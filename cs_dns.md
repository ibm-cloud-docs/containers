---

copyright:
  years: 2014, 2025
lastupdated: "2025-12-11"


keywords: kubernetes, coredns, kubedns, dns

subcollection: containers

---

{{site.data.keyword.attribute-definition-list}}





# Configuring the cluster DNS provider
{: #cluster_dns}

Each service in your {{site.data.keyword.containerlong}} cluster is assigned a Domain Name System (DNS) name that the cluster DNS provider registers to resolve DNS requests. For more information about DNS for services and pods, see [the Kubernetes documentation](https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/){: external}.
{: shortdesc}

The cluster DNS provider is [CoreDNS](https://coredns.io/){: external}, which is a general-purpose, authoritative DNS server that provides a backwards-compatible, but extensible, integration with Kubernetes. Because CoreDNS is a single executable and single process, it has fewer dependencies and moving parts that could experience issues than other cluster DNS providers. The project is also written in the same language as the Kubernetes project, `Go`, which helps protect memory. Finally, CoreDNS supports more flexible use cases than other cluster DNS providers because you can create custom DNS entries such as the common setups in [the CoreDNS docs](https://coredns.io/manual/toc/#setups){: external}.

CoreDNS and NodeLocal DNS cache configuration changes in version 1.34 and later
:   The default DNS cache time in both CoreDNS and NodeLocal DNS configurations has been increased from 30 seconds to 120 seconds. This change applies to the ConfigMap settings for DNS caching. Some users were hitting pDNS (or UDP) traffic limits due to frequent DNS lookups caused by short cache durations. A 30-second cache interval is rarely necessary except for DNS records that change very frequently, for example health-check endpoints. For most workloads, a 120-second default cache provides better performance and reduces unnecessary DNS traffic. Users who require shorter cache times for specific use cases can override this setting.

## Autoscaling the cluster DNS provider
{: #dns_autoscale}

By default, CoreDNS includes a deployment to autoscale the CoreDNS pods in response to the number of worker nodes and cores within the cluster. You can fine-tune the CoreDNS autoscaler parameters by editing the CoreDNS autoscaling ConfigMap. For example, if your apps heavily use the cluster DNS provider, you might need to increase the minimum number of CoreDNS pods to support the app. For more information, see [the Kubernetes documentation](https://kubernetes.io/docs/tasks/administer-cluster/dns-horizontal-autoscaling/){: external}.
{: shortdesc}

Before you begin: [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-access_cluster)

1. Verify that the CoreDNS autoscaler deployment is available. In your CLI output, verify that one deployment is **AVAILABLE**.

    ```sh
    kubectl get deployment -n kube-system coredns-autoscaler
    ```
    {: pre}

    Example output
    
    ```sh
    NAME                 READY   UP-TO-DATE   AVAILABLE   AGE
    coredns-autoscaler   1/1     1            1           69d
    ```
    {: screen}

2. Edit the default settings for the CoreDNS autoscaler. Look for the `data.linear` field, which defaults to one CoreDNS pod per 16 worker nodes or 256 cores, with a minimum of two CoreDNS pods regardless of cluster size (`preventSinglePointFailure: true`). For more information, see [the Kubernetes documentation](https://kubernetes.io/docs/tasks/administer-cluster/dns-horizontal-autoscaling/#tuning-autoscaling-parameters){: external}.

    ```sh
    kubectl edit configmap -n kube-system coredns-autoscaler
    ```
    {: pre}

    Example output
    
    ```sh
    apiVersion: v1
    data:
      linear: '{"coresPerReplica":256,"nodesPerReplica":16,"preventSinglePointFailure":true}'
    kind: ConfigMap
    metadata:
    ...
    ```
    {: screen}

## Customizing the cluster DNS provider
{: #dns_customize}

You can customize CoreDNS by editing the CoreDNS ConfigMap. For example, you might want to configure stub domains and upstream DNS servers to resolve services that point to external hosts. Additionally, you can configure multiple [Corefiles](https://coredns.io/2017/07/23/corefile-explained/){: external} within the CoreDNS ConfigMap. For more information, see [the Kubernetes documentation](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/){: external}.
{: shortdesc}

`NodeLocal` DNS caching relies on CoreDNS to maintain the cache of DNS resolutions. Keep applicable `NodeLocal` DNS cache and CoreDNS configurations such as stub domains the same to maintain DNS resolution consistency.
{: note}

Before you begin: [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-access_cluster)

1. Verify that the CoreDNS deployment is available. In your CLI output, verify that one deployment is **AVAILABLE**.

    ```sh
    kubectl get deployment -n kube-system coredns
    ```
    {: pre}

    Example output
    
    ```sh
    NAME      READY   UP-TO-DATE   AVAILABLE   AGE
    coredns   3/3     3            3           69d
    ```
    {: screen}

2. Edit the default settings for the CoreDNS ConfigMap. Use a Corefile in the `data` section of the ConfigMap to customize stub domains and upstream DNS servers. For more information, see [the Kubernetes documentation](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/#coredns){: external}.

    The CoreDNS `proxy` plug-in is deprecated and replaced with the `forward` plug-in. If you update the CoreDNS ConfigMap, make sure to replace all `proxy` instances with `forward`.
    {: note}

    ```sh
    kubectl edit configmap -n kube-system coredns
    ```
    {: pre}

    CoreDNS example output
    
    ```yaml
    apiVersion: v1
    kind: ConfigMap
    metadata:
    name: coredns
    namespace: kube-system
      data:
        Corefile: |
          import <MyCorefile>
          .:53 {
              errors
              health {
                lameduck 10s
              }
              ready
              kubernetes cluster.local in-addr.arpa ip6.arpa {
                 pods insecure
                 fallthrough in-addr.arpa ip6.arpa
                 ttl 30
              }
              prometheus :9153
              forward . /etc/resolv.conf {
                  max_concurrent 1000
              }
              cache 30 {
                  disable success cluster.local
                  disable denial cluster.local
              }
              loop
              reload
              loadbalance
          }
        <MyCorefile>: |
          abc.com:53 {
            errors
            cache 30
            loop
            forward . 1.2.3.4
            }
    ```
    {: screen}

3. Optional: Add custom Corefiles to the CoreDNS ConfigMap. In the following example, include the `import <MyCoreFile>` in the `data.Corefile` section, and complete the `data.<MyCorefile>` section with your custom Corefile information. For more information, see [the Corefile import documentation](https://coredns.io/plugins/import/){: external}.

    The CoreDNS `proxy` plug-in is deprecated and replaced with the `forward` plug-in. If you update the CoreDNS ConfigMap, make sure to replace all `proxy` instances with `forward`.
    {: note}

    ```sh
    kubectl edit configmap -n kube-system coredns
    ```
    {: pre}

    Custom Corefile example output
    ```yaml
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: coredns
      namespace: kube-system
    data:
      Corefile: |
        import <MyCorefile>
        .:53 {
            errors
            health
            kubernetes cluster.local in-addr.arpa ip6.arpa {
               pods insecure
               upstream 172.16.0.1
               fallthrough in-addr.arpa ip6.arpa
            }
            prometheus :9153
            forward . /etc/resolv.conf {
                max_concurrent 1000
            }
            cache 30 {
                disable success cluster.local
                disable denial cluster.local
            }
            loop
            reload
            loadbalance
        }
      <MyCorefile>: |
        abc.com:53 {
          errors
          cache 30
          loop
          forward . 1.2.3.4
        }
    ```
    {: screen}

4. After a few minutes, the CoreDNS pods pick up the ConfigMap changes.



## Setting up NodeLocal DNS cache
{: #dns_cache}

Set up the `NodeLocal` DNS caching agent on select worker nodes for improved cluster DNS performance and availability in your {{site.data.keyword.containerlong_notm}} cluster. For more information, see the [Kubernetes docs](https://kubernetes.io/docs/tasks/administer-cluster/nodelocaldns/){: external}.
{: shortdesc}

By default, cluster DNS requests for pods that use a `ClusterFirst` [DNS policy](https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/#pod-s-dns-policy){: external} are sent to the cluster DNS service. If you enable `NodeLocal` DNS caching on a worker node, the cluster DNS requests for these pods that are on the worker node are sent instead to the local DNS cache, which listens on link-local IP address 169.254.20.10. The DNS cache also listens on the cluster IP of the `kube-dns` service in the `kube-system` namespace.

Do not add the DNS cache label when you already use [zone-aware DNS](#dns_zone_aware) in your cluster. Also, `NodeLocal` DNS caching relies on CoreDNS to maintain the cache of DNS resolutions. Keep applicable `NodeLocal` DNS cache and CoreDNS configurations such as stub domains the same to maintain DNS resolution consistency.
{: important}

`NodeLocal` DNS cache is generally available in clusters that run Kubernetes 1.18 or later, but still disabled by default.
{: preview}



### Enable NodeLocal DNS cache
{: #dns_enablecache}

Enable `NodeLocal` DNS cache for one or more worker nodes in your Kubernetes cluster.
{: shortdesc}

The following steps update DNS pods that run on particular worker nodes. You can also [label the worker pool](/docs/containers?topic=containers-worker-tag-label) so that future nodes inherit the label.
{: note}

Before you begin, update any [DNS egress network policies](https://github.com/kubernetes/kubernetes/tree/master/cluster/addons/dns/nodelocaldns#network-policy-and-dns-connectivity){: external} that are impacted by this feature, such as policies that rely on pod or namespace selectors for DNS egress.

```sh
kubectl get networkpolicy --all-namespaces -o yaml
```
{: pre}


1. [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-access_cluster)
2. If you [customized stub domains and upstream DNS servers for CoreDNS](#dns_customize), you must also [customize the `NodeLocal` DNS cache](#dns_nodelocal_customize) with these stub domains and upstream DNS servers.
3. List the nodes in your cluster. The `NodeLocal` DNS caching agent pods are part of a daemon set that run on each node.

    ```sh
    kubectl get nodes
    ```
    {: pre}

4. Add the `ibm-cloud.kubernetes.io/node-local-dns-enabled=true` label to the worker node. The label starts the DNS caching agent pod on the worker node.
    1. Add the label to one or more worker nodes.
        * **To label all worker nodes in the cluster**: [Add the label to all existing worker pools](/docs/containers?topic=containers-worker-tag-label).
        * **To label an individual worker node**:
        
            ```sh
            kubectl label node <node_name> --overwrite "ibm-cloud.kubernetes.io/node-local-dns-enabled=true"
            ```
            {: pre}

    2. Verify that the node has the label by checking that the `NODE-LOCAL-DNS-ENABLED` field is set to `true`.
    
        ```sh
        kubectl get nodes -L "ibm-cloud.kubernetes.io/node-local-dns-enabled"
        ```
        {: pre}

        Example output
        
        ```sh
        NAME          STATUS                      ROLES    AGE   VERSION       NODE-LOCAL-DNS-ENABLED
        10.xxx.xx.xxx Ready,SchedulingDisabled    <none>   28h   v1.33+IKS   true
        ```
        {: screen}

    3. Verify that the DNS caching agent pod is running on the worker node.
    
        ```sh
        kubectl get pods -n kube-system -l k8s-app=node-local-dns -o wide
        ```
        {: pre}

        Example output
        
        ```sh
        NAME                   READY   STATUS    RESTARTS   AGE   IP            NODE          NOMINATED NODE   READINESS GATES
        node-local-dns-pvnjn   1/1     Running   0          1m    10.xxx.xx.xxx   10.xxx.xx.xxx  <none>           <none>
        ```
        {: screen}

5. Repeat the previous steps for each worker node to enable DNS caching.

### Disable NodeLocal DNS cache
{: #dns_disablecache}

You can disable the `NodeLocal` DNS cache for one or more worker nodes.
{: shortdesc}

1. [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-access_cluster)
2. Remove the `ibm-cloud.kubernetes.io/node-local-dns-enabled` label from the worker node. This action terminates the DNS caching agent pod on the worker node.

    Run the following command to remove the label from all worker nodes in the cluster.
    
    ```sh
    kubectl label node --all --overwrite "ibm-cloud.kubernetes.io/node-local-dns-enabled-"
    ```
    {: pre}

    Run the following command to remove the label from an individual worker node.
    
    ```sh
    kubectl label node <node_name> "ibm-cloud.kubernetes.io/node-local-dns-enabled-"
    ```
    {: pre}

    1. Verify that the label is removed by checking that the `NODE-LOCAL-DNS-ENABLED` field is empty.
    
        ```sh
        kubectl get nodes -L "ibm-cloud.kubernetes.io/node-local-dns-enabled"
        ```
        {: pre}

        Example output
        
        ```sh
        NAME          STATUS                      ROLES    AGE   VERSION       NODE-LOCAL-DNS-ENABLED
        10.xxx.xx.xxx Ready,SchedulingDisabled    <none>   28h   v1.33+IKS   
        ```
        {: screen}

    2. Verify that the pod is no longer running on the node where DNS cache is disabled. The output shows no pods.
    
        ```sh
        kubectl get pods -n kube-system -l k8s-app=node-local-dns -o wide
        ```
        {: pre}

        Example output
        
        ```sh
        No resources found.
        ```
        {: screen}

3. Repeat the previous steps for each worker node to disable DNS caching.



## Customizing NodeLocal DNS cache
{: #dns_nodelocal_customize}

You can customize the `NodeLocal` DNS cache by editing either of the two configmaps. 
{: shortdesc}

* [**`node-local-dns` ConfigMap**](#dns_nodelocal_customize_configmap): Customize the `NodeLocal` DNS cache configuration.
* [**`node-local-dns-config` ConfigMap**](#dns_nodelocal_customize_stub_upstream): Extend the `NodeLocal` DNS cache configuration by customizing stub domains or upstream DNS servers to resolve services that point to external hosts. 

`NodeLocal` DNS caching relies on CoreDNS to maintain the cache of DNS resolutions. Keep applicable `NodeLocal` DNS cache and CoreDNS configurations such as stub domains the same to maintain DNS resolution consistency.
{: note}

### Editing the `node-local-dns` ConfigMap for general configuration updates
{: #dns_nodelocal_customize_configmap}

Edit the `node-local-dns` ConfigMap to customize the `NodeLocal` DNS cache configuration.
{: shortdesc}

Before you begin: [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-access_cluster)

1. Verify that the `NodeLocal` DNS cache daemon set is available.

    ```sh
    kubectl get ds -n kube-system node-local-dns
    ```
    {: pre}

    Example output
    
    ```sh
    NAME             DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR                                         AGE
    node-local-dns   4         4         4       4            4           ibm-cloud.kubernetes.io/node-local-dns-enabled=true   82d
    ```
    {: screen}

2. Edit the default settings or add custom Corefiles to the `NodeLocal` DNS cache ConfigMap. Each Corefile that you import must use the `coredns` path. For more information, see the [Kubernetes documentation](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/#coredns){: external}.

    Only a limited set of [plug-ins](https://coredns.io/plugins/){: external} is supported for the `NodeLocal` DNS cache.
    {: important}

    ```sh
    kubectl edit configmap -n kube-system node-local-dns
    ```
    {: pre}

    Example output

    ```yaml
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: node-local-dns
      namespace: kube-system
    data:
      Corefile: |
        # Add your NodeLocal DNS customizations as import files under ./coredns directory.
        # Refer to /docs/containers?topic=containers-cluster_dns for details.
        import ./coredns/<MyCorefile>
        cluster.local:53 abc.com:53 {
            errors
            cache {
                    success 9984 30
                    denial 9984 5
            }
            reload
            loop
            bind 169.254.20.10 172.21.0.10
            forward . __PILLAR__CLUSTER__DNS__ {
                    force_tcp
            }
            prometheus :9253
            health 169.254.20.10:8080
            }
        in-addr.arpa:53 {
            errors
            cache 30
            reload
            loop
            bind 169.254.20.10 172.21.0.10
            forward . __PILLAR__CLUSTER__DNS__ {
                    force_tcp
            }
            prometheus :9253
            }
        ip6.arpa:53 {
            errors
            cache 30
            reload
            loop
            bind 169.254.20.10 172.21.0.10
            forward . __PILLAR__CLUSTER__DNS__ {
                    force_tcp
            }
            prometheus :9253
            }
        .:53 {
            errors
            cache 30 {
                  disable success cluster.local
                  disable denial cluster.local
            }
            reload
            loop
            bind 169.254.20.10 172.21.0.10
            forward . __PILLAR__UPSTREAM__SERVERS__ {
                    force_tcp
            }
            prometheus :9253
            }
      <MyCorefile>: |
        # Add custom corefile content ...
    ```
    {: screen}

3. After a few minutes, the `NodeLocal` DNS cache pods pick up the ConfigMap changes.

### Editing the `node-local-dns-config` ConfigMap to extend with stub domains or upstream servers
{: #dns_nodelocal_customize_stub_upstream}

Edit the `node-local-dns-config` ConfigMap to extend the `NodeLocal` DNS cache configuration such as by customizing stub domains or upstream DNS servers. For more information, see the [Kubernetes documentation](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/#kube-dns){: external}.
{: shortdesc}

Before you begin: [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-access_cluster)

1. Verify that the `NodeLocal` DNS cache daemon set is available.

    ```sh
    kubectl get ds -n kube-system node-local-dns
    ```
    {: pre}

    Example output
    
    ```sh
    NAME             DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR                                         AGE
    node-local-dns   4         4         4       4            4           ibm-cloud.kubernetes.io/node-local-dns-enabled=true   82d
    ```
    {: screen}

2. Confirm that the `NodeLocal` DNS cache has a ConfigMap.

    1. Determine if the `NodeLocal` DNS cache ConfigMap exists.
    
        ```sh
        kubectl get cm -n kube-system node-local-dns-config
        ```
        {: pre}

        Example output if no ConfigMap exists
        
        ```sh
        Error from server (NotFound): ConfigMaps "node-local-dns-config" not found
        ```
        {: screen}

    2. If the ConfigMap does not exist, create a `NodeLocal` DNS cache ConfigMap.
    
        ```sh
        kubectl create cm -n kube-system node-local-dns-config
        ```
        {: pre}

        Example output
        
        ```sh
        configmap/node-local-dns-config created
        ```
        {: screen}

3. Edit the `NodeLocal` DNS cache ConfigMap. The ConfigMap uses the KubeDNS syntax to customize stub domains and upstream DNS servers. For more information, see the [Kubernetes documentation](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/#kube-dns){: external}.

    ```sh
    kubectl edit cm -n kube-system node-local-dns-config
    ```
    {: pre}

    Example output

    ```yaml
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: node-local-dns-config
      namespace: kube-system
    data:
      stubDomains: |
          {"abc.com" : ["1.2.3.4"]}
    ```
    {: screen}

4. After a few minutes, the `NodeLocal` DNS cache pods pick up the ConfigMap changes.




## Setting up zone-aware DNS
{: #dns_zone_aware}

Set up zone-aware DNS for improved cluster DNS performance and availability in your [multizone {{site.data.keyword.containerlong_notm}} cluster](/docs/containers?topic=containers-strategy#plan_locations). This setup extends [`NodeLocal` DNS cache](#dns_cache) to prefer cluster DNS traffic within the same zone.
{: shortdesc}

By default, your cluster is set up with cluster-wide DNS resources, not zone-aware DNS resources. Even after you set up zone-aware DNS, the cluster-wide DNS resources remain running as a backup DNS. Your zone-aware DNS resources are separate from the cluster-wide DNS, and changing zone-aware DNS does not impact the cluster-wide DNS.

Do not use the [DNS cache label](#dns_cache) when you use zone-aware DNS in your cluster.
{: important}

### Setting up zone-aware DNS
{: #dns_zone_aware_deploy}

Complete the following step to set up zone-aware DNS in your multizone cluster.
{: shortdesc}

1. Update any [DNS egress network policies](https://github.com/kubernetes/kubernetes/tree/master/cluster/addons/dns/nodelocaldns#network-policy-and-dns-connectivity){: external} that are impacted by zone-aware DNS, such as policies that rely on pod or namespace selectors for DNS egress. Run the following command to get a list of your network policies.

    ```sh
    kubectl get networkpolicy --all-namespaces -o yaml
    ```
    {: pre}

1. Label the `coredns` ConfigMap in the `kube-system` namespace with `ibm-cloud.kubernetes.io/deploy-zone-aware-dns=true`.

    ```sh
    kubectl label cm -n kube-system coredns --overwrite "ibm-cloud.kubernetes.io/deploy-zone-aware-dns=true"
    ```
    {: pre}

1. [Refresh the cluster master](/docs/containers?topic=containers-kubernetes-service-cli#cs_apiserver_refresh) to deploy the zone-aware DNS resources.

    ```sh
    ibmcloud ks cluster master refresh -c <cluster_name_or_ID>
    ```
    {: pre}

1. Watch for the refresh operation to complete by [reviewing the **Master Health** in the cluster details](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_get).

    ```sh
    ibmcloud ks cluster get -c <cluster_name_or_ID>
    ```
    {: pre}

1. If you [customized stub domains and upstream DNS servers for CoreDNS](#dns_customize), you must also [customize the `NodeLocal` DNS cache](#dns_nodelocal_customize) with these stub domains and upstream DNS servers.
1. Set an environment variable for the zones of the cluster.
    
    ```sh
    ZONES=$(kubectl get nodes --no-headers --ignore-not-found=true -o jsonpath='{range .items[*]}{.metadata.labels.topology\.kubernetes\.io/zone}{"\n"}{end}' | uniq)
    ```
    {: pre}


1. Start the CoreDNS and CoreDNS autoscaler pods in all zones.

    ```sh
    for ZONE in ${ZONES}; do
        kubectl scale deployment -n kube-system "coredns-autoscaler-${ZONE}" --replicas=1
    done
    ```
    {: pre}

1. Verify that the CoreDNS and CoreDNS autoscaler pods are running in all zones.

    ```sh
    for ZONE in ${ZONES}; do
        kubectl get pods -n kube-system -l "k8s-app=coredns-autoscaler-${ZONE}" -o wide
        kubectl get pods -n kube-system -l "k8s-app=coredns-${ZONE}" -o wide
    done
    ```
    {: pre}

1. Start the `NodeLocal` DNS cache pods on all workers nodes.

    ```sh
    kubectl label nodes --all --overwrite "ibm-cloud.kubernetes.io/zone-aware-dns-enabled=true"
    ```
    {: pre}

1. Verify that the `NodeLocal` DNS cache pods are running on all workers nodes.

    ```sh
    for ZONE in ${ZONES}; do
        kubectl get pods -n kube-system -l "k8s-app=node-local-dns-${ZONE}" -o wide
    done
    ```
    {: pre}

1. [Label your worker pools](/docs/containers?topic=containers-worker-tag-label) so that future worker nodes inherit the `ibm-cloud.kubernetes.io/zone-aware-dns-enabled=true` label.


### Disabling and deleting zone-aware DNS
{: #dns_zone_aware_delete}

To remove zone-aware DNS, you must first disable zone-aware DNS in each zone of your multizone cluster. Then, delete the zone-aware DNS resources.
{: shortdesc}


1. Remove the `ibm-cloud.kubernetes.io/zone-aware-dns-enabled=true` [label from your worker pools](/docs/containers?topic=containers-worker-tag-label).
1. Set an environment variable for the zones in the cluster.
    
    ```sh
    ZONES=$(kubectl get nodes --no-headers --ignore-not-found=true -o jsonpath='{range .items[*]}{.metadata.labels.topology\.kubernetes\.io/zone}{"\n"}{end}' | uniq)
    ```
    {: pre}

1. Stop the `NodeLocal` DNS cache pods on all worker nodes.

    ```sh
    kubectl label nodes --all --overwrite "ibm-cloud.kubernetes.io/zone-aware-dns-enabled-"
    ```
    {: pre}

1. Stop the CoreDNS autoscaler pods in all zones.

    ```sh
    for ZONE in ${ZONES}; do
        kubectl scale deployment -n kube-system "coredns-autoscaler-${ZONE}" --replicas=0
    done
    ```
    {: pre}

1. Verify that the CoreDNS autoscaler pods are no longer running in all zones.

    ```sh
    for ZONE in ${ZONES}; do
        kubectl get pods -n kube-system -l "k8s-app=coredns-autoscaler-${ZONE}"
    done
    ```
    {: pre}

1. Stop the CoreDNS pods in all zones.

    ```sh
    for ZONE in ${ZONES}; do
        kubectl scale deployment -n kube-system "coredns-${ZONE}" --replicas=0
    done
    ```
    {: pre}

1. Remove the `ibm-cloud.kubernetes.io/deploy-zone-aware-dns=true` label from the `coredns` ConfigMap in the `kube-system` namespace.

    ```sh
    kubectl label cm -n kube-system coredns --overwrite "ibm-cloud.kubernetes.io/deploy-zone-aware-dns-"
    ```
    {: pre}

1. [Refresh the cluster master](/docs/containers?topic=containers-kubernetes-service-cli#cs_apiserver_refresh) to the delete zone-aware DNS resources.

    ```sh
    ibmcloud ks cluster master refresh --cluster <cluster-name-or-id>
    ```
    {: pre}

1. Watch for the refresh operation to complete by [reviewing the **Master Health** in the cluster details](/docs/containers?topic=containers-kubernetes-service-cli#cs_cluster_get).

    ```sh
    ibmcloud ks cluster get -c <cluster_name_or_ID>
    ```
    {: pre}
