---

copyright:
  years: 2014, 2018
lastupdated: "2018-09-10"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}
{:tsSymptoms: .tsSymptoms}
{:tsCauses: .tsCauses}
{:tsResolve: .tsResolve}



# 叢集和工作者節點的疑難排解
{: #cs_troubleshoot_clusters}

在您使用 {{site.data.keyword.containerlong}} 時，請考慮使用這些技術來進行叢集和工作者節點的疑難排解。
{: shortdesc}

如果您有更一般性的問題，請嘗試[叢集除錯](cs_troubleshoot.html)。
{: tip}

## 無法連接至基礎架構帳戶
{: #cs_credentials}

{: tsSymptoms}
建立新的 Kubernetes 叢集時，您會收到與下列其中一則類似的錯誤訊息。

```
We were unable to connect to your IBM Cloud infrastructure (SoftLayer) account.
Creating a standard cluster requires that you have either a
Pay-As-You-Go account that is linked to an IBM Cloud infrastructure (SoftLayer)
account term or that you have used the {{site.data.keyword.containerlong_notm}}
CLI to set your {{site.data.keyword.Bluemix_notm}} Infrastructure API keys.
```
{: screen}

```
{{site.data.keyword.Bluemix_notm}} Infrastructure Exception:
'Item' must be ordered with permission.
```
{: screen}

```
{{site.data.keyword.Bluemix_notm}} Infrastructure Exception:
The user does not have the necessary {{site.data.keyword.Bluemix_notm}}
Infrastructure permissions to add servers
```
{: screen}

```
IAM token exchange request failed: Cannot create IMS portal token, as no IMS account is linked to the selected BSS account
```
{: screen}

{: tsCauses}
在啟用自動帳戶鏈結之後所建立的 {{site.data.keyword.Bluemix_notm}}「隨收隨付制」帳戶已設定為具有 IBM Cloud 基礎架構 (SoftLayer) 組合的存取權。您可以購買叢集的基礎架構資源，而不需要進行額外配置。
如果您具有一個有效的「隨收隨付制」帳戶，並收到此錯誤訊息，則可能未使用正確的 IBM Cloud 基礎架構 (SoftLayer) 帳戶來存取基礎架構資源。

具有其他 {{site.data.keyword.Bluemix_notm}} 帳戶類型的使用者必須配置其帳戶以建立標準叢集。您可能會有不同帳戶類型的情況範例如下：
* 您現有 IBM Cloud 基礎架構 (SoftLayer) 帳戶的日期早於 {{site.data.keyword.Bluemix_notm}} 平台帳戶，並想要繼續使用它。
* 您要使用不同的 IBM Cloud 基礎架構 (SoftLayer) 帳戶來佈建基礎架構資源。例如，您可以設定團隊 {{site.data.keyword.Bluemix_notm}} 帳戶，使用不同的基礎架構帳戶來進行計費。

{: tsResolve}
帳戶擁有者必須適當地設定基礎架構認證帳戶。認證取決於您所使用的基礎架構帳戶類型。

**開始之前**：

1.  驗證您可以存取基礎架構帳戶。登入 [{{site.data.keyword.Bluemix_notm}} 主控台 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://console.bluemix.net/)，然後從可展開的功能表中，按一下**基礎架構**。如果您看到基礎架構儀表板，則可以存取基礎架構帳戶。
2.  檢查您的叢集是否使用不同的基礎架構帳戶，而不是「隨收隨付制」帳戶隨附的基礎架構帳戶。
    1.  從可展開的功能表中，按一下**容器 > 叢集**。
    2.  從表格中，選取您的叢集。
    3.  在**概觀**標籤中，檢查**基礎架構使用者**欄位。
        * 如果您看不到**基礎架構使用者**欄位，表示您的已鏈結「隨收隨付制」帳戶會將相同的認證用於基礎架構及平台帳戶。
        * 如果您看到**基礎架構使用者**欄位，表示您的叢集使用不同的基礎架構帳戶，而不是「隨收隨付制」帳戶隨附的基礎架構帳戶。這些不同的認證適用於地區內的所有叢集。 
3.  決定您要有哪種類型的帳戶，才能判斷如何對基礎架構許可權問題進行疑難排解。對於大部分使用者而言，預設已鏈結「隨收隨付制」帳戶就已足夠。
    *  已鏈結「隨收隨付制」{{site.data.keyword.Bluemix_notm}} 帳戶：[驗證已使用正確的許可權設定基礎架構 API 金鑰](#apikey)。如果您的叢集使用不同的基礎架構帳戶，則您必須在處理程序期間將這些認證解除設定。
    *  不同的 {{site.data.keyword.Bluemix_notm}} 平台及基礎架構帳戶：驗證您可以存取基礎架構組合，以及[已使用正確的許可權設定基礎架構帳戶認證](#credentials)。

### 搭配使用已鏈結「隨收隨付制」帳戶的預設基礎架構認證與 API 金鑰
{: #apikey}

1.  驗證您要將其認證用於基礎架構動作的使用者具有正確的許可權。

    1.  登入 [{{site.data.keyword.Bluemix_notm}} 主控台 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://console.bluemix.net/)。

    2.  從展開功能表中，選取**基礎架構**。

    3.  從功能表列中，選取**帳戶** > **使用者** > **使用者清單**。

    4.  在 **API 金鑰**直欄中，驗證使用者具有 API 金鑰，或按一下**產生**。

    5.  驗證使用者具有[正確的基礎架構許可權](cs_users.html#infra_access)，或將該許可權指派給使用者。

2.  設定叢集所在地區的 API 金鑰。

    1.  使用您要使用其基礎架構許可權的使用者身分，登入終端機。
    
    2.  如果您在不同的地區，請切換至您要設定 API 金鑰的地區。
    
        ```
        ibmcloud ks region-set
        ```
        {: pre}

    3.  設定地區的使用者 API 金鑰。
        ```
        ibmcloud ks api-key-reset
        ```
        {: pre}    

    4.  驗證已設定 API 金鑰。
        ```
        ibmcloud ks api-key-info <cluster_name_or_ID>
        ```
        {: pre}

3.  **選用項目**：如果您的「隨收隨付制」帳戶使用不同的基礎架構帳戶來佈建叢集（例如，您已使用 `ibmcloud ks credentials-set` 指令），則帳戶會繼續使用那些基礎架構認證，而不是 API 金鑰。您必須移除相關聯的基礎架構帳戶，才能使用您在前一個步驟中設定的 API 金鑰。
    ```
    ibmcloud ks credentials-unset
    ```
    {: pre}
        
4.  **選用**：如果您將公用叢集連接至內部部署資源，請檢查您的網路連線功能。

    1.  檢查您的工作者節點 VLAN 連線功能。
    2.  必要時，請[設定 VPN 連線功能](cs_vpn.html#vpn)。
    3.  [開啟防火牆中的必要埠](cs_firewall.html#firewall)。

### 配置不同平台及基礎架構帳戶的基礎架構認證
{: #credentials}

1.  取得您要用來存取 IBM Cloud 基礎架構 (SoftLayer) 組合的基礎架構帳戶。取決於現行帳戶類型，您會有不同的選項。

    <table summary="表格依帳戶類型顯示標準叢集建立選項。列應該從左到右閱讀，第一欄為帳戶說明，第二欄為建立標準叢集的選項。">
    <caption>依帳戶類型的標準叢集建立選項</caption>
      <thead>
      <th>帳戶說明</th>
      <th>建立標準叢集的選項</th>
      </thead>
      <tbody>
        <tr>
          <td>**精簡帳戶**無法佈建叢集。</td>
          <td>[將「精簡」帳戶升級至 {{site.data.keyword.Bluemix_notm}} 隨收隨付制帳戶](/docs/account/index.html#paygo)，其已設定為具有 IBM Cloud 基礎架構 (SoftLayer) 組合存取權。</td>
        </tr>
        <tr>
          <td>**最新的隨收隨付制**帳戶隨附對基礎架構組合的存取權。</td>
          <td>您可以建立標準叢集。若要疑難排解基礎架構許可權，請參閱[為已鏈結帳戶配置基礎架構 API 認證](#apikey)。</td>
        </tr>
        <tr>
          <td>在自動帳戶鏈結可用之前建立的**舊版隨收隨付制帳戶**未隨附對 IBMCloud 基礎架構 (SoftLayer) 組合的存取權。<p>如果您有現有 IBM Cloud 基礎架構 (SoftLayer) 帳戶，則無法將此帳戶鏈結至舊的「隨收隨付制」帳戶。</p></td>
          <td><p><strong>選項 1：</strong>[建立新的隨收隨付制帳戶](/docs/account/index.html#paygo)，其已設定為具有 IBM Cloud 基礎架構 (SoftLayer) 組合存取權。當您選擇此選項時，會有兩個不同的 {{site.data.keyword.Bluemix_notm}} 帳戶及計費。</p><p>若要繼續使用舊的「隨收隨付制」帳戶，您可以使用新的「隨收隨付制」帳戶來產生可存取 IBM Cloud 基礎架構 (SoftLayer) 組合的 API 金鑰。</p><p><strong>選項 2：</strong>如果您已有想要使用的現有 IBM Cloud 基礎架構 (SoftLayer) 帳戶，則可以在 {{site.data.keyword.Bluemix_notm}} 帳戶中設定您的認證。</p><p>**附註：**當您手動鏈結至 IBM Cloud 基礎架構 (SoftLayer) 帳戶時，會將認證用於您 {{site.data.keyword.Bluemix_notm}} 帳戶中的每個 IBM Cloud 基礎架構 (SoftLayer) 特定動作。您必須確定所設定的 API 金鑰具有[足夠的基礎架構許可權](cs_users.html#infra_access)，讓使用者可以建立及使用叢集。</p><p>**對於這兩個選項，請繼續執行下一步**。</p></td>
        </tr>
        <tr>
          <td>**訂閱帳戶**未設定對 IBM Cloud 基礎架構 (SoftLayer) 組合的存取權。</td>
          <td><p><strong>選項 1：</strong>[建立新的隨收隨付制帳戶](/docs/account/index.html#paygo)，其已設定為具有 IBM Cloud 基礎架構 (SoftLayer) 組合存取權。當您選擇此選項時，會有兩個不同的 {{site.data.keyword.Bluemix_notm}} 帳戶及計費。</p><p>如果您要繼續使用「訂閱」帳戶，則可以使用新的「隨收隨付制」帳戶在 IBM Cloud 基礎架構 (SoftLayer) 中產生 API 金鑰。然後，您必須手動設定「訂閱」帳戶的 IBM Cloud 基礎架構 (SoftLayer) API 金鑰。請記住，IBM Cloud 基礎架構 (SoftLayer) 資源是透過新的「隨收隨付制」帳戶計費。</p><p><strong>選項 2：</strong>如果您已有想要使用的現有 IBM Cloud 基礎架構 (SoftLayer) 帳戶，則可以針對 {{site.data.keyword.Bluemix_notm}} 帳戶手動設定 IBM Cloud 基礎架構 (SoftLayer) 認證。</p><p>**附註：**當您手動鏈結至 IBM Cloud 基礎架構 (SoftLayer) 帳戶時，會將認證用於您 {{site.data.keyword.Bluemix_notm}} 帳戶中的每個 IBM Cloud 基礎架構 (SoftLayer) 特定動作。您必須確定所設定的 API 金鑰具有[足夠的基礎架構許可權](cs_users.html#infra_access)，讓使用者可以建立及使用叢集。</p><p>**對於這兩個選項，請繼續執行下一步**。</p></td>
        </tr>
        <tr>
          <td>**IBM Cloud 基礎架構 (SoftLayer) 帳戶**，無 {{site.data.keyword.Bluemix_notm}} 帳戶</td>
          <td><p>[建立 {{site.data.keyword.Bluemix_notm}} 隨收隨付制帳戶](/docs/account/index.html#paygo)，其已設定對 IBM Cloud 基礎架構 (SoftLayer) 組合的存取權。當選擇此選項時，會為您建立 IBM Cloud 基礎架構 (SoftLayer) 帳戶。您有兩個不同的 IBM Cloud 基礎架構 (SoftLayer) 帳戶和帳單。</p><p>依預設，您的新 {{site.keyword.data.Bluemix_notm}} 帳戶會使用新的基礎架構帳戶。若要繼續使用舊的基礎架構帳戶，請繼續執行下一步。</p></td>
        </tr>
      </tbody>
      </table>

2.  驗證您要將其認證用於基礎架構動作的使用者具有正確的許可權。

    1.  登入 [{{site.data.keyword.Bluemix_notm}} 主控台 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://console.bluemix.net/)。

    2.  從展開功能表中，選取**基礎架構**。

    3.  從功能表列中，選取**帳戶** > **使用者** > **使用者清單**。

    4.  在 **API 金鑰**直欄中，驗證使用者具有 API 金鑰，或按一下**產生**。

    5.  驗證使用者具有[正確的基礎架構許可權](cs_users.html#infra_access)，或將該許可權指派給使用者。

3.  使用正確帳戶的使用者來設定基礎架構 API 認證。

    1.  取得使用者的基礎架構 API 認證。**附註**：認證不同於 IBM ID。

        1.  從 [{{site.data.keyword.Bluemix_notm}} ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://console.bluemix.net/) 主控台的**基礎架構** > **帳戶** > **使用者** > **使用者清單**表格中，按一下 **IBM ID 或使用者名稱**。

        2.  在 **API 存取資訊**區段中，檢視 **API 使用者名稱**及**鑑別金鑰**。    

    2.  設定要使用的基礎架構 API 認證。
        ```
        ibmcloud ks credentials-set --infrastructure-username <infrastructure_API_username> --infrastructure-api-key <infrastructure_API_authentication_key>
        ```
        {: pre}

4.  **選用**：如果您將公用叢集連接至內部部署資源，請檢查您的網路連線功能。

    1.  檢查您的工作者節點 VLAN 連線功能。
    2.  必要時，請[設定 VPN 連線功能](cs_vpn.html#vpn)。
    3.  [開啟防火牆中的必要埠](cs_firewall.html#firewall)。

<br />


## 防火牆阻止執行 CLI 指令
{: #ts_firewall_clis}

{: tsSymptoms}
當您從 CLI 執行 `ibmcloud`、`kubectl` 或 `calicoctl` 指令時，它們會失敗。

{: tsCauses}
您的組織網路原則可能會導致無法透過 Proxy 或防火牆從本端系統存取公用端點。

{: tsResolve}
[容許 TCP 存取以讓 CLI 指令運作](cs_firewall.html#firewall)。此作業需要[管理者存取原則](cs_users.html#access_policies)。請驗證您的現行[存取原則](cs_users.html#infra_access)。


## 防火牆阻止叢集連接至資源
{: #cs_firewall}

{: tsSymptoms}
當工作者節點無法連接時，您可能會看到各種不同的症狀。kubectl Proxy 失敗，或您嘗試存取叢集裡的服務，但連線失敗時，您可能會看到下列其中一則訊息。

  ```
  Connection refused
  ```
  {: screen}

  ```
  Connection timed out
  ```
  {: screen}

  ```
  Unable to connect to the server: net/http: TLS handshake timeout
  ```
  {: screen}

如果您執行 kubectl exec、attach 或 logs，可能會看到下列訊息。

  ```
  Error from server: error dialing backend: dial tcp XXX.XXX.XXX:10250: getsockopt: connection timed out
  ```
  {: screen}

如果 kubectl Proxy 成功，但儀表板無法使用，您可能會看到下列訊息。

  ```
  timeout on 172.xxx.xxx.xxx
  ```
  {: screen}



{: tsCauses}
您可能已在 IBM Cloud 基礎架構 (SoftLayer) 帳戶中設定另一個防火牆，或自訂現有防火牆設定。{{site.data.keyword.containerlong_notm}} 需要開啟特定 IP 位址及埠，以容許從工作者節點到 Kubernetes 主節點的通訊，反之亦然。另一個原因可能是工作者節點停留在重新載入的迴圈中。

{: tsResolve}
[容許叢集存取基礎架構資源及其他服務](cs_firewall.html#firewall_outbound)。此作業需要[管理者存取原則](cs_users.html#access_policies)。請驗證您的現行[存取原則](cs_users.html#infra_access)。

<br />



## 使用 SSH 存取工作者節點失敗
{: #cs_ssh_worker}

{: tsSymptoms}
您無法使用 SSH 連線來存取工作者節點。

{: tsCauses}
工作者節點上無法使用透過密碼的 SSH。

{: tsResolve}
針對您必須在每個節點上執行的動作使用 [DaemonSets ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/)，或針對您必須執行的一次性動作使用工作。

<br />


## 裸機實例 ID 與工作者節點記錄不一致
{: #bm_machine_id}

{: tsSymptoms}
使用 `ibmcloud ks worker` 指令與裸機工作者節點搭配時，您會看到與下列內容類似的訊息。

```
Instance ID inconsistent with worker records
```
{: screen}

{: tsCauses}
當機器遭遇硬體問題時，機器 ID 可能變成與 {{site.data.keyword.containerlong_notm}} 工作者節點記錄不一致。當 IBM Cloud 基礎架構 (SoftLayer) 解決此問題時，元件可在服務未識別的系統內變更。

{: tsResolve}
若要讓 {{site.data.keyword.containerlong_notm}} 重新識別機器，請[重新載入裸機工作者節點](cs_cli_reference.html#cs_worker_reload)。**附註**：重新載入也會更新機器的[修補程式版本](cs_versions_changelog.html)。

您也可以 [刪除裸機工作者節點](cs_cli_reference.html#cs_cluster_rm)。**附註**：裸機實例按月計費。

<br />


## `kubectl` 指令逾時
{: #exec_logs_fail}

{: tsSymptoms}
如果您執行 `kubectl exec`、`kubectl attach`、`kubectl proxy`、`kubectl port-forward` 或 `kubectl logs` 這類指令，則會看到下列訊息。

  ```
  <workerIP>:10250: getsockopt: connection timed out
  ```
  {: screen}

{: tsCauses}
主節點與工作者節點之間的 OpenVPN 連線未正常運作。

{: tsResolve}
1. 如果您的叢集有多個 VLAN、同一個 VLAN 上有多個子網路，或有多區域叢集，則必須為您的 IBM Cloud 基礎架構 (SoftLayer) 帳戶啟用 [VLAN Spanning](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning)，讓工作者節點可以在專用網路上彼此通訊。若要執行此動作，您需要**網路 > 管理網路 VLAN Spanning** [基礎架構許可權](cs_users.html#infra_access)，或者您可以要求帳戶擁有者啟用它。若要確認是否已啟用 VLAN Spanning，請使用 `ibmcloud ks vlan-spanning-get` [指令](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get)。如果您使用 {{site.data.keyword.BluDirectLink}}，則必須改為使用[虛擬路由器功能 (VRF)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf)。若要啟用 VRF，請聯絡 IBM Cloud 基礎架構 (SoftLayer) 業務代表。
2. 重新啟動 OpenVPN 用戶端 Pod。
  ```
  kubectl delete pod -n kube-system -l app=vpn
  ```
  {: pre}
3. 如果您仍看到相同的錯誤訊息，則 VPN Pod 所在的工作者節點可能性能不佳。若要重新啟動 VPN Pod 並將它排定到不同的工作者節點，[請隔離、排除及重新啟動工作者節點](cs_cli_reference.html#cs_worker_reboot)，而 VPN Pod 位於該工作者節點上。

<br />


## 將服務連結至叢集導致相同名稱錯誤
{: #cs_duplicate_services}

{: tsSymptoms}
當您執行 `ibmcloud ks cluster-service-bind <cluster_name> <namespace> <service_instance_name>` 時，會看到下列訊息。

```
Multiple services with the same name were found.
Run 'ibmcloud service list' to view available Bluemix service instances...
```
{: screen}

{: tsCauses}
多個服務實例可能在不同的地區中具有相同的名稱。

{: tsResolve}
請在 `ibmcloud ks cluster-service-bind` 指令中使用服務 GUID，而不要使用服務實例名稱。

1. [登入包含要連結之服務實例的地區。](cs_regions.html#bluemix_regions)

2. 取得服務實例的 GUID。
  ```
  ibmcloud service show <service_instance_name> --guid
  ```
  {: pre}

  輸出：
  ```
  Invoking 'cf service <service_instance_name> --guid'...
  <service_instance_GUID>
  ```
  {: screen}
3. 再次將服務連結至叢集。
  ```
  ibmcloud ks cluster-service-bind <cluster_name> <namespace> <service_instance_GUID>
  ```
  {: pre}

<br />


## 將服務連結至叢集導致「找不到服務」錯誤
{: #cs_not_found_services}

{: tsSymptoms}
當您執行 `ibmcloud ks cluster-service-bind <cluster_name> <namespace> <service_instance_name>` 時，會看到下列訊息。

```
Binding service to a namespace...
FAILED

The specified IBM Cloud service could not be found. If you just created the service, wait a little and then try to bind it again. To view available IBM Cloud service instances, run 'ibmcloud service list'. (E0023)
```
{: screen}

{: tsCauses}
若要將服務連結至叢集，您必須具有佈建服務實例之空間的 Cloud Foundry 開發人員使用者角色。此外，您還必須具有 {{site.data.keyword.containerlong}} 的「IAM 編輯者」存取權。若要存取服務實例，您必須登入佈建服務實例的空間。

{: tsResolve}

**身為使用者：**

1. 登入 {{site.data.keyword.Bluemix_notm}}。
   ```
ibmcloud login
```
   {: pre}

2. 將佈建服務實例的組織及空間設為目標。
   ```
   ibmcloud target -o <org> -s <space>
   ```
   {: pre}

3. 列出您的服務實例，驗證您位在正確的空間中。
   ```
   ibmcloud service list
   ```
   {: pre}

4. 嘗試重新連結服務。如果您收到相同的錯誤，則請聯絡帳戶管理者，並驗證您有足夠的許可權可連結服務（請參閱下列帳戶管理者步驟）。

**身為帳戶管理者：**

1. 驗證發生此問題的使用者具有 [{{site.data.keyword.containerlong}} 的編輯者許可權](/docs/iam/mngiam.html#editing-existing-access)。

2. 驗證發生此問題的使用者具有佈建服務之[空間的 Cloud Foundry 開發人員角色](/docs/iam/mngcf.html#updating-cloud-foundry-access)。

3. 如果有正確的許可權，則請嘗試指派不同的許可權，然後重新指派必要的許可權。

4. 等待幾分鐘，然後讓使用者嘗試重新連結服務。

5. 如果這樣做無法解決問題，則 IAM 許可權會不同步，且您無法自行解決問題。開立支援問題單，以[與 IBM 支援中心聯絡](/docs/get-support/howtogetsupport.html#getting-customer-support)。請務必提供叢集 ID、使用者 ID 及服務實例 ID。
   1. 擷取叢集 ID。
      ```
      ibmcloud ks clusters
      ```
      {: pre}

   2. 擷取服務實例 ID。
      ```
      ibmcloud service show <service_name> --guid
      ```
      {: pre}


<br />


## 將服務連結至叢集導致服務不支援服務金鑰錯誤
{: #cs_service_keys}

{: tsSymptoms}
當您執行 `ibmcloud ks cluster-service-bind <cluster_name> <namespace> <service_instance_name>` 時，會看到下列訊息。

```
This service doesn't support creation of keys
```
{: screen}

{: tsCauses}
{{site.data.keyword.Bluemix_notm}} 中的部分服務（例如 {{site.data.keyword.keymanagementservicelong}}）不支援建立服務認證（也稱為服務金鑰）。如果不支援服務金鑰，則服務無法連結至叢集。若要尋找支援建立服務金鑰的服務清單，請參閱[啟用外部應用程式以使用 {{site.data.keyword.Bluemix_notm}} 服務](/docs/apps/reqnsi.html#accser_external)。

{: tsResolve}
若要整合不支援服務金鑰的服務，請確認服務是否提供您可用來從應用程式直接存取服務的 API。例如，如果您要使用 {{site.data.keyword.keymanagementservicelong}}，請參閱 [API 參考資料 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://console.bluemix.net/apidocs/kms?language=curl)。 

<br />


## 工作者節點更新或重新載入之後，出現重複的節點及 Pod
{: #cs_duplicate_nodes}

{: tsSymptoms}
當您執行 `kubectl get nodes` 時，會看到重複的工作者節點，並顯示狀態 **NotReady**。具有 **NotReady** 的工作者節點具有公用 IP 位址，而具有 **Ready** 的工作者節點則具有專用 IP 位址。

{: tsCauses}
較舊的叢集會依叢集的公用 IP 位址列出工作者節點。現在，工作者節點會依叢集的專用 IP 位址列出。當您重新載入或更新節點時，IP 位址會變更，但對公用 IP 位址的參照則照舊。

{: tsResolve}
不會因這些重複項目而中斷服務，但您可以從 API 伺服器移除舊的工作者節點參照。

  ```
  kubectl delete node <node_name1> <node_name2>
  ```
  {: pre}

<br />


## 在新工作者節點上存取 Pod 因逾時而失敗
{: #cs_nodes_duplicate_ip}

{: tsSymptoms}
您已刪除叢集裡的工作者節點，然後新增工作者節點。若您已部署 Pod 或 Kubernetes 服務，資源即無法存取新建立的工作者節點，且連線逾時。

{: tsCauses}
如果您從叢集裡刪除工作者節點，然後新增工作者節點，則可能會將已刪除工作者節點的專用 IP 位址指派給新的工作者節點。Calico 使用此專用 IP 位址作為標籤，並繼續嘗試聯繫已刪除的節點。

{: tsResolve}
手動更新專用 IP 位址的參照，以指向正確的節點。

1.  確認您有兩個具有相同**專用 IP** 位址的工作者節點。請記下已刪除之工作者節點的**專用 IP** 及 **ID**。

  ```
  ibmcloud ks workers <CLUSTER_NAME>
  ```
  {: pre}

  ```
  ID                                                 Public IP       Private IP       Machine Type   State     Status   Zone   Version
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w1   169.xx.xxx.xxx  10.xxx.xx.xxx    b2c.4x16       normal    Ready    dal10      1.10.7
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w2   169.xx.xxx.xxx  10.xxx.xx.xxx    b2c.4x16       deleted    -       dal10      1.10.7
  ```
  {: screen}

2.  安裝 [Calico CLI](cs_network_policy.html#adding_network_policies)。
3.  列出 Calico 中的可用工作者節點。請將 <path_to_file> 取代為 Calico 配置檔的本端路徑。

  ```
  calicoctl get nodes --config=filepath/calicoctl.cfg
  ```
  {: pre}

  ```
  NAME
  kube-dal10-cr9b7371a7faaa46d08e04f046d5e6d8b4-w1
  kube-dal10-cr9b7371a7faaa46d08e04f046d5e6d8b4-w2
  ```
  {: screen}

4.  刪除 Calico 中的重複工作者節點。請將 NODE_ID 取代為工作者節點 ID。

  ```
  calicoctl delete node NODE_ID --config=<path_to_file>/calicoctl.cfg
  ```
  {: pre}

5.  將未刪除的工作者節點重新開機。

  ```
  ibmcloud ks worker-reboot CLUSTER_ID NODE_ID
  ```
  {: pre}


已刪除的節點不再列於 Calico 中。

<br />




## 因為 Pod 安全原則，Pod 無法部署
{: #cs_psp}

{: tsSymptoms}
在建立 Pod 或執行 `kubectl get events` 來檢查 Pod 部署之後，您會看到與下列內容類似的錯誤訊息。

```
unable to validate against any pod security policy
```
{: screen}

{: tsCauses}
[`PodSecurityPolicy` 許可控制器](cs_psp.html)會檢查嘗試建立 Pod 之使用者或服務帳戶的授權，例如部署或 Helm tiller。如果沒有 Pod 安全原則支援使用者或服務帳戶，`PodSecurityPolicy` 許可控制器會阻止建立 Pod。

如果您已刪除 [{{site.data.keyword.IBM_notm}} 叢集管理](cs_psp.html#ibm_psp)的其中一個 Pod 安全原則資源，則可能遭遇類似問題。

{: tsResolve}
確定使用者或服務帳戶已獲得 Pod 安全原則授權。您可能需要[修改現有原則](cs_psp.html#customize_psp)。

如果您已刪除 {{site.data.keyword.IBM_notm}} 叢集管理資源，請重新整理 Kubernetes 主節點來還原它。

1.  [將 CLI 的目標設為](cs_cli_install.html#cs_cli_configure)您的叢集。
2.  重新整理 Kubernetes 主節點來還原它。

    ```
    ibmcloud ks apiserver-refresh
    ```
    {: pre}


<br />




## 叢集保持在擱置狀況
{: #cs_cluster_pending}

{: tsSymptoms}
當您部署叢集時，它保持在擱置狀況，且未啟動。

{: tsCauses}
如果您才剛建立叢集，則可能仍在配置工作者節點。如果您已等待一段時間，則可能會有無效的 VLAN。

{: tsResolve}

您可以嘗試下列其中一種解決方案：
  - 執行 `ibmcloud ks clusters`，來檢查叢集的狀態。然後，執行 `ibmcloud ks workers <cluster_name>`，來檢查並確定已部署工作者節點。
  - 查看您的 VLAN 是否有效。VLAN 若要有效，則必須與基礎架構相關聯，且該基礎架構可以管理具有本端磁碟儲存空間的工作者節點。您可以執行 `ibmcloud ks vlans <zone>` 來[列出 VLAN](/docs/containers/cs_cli_reference.html#cs_vlans)，如果 VLAN 未顯示在清單中，則它是無效的。請選擇其他 VLAN。

<br />


## Pod 保持擱置狀況
{: #cs_pods_pending}

{: tsSymptoms}
當您執行 `kubectl get pods` 時，可以看到保持 **Pending** 狀況的 Pod。

{: tsCauses}
如果您才剛剛建立 Kubernetes 叢集，則可能仍在配置工作者節點。 

如果此叢集是現有叢集，請執行下列動作：
*  您的叢集中可能沒有足夠的容量可部署 Pod。
*  Pod 可能已超出資源要求或限制。

{: tsResolve}
此作業需要[管理者存取原則](cs_users.html#access_policies)。請驗證您的現行[存取原則](cs_users.html#infra_access)。

如果您才剛剛建立 Kubernetes 叢集，請執行下列指令，並等待起始設定工作者節點。

```
kubectl get nodes
```
{: pre}

如果此叢集是現有叢集，請檢查叢集容量。

1.  使用預設埠號來設定 Proxy。

  ```
  kubectl proxy
  ```
   {: pre}

2.  開啟 Kubernetes 儀表板。

  ```
  http://localhost:8001/ui
  ```
  {: pre}

3.  確認您的叢集裡是否有足夠的容量可部署 Pod。

4.  如果您的叢集裡沒有足夠容量，請調整工作者節點儲存區的大小來新增更多的節點。

    1.  檢閱工作者節點儲存區的現行大小及機型，來決定要調整哪個工作者節點儲存區的大小。

        ```
        ibmcloud ks worker-pools
        ```
        {: pre}

    2.  調整工作者節點儲存區的大小，以將更多節點新增至儲存區跨越的每一個區域。

        ```
        ibmcloud ks worker-pool-resize <worker_pool> --cluster <cluster_name_or_ID> --size-per-zone <workers_per_zone>
        ```
        {: pre}

5.  選用項目：檢查您的 Pod 資源要求。

    1.  確認 `resources.requests` 值不大於工作者節點的容量。例如，如果 Pod 要求 `cpu: 4000m` 或 4 個核心，但工作者節點大小只有 2 個核心，則無法部署 Pod。

        ```
        kubectl get pod <pod_name> -o yaml
        ```
        {: pre}
    
    2.  如果要求超出可用的容量，則請[新增工作者節點儲存區](cs_clusters.html#add_pool)，而其具有可滿足要求的工作者節點。

6.  如果您的 Pod 在工作者節點完整部署之後仍然保持 **pending** 狀況，請檢閱 [Kubernetes 文件 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/tasks/debug-application-cluster/debug-pod-replication-controller/#my-pod-stays-pending)，以進一步對 Pod 的擱置中狀況進行疑難排解。

<br />


## 容器未啟動
{: #containers_do_not_start}

{: tsSymptoms}
Pod 順利部署至叢集，但容器未啟動。

{: tsCauses}
在達到登錄配額時，容器可能無法啟動。

{: tsResolve}
[請釋放 {{site.data.keyword.registryshort_notm}} 中的儲存空間。](../services/Registry/registry_quota.html#registry_quota_freeup)



<br />


## 無法安裝具有已更新配置值的 Helm 圖表
{: #cs_helm_install}

{: tsSymptoms}
當您嘗試執行 `helm install -f config.yaml --namespace=kube-system --name=<release_name> ibm/<chart_name>` 來安裝已更新的 Helm 圖表時，您看到 `Error: failed to download "ibm/<chart_name>"` 錯誤訊息。

{: tsCauses}
在 Helm 實例中，{{site.data.keyword.Bluemix_notm}} 儲存庫的 URL 可能不正確。

{: tsResolve}
若要對 Helm 圖表進行疑難排解，請執行下列動作：

1. 列出 Helm 實例中目前可用的儲存庫。

    ```
    helm repo list
    ```
    {: pre}

2. 在輸出中，驗證 {{site.data.keyword.Bluemix_notm}} 儲存庫 `ibm` 的 URL 為 `https://registry.bluemix.net/helm/ibm`。

    ```
    NAME    URL
    stable  https://kubernetes-charts.storage.googleapis.com
    local   http://127.0.0.1:8888/charts
    ibm     https://registry.bluemix.net/helm/ibm
    ```
    {: screen}

    * 如果 URL 不正確，請執行下列動作：

        1. 移除 {{site.data.keyword.Bluemix_notm}} 儲存庫。

            ```
            helm repo remove ibm
            ```
            {: pre}

        2. 再次新增 {{site.data.keyword.Bluemix_notm}} 儲存庫。

            ```
            helm repo add ibm  https://registry.bluemix.net/helm/ibm
            ```
            {: pre}

    * 如果 URL 正確無誤，則從儲存庫取得最新的更新。

        ```
        helm repo update
        ```
        {: pre}

3. 安裝含有更新的 Helm 圖表。

    ```
    helm install -f config.yaml --namespace=kube-system --name=<release_name> ibm/<chart_name>
    ```
    {: pre}

<br />


## 取得協助及支援
{: #ts_getting_help}

叢集仍有問題？
{: shortdesc}

-  在終端機中，有 `ibmcloud` CLI 及外掛程式的更新可用時，就會通知您。請務必保持最新的 CLI，讓您可以使用所有可用的指令及旗標。

-   若要查看 {{site.data.keyword.Bluemix_notm}} 是否可用，請[檢查 {{site.data.keyword.Bluemix_notm}} 狀態頁面 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://developer.ibm.com/bluemix/support/#status)。
-   將問題張貼到 [{{site.data.keyword.containerlong_notm}} Slack ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://ibm-container-service.slack.com)。

    如果您的 {{site.data.keyword.Bluemix_notm}} 帳戶未使用 IBM ID，請[要求邀請](https://bxcs-slack-invite.mybluemix.net/)以加入此 Slack。
    {: tip}
-   檢閱討論區，以查看其他使用者是否發生過相同的問題。使用討論區提問時，請標記您的問題，以便 {{site.data.keyword.Bluemix_notm}} 開發團隊能看到它。

    -   如果您在使用 {{site.data.keyword.containerlong_notm}} 開發或部署叢集或應用程式時有技術方面的問題，請將問題張貼到 [Stack Overflow ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://stackoverflow.com/questions/tagged/ibm-cloud+containers)，並使用 `ibm-cloud`、`kubernetes` 及 `containers` 來標記問題。
    -   若為服務及開始使用指示的相關問題，請使用 [IBM Developer Answers ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://developer.ibm.com/answers/topics/containers/?smartspace=bluemix) 討論區。請包含 `ibm-cloud` 及 `containers` 標籤。如需使用討論區的詳細資料，請參閱[取得協助](/docs/get-support/howtogetsupport.html#using-avatar)。

-   開立問題單以與 IBM 支援中心聯絡。若要瞭解開立 IBM 支援問題單或是支援層次與問題單嚴重性，請參閱[與支援中心聯絡](/docs/get-support/howtogetsupport.html#getting-customer-support)。

{: tip}
當您報告問題時，請包含您的叢集 ID。若要取得叢集 ID，請執行 `ibmcloud ks clusters`。

