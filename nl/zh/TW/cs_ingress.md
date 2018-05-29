---

copyright:
  years: 2014, 2018
lastupdated: "2018-4-20"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# 使用 Ingress 公開應用程式
{: #ingress}

藉由在 {{site.data.keyword.containerlong}} 中建立由 IBM 提供的應用程式負載平衡器所管理的 Ingress 資源，來公開 Kubernetes 叢集中的多個應用程式。
{:shortdesc}

## 使用 Ingress 來管理網路資料流量
{: #planning}

Ingress 是一種 Kubernetes 服務，可將公用或專用要求轉遞給您的應用程式，以平衡叢集中的網路資料流量工作量。您可以使用 Ingress 將多個應用程式服務公開給大眾使用，或是使用唯一的公用或專用路徑公開給專用網路。
{:shortdesc}

Ingress 包含兩個元件：
<dl>
<dt>應用程式負載平衡器</dt>
<dd>應用程式負載平衡器 (ALB) 是一種外部負載平衡器，負責接聽送入的 HTTP、HTTPS、TCP 或 UDP 服務要求，並將要求轉遞至適當的應用程式 Pod。當您建立標準叢集時，{{site.data.keyword.containershort_notm}} 會為叢集自動建立高可用性的 ALB，並將唯一的公用路徑指派給它。公用路徑會鏈結至在建立叢集期間佈建至 IBM Cloud 基礎架構 (SoftLayer) 帳戶的可攜式公用 IP 位址。也會自動建立預設專用 ALB，但不會自動啟用它。</dd>
<dt>Ingress 資源</dt>
<dd>若要使用 Ingress 公開應用程式，您必須為應用程式建立 Kubernetes 服務，並藉由定義 Ingress 資源，向 ALB 登錄此服務。Ingress 資源是一項 Kubernetes 資源，它定義如何遞送應用程式送入要求的規則。Ingress 資源也指定您的應用程式服務路徑，這會附加到公用路徑，以形成唯一應用程式 URL，例如 `mycluster.us-south.containers.mybluemix.net/myapp`。</dd>
</dl>

下圖顯示 Ingress 如何將通訊從網際網路導向至應用程式：

<img src="images/cs_ingress_planning.png" width="550" alt="使用 Ingress 在 {{site.data.keyword.containershort_notm}} 中公開應用程式" style="width:550px; border-style: none"/>

1. 使用者會藉由存取應用程式的 URL，將要求傳送給您的應用程式。此 URL 是公開應用程式的公用 URL，其中已附加 Ingress 資源路徑，例如 `mycluster.us-south.containers.mybluemix.net/myapp`。

2. 用來作為廣域負載平衡器的 DNS 系統服務，會將 URL 解析為叢集中預設公用 ALB 的可攜式公用 IP 位址。

3. `kube-proxy` 會將要求遞送至應用程式的 Kubernetes ALB 服務。

4. Kubernetes 服務會將要求遞送至 ALB。

5. ALB 會檢查叢集中是否有 `myapp` 路徑的遞送規則。如果找到相符規則，則會根據您在 Ingress 資源中定義的規則，將要求轉遞至應用程式部署所在的 Pod。如果叢集中已部署多個應用程式實例，則 ALB 負載會平衡應用程式 Pod 之間的要求。



**附註：**Ingress 僅適用於標準叢集，而且叢集中需要至少兩個工作者節點才能確保高可用性，並套用定期更新。設定 Ingress 需要[管理者存取原則](cs_users.html#access_policies)。請驗證您的現行[存取原則](cs_users.html#infra_access)。

若要選擇 Ingress 的最佳配置，您可以遵循這個決策樹狀結構：

<img usemap="#ingress_map" border="0" class="image" src="images/networkingdt-ingress.png" width="750px" alt="此影像會逐步引導您為 Ingress 應用程式負載平衡器選擇最佳配置。如果此影像未顯示，則仍可在文件中找到資訊。" style="width:750px;" />
<map name="ingress_map" id="ingress_map">
<area href="/docs/containers/cs_ingress.html#private_ingress_no_tls" alt="使用自訂網域且不搭配 TLS 來專用地公開應用程式" shape="rect" coords="25, 246, 187, 294"/>
<area href="/docs/containers/cs_ingress.html#private_ingress_tls" alt="使用自訂網域且搭配 TLS 來專用地公開應用程式" shape="rect" coords="161, 337, 309, 385"/>
<area href="/docs/containers/cs_ingress.html#external_endpoint" alt="使用 IBM 提供的網域或自訂網域且搭配 TLS，公用地公用叢集外的應用程式" shape="rect" coords="313, 229, 466, 282"/>
<area href="/docs/containers/cs_ingress.html#custom_domain_cert" alt="使用自訂網域且搭配 TLS 來公用地公開應用程式" shape="rect" coords="365, 415, 518, 468"/>
<area href="/docs/containers/cs_ingress.html#ibm_domain" alt="使用 IBM 提供的網域且不搭配 TLS 來公用地公開應用程式" shape="rect" coords="414, 629, 569, 679"/>
<area href="/docs/containers/cs_ingress.html#ibm_domain_cert" alt="使用 IBM 提供的網域且搭配 TLS 來公用地公開應用程式" shape="rect" coords="563, 711, 716, 764"/>
</map>

<br />


## 將應用程式公開給大眾使用
{: #ingress_expose_public}

建立標準叢集時，會自動啟用 IBM 提供的應用程式負載平衡器 (ALB)，並為其指派可攜式公用 IP 位址及公用路徑。
{:shortdesc}

每個透過 Ingress 公開給大眾使用的應用程式都會獲指派附加至公用路徑的唯一路徑，因此，您可以使用唯一 URL 來公開存取叢集中的應用程式。若要將應用程式公開給大眾使用，您可以針對下列情境配置 Ingress。

-   [使用 IBM 提供的網域且不搭配 TLS 來公用地公開應用程式。](#ibm_domain)
-   [使用 IBM 提供的網域且搭配 TLS 來公用地公開應用程式。](#ibm_domain_cert)
-   [使用自訂網域且搭配 TLS 來公用地公開應用程式。](#custom_domain_cert)
-   [使用 IBM 提供的網域或自訂網域且搭配 TLS，公用叢集外的應用程式。](#external_endpoint)

### 使用 IBM 提供的網域且不搭配 TLS 來公用地公開應用程式
{: #ibm_domain}

您可以配置 ALB，對送入您叢集中應用程式的 HTTP 網路資料流量進行負載平衡，以及使用 IBM 提供的網域從網際網路存取應用程式。
{:shortdesc}

開始之前：

-   如果您還沒有叢集，請[建立標準叢集](cs_clusters.html#clusters_ui)。
-   [將 CLI 的目標設為](cs_cli_install.html#cs_cli_configure)叢集，才能執行 `kubectl` 指令。

若要使用 IBM 提供的網域來公開應用程式，請執行下列動作：

1.  [將應用程式部署至叢集](cs_app.html#app_cli)。請確定您已將標籤新增至您部署中配置檔的 meta 資料區段，例如 `app: code`。此標籤是識別您應用程式執行所在之所有 Pod 的必要項目，如此才能將 Pod 包含在 Ingress 負載平衡中。

2.   為您要公開的應用程式建立 Kubernetes 服務。您的應用程式必須由 Kubernet 服務公開，才能由叢集 ALB 包含在 Ingress 負載平衡中。
      1.  例如，開啟偏好的編輯器，然後建立名為 `myalbservice.yaml` 的服務配置檔。
      2.  為 ALB 將公開給大眾使用的應用程式定義服務。

          ```
          apiVersion: v1
          kind: Service
          metadata:
            name: myalbservice
          spec:
            selector:
              <selector_key>: <selector_value>
            ports:
             - protocol: TCP
               port: 8080
          ```
          {: codeblock}

          <table>
          <caption>瞭解 ALB 服務檔元件</caption>
          <thead>
          <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
          </thead>
          <tbody>
          <tr>
          <td><code>selector</code></td>
          <td>輸入標籤金鑰 (<em>&lt;selector_key&gt;</em>) 及值 (<em>&lt;selector_value&gt;</em>) 配對，以用來將應用程式執行所在的 Pod 設為目標。若要將您的 Pod 設為目標，並將它們包含在服務負載平衡中，請確定 <em>&lt;selector_key&gt;</em> 及 <em>&lt;selector_value&gt;</em> 與您在部署 yaml <code>spec.template.metadata.labels</code> 區段使用的金鑰/值配對相同。</td>
           </tr>
           <tr>
           <td><code>port</code></td>
           <td>服務所接聽的埠。</td>
           </tr>
           </tbody></table>
      3.  儲存變更。
      4.  在叢集中建立服務。

          ```
          kubectl apply -f myalbservice.yaml
          ```
          {: pre}
      5.  針對每個您要公開給大眾使用的應用程式，重複這些步驟。

3. 取得叢集的詳細資料，以檢視 IBM 提供的網域。將 _&lt;cluster_name_or_ID&gt;_ 取代為要公開給大眾使用的應用程式部署所在的叢集名稱。

    ```
    bx cs cluster-get <cluster_name_or_ID>
    ```
    {: pre}

    輸出範例：

    ```
    Name:                   mycluster
    ID:                     18a61a63c6a94b658596ca93d087aad9
    State:                  normal
    Created:                2018-01-12T18:33:35+0000
    Location:               dal10
    Master URL:             https://169.xx.xxx.xxx:26268
    Ingress Subdomain:      mycluster-12345.us-south.containers.mybluemix.net
    Ingress Secret:         <tls_secret>
    Workers:                3
    Version:                1.8.11
    Owner Email:            owner@email.com
    Monitoring Dashboard:   <dashboard_URL>
    ```
    {: screen}

    您可以在 **Ingress subdomain** 欄位中看到 IBM 提供的網域。
4.  建立 Ingress 資源。Ingress 資源會為您為應用程式建立的 Kubernetes 服務定義遞送規則，並且由 ALB 用來將送入的網路資料流量遞送至服務。如果每個應用程式都是透過叢集內的 Kubernetes 服務公開，則您必須使用一個 Ingress 資源來為多個應用程式定義遞送規則。
    1.  例如，開啟偏好的編輯器，然後建立名為 `myingressresource.yaml` 的 Ingress 配置檔。
    2.  在配置檔中定義 Ingress 資源，以使用 IBM 提供的網域將送入的網路資料流量遞送至您先前建立的服務。

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: myingressresource
        spec:
          rules:
          - host: <ibm_domain>
            http:
              paths:
              - path: /<service1_path>
                backend:
                  serviceName: <service1>
                  servicePort: 80
              - path: /<service2_path>
                backend:
                  serviceName: <service2>
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
        <td>將 <em>&lt;ibm_domain&gt;</em> 取代為前一個步驟中的 IBM 提供的 <strong>Ingress subdomain</strong> 名稱。

        </br></br>
        <strong>附註：</strong>請不要使用 * 作為您的主機，也不要讓主機內容保留為空白，以避免建立 Ingress 期間發生失敗。</td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>將 <em>&lt;service1_path&gt;</em> 取代為斜線或應用程式所接聽的唯一路徑，讓網路資料流量可以轉遞至該應用程式。

        </br>
        針對每個 Kubernetes 服務，您可以定義附加至 IBM 所提供之網域的個別路徑，以建立應用程式的唯一路徑，例如 <code>ibm_domain/service1_path</code>。當您在 Web 瀏覽器中輸入此路徑時，網路資料流量就會遞送至 ALB。ALB 會查閱相關聯的服務，將網路資料流量傳送至服務。然後，服務會將資料流量轉遞至應用程式執行所在的 Pod。應用程式必須設定成接聽此路徑，以接收送入的網路資料流量。

        </br></br>
        許多應用程式不會接聽特定路徑，但卻使用根路徑及特定埠。在此情況下，請將根路徑定義為 <code>/</code>，並且不要為應用程式指定個別路徑。</br>
        範例：<ul><li>針對 <code>http://ibm_domain/</code>，輸入 <code>/</code> 作為路徑。</li><li>針對 <code>http://ibm_domain/service1_path</code>，輸入 <code>/service1_path</code> 作為路徑。</li></ul>
        </br>
        <strong>提示：</strong>若要配置 Ingress 接聽與應用程式所接聽路徑不同的路徑，您可以使用[重寫註釋](cs_annotations.html#rewrite-path)來建立應用程式的適當遞送。</td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td>將 <em>&lt;service1&gt;</em> 取代為您為應用程式建立 Kubernetes 服務時所使用的服務名稱。</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>您的服務所接聽的埠。請使用您為應用程式建立 Kubernetes 服務時所定義的相同埠。</td>
        </tr>
        </tbody></table>

    3.  建立叢集的 Ingress 資源。

        ```
        kubectl apply -f myingressresource.yaml
        ```
        {: pre}
5.   驗證已順利建立 Ingress 資源。

      ```
      kubectl describe ingress myingressresource
      ```
      {: pre}

      1. 如果事件中的訊息說明資源配置中的錯誤，請變更資源檔中的值，然後重新套用該資源的檔案。

6.   在 Web 瀏覽器中，輸入要存取的應用程式服務的 URL。

      ```
      https://<ibm_domain>/<service1_path>
      ```
      {: codeblock}


<br />


### 使用 IBM 提供的網域且搭配 TLS 來公用地公開應用程式
{: #ibm_domain_cert}

您可以配置 Ingress ALB 來管理應用程式的送入 TLS 連線、使用 IBM 提供的 TLS 憑證來解密網路資料流量，以及將已解密的要求轉遞至叢集中已公開的應用程式。
{:shortdesc}

開始之前：

-   如果您還沒有叢集，請[建立標準叢集](cs_clusters.html#clusters_ui)。
-   [將 CLI 的目標設為](cs_cli_install.html#cs_cli_configure)叢集，才能執行 `kubectl` 指令。

若要使用 IBM 提供的網域且搭配 TLS 來公開應用程式，請執行下列動作：

1.  [將應用程式部署至叢集](cs_app.html#app_cli)。請確定您已將標籤新增至您部署中配置檔的 meta 資料區段，例如 `app: code`。此標籤是識別您應用程式執行所在之所有 Pod 的必要項目，如此才能將 Pod 包含在 Ingress 負載平衡中。

2.   為您要公開的應用程式建立 Kubernetes 服務。您的應用程式必須由 Kubernet 服務公開，才能由叢集 ALB 包含在 Ingress 負載平衡中。
      1.  例如，開啟偏好的編輯器，然後建立名為 `myalbservice.yaml` 的服務配置檔。
      2.  為 ALB 將公開給大眾使用的應用程式定義服務。

          ```
          apiVersion: v1
          kind: Service
          metadata:
            name: myalbservice
          spec:
            selector:
              <selector_key>: <selector_value>
            ports:
             - protocol: TCP
               port: 8080
          ```
          {: codeblock}

          <table>
          <caption>瞭解 ALB 服務檔元件</caption>
          <thead>
          <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
          </thead>
          <tbody>
          <tr>
          <td><code>selector</code></td>
          <td>輸入標籤金鑰 (<em>&lt;selector_key&gt;</em>) 及值 (<em>&lt;selector_value&gt;</em>) 配對，以用來將應用程式執行所在的 Pod 設為目標。若要將您的 Pod 設為目標，並將它們包含在服務負載平衡中，請確定 <em>&lt;selector_key&gt;</em> 及 <em>&lt;selector_value&gt;</em> 與您在部署 yaml <code>spec.template.metadata.labels</code> 區段使用的金鑰/值配對相同。</td>
           </tr>
           <tr>
           <td><code>port</code></td>
           <td>服務所接聽的埠。</td>
           </tr>
           </tbody></table>
      3.  儲存變更。
      4.  在叢集中建立服務。

          ```
          kubectl apply -f myalbservice.yaml
          ```
          {: pre}
      5.  針對每個您要公開給大眾使用的應用程式，重複這些步驟。

3.   檢視 IBM 提供的網域及 TLS 憑證。將 _&lt;cluster_name_or_ID&gt;_ 取代為應用程式部署到其中的叢集名稱。

      ```
      bx cs cluster-get <cluster_name_or_ID>
      ```
      {: pre}

      輸出範例：

      ```
      Name:                   mycluster
      ID:                     18a61a63c6a94b658596ca93d087aad9
      State:                  normal
      Created:                2018-01-12T18:33:35+0000
      Location:               dal10
      Master URL:             https://169.xx.xxx.xxx:26268
      Ingress Subdomain:      mycluster-12345.us-south.containers.mybluemix.net
      Ingress Secret:         <ibm_tls_secret>
      Workers:                3
      Version:                1.8.11
      Owner Email:            owner@email.com
      Monitoring Dashboard:   <dashboard_URL>
      ```
      {: screen}

      您可以在 **Ingress subdomain** 中看到 IBM 提供的網域，並在 **Ingress secret** 欄位中看到 IBM 提供的憑證。

4.  建立 Ingress 資源。Ingress 資源會為您為應用程式建立的 Kubernetes 服務定義遞送規則，並且由 ALB 用來將送入的網路資料流量遞送至服務。如果每個應用程式都是透過叢集內的 Kubernetes 服務公開，則您必須使用一個 Ingress 資源來為多個應用程式定義遞送規則。
    1.  例如，開啟偏好的編輯器，然後建立名為 `myingressresource.yaml` 的 Ingress 配置檔。
    2.  在配置檔中定義 Ingress 資源，以使用 IBM 提供的網域將送入的網路資料流量遞送至您稍早建立的服務，以及使用自訂憑證來管理 TLS 終止。

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: myingressresource
        spec:
          tls:
          - hosts:
            - <ibm_domain>
            secretName: <ibm_tls_secret>
          rules:
          - host: <ibm_domain>
            http:
              paths:
              - path: /<service1_path>
                backend:
                  serviceName: <service1>
                  servicePort: 80
              - path: /<service2_path>
                backend:
                  serviceName: <service2>
                  servicePort: 80
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
        </thead>
        <tbody>
        <tr>
        <td><code>tls/hosts</code></td>
        <td>將 <em>&lt;ibm_domain&gt;</em> 取代為前一個步驟中的 IBM 提供的 <strong>Ingress subdomain</strong> 名稱。此網域已配置 TLS 終止。

        </br></br>
        <strong>附註：</strong>請不要使用 &ast; 作為您的主機，也不要讓主機內容保留為空白，以避免建立 Ingress 期間發生失敗。</td>
        </tr>
        <tr>
        <td><code>tls/secretName</code></td>
        <td>將 <em>&lt;<ibm_tls_secret>&gt;</em> 取代為前一個步驟中的 IBM 提供的 <strong>Ingress secret</strong> 名稱。此憑證會管理 TLS 終止。
        </tr>
        <tr>
        <td><code>host</code></td>
        <td>將 <em>&lt;ibm_domain&gt;</em> 取代為前一個步驟中的 IBM 提供的 <strong>Ingress subdomain</strong> 名稱。此網域已配置 TLS 終止。

        </br></br>
        <strong>附註：</strong>請不要使用 &ast; 作為您的主機，也不要讓主機內容保留為空白，以避免建立 Ingress 期間發生失敗。</td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>將 <em>&lt;service1_path&gt;</em> 取代為斜線或應用程式所接聽的唯一路徑，讓網路資料流量可以轉遞至該應用程式。

        </br>
        針對每個 Kubernetes 服務，您可以定義附加至 IBM 所提供之網域的個別路徑，以建立應用程式的唯一路徑。當您在 Web 瀏覽器中輸入此路徑時，網路資料流量就會遞送至 ALB。ALB 會查閱相關聯的服務，將網路資料流量傳送至服務。然後，服務會將資料流量轉遞至應用程式執行所在的 Pod。應用程式必須設定成接聽此路徑，以接收送入的網路資料流量。

        </br>
        許多應用程式不會接聽特定路徑，但卻使用根路徑及特定埠。在此情況下，請將根路徑定義為 <code>/</code>，並且不要為應用程式指定個別路徑。

        </br>
        範例：<ul><li>針對 <code>http://ibm_domain/</code>，輸入 <code>/</code> 作為路徑。</li><li>針對 <code>http://ibm_domain/service1_path</code>，輸入 <code>/service1_path</code> 作為路徑。</li></ul>
        <strong>提示：</strong>若要配置 Ingress 接聽與應用程式所接聽路徑不同的路徑，您可以使用[重寫註釋](cs_annotations.html#rewrite-path)來建立應用程式的適當遞送。</td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td>將 <em>&lt;service1&gt;</em> 取代為您為應用程式建立 Kubernetes 服務時所使用的服務名稱。</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>您的服務所接聽的埠。請使用您為應用程式建立 Kubernetes 服務時所定義的相同埠。</td>
        </tr>
        </tbody></table>

    3.  建立叢集的 Ingress 資源。

        ```
        kubectl apply -f myingressresource.yaml
        ```
        {: pre}
5.   驗證已順利建立 Ingress 資源。

      ```
      kubectl describe ingress myingressresource
      ```
      {: pre}

      1. 如果事件中的訊息說明資源配置中的錯誤，請變更資源檔中的值，然後重新套用該資源的檔案。

6.   在 Web 瀏覽器中，輸入要存取的應用程式服務的 URL。

      ```
      https://<ibm_domain>/<service1_path>
      ```
      {: codeblock}


<br />


### 使用自訂網域且搭配 TLS 來公用地公開應用程式
{: #custom_domain_cert}

您可以配置 ALB，將送入的網路資料流量遞送至叢集中的應用程式，以及使用您自己的 TLS 憑證來管理 TLS 終止，同時使用您的自訂網域而非 IBM 提供的網域。
{:shortdesc}

開始之前：

-   如果您還沒有叢集，請[建立標準叢集](cs_clusters.html#clusters_ui)。
-   [將 CLI 的目標設為](cs_cli_install.html#cs_cli_configure)叢集，才能執行 `kubectl` 指令。

若要使用自訂網域且搭配 TLS 來公開應用程式，請執行下列動作：

1.  建立自訂網域。若要建立自訂網域，請使用「網域名稱服務 (DNS)」提供者或 [{{site.data.keyword.Bluemix_notm}}](/docs/infrastructure/dns/getting-started.html#getting-started-with-dns) 來登錄自訂網域。
2.  配置網域，將送入的網路資料流量遞送至 IBM 提供的 ALB。可選擇的選項有：
    -   將 IBM 提供的網域指定為「標準名稱記錄 (CNAME)」，以定義自訂網域的別名。若要尋找 IBM 提供的 Ingress 網域，請執行 `bx cs cluster-get <cluster_name>` 並尋找 **Ingress subdomain** 欄位。
    -   將您的自訂網域對映至 IBM 提供的 ALB 的可攜式公用 IP 位址，方法是將 IP 位址新增為記錄。若要尋找 ALB 的可攜式公用 IP 位址，請執行 `bx cs alb-get <public_alb_ID>`。
3.  匯入或建立 TLS 憑證及金鑰密碼：
    * 如果 TLS 憑證儲存在您要使用的 {{site.data.keyword.cloudcerts_long_notm}} 中，您可以執行下列指令，將其相關聯的密碼匯入至叢集中：

      ```
          bx cs alb-cert-deploy --secret-name <secret_name> --cluster <cluster_name_or_ID> --cert-crn <certificate_crn>
          ```
      {: pre}

    * 如果您沒有 TLS 憑證，請遵循下列步驟：
        1. 建立以 PEM 格式編碼的網域的 TLS 憑證及金鑰。
        2. 建立使用 TLS 憑證及金鑰的密碼。將 <em>&lt;tls_secret_name&gt;</em> 取代為 Kubernetes 密碼的名稱、將 <em>&lt;tls_key_filepath&gt;</em> 取代為自訂 TLS 金鑰檔的路徑，並將 <em>&lt;tls_cert_filepath&gt;</em> 取代為自訂 TLS 憑證檔的路徑。

            ```
            kubectl create secret tls <tls_secret_name> --key <tls_key_filepath> --cert <tls_cert_filepath>
            ```
            {: pre}
4.  [將應用程式部署至叢集](cs_app.html#app_cli)。請確定您已將標籤新增至您部署中配置檔的 meta 資料區段，例如 `app: code`。此標籤是識別您應用程式執行所在之所有 Pod 的必要項目，如此才能將 Pod 包含在 Ingress 負載平衡中。

5.   為您要公開的應用程式建立 Kubernetes 服務。您的應用程式必須由 Kubernet 服務公開，才能由叢集 ALB 包含在 Ingress 負載平衡中。
      1.  例如，開啟偏好的編輯器，然後建立名為 `myalbservice.yaml` 的服務配置檔。
      2.  為 ALB 將公開給大眾使用的應用程式定義服務。

          ```
          apiVersion: v1
          kind: Service
          metadata:
            name: myalbservice
          spec:
            selector:
              <selector_key>: <selector_value>
            ports:
             - protocol: TCP
               port: 8080
          ```
          {: codeblock}

          <table>
          <caption>瞭解 ALB 服務檔元件</caption>
          <thead>
          <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
          </thead>
          <tbody>
          <tr>
          <td><code>selector</code></td>
          <td>輸入標籤金鑰 (<em>&lt;selector_key&gt;</em>) 及值 (<em>&lt;selector_value&gt;</em>) 配對，以用來將應用程式執行所在的 Pod 設為目標。若要將您的 Pod 設為目標，並將它們包含在服務負載平衡中，請確定 <em>&lt;selector_key&gt;</em> 及 <em>&lt;selector_value&gt;</em> 與您在部署 yaml <code>spec.template.metadata.labels</code> 區段使用的金鑰/值配對相同。</td>
           </tr>
           <tr>
           <td><code>port</code></td>
           <td>服務所接聽的埠。</td>
           </tr>
           </tbody></table>
      3.  儲存變更。
      4.  在叢集中建立服務。

          ```
          kubectl apply -f myalbservice.yaml
          ```
          {: pre}
      5.  針對每個您要公開給大眾使用的應用程式，重複這些步驟。

6.  建立 Ingress 資源。Ingress 資源會為您為應用程式建立的 Kubernetes 服務定義遞送規則，並且由 ALB 用來將送入的網路資料流量遞送至服務。如果每個應用程式都是透過叢集內的 Kubernetes 服務公開，則您必須使用一個 Ingress 資源來為多個應用程式定義遞送規則。
    1.  例如，開啟偏好的編輯器，然後建立名為 `myingressresource.yaml` 的 Ingress 配置檔。
    2.  在配置檔中定義 Ingress 資源，以使用自訂網域將送入的網路資料流量遞送至服務，以及使用自訂憑證來管理 TLS 終止。

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: myingressresource
        spec:
          tls:
          - hosts:
            - <custom_domain>
            secretName: <tls_secret_name>
          rules:
          - host: <custom_domain>
            http:
              paths:
              - path: /<service1_path>
                backend:
                  serviceName: <service1>
                  servicePort: 80
              - path: /<service2_path>
                backend:
                  serviceName: <service2>
                  servicePort: 80
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
        </thead>
        <tbody>
        <tr>
        <td><code>tls/hosts</code></td>
        <td>將 <em>&lt;custom_domain&gt;</em> 取代為您要配置 TLS 終止的自訂網域。

        </br></br>
        <strong>附註：</strong>請不要使用 &ast; 作為您的主機，也不要讓主機內容保留為空白，以避免建立 Ingress 期間發生失敗。</td>
        </tr>
        <tr>
        <td><code>tls/secretName</code></td>
        <td>將 <em>&lt;tls_secret_name&gt;</em> 取代為您先前建立的密碼的名稱，而此密碼可保留自訂 TLS 憑證及金鑰。如果您從 {{site.data.keyword.cloudcerts_short}} 匯入了憑證，則可以執行 <code>bx cs alb-cert-get --cluster <cluster_name_or_ID> --cert-crn <certificate_crn></code>，來查看與 TLS 憑證相關聯的密碼。
        </tr>
        <tr>
        <td><code>host</code></td>
        <td>將 <em>&lt;custom_domain&gt;</em> 取代為您要配置 TLS 終止的自訂網域。

        </br></br>
        <strong>附註：</strong>請不要使用 &ast; 作為您的主機，也不要讓主機內容保留為空白，以避免建立 Ingress 期間發生失敗。</td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>將 <em>&lt;service1_path&gt;</em> 取代為斜線或應用程式所接聽的唯一路徑，讓網路資料流量可以轉遞至該應用程式。

        </br>
        針對每個服務，您可以定義附加至自訂網域的個別路徑，以建立應用程式的唯一路徑。當您在 Web 瀏覽器中輸入此路徑時，網路資料流量就會遞送至 ALB。ALB 會查閱相關聯的服務，將網路資料流量傳送至服務。然後，服務會將資料流量轉遞至應用程式執行所在的 Pod。應用程式必須設定成接聽此路徑，以接收送入的網路資料流量。

        </br>
        許多應用程式不會接聽特定路徑，但卻使用根路徑及特定埠。在此情況下，請將根路徑定義為 <code>/</code>，並且不要為應用程式指定個別路徑。

        </br></br>
        範例：<ul><li>針對 <code>https://custom_domain/</code>，輸入 <code>/</code> 作為路徑。</li><li>針對 <code>https://custom_domain/service1_path</code>，輸入 <code>/service1_path</code> 作為路徑。</li></ul>
        <strong>提示：</strong>若要配置 Ingress 接聽與應用程式所接聽路徑不同的路徑，您可以使用[重寫註釋](cs_annotations.html#rewrite-path)來建立應用程式的適當遞送。</td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td>將 <em>&lt;service1&gt;</em> 取代為您為應用程式建立 Kubernetes 服務時所使用的服務名稱。</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>您的服務所接聽的埠。請使用您為應用程式建立 Kubernetes 服務時所定義的相同埠。</td>
        </tr>
        </tbody></table>

    3.  儲存變更。
    4.  建立叢集的 Ingress 資源。

        ```
        kubectl apply -f myingressresource.yaml
        ```
        {: pre}
7.   驗證已順利建立 Ingress 資源。

      ```
      kubectl describe ingress myingressresource
      ```
      {: pre}

      1. 如果事件中的訊息說明資源配置中的錯誤，請變更資源檔中的值，然後重新套用該資源的檔案。

8.   在 Web 瀏覽器中，輸入要存取的應用程式服務的 URL。

      ```
      https://<custom_domain>/<service1_path>
      ```
      {: codeblock}


<br />


### 使用 IBM 提供的網域或自訂網域且搭配 TLS，公用叢集外的應用程式
{: #external_endpoint}

您可以配置 ALB 來納入位於叢集外的應用程式。IBM 提供的網域或自訂網域上的送入要求，會自動轉遞給外部應用程式。
{:shortdesc}

開始之前：

-   如果您還沒有叢集，請[建立標準叢集](cs_clusters.html#clusters_ui)。
-   [將 CLI 的目標設為](cs_cli_install.html#cs_cli_configure)叢集，才能執行 `kubectl` 指令。
-   確定您可以使用公用 IP 位址來存取您要包含在叢集負載平衡中的外部應用程式。

您可以將 IBM 所提供網域上的送入網路資料流量遞送至位於叢集外部的應用程式。如果您要改用自訂網域及 TLS 憑證，請將 IBM 提供的網域及 TLS 憑證取代為[自訂網域及 TLS 憑證](#custom_domain_cert)。

1.  針對將送入的要求轉遞至您將建立的外部端點的叢集，建立 Kubernetes 服務。
    1.  例如，開啟偏好的編輯器，然後建立名為 `myexternalservice.yaml` 的服務配置檔。
    2.  定義 ALB 服務。

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: myexternalservice
        spec:
          ports:
           - protocol: TCP
             port: 8080
        ```
        {: codeblock}

        <table>
        <caption>瞭解 ALB 服務檔元件</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
        </thead>
        <tbody>
        <tr>
        <td><code>metadata/name</code></td>
        <td>將 <em>&lt;myexternalservice&gt;</em> 取代為您服務的名稱。</td>
        </tr>
        <tr>
        <td><code>port</code></td>
        <td>服務所接聽的埠。</td>
        </tr></tbody></table>

    3.  儲存變更。
    4.  建立叢集的 Kubernetes 服務。

        ```
        kubectl apply -f myexternalservice.yaml
        ```
        {: pre}
2.  配置 Kubernetes 端點，以定義您要包含在叢集負載平衡中的應用程式的外部位置。
    1.  例如，開啟偏好的編輯器，然後建立名為 `myexternalendpoint.yaml` 的端點配置檔。
    2.  定義外部端點。請包含您可用來存取外部應用程式的所有公用 IP 位址及埠。

        ```
        kind: Endpoints
        apiVersion: v1
        metadata:
          name: myexternalendpoint
        subsets:
          - addresses:
              - ip: <external_IP1>
              - ip: <external_IP2>
            ports:
              - port: <external_port>
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>將 <em>&lt;myexternalendpoint&gt;</em> 取代為您先前建立的 Kubernetes 服務的名稱。</td>
        </tr>
        <tr>
        <td><code>ip</code></td>
        <td>將 <em>&lt;external_IP&gt;</em> 取代為用來連接至外部應用程式的公用 IP 位址。</td>
         </tr>
         <td><code>port</code></td>
         <td>將 <em>&lt;external_port&gt;</em> 取代為外部應用程式所接聽的埠。</td>
         </tbody></table>

    3.  儲存變更。
    4.  建立叢集的 Kubernetes 端點。

        ```
        kubectl apply -f myexternalendpoint.yaml
        ```
        {: pre}
3.   檢視 IBM 提供的網域及 TLS 憑證。將 _&lt;cluster_name_or_ID&gt;_ 取代為應用程式部署到其中的叢集名稱。

      ```
      bx cs cluster-get <cluster_name_or_ID>
      ```
      {: pre}

      輸出範例：

      ```
      Name:                   mycluster
      ID:                     18a61a63c6a94b658596ca93d087aad9
      State:                  normal
      Created:                2018-01-12T18:33:35+0000
      Location:               dal10
      Master URL:             https://169.xx.xxx.xxx:26268
      Ingress Subdomain:      mycluster-12345.us-south.containers.mybluemix.net
      Ingress Secret:         <ibm_tls_secret>
      Workers:                3
      Version:                1.8.11
      Owner Email:            owner@email.com
      Monitoring Dashboard:   <dashboard_URL>
      ```
      {: screen}

      您可以在 **Ingress subdomain** 中看到 IBM 提供的網域，並在 **Ingress secret** 欄位中看到 IBM 提供的憑證。

4.  建立 Ingress 資源。Ingress 資源會為您為應用程式建立的 Kubernetes 服務定義遞送規則，並且由 ALB 用來將送入的網路資料流量遞送至服務。只要每個應用程式都是透過叢集內的 Kubernetes 服務使用其外部端點公開時，您就可以使用一個 Ingress 資源來為多個外部應用程式定義遞送規則。
    1.  例如，開啟偏好的編輯器，然後建立名為 `myexternalingress.yaml` 的 Ingress 配置檔。
    2.  在配置檔中定義 Ingress 資源，以使用 IBM 提供的網域及 TLS 憑證將送入的網路資料流量遞送至外部應用程式，方法是使用您先前定義的外部端點。

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: myexternalingress
        spec:
          tls:
          - hosts:
            - <ibm_domain>
            secretName: <ibm_tls_secret>
          rules:
          - host: <ibm_domain>
            http:
              paths:
              - path: /<external_service1_path>
                backend:
                  serviceName: <external_service1>
                  servicePort: 80
              - path: /<external_service2_path>
                backend:
                  serviceName: <external_service2>
                  servicePort: 80
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
        </thead>
        <tbody>
        <tr>
        <td><code>tls/hosts</code></td>
        <td>將 <em>&lt;ibm_domain&gt;</em> 取代為前一個步驟中的 IBM 提供的 <strong>Ingress subdomain</strong> 名稱。此網域已配置 TLS 終止。

        </br></br>
        <strong>附註：</strong>請不要使用 &ast; 作為您的主機，也不要讓主機內容保留為空白，以避免建立 Ingress 期間發生失敗。</td>
        </tr>
        <tr>
        <td><code>tls/secretName</code></td>
        <td>將 <em>&lt;ibm_tls_secret&gt;</em> 取代為前一個步驟中的 IBM 提供的 <strong>Ingress secret</strong>。此憑證會管理 TLS 終止。
        </td>
        </tr>
        <tr>
        <td><code>rules/host</code></td>
        <td>將 <em>&lt;ibm_domain&gt;</em> 取代為前一個步驟中的 IBM 提供的 <strong>Ingress subdomain</strong> 名稱。此網域已配置 TLS 終止。

        </br></br>
        <strong>附註：</strong>請不要使用 &ast; 作為您的主機，也不要讓主機內容保留為空白，以避免建立 Ingress 期間發生失敗。</td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>將 <em>&lt;external_service_path&gt;</em> 取代為斜線或外部應用程式所接聽的唯一路徑，以將網路資料流量轉遞至應用程式。

        </br>
        針對每個服務，您可以定義附加至 IBM 所提供網域或自訂網域的個別路徑，以建立應用程式的唯一路徑，例如 <code>http://ibm_domain/external_service_path</code> 或 <code>http://custom_domain/</code>。當您在 Web 瀏覽器中輸入此路徑時，網路資料流量就會遞送至 ALB。ALB 會查閱相關聯的服務，將網路資料流量傳送至服務。服務便將資料流量轉遞至外部應用程式。應用程式必須設定成接聽此路徑，以接收送入的網路資料流量。

        </br></br>
        許多應用程式不會接聽特定路徑，但卻使用根路徑及特定埠。在此情況下，請將根路徑定義為 <code>/</code>，並且不要為應用程式指定個別路徑。

        </br></br>
        <strong>提示：</strong>若要配置 Ingress 接聽與應用程式所接聽路徑不同的路徑，您可以使用[重寫註釋](cs_annotations.html#rewrite-path)來建立應用程式的適當遞送。</td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td>將 <em>&lt;external_service&gt;</em> 取代為您為外部應用程式建立 Kubernetes 服務時所使用的服務名稱。</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>您的服務所接聽的埠。</td>
        </tr>
        </tbody></table>

    3.  儲存變更。
    4.  建立叢集的 Ingress 資源。

        ```
        kubectl apply -f myexternalingress.yaml
        ```
        {: pre}
5.   驗證已順利建立 Ingress 資源。

      ```
      kubectl describe ingress myingressresource
      ```
      {: pre}

      1. 如果事件中的訊息說明資源配置中的錯誤，請變更資源檔中的值，然後重新套用該資源的檔案。

6.   在 Web 瀏覽器中，輸入要存取的應用程式服務的 URL。

      ```
      https://<ibm_domain>/<service1_path>
      ```
      {: codeblock}


<br />


## 將應用程式公開給專用網路使用
{: #ingress_expose_private}

您建立標準叢集時，會建立 IBM 提供的應用程式負載平衡器 (ALB)，並為其指派可攜式專用 IP 位址及專用路徑。不過，不會自動啟用預設專用 ALB。
{:shortdesc}

若要將應用程式公開給專用網路使用，請先[啟用預設專用應用程式負載平衡器](#private_ingress)。

然後，您可以針對下列情境配置 Ingress。
-   [使用外部 DNS 提供者，使用自訂網域且不搭配 TLS 來專用地公開應用程式。](#private_ingress_no_tls)
-   [使用外部 DNS 提供者，使用自訂網域且搭配 TLS 來專用地公開應用程式。](#private_ingress_tls)
-   [使用內部部署 DNS 服務來專用地公開應用程式。](#private_ingress_onprem_dns)

### 啟用預設專用應用程式負載平衡器
{: #private_ingress}

在可以使用預設專用 ALB 之前，您必須使用 IBM 所提供的可攜式專用 IP 位址，或您自己的可攜式專用 IP 位址來予以啟用。
{:shortdesc}

**附註**：如果您在建立叢集時使用 `--no-subnet` 旗標，則必須先新增可攜式專用子網路或使用者管理的子網路之後，您才能啟用專用 ALB。如需相關資訊，請參閱[要求叢集的其他子網路](cs_subnets.html#request)。

開始之前：

-   如果您還沒有叢集，請[建立標準叢集](cs_clusters.html#clusters_ui)。
-   [將 CLI 的目標設為](cs_cli_install.html#cs_cli_configure)您的叢集。

若要使用預先指派、且由 IBM 提供的可攜式專用 IP 位址來啟用專用 ALB，請執行下列動作：

1. 列出叢集中可用的 ALB，以取得專用 ALB 的 ID。將 <em>&lt;cluser_name&gt;</em> 取代為您要公開之應用程式部署所在的叢集名稱。

    ```
    bx cs albs --cluster <cluser_name>
    ```
    {: pre}

    專用 ALB 的 **Status** 欄位為 _disabled_。
    ```
    ALB ID                                            Enabled   Status     Type      ALB IP
    private-cr6d779503319d419ea3b4ab171d12c3b8-alb1   false     disabled   private   -
    public-cr6d779503319d419ea3b4ab171d12c3b8-alb1    true      enabled    public    169.xx.xxx.xxx
    ```
    {: screen}

2. 啟用專用 ALB。將 <em>&lt;private_ALB_ID&gt;</em> 取代為專用 ALB 的 ID（來自前一個步驟中的輸出）。

   ```
   bx cs alb-configure --albID <private_ALB_ID> --enable
   ```
   {: pre}


若要使用您自己的可攜式專用 IP 位址來啟用專用 ALB，請執行下列動作：

1. 配置所選擇 IP 位址之使用者管理的子網路，以遞送叢集之專用 VLAN 上的資料流量。將 <em>&lt;cluser_name&gt;</em> 取代為您要公開之應用程式部署所在的叢集名稱或 ID、將 <em>&lt;subnet_CIDR&gt;</em> 取代為使用者管理之子網路的 CIDR，並將 <em>&lt;private_VLAN_ID&gt;</em> 取代為可用的專用 VLAN ID。您可以藉由執行 `bx cs vlsans`，來尋找可用的專用 VLAN ID。

   ```
   bx cs cluster-user-subnet-add <cluster_name> <subnet_CIDR> <private_VLAN_ID>
   ```
   {: pre}

2. 列出叢集中可用的 ALB，以取得專用 ALB 的 ID。

    ```
    bx cs albs --cluster <cluster_name>
    ```
    {: pre}

    專用 ALB 的 **Status** 欄位為 _disabled_。
    ```
    ALB ID                                            Enabled   Status     Type      ALB IP
    private-cr6d779503319d419ea3b4ab171d12c3b8-alb1   false     disabled   private   -
    public-cr6d779503319d419ea3b4ab171d12c3b8-alb1    true      enabled    public    169.xx.xxx.xxx
    ```
    {: screen}

3. 啟用專用 ALB。將 <em>&lt;private_ALB_ID&gt;</em> 取代為專用 ALB 的 ID（來自前一個步驟中的輸出），並將 <em>&lt;user_IP&gt;</em> 取代為您要使用之使用者所管理子網路的 IP 位址。

   ```
   bx cs alb-configure --albID <private_ALB_ID> --enable --user-ip <user_IP>
   ```
   {: pre}

<br />


### 使用外部 DNS 提供者，使用自訂網域且不搭配 TLS 來專用地公開應用程式。
{: #private_ingress_no_tls}

您可以配置專用 ALB，使用自訂網域將送入的網路資料流量遞送至叢集中的應用程式。
{:shortdesc}

開始之前：
* [啟用專用應用程式負載平衡器](#private_ingress)。
* 如果您有專用工作者節點，且想要使用外部 DNS 提供者，您必須[配置具備公用存取權的邊緣節點](cs_edge.html#edge)，以及[配置 Vyatta Gateway Appliance ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/blogs/bluemix/2017/07/kubernetes-and-bluemix-container-based-workloads-part4/)。如果您只想保留在專用網路上，請改為參閱[使用內部部署 DNS 服務來專用地公開應用程式](#private_ingress_onprem_dns)。

若要使用外部 DNS 提供者，使用自訂網域且不搭配 TLS 來專用地公開應用程式，請執行下列動作：

1.  建立自訂網域。若要建立自訂網域，請使用「網域名稱服務 (DNS)」提供者或 [{{site.data.keyword.Bluemix_notm}}](/docs/infrastructure/dns/getting-started.html#getting-started-with-dns) 來登錄自訂網域。
2.  將您的自訂網域對映至 IBM 提供的專用 ALB 的可攜式專用 IP 位址，方法是將 IP 位址新增為記錄。若要尋找專用 ALB 的可攜式專用 IP 位址，請執行 `bx cs albs --cluster <cluster_name>`.
3.  [將應用程式部署至叢集](cs_app.html#app_cli)。請確定您已將標籤新增至您部署中配置檔的 meta 資料區段，例如 `app: code`。此標籤是識別您應用程式執行所在之所有 Pod 的必要項目，如此才能將 Pod 包含在 Ingress 負載平衡中。

4.   為您要公開的應用程式建立 Kubernetes 服務。您的應用程式必須由 Kubernet 服務公開，才能由叢集 ALB 包含在 Ingress 負載平衡中。
      1.  例如，開啟偏好的編輯器，然後建立名為 `myalbservice.yaml` 的服務配置檔。
      2.  為 ALB 將公開給專用網路使用的應用程式定義服務。

          ```
          apiVersion: v1
          kind: Service
          metadata:
            name: myalbservice
          spec:
            selector:
              <selector_key>: <selector_value>
            ports:
             - protocol: TCP
               port: 8080
          ```
          {: codeblock}

          <table>
          <caption>瞭解 ALB 服務檔元件</caption>
          <thead>
          <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
          </thead>
          <tbody>
          <tr>
          <td><code>selector</code></td>
          <td>輸入標籤金鑰 (<em>&lt;selector_key&gt;</em>) 及值 (<em>&lt;selector_value&gt;</em>) 配對，以用來將應用程式執行所在的 Pod 設為目標。若要將您的 Pod 設為目標，並將它們包含在服務負載平衡中，請確定 <em>&lt;selector_key&gt;</em> 及 <em>&lt;selector_value&gt;</em> 與您在部署 yaml <code>spec.template.metadata.labels</code> 區段使用的金鑰/值配對相同。</td>
           </tr>
           <tr>
           <td><code>port</code></td>
           <td>服務所接聽的埠。</td>
           </tr>
           </tbody></table>
      3.  儲存變更。
      4.  在叢集中建立服務。

          ```
          kubectl apply -f myalbservice.yaml
          ```
          {: pre}
      5.  針對每個您要公開給專用網路使用的應用程式，重複這些步驟。

5.  建立 Ingress 資源。Ingress 資源會為您為應用程式建立的 Kubernetes 服務定義遞送規則，並且由 ALB 用來將送入的網路資料流量遞送至服務。如果每個應用程式都是透過叢集內的 Kubernetes 服務公開，則您必須使用一個 Ingress 資源來為多個應用程式定義遞送規則。
    1.  例如，開啟偏好的編輯器，然後建立名為 `myingressresource.yaml` 的 Ingress 配置檔。
    2.  在配置檔中定義 Ingress 資源，以使用自訂網域將送入的網路資料流量遞送至您的服務。

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: myingressresource
          annotations:
            ingress.bluemix.net/ALB-ID: "<private_ALB_ID>"
        spec:
          rules:
          - host: <custom_domain>
            http:
              paths:
              - path: /<service1_path>
                backend:
                  serviceName: <service1>
                  servicePort: 80
              - path: /<service2_path>
                backend:
                  serviceName: <service2>
                  servicePort: 80
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
        </thead>
        <tbody>
        <tr>
        <td><code>ingress.bluemix.net/ALB-ID</code></td>
        <td>將 <em>&lt;private_ALB_ID&gt;</em> 取代為專用 ALB 的 ID。執行 <code>bx cs albs --cluster <my_cluster></code> 以尋找 ALB ID。如需此 Ingress 註釋的相關資訊，請參閱[專用應用程式負載平衡器遞送](cs_annotations.html#alb-id)。</td>
        </tr>
        <td><code>host</code></td>
        <td>將 <em>&lt;custom_domain&gt;</em> 取代為自訂網域。

        </br></br>
        <strong>附註：</strong>請不要使用 &ast; 作為您的主機，也不要讓主機內容保留為空白，以避免建立 Ingress 期間發生失敗。</td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>將 <em>&lt;service1_path&gt;</em> 取代為斜線或應用程式所接聽的唯一路徑，讓網路資料流量可以轉遞至該應用程式。

        </br>

                針對每個服務，您可以定義附加至自訂網域的個別路徑，以建立應用程式的唯一路徑。當您在 Web 瀏覽器中輸入此路徑時，網路資料流量就會遞送至 ALB。ALB 會查閱相關聯的服務，將網路資料流量傳送至服務。然後，服務會將資料流量轉遞至應用程式執行所在的 Pod。應用程式必須設定成接聽此路徑，以接收送入的網路資料流量。

        </br>
        許多應用程式不會接聽特定路徑，但卻使用根路徑及特定埠。在此情況下，請將根路徑定義為 <code>/</code>，並且不要為應用程式指定個別路徑。

        </br></br>
        範例：<ul><li>針對 <code>https://custom_domain/</code>，輸入 <code>/</code> 作為路徑。</li><li>針對 <code>https://custom_domain/service1_path</code>，輸入 <code>/service1_path</code> 作為路徑。</li></ul>
        <strong>提示：</strong>若要配置 Ingress 接聽與應用程式所接聽路徑不同的路徑，您可以使用[重寫註釋](cs_annotations.html#rewrite-path)來建立應用程式的適當遞送。</td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td>將 <em>&lt;service1&gt;</em> 取代為您為應用程式建立 Kubernetes 服務時所使用的服務名稱。</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>您的服務所接聽的埠。請使用您為應用程式建立 Kubernetes 服務時所定義的相同埠。</td>
        </tr>
        </tbody></table>

    3.  儲存變更。
    4.  建立叢集的 Ingress 資源。

        ```
        kubectl apply -f myingressresource.yaml
        ```
        {: pre}
6.   驗證已順利建立 Ingress 資源。

      ```
      kubectl describe ingress myingressresource
      ```
      {: pre}

      1. 如果事件中的訊息說明資源配置中的錯誤，請變更資源檔中的值，然後重新套用該資源的檔案。

7.   在 Web 瀏覽器中，輸入要存取的應用程式服務的 URL。

      ```
      https://<custom_domain>/<service1_path>
      ```
      {: codeblock}


<br />


### 使用外部 DNS 提供者，使用自訂網域且搭配 TLS 來專用地公開應用程式。
{: #private_ingress_tls}

您可以使用專用 ALB，將送入的網路資料流量遞送至叢集中的應用程式。此外，在使用自訂網域時，請使用您自己的 TLS 憑證來管理 TLS 終止。
{:shortdesc}

開始之前：
* [啟用專用應用程式負載平衡器](#private_ingress)。
* 如果您有專用工作者節點，且想要使用外部 DNS 提供者，您必須[配置具備公用存取權的邊緣節點](cs_edge.html#edge)，以及[配置 Vyatta Gateway Appliance ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/blogs/bluemix/2017/07/kubernetes-and-bluemix-container-based-workloads-part4/)。如果您只想保留在專用網路上，請改為參閱[使用內部部署 DNS 服務來專用地公開應用程式](#private_ingress_onprem_dns)。

若要使用外部 DNS 提供者，使用自訂網域且搭配 TLS 來專用地公開應用程式，請執行下列動作：

1.  建立自訂網域。若要建立自訂網域，請使用「網域名稱服務 (DNS)」提供者或 [{{site.data.keyword.Bluemix_notm}}](/docs/infrastructure/dns/getting-started.html#getting-started-with-dns) 來登錄自訂網域。
2.  將您的自訂網域對映至 IBM 提供的專用 ALB 的可攜式專用 IP 位址，方法是將 IP 位址新增為記錄。若要尋找專用 ALB 的可攜式專用 IP 位址，請執行 `bx cs albs --cluster <cluster_name>`.
3.  匯入或建立 TLS 憑證及金鑰密碼：
    * 如果 TLS 憑證儲存在您要使用的 {{site.data.keyword.cloudcerts_long_notm}} 中，您可以執行下列指令，將其相關聯的密碼匯入至叢集中：`bx cs alb-cert-deploy --secret-name <secret_name> --cluster <cluster_name_or_ID> --cert-crn <certificate_crn>`.
    * 如果您沒有 TLS 憑證，請遵循下列步驟：
        1. 建立以 PEM 格式編碼的網域的 TLS 憑證及金鑰。
        2. 建立使用 TLS 憑證及金鑰的密碼。將 <em>&lt;tls_secret_name&gt;</em> 取代為 Kubernetes 密碼的名稱、將 <em>&lt;tls_key_filepath&gt;</em> 取代為自訂 TLS 金鑰檔的路徑，並將 <em>&lt;tls_cert_filepath&gt;</em> 取代為自訂 TLS 憑證檔的路徑。

            ```
            kubectl create secret tls <tls_secret_name> --key <tls_key_filepath> --cert <tls_cert_filepath>
            ```
            {: pre}
4.  [將應用程式部署至叢集](cs_app.html#app_cli)。請確定您已將標籤新增至您部署中配置檔的 meta 資料區段，例如 `app: code`。此標籤是識別您應用程式執行所在之所有 Pod 的必要項目，如此才能將 Pod 包含在 Ingress 負載平衡中。

5.   為您要公開的應用程式建立 Kubernetes 服務。您的應用程式必須由 Kubernet 服務公開，才能由叢集 ALB 包含在 Ingress 負載平衡中。
      1.  例如，開啟偏好的編輯器，然後建立名為 `myalbservice.yaml` 的服務配置檔。
      2.  為 ALB 將公開給專用網路使用的應用程式定義服務。

          ```
          apiVersion: v1
          kind: Service
          metadata:
            name: myalbservice
          spec:
            selector:
              <selector_key>: <selector_value>
            ports:
             - protocol: TCP
               port: 8080
          ```
          {: codeblock}

          <table>
          <caption>瞭解 ALB 服務檔元件</caption>
          <thead>
          <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
          </thead>
          <tbody>
          <tr>
          <td><code>selector</code></td>
          <td>輸入標籤金鑰 (<em>&lt;selector_key&gt;</em>) 及值 (<em>&lt;selector_value&gt;</em>) 配對，以用來將應用程式執行所在的 Pod 設為目標。若要將您的 Pod 設為目標，並將它們包含在服務負載平衡中，請確定 <em>&lt;selector_key&gt;</em> 及 <em>&lt;selector_value&gt;</em> 與您在部署 yaml <code>spec.template.metadata.labels</code> 區段使用的金鑰/值配對相同。</td>
           </tr>
           <tr>
           <td><code>port</code></td>
           <td>服務所接聽的埠。</td>
           </tr>
           </tbody></table>
      3.  儲存變更。
      4.  在叢集中建立服務。

          ```
          kubectl apply -f myalbservice.yaml
          ```
          {: pre}
      5.  針對每個您要公開給專用網路使用的應用程式，重複這些步驟。

6.  建立 Ingress 資源。Ingress 資源會為您為應用程式建立的 Kubernetes 服務定義遞送規則，並且由 ALB 用來將送入的網路資料流量遞送至服務。如果每個應用程式都是透過叢集內的 Kubernetes 服務公開，則您必須使用一個 Ingress 資源來為多個應用程式定義遞送規則。
    1.  例如，開啟偏好的編輯器，然後建立名為 `myingressresource.yaml` 的 Ingress 配置檔。
    2.  在配置檔中定義 Ingress 資源，以使用自訂網域將送入的網路資料流量遞送至服務，以及使用自訂憑證來管理 TLS 終止。

          ```
          apiVersion: extensions/v1beta1
          kind: Ingress
          metadata:
            name: myingressresource
            annotations:
              ingress.bluemix.net/ALB-ID: "<private_ALB_ID>"
          spec:
            tls:
            - hosts:
              - <custom_domain>
              secretName: <tls_secret_name>
            rules:
            - host: <custom_domain>
              http:
                paths:
                - path: /<service1_path>
                  backend:
                    serviceName: <service1>
                    servicePort: 80
                - path: /<service2_path>
                  backend:
                    serviceName: <service2>
                    servicePort: 80
           ```
           {: pre}

           <table>
          <thead>
          <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
          </thead>
          <tbody>
          <tr>
          <td><code>ingress.bluemix.net/ALB-ID</code></td>
          <td>將 <em>&lt;private_ALB_ID&gt;</em> 取代為專用 ALB 的 ID。執行 <code>bx cs albs --cluster <cluster_name></code> 以尋找 ALB ID。如需此 Ingress 註釋的相關資訊，請參閱[專用應用程式負載平衡器遞送 (ALB-ID)](cs_annotations.html#alb-id)。</td>
          </tr>
          <tr>
          <td><code>tls/hosts</code></td>
          <td>將 <em>&lt;custom_domain&gt;</em> 取代為您要配置 TLS 終止的自訂網域。

          </br></br>
          <strong>附註：</strong>請不要使用 &ast; 作為您的主機，也不要讓主機內容保留為空白，以避免建立 Ingress 期間發生失敗。</td>
          </tr>
          <tr>
          <td><code>tls/secretName</code></td>
          <td>將 <em>&lt;tls_secret_name&gt;</em> 取代為您先前建立的密碼的名稱，而且此密碼保留自訂 TLS 憑證及金鑰。如果您從 {{site.data.keyword.cloudcerts_short}} 匯入了憑證，則可以執行 <code>bx cs alb-cert-get --cluster <cluster_name_or_ID> --cert-crn <certificate_crn></code>，來查看與 TLS 憑證相關聯的密碼。
        </tr>
          <tr>
          <td><code>host</code></td>
          <td>將 <em>&lt;custom_domain&gt;</em> 取代為您要配置 TLS 終止的自訂網域。

          </br></br>
          <strong>附註：</strong>請不要使用 &ast; 作為您的主機，也不要讓主機內容保留為空白，以避免建立 Ingress 期間發生失敗。</td>
          </tr>
          <tr>
          <td><code>path</code></td>
          <td>將 <em>&lt;service1_path&gt;</em> 取代為斜線或應用程式所接聽的唯一路徑，讓網路資料流量可以轉遞至該應用程式。

          </br>
        針對每個服務，您可以定義附加至自訂網域的個別路徑，以建立應用程式的唯一路徑。當您在 Web 瀏覽器中輸入此路徑時，網路資料流量就會遞送至 ALB。ALB 會查閱相關聯的服務，將網路資料流量傳送至服務，然後使用相同路徑傳送至執行該應用程式的 Pod。應用程式必須設定成接聽此路徑，以接收送入的網路資料流量。

          </br>
        許多應用程式不會接聽特定路徑，但卻使用根路徑及特定埠。在此情況下，請將根路徑定義為 <code>/</code>，並且不要為應用程式指定個別路徑。

          </br></br>
        範例：<ul><li>針對 <code>https://custom_domain/</code>，輸入 <code>/</code> 作為路徑。</li><li>針對 <code>https://custom_domain/service1_path</code>，輸入 <code>/service1_path</code> 作為路徑。</li></ul>
          <strong>提示：</strong>若要配置 Ingress 接聽與應用程式所接聽路徑不同的路徑，您可以使用[重寫註釋](cs_annotations.html#rewrite-path)來建立應用程式的適當遞送。</td>
          </tr>
          <tr>
          <td><code>serviceName</code></td>
          <td>將 <em>&lt;service1&gt;</em> 取代為您為應用程式建立 Kubernetes 服務時所使用的服務名稱。</td>
          </tr>
          <tr>
          <td><code>servicePort</code></td>
          <td>您的服務所接聽的埠。請使用您為應用程式建立 Kubernetes 服務時所定義的相同埠。</td>
          </tr>
           </tbody></table>

    3.  儲存變更。
    4.  建立叢集的 Ingress 資源。

        ```
        kubectl apply -f myingressresource.yaml
        ```
        {: pre}
7.   驗證已順利建立 Ingress 資源。

      ```
      kubectl describe ingress myingressresource
      ```
      {: pre}

      1. 如果事件中的訊息說明資源配置中的錯誤，請變更資源檔中的值，然後重新套用該資源的檔案。

8.   在 Web 瀏覽器中，輸入要存取的應用程式服務的 URL。

      ```
      https://<custom_domain>/<service1_path>
      ```
      {: codeblock}


關於如何使用專用 ALB 且搭配 TLS 來保護叢集之間的微服務到微服務通訊的安全，如需全面性指導教學，請參閱 [本部落格文章![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")]](https://medium.com/ibm-cloud/secure-microservice-to-microservice-communication-across-kubernetes-clusters-using-a-private-ecbe2a8d4fe2)。

<br />


### 使用內部部署 DNS 服務來專用地公開應用程式
{: #private_ingress_onprem_dns}

您可以配置專用 ALB，使用自訂網域將送入的網路資料流量遞送至叢集中的應用程式。當您有專用工作者節點且想要保留在專用網路上時，您可以使用專用內部部署的 DNS 來解析應用程式的 URL 要求。
{:shortdesc}

1. [啟用專用應用程式負載平衡器](#private_ingress)。
2. 若要容許專用工作者節點與 Kibernate 主節點通訊，請[設定 VPN 連線功能](cs_vpn.html)。
3. [配置 DNS 服務 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/)。
4. 建立自訂網域，並向您的 DNS 服務登錄它。
5.  將您的自訂網域對映至 IBM 提供的專用 ALB 的可攜式專用 IP 位址，方法是將 IP 位址新增為記錄。若要尋找專用 ALB 的可攜式專用 IP 位址，請執行 `bx cs albs --cluster <cluster_name>`.
6.  [將應用程式部署至叢集](cs_app.html#app_cli)。請確定您已將標籤新增至您部署中配置檔的 meta 資料區段，例如 `app: code`。此標籤是識別您應用程式執行所在之所有 Pod 的必要項目，如此才能將 Pod 包含在 Ingress 負載平衡中。

7.   為您要公開的應用程式建立 Kubernetes 服務。您的應用程式必須由 Kubernet 服務公開，才能由叢集 ALB 包含在 Ingress 負載平衡中。
      1.  例如，開啟偏好的編輯器，然後建立名為 `myalbservice.yaml` 的服務配置檔。
      2.  為 ALB 將公開給專用網路使用的應用程式定義服務。

          ```
          apiVersion: v1
          kind: Service
          metadata:
            name: myalbservice
          spec:
            selector:
              <selector_key>: <selector_value>
            ports:
             - protocol: TCP
               port: 8080
          ```
          {: codeblock}

          <table>
          <caption>瞭解 ALB 服務檔元件</caption>
          <thead>
          <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
          </thead>
          <tbody>
          <tr>
          <td><code>selector</code></td>
          <td>輸入標籤金鑰 (<em>&lt;selector_key&gt;</em>) 及值 (<em>&lt;selector_value&gt;</em>) 配對，以用來將應用程式執行所在的 Pod 設為目標。若要將您的 Pod 設為目標，並將它們包含在服務負載平衡中，請確定 <em>&lt;selector_key&gt;</em> 及 <em>&lt;selector_value&gt;</em> 與您在部署 yaml <code>spec.template.metadata.labels</code> 區段使用的金鑰/值配對相同。</td>
           </tr>
           <tr>
           <td><code>port</code></td>
           <td>服務所接聽的埠。</td>
           </tr>
           </tbody></table>
      3.  儲存變更。
      4.  在叢集中建立服務。

          ```
          kubectl apply -f myalbservice.yaml
          ```
          {: pre}
      5.  針對每個您要公開給專用網路使用的應用程式，重複這些步驟。

8.  建立 Ingress 資源。Ingress 資源會為您為應用程式建立的 Kubernetes 服務定義遞送規則，並且由 ALB 用來將送入的網路資料流量遞送至服務。如果每個應用程式都是透過叢集內的 Kubernetes 服務公開，則您必須使用一個 Ingress 資源來為多個應用程式定義遞送規則。
  1.  例如，開啟偏好的編輯器，然後建立名為 `myingressresource.yaml` 的 Ingress 配置檔。
  2.  在配置檔中定義 Ingress 資源，以使用自訂網域將送入的網路資料流量遞送至您的服務。

    **附註**：如果您不想使用 TLS，請移除下列範例中的 `tls` 區段。

    ```
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: myingressresource
      annotations:
        ingress.bluemix.net/ALB-ID: "<private_ALB_ID>"
    spec:
      tls:
      - hosts:
        - <custom_domain>
        secretName: <tls_secret_name>
      rules:
      - host: <custom_domain>
        http:
          paths:
          - path: /<service1_path>
            backend:
              serviceName: <service1>
              servicePort: 80
          - path: /<service2_path>
            backend:
              serviceName: <service2>
              servicePort: 80
     ```
     {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
    </thead>
    <tbody>
    <tr>
    <td><code>ingress.bluemix.net/ALB-ID</code></td>
    <td>將 <em>&lt;private_ALB_ID&gt;</em> 取代為專用 ALB 的 ID。執行 <code>bx cs albs --cluster <my_cluster></code> 以尋找 ALB ID。如需此 Ingress 註釋的相關資訊，請參閱[專用應用程式負載平衡器遞送 (ALB-ID)](cs_annotations.html#alb-id)。</td>
    </tr>
    <tr>
    <td><code>tls/hosts</code></td>
    <td>如果您使用 `tls` 區段，請將 <em>&lt;custom_domain&gt;</em> 取代為您要配置 TLS 終止的自訂網域。</br></br>
    <strong>附註：</strong>請不要使用 &ast; 作為您的主機，也不要讓主機內容保留為空白，以避免建立 Ingress 期間發生失敗。</td>
    </tr>
    <tr>
    <td><code>tls/secretName</code></td>
    <td>如果您使用 `tls` 區段，請將 <em>&lt;tls_secret_name&gt;</em> 取代為您先前建立的密碼的名稱，而且此密碼保留自訂 TLS 憑證及金鑰。如果您從 {{site.data.keyword.cloudcerts_short}} 匯入了憑證，則可以執行 <code>bx cs alb-cert-get --cluster <cluster_name_or_ID> --cert-crn <certificate_crn></code>，來查看與 TLS 憑證相關聯的密碼。
        </tr>
    <tr>
    <td><code>host</code></td>
    <td>將 <em>&lt;custom_domain&gt;</em> 取代為您要配置 TLS 終止的自訂網域。</br></br>
    <strong>附註：</strong>請不要使用 &ast; 作為您的主機，也不要讓主機內容保留為空白，以避免建立 Ingress 期間發生失敗。</td>
    </tr>
    <tr>
    <td><code>path</code></td>
    <td>將 <em>&lt;service1_path&gt;</em> 取代為斜線或應用程式所接聽的唯一路徑，讓網路資料流量可以轉遞至該應用程式。</br>
        針對每個服務，您可以定義附加至自訂網域的個別路徑，以建立應用程式的唯一路徑。當您在 Web 瀏覽器中輸入此路徑時，網路資料流量就會遞送至 ALB。ALB 會查閱相關聯的服務，將網路資料流量傳送至服務，然後使用相同路徑傳送至執行該應用程式的 Pod。應用程式必須設定成接聽此路徑，以接收送入的網路資料流量。</br>
        許多應用程式不會接聽特定路徑，但卻使用根路徑及特定埠。在此情況下，請將根路徑定義為 <code>/</code>，並且不要為應用程式指定個別路徑。</br></br>
        範例：<ul><li>針對 <code>https://custom_domain/</code>，輸入 <code>/</code> 作為路徑。</li><li>針對 <code>https://custom_domain/service1_path</code>，輸入 <code>/service1_path</code> 作為路徑。</li></ul>
    <strong>提示：</strong>若要配置 Ingress 接聽與應用程式所接聽路徑不同的路徑，您可以使用[重寫註釋](cs_annotations.html#rewrite-path)來建立應用程式的適當遞送。</td>
    </tr>
    <tr>
    <td><code>serviceName</code></td>
    <td>將 <em>&lt;service1&gt;</em> 取代為您為應用程式建立 Kubernetes 服務時所使用的服務名稱。</td>
    </tr>
    <tr>
    <td><code>servicePort</code></td>
    <td>您的服務所接聽的埠。請使用您為應用程式建立 Kubernetes 服務時所定義的相同埠。</td>
    </tr>
    </tbody></table>

  3.  儲存變更。
  4.  建立叢集的 Ingress 資源。

      ```
        kubectl apply -f myingressresource.yaml
        ```
      {: pre}
9.   驗證已順利建立 Ingress 資源。

      ```
      kubectl describe ingress myingressresource
      ```
      {: pre}

      1. 如果事件中的訊息說明資源配置中的錯誤，請變更資源檔中的值，然後重新套用該資源的檔案。

10.   在 Web 瀏覽器中，輸入要存取的應用程式服務的 URL。

      ```
      https://<custom_domain>/<service1_path>
      ```
      {: codeblock}


<br />





## 選用的應用程式負載平衡器配置
{: #configure_alb}

您可以使用下列選項進一步配置應用程式負載平衡器。

-   [開啟 Ingress 應用程式負載平衡器中的埠](#opening_ingress_ports)
-   [配置 HTTP 層次的 SSL 通訊協定及 SSL 密碼](#ssl_protocols_ciphers)
-   [自訂 Ingress 日誌格式](#ingress_log_format)
-   [使用註釋自訂應用程式負載平衡器](cs_annotations.html)
{: #ingress_annotation}


### 開啟 Ingress 應用程式負載平衡器中的埠
{: #opening_ingress_ports}

依預設，Ingress ALB 中只會公開埠 80 及 443。若要公開其他埠，您可以編輯 `ibm-cloud-provider-ingress-cm` ConfigMap 資源。
{:shortdesc}

1. 建立並開啟 `ibm-cloud-provider-ingress-cm` configmap 資源的配置檔的本端版本。

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. 新增 <code>data</code> 區段，並指定公用埠 `80`、`443` 以及您要公開的任何其他埠，並以分號 (;) 區隔。

    **附註**：指定埠時，還必須包括 80 及 443，以讓那些埠保持開啟。任何未指定的埠都會關閉。

    ```
 apiVersion: v1
 data:
   public-ports: "80;443;<port3>"
 kind: ConfigMap
 metadata:
   name: ibm-cloud-provider-ingress-cm
   namespace: kube-system
 ```
    {: codeblock}

    範例：
    ```
 apiVersion: v1
 data:
   public-ports: "80;443;9443"
 kind: ConfigMap
 metadata:
   name: ibm-cloud-provider-ingress-cm
   namespace: kube-system
 ```
    {: screen}

3. 儲存配置檔。

4. 驗證已套用 configmap 變更。

 ```
 kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
 ```
 {: pre}

 輸出：
 ```
 Name:        ibm-cloud-provider-ingress-cm
 Namespace:    kube-system
 Labels:        <none>
 Annotations:    <none>

 Data
 ====

  public-ports: "80;443;9443"
 ```
 {: screen}

如需 ConfigMap 資源的相關資訊，請參閱 [Kubernetes 文件](https://kubernetes-v1-4.github.io/docs/user-guide/configmap/)。

### 配置 HTTP 層次的 SSL 通訊協定及 SSL 密碼
{: #ssl_protocols_ciphers}

透過編輯 `ibm-cloud-provider-ingress-cm` ConfigMap，在廣域 HTTP 層次啟用 SSL 通訊協定及密碼。
{:shortdesc}



**附註**：當您指定所有主機的已啟用通訊協定時，只有在使用 OpenSSL 1.0.1 或更新版本時，TLSv1.1 及 TLSv1.2 參數（1.1.13、1.0.12）才有作用。只有在使用以 TLSv1.3 支援所建置的 OpenSSL 1.1.1 時，TLSv1.3 參數 (1.13.0) 才有作用。

若要編輯 ConfigMap，以啟用 SSL 通訊協定及密碼，請執行下列動作：

1. 建立並開啟 `ibm-cloud-provider-ingress-cm` configmap 資源的配置檔的本端版本。

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. 新增 SSL 通訊協定及密碼。根據 [OpenSSL 程式庫密碼清單格式 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.openssl.org/docs/man1.0.2/apps/ciphers.html)，將密碼格式化。

   ```
 apiVersion: v1
 data:
   ssl-protocols: "TLSv1 TLSv1.1 TLSv1.2"
   ssl-ciphers: "HIGH:!aNULL:!MD5"
 kind: ConfigMap
 metadata:
   name: ibm-cloud-provider-ingress-cm
   namespace: kube-system
 ```
   {: codeblock}

3. 儲存配置檔。

4. 驗證已套用 configmap 變更。

   ```
   kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
   ```
   {: pre}

   輸出：
   ```
   Name:        ibm-cloud-provider-ingress-cm
   Namespace:   kube-system
   Labels:      <none>
   Annotations: <none>

   Data
   ====

    ssl-protocols: "TLSv1 TLSv1.1 TLSv1.2"
    ssl-ciphers: "HIGH:!aNULL:!MD5"
   ```
   {: screen}

### 自訂 Ingress 日誌內容及格式
{: #ingress_log_format}

您可以自訂針對 Ingress ALB 所收集日誌的內容及格式。
{:shortdesc}

依預設，Ingress 日誌會格式化為 JSON，並顯示一般的日誌欄位。不過，您也可以建立自訂日誌格式。若要選擇要轉遞的日誌元件及其在日誌輸出中的排列方式，請執行下列動作：

1. 建立並開啟 `ibm-cloud-provider-ingress-cm` configmap 資源的配置檔的本端版本。

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. 新增 <code>data</code> 區段。新增 `log-format` 欄位，並選擇性地新增 `log-format-escape-json` 欄位。

    ```
    apiVersion: v1
    data:
      log-format: '{<key1>: <log_variable1>, <key2>: <log_variable2>, <key3>: <log_variable3>}'
      log-format-escape-json: "true"
    kind: ConfigMap
    metadata:
      name: ibm-cloud-provider-ingress-cm
      namespace: kube-system
    ```
    {: pre}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 log-format 配置</th>
    </thead>
    <tbody>
    <tr>
    <td><code>log-format</code></td>
    <td>將 <code>&lt;key&gt;</code> 取代為日誌元件的名稱，並將 <code>&lt;log_variable&gt;</code> 取代為您要在日誌項目中收集的日誌元件的變數。您可以包含想要日誌項目包含的文字和標點符號，例如括住字串值用的引號以及分隔日誌元件用的逗點。例如，將元件格式化為 <code>request: "$request",</code> 會在日誌項目中產生下列內容：<code>request: "GET / HTTP/1.1",</code>。如需您可以使用的所有變數清單，請參閱 <a href="http://nginx.org/en/docs/varindex.html">Nginx 變數索引</a>。<br><br>若要記載額外的標頭，例如 <em>x-custom-ID</em>，請將下列鍵值組新增至自訂日誌內容：<br><pre class="pre"><code>customID: $http_x_custom_id</code></pre> <br>請注意，連字號 (<code>-</code>) 會轉換為底線 (<code>_</code>) ，且必須將 <code>$http_</code> 附加到自訂標頭名稱前面。</td>
    </tr>
    <tr>
    <td><code>log-format-escape-json</code></td>
    <td>選用項目：依預設，會以文字格式產生日誌。如果要產生 JSON 格式的日誌，請新增 <code>log-format-escape-json</code> 欄位，並使用值 <code>true</code>。</td>
    </tr>
    </tbody></table>
    </dd>
    </dl>

    例如，您的日誌格式可能包含下列變數：
    ```
    apiVersion: v1
    data:
      log-format: '{remote_address: $remote_addr, remote_user: "$remote_user",
                    time_date: [$time_local], request: "$request",
                    status: $status, http_referer: "$http_referer",
                    http_user_agent: "$http_user_agent",
                    request_id: $request_id}'
    kind: ConfigMap
    metadata:
      name: ibm-cloud-provider-ingress-cm
      namespace: kube-system
    ```
    {: screen}

    根據此格式的日誌項目類似下列內容：
    ```
    remote_address: 127.0.0.1, remote_user: "dbmanager", time_date: [30/Mar/2018:18:52:17 +0000], request: "GET / HTTP/1.1", status: 401, http_referer: "-", http_user_agent: "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:47.0) Gecko/20100101 Firefox/47.0", request_id: a02b2dea9cf06344a25611c1d7ad72db
    ```
    {: screen}

    如果您要建立以 ALB 日誌預設格式為基礎的自訂日誌格式，可以將下列區段新增至 configmap，並視需要進行修改：
    ```
    apiVersion: v1
    data:
      log-format: '{"time_date": "$time_iso8601", "client": "$remote_addr",
                    "host": "$http_host", "scheme": "$scheme",
                    "request_method": "$request_method", "request_uri": "$uri",
                    "request_id": "$request_id", "status": $status,
                    "upstream_addr": "$upstream_addr", "upstream_status":
                    $upstream_status, "request_time": $request_time,
                    "upstream_response_time": $upstream_response_time,
                    "upstream_connect_time": $upstream_connect_time,
                    "upstream_header_time": $upstream_header_time}'
      log-format-escape-json: "true"
    kind: ConfigMap
    metadata:
      name: ibm-cloud-provider-ingress-cm
      namespace: kube-system
    ```
    {: codeblock}

4. 儲存配置檔。

5. 驗證已套用 configmap 變更。

 ```
 kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
 ```
 {: pre}

 輸出範例：
 ```
 Name:        ibm-cloud-provider-ingress-cm
 Namespace:   kube-system
 Labels:      <none>
 Annotations: <none>

 Data
 ====

  log-format: '{remote_address: $remote_addr, remote_user: "$remote_user", time_date: [$time_local], request: "$request", status: $status, http_referer: "$http_referer", http_user_agent: "$http_user_agent", request_id: $request_id}'
  log-format-escape-json: "true"
 ```
 {: screen}

4. 若要檢視 Ingress ALB 日誌，請在叢集中[建立 Ingress 服務的記載配置](cs_health.html#logging)。

<br />




