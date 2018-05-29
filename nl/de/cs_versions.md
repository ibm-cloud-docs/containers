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

# Kubernetes-Versionen
{: #cs_versions}

{{site.data.keyword.containerlong}} unterstützt momentan mehrere Versionen von Kubernetes. Wenn die aktuellste Version (n) freigegeben wird, werden bis zu 2 Versionen davor (n-2) unterstützt. Versionen, die mehr als zwei Versionen älter sind, als die aktuellsten Version (n-3) werden zuerst nicht mehr verwendet und dann nicht weiter unterstützt.
{:shortdesc}

Die folgenden Kubernetes-Version werden gegenwärtig unterstützt:

- Aktuell: 1.9.3
- Standard: 1.8.11
- Unterstützt: 1.7.16

**Veraltete Versionen**: Wenn Cluster auf einem veralteten Kubernetes ausgeführt werden, haben Sie 30 Tage Zeit, um eine unterstützte Kubernetes-Version zu überprüfen und auf diese neuere Version zu aktualisieren, bevor die veraltete Version nicht mehr unterstützt wird. Während des Zeitraums der Einstellung der Unterstützung können Sie eingeschränkte Befehle in Ihren Clustern ausführen, um Worker hinzuzufügen, erneut zu laden und um das Cluster zu aktualisieren. In der veralteten Version können Sie keine neuen Cluster erstellen.

**Nicht unterstützte Versionen**: Wenn Sie Cluster unter einer Kubernetes-Version ausführen, die nicht unterstützt wird, [überprüfen Sie potenzielle Auswirkungen](#version_types) auf Updates und [aktualisieren Sie den Cluster](cs_cluster_update.html#update) sofort, damit Sie weiterhin wichtige Sicherheitsupdates und Support erhalten.

Führen Sie den folgenden Befehl aus, um die Serverversion eines Clusters zu überprüfen. 

```
kubectl version  --short | grep -i server
```
{: pre}

Beispielausgabe:

```
Server Version: v1.8.11+9d6e0610086578
```
{: screen}


## Aktualisierungstypen
{: #version_types}

Für Ihr Kubernetes-Cluster gibt es drei Typen von Aktualisierungen: Hauptversion, Nebenversion und Patch.
{:shortdesc}

|Aktualisierungstyp|Beispiel für Versionskennzeichnungen|Aktualisierung durch|Auswirkung
|-----|-----|-----|-----|
|Hauptversion|1.x.x|Sie|Operationsänderungen für Cluster, darunter Sripts oder Bereitstellungen.|
|Nebenversion|x.9.x|Sie|Operationsänderungen für Cluster, darunter Sripts oder Bereitstellungen.|
|Patch|x.x.4_1510|IBM und Sie|Kubernetes-Patches und andere Aktualisierungen von {{site.data.keyword.Bluemix_notm}} Provider-Komponenten, z. B. Sicherheits- und Betriebssystempatches. IBM aktualisiert die Master automatisch, aber Sie wenden Patches auf Workerknoten an.|
{: caption="Auswirkungen auf Kubernetes-Aktualisierungen" caption-side="top"}

Sobald Aktualisierungen verfügbar sind, werden Sie benachrichtigt, wenn Sie Informationen zu den Workerknoten anzeigen, z. B. mit den Befehlen `bx cs workers <cluster>` oder `bx cs worker-get <cluster> <worker>`. 
-  **Aktualisierungen von Haupt- und Nebenversionen**: Zuerst [aktualisieren Sie Ihren Masterknoten](cs_cluster_update.html#master) und anschließend [die Workerknoten](cs_cluster_update.html#worker_node).  
   - Standardmäßig ist für einen Kubernetes-Master eine Aktualisierung über mehr als zwei Nebenversionen hinweg nicht möglich. Wenn die aktuelle Masterversion beispielsweise 1.5 ist und Sie eine Aktualisierung auf 1.8 durchführen möchten, müssen Sie zunächst auf Version 1.7 aktualisieren. Sie können die gewünschte Aktualisierung zwar erzwingen, jedoch kann eine Aktualisierung über mehr als zwei Nebenversionen hinweg zu nicht erwarteten Ergebnissen führen.
   - Wenn Sie eine `kubectl`-CLI-Version verwenden, die nicht wenigstens mit der Version `major.minor` Ihrer Cluster übereinstimmt, kann dies zu unerwarteten Ergebnissen führen. Stellen Sie sicher, dass Ihr Kubernetes-Cluster und die [CLI-Versionen](cs_cli_install.html#kubectl) immer auf dem neuesten Stand sind.
-  **Patchaktualisierungen**: Überprüfen Sie einmal im Monat, ob eine Aktualisierung verfügbar ist, und geben Sie den [Befehl](cs_cli_reference.html#cs_worker_update) `bx cs worker-update` aus, um diese Sicherheits- und Betriebssystempatches anzuwenden. Weitere Details finden Sie im [Änderungsprotokoll der Version](cs_versions_changelog.html). 

<br/>

Auf dieser Seite finden Sie eine Zusammenfassung der Aktualisierungen, die sich voraussichtlich auf die bereitgestellten Apps auswirken, wenn Sie einen Cluster von einer vorherigen Version auf eine neue Version aktualisieren. 
-  Version 1.9, [Migrationsaktionen](#cs_v19). 
-  Version 1.8, [Migrationsaktionen](#cs_v18). 
-  Version 1.7, [Migrationsaktionen](#cs_v17). 
-  [Archiv](#k8s_version_archive) veralteter oder nicht unterstützter Versionen. 

<br/>

Eine vollständige Liste von Änderungen finden Sie in den folgenden Quellen: 
* [Kubernetes-Änderungsprotokoll ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG.md). 
* [Änderungsprotokoll der IBM Versionen](cs_versions_changelog.html).

## Version 1.9
{: #cs_v19}

<p><img src="images/certified_kubernetes_1x9.png" style="padding-right: 10px;" align="left" alt="Diese Markierung zeigt die Kubernetes Version 1.9-Zertifizierung für IBM Cloud Container Service an. "/> {{site.data.keyword.containerlong_notm}} ist ein zertifiziertes Kubernetes-Produkt für Version 1.9 unter dem CNCF Kubernetes Software Conformance Certification Program. _Kubernetes® ist eine eingetragene Marke von The Linux Foundation in den USA und anderen Ländern und wird entsprechend einer Lizenz von The Linux Foundation verwendet._</p>

Überprüfen Sie Änderungen, die Sie möglicherweise bei einer Aktualisierung von der vorherigen Version auf die Kubernetes-Version 1.9 vornehmen müssen.

<br/>

### Vor Master aktualisieren
{: #19_before}

<table summary="Kubernetes-Aktualisierungen für Version 1.9">
<caption>Vorzunehmende Änderungen vor der Aktualisierung des Masters auf Kubernetes 1.9</caption>
<thead>
<tr>
<th>Typ</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>Webhook-Zugangs-API</td>
<td>Die Zugangs-API, die verwendet wird, wenn der API-Server Webhooks für die Zugangssteuerung aufruft, wird von <code>admission.v1alpha1</code> nach <code>admission.v1beta1</code> verschoben. <em>Sie müssen alle vorhandenen Webhooks löschen, bevor Sie das Upgrade für Ihren Cluster durchführen</em>, und die Webhook-Konfigurationsdateien so aktualisieren, dass die aktuelle API verwendet wird. Diese Änderung ist nicht abwärtskompatibel.</td>
</tr>
</tbody>
</table>

### Nach Master aktualisieren
{: #19_after}

<table summary="Kubernetes-Aktualisierungen für Version 1.9">
<caption>Vorzunehmende Änderungen nach der Aktualisierung des Masters auf Kubernetes 1.9</caption>
<thead>
<tr>
<th>Typ</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>`kubectl` - Ausgabe</td>
<td>Wenn Sie im Befehl `kubectl` die Option `-o custom-columns` angeben und die Spalte in dem Objekt nicht gefunden wird, wird jetzt die Ausgabe `<none>`.<br>
Bisher schlug die Operation fehl und die Fehlernachricht `xxx wurde nicht gefunden` wurde angezeigt. Wenn Ihre Scripts das bisherige Verhalten erwarten, aktualisieren Sie die Scripts.</td>
</tr>
<tr>
<td>`kubectl patch`</td>
<td>Wenn beim Korrigieren der Ressource keine Änderungen vorgenommen werden, schlägt der Befehl `kubectl patch` jetzt mit `exit code 1` fehl. Wenn Ihre Scripts das bisherige Verhalten erwarten, aktualisieren Sie die Scripts.</td>
</tr>
<tr>
<td>Berechtigungen für das Kubernetes-Dashboard</td>
<td>Benutzer müssen sich mit Ihren Berechtigungsnachweisen beim Kubernetes-Dashboard anmelden, um Clusterressourcen anzuzeigen. Die RBAC-Standardberechtigung `ClusterRoleBinding` für das Kubernetes-Dashboard wurde entfernt. Entsprechende Anweisungen finden Sie unter [Kubernetes-Dashboard starten](cs_app.html#cli_dashboard).</td>
</tr>
<tr>
<td>Taints und Tolerierungen</td>
<td>Die Taints `node.alpha.kubernetes.io/notReady` und `node.alpha.kubernetes.io/unreachable` wurden in `node.kubernetes.io/not-ready` und `node.kubernetes.io/unreachable` geändert.<br>
Die Aktualisierung der Taints erfolgt zwar automatisch, aber die Tolerierungen dieser Taints müssen manuell aktualisiert werden. Stellen Sie für jeden Namensbereich mit Ausnahme von `ibm-system` und `kube-system` fest, ob die Tolerierungen geändert werden müssen:<br>
<ul><li><code>kubectl get pods -n &lt;namensbereich&gt; -o yaml | grep "node.alpha.kubernetes.io/notReady" && echo "Action required"</code></li><li>
<code>kubectl get pods -n &lt;namensbereich&gt; -o yaml | grep "node.alpha.kubernetes.io/unreachable" && echo "Action required"</code></li></ul><br>
Wenn `Action required` zurückgegeben wird, ändern Sie die Pod-Tolerierungen entsprechend.</td>
</tr>
<tr>
<td>Webhook-Zugangs-API</td>
<td>Wenn Sie vor dem Aktualisieren des Clusters vorhandene Webhooks gelöscht hatten, erstellen Sie neue Webhooks.</td>
</tr>
</tbody>
</table>

<br />


## Version 1.8
{: #cs_v18}

<p><img src="images/certified_kubernetes_1x8.png" style="padding-right: 10px;" align="left" alt="Diese Markierung zeigt die Kubernetes Version 1.8-Zertifizierung für IBM Cloud Container Service an."/> {{site.data.keyword.containerlong_notm}} ist ein zertifiziertes Kubernetes-Produkt für Version 1.8 unter dem CNCF Kubernetes Software Conformance Certification Program. _Kubernetes® ist eine eingetragene Marke von The Linux Foundation in den USA und anderen Ländern und wird entsprechend einer Lizenz von The Linux Foundation verwendet._</p>

Überprüfen Sie Änderungen, die Sie möglicherweise bei einer Aktualisierung von der vorherigen Version auf die Kubernetes-Version 1.8 vornehmen müssen.

<br/>

### Vor Master aktualisieren
{: #18_before}

<table summary="Kubernetes-Aktualisierungen für Version 1.8">
<caption>Vorzunehmende Änderungen vor der Aktualisierung des Masters auf Kubernetes 1.8</caption>
<thead>
<tr>
<th>Typ</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>Keine</td>
<td>Keine Änderungen vor der Aktualisierung des Masters erforderlich</td>
</tr>
</tbody>
</table>

### Nach Master aktualisieren
{: #18_after}

<table summary="Kubernetes-Aktualisierungen für Version 1.8">
<caption>Vorzunehmende Änderungen nach der Aktualisierung des Masters auf Kubernetes 1.8</caption>
<thead>
<tr>
<th>Typ</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>Anmeldung beim Kubernetes-Dashboard</td>
<td>Die URL für den Zugriff auf das Kubernetes-Dashboard in Version 1.8 wurde geändert und für den Anmeldeprozess ist ein neuer Authentifizierungsschritt erforderlich. Weitere Informationen hierzu finden Sie im Abschnitt zum [Zugriff auf das Kubernetes-Dashboard](cs_app.html#cli_dashboard).</td>
</tr>
<tr>
<td>Berechtigungen für das Kubernetes-Dashboard</td>
<td>Damit sich Benutzer mit ihren Berechtigungsnachweisen anmelden müssen, um Clusterressourcen in Version 1.8 anzeigen zu können, entfernen Sie die RBAC-Berechtigung 'ClusterRoleBinding' aus Version 1.7. Führen Sie dazu `kubectl delete clusterrolebinding -n kube-system kubernetes-dashboard` aus.</td>
</tr>
<tr>
<td>`kubectl delete`</td>
<td>Mit dem Befehl `kubectl delete` werden nicht länger API-Objekte für Arbeitslasten, wie Pods, vor dem Löschen des Objekts nach unten skaliert. Wenn das Objekt nach unten skaliert werden soll, verwenden Sie den Befehl [`kubectl scale ` ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#scale), bevor Sie das Objekt löschen.</td>
</tr>
<tr>
<td>`kubectl run`</td>
<td>Der Befehl `kubectl run` muss anstelle von durch Kommas getrennten Argumenten mehrere Flags für `--env` verwenden. Führen Sie beispielsweise <code>kubectl run --env &lt;x&gt;=&lt;y&gt; --env &lt;z&gt;=&lt;a&gt;</code> und nicht <code>kubectl run --env &lt;x&gt;=&lt;y&gt;,&lt;z&gt;=&lt;a&gt;</code> aus. </td>
</tr>
<tr>
<td>`kubectl stop`</td>
<td>Der Befehl `kubectl stop` ist nicht mehr verfügbar.</td>
</tr>
<tr>
<td>Schreibgeschützte API-Datenträger</td>
<td>`secret`, `configMap`, `downwardAPI` und projizierte Datenträger werden jetzt nur schreibgeschützt angehängt.
Früher durften Apps Daten auf diese Datenträger schreiben, die vom System möglicherweise nicht automatisch zurückgesetzt werden. Diese Migrationsaktion ist erforderlich,
um die Sicherheitslücke [CVE-2017-1002102](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2017-1002102) zu schließen. Wenn Ihre Apps das bisherige unsichere Verhalten erwarten, ändern Sie sie entsprechend. </td>
</tr>
</tbody>
</table>

<br />


## Version 1.7
{: #cs_v17}

<p><img src="images/certified_kubernetes_1x7.png" style="padding-right: 10px;" align="left" alt="Diese Markierung zeigt die Kubernetes Version 1.7-Zertifizierung für IBM Cloud Container Service an."/> {{site.data.keyword.containerlong_notm}} ist ein zertifiziertes Kubernetes-Produkt für Version 1.7 unter dem CNCF Kubernetes Software Conformance Certification Program.</p>

Überprüfen Sie Änderungen, die Sie möglicherweise bei einer Aktualisierung von der vorherigen Version auf die Kubernetes-Version 1.7 vornehmen müssen.

<br/>

### Vor Master aktualisieren
{: #17_before}

<table summary="Kubernetes-Aktualisierungen für die Versionen 1.7 und 1.6">
<caption>Vorzunehmende Änderungen vor der Aktualisierung des Masters auf Kubernetes 1.7</caption>
<thead>
<tr>
<th>Typ</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>Speicher</td>
<td>Konfigurationsscripts mit den Angaben `hostPath` und `mountPath` und Verweisen auf das übergeordnete Verzeichnis wie beispielsweise `../to/dir` sind nicht zulässig. Ändern Sie die Pfade in einfache absolute Pfade. Beispiel: `/path/to/dir`.
<ol>
  <li>Stellen Sie fest, ob Sie Speicherpfade ändern müssen:</br>
  ```
  kubectl get pods --all-namespaces -o yaml | grep "\.\." && echo "Action required"
  ```
  </br>

  <li>Wenn vom System die Meldung `Action required` (Aktion erforderlich) zurückgegeben wird, müssen Sie die Pods so ändern, dass auf den absoluten Pfad verwiesen wird, bevor Sie alle Workerknoten aktualisieren. Wenn eine andere Ressource (z. B. eine Bereitstellung) Eigner des Pods ist, müssen Sie die [_PodSpec_ ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/api-reference/v1.7/#podspec-v1-core) in dieser Ressource ändern.
</ol>
</td>
</tr>
</tbody>
</table>

### Nach Master aktualisieren
{: #17_after}

<table summary="Kubernetes-Aktualisierungen für die Versionen 1.7 und 1.6">
<caption>Vorzunehmende Änderungen nach der Aktualisierung des Masters auf Kubernetes 1.7</caption>
<thead>
<tr>
<th>Typ</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>Bereitstellung von `apiVersion`</td>
<td>Nachdem Sie die Cluster von Kubernetes 1.5 aktualisiert haben, verwenden Sie `apps/v1beta1` für das Feld `apiVersion` in neuen `Deployment`-YAML-Dateien. Verwenden Sie weiterhin `extensions/v1beta1` für andere Ressourcen, wie z. B. `Ingress`.</td>
</tr>
<tr>
<td>kubectl</td>
<td>Nach der Aktualisierung der `kubectl`-Benutzerschnittstelle müssen in den folgenden `kubectl create`-Befehlen anstelle von durch Kommas getrennten Argumenten mehrere Flags verwendet werden:<ul>
 <li>`role`
 <li>`clusterrole`
 <li>`rolebinding`
 <li>`clusterrolebinding`
 <li>`secret`
 </ul>
</br>  Führen Sie z. B. `kubectl create role --resource-name <x> --resource-name <y>` und nicht `kubectl create role --resource-name <x>,<y>` aus.</td>
</tr>
<tr>
<td>Netzrichtlinie</td>
<td>Die Annotation `net.beta.kubernetes.io/network-policy` ist nicht mehr verfügbar.
<ol>
  <li>Stellen Sie fest, ob Sie Richtlinien ändern müssen:</br>
  ```
  kubectl get ns -o yaml | grep "net.beta.kubernetes.io/network-policy" | grep "DefaultDeny" && echo "Action required"
  ```
  <li>Wenn das System die Meldung `"Action required"` (Aktion erforderlich) zurückgibt, müssen Sie die folgende Netzrichtlinie zu jedem aufgeführten Kubernetes-Namensbereich hinzufügen:</br>

  <pre class="codeblock">
  <code>
  kubectl create -n &lt;namensbereich&gt; -f - &lt;&lt;EOF
  kind: NetworkPolicy
  apiVersion: networking.k8s.io/v1
  metadata:
    name: default-deny
    namespace: &lt;namensbereich&gt;
  spec:
    podSelector: {}
  EOF
  </code>
  </pre>

  <li> Entfernen Sie nach dem Hinzufügen der Netzrichtlinie die Annotation `net.beta.kubernetes.io/network-policy`:
  ```
  kubectl annotate ns <namensbereich> --overwrite "net.beta.kubernetes.io/network-policy-"
  ```
  </li></ol>
</td></tr>
<tr>
<td>Affinitätsplanung für Pod</td>
<td> Die Annotation `scheduler.alpha.kubernetes.io/affinity` wird nicht mehr verwendet.
<ol>
  <li>Stellen Sie für jeden Namensbereich mit Ausnahme von `ibm-system` und `kube-system` fest, ob die Affinitätsplanung für den Pod aktualisiert werden muss:</br>
  ```
  kubectl get pods -n <namensbereich> -o yaml | grep "scheduler.alpha.kubernetes.io/affinity" && echo "Action required"
  ```
  </br></li>
  <li>Wenn das System die Meldung `"Action required"` (Aktion erforderlich) zurückgibt, verwenden Sie anstelle der Annotation `scheduler.alpha.kubernetes.io/affinity` das Feld _affinity_ der [_PodSpec_ ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/api-reference/v1.7/#podspec-v1-core).</li>
</ol>
</td></tr>
<tr>
<td>RBAC für `default` `ServiceAccount`</td>
<td><p>Die Administratorberechtigung `ClusterRoleBinding` für den `default` `ServiceAccount` im Standardnamensbereich `default` wurde entfernt, um die Clustersicherheit zu verbessern. Anwendungen, die im Standardnamensbereich `default` ausgeführt werden, verfügen nicht mehr über Clusteradministratorberechtigungen für die Kubernetes-API und es kann bei Ihnen zu `RBAC DENY`-Berechtigungsfehlern kommen. Prüfen Sie Ihre App und die zugehörige `.yaml`-Datei, um zu sehen, ob sie im Namensbereich `default` ausgeführt wird, das Standardservicekonto (`default ServiceAccount`) verwendet und auf die Kubernetes-API zugreift. </p>
<p>Wenn Ihre Anwendungen auf diese Berechtigungen angewiesen sind, [erstellen Sie RBAC-Berechtigungsressourcen ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/admin/authorization/rbac/#api-overview) für Ihre Apps. </p>
  <p>Wenn Sie die RBAC-Richtlinien für Ihre App aktualisieren, möchten Sie möglicherweise temporär zum vorherigen Standard `default` zurückkehren. Mit dem Befehl `kubectl apply -f DATEINAME` können Sie die folgenden Dateien kopieren, speichern und anwenden. <strong>Hinweis</strong>: Nutzen Sie das Zurücksetzen, damit Sie Zeit zum Aktualisieren aller Anwendungsressourcen haben. Dies ist jedoch keine langfristige Lösung.</p>

<p><pre class="codeblock">
<code>
kind: ClusterRoleBinding
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
 name: admin-binding-nonResourceURLSs-default
subjects:
  - kind: ServiceAccount
    name: default
    namespace: default
roleRef:
 kind: ClusterRole
 name: admin-role-nonResourceURLSs
 apiGroup: rbac.authorization.k8s.io
---
kind: ClusterRoleBinding
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
 name: admin-binding-resourceURLSs-default
subjects:
  - kind: ServiceAccount
      name: default
      namespace: default
  roleRef:
   kind: ClusterRole
   name: admin-role-resourceURLSs
   apiGroup: rbac.authorization.k8s.io
</code>
</pre></p>
</td>
</tr>
<tr>
<td>Schreibgeschützte API-Datenträger</td>
<td>`secret`, `configMap`, `downwardAPI` und projizierte Datenträger werden jetzt nur schreibgeschützt angehängt.
Früher durften Apps Daten auf diese Datenträger schreiben, die vom System möglicherweise nicht automatisch zurückgesetzt werden. Diese Migrationsaktion ist erforderlich,
um die Sicherheitslücke [CVE-2017-1002102](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2017-1002102) zu schließen. Wenn Ihre Apps das bisherige unsichere Verhalten erwarten, ändern Sie sie entsprechend. </td>
</tr>
<tr>
<td>StatefulSet pod DNS</td>
<td>Pods des Typs 'StatefulSet' verlieren nach der Aktualisierung des Masters ihre Kubernetes-DNS-Einträge. Um die DNS-Einträge wiederherzustellen, löschen Sie diese Pods. Kubernetes erstellt die Pods erneut und stellt die DNS-Einträge automatisch wieder her. Weitere Informationen finden Sie im Abschnitt zu dem entsprechenden [Problem in Kubernetes ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/kubernetes/kubernetes/issues/48327).</td>
</tr>
<tr>
<td>Tolerierungen</td>
<td>Die Annotation `scheduler.alpha.kubernetes.io/tolerations` ist nicht mehr verfügbar.
<ol>
  <li>Stellen Sie für jeden Namensbereich mit Ausnahme von `ibm-system` und `kube-system` fest, ob die Tolerierungen geändert werden müssen:</br>
  ```
  kubectl get pods -n <namensbereich> -o yaml | grep "scheduler.alpha.kubernetes.io/tolerations" && echo "Action required"
  ```
  </br>

  <li>Wenn das System die Meldung `"Action required"` (Aktion erforderlich) zurückgibt, verwenden Sie anstelle der Annotation `scheduler.alpha.kubernetes.io/tolerations` das Feld _tolerations_ der [_PodSpec_ ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/api-reference/v1.7/#podspec-v1-core).
</ol>
</td></tr>
<tr>
<td>Taints</td>
<td>Die Annotation `scheduler.alpha.kubernetes.io/taints` ist nicht mehr verfügbar.
<ol>
  <li>Stellen Sie fest, ob Sie Taints ändern müssen:</br>
  ```
  kubectl get nodes -o yaml | grep "scheduler.alpha.kubernetes.io/taints" && echo "Action required"
  ```
  <li>Wenn das System die Meldung `"Action required"` (Aktion erforderlich) zurückgibt, entfernen Sie für jeden Knoten die Annotation `scheduler.alpha.kubernetes.io/taints`:</br>
  `kubectl annotate nodes <node> scheduler.alpha.kubernetes.io/taints-`
  <li>Fügen Sie zu jedem Knoten einen Taint hinzu:</br>
  `kubectl taint node <node> <taint>`
  </li></ol>
</td></tr>
</tbody>
</table>

<br />


## Archiv
{: #k8s_version_archive}

### Version 1.5 (nicht unterstützt)
{: #cs_v1-5}

Seit dem 4. April 2018 werden {{site.data.keyword.containershort_notm}}-Cluster, die auf [Kubernetes Version 1.5](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.5.md) ausgeführt werden, nicht mehr unterstützt. Cluster der Version 1.5 können keine Sicherheitsupdates oder Unterstützung mehr erhalten, bis sie auf die nächste, aktuellste Version ([Kubernetes 1.7](#cs_v17)) aktualisiert wurden. 

[Überprüfen Sie mögliche Auswirkungen](cs_versions.html#cs_versions) jeder Aktualisierung einer Kubernetes-Version und [aktualisieren Sie Ihre Cluster](cs_cluster_update.html#update) dann sofort. Beachten Sie, dass Ihre Aktualisierung von einer Version auf die nächste aktuellste Version ausgeführt wird, wie zum Beispiel von Version 1.5 auf 1.7 oder von Version 1.8 auf 1.9.

