---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-31"

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

您可以將叢集的存取權授與組織中的其他使用者，以確保只有授權使用者才能使用叢集，以及將應用程式部署至叢集。
{:shortdesc}


## 管理叢集存取
{: #managing}

每位使用 {{site.data.keyword.containershort_notm}} 的使用者都必須獲指派服務特定使用者角色的組合，以判斷使用者可以執行的動作。
{:shortdesc}

<dl>
<dt>{{site.data.keyword.containershort_notm}} 存取原則</dt>
<dd>在「身分及存取管理」中，{{site.data.keyword.containershort_notm}} 存取原則可以判斷您可對叢集執行的叢集管理動作，例如，建立或移除叢集，以及新增或移除額外的工作者節點。這些原則必須與基礎架構原則一起設定。</dd>
<dt>基礎架構存取原則</dt>
<dd>在「身分及存取管理」中，基礎架構存取原則容許在 IBM Cloud 基礎架構 (SoftLayer) 中完成從 {{site.data.keyword.containershort_notm}} 使用者介面或 CLI 所要求的動作。這些原則必須與 {{site.data.keyword.containershort_notm}} 存取原則一起設定。[進一步瞭解可用的基礎架構角色](/docs/iam/infrastructureaccess.html#infrapermission)。</dd>
<dt>資源群組</dt>
<dd>資源群組是一種將 {{site.data.keyword.Bluemix_notm}} 服務組織成群組的方式，讓您可以一次快速地指派使用者對多個資源的存取權。[瞭解如何使用資源群組來管理使用者](/docs/account/resourcegroups.html#rgs)。</dd>
<dt>Cloud Foundry 角色</dt>
<dd>在「身分及存取管理」中，每位使用者都必須獲指派 Cloud Foundry 使用者角色。此角色可以判斷使用者可對 {{site.data.keyword.Bluemix_notm}} 帳戶執行的動作，例如，邀請其他使用者，或檢視配額用量。[進一步瞭解可用的 Cloud Foundry 角色](/docs/iam/cfaccess.html#cfaccess)。</dd>
<dt>Kubernetes RBAC 角色</dt>
<dd>每位獲指派 {{site.data.keyword.containershort_notm}} 存取原則的使用者都會自動獲指派 Kubernetes RBAC 角色。在 Kubernetes 中，RBAC 角色可以判斷您可對叢集內 Kubernetes 資源執行的動作。只有 default 名稱空間才能設定 RBAC 角色。叢集管理者可以為叢集中的其他名稱空間新增 RBAC 角色。如需相關資訊，請參閱 Kubernetes 文件中的[使用 RBAC 授權 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/admin/authorization/rbac/#api-overview)。</dd>
</dl>

<br />


## 存取原則及許可權
{: #access_policies}

檢閱您可以授與 {{site.data.keyword.Bluemix_notm}} 帳戶中使用者的存取原則及許可權。操作員及編輯者角色具有個別的許可權。例如，如果您想要使用者新增工作者節點及連結服務，您必須同時將操作員及編輯者角色指派給使用者。如果您變更使用者的存取原則，{{site.data.keyword.containershort_notm}} 會為您清理與叢集中變更相關聯的 RBAC 原則。

|{{site.data.keyword.containershort_notm}} 存取原則|叢集管理許可權|Kubernetes 資源許可權|
|-------------|------------------------------|-------------------------------|
|管理者|此角色會繼承此帳戶中所有叢集的「編輯者」、「操作員」及「檢視者」角色的許可權。<br/><br/>針對所有現行服務實例設定時：<ul><li>建立免費或標準叢集</li><li>設定 {{site.data.keyword.Bluemix_notm}} 帳戶的認證，以存取 IBM Cloud 基礎架構 (SoftLayer) 組合</li><li>移除叢集</li><li>指派及變更此帳戶中其他現有使用者的 {{site.data.keyword.containershort_notm}} 存取原則。</li></ul><p>針對特定叢集 ID 設定時：<ul><li>移除特定叢集</li></ul></p>對應的基礎架構存取原則：超級使用者<br/><br/><b>附註</b>：若要建立機器、VLAN 及子網路這類資源，使用者需要**超級使用者**基礎架構角色。|<ul><li>RBAC 角色：cluster-admin</li><li>每個名稱空間中資源的讀寫存取</li><li>建立名稱空間內的角色</li><li>存取 Kubernetes 儀表板</li><li>建立 Ingress 資源，使應用程式公開可用</li></ul>|
|操作員|<ul><li>將其他工作者節點新增至叢集</li><li>移除叢集中的工作者節點</li><li>重新啟動工作者節點</li><li>重新載入工作者節點</li><li>將子網路新增至叢集</li></ul><p>對應的基礎架構存取原則：基本使用者</p>|<ul><li>RBAC 角色：admin</li><li>讀寫存取預設名稱空間內的資源，但不會讀寫存取名稱空間本身</li><li>建立名稱空間內的角色</li></ul>|
|編輯者 <br/><br/><b>提示</b>：請對應用程式開發人員使用此角色。|<ul><li>將 {{site.data.keyword.Bluemix_notm}} 服務連結至叢集。</li><li>取消 {{site.data.keyword.Bluemix_notm}} 服務與叢集的連結。</li><li>建立 Webhook。</li></ul><p>對應的基礎架構存取原則：基本使用者|<ul><li>RBAC 角色：edit</li><li>default 名稱空間內資源的讀寫存取</li></ul></p>|
|檢視者|<ul><li>列出叢集</li><li>檢視叢集的詳細資料</li></ul><p>對應的基礎架構存取原則：僅限檢視</p>|<ul><li>RBAC 角色：view</li><li>default 名稱空間內資源的讀取權</li><li>沒有 Kubernetes Secret 的讀取權</li></ul>|

|Cloud Foundry 存取原則|帳戶管理許可權|
|-------------|------------------------------|
|組織角色：管理員|<ul><li>將其他使用者新增至 {{site.data.keyword.Bluemix_notm}} 帳戶</li></ul>| |
|空間角色：開發人員|<ul><li>建立 {{site.data.keyword.Bluemix_notm}} 服務實例</li><li>將 {{site.data.keyword.Bluemix_notm}} 服務實例連結至叢集</li></ul>| 

<br />


## 將使用者新增至 {{site.data.keyword.Bluemix_notm}} 帳戶
{: #add_users}

您可以將其他使用者新增至 {{site.data.keyword.Bluemix_notm}} 帳戶，以授與對叢集的存取權。

開始之前，請驗證您已獲指派 {{site.data.keyword.Bluemix_notm}} 帳戶的「管理員」Cloud Foundry 角色。

1.  [將使用者新增至帳戶](../iam/iamuserinv.html#iamuserinv)。
2.  在**存取**區段中，展開**服務**。
3.  指派 {{site.data.keyword.containershort_notm}} 存取角色。從**指派存取權**下拉清單中，決定您只要將存取權授與 {{site.data.keyword.containershort_notm}} 帳戶（**資源**），還是授與您帳戶內各種資源的集合（**資源群組**）。
  -  對於**資源**：
      1. 從**服務**下拉清單中，選取 **{{site.data.keyword.containershort_notm}}**。
      2. 從**地區**下拉清單中，選取要邀請使用者加入的地區。
      3. 從**服務實例**下拉清單中，選取要邀請使用者加入的叢集。若要尋找特定叢集的 ID，請執行 `bx cs clusters`。
      4. 在**選取角色**區段中，選擇角色。若要尋找每個角色的支援動作清單，請參閱[存取原則及許可權](#access_policies)。
  - 對於**資源群組**：
      1. 從**資源群組**下拉清單中，選取包括您帳戶之 {{site.data.keyword.containershort_notm}} 資源許可權的資源群組。
      2. 從**指派對資源群組的存取權**下拉清單中，選取角色。若要尋找每個角色的支援動作清單，請參閱[存取原則及許可權](#access_policies)。
4. [選用項目：指派基礎架構角色](/docs/iam/mnginfra.html#managing-infrastructure-access)。
5. [選用項目：指派 Cloud Foundry 角色](/docs/iam/mngcf.html#mngcf)。
5. 按一下**邀請使用者**。

<br />


## 自訂使用者的基礎架構許可權
{: #infra_access}

當您在「身分及存取管理」中設定基礎架構原則時，使用者會獲得與角色相關聯的許可權。若要自訂這些許可權，您必須登入 IBM Cloud 基礎架構 (SoftLayer)，並在該處調整許可權。
{: #view_access}

例如，基本使用者可以重新啟動工作者節點，但無法重新載入工作者節點。不必將超級使用者許可權授與該人員，您即可調整 IBM Cloud 基礎架構 (SoftLayer) 許可權，並新增可執行重新載入指令的許可權。

1.  登入您的 IBM Cloud 基礎架構 (SoftLayer) 帳戶。
2.  選取要更新的使用者設定檔。
3.  在**入口網站許可權**中，自訂使用者的存取權。例如，若要新增重新載入許可權，請在**裝置**標籤中選取**發出 OS 重新載入及起始救援核心**。
9.  儲存變更。
