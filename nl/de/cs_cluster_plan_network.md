---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

keywords: kubernetes, iks, multi az, multi-az, szr, mzr

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


# Einrichtung Ihres Clusternetzes planen
{: #plan_clusters}

Entwerfen Sie eine Netzkonfiguration für Ihre Kubernetes-Cluster in {{site.data.keyword.containerlong}}, die den Bedarf Ihrer Workloads und Ihrer Umgebung erfüllt.
{: shortdesc}

Ihre containerisierten Apps werden auf Rechenhosts namens Workerknoten gehostet. Workerknoten werden vom Kubernetes-Master verwaltet. Die Einrichtung der Kommunikation zwischen Workerknoten und dem Kubernetes-Master, anderen Services, dem Internet oder anderen privaten Netzen hängt davon ab, wie Sie Ihr IBM Cloud-Infrastrukturnetz einrichten.


Erstellen Sie zum ersten Mal einen Cluster? Sehen Sie sich dazu zunächst das [Lernprogramm zum Erstellen von Kubernetes-Clustern](/docs/containers?topic=containers-cs_cluster_tutorial) an. Kehren Sie anschließend hierher zurück, wenn Sie bereit für die Planung Ihrer einsatzfähigen Cluster sind.
{: tip}

[Machen Sie sich mit den grundlegenden Informationen zu Clusternetzen vertraut](#plan_basics), bevor Sie mit der Planung der Einrichtung Ihres Clusternetzes beginnen. Dann können Sie drei mögliche Clusternetzkonfigurationen prüfen, die für Szenarios auf Umgebungsbasis geeignet sind: [Workloads von mit dem Internet verbundenen Apps ausführen](#internet-facing), [lokales Rechenzentrum mit begrenztem öffentlichen Zugriff erweitern](#limited-public) und [lokales Rechenzentrum nur im privaten Netz erweitern](#private_clusters).

## Grundlegende Informationen zu Clusternetzen
{: #plan_basics}

Wenn Sie Ihren Cluster erstellen, müssen Sie die Netzeinrichtung auswählen, damit Clusterkomponenten miteinander und mit Netzen oder Services außerhalb des Clusters kommunizieren können.
{: shortdesc}

* [Kommunikation zwischen Workerknoten](#worker-worker): Alle Workerknoten müssen in der Lage sein, über das private Netz miteinander zu kommunizieren. In vielen Fällen muss die Kommunikation über mehrere private VLANs hinweg und in verschiedenen Zonen zugelassen werden, damit Worker Verbindungen zueinander herstellen können.
* [Worker-zu-Master- und Benutzer-zu-Master-Kommunikation](#workeruser-master): Ihre Workerknoten und Ihre berechtigten Clusterbenutzer können über das öffentliche Netz mit TLS oder über das private Netz über private Serviceendpunkte sicher mit dem Kubernetes-Master kommunizieren.
* [Kommunikation zwischen Workerknoten und anderen {{site.data.keyword.cloud_notm}}-Services oder lokalen Netzen](#worker-services-onprem): Ermöglichen Sie Ihren Workerknoten die sichere Kommunikation mit anderen {{site.data.keyword.cloud_notm}}-Services, wie z. B. {{site.data.keyword.registrylong}}, und mit einem lokalen Netz.
* [Externe Kommunikation mit Apps, die auf Workerknoten ausgeführt werden](#external-workers): Lassen Sie öffentliche oder private Anforderungen von außerhalb an den Cluster sowie Anforderungen aus dem Cluster an einen öffentlichen Endpunkt zu.

### Kommunikation zwischen Workerknoten
{: #worker-worker}

Beim Erstellen eines Clusters werden die Workerknoten des Clusters automatisch mit einem privaten VLAN und optional mit einem öffentlichen VLAN verbunden. Ein VLAN konfiguriert eine Gruppe von Workerknoten und Pods so, als wären diese an dasselbe physische Kabel angeschlossen, und es bietet einen Kanal für die Konnektivität zwischen Workerknoten.
{: shortdesc}

**VLAN-Verbindungen für Workerknoten**</br>
Alle Workerknoten müssen mit einem privaten VLAN verbunden sein, sodass jeder Workerknoten Informationen von anderen Workerknoten empfangen und Informationen an andere Workerknoten senden kann. Wenn Sie einen Cluster mit Workerknoten erstellen, die auch mit einem öffentlichen VLAN verbunden sind, können Ihre Workerknoten mit dem Kubernetes-Master automatisch über das öffentliche VLAN und über das private VLAN kommunizieren, wenn Sie einen privaten Serviceendpunkt aktivieren. Das öffentliche VLAN stellt außerdem öffentliche Netzkonnektivität bereit, sodass Sie Apps in Ihrem Cluster im Internet zugänglich machen können. Wenn Sie Ihre Apps jedoch vor der öffentlichen Schnittstelle schützen wollen, sind verschiedene Optionen zum Schützen Ihres Clusters verfügbar, wie zum Beispiel die Verwendung von Calico-Netzrichtlinien oder die Eingrenzung von externen Netzworkloads auf Edge-Workerknoten.
* Kostenlose Cluster: Bei kostenlosen Clustern werden die Workerknoten des Clusters standardmäßig mit einem öffentlichen und einem privaten VLAN verbunden, deren Eigner IBM ist. Da IBM die VLANs, Teilnetze und IP-Adressen steuert, können Sie keine Mehrzonencluster erstellen oder Ihrem Cluster Teilnetze hinzufügen; darüber hinaus können Sie zum Verfügbarmachen Ihrer App nur NodePort-Services verwenden.</dd>
* Standardcluster: Wenn Sie bei Standardclustern in einer Zone zum ersten Mal einen Cluster erstellen, werden in dieser Zone automatisch ein öffentliches und ein privates VLAN für Sie in Ihrem Konto der IBM Cloud-Infrastruktur bereitgestellt. Wenn Sie angeben, dass Workerknoten nur mit einem privaten VLAN verbunden sein müssen, wird ein privates VLAN nur in dieser Zone automatisch bereitgestellt. Für jeden weiteren Cluster, den Sie in dieser Zone erstellen, können Sie das VLAN-Paar angeben, das Sie verwenden möchten. Sie können dasselbe öffentliche und private VLAN wiederverwenden, die für Sie erstellt wurden, da ein VLAN von mehreren Clustern gemeinsam genutzt werden kann.

Weitere Informationen zu VLANs, Teilnetzen und IP-Adressen finden Sie unter [Übersicht über den Netzbetrieb in {{site.data.keyword.containerlong_notm}}](/docs/containers?topic=containers-subnets#basics).

**Kommunikation zwischen Workerknoten über Teilnetze und VLANs**</br>
In verschiedenen Situationen müssen Komponenten in Ihrem Cluster berechtigt werden, über mehrere private VLANs hinweg zu kommunizieren. Wenn Sie zum Beispiel einen Mehrzonencluster erstellen wollen, wenn Sie mehrere VLANs für einen Cluster haben oder wenn Sie mehrere Teilnetze im selben VLAN haben, können die Workerknoten in verschiedenen Teilnetzen desselben VLAN oder in verschiedenen VLANs nicht automatisch miteinander kommunizieren. Sie müssen entweder VRF (Virtual Routing and Forwarding) oder das VLAN-Spanning für Ihr IBM Cloud-Infrastrukturkonto aktivieren.

* [VRF (Virtual Routing and Forwarding)](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud): VRF ermöglicht allen privaten VLANs und Teilnetzen in Ihrem Infrastrukturkonto die Kommunikation miteinander. Außerdem ist VRF erforderlich, um die Kommunikation Ihrer Worker und Ihres Masters über den privaten Serviceendpunkt sowie die Kommunikation mit anderen {{site.data.keyword.cloud_notm}}-Instanzen, die private Serviceendpunkte unterstützen, zu ermöglichen. Zum Prüfen, ob VRF bereits aktiviert ist, verwenden Sie den Befehl `ibmcloud account show`. Führen Sie `ibmcloud account update --service-endpoint-enable true` aus, um VRF zu aktivieren. Die Ausgabe dieses Befehls fordert Sie zum Öffnen eines Supportfalls auf, um Ihr Konto für die Verwendung von VRF und Serviceendpunkten zu aktivieren. VRF schließt die Option des VLAN-Spannings für Ihr Konto aus, da alle VLANs kommunizieren können.</br></br>
Wenn VRF aktiviert ist, kann jedes System, das mit einem der privaten VLANs in demselben {{site.data.keyword.cloud_notm}}-Konto verbunden ist, mit den Workerknoten im Cluster kommunizieren. Sie können Ihren Cluster von anderen Systemen im privaten Netz mithilfe von [Calico-Richtlinien für private Netze](/docs/containers?topic=containers-network_policies#isolate_workers) isolieren.</dd>
* [VLAN-Spanning](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning): Aktivieren Sie VLAN-Spanning, wenn Sie VRF nicht aktivieren können oder wollen, z. B. weil der Master nicht im privaten Netz zugänglich sein muss oder wenn Sie eine Gateway-Einheit für den Zugriff auf den Master über das öffentliche VLAN verwenden. Wenn Sie beispielsweise über eine vorhandene Gateway-Einheit verfügen und dann einen Cluster hinzufügen, sind die neuen portierbaren Teilnetze, die für den Cluster bestellt sind, nicht in der Gateway-Einheit konfiguriert, aber VLAN-Spanning ermöglicht das Routing zwischen den Teilnetzen. Zum Aktivieren von VLAN-Spanning müssen Sie über die [Infrastrukturberechtigung](/docs/containers?topic=containers-users#infra_access) **Netz > VLAN-Spanning im Netz verwalten** verfügen oder Sie können den Kontoeigner bitten, diese zu aktivieren. Zum Prüfen, ob das VLAN-Spanning bereits aktiviert ist, verwenden Sie den [Befehl](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`. Sie können den privaten Serviceendpunkt nicht aktivieren, wenn Sie VLAN-Spanning anstelle von VRF aktivieren.

</br>

### Worker-zu-Master- und Benutzer-zu-Master-Kommunikation
{: #workeruser-master}

Es muss ein Kommunikationskanal eingerichtet werden, damit Workerknoten eine Verbindung zum Kubernetes-Master herstellen können. Sie können die Kommunikation zwischen Ihren Workerknoten und dem Kubernetes-Master dadurch ermöglichen, dass Sie nur den öffentlichen Serviceendpunkt, öffentliche und private Serviceendpunkte oder nur den privaten Serviceendpunkt aktivieren.
{: shortdesc}

Zum Schutz der Kommunikation über öffentliche und private Serviceendpunkte richtet {{site.data.keyword.containerlong_notm}} bei der Erstellung des Clusters automatisch eine OpenVPN-Verbindung zwischen dem Kubernetes-Master und den Workerknoten ein. Workerknoten senden Nachrichten mithilfe von TLS-Zertifikaten sicher an den Master und der Master sendet Nachrichten über die OpenVPN-Verbindung an die Workerknoten.

**Nur öffentlicher Servicepunkt**</br>
Wenn Sie VRF für Ihr Konto nicht aktivieren wollen oder können, können Ihre Workerknoten automatisch eine Verbindung zum Kubernetes-Master über das öffentliche VLAN durch den öffentlichen Serviceendpunkt herstellen.
* Die Kommunikation zwischen Workerknoten und Master wird sicher über das öffentliche Netz und den öffentlichen Serviceendpunkt eingerichtet.
* Der Master ist für berechtigte Clusterbenutzer nur über den öffentlichen Serviceendpunkt öffentlich zugänglich. Ihre Clusterbenutzer können sicher auf Ihren Kubernetes-Master über das Internet zugreifen, um zum Beispiel `kubectl`-Befehle auszuführen.

**Öffentliche und private Serviceendpunkte**</br>
Wenn Sie Ihren Master öffentlich oder privat für Clusterbenutzer zugänglich machen wollen, können Sie die öffentlichen und die privaten Serviceendpunkte aktivieren. VRF ist in Ihrem {{site.data.keyword.cloud_notm}}-Konto erforderlich und Sie müssen Ihr Konto zur Verwendung von Serviceendpunkten aktivieren. Führen Sie `ibmcloud account update --service-endpoint-enable true` aus, um VRF und Serviceendpunkte zu aktivieren.
* Wenn Workerknoten mit öffentlichen und privaten VLANs verbunden sind, wird die Kommunikation zwischen Workerknoten und Master sowohl über das private Netz durch den privaten Serviceendpunkt als auch über das öffentliche Netz durch den öffentlichen Serviceendpunkt hergestellt. Dadurch, dass die Hälfte des Worker-zu-Master-Datenverkehrs über den öffentlichen Endpunkt und die andere Hälfte über den privaten Endpunkt geleitet wird, ist Ihre Master-zu-Worker-Kommunikation vor potenziellen Ausfällen des öffentlichen oder privaten Netzes geschützt. Wenn Workerknoten nur mit privaten VLANs verbunden sind, wird die Kommunikation zwischen Workerknoten und Master über das private Netz nur durch den privaten Serviceendpunkt hergestellt.
* Der Master ist für berechtigte Clusterbenutzer über den öffentlichen Serviceendpunkt öffentlich zugänglich. Der Master ist privat über den privaten Serviceendpunkt zugänglich, wenn sich berechtigte Clusterbenutzer in Ihrem privaten {{site.data.keyword.cloud_notm}}-Netz befinden oder durch eine VPN-Verbindung oder {{site.data.keyword.cloud_notm}} Direct Link mit dem privaten Netz verbunden sind. Beachten Sie, dass Sie [den Master-Endpunkt über eine private Lastausgleichsfunktion zugänglich machen müssen](/docs/containers?topic=containers-clusters#access_on_prem), damit Benutzer über eine VPN- oder {{site.data.keyword.cloud_notm}} Direct Link-Verbindung auf den Master zugreifen können.

**Nur privater Serviceendpunkt**</br>
Wenn Sie Ihren Master nur privat zugänglich machen wollen, können Sie den privaten Serviceendpunkt aktivieren. VRF ist in Ihrem {{site.data.keyword.cloud_notm}}-Konto erforderlich und Sie müssen Ihr Konto zur Verwendung von Serviceendpunkten aktivieren. Führen Sie `ibmcloud account update --service-endpoint-enable true` aus, um VRF und Serviceendpunkte zu aktivieren. Beachten Sie, dass nur bei Verwendung eines privaten Serviceendpunkts keine Gebühren in Rechnung gestellt oder für gemessene Bandbreite erhoben werden.
* Die Kommunikation zwischen Workerknoten und Master wird über das private Netz und den privaten Serviceendpunkt hergestellt.
* Der Master ist privat zugänglich, wenn sich berechtigte Clusterbenutzer in Ihrem privaten {{site.data.keyword.cloud_notm}}-Netz befinden oder durch eine VPN-Verbindung oder Direct Link mit dem privaten Netz verbunden sind. Beachten Sie, dass Sie [den Master-Endpunkt über eine private Lastausgleichsfunktion zugänglich machen müssen](/docs/containers?topic=containers-clusters#access_on_prem), damit Benutzer über eine VPN- oder Direct Link-Verbindung auf den Master zugreifen können.

</br>

### Kommunikation zwischen Workerknoten und anderen {{site.data.keyword.cloud_notm}}-Services oder lokalen Netzen
{: #worker-services-onprem}

Ermöglichen Sie Ihren Workerknoten die sichere Kommunikation mit anderen {{site.data.keyword.cloud_notm}}-Services, wie z. B. {{site.data.keyword.registrylong}}, und mit einem lokalen Netz.
{: shortdesc}

**Kommunikation mit anderen {{site.data.keyword.cloud_notm}}-Services über das private oder öffentliche Netz**</br>
Ihre Workerknoten können automatisch und sicher über das private Netz Ihrer IBM Cloud-Infrastruktur mit anderen {{site.data.keyword.cloud_notm}}-Services kommunizieren, die private Serviceendpunkte unterstützen, wie z. B. {{site.data.keyword.registrylong}}. Wenn ein {{site.data.keyword.cloud_notm}}-Service private Serviceendpunkte nicht unterstützt, müssen Ihre Workerknoten mit einem öffentlichen VLAN verbunden sein, sodass sie sicher über das öffentliche Netz mit den Services kommunizieren können.

Wenn Sie die Calico-Richtlinien oder eine Gateway-Einheit verwenden, um die öffentlichen oder privaten Netze Ihrer Workerknoten zu steuern, müssen Sie den Zugriff auf die öffentlichen IP-Adressen der Services zulassen, die öffentliche Serviceendpunkte unterstützen, und optional auf die privaten IP-Adressen der Services, die private Serviceendpunkte unterstützen.
* [Zugriff auf öffentliche IP-Adressen von Services in Calico-Richtlinien zulassen](/docs/containers?topic=containers-network_policies#isolate_workers_public)
* [Zugriff auf die privaten IP-Adressen von Services zulassen, die private Serviceendpunkte in Calico-Richtlinien unterstützen](/docs/containers?topic=containers-network_policies#isolate_workers)
* [Zugriff auf öffentliche IP-Adressen von Services und auf die privaten IP-Adressen von Services zulassen, die private Serviceendpunkte in einer Firewall einer Gateway-Einheit unterstützen](/docs/containers?topic=containers-firewall#firewall_outbound)

**{{site.data.keyword.BluDirectLink}} für die Kommunikation über das private Netz mit Ressourcen in lokalen Rechenzentren**</br>
Zum Verbinden Ihres Clusters mit Ihrem lokalen Rechenzentrum, z. B. mit {{site.data.keyword.icpfull_notm}}, können Sie [{{site.data.keyword.cloud_notm}} Direct Link](/docs/infrastructure/direct-link?topic=direct-link-get-started-with-ibm-cloud-direct-link) einrichten. Mit {{site.data.keyword.cloud_notm}} Direct Link erstellen Sie eine direkte, private Verbindung zwischen Ihren fernen Netzumgebungen und {{site.data.keyword.containerlong_notm}} ohne Routing über das öffentliche Internet.

**strongSwan-IPSec-VPN-Verbindung für die Kommunikation über das öffentliche Netz mit Ressourcen in lokalen Rechenzentren**
* Workerknoten, die mit öffentlichen und privaten VLANs verbunden sind: Richten Sie einen [strongSwan-IPSec-VPN-Service ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.strongswan.org/about.html) direkt in Ihrem Cluster ein. Der strongSwan-IPSec-VPN-Service stellt einen sicheren End-to-End-Kommunikationskanal über das Internet bereit, der auf der standardisierten IPSec-Protokollsuite (IPSec – Internet Protocol Security) basiert. Um eine sichere Verbindung zwischen Ihrem Cluster und einem lokalen Netz einzurichten, [konfigurieren Sie den strongSwan-IPSec-VPN-Service und stellen ihn](/docs/containers?topic=containers-vpn#vpn-setup) direkt in einem Pod in Ihrem Cluster bereit.
* Workerknoten, die nur mit einem privaten VLAN verbunden sind: Richten Sie einen IPSec-VPN-Endpunkt auf einer Gateway-Einheit, wie z. B. eine Virtual Router Appliance (Vyatta), ein. Richten Sie anschließend [den strongSwan-IPSec-VPN-Service in Ihrem Cluster ein](/docs/containers?topic=containers-vpn#vpn-setup), um den VPN-Endpunkt auf Ihrem Gateway zu verwenden. Wenn Sie strongSwan nicht verwenden wollen, können Sie die [VPN-Konnektivität direkt mit VRA einrichten](/docs/containers?topic=containers-vpn#vyatta).

</br>

### Externe Kommunikation mit Apps, die auf Workerknoten ausgeführt werden
{: #external-workers}

Lassen Sie öffentliche oder private Datenverkehrsanforderungen von außerhalb des Clusters an Ihre Apps zu, die auf Workerknoten ausgeführt werden.
{: shortdesc}

**Privater Datenverkehr an Cluster-Apps**</br>
Wenn Sie eine App in Ihrem Cluster bereitstellen, haben Sie die Möglichkeit, die App nur für solche Benutzer und Services zugänglich zu machen, die sich in demselben privaten Netz wie Ihr Cluster befinden. Der private Lastausgleich eignet sich ideal, um Ihre App für Anforderungen von außerhalb des Clusters verfügbar zu machen, ohne die App der allgemeinen Öffentlichkeit zugänglich zu machen. Sie können den privaten Lastausgleich auch verwenden, um den Zugriff, das Anforderungsrouting und andere Konfigurationen für Ihre App zu testen, bevor Sie Ihre App später mit öffentlichen Netzservices der Öffentlichkeit zugänglich machen. Sie können private Kubernetes-Netzservices, wie z. B. private Knotenports (NodePorts), NLBs und Ingress-ALBs erstellen, um private Datenverkehrsanforderungen von außerhalb des Clusters an Ihre Apps zuzulassen. Anschließend können Sie Calico-Richtlinien des Typs Pre-DNAT verwenden, um Datenverkehr an öffentliche Knotenports privater Netzservices zu blockieren. Weitere Informationen finden unter [Privaten externen Lastausgleich planen](/docs/containers?topic=containers-cs_network_planning#private_access).

**Öffentlicher Datenverkehr an Cluster-Apps**</br>
Damit von außen über das öffentliche Internet auf Ihre Apps zugegriffen werden kann, können Sie öffentliche Knotenports (NodePorts), Netzlastausgleichsfunktionen (NLBs) und Ingress-Lastausgleichsfunktionen für Anwendungen (ALBs) erstellen. Öffentliche Netzservices stellen eine Verbindung zu dieser öffentlichen Netzschnittstelle her, indem sie Ihre App mit einer öffentlichen IP-Adresse und wahlweise einer öffentlichen URL bereitstellen. Wenn eine App öffentlich zugänglich gemacht wird, kann jeder, der über die öffentliche Service-IP-Adresse oder die URL verfügt, die Sie für Ihre App eingerichtet haben, eine Anforderung an Ihre App senden. Sie können dann Calico-Richtlinien des Typs Pre-DNAT verwenden, um den Datenverkehr zu öffentlichen Netzservices zu steuern, z. B. durch Whitelisting des Datenverkehrs von bestimmten Quellen-IP-Adressen oder CIDRs und Blockieren des übrigen Datenverkehrs. Weitere Informationen finden unter [Öffentlichen externen Lastausgleich planen](/docs/containers?topic=containers-cs_network_planning#private_access).

Grenzen Sie Netzauslastungen auf Edge-Workerknoten ein, um mehr Sicherheit zu erreichen. Mit Edge-Workerknoten kann die Sicherheit des Clusters verbessert werden, indem der externe Zugriff auf weniger Workerknoten, die mit öffentlichen VLANs verbunden sind, beschränkt und die Netzworkload eingegrenzt wird. Wenn Sie [Workerknoten als Edge-Knoten kennzeichnen](/docs/containers?topic=containers-edge#edge_nodes), werden NLB- und ALB-Pods nur auf diesen angegebenen Workerknoten bereitgestellt. Um außerdem zu verhindern, dass andere Workloads auf Edge-Knoten ausgeführt werden, können Sie [Taints auf die Edge-Knoten anwenden](/docs/containers?topic=containers-edge#edge_workloads). In Kubernetes Version 1.14 und höher können Sie sowohl öffentliche als auch private NLBs und ALBs auf Edge-Knoten bereitstellen.
Beispiel: Wenn Ihre Workerknoten nur mit einem privaten VLAN verbunden sind, Sie allerdings öffentlichen Zugriff auf eine App in Ihrem Cluster zulassen müssen, können Sie einen Edge-Worker-Pool erstellen, in dem die Edge-Knoten mit öffentlichen und privaten VLANs verbunden sind. Sie können öffentliche NLBs und ALBs auf diesen Edge-Knoten bereitstellen, um sicherzustellen, dass nur diese Worker öffentliche Verbindungen verarbeiten.

Wenn Ihre Workerknoten nur mit einem privaten VLAN verbunden sind und Sie eine Gateway-Einheit für die Kommunikation zwischen Workerknoten und dem Cluster-Master verwenden, können Sie auch die Einheit als öffentliche oder private Firewall konfigurieren. Sie können öffentliche oder private Knotenports (NodePorts), NLBs und Ingress-ALBs erstellen, um öffentliche oder private Datenverkehrsanforderungen von außerhalb des Clusters an Ihre Apps zuzulassen. Dann müssen Sie [die erforderlichen Ports und IP-Adressen in der Firewall Ihrer Gateway-Einheit öffnen](/docs/containers?topic=containers-firewall#firewall_inbound), um eingehenden Datenverkehr für diese Services über das öffentliche oder private Netz zuzulassen.
{: note}

<br />


## Szenario: Workloads von mit dem Internet verbundenen Apps in einem Cluster ausführen
{: #internet-facing}

In diesem Szenario wollen Sie Workloads in einem Cluster ausführen, die für Anforderungen aus dem Internet zugänglich sind, sodass Endbenutzer auf Ihre Apps zugreifen können. Sie wollen die Option, dass der öffentliche Zugriff in Ihrem Cluster isoliert werden kann und dass gesteuert werden kann, welche öffentlichen Anforderungen an Ihren Cluster zugelassen werden. Außerdem haben Ihre Worker automatischen Zugriff auf alle {{site.data.keyword.cloud_notm}}-Services, die eine Verbindung zu Ihrem Cluster herstellen können.
{: shortdesc}

<p>
<figure>
 <img src="images/cs_clusters_planning_internet.png" alt="Abbildung der Architektur für einen Cluster, der mit dem Internet verbundene Workloads ausführt"/> <figcaption>Architektur für einen Cluster, der mit dem Internet verbundene Workloads ausführt</figcaption>
</figure>
</p>

Um diese Konfiguration zu erreichen, erstellen Sie einen Cluster, indem Sie Workerknoten mit öffentlichen und privaten VLANs verbinden.

Wenn Sie den Cluster sowohl mit öffentlichen als auch mit privaten VLANs erstellen, können Sie später nicht alle öffentlichen VLANs aus diesem Cluster entfernen. Durch das Entfernen aller öffentlichen VLANs aus einem Cluster werden mehrere Clusterkomponenten gestoppt. Erstellen Sie stattdessen einen neuen Worker-Pool, der nur mit einem privaten VLAN verbunden ist.
{: note}

Sie können auswählen, ob Sie Worker-zu-Master- und Benutzer-zu-Master-Kommunikation über das öffentliche und das private Netz oder nur über das öffentliche Netz zulassen wollen.
* Öffentliche und private Serviceendpunkte: Für Ihr Konto muss VRF und die Verwendung von Serviceendpunkten aktiviert sein. Die Kommunikation zwischen Workerknoten und Master wird sowohl über das private Netz durch den privaten Serviceendpunkt als auch über das öffentliche Netz durch den öffentlichen Serviceendpunkt hergestellt. Der Master ist für berechtigte Clusterbenutzer über den öffentlichen Serviceendpunkt öffentlich zugänglich.
* Öffentlicher Serviceendpunkt: Wenn Sie VRF für Ihr Konto nicht aktivieren wollen oder können, können Ihre Workerknoten und berechtigte Cluster automatisch eine Verbindung zum Kubernetes-Master über das öffentliche Netz durch den öffentlichen Serviceendpunkt herstellen.

Ihre Workerknoten können automatisch sicher über das private Netz Ihrer IBM Cloud-Infrastruktur mit anderen {{site.data.keyword.cloud_notm}}-Services kommunizieren, die private Serviceendpunkte unterstützen. Wenn ein {{site.data.keyword.cloud_notm}}-Service private Serviceendpunkte nicht unterstützt, können Worker über das öffentliche Netz sicher mit den Services kommunizieren. Sie können die öffentlichen oder privaten Schnittstellen von Workerknoten mithilfe von Calico-Netzrichtlinien für die Isolation öffentlicher oder privater Netze sperren. Sie müssen Zugriff auf die öffentlichen und privaten IP-Adressen der Services zulassen, die Sie in diesen Calico-Richtlinien verwenden wollen.

Wenn Sie eine App in Ihrem Cluster im Internet zugänglich machen wollen, können Sie einen Service für eine öffentliche Netzlastausgleichsfunktion (NLB) oder einen Service für eine Ingress-Lastausgleichsfunktion für Anwendungen (ALB) erstellen. Sie können die Sicherheit Ihres Clusters verbessern, indem Sie einen Pool mit Workerknoten erstellen, die als Edge-Knoten bezeichnet werden. Die Pods für öffentliche Netzservices werden auf den Edge-Knoten bereitgestellt, sodass externe Datenverkehr-Workloads auf nur wenige Worker in Ihrem Cluster eingegrenzt werden. Außerdem können Sie den öffentlichen Datenverkehr zu den Netzservices steuern, die Ihre Apps zugänglich machen, indem Sie Calico-Richtlinien des Typs Pre-DNAT erstellen, wie z. B. Whitelist- und Blacklist-Richtlinien.

Wenn Ihre Workerknoten Zugriff auf Services in privaten Netzen außerhalb Ihres {{site.data.keyword.cloud_notm}}-Kontos benötigen, können Sie den strongSwan-IPSec-VPN-Service in Ihrem Cluster bereitstellen oder {{site.data.keyword.cloud_notm}} Direct Link-Services nutzen, um eine Verbindung zu diesen Netzen herzustellen.

Sind Sie bereit, mit einem Cluster für dieses Szenario loszulegen? Nach der Planung der Einrichtung der [Hochverfügbarkeit](/docs/containers?topic=containers-ha_clusters) und des [Workerknotens](/docs/containers?topic=containers-planning_worker_nodes) finden Sie in [Cluster erstellen](/docs/containers?topic=containers-clusters#cluster_prepare) weitere Informationen.

<br />


## Szenario: Lokales Rechenzentrum in einen Cluster im privaten Netz erweitern und begrenzten öffentlichen Zugriff hinzufügen
{: #limited-public}

In diesem Szenario wollen Sie Workloads in einem Cluster ausführen, die für Services, Datenbanken oder andere Ressourcen in Ihrem lokalen Rechenzentrum zugänglich sind. Sie müssen jedoch begrenzten öffentlichen Zugriff auf Ihren Cluster bereitstellen und wollen sicherstellen, dass öffentlicher Zugriff gesteuert und in Ihrem Cluster eingegrenzt wird. Beispielsweise benötigen Ihre Worker möglicherweise Zugriff auf einen {{site.data.keyword.cloud_notm}}-Service, der keine privaten Serviceendpunkte unterstützt und auf den über das öffentliche Netz zugegriffen werden muss. Oder Sie müssen begrenzten öffentlichen Zugriff auf eine App bereitstellen, die in Ihrem Cluster ausgeführt wird.
{: shortdesc}

Um dieses Cluster-Setup zu erreichen, erstellen Sie eine Firewall [mithilfe von Edge-Knoten und Calico-Netzrichtlinien](#calico-pc) oder [mithilfe einer Gateway-Einheit](#vyatta-gateway).

### Edge-Knoten und Calico-Netzrichtlinien verwenden
{: #calico-pc}

Lassen Sie begrenzte öffentliche Konnektivität zu Ihrem Cluster zu, indem Sie Edge-Knoten als öffentliches Gateway und Calico-Netzrichtlinien als öffentliche Firewall verwenden.
{: shortdesc}

<p>
<figure>
 <img src="images/cs_clusters_planning_calico.png" alt="Abbildung der Architektur für einen Cluster, bei dem Edge-Knoten und Calico-Netzrichtlinien für sicheren öffentlichen Zugriff verwendet werden"/>
 <figcaption>Architektur für einen Cluster, bei dem Edge-Knoten und Calico-Netzrichtlinien für sicheren öffentlichen Zugriff verwendet werden</figcaption>
</figure>
</p>

Mit dieser Konfiguration erstellen Sie einen Cluster, indem Sie Workerknoten nur mit einem privaten VLAN verbinden. Für Ihr Konto muss VRF und die Verwendung von privaten Serviceendpunkten aktiviert sein.

Der Kubernetes-Master ist über den privaten Serviceendpunkt zugänglich, wenn berechtigte Clusterbenutzer sich in Ihrem privaten {{site.data.keyword.cloud_notm}}-Netz befinden oder über eine [VPN-Verbindung](/docs/infrastructure/iaas-vpn?topic=VPN-getting-started) oder [{{site.data.keyword.cloud_notm}} Direct Link](/docs/infrastructure/direct-link?topic=direct-link-get-started-with-ibm-cloud-direct-link) mit dem privaten Netz verbunden sind. Die Kommunikation mit dem Kubernetes-Master über den privaten Serviceendpunkt muss jedoch über den IP-Adressbereich <code>166.X.X</code> erfolgen, der über eine VPN-Verbindung oder über {{site.data.keyword.cloud_notm}} Direct Link nicht angesteuert werden kann. Sie können den privaten Serviceendpunkt des Masters für Ihre Clusterbenutzer mithilfe einer privaten Netzlastausgleichsfunktion (NLB) zugänglich machen. Die private NLB macht den privaten Serviceendpunkt des Masters als internen <code>10.X.X.X</code>-IP-Adressbereich zugänglich, auf den Benutzer über eine VPN- oder {{site.data.keyword.cloud_notm}} Direct Link-Verbindung zugreifen können. Wenn Sie nur den privaten Serviceendpunkt aktivieren, können Sie das Kubernetes-Dashboard verwenden oder vorübergehend den öffentlichen Serviceendpunkt aktivieren, um die private NLB zu erstellen.

Als Nächstes können Sie einen Pool mit Workerknoten erstellen, die mit öffentlichen und privaten VLANs verbunden und als Edge-Knoten bezeichnet sind. Mit Edge-Knoten kann die Sicherheit des Clusters verbessert werden, indem der externe Zugriff auf nur wenige Workerknoten beschränkt und die Netzarbeitslast auf diese Worker eingegrenzt wird.

Ihre Workerknoten können automatisch sicher über das private Netz Ihrer IBM Cloud-Infrastruktur mit anderen {{site.data.keyword.cloud_notm}}-Services kommunizieren, die private Serviceendpunkte unterstützen. Wenn ein {{site.data.keyword.cloud_notm}}-Service private Serviceendpunkte nicht unterstützt, können Ihre mit einem öffentlichen VLAN verbundenen Edge-Knoten sicher über das öffentliche Netz mit den Services kommunizieren. Sie können die öffentlichen oder privaten Schnittstellen von Workerknoten mithilfe von Calico-Netzrichtlinien für die Isolation öffentlicher oder privater Netze sperren. Sie müssen Zugriff auf die öffentlichen und privaten IP-Adressen der Services zulassen, die Sie in diesen Calico-Richtlinien verwenden wollen.

Wenn Sie privaten Zugriff auf eine App in Ihrem Cluster bereitstellen wollen, können Sie eine Netzlastausgleichsfunktion (NLB) oder Ingress-Lastausgleichsfunktion für Anwendungen (ALB) erstellen, um Ihre App nur im privaten Netz zugänglich zu machen. Sie können den gesamten öffentlichen Datenverkehr zu diesen Netzservices blockieren, die Ihre Apps zugänglich machen, indem Sie Calico-Richtlinien des Typs Pre-DNAT erstellen, wie z. B. Richtlinien zum Blockieren öffentlicher Knotenports auf Workerknoten. Wenn Sie begrenzten öffentlichen Zugriff auf eine App in Ihrem Cluster bereitstellen müssen, können Sie eine öffentliche NLB oder ALB erstellen, um Ihre App zugänglich zu machen. Sie müssen dann Ihre Apps auf diesen Edge-Knoten bereitstellen, damit die NLBs oder ALBs den öffentlichen Datenverkehr zu Ihren App-Pods leiten können. Außerdem können Sie den öffentlichen Datenverkehr zu den Netzservices steuern, die Ihre Apps zugänglich machen, indem Sie Calico-Richtlinien des Typs Pre-DNAT erstellen, wie z. B. Whitelist- und Blacklist-Richtlinien. Die Pods für private und öffentliche Netzservices werden auf den Edge-Knoten bereitgestellt, sodass externe Datenverkehr-Workloads auf nur wenige Worker in Ihrem Cluster eingeschränkt werden.  

Damit sicher auf Services außerhalb von {{site.data.keyword.cloud_notm}} und in lokalen Netzen zugegriffen werden kann, können Sie den strongSwan-IPSec-VPN-Service in Ihrem Cluster konfigurieren und bereitstellen. Der strongSwan-Lastausgleichsfunktions-Pod wird auf einem Worker im Edge-Pool bereitgestellt. Dort stellt der Pod durch einen verschlüsselten VPN-Tunnel über das öffentliche Netz eine sichere Verbindung zum lokalen Netz her. Alternativ dazu können Sie {{site.data.keyword.cloud_notm}} Direct Link-Services verwenden, um Ihren Cluster nur über das private Netz mit Ihrem lokalen Rechenzentrum zu verbinden.

Sind Sie bereit, mit einem Cluster für dieses Szenario loszulegen? Nach der Planung der Einrichtung der [Hochverfügbarkeit](/docs/containers?topic=containers-ha_clusters) und des [Workerknotens](/docs/containers?topic=containers-planning_worker_nodes) finden Sie in [Cluster erstellen](/docs/containers?topic=containers-clusters#cluster_prepare) weitere Informationen.

</br>

### Gateway-Einheit verwenden
{: #vyatta-gateway}

Lassen Sie begrenzte öffentliche Konnektivität zu Ihrem Cluster zu, indem Sie eine Gateway-Einheit, wie z. B. eine Virtual Router Appliance (Vyatta), als öffentliches Gateway und öffentliche Firewall konfigurieren.
{: shortdesc}

<p>
<figure>
 <img src="images/cs_clusters_planning_gateway.png" alt="Abbildung der Architektur für einen Cluster, bei dem eine Gateway-Einheit für sicheren öffentlichen Zugriff verwendet wird"/> <figcaption>Architektur für einen Cluster, bei dem eine Gateway-Einheit für sicheren öffentlichen Zugriff verwendet wird</figcaption>
</figure>
</p>

Wenn Sie Ihre Workerknoten nur in einem privaten VLAN einrichten und VRF nicht für Ihr Konto aktivieren wollen oder können, müssen Sie eine Gateway-Einheit konfigurieren, um die Netzkonnektivität zwischen Ihren Workerknoten und dem Master über das öffentliche Netz bereitzustellen. Sie können beispielsweise eine [Virtual Router Appliance](/docs/infrastructure/virtual-router-appliance?topic=virtual-router-appliance-about-the-vra) oder eine [Fortigate Security Appliance](/docs/services/vmwaresolutions/services?topic=vmware-solutions-fsa_considerations) einrichten.

Sie können eine Gateway-Einheit mit angepassten Netzrichtlinien einrichten, um für Ihren Cluster dedizierte Netzsicherheit bereitzustellen und unbefugten Zugriff zu erkennen und zu unterbinden. Wenn Sie eine Firewall im öffentlichen Netz einrichten, müssen Sie die erforderlichen Ports und IP-Adressen für die einzelnen Regionen öffnen, damit der Master und die Workerknoten kommunizieren können. Wenn Sie diese Firewall für das private Netz konfigurieren, müssen Sie auch die erforderlichen Ports und IP-Adressen öffnen, um die Kommunikation zwischen den Workerknoten zuzulassen und Ihren Cluster über das private Netz auf die Infrastrukturressourcen zugreifen zu lassen. Sie müssen auch VLAN-Spanning für Ihr Konto aktivieren, damit Teilnetze in demselben VLAN und über VLANs Daten weiterleiten können.

Um eine sichere Verbindung Ihrer Workerknoten und Apps zu einem lokalen Netz oder zu Services außerhalb von {{site.data.keyword.cloud_notm}} herzustellen, richten Sie einen IPSec-VPN-Endpunkt in Ihrer Gateway-Einheit und den strongSwan-IPSec-VPN-Service in Ihrem Cluster für die Verwendung des Gateway-VPN-Endpunkts ein. Wenn Sie strongSwan nicht verwenden wollen, können Sie die VPN-Konnektivität direkt mit VRA einrichten.

Ihre Workerknoten können durch Ihre Gateway-Einheit sicher mit anderen {{site.data.keyword.cloud_notm}}-Services und öffentlichen Services außerhalb von {{site.data.keyword.cloud_notm}} kommunizieren. Sie können Ihre Firewall so konfigurieren, dass nur Zugriff auf die öffentlichen und privaten IP-Adressen der Services zugelassen wird, die Sie verwenden wollen.

Wenn Sie privaten Zugriff auf eine App in Ihrem Cluster bereitstellen wollen, können Sie eine Netzlastausgleichsfunktion (NLB) oder Ingress-Lastausgleichsfunktion für Anwendungen (ALB) erstellen, um Ihre App nur im privaten Netz zugänglich zu machen. Wenn Sie begrenzten öffentlichen Zugriff auf eine App in Ihrem Cluster bereitstellen müssen, können Sie eine öffentliche NLB oder ALB erstellen, um Ihre App zugänglich zu machen. Da der gesamte Datenverkehr die Firewall Ihrer Gateway-Einheit durchläuft, können Sie den privaten und öffentlichen Zugriff auf die Netzservices steuern, die Ihre Apps zugänglich machen, indem Sie die Ports und IP-Adressen der Services öffnen, um den eingehenden Datenverkehr zu diesen Services zuzulassen.

Sind Sie bereit, mit einem Cluster für dieses Szenario loszulegen? Nach der Planung der Einrichtung der [Hochverfügbarkeit](/docs/containers?topic=containers-ha_clusters) und des [Workerknotens](/docs/containers?topic=containers-planning_worker_nodes) finden Sie in [Cluster erstellen](/docs/containers?topic=containers-clusters#cluster_prepare) weitere Informationen.

<br />


## Szenario: Lokales Rechenzentrum in einen Cluster im privaten Netz erweitern
{: #private_clusters}

In diesem Szenario wollen Sie Workloads in einem {{site.data.keyword.containerlong_notm}}-Cluster ausführen. Sie wollen jedoch, dass diese Workloads nur für die Services, Datenbanken oder andere Ressourcen in Ihrem lokalen Rechenzentrum, wie z. B. {{site.data.keyword.icpfull_notm}}, zugänglich sind. Ihre Cluster-Workloads benötigen möglicherweise Zugriff auf einige andere {{site.data.keyword.cloud_notm}}-Services, die die Kommunikation über das private Netz unterstützen, wie z. B. {{site.data.keyword.cos_full_notm}}.
{: shortdesc}

<p>
<figure>
 <img src="images/cs_clusters_planning_extend.png" alt="Abbildung der Architektur für einen Cluster, der eine Verbindung zu einem lokalen Rechenzentrum im privaten Netz herstellt"/>
 <figcaption>Architektur für einen Cluster, der eine Verbindung zu einem lokalen Rechenzentrum im privaten Netz herstellt</figcaption>
</figure>
</p>

Um diese Konfiguration zu erreichen, erstellen Sie einen Cluster, indem Sie Workerknoten nur mit einem privaten VLAN verbinden. Zum Bereitstellen der Konnektivität zwischen dem Cluster-Master und Workerknoten im privaten Netz nur durch den privaten Serviceendpunkt muss Ihr Konto für VRF und die Verwendung von Serviceendpunkten aktiviert sein. Da Ihr Cluster für alle Ressourcen im privaten Netz sichtbar ist, wenn VRF aktiviert ist, können Sie Ihren Cluster von anderen Systemen im privaten Netz mithilfe von Calico-Richtlinien für private Netze isolieren.

Der Kubernetes-Master ist über den privaten Serviceendpunkt zugänglich, wenn berechtigte Clusterbenutzer sich in Ihrem privaten {{site.data.keyword.cloud_notm}}-Netz befinden oder über eine [VPN-Verbindung](/docs/infrastructure/iaas-vpn?topic=VPN-getting-started) oder [{{site.data.keyword.cloud_notm}} Direct Link](/docs/infrastructure/direct-link?topic=direct-link-get-started-with-ibm-cloud-direct-link) mit dem privaten Netz verbunden sind. Die Kommunikation mit dem Kubernetes-Master über den privaten Serviceendpunkt muss jedoch über den IP-Adressbereich <code>166.X.X</code> erfolgen, der über eine VPN-Verbindung oder über {{site.data.keyword.cloud_notm}} Direct Link nicht angesteuert werden kann. Sie können den privaten Serviceendpunkt des Masters für Ihre Clusterbenutzer mithilfe einer privaten Netzlastausgleichsfunktion (NLB) zugänglich machen. Die private NLB macht den privaten Serviceendpunkt des Masters als internen <code>10.X.X.X</code>-IP-Adressbereich zugänglich, auf den Benutzer über eine VPN- oder {{site.data.keyword.cloud_notm}} Direct Link-Verbindung zugreifen können. Wenn Sie nur den privaten Serviceendpunkt aktivieren, können Sie das Kubernetes-Dashboard verwenden oder vorübergehend den öffentlichen Serviceendpunkt aktivieren, um die private NLB zu erstellen.

Ihre Workerknoten können automatisch sicher über das private Netz Ihrer IBM Cloud-Infrastruktur mit anderen {{site.data.keyword.cloud_notm}}-Services (wie z. B. such as {{site.data.keyword.registrylong}}) kommunizieren, die private Serviceendpunkte unterstützen. Zum Beispiel unterstützen dedizierte Hardwareumgebungen für alle Standardplaninstanzen von {{site.data.keyword.cloudant_short_notm}} private Serviceendpunkte. Wenn ein {{site.data.keyword.cloud_notm}}-Service private Serviceendpunkte nicht unterstützt, kann Ihr Cluster nicht auf diesen Service zugreifen.

Wenn Sie privaten Zugriff auf eine App in Ihrem Cluster bereitstellen wollen, können Sie eine Netzlastausgleichsfunktion (NLB) oder Ingress-Lastausgleichsfunktion für Anwendungen (ALB) erstellen. Diese Kubernetes-Netzservices machen Ihre App nur für das private Netz zugänglich, sodass alle lokalen Systeme mit einer Verbindung zum Teilnetz, in dem sich die NLB-IP befindet, auf die App zugreifen können.

Sind Sie bereit, mit einem Cluster für dieses Szenario loszulegen? Nach der Planung der Einrichtung der [Hochverfügbarkeit](/docs/containers?topic=containers-ha_clusters) und des [Workerknotens](/docs/containers?topic=containers-planning_worker_nodes) finden Sie in [Cluster erstellen](/docs/containers?topic=containers-clusters#cluster_prepare) weitere Informationen.


