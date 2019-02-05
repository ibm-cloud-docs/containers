---

copyright:
  years: 2014, 2019
lastupdated: "2019-02-05"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:note: .note}
{:important: .important}
{:deprecated: .deprecated}
{:download: .download}


## Setting the cluster DNS provider to CoreDNS or KubeDNS
{: #cluster_dns}

Each service in your cluster is assigned a Domain Name System (DNS) name that the cluster DNS provider registers to resolve DNS requests. Depending on the Kubernetes version of your cluster, you might choose between Kubernetes DNS (KubeDNS) or [CoreDNS ![External link icon](../icons/launch-glyph.svg "External link icon")](https://coredns.io/). For more information about DNS for services and pods, see [the Kubernetes documentation ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/).
{: shortdesc}

**What Kubernetes versions support what cluster DNS provider?**<br>

| Kubernetes Version | Default for new clusters | Description |
|---|---|---|
| 1.13 and later | CoreDNS | Clusters that are updated to 1.13 from an earlier cluster keep whatever DNS provider they used at the time of the update. If you want to use a different one, [switch the DNS provider](#dns_set). |
| 1.12 | KubeDNS | To use CoreDNS instead, [switch the DNS provider](#set_coredns). |
| 1.11 and earlier | KubeDNS | You cannot switch the DNS provider to CoreDNS. |
{: caption="Default cluster DNS provider by Kubernetes version" caption-side="top"}

## Autoscaling the cluster DNS provider
{: #dns_autoscale}

By default, your cluster DNS provider includes a deployment to autoscale the DNS pods in response to the number of worker nodes and cores within the cluster. You can finetune the DNS autoscaler parameters by editing the DNS autoscaling configmap. For more information, see [the Kubernetes documentation ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/tasks/administer-cluster/dns-horizontal-autoscaling/).
{: shortdesc}

1.  Verify that the cluster DNS provider deployment is available. You might have the autoscaler for the KubeDNS, the CoreDNS, or both DNS providers installed in your cluster. If you have both DNS autoscalers installed, find the one that is in use by looking at the **AVAILABLE** column in your CLI output. The deployment that is in use is listed with 1 available deployment.
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
3.  Edit the default settings for the DNS autoscaler. Look for the `data.linear` field, which defaults to 1 DNS pod per 16 worker nodes or 256 cores. For more information, see [the Kubernetes documentation ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/tasks/administer-cluster/dns-horizontal-autoscaling/#tuning-autoscaling-parameters).
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

## Customing the cluster DNS provider
{: #dns_customize}

You can customize the cluster DNS provider by editing the DNS configmap. For example, you might want to configure stubdomains and upstream nameservers. Additionally, if you use CoreDNS, you can configure multiple [Corefiles ![External link icon](../icons/launch-glyph.svg "External link icon")](https://coredns.io/2017/07/23/corefile-explained/) within the CoreDNS configmap. For more information, see [the Kubernetes documentation ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/).
{: shortdesc}

1.  Verify that the cluster DNS provider deployment is available. You might have the autoscaler for the KubeDNS, the CoreDNS, or both DNS providers installed in your cluster. If you have both DNS autoscalers installed, find the one that is in use by looking at the **AVAILABLE** column in your CLI output. The deployment that is in use is listed with 1 available deployment.
    ```
    kubectl get deployment -n kube-system | grep dns
    ```
    {: pre}
    
    Example output:
    ```
    NAME                   DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
    coredns                0         0         0            0           33d
    kube-dns-amd64         2         2         2            2           260d
    ```
    {: screen}
2.  Get the name of the configmap for the cluster DNS provider.
    ```
    kubectl get configmap -n kube-system
    ```
    {: pre}    
3.  Edit the default settings for the CoreDNS or KubeDNS configmap.
    
    *   **For CoreDNS**: Use multiple Corefiles in the `data` section of the configmap to customize stubdomains and upstream nameservers. For more information, see [the Kubernetes documentation ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/#coredns).
        ```
        kubectl edit configmap -n kube-system coredns
        ```
        {: pre}
    
        Example output:
        ```
        apiVersion: v1
        kind: ConfigMap
        metadata:
          name: coredns
          namespace: kube-system
        data:
          Corefile: |
            .:53 {
                errors
                health
                kubernetes cluster.local in-addr.arpa ip6.arpa {
                   pods insecure
                   upstream 172.16.0.1
                   fallthrough in-addr.arpa ip6.arpa
                }
                prometheus :9153
                proxy . 172.16.0.1
                cache 30
                loop
                reload
                loadbalance
            }
            consul.local:53 {
                errors
                cache 30
                proxy . 10.150.0.1
            }
        ```
        {: screen}
    *   **For KubeDNS**: Configure stubdomains and upstream nameservers in the `data` section of the configmap. For more information, see [the Kubernetes documentation ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/#kube-dns).
        ```
        kubectl edit configmap -n kube-system kube-dns
        ```
        {: pre}

        Example output:
        ```
        apiVersion: v1
        kind: ConfigMap
        metadata:
          name: kube-dns
          namespace: kube-system
        data:
          stubDomains: |
          {"acme.local": ["1.2.3.4"]}
          upstreamNameservers: |
          ["8.8.8.8", "8.8.4.4"]
        ```
        {: screen}

## Setting the cluster DNS provider to CoreDNS or KubeDNS
{: #dns_set}

Depending on the Kubernetes version of your cluster, you can choose to use Kubernetes DNS (KubeDNS) or CoreDNS as the cluster DNS provider.
{: shortdesc}

**Before you begin**:
1.  [Log in to your account. Target the appropriate region and, if applicable, resource group. Set the context for your cluster](cs_cli_install.html#cs_cli_configure).
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

Set up CoreDNS instead of KubeDNS as the cluster DNS provider. If you have a new cluster that runs Kubernetes version 1.13 or later, your cluster comes with CoreDNS by default.
{: shortdesc}

1.  **Optional**: If you customized the `kube-dns` configmap in the `kube-system` namespace, transfer any customizations to the `coredns` configmap in the `kube-system` namespace. Note that the syntax differs from the `kube-dns` and `coredns` configmaps. For an example, see [Installing CoreDNS via Kubeadm ![External link icon](../icons/launch-glyph.svg "External link icon")](https://coredns.io/2018/05/21/migration-from-kube-dns-to-coredns/) in the CoreDNS docs.

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

4.  Scale down the KubeDNS deployment.
    ```
    kubectl scale deployment -n kube-system --replicas=0 kube-dns-amd64
    ```
    {: pre}

5.  Scale up the CoreDNS autoscaler deployment.
    ```
    kubectl scale deployment -n kube-system --replicas=1 coredns-autoscaler
    ```
    {: pre}

6.  Label and annotate the cluster DNS service for CoreDNS.
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
7.  **Optional**: If you plan to use Prometheus to collect metrics from the CoreDNS pods, you must add a metrics port to the `kube-dns` service that you are switching from.
    ```
    kubectl -n kube-system patch svc kube-dns --patch '{"spec": {"ports": [{"name":"metrics","port":9153,"protocol":"TCP"}]}}' --type strategic
    ```
    {: pre}


### Setting up KubeDNS as the cluster DNS provider
{: #set_kubedns}

In clusters that run Kubernetes version 1.12 or later, you can use KubeDNS instead of CoreDNS as the cluster DNS provider. For example, version 1.12 clusters use KubeDNS by default, but you might have changed to CoreDNS and want to revert back to KubeDNS.
{: shortdesc}

1.  **Optional**: If you customized the `coredns` configmap in the `kube-system` namespace, transfer any customizations to the `kube-dns` configmap in the `kube-system` namespace. Note that the syntax differs from the `kube-dns` and `coredns` configmaps. For an example, see [Installing CoreDNS via Kubeadm ![External link icon](../icons/launch-glyph.svg "External link icon")](https://coredns.io/2018/05/21/migration-from-kube-dns-to-coredns/) in the CoreDNS docs.

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

4.  Scale down the CoreDNS deployment.
    ```
    kubectl scale deployment -n kube-system --replicas=0 coredns
    ```
    {: pre}

5.  Scale up the KubeDNS autoscaler deployment.
    ```
    kubectl scale deployment -n kube-system --replicas=1 kube-dns-autoscaler
    ```
    {: pre}

6.  Label and annotate the cluster DNS service for KubeDNS.
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
7.  **Optional**: If you used Prometheus to collect metrics from the CoreDNS pods, your `kube-dns` service had a metrics port. However, KubeDNS does not need to include this metrics port so you can remove the port from the service.
    ```
    kubectl -n kube-system patch svc kube-dns --patch '{"spec": {"ports": [{"name":"dns","port":53,"protocol":"UDP"},{"name":"dns-tcp","port":53,"protocol":"TCP"}]}}' --type merge
    ```
    {: pre}
