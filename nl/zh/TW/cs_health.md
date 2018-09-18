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


# 記載及監視
{: #health}

在 {{site.data.keyword.containerlong}} 中設定記載及監視，以協助對問題進行疑難排解，以及改善 Kubernetes 叢集和應用程式的性能和效能。
{: shortdesc}

## 瞭解叢集和應用程式日誌轉遞
{: #logging}

持續監視及記載是偵測叢集上攻擊以及疑難排解它們所造成之問題的關鍵。持續監視叢集，即可更充分地瞭解叢集容量以及您應用程式可用的資源可用性。這容許您做相應的準備，以保護應用程式免於關閉。若要配置記載，您必須在 {{site.data.keyword.containershort_notm}} 中使用標準 Kubernetes 叢集。
{: shortdesc}


**IBM 是否會監視我的叢集？**
IBM 會持續監視每個 Kubernetes 主節點。{{site.data.keyword.containershort_notm}} 會自動掃描每個已部署 Kubernetes 主節點的節點，以尋找 Kubernetes 及 OS 特定安全修正程式中存在的漏洞。如果找到漏洞，{{site.data.keyword.containershort_notm}} 會自動套用修正程式，並代表使用者來解決漏洞以確保主節點保護。您負責監視及分析叢集其餘部分的日誌。

**我可以配置記載的來源為何？**

在下圖中，您可以看到可配置記載的來源位置。

![日誌來源](images/log_sources.png)

<ol>
<li><p><code>application</code>：在應用程式層次發生的事件的相關資訊。這可能是發生事件的通知（例如成功登入）、儲存的警告，或可在應用程式層次執行的其他作業。</p> <p>路徑：您可以設定將日誌轉遞至其中的路徑。不過，若要傳送日誌，您必須在記載配置中使用絕對路徑，否則無法讀取日誌。如果您的路徑已裝載至工作者節點，則可能已建立一個符號鏈結。範例：如果指定的路徑是 <code>/usr/local/<b>spark</b>/work/app-0546/0/stderr</code>，但實際上日誌是進到 <code>/usr/local/<b>spark-1.0-hadoop-1.2</b>/work/app-0546/0/stderr</code>，則無法讀取日誌。</p></li>

<li><p><code>container</code>：執行中容器所記載的資訊。</p> <p>路徑：所有寫入至 <code>STDOUT</code> 或 <code>STDERR</code> 的項目。</p></li>

<li><p><code>ingress</code>：透過「Ingress 應用程式負載平衡器」進入叢集之網路資料流量的相關資訊。如需特定配置資訊，請查看 [Ingress 文件](cs_ingress.html#ingress_log_format)。</p> <p>路徑：<code>/var/log/alb/ids/&ast;.log</code> <code>/var/log/alb/ids/&ast;.err</code>、<code>/var/log/alb/customerlogs/&ast;.log</code>、<code>/var/log/alb/customerlogs/&ast;.err</code></p></li>

<li><p><code>kube-audit</code>：傳送至 Kubernetes API 伺服器之叢集相關動作的相關資訊，包括時間、使用者及受影響資源。</p></li>

<li><p><code>kubernetes</code>：來自 kubelet、kube-proxy 以及在工作者節點中發生之其他 Kubernetes 事件的資訊。在 kube-system 名稱空間中執行。</p><p>路徑：<code>/var/log/kubelet.log</code>、<code>/var/log/kube-proxy.log</code>、<code>/var/log/event-exporter/*.log</code></p></li>

<li><p><code>worker</code>：您針對工作者節點所具有之基礎架構配置特有的資訊。工作者節點日誌會擷取至 syslog，並且包含作業系統事件。在 auth.log 中，您可以找到對 OS 提出的鑑別要求的資訊。</p><p>路徑：<code>/var/log/syslog</code> 及 <code>/var/log/auth.log</code></p></li>
</ol>

</br>

**我具有的配置選項有哪些？**

下表顯示在您配置記載及其說明時具有的不同選項。

<table>
<caption> 瞭解記載配置選項</caption>
  <thead>
    <th>選項</th>
    <th>說明</th>
  </thead>
  <tbody>
    <tr>
      <td><code><em>&lt;cluster_name_or_ID&gt;</em></code></td>
      <td>叢集的名稱或 ID。</td>
    </tr>
    <tr>
      <td><code><em>--log_source</em></code></td>
      <td>您要從中轉遞日誌的來源。接受值為 <code>container</code>、<code>application</code>、<code>worker</code>、<code>kubernetes</code>、<code>ingress</code> 及 <code>kube-audit</code>。</td>
    </tr>
    <tr>
      <td><code><em>--type</em></code></td>
      <td>您要轉遞日誌的位置。選項為 <code>ibm</code>，它會將日誌轉遞至 {{site.data.keyword.loganalysisshort_notm}}，還有 <code>syslog</code>，它會將日誌轉遞至外部伺服器。</td>
    </tr>
    <tr>
      <td><code><em>--namespace</em></code></td>
      <td>選用項目：您要從中轉遞日誌的 Kubernetes 名稱空間。<code>ibm-system</code> 及 <code>kube-system</code> Kubernetes 名稱空間不支援日誌轉遞。此值僅適用於 <code>container</code> 日誌來源。如果未指定名稱空間，則叢集裡的所有名稱空間都會使用此配置。</td>
    </tr>
    <tr>
      <td><code><em>--hostname</em></code></td>
      <td><p>對於 {{site.data.keyword.loganalysisshort_notm}}，請使用[汲取 URL](/docs/services/CloudLogAnalysis/log_ingestion.html#log_ingestion_urls)。如果您未指定汲取 URL，則會使用您在其中建立叢集之地區的端點。</p>
      <p>對於 syslog，請指定日誌收集器服務的主機名稱或 IP 位址。</p></td>
    </tr>
    <tr>
      <td><code><em>--port</em></code></td>
      <td>汲取埠。如果您未指定埠，則會使用標準埠 <code>9091</code>。<p>對於 syslog，請指定日誌收集器伺服器的埠。如果您未指定埠，則會使用標準埠 <code>514</code>。</td>
    </tr>
    <tr>
      <td><code><em>--space</em></code></td>
      <td>選用項目：您要將日誌傳送至其中的 Cloud Foundry 空間的名稱。將日誌轉遞至 {{site.data.keyword.loganalysisshort_notm}} 時，會在汲取點指定空間及組織。如果您未指定空間，則會將日誌傳送至帳戶層次。如果您已指定空間，則必須同時指定組織。</td>
    </tr>
    <tr>
      <td><code><em>--org</em></code></td>
      <td>選用項目：空間所在的 Cloud Foundry 組織的名稱。如果您已指定空間，則這是必要值。</td>
    </tr>
    <tr>
      <td><code><em>--app-containers</em></code></td>
      <td>選用項目：若要從應用程式中轉遞日誌，可以指定包含您應用程式之容器的名稱。您可以使用逗點區隔清單來指定多個容器。如果未指定任何容器，則會從包含您所提供路徑的所有容器轉遞日誌。</td>
    </tr>
    <tr>
      <td><code><em>--app-paths</em></code></td>
      <td>容器上應用程式記載至其中的路徑。若要使用來源類型 <code>application</code> 轉遞日誌，您必須提供路徑。若要指定多個路徑，請使用逗點區隔清單。範例：<code>/var/log/myApp1/&ast;,/var/log/myApp2/&ast;</code></td>
    </tr>
    <tr>
      <td><code><em>--syslog-protocol</em></code></td>
      <td>記載類型是 <code>syslog</code> 時，則為傳輸層通訊協定。您可以使用下列通訊協定：`udp`、`tls` 或 `tcp`。使用 <code>udp</code> 通訊協定轉遞至 rsyslog 伺服器時，會截斷超過 1KB 的日誌。</td>
    </tr>
    <tr>
      <td><code><em>--ca-cert</em></code></td>
      <td>必要：記載類型是 <code>syslog</code> 且通訊協定是 <code>tls</code> 時，則為包含「憑證管理中心憑證」的 Kubernetes 密碼名稱。</td>
    </tr>
    <tr>
      <td><code><em>--verify-mode</em></code></td>
      <td>記載類型是 <code>syslog</code> 且通訊協定是 <code>tls</code> 時，則為驗證模式。支援的值為 <code>verify-peer</code> 及預設 <code>verify-none</code>。</td>
    </tr>
    <tr>
      <td><code><em>--skip-validation</em></code></td>
      <td>選用項目：在指定組織及空間名稱時跳過其驗證。跳過驗證可減少處理時間，但是無效的記載配置不會正確轉遞日誌。</td>
    </tr>
  </tbody>
</table>

**我負責持續更新 Fluentd 以進行記載嗎？**

若要變更記載或過濾器配置，Fluentd 記載附加程式必須為最新版本。依預設，會啟用自動更新附加程式。若要停用自動更新，請參閱[更新叢集附加程式：Fluentd 以進行記載](cs_cluster_update.html#logging)。

<br />


## 配置日誌轉遞
{: #configuring}

您可以透過 GUI 或 CLI 來配置 {{site.data.keyword.containershort_notm}} 的記載。
{: shortdesc}

### 使用 GUI 啟用日誌轉遞
{: #enable-forwarding-ui}

您可以在 {{site.data.keyword.containershort_notm}} 儀表板中配置日誌轉遞。可能需要一些時間才能完成此處理程序，因此，如果您未立即看到日誌，請嘗試等待幾分鐘，然後再重新檢查。

若要建立帳戶層次的配置，針對特定容器名稱空間，或針對應用程式記載，請使用 CLI。
{: tip}

1. 導覽至儀表板的**概觀**標籤。
2. 選取您要從中轉遞日誌的 Cloud Foundry 組織及空間。在儀表板中配置日誌轉遞時，日誌會傳送至叢集的預設 {{site.data.keyword.loganalysisshort_notm}} 端點。若要將日誌轉遞至外部伺服器或另一個 {{site.data.keyword.loganalysisshort_notm}} 端點，您可以使用 CLI 來配置記載。
3. 選取您要從中轉遞日誌的日誌來源。
4. 按一下**建立**。

</br>
</br>

### 使用 CLI 啟用日誌轉遞
{: #enable-forwarding}

您可以建立一個配置進行叢集記載。您可以使用旗標來區分不同的記載選項。

**將日誌轉遞至 IBM**

1. 驗證許可權。如果您已在建立叢集或記載配置時指定空間，則帳戶擁有者及 {{site.data.keyword.containershort_notm}} API 金鑰擁有者都需要有該空間的「管理員」、「開發人員」或「審核員」[許可權](cs_users.html#access_policies)。
  * 如果您不知道 {{site.data.keyword.containershort_notm}} API 金鑰擁有者是誰，請執行下列指令。
      ```
      ibmcloud ks api-key-info <cluster_name>
      ```
      {: pre}
  * 若要立即套用您所做的全部變更，請執行下列指令。
      ```
      ibmcloud ks logging-config-refresh <cluster_name>
      ```
      {: pre}

2. 將 [CLI 的目標](cs_cli_install.html#cs_cli_configure)設為日誌來源所在的叢集。

  如果您使用「專用」帳戶，則必須登入公用 {{site.data.keyword.cloud_notm}} 端點，並將您的公用組織及空間設為目標，才能啟用日誌轉遞。
  {: tip}

3. 建立日誌轉遞配置。
    ```
    ibmcloud ks logging-config-create <cluster_name_or_ID> --logsource <log_source> --type ibm --namespace <kubernetes_namespace> --hostname <log_server_hostname_or_IP> --port <log_server_port> --space <cluster_space> --org <cluster_org> --app-containers <containers> --app-paths <paths_to_logs> --skip-validation
    ```
    {: pre}

  * default 名稱空間及輸出的範例容器記載配置：
    ```
    ibmcloud ks logging-config-create mycluster
    Creating cluster mycluster logging configurations...
    OK
    ID                                      Source      Namespace    Host                                 Port    Org  Space   Server Type   Protocol   Application Containers   Paths
    4e155cf0-f574-4bdb-a2bc-76af972cae47    container       *        ingest.logging.eu-gb.bluemix.net✣   9091✣    -     -        ibm           -                  -               -
    ✣ Indicates the default endpoint for the {{site.data.keyword.loganalysisshort_notm}} service.
    ```
    {: screen}

  * 範例應用程式記載配置及輸出：
    ```
    ibmcloud ks logging-config-create cluster2 --logsource application --app-paths '/var/log/apps.log' --app-containers 'container1,container2,container3'
    Creating logging configuration for application logs in cluster cluster2...
    OK
    Id                                     Source        Namespace   Host                                    Port    Org   Space   Server Type   Protocol   Application Containers               Paths
    aa2b415e-3158-48c9-94cf-f8b298a5ae39   application    -          ingest.logging.stage1.ng.bluemix.net✣  9091✣    -      -          ibm         -        container1,container2,container3      /var/log/apps.log
    ✣ Indicates the default endpoint for the {{site.data.keyword.loganalysisshort_notm}} service.
    ```
    {: screen}

如果在您的容器中執行的應用程式無法配置為將日誌寫入至 STDOUT 或 STDERR，則您可以建立一個記載配置，從應用程式日誌檔中轉遞日誌。
{: tip}

</br>
</br>


**透過 `udp` 或 `tcp` 通訊協定，將日誌轉遞至您自己的伺服器**

1. 若要將日誌轉遞至 syslog，請以下列兩種方式之一來設定接受 syslog 通訊協定的伺服器：
  * 設定並管理自己的伺服器，或讓提供者為您管理。如果提供者為您管理伺服器，請從記載提供者取得記載端點。

  * 從容器執行 syslog。例如，您可以使用此[部署 .yaml 檔案![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://github.com/IBM-Cloud/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml)，來提取在 Kubernet 叢集裡執行容器的 Docker 公用映像檔。映像檔會發佈公用叢集 IP 位址上的埠 `514`，並使用這個公用叢集 IP 位址來配置 syslog 主機。

  您可以移除 syslog 字首，以將日誌看成有效的 JSON。若要這樣做，請將下列程式碼新增至 rsyslog 伺服器執行所在之 <code>etc/rsyslog.conf</code> 檔案的頂端：<code>$template customFormat,"%msg%\n"</br>$ActionFileDefaultTemplate customFormat</code>
  {: tip}

2. 將 [CLI 的目標](cs_cli_install.html#cs_cli_configure)設為日誌來源所在的叢集。如果您使用「專用」帳戶，則必須登入公用 {{site.data.keyword.cloud_notm}} 端點，並將您的公用組織及空間設為目標，才能啟用日誌轉遞。
  

3. 建立日誌轉遞配置。
    ```
    ibmcloud ks logging-config-create <cluster_name_or_ID> --logsource <log_source> --namespace <kubernetes_namespace> --hostname <log_server_hostname_or_IP> --port <log_server_port> --type syslog --app-containers <containers> --app-paths <paths_to_logs> --syslog-protocol <protocol> --skip-validation
    ```
    {: pre}

</br>
</br>


**透過 `tls` 通訊協定，將日誌轉遞至您自己的伺服器**

下列步驟是一般指示。在正式作業環境中使用容器之前，請確定符合您需要的全部安全需求。
{: tip}

1. 以下列兩種方式之一來設定接受 syslog 通訊協定的伺服器：
  * 設定並管理自己的伺服器，或讓提供者為您管理。如果提供者為您管理伺服器，請從記載提供者取得記載端點。

  * 從容器執行 syslog。例如，您可以使用此[部署 .yaml 檔案![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://github.com/IBM-Cloud/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml)，來提取在 Kubernet 叢集裡執行容器的 Docker 公用映像檔。映像檔會發佈公用叢集 IP 位址上的埠 `514`，並使用這個公用叢集 IP 位址來配置 syslog 主機。您需要注入相關的「憑證管理中心」及伺服器端憑證，並更新 `syslog.conf` 來啟用伺服器上的 `tls`。

2. 將「憑證管理中心憑證」儲存至名為 `ca-cert` 的檔案。它必須是該確切名稱。

3. 在 `ca-cert` 檔案的 `kube-system` 名稱空間中，建立密碼。當您建立記載配置時，將使用密碼名稱作為 `--ca-cert` 旗標。
    ```
    kubectl -n kube-system create secret generic --from-file=ca-cert
    ```
    {: pre}

4. 將 [CLI 的目標](cs_cli_install.html#cs_cli_configure)設為日誌來源所在的叢集。如果您使用「專用」帳戶，則必須登入公用 {{site.data.keyword.cloud_notm}} 端點，並將您的公用組織及空間設為目標，才能啟用日誌轉遞。
  

3. 建立日誌轉遞配置。
    ```
    ibmcloud ks logging-config-create <cluster name or id> --logsource <log source> --type syslog --syslog-protocol tls --hostname <ip address of syslog server> --port <port for syslog server, 514 is default> --ca-cert <secret name> --verify-mode <defaults to verify-none>
    ```
    {: pre}

</br>
</br>


### 驗證日誌轉遞
{: verify-logging}

您可以使用下列兩種方式之一，驗證配置已正確設定：

* 若要列出叢集裡的所有記載配置，請執行下列指令：
    ```
    ibmcloud ks logging-config-get <cluster_name_or_ID>
    ```
    {: pre}

* 若要列出某種類型日誌來源的記載配置，請執行下列指令：
    ```
    ibmcloud ks logging-config-get <cluster_name_or_ID> --logsource <source>
    ```
    {: pre}

</br>
</br>

### 更新日誌轉遞
{: #updating-forwarding}

您可以更新已建立的記載配置。

1. 更新日誌轉遞配置。
    ```
    ibmcloud ks logging-config-update <cluster_name_or_ID> <log_config_id> --namespace <namespace> --type <server_type> --syslog-protocol <protocol> --logsource <source> --hostname <hostname_or_ingestion_URL> --port <port> --space <cluster_space> --org <cluster_org> --app-containers <containers> --app-paths <paths_to_logs>
    ```
    {: pre}

</br>
</br>

### 停止日誌轉遞
{: #log_sources_delete}

您可以停止轉遞叢集的某個或所有記載配置的日誌。
{: shortdesc}

1. 將 [CLI 的目標](cs_cli_install.html#cs_cli_configure)設為日誌來源所在的叢集。

2. 刪除記載配置。
  <ul>
  <li>若要刪除一個記載配置，請執行下列指令：</br>
    <pre><code>ibmcloud ks logging-config-rm &lt;cluster_name_or_ID&gt; --id &lt;log_config_ID&gt;</pre></code></li>
  <li>若要刪除所有記載配置，請執行下列指令：</br>
    <pre><code>ibmcloud ks logging-config-rm <my_cluster> --all</pre></code></li>
  </ul>

</br>
</br>

### 檢視日誌
{: #view_logs}

若要檢視叢集和容器的日誌，您可以使用標準 Kubernetes 及 Docker 記載特性。
{:shortdesc}

**{{site.data.keyword.loganalysislong_notm}}**
{: #view_logs_k8s}

您可以透過 Kibana 儀表板來檢視您轉遞至 {{site.data.keyword.loganalysislong_notm}} 的日誌。
{: shortdesc}

如果您已使用預設值來建立配置檔，則可以在建立該叢集的帳戶或組織和空間中找到您的日誌。如果您在配置檔中指定了組織及空間，則可以在該空間中找到您的日誌。如需記載的相關資訊，請參閱 [{{site.data.keyword.containershort_notm}} 的記載功能](/docs/services/CloudLogAnalysis/containers/containers_kubernetes.html#containers_kubernetes)。

若要存取 Kibana 儀表板，請移至下列其中一個 URL，然後選取您針對叢集配置日誌轉遞所在的 {{site.data.keyword.Bluemix_notm}} 帳戶或空間。
- 美國南部及美國東部：https://logging.ng.bluemix.net
- 英國南部：https://logging.eu-gb.bluemix.net
- 歐盟中部：https://logging.eu-fra.bluemix.net
- 亞太地區南部：https://logging.au-syd.bluemix.net

如需檢視日誌的相關資訊，請參閱[從 Web 瀏覽器導覽至 Kibana](/docs/services/CloudLogAnalysis/kibana/launch.html#launch_Kibana_from_browser)。

</br>

**Docker 日誌**

您可以運用內建 Docker 記載功能來檢閱標準 STDOUT 及 STDERR 輸出串流的活動。如需相關資訊，請參閱[檢視在 Kubernetes 叢集裡執行的容器的容器日誌](/docs/services/CloudLogAnalysis/containers/containers_kubernetes.html#containers_kubernetes)。

<br />


## 過濾日誌
{: #filter-logs}

您可以選擇要轉遞的日誌，方法為過濾掉某個時段的特定日誌。您可以使用旗標來區分不同的過濾選項。

<table>
<caption>瞭解日誌過濾的選項</caption>
  <thead>
    <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解日誌過濾選項</th>
  </thead>
  <tbody>
    <tr>
      <td>&lt;cluster_name_or_ID&gt;</td>
      <td>必要：您要過濾其日誌之叢集的名稱或 ID。</td>
    </tr>
    <tr>
      <td><code>&lt;log_type&gt;</code></td>
      <td>您要將過濾器套用至其中的日誌類型。目前支援 <code>all</code>、<code>container</code> 及 <code>host</code>。</td>
    </tr>
    <tr>
      <td><code>&lt;configs&gt;</code></td>
      <td>選用項目：以逗點區隔的記載配置 ID 清單。如果未提供，過濾器會套用至傳遞給過濾器的所有叢集記載配置。您可以使用 <code>--show-matching-configs</code> 選項，來檢視符合過濾器的日誌配置。</td>
    </tr>
    <tr>
      <td><code>&lt;kubernetes_namespace&gt;</code></td>
      <td>選用項目：您要從中轉遞日誌的 Kubernetes 名稱空間。只有在您使用日誌類型 <code>container</code> 時，此旗標才適用。</td>
    </tr>
    <tr>
      <td><code>&lt;container_name&gt;</code></td>
      <td>選用項目：您要從中過濾日誌的容器名稱。</td>
    </tr>
    <tr>
      <td><code>&lt;logging_level&gt;</code></td>
      <td>選用項目：過濾掉指定層次以下的日誌。可接受的值依其標準順序為 <code>fatal</code>、<code>error</code>、<code>warn/warning</code>、<code>info</code>、<code>debug</code> 及 <code>trace</code>。舉例來說，如果您過濾掉 <code>info</code> 層次的日誌，則也會過濾掉 <code>debug</code> 及 <code>trace</code>。**附註**：只有在日誌訊息是 JSON 格式且包含 level 欄位時，才能使用此旗標。若要以 JSON 顯示您的訊息，請將 <code>--json</code> 旗標附加至指令。</td>
    </tr>
    <tr>
      <td><code>&lt;message&gt;</code></td>
      <td>選用項目：過濾掉包含撰寫為正規表示式之指定訊息的日誌。</td>
    </tr>
    <tr>
      <td><code>&lt;filter_ID&gt;</code></td>
      <td>選用項目：日誌過濾器的 ID。</td>
    </tr>
    <tr>
      <td><code>--show-matching-configs</code></td>
      <td>選用項目：顯示每一個過濾器套用至其中的記載配置。</td>
    </tr>
    <tr>
      <td><code>--all</code></td>
      <td>選用項目：刪除所有日誌轉遞過濾器。</td>
    </tr>
  </tbody>
</table>


1. 建立記載過濾器。
  ```
  ibmcloud ks logging-filter-create <cluster_name_or_ID> --type <log_type> --logging-configs <configs> --namespace <kubernetes_namespace> --container <container_name> --level <logging_level> --regex-message <message>
  ```
  {: pre}

2. 檢視您已建立的日誌過濾器。

  ```
  ibmcloud ks logging-filter-get <cluster_name_or_ID> --id <filter_ID> --show-matching-configs
  ```
  {: pre}

3. 更新您已建立的日誌過濾器。
  ```
  ibmcloud ks logging-filter-update <cluster_name_or_ID> --id <filter_ID> --type <server_type> --logging-configs <configs> --namespace <kubernetes_namespace --container <container_name> --level <logging_level> --regex-message <message>
  ```
  {: pre}

4. 刪除您已建立的日誌過濾器。

  ```
  ibmcloud ks logging-filter-rm <cluster_name_or_ID> --id <filter_ID> [--all]
  ```
  {: pre}

<br />



## 針對 Kubernetes API 審核日誌配置日誌轉遞
{: #api_forward}

Kubernet 會自動審核透過您的 apiserver 所傳遞的全部事件。您可以將事件轉遞至 {{site.data.keyword.loganalysisshort_notm}} 或轉遞至外部伺服器。
{: shortdesc}


如需 Kubernetes 審核日誌的相關資訊，請參閱 Kubernetes 文件中的<a href="https://kubernetes.io/docs/tasks/debug-application-cluster/audit/" target="blank">審核主題 <img src="../icons/launch-glyph.svg" alt="外部鏈結圖示"></a>。

* 只有 Kubernetes 1.7 版以及更新版本才支援轉遞 Kubernetes API 審核日誌。
* 預設審核原則目前用於所有具有此記載配置的叢集。
* 目前不支援過濾器。
* 每個叢集只能有一個 `kube-audit` 配置，但是您可以建立記載配置及 Webhook，將日誌轉遞至 {{site.data.keyword.loganalysisshort_notm}} 和外部伺服器。
{: tip}


### 將審核日誌傳送至 {{site.data.keyword.loganalysisshort_notm}}
{: #audit_enable_loganalysis}

您可以將 Kubernetes API 伺服器審核日誌轉遞至 {{site.data.keyword.loganalysisshort_notm}}

**開始之前**

1. 驗證許可權。如果您在建立叢集或記載配置時指定一個空間，則帳戶擁有者及 {{site.data.keyword.containershort_notm}} 金鑰擁有者都需要有該空間的「管理員」、「開發人員」或「審核員」許可權。

2. 將 [CLI 的目標](cs_cli_install.html#cs_cli_configure)設為您要從該處收集 API 伺服器審核日誌的叢集。**附註**：如果您是使用「專用」帳戶，則必須登入公用 {{site.data.keyword.cloud_notm}} 端點，並將您的公用組織及空間設為目標，才能啟用日誌轉遞。

**轉遞日誌**

1. 建立記載配置。

    ```
    ibmcloud ks logging-config-create <cluster_name_or_ID> --logsource kube-audit --space <cluster_space> --org <cluster_org> --hostname <ingestion_URL> --type ibm
    ```
    {: pre}

    指令及輸出範例：

    ```
    ibmcloud ks logging-config-create myCluster --logsource kube-audit
    Creating logging configuration for kube-audit logs in cluster myCluster...
    OK
    Id                                     Source      Namespace   Host                                   Port     Org    Space   Server Type   Protocol  Application Containers   Paths
    14ca6a0c-5bc8-499a-b1bd-cedcf40ab850   kube-audit    -         ingest-au-syd.logging.bluemix.net✣    9091✣     -       -         ibm          -              -                  -

    ✣ Indicates the default endpoint for the {{site.data.keyword.loganalysisshort_notm}} service.

    ```
    {: screen}

    <table>
    <caption>瞭解這個指令的元件</caption>
      <thead>
        <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解這個指令的元件</th>
      </thead>
      <tbody>
        <tr>
          <td><code><em>&lt;cluster_name_or_ID&gt;</em></code></td>
          <td>叢集的名稱或 ID。</td>
        </tr>
        <tr>
          <td><code><em>&lt;ingestion_URL&gt;</em></code></td>
          <td>您要從中轉遞日誌的端點。如果您未指定[汲取 URL](/docs/services/CloudLogAnalysis/log_ingestion.html#log_ingestion_urls)，則會使用您在其中建立叢集之地區的端點。</td>
        </tr>
        <tr>
          <td><code><em>&lt;cluster_space&gt;</em></code></td>
          <td>選用項目：您要將日誌傳送至其中的 Cloud Foundry 空間的名稱。將日誌轉遞至 {{site.data.keyword.loganalysisshort_notm}} 時，會在汲取點指定空間及組織。如果您未指定空間，則會將日誌傳送至帳戶層次。</td>
        </tr>
        <tr>
          <td><code><em>&lt;cluster_org&gt;</em></code></td>
          <td>空間所在的 Cloud Foundry 組織的名稱。如果您已指定空間，則這是必要值。</td>
        </tr>
      </tbody>
    </table>

2. 檢視您的叢集記載配置，以驗證它是以您所需的方式實作。

    ```
    ibmcloud ks logging-config-get <cluster_name_or_ID>
    ```
    {: pre}

    指令及輸出範例：
    ```
    ibmcloud ks logging-config-get myCluster
    Retrieving cluster myCluster logging configurations...
    OK
    Id                                     Source        Namespace   Host                                 Port    Org   Space   Server Type  Protocol  Application Containers   Paths
    a550d2ba-6a02-4d4d-83ef-68f7a113325c   container     *           ingest-au-syd.logging.bluemix.net✣  9091✣   -     -         ibm           -          -              -
    14ca6a0c-5bc8-499a-b1bd-cedcf40ab850   kube-audit    -           ingest-au-syd.logging.bluemix.net✣  9091✣   -     -         ibm           -          -              -       
    ```
    {: screen}

3. 選用項目：如果您要停止轉遞審核日誌，則可以[刪除您的配置](#log_sources_delete)。

<br />



### 將審核日誌傳送至外部伺服器
{: #audit_enable}

**開始之前**

1. 在您可以轉遞日誌之處設定遠端記載伺服器。例如，您可以[使用 Logstash 搭配 Kubernetes ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/tasks/debug-application-cluster/audit/#use-logstash-to-collect-and-distribute-audit-events-from-webhook-backend) 以收集審核事件。

2. 將 [CLI 的目標](cs_cli_install.html#cs_cli_configure)設為您要從該處收集 API 伺服器審核日誌的叢集。**附註**：如果您是使用「專用」帳戶，則必須登入公用 {{site.data.keyword.cloud_notm}} 端點，並將您的公用組織及空間設為目標，才能啟用日誌轉遞。

若要轉遞 Kubernetes API 審核日誌，請執行下列動作：

1. 設定 Webhook。如果您未在旗標中提供任何資訊，則會使用預設配置。

    ```
    ibmcloud ks apiserver-config-set audit-webhook <cluster_name_or_ID> --remoteServer <server_URL_or_IP> --caCert <CA_cert_path> --clientCert <client_cert_path> --clientKey <client_key_path>
    ```
    {: pre}

  <table>
  <caption>瞭解這個指令的元件</caption>
    <thead>
      <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解這個指令的元件</th>
    </thead>
    <tbody>
      <tr>
        <td><code><em>&lt;cluster_name_or_ID&gt;</em></code></td>
        <td>叢集的名稱或 ID。</td>
      </tr>
      <tr>
        <td><code><em>&lt;server_URL&gt;</em></code></td>
        <td>您要將日誌傳送至其中的遠端記載服務的 URL 或 IP 位址。如果您提供不具安全保護的伺服器 URL，則會忽略憑證。</td>
      </tr>
      <tr>
        <td><code><em>&lt;CA_cert_path&gt;</em></code></td>
        <td>用來驗證遠端記載服務之 CA 憑證的檔案路徑。</td>
      </tr>
      <tr>
        <td><code><em>&lt;client_cert_path&gt;</em></code></td>
        <td>用來對遠端記載服務進行鑑別之用戶端憑證的檔案路徑。</td>
      </tr>
      <tr>
        <td><code><em>&lt;client_key_path&gt;</em></code></td>
        <td>用來連接至遠端記載服務之對應用戶端金鑰的檔案路徑。</td>
      </tr>
    </tbody>
  </table>

2. 藉由檢視遠端記載服務的 URL，來驗證已啟用日誌轉遞。

    ```
    ibmcloud ks apiserver-config-get audit-webhook <cluster_name_or_ID>
    ```
    {: pre}

    輸出範例：
    ```
    OK
    Server:			https://8.8.8.8
    ```
    {: screen}

3. 重新啟動 Kubernetes 主節點，以套用配置更新。

    ```
    ibmcloud ks apiserver-refresh <cluster_name_or_ID>
    ```
    {: pre}

4. 選用項目：如果您要停止轉遞審核日誌，則可以停用您的配置。
    1. 將 [CLI 的目標](cs_cli_install.html#cs_cli_configure)設為您要停止從該處收集 API 伺服器審核日誌的叢集。
    2. 停用叢集 API 伺服器的 Webhook 後端配置。

        ```
        ibmcloud ks apiserver-config-unset audit-webhook <cluster_name_or_ID>
        ```
        {: pre}

    3. 重新啟動 Kubernetes 主節點，以套用配置更新。

        ```
        ibmcloud ks apiserver-refresh <cluster_name_or_ID>
        ```
        {: pre}

## 檢視度量值
{: #view_metrics}

度量值可以協助您監視叢集的性能及效能。您可以使用標準 Kubernetes 及 Docker 特性，來監視叢集和應用程式的性能。**附註**：只有標準叢集支援監視。
{:shortdesc}

<dl>
  <dt>{{site.data.keyword.Bluemix_notm}} 中的叢集詳細資料頁面</dt>
    <dd>{{site.data.keyword.containershort_notm}} 提供叢集性能及容量以及叢集資源用量的相關資訊。您可以使用此 GUI 來橫向擴充叢集、使用持續性儲存空間，以及透過 {{site.data.keyword.Bluemix_notm}} 服務連結將更多功能新增至叢集。若要檢視叢集詳細資料頁面，請移至 **{{site.data.keyword.Bluemix_notm}} 儀表板**，然後選取一個叢集。</dd>
  <dt>Kubernetes 儀表板</dt>
    <dd>Kubernetes 儀表板是一種管理 Web 介面，您可以在此介面中檢閱工作者節點的性能、尋找 Kubernetes 資源、部署容器化應用程式，以及使用記載和監視資訊對應用程式進行疑難排解。如需如何存取 Kubernetes 儀表板的相關資訊，請參閱[啟動 {{site.data.keyword.containershort_notm}} 的 Kubernetes 儀表板](cs_app.html#cli_dashboard)。</dd>
  <dt>{{site.data.keyword.monitoringlong_notm}}</dt>
    <dd><p>標準叢集的度量值位於在建立 Kubernetes 叢集時所登入的 {{site.data.keyword.Bluemix_notm}} 帳戶。如果您在建立叢集時指定了 {{site.data.keyword.Bluemix_notm}} 空間，則度量值位於該空間中。會自動收集叢集裡所部署的所有容器的容器度量值。這些度量值會透過 Grafana 傳送並設為可供使用。如需度量值的相關資訊，請參閱 [{{site.data.keyword.containershort_notm}} 的監視功能](/docs/services/cloud-monitoring/containers/monitoring_containers_ov.html#monitoring_bmx_containers_ov)。</p>
    <p>若要存取 Grafana 儀表板，請移至下列其中一個 URL，然後選取您建立叢集所在的 {{site.data.keyword.Bluemix_notm}} 帳戶或空間。</p> <table summary="表格中的第一列跨越兩個直欄。其餘的列應該從左到右閱讀，第一欄為伺服器區域，第二欄則為要符合的 IP 位址。">
  <caption>針對監視資料流量開啟的 IP 位址</caption>
        <thead>
        <th>{{site.data.keyword.containershort_notm}} 地區</th>
        <th>監視位址</th>
        <th>監視 IP 位址</th>
        </thead>
      <tbody>
        <tr>
         <td>歐盟中部</td>
         <td>metrics.eu-de.bluemix.net</td>
         <td><code>158.177.65.80/30</code></td>
        </tr>
        <tr>
         <td>英國南部</td>
         <td>metrics.eu-gb.bluemix.net</td>
         <td><code>169.50.196.136/29</code></td>
        </tr>
        <tr>
          <td>美國東部、美國南部、亞太地區北部、亞太地區南部</td>
          <td>metrics.ng.bluemix.net</td>
          <td><code>169.47.204.128/29</code></td>
         </tr>
         
        </tbody>
      </table>
 </dd>
</dl>

### 其他性能監視工具
{: #health_tools}

您可以配置其他工具來取得更多的監視功能。
<dl>
  <dt>Prometheus</dt>
    <dd>Prometheus 是一個針對 Kubernetes 所設計的開放程式碼監視、記載及警示工具。此工具會根據 Kubernetes 記載資訊來擷取叢集、工作者節點及部署性能的詳細資訊。如需設定資訊，請參閱[整合服務與 {{site.data.keyword.containershort_notm}}](cs_integrations.html#integrations)。</dd>
</dl>

<br />


## 針對具有自動回復的工作者節點配置性能監視
{: #autorecovery}

{{site.data.keyword.containerlong_notm}} 的「自動回復」系統可以部署至 Kubernetes 1.7 版或更新版本的現有叢集。
{: shortdesc}

「自動回復」系統會使用各種檢查來查詢工作者節點性能狀態。如果「自動回復」根據配置的檢查，偵測到性能不佳的工作者節點，則「自動回復」會觸發更正動作，如在工作者節點上重新載入 OS。一次只有一個工作者節點進行一個更正動作。工作者節點必須先順利完成更正動作，然後任何其他工作者節點才能進行更正動作。如需相關資訊，請參閱此[自動回復部落格文章 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/blogs/bluemix/2017/12/autorecovery-utilizes-consistent-hashing-high-availability/)。
</br> </br>
**附註**：「自動回復」至少需要一個性能良好的節點，才能正常運作。只在具有兩個以上工作者節點的叢集中，配置具有主動檢查的「自動回復」。

開始之前，請先將 [CLI 的目標](cs_cli_install.html#cs_cli_configure)設為您要在其中檢查工作者節點狀態的叢集。

1. [安裝叢集的 Helm，並將 {{site.data.keyword.Bluemix_notm}} 儲存庫新增至 Helm 實例](cs_integrations.html#helm)。

2. 以 JSON 格式建立配置對映檔，以定義您的檢查。例如，下列 YAML 檔案定義三個檢查：一個 HTTP 檢查及兩個 Kubernetes API 伺服器檢查。如需三種檢查的相關資訊以及個別檢查元件的相關資訊，請參閱下列範例 YAML 檔案中的表格。
</br>
   **提示：**在配置對映的 `data` 區段中，將每一項檢查定義為唯一索引鍵。

   ```
   kind: ConfigMap
   apiVersion: v1
   metadata:
     name: ibm-worker-recovery-checks
     namespace: kube-system
   data:
     checknode.json: |
       {
         "Check":"KUBEAPI",
         "Resource":"NODE",
         "FailureThreshold":3,
         "CorrectiveAction":"RELOAD",
         "CooloffSeconds":1800,
         "IntervalSeconds":180,
         "TimeoutSeconds":10,
         "Enabled":true
       }
     checkpod.json: |
       {
         "Check":"KUBEAPI",
         "Resource":"POD",
         "PodFailureThresholdPercent":50,
         "FailureThreshold":3,
         "CorrectiveAction":"RELOAD",
         "CooloffSeconds":1800,
         "IntervalSeconds":180,
         "TimeoutSeconds":10,
         "Enabled":true
       }
     checkhttp.json: |
       {
         "Check":"HTTP",
         "FailureThreshold":3,
         "CorrectiveAction":"REBOOT",
         "CooloffSeconds":1800,
         "IntervalSeconds":180,
         "TimeoutSeconds":10,
         "Port":80,
         "ExpectedStatus":200,
         "Route":"/myhealth",
         "Enabled":false
       }
   ```
   {:codeblock}

   <table summary="瞭解 ConfigMap 的元件">
   <caption>瞭解 ConfigMap 元件</caption>
   <thead>
   <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 ConfigMap 元件</th>
   </thead>
   <tbody>
   <tr>
   <td><code>name</code></td>
   <td>配置名稱 <code>ibm-worker-recovery-checks- checks</code> 是一個常數，且無法變更。</td>
   </tr>
   <tr>
   <td><code>namespace</code></td>
   <td><code>kube-system</code> 名稱空間是一個常數，且無法變更。</td>
   </tr>
   <tr>
   <td><code>checknode.json</code></td>
   <td>定義 Kubernetes API 節點檢查，以檢查每個工作者節點是否處於 <code>Ready</code> 狀況。如果工作者節點不是處於 <code>Ready</code> 狀況，則特定工作者節點的檢查會計算為失敗。範例 YAML 中的檢查每 3 分鐘執行一次。如果它連續失敗三次，則會重新載入工作者節點。此動作相當於執行 <code>ibmcloud ks worker-reload</code>。<br></br>節點檢查會啟用，直到您將 <b>Enabled</b> 欄位設為 <code>false</code> 或移除檢查。</td>
   </tr>
   <tr>
   <td><code>checkpod.json</code></td>
   <td>
   定義 Kubernetes API Pod 檢查，它會根據指派給該工作者節點的 Pod 總數，檢查工作者節點上的 <code>NotReady</code> Pod 的百分比總計。如果 <code>NotReady</code> Pod 的百分比總計大於已定義的 <code>PodFailureThresholdPercent</code>，特定工作者節點的檢查會計算為失敗。範例 YAML 中的檢查每 3 分鐘執行一次。如果它連續失敗三次，則會重新載入工作者節點。此動作相當於執行 <code>ibmcloud ks worker-reload</code>。例如，預設 <code>PodFailureThresholdPercent</code> 為 50%。如果 <code>NotReady</code> Pod 的百分比連續三次大於 50%，則會重新載入工作者節點。<br></br>依預設，會檢查所有名稱空間中的 Pod。若要限制只檢查所指定名稱空間中的 Pod，請將 <code>Namespace</code> 欄位新增至檢查。Pod 檢查會啟用，直到您將 <b>Enabled</b> 欄位設為 <code>false</code> 或移除檢查。</td>
   </tr>
   <tr>
   <td><code>checkhttp.json</code></td>
   <td>定義 HTTP 檢查，檢查在工作者節點上執行的 HTTP 伺服器是否健全。若要使用此檢查，您必須在叢集裡的每個工作者節點上部署 HTTP 伺服器，方法為使用 [DaemonSet ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/)。您必須實作可在 <code>/myhealth</code> 路徑中使用的性能檢查，而且此檢查可驗證您的 HTTP 伺服器是否健全。您可以變更 <strong>Route</strong> 參數，來定義其他路徑。如果 HTTP 伺服器健全，則您必須傳回 <strong>ExpectedStatus</strong> 中所定義的 HTTP 回應碼。HTTP 伺服器必須配置為在工作者節點的專用 IP 位址上接聽。您可以執行 <code>kubectl get nodes</code> 找到專用 IP 位址。<br></br>
   例如，請考量叢集裡兩個具有專用 IP 位址 10.10.10.1 及 10.10.10.2 的節點。在此範例中，會檢查兩個路徑是否有 200 HTTP 回應：<code>http://10.10.10.1:80/myhealth</code> 和 <code>http://10.10.10.2:80/myhealth</code>。範例 YAML 中的檢查每 3 分鐘執行一次。如果它連續失敗三次，則會重新啟動工作者節點。此動作相當於執行 <code>ibmcloud ks worker-reboot</code>。<br></br>HTTP 檢查會停用，直到您將 <b>Enabled</b> 欄位設為 <code>true</code>。</td>
   </tr>
   </tbody>
   </table>

   <table summary="瞭解個別檢查元件">
   <caption>瞭解個別檢查元件</caption>
   <thead>
   <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解個別檢查元件</th>
   </thead>
   <tbody>
   <tr>
   <td><code>Check</code></td>
   <td>輸入您要「自動回復」使用的檢查類型。<ul><li><code>HTTP</code>：「自動回復」會呼叫每一個節點上執行的 HTTP 伺服器，以判斷節點是否適當地執行。</li><li><code>KUBEAPI</code>：「自動回復」會呼叫 Kubernetes API 伺服器，並讀取工作者節點所回報的性能狀態資料。</li></ul></td>
   </tr>
   <tr>
   <td><code>Resource</code></td>
   <td>當檢查類型為 <code>KUBEAPI</code> 時，請輸入您要「自動回復」檢查的資源類型。接受值為 <code>NODE</code> 或 <code>POD</code>。</td>
   </tr>
   <tr>
   <td><code>FailureThreshold</code></td>
   <td>輸入連續失敗檢查次數的臨界值。符合此臨界值時，「自動回復」會觸發指定的更正動作。例如，如果值為 3，且「自動回復」連續三次無法進行配置的檢查，則「自動回復」會觸發與該檢查相關聯的更正動作。</td>
   </tr>
   <tr>
   <td><code>PodFailureThresholdPercent</code></td>
   <td>資源類型為 <code>POD</code> 時，請輸入工作者節點上可以處於 [NotReady ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/#define-readiness-probes) 狀況之 Pod 的百分比臨界值。此百分比是以排定給工作者節點的 Pod 總數為基礎。當檢查判定性能不佳之 Pod 的百分比大於臨界值時，此檢查會將其算成一次失敗。</td>
   </tr>
   <tr>
   <td><code>CorrectiveAction</code></td>
   <td>輸入當符合失敗臨界值時要執行的動作。只有在未修復任何其他工作者，且此工作者節點不在前一個動作的冷卻期內時，才會執行更正動作。<ul><li><code>REBOOT</code>：重新啟動工作者節點。</li><li><code>RELOAD</code>：從全新的 OS 重新載入工作者節點的所有必要配置。</li></ul></td>
   </tr>
   <tr>
   <td><code>CooloffSeconds</code></td>
   <td>輸入「自動回復」必須等待幾秒，才能對已發出更正動作的節點發出另一個更正動作。散熱期間開始於發出更正動作時。</td>
   </tr>
   <tr>
   <td><code>IntervalSeconds</code></td>
   <td>輸入連續檢查之間的秒數。例如，如果值為 180，則「自動回復」每 3 分鐘會對每一個節點執行一次檢查。</td>
   </tr>
   <tr>
   <td><code>TimeoutSeconds</code></td>
   <td>輸入在「自動回復」終止呼叫作業之前，對資料庫進行檢查呼叫所花費的秒數上限。<code>TimeoutSeconds</code> 的值必須小於 <code>IntervalSeconds</code> 的值。</td>
   </tr>
   <tr>
   <td><code>Port</code></td>
   <td>檢查類型為 <code>HTTP</code> 時，請輸入工作者節點上 HTTP 伺服器必須連結的埠。此埠必須公開在叢集裡每個工作者節點的 IP 上。「自動回復」需要在所有節點之中固定不變的埠號，以檢查伺服器。當您將自訂伺服器部署至叢集時，請使用 [DaemonSets ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/)。</td>
   </tr>
   <tr>
   <td><code>ExpectedStatus</code></td>
   <td>檢查類型為 <code>HTTP</code> 時，請輸入您預期從檢查傳回的 HTTP 伺服器狀態。例如，值 200 指出您預期伺服器傳回 <code>OK</code> 回應。</td>
   </tr>
   <tr>
   <td><code>Route</code></td>
   <td>檢查類型為 <code>HTTP</code> 時，請輸入 HTTP 伺服器所要求的路徑。此值通常是在所有工作者節點上執行之伺服器的度量值路徑。</td>
   </tr>
   <tr>
   <td><code>Enabled</code></td>
   <td>輸入 <code>true</code> 以啟用檢查，或輸入 <code>false</code> 以停用檢查。</td>
   </tr>
   <tr>
   <td><code>Namespace</code></td>
   <td> 選用項目：若要限制 <code>checkpod.json</code> 只能檢查某個名稱空間中的 Pod，請新增 <code>Namespace</code> 欄位，並輸入名稱空間。</td>
   </tr>
   </tbody>
   </table>

3. 在叢集裡建立配置對映。

    ```
    kubectl apply -f ibm-worker-recovery-checks.yaml
    ```
    {: pre}

3. 使用適當的檢查，驗證您已在 `kube-system` 名稱空間中建立名稱為 `ibm-worker-recovery-checks` 的配置對映。

    ```
    kubectl -n kube-system get cm ibm-worker-recovery-checks -o yaml
    ```
    {: pre}

4. 安裝 `ibm-worker-recovery` Helm 圖表，以將「自動回復」部署至叢集。

    ```
    helm install --name ibm-worker-recovery ibm/ibm-worker-recovery  --namespace kube-system
    ```
    {: pre}

5. 幾分鐘之後，您可以檢查下列指令輸出中的 `Events` 區段，以查看「自動回復」部署上的活動。

    ```
    kubectl -n kube-system describe deployment ibm-worker-recovery
    ```
    {: pre}

6. 如果您在「自動回復」部署上沒有看到活動，則可以執行「自動回復」圖表定義中包括的測試來檢查 Helm 部署。

    ```
    helm test ibm-worker-recovery
    ```
    {: pre}
