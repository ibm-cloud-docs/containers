---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-30"

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
{:note: .note}


# Versionsinformationen und Aktualisierungsaktionen
{: #cs_versions}

## Kubernetes-Versionstypen
{: #version_types}

{{site.data.keyword.containerlong}} unterstützt momentan mehrere Versionen von Kubernetes. Wenn die aktuellste Version (n) freigegeben wird, werden bis zu 2 Versionen davor (n-2) unterstützt. Versionen, die mehr als zwei Versionen älter sind, als die aktuellsten Version (n-3) sind zunächst veraltet und werden dann nicht weiter unterstützt.
{:shortdesc}


**Unterstützte Kubernetes-Versionen**:
*   Aktuelle: 1.14.4
*   Standard: 1.13.8
*   Sonstige: 1.12.10

**Veraltete und nicht unterstützte Kubernetes-Versionen:**
*   Veraltet: n.z.
*   Nicht unterstützt: 1.5, 1.7, 1.8, 1.9, 1.10, 1.11  

</br>

**Veraltete Versionen:** Wenn Cluster unter einer veralteten Kubernetes-Version ausgeführt werden, haben Sie mindestens 45 Tage Zeit, um die momentan verwendete Kubernetes-Version zu überprüfen und auf dem System eine Aktualisierung auf eine unterstützte Kubernetes-Version durchzuführen, bevor die veraltete Version nicht mehr unterstützt wird. Während des Zeitraums der Einstellung der Unterstützung ist Ihr Cluster noch funktionstüchtig, muss jedoch möglicherweise auf ein unterstütztes Release aktualisiert werden, um Sicherheitslücken zu schließen. Sie können z. B. Workerknoten hinzufügen und neu laden, aber keine neuen Cluster erstellen, die die veraltete Version verwenden, wenn die Unterstützung dieser Version in weniger als 45 Tagen eingestellt wird.

**Nicht unterstützte Versionen:** Wenn Ihre Cluster eine Kubernetes-Version ausführen, die nicht unterstützt wird, prüfen Sie die folgenden potenziellen Auswirkungen von Aktualisierungen und [aktualisieren Sie dann den Cluster](/docs/containers?topic=containers-update#update) sofort, damit Sie weiterhin wichtige Sicherheitsupdates und Support erhalten. Nicht unterstützte Cluster können keine Workerknoten hinzufügen oder vorhandene Workerknoten erneut laden. Sie können ermitteln, ob Ihr Cluster **nicht unterstützt wird**, indem Sie das Statusfeld (**State**) in der Ausgabe des Befehls `ibmcloud ks clusters` oder in der [{{site.data.keyword.containerlong_notm}}-Konsole ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cloud.ibm.com/kubernetes/clusters) prüfen.

Wenn Sie warten, bis Ihr Cluster gegenüber der ältesten unterstützten Version drei oder mehr Nebenversionen zurückliegt, können Sie den Cluster nicht aktualisieren. Erstellen Sie stattdessen [einen neuen Cluster](/docs/containers?topic=containers-clusters#clusters), [stellen Sie Ihre Apps für den neuen Cluster bereit](/docs/containers?topic=containers-app#app) und [löschen](/docs/containers?topic=containers-remove) Sie den nicht unterstützten Cluster.<br><br>Zur Vermeidung dieses Problems aktualisieren Sie den veralteten Cluster zunächst auf eine unterstützte Version, die weniger als drei Nebenversionen hinter der aktuellen Version zurückliegt, wie zum Beispiel die Versionen 1.11 bis 1.12, und aktualisieren Sie anschließend auf die neueste Version, 1.14. Wenn die Workerknoten eine Version ausführen, die drei oder mehr Versionen hinter dem Master zurückliegt, schlagen Ihre Pods möglicherweise mit einem Status `MatchNodeSelector`, `CrashLoopBackOff` oder `ContainerCreating` fehl, bis Sie die Workerknoten auf dieselbe Version wie den Master aktualisieren. Nachdem Sie den Cluster von einer veralteten Version auf eine unterstützte Version aktualisiert haben, kann Ihr Cluster den normalen Betrieb wieder aufnehmen und weiterhin Support erhalten.
{: important}

</br>

Führen Sie den folgenden Befehl aus, um die Serverversion eines Clusters zu überprüfen.
```
kubectl version  --short | grep -i server
```
{: pre}

Beispielausgabe:
```
Serverversion: v1.13.8+IKS
```
{: screen}


## Aktualisierungstypen
{: #update_types}

Für Ihr Kubernetes-Cluster gibt es drei Typen von Aktualisierungen: Hauptversion, Nebenversion und Patch.
{:shortdesc}

|Aktualisierungstyp|Beispiel für Versionskennzeichnungen|Aktualisierung durch|Auswirkung
|-----|-----|-----|-----|
|Hauptversion|1.x.x|Sie|Operationsänderungen für Cluster, darunter Scripts oder Bereitstellungen.|
|Nebenversion|x.9.x|Sie|Operationsänderungen für Cluster, darunter Scripts oder Bereitstellungen.|
|Patch|x.x.4_1510|IBM und Sie|Kubernetes-Patches und andere Aktualisierungen von {{site.data.keyword.cloud_notm}} Provider-Komponenten, z. B. Sicherheits- und Betriebssystempatches. IBM aktualisiert die Master automatisch, aber Sie wenden Patches auf Workerknoten an. Informationen zu weiteren Patches finden Sie im folgenden Abschnitt.|
{: caption="Auswirkungen auf Kubernetes-Aktualisierungen" caption-side="top"}

Sobald Aktualisierungen verfügbar sind, werden Sie benachrichtigt, wenn Sie Informationen zu den Workerknoten anzeigen, z. B. mit den Befehlen `ibmcloud ks workers --cluster <cluster>` oder `ibmcloud ks worker-get --cluster <cluster> --worker <worker>`.
-  **Aktualisierungen von Haupt- und Nebenversionen (1.x)**: Zuerst [aktualisieren Sie Ihren Masterknoten](/docs/containers?topic=containers-update#master) und anschließend [die Workerknoten](/docs/containers?topic=containers-update#worker_node). Workerknoten können keine Haupt- oder Nebenversion von Kubernetes ausführen, die höher als die des Masters ist.
   - Sie können einen Kubernetes-Master nicht über mehr als drei oder mehr Nebenversionen hinweg aktualisieren. Wenn die aktuelle Masterversion beispielsweise 1.11 ist und Sie eine Aktualisierung auf 1.14 durchführen möchten, müssen Sie zunächst auf Version 1.12 aktualisieren.
   - Wenn Sie eine `kubectl`-CLI-Version verwenden, die nicht wenigstens mit der Version `major.minor` Ihrer Cluster übereinstimmt, kann dies zu unerwarteten Ergebnissen führen. Stellen Sie sicher, dass Ihr Kubernetes-Cluster und die [CLI-Versionen](/docs/containers?topic=containers-cs_cli_install#kubectl) immer auf dem neuesten Stand sind.
-  **Patchaktualisierungen (x.x.4_1510)**: Änderungen für Patches werden im [Versionsänderungsprotokoll](/docs/containers?topic=containers-changelog) dokumentiert. Master-Patches werden automatisch angewendet, während Aktualisierungen durch Workerknotenpatches von Ihnen eingeleitet werden. Workerknoten können außerdem Patchversionen ausführen, die höher als die des Masters sind. Sind Aktualisierungen verfügbar, werden Sie benachrichtigt, wenn Sie Informationen zum Masterknoten und den Workerknoten in der {{site.data.keyword.cloud_notm}}-Konsole oder -CLI beispielsweise mit den folgenden Befehlen anzeigen: `ibmcloud ks clusters`, `cluster-get`, `workers` oder `worker-get`.
   - **Patches für Workerknoten**: Überprüfen Sie einmal im Monat, ob eine Aktualisierung verfügbar ist, und verwenden Sie den [Befehl](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_update) `ibmcloud ks worker-update` oder den [Befehl](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_reload) `ibmcloud ks worker-reload`, um diese Sicherheits- und Betriebssystempatches anzuwenden. Während einer Aktualisierung oder eines erneuten Ladens wird von Ihrer Workerknotenmaschine ein neues Image erstellt und dabei werden Daten gelöscht, die nicht [außerhalb des Workerknotens gespeichert sind](/docs/containers?topic=containers-storage_planning#persistent_storage_overview).
   - **Master-Patches**: Master-Patches werden automatisch über mehrere Tage hinweg angewendet, sodass eine Master-Patch-Version möglicherweise als verfügbar angezeigt wird, bevor sie auf den Master angewendet wird. Die Aktualisierungsautomatisierung überspringt auch Cluster, die sich in einem nicht einwandfreien Zustand befinden oder in denen derzeit Operationen ausgeführt werden. Es kann vorkommen, dass IBM gelegentlich die automatischen Aktualisierungen für ein bestimmtes Master-Fixpack inaktiviert (wie im Änderungsprotokoll vermerkt), zum Beispiel ein Patch, das nur benötigt wird, wenn ein Master von einer Nebenversion auf eine andere Version aktualisiert wird. In allen diesen Fällen können Sie den [Befehl](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_update) `ibmcloud ks cluster-update` sicher selbst verwenden, ohne auf die Anwendung der automatischen Aktualisierung zu warten.

</br>

{: #prep-up}
Diese Informationen fassen die Aktualisierungen zusammen, die sich voraussichtlich auf die bereitgestellten Apps auswirken, wenn Sie einen Cluster von einer vorherigen Version auf eine neue Version aktualisieren.

-  Version 1.14 [Vorbereitungsaktionen](#cs_v114).
-  Version 1.13 [Vorbereitungsaktionen](#cs_v113).
-  Version 1.12 [Vorbereitungsaktionen](#cs_v112).
-  [Archiv](#k8s_version_archive) nicht unterstützter Versionen.

<br/>

Eine vollständige Liste von Änderungen finden Sie im Rahmen der folgenden Informationen:
* [Kubernetes-Änderungsprotokoll ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG.md).
* [Änderungsprotokoll der IBM Versionen](/docs/containers?topic=containers-changelog).

</br>

## Releaseprotokoll
{: #release-history}

In der folgenden Tabelle ist das Protokoll der {{site.data.keyword.containerlong_notm}}-Versionreleases aufgezeichnet. Sie können diese Informationen zu Planungszwecken verwenden, zum Beispiel um den allgemeinen Zeitrahmen abzuschätzen, in dem ein bestimmtes Release zu einem nicht mehr unterstützten Release wird. Wenn die Kubernetes-Community eine Versionsaktualisierung freigegeben hat, beginnt das IBM Team mit einem Prozess, um das Release für {{site.data.keyword.containerlong_notm}}-Umgebungen in seiner Relevanz zu bestätigen und zu testen. Datumsangaben für Verfügbarkeit und nicht unterstützte Releases hängen von den Ergebnissen dieser Tests, Community-Updates, Sicherheitspatches und Technologieänderungen zwischen Versionen ab. Planen Sie, die Versionen Ihres Cluster-Masters und Ihrer Workerknoten entsprechend der Versionsunterstützungsrichtlinie `n-2` auf aktuellem Stand zu halten.
{: shortdesc}

{{site.data.keyword.containerlong_notm}} war zuerst mit Kubernetes Version 1.5 allgemein verfügbar. Datumsangaben für projektierte Releases und Beendigungen der Unterstützung unterliegen Änderungen. Klicken Sie auf die Versionsnummer, um zu den Vorbereitungsschritten für die Versionsaktualisierung zu wechseln.

Datumsangaben mit einem Kreuzzeichen (`†`) sind vorläufig und können sich ändern.
{: important}

<table summary="Diese Tabelle enthält das Releaseprotokoll für {{site.data.keyword.containerlong_notm}}.">
<caption>Releaseprotokoll für {{site.data.keyword.containerlong_notm}}.</caption>
<col width="20%" align="center">
<col width="20%">
<col width="30%">
<col width="30%">
<thead>
<tr>
<th>Unterstützt?</th>
<th>Version</th>
<th>{{site.data.keyword.containerlong_notm}}<br>Datum des Release</th>
<th>{{site.data.keyword.containerlong_notm}}<br>Datum für Beendigung der Unterstützung</th>
</tr>
</thead>
<tbody>  
<tr>
  <td><img src="images/checkmark-filled.png" align="left" width="32" style="width:32px;" alt="Diese Version wird unterstützt."/></td>
  <td>[1.14](#cs_v114)</td>
  <td>7. Mai 2019</td>
  <td>April 2020 `†`</td>
</tr>
<tr>
  <td><img src="images/checkmark-filled.png" align="left" width="32" style="width:32px;" alt="Diese Version wird unterstützt."/></td>
  <td>[1.13](#cs_v113)</td>
  <td>05. Februar 2019</td>
  <td>Januar 2020 `†`</td>
</tr>
<tr>
  <td><img src="images/checkmark-filled.png" align="left" width="32" style="width:32px;" alt="Diese Version wird unterstützt."/></td>
  <td>[1.12](#cs_v112)</td>
  <td>07. November 2018</td>
  <td>Oktober 2019 `†`</td>
</tr>
<tr>
  <td><img src="images/close-filled.png" align="left" width="32" style="width:32px;" alt="Diese Version wird nicht unterstützt."/></td>
  <td>[1.11](#cs_v111)</td>
  <td>14. August 2018</td>
  <td>20. Juli 2019</td>
</tr>
<tr>
  <td><img src="images/close-filled.png" align="left" width="32" style="width:32px;" alt="Diese Version wird nicht unterstützt."/></td>
  <td>[1.10](#cs_v110)</td>
  <td>01. Mai 2018</td>
  <td>16. Mai 2019</td>
</tr>
<tr>
  <td><img src="images/close-filled.png" align="left" width="32" style="width:32px;" alt="Diese Version wird nicht unterstützt."/></td>
  <td>[1.9](#cs_v19)</td>
  <td>08. Februar 2018</td>
  <td>27. Dezember 2018</td>
</tr>
<tr>
  <td><img src="images/close-filled.png" align="left" width="32" style="width:32px;" alt="Diese Version wird nicht unterstützt."/></td>
  <td>[1.8](#cs_v18)</td>
  <td>08. November 2017</td>
  <td>22. September 2018</td>
</tr>
<tr>
  <td><img src="images/close-filled.png" align="left" width="32" style="width:32px;" alt="Diese Version wird nicht unterstützt."/></td>
  <td>[1.7](#cs_v17)</td>
  <td>19. September 2017</td>
  <td>21. Juni 2018</td>
</tr>
<tr>
  <td><img src="images/close-filled.png" align="left" width="32" style="width:32px;" alt="Diese Version wird nicht unterstützt."/></td>
  <td>1.6</td>
  <td>n.z.</td>
  <td>n.z.</td>
</tr>
<tr>
  <td><img src="images/close-filled.png" align="left" width="32" style="width:32px;" alt="Diese Version wird nicht unterstützt."/></td>
  <td>[1.5](#cs_v1-5)</td>
  <td>23. Mai 2017</td>
  <td>04. April 2018</td>
</tr>
</tbody>
</table>

<br />


## Version 1.14
{: #cs_v114}

<p><img src="images/certified_kubernetes_1x14.png" style="padding-right: 10px;" align="left" alt="Dieses Flag zeigt die Kubernetes-Version 1.14-Zertifizierung für {{site.data.keyword.containerlong_notm}} an."/> {{site.data.keyword.containerlong_notm}} ist ein zertifiziertes Kubernetes-Produkt für Version 1.14 unter dem CNCF Kubernetes Software Conformance Certification Program. _Kubernetes® ist eine eingetragene Marke von The Linux Foundation in den USA und anderen Ländern und wird entsprechend einer Lizenz von The Linux Foundation verwendet._</p>

Überprüfen Sie Änderungen, die Sie möglicherweise bei einer Aktualisierung von der vorherigen Version auf die Kubernetes-Version 1.14 vornehmen müssen.
{: shortdesc}

Kubernetes 1.14 führt neue Funktionen ein, die Sie erkunden können. Testen Sie das neue [`kustomize`-Projekt ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/kubernetes-sigs/kustomize), mit dem Sie die YAML-Konfigurationen Ihrer Kubernetes-Ressource schreiben, anpassen und wiederverwenden können. Oder sehen Sie sich die neue [`kubectl`-CLI-Dokumentation an ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubectl.docs.kubernetes.io/).
{: tip}

### Vor Master aktualisieren
{: #114_before}

In der folgenden Tabelle sind die Aktionen aufgeführt, die Sie ausführen müssen, bevor Sie den Kubernetes-Master aktualisieren.
{: shortdesc}

<table summary="Kubernetes-Aktualisierungen für Version 1.14">
<caption>Vorzunehmende Änderungen vor der Aktualisierung des Masters auf Kubernetes 1.14</caption>
<thead>
<tr>
<th>Typ</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>Änderung der CRI-Pod-Protokollverzeichnisstruktur</td>
<td>In der CRI (Container Runtime Interface) wurde die Pod-Protokollverzeichnisstruktur von `/var/log/pods/<uid>` in `/var/log/pods/<uid_des_namensbereichsnamens>` geändert. Wenn Ihre Apps Kubernetes und die CRI umgehen, um auf Pod-Protokolle direkt auf den Workerknoten zuzugreifen, aktualisieren Sie sie, sodass sie beide Verzeichnisstrukturen verarbeiten können. Der Zugriff auf Pod-Protokolle über Kubernetes, z. B. mit dem Befehl `kubectl logs`, ist von dieser Änderung nicht betroffen.</td>
</tr>
<tr>
<td>Statusprüfungen folgen Weiterleitungen nicht mehr</td>
<td>Aktivitäts- und Bereitschaftsprüfungen im Rahmen der Statusprüfung, die `HTTPGetAction` verwenden, werden nicht mehr an Hostnamen weitergeleitet, die von der ursprünglichen Prüfungsanforderung abweichen. Stattdessen geben diese nicht lokalen Umleitungen eine `Success`-Antwort zurück und ein Ereignis mit der Ursache `ProbeWarning` wird generiert, um anzuzeigen, dass die Weiterleitung ignoriert wurde. Wenn Sie Statusprüfungen für verschiedene Hostnamenendpunkte bisher auf der Basis der Weiterleitungen ausgeführt haben, müssen Sie die Statusprüfungslogik außerhalb von `kubelet` ausführen. Beispiel: Sie können den externen Endpunkt als Proxy verwenden, anstatt die Prüfungsanforderung weiterzuleiten.</td>
</tr>
<tr>
<td>Nicht unterstützt: KubeDNS-Cluster-DNS-Provider</td>
<td>CoreDNS ist jetzt der einzige unterstützte Cluster-DNS-Provider für Cluster, die Kubernetes Version 1.14 und höher ausführen. Wenn Sie einen vorhandenen Cluster, der KubeDNS als Cluster-DNS-Provider verwendet, auf Version 1.14 aktualisieren, wird KubeDNS während der Aktualisierung automatisch auf CoreDNS aktualisiert. Bevor Sie den Cluster aktualisieren, sollten Sie zunächst [CoreDNS als Cluster-DNS-Provider einrichten](/docs/containers?topic=containers-cluster_dns#set_coredns) und testen. Wenn Ihre App beispielsweise mit einem älteren DNS-Client arbeitet, dann müssen Sie ggf. die [App aktualisieren oder CoreDNS anpassen](/docs/containers?topic=containers-cs_troubleshoot_network#coredns_issues).<br><br>CoreDNS unterstützt die [Cluster-DNS-Spezifikation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/kubernetes/dns/blob/master/docs/specification.md#25---records-for-external-name-services) zur Eingabe eines Domänennamens in das Kubernetes Service-Feld `ExternalName`. Der vorherige Cluster-DNS-Provider KubeDNS folgt der Cluster-DNS-Spezifikation nicht und zulässt an sich IP-Adressen für das Feld `ExternalName` zu. Wenn Kubernetes Services vorhanden sind, die IP-Adressen anstelle von DNS verwenden, müssen Sie das Feld `ExternalName` zur Fortsetzung der Funktionalität in DNS aktualisieren.</td>
</tr>
<tr>
<td>Nicht unterstützt: Kubernetes-Alpha-Funktion `Initializers`</td>
<td>Die Kubernetes-Alpha-Funktion `Initializers`, die API-Version `admissionregistration.k8s.io/v1alpha1`, das `Initializers`-Zugangscontroller-Plug-in und die Verwendung des API-Felds `metadata.initializers` wurden entfernt. Wenn Sie `Initializers` verwenden, wechseln Sie zu [Kubernetes-Zugangs-Webhooks ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/reference/access-authn-authz/extensible-admission-controllers/) und löschen Sie alle vorhandenen `InitializerConfiguration`-API-Objekte, bevor Sie den Cluster aktualisieren.</td>
</tr>
<tr>
<td>Nicht unterstützt: Knoten-Alpha-Taints</td>
<td>Die Verwendung der Taints `node.alpha.kubernetes.io/notReady` und `node.alpha.kubernetes.io/unreachable` wird nicht mehr unterstützt. Wenn Sie diese Taints verwenden, aktualisieren Sie Apps, sodass stattdessen die Taints `node.kubernetes.io/not-ready` und `node.kubernetes.io/unreachable` verwendet werden.</td>
</tr>
<tr>
<td>Nicht unterstützt: Kubernetes-API-Swagger-Dokumente</td>
<td>Die Schema-API-Dokumente `swagger/*`, `/swagger.json` und `/swagger-2.0.0.pb-v1` wurden entfernt und durch die Schema-API-Dokumente aus `/openapi/v2` ersetzt. Die Swagger-Dokumente werden nicht mehr verwendet, seitdem die OpenAPI-Dokumentation in Kubernetes Version 1.10 verfügbar ist. Außerdem aggregiert der Kubernetes-API-Server jetzt nur OpenAPI-Schemas von `/openapi/v2`-Endpunkten aggregierter API-Server. Es wird nicht mehr von `/swagger.json` aggregiert. Wenn Sie Apps installiert haben, die Kubernetes-API-Erweiterungen bereitstellen, stellen Sie sicher, dass Ihre Apps die Schema-API-Dokumente aus `/openapi/v2` unterstützen.</td>
</tr>
<tr>
<td>Nicht unterstützt und veraltet: ausgewählten Metriken</td>
<td>Lesen Sie die Informationen zu [entfernten und veralteten Kubernetes-Metriken ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.14.md#removed-and-deprecated-metrics). Wenn Sie eine dieser veralteten Metriken verwenden, wechseln Sie zu den verfügbaren Ersatzmetriken.</td>
</tr>
</tbody>
</table>

### Nach Master aktualisieren
{: #114_after}

In der folgenden Tabelle sind die Aktionen aufgeführt, die Sie ausführen müssen, nachdem Sie den Kubernetes-Master aktualisiert haben.
{: shortdesc}

<table summary="Kubernetes-Aktualisierungen für Version 1.14">
<caption>Vorzunehmende Änderungen nach der Aktualisierung des Masters auf Kubernetes 1.14</caption>
<thead>
<tr>
<th>Typ</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>Nicht unterstützt: `kubectl --show-all`</td>
<td>Das Flag `--show-all` und die zugehörige Kurzform `-a` werden nicht mehr unterstützt. Wenn Ihre Scripts die bisherigen Flags erwarten, aktualisieren Sie die Scripts.</td>
</tr>
<tr>
<td>Kubernetes-RBAC-Standardrichtlinien für nicht authentifizierte Benutzer</td>
<td>Die Kubernetes-Standardrichtlichen für rollenbasierte Zugriffssteuerung (RBAC) erteilen [nicht authentifizierten Benutzern keine Berechtigung mehr für Erkennungs-APIs oder APIs zur Überprüfung von Berechtigungen ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#discovery-roles). Diese Änderung gilt nur für neue Cluster der Version 1.14. Wenn Sie einen Cluster einer früheren Version aktualisieren, haben nicht authentifizierte Benutzer weiterhin Zugriff auf die Erkennungs-APIs und die APIs zur Überprüfung von Berechtigungen. Wenn Sie auf die sicherere Standardeinstellung für nicht authentifizierte Benutzer aktualisieren möchten, entfernen Sie die Gruppe `system:unauthenticated` aus den Cluster-Rollenbindungen `system:basic-user` und `system:discovery`.</td>
</tr>
<tr>
<td>Veraltet: Prometheus-Abfragen, die `pod_name`- und `container_name`-Bezeichnungen verwenden</td>
<td>Aktualisieren Sie alle Prometheus-Abfragen, die die Bezeichnungen `pod_name` oder`container_name` verwenden so, dass stattdessen die Bezeichnungen `pod` bzw. `container` verwendet werden. Beispielabfragen, die diese veralteten Bezeichnungen möglicherweise verwenden, enthalten kubelet-Prüfmetriken. Die veralteten Bezeichnungen `pod_name` und `container_name` werden im nächsten Kubernetes-Release nicht mehr unterstützt.</td>
</tr>
</tbody>
</table>

<br />


## Version 1.13
{: #cs_v113}

<p><img src="images/certified_kubernetes_1x13.png" style="padding-right: 10px;" align="left" alt="Dieses Flag zeigt die Kubernetes Version 1.13-Zertifizierung für {{site.data.keyword.containerlong_notm}} an."/> {{site.data.keyword.containerlong_notm}} ist ein zertifiziertes Kubernetes-Produkt für Version 1.13 unter dem CNCF Kubernetes Software Conformance Certification Program. _Kubernetes® ist eine eingetragene Marke von The Linux Foundation in den USA und anderen Ländern und wird entsprechend einer Lizenz von The Linux Foundation verwendet._</p>

Überprüfen Sie Änderungen, die Sie möglicherweise bei einer Aktualisierung von der vorherigen Version auf die Kubernetes-Version 1.13 vornehmen müssen.
{: shortdesc}

### Vor Master aktualisieren
{: #113_before}

In der folgenden Tabelle sind die Aktionen aufgeführt, die Sie ausführen müssen, bevor Sie den Kubernetes-Master aktualisieren.
{: shortdesc}

<table summary="Kubernetes-Aktualisierungen für Version 1.13">
<caption>Vorzunehmende Änderungen vor der Aktualisierung des Masters auf Kubernetes 1.13</caption>
<thead>
<tr>
<th>Typ</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>n.z.</td>
<td></td>
</tr>
</tbody>
</table>

### Nach Master aktualisieren
{: #113_after}

In der folgenden Tabelle sind die Aktionen aufgeführt, die Sie ausführen müssen, nachdem Sie den Kubernetes-Master aktualisiert haben.
{: shortdesc}

<table summary="Kubernetes-Aktualisierungen für Version 1.13">
<caption>Vorzunehmende Änderungen nach der Aktualisierung des Masters auf Kubernetes 1.13</caption>
<thead>
<tr>
<th>Typ</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>CoreDNS als neuer Standard-Cluster-DNS-Provider verfügbar</td>
<td>CoreDNS ist jetzt der Standard-Cluster-DNS-Provider für neue Cluster in Kubernetes 1.13 und höher. Wenn Sie einen vorhandenen Cluster, der KubeDNS als Cluster-DNS-Provider verwendet, auf 1.13 aktualisieren, wird KubeDNS weiterhin als Cluster-DNS-Provider verwendet. Sie können stattdessen jedoch auch [CoreDNS verwenden](/docs/containers?topic=containers-cluster_dns#dns_set). Sie können z. B. Ihre Apps unter CoreDNS testen, um sich auf die nächste Aktualisierung der Kubernetes-Version vorzubereiten und sicherzustellen, dass die [App nicht aktualisiert bzw. CoreDNS nicht angepasst werden muss](/docs/containers?topic=containers-cs_troubleshoot_network#coredns_issues).
<br><br>CoreDNS unterstützt die [Cluster-DNS-Spezifikation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/kubernetes/dns/blob/master/docs/specification.md#25---records-for-external-name-services) zur Eingabe eines Domänennamens in das Kubernetes Service-Feld `ExternalName`. Der vorherige Cluster-DNS-Provider KubeDNS folgt der Cluster-DNS-Spezifikation nicht und zulässt an sich IP-Adressen für das Feld `ExternalName` zu. Wenn Kubernetes Services vorhanden sind, die IP-Adressen anstelle von DNS verwenden, müssen Sie das Feld `ExternalName` zur Fortsetzung der Funktionalität in DNS aktualisieren.</td>
</tr>
<tr>
<td>Ausgabe von `kubectl` für `Deployment` und `StatefulSet`</td>
<td>Die Ausgabe von `kubectl` für `Deployment` (Bereitstellung) und `StatefulSet` (statusabhängige Gruppe) enthält jetzt eine Spalte `Ready` (Bereit) und ist besser lesbar. Wenn Ihre Scripts das bisherige Verhalten erwarten, aktualisieren Sie die Scripts.</td>
</tr>
<tr>
<td>Ausgabe von `kubectl` für `PriorityClass`</td>
<td>Die Ausgabe von `kubectl` für `PriorityClass` (Prioritätsklasse) enthält jetzt eine Spalte `Value` (Wert). Wenn Ihre Scripts das bisherige Verhalten erwarten, aktualisieren Sie die Scripts.</td>
</tr>
<tr>
<td>`kubectl get componentstatuses`</td>
<td>Der Befehl `kubectl get componentstatuses` meldet den Status einiger Kubernetes-Masterkomponenten nicht korrekt, weil diese Komponenten vom Kubernetes-API-Server aus nicht mehr zugänglich sind, da jetzt `localhost` und die unsicheren Ports (HTTP-Ports) inaktiviert sind. Seit der Einführung hoch verfügbarer Master (HA-Master) in Kubernetes Version 1.10 wird jeder Kubernetes-Master mit mehreren Instanzen von `apiserver`, `controller-manager`, `scheduler` und `etcd` eingerichtet. Prüfen Sie den Clusterstatus stattdessen über die [{{site.data.keyword.cloud_notm}}-Konsole ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cloud.ibm.com/kubernetes/landing) oder mit dem [Befehl](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_get) `ibmcloud ks cluster-get`.</td>
</tr>
<tr>
<tr>
<td>Nicht unterstützt: `kubectl run-container`</td>
<td>Der Befehl `kubectl run-container` wurde entfernt. Verwenden Sie stattdessen den Befehl `kubectl run`.</td>
</tr>
<tr>
<td>`kubectl rollout undo`</td>
<td>Wenn Sie den Befehl `kubectl rollout undo` für eine Revision ausführen, die nicht vorhanden ist, wird ein Fehler zurückgegeben. Wenn Ihre Scripts das bisherige Verhalten erwarten, aktualisieren Sie die Scripts.</td>
</tr>
<tr>
<td>Veraltet: Annotation `scheduler.alpha.kubernetes.io/critical-pod`</td>
<td>Die Annotation `scheduler.alpha.kubernetes.io/critical-pod` ist jetzt veraltet. Ändern Sie alle Pods, die von dieser Annotation abhängig sind, sodass sie stattdessen die [Podpriorität](/docs/containers?topic=containers-pod_priority#pod_priority) verwenden.</td>
</tr>
</tbody>
</table>

### Nach Workerknoten aktualisieren
{: #113_after_workers}

In der folgenden Tabelle sind die Aktionen aufgeführt, die Sie ausführen müssen, nachdem Sie Ihre Workerknoten aktualisiert haben.
{: shortdesc}

<table summary="Kubernetes-Aktualisierungen für Version 1.13">
<caption>Vorzunehmende Änderungen nach der Aktualisierung der Workerknoten auf Kubernetes 1.13</caption>
<thead>
<tr>
<th>Typ</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>containerd-Streaming-Server `cri`</td>
<td>In containerd Version 1.2 arbeitet der Streaming-Server des Plug-ins `cri` jetzt über einen zufällig ausgewählten Port `http://localhost:0`. Diese Änderung unterstützt den Streaming-Proxy `kubelet` und stellt eine sicherere Streaming-Schnittstelle für die Containeroperationen `exec` und `logs` bereit. Zuvor war der Streaming-Server `cri` über die private Netzschnittstelle des Workerknotens an Port 10010 empfangsbereit. Wenn Ihre Apps das Container-Plug-in `cri` verwenden und von dem vorherigen Verhalten abhängig sind, aktualisieren Sie die Apps.</td>
</tr>
</tbody>
</table>

<br />



## Version 1.12
{: #cs_v112}

<p><img src="images/certified_kubernetes_1x12.png" style="padding-right: 10px;" align="left" alt="Dieses Flag zeigt die Kubernetes Version 1.9-Zertifizierung für IBM Cloud Container Service an."/> {{site.data.keyword.containerlong_notm}} ist ein zertifiziertes Kubernetes-Produkt für Version 1.12 unter dem CNCF Kubernetes Software Conformance Certification Program. _Kubernetes® ist eine eingetragene Marke von The Linux Foundation in den USA und anderen Ländern und wird entsprechend einer Lizenz von The Linux Foundation verwendet._</p>

Überprüfen Sie Änderungen, die Sie möglicherweise bei einer Aktualisierung von der vorherigen Version auf die Kubernetes-Version 1.12 vornehmen müssen.
{: shortdesc}

### Vor Master aktualisieren
{: #112_before}

In der folgenden Tabelle sind die Aktionen aufgeführt, die Sie ausführen müssen, bevor Sie den Kubernetes-Master aktualisieren.
{: shortdesc}

<table summary="Kubernetes-Aktualisierungen für Version 1.12">
<caption>Vorzunehmende Änderungen vor der Aktualisierung des Masters auf Kubernetes 1.12</caption>
<thead>
<tr>
<th>Typ</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes-Metrik-Server</td>
<td>Wenn derzeit eine `metric-server`-Instanz von Kubernetes in Ihrem Cluster bereitgestellt ist, müssen Sie die `metric-server`-Instanz entfernen, bevor Sie den Cluster auf Kubernetes 1.12 aktualisieren. Durch das Entfernen verhindern Sie Konflikte mit der `metric-server`-Instanz, die während der Aktualisierung bereitgestellt wird.</td>
</tr>
<tr>
<td>Rollenbindungen für das Standardservicekonto (`default`) der `kube-system`-Instanz</td>
<td>Das Standardservicekonto (`default`) der `kube-system`-Instanz hat keinen Clusteradministratorzugriff (**cluster-admin**) mehr auf die Kubernetes API. Wenn Sie Features oder Add-ons wie [Helm](/docs/containers?topic=containers-helm#public_helm_install) bereitstellen, die Zugriff benötigen, um in Ihrem Cluster arbeiten zu können, richten Sie ein [Servicekonto ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/reference/access-authn-authz/service-accounts-admin/) ein. Wenn Sie mehr Zeit für die Erstellung und Konfiguration einzelner Servicekonten mit den entsprechenden Berechtigungen benötigen, können Sie der Rolle **cluster-admin** die folgende Clusterrollenbindung temporär zuordnen: `kubectl create clusterrolebinding kube-system:default --clusterrole=cluster-admin --serviceaccount=kube-system:default`</td>
</tr>
</tbody>
</table>

### Nach Master aktualisieren
{: #112_after}

In der folgenden Tabelle sind die Aktionen aufgeführt, die Sie ausführen müssen, nachdem Sie den Kubernetes-Master aktualisiert haben.
{: shortdesc}

<table summary="Kubernetes-Aktualisierungen für Version 1.12">
<caption>Vorzunehmende Änderungen nach der Aktualisierung des Masters auf Kubernetes 1.12</caption>
<thead>
<tr>
<th>Typ</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>APIs für Kubernetes</td>
<td>Die Kubernetes-API ersetzt veraltete APIs wie folgt:
<ul><li><strong>apps/v1</strong>: Die Kubernetes-API `apps/v1` ersetzt die APIs `apps/v1beta1` und `apps/v1alpha`. Die API `apps/v1` ersetzt außderm die API `extensions/v1beta1` für die Ressourcen `daemonset`, `deployment`, `replicaset` und `statefulset`. Das Kubernetes-Projekt wird nicht mehr verwendet und die Unterstützung für frühere APIs aus dem Kubernetes-API-Server `apiserver` und dem Kubernetes-Client `kubectl` wird ausgephast.</li>
<li><strong>networking.k8s.io/v1</strong>: Die API `networking.k8s.io/v1` ersetzt die API `extensions/v1beta1` für Netzrichtlinien-Ressourcen.</li>
<li><strong>policy/v1beta1</strong>: Die API `policy/v1beta1` ersetzt die API `extensions/v1beta1` für Ressourcen `podsecuritypolicy`.</li></ul>
<br><br>Aktualisieren Sie alle YAML-Felder `apiVersion` zur Verwendung der entsprechenden Kubernetes-API, bevor die veralteten APIs nicht mehr unterstützt werden. Überprüfen Sie außerdem die [Kubernetes-Dokumentation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) auf Änderungen im Zusammenhang mit `apps/v1` wie die folgenden.
<ul><li>Nach dem Erstellen einer Bereitstellung ist das Feld `.spec.selector` nicht veränderbar.</li>
<li>Das Feld `.spec.rollbackTo` ist veraltet. Verwenden Sie stattdessen den Befehl `kubectl rollout undo`.</li></ul></td>
</tr>
<tr>
<td>CoreDNS verfügbar als Cluster-DNS-Provider</td>
<td>Das Kubernetes-Projekt wird gerade umgestellt auf die Unterstützung von CoreDNS anstelle von Kubernetes-DNS (KubeDNS). In Version 1.12 ist das standardmäßige Cluster-DNS weiterhin KubeDNS, aber Sie können [auswählen, CoreDNS zu verwenden](/docs/containers?topic=containers-cluster_dns#dns_set).</td>
</tr>
<tr>
<td>`kubectl apply --force`</td>
<td>Wenn Sie jetzt eine Anwendenaktion (`kubectl apply --force`) für Ressourcen erzwingen, die nicht aktualisiert werden können, z. B. nicht veränderbare Felder in YAML-Dateien, werden die Ressourcen stattdessen erneut erstellt. Wenn Ihre Scripts das bisherige Verhalten erwarten, aktualisieren Sie die Scripts.</td>
</tr>
<tr>
<td>`kubectl get componentstatuses`</td>
<td>Der Befehl `kubectl get componentstatuses` meldet den Status einiger Kubernetes-Masterkomponenten nicht korrekt, weil diese Komponenten vom Kubernetes-API-Server aus nicht mehr zugänglich sind, da jetzt `localhost` und die unsicheren Ports (HTTP-Ports) inaktiviert sind. Seit der Einführung hoch verfügbarer Master (HA-Master) in Kubernetes Version 1.10 wird jeder Kubernetes-Master mit mehreren Instanzen von `apiserver`, `controller-manager`, `scheduler` und `etcd` eingerichtet. Prüfen Sie den Clusterstatus stattdessen über die [{{site.data.keyword.cloud_notm}}-Konsole ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cloud.ibm.com/kubernetes/landing) oder mit dem [Befehl](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_get) `ibmcloud ks cluster-get`.</td>
</tr>
<tr>
<td>`kubectl logs --interactive`</td>
<td>Das Flag `--interactive` wird für `kubectl logs` nicht länger unterstützt. Aktualisieren Sie jede Automatisierung mit diesem Flag.</td>
</tr>
<tr>
<td>`kubectl patch`</td>
<td>Wenn der Befehl `patch` nicht zu Änderungen führt (ein redundantes Patch), hat der Befehl nicht länger den Rückgabecode `1`. Wenn Ihre Scripts das bisherige Verhalten erwarten, aktualisieren Sie die Scripts.</td>
</tr>
<tr>
<td>`kubectl version -c`</td>
<td>Das Kurzform-Flag `-c` wird nicht länger unterstützt. Verwenden Sie stattdessen das vollständige Flag `--client`. Aktualisieren Sie jede Automatisierung mit diesem Flag.</td>
</tr>
<tr>
<td>`kubectl wait`</td>
<td>Wenn keine übereinstimmenden Selektoren gefunden werden, gibt der Befehl jetzt eine Fehlernachricht aus und wird mit einem Rückgabecode von `1` beendet. Wenn Ihre Scripts das bisherige Verhalten erwarten, aktualisieren Sie die Scripts.</td>
</tr>
<tr>
<td>cAdvisor-Port 'kubelet'</td>
<td>Die [Container Advisor-Webbenutzerschnittstelle (cAdvisor) ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/google/cadvisor), die von 'kubelet' durch das Starten des cAdvisor-Ports (`--cadvisor-port`) verwendet wurde, wird aus Kubernetes 1.12 entfernt. Wenn Sie cAdvisor weiterhin ausführen müssen, [stellen Sie cAdvisor als Dämongruppe ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/google/cadvisor/tree/master/deploy/kubernetes) bereit.<br><br>Geben Sie in der Dämongruppe den Bereich 'Ports' an, damit cAdvisor über `http://node-ip:4194` wie folgt erreicht werden kann. Die cAdvisor-Pods schlagen fehl, bis die Workerknoten auf 1.12 aktualisiert werden, da frühere Versionen von kubelet den Host-Port 4194 für cAdvisor verwenden.
<pre class="screen"><code>ports:
          - name: http
            containerPort: 8080
            hostPort: 4194
            protocol: TCP</code></pre></td>
</tr>
<tr>
<td>Kubernetes-Dashboard</td>
<td>Wenn Sie über `kubectl proxy` auf das Dashboard zugreifen, wird die Schaltfläche zum Überspringen (**SKIP**) von der Anmeldeseite entfernt. [Verwenden Sie stattdessen ein **Token** für die Anmeldung](/docs/containers?topic=containers-app#cli_dashboard).</td>
</tr>
<tr>
<td id="metrics-server">Kubernetes-Metrik-Server</td>
<td>Der Kubernetes-Metrik-Server ersetzt den Kubernetes-Heapster (veraltet seit Kubernetes-Version 1.8) als Cluster-Metrik-Provider. Wenn in Ihrem Cluster mehr als 30 Pods ausgeführt werden, [passen Sie die Konfiguration von `metrics-server` für eine bessere Leistung an](/docs/containers?topic=containers-kernel#metrics).
<p>Das Kubernetes-Dashboard funktioniert nicht mit `metrics-server`. Wenn Sie Metriken in einem Dashboard anzeigen möchten, wählen Sie eine der folgenden Optionen aus.</p>
<ul><li>[Konfigurieren Sie Grafana, um Metriken zu analysieren](/docs/services/cloud-monitoring/tutorials?topic=cloud-monitoring-container_service_metrics#container_service_metrics), indem Sie das Clusterüberwachungsdashboard verwenden.</li>
<li>Implementieren Sie [Heapster ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/kubernetes/heapster) in Ihrem Cluster.
<ol><li>Kopieren Sie die `heapster-rbac`-[YAML- ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/kubernetes/kubernetes/blob/release-1.12/cluster/addons/cluster-monitoring/heapster-rbac.yaml), `heapster-service`-[YAML- ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/kubernetes/kubernetes/blob/release-1.12/cluster/addons/cluster-monitoring/standalone/heapster-service.yaml) und `heapster-controller`-[YAML-Dateien ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/kubernetes/kubernetes/blob/release-1.12/cluster/addons/cluster-monitoring/standalone/heapster-controller.yaml).</li>
<li>Bearbeiten Sie die `heapster-controller`-YAML, indem Sie die folgenden Zeichenfolgen ersetzen.
<ul><li>Ersetzen Sie `{{ nanny_memory }}` durch `90Mi`.</li>
<li>Ersetzen Sie `{{ base_metrics_cpu }}` durch `80m`.</li>
<li>Ersetzen Sie `{{ metrics_cpu_per_node }}` durch `0.5m`.</li>
<li>Ersetzen Sie `{{ base_metrics_memory }}` durch `140Mi`.</li>
<li>Ersetzen Sie `{{ metrics_memory_per_node }}` durch `4Mi`.</li>
<li>Ersetzen Sie `{{ heapster_min_cluster_size }}` durch `16`.</li></ul></li>
<li>Wenden Sie die YAML-Dateien `heapster-rbac`, `heapster-service` und `heapster-controller` auf Ihren Cluster an, indem Sie den Befehl `kubectl apply -f` ausführen.</li></ol></li></ul></td>
</tr>
<tr>
<td>Kubernetes-API `rbac.authorization.k8s.io/v1`</td>
<td>Die Kubernetes-API `rbac.authorization.k8s.io/v1` (unterstützt seit Kubernetes 1.8) ersetzt die APIs `rbac.authorization.k8s.io/v1alpha1` und `rbac.authorization.k8s.io/v1beta1`. Sie können keine RBAC-Objekte wie Rollen oder Rollenbindungen mehr mit der nicht unterstützten API `v1alpha` erstellen. Vorhandene RBAC-Objekte werden zur API `v1` konvertiert.</td>
</tr>
</tbody>
</table>

<br />


## Archiv
{: #k8s_version_archive}

Hier finden Sie eine Übersicht über Kubernetes-Versionen, die in {{site.data.keyword.containerlong_notm}} nicht unterstützt werden.
{: shortdesc}

### Version 1.11 (nicht unterstützt)
{: #cs_v111}

Seit dem 20. Juli 2019 werden {{site.data.keyword.containerlong_notm}}-Cluster, die unter [Kubernetes Version 1.11](/docs/containers?topic=containers-changelog#changelog_archive) ausgeführt werden, nicht mehr unterstützt. Cluster der Version 1.11 können keine Sicherheitsupdates oder Unterstützung mehr erhalten, bis sie auf die nächste, aktuellste Version aktualisiert werden.
{: shortdesc}

[Überprüfen Sie die mögliche Auswirkung](/docs/containers?topic=containers-cs_versions#cs_versions) jeder einzelnen Aktualisierung einer Kubernetes-Version und [aktualisieren Sie Ihre Cluster](/docs/containers?topic=containers-update#update) dann sofort mindestens auf Version 1.12.

### Version 1.10 (nicht unterstützt)
{: #cs_v110}

Seit dem 16. Mai 2019 werden {{site.data.keyword.containerlong_notm}}-Cluster, die unter [Kubernetes Version 1.10](/docs/containers?topic=containers-changelog#changelog_archive) ausgeführt werden, nicht mehr unterstützt. Cluster der Version 1.10 können keine Sicherheitsupdates oder Unterstützung mehr erhalten, bis sie auf die nächste, aktuellste Version aktualisiert werden.
{: shortdesc}

[Überprüfen Sie die mögliche Auswirkung](/docs/containers?topic=containers-cs_versions#cs_versions) jeder einzelnen Aktualisierung einer Kubernetes-Version und [aktualisieren Sie Ihre Cluster](/docs/containers?topic=containers-update#update) dann sofort auf [Kubernetes 1.12](#cs_v112).

### Version 1.9 (nicht unterstützt)
{: #cs_v19}

Seit dem 27. Dezember werden {{site.data.keyword.containerlong_notm}}-Cluster, die auf [Kubernetes Version 1.9](/docs/containers?topic=containers-changelog#changelog_archive) ausgeführt werden, nicht mehr unterstützt. Cluster der Version 1.9 können keine Sicherheitsupdates oder Unterstützung mehr erhalten, bis sie auf die nächste, aktuellste Version aktualisiert werden.
{: shortdesc}

Wenn die Apps weiterhin in {{site.data.keyword.containerlong_notm}} ausgeführt werden sollen, [erstellen Sie einen neuen Cluster](/docs/containers?topic=containers-clusters#clusters) und [stellen Sie die Apps](/docs/containers?topic=containers-app#app) im neuen Cluster bereit.

### Version 1.8 (nicht unterstützt)
{: #cs_v18}

Seit dem 22. September 2018 werden {{site.data.keyword.containerlong_notm}}-Cluster, die auf [Kubernetes Version 1.8](/docs/containers?topic=containers-changelog#changelog_archive) ausgeführt werden, nicht mehr unterstützt. Cluster der Version 1.8 können keine Sicherheitsupdates oder Unterstützung mehr erhalten.
{: shortdesc}

Wenn die Apps weiterhin in {{site.data.keyword.containerlong_notm}} ausgeführt werden sollen, [erstellen Sie einen neuen Cluster](/docs/containers?topic=containers-clusters#clusters) und [stellen Sie die Apps](/docs/containers?topic=containers-app#app) im neuen Cluster bereit.

### Version 1.7 (nicht unterstützt)
{: #cs_v17}

Seit dem 21. Juni 2018 werden {{site.data.keyword.containerlong_notm}}-Cluster, die unter [Kubernetes Version 1.7](/docs/containers?topic=containers-changelog#changelog_archive) ausgeführt werden, nicht mehr unterstützt. Cluster der Version 1.7 können keine Sicherheitsupdates oder Unterstützung mehr erhalten.
{: shortdesc}

Wenn die Apps weiterhin in {{site.data.keyword.containerlong_notm}} ausgeführt werden sollen, [erstellen Sie einen neuen Cluster](/docs/containers?topic=containers-clusters#clusters) und [stellen Sie die Apps](/docs/containers?topic=containers-app#app) im neuen Cluster bereit.

### Version 1.5 (nicht unterstützt)
{: #cs_v1-5}

Seit dem 4. April 2018 werden {{site.data.keyword.containerlong_notm}}-Cluster, die auf [Kubernetes Version 1.5](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.5.md) ausgeführt werden, nicht mehr unterstützt. Cluster der Version 1.5 können keine Sicherheitsupdates oder Unterstützung mehr erhalten.
{: shortdesc}

Wenn die Apps weiterhin in {{site.data.keyword.containerlong_notm}} ausgeführt werden sollen, [erstellen Sie einen neuen Cluster](/docs/containers?topic=containers-clusters#clusters) und [stellen Sie die Apps](/docs/containers?topic=containers-app#app) im neuen Cluster bereit.
