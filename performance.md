---

copyright: 
  years: 2014, 2021
lastupdated: "2021-10-06"

keywords: kubernetes, iks, kernel

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}



# Tuning performance
{: #kernel}

If you have specific performance optimization requirements, you can change the default settings for some cluster components in {{site.data.keyword.containerlong}}.
{: shortdesc}

If you choose to change the default settings, you are doing so at your own risk. You are responsible for running tests against any changed settings and for any potential disruptions caused by the changed settings in your environment.
{: important}

## Default worker node settings
{: #worker-default}

By default, your worker nodes have the operating system and compute hardware of the [worker node flavor](/docs/containers?topic=containers-planning_worker_nodes) that you choose when you create the worker pool.
{: shortdesc}

### Customizing the operating system
{: #worker-default-os}

The following operating systems are available for worker nodes: **Ubuntu 18.04 x86_64, 16.04 x86_64 (deprecated)**. Your cluster cannot mix operating systems or use different operating systems.
{: shortdesc}

To optimize your worker nodes, consider the following information.
* **Image and version updates**: Worker node updates, such as security patches to the image or Kubernetes versions, are provided by IBM for you. However, you choose when to apply the updates to the worker nodes. For more information, see [Updating clusters, worker nodes, and cluster components](/docs/containers?topic=containers-update).
* **Temporary modifications**: If you log in to a pod or use some other process to modify a worker node setting, the modifications are temporary. Worker node lifecycle operations, such as autorecovery, reloading, updating, or replacing a worker node, change any modifications back to the default settings.
* **Persistent modifications**: For modifications to persist across worker node lifecycle operations, create a daemon set that uses an init container. For more information, see [Modifying default worker node settings to optimize performance](#worker).

    Modifications to the operating system are not supported. If you modify the default settings, you are responsible for debugging and resolving the issues that might occur.
    {: important}

### Hardware changes
{: #worker-default-hw}

To change the compute hardware, such as the CPU and memory per worker node, choose among the following options.
* [Create a worker pool](/docs/containers?topic=containers-add_workers). The instructions vary depending on the type of infrastructure for the cluster, such as classic, VPC, or gateway clusters.
* [Update the flavor](/docs/containers?topic=containers-update#machine_type) in your cluster by creating a worker pool and removing the previous worker pool.

## Modifying default worker node settings to optimize performance
{: #worker}

If you have specific performance optimization requirements, you can change the default settings for the Linux kernel `sysctl` parameters on worker nodes.
{: shortdesc}

Worker nodes are automatically provisioned with optimized kernel performance, but you can change the default settings by applying a custom [Kubernetes `DaemonSet`](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/){: external} with an [`initContainer`](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/){: external} to your cluster. The daemon set modifies the settings for all existing worker nodes and applies the settings to any new worker nodes that are provisioned in the cluster. The init container makes sure that these modifications occur before other pods are scheduled on the worker node. No pods are affected.

You must have the [**Manager** {{site.data.keyword.cloud_notm}} IAM service access role](/docs/containers?topic=containers-users#checking-perms) for all namespaces to run the sample privileged `initContainer`. After the containers for the deployments are initialized, the privileges are dropped.
{: note}

Before you begin: [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

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
    ```sh
    kubectl apply -f worker-node-kernel-settings.yaml
    ```
    {: pre}



To revert your worker nodes' `sysctl` parameters to the default values set by {{site.data.keyword.containerlong_notm}}:

1. Delete the daemon set. The `initContainers` that applied the custom settings are removed.
    ```sh
    kubectl delete ds kernel-optimization
    ```
    {: pre}

2. [Reboot all worker nodes in the cluster](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_reboot). The worker nodes come back online with the default values applied.





## Optimizing pod performance
{: #pod}

If you have specific performance workload demands, you can change the default settings for the Linux kernel `sysctl` parameters on pod network namespaces.
{: shortdesc}

To optimize kernel settings for app pods, you can insert an [`initContainer`](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/){: external} patch into the `pod/ds/rs/deployment` YAML for each deployment. The `initContainer` is added to each app deployment that is in the pod network namespace for which you want to optimize performance.

Before you begin, ensure you have the [**Manager** {{site.data.keyword.cloud_notm}} IAM service access role](/docs/containers?topic=containers-users#checking-perms) for all namespaces to run the sample privileged `initContainer`. After the containers for the deployments are initialized, the privileges are dropped.

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
    ```sh
    kubectl patch deployment <deployment_name> --patch pod-patch.yaml
    ```
    {: pre}

3. If you changed the `net.core.somaxconn` value in the kernel settings, most apps can automatically use the updated value. However, some apps might require you to manually change the corresponding value in your app code to match the kernel value. For example, if you're tuning the performance of a pod where an NGINX app runs, you must change the value of the `backlog` field in the NGINX app code to match. For more information, see this [NGINX blog post](https://www.nginx.com/blog/tuning-nginx/){: external}.



## Adjusting cluster metrics provider resources
{: #metrics}

Your cluster's metrics provider configurations are optimized for clusters with 30 or less pods per worker node. If your cluster has more pods per worker node, the metrics provider `metrics-server` container for the pod might restart frequently with an error message such as `OOMKilled`.
{: shortdesc}

The metrics provider pod also has a `nanny` container that scales the `metrics-server` container's resource requests and limits in response to the number of worker nodes in the cluster. You can change the default resources by editing the metrics provider's configmap.

Before you begin: [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

1. Open the `metrics-server` configmap YAML.
    ```sh
    kubectl edit configmap metrics-server-config -n kube-system
    ```
    {: pre}

    Example output

    ```yaml
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

2. Add the `memoryPerNode` field to the configmap in the `data.NannyConfiguration` section. The default value is set to `4Mi`.
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

3. Save and close the file. Your changes are applied automatically.

4. Monitor the metrics provider pods.
    * If containers continue to be restarted due to an `OOMKilled` error message, repeat these steps and increase the `memoryPerNode` size until the pod is stable. If the containers are now stable but metrics are often not available or are incomplete, continue to the next step to tune the `cpuPerNode` setting.
    * If you see an error message similar to the following, or if the horizontal pod autoscaler is not scaling correctly, continue to the next step to tune the `cpuPerNode` setting.
    ```
    unable to get metrics for resource cpu: unable to fetch metrics from resource metrics API: the server is currently unable to handle the request (get pods.metrics.k8s.io)
    ```
    {: screen}

5. Open the `metrics-server` configmap YAML.
    ```sh
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



## Enabling huge pages
{: #huge-pages}

You can enable the [Kubernetes `HugePages` scheduling](https://kubernetes.io/docs/tasks/manage-hugepages/scheduling-hugepages/){: external} in clusters that run Kubernetes version 1.19 or later. The only supported page size is 2 MB per page, which is the default size of the Kubernetes feature gate.
{: shortdesc}

Huge pages scheduling is a beta feature in {{site.data.keyword.containerlong_notm}} and is subject to change.
{: beta}

By default, the CPU of your worker nodes allocates RAM in chunks, or pages, of 4 KB. When your app requires more RAM, the system must continue to look up more pages, which can slow down processing. With huge pages, you can increase the page size to 2 MB to increase performance for your RAM-intensive apps like databases for artificial intelligence (AI), internet of things (IoT), or machine learning workloads. For more information about huge pages, see [the Linux kernel documentation](https://www.kernel.org/doc/Documentation/vm/hugetlbpage.txt){: external}.

You can reboot the worker node and the huge pages configuration persists. However, the huge pages configuration does **not** persist across any other worker node life cycle operations. You must repeat the enablement steps each time that you update, reload, replace, or add worker nodes.
{: important}

**Supported infrastructure providers and required permissions**:
* ![Classic infrastructure provider icon.](images/icon-classic-2.svg) Classic
* ![VPC infrastructure provider icon.](images/icon-vpc-2.svg) VPC
* **Operator** platform access role and **Manager** service access role for the cluster in {{site.data.keyword.cloud_notm}} IAM

Before you begin: [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

1. Create a `hugepages-ds.yaml` configuration file to enable huge pages. The following sample YAML uses a daemon set to run the pod on every worker node in your cluster. You can set the allocation of huge pages that are available on the worker node by using the `vm.nr_hugepages` parameter. This example allocates 512 pages at 2 MB per page, for 1 GB of total RAM allocated exclusively for huge pages.

    Want to enable huge pages only for certain worker nodes, such as a worker pool that you use for RAM-intensive apps? [Label](/docs/containers?topic=containers-add_workers#worker_pool_labels) and [taint](/docs/containers?topic=containers-kubernetes-service-cli#worker_pool_taint) your worker pool, and then add [affinity rules](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/){: external} to the daemon set so that the pods are deployed only to the worker nodes in the worker pool that you specify.
    {: tip}

    ```yaml
    apiVersion: apps/v1
    kind: DaemonSet
    metadata:
      name: hugepages-enablement
      namespace: kube-system
      labels:
        tier: management
        app: hugepages-enablement
    spec:
      selector:
        matchLabels:
          name: hugepages-enablement
      template:
        metadata:
          labels:
            name: hugepages-enablement
        spec:
          hostPID: true
          initContainers:
            - command:
                - sh
                - -c
                # Customize allocated Hugepages by providing the value
                - "echo vm.nr_hugepages=512 > /etc/sysctl.d/90-hugepages.conf"
              image: alpine:3.6
              imagePullPolicy: IfNotPresent
              name: sysctl
              resources: {}
              securityContext:
                privileged: true
              volumeMounts:
                - name: modify-sysctld
                  mountPath: /etc/sysctl.d
          containers:
            - resources:
                requests:
                  cpu: 0.01
              image: alpine:3.6
              # once the init container completes, keep the pod running for worker node changes
              name: sleepforever
              command: ["/bin/sh", "-c"]
              args:
                - >
                  while true; do
                      sleep 100000;
                  done
          volumes:
            - name: modify-sysctld
              hostPath:
                path: /etc/sysctl.d
    ```
    {: codeblock}

2. Apply the file that you previously created.
    ```sh
    kubectl apply -f hugepages-ds.yaml
    ```
    {: pre}

3. Verify that the pods are **Running**.
    ```sh
    kubectl get pods
    ```
    {: pre}

4. Restart the kubelet that runs on each worker node by rebooting the worker nodes. Do **not** reload the worker node to restart the kubelet. Reloading the worker node before the kubelet picks up on the huge pages enablement causes the enablement to fail.
    1. List the worker nodes in your cluster.
        ```sh
        ibmcloud ks worker ls -c <cluster_name_or_ID>
        ```
        {: pre}

    2. Reboot the worker nodes. You can reboot multiple worker nodes by including multiple `-w` flags, but make sure to leave enough worker nodes running at the same time for your apps to avoid an outage.
        ```sh
        ibmcloud ks worker reboot -c <cluster_name_or_ID> -w <worker1_ID> -w <worker2_ID>
        ```
        {: pre}

5. Create a `hugepages-test.yaml` test pod that mounts huge pages as a volume and uses resource limits and requests to set how much of the huge pages resources that the pod uses. **Note**: If you used labels, taints, and affinity rules to enable huge pages on select worker nodes only, include these same rules in your test pod.
    ```yaml
    apiVersion: v1
    kind: Pod
    metadata:
      name: hugepages-example
    spec:
      containers:
      - name: hugepages-example
        image: fedora:34
        command:
        - sleep
        - inf
        volumeMounts:
        - mountPath: /hugepages-2Mi
          name: hugepage-2mi
        resources:
          limits:
            hugepages-2Mi: 100Mi
            memory: 100Mi
          requests:
            memory: 100Mi
      volumes:
      - name: hugepage-2mi
        emptyDir:
          medium: HugePages-2Mi
    ```
    {: codeblock}

6. Apply the pod file that you previously created.
    ```sh
    kubectl apply -f hugepages-pod.yaml
    ```
    {: pre}

7. Verify that your pod uses the huge pages resources.
    1. Check that your pod is **Running**. The pod does not run if no worker nodes with huge pages are available.
        ```sh
        kubectl get pods
        ```
        {: pre}

    2. Log in to the pod.
        ```sh
        kubectl exec -it <pod> /bin/sh
        ```
        {: pre}

    3. Verify that your pod can view the sizes of the huge pages.
        ```
        ls /sys/kernel/mm/hugepages
        ```
        {: pre}

        Example output
        ```
        hugepages-1048576kB  hugepages-2048kB
        ```
        {: screen}

8. Optional: Remove the enablement daemon set. Keep in mind that you must re-create the daemon set if you need to update, reload, replace, or add worker nodes with huge pages later.
    ```sh
    kubectl -n kube-system delete daemonset hugepages-enablement
    ```
    {: pre}

9. Repeat these steps whenever you update, reload, replace, or add worker nodes.

To troubleshoot worker nodes with huge pages, you can only reboot the worker node. The huge pages configuration does not persist across any other worker node life cycle operation, such as updating, reloading, replacing, or adding worker nodes. To remove the huge pages configuration from your cluster, you can update, reload, or replace all the worker nodes.





## Changing the Calico maximum transmission unit (MTU)
{: #calico-mtu}

Increase or decrease the Calico plug-in maximum transmission unit (MTU) to meet the network throughput requirements of your environment.
{: shortdesc}

By default, the Calico network plug-in in your {{site.data.keyword.containerlong_notm}} cluster has an MTU of 1480 bytes. For most cases, this default MTU value provides sufficient throughput for packets that are sent and received in your network workloads. Review the following cases in which you might need to modify the default Calico MTU:

* If your cluster uses bare metal worker nodes, and you use jumbo frames on the bare metal worker nodes, the jumbo frames have an MTU value in the range of 1500 to 9000. To ensure that your cluster's pod network can use this higher MTU value, you can increase the Calico MTU to 20 bytes lower than the jumbo frame MTU. This 20 byte difference allows space for packet header on encapsulated packets. For example, if your worker nodes' jumbo frames are set to 9000, you can set the Calico MTU to 8980. Note that all worker nodes in the cluster must use the same Calico MTU, so to increase the Calico MTU, all worker nodes in the cluster must be bare metal and use jumbo frames.
* If you have a VPN connection set up for your cluster, some VPN connections require a smaller Calico MTU than the default. Check with the VPN service provider to determine whether a smaller Calico MTU is required.
* If your cluster's worker nodes exist on different subnets, increasing the MTU value for the worker nodes and for the Calico MTU can allow pods to use the full bandwidth capability of the worker nodes.

**Before you begin**: If your bare metal worker nodes still run the default MTU value, increase the MTU value for your worker nodes first before you increase the MTU value for the Calico plug-in. For example, you can apply the following daemon set to change the MTU for your worker nodes's jumbo frames to 9000 bytes.

```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: jumbo-apply
  namespace: kube-system
  labels:
    tier: management
    app: jumbo-apply
spec:
  selector:
    matchLabels:
      name: jumbo-apply
  template:
    metadata:
      labels:
        name: jumbo-apply
    spec:
      hostNetwork: true
      hostPID: true
      hostIPC: true
      tolerations:
      - operator: Exists
      initContainers:
        - command:
            - sh
            - -c
            - ip link set dev bond0 mtu 9000;ip link set dev bond1 mtu 9000;
          image: alpine:3.6
          imagePullPolicy: IfNotPresent
          name: iplink
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



1. Edit the `calico-config` configmap resource.
    ```sh
    kubectl edit cm calico-config -n kube-system
    ```
    {: pre}

2. In the `data` section, add a `calico_mtu_override: "<new_MTU>"` field and specify the new MTU value for Calico. Note that the quotation marks (`"`) around the new MTU value are required.

    Do not change the values of `mtu` or `veth_mtu`. Changing any other settings besides the `calico_mtu_override` field for the Calico plug-in in this configmap is not supported.
    {: important}

    ```yaml
    apiVersion: v1
    data:
      calico_backend: bird
      calico_mtu_override: "8980"
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
    ```sh
    ibmcloud ks cluster master refresh --cluster <cluster_name_or_ID>
    ```
    {: pre}

4. Verify that the master refresh is completed. When the refresh is complete, the **Master Status** changes to `Ready`.
    ```sh
    ibmcloud ks cluster get --cluster <cluster_name_or_ID>
    ```
    {: pre}

5. In the `data` section of the output, verify that the `veth_mtu` field shows the new MTU value for Calico that you specified in step 2.
    ```sh
    kubectl get cm -n kube-system calico-config -o yaml
    ```
    {: pre}

    Example output

    ```yaml
    apiVersion: v1
    data:
      ...
      etcd_ca: /calico-secrets/etcd-ca
      etcd_cert: /calico-secrets/etcd-cert
      etcd_endpoints: https://172.20.0.1:2041
      etcd_key: /calico-secrets/etcd-key
      typha_service_name: none
      veth_mtu: "8980"
      kind: ConfigMap
      ...
    ```
    {: screen}

6. Apply the MTU changes to your worker nodes by [rebooting all worker nodes in your cluster](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_reboot).



## Disabling the port map plug-in
{: #calico-portmap}

The `portmap` plug-in for the Calico container network interface (CNI) enables you to use a `hostPort` to expose your app pods on a specific port on the worker node. Prevent iptables performance issues by removing the port map plug-in from your cluster's Calico CNI configuration.
{: shortdesc}

When you have a large number of services in your cluster, such as more than 500 services, or a large number of ports on services, such as more than 50 ports per service for 10 or more services, a large number of iptables rules are generated for the Calico and Kubernetes network policies for these services. A large number of iptables rules can lead to performance issues for the port map plug-in, and might prevent future updates of iptables rules or cause the `calico-node` container to restart when no lock is received to make iptables rules updates within a specified time. To prevent these performance issues, you can disable the port map plug-in by removing it from your cluster's Calico CNI configuration.

If you must use `hostPorts`, do not disable the port map plug-in.
{: note}



To disable the port map plug-in:

1. Edit the `calico-config` configmap resource.
    ```sh
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

    Changing any other settings for the Calico plug-in in this configmap is not supported.
    {: important}

3. Apply the change to your cluster by restarting all `calico-node` pods.
    ```sh
    kubectl rollout restart daemonset -n kube-system calico-node
    ```
    {: pre}




