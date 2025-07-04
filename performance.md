---

copyright: 
  years: 2014, 2025
lastupdated: "2025-05-29"


keywords: containers, {{site.data.keyword.containerlong_notm}}, kubernetes, kernel, performance

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

By default, your worker nodes have the operating system and compute hardware of the worker node flavor that you choose when you create the worker pool.
{: shortdesc}

### Customizing the operating system
{: #worker-default-os}

You can find a list of supported operating systems by cluster version in the [Kubernetes version information](/docs/containers?topic=containers-cs_versions). Your cluster can't mix operating systems or use different operating systems.
{: shortdesc}

To optimize your worker nodes, consider the following information.
* **Image and version updates**: Worker node updates, such as security patches to the image or Kubernetes versions, are provided by IBM for you. However, you choose when to apply the updates to the worker nodes. For more information, see [Updating clusters, worker nodes, and cluster components](/docs/containers?topic=containers-update).
* **Temporary modifications**: If you log in to a pod or use some other process to modify a worker node setting, the modifications are temporary. Worker node lifecycle operations, such as autorecovery, reloading, updating, or replacing a worker node, change any modifications back to the default settings.
* **Persistent modifications**: For modifications to persist across worker node lifecycle operations, create a daemon set that uses an `init` container. For more information, see [Modifying default worker node settings to optimize performance](#worker-kernel-ds).

Modifications to the operating system are not supported. If you modify the default settings, you are responsible for debugging and resolving the issues that might occur.
{: important}

### Hardware changes
{: #worker-default-hw}

To change the compute hardware, such as the CPU and memory per worker node, choose among the following options.
* Create a worker pool. The instructions vary depending on the type of infrastructure for the cluster, such as classic, VPC, or {{site.data.keyword.satelliteshort}}. For more information, see [Adding worker nodes to Classic clusters](/docs/containers?topic=containers-add-workers-classic) or [Adding worker nodes to VPC clusters](/docs/containers?topic=containers-add-workers-vpc). 
* [Update the flavor](/docs/containers?topic=containers-update#machine_type) in your cluster by creating a worker pool and removing the previous worker pool.




## Modifying worker node kernel settings to optimize performance
{: #worker-kernel-ds}

Cluster worker nodes are configured for a level of stability, optimization, and performance that is expected to meet the needs of most workloads. Usually, it is not recommended to change your worker node kernel settings, as such changes can create unusual and unintended issues. However, if your workload has highly unique performance optimization requirements that necessitate changes to your kernel settings, a custom Kubernetes daemonset can be applied to change the kernel configuration. Understand that these changes can have significant negative consequences and that you implement changes to the kernel settings configuration **at your own risk**. 

If you change the configuration of your kernel settings, make sure you document and save the exact changes that you make. If you open a support ticket for any issues related to the cluster, you must specify these changes. These configuration changes might be responsible for the issue, and you might be asked to revert the changes as part of the issue investigation. In this case, you are responsible for reverting any kernel configuration changes you implement. 
{: important}

Changing the default kernel settings can have negative effects on your cluster. Make these changes at your own risk. 
{: important}

You can change the default kernel settings by applying a custom [Kubernetes `DaemonSet`](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/){: external} with an [`init` Container](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/){: external} to your cluster. The daemon set modifies the settings for all existing worker nodes and applies the settings to any new worker nodes that are provisioned in the cluster. The `init` container makes sure that these modifications occur before other pods are scheduled on the worker node. No pods are affected.

You must have the [**Manager** {{site.data.keyword.cloud_notm}} IAM service access role](/docs/containers?topic=containers-iam-platform-access-roles) for all namespaces to run the sample privileged `initContainer`. After the containers for the deployments are initialized, the privileges are dropped.
{: note}

Before you begin: [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-access_cluster)

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
                - sysctl -w net.ipv4.tcp_syn_retries="5"; sysctl -w net.ipv4.tcp_fin_timeout="15";
              image: us.icr.io/armada-master/network-alpine:latest
              imagePullPolicy: Always 
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
              image: us.icr.io/armada-master/network-alpine:latest
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

1. Apply the daemon set to your worker nodes. The changes are applied immediately.
    ```sh
    kubectl apply -f worker-node-kernel-settings.yaml
    ```
    {: pre}

To revert your worker nodes `sysctl` parameters to the default values, follow these steps.

1. Delete the daemon set. The `initContainers` that applied the custom settings are removed.
    ```sh
    kubectl delete ds kernel-optimization
    ```
    {: pre}

1. [Reboot all worker nodes in the cluster](/docs/containers?topic=containers-kubernetes-service-cli#cs_worker_reboot). The worker nodes come back online with the default values applied.




## Optimizing pod performance
{: #pod}

If you have specific performance workload demands, you can change the default settings for the Linux kernel `sysctl` parameters on pod network namespaces.
{: shortdesc}

To optimize kernel settings for app pods, you can insert an [`initContainer`](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/){: external} patch into the `pod/ds/rs/deployment` YAML for each deployment. The `initContainer` is added to each app deployment that is in the pod network namespace for which you want to optimize performance.

Before you begin, ensure you have the [**Manager** {{site.data.keyword.cloud_notm}} IAM service access role](/docs/containers?topic=containers-iam-platform-access-roles) for all namespaces to run the sample privileged `initContainer`. After the containers for the deployments are initialized, the privileges are dropped.

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

3. If you changed the `net.core.somaxconn` value in the kernel settings, most apps can automatically use the updated value. However, some apps might require you to manually change the corresponding value in your app code to match the kernel value. For example, if you're tuning the performance of a pod where an NGINX app runs, you must change the value of the `backlog` field in the NGINX app code to match. For more information, see this [NGINX blog post](https://www.f5.com/company/blog/nginx/tuning-nginx){: external}.




## Optimizing network keepalive `sysctl` settings
{: #keepalive-iks}

If a pod has long running TCP connections that are occasionally disconnected when they are idle for a period of time, it might help to change the `sysctl` keepalive settings for the pod. 
{: shortdesc}



There currently isn't a way to set these `sysctl` keepalive settings on all pods by default in a cluster. The best way to modify the settings on all pods is to use a privileged `initContainer`. Review the following example of how to set up an `initContainer` for a deployment in a `test-ns` namespace.



Deploy the following example `initContainer`. Remember to change the `containers:` section to your own application containers. The `initContainer` then sets the `sysctl` settings for all the regular containers in the pod because they all share the same network namespace.

    ```sh
    kubectl apply -f - << EOF
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: test-sysctl
      namespace: test-ns
      labels:
        run: test-sysctl
    spec:
      replicas: 2
      selector:
        matchLabels:
          run: test-sysctl
      template:
        metadata:
          labels:
            run: test-sysctl
        spec:
          initContainers:
          - command:
            - sh
            - -c
            - sysctl -e -w net.ipv4.tcp_keepalive_time=40; sysctl -e -w net.ipv4.tcp_keepalive_intvl=15; sysctl -e -w net.ipv4.tcp_keepalive_probes=6;
            image: us.icr.io/armada-master/alpine:latest
            imagePullPolicy: IfNotPresent
            name: sysctl-init
            resources: {}
            securityContext:
              privileged: true
          containers:
          - name: test-sysctl
            image: us.icr.io/armada-master/alpine:latest
            command: ["sleep", "2592000"]
      EOF
    ```
    {: pre}
      


## Adjusting cluster metrics provider resources
{: #metrics}

Your cluster has a metrics service provided by the `metrics-server` deployment in the `kube-system` namespace. The `metrics-server` resource requests are based on the number of nodes in the cluster and are optimized for clusters with 30 or less pods per worker node. The metric service matches the memory and CPU limits of the resource requests.
{: shortdesc}

The metrics-service containers can be "out-of-memory killed" if the memory requests are too low. They might respond very slowly or fail liveness and readiness probes, due to CPU throttling if the CPU requests are too low.
{: note}

Memory use is driven by the number of pods in the cluster. CPU use is driven by the number of requests for metrics (HPAs, `kubectl top nodes / pods`, and so on) and by API discovery requests. The `metrics-server` provides a Kubernetes API, so that clients such as `kubectl` that use API discovery place some load on the `metrics-server` even if they don't use metrics.

The following symptoms might indicate a need to adjust the `metrics-server` resources:

- The `metrics-server` is restarting frequently.

- Deleting a namespace results in the namespace that is stuck in a `Terminating` state and `kubectl describe namespace` includes a condition reporting a metrics API discovery error.

- `kubectl top pods`, `kubectl top nodes`, other `kubectl` commands, or applications that use the Kubernetes API to log Kubernetes errors such as:

```sh
The server is currently unable to handle the request (get pods.metrics.k8s.io)
```
{: screen}

```sh
Discovery failed for some groups, 1 failing: unable to retrieve the complete list of server APIs: metrics.k8s.io/v1beta1: the server is currently unable to handle the request
```
{: screen}

- HorizontalPodAutoscalers (HPAs) do not scale deployments.

- Running `kubectl get apiservices v1beta1.metrics.k8s.io` results in a status like:

```sh
NAME                     SERVICE                      AVAILABLE                      AGE
v1beta1.metrics.k8s.io   kube-system/metrics-server   False (FailedDiscoveryCheck)   139d
```
{: screen}
    
### Modify the `metrics-server-config` config map
{: #metrics-server-config}

Both CPU and memory have tunable "base" and "per node" settings used to compute a total request.
{: shortdesc}

- `baseCPU`
- `cpuPerNode`
- `baseMemory`
- `memoryPerNode`

Where:
```sh
cpuRequest = baseCPU + cpuPerNode * number_of_nodes
memoryRequest = baseMemory + memoryPerNode * number_of_nodes
```    
{: pre}

The number of nodes in these calculations comes from a set of "bucket sizes" and has a minimum size of 16 nodes.
{: note}

CPU is requested in cores, with value such as `1` or fractional values such as `100m` (100 millicores).

Memory is requested in bytes with an optional suffix of:
- base 2 (1Ki = 1024): `Ki` (kilobytes), `Mi` (megabytes), `Gi` (gigabytes).
- metric (1k = 1000): `k`, `M`, `G`.

If the number of nodes in a cluster is expected to grow (or just change) over time, you might want to adjust the "per node" setting. If the number of nodes is static, adjust the "base" setting. In the end, the total CPU and memory values are set in the `metrics-server` deployment resource requests.

You can change the default resources by editing the metrics provider's configmap. Do not modify the resource requests or limits directly in the `metrics-server` deployment, the values are overwritten by the `metrics-server-nanny` container.

The default `metrics-server-config` configmap is:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  labels:
    addonmanager.kubernetes.io/mode: EnsureExists
    kubernetes.io/cluster-service: "true"
  name: metrics-server-config
  namespace: kube-system
data:
  NannyConfiguration: |-
    apiVersion: nannyconfig/v1alpha1
    kind: NannyConfiguration
```
{: screen}

This example shows a ConfigMap with all values defined.

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  labels:
    addonmanager.kubernetes.io/mode: EnsureExists
    kubernetes.io/cluster-service: "true"
  name: metrics-server-config
  namespace: kube-system
data:
  NannyConfiguration: |-
    apiVersion: nannyconfig/v1alpha1
    kind: NannyConfiguration
    baseCPU: 200m
    cpuPerNode: 1m
    baseMemory: 40Mi
    memoryPerNode: 6Mi
```
{: screen}

The default values are:

```yaml
baseCPU: 200m
cpuPerNode: 1m
baseMemory: 40Mi
memoryPerNode: 6Mi
```
{: screen}

#### Edit the configmap
{: #edit-configmap}

You can edit the ConfigMap with the `kubectl edit` command:
```sh
kubectl edit cm metrics-server-config -n kube-system
```
{: pre}

Add or edit the fields you want to change, then save the ConfigMap and exit the editor.

The {{site.data.keyword.cloud_notm}}-provided `metrics-server` monitors the ConfigMap for changes and updates the deployment resource requests automatically. It can take up to 10 minutes for the `metrics-server` to detect the change and roll out a new set of pods based on the updated settings.

#### Restore the default settings
{: #restore-default}

To restore the `metrics-server` to the default settings, delete the config map. It is recreated within a few minutes.
```sh
kubectl delete cm metrics-server-config -n kube-system
```
{: pre}

### Determining which resources to tune
{: #determine-resources}

Use the `kubectl describe pod` command to get the pod definition, state information, and recent events:
```sh
kubectl get pod -n kube-system -l k8s-app=metrics-server
NAME                             READY   STATUS    RESTARTS   AGE
metrics-server-9fb4947d6-s6sgl   3/3     Running   0          2d4h
kubectl describe pod -n kube-system metrics-server-9fb4947d6-s6sgl
```
{: pre}

Example output
```sh
Containers:
  metrics-server:
    Container ID:  containerd://fe3d07c9a2541242d36da8097de3896f740c1363f6d2bfd01b8d96a641192b1b
    Image:         registry.ng.bluemix.net/armada-master/metrics-server:v0.4.4
    Image ID:      registry.ng.bluemix.net/armada-master/metrics-server@sha256:c2c63900d0e080c2413b5f35c5a59b5ed3b809099355728cf47527aa3f35477c
    Port:          4443/TCP
    Host Port:     0/TCP
    Command:
      /metrics-server
      --metric-resolution=45s
      --secure-port=4443
      --tls-cert-file=/etc/metrics-server-certs/tls.crt
      --tls-private-key-file=/etc/metrics-server-certs/tls.key
    State:          Running
      Started:      Fri, 10 Sep 2021 17:31:39 +0000
    Last State:     Terminated
      Reason:       OOMKilled
      Exit Code:    137
      Started:      Fri, 10 Sep 2021 05:59:51 +0000
      Finished:     Fri, 10 Sep 2021 17:31:37 +0000
    Ready:          True
    Restart Count:  36
```
{: screen}

If the `Last State` shows a `Reason` of `OOMKilled`, increase the memory requests in the `metrics-server-config` ConfigMap in 100Mi increments or larger until the metrics-server is stable and runs for several hours or longer without being `OOMkilled`.
```sh
Last State:     Terminated
  Reason:       OOMKilled
  Exit Code:    137
```
{: screen}

If the `Last state` shows a shows a `Reason` of `Error` and Events such as those in the following example, increase the CPU requests in the `metrics-server-config` ConfigMap in 100m increments or larger until the metrics-server is stable and runs for several hours or longer without being killed due to probe timeouts.
```sh
Last State:     Terminated
  Reason: Error
  Exit Code: 137
```
{: screen}

```sh
Events:
Warning Unhealthy 46m (x5 over 80m) kubelet Liveness probe failed: Get "https://198.18.68.236:4443/livez": context deadline exceeded (Client.Timeout exceeded while awaiting headers)
Warning Unhealthy 26m (x65 over 89m) kubelet Liveness probe failed: Get "https://198.18.68.236:4443/livez": net/http: TLS handshake timeout
Warning Unhealthy 21m (x10 over 76m) kubelet Readiness probe failed: Get "https://198.18.68.236:4443/readyz": net/http: request canceled (Client.Timeout exceeded while awaiting headers)
Warning Unhealthy 115s (x93 over 90m) kubelet Readiness probe failed: Get "https://198.18.68.236:4443/readyz": net/http: TLS handshake timeout
```
{: screen}

You might need to repeat this process a few times to reach a stable configuration, by first adjusting memory requests, and then adjusting CPU requests.



## Enabling huge pages
{: #huge-pages}

[Classic infrastructure]{: tag-classic-inf} [Virtual Private Cloud]{: tag-vpc}

You can enable the [Kubernetes `HugePages` scheduling](https://kubernetes.io/docs/tasks/manage-hugepages/scheduling-hugepages/){: external} in clusters that run Kubernetes version 1.19 or later. The only supported page size is 2 MB per page, which is the default size of the Kubernetes feature gate.
{: shortdesc}

Huge pages scheduling is a beta feature in {{site.data.keyword.containerlong_notm}} and is subject to change.
{: beta}

By default, the CPU of your worker nodes allocates RAM in chunks, or pages, of 4 KB. When your app requires more RAM, the system must continue to look up more pages, which can slow down processing. With huge pages, you can increase the page size to 2 MB to increase performance for your RAM-intensive apps like databases for artificial intelligence (AI), internet of things (IoT), or machine learning workloads. For more information about huge pages, see [the Linux kernel documentation](https://www.kernel.org/doc/Documentation/vm/hugetlbpage.txt){: external}.

You can reboot the worker node and the huge pages configuration persists. However, the huge pages configuration doesn't persist across any other worker node life cycle operations. You must repeat the enablement steps each time that you update, reload, replace, or add worker nodes.
{: important}


* **Operator** platform access role and **Manager** service access role for the cluster in {{site.data.keyword.cloud_notm}} IAM

Before you begin: [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-access_cluster)

1. Create a `hugepages-ds.yaml` configuration file to enable huge pages. The following sample YAML uses a daemon set to run the pod on every worker node in your cluster. You can set the allocation of huge pages that are available on the worker node by using the `vm.nr_hugepages` parameter. This example allocates 512 pages at 2 MB per page, for 1 GB of total RAM allocated exclusively for huge pages.

    Want to enable huge pages only for certain worker nodes, such as a worker pool that you use for RAM-intensive apps? [Label](/docs/containers?topic=containers-worker-tag-label) and [taint](/docs/containers?topic=containers-kubernetes-service-cli#worker_pool_taint) your worker pool, and then add [affinity rules](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/){: external} to the daemon set so that the pods are deployed only to the worker nodes in the worker pool that you specify.
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

    2. Reboot the worker nodes. You can reboot multiple worker nodes by including multiple `-w` options, but make sure to leave enough worker nodes running at the same time for your apps to avoid an outage.
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
        ```sh
        ls /sys/kernel/mm/hugepages
        ```
        {: pre}

        Example output
        ```sh
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


These steps are applicable to clusters that run version [1.29](/docs/containers?topic=containers-cs_versions) or later. Additionally, all VPC worker nodes support jumbo frames, but classic infrastructure only supports jumbo frames on bare metal workers. 
{: note}




Changing maximum transmission unit (MTU) values can have unexpected results, especially in complex networking environments. To avoid disruption to your workflow, it is highly recommended that you test these changes on a development cluster before you make any changes to your production clusters. 
{: important}

By default, the Calico network plug-in in your {{site.data.keyword.containerlong_notm}} cluster has an MTU of 1450 bytes for Satellite clusters and 1480 bytes for non-Satellite clusters. For most cases, this default Calico MTU value is sufficient for preventing packet drops and fragmentation. Because most hosts use an MTU value of 1500, these default values provide Satellite clusters with 50 extra bytes for VXLAN headers and provide non-Satellite clusters with 20 extra bytes for the IP headers used in some pod-to-pod cluster network traffic. Note that all worker nodes in the cluster must use the same Calico MTU value.

Review the following cases in which you might need to modify the default Calico MTU:

* If you need to improve your pod-to-pod network throughput and your cluster nodes are able to use a higher host MTU, then you can increase both the host and Calico MTU. This is called using "jumbo frames". The typical jumbo frame MTU is 9000. In this case, you can set the host private network interface to an MTU value of 9000 and the Calico MTU to a slightly lower value -- 8950 for Satellite clusters and 8980 for non-Satellite clusters. Note that some cloud provider hardware or resources, [such as Azure virtual machines](https://learn.microsoft.com/en-us/azure/virtual-network/how-to-virtual-machine-mtu?tabs=linux){: external}, might not support jumbo frames or might only support an MTU value of up to 4000. 
* If you have a VPN connection set up for your cluster, some VPN connections require a smaller Calico MTU than the default. Check with the VPN service provider to determine whether a smaller Calico MTU is required.


Before you begin
:   If your worker nodes still run the default MTU value, increase the MTU value for your worker nodes first before you increase the MTU value for the Calico plug-in. For example, you can apply the following daemon set to change the MTU for your worker nodes to 9000 bytes. Note the interface names that are used in the **`ip link`** command vary depending on the type of your worker nodes.
    - Example command for Bare Metal worker nodes: `ip link set dev bond0 mtu 9000;ip link set dev bond1 mtu 9000;`
    - Example command VPC Gen 2 worker nodes: `ip link set dev ens3 mtu 9000;`

1. Run the following commands to log in to a cluster worker node and ping from one node to another. Because your node MTU is only set to 1500 or 1480, **this attempt is expected to fail**. In the following steps, you can run these commands again to verify that changes are successful.
    1. List the nodes in your cluster. Save the names and IP addresses of two healthy nodes. 
        ```sh
        kubectl get nodes -o wide
        ```
        {: pre}

    1. Log in to one of the nodes. Specify the name of the node.

        
        
        ```sh
        kubectl debug --image=us.icr.io/armada-master/network-alpine -it node/<NODE_NAME> -- sh
        ```
        {: pre}
        


    1. Run the command to ping from one node to the other. Specify the IP address of the node that you did not reference in the previous step.
        ```sh
        ping -c1 -Mdo -s 8972 <OTHER_HOST_IP>
        ```
        {: pre}

2. Change the node MTU with the following example daemonset. This MTU value applies to node-to-node traffic. Modify the `- ip link set dev ens3 mtu <MTU_VALUE>` line to include your MTU value (the example uses a MTU value of 9000). Note that you might also need to change the `ens3` interface name if ens3 is not appropriate for your nodes.
    ```yaml
    apiVersion: apps/v1
    kind: DaemonSet
    metadata:
      labels:
        app: set-host-mtu
      name: set-host-mtu
      namespace: kube-system
    spec:
      selector:
        matchLabels:
          name: set-host-mtu
      template:
        metadata:
          labels:
            name: set-host-mtu
        spec:
          containers:
          - args:
            - |
              while true; do
                sleep 100000;
              done
            command:
            - /bin/sh
            - -c
            image: us.icr.io/armada-master/network-alpine:latest
            imagePullPolicy: IfNotPresent
            name: sleepforever
            resources:
              requests:
                cpu: 10m
          hostNetwork: true
          initContainers:
          - command:
            - sh
            - -c
            - ip link set dev ens3 mtu 9000
            image: us.icr.io/armada-master/network-alpine:latest
            imagePullPolicy: IfNotPresent
            name: set-host-mtu
            securityContext:
              capabilities:
                add:
                - NET_ADMIN
              privileged: true
            volumeMounts:
            - mountPath: /sys
              name: modifysys
          restartPolicy: Always
          terminationGracePeriodSeconds: 2
          tolerations:
          - operator: Exists
          volumes:
          - hostPath:
              path: /sys
              type: ""
            name: modifysys
      updateStrategy:
        rollingUpdate:
          maxSurge: 0
          maxUnavailable: 1
        type: RollingUpdate
    ```
    {: codeblock}

3. Apply the daemonset to change the node MTU value. 
    ```sh
      kubectl apply -f <file_name>
    ```
    {: pre}

4. Re-run the commands to log in to a node and ping from one host to another, using a large packet size. Now that you have increased the node MTU value, the `ping` command is expected to succeed. 
    
    
    ```sh
    kubectl debug --image=us.icr.io/armada-master/network-alpine -it node/<NODE_NAME> -- sh
    ```
    {: pre}
    

    ```sh
    ping -c1 -Mdo -s 8972 <OTHER_HOST_IP>
    ```
    {: pre}

5. Take time to test your cluster with the new node MTU value. Before you continue with changing the Calico MTU value, it is recommended that you check to make sure your applications still function as expected. 

6. Run the command to update the Calico MTU values so that pod-to-pod traffic can also use the larger MTU. For Satellite Core OS clusters, the Calico MTU value should be 50 bytes less than the node MTU value. For all other clusters, the Calico MTU value should be 20 bytes less. For example, if you specified 9000 for the node MTU, your Calico MTU should be 8950 for Satellite Core OS clusters or 8980 for all other clusters. 

      ```sh
      kubectl patch installation.operator.tigera.io default --type='merge' -p '{"spec":{"calicoNetwork":{"mtu":<MTU_VALUE>}}}'
      ```
      {: pre}

      You can also edit the resource directly by running `kubectl edit installation.operator.tigera.io default`.
      {: tip}

7. Apply these changes to all your nodes by carefully rebooting all nodes. Make sure you have tested this process on a development cluster before you continue with this step, as these changes could cause disruptions to your workload. To reboot your nodes, it is recommended that you [cordon, drain, and reboot](/docs/containers?topic=containers-host-maintenance#worker-maintenance-classic) your nodes one by one. 

If you are completing these steps on a production cluster, you should use the same process you use for updating or replacing production nodes. It is highly recommended that you test this entire process on a test cluster before you complete these steps on a production cluster. 
{: important}

During the reboot process, some pods use the new larger MTU and some pods still have the original, smaller MTU. Typically, this scenario does not cause issues because both sides negotiate the correct max packet size. However, if you block ICMP packets, the negotiation might not work and your cluster might experience pod connection issues until all reboots have completed. It is critical that this process is first tested on a development cluster. 
{: important}

## Disabling the port map plug-in
{: #calico-portmap}

The `portmap` plug-in for the Calico container network interface (CNI) enables you to use a `hostPort` to expose your app pods on a specific port on the worker node. Prevent iptables performance issues by removing the port map plug-in from your cluster's Calico CNI configuration.
{: shortdesc}

When you have many services in your cluster, such as more than 500 services, or many ports on services, such as more than 50 ports per service for 10 or more services, many iptables rules are generated for the Calico and Kubernetes network policies for these services. Using many iptables rules can lead to performance issues for the port map plug-in, and might prevent future updates of iptables rules or cause the `calico-node` container to restart when no lock is received to make iptables rules updates within a specified time. To prevent these performance issues, you can disable the port map plug-in by removing it from your cluster's Calico CNI configuration.

If you must use `hostPorts`, don't disable the port map plug-in.
{: note}


### Disabling the port map plug-in in Kubernetes version 1.29 and later
{: #calico-portmap-129}


1. Edit the `default` Calico installation resource.
    ```sh
    kubectl edit installation default -n calico-system
    ```
    {: pre}

1. In the `spec.calicoNetwork` section, change the value of `hostPorts` to `Disabled`.
    ```yaml
    ...
    spec:
      calicoNetwork:
        hostPorts: Disabled
        ipPools:
        - cidr: 172.30.0.0/16
          encapsulation: IPIPCrossSubnet
          natOutgoing: Enabled
          nodeSelector: all()
        mtu: 1480
        nodeAddressAutodetectionV4:
          interface: (^bond0$|^eth0$|^ens6$|^ens3$)
      kubernetesProvider: OpenShift
      registry: registry.ng.bluemix.net/armada-master/
      variant: Calico
    status:
      variant: Calico
    ```
    {: screen}

1. Save and close the file. Your changes are automatically applied.



### Disabling the port map plug-in in Kubernetes version 1.28 and earlier
{: #calico-portmap-128}

1. Edit the `calico-config` ConfigMap resource.
    ```sh
    kubectl edit cm calico-config -n kube-system
    ```
    {: pre}

1. In the `data.cni_network_config.plugins` section after the `kubernetes` plug-in, remove the `portmap` plug-in section. After you remove the `portmap` section, the configuration looks like the following:
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
              ...
            },
            {
              "type": "tuning",
              ...
            },
            {
              "type": "bandwidth",
              ...
            }
          ]
        }
      typha_service_name: calico-typha
      ...
    ```
    {: codeblock}

    Changing any other settings for the Calico plug-in in this ConfigMap is not supported.
    {: important}

1. Apply the change to your cluster by restarting all `calico-node` pods.
    ```sh
    kubectl rollout restart daemonset -n kube-system calico-node
    ```
    {: pre}
