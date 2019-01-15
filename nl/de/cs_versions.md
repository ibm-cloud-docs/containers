---

copyright:
  years: 2014, 2018
lastupdated: "2018-12-06"

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
{:important: .important}
{:deprecated: .deprecated}
{:download: .download}



# Versionsinformationen und Aktualisierungsaktionen
{: #cs_versions}

## Kubernetes-Versionstypen
{: #version_types}

{{site.data.keyword.containerlong}} unterstützt momentan mehrere Versionen von Kubernetes. Wenn die aktuellste Version (n) freigegeben wird, werden bis zu 2 Versionen davor (n-2) unterstützt. Versionen, die mehr als zwei Versionen älter sind, als die aktuellsten Version (n-3) werden zuerst nicht mehr verwendet und dann nicht weiter unterstützt.
{:shortdesc}

**Unterstützte Kubernetes-Versionen**:
- Aktuelle: 1.12.3
- Standard: 1.10.11
- Sonstige: 1.11.5

</br>

**Veraltete Versionen**: Wenn Cluster unter einer veralteten Kubernetes-Version ausgeführt werden, haben Sie 30 Tage Zeit, um eine unterstützte Kubernetes-Version zu überprüfen und auf diese neuere Version zu aktualisieren, bevor die veraltete Version nicht mehr unterstützt wird. Während des Zeitraums der Einstellung der Unterstützung ist Ihr Cluster noch funktionstüchtig, muss jedoch möglicherweise auf ein unterstütztes Release aktualisiert werden, um Sicherheitslücken zu schließen. Sie können keine neuen Cluster erstellen, die die veraltete Version verwenden. 

**Nicht unterstützte Versionen**: Wenn Sie Cluster unter einer Kubernetes-Version ausführen, die nicht unterstützt wird, überprüfen Sie potenzielle Auswirkungen auf die folgenden Updates und [aktualisieren Sie den Cluster](cs_cluster_update.html#update) sofort, damit Sie weiterhin wichtige Sicherheitsupdates und Support erhalten.
*  **Achtung**: Wenn Sie warten, bis Ihr Cluster gegenüber der unterstützten Version drei oder mehr Nebenversionen zurückliegt, müssen Sie die Aktualisierung erzwingen; dies kann zu unerwarteten Ergebnissen oder Fehlern führen.
*  Nicht unterstützte Cluster können keine Workerknoten hinzufügen oder vorhandene Workerknoten erneut laden.
*  Nachdem Sie den Cluster auf eine unterstützte Version aktualisiert haben, kann Ihr Cluster den normalen Betrieb wieder aufnehmen und weiterhin Unterstützung erhalten.

</br>

Führen Sie den folgenden Befehl aus, um die Serverversion eines Clusters zu überprüfen.

```
kubectl version  --short | grep -i server
```
{: pre}

Beispielausgabe:

```
Server Version: v1.10.11+IKS
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

Sobald Aktualisierungen verfügbar sind, werden Sie benachrichtigt, wenn Sie Informationen zu den Workerknoten anzeigen, z. B. mit den Befehlen `ibmcloud ks workers <cluster>` oder `ibmcloud ks worker-get <cluster> <worker>`.
-  **Aktualisierungen von Haupt- und Nebenversionen**: Zuerst [aktualisieren Sie Ihren Masterknoten](cs_cluster_update.html#master) und anschließend [die Workerknoten](cs_cluster_update.html#worker_node).
   - Standardmäßig ist für einen Kubernetes-Master eine Aktualisierung über über drei und mehr Nebenversionen hinweg nicht möglich. Wenn die aktuelle Masterversion beispielsweise 1.9 ist und Sie eine Aktualisierung auf 1.12 durchführen möchten, müssen Sie zunächst auf Version 1.10 aktualisieren. Sie können die gewünschte Aktualisierung zwar erzwingen, jedoch kann eine Aktualisierung über mehr als zwei Nebenversionen hinweg zu nicht erwarteten Ergebnissen oder zu einem Ausfall führen.
   - Wenn Sie eine `kubectl`-CLI-Version verwenden, die nicht wenigstens mit der Version `major.minor` Ihrer Cluster übereinstimmt, kann dies zu unerwarteten Ergebnissen führen. Stellen Sie sicher, dass Ihr Kubernetes-Cluster und die [CLI-Versionen](cs_cli_install.html#kubectl) immer auf dem neuesten Stand sind.
-  **Patchaktualisierungen**: Änderungen für Patches werden im [Änderungsprotokoll der Version](cs_versions_changelog.html) dokumentiert. Sind Aktualisierungen verfügbar, werden Sie benachrichtigt, wenn Sie Informationen zum Masterknoten und den Workerknoten in der {{site.data.keyword.Bluemix_notm}}-Konsole oder -CLI beispielsweise mit den folgenden Befehlen anzeigen: `ibmcloud ks clusters`, `cluster-get`, `workers` oder `worker-get`. 
   - **Patches für Workerknoten**: Überprüfen Sie einmal im Monat, ob eine Aktualisierung verfügbar ist, und führen Sie den [Befehl](cs_cli_reference.html#cs_worker_update) `ibmcloud ks worker-update` oder den [Befehl](cs_cli_reference.html#cs_worker_reload) `ibmcloud ks worker-reload` aus, um diese Sicherheits- und Betriebssystempatches anzuwenden. Beachten Sie, dass von Ihrer Workerknotenmaschine während einer Aktualisierung oder eines Neuladens ein neues Image erstellt wird und dass dabei Daten gelöscht werden, die nicht [außerhalb des Workerknotens gespeichert sind](cs_storage_planning.html#persistent_storage_overview). 
   - **Master-Patches**: Master-Patches werden automatisch über mehrere Tage hinweg angewendet, sodass eine Master-Patch-Version möglicherweise als verfügbar angezeigt wird, bevor sie auf den Master angewendet wird. Die Aktualisierungsautomatisierung überspringt auch Cluster, die sich in einem nicht einwandfreien Zustand befinden oder in denen derzeit Operationen ausgeführt werden. Es kann vorkommen, dass IBM gelegentlich die automatischen Aktualisierungen für ein bestimmtes Master-Fixpack inaktiviert (wie im Änderungsprotokoll vermerkt), zum Beispiel ein Patch, das nur benötigt wird, wenn ein Master von einer Nebenversion auf eine andere Version aktualisiert wird. In allen diesen Fällen können Sie sicher selbst den [Befehl](cs_cli_reference.html#cs_cluster_update) `ibmcloud ks cluster-update` verwenden, ohne auf die Anwendung der automatischen Aktualisierung zu warten.

</br>

Diese Informationen fassen die Aktualisierungen zusammen, die sich voraussichtlich auf die bereitgestellten Apps auswirken, wenn Sie einen Cluster von einer vorherigen Version auf eine neue Version aktualisieren.
-  Version 1.12 [Vorbereitungsaktionen](#cs_v112).
-  Version 1.11 [Vorbereitungsaktionen](#cs_v111).
-  Version 1.10 [Vorbereitungsaktionen](#cs_v110).
-  [Archiv](#k8s_version_archive) veralteter oder nicht unterstützter Versionen.

<br/>

Eine vollständige Liste von Änderungen finden Sie im Rahmen der folgenden Informationen:
* [Kubernetes-Änderungsprotokoll ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG.md).
* [Änderungsprotokoll der IBM Versionen](cs_versions_changelog.html).

</br>

## Version 1.12
{: #cs_v112}

<p><img src="images/certified_kubernetes_1x12.png" style="padding-right: 10px;" align="left" alt="Dieses Flag zeigt die Kubernetes Version 1.9-Zertifizierung für IBM Cloud Container Service an."/> {{site.data.keyword.containerlong_notm}} ist ein zertifiziertes Kubernetes-Produkt für Version 1.12 unter dem CNCF Kubernetes Software Conformance Certification Program. _Kubernetes® ist eine eingetragene Marke von The Linux Foundation in den USA und anderen Ländern und wird entsprechend einer Lizenz von The Linux Foundation verwendet._</p>

Überprüfen Sie Änderungen, die Sie möglicherweise bei einer Aktualisierung von der vorherigen Version auf die Kubernetes-Version 1.12 vornehmen müssen. {: shortdesc}

### Vor Master aktualisieren
{: #112_before}

In der folgenden Tabelle sind die Aktionen aufgeführt, die Sie ausführen müssen, bevor Sie den Kubernetes-Master aktualisieren. {: shortdesc}

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
<td>Wenn derzeit eine `metric-server`-Instanz von Kubernetes in Ihrem Cluster bereitgestellt ist, müssen Sie die `metric-server`-Instanz entfernen, bevor Sie den Cluster auf Kubernetes 1.12 aktualisieren. Durch das Entfernen verhindern Sie Konflikte mit der `metric-server`-Instanz, die während der Aktualisierung bereitgestellt wird. </td>
</tr>
<tr>
<td>Rollenbindungen für das Standardservicekonto (`default`) der `kube-system`-Instanz</td>
<td>Das Standardservicekonto (`default`) der `kube-system`-Instanz hat keinen Clusteradministratorzugriff (**cluster-admin**) mehr auf die Kubernetes API. Wenn Sie Features oder Add-ons wie [Helm](cs_integrations.html#helm) bereitstellen, die Zugriff benötigen, um in Ihrem Cluster arbeiten zu können, richten Sie ein [Servicekonto ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/reference/access-authn-authz/service-accounts-admin/) ein. Wenn Sie mehr Zeit für die Erstellung und Konfiguration einzelner Servicekonten mit den entsprechenden Berechtigungen benötigen, können Sie der Rolle **cluster-admin** die folgende Clusterrollenbindung temporär zuordnen: `kubectl create clusterrolebinding kube-system:default --clusterrole=cluster-admin --serviceaccount=kube-system:default` </td>
</tr>
</tbody>
</table>

### Nach Master aktualisieren
{: #112_after}

In der folgenden Tabelle sind die Aktionen aufgeführt, die Sie ausführen müssen, nachdem Sie den Kubernetes-Master aktualisiert haben. {: shortdesc}

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
<td>Kubernetes-API `apps/v1`</td>
<td>Die Kubernetes-API The `apps/v1` ersetzt die APIs `extensions`, `apps/v1beta1` und `apps/v1alpha`. Das Kubernetes-Projekt wird nicht mehr verwendet und die Unterstützung für frühere APIs des Kubernetes-Clients `apiserver` und `kubectl` wird ausgephast. <br><br>Sie müssen alle Ihre `apiVersion`-YAML-Felder für die Verwendung von `apps/v1` aktualisieren. Überprüfen Sie außerdem die [Kubernetes-Dokumentation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) auf Änderungen im Zusammenhang mit `apps/v1` wie beispielsweise die folgenden.
<ul><li>Nach dem Erstellen einer Bereitstellung ist das Feld `.spec.selector` nicht veränderbar. </li>
<li>Das Feld `.spec.rollbackTo` ist veraltet. Verwenden Sie stattdessen den Befehl `kubectl rollout undo`. </li></ul></td>
</tr>
<tr>
<td>CoreDNS verfügbar als Cluster-DNS-Provider</td>
<td>Das Kubernetes-Projekt wird gerade umgestellt auf die Unterstützung von CoreDNS anstelle von Kubernetes-DNS (KubeDNS). In Version 1.12 ist das standardmäßige Cluster-DNS weiterhin KubeDNS, aber Sie können [auswählen, CoreDNS zu verwenden](cs_cluster_update.html#dns). </td>
</tr>
<tr>
<td>`kubectl apply --force`</td>
<td>Wenn Sie jetzt eine Anwendenaktion (`kubectl apply --force`) für Ressourcen erzwingen, die nicht aktualisiert werden können, z. B. nicht veränderbare Felder in YAML-Dateien, werden die Ressourcen stattdessen erneut erstellt. Wenn Ihre Scripts das bisherige Verhalten erwarten, aktualisieren Sie die Scripts.</td>
</tr>
<tr>
<td>`kubectl logs --interactive`</td>
<td>Das Flag `--interactive` wird für `kubectl logs` nicht länger unterstützt. Aktualisieren Sie jede Automatisierung mit diesem Flag. </td>
</tr>
<tr>
<td>`kubectl patch`</td>
<td>Wenn der Befehl `patch` nicht zu Änderungen führt (ein redundantes Patch), hat der Befehl nicht länger den Rückgabecode `1`. Wenn Ihre Scripts das bisherige Verhalten erwarten, aktualisieren Sie die Scripts.</td>
</tr>
<tr>
<td>`kubectl version -c`</td>
<td>Das Kurzform-Flag `-c` wird nicht länger unterstützt. Verwenden Sie stattdessen das vollständige Flag `--client`. Aktualisieren Sie jede Automatisierung mit diesem Flag. </td>
</tr>
<tr>
<td>`kubectl wait`</td>
<td>Wenn keine übereinstimmenden Selektoren gefunden werden, gibt der Befehl jetzt eine Fehlernachricht aus und wird mit einem Rückgabecode von `1` beendet. Wenn Ihre Scripts das bisherige Verhalten erwarten, aktualisieren Sie die Scripts.</td>
</tr>
<tr>
<td>cAdvisor-Port 'kubelet'</td>
<td>Die [Container Advisor-Webbenutzerschnittstelle (cAdvisor) ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/google/cadvisor), die von 'kubelet' durch das Starten des cAdvisor-Ports (`--cadvisor-port`) verwendet wurde, wird aus Kubernetes 1.12 entfernt. Wenn Sie cAdvisor weiterhin ausführen müssen, [stellen Sie cAdvisor als Dämongruppe ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/google/cadvisor/tree/master/deploy/kubernetes) bereit. <br><br>Geben Sie in der Dämongruppe den Bereich 'Ports' an, damit cAdvisor über `http://node-ip:4194` wie folgt erreicht werden kann. Beachten Sie, dass die cAdvisor-Pods fehlschlagen, bis die Workerknoten auf 1.12 aktualisiert werden, da frühere Versionen von kubelet den Host-Port 4194 für cAdvisor verwenden. <pre class="screen"><code>ports:
          - name: http
            containerPort: 8080
            hostPort: 4194
            protocol: TCP</code></pre></td>
</tr>
<tr>
<td>Kubernetes-Dashboard</td>
<td>Wenn Sie über `kubectl proxy` auf das Dashboard zugreifen, wird die Schaltfläche zum Überspringen (**SKIP**) von der Anmeldeseite entfernt. Verwenden Sie stattdessen ein **Token** für die Anmeldung. </td>
</tr>
<tr>
<td id="metrics-server">Kubernetes-Metrik-Server</td>
<td>Der Kubernetes-Metrik-Server ersetzt den Kubernetes-Heapster (veraltet seit Kubernetes-Version 1.8) als Cluster-Metrik-Provider. Wenn in Ihrem Cluster mehr als 30 Pods ausgeführt werden, [passen Sie die Konfiguration von `metrics-server` für eine bessere Leistung an](cs_performance.html#metrics).
<p>Das Kubernetes-Dashboard funktioniert nicht mit `metrics-server`. Wenn Sie Metriken in einem Dashboard anzeigen möchten, wählen Sie eine der folgenden Optionen aus. </p>
<ul><li>[Konfigurieren Sie Grafana, um Metriken zu analysieren](/docs/services/cloud-monitoring/tutorials/container_service_metrics.html#container_service_metrics), indem Sie das Clusterüberwachungsdashboard verwenden. </li>
<li>Implementieren Sie [Heapster ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/kubernetes/heapster) in Ihrem Cluster.
<ol><li>Kopieren Sie die `heapster-rbac`-[YAML- ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/kubernetes/kubernetes/blob/release-1.12/cluster/addons/cluster-monitoring/heapster-rbac.yaml), `heapster-service`-[YAML- ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/kubernetes/kubernetes/blob/release-1.12/cluster/addons/cluster-monitoring/standalone/heapster-service.yaml) und `heapster-controller`-[YAML-Dateien ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/kubernetes/kubernetes/blob/release-1.12/cluster/addons/cluster-monitoring/standalone/heapster-controller.yaml). </li>
<li>Bearbeiten Sie die `heapster-controller`-YAML, indem Sie die folgenden Zeichenfolgen ersetzen.
<ul><li>Ersetzen Sie `{{ nanny_memory }}` durch `90Mi`. </li>
<li>Ersetzen Sie `{{ base_metrics_cpu }}` durch `80m`. </li>
<li>Ersetzen Sie `{{ metrics_cpu_per_node }}` durch `0.5m`. </li>
<li>Ersetzen Sie `{{ base_metrics_memory }}` durch `140Mi`. </li>
<li>Ersetzen Sie `{{ metrics_memory_per_node }}` durch `4Mi`. </li>
<li>Ersetzen Sie `{{ heapster_min_cluster_size }}` durch `16`. </li></ul></li>
<li>Wenden Sie die YAML-Dateien `heapster-rbac`, `heapster-service` und `heapster-controller` auf Ihren Cluster an, indem Sie den Befehl `kubectl apply -f` ausführen. </li></ol></li></ul></td>
</tr>
<tr>
<td>Kubernetes-API `rbac.authorization.k8s.io/v1`</td>
<td>Die Kubernetes-API `rbac.authorization.k8s.io/v1` (unterstützt seit Kubernetes 1.8) ersetzt die APIs `rbac.authorization.k8s.io/v1alpha1` und `rbac.authorization.k8s.io/v1beta1`. Sie können keine RBAC-Objekte wie Rollen oder Rollenbindungen mehr mit der nicht unterstützten API `v1alpha` erstellen. Vorhandene RBAC-Objekte werden zur API `v1` konvertiert. </td>
</tr>
</tbody>
</table>

## Version 1.11
{: #cs_v111}

<p><img src="images/certified_kubernetes_1x11.png" style="padding-right: 10px;" align="left" alt="Dieses Flag zeigt die Kubernetes Version 1.11-Zertifizierung für IBM Cloud Container Service an."/> {{site.data.keyword.containerlong_notm}} ist ein zertifiziertes Kubernetes-Produkt für Version 1.11 unter dem CNCF Kubernetes Software Conformance Certification Program. _Kubernetes® ist eine eingetragene Marke von The Linux Foundation in den USA und anderen Ländern und wird entsprechend einer Lizenz von The Linux Foundation verwendet._</p>

Überprüfen Sie Änderungen, die Sie möglicherweise bei einer Aktualisierung von der vorherigen Version auf die Kubernetes-Version 1.11 vornehmen müssen.
{: shortdesc}

Bevor Sie einen Cluster erfolgreich von Kubernetes Version 1.9 oder einer früheren Version auf Version 1.11 aktualisieren können, müssen Sie zunächst die im Abschnitt zu den [Vorbereitungen zur Aktualisierung auf Calico Version 3](#111_calicov3) aufgeführten Schritte durchführen. {: important}

### Vor Master aktualisieren
{: #111_before}

In der folgenden Tabelle sind die Aktionen aufgeführt, die Sie ausführen müssen, bevor Sie den Kubernetes-Master aktualisieren. {: shortdesc}

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
<td>Die Cluster-Master-Konfiguration wurde aktualisiert, um die Hochverfügbarkeit zu erhöhen. Cluster haben jetzt drei Kubernetes-Masterreplikate, die für jeden Master konfiguriert werden, der auf einem separaten physischen Host bereitgestellt wird. Und wenn sich Ihr Cluster in einer Zone mit mehreren Zonen befindet, werden die Master über Zonen verteilt. <br><br>Informationen zu den Aktionen, die Sie ausführen müssen, finden Sie unter [Aktualisierung auf hoch verfügbare Cluster-Master](#ha-masters). Diese Vorbereitungsaktionen finden Anwendung: <ul>
<li>Wenn Sie über eine Firewall oder über angepasste Calico-Netzrichtlinien verfügen. </li>
<li>Wenn Sie die Host-Ports `2040` oder `2041` auf Ihren Workerknoten verwenden. </li>
<li>Wenn Sie die IP-Adresse des Cluster-Masters für den clusterinternen Zugriff auf den Master verwendet haben. </li>
<li>Wenn eine Automatisierung vorhanden ist, die die Calico-API oder -CLI (`calicoctl`) aufruft, z. B. um Calico-Richtlinien zu erstellen. </li>
<li>Wenn Sie Kubernetes- oder Calico-Netzrichtlinien zum Steuern des Pod-Egress-Zugriffs auf den Master verwenden. </li></ul></td>
</tr>
<tr>
<td>`containerd` - neue Kubernetes-Containerlaufzeit</td>
<td><p class="important">`containerd` ersetzt Docker als neue Containerlaufzeit für Kubernetes. Informationen zu den Aktionen, die Sie ausführen müssen, finden Sie unter [Aktualisieren auf `containerd` als Containerlaufzeit](#containerd). </p></td>
</tr>
<tr>
<td>Verschlüsseln von Daten in 'etcd'</td>
<td>Bisher wurden 'etcd'-Daten in der NFS-Dateispeicherinstanz eines Masters gespeichert, in der ruhende Daten verschlüsselt werden. Jetzt werden 'etcd'-Daten auf der lokalen Platte des Masters gespeichert und in {{site.data.keyword.cos_full_notm}} gesichert. Daten werden während des Transits an {{site.data.keyword.cos_full_notm}} verschlüsselt und wenn sie ruhen. Die 'etcd'-Daten auf der lokalen Platte des Masters sind jedoch nicht verschlüsselt. Wenn die lokalen 'etcd'-Daten Ihres Masters verschlüsselt werden sollen, [aktivieren Sie {{site.data.keyword.keymanagementservicelong_notm}} in Ihrem Cluster](cs_encrypt.html#keyprotect). </td>
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

In der folgenden Tabelle sind die Aktionen aufgeführt, die Sie ausführen müssen, nachdem Sie den Kubernetes-Master aktualisiert haben. {: shortdesc}

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
<td>Aktualisierung der Kubernetes-Konfiguration</td>
<td>Die OpenID Connect-Konfiguration für den Kubernetes-API-Server des Clusters wurde zur Unterstützung von {{site.data.keyword.Bluemix_notm}} Identity and Access Management-Zugriffsgruppen aktualisiert. Folglich müssen Sie die Kubernetes-Konfiguration Ihres Clusters nach der Masteraktualisierung auf Kubernetes Version 1.11 aktualisieren, indem Sie folgenden Befehl ausführen: `ibmcloud ks cluster-config --cluster <clustername_oder_-id>`. <br><br>Wenn Sie die Konfiguration nicht aktualisieren, schlagen die Clusteraktionen mit der folgenden Fehlernachricht fehl: `You must be logged in to the server (Unauthorized).`</td>
</tr>
<tr>
<td>`kubectl` CLI</td>
<td>Für die `kubectl`-CLI für Kubernetes Version 1.11 sind die `apps/v1`-APIs erforderlich. Version 1.11 der `kubectl`-CLI funktioniert daher nicht für Cluster, auf denen Kubernetes Version 1.8 oder früher ausgeführt wird. Verwenden Sie die Version der `kubectl`-CLI, die mit der Version des Kubernetes-API-Servers Ihres Clusters übereinstimmt.</td>
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

Für Cluster mit Kubernetes-Version [1.10.8_1530](#110_ha-masters), 1.11.3_1531 oder höher wird die Konfiguration des Cluster-Masters aktualisiert, um die Hochverfügbarkeit zu erhöhen. Cluster haben jetzt drei Kubernetes-Masterreplikate, die für jeden Master konfiguriert werden, der auf einem separaten physischen Host bereitgestellt wird. Und wenn sich Ihr Cluster in einer Zone mit mehreren Zonen befindet, werden die Master über Zonen verteilt. {: shortdesc}

Wenn Sie Ihren Cluster von Version 1.9 oder einem früheren Patch von 1.10 oder 1.11 auf diese Kubernetes-Version aktualisieren, müssen Sie diese Vorbereitungsschritte ausführen. Damit Sie dafür etwas mehr Zeit haben, werden automatische Aktualisierungen des Masters vorübergehend inaktiviert. Weitere Informationen und den Zeitplan finden Sie im [Blogbeitrag zu Hochverfügbarkeit des Masters](https://www.ibm.com/blogs/bluemix/2018/10/increased-availability-with-ha-masters-in-the-kubernetes-service-actions-you-must-take/).
{: tip}

In den folgenden Situationen müssen Sie Änderungen vornehmen, um die Hochverfügbarkeitskonfiguration des Masters uneingeschränkt nutzen zu können. 
* Wenn Sie über eine Firewall oder über angepasste Calico-Netzrichtlinien verfügen. 
* Wenn Sie die Host-Ports `2040` oder `2041` auf Ihren Workerknoten verwenden. 
* Wenn Sie die IP-Adresse des Cluster-Masters für den clusterinternen Zugriff auf den Master verwendet haben. 
* Wenn eine Automatisierung vorhanden ist, die die Calico-API oder -CLI (`calicoctl`) aufruft, z. B. um Calico-Richtlinien zu erstellen. 
* Wenn Sie Kubernetes- oder Calico-Netzrichtlinien zum Steuern des Pod-Egress-Zugriffs auf den Master verwenden. 

<br>
**Aktualisieren Ihrer Firewall oder Ihrer angepassten Netzrichtlinien des Calico-Hosts für Hochverfügbarkeits-Master**:</br>
{: #ha-firewall}
Wenn Sie eine Firewall oder angepasste Calico-Host-Netzrichtlinien verwenden, um den ausgehenden Netzverkehr (Egress) von Ihren Workerknoten zu steuern, lassen Sie ausgehenden Datenverkehr zu den Ports und IP-Adressen für alle Zonen in der Region zu, in der sich Ihr Cluster befindet. Siehe [Zugriff des Clusters auf Infrastrukturressourcen und andere Services ermöglichen](cs_firewall.html#firewall_outbound).

<br>
**Reservieren von Host-Ports `2040` und `2041` auf Ihren Workerknoten**:</br>
{: #ha-ports}
Um Zugriff auf den Cluster-Master in einer Hochverfügbarkeitskonfiguration zuzulassen, müssen die Host-Ports `2040` und `2041` auf allen Workerknoten verfügbar bleiben. 
* Aktualisieren Sie alle Pods, für die `hostPort` auf `2040` oder auf `2041` gesetzt ist, um andere Ports zu verwenden. 
* Aktualisieren Sie alle Pods, für die `hostNetwork` auf `true` gesetzt ist und die am Port `2040` oder `2041` empfangsbereit sind, um andere Ports zu verwenden. 

Wenn Sie prüfen möchten, ob Ihre Pods derzeit den Port `2040` oder `2041` verwenden, wählen Sie Ihren Cluster als Ziel aus und setzen Sie den folgenden Befehl ab. 

```
kubectl get pods --all-namespaces -o yaml | grep "hostPort: 204[0,1]"
```
{: pre}

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

Verwenden Sie stattdessen die Daten, die in der Konfigurationszuordnung `cluster-info` im Namensbereich `kube-system` gespeichert sind. Verwenden Sie insbesondere die Werte `etcd_host` und `etcd_port`, um den Endpunkt für die [Calico-CLI](cs_network_policy.html#cli_install) für den clusterexternen Zugriff auf den Master mit Hochverfügbarkeitskonfiguration zu konfigurieren. 

<br>
**Aktualisieren von Kubernetes- oder Calico-Netzrichtlinien**:</br>
{: #ha-networkpolicies}
Sie müssen zusätzliche Aktionen ausführen, wenn Sie [Kubernetes- oder Calico-Netzrichtlinien](cs_network_policy.html#network_policies) zum Steuern des Pod-Egress-Zugriffs auf den Cluster-Master einsetzen möchten und momentan Folgendes verwenden: 
*  Die Kubernetes-Service-Cluster-IP, die Sie mit dem Befehl `kubectl get service kubernetes -o yaml | grep clusterIP` abrufen können. 
*  Den Kubernetes-Servicedomänennamen, der standardmäßig `https://kubernetes.default.svc.cluster.local` lautet. 
*  Die Cluster-Master-IP, die Sie mit dem Befehl `kubectl cluster-info | grep Kubernetes` abrufen können. 

In den folgenden Schritten wird beschrieben, wie Sie Ihre Kubernetes-Netzrichtlinien aktualisieren. Um die Netzrichtlinien von Calico zu aktualisieren, wiederholen Sie diese Schritte mit einigen kleineren Richtliniensyntaxänderungen und `calicoctl`, um Richtlinien nach Auswirkungen zu durchsuchen. {: note}

Vorbereitende Schritte: [Melden Sie sich an Ihrem Konto an. Geben Sie als Ziel die entsprechende Region und - sofern anwendbar - die Ressourcengruppe an. Legen Sie den Kontext für den Cluster fest.](cs_cli_install.html#cs_cli_configure)

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
    apiVersion: extensions/v1beta1
    kind: NetworkPolicy
    metadata:
      name: all-master-egress
      namespace: default
    spec:
      egress:
      # Zugriff auf Cluster-Master mithilfe von Kubernetes-Service-Cluster-IP-Adresse
      # oder Domänenname oder Cluster-Master-IP-Adresse zulassen.
      - ports:
        - protocol: TCP
        to:
        - ipBlock:
            cidr: 161.202.126.210/32
      # Zugriff auf Kubernetes-DNS zulassen, um den Kubernetes-Service-
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

    Wenn Sie zuvor Ihre Richtlinien für ausgehenden Netzverkehr so konfiguriert haben, dass nur eine einzelne IP-Adresse und ein einzelner Port für den einzelnen Kubernetes-Master geöffnet sind, verwenden Sie jetzt den clusterinternen IP-Adressbereich '172.20.0.1/32' und den Port '2040' des Master-Proxy. {: tip}

    ```
    apiVersion: extensions/v1beta1
    kind: NetworkPolicy
    metadata:
      name: all-master-egress
      namespace: default
    spec:
      egress:
      # Zugriff auf Cluster-Master mithilfe von Kubernetes-Service-Cluster-IP-Adresse
      # oder Domänenname zulassen.
      - ports:
        - protocol: TCP
        to:
        - ipBlock:
            cidr: 172.20.0.1/32
        - ipBlock:
            cidr: 161.202.126.210/32
      # Zugriff auf Kubernetes-DNS zulassen, um den Kubernetes-Service-Domänennamen aufzulösen. 
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

6.  Nachdem Sie alle [Vorbereitungsaktionen](#ha-masters) (einschließlich dieser Schritte) ausgeführt haben, [aktualisieren Sie Ihren Cluster-Master](cs_cluster_update.html#master) auf das Fixpack für den Hochverfügbarkeitsmaster. 

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
   - Ihr Protokollierungstool verwendet unter Umständen das Verzeichnis `/var/log/pods/<pod_uuid>/<container_name>/*.log` des Containers `stderr/stdout`, um auf Protokolle zuzugreifen. In Docker ist dieses Verzeichnis eine symbolische Verbindung zu `/var/data/cripersistentstorage/containers/<container_uuid>/<container_uuid>-json.log`, während Sie in `containerd` direkt, ohne eine symbolische Verbindung, auf das Verzeichnis zugreifen. 
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

Wenn Sie für einen Cluster eine Aktualisierung von Kubernetes Version 1.10 auf Version 1.11 durchführen, überspringen Sie diese Schritte, weil Sie diese Schritte bereits ausgeführt haben, als Sie die Aktualisierung auf Version 1.10 durchgeführt haben.{: note}

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
    2.  Wenn der Zustand des Workerknotens nicht **Normal** lautet, befolgen Sie die Schritte zum [Debuggen von Workerknoten](cs_troubleshoot.html#debug_worker_nodes). Der Zustand **Kritisch** oder **Unbekannt** lässt sich häufig auflösen, indem Sie [den Workerknoten neu laden](cs_cli_reference.html#cs_worker_reload). 

3.  Wenn Sie Calico-Richtlinien oder andere Calico-Ressourcen automatisch generieren, aktualisieren Sie Ihre Automatisierungstools, um diese Ressourcen mit der [Calico Version 3-Syntax ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://docs.projectcalico.org/v3.1/reference/calicoctl/resources/) zu generieren. 

4.  Wenn Sie [strongSwan](cs_vpn.html#vpn-setup) für die VPN-Konnektivität verwenden, funktioniert das strongSwan 2.0.0-Helm-Diagramm nicht mit Calico Version 3 oder Kubernetes 1.11. [Aktualisieren Sie strongSwan](cs_vpn.html#vpn_upgrade) auf das 2.1.0-Helm-Diagramm, das abwärtskompatibel mit Calico 2.6 und Kubernetes 1.7, 1.8 und 1.9 ist.

5.  [Aktualisieren Sie den Cluster-Master auf Kubernetes Version 1.11](cs_cluster_update.html#master).

<br />


## Version 1.10
{: #cs_v110}

<p><img src="images/certified_kubernetes_1x10.png" style="padding-right: 10px;" align="left" alt="Dieses Flag zeigt die Kubernetes Version 1.10-Zertifizierung für IBM Cloud Container Service an."/> {{site.data.keyword.containerlong_notm}} ist ein zertifiziertes Kubernetes-Produkt für Version 1.10 unter dem CNCF Kubernetes Software Conformance Certification Program. _Kubernetes® ist eine eingetragene Marke von The Linux Foundation in den USA und anderen Ländern und wird entsprechend einer Lizenz von The Linux Foundation verwendet._</p>

Überprüfen Sie Änderungen, die Sie möglicherweise bei einer Aktualisierung von der vorherigen Version auf die Kubernetes-Version 1.10 vornehmen müssen.
{: shortdesc}

Bevor Sie eine erfolgreiche Aktualisierung auf Kubernetes 1.10 vornehmen können, müssen Sie zunächst die im Abschnitt mit den [Vorbereitungen zur Aktualisierung auf Calico Version 3](#110_calicov3) aufgeführten Schritte durchführen. {: important}

<br/>

### Vor Master aktualisieren
{: #110_before}

In der folgenden Tabelle sind die Aktionen aufgeführt, die Sie ausführen müssen, bevor Sie den Kubernetes-Master aktualisieren. {: shortdesc}

<table summary="Kubernetes-Aktualisierungen für Version 1.10">
<caption>Vorzunehmende Änderungen vor der Aktualisierung des Masters auf Kubernetes 1.10</caption>
<thead>
<tr>
<th>Typ</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico Version 3</td>
<td>Bei einer Aktualisierung auf Kubernetes Version 1.10 wird auch Calico von Version 2.6.5 auf Version 3.1.1 aktualisiert. <strong>Wichtig</strong>: Bevor Sie eine erfolgreiche Aktualisierung auf Kubernetes 1.10 vornehmen können, müssen Sie zunächst die im Abschnitt mit den [Vorbereitungen zur Aktualisierung auf Calico Version 3](#110_calicov3) aufgeführten Schritte durchführen.</td>
</tr>
<tr>
<td>Konfiguration der Hochverfügbarkeit des Cluster-Masters</td>
<td>Die Cluster-Master-Konfiguration wurde aktualisiert, um die Hochverfügbarkeit zu erhöhen. Cluster haben jetzt drei Kubernetes-Masterreplikate, die für jeden Master konfiguriert werden, der auf einem separaten physischen Host bereitgestellt wird. Und wenn sich Ihr Cluster in einer Zone mit mehreren Zonen befindet, werden die Master über Zonen verteilt. <br><br>Informationen zu den Aktionen, die Sie ausführen müssen, finden Sie unter [Aktualisierung auf hoch verfügbare Cluster-Master](#110_ha-masters). Diese Vorbereitungsaktionen finden Anwendung: <ul>
<li>Wenn Sie über eine Firewall oder über angepasste Calico-Netzrichtlinien verfügen. </li>
<li>Wenn Sie die Host-Ports `2040` oder `2041` auf Ihren Workerknoten verwenden. </li>
<li>Wenn Sie die IP-Adresse des Cluster-Masters für den clusterinternen Zugriff auf den Master verwendet haben. </li>
<li>Wenn eine Automatisierung vorhanden ist, die die Calico-API oder -CLI (`calicoctl`) aufruft, z. B. um Calico-Richtlinien zu erstellen. </li>
<li>Wenn Sie Kubernetes- oder Calico-Netzrichtlinien zum Steuern des Pod-Egress-Zugriffs auf den Master verwenden. </li></ul></td>
</tr>
<tr>
<td>Netzrichtlinie für das Kubernetes-Dashboard</td>
<td>In Kubernetes 1.10 blockiert die Netzrichtlinie <code>kubernetes-dashboard</code> im Namensbereich <code>kube-system</code> für alle Pods den Zugriff auf das Kubernetes-Dashboard. Dies hat jedoch <strong>keinerlei</strong> Auswirkungen auf den möglichen Zugriff auf das Dashboard über die {{site.data.keyword.Bluemix_notm}}-Konsole oder mithilfe von <code>kubectl proxy</code>. Wenn ein Pod Zugriff auf das Dashboard benötigt, können Sie einem Namensbereich die Bezeichnung <code>kubernetes-dashboard-policy: allow</code> hinzufügen und anschließend den Pod für den Namensbereich bereitstellen.</td>
</tr>
<tr>
<td>Kubelet-API-Zugriff</td>
<td>Die Kubelet-API-Autorisierung wird jetzt an den <code>Kubernetes-API-Server</code> delegiert. Der Zugriff auf die Kubelet-API basiert auf Clusterrollen (<code>ClusterRoles</code>), die die Berechtigung zum Zugriff auf <strong>Knoten</strong>-Unterressourcen einräumen. Standardmäßig verfügt Kubernetes Heapster über <code>ClusterRole</code> und <code>ClusterRoleBinding</code>. Wenn die Kubelet-API von anderen Benutzern oder Apps verwendet wird, müssen Sie diesen die Berechtigung für die Verwendung der API einräumen. Weitere Informationen zur [Kubelet-Autorisierung ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet-authentication-authorization/) finden Sie in der Kubernetes-Dokumentation.</td>
</tr>
<tr>
<td>Cipher-Suites</td>
<td>Die unterstützten Cipher-Suites für den <code>Kubernetes-API-Server</code> und die Kubelet-API sind nun auf eine Teilmenge mit einer starken Verschlüsselung (128 Bit oder höher) begrenzt. Wenn Sie über eine bestehende Automatisierung oder bestehende Ressourcen verfügen, die eine schwächere Verschlüsselung verwenden und auf die Kommunikation mit dem <code>Kubernetes-API-Server</code> oder der Kubelet-API angewiesen sind, aktivieren Sie eine stärkere Verschlüsselungsunterstützung, bevor Sie den Master aktualisieren.</td>
</tr>
<tr>
<td>strongSwan-VPN</td>
<td>Wenn Sie für die VPN-Konnektivität [strongSwan](cs_vpn.html#vpn-setup) verwenden, müssen Sie das Diagramm vor Aktualisieren des Clusters entfernen, indem Sie den Befehl `helm delete -- purge <release_name>` ausführen. Wenn die Clusteraktualisierung abgeschlossen ist, installieren Sie das StrongSwan-Helm-Diagramm erneut.</td>
</tr>
</tbody>
</table>

### Nach Master aktualisieren
{: #110_after}

In der folgenden Tabelle sind die Aktionen aufgeführt, die Sie ausführen müssen, nachdem Sie den Kubernetes-Master aktualisiert haben. {: shortdesc}

<table summary="Kubernetes-Aktualisierungen für Version 1.10">
<caption>Vorzunehmende Änderungen nach der Aktualisierung des Masters auf Kubernetes 1.10</caption>
<thead>
<tr>
<th>Typ</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico Version 3</td>
<td>Bei einer Aktualisierung des Clusters werden alle vorhandenen Calico-Daten, die auf den Cluster angewendet werden, automatisch für die Verwendung der Calico Version 3-Syntax migriert. Um Calico-Ressourcen mit der Calico Version 3-Syntax anzuzeigen, hinzuzufügen oder zu ändern, aktualisieren Sie Ihre [Calico-CLI-Konfiguration auf Version 3.1.1](#110_calicov3).</td>
</tr>
<tr>
<td>Externe IP-Adresse (<code>ExternalIP</code>) des Knotens</td>
<td>Das Feld <code>ExternalIP</code> eines Knotens ist jetzt auf den Wert der öffentlichen IP-Adresse des Knotens festgelegt. Überprüfen und aktualisieren Sie alle Ressourcen, die von diesem Wert abhängen.</td>
</tr>
<tr>
<td><code>kubectl port-forward</code></td>
<td>Wenn Sie jetzt den Befehl <code>kubectl port-forward</code> verwenden, wird das Flag <code>-p</code> nicht weiter unterstützt. Wenn Ihre Scripts das bisherige Verhalten erwarten, aktualisieren Sie die Scripts und ersetzen Sie das Flag <code>-p</code> durch den Podnamen.</td>
</tr>
<tr>
<td>Flag `kubectl --show-all, -a`</td>
<td>Das Flag `--show-all, -a`, das nur für lesbare Pod-Befehle verfügbar (nicht API-Aufrufe) war, ist veraltet und wird in zukünftigen Versionen nicht mehr unterstützt. Das Flag wird verwendet, um Pods in einem terminalen Zustand anzuzeigen. Zum Verfolgen von Informationen zu beendeten Apps und Containern [richten Sie eine Protokollweiterleitung in Ihrem Cluster ein](cs_health.html#health). </td>
</tr>
<tr>
<td>Schreibgeschützte API-Datenträger</td>
<td>`secret`, `configMap`, `downwardAPI` und projizierte Datenträger werden jetzt nur schreibgeschützt angehängt.
Früher durften Apps Daten auf diese Datenträger schreiben, die vom System möglicherweise nicht automatisch zurückgesetzt werden. Diese Änderung ist erforderlich,
um die Sicherheitslücke [CVE-2017-1002102![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2017-1002102) zu schließen.
Wenn Ihre Apps das bisherige unsichere Verhalten erwarten, ändern Sie sie entsprechend.</td>
</tr>
<tr>
<td>strongSwan-VPN</td>
<td>Wenn Sie für die VPN-Konnektivität [strongSwan](cs_vpn.html#vpn-setup) verwenden und Ihr Diagramm vor dem Aktualisieren Ihres Clusters gelöscht haben, können Sie Ihr StrongSwan-Helm-Diagramm nun erneut installieren.</td>
</tr>
</tbody>
</table>

### Aktualisierung auf hoch verfügbare Cluster-Master in Kubernetes 1.10
{: #110_ha-masters}

Für Cluster mit Kubernetes-Version 1.10.8_1530, [1.11.3_1531](#ha-masters) oder höher wird die Konfiguration des Cluster-Masters aktualisiert, um die Hochverfügbarkeit zu erhöhen. Cluster haben jetzt drei Kubernetes-Masterreplikate, die für jeden Master konfiguriert werden, der auf einem separaten physischen Host bereitgestellt wird. Und wenn sich Ihr Cluster in einer Zone mit mehreren Zonen befindet, werden die Master über Zonen verteilt. {: shortdesc}

Wenn Sie Ihren Cluster von Version 1.9 oder einem früheren Patch von 1.10 auf diese Kubernetes-Version aktualisieren, müssen Sie diese Vorbereitungsschritte ausführen. Damit Sie dafür etwas mehr Zeit haben, werden automatische Aktualisierungen des Masters vorübergehend inaktiviert. Weitere Informationen und den Zeitplan finden Sie im [Blogbeitrag zu Hochverfügbarkeit des Masters](https://www.ibm.com/blogs/bluemix/2018/10/increased-availability-with-ha-masters-in-the-kubernetes-service-actions-you-must-take/).
{: tip}

In den folgenden Situationen müssen Sie Änderungen vornehmen, um die Hochverfügbarkeitskonfiguration des Masters uneingeschränkt nutzen zu können. 
* Wenn Sie über eine Firewall oder über angepasste Calico-Netzrichtlinien verfügen. 
* Wenn Sie die Host-Ports `2040` oder `2041` auf Ihren Workerknoten verwenden. 
* Wenn Sie die IP-Adresse des Cluster-Masters für den clusterinternen Zugriff auf den Master verwendet haben. 
* Wenn eine Automatisierung vorhanden ist, die die Calico-API oder -CLI (`calicoctl`) aufruft, z. B. um Calico-Richtlinien zu erstellen. 
* Wenn Sie Kubernetes- oder Calico-Netzrichtlinien zum Steuern des Pod-Egress-Zugriffs auf den Master verwenden. 

<br>
**Aktualisieren Ihrer Firewall oder Ihrer angepassten Netzrichtlinien des Calico-Hosts für Hochverfügbarkeits-Master**:</br>
{: #110_ha-firewall}
Wenn Sie eine Firewall oder angepasste Calico-Host-Netzrichtlinien verwenden, um den ausgehenden Netzverkehr (Egress) von Ihren Workerknoten zu steuern, lassen Sie ausgehenden Datenverkehr zu den Ports und IP-Adressen für alle Zonen in der Region zu, in der sich Ihr Cluster befindet. Siehe [Zugriff des Clusters auf Infrastrukturressourcen und andere Services ermöglichen](cs_firewall.html#firewall_outbound).

<br>
**Reservieren von Host-Ports `2040` und `2041` auf Ihren Workerknoten**:</br>
{: #110_ha-ports}
Um Zugriff auf den Cluster-Master in einer Hochverfügbarkeitskonfiguration zuzulassen, müssen die Host-Ports `2040` und `2041` auf allen Workerknoten verfügbar bleiben. 
* Aktualisieren Sie alle Pods, für die `hostPort` auf `2040` oder auf `2041` gesetzt ist, um andere Ports zu verwenden. 
* Aktualisieren Sie alle Pods, für die `hostNetwork` auf `true` gesetzt ist und die am Port `2040` oder `2041` empfangsbereit sind, um andere Ports zu verwenden. 

Wenn Sie prüfen möchten, ob Ihre Pods derzeit den Port `2040` oder `2041` verwenden, wählen Sie Ihren Cluster als Ziel aus und setzen Sie den folgenden Befehl ab. 

```
kubectl get pods --all-namespaces -o yaml | grep "hostPort: 204[0,1]"
```
{: pre}

<br>
**Verwenden der `kubernetes`-Service-Cluster-IP oder -Domäne für den clusterinternen Zugriff auf den Master**:</br>
{: #110_ha-incluster}
Wählen Sie eine der folgenden Möglichkeiten, um von innerhalb des Clusters auf den Cluster-Master in einer Hochverfügbarkeitskonfiguration zuzugreifen: 
* Die `kubernetes`-Service-Cluster-IP-Adresse, die standardmäßig `https://172.21.0.1` lautet. 
* Der `kubernetes`-Servicedomänenname, der standardmäßig `https://kubernetes.default.svc.cluster.local` lautet. 

Wenn Sie die Cluster-Master-IP-Adresse bereits verwendet haben, funktioniert diese Methode weiterhin. Für eine höhere Verfügbarkeit können Sie diese Einstellung jedoch aktualisieren und die `kubernetes`-Service-Cluster-IP-Adresse oder den entsprechenden Domänennamen verwenden. 

<br>
**Konfigurieren von Calico für clusterexternen Zugriff auf den Master mit Hochverfügbarkeitskonfiguration**:</br>
{: #110_ha-outofcluster}
Die Daten, die in der Konfigurationszuordnung `calico-config` im Namensbereich `kube-system` gespeichert sind, werden geändert, um die Hochverfügbarkeitskonfiguration des Masters zu unterstützen. Insbesondere der Wert `etcd_endpoints` unterstützt jetzt nur clusterinternen Zugriff. Sie können diesen Wert nicht mehr verwenden, um die Calico-CLI für den Zugriff von außerhalb des Clusters zu konfigurieren. 

Verwenden Sie stattdessen die Daten, die in der Konfigurationszuordnung `cluster-info` im Namensbereich `kube-system` gespeichert sind. Verwenden Sie insbesondere die Werte `etcd_host` und `etcd_port`, um den Endpunkt für die [Calico-CLI](cs_network_policy.html#cli_install) für den clusterexternen Zugriff auf den Master mit Hochverfügbarkeitskonfiguration zu konfigurieren. 

<br>
**Aktualisieren von Kubernetes- oder Calico-Netzrichtlinien**:</br>
{: #110_ha-networkpolicies}
Sie müssen zusätzliche Aktionen ausführen, wenn Sie [Kubernetes- oder Calico-Netzrichtlinien](cs_network_policy.html#network_policies) zum Steuern des Pod-Egress-Zugriffs auf den Cluster-Master einsetzen möchten und momentan Folgendes verwenden: 
*  Die Kubernetes-Service-Cluster-IP, die Sie mit dem Befehl `kubectl get service kubernetes -o yaml | grep clusterIP` abrufen können. 
*  Den Kubernetes-Servicedomänennamen, der standardmäßig `https://kubernetes.default.svc.cluster.local` lautet. 
*  Die Cluster-Master-IP, die Sie mit dem Befehl `kubectl cluster-info | grep Kubernetes` abrufen können. 

In den folgenden Schritten wird beschrieben, wie Sie Ihre Kubernetes-Netzrichtlinien aktualisieren. Um die Netzrichtlinien von Calico zu aktualisieren, wiederholen Sie diese Schritte mit einigen kleineren Richtliniensyntaxänderungen und `calicoctl`, um Richtlinien nach Auswirkungen zu durchsuchen. {: note}

Vorbereitende Schritte: [Melden Sie sich an Ihrem Konto an. Geben Sie als Ziel die entsprechende Region und - sofern anwendbar - die Ressourcengruppe an. Legen Sie den Kontext für den Cluster fest.](cs_cli_install.html#cs_cli_configure)

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
    apiVersion: extensions/v1beta1
    kind: NetworkPolicy
    metadata:
      name: all-master-egress
      namespace: default
    spec:
      egress:
      # Zugriff auf Cluster-Master mithilfe von Kubernetes-Service-Cluster-IP-Adresse
      # oder Domänenname oder Cluster-Master-IP-Adresse zulassen.
      - ports:
        - protocol: TCP
        to:
        - ipBlock:
            cidr: 161.202.126.210/32
      # Zugriff auf Kubernetes-DNS zulassen, um den Kubernetes-Service-
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

    Wenn Sie zuvor Ihre Richtlinien für ausgehenden Netzverkehr so konfiguriert haben, dass nur eine einzelne IP-Adresse und ein einzelner Port für den einzelnen Kubernetes-Master geöffnet sind, verwenden Sie jetzt den clusterinternen IP-Adressbereich '172.20.0.1/32' und den Port '2040' des Master-Proxy. {: tip}

    ```
    apiVersion: extensions/v1beta1
    kind: NetworkPolicy
    metadata:
      name: all-master-egress
      namespace: default
    spec:
      egress:
      # Zugriff auf Cluster-Master mithilfe von Kubernetes-Service-Cluster-IP-Adresse
      # oder Domänenname zulassen.
      - ports:
        - protocol: TCP
        to:
        - ipBlock:
            cidr: 172.20.0.1/32
        - ipBlock:
            cidr: 161.202.126.210/32
      # Zugriff auf Kubernetes-DNS zulassen, um den Kubernetes-Service-Domänennamen aufzulösen. 
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

6.  Nachdem Sie alle [Vorbereitungsaktionen](#ha-masters) (einschließlich dieser Schritte) ausgeführt haben, [aktualisieren Sie Ihren Cluster-Master](cs_cluster_update.html#master) auf das Fixpack für den Hochverfügbarkeitsmaster. 

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

### Vorbereitungen für die Aktualisierung auf Calico Version 3
{: #110_calicov3}

Sie müssen zunächst sicherstellen, dass Ihr Cluster-Master und alle Workerknoten Kubernetes-Version 1.8 oder später ausführen und über mindestens einen Workerknoten verfügen.
{: shortdesc}

Bereiten Sie sich auf die Calico Version 3-Aktualisierung vor, bevor Sie den Master aktualisieren. Während der Aktualisierung des Masters auf Kubernetes Version 1.10 werden keine neuen Pods oder neue Kubernetes- oder Calico-Netzrichtlinien terminiert. Die Zeit, während der bei der Aktualisierung keine neue Terminierung möglich ist, variiert. Für kleine Cluster kann der Vorgang einige Minuten dauern, wobei für jede 10 Knoten ein paar Minuten mehr benötigt werden. Bestehende Netzrichtlinien und Pods werden weiterhin ausgeführt.
{: important}

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
    2.  Wenn der Zustand des Workerknotens nicht **Normal** lautet, befolgen Sie die Schritte zum [Debuggen von Workerknoten](cs_troubleshoot.html#debug_worker_nodes). Der Zustand **Kritisch** oder **Unbekannt** lässt sich häufig auflösen, indem Sie [den Workerknoten neu laden](cs_cli_reference.html#cs_worker_reload). 

3.  Wenn Sie Calico-Richtlinien oder andere Calico-Ressourcen automatisch generieren, aktualisieren Sie Ihre Automatisierungstools, um diese Ressourcen mit der [Calico Version 3-Syntax ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://docs.projectcalico.org/v3.1/reference/calicoctl/resources/) zu generieren.

4.  Wenn Sie [strongSwan](cs_vpn.html#vpn-setup) für die VPN-Konnektivität verwenden, funktioniert das strongSwan 2.0.0-Helm-Diagramm nicht mit Calico Version 3 oder Kubernetes 1.10. [Aktualisieren Sie strongSwan](cs_vpn.html#vpn_upgrade) auf das 2.1.0-Helm-Diagramm, das abwärtskompatibel mit Calico 2.6 und Kubernetes 1.7, 1.8 und 1.9 ist.

5.  [Aktualisieren Sie den Cluster-Master auf Kubernetes Version 1.10](cs_cluster_update.html#master).

<br />


## Archiv
{: #k8s_version_archive}

Hier finden Sie eine Übersicht über Kubernetes-Versionen, die in {{site.data.keyword.containerlong_notm}} nicht unterstützt werden.
{: shortdesc}

### Version 1.9 (veraltet, nicht mehr unterstützt seit 27. Dezember 2018)
{: #cs_v19}

<p><img src="images/certified_kubernetes_1x9.png" style="padding-right: 10px;" align="left" alt="Dieses Flag zeigt die Kubernetes Version 1.9-Zertifizierung für IBM Cloud Container Service an. "/> {{site.data.keyword.containerlong_notm}} ist ein zertifiziertes Kubernetes-Produkt für Version 1.9 unter dem CNCF Kubernetes Software Conformance Certification Program. _Kubernetes® ist eine eingetragene Marke von The Linux Foundation in den USA und anderen Ländern und wird entsprechend einer Lizenz von The Linux Foundation verwendet._</p>

Überprüfen Sie Änderungen, die Sie möglicherweise bei einer Aktualisierung von der vorherigen Version auf die Kubernetes-Version 1.9 vornehmen müssen.
{: shortdesc}

<br/>

### Vor Master aktualisieren
{: #19_before}

In der folgenden Tabelle sind die Aktionen aufgeführt, die Sie ausführen müssen, bevor Sie den Kubernetes-Master aktualisieren. {: shortdesc}

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

In der folgenden Tabelle sind die Aktionen aufgeführt, die Sie ausführen müssen, nachdem Sie den Kubernetes-Master aktualisiert haben. {: shortdesc}

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
<td>Schreibgeschützte API-Datenträger</td>
<td>`secret`, `configMap`, `downwardAPI` und projizierte Datenträger werden jetzt nur schreibgeschützt angehängt.
Früher durften Apps Daten auf diese Datenträger schreiben, die vom System möglicherweise nicht automatisch zurückgesetzt werden. Diese Änderung ist erforderlich,
um die Sicherheitslücke [CVE-2017-1002102](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2017-1002102) zu schließen.
Wenn Ihre Apps das bisherige unsichere Verhalten erwarten, ändern Sie sie entsprechend.</td>
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

### Version 1.8 (nicht unterstützt)
{: #cs_v18}

Seit dem 22. September 2018 werden {{site.data.keyword.containerlong_notm}}-Cluster, die auf [Kubernetes Version 1.8](cs_versions_changelog.html#changelog_archive) ausgeführt werden, nicht mehr unterstützt. Cluster der Version 1.8 können keine Sicherheitsupdates oder Unterstützung mehr erhalten, bis sie auf die nächste, aktuellste Version ([Kubernetes 1.9](#cs_v19)) aktualisiert werden.
{: shortdesc}

[Überprüfen Sie die mögliche Auswirkung](cs_versions.html#cs_versions) jeder einzelnen Aktualisierung einer Kubernetes-Version und [aktualisieren Sie Ihre Cluster](cs_cluster_update.html#update) dann sofort auf mindestens Version 1.9.

### Version 1.7 (nicht unterstützt)
{: #cs_v17}

Seit dem 21. Juni 2018 werden {{site.data.keyword.containerlong_notm}}-Cluster, die unter [Kubernetes Version 1.7](cs_versions_changelog.html#changelog_archive) ausgeführt werden, nicht mehr unterstützt. Cluster der Version 1.7 können keine Sicherheitsupdates oder Unterstützung mehr erhalten, bis sie auf die nächste, aktuellste Version ([Kubernetes 1.9](#cs_v19)) aktualisiert werden.
{: shortdesc}

[Überprüfen Sie die mögliche Auswirkung](cs_versions.html#cs_versions) jeder einzelnen Aktualisierung einer Kubernetes-Version und [aktualisieren Sie Ihre Cluster](cs_cluster_update.html#update) dann sofort auf mindestens Version 1.9.

### Version 1.5 (nicht unterstützt)
{: #cs_v1-5}

Seit dem 4. April 2018 werden {{site.data.keyword.containerlong_notm}}-Cluster, die auf [Kubernetes Version 1.5](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.5.md) ausgeführt werden, nicht mehr unterstützt. Cluster der Version 1.5 können keine Sicherheitsupdates oder Unterstützung mehr erhalten.
{: shortdesc}

Wenn die Apps weiterhin in {{site.data.keyword.containerlong_notm}} ausgeführt werden sollen, [erstellen Sie einen neuen Cluster](cs_clusters.html#clusters) und [stellen Sie die Apps](cs_app.html#app) im neuen Cluster bereit. 
