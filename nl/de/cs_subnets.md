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


# Teilnetze für Cluster konfigurieren
{: #subnets}

Ändern Sie den Pool der verfügbaren portierbaren öffentlichen oder privaten IP-Adressen, indem Sie Ihrem Cluster Teilnetze hinzufügen.
{:shortdesc}

Sie können in {{site.data.keyword.containershort_notm}} stabile, portierbare IPs für Kubernetes-Services hinzufügen, indem Sie dem Cluster Teilnetze hinzufügen. In diesem Fall werden Teilnetze nicht mit Netzmasken verwendet, um Konnektivität zwischen mehreren Clustern zu erstellen. Stattdessen werden Teilnetze eingesetzt, um unveränderliche IPs für einen Service aus einem Cluster bereitzustellen, über die auf den Service zugegriffen werden kann.

Wenn Sie einen Standardcluster erstellen, stellt {{site.data.keyword.containershort_notm}} automatisch ein portierbares öffentliches Teilnetz mit 5 öffentlichen IP-Adressen und ein portierbares privates Teilnetz mit 5 privaten IP-Adressen bereit. Portierbare öffentliche und private IP-Adressen sind statisch und ändern sich nicht, wenn ein Workerknoten oder sogar der Cluster entfernt wird. Pro Teilnetz wird eine der portierbaren öffentlichen und eine der portierbaren privaten IP-Adressen für [Lastausgleichsfunktionen für Anwendungen](cs_ingress.html) verwendet, mit denen Sie mehrere Apps in Ihrem Cluster zugänglich machen können. Die vier verbleibenden portierbaren öffentlichen und vier portierbaren privaten IP-Adressen können verwendet werden, um einzelne Apps für die Öffentlichkeit verfügbar zu machen, indem Sie einen [Lastausgleichsservice erstellen](cs_loadbalancer.html).

**Hinweis:** Portierbare öffentliche IP-Adressen werden monatlich berechnet. Wenn Sie nach der Bereitstellung Ihres Clusters beschließen, portierbare öffentliche IP-Adressen zu entfernen, müssen Sie trotzdem die monatliche Gebühr bezahlen, auch wenn sie sie nur über einen kurzen Zeitraum genutzt haben.

## Zusätzliche Teilnetze für Ihren Cluster anfordern
{: #request}

Sie können stabile portierbare öffentliche oder private IP-Adressen zum Cluster hinzufügen, wenn Sie dem Cluster Teilnetze zuordnen.

**Hinweis:** Wenn Sie ein Teilnetz in einem Cluster verfügbar machen, werden IP-Adressen dieses Teilnetzes zum Zweck von Clusternetzen verwendet. Vermeiden Sie IP-Adresskonflikte, indem Sie ein Teilnetz mit nur einem Cluster verwenden. Verwenden Sie kein Teilnetz für mehrere Cluster oder für andere
Zwecke außerhalb von {{site.data.keyword.containershort_notm}} gleichzeitig.

Führen Sie zunächst den folgenden Schritt aus: [Richten Sie Ihre CLI](cs_cli_install.html#cs_cli_configure) auf Ihren Cluster aus.

Gehen Sie wie folgt vor, um ein Teilnetz in einem IBM Cloud Infrastructure (SoftLayer)-Konto zu erstellen und in einem bestimmten Cluster verfügbar zu machen:

1. Stellen Sie ein neues Teilnetz bereit.

    ```
    bx cs cluster-subnet-create <clustername_oder_-id> <teilnetzgröße> <VLAN_ID>
    ```
    {: pre}

    <table>
    <caption>Erklärung der Bestandteile dieses Befehls</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der Bestandteile dieses Befehls</th>
    </thead>
    <tbody>
    <tr>
    <td><code>cluster-subnet-create</code></td>
    <td>Der Befehl zum Bereitstellen eines Teilnetzes für Ihren Cluster.</td>
    </tr>
    <tr>
    <td><code><em>&lt;clustername_oder_-id&gt;</em></code></td>
    <td>Ersetzen Sie <code>&lt;clustername_oder_-id&gt;</code> durch den Namen oder die ID des Clusters.</td>
    </tr>
    <tr>
    <td><code><em>&lt;teilnetzgröße&gt;</em></code></td>
    <td>Ersetzen Sie <code>&lt;teilnetzgröße&gt;</code> durch die Anzahl von IP-Adressen, die Sie aus Ihrem portierbaren Teilnetz hinzufügen möchten. Gültige Werte sind 8, 16, 32 oder 64. <p>**Hinweis:** Wenn Sie portierbare IP-Adressen für Ihr Teilnetz hinzufügen, werden drei IP-Adressen verwendet, um clusterinterne Netze einzurichten, und stehen folglich nicht für Ihre Lastausgleichsfunktionen für Anwendungen oder für das Erstellen eines Lastausgleichsservice bereit. Wenn Sie beispielsweise acht portierbare öffentliche IP-Adressen anfordern, können Sie fünf verwenden, um die Apps öffentlich verfügbar zu machen.</p> </td>
    </tr>
    <tr>
    <td><code><em>&lt;VLAN_ID&gt;</em></code></td>
    <td>Ersetzen Sie <code>&lt;VLAN_ID&gt;</code> durch die ID des öffentlichen oder privaten VLANs, in dem Sie die portierbaren öffentlichen oder privaten IP-Adressen zuweisen möchten. Sie müssen das öffentliche oder private VLAN auswählen, mit dem ein vorhandener Workerknoten verbunden ist. Führen Sie den Befehl <code>bx cs worker-get &lt;worker-id&gt;</code> aus, um das öffentliche oder private VLAN für einen Workerknoten zu überprüfen. </td>
    </tr>
    </tbody></table>

2.  Überprüfen Sie, ob das Teilnetz erfolgreich erstellt und zu Ihrem Cluster hinzugefügt wurde. Das Teilnetz-CIDR wird im Abschnitt **VLANs** aufgelistet.

    ```
    bx cs cluster-get --showResources <clustername_oder_-id>
    ```
    {: pre}

<br />


## Angepasste und vorhandene Teilnetze zu Kubernetes-Clustern hinzufügen
{: #custom}

Sie können Ihren Kubernetes-Clustern vorhandene portierbare öffentliche oder private Teilnetze hinzufügen.

Führen Sie zunächst den folgenden Schritt aus: [Richten Sie Ihre CLI](cs_cli_install.html#cs_cli_configure) auf Ihren Cluster aus.

Wenn Sie ein Teilnetz in Ihrem Portfolio von IBM Cloud Infrastructure (SoftLayer) mit angepassten Firewallregeln oder verfügbaren IP-Adressen haben, das Sie verwenden möchten, erstellen Sie einen Cluster ohne Teilnetz. Stellen Sie dann das vorhandene Teilnetz dem Cluster zur Verfügung, wenn der Cluster bereitgestellt wird.

1.  Geben Sie das Teilnetz an, das Sie verwenden möchten. Beachten Sie die ID des Teilnetzes und die VLAN-ID. In diesem Beispiel lautet die Teilnetz-ID '807861' und die VLAN-ID '1901230'.

    ```
    bx cs subnets
    ```
    {: pre}

    ```
    Getting subnet list...
    OK
    ID        Network                                      Gateway                                   VLAN ID   Type      Bound Cluster   
    553242    203.0.113.0/24                               10.87.15.00                               1565280   private      
    807861    192.0.2.0/24                                 10.121.167.180                            1901230   public

    ```
    {: screen}

2.  Bestätigen Sie die Position, an der sich das VLAN befindet. In diesem Beispiel lautet die Position 'dal10'.

    ```
    bx cs vlans dal10
    ```
    {: pre}

    ```
    Getting VLAN list...
    OK
    ID        Name                  Number   Type      Router   
    1900403   vlan                    1391     private   bcr01a.dal10   
    1901230   vlan                    1180     public   fcr02a.dal10
    ```
    {: screen}

3.  Erstellen Sie einen Cluster mithilfe der Position und der VLAN-ID, die Sie angegeben haben. Schließen Sie das Flag `--no-subnet` ein, um zu vermeiden, dass ein neues portierbares öffentliches und ein neues portierbares privates IP-Teilnetz automatisch erstellt wird.

    ```
    bx cs cluster-create --location dal10 --machine-type u2c.2x4 --no-subnet --public-vlan 1901230 --private-vlan 1900403 --workers 3 --name mein_cluster
    ```
    {: pre}

4.  Prüfen Sie, ob die Erstellung des Clusters angefordert wurde.

    ```
    bx cs clusters
    ```
    {: pre}

    **Hinweis:** Es kann bis zu 15 Minuten dauern, bis die Workerknotenmaschinen angewiesen werden und der Cluster in Ihrem
Konto eingerichtet und bereitgestellt wird.

    Nach Abschluss der Bereitstellung Ihres Clusters wird der Status des
Clusters in **deployed** (Bereitgestellt) geändert.

    ```
    Name         ID                                   State      Created          Workers
    mein_cluster   paf97e8843e29941b49c598f516de72101   deployed   20170201162433   3
    ```
    {: screen}

5.  Überprüfen Sie den Status der Workerknoten.

    ```
    bx cs workers <cluster>
    ```
    {: pre}

    Wenn die Workerknoten bereit sind, wechselt der Zustand (State) zu **Normal**, während für den Status die Angabe **Bereit** angezeigt wird. Wenn der Knotenstatus **Bereit** lautet, können Sie auf den Cluster zugreifen.

    ```
    ID                                                  Public IP        Private IP     Machine Type   State      Status  
    prod-dal10-pa8dfcc5223804439c87489886dbbc9c07-w1   169.47.223.113   10.171.42.93   free           normal    Ready
    ```
    {: screen}

6.  Fügen Sie Ihrem Cluster das Teilnetz hinzu, indem Sie die Teilnetz-ID angeben. Wenn Sie ein Teilnetz für einen Cluster verfügbar machen, wird eine Kubernetes-Konfigurationsübersicht für Sie erstellt, die alle verfügbaren portierbaren öffentlichen IP-Adressen enthält, die Sie verwenden können. Wenn für Ihr Cluster noch keine Lastausgleichsfunktionen für Anwendungen vorhanden sind, werden eine portierbare öffentliche und eine portierbare private IP-Adresse automatisch verwendet, um die öffentlichen und privaten Lastausgleichsfunktionen für Anwendungen zu erstellen. Alle anderen portierbaren öffentlichen und privaten IP-Adressen können zum Erstellen von Lastenausgleichsservices für die Apps verwendet werden.

    ```
    bx cs cluster-subnet-add mycluster 807861
    ```
    {: pre}

<br />


## Vom Benutzer verwaltete Teilnetze und IP-Adressen zu Kubernetes-Clustern hinzufügen
{: #user_managed}

Stellen Sie ein eigenes Teilnetz aus einem lokalen Netz zur Verfügung, auf das über {{site.data.keyword.containershort_notm}} zugegriffen werden soll. Anschließend können Sie private IP-Adressen aus diesem Teilnetz zu den Lastenausgleichsservices im Kubernetes-Cluster hinzufügen.

Voraussetzungen:
- Vom Benutzer verwaltete Teilnetze können nur zu privaten VLANs hinzugefügt werden.
- Die Begrenzung für die Länge des Teilnetzpräfix beträgt /24 bis /30. Beispiel: `203.0.113.0/24` gibt 253 verwendbare private IP-Adressen an, während `203.0.113.0/30` 1 verwendbare private IP-Adresse angibt.
- Die erste IP-Adresse im Teilnetz muss als Gateway für das Teilnetz verwendet werden.

Vorbemerkungen:
- Konfigurieren Sie vorab das Routing des Netzverkehrs in das externe Teilnetz bzw. aus dem externen Teilnetz.
- Vergewissern Sie sich, dass Sie über VPN-Konnektivität zwischen der Gateway-Einheit des lokalen Rechenzentrums und entweder der Vyatta-Einheit des privaten Netzes im Portfolio von IBM Cloud Infrastructure (SoftLayer) oder dem aktiven Strongswan-VPN-Service in Ihrem Cluster verfügen. Informationen zur Verwendung von Vyatta finden Sie in diesem [Blogbeitrag ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/blogs/bluemix/2017/07/kubernetes-and-bluemix-container-based-workloads-part4/). Informationen zur Verwendung von Strongswan finden Sie unter [Einrichtung von VPN-Konnektivität mit dem Strongswan-IPSec-VPN-Service](cs_vpn.html).

1. Zeigen Sie die ID des privaten VLAN Ihres Clusters an. Suchen Sie den Abschnitt **VLANs**. Geben Sie im Feld für die Verwaltung durch den Benutzer die VLAN-ID mit _false_ an.

    ```
    bx cs cluster-get --showResources <clustername>
    ```
    {: pre}

    ```
    VLANs
    VLAN ID   Subnet CIDR         Public       User-managed
    1555503   192.0.2.0/24        true         false
    1555505   198.51.100.0/24     false        false
    ```
    {: screen}

2. Fügen Sie das externe Teilnetz zu Ihrem privaten VLAN hinzu. Die portierbaren privaten IP-Adressen werden zur Konfigurationsübersicht des Clusters hinzugefügt.

    ```
    bx cs cluster-user-subnet-add <clustername> <teilnetz_CIDR> <VLAN-ID>
    ```
    {: pre}

    Beispiel:

    ```
    bx cs cluster-user-subnet-add mein_cluster 203.0.113.0/24 1555505
    ```
    {: pre}

3. Überprüfen Sie, ob das vom Benutzer bereitgestellte Teilnetz hinzugefügt wurde. Das Feld für die Verwaltung durch den Benutzer ist auf _true_ gesetzt.

    ```
    bx cs cluster-get --showResources <clustername>
    ```
    {: pre}

    ```
    VLANs
    VLAN ID   Subnet CIDR         Public       User-managed
    1555503   192.0.2.0/24        true         false
    1555505   198.51.100.0/24     false        false
    1555505   203.0.113.0/24      false        true
    ```
    {: screen}

4. Fügen Sie einen privaten Lastausgleichsservice oder eine private Ingress-Lastausgleichsfunktion für Anwendungen hinzu, um über das private Netz auf Ihre App zuzugreifen. Wenn Sie eine private IP-Adresse aus dem Teilnetz verwenden möchten, die Sie hinzugefügt haben, als Sie eine private Lastausgleichsfunktion bzw. eine private Ingress-Lastausgleichsfunktion für Anwendungen erstellt haben, müssen Sie eine IP-Adresse angeben. Andernfalls wird eine IP-Adresse nach dem Zufallsprinzip aus den Teilnetzen von IBM Cloud Infrastructure (SoftLayer) oder aus den vom Benutzer bereitgestellten Teilnetzen im privaten VLAN ausgewählt. Weitere Informationen finden Sie unter [Zugriff auf eine App durch Verwenden des Servicetyps 'LoadBalancer' konfigurieren](cs_loadbalancer.html#config) oder unter [Private Lastausgleichsfunktion für Anwendungen aktivieren](cs_ingress.html#private_ingress).

<br />


## IP-Adressen und Teilnetze verwalten
{: #manage}

Sie können portierbare öffentliche und private Teilnetze und IP-Adressen verwenden, um Apps in Ihrem Cluster und über das Internet oder ein privates Netz zugänglich zu machen.
{:shortdesc}

Sie können in {{site.data.keyword.containershort_notm}} stabile, portierbare IPs für Kubernetes-Services hinzufügen, indem Sie dem Cluster Teilnetze hinzufügen. Wenn Sie einen Standardcluster erstellen, stellt {{site.data.keyword.containershort_notm}} automatisch ein portierbares öffentliches Teilnetz mit 5 portierbaren öffentlichen IP-Adressen und ein portierbares privates Teilnetz mit 5 portierbaren privaten IP-Adressen bereit. Portierbare IP-Adressen sind statisch und ändern sich nicht, wenn ein Workerknoten oder sogar der Cluster entfernt wird.

Zwei der portierbaren IP-Adressen (eine öffentliche und eine private) werden für [Ingress-Lastausgleichsfunktionen für Anwendungen](cs_ingress.html) verwendet, mit denen Sie mehrere Apps in Ihrem Cluster zugänglich machen können. 4 portierbare öffentliche und 4 portierbare private IP-Adressen können verwendet werden, um Apps verfügbar zu machen, indem Sie einen [Lastausgleichsservice erstellen](cs_loadbalancer.html).

**Hinweis:** Portierbare öffentliche IP-Adressen werden monatlich berechnet. Wenn Sie nach der Bereitstellung Ihres Clusters beschließen, portierbare öffentliche IP-Adressen zu entfernen, müssen Sie trotzdem die monatliche Gebühr bezahlen, auch wenn sie sie nur über einen kurzen Zeitraum genutzt haben.



1.  Erstellen Sie eine Kubernetes-Servicekonfigurationsdatei namens `myservice.yaml` und definieren Sie einen Service vom Typ `LoadBalancer` mit einer Dummy-IP-Adresse für die Lastausgleichsfunktion. Im folgenden Beispiel wird die IP-Adresse '1.1.1.1' als IP-Adresse der Lastausgleichsfunktion verwendet.

    ```
    apiVersion: v1
    kind: Service
    metadata:
      labels:
        run: myservice
      name: myservice
      namespace: default
    spec:
      ports:
      - port: 80
        protocol: TCP
        targetPort: 80
      selector:
        run: myservice
      sessionAffinity: None
      type: LoadBalancer
      loadBalancerIP: 1.1.1.1
    ```
    {: codeblock}

2.  Erstellen Sie den Service in Ihrem Cluster.

    ```
    kubectl apply -f myservice.yaml
    ```
    {: pre}

3.  Überprüfen Sie den Service.

    ```
    kubectl describe service myservice
    ```
    {: pre}

    **Hinweis:** Die Erstellung dieses Service schlägt fehl, weil der Kubernetes-Master die angegebene IP-Adresse der Lastausgleichsfunktion in der Kubernetes-Konfigurationsübersicht nicht finden kann. Wenn Sie diesen Befehl ausführen, können Sie die Fehlernachricht und die Liste von verfügbaren öffentlichen IP-Adressen für den Cluster anzeigen.

    ```
    Error on cloud load balancer a8bfa26552e8511e7bee4324285f6a4a for service default/myservice with UID 8bfa2655-2e85-11e7-bee4-324285f6a4af: Requested cloud provider IP 1.1.1.1 is not available. Die folgenden Cloud-Provider-IPs sind verfügbar: <liste_von_IP-adressen>
    ```
    {: screen}

<br />




## Verwendete IP-Adressen freigeben
{: #free}

Sie können eine bereits verwendete portierbare IP-Adresse freigeben, indem Sie den Lastausgleichsservice löschen, der die portierbare IP-Adresse belegt.

Bevor Sie beginnen, müssen Sie den [Kontext für den zu verwendenden Cluster festlegen](cs_cli_install.html#cs_cli_configure).

1.  Listen Sie verfügbare Services in Ihrem Cluster auf.

    ```
    kubectl get services
    ```
    {: pre}

2.  Entfernen Sie den Lastausgleichsservice, der eine öffentliche oder private IP-Adresse belegt.

    ```
    kubectl delete service <mein_service>
    ```
    {: pre}
