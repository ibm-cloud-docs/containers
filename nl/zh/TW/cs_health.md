---

copyright:
  years: 2014, 2018
lastupdated: "2018-02-02"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# 記載及監視叢集
{: #health}

配置叢集記載及監視，以協助您疑難排解叢集和應用程式的問題，以及監視叢集的性能與效能。
{:shortdesc}

## 配置叢集記載
{: #logging}

您可以將日誌傳送至用來處理或長期儲存的特定位置。在 {{site.data.keyword.containershort_notm}} 的 Kubernetes 叢集上，您可以針對叢集啟用日誌轉遞，並選擇日誌的轉遞位置。**附註**：只有標準叢集支援日誌轉遞。
{:shortdesc}

您可以轉遞日誌來源（例如容器、應用程式、工作者節點、Kubernetes 叢集及 Ingress 控制器）的日誌。如需每一個日誌來源的相關資訊，請檢閱下表。

|日誌來源|特徵|日誌路徑|
|----------|---------------|-----|
|`容器`|在 Kubernetes 叢集中執行之容器的日誌。|-|
|`application`|在 Kubernetes 叢集中執行之自己的應用程式的日誌。|`/var/log/apps/**/*.log`、`/var/log/apps/**/*.err`|
|`worker`|Kubernetes 叢集內虛擬機器工作者節點的日誌。|`/var/log/syslog`、`/var/log/auth.log`|
|`kubernetes`|Kubernetes 系統元件的日誌。|`/var/log/kubelet.log`、`/var/log/kube-proxy.log`|
|`ingress`|管理進入 Kubernetes 叢集之網路資料流量之 Ingress 應用程式負載平衡器的日誌。|`/var/log/alb/ids/*.log`、`/var/log/alb/ids/*.err`、`/var/log/alb/customerlogs/*.log`、`/var/log/alb/customerlogs/*.err`|
{: caption="日誌來源特徵" caption-side="top"}

## 啟用日誌轉遞
{: #log_sources_enable}

您可以將日誌轉遞至 {{site.data.keyword.loganalysislong_notm}} 或轉遞至外部 syslog 伺服器。如果您要將某個日誌來源中的日誌轉遞至這兩個日誌收集器伺服器，則必須建立兩個記載配置。
**附註**：若要轉遞應用程式的日誌，請參閱[啟用應用程式的日誌轉遞](#apps_enable)。
{:shortdesc}

開始之前：

1. 如果您要將日誌轉遞至外部 syslog 伺服器，可以使用下列兩種方式來設定接受 syslog 通訊協定的伺服器：
  * 設定並管理自己的伺服器，或讓提供者為您管理。如果提供者為您管理伺服器，請從記載提供者取得記載端點。
  * 從容器執行 syslog。例如，您可以使用此[部署 .yaml 檔案![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://github.com/IBM-Bluemix/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml)，來提取在 Kubernet 叢集中執行容器的 Docker 公用映像檔。映像檔會發佈公用叢集 IP 位址上的埠 `514`，並使用這個公用叢集 IP 位址來配置 syslog 主機。

2. 將 [CLI 的目標](cs_cli_install.html#cs_cli_configure)設為日誌來源所在的叢集。

若要啟用容器、工作者節點、Kubernetes 系統元件、應用程式或 Ingress 應用程式負載平衡器的日誌轉遞，請執行下列動作：

1. 建立日誌轉遞配置。

  * 若要將日誌轉遞至 {{site.data.keyword.loganalysislong_notm}}，請執行下列指令：

    ```
    bx cs logging-config-create <my_cluster> --logsource <my_log_source> --namespace <kubernetes_namespace> --hostname <ingestion_URL> --port <ingestion_port> --space <cluster_space> --org <cluster_org> --type ibm
    ```
    {: pre}

    <table>
    <caption>瞭解此指令的元件</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解此指令的元件</th>
    </thead>
    <tbody>
    <tr>
    <td><code>logging-config-create</code></td>
    <td>建立 {{site.data.keyword.loganalysislong_notm}} 日誌轉遞配置的指令。</td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td>將 <em>&lt;my_cluster&gt;</em> 取代為叢集的名稱或 ID。</td>
    </tr>
    <tr>
    <td><code>--logsource <em>&lt;my_log_source&gt;</em></code></td>
    <td>將 <em>&lt;my_log_source&gt;</em> 取代為日誌來源。接受值為 <code>container</code>、<code>application</code>、<code>worker</code>、<code>kubernetes</code> 及 <code>ingress</code>。</td>
    </tr>
    <tr>
    <td><code><em>&lt;kubernetes_namespace&gt;</em></code></td>
    <td>將 <em>&lt;kubernetes_namespace&gt;</em> 取代為您要從該處轉遞日誌的 Kubernetes 名稱空間。<code>ibm-system</code> 及 <code>kube-system</code> Kubernetes 名稱空間不支援日誌轉遞。此值僅對容器日誌來源有效且為選用。如果未指定名稱空間，則叢集中的所有名稱空間都會使用此配置。</td>
    </tr>
    <tr>
    <td><code>--hostname <em>&lt;ingestion_URL&gt;</em></code></td>
    <td>將 <em>&lt;ingestion_URL&gt;</em> 取代為 {{site.data.keyword.loganalysisshort_notm}} 汲取 URL。您可以在[這裡](/docs/services/CloudLogAnalysis/log_ingestion.html#log_ingestion_urls)尋找可用的汲取 URL 清單。如果您未指定汲取 URL，則會使用您在其中建立叢集之地區的端點。</td>
    </tr>
    <tr>
    <td><code>--port <em>&lt;ingestion_port&gt;</em></code></td>
    <td>將 <em>&lt;ingestion_port&gt;</em> 取代為汲取埠。如果您未指定埠，則會使用標準埠 <code>9091</code>。</td>
    </tr>
    <tr>
    <td><code>--space <em>&lt;cluster_space&gt;</em></code></td>
    <td>將 <em>&lt;cluster_space&gt;</em> 取代為您要將日誌傳送至其中的 Cloud Foundry 空間的名稱。如果您未指定空間，則會將日誌傳送至帳戶層次。</td>
    </tr>
    <tr>
    <td><code>--org <em>&lt;cluster_org&gt;</em></code></td>
    <td>將 <em>&lt;cluster_org&gt;</em> 取代為空間所在的 Cloud Foundry 組織的名稱。如果您已指定空間，則這是必要值。</td>
    </tr>
    <tr>
    <td><code>--type ibm</code></td>
    <td>將日誌傳送至 {{site.data.keyword.loganalysisshort_notm}} 的日誌類型。</td>
    </tr>
    </tbody></table>

  * 若要將日誌轉遞至外部 syslog 伺服器，請執行下列指令：

    ```
    bx cs logging-config-create <my_cluster> --logsource <my_log_source> --namespace <kubernetes_namespace> --hostname <log_server_hostname_or_IP> --port <log_server_port> --type syslog
    ```
    {: pre}

    <table>
    <caption>瞭解此指令的元件</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解此指令的元件</th>
    </thead>
    <tbody>
    <tr>
    <td><code>logging-config-create</code></td>
    <td>建立 syslog 日誌轉遞配置的指令。</td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td>將 <em>&lt;my_cluster&gt;</em> 取代為叢集的名稱或 ID。</td>
    </tr>
    <tr>
    <td><code>--logsource <em>&lt;my_log_source&gt;</em></code></td>
    <td>將 <em>&lt;my_log_source&gt;</em> 取代為日誌來源。接受值為 <code>container</code>、<code>application</code>、<code>worker</code>、<code>kubernetes</code> 及 <code>ingress</code>。</td>
    </tr>
    <tr>
    <td><code><em>&lt;kubernetes_namespace&gt;</em></code></td>
    <td>將 <em>&lt;kubernetes_namespace&gt;</em> 取代為您要從該處轉遞日誌的 Kubernetes 名稱空間。<code>ibm-system</code> 及 <code>kube-system</code> Kubernetes 名稱空間不支援日誌轉遞。此值僅對容器日誌來源有效且為選用。如果未指定名稱空間，則叢集中的所有名稱空間都會使用此配置。</td>
    </tr>
    <tr>
    <td><code>--hostname <em>&lt;log_server_hostname_or_IP&gt;</em></code></td>
    <td>將 <em>&lt;log_server_hostname&gt;</em> 取代為日誌收集器服務的主機名稱或 IP 位址。</td>
    </tr>
    <tr>
    <td><code>--port <em>&lt;log_server_port&gt;</em></code></td>
    <td>將 <em>&lt;log_server_port&gt;</em> 取代為日誌收集器伺服器的埠。如果您未指定埠，則會使用標準埠 <code>514</code>。</td>
    </tr>
    <tr>
    <td><code>--type syslog</code></td>
    <td>將日誌傳送至外部 syslog 伺服器的日誌類型。</td>
    </tr>
    </tbody></table>

2. 驗證已建立日誌轉遞配置。

    * 若要列出叢集中的所有記載配置，請執行下列指令：
      ```
      bx cs logging-config-get <my_cluster>
      ```
      {: pre}

      輸出範例：

      ```
      Id                                    Source       Namespace     Host                          Port   Org      Space      Protocol     Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  kubernetes   -             172.30.162.138                5514   -        -          syslog       /var/log/kubelet.log,/var/log/kube-proxy.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  application  -             ingest.logging.ng.bluemix.net 9091   my_org   my_space   ibm          /var/log/apps/**/*.log,/var/log/apps/**/*.err
      8a284f1a-451c-4c48-b1b4-a4e6b977264e  containers   my-namespace  myhostname.common             5514   -        -          syslog       -
      ```
      {: screen}

    * 若要列出某種類型日誌來源的記載配置，請執行下列指令：
      ```
      bx cs logging-config-get <my_cluster> --logsource worker
      ```
      {: pre}

      輸出範例：

      ```
      Id                                    Source    Namespace   Host                            Port   Org    Space     Protocol    Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  worker    -           ingest.logging.ng.bluemix.net   9091   -      -         ibm         /var/log/syslog,/var/log/auth.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  worker    -           172.30.162.138                  5514   -      -         syslog      /var/log/syslog,/var/log/auth.log
      ```
      {: screen}


### 啟用應用程式的日誌轉遞
{: #apps_enable}

來自應用程式的日誌必須限制為主機節點上的特定目錄。您可以使用裝載路徑，將主機路徑磁區裝載至您的容器，來執行此動作。此裝載路徑可充當容器上應用程式日誌傳送至其中的目錄。建立磁區裝載時，會自動建立預先定義的主機路徑目錄 (`/var/log/apps`)。

請檢閱應用程式日誌轉遞的下列各層面：
* 從 /var/log/apps 路徑遞迴地讀取日誌。這表示可以將應用程式日誌放入 /var/log/apps 路徑的子目錄中。
* 只會轉遞副檔名為 `.log` 或 `.err` 的應用程式日誌檔。
* 第一次啟用日誌轉遞時，應用程式日誌會加在後面，而不是從頭讀取。這表示在啟用應用程式記載之前，已存在之所有日誌的內容都不會被讀取。日誌是從啟用記載的時間點開始讀取。不過，在第一次啟用日誌轉遞之後，一律會從前次離開的位置來挑選日誌。
* 當您將 `/var/log/apps` 主機路徑磁區裝載至容器時，容器全都會寫入至這個相同的目錄。這表示如果您的容器寫入至相同的檔名，則容器會寫入至主機上完全相同的檔案。如果這不是您的本意，您可以使用不同方式命名來自每一個容器的日誌檔，以防止容器改寫相同的日誌檔。
* 因為所有容器都會寫入至相同的檔名，所以請不要使用此方法來轉遞 ReplicaSets 的應用程式日誌。反之，您可以將應用程式中的日誌寫入至 STDOUT 及 STDERR，而這些日誌是以容器日誌形式進行挑選。若要轉遞寫入至 STDOUT 及 STDERR 的應用程式日誌，請遵循[啟用日誌轉遞](cs_health.html#log_sources_enable)中的步驟。

開始之前，請先將 [CLI 的目標](cs_cli_install.html#cs_cli_configure)設為日誌來源所在的叢集。

1. 開啟應用程式 Pod 的 `.yaml` 配置檔。

2. 將下列 `volumeMounts` 及 `volumes` 新增至配置檔：

    ```
    apiVersion: v1
    kind: Pod
    metadata:
      name: <pod_name>
    containers:
    - name: fluentd
      image: "<your_registry_image>"
      volumeMounts:
        # Docker paths
          - mountPath: /var/log/my-app-log-files-directory
            name: app-log
    volumes:
    - name: app-log
      hostPath:
        path: /var/log/apps
    ```
    {: codeblock}

2. 將磁區裝載至 Pod。

    ```
    kubectl apply -f <local_yaml_path>
    ```
    {:pre}

3. 若要建立日誌轉遞配置，請遵循[啟用日誌轉遞](cs_health.html#log_sources_enable)中的步驟。

<br />


## 更新日誌轉遞配置
{: #log_sources_update}

您可以更新容器、應用程式、工作者節點、Kubernetes 系統元件或 Ingress 應用程式負載平衡器的記載配置。
{: shortdesc}

開始之前：

1. 如果您要將日誌收集器伺服器變更為 syslog，可以使用下列兩種方式來設定接受 syslog 通訊協定的伺服器：
  * 設定並管理自己的伺服器，或讓提供者為您管理。如果提供者為您管理伺服器，請從記載提供者取得記載端點。
  * 從容器執行 syslog。例如，您可以使用此[部署 .yaml 檔案![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://github.com/IBM-Bluemix/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml)，來提取在 Kubernet 叢集中執行容器的 Docker 公用映像檔。映像檔會發佈公用叢集 IP 位址上的埠 `514`，並使用這個公用叢集 IP 位址來配置 syslog 主機。

2. 將 [CLI 的目標](cs_cli_install.html#cs_cli_configure)設為日誌來源所在的叢集。

若要變更記載配置的詳細資料，請執行下列動作：

1. 更新記載配置。

    ```
    bx cs logging-config-update <my_cluster> --id <log_config_id> --logsource <my_log_source> --hostname <log_server_hostname_or_IP> --port <log_server_port> --space <cluster_space> --org <cluster_org> --type <logging_type>
    ```
    {: pre}

    <table>
    <caption>瞭解此指令的元件</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解此指令的元件</th>
    </thead>
    <tbody>
    <tr>
    <td><code>logging-config-update</code></td>
    <td>用來為您的日誌來源更新日誌轉遞配置的指令。</td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td>將 <em>&lt;my_cluster&gt;</em> 取代為叢集的名稱或 ID。</td>
    </tr>
    <tr>
    <td><code>--id <em>&lt;log_config_id&gt;</em></code></td>
    <td>將 <em>&lt;log_config_id&gt;</em> 取代為日誌來源配置的 ID。</td>
    </tr>
    <tr>
    <td><code>--logsource <em>&lt;my_log_source&gt;</em></code></td>
    <td>將 <em>&lt;my_log_source&gt;</em> 取代為日誌來源。接受值為 <code>container</code>、<code>application</code>、<code>worker</code>、<code>kubernetes</code> 及 <code>ingress</code>。</td>
    </tr>
    <tr>
    <td><code>--hostname <em>&lt;log_server_hostname_or_IP&gt;</em></code></td>
    <td>記載類型是 <code>syslog</code> 時，請將 <em>&lt;log_server_hostname_or_IP&gt;</em> 取代為日誌收集器服務的主機名稱或 IP 位址。記載類型是 <code>ibm</code> 時，請將 <em>&lt;log_server_hostname&gt;</em> 取代為 {{site.data.keyword.loganalysislong_notm}} 汲取 URL。您可以在[這裡](/docs/services/CloudLogAnalysis/log_ingestion.html#log_ingestion_urls)尋找可用的汲取 URL 清單。如果您未指定汲取 URL，則會使用您在其中建立叢集之地區的端點。</td>
    </tr>
    <tr>
    <td><code>--port <em>&lt;log_collector_port&gt;</em></code></td>
    <td>將 <em>&lt;log_server_port&gt;</em> 取代為日誌收集器伺服器的埠。如果您未指定埠，則會將標準埠 <code>514</code> 用於 <code>syslog</code>，而將 <code>9091</code> 用於 <code>ibm</code>。</td>
    </tr>
    <tr>
    <td><code>--space <em>&lt;cluster_space&gt;</em></code></td>
    <td>將 <em>&lt;cluster_space&gt;</em> 取代為您要將日誌傳送至其中的 Cloud Foundry 空間的名稱。此值僅對日誌類型 <code>ibm</code> 有效且為選用。如果您未指定空間，則會將日誌傳送至帳戶層次。</td>
    </tr>
    <tr>
    <td><code>--org <em>&lt;cluster_org&gt;</em></code></td>
    <td>將 <em>&lt;cluster_org&gt;</em> 取代為空間所在的 Cloud Foundry 組織的名稱。此值僅對日誌類型 <code>ibm</code> 有效，而且如果您已指定空間，則這是必要值。</td>
    </tr>
    <tr>
    <td><code>--type <em>&lt;logging_type&gt;</em></code></td>
    <td>將 <em>&lt;logging_type&gt;</em> 取代為您要使用的新日誌轉遞通訊協定。目前支援 <code>syslog</code> 和 <code>ibm</code>。</td>
    </tr>
    </tbody></table>

2. 驗證已更新日誌轉遞配置。

    * 若要列出叢集中的所有記載配置，請執行下列指令：

      ```
      bx cs logging-config-get <my_cluster>
      ```
      {: pre}

      輸出範例：

      ```
      Id                                    Source       Namespace     Host                          Port   Org      Space      Protocol     Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  kubernetes   -             172.30.162.138                5514   -        -          syslog       /var/log/kubelet.log,/var/log/kube-proxy.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  application  -             ingest.logging.ng.bluemix.net 9091   my_org   my_space   ibm          /var/log/apps/**/*.log,/var/log/apps/**/*.err
      8a284f1a-451c-4c48-b1b4-a4e6b977264e  containers   my-namespace  myhostname.common             5514   -        -          syslog       -
      ```
      {: screen}

    * 若要列出某種類型日誌來源的記載配置，請執行下列指令：

      ```
      bx cs logging-config-get <my_cluster> --logsource worker
      ```
      {: pre}

      輸出範例：

      ```
      Id                                    Source    Namespace   Host                            Port   Org    Space     Protocol    Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  worker    -           ingest.logging.ng.bluemix.net   9091   -      -         ibm         /var/log/syslog,/var/log/auth.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  worker    -           172.30.162.138                  5514   -      -         syslog      /var/log/syslog,/var/log/auth.log
      ```

      {: screen}

<br />


## 停止日誌轉遞
{: #log_sources_delete}

您可以藉由刪除記載配置來停止轉遞日誌。

開始之前，請先將 [CLI 的目標](cs_cli_install.html#cs_cli_configure)設為日誌來源所在的叢集。

1. 刪除記載配置。

    ```
    bx cs logging-config-rm <my_cluster> --id <log_config_id>
    ```
    {: pre}
    將 <em>&lt;my_cluster&gt;</em> 取代為記載配置所在叢集的名稱，並將 <em>&lt;log_config_id&gt;</em> 取代為日誌來源配置的 ID。



<br />


## 針對 Kubernetes API 審核日誌配置日誌轉遞
{: #app_forward}

Kubernetes API 審核日誌會從叢集中擷取任何 Kubernetes API 伺服器呼叫。若要開始收集 Kubernetes API 審核日誌，您可以配置 Kubernetes API 伺服器，為您的叢集設定 Webhook 後端。此 Webhook 後端可將日誌傳送至遠端伺服器。如需 Kubernetes 審核日誌的相關資訊，請參閱 Kubernetes 文件中的<a href="https://kubernetes.io/docs/tasks/debug-application-cluster/audit/" target="_blank">審核主題 <img src="../icons/launch-glyph.svg" alt="外部鏈結圖示"></a>。

**附註**：
* 只有 Kubernetes 1.7 版及更新版本才支援轉遞 Kubernetes API 審核日誌。
* 預設審核原則目前用於所有具有此記載配置的叢集。

### 啟用 Kubernetes API 審核日誌轉遞
{: #audit_enable}

開始之前：

1. 在您可以轉遞日誌之處設定遠端記載伺服器。例如，您可以[使用 Logstash 搭配 Kubernetes ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/tasks/debug-application-cluster/audit/#use-logstash-to-collect-and-distribute-audit-events-from-webhook-backend) 以收集審核事件。

2. 將 [CLI 的目標](cs_cli_install.html#cs_cli_configure)設為您要從該處收集 API 伺服器審核日誌的叢集。

若要轉遞 Kubernetes API 審核日誌，請執行下列動作：

1. 設定 API 伺服器配置的 Webhook 後端。將根據您在此指令旗標中提供的資訊，來建立 Webhook 配置。如果您未在旗標中提供任何資訊，則會使用預設 Webhook 配置。

    ```
    bx cs apiserver-config-set audit-webhook <my_cluster> --remoteServer <server_URL_or_IP> --caCert <CA_cert_path> --clientCert <client_cert_path> --clientKey <client_key_path>
    ```
    {: pre}

    <table>
    <caption>瞭解此指令的元件</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解此指令的元件</th>
    </thead>
    <tbody>
    <tr>
    <td><code>apiserver-config-set</code></td>
    <td>設定叢集 Kubernetes API 伺服器配置之選項的指令。</td>
    </tr>
    <tr>
    <td><code>audit-webhook</code></td>
    <td>設定叢集 Kubernetes API 伺服器之審核 Webhook 配置的次指令。</td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td>將 <em>&lt;my_cluster&gt;</em> 取代為叢集的名稱或 ID。</td>
    </tr>
    <tr>
    <td><code>--remoteServer <em>&lt;server_URL&gt;</em></code></td>
    <td>將 <em>&lt;server_URL&gt;</em> 取代為您要將日誌傳送至其中的遠端記載服務的 URL 或 IP 位址。如果您提供不安全的伺服器 URL，則會忽略任何憑證。</td>
    </tr>
    <tr>
    <td><code>--caCert <em>&lt;CA_cert_path&gt;</em></code></td>
    <td>將 <em>&lt;CA_cert_path&gt;</em> 取代為用來驗證遠端記載服務之 CA 憑證的檔案路徑。</td>
    </tr>
    <tr>
    <td><code>--clientCert <em>&lt;client_cert_path&gt;</em></code></td>
    <td>將 <em>&lt;client_cert_path&gt;</em> 取代為用來對遠端記載服務進行鑑別之用戶端憑證的檔案路徑。</td>
    </tr>
    <tr>
    <td><code>--clientKey <em>&lt;client_key_path&gt;</em></code></td>
    <td>將 <em>&lt;client_key_path&gt;</em> 取代為用來連接至遠端記載服務之對應用戶端金鑰的檔案路徑。</td>
    </tr>
    </tbody></table>

2. 檢視遠端記載服務的 URL，驗證已啟用日誌轉遞。

    ```
    bx cs apiserver-config-get audit-webhook <my_cluster>
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
    bx cs apiserver-refresh <my_cluster>
    ```
    {: pre}

### 停止 Kubernetes API 審核日誌轉遞
{: #audit_delete}

您可以停用叢集 API 伺服器的 Webhook 後端配置，來停止轉遞審核日誌。

開始之前，請先將 [CLI 的目標](cs_cli_install.html#cs_cli_configure)設為您要停止從該處收集 API 伺服器審核日誌的叢集。

1. 停用叢集 API 伺服器的 Webhook 後端配置。

    ```
    bx cs apiserver-config-unset audit-webhook <my_cluster>
    ```
    {: pre}

2. 重新啟動 Kubernetes 主節點，以套用配置更新。

    ```
    bx cs apiserver-refresh <my_cluster>
    ```
    {: pre}

<br />


## 檢視日誌
{: #view_logs}

若要檢視叢集及容器的日誌，您可以使用標準 Kubernetes 及 Docker 記載特性。
{:shortdesc}

### {{site.data.keyword.loganalysislong_notm}}
{: #view_logs_k8s}

若為標準叢集，日誌位於您在建立 Kubernetes 叢集時所登入的 {{site.data.keyword.Bluemix_notm}} 帳戶。如果您在建立叢集或建立記載配置時指定了 {{site.data.keyword.Bluemix_notm}} 空間，則日誌位於該空間中。日誌是在容器外部進行監視及轉遞。您可以使用 Kibana 儀表板來存取容器的日誌。如需記載的相關資訊，請參閱 [{{site.data.keyword.containershort_notm}} 的記載功能](/docs/services/CloudLogAnalysis/containers/containers_kubernetes.html#containers_kubernetes)。

**附註**：如果您在建立叢集或記載配置時指定了空間，則帳戶擁有者必須對該空間具有「管理員」、「開發人員」或「審核員」許可權，才能檢視日誌。如需變更 {{site.data.keyword.containershort_notm}} 存取原則及許可權的相關資訊，請參閱[管理叢集存取](cs_users.html#managing)。在變更許可權之後，日誌最多需要 24 小時才會開始出現。

若要存取 Kibana 儀表板，請移至下列其中一個 URL，然後選取您建立叢集所在的 {{site.data.keyword.Bluemix_notm}} 帳戶或空間。
- 美國南部及美國東部：https://logging.ng.bluemix.net
- 英國南部：https://logging.eu-gb.bluemix.net
- 歐盟中部：https://logging.eu-fra.bluemix.net
- 亞太地區南部：https://logging.au-syd.bluemix.net

如需檢視日誌的相關資訊，請參閱[從 Web 瀏覽器導覽至 Kibana](/docs/services/CloudLogAnalysis/kibana/launch.html#launch_Kibana_from_browser)。

### Docker 日誌
{: #view_logs_docker}

您可以運用內建 Docker 記載功能來檢閱標準 STDOUT 及 STDERR 輸出串流的活動。如需相關資訊，請參閱[檢視在 Kubernetes 叢集中執行的容器的容器日誌](/docs/services/CloudLogAnalysis/containers/containers_kubernetes.html#containers_kubernetes)。

<br />


## 配置叢集監視
{: #monitoring}

度量值可以協助您監視叢集的性能及效能。您可以配置工作者節點的性能監視，以自動偵測並更正任何進入欠佳或非作業狀態的工作者。**附註**：只有標準叢集支援監視。
{:shortdesc}

## 檢視度量值
{: #view_metrics}

您可以使用標準 Kubernetes 及 Docker 特性，來監視叢集及應用程式的性能。
{:shortdesc}

<dl>
<dt>{{site.data.keyword.Bluemix_notm}} 中的叢集詳細資料頁面</dt>
<dd>{{site.data.keyword.containershort_notm}} 提供叢集性能及容量以及叢集資源使用情形的相關資訊。您可以使用此 GUI 來橫向擴充叢集、使用持續性儲存空間，以及透過 {{site.data.keyword.Bluemix_notm}} 服務連結將更多功能新增至叢集。若要檢視叢集詳細資料頁面，請移至 **{{site.data.keyword.Bluemix_notm}} 儀表板**，然後選取一個叢集。</dd>
<dt>Kubernetes 儀表板</dt>
<dd>Kubernetes 儀表板是一個管理 Web 介面，可用來檢閱工作者節點的性能、尋找 Kubernetes 資源、部署容器化應用程式，以及使用記載及監視資訊來進行應用程式疑難排解。如需如何存取 Kubernetes 儀表板的相關資訊，請參閱[啟動 {{site.data.keyword.containershort_notm}} 的 Kubernetes 儀表板](cs_app.html#cli_dashboard)。</dd>
<dt>{{site.data.keyword.monitoringlong_notm}}</dt>
<dd>標準叢集的度量值位於在建立 Kubernetes 叢集時所登入的 {{site.data.keyword.Bluemix_notm}} 帳戶。如果您在建立叢集時指定了 {{site.data.keyword.Bluemix_notm}} 空間，則度量值位於該空間中。會自動收集叢集中所部署的所有容器的容器度量值。這些度量值會透過 Grafana 傳送並設為可供使用。如需度量值的相關資訊，請參閱 [{{site.data.keyword.containershort_notm}} 的監視功能](/docs/services/cloud-monitoring/containers/monitoring_containers_ov.html#monitoring_bmx_containers_ov)。<p>若要存取 Grafana 儀表板，請移至下列其中一個 URL，然後選取您建立叢集所在的 {{site.data.keyword.Bluemix_notm}} 帳戶或空間。<ul><li>美國南部及美國東部：https://metrics.ng.bluemix.net</li><li>英國南部：https://metrics.eu-gb.bluemix.net</li></ul></p></dd></dl>

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

{{site.data.keyword.containerlong_notm}} 的「自動回復」系統可以部署至 Kubernetes 1.7 版或更新版本的現有叢集。「自動回復」系統會使用各種檢查來查詢工作者節點性能狀態。如果「自動回復」根據配置的檢查，偵測到性能不佳的工作者節點，則「自動回復」會觸發更正動作，如在工作者節點上重新載入 OS。一次只有一個工作者節點進行一個更正動作。工作者節點必須先順利完成更正動作，然後任何其他工作者節點才能進行更正動作。
如需相關資訊，請參閱此[自動回復部落格文章 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/blogs/bluemix/2017/12/autorecovery-utilizes-consistent-hashing-high-availability/)。
**附註**：「自動回復」至少需要一個性能良好的節點，才能正常運作。只在具有兩個以上工作者節點的叢集中，配置具有主動檢查的「自動回復」。

開始之前，請先將 [CLI 的目標](cs_cli_install.html#cs_cli_configure)設為您要在其中檢查工作者節點狀態的叢集。

1. 以 JSON 格式建立配置對映檔，以定義您的檢查。例如，下列 YAML 檔案定義三個檢查：一個 HTTP 檢查及兩個 Kubernetes API 伺服器檢查。**附註**：每項檢查需要在配置對映的資料區段中定義為唯一索引鍵。

    ```
    kind: ConfigMap
    apiVersion: v1
    metadata:
      name: ibm-worker-recovery-checks
      namespace: kube-system
    data:
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
    ```
    {:codeblock}


<table summary="瞭解配置對映元件">
    <caption>瞭解配置對映元件</caption>
<thead>
<th colspan=2><img src="images/idea.png"/>瞭解配置對映元件</th>
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
<td><code>checkhttp.json</code></td>
<td>定義 HTTP 檢查，以確定 HTTP 伺服器在每個節點的 IP 位址的埠 80 上執行，並在路徑 <code>/myhealth</code> 傳回 200 回應。您可以執行 <code>kubectl get nodes</code> 找到節點的 IP 位址。
               例如，請考量叢集中的兩個節點，IP 位址分別為 10.10.10.1 和 10.10.10.2。在此範例中，會檢查兩個路徑以取得 200 OK 回應：<code>http://10.10.10.1:80/myhealth</code> 和 <code>http://10.10.10.2:80/myhealth</code>。
               上述範例 YAML 中的檢查每 3 分鐘執行一次。如果它連續失敗 3 次，便會將節點重新開機。此動作相等於執行 <code>bx cs worker-reboot</code>。HTTP 檢查會停用，直到您將 <b>Enabled</b> 欄位設為 <code>true</code>。</td>
</tr>
<tr>
<td><code>checknode.json</code></td>
<td>定義 Kubernetes API 節點檢查，以檢查每個節點是否處於 <code>Ready</code> 狀態。如果節點不是處於 <code>Ready</code> 狀態，特定節點的檢查會計算為失敗。
               上述範例 YAML 中的檢查每 3 分鐘執行一次。如果它連續失敗 3 次，便會重新載入節點。此動作相等於執行 <code>bx cs worker-reload</code>。節點檢查會啟用，直到您將 <b>Enabled</b> 欄位設為 <code>false</code> 或移除檢查。</td>
</tr>
<tr>
<td><code>checkpod.json</code></td>
<td>定義 Kubernetes API pod 檢查，以檢查節點上 <code>NotReady</code> pod 的百分比總計，以指派給該節點的總 pod 數為基礎。如果 <code>NotReady</code> pod 的百分比總計大於已定義的 <code>PodFailureThresholdPercent</code>，特定節點的檢查會計算為失敗。
               上述範例 YAML 中的檢查每 3 分鐘執行一次。如果它連續失敗 3 次，便會重新載入節點。此動作相等於執行 <code>bx cs worker-reload</code>。Pod 檢查會啟用，直到您將 <b>Enabled</b> 欄位設為 <code>false</code> 或移除檢查。</td>
</tr>
</tbody>
</table>


<table summary="瞭解個別規則的元件">
    <caption>瞭解個別規則的元件</caption>
<thead>
<th colspan=2><img src="images/idea.png"/>瞭解個別規則元件</th>
</thead>
<tbody>
<tr>
<td><code>Check</code></td>
<td>輸入您要「自動回復」使用的檢查類型。<ul><li><code>HTTP</code>：「自動回復」會呼叫每一個節點上執行的 HTTP 伺服器，以判斷節點是否適當地執行。</li><li><code>KUBEAPI</code>：「自動回復」會呼叫 Kubernetes API 伺服器，並讀取工作者節點所回報的性能狀態資料。</li></ul></td>
</tr>
<tr>
<td><code>Resource</code></td>
<td>當檢查類型為 <code>KUBEAPI</code> 時，請輸入您要「自動回復」檢查的資源類型。接受的值為 <code>NODE</code> 或 <code>PODS</code>。</td>
</tr>
<tr>
<td><code>FailureThreshold</code></td>
<td>輸入連續失敗檢查次數的臨界值。符合此臨界值時，「自動回復」會觸發指定的更正動作。例如，如果值為 3，且「自動回復」連續三次無法進行配置的檢查，則「自動回復」會觸發與該檢查相關聯的更正動作。</td>
</tr>
<tr>
<td><code>PodFailureThresholdPercent</code></td>
<td>資源類型為 <code>PODS</code> 時，請輸入工作者節點上可以處於 [NotReady ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/#define-readiness-probes) 狀態之 Pod 的百分比臨界值。此百分比是以排定給工作者節點的 Pod 總數為基礎。當檢查判定性能不佳之 Pod 的百分比大於臨界值時，此檢查會將其算成一次失敗。</td>
</tr>
<tr>
<td><code>CorrectiveAction</code></td>
<td>輸入當符合失敗臨界值時要執行的動作。只有在未修復任何其他工作者，且此工作者節點不在前一個動作的冷卻期內時，才會執行更正動作。<ul><li><code>REBOOT</code>：重新啟動工作者節點。</li><li><code>RELOAD</code>：從全新的 OS 重新載入工作者節點的所有必要配置。</li></ul></td>
</tr>
<tr>
<td><code>CooloffSeconds</code></td>
<td>輸入「自動回復」必須等待幾秒，才能對已發出更正動作的節點發出另一個更正動作。冷卻期從發出更正動作的時間開始。</td>
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
<td>檢查類型為 <code>HTTP</code> 時，請輸入工作者節點上 HTTP 伺服器必須連結的埠。此埠必須公開在叢集中每個工作者節點的 IP 上。「自動回復」需要在所有節點之中固定不變的埠號，以檢查伺服器。將自訂伺服器部署至叢集時，請使用 [DaemonSets ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/)。</td>
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
</tbody>
</table>

2. 在叢集中建立配置對映。

    ```
    kubectl apply -f <my_file.yaml>
    ```
    {: pre}

3. 使用適當的檢查，驗證您已在 `kube-system` 名稱空間中建立名稱為 `ibm-worker-recovery-checks` 的配置對映。

    ```
    kubectl -n kube-system get cm ibm-worker-recovery-checks -o yaml
    ```
    {: pre}


4. 套用此 YAML 檔案，以將「自動回復」部署至叢集。

   ```
   kubectl apply -f https://raw.githubusercontent.com/IBM-Bluemix/kube-samples/master/ibm-worker-recovery/ibm-worker-recovery.yml
   ```
   {: pre}

5. 幾分鐘之後，您可以檢查下列指令輸出中的 `Events` 區段，以查看「自動回復」部署上的活動。

    ```
    kubectl -n kube-system describe deployment ibm-worker-recovery
    ```
    {: pre}
