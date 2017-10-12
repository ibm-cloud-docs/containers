---

copyright:
  years: 2014, 2017
lastupdated: "2017-08-15"

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

Ziehen Sie bei der Verwendung von {{site.data.keyword.containershort_notm}} die folgenden Verfahren für die Fehlerbehebung und zum Abrufen von Hilfe in Betracht. 

{: shortdesc}


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
        <td>Der Kubernetes-Master ist bereitgestellt. Die Workerknoten werden gerade eingerichtet und sind noch nicht im Cluster verfügbar. Sie können auf den Cluster zugreifen, aber Sie können keine Apps auf dem Cluster bereitstellen. </td>
      </tr>
      <tr>
        <td>Normal</td>
        <td>Alle Workerknoten in einem Cluster sind betriebsbereit. Sie können auf den Cluster zugreifen und Apps auf dem Cluster bereitstellen. </td>
     </tr>
     <tr>
        <td>Warning (Warnung)</td>
        <td>Mindestens ein Workerknoten in dem Cluster ist nicht verfügbar, aber andere Workerknoten sind verfügbar und können die Workload übernehmen. </td>
     </tr>
     <tr>
      <td>Critical (Kritisch)</td>
      <td>Der Kubernetes-Master kann nicht erreicht werden oder alle Workerknoten in dem Cluster sind inaktiv. </td>
     </tr>
    </tbody>
  </table>

3.  Wenn Ihr Cluster den Status **Warning** oder **Critical** hat oder sich seit längerer Zeit im Status **Pending** befindet, überprüfen Sie den Status Ihrer Workerknoten. Wenn Ihr Cluster den Status **Deploying** hat, warten Sie, bis Ihr Cluster vollständig bereitgestellt wurde, und überprüfen Sie dann den Status Ihres Clusters. Für Cluster mit dem Status **Normal** wird angenommen, dass sie sich in einem in einwandfreiem Zustand befinden und dass derzeit keine Aktion ausgeführt werden muss.  

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
       <td>Der Kubernetes-Master ist aus einem der folgenden Gründe nicht erreichbar: <ul><li>Sie haben ein Update Ihres Kubernetes-Masters angefordert. Der Status des Workerknotens kann während des Updates nicht abgerufen werden. </li><li>Sie haben möglicherweise eine zusätzliche Firewall, die Ihre Workerknoten schützt, oder Sie haben die Firewalleinstellungen kürzlich geändert. {{site.data.keyword.containershort_notm}} erfordert, dass bestimmte IP-Adressen und Ports geöffnet sind, damit die Kommunikation vom Workerknoten zum Kubernetes-Master und umgekehrt möglich ist. Weitere Informationen finden Sie unter [Workerknoten hängen in einer Neuladen-Schleife](#cs_firewall). </li><li>Der Kubernetes-Master ist inaktiv. Wenden Sie sich an den {{site.data.keyword.Bluemix_notm}}-Support, indem Sie ein [{{site.data.keyword.Bluemix_notm}}-Support-Ticket](/docs/support/index.html#contacting-support) öffnen. </li></ul></td>
      </tr>
      <tr>
        <td>Provisioning (Wird bereitgestellt)</td>
        <td>Ihr Workerknoten wird gerade eingerichtet und ist noch nicht im Cluster verfügbar. Sie können den Bereitstellungsprozess in der Spalte **Status** Ihrer CLI-Ausgabe überwachen. Falls sich Ihr Workerknoten eine längere Zeit in diesem Status befindet und Sie in der Spalte **Status** keinen Fortschritt erkennen können, fahren Sie mit dem nächsten Schritt fort, um zu sehen, ob während der Bereitstellung ein Problem aufgetreten ist. </td>
      </tr>
      <tr>
        <td>Provision_failed (Bereitstellung fehlgeschlagen)</td>
        <td>Ihr Workerknoten konnte nicht bereitgestellt werden. Fahren Sie mit dem nächsten Schritt fort, um die Details des Fehlers abzurufen. </td>
      </tr>
      <tr>
        <td>Reloading (Wird neu geladen)</td>
        <td>Ihr Workerknoten wird neu geladen und ist nicht im Cluster verfügbar. Sie können den Neuladeprozess in der Spalte **Status** Ihrer CLI-Ausgabe überwachen. Falls sich Ihr Workerknoten eine längere Zeit in diesem Status befindet und Sie in der Spalte **Status** keinen Fortschritt erkennen können, fahren Sie mit dem nächsten Schritt fort, um zu sehen, ob während des Neuladens ein Problem aufgetreten ist. </td>
       </tr>
       <tr>
        <td>Reloading_failed (Neuladen fehlgeschlagen)</td>
        <td>Ihr Workerknoten konnte nicht neu geladen werden. Fahren Sie mit dem nächsten Schritt fort, um die Details des Fehlers abzurufen. </td>
      </tr>
      <tr>
        <td>Normal</td>
        <td>Ihr Workerknoten wurde vollständig bereitgestellt und kann im Cluster verwendet werden. </td>
     </tr>
     <tr>
        <td>Warning (Warnung)</td>
        <td>Ihr Workerknoten nähert sich dem Grenzwert für die Speicher- oder Plattenkapazität. </td>
     </tr>
     <tr>
      <td>Critical (Kritisch)</td>
      <td>Die Plattenkapazität Ihres Workerknotens ist erschöpft. </td>
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
        <td>Mit Ihrem {{site.data.keyword.BluSoftlayer_notm}}-Konto können Sie keine Rechenressourcen bestellen. Wenden Sie sich an den {{site.data.keyword.Bluemix_notm}}-Support, indem Sie ein [{{site.data.keyword.Bluemix_notm}}-Support-Ticket](/docs/support/index.html#contacting-support) öffnen. </td>
      </tr>
      <tr>
        <td>{{site.data.keyword.Bluemix_notm}} Infrastructure Exception: Could not place order. There are insufficient resources behind router 'routername' to fulfill the request for the following guests: 'worker-id'.</td>
        <td>Das ausgewählte VLAN ist einem Pod im Rechenzentrum zugeordnet, der nicht über ausreichend Speicherplatz zum Bereitstellen Ihres Workerknotens verfügt. Sie können zwischen den folgenden Optionen wählen: <ul><li>Stellen Sie Ihren Workerknoten in einem anderen Rechenzentrum bereit. Führen Sie <code>bx cs locations</code> aus, um verfügbare Rechenzentren aufzulisten. <li>Wenn Sie ein vorhandenes Paar aus öffentlichem und privatem VLAN haben, das einem anderen Pod in dem Rechenzentrum zugeordnet ist, verwenden Sie dieses VLAN stattdessen. <li>Wenden Sie sich an den {{site.data.keyword.Bluemix_notm}}-Support, indem Sie ein [{{site.data.keyword.Bluemix_notm}}-Support-Ticket](/docs/support/index.html#contacting-support) öffnen. </ul></td>
      </tr>
      <tr>
        <td>{{site.data.keyword.Bluemix_notm}} Infrastructure Exception: Could not obtain network VLAN with id: &lt;vlan-id&gt;. </td>
        <td>Ihr Workerknoten konnte nicht bereitgestellt werden, weil die ausgewählte VLAN-ID aus einem der folgenden Gründe nicht gefunden werden konnte: <ul><li>Möglicherweise haben Sie statt der VLAN-ID die VLAN-Nummer angegeben. Die VLAN-Nummer umfasst 3 oder 4 Ziffern, während die VLAN-ID 7 Stellen hat. Führen Sie <code>bx cs vlans &lt;standort&gt;</code> aus, um die VLAN-ID abzurufen. <li>Möglicherweise ist die VLAN-ID nicht dem von Ihnen verwendeten Bluemix-Infrastrukturkonto (SoftLayer) zugeordnet. Führen Sie <code>bx cs vlans &lt;standort&gt;</code> aus, um verfügbare VLAN-IDs für Ihr Konto aufzulisten. Informationen zum Ändern des {{site.data.keyword.BluSoftlayer_notm}}-Kontos finden Sie unter [bx cs credentials-set](cs_cli_reference.html#cs_credentials_set). </ul></td>
      </tr>
      <tr>
        <td>SoftLayer_Exception_Order_InvalidLocation: The location provided for this order is invalid. (HTTP 500)</td>
        <td>Ihr {{site.data.keyword.BluSoftlayer_notm}} ist nicht für das Bestellen von Rechenressourcen im ausgewählten Rechenzentrum eingerichtet. Wenden Sie sich an den [{{site.data.keyword.Bluemix_notm}}-Support](/docs/support/index.html#contacting-support), um sicherzustellen, dass Ihr Konto korrekt eingerichtet ist. </td>
       </tr>
       <tr>
        <td>{{site.data.keyword.Bluemix_notm}} Infrastructure Exception: The user does not have the necessary {{site.data.keyword.Bluemix_notm}} Infrastructure permissions to add servers
        
        </br></br>
        {{site.data.keyword.Bluemix_notm}} Infrastructure Exception: 'Item' must be ordered with permission.</td>
        <td>Möglicherweise verfügen Sie nicht über die erforderlichen Berechtigungen, um einen Workerknoten aus dem {{site.data.keyword.BluSoftlayer_notm}}-Portfolio bereitzustellen. Informationen zu den erforderlichen Berechtigungen finden Sie unter [Zugriff auf das {{site.data.keyword.BluSoftlayer_notm}}-Portfolio konfigurieren, um Kubernetes-Standardcluster zu erstellen](cs_planning.html#cs_planning_unify_accounts). </td>
      </tr>
    </tbody>
  </table>

## Verbindung mit Ihrem IBM {{site.data.keyword.BluSoftlayer_notm}}-Konto während der Erstellung eines Clusters nicht möglich
{: #cs_credentials}

{: tsSymptoms}
Wenn Sie einen neuen Kubernetes-Cluster erstellen, wird die folgende Nachricht angezeigt.

```
We were unable to connect to your {{site.data.keyword.BluSoftlayer_notm}} account. Creating a standard cluster requires that you have either a Pay-As-You-Go account that is linked to an {{site.data.keyword.BluSoftlayer_notm}} account term or that you have used the IBM
{{site.data.keyword.Bluemix_notm}} Container Service CLI to set your {{site.data.keyword.Bluemix_notm}} Infrastructure API keys.
```
{: screen}

{: tsCauses}
Benutzer mit einem nicht verlinkten {{site.data.keyword.Bluemix_notm}}-Konto müssen ein neues nutzungsabhängiges Konto erstellen oder {{site.data.keyword.BluSoftlayer_notm}}-API-Schlüssel manuell mithilfe der {{site.data.keyword.Bluemix_notm}}-CLI hinzufügen.

{: tsResolve}
Gehen Sie wie folgt vor, um Berechtigungsnachweise für Ihr {{site.data.keyword.Bluemix_notm}}-Konto hinzuzufügen. 

1.  Wenden Sie sich an Ihren {{site.data.keyword.BluSoftlayer_notm}}-Administrator, um Ihren {{site.data.keyword.BluSoftlayer_notm}}-Benutzernamen und den API-Schlüssel abzurufen.

    **Hinweis:** Das {{site.data.keyword.BluSoftlayer_notm}}-Konto, das Sie verwenden, muss mit Superuser-Berechtigungen konfiguriert sein, um Standardcluster erfolgreich zu erstellen. 

2.  Fügen Sie die Berechtigungsnachweise hinzu.

  ```
  bx cs credentials-set --infrastructure-username <benutzername> --infrastructure-api-key <api-schlüssel>
  ```
  {: pre}

3.  Erstellen Sie einen Standardcluster.

  ```
  bx cs cluster-create --location dal10 --public-vlan meine_ID_für_öffentliches_VLAN --private-vlan meine_ID_für_privates_VLAN --machine-type u1c.2x4 --name mein_cluster --hardware gemeinsam genutzt --workers 2
  ```
  {: pre}


## Zugreifen auf Workerknoten mit SSH schlägt fehl
{: #cs_ssh_worker}

{: tsSymptoms}
Es ist kein Zugriff auf Ihren Workerknoten über eine SSH-Verbindung möglich.

{: tsCauses}
Auf den Workerknoten ist SSH über Kennwort inaktiviert.

{: tsResolve}
Verwenden Sie [Dämon-Sets ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) für Vorgänge, die auf jedem Knoten ausgeführt werden müssen. Verwenden Sie Jobs für alle einmaligen Aktionen, die Sie durchführen müssen.



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
  bx cs worker-add <clustername_oder_-ID> 1
  ```
  {: pre}

5.  Falls Ihre Pods auch weiterhin im Status **Pending** (Anstehend) verweilen, obwohl der Workerknoten voll bereitgestellt wurde, ziehen Sie die [Kubernetes-Dokumentation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tasks/debug-application-cluster/debug-pod-replication-controller/#my-pod-stays-pending) zurate, um die Ursache für den andauernden Status 'Pending' Ihres Pods zu ermitteln und den Fehler zu beheben. 

## Workerknotenerstellung schlägt mit provision_failed-Nachricht fehl
{: #cs_pod_space}

{: tsSymptoms}
Wenn Sie einen Kubernetes-Cluster erstellen oder Workerknoten hinzufügen, wird der Zustand provision_failed angezeigt. Führen Sie den folgenden Befehl aus.

```
bx cs worker-get <WORKERKNOTEN-ID>
```
{: pre}

Die folgende Nachricht wird angezeigt.

```
SoftLayer_Exception_Virtual_Host_Pool_InsufficientResources: Could not place order. There are insufficient resources behind router bcr<router-ID> to fulfill the request for the following guests: kube-<standort>-<workerknoten-ID>-w1 (HTTP 500)
```
{: screen}

{: tsCauses}
{{site.data.keyword.BluSoftlayer_notm}} hat zu diesem Zeitpunkt nicht ausreichend Kapazität für die Bereitstellung des Workerknotens.

{: tsResolve}
Option 1: Erstellen Sie den Cluster an einem anderen Standort.

Option 2: Öffnen Sie ein Support-Ticket bei {{site.data.keyword.BluSoftlayer_notm}} und erfragen Sie die Kapazitätsverfügbarkeit an dem Standort.

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

## Workerknoten können nicht verbunden werden
{: #cs_firewall}

{: tsSymptoms}
Wenn 'kubectl proxy' fehlschlägt oder wenn Sie versuchen, auf einen Service in Ihrem Cluster zuzugreifen und die Verbindung schlägt mit einer der folgenden Fehlernachrichten fehl:

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

Oder wenn Sie 'kubectl exec', 'kubectl attach' oder 'kubectl logs' verwenden und diesen Fehler erhalten:

  ```
  Error from server: error dialing backend: dial tcp XXX.XXX.XXX:10250: getsockopt: connection timed out
  ```
  {: screen}

Oder wenn 'kubectl proxy' erfolgreich ausgeführt wird, aber das Dashboard ist nicht verfügbar und Sie erhalten diesen Fehler:

  ```
  timeout on 172.xxx.xxx.xxx
  ```
  {: screen}

Oder wenn Ihre Workerknoten in einer Neuladen-Schleife hängen. 

{: tsCauses}
Gegebenenfalls ist eine zusätzliche Firewall eingerichtet oder Sie haben die vorhandenen Firewalleinstellungen in Ihrem {{site.data.keyword.BluSoftlayer_notm}}-Konto angepasst. {{site.data.keyword.containershort_notm}} erfordert, dass bestimmte IP-Adressen und Port geöffnet sind, damit die Kommunikation vom Workerknoten zum Kubernetes-Master und umgekehrt möglich ist.

{: tsResolve}
Für diese Task ist die [Zugriffsrichtlinie 'Administrator'](cs_cluster.html#access_ov) erforderlich. Überprüfen Sie Ihre aktuelle [Zugriffsrichtlinie](cs_cluster.html#view_access).

Öffnen Sie in Ihrer angepassten Firewall die folgenden Ports und IP-Adressen.
```
TCP port 443 FROM '<öffentliche_ip_jedes_workerknotens>' TO registry.ng.bluemix.net, apt.dockerproject.org
```
{: pre}


<!--Inbound left for existing clusters. Once existing worker nodes are reloaded, users only need the Outbound information, which is found in the regular docs.-->

1.  Notieren Sie die öffentlichen IP-Adressen für alle Workerknoten im Cluster:

  ```
  bx cs workers '<clustername_oder_-id>'
  ```
  {: pre}

2.  Lassen Sie in Ihrer Firewall die folgenden Verbindungen von und zu Ihren Workerknoten zu:

  ```
TCP port 443 FROM '<öffentliche_ip_jedes_workerknotens>' TO registry.ng.bluemix.net, apt.dockerproject.org
```
  {: pre}

    <ul><li>Lassen Sie für die Konnektivität ankommender Daten zu den Workerknoten den eingehenden Netzverkehr von den folgenden Quellennetzgruppen und IP-Adressen zum TCP/UDP-Zielport 10250 und zu `<öffentliche_ip_jedes_workerknotens>` zu:</br>
    
    <table summary="Die erste Zeile in der Tabelle erstreckt sich über beide Spalten. Der Rest der Zeilen sollte von links nach rechts gelesen werden, wobei die Serverposition in der ersten Spalte und die passenden IP-Adressen in der zweiten Spalte angegeben sind.">
      <thead>
      <th colspan=2><img src="images/idea.png"/> Eingehende IP-Adressen</th>
      </thead>
    <tbody>
      <tr>
        <td>ams03</td>
        <td><code>169.50.144.128/28</code></br><code>169.50.169.104/29</code></br><code>169.50.185.32/27</code></td>
      </tr>
      <tr>
        <td>dal10</td>
        <td><code>169.46.7.232/29</code></br><code>169.48.138.64/26</code></br><code>169.48.180.128/25</code></td>
       </tr>
       <tr>
        <td>dal12</td>
        <td><code>169.47.70.8/29</code></br><code>169.47.79.192/26</code></br><code>169.47.126.192/27</code></td>
       </tr>
       <tr>
        <td>fra02</td>
        <td><code>169.50.48.160/28</code></br><code>169.50.56.168/29</code></br><code>169.50.58.160/27</code></td>
       </tr>
      </tbody>
      <tr>
       <td>lon02</td>
       <td><code>159.122.242.78</code></td>
      </tr>
      <tr>
       <td>lon04</td>
       <td><code>158.175.68.192/26</code></td>
      </tr>
      <tr>
       <td>syd01</td>
       <td><code>168.1.209.192/26</code></td>
      </tr>
      <tr>
       <td>syd04</td>
       <td><code>130.198.67.0/26</code></td>
      </tr>
    </table>

    <li>Ermöglichen Sie für eine OUTBOUND-Konnektivität für Ihre Workerknoten einen ausgehenden Netzverkehr vom Quellen-Workerknoten zum TCP/UDP-Zielportbereich 20000-32767 für `<öffentliche_IP_für_jeden_workerknoten>` und die folgenden IP-Adressen und Netzgruppen: </br>
    
    <table summary="Die erste Zeile in der Tabelle erstreckt sich über beide Spalten. Der Rest der Zeilen sollte von links nach rechts gelesen werden, wobei die Serverposition in der ersten Spalte und die passenden IP-Adressen in der zweiten Spalte angegeben sind."> <thead>
      <th colspan=2><img src="images/idea.png"/> Ausgehende IP-Adressen</th>
      </thead>
    <tbody>
      <tr>
        <td>ams03</td>
        <td><code>169.50.169.110</code></td>
      </tr>
      <tr>
        <td>dal10</td>
        <td><code>169.46.7.238</code></td>
       </tr>
       <tr>
        <td>dal12</td>
        <td><code>169.47.70.10</code></td>
       </tr>
       <tr>
        <td>fra02</td>
        <td><code>169.50.56.174</code></td>
       </tr>
      </tbody>
      <tr>
       <td>lon02</td>
       <td><code>159.122.242.78</code></td>
      </tr>
      <tr>
       <td>lon04</td>
       <td><code>158.175.65.170</code></td>
      </tr>
      <tr>
       <td>syd01</td>
       <td><code>168.1.8.195</code></td>
      </tr>
      <tr>
       <td>syd04</td>
       <td><code>130.198.64.19</code></td>
      </tr>
    </table>
</ul>
    
    

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
  bx cs workers <clustername_oder_-id>
  ```
  {: pre}

    Stellen Sie in Ihrer CLI-Ausgabe sicher, dass der **Status** Ihrer Workerknoten **Ready** (Bereit) lautet und dass für den **Maschinentyp** etwas anderes als **free** (frei) anzeigt wird. 

2.  Rufen Sie die Unterdomäne und die öffentliche IP-Adresse des Ingress-Controllers ab und setzen Sie dann ein Pingsignal an beide ab. 

    1.  Rufen Sie die Unterdomäne des Ingress-Controllers ab. 

      ```
      bx cs cluster-get <clustername_oder_-id> | grep "Ingress subdomain"
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

    1.  Prüfen Sie, dass die Unterdomäne des Ingress-Controllers und das TLS-Zertifikat korrekt sind. Sie finden die von IBM bereitgestellte Unterdomäne und das TLS-Zertifikat, indem Sie 'bx cs cluster-get <clustername_oder_-id>' ausführen. 
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

    1.  Prüfen Sie, dass Sie **LoadBalancer** als Typ für Ihren Service definiert haben. 
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
    <ol><li>Listen Sie verfügbare Workerknoten auf. </br><pre class="codeblock"><code>kubectl get nodes</code></pre>
    <li>Werden mindestens zwei verfügbare Workerknoten gefunden, listen Sie die Details der Workerknoten auf. </br><pre class="screen"><code>bx cs worker-get <worker-id></code></pre>
    <li>Stellen Sie sicher, dass die öffentlichen und privaten VLAN-IDs für die Workerknoten, die von den Befehlen 'kubectl get nodes' und 'bx cs worker-get' zurückgegeben wurden, übereinstimmen. </ol></ul></ul>

4.  Wenn Sie eine angepasste Domäne verwenden, um Ihren Lastausgleichsservice zu verbinden, stellen Sie sicher, dass Ihre angepasste Domäne der öffentlichen IP-Adresse Ihres Lastausgleichsservice zugeordnet ist. 
    1.  Suchen Sie nach der öffentlichen IP-Adresse Ihres Lastausgleichsservice. 

      ```
      kubectl describe service <mein_service> | grep "LoadBalancer Ingress"
      ```
      {: pre}

    2.  Prüfen Sie, dass Ihre angepasste Domäne der portierbaren öffentlichen IP-Adresse Ihres Lastausgleichsservice im Zeigerdatensatz (PTR) zugeordnet ist. 

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
    <dd>Aus Sicherheitsgründen ist der Service 'NodePort' im Kubernetes-Dashboard inaktiviert. Führen Sie folgenden Befehl aus, um auf Ihr Kubernetes-Dashboard zuzugreifen:</br><pre class="codeblock"><code>kubectl proxy</code></pre></br>Anschließend können Sie auf das Kubernetes-Dashboard unter `http://localhost:8001/ui` zugreifen. </dd>
  <dt>Einschränkungen beim Servicetyp für die Lastausgleichsfunktion (Load Balancer)</dt>
    <dd><ul><li>Die Verwendung des Lastausgleichs für private LANs ist nicht möglich.<li>Es können keine Serviceannotationen für 'service.beta.kubernetes.io/external-traffic' und
'service.beta.kubernetes.io/healthcheck-nodeport' verwenden. Weitere Informationen zu diesen Annotationen enthält die
[Kubernetes-Dokumentation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tutorials/services/source-ip/).
</ul></dd>
  <dt>Horizontales automatisches Skalieren funktioniert nicht</dt>
    <dd>Aus Sicherheitsgründen wird der Standardport verwendet, der von Heapster (10255) in allen Workerknoten geschlossen ist. Da dieser Port geschlossen ist, ist Heapster nicht in der Lage, Metriken für Workerknoten zu melden, und das horizontale automatische Skalieren funktioniert nicht wie im Abschnitt zum [automatischen horizontalen Skalieren von Pods ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/) in der Kubernetes-Dokumentation dokumentiert. </dd>
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
    -   Verwenden Sie für Fragen zum Service und zu ersten Schritten das Forum [IBM developerWorks dW Answers ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://developer.ibm.com/answers/topics/containers/?smartspace=bluemix).
Geben Sie die Tags `bluemix`
und `containers` an.
    Weitere Details zur Verwendung der Foren
finden Sie unter [Hilfe anfordern](/docs/support/index.html#getting-help).

-   Wenden Sie sich an den IBM Support. Informationen zum Öffnen eines IBM
Support-Tickets oder zu Supportstufen und zu Prioritätsstufen von Tickets finden Sie unter
[Support kontaktieren](/docs/support/index.html#contacting-support).
