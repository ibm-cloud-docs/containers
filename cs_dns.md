---

copyright:
  years: 2014, 2020
lastupdated: "2020-02-10"

keywords: kubernetes, iks, coredns, kubedns, dns

subcollection: containers

---

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


# Classic: Configuring the cluster DNS provider
{: #cluster_dns}

<img src="images/icon-classic.png" alt="Classic infrastructure provider icon" width="15" style="width:15px; border-style: none"/> This DNS provider information is specific to classic clusters. For DNS provider information for VPC clusters, see [Configuring CoreDNS](/docs/containers?topic=containers-vpc_dns).
{: note}

Each service in your {{site.data.keyword.containerlong}} cluster is assigned a Domain Name System (DNS) name that the cluster DNS provider registers to resolve DNS requests. Depending on the Kubernetes version of your cluster, you might choose between Kubernetes DNS (KubeDNS) or [CoreDNS](https://coredns.io/){: external}. For more information about DNS for services and pods, see [the Kubernetes documentation](https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/){: external}.
{: shortdesc}

**Which Kubernetes versions support which cluster DNS provider?**<br>

| Kubernetes Version | Default for new clusters | Description |
|---|---|---|
| 1.14 and later | CoreDNS | If a cluster uses KubeDNS and is updated to version 1.14 or later from an earlier version, the cluster DNS provider is automatically migrated from KubeDNS to CoreDNS during the cluster update. You cannot switch the cluster DNS provider back to KubeDNS. Additionally, any remaining KubeDNS components are removed and no longer exist in clusters that run version 1.16 or later.|
| 1.13 | CoreDNS | Clusters that are updated to 1.13 from an earlier version keep whichever DNS provider they used at the time of the update. If you want to use a different one, [switch the DNS provider](#dns_set). |
| 1.12 | KubeDNS | To use CoreDNS instead, [switch the DNS provider](#set_coredns). |
| 1.11 and earlier | KubeDNS | You cannot switch the DNS provider to CoreDNS. |
{: caption="Default cluster DNS provider by Kubernetes version" caption-side="top"}

**What are the benefits of using CoreDNS instead of KubeDNS?**<br>
CoreDNS is the default supported cluster DNS provider for Kubernetes version 1.13 and later, and recently became a [graduated Cloud Native Computing Foundation (CNCF) project](https://www.cncf.io/projects/){: external}. A graduated project is thoroughly tested, hardened, and ready for wide-scale, production-level adoption.

As noted in the [Kubernetes announcement](https://kubernetes.io/blog/2018/12/03/kubernetes-1-13-release-announcement/){: external}, CoreDNS is a general-purpose, authoritative DNS server that provides a backwards-compatible, but extensible, integration with Kubernetes. Because CoreDNS is a single executable and single process, it has fewer dependencies and moving parts that could experience issues than the previous cluster DNS provider. The project is also written in the same language as the Kubernetes project, `Go`, which helps protect memory. Finally, CoreDNS supports more flexible use cases than KubeDNS because you can create custom DNS entries such as the [common setups in the CoreDNS docs](https://coredns.io/manual/toc/#setups){: external}.

## Autoscaling the cluster DNS provider
{: #dns_autoscale}

By default, your {{site.data.keyword.containerlong_notm}} cluster DNS provider includes a deployment to autoscale the DNS pods in response to the number of worker nodes and cores within the cluster. You can fine-tune the DNS autoscaler parameters by editing the DNS autoscaling configmap. For example, if your apps heavily use the cluster DNS provider, you might need to increase the minimum number of DNS pods to support the app. For more information, see [the Kubernetes documentation](https://kubernetes.io/docs/tasks/administer-cluster/dns-horizontal-autoscaling/){: external}.
{: shortdesc}

Before you begin: [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

1.  Verify that the cluster DNS provider deployment is available. You might have the autoscaler for the KubeDNS, the CoreDNS, or both DNS providers installed in your cluster. If both DNS autoscalers are installed, find the one that is in use by looking at the **AVAILABLE** column in your CLI output. The deployment that is in use is listed with one available deployment.
    ```
    kubectl get deployment -n kube-system | grep dns-autoscaler
    ```
    {: pre}

    Example output:
    ```
    NAME                   DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
    coredns-autoscaler     0         0         0            0           32d
    kube-dns-autoscaler    1         1         1            1           260d
    ```
    {: screen}
2.  Get the name of the configmap for the DNS autoscaler parameters.
    ```
    kubectl get configmap -n kube-system
    ```
    {: pre}    
3.  Edit the default settings for the DNS autoscaler. Look for the `data.linear` field, which defaults to one DNS pod per 16 worker nodes or 256 cores, with a minimum of two DNS pods regardless of cluster size (`preventSinglePointFailure: true`). For more information, see [the Kubernetes documentation](https://kubernetes.io/docs/tasks/administer-cluster/dns-horizontal-autoscaling/#tuning-autoscaling-parameters){: external}.
    ```
    kubectl edit configmap -n kube-system <dns-autoscaler>
    ```
    {: pre}

    Example output:
    ```
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

You can customize your {{site.data.keyword.containerlong_notm}} cluster DNS provider by editing the DNS configmap. For example, you might want to configure `stubdomains` to resolve services that point to external hosts. Additionally, if you use CoreDNS, you can configure multiple [Corefiles](https://coredns.io/2017/07/23/corefile-explained/){: external} within the CoreDNS configmap. For more information, see [the Kubernetes documentation](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/){: external}.
{: shortdesc}

Before you begin: [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

1.  Verify that the cluster DNS provider deployment is available. You might have the DNS cluster provider for KubeDNS, CoreDNS, or both DNS providers installed in your cluster. If both DNS providers are installed, find the one that is in use by looking at the **AVAILABLE** column in your CLI output. The deployment that is in use is listed with one available deployment.
    ```
    kubectl get deployment -n kube-system -l k8s-app=kube-dns
    ```
    {: pre}

    Example output:
    ```
    NAME                   DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
    coredns                0         0         0            0           89d
    kube-dns-amd64         2         2         2            2           89d
    ```
    {: screen}
2.  Edit the default settings for the CoreDNS or KubeDNS configmap.

    *   **For CoreDNS**: Use a Corefile in the `data` section of the configmap to customize `stubdomains`. For more information, see [the Kubernetes documentation](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/#coredns){: external}.<p class="tip">Do you have many customizations that you want to organize? In Kubernetes version 1.12.6_1543 and later, you can add multiple Corefiles to the CoreDNS configmap. In the following example, include the `import <MyCoreFile>` in the `data.Corefile` section, and fill out the `data.<MyCorefile>` section with your custom Corefile information. For more information, see [the Corefile import documentation](https://coredns.io/plugins/import/){: external}.</p>

        ```
        kubectl edit configmap -n kube-system coredns
        ```
        {: pre}

        **CoreDNS example output**:
          ```
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
                  forward . /etc/resolv.conf
                  cache 30
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

    *   **For KubeDNS**: Configure `stubdomains` and upstream nameservers in the `data` section of the configmap. For more information, see [the Kubernetes documentation](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/#kube-dns){: external}.
        ```
        kubectl edit configmap -n kube-system kube-dns
        ```
        {: pre}

        **KubeDNS example output**:
        ```
        apiVersion: v1
        kind: ConfigMap
        metadata:
          name: kube-dns
          namespace: kube-system
        data:
          stubDomains: |
            {"abc.com": ["1.2.3.4"]}
        ```
        {: screen}

## Setting the cluster DNS provider to CoreDNS or KubeDNS
{: #dns_set}

If you have an {{site.data.keyword.containerlong_notm}} cluster that runs Kubernetes version 1.12 or 1.13, you can choose to use Kubernetes DNS (KubeDNS) or CoreDNS as the cluster DNS provider.
{: shortdesc}

Clusters that run other Kubernetes versions cannot set the cluster DNS provider. Version 1.11 and earlier supports only KubeDNS, and version 1.14 and later supports only CoreDNS.
{: note}

**Before you begin**:
1.  [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)
2.  Determine the current cluster DNS provider. In the following example, KubeDNS is the current cluster DNS provider.
    ```
    kubectl cluster-info
    ```
    {: pre}

    Example output:
    ```
    ...
    KubeDNS is running at https://c2.us-south.containers.cloud.ibm.com:20190/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
    ...
    ```
    {: screen}
3.  Based on the DNS provider that your cluster uses, follow the steps to switch DNS providers.
    *  [Switch to use CoreDNS](#set_coredns).
    *  [Switch to use KubeDNS](#set_kubedns).

### Setting up CoreDNS as the cluster DNS provider
{: #set_coredns}

Set up CoreDNS instead of KubeDNS as the cluster DNS provider.
{: shortdesc}

1.  If you customized the KubeDNS provider configmap or KubeDNS autoscaler configmap, transfer any customizations to the CoreDNS configmaps.
    *   For the `kube-dns` configmap in the `kube-system` namespace, transfer any [DNS customizations](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/){: external} to the `coredns` configmap in the `kube-system` namespace. The syntax differs in the `kube-dns` and `coredns` configmaps. For an example, see [the Kubernetes docs](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/#coredns-configuration-equivalent-to-kube-dns){: external}.
    *   For the `kube-dns-autoscaler` configmap in the `kube-system` namespace, transfer any [DNS autoscaler customizations](https://kubernetes.io/docs/tasks/administer-cluster/dns-horizontal-autoscaling/){: external} to the `coredns-autoscaler` configmap in the `kube-system` namespace. The customization syntax is the same in both.
2.  Scale down the KubeDNS autoscaler deployment.
    ```
    kubectl scale deployment -n kube-system --replicas=0 kube-dns-autoscaler
    ```
    {: pre}
3.  Check and wait for the pods to be deleted.
    ```
    kubectl get pods -n kube-system -l k8s-app=kube-dns-autoscaler
    ```
    {: pre}
4.  Switch the cluster DNS provider to CoreDNS from KubeDNS.<p class="important">When you run both cluster DNS providers at the same time, you might experience intermittent DNS failures. Be sure to scale down the KubeDNS deployment so that you do not keep both DNS providers running at the same time.</p>
    1.  Scale up the CoreDNS autoscaler deployment.
        ```
        kubectl scale deployment -n kube-system --replicas=1 coredns-autoscaler
        ```
        {: pre}
    2.  Label and annotate the cluster DNS service for CoreDNS.
        ```
        kubectl label service --overwrite -n kube-system kube-dns kubernetes.io/name=CoreDNS
        ```
        {: pre}
        ```
        kubectl annotate service --overwrite -n kube-system kube-dns prometheus.io/port=9153
        ```
        {: pre}
        ```
        kubectl annotate service --overwrite -n kube-system kube-dns prometheus.io/scrape=true
        ```
        {: pre}
    3.  Scale down the KubeDNS deployment.
        ```
        kubectl scale deployment -n kube-system --replicas=0 kube-dns-amd64
        ```
        {: pre}
5.  **Optional**: If you plan to use Prometheus to collect metrics from the CoreDNS pods, you must add a metrics port to the `kube-dns` service that you are switching from.
    ```
    kubectl -n kube-system patch svc kube-dns --patch '{"spec": {"ports": [{"name":"metrics","port":9153,"protocol":"TCP"}]}}' --type strategic
    ```
    {: pre}



### Setting up KubeDNS as the cluster DNS provider
{: #set_kubedns}

Set up KubeDNS instead of CoreDNS as the cluster DNS provider.
{: shortdesc}

1.  If you customized the CoreDNS provider configmap or CoreDNS autoscaler configmap, transfer any customizations to the KubeDNS configmaps.
    *   For the `coredns` configmap in the `kube-system` namespace, transfer any [DNS customizations](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/){: external} to the `kube-dns` configmap in the `kube-system` namespace. The syntax differs from the `kube-dns` and `coredns` configmaps. For an example, see [the Kubernetes docs](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/#coredns-configuration-equivalent-to-kube-dns){: external}.
    *   For the `coredns-autoscaler` configmap in the `kube-system` namespace, transfer any [DNS autoscaler customizations](https://kubernetes.io/docs/tasks/administer-cluster/dns-horizontal-autoscaling/){: external} to the `kube-dns-autoscaler` configmap in the `kube-system` namespace. The customization syntax is the same in both.
2.  Scale down the CoreDNS autoscaler deployment.
    ```
    kubectl scale deployment -n kube-system --replicas=0 coredns-autoscaler
    ```
    {: pre}
3.  Check and wait for the pods to be deleted.
    ```
    kubectl get pods -n kube-system -l k8s-app=coredns-autoscaler
    ```
    {: pre}
4.  Switch the cluster DNS provider to KubeDNS from CoreDNS.<p class="important">When you run both cluster DNS providers at the same time, you might experience intermittent DNS failures. Be sure to scale down the CoreDNS deployment so that you do not keep both DNS providers running at the same time.</p>
    1.  Scale up the KubeDNS autoscaler deployment.
        ```
        kubectl scale deployment -n kube-system --replicas=1 kube-dns-autoscaler
        ```
        {: pre}
    2.  Label and annotate the cluster DNS service for KubeDNS.
        ```
        kubectl label service --overwrite -n kube-system kube-dns kubernetes.io/name=KubeDNS
        ```
        {: pre}
        ```
        kubectl annotate service --overwrite -n kube-system kube-dns prometheus.io/port-
        ```
        {: pre}
        ```
        kubectl annotate service --overwrite -n kube-system kube-dns prometheus.io/scrape-
        ```
        {: pre}
    3.  Scale down the CoreDNS deployment.
        ```
        kubectl scale deployment -n kube-system --replicas=0 coredns
        ```
        {: pre}
5.  **Optional**: If you used Prometheus to collect metrics from the CoreDNS pods, your `kube-dns` service had a metrics port. However, KubeDNS does not need to include this metrics port so you can remove the port from the service.
    ```
    kubectl -n kube-system patch svc kube-dns --patch '{"spec": {"ports": [{"name":"dns","port":53,"protocol":"UDP"},{"name":"dns-tcp","port":53,"protocol":"TCP"}]}}' --type merge
    ```
    {: pre}

<br />


## Setting up NodeLocal DNS cache (beta)
{: #dns_cache}

Set up the `NodeLocal` DNS caching agent on select worker nodes for improved cluster DNS performance in your {{site.data.keyword.containerlong_notm}} cluster. For more information, see the [Kubernetes docs](https://kubernetes.io/docs/tasks/administer-cluster/nodelocaldns/){: external}.
{: shortdesc}

By default, cluster DNS requests for pods that use a `ClusterFirst` [DNS policy](https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/#pod-s-dns-policy){: external} are sent to the cluster DNS service. If you enable this beta feature on a worker node, the cluster DNS requests for these pods that are on the worker node are sent instead to the local DNS cache, which listens on link-local IP address 169.254.20.10. Additionally, in clusters that run Kubernetes 1.17 or later, the DNS cache also listens on the cluster IP of the `kube-dns` service in the `kube-system` namespace.

`NodeLocal` DNS cache is a beta feature that is subject to change, and available only for select Kubernetes versions that depend on your cluster infrastructure provider.
{: preview}

* <img src="images/icon-classic.png" alt="Classic infrastructure provider icon" width="15" style="width:15px; border-style: none"/> **Classic clusters**: Kubernetes version 1.15 or later is required.
* <img src="images/icon-vpc.png" alt="VPC infrastructure provider icon" width="15" style="width:15px; border-style: none"/> **VPC clusters**: Kubernetes version 1.17 or later is required.


### Enable NodeLocal DNS cache (beta)
{: #dns_enablecache}

Enable `NodeLocal` DNS cache for one or more worker nodes in your Kubernetes cluster.
{: shortdesc}

The following steps update DNS pods that run on particular worker nodes. You can also [label the worker pool](/docs/containers?topic=containers-add_workers#worker_pool_labels) so that future nodes inherit the label.
{: note}

**Before you begin**: Update any [DNS egress network policies](https://github.com/kubernetes/kubernetes/tree/master/cluster/addons/dns/nodelocaldns#network-policy-and-dns-connectivity){: external} that are impacted by this beta feature, such as policies that rely on pod or namespace selectors for DNS egress.
  ```
  kubectl get networkpolicy --all-namespaces -o yaml
  ```
  {: pre}

<br>
**To enable NodeLocal DNS cache**:

1. [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)
2. List the nodes in your cluster. The `NodeLocal` DNS caching agent pods are part of a daemon set that run on each node.
   ```
   kubectl get nodes
   ```
   {: pre}
3. Add the `ibm-cloud.kubernetes.io/node-local-dns-enabled=true` label to the worker node. The label starts the DNS caching agent pod on the worker node.
   ```
   kubectl label node <node_name> --overwrite "ibm-cloud.kubernetes.io/node-local-dns-enabled=true"
   ```
   {: pre}
   1. Verify that the node has the label by checking that the `NODE-LOCAL-DNS-ENABLED` field is set to `true`.
      ```
      kubectl get nodes -L "ibm-cloud.kubernetes.io/node-local-dns-enabled"
      ```
      {: pre}

      Example output:
      ```
      NAME          STATUS                      ROLES    AGE   VERSION       NODE-LOCAL-DNS-ENABLED
      10.xxx.xx.xxx Ready,SchedulingDisabled    <none>   28h   v1.15.1+IKS   true
      ```
      {: screen}
   2. Verify that the DNS caching agent pod is running on the worker node.
      ```
      kubectl get pods -n kube-system -l k8s-app=node-local-dns -o wide
      ```
      {: pre}

      Example output:
      ```
      NAME                   READY   STATUS    RESTARTS   AGE   IP            NODE          NOMINATED NODE   READINESS GATES
      node-local-dns-pvnjn   1/1     Running   0          1m    10.xxx.xx.xxx   10.xxx.xx.xxx  <none>           <none>
      ```
      {: screen}
4. **Classic clusters, Kubernetes version 1.15 or 1.16 only**: Drain and reload the worker node to apply the node local DNS caching changes. Even though you labelled the worker node, the pod is not yet handling cluster DNS requests.
   1. Drain the worker node to reschedule the pods onto remaining worker nodes in the cluster and to make it unavailable for future pod scheduling.
      ```
      kubectl drain <node_name> --delete-local-data=true --ignore-daemonsets=true --force=true --timeout=5m
      ```
      {: pre}
      Example output:
      ```
      node/10.xxx.xx.xxx cordoned
      WARNING: ignoring DaemonSet-managed Pods: default/ssh-daemonset-kdns4, kube-system/ calico-node-9hz77, kube-system/    ibm-keepalived-watcher-sh68n, kube-system/ibm-kube-fluentd-bz4ts,
      evicting pod "<pod_name>"
      ...
      pod/<pod_name> evicted
      ...
      node/10.xxx.xx.xxx evicted
      ```
      {: screen}
   2. Reload the worker node. After the worker node reload completes, the DNS caching agent pod handles cluster DNS requests for applicable pods that are running on the worker node. The worker node is also made available for pod scheduling.
      ```
      ibmcloud ks ks worker reload --cluster <cluster_name_or_id> --worker <worker_id>
      ```
      {: pre}
5. Repeat the previous steps for each worker node to enable DNS caching.

### Disable NodeLocal DNS cache (beta)
{: #dns_disablecache}

You can disable the beta feature for one or more worker nodes.
{: shortdesc}

1. [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)
2. **Classic clusters, Kubernetes version 1.15 or 1.16 only**: Drain the worker node to reschedule the pods onto remaining worker nodes in the cluster and to make it unavailable for future pod scheduling.
   ```
   kubectl drain <node_name> --delete-local-data=true --ignore-daemonsets=true --force=true --timeout=5m
   ```
   {: pre}
3. Remove the `ibm-cloud.kubernetes.io/node-local-dns-enabled` label from the worker node. This action terminates the DNS caching agent pod on the worker node.
   ```
   kubectl label node <node_name> "ibm-cloud.kubernetes.io/node-local-dns-enabled-"
   ```
   {: pre}
   1. Verify that the label is removed by checking that the `NODE-LOCAL-DNS-ENABLED` field is empty.
      ```
      kubectl get nodes -L "ibm-cloud.kubernetes.io/node-local-dns-enabled"
      ```
      {: pre}

      Example output:
      ```
      NAME          STATUS                      ROLES    AGE   VERSION       NODE-LOCAL-DNS-ENABLED
      10.xxx.xx.xxx Ready,SchedulingDisabled    <none>   28h   v1.15.1+IKS   
      ```
      {: screen}
   2. Verify that the pod is no longer running on the node where DNS cache is disabled. The output shows no pods.
      ```
      kubectl get pods -n kube-system -l k8s-app=node-local-dns -o wide
      ```
      {: pre}

      Example output:
      ```
      No resources found.
      ```
      {: screen}
4. **Classic clusters, Kubernetes version 1.15 or 1.16 only**: Reload the worker node. After the worker node has been reloaded, pods that run on the node won't use the local DNS cache. Instead, the pods revert to the same behavior that they had before you enabled the beta feature. The worker node is also made available for pod scheduling.
   ```
   ibmcloud ks ks worker reload --cluster <cluster_name_or_id> --worker <worker_id>
   ```
   {: pre}
5.  Repeat the previous steps for each worker node to disable DNS caching.

