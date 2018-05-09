---

copyright:
  years: 2014, 2018
lastupdated: "2018-03-13"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# LoadBalancer-Services einrichten
{: #loadbalancer}

Machen Sie einen Port zugänglich und verwenden Sie eine portierbare IP-Adresse für die Lastausgleichsfunktion (Load Balancer), um auf eine containerisierte App zuzugreifen. {:shortdesc}

## Externen Netzbetrieb mit LoadBalancer-Services planen
{: #planning}

Wenn Sie einen Standardcluster erstellen, fordert {{site.data.keyword.containershort_notm}} automatisch fünf portierbare öffentliche IP-Adressen und fünf portierbare private IP-Adressen an und richtet diese bei der Erstellung des Clusters in Ihrem Konto von IBM Cloud Infrastructure (SoftLayer) ein. Zwei der portierbaren IP-Adressen (eine öffentliche und eine private) werden für [Ingress-Lastausgleichsfunktionen für Anwendungen](cs_ingress.html#planning) verwendet. Vier portierbare öffentliche und vier portierbare private IP-Adressen können verwendet werden, um Apps verfügbar zu machen, indem Sie einen LoadBalancer-Service erstellen.

Wenn Sie einen Kubernetes-LoadBalancer-Service in einem Cluster in einem öffentlichen VLAN erstellen, wird eine externe Lastausgleichsfunktion erstellt. Ihre Optionen für IP-Adressen bei Erstellung eines LoadBalancer-Service lauten wie folgt:

- Wenn sich Ihr Cluster in einem öffentlichen VLAN befindet, dann wird eine der vier verfügbaren, portierbaren, öffentlichen IP-Adressen verwendet.
- Wenn Ihr Cluster ausschließlich in einem privaten VLAN verfügbar ist, wird eine der vier verfügbaren, portierbaren, privaten IP-Adressen verwendet.
- Sie können eine portierbare öffentliche oder private IP-Adresse für einen LoadBalancer-Service anfordern, indem Sie eine Annotation zur Konfigurationsdatei hinzufügen: `service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>`.

Die dem LoadBalancer-Service zugewiesene portierbare öffentliche IP-Adresse ist dauerhaft und ändert sich nicht, wenn ein Workerknoten entfernt oder neu erstellt wird. Dadurch bietet der LoadBalancer-Service eine höhere Verfügbarkeit als der NodePort-Service. Anders als bei NodePort-Services können Sie Ihrer Lastausgleichsfunktion jeden beliebigen Port zuweisen und sind dabei nicht an einen bestimmten Portnummernbereich gebunden. Wenn Sie einen LoadBalancer-Service verwenden, steht für jede IP-Adresse aller Workerknoten auch ein Knotenport zur Verfügung. Informationen zum Blockieren des Zugriffs auf den Knotenport während der Nutzung eines LoadBalancer-Service finden Sie in [Eingehenden Datenverkehr blockieren](cs_network_policy.html#block_ingress).

Der LoadBalancer-Service fungiert als externer Einstiegspunkt für eingehende Anforderungen an die App. Um vom Internet aus auf den LoadBalancer-Service zuzugreifen, können Sie die öffentliche IP-Adresse Ihrer Lastausgleichsfunktion in Verbindung mit der zugewiesenen Portnummer im Format `<ip_address>:<port>`. Das folgende Diagramm veranschaulicht, wie eine Lastausgleichsfunktion die Kommunikation vom Internet an eine App leitet:

<img src="images/cs_loadbalancer_planning.png" width="550" alt="Stellen Sie ein App in {{site.data.keyword.containershort_notm}} bereit, indem Sie eine Lastausgleichsfunktion verwenden" style="width:550px; border-style: none"/>

1. Eine Anforderung wird an Ihre App gesendet, indem die öffentliche IP-Adresse Ihrer Lastausgleichsfunktion und der zugeordnete Port auf dem Workerknoten verwendet wird.

2. Die Anforderung wird automatisch an die interne Cluster-IP-Adresse und den internen Port des Service für die Lastausgleichsfunktion weitergeleitet. Auf die interne Cluster-IP-Adresse kann nur aus dem Cluster selbst heraus zugegriffen werden. 

3. `kube-proxy` leitet die Anforderung an den Kubernetes-Service für die Lastausgleichsfunktion für die App weiter. 

4. Die Anforderung wird an die private IP-Adresse des Pods weitergeleitet, auf dem die App bereitgestellt wird. Wenn mehrere App-Instanzen im Cluster bereitgestellt werden, leitet die Lastausgleichsfunktion die Anforderungen zwischen den App-Pods weiter.




<br />




## Zugriff auf eine App mit einer Lastausgleichsfunktion konfigurieren
{: #config}

Vorbemerkungen:

-   Dieses Feature ist nur für Standardcluster verfügbar.
-   Es muss eine portierbare öffentliche oder private IP-Adresse verfügbar sein, die Sie dem Service für die Lastausgleichsfunktion (Load Balancer) zuweisen können.
-   Ein Service für die Lastausgleichsfunktion mit einer portierbaren privaten IP-Adresse verfügt weiterhin auf jedem Workerknoten über einen offenen öffentlichen Knotenport. Informationen zum Hinzufügen einer Netzrichtlinie zur Verhinderung von öffentlichem Datenverkehr finden Sie unter dem Thema [Eingehenden Datenverkehr blockieren](cs_network_policy.html#block_ingress).

Gehen Sie wie folgt vor, um einen Service für die Lastausgleichsfunktion zu erstellen:

1.  [Stellen Sie die App für den Cluster bereit](cs_app.html#app_cli). Wenn Sie dem Cluster die App bereitstellen, wird mindestens ein Pod für Sie erstellt, von dem die App im Container ausgeführt wird. Stellen Sie sicher, dass Sie zur Bereitstellung im Metadatenabschnitt der Konfigurationsdatei eine Bezeichnung hinzufügen. Diese Bezeichnung ist zur Identifizierung aller Pods erforderlich, in denen Ihre App ausgeführt wird, damit sie in den Lastenausgleich aufgenommen werden können.
2.  Erstellen Sie einen Service für die App, den Sie öffentlich zugänglich machen möchten. Damit Ihre App im öffentlichen Internet oder in einem privaten Netz verfügbar wird, müssen Sie einen Kubernetes-Service für die App erstellen. Sie müssen den Service so konfigurieren, dass alle Pods, aus denen die App besteht, in den Lastenausgleich eingeschlossen sind.
    1.  Erstellen Sie eine Servicekonfigurationsdatei namens `myloadbalancer.yaml` (Beispiel).

    2.  Definieren Sie einen Lastenausgleichsservice für die App, die Sie zugänglich machen möchten.
        - Wenn sich Ihr Cluster in einem öffentlichen VLAN befindet, dann wird eine portierbare öffentliche IP-Adresse verwendet. Die meisten Cluster befinden sich in einem öffentlichen VLAN.
        - Wenn Ihr Cluster ausschließlich in einem privaten VLAN verfügbar ist, wird eine portierbare private IP-Adresse verwendet.
        - Sie können eine portierbare öffentliche oder private IP-Adresse für einen LoadBalancer-Service anfordern, indem Sie eine Annotation zur Konfigurationsdatei hinzufügen.

        LoadBalancer-Service, der eine IP-Standardadresse verwendet:

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <mein_service>
        spec:
          type: LoadBalancer
          selector:
            <selektorschlüssel>:<selektorwert>
          ports:
           - protocol: TCP
             port: 8080
        ```
        {: codeblock}

        LoadBalancer-Service, der eine Annotation zur Angabe einer privaten oder öffentlichen IP-Adresse verwendet:

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <mein_service>
          annotations:
            service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <öffentlich_oder_privat>
        spec:
          type: LoadBalancer
          selector:
            <selektorschlüssel>:<selektorwert>
          ports:
           - protocol: TCP
             port: 8080
          loadBalancerIP: <private_ip-adresse>
        ```
        {: codeblock}

        <table>
        <caption>Erklärung der Komponenten der LoadBalancer-Servicedatei</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der YAML-Dateikomponenten</th>
        </thead>
        <tbody>
        <tr>
          <td><code>name</code></td>
          <td>Ersetzen Sie <em>&lt;mein_service&gt;</em> durch den Namen für Ihren Lastenausgleichsservice.</td>
        </tr>
        <tr>
          <td><code>selector</code></td>
          <td>Geben Sie das Paar aus Kennzeichnungsschlüssel (<em>&lt;selektorschlüssel&gt;</em>) und Wert (<em>&lt;selektorwert&gt;</em>) ein, das Sie für die Ausrichtung auf die Pods, in denen Ihre App ausgeführt wird, verwenden möchten. Wenn Sie beispielsweise den Selektor <code>app: code</code> verwenden, werden alle Pods, die diese Bezeichnung in den Metadaten aufweisen, in den Lastausgleich einbezogen. Geben Sie dieselbe Bezeichnung ein, die Sie verwendet haben, als Sie Ihre App dem Cluster bereitgestellt haben. </td>
        </tr>
        <tr>
          <td><code>port</code></td>
          <td>Der Port, den der Service überwacht.</td>
        </tr>
        <tr>
          <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type:`
          <td>Annotation zur Angabe des LoadBalancer-Typs. Die Werte sind `Privat` und `Öffentlich`. Bei der Erstellung eines öffentlichen LoadBalancers in Clustern in öffentlichen VLANs ist diese Annotation nicht erforderlich.</td>
        </tr>
        <tr>
          <td><code>loadBalancerIP</code></td>
          <td>Um eine private Lastausgleichsfunktion zu erstellen oder um eine bestimmte portierbare IP-Adresse für eine öffentliche Lastausgleichsfunktion zu verwenden, ersetzen Sie <em>&lt;loadBalancerIP&gt;</em> durch die IP-Adresse, die Sie verwenden wollen. Weitere Informationen enthält die [Kubernetes-Dokumentation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/concepts/services-networking/service/#type-loadbalancer).</td>
        </tr>
        </tbody></table>

    3.  Optional: Konfigurieren Sie eine Firewall, indem Sie `loadBalancerSourceRanges` im Spezifikationsabschnitt angeben. Weitere Informationen enthält die [Kubernetes-Dokumentation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/).

    4.  Erstellen Sie den Service in Ihrem Cluster.

        ```
        kubectl apply -f myloadbalancer.yaml
        ```
        {: pre}

        Wenn der Lastenausgleichsservice erstellt wird, wird der Lastenausgleichsfunktion automatisch eine portierbare IP-Adresse zugeordnet. Ist keine portierbare IP-Adresse verfügbar, schlägt die Erstellung Ihres Lastenausgleichsservice fehl.

3.  Stellen Sie sicher, dass der Lastenausgleichsservice erstellt wurde. Ersetzen Sie _&lt;mein_service&gt;_ durch den Namen des Lastenausgleichsservice, den Sie im vorherigen Schritt erstellt haben.

    ```
    kubectl describe service <mein_service>
    ```
    {: pre}

    **Hinweis:** Es kann ein paar Minuten dauern, bis der Lastenausgleichsservice ordnungsgemäß erstellt und die App verfügbar ist.

    CLI-Beispielausgabe:

    ```
    Name:                   <mein_service>
    Namespace:              default
    Labels:                 <keine>
    Selector:               <selectorschlüssel>=<selektorwert>
    Type:                   LoadBalancer
    Location:               dal10
    IP:                     10.10.10.90
    LoadBalancer Ingress:   192.168.10.38
    Port:                   <unset> 8080/TCP
    NodePort:               <unset> 32040/TCP
    Endpoints:              172.30.171.87:8080
    Session Affinity:       None
    Events:
    FirstSeen	LastSeen	Count	From			SubObjectPath	Type		Reason			Message
      ---------	--------	-----	----			-------------	--------	------			-------
      10s		10s		1	{service-controller }			Normal		CreatingLoadBalancer	Creating load balancer
      10s		10s		1	{service-controller }			Normal		CreatedLoadBalancer	Created load balancer
    ```
    {: screen}

    Die IP-Adresse für **LoadBalancer Ingress** ist die portierbare IP-Adresse, die dem Lastenausgleichsservice zugeordnet wurde.

4.  Wenn Sie eine öffentliche Lastausgleichsfunktion erstellt haben, dann greifen Sie über das Internet auf Ihre App zu.
    1.  Öffnen Sie Ihren bevorzugten Web-Browser.
    2.  Geben Sie die portierbare öffentliche IP-Adresse der Lastausgleichsfunktion und des Ports ein. Im obigen Beispiel wurde dem Service für die Lastausgleichsfunktion die portierbare öffentliche IP-Adresse `192.168.10.38` zugeordnet.

        ```
        http://192.168.10.38:8080
        ```
        {: codeblock}
