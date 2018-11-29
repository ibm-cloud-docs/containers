---

copyright:
  years: 2014, 2018
lastupdated: "2018-10-25"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}





# Cluster, Workerknoten und Add-ons aktualisieren
{: #update}

Sie können Aktualisierungen installieren, um Ihre Kubernetes-Cluster in {{site.data.keyword.containerlong}} aktuell zu halten.
{:shortdesc}

## Kubernetes-Master aktualisieren
{: #master}

Kubernetes gibt regelmäßig [Hauptversionen, Nebenversionen oder Patches als Aktualisierungen heraus.](cs_versions.html#version_types). Aktualisierungen können die API-Serverversion von Kubernetes oder andere Komponenten in Ihrem Kubernetes-Master betreffen. IBM aktualisiert die Programmkorrekturversion, aber Sie müssen die Haupt- und Nebenversionen des Masters aktualisieren.
{:shortdesc}

**Wie kann ich wissen, wann der Master aktualisiert werden soll?**</br>
Sie werden über die GUI und die CLI benachrichtigt, wenn Aktualisierungen verfügbar sind. Außerdem können Sie unsere Seite mit den [unterstützten Versionen](cs_versions.html) überprüfen.

**Wie viele Versionen älter als die aktuelle Version darf der Master sein?**</br>
IBM unterstützt in der Regel drei Versionen von Kubernetes zu einem bestimmten Zeitpunkt. Eine Aktualisierung des Kubernetes-API-Servers von seiner aktuellen Version über mehr als zwei Versionen hinweg ist nicht möglich.

Beispiel: Wenn Ihre aktuelle Kubernetes-API-Serverversion die Version 1.7 ist und Sie auf Version 1.10 aktualisieren möchten, müssen Sie zuerst die Aktualisierung auf Version 1.9 durchführen. Sie können die gewünschte Aktualisierung zwar erzwingen, doch kann eine Aktualisierung über drei oder mehr Nebenversionen hinweg unter Umständen zu nicht erwarteten Ergebnissen oder Fehlern führen.

Falls Ihr Cluster in einer nicht unterstützten Kubernetes-Version ausgeführt wird, müssen Sie die Aktualisierung möglicherweise erzwingen. Daher sollten Sie Ihren Cluster auf dem neuesten Stand halten, um operative Auswirkungen zu vermeiden.

**Können meine Workerknoten eine höhere Version als der Master ausführen?**</br>
Nein. [Aktualisieren Sie Ihren Master](#update_master) zunächst auf die aktuellste Version von Kubernetes. Anschließend [aktualisieren Sie die Workerknoten](#worker_node) in Ihrem Cluster. Im Gegensatz zum Master müssen Sie die Worker für jede Patchversion aktualisieren.

**Was passiert bei der Masteraktualisierung?**</br>
Wenn Sie den API-Server von Kubernetes aktualisieren, ist der API-Server für 5 bis 10 Minuten inaktiv. Während der Aktualisierung können Sie weder auf den Cluster zugreifen noch Änderungen am Cluster vornehmen. Allerdings werden Workerknoten, Apps und Ressourcen, die von Clusterbenutzern bereitgestellt wurden, nicht geändert und weiterhin ausgeführt.

**Kann ich die Aktualisierung rückgängig machen?**</br>
Nein, Sie können nach dem Aktualisierungsprozess für Cluster keinen Rollback auf eine frühere Version durchführen. Achten Sie darauf, zunächst einen Testcluster zu verwenden und die Anweisungen für den Umgang mit potenziellen Problemen zu befolgen, bevor Sie Ihren Produktionsmaster aktualisieren.

**Welchen Prozess kann ich verfolgen, um den Master zu aktualisieren?**</br>
Das folgende Diagramm zeigt den Prozess, den Sie zum Aktualisieren des Masters durchlaufen können.

![Best Practice zur Aktualisierung des Masters](/images/update-tree.png)

Abbildung 1. Prozessdiagramm für die Aktualisierung des Kubernetes-Masters

{: #update_master}
Gehen Sie wie folgt vor, um die _Haupt-_ oder _Nebenversion_ des Kubernetes-Masters zu aktualisieren:

1.  Überprüfen Sie die [Kubernetes-Änderungen](cs_versions.html) und führen Sie alle Aktualisierungen durch, die mit der Markierung _Vor Master aktualisieren_ gekennzeichnet sind.

2.  Aktualisieren Sie Ihre API-Server von Kubernetes und die zugehörigen Masterkomponenten von Kubernetes, indem Sie die GUI verwenden oder den [CLI-Befehl `ibmcloud ks cluster-update`](cs_cli_reference.html#cs_cluster_update) ausführen.

3.  Warten Sie ein paar Minuten und stellen Sie dann sicher, dass die Aktualisierung abgeschlossen ist. Überprüfen Sie die Version des Kubernetes-API-Servers im {{site.data.keyword.Bluemix_notm}}-Dashboard oder führen Sie den Befehl `ibmcloud ks clusters` aus.

4.  Installieren Sie die Version von [`kubectl cli`](cs_cli_install.html#kubectl), die mit dem API-Server von Kubernetes übereinstimmt, der in Ihrem Kubernetes-Master ausgeführt wird.

Wenn die Aktualisierung des API-Servers von Kubernetes abgeschlossen ist, können Sie Ihre Workerknoten aktualisieren.

<br />


## Workerknoten aktualisieren
{: #worker_node}

Sie haben eine Benachrichtigung erhalten, die besagt, dass Sie Ihre Workerknoten aktualisieren müssen. Was bedeutet dies nun? Bei der Einrichtung von Sicherheitsupdates und -patches für den API-Server von Kubernetes und anderen Komponenten des Kubernetes-Masters müssen Sie darauf achten, dass Ihre Workerknoten synchronisiert bleiben.
{: shortdesc}

Vorbemerkungen:
- [Melden Sie sich an Ihrem Konto an. Geben Sie als Ziel die entsprechende Region und - sofern anwendbar - die Ressourcengruppe an. Legen Sie den Kontext für den Cluster fest.](cs_cli_install.html#cs_cli_configure)
- [Aktualisieren Sie den Kubernetes-Master](#master). Die Kubernetes-Version der Workerknoten darf nicht höher als die Version des API-Servers von Kubernetes sein.
- Führen Sie alle Änderungen durch, die mit der Markierung _Nach Master aktualisieren_ in [Kubernetes-Änderungen](cs_versions.html) versehen sind.
- Wenn Sie eine Patchaktualisierung anwenden möchten, lesen Sie sich die Informationen im [Kubernetes-Änderungsprotokoll](cs_versions_changelog.html#changelog) durch. </br>

**Achtung**: Die Aktualisierung von Workerknoten kann zu Ausfallzeiten bei Ihren Apps und Services führen. Die Daten werden gelöscht, wenn sie nicht [außerhalb des Pods gespeichert werden](cs_storage_planning.html#persistent_storage_overview).


**Was passiert mit meinen Apps während einer Aktualisierung?**</br>
Wenn Sie Apps als Teil einer Bereitstellung auf Workerknoten ausführen, die Sie aktualisieren, werden die Apps auf anderen Workerknoten im Cluster neu geplant. Diese Workerknoten können sich in einem anderen Worker-Pool befinden. Wenn Sie eigenständige Workerknoten haben, können Apps auch auf eigenständigen Workerknoten geplant werden. Um Ausfallzeiten für Ihre App zu vermeiden, müssen Sie sicherstellen, dass genügend Kapazität im Cluster vorhanden ist, um die Workload zu übernehmen.

**Wie kann ich die Ausfallzeiten von Workerknoten zu einem bestimmten Zeitpunkt während der Aktualisierung steuern?**
Wenn alle Workerknoten betriebsbereit sein müssen, sollten Sie in Betracht ziehen, [die Größe des Worker-Pools zu ändern](cs_cli_reference.html#cs_worker_pool_resize) oder [eigenständige Workerknoten hinzufügen](cs_cli_reference.html#cs_worker_add), um weitere Workerknoten hinzuzufügen. Sie können die zusätzlichen Workerknoten entfernen, nachdem die Aktualisierung abgeschlossen ist.

Darüber hinaus können Sie eine Kubernetes-Konfigurationszuordnung erstellen, die die maximale Anzahl der Workerknoten angibt, die während der Aktualisierung nicht verfügbar sein können. Workerknoten werden durch eine entsprechende Bezeichnung identifiziert. Sie können von IBM bereitgestellte Bezeichnungen oder angepasste Bezeichnungen verwenden, die Sie dem Workerknoten hinzugefügt haben.

**Wie sieht es aus, wenn keine Konfigurationszuordnung definiert wurde?**</br>
Wenn die Konfigurationszuordnung nicht definiert wurde, wird die Standardeinstellung verwendet. Standardmäßig können maximal 20 % aller Workerknoten in den einzelnen Clustern während des Aktualisierungsprozesses nicht verfügbar sein.

Gehen Sie wie folgt vor, um eine Konfigurationszuordnung zu erstellen und die Workerknoten zu aktualisieren:

1.  Listen Sie verfügbare Workerknoten auf und notieren Sie deren private IP-Adressen.

    ```
    ibmcloud ks workers <clustername_oder_-id>
    ```
    {: pre}

2. Zeigen Sie die Bezeichnungen eines Workerknotens an. Die Bezeichnungen der Workerknoten finden Sie im Abschnitt **Labels** der CLI-Ausgabe. Jede Bezeichnung besteht aus einem Selektorschlüssel (`NodeSelectorKey`) und einem Selektorwert (`NodeSelectorValue`).
   ```
   kubectl describe node <private_worker-ip>
   ```
   {: pre}

   Beispielausgabe:
   ```
   Name:               10.184.58.3
   Roles:              <keine>
   Labels:             arch=amd64
                    beta.kubernetes.io/arch=amd64
                    beta.kubernetes.io/os=linux
                    failure-domain.beta.kubernetes.io/region=us-south
                    failure-domain.beta.kubernetes.io/zone=dal12
                    ibm-cloud.kubernetes.io/encrypted-docker-data=true
                    ibm-cloud.kubernetes.io/iaas-provider=softlayer
                    ibm-cloud.kubernetes.io/machine-type=u2c.2x4.encrypted
                    kubernetes.io/hostname=10.123.45.3
                    privateVLAN=2299001
                    publicVLAN=2299012
   Annotations:        node.alpha.kubernetes.io/ttl=0
                    volumes.kubernetes.io/controller-managed-attach-detach=true
   CreationTimestamp:  Tue, 03 Apr 2018 15:26:17 -0400
   Taints:             <none>
   Unschedulable:      false
   ```
   {: screen}

3. Erstellen Sie eine Konfigurationszuordnung und definieren Sie die Nichtverfügbarkeitsregeln für Ihre Workerknoten. Das folgende Beispiel zeigt vier Prüfungen: `zonecheck.json`, `regioncheck.json`, `defaultcheck.json` und eine Prüfungsvorlage. Sie können diese Beispielprüfungen verwenden, um Regeln für Workerknoten in einer bestimmten Zone (`zonecheck.json`), Region (`regioncheck.json`) oder für alle Workerknoten zu definieren, die nicht mit den in der Konfigurationszuordnung definierten Prüfungen übereinstimmen (`defaultcheck.json`). Mit der Prüfungsvorlage können Sie Ihre eigene Prüfung erstellen. Für jede Prüfung müssen Sie zum Identifizieren eines Workerknotens eine der Workerknotenbezeichnungen auswählen, die Sie im vorherigen Schritt abgerufen haben.  

   **Hinweis:** Für jede Prüfung können Sie nur einen Wert für <code>NodeSelectorKey</code> und <code>NodeSelectorValue</code> festlegen. Wenn Sie Regeln für mehrere Regionen, Zonen oder andere Workerknotenbezeichnungen festlegen möchten, müssen Sie eine neue Prüfung erstellen. Definieren Sie bis zu zehn Prüfungen in einer Konfigurationszuordnung. Wenn Sie weitere Prüfungen hinzufügen, werden sie ignoriert.

   Beispiel:
   ```
   apiVersion: v1
    kind: ConfigMap
    metadata:
      name: ibm-cluster-update-configuration
      namespace: kube-system
    data:
     drain_timeout_seconds: "120"
     zonecheck.json: |
       {
        "MaxUnavailablePercentage": 30,
        "NodeSelectorKey": "failure-domain.beta.kubernetes.io/zone",
        "NodeSelectorValue": "dal13"
      }
    regioncheck.json: |
       {
        "MaxUnavailablePercentage": 20,
        "NodeSelectorKey": "failure-domain.beta.kubernetes.io/region",
        "NodeSelectorValue": "us-south"
      }
    defaultcheck.json: |
       {
        "MaxUnavailablePercentage": 20
      }
    <Prüfungsname>: |
      {
        "MaxUnavailablePercentage": <wert_in_prozent>,
        "NodeSelectorKey": "<selektorschlüssel_des_knotens>",
        "NodeSelectorValue": "<selektorwert_des_knotens>"
      }
   ```
   {:pre}

   <table summary="Die erste Zeile in der Tabelle erstreckt sich über beide Spalten. Die übrigen Zeilen sollten von links nach rechts gelesen werden, wobei der Parameter in der ersten Spalte und die entsprechende Beschreibung in der zweiten Spalte angegeben sind.">
   <caption>Komponenten der Konfigurationszuordnung</caption>
    <thead>
      <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der Komponenten </th>
    </thead>
    <tbody>
      <tr>
        <td><code>drain_timeout_seconds</code></td>
        <td> Optional: Das Zeitlimit in Sekunden, das gewartet wird, bis die [Entleerung ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tasks/administer-cluster/safely-drain-node/) abgeschlossen ist. Durch das Entleeren eines Workerknotens werden alle vorhandenen Pods sicher vom Workerknoten entfernt und die Pods auf anderen Workerknoten im Cluster neu geplant. Zulässige Werte liegen zwischen 1 und 180. Der Standardwert ist 30.</td>
      </tr>
      <tr>
        <td><code>zonecheck.json</code></br><code>regioncheck.json</code></td>
        <td>Zwei Prüfungen, die eine Regel für eine Gruppe von Workerknoten definieren, die Sie mit den angegebenen Werten für <code>NodeSelectorKey</code> und <code>NodeSelectorValue</code> identifizieren können. Die Datei <code>zonecheck.json</code> identifiziert Workerknoten auf der Basis ihrer Zonenbezeichnung und die Datei <code>regioncheck.json</code> verwendet die Regionsbezeichnung, die während der Bereitstellung zu jedem Workerknoten hinzugefügt wird. Im vorliegenden Beispiel können 30 % aller Workerknoten, die <code>dal13</code> als Zonenbezeichnung aufweisen, und 20 % aller Workerknoten in <code>us-south</code> während der Aktualisierung nicht verfügbar sein.</td>
      </tr>
      <tr>
        <td><code>defaultcheck.json</code></td>
        <td>Wenn Sie keine Konfigurationszuordnung erstellen oder die Zuordnung nicht ordnungsgemäß konfiguriert ist, wird der Standardwert von Kubernetes angewendet. Standardmäßig können nur 20 % der Workerknoten im Cluster zu einem bestimmten Zeitpunkt nicht verfügbar sein. Sie können den Standardwert überschreiben, indem Sie die Standardprüfung zur Konfigurationszuordnung hinzufügen. Im Beispiel kann jeder in den Zonen- und Regionsprüfungen (<code>dal13</code> oder <code>us-south</code>) angegebene Workerknoten während der Aktualisierung nicht verfügbar sein. </td>
      </tr>
      <tr>
        <td><code>MaxUnavailablePercentage</code></td>
        <td>Dies ist für einen angegebenen Kennzeichnungsschlüssel und -wert der maximal zulässige Anteil an nicht verfügbaren Knoten. Der Wert wird als Prozentsatz angegeben. Ein Workerknoten ist dann nicht verfügbar, wenn er sich zum betreffenden Zeitpunkt im Bereitstellungs-, Neulade- oder Einrichtungsprozess befindet. Bei Überschreitung eines beliebigen definierten maximalen Prozentsatzes für Nichtverfügbarkeit werden die in der Warteschlange befindlichen Workerknoten blockiert und so von der Aktualisierung ausgeschlossen. </td>
      </tr>
      <tr>
        <td><code>NodeSelectorKey</code></td>
        <td>Dies ist der Kennzeichnungsschlüssel des Workerknotens, für den eine Regel festgelegt werden soll. Sie können Regeln sowohl für die von IBM bereitgestellten Standardbezeichnungen als auch für die von Ihnen erstellten Workerknotenbezeichnungen festlegen. <ul><li>Wenn Sie eine Regel für Workerknoten hinzufügen möchten, die zu einem Worker-Pool gehören, können Sie die Bezeichnung <code>ibm-cloud.kubernetes.io/machine-type</code> verwenden. </li><li> Wenn Sie mehr als einen Worker-Pool mit demselben Maschinentyp haben, verwenden Sie eine angepasste Bezeichnung. </li></ul></td>
      </tr>
      <tr>
        <td><code>NodeSelectorValue</code></td>
        <td>Der Bezeichnungswert, den der Workerknoten für die von Ihnen definierte Regel berücksichtigen muss. </td>
      </tr>
    </tbody>
   </table>

4. Erstellen Sie die Konfigurationszuordnung in Ihrem Cluster.
   ```
   kubectl apply -f <filepath/configmap.yaml>
   ```
   {: pre}

5. Stellen Sie sicher, dass die Konfigurationszuordnung erstellt wurde.
   ```
   kubectl get configmap --namespace kube-system
   ```
   {: pre}

6.  Aktualisieren Sie die Workerknoten.

    ```
    ibmcloud ks worker-update <clustername_oder_-id> <workerknoten1-id> <workerknoten2-id>
    ```
    {: pre}

7. Optional: Überprüfen Sie die Ereignisse, die von der Konfigurationszuordnung möglicherweise ausgelöst werden, sowie alle eventuell auftretenden Gültigkeitsfehler. Die Ereignisse können im Abschnitt **Events** Ihrer CLI-Ausgabe überprüft werden.
   ```
   kubectl describe -n kube-system cm ibm-cluster-update-configuration
   ```
   {: pre}

8. Vergewissern Sie sich, dass die Aktualisierung abgeschlossen wurde, indem Sie die Kubernetes-Version der Workerknoten überprüfen.  
   ```
   kubectl get nodes
   ```
   {: pre}

9. Stellen Sie sicher, dass keine doppelten Workerknoten vorhanden sind. In bestimmten Fällen werden in älteren Clustern nach einer Aktualisierung doppelte Workerknoten mit dem Status **NotReady** (Nicht bereit) aufgelistet. Informationen zum Entfernen doppelter Workerknoten finden Sie im Abschnitt zur [Fehlerbehebung](cs_troubleshoot_clusters.html#cs_duplicate_nodes).

Nächste Schritte:
  - Wiederholen Sie den Aktualisierungsprozess mit anderen Worker-Pools.
  - Informieren Sie die Entwickler, die im Cluster arbeiten, damit diese ihre `kubectl`-CLI auf die Version des Kubernetes-Masters aktualisieren können.
  - Wenn im Kubernetes-Dashboard keine Nutzungsdiagramme angezeigt werden, [löschen Sie den Pod `kube-dashboard`](cs_troubleshoot_health.html#cs_dashboard_graphs).

<br />



## Maschinentypen aktualisieren
{: #machine_type}

Sie können die Maschinentypen der Workerknoten aktualisieren, indem Sie neue Workerknoten hinzufügen und alte entfernen. Wenn Sie zum Beispiel über virtuelle Workerknoten auf nicht mehr verwendeten Maschinen mit `u1c` oder `b1c` in den jeweiligen Namen verfügen, erstellen Sie Workerknoten, die Maschinentypen mit `u2c` oder `b2c` in den Namen verwenden.
{: shortdesc}

Vorbemerkungen:
- [Melden Sie sich an Ihrem Konto an. Geben Sie als Ziel die entsprechende Region und - sofern anwendbar - die Ressourcengruppe an. Legen Sie den Kontext für den Cluster fest.](cs_cli_install.html#cs_cli_configure)
- Wenn Sie Daten auf dem Workerknoten speichern, werden die Daten gelöscht, wenn sie nicht [außerhalb des Workerknotens gespeichert sind](cs_storage_planning.html#persistent_storage_overview).


**Achtung**: Die Aktualisierung von Workerknoten kann zu Ausfallzeiten bei Ihren Apps und Services führen. Die Daten werden gelöscht, wenn sie nicht [außerhalb des Pods gespeichert werden](cs_storage_planning.html#persistent_storage_overview).

1. Listen Sie verfügbare Workerknoten auf und notieren Sie deren private IP-Adressen.
   - **Für Workerknoten in einem Worker-Pool**:
     1. Listen Sie verfügbare Worker-Pools in Ihrem Cluster auf.
        ```
        ibmcloud ks worker-pools --cluster <clustername_oder_-id>
        ```
        {: pre}

     2. Listen Sie die Workerknoten im Worker-Pool auf.
        ```
        ibmcloud ks workers <clustername_oder_-id> --worker-pool <poolname>
        ```
        {: pre}

     3. Rufen Sie die Details für einen Workerknoten ab und notieren Sie die Zone, die private und die öffentliche VLAN-ID.
        ```
        ibmcloud ks worker-get <clustername_oder_-id> <worker-id>
        ```
        {: pre}

   - **Veraltet: Für eigenständige Workerknoten**:
     1. Listen Sie verfügbare Workerknoten auf.
        ```
        ibmcloud ks workers <clustername_oder_-id>
        ```
        {: pre}

     2. Rufen Sie die Details für einen Workerknoten ab und notieren Sie die Zone, die private und die öffentliche VLAN-ID.
        ```
        ibmcloud ks worker-get <clustername_oder_-id> <worker-id>
        ```
        {: pre}

2. Listen Sie die verfügbaren Maschinentypen in der Zone auf.
   ```
   ibmcloud ks machine-types <zone>
   ```
   {: pre}

3. Erstellen Sie einen Workerknoten mit dem neuen Maschinentyp.
   - **Für Workerknoten in einem Worker-Pool**:
     1. Erstellen Sie einen Worker-Pool mit der Anzahl der Workerknoten, die Sie ersetzen möchten.
        ```
        ibmcloud ks worker-pool-create --name <poolname> --cluster <clustername_oder_-id> --machine-type <maschinentyp> --size-per-zone <anzahl_der_worker_pro_zone>
        ```
        {: pre}

     2. Stellen Sie sicher, dass der Worker-Pool erstellt wird.
        ```
        ibmcloud ks worker-pools --cluster <clustername_oder_-id>
        ```
        {: pre}

     3. Fügen Sie die Zone zu Ihrem Worker-Pool hinzu, den Sie zuvor abgerufen haben. Beim Hinzufügen einer Zone werden die Workerknoten, die im Worker-Pool definiert sind, in der Zone bereitgestellt und für die zukünftige Planung von Workloads berücksichtigt. Wenn Sie die Workerknoten auf mehrere Zonen verteilen möchten, wählen Sie eine [mehrzonenfähige Zone](cs_regions.html#zones) aus.
        ```
        ibmcloud ks zone-add --zone <zone> --cluster <clustername_oder_-id> --worker-pools <poolname> --private-vlan <private_vlan-id> --public-vlan <public_vlan-id>
        ```
        {: pre}

   - **Veraltet: Für eigenständige Workerknoten**:
       ```
       ibmcloud ks worker-add --cluster <clustername> --machine-type <maschinentyp> --number <anzahl_der_workerknoten> --private-vlan <private_vlan-id> --public-vlan <öffentliche_vlan-id>
       ```
       {: pre}

4. Warten Sie, bis die Workerknoten bereitgestellt wurden.
   ```
   ibmcloud ks workers <clustername_oder_-id>
   ```
   {: pre}

   Wenn der Status des Workerknotens in **Normal** wechselt, ist die Bereitstellung abgeschlossen.

5. Entfernen Sie den alten Workerknoten. **Hinweis**: Wenn Sie einen Maschinentyp entfernen, der monatlich abgerechnet wird (zum Beispiel Bare-Metal), dann wird Ihnen der gesamte Monat noch berechnet.
   - **Für Workerknoten in einem Worker-Pool**:
     1. Entfernen Sie den Worker-Pool mit dem alten Maschinentyp. Durch das Entfernen eines Worker-Pools werden alle Workerknoten im Pool in allen Zonen entfernt. Dieser Prozess kann einige Minuten dauern.
        ```
        ibmcloud ks worker-pool-rm --worker-pool <poolname> --cluster <clustername_oder_-id>
        ```
        {: pre}

     2. Stellen Sie sicher, dass der Worker-Pool entfernt wird.
        ```
        ibmcloud ks worker-pools --cluster <clustername_oder_-id>
        ```
        {: pre}

   - **Veraltet: Für eigenständige Workerknoten**:
      ```
      ibmcloud ks worker-rm <clustername> <workerknoten>
      ```
      {: pre}

6. Stellen Sie sicher, dass die Workerknoten aus Ihrem Cluster entfernt werden.
   ```
   ibmcloud ks workers <clustername_oder_-id>
   ```
   {: pre}

7. Wiederholen Sie diese Schritte, um andere Worker-Pools oder eigenständige Workerknoten auf verschiedene Maschinentypen zu aktualisieren.

## Cluster-Add-ons aktualisieren
{: #addons}

Ihr {{site.data.keyword.containerlong_notm}}-Cluster wird mit **Add-ons** geliefert, z. B. Fluentd für die Protokollierung, die automatisch installiert werden, wenn Sie den Cluster bereitstellen. Diese Add-ons müssen separat von den Master- und Workerknoten aktualisiert werden.
{: shortdesc}

**Welche Standard-Add-ons müssen ich separat vom Cluster aktualisieren?**
* [Fluentd für Protokollierung](#logging)

**Gibt es Add-ons, die ich nicht aktualisieren muss und die ich nicht ändern kann?**</br>
Ja, Ihr Cluster wird mit den folgenden verwalteten Add-ons und zugehörigen Ressourcen bereitgestellt, die nicht geändert werden können. Wenn Sie versuchen, eines dieser Add-ons für die Bereitstellung zu ändern, werden ihre ursprünglichen Einstellungen in einem regelmäßigen Intervall wiederhergestellt.

* `heapster`
* `ibm-file-plugin`
* `ibm-storage-watcher`
* `ibm-keepalived-watcher`
* `kube-dns-amd64`
* `kube-dns-autoscaler`
* `kubernetes-dashboard`
* `vpn`

Sie können diese Ressourcen anzeigen, indem Sie die Bezeichnung `addonmanager.kubernetes.io/mode: Reconcile` verwenden. Beispiel:

```
kubectl get deployments --all-namespaces -l addonmanager.kubernetes.io/mode=Reconcile
```
{: pre}

**Kann ich andere Add-Ons als den Standard installieren?**</br>
Ja. {{site.data.keyword.containerlong_notm}} stellt weitere Add-ons zur Verfügung, die Sie auswählen können, um Ihrem Cluster Funktionen hinzuzufügen. Sie können z. B. [Helm-Diagramme verwenden](cs_integrations.html#helm) , um das [Blockspeicher-Plug-in](cs_storage_block.html#install_block), [Istio](cs_tutorials_istio.html#istio_tutorial) oder das [strongSwan-VPN](cs_vpn.html#vpn-setup) zu installieren. Sie müssen jedes Add-on separat aktualisieren, indem Sie die Anweisungen zum Aktualisieren der Helm-Diagramme befolgen.

### Fluentd für Protokollierung
{: #logging}

Um Änderungen an Ihren Protokollierungs- oder Filterkonfigurationen vornehmen zu können, muss das Fluentd-Add-on die aktuelle Version aufweisen. Standardmäßig sind automatische Aktualisierungen für das Add-on aktiviert.
{: shortdesc}

Sie können überprüfen, ob automatische Aktualisierungen aktiviert sind, indem Sie den [Befehl `ibmcloud ks logging-autoupdate-get --cluster <cluster_name_or_ID>`](cs_cli_reference.html#cs_log_autoupdate_get) ausführen.

Um automatische Aktualisierungen zu inaktivieren, führen Sie den [Befehl `ibmcloud ks logging-autoupdate-disable`](cs_cli_reference.html#cs_log_autoupdate_disable) aus.

Wenn automatische Aktualisierungen inaktiviert sind, Sie jedoch eine Änderung an der Konfiguration vornehmen müssen, stehen Ihnen zwei Optionen zur Auswahl.

*  Aktivieren Sie automatische Aktualisierungen für Ihre Fluentd-Pods.

    ```
    ibmcloud ks logging-autoupdate-enable --cluster <clustername_oder_-id>
    ```
    {: pre}

*  Erzwingen Sie eine einmalige Aktualisierung, wenn Sie einen Protokollierungsbefehl verwenden, der die Option `--force-update` enthält. **Hinweis**: Die Pods werden auf die aktuelle Version des Fluentd-Add-ons aktualisiert, Fluentd wird jedoch zukünftig nicht automatisch aktualisiert.

    Beispielbefehl:

    ```
    ibmcloud ks logging-config-update --cluster <clustername_oder_-id> --id <protokollkonfigurations-id> --type <protokollierungstyp> --force-update
    ```
    {: pre}

## Von eigenständigen Workerknoten auf Worker-Pools aktualisieren
{: #standalone_to_workerpool}

Mit der Einführung von Mehrzonenclustern werden Workerknoten mit derselben Konfiguration, wie z. B. dem Maschinentyp, in Worker-Pools gruppiert. Wenn Sie einen neuen Cluster erstellen, wird automatisch ein Worker-Pool mit dem Namen `default` für Sie erstellt.
{: shortdesc}

Sie können Worker-Pools verwenden, um die Workerknoten gleichmäßig auf die Zonen zu verteilen und einen ausgeglichenen Cluster zu erstellen. Ausgeglichene Cluster sind besser verfügbar und können bei Fehlern ausfallfrei eingesetzt werden. Wenn ein Workerknoten aus einer Zone entfernt wird, können Sie den Worker-Pool neu ausgleichen und automatisch neue Workerknoten für diese Zone bereitstellen. Worker-Pools werden auch verwendet, um Kubernetes-Versionsaktualisierungen für alle Workerknoten zu installieren.  

**Wichtig:** Wenn Sie Cluster erstellt haben, bevor Mehrzonencluster verfügbar wurden, sind die Workerknoten noch eigenständig und werden nicht automatisch in Worker-Pools gruppiert. Sie müssen diese Cluster für die Verwendung von Worker-Pools aktualisieren. Wenn keine Aktualisierung durchgeführt wird, können Sie Ihren Einzelzonencluster nicht in einen Mehrzonencluster ändern.

Die folgende Abbildung veranschaulicht, wie sich Ihre Clusterkonfiguration ändert, wenn Sie statt eigenständigen Workerknoten Worker-Pools verwenden.

<img src="images/cs_cluster_migrate.png" alt="Cluster von eigenständigen Workerknoten auf Worker-Pools aktualisieren" width="600" style="width:600px; border-style: none"/>

Vorbereitende Schritte: [Melden Sie sich an Ihrem Konto an. Geben Sie als Ziel die entsprechende Region und - sofern anwendbar - die Ressourcengruppe an. Legen Sie den Kontext für den Cluster fest.](cs_cli_install.html#cs_cli_configure)

1. Listen Sie vorhandene eigenständige Workerknoten in Ihrem Cluster auf und notieren Sie die **ID**, den **Maschinentyp** und die **private IP**.
   ```
   ibmcloud ks workers <clustername_oder_-id>
   ```
   {: pre}

2. Erstellen Sie einen Worker-Pool und entscheiden Sie sich für den Maschinentyp und die Anzahl der Workerknoten, die Sie zum Pool hinzufügen möchten.
   ```
   ibmcloud ks worker-pool-create --name <poolname> --cluster <clustername_oder_-id> --machine-type <maschinentyp> --size-per-zone <anzahl_der_worker_pro_zone>
   ```
   {: pre}

3. Listen Sie die verfügbaren Zonen auf und legen Sie fest, wo die Workerknoten in Ihrem Worker-Pool bereitgestellt werden sollen. Um die Zone anzuzeigen, in der die eigenständigen Workerknoten bereitgestellt werden, führen Sie den Befehl `ibmcloud ks cluster-get <cluster_name_or_ID>` aus. Wenn Sie die Workerknoten auf mehrere Zonen verteilen möchten, wählen Sie eine [mehrzonenfähige Zone](cs_regions.html#zones) aus.
   ```
   ibmcloud ks zones
   ```
   {: pre}

4. Listen Sie verfügbare VLANs für die Zone auf, die Sie im vorherigen Schritt ausgewählt haben. Wenn in dieser Zone noch kein VLAN vorhanden ist, wird das VLAN automatisch für Sie erstellt, wenn Sie die Zone zum Worker-Pool hinzufügen.
   ```
   ibmcloud ks vlans <zone>
   ```
   {: pre}

5. Fügen Sie die Zone zu Ihrem Worker-Pool hinzu. Beim Hinzufügen einer Zone zu einem Worker-Pool werden die Workerknoten, die im Worker-Pool definiert sind, in der Zone bereitgestellt und für die zukünftige Planung von Workloads berücksichtigt. {{site.data.keyword.containerlong}} fügt automatisch die Bezeichnung `failure-domain.beta.kubernetes.io/region` für die Region und die Bezeichnung `failure-domain.beta.kubernetes.io/zone` für die Zone für jeden Workerknoten hinzu. Der Kubernetes-Scheduler verwendet diese Bezeichnungen, um Pods auf Zonen innerhalb derselben Region zu verteilen.
   1. **So fügen Sie eine Zone zu einem Workerpool hinzu**: Ersetzen Sie `.<pool_name>` durch den Namen Ihres Worker-Pools und füllen Sie die Werte für die Cluster-ID, die Zone und die VLANs mit den zuvor abgerufenen Informationen aus. Wenn Sie nicht über ein privates und ein öffentliches VLAN in dieser Zone verfügen, geben Sie diese Option nicht an. Ein privates und ein öffentliches VLAN werden automatisch für Sie erstellt.

      Wenn Sie verschiedene VLANs für unterschiedliche Worker-Pools verwenden möchten, wiederholen Sie diesen Befehl für jedes VLAN und die entsprechenden Worker-Pools. Alle neuen Workerknoten werden den von Ihnen angegebenen VLANs hinzugefügt, die VLANs für alle vorhandenen Workerknoten werden jedoch nicht geändert.
      ```
      ibmcloud ks zone-add --zone <zone> --cluster <clustername_oder_-id> --worker-pools <poolname> --private-vlan <private_vlan-id> --public-vlan <public_vlan-id>
      ```
      {: pre}

   2. **So fügen Sie die Zone zu mehreren Worker-Pools hinzu**: Fügen Sie mehrere Worker-Pools zum Befehl `ibmcloud ks zone-add` hinzu. Wenn Sie mehrere Worker-Pools zu einer Zone hinzufügen möchten, müssen Sie über ein vorhandenes privates und öffentliches VLAN in dieser Zone verfügen. Wenn Sie kein öffentliches und privates VLAN in dieser Zone haben, sollten Sie die Zone zuerst einem Worker-Pool hinzufügen, damit ein öffentliches und ein privates VLAN für Sie erstellt werden. Anschließend können Sie die Zone zu anderen Worker-Pools hinzufügen. </br></br>Es ist wichtig, dass die Workerknoten in allen Worker-Pools in allen Zonen bereitgestellt werden, um sicherzustellen, dass Ihr Cluster in allen Zonen verteilt ist. Wenn Sie verschiedene VLANs für verschiedene Worker-Pools verwenden möchten, wiederholen Sie diesen Befehl mit dem VLAN, das Sie für Ihren Worker-Pool verwenden wollen. Wenn Sie über mehrere VLANs für einen Cluster, mehrere Teilnetze in demselben VLAN oder einen Cluster mit mehreren Zonen verfügen, müssen Sie [VLAN-Spanning](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) für Ihr Konto für die IBM Cloud-Infrastruktur (SoftLayer) aktivieren, damit die Workerknoten in dem privaten Netz miteinander kommunizieren können. Um diese Aktion durchführen zu können, müssen Sie über die [Infrastrukturberechtigung](cs_users.html#infra_access) **Netz > VLAN-Spanning im Netz verwalten** verfügen oder Sie können den Kontoeigner bitte, diese zu aktivieren. Um zu prüfen, ob das VLAN-Spanning bereits aktiviert ist, verwenden Sie den [Befehl](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`. Wenn Sie {{site.data.keyword.BluDirectLink}} verwenden, müssen Sie stattdessen eine [ VRF-Funktion (Virtual Router Function)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf) verwenden. Um VRF zu aktivieren, wenden Sie sich an Ihren Ansprechpartner für die IBM Cloud-Infrastruktur (SoftLayer).
      ```
      ibmcloud ks zone-add --zone <zone> --cluster <clustername_oder_-id> --worker-pools <poolname1,poolname2,poolname3> --private-vlan <private_vlan-id> --public-vlan <öffentliche_vlan-id>
      ```
      {: pre}

   3. **So fügen Sie mehrere Zonen zu Ihren Worker-Pools hinzu**: Wiederholen Sie den Befehl `ibmcloud ks zone-add` mit einer anderen Zone und geben Sie die Worker-Pools an, die in dieser Zone bereitgestellt werden sollen. Wenn Sie Ihrem Cluster weitere Zonen hinzufügen, ändern Sie den Cluster von einem Einzelzonencluster in einen [Mehrzonencluster](cs_clusters_planning.html#multizone).

6. Warten Sie, bis die Workerknoten in jeder Zone bereitgestellt wurden.
   ```
   ibmcloud ks workers <clustername_oder_-id>
   ```
   {: pre}
   Wenn sich der Status des Workerknotens in **Normal** ändert, ist die Bereitstellung abgeschlossen.

7. Entfernen Sie die eigenständigen Workerknoten. Wenn Sie mehrere eigenständige Workerknoten haben, entfernen Sie immer jeweils einen Knoten.
   1. Listen Sie die Workerknoten in Ihrem Cluster auf und vergleichen Sie die private IP-Adresse aus diesem Befehl mit der privaten IP-Adresse, die Sie am Anfang abgerufen haben, um Ihre eigenständigen Workerknoten zu finden.
      ```
      kubectl get nodes
      ```
      {: pre}
   2. Markieren Sie den Workerknoten in einem Prozess, der als Abriegelung oder "Cordoning" bezeichnet wird, als nicht planbar ("unschedulable"). Wenn Sie einen Workerknoten abriegeln, ist er für die künftige Pod-Planung nicht mehr verfügbar. Verwenden Sie den Wert für `name`, der im Befehl `kubectl get nodes` zurückgegeben wird.
      ```
      kubectl cordon <workername>
      ```
      {: pre}
   3. Überprüfen Sie, ob die Pod-Planung für Ihren Workerknoten inaktiviert ist
      ```
      kubectl get nodes
      ```
      {: pre}
      Ihr Workerknoten ist für die Pod-Planung inaktiviert, wenn der Status **SchedulingDisabled** angezeigt wird.
   4. Pods müssen aus dem eigenständigen Workerknoten entfernt und auf den verbleibenden entriegelten eigenständigen Workerknoten und Workerknoten aus Ihrem Worker-Pool neu geplant werden.
      ```
      kubectl drain <workername> --ignore-daemonsets
      ```
      {: pre}
      Dieser Prozess kann einige Minuten dauern.

   5. Entfernen Sie den eigenständigen Workerknoten. Verwenden Sie die ID des Workerknotens, den Sie im vorherigen Schritt mit dem Befehl `ibmcloud ks workers <cluster_name_or_ID>` abgerufen haben.
      ```
      ibmcloud ks worker-rm <clustername_oder_-d> <worker-id>
      ```
      {: pre}
   6. Wiederholen Sie diese Schritte, bis alle eigenständigen Workerknoten entfernt wurden.


**Womit möchten Sie fortfahren?** </br>
Nachdem Sie den Cluster aktualisiert haben, um Worker-Pools zu verwenden, können Sie die Verfügbarkeit verbessern, indem Sie Ihrem Cluster weitere Zonen hinzufügen. Durch das Hinzufügen weiterer Zonen zu Ihrem Cluster wird Ihr Cluster von einem Einzelzonencluster in einen [Mehrzonencluster](cs_clusters_planning.html#ha_clusters) geändert. Wenn Sie Ihren Einzelzonencluster in einen Mehrzonencluster ändern, ändert sich die Ingress-Domäne von `<cluster_name>.<region>.containers.mybluemix.net` in `<cluster_name>.<region_or_zone>.containers.appdomain.cloud`. Die vorhandene Ingress-Domäne ist weiterhin gültig und kann zum Senden von Anforderungen an Ihre Apps verwendet werden.
