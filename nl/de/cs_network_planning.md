---

copyright:
  years: 2014, 2018
lastupdated: "2018-12-05"

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


# Zugänglichmachen Ihrer Apps mit externer Vernetzung planen
{: #planning}

Mit {{site.data.keyword.containerlong}} können Sie die externe Vernetzung verwalten, indem Sie Apps öffentlich oder privat zugänglich machen.
{: shortdesc}

## NodePort-, LoadBalancer- oder Ingress-Service auswählen
{: #external}

Wenn Sie Ihre Apps extern über das öffentliche Internet oder ein privates Netz zugänglich machen möchten, unterstützt {{site.data.keyword.containerlong_notm}} drei Netzservices.
{:shortdesc}

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

Wenn Sie einen Kubernetes-Cluster in {{site.data.keyword.containerlong_notm}} erstellen, können Sie den Cluster mit einem öffentlichen VLAN verbinden. Das öffentliche VLAN bestimmt die öffentliche IP-Adresse, die dem jeweiligen Workerknoten zugeordnet ist. Diese Adresse stellt jedem Workerknoten eine öffentliche Netzschnittstelle bereit.
{:shortdesc}

Um eine App öffentlich für das Internet verfügbar zu machen, können Sie einen NodePort-, LoadBalancer- oder Ingress-Service erstellen. Informationen zum Vergleichen der einzelnen Services finden Sie im Abschnitt [NodePort-, LoadBalancer- oder Ingress-Service auswählen](#external).

Das folgende Diagramm zeigt, wie Kubernetes den öffentlichen Netzverkehr in {{site.data.keyword.containerlong_notm}} weiterleitet.

![{{site.data.keyword.containerlong_notm}} Kubernetes-Architektur](images/networking.png)

*Kubernetes-Datenebene in {{site.data.keyword.containerlong_notm}}*

Die öffentliche Netzschnittstelle für die Workerknoten in kostenlosen Clustern und in Standardclustern wird durch Calico-Netzrichtlinien geschützt. Diese Richtlinien blockieren standardmäßig den Großteil des eingehenden Datenverkehrs. Allerdings ist der eingehende Datenverkehr zulässig, der zur ordnungsgemäßen Funktion von Kubernetes erforderlich ist. Dies gilt auch für die Verbindungen zu NodePort-, LoadBalancer- und Ingress-Services. Weitere Informationen zu diesen Richtlinien und zur Vorgehensweise bei der Änderung dieser Richtlinien finden Sie in [Netzrichtlinien](cs_network_policy.html#network_policies).

Weitere Informationen zum Einrichten Ihres Clusters für den Netzbetrieb, einschließlich Informationen zu Teilnetzen, Firewalls und VPNs, finden Sie unter [Standardclustervernetzung planen](cs_network_cluster.html#both_vlans).

<br />


## Private externe Vernetzung für ein öffentliches und privates VLAN-Setup planen
{: #private_both_vlans}

Wenn die Workerknoten sowohl mit einem öffentlichen als auch mit einem privaten VLAN verbunden sind, können Sie Ihre App ausschließlich über ein privates Netz zugänglich machen, indem Sie private NodePort-, LoadBalancer- oder Ingress-Services verwenden. Anschließend können Sie Calico-Richtlinien erstellen, um den öffentlichen Datenverkehr an die Services zu blockieren.

**NodePort**
* [Erstellen Sie einen NodePort-Service](cs_nodeport.html). Zusätzlich zur öffentlichen IP-Adresse steht ein NodePort-Service über die private IP-Adresse eines Workerknotens zur Verfügung.
* Ein NodePort-Service öffnet einen Port auf einem Workerknoten sowohl über die private als auch über die öffentliche IP-Adresse des Workerknotens. Sie müssen eine [Calico-PreDNAT-Netzrichtlinie](cs_network_policy.html#block_ingress) verwenden, um die öffentlichen Knotenports (NodePorts) zu blockieren.

**LoadBalancer**
* [Erstellen Sie einen privaten LoadBalancer-Service](cs_loadbalancer.html).
* Ein LoadBalancer-Service mit einer portierbaren privaten IP-Adresse verfügt weiterhin auf jedem Workerknoten über einen offenen öffentlichen Knotenport (NodePort). Sie müssen eine [Calico-PreDNAT-Netzrichtlinie ](cs_network_policy.html#block_ingress) verwenden, um die öffentlichen Knotenports für den Knoten zu blockieren.

**Ingress**
* Wenn Sie einen Cluster erstellen, werden automatisch eine öffentliche und eine private Ingress-Lastausgleichsfunktion für Anwendungen (ALB) erstellt. Da die öffentliche ALB aktiviert ist und die private ALB standardmäßig inaktiviert ist, müssen Sie [die öffentliche ALB inaktivieren](cs_cli_reference.html#cs_alb_configure) und [die private ALB aktivieren](cs_ingress.html#private_ingress).
* Erstellen Sie anschließend [einen privaten Ingress-Service](cs_ingress.html#ingress_expose_private).

Beispiel: Angenommen, Sie haben einen privaten Lastausgleichsservice erstellt. Außerdem haben Sie eine Calico-PreDNAT-Richtlinie erstellt, um den öffentlichen Datenverkehr zu blockieren, sodass er nicht zu den öffentlichen NodePorts gelangt, die von der Lastausgleichsfunktion geöffnet werden. Auf diese private Lastausgleichsfunktion ist der Zugriff wie folgt möglich:
* Von einem beliebigen Pod in demselben Cluster
* Von einem Pod in einem beliebigen Cluster in demselben IBM Cloud-Konto
* Von allen Systemen, die mit einem der privaten VLANs in demselben IBM Cloud-Konto verbunden sind (wenn das [VLAN-Spanning aktiviert](cs_subnets.html#subnet-routing) ist)
* Von allen Systemen über eine VPN-Verbindung zu dem Teilnetz, auf dem sich die Lastausgleichsfunktion befindet (wenn Sie sich nicht im IBM Cloud-Konto, aber dennoch hinter der Unternehmensfirewall befinden)
* Von allen Systemen über eine VPN-Verbindung zu dem Teilnetz, auf dem sich die Lastausgleichsfunktion befindet (wenn Sie sich in einem anderen IBM Cloud-Konto befinden)

Weitere Informationen zum Einrichten Ihres Clusters für den Netzbetrieb, einschließlich Informationen zu Teilnetzen, Firewalls und VPNs, finden Sie unter [Standardclustervernetzung planen](cs_network_cluster.html#both_vlans).

<br />


## Private externe Netze ausschließlich für private VLAN-Konfiguration planen
{: #private_vlan}

Wenn die Workerknoten nur mit einem privaten VLAN verbunden sind, können Sie Ihre App ausschließlich über ein privates Netz zugänglich machen, indem Sie private NodePort-, LoadBalancer- oder Ingress-Services verwenden. Da Ihre Workerknoten nicht mit einem öffentlichen VLAN verbunden sind, wird kein öffentlicher Datenverkehr an diese Services weitergeleitet.

**NodePort**:
* [Erstellen Sie einen privaten NodePort-Service](cs_nodeport.html). Der Service ist über die private IP-Adresse eines Workerknotens verfügbar.
* Öffnen Sie in der Firewall den Port, den Sie bei der Bereitstellung des Service an den privaten IP-Adressen für alle Workerknoten konfiguriert haben, mit denen Datenverkehr möglich sein soll. Führen Sie `kubectl get svc` aus, um den Port zu suchen. Der Port liegt im Bereich 20000-32000.

**LoadBalancer**
* [Erstellen Sie einen privaten LoadBalancer-Service](cs_loadbalancer.html). Wenn Ihr Cluster ausschließlich in einem privaten VLAN verfügbar ist, wird eine der vier verfügbaren, portierbaren, privaten IP-Adressen verwendet.
* Öffnen Sie in der privaten Firewall den Port, den Sie bei der Bereitstellung des LoadBalancer-Service an der privaten IP-Adresse konfiguriert haben.

**Ingress**:
* Sie müssen einen [DNS-Service konfigurieren, der im privaten Netz verfügbar ist ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/).
* Wenn Sie einen Cluster erstellen, wird automatisch eine private Ingress-Lastausgleichsfunktion für Anwendungen (ALB) erstellt, die jedoch standardmäßig nicht aktiviert ist. Sie müssen [die private ALB aktivieren](cs_ingress.html#private_ingress).
* Erstellen Sie anschließend [einen privaten Ingress-Service](cs_ingress.html#ingress_expose_private).
* Öffnen Sie in Ihrer privaten Firewall Port 80 für HTTP oder Port 443 für HTTPS an der IP-Adresse für die private ALB.

Weitere Informationen zum Einrichten Ihres Clusters für den Netzbetrieb, einschließlich Informationen zu Teilnetzen und Gateway-Appliances, finden Sie unter [Ausschließlich private Clusternetze planen](cs_network_cluster.html#private_vlan).
