---

copyright:
  years: 2014, 2018
lastupdated: "2018-02-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Externen Netzbetrieb planen
{: #planning}

Wenn Sie einen Cluster erstellen, muss jeder Cluster mit einem öffentlichen VLAN verbunden sein. Das öffentliche VLAN bestimmt, welche öffentliche IP-Adresse einem Workerknoten während der Clustererstellung zugewiesen wird.
{:shortdesc}

Die öffentliche Netzschnittstelle für die Workerknoten in kostenlosen Clustern und in Standardclustern wird durch Calico-Netzrichtlinien geschützt. Diese Richtlinien blockieren standardmäßig den Großteil des eingehenden Datenverkehrs. Allerdings wird der eingehende Datenverkehr, der zur ordnungsgemäßen Funktion von Kubernetes erforderlich ist, zugelassen. Dies gilt auch für die Verbindungen zu NodePort-, Loadbalancer- und Ingress-Services. Weitere Informationen zu diesen Richtlinien und zur Vorgehensweise bei der Änderung dieser Richtlinien finden Sie in [Netzrichtlinien](cs_network_policy.html#network_policies).

|Clustertyp|Manager des öffentlichen VLANs für den Cluster|
|------------|------------------------------------------|
|Kostenlose Cluster in {{site.data.keyword.Bluemix_notm}}|{{site.data.keyword.IBM_notm}}|
|Standardcluster in {{site.data.keyword.Bluemix_notm}}|Sie bei Ihrem Konto von IBM Cloud Infrastructure (SoftLayer)|
{: caption="Zuständigkeiten beim Management von VLANs" caption-side="top"}

Informationen zur clusterinternen Netzkommunikation zwischen Workerknoten und Pods finden Sie in [Netzbetrieb in Clustern](cs_secure.html#in_cluster_network). Informationen zu sicheren Verbindungen von Apps, die in einem Kubernetes-Cluster ausgeführt werden, zu einem lokalen Netz oder zu Apps außerhalb Ihres Clusters finden Sie in [VPN-Konnektivität einrichten](cs_vpn.html).

## Öffentlichen Zugriff auf Apps zulassen
{: #public_access}

Um eine App öffentlich für das Internet zugänglich zu machen, müssen Sie vor der Bereitstellung der App in einem Cluster Ihre Konfigurationsdatei aktualisieren.
{:shortdesc}

*Kubernetes-Datenebene in {{site.data.keyword.containershort_notm}}*

![{{site.data.keyword.containerlong_notm}} Kubernetes-Architektur](images/networking.png)

Das Diagramm zeigt, wie Kubernetes Benutzernetzverkehr in {{site.data.keyword.containershort_notm}} überträgt. Je nachdem, ob Sie einen kostenlosen Cluster oder einen Standardcluster erstellt haben, gibt es verschiedene Möglichkeiten, Ihre App im Internet zugänglich zu machen.

<dl>
<dt><a href="#nodeport" target="_blank">NodePort-Service</a> (kostenlose Cluster und Standardcluster)</dt>
<dd>
 <ul>
  <li>Machen Sie auf jedem Workerknoten einen öffentlichen Port zugänglich und verwenden Sie die öffentliche IP-Adresse der einzelnen Workerknoten, um öffentlich auf Ihren Service im Cluster zuzugreifen.</li>
  <li>Iptables ist ein Linux-Kernel-Feature für den Lastausgleich von Anforderungen in allen Pods der App, das eine Hochleistungsnetzweiterleitung und Netzzugriffssteuerung bietet.</li>
  <li>Die öffentliche IP-Adresse des Workerknotens ist nicht permanent. Wird ein Workerknoten entfernt oder neu erstellt, so wird ihm eine neue öffentliche IP-Adresse zugewiesen.</li>
  <li>Der NodePort-Service eignet sich hervorragend zum Testen des öffentlichen Zugriffs. Er kann auch verwendet werden, wenn Sie nur für kurze Zeit einen öffentlichen Zugriff einrichten möchten.</li>
 </ul>
</dd>
<dt><a href="#loadbalancer" target="_blank">LoadBalancer-Service</a> (nur Standardcluster)</dt>
<dd>
 <ul>
  <li>Jeder Standardcluster wird mit 4 portierbaren öffentlichen IP-Adressen und 4 portierbaren privaten IP-Adressen bereitgestellt, mit denen Sie eine externe TCP-/UDP-Lastausgleichsfunktion (Load Balancer) für Ihre App erstellen können.</li>
  <li>Iptables ist ein Linux-Kernel-Feature für den Lastausgleich von Anforderungen in allen Pods der App, das eine Hochleistungsnetzweiterleitung und Netzzugriffssteuerung bietet.</li>
  <li>Die der Lastausgleichsfunktion zugewiesene portierbare öffentliche IP-Adresse ist dauerhaft und ändert sich nicht, wenn im Cluster ein Workerknoten neu erstellt wird.</li>
  <li>Diese Lastausgleichsfunktion kann durch Offenlegung jedes beliebigen Ports, den Ihre App benötigt, entsprechend angepasst werden.</li></ul>
</dd>
<dt><a href="#ingress" target="_blank">Ingress</a> (nur Standardcluster)</dt>
<dd>
 <ul>
  <li>Sie können mehrere Apps in ihrem Cluster öffentlich zugänglich machen, indem Sie eine einzelne externe HTTP- oder HTTPS-Lastausgleichsfunktion (Load Balancer) erstellen, die einen geschützten und eindeutigen Einstiegspunkt für die Weiterleitung eingehender Anforderungen an Ihre Apps verwendet.</li>
  <li>Sie können eine öffentliche Route verwenden, um mehrere Apps in Ihrem Cluster als Services zugänglich zu machen.</li>
  <li>Ingress besteht aus zwei Hauptkomponenten: der Ingress-Ressource und der Lastausgleichsfunktion für Anwendungen.
   <ul>
    <li>Die Ingress-Ressource definiert die Regeln, die festlegen, wie die Weiterleitung der eingehenden Anforderungen für eine App und deren Lastausgleich erfolgen soll.</li>
    <li>Die Lastausgleichsfunktion für Anwendungen ist für eingehende HTTP- oder HTTPS-Serviceanforderungen empfangsbereit und leitet Anforderungen über die Pods der App in Übereinstimmung mit den für jede Ingress-Ressource definierten Regeln weiter.</li>
   </ul>
  <li>Verwenden Sie Ingress, wenn Sie eine eigene Lastausgleichsfunktion für Anwendungen mit angepassten Weiterleitungsregeln implementieren möchten und wenn Sie SSL-Terminierung für Ihre Apps benötigen.</li>
 </ul>
</dd></dl>

Folgen Sie diesem Entscheidungsbaum, um die beste Netzoption für Ihre Anwendung auszuwählen:

<img usemap="#networking_map" border="0" class="image" src="images/networkingdt.png" width="500px" alt="In dieser Grafik werden Sie durch einzelnen Schritte zur Auswahl der besten Netzoption für Ihre Anwendung geführt. Wird diese Grafik hier nicht angezeigt, können Sie die erforderlichen Informationen an anderer Stelle in der Dokumentation finden." style="width:500px;" />
<map name="networking_map" id="networking_map">
<area href="/docs/containers/cs_nodeport.html#config" alt="NodePort-Service" shape="circle" coords="52, 283, 45"/>
<area href="/docs/containers/cs_loadbalancer.html#config" alt="LoadBalancer-Service" shape="circle" coords="247, 419, 44"/>
<area href="/docs/containers/cs_ingress.html#config" alt="Ingress-Service" shape="circle" coords="445, 420, 45"/>
</map>


<br />


## App mithilfe eines NodePort-Service im Internet zugänglich machen
{: #nodeport}

Machen Sie auf Ihrem Workerknoten einen öffentlichen Port zugänglich und verwenden Sie die öffentliche IP-Adresse des Workerknotens, um öffentlich über das Internet auf Ihren Service im Cluster zuzugreifen.
{:shortdesc}

Wenn Sie Ihre App durch Erstellen eines Kubernetes-Service vom Typ 'NodePort' zugänglich machen, wird dem Service eine Knotenportnummer im Zahlenbereich 30000-32767 und eine interne Cluster-IP-Adresse zugewiesen. Der NodePort-Service fungiert als externer Einstiegspunkt für eingehende Anforderungen an die App. Der zugewiesene NodePort wird in den kubeproxy-Einstellungen eines jeden Workerknotens im Cluster zugänglich gemacht. Jeder Workerknoten beginnt, am zugewiesenen Knotenport empfangsbereit für eingehende Anforderungen für den Service zu sein. Um vom Internet aus auf den Service zuzugreifen, können Sie die öffentliche IP-Adresse eines beliebigen Workerknotens, die bei der Clustererstellung zugewiesen wurde, in Verbindung mit der Knotenportnummer im Format `<ip_address>:<nodeport>`. Zusätzlich zur öffentlichen IP-Adresse steht ein NodePort-Service über die private IP-Adresse eines Workerknotens zur Verfügung.

Das folgende Diagramm veranschaulicht, wie die Kommunikation vom Internet an eine App geleitet wird, wenn NodePort-Service konfiguriert ist.

![Service mithilfe eines Kubernetes-NodePort-Service zugänglich machen](images/cs_nodeport.png)

Wenn eine Anforderung beim NodePort-Service eingeht, wird sie, wie im Diagramm dargestellt, automatisch an die interne Cluster-IP des Service weitergeleitet und dann von der `kube-proxy`-Komponente weiter an die private IP-Adresse des Pods weitergeleitet, durch den die App bereitgestellt wird. Auf die Cluster-IP kann nur aus dem Cluster selbst heraus zugegriffen werden. Werden mehrere Replikate Ihrer App in verschiedenen Pods ausgeführt, so führt die `kube-proxy`-Komponente für die eingehenden Anforderungen über alle Replikate hinweg einen Lastausgleich aus.

**Hinweis:** Die öffentliche IP-Adresse des Workerknotens ist nicht permanent. Wird ein Workerknoten entfernt oder neu erstellt, so wird ihm eine neue öffentliche IP-Adresse zugewiesen. Sie können den NodePort-Service verwenden, wenn Sie den öffentlichen Zugriff auf Ihre App testen möchten oder der öffentliche Zugriff nur über einen beschränkten Zeitraum erforderlich ist. Wenn Sie eine stabile öffentliche IP-Adresse und ein höheres Maß an Verfügbarkeit für Ihren Service benötigen, sollten Sie Ihre App über einen [LoadBalancer-Service](#loadbalancer) oder über [Ingress](#ingress) verfügbar machen.

Anweisungen zum Erstellen eines Service vom Typ 'NodePort' mit {{site.data.keyword.containershort_notm}} finden Sie unter [Öffentlichen Zugriff auf eine App durch Verwenden des Servicetyps 'NodePort' konfigurieren](cs_nodeport.html#config).

<br />



## App mithilfe eines LoadBalancer-Service im Internet zugänglich machen
{: #loadbalancer}

Machen Sie einen Port zugänglich und verwenden Sie die öffentliche oder private IP-Adresse für die Lastausgleichsfunktion (Load Balancer), um auf die App zuzugreifen.
{:shortdesc}


Wenn Sie einen Standardcluster erstellen, fordert {{site.data.keyword.containershort_notm}} automatisch fünf portierbare öffentliche IP-Adressen und fünf portierbare private IP-Adressen an und richtet diese bei der Erstellung des Clusters in Ihrem Konto von IBM Cloud Infrastructure (SoftLayer) ein. Zwei der portierbaren IP-Adressen (eine öffentliche und eine private) werden für [Ingress-Lastausgleichsfunktionen für Anwendungen](#ingress) verwendet. Vier portierbare öffentliche und vier portierbare private IP-Adressen können verwendet werden, um Apps verfügbar zu machen, indem Sie einen LoadBalancer-Service erstellen.

Wenn Sie einen Kubernetes-LoadBalancer-Service in einem Cluster in einem öffentlichen VLAN erstellen, wird eine externe Lastausgleichsfunktion erstellt. Eine der vier verfügbaren öffentlichen IP-Adressen wird der Lastausgleichsfunktion zugewiesen. Sind keine portierbaren öffentlichen IP-Adresse verfügbar, schlägt die Erstellung des 'LoadBalancer'-Service fehl. Der LoadBalancer-Service fungiert als externer Einstiegspunkt für eingehende Anforderungen an die App. Anders als bei NodePort-Services können Sie Ihrer Lastausgleichsfunktion jeden beliebigen Port zuweisen und sind dabei nicht an einen bestimmten Portnummernbereich gebunden. Die dem LoadBalancer-Service zugewiesene portierbare öffentliche IP-Adresse ist dauerhaft und ändert sich nicht, wenn ein Workerknoten entfernt oder neu erstellt wird. Dadurch bietet der LoadBalancer-Service eine höhere Verfügbarkeit als der NodePort-Service. Um vom Internet aus auf den LoadBalancer-Service zuzugreifen, können Sie die öffentliche IP-Adresse Ihrer Lastausgleichsfunktion in Verbindung mit der zugewiesenen Portnummer im Format `<ip_address>:<port>`.

Das folgende Diagramm veranschaulicht, wie die Lastausgleichsfunktion (LoadBalancer) die Kommunikation vom Internet an eine App leitet:

![Service mithilfe eines Kubernetes-LoadBalancer-Service zugänglich machen](images/cs_loadbalancer.png)

Wenn eine Anforderung beim LoadBalancer-Service eingeht, wird diese, wie im Diagramm dargestellt, automatisch an die interne Cluster-IP-Adresse weitergeleitet, die dem LoadBalancer-Service bei der Erstellung des Service zugewiesen wurde. Auf die Cluster-IP-Adresse kann nur aus dem Cluster selbst heraus zugegriffen werden. Von der Cluster-IP-Adresse werden eingehende Anforderungen weiter an die `kube-proxy`-Komponente Ihres Workerknotens weitergeleitet. Dann werden die Anforderungen an die private IP-Adresse des Pods weitergeleitet, durch den die App bereitgestellt wird. Werden mehrere Replikate Ihrer App in verschiedenen Pods ausgeführt, so führt die `kube-proxy`-Komponente für die eingehenden Anforderungen über alle Replikate hinweg einen Lastausgleich aus.

Wenn Sie einen LoadBalancer-Service verwenden, steht für jede IP-Adresse aller Workerknoten auch ein Knotenport zur Verfügung. Informationen zum Blockieren des Zugriffs auf den Knotenport während der Nutzung eines LoadBalancer-Service finden Sie in [Eingehenden Datenverkehr blockieren](cs_network_policy.html#block_ingress).

Ihre Optionen für IP-Adressen bei Erstellung eines LoadBalancer-Service lauten wie folgt:

- Wenn sich Ihr Cluster in einem öffentlichen VLAN befindet, dann wird eine portierbare öffentliche IP-Adresse verwendet.
- Wenn Ihr Cluster ausschließlich in einem privaten VLAN verfügbar ist, wird eine portierbare private IP-Adresse verwendet.
- Sie können eine portierbare öffentliche oder private IP-Adresse für einen LoadBalancer-Service anfordern, indem Sie eine Annotation zur Konfigurationsdatei hinzufügen: `service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>`.



Anweisungen zum Erstellen eines LoadBalancer-Service mit {{site.data.keyword.containershort_notm}} finden Sie unter [Öffentlichen Zugriff auf eine App durch Verwenden des Servicetyps 'LoadBalancer' konfigurieren](cs_loadbalancer.html#config).


<br />



## App mithilfe von Ingress im Internet zugänglich machen
{: #ingress}

Ingress ermöglicht es Ihnen, mehrere Services in Ihrem Cluster zugänglich zu machen und diese unter Verwendung eines einzelnen öffentlichen Einstiegspunkts öffentlich verfügbar zu machen.
{:shortdesc}

Anstatt für jede App, die öffentlich zugänglich gemacht werden soll, einen Lastausgleichsservice zu erstellen,
bietet Ingress eine eindeutige öffentliche Route, mit der Sie öffentliche Anforderungen a Apps basierend auf ihren individuellen Pfaden innerhalb Ihres Clusters weiterleiten können. Ingress besteht aus zwei Hauptkomponenten. Die Ingress-Ressource definiert die Regeln, die festlegen,
wie die Weiterleitung der eingehenden Anforderungen für eine App erfolgen soll. Alle Ingress-Ressourcen müssen bei der Ingress-Lastausgleichsfunktion für Anwendungen registriert sein, die für eingehende HTTP- oder HTTPS-Serviceanforderungen empfangsbereit ist und die Weiterleitung der Anforderungen basierend auf den für jede Ingress-Ressource definierten Regeln durchführt.

Wenn Sie einen Standardcluster erstellen, erstellt {{site.data.keyword.containershort_notm}} automatisch eine hoch verfügbare Lastausgleichsfunktion für Anwendungen in Ihrem Cluster und weist dieser eine eindeutige öffentliche Route im Format `<cluster_name>.<region>.containers.mybluemix.net` zu. Die öffentliche Route ist mit einer portierbaren öffentlichen IP-Adresse verknüpft, die bei der Erstellung des Clusters in Ihrem Konto von IBM Cloud Infrastructure (SoftLayer) eingerichtet wird. Es wird zwar auch eine private Lastausgleichsfunktion für Anwendungen erstellt, diese wird jedoch nicht automatisch aktiviert.

Das folgende Diagramm veranschaulicht, wie Ingress die Kommunikation vom Internet an eine App leitet:

![Service unter Verwendung der Unterstützung für Ingress von {{site.data.keyword.containershort_notm}} zugänglich machen](images/cs_ingress.png)

Um eine App über Ingress zugänglich zu machen, müssen Sie einen Kubernetes-Service für Ihre App erstellen und diesen Service bei der Lastausgleichsfunktion für Anwendungen registrieren, indem Sie eine Ingress-Ressource definieren. Die Ingress-Ressource gibt den Pfad an, den Sie an die öffentliche Route anfügen möchten, um eine eindeutige URL für Ihre zugänglich gemachte App zu bilden (z. B. `mein_cluster.us-süden.container.mein_bluemix.net/meine_app`). Wenn Sie diese Route in Ihren Web-Browser eingeben, wird die Anforderung (wie im Diagramm dargestellt) an die verknüpfte, portierbare öffentliche IP-Adresse der Lastausgleichsfunktion für Anwendungen gesendet. Die Lastausgleichsfunktion für Anwendungen prüft, ob für den Pfad `meine_app` im Cluster `mein_cluster` eine Routing-Regel vorhanden ist. Wird eine übereinstimmende Regel gefunden, so wird die Anforderung einschließlich dem einzelnen Pfad an den Pod weitergeleitet, über den die App bereitgestellt wird. Diese Weiterleitung erfolgt unter Berücksichtigung der Regeln, die im ursprünglichen Ingress-Ressourcenobjekt definiert waren. Damit die App eingehende Anforderungen verarbeitet, müssen Sie sicherstellen, dass Ihre App unter dem jeweiligen Pfad empfangsbereit ist, den Sie in der Ingress-Ressource definiert haben.



Sie können die Lastausgleichsfunktion für Anwendungen so konfigurieren, dass eingehender Netzverkehr für Ihre Apps in den folgenden Szenarios verwaltet wird:

-   Von IBM bereitgestellte Domäne ohne TLS-Terminierung verwenden
-   Von IBM bereitgestellte Domäne mit TLS-Terminierung verwenden
-   Angepasste Domäne mit TLS-Terminierung verwenden
-   Von IBM bereitgestellte oder angepasste Domäne mit TLS-Terminierung für den Zugriff auf Apps außerhalb Ihres Clusters verwenden
-   Private Lastausgleichsfunktion für Anwendungen und angepasste Domäne ohne TLS-Terminierung verwenden
-   Private Lastausgleichsfunktion für Anwendungen und angepasste Domäne mit TLS-Terminierung verwenden
-   Funktionen mithilfe von Annotationen zur Lastausgleichsfunktion für Anwendungen hinzufügen

Anweisungen zur Verwendung von Ingress mit {{site.data.keyword.containershort_notm}} finden Sie unter [Öffentlichen Zugriff auf eine App durch Verwenden von Ingress konfigurieren](cs_ingress.html#ingress).

<br />

