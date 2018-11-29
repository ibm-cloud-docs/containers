---

copyright:
  years: 2014, 2018
lastupdated: "2018-10-25"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# 保護叢集中的機密性資訊
{: #encryption}

依預設，{{site.data.keyword.containerlong}} 叢集會使用已加密的磁碟來儲存資訊，例如 `etcd` 中的配置，或在工作者節點次要磁碟上執行的容器檔案系統。部署應用程式時，請不要在 YAML 配置檔、ConfigMap 或 Script 中儲存機密資訊，例如認證或金鑰。請改用 [Kubernetes 密碼 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/concepts/configuration/secret/)。您也可以加密 Kubernetes 密碼中的資料，以防止未獲授權的使用者存取機密叢集資訊。
{: shortdesc}

如需保護叢集的相關資訊，請參閱 [{{site.data.keyword.containerlong_notm}} 的安全](cs_secure.html#security)。



## 瞭解何時使用密碼
{: #secrets}

Kubernetes 密碼是一種儲存機密資訊（例如使用者名稱、密碼或金鑰）的安全方式。如果您需要加密機密資訊，請[啟用 {{site.data.keyword.keymanagementserviceshort}}](#keyprotect) 來加密密碼。如需您可以在密碼中儲存哪些項目的相關資訊，請參閱 [Kubernetes 文件 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/concepts/configuration/secret/)。
{:shortdesc}

請檢閱下列需要密碼的作業。

### 將服務新增至叢集
{: #secrets_service}

將服務連結至叢集時，不必建立密碼來儲存您的服務認證。會自動為您建立密碼。如需相關資訊，請參閱[將 Cloud Foundry 服務新增至叢集](cs_integrations.html#adding_cluster)。

### 使用 TLS 密碼將資料流量加密至應用程式
{: #secrets_tls}

ALB 會對叢集裡應用程式的 HTTP 網路資料流量進行負載平衡。若要同時對送入的 HTTPS 連線進行負載平衡，您可以配置 ALB 來解密網路資料流量，並將解密的要求轉遞至叢集裡公開的應用程式。如需相關資訊，請參閱 [Ingress 配置文件](cs_ingress.html#public_inside_3)。

此外，如果您的應用程式需要 HTTPS 通訊協定，並且需要資料流量保持加密狀態，則您可以使用單向或交互鑑別密碼與 `ssl-services` 註釋搭配。如需相關資訊，請參閱 [Ingress 註釋文件](cs_annotations.html#ssl-services)。

### 使用 Kubernetes `imagePullSecret` 中儲存的認證存取您的登錄
{: #imagepullsecret}

建立叢集時，會在 `default` Kubernetes 名稱空間中自動為您建立 {{site.data.keyword.registrylong}} 認證的密碼。不過，如果您要在下列狀況中部署容器，則必須[為您的叢集建立自己的 imagePullSecret](cs_images.html#other)。
* 從 {{site.data.keyword.registryshort_notm}} 登錄中的映像檔到 `default` 以外的 Kubernetes 名稱空間。
* 從 {{site.data.keyword.registryshort_notm}} 登錄中儲存在不同 {{site.data.keyword.Bluemix_notm}} 地區或 {{site.data.keyword.Bluemix_notm}} 帳戶中的映像檔。
* 從「{{site.data.keyword.Bluemix_notm}} 專用」帳戶中儲存的映像檔。
* 從外部專用登錄中儲存的映像檔。

<br />


## 使用 {{site.data.keyword.keymanagementserviceshort}} 加密 Kubernetes 密碼
{: #keyprotect}

您可以在叢集中使用 [{{site.data.keyword.keymanagementservicefull}} ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](/docs/services/key-protect/index.html#getting-started-with-key-protect) 作為 Kubernetes [金鑰管理服務 (KMS) 提供者 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://kubernetes.io/docs/tasks/administer-cluster/kms-provider/)，來加密 Kubernetes 密碼。KMS 提供者是 Kubernetes 1.10 版和 1.11 版的 Alpha 功能。
{: shortdesc}

依預設，Kubernetes 密碼會儲存在已加密的磁碟中，而此磁碟位於 IBM 管理的 Kubernetes 主節點的 `etcd` 元件中。您的工作者節點也具有由 IBM 管理的 LUKS 金鑰所加密的次要磁碟，這些金鑰在叢集中儲存為密碼。當您在叢集中啟用 {{site.data.keyword.keymanagementserviceshort}} 時，您自己的主要金鑰會用來加密 Kubernetes 密碼，包括 LUKS 密碼。您可以使用主要金鑰來加密密碼，以進一步控制機密資料。使用自己的加密可在 Kubernetes 密碼中加入一層安全，並讓您更精細地控制誰可以存取機密叢集資訊。如果您需要不可逆轉地移除對密碼的存取權，則可以刪除主要金鑰。

**重要事項**：如果您刪除 {{site.data.keyword.keymanagementserviceshort}} 實例中的主要金鑰，則從此以後無法在叢集中存取或移除密碼中的資料。

開始之前：
* [登入您的帳戶。將目標設為適當的地區及（如果適用的話）資源群組。設定叢集的環境定義](cs_cli_install.html#cs_cli_configure)。
* 確認您的叢集是執行 Kubernetes 1.10.8_1524 版、1.11.3_1521 版或更新版本，方法是執行 `ibmcloud ks cluster-get --cluster <cluster_name_or_ID>`，並檢查**版本**欄位。
* 驗證您具有[**管理者** 許可權](cs_users.html#access_policies)來完成這些步驟。
* 確定針對叢集所在地區設定的 API 金鑰已獲授權使用 Key Protect。若要檢查針對地區儲存其認證的 API 金鑰擁有者，請執行 `ibmcloud ks api-key-info --cluster <cluster_name_or_ID>`。

若要啟用 {{site.data.keyword.keymanagementserviceshort}}，或更新在叢集中加密密碼的實例或主要金鑰，請執行下列動作：

1.  [建立 {{site.data.keyword.keymanagementserviceshort}} 實例](/docs/services/key-protect/provision.html#provision)。

2.  取得服務實例 ID。

    ```
    ibmcloud resource service-instance <kp_instance_name> | grep GUID
    ```
    {: pre}

3.  [建立主要金鑰](/docs/services/key-protect/create-root-keys.html#create-root-keys)。依預設，會建立沒有到期日的主要金鑰。

    需要設定到期日以符合內部安全原則嗎？[使用 API 建立主要金鑰](/docs/services/key-protect/create-root-keys.html#api)，並包括 `expirationDate` 參數。**重要事項**：在您的主要金鑰到期之前，您必須重複這些步驟來更新叢集，以使用新的主要金鑰。否則，無法將您的密碼解密。
    {: tip}

4.  記下[主要金鑰 **ID**](/docs/services/key-protect/view-keys.html#gui)。

5.  取得實例的 [{{site.data.keyword.keymanagementserviceshort}} 端點](/docs/services/key-protect/regions.html#endpoints)。

6.  取得您要為其啟用 {{site.data.keyword.keymanagementserviceshort}} 的叢集名稱。

    ```
    ibmcloud ks clusters
    ```
    {: pre}

7.  在叢集中啟用 {{site.data.keyword.keymanagementserviceshort}}。在旗標中填入您先前擷取的資訊。

    ```
    ibmcloud ks key-protect-enable --cluster <cluster_name_or_ID> --key-protect-url <kp_endpoint> --key-protect-instance <kp_instance_ID> --crk <kp_root_key_ID>
    ```
    {: pre}

在叢集中啟用 {{site.data.keyword.keymanagementserviceshort}} 之後，會使用 {{site.data.keyword.keymanagementserviceshort}} 主要金鑰來自動加密叢集中所建立的現有密碼及新密碼。您可以隨時重複這些步驟，利用新的主要金鑰 ID 來替換您的金鑰。
