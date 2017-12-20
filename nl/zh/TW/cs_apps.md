---

copyright:
  years: 2014, 2017
lastupdated: "2017-11-28"

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

藉由按一下下列影像的區域，來瞭解部署應用程式的一般步驟。

<img usemap="#d62e18" border="0" class="image" id="basic_deployment_process" src="images/basic_deployment_process.png" width="780" style="width:780px;"/>
<map name="d62e18" id="d62e18">
<area href="cs_cli_install.html" target="_blank" alt="安裝 CLI。" title="安裝 CLI。" shape="rect" coords="30, 69, 179, 209" />
<area href="https://kubernetes.io/docs/concepts/configuration/overview/" target="_blank" alt="為您的應用程式建立配置檔。請檢閱來自 Kubernetes 的最佳作法。" title="為您的應用程式建立配置檔。請檢閱來自 Kubernetes 的最佳作法。" shape="rect" coords="254, 64, 486, 231" />
<area href="#cs_apps_cli" target="_blank" alt="選項 1：執行來自 Kubernetes CLI 的配置檔。" title="選項 1：執行來自 Kubernetes CLI 的配置檔。" shape="rect" coords="544, 67, 730, 124" />
<area href="#cs_cli_dashboard" target="_blank" alt="選項 2：在本端啟動 Kubernetes 儀表板，並執行配置檔。" title="選項 2：在本端啟動 Kubernetes 儀表板，並執行配置檔。" shape="rect" coords="544, 141, 728, 204" />
</map>


<br />


## 啟動 Kubernetes 儀表板
{: #cs_cli_dashboard}

在本端系統上開啟 Kubernetes 儀表板，以檢視叢集及其工作者節點的相關資訊。
{:shortdesc}

開始之前，請先將 [CLI 的目標](cs_cli_install.html#cs_cli_configure)設為您的叢集。此作業需要[管理者存取原則](cs_cluster.html#access_ov)。請驗證您的現行[存取原則](cs_cluster.html#view_access)。

您可以使用預設埠或設定自己的埠，來啟動叢集的 Kubernetes 儀表板。

1.  對於 Kubernetes 主要版本為 1.7.4 或之前版本的叢集：

    1.  使用預設埠號來設定 Proxy。

        ```
        kubectl proxy
        ```
        {: pre}

        輸出：

        ```
        Starting to serve on 127.0.0.1:8001
        ```
        {: screen}

    2.  在 Web 瀏覽器中開啟 Kubernetes 儀表板。

        ```
        http://localhost:8001/ui
        ```
        {: codeblock}

2.  對於 Kubernetes 主要版本為 1.8.2 或更新版本的叢集：

    1.  下載您的認證。

        ```
        bx cs cluster-config <cluster_name>
        ```
        {: codeblock}

    2.  檢視已下載的叢集認證。使用在前一個步驟的匯出中指定的檔案路徑。

        對於 macOS 或 Linux：

        ```
        cat <filepath_to_cluster_credentials>
        ```
        {: codeblock}

        對於 Windows：

        ```
        type <filepath_to_cluster_credentials>
        ```
        {: codeblock}

    3.  複製 **id-token** 欄位中的記號。

    4.  使用預設埠號來設定 Proxy。

        ```
        kubectl proxy
        ```
        {: pre}

        您的 CLI 輸出看起來如下：

        ```
        Starting to serve on 127.0.0.1:8001
        ```
        {: screen}

    6.  登入儀表板。

        1.  將此 URL 複製到您的瀏覽器。

            ```
            http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/
            ```
            {: codeblock}

        2.  在登入頁面中，選取**記號**鑑別方法。

        3.  然後，將 **id-token** 值貼到**記號**欄位，然後按一下**登入**。

[接下來，您可以從儀表板執行配置檔。](#cs_apps_ui)

完成 Kubernetes 儀表板之後，使用 `CTRL+C` 來結束 `proxy` 指令。在您結束之後，無法再使用 Kubernetes 儀表板。請執行 `proxy` 指令，以重新啟動 Kubernetes 儀表板。



<br />


## 建立 Secret
{: #secrets}

Kubernetes Secret 是一種儲存機密資訊（例如使用者名稱、密碼或金鑰）的安全方式。


<table>
<caption>表格。需要藉由作業儲存在 Secret 中的檔案</caption>
<thead>
<th>作業</th>
<th>要儲存在 Secret 中的必要檔案</th>
</thead>
<tbody>
<tr>
<td>將服務新增至叢集</td>
<td>無。將服務連結至叢集時，系統會為您建立 Secret。</td>
</tr>
<tr>
<td>選用項目：如果不是使用 ingress-secret，請配置 Ingress 服務與 TLS 搭配。<p><b>附註</b>：依預設，TLS 已啟用，且已針對「TLS 連線」建立 Secret。

若要檢視預設 TLS Secret，請執行下列指令：
<pre>
bx cs cluster-get &gt;CLUSTER-NAME&lt; | grep "Ingress secret"
</pre>
</p>
若要改為自行建立，請完成這個主題中的步驟。</td>
<td>伺服器憑證及金鑰：<code>server.crt</code> 及 <code>server.key</code></td>
<tr>
<td>建立交互鑑別註釋。</td>
<td>CA 憑證：<code>ca.crt</code></td>
</tr>
</tbody>
</table>

如需您可以在 Secret 中儲存哪些項目的相關資訊，請參閱 [Kubernetes 文件](https://kubernetes.io/docs/concepts/configuration/secret/)。



若要使用憑證來建立 Secret，請執行下列動作：

1. 從憑證提供者產生憑證管理中心 (CA) 憑證及金鑰。如果您有自己的網域，請為您的網域購買正式的 TLS 憑證。基於測試目的，您可以產生自簽憑證。

 重要事項：請確定每一個憑證的 [CN](https://support.dnsimple.com/articles/what-is-common-name/) 都不同。

 用戶端憑證及用戶端金鑰必須最多驗證到授信主要憑證（在此情況下，指的是 CA 憑證）。範例：

 ```
 Client Certificate: issued by Intermediate Certificate
 Intermediate Certificate: issued by Root Certificate
 Root Certificate: issued by itself
 ```
 {: codeblock}

2. 建立憑證作為 Kubernetes Secret。

 ```
 kubectl create secret generic <secretName> --from-file=<cert_file>=<cert_file>
 ```
 {: pre}

 範例：
 - TLS 連線：

 ```
 kubectl create secret tls <secretName> --from-file=tls.crt=server.crt --from-file=tls.key=server.key
 ```
 {: pre}

 - 交互鑑別註釋：

 ```
 kubectl create secret generic <secretName> --from-file=ca.crt=ca.crt
 ```
 {: pre}

<br />



## 容許對應用程式的公用存取
{: #cs_apps_public}

若要將應用程式設為可在網際網路上公開使用，您必須先更新配置檔，再將應用程式部署至叢集。
{:shortdesc}

視您所建立的是精簡還是標準叢集而定，會有不同的方式可從網際網路存取您的應用程式。

<dl>
<dt><a href="#cs_apps_public_nodeport" target="_blank">NodePort 服務</a>（精簡及標準叢集）</dt>
<dd>公開每個工作者節點上的公用埠，並使用任何工作者節點的公用 IP 位址來公開存取您在叢集中的服務。工作者節點的公用 IP 位址不是永久性的。移除或重建工作者節點時，會將新的公用 IP 位址指派給工作者節點。NodePort 服務可以用於測試應用程式的公用存取，也可以用於僅短時間需要公用存取時。當您需要服務端點的穩定公用 IP 位址及更高可用性時，請使用 LoadBalancer 服務或 Ingress 來公開應用程式。</dd>
<dt><a href="#cs_apps_public_load_balancer" target="_blank">LoadBalancer 服務</a>（僅限標準叢集）</dt>
<dd>每個標準叢集都會佈建 4 個可攜式公用 IP 位址及 4 個可攜式專用 IP 位址，可用來建立應用程式的外部 TCP/ UDP 負載平衡器。您可以公開應用程式所需的任何埠來自訂負載平衡器。指派給負載平衡器的可攜式公用 IP 位址是永久性的，因此在叢集中重建工作者節點時並不會變更。</br>
如果您的應用程式需要 HTTP 或 HTTPS 負載平衡，而且要使用一個公用路徑將您叢集中的多個應用程式公開為服務，請使用
{{site.data.keyword.containershort_notm}} 的內建 Ingress 支援。</dd>
<dt><a href="#cs_apps_public_ingress" target="_blank">Ingress</a>（僅限標準叢集）</dt>
<dd>公開您叢集中的多個應用程式，方法是建立一個外部 HTTP 或 HTTPS 負載平衡器，以使用安全且唯一的公用進入點，將送入要求遞送給應用程式。Ingress 包含兩個主要元件：Ingress 資源及 Ingress 控制器。Ingress 資源會定義如何遞送及負載平衡應用程式送入要求的規則。所有 Ingress 資源都必須向 Ingress 控制器登錄，而 Ingress 控制器會接聽送入 HTTP 或 HTTPS 服務要求，並根據針對每一個 Ingress 資源所定義的規則來轉遞要求。如果您要使用自訂遞送規則來實作自己的負載平衡器，以及需要應用程式的 SSL 終止，請使用 Ingress。</dd></dl>

### 使用 NodePort 服務類型來配置應用程式的公用存取
{: #cs_apps_public_nodeport}

使用叢集中任何工作者節點的公用 IP 位址，並公開節點埠，將應用程式設為可在網際網路上進行存取。請使用此選項來進行測試及短期公用存取。

{:shortdesc}

對於精簡或標準叢集，您可以將應用程式公開為 Kubernetes NodePort 服務。

對於「{{site.data.keyword.Bluemix_dedicated_notm}}」環境，防火牆會封鎖公用 IP 位址。若要讓應用程式可公開使用，請改用 [LoadBalancer 服務](#cs_apps_public_load_balancer)或 [Ingress](#cs_apps_public_ingress)。

**附註：**工作者節點的公用 IP 位址不是永久性的。如果必須重建工作者節點，則會將新的公用 IP 位址指派給工作者節點。如果您需要服務的穩定公用 IP 位址及更高可用性，請使用 [LoadBalancer 服務](#cs_apps_public_load_balancer)或 [Ingress](#cs_apps_public_ingress) 來公開應用程式。




1.  在配置檔定義 [service ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/concepts/services-networking/service/) 區段。
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
    prod-dal10-pa215dcf5bbc0844a990fa6b0fcdbff286-w1  192.0.2.23  10.100.10.10  u2c.2x4  normal   Ready
    prod-dal10-pa215dcf5bbc0844a990fa6b0fcdbff286-w2  192.0.2.27  10.100.10.15  u2c.2x4  normal   Ready
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

### 使用負載平衡器服務類型來配置應用程式的存取
{: #cs_apps_public_load_balancer}

公開埠並使用可攜式 IP 位址，讓負載平衡器可以存取應用程式。使用公用 IP 位址，將應用程式設為可在網際網路上進行存取，或使用專用 IP 位址，將應用程式設為可在專用基礎架構網路上進行存取。

與 NodePort 服務不同，負載平衡器服務的可攜式 IP 位址不是取決於在其上已部署應用程式的工作者節點。不過，Kubernetes LoadBalancer 服務也是 NodePort 服務。LoadBalancer 服務可讓您的應用程式透過負載平衡器 IP 位址及埠提供使用，並讓您的應用程式可透過服務的節點埠提供使用。

負載平衡器的可攜式 IP 位址會自動進行指派，而且不會在您新增或移除工作者節點時變更。因此，負載平衡器服務的高可用性高於 NodePort 服務。使用者可以選取負載平衡器的任何埠，而不只限於 NodePort 埠範圍。您可以針對 TCP 及 UDP 通訊協定使用負載平衡器服務。

當「{{site.data.keyword.Bluemix_dedicated_notm}}」帳戶[啟用叢集功能](cs_ov.html#setup_dedicated)時，您可以要求將公用子網路用於負載平衡器 IP 位址。[開立支援問題單](/docs/support/index.html#contacting-support)建立子網路，然後使用 [`bx cs cluster-subnet-add`](cs_cli_reference.html#cs_cluster_subnet_add) 指令將子網路新增至叢集。

**附註：**負載平衡器服務不支援 TLS 終止。如果您的應用程式需要 TLS 終止，您可以使用 [Ingress](#cs_apps_public_ingress) 來公開應用程式，或配置應用程式來管理 TLS 終止。

開始之前：

-   只有標準叢集才能使用此特性。
-   您必須要有可指派給負載平衡器服務的可攜式公用或專用 IP 位址。
-   具有可攜式專用 IP 位址的負載平衡器服務仍然會在每個工作者節點上開啟一個公用節點埠。若要新增網路原則以防止公用資料流量，請參閱[封鎖送入的資料流量](cs_security.html#cs_block_ingress)。

若要建立負載平衡器服務，請執行下列動作：

1.  [將應用程式部署至叢集](#cs_apps_cli)。將應用程式部署至叢集時，會自動建立一個以上的 Pod，以在容器中執行您的應用程式。請確定您已將標籤新增至您部署中配置檔的 meta 資料區段。此標籤是識別您應用程式執行所在之所有 Pod 的必要項目，如此才能將 Pod 包含在負載平衡中。
2.  為您要公開的應用程式建立負載平衡器服務。若要讓您的應用程式可在公用網際網路或專用網路上使用，請建立應用程式的 Kubernetes 服務。請配置服務，以將所有構成應用程式的 Pod 包含在負載平衡中。
    1.  例如，建立名稱為 `myloadbalancer.yaml` 的服務配置檔。
    2.  為您要公開的應用程式定義負載平衡器服務。
        - 如果叢集是在公用 VLAN 上，則會使用可攜式公用 IP 位址。大部分叢集都在公用 VLAN 上。
        - 如果您的叢集只能在專用 VLAN 上使用，則會使用可攜式專用 IP 位址。
        - 您可以透過將註釋新增至配置檔，要求 LoadBalancer 服務的可攜式公用或專用 IP 位址。

        使用預設 IP 位址的 LoadBalancer 服務：

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

        使用註釋來指定專用或公用 IP 位址的 LoadBalancer 服務：

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <myservice>
          annotations: 
            service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private> 
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
        <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
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
        <tr>
          <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type:`
          <td>要指定 LoadBalancer 類型的註釋。值為 `private` 和 `public`。在公用 VLAN 的叢集中建立公用 LoadBalancer 時，不需要此註釋。
        </td>
        </tbody></table>
    3.  選用項目：若要為叢集可用的特定負載平衡器，使用特定的可攜式 IP 位址，可以將 `loadBalancerIP` 包含在 spec 區段，以指定該 IP 位址。如需相關資訊，請參閱 [Kubernetes 文件 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/concepts/services-networking/service/)。
    4.  選用項目：在 spec 區段中指定 `loadBalancerSourceRanges`，以配置防火牆。如需相關資訊，請參閱 [Kubernetes 文件 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/)。
    5.  在叢集中建立服務。

        ```
        kubectl apply -f myloadbalancer.yaml
        ```
        {: pre}

        若已建立負載平衡器服務，可攜式 IP 位址即會自動指派給負載平衡器。如果沒有可用的可攜式 IP 位址，則無法建立負載平衡器服務。
3.  驗證已順利建立負載平衡器服務。將 _&lt;myservice&gt;_ 取代為您在前一個步驟中建立之負載平衡器服務的名稱。

    ```
    kubectl describe service <myservice>
    ```
    {: pre}

    **附註：**這可能需要幾分鐘的時間，才能適當地建立負載平衡器服務，以及提供使用應用程式。

    CLI 輸出範例：

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

    **LoadBalancer Ingress** IP 位址是已指派給負載平衡器服務的可攜式 IP 位址。
4.  如果您已建立公用負載平衡器，請從網際網路存取您的應用程式。
    1.  開啟偏好的 Web 瀏覽器。
    2.  輸入負載平衡器的可攜式公用 IP 位址及埠。在上述範例中，`192.168.10.38` 可攜式公用 IP 位址已指派給負載平衡器服務。

        ```
        http://192.168.10.38:8080
        ```
        {: codeblock}




### 使用 Ingress 控制器來配置應用程式的存取
{: #cs_apps_public_ingress}

建立 IBM 提供的 Ingress 控制器所管理的 Ingress 資源，以公開叢集中的多個應用程式。Ingress 控制器是一個外部 HTTP 或 HTTPS 負載平衡器，使用安全且唯一的公用或專用進入點，將送入要求遞送至叢集內外部的應用程式。

**附註：**Ingress 僅適用於標準叢集，而且叢集中需要至少兩個工作者節點才能確保高可用性，並套用定期更新。設定 Ingress 需要[管理者存取原則](cs_cluster.html#access_ov)。請驗證您的現行[存取原則](cs_cluster.html#view_access)。

當您建立標準叢集時，系統會為您自動建立並啟用一個獲指派可攜式公用 IP 位址及公用路徑的 Ingress 控制器。也會自動建立（但不會自動啟用）一個獲指派可攜式專用 IP 位址及專用路徑的 Ingress 控制器。您可以配置這些 Ingress 控制器，並且為每個公開給大眾或專用網路使用的應用程式定義個別遞送規則。每個透過 Ingress 公開給大眾使用的應用程式都會獲指派附加至公用路徑的唯一路徑，因此，您可以使用唯一 URL 來公開存取叢集中的應用程式。

當「{{site.data.keyword.Bluemix_dedicated_notm}}」帳戶[啟用叢集功能](cs_ov.html#setup_dedicated)時，您可以要求將公用子網路用於 Ingress 控制器 IP 位址。然後，會建立 Ingress 控制器，並指派公用路徑。[開立支援問題單](/docs/support/index.html#contacting-support)建立子網路，然後使用 [`bx cs cluster-subnet-add`](cs_cli_reference.html#cs_cluster_subnet_add) 指令將子網路新增至叢集。

若要將應用程式公開給大眾使用，您可以針對下列情境配置公用 Ingress 控制器。

-   [使用沒有 TLS 終止的 IBM 提供的網域](#ibm_domain)
-   [使用具有 TLS 終止的 IBM 提供的網域](#ibm_domain_cert)
-   [使用自訂網域及 TLS 憑證來執行 TLS 終止](#custom_domain_cert)
-   [使用具有 TLS 終止的 IBM 提供的網域或自訂網域，來存取叢集外部的應用程式](#external_endpoint)
-   [開啟 Ingress 負載平衡器中的埠](#opening_ingress_ports)
-   [配置 HTTP 層次的 SSL 通訊協定及 SSL 密碼](#ssl_protocols_ciphers)
-   [使用註釋自訂 Ingress 控制器](cs_annotations.html)
{: #ingress_annotation}

若要將應用程式公開給專用網路使用，首先請[啟用專用 Ingress 控制器](#private_ingress)。然後，您可以針對下列情境配置專用 Ingress 控制器。

-   [使用沒有 TLS 終止的自訂網域](#private_ingress_no_tls)
-   [使用自訂網域及 TLS 憑證來執行 TLS 終止](#private_ingress_tls)

#### 使用沒有 TLS 終止的 IBM 提供的網域
{: #ibm_domain}

您可以將 Ingress 控制器配置為叢集中應用程式的 HTTP 負載平衡器，以及使用 IBM 提供的網域從網際網路存取應用程式。

開始之前：

-   如果您還沒有叢集，請[建立標準叢集](cs_cluster.html#cs_cluster_ui)。
-   [將 CLI 的目標設為](cs_cli_install.html#cs_cli_configure)叢集，才能執行 `kubectl` 指令。

若要配置 Ingress 控制器，請執行下列動作：

1.  [將應用程式部署至叢集](#cs_apps_cli)。將應用程式部署至叢集時，會自動建立一個以上的 Pod，以在容器中執行您的應用程式。請確定您已將標籤新增至您部署中配置檔的 meta 資料區段。此標籤是識別您應用程式執行所在之所有 Pod 的必要項目，如此才能將 Pod 包含在 Ingress 負載平衡中。
2.  為要公開的應用程式，建立 Kubernetes 服務。只有在您的應用程式是透過叢集內的 Kubernetes 服務公開時，Ingress 控制器才能將應用程式包含在 Ingress 負載平衡中。
    1.  例如，開啟偏好的編輯器，然後建立名為 `myservice.yaml` 的服務配置檔。
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
        <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
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
    1.  例如，開啟偏好的編輯器，然後建立名為 `myingress.yaml` 的 Ingress 配置檔。
    2.  在配置檔中定義 Ingress 資源，以使用 IBM 提供的網域將送入的網路資料流量遞送至您先前建立的服務。

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
        <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
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
        <strong>提示：</strong>如果您要配置與應用程式所接聽路徑不同的 Ingress 接聽路徑，則可以使用[重新編寫註釋](cs_annotations.html#rewrite-path)來建立應用程式的正確遞送。</td>
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

1.  [將應用程式部署至叢集](#cs_apps_cli)。請確定您已將標籤新增至您部署中配置檔的 meta 資料區段。此標籤會識別您應用程式執行所在的所有 Pod，如此才能將 Pod 包含在 Ingress 負載平衡中。
2.  為要公開的應用程式，建立 Kubernetes 服務。只有在您的應用程式是透過叢集內的 Kubernetes 服務公開時，Ingress 控制器才能將應用程式包含在 Ingress 負載平衡中。
    1.  例如，開啟偏好的編輯器，然後建立名為 `myservice.yaml` 的服務配置檔。
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
        <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
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
    1.  例如，開啟偏好的編輯器，然後建立名為 `myingress.yaml` 的 Ingress 配置檔。
    2.  在配置檔中定義 Ingress 資源，以使用 IBM 提供的網域將送入的網路資料流量遞送至服務，以及使用 IBM 提供的憑證來管理 TLS 終止。針對每個服務，您可以定義附加至 IBM 提供網域的個別路徑，以建立應用程式的唯一路徑，例如 `https://ingress_domain/myapp`。當您將此路徑輸入 Web 瀏覽器時，會將網路資料流量遞送至 Ingress 控制器。Ingress 控制器會查閱關聯的服務，然後將網路資料流量傳送至服務，並進一步傳送至執行應用程式的 Pod。

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
        <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
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
        <strong>提示：</strong>如果您要配置與應用程式所接聽路徑不同的 Ingress 接聽路徑，則可以使用[重新編寫註釋](cs_annotations.html#rewrite-path)來建立應用程式的正確遞送。</td>
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

#### 使用 Ingress 控制器與自訂網域及 TLS 憑證搭配
{: #custom_domain_cert}

您可以配置 Ingress 控制器，將送入網路資料流量遞送至叢集中的應用程式，以及使用您自己的 TLS 憑證來管理 TLS 終止，同時使用您的自訂網域而非 IBM 提供的網域。
{:shortdesc}

開始之前：

-   如果您還沒有叢集，請[建立標準叢集](cs_cluster.html#cs_cluster_ui)。
-   [將 CLI 的目標設為](cs_cli_install.html#cs_cli_configure)叢集，才能執行 `kubectl` 指令。

若要配置 Ingress 控制器，請執行下列動作：

1.  建立自訂網域。若要建立自訂網域，請與「網域名稱服務 (DNS)」提供者合作，登錄自訂網域。
2.  配置網域，以將送入的網路資料流量遞送至 IBM Ingress 控制器。可選擇的選項有：
    -   將 IBM 提供的網域指定為「標準名稱記錄 (CNAME)」，以定義自訂網域的別名。若要尋找 IBM 提供的 Ingress 網域，請執行 `bx cs cluster-get <mycluster>` 並尋找 **Ingress subdomain** 欄位。
    -   將自訂網域對映至 IBM 提供的 Ingress 控制器的可攜式公用 IP 位址，方法是將 IP 位址新增為記錄。若要尋找 Ingress 控制器的可攜式公用 IP 位址，請執行下列動作：
        1.  執行 `bx cs cluster-get <mycluster>` 並尋找 **Ingress subdomain** 欄位。
        2.  執行 `nslookup <Ingress subdomain>`。
3.  建立以 PEM 格式編碼的網域的 TLS 憑證及金鑰。
4.  將 TLS 憑證及金鑰儲存至 Kubernetes Secret 中。
    1.  例如，開啟偏好的編輯器，然後建立名為 `mysecret.yaml` 的 Kubernetes Secret 配置檔。
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
        <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
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

    3.  儲存配置檔。
    4.  建立叢集的 TLS Secret。

        ```
        kubectl apply -f mysecret.yaml
        ```
        {: pre}

5.  [將應用程式部署至叢集](#cs_apps_cli)。將應用程式部署至叢集時，會自動建立一個以上的 Pod，以在容器中執行您的應用程式。請確定您已將標籤新增至您部署中配置檔的 meta 資料區段。此標籤是識別您應用程式執行所在之所有 Pod 的必要項目，如此才能將 Pod 包含在 Ingress 負載平衡中。

6.  為要公開的應用程式，建立 Kubernetes 服務。只有在您的應用程式是透過叢集內的 Kubernetes 服務公開時，Ingress 控制器才能將應用程式包含在 Ingress 負載平衡中。

    1.  例如，開啟偏好的編輯器，然後建立名為 `myservice.yaml` 的服務配置檔。
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
        <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
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
    1.  例如，開啟偏好的編輯器，然後建立名為 `myingress.yaml` 的 Ingress 配置檔。
    2.  在配置檔中定義 Ingress 資源，以使用自訂網域將送入的網路資料流量遞送至服務，以及使用自訂憑證來管理 TLS 終止。針對每個服務，您可以定義附加至自訂網域的個別路徑，以建立應用程式的唯一路徑，例如 `https://mydomain/myapp`。當您將此路徑輸入 Web 瀏覽器時，會將網路資料流量遞送至 Ingress 控制器。Ingress 控制器會查閱關聯的服務，然後將網路資料流量傳送至服務，並進一步傳送至執行應用程式的 Pod。

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
        <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
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
        <strong>提示：</strong>如果您要配置與應用程式所接聽路徑不同的 Ingress 接聽路徑，則可以使用[重新編寫註釋](cs_annotations.html#rewrite-path)來建立應用程式的正確遞送。</td>
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
    1.  例如，開啟偏好的編輯器，然後建立名為 `myexternalendpoint.yaml` 的端點配置檔。
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
        <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
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
    1.  例如，開啟偏好的編輯器，然後建立名為 `myexternalservice.yaml` 的服務配置檔。
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
        <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
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
    1.  例如，開啟偏好的編輯器，然後建立名為 `myexternalingress.yaml` 的 Ingress 配置檔。
    2.  在配置檔中定義 Ingress 資源，以使用 IBM 提供的網域及 TLS 憑證將送入的網路資料流量遞送至外部應用程式，方法是使用您先前定義的外部端點。針對每個服務，您可以定義附加至 IBM 提供網域或自訂網域的個別路徑，以建立應用程式的唯一路徑，例如 `https://ingress_domain/myapp`。當您將此路徑輸入 Web 瀏覽器時，會將網路資料流量遞送至 Ingress 控制器。Ingress 控制器會查閱關聯的服務，然後將網路資料流量傳送至服務，並進一步傳送至外部應用程式。

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
        <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
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
        <strong>提示：</strong>如果您要配置與應用程式所接聽路徑不同的 Ingress 接聽路徑，則可以使用[重新編寫註釋](cs_annotations.html#rewrite-path)來建立應用程式的正確遞送。</td>
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



#### 開啟 Ingress 負載平衡器中的埠
{: #opening_ingress_ports}

依預設，Ingress 負載平衡器中只會公開埠 80 及 443。若要公開其他埠，您可以編輯 ibm-cloud-provider-ingress-cm 配置對映資源。

1.  為 ibm-cloud-provider-ingress-cm 配置對映資源建立配置檔的本端版本。新增 <code>data</code> 區段，並指定公用埠 80、443 以及您要新增至配置對映檔的任何其他埠，並以分號 (;) 區隔。

 附註：指定埠時，還必須包括 80 及 443，以讓那些埠保持開啟。任何未指定的埠都會關閉。

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

2. 套用配置檔。

 ```
 kubectl apply -f <path/to/configmap.yaml>
 ```
 {: pre}

3. 驗證已套用配置檔。

 ```
 kubectl describe cm ibm-cloud-provider-ingress-cm -n kube-system
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

  public-ports: "80;443;<port3>"
 ```
 {: codeblock}

如需配置對映資源的相關資訊，請參閱 [Kubernetes 文件](https://kubernetes-v1-4.github.io/docs/user-guide/configmap/)。



#### 配置 HTTP 層次的 SSL 通訊協定及 SSL 密碼
{: #ssl_protocols_ciphers}

藉由編輯 `ibm-cloud-provider-ingress-cm` 配置對映，在廣域 HTTP 層次啟用 SSL 通訊協定及密碼。

依預設，下列值用於 ssl-protocols 及 ssl-ciphers：

```
ssl-protocols : "TLSv1 TLSv1.1 TLSv1.2"
ssl-ciphers : "HIGH:!aNULL:!MD5"
```
{: codeblock}

如需這些參數的相關資訊，請參閱 NGINX 文件中的 [ssl-protocols ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](http://nginx.org/en/docs/http/ngx_http_ssl_module.html#ssl_protocols) 及 [ssl-ciphers ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](http://nginx.org/en/docs/http/ngx_http_ssl_module.html#ssl_ciphers)。

若要變更預設值，請執行下列動作：
1. 為 ibm-cloud-provider-ingress-cm 配置對映資源建立配置檔的本端版本。

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

2. 套用配置檔。

 ```
 kubectl apply -f <path/to/configmap.yaml>
 ```
 {: pre}

3. 驗證已套用配置檔。

 ```
 kubectl describe cm ibm-cloud-provider-ingress-cm -n kube-system
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

  ssl-protocols: "TLSv1 TLSv1.1 TLSv1.2"
  ssl-ciphers: "HIGH:!aNULL:!MD5"
 ```
 {: screen}


#### 啟用專用 Ingress 控制器
{: #private_ingress}

當您建立標準叢集時，系統會自動建立（但不會自動啟用）專用 Ingress 控制器。在可以使用專用 Ingress 控制器之前，您必須使用預先指派且由 IBM 提供的可攜式專用 IP 位址，或您自己的可攜式專用 IP 位址來啟用該控制器。**附註**：如果您在建立叢集時使用 `--no-subnet` 旗標，則必須先新增可攜式專用子網路或使用者管理的子網路，然後才能啟用專用 Ingress 控制器。如需相關資訊，請參閱[要求叢集的其他子網路](cs_cluster.html#add_subnet)。

開始之前：

-   如果您還沒有叢集，請[建立標準叢集](cs_cluster.html#cs_cluster_ui)。
-   [將 CLI 的目標設為](cs_cli_install.html#cs_cli_configure)您的叢集。

若要使用預先指派且由 IBM 提供的可攜式專用 IP 位址，來啟用專用 Ingress 控制器，請執行下列動作：

1. 列出叢集中可用的 Ingress 控制器，以取得專用 Ingress 控制器的 ALB ID。將 <em>&lt;cluser_name&gt;</em> 取代為您要公開之應用程式部署所在的叢集名稱。

    ```
    bx cs albs --cluster <my_cluster>
    ```
    {: pre}

    專用 Ingress 控制器的 **Status** 欄位是 _disabled_。
    ```
    ALB ID                                            Enabled   Status     Type      ALB IP
    private-cr6d779503319d419ea3b4ab171d12c3b8-alb1   false     disabled   private   -
    public-cr6d779503319d419ea3b4ab171d12c3b8-alb1    true      enabled    public    169.46.63.150
    ```
    {: screen}

2. 啟用專用 Ingress 控制器。將 <em>&lt;private_ALB_ID&gt;</em> 取代為專用 Ingress 控制器的 ALB ID（來自前一個步驟中的輸出）。

   ```
   bx cs bx cs alb-configure --albID <private_ALB_ID> --enable
   ```
   {: pre}


若要使用您自己的可攜式專用 IP 位址，來啟用專用 Ingress 控制器，請執行下列動作：

1. 配置所選擇 IP 位址之使用者管理的子網路，以遞送叢集之專用 VLAN 上的資料流量。將 <em>&lt;cluser_name&gt;</em> 取代為您要公開之應用程式部署所在的叢集名稱或 ID、將 <em>&lt;subnet_CIDR&gt;</em> 取代為使用者管理之子網路的 CIDR，並將 <em>&lt;private_VLAN&gt;</em> 取代為可用的專用 VLAN ID。您可以藉由執行 `bx cs vlsans`，來尋找可用的專用 VLAN ID。

   ```
   bx cs cluster-user-subnet-add <cluster_name> <subnet_CIDR> <private_VLAN>
   ```
   {: pre}

2. 列出叢集中可用的 Ingress 控制器，以取得專用 Ingress 控制器的 ALB ID。

    ```
    bx cs albs --cluster <my_cluster>
    ```
    {: pre}

    專用 Ingress 控制器的 **Status** 欄位是 _disabled_。
    ```
    ALB ID                                            Enabled   Status     Type      ALB IP
    private-cr6d779503319d419ea3b4ab171d12c3b8-alb1   false     disabled   private   -
    public-cr6d779503319d419ea3b4ab171d12c3b8-alb1    true      enabled    public    169.46.63.150
    ```
    {: screen}

3. 啟用專用 Ingress 控制器。將 <em>&lt;private_ALB_ID&gt;</em> 取代為專用 Ingress 控制器的 ALB ID（來自前一個步驟中的輸出），並將 <em>&lt;user_ip&gt;</em> 取代為您要使用的使用者管理之子網路的 IP 位址。

   ```
   bx cs bx cs alb-configure --albID <private_ALB_ID> --enable --user-ip <user_ip>
   ```
   {: pre}

#### 使用專用 Ingress 控制器與自訂網域搭配
{: #private_ingress_no_tls}

您可以配置專用 Ingress 控制器，以使用自訂網域，將送入的網路資料流量遞送至叢集中的應用程式。
{:shortdesc}

開始之前，請[啟用專用 Ingress 控制器](#private_ingress)。

若要配置專用 Ingress 控制器，請執行下列動作：

1.  建立自訂網域。若要建立自訂網域，請與「網域名稱服務 (DNS)」提供者合作，登錄自訂網域。

2.  將自訂網域對映至 IBM 提供的專用 Ingress 控制器的可攜式專用 IP 位址，方法是將 IP 位址新增為記錄。若要尋找專用 Ingress 控制器的可攜式專用 IP 位址，請執行 `bx cs albs --cluster <cluster_name>`。

3.  [將應用程式部署至叢集](#cs_apps_cli)。將應用程式部署至叢集時，會自動建立一個以上的 Pod，以在容器中執行您的應用程式。請確定您已將標籤新增至您部署中配置檔的 meta 資料區段。此標籤是識別您應用程式執行所在之所有 Pod 的必要項目，如此才能將 Pod 包含在 Ingress 負載平衡中。

4.  為要公開的應用程式，建立 Kubernetes 服務。只有在您的應用程式是透過叢集內的 Kubernetes 服務公開時，專用 Ingress 控制器才能將應用程式併入 Ingress 負載平衡。

    1.  例如，開啟偏好的編輯器，然後建立名為 `myservice.yaml` 的服務配置檔。
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
        <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
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

    5.  針對每個您要公開給專用網路使用的應用程式，重複這些步驟。
7.  建立 Ingress 資源。Ingress 資源定義您為應用程式所建立之 Kubernetes 服務的遞送規則，並且供 Ingress 控制器用來將送入網路資料流量遞送給服務。只要每個應用程式都是透過叢集內的 Kubernetes 服務公開時，您就可以使用一個 Ingress 資源來為多個應用程式定義遞送規則。
    1.  例如，開啟偏好的編輯器，然後建立名為 `myingress.yaml` 的 Ingress 配置檔。
    2.  在配置檔中定義 Ingress 資源，以使用自訂網域將送入的網路資料流量遞送至您的服務。針對每個服務，您可以定義附加至自訂網域的個別路徑，以建立應用程式的唯一路徑，例如 `https://mydomain/myapp`。當您將此路徑輸入 Web 瀏覽器時，會將網路資料流量遞送至 Ingress 控制器。Ingress 控制器會查閱關聯的服務，然後將網路資料流量傳送至服務，並進一步傳送至執行應用程式的 Pod。

        **附註：**應用程式必須接聽 Ingress 資源中所定義的路徑。否則，無法將網路資料流量轉遞至應用程式。大部分的應用程式不會接聽特定路徑，但使用根路徑及特定埠。在此情況下，請將根路徑定義為 `/`，並且不要為應用程式指定個別路徑。

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: <myingressname>
          annotations:
            ingress.bluemix.net/ALB-ID: "<private_ALB_ID>"
        spec:
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
        <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>將 <em>&lt;myingressname&gt;</em> 取代為 Ingress 資源的名稱。</td>
        </tr>
        <tr>
        <td><code>ingress.bluemix.net/ALB-ID</code></td>
        <td>將 <em>&lt;private_ALB_ID&gt;</em> 取代為專用 Ingress 控制器的 ALB ID。執行 <code>bx cs albs --cluster <my_cluster></code> 以尋找 ALB ID。</td>
        </tr>
        <td><code>host</code></td>
        <td>將 <em>&lt;mycustomdomain&gt;</em> 取代為自訂網域。

        </br></br>
        <strong>附註：</strong>請不要使用 &ast; 作為您的主機，也不要讓主機內容保留為空白，以避免建立 Ingress 期間發生失敗。</td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>將 <em>&lt;myservicepath1&gt;</em> 取代為斜線或應用程式所接聽的唯一路徑，以將網路資料流量轉遞至應用程式。

        </br>
        針對每個 Kubernetes 服務，您可以定義附加至自訂網域的個別路徑，以建立應用程式的唯一路徑，例如 <code>custom_domain/myservicepath1</code>。當您將此路徑輸入 Web 瀏覽器時，會將網路資料流量遞送至 Ingress 控制器。Ingress 控制器會查閱相關聯的服務，然後將網路資料流量傳送至服務，並使用相同路徑傳送至執行應用程式的 Pod。應用程式必須設定成接聽此路徑，以接收送入的網路資料流量。

        </br>
        許多應用程式不會接聽特定路徑，但卻使用根路徑及特定埠。在此情況下，請將根路徑定義為 <code>/</code>，並且不要為應用程式指定個別路徑。

        </br></br>
        範例：<ul><li>針對 <code>https://mycustomdomain/</code>，輸入 <code>/</code> 作為路徑。</li><li>針對 <code>https://mycustomdomain/myservicepath</code>，輸入 <code>/myservicepath</code> 作為路徑。</li></ul>
        <strong>提示：</strong>如果您要配置與應用程式所接聽路徑不同的 Ingress 接聽路徑，則可以使用[重新編寫註釋](cs_annotations.html#rewrite-path)來建立應用程式的正確遞送。</td>
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

8.  驗證已順利建立 Ingress 資源。將 <em>&lt;myingressname&gt;</em> 取代為您在前一個步驟中建立之 Ingress 資源的名稱。

    ```
    kubectl describe ingress <myingressname>
    ```
    {: pre}

    **附註：**這可能需要幾秒鐘的時間，才能適當地建立 Ingress 資源，以及將應用程式設為可用。

9.  從網際網路存取您的應用程式。
    1.  開啟偏好的 Web 瀏覽器。
    2.  輸入要存取的應用程式服務的 URL。

        ```
        http://<mycustomdomain>/<myservicepath1>
        ```
        {: codeblock}

#### 使用專用 Ingress 控制器與自訂網域及 TLS 憑證搭配
{: #private_ingress_tls}

您可以配置專用 Ingress 控制器，將送入的網路資料流量遞送至叢集中的應用程式，以及使用自己的 TLS 憑證來管理 TLS 終止，同時使用自訂網域。
{:shortdesc}

開始之前，請[啟用專用 Ingress 控制器](#private_ingress)。

若要配置 Ingress 控制器，請執行下列動作：

1.  建立自訂網域。若要建立自訂網域，請與「網域名稱服務 (DNS)」提供者合作，登錄自訂網域。

2.  將自訂網域對映至 IBM 提供的專用 Ingress 控制器的可攜式專用 IP 位址，方法是將 IP 位址新增為記錄。若要尋找專用 Ingress 控制器的可攜式專用 IP 位址，請執行 `bx cs albs --cluster <cluster_name>`。

3.  建立以 PEM 格式編碼的網域的 TLS 憑證及金鑰。

4.  將 TLS 憑證及金鑰儲存至 Kubernetes Secret 中。
    1.  例如，開啟偏好的編輯器，然後建立名為 `mysecret.yaml` 的 Kubernetes Secret 配置檔。
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
        <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
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

    3.  儲存配置檔。
    4.  建立叢集的 TLS Secret。

        ```
        kubectl apply -f mysecret.yaml
        ```
        {: pre}

5.  [將應用程式部署至叢集](#cs_apps_cli)。將應用程式部署至叢集時，會自動建立一個以上的 Pod，以在容器中執行您的應用程式。請確定您已將標籤新增至您部署中配置檔的 meta 資料區段。此標籤是識別您應用程式執行所在之所有 Pod 的必要項目，如此才能將 Pod 包含在 Ingress 負載平衡中。

6.  為要公開的應用程式，建立 Kubernetes 服務。只有在您的應用程式是透過叢集內的 Kubernetes 服務公開時，專用 Ingress 控制器才能將應用程式併入 Ingress 負載平衡。

    1.  例如，開啟偏好的編輯器，然後建立名為 `myservice.yaml` 的服務配置檔。
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
        <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
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

    5.  針對每個您要在專用網路上公開的應用程式，重複這些步驟。
7.  建立 Ingress 資源。Ingress 資源定義您為應用程式所建立之 Kubernetes 服務的遞送規則，並且供 Ingress 控制器用來將送入網路資料流量遞送給服務。只要每個應用程式都是透過叢集內的 Kubernetes 服務公開時，您就可以使用一個 Ingress 資源來為多個應用程式定義遞送規則。
    1.  例如，開啟偏好的編輯器，然後建立名為 `myingress.yaml` 的 Ingress 配置檔。
    2.  在配置檔中定義 Ingress 資源，以使用自訂網域將送入的網路資料流量遞送至服務，以及使用自訂憑證來管理 TLS 終止。針對每個服務，您可以定義附加至自訂網域的個別路徑，以建立應用程式的唯一路徑，例如 `https://mydomain/myapp`。當您將此路徑輸入 Web 瀏覽器時，會將網路資料流量遞送至 Ingress 控制器。Ingress 控制器會查閱關聯的服務，然後將網路資料流量傳送至服務，並進一步傳送至執行應用程式的 Pod。

        **附註：**應用程式必須接聽 Ingress 資源中所定義的路徑。否則，無法將網路資料流量轉遞至應用程式。大部分的應用程式不會接聽特定路徑，但使用根路徑及特定埠。在此情況下，請將根路徑定義為 `/`，並且不要為應用程式指定個別路徑。

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: <myingressname>
          annotations:
            ingress.bluemix.net/ALB-ID: "<private_ALB_ID>"
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
        <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>將 <em>&lt;myingressname&gt;</em> 取代為 Ingress 資源的名稱。</td>
        </tr>
        <tr>
        <td><code>ingress.bluemix.net/ALB-ID</code></td>
        <td>將 <em>&lt;private_ALB_ID&gt;</em> 取代為專用 Ingress 控制器的 ALB ID。執行 <code>bx cs albs --cluster <my_cluster></code> 以尋找 ALB ID。</td>
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
        <strong>提示：</strong>如果您要配置與應用程式所接聽路徑不同的 Ingress 接聽路徑，則可以使用[重新編寫註釋](cs_annotations.html#rewrite-path)來建立應用程式的正確遞送。</td>
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

8.  驗證已順利建立 Ingress 資源。將 <em>&lt;myingressname&gt;</em> 取代為您先前建立的 Ingress 資源的名稱。

    ```
    kubectl describe ingress <myingressname>
    ```
    {: pre}

    **附註：**這可能需要幾秒鐘的時間，才能適當地建立 Ingress 資源，以及將應用程式設為可用。

9.  從網際網路存取您的應用程式。
    1.  開啟偏好的 Web 瀏覽器。
    2.  輸入要存取的應用程式服務的 URL。

        ```
        https://<mycustomdomain>/<myservicepath1>
        ```
        {: codeblock}

## 管理 IP 位址及子網路
{: #cs_cluster_ip_subnet}

您可以使用可攜式公用及專用子網路及 IP 位址來公開叢集中的應用程式，並且將它們設為可從網際網路或在專用網路上進行存取。
{:shortdesc}

在 {{site.data.keyword.containershort_notm}} 中，您可以將網路子網路新增至叢集，為 Kubernetes 服務新增穩定的可攜式 IP。當您建立標準叢集時，{{site.data.keyword.containershort_notm}} 會自動佈建 1 個可攜式公用子網路（含 5 個可攜式公用 IP 位址）及 1 個可攜式專用子網路（含 5 個可攜式專用 IP 位址）。可攜式 IP 位址是靜態的，不會在移除工作者節點或甚至叢集時變更。

 兩個可攜式 IP 位址（一個公用、一個專用）會用於 [Ingress 控制器](#cs_apps_public_ingress)，您可以使用 Ingress 控制器，公開叢集中的多個應用程式。4 個可攜式公用和 4 個可攜式專用 IP 位址可用來藉由[建立負載平衡器服務](#cs_apps_public_load_balancer)來公開應用程式。

**附註：**可攜式公用 IP 位址是按月收費。如果您選擇在佈建叢集之後移除可攜式公用 IP 位址，則仍需要按月支付費用，即使您僅短時間使用。



1.  建立名為 `myservice.yaml` 的 Kubernetes 服務配置檔，並且使用虛擬負載平衡器 IP 位址來定義類型為 `LoadBalancer` 的服務。下列範例使用 IP 位址 1.1.1.1 作為負載平衡器 IP 位址。

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




1.  建立名為 `myservice.yaml` 的 Kubernetes 服務配置檔，並且使用虛擬負載平衡器 IP 位址來定義類型為 `LoadBalancer` 的服務。下列範例使用 IP 位址 1.1.1.1 作為負載平衡器 IP 位址。

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

### 釋放已使用的 IP 位址
{: #freeup_ip}

您可以刪除使用可攜式 IP 位址的負載平衡器服務，以釋放已使用的可攜式 IP 位址。

[開始之前，請為您要使用的叢集設定環境定義。](cs_cli_install.html#cs_cli_configure)

1.  列出叢集中可用的服務。

    ```
    kubectl get services
    ```
    {: pre}

2.  移除使用公用或專用 IP 位址的負載平衡器服務。

    ```
    kubectl delete service <myservice>
    ```
    {: pre}

<br />


## 使用 GUI 部署應用程式
{: #cs_apps_ui}

當您使用 Kubernetes 儀表板將應用程式部署至叢集時，會自動建立可建立、更新及管理叢集中 Pod 的部署資源。
{:shortdesc}

開始之前：

-   安裝必要的 [CLI](cs_cli_install.html#cs_cli_install)。
-   [將 CLI 的目標設為](cs_cli_install.html#cs_cli_configure)您的叢集。

若要部署應用程式，請執行下列動作：

1.  [開啟 Kubernetes 儀表板](#cs_cli_dashboard)。
2.  從 Kubernetes 儀表板中，按一下 **+ 建立**。
3.  選取**在下面指定應用程式詳細資料**以在 GUI 上輸入應用程式詳細資料，或選取**上傳 YAML 或 JSON 檔案**以上傳應用程式[配置檔 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-container/)。使用[此範例 YAML 檔案 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://github.com/IBM-Bluemix/kube-samples/blob/master/deploy-apps-clusters/deploy-ibmliberty.yaml)，以在美國南部地區從 **ibmliberty** 映像檔部署容器。
4.  在 Kubernetes 儀表板中，按一下**部署**，以驗證已建立部署。
5.  如果您使用節點埠服務讓應用程式可公開使用，負載平衡器服務（或 Ingress）會確認您可以存取此應用程式。

<br />


## 使用 CLI 部署應用程式
{: #cs_apps_cli}

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

2.  在叢集的環境定義中執行配置檔。

    ```
    kubectl apply -f deployment_script_location
    ```
    {: pre}

3.  如果您使用節點埠服務讓應用程式可公開使用，負載平衡器服務（或 Ingress）會確認您可以存取此應用程式。

<br />





## 調整應用程式
{: #cs_apps_scaling}

<!--Horizontal auto-scaling is not working at the moment due to a port issue with heapster. The dev team is working on a fix. We pulled out this content from the public docs. It is only visible in staging right now.-->

部署雲端應用程式，以回應應用程式要求的變更，並且只在需要時才使用資源。自動調整可根據 CPU 自動增加或減少應用程式的實例數。
{:shortdesc}

開始之前，請先將 [CLI 的目標](cs_cli_install.html#cs_cli_configure)設為您的叢集。

**附註：**您在尋找調整 Cloud Foundry 應用程式的相關資訊嗎？請查看 [IBM Auto-Scaling for {{site.data.keyword.Bluemix_notm}}](/docs/services/Auto-Scaling/index.html)。

使用 Kubernetes，您可以啟用 [Horizontal Pod Autoscaling ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/)，根據 CPU 來調整應用程式。

1.  從 CLI 將應用程式部署至叢集。當您部署應用程式時，必須要求 CPU。



    ```
    kubectl run <name> --image=<image> --requests=cpu=<cpu> --expose --port=<port_number>
    ```
    {: pre}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解此指令的元件</th>
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

    **附註：**若為更複雜的部署，您可能需要建立[配置檔](#cs_apps_cli)。
2.  建立 Horizontal Pod Autoscaler，並定義您的原則。如需使用 `kubetcl autoscale` 指令的相關資訊，請參閱 [Kubernetes 文件 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/user-guide/kubectl/v1.5/#autoscale)。

    ```
    kubectl autoscale deployment <deployment_name> --cpu-percent=<percentage> --min=<min_value> --max=<max_value>
    ```
    {: pre}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解此指令的元件</th>
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

<br />


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
    <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
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
8.  取得有關 Pod 的詳細資料，並尋找 Secret 名稱。

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

<br />


## 建立持續性儲存空間
{: #cs_apps_volume_claim}

建立持續性磁區宣告 (pvc)，以為叢集佈建 NFS 檔案儲存空間。然後，將此宣告裝載至 Pod，以確保即使 Pod 損毀或關閉，也能使用資料。
{:shortdesc}

IBM 已叢集化支援持續性磁區的 NFS 檔案儲存空間，可提供資料的高可用性。


當「{{site.data.keyword.Bluemix_dedicated_notm}}」帳戶[啟用叢集功能](cs_ov.html#setup_dedicated)時，您不是使用此作業，而是必須[開立支援問題單](/docs/support/index.html#contacting-support)。藉由開立問題單，您可以要求備份磁區、從磁區還原，以及其他儲存空間功能。


1.  檢閱可用的儲存空間類別。{{site.data.keyword.containerlong}} 提供八個預先定義的儲存空間類別，因此叢集管理者不需要建立任何儲存空間類別。`ibmc-file-bronze` 儲存空間類別與 `default` 儲存空間類別相同。

    ```
    kubectl get storageclasses
    ```
    {: pre}

    ```
    $ kubectl get storageclasses
    NAME                         TYPE
    default                      ibm.io/ibmc-file   
    ibmc-file-bronze (default)   ibm.io/ibmc-file   
    ibmc-file-custom             ibm.io/ibmc-file
    ibmc-file-gold               ibm.io/ibmc-file   
    ibmc-file-retain-bronze      ibm.io/ibmc-file   
    ibmc-file-retain-custom      ibm.io/ibmc-file   
    ibmc-file-retain-gold        ibm.io/ibmc-file   
    ibmc-file-retain-silver      ibm.io/ibmc-file   
    ibmc-file-silver             ibm.io/ibmc-file 
    ```
    {: screen}

2.  決定在刪除 pvc 之後，是否要儲存資料及 NFS 檔案共用。如果要保留資料，則請選擇 `retain` 儲存空間類別。如果您要在刪除 pvc 時刪除資料及檔案共用，請選擇儲存空間類別而不使用 `retain`。

3.  檢閱儲存空間類別的 IOPS 和可用的儲存空間大小。
    - 銅級、銀級和金級儲存空間類別使用 Endurance 儲存空間，每個類別各有一個定義的 IOPS per GB。IOPS 總計取決於儲存空間的大小。例如，每 GB 4 IOPS 的 1000Gi pvc 具有總計 4000 的 IOPS。

    ```
    kubectl describe storageclasses ibmc-file-silver
    ```
    {: pre}

    **parameters** 欄位提供每個與儲存空間類別相關聯的 GB 的 IOPS 以及可用大小（以 GB 為單位）。

    ```
    Parameters: iopsPerGB=4,sizeRange=20Gi,40Gi,80Gi,100Gi,250Gi,500Gi,1000Gi,2000Gi,4000Gi,8000Gi,12000Gi
    ```
    {: screen}

    - 自訂儲存空間類別使用 [Performance 儲存空間 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://knowledgelayer.softlayer.com/topic/performance-storage)，並且對總計 IOPS 和大小有不同的選項。

    ```
    kubectl describe storageclasses ibmc-file-retain-custom 
    ```
    {: pre}

    **parameters** 欄位提供每個與儲存空間類別相關聯的 IOPS 以及可用大小（以 GB 為單位）。例如，40Gi pvc 可以選取範圍 100 - 2000 IOPS 內，屬於 100 倍數的 IOPS。

    ```
    Parameters:	Note=IOPS value must be a multiple of 100,reclaimPolicy=Retain,sizeIOPSRange=20Gi:[100-1000],40Gi:[100-2000],80Gi:[100-4000],100Gi:[100-6000],1000Gi[100-6000],2000Gi:[200-6000],4000Gi:[300-6000],8000Gi:[500-6000],12000Gi:[1000-6000]
    ```
    {: screen}

4.  建立配置檔來定義持續性磁區宣告，以及將配置儲存為 `.yaml` 檔案。

    銅級、銀級、金級類別的範例：

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

    自訂類別的範例：

    ```
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: <pvc_name>
      annotations:
        volume.beta.kubernetes.io/storage-class: "ibmc-file-retain-custom"
    spec:
      accessModes:
        - ReadWriteMany
      resources:
        requests:
          storage: 40Gi
          iops: "500"
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
    </thead>
    <tbody>
    <tr>
    <td><code>metadata/name</code></td>
    <td>輸入持續性磁區宣告的名稱。</td>
    </tr>
    <tr>
    <td><code>metadata/annotations</code></td>
    <td>指定持續性磁區的儲存空間類別：
      <ul>
      <li>ibmc-file-bronze / ibmc-file-retain-bronze：每個 GB 有 2 個 IOPS。</li>
      <li>ibmc-file-silver / ibmc-file-retain-silver：每個 GB 有 4 個 IOPS。</li>
      <li>ibmc-file-gold / ibmc-file-retain-gold：每個 GB 有 10 個 IOPS。</li>
      <li>ibmc-file-custom / ibmc-file-retain-custom：可以使用 IOPS 的多個值。

    </li> 如果未指定任何儲存空間類別，則會建立具有 bronze（銅級）儲存空間類別的持續性磁區。</td>
    </tr>
    <tr>
    <td><code>spec/accessModes</code>
    <code>resources/requests/storage</code></td>
    <td> 如果您選擇的大小不是所列出的大小，則會將此大小四捨五入。如果您選取的大小大於最大大小，則會對此大小進行無條件捨去。</td>
    </tr>
    <tr>
    <td><code>spec/accessModes</code>
    <code>resources/requests/iops</code></td>
    <td>這個選項只適用於 ibmc-file-custom / ibmc-file-retain-custom。請指定儲存空間的總計 IOPS。執行 `kubectl describe storageclasses ibmc-file-custom` 以查看所有選項。如果您選擇的 IOPS 不是所列出的 IOPS，則會將 IOPS 無條件進位。</td>
    </tr>
    </tbody></table>

5.  建立持續性磁區宣告。

    ```
    kubectl apply -f <local_file_path>
    ```
    {: pre}

6.  驗證持續性磁區宣告已建立並連結至持續性磁區。此處理程序可能需要幾分鐘的時間。

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

6.  {: #cs_apps_volume_mount}若要將持續性磁區宣告裝載至 Pod，請建立配置檔。將配置儲存為 `.yaml` 檔案。

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
    <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 檔案元件</th>
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

8.  建立 Pod，並將持續性磁區宣告裝載至 Pod。

    ```
    kubectl apply -f <local_yaml_path>
    ```
    {: pre}

9.  驗證磁區已順利裝載至 Pod。

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

<br />


## 新增非 root 使用者對持續性儲存空間的存取權
{: #cs_apps_volumes_nonroot}

非 root 使用者對 NFS 支援的儲存空間的磁區裝載路徑沒有寫入權。若要授與寫入權，您必須編輯映像檔的 Dockerfile，以使用正確許可權在裝載路徑上建立目錄。
{:shortdesc}

開始之前，請先將 [CLI 的目標](cs_cli_install.html#cs_cli_configure)設為您的叢集。

如果您是使用需要磁區寫入權的非 root 使用者來設計應用程式，則必須將下列處理程序新增至 Dockerfile 及進入點 Script：

-   建立非 root 使用者。
-   暫時將使用者新增至 root 群組。
-   使用正確的使用者許可權在磁區裝載路徑中建立目錄。

對於 {{site.data.keyword.containershort_notm}}，磁區裝載路徑的預設擁有者是擁有者 `nobody`。使用 NFS 儲存空間，如果擁有者不存在於 Pod 本端，則會建立 `nobody` 使用者。磁區設定成辨識容器中的 root 使用者，對部分應用程式而言，這是容器內唯一的使用者。不過，許多應用程式會指定寫入至容器裝載路徑且不是 `nobody` 的非 root 使用者。部分應用程式指定磁區必須由 root 使用者擁有。由於安全考量，通常應用程式不會使用 root 使用者。不過，如果您的應用程式需要 root 使用者，您可以聯絡 [{{site.data.keyword.Bluemix_notm}} 支援中心](/docs/support/index.html#contacting-support)以取得協助。


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

6.  建立配置 `.yaml` 檔案，以建立持續性磁區宣告。此範例使用較低效能的儲存空間類別。請執行 `kubectl get storageclasses`，以查看可用的儲存空間類別。

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

8.  建立配置檔，以裝載磁區然後從 nonroot 映像檔中執行 Pod。磁區裝載路徑 `/mnt/myvol` 符合 Dockerfile 中所指定的裝載路徑。將配置儲存為 `.yaml` 檔案。

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
