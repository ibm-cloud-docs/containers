---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

keywords: kubernetes, iks, lb2.0, nlb

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



# NLB der Version 2.0 (Beta) einrichten
{: #loadbalancer-v2}

Machen Sie einen Port zugänglich und verwenden Sie eine portierbare IP-Adresse für die Layer 4-Netzlastausgleichsfunktion (NLB), um eine containerisierte App zugänglich zu machen. Weitere Informationen zu NLBs der Version 2.0 finden Sie unter [Komponenten und Architektur eines NLB der Version 2.0](/docs/containers?topic=containers-loadbalancer-about#planning_ipvs).
{:shortdesc}

## Voraussetzungen
{: #ipvs_provision}

Sie können eine vorhandene NLB der Version 1.0 nicht auf eine Lastausgleichsfunktion der Version 2.0 aktualisieren. Sie müssen eine neue NLB mit der Version 2.0 erstellen. Beachten Sie, dass Sie NLBs der Version 1.0 und 2.0 gleichzeitig in einem Cluster ausführen können.
{: shortdesc}

Bevor Sie eine NLB der Version 2.0 erstellen, müssen Sie die folgenden vorausgesetzten Schritte ausführen.

1. [Aktualisieren Sie die Master- und Workerknoten Ihres Clusters](/docs/containers?topic=containers-update) auf Kubernetes Version 1.12 oder höher.

2. Damit Ihre NLB der Version 2.0 Anforderungen an App-Pods in mehreren Zonen weiterleiten kann, öffnen Sie einen Supportfall, um eine Kapazitätsaggregation für Ihre VLANs anzufordern. Diese Konfigurationseinstellung verursacht keine Netzfehler oder -ausfälle.
    1. Melden Sie sich bei der [{{site.data.keyword.cloud_notm}}-Konsole](https://cloud.ibm.com/) an.
    2. Klicken Sie in der Menüleiste auf **Support**, klicken Sie auf die Registerkarte **Fälle verwalten** und klicken Sie auf **Neuen Fall erstellen**.
    3. Geben Sie in die Fallfelder die folgenden Informationen ein:
       * Wählen Sie für den Typ von Support die Option **Technisch** aus.
       * Wählen Sie für die Kategorie die Option **VLAN Spanning** aus.
       * Geben Sie den Betreff **Frage zu öffentlichem und privatem VLAN-Netz** ein.
    4. Fügen Sie die folgenden Informationen zur Beschreibung hinzu: "Konfigurieren Sie das Netz bitte so, dass eine Kapazitätsaggregation in den öffentlichen und privaten VLANs, die diesem Konto zugeordnet sind, zulässig ist. Das Referenzticket für diese Anforderung lautet: https://control.softlayer.com/support/tickets/63859145". Wenn Sie die Kapazitätsaggregation für bestimmte VLANs erlauben wollen, z. B. die öffentlichen VLANs für nur einen Cluster, können Sie diese VLAN-IDs in der Beschreibung angeben.
    5. Klicken Sie auf **Übergeben**.

3. Aktivieren Sie eine [VRF-Funktion (Virtual Router Function)](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud) für Ihr IBM Cloud-Infrastrukturkonto. Zur Aktivierung von VRF [wenden Sie sich an Ihren Ansprechpartner für die IBM Cloud-Infrastruktur](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#how-you-can-initiate-the-conversion). Zum Prüfen, ob VRF bereits aktiviert ist, verwenden Sie den Befehl `ibmcloud account show`. Wenn Sie VRF nicht aktivieren können oder wollen, aktivieren Sie das [VLAN-Spanning](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning). Wenn VRF- oder VLAN-Spanning aktiviert ist, kann die NLB der Version 2.0 Pakete an verschiedene Teilnetz im Konto weiterleiten.

4. Wenn Sie [Calico-Netzrichtlinien des Typs 'Pre-DNAT'](/docs/containers?topic=containers-network_policies#block_ingress) verwenden, um Datenverkehr an die IP-Adresse einer NLB der Version 2.0 weiterzuleiten, müssen Sie die Felder `applyOnForward: true` und `doNotTrack: true` dem Abschnitt `spec` in den Richtlinien hinzufügen und das Feld `preDNAT: true` daraus entfernen. `applyOnForward: true` stellt sicher, dass die Calico-Richtlinie beim Einschließen und Weiterleiten auf den Datenverkehr angewendet wird. `doNotTrack: true` stellt sicher, dass die Workerknoten DSR verwenden können, um ein Antwortpaket direkt an den Client zurückzugeben, ohne dass die Verbindung verfolgt werden muss. Wenn Sie beispielsweise eine Calico-Richtlinie verwenden, um Datenverkehr von nur einer spezifischen IP-Adresse an die NLB-IP-Adresse in eine Whitelist zu schreiben, sieht die Richtlinie wie folgt aus:
    ```
    apiVersion: projectcalico.org/v3
    kind: GlobalNetworkPolicy
    metadata:
      name: whitelist
    spec:
      applyOnForward: true
      doNotTrack: true
      ingress:
      - action: Allow
        destination:
          nets:
          - <ip_der_lastausgleichsfunktion>/32
          ports:
          - 80
        protocol: TCP
        source:
          nets:
          - <clientadresse>/32
      selector: ibm.role=='worker_public'
      order: 500
      types:
      - Ingress
    ```
    {: screen}

Jetzt können Sie die Schritte unter [NLB der Version 2.0 in einem Mehrzonencluster konfigurieren](#ipvs_multi_zone_config) bzw. [in einem Einzelzonencluster konfigurieren](#ipvs_single_zone_config) ausführen.

<br />


## NLB der Version 2.0 in einem Mehrzonencluster konfigurieren
{: #ipvs_multi_zone_config}

**Vorbereitende Schritte**:

* **Wichtig**: Erfüllen Sie die [Voraussetzungen für die NLB der Version 2.0](#ipvs_provision).
* Um öffentliche NLBs in mehreren Zonen zu erstellen, muss mindestens ein öffentliches VLAN portierbare Teilnetze aufweisen, die in jeder Zone verfügbar sind. Um private NLBs in mehreren Zonen zu erstellen, muss mindestens ein privates VLAN portierbare Teilnetze aufweisen, die in jeder Zone verfügbar sind. Sie können Teilnetze hinzufügen, indem Sie die Schritte im Abschnitt [Teilnetze für Cluster konfigurieren](/docs/containers?topic=containers-subnets) ausführen.
* Wenn Sie den Datenaustausch im Netz auf Edge-Workerknoten beschränken, müssen Sie sicherstellen, dass in jeder Zone mindestens zwei [Edge-Workerknoten](/docs/containers?topic=containers-edge#edge) aktiviert sind, sodass NLBs gleichmäßig bereitgestellt werden können.
* Stellen Sie sicher, dass Sie die [{{site.data.keyword.cloud_notm}} IAM-Servicerolle **Schreibberechtigter** oder **Manager**](/docs/containers?topic=containers-users#platform) für den Namensbereich `default` innehaben.


Gehen Sie wie folgt vor, um eine NLB der Version 2.0 in einem Mehrzonencluster einzurichten:
1.  [Stellen Sie die App für den Cluster bereit](/docs/containers?topic=containers-app#app_cli). Stellen Sie sicher, dass Sie zur Bereitstellung im Metadatenabschnitt der Konfigurationsdatei eine Bezeichnung hinzufügen. Diese Bezeichnung ist zur Identifizierung aller Pods erforderlich, in denen Ihre App ausgeführt wird, damit sie in den Lastenausgleich aufgenommen werden können.

2.  Erstellen Sie einen Lastausgleichsservice für die App, die Sie über das öffentliche Internet oder ein privates Netz zugänglich machen wollen.
  1. Erstellen Sie eine Servicekonfigurationsdatei namens `myloadbalancer.yaml` (Beispiel).
  2. Definieren Sie einen Lastausgleichsservice für die App, die Sie zugänglich machen möchten. Sie können eine Zone, ein VLAN und eine IP-Adresse angeben.

      ```
      apiVersion: v1
      kind: Service
      metadata:
        name: myloadbalancer
        annotations:
          service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_oder_private>
          service.kubernetes.io/ibm-load-balancer-cloud-provider-zone: "<zone>"
          service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan: "<vlan-id>"
          service.kubernetes.io/ibm-load-balancer-cloud-provider-enable-features: "ipvs"
          service.kubernetes.io/ibm-load-balancer-cloud-provider-scheduler: "<algorithmus>"
      spec:
        type: LoadBalancer
        selector:
          <selektorschlüssel>: <selektorwert>
        ports:
         - protocol: TCP
           port: 8080
        loadBalancerIP: <ip-adresse>
        externalTrafficPolicy: Local
      ```
      {: codeblock}

      <table>
      <caption>Erklärung der Komponenten der YAML-Datei</caption>
      <thead>
      <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der YAML-Dateikomponenten</th>
      </thead>
      <tbody>
      <tr>
        <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type:</code>
        <td>Annotation zum Angeben des Typs einer Lastausgleichsfunktion: <code>private</code> oder <code>public</code>.</td>
      </tr>
      <tr>
        <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-zone:</code>
        <td>Annotation zum Angeben der Zone, in der der Lastausgleichsservice bereitgestellt wird. Um Zonen anzuzeigen, führen Sie den Befehl <code>ibmcloud ks zones</code> aus.</td>
      </tr>
      <tr>
        <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan:`
        <td>Annotation zum Angeben eines VLAN, in dem der Lastausgleichsservice bereitgestellt wird. Um VLANs anzuzeigen, führen Sie <code>ibmcloud ks vlans --zone <zone></code> aus.</td>
      </tr>
      <tr>
        <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-enable-features: "ipvs"</code>
        <td>Annotation zum Angeben einer Lastausgleichsfunktion der Version 2.0.</td>
      </tr>
      <tr>
        <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-scheduler:</code>
        <td>Optional: Annotation zum Angeben eines Planungsalgorithmus. Akzeptierte Werte sind <code>"rr"</code> für Round Robin (Standard) oder <code>"sh"</code> für Source Hashing. Weitere Informationen finden Sie unter [v2.0: Planungsalgorithmen](#scheduling).</td>
      </tr>
      <tr>
        <td><code>selector</code></td>
        <td>Der Bezeichnungsschlüssel (<em>&lt;selektorschlüssel&gt;</em>) und der Wert (<em>&lt;selektorwert&gt;</em>), den Sie im Abschnitt <code>spec.template.metadata.labels</code> der YAML-Bereitstellungsdatei für Ihre App verwendet haben.</td>
      </tr>
      <tr>
        <td><code>port</code></td>
        <td>Der Port, den der Service überwacht.</td>
      </tr>
      <tr>
        <td><code>loadBalancerIP</code></td>
        <td>Optional: Um eine private NLB zu erstellen oder um eine bestimmte portierbare IP-Adresse für eine öffentliche NLB zu verwenden, geben Sie die IP-Adresse an, die Sie verwenden wollen. Die IP-Adresse muss sich in der Zone und dem VLAN befinden, die Sie in den Annotationen angeben. Wenn Sie keine IP-Adresse angeben, geschieht Folgendes:<ul><li>Wenn sich Ihr Cluster in einem öffentlichen VLAN befindet, dann wird eine portierbare öffentliche IP-Adresse verwendet. Die meisten Cluster befinden sich in einem öffentlichen VLAN.</li><li>Wenn sich Ihr Cluster nur in einem privaten VLAN befindet, wird eine portierbare private IP-Adresse verwendet.</li></ul></td>
      </tr>
      <tr>
        <td><code>externalTrafficPolicy: Local</code></td>
        <td>Setzen Sie dies auf <code>Local</code>.</td>
      </tr>
      </tbody></table>

      Beispielkonfigurationsdatei zum Erstellen eines NLB-Service der Version 2.0 in `dal12`, die den Round Robin-Planungsalgorithmus verwendet.

      ```
      apiVersion: v1
      kind: Service
      metadata:
        name: myloadbalancer
        annotations:
          service.kubernetes.io/ibm-load-balancer-cloud-provider-zone: "dal12"
          service.kubernetes.io/ibm-load-balancer-cloud-provider-enable-features: "ipvs"
          service.kubernetes.io/ibm-load-balancer-cloud-provider-scheduler: "rr"
      spec:
        type: LoadBalancer
        selector:
          app: nginx
        ports:
         - protocol: TCP
           port: 8080
        externalTrafficPolicy: Local
      ```
      {: codeblock}

  3. Optional: Stellen Sie sicher, dass Ihre NLB nur für einen begrenzten Bereich von IP-Adressen verfügbar ist, indem Sie die IP-Adressen im Feld `spec.loadBalancerSourceRanges` angeben.  `loadBalancerSourceRanges` wird von `kube-proxy` in Ihrem Cluster durch Iptables-Regeln auf Workerknoten implementiert. Weitere Informationen enthält die [Kubernetes-Dokumentation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/).

  4. Erstellen Sie den Service in Ihrem Cluster.

      ```
      kubectl apply -f myloadbalancer.yaml
      ```
      {: pre}

3. Stellen Sie sicher, dass der NLB-Service erfolgreich erstellt wurde. Es kann einige Minuten dauern, bis der NLB-Service ordnungsgemäß erstellt wurde und die App verfügbar ist.

    ```
    kubectl describe service myloadbalancer
    ```
    {: pre}

    CLI-Beispielausgabe:

    ```
    Name:                   myloadbalancer
    Namespace:              default
    Labels:                 <none>
    Selector:               app=liberty
    Type:                   LoadBalancer
    Zone:                   dal10
    IP:                     172.21.xxx.xxx
    LoadBalancer Ingress:   169.xx.xxx.xxx
    Port:                   <unset> 8080/TCP
    NodePort:               <unset> 32040/TCP
    Endpoints:              172.30.xxx.xxx:8080
    Session Affinity:       None
    Events:
      FirstSeen	LastSeen	Count	From			SubObjectPath	Type	 Reason			          Message
      ---------	--------	-----	----			-------------	----	 ------			          -------
      10s		    10s		    1	    {service-controller }	  Normal CreatingLoadBalancer	Creating load balancer
      10s		    10s		    1	    {service-controller }		Normal CreatedLoadBalancer	Created load balancer
    ```
    {: screen}

    Die IP-Adresse für **LoadBalancer Ingress** ist die portierbare IP-Adresse, die dem NLB-Service zugewiesen wurde.

4.  Wenn Sie eine öffentliche NLB erstellt haben, dann greifen Sie über das Internet auf Ihre App zu.
    1.  Öffnen Sie Ihren bevorzugten Web-Browser.
    2.  Geben Sie die portierbare öffentliche IP-Adresse der NLB und des Ports ein.

        ```
        http://169.xx.xxx.xxx:8080
        ```
        {: codeblock}

5. Um eine hohe Verfügbarkeit zu erreichen, wiederholen Sie die Schritte 2 bis 4, um eine NLB der Version 2.0 in jeder Zone bereitstellen, in der sich App-Instanzen befinden.

6. Optional: Ein NLB-Service macht Ihre App auch über die NodePort-Instanzen des Service verfügbar. Auf [Knotenports (NodePorts)](/docs/containers?topic=containers-nodeport) kann über jede öffentliche und private IP-Adresse für jeden Knoten innerhalb des Clusters zugegriffen werden. Informationen zum Blockieren des Datenverkehrs an Knotenports während der Verwendung eines NLB-Service finden Sie im Abschnitt [Eingehenden Datenverkehr an Netzlastausgleichsfunktion (NLB) oder NodePort-Services steuern](/docs/containers?topic=containers-network_policies#block_ingress).

Als Nächstes können Sie [einen NLB-Hostnamen registrieren](/docs/containers?topic=containers-loadbalancer_hostname).

<br />


## NLB der Version 2.0 in einem Einzelzonencluster konfigurieren
{: #ipvs_single_zone_config}

**Vorbereitende Schritte**:

* **Wichtig**: Erfüllen Sie die [Voraussetzungen für die NLB der Version 2.0](#ipvs_provision).
* Es muss eine portierbare öffentliche oder private IP-Adresse verfügbar sein, die dem NLB-Service zugewiesen werden kann. Weitere Informationen finden Sie unter [Teilnetze für Cluster konfigurieren](/docs/containers?topic=containers-subnets).
* Stellen Sie sicher, dass Sie die [{{site.data.keyword.cloud_notm}} IAM-Servicerolle **Schreibberechtigter** oder **Manager**](/docs/containers?topic=containers-users#platform) für den Namensbereich `default` innehaben.

Gehen Sie wie folgt vor, um einen NLB-Service der Version 2.0 in einem Einzelzonencluster zu erstellen:

1.  [Stellen Sie die App für den Cluster bereit](/docs/containers?topic=containers-app#app_cli). Stellen Sie sicher, dass Sie zur Bereitstellung im Metadatenabschnitt der Konfigurationsdatei eine Bezeichnung hinzufügen. Diese Bezeichnung ist zur Identifizierung aller Pods erforderlich, in denen Ihre App ausgeführt wird, damit sie in den Lastenausgleich aufgenommen werden können.
2.  Erstellen Sie einen Lastausgleichsservice für die App, die Sie über das öffentliche Internet oder ein privates Netz zugänglich machen wollen.
    1.  Erstellen Sie eine Servicekonfigurationsdatei namens `myloadbalancer.yaml` (Beispiel).

    2.  Definieren Sie einen Lastausgleichsservice der Version 2.0 für die App, die Sie zugänglich machen möchten.
        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: myloadbalancer
          annotations:
            service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_oder_private>
            service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan: "<vlan-id>"
            service.kubernetes.io/ibm-load-balancer-cloud-provider-enable-features: "ipvs"
            service.kubernetes.io/ibm-load-balancer-cloud-provider-scheduler: "<algorithmus>"
        spec:
          type: LoadBalancer
          selector:
            <selektorschlüssel>: <selektorwert>
          ports:
           - protocol: TCP
           port: 8080
        loadBalancerIP: <ip-adresse>
        externalTrafficPolicy: Local
        ```
        {: codeblock}

        <table>
        <caption>Erklärung der Komponenten der YAML-Datei</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der YAML-Dateikomponenten</th>
        </thead>
        <tbody>
        <tr>
          <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type:`
          <td>Annotation zum Angeben des Typs einer Lastausgleichsfunktion: <code>private</code> oder <code>public</code>.</td>
        </tr>
        <tr>
          <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan:`
          <td>Optional: Annotation zum Angeben eines VLAN, in dem der Lastausgleichsservice bereitgestellt wird. Um VLANs anzuzeigen, führen Sie <code>ibmcloud ks vlans --zone <zone></code> aus.</td>
        </tr>
        <tr>
          <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-enable-features: "ipvs"</code>
          <td>Annotation zum Angeben einer Lastausgleichsfunktion der Version 2.0.</td>
        </tr>
        <tr>
          <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-scheduler:</code>
          <td>Optional: Annotation zum Angeben eines Planungsalgorithmus. Akzeptierte Werte sind <code>"rr"</code> für Round Robin (Standard) oder <code>"sh"</code> für Source Hashing. Weitere Informationen finden Sie unter [v2.0: Planungsalgorithmen](#scheduling).</td>
        </tr>
        <tr>
          <td><code>selector</code></td>
          <td>Der Bezeichnungsschlüssel (<em>&lt;selektorschlüssel&gt;</em>) und der Wert (<em>&lt;selektorwert&gt;</em>), den Sie im Abschnitt <code>spec.template.metadata.labels</code> der YAML-Bereitstellungsdatei für Ihre App verwendet haben.</td>
        </tr>
        <tr>
          <td><code>port</code></td>
          <td>Der Port, den der Service überwacht.</td>
        </tr>
        <tr>
          <td><code>loadBalancerIP</code></td>
          <td>Optional: Um eine private NLB zu erstellen oder um eine bestimmte portierbare IP-Adresse für eine öffentliche NLB zu verwenden, geben Sie die IP-Adresse an, die Sie verwenden wollen. Die IP-Adresse muss sich in dem VLAN befinden, das Sie in den Annotationen angeben. Wenn Sie keine IP-Adresse angeben, geschieht Folgendes:<ul><li>Wenn sich Ihr Cluster in einem öffentlichen VLAN befindet, dann wird eine portierbare öffentliche IP-Adresse verwendet. Die meisten Cluster befinden sich in einem öffentlichen VLAN.</li><li>Wenn sich Ihr Cluster nur in einem privaten VLAN befindet, wird eine portierbare private IP-Adresse verwendet.</li></ul></td>
        </tr>
        <tr>
          <td><code>externalTrafficPolicy: Local</code></td>
          <td>Setzen Sie dies auf <code>Local</code>.</td>
        </tr>
        </tbody></table>

    3.  Optional: Stellen Sie sicher, dass Ihre NLB nur für einen begrenzten Bereich von IP-Adressen verfügbar ist, indem Sie die IP-Adressen im Feld `spec.loadBalancerSourceRanges` angeben. `loadBalancerSourceRanges` wird von `kube-proxy` in Ihrem Cluster durch Iptables-Regeln auf Workerknoten implementiert. Weitere Informationen enthält die [Kubernetes-Dokumentation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/).

    4.  Erstellen Sie den Service in Ihrem Cluster.

        ```
        kubectl apply -f myloadbalancer.yaml
        ```
        {: pre}

3.  Stellen Sie sicher, dass der NLB-Service erfolgreich erstellt wurde. Es kann ein paar Minuten dauern, bis der Service erstellt wurde und die App verfügbar ist.

    ```
    kubectl describe service myloadbalancer
    ```
    {: pre}

    CLI-Beispielausgabe:

    ```
    Name:                   myloadbalancer
    Namespace:              default
    Labels:                 <none>
    Selector:               app=liberty
    Type:                   LoadBalancer
    Location:               dal10
    IP:                     172.21.xxx.xxx
    LoadBalancer Ingress:   169.xx.xxx.xxx
    Port:                   <unset> 8080/TCP
    NodePort:               <unset> 32040/TCP
    Endpoints:              172.30.xxx.xxx:8080
    Session Affinity:       None
    Events:
      FirstSeen	LastSeen	Count	From			SubObjectPath	Type	 Reason			          Message
      ---------	--------	-----	----			-------------	----	 ------			          -------
      10s		    10s		    1	    {service-controller }	  Normal CreatingLoadBalancer	Creating load balancer
      10s		    10s		    1	    {service-controller }		Normal CreatedLoadBalancer	Created load balancer
    ```
    {: screen}

    Die IP-Adresse für **LoadBalancer Ingress** ist die portierbare IP-Adresse, die dem NLB-Service zugewiesen wurde.

4.  Wenn Sie eine öffentliche NLB erstellt haben, dann greifen Sie über das Internet auf Ihre App zu.
    1.  Öffnen Sie Ihren bevorzugten Web-Browser.
    2.  Geben Sie die portierbare öffentliche IP-Adresse der NLB und des Ports ein.

        ```
        http://169.xx.xxx.xxx:8080
        ```
        {: codeblock}

5. Optional: Ein NLB-Service macht Ihre App auch über die NodePort-Instanzen des Service verfügbar. Auf [Knotenports (NodePorts)](/docs/containers?topic=containers-nodeport) kann über jede öffentliche und private IP-Adresse für jeden Knoten innerhalb des Clusters zugegriffen werden. Informationen zum Blockieren des Datenverkehrs an Knotenports während der Verwendung eines NLB-Service finden Sie im Abschnitt [Eingehenden Datenverkehr an Netzlastausgleichsfunktion (NLB) oder NodePort-Services steuern](/docs/containers?topic=containers-network_policies#block_ingress).

Als Nächstes können Sie [einen NLB-Hostnamen registrieren](/docs/containers?topic=containers-loadbalancer_hostname).

<br />


## Planungsalgorithmen
{: #scheduling}

Planungsalgorithmen bestimmen, wie eine NLB der Version 2.0 Ihren App-Pods Netzverbindungen zuordnet. Wenn Clientanforderungen in Ihrem Cluster eingehen, leitet die NLB die Anforderungspakete auf der Basis des Planungsalgorithmus an Workerknoten weiter. Um einen Planungsalgorithmus zu verwenden, geben Sie den zugehörigen Keepalived-Kurznamen in der Planungsannotation der Konfigurationsdatei Ihres NLB-Service an: `service.kubernetes.io/ibm-load-balancer-cloud-provider-scheduler: "rr"`. In der folgenden Liste finden Sie die Planungsalgorithmen, die in {{site.data.keyword.containerlong_notm}} unterstützt werden. Wenn Sie keinen Planungsalgorithmus angeben, wird der Round-Robin-Algorithmus standardmäßig verwendet. Weitere Informationen finden Sie in der [Keepalived-Dokumentation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](http://www.Keepalived.org/doc/scheduling_algorithms.html).
{: shortdesc}

### Unterstützte Planungsalgorithmen
{: #scheduling_supported}

<dl>
<dt>Round Robin (<code>rr</code>)</dt>
<dd>Die NLB durchläuft zyklisch die Liste von App-Pods, wenn Verbindungen an Workerknoten weitergeleitet werden, wobei jeder App-Pod gleich behandelt wird. Round Robin ist der Standardplanungsalgorithmus für NLBs der Version 2.0.</dd>
<dt>Source Hashing (<code>sh</code>)</dt>
<dd>Die NLB generiert einen Hashschlüssel basierend auf der Quellen-IP-Adresse des Clientanforderungspakets. Anschließend sucht die NLB den Hashschlüssel in einer statisch zugeordneten Hashtabelle und leitet die Anforderung an den App-Pod weiter, der die Hashes dieses Bereichs verarbeitet. Dieser Algorithmus stellt sicher, dass Anforderungen von einem bestimmten Client immer an denselben App-Pod übertragen werden.</br>**Note**: Kubernetes verwendet 'iptables'-Regeln, die dafür sorgen, dass Anforderungen an einen zufälligen Pod auf dem Worker gesendet werden. Um diesen Planungsalgorithmus zu verwenden, müssen Sie sicherstellen, dass pro Workerknoten nicht mehr als ein Pod Ihrer App bereitgestellt wird. Beispiel: Wenn alle Pods die Bezeichnung <code>run=&lt;app_name&gt;</code>, haben, fügen Sie die folgende Anti-Affinitäts-Regel zum Abschnitt <code>spec</code> Ihrer App-Bereitstellung hinzu:</br>
<pre class="codeblock">
<code>
    spec:
      affinity:
        podAntiAffinity:
          preferredDuringSchedulingIgnoredDuringExecution:
          - weight: 100
        podAffinityTerm:
          labelSelector:
            matchExpressions:
                - key: run
                  operator: In
                  values:
                  - <APP_NAME>
              topologyKey: kubernetes.io/hostname</code></pre>

Sie finden das vollständige Beispiel in [diesem Blog zu IBM Cloud-Bereitstellungsmustern ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/blogs/bluemix/2018/10/ibm-cloud-kubernetes-service-deployment-patterns-4-multi-zone-cluster-app-exposed-via-loadbalancer-aggregating-whole-region-capacity/).</dd>
</dl>

### Nicht unterstützte Planungsalgorithmen
{: #scheduling_unsupported}

<dl>
<dt>Destination Hashing (<code>dh</code>)</dt>
<dd>Das Ziel des Pakets, d. h. die IP-Adresse und der Port der NLB, wird verwendet, um zu bestimmen, welcher Workerknoten die eingehende Anforderung verarbeitet. Allerdings ändern sich die IP-Adresse und der Port für NLBs in {{site.data.keyword.containerlong_notm}} nicht. Die NLB ist gezwungen, die Anforderung innerhalb desselben Workerknotens zu behalten, auf dem sie sich befindet, sodass nur die App-Pods eines einzelnen Workerknotens alle eingehenden Anforderungen verarbeiten.</dd>
<dt>Dynamische Verbindungszählalgorithmen</dt>
<dd>Die folgenden Algorithmen sind von der dynamischen Zählung der Verbindungen zwischen Clients und NLBs abhängig. Da DSR (Direct Service Return) jedoch verhindert, dass Pods von NLBs der Version 2.0 im Rückgabepaketpfad vorhanden sind, verfolgen NLBs keine eingerichteten Verbindungen.<ul>
<li>Least Connection (<code>lc</code>)</li>
<li>Locality-Based Least Connection (<code>lblc</code>)</li>
<li>Locality-Based Least Connection with Replication (<code>lblcr</code>)</li>
<li>Never Queue (<code>nq</code>)</li>
<li>Shortest Expected Delay (<code>seq</code>)</li></ul></dd>
<dt>Gewichtete Pod-Algorithmen</dt>
<dd>Die folgenden Algorithmen hängen von gewichteten App-Pods ab. In {{site.data.keyword.containerlong_notm}} haben aber alle App-Pods dieselbe Gewichtung für den Lastausgleich.<ul>
<li>Weighted Least Connection (<code>wlc</code>)</li>
<li>Weighted Round Robin (<code>wrr</code>)</li></ul></dd></dl>
