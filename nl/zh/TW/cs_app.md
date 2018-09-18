---

copyright:
  years: 2014, 2018
lastupdated: "2018-08-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}




# 在叢集裡部署應用程式
{: #app}

您可以在 {{site.data.keyword.containerlong}} 中使用 Kubernetes 技術於容器中部署應用程式，並確保那些應用程式始終處於運行狀態。例如，您可以執行漸進式更新及回復，而不會對使用者造成任何關閉時間。
{: shortdesc}

藉由按一下下列影像的區域，來瞭解部署應用程式的一般步驟。要先學習基本觀念嗎？請試用[部署應用程式指導教學](cs_tutorials_apps.html#cs_apps_tutorial)。

<img usemap="#d62e18" border="0" class="image" id="basic_deployment_process" src="images/basic_deployment_process.png" width="780" style="width:780px;" alt="基本部署程序"/>
<map name="d62e18" id="d62e18">
<area href="cs_cli_install.html" target="_blank" alt="安裝 CLI。" title="安裝 CLI。" shape="rect" coords="30, 69, 179, 209" />
<area href="https://kubernetes.io/docs/concepts/configuration/overview/" target="_blank" alt="為您的應用程式建立配置檔。請檢閱來自 Kubernetes 的最佳作法。" title="為您的應用程式建立配置檔。請檢閱來自 Kubernetes 的最佳作法。" shape="rect" coords="254, 64, 486, 231" />
<area href="#app_cli" target="_blank" alt="選項 1：執行來自 Kubernetes CLI 的配置檔。" title="選項 1：執行來自 Kubernetes CLI 的配置檔。" shape="rect" coords="544, 67, 730, 124" />
<area href="#cli_dashboard" target="_blank" alt="選項 2：在本端啟動 Kubernetes 儀表板，並執行配置檔。" title="選項 2：在本端啟動 Kubernetes 儀表板，並執行配置檔。" shape="rect" coords="544, 141, 728, 204" />
</map>

<br />




## 規劃高可用性部署
{: #highly_available_apps}

將設定分佈到越多個工作者節點及叢集，使用者遇到應用程式關閉的可能性越低。
{: shortdesc}

檢閱下列潛在的應用程式設定，它們依遞增的可用性程度進行排序：


![應用程式高可用性階段](images/cs_app_ha_roadmap-mz.png)

1.  含有 n+2 個 Pod 的部署，由抄本集管理，位於單一區域叢集的單一節點中。
2.  含有 n+2 個 Pod 的部署，由抄本集管理，分散於單一區域叢集的多個節點（反親緣性）中。
3.  含有 n+2 個 Pod 的部署，由抄本集管理，分散於各區域的多區域叢集的多個節點（反親緣性）中。

您也可以[使用廣域負載平衡器連接不同地區中的多個叢集](cs_clusters.html#multiple_clusters)，以增加高可用性。

### 增加應用程式的可用性
{: #increase_availability}

<dl>
  <dt>使用部署和抄本集來部署您的應用程式及其相依關係</dt>
    <dd><p>部署是一種 Kubernetes 資源，您可以用來宣告應用程式的所有元件及其相依關係。使用部署時，您不必寫下所有步驟，而是可以著重於您的應用程式。</p>
    <p>當您部署多個 Pod 時，會自動為您的部署建立抄本集來監視 Pod，並確保隨時都有所需數目的 Pod 在執行。當一個 Pod 關閉時，抄本集會以新的 Pod 來取代無回應的 Pod。</p>
    <p>您可以使用部署來定義應用程式的更新策略，包括您要在漸進式更新期間新增的 Pod 數目，以及每次更新時可能無法使用的 Pod 數目。當您執行漸進式更新時，部署會檢查修訂版是否正常運作，並且在偵測到失敗時停止推出。</p>
    <p>使用部署，您可以同時部署多個具有不同旗標的修訂。例如，您可以先測試部署，然後再決定將其推送至正式作業。</p>
    <p>部署可讓您追蹤任何已部署的修訂。如果發現更新無法如預期般運作時，則您可以使用此歷程來回復至舊版。</p></dd>
  <dt>為應用程式的工作負載包含足夠的抄本，然後加兩個</dt>
    <dd>為了讓應用程式具備高可用性以及更大的失敗復原力，請考慮包含多於最小值的額外抄本來處理預期工作負載。額外的抄本可以在 Pod 當機，而抄本集尚未回復當機的 Pod 時，處理工作負載。為了預防兩者同時失敗，請包含兩個額外的抄本。此設定是 N+2 型樣，其中 N 是處理送入工作負載的抄本數，而 +2 是額外的兩個抄本。只要您的叢集有足夠空間，就可以有任意數目的 Pod。</dd>
  <dt>將 Pod 分散於多個節點（反親緣性）</dt>
    <dd><p>當您建立部署時，可以將每一個 Pod 部署至相同的工作者節點。這稱為親緣性或主機託管。為了保護您的應用程式不受工作者節點失敗影響，您可以使用 <em>podAntiAffinity</em> 選項與標準叢集搭配，將部署配置為將 Pod 分散至多個工作者節點。您可以定義兩種類型的 Pod 反親緣性：偏好或必要。如需相關資訊，請參閱關於<a href="https://kubernetes.io/docs/concepts/configuration/assign-pod-node/" rel="external" target="_blank" title="（在新分頁或視窗中開啟）">將 Pod 指派給節點</a>的 Kubernetes 文件。</p>
    <p><strong>附註</strong>：使用必要的反親緣性，您只能部署對其具有工作者節點之抄本的數量。比方說，如果您的叢集裡有 3 個工作者節點，但您在 YAML 檔案中定義 5 個抄本，則只會部署 3 個抄本。每一個抄本都位於不同的工作者節點上。剩餘的 2 個抄本會保持擱置狀態。如果您新增另一個工作者節點至叢集，則其中一個剩餘的抄本會自動部署至新的工作者節點。<p>
    <p><strong>範例部署 YAML 檔案</strong>:<ul>
    <li><a href="https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/deploy-apps-clusters/nginx_preferredAntiAffinity.yaml" rel="external" target="_blank" title="（在新分頁或視窗中開啟）">具有偏好的 Pod 反親緣性的 Nginx 應用程式。</a></li>
    <li><a href="https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/deploy-apps-clusters/liberty_requiredAntiAffinity.yaml" rel="external" target="_blank" title="（在新分頁或視窗中開啟）">具有必要的 Pod 反親緣性的 IBM® WebSphere® Application Server Liberty 應用程式。</a></li></ul></p>
    
    </dd>
<dt>將 Pod 分散在多個區域或地區</dt>
  <dd><p>若要保護應用程式不發生區域失敗，您可以在不同區域中建立多個叢集，或將區域新增至多區域叢集裡的工作者節點儲存區。多區域叢集僅適用於[特定都會區域](cs_regions.html#zones)（例如達拉斯）。如果您在不同區域中建立多個叢集，則必須[設定廣域負載平衡器](cs_clusters.html#multiple_clusters)。</p>
  <p>當您使用抄本集並指定 Pod 反親緣性時，Kubernetes 會將應用程式 Pod 分散到各節點。如果您的節點位於多個區域中，則會將 Pod 分散到各區域，以增加應用程式的可用性。如果您要限制應用程式只在某個區域中執行，則可以配置 Pod 親緣性，或在某個區域中建立及標示工作者節點儲存區。如需相關資訊，請參閱[多區域叢集的高可用性](cs_clusters.html#ha_clusters)。</p>
  <p><strong>在多區域叢集部署中，應用程式 Pod 是否平均分佈到各節點？</strong></p>
  <p>Pod 會平均分佈到各區域，但不一定會分佈到各節點。例如，如果您叢集的 3 個區域各有 1 個節點，並且部署 6 個 Pod 的抄本集，則每個節點都會取得 2 個 Pod。不過，如果您叢集的 3 個區域各有 2 個節點，並且部署 6 個 Pod 的抄本集，則每個區域會排定 2 個 Pod，而且每個節點或許會排定 1 個 Pod 也或許未排定。如需進一步控制排程，您可以[設定 Pod 親緣性 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node)。</p>
  <p><strong>如果區域關閉，如何將 Pod 重新排定至其他區域中的其餘節點？</strong></br>它取決於您在部署中使用的排程原則。如果您已包括[節點特定 Pod 親緣性 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#node-affinity-beta-feature)，則不會重新排定 Pod。如果您未這麼做，則會在其他區域的可用工作者節點上建立 Pod，但它們可能不平衡。例如，2 個 Pod 可能會分散到 2 個可用節點，或者它們可能會同時排定到具有可用容量的 1 個節點。同樣地，傳回無法使用區域時，不會自動刪除 Pod，也不會重新讓它在各節點之間保持平衡。如果您要在備份區域之後重新讓 Pod 在各區域之間保持平衡，請考慮使用 [Kubernetes 取消排程器 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://github.com/kubernetes-incubator/descheduler)。</p>
  <p><strong>提示</strong>：在多區域叢集中，請嘗試將每個區域的工作者節點容量保持為 50%，讓您有足夠的剩餘容量來保護叢集不發生區域失敗。</p>
  <p><strong>如果我要將應用程式分散到各地區，該怎麼辨？</strong></br>為了保護應用程式不發生地區失敗，請在另一個地區建立第二個叢集、[設定廣域負載平衡器](cs_clusters.html#multiple_clusters)以連接叢集，以及使用部署 YAML，以利用應用程式的 [Pod 反親緣性 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/) 來部署重複抄本集。</p>
  <p><strong>如果應用程式需要持續性儲存空間，該怎麼辨？</strong></p>
  <p>請使用雲端服務（例如 [{{site.data.keyword.cloudant_short_notm}}](/docs/services/Cloudant/getting-started.html#getting-started-with-cloudant) 或 [{{site.data.keyword.cos_full_notm}}](/docs/services/cloud-object-storage/about-cos.html#about-ibm-cloud-object-storage)）。</p></dd>
</dl>



### 最小應用程式部署
{: #minimal_app_deployment}

免費或標準叢集裡的基本應用程式部署可能包括下列元件。
{: shortdesc}

![部署設定](images/cs_app_tutorial_components1.png)

若要部署最小應用程式的元件（如圖所示），請使用類似於下列範例的配置檔：
```
apiVersion: apps/v1beta1
kind: Deployment
metadata:
  name: ibmliberty
spec:
  replicas: 1
  template:
    metadata:
      labels:
        app: ibmliberty
    spec:
      containers:
      - name: ibmliberty
        image: registry.bluemix.net/ibmliberty:latest
        ports:
        - containerPort: 9080
---
apiVersion: v1
kind: Service
metadata:
  name: ibmliberty-service
  labels:
    app: ibmliberty
spec:
  selector:
    app: ibmliberty
  type: NodePort
  ports:
   - protocol: TCP
     port: 9080
```
{: codeblock}

**附註：**若要公開您的服務，請確定您在服務的 `spec.selector` 區段中使用的鍵值組，與您在部署 yaml 的 `spec.template.metadata.labels` 區段中使用的鍵值組相同。若要進一步瞭解每一個元件，請檢閱 [Kubernetes 基本概念](cs_tech.html#kubernetes_basics)。

<br />






## 啟動 Kubernetes 儀表板
{: #cli_dashboard}

在本端系統上開啟 Kubernetes 儀表板，以檢視叢集和其工作者節點的相關資訊。
[在 GUI 中](#db_gui)，只需按一下按鈕，即可存取儀表板。[使用 CLI](#db_cli)，您可以存取儀表板，或使用自動化處理程序中的步驟，例如針對 CI/CD 管線。
{:shortdesc}

開始之前，請先將 [CLI 的目標](cs_cli_install.html#cs_cli_configure)設為您的叢集。

您可以使用預設埠或設定自己的埠，來啟動叢集的 Kubernetes 儀表板。

**從 GUI 啟動 Kubernetes 儀表板**
{: #db_gui}

1.  登入 [{{site.data.keyword.Bluemix_notm}} GUI](https://console.bluemix.net/)。
2.  從功能表列中您的設定檔中，選取您要使用的帳戶。
3.  從功能表中，按一下**容器**。
4.  在**叢集**頁面上，按一下您要存取的叢集。
5.  從叢集詳細資料頁面中，按一下 **Kubernetes 儀表板**按鈕。

</br>
</br>

**從 CLI 啟動 Kubernetes 儀表板**
{: #db_cli}

1.  取得 Kubernetes 的認證。

    ```
    kubectl config view -o jsonpath='{.users[0].user.auth-provider.config.id-token}'
    ```
    {: pre}

2.  複製輸出中所顯示的 **id-token** 值。

3.  使用預設埠號來設定 Proxy。

    ```
    kubectl proxy
    ```
    {: pre}

    輸出範例：

    ```
    Starting to serve on 127.0.0.1:8001
    ```
    {: screen}

4.  登入儀表板。

  1.  在您的瀏覽器中，導覽至下列 URL：

      ```
      http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/
      ```
      {: codeblock}

  2.  在登入頁面中，選取**記號**鑑別方法。

  3.  然後，將您先前複製的 **id-token** 值貼到**記號**欄位，然後按一下**登入**。

完成 Kubernetes 儀表板之後，使用 `CTRL+C` 來結束 `proxy` 指令。在您結束之後，無法再使用 Kubernetes 儀表板。請執行 `proxy` 指令，以重新啟動 Kubernetes 儀表板。

[接下來，您可以從儀表板執行配置檔。](#app_ui)

<br />


## 建立密碼
{: #secrets}

Kubernetes 密碼是一種儲存機密資訊（例如使用者名稱、密碼或金鑰）的安全方式。
{:shortdesc}

請檢閱下列需要密碼的作業。如需您可以在密碼中儲存哪些項目的相關資訊，請參閱 [Kubernetes 文件 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/concepts/configuration/secret/)。

### 將服務新增至叢集
{: #secrets_service}

將服務連結至叢集時，不需要建立密碼。會自動為您建立密碼。如需相關資訊，請參閱[將 Cloud Foundry 服務新增至叢集](cs_integrations.html#adding_cluster)。

### 配置 Ingress ALB 以使用 TLS
{: #secrets_tls}

ALB 會對叢集裡應用程式的 HTTP 網路資料流量進行負載平衡。若要同時對送入的 HTTPS 連線進行負載平衡，您可以配置 ALB 來解密網路資料流量，並將解密的要求轉遞至叢集裡公開的應用程式。

如果您使用 IBM 提供的 Ingress 子網域，則可以[使用 IBM 提供的 TLS 憑證](cs_ingress.html#public_inside_2)。若要檢視 IBM 提供的 TLS 密碼，請執行下列指令：
```
ibmcloud ks cluster-get <cluster_name_or_ID> | grep "Ingress secret"
```
{: pre}

如果您使用自訂網域，則可以使用自己的憑證來管理 TLS 終止。若要建立您自己的 TLS 密碼，請執行下列動作：
1. 使用下列其中一種方法來產生金鑰及憑證：
    * 從憑證提供者產生憑證管理中心 (CA) 憑證及金鑰。如果您有自己的網域，請為您的網域購買正式的 TLS 憑證。**重要事項**：請確定每一個憑證的 [CN ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://support.dnsimple.com/articles/what-is-common-name/) 都不同。
    * 基於測試用途，您可以使用 OpenSSL 來建立自簽憑證。如需相關資訊，請參閱此[自簽 SSL 憑證指導教學 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.akadia.com/services/ssh_test_certificate.html)。
        1. 建立 `tls.key`。
            ```
            openssl genrsa -out tls.key 2048
            ```
            {: pre}
        2. 使用金鑰，以建立 `tls.crt`。
            ```
            openssl req -new -x509 -key tls.key -out tls.crt
            ```
            {: pre}
2. [將憑證及金鑰轉換為 base-64 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.base64encode.org/)。
3. 使用憑證及金鑰，以建立密碼 YAML 檔案。
     ```
     apiVersion: v1
     kind: Secret
     metadata:
       name: ssl-my-test
     type: Opaque
     data:
       tls.crt: <client_certificate>
       tls.key: <client_key>
     ```
     {: codeblock}

4. 建立憑證作為 Kubernetes 密碼。
     ```
     kubectl create -f ssl-my-test
     ```
     {: pre}

### 自訂包含 SSL 服務註釋的 Ingress ALB
{: #secrets_ssl_services}

您可以使用 [`ingress.bluemix.net/ssl-services` 註釋](cs_annotations.html#ssl-services)，加密從 Ingress ALB 到上游應用程式的資料流量。若要建立密碼，請執行下列動作：

1. 從上游伺服器取得憑證管理中心 (CA) 金鑰及憑證。
2. [將憑證轉換為 base-64 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.base64encode.org/)。
3. 使用憑證，以建立密碼 YAML 檔案。
     ```
     apiVersion: v1
     kind: Secret
     metadata:
       name: ssl-my-test
     type: Opaque
     data:
       trusted.crt: <ca_certificate>
     ```
     {: codeblock}
     **附註**：如果您也要施行上游資料流量的交互鑑別，則可以提供 `client.crt` 和 `client.key`，以及 data 區段中的 `trusted.crt`。
4. 建立憑證作為 Kubernetes 密碼。
     ```
     kubectl create -f ssl-my-test
     ```
     {: pre}

### 自訂包含交互鑑別註釋的 Ingress ALB
{: #secrets_mutual_auth}

您可以使用 [`ingress.bluemix.net/mutual-auth` 註釋](cs_annotations.html#mutual-auth)，針對 Ingress ALB 配置下游資料流量的交互鑑別。若要建立交互鑑別密碼，請執行下列動作：

1. 使用下列其中一種方法來產生金鑰及憑證：
    * 從憑證提供者產生憑證管理中心 (CA) 憑證及金鑰。如果您有自己的網域，請為您的網域購買正式的 TLS 憑證。**重要事項**：請確定每一個憑證的 [CN ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://support.dnsimple.com/articles/what-is-common-name/) 都不同。
    * 基於測試用途，您可以使用 OpenSSL 來建立自簽憑證。如需相關資訊，請參閱此[自簽 SSL 憑證指導教學 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.akadia.com/services/ssh_test_certificate.html)。
        1. 建立 `ca.key`。
            ```
            openssl genrsa -out ca.key 1024
            ```
            {: pre}
        2. 使用金鑰，以建立 `ca.crt`。
            ```
            openssl req -new -x509 -key ca.key -out ca.crt
            ```
            {: pre}
        3. 使用 `ca.crt`，以建立自簽憑證。
            ```
            openssl x509 -req -in example.org.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out example.org.crt
            ```
            {: pre}
2. [將憑證轉換為 base-64 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.base64encode.org/)。
3. 使用憑證，以建立密碼 YAML 檔案。
     ```
     apiVersion: v1
     kind: Secret
     metadata:
       name: ssl-my-test
     type: Opaque
     data:
       ca.crt: <ca_certificate>
     ```
     {: codeblock}
4. 建立憑證作為 Kubernetes 密碼。
     ```
     kubectl create -f ssl-my-test
     ```
     {: pre}

<br />


## 使用 GUI 部署應用程式
{: #app_ui}

當您使用 Kubernetes 儀表板將應用程式部署至叢集時，部署資源會自動在叢集裡建立、更新及管理 Pod。
{:shortdesc}

開始之前：

-   安裝必要的 [CLI](cs_cli_install.html#cs_cli_install)。
-   [將 CLI 的目標設為](cs_cli_install.html#cs_cli_configure)您的叢集。

若要部署應用程式，請執行下列動作：

1.  開啟 Kubernetes [儀表板](#cli_dashboard)，然後按一下**+ 建立**。
2.  使用下列兩種方式之一來輸入您的應用程式詳細資料。
  * 選取**在下面指定應用程式詳細資料**，然後輸入詳細資料。
  * 選取**上傳 YAML 或 JSON 檔案**以上傳應用程式[配置檔 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-container/)。

  需要配置檔的說明嗎？請移出此[範例 YAML 檔案 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://github.com/IBM-Cloud/kube-samples/blob/master/deploy-apps-clusters/deploy-ibmliberty.yaml)。在此範例中，容器是從美國南部地區中的 **ibmliberty** 映像檔部署的。進一步瞭解使用 Kubernetes 資源時如何[保護個人資訊安全](cs_secure.html#pi)。
  {: tip}

3.  驗證您是否已使用下列其中一種方式，順利部署您的應用程式。
  * 在 Kubernees 儀表板中，按一下**部署**。即會顯示成功部署的清單。
  * 如果您的應用程式是[公開可用](cs_network_planning.html#public_access)，請導覽至 {{site.data.keyword.containerlong}} 儀表板中的叢集概觀頁面。複製位於叢集摘要區段的子網域，並將其貼入瀏覽器中，以檢視您的應用程式。

<br />


## 使用 CLI 部署應用程式
{: #app_cli}

建立叢集之後，您可以使用 Kubernetes CLI 以將應用程式部署至該叢集。
{:shortdesc}

開始之前：

-   安裝必要的 [CLI](cs_cli_install.html#cs_cli_install)。
-   [將 CLI 的目標設為](cs_cli_install.html#cs_cli_configure)您的叢集。

若要部署應用程式，請執行下列動作：

1.  根據 [Kubernetes 最佳作法 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/concepts/configuration/overview/) 建立配置檔。配置檔通常會包含您在 Kubernetes 中建立之每一個資源的配置詳細資料。您的 Script 可能包括下列一個以上區段：

    -   [Deployment ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)：定義 Pod 和抄本集的建立。Pod 包括一個個別的容器化應用程式，而抄本集會控制多個 Pod 實例。

    -   [Service ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/concepts/services-networking/service/)：藉由使用工作者節點或負載平衡器公用 IP 位址，或公用 Ingress 路徑，提供 Pod 的前端存取。

    -   [Ingress ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/concepts/services-networking/ingress/)：指定一種負載平衡器，提供路徑來公開存取您的應用程式。

    進一步瞭解使用 Kubernetes 資源時如何[保護個人資訊安全](cs_secure.html#pi)。

2.  在叢集的環境定義中執行配置檔。

    ```
    kubectl apply -f config.yaml
    ```
    {: pre}

3.  如果您使用 NodePort 服務讓應用程式可公開使用，負載平衡器服務（或 Ingress）會確認您可以存取此應用程式。

<br />


## 使用標籤將應用程式部署至特定工作者節點
{: #node_affinity}

當您部署應用程式時，應用程式 Pod 會任意地部署至叢集裡的各種工作者節點。在某些情況下，建議您限制應用程式 Pod 要部署至其中的工作者節點。例如，建議您讓應用程式 Pod 只部署至特定工作者節點儲存區中的工作者節點，因為這些工作者節點位於裸機機器上。若要指定應用程式 Pod 必須部署至其中的工作者節點，請將親緣性規則新增至應用程式部署。
{:shortdesc}

開始之前，請先將 [CLI 的目標](cs_cli_install.html#cs_cli_configure)設為您的叢集。

1. 取得您要將應用程式 Pod 部署至其中的工作者節點儲存區名稱。
    ```
    ibmcloud ks worker-pools <cluster_name_or_ID>
    ```
    {:pre}

    這些步驟使用工作者節點儲存區名稱作為範例。若要根據另一個因素將應用程式 Pod 部署至特定工作者節點，請改為取得該值。例如，若只要將應用程式 Pod 部署至特定 VLAN 上的工作者節點，請執行 `ibmcloud ks vlans <zone>` 以取得 VLAN ID。
    {: tip}

2. 針對工作者節點儲存區名稱，[新增親緣性規則 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#node-affinity-beta-feature) 至應用程式部署。

    yaml 範例：

    ```
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
      name: with-node-affinity
    spec:
      template:
        spec:
          affinity:
            nodeAffinity:
              requiredDuringSchedulingIgnoredDuringExecution:
                nodeSelectorTerms:
                - matchExpressions:
                  - key: workerPool
                    operator: In
                    values:
                    - <worker_pool_name>
    ...
    ```
    {: codeblock}

    在 yaml 範例的 **affinity** 區段中，`workerPool` 是 `key`，而 `<worker_pool_name>` 是 `value`。

3. 套用已更新的部署配置檔。
    ```
    kubectl apply -f with-node-affinity.yaml
    ```
    {: pre}

4. 驗證應用程式 Pod 已部署至正確的工作者節點。

    1. 列出叢集裡的 Pod。
        ```
        kubectl get pods -o wide
        ```
        {: pre}

        輸出範例：
        ```
        NAME                   READY     STATUS              RESTARTS   AGE       IP               NODE
        cf-py-d7b7d94db-vp8pq  1/1       Running             0          15d       172.30.xxx.xxx   10.176.48.78
        ```
        {: screen}

    2. 在輸出中，識別應用程式的 Pod。記下 Pod 所在工作者節點的 **NODE** 專用 IP 位址。

        在上述範例輸出中，應用程式 Pod `cf-py-d7b7d94db-vp8pq` 位於 IP 位址為 `10.176.48.78` 的工作者節點上。

    3. 列出您在應用程式部署內所指定工作者節點儲存區中的工作者節點。

        ```
        ibmcloud ks workers <cluster_name_or_ID> --worker-pool <worker_pool_name>
        ```
        {: pre}

        輸出範例：

        ```
        ID                                                 Public IP       Private IP     Machine Type      State    Status  Zone    Version
        kube-dal10-crb20b637238bb471f8b4b8b881bbb4962-w7   169.xx.xxx.xxx  10.176.48.78   b2c.4x16          normal   Ready   dal10   1.8.6_1504
        kube-dal10-crb20b637238bb471f8b4b8b881bbb4962-w8   169.xx.xxx.xxx  10.176.48.83   b2c.4x16          normal   Ready   dal10   1.8.6_1504
        kube-dal12-crb20b637238bb471f8b4b8b881bbb4962-w9   169.xx.xxx.xxx  10.176.48.69   b2c.4x16          normal   Ready   dal12   1.8.6_1504
        ```
        {: screen}

        如果您已根據另一個因素建立應用程式親緣性規則，請改為取得該值。例如，若要驗證應用程式 Pod 已部署至特定 VLAN 上的工作者節點，請執行 `ibmcloud ks worker-get <cluster_name_or_ID> <worker_ID>` 以檢視工作者節點所在的 VLAN。
        {: tip}

    4. 在輸出中，驗證具有您在前一個步驟中所識別之專用 IP 位址的工作者節點已部署在此工作者節點儲存區。

<br />


## 在 GPU 機器上部署應用程式
{: #gpu_app}

如果您有[裸機圖形處理裝置 (GPU) 機型](cs_clusters.html#shared_dedicated_node)，則可以將數學運算密集的工作負載排定在工作者節點上。例如，您可以執行 3D 應用程式，而此應用程式會使用「統一計算裝置架構 (CUDA) 」平台來共用 GPU 和 CPU 之間的處理負載，以提高效能。
{:shortdesc}

在下列步驟中，您將學習如何部署需要 GPU 的工作負載。您也可以[部署應用程式](#app_ui)，不需要在 GPU 和 CPU 之間處理它們的工作負載。之後，您可能發現使用[此 Kubernetes 示範 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://github.com/pachyderm/pachyderm/tree/master/doc/examples/ml/tensorflow) 來嘗試數學運算密集的工作負載（例如 [TensorFlow ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.tensorflow.org/) 機器學習架構）很有用。

開始之前：
* [建立一個裸機 GPU 機型](cs_clusters.html#clusters_cli)。請注意，此處理程序可能需要多個營業日才能完成。
* 您的主要叢集和 GPU 工作者節點必須執行 Kubernetes 1.10 版或更新版本。

若要在 GPU 機器上執行工作負載，請執行下列動作：
1.  建立 YAML 檔案。在此範例中，`Job` YAML 會管理批次型工作負載，方法為建立一個短暫存在的 Pod，一直執行到排定它完成的指令順利終止。

    **重要事項**：對於 GPU 工作負載，您必須一律在 YAML 規格中提供 `resources: limits: nvidia.com/gpu` 欄位。

    ```yaml
    apiVersion: batch/v1
    kind: Job
    metadata:
      name: nvidia-smi
      labels:
        name: nvidia-smi
    spec:
      template:
        metadata:
          labels:
            name: nvidia-smi
        spec:
          containers:
          - name: nvidia-smi
            image: nvidia/cuda:9.1-base-ubuntu16.04
            command: [ "/usr/test/nvidia-smi" ]
            imagePullPolicy: IfNotPresent
            resources:
              limits:
                nvidia.com/gpu: 2
            volumeMounts:
            - mountPath: /usr/test
              name: nvidia0
          volumes:
            - name: nvidia0
              hostPath:
                path: /usr/bin
          restartPolicy: Never
    ```
    {: codeblock}

    <table>
    <caption>YAML 元件</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
    </thead>
    <tbody>
    <tr>
    <td>meta 資料及標籤名稱</td>
    <td>為工作提供名稱和標籤，並在檔案的 meta 資料及 `spec template` meta 資料中使用相同的名稱。例如，`nvidia-smi`。</td>
    </tr>
    <tr>
    <td><code>containers/image</code></td>
    <td>提供容器是其執行中實例的映像檔。在此範例中，該值會設為使用 DockerHub CUDA 映像檔：<code>nvidia/cuda:9.1-base-ubuntu16.04</code></td>
    </tr>
    <tr>
    <td><code>containers/command</code></td>
    <td>指定要在容器中執行的指令。在此範例中，<code>[ "/usr/test/nvidia-smi" ]</code> 指令會參照 GPU 機器上的二進位檔，因此您也必須設定磁區裝載。</td>
    </tr>
    <tr>
    <td><code>containers/imagePullPolicy</code></td>
    <td>若要只當映像檔目前不在工作者節點上時，才取回新的映像檔，請指定 <code>IfNotPresent</code>。</td>
    </tr>
    <tr>
    <td><code>resources/limits</code></td>
    <td>對於 GPU 機器，您必須指定資源限制。Kubernetes [裝置外掛程式 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/concepts/cluster-administration/device-plugins/) 會設定預設資源要求，以符合限制。
    <ul><li>您必須將金鑰指定為 <code>nvidia.com/gpu</code>。</li>
    <li>輸入您要要求的 GPU 數目（整數），例如 <code>2</code>。<strong>附註</strong>：容器 Pod 不會共用 GPU，而且 GPU 不能過量使用。例如，如果您只有 1 部 `mg1c.16x128` 機器，則在該機器中您只有 2 個 GPU，且最多可以指定 `2`。</li></ul></td>
    </tr>
    <tr>
    <td><code>volumeMounts</code></td>
    <td>為裝載至容器的磁區命名，例如 <code>nvidia0</code>。請在磁區的容器上指定 <code>mountPath</code>。在此範例中，路徑 <code>/usr/test</code> 符合工作容器指令中所使用的路徑。</td>
    </tr>
    <tr>
    <td><code>volumes</code></td>
    <td>為工作磁區命名，例如 <code>nvidia0</code>。在 GPU 工作者節點的 <code>hostPath</code> 中，指定主機上磁區的 <code>path</code>，在這個範例中，指定 <code>/usr/bin</code>。容器 <code>mountPath</code> 會對映至主機碟區 <code>path</code>，這可讓此工作存取 GPU 工作者節點上的 NVIDIA 二進位檔，以供容器指令執行。</td>
    </tr>
    </tbody></table>

2.  套用 YAML 檔案。例如：

    ```
    kubectl apply -f nvidia-smi.yaml
    ```
    {: pre}

3.  藉由依 `nvidia-sim` 標籤過濾您的 Pod 來檢查工作 Pod。驗證 **STATUS** 為 **Completed**。

    ```
    kubectl get pod -a -l 'name in (nvidia-sim)'
    ```
    {: pre}

    輸出範例：
    ```
    NAME                  READY     STATUS      RESTARTS   AGE
    nvidia-smi-ppkd4      0/1       Completed   0          36s
    ```
    {: screen}

4.  說明 Pod，以查看 GPU 裝置外掛程式如何排定 Pod。
    * 在 `Limits` 及 `Requests` 欄位中，查看您所指定的資源限制符合裝置外掛程式自動設定的要求。
    * 在事件中，驗證已將 Pod 指派給 GPU 工作者節點。

    ```
    kubectl describe pod nvidia-smi-ppkd4
    ```
    {: pre}

    輸出範例：
    ```
    Name:           nvidia-smi-ppkd4
    Namespace:      default
    ...
    Limits:
     nvidia.com/gpu:  2
    Requests:
     nvidia.com/gpu:  2
    ...
    Events:
    Type    Reason                 Age   From                     Message
    ----    ------                 ----  ----                     -------
    Normal  Scheduled              1m    default-scheduler        Successfully assigned nvidia-smi-ppkd4 to 10.xxx.xx.xxx
    ...
    ```
    {: screen}

5.  若要驗證工作已使用 GPU 來計算其工作負載，您可以檢查日誌。來自工作的 `[ "/usr/test/nvidia-smi" ]` 指令已查詢 GPU 工作者節點上的 GPU 裝置狀況。

    ```
    kubectl logs nvidia-sim-ppkd4
    ```
    {: pre}

    輸出範例：
    ```
    +-----------------------------------------------------------------------------+
    | NVIDIA-SMI 390.12                 Driver Version: 390.12                    |
    |-------------------------------+----------------------+----------------------+
    | GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
    | Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
    |===============================+======================+======================|
    |   0  Tesla K80           Off  | 00000000:83:00.0 Off |                  Off |
    | N/A   37C    P0    57W / 149W |      0MiB / 12206MiB |      0%      Default |
    +-------------------------------+----------------------+----------------------+
    |   1  Tesla K80           Off  | 00000000:84:00.0 Off |                  Off |
    | N/A   32C    P0    63W / 149W |      0MiB / 12206MiB |      1%      Default |
    +-------------------------------+----------------------+----------------------+

    +-----------------------------------------------------------------------------+
    | Processes:                                                       GPU Memory |
    |  GPU       PID   Type   Process name                             Usage      |
    |=============================================================================|
    |  No running processes found                                                 |
    +-----------------------------------------------------------------------------+
    ```
    {: screen}

    在此範例中，您會看到使用這兩個 GPU 來執行工作，因為在工作者節點中已排定這兩個 GPU。如果限制設為 1，則只會顯示 1 個 GPU。

## 調整應用程式
{: #app_scaling}

使用 Kubernetes，您可以啟用[水平 Pod 自動調整![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/)，根據 CPU 自動增加或減少應用程式的實例數目。
{:shortdesc}

要尋找調整 Cloud Foundry 應用程式的相關資訊嗎？請查看 [IBM Auto-Scaling for {{site.data.keyword.Bluemix_notm}}](/docs/services/Auto-Scaling/index.html)。
{: tip}

開始之前：
- [將 CLI 的目標設為](cs_cli_install.html#cs_cli_configure)您的叢集。
- Heapster 監視必須部署在您要自動調整的叢集裡。

步驟：

1.  從 CLI 將您的應用程式部署至叢集。當您部署應用程式時，必須要求 CPU。

    ```
    kubectl run <app_name> --image=<image> --requests=cpu=<cpu> --expose --port=<port_number>
    ```
    {: pre}

    <table>
    <caption>kubectl run 的指令元件</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解這個指令的元件</th>
    </thead>
    <tbody>
    <tr>
    <td><code>--image</code></td>
    <td>您要部署的應用程式。</td>
    </tr>
    <tr>
    <td><code>--request=cpu</code></td>
    <td>容器的必要 CPU（以 millicores 為單位指定）。例如，<code>--requests=200m</code>。</td>
    </tr>
    <tr>
    <td><code>--expose</code></td>
    <td>設為 true 時，會建立外部服務。</td>
    </tr>
    <tr>
    <td><code>--port</code></td>
    <td>透過此埠可讓您的應用程式供外部使用。</td>
    </tr></tbody></table>

    若為更複雜的部署，您可能需要建立[配置檔](#app_cli)。
    {: tip}

2.  建立 autoscaler 並定義原則。如需使用 `kubectl autoscale` 指令的相關資訊，請參閱 [Kubernetes 文件 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://v1-8.docs.kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#autoscale)。

    ```
    kubectl autoscale deployment <deployment_name> --cpu-percent=<percentage> --min=<min_value> --max=<max_value>
    ```
    {: pre}

    <table>
    <caption>kubectl autoscale 的指令元件</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解這個指令的元件</th>
    </thead>
    <tbody>
    <tr>
    <td><code>--cpu-percent</code></td>
    <td>Horizontal Pod Autoscaler 所維護的平均 CPU 使用率（以百分比為指定單位）。</td>
    </tr>
    <tr>
    <td><code>--min</code></td>
    <td>用來維護指定 CPU 使用率百分比之已部署的 Pod 數目下限。</td>
    </tr>
    <tr>
    <td><code>--max</code></td>
    <td>用來維護指定 CPU 使用率百分比之已部署的 Pod 數目上限。</td>
    </tr>
    </tbody></table>


<br />


## 管理漸進式部署
{: #app_rolling}

您可以以自動化及受管制的方式來管理變更推出。如果推出不是根據計劃進行，您可以將部署回復為前一個修訂。
{:shortdesc}

在開始之前，請先建立[部署](#app_cli)。

1.  [推出 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#updating-a-deployment) 變更。例如，建議您變更起始部署中所用的映像檔。

    1.  取得部署名稱。

        ```
        kubectl get deployments
        ```
        {: pre}

    2.  取得 Pod 名稱。

        ```
        kubectl get pods
        ```
        {: pre}

    3.  取得在 Pod 中執行的容器的名稱。

        ```
        kubectl describe pod <pod_name>
        ```
        {: pre}

    4.  設定部署要使用的新映像檔。

        ```
        kubectl set image deployment/<deployment_name><container_name>=<image_name>
        ```
        {: pre}

    當您執行這些指令時，會立即套用變更，並記載推出歷程。

2.  檢查部署的狀態。

    ```
    kubectl rollout status deployments/<deployment_name>
    ```
    {: pre}

3.  回復變更。
    1.  檢視部署的推出歷程，並識別前次部署的修訂號碼。

        ```
        kubectl rollout history deployment/<deployment_name>
        ```
        {: pre}

        **提示：**若要查看特定修訂的詳細資料，請包括修訂號碼。

        ```
        kubectl rollout history deployment/<deployment_name> --revision=<number>
        ```
        {: pre}

    2.  回復至舊版，或指定修訂版。若要回復至舊版，請使用下列指令。

        ```
        kubectl rollout undo deployment/<depoyment_name> --to-revision=<number>
        ```
        {: pre}

<br />

