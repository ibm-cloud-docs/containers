---

copyright:
  years: 2014, 2018
lastupdated: "2018-09-11"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}



# 指導教學：在 {{site.data.keyword.containerlong_notm}} 上安裝 Istio
{: #istio_tutorial}

[Istio ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/cloud/info/istio) 是一種開放平台，能夠連接、保護、控制及觀察雲端平台上的服務，例如 {{site.data.keyword.containerlong}} 中的 Kubernetes。使用 Istio，您可以管理網路資料流量、微服務之間的負載平衡、強制執行存取原則、驗證服務身分等等。
{:shortdesc}

在本指導教學中，您可以看到如何為一個稱為 BookInfo 的簡單模擬書店應用程式，一起安裝 Istio 及四個微服務。微服務包括產品網頁、書籍詳細資料、檢閱及評等。將 BookInfo 的微服務部署至已安裝 Istio 的 {{site.data.keyword.containerlong}} 叢集時，即會在每一個微服務的 Pod 中注入 Istio Envoy Sidecar Proxy。

## 目標

-   在您的叢集裡部署 Istio Helm 圖表
-   部署 BookInfo 範例應用程式
-   驗證 BookInfo 應用程式部署並循環使用三個版本的評等服務

## 所需時間

30 分鐘

## 適用對象

本指導教學的適用對象是第一次使用 Istio 的軟體開發人員及網路管理者。

## 必要條件

-  [安裝 IBM Cloud CLI、{{site.data.keyword.containerlong_notm}} 外掛程式及 Kubernetes CLI](cs_cli_install.html#cs_cli_install_steps)。Istio 需要 Kubernetes 1.9 版或以上版本。請務必安裝符合叢集之 Kubernetes 版本的 `kubectl` CLI 版本。
-  [建立執行 Kubernetes 1.9 版或更新版本](cs_clusters.html#clusters_cli)的叢集，或[將現有叢集更新至 1.9 版](cs_versions.html#cs_v19)。
-  [將 CLI 的目標設為叢集](cs_cli_install.html#cs_cli_configure)。

## 課程 1：下載並安裝 Istio
{: #istio_tutorial1}

在叢集裡下載並安裝 Istio。
{:shortdesc}

1. 使用 [IBM Istio Helm 圖表 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://console.bluemix.net/containers-kubernetes/solutions/helm-charts/ibm/ibm-istio) 來安裝 Istio。
    1. [在叢集中設定 Helm，並將 IBM 儲存庫新增至 Helm 實例](cs_integrations.html#helm)。
    2.  **僅限 Helm 2.9 版或更早版本**：安裝 Istio 的自訂資源定義。
        ```
        kubectl apply -f https://raw.githubusercontent.com/IBM/charts/master/stable/ibm-istio/templates/crds.yaml
        ```
        {: pre}
    3. 將 Helm 圖表安裝至您的叢集。
        ```
        helm install ibm/ibm-istio --name=istio --namespace istio-system
        ```
        {: pre}

2. 在繼續之前，確定已完全部署適用於 9 Istio 服務及 Prometheus 的 Pod。
    ```
    kubectl get pods -n istio-system
    ```
    {: pre}

    ```
    NAME                                       READY     STATUS      RESTARTS   AGE
    istio-citadel-748d656b-pj9bw               1/1       Running     0          2m
    istio-egressgateway-6c65d7c98d-l54kg       1/1       Running     0          2m
    istio-galley-65cfbc6fd7-bpnqx              1/1       Running     0          2m
    istio-ingressgateway-f8dd85989-6w6nj       1/1       Running     0          2m
    istio-pilot-5fd885964b-l4df6               2/2       Running     0          2m
    istio-policy-56f4f4cbbd-2z2bk              2/2       Running     0          2m
    istio-sidecar-injector-646655c8cd-rwvsx    1/1       Running     0          2m
    istio-statsd-prom-bridge-7fdbbf769-8k42l   1/1       Running     0          2m
    istio-telemetry-8687d9d745-mwjbf           2/2       Running     0          2m
    prometheus-55c7c698d6-f4drj                1/1       Running     0          2m
    ```
    {: screen}

做得好！您已順利將 Istio 安裝至叢集。接下來，請將 BookInfo 範例應用程式部署至您的叢集。


## 課程 2：部署 BookInfo 應用程式
{: #istio_tutorial2}

將 BookInfo 範例應用程式的微服務部署至 Kubernetes 叢集。
{:shortdesc}

這四個微服務包括產品網頁、書籍詳細資料、檢閱（含數個版本的檢閱微服務）及評等。當您部署 BookInfo 時，會先將 Envoy Sidecar Proxy 當成容器注入至應用程式微服務的 Pod，再部署微服務 Pod。Istio 會使用延伸版本的 Envoy Proxy 來調解服務網中所有微服務的所有入埠及出埠資料流量。如需 Envoy 的相關資訊，請參閱 [Istio 文件 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://istio.io/docs/concepts/what-is-istio/overview/#envoy)。

1. 下載包含必要 BookInfo 檔案的 Istio 套件。
    1. 直接從 [https://github.com/istio/istio/releases ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://github.com/istio/istio/releases) 下載 Istio，並解壓縮安裝檔案，或使用 cURL 取得最新版本：
       ```
       curl -L https://git.io/getLatestIstio | sh -
       ```
       {: pre}

    2. 切換至 Istio 檔案位置的目錄。
       ```
       cd <filepath>/istio-1.0
       ```
       {: pre}

    3. 將 `istioctl` 用戶端新增至 PATH。例如，在 MacOS 或 Linux 系統上執行下列指令：
       ```
       export PATH=$PWD/istio-1.0/bin:$PATH
       ```
        {: pre}

2. 使用 `istio-injection=enabled` 來標示 `default` 名稱空間。
    ```
    kubectl label namespace default istio-injection=enabled
    ```
    {: pre}

3. 部署 BookInfo 應用程式。部署應用程式微服務時，也會將 Envoy Sidecar 部署在每一個微服務 Pod 中。

   ```
   kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml
   ```
   {: pre}

4. 確定已部署微服務及其對應的 Pod：
    ```
    kubectl get svc
    ```
    {: pre}

    ```
    NAME                      TYPE           CLUSTER-IP       EXTERNAL-IP    PORT(S)          AGE
    details                   ClusterIP      172.21.19.104    <none>         9080/TCP         1m
    productpage               ClusterIP      172.21.168.196   <none>         9080/TCP         1m
    ratings                   ClusterIP      172.21.11.131    <none>         9080/TCP         1m
    reviews                   ClusterIP      172.21.117.164   <none>         9080/TCP         1m
    ```
    {: screen}

    ```
    kubectl get pods
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

5. 若要驗證應用程式部署，請取得叢集的公用位址。
    * 標準叢集：
        1. 若要在公用 Ingress IP 上公開您的應用程式，請部署 BookInfo 閘道。
            ```
            kubectl apply -f samples/bookinfo/networking/bookinfo-gateway.yaml
            ```
            {: pre}

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
        1. 取得叢集裡任何工作者節點的公用 IP 位址。
            ```
            ibmcloud ks workers <cluster_name_or_ID>
            ```
            {: pre}

        2. 建立 GATEWAY_URL 環境變數，其會使用工作者節點的公用 IP 位址。
            ```
            export GATEWAY_URL=<worker_node_public_IP>:$(kubectl get svc istio-ingressgateway -n istio-system -o jsonpath='{.spec.ports[0].nodePort}')
            ```
            {: pre}

5. 對 `GATEWAY_URL` 變數進行 Curl 處理，以確認 BookInfo 應用程式正在執行中。`200` 回應表示 BookInfo 應用程式與 Istio 適當地執行中。
     ```
     curl -o /dev/null -s -w "%{http_code}\n" http://${GATEWAY_URL}/productpage
     ```
     {: pre}

6.  在瀏覽器中檢視 BookInfo 網頁。

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

7. 嘗試多次重新整理頁面。不同版本的檢閱區段會循環使用紅色星星、黑色星星及無任何星星。

做得好！您已順利使用 Istio Envoy Sidecar 來部署 BookInfo 範例應用程式。接下來，您可以清理資源，或繼續執行其他指導教學來進一步探索 Istio。

## 清理
{: #istio_tutorial_cleanup}

如果您完成使用 Istio，而且不想要[繼續探索](#istio_tutorial_whatsnext)，則可以清理叢集裡的 Istio 資源。
{:shortdesc}

1. 刪除叢集裡的所有 BookInfo 服務、Pod 及部署。
    ```
    samples/bookinfo/platform/kube/cleanup.sh
    ```
    {: pre}

2. 解除安裝 Istio Helm 部署。
    ```
    helm del istio --purge
    ```
    {: pre}

3. **選用**：如果您使用的是 Helm 2.9 或更早版本，並已套用 Istio 自訂資源定義，請刪除它們。
    ```
    kubectl delete -f https://raw.githubusercontent.com/IBM/charts/master/stable/ibm-istio/templates/crds.yaml
    ```
    {: pre}

## 下一步為何？
{: #istio_tutorial_whatsnext}

* 若要進一步探索 Istio，您可以在 [Istio 文件 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://istio.io/) 中找到更多手冊。
    * [Intelligent Routing ![外部鏈結圖示 ](../icons/launch-glyph.svg "外部鏈結圖示")](https://istio.io/docs/guides/intelligent-routing.html)：此範例顯示如何使用 Istio 的資料流量管理功能，將資料流量遞送至特定版本之 BookInfo 的檢閱及評等微服務。
    * [In-Depth Telemetry ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://istio.io/docs/guides/telemetry.html)：此範例包括如何使用 Istio Mixer 及 Envoy Proxy 來取得 BookInfo 微服務的統一度量值、日誌及追蹤。
* 取得[認知類別：使用 Istio 及 IBM Cloud Kubernetes Service 來開始使用微服務 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://cognitiveclass.ai/courses/get-started-with-microservices-istio-and-ibm-cloud-container-service/)。**附註**：您可以跳過本課程的 Istio 安裝一節。
* 請參閱此部落格文章，其描述如何使用 [Vistio ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://itnext.io/vistio-visualize-your-istio-mesh-using-netflixs-vizceral-b075c402e18e) 來視覺化您的 Istio 服務網。
