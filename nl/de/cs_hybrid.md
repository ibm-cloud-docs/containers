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


# {{site.data.keyword.containerlong_notm}} mit {{site.data.keyword.Bluemix_notm}} Private verwenden
{: #hybrid_iks_icp}

Wenn Sie über ein {{site.data.keyword.Bluemix}} Private-Konto verfügen, können Sie dies mit ausgewählten {{site.data.keyword.Bluemix_notm}}-Services, einschließlich {{site.data.keyword.containerlong}}, verwenden. Weitere Informationen finden Sie im Blog zu [Hybrid-Erweiterungen in {{site.data.keyword.Bluemix_notm}} Private und IBM Public Cloud![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](http://ibm.biz/hybridJune2018).
{: shortdesc}

Sie kennen die [{{site.data.keyword.Bluemix_notm}}-Angebote](cs_why.html#differentiation). Jetzt können Sie [Ihre öffentliche und private Cloud verbinden](#hybrid_vpn) und [Ihre privaten Pakete für öffentliche Container wiederverwenden](#hybrid_ppa_importer).

## Öffentliche und private Cloud mit dem strongSwan-VPN verbinden
{: #hybrid_vpn}

Stellen Sie die VPN-Verbindung zwischen dem öffentlichen Kubernetes-Cluster und Ihrer {{site.data.keyword.Bluemix}} Private-Instanz her, um eine wechselseitige Übertragung zu ermöglichen.
{: shortdesc}

1.  [Erstellen Sie einen Cluster in {{site.data.keyword.Bluemix}} Private![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/support/knowledgecenter/SSBS6K_2.1.0.3/installing/installing.html).

2.  Erstellen Sie einen Standardcluster mit {{site.data.keyword.containerlong}} in {{site.data.keyword.Bluemix}} Public oder verwenden Sie einen vorhandenen Cluster. Wenn Sie einen Cluster erstellen möchten, wählen Sie zwischen den folgenden Optionen: 
    - [Erstellen Sie einen Standardcluster über die GUI](cs_clusters.html#clusters_ui). 
    - [Erstellen Sie einen Standardcluster über die CLI](cs_clusters.html#clusters_cli). 
    - [Verwenden Sie Cloud Automation Manager (CAM), um einen Cluster zu erstellen, indem Sie eine vordefinierte Vorlage verwenden ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/support/knowledgecenter/SS2L37_2.1.0.3/cam_deploy_IKS.html). Wenn Sie einen Cluster mit CAM bereitstellen, wird Tiller für Helm automatisch für Sie installiert.

3.  Stellen Sie den strongSwan-IPSec-VPN-Service in Ihrem {{site.data.keyword.Bluemix}} Private-Cluster bereit.

    1.  [Führen Sie die Ausweichlösungen für das strongSwan-IPSec-VPN durch ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/support/knowledgecenter/SS2L37_2.1.0.3/cam_strongswan.html). 

    2.  [Installieren Sie das Helm-Diagramm für das strongSwan-VPN![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/support/knowledgecenter/SSBS6K_2.1.0.3/app_center/create_release.html) in Ihrem privaten Cluster.

4.  Rufen Sie die öffentliche IP-Adresse des {{site.data.keyword.Bluemix}} Private-VPN-Gateways ab. Die IP-Adresse war Teil Ihrer [vorläufigen Konfiguration für private Cluster ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/support/knowledgecenter/SSBS6K_2.1.0.3/installing/prep_cluster.html).

5.  [Stellen Sie den strongSwan-IPSec-VPN-Service](cs_vpn.html#vpn-setup) in Ihrem {{site.data.keyword.Bluemix}} Public-Cluster bereit. Verwenden Sie die öffentliche IP-Adresse aus dem vorherigen Schritt und stellen Sie sicher, dass Sie Ihr VPN-Gateway in {{site.data.keyword.Bluemix}} Public für [abgehende Verbindungen](cs_vpn.html#strongswan_3) konfigurieren, damit die VPN-Verbindung vom Cluster in {{site.data.keyword.Bluemix}} Public gestartet wird. 

6.  [Testen Sie die VPN-Verbindung](cs_vpn.html#vpn_test) zwischen Ihren Clustern.

7.  Wiederholen Sie die Schritte für jeden Cluster, der verbunden werden soll. 


## {{site.data.keyword.Bluemix_notm}} Private-Images in öffentlichen Kubernetes-Containern ausführen
{: #hybrid_ppa_importer}

Sie können ausgewählte lizenzierte IBM Produkte ausführen, die für {{site.data.keyword.Bluemix_notm}} Private in einem Cluster in {{site.data.keyword.Bluemix_notm}} Public gepackt wurden.  
{: shortdesc}

Lizenzierte Software ist in [IBM Passport Advantage ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www-01.ibm.com/software/passportadvantage/index.html) verfügbar. Um diese Software in einem Cluster in {{site.data.keyword.Bluemix_notm}} Public verwenden zu können, müssen Sie die Software herunterladen, das Image extrahieren und das Image in Ihren Namensbereich in {{site.data.keyword.registryshort}} hochladen. Unabhängig von der Umgebung, in der Sie die Software verwenden möchten, müssen Sie zuerst die erforderliche Lizenz für das Produkt erwerben. 

In der folgenden Tabelle finden Sie eine Übersicht über verfügbare {{site.data.keyword.Bluemix_notm}} Private-Produkte, die Sie in Ihrem Cluster in {{site.data.keyword.Bluemix_notm}} Public verwenden können.

| Produktname | Version | Teilenummer |
| --- | --- | --- |
| IBM Db2 Direct Advanced Edition Server | 11.1 | CNU3TML |
| IBM Db2 Advanced Enterprise Server Edition Server | 11.1 | CNU3SML |
| IBM MQ Advanced | 9.0.5 | CNU1VML |
| IBM WebSphere Application Server Liberty | 16.0.0.3 | Docker Hub-Image |
{: caption="Tabelle. Unterstützte {{site.data.keyword.Bluemix_notm}} Private-Produkte, die in {{site.data.keyword.Bluemix_notm}} Public verwendet werden können." caption-side="top"}

Vorbemerkungen: 
- [Installieren Sie das {{site.data.keyword.registryshort}}-CLI-Plug-in (`ibmcloud cr`)](/docs/services/Registry/registry_setup_cli_namespace.html#registry_cli_install). 
- [Richten Sie einen Namensbereich in {{site.data.keyword.registryshort}}](/docs/services/Registry/registry_setup_cli_namespace.html#registry_namespace_add) ein oder rufen Sie Ihren vorhandenen Namensbereich ab, indem Sie `ibmcloud cr namespaces` ausführen. 
- [Richten Sie die `kubectl`-CLI auf Ihren Cluster aus](/docs/containers/cs_cli_install.html#cs_cli_configure). 
- [Installieren Sie die Helm-CLI und richten Sie Tiller in Ihrem Cluster ein](/docs/containers/cs_integrations.html#helm). 

Gehen Sie wie folgt vor, um ein {{site.data.keyword.Bluemix_notm}} Private-Image in einem Cluster in {{site.data.keyword.Bluemix_notm}} Public bereitzustellen:

1.  Befolgen Sie die Schritte in der [{{site.data.keyword.registryshort}}-Dokumentation](/docs/services/Registry/ts_index.html#ts_ppa), um die lizenzierte Software von IBM Passport Advantage herunterzuladen, das Image in Ihren Namensbereich zu übertragen und das Helm-Diagramm in Ihrem Cluster zu installieren. 

    **Für IBM WebSphere Application Server Liberty**:
    
    1.  Anstatt das Image von IBM Passport Advantage abzurufen, verwenden Sie das [Docker Hub-Image ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link") ](https://hub.docker.com/_/websphere-liberty/). Anweisungen zum Abrufen einer Produktionslizenz finden Sie in der Veröffentlichung zum [Aktualisieren eines Image von Docker Hub auf ein Produktionsimage![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/WASdev/ci.docker/tree/master/ga/production-upgrade).
    
    2.  Befolgen Sie die [Anweisungen für Liberty-Helm-Diagramme![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/support/knowledgecenter/en/SSEQTP_liberty/com.ibm.websphere.wlp.doc/ae/rwlp_icp_helm.html). 

2.  Stellen Sie sicher, dass der **STATUS** des Helms-Diagramms `DEPLOYED` lautet. Ist dies nicht der Fall, warten Sie einige Minuten und versuchen Sie es erneut.
    ```
    helm status <name_des_helm-diagramms>
    ```
    {: pre}
   
3.  Weitere Informationen zum Konfigurieren und Verwenden des Produkts mit dem Cluster finden Sie in der produktspezifischen Dokumentation. 

    - [IBM Db2 Direct Advanced Edition Server ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/support/knowledgecenter/en/SSEPGG_11.1.0/com.ibm.db2.luw.licensing.doc/doc/c0070181.html) 
    - [IBM MQ Advanced ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/support/knowledgecenter/en/SSFKSJ_9.0.0/com.ibm.mq.helphome.v90.doc/WelcomePagev9r0.html)
    - [IBM WebSphere Application Server Liberty ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/support/knowledgecenter/en/SSEQTP_liberty/as_ditamaps/was900_welcome_liberty.html)
