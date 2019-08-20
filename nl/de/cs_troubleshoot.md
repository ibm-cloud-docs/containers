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
{:tsSymptoms: .tsSymptoms}
{:tsCauses: .tsCauses}
{:tsResolve: .tsResolve}



# Cluster debuggen
{: #cs_troubleshoot}

Ziehen Sie bei der Verwendung von {{site.data.keyword.containerlong}} die folgenden Verfahren für die allgemeine Fehlerbehebung und das Debugging der Kubernetes- oder OpenShift-Cluster Ihrer Community in Betracht. Sie können außerdem den [Status des {{site.data.keyword.cloud_notm}}-Systems ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://developer.ibm.com/bluemix/support/#status) überprüfen.
{: shortdesc}

Sie können die folgenden allgemeinen Schritte ausführen, um sicherzustellen, dass Ihre Cluster auf dem neuesten Stand sind:
- Prüfen Sie einmal im Monat auf verfügbare Sicherheits- und Betriebssystempatches, um [Ihre Workerknoten zu aktualisieren](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_update).
- [Aktualisieren Sie Ihren Cluster](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_update) auf die neueste Standardversion für [Community-Kubernetes](/docs/containers?topic=containers-cs_versions) oder [OpenShift](/docs/containers?topic=containers-cs_versions).<p class="important">Stellen Sie sicher, dass die Kubernetes-Version Ihres [`kubectl`-CLI-Clients](/docs/containers?topic=containers-cs_cli_install#kubectl) mit der Kubernetes-Version Ihres Cluster-Servers übereinstimmt. [Kubernetes unterstützt ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/setup/version-skew-policy/) `kubectl`-Clientversionen nicht, die um zwei oder mehr Versionen von der Serverversion abweichen (n +/- 2).</p>

## Tests mit {{site.data.keyword.containerlong_notm}} Diagnostics and Debug Tool durchführen
{: #debug_utility}

Bei der Fehlerbehebung können Sie {{site.data.keyword.containerlong_notm}} Diagnostics and Debug Tool verwenden, um Tests durchzuführen und relevante Informationen aus Ihrem Cluster zu erfassen. Zur Verwendung des Debug-Tools installieren Sie das [Helm-Diagramm `ibmcloud-iks-debug` ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cloud.ibm.com/kubernetes/helm/iks-charts/ibmcloud-iks-debug):
{: shortdesc}


1. [Richten Sie Helm in Ihrem Cluster ein, erstellen Sie ein Servicekonto für Tiller und fügen Sie Ihrer Helm-Instanz das Repository `ibm` hinzu](/docs/containers?topic=containers-helm).

2. Installieren Sie das Helm-Diagramm in Ihrem Cluster.
  ```
  helm install iks-charts/ibmcloud-iks-debug --name debug-tool
  ```
  {: pre}

3. Starten Sie einen Proxy-Server, um die Debug-Tool-Schnittstelle anzuzeigen.
  ```
  kubectl proxy --port 8080
  ```
  {: pre}

4. Öffnen Sie in einem Webbrowser die URL der Debug-Tool-Schnittstelle: http://localhost:8080/api/v1/namespaces/default/services/debug-tool-ibmcloud-iks-debug:8822/proxy/page

5. Wählen Sie einzelne Tests oder eine Gruppe von Tests aus, die durchgeführt werden sollen. Einige Tests prüfen auf potenzielle Warnungen, Fehler oder Probleme, während andere Tests nur Informationen zusammenstellen, auf die Sie bei der Fehlersuche zurückgreifen können. Weitere Informationen zur Funktion der einzelnen Test erhalten Sie, wenn Sie auf das Informationssymbol neben dem Namen des Tests klicken.

6. Klicken Sie auf **Run** (Ausführen).

7. Prüfen Sie die Ergebnisse jedes Tests.
  * Wenn ein Test einen Fehler meldet, klicken Sie auf das Informationssymbol neben dem Namen des Tests in der linken Spalte, um Informationen zur Lösung des Problems anzuzeigen.
  * Sie können die Ergebnisse von Tests auch zur Zusammenstellung von Informationen, wie zum Beispiel vollständige YAML-Dateien, verwenden, die Ihnen beim Debugging Ihrer Cluster in den folgenden Abschnitten helfen können.

## Cluster debuggen
{: #debug_clusters}

Informieren Sie sich über die Optionen, die Ihnen für die Fehlerbehebung bei Ihren Clustern und zum Eingrenzen der jeweiligen Fehlerquelle zur Verfügung stehen.

1.  Listen Sie Ihren Cluster auf und suchen Sie nach `Status` des Clusters.

  ```
  ibmcloud ks clusters
  ```
  {: pre}

2.  Überprüfen Sie den `Status` Ihres Clusters. Wenn Ihr Cluster den Status **Critical**, **Delete failed** oder **Warning** aufweist oder sich seit längerer Zeit im Status **Pending** befindet, beginnen Sie mit dem [Debugging der Workerknoten](#debug_worker_nodes).

    Sie können den aktuellen Clusterstatus anzeigen, indem Sie den Befehl `ibmcloud ks clusters` ausführen. Der Status wird im entsprechenden **Statusfeld** angezeigt. 
{: shortdesc}

<table summary="Jede Tabellenzeile sollte von links nach rechts gelesen werden, wobei der Clusterstatus in der ersten Spalte und eine Beschreibung in der zweiten Spalte angegeben ist.">
<caption>Clusterstatus</caption>
   <thead>
   <th>Clusterstatus</th>
   <th>Beschreibung</th>
   </thead>
   <tbody>
<tr>
   <td>`Aborted (Abgebrochen)`</td>
   <td>Das Löschen des Clusters wird vom Benutzer angefordert, bevor der Kubernetes Master bereitgestellt ist. Nachdem das Löschen des Clusters abgeschlossen ist, wird der Cluster aus dem Dashboard entfernt. Wenn Ihr Cluster in diesem Status lange Zeit blockiert ist, öffnen Sie einen [{{site.data.keyword.cloud_notm}}-Supportfall](/docs/containers?topic=containers-cs_troubleshoot#ts_getting_help).</td>
   </tr>
 <tr>
     <td>`Critical (Kritisch)`</td>
     <td>Der Kubernetes-Master kann nicht erreicht werden oder alle Workerknoten in dem Cluster sind inaktiv. Wenn Sie in Ihrem Cluster {{site.data.keyword.keymanagementservicelong_notm}} aktiviert haben, dann kann der {{site.data.keyword.keymanagementserviceshort}}-Container die geheimen Schlüssel Ihres Clusters möglicherweise nicht verschlüsseln oder entschlüsseln. In diesem Fall wird eine Fehlernachricht angezeigt, die weiterführende Informationen enthält, wenn Sie den Befehl `kubectl get secrets` ausführen.</td>
    </tr>
   <tr>
     <td>`Delete failed (Löschen fehlgeschlagen)`</td>
     <td>Der Kubernetes Masterknoten oder mindestens ein Workerknoten kann nicht gelöscht werden.  </td>
   </tr>
   <tr>
     <td>`Deleted (Gelöscht)`</td>
     <td>Der Cluster wird gelöscht, aber noch nicht aus dem Dashboard entfernt. Wenn Ihr Cluster in diesem Status lange Zeit blockiert ist, öffnen Sie einen [{{site.data.keyword.cloud_notm}}-Supportfall](/docs/containers?topic=containers-cs_troubleshoot#ts_getting_help). </td>
   </tr>
   <tr>
   <td>`Deleting (Löschen)`</td>
   <td>Der Cluster wird gelöscht, und die Clusterinfrastruktur wird abgebaut. Der Zugriff auf den Cluster ist nicht möglich.  </td>
   </tr>
   <tr>
     <td>`Deploy failed (Bereitstellung fehlgeschlagen)`</td>
     <td>Die Bereitstellung des Kubernetes-Masters konnte nicht abgeschlossen werden. Sie können diesen Status nicht auflösen. Wenden Sie sich an den Support für IBM Cloud, indem Sie einen [{{site.data.keyword.cloud_notm}}-Supportfall](/docs/containers?topic=containers-cs_troubleshoot#ts_getting_help) öffnen.</td>
   </tr>
     <tr>
       <td>`Deploying (Wird bereitgestellt)`</td>
       <td>Der Kubernetes-Master ist noch nicht vollständig implementiert. Sie können auf Ihren Cluster nicht zugreifen. Warten Sie, bis Ihr Cluster vollständig bereitgestellt wurde, und überprüfen Sie dann den Status Ihres Clusters.</td>
      </tr>
      <tr>
       <td>`Normal`</td>
       <td>Alle Workerknoten in einem Cluster sind betriebsbereit. Sie können auf den Cluster zugreifen und Apps auf dem Cluster bereitstellen. Dieser Status wird als einwandfreier Zustand betrachtet und erfordert keine Aktion von Ihnen.<p class="note">Auch wenn die Workerknoten ordnungsgemäß funktionieren, bedürfen andere Infrastrukturressourcen wie [Netz](/docs/containers?topic=containers-cs_troubleshoot_network) und [Speicher](/docs/containers?topic=containers-cs_troubleshoot_storage) möglicherweise Ihrer Aufmerksamkeit. Wenn Sie den Cluster gerade erstellt haben, befinden sich einige Teile des Clusters, die von anderen Services wie z. B. geheimen Ingress-Schlüsseln oder geheimen Schlüsseln für Registry-Image-Pull-Operationen verwendet werden, möglicherweise noch in Bearbeitung.</p></td>
    </tr>
      <tr>
       <td>`Pending (Anstehend)`</td>
       <td>Der Kubernetes-Master ist bereitgestellt. Die Workerknoten werden gerade eingerichtet und sind noch nicht im Cluster verfügbar. Sie können auf den Cluster zugreifen, aber Sie können keine Apps auf dem Cluster bereitstellen.  </td>
     </tr>
   <tr>
     <td>`Requested (Angefordert)`</td>
     <td>Eine Anforderung zum Erstellen des Clusters und zum Bestellen der Infrastruktur für die Kubernetes Master- und Workerknoten wird gesendet. Wenn die Bereitstellung des Clusters gestartet wird, ändert sich der Clusterstatus in <code>Deploying</code> (Wird bereitgestellt). Wenn Ihr Cluster lange Zeit im Status <code>Requested</code> (Angefordert) blockiert ist, öffnen Sie einen [{{site.data.keyword.cloud_notm}}-Supportfall](/docs/containers?topic=containers-cs_troubleshoot#ts_getting_help). </td>
   </tr>
   <tr>
     <td>`Updating (Aktualisierung)`</td>
     <td>Der Kubernetes API-Server, der in Ihrem Kubernetes-Master ausgeführt wird, wird auf eine neue Version der Kubernetes-API aktualisiert. Während der Aktualisierung können Sie weder auf den Cluster zugreifen noch Änderungen am Cluster vornehmen. Workerknoten, Apps und Ressourcen, die vom Benutzer bereitgestellt wurden, werden nicht geändert und weiterhin ausgeführt. Warten Sie, bis die Aktualisierung abgeschlossen ist, und überprüfen Sie dann den Status Ihres Clusters. </td>
   </tr>
   <tr>
    <td>`Nicht unterstützt`</td>
    <td>Die [Kubernetes-Version](/docs/containers?topic=containers-cs_versions#cs_versions), die der Cluster ausführt, wird nicht mehr unterstützt. Der Zustand des Clusters wird nicht mehr aktiv überwacht oder gemeldet. Darüber hinaus können Sie keine Workerknoten hinzufügen oder erneut laden. Um weiterhin wichtige Sicherheitsupdates und Unterstützung erhalten zu können, müssen Sie Ihren Cluster aktualisieren. Prüfen Sie die [Aktionen zum Vorbereiten der Versionsaktualisierung](/docs/containers?topic=containers-cs_versions#prep-up) und [aktualisieren Sie Ihren Cluster](/docs/containers?topic=containers-update#update) auf eine unterstützte Kubernetes-Version.<br><br><p class="note">Cluster mit einer Version, die drei oder mehr Versionen älter als die älteste unterstützte Version ist, können nicht aktualisiert werden. Zur Vermeidung dieser Situation können Sie den Cluster auf eine Kubernetes-Version aktualisieren, die der aktuellen Version weniger als drei Versionen voraus ist, wie zum Beipiel die Versionen 1.12 bis 1.14. Wenn Ihre Cluster Version 1.5, 1.7 oder 1.8 ausführt, ist die Version zu alt für eine Aktualisierung. Stattdessen müssen Sie [einen Cluster erstellen](/docs/containers?topic=containers-clusters#clusters) und [Ihre Apps für den Cluster bereitstellen](/docs/containers?topic=containers-app#app).</p></td>
   </tr>
    <tr>
       <td>`Warning (Warnung)`</td>
       <td><ul><li>Mindestens ein Workerknoten in dem Cluster ist nicht verfügbar, aber andere Workerknoten sind verfügbar und können die Workload übernehmen. Versuchen Sie, die nicht verfügbaren Workerknoten [erneut zu laden](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_reload).</li>
       <li>Ihr Cluster verfügt über null Workerknoten, was auch der Fall wäre, wenn Sie einen Cluster ohne Workerknoten erstellt oder alle Workerknoten manuell aus dem Cluster entfernt hätten. [Ändern Sie die Größe Ihres Worker-Pools](/docs/containers?topic=containers-add_workers#resize_pool), um Workerknoten hinzuzufügen und das System nach Auftreten des Status `Warnung` wiederherzustellen.</li>
       <li>Eine Operation auf Steuerebene für Ihren Cluster ist fehlgeschlagen. Zeigen Sie den Cluster in der Konsole an und führen Sie den Befehl `ibmcloud ks cluster-get --cluster <cluster_name_or_ID>` aus, um den [**Masterstatus** zur weiteren Fehlerbehebung zu überprüfen](/docs/containers?topic=containers-cs_troubleshoot#debug_master).</li></ul></td>
    </tr>
   </tbody>
 </table>


Der [Kubernetes-Master](/docs/containers?topic=containers-ibm-cloud-kubernetes-service-technology#architecture) ist die Hauptkomponente, die den Cluster betriebsbereit hält. Der Master speichert Clusterressourcen und ihre Konfigurationen in der etcd-Datenbank, die als Single Point of Truth für Ihren Cluster dient. Der Kubernetes-API-Server dient als Haupteinstiegspunkt für alle Anforderungen der Clusterverwaltung von den Workerknoten zum Master oder wenn Sie mit Ihren Clusterressourcen interagieren möchten.<br><br>Wenn ein Masterausfall auftritt, werden Ihre Workloads weiterhin auf den Workerknoten ausgeführt, Sie können jedoch erst wieder `kubectl`-Befehle verwenden, um mit Ihren Clusterressourcen zu arbeiten oder den Clusterzustand anzuzeigen, wenn der Kubernetes-API-Server im Master wieder betriebsbereit ist. Wenn ein Pod während des Ausfalls des Masters inaktiv ist, kann der Pod erst wieder ausgeführt werden, wenn der Workerknoten den Kubernetes-API-Server wieder erreichen kann.<br><br>Während eines Masterausfalls können Sie `ibmcloud ks`-Befehle weiterhin für die {{site.data.keyword.containerlong_notm}}-API ausführen, um mit Ihren Infrastrukturressourcen zu arbeiten (z. B. Workerknoten oder VLANs). Wenn Sie die aktuelle Clusterkonfiguration ändern, indem Sie Workerknoten zum Cluster hinzufügen oder aus ihm entfernen, werden die Änderungen erst wirksam, wenn der Master wieder betriebsbereit ist.

Ein Workerknoten darf während eines Masterausfalls nicht neu gestartet werden. Durch diese Aktion werden die Pods aus dem Workerknoten entfernt. Da der Kubernetes-API-Server nicht verfügbar ist, können die Pods nicht auf andere Workerknoten im Cluster umgestellt werden.
{: important}


<br />


## Debugging der Workerknoten
{: #debug_worker_nodes}

Informieren Sie sich über die Optionen, die Ihnen für die Fehlerbehebung bei Ihren Workerknoten und zum Eingrenzen der jeweiligen Fehlerquelle zur Verfügung stehen.

<ol><li>Wenn Ihr Cluster den Status **Critical**, **Delete failed** oder **Warning** aufweist oder sich seit längerer Zeit im Status **Pending** befindet, überprüfen Sie den Status Ihrer Workerknoten.<p class="pre">ibmcloud ks workers --cluster <clustername_oder_-id></p></li>
<li>Überprüfen Sie die Felder **State** (Zustand) und **Status** für jeden Workerknoten in Ihrer CLI-Ausgabe.<p>Sie können den aktuellen Workerknotenzustand anzeigen, indem Sie den Befehl `ibmcloud ks workers --cluster <clustername_oder_ID` ausführen. Der Status und der Zustand werden in den entsprechenden Feldern ******** angezeigt.
{: shortdesc}

<table summary="Jede Tabellenzeile sollte von links nach rechts gelesen werden, wobei der Clusterstatus in der ersten Spalte und eine Beschreibung in der zweiten Spalte angegeben ist.">
<caption>Status des Workerknotens</caption>
  <thead>
  <th>Status des Workerknotens</th>
  <th>Beschreibung</th>
  </thead>
  <tbody>
<tr>
    <td>`Critical (Kritisch)`</td>
    <td>Ein Workerknoten kann aus vielen Gründen in einen kritischen Status wechseln: <ul><li>Sie haben einen Warmstart für Ihren Workerknoten eingeleitet, ohne den Workerknoten zu abzuriegeln und zu entleeren. Der Warmstart eines Workerknotens kann zu Datenverlust in <code>containerd</code>, <code>kubelet</code>, <code>kube-proxy</code> und <code>calico</code> führen. </li>
    <li>Die Pods, die auf Ihrem Workerknoten bereitgestellt wurden, verwenden keine Ressourcengrenzen für [Speicher ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tasks/configure-pod-container/assign-memory-resource/) und [CPU ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tasks/configure-pod-container/assign-cpu-resource/). Ohne Ressourcengrenzen können die Pods alle verfügbaren Ressourcen in Anspruch nehmen und keine Ressourcen mehr für andere Pods übrig lassen, die auch auf diesem Workerknoten ausgeführt werden. Diese Überbelegung durch Workload führt dazu, dass der Workerknoten fehlschlägt. </li>
    <li><code>containerd</code>, <code>kubelet</code> oder <code>calico</code> geraten in einen nicht behebbaren kritischen Zustand, nachdem Hunderte oder Tausende von Containern ausgeführt wurden. </li>
    <li>Sie haben eine Virtual Router Appliance für Ihren Workerknoten eingerichtet, die fehlschlug und die Kommunikation zwischen Ihrem Workerknoten und dem Kubernetes-Master unterbrochen hat. </li><li> Aktuelle Netzprobleme in {{site.data.keyword.containerlong_notm}} oder in der IBM Cloud-Infrastruktur, die ein Fehlschlagen der Kommunikation zwischen Ihrem Workerknoten und dem Kubernetes-Master verursachen.</li>
    <li>Ihr Workerknoten hat keine Kapazität mehr. Überprüfen Sie den <strong>Status</strong> des Workerknotens, um zu sehen, ob <strong>Out of disk</strong> (zu wenig Plattenspeicher) oder <strong>Out of memory</strong> (zu wenig Hauptspeicher) angezeigt wird. Wenn Ihr Workerknoten die Kapazitätsgrenze erreicht hat, können Sie entweder die Arbeitslast auf Ihrem Workerknoten reduzieren oder einen Workerknoten zu Ihrem Cluster hinzufügen und so den Lastausgleich verbessern.</li>
    <li>Die Einheit wurde über die [Ressourcenliste der {{site.data.keyword.cloud_notm}}-Konsole ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cloud.ibm.com/resources) ausgeschaltet. Öffnen Sie die Ressourcenliste und suchen Sie Ihre Workerknoten-ID in der Liste **Geräte**. Klicken Sie im Aktionsmenü auf die Option **Einschalten**.</li></ul>
    In vielen Fällen kann ein [Neuladen](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_reload) Ihres Workerknotens das Problem lösen. Wenn Sie Ihren Workerknoten neu laden, wird die aktuellste [Patchversion](/docs/containers?topic=containers-cs_versions#version_types) auf Ihren Workerknoten angewendet. Die Haupt- und Nebenversion werden nicht geändert. Bevor Sie Ihren Workerknoten erneut laden, stellen Sie sicher, dass Ihr Workerknoten abgeriegelt und entleert wurde, damit die vorhandenen Pods ordnungsgemäß beendet und auf den verbleibenden Workerknoten neu geplant werden können. </br></br> Wenn das Neuladen des Workerknotens das Problem nicht löst, wechseln Sie zum nächsten Schritt, um mit der Fehlerbehebung Ihrer Workerknoten fortzufahren. </br></br><strong>Tipp:</strong> Sie können [Statusprüfungen für Ihre Workerknoten konfigurieren und die automatische Wiederherstellung aktiveren](/docs/containers?topic=containers-health#autorecovery). Wenn die automatische Wiederherstellung basierend auf den konfigurierten Prüfungen einen nicht ordnungsgemäß funktionierenden Workerknoten erkennt, löst das System eine Korrekturmaßnahme, wie das erneute Laden des Betriebssystems, auf dem Workerknoten aus. Weitere Informationen zur Funktionsweise der automatischen Wiederherstellung finden Sie im [Blogbeitrag zur automatischen Wiederherstellung![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/blogs/bluemix/2017/12/autorecovery-utilizes-consistent-hashing-high-availability/).
    </td>
   </tr>
   <tr>
   <td>`Deployed (Bereitgestellt)`</td>
   <td>Aktualisierungen wurden erfolgreich auf Ihrem Workerknoten bereitgestellt. Nach der Bereitstellung von Aktualisierungen startet {{site.data.keyword.containerlong_notm}} eine Zustandsprüfung auf dem Workerknoten. Wenn die Zustandsprüfung erfolgreich war, wechselt der Workerknoten in den Status <code>Normal</code>. Workerknoten im Status <code>Deployed</code> (Bereitgestellt) sind normalerweise dafür bereit, Workloads zu empfangen. Sie können dies überprüfen, indem Sie <code>kubectl get nodes</code> ausführen und bestätigen, dass der Zustand <code>Normal</code> angezeigt wird. </td>
   </tr>
    <tr>
      <td>`Deploying (Wird bereitgestellt)`</td>
      <td>Wenn Sie die Kubernetes-Version Ihres Workerknotens aktualisieren, wird der Workerknoten erneut bereitgestellt, um die Aktualisierungen zu installieren. Wenn Sie Ihren Workerknoten neu starten, wird der Workerknoten erneut bereitgestellt, um die neueste Patchversion automatisch zu installieren. Falls sich Ihr Workerknoten eine längere Zeit in diesem Status befindet, fahren Sie mit dem nächsten Schritt fort, um zu sehen, ob während der Bereitstellung ein Problem aufgetreten ist. </td>
   </tr>
      <tr>
      <td>`Normal`</td>
      <td>Ihr Workerknoten wurde vollständig bereitgestellt und kann im Cluster verwendet werden. Dieser Status wird als einwandfreier Zustand betrachtet und erfordert keine Aktion vom Benutzer. **Hinweis**: Auch wenn die Workerknoten ordnungsgemäß funktionieren, bedürfen andere Infrastrukturressourcen wie [Netz](/docs/containers?topic=containers-cs_troubleshoot_network) und [Speicher](/docs/containers?topic=containers-cs_troubleshoot_storage) möglicherweise Ihrer Aufmerksamkeit.</td>
   </tr>
 <tr>
      <td>`Provisioning (Wird bereitgestellt)`</td>
      <td>Ihr Workerknoten wird gerade eingerichtet und ist noch nicht im Cluster verfügbar. Sie können den Bereitstellungsprozess in der Spalte <strong>Status</strong> Ihrer CLI-Ausgabe überwachen. Falls sich Ihr Workerknoten eine längere Zeit in diesem Status befindet, fahren Sie mit dem nächsten Schritt fort, um zu sehen, ob während der Bereitstellung ein Problem aufgetreten ist.</td>
    </tr>
    <tr>
      <td>`Provision_failed (Bereitstellung fehlgeschlagen)`</td>
      <td>Ihr Workerknoten konnte nicht bereitgestellt werden. Fahren Sie mit dem nächsten Schritt fort, um die Details des Fehlers abzurufen.</td>
    </tr>
 <tr>
      <td>`Reloading (Wird neu geladen)`</td>
      <td>Ihr Workerknoten wird neu geladen und ist nicht im Cluster verfügbar. Sie können den Neuladeprozess in der Spalte <strong>Status</strong> Ihrer CLI-Ausgabe überwachen. Falls sich Ihr Workerknoten eine längere Zeit in diesem Status befindet, fahren Sie mit dem nächsten Schritt fort, um zu sehen, ob während des Neuladens ein Problem aufgetreten ist.</td>
     </tr>
     <tr>
      <td>`Reloading_failed (Neuladen fehlgeschlagen) `</td>
      <td>Ihr Workerknoten konnte nicht neu geladen werden. Fahren Sie mit dem nächsten Schritt fort, um die Details des Fehlers abzurufen.</td>
    </tr>
    <tr>
      <td>`Reload_pending (Neuladen anstehend) `</td>
      <td>Eine Anforderung zum Neuladen oder Aktualisieren der Kubernetes-Version Ihrer Workerknoten wurde gesendet. Wenn der Workerknoten erneut geladen wird, ändert sich der Status in <code>Reloading</code>. </td>
    </tr>
    <tr>
     <td>`Unknown (Unbekannt)`</td>
     <td>Der Kubernetes-Master ist aus einem der folgenden Gründe nicht erreichbar:<ul><li>Sie haben ein Update Ihres Kubernetes-Masters angefordert. Der Status des Workerknotens kann während des Updates nicht abgerufen werden. Wenn der Workerknoten auch nach einer erfolgreichen Aktualisierung des Kubernetes-Masters für längere Zeit in diesem Status verbleibt, versuchen Sie, den Workerknoten [erneut zu laden](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_reload).</li><li>Sie haben möglicherweise eine weitere Firewall, die Ihre Workerknoten schützt, oder Sie haben die Firewalleinstellungen kürzlich geändert. {{site.data.keyword.containerlong_notm}} erfordert, dass bestimmte IP-Adressen und Ports geöffnet sind, damit die Kommunikation vom Workerknoten zum Kubernetes-Master und umgekehrt möglich ist. Weitere Informationen finden Sie in [Firewall verhindert Verbindung für Workerknoten](/docs/containers?topic=containers-cs_troubleshoot_clusters#cs_firewall).</li><li>Der Kubernetes-Master ist inaktiv. Wenden Sie sich an den {{site.data.keyword.cloud_notm}}-Support, indem Sie einen [{{site.data.keyword.cloud_notm}}-Supportfall](/docs/containers?topic=containers-cs_troubleshoot#ts_getting_help) öffnen.</li></ul></td>
</tr>
   <tr>
      <td>`Warning (Warnung)`</td>
      <td>Ihr Workerknoten nähert sich dem Grenzwert für die Speicher- oder Plattenkapazität. Sie können entweder die Arbeitslast auf Ihrem Workerknoten reduzieren oder einen Workerknoten zu Ihrem Cluster hinzufügen und so den Lastausgleich verbessern.</td>
</tr>
  </tbody>
</table>
</p></li>
<li>Listen Sie die Details für den Workerknoten auf. Wenn die Details eine Fehlernachricht enthalten, überprüfen Sie die Liste der [gängigen Fehlernachrichten für Workerknoten](#common_worker_nodes_issues) und lernen Sie, diese Probleme zu beheben.<p class="pre">ibmcloud ks worker-get --cluster <clustername_oder_-id> --worker <workerknoten-id></p></li>
</ol>

<br />


## Gängige Fehlernachrichten bei Workerknoten
{: #common_worker_nodes_issues}

Überprüfen Sie gängige Fehlernachrichten und lernen Sie, diese zu beheben.

  <table>
  <caption>Allgemeine Fehlernachrichten</caption>
    <thead>
    <th>Fehlernachricht</th>
    <th>Beschreibung und Problemlösung
    </thead>
    <tbody>
      <tr>
        <td>{{site.data.keyword.cloud_notm}} classic infrastructure exception: Your account is currently prohibited from ordering 'Computing Instances'.</td>
        <td>Ihr Konto in der IBM Cloud-Infrastruktur wurde möglicherweise für die Bestellung von Rechenressourcen gesperrt. Wenden Sie sich an den {{site.data.keyword.cloud_notm}}-Support, indem Sie einen [{{site.data.keyword.cloud_notm}}-Supportfall](#ts_getting_help) öffnen.</td>
      </tr>
      <tr>
      <td>{{site.data.keyword.cloud_notm}} classic infrastructure exception: Could not place order.<br><br>
      {{site.data.keyword.cloud_notm}} classic infrastructure exception: Could not place order. There are insufficient resources behind router 'routername' to fulfill the request for the following guests: 'worker-id'.</td>
      <td>Die Zone, die Sie ausgewählt haben, hat möglicherweise nicht genug Infrastrukturkapazität, um Ihre Workerknoten einzurichten. Oder Sie haben möglicherweise einen Grenzwert in Ihrem Konto der IBM Cloud-Infrastruktur überschritten. Führen Sie eine der folgenden Optionen aus, um eine Lösung zu finden:
      <ul><li>Die Verfügbarkeit der Infrastrukturressourcen kann in den einzelnen Zonen variieren. Warten Sie ein paar Minuten und versuchen Sie es erneut.</li>
      <li>Für einen Einzelzonencluster erstellen Sie den Cluster in einer anderen Zone. Für einen Mehrzonencluster fügen Sie eine Zone zu dem Cluster hinzu.</li>
      <li>Geben Sie ein anderes Paar aus öffentlichen und privaten VLANs für Ihre Workerknoten in Ihrem Konto der IBM Cloud-Infrastruktur an. Für Workerknoten, die sich in einem Worker-Pool befinden, können Sie den [Befehl](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_zone_network_set) <code>ibmcloud ks zone-network-set</code> verwenden.</li>
      <li>Wenden Sie sich an den Manager des Kontos der IBM Cloud-Infrastruktur, um sicherzustellen, dass Sie keine Kontobegrenzung (z. B. eine globale Quote) überschreiten.</li>
      <li>Öffnen Sie einen Supportfall für die [IBM Cloud-Infrastruktur](#ts_getting_help).</li></ul></td>
      </tr>
      <tr>
        <td>{{site.data.keyword.cloud_notm}} classic infrastructure exception: Could not obtain network VLAN with ID: <code>&lt;vlan id&gt;</code>.</td>
        <td>Ihr Workerknoten konnte nicht bereitgestellt werden, weil die ausgewählte VLAN-ID aus einem der folgenden Gründe nicht gefunden werden konnte:<ul><li>Möglicherweise haben Sie statt der VLAN-ID die VLAN-Nummer angegeben. Die VLAN-Nummer umfasst 3 oder 4 Ziffern, während die VLAN-ID 7 Stellen hat. Führen Sie den Befehl <code>ibmcloud ks vlans --zone &lt;zone&gt;</code> aus, um die VLAN-ID abzurufen.<li>Möglicherweise ist die VLAN-ID nicht dem von Ihnen verwendeten Konto der IBM Cloud-Infrastruktur zugeordnet. Führen Sie den Befehl <code>ibmcloud ks vlans --zone &lt;zone&gt;</code> aus, um verfügbare VLAN-IDs für Ihr Konto aufzulisten. Um das Konto der IBM Cloud-Infrastruktur zu ändern, lesen Sie die Informationen unter [`ibmcloud ks credential-set`](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_credentials_set). </ul></td>
      </tr>
      <tr>
        <td>SoftLayer_Exception_Order_InvalidLocation: The location provided for this order is invalid. (HTTP 500)</td>
        <td>Ihr System von IBM Cloud Infrastructure ist nicht für das Bestellen von Rechenressourcen im ausgewählten Rechenzentrum eingerichtet. Wenden Sie sich an den [{{site.data.keyword.cloud_notm}}-Support](#ts_getting_help), um sicherzustellen, dass Ihr Konto korrekt eingerichtet ist.</td>
       </tr>
       <tr>
        <td>{{site.data.keyword.cloud_notm}} classic infrastructure exception: The user does not have the necessary {{site.data.keyword.cloud_notm}} classic infrastructure permissions to add servers
        </br></br>
        {{site.data.keyword.cloud_notm}} classic infrastructure exception: 'Item' must be ordered with permission.
        </br></br>
        Die Berechtigungsnachweise für die klassische {{site.data.keyword.cloud_notm}}-Infrastruktur konnten nicht validiert werden.</td>
        <td>Möglicherweise verfügen Sie nicht über die erforderlichen Berechtigungen zum Ausführen der Aktion in Ihrem Portfolio der IBM Cloud-Infrastruktur oder Sie verwenden die falschen Infrastrukturberechtigungsnachweise. Informationen hierzu finden Sie im Abschnitt [API-Schlüssel für Aktivierung des Zugriffs auf Infrastrukturportfolio konfigurieren](/docs/containers?topic=containers-users#api_key).</td>
      </tr>
      <tr>
       <td>Worker unable to talk to {{site.data.keyword.containerlong_notm}} servers. Please verify your firewall setup is allowing traffic from this worker.
       <td><ul><li>Wenn Sie über eine Firewall verfügen, [konfigurieren Sie Ihre Firewalleinstellungen so, dass sie ausgehenden Datenverkehr zu den entsprechenden Ports und IP-Adressen zulassen](/docs/containers?topic=containers-firewall#firewall_outbound).</li>
       <li>Überprüfen Sie durch Ausführen des Befehls `ibmcloud ks workers --cluster <mycluster>`, ob Ihr Cluster keine öffentliche IP hat. Wenn keine öffentliche IP aufgelistet wird, verfügt Ihr Cluster nur über private VLANs.
       <ul><li>Wenn Sie möchten, dass der Cluster nur über private VLANs verfügt, konfigurieren Sie die [VLAN-Verbindung](/docs/containers?topic=containers-plan_clusters#private_clusters) und die [Firewall](/docs/containers?topic=containers-firewall#firewall_outbound).</li>
       <li>Wenn Sie den Cluster nur mit dem privaten Serviceendpunkt erstellt haben, bevor Sie Ihr Konto für [VRF](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud) und [Serviceendpunkte](/docs/resources?topic=resources-private-network-endpoints#getting-started) aktiviert haben, können Ihre Worker keine Verbindung zum Master herstellen. Versuchen Sie, [den öffentlichen Serviceendpunkt einzurichten](/docs/containers?topic=containers-cs_network_cluster#set-up-public-se), damit Sie Ihren Cluster verwenden können, bis Ihre Supportfälle zur Aktualisierung Ihres Kontos bearbeitet wurden. Wenn Sie auch nach der Aktualisierung Ihres Kontos mit einem Cluster mit nur einem privaten Serviceendpunkt arbeiten möchten, können Sie den öffentlichen Serviceendpunkt inaktivieren.</li>
       <li>Wenn Sie möchten, dass der Cluster über eine öffentliche IP verfügt, [fügen Sie neue Workerknoten](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_add) mit öffentlichen und privaten VLANs hinzu.</li></ul></li></ul></td>
     </tr>
      <tr>
  <td>IMS-Portaltoken kann nicht erstellt werden, da kein IMS-Konto mit dem ausgewählten BSS-Konto verknüpft ist</br></br>Angegebener Benutzer nicht gefunden bzw. aktiv</br></br>SoftLayer_Exception_User_Customer_InvalidUserStatus: User account is currently cancel_pending.</br></br>Worker not found. Überprüfen Sie die Benutzerberechtigungen der klassischen {{site.data.keyword.cloud_notm}}-Infrastruktur.</td>
  <td>Der Eigner des API-Schlüssels, der für den Zugriff auf das Portfolio von IBM Cloud Infrastructure verwendet wird, verfügt nicht über die erforderlichen Berechtigungen zum Ausführen der Aktion oder es steht die Löschung der Berechtigungen an.</br></br><strong>Als Benutzer</strong> befolgen Sie diese Schritte:
  <ol><li>Wenn Sie Zugriff auf mehrere Konten haben, stellen Sie sicher, dass Sie bei dem Konto angemeldet sind, in dem Sie mit {{site.data.keyword.containerlong_notm}} arbeiten möchten. </li>
  <li>Führen Sie den Befehl <code>ibmcloud ks api-key-info --cluster &lt;clustername_oder_-id&gt;</code> aus, um den aktuellen Eigner des API-Schlüssels anzuzeigen, der für den Zugriff auf das Portfolio der IBM Cloud-Infrastruktur verwendet wird. </li>
  <li>Führen Sie den Befehl <code>ibmcloud account list</code> aus, um den Eigner des {{site.data.keyword.cloud_notm}}-Kontos anzuzeigen, das Sie aktuell verwenden. </li>
  <li>Kontaktieren Sie den Eigner des {{site.data.keyword.cloud_notm}}-Kontos und melden Sie, dass der Eigner des API-Schlüssels nicht über ausreichende Berechtigungen in IBM Cloud Infrastructure verfügt oder dass die Löschung der Berechtigungen ansteht. </li></ol>
  </br><strong>Als Kontoeigner</strong>, führen Sie diese Schritte aus:
  <ol><li>Überprüfen Sie die [erforderlichen Berechtigungen in IBM Cloud Infrastructure](/docs/containers?topic=containers-users#infra_access), um die Aktion auszuführen, die zuvor fehlgeschlagen ist. </li>
  <li>Korrigieren Sie die Berechtigungen des API-Schlüsseleigners oder erstellen Sie mithilfe des Befehls [<code>ibmcloud ks api-key-reset --region <region></code>](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_api_key_reset) einen neuen API-Schlüssel. </li>
  <li>Wenn durch Sie oder einen anderen Kontoadministrator Berechtigungsnachweise für die IBM Cloud-Infrastruktur manuell in Ihrem Konto definiert wurden, führen Sie den Befehl [<code>ibmcloud ks credential-unset --region <region></code>](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_credentials_unset) aus, um die Berechtigungsnachweise aus Ihrem Konto zu entfernen. </li></ol></td>
  </tr>
    </tbody>
  </table>

<br />


## Masterstatus überprüfen
{: #debug_master}

Ihre {{site.data.keyword.containerlong_notm}}-Instanz schließt einen IBM verwalteten Master mit Hochverfügbarkeitsreplikaten, für Sie angewendete automatische Sicherheitspatchaktualisierungen sowie Automatisierung zur Wiederherstellung nach einer Störung ein. Sie können den Zustand und den Status des Cluster-Masters überprüfen, indem Sie `ibmcloud ks cluster-get --cluster <clustername_oder_-id>` ausführen.
{: shortdesc} 

**Masterstatus (Master Health)**<br>
Der **Masterstatus** (Master Health) spiegelt den Status der Masterkomponenten wider und benachrichtigt Sie, wenn Ihre Aufmerksamkeit erforderlich ist. Der Status kann einen der folgenden Werte aufweisen:
*   `error (Fehler)`: Der Master ist nicht betriebsbereit. IBM wird automatisch benachrichtigt und ergreift Maßnahmen zur Behebung dieses Problems. Sie können den Status weiter überwachen, bis der Master den Status `normal` aufweist.
*   `normal (Normal)`: Der Master ist betriebsbereit und in einwandfreiem Zustand. Es ist keine Aktion erforderlich.
*   `unavailable (nicht verfügbar)`: Der Master ist möglicherweise nicht zugänglich. Dies bedeutet, dass einige Aktionen, wie z. B. die Änderung der Größe eines Worker-Pools, vorübergehend nicht verfügbar sind. IBM wird automatisch benachrichtigt und ergreift Maßnahmen zur Behebung dieses Problems. Sie können den Status weiter überwachen, bis der Master den Status `normal` aufweist. 
*   `unsupported (nicht unterstützt)`: Der Master führt eine nicht unterstützte Version von Kubernetes aus. Sie müssen [Ihren Cluster aktualisieren](/docs/containers?topic=containers-update), um den Master wieder in  einen normalen Status (`normal`) zu versetzen.

**Masterstatus und -zustand**<br>
Der **Masterstatus** (Master Status) stellt Details zu den Operationen bereit, die über den Masterzustand in Bearbeitung sind. Der Status umfasst eine Zeitmarke dazu, wie lange der Master sich in demselben Zustand befand, z. B. `Ready (1 month ago)` (Bereit (vor 1 Monat). Der **Masterzustand** (Master State) spiegelt den Lebenszyklus möglicher Operationen wider, die auf dem Master ausgeführt werden können, z. B. Bereitstellen, Aktualisieren oder Löschen. Die einzelnen Zustände werden in der folgenden Tabelle beschrieben.

<table summary="Jede Tabellenzeile sollte von links nach rechts gelesen werden, wobei der Masterzustand in der ersten Spalte und eine Beschreibung in der zweiten Spalte angegeben ist.">
<caption>Masterzustände</caption>
   <thead>
   <th>Masterzustand</th>
   <th>Beschreibung</th>
   </thead>
   <tbody>
<tr>
   <td>`deployed (bereitgestellt)`</td>
   <td>Der Master wurde erfolgreich bereitgestellt. Überprüfen Sie den Zustand, um zu verifizieren, dass der Master betriebsbereit (`Ready`) ist, oder um festzustellen, ob eine Aktualisierung verfügbar ist.</td>
   </tr>
 <tr>
     <td>`deploying (wird bereitgestellt)`</td>
     <td>Der Master wird zurzeit bereitgestellt. Warten Sie, bis der Zustand in `deployed` (bereitgestellt) geändert wird, bevor Sie mit Ihrem Cluster arbeiten, z. B. um Workerknoten hinzuzufügen.</td>
    </tr>
   <tr>
     <td>`deploy_failed (Bereitstellung fehlgeschlagen)`</td>
     <td>Die Bereitstellung des Masters ist fehlgeschlagen. Der IBM Support wird benachrichtigt und arbeitet an einer Lösung des Problems. Überprüfen Sie das ****Masterstatusfeld auf weitere Informationen oder warten Sie, bis der Zustand in `deployed` (bereitgestellt) geändert wird.</td>
   </tr>
   <tr>
   <td>`deleting (wird gelöscht)`</td>
   <td>Der Master wird zurzeit gelöscht, weil Sie den Cluster gelöscht haben. Ein Löschvorgang kann nicht rückgängig gemacht werden. Nach dem Löschen des Clusters können Sie den Masterzustand nicht mehr überprüfen, da der Cluster vollständig entfernt wird.</td>
   </tr>
     <tr>
       <td>`delete_failed (Löschen fehlgeschlagen)`</td>
       <td>Das Löschen des Masters ist fehlgeschlagen. Der IBM Support wird benachrichtigt und arbeitet an einer Lösung des Problems. Sie können das Problem nicht lösen, indem Sie versuchen, den Cluster erneut zu löschen. Überprüfen Sie stattdessen das ****Masterstatusfeld auf weitere Informationen oder warten Sie, bis der Cluster gelöscht wurde.</td>
      </tr>
      <tr>
       <td>`updating (wird aktualisiert)`</td>
       <td>Der Master aktualisiert seine Kubernetes-Version. Bei der Aktualisierung kann es sich um eine Patchaktualisierung handeln, die automatisch angewendet wird, oder um eine über- oder untergeordnete Version, die Sie durch Aktualisieren des Clusters angewendet haben. Während der Aktualisierung kann Ihr hoch verfügbarer Master die Verarbeitung von Anforderungen fortsetzen und Ihre App-Workloads und Workerknoten werden weiterhin ausgeführt. Wenn die Aktualisierung abgeschlossen ist, können Sie [Ihre Workerknoten aktualisieren](/docs/containers?topic=containers-update#worker_node).<br><br>
       Ist die Aktualisierung nicht erfolgreich, wird der Master wieder in den Zustand `deployed` (bereitgestellt) versetzt und führt die Vorgängerversion weiter aus. Der IBM Support wird benachrichtigt und arbeitet an einer Lösung des Problems. Sie können im ****Masterstatusfeld überprüfen, ob die Aktualisierung fehlgeschlagen ist.</td>
    </tr>
   </tbody>
 </table>


<br />



## App-Bereitstellungen debuggen
{: #debug_apps}

Informieren Sie sich über die Optionen, die Ihnen für das Debuggen Ihrer App-Bereitstellungen und zum Eingrenzen der jeweiligen Fehlerquelle zur Verfügung stehen.

Stellen Sie zunächst sicher, dass Sie über die [{{site.data.keyword.cloud_notm}} IAM-Servicerolle **Schreibberechtigter** oder **Manager**](/docs/containers?topic=containers-users#platform) für den Namensbereich verfügen, in dem Ihre App bereitgestellt wird.

1. Suchen Sie nach Unregelmäßigkeiten in den Service- oder Bereitstellungsressourcen, indem Sie den Befehl `describe` ausführen.

 Beispiel:
 <pre class="pre"><code>kubectl describe service &lt;servicename&gt; </code></pre>

2. [Überprüfen Sie, ob die Container im Status `ContainerCreating` blockiert sind](/docs/containers?topic=containers-cs_troubleshoot_storage#stuck_creating_state).

3. Überprüfen Sie, ob der Cluster sich im Status `Critical` (Kritisch) befindet. Befindet sich der Cluster im Status `Critical`, dann überprüfen Sie die Firewallregeln und verifizieren Sie, ob der Master mit den Workerknoten kommunizieren kann.

4. Vergewissern Sie sich, dass der Service am korrekten Port empfangsbereit ist.
   1. Rufen Sie den Namen eines Pods ab.
     <pre class="pre"><code>kubectl get pods</code></pre>
   2. Melden Sie sich am Container an.
     <pre class="pre"><code>kubectl exec -it &lt;podname&gt; -- /bin/bash</code></pre>
   3. Führen Sie den Curl-Befehl für die App innerhalb des Containers aus. Wenn auf den Port nicht zugegriffen werden kann, dann ist der Service möglicherweise nicht am richtigen Port empfangsbereit oder in der App sind Probleme aufgetreten. Aktualisieren Sie die Konfigurationsdatei für den Service und geben Sie dabei den korrekten Port an und wiederholen Sie die Bereitstellung oder untersuchen Sie mögliche Probleme mit der App.
     <pre class="pre"><code>curl localhost: &lt;port&gt;</code></pre>

5. Stellen Sie sicher, dass der Service korrekt mit den Pods verbunden ist.
   1. Rufen Sie den Namen eines Pods ab.
     <pre class="pre"><code>kubectl get pods</code></pre>
   2. Melden Sie sich am Container an.
     <pre class="pre"><code>kubectl exec -it &lt;podname&gt; -- /bin/bash</code></pre>
   3. Führen Sie den Curl-Befehl für die Cluster-IP-Adresse und den Port des Service aus. Wenn nicht auf die IP-Adresse und den Port zugegriffen werden kann, dann untersuchen Sie die Endpunkte des Service. Wenn keine Endpunkte vorhanden sind, dann stimmt der Selektor für den Service nicht mit den Pods überein. Wenn Endpunkte aufgeführt sind, dann überprüfen Sie das Feld des Zielports für den Service und vergewissern Sie sich, dass der Zielport identisch mit dem Zielport für die Pods ist.
     <pre class="pre"><code>curl &lt;cluster_IP&gt;:&lt;port&gt;</code></pre>

6. Überprüfen Sie für die Ingress-Services, ob auf den Service von innerhalb des Clusters zugegriffen werden kann.
   1. Rufen Sie den Namen eines Pods ab.
     <pre class="pre"><code>kubectl get pods</code></pre>
   2. Melden Sie sich am Container an.
     <pre class="pre"><code>kubectl exec -it &lt;podname&gt; -- /bin/bash</code></pre>
   2. Führen Sie den Curl-Befehl für die URL aus, die für den Ingress-Service angegeben wurde. Wenn nicht auf die URL zugegriffen werden kann, dann überprüfen Sie das System auf ein Firewallproblem zwischen dem Cluster und dem externen Endpunkt. 
     <pre class="pre"><code>curl &lt;hostname&gt;.&lt;domäne&gt;</code></pre>

<br />



## Hilfe und Unterstützung anfordern
{: #ts_getting_help}

Haben Sie noch immer Probleme mit Ihrem Cluster?
{: shortdesc}

-  Sie werden im Terminal benachrichtigt, wenn Aktualisierungen für die `ibmcloud`-CLI und -Plug-ins verfügbar sind. Halten Sie Ihre CLI stets aktuell, sodass Sie alle verfügbaren Befehle und Flags verwenden können.
-   [Überprüfen Sie auf der {{site.data.keyword.cloud_notm}}-Statusseite ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cloud.ibm.com/status?selected=status), ob {{site.data.keyword.cloud_notm}} verfügbar ist.
-   Veröffentlichen Sie eine Frage im [{{site.data.keyword.containerlong_notm}}-Slack ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://ibm-container-service.slack.com).
    Wenn Sie keine IBM ID für Ihr {{site.data.keyword.cloud_notm}}-Konto verwenden, [fordern Sie eine Einladung](https://cloud.ibm.com/kubernetes/slack) zu diesem Slack an.
    {: tip}
-   Suchen Sie in entsprechenden Foren, ob andere Benutzer auf das gleiche Problem
gestoßen sind. Versehen Sie Ihre Fragen in den Foren mit Tags, um sie für das Entwicklungsteam
von {{site.data.keyword.cloud_notm}} erkennbar zu machen.
    -   Wenn Sie technische Fragen zur Entwicklung oder Bereitstellung von Clustern oder Apps mit {{site.data.keyword.containerlong_notm}} haben, veröffentlichen Sie Ihre Frage auf [Stack Overflow ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://stackoverflow.com/questions/tagged/ibm-cloud+containers) und versehen Sie sie mit den Tags `ibm-cloud`, `kubernetes` und `containers`.
    -   Verwenden Sie bei Fragen zum Service und zu ersten Schritten das Forum [IBM Developer Answers ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://developer.ibm.com/answers/topics/containers/?smartspace=bluemix). Geben Sie die Tags `ibm-cloud` und `containers` an.
    Weitere Details zur Verwendung der Foren finden Sie unter [Hilfe anfordern](/docs/get-support?topic=get-support-getting-customer-support#using-avatar).
-   Wenden Sie sich an den IBM Support, indem Sie einen Fall öffnen. Informationen zum Öffnen eines IBM Supportfalls oder zu Supportstufen und zu Prioritätsstufen von Fällen finden Sie unter [Support kontaktieren](/docs/get-support?topic=get-support-getting-customer-support).
Geben Sie beim Melden eines Problems Ihre Cluster-ID an. Führen Sie den Befehl `ibmcloud ks clusters` aus, um Ihre Cluster-ID abzurufen. Sie können außerdem [{{site.data.keyword.containerlong_notm}} Diagnostics and Debug Tool](/docs/containers?topic=containers-cs_troubleshoot#debug_utility) verwenden, um relevante Informationen aus Ihrem Cluster zu erfassen und zu exportieren, um sie dem IBM Support zur Verfügung zu stellen.
{: tip}

