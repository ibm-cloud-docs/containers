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


# 使用受管理 Istio 附加程式（測試版）
{: #istio}

Istio on {{site.data.keyword.containerlong}} 提供 Istio 的無縫安裝、Istio 控制平面元件的自動更新及生命週期管理，以及與平台記載和監視工具的整合。
{: shortdesc}

只要按一下，您就可以取得所有 Istio 核心元件、額外的追蹤、監視和視覺化，以及啟動並執行 BookInfo 範例應用程式。Istio on {{site.data.keyword.containerlong_notm}} 是以受管理附加程式形式提供，因此 {{site.data.keyword.Bluemix_notm}} 會自動保持所有 Istio 元件的最新狀態。

## 瞭解 Istio on {{site.data.keyword.containerlong_notm}}
{: #istio_ov}

### 何謂 Istio？
{: #istio_ov_what_is}

[Istio ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/cloud/info/istio) 是一種開放服務網平台，能夠連接、保護、控制及觀察雲端平台上的微服務，例如 {{site.data.keyword.containerlong_notm}} 中的 Kubernetes。
{:shortdesc}

當您將龐大的應用程式移至分散式微服務架構時，就會產生一組新的挑戰，例如如何控制微服務的資料流量、對服務執行摸黑啟動和 Canary 推出、處理失敗、保護服務通訊、觀察服務，以及跨服務機隊強制執行一致的存取原則。若要解決這些困難，您可以運用服務網。服務網提供透通且與語言無關的網路，用於連接、觀察、保護及控制微服務之間的連線功能。Istio 透過容許您管理網路資料流量、跨微服務的負載平衡、強制執行存取原則、驗證服務身分等等，來提供服務網的見解及控制。

例如，在微服務網中使用 Istio 可協助您：
- 更輕鬆地看到叢集中執行的應用程式
- 部署 Canary 版本的應用程式，並控制傳送給它們的資料流量
- 啟用在微服務之間傳送之資料的自動加密
- 強制執行速率限制及屬性型白名單和黑名單原則

Istio 服務網由資料平面及控制平面組成。資料平面由每個應用程式 Pod 中的 Envoy Proxy Sidecar 組成，這會調解微服務之間的通訊。控制平面由 Pilot、Mixer 遙測和原則以及 Citadel 組成，以將 Istio 配置套用至叢集。如需其中每個元件的相關資訊，請參閱 [`istio` 附加程式說明](#istio_components)。

### 何謂 Istio on {{site.data.keyword.containerlong_notm}}（測試版）？
{: #istio_ov_addon}

Istio on {{site.data.keyword.containerlong_notm}} 是以受管理附加程式形式提供，可直接整合 Istio 與 Kubernetes 叢集。
{: shortdesc}

**這在我的叢集中看起來像什麼？**</br>
當您安裝 Istio 附加程式時，Istio 控制項及資料平面會使用您叢集已連接的 VLAN。配置資料流量會流經叢集內的專用網路，且不需要您在防火牆中開啟任何其他埠或 IP 位址。如果您使用 Istio Gateway 公開 Istio 受管理應用程式，則對應用程式提出的外部資料流量要求會流經公用 VLAN。

**更新處理程序如何運作？**</br>
受管理附加程式中的 Istio 版本是透過 {{site.data.keyword.Bluemix_notm}} 進行測試，並核准用於 {{site.data.keyword.containerlong_notm}}。此外，Istio 附加程式還會簡化 Istio 控制平面的維護，讓您可以著重於如何管理微服務。{{site.data.keyword.Bluemix_notm}} 會自動推出 {{site.data.keyword.containerlong_notm}} 所支援之最新 Istio 版本的更新項目，以保持所有 Istio 元件都是最新狀態。  

如果您需要使用最新 Istio 版本或自訂 Istio 安裝，則可以遵循 [{{site.data.keyword.Bluemix_notm}} 快速入門指導教學 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://istio.io/docs/setup/kubernetes/quick-start-ibm/) 中的步驟，來安裝 Istio 的開放程式碼版本。
{: tip}

**有任何限制嗎？** </br>
如果您已在叢集中安裝[容器映像檔安全強制執行程式許可控制器](/docs/services/Registry?topic=registry-security_enforce#security_enforce)，則無法在叢集中啟用受管理 Istio 附加程式。

<br />


## 我可以安裝什麼？
{: #istio_components}

在叢集中，Istio on {{site.data.keyword.containerlong_notm}} 是以三個受管理附加程式形式提供。
{: shortdesc}

<dl>
<dt>Istio (`istio`)</dt>
<dd>安裝 Istio 的核心元件，包括 Prometheus。如需下列任何控制平面元件的相關資訊，請參閱 [Istio 文件 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://istio.io/docs/concepts/what-is-istio)。
  <ul><li>`Envoy` 會對服務網中所有服務的入埠和出埠資料流量進行 Proxy 處理。在與應用程式容器相同的 Pod 中，會將 Envoy 部署為 Sidecar 容器。</li>
  <li>`Mixer` 提供遙測收集和原則控制。<ul>
    <li>使用 Prometheus 端點來啟用遙測 Pod，此端點會聚集應用程式 Pod 中來自 Envoy Proxy Sidecar 和服務的所有遙測資料。</li>
    <li>原則 Pod 會強制執行存取控制，包括限制與套用白名單和黑名單原則的速率。</li></ul>
  </li>
  <li>`Pilot` 提供 Envoy Sidecar 的服務探索，以及配置 Sidecar 的資料流量管理遞送規則。</li>
  <li>`Citadel` 使用身分及認證管理來提供服務對服務和一般使用者鑑別。</li>
  <li>`Galley` 驗證其他 Istio 控制平面元件的配置變更。</li>
</ul></dd>
<dt>Istio extras (`istio-extras`)</dt>
<dd>選用項目：安裝 [Grafana ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://grafana.com/)、[Jaeger ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.jaegertracing.io/) 及 [Kiali ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.kiali.io/)，以提供額外的 Istio 監視、追蹤及視覺化。</dd>
<dt>BookInfo 範例應用程式 (`istio-sample-bookinfo`)</dt>
<dd>選用項目：部署 [Istio 的 BookInfo 範例應用程式 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://istio.io/docs/examples/bookinfo/)。此部署包括基礎展示設定及預設目的地規則，因此，您可以立即試用 Istio 的功能。</dd>
</dl>

<br>
您一律可以藉由執行下列指令，來查看叢集中已啟用的 Istio 附加程式：
```
ibmcloud ks cluster-addons --cluster <cluster_name_or_ID>
```
{: pre}

`istio` 受管理附加程式可以安裝到可用的叢集。若要同時安裝 `istio-extras` 和 `istio-sample-bookinfo` 附加程式，請建立至少有兩個工作者節點的標準叢集。
{: note}

<br />


## 安裝 Istio on {{site.data.keyword.containerlong_notm}}
{: #istio_install}

請在現有叢集中安裝 Istio 受管理附加程式。
{: shortdesc}

**開始之前**</br>
* 確定您具有 {{site.data.keyword.containerlong_notm}} 的 [**Writer** 或 **Manager** {{site.data.keyword.Bluemix_notm}}IAM 服務角色](/docs/containers?topic=containers-users#platform)。
* [將 CLI 的目標設為現有 1.10 或更新版本的叢集](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)。
* 如果您先前使用 IBM Helm 圖表或透過另一種方法在叢集中安裝 Istio，請[清除該 Istio 安裝](#istio_uninstall_other)。

### 在 CLI 中安裝受管理 Istio 附加程式
{: #istio_install_cli}

1. 啟用 `istio` 附加程式。
  ```
  ibmcloud ks cluster-addon-enable istio --cluster <cluster_name_or_ID>
  ```
  {: pre}

2. 選用項目：啟用 `istio-extras` 附加程式。
  ```
  ibmcloud ks cluster-addon-enable istio-extras --cluster <cluster_name_or_ID>
  ```
  {: pre}

3. 選用項目：啟用 `istio-sample-bookinfo` 附加程式。
  ```
  ibmcloud ks cluster-addon-enable istio-sample-bookinfo --cluster <cluster_name_or_ID>
  ```
  {: pre}

4. 驗證此叢集中已啟用您所安裝的受管理 Istio 附加程式。
  ```
  ibmcloud ks cluster-addons --cluster <cluster_name_or_ID>
  ```
  {: pre}

  輸出範例：
  ```
  Name                      Version
  istio                     1.0.5
  istio-extras              1.0.5
  istio-sample-bookinfo     1.0.5
  ```
  {: screen}

5. 您也可以查看叢集中每個附加程式的個別元件。
  - `istio` 和 `istio-extras` 的元件：確定已部署 Istio 服務及其對應的 Pod。
    ```
    kubectl get svc -n istio-system
    ```
    {: pre}

    ```
    NAME                     TYPE           CLUSTER-IP       EXTERNAL-IP                                                                    AGE
    grafana                  ClusterIP      172.21.98.154    <none>          3000/TCP                                                       2m
    istio-citadel            ClusterIP      172.21.221.65    <none>          8060/TCP,9093/TCP                                              2m
    istio-egressgateway      ClusterIP      172.21.46.253    <none>          80/TCP,443/TCP                                                 2m
    istio-galley             ClusterIP      172.21.125.77    <none>          443/TCP,9093/TCP                                               2m
    istio-ingressgateway     LoadBalancer   172.21.230.230   169.46.56.125   80:31380/TCP,443:31390/TCP,31400:31400/TCP,5011:31323/TCP,
                                                                              8060:32483/TCP,853:32628/TCP,15030:31601/TCP,15031:31915/TCP   2m
    istio-pilot              ClusterIP      172.21.171.29    <none>          15010/TCP,15011/TCP,8080/TCP,9093/TCP                          2m
    istio-policy             ClusterIP      172.21.140.180   <none>          9091/TCP,15004/TCP,9093/TCP                                    2m
    istio-sidecar-injector   ClusterIP      172.21.248.36    <none>          443/TCP                                                        2m
    istio-telemetry          ClusterIP      172.21.204.173   <none>          9091/TCP,15004/TCP,9093/TCP,42422/TCP                          2m
    jaeger-agent             ClusterIP      None             <none>          5775/UDP,6831/UDP,6832/UDP                                     2m
    jaeger-collector         ClusterIP      172.21.65.195    <none>          14267/TCP,14268/TCP                                            2m
    jaeger-query             ClusterIP      172.21.171.199   <none>          16686/TCP                                                      2m
    kiali                    ClusterIP      172.21.13.35     <none>          20001/TCP                                                      2m
    prometheus               ClusterIP      172.21.105.229   <none>          9090/TCP                                                       2m
    tracing                  ClusterIP      172.21.125.177   <none>          80/TCP                                                         2m
    zipkin                   ClusterIP      172.21.1.77      <none>          9411/TCP                                                       2m
    ```
    {: screen}

    ```
    kubectl get pods -n istio-system
    ```
    {: pre}

    ```
    NAME                                      READY   STATUS    RESTARTS   AGE
    grafana-76dcdfc987-94ldq                  1/1     Running   0          2m
    istio-citadel-869c7f9498-wtldz            1/1     Running   0          2m
    istio-egressgateway-69bb5d4585-qxxbp      1/1     Running   0          2m
    istio-galley-75d7b5bdb9-c9d9n             1/1     Running   0          2m
    istio-ingressgateway-5c8764db74-gh8xg     1/1     Running   0          2m
    istio-pilot-55fd7d886f-vv6fb              2/2     Running   0          2m
    istio-policy-6bb6f6ddb9-s4c8t             2/2     Running   0          2m
    istio-sidecar-injector-7d9845dbb7-r8nq5   1/1     Running   0          2m
    istio-telemetry-7695b4c4d4-tlvn8          2/2     Running   0          2m
    istio-tracing-55bbf55878-z4rd2            1/1     Running   0          2m
    kiali-77566cc66c-kh6lm                    1/1     Running   0          2m
    prometheus-5d5cb44877-lwrqx               1/1     Running   0          2m
    ```
    {: screen}

  - `istio-sample-bookinfo` 的元件：確定已部署 BookInfo 微服務及其對應的 Pod。
    ```
    kubectl get svc -n default
    ```
    {: pre}

    ```
    NAME                      TYPE           CLUSTER-IP       EXTERNAL-IP    PORT(S)          AGE
    details                   ClusterIP      172.21.19.104    <none>         9080/TCP         2m
    productpage               ClusterIP      172.21.168.196   <none>         9080/TCP         2m
    ratings                   ClusterIP      172.21.11.131    <none>         9080/TCP         2m
    reviews                   ClusterIP      172.21.117.164   <none>         9080/TCP         2m
    ```
    {: screen}

    ```
    kubectl get pods -n default
    ```
    {: pre}

    ```
    NAME                                     READY     STATUS      RESTARTS   AGE
    details-v1-6865b9b99d-7v9h8              2/2       Running     0          2m
    productpage-v1-f8c8fb8-tbsz9             2/2       Running     0          2m
    ratings-v1-77f657f55d-png6j              2/2       Running     0          2m
    reviews-v1-6b7f6db5c5-fdmbq              2/2       Running     0          2m
    reviews-v2-7ff5966b99-zflkv              2/2       Running     0          2m
    reviews-v3-5df889bcff-nlmjp              2/2       Running     0          2m
    ```
    {: screen}

### 在使用者介面中安裝受管理 Istio 附加程式
{: #istio_install_ui}

1. 在[叢集儀表板 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://cloud.ibm.com/containers-kubernetes/clusters) 中，按一下 1.10 版或更新版本叢集的名稱。

2. 按一下**附加程式**標籤。

3. 在 Istio 卡上，按一下**安裝**。

4. 已選取 **Istio** 勾選框。若要同時安裝 Istio extras 及 BookInfo 範例應用程式，請選取 **Istio Extras** 和 **Istio 範例**勾選框。

5. 按一下**安裝**。

6. 在 Istio 卡上，驗證已列出您所啟用的附加程式。

接下來，您可以查看 [BookInfo 範例應用程式](#istio_bookinfo)來試用 Istio 的功能。

<br />


## 試用 BookInfo 範例應用程式
{: #istio_bookinfo}

BookInfo 附加程式 (`istio-sample-bookinfo`) 會將 [Istio 的 BookInfo 範例應用程式 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://istio.io/docs/examples/bookinfo/) 部署至 `default` 名稱空間。此部署包括基礎展示設定及預設目的地規則，因此，您可以立即試用 Istio 的功能。
{: shortdesc}

四個 BookInfo 微服務包括：
* `productpage` 會呼叫 `details` 和 `reviews` 微服務以移入頁面。
* `details` 包含書籍資訊。
* `reviews` 包含書籍檢閱，並呼叫 `ratings` 微服務。
* `ratings` 包含隨附書籍檢閱的書籍分級資訊。

`reviews` 微服務具有多個版本：
* `v1` 不會呼叫 `ratings` 微服務。
* `v2` 會呼叫 `ratings` 微服務，並將評等顯示為 1 到 5 顆黑色星星。
* `v3` 會呼叫 `ratings` 微服務，並將評等顯示為 1 到 5 顆紅色星星。

會修改其中每個微服務的部署 YAML，先將 Envoy Sidecar Proxy 以容器形式預先注入微服務的 Pod，再予以部署。如需手動 Sidecar 注入的相關資訊，請參閱 [Istio 文件 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://istio.io/docs/setup/kubernetes/sidecar-injection/)。BookInfo 應用程式也已透過 Istio Gateway 公開於公用 IP Ingress 位址。請注意，雖然 BookInfo 應用程式可協助您開始使用，但應用程式不適用於正式作業。

開始之前，請在叢集中[安裝 `istio`、`istio-extras` 及 `istio-sample-bookinfo` 受管理附加程式](#istio_install)。

1. 取得叢集的公用位址。
  * 標準叢集：
      2. 設定 Ingress 主機。
            ```
            export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
            ```
        {: pre}

      3. 設定 Ingress 埠。
            ```
            export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')
            ```
        {: pre}

      4. 建立一個使用 Ingress 主機及埠的 `GATEWAY_URL` 環境變數。
         ```
         export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT
         ```
         {: pre}

  * 免費叢集：
      1. 設定 Ingress 主機。此主機是叢集中任何工作者節點的公用 IP 位址。
        ```
        export INGRESS_HOST=$(kubectl get nodes -o jsonpath='{.items[0].status.addresses[?(@.type=="ExternalIP")].address}')
        ```
        {: pre}

      2. 設定 Ingress 埠。
        ```
        export INGRESS_PORT=$(kubectl get svc istio-ingressgateway -n istio-system -o jsonpath='{.spec.ports[0].nodePort}')
        ```
        {: pre}

      3. 建立一個使用工作者節點的公用 IP 位址和 NodePort 的 GATEWAY_URL 環境變數。
         ```
         export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT
         ```
         {: pre}

2. 對 `GATEWAY_URL` 變數進行 Curl 處理，以確認 BookInfo 應用程式正在執行中。`200` 回應表示 BookInfo 應用程式與 Istio 適當地執行中。
   ```
   curl -o /dev/null -s -w "%{http_code}\n" http://${GATEWAY_URL}/productpage
   ```
   {: pre}

3.  在瀏覽器中檢視 BookInfo 網頁。

    若為 Mac OS 或 Linux：
    ```
    open http://$GATEWAY_URL/productpage
    ```
    {: pre}

    若為 Windows：
    ```
    start http://$GATEWAY_URL/productpage
    ```
    {: pre}

4. 嘗試多次重新整理頁面。不同版本的檢閱區段會循環使用紅色星星、黑色星星及無任何星星。

### 瞭解發生什麼情況
{: #istio_bookinfo_understanding}

BookInfo 範例示範三種 Istio 的資料流量管理元件如何一起運作，以將 Ingress 資料流量遞送至應用程式。
{: shortdesc}

<dl>
<dt>`Gateway`</dt>
<dd>`bookinfo-gateway` [Gateway ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://istio.io/docs/reference/config/istio.networking.v1alpha3/#Gateway) 說明負載平衡器（`istio-system` 名稱空間中的 `istio-ingressgateway` 服務），用來作為 BookInfo HTTP/TCP 資料流量的 Ingress 進入點。Istio 會配置負載平衡器，以在閘道配置檔中定義的埠上接聽 Istio 受管理應用程式的送入要求。
</br></br>若要查看 BookInfo 閘道的配置檔，請執行下列指令。
<pre class="pre"><code>kubectl get gateway bookinfo-gateway -o yaml</code></pre></dd>

<dt>`VirtualService`</dt>
<dd>`bookinfo` [`VirtualService` ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://istio.io/docs/reference/config/istio.networking.v1alpha3/#VirtualService) 藉由將微服務定義為 `destinations`，來定義控制如何在服務網內遞送要求的規則。在 `bookinfo` 虛擬服務中，會透過埠 `9080` 將要求的 `/productpage` URI 遞送至 `productpage` 主機。因此，所有對 BookInfo 應用程式的要求都會先遞送至 `productpage` 微服務，此微服務接著會呼叫其他 BookInfo 微服務。
</br></br>若要查看套用至 BookInfo 的虛擬服務規則，請執行下列指令。
<pre class="pre"><code>kubectl get virtualservice bookinfo -o yaml</code></pre></dd>

<dt>`DestinationRule`</dt>
<dd>閘道根據虛擬服務規則來遞送要求之後，`details`、`productpage`、`ratings` 及 `reviews` [`DestinationRule` ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://istio.io/docs/reference/config/istio.networking.v1alpha3/#DestinationRule) 會定義在要求到達微服務時所套用的原則。例如，當您重新整理 BookInfo 產品頁面時，所看到的變更是隨機呼叫不同 `reviews` 微服務版本（`v1`、`v2` 及 `v3`）的 `productpage` 微服務結果。隨機選取版本，因為 `reviews` 目的地規則會針對微服務的 `subsets` 或具名版本提供相同的加權。將資料流量遞送至特定版本的服務時，虛擬服務規則即會使用這些子集。
</br></br>若要查看套用至 BookInfo 的目的地規則，請執行下列指令。
<pre class="pre"><code>kubectl describe destinationrules</code></pre></dd>
</dl>

</br>

接下來，您可以[使用 IBM 提供的 Ingress 子網域來公開 BookInfo](#istio_expose_bookinfo)，或是[記載、監視、追蹤及視覺化](#istio_health) BookInfo 應用程式的服務網。

<br />


## 記載、監視、追蹤及視覺化 Istio on {{site.data.keyword.containerlong_notm}}
{: #istio_health}

若要記載、監視、追蹤及視覺化 Istio on {{site.data.keyword.containerlong_notm}} 所管理的應用程式，您可以啟動 `istio-extras` 附加程式中所安裝的 Grafana、Jaeger 及 Kiali 儀表板，或將 LogDNA 及 Sysdig 以協力廠商服務形式部署至工作者節點。
{: shortdesc}

### 啟動 Grafana、Jaeger 及 Kiali 儀表板
{: #istio_health_extras}

Istio extras 附加程式 (`istio-extras`) 會安裝 [Grafana ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://grafana.com/)、[Jaeger ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.jaegertracing.io/) 及 [Kiali ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.kiali.io/)。啟動其中每個服務的儀表板，為 Istio 提供額外的監視、追蹤及視覺化。
{: shortdesc}

開始之前，請在叢集中[安裝 `istio` 及 `istio-extras` 受管理附加程式](#istio_install)。

**Grafana**</br>
1. 啟動 Grafana 儀表板的 Kubernetes 埠轉遞。
  ```
  kubectl -n istio-system port-forward $(kubectl -n istio-system get pod -l app=grafana -o jsonpath='{.items[0].metadata.name}') 3000:3000 &
  ```
  {: pre}

2. 若要開啟 Istio Grafana 儀表板，請移至下列 URL：http://localhost:3000/dashboard/db/istio-mesh-dashboard。如果您已安裝 [BookInfo 附加程式](#istio_bookinfo)，則 Istio 儀表板會顯示您在重新整理產品頁面數次後所產生的資料流量度量值。如需使用 Istio Grafana 儀表板的相關資訊，請參閱 Istio 開放程式碼文件中的[檢視 Istio 儀表板 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://istio.io/docs/tasks/telemetry/using-istio-dashboard/)。

**Jaeger**</br>
1. 啟動 Jaeger 儀表板的 Kubernetes 埠轉遞。
  ```
  kubectl -n istio-system port-forward $(kubectl -n istio-system get pod -l app=jaeger -o jsonpath='{.items[0].metadata.name}') 16686:16686 &
  ```
  {: pre}

2. 若要開啟 Jaeger 使用者介面，請移至下列 URL：http://localhost:16686。

3. 如果您已安裝 [BookInfo 附加程式](#istio_bookinfo)，則可以從**服務**清單中選取 `productpage`，然後按一下**尋找追蹤**。即會顯示您在重新整理產品頁面數次後所產生的資料流量追蹤資料。如需搭配使用 Jaeger 與 Istio 的相關資訊，請參閱 Istio 開放程式碼文件中的[使用 BookInfo 範例產生追蹤資料 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://istio.io/docs/tasks/telemetry/distributed-tracing/#generating-traces-using-the-bookinfo-sample)。

**Kiali**</br>
1. 啟動 Kiali 儀表板的 Kubernetes 埠轉遞。
  ```
  kubectl -n istio-system port-forward $(kubectl -n istio-system get pod -l app=kiali -o jsonpath='{.items[0].metadata.name}') 20001:20001 &
  ```
  {: pre}

2. 若要開啟 Kiali 使用者介面，請移至下列 URL：http://localhost:20001。

3. 針對使用者名稱和通行詞組，輸入 `admin`。如需使用 Kiali 視覺化 Istio 受管理微服務的相關資訊，請參閱 Istio 開放程式碼文件中的[產生服務圖形 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://istio.io/docs/tasks/telemetry/kiali/#generating-a-service-graph)。

### 使用 {{site.data.keyword.la_full_notm}} 設定記載
{: #istio_health_logdna}

將 LogDNA 部署至工作者節點以將日誌轉遞給 {{site.data.keyword.loganalysislong}}，來無縫管理每個 Pod 中應用程式容器和 Envoy Proxy Sidecar 容器的日誌。
{: shortdesc}

若要使用 [{{site.data.keyword.la_full}}](/docs/services/Log-Analysis-with-LogDNA?topic=LogDNA-about)，您可以將記載代理程式部署至叢集中的每個工作者節點。此代理程式會從所有名稱空間（包括 `kube-system`）收集副檔名為 `*.log` 的日誌，以及 Pod 的 `/var/log` 目錄中所儲存的無副檔名檔案。這些日誌包括來自每個 Pod 中應用程式容器和 Envoy Proxy Sidecar 容器的日誌。代理程式接著會將日誌轉遞至 {{site.data.keyword.la_full_notm}} 服務。

若要開始，請遵循[使用 {{site.data.keyword.la_full_notm}} 管理 Kubernetes 叢集日誌](/docs/services/Log-Analysis-with-LogDNA/tutorials?topic=LogDNA-kube#kube)中的步驟，來設定叢集的 LogDNA。




### 使用 {{site.data.keyword.mon_full_notm}} 設定監視
{: #istio_health_sysdig}

取得 Istio 受管理應用程式效能及性能的作業可見性，方法是將 Sysdig 部署至工作者節點，以將度量值轉遞至 {{site.data.keyword.monitoringlong}}。
{: shortdesc}

使用 Istio on {{site.data.keyword.containerlong_notm}}，受管理 `istio` 附加程式即會將 Prometheus 安裝至叢集。叢集中的 `istio-mixer-telemetry` Pod 標註有 Prometheus 端點，讓 Prometheus 可以聚集 Pod 的所有遙測資料。當您將 Sysdig 代理程式部署至叢集中的每個工作者節點時，即已自動啟用 Sysdig 來偵測及提取來自這些 Prometheus 端點的資料，以將它們顯示在 {{site.data.keyword.Bluemix_notm}} 監視儀表板中。

因為所有 Prometheus 工作都已完成，所以您只需要在叢集中部署 Sysdig 即可。

1. 遵循[分析 Kubernetes 叢集中所部署應用程式的度量值](/docs/services/Monitoring-with-Sysdig/tutorials?topic=Sysdig-kubernetes_cluster#kubernetes_cluster)中的步驟，來設定 Sysdig。

2. [啟動 Sysdig 使用者介面 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](/docs/services/Monitoring-with-Sysdig/tutorials?topic=Sysdig-kubernetes_cluster#kubernetes_cluster_step3)。

3. 按一下**新增儀表板**。

4. 搜尋 `Istio`，然後選取 Sysdig 的其中一個預先定義 Istio 儀表板。

如需參照度量值和儀表板、監視 Istio 內部元件以及監視 Istio A/B 部署和 Canary 部署的相關資訊，請參閱 Sysdig 部落格文章：[如何監視 Istio（Kubernetes 服務網）![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://sysdig.com/blog/monitor-istio/)。請尋找稱為「監視 Istio：參照度量值及儀表板」的小節。

<br />


## 設定應用程式的 Sidecar 注入
{: #istio_sidecar}

準備好使用 Istio 來管理自己的應用程式了嗎？部署應用程式之前，您必須先決定要如何將 Envoy Proxy Sidecar 注入應用程式 Pod。
{: shortdesc}

每個應用程式 Pod 都必須執行 Envoy Proxy Sidecar，以將微服務內含在服務網中。您可以確定自動或手動將 Sidecar 注入每個應用程式 Pod。如需 Sidecar 注入的相關資訊，請參閱 [Istio 文件 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://istio.io/docs/setup/kubernetes/sidecar-injection/)。

### 啟用自動 Sidecar 注入
{: #istio_sidecar_automatic}

啟用自動 Sidecar 注入時，名稱空間會接聽任何新的部署，並自動修改部署 YAML 以新增 Sidecar。當您打算將要與 Istio 整合的多個應用程式部署至名稱空間時，請針對該名稱空間啟用自動 Sidecar 注入。請注意，依預設，不會針對 Istio 受管理附加程式中的任何名稱空間啟用自動 Sidecar 注入。

若要啟用名稱空間的自動 Sidecar 注入，請執行下列動作：

1. 取得您要在其中部署 Istio 受管理應用程式的名稱空間名稱。
  ```
   kubectl get namespaces
   ```
  {: pre}

2. 將名稱空間標示為 `istio-injection=enabled`。
  ```
  kubectl label namespace <namespace> istio-injection=enabled
  ```
  {: pre}

3. 將應用程式部署至所標示的名稱空間，或重新部署已在名稱空間中的應用程式。
  * 若要將應用程式部署至所標示的名稱空間，請執行下列指令：
    ```
    kubectl apply <myapp>.yaml --namespace <namespace>
    ```
    {: pre}
  * 若要重新部署已部署在該名稱空間的應用程式，請刪除應用程式 Pod，以使用注入的 Sidecar 重新予以部署。
    ```
    kubectl delete pod -l app=<myapp>
    ```
    {: pre}

5. 如果您尚未建立用來公開應用程式的服務，請建立 Kubernetes 服務。您的應用程式必須由 Kubernetes 服務公開，才能併入為 Istio 服務網中的微服務。請確定您遵循 [Pod 及服務的 Istio 需求 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://istio.io/docs/setup/kubernetes/spec-requirements/)。

  1. 定義應用程式的服務。
    ```
              apiVersion: v1
          kind: Service
          metadata:
            name: myappservice
          spec:
            selector:
              <selector_key>: <selector_value>
            ports:
       - protocol: TCP
         port: 8080
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解服務 YAML 檔案元件</th>
    </thead>
    <tbody>
    <tr>
    <td><code>selector</code></td>
    <td>輸入標籤索引鍵 (<em>&lt;selector_key&gt;</em>) 及值 (<em>&lt;selector_value&gt;</em>) 配對，您想要用來將應用程式執行所在的 Pod 設為目標。</td>
     </tr>
     <tr>
     <td><code>port</code></td>
     <td>服務所接聽的埠。</td>
     </tr>
     </tbody></table>

  2. 在叢集裡建立服務。請確定服務會部署至與應用程式相同的名稱空間。
    ```
    kubectl apply -f myappservice.yaml -n <namespace>
    ```
    {: pre}

應用程式 Pod 現在已整合至您的 Istio 服務網，因為它們的 Istio Sidecar 容器與您的應用程式容器並排執行 。

### 手動注入 Sidecar
{: #istio_sidecar_manual}

如果您不要在名稱空間上啟用自動 Sidecar 注入，則可以手動將 Sidecar 注入部署 YAML。當應用程式在與您不要自動注入 Sidecar 的其他部署並排的名稱空間中執行時，請手動注入 Sidecar。

若要手動將 Sidecar 注入部署，請執行下列動作：

1. 下載 `istioctl` 用戶端。
  ```
       curl -L https://git.io/getLatestIstio | sh -
       ```

2. 導覽至 Istio 套件目錄。
  ```
  cd istio-1.0.6
  ```
  {: pre}

3. 將 Envoy Sidecar 注入應用程式部署 YAML。
  ```
  istioctl kube-inject -f <myapp>.yaml | kubectl apply -f -
  ```
  {: pre}

4. 部署應用程式。
  ```
  kubectl apply <myapp>.yaml
  ```
  {: pre}

5. 如果您尚未建立用來公開應用程式的服務，請建立 Kubernetes 服務。您的應用程式必須由 Kubernetes 服務公開，才能併入為 Istio 服務網中的微服務。請確定您遵循 [Pod 及服務的 Istio 需求 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://istio.io/docs/setup/kubernetes/spec-requirements/)。

  1. 定義應用程式的服務。
    ```
              apiVersion: v1
          kind: Service
          metadata:
            name: myappservice
          spec:
            selector:
              <selector_key>: <selector_value>
            ports:
       - protocol: TCP
         port: 8080
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解服務 YAML 檔案元件</th>
    </thead>
    <tbody>
    <tr>
    <td><code>selector</code></td>
    <td>輸入標籤索引鍵 (<em>&lt;selector_key&gt;</em>) 及值 (<em>&lt;selector_value&gt;</em>) 配對，您想要用來將應用程式執行所在的 Pod 設為目標。</td>
     </tr>
     <tr>
     <td><code>port</code></td>
     <td>服務所接聽的埠。</td>
     </tr>
     </tbody></table>

  2. 在叢集裡建立服務。請確定服務會部署至與應用程式相同的名稱空間。
    ```
    kubectl apply -f myappservice.yaml -n <namespace>
    ```
    {: pre}

應用程式 Pod 現在已整合至您的 Istio 服務網，因為它們的 Istio Sidecar 容器與您的應用程式容器並排執行 。

<br />


## 使用 IBM 提供的 Ingress 子網域來公開 Istio 受管理應用程式
{: #istio_expose}

[設定 Envoy Proxy Sidecar 注入](#istio_sidecar)並將應用程式部署至 Istio 服務網之後，您可以使用 IBM 提供的 Ingress 子網域，將 Istio 受管理應用程式公開到公用要求。
{: shortdesc}

{{site.data.keyword.containerlong_notm}} ALB 使用 Kubernetes Ingress 資源來控制資料流量如何遞送至應用程式。不過，Istio 會使用 [Gateway ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://istio.io/docs/reference/config/istio.networking.v1alpha3/#Gateway) 及 [VirtualService ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://istio.io/docs/reference/config/istio.networking.v1alpha3/#VirtualService) 來控制資料流量如何遞送至應用程式。閘道會配置負載平衡器，以用來作為 Istio 受管理應用程式的進入點。虛擬服務會定義遞送規則，以將資料流量適當地轉遞至應用程式微服務。

在標準叢集中，會自動將 IBM 提供的 Ingress 子網域指派給叢集，讓您可以公然地公開應用程式。您可以運用此子網域的 DNS 項目，將預設 {{site.data.keyword.containerlong_notm}} ALB 連接至 Istio Ingress 閘道，以公開 Istio 受管理應用程式。

您可以先試用[使用 IBM 提供的 Ingress 子網域來公開 BookInfo 的範例](#istio_expose_bookinfo)，或[藉由連接 Istio 閘道和 Ingress ALB 公然地公開自己的 Istio 受管理應用程式](#istio_expose_link)。

### 範例：使用 IBM 提供的 Ingress 子網域來公開 BookInfo
{: #istio_expose_bookinfo}

在叢集中啟用 [BookInfo 附加程式](#istio_bookinfo)時，會為您建立 Istio 閘道 `bookinfo-gateway`。該閘道使用 Istio 虛擬服務及目的地規則來配置公然地公開 BookInfo 應用程式的負載平衡器 `istio-ingressgateway`。在下列步驟中，您會建立 Kubernetes Ingress 資源，以將 {{site.data.keyword.containerlong_notm}} Ingress ALB 的送入要求轉遞至 `istio-ingressgateway` 負載平衡器。
{: shortdesc}

開始之前，請在叢集中[啟用 `istio` 及 `istio-sample-bookinfo` 受管理附加程式](#istio_install)。

1. 針對叢集取得 IBM 提供的 Ingress 子網域。如果您要使用 TLS，也請記下輸出中 IBM 提供的 Ingress TLS 密碼。
  ```
  ibmcloud ks cluster-get --cluster <cluster_name_or_ID> | grep Ingress
  ```
  {: pre}

  輸出範例：
  ```
  Ingress Subdomain:      mycluster-12345.us-south.containers.appdomain.cloud
  Ingress Secret:         mycluster-12345
  ```
  {: screen}

2. 建立 Ingress 資源。{{site.data.keyword.containerlong_notm}} ALB 會使用此資源中定義的規則，將資料流量轉遞至公開 Istio 受管理應用程式的 Istio 負載平衡器。
  ```
  apiVersion: extensions/v1beta1
  kind: Ingress
  metadata:
    name: myingressresource
    namespace: istio-system
  spec:
    tls:
    - hosts:
      - bookinfo.<IBM-ingress-domain>
      secretName: <tls_secret_name>
    rules:
    - host: bookinfo.<IBM-ingress-domain>
      http:
        paths:
        - path: /
          backend:
            serviceName: istio-ingressgateway
            servicePort: 80
  ```
  {: codeblock}

  <table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
  </thead>
  <tbody>
  <tr>
  <td><code>tls.hosts</code></td>
  <td>若要使用 TLS，請將 <em>&lt;IBM-ingress-domain&gt;</em> 取代為 IBM 提供的 Ingress 子網域。請注意，`bookinfo` 會附加到 IBM 提供的 Ingress 子網域的前面。依預設，會針對叢集登錄 IBM 提供的 Ingress 子網域萬用字元 <code>*.&lt;cluster_name&gt;.&lt;region&gt;.containers.appdomain.cloud</code>。</td>
  </tr>
  <tr>
  <td><code>tls.secretName</code></td>
  <td>將 <em>&lt;tls_secret_name&gt;</em> 取代為 IBM 提供的 Ingress 密碼名稱。IBM 提供的 TLS 憑證是萬用字元憑證，可用於萬用字元子網域。<td>
  </tr>
  <tr>
  <td><code>host</code></td>
  <td>將 <em>&lt;IBM-ingress-domain&gt;</em> 取代為 IBM 提供的 Ingress 子網域。請注意，`bookinfo` 會附加到 IBM 提供的 Ingress 子網域的前面。</td>
  </tr>
  <tr>
  <td><code>serviceName</code></td>
  <td>請注意，服務名稱是 <code>istio-ingressgateway</code>，因此 ALB 會將來自此子網域的要求轉遞至 Istio 負載平衡器服務。</td>
  </tr>
  </tbody></table>

3. 建立 Ingress 資源。
  ```
  kubectl apply -f myingressresource.yaml -n istio-system
  ```
  {: pre}

4. 在 Web 瀏覽器中，開啟 BookInfo 產品頁面。
  - 如果您已啟用 TLS，請執行下列指令：
    ```
    https://bookinfo.<IBM-ingress-domain>/productpage
    ```
    {: codeblock}
  - 如果您未啟用 TLS，請執行下列指令：
    ```
    http://bookinfo.<IBM-ingress-domain>/productpage
    ```
    {: codeblock}

5. 嘗試多次重新整理頁面。對 `http://bookinfo.<IBM-domain>/productpage` 提出的要求會由 ALB 接收，並且轉遞至 Istio 閘道負載平衡器。仍然會隨機傳回不同的 `reviews` 微服務版本，因為 Istio 閘道會管理微服務的虛擬服務及目的地遞送規則。

如需 BookInfo 應用程式的閘道、虛擬服務規則及目的地規則的相關資訊，請參閱[瞭解發生什麼情況](#istio_bookinfo_understanding)。

### 藉由連接 Istio 閘道和 Ingress ALB 公然地公開自己的 Istio 受管理應用程式
{: #istio_expose_link}

連接 Istio 閘道和 {{site.data.keyword.containerlong_notm}} ALB，將 IBM 提供的 Ingress 子網域用於 Istio 受管理應用程式。下列步驟顯示如何設定 Istio 閘道、建立虛擬服務來定義 Istio 受管理服務的資料流量管理規則，以及配置 {{site.data.keyword.containerlong_notm}} Ingress ALB，以將資料流量從 IBM 提供的 Ingress 子網域導向 `istio-ingressgateway` 負載平衡器。
{: shortdesc}

開始之前：
1. 在叢集中[安裝 `istio` 受管理附加程式](#istio_install)。
2. 安裝 `istioctl` 用戶端。
  1. 下載 `istioctl`。
    ```
       curl -L https://git.io/getLatestIstio | sh -
       ```
  2. 導覽至 Istio 套件目錄。
    ```
    cd istio-1.0.6
    ```
    {: pre}
3. [設定應用程式微服務的 Sidecar 注入、將應用程式微服務部署至名稱空間，以及建立應用程式微服務的 Kubernetes 服務，以將它們併入 Istio 服務網](#istio_sidecar)。

若要連接 Istio 閘道和 {{site.data.keyword.containerlong_notm}} ALB，請執行下列動作：

1. 建立閘道。此範例閘道使用 `istio-ingressgateway` 負載平衡器服務來公開埠 80，以用於 HTTP。將 `<namespace>` 取代為在其中部署 Istio 受管理微服務的名稱空間。如果微服務接聽的不是埠 `80`，請新增該埠。如需閘道 YAML 元件的相關資訊，請參閱 [Istio 參考文件 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://istio.io/docs/reference/config/istio.networking.v1alpha3/#Gateway)。
  ```
  apiVersion: networking.istio.io/v1alpha3
  kind: Gateway
  metadata:
    name: my-gateway
    namespace: <namespace>
  spec:
    selector:
      istio: ingressgateway
    servers:
    - port:
        name: http
        number: 80
        protocol: HTTP
      hosts:
      - '*'
  ```
  {: codeblock}

2. 在其中部署 Istio 受管理微服務的名稱空間中，套用閘道。
  ```
  kubectl apply -f my-gateway.yaml -n <namespace>
  ```
  {: pre}

3. 建立虛擬服務，以使用 `my-gateway` 閘道並定義應用程式微服務的遞送規則。如需虛擬服務 YAML 元件的相關資訊，請參閱 [Istio 參考文件 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://istio.io/docs/reference/config/istio.networking.v1alpha3/#VirtualService)。

  如果您已使用 {{site.data.keyword.containerlong_notm}} ALB 公開微服務，則 Istio 會提供轉換器工具作為 `istioctl` 用戶端的一部分，此用戶端可協助您將 Ingress 資源定義移轉至對應的虛擬服務。[`istioctl` 轉換器工具 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://istio.io/docs/reference/commands/istioctl/#istioctl-experimental-convert-ingress) 會根據最佳效能將 Ingress 資源轉換為虛擬服務。請注意，不會轉換 Ingress 註釋，因為 Istio 閘道不會使用 Ingress 註釋。輸出是 Istio Ingress 配置的起始點，而且可能需要進行一些修改。若要使用此工具，請執行下列指令：`istioctl experimental convert-ingress -f <existing_ingress_resource>.yaml > my-virtual-service.yaml`
  {: tip}

  ```
  apiVersion: networking.istio.io/v1alpha3
  kind: VirtualService
  metadata:
    name: my-virtual-service
    namespace: <namespace>
  spec:
    gateways:
    - my-gateway
    hosts:
    - '*'
    http:
    - match:
      - uri:
          exact: /<service_path>
      route:
      - destination:
          host: <service_name>
          port:
            number: 80
  ```
  {: codeblock}

  <table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
  </thead>
  <tbody>
  <tr>
  <td><code>namespace</code></td>
  <td>將 <em>&lt;namespace&gt;</em> 取代為在其中部署 Istio 受管理微服務的名稱空間。</td>
  </tr>
  <tr>
  <td><code>gateways</code></td>
  <td>請注意，已指定 <code>my-gateway</code>，讓閘道可以將這些虛擬服務遞送規則套用至 Istio 負載平衡器。<td>
  </tr>
  <tr>
  <td><code>http.match.uri.exact</code></td>
  <td>將 <em>&lt;service_path&gt;</em> 取代為進入點微服務所接聽的路徑。例如，在 BookInfo 應用程式中，路徑會定義為 <code>/productpage</code>。</td>
  </tr>
  <tr>
  <td><code>http.route.destination.host</code></td>
  <td>將 <em>&lt;service_name&gt;</em> 取代為進入點微服務的名稱。例如，在 BookInfo 應用程式中，<code>productpage</code> 作為已呼叫其他應用程式微服務的進入點微服務。</td>
  </tr>
  <tr>
  <td><code>http.route.destination.port.number</code></td>
  <td>如果微服務接聽不同的埠，請將 <em>&lt;80&gt;</em> 取代為該埠。</td>
  </tr>
  </tbody></table>

4. 在其中部署 Istio 受管理微服務的名稱空間中，套用虛擬服務規則。
  ```
  kubectl apply -f my-virtual-service.yaml -n <namespace>
  ```
  {: pre}

5. 選用項目：若要建立將資料流量遞送至每個微服務之後所套用的規則（例如，將資料流量傳送至某個微服務的不同版本的規則），您可以建立並套用 [`DestinationRule` ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://istio.io/docs/reference/config/istio.networking.v1alpha3/#DestinationRule)。

6. 建立 Ingress 資源檔。{{site.data.keyword.containerlong_notm}} ALB 會使用此範例資源中定義的規則，將資料流量轉遞至公開 Istio 受管理微服務的 Istio 負載平衡器。
  ```
  apiVersion: extensions/v1beta1
  kind: Ingress
  metadata:
    name: my-ingress-resource
    namespace: istio-system
  spec:
    rules:
    - host: <sub-domain>.<IBM-ingress-domain>
      http:
        paths:
        - path: /
          backend:
            serviceName: istio-ingressgateway
            servicePort: 80
  ```
  {: codeblock}

  <table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
  </thead>
  <tbody>
  <tr>
  <td><code>host</code></td>
  <td>將 <em>&lt;sub-domain&gt;</em> 取代為應用程式的子網域，並將 <em>&lt;IBM-ingress-domain&gt;</em> 取代為 IBM 提供的 Ingress 子網域。您可以執行 <code>ibmcloud ks cluster-get --cluster &lt;cluster_name_or_ID&gt;</code>，針對叢集尋找 IBM 提供的 Ingress 子網域。自動登錄您選擇的子網域，因為依預設會針對叢集登錄 IBM 提供的 Ingress 子網域萬用字元 <code>*.&lt;cluster_name&gt;.&lt;region&gt;.containers.appdomain.cloud</code>。</td>
  </tr>
  <tr>
  <td><code>serviceName</code></td>
  <td>請注意，已指定 <code>istio-ingressgateway</code>，因此 ALB 會將送入的要求轉遞至 Istio 負載平衡器服務。</td>
  </tr>
  </tbody></table>

7. 在其中部署 Istio 受管理微服務的名稱空間中，套用 Ingress 資源。
  ```
  kubectl apply -f my-ingress-resource.yaml -n <namespace>
  ```
  {: pre}

8. 在 Web 瀏覽器中，輸入要存取的應用程式微服務的 URL，驗證已將資料流量遞送至 Istio 受管理微服務。
  ```
  http://<subdomain>.<IBM-ingress-domain>/<service_path>
  ```
  {: codeblock}

<br />


## 解除安裝 Istio on {{site.data.keyword.containerlong_notm}}
{: #istio_uninstall}

如果您完成使用 Istio，則可以解除安裝 Istio 附加程式，以清除叢集中的 Istio 資源。
{:shortdesc}

請注意，`istio` 附加程式是 `istio-extras`、`istio-sample-bookinfo` 及 [`knative`](/docs/containers?topic=containers-knative_tutorial) 附加程式的相依項。`istio-extras` 附加程式是 `istio-sample-bookinfo` 附加程式的相依項。

### 在 CLI 中解除安裝受管理 Istio 附加程式
{: #istio_uninstall_cli}

1. 停用 `istio-sample-bookinfo` 附加程式。
  ```
  ibmcloud ks cluster-addon-disable istio-sample-bookinfo --cluster <cluster_name_or_ID>
  ```
  {: pre}

2. 停用 `istio-extras` 附加程式。
  ```
  ibmcloud ks cluster-addon-disable istio-extras --cluster <cluster_name_or_ID>
  ```
  {: pre}

3. 停用 `istio` 附加程式。
  ```
  ibmcloud ks cluster-addon-disable istio --cluster <cluster_name_or_ID> -f
  ```
  {: pre}

4. 驗證在此叢集中已停用所有受管理 Istio 附加程式。輸出中未傳回任何 Istio 附加程式。
  ```
  ibmcloud ks cluster-addons --cluster <cluster_name_or_ID>
  ```
  {: pre}

### 在使用者介面中解除安裝受管理 Istio 附加程式
{: #istio_uninstall_ui}

1. 在[叢集儀表板 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://cloud.ibm.com/containers-kubernetes/clusters) 中，按一下 1.10 版或更新版本叢集的名稱。

2. 按一下**附加程式**標籤。

3. 在 Istio 卡上，按一下功能表圖示。

4. 解除安裝個別或所有 Istio 附加程式。
  - 個別 Istio 附加程式：
    1. 按一下**更新**。
    2. 清除您要停用之附加程式的勾選框。如果您清除附加程式，則可能會自動清除其他需要該附加程式作為相依項的附加程式。
    3. 按一下**更新**。已停用 Istio 附加程式，而且會從此叢集中移除這些附加程式的資源。
  - 所有 Istio 附加程式：
    1. 按一下**解除安裝**。即會停用此叢集中的所有受管理 Istio 附加程式，而且會移除此叢集中的所有 Istio 資源。

5. 在 Istio 卡上，驗證不再列出您已解除安裝的附加程式。

<br />


### 解除安裝叢集中的其他 Istio 安裝
{: #istio_uninstall_other}

如果您先前使用 IBM Helm 圖表或透過另一種方法在叢集中安裝 Istio，請先清除該 Istio 安裝，再啟用叢集中的受管理 Istio 附加程式。若要檢查 Istio 是否已在叢集中，請執行 `kubectl get namespaces`，並在輸出中尋找 `istio-system` 名稱空間。
{: shortdesc}

- 如果您是使用 {{site.data.keyword.Bluemix_notm}} Istio Helm 圖表來安裝 Istio，請執行下列動作：
  1. 解除安裝 Istio Helm 部署。
    ```
    helm del istio --purge
    ```
    {: pre}

  2. 如果您是使用 Helm 2.9 或更早版本，請刪除額外的工作資源。
    ```
      kubectl -n istio-system delete job --all
      ```
    {: pre}

- 如果您是手動安裝 Istio，或使用 Istio 社群 Helm 圖表，請參閱 [Istio 解除安裝文件 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://istio.io/docs/setup/kubernetes/quick-start/#uninstall-istio-core-components)。
* 如果您先前在叢集中安裝了 BookInfo，請清除那些資源。
  1. 切換至 Istio 檔案位置的目錄。
       ```
    cd <filepath>/istio-1.0.5
    ```
    {: pre}

  2. 刪除叢集裡的所有 BookInfo 服務、Pod 及部署。
    ```
    samples/bookinfo/platform/kube/cleanup.sh
    ```
    {: pre}

## 下一步為何？
{: #istio_next}

* 若要進一步探索 Istio，您可以在 [Istio 文件 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://istio.io/) 中找到更多手冊。
    * [Intelligent Routing ![外部鏈結圖示 ](../icons/launch-glyph.svg "外部鏈結圖示")](https://istio.io/docs/guides/intelligent-routing.html)：此範例顯示如何使用 Istio 的資料流量管理功能，將資料流量遞送至特定版本之 BookInfo 的檢閱及評等微服務。
    * [In-Depth Telemetry ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://istio.io/docs/guides/telemetry.html)：此範例包括如何使用 Istio Mixer 及 Envoy Proxy 來取得 BookInfo 微服務的統一度量值、日誌及追蹤。
* 取得[認知類別：使用 Istio 及 IBM Cloud Kubernetes Service 來開始使用微服務 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://cognitiveclass.ai/courses/get-started-with-microservices-istio-and-ibm-cloud-container-service/)。**附註**：您可以跳過本課程的 Istio 安裝一節。
* 請參閱此部落格文章，其描述如何使用 [Istio ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://itnext.io/vistio-visualize-your-istio-mesh-using-netflixs-vizceral-b075c402e18e) 來視覺化您的 Istio 服務網。
