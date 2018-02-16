---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-12"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Cluster und Workerknoten aktualisieren
{: #update}

## Kubernetes-Master aktualisieren
{: #master}

Kubernetes stellt regelmäßig Aktualisierungen in Form von Releases zur Verfügung. Hierbei kann es sich um [Hauptversionen, Nebenversionen oder Patchs](cs_versions.html#version_types) handeln. Je nach Aktualisierungstyp kann es sein, dass Sie für die Aktualisierung Ihres Kubernetes-Masters verantwortlich sind. Auf jeden Fall sind Sie immer dafür verantwortlich, Ihre Workerknoten auf dem neuesten Stand zu halten. Bei der Durchführung von Aktualisierungen wird der Kubernetes-Master vor Ihren Workerknoten aktualisiert.
{:shortdesc}

Standardmäßig gilt für die Aktualisierung eines Kubernetes-Masters eine Beschränkung auf zwei Nebenversionen ab der aktuellen Version. Beispiel: Wenn der aktuelle Master die Version 1.5 aufweist und Sie eine Aktualisierung auf 1.8 durchführen wollen, müssen Sie zunächst auf Version 1.7 aktualisieren. Sie können die gewünschte Aktualisierung zwar erzwingen, doch kann eine Aktualisierung über mehr als zwei Nebenversionen hinweg unter Umständen zu nicht erwarteten Ergebnissen führen.

Das folgende Diagramm zeigt den Prozess, den Sie zum Aktualisieren des Masters durchlaufen können.

![Best Practice zur Aktualisierung des Masters](/images/update-tree.png)

Abbildung 1. Prozessdiagramm für die Aktualisierung des Kubernetes-Masters

**Achtung**: Nach Durchführung des Aktualisierungsprozesses kann für einen Cluster kein Rollback auf eine Vorgängerversion durchgeführt werden. Achten Sie darauf, zunächst einen Testcluster zu verwenden und die Anweisungen für den Umgang mit potenziellen Problemen zu befolgen, bevor Sie Ihren Produktionsmaster aktualisieren.

Bei der Durchführung einer Aktualisierung für eine _Hauptversion_ oder _Nebenversion_ müssen Sie die folgenden Schritte ausführen:

1. Überprüfen Sie die [Kubernetes-Änderungen](cs_versions.html) und führen Sie alle Aktualisierungen durch, die mit der Markierung _Vor Master aktualisieren_ gekennzeichnet sind.
2. Aktualisieren Sie den Kubernetes-Master über die GUI oder durch Ausführung des [CLI-Befehls](cs_cli_reference.html#cs_cluster_update). Wenn Sie den Kubernetes-Master aktualisieren, dann wird der Master für ca. 5 - 10 Minuten inaktiviert. Während der Aktualisierung können Sie weder auf den Cluster zugreifen noch Änderungen am Cluster vornehmen. Allerdings werden Workerknoten, Apps und Ressourcen, die von Clusterbenutzern bereitgestellt wurden, nicht geändert und weiterhin ausgeführt.
3. Vergewissern Sie sich, dass die Aktualisierung abgeschlossen wurde. Überprüfen Sie die Kubernetes-Version im {{site.data.keyword.Bluemix_notm}}-Dashboard oder führen Sie den Befehl `bx cs clusters` aus.

Wenn die Aktualisierung des Kubernetes-Masters abgeschlossen ist, können Sie Ihre Workerknoten aktualisieren.

<br />


## Workerknoten aktualisieren
{: #worker_node}

Sie haben also eine Benachrichtigung erhalten, dass Ihre Workerknoten aktualisiert werden müssen. Was bedeutet dies nun? Ihre Daten sind innerhalb Ihrer Workerknoten in den Pods gespeichert. Bei der Einrichtung von Sicherheitsupdates und -patchs für den Kubernetes-Master müssen Sie darauf achten, dass Ihre Workerknoten synchronisiert bleiben. Die Version des Workerknoten-Masters darf nicht höher sein als die des Kubernetes-Masters.
{: shortdesc}

<ul>**Achtung**:</br>
<li>Die Aktualisierung von Workerknoten kann zu Ausfallzeiten bei Ihren Apps und Services führen.</li>
<li>Die Daten werden gelöscht, wenn sie nicht außerhalb des Pods gespeichert werden.</li>
<li>Verwenden Sie [Replikate ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#replicas) in Ihren Bereitstellungen, um die erneute Zeitplanung für Pods auf den verfügbaren Knoten zu ermöglichen.</li></ul>

Was kann getan werden, um Ausfallzeiten zu vermeiden?

Während des Aktualisierungsprozesses werden bestimmte Knoten für eine gewisse Zeit nicht aktiv sein. Um Ausfallzeiten bei Ihren Anwendungen möglichst zu vermeiden, können Sie eindeutige Schlüssel in einer Konfigurationszuordnung definieren, in der Prozentsätze als Schwellenwerte für bestimmte Knotentypen für die Zeit der Durchführung des Aktualisierungsprozesses angegeben werden. Durch das Definieren von Regeln auf der Basis von standardmäßigen Kubernetes-Bezeichnungen und das Angeben eines Prozentsatzes für den maximal zulässigen Anteil an nicht verfügbaren Knoten können Sie sicherstellen, dass Ihre App betriebsbereit bleibt. Ein Knoten gilt als nicht verfügbar, wenn er den Bereitstellungsprozess noch nicht vollständig durchlaufen hat.

Wie werden die Schlüssel definiert?

In der Konfigurationszuordnung befindet sich ein Datenabschnitt. Sie können bis zu 10 einzelne Regeln definieren, die jederzeit ausgeführt werden können. Damit ein Workerknoten aktualisiert werden kann, muss er jede in der Zuordnung definierte Regel erfüllen.

Die Schlüssel sind definiert. Was kommt als Nächstes?

Nachdem die gewünschten Regeln definiert worden sind, führen Sie den Befehl 'worker-upgrade' aus. Bei erfolgreicher Ausführung und Rückgabe einer entsprechenden Antwort werden die Workerknoten in eine Warteschlange zwecks Aktualisierung eingereiht. Die Knoten durchlaufen den Aktualisierungsprozess jedoch erst dann, wenn sämtliche Regeln erfüllt sind. Während sich die Knoten in der Warteschlange befinden, werden die Regeln in Intervallen überprüft, um festzustellen, ob die Knoten aktualisiert werden können.

Wie sieht es aus, wenn keine Konfigurationszuordnung definiert wurde?

Wenn die Konfigurationszuordnung nicht definiert wurde, wird die Standardeinstellung verwendet. Standardmäßig sind maximal 20% aller Workerknoten in den einzelnen Clustern während des Aktualisierungsprozesses nicht verfügbar.

Gehen Sie wie folgt vor, um Ihre Workerknoten zu aktualisieren:

1. Installieren Sie die Version der [`CLI für kubectl` ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tasks/tools/install-kubectl/), die der Kubernetes-Version des Kubernetes-Masters entspricht.

2. Führen Sie alle Änderungen durch, die mit der Markierung _Nach Master aktualisieren_ in [Kubernetes-Änderungen](cs_versions.html) versehen sind.

3. Optional: Definieren Sie eine Konfigurationszuordnung (ConfigMap).
    Beispiel:

    ```
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: ibm-cluster-update-configuration
      namespace: kube-system
    data:
     zonecheck.json: |
       {
         "MaxUnavailablePercentage": 70,
         "NodeSelectorKey": "failure-domain.beta.kubernetes.io/zone",
         "NodeSelectorValue": "dal13"
       }
     regioncheck.json: |
       {
         "MaxUnavailablePercentage": 80,
         "NodeSelectorKey": "failure-domain.beta.kubernetes.io/region",
         "NodeSelectorValue": "us-south"
       }
    ...
     defaultcheck.json: |
       {
         "MaxUnavailablePercentage": 100
       }
    ```
    {:pre}
  <table summary="Die erste Zeile in der Tabelle erstreckt sich über beide Spalten. Die übrigen Zeilen sollten von links nach rechts gelesen werden, wobei der Parameter in der ersten Spalte und die entsprechende Beschreibung in der zweiten Spalte angegeben sind.">
    <thead>
      <th colspan=2><img src="images/idea.png"/> Erklärung der Komponenten </th>
    </thead>
    <tbody>
      <tr>
        <td><code>defaultcheck.json</code></td>
        <td> Wenn keine gültige Definition der Zuordnung 'ibm-cluster-update-configuration' vorhanden ist, dann können standardmäßig immer nur maximal 20% Ihrer Cluster gleichzeitig nicht verfügbar sein. Wird mindestens eine gültige Regel ohne globalen Standardwert (default) definiert, dann sieht der neue Standardwert vor, dass 100% der Worker gleichzeitig nicht verfügbar sein dürfen. Dies lässt sich entsprechend steuern, indem Sie einen Eintrag mit einem Standardprozentsatz erstellen. </td>
      </tr>
      <tr>
        <td><code>zonecheck.json</code></br><code>regioncheck.json</code></td>
        <td> Dies sind Beispiele für eindeutige Schlüssel, für die Regeln festgelegt werden sollen. Die Namen der Schlüssel können beliebig gewählt werden; die Informationen werden von den festgelegten Konfigurationen im Schlüssel geparst. Für jeden definierten Schlüssel kann jeweils nur ein einziger Wert für <code>NodeSelectorKey</code> und <code>NodeSelectorValue</code> festgelegt werden. Wenn Sie Regeln für mehr als eine Region oder mehr als einen Standort (Rechenzentrum) festlegen wollen, müssen Sie jeweils einen neuen Schlüsseleintrag erstellen. </td>
      </tr>
      <tr>
        <td><code>MaxUnavailablePercentage</code></td>
        <td> Dies ist für einen angegebenen Schlüssel der maximal zulässige Anteil an nicht verfügbaren Knoten. Der Wert wird als Prozentsatz angegeben. Ein Knoten ist dann nicht verfügbar, wenn er sich zum betreffenden Zeitpunkt im Bereitstellungs-, Neulade- oder Einrichtungsprozess befindet. Bei Überschreitung eines beliebigen definierten maximalen Prozentsatzes für Nichtverfügbarkeit werden die in der Warteschlange befindlichen Workerknoten blockiert und so von der Aktualisierung ausgeschlossen. </td>
      </tr>
      <tr>
        <td><code>NodeSelectorKey</code></td>
        <td> Dies ist der Typ der Bezeichnung, für die Sie eine Regel für einen angegebenen Schlüssel festlegen wollen. Sie können Regeln sowohl für die von IBM bereitgestellten Standardbezeichnungen als auch für die von Ihnen erstellten Bezeichnungen festlegen. </td>
      </tr>
      <tr>
        <td><code>NodeSelectorValue</code></td>
        <td> Dies ist die Teilmenge der Knoten in einem angegebenen Schlüssel, die von der Regel evaluiert werden sollen. </td>
      </tr>
    </tbody>
  </table>

    **Hinweis**: Es können maximal 10 Regeln definiert werden. Werden einer einzelnen Datei mehr als 10 Schlüssel hinzugefügt, wird nur eine Teilmenge der Informationen geparst.

3. Aktualisieren Sie Ihre Workerknoten über die grafische Benutzerschnittstelle (GUI) oder durch Ausführung des CLI-Befehls.
  * Zur Aktualisierung über das {{site.data.keyword.Bluemix_notm}}-Dashboard navigieren Sie zum Abschnitt für die `Workerknoten` Ihres Clusters und klicken dann auf `Worker aktualisieren`.
  * Zum Abrufen von Workerknoten-IDs müssen Sie den Befehl `bx cs workers <cluster_name_or_id>` ausführen. Wenn Sie mehrere Workerknoten auswählen, werden die Workerknoten zwecks Evaluierung der Aktualisierung in eine Warteschlange gestellt. Ergibt die Evaluierung, dass die Knoten für die Aktualisierung bereit sind, werden sie gemäß den in den Konfigurationen festgelegten Regeln aktualisiert.

    ```
    bx cs worker-update <clustername_oder_-id> <workerknoten_id1> <workerknoten_id2>
    ```
    {: pre}

4. Optional: Überprüfen Sie die Ereignisse, die von der Konfigurationszuordnung möglicherweise ausgelöst werden, sowie alle eventuell auftretenden Gültigkeitsfehler, indem Sie den folgenden Befehl ausführen und die **Ereignisse** (Events) untersuchen.
    ```
    kubectl describe -n kube-system cm ibm-cluster-update-configuration
    ```
    {: pre}

5. Vergewissern Sie sich, dass die Aktualisierung abgeschlossen wurde:
  * Überprüfen Sie die Kubernetes-Version im {{site.data.keyword.Bluemix_notm}}-Dashboard oder führen Sie den Befehl `bx cs workers <cluster_name_or_id>` aus.
  * Überprüfen Sie die Kubernetes-Version der Workerknoten, indem Sie den Befehl `kubectl get nodes` ausführen.
  * In bestimmten Fällen werden in älteren Clustern nach einer Aktualisierung doppelte Workerknoten mit dem Status **NotReady** (Nicht bereit) aufgelistet. Informationen zum Entfernen doppelter Workerknoten finden Sie im Abschnitt zur [Fehlerbehebung](cs_troubleshoot.html#cs_duplicate_nodes).

Nächste Schritte:
  - Wiederholen Sie den Aktualisierungsprozess für andere Cluster.
  - Informieren Sie die Entwickler, die im Cluster arbeiten, damit diese ihre `kubectl`-CLI auf die Version des Kubernetes-Masters aktualisieren können.
  - Wenn im Kubernetes-Dashboard keine Nutzungsdiagramme angezeigt werden, [löschen Sie den Pod `kube-dashboard`](cs_troubleshoot.html#cs_dashboard_graphs).
<br />

