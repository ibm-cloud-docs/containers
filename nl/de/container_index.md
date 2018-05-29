---

copyright:
  years: 2014, 2018
lastupdated: "2018-4-20"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Einführung in {{site.data.keyword.containerlong_notm}}
{: #container_index}

Seien Sie sofort einsatzbereit mit {{site.data.keyword.containerlong}} durch die Bereitstellung hoch verfügbarer Apps in Docker-Containern, die in Kubernetes-Clustern ausgeführt werden.
{:shortdesc}

Ein Container ist ein Standardverfahren zum Packen von Apps mit den zugehörigen Abhängigkeiten, sodass die Apps nahtlos zwischen Umgebungen verlagert werden können. Im Unterschied zu virtuellen Maschinen packen Container das Betriebssystem nicht. Nur App-Code, Laufzeit, Systemtools, Bibliotheken und Einstellungen werden in Container gepackt. Containers sind schlanker, leichter portierbar und effizienter als virtuelle Maschinen.


Klicken Sie auf eine Option für den Start:

<img usemap="#home_map" border="0" class="image" id="image_ztx_crb_f1b" src="images/cs_public_dedicated_options.png" width="440" alt="Klicken Sie auf ein Symbol, um schnell Ihre ersten Schritte mit {{site.data.keyword.containershort_notm}} zu machen. Klicken Sie in {{site.data.keyword.Bluemix_dedicated_notm}} auf dieses Symbol, um Ihre Optionen anzuzeigen." style="width:440px;" />
<map name="home_map" id="home_map">
<area href="#clusters" alt="Einführung zu Kubernetes-Clustern in {{site.data.keyword.Bluemix_notm}}" title="Einführung zu Kubernetes-Clustern in {{site.data.keyword.Bluemix_notm}}" shape="rect" coords="-7, -8, 108, 211" />
<area href="cs_cli_install.html" alt="Installieren Sie die CLIs." title="Installieren Sie die CLIs." shape="rect" coords="155, -1, 289, 210" />
<area href="cs_dedicated.html#dedicated_environment" alt="{{site.data.keyword.Bluemix_dedicated_notm}}-Cloudumgebung" title="{{site.data.keyword.Bluemix_notm}}-Cloudumgebung" shape="rect" coords="326, -10, 448, 218" />
</map>


## Einführung in Cluster
{: #clusters}

Sie möchten also eine App in einem Container bereitstellen? Dann müssen Sie als Erstes einen Kubernetes-Cluster erstellen. Kubernetes ist ein Orchestrierungstool für Container. Mit Kubernetes können Entwickler hoch verfügbare Apps im Handumdrehen bereitstellen, indem sie sich die Leistungsstärke und Flexibilität von Clustern zunutze machen.
{:shortdesc}

Und was ist ein Cluster? Ein Cluster ist eine Gruppe von Ressourcen, Knoten, Netzen und Speichereinheiten, die die Hochverfügbarkeit von Apps sicherstellen. Nachdem Sie den Cluster erstellt haben, können Sie Ihre Apps in Containern bereitstellen.

Bevor Sie beginnen, müssen Sie über ein Testkonto, ein nutzungsabhängiges Konto oder ein Abonnementkonto als [{{site.data.keyword.Bluemix_notm}}-Konto](https://console.bluemix.net/registration/) verfügen, um einen kostenlosen Cluster zu erstellen.

**Welchen {{site.data.keyword.Bluemix_notm}}-Kontotyp soll ich abrufen?** Mit nutzungsabhängigen oder Abonnementkonten können Sie IBM Cloud-Infrastrukturressourcen (SoftLayer) für Ihre Kubernetes-Cluster bereitstellen und einen kostenlosen Cluster oder Standardcluster erstellen. Mit einem Testkonto können Sie einen kostenlosen Cluster, aber keine Standardcluster erstellen. Alle kostenlosen Cluster werden nach 21 Tagen automatisch gelöscht. Wenn Sie mit Kubernetes-Clustern fortfahren möchten, erstellen Sie einen weiteren kostenlosen Cluster, bis Ihr Testkonto endet, oder aktualisieren Sie Ihr Konto auf ein nutzungsabhängiges oder Abonnementkonto.
{:tip}

Gehen Sie wie folgt vor, um einen kostenlosen Cluster zu erstellen:

1.  Klicken Sie im [{{site.data.keyword.Bluemix_notm}}-**Katalog** ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://console.bluemix.net/catalog/?category=containers) in der Kategorie **Container** auf **Container im Kubernetes-Cluster**.

2.  Lesen Sie die Informationen zu Clustern und klicken Sie dann auf **Erstellen**. Geben Sie bei **Cluster Name** einen Namen für den Cluster ein. Der Standardtyp ist der kostenlose Cluster. Beim nächsten Mal können Sie einen Standardcluster erstellen und zusätzliche Anpassungen wie die Anzahl der Workerknoten definieren.

3.  Klicken Sie auf **Cluster erstellen**. Die Detailinformationen für den Cluster werden geöffnet; die Einrichtung des Workerknotens im Cluster kann jedoch einige Minuten in Anspruch nehmen. Auf der Registerkarte **Workerknoten** können Sie den Status des Workerknoten überprüfen. Wenn der Status `Ready` erreicht wurde, ist Ihr Workerknoten einsatzbereit.

Hervorragend! Sie haben Ihren ersten Kubernetes-Cluster erstellt. Im Folgenden finden Sie einige Details zu Ihrem kostenlosen Cluster:

*   **Maschinentyp**: Der kostenlose Cluster stellt Ihren Apps einen virtuellen Workerknoten mit 2 CPUs und 4 GB Speicherplatz zur Verfügung. Wenn Sie einen Standardcluster erstellen, können Sie zwischen physischen (Bare-Metal-Maschinen) oder virtuellen Maschinen sowie verschiedenen Maschinengrößen wählen.
*   **Verwalteter Master**: Der Workerknoten wird durch einen dedizierten und hoch verfügbaren {{site.data.keyword.IBM_notm}}-eigenen Kubernetes-Master zentral überwacht und verwaltet, der alle Kubernetes-Ressourcen im Cluster steuert und überwacht. Sie können sich auf Ihren Workerknoten und die darin bereitgestellten Apps konzentrieren, ohne sich Gedanken über die Verwaltung des Masters zu machen.
*   **Infrastrukturressourcen**: Die für die Ausführung des Clusters erforderlichen Ressourcen, z. B. VLANs und IP-Adressen, werden in einem {{site.data.keyword.IBM_notm}}-eigenen Konto von IBM Cloud Infrastructure (SoftLayer) verwaltet. Wenn Sie einen Standardcluster erstellen, verwalten Sie diese Ressourcen in Ihrem eigenen Konto von IBM Cloud Infrastructure (SoftLayer). Weitere Informationen zu diesen Ressourcen und den [erforderlichen Berechtigungen](cs_users.html#infra_access) erhalten Sie, wenn Sie einen Standardcluster erstellen.
*   **Position und andere Optionen**: Kostenlose Cluster werden innerhalb der von Ihnen ausgewählten Region bereitgestellt. Sie können jedoch nicht auswählen, an welcher Position (in welchem Rechenzentrum) sie sich befinden werden. Erstellen Sie einen Standardcluster, um mehr Kontrolle über Position, Vernetzung und persistenten Speicher zu haben. [Weitere Informationen zu den Vorteilen von kostenlosen und Standardclustern](cs_why.html#cluster_types).


**Womit möchten Sie fortfahren?**
In den nächsten 21 Tagen haben Sie die Gelegenheit, verschiedene Dinge mit Ihrem kostenlosen Cluster auszuprobieren. 

* [Installieren Sie die Befehlszeilenschnittstellen und nehmen Sie die Arbeit mit dem Cluster auf.](cs_cli_install.html#cs_cli_install)
* [Stellen Sie eine App in Ihrem Cluster bereit.](cs_app.html#app_cli)
* [Erstellen Sie einen Standardcluster mit mehreren Knoten zwecks höherer Verfügbarkeit.](cs_clusters.html#clusters_ui)
* [Richten Sie Ihre eigene private Registry in {{site.data.keyword.Bluemix_notm}} ein, um Docker-Images zu speichern und gemeinsam mit anderen Benutzern zu verwenden.](/docs/services/Registry/index.html)

