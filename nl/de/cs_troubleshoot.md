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
{:tsSymptoms: .tsSymptoms}
{:tsCauses: .tsCauses}
{:tsResolve: .tsResolve}


# Fehlerbehebung für Cluster
{: #cs_troubleshoot}

Ziehen Sie bei der Verwendung von {{site.data.keyword.containershort_notm}} die folgenden Verfahren für die Fehlerbehebung und zum Abrufen von Hilfe in Betracht. Sie können außerdem den [Status des {{site.data.keyword.Bluemix_notm}}-Systems ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://developer.ibm.com/bluemix/support/#status) überprüfen.

Sie können verschiedene allgemeine Schritte ausführen, um sicherzustellen, dass Ihre Cluster auf dem neuesten Stand sind:
- Führen Sie in regelmäßigen Zeitabständen einen [Warmstart der Workerknoten](cs_cli_reference.html#cs_worker_reboot) durch, um sicherzustellen, dass die Installation der Aktualisierungen und Sicherheitspatches, die von IBM automatisch bereitgestellt werden, für das Betriebssystem auch durchgeführt werden.
- Führen Sie für Ihren Cluster eine Aktualisierung auf die [aktuellste Standardversion von Kubernetes](cs_versions.html) für {{site.data.keyword.containershort_notm}} durch.

{: shortdesc}

<br />


## Cluster debuggen
{: #debug_clusters}

Informieren Sie sich über die Optionen, die Ihnen für die Fehlerbehebung bei Ihren Clustern und zum Eingrenzen der jeweiligen Fehlerquelle zur Verfügung stehen.

1.  Listen Sie Ihren Cluster auf und suchen Sie nach `Status` des Clusters.

  ```
  bx cs clusters
  ```
  {: pre}

2.  Überprüfen Sie den `Status` Ihres Clusters.

  <table summary="Jede Tabellenzeile sollte von links nach rechts gelesen werden, wobei der Clusterstatus in der ersten Spalte und eine Beschreibung in der zweiten Spalte angegeben ist.">
    <thead>
    <th>Clusterstatus</th>
    <th>Beschreibung</th>
    </thead>
    <tbody>
      <tr>
        <td>Deploying (Wird bereitgestellt)</td>
        <td>Der Kubernetes-Master ist noch nicht vollständig implementiert. Sie können auf Ihren Cluster nicht zugreifen.</td>
       </tr>
       <tr>
        <td>Pending (Anstehend)</td>
        <td>Der Kubernetes-Master ist bereitgestellt. Die Workerknoten werden gerade eingerichtet und sind noch nicht im Cluster verfügbar. Sie können auf den Cluster zugreifen, aber Sie können keine Apps auf dem Cluster bereitstellen.</td>
      </tr>
      <tr>
        <td>Normal</td>
        <td>Alle Workerknoten in einem Cluster sind betriebsbereit. Sie können auf den Cluster zugreifen und Apps auf dem Cluster bereitstellen.</td>
     </tr>
     <tr>
        <td>Warning (Warnung)</td>
        <td>Mindestens ein Workerknoten in dem Cluster ist nicht verfügbar, aber andere Workerknoten sind verfügbar und können die Workload übernehmen.</td>
     </tr>
     <tr>
      <td>Critical (Kritisch)</td>
      <td>Der Kubernetes-Master kann nicht erreicht werden oder alle Workerknoten in dem Cluster sind inaktiv.</td>
     </tr>
    </tbody>
  </table>

3.  Wenn Ihr Cluster den Status **Warning** oder **Critical** hat oder sich seit längerer Zeit im Status **Pending** befindet, überprüfen Sie den Status Ihrer Workerknoten. Wenn Ihr Cluster den Status **Deploying** hat, warten Sie, bis Ihr Cluster vollständig bereitgestellt wurde, und überprüfen Sie dann den Status Ihres Clusters. Für Cluster mit dem Status **Normal** wird angenommen, dass sie sich in einem in einwandfreiem Zustand befinden und dass derzeit keine Aktion für sie ausgeführt werden muss.

  ```
  bx cs workers <clustername_oder_id>
  ```
  {: pre}

  <table summary="Jede Tabellenzeile sollte von links nach rechts gelesen werden, wobei der Clusterstatus in der ersten Spalte und eine Beschreibung in der zweiten Spalte angegeben ist.">
    <thead>
    <th>Status des Workerknotens</th>
    <th>Beschreibung</th>
    </thead>
    <tbody>
      <tr>
       <td>Unknown (Unbekannt)</td>
       <td>Der Kubernetes-Master ist aus einem der folgenden Gründe nicht erreichbar:<ul><li>Sie haben ein Update Ihres Kubernetes-Masters angefordert. Der Status des Workerknotens kann während des Updates nicht abgerufen werden.</li><li>Sie haben möglicherweise eine zusätzliche Firewall, die Ihre Workerknoten schützt, oder Sie haben die Firewalleinstellungen kürzlich geändert. {{site.data.keyword.containershort_notm}} erfordert, dass bestimmte IP-Adressen und Ports geöffnet sind, damit die Kommunikation vom Workerknoten zum Kubernetes-Master und umgekehrt möglich ist. Weitere Informationen finden Sie unter [Workerknoten hängen in einer Neuladen-Schleife](#cs_firewall).</li><li>Der Kubernetes-Master ist inaktiv. Wenden Sie sich an den {{site.data.keyword.Bluemix_notm}}-Support, indem Sie ein [{{site.data.keyword.Bluemix_notm}}-Support-Ticket](/docs/support/index.html#contacting-support) öffnen.</li></ul></td>
      </tr>
      <tr>
        <td>Provisioning (Wird bereitgestellt)</td>
        <td>Ihr Workerknoten wird gerade eingerichtet und ist noch nicht im Cluster verfügbar. Sie können den Bereitstellungsprozess in der Spalte **Status** Ihrer CLI-Ausgabe überwachen. Falls sich Ihr Workerknoten eine längere Zeit in diesem Status befindet und Sie in der Spalte **Status** keinen Fortschritt erkennen können, fahren Sie mit dem nächsten Schritt fort, um zu sehen, ob während der Bereitstellung ein Problem aufgetreten ist.</td>
      </tr>
      <tr>
        <td>Provision_failed (Bereitstellung fehlgeschlagen)</td>
        <td>Ihr Workerknoten konnte nicht bereitgestellt werden. Fahren Sie mit dem nächsten Schritt fort, um die Details des Fehlers abzurufen.</td>
      </tr>
      <tr>
        <td>Reloading (Wird neu geladen)</td>
        <td>Ihr Workerknoten wird neu geladen und ist nicht im Cluster verfügbar. Sie können den Neuladeprozess in der Spalte **Status** Ihrer CLI-Ausgabe überwachen. Falls sich Ihr Workerknoten eine längere Zeit in diesem Status befindet und Sie in der Spalte **Status** keinen Fortschritt erkennen können, fahren Sie mit dem nächsten Schritt fort, um zu sehen, ob während des Neuladens ein Problem aufgetreten ist.</td>
       </tr>
       <tr>
        <td>Reloading_failed (Neuladen fehlgeschlagen)</td>
        <td>Ihr Workerknoten konnte nicht neu geladen werden. Fahren Sie mit dem nächsten Schritt fort, um die Details des Fehlers abzurufen.</td>
      </tr>
      <tr>
        <td>Normal</td>
        <td>Ihr Workerknoten wurde vollständig bereitgestellt und kann im Cluster verwendet werden.</td>
     </tr>
     <tr>
        <td>Warning (Warnung)</td>
        <td>Ihr Workerknoten nähert sich dem Grenzwert für die Speicher- oder Plattenkapazität.</td>
     </tr>
     <tr>
      <td>Critical (Kritisch)</td>
      <td>Die Plattenkapazität Ihres Workerknotens ist erschöpft.</td>
     </tr>
    </tbody>
  </table>

4.  Listen Sie die Details für den Workerknoten auf.

  ```
  bx cs worker-get <workerknoten-id>
  ```
  {: pre}

5.  Überprüfen Sie gängige Fehlernachrichten und lernen Sie, diese zu beheben.

  <table>
    <thead>
    <th>Fehlernachricht</th>
    <th>Beschreibung und Problemlösung
    </thead>
    <tbody>
      <tr>
        <td>{{site.data.keyword.Bluemix_notm}} Infrastructure Exception: Your account is currently prohibited from ordering 'Computing Instances'.</td>
        <td>Mit Ihrem Konto von IBM Bluemix Infrastructure (SoftLayer) können Sie möglicherweise keine Rechenressourcen bestellen. Wenden Sie sich an den {{site.data.keyword.Bluemix_notm}}-Support, indem Sie ein [{{site.data.keyword.Bluemix_notm}}-Support-Ticket](/docs/support/index.html#contacting-support) öffnen.</td>
      </tr>
      <tr>
        <td>{{site.data.keyword.Bluemix_notm}} Infrastructure Exception: Could not place order. There are insufficient resources behind router 'routername' to fulfill the request for the following guests: 'worker-id'.</td>
        <td>Das ausgewählte VLAN ist einem Pod im Rechenzentrum zugeordnet, der nicht über ausreichend Speicherplatz zum Bereitstellen Ihres Workerknotens verfügt. Sie können zwischen den folgenden Optionen wählen:<ul><li>Stellen Sie Ihren Workerknoten in einem anderen Rechenzentrum bereit. Führen Sie <code>bx cs locations</code> aus, um verfügbare Rechenzentren aufzulisten.<li>Wenn Sie ein vorhandenes Paar aus öffentlichem und privatem VLAN haben, das einem anderen Pod in dem Rechenzentrum zugeordnet ist, verwenden Sie dieses VLAN stattdessen.<li>Wenden Sie sich an den {{site.data.keyword.Bluemix_notm}}-Support, indem Sie ein [{{site.data.keyword.Bluemix_notm}}-Support-Ticket](/docs/support/index.html#contacting-support) öffnen.</ul></td>
      </tr>
      <tr>
        <td>{{site.data.keyword.Bluemix_notm}} Infrastructure Exception: Could not obtain network VLAN with id: &lt;vlan-id&gt;.</td>
        <td>Ihr Workerknoten konnte nicht bereitgestellt werden, weil die ausgewählte VLAN-ID aus einem der folgenden Gründe nicht gefunden werden konnte:<ul><li>Möglicherweise haben Sie statt der VLAN-ID die VLAN-Nummer angegeben. Die VLAN-Nummer umfasst 3 oder 4 Ziffern, während die VLAN-ID 7 Stellen hat. Führen Sie <code>bx cs vlans &lt;standort&gt;</code> aus, um die VLAN-ID abzurufen.<li>Möglicherweise ist die VLAN-ID nicht dem von Ihnen verwendeten Konto von IBM Bluemix Infrastructure (SoftLayer) zugeordnet. Führen Sie <code>bx cs vlans &lt;standort&gt;</code> aus, um verfügbare VLAN-IDs für Ihr Konto aufzulisten. Um das Konto von IBM Bluemix Infrastructure (SoftLayer) zu ändern, sollten Sie die Informationen unter [bx cs credentials-set](cs_cli_reference.html#cs_credentials_set) nachlesen. </ul></td>
      </tr>
      <tr>
        <td>SoftLayer_Exception_Order_InvalidLocation: The location provided for this order is invalid. (HTTP 500)</td>
        <td>Ihr System von IBM Bluemix Infrastructure (SoftLayer) ist nicht für das Bestellen von Rechenressourcen im ausgewählten Rechenzentrum eingerichtet. Wenden Sie sich an den [{{site.data.keyword.Bluemix_notm}}-Support](/docs/support/index.html#contacting-support), um sicherzustellen, dass Ihr Konto korrekt eingerichtet ist.</td>
       </tr>
       <tr>
        <td>{{site.data.keyword.Bluemix_notm}} Infrastructure Exception: The user does not have the necessary {{site.data.keyword.Bluemix_notm}} Infrastructure permissions to add servers

        </br></br>
        {{site.data.keyword.Bluemix_notm}} Infrastructure Exception: 'Item' must be ordered with permission.</td>
        <td>Möglicherweise verfügen Sie nicht über die erforderlichen Berechtigungen, um einen Workerknoten aus dem Portfolio von IBM Bluemix Infrastructure (SoftLayer) bereitzustellen. Weitere Informationen finden Sie unter [Zugriff auf das Portfolio von IBM Bluemix Infrastructure (SoftLayer) konfigurieren, um Kubernetes-Standardcluster zu erstellen](cs_planning.html#cs_planning_unify_accounts).</td>
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


## Lokale Client- und Serverversionen von kubectl ermitteln

Führen Sie den folgenden Befehl aus und überprüfen Sie die Version, um festzustellen, welche Version der Kubernetes-Befehlszeilenschnittstelle lokal oder in Ihrem Cluster ausgeführt wird.

```
kubectl version  --short
```
{: pre}

Beispielausgabe:

```
Client Version: v1.5.6
        Server Version: v1.5.6
```
{: screen}

<br />


## Verbindung mit Ihrem Konto von IBM Bluemix Infrastructure (SoftLayer) während der Erstellung eines Clusters nicht möglich
{: #cs_credentials}

{: tsSymptoms}
Wenn Sie einen neuen Kubernetes-Cluster erstellen, wird die folgende Nachricht angezeigt.

```
Es konnte keine Verbindung zu Ihrem Konto von IBM Bluemix Infrastructure (SoftLayer) hergestellt werden. Zur Erstellung eines Standardclusters ist es erforderlich, dass Sie entweder über ein nutzungsabhängiges Konto mit einer Verbindung zum Konto von IBM Bluemix Infrastructure (SoftLayer) verfügen oder dass Sie die {{site.data.keyword.Bluemix_notm}} Container Service-CLI zum Einrichten der API-Schlüssel für {{site.data.keyword.Bluemix_notm}} Infrastructure verwendet haben.
```
{: screen}

{: tsCauses}
Benutzer mit einem {{site.data.keyword.Bluemix_notm}}-Konto ohne Verbindung müssen ein neues nutzungsabhängiges Konto erstellen oder die API-Schlüssel von IBM Bluemix Infrastructure (SoftLayer) manuell über die {{site.data.keyword.Bluemix_notm}}-CLI hinzufügen.

{: tsResolve}
Gehen Sie wie folgt vor, um Berechtigungsnachweise für Ihr {{site.data.keyword.Bluemix_notm}}-Konto hinzuzufügen.

1.  Wenden Sie sich an den Administrator von IBM Bluemix Infrastructure (SoftLayer), um den Benutzernamen und den API-Schlüssel für IBM Bluemix Infrastructure (SoftLayer) zu erhalten.

    **Hinweis:** Das Konto von IBM Bluemix Infrastructure (SoftLayer), das Sie verwenden, muss mit SuperUser-Berechtigungen eingerichtet werden, damit Standardcluster erfolgreich erstellt werden können.

2.  Fügen Sie die Berechtigungsnachweise hinzu.

  ```
  bx cs credentials-set --infrastructure-username <benutzername> --infrastructure-api-key <api-schlüssel>
  ```
  {: pre}

3.  Erstellen Sie einen Standardcluster.

  ```
  bx cs cluster-create --location dal10 --public-vlan meine_id_des_öffentlichen_vlan --private-vlan meine_id_des_privaten_vlan --machine-type u1c.2x4 --name mein_cluster --hardware shared --workers 2
  ```
  {: pre}

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


## Pods verweilen in  im Status 'Pending' (Anstehend)
{: #cs_pods_pending}

{: tsSymptoms}
Beim Ausführen von `kubectl get pods` verbleiben Pods weiterhin im Status **Pending** (Anstehend).

{: tsCauses}
Wenn Sie den Kubernetes-Cluster gerade erst erstellt haben, werden die Workerknoten möglicherweise noch konfiguriert. Falls dieser Cluster bereits vorhanden ist, steht unter Umständen nicht ausreichend Kapazität für die Bereitstellung des Pods in Ihrem Cluster zur Verfügung.

{: tsResolve}
Für diese Task ist die [Zugriffsrichtlinie 'Administrator'](cs_cluster.html#access_ov) erforderlich. Überprüfen Sie Ihre aktuelle [Zugriffsrichtlinie](cs_cluster.html#view_access).

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
  bx cs worker-add <clustername_oder_id> 1
  ```
  {: pre}

5.  Falls Ihre Pods auch weiterhin im Status **Pending** (Anstehend) verweilen, obwohl der Workerknoten voll bereitgestellt wurde, ziehen Sie die [Kubernetes-Dokumentation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tasks/debug-application-cluster/debug-pod-replication-controller/#my-pod-stays-pending) zurate, um die Ursache für den andauernden Status 'Pending' Ihres Pods zu ermitteln und den Fehler zu beheben.

<br />


## Pods sind im Erstellungszustand blockiert
{: #stuck_creating_state}

{: tsSymptoms}
Wenn Sie den Befehl `kubectl get pods -o wide` ausführen, dann können Sie erkennen, dass mehrere Pods, die auf demselben Workerknoten ausgeführt werden, im Zustand `ContainerCreating` blockiert sind.

{: tsCauses}
Das Dateisystem auf dem Workerknoten ist schreibgeschützt.

{: tsResolve}
1. Erstellen Sie eine Sicherungskopie aller Daten, die möglicherweise auf dem Workerknoten oder in Ihren Containern gespeichert werden.
2. Erstellen Sie den Workerknoten neu, indem Sie den folgenden Befehl ausführen.

<pre class="pre"><code>bx cs worker-reload &lt;clustername&gt; &lt;worker-id&gt;</code></pre>

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
  ID                                                 Public IP       Private IP       Machine Type   State     Status
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w1   192.0.2.0.12   203.0.113.144   b1c.4x16       normal    Ready
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w2   192.0.2.0.16   203.0.113.144   b1c.4x16       deleted    -
  ```
  {: screen}

2.  Installieren Sie die [Calico-CLI](cs_security.html#adding_network_policies).
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


## Workerknoten können nicht verbunden werden
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
Möglicherweise wurde eine zusätzliche Firewall eingerichtet oder Sie haben die vorhandenen Firewalleinstellungen für Ihr Konto von IBM Bluemix Infrastructure (SoftLayer) angepasst. {{site.data.keyword.containershort_notm}} erfordert, dass bestimmte IP-Adressen und Ports geöffnet sind, damit die Kommunikation vom Workerknoten zum Kubernetes-Master und umgekehrt möglich ist. Ein weiterer möglicher Grund kann sein, dass Ihre Workerknoten in einer Neuladen-Schleife hängen.

{: tsResolve}
Für diese Task ist die [Zugriffsrichtlinie 'Administrator'](cs_cluster.html#access_ov) erforderlich. Überprüfen Sie Ihre aktuelle [Zugriffsrichtlinie](cs_cluster.html#view_access).

Öffnen Sie in Ihrer angepassten Firewall die folgenden Ports und IP-Adressen.

1.  Notieren Sie die öffentlichen IP-Adressen für alle Workerknoten im Cluster:

  ```
  bx cs workers '<clustername_oder_id>'
  ```
  {: pre}

2.  In Ihrer Firewall für die OUTBOUND-Konnektivität Ihrer Workerknoten müssen Sie den ausgehenden Netzverkehr vom Quellen-Workerknoten zum TCP/UDP-Zielportbereich 20000 - 32767 und zum Port 443 für `<each_worker_node_publicIP>` und außerdem für die folgenden IP-Adressen und Netzgruppen zulassen.
    - **Wichtig**: Sie müssen den ausgehenden Datenverkehr am Port 443 und von allen Standorten in der Region zu den jeweils anderen Standorten zulassen, um die Arbeitslast während des Bootstrap-Prozesses auszugleichen. Wenn Ihr Cluster sich beispielsweise in der Region 'Vereinigte Staaten (Süden)' befindet, dann müssen Sie Datenverkehr über den Port 443 an 'dal10' und 'dal12' sowie von 'dal10' und 'dal12' zu dem jeweils anderen Standort zulassen.
      <p>
  <table summary="Die erste Zeile in der Tabelle erstreckt sich über beide Spalten. Der Rest der Zeilen sollte von links nach rechts gelesen werden, wobei die Serverposition in der ersten Spalte und die passenden IP-Adressen in der zweiten Spalte angegeben sind.">
      <thead>
      <th>Region</th>
      <th>Standort</th>
      <th>IP-Adresse</th>
      </thead>
    <tbody>
      <tr>
         <td>Asien-Pazifik (Süden)</td>
         <td>mel01<br>syd01</td>
         <td><code>168.1.97.67</code><br><code>168.1.8.195</code></td>
      </tr>
      <tr>
         <td>Zentraleuropa</td>
         <td>ams03<br>fra02</td>
         <td><code>169.50.169.110</code><br><code>169.50.56.174</code></td>
        </tr>
      <tr>
        <td>Großbritannien (Süden)</td>
        <td>lon02<br>lon04</td>
        <td><code>159.122.242.78</code><br><code>158.175.65.170</code></td>
      </tr>
      <tr>
        <td>Vereinigte Staaten (Osten)</td>
         <td>wdc06<br>wdc07</td>
         <td><code>169.60.73.142</code><br><code>169.61.83.62</code></td>
      </tr>
      <tr>
        <td>Vereinigte Staaten (Süden)</td>
        <td>dal10<br>dal12<br>dal13</td>
        <td><code>169.46.7.238</code><br><code>169.47.70.10</code><br><code>169.60.128.2</code></td>
      </tr>
      </tbody>
    </table>
</p>

3.  Erlauben Sie den ausgehenden Netzverkehr von den Workerknoten an {{site.data.keyword.registrylong_notm}}:
    - `TCP port 443 FROM <each_worker_node_publicIP> TO <registry_publicIP>`
    - Ersetzen Sie <em>&lt;registry_publicIP&gt;</em> durch alle Adressen für Registry-Regionen, an die der Datenverkehr als zulässig definiert werden soll:
        <p>      
<table summary="Die erste Zeile in der Tabelle erstreckt sich über beide Spalten. Der Rest der Zeilen sollte von links nach rechts gelesen werden, wobei die Serverposition in der ersten Spalte und die passenden IP-Adressen in der zweiten Spalte angegeben sind.">
        <thead>
        <th colspan=2><img src="images/idea.png"/> Registry-IP-Adressen</th>
        </thead>
      <tbody>
        <tr>
          <td>registry.au-syd.bluemix.net</td>
          <td><code>168.1.45.160/27</code></br><code>168.1.139.32/27</code></td>
        </tr>
        <tr>
          <td>registry.eu-de.bluemix.net</td>
          <td><code>169.50.56.144/28</code></br><code>159.8.73.80/28</code></td>
         </tr>
         <tr>
          <td>registry.eu-gb.bluemix.net</td>
          <td><code>159.8.188.160/27</code></br><code>169.50.153.64/27</code></td>
         </tr>
         <tr>
          <td>registry.ng.bluemix.net</td>
          <td><code>169.55.39.112/28</code></br><code>169.46.9.0/27</code></br><code>169.55.211.0/27</code></td>
         </tr>
        </tbody>
      </table>
</p>

4.  Optional: Erlauben Sie den ausgehenden Netzverkehr von den Workerknoten an {{site.data.keyword.monitoringlong_notm}} und die {{site.data.keyword.loganalysislong_notm}}-Services:
    - `TCP port 443, port 9095 FROM <each_worker_node_publicIP> TO <monitoring_publicIP>`
    - Ersetzen Sie <em>&lt;monitoring_publicIP&gt;</em> durch alle Adressen für die Überwachungsregionen, an die der Datenverkehr als zulässig definiert werden soll:
        <p><table summary="Die erste Zeile in der Tabelle erstreckt sich über beide Spalten. Der Rest der Zeilen sollte von links nach rechts gelesen werden, wobei die Serverposition in der ersten Spalte und die passenden IP-Adressen in der zweiten Spalte angegeben sind.">
        <thead>
        <th colspan=2><img src="images/idea.png"/> Überwachen öffentlicher IP-Adressen</th>
        </thead>
      <tbody>
        <tr>
         <td>metrics.eu-de.bluemix.net</td>
         <td><code>159.122.78.136/29</code></td>
        </tr>
        <tr>
         <td>metrics.eu-gb.bluemix.net</td>
         <td><code>169.50.196.136/29</code></td>
        </tr>
        <tr>
          <td>metrics.ng.bluemix.net</td>
          <td><code>169.47.204.128/29</code></td>
         </tr>
         
        </tbody>
      </table>
</p>
    - `TCP port 443, port 9091 FROM <each_worker_node_publicIP> TO <logging_publicIP>`
    - Ersetzen Sie <em>&lt;logging_publicIP&gt;</em> durch alle Adressen für die Protokollierungsregionen, an die der Datenverkehr als zulässig definiert werden soll:
        <p><table summary="Die erste Zeile in der Tabelle erstreckt sich über beide Spalten. Der Rest der Zeilen sollte von links nach rechts gelesen werden, wobei die Serverposition in der ersten Spalte und die passenden IP-Adressen in der zweiten Spalte angegeben sind.">
        <thead>
        <th colspan=2><img src="images/idea.png"/> Protokollieren öffentlicher IP-Adressen</th>
        </thead>
      <tbody>
        <tr>
         <td>ingest.logging.eu-de.bluemix.net</td>
         <td><code>169.50.25.125</code></td>
        </tr>
        <tr>
         <td>ingest.logging.eu-gb.bluemix.net</td>
         <td><code>169.50.115.113</code></td>
        </tr>
        <tr>
          <td>ingest.logging.ng.bluemix.net</td>
          <td><code>169.48.79.236</code><br><code>169.46.186.113</code></td>
         </tr>
        </tbody>
      </table>
</p>

5. Wenn Sie über eine private Firewall verfügen, müssen Sie die entsprechenden Bereiche privater IPs für IBM Bluemix Infrastructure (SoftLayer) zulassen. Weitere Informationen finden Sie unter [diesem Link](https://knowledgelayer.softlayer.com/faq/what-ip-ranges-do-i-allow-through-firewall) ausgehend vom Abschnitt **Back-End-Netz (Privat)**.
    - Fügen Sie alle [Standorte in den Regionen](cs_regions.html#locations) hinzu, die von Ihnen verwendet werden.
    - Beachten Sie, dass Sie den Standort 'dal01' (Rechenzentrum) hinzufügen müssen.
    - Öffnen Sie die Ports 80 und 443, um die Durchführung des Cluster-Bootstrap-Prozesses zu erlauben.

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


## Verbindung mit einer App über Ingress schlägt fehl
{: #cs_ingress_fails}

{: tsSymptoms}
Sie haben Ihre App öffentlich zugänglich gemacht, indem Sie eine Ingress-Ressource für Ihre App in Ihrem Cluster erstellt haben. Als Sie versuchten, eine Verbindung mit Ihrer App über die öffentliche IP-Adresse oder eine Unterdomäne des Ingress-Controllers herzustellen, ist die Verbindung fehlgeschlagen oder sie hat das zulässige Zeitlimit überschritten.

{: tsCauses}
Ingress funktioniert aus den folgenden Gründen möglicherweise nicht ordnungsgemäß:
<ul><ul>
<li>Der Cluster ist nocht nicht vollständig bereitgestellt.
<li>Der Cluster wurde als Lite-Cluster oder als Standardcluster mit nur einem Workerknoten eingerichtet.
<li>Das Ingress-Konfigurationsscript enthält Fehler.
</ul></ul>

{: tsResolve}
Gehen Sie wie folgt vor, um Fehler in Ingress zu beheben:

1.  Prüfen Sie, dass Sie einen Standardcluster einrichten, der vollständig bereitgestellt ist und mindestens zwei Workerknoten umfasst, um Hochverfügbarkeit für Ihren Ingress-Controller zu gewährleisten.

  ```
  bx cs workers <clustername_oder_id>
  ```
  {: pre}

    Stellen Sie in Ihrer CLI-Ausgabe sicher, dass der **Status** Ihrer Workerknoten **Ready** (Bereit) lautet und dass für den **Maschinentyp** etwas anderes als **free** (frei) anzeigt wird.

2.  Rufen Sie die Unterdomäne und die öffentliche IP-Adresse des Ingress-Controllers ab und setzen Sie dann ein Pingsignal an beide ab.

    1.  Rufen Sie die Unterdomäne des Ingress-Controllers ab.

      ```
      bx cs cluster-get <clustername_oder_id> | grep "Ingress subdomain"
      ```
      {: pre}

    2.  Setzen Sie in Pingsignal an die Unterdomäne des Ingress-Controllers ab.

      ```
      ping <unterdomäne_des_ingress-controllers>
      ```
      {: pre}

    3.  Rufen Sie die öffentliche IP-Adresse Ihres Ingress-Controllers ab.

      ```
      nslookup <unterdomäne_des_ingress-controllers>
      ```
      {: pre}

    4.  Setzen Sie ein Pingsignal an die öffentliche IP-Adresse des Ingress-Controllers ab.

      ```
      ping <ip_des_ingress-controllers>
      ```
      {: pre}

    Falls die CLI eine Zeitlimitüberschreitung für die öffentliche IP-Adresse oder die Unterdomäne des Ingress-Controllers zurückgibt und Sie eine angepasste Firewall eingerichtet haben, die Ihre Workerknoten schützt, müssen Sie unter Umständen zusätzliche Ports und Netzgruppen in Ihrer [Firewall](#cs_firewall) öffnen.

3.  Wenn Sie eine angepasste Domäne verwenden, stellen Sie sicher, dass Ihre angepasste Domäne der öffentlichen IP-Adresse oder Unterdomäne des von IBM bereitgestellten Ingress-Controllers mit Ihrem DNS-Anbieter (Domain Name Service) zugeordnet ist.
    1.  Wenn Sie die Unterdomäne des Ingress-Controllers verwendet haben, prüfen Sie Ihren CNAME-Datensatz (Canonical Name, kanonischer Name).
    2.  Wenn Sie die öffentliche IP-Adresse des Ingress-Controllers verwendet haben, prüfen Sie, dass Ihre angepasste Domäne der portierbaren öffentlichen IP-Adresse im Zeigerdatensatz (PTR) zugeordnet ist.
4.  Prüfen Sie Ihre Ingress-Konfigurationsdatei.

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

    1.  Prüfen Sie, dass die Unterdomäne des Ingress-Controllers und das TLS-Zertifikat korrekt sind. Sie finden die von IBM bereitgestellte Unterdomäne und das TLS-Zertifikat, indem Sie 'bx cs cluster-get <clustername_oder_id>' ausführen.
    2.  Stellen Sie sicher, dass Ihre App denselben Pfad überwacht, der im Abschnitt **path** von Ingress konfiguriert ist. Wenn Ihre App so eingerichtet ist, dass sie den Rootpfad überwacht, schließen Sie **/** als Ihren Pfad ein.
5.  Prüfen Sie Ihre Ingress-Bereitstellung und suchen Sie nach potenziellen Fehlernachrichten.

  ```
  kubectl describe ingress <myingress>
  ```
  {: pre}

6.  Prüfen Sie die Protokolle für Ihren Ingress-Controller.
    1.  Rufen Sie die ID der Ingress-Pods ab, die in Ihrem Cluster ausgeführt werden.

      ```
      kubectl get pods -n kube-system |grep ingress
      ```
      {: pre}

    2.  Rufen Sie die Protokolle für jeden Ingress-Pod ab.

      ```
      kubectl logs <ingress-pod-id> -n kube-system
      ```
      {: pre}

    3.  Suchen Sie nach Fehlernachrichten in den Ingress-Controllerprotokollen.

<br />


## Verbindung mit einer App über einen Lastausgleichsservice schlägt fehl
{: #cs_loadbalancer_fails}

{: tsSymptoms}
Sie haben Ihre App öffentlich zugänglich gemacht, indem Sie einen Lastausgleichsservice in Ihrem Cluster erstellt haben. Als Sie versuchten, eine Verbindung mit Ihrer App über die öffentliche IP-Adresse der Lastausgleichsfunktion herzustellen, ist die Verbindung fehlgeschlagen oder sie hat das zulässige Zeitlimit überschritten.

{: tsCauses}
Ihr Lastausgleichsservice funktioniert aus einem der folgenden Gründe möglicherweise nicht ordnungsgemäß:

-   Der Cluster ist ein Lite-Cluster oder Standardcluster mit nur einem Workerknoten.
-   Der Cluster ist nocht nicht vollständig bereitgestellt.
-   Das Konfigurationsscript für Ihren Lastausgleichsservice enthält Fehler.

{: tsResolve}
Gehen Sie wie folgt vor, um Fehler in Ihrem Lastausgleichsservice zu beheben:

1.  Prüfen Sie, dass Sie einen Standardcluster einrichten, der vollständig bereitgestellt ist und mindestens zwei Workerknoten umfasst, um Hochverfügbarkeit für Ihren Lastausgleichsservice zu gewährleisten.

  ```
  bx cs workers <clustername_oder_id>
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
    <ul><ul><li><pre class="screen"><code>Clusters with one node must use services of type NodePort</code></pre></br>Um den Lastausgleichsservice verwenden zu können, müssen Sie über ein Standardcluster mit mindestens zwei Workerknoten verfügen.
    <li><pre class="screen"><code>No cloud provider IPs are available to fulfill the load balancer service request. Add a portable subnet to the cluster and try again</code></pre></br>Diese Fehlernachricht weist darauf hin, dass keine portierbaren öffentlichen IP-Adressen mehr verfügbar sind, die Ihrem Lastausgleichsservice zugeordnet werden können. Informationen zum Anfordern portierbarer IP-Adressen für Ihren Cluster finden Sie unter [Clustern Teilnetze hinzufügen](cs_cluster.html#cs_cluster_subnet). Nachdem portierbare öffentliche IP-Adressen im Cluster verfügbar gemacht wurden, wird der Lastausgleichsservice automatisch erstellt.
    <li><pre class="screen"><code>Requested cloud provider IP <cloud-provider-ip> is not available. The following cloud provider IPs are available: <available-cloud-provider-ips</code></pre></br>Sie haben eine portierbare öffentliche IP-Adresse für Ihren Lastausgleichsservice mithilfe des Abschnitts **loadBalancerIP** definiert, aber diese portierbare öffentliche IP-Adresse ist in Ihrem portierbaren öffentlichen Teilnetz nicht verfügbar. Ändern Sie das Konfigurationsscript Ihres Lastausgleichsservice und wählen Sie entweder eine der portierbaren öffentlichen IP-Adressen aus, oder entfernen Sie den Abschnitt **loadBalancerIP** aus Ihrem Script, damit eine verfügbare portierbare öffentliche IP-Adresse automatisch zugeordnet werden kann.
    <li><pre class="screen"><code>No available nodes for load balancer services</code></pre>Sie verfügen nicht über ausreichend Workerknoten, um einen Lastausgleichsservice bereitzustellen. Ein Grund kann sein, dass Sie einen Standardcluster mit mehr ale einem Workerknoten bereitgestellt haben, aber die Bereitstellung der Workerknoten ist fehlgeschlagen.
    <ol><li>Listen Sie verfügbare Workerknoten auf.</br><pre class="codeblock"><code>kubectl get nodes</code></pre>
    <li>Werden mindestens zwei verfügbare Workerknoten gefunden, listen Sie die Details der Workerknoten auf.</br><pre class="screen"><code>bx cs worker-get <worker-id></code></pre>
    <li>Stellen Sie sicher, dass die öffentlichen und privaten VLAN-IDs für die Workerknoten, die von den Befehlen 'kubectl get nodes' und 'bx cs worker-get' zurückgegeben wurden, übereinstimmen.</ol></ul></ul>

4.  Wenn Sie eine angepasste Domäne verwenden, um Ihren Lastausgleichsservice zu verbinden, stellen Sie sicher, dass Ihre angepasste Domäne der öffentlichen IP-Adresse Ihres Lastausgleichsservice zugeordnet ist.
    1.  Suchen Sie nach der öffentlichen IP-Adresse Ihres Lastausgleichsservice.

      ```
      kubectl describe service <mein_service> | grep "LoadBalancer Ingress"
      ```
      {: pre}

    2.  Prüfen Sie, dass Ihre angepasste Domäne der portierbaren öffentlichen IP-Adresse Ihres Lastausgleichsservice im Zeigerdatensatz (PTR) zugeordnet ist.

<br />


## Abrufen der ETCD-URL für die Konfiguration der Calico-CLI ist fehlgeschlagen
{: #cs_calico_fails}

{: tsSymptoms}
Wenn Sie den Wert für `<ETCD_URL>` abrufen, um [Netzrichtlinien hinzuzufügen](cs_security.html#adding_network_policies), dann gibt das System die Fehlernachricht `calico-config nicht gefunden` aus.

{: tsCauses}
Ihr Cluster hat nicht (Kubernetes Version 1.7)[cs_versions.html] oder höher.

{: tsResolve}
(Aktualisieren Sie den Cluster)[cs_cluster.html#cs_cluster_update] oder rufen Sie den Wert für `<ETCD_URL>` mit Befehlen ab, die mit älteren Versionen von Kubernetes kompatibel sind.

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

Wenn Sie den Wert für `<ETCD_URL>` abrufen, dann fahren Sie mit den Schritten fort, die unter (Netzrichtlinien hinzufügen)[cs_security.html#adding_network_policies] aufgeführt sind.

<br />


## Bekannte Probleme
{: #cs_known_issues}

Erfahren Sie mehr über bekannte Probleme.
{: shortdesc}

### Cluster
{: #ki_clusters}

<dl>
  <dt>Cloud Foundry-Apps in demselben {{site.data.keyword.Bluemix_notm}}-Bereich können nicht auf ein Cluster zugreifen</dt>
    <dd>Wenn Sie einen Kubernetes-Cluster erstellen, wird der Cluster auf Kontoebene erstellt und verwendet den Bereich nicht, es sei denn, Sie binden {{site.data.keyword.Bluemix_notm}}-Services. Wenn Sie über eine Cloud Foundry-App
verfügen, auf die der Cluster zugreifen soll, müssen Sie entweder die Cloud Foundry-App öffentlich zugänglich machen oder Sie müssen Ihre App in Ihrem Cluster [öffentlich zugänglich machen](cs_planning.html#cs_planning_public_network).</dd>
  <dt>Service 'NodePort' im Kube-Dashboard wurde inaktiviert</dt>
    <dd>Aus Sicherheitsgründen ist der Service 'NodePort' im Kubernetes-Dashboard inaktiviert. Führen Sie folgenden Befehl aus, um auf Ihr Kubernetes-Dashboard zuzugreifen:</br><pre class="codeblock"><code>kubectl proxy</code></pre></br>Anschließend können Sie auf das Kubernetes-Dashboard unter `http://localhost:8001/ui` zugreifen.</dd>
  <dt>Einschränkungen beim Servicetyp für die Lastausgleichsfunktion (Load Balancer)</dt>
    <dd><ul><li>Die Verwendung des Lastausgleichs für private LANs ist nicht möglich.<li>Es können keine Serviceannotationen für 'service.beta.kubernetes.io/external-traffic' und
'service.beta.kubernetes.io/healthcheck-nodeport' verwenden. Weitere Informationen zu diesen Annotationen enthält die
[Kubernetes-Dokumentation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tutorials/services/source-ip/).</ul></dd>
  <dt>Horizontale Autoskalierung funktioniert in bestimmten Clustern nicht</dt>
    <dd>Aus Sicherheitsgründen wird der Standardport, der von Heapster (10255) verwendet wird, in allen Workerknoten in alten Clustern geschlossen. Da dieser Port geschlossen ist, ist Heapster nicht in der Lage, Metriken für Workerknoten zu melden, und das horizontale automatische Skalieren funktioniert nicht wie im Abschnitt zum [automatischen horizontalen Skalieren von Pods ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/) in der Kubernetes-Dokumentation dokumentiert. Erstellen Sie einen weiteren Cluster, um das Auftreten dieses Problems zu vermeiden.</dd>
</dl>

### Persistenter Speicher
{: #persistent_storage}

Der Befehl `kubectl describe <pvc_name>` zeigt **ProvisioningFailed** für einen Persistent Volume Claim (PVC) an:
<ul><ul>
<li>Wenn Sie einen Persistent Volume Claim (PVC) erstellen, ist kein Persistent Volume (PV) verfügbar. Daher gibt Kubernetes die Nachricht **ProvisioningFailed** zurück.
<li>Nachdem ein Persistent Volume erstellt und an den Claim gebunden worden ist, gibt Kubernetes die Nachricht **ProvisioningSucceeded** zurück. Dieser Prozess kann einige Minuten dauern.
</ul></ul>

## Hilfe und Unterstützung anfordern
{: #ts_getting_help}

Erste Schritte bei der Fehlerbehebung für einen Container

-   [Überprüfen Sie auf der {{site.data.keyword.Bluemix_notm}}-Statusseite ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://developer.ibm.com/bluemix/support/#status), ob {{site.data.keyword.Bluemix_notm}} verfügbar ist.
-   Veröffentlichen Sie eine Frage im [{{site.data.keyword.containershort_notm}}-Slack. ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://ibm-container-service.slack.com) Wenn Sie keine IBM ID für Ihr {{site.data.keyword.Bluemix_notm}}-Konto verwenden, wenden Sie sich an [crosen@us.ibm.com](mailto:crosen@us.ibm.com) und fordern Sie eine Einladung zu diesem Slack an.
-   Suchen Sie in entsprechenden Foren, ob andere Benutzer auf das gleiche Problem
gestoßen sind. Versehen Sie Ihre Fragen in den Foren mit Tags, um sie für das Entwicklungsteam
von {{site.data.keyword.Bluemix_notm}} erkennbar zu machen.

    -   Posten Sie technische Fragen zur Entwicklung oder Bereitstellung von Clustern oder Apps mit {{site.data.keyword.containershort_notm}} haben, veröffentlichen Sie Ihre Frage auf [Stack Overflow ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link icon")](http://stackoverflow.com/search?q=bluemix+containers) und versehen Sie sie mit den Tags `ibm-bluemix`, `kubernetes` und `containers`.
    -   Verwenden Sie für Fragen zum Service und zu ersten Schritten das Forum [IBM developerWorks dW Answers ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://developer.ibm.com/answers/topics/containers/?smartspace=bluemix). Geben Sie die Tags `bluemix`
und `containers` an.
    Weitere Details zur Verwendung der Foren
finden Sie unter [Hilfe anfordern](/docs/support/index.html#getting-help).

-   Wenden Sie sich an den IBM Support. Informationen zum Öffnen eines IBM
Support-Tickets oder zu Supportstufen und zu Prioritätsstufen von Tickets finden Sie unter
[Support kontaktieren](/docs/support/index.html#contacting-support).
