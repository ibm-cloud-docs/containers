---

copyright:
  years: 2014, 2019
lastupdated: "2019-03-21"

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

# 配置集群 DNS 提供程序
{: #cluster_dns}

{{site.data.keyword.containerlong}} 集群中的每个服务都分配有一个域名系统 (DNS) 名称，集群 DNS 提供程序将注册该名称以解析 DNS 请求。根据集群的 Kubernetes 版本，您可以在 Kubernetes DNS (KubeDNS) 或 [CoreDNS ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://coredns.io/) 之间进行选择。有关服务和 pod 的 DNS 的更多信息，请参阅 [Kubernetes 文档 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/)。
{: shortdesc}

**哪些 Kubernetes 版本支持哪个集群 DNS 提供程序？**<br>

|Kubernetes 版本|新集群的缺省 DNS 提供程序|描述|
|---|---|---|
|1.13 和更高版本|CoreDNS|从更低版本的集群更新为 1.13 的集群会保留在更新时使用的任何 DNS 提供程序。如果要使用其他 DNS 提供程序，请[切换 DNS 提供程序](#dns_set)。|
|1.12|KubeDNS|要改为使用 CoreDNS，请[切换 DNS 提供程序](#set_coredns)。|
|1.11 和更低版本|KubeDNS|不能将此 DNS 提供程序切换为 CoreDNS。|
{: caption="按 Kubernetes 版本列出的缺省集群 DNS 提供程序" caption-side="top"}

## 自动缩放集群 DNS 提供程序
{: #dns_autoscale}

缺省情况下，{{site.data.keyword.containerlong_notm}} 集群 DNS 提供程序包含部署，以根据集群中的工作程序节点数和核心数来自动缩放 DNS pod。您可以通过编辑 DNS 自动缩放配置映射来微调 DNS 自动缩放器参数。例如，如果应用程序使用集群 DNS 提供程序十分频繁，那么可能需要增加用于支持应用程序的最小 DNS pod 数。有关更多信息，请参阅 [Kubernetes 文档 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/tasks/administer-cluster/dns-horizontal-autoscaling/)。
{: shortdesc}

开始之前：[登录到您的帐户。将相应的区域和（如果适用）资源组设定为目标。设置集群的上下文](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)。

1.  验证集群 DNS 提供程序部署是否可用。对于在集群中安装的 KubeDNS 和/或 CoreDNS 这两个 DNS 提供程序，您可能有相应的自动缩放器。如果同时安装了这两个 DNS 自动缩放器，请通过查看 CLI 输出中的 **AVAILABLE** 列来查找正在使用的 DNS 自动缩放器。正在使用的部署会列出有 1 个可用部署。
    ```
    kubectl get deployment -n kube-system | grep dns-autoscaler
    ```
    {: pre}
    
    输出示例：
    ```
    NAME                   DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
    coredns-autoscaler     0         0         0            0           32d
    kube-dns-autoscaler    1         1         1            1           260d
    ```
    {: screen}
2.  获取 DNS 自动缩放器参数的配置映射的名称。
    ```
    kubectl get configmap -n kube-system
    ```
    {: pre}    
3.  编辑 DNS 自动缩放器的缺省设置。查找 `data.linear` 字段，其缺省值为每 16 个工作程序节点或每 256 个核心 1 个 DNS pod，无论集群大小，都至少有 2 个 DNS pod (`preventSinglePointFailure: true`)。有关更多信息，请参阅 [Kubernetes 文档 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/tasks/administer-cluster/dns-horizontal-autoscaling/#tuning-autoscaling-parameters)。
```
    kubectl edit configmap -n kube-system <dns-autoscaler>
    ```
    {: pre}
    
    输出示例：
    ```
    apiVersion: v1
    data:
      linear: '{"coresPerReplica":256,"nodesPerReplica":16,"preventSinglePointFailure":true}'
    kind: ConfigMap
    metadata:
    ...
    ```
    {: screen}

## 定制集群 DNS 提供程序
{: #dns_customize}

可以通过编辑 DNS 配置映射来定制 {{site.data.keyword.containerlong_notm}} 集群 DNS 提供程序。例如，您可能希望配置存根域和上游名称服务器来解析指向外部主机的服务。此外，如果使用 CoreDNS，那么可以在 CoreDNS 配置映射中配置多个 [Corefile ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://coredns.io/2017/07/23/corefile-explained/)。有关更多信息，请参阅 [Kubernetes 文档 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/)。
{: shortdesc}

开始之前：[登录到您的帐户。将相应的区域和（如果适用）资源组设定为目标。设置集群的上下文](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)。

1.  验证集群 DNS 提供程序部署是否可用。对于在集群中安装的 KubeDNS 和/或 CoreDNS 这两个 DNS 提供程序，您可能有相应的 DNS 集群提供程序。如果同时安装了这两个 DNS 提供程序，请通过查看 CLI 输出中的 **AVAILABLE** 列来查找正在使用的 DNS 提供程序。正在使用的部署会列出有 1 个可用部署。
    ```
    kubectl get deployment -n kube-system -l k8s-app=kube-dns
    ```
    {: pre}
    
    输出示例：
    ```
    NAME                   DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
    coredns                0         0         0            0           89d
    kube-dns-amd64         2         2         2            2           89d
    ```
    {: screen}
2.  编辑 CoreDNS 或 KubeDNS 配置映射的缺省设置。
    
    *   **对于 CoreDNS**：在配置映射的 `data` 部分中使用 Corefile 来定制存根域和上游名称服务器。有关更多信息，请参阅 [Kubernetes 文档 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/#coredns)。
```
        kubectl edit configmap -n kube-system coredns
        ```
        {: pre}
    
        **CoreDNS 示例输出**：
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
          
          您是否有许多要组织的定制内容？在 Kubernetes V1.12.6_1543 和更高版本中，可以将多个 Corefile 添加到 CoreDNS 配置映射。有关更多信息，请参阅 [Corefile import 文档 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://coredns.io/plugins/import/)。
          {: tip}
          
    *   **对于 KubeDNS**：在配置映射的 `data` 部分中配置存根域和上游名称服务器。有关更多信息，请参阅 [Kubernetes 文档 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/#kube-dns)。
        ```
        kubectl edit configmap -n kube-system kube-dns
        ```
        {: pre}

        **KubeDNS 示例输出**：
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

## 将集群 DNS 提供程序设置为 CoreDNS 或 KubeDNS
{: #dns_set}

如果有运行 Kubernetes V1.12 或更高版本的 {{site.data.keyword.containerlong_notm}} 集群，那么可以选择使用 Kubernetes DNS (KubeDNS) 或 CoreDNS 作为集群 DNS 提供程序。
{: shortdesc}

**开始之前**：
1.  [登录到您的帐户。将相应的区域和（如果适用）资源组设定为目标。设置集群的上下文](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)。
2.  确定当前集群 DNS 提供程序。在以下示例中，KubeDNS 是当前集群 DNS 提供程序。
    ```
    kubectl cluster-info
    ```
    {: pre}

    输出示例：
    ```
    ...
    KubeDNS is running at https://c2.us-south.containers.cloud.ibm.com:20190/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
    ...
    ```
    {: screen}
3.  根据集群使用的 DNS 提供程序，执行用于切换 DNS 提供程序的步骤。
    *  [切换为使用 CoreDNS](#set_coredns)。
    *  [切换为使用 KubeDNS](#set_kubedns)。

### 将 CoreDNS 设置为集群 DNS 提供程序
{: #set_coredns}

将 CoreDNS 而不是 KubeDNS 设置为集群 DNS 提供程序。
{: shortdesc}

1.  如果定制了 KubeDNS 提供程序配置映射或 KubeDNS 自动缩放器配置映射，请将所有定制内容传输到 CoreDNS 配置映射。
    *   对于 `kube-system` 名称空间中的 `kube-dns` 配置映射，请将所有 [DNS 定制内容 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/) 传输到 `kube-system` 名称空间中的 `coredns` 配置映射。请注意，`kube-dns` 和 `coredns` 配置映射的语法不同。有关示例，请参阅 [Kubernetes 文档 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/#coredns-configuration-equivalent-to-kube-dns)。
    *   对于 `kube-system` 名称空间中的 `kube-dns-autoscaler` 配置映射，请将所有 [DNS 自动缩放器定制内容 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/tasks/administer-cluster/dns-horizontal-autoscaling/) 传输到 `kube-system` 名称空间中的 `coredns-autoscaler` 配置映射。请注意，定制内容的语法相同。
2.  缩减 KubeDNS 自动缩放器部署。
    ```
        kubectl scale deployment -n kube-system --replicas=0 kube-dns-autoscaler
        ```
    {: pre}
3.  检查并等待要删除的 pod 显示。
    ```
        kubectl get pods -n kube-system -l k8s-app=kube-dns-autoscaler
        ```
    {: pre}
4.  缩减 KubeDNS 部署。
    ```
        kubectl scale deployment -n kube-system --replicas=0 kube-dns-amd64
        ```
    {: pre}
5.  扩展 CoreDNS 自动缩放器部署。
    ```
        kubectl scale deployment -n kube-system --replicas=1 coredns-autoscaler
        ```
    {: pre}
6.  对集群 DNS 服务进行标记和注释以用于 CoreDNS。
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
7.  **可选**：如果计划使用 Prometheus 从 CoreDNS pod 收集度量值，那么必须向要从中切换的源 `kube-dns` 服务添加度量值端口。
    ```
    kubectl -n kube-system patch svc kube-dns --patch '{"spec": {"ports": [{"name":"metrics","port":9153,"protocol":"TCP"}]}}' --type strategic
    ```
    {: pre}



### 将 KubeDNS 设置为集群 DNS 提供程序
{: #set_kubedns}

将 KubeDNS 而不是 CoreDNS 设置为集群 DNS 提供程序。
{: shortdesc}

1.  如果定制了 CoreDNS 提供程序配置映射或 CoreDNS 自动缩放器配置映射，请将所有定制内容传输到 KubeDNS 配置映射。
    *   对于 `kube-system` 名称空间中的 `coredns` 配置映射，请将所有 [DNS 定制内容 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/) 传输到 `kube-system` 名称空间中的 `kube-dns` 配置映射。请注意，`kube-dns` 和 `coredns` 配置映射的语法不同。有关示例，请参阅 [Kubernetes 文档 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/#coredns-configuration-equivalent-to-kube-dns)。
    *   对于 `kube-system` 名称空间中的 `coredns-autoscaler` 配置映射，请将所有 [DNS 自动缩放器定制内容 ![外部链接图标](../icons/launch-glyph.svg "外部链接图标")](https://kubernetes.io/docs/tasks/administer-cluster/dns-horizontal-autoscaling/) 传输到 `kube-system` 名称空间中的 `kube-dns-autoscaler` 配置映射。请注意，定制内容的语法相同。
2.  缩减 CoreDNS 自动缩放器部署。
    ```
        kubectl scale deployment -n kube-system --replicas=0 coredns-autoscaler
        ```
    {: pre}
3.  检查并等待要删除的 pod 显示。
    ```
        kubectl get pods -n kube-system -l k8s-app=coredns-autoscaler
        ```
    {: pre}
4.  缩减 CoreDNS 部署。
    ```
        kubectl scale deployment -n kube-system --replicas=0 coredns
        ```
    {: pre}
5.  扩展 KubeDNS 自动缩放器部署。
    ```
        kubectl scale deployment -n kube-system --replicas=1 kube-dns-autoscaler
        ```
    {: pre}
6.  对集群 DNS 服务进行标记和注释以用于 KubeDNS。
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
7.  **可选**：如果已使用 Prometheus 从 CoreDNS pod 收集度量值，那么 `kube-dns` 服务具有度量值端口。但是，KubeDNS 并不需要包含此度量值端口，因此您可以从服务中除去该端口。
    ```
    kubectl -n kube-system patch svc kube-dns --patch '{"spec": {"ports": [{"name":"dns","port":53,"protocol":"UDP"},{"name":"dns-tcp","port":53,"protocol":"TCP"}]}}' --type merge
    ```
    {: pre}
