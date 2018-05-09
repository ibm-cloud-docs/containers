---

copyright:
  years: 2014, 2018
lastupdated: "2018-03-16"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}
{:tsSymptoms: .tsSymptoms}
{:tsCauses: .tsCauses}
{:tsResolve: .tsResolve}


# Fehlerbehebung für Cluster
{: #cs_troubleshoot}

Ziehen Sie bei der Verwendung von {{site.data.keyword.containerlong}} die folgenden Verfahren für die Fehlerbehebung und zum Abrufen von Hilfe in Betracht. Sie können außerdem den [Status des {{site.data.keyword.Bluemix_notm}}-Systems ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://developer.ibm.com/bluemix/support/#status) überprüfen.
{: shortdesc}

Sie können verschiedene allgemeine Schritte ausführen, um sicherzustellen, dass Ihre Cluster auf dem neuesten Stand sind:
- Führen Sie in regelmäßigen Zeitabständen einen [Warmstart der Workerknoten](cs_cli_reference.html#cs_worker_reboot) durch, um sicherzustellen, dass die Installation der Aktualisierungen und Sicherheitspatches, die von IBM automatisch bereitgestellt werden, für das Betriebssystem auch durchgeführt werden.
- Führen Sie für Ihren Cluster eine Aktualisierung auf die [aktuellste Standardversion von Kubernetes](cs_versions.html) für {{site.data.keyword.containershort_notm}} durch.

<br />




## Cluster debuggen
{: #debug_clusters}

Informieren Sie sich über die Optionen, die Ihnen für die Fehlerbehebung bei Ihren Clustern und zum Eingrenzen der jeweiligen Fehlerquelle zur Verfügung stehen.

1.  Listen Sie Ihren Cluster auf und suchen Sie nach `Status` des Clusters.

  ```
  bx cs clusters
  ```
  {: pre}

2.  Überprüfen Sie den `Status` Ihres Clusters. Wenn Ihr Cluster den Status **Critical**, **Delete failed** oder **Warning** aufweist oder sich seit längerer Zeit im Status **Pending** befindet, beginnen Sie mit dem [Debugging der Workerknoten](#debug_worker_nodes).

    <table summary="Jede Tabellenzeile sollte von links nach rechts gelesen werden, wobei der Clusterstatus in der ersten Spalte und eine Beschreibung in der zweiten Spalte angegeben ist.">
   <thead>
   <th>Clusterstatus</th>
   <th>Beschreibung</th>
   </thead>
   <tbody>
<tr>
   <td>Aborted (Abgebrochen)</td>
   <td>Das Löschen des Clusters wird vom Benutzer angefordert, bevor der Kubernetes Master bereitgestellt ist. Nachdem das Löschen des Clusters abgeschlossen ist, wird der Cluster aus dem Dashboard entfernt. Wenn Ihr Cluster in diesem Status lange Zeit blockiert ist, öffnen Sie ein [ {{site.data.keyword.Bluemix_notm}}-Support-Ticket](/docs/get-support/howtogetsupport.html#using-avatar). </td>
   </tr>
 <tr>
     <td>Critical (Kritisch)</td>
     <td>Der Kubernetes-Master kann nicht erreicht werden oder alle Workerknoten in dem Cluster sind inaktiv. </td>
    </tr>
   <tr>
     <td>Delete failed (Löschen fehlgeschlagen)</td>
     <td>Der Kubernetes Masterknoten oder mindestens ein Workerknoten kann nicht gelöscht werden. </td>
   </tr>
   <tr>
     <td>Deleted (Gelöscht)</td>
     <td>Der Cluster wird gelöscht, aber noch nicht aus dem Dashboard entfernt. Wenn Ihr Cluster in diesem Status lange Zeit blockiert ist, öffnen Sie ein [ {{site.data.keyword.Bluemix_notm}}Support-Ticket](/docs/get-support/howtogetsupport.html#using-avatar). </td>
   </tr>
   <tr>
   <td>Deleting (Löschen)</td>
   <td>Der Cluster wird gelöscht, und die Clusterinfrastruktur wird abgebaut. Der Zugriff auf den Cluster ist nicht möglich. </td>
   </tr>
   <tr>
     <td>Deploy failed (Bereitstellung fehlgeschlagen)</td>
     <td>Die Bereitstellung des Kubernetes-Masters konnte nicht abgeschlossen werden. Sie können diesen Status nicht auflösen. Wenden Sie sich an den Support für IBM Cloud, indem Sie ein [{{site.data.keyword.Bluemix_notm}}-Support-Ticket](/docs/get-support/howtogetsupport.html#using-avatar) öffnen.</td>
   </tr>
     <tr>
       <td>Deploying (Wird bereitgestellt)</td>
       <td>Der Kubernetes-Master ist noch nicht vollständig implementiert. Sie können auf Ihren Cluster nicht zugreifen. Warten Sie, bis Ihr Cluster vollständig bereitgestellt wurde, und überprüfen Sie dann den Status Ihres Clusters. </td>
      </tr>
      <tr>
       <td>Normal</td>
       <td>Alle Workerknoten in einem Cluster sind betriebsbereit. Sie können auf den Cluster zugreifen und Apps auf dem Cluster bereitstellen. Dieser Status wird als einwandfreier Zustand betrachtet und erfordert keine Aktion von Ihnen.</td>
    </tr>
      <tr>
       <td>Pending (Anstehend)</td>
       <td>Der Kubernetes-Master ist bereitgestellt. Die Workerknoten werden gerade eingerichtet und sind noch nicht im Cluster verfügbar. Sie können auf den Cluster zugreifen, aber Sie können keine Apps auf dem Cluster bereitstellen.  </td>
     </tr>
   <tr>
     <td>Requested (Angefordert)</td>
     <td>Eine Anforderung zum Erstellen des Clusters und zum Bestellen der Infrastruktur für die Kubernetes Master- und Worker-Knoten wird gesendet. Wenn die Bereitstellung des Clusters gestartet wird, ändert sich der Clusterstatus in <code>Deploying</code> (Wird bereitgestellt). Wenn Ihr Cluster lange Zeit im Status <code>Requested</code> (Angefordert) blockiert ist, öffnen Sie ein [{{site.data.keyword.Bluemix_notm}}-Support-Ticket](/docs/get-support/howtogetsupport.html#using-avatar). </td>
   </tr>
   <tr>
     <td>Updating (Aktualisierung)</td>
     <td>Der Kubernetes API-Server, der in Ihrem Kubernetes-Master ausgeführt wird, wird auf eine neue Version der Kubernetes-API aktualisiert. Während der Aktualisierung können Sie weder auf den Cluster zugreifen noch Änderungen am Cluster vornehmen. Workerknoten, Apps und Ressourcen, die vom Benutzer bereitgestellt wurden, werden nicht geändert und weiterhin ausgeführt. Warten Sie, bis die Aktualisierung abgeschlossen ist, und überprüfen Sie dann den Status Ihres Clusters. </td>
   </tr>
    <tr>
       <td>Warning (Warnung)</td>
       <td>Mindestens ein Workerknoten in dem Cluster ist nicht verfügbar, aber andere Workerknoten sind verfügbar und können die Workload übernehmen. </td>
    </tr>
   </tbody>
 </table>

<br />


## Debugging der Workerknoten
{: #debug_worker_nodes}

Informieren Sie sich über die Optionen, die Ihnen für die Fehlerbehebung bei Ihren Workerknoten und zum Eingrenzen der jeweiligen Fehlerquelle zur Verfügung stehen.


1.  Wenn Ihr Cluster den Status **Critical**, **Delete failed** oder **Warning** aufweist oder sich seit längerer Zeit im Status **Pending** befindet, überprüfen Sie den Status Ihrer Workerknoten. 

  ```
  bx cs workers <clustername_oder_-id>
  ```
  {: pre}

2.  Überprüfen Sie die Felder für `Zustand` und `Status` für jeden Workerknoten in Ihrer CLI-Ausgabe. 

  <table summary="Jede Tabellenzeile sollte von links nach rechts gelesen werden, wobei der Clusterstatus in der ersten Spalte und eine Beschreibung in der zweiten Spalte angegeben ist.">
    <thead>
    <th>Status des Workerknotens</th>
    <th>Beschreibung</th>
    </thead>
    <tbody>
  <tr>
      <td>Critical (Kritisch)</td>
      <td>Ein Workerknoten kann aus vielen Gründen in einen kritischen Status wechseln. Die häufigsten Ursachen sind die folgenden: <ul><li>Sie haben einen Warmstart für Ihren Workerknoten eingeleitet, ohne den Workerknoten zu abzuriegeln und zu entleeren. Der Warmstart eines Workerknotens kann zu Datenverlust in <code>docker</code>, <code>kubelet</code>, <code>kube-proxy</code> und <code>calico</code> führen. </li><li>Die Pods, die auf Ihrem Workerknoten bereitgestellt wurden, verwenden keine Ressourcengrenzen für [Speicher ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tasks/configure-pod-container/assign-memory-resource/) und [CPU ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tasks/configure-pod-container/assign-cpu-resource/). Ohne Ressourcengrenzen können die Pods alle verfügbaren Ressourcen in Anspruch nehmen und keine Ressourcen mehr für andere Pods übrig lassen, die auch auf diesem Workerknoten ausgeführt werden. Diese Überbelegung durch Workload führt dazu, dass der Workerknoten fehlschlägt. </li><li><code>Docker</code>, <code>kubelet</code> oder <code>calico</code> geraten in einen nicht behebbaren kritischen Zustand, nachdem Sie Hunderte oder Tausende von Containern ausgeführt haben. </li><li>Sie haben eine Vyatta für Ihren Workerknoten eingerichtet, die fehlschlug und die Kommunikation zwischen Ihrem Workerknoten und dem Kubernetes-Master unterbrochen hat. </li><li> Aktuelle Netzprobleme in {{site.data.keyword.containershort_notm}} oder IBM Cloud Infrastructure (SoftLayer), die ein Fehlschlagen der Kommunikation zwischen Ihrem Workerknoten und dem Kubernetes-Master verursachen. </li><li>Ihr Workerknoten hat keine Kapazität mehr. Überprüfen Sie den <strong>Status</strong> des Workerknotens, um zu sehen, ob <strong>Out of disk</strong> (zu wenig Plattenspeicher) oder <strong>Out of memory</strong> (zu wenig Hauptspeicher) angezeigt wird. Wenn Ihr Workerknoten die Kapazitätsgrenze erreicht hat, können Sie entweder die Arbeitslast auf Ihrem Workerknoten reduzieren oder einen Workerknoten zu Ihrem Cluster hinzufügen und so den Lastausgleich verbessern. </li></ul> In vielen Fällen kann ein [Neuladen](cs_cli_reference.html#cs_worker_reload) Ihres Workerknotens das Problem lösen. Stellen Sie, bevor Sie Ihren Workerknoten erneut laden, sicher, dass Ihr Workerknoten abgeriegelt und entleert wurde, damit die vorhandenen Pods ordnungsgemäß beendet und auf den verbleibenden Workerknoten neu geplant werden können. </br></br> Wenn das Neuladen des Workerknotens das Problem nicht löst, wechseln Sie zum nächsten Schritt, um mit der Fehlerbehebung Ihrer Workerknoten fortzufahren. </br></br><strong>Tipp:</strong> Sie können [Statusprüfungen für Ihre Workerknoten konfigurieren und die automatische Wiederherstellung aktiveren](cs_health.html#autorecovery). Wenn die automatische Wiederherstellung basierend auf den konfigurierten Prüfungen einen nicht ordnungsgemäß funktionierenden Workerknoten erkennt, löst das System eine Korrekturmaßnahme, wie das erneute Laden des Betriebssystems, auf dem Workerknoten aus. Weitere Informationen zur Funktionsweise der automatischen Wiederherstellung finden Sie im [Blogbeitrag zur automatischen Wiederherstellung![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/blogs/bluemix/2017/12/autorecovery-utilizes-consistent-hashing-high-availability/).</td>
     </tr>
      <tr>
        <td>Deploying (Wird bereitgestellt)</td>
        <td>Wenn Sie die Kubernetes-Version Ihres Workerknotens aktualisieren, wird der Workerknoten erneut bereitgestellt, um die Aktualisierungen zu installieren. Falls sich Ihr Workerknoten eine längere Zeit in diesem Status befindet, fahren Sie mit dem nächsten Schritt fort, um zu sehen, ob während der Bereitstellung ein Problem aufgetreten ist. </td>
     </tr>
        <tr>
        <td>Normal</td>
        <td>Ihr Workerknoten wurde vollständig bereitgestellt und kann im Cluster verwendet werden. Dieser Status wird als einwandfreier Zustand betrachtet und erfordert keine Aktion vom Benutzer. </td>
     </tr>
   <tr>
        <td>Provisioning (Wird bereitgestellt)</td>
        <td>Ihr Workerknoten wird gerade eingerichtet und ist noch nicht im Cluster verfügbar. Sie können den Bereitstellungsprozess in der Spalte <strong>Status</strong> Ihrer CLI-Ausgabe überwachen. Falls sich Ihr Workerknoten eine längere Zeit in diesem Status befindet und Sie in der Spalte <strong>Status</strong> keinen Fortschritt erkennen können, fahren Sie mit dem nächsten Schritt fort, um zu sehen, ob während der Bereitstellung ein Problem aufgetreten ist.</td>
      </tr>
      <tr>
        <td>Provision_failed (Bereitstellung fehlgeschlagen)</td>
        <td>Ihr Workerknoten konnte nicht bereitgestellt werden. Fahren Sie mit dem nächsten Schritt fort, um die Details des Fehlers abzurufen.</td>
      </tr>
   <tr>
        <td>Reloading (Wird neu geladen)</td>
        <td>Ihr Workerknoten wird neu geladen und ist nicht im Cluster verfügbar. Sie können den Neuladeprozess in der Spalte <strong>Status</strong> Ihrer CLI-Ausgabe überwachen. Falls sich Ihr Workerknoten eine längere Zeit in diesem Status befindet und Sie in der Spalte <strong>Status</strong> keinen Fortschritt erkennen können, fahren Sie mit dem nächsten Schritt fort, um zu sehen, ob während des Neuladens ein Problem aufgetreten ist.</td>
       </tr>
       <tr>
        <td>Reloading_failed (Neuladen fehlgeschlagen) </td>
        <td>Ihr Workerknoten konnte nicht neu geladen werden. Fahren Sie mit dem nächsten Schritt fort, um die Details des Fehlers abzurufen.</td>
      </tr>
      <tr>
        <td>Reload_pending (Neuladen anstehend) </td>
        <td>Eine Anforderung zum Neuladen oder Aktualisieren der Kubernetes-Version Ihrer Workerknoten wurde gesendet. Wenn der Workerknoten erneut geladen wird, ändert sich der Status in <code>Reloading</code>. </td>
      </tr>
      <tr>
       <td>Unknown (Unbekannt)</td>
       <td>Der Kubernetes-Master ist aus einem der folgenden Gründe nicht erreichbar:<ul><li>Sie haben ein Update Ihres Kubernetes-Masters angefordert. Der Status des Workerknotens kann während des Updates nicht abgerufen werden.</li><li>Sie haben möglicherweise eine zusätzliche Firewall, die Ihre Workerknoten schützt, oder Sie haben die Firewalleinstellungen kürzlich geändert. {{site.data.keyword.containershort_notm}} erfordert, dass bestimmte IP-Adressen und Ports geöffnet sind, damit die Kommunikation vom Workerknoten zum Kubernetes-Master und umgekehrt möglich ist. Weitere Informationen finden Sie in [Firewall verhindert Verbindung für Workerknoten](#cs_firewall).</li><li>Der Kubernetes-Master ist inaktiv. Wenden Sie sich an den {{site.data.keyword.Bluemix_notm}}-Support, indem Sie ein [{{site.data.keyword.Bluemix_notm}}-Support-Ticket](/docs/get-support/howtogetsupport.html#getting-customer-support) öffnen.</li></ul></td>
  </tr>
     <tr>
        <td>Warning (Warnung)</td>
        <td>Ihr Workerknoten nähert sich dem Grenzwert für die Speicher- oder Plattenkapazität. Sie können entweder die Arbeitslast auf Ihrem Workerknoten reduzieren oder einen Workerknoten zu Ihrem Cluster hinzufügen und so den Lastausgleich verbessern.</td>
  </tr>
    </tbody>
  </table>

5.  Listen Sie die Details für den Workerknoten auf. Wenn die Details eine Fehlernachricht enthalten, überprüfen Sie die Liste der [gängigen Fehlernachrichten für Workerknoten](#common_worker_nodes_issues) und lernen Sie, diese Probleme zu beheben. 

   ```
   bx cs worker-get <worker_id>
   ```
   {: pre}

  ```
  bx cs worker-get [<clustername_oder_-id>] <workerknoten-id>
  ```
  {: pre}

<br />


## Gängige Fehlernachrichten bei Workerknoten
{: #common_worker_nodes_issues}

Überprüfen Sie gängige Fehlernachrichten und lernen Sie, diese zu beheben.

  <table>
    <thead>
    <th>Fehlernachricht</th>
    <th>Beschreibung und Problemlösung
    </thead>
    <tbody>
      <tr>
        <td>{{site.data.keyword.Bluemix_notm}} Infrastructure Exception: Your account is currently prohibited from ordering 'Computing Instances'.</td>
        <td>Mit Ihrem Konto von IBM Cloud Infrastructure (SoftLayer) können Sie möglicherweise keine Rechenressourcen bestellen. Wenden Sie sich an den {{site.data.keyword.Bluemix_notm}}-Support, indem Sie ein [{{site.data.keyword.Bluemix_notm}}-Support-Ticket](/docs/get-support/howtogetsupport.html#getting-customer-support) öffnen.</td>
      </tr>
      <tr>
        <td>{{site.data.keyword.Bluemix_notm}} Infrastructure Exception: Could not place order. There are insufficient resources behind router 'routername' to fulfill the request for the following guests: 'worker-id'.</td>
        <td>Das ausgewählte VLAN ist einem Pod im Rechenzentrum zugeordnet, der nicht über ausreichend Speicherplatz zum Bereitstellen Ihres Workerknotens verfügt. Sie können zwischen den folgenden Optionen wählen:<ul><li>Stellen Sie Ihren Workerknoten in einem anderen Rechenzentrum bereit. Führen Sie <code>bx cs locations</code> aus, um verfügbare Rechenzentren aufzulisten.<li>Wenn Sie ein vorhandenes Paar aus öffentlichem und privatem VLAN haben, das einem anderen Pod in dem Rechenzentrum zugeordnet ist, verwenden Sie dieses VLAN stattdessen.<li>Wenden Sie sich an den {{site.data.keyword.Bluemix_notm}}-Support, indem Sie ein [{{site.data.keyword.Bluemix_notm}}-Support-Ticket](/docs/get-support/howtogetsupport.html#getting-customer-support) öffnen.</ul></td>
      </tr>
      <tr>
        <td>{{site.data.keyword.Bluemix_notm}} Infrastructure Exception: Could not obtain network VLAN with id: &lt;vlan-id&gt;.</td>
        <td>Ihr Workerknoten konnte nicht bereitgestellt werden, weil die ausgewählte VLAN-ID aus einem der folgenden Gründe nicht gefunden werden konnte:<ul><li>Möglicherweise haben Sie statt der VLAN-ID die VLAN-Nummer angegeben. Die VLAN-Nummer umfasst 3 oder 4 Ziffern, während die VLAN-ID 7 Stellen hat. Führen Sie <code>bx cs vlans &lt;standort&gt;</code> aus, um die VLAN-ID abzurufen.<li>Möglicherweise ist die VLAN-ID nicht dem von Ihnen verwendeten Konto von IBM Cloud Infrastructure (SoftLayer) zugeordnet. Führen Sie <code>bx cs vlans &lt;standort&gt;</code> aus, um verfügbare VLAN-IDs für Ihr Konto aufzulisten. Um das Konto von IBM Cloud Infrastructure (SoftLayer) zu ändern, sollten Sie die Informationen unter [bx cs credentials-set](cs_cli_reference.html#cs_credentials_set) nachlesen. </ul></td>
      </tr>
      <tr>
        <td>SoftLayer_Exception_Order_InvalidLocation: The location provided for this order is invalid. (HTTP 500)</td>
        <td>Ihr System von IBM Cloud Infrastructure (SoftLayer) ist nicht für das Bestellen von Rechenressourcen im ausgewählten Rechenzentrum eingerichtet. Wenden Sie sich an den [{{site.data.keyword.Bluemix_notm}}-Support](/docs/get-support/howtogetsupport.html#getting-customer-support), um sicherzustellen, dass Ihr Konto korrekt eingerichtet ist.</td>
       </tr>
       <tr>
        <td>{{site.data.keyword.Bluemix_notm}} Infrastructure Exception: The user does not have the necessary {{site.data.keyword.Bluemix_notm}} Infrastructure permissions to add servers
        </br></br>
        {{site.data.keyword.Bluemix_notm}} Infrastructure Exception: 'Item' must be ordered with permission.</td>
        <td>Möglicherweise verfügen Sie nicht über die erforderlichen Berechtigungen, um einen Workerknoten aus dem Portfolio von IBM Cloud Infrastructure (SoftLayer) bereitzustellen. Weitere Informationen finden Sie in [Zugriff auf das Portfolio von IBM Cloud Infrastructure (SoftLayer) konfigurieren, um Kubernetes-Standardcluster zu erstellen](cs_infrastructure.html#unify_accounts).</td>
      </tr>
      <tr>
       <td>Worker kann nicht mit {{site.data.keyword.containershort_notm}}-Servern  kommunizieren. Bitte überprüfen Sie, ob Ihre Firewalleinstellung Datenverkehr von diesem Worker zulässt.
<td><ul><li>Wenn Sie über eine Firewall verfügen, [konfigurieren Sie Ihre Firewalleinstellungen so, dass sie ausgehenden Datenverkehr zu den entsprechenden Ports und IP-Adressen zulassen](cs_firewall.html#firewall_outbound). </li><li>Überprüfen Sie, dass Ihr Cluster über keine öffentliche IP verfügt, indem Sie den folgenden Befehl ausführen: `bx cs workers <mycluster>`. Wenn keine öffentliche IP aufgelistet wird, verfügt Ihr Cluster nur über private VLANs. <ul><li>Wenn Sie möchten, dass der Cluster nur über private VLANs verfügt, stellen Sie sicher, dass Sie Ihre [VLAN-Verbindung](cs_clusters.html#worker_vlan_connection) und Ihre [Firewall](cs_firewall.html#firewall_outbound) konfiguriert haben. </li><li>Wenn Sie möchten, dass der Cluster über eine öffentliche IP verfügt, [fügen Sie neue Workerknoten](cs_cli_reference.html#cs_worker_add) mit öffentlichen und privaten VLANs hinzu.</li></ul></li></ul></td>
     </tr>
      <tr>
  <td>IMS-Portaltoken kann nicht erstellt werden, da kein IMS-Konto mit dem ausgewählten BSS-Konto verknüpft ist.
</br></br>Angegebener Benutzer nicht gefunden bzw. aktiv
</br></br>SoftLayer_Exception_User_Customer_InvalidUserStatus: User account is currently cancel_pending.</td>
  <td>Der Eigner des API-Schlüssels, der für den Zugriff auf das Portfolio von IBM Cloud Infrastructure (SoftLayer) verwendet wird, verfügt nicht über die erforderlichen Berechtigungen zum Ausführen der Aktion oder es steht die Löschung der Berechtigungen an. </br></br><strong>Als Benutzer</strong> führen Sie diese Schritte aus: <ol><li>Wenn Sie Zugriff auf mehrere Konten haben, stellen Sie sicher, dass Sie bei dem Konto angemeldet sind, in dem Sie mit {{site.data.keyword.containerlong_notm}} arbeiten möchten. </li><li>Führen Sie den Befehl <code>bx cs api-key-info</code> aus, um den aktuellen API-Schlüsseleigner anzuzeigen, der für den Zugriff auf das Portfolio von IBM Cloud Infrastructure (SoftLayer) verwendet wird. </li><li>Führen Sie den Befehl <code>bx account list</code> aus, um den Eigner des {{site.data.keyword.Bluemix_notm}}-Kontos anzuzeigen, das Sie gerade verwenden. </li><li>Kontaktieren Sie den Eigner des {{site.data.keyword.Bluemix_notm}}-Kontos und berichten Sie, dass der Eigner, des API-Schlüssels, den Sie zuvor erhalten haben, nicht über ausreichende Berechtigungen in IBM Cloud Infrastructure (SoftLayer) verfügt oder dass die Löschung der Berechtigungen ansteht. </li></ol></br><strong>Als Kontoeigner</strong>, führen Sie diese Schritte aus: <ol><li>Überprüfen Sie die [erforderlichen Berechtigungen in IBM Cloud Infrastructure (SoftLayer)](cs_users.html#managing), um die Aktion auszuführen, die zuvor fehlgeschlagen ist. </li><li>Korrigieren Sie die Berechtigungen für den API-Schlüsseleigner oder erstellen Sie einen neuen API-Schlüssel mithilfe des Befehls [<code>bx cs api-key-reset</code>](cs_cli_reference.html#cs_api_key_reset). </li><li>Wenn durch Sie oder einen anderen Kontoadministrator manuell Berechtigungsnachweise für IBM Cloud Infrastructure (SoftLayer) in Ihrem Konto definiert wurden, führen Sie den Befehl [<code>bx cs credentials-unset</code>](cs_cli_reference.html#cs_credentials_unset) aus, um die Berechtigungsnachweise aus Ihrem Konto zu entfernen. </li></ol></td>
  </tr>
    </tbody>
  </table>



<br />




## App-Bereitstellungen debuggen
{: #debug_apps}

Informieren Sie sich über die Optionen, die Ihnen für das Debuggen Ihrer App-Bereitstellungen und zum Eingrenzen der jeweiligen Fehlerquelle zur Verfügung stehen.

1. Suchen Sie nach Unregelmäßigkeiten in den Service- oder Bereitstellungsressourcen, indem Sie den Befehl `describe` ausführen.

 Beispiel:
 <pre class="pre"><code>kubectl describe service &lt;servicename&gt; </code></pre>

2. [Überprüfen Sie, ob die Container im Status 'ContainerCreating' blockiert sind](#stuck_creating_state).

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
   3. Führen Sie den Curl-Befehl für die Cluster-IP-Adresse und den Port des Service aus. Wenn nicht auf die IP-Adresse und den Port zugegriffen werden kann, dann untersuchen Sie die Endpunkte des Service. Wenn keine Endpunkte vorhanden sind, dann stimmt der Selektor für den Service nicht mit den Pods überein. Wenn Endpunkte vorhanden sind, dann überprüfen Sie das Feld des Zielports für den Service und vergewissern Sie sich, dass der Zielport identisch mit dem Zielport für die Pods ist.
     <pre class="pre"><code>curl &lt;cluster_IP&gt;:&lt;port&gt;</code></pre>

6. Überprüfen Sie für die Ingress-Services, ob auf den Service von innerhalb des Clusters zugegriffen werden kann.
   1. Rufen Sie den Namen eines Pods ab.
     <pre class="pre"><code>kubectl get pods</code></pre>
   2. Melden Sie sich am Container an.
     <pre class="pre"><code>kubectl exec -it &lt;podname&gt; -- /bin/bash</code></pre>
   2. Führen Sie den Curl-Befehl für die URL aus, die für den Ingress-Service angegeben wurde. Wenn nicht auf die URL zugegriffen werden kann, dann überprüfen Sie das System auf ein Firewallproblem zwischen dem Cluster und dem externen Endpunkt. 
     <pre class="pre"><code>curl &lt;hostname&gt;.&lt;domäne&gt;</code></pre>

<br />


## Verbindung mit dem Infrastrukturkonto kann nicht hergestellt werden
{: #cs_credentials}

{: tsSymptoms}
Wenn Sie einen neuen Kubernetes-Cluster erstellen, wird die folgende Nachricht angezeigt.

```
Es konnte keine Verbindung zu Ihrem Konto von IBM Cloud Infrastructure (SoftLayer) hergestellt werden.
Zur Erstellung eines Standardclusters ist es erforderlich, dass Sie entweder über ein nutzungsabhängiges Konto
mit einer Verbindung zum Konto von IBM Cloud Infrastructure (SoftLayer) verfügen oder dass Sie die {{site.data.keyword.Bluemix_notm}}
Container Service-CLI zum Einrichten der API-Schlüssel für {{site.data.keyword.Bluemix_notm}} Infrastructure verwendet haben.
```
{: screen}

{: tsCauses}
Benutzer mit einem {{site.data.keyword.Bluemix_notm}}-Konto ohne Verbindung müssen ein neues nutzungsabhängiges Konto erstellen oder die API-Schlüssel von IBM Cloud Infrastructure (SoftLayer) manuell über die {{site.data.keyword.Bluemix_notm}}-CLI hinzufügen.

{: tsResolve}
Gehen Sie wie folgt vor, um Berechtigungsnachweise für Ihr {{site.data.keyword.Bluemix_notm}}-Konto hinzuzufügen.

1.  Wenden Sie sich an den Administrator von IBM Cloud Infrastructure (SoftLayer), um den Benutzernamen und den API-Schlüssel für IBM Cloud Infrastructure (SoftLayer) zu erhalten.

    **Hinweis:** Das Konto von IBM Cloud Infrastructure (SoftLayer), das Sie verwenden, muss mit SuperUser-Berechtigungen eingerichtet werden, damit Standardcluster erfolgreich erstellt werden können.

2.  Fügen Sie die Berechtigungsnachweise hinzu.

  ```
  bx cs credentials-set --infrastructure-username <benutzername> --infrastructure-api-key <api-schlüssel>
  ```
  {: pre}

3.  Erstellen Sie einen Standardcluster.

  ```
  bx cs cluster-create --location dal10 --public-vlan meine_id_des_öffentlichen_vlan --private-vlan meine_id_des_privaten_vlan --machine-type u2c.2x4 --name mein_cluster --hardware shared --workers 2
  ```
  {: pre}

<br />


## Firewall verhindert das Ausführen von CLI-Befehlen
{: #ts_firewall_clis}

{: tsSymptoms}
Wenn Sie die Befehle `bx`, `kubectl` oder `calicoctl` über die Befehlszeilenschnittstelle ausführen, schlagen sie fehl.

{: tsCauses}
Möglicherweise verhindern Unternehmensnetzrichtlinien den Zugriff von Ihrem lokalen System auf öffentliche Endpunkte über Proxys oder Firewalls.

{: tsResolve}
[Lassen Sie TCP-Zugriff zu, damit die CLI-Befehle ausgeführt werden können](cs_firewall.html#firewall). Für diese Task ist die [Zugriffsrichtlinie 'Administrator'](cs_users.html#access_policies) erforderlich. Überprüfen Sie Ihre aktuelle [Zugriffsrichtlinie](cs_users.html#infra_access).


## Firewall verhindert die Verbindung des Clusters mit Ressourcen
{: #cs_firewall}

{: tsSymptoms}
Wenn die Workerknoten keine Verbindung herstellen können, dann werden Sie möglicherweise eine Vielzahl unterschiedlicher Symptome feststellen. Das System zeigt eventuell eine der folgenden Nachrichten an, wenn die Ausführung des Befehls 'kubectl proxy' fehlschlägt oder wenn Sie versuchen, auf einen Service in Ihrem Cluster zuzugreifen und diese Verbindung fehlschlägt.

  ```
  Connection refused
  ```
  {: screen}

  ```
  Connection timed out
  ```
  {: screen}

  ```
  Unable to connect to the server: net/http: TLS handshake timeout
  ```
  {: screen}

Wenn Sie 'kubectl exec', kubectl attach' oder 'kubectl logs' ausführen, dann wird möglicherweise die folgende Nachricht angezeigt.

  ```
  Error from server: error dialing backend: dial tcp XXX.XXX.XXX:10250: getsockopt: connection timed out
  ```
  {: screen}

Wenn die Ausführung von 'kubectl proxy' erfolgreich verläuft, das Dashboard jedoch nicht verfügbar ist, dann wird möglicherweise die folgende Nachricht angezeigt.

  ```
  timeout on 172.xxx.xxx.xxx
  ```
  {: screen}



{: tsCauses}
Möglicherweise wurde eine zusätzliche Firewall eingerichtet oder Sie haben die vorhandenen Firewalleinstellungen für Ihr Konto von IBM Cloud Infrastructure (SoftLayer) angepasst. {{site.data.keyword.containershort_notm}} erfordert, dass bestimmte IP-Adressen und Ports geöffnet sind, damit die Kommunikation vom Workerknoten zum Kubernetes-Master und umgekehrt möglich ist. Ein weiterer möglicher Grund kann sein, dass Ihre Workerknoten in einer Neuladen-Schleife hängen.

{: tsResolve}
[Gewähren Sie dem Cluster den Zugriff auf Infrastrukturressourcen und andere Services](cs_firewall.html#firewall_outbound). Für diese Task ist die [Zugriffsrichtlinie 'Administrator'](cs_users.html#access_policies) erforderlich. Überprüfen Sie Ihre aktuelle [Zugriffsrichtlinie](cs_users.html#infra_access).

<br />



## Zugreifen auf Workerknoten mit SSH schlägt fehl
{: #cs_ssh_worker}

{: tsSymptoms}
Es ist kein Zugriff auf Ihren Workerknoten über eine SSH-Verbindung möglich.

{: tsCauses}
Auf den Workerknoten ist SSH über Kennwort inaktiviert.

{: tsResolve}
Verwenden Sie [Dämon-Sets ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) für Vorgänge, die auf jedem Knoten ausgeführt werden müssen. Verwenden Sie Jobs für alle einmaligen Aktionen, die Sie durchführen müssen.

<br />



## Bindung eines Service an einen Cluster führt zu Fehler wegen identischer Namen
{: #cs_duplicate_services}

{: tsSymptoms}
Bei der Ausführung des Befehls `bx cs cluster-service-bind <cluster_name> <namespace> <service_instance_name>` wird die folgende Nachricht angezeigt:

```
Multiple services with the same name were found.
Run 'bx service list' to view available Bluemix service instances...
```
{: screen}

{: tsCauses}
Unter Umständen haben mehrere Serviceinstanzen in unterschiedlichen Regionen denselben Namen.

{: tsResolve}
Verwenden Sie im Befehl `bx cs cluster-service-bind` die GUID des Service anstelle des Serviceinstanznamens.

1. [Melden Sie sich in der Region an, in der sich die Serviceinstanz befindet, die gebunden werden soll.](cs_regions.html#bluemix_regions)

2. Rufen Sie die GUID für die Serviceinstanz ab.
  ```
  bx service show <serviceinstanzname> --guid
  ```
  {: pre}

  Ausgabe:
  ```
  Invoking 'cf service <serviceinstanzname> --guid'...
  <serviceinstanz-GUID>
  ```
  {: screen}
3. Binden Sie den Service erneut an den Cluster.
  ```
  bx cs cluster-service-bind <clustername> <namensbereich> <serviceinstanz-GUID>
  ```
  {: pre}

<br />



## Nachdem ein Workerknoten aktualisiert oder erneut geladen wurde, werden doppelte Knoten und Pods angezeigt
{: #cs_duplicate_nodes}

{: tsSymptoms}
Wenn Sie `kubectl get nodes` ausführen, werden doppelte Workerknoten mit dem Status **NotReady** (Nicht bereit) angezeigt. Die Workerknoten mit dem Status **NotReady** verfügen über öffentliche IP-Adressen, während die Workerknoten mit dem Status **Ready** (Bereit) private IP-Adressen haben.

{: tsCauses}
Ältere Cluster haben über Workerknoten verfügt, die über die öffentliche IP-Adresse des Clusters aufgelistet wurden. Nun werden Workerknoten über die private IP-Adresse des Clusters aufgelistet. Wenn Sie einen Knoten erneut laden oder aktualisieren, dann wird die IP-Adresse geändert, der Verweis auf die öffentliche IP-Adresse bleibt jedoch erhalten.

{: tsResolve}
Es treten keine Serviceunterbrechungen aufgrund dieser Duplikate auf, Sie sollten die alten Workerknotenverweise jedoch vom API-Server entfernen.

  ```
  kubectl delete node <knotenname1> <knotenname2>
  ```
  {: pre}

<br />




## Dateisysteme für Workerknoten werden schreibgeschützt
{: #readonly_nodes}

{: tsSymptoms}
{: #stuck_creating_state}
Sie bemerken möglicherweise eines der folgenden Symptome: 
- Wenn Sie den Befehl `kubectl get pods -o wide` ausführen, dann können Sie erkennen, dass mehrere Pods, die auf demselben Workerknoten ausgeführt werden, im Zustand `ContainerCreating` blockiert sind.
- Wenn Sie den Befehl `kubectl describe` ausführen, sehen Sie den folgenden Fehler im Abschnitt 'Ereignisse' `MountVolume.SetUp failed for volume ... read-only file system`.

{: tsCauses}
Das Dateisystem auf dem Workerknoten ist schreibgeschützt.

{: tsResolve}
1. Erstellen Sie eine Sicherungskopie aller Daten, die möglicherweise auf dem Workerknoten oder in Ihren Containern gespeichert werden.
2. Laden Sie den Workerknoten erneut, um eine kurzfristige Programmkorrektur für den vorhandenen Workerknoten zu erreichen. 

<pre class="pre"><code>bx cs worker-reload &lt;clustername&gt; &lt;worker-id&gt;</code></pre>

Für eine langfristige Programmkorrektur müssen Sie [den Maschinentyp aktualisieren, indem Sie einen anderen Workerknoten hinzufügen](cs_cluster_update.html#machine_type).

<br />




## Zugriff auf einen Pod auf einem Workerknoten schlägt mit einer Zeitlimitüberschreitung fehl
{: #cs_nodes_duplicate_ip}

{: tsSymptoms}
Sie haben einen Workerknoten in Ihrem Cluster gelöscht und dann einen Workerknoten hinzugefügt. Wenn Sie einen Pod oder einen Kubernetes-Service bereitgestellt haben, kann die Ressource nicht auf den neu erstellten Workerknoten zugreifen, und die Verbindung überschreitet das Zeitlimit.

{: tsCauses}
Wenn Sie einen Workerknoten aus Ihrem Cluster löschen und dann einen Workerknoten hinzufügen, ist es möglich, dass der neue Workerknoten der privaten IP-Adresse des gelöschten Workerknotens zugeordnet wird. Calico verwendet diese private IP-Adresse als Tag und versucht weiterhin, den gelöschten Knoten zu erreichen.

{: tsResolve}
Aktualisieren Sie die Referenz der privaten IP-Adresse manuell, um auf den korrekten Knoten zu zeigen.

1.  Stellen Sie sicher, dass Sie zwei Workerknoten mit derselben **privaten IP**-Adresse haben. Notieren Sie sich die **private IP** und die **ID** des gelöschten Workers.

  ```
  bx cs workers <CLUSTERNAME>
  ```
  {: pre}

  ```
  ID                                                 Public IP       Private IP       Machine Type   State     Status   Location   Version
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w1   192.0.2.0.12    203.0.113.144    b2c.4x16       normal    Ready    dal10      1.8.8
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w2   192.0.2.0.16    203.0.113.144    b2c.4x16       deleted    -       dal10      1.8.8
  ```
  {: screen}

2.  Installieren Sie die [Calico-CLI](cs_network_policy.html#adding_network_policies).
3.  Listen Sie die verfügbaren Workerknoten in Calico auf. Ersetzen Sie <dateipfad> durch den lokalen Pfad zur Calico-Konfigurationsdatei.

  ```
  calicoctl get nodes --config=<dateipfad>/calicoctl.cfg
  ```
  {: pre}

  ```
  NAME
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w1
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w2
  ```
  {: screen}

4.  Löschen Sie den doppelten Workerknoten in Calico. Ersetzen Sie KNOTEN-ID durch die Workerknoten-ID.

  ```
  calicoctl delete node KNOTEN-ID --config=<dateipfad>/calicoctl.cfg
  ```
  {: pre}

5.  Starten Sie den Workerknoten, der nicht gelöscht wurde, neu.

  ```
  bx cs worker-reboot CLUSTER-ID KNOTEN-ID
  ```
  {: pre}


Der gelöschte Knoten wird nicht mehr in Calico aufgelistet.

<br />


## Cluster verbleibt im Wartestatus ('Pending')
{: #cs_cluster_pending}

{: tsSymptoms}
Wenn Sie Ihren Cluster bereitstellen, bleibt dieser im Wartestatus und startet nicht. 

{: tsCauses}
Wenn Sie den Cluster gerade erst erstellt haben, werden die Workerknoten möglicherweise noch konfiguriert. Wenn Sie bereits eine Weile gewartet haben, ist Ihr VLAN möglicherweise ungültig. 

{: tsResolve}

Sie können eine der folgenden Lösungen ausprobieren: 
  - Überprüfen Sie den Status Ihres Clusters, indem Sie den folgenden Befehl ausführen: `bx cs clusters`. Überprüfen Sie dann, dass Ihre Workerknoten bereitgestellt wurden, indem Sie den folgenden Befehl ausgeben: `bx cs workers <cluster_name>`.
  - Überprüfen Sie, ob Ihr VLAN gültig ist. Damit ein VLAN gültig ist, muss es einer Infrastruktur zugeordnet sein, die einen Worker mit lokalem Plattenspeicher hosten kann. Sie können [Ihre VLANs auflisten](/docs/containers/cs_cli_reference.html#cs_vlans), indem Sie den Befehl `bx cs vlans LOCATION` ausführen. Wenn das VLAN nicht in der Liste aufgeführt wird, dann ist es nicht gültig. Wählen Sie ein anderes VLAN aus.

<br />


## Pods verweilen in  im Status 'Pending' (Anstehend)
{: #cs_pods_pending}

{: tsSymptoms}
Beim Ausführen von `kubectl get pods` verbleiben Pods weiterhin im Status **Pending** (Anstehend).

{: tsCauses}
Wenn Sie den Kubernetes-Cluster gerade erst erstellt haben, werden die Workerknoten möglicherweise noch konfiguriert. Falls dieser Cluster bereits vorhanden ist, steht unter Umständen nicht ausreichend Kapazität für die Bereitstellung des Pods in Ihrem Cluster zur Verfügung.

{: tsResolve}
Für diese Task ist die [Zugriffsrichtlinie 'Administrator'](cs_users.html#access_policies) erforderlich. Überprüfen Sie Ihre aktuelle [Zugriffsrichtlinie](cs_users.html#infra_access).

Führen Sie den folgenden Befehl aus, wenn Sie den Kubernetes-Cluster gerade erst erstellt haben. Warten Sie, bis die Workerknoten initialisiert werden.

```
kubectl get nodes
```
{: pre}

Falls dieser Cluster bereits vorhanden ist, prüfen Sie Ihre Clusterkapazität.

1.  Legen Sie die Standardportnummer für den Proxy fest.

  ```
  kubectl proxy
  ```
   {: pre}

2.  Öffnen Sie das Kubernetes-Dashboard.

  ```
  http://localhost:8001/ui
  ```
  {: pre}

3.  Überprüfen Sie, ob in Ihrem Cluster ausreichend Kapazität verfügbar ist, um Ihren Pod bereitzustellen.

4.  Falls Ihr Cluster nicht genügend freie Kapazität bietet, fügen Sie einen weiteren Workerknoten zu ihm hinzu.

  ```
  bx cs worker-add <clustername_oder_-id> 1
  ```
  {: pre}

5.  Falls Ihre Pods auch weiterhin im Status **Pending** (Anstehend) verweilen, obwohl der Workerknoten voll bereitgestellt wurde, ziehen Sie die [Kubernetes-Dokumentation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tasks/debug-application-cluster/debug-pod-replication-controller/#my-pod-stays-pending) zurate, um die Ursache für den andauernden Status 'Pending' Ihres Pods zu ermitteln und den Fehler zu beheben.

<br />




## Container werden nicht gestartet
{: #containers_do_not_start}

{: tsSymptoms}
Die Pods wurden erfolgreich auf den Clustern bereitgestellt, aber die Container können nicht gestartet werden.

{: tsCauses}
Die Container werden möglicherweise nicht gestartet, wenn die Registry-Quote erreicht ist.

{: tsResolve}
[Geben Sie Speicherplatz in {{site.data.keyword.registryshort_notm}} frei.](../services/Registry/registry_quota.html#registry_quota_freeup)

<br />




## Protokolle werden nicht angezeigt
{: #cs_no_logs}

{: tsSymptoms}
Beim Zugriff auf das Kibana-Dashboard werden keine Protokolle angezeigt.

{: tsResolve}
Überprüfen Sie die folgenden möglichen Ursachen für nicht angezeigte Protokolle sowie die entsprechenden Fehlerbehebungsschritte:

<table>
<col width="40%">
<col width="60%">
 <thead>
 <th>Mögliche Ursache</th>
 <th>Fehlerbehebungsmaßnahme</th>
 </thead>
 <tbody>
 <tr>
 <td>Es ist keine Protokollierungskonfiguration eingerichtet.</td>
 <td>Damit Protokolle gesendet werden, müssen Sie zunächst eine Protokollierungskonfiguration erstellen, um Protokolle an {{site.data.keyword.loganalysislong_notm}} weiterzuleiten. Weitere Informationen zum Erstellen einer Protokollierungskonfiguration finden Sie unter <a href="cs_health.html#logging">Clusterprotokollierung konfigurieren</a>.</td>
 </tr>
 <tr>
 <td>Der Cluster weist nicht den Status <code>Normal</code> auf.</td>
 <td>Informationen darüber, wie Sie den Status des Clusters überprüfen können, finden Sie unter <a href="cs_troubleshoot.html#debug_clusters">Cluster debuggen</a>.</td>
 </tr>
 <tr>
 <td>Das Kontingent für den Protokollspeicher ist erschöpft.</td>
 <td>Informationen darüber, wie Sie die Protokollspeichergrenze erhöhen können, finden Sie in der <a href="/docs/services/CloudLogAnalysis/troubleshooting/error_msgs.html">{{site.data.keyword.loganalysislong_notm}}-Dokumentation</a>.</td>
 </tr>
 <tr>
 <td>Wenn Sie beim Erstellen des Clusters einen Bereich angegeben haben, verfügt der Kontoeigner nicht über die Berechtigungen eines Managers, Entwicklers oder Prüfers für diesen Bereich.</td>
 <td>Gehen Sie wie folgt vor, um die Zugriffsberechtigungen für den Kontoeigner zu ändern:<ol><li>Führen Sie den folgenden Befehl aus, um den Kontoeigner für den Cluster zu ermitteln: <code>bx cs api-key-info &lt;clustername_oder_-id&gt;</code>.</li><li>Informationen darüber, wie dem betreffenden Kontoeigner die {{site.data.keyword.containershort_notm}}-Zugriffsberechtigung eines Managers, Entwicklers oder Prüfers für den Bereich zugeordnet werden kann, finden Sie unter <a href="cs_users.html#managing">Clusterzugriff verwalten</a>.</li><li>Führen Sie den folgenden Befehl aus, um das Protokollierungstoken nach Änderung der Berechtigungen zu aktualisieren: <code>bx cs logging-config-refresh &lt;clustername_oder_-id&gt;</code>.</li></ol></td>
 </tr>
 </tbody></table>

Um Änderungen zu testen, die Sie während der Fehlerbehebung vorgenommen haben, können Sie Noisy auf einem Workerknoten in Ihrem Cluster bereitstellen. Dabei handelt es sich um einen Beispiel-Pod, der mehrere Protokollereignisse generiert.

  1. [Geben Sie als Ziel der CLI](cs_cli_install.html#cs_cli_configure) einen Cluster an, auf dem Protokolle generiert werden sollen.

  2. Erstellen Sie die Konfigurationsdatei `deploy-noisy.yaml`.

      ```
      apiVersion: v1
      kind: Pod
      metadata:
        name: noisy
      spec:
        containers:
        - name: noisy
          image: ubuntu:16.04
          command: ["/bin/sh"]
          args: ["-c", "while true; do sleep 10; echo 'Hello world!'; done"]
          imagePullPolicy: "Always"
        ```
        {: codeblock}

  3. Führen Sie die Konfigurationsdatei in dem Kontext des Clusters aus.

        ```
        kubectl apply -f <dateipfad_zu_noisy>
        ```
        {:pre}

  4. Nach einigen Minuten werden die Protokolle im Kibana-Dashboard angezeigt. Zum Zugriff auf das Kibana-Dashboard müssen Sie eine der folgenden URLs aufrufen und dann das {{site.data.keyword.Bluemix_notm}}-Konto, in dem Sie den Cluster erstellt haben, auswählen. Wenn Sie beim Erstellen des Clusters einen Bereich angegeben haben, wechseln Sie stattdessen zu diesem Bereich.
      - Vereinigte Staaten (Süden) und Vereinigte Staaten (Osten): https://logging.ng.bluemix.net
      - Großbritannien (Süden): https://logging.eu-gb.bluemix.net
      - Zentraleuropa: https://logging.eu-fra.bluemix.net
      - Asiatisch-pazifischer Raum (Süden): https://logging.au-syd.bluemix.net

<br />




## Im Kubernetes-Dashboard werden keine Nutzungsdiagramme angezeigt
{: #cs_dashboard_graphs}

{: tsSymptoms}
Beim Zugriff auf das Kubernetes-Dashboard werden keine Nutzungsdiagramme angezeigt.

{: tsCauses}
Nach einer Clusteraktualisierung oder dem Neustart eines Workerknotens kann es vorkommen, dass der Pod `kube-dashboard` nicht aktualisiert wird.

{: tsResolve}
Löschen Sie den Pod `kube-dashboard`, um einen Neustart zu erzwingen. Der Pod wird mit RBAC-Richtlinien erneut erstellt, um die Informationen zur Auslastung von Heapster abzurufen.

  ```
  kubectl delete pod -n kube-system $(kubectl get pod -n kube-system --selector=k8s-app=kubernetes-dashboard -o jsonpath='{.items..metadata.name}')
  ```
  {: pre}

<br />


## Hinzufügen von Zugriff für Benutzer ohne Rootberechtigung auf persistente Speicher ist fehlgeschlagen
{: #cs_storage_nonroot}

{: tsSymptoms}
Nach dem [Hinzufügen von Zugriff für Benutzer ohne Rootberechtigung auf persistenten Speicher](cs_storage.html#nonroot) oder nach dem Bereitstellen eines Helm-Diagramms, in dem ein Benutzer ohne Rootberechtigung angegeben ist, kann der Benutzer nicht in den angehängten Speicher schreiben. 

{: tsCauses}
Die Bereitstellungs- oder Helm-Diagrammkonfiguration gibt den [Sicherheitskontext](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/) für `fsGroup` (Gruppen-ID) und `runAsUser` (Benutzer-ID) des Pod an. Aktuell unterstützt {{site.data.keyword.containershort_notm}} die Spezifikation `fsGroup` nicht, sondern nur `runAsUser` mit der Festlegung als `0` (Rootberechtigungen). 

{: tsResolve}
Entfernen Sie in der Konfiguration die `securityContext`-Felder für `fsGroup` und `runAsUser` aus dem Image, der Bereitstellungs- oder Helm-Diagrammkonfigurationsdatei und nehmen Sie die Bereitstellung erneut vor. Wenn Sie die Eigentumsrechte des Mountpfads von `nobody` ändern müssen, [fügen Sie Zugriff für Benutzer ohne Rootberechtigung hinzu](cs_storage.html#nonroot).

<br />


## Verbindung mit einer App über einen Lastausgleichsservice kann nicht hergestellt werden
{: #cs_loadbalancer_fails}

{: tsSymptoms}
Sie haben Ihre App öffentlich zugänglich gemacht, indem Sie einen Lastausgleichsservice in Ihrem Cluster erstellt haben. Als Sie versuchten, eine Verbindung mit Ihrer App über die öffentliche IP-Adresse der Lastausgleichsfunktion herzustellen, ist die Verbindung fehlgeschlagen oder sie hat das zulässige Zeitlimit überschritten.

{: tsCauses}
Ihr Lastausgleichsservice funktioniert aus einem der folgenden Gründe möglicherweise nicht ordnungsgemäß:

-   Der Cluster ist ein kostenloser Cluster oder Standardcluster mit nur einem Workerknoten.
-   Der Cluster ist noch nicht vollständig bereitgestellt.
-   Das Konfigurationsscript für Ihren Lastausgleichsservice enthält Fehler.

{: tsResolve}
Gehen Sie wie folgt vor, um Fehler in Ihrem Lastausgleichsservice zu beheben:

1.  Prüfen Sie, dass Sie einen Standardcluster einrichten, der vollständig bereitgestellt ist und mindestens zwei Workerknoten umfasst, um Hochverfügbarkeit für Ihren Lastausgleichsservice zu gewährleisten.

  ```
  bx cs workers <clustername_oder_-id>
  ```
  {: pre}

    Stellen Sie in Ihrer CLI-Ausgabe sicher, dass der **Status** Ihrer Workerknoten **Ready** (Bereit) lautet und dass für den **Maschinentyp** etwas anderes als **free** (frei) anzeigt wird.

2.  Prüfen Sie die Richtigkeit der Konfigurationsdatei für Ihren Lastausgleichsservice.

  ```
  apiVersion: v1
  kind: Service
  metadata:
    name: myservice
  spec:
    type: LoadBalancer
    selector:
      <selektorschlüssel>:<selektorwert>
    ports:
     - protocol: TCP
       port: 8080
  ```
  {: pre}

    1.  Überprüfen Sie, dass Sie **LoadBalancer** als Typ für Ihren Service definiert haben.
    2.  Stellen Sie sicher, dass Sie denselben **<selektorschlüssel>** und **<selektorwert>** verwendet haben, den Sie beim Bereitstellen Ihrer App im Abschnitt **label/metadata** angegeben haben.
    3.  Prüfen Sie, dass Sie den **Port** verwendet haben, den Ihre App überwacht.

3.  Prüfen Sie Ihren Lastausgleichsservice und suchen Sie im Abschnitt zu den Ereignissen (**Events**) nach potenziellen Fehlern.

  ```
  kubectl describe service <myservice>
  ```
  {: pre}

    Suchen Sie nach den folgenden Fehlernachrichten:

    <ul><li><pre class="screen"><code>Clusters with one node must use services of type NodePort</code></pre></br>Um den Lastausgleichsservice verwenden zu können, müssen Sie über ein Standardcluster mit mindestens zwei Workerknoten verfügen.</li>
    <li><pre class="screen"><code>No cloud provider IPs are available to fulfill the load balancer service request. Add a portable subnet to the cluster and try again</code></pre></br>Diese Fehlernachricht weist darauf hin, dass keine portierbaren öffentlichen IP-Adressen mehr verfügbar sind, die Ihrem Lastausgleichsservice zugeordnet werden können. Informationen zum Anfordern portierbarer IP-Adressen für Ihren Cluster finden Sie unter <a href="cs_subnets.html#subnets">Clustern Teilnetze hinzufügen</a>. Nachdem portierbare öffentliche IP-Adressen im Cluster verfügbar gemacht wurden, wird der Lastausgleichsservice automatisch erstellt.</li>
    <li><pre class="screen"><code>Requested cloud provider IP <cloud-provider-ip> is not available. The following cloud provider IPs are available: <available-cloud-provider-ips></code></pre></br>Sie haben eine portierbare öffentliche IP-Adresse für Ihren Lastausgleichsservice mithilfe des Abschnitts **loadBalancerIP** definiert, aber diese portierbare öffentliche IP-Adresse ist in Ihrem portierbaren öffentlichen Teilnetz nicht verfügbar. Ändern Sie das Konfigurationsscript Ihres Lastausgleichsservice und wählen Sie entweder eine der portierbaren öffentlichen IP-Adressen aus, oder entfernen Sie den Abschnitt **loadBalancerIP** aus Ihrem Script, damit eine verfügbare portierbare öffentliche IP-Adresse automatisch zugeordnet werden kann.</li>
    <li><pre class="screen"><code>No available nodes for load balancer services</code></pre>Sie verfügen nicht über ausreichend Workerknoten, um einen Lastausgleichsservice bereitzustellen. Ein Grund kann sein, dass Sie einen Standardcluster mit mehr ale einem Workerknoten bereitgestellt haben, aber die Bereitstellung der Workerknoten ist fehlgeschlagen.</li>
    <ol><li>Listen Sie verfügbare Workerknoten auf.</br><pre class="codeblock"><code>kubectl get nodes</code></pre></li>
    <li>Werden mindestens zwei verfügbare Workerknoten gefunden, listen Sie die Details der Workerknoten auf.</br><pre class="codeblock"><code>bx cs worker-get [&lt;clustername_oder_-id&gt;] &lt;worker-ID&gt;</code></pre></li>
    <li>Stellen Sie sicher, dass die öffentlichen und privaten VLAN-IDs für die Workerknoten, die von den Befehlen <code>kubectl get nodes</code> und <code>bx cs [&lt;clustername_oder_-id&gt;] worker-get</code> zurückgegeben wurden, übereinstimmen.</li></ol></li></ul>

4.  Wenn Sie eine angepasste Domäne verwenden, um Ihren Lastausgleichsservice zu verbinden, stellen Sie sicher, dass Ihre angepasste Domäne der öffentlichen IP-Adresse Ihres Lastausgleichsservice zugeordnet ist.
    1.  Suchen Sie nach der öffentlichen IP-Adresse Ihres Lastausgleichsservice.

      ```
      kubectl describe service <mein_service> | grep "LoadBalancer Ingress"
      ```
      {: pre}

    2.  Prüfen Sie, dass Ihre angepasste Domäne der portierbaren öffentlichen IP-Adresse Ihres Lastausgleichsservice im Zeigerdatensatz (PTR) zugeordnet ist.

<br />


## Verbindung mit einer App über Ingress kann nicht hergestellt werden
{: #cs_ingress_fails}

{: tsSymptoms}
Sie haben Ihre App öffentlich zugänglich gemacht, indem Sie eine Ingress-Ressource für Ihre App in Ihrem Cluster erstellt haben. Als Sie versuchten, eine Verbindung mit Ihrer App über die öffentliche IP-Adresse oder Unterdomäne der Ingress-Lastausgleichsfunktion für Anwendungen herzustellen, ist die Verbindung fehlgeschlagen oder sie hat das zulässige Zeitlimit überschritten.

{: tsCauses}
Ingress funktioniert aus den folgenden Gründen möglicherweise nicht ordnungsgemäß:
<ul><ul>
<li>Der Cluster ist noch nicht vollständig bereitgestellt.
<li>Der Cluster wurde als kostenloser Cluster oder als Standardcluster mit nur einem Workerknoten eingerichtet.
<li>Das Ingress-Konfigurationsscript enthält Fehler.
</ul></ul>

{: tsResolve}
Gehen Sie wie folgt vor, um Fehler in Ingress zu beheben:

1.  Prüfen Sie, dass Sie einen Standardcluster einrichten, der vollständig ist und mindestens zwei Workerknoten umfasst, um Hochverfügbarkeit für Ihre Ingress-Lastausgleichsfunktion für Anwendungen zu gewährleisten.

  ```
  bx cs workers <clustername_oder_-id>
  ```
  {: pre}

    Stellen Sie in Ihrer CLI-Ausgabe sicher, dass der **Status** Ihrer Workerknoten **Ready** (Bereit) lautet und dass für den **Maschinentyp** etwas anderes als **free** (frei) anzeigt wird.

2.  Rufen Sie die Unterdomäne und die öffentliche IP-Adresse der Ingress-Lastausgleichsfunktion für Anwendungen ab und setzen Sie anschließend ein Pingsignal an beide ab.

    1.  Rufen Sie die Unterdomäne der Lastausgleichsfunktion für Anwendungen ab.

      ```
      bx cs cluster-get <clustername_oder_-id> | grep "Ingress subdomain"
      ```
      {: pre}

    2.  Setzen Sie ein Pingsignal an die Unterdomäne der Ingress-Lastausgleichsfunktion für Anwendungen ab.

      ```
      ping <unterdomäne_des_ingress-controllers>
      ```
      {: pre}

    3.  Rufen Sie die öffentliche IP-Adresse Ihrer Ingress-Lastausgleichsfunktion für Anwendungen ab.

      ```
      nslookup <unterdomäne_des_ingress-controllers>
      ```
      {: pre}

    4.  Setzen Sie ein Pingsignal an die öffentliche IP-Adresse der Ingress-Lastausgleichsfunktion für Anwendungen ab.

      ```
      ping <ip_des_ingress-controllers>
      ```
      {: pre}

    Falls die CLI eine Zeitlimitüberschreitung für die öffentliche IP-Adresse oder die Unterdomäne der Ingress-Lastausgleichsfunktion für Anwendungen zurückgibt und Sie eine angepasste Firewall eingerichtet haben, die Ihre Workerknoten schützt, müssen Sie unter Umständen zusätzliche Ports und Netzgruppen in Ihrer [Firewall](#cs_firewall) öffnen.

3.  Wenn Sie eine angepasste Domäne verwenden, stellen Sie sicher, dass Ihre angepasste Domäne der öffentlichen IP-Adresse oder Unterdomäne der von IBM bereitgestellten Ingress-Lastausgleichsfunktion für Anwendungen mit Ihrem DNS-Anbieter (Domain Name Service) zugeordnet ist.
    1.  Wenn Sie die Unterdomäne der Ingress-Lastausgleichsfunktion für Anwendungen verwendet haben, prüfen Sie Ihren CNAME-Datensatz (Canonical Name, kanonischer Name).
    2.  Wenn Sie die öffentliche IP-Adresse der Ingress-Lastausgleichsfunktion für Anwendungen verwendet haben, prüfen Sie, dass Ihre angepasste Domäne der portierbaren öffentlichen IP-Adresse im Zeigerdatensatz (PTR) zugeordnet ist.
4.  Prüfen Sie Ihre Ingress-Ressourcenkonfigurationsdatei.

    ```
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: myingress
    spec:
      tls:
      - hosts:
        - <ingress-unterdomäne>
        secretName: <ingress-tls-schlüssel>
      rules:
      - host: <ingress-unterdomäne>
        http:
          paths:
          - path: /
            backend:
              serviceName: myservice
              servicePort: 80
    ```
    {: codeblock}

    1.  Prüfen Sie, dass die Unterdomäne der Ingress-Lastausgleichsfunktion für Anwendungen und das TLS-Zertifikat korrekt sind. Um die von IBM bereitgestellte Unterdomäne und das TLS-Zertifikat zu finden, führen Sie den folgenden Befehl aus: `bx cs cluster-get <cluster_name_or_id>`.
    2.  Stellen Sie sicher, dass Ihre App denselben Pfad überwacht, der im Abschnitt **path** von Ingress konfiguriert ist. Wenn Ihre App so eingerichtet ist, dass sie den Rootpfad überwacht, schließen Sie **/** als Ihren Pfad ein.
5.  Überprüfen Sie Ihre Ingress-Bereitstellung und suchen Sie nach möglichen Warnungen und Fehlernachrichten. 

    ```
    kubectl describe ingress <myingress>
    ```
    {: pre}

    Im Abschnitt **Ereignisse** der Ausgabe sehen Sie möglicherweise Nachrichten zu ungültigen Werten in Ihrer Ingress-Ressource oder in bestimmten Annotationen, die Sie verwendet haben. 

    ```
    Name:             myingress
    Namespace:        default
    Address:          169.xx.xxx.xx,169.xx.xxx.xx
    Default backend:  default-http-backend:80 (<none>)
    Rules:
      Host                                             Path  Backends
      ----                                             ----  --------
      mycluster.us-south.containers.mybluemix.net
                                                       /tea      myservice1:80 (<none>)
                                                       /coffee   myservice2:80 (<none>)
    Annotations:
      custom-port:        protocol=http port=7490; protocol=https port=4431
      location-modifier:  modifier='~' serviceName=myservice1;modifier='^~' serviceName=myservice2
    Events:
      Type     Reason             Age   From                                                            Message
      ----     ------             ----  ----                                                            -------
      Normal   Success            1m    public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Successfully applied ingress resource.
      Warning  TLSSecretNotFound  1m    public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Failed to apply ingress resource.
      Normal   Success            59s   public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Successfully applied ingress resource.
      Warning  AnnotationError    40s   public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Failed to apply ingress.bluemix.net/custom-port annotation. Error annotation format error : One of the mandatory fields not valid/missing for annotation ingress.bluemix.net/custom-port
      Normal   Success            40s   public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Successfully applied ingress resource.
      Warning  AnnotationError    2s    public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Failed to apply ingress.bluemix.net/custom-port annotation. Invalid port 7490. Annotation cannot use ports 7481 - 7490
      Normal   Success            2s    public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Successfully applied ingress resource.
    ```
    {: screen}

6.  Überprüfen Sie die Protokolle für Ihre Lastausgleichsfunktion für Anwendungen.
    1.  Rufen Sie die ID der Ingress-Pods ab, die in Ihrem Cluster ausgeführt werden.

      ```
      kubectl get pods -n kube-system | grep alb1
      ```
      {: pre}

    2.  Rufen Sie die Protokolle für jeden Ingress-Pod ab.

      ```
      kubectl logs <ingress-pod-id> nginx-ingress -n kube-system
      ```
      {: pre}

    3.  Suchen Sie nach Fehlernachrichten in den Protokollen der Lastausgleichsfunktion für Anwendungen. 

<br />



## Probleme mit geheimen Schlüsseln der Ingress-Lastausgleichsfunktion für Anwendungen
{: #cs_albsecret_fails}

{: tsSymptoms}
Nach der Bereitstellung eines geheimen Schlüssels der Ingress-Lastausgleichsfunktion für Anwendungen für Ihren Cluster wird das Beschreibungsfeld `Description` nicht mit dem Namen des geheimen Schlüssels aktualisiert, wenn Sie Ihr Zertifikat in {{site.data.keyword.cloudcerts_full_notm}} anzeigen.

Beim Auflisten von Informationen zum geheimen Schlüssel der Lastausgleichsfunktion für Anwendungen wird der Status `*_failed` angezeigt. Beispiel: `create_failed`, `update_failed` oder `delete_failed`.

{: tsResolve}
Überprüfen Sie die folgenden möglichen Ursachen für ein Fehlschlagen des geheimen Schlüssels der Lastausgleichsfunktion für Anwendungen sowie die entsprechenden Fehlerbehebungsschritte:

<table>
 <thead>
 <th>Mögliche Ursache</th>
 <th>Fehlerbehebungsmaßnahme</th>
 </thead>
 <tbody>
 <tr>
 <td>Sie verfügen nicht über die erforderlichen Zugriffsrollen für das Herunterladen und Aktualisieren von Zertifikatsdaten.</td>
 <td>Bitten Sie Ihren Kontoadministrator, Ihnen sowohl die Rolle eines **Operators** als auch die Rolle eines **Bearbeiters** für Ihre Instanz von {{site.data.keyword.cloudcerts_full_notm}} zuzuweisen. Weitere Informationen hierzu finden Sie im Thema <a href="/docs/services/certificate-manager/about.html#identity-access-management">Identitäts- und Zugriffsmanagement</a> für {{site.data.keyword.cloudcerts_short}}.</td>
 </tr>
 <tr>
 <td>Die CRN des Zertifikats, die zum Zeitpunkt der Erstellung, Aktualisierung oder Entfernung angegeben wurde, gehört nicht zu demselben Konto wie der Cluster.</td>
 <td>Vergewissern Sie sich, dass die von Ihnen angegebene CRN des Zertifikats in eine Instanz des {{site.data.keyword.cloudcerts_short}}-Service importiert wurde, die in demselben Konto wie Ihr Cluster bereitgestellt wird.</td>
 </tr>
 <tr>
 <td>Die zum Zeitpunkt der Erstellung angegebene CRN des Zertifikats ist falsch.</td>
 <td><ol><li>Überprüfen Sie die Richtigkeit der von Ihnen angegebenen Zeichenfolge für die CRN des Zertifikats. </li><li>Falls die CRN des Zertifikats als korrekt befunden wird, versuchen Sie den geheimen Schlüssel <code>bx cs alb-cert-deploy --update --cluster &lt;clustername_oder_id&gt; --secret-name &lt;name_des_geheimen_schlüssels&gt; --cert-crn &lt;CRN_des_zertifikats&gt;</code> zu aktualisieren. </li><li>Wenn dieser Befehl zum Status <code>update_failed</code> führt, entfernen Sie den geheimen Schlüssel: <code>bx cs alb-cert-rm --cluster &lt;clustername_oder_id&gt; --secret-name &lt;name_des_geheimen_schlüssels&gt;</code></li><li>Stellen Sie den geheimen Schlüssel erneut bereit: <code>bx cs alb-cert-deploy --cluster &lt;clustername_oder_id&gt; --secret-name &lt;name_des_geheimen_schlüssels&gt; --cert-crn &lt;CRN_des_zertifikatsN&gt;</code></li></ol></td>
 </tr>
 <tr>
 <td>Die zum Zeitpunkt der Aktualisierung angegebene CRN des Zertifikats ist falsch.</td>
 <td><ol><li>Überprüfen Sie die Richtigkeit der von Ihnen angegebenen Zeichenfolge für die CRN des Zertifikats. </li><li>Wenn die CRN des Zertifikats als korrekt befunden wurde, enternen Sie den geheimen Schlüssel: <code>bx cs alb-cert-rm --cluster &lt;clustername_oder_id&gt; --secret-name &lt;name_des_geheimen_schlüssels&gt;</code></li><li>Stellen Sie den geheimen Schlüssel erneut bereit: <code>bx cs alb-cert-deploy --cluster &lt;clustername_oder_id&gt; --secret-name &lt;name_des_geheimen_schlüssels&gt; --cert-crn &lt;CRN_des_zertifikats&gt;</code></li><li>Versuchen Sie, den geheimen Schlüssel zu aktualisieren: <code>bx cs alb-cert-deploy --update --cluster &lt;clustername_oder_id&gt; --secret-name &lt;name_des_geheimen_schlüssels&gt; --cert-crn &lt;CRN_des_zertifikats&gt;</code></li></ol></td>
 </tr>
 <tr>
 <td>Der {{site.data.keyword.cloudcerts_long_notm}}-Service ist ausgefallen.</td>
 <td>Vergewissern Sie sich, dass Ihr {{site.data.keyword.cloudcerts_short}}-Service betriebsbereit ist.</td>
 </tr>
 </tbody></table>

<br />


## Ein Helm-Diagramm kann nicht mit aktualisierten Konfigurationswerten installiert werden.
{: #cs_helm_install}

{: tsSymptoms}
Wenn Sie versuchen, ein aktualsiertes Helm-Diagramm zu installieren, indem Sie den Befehl `helm install -f config.yaml --namespace=kube-system --name=<release_name> ibm/<chart_name>` ausführen, erhalten Sie die Fehlernachricht `Error: failed to download "ibm/<chart_name>"`. 

{: tsCauses}
Die URL für das {{site.data.keyword.Bluemix_notm}}-Repository in Ihrer Helm-Instanz ist möglicherweise nicht korrekt. 

{: tsResolve}
Gehen Sie wie folgt vor, um Fehler in Ihrem Helm-Diagramm zu beheben: 

1. Listen Sie die Repository auf, die aktuell in Ihrer Helm-Instanz verfügbar sind. 

    ```
    helm repo list
    ```
    {: pre}

2. Überprüfen Sie in der Ausgabe, dass die URL für das {{site.data.keyword.Bluemix_notm}}-Repository, `ibm`, wie folgt lautet: `https://registry.bluemix.net/helm/ibm`.

    ```
    NAME    URL
    stable  https://kubernetes-charts.storage.googleapis.com
    local   http://127.0.0.1:8888/charts
    ibm     https://registry.bluemix.net/helm/ibm
    ```
    {: screen}

    * Falls die URL falsch ist: 

        1. Entfernen Sie das {{site.data.keyword.Bluemix_notm}}-Repository.

            ```
            helm repo remove ibm
            ```
            {: pre}

        2. Fügen Sie das {{site.data.keyword.Bluemix_notm}}-Repository erneut hinzu. 

            ```
            helm repo add ibm  https://registry.bluemix.net/helm/ibm
            ```
            {: pre}

    * Wenn die URL richtig ist, rufen Sie die aktuellsten Aktualisierung vom Repository ab: 

        ```
        helm repo update
        ```
        {: pre}

3. Installieren Sie das Helm-Diagramm mit Ihren Aktualisierungen. 

    ```
    helm install -f config.yaml --namespace=kube-system --name=<release_name> ibm/<chart_name>
    ```
    {: pre}


<br />


## VPN-Konnektivität kann nicht mit dem StrongSwan-Helm-Diagramm erstellt werden
{: #cs_vpn_fails}

{: tsSymptoms}
Wenn Sie die VPN-Konnektivität überprüfen, indem Sie den Befehl `kubectl exec -n kube-system  $STRONGSWAN_POD -- ipsec status` ausführen, sehen Sie den Status `ESTABLISHED` nicht oder der VPN-Pod befindet sich im Fehlerstatus `ERROR` oder er schlägt immer wieder fehl und startet neu. 

{: tsCauses}
Ihre Helm-Diagrammkonfigurationsdatei weist falsche oder fehlende Werte auf oder es liegen Syntaxfehler vor. 

{: tsResolve}
Wenn Sie versuchen, VPN-Konnektivität mit dem StrongSwan-Helm-Diagramm zu erstellen, ist es wahrscheinlich, dass der Status beim ersten Mal nicht `ESTABLISHED` lautet. Möglicherweise müssen Sie mehrere Problemtypen überprüfen und Ihre Konfigurationsdatei entsprechend ändern. Gehen Sie wie folgt vor, um Fehler in Ihrer StrongSwan-VPN-Konnektivität zu beheben:

1. Überprüfen Sie die Einstellungen des lokalen VPN-Endpunkts im Unternehmen mit den Einstellungen in Ihrer Konfigurationsdatei. Falls Sie fehlende Übereinstimmung feststellen: 

    <ol>
    <li>Löschen Sie das vorhandene Helm-Diagramm. </br><pre class="codeblock"><code>helm delete --purge <releasename></code></pre></li>
    <li>Korrigieren Sie die falschen Werte in der Datei <code>config.yaml</code> und speichern Sie die aktualisiert Datei. </li>
    <li>Installieren Sie das neue Helm-Diagramm.</br><pre class="codeblock"><code>helm install -f config.yaml --namespace=kube-system --name=<releasename> bluemix/strongswan</code></pre></li>
    </ol>

2. Falls der VPN-Pod den Status `ERROR` hat oder immer wieder ausfällt und neu startet, kann dies an der Parametervalidierung der `ipsec.conf`-Einstellungen in der Konfigurationsmap des Diagramms liegen.

    <ol>
    <li>Überprüfen Sie alle Gültigkeitsfehler in den StrongSwan-Pod-Protokollen. </br><pre class="codeblock"><code>kubectl logs -n kube-system $STRONGSWAN_POD</code></pre></li>
    <li>Falls Gültigkeitsfehler vorliegen, löschen Sie das vorhandene Helm-Diagramm.</br><pre class="codeblock"><code>helm delete --purge <releasename></code></pre></li>
    <li>Korrigieren Sie die falschen Werte in der Datei `config.yaml` und speichern Sie die aktualisiert Datei. </li>
    <li>Installieren Sie das neue Helm-Diagramm.</br><pre class="codeblock"><code>helm install -f config.yaml --namespace=kube-system --name=<releasename> bluemix/strongswan</code></pre></li>
    </ol>

3. Führen Sie die 5 Helm-Tests aus, die in der StrongSwan-Diagrammdefinition enthalten sind. 

    <ol>
    <li>Führen Sie die Helm-Tests aus.</br><pre class="codeblock"><code>helm test vpn</code></pre></li>
    <li>Wenn ein Test fehlschlägt, lesen Sie die Informationen zu den einzelnen Tests und warum diese möglicherweise fehlschlagen unter [Erklärung der Helm-VPN-Konnektivitätstests](cs_vpn.html#vpn_tests_table). <b>Hinweis</b>: Einige der Tests haben als Voraussetzungen optionale Einstellungen in der VPN-Konfiguration. Wenn einige der Tests fehlschlagen, kann dies abhängig davon, ob Sie diese optionalen Einstellungen angegeben haben, zulässig sein. </li>
    <li>Zeigen Sie die Ausgabe eines fehlgeschlagenen Tests an, indem Sie die Protokolle des Testpods anzeigen.<br><pre class="codeblock"><code>kubectl logs -n kube-system <testprogramm></code></pre></li>
    <li>Löschen Sie das vorhandene Helm-Diagramm. </br><pre class="codeblock"><code>helm delete --purge <releasename></code></pre></li>
    <li>Korrigieren Sie die falschen Werte in der Datei <code>config.yaml</code> und speichern Sie die aktualisiert Datei. </li>
    <li>Installieren Sie das neue Helm-Diagramm.</br><pre class="codeblock"><code>helm install -f config.yaml --namespace=kube-system --name=<release_name> bluemix/strongswan</code></pre></li>
    <li>Gehen Sie wie folgt vor, um Ihre Änderungen zu überprüfen: <ol><li>Rufen Sie die aktuellen Test-Pods ab. </br><pre class="codeblock"><code>kubectl get pods -a -n kube-system -l app=strongswan-test</code></pre></li><li>Bereinigen Sie die aktuellen Testpods.</br><pre class="codeblock"><code>kubectl delete pods -n kube-system -l app=strongswan-test</code></pre></li><li>Führen Sie den Test erneut aus.</br><pre class="codeblock"><code>helm test vpn</code></pre></li>
    </ol></ol>

4. Führen Sie das VPN-Debugging-Tool aus, das im Paket des VPN-Pod-Image enthalten ist.

    1. Legen Sie die Umgebungsvariable `STRONGSWAN_POD` fest.

        ```
        export STRONGSWAN_POD=$(kubectl get pod -n kube-system -l app=strongswan,release=vpn -o jsonpath='{ .items[0].metadata.name }')
        ```
        {: pre}

    2. Führen Sie das Debugging-Tool aus.

        ```
        kubectl exec -n kube-system  $STRONGSWAN_POD -- vpnDebug
        ```
        {: pre}

        Das Tool gibt bei seiner Ausführung mehrere Seiten mit Informationen aus, da es verschiedene Tests für allgemeine Netzprobleme ausführt. Ausgabezeilen, die mit `ERROR`, `WARNING`, `VERIFY` oder `CHECK` beginnen, weisen auf mögliche Fehler bei der VPN-Verbindung hin.

    <br />


## StrongSwan-VPN-Konnektivität schlägt nach Hinzufügen oder Löschen von Workerknoten fehl
{: #cs_vpn_fails_worker_add}

{: tsSymptoms}
Sie haben zuvor eine funktionierende VPN-Verbindung mithilfe des StrongSwan-IPSec-VPN-Service hergestellt. Nachdem Sie einen Workerknoten in Ihrem Cluster hinzugefügt oder gelöscht haben, tritt jedoch mindestens eines der folgenden Symptome auf:

* Der VPN-Status lautet nicht `ESTABLISHED`
* Sie können von Ihrem lokalen Netz im Unternehmen nicht auf einen neuen Workerknoten zugreifen
* Sie können von Pods, die auf neuen Workerknoten ausgeführt werden, nicht auf das ferne Netz zugreifen. 

{: tsCauses}
Wenn Sie einen Workerknoten hinzugefügt haben: 

* Der Workerknoten wurde auf einem neuen privaten Teilnetz bereitgestellt, das nicht über die VPN-Verbindung durch Ihre vorhandenen `localSubnetNAT`- oder `local.subnet`-Einstellungen zugänglich gemacht wurde. 
* VPN-Routen können nicht zum Workerknoten hinzugefügt werden, weil der Worker Taints oder Beschriftungen aufweist, die nicht in Ihren vorhandenen `tolerations`- oder `nodeSelector`-Einstellungen enthalten sind. 
* Der VPN-Pod ist auf dem neuen Workerknoten aktiv, aber die öffentliche IP-Adresse des Workerknotens ist über die lokale Firewall des Unternehmens nicht zulässig. 

Wenn Sie einen Workerknoten gelöscht haben: 

* Der Workerknoten war aufgrund von vorhandenen `tolerations`- oder `nodeSelector`-Einstellungen der einzige Knoten, in dem der VPN-Pod aktiv war. 

{: tsResolve}
Aktualisieren Sie die Helm-Diagrammwerte, um die Änderungen im Workerknoten abzubilden. 

1. Löschen Sie das vorhandene Helm-Diagramm. 

    ```
    helm delete --purge <release_name>
    ```
    {: pre}

2. Öffnen Sie die Konfigurationsdatei für Ihren StrongSwan-VPN-Service.

    ```
    helm inspect values ibm/strongswan > config.yaml
    ```
    {: pre}

3. Überprüfgen Sie die folgenden Einstellungen und nehmen Sie bei Bedarf Änderungen vor, um die gelöschten oder hinzugefügten Workerknoten abzubilden. 

    Wenn Sie einen Workerknoten hinzugefügt haben: 

    <table>
     <thead>
     <th>Einstellung</th>
     <th>Beschreibung</th>
     </thead>
     <tbody>
     <tr>
     <td><code>localSubnetNAT</code></td>
     <td>Der hinzugefügte Workerknoten kann in einem neuen, anderen privaten Teilnetz bereitgestellt werden als die anderen vorhandenen Teilnetze, auf denen sich andere Workerknoten befinden. Wenn Sie Teilnetz-NAT (subnetNAT) verwenden, um die privaten lokalen IP-Adressen Ihres Clusters erneut zuzuorden, und wenn ein Workerknoten auf einem neuen Teilnetz hinzugefügt wurde, fügen Sie die neue Teilnetz-CIDR zu dieser Einstellung hinzu. </td>
     </tr>
     <tr>
     <td><code>nodeSelector</code></td>
     <td>Wenn Sie den VPN-Pod zuvor auf die Ausführung auf beliebigen Workerknoten mit einer bestimmten Bezeichnung beschränkt haben und wenn Sie jetzt VPN-Routen zum Worker hinzufügen möchten, stellen Sie sicher, dass der hinzugefügte Workerknoten über diese Bezeichnung verfügt. </td>
     </tr>
     <tr>
     <td><code>tolerations</code></td>
     <td>Wenn der hinzugefügte Workerknoten eine Bezeichnung trägt und Sie dem Worker VPN-Routen hinzufügen möchten, dann ändern Sie die Einstellung, damit der VPN-Pod auf allen Workerknoten mit Bezeichnungen oder auf Workerknoten mit bestimmten Bezeichnungen ausgeführt werden kann. </td>
     </tr>
     <tr>
     <td><code>local.subnet</code></td>
     <td>Der hinzugefügte Workerknoten kann in einem neuen, anderen privaten Teilnetz bereitgestellt werden als die anderen vorhandenen Teilnetze, auf denen sich andere Workerknoten befinden. Wenn Ihre Apps von NodePort- oder LoadBalancer-Services im privaten Netz zugänglich gemacht werden und sich auf einem neuen Workerknoten befinden, den Sie hinzugefügt haben, dann fügen Sie die neue Teilnetz-CIDR zu dieser Einstellung hinzu. **Hinweis**: Wenn Sie Werte zum `lokalen Teilnetz` hinzufügen, überprüfen Sie die VPN-Einstellungen für das lokale Teilnetz im Unternehmen, um zu sehen, ob diese ebenfalls aktualisiert werden müssen. </td>
     </tr>
     </tbody></table>

    Wenn Sie einen Workerknoten gelöscht haben: 

    <table>
     <thead>
     <th>Einstellung</th>
     <th>Beschreibung</th>
     </thead>
     <tbody>
     <tr>
     <td><code>localSubnetNAT</code></td>
     <td>Wenn Sie die Teilnetz-NAT (subnetNAT) verwenden, um bestimmte, private, lokale IP-Adressen erneut zuzuordnen, entfernen Sie alle IP-Adressen aus dem alten Workerknoten. Wenn Sie die Teilnetz-NAT verwenden, um ganze Teilnetze erneut zuzuordnen und wenn sich keine Ihrer Workerknoten mehr im Teilnetz befinden, dann entfernen Sie das Teilnetz-CIDR aus dieser Einstellung. </td>
     </tr>
     <tr>
     <td><code>nodeSelector</code></td>
     <td>Sie haben zuvor den VPN-Pod auf die Ausführung auf einen einzigen Workerknoten beschränkt und dieser Workerknoten wurde gelöscht. Ändern Sie diese Einstellung, um dem VPN-Pod die Ausführung auf anderen Workerknoten zu erlauben. </td>
     </tr>
     <tr>
     <td><code>tolerations</code></td>
     <td>Falls der von Ihnen gelöschte Workerknoten keine Bezeichnung hatte und die einzigen verbleibenden Workerknoten Bezeichnungen aufweisen, ändern Sie diese Einstellung, damit der VPN-Pod auf allen Workerknoten mit Bezeichnungen oder auf Workerknoten mit bestimmten Bezeichnungen ausgeführt werden kann. </td>
     </tr>
     </tbody></table>

4. Installieren Sie das neue Helm-Diagramm mit Ihren aktualisierten Werten. 

    ```
    helm install -f config.yaml --namespace=kube-system --name=<releasename> ibm/strongswan
    ```
    {: pre}

5. Prüfen Sie den Status der Diagrammbereitstellung. Sobald das Diagramm bereit ist, hat das Feld **STATUS** oben in der Ausgabe den Wert `DEPLOYED`.

    ```
    helm status <releasename>
    ```
    {: pre}

6. In einigen Fällen müssen Sie möglicherweise Ihre lokalen Einstellungen im Unternehmen und Ihre Firewalleinstellungen ändern, damit diese mit den Änderungen übereinstimmen, die Sie in der VPN-Konfigurationsdatei vorgenommen haben. 

7. Starten Sie das VPN.
    * Falls die VPN-Verbindung von einem Cluster initialisiert wird (für `ipsec.auto` ist `start` festgelegt), starten Sie das VPN auf einem lokalen Gateway im Unternehmen und starten Sie dann das VPN auf dem Cluster. 
    * Falls die VPN-Verbindung von einem lokalen Gateway im Unternehmen initialisiert wird (für `ipsec.auto` ist `auto` festgelegt), starten Sie das VPN auf dem Cluster und anschließend starten Sie das VPN auf dem lokalen Gateway im Unternehmen.

8. Legen Sie die Umgebungsvariable `STRONGSWAN_POD` fest.

    ```
    export STRONGSWAN_POD=$(kubectl get pod -n kube-system -l app=strongswan,release=<releasename> -o jsonpath='{ .items[0].metadata.name }')
    ```
    {: pre}

9. Prüfen Sie den Status des VPN.

    ```
    kubectl exec -n kube-system  $STRONGSWAN_POD -- ipsec status
    ```
    {: pre}

    * Sobald die VPN-Verbindung den Status `ESTABLISHED` erreicht hat, war die VPN-Verbindung erfolgreich. Es ist keine weitere Aktion erforderlich. 

    * Wenn Sie immer noch Verbindungsprobleme haben, lesen Sie die Informationen im Abschnitt [VPN-Konnektivität mit StrongSwan-Helm-Diagramm kann nicht erstellt werden](#cs_vpn_fails), um weiter nach Fehlern bei der VPN-Verbindung zu suchen. 

<br />


## ETCD-URL für die Konfiguration der Calico-CLI kann nicht abgerufen werden
{: #cs_calico_fails}

{: tsSymptoms}
Wenn Sie die `<ETCD_URL>` abrufen, um [Netzrichtlinien hinzuzufügen](cs_network_policy.html#adding_network_policies), dann gibt das System die Fehlernachricht `calico-config nicht gefunden` aus.

{: tsCauses}
Ihr Cluster verfügt nicht über [Kubernetes Version 1.7](cs_versions.html) oder höher.

{: tsResolve}
[Aktualisieren Sie Ihren Cluster](cs_cluster_update.html#master) oder rufen Sie die `<ETCD_URL>` mithilfe von Befehlen ab, die mit älteren Versionen von Kubernetes kompatibel sind.

Führen Sie die folgenden Befehle aus, um den Wert für `<ETCD_URL>` abzurufen:

- Linux und OS X:

    ```
    kubectl describe pod -n kube-system `kubectl get pod -n kube-system | grep calico-policy-controller | awk '{print $1}'` | grep ETCD_ENDPOINTS | awk '{print $2}'
    ```
    {: pre}

- Windows:
    <ol>
    <li> Rufen Sie eine Liste der Pods im Namensbereich des kube-Systems ab und suchen Sie nach dem Calico-Controller-Pod. </br><pre class="codeblock"><code>kubectl get pod -n kube-system</code></pre></br>Beispiel:</br><pre class="screen"><code>calico-policy-controller-1674857634-k2ckm</code></pre>
    <li> Zeigen Sie die Details des Calico-Controller-Pods an.</br> <pre class="codeblock"><code>kubectl describe pod -n kube-system calico-policy-controller-&lt;ID&gt;</code></pre>
    <li> Suchen Sie den etcd-Endpunktwert. Beispiel: <code>https://169.1.1.1:30001</code>
    </ol>

Wenn Sie die `<ETCD_URL>` abrufen, dann arbeiten Sie mit den Schritten weiter, die unter (Netzrichtlinien hinzufügen)[cs_network_policy.html#adding_network_policies] aufgeführt sind.

<br />




## Hilfe und Unterstützung anfordern
{: #ts_getting_help}

Erste Schritte bei der Fehlerbehebung für einen Container
{: shortdesc}

-   [Überprüfen Sie auf der {{site.data.keyword.Bluemix_notm}}-Statusseite ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://developer.ibm.com/bluemix/support/#status), ob {{site.data.keyword.Bluemix_notm}} verfügbar ist.
-   Veröffentlichen Sie eine Frage im [{{site.data.keyword.containershort_notm}}-Slack. ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://ibm-container-service.slack.com) Tipp: Wenn Sie keine IBM ID für Ihr {{site.data.keyword.Bluemix_notm}}-Konto verwenden, [fordern Sie eine Einladung](https://bxcs-slack-invite.mybluemix.net/) zu diesem Slack an.
-   Suchen Sie in entsprechenden Foren, ob andere Benutzer auf das gleiche Problem
gestoßen sind. Versehen Sie Ihre Fragen in den Foren mit Tags, um sie für das Entwicklungsteam
von {{site.data.keyword.Bluemix_notm}} erkennbar zu machen.

    -   Wenn Sie technische Fragen zur Entwicklung oder Bereitstellung von Clustern oder Apps mit {{site.data.keyword.containershort_notm}} haben, veröffentlichen Sie Ihre Frage auf [Stack Overflow ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://stackoverflow.com/questions/tagged/ibm-cloud+containers) und versehen Sie sie mit den Tags `ibm-cloud`, `kubernetes` und `containers`.
    -   Verwenden Sie für Fragen zum Service und zu ersten Schritten das Forum [IBM developerWorks dW Answers ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://developer.ibm.com/answers/topics/containers/?smartspace=bluemix). Geben Sie die Tags `ibm-cloud` und `containers` an.
    Weitere Details zur Verwendung der Foren
finden Sie unter [Hilfe anfordern](/docs/get-support/howtogetsupport.html#using-avatar).

-   Wenden Sie sich an den IBM Support. Informationen zum Öffnen eines IBM
Support-Tickets oder zu Supportstufen und zu Prioritätsstufen von Tickets finden Sie unter
[Support kontaktieren](/docs/get-support/howtogetsupport.html#getting-customer-support).

{:tip}
Geben Sie beim Melden eines Problems Ihre Cluster-ID an. Führen Sie den Befehl `bx cs clusters` aus, um Ihre Cluster-ID abzurufen.
