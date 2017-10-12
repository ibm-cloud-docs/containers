---

copyright:
  years: 2014, 2017
lastupdated: "2017-08-13"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# 在叢集中部署應用程式
{: #cs_apps}

您隨時可以使用 Kubernetes 技術部署應用程式，以及確保您的應用程式已啟動並在執行中。例如，您可以執行漸進式更新及回復，而不會對使用者造成任何關閉時間。
{:shortdesc}

部署應用程式一般會包括下列步驟。

1.  [安裝 CLI](cs_cli_install.html#cs_cli_install)。

2.  建立應用程式的配置 Script。[檢閱 Kubernetes 的最佳作法。 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/concepts/configuration/overview/)

3.  使用下列其中一種方法來執行配置 Script。
    -   [Kubernetes CLI](#cs_apps_cli)
    -   Kubernetes 儀表板
        1.  [啟動 Kubernetes 儀表板。](#cs_cli_dashboard)
        2.  [執行配置 Script。](#cs_apps_ui)


## 啟動 Kubernetes 儀表板
{: #cs_cli_dashboard}

在本端系統上開啟 Kubernetes 儀表板，以檢視叢集及其工作者節點的相關資訊。
{:shortdesc}

開始之前，請先將 [CLI 的目標](cs_cli_install.html#cs_cli_configure)設為您的叢集。此作業需要[管理者存取原則](cs_cluster.html#access_ov)。請驗證您的現行[存取原則](cs_cluster.html#view_access)。

您可以使用預設埠或設定自己的埠，來啟動叢集的 Kubernetes 儀表板。
-   使用預設埠 8001 來啟動 Kubernetes 儀表板。
    1.  使用預設埠號來設定 Proxy。

        ```
        kubectl proxy
        ```
        {: pre}

        您的 CLI 輸出看起來如下：

        ```
        Starting to serve on 127.0.0.1:8001
        ```
        {: screen}

    2.  在 Web 瀏覽器中開啟下列 URL，以查看 Kubernetes 儀表板。

        ```
        http://localhost:8001/ui
        ```
        {: codeblock}

-   使用您自己的埠來啟動 Kubernetes 儀表板。
    1.  使用您自己的埠號來設定 Proxy。

        ```
        kubectl proxy -p <port>
        ```
        {: pre}

    2.  在瀏覽器開啟下列 URL。

        ```
        http://localhost:<port>/ui
        ```
        {: codeblock}


完成 Kubernetes 儀表板之後，使用 `CTRL+C` 來結束 `proxy` 指令。

## 容許對應用程式的公用存取
{: #cs_apps_public}

若要將應用程式設為可公開使用，您必須先更新配置 Script，再將應用程式部署至叢集。
{:shortdesc}

視您所建立的是精簡還是標準叢集而定，會有不同的方式可從網際網路存取您的應用程式。

<dl>
<dt><a href="#cs_apps_public_nodeport" target="_blank">NodePort 類型服務</a>（精簡及標準叢集）</dt>
<dd>公開每個工作者節點上的公用埠，並使用任何工作者節點的公用 IP 位址來公開存取您在叢集中的服務。工作者節點的公用 IP 位址不是永久性的。移除或重建工作者節點時，會將新的公用 IP 位址指派給工作者節點。NodePort 類型服務可以用於測試應用程式的公用存取，也可以用於僅短時間需要公用存取時。當您需要服務端點的穩定公用 IP 位址及更高可用性時，請使用 LoadBalancer 類型服務或 Ingress 來公開應用程式。</dd>
<dt><a href="#cs_apps_public_load_balancer" target="_blank">LoadBalancer 類型服務</a>（僅限標準叢集）</dt>
<dd>每個標準叢集都會佈建 4 個可攜式公用 IP 位址，可用來建立應用程式的外部 TCP/ UDP 負載平衡器。您可以公開應用程式所需的任何埠來自訂負載平衡器。指派給負載平衡器的可攜式公用 IP 位址是永久性的，因此在叢集中重建工作者節點時並不會變更。</br>
如果您的應用程式需要 HTTP 或 HTTPS 負載平衡，而且要使用一個公用路徑將您叢集中的多個應用程式公開為服務，請使用
{{site.data.keyword.containershort_notm}} 的內建 Ingress 支援。</dd>
<dt><a href="#cs_apps_public_ingress" target="_blank">Ingress</a>（僅限標準叢集）</dt>
<dd>公開您叢集中的多個應用程式，方法是建立一個外部 HTTP 或 HTTPS 負載平衡器，以使用安全且唯一的公用進入點，將送入要求遞送給應用程式。Ingress 包含兩個主要元件：Ingress 資源及 Ingress 控制器。Ingress 資源會定義如何遞送及負載平衡應用程式送入要求的規則。所有 Ingress 資源都必須向 Ingress 控制器登錄，而 Ingress 控制器會接聽送入 HTTP 或 HTTPS 服務要求，並根據針對每一個 Ingress 資源所定義的規則來轉遞要求。如果您要使用自訂遞送規則來實作自己的負載平衡器，以及需要應用程式的 SSL 終止，請使用 Ingress。</dd></dl>

### 使用 NodePort 服務類型來配置應用程式的公用存取
{: #cs_apps_public_nodeport}

使用叢集中任何工作者節點的公用 IP 位址，並公開節點埠，以將應用程式設為可公開使用。請使用此選項來進行測試及短期公用存取。
{:shortdesc}

對於精簡或標準叢集，您可以將應用程式公開為 NodePort 類型的 Kubernetes 服務。

對於「{{site.data.keyword.Bluemix_notm}} 專用」環境，防火牆會封鎖公用 IP 位址。若要讓應用程式可公開使用，請改用 [LoadBalancer 類型服務](#cs_apps_public_load_balancer)或 [Ingress](#cs_apps_public_ingress)。

**附註：**工作者節點的公用 IP 位址不是永久性的。如果必須重建工作者節點，則會將新的公用 IP 位址指派給工作者節點。如果您需要服務的穩定公用 IP 位址及更高可用性，請使用 [LoadBalancer 類型服務](#cs_apps_public_load_balancer)或 [Ingress](#cs_apps_public_ingress) 來公開應用程式。




1.  在配置 Script 定義 [service ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/concepts/services-networking/service/) 區段。
2.  在服務的 `spec` 區段中，新增 NodePort 類型。

    ```
    spec:
      type: NodePort
    ```
    {: codeblock}

3.  選用項目：在 `ports` 區段中，新增在 30000 到 32767 範圍內的 NodePort。請不要指定另一個服務已在使用中的 NodePort。如果您不確定哪些 NodePort 已在使用中，請勿進行指派。如果未指派 NodePort，則會自動指派一個隨機 NodePort。

    ```
    ports:
      - port: 80
        nodePort: 31514
    ```
    {: codeblock}

    如果您要指定 NodePort，並且要查看哪些 NodePort 已在使用中，則可以執行下列指令。

    ```
    kubectl get svc
    ```
    {: pre}

    輸出：

    ```
    NAME           CLUSTER-IP     EXTERNAL-IP   PORTS          AGE
    myapp          10.10.10.83    <nodes>       80:31513/TCP   28s
    redis-master   10.10.10.160   <none>        6379/TCP       28s
    redis-slave    10.10.10.194   <none>        6379/TCP       28s
    ```
    {: screen}

4.  儲存變更。
5.  重複以建立每個應用程式的服務。

    範例：

    ```
    apiVersion: v1
    kind: Service
    metadata:
      name: my-nodeport-service
      labels:
        run: my-demo
    spec:
      selector:
        run: my-demo
      type: NodePort
      ports:
       - protocol: TCP
         port: 8081
         # nodePort: 31514

    ```
    {: codeblock}

**下一步為何：**

部署應用程式時，您可以使用任何工作者節點的公用 IP 位址以及 NodePort 來形成可在瀏覽器中存取應用程式的公用 URL。

1.  取得叢集中工作者節點的公用 IP 位址。

    ```
    bx cs workers <cluster_name>
    ```
    {: pre}

    輸出：

    ```
    ID                                                Public IP   Private IP    Size     State    Status
    prod-dal10-pa215dcf5bbc0844a990fa6b0fcdbff286-w1  192.0.2.23  10.100.10.10  u1c.2x4  normal   Ready
    prod-dal10-pa215dcf5bbc0844a990fa6b0fcdbff286-w2  192.0.2.27  10.100.10.15  u1c.2x4  normal   Ready
    ```
    {: screen}

2.  如果已指派隨機 NodePort，請找出已指派的 NodePort。

    ```
    kubectl describe service <service_name>
    ```
    {: pre}

    輸出：

    ```
    Name:                   <service_name>
    Namespace:              default
    Labels:                 run=<deployment_name>
    Selector:               run=<deployment_name>
    Type:                   NodePort
    IP:                     10.10.10.8
    Port:                   <unset> 8080/TCP
    NodePort:               <unset> 30872/TCP
    Endpoints:              172.30.171.87:8080
    Session Affinity:       None
    No events.
    ```
    {: screen}

    在此範例中，NodePort 是 `30872`。

3.  形成具有其中一個工作者節點公用 IP 位址及 NodePort 的 URL。範例：`http://192.0.2.23:30872`

### 使用負載平衡器服務類型來配置應用程式的公用存取
{: #cs_apps_public_load_balancer}

公開埠並使用可攜式公用 IP 位址，讓負載平衡器可以存取應用程式。與 NodePort 服務不同，負載平衡器服務的可攜式公用 IP 位址不是取決於在其上已部署應用程式的工作者節點。負載平衡器的可攜式公用 IP 位址會自動進行指派，而且不會在您新增或移除工作者節點時變更，這表示負載平衡器服務的可用性比 NodePort 服務的可用性更高。使用者可以選取負載平衡器的任何埠，而不只限於 NodePort 埠範圍。您可以針對 TCP 及 UDP 通訊協定使用負載平衡器服務。

當「{{site.data.keyword.Bluemix_notm}} 專用」帳戶[啟用叢集功能](cs_ov.html#setup_dedicated)時，您可以要求將公用子網路用於負載平衡器 IP 位址。[開立支援問題單](/docs/support/index.html#contacting-support)建立子網路，然後使用 [`bx cs cluster-subnet-add`](cs_cli_reference.html#cs_cluster_subnet_add) 指令將子網路新增至叢集。

**附註：**負載平衡器服務不支援 TLS 終止。如果您的應用程式需要 TLS 終止，您可以透過 [Ingress](#cs_apps_public_ingress) 來公開應用程式，或配置應用程式來管理 TLS 終止。

開始之前：

-   只有標準叢集才能使用此特性。
-   您必須要有可指派給負載平衡器服務的可攜式公用 IP 位址。

若要建立負載平衡器服務，請執行下列動作：

1.  [將應用程式部署至叢集](#cs_apps_cli)。將應用程式部署至叢集時，會自動建立一個以上的 Pod，以在容器中執行您的應用程式。請確定您已將標籤新增至您部署中配置 Script 的 meta 資料區段。此標籤是識別您應用程式執行所在之所有 Pod 的必要項目，如此才能將 Pod 包含在負載平衡中。
2.  為您要公開的應用程式建立負載平衡器服務。若要讓您的應用程式可在公用網際網路上使用，您必須建立應用程式的 Kubernetes 服務，並配置服務，以將所有構成應用程式的 Pod 包含在負載平衡中。
    1.  例如，開啟偏好的編輯器，然後建立名為 `myloadbalancer.yaml` 的服務配置 Script。
    2.  為您要公開給大眾使用的應用程式定義負載平衡器服務。

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <myservice>
        spec:
          type: LoadBalancer
          selector:
            <selectorkey>:<selectorvalue>
          ports:
           - protocol: TCP
             port: 8080
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> 瞭解 YAML 檔案元件</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>將 <em>&lt;myservice&gt;</em> 取代為負載平衡器服務的名稱。</td>
        </tr>
        <tr>
        <td><code>selector</code></td>
        <td>輸入標籤索引鍵 (<em>&lt;selectorkey&gt;</em>) 及值 (<em>&lt;selectorvalue&gt;</em>) 配對，以用來將應用程式執行所在的 Pod 設為目標。例如，如果您使用下列選取器 <code>app: code</code>，會將所有其 meta 資料中具有此標籤的 Pod 都包含在負載平衡中。當您將應用程式部署至叢集時，請輸入所使用的相同標籤。</td>
         </tr>
         <td><code>port</code></td>
         <td>服務所接聽的埠。</td>
         </tbody></table>
    3.  選用項目：如果您的叢集可用的特定負載平衡器，要使用特定的可攜式公用 IP 位址，可以將 `loadBalancerIP` 包含在 spec 區段，以指定該 IP 位址。如需相關資訊，請參閱 [Kubernetes 文件 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/concepts/services-networking/service/)。
    4.  選用項目：您可以選擇在 spec 區段中指定 `loadBalancerSourceRanges`，以配置防火牆。如需相關資訊，請參閱 [Kubernetes 文件 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/)。
    5.  儲存變更。
    6.  在叢集中建立服務。

        ```
        kubectl apply -f myloadbalancer.yaml
        ```
        {: pre}

        若已建立負載平衡器服務，可攜式公用 IP 位址即會自動指派給負載平衡器。如果沒有可用的可攜式公用 IP 位址，則建立負載平衡器服務會失敗。
3.  驗證已順利建立負載平衡器服務。將 _&lt;myservice&gt;_ 取代為您在前一個步驟中建立之負載平衡器服務的名稱。

    ```
    kubectl describe service <myservice>
    ```
    {: pre}

    **附註：**這可能需要幾分鐘的時間，才能適當地建立負載平衡器服務，以及在公用網際網路上使用應用程式。

    CLI 輸出會與下列內容類似：

    ```
    Name:                   <myservice>
    Namespace:              default
    Labels:                 <none>
    Selector:               <selectorkey>=<selectorvalue>
    Type:                   LoadBalancer
    IP:                     10.10.10.90
    LoadBalancer Ingress:   192.168.10.38
    Port:                   <unset> 8080/TCP
    NodePort:               <unset> 32040/TCP
    Endpoints:              172.30.171.87:8080
    Session Affinity:       None
    Events:
    FirstSeen LastSeen Count From   SubObjectPath Type  Reason   Message
      --------- -------- ----- ----   ------------- -------- ------   -------
      10s  10s  1 {service-controller }   Normal  CreatingLoadBalancer Creating load balancer
      10s  10s  1 {service-controller }   Normal  CreatedLoadBalancer Created load balancer
    ```
    {: screen}

    **LoadBalancer Ingress** IP 位址是已指派給負載平衡器服務的可攜式公用 IP 位址。
4.  從網際網路存取您的應用程式。
    1.  開啟偏好的 Web 瀏覽器。
    2.  輸入負載平衡器的可攜式公用 IP 位址及埠。在上述範例中，`192.168.10.38` 可攜式公用 IP 位址已指派給負載平衡器服務。

        ```
        http://192.168.10.38:8080
        ```
        {: codeblock}


### 使用 Ingress 控制器來配置應用程式的公用存取
{: #cs_apps_public_ingress}

建立 IBM 提供的 Ingress 控制器所管理的 Ingress 資源，以公開叢集中的多個應用程式。Ingress 控制器是一個外部 HTTP 或 HTTPS 負載平衡器，使用安全且唯一的公用進入點，將送入要求遞送給叢集內外部的應用程式。

**附註：**Ingress 僅適用於標準叢集，而且叢集中需要至少兩個工作者節點才能確保高可用性。

當您建立標準叢集時，會自動建立 Ingress 控制器，並獲指派一個可攜式公用 IP 位址及一個公用路徑。您可以配置 Ingress 控制器，以及為每個公開給大眾使用的應用程式定義個別遞送規則。每個透過 Ingress 公開的應用程式，都會獲指派一個附加至公用路徑的唯一路徑，以便您可以使用唯一 URL 來公開存取叢集中的應用程式。

當「{{site.data.keyword.Bluemix_notm}} 專用」帳戶[啟用叢集功能](cs_ov.html#setup_dedicated)時，您可以要求將公用子網路用於 Ingress 控制器 IP 位址。然後，會建立 Ingress 控制器，並指派公用路徑。[開立支援問題單](/docs/support/index.html#contacting-support)建立子網路，然後使用 [`bx cs cluster-subnet-add`](cs_cli_reference.html#cs_cluster_subnet_add) 指令將子網路新增至叢集。

您可以針對下列情境配置 Ingress 控制器。

-   [使用沒有 TLS 終止的 IBM 提供的網域](#ibm_domain)
-   [使用具有 TLS 終止的 IBM 提供的網域](#ibm_domain_cert)
-   [使用自訂網域及 TLS 憑證來執行 TLS 終止](#custom_domain_cert)
-   [使用具有 TLS 終止的 IBM 提供的網域或自訂網域，來存取叢集外部的應用程式](#external_endpoint)
-   [使用註釋自訂 Ingress 控制器](#ingress_annotation)

#### 使用沒有 TLS 終止的 IBM 提供的網域
{: #ibm_domain}

您可以將 Ingress 控制器配置為叢集中應用程式的 HTTP 負載平衡器，以及使用 IBM 提供的網域從網際網路存取應用程式。

開始之前：

-   如果您還沒有叢集，請[建立標準叢集](cs_cluster.html#cs_cluster_ui)。
-   [將 CLI 的目標設為](cs_cli_install.html#cs_cli_configure)叢集，才能執行 `kubectl` 指令。

若要配置 Ingress 控制器，請執行下列動作：

1.  [將應用程式部署至叢集](#cs_apps_cli)。將應用程式部署至叢集時，會自動建立一個以上的 Pod，以在容器中執行您的應用程式。請確定您已將標籤新增至您部署中配置 Script 的 meta 資料區段。此標籤是識別您應用程式執行所在之所有 Pod 的必要項目，如此才能將 Pod 包含在 Ingress 負載平衡中。
2.  為要公開的應用程式，建立 Kubernetes 服務。只有在您的應用程式是透過叢集內的 Kubernetes 服務公開時，Ingress 控制器才能將應用程式包含在 Ingress 負載平衡中。
    1.  例如，開啟偏好的編輯器，然後建立名為 `myservice.yaml` 的服務配置 Script。
    2.  為您要公開給大眾使用的應用程式定義服務。

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <myservice>
        spec:
          selector:
            <selectorkey>: <selectorvalue>
          ports:
           - protocol: TCP
             port: 8080
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> 瞭解 YAML 檔案元件</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>將 <em>&lt;myservice&gt;</em> 取代為負載平衡器服務的名稱。</td>
        </tr>
        <tr>
        <td><code>selector</code></td>
        <td>輸入標籤索引鍵 (<em>&lt;selectorkey&gt;</em>) 及值 (<em>&lt;selectorvalue&gt;</em>) 配對，以用來將應用程式執行所在的 Pod 設為目標。例如，如果您使用下列選取器 <code>app: code</code>，會將所有其 meta 資料中具有此標籤的 Pod 都包含在負載平衡中。當您將應用程式部署至叢集時，請輸入所使用的相同標籤。</td>
         </tr>
         <tr>
         <td><code>port</code></td>
         <td>服務所接聽的埠。</td>
         </tr>
         </tbody></table>
    3.  儲存變更。
    4.  在叢集中建立服務。

        ```
        kubectl apply -f myservice.yaml
        ```
        {: pre}
    5.  針對每個您要公開給大眾使用的應用程式，重複這些步驟。
3.  取得叢集的詳細資料，以檢視 IBM 提供的網域。將 _&lt;mycluster&gt;_ 取代為要公開給大眾使用的應用程式部署到其中的叢集名稱。

    ```
    bx cs cluster-get <mycluster>
    ```
    {: pre}

    CLI 輸出會與下列內容類似。

    ```
    Retrieving cluster <mycluster>...
    OK
    Name:    <mycluster>
    ID:    b9c6b00dc0aa487f97123440b4895f2d
    Created:  2017-04-26T19:47:08+0000
    State:    normal
    Master URL:  https://169.57.40.165:1931
    Ingress subdomain:  <ibmdomain>
    Ingress secret:  <ibmtlssecret>
    Workers:  3
    ```
    {: screen}

    您可以在 **Ingress subdomain** 欄位中看到 IBM 提供的網域。
4.  建立 Ingress 資源。Ingress 資源定義您為應用程式所建立之 Kubernetes 服務的遞送規則，並且供 Ingress 控制器用來將送入網路資料流量遞送給服務。只要每個應用程式都是透過叢集內的 Kubernetes 服務公開時，您就可以使用一個 Ingress 資源來為多個應用程式定義遞送規則。
    1.  例如，開啟偏好的編輯器，然後建立名為 `myingress.yaml` 的 Ingress 配置 Script。
    2.  在配置 Script 中定義 Ingress 資源，以使用 IBM 提供的網域將送入的網路資料流量遞送至您先前建立的服務。

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: <myingressname>
        spec:
          rules:
          - host: <ibmdomain>
            http:
              paths:
              - path: /<myservicepath1>
                backend:
                  serviceName: <myservice1>
                  servicePort: 80
              - path: /<myservicepath2>
                backend:
                  serviceName: <myservice2>
                  servicePort: 80
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> 瞭解 YAML 檔案元件</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>將 <em>&lt;myingressname&gt;</em> 取代為 Ingress 資源的名稱。</td>
        </tr>
        <tr>
        <td><code>host</code></td>
        <td>將 <em>&lt;ibmdomain&gt;</em> 取代為前一個步驟中的 IBM 提供的 <strong>Ingress subdomain</strong> 名稱。

        </br></br>
        <strong>附註：</strong>請不要使用 * 作為您的主機，也不要讓主機內容保留為空白，以避免建立 Ingress 期間發生失敗。</td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>將 <em>&lt;myservicepath1&gt;</em> 取代為斜線或應用程式所接聽的唯一路徑，以將網路資料流量轉遞至應用程式。

        </br>
        針對每個 Kubernetes 服務，您可以定義附加至 IBM 所提供之網域的個別路徑，以建立應用程式的唯一路徑，例如 <code>ingress_domain/myservicepath1</code>。當您將此路徑輸入 Web 瀏覽器時，會將網路資料流量遞送至 Ingress 控制器。Ingress 控制器會查閱相關聯的服務，然後將網路資料流量傳送至服務，並使用相同路徑傳送至執行應用程式的 Pod。應用程式必須設定成接聽此路徑，以接收送入的網路資料流量。

        </br></br>
        許多應用程式不會接聽特定路徑，但卻使用根路徑及特定埠。在此情況下，請將根路徑定義為 <code>/</code>，並且不要為應用程式指定個別路徑。</br>
        範例：<ul><li>針對 <code>http://ingress_host_name/</code>，輸入 <code>/</code> 作為路徑。</li><li>針對 <code>http://ingress_host_name/myservicepath</code>，輸入 <code>/myservicepath</code> 作為路徑。</li></ul>
        </br>
        <strong>提示：</strong>如果您要配置與應用程式所接聽路徑不同的 Ingress 接聽路徑，則可以使用<a href="#rewrite" target="_blank">重新編寫註釋</a>來建立應用程式的正確遞送。</td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td>將 <em>&lt;myservice1&gt;</em> 取代為您為應用程式建立 Kubernetes 服務時所使用的服務名稱。</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>您的服務所接聽的埠。請使用您為應用程式建立 Kubernetes 服務時所定義的相同埠。</td>
        </tr>
        </tbody></table>

    3.  建立叢集的 Ingress 資源。

        ```
        kubectl apply -f myingress.yaml
        ```
        {: pre}

5.  驗證已順利建立 Ingress 資源。將 _&lt;myingressname&gt;_ 取代為您先前建立的 Ingress 資源的名稱。

    ```
    kubectl describe ingress <myingressname>
    ```
    {: pre}

  **附註：**這可能需要幾分鐘的時間，才能適當地建立 Ingress 資源，以及在公用網際網路上使用應用程式。
6.  在 Web 瀏覽器中，輸入要存取的應用程式服務的 URL。

    ```
    http://<ibmdomain>/<myservicepath1>
    ```
    {: codeblock}


#### 使用具有 TLS 終止的 IBM 提供的網域
{: #ibm_domain_cert}

您可以配置 Ingress 控制器來管理應用程式的送入 TLS 連線、使用 IBM 提供的 TLS 憑證來解密網路資料流量，以及將未加密的要求轉遞至叢集中公開的應用程式。

開始之前：

-   如果您還沒有叢集，請[建立標準叢集](cs_cluster.html#cs_cluster_ui)。
-   [將 CLI 的目標設為](cs_cli_install.html#cs_cli_configure)叢集，才能執行 `kubectl` 指令。

若要配置 Ingress 控制器，請執行下列動作：

1.  [將應用程式部署至叢集](#cs_apps_cli)。請確定您已將標籤新增至您部署中配置 Script 的 meta 資料區段。此標籤會識別您應用程式執行所在的所有 Pod，如此才能將 Pod 包含在 Ingress 負載平衡中。
2.  為要公開的應用程式，建立 Kubernetes 服務。只有在您的應用程式是透過叢集內的 Kubernetes 服務公開時，Ingress 控制器才能將應用程式包含在 Ingress 負載平衡中。
    1.  例如，開啟偏好的編輯器，然後建立名為 `myservice.yaml` 的服務配置 Script。
    2.  為您要公開給大眾使用的應用程式定義服務。

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <myservice>
        spec:
          selector:
            <selectorkey>: <selectorvalue>
          ports:
           - protocol: TCP
             port: 8080
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> 瞭解 YAML 檔案元件</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>將 <em>&lt;myservice&gt;</em> 取代為 Kubernetes 服務的名稱。</td>
        </tr>
        <tr>
        <td><code>selector</code></td>
        <td>輸入標籤索引鍵 (<em>&lt;selectorkey&gt;</em>) 及值 (<em>&lt;selectorvalue&gt;</em>) 配對，以用來將應用程式執行所在的 Pod 設為目標。例如，如果您使用下列選取器 <code>app: code</code>，會將所有其 meta 資料中具有此標籤的 Pod 都包含在負載平衡中。當您將應用程式部署至叢集時，請輸入所使用的相同標籤。</td>
         </tr>
         <tr>
         <td><code>port</code></td>
         <td>服務所接聽的埠。</td>
         </tr>
         </tbody></table>

    3.  儲存變更。
    4.  在叢集中建立服務。

        ```
        kubectl apply -f myservice.yaml
        ```
        {: pre}

    5.  針對每個您要公開給大眾使用的應用程式，重複這些步驟。

3.  檢視 IBM 提供的網域及 TLS 憑證。將 _&lt;mycluster&gt;_ 取代為應用程式部署到其中的叢集名稱。

    ```
    bx cs cluster-get <mycluster>
    ```
    {: pre}

    CLI 輸出會與下列內容類似。

    ```
    bx cs cluster-get <mycluster>
    Retrieving cluster <mycluster>...
    OK
    Name:    <mycluster>
    ID:    b9c6b00dc0aa487f97123440b4895f2d
    Created:  2017-04-26T19:47:08+0000
    State:    normal
    Master URL:  https://169.57.40.165:1931
    Ingress subdomain:  <ibmdomain>
    Ingress secret:  <ibmtlssecret>
    Workers:  3
    ```
    {: screen}

    您可以在 **Ingress subdomain** 中看到 IBM 提供的網域，並在 **Ingress secret** 欄位中看到 IBM 提供的憑證。

4.  建立 Ingress 資源。Ingress 資源定義您為應用程式所建立之 Kubernetes 服務的遞送規則，並且供 Ingress 控制器用來將送入網路資料流量遞送給服務。只要每個應用程式都是透過叢集內的 Kubernetes 服務公開時，您就可以使用一個 Ingress 資源來為多個應用程式定義遞送規則。
    1.  例如，開啟偏好的編輯器，然後建立名為 `myingress.yaml` 的 Ingress 配置 Script。
    2.  在配置 Script 中定義 Ingress 資源，以使用 IBM 提供的網域將送入的網路資料流量遞送至服務，以及使用 IBM 提供的憑證來管理 TLS 終止。針對每個服務，您可以定義附加至 IBM 提供網域的個別路徑，以建立應用程式的唯一路徑，例如 `https://ingress_domain/myapp`。當您將此路徑輸入 Web 瀏覽器時，會將網路資料流量遞送至 Ingress 控制器。Ingress 控制器會查閱關聯的服務，然後將網路資料流量傳送至服務，並進一步傳送至執行應用程式的 Pod。

        **附註：**應用程式必須接聽 Ingress 資源中所定義的路徑。否則，無法將網路資料流量轉遞至應用程式。大部分的應用程式不會接聽特定路徑，但使用根路徑及特定埠。在此情況下，請將根路徑定義為 `/`，並且不要為應用程式指定個別路徑。

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: <myingressname>
        spec:
          tls:
          - hosts:
            - <ibmdomain>
            secretName: <ibmtlssecret>
          rules:
          - host: <ibmdomain>
            http:
              paths:
              - path: /<myservicepath1>
                backend:
                  serviceName: <myservice1>
                  servicePort: 80
              - path: /<myservicepath2>
                backend:
                  serviceName: <myservice2>
                  servicePort: 80
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> 瞭解 YAML 檔案元件</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>將 <em>&lt;myingressname&gt;</em> 取代為 Ingress 資源的名稱。</td>
        </tr>
        <tr>
        <td><code>tls/hosts</code></td>
        <td>將 <em>&lt;ibmdomain&gt;</em> 取代為前一個步驟中的 IBM 提供的 <strong>Ingress subdomain</strong> 名稱。此網域已配置 TLS 終止。

        </br></br>
        <strong>附註：</strong>請不要使用 &ast; 作為您的主機，也不要讓主機內容保留為空白，以避免建立 Ingress 期間發生失敗。</td>
        </tr>
        <tr>
        <td><code>tls/secretName</code></td>
        <td>將 <em>&lt;ibmtlssecret&gt;</em> 取代為前一個步驟中的 IBM 提供的 <strong>Ingress secret</strong> 名稱。此憑證會管理 TLS 終止。
        </tr>
        <tr>
        <td><code>host</code></td>
        <td>將 <em>&lt;ibmdomain&gt;</em> 取代為前一個步驟中的 IBM 提供的 <strong>Ingress subdomain</strong> 名稱。此網域已配置 TLS 終止。

        </br></br>
        <strong>附註：</strong>請不要使用 &ast; 作為您的主機，也不要讓主機內容保留為空白，以避免建立 Ingress 期間發生失敗。</td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>將 <em>&lt;myservicepath1&gt;</em> 取代為斜線或應用程式所接聽的唯一路徑，以將網路資料流量轉遞至應用程式。

        </br>
        針對每個 Kubernetes 服務，您可以定義附加至 IBM 所提供之網域的個別路徑，以建立應用程式的唯一路徑，例如 <code>ingress_domain/myservicepath1</code>。當您將此路徑輸入 Web 瀏覽器時，會將網路資料流量遞送至 Ingress 控制器。Ingress 控制器會查閱相關聯的服務，然後將網路資料流量傳送至服務，並使用相同路徑傳送至執行應用程式的 Pod。應用程式必須設定成接聽此路徑，以接收送入的網路資料流量。

        </br>
        許多應用程式不會接聽特定路徑，但卻使用根路徑及特定埠。在此情況下，請將根路徑定義為 <code>/</code>，並且不要為應用程式指定個別路徑。

        </br>
        範例：<ul><li>針對 <code>http://ingress_host_name/</code>，輸入 <code>/</code> 作為路徑。</li><li>針對 <code>http://ingress_host_name/myservicepath</code>，輸入 <code>/myservicepath</code> 作為路徑。</li></ul>
        <strong>提示：</strong>如果您要配置與應用程式所接聽路徑不同的 Ingress 接聽路徑，則可以使用<a href="#rewrite" target="_blank">重新編寫註釋</a>來建立應用程式的正確遞送。</td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td>將 <em>&lt;myservice1&gt;</em> 取代為您為應用程式建立 Kubernetes 服務時所使用的服務名稱。</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>您的服務所接聽的埠。請使用您為應用程式建立 Kubernetes 服務時所定義的相同埠。</td>
        </tr>
        </tbody></table>

    3.  建立叢集的 Ingress 資源。

        ```
        kubectl apply -f myingress.yaml
        ```
        {: pre}

5.  驗證已順利建立 Ingress 資源。將 _&lt;myingressname&gt;_ 取代為您先前建立的 Ingress 資源的名稱。

    ```
    kubectl describe ingress <myingressname>
    ```
    {: pre}

    **附註：**這可能需要幾分鐘的時間，才能適當地建立 Ingress 資源，以及在公用網際網路上使用應用程式。
6.  在 Web 瀏覽器中，輸入要存取的應用程式服務的 URL。

    ```
    https://<ibmdomain>/<myservicepath1>
    ```
    {: codeblock}

#### 搭配使用 Ingress 控制器與自訂網域及 TLS 憑證
{: #custom_domain_cert}

您可以配置 Ingress 控制器，將送入網路資料流量遞送至叢集中的應用程式，以及使用您自己的 TLS 憑證來管理 TLS 終止，同時使用您的自訂網域而非 IBM 提供的網域。
{:shortdesc}

開始之前：

-   如果您還沒有叢集，請[建立標準叢集](cs_cluster.html#cs_cluster_ui)。
-   [將 CLI 的目標設為](cs_cli_install.html#cs_cli_configure)叢集，才能執行 `kubectl` 指令。

若要配置 Ingress 控制器，請執行下列動作：

1.  建立自訂網域。若要建立自訂網域，請與「網域名稱服務 (DNS)」提供者合作，登錄自訂網域。
2.  配置網域，以將送入的網路資料流量遞送至 IBM Ingress 控制器。可選擇的選項有：
    -   將 IBM 提供的網域指定為「標準名稱記錄 (CNAME)」，以定義自訂網域的別名。若要尋找 IBM 提供的 Ingress 網域，請執行 `bx cs cluster-get <mycluster>`，並尋找 **Ingress subdomain** 欄位。
    -   將自訂網域對映至 IBM 提供的 Ingress 控制器的可攜式公用 IP 位址，方法是將 IP 位址新增為「指標記錄 (PTR)」。若要尋找 Ingress 控制器的可攜式公用 IP 位址，請執行下列動作：
        1.  執行 `bx cs cluster-get <mycluster>` 並尋找 **Ingress subdomain** 欄位。
        2.  執行 `nslookup <Ingress subdomain>`。
3.  建立以 base64 格式編碼的網域的 TLS 憑證及金鑰。
4.  將 TLS 憑證及金鑰儲存至 Kubernetes Secret 中。
    1.  例如，開啟偏好的編輯器，然後建立名為 `mysecret.yaml` 的 Kubernetes Secret 配置 Script。
    2.  定義使用 TLS 憑證及金鑰的 Secret。

        ```
        apiVersion: v1
        kind: Secret
        metadata:
          name: <mytlssecret>
        type: Opaque
        data:
          tls.crt: <tlscert>
          tls.key: <tlskey>
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> 瞭解 YAML 檔案元件</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>將 <em>&lt;mytlssecret&gt;</em> 取代為 Kubernetes Secret 的名稱。</td>
        </tr>
        <tr>
        <td><code>tls.cert</code></td>
        <td>將 <em>&lt;tlscert&gt;</em> 取代為以 base64 格式編碼的自訂 TLS 憑證。</td>
         </tr>
         <td><code>tls.key</code></td>
         <td>將 <em>&lt;tlskey&gt;</em> 取代為以 base64 格式編碼的自訂 TLS 金鑰。</td>
         </tbody></table>

    3.  儲存配置 Script。
    4.  建立叢集的 TLS Secret。

        ```
        kubectl apply -f mysecret.yaml
        ```
        {: pre}

5.  [將應用程式部署至叢集](#cs_apps_cli)。將應用程式部署至叢集時，會自動建立一個以上的 Pod，以在容器中執行您的應用程式。請確定您已將標籤新增至您部署中配置 Script 的 meta 資料區段。此標籤是識別您應用程式執行所在之所有 Pod 的必要項目，如此才能將 Pod 包含在 Ingress 負載平衡中。

6.  為要公開的應用程式，建立 Kubernetes 服務。只有在您的應用程式是透過叢集內的 Kubernetes 服務公開時，Ingress 控制器才能將應用程式包含在 Ingress 負載平衡中。

    1.  例如，開啟偏好的編輯器，然後建立名為 `myservice.yaml` 的服務配置 Script。
    2.  為您要公開給大眾使用的應用程式定義服務。

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <myservice>
        spec:
          selector:
            <selectorkey>: <selectorvalue>
          ports:
           - protocol: TCP
             port: 8080
        ```
       {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> 瞭解 YAML 檔案元件</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>將 <em>&lt;myservice1&gt;</em> 取代為 Kubernetes 服務的名稱。</td>
        </tr>
        <tr>
        <td><code>selector</code></td>
        <td>輸入標籤索引鍵 (<em>&lt;selectorkey&gt;</em>) 及值 (<em>&lt;selectorvalue&gt;</em>) 配對，以用來將應用程式執行所在的 Pod 設為目標。例如，如果您使用下列選取器 <code>app: code</code>，會將所有其 meta 資料中具有此標籤的 Pod 都包含在負載平衡中。當您將應用程式部署至叢集時，請輸入所使用的相同標籤。</td>
         </tr>
         <td><code>port</code></td>
         <td>服務所接聽的埠。</td>
         </tbody></table>

    3.  儲存變更。
    4.  在叢集中建立服務。

        ```
        kubectl apply -f myservice.yaml
        ```
        {: pre}

    5.  針對每個您要公開給大眾使用的應用程式，重複這些步驟。
7.  建立 Ingress 資源。Ingress 資源定義您為應用程式所建立之 Kubernetes 服務的遞送規則，並且供 Ingress 控制器用來將送入網路資料流量遞送給服務。只要每個應用程式都是透過叢集內的 Kubernetes 服務公開時，您就可以使用一個 Ingress 資源來為多個應用程式定義遞送規則。
    1.  例如，開啟偏好的編輯器，然後建立名為 `myingress.yaml` 的 Ingress 配置 Script。
    2.  在配置 Script 中定義 Ingress 資源，以使用自訂網域將送入的網路資料流量遞送至服務，以及使用自訂憑證來管理 TLS 終止。針對每個服務，您可以定義附加至自訂網域的個別路徑，以建立應用程式的唯一路徑，例如 `https://mydomain/myapp`。當您將此路徑輸入 Web 瀏覽器時，會將網路資料流量遞送至 Ingress 控制器。Ingress 控制器會查閱關聯的服務，然後將網路資料流量傳送至服務，並進一步傳送至執行應用程式的 Pod。

        **附註：**應用程式必須接聽 Ingress 資源中所定義的路徑。否則，無法將網路資料流量轉遞至應用程式。大部分的應用程式不會接聽特定路徑，但使用根路徑及特定埠。在此情況下，請將根路徑定義為 `/`，並且不要為應用程式指定個別路徑。

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: <myingressname>
        spec:
          tls:
          - hosts:
            - <mycustomdomain>
            secretName: <mytlssecret>
          rules:
          - host: <mycustomdomain>
            http:
              paths:
              - path: /<myservicepath1>
                backend:
                  serviceName: <myservice1>
                  servicePort: 80
              - path: /<myservicepath2>
                backend:
                  serviceName: <myservice2>
                  servicePort: 80
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> 瞭解 YAML 檔案元件</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>將 <em>&lt;myingressname&gt;</em> 取代為 Ingress 資源的名稱。</td>
        </tr>
        <tr>
        <td><code>tls/hosts</code></td>
        <td>將 <em>&lt;mycustomdomain&gt;</em> 取代為您要配置 TLS 終止的自訂網域。

        </br></br>
        <strong>附註：</strong>請不要使用 &ast; 作為您的主機，也不要讓主機內容保留為空白，以避免建立 Ingress 期間發生失敗。</td>
        </tr>
        <tr>
        <td><code>tls/secretName</code></td>
        <td>將 <em>&lt;mytlssecret&gt;</em> 取代為您先前建立的 Secret 的名稱，而此 Secret 可保留自訂 TLS 憑證及金鑰來管理自訂網域的 TLS 終止。</tr>
        <tr>
        <td><code>host</code></td>
        <td>將 <em>&lt;mycustomdomain&gt;</em> 取代為您要配置 TLS 終止的自訂網域。

        </br></br>
        <strong>附註：</strong>請不要使用 &ast; 作為您的主機，也不要讓主機內容保留為空白，以避免建立 Ingress 期間發生失敗。</td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>將 <em>&lt;myservicepath1&gt;</em> 取代為斜線或應用程式所接聽的唯一路徑，以將網路資料流量轉遞至應用程式。

        </br>
        針對每個 Kubernetes 服務，您可以定義附加至 IBM 所提供之網域的個別路徑，以建立應用程式的唯一路徑，例如 <code>ingress_domain/myservicepath1</code>。當您將此路徑輸入 Web 瀏覽器時，會將網路資料流量遞送至 Ingress 控制器。Ingress 控制器會查閱相關聯的服務，然後將網路資料流量傳送至服務，並使用相同路徑傳送至執行應用程式的 Pod。應用程式必須設定成接聽此路徑，以接收送入的網路資料流量。

        </br>
        許多應用程式不會接聽特定路徑，但卻使用根路徑及特定埠。在此情況下，請將根路徑定義為 <code>/</code>，並且不要為應用程式指定個別路徑。

        </br></br>
        範例：<ul><li>針對 <code>https://mycustomdomain/</code>，輸入 <code>/</code> 作為路徑。</li><li>針對 <code>https://mycustomdomain/myservicepath</code>，輸入 <code>/myservicepath</code> 作為路徑。</li></ul>
        <strong>提示：</strong>如果您要配置與應用程式所接聽路徑不同的 Ingress 接聽路徑，則可以使用<a href="#rewrite" target="_blank">重新編寫註釋</a>來建立應用程式的正確遞送。</td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td>將 <em>&lt;myservice1&gt;</em> 取代為您為應用程式建立 Kubernetes 服務時所使用的服務名稱。</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>您的服務所接聽的埠。請使用您為應用程式建立 Kubernetes 服務時所定義的相同埠。</td>
        </tr>
        </tbody></table>

    3.  儲存變更。
    4.  建立叢集的 Ingress 資源。

        ```
        kubectl apply -f myingress.yaml
        ```
        {: pre}

8.  驗證已順利建立 Ingress 資源。將 _&lt;myingressname&gt;_ 取代為您先前建立的 Ingress 資源的名稱。

    ```
    kubectl describe ingress <myingressname>
    ```
    {: pre}

    **附註：**這可能需要幾分鐘的時間，才能適當地建立 Ingress 資源，以及在公用網際網路上使用應用程式。

9.  從網際網路存取您的應用程式。
    1.  開啟偏好的 Web 瀏覽器。
    2.  輸入要存取的應用程式服務的 URL。

        ```
        https://<mycustomdomain>/<myservicepath1>
        ```
        {: codeblock}


#### 配置 Ingress 控制器，以將網路資料流量遞送至叢集外部的應用程式
{: #external_endpoint}

您可以為要包含在叢集負載平衡中且位於叢集外的應用程式，配置 Ingress 控制器。IBM 提供的網域或自訂網域上的送入要求，會自動轉遞給外部應用程式。

開始之前：

-   如果您還沒有叢集，請[建立標準叢集](cs_cluster.html#cs_cluster_ui)。
-   [將 CLI 的目標設為](cs_cli_install.html#cs_cli_configure)叢集，才能執行 `kubectl` 指令。
-   確定您可以使用公用 IP 位址來存取您要包含在叢集負載平衡中的外部應用程式。

您可以配置 Ingress 控制器，以將 IBM 提供的網域上的送入網路資料流量遞送給叢集外部的應用程式。如果您要改用自訂網域及 TLS 憑證，請將 IBM 提供的網域及 TLS 憑證取代為[自訂網域及 TLS 憑證](#custom_domain_cert)。

1.  配置 Kubernetes 端點，以定義您要包含在叢集負載平衡中的應用程式的外部位置。
    1.  例如，開啟偏好的編輯器，然後建立名為 `myexternalendpoint.yaml` 的端點配置 Script。
    2.  定義外部端點。請包含您可用來存取外部應用程式的所有公用 IP 位址及埠。

        ```
        kind: Endpoints
        apiVersion: v1
        metadata:
          name: <myendpointname>
        subsets:
          - addresses:
              - ip: <externalIP1>
              - ip: <externalIP2>
            ports:
              - port: <externalport>
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> 瞭解 YAML 檔案元件</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>將 <em>&lt;myendpointname&gt;</em> 取代為 Kubernetes 端點的名稱。</td>
        </tr>
        <tr>
        <td><code>ip</code></td>
        <td>將 <em>&lt;externalIP&gt;</em> 取代為用來連接至外部應用程式的公用 IP 位址。</td>
         </tr>
         <td><code>port</code></td>
         <td>將 <em>&lt;externalport&gt;</em> 取代為外部應用程式所接聽的埠。</td>
         </tbody></table>

    3.  儲存變更。
    4.  建立叢集的 Kubernetes 端點。

        ```
        kubectl apply -f myexternalendpoint.yaml
        ```
        {: pre}

2.  建立叢集的 Kubernetes 服務，並且配置它以將送入的要求轉遞至您先前建立的外部端點。
    1.  例如，開啟偏好的編輯器，然後建立名為 `myexternalservice.yaml` 的服務配置 Script。
    2.  定義服務。

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <myexternalservice>
          labels:
              name: <myendpointname>
        spec:
          ports:
           - protocol: TCP
             port: 8080
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> 瞭解 YAML 檔案元件</th>
        </thead>
        <tbody>
        <tr>
        <td><code>metadata/name</code></td>
        <td>將 <em>&lt;myexternalservice&gt;</em> 取代為 Kubernetes 服務的名稱。</td>
        </tr>
        <tr>
        <td><code>labels/name</code></td>
        <td>將 <em>&lt;myendpointname&gt;</em> 取代為您先前建立的 Kubernetes 端點的名稱。</td>
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

3.  檢視 IBM 提供的網域及 TLS 憑證。將 _&lt;mycluster&gt;_ 取代為應用程式部署到其中的叢集名稱。

    ```
    bx cs cluster-get <mycluster>
    ```
    {: pre}

    CLI 輸出會與下列內容類似。

    ```
    Retrieving cluster <mycluster>...
    OK
    Name:    <mycluster>
    ID:    b9c6b00dc0aa487f97123440b4895f2d
    Created:  2017-04-26T19:47:08+0000
    State:    normal
    Master URL:  https://169.57.40.165:1931
    Ingress subdomain:  <ibmdomain>
    Ingress secret:  <ibmtlssecret>
    Workers:  3
    ```
    {: screen}

    您可以在 **Ingress subdomain** 中看到 IBM 提供的網域，並在 **Ingress secret** 欄位中看到 IBM 提供的憑證。

4.  建立 Ingress 資源。Ingress 資源定義您為應用程式所建立之 Kubernetes 服務的遞送規則，並且供 Ingress 控制器用來將送入網路資料流量遞送給服務。只要每個應用程式都是透過叢集內的 Kubernetes 服務使用其外部端點公開時，您就可以使用一個 Ingress 資源來為多個外部應用程式定義遞送規則。
    1.  例如，開啟偏好的編輯器，然後建立名為 `myexternalingress.yaml` 的 Ingress 配置 Script。
    2.  在配置 Script 中定義 Ingress 資源，以使用 IBM 提供的網域及 TLS 憑證將送入的網路資料流量遞送至外部應用程式，方法是使用您先前定義的外部端點。針對每個服務，您可以定義附加至 IBM 提供網域或自訂網域的個別路徑，以建立應用程式的唯一路徑，例如 `https://ingress_domain/myapp`。當您將此路徑輸入 Web 瀏覽器時，會將網路資料流量遞送至 Ingress 控制器。Ingress 控制器會查閱關聯的服務，然後將網路資料流量傳送至服務，並進一步傳送至外部應用程式。

        **附註：**應用程式必須接聽 Ingress 資源中所定義的路徑。否則，無法將網路資料流量轉遞至應用程式。大部分的應用程式不會接聽特定路徑，但使用根路徑及特定埠。在此情況下，請將根路徑定義為 /，並且不要為應用程式指定個別路徑。

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: <myingressname>
        spec:
          tls:
          - hosts:
            - <ibmdomain>
            secretName: <ibmtlssecret>
          rules:
          - host: <ibmdomain>
            http:
              paths:
              - path: /<myexternalservicepath1>
                backend:
                  serviceName: <myservice1>
                  servicePort: 80
              - path: /<myexternalservicepath2>
                backend:
                  serviceName: <myexternalservice2>
                  servicePort: 80
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png"/> 瞭解 YAML 檔案元件</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>將 <em>&lt;myingressname&gt;</em> 取代為 Ingress 資源的名稱。</td>
        </tr>
        <tr>
        <td><code>tls/hosts</code></td>
        <td>將 <em>&lt;ibmdomain&gt;</em> 取代為前一個步驟中的 IBM 提供的 <strong>Ingress subdomain</strong> 名稱。此網域已配置 TLS 終止。

        </br></br>
        <strong>附註：</strong>請不要使用 &ast; 作為您的主機，也不要讓主機內容保留為空白，以避免建立 Ingress 期間發生失敗。</td>
        </tr>
        <tr>
        <td><code>tls/secretName</code></td>
        <td>將 <em>&lt;ibmtlssecret&gt;</em> 取代為前一個步驟中的 IBM 提供的 <strong>Ingress secret</strong>。此憑證會管理 TLS 終止。
        </td>
        </tr>
        <tr>
        <td><code>rules/host</code></td>
        <td>將 <em>&lt;ibmdomain&gt;</em> 取代為前一個步驟中的 IBM 提供的 <strong>Ingress subdomain</strong> 名稱。此網域已配置 TLS 終止。

        </br></br>
        <strong>附註：</strong>請不要使用 &ast; 作為您的主機，也不要讓主機內容保留為空白，以避免建立 Ingress 期間發生失敗。</td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>將 <em>&lt;myexternalservicepath&gt;</em> 取代為斜線或外部應用程式所接聽的唯一路徑，以將網路資料流量轉遞至應用程式。

        </br>
        針對每個 Kubernetes 服務，您可以定義附加至自訂網域的個別路徑，以建立應用程式的唯一路徑，例如 <code>https://ibmdomain/myservicepath1</code>。當您將此路徑輸入 Web 瀏覽器時，會將網路資料流量遞送至 Ingress 控制器。Ingress 控制器會查閱相關聯的服務，然後使用相同路徑將網路資料流量傳送至外部應用程式。應用程式必須設定成接聽此路徑，以接收送入的網路資料流量。

        </br></br>
        許多應用程式不會接聽特定路徑，但卻使用根路徑及特定埠。在此情況下，請將根路徑定義為 <code>/</code>，並且不要為應用程式指定個別路徑。

        </br></br>
        <strong>提示：</strong>如果您要配置與應用程式所接聽路徑不同的 Ingress 接聽路徑，則可以使用<a href="#rewrite" target="_blank">重新編寫註釋</a>來建立應用程式的正確遞送。</td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td>將 <em>&lt;myexternalservice&gt;</em> 取代為您為外部應用程式建立 Kubernetes 服務時所使用的服務名稱。</td>
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

5.  驗證已順利建立 Ingress 資源。將 _&lt;myingressname&gt;_ 取代為您先前建立的 Ingress 資源的名稱。

    ```
    kubectl describe ingress <myingressname>
    ```
    {: pre}

    **附註：**這可能需要幾分鐘的時間，才能適當地建立 Ingress 資源，以及在公用網際網路上使用應用程式。

6.  存取外部應用程式。
    1.  開啟偏好的 Web 瀏覽器。
    2.  輸入用來存取外部應用程式的 URL。

        ```
        https://<ibmdomain>/<myexternalservicepath>
        ```
        {: codeblock}


#### 支援的 Ingress 註釋
{: #ingress_annotation}

您可以指定 Ingress 資源的 meta 資料，以將功能新增至 Ingress 控制器。
{: shortdesc}

|支援的註釋|說明|
|--------------------|-----------|
|[重新編寫](#rewrite)|將送入的網路資料流量遞送至後端應用程式接聽的不同路徑。|
|[Cookie 的階段作業親緣性](#sticky_cookie)|使用 Sticky Cookie 一律將送入的網路資料流量遞送至相同的上游伺服器。|
|[額外的用戶端要求或回應標頭](#add_header)|新增額外的標頭資訊至用戶端要求，然後才將要求轉遞至後端應用程式，或新增至用戶端回應，然後才將回應傳送至用戶端。|
|[移除用戶端回應標頭](#remove_response_headers)|從用戶端回應移除標頭資訊，然後才將回應轉遞至用戶端。|
|[HTTP 重新導向至 HTTPS](#redirect_http_to_https)|將您網域上不安全的 HTTP 要求重新導向 HTTPS。|
|[用戶端回應資料緩衝](#response_buffer)|將回應傳送至用戶端時，停用 Ingress 控制器上的用戶端回應緩衝。|
|[自訂連接逾時和讀取逾時](#timeout)|調整 Ingress 控制器等待以連接及讀取後端應用程式的時間，在此時間之後，後端應用程式將被視為無法使用。|
|[自訂用戶端要求內文大小上限](#client_max_body_size)|調整允許傳送至 Ingress 控制器的用戶端要求內文大小。|

##### **使用重新編寫，將送入的網路資料流量遞送至不同路徑**
{: #rewrite}

使用重新編寫註釋，可以將 Ingress 控制器網域路徑上的送入網路資料流量遞送至與後端應用程式所接聽的不同路徑。
{:shortdesc}

<dl>
<dt>說明</dt>
<dd>Ingress 控制器網域會將 <code>mykubecluster.us-south.containers.mybluemix.net/beans</code> 上的送入網路資料流量遞送至您的應用程式。您的應用程式會接聽 <code>/coffee</code>，而非 <code>/beans</code>。若要將送入的網路資料流量轉遞至您的應用程式，請將重新編寫註釋新增至 Ingress 資源配置檔，如此，<code>/beans</code> 上的送入網路資料流量就會使用 <code>/coffee</code> 路徑轉遞至您的應用程式。包含多個服務時，只使用分號 (;) 來區隔它們。</dd>
<dt>Ingress 資源範例 YAML</dt>
<dd>
<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/rewrite-path: "serviceName=&lt;service_name1&gt; rewrite=&lt;rewrite_path1&gt;;serviceName=&lt;service_name2&gt; rewrite=&lt;rewrite_path2&gt;"
spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /&lt;domain_path1&gt;
        backend:
          serviceName: &lt;service_name1&gt;
          servicePort: &lt;service_port1&gt;
      - path: /&lt;domain_path2&gt;
        backend:
          serviceName: &lt;service_name2&gt;
          servicePort: &lt;service_port2&gt;</code></pre>

<table>
<thead>
<th colspan=2><img src="images/idea.png"/> 瞭解 YAML 檔案元件</th>
</thead>
<tbody>
<tr>
<td><code>annotations</code></td>
<td>將 <em>&lt;service_name&gt;</em> 取代為您為應用程式所建立之 Kubernetes 服務的名稱，並將 <em>&lt;rewrite-path&gt;</em> 取代為您的應用程式所接聽的路徑。Ingress 控制器網域上的送入網路資料流量即會使用此路徑轉遞至 Kubernetes 服務。大部分的應用程式不會接聽特定路徑，但使用根路徑及特定埠。在此情況下，將 <code>/</code> 定義為您應用程式的 <em>&lt;rewrite-path&gt;</em>。</td>
</tr>
<tr>
<td><code>path</code></td>
<td>將 <em>&lt;domain_path&gt;</em> 取代為您要附加至 Ingress 控制器網域的路徑。這個路徑上的送入網路資料流量即會轉遞至您在註釋中所定義的重新編寫路徑。在上述範例中，請將網域路徑設定為 <code>/beans</code>，以將此路徑包含在 Ingress 控制器的負載平衡中。</td>
</tr>
<tr>
<td><code>serviceName</code></td>
<td>將 <em>&lt;service_name&gt;</em> 取代為您為應用程式所建立之 Kubernetes 服務的名稱。您在這裡使用的服務名稱，必須與在註釋中定義的名稱相同。</td>
</tr>
<tr>
<td><code>servicePort</code></td>
<td>將 <em>&lt;service_port&gt;</em> 取代為服務所接聽的埠。</td>
</tr></tbody></table>

</dd></dl>


##### **使用 Sticky Cookie 一律將送入的網路資料流量遞送至相同的上游伺服器**
{: #sticky_cookie}

使用 Sticky Cookie 註釋，可以為 Ingress 控制器新增階段作業親緣性。
{:shortdesc}

<dl>
<dt>說明</dt>
<dd>您的應用程式設定可能需要您部署多個上游伺服器，它們會處理送入的用戶端要求並且確保高可用性。當用戶端連接至後端應用程式時，在階段作業持續時間，或是在完成作業所需的時間內，由相同的上游伺服器服務某一用戶端可能很有用。您可以配置 Ingress 控制器，一律將送入的網路資料流量遞送至相同的上游伺服器，以確保階段作業親緣性。

</br>
連接至您的後端應用程式的每個用戶端，會由 Ingress 控制器指派給其中一個可用的上游伺服器。Ingress 控制器會建立階段作業 Cookie，它儲存在用戶端應用程式，用戶端應用程式則包含在 Ingress 控制器與用戶端之間每個要求的標頭資訊中。Cookie 中的資訊確保所有要求在整個階段作業中，都由相同的上游伺服器處理。

</br></br>
當您包含多個服務時，請使用分號 (;) 來區隔它們。</dd>
<dt>Ingress 資源範例 YAML</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/sticky-cookie-services: "serviceName=&lt;service_name1&gt; name=&lt;cookie_name1&gt; expires=&lt;expiration_time1&gt; path=&lt;cookie_path1&gt; hash=&lt;hash_algorithm1&gt;;serviceName=&lt;service_name2&gt; name=&lt;cookie_name2&gt; expires=&lt;expiration_time2&gt; path=&lt;cookie_path2&gt; hash=&lt;hash_algorithm2&gt;"
spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: &lt;service_name1&gt;
          servicePort: 8080
      - path: /myapp
        backend:
          serviceName: &lt;service_name2&gt;
          servicePort: 80</code></pre>

  <table>
  <caption>表 12. 瞭解 YAML 檔案元件</caption>
  <thead>
  <th colspan=2><img src="images/idea.png"/> 瞭解 YAML 檔案元件</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>請取代下列值：<ul><li><code><em>&lt;service_name&gt;</em></code>：您為應用程式所建立之 Kubernetes 服務的名稱。</li><li><code><em>&lt;cookie_name&gt;</em></code>：選擇在階段作業期間建立的 Sticky Cookie。</li><li><code><em>&lt;expiration_time&gt;</em></code>：Sticky Cookie 到期之前的時間量，以秒、分鐘或小時為單位。此時間與使用者活動無關。Cookie 到期之後，用戶端 Web 瀏覽器會刪除 Cookie，而且不再傳送到 Ingress 控制器。例如，若要設定 1 秒、1 分鐘或 1 小時的有效期限，請輸入 <strong>1s</strong>、<strong>1m</strong> 或 <strong>1h</strong>。</li><li><code><em>&lt;cookie_path&gt;</em></code>：附加至 Ingress 子網域的路徑，且該路徑指出針對哪些網域和子網域傳送 Cookie 到 Ingress 控制器。例如，如果您的 Ingress 網域是 <code>www.myingress.com</code> 且想要在每個用戶端要求中傳送 Cookie，您必須設定 <code>path=/</code>。如果您只想針對 <code>www.myingress.com/myapp</code> 及其所有子網域傳送 Cookie，則必須設定 <code>path=/myapp</code>。</li><li><code><em>&lt;hash_algorithm&gt;</em></code>：保護 Cookie 中資訊的雜湊演算法。僅支援 <code>sha1</code>。SHA1 會根據 Cookie 中的資訊建立雜湊總和，並將此雜湊總和附加到 Cookie。伺服器可以解密 Cookie 中的資訊，然後驗證資料完整性。</li></ul></td>
  </tr>
  </tbody></table>

 </dd></dl>


##### **新增自訂 HTTP 標頭至用戶端要求或用戶端回應**
{: #add_header}

使用此註釋，可以新增額外的標頭資訊至用戶端要求，然後才將要求傳送至後端應用程式，或新增至用戶端回應，然後才將回應傳送至用戶端。
{:shortdesc}

<dl>
<dt>說明</dt>
<dd>Ingress 控制器充當用戶端應用程式與後端應用程式之間的 Proxy。傳送到 Ingress 控制器的用戶端要求會被處理（代理），然後放入新的要求，從 Ingress 控制器傳送到您的後端應用程式。代理 (Proxy) 要求會移除一開始從用戶端傳送的 HTTP 標頭資訊，例如使用者名稱。如果您的後端應用程式需要此資訊，可以使用 <strong>ingress.bluemix.net/proxy-add-headers</strong> 註釋，將標頭資訊新增至用戶端要求，之後才將要求從 Ingress 控制器轉遞到您的後端應用程式。

</br></br>
當後端應用程式傳送回應給用戶端時，回應會由 Ingress 控制器代理，並從回應移除 HTTP 標頭。用戶端 Web 應用程式可能需要此標頭資訊才能順利處理回應。您可以使用 <strong>ingress.bluemix.net/response-add-headers</strong> 註釋，將標頭資訊新增至用戶端回應，之後才將回應從 Ingress 控制器轉遞到用戶端 Web 應用程式。</dd>
<dt>Ingress 資源範例 YAML</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/proxy-add-headers: |
      serviceName=&lt;service_name1&gt; {
      &lt;header1> &lt;value1&gt;;
      &lt;header2> &lt;value2&gt;;
      }
      serviceName=&lt;service_name2&gt; {
      &lt;header3&gt; &lt;value3&gt;;
      }
    ingress.bluemix.net/response-add-headers: |
      serviceName=&lt;service_name1&gt; {
      "&lt;header1&gt;: &lt;value1&gt;";
      "&lt;header2&gt;: &lt;value2&gt;";
      }
      serviceName=&lt;service_name1&gt; {
      "&lt;header3&gt;: &lt;value3&gt;";
      }
spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: &lt;service_name1&gt;
          servicePort: 8080
      - path: /myapp
        backend:
          serviceName: &lt;service_name2&gt;
          servicePort: 80</code></pre>

 <table>
  <thead>
  <th colspan=2><img src="images/idea.png"/> 瞭解 YAML 檔案元件</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>請取代下列值：<ul><li><code><em>&lt;service_name&gt;</em></code>：您為應用程式所建立之 Kubernetes 服務的名稱。</li><li><code><em>&lt;header&gt;</em></code>：要新增至用戶端要求或用戶端回應的標頭資訊索引鍵。</li><li><code><em>&lt;value&gt;</em></code>：要新增至用戶端要求或用戶端回應的標頭資訊值。</li></ul></td>
  </tr>
  </tbody></table>

 </dd></dl>

##### **從用戶端回應移除 HTTP 標頭資訊**
{: #remove_response_headers}

使用此註釋，可以移除來自後端應用程式之用戶端回應中包含的標頭資訊，再將回應傳送至用戶端。
{:shortdesc}

<dl>
<dt>說明</dt>
<dd>Ingress 控制器充當後端應用程式與用戶端 Web 瀏覽器之間的 Proxy。從後端應用程式傳送到 Ingress 控制器的用戶端回應會被處理（代理），然後放入新的回應，從 Ingress 控制器傳送到用戶端 Web 瀏覽器。雖然代理回應會移除一開始從後端應用程式傳送的 HTTP 標頭資訊，但這個程序不一定會移除所有後端應用程式特有的標頭。使用此註釋，可以從用戶端回應移除標頭資訊，之後才將回應從 Ingress 控制器轉遞到用戶端 Web 應用程式。</dd>
<dt>Ingress 資源範例 YAML</dt>
<dd>
<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/response-remove-headers: |
      serviceName=&lt;service_name1&gt; {
      "&lt;header1&gt;";
      "&lt;header2&gt;";
      }
      serviceName=&lt;service_name2&gt; {
      "&lt;header3&gt;";
      }
spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: &lt;service_name1&gt;
          servicePort: 8080
      - path: /myapp
        backend:
          serviceName: &lt;service_name2&gt;
          servicePort: 80</code></pre>

 <table>
  <thead>
  <th colspan=2><img src="images/idea.png"/> 瞭解 YAML 檔案元件</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>請取代下列值：<ul><li><code><em>&lt;service_name&gt;</em></code>：您為應用程式所建立之 Kubernetes 服務的名稱。</li><li><code><em>&lt;header&gt;</em></code>：要從用戶端回應移除的標頭索引鍵。</li></ul></td>
  </tr>
  </tbody></table>

  </dd></dl>


##### **將不安全的 HTTP 用戶端要求重新導向至 HTTPS**
{: #redirect_http_to_https}

使用重新導向註釋，可以將不安全的 HTTP 用戶端要求重新導向至 HTTPS。
{:shortdesc}

<dl>
<dt>說明</dt>
<dd>您設定 Ingress 控制器，以 IBM 提供的 TLS 憑證或您的自訂 TLS 憑證來保護網域。有些使用者可能會嘗試對 Ingress 控制器網域使用不安全的 HTTP 要求存取您的應用程式，例如 <code>http://www.myingress.com</code>，而不是使用 <code>https</code>。您可以使用重新導向註釋，一律將不安全的 HTTP 用戶端要求重新導向至 HTTPS。如果您不使用此註釋，依預設，不安全的 HTTP 要求不會轉換成 HTTPS 要求，且可能使得機密資訊公開給大眾而未加密。

</br></br>
依預設，會停用將 HTTP 要求重新導向至 HTTPS。</dd>
<dt>Ingress 資源範例 YAML</dt>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/redirect-to-https: "True"
spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>
</dd></dl>

##### **在 Ingress 控制器上停用後端回應的緩衝**
{: #response_buffer}

使用緩衝區註釋，可以停用在資料傳送至用戶端時，在 Ingress 控制器上儲存回應資料。
{:shortdesc}

<dl>
<dt>說明</dt>
<dd>Ingress 控制器充當後端應用程式與用戶端 Web 瀏覽器之間的 Proxy。回應從後端應用程式傳送至用戶端時，依預設會將回應資料緩衝在 Ingress 控制器上。Ingress 控制器會代理用戶端回應，並開始按照用戶端的速度將回應傳送至用戶端。Ingress 控制器收到來自後端應用程式的所有資料之後，會關閉後端連線。從 Ingress 控制器到用戶端的連線會維持開啟，直到用戶端收到所有資料為止。

</br></br>
如果停用在 Ingress 控制器上緩衝回應資料，資料立即從 Ingress 控制器傳送至用戶端。用戶端必須能夠按照 Ingress 控制器的速度處理送入的資料。如果用戶端太慢，資料可能會遺失。
</br></br>
依預設會啟用 Ingress 控制器上的回應資料緩衝。</dd>
<dt>Ingress 資源範例 YAML</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/proxy-buffering: "False"
spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>
</dd></dl>


##### **為 Ingress 控制器設定自訂連接逾時和讀取逾時**
{: #timeout}

調整 Ingress 控制器連接及讀取後端應用程式時等候的時間，在此時間之後，後端應用程式將被視為無法使用。
{:shortdesc}

<dl>
<dt>說明</dt>
<dd>用戶端要求傳送至 Ingress 控制器時，Ingress 控制器會開啟與後端應用程式的連線。依預設，Ingress 控制器會等待 60 秒，以便從後端應用程式收到回覆。如果後端應用程式未在 60 秒內回答，則會中斷連線要求，且後端應用程式將被視為無法使用。
</br></br>
Ingress 控制器連接至後端應用程式之後，Ingress 控制器會讀取來自後端應用程式的回應資料。在此讀取作業期間，Ingress 控制器在兩次讀取作業之間最多等待 60 秒，以接收來自後端應用程式的資料。如果後端應用程式未在 60 秒內傳送資料，則會關閉與後端應用程式的連線，且應用程式將被視為無法使用。
</br></br>
60 秒的連接逾時和讀取逾時，是 Proxy 上的預設逾時，理想中不應該加以變更。
</br></br>
如果應用程式的可用性不穩定，或是您的應用程式因為高工作負載而回應太慢，您或許會想增加連接逾時或讀取逾時。請記住，增加逾時會影響 Ingress 控制器的效能，因為與後端應用程式的連線必須維持開啟，直到達到逾時為止。
</br></br>
另一方面，您可以減少逾時以提高 Ingress 控制器的效能。請確保您的後端應用程式能夠在指定的逾時內處理要求，即使是在較高工作負載的時段。</dd>
<dt>Ingress 資源範例 YAML</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/proxy-connect-timeout: "&lt;connect_timeout&gt;s"
    ingress.bluemix.net/proxy-read-timeout: "&lt;read_timeout&gt;s"
spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

<table>
  <thead>
  <th colspan=2><img src="images/idea.png"/> 瞭解 YAML 檔案元件</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>請取代下列值：<ul><li><code><em>&lt;connect_timeout&gt;</em></code>：輸入要等待連接後端應用程式的秒數，例如 <strong>65s</strong>。

  </br></br>
  <strong>附註：</strong>連接逾時不可超過 75 秒。</li><li><code><em>&lt;read_timeout&gt;</em></code>：輸入要等待從後端應用程式讀取的秒數，例如 <strong>65s</strong>。</li></ul></td>
  </tr>
  </tbody></table>

  </dd></dl>

##### **設定用戶端要求內文的允許大小上限**
{: #client_max_body_size}

使用這個註釋，可以調整用戶端可以傳送作為要求一部分的內文大小。
{:shortdesc}

<dl>
<dt>說明</dt>
<dd>為了維護預期的效能，用戶端要求內文大小上限設為 1 MB。當內文大小超過限制的用戶端要求傳送至 Ingress 控制器，而且用戶端不允許將資料分成多個片段時，Ingress 控制器會傳回 413（要求的實體太大）的 HTTP 回應給用戶端。在要求內文的大小減少之前，用戶端及 Ingress 控制器之間無法進行連線。當用戶端允許資料分割成多個片段時，資料會分成 1 MB 的套件，然後傳送至 Ingress 控制器。

</br></br>
您可能會想要增加內文大小上限，因為您預期用戶端要求的內文大小會大於 1 MB。例如，您要讓用戶端能上傳大型檔案。增加要求內文大小上限可能會影響 Ingress 控制器的效能，因為對用戶端的連線必須維持開啟，直到收到要求為止。
</br></br>
<strong>附註：</strong>部分用戶端 Web 瀏覽器無法適當地顯示 413 HTTP 回應訊息。</dd>
<dt>Ingress 資源範例 YAML</dt>
<dd>

<pre class="codeblock">
<code>apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingress
  annotations:
    ingress.bluemix.net/client-max-body-size: "&lt;size&gt;"
spec:
  tls:
  - hosts:
    - mydomain
    secretName: mytlssecret
  rules:
  - host: mydomain
    http:
      paths:
      - path: /
        backend:
          serviceName: myservice
          servicePort: 8080</code></pre>

<table>
  <thead>
  <th colspan=2><img src="images/idea.png"/> 瞭解 YAML 檔案元件</th>
  </thead>
  <tbody>
  <tr>
  <td><code>annotations</code></td>
  <td>請取代下列值：<ul><li><code><em>&lt;size&gt;</em></code>：輸入用戶端回應內文的大小上限。例如，若要將它設為 200 MB，請定義 <strong>200m</strong>。

  </br></br>
  <strong>附註：</strong>您可以將大小設為 0，以停用用戶端要求內文大小的檢查。</li></ul></td>
  </tr>
  </tbody></table>

  </dd></dl>


## 管理 IP 位址及子網路
{: #cs_cluster_ip_subnet}

您可以使用可攜式公用子網路及 IP 位址來公開叢集中的應用程式，並且將它們設為可從網際網路中進行存取。
{:shortdesc}

在 {{site.data.keyword.containershort_notm}} 中，您可以將網路子網路新增至叢集，為 Kubernetes 服務新增穩定的可攜式 IP。當您建立標準叢集時，{{site.data.keyword.containershort_notm}} 會自動佈建 1 個可攜式公用子網路及 5 個 IP 位址。可攜式公用 IP 位址是靜態的，不會在移除工作者節點或甚至叢集時變更。

使用公用路徑，以將其中一個可攜式公用 IP 位址用於可用來公開叢集中多個應用程式的 [Ingress 控制器](#cs_apps_public_ingress)。[建立負載平衡器服務](#cs_apps_public_load_balancer)，即可使用其餘 4 個可攜式公用 IP 位址，將單一應用程式公開給大眾使用。

**附註：**可攜式公用 IP 位址是按月收費。如果您選擇在佈建叢集之後移除可攜式公用 IP 位址，則仍需要按月支付費用，即使您僅短時間使用。



1.  建立名為 `myservice.yaml` 的 Kubernetes 服務配置 Script，並且使用虛擬負載平衡器 IP 位址來定義類型為 `LoadBalancer` 的服務。下列範例使用 IP 位址 1.1.1.1 作為負載平衡器 IP 位址。

    ```
    apiVersion: v1
    kind: Service
    metadata:
      labels:
        run: myservice
      name: myservice
      namespace: default
    spec:
      ports:
      - port: 80
        protocol: TCP
        targetPort: 80
      selector:
        run: myservice
      sessionAffinity: None
      type: LoadBalancer
      loadBalancerIP: 1.1.1.1
    ```
    {: codeblock}

2.  在叢集中建立服務。

    ```
    kubectl apply -f myservice.yaml
    ```
    {: pre}

3.  檢查服務。

    ```
    kubectl describe service myservice
    ```
    {: pre}

    **附註：**建立此服務失敗，因為 Kubernetes 主節點在 Kubernetes 配置對映中找不到指定的負載平衡器 IP 位址。當您執行此指令時，可以看到錯誤訊息以及叢集可用的公用 IP 位址清單。

    ```
    Error on cloud load balancer a8bfa26552e8511e7bee4324285f6a4a for service default/myservice with UID 8bfa2655-2e85-11e7-bee4-324285f6a4af: Requested cloud provider IP 1.1.1.1 is not available. The following cloud provider IPs are available: <list_of_IP_addresses>
    ```
    {: screen}

</staging>

### 釋放已使用的公用 IP 位址
{: #freeup_ip}

您可以刪除使用可攜式公用 IP 位址的負載平衡器服務，以釋放已使用的可攜式公用 IP 位址。

[開始之前，請為您要使用的叢集設定環境定義。](cs_cli_install.html#cs_cli_configure)

1.  列出叢集中可用的服務。

    ```
    kubectl get services
    ```
    {: pre}

2.  移除使用公用 IP 位址的負載平衡器服務。

    ```
    kubectl delete service <myservice>
    ```
    {: pre}


## 使用 GUI 部署應用程式
{: #cs_apps_ui}

當您使用 Kubernetes 儀表板將應用程式部署至叢集時，會自動建立可建立、更新及管理叢集中 Pod 的部署。
{:shortdesc}

開始之前：

-   安裝必要的 [CLI](cs_cli_install.html#cs_cli_install)。
-   [將 CLI 的目標設為](cs_cli_install.html#cs_cli_configure)您的叢集。

若要部署應用程式，請執行下列動作：

1.  [開啟 Kubernetes 儀表板](#cs_cli_dashboard)。
2.  從 Kubernetes 儀表板中，按一下 **+ 建立**。
3.  選取**在下面指定應用程式詳細資料**以在 GUI 上輸入應用程式詳細資料，或選取**上傳 YAML 或 JSON 檔案**以上傳應用程式[配置檔 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-container/)。使用[此範例 YAML 檔案 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://github.com/IBM-{{site.data.keyword.Bluemix_notm}}/kube-samples/blob/master/deploy-apps-clusters/deploy-ibmliberty.yaml)，以在美國南部地區從 **ibmliberty** 映像檔部署容器。
4.  在 Kubernetes 儀表板中，按一下**部署**，以驗證已建立部署。
5.  如果您使用節點埠服務讓應用程式可公開使用，負載平衡器服務（或 Ingress）會[確認您可以存取此應用程式](#cs_apps_public)。

## 使用 CLI 部署應用程式
{: #cs_apps_cli}

建立叢集之後，您可以使用 Kubernetes CLI 以將應用程式部署至該叢集。
{:shortdesc}

開始之前：

-   安裝必要的 [CLI](cs_cli_install.html#cs_cli_install)。
-   [將 CLI 的目標設為](cs_cli_install.html#cs_cli_configure)您的叢集。

若要部署應用程式，請執行下列動作：

1.  根據 [Kubernetes 最佳作法 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/concepts/configuration/overview/) 建立配置 Script。配置 Script 通常會包含您在 Kubernetes 中建立之每一個資源的配置詳細資料。您的 Script 可能包括下列一個以上區段：

    -   [Deployment ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)：定義 Pod 和抄本集的建立。Pod 包括一個個別的容器化應用程式，而抄本集會控制多個 Pod 實例。

    -   [Service ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/concepts/services-networking/service/)：藉由使用工作者節點或負載平衡器公用 IP 位址，或公用 Ingress 路徑，提供 Pod 的前端存取。

    -   [Ingress ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/concepts/services-networking/ingress/)：指定一種負載平衡器，提供路徑來公開存取您的應用程式。

2.  在叢集的環境定義中執行配置 Script。

    ```
    kubectl apply -f deployment_script_location
    ```
    {: pre}

3.  如果您使用節點埠服務讓應用程式可公開使用，負載平衡器服務（或 Ingress）會[確認您可以存取此應用程式](#cs_apps_public)。



## 管理漸進式部署
{: #cs_apps_rolling}

您可以以自動化及受管制的方式來管理變更推出。如果推出不是根據計劃進行，您可以將部署回復為前一個修訂。
{:shortdesc}

在開始之前，請先建立[部署](#cs_apps_cli)。

1.  [推出 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/user-guide/kubectl/v1.5/#rollout) 變更。例如，您可能想要變更起始部署中所用的映像檔。

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

    2.  回復為前一個版本，或指定修訂版。若要回復為前一個版本，請使用下列指令。

        ```
        kubectl rollout undo deployment/<depoyment_name> --to-revision=<number>
        ```
        {: pre}

## 新增 {{site.data.keyword.Bluemix_notm}} 服務
{: #cs_apps_service}

加密 Kubernetes Secret 是用來儲存 {{site.data.keyword.Bluemix_notm}} 服務詳細資料及認證，以及容許服務與叢集之間的安全通訊。身為叢集使用者，您可以將此 Secret 以磁區形式裝載至 Pod 來進行存取。
{:shortdesc}

開始之前，請先將 [CLI 的目標](cs_cli_install.html#cs_cli_configure)設為您的叢集。請確定叢集管理者已將您要用在應用程式中的 {{site.data.keyword.Bluemix_notm}} 服務[新增至叢集](cs_cluster.html#cs_cluster_service)。

Kubernetes Secret 是一種儲存機密資訊（例如使用者名稱、密碼或金鑰）的安全方式。Secret 必須以 Secret 磁區形式裝載至 Pod，以供在 Pod 中執行的容器存取，而不是透過環境變數或直接在 Dockerfile 中公開機密資訊。

當您將 Secret 磁區裝載至 Pod 時，會將名為 binding 的檔案儲存在磁區裝載目錄中，該目錄包括您存取 {{site.data.keyword.Bluemix_notm}} 服務所需的所有資訊及認證。

1.  列出叢集名稱空間中的可用 Secret。

    ```
    kubectl get secrets --namespace=<my_namespace>
    ```
    {: pre}

    輸出範例：

    ```
    NAME                                    TYPE                                  DATA      AGE
    binding-<service_instance_name>         Opaque                                1         3m

    ```
    {: screen}

2.  尋找 **Opaque** 類型的 Secret，並記下 Secret 的**名稱**。如果有多個 Secret，請與叢集管理者聯絡，以識別正確的服務 Secret。

3.  開啟您偏好的編輯器。

4.  建立 YAML 檔案，以配置可透過 Secret 磁區存取服務詳細資料的 Pod。

    ```
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
      labels:
        app: secret-test
      name: secret-test
      namespace: <my_namespace>
    spec:
      selector:
        matchLabels:
          app: secret-test
      replicas: 1
      template:
        metadata:
          labels:
            app: secret-test
        spec:
          containers:
          - image: nginx
            name: secret-test
            volumeMounts:
            - mountPath: /opt/service-bind
              name: service-bind-volume
          volumes:
          - name: service-bind-volume
            secret:
              defaultMode: 420
              secretName: binding-<service_instance_name>
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png"/> 瞭解 YAML 檔案元件</th>
    </thead>
    <tbody>
    <tr>
    <td><code>volumeMounts/mountPath</code></td>
    <td>您要裝載至容器的 Secret 磁區的名稱。</td>
    </tr>
    <tr>
    <td><code>volumes/name</code></td>
    <td>輸入您要裝載至容器的 Secret 磁區的名稱。</td>
    </tr>
    <tr>
    <td><code>secret/defaultMode</code></td>
    <td>設定服務 Secret 的唯讀許可權。</td>
    </tr>
    <tr>
    <td><code>secret/secretName</code></td>
    <td>輸入您稍早記下的 Secret 的名稱。</td>
    </tr></tbody></table>

5.  建立 Pod，並裝載 Secret 磁區。

    ```
    kubectl apply -f <yaml_path>
    ```
    {: pre}

6.  驗證已建立 Pod。

    ```
    kubectl get pods --namespace=<my_namespace>
    ```
    {: pre}

    CLI 輸出範例：

    ```
    NAME                           READY     STATUS    RESTARTS   AGE
    secret-test-1111454598-gfx32   1/1       Running   0          1m
    ```
    {: screen}

7.  記下 Pod 的**名稱**。
8.  取得 Pod 的詳細資料，並尋找 Secret 名稱。

    ```
    kubectl describe pod <pod_name>
    ```
    {: pre}

    輸出：

    ```
    ...
    Volumes:
      service-bind-volume:
        Type:       Secret (a volume populated by a Secret)
        SecretName: binding-<service_instance_name>
    ...
    ```
    {: screen}

    

9.  實作應用程式時，請將它配置為在裝載目錄中尋找名為 **binding** 的 Secret 檔案、剖析 JSON 內容，以及判定可存取 {{site.data.keyword.Bluemix_notm}} 服務的 URL 及服務認證。

您現在可以存取 {{site.data.keyword.Bluemix_notm}} 服務詳細資料及認證。若要使用 {{site.data.keyword.Bluemix_notm}} 服務，請確定應用程式已配置為在裝載目錄中尋找服務 Secret 檔案、剖析 JSON 內容，以及判定服務詳細資料。

## 建立持續性儲存空間
{: #cs_apps_volume_claim}

您會建立持續性磁區宣告，以為叢集佈建 NFS 檔案儲存空間。您將此宣告裝載至 Pod，以確保即使 Pod 損毀或關閉，也能使用資料。
{:shortdesc}

IBM 已叢集化支援持續性磁區的 NFS 檔案儲存空間，可提供資料的高可用性。

1.  檢閱可用的儲存空間類別。{{site.data.keyword.containerlong}} 提供三個預先定義的儲存空間類別，因此叢集管理者不需要建立任何儲存空間類別。


    ```
    kubectl get storageclasses
    ```
    {: pre}

    ```
    $ kubectl get storageclasses
    NAME                         TYPE
    ibmc-file-bronze (default)   ibm.io/ibmc-file
    ibmc-file-gold               ibm.io/ibmc-file
    ibmc-file-silver             ibm.io/ibmc-file
    ```
    {: screen}

2.  檢閱儲存空間類別的 IOPS 或可用大小。

    ```
    kubectl describe storageclasses ibmc-file-silver
    ```
    {: pre}

    **parameters** 欄位提供每個與儲存空間類別相關聯的 GB 的 IOPS 以及可用大小（以 GB 為單位）。

    ```
    Parameters: iopsPerGB=4,sizeRange=20Gi,40Gi,80Gi,100Gi,250Gi,500Gi,1000Gi,2000Gi,4000Gi,8000Gi,12000Gi
    ```
    {: screen}

3.  在您偏好的文字編輯器中，建立配置 Script 來定義持續性磁區宣告，以及將配置儲存為 `.yaml` 檔案。

    ```
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: <pvc_name>
      annotations:
        volume.beta.kubernetes.io/storage-class: "ibmc-file-silver"
    spec:
      accessModes:
        - ReadWriteMany
      resources:
        requests:
          storage: 20Gi
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png"/> 瞭解 YAML 檔案元件</th>
    </thead>
    <tbody>
    <tr>
    <td><code>metadata/name</code></td>
    <td>輸入持續性磁區宣告的名稱。</td>
    </tr>
    <tr>
    <td><code>metadata/annotations</code></td>
    <td>指定儲存空間類別，定義持續性磁區之主機檔案共用的每個 GB 的 IOPS：<ul><li>ibmc-file-bronze：每個 GB 有 2 個 IOPS。</li><li>ibmc-file-silver：每個 GB 有 4 個 IOPS。</li><li>ibmc-file-gold：每個 GB 有 10 個 IOPS。</li>

    </li> 如果未指定任何儲存空間類別，則會建立具有 bronze 儲存空間類別的持續性磁區。</td>
    </tr>
    <tr>
    <td><code>spec/accessModes</code>
    <code>resources/requests/storage</code></td>
    <td> 如果您選擇的大小不是所列出的大小，則會將此大小四捨五入。如果您選取的大小大於最大大小，則會對此大小進行無條件捨去。</td>
    </tr>
    </tbody></table>

4.  建立持續性磁區宣告。

    ```
    kubectl apply -f <local_file_path>
    ```
    {: pre}

5.  驗證持續性磁區宣告已建立並連結至持續性磁區。此處理程序可能需要幾分鐘的時間。

    ```
    kubectl describe pvc <pvc_name>
    ```
    {: pre}

    您的輸出會與下列內容類似。

    ```
    Name:  <pvc_name>
    Namespace: default
    StorageClass: ""
    Status:  Bound
    Volume:  pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
    Labels:  <none>
    Capacity: 20Gi
    Access Modes: RWX
    Events:
      FirstSeen LastSeen Count From        SubObjectPath Type  Reason   Message
      --------- -------- ----- ----        ------------- -------- ------   -------
      3m  3m  1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 }   Normal  Provisioning  External provisioner is provisioning volume for claim "default/my-persistent-volume-claim"
      3m  1m  10 {persistentvolume-controller }       Normal  ExternalProvisioning cannot find provisioner "ibm.io/ibmc-file", expecting that a volume for the claim is provisioned either manually or via external software
      1m  1m  1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 }   Normal  ProvisioningSucceeded Successfully provisioned volume pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2

    ```
    {: screen}

6.  {: #cs_apps_volume_mount}若要將持續性磁區宣告裝載至 Pod，請建立配置 Script。將配置儲存為 `.yaml` 檔案。

    ```
    apiVersion: v1
    kind: Pod
    metadata:
     name: <pod_name>
    spec:
     containers:
     - image: nginx
       name: mycontainer
       volumeMounts:
       - mountPath: /volumemount
         name: myvol
     volumes:
     - name: myvol
       persistentVolumeClaim:
         claimName: mypvc
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png"/> 瞭解 YAML 檔案元件</th>
    </thead>
    <tbody>
    <tr>
    <td><code>metadata/name</code></td>
    <td>Pod 的名稱。</td>
    </tr>
    <tr>
    <td><code>volumeMounts/mountPath</code></td>
    <td>在容器內裝載磁區的目錄的絕對路徑。</td>
    </tr>
    <tr>
    <td><code>volumeMounts/name</code></td>
    <td>您裝載至容器的磁區的名稱。</td>
    </tr>
    <tr>
    <td><code>volumes/name</code></td>
    <td>您裝載至容器的磁區的名稱。此名稱通常與 <code>volumeMounts/name</code> 相同。</td>
    </tr>
    <tr>
    <td><code>volumes/name/persistentVolumeClaim</code></td>
    <td>您要用來作為磁區的持續性磁區宣告的名稱。當您將磁區裝載至 Pod 時，Kubernetes 會識別連結至持續性磁區宣告的持續性磁區，並讓使用者讀取及寫入持續性磁區。</td>
    </tr>
    </tbody></table>

7.  建立 Pod，並將持續性磁區宣告裝載至 Pod。

    ```
    kubectl apply -f <local_yaml_path>
    ```
    {: pre}

8.  驗證磁區已順利裝載至 Pod。

    ```
    kubectl describe pod <pod_name>
    ```
    {: pre}

    裝載點在 **Volume Mounts**（磁區裝載）欄位中，而磁區在 **Volumes**（磁區）欄位中。

    ```
     Volume Mounts:
          /var/run/secrets/kubernetes.io/serviceaccount from default-token-tqp61 (ro)
          /volumemount from myvol (rw)
    ...
    Volumes:
      myvol:
        Type: PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
        ClaimName: mypvc
        ReadOnly: false

    ```
    {: screen}

## 新增非 root 使用者對持續性儲存空間的存取權
{: #cs_apps_volumes_nonroot}

非 root 使用者對 NFS 支援的儲存空間的磁區裝載路徑沒有寫入權。若要授與寫入權，您必須編輯映像檔的 Dockerfile，以使用正確許可權在裝載路徑上建立目錄。
{:shortdesc}

開始之前，請先將 [CLI 的目標](cs_cli_install.html#cs_cli_configure)設為您的叢集。

如果您是使用需要磁區寫入權的非 root 使用者來設計應用程式，則必須將下列處理程序新增至 Dockerfile 及進入點 Script：

-   建立非 root 使用者。
-   暫時將使用者新增至 root 群組。
-   使用正確的使用者許可權在磁區裝載路徑中建立目錄。

對於 {{site.data.keyword.containershort_notm}}，磁區裝載路徑的預設擁有者是擁有者 `nobody`。使用 NFS 儲存空間，如果擁有者不存在於 Pod 本端，則會建立 `nobody` 使用者。磁區設定成辨識容器中的 root 使用者，對部分應用程式而言，這是容器內唯一的使用者。不過，許多應用程式會指定寫入至容器裝載路徑且不是 `nobody` 的非 root 使用者。

1.  在本端目錄中建立 Dockerfile。此範例 Dockerfile 會建立名為 `myguest` 的非 root 使用者。

    ```
    FROM registry.<region>.bluemix.net/ibmnode:latest

    # Create group and user with GID & UID 1010.
    # In this case your are creating a group and user named myguest.
    # The GUID and UID 1010 is unlikely to create a conflict with any existing user GUIDs or UIDs in the image.
    # The GUID and UID must be between 0 and 65536. Otherwise, container creation fails.
    RUN groupadd --gid 1010 myguest
    RUN useradd --uid 1010 --gid 1010 -m --shell /bin/bash myguest

    ENV MY_USER=myguest

    COPY entrypoint.sh /sbin/entrypoint.sh
    RUN chmod 755 /sbin/entrypoint.sh

    EXPOSE 22
    ENTRYPOINT ["/sbin/entrypoint.sh"]
    ```
    {: codeblock}

2.  在與 Dockerfile 相同的本端資料夾中，建立進入點 Script。此範例進入點 Script 會將 `/mnt/myvol` 指定為磁區裝載路徑。

    ```
    #!/bin/bash
    set -e

    # This is the mount point for the shared volume.
    # By default the mount point is owned by the root user.
    MOUNTPATH="/mnt/myvol"
    MY_USER=${MY_USER:-"myguest"}

    # This function creates a subdirectory that is owned by
    # the non-root user under the shared volume mount path.
    create_data_dir() {
      #Add the non-root user to primary group of root user.
      usermod -aG root $MY_USER

      # Provide read-write-execute permission to the group for the shared volume mount path.
      chmod 775 $MOUNTPATH

      # Create a directory under the shared path owned by non-root user myguest.
      su -c "mkdir -p ${MOUNTPATH}/mydata" -l $MY_USER
      su -c "chmod 700 ${MOUNTPATH}/mydata" -l $MY_USER
      ls -al ${MOUNTPATH}

      # For security, remove the non-root user from root user group.
      deluser $MY_USER root

      # Change the shared volume mount path back to its original read-write-execute permission.
      chmod 755 $MOUNTPATH
      echo "Created Data directory..."
    }

    create_data_dir

    # This command creates a long-running process for the purpose of this example.
    tail -F /dev/null
    ```
    {: codeblock}

3.  登入 {{site.data.keyword.registryshort_notm}}。

    ```
    bx cr login
    ```
    {: pre}

4.  本端建置映像檔。請記得將 _&lt;my_namespace&gt;_ 取代為專用映像檔登錄的名稱空間。如果您需要尋找名稱空間，請執行 `bx cr namespace-get`。

    ```
    docker build -t registry.<region>.bluemix.net/<my_namespace>/nonroot .
    ```
    {: pre}

5.  將映像檔推送至 {{site.data.keyword.registryshort_notm}} 中的名稱空間。

    ```
    docker push registry.<region>.bluemix.net/<my_namespace>/nonroot
    ```
    {: pre}

6.  建立配置 `.yaml` 檔案，以建立持續性磁區宣告。此範例使用較低效能的儲存類別。請執行 `kubectl get storageclasses`，以查看可用的儲存類別。

    ```
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: mypvc
      annotations:
        volume.beta.kubernetes.io/storage-class: "ibmc-file-bronze"
    spec:
      accessModes:
        - ReadWriteMany
      resources:
        requests:
          storage: 20Gi
    ```
    {: codeblock}

7.  建立持續性磁區宣告。

    ```
    kubectl apply -f <local_file_path>
    ```
    {: pre}

8.  建立配置 Script，以裝載磁區然後從 nonroot 映像檔中執行 Pod。磁區裝載路徑 `/mnt/myvol` 符合 Dockerfile 中所指定的裝載路徑。將配置儲存為 `.yaml` 檔案。

    ```
    apiVersion: v1
    kind: Pod
    metadata:
     name: mypod
    spec:
     containers:
     - image: registry.<region>.bluemix.net/<my_namespace>/nonroot
       name: mycontainer
       volumeMounts:
       - mountPath: /mnt/myvol
         name: myvol
     volumes:
     - name: myvol
       persistentVolumeClaim:
         claimName: mypvc
    ```
    {: codeblock}

9.  建立 Pod，並將持續性磁區宣告裝載至 Pod。

    ```
    kubectl apply -f <local_yaml_path>
    ```
    {: pre}

10. 驗證磁區已順利裝載至 Pod。

    ```
    kubectl describe pod mypod
    ```
    {: pre}

    裝載點會列在 **Volume Mounts**（磁區裝載）欄位中，而磁區會列在 **Volumes**（磁區）欄位中。

    ```
     Volume Mounts:
          /var/run/secrets/kubernetes.io/serviceaccount from default-token-tqp61 (ro)
          /mnt/myvol from myvol (rw)
    ...
    Volumes:
      myvol:
        Type: PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
        ClaimName: mypvc
        ReadOnly: false

    ```
    {: screen}

11. 在 Pod 執行之後，登入 Pod。

    ```
    kubectl exec -it mypod /bin/bash
    ```
    {: pre}

12. 檢視磁區裝載路徑的許可權。

    ```
    ls -al /mnt/myvol/
    ```
    {: pre}

    ```
    root@instance-006ff76b:/# ls -al /mnt/myvol/
    total 12
    drwxr-xr-x 3 root    root    4096 Jul 13 19:03 .
    drwxr-xr-x 3 root    root    4096 Jul 13 19:03 ..
    drwx------ 2 myguest myguest 4096 Jul 13 19:03 mydata
    ```
    {: screen}

    此輸出顯示 root 具有磁區裝載路徑 `mnt/myvol/` 的讀取、寫入及執行權，但非 root myguest 使用者則具有 `mnt/myvol/mydata` 資料夾的讀取及寫入權。因為這些更新過的許可權，所以非 root 使用者現在可以將資料寫入至持續性磁區。


