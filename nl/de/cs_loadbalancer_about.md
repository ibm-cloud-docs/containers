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



# Informationen zu NLBs
{: #loadbalancer-about}

Wenn Sie einen Standardcluster erstellen, stellt {{site.data.keyword.containerlong}} automatisch ein portierbares öffentliches Teilnetz und ein portierbares privates Teilnetz bereit.
{: shortdesc}

* Das portierbare öffentliche Teilnetz stellt fünf verwendbare IP-Adressen bereit. Eine portierbare öffentliche IP-Adresse wird von der [öffentlichen Ingress-Standard-ALB](/docs/containers?topic=containers-ingress) verwendet. Die verbleibenden vier portierbaren öffentlichen IP-Adressen können verwendet werden, um einzelne Apps dem Internet zugänglich zu machen, indem öffentliche Netzausgleichsfunktions- (NLB-) Services erstellt werden.
* Das portierbare private Teilnetz stellt fünf verwendbare IP-Adressen bereit. Eine portierbare private IP-Adresse wird von der [privaten Ingress-Standard-ALB](/docs/containers?topic=containers-ingress#private_ingress) verwendet. Die verbleibenden vier portierbaren privaten IP-Adressen können verwendet werden, um einzelne Apps einem privaten Netz zugänglich zu machen, indem private Services für die Lastausgleichsfunktion erstellt werden.

Portierbare öffentliche und private IP-Adressen sind statische variable IPs und ändern sich nicht, wenn ein Workerknoten entfernt wird. Wenn der Workerknoten, auf dem sich die NLB-IP-Adresse befindet, entfernt wird, wird die IP-Adresse von einem Keepalive-Dämon, der die IP kontinuierlich überwacht, automatisch in einen anderen Workerknoten verschoben. Sie können Ihrer NLB jeden beliebigen Port zuweisen. Die NLB fungiert als externer Einstiegspunkt für eingehende Anforderungen an die App. Wenn Sie vom Internet aus auf die NLB zugreifen möchten, können Sie die öffentliche IP-Adresse der NLB in Verbindung mit der zugewiesenen Portnummer im Format `<ip-adresse>:<port>` verwenden. Sie können DNS-Einträge für NLBs auch erstellen, indem Sie die NLB-IP-Adressen mit Hostnamen registrieren.

Wenn Sie eine App mithilfe eines NLB-Service zugänglich machen, wird Ihre App automatisch auch über die NodePorts des Service bereitgestellt. Auf [Knotenports (NodePorts)](/docs/containers?topic=containers-nodeport) kann über jede öffentliche und private IP-Adresse jedes Workerknotens innerhalb des Clusters zugegriffen werden. Informationen zum Blockieren des Datenverkehrs an Knotenports während der Verwendung einer NLB finden Sie im Abschnitt [Eingehenden Datenverkehr an Netzlastausgleichsfunktion (NLB) oder NodePort-Services steuern](/docs/containers?topic=containers-network_policies#block_ingress).

<br />


## Vergleich des Basis- und DSR-Lastausgleichs in NLBs der Versionen 1.0 und 2.0
{: #comparison}

Wenn Sie eine NLB erstellen, können Sie eine NLB der Version 1.0 auswählen, die einen Basislastausgleich ausführt, oder eine NLB der Version 2.0, die einen DSR-Lastausgleich (DSR - Direct Server Return) ausführt. Beachten Sie, dass die Version 2.0 der NLBs eine Betaversion ist.
{: shortdesc}

**Was haben die NLBs der Versionen 1.0 und 2.0 gemeinsam?**

Die NLBs der Versionen 1.0 und 2.0 sind beides Layer 4-Lastausgleichsfunktionen, die sich im Linux-Kernelbereich befinden. Beide Versionen werden innerhalb des Clusters ausgeführt und verwenden Ressourcen von Workerknoten. Deshalb ist die verfügbare Kapazität der NLBs immer Ihrem eigenen Cluster zugeordnet. Darüber hinaus beenden beide Versionen von NLBs nicht die Verbindung. Stattdessen leiten sie Verbindungen an einen App-Pod weiter.

**Worin unterscheiden sich NLBs der Versionen 1.0 und 2.0?**

Wenn ein Client eine Anforderung an Ihre App sendet, leitet die NLB Anforderungspakete an die IP-Adresse des Workerknotens weiter, auf dem ein App-Pod vorhanden ist. NLBs der Version 1.0 verwenden NAT (Network Address Translation, Netzadressumsetzung), um die Quellen-IP-Adresse des Anforderungspakets in die IP des Workerknotens umzuschreiben, auf dem ein Lastausgleichsfunktions-Pod vorhanden ist. Wenn der Workerknoten das App-Antwortpaket zurückgibt, wird die IP des Workerknotens, auf dem die NLB vorhanden ist, verwendet. Die NLB muss dann das Antwortpaket an den Client senden. Um zu verhindern, dass die IP-Adresse neu geschrieben wird, können Sie die [Beibehaltung der Quellen-IP aktivieren](/docs/containers?topic=containers-loadbalancer#node_affinity_tolerations). Die Beibehaltung der Quellen-IP erfordert jedoch, dass Lastausgleichsfunktions-Pods und App-Pods auf demselben Worker ausgeführt werden, sodass die Anforderung nicht an einen anderen Worker weitergeleitet werden muss. Sie müssen Knotenaffinität und -tolerierungen zu App-Pods hinzufügen. Weitere Informationen zum Basislastausgleich mit NLBs der Version 1.0 finden Sie unter [Version 1.0: Komponenten und Architektur des Basislastausgleichs](#v1_planning).

Im Gegensatz zu den NLBs der Version 1.0 verwenden die NLBs der Version 2.0 NAT nicht, wenn Anforderungen an App-Pods an andere Worker weitergeleitet werden. Wenn eine NLB der Version 2.0 eine Clientanforderung weiterleitet, verwendet sie IP über IP (IPIP), um das ursprüngliche Anforderungspaket in ein anderes Paket einzubinden. Dieses einbindende IPIP-Paket hat eine Quellen-IP des Workerknotens, auf dem sich der Lastausgleichsfunktions-Pod befindet. Dadurch kann das ursprüngliche Anforderungspaket die Client-IP-Adresse als Quellen-IP-Adresse beibehalten. Der Workerknoten verwendet dann DSR (Direct Server Return), um das App-Antwortpaket an die Client-IP zu senden. Das Antwortpaket überspringt die NLB und wird direkt an den Client gesendet, wodurch der Umfang des Datenverkehrs reduziert wird, den die NLB verarbeiten muss. Weitere Informationen zum DSR-Lastausgleich mit NLBs der Version 2.0 finden Sie unter [Version 2.0: Komponenten und Architektur des DSR-Lastausgleichs](#planning_ipvs).

<br />


## Komponenten und Architektur eines NLB der Version 1.0
{: #v1_planning}

Die TCP/UDP-Netzlastausgleichsfunktion (NLB) der Version 1.0 verwendet 'Iptables', ein Linux-Kernel-Feature, für den Lastausgleich von Anforderungen in den Pods einer App.
{: shortdesc}

### Datenfluss in einem Einzelzonencluster
{: #v1_single}

Das folgende Diagramm veranschaulicht, wie eine NLB der Version 1.0 die Kommunikation vom Internet an eine App in einem Einzelzonencluster leitet.
{: shortdesc}

<img src="images/cs_loadbalancer_planning.png" width="410" alt="App in {{site.data.keyword.containerlong_notm}} über eine NLB 1.0 zugänglich machen" style="width:410px; border-style: none"/>

1. Eine Anforderung an Ihre App verwendet die öffentliche IP-Adresse der NLB und den zugeordneten Port auf dem Workerknoten.

2. Die Anforderung wird automatisch an die interne Cluster-IP-Adresse und den internen Port der NLB weitergeleitet. Auf die interne Cluster-IP-Adresse kann nur aus dem Cluster selbst heraus zugegriffen werden.

3. `kube-proxy` leitet die Anforderung an den NLB-Service für die App weiter.

4. Die Anforderung wird an die private IP-Adresse des App-Pods weitergeleitet. Die Quellen-IP-Adresse des Anforderungspakets wird in die öffentliche IP-Adresse des Workerknotens geändert, auf dem der App-Pod ausgeführt wird. Wenn mehrere App-Instanzen im Cluster bereitgestellt werden, leitet die NLB die Anforderungen zwischen den App-Pods weiter.

### Datenfluss in einem Mehrzonencluster
{: #v1_multi}

Das folgende Diagramm veranschaulicht, wie eine Netzlastausgleichsfunktion (NLB) der Version 1.0 die Kommunikation vom Internet an eine App in einem Mehrzonencluster leitet.
{: shortdesc}

<img src="images/cs_loadbalancer_planning_multizone.png" width="500" alt="NLB 1.0 für den Lastausgleich von Apps in Mehrzonenclustern verwenden" style="width:500px; border-style: none"/>

Standardmäßig werden NLBs der Version 1.0 nur in einer Zone konfiguriert. Um eine hohe Verfügbarkeit zu erreichen, müssen Sie eine NLB der Version 1.0 in jeder Zone bereitstellen, in der sich App-Instanzen befinden. Anforderungen werden von den NLBs in verschiedenen Zonen in einem Umlaufzyklus bearbeitet. Darüber hinaus leitet jede NLB Anforderungen an die App-Instanzen in ihrer eigenen Zone und an App-Instanzen in anderen Zonen weiter.

<br />


## Komponenten und Architektur eines NLB der Version 2.0 (Beta)
{: #planning_ipvs}

Die Funktionen der Netzlastausgleichsfunktion (NLB) Version 2.0 sind Beta-Funktionen. Um eine NLB der Version 2.0 zu verwenden, müssen Sie [den Master und die Workerknoten Ihres Clusters aktualisieren](/docs/containers?topic=containers-update), sodass sie Kubernetes Version 1.12 oder höher ausführen.
{: note}

Die NLB der Version 2.0 ist eine Layer 4-Lastausgleichsfunktion, die den IPVS (IP Virtual Server) des Linux-Kernels verwendet. Die NLB 2.0 unterstützt TCP und UDP, wird vor mehreren Workerknoten ausgeführt und verwendet IPIP-Tunneling (IP über IP), um Datenverkehr zu verteilen, der über eine einzelne NLB-IP-Adresse für alle diese Workerknoten eingeht.

Wünschen Sie weitere Details zu den Bereitstellungsmustern für Lastausgleich, die in {{site.data.keyword.containerlong_notm}} verfügbar sind? Schauen Sie sich diesen [Blogeintrag ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/blogs/bluemix/2018/10/ibm-cloud-kubernetes-service-deployment-patterns-for-maximizing-throughput-and-availability/) an.
{: tip}

### Datenfluss in einem Einzelzonencluster
{: #ipvs_single}

Das folgende Diagramm veranschaulicht, wie eine NLB der Version 2.0 die Kommunikation vom Internet an eine App in einem Einzelzonencluster leitet.
{: shortdesc}

<img src="images/cs_loadbalancer_ipvs_planning.png" width="600" alt="App in {{site.data.keyword.containerlong_notm}} über eine NLB der Version 2.0 verfügbar machen" style="width:600px; border-style: none"/>

1. Eine Clientanforderung an Ihre App verwendet die öffentliche IP-Adresse der NLB und den zugeordneten Port auf dem Workerknoten. In diesem Beispiel hat die NLB die virtuelle IP-Adresse '169.61.23.130', die sich derzeit auf dem Worker 10.73.14.25 befindet.

2. Die NLB kapselt das Clientanforderungspaket (im Bild als "CR" gekennzeichnet) in ein IPIP-Paket (gekennzeichnet als "IPIP") ein. Das Clientanforderungspaket behält die Client-IP als Quellen-IP-Adresse bei. Das einschließende IPIP-Paket verwendet die IP des Workers 10.73.14.25 als Quellen-IP-Adresse.

3. Die NLB leitet das IPIP-Paket an einen Worker weiter, auf dem sich ein App-Pod befindet, 10.73.14.26. Wenn mehrere App-Instanzen im Cluster bereitgestellt werden, leitet die NLB die Anforderungen zwischen den Workern weiter, auf denen App-Pods bereitgestellt sind.

4. Worker 10.73.14.26 entpackt das einschließende IPIP-Paket und dann das Clientanforderungspaket. Das Clientanforderungspaket wird an den App-Pod auf diesem Workerknoten weitergeleitet.

5. Worker 10.73.14.26 verwendet dann die Quellen-IP-Adresse aus dem ursprünglichen Anforderungspaket, die Client-IP, um das Antwortpaket des App-Pods direkt an den Client zurückzugeben.

### Datenfluss in einem Mehrzonencluster
{: #ipvs_multi}

Der Datenfluss durch ein Mehrzonencluster folgt demselben Pfad wie [Datenverkehr durch ein Einzelzonencluster](#ipvs_single). In einem Mehrzonencluster leitet die NLB Anforderungen an die App-Instanzen in ihrer eigenen Zone und an App-Instanzen in anderen Zonen weiter. Das folgende Diagramm veranschaulicht, wie NLBs der Version 2.0 in den einzelnen Zonen Datenverkehr vom Internet an eine App in einem Mehrzonencluster weiterleiten.
{: shortdesc}

<img src="images/cs_loadbalancer_ipvs_multizone.png" alt="App in {{site.data.keyword.containerlong_notm}} über eine NLB der Version 2.0 zugänglich machen" style="width:500px; border-style: none"/>

Standardmäßig ist jede NLB der Version 2.0 nur in einer Zone konfiguriert. Sie können eine hohe Verfügbarkeit erreichen, indem Sie eine NLB der Version 2.0 in jeder Zone bereitstellen, in der sich App-Instanzen befinden.
