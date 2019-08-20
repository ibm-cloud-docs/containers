---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

keywords: kubernetes, iks, helm

subcollection: containers

---

{:new_window: target="_blank"}
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
{:preview: .preview}


# IBM Cloud-Services und Integrationen von Drittanbietern
{: #ibm-3rd-party-integrations}

Sie können Plattform- und Infrastrukturservices von {{site.data.keyword.cloud_notm}} sowie Drittanbieterintegrationen verwenden, um Ihrem Cluster zusätzliche Funktionen hinzuzufügen.
{: shortdesc}

## IBM Cloud-Services
{: #ibm-cloud-services}

Lesen Sie die folgenden Informationen, um herauszufinden, wie die Plattform- und Infrastrukturservices von {{site.data.keyword.cloud_notm}} in {{site.data.keyword.containerlong_notm}} integriert sind und wie Sie sie in Ihrem Cluster einsetzen können.
{: shortdesc}

### IBM Cloud-Plattformservices
{: #platform-services}

Alle {{site.data.keyword.cloud_notm}}-Plattformservices, die Serviceschlüssel unterstützen, können mithilfe der {{site.data.keyword.containerlong_notm}}-[Servicebindung](/docs/containers?topic=containers-service-binding) integriert werden.
{: shortdesc}

Die Servicebindung ist eine schnelle Methode zum Erstellen von Serviceberechtigungsnachweisen für einen {{site.data.keyword.cloud_notm}}-Service und zum Speichern dieser Berechtigungsnachweise in einem geheimen Kubernetes-Schlüssel in Ihrem Cluster. Der geheime Kubernetes-Schlüssel wird automatisch in 'etcd' verschlüsselt, um Ihre Daten zu schützen. Ihre Apps können die Berechtigungsnachweise im geheimen Schlüssel verwenden, um auf Ihre {{site.data.keyword.cloud_notm}}-Serviceinstanz zuzugreifen.

Services, die keine Serviceschlüssel unterstützen, stellen in der Regel eine API bereit, die Sie direkt in Ihrer App verwenden können.

Eine Übersicht über gängige {{site.data.keyword.cloud_notm}}-Services finden Sie unter [Beliebte Integrationen](/docs/containers?topic=containers-supported_integrations#popular_services).

### IBM Cloud-Infrastrukturservices
{: #infrastructure-services}

Da {{site.data.keyword.containerlong_notm}} Ihnen die Erstellung eines Kubernetes-Clusters ermöglicht, der auf der {{site.data.keyword.cloud_notm}}-Infrastruktur basiert, sind einige Infrastrukturservices, z. B. Virtual Server, Bare Metal Server oder VLANs vollständig in {{site.data.keyword.containerlong_notm}} integriert. Sie erstellen und verwenden diese Serviceinstanzen mithilfe der {{site.data.keyword.containerlong_notm}}-API, -CLI oder -Konsole.
{: shortdesc}

Unterstützte Lösungen für persistenten Speicher, z. B. {{site.data.keyword.cloud_notm}} File Storage, {{site.data.keyword.cloud_notm}} Block Storage oder {{site.data.keyword.cos_full}}, sind als Kubernetes-Flex-Treiber integriert und können mithilfe von [Helm-Diagrammen](/docs/containers?topic=containers-helm) eingerichtet werden. Das Helm-Diagramm richtet automatisch Kubernetes-Speicherklassen, den Speicheranbieter und den Speichertreiber in Ihrem Cluster ein. Sie können die Speicherklassen verwenden, um persistenten Speicher durch Verwendung von PVCs (Persistent Volume Claims - Anforderungen persistenter Datenträger) bereitzustellen.

Um Ihr Clusternetz zu sichern oder eine Verbindung zu einem On-Premises-Rechenzentrum herzustellen, können Sie eine der folgenden Optionen konfigurieren:
- [strongSwan-IPSec-VPN-Service](/docs/containers?topic=containers-vpn#vpn-setup)
- [{{site.data.keyword.BluDirectLink}}](/docs/infrastructure/direct-link?topic=direct-link-get-started-with-ibm-cloud-direct-link)
- [Virtual Router Appliance (VRA)](/docs/containers?topic=containers-vpn#vyatta)
- [Fortigate Security Appliance (FSA)](/docs/services/vmwaresolutions/services?topic=vmware-solutions-fsa_considerations)

## Kubernetes-Community und Open-Source-Integrationen
{: #kube-community-tools}

Da Sie Eigner der Standardcluster sind, die Sie in {{site.data.keyword.containerlong_notm}} erstellen, können Sie Drittanbieterlösungen installieren, um Ihrem Cluster zusätzliche Funktionen hinzuzufügen.
{: shortdesc}

Einige Open-Source-Technologien wie Knative, Istio, LogDNA, Sysdig oder Portworx werden von IBM getestet und werden als verwaltete Add-ons, Helm-Diagramme oder {{site.data.keyword.cloud_notm}}-Services bereitgestellt, die vom Service-Provider in Partnerschaft mit IBM betrieben werden. Diese Open-Source-Tools sind vollständig in das Abrechnungs- und Unterstützungssystem von {{site.data.keyword.cloud_notm}} integriert.

Sie können andere Open-Source-Tools in Ihrem Cluster installieren, aber diese Tools werden möglicherweise nicht für die Verwendung in {{site.data.keyword.containerlong_notm}} verwaltet, unterstützt oder überprüft.

### In Partnerschaft betriebene Integrationen
{: #open-source-partners}

Weitere Informationen zu den {{site.data.keyword.containerlong_notm}}-Partnern und den Vorteilen der einzelnen von ihnen angebotenen Lösungen finden Sie unter [{{site.data.keyword.containerlong_notm}}-Partner](/docs/containers?topic=containers-service-partners).

### Verwaltete Add-ons
{: #cluster-add-ons}
{{site.data.keyword.containerlong_notm}} integriert gängige Open-Source-Integrationen, z. B. [Knative](/docs/containers?topic=containers-serverless-apps-knative) oder [Istio](/docs/containers?topic=containers-istio), mithilfe von [verwalteten Add-ons](/docs/containers?topic=containers-managed-addons). Verwaltete Add-ons sind eine einfache Möglichkeit, ein Open-Source-Tool in Ihrem Cluster zu installieren, das von IBM getestet und für die Verwendung in {{site.data.keyword.containerlong_notm}} freigegeben wurde.

Verwaltete Add-ons werden vollständig in die {{site.data.keyword.cloud_notm}}-Unterstützungsorganisation integriert. Wenn Sie eine Frage oder ein Problem mit der Verwendung der verwalteten Add-ons haben, können Sie einen der {{site.data.keyword.containerlong_notm}}-Unterstützungskanäle verwenden. Weitere Informationen finden Sie im Abschnitt [Hilfe und Unterstützung anfordern](/docs/containers?topic=containers-cs_troubleshoot_clusters#clusters_getting_help).

Wenn das Tool, das Sie Ihrem Cluster hinzufügen, Kosten verursacht, werden diese automatisch integriert und als Teil Ihrer {{site.data.keyword.cloud_notm}}-Abrechnung aufgeführt. Der Abrechnungszyklus wird von {{site.data.keyword.cloud_notm}} in Abhängigkeit vom Zeitpunkt der Aktivierung des Add-ons im Cluster bestimmt.

### Weitere Integrationen von Drittanbietern
{: #kube-community-helm}

Sie können jedes Open-Source-Tool eines anderen Anbieters installieren, das in Kubernetes integrierbar ist. Die Kubernetes-Community bezeichnet beispielsweise bestimmte Helm-Diagramme als `stable` oder`incubator`. Beachten Sie, dass diese Diagramme oder Tools nicht auf ihre Verwendbarkeit in {{site.data.keyword.containerlong_notm}} geprüft wurden. Wenn für das Tool eine Lizenz erforderlich ist, müssen Sie diese erwerben, bevor Sie das Tool verwenden. Eine Übersicht über verfügbare Helm-Diagramme aus der Kubernetes-Community finden Sie in den Repositorys `kubernetes` und `kubernetes-incubator` im Katalog [Helm-Diagramme ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cloud.ibm.com/kubernetes/solutions/helm-charts).
{: shortdesc}

Kosten, die durch die Verwendung einer Open-Source-Integration eines anderen Anbieters entstehen, sind in Ihrer monatlichen {{site.data.keyword.cloud_notm}}-Rechnung nicht enthalten.

Durch die Installation von Open-Source-Integrationen anderer Anbieter oder von Helm-Diagrammen aus der Kubernetes-Community kann die Standardclusterkonfiguration geändert werden und Ihr Cluster wird möglicherweise in einen nicht unterstützten Zustand versetzt. Wenn bei der Verwendung dieser Tools Probleme auftreten, wenden Sie sich bitte direkt an die Kubernetes-Community oder den Service-Provider.
{: important}
