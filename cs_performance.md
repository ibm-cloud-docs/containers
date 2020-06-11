---

copyright:
  years: 2014, 2020
lastupdated: "2020-06-11"

keywords: kubernetes, iks, kernel

subcollection: containers

---

{:beta: .beta}
{:codeblock: .codeblock}
{:deprecated: .deprecated}
{:download: .download}
{:external: target="_blank" .external}
{:faq: data-hd-content-type='faq'}
{:gif: data-image-type='gif'}
{:help: data-hd-content-type='help'}
{:important: .important}
{:new_window: target="_blank"}
{:note: .note}
{:pre: .pre}
{:preview: .preview}
{:screen: .screen}
{:shortdesc: .shortdesc}
{:support: data-reuse='support'}
{:table: .aria-labeledby="caption"}
{:tip: .tip}
{:troubleshoot: data-hd-content-type='troubleshoot'}
{:tsCauses: .tsCauses}
{:tsResolve: .tsResolve}
{:tsSymptoms: .tsSymptoms}



# Tuning performance
{: #kernel}

If you have specific performance optimization requirements, you can change the default settings for some cluster components in {{site.data.keyword.containerlong}}.
{: shortdesc}

If you choose to change the default settings, you are doing so at your own risk. You are responsible for running tests against any changed settings and for any potential disruptions caused by the changed settings in your environment.
{: important}

## Optimizing worker node performance
{: #worker}

If you have specific performance optimization requirements, you can change the default settings for the Linux kernel `sysctl` parameters on worker nodes.
{: shortdesc}

Worker nodes are automatically provisioned with optimized kernel performance, but you can change the default settings by applying a custom [Kubernetes `DaemonSet`](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/){: external} object to your cluster. The daemon set alters the settings for all existing worker nodes and applies the settings to any new worker nodes that are provisioned in the cluster. No pods are affected.

You must have the [**Manager** {{site.data.keyword.cloud_notm}} IAM service role](/docs/containers?topic=containers-users#platform) for all namespaces to run the sample privileged `initContainer`. After the containers for the deployments are initialized, the privileges are dropped.
{: note}

1. Save the following daemon set in a file named `worker-node-kernel-settings.yaml`. In the `spec.template.spec.initContainers` section, add the fields and values for the `sysctl` parameters that you want to tune. This example daemon set changes the default maximum number of connections that are allowed in the environment via the `net.core.somaxconn` setting and the ephemeral port range via the `net.ipv4.ip_local_port_range` setting.
    ```yaml
    apiVersion: apps/v1
    kind: DaemonSet
    metadata:
      name: kernel-optimization
      namespace: kube-system
      labels:
        tier: management
        app: kernel-optimization
    spec:
      selector:
        matchLabels:
          name: kernel-optimization
      template:
        metadata:
          labels:
            name: kernel-optimization
        spec:
          hostNetwork: true
          hostPID: true
          hostIPC: true
          initContainers:
            - command:
                - sh
                - -c
                - sysctl -w net.ipv4.ip_local_port_range="1025 65535"; sysctl -w net.core.somaxconn=32768;
              image: alpine:3.6
              imagePullPolicy: IfNotPresent
              name: sysctl
              resources: {}
              securityContext:
                privileged: true
                capabilities:
                  add:
                    - NET_ADMIN
              volumeMounts:
                - name: modifysys
                  mountPath: /sys
          containers:
            - resources:
                requests:
                  cpu: 0.01
              image: alpine:3.6
              name: sleepforever
              command: ["/bin/sh", "-c"]
              args:
                - >
                  while true; do
                    sleep 100000;
                  done
          volumes:
            - name: modifysys
              hostPath:
                path: /sys
    ```
    {: codeblock}

2. Apply the daemon set to your worker nodes. The changes are applied immediately.
    ```
    kubectl apply -f worker-node-kernel-settings.yaml
    ```
    {: pre}

<br />

To revert your worker nodes' `sysctl` parameters to the default values set by {{site.data.keyword.containerlong_notm}}:

1. Delete the daemon set. The `initContainers` that applied the custom settings are removed.
    ```
    kubectl delete ds kernel-optimization
    ```
    {: pre}

2. [Reboot all worker nodes in the cluster](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_reboot). The worker nodes come back online with the default values applied.

<br />


## Optimizing pod performance
{: #pod}

If you have specific performance workload demands, you can change the default settings for the Linux kernel `sysctl` parameters on pod network namespaces.
{: shortdesc}

To optimize kernel settings for app pods, you can insert an [`initContainer`](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/){: external} patch into the `pod/ds/rs/deployment` YAML for each deployment. The `initContainer` is added to each app deployment that is in the pod network namespace for which you want to optimize performance.

Before you begin, ensure you have the [**Manager** {{site.data.keyword.cloud_notm}} IAM service role](/docs/containers?topic=containers-users#platform) for all namespaces to run the sample privileged `initContainer`. After the containers for the deployments are initialized, the privileges are dropped.

1. Save the following `initContainer` patch in a file named `pod-patch.yaml` and add the fields and values for the `sysctl` parameters that you want to tune. This example `initContainer` changes the default maximum number of connections allowed in the environment via the `net.core.somaxconn` setting and the ephemeral port range via the `net.ipv4.ip_local_port_range` setting.
    ```yaml
    spec:
      template:
        spec:
          initContainers:
          - command:
            - sh
            - -c
            - sysctl -e -w net.core.somaxconn=32768;  sysctl -e -w net.ipv4.ip_local_port_range="1025 65535";
            image: alpine:3.6
            imagePullPolicy: IfNotPresent
            name: sysctl
            resources: {}
            securityContext:
              privileged: true
    ```
    {: codeblock}

2. Patch each of your deployments.
    ```
    kubectl patch deployment <deployment_name> --patch pod-patch.yaml
    ```
    {: pre}

3. If you changed the `net.core.somaxconn` value in the kernel settings, most apps can automatically use the updated value. However, some apps might require you to manually change the corresponding value in your app code to match the kernel value. For example, if you're tuning the performance of a pod where an NGINX app runs, you must change the value of the `backlog` field in the NGINX app code to match. For more information, see this [NGINX blog post](https://www.nginx.com/blog/tuning-nginx/){: external}.

<br />


## Adjusting cluster metrics provider resources
{: #metrics}

Your cluster's metrics provider (`metrics-server` in Kubernetes 1.12 and later) configurations are optimized for clusters with 30 or less pods per worker node. If your cluster has more pods per worker node, the metrics provider `metrics-server` container for the pod might restart frequently with an error message such as `OOMKilled`.
{: shortdesc}

The metrics provider pod also has a `nanny` container that scales the `metrics-server` container's resource requests and limits in response to the number of worker nodes in the cluster. You can change the default resources by editing the metrics provider's configmap.

Before you begin: [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

1.  Open the `metrics-server` configmap YAML.
    ```
    kubectl edit configmap metrics-server-config -n kube-system
    ```
    {: pre}

    Example output:
    ```
    apiVersion: v1
    data:
      NannyConfiguration: |-
        apiVersion: nannyconfig/v1alpha1
        kind: NannyConfiguration
    kind: ConfigMap
    metadata:
      annotations:
        armada-service: cruiser-kube-addons
        version: --
      creationTimestamp: 2018-10-09T20:15:32Z
      labels:
        addonmanager.kubernetes.io/mode: EnsureExists
        kubernetes.io/cluster-service: "true"
      name: metrics-server-config
      namespace: kube-system
      resourceVersion: "1424"
      selfLink: /api/v1/namespaces/kube-system/configmaps/metrics-server-config
      uid: 11a1aaaa-bb22-33c3-4444-5e55e555e555
    ```
    {: screen}

2.  Add the `memoryPerNode` field to the configmap in the `data.NannyConfiguration` section. The default value is set to `4Mi`.
    ```yaml
    apiVersion: v1
    data:
      NannyConfiguration: |-
        apiVersion: nannyconfig/v1alpha1
        kind: NannyConfiguration
        memoryPerNode: 5Mi
    kind: ConfigMap
    ...
    ```
    {: codeblock}

3.  Save and close the file. Your changes are applied automatically.

4.  Monitor the metrics provider pods.
  * If containers continue to be restarted due to an `OOMKilled` error message, repeat these steps and increase the `memoryPerNode` size until the pod is stable. If the containers are now stable but metrics are often not available or are incomplete, continue to the next step to tune the `cpuPerNode` setting.
  * If you see an error message similar to the following, or if the horizontal pod autoscaler is not scaling correctly, continue to the next step to tune the `cpuPerNode` setting.
    ```
    unable to get metrics for resource cpu: unable to fetch metrics from resource metrics API: the server is currently unable to handle the request (get pods.metrics.k8s.io)
    ```
    {: screen}

5. Open the `metrics-server` configmap YAML.
    ```
    kubectl edit configmap metrics-server-config -n kube-system
    ```
    {: pre}

6. Add the `cpuPerNode` field to the configmap in the `data.NannyConfiguration` section.
    ```yaml
    apiVersion: v1
    data:
      NannyConfiguration: |-
        apiVersion: nannyconfig/v1alpha1
        kind: NannyConfiguration
        cpuPerNode: 5m
    kind: ConfigMap
    ...
    ```
    {: codeblock}

7. Monitor the metrics provider pods for at least an hour. It can take several minutes for the metrics server to start collecting metrics.
  * If metrics continue to be unavailable or incomplete, repeat these steps and increase the `cpuPerNode` size until the metrics are stable. If the load on a specific worker node is very high, the metrics provider might timeout waiting for metrics from that worker node, and continue to report unknown values for that worker node. Note that due to the timing of requests relative to other processing that occur in the `metrics-server`, you might not be able to get metrics for all of your pods all of the time.

Want to tune more settings? Check out the [Kubernetes Add-on resizer configuration docs](https://github.com/kubernetes/autoscaler/tree/master/addon-resizer#addon-resizer-configuration){: external} for more ideas.
{: tip}

<br />


## Changing the Calico maximum transmission unit (MTU)
{: #calico-mtu}

Increase or decrease the Calico plug-in maximum transmission unit (MTU) to meet the network throughput requirements of your environment.
{: shortdesc}

By default, the Calico network plug-in in your {{site.data.keyword.containerlong_notm}} cluster has an MTU of 1480 bytes. For most cases, this default MTU value provides sufficient throughput for packets that are sent and received in your network workloads. Review the following cases in which you might need to modify the default Calico MTU:

* If your cluster uses bare metal worker nodes, and you use jumbo frames on the bare metal worker nodes, the jumbo frames have an MTU value in the range of 1500 to 9000. To ensure that Calico can handle this throughput, you can increase the Calico MTU to match the MTU of the jumbo frames. Note that all worker nodes in the cluster must use the same Calico MTU, so to increase the Calico MTU, all worker nodes in the cluster must be bare metal and use jumbo frames.
* If you have a VPN connection set up for your cluster, some VPN connections require a smaller Calico MTU than the default. Check with the VPN service to determine whether a smaller Calico MTU is required. 

You can change the MTU on the tunnel interface `tunl0`, which is used for pod to pod communication, and the MTU on the `caliXXXXXXXX` `veth` interface of each worker node.


1. Edit the `calico-config` configmap resource.
  ```
  kubectl edit cm calico-config -n kube-system
  ```
  {: pre}

2. In the `data` section, add a `calico_mtu_override: "<new_MTU>"` field and specify the new MTU value for Calico. Note that the quotation marks (`"`) around the new MTU value are required.

    Do not change the values of `mtu` or `veth_mtu`.
    {: important}

    ```yaml
    apiVersion: v1
    data:
      calico_backend: bird
      calico_mtu_override: "1600"
      cni_network_config: |-
        {
          "name": "k8s-pod-network",
          "cniVersion": "0.3.1",
          "plugins": [
            {
              "type": "calico",
              "log_level": "info",
              "etcd_endpoints": "__ETCD_ENDPOINTS__",
              "etcd_key_file": "__ETCD_KEY_FILE__",
              "etcd_cert_file": "__ETCD_CERT_FILE__",
              "etcd_ca_cert_file": "__ETCD_CA_CERT_FILE__",
              "mtu": __CNI_MTU__,
              "ipam": {
                  "type": "calico-ipam"
              },
              "container_settings": {
                  "allow_ip_forwarding": true
              },
              "policy": {
                  "type": "k8s"
              },
              "kubernetes": {
                  "kubeconfig": "__KUBECONFIG_FILEPATH__"
              }
            },
            {
              "type": "portmap",
              "snat": true,
              "capabilities": {"portMappings": true}
            }
          ]
        }
      etcd_ca: /calico-secrets/etcd-ca
      etcd_cert: /calico-secrets/etcd-cert
      etcd_endpoints: https://172.20.0.1:2041
      etcd_key: /calico-secrets/etcd-key
      typha_service_name: none
      veth_mtu: "1480"
    kind: ConfigMap
    ...
    ```
    {: codeblock}
    
3. Apply the MTU changes to your cluster master by refreshing the master API server. It might take several minutes for the master to refresh.
  ```
  ibmcloud ks cluster master refresh --cluster <cluster_name_or_ID>
  ```
  {: pre}

4. Verify that the master refresh is completed. When the refresh is complete, the **Master Status** changes to `Ready`.
  ```
  ibmcloud ks cluster get --cluster <cluster_name_or_ID>
  ```
  {: pre}

5. In the `data` section of the output, verify that the `veth_mtu` field shows the new MTU value for Calico that you specified in step 2.
  ```
  kubectl get cm -n kube-system calico-config -o yaml
  ```
  {: pre}

  Example output:
  ```yaml
  apiVersion: v1
  data:
    ...
    etcd_ca: /calico-secrets/etcd-ca
    etcd_cert: /calico-secrets/etcd-cert
    etcd_endpoints: https://172.20.0.1:2041
    etcd_key: /calico-secrets/etcd-key
    typha_service_name: none
    veth_mtu: "1600"
  kind: ConfigMap
  ...
  ```
  {: screen}

6. Apply the MTU changes to your worker nodes by [rebooting all worker nodes in your cluster](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_reboot).

<br />


## Disabling the portmap plug-in
{: #calico-portmap}

The `portmap` plug-in for the Calico container network interface (CNI) enables you to use a `hostPort` to expose your app pods on a specific port on the worker node. Prevent iptables performance issues by removing the portmap plug-in from your cluster's Calico CNI configuration.
{: shortdesc}

When you have a large number of services in your cluster, such as more than 500 services, or a large number of ports on services, such as more than 50 ports per service for 10 or more services, a large number of iptables rules are generated for the Calico and Kubernetes network policies for these services. A large number of iptables rules can lead to performance issues for the portmap plug-in, and might prevent future updates of iptables rules or cause the `calico-node` container to restart when no lock is received to make iptables rules updates within a specified time. To prevent these performance issues, you can disable the portmap plug-in by removing it from your cluster's Calico CNI configuration.

If you must use `hostPorts`, do not disable the portmap plug-in.
{: note}

To disable the portmap plug-in:

1. Edit the `calico-config` configmap resource.
  ```
  kubectl edit cm calico-config -n kube-system
  ```
  {: pre}

2. In the `data.cni_network_config.plugins` section after the `kubernetes` plug-in, remove the `portmap` plug-in section. After you remove the `portmap` section, the configuration looks like the following:
  ```yaml
  apiVersion: v1
  data:
    calico_backend: bird
    cni_network_config: |-
      {
        "name": "k8s-pod-network",
        "cniVersion": "0.3.1",
        "plugins": [
          {
            "type": "calico",
            "log_level": "info",
            "etcd_endpoints": "__ETCD_ENDPOINTS__",
            "etcd_key_file": "__ETCD_KEY_FILE__",
            "etcd_cert_file": "__ETCD_CERT_FILE__",
            "etcd_ca_cert_file": "__ETCD_CA_CERT_FILE__",
            "mtu": __CNI_MTU__,
            "ipam": {
                "type": "calico-ipam"
            },
            "container_settings": {
                "allow_ip_forwarding": true
            },
            "policy": {
                "type": "k8s"
            },
            "kubernetes": {
                "kubeconfig": "__KUBECONFIG_FILEPATH__"
            }
          }
        ]
      }
    etcd_ca: /calico-secrets/etcd-ca
    ...
  ```
  {: codeblock}

3. Apply the change to your cluster by restarting all `calico-node` pods.
    ```
    kubectl rollout restart daemonset -n kube-system calico-node
    ```
    {: pre}

