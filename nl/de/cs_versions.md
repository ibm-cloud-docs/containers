---

copyright:
  years: 2014, 2019
lastupdated: "2019-06-11"

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
*   Aktuelle: 1.14.2 
*   Standard: 1.13.6
*   Sonstige: 1.12.9

**Veraltete und nicht unterstützte Kubernetes-Versionen:**
*   Veraltet: 1.11
*   Nicht unterstützt: 1.5, 1.7, 1.8, 1.9, 1.10 

</br>

**Veraltete Versionen:** Wenn Cluster unter einer veralteten Kubernetes-Version ausgeführt werden, haben Sie mindestens 30 Tage Zeit, um eine unterstützte Kubernetes-Version zu überprüfen und auf diese neuere Version zu aktualisieren, bevor die veraltete Version nicht mehr unterstützt wird. Während des Zeitraums der Einstellung der Unterstützung ist Ihr Cluster noch funktionstüchtig, muss jedoch möglicherweise auf ein unterstütztes Release aktualisiert werden, um Sicherheitslücken zu schließen. Sie können z. B. Workerknoten hinzufügen und neu laden, aber keine neuen Cluster erstellen, die die veraltete Version verwenden, wenn die Unterstützung dieser Version in weniger als 30 Tagen eingestellt wird.

**Nicht unterstützte Versionen:** Wenn Ihre Cluster eine Kubernetes-Version ausführen, die nicht unterstützt wird, prüfen Sie die folgenden potenziellen Auswirkungen von Aktualisierungen und [aktualisieren Sie dann den Cluster](/docs/containers?topic=containers-update#update) sofort, damit Sie weiterhin wichtige Sicherheitsupdates und Support erhalten. Nicht unterstützte Cluster können keine Workerknoten hinzufügen oder vorhandene Workerknoten erneut laden. Sie können ermitteln, ob Ihr Cluster **nicht unterstützt wird**, indem Sie das Statusfeld (**State**) in der Ausgabe des Befehls `ibmcloud ks clusters` oder in der [{{site.data.keyword.containerlong_notm}}-Konsole ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cloud.ibm.com/kubernetes/clusters) prüfen.

Wenn Sie warten, bis Ihr Cluster gegenüber der ältesten unterstützten Version drei oder mehr Nebenversionen zurückliegt, können Sie den Cluster nicht aktualisieren. Erstellen Sie stattdessen [einen neuen Cluster](/docs/containers?topic=containers-clusters#clusters), [stellen Sie Ihre Apps für den neuen Cluster bereit](/docs/containers?topic=containers-app#app) und [löschen](/docs/containers?topic=containers-remove) Sie den nicht unterstützten Cluster. <br><br>Zur Vermeidung dieses Problems aktualisieren Sie den veralteten Cluster zunächst auf eine unterstützte Version, die weniger als drei Nebenversionen hinter der aktuellen Version zurückliegt, wie zum Beispiel die Versionen 1.11 bis 1.12, und aktualisieren Sie anschließend auf die neueste Version, 1.14. Wenn die Workerknoten eine Version ausführen, die drei oder mehr Versionen hinter dem Master zurückliegt, schlagen Ihre Pods möglicherweise mit einem Status `MatchNodeSelector`, `CrashLoopBackOff` oder `ContainerCreating` fehl, bis Sie die Workerknoten auf dieselbe Version wie den Master aktualisieren. Nachdem Sie den Cluster von einer veralteten Version auf eine unterstützte Version aktualisiert haben, kann Ihr Cluster den normalen Betrieb wieder aufnehmen und weiterhin Support erhalten.
{: important}

</br>

Führen Sie den folgenden Befehl aus, um die Serverversion eines Clusters zu überprüfen.
```
kubectl version  --short | grep -i server
```
{: pre}

Beispielausgabe:
```
Serverversion: V1.13.6+IKS
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
|Patch|x.x.4_1510|IBM und Sie|Kubernetes-Patches und andere Aktualisierungen von {{site.data.keyword.Bluemix_notm}} Provider-Komponenten, z. B. Sicherheits- und Betriebssystempatches. IBM aktualisiert die Master automatisch, aber Sie wenden Patches auf Workerknoten an. Informationen zu weiteren Patches finden Sie im folgenden Abschnitt.|
{: caption="Auswirkungen auf Kubernetes-Aktualisierungen" caption-side="top"}

Sobald Aktualisierungen verfügbar sind, werden Sie benachrichtigt, wenn Sie Informationen zu den Workerknoten anzeigen, z. B. mit den Befehlen `ibmcloud ks workers --cluster <cluster>` oder `ibmcloud ks worker-get --cluster <cluster> --worker <worker>`.
-  **Aktualisierungen von Haupt- und Nebenversionen (1.x)**: Zuerst [aktualisieren Sie Ihren Masterknoten](/docs/containers?topic=containers-update#master) und anschließend [die Workerknoten](/docs/containers?topic=containers-update#worker_node). Workerknoten können keine Haupt- oder Nebenversion von Kubernetes ausführen, die höher als die des Masters ist.
   - Sie können einen Kubernetes-Master nicht über mehr als drei oder mehr Nebenversionen hinweg aktualisieren. Wenn die aktuelle Masterversion beispielsweise 1.11 ist und Sie eine Aktualisierung auf 1.14 durchführen möchten, müssen Sie zunächst auf Version 1.12 aktualisieren.
   - Wenn Sie eine `kubectl`-CLI-Version verwenden, die nicht wenigstens mit der Version `major.minor` Ihrer Cluster übereinstimmt, kann dies zu unerwarteten Ergebnissen führen. Stellen Sie sicher, dass Ihr Kubernetes-Cluster und die [CLI-Versionen](/docs/containers?topic=containers-cs_cli_install#kubectl) immer auf dem neuesten Stand sind.
-  **Patchaktualisierungen (x.x.4_1510)**: Änderungen für Patches werden im [Versionsänderungsprotokoll](/docs/containers?topic=containers-changelog) dokumentiert. Master-Patches werden automatisch angewendet, während Aktualisierungen durch Workerknotenpatches von Ihnen eingeleitet werden. Workerknoten können außerdem Patchversionen ausführen, die höher als die des Masters sind. Sind Aktualisierungen verfügbar, werden Sie benachrichtigt, wenn Sie Informationen zum Masterknoten und den Workerknoten in der {{site.data.keyword.Bluemix_notm}}-Konsole oder -CLI beispielsweise mit den folgenden Befehlen anzeigen: `ibmcloud ks clusters`, `cluster-get`, `workers` oder `worker-get`.
   - **Patches für Workerknoten**: Überprüfen Sie einmal im Monat, ob eine Aktualisierung verfügbar ist, und verwenden Sie den [Befehl](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_update) `ibmcloud ks worker-update` oder den [Befehl](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_reload) `ibmcloud ks worker-reload`, um diese Sicherheits- und Betriebssystempatches anzuwenden. Während einer Aktualisierung oder eines erneuten Ladens wird von Ihrer Workerknotenmaschine ein neues Image erstellt und dabei werden Daten gelöscht, die nicht [außerhalb des Workerknotens gespeichert sind](/docs/containers?topic=containers-storage_planning#persistent_storage_overview).
   - **Master-Patches**: Master-Patches werden automatisch über mehrere Tage hinweg angewendet, sodass eine Master-Patch-Version möglicherweise als verfügbar angezeigt wird, bevor sie auf den Master angewendet wird. Die Aktualisierungsautomatisierung überspringt auch Cluster, die sich in einem nicht einwandfreien Zustand befinden oder in denen derzeit Operationen ausgeführt werden. Es kann vorkommen, dass IBM gelegentlich die automatischen Aktualisierungen für ein bestimmtes Master-Fixpack inaktiviert (wie im Änderungsprotokoll vermerkt), zum Beispiel ein Patch, das nur benötigt wird, wenn ein Master von einer Nebenversion auf eine andere Version aktualisiert wird. In allen diesen Fällen können Sie den [Befehl](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_update) `ibmcloud ks cluster-update` sicher selbst verwenden, ohne auf die Anwendung der automatischen Aktualisierung zu warten.

</br>

{: #prep-up}
Diese Informationen fassen die Aktualisierungen zusammen, die sich voraussichtlich auf die bereitgestellten Apps auswirken, wenn Sie einen Cluster von einer vorherigen Version auf eine neue Version aktualisieren.
-  Version 1.14 [Vorbereitungsaktionen](#cs_v114).
-  Version 1.13 [Vorbereitungsaktionen](#cs_v113).
-  Version 1.12 [Vorbereitungsaktionen](#cs_v112).
-  **Veraltet**: Version 1.11 [Vorbereitungsaktionen](#cs_v111).
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
  <td>März 2020 `†`</td>
</tr>
<tr>
  <td><img src="images/checkmark-filled.png" align="left" width="32" style="width:32px;" alt="Diese Version wird unterstützt."/></td>
  <td>[1.13](#cs_v113)</td>
  <td>05. Februar 2019</td>
  <td>Dezember 2019 `†`</td>
</tr>
<tr>
  <td><img src="images/checkmark-filled.png" align="left" width="32" style="width:32px;" alt="Diese Version wird unterstützt."/></td>
  <td>[1.12](#cs_v112)</td>
  <td>07. November 2018</td>
  <td>September 2019 `†`</td>
</tr>
<tr>
  <td><img src="images/warning-filled.png" align="left" width="32" style="width:32px;" alt="Diese Version ist veraltet."/></td>
  <td>[1.11](#cs_v111)</td>
  <td>14. August 2018</td>
  <td>27. Juni 2019 `†`</td>
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
<td>In der CRI (Container Runtime Interface) wurde die Pod-Protokollverzeichnisstruktur von `/var/log/pods/<uid>` in `/var/log/pods/<uid_des_namensbereichsnamens>` geändert. Wenn Ihre Apps Kubernetes und die CRI umgehen, um auf Pod-Protokolle direkt auf den Workerknoten zuzugreifen, aktualisieren Sie sie, sodass sie beide Verzeichnisstrukturen verarbeiten können. Der Zugriff auf Pod-Protokolle über Kubernetes, z. B. mit dem Befehl `kubectl logs`, ist von dieser Änderung nicht betroffen. </td>
</tr>
<tr>
<td>Statusprüfungen folgen Weiterleitungen nicht mehr</td>
<td>Aktivitäts- und Bereitschaftsprüfungen im Rahmen der Statusprüfung, die `HTTPGetAction` verwenden, werden nicht mehr an Hostnamen weitergeleitet, die von der ursprünglichen Prüfungsanforderung abweichen. Stattdessen geben diese nicht lokalen Umleitungen eine `Success`-Antwort zurück und ein Ereignis mit der Ursache `ProbeWarning` wird generiert, um anzuzeigen, dass die Weiterleitung ignoriert wurde. Wenn Sie Statusprüfungen für verschiedene Hostnamenendpunkte bisher auf der Basis der Weiterleitungen ausgeführt haben, müssen Sie die Statusprüfungslogik außerhalb von `kubelet` ausführen. Beispiel: Sie können den externen Endpunkt als Proxy verwenden, anstatt die Prüfungsanforderung weiterzuleiten.</td>
</tr>
<tr>
<td>Nicht unterstützt: KubeDNS-Cluster-DNS-Provider</td>
<td>CoreDNS ist jetzt der einzige unterstützte Cluster-DNS-Provider für Cluster, die Kubernetes Version 1.14 und höher ausführen. Wenn Sie einen vorhandenen Cluster, der KubeDNS als Cluster-DNS-Provider verwendet, auf Version 1.14 aktualisieren, wird KubeDNS während der Aktualisierung automatisch auf CoreDNS aktualisiert. Bevor Sie den Cluster aktualisieren, sollten Sie zunächst [CoreDNS als Cluster-DNS-Provider einrichten](/docs/containers?topic=containers-cluster_dns#set_coredns) und testen.<br><br>CoreDNS unterstützt die [Cluster-DNS-Spezifikation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/kubernetes/dns/blob/master/docs/specification.md#25---records-for-external-name-services) zur Eingabe eines Domänennamens in das Kubernetes Service-Feld `ExternalName`. Der vorherige Cluster-DNS-Provider KubeDNS folgt der Cluster-DNS-Spezifikation nicht und zulässt an sich IP-Adressen für das Feld `ExternalName` zu. Wenn Kubernetes Services vorhanden sind, die IP-Adressen anstelle von DNS verwenden, müssen Sie das Feld `ExternalName` zur Fortsetzung der Funktionalität in DNS aktualisieren.</td>
</tr>
<tr>
<td>Nicht unterstützt: Kubernetes-Alpha-Funktion `Initializers`</td>
<td>Die Kubernetes-Alpha-Funktion `Initializers`, die API-Version `admissionregistration.k8s.io/v1alpha1`, das `Initializers`-Zugangscontroller-Plug-in und die Verwendung des API-Felds `metadata.initializers` wurden entfernt. Wenn Sie `Initializers` verwenden, wechseln Sie zu [Kubernetes-Zugangs-Webhooks ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/reference/access-authn-authz/extensible-admission-controllers/) und löschen Sie alle vorhandenen `InitializerConfiguration`-API-Objekte, bevor Sie den Cluster aktualisieren. </td>
</tr>
<tr>
<td>Nicht unterstützt: Knoten-Alpha-Taints</td>
<td>Die Verwendung der Taints `node.alpha.kubernetes.io/notReady` und `node.alpha.kubernetes.io/unreachable` wird nicht mehr unterstützt. Wenn Sie diese Taints verwenden, aktualisieren Sie Apps, sodass stattdessen die Taints `node.kubernetes.io/not-ready` und `node.kubernetes.io/unreachable` verwendet werden. </td>
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
<td>CoreDNS ist jetzt der Standard-Cluster-DNS-Provider für neue Cluster in Kubernetes 1.13 und höher. Wenn Sie einen vorhandenen Cluster, der KubeDNS als Cluster-DNS-Provider verwendet, auf 1.13 aktualisieren, wird KubeDNS weiterhin als Cluster-DNS-Provider verwendet. Sie können stattdessen jedoch auch [CoreDNS verwenden](/docs/containers?topic=containers-cluster_dns#dns_set).
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
<td>Der Befehl `kubectl get componentstatuses` meldet den Status einiger Kubernetes-Masterkomponenten nicht korrekt, weil diese Komponenten vom Kubernetes-API-Server aus nicht mehr zugänglich sind, da jetzt `localhost` und die unsicheren Ports (HTTP-Ports) inaktiviert sind. Seit der Einführung hoch verfügbarer Master (HA-Master) in Kubernetes Version 1.10 wird jeder Kubernetes-Master mit mehreren Instanzen von `apiserver`, `controller-manager`, `scheduler` und `etcd` eingerichtet. Prüfen Sie den Clusterstatus stattdessen über die [{{site.data.keyword.Bluemix_notm}}-Konsole ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cloud.ibm.com/kubernetes/landing) oder mit dem [Befehl](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_get) `ibmcloud ks cluster-get`.</td>
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
<td>Der Befehl `kubectl get componentstatuses` meldet den Status einiger Kubernetes-Masterkomponenten nicht korrekt, weil diese Komponenten vom Kubernetes-API-Server aus nicht mehr zugänglich sind, da jetzt `localhost` und die unsicheren Ports (HTTP-Ports) inaktiviert sind. Seit der Einführung hoch verfügbarer Master (HA-Master) in Kubernetes Version 1.10 wird jeder Kubernetes-Master mit mehreren Instanzen von `apiserver`, `controller-manager`, `scheduler` und `etcd` eingerichtet. Prüfen Sie den Clusterstatus stattdessen über die [{{site.data.keyword.Bluemix_notm}}-Konsole ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cloud.ibm.com/kubernetes/landing) oder mit dem [Befehl](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_get) `ibmcloud ks cluster-get`.</td>
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


## Veraltet: Version 1.11
{: #cs_v111}

<p><img src="images/certified_kubernetes_1x11.png" style="padding-right: 10px;" align="left" alt="Dieses Flag zeigt die Kubernetes Version 1.11-Zertifizierung für IBM Cloud Container Service an."/> {{site.data.keyword.containerlong_notm}} ist ein zertifiziertes Kubernetes-Produkt für Version 1.11 unter dem CNCF Kubernetes Software Conformance Certification Program. _Kubernetes® ist eine eingetragene Marke von The Linux Foundation in den USA und anderen Ländern und wird entsprechend einer Lizenz von The Linux Foundation verwendet._</p>

Überprüfen Sie Änderungen, die Sie möglicherweise bei einer Aktualisierung von der vorherigen Version auf die Kubernetes-Version 1.11 vornehmen müssen.
{: shortdesc}

Kubernetes Version 1.11 ist veraltet und wird (voraussichtlich) ab dem 27. Juni 2019 nicht mehr unterstützt. [Überprüfen Sie die mögliche Auswirkung](/docs/containers?topic=containers-cs_versions#cs_versions) jeder einzelnen Aktualisierung einer Kubernetes-Version und [aktualisieren Sie Ihre Cluster](/docs/containers?topic=containers-update#update) dann sofort mindestens auf Version 1.12.
{: deprecated}

Bevor Sie einen Cluster erfolgreich von Kubernetes Version 1.9 oder einer früheren Version auf Version 1.11 aktualisieren können, müssen Sie zunächst die im Abschnitt zu den [Vorbereitungen zur Aktualisierung auf Calico Version 3](#111_calicov3) aufgeführten Schritte durchführen.
{: important}

### Vor Master aktualisieren
{: #111_before}

In der folgenden Tabelle sind die Aktionen aufgeführt, die Sie ausführen müssen, bevor Sie den Kubernetes-Master aktualisieren.
{: shortdesc}

<table summary="Kubernetes-Aktualisierungen für Version 1.11">
<caption>Vorzunehmende Änderungen vor der Aktualisierung des Masters auf Kubernetes 1.11</caption>
<thead>
<tr>
<th>Typ</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>Konfiguration der Hochverfügbarkeit des Cluster-Masters</td>
<td>Die Cluster-Master-Konfiguration wurde aktualisiert, um die Hochverfügbarkeit zu erhöhen. Cluster haben jetzt drei Kubernetes-Masterreplikate, die für jeden Master konfiguriert werden, der auf einem separaten physischen Host bereitgestellt wird. Und wenn sich Ihr Cluster in einer Zone mit mehreren Zonen befindet, werden die Master über Zonen verteilt.<br><br>Informationen zu den Aktionen, die Sie ausführen müssen, finden Sie unter [Aktualisierung auf hoch verfügbare Cluster-Master](#ha-masters). Diese Vorbereitungsaktionen finden Anwendung:<ul>
<li>Wenn Sie über eine Firewall oder über angepasste Calico-Netzrichtlinien verfügen.</li>
<li>Wenn Sie die Host-Ports `2040` oder `2041` auf Ihren Workerknoten verwenden.</li>
<li>Wenn Sie die IP-Adresse des Cluster-Masters für den clusterinternen Zugriff auf den Master verwendet haben.</li>
<li>Wenn eine Automatisierung vorhanden ist, die die Calico-API oder -CLI (`calicoctl`) aufruft, z. B. um Calico-Richtlinien zu erstellen.</li>
<li>Wenn Sie Kubernetes- oder Calico-Netzrichtlinien zum Steuern des Pod-Egress-Zugriffs auf den Master verwenden.</li></ul></td>
</tr>
<tr>
<td>`containerd` - neue Kubernetes-Containerlaufzeit</td>
<td><p class="important">`containerd` ersetzt Docker als neue Containerlaufzeit für Kubernetes. Informationen zu den Aktionen, die Sie ausführen müssen, finden Sie unter [Aktualisieren auf `containerd` als Containerlaufzeit](#containerd).</p></td>
</tr>
<tr>
<td>Verschlüsseln von Daten in 'etcd'</td>
<td>Bisher wurden 'etcd'-Daten in der NFS-Dateispeicherinstanz eines Masters gespeichert, in der ruhende Daten verschlüsselt wurden. Jetzt werden 'etcd'-Daten auf der lokalen Platte des Masters gespeichert und in {{site.data.keyword.cos_full_notm}} gesichert. Daten werden während des Transits an {{site.data.keyword.cos_full_notm}} verschlüsselt und wenn sie ruhen. Die 'etcd'-Daten auf der lokalen Platte des Masters sind jedoch nicht verschlüsselt. Wenn die lokalen 'etcd'-Daten Ihres Masters verschlüsselt werden sollen, [aktivieren Sie {{site.data.keyword.keymanagementservicelong_notm}} in Ihrem Cluster](/docs/containers?topic=containers-encryption#keyprotect).</td>
</tr>
<tr>
<td>'mountPropagation' für Kubernetes-Containerdatenträger</td>
<td>Der Standardwert für das Feld [`mountPropagation` ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/concepts/storage/volumes/#mount-propagation) für einen Container `VolumeMount` wurde von `HostToContainer` in `None` geändert. Diese Änderung stellt das Verhalten von Kubernetes Version 1.9 und früher wieder her. Wenn Ihre Podspezifikationen darauf basieren, dass `HostToContainer` als Standardwert verwendet wird, ändern Sie sie entsprechend.</td>
</tr>
<tr>
<td>JSON-Deserializer des Kubernetes-API-Servers</td>
<td>Bei dem JSON-Deserializer des Kubernetes-API-Servers muss jetzt die Groß-/Kleinschreibung beachtet werden. Diese Änderung stellt das Verhalten von Kubernetes Version 1.7 und früher wieder her. Wenn Ihre JSON-Ressourcendefinitionen nicht die richtige Groß-/Kleinschreibweise verwenden, aktualisieren Sie sie. <br><br>Nur direkte Anforderungen des Kubernetes-API-Servers sind betroffen. Die Befehlszeilenschnittstelle `kubectl` setzte die Groß-/Kleinschreibung in Kubernetes ab Version 1.7 durch. Wenn Sie Ihre Ressourcen strikt mit `kubectl` verwalten, sind Sie nicht betroffen.</td>
</tr>
</tbody>
</table>

### Nach Master aktualisieren
{: #111_after}

In der folgenden Tabelle sind die Aktionen aufgeführt, die Sie ausführen müssen, nachdem Sie den Kubernetes-Master aktualisiert haben.
{: shortdesc}

<table summary="Kubernetes-Aktualisierungen für Version 1.11">
<caption>Vorzunehmende Änderungen nach der Aktualisierung des Masters auf Kubernetes 1.11</caption>
<thead>
<tr>
<th>Typ</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>Konfiguration der Clusterprotokollierung</td>
<td>Das Cluster-Add-on `fluentd` wird automatisch mit Version 1.11 aktualisiert, auch wenn `logging-autoupdate` inaktiviert ist.<br><br>
Das Containerprotokollverzeichnis wurde von `/var/lib/docker/` in `/var/log/pods/` geändert. Wenn Sie eine eigene Lösung für die Protokollierung verwenden, die das zuvor angegebene Verzeichnis überwacht, ändern Sie es entsprechend.</td>
</tr>
<tr>
<td>Unterstützung für {{site.data.keyword.Bluemix_notm}} Identity and Access Management (IAM)</td>
<td>Cluster, die Kubernetes Version 1.11 oder höher ausführen, unterstützen IAM-[Zugriffsgruppen](/docs/iam?topic=iam-groups#groups) und -[Service-IDs](/docs/iam?topic=iam-serviceids#serviceids). Sie können diese Funktionen nun verwenden, um den [Zugriff auf Ihre Cluster zu autorisieren](/docs/containers?topic=containers-users#users).</td>
</tr>
<tr>
<td>Aktualisierung der Kubernetes-Konfiguration</td>
<td>Die OpenID Connect-Konfiguration für den Kubernetes-API-Server des Clusters wurde zur Unterstützung von {{site.data.keyword.Bluemix_notm}} Identity and Access Management-Zugriffsgruppen aktualisiert. Folglich müssen Sie die Kubernetes-Konfiguration Ihres Clusters nach der Masteraktualisierung auf Kubernetes Version 1.11 aktualisieren, indem Sie folgenden Befehl ausführen: `ibmcloud ks cluster-config --cluster <clustername_oder_-id>`. Mit diesem Befehl wird die Konfiguration auf die Rollenbindungen im Namensbereich `default` angewendet.<br><br>Wenn Sie die Konfiguration nicht aktualisieren, schlagen die Clusteraktionen mit der folgenden Fehlernachricht fehl: `You must be logged in to the server (Unauthorized).`</td>
</tr>
<tr>
<td>Kubernetes-Dashboard</td>
<td>Wenn Sie über `kubectl proxy` auf das Dashboard zugreifen, wird die Schaltfläche zum Überspringen (**SKIP**) von der Anmeldeseite entfernt. [Verwenden Sie stattdessen ein **Token** für die Anmeldung](/docs/containers?topic=containers-app#cli_dashboard).</td>
</tr>
<tr>
<td>CLI `kubectl`</td>
<td>Für die CLI `kubectl` für Kubernetes Version 1.11 sind die APIs `apps/v1` erforderlich. Version 1.11 der `kubectl`-CLI funktioniert daher nicht für Cluster, auf denen Kubernetes Version 1.8 oder früher ausgeführt wird. Verwenden Sie die Version der `kubectl`-CLI, die mit der Version des Kubernetes-API-Servers Ihres Clusters übereinstimmt.</td>
</tr>
<tr>
<td>`kubectl auth can-i`</td>
<td>Wenn ein Benutzer nicht berechtigt ist, schlägt der Befehl `kubectl auth` jetzt mit `exit code 1` fehl. Wenn Ihre Scripts das bisherige Verhalten erwarten, aktualisieren Sie die Scripts.</td>
</tr>
<tr>
<td>`kubectl delete`</td>
<td>Beim Löschen von Ressourcen unter Verwendung von Auswahlkriterien (wie z. B. Bezeichnungen), ignoriert der Befehl `kubectl delete` standardmäßig Fehler des Typs `not found`. Wenn Ihre Scripts das bisherige Verhalten erwarten, aktualisieren Sie die Scripts.</td>
</tr>
<tr>
<td>Kubernetes-Feature `sysctls`</td>
<td>Die Annotation `security.alpha.kubernetes.io/sysctls` wird jetzt ignoriert. Stattdessen wurden bei Kubernetes Felder zu den Objekten `PodSecurityPolicy` und `Pod` hinzugefügt, um `sysctls` anzugeben und zu steuern. Weitere Informationen finden Sie im Abschnitt zur [Verwendung von sysctls in Kubernetes ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tasks/administer-cluster/sysctl-cluster/). <br><br>Nachdem Sie den Cluster-Master und die Worker aktualisiert haben, aktualisieren Sie Ihre Objekte `PodSecurityPolicy` und `Pod`, um die neuen `sysctls`-Felder zu verwenden.</td>
</tr>
</tbody>
</table>

### Aktualisierung auf hoch verfügbare Cluster-Master in Kubernetes 1.11
{: #ha-masters}

Für Cluster mit Kubernetes-Version 1.10.8_1530, 1.11.3_1531 oder höher wird die Konfiguration des Cluster-Masters aktualisiert, um die Hochverfügbarkeit zu erhöhen. Cluster haben jetzt drei Kubernetes-Masterreplikate, die für jeden Master konfiguriert werden, der auf einem separaten physischen Host bereitgestellt wird. Und wenn sich Ihr Cluster in einer Zone mit mehreren Zonen befindet, werden die Master über Zonen verteilt.
{: shortdesc}

Sie können prüfen, ob Ihr Cluster eine Masterkonfiguration mit hoher Verfügbarkeit (HA) hat, indem Sie die Master-URL des Clusters in der Konsole prüfen oder den Befehl `ibmcloud ks cluster-get --cluster <clustername_oder_-id>` ausführen. Wenn die Master-URL einen Hostnamen wie ` https://c2.us-south.containers.cloud.ibm.com:xxxxx` aufweist und keine IP-Adresse wie ` https://169.xx.xx.xx:xxxxx` enthält, dann hat der Cluster eine HA-Masterkonfiguration. Sie erhalten möglicherweise eine HA-Masterkonfiguration durch eine automatische Patchaktualisierung des Masters oder durch manuelles Anwenden einer Aktualisierung. In beiden Fällen müssen Sie noch die folgenden Elemente prüfen, um sicherzustellen, dass Ihr Clusternetz so eingerichtet ist, dass es die Konfiguration in vollem Umfang nutzt.

* Wenn Sie über eine Firewall oder über angepasste Calico-Netzrichtlinien verfügen.
* Wenn Sie die Host-Ports `2040` oder `2041` auf Ihren Workerknoten verwenden.
* Wenn Sie die IP-Adresse des Cluster-Masters für den clusterinternen Zugriff auf den Master verwendet haben.
* Wenn eine Automatisierung vorhanden ist, die die Calico-API oder -CLI (`calicoctl`) aufruft, z. B. um Calico-Richtlinien zu erstellen.
* Wenn Sie Kubernetes- oder Calico-Netzrichtlinien zum Steuern des Pod-Egress-Zugriffs auf den Master verwenden.

<br>
**Aktualisieren Ihrer Firewall oder Ihrer angepassten Netzrichtlinien des Calico-Hosts für Hochverfügbarkeits-Master**:</br>
{: #ha-firewall}
Wenn Sie eine Firewall oder angepasste Calico-Host-Netzrichtlinien verwenden, um den ausgehenden Netzverkehr (Egress) von Ihren Workerknoten zu steuern, lassen Sie ausgehenden Datenverkehr zu den Ports und IP-Adressen für alle Zonen in der Region zu, in der sich Ihr Cluster befindet. Siehe [Zugriff des Clusters auf Infrastrukturressourcen und andere Services ermöglichen](/docs/containers?topic=containers-firewall#firewall_outbound).

<br>
**Reservieren der Host-Ports `2040` und `2041` für Ihre Workerknoten**:</br>
{: #ha-ports}
Um Zugriff auf den Cluster-Master in einer Hochverfügbarkeitskonfiguration zuzulassen, müssen die Host-Ports `2040` und `2041` auf allen Workerknoten verfügbar bleiben.
* Aktualisieren Sie alle Pods, für die `hostPort` auf `2040` oder auf `2041` gesetzt ist, um andere Ports zu verwenden.
* Aktualisieren Sie alle Pods, für die `hostNetwork` auf `true` gesetzt ist und die am Port `2040` oder `2041` empfangsbereit sind, sodass sie andere Ports verwenden.

Wenn Sie prüfen möchten, ob Ihre Pods derzeit den Port `2040` oder `2041` verwenden, wählen Sie Ihren Cluster als Ziel aus und setzen Sie den folgenden Befehl ab.

```
kubectl get pods --all-namespaces -o yaml | grep -B 3 "hostPort: 204[0,1]"
```
{: pre}

Wenn Sie bereits über eine HA-Masterkonfiguration verfügen, werden Ihnen die Ergebnisse für `ibm-master-proxy-*` im Namensbereich `kube-system` angezeigt, wie im folgenden Beispiel zu sehen. Wenn andere Pods zurückgegeben werden, aktualisieren Sie deren Ports.

```
name: ibm-master-proxy-static
ports:
- containerPort: 2040
  hostPort: 2040
  name: apiserver
  protocol: TCP
- containerPort: 2041
  hostPort: 2041
...
```
{: screen}


<br>
**Verwenden der `kubernetes`-Service-Cluster-IP oder -Domäne für den clusterinternen Zugriff auf den Master**:</br>
{: #ha-incluster}
Wählen Sie eine der folgenden Möglichkeiten aus, um von innerhalb des Clusters auf den Cluster-Master in einer Hochverfügbarkeitskonfiguration zuzugreifen:
* Die `kubernetes`-Service-Cluster-IP-Adresse, die standardmäßig `https://172.21.0.1` lautet.
* Der `kubernetes`-Servicedomänenname, der standardmäßig `https://kubernetes.default.svc.cluster.local` lautet.

Wenn Sie die Cluster-Master-IP-Adresse bereits verwendet haben, funktioniert diese Methode weiterhin. Für eine höhere Verfügbarkeit können Sie diese Einstellung jedoch aktualisieren und die `kubernetes`-Service-Cluster-IP-Adresse oder den entsprechenden Domänennamen verwenden.

<br>
**Konfigurieren von Calico für clusterexternen Zugriff auf den Master mit Hochverfügbarkeitskonfiguration**:</br>
{: #ha-outofcluster}
Die Daten, die in der Konfigurationszuordnung `calico-config` im Namensbereich `kube-system` gespeichert sind, werden geändert, um die Hochverfügbarkeitskonfiguration des Masters zu unterstützen. Insbesondere der Wert `etcd_endpoints` unterstützt jetzt nur clusterinternen Zugriff. Sie können diesen Wert nicht mehr verwenden, um die Calico-CLI für den Zugriff von außerhalb des Clusters zu konfigurieren.

Verwenden Sie stattdessen die Daten, die in der Konfigurationszuordnung `cluster-info` im Namensbereich `kube-system` gespeichert sind. Verwenden Sie insbesondere die Werte `etcd_host` und `etcd_port`, um den Endpunkt für die [Calico-CLI](/docs/containers?topic=containers-network_policies#cli_install) für den clusterexternen Zugriff auf den Master mit Hochverfügbarkeitskonfiguration zu konfigurieren.

<br>
**Aktualisieren von Kubernetes- oder Calico-Netzrichtlinien**:</br>
{: #ha-networkpolicies}
Sie müssen zusätzliche Aktionen ausführen, wenn Sie [Kubernetes- oder Calico-Netzrichtlinien](/docs/containers?topic=containers-network_policies#network_policies) zum Steuern des Pod-Egress-Zugriffs auf den Cluster-Master einsetzen möchten und momentan Folgendes verwenden:
*  Die Kubernetes Service-Cluster-IP, die Sie mit dem Befehl `kubectl get service kubernetes -o yaml | grep clusterIP` abrufen können.
*  Den Kubernetes Service-Domänennamen, der standardmäßig `https://kubernetes.default.svc.cluster.local` lautet.
*  Die Cluster-Master-IP, die Sie mit dem Befehl `kubectl cluster-info | grep Kubernetes` abrufen können.

In den folgenden Schritten wird beschrieben, wie Sie Ihre Kubernetes-Netzrichtlinien aktualisieren. Um die Netzrichtlinien von Calico zu aktualisieren, wiederholen Sie diese Schritte mit einigen kleineren Richtliniensyntaxänderungen und `calicoctl`, um Richtlinien nach Auswirkungen zu durchsuchen.
{: note}

Vorbereitende Schritte: [Melden Sie sich an Ihrem Konto an. Geben Sie, sofern anwendbar, die richtige Ressourcengruppe als Ziel an. Legen Sie den Kontext für den Cluster fest.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

1.  Rufen Sie die Master-IP-Adresse Ihres Clusters ab.
    ```
    kubectl cluster-info | grep Kubernetes
    ```
    {: pre}

2.  Durchsuchen Sie Ihre Kubernetes-Netzrichtlinien nach Auswirkungen. Wenn keine YAML zurückgegeben wird, ist Ihr Cluster nicht betroffen, und Sie müssen keine zusätzlichen Änderungen vornehmen.
    ```
    kubectl get networkpolicies --all-namespaces -o yaml | grep <cluster-master-ip>
    ```
    {: pre}

3.  Überprüfen Sie die YAML. Wenn Ihr Cluster beispielsweise die folgende Kubernetes-Netzrichtlinie verwendet, damit Pods im Namensbereich `default` über die `kubernetes`-Service-Cluster-IP oder über die Cluster-Master-IP auf den Cluster-Master zugreifen können, müssen Sie die Richtlinie aktualisieren.
    ```
    apiVersion: networking.k8s.io/v1
    kind: NetworkPolicy
    metadata:
      name: all-master-egress
      namespace: default
    spec:
      egress:
      # Zugriff auf Cluster-Master mithilfe von Kubernetes Service-Cluster-IP-Adresse
      # oder Domänenname oder Cluster-Master-IP-Adresse zulassen.
      - ports:
        - protocol: TCP
        to:
        - ipBlock:
            cidr: 161.202.126.210/32
      # Zugriff auf Kubernetes-DNS zulassen, um den Kubernetes Service-
      # Domänennamen aufzulösen.
      - ports:
        - protocol: TCP
          port: 53
        - protocol: UDP
          port: 53
      podSelector: {}
      policyTypes:
      - Egress
    ```
    {: screen}

4.  Überarbeiten Sie die Kubernetes-Netzrichtlinie, um für die clusterinterne Master-Proxy-IP-Adresse `172.20.0.1` ausgehenden Netzverkehr zuzulassen. Behalten Sie bis auf Weiteres die Cluster-Master-IP-Adresse bei. Das vorherige Netzrichtlinienbeispiel ändert sich beispielsweise wie folgt.

    Wenn Sie zuvor Ihre Richtlinien für ausgehenden Netzverkehr so konfiguriert haben, dass nur eine einzelne IP-Adresse und ein einzelner Port für den einzelnen Kubernetes-Master geöffnet sind, verwenden Sie jetzt den clusterinternen IP-Adressbereich '172.20.0.1/32' und den Port '2040' des Master-Proxy.
    {: tip}

    ```
    apiVersion: networking.k8s.io/v1
    kind: NetworkPolicy
    metadata:
      name: all-master-egress
      namespace: default
    spec:
      egress:
      # Zugriff auf Cluster-Master mithilfe von Kubernetes Service-Cluster-IP-Adresse
      # oder Domänenname zulassen.
      - ports:
        - protocol: TCP
        to:
        - ipBlock:
            cidr: 172.20.0.1/32
        - ipBlock:
            cidr: 161.202.126.210/32
      # Zugriff auf Kubernetes-DNS zulassen, um den Kubernetes Service-Domänennamen aufzulösen.
      - ports:
        - protocol: TCP
          port: 53
        - protocol: UDP
          port: 53
      podSelector: {}
      policyTypes:
      - Egress
    ```
    {: screen}

5.  Wenden Sie die überarbeitete Netzrichtlinie auf Ihren Cluster an.
    ```
    kubectl apply -f all-master-egress.yaml
    ```
    {: pre}

6.  Nachdem Sie alle [Vorbereitungsaktionen](#ha-masters) (einschließlich dieser Schritte) ausgeführt haben, [aktualisieren Sie Ihren Cluster-Master](/docs/containers?topic=containers-update#master) auf das Fixpack für den Hochverfügbarkeitsmaster.

7.  Wenn die Aktualisierung abgeschlossen ist, entfernen Sie die Cluster-Master-IP-Adresse aus der Netzrichtlinie. Entfernen Sie beispielsweise aus der vorherigen Netzrichtlinie die folgenden Zeilen und wenden Sie die Richtlinie dann erneut an.

    ```
    - ipBlock:
        cidr: 161.202.126.210/32
    ```
    {: screen}

    ```
    kubectl apply -f all-master-egress.yaml
    ```
    {: pre}

### Aktualisieren auf `containerd` als Containerlaufzeit
{: #containerd}

Für Cluster, auf denen Kubernetes Version 1.11 oder höher ausgeführt wird, wird `containerd` durch Docker als neue Containerlaufzeit für Kubernetes ersetzt, um die Leistung zu verbessern. Wenn Ihre Pods Docker als Kubernetes-Containerlaufzeit verwenden, müssen Sie sie aktualisieren, damit `containerd` als Containerlaufzeitumgebung behandelt wird. Weitere Informationen finden Sie in der [Kubernetes-Ankündigung zu 'containerd' ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/blog/2018/05/24/kubernetes-containerd-integration-goes-ga/).
{: shortdesc}

**Wie kann ich wissen, ob meine Apps auf `docker` anstatt auf `containerd` basieren?**<br>
Beispiele für Situationen, in denen Sie Docker als Containerlaufzeit verwenden:
*  Wenn Sie direkt über privilegierte Container auf die Docker-Engine oder -API zugreifen, aktualisieren Sie Ihre Pods, um `containerd` als Laufzeit zu unterstützen. Sie können beispielsweise das Docker-Socket direkt aufrufen, um Container zu starten oder andere Docker-Operationen auszuführen. Das Docker-Socket hat sich von `/var/run/docker.sock` in `/run/containerd/containerd.sock` geändert. Das Protokoll, das im Socket `containerd` verwendet wird, unterscheidet sich leicht von dem in Docker. Versuchen Sie, Ihre App auf das Socket `containerd` zu aktualisieren. Wenn Sie das Docker-Socket weiterhin verwenden möchten, finden Sie weitere Informationen unter [Docker-inside-Docker (DinD) ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://hub.docker.com/_/docker/).
*  Einige Add-ons von Drittanbietern (wie z. B. Protokollierungs- und Überwachungstools), die Sie in Ihrem Cluster installieren, verwenden möglicherweise die Docker-Engine. Klären Sie mit Ihrem Provider, ob die Tools mit 'containerd' kompatibel sind. Mögliche Anwendungsfälle sind:
   - Ihr Protokollierungstool verwendet unter Umständen das Verzeichnis `/var/log/pods/<pod_uuid>/<container_name>/*.log` des Containers `stderr/stdout` für den Zugriff auf Protokolle. In Docker ist dieses Verzeichnis eine symbolische Verbindung zu `/var/data/cripersistentstorage/containers/<container_uuid>/<container_uuid>-json.log`, wohingegen Sie in `containerd` direkt, ohne symbolische Verbindung, auf das Verzeichnis zugreifen.
   - Ihr Überwachungstool greift direkt auf das Docker-Socket zu. Das Docker-Socket hat sich von `/var/run/docker.sock` in `/run/containerd/containerd.sock` geändert.

<br>

**Muss ich neben der Berücksichtigung der Abhängigkeit von der Laufzeit weitere Vorbereitungsaktionen ausführen?**<br>

**Manifesttool**: Wenn Sie plattformübergreifende Images haben, die mit dem experimentellen Tool `docker-manifest` [ ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://docs.docker.com/edge/engine/reference/commandline/manifest/) vor Docker Version 18.06 erstellt wurden, können Sie das Image nicht mit `containerd` aus DockerHub extrahieren.

Wenn Sie die Podereignisse überprüfen, sehen Sie möglicherweise folgenden Fehler.
```
failed size validation
```
{: screen}

Wenn Sie ein Image verwenden möchten, das mithilfe des Manifesttools mit `containerd` erstellt wurde, wählen Sie eine der folgenden Optionen aus.

*  Erstellen Sie das Image mit dem [Manifesttool ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/estesp/manifest-tool) neu.
*  Erstellen Sie das Image mit dem Tool `docker-manifest` neu, nachdem Sie eine Aktualisierung auf Docker Version 18.06 oder höher vorgenommen haben.

<br>

**Was ist nicht betroffen? Muss ich die Art und Weise ändern, mit der ich meine Container bereitstelle?**<br>
Im Allgemeinen ändern sich Ihre Prozesse zur Containerbereitstellung nicht. Sie können immer noch eine Dockerfile verwenden, um ein Docker-Image zu definieren und einen Docker-Container für Ihre Apps zu erstellen. Wenn Sie `docker`-Befehle für die Erstellung und Push-Übertragung von Images an eine Registry verwenden, können Sie weiterhin `docker` nutzen oder stattdessen `ibmcloud cr`-Befehle verwenden.

### Vorbereitungen für die Aktualisierung auf Calico Version 3
{: #111_calicov3}

Wenn Sie für einen Cluster ein Upgrade von Kubernetes Version 1.9 oder einer früheren Version auf Version 1.11 durchführen, bereiten Sie sich auf die Calico Version 3-Aktualisierung vor, bevor Sie den Master aktualisieren. Während der Aktualisierung des Masters auf Kubernetes Version 1.11 werden keine neuen Pods oder neue Kubernetes- oder Calico-Netzrichtlinien terminiert. Die Zeit, während der bei der Aktualisierung keine neue Terminierung möglich ist, variiert. Für kleine Cluster kann der Vorgang einige Minuten dauern, wobei für jede 10 Knoten ein paar Minuten mehr benötigt werden. Bestehende Netzrichtlinien und Pods werden weiterhin ausgeführt.
{: shortdesc}

Wenn Sie für einen Cluster eine Aktualisierung von Kubernetes Version 1.10 auf Version 1.11 durchführen, überspringen Sie diese Schritte, weil Sie diese Schritte bereits ausgeführt haben, als Sie die Aktualisierung auf Version 1.10 durchgeführt haben.
{: note}

Sie müssen zunächst sicherstellen, dass vom Cluster-Master und auf allen Workerknoten Kubernetes Version 1.8 oder 1.9 ausgeführt wird und Sie über mindestens einen Workerknoten verfügen.

1.  Stellen Sie sicher, dass die Calico-Pods in einwandfreiem Zustand sind.
    ```
    kubectl get pods -n kube-system -l k8s-app=calico-node -o wide
    ```
    {: pre}

2.  Wenn ein Pod nicht den Status **Aktiv** aufweist, löschen Sie den Pod und warten Sie, bis er den Status **Aktiv** einnimmt, bevor Sie fortfahren. Wenn der Pod nicht in den Status **Aktiv** zurückkehrt:
    1.  Prüfen Sie den **Zustand** und den **Status** des Workerknotens.
        ```
        ibmcloud ks workers --cluster <clustername_oder_-id>
        ```
        {: pre}
    2.  Wenn der Zustand des Workerknotens nicht **Normal** lautet, befolgen Sie die Schritte zum [Debuggen von Workerknoten](/docs/containers?topic=containers-cs_troubleshoot#debug_worker_nodes). Der Zustand **Kritisch** oder **Unbekannt** lässt sich häufig auflösen, indem Sie [den Workerknoten neu laden](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_reload).

3.  Wenn Sie Calico-Richtlinien oder andere Calico-Ressourcen automatisch generieren, aktualisieren Sie Ihre Automatisierungstools, um diese Ressourcen mit der [Calico Version 3-Syntax ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://docs.projectcalico.org/v3.1/reference/calicoctl/resources/) zu generieren.

4.  Wenn Sie [strongSwan](/docs/containers?topic=containers-vpn#vpn-setup) für die VPN-Konnektivität verwenden, funktioniert das strongSwan 2.0.0-Helm-Diagramm nicht mit Calico Version 3 oder Kubernetes 1.11. [Aktualisieren Sie strongSwan](/docs/containers?topic=containers-vpn#vpn_upgrade) auf das 2.1.0-Helm-Diagramm, das abwärtskompatibel mit Calico 2.6 und Kubernetes 1.7, 1.8 und 1.9 ist.

5.  [Aktualisieren Sie den Cluster-Master auf Kubernetes Version 1.11](/docs/containers?topic=containers-update#master).

<br />


## Archiv
{: #k8s_version_archive}

Hier finden Sie eine Übersicht über Kubernetes-Versionen, die in {{site.data.keyword.containerlong_notm}} nicht unterstützt werden.
{: shortdesc}

### Version 1.10 (nicht unterstützt)
{: #cs_v110}

Seit dem 16. Mai 2019 werden {{site.data.keyword.containerlong_notm}}-Cluster, die unter [Kubernetes Version 1.10](/docs/containers?topic=containers-changelog#changelog_archive) ausgeführt werden, nicht mehr unterstützt. Cluster der Version 1.10 können keine Sicherheitsupdates oder Unterstützung mehr erhalten, bis sie auf die nächste, aktuellste Version aktualisiert werden.
{: shortdesc}

[Überprüfen Sie die mögliche Auswirkung](/docs/containers?topic=containers-cs_versions#cs_versions) jeder einzelnen Aktualisierung einer Kubernetes-Version und [aktualisieren Sie dann Ihre Cluster](/docs/containers?topic=containers-update#update) auf [Kubernetes 1.12](#cs_v112), da Kubernetes 1.11 veraltet ist. 

### Version 1.9 (nicht unterstützt)
{: #cs_v19}

Seit dem 27. Dezember werden {{site.data.keyword.containerlong_notm}}-Cluster, die auf [Kubernetes Version 1.9](/docs/containers?topic=containers-changelog#changelog_archive) ausgeführt werden, nicht mehr unterstützt. Cluster der Version 1.9 können keine Sicherheitsupdates oder Unterstützung mehr erhalten, bis sie auf die nächste, aktuellste Version aktualisiert werden.
{: shortdesc}

[Überprüfen Sie die mögliche Auswirkung](/docs/containers?topic=containers-cs_versions#cs_versions) jeder einzelnen Aktualisierung einer Kubernetes-Version und [aktualisieren Sie dann Ihre Cluster](/docs/containers?topic=containers-update#update) zunächst auf die [veraltete Kubernetes-Version 1.11](#cs_v111) und dann sofort auf [Kubernetes 1.12](#cs_v112).

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
