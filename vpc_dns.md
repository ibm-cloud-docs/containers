---

copyright:
  years: 2014, 2019
lastupdated: "2019-11-08"

keywords: kubernetes, iks, coredns, dns

subcollection: containers

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
{:preview: .preview}


# Configuring CoreDNS for VPC clusters
{: #vpc_dns}

<img src="images/icon-vpc.png" alt="VPC infrastructure provider icon" width="15" style="width:15px; border-style: none"/> This DNS provider information is specific to VPC clusters. For DNS provider information for classic clusters, see [Configuring the DNS provider for classic clusters](/docs/containers?topic=containers-cluster_dns).
{: note}

Each service in your {{site.data.keyword.containerlong}} cluster is assigned a Domain Name System (DNS) name that the cluster DNS provider registers to resolve DNS requests. All VPC clusters use [CoreDNS ![External link icon](../icons/launch-glyph.svg "External link icon")](https://coredns.io/) as the DNS provider. For more information about DNS for services and pods, see [the Kubernetes documentation ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/).
{: shortdesc}

## Autoscaling CoreDNS
{: #vpc_dns_autoscale}

By default, CoreDNS includes a deployment to autoscale the DNS pods in response to the number of worker nodes and cores within the cluster. You can fine-tune the DNS autoscaler parameters by editing the DNS autoscaling configmap. For example, if your apps heavily use the cluster DNS provider, you might need to increase the minimum number of DNS pods to support the app. For more information, see [the Kubernetes documentation ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/tasks/administer-cluster/dns-horizontal-autoscaling/).
{: shortdesc}

Before you begin: [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

1.  Verify that the CoreDNS deployment is available. In your CLI output, verify that one deployment is **AVAILABLE**.
    ```
    kubectl get deployment -n kube-system | grep dns-autoscaler
    ```
    {: pre}

    Example output:
    ```
    NAME                   DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
    coredns-autoscaler     1         1         1            1           32d
    ```
    {: screen}
2.  Get the name of the configmap for the DNS autoscaler parameters.
    ```
    kubectl get configmap -n kube-system
    ```
    {: pre}
3.  Edit the default settings for the DNS autoscaler. Look for the `data.linear` field, which defaults to one DNS pod per 16 worker nodes or 256 cores, with a minimum of two DNS pods regardless of cluster size (`preventSinglePointFailure: true`). For more information, see [the Kubernetes documentation ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/tasks/administer-cluster/dns-horizontal-autoscaling/#tuning-autoscaling-parameters).
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

## Customizing CoreDNS
{: #vpc_dns_customize}

You can customize CoreDNS by editing the DNS configmap. For example, you might want to configure `stubdomains` and upstream nameservers to resolve services that point to external hosts. Additionally, you can configure multiple [Corefiles ![External link icon](../icons/launch-glyph.svg "External link icon")](https://coredns.io/2017/07/23/corefile-explained/) within the CoreDNS configmap. For more information, see [the Kubernetes documentation ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/).
{: shortdesc}

Before you begin: [Log in to your account. If applicable, target the appropriate resource group. Set the context for your cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

1.  Verify that the CoreDNS deployment is available. In your CLI output, verify that one deployment is **AVAILABLE**.
    ```
    kubectl get deployment -n kube-system | grep dns-autoscaler
    ```
    {: pre}

    Example output:
    ```
    NAME                   DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
    coredns-autoscaler     1         1         1            1           32d
    ```
    {: screen}
2.  Edit the default settings for the CoreDNS configmap. Use a Corefile in the `data` section of the configmap to customize `stubdomains` and upstream nameservers. For more information, see [the Kubernetes documentation ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/#coredns).
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
          abc.com:53 {
              errors
              cache 30
              proxy . 1.2.3.4
          }
          .:53 {
              errors
              health
              kubernetes cluster.local in-addr.arpa ip6.arpa {
                 pods insecure
                 upstream 172.16.0.1
                 fallthrough in-addr.arpa ip6.arpa
              }
              prometheus :9153
              proxy . /etc/resolv.conf
              cache 30
              loop
              reload
              loadbalance
          }
      ```
      {: screen}
3.  Optional: Add custom Corefiles to the CoreDNS configmap. In the following example, include the `import <MyCoreFile>` in the `data.Corefile` section, and fill out the `data.<MyCorefile>` section with your custom Corefile information. For more information, see [the Corefile import documentation ![External link icon](../icons/launch-glyph.svg "External link icon")](https://coredns.io/plugins/import/).
    ```
    kubectl edit configmap -n kube-system coredns
    ```
    {: pre}

    **Custom Corefile example output**:
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
            health
            kubernetes cluster.local in-addr.arpa ip6.arpa {
               pods insecure
               upstream 172.16.0.1
               fallthrough in-addr.arpa ip6.arpa
            }
            prometheus :9153
            proxy . /etc/resolv.conf
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
          proxy . 1.2.3.4
        }
    ```
    {: screen}


