---

copyright:
  years: 2014, 2018
lastupdated: "2018-08-06"


---

{:new_window: target="blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# 指派叢集存取
{: #users}

身為叢集管理者，您可以為 Kubernetes 叢集定義存取原則，以針對不同使用者建立不同的存取層次。例如，您可以授權某些使用者使用叢集資源，而其他使用者則只能部署容器。
{: shortdesc}


## 瞭解存取原則及許可權
{: #access_policies}

<dl>
  <dt>必須設定存取原則嗎？</dt>
    <dd>您必須針對使用 {{site.data.keyword.containershort_notm}} 的每一個使用者定義存取原則。存取原則的範圍是根據使用者定義的角色來決定容許他們執行的動作。部分原則是預先定義的，但可以自訂其他原則。不論使用者是從 {{site.data.keyword.containershort_notm}} GUI 還是透過 CLI 提出要求，都會強制執行相同的原則，即使在 IBM Cloud 基礎架構 (SoftLayer) 中完成動作也一樣。</dd>

  <dt>許可權的類型有哪些？</dt>
    <dd><p><strong>平台</strong>：{{site.data.keyword.containershort_notm}} 配置為使用 {{site.data.keyword.Bluemix_notm}} 平台角色，以決定個體可在叢集上執行的動作。角色許可權是根據彼此來建置，這表示 `Editor` 角色具有與 `Viewer` 角色相同的所有許可權，加上授與編輯者的許可權。您可以依地區設定這些原則。這些原則必須與基礎架構原則一起設定，並具有自動指派給 default 名稱空間的對應 RBAC 角色。範例動作是建立或移除叢集，或新增額外的工作者節點。</p> <p><strong>基礎架構</strong>：您可以判斷基礎架構的存取層次，例如叢集節點機器、網路或儲存空間資源。您必須同時設定此類型的原則與 {{site.data.keyword.containershort_notm}} 平台存取原則。若要瞭解可用角色，請查看[基礎架構許可權](/docs/iam/infrastructureaccess.html#infrapermission)。除了授與特定基礎架構角色之外，您還必須將裝置存取權授與使用基礎架構的使用者。
若要開始指派角色，請遵循[自訂使用者的基礎架構許可權](#infra_access)中的步驟。<strong>附註</strong>：請確定 {{site.data.keyword.Bluemix_notm}} 帳戶已[設定 IBM Cloud 基礎架構 (SoftLayer) 組合存取權](cs_troubleshoot_clusters.html#cs_credentials)，讓獲得授權的使用者可以根據被指派的權限，在 IBM Cloud 基礎架構 (SoftLayer) 帳戶中執行動作。</p> <p><strong>RBAC</strong>：資源型存取控制 (RBAC) 是一種保護叢集內資源，以及決定誰可以執行哪些 Kubernetes 動作的方式。每個獲指派平台存取原則的使用者都會自動獲指派 Kubernetes 角色。在 Kubernetes 中，[角色型存取控制 (RBAC) ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#api-overview) 決定使用者可對叢集內的資源執行的動作。<strong>附註</strong>：會自動設定 RBAC 角色與 default 名稱空間的平台角色。當您作為叢集管理者時，可以為其他名稱空間[更新或指派角色](#rbac)。</p> <p><strong>Cloud Foundry</strong>：無法使用 Cloud IAM 來管理所有服務。如果您是使用其中一個服務，則可以繼續使用 [Cloud Foundry 使用者角色](/docs/iam/cfaccess.html#cfaccess)，控制服務的存取。範例動作為連結服務或建立新的服務實例。</p></dd>

  <dt>如何設定許可權？</dt>
    <dd><p>設定「平台」許可權時，您可以將存取權指派給特定使用者、使用者群組或 default 資源群組。設定平台許可權時，會自動為 default 名稱空間配置 RBAC 角色，並建立 RoleBinding。</p>
    <p><strong>使用者</strong>：您可能有一個特定使用者，比您的其餘團隊成員需要更多或更少的許可權。您可以根據個人自訂許可權，讓每一個人員都有正確數量的必要許可權來完成其作業。</p>
    <p><strong>存取群組</strong>：您可以建立使用者群組，然後將許可權指派給特定群組。例如，您可以將所有團隊領導人分組，並給與該群組管理者存取權。同時，您的開發人員群組只有寫入權。</p>
    <p><strong>資源群組</strong>：您可以使用 IAM，來建立資源群組的存取原則，並將使用者存取權授與這個群組。這些資源可以是 {{site.data.keyword.Bluemix_notm}} 服務的一部分，或者您也可以跨服務實例將資源分組，例如 {{site.data.keyword.containershort_notm}} 叢集和 CF 應用程式。</p> <p>**重要事項**：{{site.data.keyword.containershort_notm}} 僅支援 <code>default</code> 資源群組。<code>default</code> 資源群組會自動提供所有叢集相關資源。如果您在 {{site.data.keyword.Bluemix_notm}} 帳戶中有想要與叢集搭配使用的其他服務，則這些服務也須位於 <code>default</code> 資源群組中。</p></dd>
</dl>


感覺不知所措嗎？請試用本指導教學，其關於[組織使用者、團隊及應用程式的最佳作法](/docs/tutorials/users-teams-applications.html)。
{: tip}

<br />


## 存取 IBM Cloud 基礎架構 (SoftLayer) 組合
{: #api_key}

<dl>
  <dt>為什麼需要存取 IBM Cloud infrastructure (SoftLayer) 組合？</dt>
    <dd>若要順利在帳戶中佈建及使用叢集，您必須確定已正確設定您的帳戶，可存取 IBM Cloud 基礎架構 (SoftLayer) 組合。根據您的帳戶設定，您可以使用 IAM API 金鑰或使用 `ibmcloud ks credentials-set` 指令手動設定的基礎架構認證。</dd>

  <dt>IAM API 金鑰如何使用 {{site.data.keyword.containershort_notm}}？</dt>
    <dd><p>當執行第一個需要 {{site.data.keyword.containershort_notm}} 管理存取原則的動作時，會針對地區自動設定 Identity and Access Management (IAM) API 金鑰。例如，其中一位管理使用者會在 <code>us-south</code> 地區中建立第一個叢集。如此一來，這位使用者的 IAM API 金鑰就會儲存在這個地區的帳戶中。API 金鑰會用來訂購 IBM Cloud 基礎架構 (SoftLayer)，例如新的工作者節點或 VLAN。</p> <p>當另一位使用者在此地區中執行需要與 IBM Cloud 基礎架構 (SoftLayer) 組合互動的動作（例如建立新叢集或重新載入工作者節點）時，會使用儲存的 API 金鑰來判斷是否有足夠的許可權可執行該動作。為了確保可以順利執行叢集裡的基礎架構相關動作，請對 {{site.data.keyword.containershort_notm}} 管理使用者指派<strong>超級使用者</strong>基礎架構存取原則。</p> <p>您可以執行 [<code>ibmcloud ks api-key-info</code>](cs_cli_reference.html#cs_api_key_info) 來尋找現行 API 金鑰擁有者。如果您發現需要更新針對某地區所儲存的 API 金鑰，即可執行 [<code>ibmcloud ks api-key-reset</code>](cs_cli_reference.html#cs_api_key_reset) 指令來達成此目的。這個指令需要 {{site.data.keyword.containershort_notm}} 管理存取原則，它會將執行這個指令的使用者的 API 金鑰儲存在帳戶中。如果 IBM Cloud 基礎架構 (SoftLayer) 認證是使用 <code>ibmcloud ks credentials-set</code> 指令手動設定的，則可能不會使用針對該地區所儲存的 API 金鑰。</p> <p><strong>附註：</strong>請務必重設金鑰，並瞭解這對應用程式的影響。金鑰用於數個不同的工作區，如果對其進行不需要的變更，則可能導致岔斷變更。</p></dd>

  <dt><code>ibmcloud ks credentials-set</code> 指令有何作用？</dt>
    <dd><p>如果您有 {{site.data.keyword.Bluemix_notm}}「隨收隨付制」帳戶，依預設，您便可以存取 IBM Cloud 基礎架構 (SoftLayer) 組合。不過，建議您使用您已具有的不同 IBM Cloud 基礎架構 (SoftLayer) 帳戶來訂購基礎架構。您可以使用 [<code>ibmcloud ks credentials-set</code>](cs_cli_reference.html#cs_credentials_set) 指令，將此基礎架構帳戶鏈結至 {{site.data.keyword.Bluemix_notm}} 帳戶。</p> <p>若要移除手動設定的 IBM Cloud 基礎架構 (SoftLayer) 認證，您可以使用 [<code>ibmcloud ks credentials-unset</code>](cs_cli_reference.html#cs_credentials_unset) 指令。移除認證之後，會使用 IAM API 金鑰來訂購基礎架構。</p></dd>

  <dt>兩者之間有差異嗎？</dt>
    <dd>API 金鑰與 <code>ibmcloud ks credentials-set</code> 指令都會完成相同的作業。如果您使用 <code>ibmcloud ks credentials-set</code> 指令手動設定認證，則設定的認證會置換 API 金鑰所授與的任何存取權。不過，如果已儲存其認證的使用者沒有訂購基礎架構的必要許可權，則基礎架構相關動作（例如建立叢集或重新載入工作者節點）可能會失敗。</dd>
</dl>


若要讓使用 API 金鑰更為輕鬆，請嘗試建立您可以用來設定許可權的功能 ID。
{: tip}

<br />



## 瞭解角色關係
{: #user-roles}

在您可以瞭解哪個角色可以執行每一個動作之前，瞭解角色如何彼此整合很重要。
{: shortdesc}

下圖顯示您組織中每一種類型的人員可能需要的角色。不過，每個組織各有不同。

![{{site.data.keyword.containershort_notm}} 存取角色](/images/user-policies.png)

圖. 依角色類型的 {{site.data.keyword.containershort_notm}} 存取許可權

<br />



## 使用 GUI 指派角色
{: #add_users}

您可以將使用者新增至 {{site.data.keyword.Bluemix_notm}} 帳戶，以使用 GUI 授與對叢集的存取權。
{: shortdesc}

**開始之前**

- 驗證您的使用者已新增至帳戶。如果沒有，請新增[他們](../iam/iamuserinv.html#iamuserinv)。
- 驗證您已獲指派您工作所在之 {{site.data.keyword.Bluemix_notm}} 帳戶的 `Manager` [Cloud Foundry 角色](/docs/iam/mngcf.html#mngcf)。

**將存取權指派給使用者**

1. 導覽至**管理 > 使用者**。即會顯示可以存取帳戶之使用者的清單。

2. 按一下您要為其設定許可權的使用者名稱。如果使用者未顯示，請按一下**邀請使用者**，將他們新增至帳戶。

3. 指派原則。
  * 若為資源群組：
    1. 選取 **default** 資源群組。可以僅針對 default 資源群組配置 {{site.data.keyword.containershort_notm}} 存取權。
  * 若為特定資源：
    1. 從**服務**清單中，選取 **{{site.data.keyword.containershort_notm}}**。
    2. 從**地區**清單中，選取地區。
    3. 從**服務實例**清單中，選取要邀請使用者加入的叢集。若要尋找特定叢集的 ID，請執行 `ibmcloud ks clusters`。

4. 在**選取角色**區段中，選擇角色。 

5. 按一下**指派**。

6. 指派 [Cloud Foundry 角色](/docs/iam/mngcf.html#mngcf)。

7. 選用項目：指派[基礎架構角色](/docs/iam/infrastructureaccess.html#infrapermission)。

</br>

**將存取權指派給群組**

1. 導覽至**管理 > 存取群組**。

2. 建立存取群組。
  1. 按一下**建立**，並為群組指定一個**名稱**及**說明**。按一下**建立**。
  2. 按一下**新增使用者**，將人員新增至您的存取群組。即會顯示可以存取您帳戶的使用者清單。
  3. 勾選您要新增至群組之使用者旁的方框。即會顯示一個對話框。
  4. 按一下**新增至群組**。

3. 若要將存取權指派給特定服務，請新增服務 ID。
  1. 按一下**新增服務 ID**。
  2. 勾選您要新增至群組之使用者旁的方框。即會顯示一個蹦現畫面。
  3. 按一下**新增至群組**。

4. 指派存取原則。請不要忘記重複確認您要新增至群組的人員。對群組中的每個人都提供了相同層次的存取權。
    * 若為資源群組：
        1. 選取 **default** 資源群組。可以僅針對 default 資源群組配置 {{site.data.keyword.containershort_notm}} 存取權。
    * 若為特定資源：
        1. 從**服務**清單中，選取 **{{site.data.keyword.containershort_notm}}**。
        2. 從**地區**清單中，選取地區。
        3. 從**服務實例**清單中，選取要邀請使用者加入的叢集。若要尋找特定叢集的 ID，請執行 `ibmcloud ks clusters`。

5. 在**選取角色**區段中，選擇角色。 

6. 按一下**指派**。

7. 指派 [Cloud Foundry 角色](/docs/iam/mngcf.html#mngcf)。

8. 選用項目：指派[基礎架構角色](/docs/iam/infrastructureaccess.html#infrapermission)。

<br />






## 授權具有自訂 Kubernetes RBAC 角色的使用者
{: #rbac}

{{site.data.keyword.containershort_notm}} 存取原則對應於某些 Kubernetes 角色型存取控制 (RBAC) 角色。若要授權不同於對應存取原則的其他 Kubernetes 角色，您可以自訂 RBAC 角色，然後將角色指派給個人或使用者群組。
{: shortdesc}

有時候您可能需要存取原則比 IAM 原則可能容許的更為精細。沒有問題！您可以為使用者或群組指派特定 Kubernetes 資源的存取原則。您可以建立一個角色，然後將角色連結至特定的使用者或群組。如需相關資訊，請參閱 Kubernetes 文件中的 [Using RBAC Authorization ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#api-overview)。

為群組建立連結後，它會影響已新增或已從該群組移除的任何使用者。如果您將使用者新增至群組，則他們也會有其他存取權。如果移除他們，則會撤銷其存取權。
{: tip}

如果您想要指派對服務（例如持續整合、持續交付管線）的存取權，則可以使用 [Kubernetes 服務帳戶 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/reference/access-authn-authz/service-accounts-admin/)。

**開始之前**

- 將 [Kubernetes CLI](cs_cli_install.html#cs_cli_configure) 的目標設為您的叢集。
- 確定使用者或群組至少具有服務層次的 `Viewer` 存取權。


**自訂 RBAC 角色**

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
        <caption>瞭解這個 YAML 元件</caption>
          <thead>
            <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解這個 YAML 元件</th>
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
              <td><ul><li>對於 `Role` 類型：指定授與對其之存取權的 Kubernetes 名稱空間。</li><li>如果您要建立在叢集層次上套用的 `ClusterRole`，請不要使用 `namespace` 欄位。</li></ul></td>
            </tr>
            <tr>
              <td><code>metadata/name</code></td>
              <td>命名角色，並在稍後連結該角色時使用此名稱。</td>
            </tr>
            <tr>
              <td><code>rules/apiGroups</code></td>
              <td><ul><li>指定您要使用者能夠與其互動的 Kubernetes API 群組，例如 `"apps"`、`"batch"` 或 `"extensions"`。</li><li>若要存取位於 REST 路徑 `apiv1` 的核心 API 群組，請將群組保留空白：`[""]`。</li><li>如需相關資訊，請參閱 Kubernetes 文件中的 [API 群組 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://v1-9.docs.kubernetes.io/docs/reference/api-overview/#api-groups)。</li></ul></td>
            </tr>
            <tr>
              <td><code>rules/resources</code></td>
              <td><ul><li>指定您要授與對其之存取權的 Kubernetes 資源，例如 `"daemonset"`、`"deployments"`、`"events"` 或 `"ingresses"`。</li><li>如果您指定 `"nodes"`，則角色類型必須是 `ClusterRole`。</li><li>如需資源清單，請參閱 Kubernetes 提要中的 [Resource types ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/reference/kubectl/cheatsheet/) 表格。</li></ul></td>
            </tr>
            <tr>
              <td><code>rules/verbs</code></td>
              <td><ul><li>指定您要使用者能夠執行的動作類型，例如 `"get"`、`"list"`、`"describe"`、`"create"` 或 `"delete"`。</li><li>如需動詞的完整清單，請參閱 [`kubectl` 文件 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/reference/kubectl/overview/)。</li></ul></td>
            </tr>
          </tbody>
        </table>

    2.  在叢集裡建立角色。

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
        - kind: User
          name: system:serviceaccount:<namespace>:<service_account_name>
          apiGroup: rbac.authorization.k8s.io
        roleRef:
          kind: Role
          name: custom-rbac-test
          apiGroup: rbac.authorization.k8s.io
        ```
        {: codeblock}

        <table>
        <caption>瞭解這個 YAML 元件</caption>
          <thead>
            <th colspan=2><img src="images/idea.png" alt="構想圖示"/> 瞭解這個 YAML 元件</th>
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
              <td><ul><li>**若為個別使用者**：將使用者的電子郵件位址附加到下列 URL 後面：`https://iam.ng.bluemix.net/kubernetes#`。例如，`https://iam.ng.bluemix.net/kubernetes#user1@example.com`</li>
              <li>**若為服務帳戶**：指定名稱空間及服務名稱。例如：`system:serviceaccount:<namespace>:<service_account_name>`</li></ul></td>
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

    2. 在叢集裡建立角色連結資源。

        ```
        kubectl apply -f filepath/my_role_team1.yaml
        ```
        {: pre}

    3.  驗證已建立連結。

        ```
        kubectl get rolebinding
        ```
        {: pre}

既然您已建立並連結自訂 Kubernetes RBAC 角色，請對使用者採取後續行動。要求他們測試由於該角色而具有許可權可以完成的動作，例如刪除 Pod。


<br />



## 自訂使用者的基礎架構許可權
{: #infra_access}

當您在 Identity and Access Management 中設定基礎架構原則時，使用者會獲得與角色相關聯的許可權。部分原則是預先定義的，但可以自訂其他原則。若要自訂這些許可權，您必須登入 IBM Cloud 基礎架構 (SoftLayer)，並在該處調整許可權。
{: #view_access}

例如，**基本使用者**可以重新啟動工作者節點，但無法重新載入工作者節點。不必授與該人員**超級使用者**許可權，您可以調整 IBM Cloud 基礎架構 (SoftLayer) 許可權，並新增許可權來執行重新載入指令。

如果您有多個叢集，則您的 IBM Cloud 基礎架構 (SoftLayer) 帳戶擁有者需要開啟 VLAN Spanning，不同區域中的節點才能在叢集內通訊。帳戶擁有者也可將**網路 > 管理網路 VLAN Spanning** 許可權指派給使用者，讓使用者可以啟用 VLAN Spanning。
{: tip}


1.  登入 [{{site.data.keyword.Bluemix_notm}} 帳戶](https://console.bluemix.net/)，然後從功能表中選取**基礎架構**。

2.  移至**帳戶** > **使用者** > **使用者清單**。

3.  若要修改許可權，請選取使用者設定檔的名稱或**裝置存取權**直欄。

4.  在**入口網站許可權**標籤中，自訂使用者的存取權。使用者需要的許可權，取決於他們需要使用的基礎架構資源：

    * 使用**快速許可權**下拉清單來指派**超級使用者**角色，這會將所有許可權提供給使用者。
    * 使用**快速許可權**下拉清單來指派**基本使用者**角色，這會將部分（但非全部）所需許可權提供給使用者。
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
         <td><strong>儲存空間</strong>：<ul><li>建立持續性磁區要求，以佈建持續性磁區。</li><li>建立及管理儲存空間基礎架構資源。</li></ul></td>
         <td><strong>服務</strong>：<ul><li>管理儲存空間</li></ul><strong>帳戶</strong>：<ul><li>新增儲存空間</li></ul></td>
       </tr>
       <tr>
         <td><strong>專用網路</strong>：<ul><li>管理專用 VLAN 來建立叢集內網路連線。</li><li>設定專用網路的 VPN 連線功能。</li></ul></td>
         <td><strong>網路</strong>：<ul><li>管理網路子網路路徑</li><li>管理 IPSEC 網路通道</li><li>管理網路閘道</li><li>VPN 管理</li></ul></td>
       </tr>
       <tr>
         <td><strong>公用網路</strong>：<ul><li>設定公用負載平衡器或 Ingress 網路來公開應用程式。</li></ul></td>
         <td><strong>裝置</strong>：<ul><li>管理負載平衡器</li><li>編輯主機名稱/網域</li><li>管理埠控制</li></ul>
         <strong>網路</strong>：<ul><li>新增運算與公用網路埠</li><li>管理網路子網路路徑</li><li>新增 IP 位址</li></ul>
         <strong>服務</strong>：<ul><li>管理 DNS、反向 DNS 及 WHOIS</li><li>檢視憑證 (SSL)</li><li>管理憑證 (SSL)</li></ul></td>
       </tr>
     </tbody>
    </table>

5.  若要儲存您的變更，請按一下**編輯入口網站許可權**。

6.  在**裝置存取權**標籤中，選取要授與存取權的裝置。

    * 在**裝置類型**下拉清單中，您可以授與對**所有虛擬伺服器**的存取權。
    * 若要容許使用者存取所建立的新裝置，請選取**新增裝置時自動授與存取權**。
    * 若要儲存您的變更，請按一下**更新裝置存取權**。

要降級許可權嗎？可能需要幾分鐘的時間才能完成此動作。
{: tip}

<br />

