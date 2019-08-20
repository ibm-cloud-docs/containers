---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

keywords: kubernetes, iks, lb1.0, nlb

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


# NLB der Version 1.0 einrichten
{: #loadbalancer}

Machen Sie einen Port zugänglich und verwenden Sie eine portierbare IP-Adresse für die Layer 4-Netzlastausgleichsfunktion (NLB), um eine containerisierte App zugänglich zu machen. Weitere Informationen zu NLBs der Version 1.0 finden Sie unter [Komponenten und Architektur eines NLB der Version 1.0](/docs/containers?topic=containers-loadbalancer-about#v1_planning).
{:shortdesc}

Für einen schnellen Einstieg können Sie den folgenden Befehl ausführen, mit dem eine Lastausgleichsfunktion 1.0 erstellt wird:
```
kubectl expose deploy my-app --port=80 --target-port=8080 --type=LoadBalancer --name my-lb-svc
```
{: pre}

## NLB der Version 1.0 in einem Mehrzonencluster konfigurieren
{: #multi_zone_config}

**Vorbereitende Schritte**:
* Um öffentliche Netzlastausgleichsfunktionen in mehreren Zonen zu erstellen, muss mindestens ein öffentliches VLAN portierbare Teilnetze aufweisen, die in jeder Zone verfügbar sind. Um private NLBs in mehreren Zonen zu erstellen, muss mindestens ein privates VLAN portierbare Teilnetze aufweisen, die in jeder Zone verfügbar sind. Sie können Teilnetze hinzufügen, indem Sie die Schritte im Abschnitt [Teilnetze für Cluster konfigurieren](/docs/containers?topic=containers-subnets) ausführen.
* Wenn Sie den Datenaustausch im Netz auf Edge-Workerknoten beschränken, müssen Sie sicherstellen, dass in jeder Zone mindestens zwei [Edge-Workerknoten](/docs/containers?topic=containers-edge#edge) aktiviert sind, sodass NLBs gleichmäßig bereitgestellt werden können.
* Aktivieren Sie [VLAN-Spanning](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning) für Ihr IBM Cloud-Infrastrukturkonto, damit die Workerknoten in dem privaten Netz miteinander kommunizieren können. Um diese Aktion durchführen zu können, müssen Sie über die [Infrastrukturberechtigung](/docs/containers?topic=containers-users#infra_access) **Netz > VLAN-Spanning im Netz verwalten** verfügen oder Sie können den Kontoeigner bitten, diese zu aktivieren. Zum Prüfen, ob das VLAN-Spanning bereits aktiviert ist, verwenden Sie den [Befehl](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get --region <region>`.
* Stellen Sie sicher, dass Sie die [{{site.data.keyword.cloud_notm}} IAM-Servicerolle **Schreibberechtigter** oder **Manager**](/docs/containers?topic=containers-users#platform) für den Namensbereich `default` innehaben.


Gehen Sie wie folgt vor, um eine NLB der Version 1.0 in einem Mehrzonencluster einzurichten:
1.  [Stellen Sie die App für den Cluster bereit](/docs/containers?topic=containers-app#app_cli). Stellen Sie sicher, dass Sie im Metadatenabschnitt der Konfigurationsdatei für die Bereitstellung eine Bezeichnung hinzufügen. Diese Bezeichnung ist zur Identifizierung aller Pods erforderlich, in denen Ihre App ausgeführt wird, damit sie in den Lastenausgleich aufgenommen werden können.

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
      spec:
        type: LoadBalancer
        selector:
          <selektorschlüssel>: <selektorwert>
        ports:
         - protocol: TCP
             port: 8080
          loadBalancerIP: <ip-adresse>
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
        <td><code>selector</code></td>
        <td>Der Bezeichnungsschlüssel (<em>&lt;selektorschlüssel&gt;</em>) und der Wert (<em>&lt;selektorwert&gt;</em>), den Sie im Abschnitt <code>spec.template.metadata.labels</code> der YAML-Bereitstellungsdatei für Ihre App verwendet haben.</td>
      </tr>
      <tr>
        <td><code>port</code></td>
        <td>Der Port, den der Service überwacht.</td>
      </tr>
      <tr>
        <td><code>loadBalancerIP</code></td>
        <td>Optional: Um eine private Lastausgleichsfunktion zu erstellen oder um eine bestimmte portierbare IP-Adresse für eine öffentliche Lastausgleichsfunktion zu verwenden, geben Sie die IP-Adresse an, die Sie verwenden wollen. Die IP-Adresse muss sich in dem VLAN und in der Zone befinden, die Sie in den Annotationen angeben. Wenn Sie keine IP-Adresse angeben, geschieht Folgendes:<ul><li>Wenn sich Ihr Cluster in einem öffentlichen VLAN befindet, dann wird eine portierbare öffentliche IP-Adresse verwendet. Die meisten Cluster befinden sich in einem öffentlichen VLAN.</li><li>Wenn sich Ihr Cluster nur in einem privaten VLAN befindet, wird eine portierbare private IP-Adresse verwendet.</li></ul></td>
      </tr>
      </tbody></table>

      Beispielkonfigurationsdatei zum Erstellen eines privaten NLB-Service der Version 1.0, der eine angegebene IP-Adresse im privaten VLAN `2234945` in `dal12` verwendet:

      ```
      apiVersion: v1
      kind: Service
      metadata:
        name: myloadbalancer
        annotations:
          service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: private
          service.kubernetes.io/ibm-load-balancer-cloud-provider-zone: "dal12"
          service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan: "2234945"
      spec:
        type: LoadBalancer
        selector:
          app: nginx
        ports:
         - protocol: TCP
           port: 8080
        loadBalancerIP: 172.21.xxx.xxx
      ```
      {: codeblock}

  3. Optional: Stellen Sie sicher, dass Ihre NLB nur für einen begrenzten Bereich von IP-Adressen verfügbar ist, indem Sie die IP-Adressen im Feld `spec.loadBalancerSourceRanges` angeben. `loadBalancerSourceRanges` wird von `kube-proxy` in Ihrem Cluster durch Iptables-Regeln auf Workerknoten implementiert. Weitere Informationen enthält die [Kubernetes-Dokumentation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/).

  4. Erstellen Sie den Service in Ihrem Cluster.

      ```
      kubectl apply -f myloadbalancer.yaml
      ```
      {: pre}

3. Stellen Sie sicher, dass der NLB-Service erfolgreich erstellt wurde. Es kann ein paar Minuten dauern, bis der Service erstellt wurde und die App verfügbar ist.

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

5. Wiederholen Sie die Schritte 2 bis 4, um eine NLB der Version 1.0 in allen Zonen bereitzustellen.    

6. Wenn Sie die [Beibehaltung der Quellen-IP für eine NLB der Version NLB 1.0](#node_affinity_tolerations) wählen, stellen Sie sicher, dass App-Pods auf den Edge-Workerknoten geplant werden, indem Sie [Edge-Knoten-Affinität zu App-Pods hinzufügen](#lb_edge_nodes). App-Pods müssen auf Edge-Knoten geplant werden, um eingehende Anforderungen empfangen zu können.

7. Optional: Ein Lastausgleichsservice macht Ihre App auch über die NodePort-Instanzen des Service verfügbar. Auf [Knotenports (NodePorts)](/docs/containers?topic=containers-nodeport) kann über jede öffentliche und private IP-Adresse für jeden Knoten innerhalb des Clusters zugegriffen werden. Informationen zum Blockieren des Datenverkehrs an Knotenports während der Verwendung eines NLB-Service finden Sie im Abschnitt [Eingehenden Datenverkehr an Netzlastausgleichsfunktion (NLB) oder NodePort-Services steuern](/docs/containers?topic=containers-network_policies#block_ingress).

Als Nächstes können Sie [einen NLB-Hostnamen registrieren](/docs/containers?topic=containers-loadbalancer_hostname).

<br />


## NLB der Version 1.0 in einem Einzelzonencluster konfigurieren
{: #lb_config}

**Vorbereitende Schritte**:
* Es muss eine portierbare öffentliche oder private IP-Adresse verfügbar sein, die dem Netzlastausgleichsfunktions- (NLB-) Service zugewiesen werden kann. Weitere Informationen finden Sie unter [Teilnetze für Cluster konfigurieren](/docs/containers?topic=containers-subnets).
* Stellen Sie sicher, dass Sie die [{{site.data.keyword.cloud_notm}} IAM-Servicerolle **Schreibberechtigter** oder **Manager**](/docs/containers?topic=containers-users#platform) für den Namensbereich `default` innehaben.

Gehen Sie wie folgt vor, um einen NLB-Service der Version 1.0 in einem Einzelzonencluster zu erstellen:

1.  [Stellen Sie die App für den Cluster bereit](/docs/containers?topic=containers-app#app_cli). Stellen Sie sicher, dass Sie zur Bereitstellung im Metadatenabschnitt der Konfigurationsdatei eine Bezeichnung hinzufügen. Diese Bezeichnung ist zur Identifizierung aller Pods erforderlich, in denen Ihre App ausgeführt wird, damit sie in den Lastenausgleich aufgenommen werden können.
2.  Erstellen Sie einen Lastausgleichsservice für die App, die Sie über das öffentliche Internet oder ein privates Netz zugänglich machen wollen.
    1.  Erstellen Sie eine Servicekonfigurationsdatei namens `myloadbalancer.yaml` (Beispiel).

    2.  Definieren Sie einen Lastausgleichsservice für die App, die Sie zugänglich machen möchten.
        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: myloadbalancer
          annotations:
            service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_oder_private>
            service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan: "<vlan-id>"
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
          <td>Annotation zum Angeben eines VLAN, in dem der Lastausgleichsservice bereitgestellt wird. Um VLANs anzuzeigen, führen Sie <code>ibmcloud ks vlans --zone <zone></code> aus.</td>
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
          <td>Optional: Um eine private Lastausgleichsfunktion zu erstellen oder um eine bestimmte portierbare IP-Adresse für eine öffentliche Lastausgleichsfunktion zu verwenden, geben Sie die IP-Adresse an, die Sie verwenden wollen. Die IP-Adresse muss sich in dem VLAN befinden, das Sie in den Annotationen angeben. Wenn Sie keine IP-Adresse angeben, geschieht Folgendes:<ul><li>Wenn sich Ihr Cluster in einem öffentlichen VLAN befindet, dann wird eine portierbare öffentliche IP-Adresse verwendet. Die meisten Cluster befinden sich in einem öffentlichen VLAN.</li><li>Wenn sich Ihr Cluster nur in einem privaten VLAN befindet, wird eine portierbare private IP-Adresse verwendet.</li></ul></td>
        </tr>
        </tbody></table>

        Beispielkonfigurationsdatei zum Erstellen eines privaten NLB-Service der Version 1.0, der eine angegebene IP-Adresse im privaten VLAN `2234945` verwendet:

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: myloadbalancer
          annotations:
            service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: private
            service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan: "2234945"
        spec:
          type: LoadBalancer
          selector:
            app: nginx
          ports:
           - protocol: TCP
             port: 8080
          loadBalancerIP: 172.21.xxx.xxx
        ```
        {: codeblock}

    3. Optional: Stellen Sie sicher, dass Ihre NLB nur für einen begrenzten Bereich von IP-Adressen verfügbar ist, indem Sie die IP-Adressen im Feld `spec.loadBalancerSourceRanges` angeben. `loadBalancerSourceRanges` wird von `kube-proxy` in Ihrem Cluster durch Iptables-Regeln auf Workerknoten implementiert. Weitere Informationen enthält die [Kubernetes-Dokumentation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/).

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

5. Wenn Sie die [Beibehaltung der Quellen-IP für eine NLB der Version NLB 1.0](#node_affinity_tolerations) wählen, stellen Sie sicher, dass App-Pods auf den Edge-Workerknoten geplant werden, indem Sie [Edge-Knoten-Affinität zu App-Pods hinzufügen](#lb_edge_nodes). App-Pods müssen auf Edge-Knoten geplant werden, um eingehende Anforderungen empfangen zu können.

6. Optional: Ein Lastausgleichsservice macht Ihre App auch über die NodePort-Instanzen des Service verfügbar. Auf [Knotenports (NodePorts)](/docs/containers?topic=containers-nodeport) kann über jede öffentliche und private IP-Adresse für jeden Knoten innerhalb des Clusters zugegriffen werden. Informationen zum Blockieren des Datenverkehrs an Knotenports während der Verwendung eines NLB-Service finden Sie im Abschnitt [Eingehenden Datenverkehr an Netzlastausgleichsfunktion (NLB) oder NodePort-Services steuern](/docs/containers?topic=containers-network_policies#block_ingress).

Als Nächstes können Sie [einen NLB-Hostnamen registrieren](/docs/containers?topic=containers-loadbalancer_hostname#loadbalancer_hostname).

<br />


## Beibehaltung von Quellen-IP-Adressen aktivieren
{: #node_affinity_tolerations}

Dieses Feature ist nur für Netzlastausgleichsfunktionen (NLBs) der Version 1.0 verfügbar. Die Quellen-IP-Adresse von Clientanforderungen wird in den NLBs der Version 2.0 standardmäßig beibehalten.
{: note}

Wenn eine Clientanforderung an Ihre App an Ihren Cluster gesendet wird, empfängt ein Pod des Lastausgleichsservice die Anforderung. Wenn ein App-Pod nicht auf demselben Workerknoten vorhanden ist wie der Lastausgleichsfunktions-Pod, leitet die NLB die Anforderung an einen App-Pod auf einem anderen Workerknoten weiter. Die Quellen-IP-Adresse des Pakets wird in die öffentliche IP-Adresse des Workerknotens geändert, auf dem der Pod des Lastausgleichsservice ausgeführt wird.
{: shortdesc}

Um die ursprüngliche Quellen-IP-Adresse der Clientanforderung beizubehalten, können Sie die [Quellen-IP ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/#preserving-the-client-source-ip) für Lastausgleichsservices aktivieren. Die TCP-Verbindung wird bis zu den App-Pods fortgesetzt, sodass die App die tatsächliche IP-Adresse des Initiators sehen kann. Das Beibehalten der IP des Clients ist nützlich, z. B. wenn App-Server Sicherheits- und Zugriffssteuerungsrichtlinien genügen müssen.

Nachdem Sie die Quellen-IP aktiviert haben, müssen Lastausgleichsfunktions-Pods Anforderungen an App-Pods weiterleiten, die auf demselben Workerknoten bereitgestellt sind. In der Regel werden auch Lastausgleichsfunktions-Pods auf den Workerknoten bereitgestellt, auf denen sich die App-Pods befinden. Es kann jedoch vorkommen, dass die Lastausgleichsfunktions-Pods und die App-Pods nicht auf demselben Workerknoten geplant sind:

* Sie verfügen Edge-Knoten, auf die ein Taint angewendet wurde und auf denen deshalb nur Lastausgleichsfunktions-Pods bereitgestellt werden können. App-Pods dürfen auf diesen Knoten nicht bereitgestellt werden.
* Ihr Cluster ist mit mehreren öffentlichen oder privaten VLANs verbunden und Ihre App-Pods werden unter Umständen auf Workerknoten bereitgestellt, die nur mit einem VLAN verbunden sind. Lastausgleichsfunktions-Pods lassen sich möglicherweise nicht auf solchen Workerknoten bereitstellen, weil die NLB-IP-Adresse mit einem anderen VLAN als die Workerknoten verbunden ist.

Um zu erzwingen, dass Ihre App auf bestimmten Workerknoten bereitgestellt wird, auf denen auch Lastausgleichsfunktions-Pods bereitgestellt werden können, müssen Sie Affinitätsregeln und Tolerierungen zu Ihrer App-Bereitstellung hinzufügen.

### Affinitätsregeln und Tolerierungen für Edge-Knoten hinzufügen
{: #lb_edge_nodes}

Wenn Sie [Workerknoten als Edge-Knoten kennzeichnen](/docs/containers?topic=containers-edge#edge_nodes) und zudem [Taints auf Edge-Knoten anwenden](/docs/containers?topic=containers-edge#edge_workloads), werden Lastausgleichsfunktions-Pods nur auf diesen Edge-Knoten bereitgestellt und App-Pods können nicht auf Edge-Knoten implementiert werden. Wenn die Quellen-IP für den NLB-Service aktiviert ist, können die Lastausgleichsfunktions-Pods auf den Edge-Knoten eingehende Anforderungen nicht an die App-Pods auf anderen Workerknoten weiterleiten.
{:shortdesc}

Um zu erzwingen, dass Ihre App-Pods auf Edge-Knoten bereitgestellt werden, fügen Sie eine [Affinitätsregel ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#node-affinity-beta-feature) für den Edge-Knoten und eine [Tolerierung ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/#concepts) zur App-Bereitstellung hinzu.

Beispiel für die YAML-Bereitstellungsdatei mit Edge-Knoten-Affinität und -Tolerierung:

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: with-node-affinity
spec:
  selector:
    matchLabels:
      <label_name>: <label_value>
  template:
    spec:
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
            - matchExpressions:
              - key: dedicated
                operator: In
                values:
                - edge
      tolerations:
        - key: dedicated
          value: edge
...
```
{: codeblock}

In beiden Abschnitten **affinity** und **tolerations** ist der Wert `dedicated` für `key` und der Wert `edge` für `value` angegeben.

### Affinitätsregeln für mehrere öffentliche oder private VLANs hinzufügen
{: #edge_nodes_multiple_vlans}

Wenn Ihr Cluster mit mehreren öffentlichen oder privaten VLANs verbunden ist, werden Ihre App-Pods unter Umständen auf Workerknoten bereitgestellt, die nur mit einem VLAN verbunden sind. Wenn die NLB-IP-Adresse mit einem anderen VLAN als diese Workerknoten verbunden ist, werden die Lastausgleichsfunktions-Pods nicht auf diesen Workerknoten bereitgestellt.
{:shortdesc}

Wenn die Quellen-IP aktiviert ist, planen Sie App-Pods auf Workerknoten, die dasselbe VLAN wie die NLB-IP-Adresse aufweisen, indem Sie eine Affinitätsregel zur App-Bereitstellung hinzufügen.

Vorbereitende Schritte: [Melden Sie sich an Ihrem Konto an. Geben Sie, sofern anwendbar, die richtige Ressourcengruppe als Ziel an. Legen Sie den Kontext für den Cluster fest.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

1. Rufen Sie die IP-Adresse des NLB-Service ab. Suchen Sie im Feld **LoadBalancer Ingress** nach der IP-Adresse.
    ```
    kubectl describe service <name_des_lastausgleichsservice>
    ```
    {: pre}

2. Rufen Sie die VLAN-ID ab, mit der Ihr NLB-Service verbunden ist.

    1. Listen Sie portierbare öffentliche VLANs für Ihren Cluster auf.
        ```
        ibmcloud ks cluster-get --cluster <clustername_oder_-id> --showResources
        ```
        {: pre}

        Beispielausgabe:
        ```
        ...

        Subnet VLANs
        VLAN ID   Subnet CIDR       Public   User-managed
        2234947   10.xxx.xx.xxx/29  false    false
        2234945   169.36.5.xxx/29   true     false
        ```
        {: screen}

    2. Suchen Sie in der Ausgabe unter **Subnet VLANs** nach der Teilnetz-CIDR, die mit der NLB-IP-Adresse übereinstimmt, die Sie zuvor abgerufen haben, und notieren Sie sich die VLAN-ID.

        Wenn die IP-Adresse des NLB-Service beispielsweise `169.36.5.xxx` lautet, ist das passende Teilnetz in der Beispielausgabe aus dem vorherigen Schritt `169.36.5.xxx/29`. Die VLAN-ID, mit der das Teilnetz verbunden ist, lautet `2234945`.

3. [Fügen Sie eine Affinitätsregel ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#node-affinity-beta-feature) zu der App-Bereitstellung für die VLAN-ID hinzu, die Sie sich im vorherigen Schritt notiert haben.

    Wenn Sie beispielsweise über mehrere VLANs verfügen, aber Ihre App-Pods nur auf Workerknoten im öffentlichen VLAN `2234945` bereitstellen möchten.

    ```
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: with-node-affinity
    spec:
      selector:
        matchLabels:
          <label_name>: <label_value>
      template:
        spec:
          affinity:
            nodeAffinity:
              requiredDuringSchedulingIgnoredDuringExecution:
                nodeSelectorTerms:
                - matchExpressions:
                  - key: publicVLAN
                    operator: In
                    values:
                    - "2234945"
    ...
    ```
    {: codeblock}

    In der YAML-Beispieldatei enthält der Abschnitt **affinity** den Wert `publicVLAN` für `key` und den Wert `"2234945"` für `value`.

4. Wenden Sie die aktualisierte Bereitstellungskonfigurationsdatei an.
    ```
    kubectl apply -f with-node-affinity.yaml
    ```
    {: pre}

5. Überprüfen Sie, dass die App-Pods auf Workerknoten bereitgestellt werden, die mit dem designierten VLAN verbunden sind.

    1. Listen Sie die Pods in Ihrem Cluster auf. Ersetzen Sie `<selector>` durch die Bezeichnung, die Sie für die App verwendet haben.
        ```
        kubectl get pods -o wide app=<selektor>
        ```
        {: pre}

        Beispielausgabe:
        ```
        NAME                   READY     STATUS              RESTARTS   AGE       IP               NODE
        cf-py-d7b7d94db-vp8pq  1/1       Running             0          15d       172.30.xxx.xxx   10.176.48.78
        ```
        {: screen}

    2. Geben Sie in der Ausgabe einen Pod für Ihre App an. Notieren Sie sich die Knoten-ID (**NODE**) des Workerknotens, auf dem sich der Pod befindet.

        In der Beispielausgabe aus dem vorherigen Schritt befindet sich der App-Pod `cf-py-d7b7d94db-vp8pq` auf dem Workerknoten `10.176.48.78`.

    3. Listen Sie die Details für den Workerknoten auf.

        ```
        kubectl describe node <workerknoten-ID>
        ```
        {: pre}

        Beispielausgabe:

        ```
        Name:                   10.xxx.xx.xxx
        Role:
        Labels:                 arch=amd64
                                beta.kubernetes.io/arch=amd64
                                beta.kubernetes.io/os=linux
                                failure-domain.beta.kubernetes.io/region=us-south
                                failure-domain.beta.kubernetes.io/zone=dal10
                                ibm-cloud.kubernetes.io/encrypted-docker-data=true
                                kubernetes.io/hostname=10.xxx.xx.xxx
                                privateVLAN=2234945
                                publicVLAN=2234967
        ...
        ```
        {: screen}

    4. Überprüfen Sie im Abschnitt **Labels** der Ausgabe, dass es sich bei dem öffentlichen oder privaten VLAN um das VLAN handelt, das Sie in den vorherigen Schritten angegeben haben.
