---

copyright:
  years: 2014, 2018
lastupdated: "2018-12-05"


---

{:new_window: target="blank"}
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

# 使用者存取許可權
{: #understanding}



當您[指派叢集許可權](cs_users.html)時，很難判斷您需要指派給使用者的角色。使用下列各節中的表格，來判定在 {{site.data.keyword.containerlong}} 中執行一般作業所需的最低許可權層次。
{: shortdesc}

## {{site.data.keyword.Bluemix_notm}} IAM 平台與 Kubernetes RBAC
{: #platform}

{{site.data.keyword.containerlong_notm}} 會配置為使用 {{site.data.keyword.Bluemix_notm}} Identity and Access Management (IAM) 角色。{{site.data.keyword.Bluemix_notm}} IAM 平台角色決定使用者可對叢集執行的動作。獲指派平台角色的每位使用者，也會在預設名稱空間中，自動獲指派對應的 Kubernetes 角色型存取控制 (RBAC) 角色。此外，平台角色會自動設定使用者的基本基礎架構許可權。若要設定原則，請參閱[指派 {{site.data.keyword.Bluemix_notm}} IAM 平台許可權](cs_users.html#platform)。若要進一步瞭解 RBAC 角色，請參閱[指派 RBAC 許可權](cs_users.html#role-binding)。
{: shortdesc}

下表顯示每一個平台角色所授與的叢集管理許可權，以及對應 RBAC 角色的 Kubernetes 資源許可權。

<table summary="此表格顯示 IAM 平台角色的使用者許可權，以及對應的 RBAC 原則。列應該從左到右閱讀，第一欄為 IAM 平台角色，第二欄為叢集許可權，第三欄為對應的 RBAC 角色。">
<caption>依平台及 RBAC 角色的叢集管理許可權</caption>
<thead>
    <th>平台角色</th>
    <th>叢集管理許可權</th>
    <th>對應的 RBAC 角色和資源許可權</th>
</thead>
<tbody>
  <tr>
    <td>**檢視者**</td>
    <td>
      叢集：<ul>
        <li>檢視資源群組及地區之 {{site.data.keyword.Bluemix_notm}} IAM API 金鑰擁有者的名稱及電子郵件位址。</li>
        <li>如果您的 {{site.data.keyword.Bluemix_notm}} 帳戶使用不同的認證來存取 IBM Cloud 基礎架構 (SoftLayer) 組合，請檢視基礎架構使用者名稱</li>
        <li>全部列出或檢視叢集、工作者節點、工作者節點儲存區、叢集裡服務，以及 Webhook 的詳細資料</li>
        <li>檢視基礎架構帳戶的 VLAN Spanning 狀態</li>
        <li>列出基礎架構帳戶中的可用子網路</li>
        <li>針對某個叢集設定時：列出區域中叢集連接至其中的 VLAN</li>
        <li>針對帳戶中的所有叢集設定時：列出區域中所有可用的 VLAN</li></ul>
      記載：<ul>
        <li>檢視目標地區的預設記載端點</li>
        <li>列出或檢視日誌轉遞和過濾配置的詳細資料</li>
        <li>檢視 Fluentd 附加程式的自動更新狀態</li></ul>
      Ingress：<ul>
        <li>全部列出或檢視叢集裡 ALB 的詳細資料</li>
        <li>檢視地區中支援的 ALB 類型</li></ul>
    </td>
    <td><code>view</code> 叢集角色是由 <code>ibm-view</code> 角色連結所套用，在 <code>default</code> 名稱空間中提供下列許可權：<ul>
      <li>default 名稱空間內資源的讀取權</li>
      <li>沒有 Kubernetes 密碼的讀取權</li></ul>
    </td>
  </tr>
  <tr>
    <td>**編輯者** <br/><br/><strong>提示</strong>：請對應用程式開發人員使用此角色，並指派 <a href="#cloud-foundry">Cloud Foundry</a> **開發人員**角色。</td>
    <td>此角色具有「檢視者」角色的所有權限，加上下列權限：</br></br>
      叢集：<ul>
        <li>連結及取消連結 {{site.data.keyword.Bluemix_notm}} 服務至叢集</li></ul>
      記載：<ul>
        <li>建立、更新及刪除 API 伺服器審核 Webhook</li>
        <li>建立叢集 Webhook</li>
        <li>建立及刪除 `kube-audit` 以外的所有類型的日誌轉遞配置</li>
        <li>更新及重新整理日誌轉遞配置</li>
        <li>建立、更新及刪除日誌過濾配置</li></ul>
      Ingress：<ul>
        <li>啟用或停用 ALB</li></ul>
    </td>
    <td><code>edit</code> 叢集角色是由 <code>ibm-edit</code> 角色連結所套用，在 <code>default</code> 名稱空間中提供下列許可權：
      <ul><li>default 名稱空間內資源的讀寫存取</li></ul></td>
  </tr>
  <tr>
    <td>**操作員**</td>
    <td>此角色具有「檢視者」角色的所有權限，加上下列權限：</br></br>
      叢集：<ul>
        <li>更新叢集</li>
        <li>重新整理 Kubernetes 主節點</li>
        <li>新增及移除工作者節點</li>
        <li>重新啟動、重新載入及更新工作者節點</li>
        <li>建立及刪除工作者節點儲存區</li>
        <li>新增及移除工作者節點儲存區中的區域</li>
        <li>更新工作者節點儲存區中給定區域的網路配置</li>
        <li>調整工作者節點儲存區的大小並且重新平衡工作者節點儲存區</li>
        <li>建立及新增子網路至叢集</li>
        <li>新增及移除叢集裡使用者管理的子網路</li></ul>
    </td>
    <td><code>admin</code> 叢集角色是由 <code>ibm-operate</code> 叢集角色連結所套用，提供下列許可權：<ul>
      <li>讀寫存取名稱空間內的資源，但不會讀寫存取名稱空間本身</li>
      <li>建立名稱空間內的 RBAC 角色</li></ul></td>
  </tr>
  <tr>
    <td>**管理者**</td>
    <td>此角色具有此帳戶中所有叢集的「編輯者」、「操作員」及「檢視者」角色的所有許可權，加上下列許可權：</br></br>
      叢集：<ul>
        <li>建立免費或標準叢集</li>
        <li>刪除叢集</li>
        <li>使用 {{site.data.keyword.keymanagementservicefull}} 來加密 Kubernetes 密碼</li>
        <li>設定 {{site.data.keyword.Bluemix_notm}} 帳戶的 API 金鑰，以存取鏈結的 IBM Cloud 基礎架構 (SoftLayer) 組合</li>
        <li>設定、檢視及移除 {{site.data.keyword.Bluemix_notm}} 帳戶的基礎架構認證，以存取不同的 IBM Cloud 基礎架構 (SoftLayer) 組合</li>
        <li>指派及變更帳戶中其他現有使用者的 {{site.data.keyword.Bluemix_notm}} IAM 平台角色</li>
        <li>針對所有地區中的所有 {{site.data.keyword.containerlong_notm}} 實例（叢集）設定時：列出帳戶中所有可用的 VLAN</ul>
      記載：<ul>
        <li>建立及更新類型 `kube-audit` 的日誌轉遞配置</li>
        <li>收集 {{site.data.keyword.cos_full_notm}} 儲存區中 API 伺服器日誌的 Snapshot</li>
        <li>啟用及停用 Fluentd 叢集附加程式的自動更新</li></ul>
      Ingress：<ul>
        <li>全部列出或檢視叢集裡 ALB 密碼的詳細資料</li>
        <li>將 {{site.data.keyword.cloudcerts_long_notm}} 實例中的憑證部署至 ALB</li>
        <li>更新或移除叢集裡的 ALB 密碼</li></ul>
      <p class="note">若要建立機器、VLAN 及子網路這類資源，「管理者」使用者需要**超級使用者**基礎架構角色。</p>
    </td>
    <td><code>cluster-admin</code> 叢集角色是由 <code>ibm-admin</code> 叢集角色連結所套用，提供下列許可權：
      <ul><li>每個名稱空間中資源的讀寫存取</li>
      <li>建立名稱空間內的 RBAC 角色</li>
      <li>存取 Kubernetes 儀表板</li>
      <li>建立 Ingress 資源，讓應用程式公開可用</li></ul>
    </td>
  </tr>
  </tbody>
</table>



## Cloud Foundry 角色
{: #cloud-foundry}

Cloud Foundry 角色會授與對帳戶內組織及空間的存取權。若要查看 {{site.data.keyword.Bluemix_notm}} 中的 Cloud Foundry 型服務清單，請執行 `ibmcloud service list`。若要進一步瞭解，請參閱 {{site.data.keyword.Bluemix_notm}} IAM 文件中的所有可用[組織和空間角色](/docs/iam/cfaccess.html)或[管理 Cloud Foundry 存取](/docs/iam/mngcf.html)的步驟。
{: shortdesc}

下表顯示叢集動作許可權所需的 Cloud Foundry 角色。

<table summary="此表格顯示 Cloud Foundry 的使用者許可權。列應該從左到右閱讀，第一欄為 Cloud Foundry 角色，第二欄為叢集許可權。">
  <caption>依 Cloud Foundry 角色的叢集管理許可權</caption>
  <thead>
    <th>Cloud Foundry 角色</th>
    <th>叢集管理許可權</th>
  </thead>
  <tbody>
  <tr>
    <td>空間角色：管理員</td>
    <td>管理使用者存取 {{site.data.keyword.Bluemix_notm}} 空間</td>
  </tr>
  <tr>
    <td>空間角色：開發人員</td>
    <td>
      <ul><li>建立 {{site.data.keyword.Bluemix_notm}} 服務實例</li>
      <li>將 {{site.data.keyword.Bluemix_notm}} 服務實例連結至叢集</li>
      <li>檢視來自空間層次之叢集日誌轉遞配置的日誌</li></ul>
    </td>
  </tr>
  </tbody>
</table>

## 基礎架構角色
{: #infra}

當具有**超級使用者**基礎架構存取角色的使用者[設定地區和資源群組的 API 金鑰](cs_users.html#api_key)時，帳戶中其他使用者的基礎架構許可權是由 {{site.data.keyword.Bluemix_notm}} IAM 平台角色設定。您不需要編輯其他使用者的 IBM Cloud 基礎架構 (SoftLayer) 許可權。只有在您無法將**超級使用者**指派給設定 API 金鑰的使用者時，才會使用下表來自訂使用者的 IBM Cloud 基礎架構 (SoftLayer) 許可權。如需相關資訊，請參閱[ 自訂基礎架構許可權](cs_users.html#infra_access)。
{: shortdesc}

下表顯示完成一般作業群組所需的基礎架構許可權。

<table summary="一般 {{site.data.keyword.containerlong_notm}} 情境的基礎架構許可權。">
     <caption>{{site.data.keyword.containerlong_notm}} 一般需要的基礎架構許可權</caption>
 <thead>
  <th>{{site.data.keyword.containerlong_notm}} 的一般作業</th>
  <th>依標籤列出必要的基礎架構許可權</th>
 </thead>
 <tbody>
   <tr>
     <td><strong>最少許可權</strong>：<ul><li>建立叢集。</li></ul></td>
     <td><strong>裝置</strong>：<ul><li>檢視虛擬伺服器詳細資料</li><li>重新啟動伺服器並檢視 IPMI 系統資訊</li><li>發出 OS 重新載入及起始救援核心</li></ul><strong>帳戶</strong>：<ul><li>新增伺服器</li></ul></td>
   </tr>
   <tr>
     <td><strong>叢集管理</strong>：<ul><li>建立、更新及刪除叢集。</li><li>新增、重新載入及重新啟動工作者節點。</li><li>檢視 VLAN。</li><li>建立子網路。</li><li>部署 Pod 及負載平衡器服務。</li></ul></td>
     <td><strong>支援</strong>：<ul><li>檢視問題單</li><li>新增問題單</li><li>編輯問題單</li></ul>
     <strong>裝置</strong>：<ul><li>檢視硬體詳細資料</li><li>檢視虛擬伺服器詳細資料</li><li>重新啟動伺服器並檢視 IPMI 系統資訊</li><li>發出 OS 重新載入及起始救援核心</li></ul>
     <strong>網路</strong>：<ul><li>新增運算與公用網路埠</li></ul>
     <strong>帳戶</strong>：<ul><li>取消伺服器</li><li>新增伺服器</li></ul></td>
   </tr>
   <tr>
     <td><strong>儲存空間</strong>：<ul><li>建立持續性磁區要求，以佈建持續性磁區。</li><li>建立及管理儲存空間基礎架構資源。</li></ul></td>
     <td><strong>服務</strong>：<ul><li>管理儲存空間</li></ul><strong>帳戶</strong>：<ul><li>新增儲存空間</li></ul></td>
   </tr>
   <tr>
     <td><strong>專用網路</strong>：<ul><li>管理專用 VLAN 來建立叢集內網路連線。</li><li>設定專用網路的 VPN 連線功能。</li></ul></td>
     <td><strong>網路</strong>：<ul><li>管理網路子網路路徑</li></ul></td>
   </tr>
   <tr>
     <td><strong>公用網路</strong>：<ul><li>設定公用負載平衡器或 Ingress 網路來公開應用程式。</li></ul></td>
     <td><strong>裝置</strong>：<ul><li>編輯主機名稱/網域</li><li>管理埠控制</li></ul>
     <strong>網路</strong>：<ul><li>新增運算與公用網路埠</li><li>管理網路子網路路徑</li><li>新增 IP 位址</li></ul>
     <strong>服務</strong>：<ul><li>管理 DNS、反向 DNS 及 WHOIS</li><li>檢視憑證 (SSL)</li><li>管理憑證 (SSL)</li></ul></td>
   </tr>
 </tbody>
</table>
