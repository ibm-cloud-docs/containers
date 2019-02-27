---

copyright:
  years: 2014, 2018
lastupdated: "2018-12-05"

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




# 在防火牆中開啟必要埠及 IP 位址
{: #firewall}

請檢閱下列狀況，在下列狀況時，您可能需要在防火牆中為 {{site.data.keyword.containerlong}} 開啟特定的埠和 IP 位址。
{:shortdesc}

* 當組織網路原則導致無法透過 Proxy 或防火牆存取公用網際網路端點時，從本端系統[執行 `ibmcloud` 指令](#firewall_bx)。
* 當組織網路原則導致無法透過 Proxy 或防火牆存取公用網際網路端點時，從本端系統[執行 `kubectl` 指令](#firewall_kubectl)。
* 當組織網路原則導致無法透過 Proxy 或防火牆存取公用網際網路端點時，從本端系統[執行 `calicoctl` 指令](#firewall_calicoctl)。
* 當已針對工作者節點設定防火牆，或是在 IBM Cloud 基礎架構 (SoftLayer) 帳戶中自訂防火牆設定時，[容許 Kubernetes 主節點與工作者節點之間的通訊](#firewall_outbound)。
* [容許叢集透過專用網路上的防火牆存取資源](#firewall_private)。
* [從叢集外部存取 NodePort 服務、負載平衡器服務或 Ingress](#firewall_inbound)。

<br />


## 在防火牆的保護下執行 `ibmcloud ks` 指令
{: #firewall_bx}

如果組織網路原則導致無法透過 Proxy 或防火牆從本端系統存取公用端點，則若要執行 `ibmcloud ks` 指令，您必須容許 {{site.data.keyword.containerlong_notm}} 的 TCP 存取。
{:shortdesc}

1. 容許埠 443 上對 `containers.bluemix.net` 的存取。
2. 驗證連線。如果已正確配置存取，則會在輸出中顯示船。
   ```
   curl https://containers.bluemix.net/v1/
   ```
   {: pre}

   輸出範例：
   ```
                                     )___(
                              _______/__/_
                     ___     /===========|   ___
    ____       __   [\\\]___/____________|__[///]   __
    \   \_____[\\]__/___________________________\__[//]___
     \                                                    |
      \                                                  /
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

   ```
   {: screen}

<br />


## 在防火牆的保護下執行 `kubectl` 指令
{: #firewall_kubectl}

如果組織網路原則導致無法透過 Proxy 或防火牆從本端系統存取公用端點，則若要執行 `kubectl` 指令，您必須容許叢集的 TCP 存取。
{:shortdesc}

建立叢集時，會從 20000-32767 內隨機指派主要 URL 中的埠。您可以針對任何可能建立的叢集選擇開啟埠範圍 20000-32767，或選擇容許存取特定現有叢集。

開始之前，請容許[執行 `ibmcloud ks` 指令](#firewall_bx)的存取。

若要容許存取特定叢集，請執行下列動作：

1. 登入 {{site.data.keyword.Bluemix_notm}} CLI。系統提示時，請輸入您的 {{site.data.keyword.Bluemix_notm}} 認證。如果您有聯合帳戶，請包含 `--sso` 選項。

   ```
   ibmcloud login [--sso]
   ```
   {: pre}

2. 如果叢集位於 `default` 以外的資源群組中，請將目標設為該資源群組。若要查看每一個叢集所屬的資源群組，請執行 `ibmcloud ks clusters`。**附註**：您必須至少具有資源群組的[**檢視者**角色](cs_users.html#platform)。
   ```
   ibmcloud target -g <resource_group_name>
   ```
   {: pre}

2. 選取您叢集所在的地區。

   ```
   ibmcloud ks region-set
   ```
   {: pre}

3. 取得叢集的名稱。

   ```
   ibmcloud ks clusters
   ```
   {: pre}

4. 擷取叢集的**主要 URL**。

   ```
   ibmcloud ks cluster-get <cluster_name_or_ID>
   ```
   {: pre}

   輸出範例：
   ```
   ...
   Master URL:		https://c3.<region>.containers.cloud.ibm.com
   ...
   ```
   {: screen}

5. 容許在埠上存取**主要 URL**，例如來自前一個範例的埠 `31142`。

6. 驗證連線。

   ```
   curl --insecure <master_URL>/version
   ```
   {: pre}

   範例指令：
   ```
   curl --insecure https://c3.<region>.containers.cloud.ibm.com:31142/version
   ```
   {: pre}

   輸出範例：
   ```
   {
     "major": "1",
     "minor": "7+",
     "gitVersion": "v1.7.4-2+eb9172c211dc41",
     "gitCommit": "eb9172c211dc4108341c0fd5340ee5200f0ec534",
     "gitTreeState": "clean",
     "buildDate": "2017-11-16T08:13:08Z",
     "goVersion": "go1.8.3",
     "compiler": "gc",
     "platform": "linux/amd64"
   }
   ```
   {: screen}

7. 選用項目：針對您需要公開的每一個叢集，重複這些步驟。

<br />


## 在防火牆的保護下執行 `calicoctl` 指令
{: #firewall_calicoctl}

如果組織網路原則導致無法透過 Proxy 或防火牆從本端系統存取公用端點，則若要執行 `calicoctl` 指令，您必須容許 Calico 指令的 TCP 存取。
{:shortdesc}

開始之前，請容許執行 [`ibmcloud` 指令](#firewall_bx)及 [`kubectl` 指令](#firewall_kubectl)的存取。

1. 從用來容許 [`kubectl` 指令](#firewall_kubectl)的主要 URL 中擷取 IP 位址。

2. 取得 ETCD 的埠。

  ```
  kubectl get cm -n kube-system cluster-info -o yaml | grep etcd_host
  ```
  {: pre}

3. 容許透過主要 URL IP 位址及 ETCD 埠存取 Calico 原則。

<br />


## 容許叢集存取基礎架構資源及其他服務
{: #firewall_outbound}

讓您的叢集從防火牆之後存取基礎架構資源及服務，例如 {{site.data.keyword.containerlong_notm}} 地區、{{site.data.keyword.registrylong_notm}}、{{site.data.keyword.monitoringlong_notm}}、{{site.data.keyword.loganalysislong_notm}}、IBM Cloud 基礎架構 (SoftLayer) 專用 IP，以及持續性磁區要求的出口。
{:shortdesc}

1.  記下叢集裡所有工作者節點的公用 IP 位址。

    ```
    ibmcloud ks workers <cluster_name_or_ID>
    ```
    {: pre}

2.  容許從來源 _<each_worker_node_publicIP>_ 到目的地 TCP/UDP 埠範圍 20000-32767 和埠 443 以及下列 IP 位址和網路群組的送出網路資料流量。如果您的組織防火牆導致本端機器無法存取公用網際網路端點，請針對來源工作者節點及本端機器執行此步驟。

    對於地區內的所有區域，您必須容許對埠 443 的送出資料流量，以平衡引導處理程序期間的負載。例如，如果您的叢集是在美國南部，則必須容許從每個工作者節點的公用 IP 傳輸到所有區域的 IP 位址的埠 443。
    {: important}

    <table summary="表格中的第一列跨越兩個直欄。其餘的列應該從左到右閱讀，第一欄為伺服器區域，第二欄則為要符合的 IP 位址。">
  <caption>針對送出資料流量開啟的 IP 位址</caption>
        <thead>
        <th>地區</th>
        <th>區域</th>
        <th>IP 位址</th>
        </thead>
      <tbody>
        <tr>
          <td>亞太地區北部</td>
          <td>che01<br>hkg02<br>seo01<br>sng01<br>tok02、tok04、tok05</td>
          <td><code>169.38.70.10</code><br><code>169.56.132.234</code><br><code>169.56.69.242</code><br><code>161.202.186.226</code><br><code>161.202.126.210、128.168.71.117、165.192.69.69</code></td>
         </tr>
        <tr>
           <td>亞太地區南部</td>
           <td>mel01<br>syd01、syd04</td>
           <td><code>168.1.97.67</code><br><code>168.1.8.195、130.198.66.26、168.1.12.98、130.198.64.19</code></td>
        </tr>
        <tr>
           <td>歐盟中部</td>
           <td>ams03<br>mil01<br>osl01<br>par01<br>fra02、fra04、fra05</td>
           <td><code>169.50.169.110、169.50.154.194</code><br><code>159.122.190.98、159.122.141.69</code><br><code>169.51.73.50</code><br><code>159.8.86.149、159.8.98.170</code><br><code>169.50.56.174、161.156.65.42、149.81.78.114</code></td>
          </tr>
        <tr>
          <td>英國南部</td>
          <td>lon02、lon04、lon05、lon06</td>
          <td><code>159.122.242.78、158.175.111.42、158.176.94.26、159.122.224.242、158.175.65.170、158.176.95.146</code></td>
        </tr>
        <tr>
          <td>美國東部</td>
           <td>mon01<br>tor01<br>wdc04、wdc06、wdc07</td>
           <td><code>169.54.126.219</code><br><code>169.53.167.50</code><br><code>169.63.88.186、169.60.73.142、169.61.109.34、169.63.88.178、169.60.101.42、169.61.83.62</code></td>
        </tr>
        <tr>
          <td>美國南部</td>
          <td>hou02<br>sao01<br>sjc03<br>sjc04<br>dal10、dal12、dal13</td>
          <td><code>184.173.44.62</code><br><code>169.57.151.10</code><br><code>169.45.67.210</code><br><code>169.62.82.197</code><br><code>169.46.7.238、169.48.230.146、169.61.29.194、169.46.110.218、169.47.70.10、169.62.166.98、169.48.143.218、169.61.177.2、169.60.128.2</code></td>
        </tr>
        </tbody>
      </table>

3.  容許從工作者節點到 [{{site.data.keyword.registrylong_notm}} 地區](/docs/services/Registry/registry_overview.html#registry_regions)的送出網路資料流量：
    - `TCP port 443 FROM <each_worker_node_publicIP> TO <registry_publicIP>`
    - 將 <em>&lt;registry_publicIP&gt;</em> 取代為您要容許資料流量的登錄 IP 位址。全球登錄會儲存 IBM 提供的公用映像檔，地區登錄會儲存您自己的專用或公用映像檔。
        <p>
<table summary="表格中的第一列跨越兩個直欄。其餘的列應該從左到右閱讀，第一欄為伺服器區域，第二欄則為要符合的 IP 位址。">
  <caption>針對「登錄」資料流量開啟的 IP 位址</caption>
      <thead>
        <th>{{site.data.keyword.containerlong_notm}} 地區</th>
        <th>登錄位址</th>
        <th>登錄 IP 位址</th>
      </thead>
      <tbody>
        <tr>
          <td>跨 {{site.data.keyword.containerlong_notm}} 地區的全球登錄</td>
          <td>registry.bluemix.net</td>
          <td><code>169.60.72.144/28</code></br><code>169.61.76.176/28</code></br><code>169.62.37.240/29</code></br><code>169.60.98.80/29</code></br><code>169.63.104.232/29></code></td>
        </tr>
        <tr>
          <td>亞太地區北部、亞太地區南部</td>
          <td>registry.au-syd.bluemix.net</td>
          <td><code>168.1.45.160/27</code></br><code>168.1.139.32/27</code></br><code>168.1.1.240/29</code></br><code>130.198.88.128/29</code></td>
        </tr>
        <tr>
          <td>歐盟中部</td>
          <td>registry.eu-de.bluemix.net</td>
          <td><code>169.50.56.144/28</code></br><code>159.8.73.80/28</code></br><code>169.50.58.104/29</code></br><code>161.156.93.16/29</code></br><code>149.81.79.152/29</code></td>
         </tr>
         <tr>
          <td>英國南部</td>
          <td>registry.eu-gb.bluemix.net</td>
          <td><code>159.8.188.160/27</code></br><code>169.50.153.64/27</code></br><code>158.175.97.184/29</code></br><code>158.176.105.64/29</code></br><code>141.125.71.136/29</code></td>
         </tr>
         <tr>
          <td>美國東部、美國南部</td>
          <td>registry.ng.bluemix.net</td>
          <td><code>169.55.39.112/28</code></br><code>169.46.9.0/27</code></br><code>169.55.211.0/27</code></br><code>169.61.234.224/29</code></br><code>169.61.135.160/29</code></br><code>169.61.46.80/29</code></td>
         </tr>
        </tbody>
      </table>
</p>

4.  選用項目：容許從工作者節點到 {{site.data.keyword.monitoringlong_notm}}、{{site.data.keyword.loganalysislong_notm}} 及 LogDNA 服務的送出網路資料流量：
    *   **{{site.data.keyword.monitoringlong_notm}}**:
        <pre class="screen">TCP port 443, port 9095 FROM &lt;each_worker_node_public_IP&gt; TO &lt;monitoring_public_IP&gt;</pre>
將 <em>&lt;monitoring_public_IP&gt;</em> 取代為您要容許資料流量的監視地區的所有位址：
        <p><table summary="表格中的第一列跨越兩個直欄。其餘的列應該從左到右閱讀，第一欄為伺服器區域，第二欄則為要符合的 IP 位址。">
  <caption>針對監視資料流量開啟的 IP 位址</caption>
        <thead>
        <th>{{site.data.keyword.containerlong_notm}} 地區</th>
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
</p>
    *   **{{site.data.keyword.loganalysislong_notm}}**:
        <pre class="screen">TCP port 443, port 9091 FROM &lt;each_worker_node_public_IP&gt; TO &lt;logging_public_IP&gt;</pre>
將 <em>&lt;logging_public_IP&gt;</em> 取代為您要容許資料流量的記載地區的所有位址：
        <p><table summary="表格中的第一列跨越兩個直欄。其餘的列應該從左到右閱讀，第一欄為伺服器區域，第二欄則為要符合的 IP 位址。">
<caption>針對記載資料流量開啟的 IP 位址</caption>
        <thead>
        <th>{{site.data.keyword.containerlong_notm}} 地區</th>
        <th>記載位址</th>
        <th>記載 IP 位址</th>
        </thead>
        <tbody>
          <tr>
            <td>美國東部、美國南部</td>
            <td>ingest.logging.ng.bluemix.net</td>
            <td><code>169.48.79.236</code><br><code>169.46.186.113</code></td>
          </tr>
          <tr>
           <td>英國南部</td>
           <td>ingest.logging.eu-gb.bluemix.net</td>
           <td><code>169.50.115.113</code></td>
          </tr>
          <tr>
           <td>歐盟中部</td>
           <td>ingest-eu-fra.logging.bluemix.net</td>
           <td><code>158.177.88.43</code><br><code>159.122.87.107</code></td>
          </tr>
          <tr>
           <td>亞太地區南部、亞太地區北部</td>
           <td>ingest-au-syd.logging.bluemix.net</td>
           <td><code>130.198.76.125</code><br><code>168.1.209.20</code></td>
          </tr>
         </tbody>
       </table>
</p>
    *   **{{site.data.keyword.la_full_notm}}**:
        <pre class="screen">TCP port 443, port 80 FROM &lt;each_worker_node_public_IP&gt; TO &lt;logDNA_public_IP&gt;</pre>
將 `<logDNA_public_IP>` 取代為 [LogDNA IP 位址](/docs/services/Log-Analysis-with-LogDNA/network.html#ips)。

5. 如果您使用負載平衡器服務，請確定在公用和專用介面的工作者節點之間容許使用 VRRP 通訊協定的所有資料流量。{{site.data.keyword.containerlong_notm}} 使用 VRRP 通訊協定來管理公用及專用負載平衡器的 IP 位址。

6. {: #pvc}若要建立資料儲存空間的持續性磁區要求，請透過防火牆容許對 IBM Cloud 基礎架構 (SoftLayer) 進行 Egress 存取。
    - 容許存取 IBM Cloud 基礎架構 (SoftLayer) API 端點，以起始佈建要求：`TCP port 443 FROM <each_worker_node_public_IP> TO 66.228.119.120`。
    - 對於[**前端（公用）網路**](/docs/infrastructure/hardware-firewall-dedicated/ips.html#frontend-public-network)及[**後端（專用）網路**](/docs/infrastructure/hardware-firewall-dedicated/ips.html#backend-private-network)，容許存取您叢集所在之區域的 IBM Cloud 基礎架構 (SoftLayer) IP 範圍。若要尋找叢集的區域，請執行 `ibmcloud ks clusters`。

<br />


## 容許叢集透過專用防火牆存取資源
{: #firewall_private}

如果您的專用網路有防火牆，請容許工作者節點之間進行通訊，並讓您的叢集透過專用網路來存取基礎架構資源。
{:shortdesc}

1. 容許工作者節點之間的所有資料流量。
    1. 在公用及專用介面上，容許工作者節點之間的所有 TCP、UDP、VRRP 及 IPEncap 資料流量。{{site.data.keyword.containerlong_notm}} 使用 VRRP 通訊協定來管理專用負載平衡器的 IP 位址，以及使用 IPEncap 通訊協定來允許跨子網路的 Pod 至 Pod 資料流量。
    2. 如果您使用 Calico 原則，或者您在多區域叢集的每一個區域中都有防火牆，則防火牆可能會封鎖工作者節點之間的通訊。您必須使用工作者節點的埠、工作者節點的專用 IP 位址，或 Calico 工作者節點標籤，讓叢集裡的所有工作者節點都對彼此開啟。

2. 容許 IBM Cloud 基礎架構 (SoftLayer) 專用 IP 範圍，以便您可以在叢集裡建立工作者節點。
    1. 容許適當的 IBM Cloud 基礎架構 (SoftLayer) 專用 IP 範圍。請參閱[後端（專用）網路](/docs/infrastructure/hardware-firewall-dedicated/ips.html#backend-private-network)。
    2. 容許您所使用的所有[區域](cs_regions.html#zones)的 IBM Cloud 基礎架構 (SoftLayer) 專用 IP 範圍。請注意，您必須新增 `dal01` 和 `wdc04` 區域的IP。請參閱[服務網路（在後端/專用網路上）](/docs/infrastructure/hardware-firewall-dedicated/ips.html#service-network-on-backend-private-network-)。

3. 開啟下列埠：
    - 容許出埠 TCP 及 UDP 連線從工作者節點到達埠 80 和 443，以容許工作者節點更新及重新載入。
    - 容許出埠 TCP 及 UDP 到達埠 2049，以容許將檔案儲存空間裝載為磁區。
    - 容許出埠 TCP 及 UDP 到達埠 3260，以進行與區塊儲存空間的通訊。
    - 容許入埠 TCP 及 UDP 連線到達埠 10250，以進行 Kubernetes 儀表板及指令（例如 `kubectl logs` 及 `kubectl exec`）。
    - 容許入埠及出埠連線到達 TCP 和 UDP 埠 53，以進行 DNS 存取。

4. 如果您在公用網路上也有防火牆，或者您有一個僅限專用 VLAN 叢集，而且是使用閘道應用裝置作為防火牆，則您也必須容許[容許叢集存取基礎架構資源及其他服務](#firewall_outbound)中指定的 IP 和埠。

<br />


## 從叢集外部存取 NodePort、負載平衡器及 Ingress 服務
{: #firewall_inbound}

您可以容許對 NodePort、負載平衡器及 Ingress 服務進行送入存取。
{:shortdesc}

<dl>
  <dt>NodePort 服務</dt>
  <dd>開啟您在將服務部署至所有工作者節點的公用 IP 位址時所配置的埠，以容許接收資料流量。若要尋找埠，請執行 `kubectl get svc`。該埠在 20000-32000 的範圍內。<dd>
  <dt>負載平衡器服務</dt>
  <dd>開啟您在將服務部署至負載平衡器服務的公用 IP 位址時所配置的埠。</dd>
  <dt>Ingress</dt>
  <dd>針對 Ingress 應用程式負載平衡器的 IP 位址，開啟埠 80（適用於 HTTP）或埠 443（適用於 HTTPS）。</dd>
</dl>
