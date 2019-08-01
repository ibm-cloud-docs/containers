---

copyright:
  years: 2014, 2019
lastupdated: "2019-06-12"

keywords: kubernetes, iks

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

# Releaseinformationen
{: #iks-release}

In den Releaseinformationen finden Sie Informationen zu den aktuellen Änderungen der {{site.data.keyword.containerlong}}-Dokumentation, die nach Monat gruppiert sind.
{:shortdesc}

## Juni 2019
{: #jun19}

<table summary="Die Tabelle zeigt Releaseinformationen. Die Zeilen sind von links nach rechts zu lesen, wobei Spalte 1 das Datum, Spalte 2 den Titel der Funktion und Spalte 3 eine Beschreibung enthält. ">
<caption>Aktualisierungen der {{site.data.keyword.containerlong_notm}}-Dokumentation im Juni 2019</caption>
<thead>
<th>Datum</th>
<th>Beschreibung</th>
</thead>
<tbody>
<tr>
  <td>7. Juni 2019</td>
  <td><ul>
  <li><strong>Zugriff auf den Kubernetes-Master über den privaten Serviceendpunkt</strong>: Es wurden [Schritte](/docs/containers?topic=containers-clusters#access_on_prem) hinzugefügt, um den privaten Serviceendpunkt über eine private Lastausgleichsfunktion zugänglich zu machen. Nachdem Sie diese Schritte ausgeführt haben, können Ihre berechtigten Clusterbenutzer über eine VPN- oder {{site.data.keyword.Bluemix_notm}} Direct Link-Verbindung auf den Kubernetes-Master zugreifen. </li>
  <li><strong>{{site.data.keyword.BluDirectLink}}</strong>: {{site.data.keyword.Bluemix_notm}} Direct Link wurde der [VPN-Konnektivität](/docs/containers?topic=containers-vpn) und den [Hybrid-Cloud-Seiten](/docs/containers?topic=containers-hybrid_iks_icp) hinzugefügt, damit Sie ohne Routing über das öffentliche Internet eine direkte, private Verbindung zwischen Ihren fernen Netzumgebungen und {{site.data.keyword.containerlong_notm}} herstellen können. </li>
  <li><strong>Änderungsprotokoll für Ingress-ALB</strong>: Das [ALB-`ingress-auth`-Image wurde auf Build 330 aktualisiert](/docs/containers?topic=containers-cluster-add-ons-changelog#alb_changelog).</li>
  <li><strong>OpenShift-Betaversion</strong>: Eine [Lerneinheit](/docs/containers?topic=containers-openshift_tutorial#openshift_logdna_sysdig) zur Vorgehensweise beim Ändern von App-Bereitstellungen zur Anpassung an Sicherheitskontexteinschränkungen des Typs 'privileged' für {{site.data.keyword.la_full_notm}}- und {{site.data.keyword.mon_full_notm}}-Add-ons wurde hinzugefügt.</li>
  </ul></td>
</tr>
<tr>
  <td>6. Juni 2019</td>
  <td><ul>
  <li><strong>Fluentd-Änderungsprotokoll</strong>: Ein [Änderungsprotokoll für Fluentd-Versionen](/docs/containers?topic=containers-cluster-add-ons-changelog#fluentd_changelog) wurde hinzugefügt.</li>
  <li><strong>Änderungsprotokoll für Ingress-ALB</strong>: Das [ALB-`nginx-ingress`-Image wurde auf Build 470 aktualisiert](/docs/containers?topic=containers-cluster-add-ons-changelog#alb_changelog).</li>
  </ul></td>
</tr>
<tr>
  <td>5. Juni 2019</td>
  <td><ul>
  <li><strong>CLI-Referenz</strong>: Die [CLI-Referenzseite](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli) wurde aktualisiert und spiegelt jetzt mehrere Änderungen für das [Release der Version 0.3.34](/docs/containers?topic=containers-cs_cli_changelog) des {{site.data.keyword.containerlong_notm}}-CLI-Plug-ins wider. </li>
  <li><strong>Neu! Red Hat OpenShift on IBM Cloud-Cluster (Beta)</strong>: Mit der Betaversion von Red Hat OpenShift on IBM Cloud können Sie {{site.data.keyword.containerlong_notm}}-Cluster mit Workerknoten erstellen, die mit der Container-Orchestrierungsplattformsoftware OpenShift installiert werden. Bei der Verwendung der [OpenShift-Tools und des Katalogs ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://docs.openshift.com/container-platform/3.11/welcome/index.html), der unter Red Hat Enterprise Linux ausgeführt wird, zum Entwickeln Ihrer Apps haben Sie alle Vorteile der verwalteten {{site.data.keyword.containerlong_notm}}-Instanzen für Ihre Clusterinfrastrukturumgebung. Informationen zum Einstieg finden Sie im [Lernprogramm: Red Hat OpenShift on IBM Cloud-Cluster (Beta) erstellen](/docs/containers?topic=containers-openshift_tutorial). </li>
  </ul></td>
</tr>
<tr>
  <td>4. Juni 2019</td>
  <td><ul>
  <li><strong>Versionsänderungsprotokolle</strong>: Die Änderungsprotokolle für die Patch-Releases [1.14.2_1521](/docs/containers?topic=containers-changelog#1142_1521), [1.13.6_1524](/docs/containers?topic=containers-changelog#1136_1524), [1.12.9_1555](/docs/containers?topic=containers-changelog#1129_1555) und [1.11.10_1561](/docs/containers?topic=containers-changelog#11110_1561) wurden aktualisiert.</li></ul>
  </td>
</tr>
<tr>
  <td>3. Juni 2019</td>
  <td><ul>
  <li><strong>Eigenen Ingress-Controller verwenden</strong>: Die [Schritte](/docs/containers?topic=containers-ingress#user_managed) wurden aktualisiert und spiegeln jetzt Änderungen des Standard-Community-Controllers wider und erfordern eine Statusprüfung der Controller-IP-Adressen in Mehrzonenclustern. </li>
  <li><strong>{{site.data.keyword.cos_full_notm}}</strong>: Die [Schritte](/docs/containers?topic=containers-object_storage#install_cos) wurden aktualisiert und enthalten jetzt Informationen zum Installieren des {{site.data.keyword.cos_full_notm}}-Plug-ins mit oder ohne den Helm-Server, Tiller. </li>
  <li><strong>Änderungsprotokoll für Ingress-ALB</strong>: Das [ALB-`nginx-ingress`-Image wurde auf Build 467 aktualisiert](/docs/containers?topic=containers-cluster-add-ons-changelog#alb_changelog).</li>
  <li><strong>Kustomize</strong>: Ein Beispiel für die [umgebungsübergreifende Wiederverwendung von Kubernetes-Konfigurationsdateien mit Kustomize](/docs/containers?topic=containers-app#kustomize) wurde hinzugefügt.</li>
  <li><strong>Razee</strong>: [Razee ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/razee-io/Razee) wurde den unterstützten Integrationen hinzugefügt, um Bereitstellungsinformationen im Cluster zu visualisieren und die Bereitstellung von Kubernetes-Ressourcen zu automatisieren. </li></ul>
  </td>
</tr>
</tbody></table>

## Mai 2019
{: #may19}

<table summary="Die Tabelle zeigt Releaseinformationen. Die Zeilen sind von links nach rechts zu lesen, wobei Spalte 1 das Datum, Spalte 2 den Titel der Funktion und Spalte 3 eine Beschreibung enthält. ">
<caption>Aktualisierungen der {{site.data.keyword.containerlong_notm}}-Dokumentation im Mai 2019</caption>
<thead>
<th>Datum</th>
<th>Beschreibung</th>
</thead>
<tbody>
<tr>
  <td>30. Mai 2019</td>
  <td><ul>
  <li><strong>CLI-Referenz</strong>: Die [CLI-Referenzseite](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli) wurde aktualisiert und spiegelt jetzt mehrere Änderungen für das [Release der Version 0.3.33](/docs/containers?topic=containers-cs_cli_changelog) des {{site.data.keyword.containerlong_notm}}-CLI-Plug-ins wider.</li>
  <li><strong>Fehlerbehebung für Speicher</strong> <ul>
  <li>Ein Abschnitt zur Fehlerbehebung für Datei- und Blockspeicher mit [PVC im Wartestatus (Pending)](/docs/containers?topic=containers-cs_troubleshoot_storage#file_pvc_pending) wurde hinzugefügt.</li>
  <li>Ein Abschnitt zur Fehlerbehebung für Blockspeicher, bei dem [eine App nicht auf den PVC zugreifen oder in den PVC schreiben kann](/docs/containers?topic=containers-cs_troubleshoot_storage#block_app_failures).</li>
  </ul></li>
  </ul></td>
</tr>
<tr>
  <td>28. Mai 2019</td>
  <td><ul>
  <li><strong>Änderungsprotokoll für Cluster-Add-ons</strong>: Das [ALB-`nginx-ingress`-Image wurde auf Build 462 aktualisiert](/docs/containers?topic=containers-cluster-add-ons-changelog).</li>
  <li><strong>Fehlerbehebung für Registry</strong>: Ein [Abschnitt zur Fehlerbehebung](/docs/containers?topic=containers-cs_troubleshoot_clusters#ts_image_pull_create) für den Fall, dass Ihr Cluster aufgrund eines Fehler während der Clustererstellung keine Images aus {{site.data.keyword.registryfull}} extrahieren kann, wurde hinzugefügt. </li>
  <li><strong>Fehlerbehebung für Speicher</strong> <ul>
  <li>Ein Abschnitt zum [Debugging von Fehlern bei persistentem Speicher](/docs/containers?topic=containers-cs_troubleshoot_storage#debug_storage) wurde hinzugefügt.</li>
  <li>Ein Abschnitt zur Fehlerbehebung beim [Fehlschlagen der PVC-Erstellung aufgrund von fehlenden Berechtigungen](/docs/containers?topic=containers-cs_troubleshoot_storage#missing_permissions) wurde hinzugefügt.</li>
  </ul></li>
  </ul></td>
</tr>
<tr>
  <td>23. Mai 2019</td>
  <td><ul>
  <li><strong>CLI-Referenz</strong>: Die [CLI-Referenzseite](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli) wurde aktualisiert und spiegelt jetzt mehrere Änderungen für das [Release der Version 0.3.28](/docs/containers?topic=containers-cs_cli_changelog) des {{site.data.keyword.containerlong_notm}}-CLI-Plug-ins wider.</li>
  <li><strong>Änderungsprotokoll für Cluster-Add-ons</strong>: Das [ALB-`nginx-ingress`-Image wurde auf Build 457 aktualisiert](/docs/containers?topic=containers-cluster-add-ons-changelog).</li>
  <li><strong>Cluster- und Workerstatus</strong>: Die [Protokollierungs- und Überwachungsseite](/docs/containers?topic=containers-health#states) wurde aktualisiert und enthält jetzt Referenztabellen zum Status von Clustern und Workerknoten. </li>
  <li><strong>Clusterplanung und -erstellung</strong>: Auf den folgenden Seiten finden Sie jetzt Informationen zum Planen, Erstellen und Entfernen von Clustern sowie zur Netzplanung:
    <ul><li>[Einrichtung Ihres Clusternetzes planen](/docs/containers?topic=containers-plan_clusters)</li>
    <li>[Cluster für Hochverfügbarkeit planen](/docs/containers?topic=containers-ha_clusters)</li>
    <li>[Konfiguration Ihres Workerknotens planen](/docs/containers?topic=containers-planning_worker_nodes)</li>
    <li>[Cluster erstellen](/docs/containers?topic=containers-clusters)</li>
    <li>[Workerknoten und Zonen zu Clustern hinzufügen](/docs/containers?topic=containers-add_workers)</li>
    <li>[Cluster entfernen](/docs/containers?topic=containers-remove)</li>
    <li>[Serviceendpunkte oder VLAN-Verbindungen ändern](/docs/containers?topic=containers-cs_network_cluster)</li></ul>
  </li>
  <li><strong>Aktualisierungen der Clusterversion</strong>: Die [Richtlinie für nicht unterstützte Versionen](/docs/containers?topic=containers-cs_versions) wurde aktualisiert und enthält jetzt den Hinweis, dass Cluster nicht aktualisiert werden können, wenn die Master-Version mehr als drei oder mehr Versionen älter als die älteste unterstützte Version ist. Informationen dazu, ob ein Cluster nicht unterstützt (**unsupported**) wird, finden Sie beim Auflisten von Clustern im Statusfeld (**State**). </li>
  <li><strong>Istio</strong>: Auf der [Istio-Seite](/docs/containers?topic=containers-istio) wurde die Einschränkung entfernt, dass Istio in Clustern nicht funktioniert, die nur mit einem privaten VLAN verbunden sind. Dem [Abschnitt zum Verwalten aktualisierter Add-ons](/docs/containers?topic=containers-managed-addons#updating-managed-add-ons) wurde ein Schritt hinzugefügt um Istio-Gateways, die TLS-Abschnitte verwenden, nach Abschluss der Aktualisierung der verwalteten Istio-Add-ons erneut zu erstellen. </li>
  <li><strong>Beliebte Themen</strong>: Die beliebten Themen wurde durch diese Seite der Releaseinformationen ersetzt, auf der für {{site.data.keyword.containershort_notm}} spezifische neue Funktionen und Aktualisierungen beschrieben werden. Die neuesten Informationen zu {{site.data.keyword.Bluemix_notm}}-Produkten finden Sie in den [Ankündigungen](https://www.ibm.com/cloud/blog/announcements).</li>
  </ul></td>
</tr>
<tr>
  <td>20. Mai 2019</td>
  <td><ul>
  <li><strong>Versionsänderungsprotokolle</strong>: [Änderungsprotokolle für Workerknoten-Fixpacks](/docs/containers?topic=containers-changelog) wurden hinzugefügt.</li>
  </ul></td>
</tr>
<tr>
  <td>16. Mai 2019</td>
  <td><ul>
  <li><strong>CLI-Referenz</strong>: Die [CLI-Referenzseite](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli) wurde aktualisiert und enthält jetzt COS-Endpunkte für `logging-collect`-Befehle und die Information, dass `apiserver-refresh` die Kubernetes-Masterkomponenten neu startet. </li>
  <li><strong>Nicht unterstützt: Kubernetes Version 1.10</strong>: [Kubernetes Version 1.10](/docs/containers?topic=containers-cs_versions#cs_v114) wird nicht mehr unterstützt. </li>
  </ul></td>
</tr>
<tr>
  <td>15. Mai 2019</td>
  <td><ul>
  <li><strong>Standardversion von Kubernetes</strong>: Die Standardversion von Kubernetes ist jetzt 1.13.6.</li>
  <li><strong>Serviceeinschränkungen</strong>: Ein [Abschnitt zu Serviceeinschränkungen](/docs/containers?topic=containers-ibm-cloud-kubernetes-service-technology#tech_limits) wurde hinzugefügt.</li>
  </ul></td>
</tr>
<tr>
  <td>13. Mai 2019</td>
  <td><ul>
  <li><strong>Versionsänderungsprotokolle</strong>: Information hinzugefügt, dass neue Patchaktualisierungen für [1.14.1_1518](/docs/containers?topic=containers-changelog#1141_1518), [1.13.6_1521](/docs/containers?topic=containers-changelog#1136_1521), [1.12.8_1552](/docs/containers?topic=containers-changelog#1128_1552), [1.11.10_1558](/docs/containers?topic=containers-changelog#11110_1558) und [1.10.13_1558](/docs/containers?topic=containers-changelog#11013_1558) verfügbar sind.</li>
  <li><strong>Workerknotentypen</strong>: Alle [Workerknotentypen für virtuelle Maschinen](/docs/containers?topic=containers-planning_worker_nodes#vm) mit laut [Cloudstatus ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cloud.ibm.com/status?component=containers-kubernetes&selected=status) 48 oder mehr Kernen wurden entfernt. Sie können weiterhin [Bare-Metal-Workerknoten](/docs/containers?topic=containers-plan_clusters#bm) mit 48 oder mehr Kernen bereitstellen.</li></ul></td>
</tr>
<tr>
  <td>8. Mai 2019</td>
  <td><ul>
  <li><strong>API</strong>: Ein Link zur [Swagger-Dokumentation für die globale API ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://containers.cloud.ibm.com/global/swagger-global-api/#/) wurde hinzugefügt.</li>
  <li><strong>Cloudobjektspeicher</strong>: [Ein Handbuch zur Behebung von Fehlern in Cloudobjektspeichern](/docs/containers?topic=containers-cs_troubleshoot_storage#cos_pvc_pending) in Ihren {{site.data.keyword.containerlong_notm}}-Clustern wurde hinzugefügt. </li>
  <li><strong>Kubernetes-Strategie</strong>: Ein Abschnitt zum [vor dem Verschieben Ihrer Apps in {{site.data.keyword.containerlong_notm}} erforderlichen Wissen und den erforderlichen Qualifikationen](/docs/containers?topic=containers-strategy#knowledge) wurde hinzugefügt.</li>
  <li><strong>Kubernetes Version 1.14</strong>: Es wurde hinzugefügt, dass das [Kubernetes-Release 1.14](/docs/containers?topic=containers-cs_versions#cs_v114) zertifiziert ist. </li>
  <li><strong>Referenzabschnitte</strong>: Informationen zu verschiedenen Servicebindungs-, `Protokollierungs-` und `nlb`-Operationen wurden in den Referenzseiten für den [Benutzerzugriffs](/docs/containers?topic=containers-access_reference) und die [CLI](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli) hinzugefügt. </li></ul></td>
</tr>
<tr>
  <td>7. Mai 2019</td>
  <td><ul>
  <li><strong>Cluster-DNS-Provider</strong>: [Die Vorteile von CoreDNS](/docs/containers?topic=containers-cluster_dns) werden erläutert, da Cluster, die Kubernetes 1.14 oder höher ausführen, nur CoreDNS unterstützen.</li>
  <li><strong>Edge-Knoten</strong>: Unterstützung privater Lastausgleichsfunktionen für [Edge-Knoten](/docs/containers?topic=containers-edge) wurde hinzugefügt.</li>
  <li><strong>Kostenlose Cluster</strong>: Es wurde klargestellt, wo [kostenlose Cluster](/docs/containers?topic=containers-regions-and-zones#regions_free) unterstützt werden. </li>
  <li><strong>Neu! Integrationen</strong>: Informationen zu [Integrationen von {{site.data.keyword.Bluemix_notm}}-Services und Services anderer Anbieter](/docs/containers?topic=containers-ibm-3rd-party-integrations), [gängigen Integrationen](/docs/containers?topic=containers-supported_integrations) und [Partnerschaften](/docs/containers?topic=containers-service-partners) wurden hinzugefügt und umstrukturiert.</li>
  <li><strong>Neu! Kubernetes Version 1.14</strong>: Erstellen Sie Ihre Cluster mit [Kubernetes 1.14](/docs/containers?topic=containers-cs_versions#cs_v114) oder aktualisieren Sie Ihre Cluster auf diese Version.</li>
  <li><strong>Kubernetes Version 1.11 veraltet</strong>: [Aktualisieren](/docs/containers?topic=containers-update) Sie Cluster, die mit [Kubernetes 1.11](/docs/containers?topic=containers-cs_versions#cs_v111) ausgeführt werden, bevor sie nicht mehr unterstützt werden. </li>
  <li><strong>Berechtigungen</strong>: FAQ [Welche Zugriffsrichtlinien erteile ich meinen Clusterbenutzern?](/docs/containers?topic=containers-faqs#faq_access) wurde hinzugefügt. </li>
  <li><strong>Worker-Pools</strong>: Es wurden Anweisungen zum [Anwenden von Bezeichnungen auf vorhandene Worker-Pools](/docs/containers?topic=containers-add_workers#worker_pool_labels) hinzugefügt.</li>
  <li><strong>Referenzabschnitte</strong>: Zur Unterstützung neuer Funktionen wie Kubernetes 1.14 wurden Referenzseiten mit [Änderungsprotokollen](/docs/containers?topic=containers-changelog#changelog) aktualisiert.</li></ul></td>
</tr>
<tr>
  <td>1. Mai 2019</td>
  <td><strong>Infrastrukturzugriff zuordnen</strong>: Die [Schritte zum Zuordnen von IAM-Berechtigungen zum Öffnen von Supportfällen](/docs/containers?topic=containers-users#infra_access) wurden überarbeitet.</td>
</tr>
</tbody></table>


