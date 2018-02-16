---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-12"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# 設定 NodePort 服務
{: #nodeport}

使用叢集中任何工作者節點的公用 IP 位址，並公開節點埠，將應用程式設為可在網際網路上進行存取。請使用此選項來進行測試及短期公用存取。
{:shortdesc}

## 使用 NodePort 服務類型來配置應用程式的公用存取
{: #config}

對於精簡或標準叢集，您可以將應用程式公開為 Kubernetes NodePort 服務。
{:shortdesc}

**附註：**工作者節點的公用 IP 位址不是永久性的。如果必須重建工作者節點，則會將新的公用 IP 位址指派給工作者節點。如果您需要服務的穩定公用 IP 位址及更高可用性，請使用 [LoadBalancer 服務](cs_loadbalancer.html)或 [Ingress](cs_ingress.html) 來公開應用程式。

如果您還沒有應用程式，您可以使用稱為 [Guestbook ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://github.com/kubernetes/kubernetes/blob/master/examples/guestbook/all-in-one/guestbook-all-in-one.yaml) 的 Kubernetes 範例應用程式。

1.  在您應用程式的配置檔中，定義 [service ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/concepts/services-networking/service/) 區段。

    範例：

    ```
    apiVersion: v1
    kind: Service
    metadata:
      name: <my-nodeport-service>
      labels:
        run: <my-demo>
    spec:
      selector:
        run: <my-demo>
      type: NodePort
      ports:
       - port: <8081>
         # nodePort: <31514>

    ```
    {: codeblock}

    <table>
    <caption>瞭解此 YAML 檔案的元件</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 NodePort 服務區段元件</th>
    </thead>
    <tbody>
    <tr>
    <td><code>name</code></td>
    <td>將 <code><em>&lt;my-nodeport-service&gt;</em></code> 取代為 NodePort 服務的名稱。</td>
    </tr>
    <tr>
    <td><code>run</code></td>
    <td>將 <code><em>&lt;my-demo&gt;</em></code> 取代為您部署的名稱。</td>
    </tr>
    <tr>
    <td><code>port</code></td>
    <td>將 <code><em>&lt;8081&gt;</em></code> 取代為服務所接聽的埠。</td>
     </tr>
     <tr>
     <td><code>nodePort</code></td>
     <td>選用項目：將 <code><em>&lt;31514&gt;</em></code> 取代為 30000 到 32767 範圍內的 NodePort。請不要指定另一個服務已在使用中的 NodePort。如果未指派 NodePort，則會自動指派一個隨機 NodePort。<br><br>如果您要指定 NodePort，並且要查看哪些 NodePort 已在使用中，則可以執行下列指令：<pre class="pre"><code>kubectl get svc</code></pre>使用中的任何 NodePort 會出現在**埠**欄位下。</td>
     </tr>
     </tbody></table>


    對於 Guestbook 範例，在配置檔中已有前端服務區段存在。若要讓 Guestbook 應用程式可在外部使用，請新增 NodePort 類型及範圍 30000 - 32767 內的 NodePort 至前端服務區段。

    ```
    apiVersion: v1
    kind: Service
    metadata:
      name: frontend
      labels:
        app: guestbook
        tier: frontend
    spec:
      type: NodePort
      ports:
      - port: 80
        nodePort: 31513
      selector:
        app: guestbook
        tier: frontend
    ```
    {: codeblock}

2.  儲存已更新的配置檔。

3.  針對每個您要公開給網際網路使用的應用程式，重複這些步驟以建立 NodePort 服務。

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
