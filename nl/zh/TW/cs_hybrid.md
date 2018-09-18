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
{:tsSymptoms: .tsSymptoms}
{:tsCauses: .tsCauses}
{:tsResolve: .tsResolve}


# 使用 {{site.data.keyword.containerlong_notm}} 與 {{site.data.keyword.Bluemix_notm}} 專用搭配
{: #hybrid_iks_icp}

如果您有「{{site.data.keyword.Bluemix}} 專用」帳戶，則可以將它與精選 {{site.data.keyword.Bluemix_notm}} 服務（包括 {{site.data.keyword.containerlong}}）搭配使用。如需相關資訊，請參閱 [{{site.data.keyword.Bluemix_notm}} 專用及 IBM 公用雲端的混合式經驗 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](http://ibm.biz/hybridJune2018) 上的部落格。
{: shortdesc}

您瞭解 [{{site.data.keyword.Bluemix_notm}} 供應項目](cs_why.html#differentiation)。現在，您可以[連接公用及專用雲端](#hybrid_vpn)，以及[重複使用公用容器的專用套件](#hybrid_ppa_importer)。

## 使用 strongSwan VPN 連接公用及專用雲端
{: #hybrid_vpn}

建立公用 Kubernetes 叢集與「{{site.data.keyword.Bluemix}} 專用」實例之間的 VPN 連線功能，以容許雙向通訊。
{: shortdesc}

1.  [在 {{site.data.keyword.Bluemix}} 專用中建立叢集 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/support/knowledgecenter/SSBS6K_2.1.0.3/installing/installing.html)。

2.  在 {{site.data.keyword.Bluemix}} 公用中使用 {{site.data.keyword.containerlong}} 建立標準叢集，或使用現有叢集。若要建立叢集，請選擇下列選項： 
    - [從 GUI 建立標準叢集](cs_clusters.html#clusters_ui)。 
    - [從 CLI 建立標準叢集](cs_clusters.html#clusters_cli)。 
    - [使用 Cloud Automation Manager (CAM) 利用預先定義的範本來建立叢集 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/support/knowledgecenter/SS2L37_2.1.0.3/cam_deploy_IKS.html)。當您使用 CAM 部署叢集時，會自動為您安裝 Helm tiller。

3.  在「{{site.data.keyword.Bluemix}} 專用」叢集中，部署 strongSwan IPSec VPN 服務。

    1.  [完成 strongSwan IPSec VPN 暫行解決方法 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/support/knowledgecenter/SS2L37_2.1.0.3/cam_strongswan.html)。 

    2.  在專用叢集中，[安裝 strongSwan VPN Helm 圖表 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/support/knowledgecenter/SSBS6K_2.1.0.3/app_center/create_release.html)。

4.  取得「{{site.data.keyword.Bluemix}} 專用」VPN 閘道的公用 IP 位址。IP 位址是[專用叢集初步設定 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/support/knowledgecenter/SSBS6K_2.1.0.3/installing/prep_cluster.html) 的一部分。

5.  在「{{site.data.keyword.Bluemix}} 公用」叢集中，[部署 strongSwan IPSec VPN 服務](cs_vpn.html#vpn-setup)。使用前一個步驟的公用 IP 位址，並且務必在「{{site.data.keyword.Bluemix}} 公用」中配置 VPN 閘道來進行[出埠連線](cs_vpn.html#strongswan_3)，以從「{{site.data.keyword.Bluemix}} 公用」中的叢集起始 VPN 連線。 

6.  [測試叢集之間的 VPN 連線](cs_vpn.html#vpn_test)。

7.  針對每一個您要連接的叢集，重複這些步驟。 


## 在公用 Kubernetes 容器中執行 {{site.data.keyword.Bluemix_notm}} 專用映像檔
{: #hybrid_ppa_importer}

您可以執行精選授權 IBM 產品，而這些產品是針對「{{site.data.keyword.Bluemix_notm}} 公用」的叢集裡的「{{site.data.keyword.Bluemix_notm}} 專用」進行包裝。  
{: shortdesc}

[IBM Passport Advantage ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www-01.ibm.com/software/passportadvantage/index.html) 中提供授權軟體。若要在「{{site.data.keyword.Bluemix_notm}} 公用」的叢集裡使用此軟體，您必須下載軟體，並擷取映像檔，然後將映像檔上傳至 {{site.data.keyword.registryshort}} 中的名稱空間。與您計劃使用軟體的環境無關，您必須先取得產品的必要授權。 

下表概述您可在「{{site.data.keyword.Bluemix_notm}} 公用」的叢集裡使用的可用「{{site.data.keyword.Bluemix_notm}} 專用」產品。

| 產品名稱 | 版本 | 產品編號 |
| --- | --- | --- |
| IBM Db2 Direct Advanced Edition Server | 11.1 | CNU3TML |
| IBM Db2 Advanced Enterprise Server Edition Server | 11.1 | CNU3SML |
| IBM MQ Advanced | 9.0.5 | CNU1VML |
| IBM WebSphere Application Server Liberty | 16.0.0.3 | Docker Hub 映像檔 |
{: caption="表. 支援在「{{site.data.keyword.Bluemix_notm}} 公用」中使用的「{{site.data.keyword.Bluemix_notm}} 專用」產品" caption-side="top"}

開始之前： 
- [安裝 {{site.data.keyword.registryshort}} CLI 外掛程式 (`ibmcloud cr`)](/docs/services/Registry/registry_setup_cli_namespace.html#registry_cli_install)。 
- [在 {{site.data.keyword.registryshort}}](/docs/services/Registry/registry_setup_cli_namespace.html#registry_namespace_add) 中設定名稱空間，或藉由執行 `ibmcloud cr namespaces` 來擷取現有名稱空間。 
- [將 `kubectl` CLI 的目標設為叢集](/docs/containers/cs_cli_install.html#cs_cli_configure)。 
- [在叢集裡安裝 Helm CLI 並設定 tiller](/docs/containers/cs_integrations.html#helm)。 

若要在「{{site.data.keyword.Bluemix_notm}} 公用」的叢集裡部署「{{site.data.keyword.Bluemix_notm}} 專用」映像檔，請執行下列動作：

1.  遵循 [{{site.data.keyword.registryshort}} 文件](/docs/services/Registry/ts_index.html#ts_ppa)中的步驟以從 IBM Passport Advantage 下載授權軟體，並將映像檔推送至名稱空間，然後在叢集裡安裝 Helm 圖表。 

    **針對 IBM WebSphere Application Server Liberty**：
    
    1.  使用 [Docker Hub 映像檔 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://hub.docker.com/_/websphere-liberty/)，而非從 IBM Passport Advantage 取得映像檔。如需取得正式作業授權的指示，請參閱[將映像檔從 Docker Hub 升級至正式作業映像檔 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://github.com/WASdev/ci.docker/tree/master/ga/production-upgrade)。
    
    2.  遵循 [Liberty Helm 圖表指示 ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/support/knowledgecenter/en/SSEQTP_liberty/com.ibm.websphere.wlp.doc/ae/rwlp_icp_helm.html)。 

2.  驗證 Helm 圖表的 **STATUS** 顯示為 `DEPLOYED`。否則，等待幾分鐘，然後再試一次試。
    ```
    helm status <helm_chart_name>
    ```
    {: pre}
   
3.  如需如何配置產品以及使用產品與叢集搭配的相關資訊，請參閱產品特定文件。 

    - [IBM Db2 Direct Advanced Edition Server ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/support/knowledgecenter/en/SSEPGG_11.1.0/com.ibm.db2.luw.licensing.doc/doc/c0070181.html) 
    - [IBM MQ Advanced ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/support/knowledgecenter/en/SSFKSJ_9.0.0/com.ibm.mq.helphome.v90.doc/WelcomePagev9r0.html)
    - [IBM WebSphere Application Server Liberty ![外部鏈結圖示](../icons/launch-glyph.svg "外部鏈結圖示")](https://www.ibm.com/support/knowledgecenter/en/SSEQTP_liberty/as_ditamaps/was900_welcome_liberty.html)
