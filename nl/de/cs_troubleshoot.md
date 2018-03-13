---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-31"

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
      <td>Critical (Kritisch)</td>
      <td>Der Kubernetes-Master kann nicht erreicht werden oder alle Workerknoten in dem Cluster sind inaktiv.</td>
     </tr>
  
      <tr>
        <td>Deploying (Wird bereitgestellt)</td>
        <td>Der Kubernetes-Master ist noch nicht vollständig implementiert. Sie können auf Ihren Cluster nicht zugreifen.</td>
       </tr>
       <tr>
        <td>Normal</td>
        <td>Alle Workerknoten in einem Cluster sind betriebsbereit. Sie können auf den Cluster zugreifen und Apps auf dem Cluster bereitstellen.</td>
     </tr>
       <tr>
        <td>Pending (Anstehend)</td>
        <td>Der Kubernetes-Master ist bereitgestellt. Die Workerknoten werden gerade eingerichtet und sind noch nicht im Cluster verfügbar. Sie können auf den Cluster zugreifen, aber Sie können keine Apps auf dem Cluster bereitstellen.</td>
      </tr>
  
     <tr>
        <td>Warning (Warnung)</td>
        <td>Mindestens ein Workerknoten in dem Cluster ist nicht verfügbar, aber andere Workerknoten sind verfügbar und können die Workload übernehmen.</td>
     </tr>  
    </tbody>
  </table>

3.  Wenn Ihr Cluster den Status **Warning**, **Critical** oder **Delete failed** aufweist oder sich seit längerer Zeit im Status **Pending** befindet, überprüfen Sie den Status Ihrer Workerknoten. Wenn Ihr Cluster den Status **Deploying** hat, warten Sie, bis Ihr Cluster vollständig bereitgestellt wurde, und überprüfen Sie dann den Status Ihres Clusters. Für Cluster mit dem Status **Normal** wird angenommen, dass derzeit keine Aktion für sie ausgeführt werden muss. 
<p>Gehen Sie wie folgt vor, um den Status Ihrer Workerknoten zu prüfen:</p>

  ```
  bx cs workers <clustername_oder_-id>
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
       <td>Der Kubernetes-Master ist aus einem der folgenden Gründe nicht erreichbar:<ul><li>Sie haben ein Update Ihres Kubernetes-Masters angefordert. Der Status des Workerknotens kann während des Updates nicht abgerufen werden.</li><li>Sie haben möglicherweise eine zusätzliche Firewall, die Ihre Workerknoten schützt, oder Sie haben die Firewalleinstellungen kürzlich geändert. {{site.data.keyword.containershort_notm}} erfordert, dass bestimmte IP-Adressen und Ports geöffnet sind, damit die Kommunikation vom Workerknoten zum Kubernetes-Master und umgekehrt möglich ist. Weitere Informationen finden Sie in [Firewall verhindert Verbindung für Workerknoten](#cs_firewall).</li><li>Der Kubernetes-Master ist inaktiv. Wenden Sie sich an den {{site.data.keyword.Bluemix_notm}}-Support, indem Sie ein [{{site.data.keyword.Bluemix_notm}}-Support-Ticket](/docs/get-support/howtogetsupport.html#getting-customer-support) öffnen.</li></ul></td>
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
  bx cs worker-get [<clustername_oder_-id>] <workerknoten-id>
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
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w1   192.0.2.0.12   203.0.113.144   b2c.4x16       normal    Ready
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w2   192.0.2.0.16   203.0.113.144   b2c.4x16       deleted    -
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
 <td>Damit Protokolle gesendet werden, müssen Sie zunächst eine Protokollierungskonfiguration erstellen, um Protokolle an {{site.data.keyword.loganalysislong_notm}} weiterzuleiten. Weitere Informationen zum Erstellen einer Protokollierungskonfiguration finden Sie unter <a href="cs_health.html#log_sources_enable">Protokollweiterleitung aktivieren</a>.</td>
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
    <li>Werden mindestens zwei verfügbare Workerknoten gefunden, listen Sie die Details der Workerknoten auf.</br><pre class="screen"><code>bx cs worker-get [&lt;clustername_oder_-id&gt;] &lt;worker-ID&gt;</code></pre></li>
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

    1.  Rufen Sie die Unterdomäne des Ingress-Controllers ab.

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

    1.  Prüfen Sie, dass die Unterdomäne der Ingress-Lastausgleichsfunktion für Anwendungen und das TLS-Zertifikat korrekt sind. Sie finden die von IBM bereitgestellte Unterdomäne und das TLS-Zertifikat, indem Sie 'bx cs cluster-get <clustername_oder_-id>' ausführen.
    2.  Stellen Sie sicher, dass Ihre App denselben Pfad überwacht, der im Abschnitt **path** von Ingress konfiguriert ist. Wenn Ihre App so eingerichtet ist, dass sie den Rootpfad überwacht, schließen Sie **/** als Ihren Pfad ein.
5.  Prüfen Sie Ihre Ingress-Bereitstellung und suchen Sie nach potenziellen Fehlernachrichten.

  ```
  kubectl describe ingress <myingress>
  ```
  {: pre}

6.  Prüfen Sie die Protokolle für Ihren Ingress-Controller.
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

    3.  Suchen Sie nach Fehlernachrichten in den Ingress-Controllerprotokollen.

<br />



## Probleme mit geheimen Schlüsseln der Ingress-Lastausgleichsfunktion für Anwendungen
{: #cs_albsecret_fails}

{: tsSymptoms}
Nach der Bereitstellung eines geheimen Schlüssels der Ingress-Lastausgleichsfunktion für Anwendungen für Ihren Cluster wird das Beschreibungsfeld `Description` nicht mit dem Namen des geheimen Schlüssels aktualisiert, wenn Sie Ihr Zertifikat in {{site.data.keyword.cloudcerts_full_notm}} anzeigen.

Beim Auflisten von Informationen zum geheimen Schlüssel der Lastausgleichsfunktion für Anwendungen wird der Status `*_failed` angezeigt. Beispiel: `create_failed`, `update_failed` oder `delete_failed`.

{: tsResolve}
Überprüfen Sie die folgenden möglichen Ursachen für ein Fehlschlagen des geheimen Schlüssels der Lastausgleichsfunktion für Anwendungen sowie die entsprechenden Fehlerbehebungsschritte:

<table>
<col width="40%">
<col width="60%">
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
 <td><ol><li>Überprüfen Sie die Richtigkeit der von Ihnen angegebenen Zeichenfolge für die CRN des Zertifikats.</li><li>Wenn die CRN des Zertifikats korrekt angegeben wurde, versuchen Sie, den geheimen Schlüssel zu aktualisieren: <pre class="pre"><code>bx cs alb-cert-deploy --update --cluster &lt;clustername_oder_-id&gt; --secret-name &lt;name_des_geheimen_schlüssels&gt; --cert-crn &lt;CRN_des_zertifikats&gt;</code></pre></li><li>Wenn dieser Befehl den Status <code>update_failed</code> zurückgibt, dann entfernen Sie den geheimen Schlüssel: <pre class="pre"><code>bx cs alb-cert-rm --cluster &lt;clustername_oder_-id&gt; --secret-name &lt;name_des_geheimen_schlüssels&gt;</code></pre></li><li>Stellen Sie den geheimen Schlüssel erneut bereit: <pre class="pre"><code>bx cs alb-cert-deploy --cluster &lt;clustername_oder_-id&gt; --secret-name &lt;name_des_geheimen_schlüssels&gt; --cert-crn &lt;CRN_des_zertifikats&gt;</code></pre></li></ol></td>
 </tr>
 <tr>
 <td>Die zum Zeitpunkt der Aktualisierung angegebene CRN des Zertifikats ist falsch.</td>
 <td><ol><li>Überprüfen Sie die Richtigkeit der von Ihnen angegebenen Zeichenfolge für die CRN des Zertifikats.</li><li>Wenn die CRN des Zertifikats korrekt angegeben wurde, dann entfernen Sie den geheimen Schlüssel: <pre class="pre"><code>bx cs alb-cert-rm --cluster &lt;clustername_oder_-id&gt; --secret-name &lt;name_des_geheimen_schlüssels&gt;</code></pre></li><li>Stellen Sie den geheimen Schlüssel erneut bereit: <pre class="pre"><code>bx cs alb-cert-deploy --cluster &lt;clustername_oder_-id&gt; --secret-name &lt;name_des_geheimen_schlüssels&gt; --cert-crn &lt;CRN_des_zertifikats&gt;</code></pre></li><li>Versuchen Sie, den geheimen Schlüssel zu aktualisieren: <pre class="pre"><code>bx cs alb-cert-deploy --update --cluster &lt;clustername_oder_-id&gt; --secret-name &lt;name_des_geheimen_schlüssels&gt; --cert-crn &lt;CRN_des_zertifikats&gt;</code></pre></li></ol></td>
 </tr>
 <tr>
 <td>Der {{site.data.keyword.cloudcerts_long_notm}}-Service ist ausgefallen.</td>
 <td>Vergewissern Sie sich, dass Ihr {{site.data.keyword.cloudcerts_short}}-Service betriebsbereit ist.</td>
 </tr>
 </tbody></table>

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
