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

# 配置叢集 DNS 提供者
{: #cluster_dns}

{{site.data.keyword.containerlong}} 叢集中的每一個服務都會獲指派一個「網域名稱系統 (DNS)」名稱，叢集 DNS 提供者登錄此名稱來解析 DNS 要求。視您叢集的 Kubernetes 版本而定，您可以選擇 Kubernetes DNS (KubeDNS) 或 [CoreDNS ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://coredns.io/)。如需服務和 Pod 之 DNS 的相關資訊，請參閱 [ Kubernetes 文件 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/)。
{: shortdesc}

**哪些 Kubernetes 版本支援哪些叢集 DNS 提供者？**<br>

| Kubernetes 版本 | 新叢集的預設值 |說明|
|---|---|---|
| 1.13 以及更新版本 |CoreDNS| 從舊版叢集中更新為 1.13 的叢集會保留更新時其所使用的任何 DNS 提供者。如果您想要使用不同的 DNS 提供者，請[切換 DNS 提供者](#dns_set)。|
| 1.12 | KubeDNS | 若要改用 CoreDNS，請[切換 DNS 提供者](#set_coredns)。|
| 1.11 及較舊版本 | KubeDNS | 您無法將 DNS 提供者切換為 CoreDNS。|
{: caption="依 Kubernetes 版本排列的預設叢集 DNS 提供者" caption-side="top"}

## 自動調整叢集 DNS 提供者
{: #dns_autoscale}

依預設，{{site.data.keyword.containerlong_notm}} 叢集 DNS 提供者包括一個部署，可自動調整 DNS Pod，以回應叢集內的工作者節點及核心數目。您可以編輯 DNS 自動調整 configmap，來細部調整 DNS autoscaler 參數。例如，如果您的應用程式大量使用叢集 DNS 提供者，您可能需要增加 DNS Pod 數目下限才能支援此應用程式。如需相關資訊，請參閱 [Kubernetes 文件 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/tasks/administer-cluster/dns-horizontal-autoscaling/)。
{: shortdesc}

開始之前：[登入您的帳戶。將目標設為適當的地區及（如果適用的話）資源群組。設定叢集的環境定義](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)。

1.  驗證是否有可用的叢集 DNS 提供者部署。您可能在叢集中為 KubeDNS、CoreDNS 或這兩個 DNS 提供者安裝了 autoscaler。如果您已安裝 DNS autoscaler，請查看 CLI 輸出中的 **AVAILABLE** 直欄，以找出使用中的那一個。所列出的使用中部署會以 1 個可用部署列出。
    ```
    kubectl get deployment -n kube-system | grep dns-autoscaler
    ```
    {: pre}
    
    輸出範例：
    ```
    NAME                   DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
    coredns-autoscaler     0         0         0            0           32d
    kube-dns-autoscaler    1         1         1            1           260d
    ```
    {: screen}
2.  取得 DNS autoscaler 參數的 configmap 名稱。
    ```
    kubectl get configmap -n kube-system
    ```
    {: pre}    
3.  編輯 DNS autoscaler 的預設值。尋找 `data.linear` 欄位，其預設為每 16 個工作者節點或 256 核心有 1 個 DNS Pod，不論叢集大小為何，至少會有 2 個 DNS Pod (`preventSinglePointFailure: true`)。如需相關資訊，請參閱 [Kubernetes 文件 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/tasks/administer-cluster/dns-horizontal-autoscaling/#tuning-autoscaling-parameters)。
```
    kubectl edit configmap -n kube-system <dns-autoscaler>
    ```
    {: pre}
    
    輸出範例：
    ```
    apiVersion: v1
    data:
      linear: '{"coresPerReplica":256,"nodesPerReplica":16,"preventSinglePointFailure":true}'
    kind: ConfigMap
    metadata:
    ...
    ```
    {: screen}

## 自訂叢集 DNS 提供者
{: #dns_customize}

您可以編輯 DNS configmap，來自訂 {{site.data.keyword.containerlong_notm}} 叢集 DNS 提供者。例如，您可能要配置 stubdomain 及上游名稱伺服器來解析指向外部主機的服務。此外，如果您使用 CoreDNS，則可以在 CoreDNS configmap 內配置多個 [Corefile ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://coredns.io/2017/07/23/corefile-explained/)。如需相關資訊，請參閱 [Kubernetes 文件 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/)。
{: shortdesc}

開始之前：[登入您的帳戶。將目標設為適當的地區及（如果適用的話）資源群組。設定叢集的環境定義](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)。

1.  驗證是否有可用的叢集 DNS 提供者部署。您可能在叢集中為 KubeDNS、CoreDNS 或這兩個 DNS 提供者安裝了 DNS 叢集提供者。如果您已安裝這兩個 DNS 提供者，請查看 CLI 輸出中的 **AVAILABLE** 直欄，以找出使用中的那一個。所列出的使用中部署會以 1 個可用部署列出。
    ```
    kubectl get deployment -n kube-system -l k8s-app=kube-dns
    ```
    {: pre}
    
    輸出範例：
    ```
    NAME                   DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
    coredns                0         0         0            0           89d
    kube-dns-amd64         2         2         2            2           89d
    ```
    {: screen}
2.  編輯 CoreDNS 或 KubeDNS configmap 的預設值。
    
    *   **若為 CoreDNS**：在 configmap 的 `data` 區段中使用 Corefile，來自訂 stubdomain 和上游名稱伺服器。如需相關資訊，請參閱 [Kubernetes 文件 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/#coredns)。
```
        kubectl edit configmap -n kube-system coredns
        ```
        {: pre}
    
        **CoreDNS 範例輸出**：
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
          
          您有許多要組織的自訂作業嗎？在 Kubernetes 1.12.6_1543 版以及更新版本中，您可以將多個 Corefile 新增至 CoreDNS configmap。如需相關資訊，請參閱 [Corefile 匯入文件 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://coredns.io/plugins/import/)。
          {: tip}
          
    *   **若為 KubeDNS**：在 configmap 的 `data` 區段中配置 stubdomain 及上游名稱伺服器。如需相關資訊，請參閱 [Kubernetes 文件 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/#kube-dns)。
```
        kubectl edit configmap -n kube-system kube-dns
        ```
        {: pre}

        **KubeDNS 範例輸出**：
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

## 將叢集 DNS 提供者設為 CoreDNS 或 KubeDNS
{: #dns_set}

如果您有執行 Kubernetes 1.12 版或更新版本的 {{site.data.keyword.containerlong_notm}} 叢集，您可以選擇使用 Kubernetes DNS (KubeDNS) 或 CoreDNS 作為叢集 DNS 提供者。
{: shortdesc}

**開始之前**：
1.  [登入您的帳戶。將目標設為適當的地區及（如果適用的話）資源群組。設定叢集的環境定義](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)。
2.  判定現行叢集 DNS 提供者。在下列範例中，KubeDNS 是現行叢集 DNS 提供者。
    ```
    kubectl cluster-info
    ```
    {: pre}

    輸出範例：
    ```
    ...
    KubeDNS is running at https://c2.us-south.containers.cloud.ibm.com:20190/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
    ...
    ```
    {: screen}
3.  根據您的叢集使用的 DNS 提供者，遵循切換 DNS 提供者的步驟。
    *  [切換為使用 CoreDNS](#set_coredns)。
    *  [切換為使用 KubeDNS](#set_kubedns)。

### 將 CoreDNS 設為叢集 DNS 提供者
{: #set_coredns}

設定 CoreDNS 而非 KubeDNS 作為叢集 DNS 提供者。
{: shortdesc}

1.  如果您已自訂 KubeDNS 提供者 configmap 或 KubeDNS autoscaler configmap，請將任何自訂作業傳送至 CoreDNS configmap。
    *   若為 `kube-system` 名稱空間中的 `kube-dns` configmap，請將任何 [DNS 自訂作業 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/)傳送至 `kube-system` 名稱空間中的 `coredns` configmap。請注意，語法不同於 `kube-dns` 和 `coredns` ConfigMap。如需範例，請參閱 [Kubernetes 文件 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/#coredns-configuration-equivalent-to-kube-dns)。
    *   若為 `kube-system` 名稱空間中的 `kube-dns-autoscaler` configmap，請將任何 [DNS autoscaler 自訂作業 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/tasks/administer-cluster/dns-horizontal-autoscaling/)傳送至 `kube-system` 名稱空間中的 `coredns-autoscaler` configmap。請注意，自訂作業語法均相同。
2.  縮減 KubeDNS autoscaler 部署。
        ```
        kubectl scale deployment -n kube-system --replicas=0 kube-dns-autoscaler
        ```
    {: pre}
3.  檢查並等待刪除 Pod。
        ```
        kubectl get pods -n kube-system -l k8s-app=kube-dns-autoscaler
        ```
    {: pre}
4.  縮減 KubeDNS 部署。
        ```
        kubectl scale deployment -n kube-system --replicas=0 kube-dns-amd64
        ```
    {: pre}
5.  擴增 CoreDNS autoscaler 部署。
        ```
        kubectl scale deployment -n kube-system --replicas=1 coredns-autoscaler
        ```
    {: pre}
6.  標示並註釋 CoreDNS 的叢集 DNS 服務。
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
7.  **選用項目**：如果您計劃使用 Prometheus 從 CoreDNS Pod 收集度量值，則必須將度量埠新增至您從中切換的 `kube-dns` 服務。
    ```
    kubectl -n kube-system patch svc kube-dns --patch '{"spec": {"ports": [{"name":"metrics","port":9153,"protocol":"TCP"}]}}' --type strategic
    ```
    {: pre}



### 將 KubeDNS 設為叢集 DNS 提供者
{: #set_kubedns}

設定 KubeDNS 而非 CoreDNS 作為叢集 DNS 提供者。
{: shortdesc}

1.  如果您已自訂 CoreDNS 提供者 configmap 或 CoreDNS autoscaler configmap，請將任何自訂作業傳送至 KubeDNS configmap。
    *   若為 `kube-system` 名稱空間中的 `coredns` configmap，請將任何 [DNS 自訂作業 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/)傳送至 `kube-system` 名稱空間中的 `kube-dns` configmap。請注意，語法不同於 `kube-dns` 和 `coredns` ConfigMap。如需範例，請參閱 [Kubernetes 文件 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/#coredns-configuration-equivalent-to-kube-dns)。
    *   若為 `kube-system` 名稱空間中的 `coredns-autoscaler` configmap，請將任何 [DNS autoscaler 自訂作業 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/tasks/administer-cluster/dns-horizontal-autoscaling/)傳送至 `kube-system` 名稱空間中的 `kube-dns-autoscaler` configmap。請注意，自訂作業語法均相同。
2.  縮減 CoreDNS autoscaler 部署。
    ```
    kubectl scale deployment -n kube-system --replicas=0 coredns-autoscaler
    ```
    {: pre}
3.  檢查並等待刪除 Pod。
    ```
    kubectl get pods -n kube-system -l k8s-app=coredns-autoscaler
    ```
    {: pre}
4.  縮減 CoreDNS 部署。
    ```
    kubectl scale deployment -n kube-system --replicas=0 coredns
    ```
    {: pre}
5.  擴增 KubeDNS autoscaler 部署。
    ```
    kubectl scale deployment -n kube-system --replicas=1 kube-dns-autoscaler
    ```
    {: pre}
6.  標示並註釋 KubeDNS 的叢集 DNS 服務。
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
7.  **選用項目**：如果您已使用 Prometheus 從 CoreDNS Pod 收集度量值，則 `kube-dns` 服務具有度量埠。不過，KubeDNS 並不需要包含此度量埠，因此您可以從服務中移除該埠。
    ```
    kubectl -n kube-system patch svc kube-dns --patch '{"spec": {"ports": [{"name":"dns","port":53,"protocol":"UDP"},{"name":"dns-tcp","port":53,"protocol":"TCP"}]}}' --type merge
    ```
    {: pre}
