---

copyright:
  years: 2014, 2018
lastupdated: "2018-03-06"


---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# 指派對叢集的使用者存取
{: #users}

您可以授與 Kubernetes 叢集的存取權，以確保只有獲授權的使用者才能使用該叢集，並將容器部署至 {{site.data.keyword.containerlong}} 中的叢集。
{:shortdesc}


## 規劃通訊處理程序
身為叢集管理者，請考量如何建立一個通訊處理程序，讓組織的成員能夠向您傳送存取要求，而您能夠維持井然有序。
{:shortdesc}

請指示叢集使用者如何要求對叢集的存取權，或如何向叢集管理者取得任何類型一般作業的協助。因為 Kubernetes 不協助這種通訊，所以每一個團隊在其偏好的處理程序可能會有不同。

您可以選擇下列任何方法，或建立您自己的方法。
- 建立問題單系統
- 建立表單範本
- 建立 Wiki 頁面
- 需要電子郵件要求
- 使用您已在使用的問題追蹤方法，來追蹤團隊的日常工作


## 管理叢集存取
{: #managing}

每位使用 {{site.data.keyword.containershort_notm}} 的使用者都必須獲指派服務特定使用者角色的組合，以決定使用者可以執行的動作。
{:shortdesc}

<dl>
<dt>{{site.data.keyword.containershort_notm}} 存取原則</dt>
<dd>在「身分及存取管理」中，{{site.data.keyword.containershort_notm}} 存取原則決定了您可對叢集執行的叢集管理動作，例如，建立或移除叢集，以及新增或移除額外的工作者節點。這些原則必須與基礎架構原則一起設定。您可以用地區為基準來授與對叢集的存取權。</dd>
<dt>基礎架構存取原則</dt>
<dd>在「身分及存取管理」中，基礎架構存取原則容許在 IBM Cloud 基礎架構 (SoftLayer) 中完成從 {{site.data.keyword.containershort_notm}} 使用者介面或 CLI 所要求的動作。這些原則必須與 {{site.data.keyword.containershort_notm}} 存取原則一起設定。[進一步瞭解可用的基礎架構角色](/docs/iam/infrastructureaccess.html#infrapermission)。</dd>
<dt>資源群組</dt>
<dd>資源群組是一種將 {{site.data.keyword.Bluemix_notm}} 服務組織成群組的方式，讓您可以一次快速地指派使用者對多個資源的存取權。[瞭解如何使用資源群組來管理使用者](/docs/account/resourcegroups.html#rgs)。</dd>
<dt>Cloud Foundry 角色</dt>
<dd>在「身分及存取管理」中，每位使用者都必須獲指派 Cloud Foundry 使用者角色。此角色決定了使用者可對 {{site.data.keyword.Bluemix_notm}} 帳戶執行的動作，例如，邀請其他使用者，或檢視配額用量。[進一步瞭解可用的 Cloud Foundry 角色](/docs/iam/cfaccess.html#cfaccess)。</dd>
<dt>Kubernetes RBAC 角色</dt>
<dd>每位獲指派 {{site.data.keyword.containershort_notm}} 存取原則的使用者都會自動獲指派 Kubernetes RBAC 角色。在 Kubernetes 中，RBAC 角色決定了您可對叢集內 Kubernetes 資源執行的動作。只有針對 default 名稱空間設定 RBAC 角色。叢集管理者可以為叢集中的其他名稱空間新增 RBAC 角色。請參閱[存取原則及許可權](#access_policies)小節中的下列表格，以查看哪個 RBAC 角色對應於哪個 {{site.data.keyword.containershort_notm}} 存取原則。如需一般 RBAC 角色的相關資訊，請參閱 Kubernetes 文件中的[使用 RBAC 授權 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/admin/authorization/rbac/#api-overview)。</dd>
</dl>

<br />


## 存取原則及許可權
{: #access_policies}

檢閱您可以授與 {{site.data.keyword.Bluemix_notm}} 帳戶中使用者的存取原則及許可權。
{:shortdesc}

{{site.data.keyword.Bluemix_notm}} 身分存取及管理 (IAM) 操作員和編輯者角色具有不同的許可權。例如，如果您想要使用者新增工作者節點及連結服務，則您必須同時將操作員及編輯者角色指派給使用者。如需對應的基礎架構存取原則的詳細資料，請參閱[自訂使用者的基礎架構許可權](#infra_access)。<br/><br/>如果您變更使用者的存取原則，則會為您清除與叢集中的變更相關聯的 RBAC 原則。</br></br>**附註：**當您降級許可權時（例如，您要將檢視者存取權指派給前任叢集管理者），必須等待幾分鐘，才能完成降級。

|{{site.data.keyword.containershort_notm}} 存取原則|叢集管理許可權|Kubernetes 資源許可權|
|-------------|------------------------------|-------------------------------|
|管理者|此角色會繼承此帳戶中所有叢集的「編輯者」、「操作員」及「檢視者」角色的許可權。<br/><br/>針對所有現行服務實例設定時：<ul><li>建立免費或標準叢集</li><li>設定 {{site.data.keyword.Bluemix_notm}} 帳戶的認證，以存取 IBM Cloud 基礎架構 (SoftLayer) 組合</li><li>移除叢集</li><li>指派及變更此帳戶中其他現有使用者的 {{site.data.keyword.containershort_notm}} 存取原則。</li></ul><p>針對特定叢集 ID 設定時：<ul><li>移除特定叢集</li></ul></p>對應的基礎架構存取原則：超級使用者<br/><br/><strong>附註</strong>：若要建立機器、VLAN 及子網路這類資源，使用者需要**超級使用者**基礎架構角色。|<ul><li>RBAC 角色：cluster-admin</li><li>每個名稱空間中資源的讀寫存取</li><li>建立名稱空間內的角色</li><li>存取 Kubernetes 儀表板</li><li>建立 Ingress 資源，使應用程式公開可用</li></ul>|
|操作員|<ul><li>將其他工作者節點新增至叢集</li><li>移除叢集中的工作者節點</li><li>重新啟動工作者節點</li><li>重新載入工作者節點</li><li>將子網路新增至叢集</li></ul><p>對應的基礎架構存取原則：[自訂](#infra_access)</p>|<ul><li>RBAC 角色：admin</li><li>讀寫存取 default 名稱空間內的資源，但不會讀寫存取名稱空間本身</li><li>建立名稱空間內的角色</li></ul>|
|編輯者 <br/><br/><strong>提示</strong>：請對應用程式開發人員使用此角色。|<ul><li>將 {{site.data.keyword.Bluemix_notm}} 服務連結至叢集。</li><li>取消 {{site.data.keyword.Bluemix_notm}} 服務與叢集的連結。</li><li>建立 Webhook。</li></ul><p>對應的基礎架構存取原則：[自訂](#infra_access)|<ul><li>RBAC 角色：edit</li><li>default 名稱空間內資源的讀寫存取</li></ul></p>|
|檢視者|<ul><li>列出叢集</li><li>檢視叢集的詳細資料</li></ul><p>對應的基礎架構存取原則：僅限檢視</p>|<ul><li>RBAC 角色：view</li><li>default 名稱空間內資源的讀取權</li><li>沒有 Kubernetes 密碼的讀取權</li></ul>|

|Cloud Foundry 存取原則|帳戶管理許可權|
|-------------|------------------------------|
|組織角色：管理員|<ul><li>將其他使用者新增至 {{site.data.keyword.Bluemix_notm}} 帳戶</li></ul>| |
|空間角色：開發人員|<ul><li>建立 {{site.data.keyword.Bluemix_notm}} 服務實例</li><li>將 {{site.data.keyword.Bluemix_notm}} 服務實例連結至叢集</li></ul>| 

<br />



## 瞭解 IAM API 金鑰及 `bx cs credentials-set` 指令
{: #api_key}

若要順利在帳戶中佈建及使用叢集，您必須確定您的帳戶已正確設定，以存取 IBM Cloud 基礎架構 (SoftLayer) 組合。根據您的帳戶設定，您可以使用 IAM API 金鑰或使用 `bx cs credentials-set` 指令手動設定的基礎架構認證。

<dl>
  <dt>IAM API 金鑰</dt>
  <dd>當執行第一個需要 {{site.data.keyword.containershort_notm}} 管理存取原則的動作時，會針對地區自動設定「身分及存取管理 (IAM)」API 金鑰。例如，其中一位管理使用者會在 <code>us-south</code> 地區中建立第一個叢集。如此一來，這位使用者的 IAM API 金鑰就會儲存在這個地區的帳戶中。API 金鑰會用來訂購 IBM Cloud 基礎架構 (SoftLayer)，例如新的工作者節點或 VLAN。</br></br>
當另一位使用者在此地區中執行需要與 IBM Cloud 基礎架構 (SoftLayer) 組合互動的動作（例如建立新叢集或重新載入工作者節點）時，會使用儲存的 API 金鑰來判斷是否有足夠的許可權可執行該動作。為了確保可以順利執行叢集中的基礎架構相關動作，請對 {{site.data.keyword.containershort_notm}} 管理使用者指派<strong>超級使用者</strong>基礎架構存取原則。</br></br>您可以執行 [<code>bx cs api-key-info</code>](cs_cli_reference.html#cs_api_key_info) 來尋找現行 API 金鑰擁有者。如果您發現需要更新針對某地區所儲存的 API 金鑰，您可以執行 [<code>bx cs api-key-reset</code>](cs_cli_reference.html#cs_api_key_reset) 指令來達成此目的。此指令需要 {{site.data.keyword.containershort_notm}} 管理存取原則，它會將執行此指令的使用者的 API 金鑰儲存在帳戶中。</br></br> <strong>附註：</strong>如果 IBM Cloud 基礎架構 (SoftLayer) 認證是使用 <code>bx cs credentials-set</code> 指令手動設定的，則可能不會使用針對該地區所儲存的 API 金鑰。</dd>
<dt>透過 <code>bx cs credentials-set</code> 設定的 IBM Cloud infrastructure (SoftLayer) 認證</dt>
<dd>如果您有 {{site.data.keyword.Bluemix_notm}}「隨收隨付制」帳戶，依預設，您便可以存取 IBM Cloud 基礎架構 (SoftLayer) 組合。不過，建議您使用您已具有的不同 IBM Cloud 基礎架構 (SoftLayer) 帳戶來訂購基礎架構。您可以使用 [<code>bx cs credentials-set</code>](cs_cli_reference.html#cs_credentials_set) 指令，將此基礎架構帳戶鏈結至 {{site.data.keyword.Bluemix_notm}} 帳戶。</br></br>如果手動設定了 IBM Cloud 基礎架構 (SoftLayer) 認證，則即使帳戶已有 IAM API 金鑰存在，也會使用這些認證來訂購基礎架構。如果已儲存其認證的使用者沒有訂購基礎架構的必要許可權，則基礎架構相關動作（例如建立叢集或重新載入工作者節點）可能會失敗。</br></br> 若要移除手動設定的 IBM Cloud 基礎架構 (SoftLayer) 認證，您可以使用 [<code>bx cs credentials-unset</code>](cs_cli_reference.html#cs_credentials_unset) 指令。移除認證之後，會使用 IAM API 金鑰來訂購基礎架構。</dd>
</dl>

## 將使用者新增至 {{site.data.keyword.Bluemix_notm}} 帳戶
{: #add_users}

您可以將使用者新增至 {{site.data.keyword.Bluemix_notm}} 帳戶，以授與對叢集的存取權。
{:shortdesc}

開始之前，請驗證您已獲指派 {{site.data.keyword.Bluemix_notm}} 帳戶的「管理員」Cloud Foundry 角色。

1.  [將使用者新增至帳戶](../iam/iamuserinv.html#iamuserinv)。
2.  在**存取**區段中，展開**服務**。
3.  指派 {{site.data.keyword.containershort_notm}} 存取角色。從**指派存取權**下拉清單中，決定您只要將存取權授與 {{site.data.keyword.containershort_notm}} 帳戶（**資源**），還是授與您帳戶內各種資源的集合（**資源群組**）。
  -  對於**資源**：
      1. 從**服務**下拉清單中，選取 **{{site.data.keyword.containershort_notm}}**。
      2. 從**地區**下拉清單中，選取要邀請使用者加入的地區。**附註**：如需對[亞太地區北部](cs_regions.html#locations)的叢集的存取權，請參閱[將對於亞太地區北部內的叢集的 IAM 存取權授與使用者](#iam_cluster_region)。
      3. 從**服務實例**下拉清單中，選取要邀請使用者加入的叢集。若要尋找特定叢集的 ID，請執行 `bx cs clusters`。
      4. 在**選取角色**區段中，選擇角色。若要尋找每個角色的支援動作清單，請參閱[存取原則及許可權](#access_policies)。
  - 對於**資源群組**：
      1. 從**資源群組**下拉清單中，選取包括您帳戶之 {{site.data.keyword.containershort_notm}} 資源許可權的資源群組。
      2. 從**指派對資源群組的存取權**下拉清單中，選取角色。若要尋找每個角色的支援動作清單，請參閱[存取原則及許可權](#access_policies)。
4. [選用項目：指派 Cloud Foundry 角色](/docs/iam/mngcf.html#mngcf)。
5. [選用項目：指派基礎架構角色](/docs/iam/infrastructureaccess.html#infrapermission)。
6. 按一下**邀請使用者**。

<br />


### 將對於亞太地區北部內的叢集的 IAM 存取權授與使用者
{: #iam_cluster_region}

當您[將使用者新增至 {{site.data.keyword.Bluemix_notm}} 帳戶](#add_users)時，要選取他們被授與存取權的地區。不過，部分地區（例如亞太地區北部）可能沒有出現在主控台中，您必須使用 CLI 予以新增。
{:shortdesc}

開始之前，請驗證您是 {{site.data.keyword.Bluemix_notm}} 帳戶的管理者。

1.  登入 {{site.data.keyword.Bluemix_notm}} CLI。選取您要使用的帳戶。

    ```
    bx login [--sso]
    ```
    {: pre}

    **附註：**如果您具有聯合 ID，請使用 `bx login --sso` 來登入 {{site.data.keyword.Bluemix_notm}} CLI。請輸入使用者名稱，並使用 CLI 輸出中提供的 URL 來擷取一次性密碼。若沒有 `--sso` 時登入失敗，而有 `--sso` 選項時登入成功，即表示您有聯合 ID。

2.  將您要授與許可權的環境設為目標，例如亞太地區北部 (`jp-tok`)。如需有關指令選項（例如組織及空間）的詳細資料，請參閱 [`bluemix target` 指令](../cli/reference/bluemix_cli/bx_cli.html#bluemix_target)。

    ```
    bx target -r jp-tok
    ```
    {: pre}

3.  取得您要授與存取權之地區的叢集名稱或 ID。

    ```
    bx cs clusters
    ```
    {: pre}

4.  取得您要授與存取權的使用者 ID。

    ```
    bx account users
    ```
    {: pre}

5.  選取存取原則的角色。

    ```
    bx iam roles --service containers-kubernetes
    ```
    {: pre}

6.  以適當的角色授權使用者對叢集的存取權。此範例將對於三個叢集的 `Operator` 及 `Editor` 角色指派給 `user@example.com`。

    ```
    bx iam user-policy-create user@example.com --roles Operator,Editor --service-name containers-kubernetes --region jp-tok --service-instance cluster1,cluster2,cluster3
    ```
    {: pre}

    若要授與地區中現有及未來叢集的存取權，請不要指定 `--service-instance` 旗標。如需相關資訊，請參閱 [`bluemix iam user-policy-create` 指令](../cli/reference/bluemix_cli/bx_cli.html#bluemix_iam_user_policy_create)。
    {:tip}

## 自訂使用者的基礎架構許可權
{: #infra_access}

當您在「身分及存取管理」中設定基礎架構原則時，使用者會獲得與角色相關聯的許可權。若要自訂這些許可權，您必須登入 IBM Cloud 基礎架構 (SoftLayer)，並在該處調整許可權。
{: #view_access}

例如，**基本使用者**可以重新啟動工作者節點，但無法重新載入工作者節點。不必授與該人員**超級使用者**許可權，您可以調整 IBM Cloud 基礎架構 (SoftLayer) 許可權，並新增許可權來執行重新載入指令。

1.  登入 [{{site.data.keyword.Bluemix_notm}}帳戶](https://console.bluemix.net/)，然後從功能表中選取**基礎架構**。

2.  移至**帳戶** > **使用者** > **使用者清單**。

3.  若要修改許可權，請選取使用者設定檔的名稱或**裝置存取權**直欄。

4.  在**入口網站許可權**標籤中，自訂使用者的存取權。使用者需要的許可權，取決於他們需要使用的基礎架構資源：

    * 請使用**快速許可權**下拉清單來指派**超級使用者**角色，這會提供使用者所有許可權。
    * 請使用**快速許可權**下拉清單來指派**基本使用者**角色，這會提供使用者部分（但非全部）需要的許可權。
    * 如果您不要使用**超級使用者**角色來授與所有許可權，或需要新增**基本使用者**角色以外的許可權，請檢閱下表，其中會說明在 {{site.data.keyword.containershort_notm}} 中執行一般作業所需的許可權。

    <table summary="一般 {{site.data.keyword.containershort_notm}} 情境的基礎架構許可權。">
     <caption>{{site.data.keyword.containershort_notm}} 一般需要的基礎架構許可權</caption>
     <thead>
     <th>{{site.data.keyword.containershort_notm}} 的一般作業</th>
     <th>依標籤列出必要的基礎架構許可權</th>
     </thead>
     <tbody>
     <tr>
     <td><strong>最少許可權</strong>：<ul><li>建立叢集。</li></ul></td>
     <td><strong>裝置</strong>：<ul><li>檢視虛擬伺服器詳細資料</li><li>重新啟動伺服器並檢視 IPMI 系統資訊</li><li>發出 OS 重新載入及起始救援核心</li></ul><strong>帳戶</strong>：<ul><li>新增/升級雲端實例</li><li>新增伺服器</li></ul></td>
     </tr>
     <tr>
     <td><strong>叢集管理</strong>：<ul><li>建立、更新及刪除叢集。</li><li>新增、重新載入及重新啟動工作者節點。</li><li>檢視 VLAN。</li><li>建立子網路。</li><li>部署 Pod 及負載平衡器服務。</li></ul></td>
     <td><strong>支援</strong>：<ul><li>檢視問題單</li><li>新增問題單</li><li>編輯問題單</li></ul>
     <strong>裝置</strong>：<ul><li>檢視虛擬伺服器詳細資料</li><li>重新啟動伺服器並檢視 IPMI 系統資訊</li><li>升級伺服器</li><li>發出 OS 重新載入及起始救援核心</li></ul>
     <strong>服務</strong>：<ul><li>管理 SSH 金鑰</li></ul>
     <strong>帳戶</strong>：<ul><li>檢視帳戶摘要</li><li>新增/升級雲端實例</li><li>取消伺服器</li><li>新增伺服器</li></ul></td>
     </tr>
     <tr>
     <td><strong>儲存空間</strong>：<ul><li>建立持續性磁區宣告，以佈建持續性磁區。</li><li>建立及管理儲存空間基礎架構資源。</li></ul></td>
     <td><strong>服務</strong>：<ul><li>管理儲存空間</li></ul><strong>帳戶</strong>：<ul><li>新增儲存空間</li></ul></td>
     </tr>
     <tr>
     <td><strong>專用網路</strong>：<ul><li>管理專用 VLAN 來建立叢集內網路連線。</li><li>設定專用網路的 VPN 連線功能。</li></ul></td>
     <td><strong>網路</strong>：<ul><li>管理網路子網路路徑</li><li>管理網路 VLAN 跨越</li><li>管理 IPSEC 網路通道</li><li>管理網路閘道</li><li>VPN 管理</li></ul></td>
     </tr>
     <tr>
     <td><strong>公用網路</strong>：<ul><li>設定公用負載平衡器或 Ingress 網路來公開應用程式。</li></ul></td>
     <td><strong>裝置</strong>：<ul><li>管理負載平衡器</li><li>編輯主機名稱/網域</li><li>管理埠控制</li></ul>
     <strong>網路</strong>：<ul><li>新增運算與公用網路埠</li><li>管理網路子網路路徑</li><li>管理網路 VLAN 跨越</li><li>新增 IP 位址</li></ul>
     <strong>服務</strong>：<ul><li>管理 DNS、反向 DNS 及 WHOIS</li><li>檢視憑證 (SSL)</li><li>管理憑證 (SSL)</li></ul></td>
     </tr>
     </tbody></table>

5.  若要儲存您的變更，請按一下**編輯入口網站許可權**。

6.  在**裝置存取權**標籤中，選取要授與存取權的裝置。

    * 在**裝置類型**下拉清單中，您可以授與對**所有虛擬伺服器**的存取權。
    * 若要容許使用者存取所建立的新裝置，請勾選**新增裝置時自動授與存取權**。
    * 若要儲存您的變更，請按一下**更新裝置存取權**。

7.  回到使用者設定檔清單，並驗證已授與**裝置存取權**。

## 授權具有自訂 Kubernetes RBAC 角色的使用者
{: #rbac}

{{site.data.keyword.containershort_notm}} 存取原則對應於某些 Kubernetes 角色型存取控制 (RBAC) 角色，如[存取原則及許可權](#access_policies)所述。若要授權不同於對應存取原則的其他 Kubernetes 角色，您可以自訂 RBAC 角色，然後將角色指派給個人或使用者群組。
{: shortdesc}

例如，建議您授與許可權給開發人員團隊，以使用特定 API 群組或叢集中 Kubernetes 名稱空間內的資源，而不是整個叢集。您要使用對 {{site.data.keyword.containershort_notm}} 而言唯一的使用者名稱來建立角色，然後將角色連結至使用者。如需其他詳細資訊，請參閱 Kubernetes 文件中的[使用 RBAC 授權 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/admin/authorization/rbac/#api-overview)。

開始之前，請[將 Kubernetes CLI 的目標設為叢集](cs_cli_install.html#cs_cli_configure)。

1.  建立具有您要指派之存取權的角色。

    1. 建立 `.yaml` 檔案，以定義具有您要指派之存取權的角色。

        ```
        kind: Role
        apiVersion: rbac.authorization.k8s.io/v1
        metadata:
          namespace: default
          name: my_role
        rules:
        - apiGroups: [""]
          resources: ["pods"]
          verbs: ["get", "watch", "list"]
        - apiGroups: ["apps", "extensions"]
          resources: ["daemonsets", "deployments"]
          verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
        ```
        {: codeblock}

        <table>
        <caption>表.瞭解這個 YAML 元件</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="構想圖示"/>瞭解這個 YAML 元件</th>
        </thead>
        <tbody>
        <tr>
        <td><code>kind</code></td>
        <td>使用 `Role` 來授與對單一名稱空間內的資源的存取權，或使用 `ClusterRole` 來授與對全叢集的資源的存取權。</td>
        </tr>
        <tr>
        <td><code>apiVersion</code></td>
        <td><ul><li>對於執行 Kubernetes 1.8 或更新版本的叢集，請使用 `rbac.authorization.k8s.io/v1`。</li><li>對於較舊版本，請使用 `apiVersion: rbac.authorization.k8s.io/v1beta1`。</li></ul></td>
        </tr>
        <tr>
        <td><code>metadata/namespace</code></td>
        <td><ul><li>對於 `Role` 類型：指定授與對其存取權的 Kubernetes 名稱空間。</li><li>如果您要建立在叢集層次上套用的 `ClusterRole`，請不要使用 `namespace` 欄位。</li></ul></td>
        </tr>
        <tr>
        <td><code>metadata/name</code></td>
        <td>命名角色，並在稍後連結該角色時使用此名稱。</td>
        </tr>
        <tr>
        <td><code>rules/apiGroups</code></td>
        <td><ul><li>指定您要使用者能夠與其互動的 Kubernetes API 群組，例如 `"apps"`、`"batch"` 或 `"extensions"`。</li><li>若要存取位於 REST 路徑 `apiv1` 的核心 API 群組，請將群組保留空白：`[""]`。</li><li>如需相關資訊，請參閱 Kubernetes 文件中的 [API 群組 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/reference/api-overview/#api-groups)。</li></ul></td>
        </tr>
        <tr>
        <td><code>rules/resources</code></td>
        <td><ul><li>指定您要授與對其之存取權的 Kubernetes 資源，例如 `"daemonset"`、`"deployments"`、`"events"` 或 `"ingresses"`。</li><li>如果您指定 `"nodes"`，則角色類型必須是 `ClusterRole`。</li><li>如需資源清單，請參閱 Kubernetes 提要中的[資源類型 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/reference/kubectl/cheatsheet/) 表格。</li></ul></td>
        </tr>
        <tr>
        <td><code>rules/verbs</code></td>
        <td><ul><li>指定您要使用者能夠執行的動作類型，例如 `"get"`、`"list"`、`"describe"`、`"create"` 或 `"delete"`。</li><li>如需動詞的完整清單，請參閱 [`kubectl` 文件 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands)。</li></ul></td>
        </tr>
        </tbody>
        </table>

    2.  在叢集中建立角色。

        ```
        kubectl apply -f <path_to_yaml_file>
        ```
        {: pre}

    3.  驗證已建立角色。

        ```
        kubectl get roles
        ```
        {: pre}

2.  將使用者連結至角色。

    1. 建立 `.yaml` 檔案，將使用者連結至您的角色。請注意要用於每一個主題名稱的唯一 URL。

        ```
        kind: RoleBinding
        apiVersion: rbac.authorization.k8s.io/v1
        metadata:
          name: my_role_team1
          namespace: default
        subjects:
        - kind: User
          name: https://iam.ng.bluemix.net/kubernetes#user1@example.com
          apiGroup: rbac.authorization.k8s.io
        - kind: User
          name: https://iam.ng.bluemix.net/kubernetes#user2@example.com
          apiGroup: rbac.authorization.k8s.io
        roleRef:
          kind: Role
          name: custom-rbac-test
          apiGroup: rbac.authorization.k8s.io
        ```
        {: codeblock}

        <table>
        <caption>表.瞭解這個 YAML 元件</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="構想圖示"/>瞭解這個 YAML 元件</th>
        </thead>
        <tbody>
        <tr>
        <td><code>kind</code></td>
        <td>針對這兩種類型的角色 `.yaml` 檔案，將 `kind` 指定為 `RoleBinding`：名稱空間 `role` 及全叢集 `ClusterRole`。</td>
        </tr>
        <tr>
        <td><code>apiVersion</code></td>
        <td><ul><li>對於執行 Kubernetes 1.8 或更新版本的叢集，請使用 `rbac.authorization.k8s.io/v1`。</li><li>對於較舊版本，請使用 `apiVersion: rbac.authorization.k8s.io/v1beta1`。</li></ul></td>
        </tr>
        <tr>
        <td><code>metadata/namespace</code></td>
        <td><ul><li>對於 `Role` 類型：指定授與對其之存取權的 Kubernetes 名稱空間。</li><li>如果您要建立在叢集層次上套用的 `ClusterRole`，請不要使用 `namespace` 欄位。</li></ul></td>
        </tr>
        <tr>
        <td><code>metadata/name</code></td>
        <td>命名角色連結。</td>
        </tr>
        <tr>
        <td><code>subjects/kind</code></td>
        <td>將類型指定為 `User`。</td>
        </tr>
        <tr>
        <td><code>subjects/name</code></td>
        <td><ul><li>將使用者的電子郵件位址附加到下列 URL 後面：`https://iam.ng.bluemix.net/kubernetes#`。</li><li>例如，`https://iam.ng.bluemix.net/kubernetes#user1@example.com`</li></ul></td>
        </tr>
        <tr>
        <td><code>subjects/apiGroup</code></td>
        <td>使用 `rbac.authorization.k8s.io`。</td>
        </tr>
        <tr>
        <td><code>roleRef/kind</code></td>
        <td>在角色 `.yaml` 檔案中輸入與 `kind` 相同的值：`Role` 或 `ClusterRole`。</td>
        </tr>
        <tr>
        <td><code>roleRef/name</code></td>
        <td>輸入角色 `.yaml` 檔案的名稱。</td>
        </tr>
        <tr>
        <td><code>roleRef/apiGroup</code></td>
        <td>使用 `rbac.authorization.k8s.io`。</td>
        </tr>
        </tbody>
        </table>

    2. 在叢集中建立角色連結資源。

        ```
        kubectl apply -f <path_to_yaml_file>
        ```
        {: pre}

    3.  驗證已建立連結。

        ```
        kubectl get rolebinding
        ```
        {: pre}

既然您已建立並連結自訂 Kubernetes RBAC 角色，請對使用者採取後續行動。要求他們測試由於該角色而具有許可權可以完成的動作，例如刪除 Pod。
