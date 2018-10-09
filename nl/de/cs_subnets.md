---

copyright:
  years: 2014, 2018
lastupdated: "2018-09-10"

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

Ändern Sie den Pool der verfügbaren, portierbaren öffentlichen oder privaten IP-Adressen für Load Balancer-Services (Load Balancer – Lastausgleichsfunktion), indem Sie Ihrem Kubernetes-Cluster Teilnetze hinzufügen.
{:shortdesc}

## Standard-VLANs, Teilnetze und IPs für Cluster
{: #default_vlans_subnets}

Während der Clustererstellung werden die Workerknoten des Clusters und die Standardteilnetze automatisch mit einem VLAN verbunden.

### VLANs
{: #vlans}

Beim Erstellen eines Clusters werden die Workerknoten des Clusters automatisch mit einem VLAN verbunden. Ein VLAN konfiguriert eine Gruppe von Workerknoten und Pods so, als wären diese an dasselbe physische Kabel angeschlossen und es bietet einen Kanal für die Konnektivität zwischen Worker und Pods.

<dl>
<dt>VLANs for kostenlose Cluster</dt>
<dd>Bei kostenlosen Clustern werden die Workerknoten des Clusters standardmäßig mit einem öffentlichen und einem privaten VLAN verbunden, deren Eigner IBM ist. Da IBM die VLANs, Teilnetze und IP-Adressen steuert, können Sie keine Mehrzonencluster erstellen oder Ihrem Cluster Teilnetze hinzufügen; darüber hinaus können Sie zum Verfügbarmachen Ihrer App nur NodePort-Services verwenden.</dd>
<dt>VLANs für Standardcluster</dt>
<dd>Wenn Sie bei Standardclustern in einer Zone zum ersten Mal einen Cluster erstellen, werden in dieser Zone automatisch ein öffentliches und ein privates VLAN für Sie in Ihrem Konto der IBM Cloud-Infrastruktur (SoftLayer) bereitgestellt. Für jeden weiteren Cluster, den Sie in dieser Zone erstellen, können Sie dasselbe öffentliche und private VLAN wiederverwenden, da ein VLAN von mehreren Clustern gemeinsam genutzt werden kann.</br></br>Sie können Ihre Workerknoten entweder mit einem öffentlichen und einem privaten VLAN verbinden oder nur mit einem privaten VLAN. Wenn Ihre Workerknoten nur mit einem privaten VLAN verbunden werden sollen, können Sie die ID eines vorhandenen privaten VLANs verwenden oder [ein privates VLAN erstellen](/docs/cli/reference/ibmcloud/cli_vlan.html#ibmcloud-sl-vlan-create) und die ID während der Clustererstellung verwenden.</dd></dl>

Um die VLANs anzuzeigen, die in den einzelnen Zonen für Ihr Konto bereitgestellt sind, setzen Sie `ibmcloud ks vlans <zone>` aus. Um die VLANs anzuzeigen, in denen ein Cluster bereitgestellt ist, setzen Sie `ibmcloud ks cluster-get <cluster_name_or_ID> --showResources` ab und suchen Sie den Abschnitt für **VLANs von Teilnetzen**.

**Hinweis**:
* Wenn Sie über mehrere VLANs für einen Cluster, mehrere Teilnetze in demselben VLAN oder einen Cluster mit mehreren Zonen verfügen, müssen Sie [VLAN-Spanning](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) für Ihr Konto für die IBM Cloud-Infrastruktur (SoftLayer) aktivieren, damit die Workerknoten in dem privaten Netz miteinander kommunizieren können. Um diese Aktion durchführen zu können, müssen Sie über die [Infrastrukturberechtigung](cs_users.html#infra_access) **Netz > VLAN-Spanning im Netz verwalten** verfügen oder Sie können den Kontoeigner bitte, diese zu aktivieren. Um zu prüfen, ob das VLAN-Spanning bereits aktiviert ist, verwenden Sie den [Befehl](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`. Wenn Sie {{site.data.keyword.BluDirectLink}} verwenden, müssen Sie stattdessen eine [ VRF-Funktion (Virtual Router Function)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf) verwenden. Um VRF zu aktivieren, wenden Sie sich an Ihren Ansprechpartner für die IBM Cloud-Infrastruktur (SoftLayer). 
* Die IBM Cloud-Infrastruktur (SoftLayer) verwaltet die VLANs, die automatisch bereitgestellt werden, wenn Sie Ihren ersten Cluster in einer Zone erstellen. Wenn ein VLAN nicht mehr verwendet wird, z. B. nach dem Entfernen aller Workerknoten aus dem VLAN, wird das VLAN von der IBM Cloud-Infrastruktur (SoftLayer) freigegeben. Wenn Sie ein neues VLAN benötigen, [wenden Sie sich an den {{site.data.keyword.Bluemix_notm}}-Support](/docs/infrastructure/vlans/order-vlan.html#order-vlans).

### Teilnetze und IP-Adressen
{: #subnets_ips}

Zusätzlich zu Workerknoten und Pods werden auch Teilnetze automatisch in VLANs bereitgestellt. Teilnetze stellen für Ihre Clusterkomponenten Netzkonnektivität bereit, indem sie ihnen IP-Adressen zuordnen.

Folgende Teilnetze werden in den standardmäßigen öffentlichen und privaten VLANs automatisch bereitgestellt:

**Öffentliche VLAN-Teilnetze**
* Durch das primäre öffentliche Teilnetz werden die öffentlichen IP-Adressen festgelegt, die während der Clustererstellung den Workerknoten zugeordnet werden. Mehrere im selben VLAN vorhandene Cluster können ein einziges primäres öffentliches Teilnetz gemeinsam nutzen.
* Das portierbare öffentliche Teilnetz ist nur an einen einzigen Cluster gebunden und stellt dem Cluster acht öffentliche IP-Adressen zur Verfügung. Drei IPs sind für Softlayer-Funktionen reserviert. Eine IP wird von der standardmäßigen öffentlichen Ingress-ALB (ALB – Application Load Balancer, Lastausgleichsfunktion für Anwendungen) verwendet und vier IPs können verwendet werden, um Netzservices für öffentliche Lastausgleichsfunktionen zu erstellen. Portierbare öffentliche IPs sind permanente, feste IP-Adressen, die verwendet werden können, um über das Internet auf Services für Lastausgleichsfunktionen zuzugreifen. Wenn Sie für öffentliche Lastausgleichsfunktionen mehr als vier IPs benötigen, finden Sie Informationen dazu in [Portierbare IP-Adressen hinzufügen](#adding_ips).

**Private VLAN-Teilnetze**
* Durch das primäre private Teilnetz werden die privaten IP-Adressen festgelegt, die während der Clustererstellung den Workerknoten zugeordnet werden. Mehrere im selben VLAN vorhandene Cluster können ein einziges primäres privates Teilnetz gemeinsam nutzen.
* Das portierbare private Teilnetz ist nur an einen einzigen Cluster gebunden und stellt dem Cluster acht private IP-Adressen zur Verfügung. Drei IPs sind für Softlayer-Funktionen reserviert. Eine IP wird von der standardmäßigen privaten Ingress-ALB (ALB – Application Load Balancer, Lastausgleichsfunktion für Anwendungen) verwendet und vier IPs können verwendet werden, um Netzservices für private Lastausgleichsfunktionen zu erstellen. Portierbare private IPs sind permanente, feste IP-Adressen, die verwendet werden können, um über das Internet auf Services für Lastausgleichsfunktionen zuzugreifen. Wenn Sie für private Lastausgleichsfunktionen mehr als vier IPs benötigen, finden Sie Informationen dazu in [Portierbare IP-Adressen hinzufügen](#adding_ips).

Führen Sie `ibmcloud ks subnets` aus, um alle in Ihrem Konto bereitgestellten Teilnetze anzuzeigen. Um die portierbaren öffentlichen und die portierbaren privaten Teilnetze anzuzeigen, die an einen einzigen Cluster gebunden sind, können Sie `ibmcloud ks cluster-get <cluster_name_or_ID> --showResources` ausführen und den Abschnitt für **VLANs von Teilnetzen** suchen.

**Anmerkung**: In {{site.data.keyword.containerlong_notm}} haben VLANs einen Grenzwert von 40 Teilnetzen. Überprüfen Sie bei Erreichen dieses Grenzwerts zunächst, ob Sie [Teilnetze im VLAN wiederverwenden können, um neue Cluster zu erstellen](#custom). Wenn Sie ein neues VLAN benötigen, fordern Sie eines an, indem Sie den [{{site.data.keyword.Bluemix_notm}}-Support kontaktieren](/docs/infrastructure/vlans/order-vlan.html#order-vlans). [Erstellen Sie dann einen Cluster](cs_cli_reference.html#cs_cluster_create), der dieses neue VLAN verwendet.

<br />


## Angepasste oder vorhandene Teilnetze für die Erstellung eines Clusters verwenden
{: #custom}

Wenn Sie einen Standardcluster erstellen, werden Teilnetze automatisch für Sie erstellt. Statt die automatisch bereitgestellten Teilnetze zu verwenden, können Sie jedoch vorhandene portierbare Teilnetze aus Ihrem Konto der IBM Cloud-Infrastruktur (SoftLayer) verwenden oder Teilnetze aus einem gelöschten Cluster wiederverwenden.
{:shortdesc}

Verwenden Sie diese Option, um stabile statische IP-Adressen beizubehalten, obwohl Cluster entfernt oder erstellt werden, oder um größere Blöcke von IP-Adressen zu bestellen.

**Hinweis:** Portierbare öffentliche IP-Adressen werden monatlich berechnet. Wenn Sie nach der Bereitstellung Ihres Clusters portierbare öffentliche IP-Adressen entfernen, müssen Sie trotzdem die monatliche Gebühr bezahlen, auch wenn sie sie nur über einen kurzen Zeitraum genutzt haben.

Vorbereitende Schritte
- [Richten Sie Ihre CLI](cs_cli_install.html#cs_cli_configure) (Befehlszeilenschnittstelle) auf Ihren Cluster aus.
- Wenn Sie Teilnetze aus einem Cluster wiederverwenden möchten, den Sie nicht mehr benötigen, löschen Sie den nicht benötigten Cluster. Erstellen Sie den neuen Cluster sofort, da die Teilnetze innerhalb von 24 Stunden gelöscht werden, wenn Sie sie nicht wiederverwenden.

   ```
   ibmcloud ks cluster-rm <clustername_oder_-id>
   ```
   {: pre}

Gehen Sie wie folgt vor, um ein Teilnetz in Ihrem Portfolio der IBM Cloud-Infrastruktur (SoftLayer) mit angepassten Firewallregeln oder verfügbaren IP-Adressen zu verwenden.

1. Rufen Sie die ID des Teilnetzes ab, das Sie verwenden möchten, und die ID des VLANs, in dem sich das Teilnetz befindet.

    ```
    ibmcloud ks subnets
    ```
    {: pre}

    In dieser Beispielausgabe lautet die Teilnetz-ID `1602829` und die VLAN-ID `2234945`:
    ```
    Getting subnet list...
    OK
    ID        Network             Gateway          VLAN ID   Type      Bound Cluster
    1550165   10.xxx.xx.xxx/26    10.xxx.xx.xxx    2234947   private
    1602829   169.xx.xxx.xxx/28   169.xx.xxx.xxx   2234945   public
    ```
    {: screen}

2. [Erstellen Sie einen Cluster](cs_clusters.html#clusters_cli) mithilfe der VLAN-ID, die Sie angegeben haben. Schließen Sie das Flag `--no-subnet` ein, um zu verhindern, dass ein neues portierbares öffentliches IP-Teilnetz und ein neues portierbares privates IP-Teilnetz automatisch erstellt werden.

    ```
    ibmcloud ks cluster-create --zone dal10 --machine-type b2c.4x16 --no-subnet --public-vlan 2234945 --private-vlan 2234947 --workers 3 --name mein_cluster
    ```
    {: pre}
    Wenn Sie sich nicht erinnern können, in welcher Zone sich das VLAN für das Flag `-- zone` befindet, können Sie überprüfen, ob sich das VLAN in einer bestimmten Zone befindet, indem Sie `ibmcloud ks vlans <zone>` ausführen.
    {: tip}

3.  Überprüfen Sie, dass der Cluster erstellt wurde. **Anmerkung:** Es kann bis zu 15 Minuten dauern, bis die Maschinen mit den Workerknoten angewiesen werden und der Cluster in Ihrem Konto eingerichtet und bereitgestellt wird.

    ```
    ibmcloud ks clusters
    ```
    {: pre}

    Wenn Ihr Cluster vollständig bereitgestellt ist, ändert sich der **Status** in `deployed` (bereitgestellt).

    ```
    Name         ID                                   State      Created          Workers   Zone   Version
    mycluster    aaf97a8843a29941b49a598f516da72101   deployed   20170201162433   3         dal10      1.10.7
    ```
    {: screen}

4.  Überprüfen Sie den Status der Workerknoten.

    ```
    ibmcloud ks workers <clustername_oder_-id>
    ```
    {: pre}

    Bevor Sie mit dem nächsten Schritt fortfahren, müssen die Workerknoten bereit sein. Der **Status** ändert sich in `normal` und der **Status** lautet `Ready` (Bereit).

    ```
    ID                                                  Public IP        Private IP     Machine Type   State      Status   Zone   Version
    prod-dal10-pa8dfcc5223804439c87489886dbbc9c07-w1    169.xx.xxx.xxx   10.xxx.xx.xxx  free           normal     Ready    dal10      1.10.7
    ```
    {: screen}

5.  Fügen Sie Ihrem Cluster das Teilnetz hinzu, indem Sie die Teilnetz-ID angeben. Wenn Sie ein Teilnetz für einen Cluster verfügbar machen, wird eine Kubernetes-Konfigurationszuordnung für Sie erstellt, die alle verfügbaren portierbaren öffentlichen IP-Adressen enthält, die Sie verwenden können. Wenn in der Zone, in der sich das VLAN des Teilnetzes befindet, keine Ingress-ALBs (Lastausgleichsfunktion für Anwendungen) vorhanden sind, wird automatisch eine portierbare öffentliche und eine portierbare private IP-Adresse verwendet, um die öffentlichen und privaten ALBs für diese Zone zu erstellen. Sie können alle anderen portierbaren öffentlichen und privaten IP-Adressen aus dem Teilnetz verwenden, um für Ihre Apps Services für die Lastausgleichsfunktion zu erstellen.

    ```
    ibmcloud ks cluster-subnet-add mycluster 807861
    ```
    {: pre}

6. **Wichtig**: Um die Kommunikation zwischen Workern zu aktivieren, die sich in unterschiedlichen Teilnetzen im selben VLAN befinden, müssen Sie [das Routing zwischen Teilnetzen im selben VLAN aktivieren](#subnet-routing).

<br />


## Vorhandene portierbare IP-Adressen verwalten
{: #managing_ips}

Die vier portierbaren öffentlichen und vier portierbaren privaten IP-Adressen können verwendet werden, um einzelne Apps für das öffentliche oder private Netz verfügbar zu machen, indem Sie einen [Service für die Lastausgleichsfunktion erstellen](cs_loadbalancer.html). Um einen Service für die Lastausgleichsfunktion zu erstellen, muss mindestens eine portierbare IP-Adresse des richtigen Typs für Sie verfügbar sein. Sie können portierbare IP-Adressen anzeigen, die verfügbar sind, oder eine bereits verwendete portierbare IP-Adresse freigeben.

### Verfügbare portierbare öffentliche IP-Adressen anzeigen
{: #review_ip}

Um sowohl verwendete als auch verfügbare portierbare IP-Adressen in Ihrem Cluster aufzulisten, können Sie Folgendes ausführen:

```
kubectl get cm ibm-cloud-provider-vlan-ip-config -n kube-system -o yaml
```
{: pre}

Wenn Sie nur portierbare öffentliche IP-Adressen auflisten möchten, die zum Erstellen von Lastausgleichsfunktionen zur Verfügung stehen, können Sie die folgenden Schritte ausführen:

Bevor Sie beginnen, müssen Sie den [Kontext für den zu verwendenden Cluster festlegen](cs_cli_install.html#cs_cli_configure).

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

    **Hinweis:** Die Erstellung dieses Service schlägt fehl, weil der Kubernetes-Master die angegebene IP-Adresse der Lastausgleichsfunktion in der Kubernetes-Konfigurationszuordnung nicht finden kann. Wenn Sie diesen Befehl ausführen, können Sie die Fehlernachricht und die Liste von verfügbaren öffentlichen IP-Adressen für den Cluster anzeigen.

    ```
    Error on cloud load balancer a8bfa26552e8511e7bee4324285f6a4a for service default/myservice with UID 8bfa2655-2e85-11e7-bee4-324285f6a4af: Requested cloud provider IP 1.1.1.1 is not available. The following cloud provider IP addresses are available: <liste_von_IP-adressen>
    ```
    {: screen}

<br />


### Verwendete IP-Adressen freigeben
{: #free}

Sie können eine bereits verwendete portierbare IP-Adresse freigeben, indem Sie den Lastausgleichsservice löschen, der die portierbare IP-Adresse belegt.
{:shortdesc}

Bevor Sie beginnen, müssen Sie den [Kontext für den zu verwendenden Cluster festlegen](cs_cli_install.html#cs_cli_configure).

1.  Listen Sie verfügbare Services in Ihrem Cluster auf.

    ```
    kubectl get services
    ```
    {: pre}

2.  Entfernen Sie den Lastausgleichsservice, der eine öffentliche oder private IP-Adresse belegt.

    ```
    kubectl delete service <servicename>
    ```
    {: pre}

<br />


## Portierbare IP-Adressen hinzufügen
{: #adding_ips}

Die vier portierbaren öffentlichen und vier portierbaren privaten IP-Adressen können verwendet werden, um einzelne Apps für das öffentliche oder private Netz verfügbar zu machen, indem Sie einen [Service für die Lastausgleichsfunktion erstellen](cs_loadbalancer.html). Wenn Sie mehr als vier öffentliche oder vier private Lastausgleichsfunktionen erstellen möchten, können Sie weitere portierbare IP-Adressen erhalten, indem Sie dem Cluster Netz-Teilnetze hinzufügen.

**Anmerkung:**
* Wenn Sie ein Teilnetz in einem Cluster verfügbar machen, werden IP-Adressen dieses Teilnetzes zum Zweck von Clusternetzen verwendet. Vermeiden Sie IP-Adresskonflikte, indem Sie ein Teilnetz mit nur einem Cluster verwenden. Verwenden Sie kein Teilnetz für mehrere Cluster oder für andere
Zwecke außerhalb von {{site.data.keyword.containerlong_notm}} gleichzeitig.
* Portierbare öffentliche IP-Adressen werden monatlich berechnet. Wenn Sie nach der Bereitstellung Ihres Teilnetzes portierbare öffentliche IP-Adressen entfernen, müssen Sie trotzdem die monatliche Gebühr bezahlen, auch wenn sie sie nur für einen kurzen Zeitraum genutzt haben.

### Portierbare IPs hinzufügen, indem Sie weitere Teilnetze bestellen
{: #request}

Sie können für Services für Lastausgleichsfunktionen weitere portierbare IPs erhalten, indem Sie in einem Konto der IBM Cloud-Infrastruktur (SoftLayer) ein neues Teilnetz erstellen und es für den angegebenen Cluster verfügbar machen.
{:shortdesc}

Führen Sie zunächst den folgenden Schritt aus: [Richten Sie Ihre CLI](cs_cli_install.html#cs_cli_configure) auf Ihren Cluster aus.

1. Stellen Sie ein neues Teilnetz bereit.

    ```
    ibmcloud ks cluster-subnet-create <clustername_oder_-id> <teilnetzgröße> <vlan-id>
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
    <td>Ersetzen Sie <code>&lt;teilnetzgröße&gt;</code> durch die Anzahl von IP-Adressen, die Sie aus Ihrem portierbaren Teilnetz hinzufügen möchten. Gültige Werte sind 8, 16, 32 oder 64. <p>**Hinweis:** Wenn Sie portierbare IP-Adressen für Ihr Teilnetz hinzufügen, werden drei IP-Adressen verwendet, um clusterinterne Netze einzurichten. Diese stehen folglich nicht für Ihre Lastausgleichsfunktionen für Anwendungen oder für das Erstellen eines Lastausgleichsservice bereit. Wenn Sie beispielsweise acht portierbare öffentliche IP-Adressen anfordern, können Sie fünf verwenden, um die Apps öffentlich verfügbar zu machen.</p> </td>
    </tr>
    <tr>
    <td><code><em>&lt;VLAN_ID&gt;</em></code></td>
    <td>Ersetzen Sie <code>&lt;VLAN_ID&gt;</code> durch die ID des öffentlichen oder privaten VLANs, in dem Sie die portierbaren öffentlichen oder privaten IP-Adressen zuweisen möchten. Sie müssen das öffentliche oder private VLAN auswählen, mit dem ein vorhandener Workerknoten verbunden ist. Führen Sie den Befehl <code>ibmcloud ks worker-get &lt;worker-id&gt;</code> aus, um das öffentliche oder private VLAN für einen Workerknoten zu überprüfen. <Das Teilnetz wird in derselben Zone bereitgestellt, in der sich auch das VLAN befindet.</td>
    </tr>
    </tbody></table>

2. Überprüfen Sie, ob das Teilnetz erfolgreich erstellt und zu Ihrem Cluster hinzugefügt wurde. Das Teilnetz-CIDR wird im Abschnitt für **Teilnetz-VLANs** aufgeführt.

    ```
    ibmcloud ks cluster-get --showResources <clustername_oder_-id>
    ```
    {: pre}

    In dieser Beispielausgabe wurde dem öffentlichen VLAN `2234945` ein zweites Teilnetz hinzugefügt:
    ```
    Subnet VLANs
    VLAN ID   Subnet CIDR          Public   User-managed
    2234947   10.xxx.xx.xxx/29     false    false
    2234945   169.xx.xxx.xxx/29    true     false
    2234945   169.xx.xxx.xxx/29    true     false
    ```
    {: screen}

3. **Wichtig**: Um die Kommunikation zwischen Workern zu aktivieren, die sich in unterschiedlichen Teilnetzen im selben VLAN befinden, müssen Sie [das Routing zwischen Teilnetzen im selben VLAN aktivieren](#subnet-routing).

<br />


### Portierbare private IPs unter Verwendung benutzerverwalteter Teilnetze hinzufügen
{: #user_managed}

Sie können für Services für Lastausgleichsfunktionen weitere portierbare private IPs erhalten, indem Sie ein Teilnetz von einem lokalen Netz für Ihren angegebenen Cluster verfügbar machen.
{:shortdesc}

Voraussetzungen:
- Vom Benutzer verwaltete Teilnetze können nur zu privaten VLANs hinzugefügt werden.
- Die Begrenzung für die Länge des Teilnetzpräfix beträgt /24 bis /30. Beispiel: `169.xx.xxx.xxx/24` gibt 253 verwendbare private IP-Adressen an, während `169.xx.xxx.xxx/30` eine verwendbare private IP-Adresse angibt.
- Die erste IP-Adresse im Teilnetz muss als Gateway für das Teilnetz verwendet werden.

Vorbemerkungen:
- Konfigurieren Sie vorab das Routing des Netzverkehrs in das externe Teilnetz bzw. aus dem externen Teilnetz.
- Vergewissern Sie sich, dass Sie über VPN-Konnektivität zwischen dem Netzgateway des lokalen Rechenzentrums und entweder der Virtual Router Appliance des privaten Netzes oder dem aktiven StrongSwan-VPN-Service in Ihrem Cluster verfügen. Weitere Informationen finden Sie unter [VPN-Konnektivität einrichten](cs_vpn.html).

Gehen Sie wie folgt vor, um ein lokales Netz im Unternehmen hinzuzufügen:

1. Zeigen Sie die ID des privaten VLANs Ihres Clusters an. Suchen Sie den Abschnitt für **Teilnetz-VLANs**. Geben Sie im Feld für die Verwaltung durch den Benutzer die VLAN-ID mit _false_ an.

    ```
    ibmcloud ks cluster-get --showResources <clustername>
    ```
    {: pre}

    ```
    Subnet VLANs
  VLAN ID   Subnet CIDR         Public   User-managed
  2234947   10.xxx.xx.xxx/29    false    false
  2234945   169.xx.xxx.xxx/29  true    false
    ```
    {: screen}

2. Fügen Sie das externe Teilnetz zu Ihrem privaten VLAN hinzu. Die portierbaren privaten IP-Adressen werden zur Konfigurationszuordnung des Clusters hinzugefügt.

    ```
    ibmcloud ks cluster-user-subnet-add <clustername> <teilnetz-cidr> <vlan-id>
    ```
    {: pre}

    Beispiel:

    ```
    ibmcloud ks cluster-user-subnet-add mein_cluster 10.xxx.xx.xxx/24 2234947
    ```
    {: pre}

3. Überprüfen Sie, ob das vom Benutzer bereitgestellte Teilnetz hinzugefügt wurde. Das Feld für die Verwaltung durch den Benutzer ist auf _true_ gesetzt.

    ```
    ibmcloud ks cluster-get --showResources <clustername>
    ```
    {: pre}

    In dieser Beispielausgabe wurde dem privaten VLAN `2234947` ein zweites Teilnetz hinzugefügt:
    ```
    Subnet VLANs
    VLAN ID   Subnet CIDR       Public   User-managed
    2234947   10.xxx.xx.xxx/29  false    false
    2234945   169.xx.xxx.xxx/29 true     false
    2234947   10.xxx.xx.xxx/24  false    true
    ```
    {: screen}

4. [Aktivieren Sie das Routing zwischen Teilnetzen im selben VLAN](#subnet-routing).

5. Fügen Sie einen [privaten Service für die Lastausgleichsfunktion](cs_loadbalancer.html) hinzu oder aktivieren Sie die [private Ingress-ALB](cs_ingress.html#private_ingress), um über das private Netz auf Ihre App zuzugreifen. Um eine private IP-Adresse aus dem von Ihnen hinzugefügten Teilnetz zu verwenden, müssen Sie eine IP-Adresse aus dem Teilnetz-CIDR angeben. Andernfalls wird eine IP-Adresse nach dem Zufallsprinzip aus den Teilnetzen von IBM Cloud Infrastructure (SoftLayer) oder aus den vom Benutzer bereitgestellten Teilnetzen im privaten VLAN ausgewählt.

<br />


## Teilnetzrouting aktivieren
{: #subnet-routing}

Wenn Sie über mehrere VLANs für einen Cluster, mehrere Teilnetze in demselben VLAN oder einen Cluster mit mehreren Zonen verfügen, müssen Sie [VLAN-Spanning](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) für Ihr Konto für die IBM Cloud-Infrastruktur (SoftLayer) aktivieren, damit die Workerknoten in dem privaten Netz miteinander kommunizieren können. Um diese Aktion durchführen zu können, müssen Sie über die [Infrastrukturberechtigung](cs_users.html#infra_access) **Netz > VLAN-Spanning im Netz verwalten** verfügen oder Sie können den Kontoeigner bitte, diese zu aktivieren. Um zu prüfen, ob das VLAN-Spanning bereits aktiviert ist, verwenden Sie den [Befehl](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`. Wenn Sie {{site.data.keyword.BluDirectLink}} verwenden, müssen Sie stattdessen eine [ VRF-Funktion (Virtual Router Function)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf) verwenden. Um VRF zu aktivieren, wenden Sie sich an Ihren Ansprechpartner für die IBM Cloud-Infrastruktur (SoftLayer). 

Sehen Sie sich folgende Szenarios an, in denen auch das VLAN-Spanning erforderlich ist.

### Routing zwischen primären Teilnetzen im selben VLAN aktivieren
{: #vlan-spanning}

Wenn Sie einen Cluster erstellen, wird ein Teilnetz, das auf `/26` endet, im standardmäßigen privaten und primären VLAN bereitgestellt. Ein privates primäres Teilnetz kann IPs für bis zu 62 Workerknoten bereitstellen.
{:shortdesc}

Dieser Grenzwert von 62 Workerknoten kann von einem großen Cluster oder von mehreren kleineren Clustern in einer einzigen Region, die sich in demselben VLAN befinden, überschritten werden. Wenn der Grenzwert von 62 Workerknoten erreicht ist, wird ein zweites privates primäres Teilnetz im selben VLAN angefordert.

Um sicherzustellen, dass Worker im selben VLAN in diesen primären Teilnetzen kommunizieren können, müssen Sie das VLAN-Spanning aktivieren. Entsprechende Anweisungen finden Sie in [VLAN-Spanning aktivieren oder inaktivieren](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning).

Um zu prüfen, ob das VLAN-Spanning bereits aktiviert ist, verwenden Sie den [Befehl](cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`.
{: tip}

### Teilnetzrouting für Gateway-Appliance verwalten
{: #vra-routing}

Wenn Sie einen Cluster erstellen, werden ein portierbares öffentliches und ein portierbares privates Teilnetz in den VLANs angefordert, mit denen das Cluster verbunden ist. Diese Teilnetze stellen IP-Adressen für die Netzservices für Ingress und für die Lastausgleichsfunktion bereit.

Wenn Sie jedoch über eine vorhandene Router-Appliance verfügen, wie z. B. eine [Virtual Router Appliance (VRA)](/docs/infrastructure/virtual-router-appliance/about.html#about), werden die neu hinzugefügten portierbaren Teilnetze aus diesen VLANs, mit denen der Cluster verbunden ist, nicht im Router konfiguriert. Um die Netzservices für Ingress und für die Lastausgleichsfunktion zu verwenden, müssen Sie sicherstellen, dass für Netzeinheiten das Routing zwischen verschiedenen Teilnetzen im selben VLAN möglich ist, indem Sie das [VLAN-Spanning aktivieren](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning).

Um zu prüfen, ob das VLAN-Spanning bereits aktiviert ist, verwenden Sie den [Befehl](cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`.
{: tip}
