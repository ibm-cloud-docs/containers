---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-05"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# Kubernetes-Versionen für {{site.data.keyword.containerlong_notm}}
{: #cs_versions}

Informieren Sie sich über die Kubernetes-Versionen, die für {{site.data.keyword.containerlong}} verfügbar sind.
{:shortdesc}

{{site.data.keyword.containershort_notm}} unterstützt mehrere Versionen von Kubernetes. Beim Erstellen oder Aktualisieren eines Clusters wird die Standardversion verwendet, es sei denn, Sie geben eine andere Version an. Die folgenden Kubernetes-Versionen stehen zur Verfügung:
- 1.8.6
- 1.7.4 (Standardversion)
- 1.5.6

Führen Sie den folgenden Befehl aus und überprüfen Sie die Version, um festzustellen, welche Version der Kubernetes-Befehlszeilenschnittstelle lokal oder in Ihrem Cluster ausgeführt wird.

```
kubectl version  --short
```
{: pre}

Beispielausgabe:

```
Client Version: 1.7.4
Server Version: 1.7.4
```
{: screen}

## Aktualisierungstypen
{: #version_types}

Kubernetes stellt die folgenden Versionsaktualisierungstypen zur Verfügung:
{:shortdesc}

|Aktualisierungstyp|Beispiel für Versionskennzeichnungen|Aktualisierung durch|Auswirkung
|-----|-----|-----|-----|
|Hauptversion|1.x.x|Sie|Operationsänderungen für Cluster, darunter Sripts oder Bereitstellungen.|
|Nebenversion|x.5.x|Sie|Operationsänderungen für Cluster, darunter Sripts oder Bereitstellungen.|
|Patch|x.x.3|IBM und Sie|Keine Änderungen an Scripts oder Bereitstellungen. IBM aktualisiert die Master automatisch, aber Sie wenden Patches auf Workerknoten an.|
{: caption="Auswirkungen auf Kubernetes-Aktualisierungen" caption-side="top"}

Standardmäßig ist für einen Kubernetes-Master eine Aktualisierung über mehr als zwei Nebenversionen hinweg nicht möglich. Wenn die aktuelle Masterversion beispielsweise 1.5 ist und Sie eine Aktualisierung auf 1.8 durchführen möchten, müssen Sie zunächst auf Version 1.7 aktualisieren. Sie können die gewünschte Aktualisierung zwar erzwingen, jedoch kann eine Aktualisierung über mehr als zwei Nebenversionen hinweg zu nicht erwarteten Ergebnissen führen.
{: tip}

Nachfolgend finden Sie eine Zusammenfassung der Aktualisierungen, die sich voraussichtlich auf die bereitgestellten Apps auswirken, wenn Sie einen Cluster auf eine neue Version aktualisieren. Im [Kubernetes-Änderungsprotokoll ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG.md) finden Sie eine vollständige Liste der Änderungen, die in den verschiedenen Kubernetes-Versionen vorgenommen wurden.

Weitere Informationen zum Aktualisierungsprozess finden Sie in [Cluster aktualisieren](cs_cluster_update.html#master) und [Workerknoten aktualisieren](cs_cluster_update.html#worker_node).

## Version 1.8
{: #cs_v18}

<p><img src="images/certified_kubernetes_1x8.png" style="width:62px; height: 100px; border-style: none; padding-right: 10px;" height="100" width="62.5" align="left" alt="Diese Markierung zeigt die Kubernetes Version 1.8-Zertifizierung für IBM Cloud Container Service an."/> {{site.data.keyword.containerlong_notm}} ist ein zertifiziertes Kubernetes-Produkt für Version 1.8 unter dem CNCF Kubernetes Software Conformance Certification Program. _Kubernetes® ist eine eingetragene Marke von The Linux Foundation in den USA und anderen Ländern und wird entsprechend einer Lizenz von The Linux Foundation verwendet._</p>

Überprüfen Sie Änderungen, die Sie möglicherweise bei einer Aktualisierung auf Kubernetes Version 1.8 vornehmen müssen.

<br/>

### Vor Master aktualisieren
{: #18_before}

<table summary="Kubernetes-Aktualisierungen für Version 1.8">
<caption>Von Ihnen vorgenommene Änderungen vor einer Aktualisierung des Masters auf Kubernetes 1.8</caption>
<thead>
<tr>
<th>Typ</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td colspan='2'>Keine Änderungen vor der Aktualisierung des Masters erforderlich</td>
</tr>
</tbody>
</table>

### Nach Master aktualisieren
{: #18_after}

<table summary="Kubernetes-Aktualisierungen für Version 1.8">
<caption>Von Ihnen vorgenommene Änderungen nach einer Aktualisierung des Masters auf Kubernetes 1.8</caption>
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
<td>Mit dem Befehl `kubectl delete` werden nicht länger API-Objekte für Arbeitslasten, wie Pods, vor dem Löschen des Objekts nach unten skaliert. Wenn das Objekt nach unten skaliert werden soll, verwenden Sie den Befehl [kubectl scale ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#scale), bevor Sie das Objekt löschen.</td>
</tr>
<tr>
<td>`kubectl run`</td>
<td>Der Befehl `kubectl run` muss anstelle von durch Kommas getrennten Argumenten mehrere Flags für `--env` verwenden. Führen Sie beispielsweise <code>kubectl run --env &lt;x&gt;=&lt;y&gt; --env &lt;z&gt;=&lt;a&gt;</code> und nicht <code>kubectl run --env &lt;x&gt;=&lt;y&gt;,&lt;z&gt;=&lt;a&gt;</code> aus. </td>
</tr>
<tr>
<td>`kubectl stop`</td>
<td>Der Befehl `kubectl stop` ist nicht mehr verfügbar.</td>
</tr>
</tbody>
</table>


## Version 1.7
{: #cs_v17}

<p><img src="images/certified_kubernetes_1x7.png" height="100" width="62.5" style="width:62px; height: 100px; border-style: none; padding-right: 10px;" align="left" alt="Diese Markierung zeigt die Kubernetes Version 1.7-Zertifizierung für IBM Cloud Container Service an."/> {{site.data.keyword.containerlong_notm}} ist ein zertifiziertes Kubernetes-Produkt für Version 1.7 unter dem CNCF Kubernetes Software Conformance Certification Program.</p>

Überprüfen Sie Änderungen, die Sie möglicherweise bei einer Aktualisierung auf Kubernetes Version 1.7 vornehmen müssen.

<br/>

### Vor Master aktualisieren
{: #17_before}

<table summary="Kubernetes-Aktualisierungen für die Versionen 1.7 und 1.6">
<caption>Von Ihnen vorgenommene Änderungen vor einer Aktualisierung des Masters auf Kubernetes 1.7</caption>
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
<caption>Von Ihnen vorgenommene Änderungen nach einer Aktualisierung des Masters auf Kubernetes 1.7</caption>
<thead>
<tr>
<th>Typ</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
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
</tr>
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
</tr>
<tr>
<td>StatefulSet pod DNS</td>
<td>Pods des Typs 'StatefulSet' verlieren nach der Aktualisierung des Masters ihre Kubernetes-DNS-Einträge. Um die DNS-Einträge wiederherzustellen, löschen Sie diese Pods. Kubernetes erstellt die Pods erneut und stellt die DNS-Einträge automatisch wieder her. Weitere Informationen finden Sie im Abschnitt zu dem entsprechenden [Problem in Kubernetes ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/kubernetes/kubernetes/issues/48327).
</tr>
</tbody>
</table>
