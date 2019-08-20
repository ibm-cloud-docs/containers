---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

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

Die folgenden Symbole werden verwendet, um anzugeben, ob Releaseinformationen nur für eine bestimmte Containerplattform gelten. Wenn kein Symbol verwendet wird, gelten die Releaseinformationen sowohl für Community-Kubernetes- als auch für OpenShift-Cluster.<br>
<img src="images/logo_kubernetes.svg" alt="Kubernetes-Symbol" width="15" style="width:15px; border-style: none"/> Gilt nur für Community-Kubernetes-Cluster.<br>
<img src="images/logo_openshift.svg" alt="OpenShift-Symbol" width="15" style="width:15px; border-style: none"/> Gilt nur für OpenShift-Cluster, die am 5. Juni 2019 als Betaversion freigegeben wurden.
{: note}

## August 2019
{: #aug19}

<table summary="Die Tabelle zeigt Releaseinformationen. Die Zeilen sind von links nach rechts zu lesen, wobei Spalte 1 das Datum, Spalte 2 den Titel der Funktion und Spalte 3 eine Beschreibung enthält. ">
<caption>Dokumentationsaktualisierungen im August 2019</caption>
<thead>
<th>Datum</th>
<th>Beschreibung</th>
</thead>
<tbody>
<tr>
  <td>01. August 2019</td>
  <td><img src="images/logo_openshift.svg" alt="OpenShift-Symbol" width="15" style="width:15px; border-style: none"/> <strong>Red Hat OpenShift on IBM Cloud</strong>: Red Hat OpenShift on IBM Cloud wurde am 1. August 2019 um 0:00 Uhr (UTC) allgemein verfügbar gemacht. Die Gültigkeit aller Betacluster läuft innerhalb von 30 Tagen ab. Sie können einen [GA-Cluster erstellen](/docs/openshift?topic=openshift-openshift_tutorial) und anschließend alle Apps, die Sie vor der Entfernung der Betacluster auf diesen Clustern verwendet haben, neu bereitstellen.<br><br>Da die {{site.data.keyword.containerlong_notm}}-Logik und die zugrunde liegende Cloudinfrastruktur identisch sind, werden in der Dokumentation für [Community-Kubernetes](/docs/containers?topic=containers-getting-started)- und [OpenShift](/docs/openshift?topic=openshift-getting-started)-Cluster zahlreiche Abschnitte wiederverwendet (z. B. der hier vorliegende Abschnitt zu den Releaseinformationen).</td>
</tr>
</tbody></table>

## Juli 2019
{: #jul19}

<table summary="Die Tabelle zeigt Releaseinformationen. Die Zeilen sind von links nach rechts zu lesen, wobei Spalte 1 das Datum, Spalte 2 den Titel der Funktion und Spalte 3 eine Beschreibung enthält. ">
<caption>Aktualisierungen der {{site.data.keyword.containerlong_notm}}-Dokumentation im Juli 2019</caption>
<thead>
<th>Datum</th>
<th>Beschreibung</th>
</thead>
<tbody>
<tr>
  <td>30. Juli 2019</td>
  <td><ul>
  <li><strong>CLI-Änderungsprotokoll</strong>: Die Änderungsprotokollseite des {{site.data.keyword.containerlong_notm}}-CLI-Plug-ins für die [Freigabe von Version 0.3.95](/docs/containers?topic=containers-cs_cli_changelog) wurde aktualisiert.</li>
  <li><strong>Ingress-ALB-Änderungsprotokoll</strong>: Das ALB-Image `nginx-ingress` wurde für die [ALB-Pod-Bereitschaftsprüfung](/docs/containers?topic=containers-cluster-add-ons-changelog#alb_changelog) auf Build 515 aktualisiert.</li>
  <li><strong>Teilnetze aus einem Cluster entfernen</strong>: Es wurden Schritte zum Entfernen von Teilnetzen [in einem Konto der IBM Cloud-Infrastruktur](/docs/containers?topic=containers-subnets#remove-sl-subnets) oder [in einem lokalen Netz](/docs/containers?topic=containers-subnets#remove-user-subnets) aus einem Cluster hinzugefügt.</li>
  </ul></td>
</tr>
<tr>
  <td>26. Juli 2019</td>
  <td><img src="images/logo_openshift.svg" alt="OpenShift-Symbol" width="15" style="width:15px; border-style: none"/> <strong>Red Hat OpenShift on IBM Cloud</strong>: Es wurden Abschnitte für [Integrationen](/docs/openshift?topic=openshift-openshift_integrations), [Standorte](/docs/openshift?topic=openshift-regions-and-zones) und [Sicherheitskontexteinschränkungen](/docs/openshift?topic=openshift-openshift_scc) hinzugefügt. Es wurden die Clusterrollen `basic-users` und `self-provisioning` zum Abschnitt für die [IAM-Servicerolle für die RBAC-Synchronisation](/docs/openshift?topic=openshift-access_reference#service) hinzugefügt.</td>
</tr>
<tr>
  <td>23. Juli 2019</td>
  <td><strong>Fluentd-Änderungsprotokoll</strong>: Die [Alpine-Sicherheitslücken](/docs/containers?topic=containers-cluster-add-ons-changelog#fluentd_changelog) wurden korrigiert.</td>
</tr>
<tr>
  <td>22. Juli 2019</td>
  <td><ul>
  <li><img src="images/logo_kubernetes.svg" alt="Kubernetes-Symbol" width="15" style="width:15px; border-style: none"/> <strong>Versionsrichtlinie</strong>: Der Zeitraum für die [Einstellung der Versionsunterstützung](/docs/containers?topic=containers-cs_versions#version_types) wurde von 30 auf 45 Tage verlängert.</li>
      <li><img src="images/logo_kubernetes.svg" alt="Kubernetes-Symbol" width="15" style="width:15px; border-style: none"/> <strong>Versionsänderungsprotokolle</strong>: Die Änderungsprotokolle für die Patchaktualisierungen der Workerknoten [1.14.4_1526](/docs/containers?topic=containers-changelog#1144_1526_worker), [1.13.8_1529](/docs/containers?topic=containers-changelog#1138_1529_worker) und [1.12.10_1560](/docs/containers?topic=containers-changelog#11210_1560_worker) wurden aktualisiert.</li>
    <li><img src="images/logo_kubernetes.svg" alt="Kubernetes-Symbol" width="15" style="width:15px; border-style: none"/> <strong>Versionsänderungsprotokoll</strong>: [Version 1.11](/docs/containers?topic=containers-changelog#111_changelog) wird nicht mehr unterstützt.</li></ul>
  </td>
</tr>
<tr>
  <td>19. Juli 2019</td>
  <td><img src="images/logo_openshift.svg" alt="OpenShift-Symbol" width="15" style="width:15px; border-style: none"/> <strong>Red Hat OpenShift on IBM Cloud</strong>: Die [Red Hat OpenShift on IBM Cloud-Dokumentation wurde zu einem separaten Repository](/docs/openshift?topic=openshift-getting-started) hinzugefügt. Da die {{site.data.keyword.containerlong_notm}}-Logik und die zugrunde liegende Cloudinfrastruktur identisch sind, werden in der Dokumentation für Community-Kubernetes- und OpenShift-Cluster zahlreiche Abschnitte wiederverwendet (z. B. der hier vorliegende Abschnitt zu den Releaseinformationen).</td>
</tr>
<tr>
  <td>17. Juli 2019</td>
  <td><strong>Ingress-ALB-Änderungsprotokoll</strong>: [Die `rbash`-Sicherheitslücken wurden behoben](/docs/containers?topic=containers-cluster-add-ons-changelog#alb_changelog).
  </td>
</tr>
<tr>
  <td>15. Juli 2019</td>
  <td><ul>
  <li><img src="images/logo_kubernetes.svg" alt="Kubernetes-Symbol" width="15" style="width:15px; border-style: none"/> <strong>Cluster- und Workerknoten-ID</strong>: Das ID-Format für Cluster und Workerknoten wurde geändert. Vorhandene Cluster und Workerknoten behalten ihre vorhandenen IDs bei. Wenn Sie über eine Automation verfügen, die mit dem vorherigen Format arbeitet, dann führen Sie die Aktualisierung für neue Cluster durch.<ul>
  <li>**Cluster-ID**: Im regex-Format `{a-v0-9}[7]{a-z0-9}[2]{a-v0-9}[11]`</li>
  <li>**Workerknoten-ID**: Im Format `kube-<cluster_ID>-<cluster_name_truncated>-<resource_group_truncated>-<worker_ID>`</li></ul></li>
  <li><strong>Ingress-ALB-Änderungsprotokoll</strong>: Das [ALB-Image `nginx-ingress` wurde auf Build 497 aktualisiert](/docs/containers?topic=containers-cluster-add-ons-changelog#alb_changelog).</li>
  <li><strong>Fehlerbehebung für Cluster</strong>: Es wurden [Fehlerbehebungsschritte](/docs/containers?topic=containers-cs_troubleshoot_clusters#cs_totp) hinzugefügt, die angewendet werden können, wenn Cluster und Workerknoten nicht verwaltet werden können, weil die TOTP-Option (TOTP = Time-Based One-Time Passcode; zeitbasierter einmaliger Kenncode) für Ihr Konto aktiviert wurde.</li>
  <li><img src="images/logo_kubernetes.svg" alt="Kubernetes-Symbol" width="15" style="width:15px; border-style: none"/> <strong>Versionsänderungsprotokolle</strong>: Die Änderungsprotokolle für die Aktualisierungen der Master-Fixpacks [1.14.4_1526](/docs/containers?topic=containers-changelog#1144_1526), [1.13.8_1529](/docs/containers?topic=containers-changelog#1138_1529) und [1.12.10_1560](/docs/containers?topic=containers-changelog#11210_1560) wurden aktualisiert.</li></ul>
  </td>
</tr>
<tr>
  <td>08. Juli 2019</td>
  <td><ul>
  <li><strong>App-Netzbetrieb</strong>: Auf den folgenden Seiten finden Sie Informationen zum App-Netzbetrieb mit NLBs und Ingress-ALBs:
    <ul><li>[Basis- und DSR-Lastausgleich mit Netzlastausgleichsfunktionen (NLB)](/docs/containers?topic=containers-cs_sitemap#sitemap-nlb)</li>
    <li>[HTTPS-Lastausgleich mit Ingress-Lastausgleichsfunktionen für Anwendungen (ALB)](/docs/containers?topic=containers-cs_sitemap#sitemap-ingress)</li></ul>
  </li>
  <li><img src="images/logo_kubernetes.svg" alt="Kubernetes-Symbol" width="15" style="width:15px; border-style: none"/> <strong>Versionsänderungsprotokolle</strong>: Die Änderungsprotokolle für die Patchaktualisierungen der Workerknoten [1.14.3_1525](/docs/containers?topic=containers-changelog#1143_1525), [1.13.7_1528](/docs/containers?topic=containers-changelog#1137_1528), [1.12.9_1559](/docs/containers?topic=containers-changelog#1129_1559) und [1.11.10_1564](/docs/containers?topic=containers-changelog#11110_1564) wurden aktualisiert.</li></ul>
  </td>
</tr>
<tr>
  <td>02. Juli 2019</td>
  <td><strong>CLI-Änderungsprotokoll</strong>: Die Änderungsprotokollseite des {{site.data.keyword.containerlong_notm}}-CLI-Plug-ins für die [Freigabe von Version 0.3.58](/docs/containers?topic=containers-cs_cli_changelog) wurde aktualisiert.</td>
</tr>
<tr>
  <td>01. Juli 2019</td>
  <td><ul>
  <li><strong>Infrastrukturberechtigungen</strong>: Die [Rollen der klassischen Infrastruktur](/docs/containers?topic=containers-access_reference#infra), die für allgemeine Anwendungsfälle erforderlich sind, wurden aktualisiert.</li>
  <li><img src="images/logo_openshift.svg" alt="OpenShift-Symbol" width="15" style="width:15px; border-style: none"/> <strong>Häufig gestellte Fragen zu OpenShift</strong>: Der Abschnitt mit den [häufig gestellten Fragen (FAQs)](/docs/containers?topic=containers-faqs#container_platforms) wurde mit Informationen zu OpenShift-Clustern ergänzt.</li>
  <li><strong>Istio-verwaltete Apps mit {{site.data.keyword.appid_short_notm}}</strong> sichern: Es wurden Informationen zum [App Identity and Access-Adapter](/docs/containers?topic=containers-istio#app-id) hinzugefügt.</li>
  <li><strong>strongSwan-VPN-Service</strong>: Wenn Sie strongSwan in einem Cluster mit mehreren Zonen installieren und die Einstellung `enableSingleSourceIP=true` verwenden, können Sie nun [`local.subnet` in der Variablen `%zoneSubnet` festlegen und `local.zoneSubnet` zum Angeben einer IP-Adresse als /32-Teilnetz für jede Zone im Cluster verwenden](/docs/containers?topic=containers-vpn#strongswan_4).</li>
  </ul></td>
</tr>
</tbody></table>


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
  <td>24. Juni 2019</td>
  <td><ul>
  <li><strong>Calico-Netzrichtlinien</strong>: Es wurde eine Gruppe von [öffentlichen Calico-Richtlinien](/docs/containers?topic=containers-network_policies#isolate_workers_public) hinzufügt und die Gruppe der [privaten Calico-Richtlinien](/docs/containers?topic=containers-network_policies#isolate_workers) wurde erweitert, um Ihren Cluster in öffentlichen und privaten Netzen zu schützen.</li>
  <li><strong>Ingress-ALB-Änderungsprotokoll</strong>: Das [ALB-Image `nginx-ingress` wurde auf Build 477 aktualisiert](/docs/containers?topic=containers-cluster-add-ons-changelog#alb_changelog).</li>
  <li><img src="images/logo_kubernetes.svg" alt="Kubernetes-Symbol" width="15" style="width:15px; border-style: none"/> <strong>Servicebeschränkungen</strong>: Die [Beschränkung für die maximale Anzahl von Pods pro Workerknoten](/docs/containers?topic=containers-ibm-cloud-kubernetes-service-technology#tech_limits) wurde aktualisiert. Für Workerknoten, die mit Kubernetes 1.13.7_1527, 1.14.3_1524 oder höher arbeiten und mit mehr als elf CPU-Cores (Kernen) ausgestattet sind, können die Workerknoten bis zu 10 Pods pro Core unterstützen. Hierbei gilt ein Maximum von 250 Pods pro Workerknoten. </li>
  <li><img src="images/logo_kubernetes.svg" alt="Kubernetes-Symbol" width="15" style="width:15px; border-style: none"/> <strong>Versionsänderungsprotokolle</strong>: Die Änderungsprotokolle für die Patchaktualisierungen der Workerknoten [1.14.3_1524](/docs/containers?topic=containers-changelog#1143_1524), [1.13.7_1527](/docs/containers?topic=containers-changelog#1137_1527), [1.12.9_1558](/docs/containers?topic=containers-changelog#1129_1558) und [1.11.10_1563](/docs/containers?topic=containers-changelog#11110_1563) wurden hinzugefügt.</li>
  </ul></td>
</tr>
<tr>
  <td>21. Juni 2019</td>
  <td><ul>
  <li><img src="images/logo_openshift.svg" alt="OpenShift-Symbol" width="15" style="width:15px; border-style: none"/> <strong>Auf OpenShift-Cluster zugreifen</strong>: Es wurden Schritte für die [Automatisierung des Zugriffs auf einen OpenShift-Cluster mithilfe eines OpenShift-Anmeldetokens](/docs/containers?topic=containers-cs_cli_install#openshift_cluster_login) hinzugefügt.</li>
  <li><img src="images/logo_kubernetes.svg" alt="Kubernetes-Symbol" width="15" style="width:15px; border-style: none"/> <strong>Über privaten Serviceendpunkt auf Kubernetes-Master zugreifen</strong>: Es wurden Schritte zum [Bearbeiten der lokalen Kubernetes-Konfigurationsdatei](/docs/containers?topic=containers-clusters#access_on_prem) hinzugefügt, die ausgeführt werden können, wenn sowohl die öffentlichen als auch die privaten Serviceendpunkte aktiviert sind, Sie jedoch auf dem Kubernetes-Master nur über den privaten Serviceendpunkt zugreifen möchten.</li>
  <li><img src="images/logo_openshift.svg" alt="OpenShift-Symbol" width="15" style="width:15px; border-style: none"/> <strong>Fehler in OpenShift-Clustern beheben</strong>: Es wurde ein [Abschnitt zur Fehlerbehebung](/docs/openshift?topic=openshift-openshift_tutorial#openshift_troubleshoot) zum Lernprogramm 'Red Hat OpenShift on IBM Cloud-Cluster (Beta) erstellen' hinzugefügt.</li>
  </ul></td>
</tr>
<tr>
  <td>18. Juni 2019</td>
  <td><ul>
  <li><strong>CLI-Änderungsprotokoll</strong>: Die Änderungsprotokollseite des {{site.data.keyword.containerlong_notm}}-CLI-Plug-ins für die [Freigabe von Version 0.3.47 und Version 0.3.49](/docs/containers?topic=containers-cs_cli_changelog) wurde aktualisiert.</li>
  <li><strong>Ingress-ALB-Änderungsprotokoll</strong>: Das [ALB-Image `nginx-ingress` wurde auf Build 473 und das Image `ingress-auth` auf Build 331 aktualisiert](/docs/containers?topic=containers-cluster-add-ons-changelog#alb_changelog).</li>
  <li><strong>Verwaltete Add-on-Versionen</strong>: Die Version des Istio-verwalteten Add-ons wurde auf Version 1.1.7 und die Version des Knative-verwalteten Add-ons auf Version 0.6.0 aktualisiert.</li>
  <li><strong>Persistenten Speicher entfernen</strong>: Die Informationen zur Vorgehensweise bei der Abrechnung beim [Löschen von persistentem Speicher](/docs/containers?topic=containers-cleanup) wurden aktualisiert.</li>
  <li><strong>Servicebindungen mit privatem Endpunkt</strong>: Es wurden [Schritte hinzugefügt](/docs/containers?topic=containers-service-binding), mit denen Serviceberechtigungsnachweise beim Binden des Service an Ihren Cluster mit dem privaten Serviceendpunkt manuell erstellt werden können.</li>
  <li><img src="images/logo_kubernetes.svg" alt="Kubernetes-Symbol" width="15" style="width:15px; border-style: none"/> <strong>Versionsänderungsprotokolle</strong>: Die Änderungsprotokolle für die Patchaktualisierungen [1.14.3_1523](/docs/containers?topic=containers-changelog#1143_1523), [1.13.7_1526](/docs/containers?topic=containers-changelog#1137_1526), [1.12.9_1557](/docs/containers?topic=containers-changelog#1129_1557) und [1.11.10_1562](/docs/containers?topic=containers-changelog#11110_1562) wurden aktualisiert. updates.</li>
  </ul></td>
</tr>
<tr>
  <td>14. Juni 2019</td>
  <td><ul>
  <li><strong>Fehlerbehebung für `kubectl`</strong>: Es wurde ein [Abschnitt zur Fehlerbehebung](/docs/containers?topic=containers-cs_troubleshoot_clusters#kubectl_fails) für den Fall hinzugefügt, dass Sie über eine `kubectl`-Clientversion verfügen, die einen Unterschied von zwei oder mehr Versionen zur Serverversion oder der OpenShift-Version von `kubectl` aufweist. Dies ist für Community-Kubernetes-Cluster nicht möglich. </li>
  <li><strong>Landing-Page für Lernprogramme</strong>: Die Seite für zugehörige Links wurde durch eine neue [Landing-Page für Lernprogramme](/docs/containers?topic=containers-tutorials-ov) für alle Lernprogramme ersetzt, die speziell für {{site.data.keyword.containershort_notm}} vorgesehen sind.</li>
  <li><img src="images/logo_kubernetes.svg" alt="Kubernetes-Symbol" width="15" style="width:15px; border-style: none"/> <strong>Lernprogramm zum Erstellen eines Clusters und Bereitstellen einer App</strong>: Die Lernprogramme zum Erstellen von Clustern und Bereitstellen von Apps wurden zu einem umfassenden [Lernprogramm](/docs/containers?topic=containers-cs_cluster_tutorial) kombiniert.</li>
  <li><strong>Vorhandene Teilnetze zum Erstellen eines Clusters verwenden</strong>: Um [Teilnetze aus einem nicht benötigten Cluster wiederzuverwenden, wenn Sie einen neuen Cluster erstellen](/docs/containers?topic=containers-subnets#subnets_custom), müssen die Teilnetze benutzerverwaltete Teilnetze sein, die Sie manuell aus einem lokalen Netz hinzugefügt haben. Alle Teilnetze, die während der Clustererstellung automatisch bestellt wurden, werden nach dem Löschen eines Clusters sofort gelöscht, und Sie können diese Teilnetze nicht wiederverwenden, um einen neuen Cluster zu erstellen. </li>
  </ul></td>
</tr>
<tr>
  <td>12. Juni 2019</td>
  <td><strong>Clusterrollen aggregieren</strong>: Es wurden Schritte zur [Erweiterung bestehender Benutzerberechtigungen durch Aggregation von Clusterrollen](/docs/containers?topic=containers-users#rbac_aggregate) hinzugefügt.</td>
</tr>
<tr>
  <td>7. Juni 2019</td>
  <td><ul>
  <li><strong>Zugriff auf den Kubernetes-Master über den privaten Serviceendpunkt</strong>: Es wurden [Schritte](/docs/containers?topic=containers-clusters#access_on_prem) hinzugefügt, um den privaten Serviceendpunkt über eine private Lastausgleichsfunktion zugänglich zu machen. Nachdem Sie diese Schritte ausgeführt haben, können Ihre berechtigten Clusterbenutzer über eine VPN- oder {{site.data.keyword.cloud_notm}} Direct Link-Verbindung auf den Kubernetes-Master zugreifen. </li>
  <li><strong>{{site.data.keyword.BluDirectLink}}</strong>: {{site.data.keyword.cloud_notm}} Direct Link wurde der [VPN-Konnektivität](/docs/containers?topic=containers-vpn) und den [Hybrid-Cloud-Seiten](/docs/containers?topic=containers-hybrid_iks_icp) hinzugefügt, damit Sie ohne Routing über das öffentliche Internet eine direkte, private Verbindung zwischen Ihren fernen Netzumgebungen und {{site.data.keyword.containerlong_notm}} herstellen können.</li>
  <li><strong>Ingress-ALB-Änderungsprotokoll</strong>: Das [ALB-Image `ingress-auth` wurde auf Build 330 aktualisiert](/docs/containers?topic=containers-cluster-add-ons-changelog#alb_changelog).</li>
  <li><img src="images/logo_openshift.svg" alt="OpenShift-Symbol" width="15" style="width:15px; border-style: none"/> <strong>OpenShift-Betaversion</strong>: [Es wurde eine Lerneinheit](/docs/openshift?topic=openshift-openshift_tutorial#openshift_logdna_sysdig) zur Änderung von Appbereitstellungen für privilegierte Sicherheitskontexteinschränkungen für {{site.data.keyword.la_full_notm}}- und {{site.data.keyword.mon_full_notm}}-Add-ons hinzugefügt.</li>
  </ul></td>
</tr>
<tr>
  <td>6. Juni 2019</td>
  <td><ul>
  <li><strong>Fluentd-Änderungsprotokoll</strong>: Ein [Änderungsprotokoll für Fluentd-Versionen](/docs/containers?topic=containers-cluster-add-ons-changelog#fluentd_changelog) wurde hinzugefügt.</li>
  <li><strong>Ingress-ALB-Änderungsprotokoll</strong>: Das [ALB-Image `nginx-ingress` wurde auf Build 470 aktualisiert](/docs/containers?topic=containers-cluster-add-ons-changelog#alb_changelog).</li>
  </ul></td>
</tr>
<tr>
  <td>05. Juni 2019</td>
  <td><ul>
  <li><strong>CLI-Referenz</strong>: Die [CLI-Referenzseite](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli) wurde aktualisiert und spiegelt jetzt mehrere Änderungen für das [Release der Version 0.3.34](/docs/containers?topic=containers-cs_cli_changelog) des {{site.data.keyword.containerlong_notm}}-CLI-Plug-ins wider.</li>
  <li><img src="images/logo_openshift.svg" alt="OpenShift-Symbol" width="15" style="width:15px; border-style: none"/> <strong>Neu! Red Hat OpenShift on IBM Cloud-Cluster (Beta)</strong>: Mit der Betaversion von Red Hat OpenShift on IBM Cloud können Sie {{site.data.keyword.containerlong_notm}}-Cluster mit Workerknoten erstellen, die mit der Container-Orchestrierungsplattformsoftware OpenShift installiert werden. Bei der Verwendung der [OpenShift-Tools und des Katalogs ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://docs.openshift.com/container-platform/3.11/welcome/index.html), der unter Red Hat Enterprise Linux ausgeführt wird, zum Entwickeln Ihrer Apps haben Sie alle Vorteile der verwalteten {{site.data.keyword.containerlong_notm}}-Instanzen für Ihre Clusterinfrastrukturumgebung. Informationen zum Einstieg finden Sie im [Lernprogramm: Red Hat OpenShift on IBM Cloud-Cluster (Beta) erstellen](/docs/openshift?topic=openshift-openshift_tutorial).</li>
  </ul></td>
</tr>
<tr>
  <td>04. Juni 2019</td>
  <td><ul>
  <li><img src="images/logo_kubernetes.svg" alt="Kubernetes-Symbol" width="15" style="width:15px; border-style: none"/> <strong>Versionsänderungsprotokolle</strong>: Die Änderungsprotokolle für die Patch-Releases [1.14.2_1521](/docs/containers?topic=containers-changelog#1142_1521), [1.13.6_1524](/docs/containers?topic=containers-changelog#1136_1524), [1.12.9_1555](/docs/containers?topic=containers-changelog#1129_1555) und  [1.11.10_1561](/docs/containers?topic=containers-changelog#11110_1561) wurden aktualisiert.</li></ul>
  </td>
</tr>
<tr>
  <td>3. Juni 2019</td>
  <td><ul>
  <li><strong>Eigenen Ingress-Controller verwenden</strong>: Die [Schritte](/docs/containers?topic=containers-ingress-user_managed) wurden aktualisiert und spiegeln jetzt Änderungen des Standard-Community-Controllers wider und erfordern eine Statusprüfung der Controller-IP-Adressen in Mehrzonenclustern.</li>
  <li><strong>{{site.data.keyword.cos_full_notm}}</strong>: Die [Schritte](/docs/containers?topic=containers-object_storage#install_cos) wurden aktualisiert und enthalten jetzt Informationen zum Installieren des {{site.data.keyword.cos_full_notm}}-Plug-ins mit oder ohne den Helm-Server, Tiller.</li>
  <li><strong>Ingress-ALB-Änderungsprotokoll</strong>: Das [ALB-Image `nginx-ingress` wurde auf Build 467 aktualisiert](/docs/containers?topic=containers-cluster-add-ons-changelog#alb_changelog).</li>
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
  <li><strong>Änderungsprotokoll für Cluster-Add-ons</strong>: Das [ALB-Image `nginx-ingress` wurde auf Build 462 aktualisiert](/docs/containers?topic=containers-cluster-add-ons-changelog).</li>
  <li><strong>Fehlerbehebung für Registry</strong>: Ein [Abschnitt zur Fehlerbehebung](/docs/containers?topic=containers-cs_troubleshoot_clusters#ts_image_pull_create) für den Fall, dass Ihr Cluster aufgrund eines Fehler während der Clustererstellung keine Images aus {{site.data.keyword.registryfull}} extrahieren kann, wurde hinzugefügt.
  </li>
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
  <li><strong>Änderungsprotokoll für Cluster-Add-ons</strong>: Das [ALB-Image `nginx-ingress` wurde auf Build 457 aktualisiert](/docs/containers?topic=containers-cluster-add-ons-changelog).</li>
  <li><strong>Cluster- und Workerstatus</strong>: Die [Protokollierungs- und Überwachungsseite](/docs/containers?topic=containers-health#states) wurde aktualisiert und enthält jetzt Referenztabellen zum Status von Clustern und Workerknoten.</li>
  <li><strong>Clusterplanung und -erstellung</strong>: Auf den folgenden Seiten finden Sie jetzt Informationen zum Planen, Erstellen und Entfernen von Clustern sowie zur Netzplanung:
    <ul><li>[Einrichtung Ihres Clusternetzes planen](/docs/containers?topic=containers-plan_clusters)</li>
    <li>[Cluster für Hochverfügbarkeit planen](/docs/containers?topic=containers-ha_clusters)</li>
    <li>[Konfiguration Ihres Workerknotens planen](/docs/containers?topic=containers-planning_worker_nodes)</li>
    <li>[Cluster erstellen](/docs/containers?topic=containers-clusters)</li>
    <li>[Workerknoten und Zonen zu Clustern hinzufügen](/docs/containers?topic=containers-add_workers)</li>
    <li>[Cluster entfernen](/docs/containers?topic=containers-remove)</li>
    <li>[Serviceendpunkte oder VLAN-Verbindungen ändern](/docs/containers?topic=containers-cs_network_cluster)</li></ul>
  </li>
  <li><strong>Aktualisierungen der Clusterversion</strong>: Die [Richtlinie für nicht unterstützte Versionen](/docs/containers?topic=containers-cs_versions) wurde aktualisiert und enthält jetzt den Hinweis, dass Cluster nicht aktualisiert werden können, wenn die Master-Version mehr als drei oder mehr Versionen älter als die älteste unterstützte Version ist. Informationen dazu, ob ein Cluster nicht unterstützt (**unsupported**) wird, finden Sie beim Auflisten von Clustern im Statusfeld (**State**).</li>
  <li><strong>Istio</strong>: Auf der [Istio-Seite](/docs/containers?topic=containers-istio) wurde die Einschränkung entfernt, dass Istio in Clustern nicht funktioniert, die nur mit einem privaten VLAN verbunden sind. Dem [Abschnitt zum Verwalten aktualisierter Add-ons](/docs/containers?topic=containers-managed-addons#updating-managed-add-ons) wurde ein Schritt hinzugefügt um Istio-Gateways, die TLS-Abschnitte verwenden, nach Abschluss der Aktualisierung der verwalteten Istio-Add-ons erneut zu erstellen.</li>
  <li><strong>Beliebte Themen</strong>: Die beliebten Themen wurde durch diese Seite der Releaseinformationen ersetzt, auf der für {{site.data.keyword.containershort_notm}} spezifische neue Funktionen und Aktualisierungen beschrieben werden. Die neuesten Informationen zu {{site.data.keyword.cloud_notm}}-Produkten finden Sie in den [Ankündigungen](https://www.ibm.com/cloud/blog/announcements).</li>
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
  <li><strong>CLI-Referenz</strong>: Die [CLI-Referenzseite](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli) wurde aktualisiert und enthält jetzt COS-Endpunkte für `logging-collect`-Befehle und die Information, dass `apiserver-refresh` die Kubernetes-Masterkomponenten neu startet.</li>
  <li><strong>Nicht unterstützt: Kubernetes Version 1.10</strong>: [Kubernetes Version 1.10](/docs/containers?topic=containers-cs_versions#cs_v114) wird nicht mehr unterstützt.</li>
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
  <li><strong>Cloud Object Storage</strong>: [Ein Handbuch zur Behebung von Fehlern in Cloud Object Storage](/docs/containers?topic=containers-cs_troubleshoot_storage#cos_pvc_pending) in Ihren {{site.data.keyword.containerlong_notm}}-Clustern wurde hinzugefügt.</li>
  <li><strong>Kubernetes-Strategie</strong>: Ein Abschnitt zum [vor dem Verschieben Ihrer Apps in {{site.data.keyword.containerlong_notm}} erforderlichen Wissen und den erforderlichen Qualifikationen](/docs/containers?topic=containers-strategy#knowledge) wurde hinzugefügt.</li>
  <li><strong>Kubernetes Version 1.14</strong>: Es wurde hinzugefügt, dass das [Kubernetes-Release 1.14](/docs/containers?topic=containers-cs_versions#cs_v114) zertifiziert ist.</li>
  <li><strong>Referenzabschnitte</strong>: Informationen zu verschiedenen Servicebindungs-, `Protokollierungs-` und `nlb`-Operationen wurden in den Referenzseiten für den [Benutzerzugriffs](/docs/containers?topic=containers-access_reference) und die [CLI](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli) hinzugefügt.</li></ul></td>
</tr>
<tr>
  <td>7. Mai 2019</td>
  <td><ul>
  <li><strong>Cluster-DNS-Provider</strong>: [Die Vorteile von CoreDNS](/docs/containers?topic=containers-cluster_dns) werden erläutert, da Cluster, die Kubernetes 1.14 oder höher ausführen, nur CoreDNS unterstützen.</li>
  <li><strong>Edge-Knoten</strong>: Unterstützung privater Lastausgleichsfunktionen für [Edge-Knoten](/docs/containers?topic=containers-edge) wurde hinzugefügt.</li>
  <li><strong>Kostenlose Cluster</strong>: Es wurde klargestellt, wo [kostenlose Cluster](/docs/containers?topic=containers-regions-and-zones#regions_free) unterstützt werden.</li>
  <li><strong>Neu! Integrationen</strong>: Informationen zu [Integrationen von {{site.data.keyword.cloud_notm}}-Services und Services anderer Anbieter](/docs/containers?topic=containers-ibm-3rd-party-integrations), [gängigen Integrationen](/docs/containers?topic=containers-supported_integrations) und [Partnerschaften](/docs/containers?topic=containers-service-partners) wurden hinzugefügt und umstrukturiert.</li>
  <li><strong>Neu! Kubernetes Version 1.14</strong>: Erstellen Sie Ihre Cluster mit [Kubernetes 1.14](/docs/containers?topic=containers-cs_versions#cs_v114) oder aktualisieren Sie Ihre Cluster auf diese Version.</li>
  <li><strong>Kubernetes Version 1.11 veraltet</strong>: [Aktualisieren](/docs/containers?topic=containers-update) Sie Cluster, die mit [Kubernetes 1.11](/docs/containers?topic=containers-cs_versions#cs_v111) ausgeführt werden, bevor sie nicht mehr unterstützt werden.</li>
  <li><strong>Berechtigungen</strong>: FAQ [Welche Zugriffsrichtlinien erteile ich meinen Clusterbenutzern?](/docs/containers?topic=containers-faqs#faq_access) wurde hinzugefügt.</li>
  <li><strong>Worker-Pools</strong>: Es wurden Anweisungen zum [Anwenden von Bezeichnungen auf vorhandene Worker-Pools](/docs/containers?topic=containers-add_workers#worker_pool_labels) hinzugefügt.</li>
  <li><strong>Referenzabschnitte</strong>: Zur Unterstützung neuer Funktionen wie Kubernetes 1.14 wurden Referenzseiten mit [Änderungsprotokollen](/docs/containers?topic=containers-changelog#changelog) aktualisiert.</li></ul></td>
</tr>
<tr>
  <td>1. Mai 2019</td>
  <td><strong>Infrastrukturzugriff zuordnen</strong>: Die [Schritte zum Zuordnen von IAM-Berechtigungen zum Öffnen von Supportfällen](/docs/containers?topic=containers-users#infra_access) wurden überarbeitet.</td>
</tr>
</tbody></table>


