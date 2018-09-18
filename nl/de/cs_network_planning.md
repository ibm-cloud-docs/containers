---

copyright:
  years: 2014, 2018
lastupdated: "2018-08-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Clustervernetzung planen
{: #planning}

Mit {{site.data.keyword.containerlong}} können Sie sowohl die externe Vernetzung verwalten, indem Sie Apps öffentlich oder privat zugänglich machen, sowie die interne Vernetzung in Ihrem Cluster.
{: shortdesc}

## NodePort-, LoadBalancer- oder Ingress-Service auswählen
{: #external}

Wenn Sie Ihre Apps extern über das [öffentliche Internet](#public_access) oder ein [privates Netz](#private_both_vlans) zugänglich machen möchten, unterstützt {{site.data.keyword.containershort_notm}} drei Netzservices.{:shortdesc}

**[NodePort-Service](cs_nodeport.html)** (kostenlose Cluster und Standardcluster)
* Machen Sie auf jedem Workerknoten einen Port zugänglich und verwenden Sie die öffentliche oder private IP-Adresse der einzelnen Workerknoten, um auf Ihren Service im Cluster zuzugreifen.
* Iptables ist ein Linux-Kernel-Feature für den Lastausgleich von Anforderungen in allen Pods der App, das eine Hochleistungsnetzweiterleitung und Netzzugriffssteuerung bietet.
* Die öffentlichen und privaten IP-Adressen des Workerknotens sind nicht permanente Adressen. Wenn ein Workerknoten entfernt oder neu erstellt wird, werden ihm eine neue öffentliche und eine neue private IP-Adresse zugewiesen.
* Der NodePort-Service eignet sich gut zum Testen des öffentlichen oder privaten Zugriffs. Er kann auch verwendet werden, wenn Sie nur für kurze Zeit einen öffentlichen oder privaten Zugriff benötigen.

**[LoadBalancer-Service](cs_loadbalancer.html)** (nur Standardcluster)
* Jeder Standardcluster wird mit 4 portierbaren öffentlichen IP-Adressen und 4 portierbaren privaten IP-Adressen bereitgestellt, mit denen Sie eine externe TCP/UDP-Lastausgleichsfunktion (LoadBalancer) für Ihre App erstellen können.
* Iptables ist ein Linux-Kernel-Feature für den Lastausgleich von Anforderungen in allen Pods der App, das eine Hochleistungsnetzweiterleitung und Netzzugriffssteuerung bietet.
* Die der Lastausgleichsfunktion zugewiesenen portierbaren öffentlichen und privaten IP-Adressen sind dauerhaft und ändern sich nicht, wenn im Cluster ein Workerknoten neu erstellt wird.
* Diese Lastausgleichsfunktion kann durch Offenlegung jedes beliebigen Ports, den Ihre App benötigt, entsprechend angepasst werden.

**[Ingress](cs_ingress.html)** (nur Standardcluster)
* Sie können mehrere Anwendungen in einem Cluster zugänglich machen, indem Sie eine externe HTTP- oder HTTPS-, TCP- oder UDP-Lastausgleichsfunktion für Anwendungen (ALB) erstellen. Diese verwendet einen geschützten und eindeutigen öffentlichen oder privaten Einstiegspunkt für die Weiterleitung eingehender Anforderungen an Ihre Apps.
* Sie können eine Route verwenden, um mehrere Apps in Ihrem Cluster als Services zugänglich zu machen.
* Ingress besteht aus drei Komponenten:
  * Die Ingress-Ressource definiert die Regeln, die festlegen, wie die Weiterleitung der eingehenden Anforderungen für eine App und deren Lastausgleich erfolgen soll.
  * Die ALB ist für eingehende HTTP- oder HTTPS-, TCP- oder UDP-Serviceanforderungen empfangsbereit. Sie leitet Anforderungen über die Pods der App in Übereinstimmung mit den für jede Ingress-Ressource definierten Regeln weiter.
  * Der Lastausgleichsfunktion für mehrere Zonen (MZLB) verarbeitet alle eingehenden Anforderungen an Ihre Apps und verteilt diese an die ALBs in den verschiedenen Zonen.
* Verwenden Sie Ingress, wenn Sie Ihre eigene ALB mit angepassten Regeln für die Weiterleitung implementieren möchten und eine SSL-Terminierung für Ihre Apps benötigen.

Um den besten Netzservice für Ihre App auszuwählen, können Sie diesem Entscheidungsbaum folgen und auf eine der Optionen klicken, um zu beginnen.

<img usemap="#networking_map" border="0" class="image" src="images/networkingdt.png" width="500px" alt="In dieser Grafik werden Sie durch einzelnen Schritte zur Auswahl der besten Netzoption für Ihre Anwendung geführt. Wird diese Grafik hier nicht angezeigt, können Sie die erforderlichen Informationen an anderer Stelle in der Dokumentation finden." style="width:500px;" />
<map name="networking_map" id="networking_map">
<area href="/docs/containers/cs_nodeport.html" alt="NodePort-Service" shape="circle" coords="52, 283, 45"/>
<area href="/docs/containers/cs_loadbalancer.html" alt="LoadBalancer-Service" shape="circle" coords="247, 419, 44"/>
<area href="/docs/containers/cs_ingress.html" alt="Ingress-Service" shape="circle" coords="445, 420, 45"/>
</map>

<br />


## Öffentliche externe Vernetzung planen
{: #public_access}

Wenn Sie einen Kubernetes-Cluster in {{site.data.keyword.containershort_notm}} erstellen, können Sie den Cluster mit einem öffentlichen VLAN verbinden. Das öffentliche VLAN bestimmt die öffentliche IP-Adresse, die dem jeweiligen Workerknoten zugeordnet ist. Diese Adresse stellt jedem Workerknoten eine öffentliche Netzschnittstelle bereit.{:shortdesc}

Um eine App öffentlich für das Internet verfügbar zu machen, können Sie einen NodePort-, LoadBalancer- oder Ingress-Service erstellen. Informationen zum Vergleichen der einzelnen Services finden Sie im Abschnitt [NodePort-, LoadBalancer- oder Ingress-Service auswählen](#external).

Das folgende Diagramm zeigt, wie Kubernetes den öffentlichen Netzverkehr in {{site.data.keyword.containershort_notm}} weiterleitet.

![{{site.data.keyword.containershort_notm}} Kubernetes-Architektur](images/networking.png)

*Kubernetes-Datenebene in {{site.data.keyword.containershort_notm}}*

Die öffentliche Netzschnittstelle für die Workerknoten in kostenlosen Clustern und in Standardclustern wird durch Calico-Netzrichtlinien geschützt. Diese Richtlinien blockieren standardmäßig den Großteil des eingehenden Datenverkehrs. Allerdings wird der eingehende Datenverkehr, der zur ordnungsgemäßen Funktion von Kubernetes erforderlich ist, zugelassen. Dies gilt auch für die Verbindungen zu NodePort-, LoadBalancer- und Ingress-Services. Weitere Informationen zu diesen Richtlinien und zur Vorgehensweise bei der Änderung dieser Richtlinien finden Sie in [Netzrichtlinien](cs_network_policy.html#network_policies).

<br />


## Private externe Vernetzung für ein öffentliches und privates VLAN-Setup planen
{: #private_both_vlans}

Wenn Sie einen Kubernetes-Cluster in {{site.data.keyword.containershort_notm}} erstellen, müssen Sie Ihren Cluster mit einem privaten VLAN verbinden. Das private VLAN bestimmt die private IP-Adresse, die dem jeweiligen Workerknoten zugeordnet ist. Diese Adresse stellt jedem Workerknoten eine private Netzschnittstelle bereit.{:shortdesc}

Wenn Ihre Apps nur mit einem privaten Netz verbunden sein sollen, können Sie die private Netzschnittstelle für die Workerknoten in Standardclustern verwenden. Wenn die Workerknoten jedoch sowohl mit einem öffentlichen als auch mit einem privaten VLAN verbunden sind, müssen Sie auch die Netzrichtlinien von Calico verwenden, um Ihren Cluster vor unerwünschtem öffentlichen Zugriff zu schützen.

In den folgenden Abschnitten werden die Funktionen in {{site.data.keyword.containershort_notm}} beschrieben, die Sie verwenden können, um Anwendungen einem privaten Netz zugänglich zu machen und Ihren Cluster vor unerwünschtem öffentlichen Zugriff zu schützen. Optional können Sie die Netzarbeitslast auch isolieren und Ihren Cluster mit Ressourcen in einem lokalen Netz verbinden.

### Apps mit privaten Netzservices zugänglich machen und den Cluster mit Calico-Netzrichtlinien schützen
{: #private_both_vlans_calico}

Die öffentliche Netzschnittstelle für Workerknoten wird durch [vordefinierte Calico-Netzrichtlinieneinstellungen](cs_network_policy.html#default_policy) geschützt, die bei der Clustererstellung auf jedem Workerknoten konfiguriert werden. Standardmäßig ist für alle Workerknoten der gesamte ausgehende Netzverkehr zulässig. Der eingehende Netzverkehr wird mit Ausnahme einiger Ports blockiert, die geöffnet werden, damit der Netzverkehr von IBM überwacht werden und IBM Sichheitsupdates für den Kubernetes-Master automatisch aktualisieren kann. Der Zugriff auf den Kubelet des Workerknotens wird durch einen OpenVPN-Tunnel gesichert. Weitere Informationen finden Sie im Abschnitt mit der [{{site.data.keyword.containershort_notm}}-Architektur](cs_tech.html).

Wenn Sie Ihre Apps mit einem NodePort-Service, einem LoadBalancer-Service oder einer Ingress-ALB bereitstellen, ermöglichen die standardmäßigen Calico-Richtlinien auch eingehenden Netzverkehr vom Internet an diese Services. Um die App nur über ein privates Netz zugänglich zu machen, können Sie nur private NodePort-, LoadBalancer- oder Ingress-Services verwenden und den gesamten öffentlichen Datenverkehr für die Services blockieren.

**NodePort**
* [Erstellen Sie einen NodePort-Service](cs_nodeport.html). Zusätzlich zur öffentlichen IP-Adresse steht ein NodePort-Service über die private IP-Adresse eines Workerknotens zur Verfügung.
* Ein NodePort-Service öffnet einen Port auf einem Workerknoten sowohl über die private als auch über die öffentliche IP-Adresse des Workerknotens. Sie müssen eine [Calico-PreDNAT-Netzrichtlinie](cs_network_policy.html#block_ingress) verwenden, um die öffentlichen Knotenports (NodePorts) zu blockieren.

**LoadBalancer**
* [Erstellen Sie einen privaten LoadBalancer-Service](cs_loadbalancer.html).
* Ein LoadBalancer-Service mit einer portierbaren privaten IP-Adresse verfügt weiterhin auf jedem Workerknoten über einen offenen öffentlichen Knotenport (NodePort). Sie müssen eine [Calico-PreDNAT-Netzrichtlinie ](cs_network_policy.html#block_ingress) verwenden, um die öffentlichen Knotenports für den Knoten zu blockieren.

**Ingress**
* Wenn Sie einen Cluster erstellen, werden automatisch eine öffentliche und eine private Ingress-Lastausgleichsfunktion für Anwendungen (ALB) erstellt. Da die öffentliche ALB aktiviert ist und die private ALB standardmäßig inaktiviert ist, müssen Sie [die öffentliche ALB inaktivieren](cs_cli_reference.html#cs_alb_configure) und [die private ALB aktivieren](cs_ingress.html#private_ingress).
* Erstellen Sie anschließend [einen privaten Ingress-Service](cs_ingress.html#ingress_expose_private).

Weitere Informationen zu den einzelnen Services finden Sie unter [ NodePort-, LoadBalancer- oder Ingress-Service auswählen](#external).

### Optional: Netzarbeitslasten für Edge-Workerknoten isolieren
{: #private_both_vlans_edge}

Mit Edge-Workerknoten kann die Sicherheit des Clusters verbessert werden, indem der externe Zugriff auf Workerknoten beschränkt und die Netzarbeitslast isoliert wird.
Um sicherzustellen, dass Ingress- und Lastausgleichsfunktions-Pods nur auf den angegebenen Workerknoten bereitgestellt werden, [kennzeichnen Sie die Workerknoten als Edge-Knoten](cs_edge.html#edge_nodes). Um außerdem zu verhindern, dass andere Arbeitslasten auf Edge-Knoten ausgeführt werden, [wenden Sie Taints auf die Edge-Knoten an](cs_edge.html#edge_workloads).

Verwenden Sie dann eine [Calico-PreDNAT-Netzrichtlinie](cs_network_policy.html#block_ingress), um den Datenverkehr an öffentlichen Knotenports in Clustern zu blockieren, in denen Edge-Workerknoten ausgeführt werden. Durch das Blockieren von Knotenports wird sichergestellt, dass die Edge-Workerknoten die einzigen Workerknoten sind, die eingehenden Datenverkehr verarbeiten.

### Optional: Verbindung zu einer lokalen Datenbank mithilfe des strongSwan-VPN-Service herstellen
{: #private_both_vlans_vpn}

Um eine sichere Verbindung Ihrer Workerknoten und Apps zu einem lokalen Netz herzustellen, können Sie einen [strongSwan-IPSec-VPN-Service ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.strongswan.org/about.html) einrichten. Der strongSwan-IPSec-VPN-Service stellt einen sicheren End-to-End-Kommunikationskanal über das Internet bereit, der auf der standardisierten IPSec-Protokollsuite (IPSec - Internet Protocol Security) basiert. Um eine sichere Verbindung zwischen Ihrem Cluster und einem lokalen Netz einzurichten, [konfigurieren und implementieren Sie den StrongSwan-IPSec-VPN-Service](cs_vpn.html#vpn-setup) direkt in einem Pod in Ihrem Cluster.

<br />


## Nur private externe Netze für private VLAN-Konfiguration planen
{: #private_vlan}

Wenn Sie einen Kubernetes-Cluster in {{site.data.keyword.containershort_notm}} erstellen, müssen Sie Ihren Cluster mit einem privaten VLAN verbinden. Das private VLAN bestimmt die private IP-Adresse, die dem jeweiligen Workerknoten zugeordnet ist. Diese Adresse stellt jedem Workerknoten eine private Netzschnittstelle bereit.
{:shortdesc}

Wenn Ihre Workerknoten nur mit einem privaten VLAN verbunden sind, können Sie die private Netzschnittstelle für die Workerknoten verwenden, um Apps nur mit dem privaten Netz zu verbinden. Sie können dann eine Gateway-Appliance verwenden, um Ihren Cluster vor unerwünschtem öffentlichen Zugriff zu schützen.

In den folgenden Abschnitten werden die Funktionen in {{site.data.keyword.containershort_notm}} beschrieben, die Sie verwenden können, um Ihren Cluster vor unerwünschtem öffentlichen Zugriff zu schützen, Apps einem privaten Netz zugänglich zu machen und eine Verbindung zu Ressourcen in einem lokalen Netz herzustellen.

### Gateway-Appliance konfigurieren
{: #private_vlan_gateway}

Wenn Workerknoten nur mit einem privaten VLAN eingerichtet werden, müssen Sie eine alternative Lösung für die Netzkonnektivität konfigurieren. Sie können eine Firewall mit angepassten Netzrichtlinien einrichten, um für Ihren Standardcluster dedizierte Netzsicherheit bereitzustellen und unbefugten Zugriff zu erkennen und zu unterbinden. Sie können beispielsweise [Virtual Router Appliance](/docs/infrastructure/virtual-router-appliance/about.html) oder [Fortigate Security Appliance](/docs/infrastructure/fortigate-10g/about.html) als Ihre Firewall und zum Blockieren unerwünschten Datenverkehrs einrichten. Wenn Sie eine Firewall einrichten, [müssen Sie auch die erforderlichen Ports und IP-Adressen für die einzelnen Regionen öffnen](cs_firewall.html#firewall_outbound), damit der Master und die Workerknoten kommunizieren können. 

**Hinweis**: Wenn Sie über eine vorhandene VRA-Instanz verfügen und dann einen Cluster hinzufügen, werden die neuen portierbaren Teilnetze, die für den Cluster bestellt wurden, nicht auf der Router Appliance konfiguriert. Um Netzservices verwenden zu können, müssen Sie die Weiterleitung zwischen Teilnetzen im selben VLAN aktivieren, indem Sie [VLAN-Spanning aktivieren](cs_subnets.html#vra-routing).

### Apps mit privaten Netzservices zugänglich machen
{: #private_vlan_services}

Um Ihre App nur über ein privates Netz zugänglich zu machen, können Sie private NodePort-, LoadBalancer- oder Ingress-Services verwenden. Da Ihre Workerknoten nicht mit einem öffentlichen VLAN verbunden sind, wird kein öffentlicher Datenverkehr an diese Services weitergeleitet.

**NodePort**:
* [Erstellen Sie einen privaten NodePort-Service](cs_nodeport.html). Der Service ist über die private IP-Adresse eines Workerknotens verfügbar.
* Öffnen Sie in der Firewall den Port, den Sie bei der Bereitstellung des Service an den privaten IP-Adressen für alle Workerknoten konfiguriert haben, mit denen Datenverkehr möglich sein soll. Führen Sie `kubectl get svc` aus, um den Port zu suchen. Der Port liegt im Bereich 20000-32000.

**LoadBalancer**
* [Erstellen Sie einen privaten LoadBalancer-Service](cs_loadbalancer.html). Wenn Ihr Cluster ausschließlich in einem privaten VLAN verfügbar ist, wird eine der vier verfügbaren, portierbaren, privaten IP-Adressen verwendet.
* Öffnen Sie in der privaten Firewall den Port, den Sie bei der Bereitstellung des LoadBalancer-Service an der privaten IP-Adresse konfiguriert haben.

**Ingress**:
* Wenn Sie einen Cluster erstellen, wird automatisch eine private Ingress-Lastausgleichsfunktion für Anwendungen (ALB) erstellt, die jedoch standardmäßig nicht aktiviert ist. Sie müssen [die private ALB aktivieren](cs_ingress.html#private_ingress).
* Erstellen Sie anschließend [einen privaten Ingress-Service](cs_ingress.html#ingress_expose_private).
* Öffnen Sie in Ihrer privaten Firewall Port 80 für HTTP oder Port 443 für HTTPS an der IP-Adresse für die private ALB.


Weitere Informationen zu den einzelnen Services finden Sie unter [ NodePort-, LoadBalancer- oder Ingress-Service auswählen](#external).

### Optional: Verbindung zu einer lokalen Datenbank mithilfe der Gateway-Appliance herstellen
{: #private_vlan_vpn}

Um eine sichere Verbindung Ihrer Workerknoten und Apps zu einem lokalen Netz herzustellen, müssen Sie ein VPN-Gateway einrichten. Sie können die [Virtual Router Appliance (VRA)](/docs/infrastructure/virtual-router-appliance/about.html) oder [Fortigate Security Appliance (FSA)](/docs/infrastructure/fortigate-10g/about.html) verwenden, die Sie als Firewall eingerichtet haben, um auch einen IPSec-VPN-Endpunkt zu konfigurieren. Informationen zum Konfigurieren einer VRA finden Sie unter [VPN-Konnektivität mit VRA konfigurieren](cs_vpn.html#vyatta).

<br />


## Netzbetrieb in Clustern planen
{: #in-cluster}

Alle Pods, die auf einem Workerknoten bereitgestellt werden, erhalten im Bereich 172.30.0.0/16 eine private IP-Adresse und werden nur zwischen den Workerknoten weitergeleitet. Vermeiden Sie Konflikte, indem Sie diesen IP-Bereich nicht auf Knoten verwenden, die mit Ihren Workerknoten kommunizieren. Workerknoten und Pods können im privaten Netz durch die Verwendung von privaten IP-Adressen sicher kommunizieren. Wenn ein Pod ausfällt oder ein Workerknoten neu erstellt werden muss, wird jedoch eine neue private IP-Adresse zugewiesen.

Standardmäßig ist es schwierig, sich ändernde private IP-Adressen für Apps nachzuverfolgen, die hoch verfügbar sein müssen. Stattdessen können Sie die integrierten Erkennungsfunktionen des Kubernetes-Service nutzen, um Anwendungen als Cluster-IP-Services im privaten Netz zugänglich zu machen. Ein Kubernetes-Service fasst eine Gruppe von Pods zusammen und stellt diesen Pods eine Netzverbindung für andere Services im Cluster zur Verfügung, ohne hierbei die tatsächlichen, privaten IP-Adressen der einzelnen Pods preiszugeben. Services wird eine IP-Cluster-IP-Adresse zugeordnet, auf die nur innerhalb des Clusters zugegriffen werden kann.
* **Ältere Cluster**: In Clustern, die vor Februar 2018 in der Zone 'dal13' oder vor Oktober 2017 in einer anderen Zone erstellt wurden, wird den Services eine der 254 IPs im Bereich 10.10.10.0/24 zugeordnet. Wenn Sie den Grenzwert von 254 Services erreicht haben und mehr Services benötigen, müssen Sie einen neuen Cluster erstellen.
* **Ältere Cluster**: In Clustern, die nach Februar 2018 in der Zone 'dal13' oder nach Oktober 2017 in einer anderen Zone erstellt wurden, wird den Services eine der 65.000 IPs im Bereich 172.21.0.0/16 zugeordnet. 

Vermeiden Sie Konflikte, indem Sie diesen IP-Bereich nicht auf Knoten verwenden, die mit Ihren Workerknoten kommunizieren. Es wird auch ein Eintrag für die DNS-Suche für den Service erstellt und in der Komponente `kube-dns` des Clusters gespeichert. Der DNS-Eintrag enthält den Namen des Service, den Namensbereich, in dem der Service erstellt wurde, und den Link zu der zugeordneten IP-Adresse, die im Cluster enthalten ist.

Um auf einen Pod hinter einem Cluster-IP-Service zuzugreifen, können Apps entweder die IP-Adresse des Service im Cluster verwenden oder eine Anforderung mit dem Namen des Service senden. Wenn Sie den Namen des Service verwenden, wird dieser in der Komponente `kube-dns` gesucht und an die IP-Adresse des Service im Cluster weitergeleitet. Wenn eine Anforderung den Service erreicht, stellt der Service sicher, dass alle Anforderungen gleichmäßig an die Pods weitergeleitet werden, unabhängig von ihren jeweiligen IP-Adressen im Cluster und dem Workerknoten, auf dem sie implementiert sind.
