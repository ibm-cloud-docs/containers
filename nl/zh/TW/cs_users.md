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


# 指派叢集存取
{: #users}

當您作為叢集管理者時，可以為 {{site.data.keyword.containerlong}} 叢集定義存取原則，以針對不同使用者建立不同的存取層次。例如，您可以授權某些使用者能使用叢集基礎架構資源，而其他使用者則只能部署容器。
{: shortdesc}

## 瞭解存取原則及角色
{: #access_policies}

存取原則決定 {{site.data.keyword.Bluemix_notm}} 帳戶中使用者對跨 {{site.data.keyword.Bluemix_notm}} 平台之資源的存取層次。原則會將一個以上的角色指派給使用者，而角色定義單一服務的存取範圍，或定義資源群組中組織在一起之一組服務及資源的存取範圍。{{site.data.keyword.Bluemix_notm}} 中的每個服務都可能需要它自己的一組存取原則。
{: shortdesc}

在您開發方案以管理使用者存取時，請考量下列一般步驟：
1.  [挑選使用者的正確存取原則及角色](#access_roles)
2.  [在 {{site.data.keyword.Bluemix_notm}} IAM 中將存取角色指派給個別使用者或使用者群組](#iam_individuals_groups)
3.  [限定使用者存取叢集實例或資源群組](#resource_groups)

在瞭解如何管理您帳戶中的角色、使用者及資源之後，請參閱[設定叢集存取權](#access-checklist)，以取得如何配置存取權的核對清單。

### 挑選使用者的正確存取原則及角色
{: #access_roles}

您必須針對使用 {{site.data.keyword.containerlong_notm}} 的每一個使用者定義存取原則。存取原則的範圍是根據使用者定義的角色，來決定使用者可以執行的動作。部分原則是預先定義的，但可以自訂其他原則。不論使用者是從 {{site.data.keyword.containerlong_notm}} 主控台還是透過 CLI 提出要求，都會強制執行相同的原則，即使是在 IBM Cloud 基礎架構 (SoftLayer) 中完成動作。
{: shortdesc}

瞭解不同類型的許可權及角色、哪個角色可以執行每個動作，以及角色彼此的關係。

若要查看每個角色的特定 {{site.data.keyword.containerlong_notm}} 許可權，請參閱[使用者存取權](cs_access_reference.html)參照主題。
{: tip}

<dl>

<dt><a href="#platform">IAM 平台</a></dt>
<dd>{{site.data.keyword.containerlong_notm}} 使用 {{site.data.keyword.Bluemix_notm}} Identity and Access Management (IAM) 角色來授與使用者對叢集的存取權。IAM 平台角色決定使用者可對叢集執行的動作。您可以依地區設定這些角色的原則。獲指派 IAM 平台角色的每位使用者，也會自動獲指派 `default` Kubernetes 名稱空間中對應的 RBAC 角色。此外，IAM 平台角色也會授權您對叢集執行基礎架構動作，但不會授與對 IBM Cloud 基礎架構 (SoftLayer) 資源的存取權。對 IBM Cloud 基礎架構 (SoftLayer) 資源的存取權，取決於[針對地區所設定的 API 金鑰](#api_key)。</br></br>
IAM 平台角色所允許的範例動作是建立或移除叢集、將服務連結至叢集，或新增額外的工作者節點。</dd>
<dt><a href="#role-binding">RBAC</a></dt>
<dd>在 Kubernetes 中，角色型存取控制 (RBAC) 是保護叢集內資源的一種方式。RBAC 角色決定使用者可對那些資源執行的 Kubernetes 動作。獲指派 IAM 平台角色的每位使用者，也會自動獲指派 `default` Kubernetes 中對應的 RBAC 角色。此 RBAC 叢集角色會套用至 default 名稱空間或所有名稱空間（視選擇的 IAM 平台角色而定）。</br></br>
RBAC 角色所允許的範例動作是建立 Pod 這類物件或是讀取 Pod 日誌。</dd>
<dt><a href="#api_key">基礎架構</a></dt>
<dd>基礎架構角色可存取您的 IBM Cloud 基礎架構 (SoftLayer) 資源。設定具有**超級使用者**基礎架構角色的使用者，並將此使用者的基礎架構認證儲存在 API 金鑰。然後，在您要建立叢集的每個地區中設定 API 金鑰。設定 API 金鑰之後，您授與 {{site.data.keyword.containerlong_notm}} 存取權的其他使用者就不需要基礎架構角色，因為該地區內的所有使用者都會共用此 API 金鑰。相反地，{{site.data.keyword.Bluemix_notm}} IAM 平台角色決定容許使用者執行的基礎架構動作。如果您未使用完整<strong>超級使用者</strong>基礎架構來設定 API 金鑰，或您需要將特定裝置存取權授與使用者，則可以[自訂基礎架構許可權](#infra_access)。</br></br>
基礎架構角色所允許的範例動作將會檢視叢集工作者節點機器的詳細資料，或編輯網路及儲存空間資源。</dd>
<dt>Cloud Foundry</dt>
<dd>無法使用 {{site.data.keyword.Bluemix_notm}} IAM 來管理所有服務。如果您是使用其中一個服務，則可以繼續使用 Cloud Foundry 使用者角色來控制對這些服務的存取。Cloud Foundry 角色會授與對帳戶內組織及空間的存取權。若要查看 {{site.data.keyword.Bluemix_notm}} 中的 Cloud Foundry 型服務清單，請執行 <code>ibmcloud service list</code>。</br></br>
Cloud Foundry 角色所允許的範例動作是建立新的 Cloud Foundry 服務實例，或是將 Cloud Foundry 服務實例連結至叢集。若要進一步瞭解，請參閱 {{site.data.keyword.Bluemix_notm}} IAM 文件中的可用[組織和空間角色](/docs/iam/cfaccess.html)或[管理 Cloud Foundry 存取](/docs/iam/mngcf.html)的步驟。</dd>
</dl>

### 在 {{site.data.keyword.Bluemix_notm}} IAM 中將存取角色指派給個別使用者或使用者群組
{: #iam_individuals_groups}

當您設定 {{site.data.keyword.Bluemix_notm}} IAM 原則時，可以將角色指派給個別使用者或使用者群組。
{: shortdesc}

<dl>
<dt>個別使用者</dt>
<dd>您可能有一個特定使用者，比您的其餘團隊成員需要更多或更少的許可權。您可以根據個別使用者來自訂許可權，讓每個人員都有完成其作業的必要許可權。您可以將多個 {{site.data.keyword.Bluemix_notm}} IAM 角色指派給每位使用者。</dd>
<dt>存取群組中的多個使用者</dt>
<dd>您可以建立使用者群組，然後將許可權指派給該群組。例如，您可以將所有團隊領導人分組，並將群組的存取權指派給管理者。然後，您可以將所有開發人員分組，並僅指派該群組的寫入權。您可以將多個 {{site.data.keyword.Bluemix_notm}} IAM 角色指派給每個存取群組。將許可權指派給群組時，會影響新增至該群組或從該群組移除的任何使用者。如果您將使用者新增至群組，他們也會有額外的存取權。如果移除他們，則會撤銷其存取權。
</dd>
</dl>

{{site.data.keyword.Bluemix_notm}} IAM 角色無法指派給服務帳戶。相反地，您可以直接[將 RBAC 角色指派給服務帳戶](#rbac)。
{: tip}

您也必須指定使用者是否有權存取資源群組中的某個叢集、資源群組中的所有叢集，或您帳戶中所有資源群組的所有叢集。

### 限定使用者存取叢集實例或資源群組
{: #resource_groups}

在 {{site.data.keyword.Bluemix_notm}} IAM 中，您可以將使用者存取角色指派給資源實例或資源群組。
{: shortdesc}

當您建立 {{site.data.keyword.Bluemix_notm}} 帳戶時，會自動建立 default 資源群組。如果您在建立資源時未指定資源群組，則資源實例（叢集）屬於 default 資源群組。如果您要在帳戶中新增資源群組，請參閱[設定帳戶的最佳作法 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](/docs/tutorials/users-teams-applications.html) 及[設定資源群組](/docs/resources/bestpractice_rgs.html#setting-up-your-resource-groups)。

<dl>
<dt>資源實例</dt>
  <dd><p>您帳戶中的每個 {{site.data.keyword.Bluemix_notm}} 服務都是具有實例的資源。實例會依服務而不同。例如，在 {{site.data.keyword.containerlong_notm}} 中，實例是叢集，但在 {{site.data.keyword.cloudcerts_long_notm}} 中，實例是憑證。依預設，資源也屬於您帳戶中的 default 資源群組。在下列情境中，您可以將資源實例的存取角色指派給使用者。
  <ul><li>您帳戶中的所有 {{site.data.keyword.Bluemix_notm}} IAM 服務（包括 {{site.data.keyword.containerlong_notm}} 中的所有叢集，以及 {{site.data.keyword.registrylong_notm}} 中的映像檔）。</li>
  <li>服務內的所有實例（例如 {{site.data.keyword.containerlong_notm}} 中的所有叢集）。</li>
  <li>服務地區內的所有實例（例如 {{site.data.keyword.containerlong_notm}} 之**美國南部**地區中的所有叢集）。</li>
  <li>個別實例（例如某個叢集）。</li></ul></dd>
<dt>資源群組</dt>
  <dd><p>您可以將帳戶資源組織為可自訂分組，讓您可以一次快速地指派個別使用者或使用者群組對多個資源的存取權。資源群組可以協助操作員及管理者過濾資源，以檢視其現行用量、問題疑難排解以及管理團隊。</p>
  <p class="important">叢集只能與相同資源群組中的其他 {{site.data.keyword.Bluemix_notm}} 服務，或不支援資源群組的服務（例如 {{site.data.keyword.registrylong_notm}}）整合。只能在一個資源群組中建立一個叢集，之後就無法進行變更。如果您在錯誤資源群組中建立叢集，則必須刪除叢集，然後在正確的資源群組中予以重建。</p>
  <p>如果您計劃使用[度量值的 {{site.data.keyword.monitoringlong_notm}}](cs_health.html#view_metrics)，請考量在帳戶的資源群組及地區中提供叢集唯一名稱，以避免發生度量值命名衝突。您無法重新命名叢集。</p>
  <p>在下列情境中，您可以將資源群組的存取角色指派給使用者。請注意，與資源實例不同，您無法授與資源群組內個別實例的存取權。</p>
  <ul><li>資源群組中的所有 {{site.data.keyword.Bluemix_notm}} IAM 服務（包括 {{site.data.keyword.containerlong_notm}} 中的所有叢集，以及 {{site.data.keyword.registrylong_notm}} 中的映像檔）。</li>
  <li>資源群組中服務內的所有實例（例如 {{site.data.keyword.containerlong_notm}} 中的所有叢集）。</li>
  <li>資源群組中服務地區內的所有實例（例如 {{site.data.keyword.containerlong_notm}} 之**美國南部**地區中的所有叢集）。</li></ul></dd>
</dl>

<br />


## 設定對叢集的存取權
{: #access-checklist}

在您[瞭解如何管理您帳戶中的角色、使用者及資源](#access_policies)之後，請使用下列核對清單來配置叢集裡的使用者存取權。
{: shortdesc}

1. 針對您要建立叢集的所有地區及資源群組，[設定 API 金鑰](#api_key)。
2. 邀請使用者加入您的帳戶，並針對 {{site.data.keyword.containerlong_notm}} [指派其 {{site.data.keyword.Bluemix_notm}} IAM 角色](#platform)。
3. 若要容許使用者將服務連結至叢集，或檢視從叢集記載配置轉遞的日誌，請針對已部署服務或日誌收集所在的組織及空間，[將 Cloud Foundry 角色授與使用者](/docs/iam/mngcf.html)。
4. 如果您使用 Kubernetes 名稱空間來隔離叢集內的資源，則請[將**檢視者**及**編輯者** {{site.data.keyword.Bluemix_notm}} IAM 平台角色的 Kubernetes RBAC 角色連結複製到其他名稱空間](#role-binding)。
5. 對於任何自動化工具（例如在 CI/CD 管線中），設定服務帳戶，以及[將 Kubernetes RBAC 許可權指派給服務帳戶](#rbac)。
6. 如需其他進階配置以控制 Pod 層次對叢集資源的存取權，請參閱[配置 Pod 安全](/docs/containers/cs_psp.html)。

</br>

如需設定帳戶及資源的相關資訊，請試用本指導教學中[組織使用者、團隊及應用程式的最佳作法](/docs/tutorials/users-teams-applications.html)的相關內容。
{: tip}

<br />


## 設定 API 金鑰以啟用存取基礎架構組合
{: #api_key}

若要順利佈建及使用叢集，您必須確定已正確設定 {{site.data.keyword.Bluemix_notm}} 帳戶，可存取 IBM Cloud 基礎架構 (SoftLayer) 組合。
{: shortdesc}

**大部分情況**：您的 {{site.data.keyword.Bluemix_notm}}「隨收隨付制」帳戶已有權存取 IBM Cloud 基礎架構 (SoftLayer) 組合。若要設定 {{site.data.keyword.containerlong_notm}} 來存取該組合，**帳戶擁有者**必須設定地區及資源群組的 API 金鑰。

1. 以帳戶擁有者身分登入終端機。
    ```
    ibmcloud login [--sso]
    ```
    {: pre}

2. 將您要設定 API 金鑰的資源群組設為目標。如果您未將目標設為資源群組，則會針對 default 資源群組設定 API 金鑰。
    ```
    ibmcloud target -g <resource_group_name>
    ```
    {:pre}

3. 如果您在不同的地區，請切換至您要設定 API 金鑰的地區。
    ```
    ibmcloud ks region-set
    ```
    {: pre}

4. 設定地區及資源群組的 API 金鑰。
    ```
    ibmcloud ks api-key-reset
    ```
    {: pre}    

5. 驗證已設定 API 金鑰。
    ```
    ibmcloud ks api-key-info <cluster_name_or_ID>
    ```
    {: pre}

6. 針對您要建立叢集的每個地區及資源群組，重複該步驟。

**替代選項及相關資訊**：如需存取 IBM Cloud 基礎架構 (SoftLayer) 組合的不同方式，請參閱下列各節。
* 如果不確定您的帳戶是否已可存取 IBM Cloud 基礎架構 (SoftLayer) 組合，請參閱[瞭解 IBM Cloud 基礎架構 (SoftLayer) 組合存取權](#understand_infra)。
* 如果帳戶擁有者未設定 API 金鑰，請[確定設定 API 金鑰的使用者具有正確許可權](#owner_permissions)。
* 如需使用預設帳戶來設定 API 金鑰的相關資訊，請參閱[使用預設 {{site.data.keyword.Bluemix_notm}} 隨收隨付制帳戶存取基礎架構組合](#default_account)。
* 如果您沒有預設「隨收隨付制」帳戶，或需要使用不同的 IBM Cloud 基礎架構 (SoftLayer) 帳戶，請參閱[存取不同的 IBM Cloud 基礎架構 (SoftLayer) 帳戶](#credentials)。

### 瞭解 IBM Cloud 基礎架構 (SoftLayer) 組合存取權
{: #understand_infra}

判定您的帳戶是否可存取 IBM Cloud 基礎架構 (SoftLayer) 組合，並瞭解 {{site.data.keyword.containerlong_notm}} 如何使用 API 金鑰存取組合。
{: shortdesc}

**我的帳戶是否已有權存取 IBM Cloud 基礎架構 (SoftLayer) 組合？**</br>

若要存取 IBM Cloud 基礎架構 (SoftLayer) 組合，您可以使用 {{site.data.keyword.Bluemix_notm}}「隨收隨付制」帳戶。如果您有不同類型的帳戶，則請檢視下表中的選項。

<table summary="表格依帳戶類型顯示標準叢集建立選項。列應該從左到右閱讀，第一欄為帳戶說明，第二欄為建立標準叢集的選項。">
    <caption>依帳戶類型的標準叢集建立選項</caption>
  <thead>
  <th>帳戶說明</th>
  <th>建立標準叢集的選項</th>
  </thead>
  <tbody>
    <tr>
      <td>**精簡帳戶**無法佈建叢集。</td>
      <td>[將精簡帳戶升級至 {{site.data.keyword.Bluemix_notm}} 隨收隨付制帳戶](/docs/account/index.html#paygo)。</td>
    </tr>
    <tr>
      <td>**隨收隨付制**帳戶隨附對基礎架構組合的存取權。</td>
      <td>您可以建立標準叢集。使用 API 金鑰來設定叢集的基礎架構許可權。</td>
    </tr>
    <tr>
      <td>**訂閱帳戶**未設定對 IBM Cloud 基礎架構 (SoftLayer) 組合的存取權。</td>
      <td><p><strong>選項 1：</strong>[建立新的隨收隨付制帳戶](/docs/account/index.html#paygo)，其已設定為具有 IBM Cloud 基礎架構 (SoftLayer) 組合存取權。當您選擇此選項時，會有兩個不同的 {{site.data.keyword.Bluemix_notm}} 帳戶及計費。</p><p>如果您要繼續使用「訂閱」帳戶，則可以使用新的「隨收隨付制」帳戶在 IBM Cloud 基礎架構 (SoftLayer) 中產生 API 金鑰。然後，您必須手動設定「訂閱」帳戶的 IBM Cloud 基礎架構 (SoftLayer) API 金鑰。請記住，IBM Cloud 基礎架構 (SoftLayer) 資源是透過新的「隨收隨付制」帳戶計費。</p><p><strong>選項 2：</strong>如果您已有想要使用的現有 IBM Cloud 基礎架構 (SoftLayer) 帳戶，則可以針對 {{site.data.keyword.Bluemix_notm}} 帳戶手動設定 IBM Cloud 基礎架構 (SoftLayer) 認證。</p><p class="note">當您手動鏈結至 IBM Cloud 基礎架構 (SoftLayer) 帳戶時，會將認證用於您 {{site.data.keyword.Bluemix_notm}} 帳戶中的每個 IBM Cloud 基礎架構 (SoftLayer) 特定動作。您必須確定所設定的 API 金鑰具有[足夠的基礎架構許可權](cs_users.html#infra_access)，讓使用者可以建立及使用叢集。</p></td>
    </tr>
    <tr>
      <td>**IBM Cloud 基礎架構 (SoftLayer) 帳戶**，無 {{site.data.keyword.Bluemix_notm}} 帳戶</td>
      <td><p>[建立 {{site.data.keyword.Bluemix_notm}} 隨收隨付制帳戶](/docs/account/index.html#paygo)。您有兩個不同的 IBM Cloud 基礎架構 (SoftLayer) 帳戶和帳單。</p><p>依預設，您的新 {{site.data.keyword.Bluemix_notm}} 帳戶會使用新的基礎架構帳戶。若要繼續使用舊的基礎架構帳戶，請手動設定認證。</p></td>
    </tr>
  </tbody>
  </table>

**現在，已設定我的基礎架構組合，{{site.data.keyword.containerlong_notm}} 會如何存取組合？**</br>

{{site.data.keyword.containerlong_notm}} 使用 API 金鑰來存取 IBM Cloud 基礎架構 (SoftLayer) 組合。API 金鑰會儲存具有 IBM Cloud 基礎架構 (SoftLayer) 帳戶存取權的使用者認證。API 金鑰是依資源群組內的地區所設定，並且供該地區中的使用者所共用。
 
若要讓所有使用者存取 IBM Cloud 基礎架構 (SoftLayer) 組合，API 金鑰中儲存其認證的使用者必須在您的 {{site.data.keyword.Bluemix_notm}} 帳戶中具有[**超級使用者**基礎架構角色，以及 {{site.data.keyword.containerlong_notm}} 及 {{site.data.keyword.registryshort_notm}} 的 **管理者**平台角色](#owner_permissions)。然後，讓該使用者執行地區及資源群組中的第一個管理者動作。使用者的基礎架構認證儲存在該地區及資源群組的 API 金鑰中。

帳戶內的其他使用者會共用用於存取基礎架構的 API 金鑰。使用者登入 {{site.data.keyword.Bluemix_notm}} 帳戶時，會針對 CLI 階段作業產生根據 API 金鑰的 {{site.data.keyword.Bluemix_notm}} IAM 記號，並啟用要在叢集裡執行的基礎架構相關指令。

若要查看 CLI 階段作業的 {{site.data.keyword.Bluemix_notm}} IAM 記號，您可以執行 `ibmcloud iam oauth-tokens`。{{site.data.keyword.Bluemix_notm}} IAM 記號也可以用來[直接呼叫 {{site.data.keyword.containerlong_notm}} API](cs_cli_install.html#cs_api)。
{: tip}

**如果使用者有權透過 {{site.data.keyword.Bluemix_notm}} IAM 記號存取該組合，則如何限制使用者可以執行哪些指令？**

在對您帳戶中的使用者設定組合的存取權之後，您接著可以指派適當的[平台角色](#platform)，以控制使用者可以執行的基礎架構動作。藉由將 {{site.data.keyword.Bluemix_notm}} IAM 角色指派給使用者，可以限制他們只能針對叢集執行哪些指令。例如，因為 API 金鑰擁有者具有**超級使用者**基礎架構角色，所以所有基礎架構相關指令都可以在叢集裡執行。但是，根據指派給使用者的 {{site.data.keyword.Bluemix_notm}} IAM 角色，使用者只能執行其中部分的基礎架構相關指令。

例如，如果您要在新地區中建立叢集，請確定第一個叢集是由具有**超級使用者**基礎架構角色的使用者所建立（例如帳戶擁有者）。之後，您可以邀請 {{site.data.keyword.Bluemix_notm}} IAM 存取群組中的個別使用者加入該地區，方法是在該地區中設定其平台管理原則。具有**檢視者**平台角色的使用者未獲授權新增工作者節點。因此，`worker-add` 動作會失敗，即使 API 金鑰具有正確的基礎架構權限也是一樣。如果您將使用者的平台角色變更為**操作員**，則會授權使用者新增工作者節點。`worker-add` 動作成功，因為使用者已獲授權，而且 API 金鑰設定正確。您不需要編輯使用者的 IBM Cloud 基礎架構 (SoftLayer) 許可權。

若要審核使用者在您帳戶中執行的動作，您可以使用 [{{site.data.keyword.cloudaccesstrailshort}}](cs_at_events.html) 來檢視所有叢集相關事件。
{: tip}

**如果我不想將「超級使用者」基礎架構角色指派給 API 金鑰擁有者或認證擁有者，該怎麼辨？**</br>

基於法規遵循、安全或計費原因，您可能不想將**超級使用者**基礎架構角色指派給設定 API 金鑰的使用者，或使用 `ibmcloud ks credential-set` 指令設定其認證的使用者。不過，如果此使用者沒有**超級使用者**角色，則基礎架構相關動作（例如建立叢集或重新載入工作者節點）可能會失敗。您必須針對使用者[設定特定 IBM Cloud 基礎架構 (SoftLayer) 許可權](#infra_access)，而不是使用 {{site.data.keyword.Bluemix_notm}} IAM 平台角色來控制使用者的基礎架構存取權。

**在為地區和資源群組設定 API 金鑰的使用者離開公司時會發生什麼情況？**

如果使用者離開您的組織，則 {{site.data.keyword.Bluemix_notm}} 帳戶擁有者可以移除該使用者的許可權。不過，在您移除使用者的特定存取許可權，或從您的帳戶中完整移除使用者之前，您必須使用另一個使用者的基礎架構認證來重設 API 金鑰。否則，帳戶中的其他使用者可能無法存取 IBM Cloud 基礎架構 (SoftLayer) 入口網站，而且基礎架構相關指令可能失敗。如需相關資訊，請參閱[移除使用者許可權](#removing)。

**如果我的 API 金鑰受損，如何才能鎖定我的叢集？**

如果針對您叢集裡地區及資源群組設定的 API 金鑰受損，請[刪除它](../iam/userid_keys.html#deleting-an-api-key)，這樣就無法使用 API 金鑰作為鑑別來進一步呼叫。如需安全存取 Kubernetes API 伺服器的相關資訊，請參閱 [Kubernetes API 伺服器及 etcd](cs_secure.html#apiserver) 安全主題。

**如何設定叢集的 API 金鑰？**</br>

它取決於您將用來存取 IBM Cloud 基礎架構 (SoftLayer) 組合的帳戶類型：
* [預設 {{site.data.keyword.Bluemix_notm}} 隨收隨付制帳戶](#default_account)
* [未鏈結至預設 {{site.data.keyword.Bluemix_notm}} 隨收隨付制帳戶的不同 IBM Cloud 基礎架構 (SoftLayer) 帳戶](#credentials)

### 確保 API 金鑰或基礎架構認證擁有者具有正確許可權
{: #owner_permissions}

為了確保可以在叢集裡順利完成所有基礎架構相關動作，您要針對 API 金鑰設定其認證的使用者必須具有適當的許可權。
{: shortdesc}

1. 登入 [{{site.data.keyword.Bluemix_notm}} 主控台 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://console.bluemix.net/)。

2. 為了確保可以順利執行所有帳戶相關動作，請驗證使用者具有正確的 {{site.data.keyword.Bluemix_notm}} IAM 平台角色。
    1. 導覽至**管理 > 帳戶 > 使用者**。
    2. 按一下您要設定 API 金鑰的使用者名稱，或您要針對 API 金鑰設定其認證的使用者名稱。
    3. 如果使用者沒有所有地區中所有 {{site.data.keyword.containerlong_notm}} 叢集的**管理者**平台角色，請[將該平台角色指派給使用者](#platform)。
    4. 如果使用者沒有您要設定 API 金鑰之資源群組的至少**檢視者**平台角色，請[將該資源群組角色指派給使用者](#platform)。
    5. 若要建立叢集，使用者還需要帳戶層次中 {{site.data.keyword.registrylong_notm}} 的**管理者**平台角色。請不要將 {{site.data.keyword.registryshort_notm}} 的原則限制為資源群組層次。

3. 為了確保可以順利執行叢集裡的所有基礎架構相關動作，請驗證使用者具有正確的基礎架構存取原則。
    1. 從功能表 ![「功能表」圖示](../icons/icon_hamburger.svg "「功能表」圖示") 中，選取**基礎架構**。
    2. 從功能表列中，選取**帳戶** > **使用者** > **使用者清單**。
    3. 在 **API 金鑰**直欄中，驗證使用者具有 API 金鑰，或按一下**產生**。
    4. 選取使用者設定檔的名稱，並檢查使用者的許可權。
    5. 如果使用者沒有**超級使用者**角色，請按一下**入口網站許可權**標籤。
        1. 使用**快速許可權**下拉清單來指派**超級使用者**角色。
        2. 按一下**設定許可權**。

### 使用預設 {{site.data.keyword.Bluemix_notm}} 隨收隨付制帳戶存取基礎架構組合
{: #default_account}

如果您有 {{site.data.keyword.Bluemix_notm}}「隨收隨付制」帳戶，依預設，可以存取鏈結的 IBM Cloud 基礎架構 (SoftLayer) 組合。API 金鑰用來從此 IBM Cloud 基礎架構 (SoftLayer) 組合訂購基礎架構資源，例如新的工作者節點或 VLAN。
{: shortdec}

您可以執行 [`ibmcloud ks api-key-info`](cs_cli_reference.html#cs_api_key_info) 來尋找現行 API 金鑰擁有者。如果您發現需要更新針對某地區所儲存的 API 金鑰，即可執行 [`ibmcloud ks api-key-reset`](cs_cli_reference.html#cs_api_key_reset) 指令來達成此目的。這個指令需要 {{site.data.keyword.containerlong_notm}} 管理存取原則，它會將執行這個指令的使用者的 API 金鑰儲存在帳戶中。

請務必重設金鑰，並瞭解這對應用程式的影響。金鑰用於數個不同的地方，如果對其進行不需要的變更，則可能導致岔斷變更。
{: note}

**開始之前**：
- 如果帳戶擁有者未設定 API 金鑰，請[確定設定 API 金鑰的使用者具有正確許可權](#owner_permissions)。
- [登入您的帳戶。將目標設為適當的地區及（如果適用的話）資源群組。設定叢集的環境定義](cs_cli_install.html#cs_cli_configure)。

若要設定 API 金鑰來存取 IBM Cloud 基礎架構 (SoftLayer) 組合，請執行下列動作：

1.  設定叢集所在地區及資源群組的 API 金鑰。
    1.  使用您要使用其基礎架構許可權的使用者身分，登入終端機。
    2.  將您要設定 API 金鑰的資源群組設為目標。如果您未將目標設為資源群組，則會針對 default 資源群組設定 API 金鑰。
        ```
        ibmcloud target -g <resource_group_name>
        ```
        {:pre}
    3.  如果您在不同的地區，請切換至您要設定 API 金鑰的地區。
        ```
        ibmcloud ks region-set
        ```
        {: pre}
    4.  設定地區的使用者 API 金鑰。
        ```
        ibmcloud ks api-key-reset
        ```
        {: pre}    
    5.  驗證已設定 API 金鑰。
        ```
        ibmcloud ks api-key-info <cluster_name_or_ID>
        ```
        {: pre}

2. [建立叢集](cs_clusters.html)。為建立叢集，會使用您針對地區及資源群組所設定的 API 金鑰認證。

### 存取不同的 IBM Cloud 基礎架構 (SoftLayer) 帳戶
{: #credentials}

建議您使用已具有的不同 IBM Cloud 基礎架構 (SoftLayer) 帳戶，而不是使用預設已鏈結的 IBM Cloud 基礎架構 (SoftLayer) 帳戶來訂購地區內叢集的基礎架構。您可以使用 [`ibmcloud ks credential-set`](cs_cli_reference.html#cs_credentials_set) 指令，將此基礎架構帳戶鏈結至 {{site.data.keyword.Bluemix_notm}} 帳戶。使用 IBM Cloud 基礎架構 (SoftLayer) 認證，而不是使用針對地區所儲存的預設「隨收隨付制」帳戶認證。
{: shortdesc}

在您的階段作業結束之後，會持續保存 `ibmcloud ks credential-set` 指令所設定的 IBM Cloud 基礎架構 (SoftLayer) 認證。如果您使用 [`ibmcloud ks credential-unset`](cs_cli_reference.html#cs_credentials_unset) 指令移除手動設定的 IBM Cloud 基礎架構 (SoftLayer) 認證，則會使用預設「隨收隨付制」帳戶認證。不過，基礎架構帳戶認證中的這項變更可能會導致[孤立叢集](cs_troubleshoot_clusters.html#orphaned)。
{: important}

**開始之前**：
- 如果您未使用帳戶擁有者的認證，請[確定您要針對 API 金鑰設定其認證的使用者具有正確許可權](#owner_permissions)。
- [登入您的帳戶。將目標設為適當的地區及（如果適用的話）資源群組。設定叢集的環境定義](cs_cli_install.html#cs_cli_configure)。

若要設定基礎架構帳戶認證來存取 IBM Cloud 基礎架構 (SoftLayer) 組合，請執行下列動作：

1. 取得您要用來存取 IBM Cloud 基礎架構 (SoftLayer) 組合的基礎架構帳戶。取決於[現行帳戶類型](#understand_infra)，您會有不同的選項。

2.  使用正確帳戶的使用者來設定基礎架構 API 認證。

    1.  取得使用者的基礎架構 API 認證。請注意，認證不同於 IBM ID。

        1.  從 [{{site.data.keyword.Bluemix_notm}} ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://console.bluemix.net/) 主控台的**基礎架構** > **帳戶** > **使用者** > **使用者清單**表格中，按一下 **IBM ID 或使用者名稱**。

        2.  在 **API 存取資訊**區段中，檢視 **API 使用者名稱**及**鑑別金鑰**。    

    2.  設定要使用的基礎架構 API 認證。
        ```
        ibmcloud ks credential-set --infrastructure-username <infrastructure_API_username> --infrastructure-api-key <infrastructure_API_authentication_key>
        ```
        {: pre}

    3. 驗證已設定正確的認證。
        ```
        ibmcloud ks credential-get
        ```
        輸出範例：
        ```
        Infrastructure credentials for user name user@email.com set for resource group default.
        ```
        {: screen}

3. [建立叢集](cs_clusters.html)。為建立叢集，會使用您針對地區及資源群組所設定的基礎架構認證。

4. 驗證您的叢集使用您所設定的基礎架構帳戶認證。
  1. 開啟 [{{site.data.keyword.containerlong_notm}} 主控台 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://console.bluemix.net/containers-kubernetes/clusters)，並選取叢集。
  2. 在「概觀」標籤中，尋找**基礎架構使用者**欄位。
  3. 如果您看到該欄位，則不會使用此地區中隨附「隨收隨付制」帳戶的預設基礎架構認證。相反地，此地區設定為使用您所設定的不同基礎架構帳戶認證。

<br />


## 透過 {{site.data.keyword.Bluemix_notm}} IAM 授與使用者對您叢集的存取權
{: #platform}

在 [{{site.data.keyword.Bluemix_notm}} 主控台](#add_users) 或 [CLI](#add_users_cli) 中設定 {{site.data.keyword.Bluemix_notm}} IAM 平台管理原則，讓使用者可以在 {{site.data.keyword.containerlong_notm}} 中使用叢集。開始之前，請參閱[瞭解存取原則及角色](#access_policies)，以檢閱什麼是原則、您可以將原則指派給誰，以及哪些資源可獲授與原則。
{: shortdesc}

{{site.data.keyword.Bluemix_notm}} IAM 角色無法指派給服務帳戶。相反地，您可以直接[將 RBAC 角色指派給服務帳戶](#rbac)。
{: tip}

### 使用主控台指派 {{site.data.keyword.Bluemix_notm}} IAM 角色
{: #add_users}

使用 {{site.data.keyword.Bluemix_notm}} 主控台指派 {{site.data.keyword.Bluemix_notm}} IAM 平台管理角色，以授與使用者對您叢集的存取權。
{: shortdesc}

開始之前，請驗證您已獲指派所使用之 {{site.data.keyword.Bluemix_notm}} 帳戶的**管理者**平台角色。

1. 登入 [{{site.data.keyword.Bluemix_notm}} 主控台](https://console.bluemix.net/)，並導覽至**管理 > 帳戶 > 使用者**。

2. 個別選取使用者，或建立使用者的存取群組。
    * 若要將角色指派給個別使用者，請執行下列動作：
      1. 按一下您要為其設定許可權的使用者名稱。如果未顯示使用者，請按一下**邀請使用者**，將他們新增至帳戶。
      2. 按一下**指派存取權**。
    * 若要將角色指派給存取群組中的多位使用者，請執行下列動作：
      1. 在左側導覽中，按一下**存取群組**。
      2. 按一下**建立**，並為群組指定一個**名稱**及**說明**。按一下**建立**。
      3. 按一下**新增使用者**，將人員新增至您的存取群組。即會顯示可以存取您帳戶的使用者清單。
      4. 針對您要新增至群組的使用者，勾選旁邊的方框。即會顯示一個對話框。
      5. 按一下**新增至群組**。
      6. 按一下**存取原則**。
      7. 按一下**指派存取權**。

3. 指派原則。
  * 若要存取資源群組中的所有叢集，請執行下列動作：
    1. 按一下**指派資源群組內的存取權**。
    2. 選取資源群組名稱。
    3. 從**服務**清單中，選取 **{{site.data.keyword.containershort_notm}}**。
    4. 從**地區**清單中，選取一個或所有地區。
    5. 選取**平台存取角色**。若要尋找每個角色的支援動作清單，請參閱[使用者存取權](/cs_access_reference.html#platform)。
    6. 按一下**指派**。
  * 若要存取某個資源群組中的某個叢集，或所有資源群組中的所有叢集，請執行下列動作：
    1. 按一下**指派對資源的存取權**。
    2. 從**服務**清單中，選取 **{{site.data.keyword.containershort_notm}}**。
    3. 從**地區**清單中，選取一個或所有地區。
    4. 從**服務實例**清單中，選取叢集名稱或**所有服務實例**。
    5. 在**選取角色**區段中，選擇 {{site.data.keyword.Bluemix_notm}} IAM 平台存取角色。若要尋找每個角色的支援動作清單，請參閱[使用者存取權](/cs_access_reference.html#platform)。附註：如果您將只針對某個叢集的**管理者**平台角色指派給使用者，則也必須將資源群組中該地區內之所有叢集的**檢視者**平台角色指派給使用者。
    6. 按一下**指派**。

4. 如果您要使用者能夠使用非 default 資源群組中的叢集，則這些使用者需要對叢集所在之資源群組的其他存取權。您至少可以將資源群組的**檢視者**平台角色指派給這些使用者。
  1. 按一下**指派資源群組內的存取權**。
  2. 選取資源群組名稱。
  3. 從**指派對資源群組的存取權**清單中，選取**檢視者**角色。此角色允許使用者存取資源群組本身，但不能存取群組內的資源。
  4. 按一下**指派**。

### 使用 CLI 指派 {{site.data.keyword.Bluemix_notm}} IAM 角色
{: #add_users_cli}

使用 CLI 指派 {{site.data.keyword.Bluemix_notm}} IAM 平台管理角色，以授與使用者對您叢集的存取權。
{: shortdesc}

**開始之前**：

- 驗證您已獲指派所使用之 {{site.data.keyword.Bluemix_notm}} 帳戶的 `cluster-admin` {{site.data.keyword.Bluemix_notm}} IAM 平台角色。
- 驗證已將使用者新增至帳戶。如果未將使用者新增至帳戶，則請執行 `ibmcloud account user-invite <user@email.com>`，邀請使用者加入帳戶。
- [登入您的帳戶。將目標設為適當的地區及（如果適用的話）資源群組。設定叢集的環境定義](cs_cli_install.html#cs_cli_configure)。

**若要使用 CLI 將 {{site.data.keyword.Bluemix_notm}} IAM 角色指派給個別使用者，請執行下列動作：**

1.  建立 {{site.data.keyword.Bluemix_notm}} IAM 存取原則來設定 {{site.data.keyword.containerlong_notm}} 的許可權 (**`--service-name containers-kubernetes`**)。您可以選擇「檢視者」、「編輯者」、「操作員」及「管理者」作為平台角色。若要尋找每個角色的支援動作清單，請參閱[使用者存取權](cs_access_reference.html#platform)。
    * 若要指派對資源群組中某個叢集的存取權，請執行下列指令：
      ```
      ibmcloud iam user-policy-create <user_email> --resource-group-name <resource_group_name> --service-name containers-kubernetes --region <region> --service-instance <cluster_ID> --roles <role>
      ```
      {: pre}

      **附註**：如果您將只針對某個叢集的**管理者**平台角色指派給使用者，則也必須將資源群組內該地區中之所有叢集的**檢視者**平台角色指派給使用者。

    * 若要指派對資源群組中所有叢集的存取權，請執行下列指令：
      ```
      ibmcloud iam user-policy-create <user_email> --resource-group-name <resource_group_name> --service-name containers-kubernetes [--region <region>] --roles <role>
      ```
      {: pre}

    * 若要指派對所有資源群組中所有叢集的存取權，請執行下列指令：
      ```
      ibmcloud iam user-policy-create <user_email> --service-name containers-kubernetes --roles <role>
      ```
      {: pre}

2. 如果您要使用者能夠使用非 default 資源群組中的叢集，則這些使用者需要對叢集所在之資源群組的其他存取權。您至少可以將資源群組的**檢視者**角色指派給這些使用者。您可以執行 `ibmcloud resource group <resource_group_name> --id` 來尋找資源群組 ID。
    ```
    ibmcloud iam user-policy-create <user-email_OR_access-group> --resource-type resource-group --resource <resource_group_ID> --roles Viewer
    ```
    {: pre}

3. 若要讓變更生效，請重新整理叢集配置。
    ```
    ibmcloud ks cluster-config --cluster <cluster_name_or_id>
    ```
    {: pre}

4. {{site.data.keyword.Bluemix_notm}} IAM 平台角色會自動套用為對應的 [RBAC 角色連結或叢集角色連結](#role-binding)。針對所指派的平台角色執行下列其中一個指令，驗證已將使用者新增至 RBAC 角色：
    * 檢視者：
        ```
        kubectl get rolebinding ibm-view -o yaml -n default
        ```
        {: pre}
    * 編輯者：
        ```
        kubectl get rolebinding ibm-edit -o yaml -n default
        ```
        {: pre}
    * 操作員：
        ```
        kubectl get clusterrolebinding ibm-operate -o yaml
        ```
        {: pre}
    * 管理者：
        ```
        kubectl get clusterrolebinding ibm-admin -o yaml
        ```
        {: pre}

  例如，如果您將**檢視者**平台角色指派給使用者 `john@email.com`，並執行 `kubectl get rolebinding ibm-view -o yaml -n default`，則輸出類似下列內容：

  ```
  apiVersion: rbac.authorization.k8s.io/v1
  kind: RoleBinding
  metadata:
    creationTimestamp: 2018-05-23T14:34:24Z
    name: ibm-view
    namespace: default
    resourceVersion: "8192510"
    selfLink: /apis/rbac.authorization.k8s.io/v1/namespaces/default/rolebindings/ibm-view
    uid: 63f62887-5e96-11e8-8a75-b229c11ba64a
  roleRef:
    apiGroup: rbac.authorization.k8s.io
    kind: ClusterRole
    name: view
  subjects:
  - apiGroup: rbac.authorization.k8s.io
    kind: User
    name: IAM#user@email.com
  ```
  {: screen}


**若要使用 CLI 將 {{site.data.keyword.Bluemix_notm}} IAM 平台角色指派給存取群組中的多位使用者，請執行下列動作：**

1. 建立存取群組。
    ```
    ibmcloud iam access-group-create <access_group_name>
    ```
    {: pre}

2. 將使用者新增至存取群組。
    ```
    ibmcloud iam access-group-user-add <access_group_name> <user_email>
    ```
    {: pre}

3. 建立 {{site.data.keyword.Bluemix_notm}} IAM 存取原則來設定 {{site.data.keyword.containerlong_notm}} 的許可權。您可以選擇「檢視者」、「編輯者」、「操作員」及「管理者」作為平台角色。若要尋找每個角色的支援動作清單，請參閱[使用者存取權](/cs_access_reference.html#platform)。
  * 若要指派對資源群組中某個叢集的存取權，請執行下列指令：
      ```
      ibmcloud iam access-group-policy-create <access_group_name> --resource-group-name <resource_group_name> --service-name containers-kubernetes --region <region> --service-instance <cluster_ID> --roles <role>
      ```
      {: pre}

      如果您將只針對某個叢集的**管理者**平台角色指派給使用者，則也必須將資源群組內該地區中之所有叢集的**檢視者**平台角色指派給使用者。
      {: note}

  * 若要指派對資源群組中所有叢集的存取權，請執行下列指令：
      ```
      ibmcloud iam access-group-policy-create <access_group_name> --resource-group-name <resource_group_name> --service-name containers-kubernetes [--region <region>] --roles <role>
      ```
      {: pre}

  * 若要指派對所有資源群組中所有叢集的存取權，請執行下列指令：
      ```
      ibmcloud iam access-group-policy-create <access_group_name> --service-name containers-kubernetes --roles <role>
      ```
      {: pre}

4. 如果您要使用者能夠使用非 default 資源群組中的叢集，則這些使用者需要對叢集所在之資源群組的其他存取權。您至少可以將資源群組的**檢視者**角色指派給這些使用者。您可以執行 `ibmcloud resource group <resource_group_name> --id` 來尋找資源群組 ID。
    ```
    ibmcloud iam access-group-policy-create <access_group_name> --resource-type resource-group --resource <resource_group_ID> --roles Viewer
    ```
    {: pre}

    1. 如果您已指派對所有資源群組中所有叢集的存取權，則請針對帳戶中的每個資源群組重複這個指令。

5. 若要讓變更生效，請重新整理叢集配置。
    ```
    ibmcloud ks cluster-config --cluster <cluster_name_or_id>
    ```
    {: pre}

6. {{site.data.keyword.Bluemix_notm}} IAM 平台角色會自動套用為對應的 [RBAC 角色連結或叢集角色連結](#role-binding)。針對所指派的平台角色執行下列其中一個指令，驗證已將使用者新增至 RBAC 角色：
    * 檢視者：
        ```
        kubectl get rolebinding ibm-view -o yaml -n default
        ```
        {: pre}
    * 編輯者：
        ```
        kubectl get rolebinding ibm-edit -o yaml -n default
        ```
        {: pre}
    * 操作員：
        ```
        kubectl get clusterrolebinding ibm-operate -o yaml
        ```
        {: pre}
    * 管理者：
        ```
        kubectl get clusterrolebinding ibm-admin -o yaml
        ```
        {: pre}

  例如，如果您將**檢視者**平台角色指派給存取群組 `team1`，並執行 `kubectl get rolebinding ibm-view -o yaml -n default`，則輸出類似下列內容：
  ```
  apiVersion: rbac.authorization.k8s.io/v1
  kind: RoleBinding
  metadata:
    creationTimestamp: 2018-05-23T14:34:24Z
    name: ibm-edit
    namespace: default
    resourceVersion: "8192510"
    selfLink: /apis/rbac.authorization.k8s.io/v1/namespaces/default/rolebindings/ibm-edit
    uid: 63f62887-5e96-11e8-8a75-b229c11ba64a
  roleRef:
    apiGroup: rbac.authorization.k8s.io
    kind: ClusterRole
    name: edit
  subjects:
  - apiGroup: rbac.authorization.k8s.io
    kind: group
    name: team1
  ```
  {: screen}

<br />



- 若要指派對個別使用者或存取群組中使用者的存取權，請確定使用者或群組已在 {{site.data.keyword.containerlong_notm}} 服務層次獲指派至少一個 [{{site.data.keyword.Bluemix_notm}}IAM 平台角色](#platform)。

若要建立自訂 RBAC 許可權，請執行下列動作：

1. 建立具有您要指派之存取權的角色或叢集角色。

    1. 建立 `.yaml` 檔案，以定義角色或叢集角色。

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
        <caption>瞭解 YAML 元件</caption>
          <thead>
            <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 元件</th>
          </thead>
          <tbody>
            <tr>
              <td><code>kind</code></td>
              <td>使用 `Role` 來授與對特定名稱空間內資源的存取權。使用 `ClusterRole` 來授與對全叢集資源（例如工作者節點）或名稱空間範圍資源（例如所有名稱空間中的 Pod）的存取權。</td>
            </tr>
            <tr>
              <td><code>apiVersion</code></td>
              <td><ul><li>對於執行 Kubernetes 1.8 或更新版本的叢集，請使用 `rbac.authorization.k8s.io/v1`。</li><li>對於較舊版本，請使用 `apiVersion: rbac.authorization.k8s.io/v1beta1`。</li></ul></td>
            </tr>
            <tr>
              <td><code>metadata.namespace</code></td>
              <td>僅限 `Role` 類型：指定授與存取權的 Kubernetes 名稱空間。</td>
            </tr>
            <tr>
              <td><code>metadata.name</code></td>
              <td>命名角色或叢集角色。</td>
            </tr>
            <tr>
              <td><code>rules.apiGroups</code></td>
              <td>指定您要使用者能夠與其互動的 Kubernetes [API 群組 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://v1-9.docs.kubernetes.io/docs/reference/api-overview/#api-groups)，例如 `"apps"`、`"batch"` 或 `"extensions"`。若要存取位於 REST 路徑 `apiv1` 的核心 API 群組，請將群組保留空白：`[""]`。</td>
            </tr>
            <tr>
              <td><code>rules.resources</code></td>
              <td>指定您要授與存取權的 Kubernetes [資源類型 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)，例如 `"daemonset"`、`"deployments"`、`"events"` 或 `"ingresses"`。如果您指定 `"nodes"`，則類型必須是 `ClusterRole`。</td>
            </tr>
            <tr>
              <td><code>rules.verbs</code></td>
              <td>指定您要使用者能夠執行的[動作類型 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/reference/kubectl/overview/)，例如 `"get"`、`"list"`、`"describe"`、`"create"` 或 `"delete"`。</td>
            </tr>
          </tbody>
        </table>

    2. 在叢集裡建立角色或叢集角色。

        ```
        kubectl apply -f my_role.yaml
        ```
        {: pre}

    3. 驗證已建立角色或叢集角色。
      * 角色：
          ```
          kubectl get roles -n <namespace>
          ```
          {: pre}

      * 叢集角色：
          ```
          kubectl get clusterroles
          ```
          {: pre}

2. 將使用者連結至角色或叢集角色。

    1. 建立 `.yaml` 檔案，以將使用者連結至您的角色或叢集角色。請注意要用於每一個主題名稱的唯一 URL。

        ```
        kind: RoleBinding
        apiVersion: rbac.authorization.k8s.io/v1
        metadata:
          name: my_role_binding
          namespace: default
        subjects:
        - kind: User
          name: IAM#user1@example.com
          apiGroup: rbac.authorization.k8s.io
        - kind: Group
          name: team1
          apiGroup: rbac.authorization.k8s.io
        - kind: ServiceAccount
          name: <service_account_name>
          namespace: <kubernetes_namespace>
        roleRef:
          kind: Role
          name: my_role
          apiGroup: rbac.authorization.k8s.io
        ```
        {: codeblock}

        <table>
        <caption>瞭解 YAML 元件</caption>
          <thead>
            <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 元件</th>
          </thead>
          <tbody>
            <tr>
              <td><code>kind</code></td>
              <td><ul><li>指定名稱空間特定 `Role` 或 `ClusterRole` 的 `RoleBinding`。</li><li>指定全叢集 `ClusterRole` 的 `ClusterRoleBinding`。</li></ul></td>
            </tr>
            <tr>
              <td><code>apiVersion</code></td>
              <td><ul><li>對於執行 Kubernetes 1.8 或更新版本的叢集，請使用 `rbac.authorization.k8s.io/v1`。</li><li>對於較舊版本，請使用 `apiVersion: rbac.authorization.k8s.io/v1beta1`。</li></ul></td>
            </tr>
            <tr>
              <td><code>metadata.namespace</code></td>
              <td><ul><li>對於 `RoleBinding` 類型：指定授與存取權的 Kubernetes 名稱空間。</li><li>對於 `ClusterRoleBinding` 類型：請不要使用 `namespace` 欄位。</li></ul></td>
            </tr>
            <tr>
              <td><code>metadata.name</code></td>
              <td>命名角色連結或叢集角色連結。</td>
            </tr>
            <tr>
              <td><code>subjects.kind</code></td>
              <td>將類型指定為下列其中一項：
              <ul><li>`User`：將 RBAC 角色或叢集角色連結至您帳戶中的個別使用者。</li>
              <li>`Group`：對於執行 Kubernetes 1.11 或更新版本的叢集，將 RBAC 角色或叢集角色連結至您帳戶中的 [{{site.data.keyword.Bluemix_notm}}IAM 存取群組](/docs/iam/groups.html#groups)。</li>
              <li>`ServiceAccount`：將 RBAC 角色或叢集角色連結至您叢集之名稱空間中的服務帳戶。</li></ul></td>
            </tr>
            <tr>
              <td><code>subjects.name</code></td>
              <td><ul><li>對於 `User`：將個別使用者的電子郵件位址附加到下列其中一個 URL。<ul><li>若為執行 Kubernetes 1.11 或更新版本的叢集：<code>IAM#user@email.com</code></li><li>若為執行 Kubernetes 1.10 或更早版本的叢集：<code>https://iam.ng.bluemix.net/kubernetes#user@email.com</code></li></ul></li>
              <li>對於 `Group`：針對執行 Kubernetes 1.11 或更新版本的叢集，指定您帳戶中 [{{site.data.keyword.Bluemix_notm}} IAM 存取群組](/docs/iam/groups.html#groups)的名稱。</li>
              <li>對於 `ServiceAccount`：指定服務帳戶名稱。</li></ul></td>
            </tr>
            <tr>
              <td><code>subjects.apiGroup</code></td>
              <td><ul><li>對於 `User` 或 `Group`：使用 `rbac.authorization.k8s.io`。</li>
              <li>對於 `ServiceAccount`：不包括此欄位。</li></ul></td>
            </tr>
            <tr>
              <td><code>subjects.namespace</code></td>
              <td>僅限 `ServiceAccount`：指定在其中部署服務帳戶的 Kubernetes 名稱空間名稱。</td>
            </tr>
            <tr>
              <td><code>roleRef.kind</code></td>
              <td>在角色 `.yaml` 檔案中輸入與 `kind` 相同的值：`Role` 或 `ClusterRole`。</td>
            </tr>
            <tr>
              <td><code>roleRef.name</code></td>
              <td>輸入角色 `.yaml` 檔案的名稱。</td>
            </tr>
            <tr>
              <td><code>roleRef.apiGroup</code></td>
              <td>使用 `rbac.authorization.k8s.io`。</td>
            </tr>
          </tbody>
        </table>

    2. 在叢集裡建立角色連結或叢集角色連結資源。

        ```
        kubectl apply -f my_role_binding.yaml
        ```
        {: pre}

    3.  驗證已建立連結。

        ```
        kubectl get rolebinding -n <namespace>
        ```
        {: pre}

3. 選用項目：若要強制執行其他名稱空間中的相同使用者存取層次，您可以將這些角色或叢集角色的角色連結複製到其他名稱空間。
    1. 將角色連結從某個名稱空間複製到另一個名稱空間。
        ```
        kubectl get rolebinding <role_binding_name> -o yaml | sed 's/<namespace_1>/<namespace_2>/g' | kubectl -n <namespace_2> create -f -
        ```
        {: pre}

        例如，若要將 `custom-role` 角色連結從 `default` 名稱空間複製到 `testns` 名稱空間，請執行下列指令：
    ```
        kubectl get rolebinding custom-role -o yaml | sed 's/default/testns/g' | kubectl -n testns create -f -
        ```
        {: pre}

    2. 驗證已複製角色連結。如果您已將 {{site.data.keyword.Bluemix_notm}} IAM 存取群組新增至角色連結，則會個別新增該群組中的每一個使用者，而不是作為存取群組 ID。
        ```
        kubectl get rolebinding -n <namespace_2>
        ```
        {: pre}

既然您已建立並連結自訂 Kubernetes RBAC 角色或叢集角色，請對使用者採取後續行動。要求他們測試由於該角色而具有許可權可以完成的動作，例如刪除 Pod。

<br />


</staging>
    ## 指派 RBAC 許可權
{: #role-binding}

請使用 RBAC 角色，來定義使用者可以採取的動作，以在您的叢集裡使用 Kubernetes 資源。
{: shortdesc}

**何謂 RBAC 角色及叢集角色？**</br>

RBAC 角色及叢集角色定義一組有關使用者如何與叢集裡的 Kubernetes 資源互動的許可權。角色限定為特定名稱空間內的資源（例如部署）。叢集角色限定為全叢集資源（例如工作者節點）或可在每個名稱空間中找到的名稱空間範圍資源（例如 Pod）。

**何謂 RBAC 角色連結及叢集角色連結？**</br>

角色連結會將 RBAC 角色或叢集角色套用至特定的名稱空間。當您使用角色連結來套用角色時，可以將特定名稱空間中特定資源的存取權授與使用者。當您使用角色連結來套用叢集角色時，可以將可在每個名稱空間中找到的名稱空間範圍資源（例如 Pod）的存取權授與使用者，但只限特定名稱空間內。

叢集角色連結會將 RBAC 叢集角色套用至叢集裡的所有名稱空間。當您使用叢集角色連結來套用叢集角色時，可以將全叢集資源（例如工作者節點）或每個名稱空間中名稱空間範圍資源（例如 Pod）的存取權授與使用者。

**這些角色在我的叢集裡看起來像什麼？**</br>

獲指派 [{{site.data.keyword.Bluemix_notm}}IAM 平台管理角色](#platform)的每位使用者，會自動獲指派對應的 RBAC 叢集角色。這些 RBAC 叢集角色已預先定義，並允許使用者與叢集裡的 Kubernetes 資源互動。此外，會建立角色連結以將叢集角色套用至特定的名稱空間，或建立叢集角色連結以將叢集角色套用至所有名稱空間。

下表說明 {{site.data.keyword.Bluemix_notm}} 平台角色與對應叢集角色之間的關係，以及針對平台角色自動建立的角色連結或叢集角色連結。

<table>
  <tr>
    <th>{{site.data.keyword.Bluemix_notm}} IAM 平台角色</th>
    <th>RBAC 叢集角色</th>
    <th>RBAC 角色連結</th>
    <th>RBAC 叢集角色連結</th>
  </tr>
  <tr>
    <td>檢視者</td>
    <td><code>view</code></td>
    <td>default 名稱空間中的 <code>ibm-view</code></td>
    <td>-</td>
  </tr>
  <tr>
    <td>編輯者</td>
    <td><code>edit</code></td>
    <td>default 名稱空間中的 <code>ibm-edit</code></td>
    <td>-</td>
  </tr>
  <tr>
    <td>操作員</td>
    <td><code>admin</code></td>
    <td>-</td>
    <td><code>ibm-operate</code></td>
  </tr>
  <tr>
    <td>管理者</td>
    <td><code>cluster-admin</code></td>
    <td>-</td>
    <td><code>ibm-admin</code></td>
  </tr>
</table>

若要進一步瞭解每個 RBAC 角色所允許的動作，請參閱[使用者存取權](cs_access_reference.html#platform)參照主題。
{: tip}

**如何在我的叢集裡管理特定名稱空間的 RBAC 許可權？**

如果您使用 [Kubernetes 名稱空間來分割叢集並提供工作負載的隔離](cs_secure.html#container)，則必須將特定名稱空間的存取權指派給使用者。當您將**操作員**或**管理者**平台角色指派給使用者時，會將對應的 `admin` 及 `cluster-admin` 預先定義叢集角色自動套用至整個叢集。不過，當您將**檢視者**或**編輯者**平台角色指派給使用者時，只會將對應的 `view` 及 `edit` 預先定義叢集角色自動套用至 default 名稱空間。若要強制執行其他名稱空間中的相同使用者存取層次，您可以將這些叢集角色 `ibm-view` 及 `ibm-edit` 的[角色連結複製](#rbac_copy)到其他名稱空間。

**我可以建立自訂角色或叢集角色嗎？**

`view`、`edit`、`admin` 及 `cluster-admin` 叢集角色是預先定義的角色，這些角色是在您將對應的 {{site.data.keyword.Bluemix_notm}} IAM 平台角色指派給使用者時所自動建立的角色。若要授與其他 Kubernetes 許可權，您可以[建立自訂 RBAC 許可權](#rbac)。

**何時需要使用叢集角色連結以及未關聯至所設定之 {{site.data.keyword.Bluemix_notm}} IAM 許可權的角色連結？**

建議您授權誰可以建立及更新您叢集裡的 Pod。使用 [Pod 安全原則](https://console.bluemix.net/docs/containers/cs_psp.html#psp)，您可以使用叢集隨附的現有叢集角色連結，或建立您自己的叢集角色連結。

也建議您將附加程式整合到叢集。例如，當您[在叢集裡設定 Helm](cs_integrations.html#helm) 時，必須在 `kube-system` 名稱空間中建立 Tiller 的服務帳戶，以及建立 `tiller-deploy` Pod 的 Kubernetes RBAC 叢集角色連結。

### 將 RBAC 角色連結複製到另一個名稱空間
{: #rbac_copy}

部分角色及叢集角色只會套用至一個名稱空間。例如，只會將 `view` 及 `edit` 預先定義叢集角色自動套用至 `default` 名稱空間。若要強制執行其他名稱空間中的相同使用者存取層次，您可以將這些角色或叢集角色的角色連結複製到其他名稱空間。
{: shortdesc}

例如，假設您將**編輯者**平台管理角色指派給使用者 "john@email.com"。則會在您的叢集裡自動建立預先定義的 RBAC 叢集角色 `edit`，而且 `ibm-edit` 角色連結會將許可權套用至 `default` 名稱空間。您要 "john@email.com" 也具有您開發名稱空間中的「編輯者」存取權，因此，您可以將 `ibm-edit` 角色連結從 `default` 複製到 `development`。**附註**：每次將使用者新增至 `view` 或 `edit` 角色時，您都必須複製角色連結。

1. 將角色連結從 `default` 複製到另一個名稱空間。
    ```
    kubectl get rolebinding <role_binding_name> -o yaml | sed 's/default/<namespace>/g' | kubectl -n <namespace> create -f -
    ```
    {: pre}

    例如，若要將 `ibm-edit` 角色連結複製到 `testns` 名稱空間，請執行下列指令：
    ```
    kubectl get rolebinding ibm-edit -o yaml | sed 's/default/testns/g' | kubectl -n testns create -f -
    ```
    {: pre}

2. 驗證已複製 `ibm-edit` 角色連結。
    ```
    kubectl get rolebinding -n <namespace>
    ```
    {: pre}

<br />


### 建立使用者、群組或服務帳戶的自訂 RBAC 許可權
{: #rbac}

當您指派對應的 {{site.data.keyword.Bluemix_notm}} IAM 平台管理角色時，會自動建立 `view`、`edit`、`admin` 及 `cluster-admin` 叢集角色。您是否需要比這些預先定義許可權所容許的更精細叢集存取原則？沒有問題！您可以建立自訂 RBAC 角色及叢集角色。
{: shortdesc}

您可以將自訂 RBAC 角色及叢集角色指派給個別使用者、使用者群組（在執行 Kubernetes 1.11 版或更新版本的叢集裡）或服務帳戶。為群組建立連結後，它會影響已新增至該群組或已從該群組移除的任何使用者。當您將使用者新增至群組時，除了您授與他們的任何個別存取權之外，他們還會取得群組的存取權。如果移除他們，則會撤銷其存取權。
**附註**：您不能將服務帳戶新增至存取群組。

如果您要指派對 Pod 中所執行之處理程序（例如持續交付工具鏈）的存取權，則可以使用 [Kubernetes ServiceAccounts ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/reference/access-authn-authz/service-accounts-admin/)。若要遵循指導教學，以示範如何設定 Travis 及 Jenkins 的服務帳戶，以及如何將自訂 RBAC 角色指派給 ServiceAccounts，請參閱[用於自動化系統中的 Kubernetes ServiceAccounts ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://medium.com/@jakekitchener/kubernetes-serviceaccounts-for-use-in-automated-systems-515297974982) 部落格文章。

**附註**：若要防止岔斷變更，請不要變更預先定義的 `view`、`edit`、`admin` 及 `cluster-admin` 叢集角色。

**我要建立角色還是叢集角色？我要使用角色連結還是叢集角色連結套用它？**

* 若要容許使用者、存取群組或服務帳戶存取特定名稱空間內的資源，請選擇下列其中一種組合：
  * 建立角色，並使用角色連結套用它。此選項適用於控制存取只存在於某個名稱空間中的唯一資源（例如應用程式部署）。
  * 建立叢集角色，並使用角色連結套用它。此選項適用於控制存取某個名稱空間中的一般資源（例如 Pod）。
* 若要容許使用者或存取群組存取全叢集資源或所有名稱空間中的資源，請建立叢集角色，並使用叢集角色連結套用它。此選項適用於控制存取未限定為名稱空間的資源（例如工作者節點）或叢集之所有名稱空間中的資源（例如每個名稱空間中的 Pod）。

開始之前：

- 將 [Kubernetes CLI](cs_cli_install.html#cs_cli_configure) 的目標設為您的叢集。
- 若要指派對個別使用者或存取群組中使用者的存取權，請確定使用者或群組已在 {{site.data.keyword.containerlong_notm}} 服務層次獲指派至少一個 [{{site.data.keyword.Bluemix_notm}}IAM 平台角色](#platform)。

若要建立自訂 RBAC 許可權，請執行下列動作：

1. 建立具有您要指派之存取權的角色或叢集角色。

    1. 建立 `.yaml` 檔案，以定義角色或叢集角色。

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
        <caption>瞭解 YAML 元件</caption>
          <thead>
            <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 元件</th>
          </thead>
          <tbody>
            <tr>
              <td><code>kind</code></td>
              <td>使用 `Role` 來授與對特定名稱空間內資源的存取權。使用 `ClusterRole` 來授與對全叢集資源（例如工作者節點）或名稱空間範圍資源（例如所有名稱空間中的 Pod）的存取權。</td>
            </tr>
            <tr>
              <td><code>apiVersion</code></td>
              <td><ul><li>對於執行 Kubernetes 1.8 或更新版本的叢集，請使用 `rbac.authorization.k8s.io/v1`。</li><li>對於較舊版本，請使用 `apiVersion: rbac.authorization.k8s.io/v1beta1`。</li></ul></td>
            </tr>
            <tr>
              <td><code>metadata.namespace</code></td>
              <td>僅限 `Role` 類型：指定授與存取權的 Kubernetes 名稱空間。</td>
            </tr>
            <tr>
              <td><code>metadata.name</code></td>
              <td>命名角色或叢集角色。</td>
            </tr>
            <tr>
              <td><code>rules.apiGroups</code></td>
              <td>指定您要使用者能夠與其互動的 Kubernetes [API 群組 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://v1-9.docs.kubernetes.io/docs/reference/api-overview/#api-groups)，例如 `"apps"`、`"batch"` 或 `"extensions"`。若要存取位於 REST 路徑 `apiv1` 的核心 API 群組，請將群組保留空白：`[""]`。</td>
            </tr>
            <tr>
              <td><code>rules.resources</code></td>
              <td>指定您要授與存取權的 Kubernetes [資源類型 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)，例如 `"daemonset"`、`"deployments"`、`"events"` 或 `"ingresses"`。如果您指定 `"nodes"`，則類型必須是 `ClusterRole`。</td>
            </tr>
            <tr>
              <td><code>rules.verbs</code></td>
              <td>指定您要使用者能夠執行的[動作類型 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/reference/kubectl/overview/)，例如 `"get"`、`"list"`、`"describe"`、`"create"` 或 `"delete"`。</td>
            </tr>
          </tbody>
        </table>

    2. 在叢集裡建立角色或叢集角色。

        ```
        kubectl apply -f my_role.yaml
        ```
        {: pre}

    3. 驗證已建立角色或叢集角色。
      * 角色：
          ```
          kubectl get roles -n <namespace>
          ```
          {: pre}

      * 叢集角色：
          ```
          kubectl get clusterroles
          ```
          {: pre}

2. 將使用者連結至角色或叢集角色。

    1. 建立 `.yaml` 檔案，以將使用者連結至您的角色或叢集角色。請注意要用於每一個主題名稱的唯一 URL。

        ```
        kind: RoleBinding
        apiVersion: rbac.authorization.k8s.io/v1
        metadata:
          name: my_role_binding
          namespace: default
        subjects:
        - kind: User
          name: IAM#user1@example.com
          apiGroup: rbac.authorization.k8s.io
        - kind: Group
          name: team1
          apiGroup: rbac.authorization.k8s.io
        - kind: ServiceAccount
          name: <service_account_name>
          namespace: <kubernetes_namespace>
        roleRef:
          kind: Role
          name: my_role
          apiGroup: rbac.authorization.k8s.io
        ```
        {: codeblock}

        <table>
        <caption>瞭解 YAML 元件</caption>
          <thead>
            <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解 YAML 元件</th>
          </thead>
          <tbody>
            <tr>
              <td><code>kind</code></td>
              <td><ul><li>指定名稱空間特定 `Role` 或 `ClusterRole` 的 `RoleBinding`。</li><li>指定全叢集 `ClusterRole` 的 `ClusterRoleBinding`。</li></ul></td>
            </tr>
            <tr>
              <td><code>apiVersion</code></td>
              <td><ul><li>對於執行 Kubernetes 1.8 或更新版本的叢集，請使用 `rbac.authorization.k8s.io/v1`。</li><li>對於較舊版本，請使用 `apiVersion: rbac.authorization.k8s.io/v1beta1`。</li></ul></td>
            </tr>
            <tr>
              <td><code>metadata.namespace</code></td>
              <td><ul><li>對於 `RoleBinding` 類型：指定授與存取權的 Kubernetes 名稱空間。</li><li>對於 `ClusterRoleBinding` 類型：請不要使用 `namespace` 欄位。</li></ul></td>
            </tr>
            <tr>
              <td><code>metadata.name</code></td>
              <td>命名角色連結或叢集角色連結。</td>
            </tr>
            <tr>
              <td><code>subjects.kind</code></td>
              <td>將類型指定為下列其中一項：
              <ul><li>`User`：將 RBAC 角色或叢集角色連結至您帳戶中的個別使用者。</li>
              <li>`Group`：對於執行 Kubernetes 1.11 或更新版本的叢集，將 RBAC 角色或叢集角色連結至您帳戶中的 [{{site.data.keyword.Bluemix_notm}}IAM 存取群組](/docs/iam/groups.html#groups)。</li>
              <li>`ServiceAccount`：將 RBAC 角色或叢集角色連結至您叢集之名稱空間中的服務帳戶。</li></ul></td>
            </tr>
            <tr>
              <td><code>subjects.name</code></td>
              <td><ul><li>對於 `User`：將個別使用者的電子郵件位址附加到下列其中一個 URL。<ul><li>若為執行 Kubernetes 1.11 或更新版本的叢集：<code>IAM#user@email.com</code></li><li>若為執行 Kubernetes 1.10 或更早版本的叢集：<code>https://iam.ng.bluemix.net/kubernetes#user@email.com</code></li></ul></li>
              <li>對於 `Group`：對於執行 Kubernetes 1.11 或更新版本的叢集，指定您帳戶中 [{{site.data.keyword.Bluemix_notm}}IAM 群組](/docs/iam/groups.html#groups)的名稱。</li>
              <li>對於 `ServiceAccount`：指定服務帳戶名稱。</li></ul></td>
            </tr>
            <tr>
              <td><code>subjects.apiGroup</code></td>
              <td><ul><li>對於 `User` 或 `Group`：使用 `rbac.authorization.k8s.io`。</li>
              <li>對於 `ServiceAccount`：不包括此欄位。</li></ul></td>
            </tr>
            <tr>
              <td><code>subjects.namespace</code></td>
              <td>僅限 `ServiceAccount`：指定在其中部署服務帳戶的 Kubernetes 名稱空間名稱。</td>
            </tr>
            <tr>
              <td><code>roleRef.kind</code></td>
              <td>在角色 `.yaml` 檔案中輸入與 `kind` 相同的值：`Role` 或 `ClusterRole`。</td>
            </tr>
            <tr>
              <td><code>roleRef.name</code></td>
              <td>輸入角色 `.yaml` 檔案的名稱。</td>
            </tr>
            <tr>
              <td><code>roleRef.apiGroup</code></td>
              <td>使用 `rbac.authorization.k8s.io`。</td>
            </tr>
          </tbody>
        </table>

    2. 在叢集裡建立角色連結或叢集角色連結資源。

        ```
        kubectl apply -f my_role_binding.yaml
        ```
        {: pre}

    3.  驗證已建立連結。

        ```
        kubectl get rolebinding -n <namespace>
        ```
        {: pre}

既然您已建立並連結自訂 Kubernetes RBAC 角色或叢集角色，請對使用者採取後續行動。要求他們測試由於該角色而具有許可權可以完成的動作，例如刪除 Pod。

<br />




## 自訂基礎架構許可權
{: #infra_access}

當您將**超級使用者**基礎架構角色指派給設定 API 金鑰或設定其基礎架構認證的管理者時，帳戶內的其他使用者會共用 API 金鑰或認證來執行基礎架構動作。您接著可以指派適當的 [{{site.data.keyword.Bluemix_notm}}IAM 平台角色](#platform)，以控制使用者可以執行的基礎架構動作。您不需要編輯使用者的 IBM Cloud 基礎架構 (SoftLayer) 許可權。
{: shortdesc}

基於法規遵循、安全或計費原因，您可能不想將**超級使用者**基礎架構角色指派給設定 API 金鑰的使用者，或使用 `ibmcloud ks credential-set` 指令設定其認證的使用者。不過，如果此使用者沒有**超級使用者**角色，則基礎架構相關動作（例如建立叢集或重新載入工作者節點）可能會失敗。您必須針對使用者設定特定 IBM Cloud 基礎架構 (SoftLayer) 許可權，而不是使用 {{site.data.keyword.Bluemix_notm}} IAM 平台角色來控制使用者的基礎架構存取權。

如果您有多個叢集，則您的 IBM Cloud 基礎架構 (SoftLayer) 帳戶擁有者需要開啟 VLAN Spanning，不同區域中的節點才能在叢集內通訊。帳戶擁有者也可將**網路 > 管理網路 VLAN Spanning** 許可權指派給使用者，讓使用者可以啟用 VLAN Spanning。若要確認是否已啟用 VLAN Spanning，請使用 `ibmcloud ks vlan-spanning-get` [指令](cs_cli_reference.html#cs_vlan_spanning_get)。
{: tip}

開始之前，請確定您是帳戶擁有者或具有**超級使用者**及所有裝置存取權。您無法將您沒有的存取權授與使用者。

1. 登入 [{{site.data.keyword.Bluemix_notm}} 主控台](https://console.bluemix.net/)，並導覽至**管理 > 帳戶 > 使用者**。

2. 按一下您要為其設定許可權的使用者名稱。

3. 按一下**指派存取權**，然後按一下**將存取權指派給 SoftLayer 帳戶**。

4. 按一下**入口網站許可權**標籤，以自訂使用者的存取權。使用者需要的許可權取決於他們需要使用的基礎架構資源。您有兩個選項可以指派存取權：
    * 使用**快速許可權**下拉清單，來指派下列其中一個預先定義角色。選取角色之後，請按一下**設定許可權**。
        * **僅檢視使用者**僅將檢視基礎架構詳細資料的許可權授與使用者。
        * **基本使用者**會將部分（但並非所有）基礎架構許可權授與使用者。
        * **超級使用者**會將所有基礎架構許可權授與使用者。
    * 在每個標籤中選取個別許可權。若要檢閱在 {{site.data.keyword.containerlong_notm}} 中執行一般作業所需的許可權，請參閱[使用者存取權](cs_access_reference.html#infra)。

5.  若要儲存您的變更，請按一下**編輯入口網站許可權**。

6.  在**裝置存取權**標籤中，選取要授與存取權的裝置。

    * 在**裝置類型**下拉清單中，您可以授與對**所有裝置**的存取權，讓使用者可以使用工作者節點的虛擬及實體（裸機硬體）機器類型。
    * 若要容許使用者存取所建立的新裝置，請選取**新增裝置時自動授與存取權**。
    * 在裝置的表格中，確定已選取適當的裝置。

7. 若要儲存您的變更，請按一下**更新裝置存取權**。

要降級許可權嗎？此動作可能需要幾分鐘的時間才能完成。
{: tip}

<br />


## 移除使用者許可權
{: #removing}

如果使用者不再需要特定的存取許可權，或如果使用者離開您的組織，則 {{site.data.keyword.Bluemix_notm}} 帳戶擁有者可以移除該使用者的許可權。
{: shortdesc}

在您移除使用者的特定存取許可權，或從您的帳戶中完整移除使用者之前，請確定使用者的基礎架構認證不是用來設定 API 金鑰，也不是用於 `ibmcloud ks credential-set` 指令。否則，帳戶中的其他使用者可能無法存取 IBM Cloud 基礎架構 (SoftLayer) 入口網站，而且基礎架構相關指令可能失敗。
{: important}

1. 將 CLI 環境定義的目標設為您具有叢集的地區及資源群組。
    ```
    ibmcloud target -g <resource_group_name> -r <region>
    ```
    {: pre}

2. 檢查 API 金鑰的擁有者，或針對該地區及資源群組設定的基礎架構認證。
    * 如果您使用 [API 金鑰來存取 IBM Cloud 基礎架構 (SoftLayer) 組合](#default_account)，請執行下列指令：
        ```
        ibmcloud ks api-key-info --cluster <cluster_name_or_id>
        ```
        {: pre}
    * 如果您設定[基礎架構認證以存取 IBM Cloud 基礎架構 (SoftLayer) 組合](#credentials)，請執行下列指令：
        ```
        ibmcloud ks credential-get
        ```
        {: pre}

3. 如果傳回使用者的使用者名稱，請使用另一個使用者的認證，來設定 API 金鑰或基礎架構認證。

  如果帳戶擁有者未設定 API 金鑰，或您未設定帳戶擁有者的基礎架構認證，請[確保設定 API 金鑰的使用者，或您設定其認證的使用者具有正確的許可權](#owner_permissions)。
  {: note}

    * 若要重設 API 金鑰，請執行下列指令：
        ```
        ibmcloud ks api-key-reset
        ```
        {: pre}
    * 若要重設基礎架構認證，請執行下列指令：
        ```
        ibmcloud ks credential-set --infrastructure-username <infrastructure_API_username> --infrastructure-api-key <infrastructure_API_authentication_key>
        ```
        {: pre}

4. 針對您在其中具有叢集之資源群組及地區的每一種組合，重複這些步驟。

### 從您的帳戶移除使用者
{: #remove_user}

如果您帳戶中的使用者離開您的組織，您必須仔細地移除該使用者的許可權，以確保不會孤立叢集或其他資源。之後，您可以從 {{site.data.keyword.Bluemix_notm}} 帳戶移除使用者。
{: shortdesc}

開始之前：
- [確定使用者的基礎架構認證不是用來設定 API 金鑰，也不是用於 `ibmcloud ks credential-set` 指令](#removing)。
- 如果您在 {{site.data.keyword.Bluemix_notm}} 帳戶中具有使用者可能已佈建的其他服務實例，請檢查這些服務的文件，以找出在移除帳戶中的使用者之前必須完成的所有步驟。

在使用者離開之前，{{site.data.keyword.Bluemix_notm}} 帳戶擁有者必須完成下列步驟，以防止岔斷 {{site.data.keyword.containerlong_notm}} 中的變更。

1. 判斷使用者已建立了哪些叢集。
    1.  登入 [{{site.data.keyword.containerlong_notm}} 主控台 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://console.bluemix.net/containers-kubernetes/clusters)。
    2.  從表格中，選取您的叢集。
    3.  在**概觀**標籤中，尋找**擁有者**欄位。

2. 對於使用者所建立的每一個叢集，請遵循下列步驟：
    1. 檢查使用者已使用哪個基礎架構帳戶來佈建叢集。
        1.  在**工作者節點**標籤中，選取工作者節點，並記下其 **ID**。
        2.  開啟功能表 ![「功能表」圖示](../icons/icon_hamburger.svg "「功能表」圖示")，然後按一下**基礎架構**。
        3.  從基礎架構導覽窗格中，按一下**裝置 > 裝置清單**。
        4.  搜尋您先前記下的工作者節點 ID。
        5.  如果您找不到工作者節點 ID，則未將工作者節點佈建至此基礎架構帳戶。請切換至不同的基礎架構帳戶，然後再試一次。
    2. 判斷在使用者離開之後，使用者用來佈建叢集的基礎架構帳戶將發生什麼情況。
        * 如果使用者未擁有基礎架構帳戶，則其他使用者可以存取此基礎架構帳戶，且會在使用者離開之後持續保存。您可以繼續在帳戶中使用這些叢集。請確定至少有一個其他使用者具有叢集的[**管理者**平台角色](#platform)。
        * 如果使用者擁有基礎架構帳戶，則當使用者離開時，系統會刪除基礎架構帳戶。您無法繼續使用這些叢集。若要防止叢集成為孤立的叢集，使用者必須在離開之前刪除叢集。如果使用者已離開，但未刪除叢集，則您必須使用 `ibmcloud k credential - set` 指令，將基礎架構認證變更為叢集工作者節點佈建所在的帳戶，然後刪除叢集。如需相關資訊，請參閱[無法修改或刪除孤立叢集裡的基礎架構](cs_troubleshoot_clusters.html#orphaned)。

3. 移除 {{site.data.keyword.Bluemix_notm}} 帳戶中的使用者。
    1. 導覽至**管理 > 帳戶 > 使用者**。
    2. 按一下使用者的使用者名稱。
    3. 在使用者的表格項目中，按一下動作功能表，然後選取**移除使用者**。當您移除使用者時，會自動移除使用者獲指派的 {{site.data.keyword.Bluemix_notm}} IAM 平台角色、Cloud Foundry 角色，以及 IBM Cloud 基礎架構 (SoftLayer) 角色。

4. 移除 {{site.data.keyword.Bluemix_notm}} IAM 平台許可權時，也會從關聯的預先定義 RBAC 角色中自動移除使用者的許可權。不過，如果您已建立自訂 RBAC 角色或叢集角色，請[移除那些 RBAC 角色連結或叢集角色連結的使用者](#remove_custom_rbac)。

5. 如果您具有自動鏈結至 {{site.data.keyword.Bluemix_notm}} 帳戶的「隨收隨付制」帳戶，則會自動移除使用者的 IBM Cloud 基礎架構 (SoftLayer) 角色。不過，如果您具有[不同類型的帳戶](#understand_infra)，則可能需要手動從 IBM Cloud 基礎架構 (SoftLayer) 移除使用者。
    1. 在 [{{site.data.keyword.Bluemix_notm}} 主控台](https://console.bluemix.net/)功能表 ![「功能表」圖示](../icons/icon_hamburger.svg "「功能表」圖示") 中，按一下**基礎架構**。
    2. 導覽至**帳戶 > 使用者 > 使用者清單**。
    2. 尋找使用者的表格項目。
        * 如果您沒有看到使用者的項目，則表示已移除該使用者。不需要執行任何進一步動作。
        * 如果您看到使用者的項目，請繼續下一步。
    3. 在使用者的表格項目中，按一下「動作」功能表。
    4. 選取**變更使用者狀態**。
    5. 在「狀態」清單中，選取**已停用**。按一下**儲存**。


### 移除特定的許可權
{: #remove_permissions}

如果您要移除使用者的特定許可權，則可以移除已指派給使用者的個別存取原則。
{: shortdesc}

開始之前，[確定使用者的基礎架構認證不是用來設定 API 金鑰，也不是用於 `ibmcloud ks credential-set` 指令](#removing)。之後，您可以移除：
* [存取群組中的使用者](#remove_access_group)
* [使用者的 {{site.data.keyword.Bluemix_notm}} IAM 平台及關聯的 RBAC 許可權](#remove_iam_rbac)
* [使用者的自訂 RBAC 許可權](#remove_custom_rbac)
* [使用者的 Cloud Foundry 許可權](#remove_cloud_foundry)
* [使用者的基礎架構許可權](#remove_infra)

#### 從存取群組移除使用者
{: #remove_access_group}

1. 登入 [{{site.data.keyword.Bluemix_notm}} 主控台](https://console.bluemix.net/)，並導覽至**管理 > 帳戶 > 使用者**。
2. 按一下您要從中移除許可權的使用者名稱。
3. 按一下**存取群組**標籤。
4. 在存取群組的表格項目中，按一下動作功能表，然後選取**移除使用者**。移除使用者時，會從使用者移除任何已指派給存取群組的角色。

#### 移除 {{site.data.keyword.Bluemix_notm}} IAM 平台許可權及關聯的預先定義 RBAC 許可權
{: #remove_iam_rbac}

1. 登入 [{{site.data.keyword.Bluemix_notm}} 主控台](https://console.bluemix.net/)，並導覽至**管理 > 帳戶 > 使用者**。
2. 按一下您要從中移除許可權的使用者名稱。
3. 在您要移除之許可權的表格項目中，按一下動作功能表。
4. 選取**移除。**
5. 移除 {{site.data.keyword.Bluemix_notm}} IAM 平台許可權時，也會從關聯的預先定義 RBAC 角色中自動移除使用者的許可權。若要使用這些變更來更新 RBAC 角色，請執行 `ibmcloud k cluster-config`。不過，如果您已建立[自訂 RBAC 角色或叢集角色](#rbac)，則必須從 `.yaml` 檔案移除那些 RBAC 角色連結或叢集角色連結的使用者。請參閱以下移除自訂 RBAC 許可權的步驟。

#### 移除自訂 RBAC 許可權
{: #remove_custom_rbac}

如果您不再需要自訂的 RBAC 許可權，則可以將它們移除。
{: shortdesc}

1. 針對您所建立的角色連結或叢集角色連結，開啟 `.yaml` 檔案。
2. 在 `subjects` 區段中，移除使用者的區段。
3. 儲存檔案。
4. 在您的叢集裡套用角色連結或叢集角色連結資源中的變更。
    ```
    kubectl apply -f my_role_binding.yaml
    ```
    {: pre}

#### 移除 Cloud Foundry 許可權
{: #remove_cloud_foundry}

若要移除所有使用者的 Cloud Foundry 許可權，您可以移除使用者的組織角色。如果您只要移除使用者的能力（例如，連結叢集裡的服務），則只會移除使用者的空間角色。
{: shortdesc}

1. 登入 [{{site.data.keyword.Bluemix_notm}} 主控台](https://console.bluemix.net/)，並導覽至**管理 > 帳戶 > 使用者**。
2. 按一下您要從中移除許可權的使用者名稱。
3. 按一下 **Cloud Foundry 存取**標籤。
    * 若要移除使用者的空間角色，請執行下列動作：
        1. 展開空間所在組織的表格項目。
        2. 在空間角色的表格項目中，按一下動作功能表，然後選取**編輯空間角色**。
        3. 按一下關閉按鈕來刪除角色。
        4. 若要移除所有空間角色，請在下拉清單中選取**無空間角色**。
        5. 按一下**儲存角色**。
    * 若要移除使用者的組織角色，請執行下列動作：
        1. 在組織角色的表格項目中，按一下動作功能表，然後選取**編輯組織角色**。
        3. 按一下關閉按鈕來刪除角色。
        4. 若要移除所有組織角色，請在下拉清單中選取**無組織角色**。
        5. 按一下**儲存角色**。

#### 移除 IBM Cloud 基礎架構 (SoftLayer) 許可權
{: #remove_infra}

您可以使用 {{site.data.keyword.Bluemix_notm}} 主控台，來移除使用者的 IBM Cloud 基礎架構 (SoftLayer) 許可權。
{: shortdesc}

1. 登入 [{{site.data.keyword.Bluemix_notm}} 主控台](https://console.bluemix.net/)。
2. 從功能表 ![「功能表」圖示](../icons/icon_hamburger.svg "「功能表」圖示") 中，按一下**基礎架構**。
3. 按一下使用者的電子郵件位址。
4. 按一下**入口網站許可權**標籤。
5. 在每一個標籤中，取消選取特定的許可權。
6. 若要儲存您的變更，請按一下**編輯入口網站許可權**。
7. 在**裝置存取**標籤中，取消選取特定的裝置。
8. 若要儲存您的變更，請按一下**更新裝置存取**。在幾分鐘之後，許可權即會降級。

<br />



