---

copyright:
  years: 2014, 2017
lastupdated: "2017-10-24"

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

Die Tabelle enthält die Aktualisierungen, die sich voraussichtlich auf die bereitgestellten Apps auswirken, wenn Sie einen Cluster auf eine neue Version aktualisieren. Im [Kubernetes-Änderungsprotokoll ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG.md) finden Sie eine vollständige Liste der Änderungen, die in den verschiedenen Kubernetes-Versionen vorgenommen wurden.

Weitere Informationen zum Aktualisierungsprozess finden Sie in [Cluster aktualisieren](cs_cluster.html#cs_cluster_update) und [Workerknoten aktualisieren](cs_cluster.html#cs_cluster_worker_update).



## Version 1.7
{: #cs_v17}

### Vor Master aktualisieren
{: #17_before}

<table summary="Kubernetes-Aktualisierungen für die Versionen 1.7 und 1.6">
<caption>Tabelle 1. Vor der Aktualisierung des Masters auf Kubernetes 1.7 durchzuführende Änderungen</caption>
<thead>
<tr>
<th>Typ</th>
<th>Beschreibung
</tr>
</thead>
<tbody>
<tr>
<td>Speicher</td>
<td>Konfigurationsscripts mit den Angaben `hostPath` und `mountPath` und Verweisen auf das übergeordnete Verzeichnis wie beispielsweise `../to/dir` sind nicht zulässig. Ändern Sie die Pfade in einfache absolute Pfade. Beispiel: `/path/to/dir`.
<ol>
  <li>Führen Sie den folgenden Befehl aus, um festzustellen, ob Sie Ihre Speicherpfade aktualisieren müssen.</br>
  ```
  kubectl get pods --all-namespaces -o yaml | grep "\.\." && echo "Action required"
  ```
  </br>

  <li>Wenn vom System die Meldung `Action required` (Aktion erforderlich) zurückgegeben wird, dann müssen Sie jeden betroffenen Pod so ändern, dass auf den absoluten Pfad verwiesen wird, bevor Sie alle Workerknoten aktualisieren. Wenn eine andere Ressource (z. B. eine Bereitstellung) Eigner des Pods ist, müssen Sie die [_PodSpec_ ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/api-reference/v1.7/#podspec-v1-core) in dieser Ressource ändern.
</ol>
</td>
</tr>
</tbody>
</table>

### Nach Master aktualisieren
{: #17_after}

<table summary="Kubernetes-Aktualisierungen für die Versionen 1.7 und 1.6">
<caption>Tabelle 2. Nach der Aktualisierung des Masters auf Kubernetes 1.7 durchzuführende Änderungen</caption>
<thead>
<tr>
<th>Typ</th>
<th>Beschreibung
</tr>
</thead>
<tbod>
<tr>
<td>kubectl</td>
<td>Nachdem Sie die `kubectl`-CLI auf die Version Ihres Clusters aktualisiert haben, müssen in den folgenden `kubectl`-Befehlen anstelle von durch Kommas getrennten Argumenten mehrere Flags verwendet werden.<ul>
 <li>`create role`
 <li>`create clusterrole`
 <li>`create rolebinding`
 <li>`create clusterrolebinding`
 <li>`create secret`
 </ul>
</br>  Führen Sie z. B. `kubectl create role --resource-name <x> --resource-name <y>` und nicht `kubectl create role --resource-name <x>,<y>` aus.</td>
</tr>
<tr>
<td>Affinitätsplanung für Pod</td>
<td> Die Annotation `scheduler.alpha.kubernetes.io/affinity` wird nicht mehr verwendet.
<ol>
  <li>Führen Sie diesen Befehl für jeden Namensbereich mit Ausnahme von `ibm-system` und `kube-system` aus, um festzustellen, ob die Affinitätsplanung für den Pod aktualisiert werden muss.</br>
  ```
  kubectl get pods -n <namensbereich> -o yaml | grep "scheduler.alpha.kubernetes.io/affinity" && echo "Action required"
  ```
  </br>
  <li>Wenn das System die Meldung `"Action required"` (Aktion erforderlich) zurückgibt, dann müssen Sie die betroffenen Pods ändern, um anstelle der Annotation `scheduler.alpha.kubernetes.io/affinity` das Feld _affinity_ der [_PodSpec_ ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/api-reference/v1.7/#podspec-v1-core) zu verwenden.
</ol>
</tr>
<tr>
<td>Netzrichtlinie</td>
<td>Die Annotation `net.beta.kubernetes.io/network-policy` wird nicht mehr unterstützt.
<ol>
  <li>Führen Sie den folgenden Befehl aus, um festzustellen, ob Sie Ihre Netzrichtlinien aktualisieren müssen.</br>
  ```
  kubectl get ns -o yaml | grep "net.beta.kubernetes.io/network-policy" | grep "DefaultDeny" && echo "Action required"
  ```
  <li>Wenn das System die Meldung `Action required` (Aktion erforderlich) zurückgibt, dann müssen Sie die folgende Netzrichtlinie zu jedem Kubernetes-Namensbereich hinzufügen, der aufgelistet wird.</br>

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

  <li> Sobald die Netzrichtlinie ordnungsgemäß implementiert wurde, können Sie die Annotation `net.beta.kubernetes.io/network-policy` entfernen.
  ```
  kubectl annotate ns <namensbereich> --overwrite "net.beta.kubernetes.io/network-policy-"
  ```
  </ol>
</tr>
<tr>
<td>Tolerierungen</td>
<td>Die Annotation `scheduler.alpha.kubernetes.io/tolerations` wird nicht mehr unterstützt.
<ol>
  <li>Führen Sie diesen Befehl für jeden Namensbereich mit Ausnahme von `ibm-system` und `kube-system` aus, um festzustellen, ob die Tolerierungen aktualisiert werden müssen.</br>
  ```
  kubectl get pods -n <namensbereich> -o yaml | grep "scheduler.alpha.kubernetes.io/tolerations" && echo "Action required"
  ```
  </br>

  <li>Wenn das System die Meldung `"Action required"` (Aktion erforderlich) zurückgibt, dann müssen Sie die betroffenen Pods ändern, um anstelle der Annotation `scheduler.alpha.kubernetes.io/tolerations` das Feld _tolerations_ der [_PodSpec_ ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/api-reference/v1.7/#podspec-v1-core) zu verwenden.
</ol>
</tr>
<tr>
<td>Taints</td>
<td>Die Annotation `scheduler.alpha.kubernetes.io/taints` wird nicht mehr unterstützt.
<ol>
  <li>Führen Sie den folgenden Befehl aus, um festzustellen, ob Sie Ihre Taints aktualisieren müssen.</br>
  ```
  kubectl get nodes -o yaml | grep "scheduler.alpha.kubernetes.io/taints" && echo "Action required"
  ```
  <li>Wenn das System die Meldung `"Action required"` (Aktion erforderlich) zurückgibt, dann entfernen Sie die Annotation `scheduler.alpha.kubernetes.io/taints` für jeden Knoten, in dem die nicht unterstützte Annotation verwendet wird.</br>
  `kubectl annotate nodes <node> scheduler.alpha.kubernetes.io/taints-`
  <li>Wenn Sie die nicht unterstützte Annotation entfernen, dann fügen Sie jedem Knoten einen Taint hinzu. Sie benötigen hierbei die Version 1.6 oder höher der `kubectl`-CLI.</br>
  `kubectl taint node <node> <taint>`
  </ol>
</tr>
</tbody>
</table></staging>
