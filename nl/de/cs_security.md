---

copyright:
  years: 2014, 2017
lastupdated: "2017-08-15"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Sicherheit für {{site.data.keyword.containerlong_notm}}
{: #cs_security}

Sie können die integrierten Sicherheitsfunktionen für die Risikoanalyse und den Sicherheitsschutz verwenden. Diese Funktionen helfen Ihnen, die Clusterinfrastruktur und Netzkommunikation zu schützen, die Berechnungsressourcen zu isolieren und die Einhaltung von Sicherheitsbestimmungen über die einzelnen Infrastrukturkomponenten und Containerbereitstellungen hinweg sicherzustellen.
{: shortdesc}

<a href="https://console.bluemix.net/docs/api/content/containers/images/cs_security.png"><img src="images/cs_security.png" width="400" alt="{{site.data.keyword.containershort_notm}} Clustersicherheit" style="width:400px;" /></a>

<table summary="Die erste Zeile in der Tabelle erstreckt sich über beide Spalten. Der Rest der Zeilen sollte von links nach rechts gelesen werden, wobei die Serverposition in der ersten Spalte und die passenden IP-Adressen in der zweiten Spalte angegeben sind.">
      <thead>
  <th colspan=2><img src="images/idea.png"/> Integrierte Sicherheitseinstellungen in {{site.data.keyword.containershort_notm}}</th>
  </thead>
  <tbody>
    <tr>
      <td>Kubernetes-Master</td>
      <td>Der Kubernetes-Master in jedem Cluster wird von IBM verwaltet und ist hoch verfügbar. Er enthält Sicherheitseinstellungen für {{site.data.keyword.containershort_notm}}, mit denen die Einhaltung der Sicherheitsbestimmungen und eine sichere Kommunikation von und zu den Workerknoten sichergestellt wird. Aktualisierungen werden von IBM bei Bedarf durchgeführt. Vom dedizierten Kubernetes-Master werden alle Kubernetes-Ressourcen im Cluster zentral gesteuert und überwacht. Abhängig von den Bereitstellungsvoraussetzungen und der Kapazität im Cluster werden die containerisierten Apps vom Kubernetes-Master automatisch zur Bereitstellung für die verfügbaren Workerknoten geplant. Weitere Informationen enthält [Sicherheit des Kubernetes-Masters](#cs_security_master).</td>
    </tr>
    <tr>
      <td>Workerknoten</td>
      <td>Container werden auf Workerknoten bereitgestellt, die der Nutzung durch einen Cluster vorbehalten sind und gegenüber IBM Kunden die Berechnungs-, Netz- und Speicherisolation sicherstellen. {{site.data.keyword.containershort_notm}} stellt integrierte Sicherheitsfunktionen zur Verfügung, um die Sicherheit
Ihrer Workerknoten im privaten und im öffentlichen Netz sicherzustellen und für die Einhaltung von Sicherheitsbestimmungen für Workerknoten zu sorgen. Weitere Informationen enthält [Sicherheit von Workerknoten](#cs_security_worker).</td>
     </tr>
     <tr>
      <td>Images</td>
      <td>Als Clusteradministrator können Sie ein eigenes sicheres Docker-Image-Repository in {{site.data.keyword.registryshort_notm}} einrichten, in dem Sie Docker-Images sicher speichern und zur gemeinsamen Nutzung durch Ihre Clusterbenutzer freigeben können. Jedes Image in Ihrer privaten Registry wird von Vulnerability Advisor überprüft, um die Bereitstellung sicherer Container sicherzustellen. Vulnerability Advisor ist eine Komponente von {{site.data.keyword.registryshort_notm}}, die nach potenziellen Sicherheitslücken sucht, Sicherheitsempfehlungen ausgibt und Anweisungen zur Schließung von Sicherheitslücken bereitstellt. Weitere Informationen finden Sie unter [Imagesicherheit in {{site.data.keyword.containershort_notm}}](#cs_security_deployment).</td>
    </tr>
  </tbody>
</table>

## Kubernetes-Master
{: #cs_security_master}

Prüfen Sie die integrierten Sicherheitsfeatures, die den Kubernetes-Master schützt und die Netzkommunikation für den Cluster sichert.
{: shortdesc}

<dl>
  <dt>Vollständig verwalteter und dedizierter Kubernetes-Master</dt>
    <dd>Jeder Kubernetes-Cluster in {{site.data.keyword.containershort_notm}}
wird von einem dedizierten Kubernetes-Master gesteuert, der von IBM in einem IBM eigenen {{site.data.keyword.BluSoftlayer_full}}-Konto verwaltet wird. Der Kubernetes-Master ist mit den folgenden dedizierten Komponenten konfiguriert, die nicht mit anderen IBM Kunden gemeinsam genutzt werden.
    <ul><ul><li>Datenspeicher 'etcd': Speichert alle Kubernetes-Ressourcen eines Clusters, z. B. Services, Bereitstellungen und Pods. Kubernetes-Konfigurationsübersichten und geheime Kubernetes-Schlüssel sind App-Daten, die in Form von Schlüssel/Wert-Paaren gespeichert werden, damit sie von einer in einem Pod ausgeführten App verwendet werden können. Daten in 'etcd' werden auf einem verschlüsselten
Datenträger gespeichert, der von IBM verwaltet wird, und mit TLS verschlüsselt, wenn sie an einen Pod gesendet werden, um Datenschutz und die Datenintegrität sicherzustellen.
    <li>'kube-apiserver': Dient als Haupteinstiegspunkt für alle Anforderungen vom Workerknoten zum Kubernetes-Master. Die Komponente 'kube-apiserver' validiert und verarbeitet Anforderungen und besitzt Lese- und Schreibberechtigungen für den Datenspeicher 'etcd'.
    <li><kube-scheduler': Entscheidet unter Berücksichtigung von Kapazitätsbedarf und Leistungsanforderungen, Beschränkungen durch Hardware- und Softwarerichtlinien, Anti-Affinitäts-Spezifikationen und Anforderungen für Arbeitslasten darüber, wo die Bereitstellung von Pods erfolgt. Wird kein Workerknoten gefunden, der mit den Anforderungen übereinstimmt, so wird der Pod nicht im Cluster bereitgestellt.
    <li>'kube-controller-manager': Verantwortlich für die Überwachung von Replikatgruppen und für die Erstellung entsprechender Pods, um den gewünschten Zustand (Soll-Status) zu erreichen.
    <li>'OpenVPN': Für {{site.data.keyword.containershort_notm}} spezifische Komponente, die sichere Netzkonnektivität für die gesamte Kommunikation vom Kubernetes-Master zu den Workerknoten bereitstellt.</ul></ul></dd>
  <dt>Mit TLS geschützte Netzkonnektivität für die gesamte Kommunikation von den Workerknoten zum Kubernetes-Master</dt>
    <dd>{{site.data.keyword.containershort_notm}} schützt die Netzkommunikation zum Kubernetes-Master durch Generieren von TLS-Zertifikaten, mit denen für jeden Cluster die Kommunikation zu und von den Komponenten 'kube-apiserver' und 'etcd' verschlüsselt wird. Diese Zertifikate werden zu keinem Zeitpunkt von mehreren Clustern oder Komponenten des Kubernetes-Masters gemeinsam genutzt.</dd>
  <dt>Mit OpenVPN geschützte Netzkonnektivität für die gesamte Kommunikation vom Kubernetes-Master zu den Workerknoten</dt>
    <dd>Kubernetes schützt die Kommunikation zwischen dem Kubernetes-Master und den Workerknoten zwar durch die Verwendung des Protokolls `https`, doch auf dem Workerknoten wird keine standardmäßige Authentifizierung bereitgestellt. Zum Schutz dieser Kommunikation richtet {{site.data.keyword.containershort_notm}} bei der Erstellung des Clusters automatisch eine OpenVPN-Verbindung zwischen dem Kubernetes-Master und den Workerknoten ein.</dd>
  <dt>Kontinuierliche Überwachung des Kubernetes-Master-Netzes</dt>
    <dd>Jeder Kubernetes-Master wird kontinuierlich von IBM überwacht, um Denial-of-Service-Attacken (DoS) auf Prozessebene zu steuern und zu korrigieren.</dd>
  <dt>Einhaltung der Sicherheitsbestimmungen durch die Kubernetes-Master-Knoten</dt>
    <dd>{{site.data.keyword.containershort_notm}} überprüft automatisch jeden Knoten, auf dem der Kubernetes-Master bereitgestellt ist, auf Schwachstellen bzw. Sicherheitslücken, die in Kubernetes festgestellt wurden, und auf betriebssystemspezifische Korrekturen (Fixes) für die Sicherheit, die gegebenenfalls angewendet werden müssen, um den Schutz des Masterknotens sicherzustellen. Werden Schwachstellen bzw. Sicherheitslücken festgestellt, wendet {{site.data.keyword.containershort_notm}} automatisch entsprechende Korrekturen (Fixes) und beseitigt Schwachstellen bzw. Sicherheitslücken zugunsten des Benutzers.</dd>
</dl>  

## Workerknoten
{: #cs_security_worker}

Prüfen Sie die integrierten Sicherheitsfeatures für Workerknoten, die die Workerknotenumgebung schützen und die Ressourcen-, Netz- und
Speicherisolation sicherstellen.
{: shortdesc}

<dl>
  <dt>Isolation der Berechnungs-, Netz- und Speicherinfrastruktur</dt>
    <dd>Wenn Sie einen Cluster bereitstellen, werden im
{{site.data.keyword.BluSoftlayer_notm}}-Konto oder im dedizierten
{{site.data.keyword.BluSoftlayer_notm}}-Konto von IBM virtuelle Maschinen als Workerknoten eingerichtet. Workerknoten sind einem Cluster zugeordnet und hosten nicht die Arbeitslast anderer Cluster.</br> Jedes {{site.data.keyword.Bluemix_notm}}-Konto wird mit {{site.data.keyword.BluSoftlayer_notm}}-VLANs eingerichtet, um die Qualität der Netzleistung und Isolation
sicherzustellen. </br>Damit Daten in Ihrem Cluster als persistent erhalten bleiben, können Sie den dedizierten NFS-basierten Dateispeicher von
{{site.data.keyword.BluSoftlayer_notm}} einrichten und die integrierten Funktionen für Datensicherheit dieser Plattform
nutzen.</dd>
  <dt>Einrichtung geschützter Workerknoten</dt>
    <dd>Alle Workerknoten werden mit dem Betriebssystem Ubuntu eingerichtet, das nicht vom Benutzer geändert werden kann. Um das Betriebssystem der Workerknoten gegen potenzielle Angriffe zu schützen,
wird jeder Workerknoten mit extrem fortgeschrittenen Firewalleinstellungen konfiguriert,
die durch iptables-Regeln von Linux umgesetzt werden.</br> Alle Container,
die auf Kubernetes ausgeführt werden, sind durch vordefinierte Calico-Netzrichtlinieneinstellungen geschützt,
die bei der Clustererstellung auf jedem Workerknoten konfiguriert werden. Diese Konstellation stellt die sichere Netzkommunikation zwischen Workerknoten und Pods sicher. Um die Aktionen, die ein Container auf einem Workerknoten ausführen kann, weiter einzuschränken, können die Benutzer
[AppArmor-Richtlinien ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tutorials/clusters/apparmor/)
auf den Workerknoten konfigurieren.
</br> Standardmäßig ist der SSH-Zugriff für den Rootbenutzer beim Workerknoten inaktiviert. Wenn Sie zusätzliche Features auf dem Workerknoten installieren wollen, können Sie [Kubernetes-Dämon-Sets verwenden ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset) für Vorgänge, die auf jedem Knoten ausgeführt werden müssen, bzw. [Kubernetes-Jobs ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/) für alle einmaligen Aktionen, die Sie ausführen müssen. </dd>
  <dt>Einhaltung der Sicherheitsbestimmungen für die Kubernetes-Workerknoten</dt>
    <dd>IBM arbeitet intern und extern mit Beratungsteams für Sicherheit zusammen, um potenzielle Probleme im Bereich der Einhaltung von
Sicherheitsbestimmungen (Compliance) für Workerknoten zu erkennen, und gibt kontinuierlich Compliance-Aktualisierungen und Sicherheitskorrekturen frei, um
jegliche identifizierte Schwachstellen und Sicherheitslücken zu beheben. Updates und Sicherheitspatches werden auf dem Betriebssystem des Workerknotens von IBM automatisch implementiert. Dazu verwaltet IBM den SSH-Zugriff auf die
Workerknoten.</br> <b>Hinweis</b>: Einige Updates erfordern einen Warmstart des Workerknotens. IBM führt jedoch keinen Warmstart des Workerknotens während der
Installation von Updates oder Sicherheitspatches durch. Benutzern wird empfohlen, einen Warmstart des Workerknotens regelmäßig durchzuführen, um
sicherzustellen, dass die Installation von Updates und Sicherheitspatches beendet wird.</dd>
  <dt>Unterstützung für SoftLayer-Netzfirewalls</dt>
    <dd>{{site.data.keyword.containershort_notm}} ist mit allen [{{site.data.keyword.BluSoftlayer_notm}}-Firewallangeboten ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link") kompatibel](https://www.ibm.com/cloud-computing/bluemix/network-security). Sie können unter
{{site.data.keyword.Bluemix_notm}} Public eine Firewall mit angepassten Netzrichtlinien einrichten, um für Ihren Cluster dedizierte Netzsicherheit zu erzielen und unbefugten Zugriff zu erkennen und zu unterbinden. Sie können beispielsweise [Vyatta ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://knowledgelayer.softlayer.com/topic/vyatta-1) als Ihre Firewall und zum Blockieren unerwünschten Datenverkehrs einrichten. Wenn Sie eine Firewall einrichten, [müssen Sie auch die erforderlichen Ports und IP-Adressen für die einzelnen Regionen öffnen](#opening_ports), damit der Master und die Workernoten kommunizieren können. Unter
{{site.data.keyword.Bluemix_notm}} Dedicated sind Firewalls, DataPower, Fortigate und DNS bereits als Teil der
dedizierten Standardbereitstellung der Umgebung konfiguriert. </dd>
  <dt>Services privat belassen oder Service und Apps selektiv dem öffentlichen Internet zugänglich machen</dt>
    <dd>Sie können entscheiden, ob Sie Ihre Services und Apps privat belassen wollen. Durch Nutzung der in diesem Abschnitt beschriebenen integrierten
Sicherheitsfeatures können Sie außerdem die geschützte Kommunikation zwischen Workerknoten und Pods sicherstellen. Um Services und Apps dem öffentlichen Internet zugänglich zu machen, können Sie die Ingress-Unterstützung und die
Unterstützung der Lastausgleichsfunktion nutzen, um Ihre Services auf sichere Weise öffentlich verfügbar zu machen.</dd>
  <dt>Sichere Verbindung Ihrer Workerknoten und Apps mit einem lokalen Rechenzentrum</dt>
    <dd>Sie können eine Vyatta-Gateway-Appliance oder eine Fortigate-Appliance einrichten, um einen IPSec-VPN-Endpunkt zu konfigurieren, der Ihren Kubernetes-Cluster mit einem lokalen Rechenzentrum verbindet. Über einen verschlüsselten Tunnel können alle Services, die in Ihrem Kubernetes-Cluster ausgeführt werden, sicher mit lokalen Apps wie Benutzerverzeichnissen, Datenbanken oder Mainframes kommunizieren. Weitere Informationen finden Sie unter [Cluster mit einem lokalen Rechenzentrum verbinden ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/blogs/bluemix/2017/07/kubernetes-and-bluemix-container-based-workloads-part4/). </dd>
  <dt>Kontinuierliche Überwachung und Protokollierung der Clusteraktivität</dt>
    <dd>Bei Standardclustern werden alle clusterbezogenen Ereignisse wie das Hinzufügen eines Workerknotens, der Fortschritt bei einem rollierenden Aktualisierung oder Informationen zur Kapazitätsnutzung von {{site.data.keyword.containershort_notm}} protokolliert, überwacht und an IBM Logging and Monitoring Service gesendet.</dd>
</dl>

### Erforderliche Ports und IP-Adressen in Ihrer Firewall öffnen
{: #opening_ports}

Wenn Sie eine Firewall für Ihre Workerknoten einrichten oder die Firewalleinstellungen in Ihrem {{site.data.keyword.BluSoftlayer_notm}}-Konto anpassen, müssen Sie bestimmte Ports und IP-Adressen öffnen, damit der Workerknoten und der Kubernetes-Master kommunizieren können. 

1.  Notieren Sie die öffentlichen IP-Adressen für alle Workerknoten im Cluster.

    ```
  bx cs workers <clustername_oder_-id>
  ```
    {: pre}

2.  Lassen Sie in Ihrer Firewall die folgenden Verbindungen von und zu Ihren Workerknoten zu.

  ```
  TCP port 443 FROM <öffentliche_ip_jedes_workerknotens> TO registry.<region>.bluemix.net, apt.dockerproject.org
  ```
  {: codeblock}

    <ul><li>Ermöglichen Sie für eine OUTBOUND-Konnektivität für Ihre Workerknoten einen ausgehenden Netzverkehr vom Quellen-Workerknoten zum TCP/UDP-Zielportbereich 20000-32767 für `<öffentliche_ip_jedes_workerknotens>` und die folgenden IP-Adressen und Netzgruppen: </br>
    

    <table summary="Die erste Zeile in der Tabelle erstreckt sich über beide Spalten. Der Rest der Zeilen sollte von links nach rechts gelesen werden, wobei die Serverposition in der ersten Spalte und die passenden IP-Adressen in der zweiten Spalte angegeben sind.">
      <thead>
      <th colspan=2><img src="images/idea.png"/> Ausgehende IP-Adressen</th>
      </thead>
    <tbody>
      <tr>
        <td>ams03</td>
        <td><code>169.50.169.110</code></td>
      </tr>
      <tr>
        <td>dal10</td>
        <td><code>169.46.7.238</code></td>
       </tr>
       <tr>
        <td>dal12</td>
        <td><code>169.47.70.10</code></td>
       </tr>
       <tr>
        <td>fra02</td>
        <td><code>169.50.56.174</code></td>
       </tr>
      </tbody>
      <tr>
       <td>lon02</td>
       <td><code>159.122.242.78</code></td>
      </tr>
      <tr>
       <td>lon04</td>
       <td><code>158.175.65.170</code></td>
      </tr>
      <tr>
       <td>syd01</td>
       <td><code>168.1.8.195</code></td>
      </tr>
      <tr>
       <td>syd04</td>
       <td><code>130.198.64.19</code></td>
      </tr>
    </table>
</ul>


## Netzrichtlinien
{: #cs_security_network_policies}

Jeder Kubernetes-Cluster wird mit einem Netz-Plug-in namens Calico eingerichtet. Standardnetzrichtlinien werden zum Schutz der öffentlichen Netzschnittstelle der einzelnen Workerknoten eingerichtet. Sie können Calico und native
Kubernetes-Funktionen verwenden, um weitere Netzrichtlinien für einen Cluster zu konfigurieren, wenn Sie eindeutige Sicherheitsanforderungen haben. Diese Netzrichtlinien geben Sie den Netzverkehr an, den Sie zu und von einem Pod in einem Cluster zulassen oder blockieren
möchten.
{: shortdesc}

Sie können zwischen Calico und nativen Kubernetes-Funktionen wählen, um Netzrichtlinien für Ihren Cluster zu erstellen. Für den Anfang reichen Kubernetes-Netzrichtlinien aus, aber für stabilere Funktionen sollten Sie
die Calico-Netzrichtlinien verwenden.

<ul><li>[Kubernetes-Netzrichtlinien ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/concepts/services-networking/network-policies/): Es werden grundlegende Optionen bereitgestellt, z. B. das Angeben der Pods, die miteinander kommunizieren können. Eingehender Netzverkehr
für Pods kann für ein Protokoll und einen Port basierend auf den Bezeichnungen und den Kubernetes-Namensbereichen des Pods zugelassen oder blockiert werden, der eine Verbindung damit herzustellen versucht. </br>Diese Richtlinien
können mithilfe von `kubectl`-Befehlen oder den Kubernetes-APIs angewendet werden. Werden diese Richtlinien angewendet, werden sie in Calico-Netzrichtlinien konvertiert und Calico erzwingt sie.
<li>[Calico-Netzrichtlinien ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](http://docs.projectcalico.org/v2.0/getting-started/kubernetes/tutorials/advanced-policy): Diese Richtlinien sind eine Obermenge
der Kubernetes-Netzrichtlinien und erweitern die nativen Kubernetes-Funktionen um die folgenden Features. <ul><ul><li>Zulassen oder Blockieren von Netzverkehr in bestimmten Netzschnittstellen, nicht nur Kubernetes-Pod-Datenverkehr.<li>Zulassen oder Blockieren eingehenden (Ingress) und ausgehenden (Egress) Netzverkehrs.<li>Zulassen oder Blockieren von Datenverkehr auf der Basis einer Quellen- oder Ziel-IP-Adresse oder -CIDR.</ul></ul></br>
Diese Richtlinien werden mithilfe von `calicoctl`-Befehlen angewendet. Calico erzwingt
diese Richtlinien, einschließlich aller Kubernetes-Netzrichtlinien, die in Calico-Richtlinien konvertiert werden, indem 'iptables'-Regeln von Linux in den Kubernetes-Workerknoten konfiguriert werden. 'iptables'-Regeln dienen als
Firewall für den Workerknoten, um die Merkmale zu definieren, die der Netzverkehr erfüllen muss, damit er an die Zielressource weitergeleitet wird.</ul>


### Standardrichtlinienkonfiguration
{: #concept_nq1_2rn_4z}

Wenn ein Cluster erstellt wird, werden Standardnetzrichtlinien automatisch für die öffentliche Netzschnittstelle
jedes Workerknotens konfiguriert, um eingehenden Datenverkehr für einen Workerknoten aus dem öffentlichen Internet zu begrenzen. Diese Richtlinien wirken sich nicht auf Datenverkehr zwischen Pods aus
und werden konfiguriert, um Zugriff auf den Kubernetes-Knotenport, die Lastausgleichsfunktion und die Ingress-Services zu ermöglichen.

Standardrichtlinien werden nicht direkt auf Pods angewendet. Sie werden mithilfe eines Calico-[Host-Endpunkts ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](http://docs.projectcalico.org/v2.0/getting-started/bare-metal/bare-metal) auf die öffentliche Netzschnittstelle
eines Workerknotens angewendet. Wenn ein Host-Endpunkt in Calico erstellt wird, wird der gesamte Datenverkehr zu und von der Netzschnittstelle dieses Workerknotens blockiert, es sei denn, eine Richtlinien lässt diesen Datenverkehr zu.

Beachten Sie, dass es keine Richtlinie gibt, die SSH zulässt, deshalb ist SSH-Zugriff über die öffentliche Netzschnittstelle
ebenfalls blockiert, ebenso wie alle anderen Ports, die sich nicht mithilfe einer Richtlinie öffnen lassen. SSH-Zugriff und alle anderen Zugriffe sind über die private Netzschnittstelle jedes Workerknotens möglich.

**Wichtig:** Entfernen Sie keine Richtlinien, die auf einen Host-Endpunkt angewendet sind, es sei denn, Sie kennen die Richtlinie und wissen, dass Sie den Datenverkehr, der durch diese Richtlinie zugelassen wird, nicht benötigen. 



  <table summary="Die erste Zeile in der Tabelle erstreckt sich über beide Spalten. Der Rest der Zeilen sollte von links nach rechts gelesen werden, wobei die Serverposition in der ersten Spalte und die passenden IP-Adressen in der zweiten Spalte angegeben sind.">
      <thead>
  <th colspan=2><img src="images/idea.png"/> Standardrichtlinien für die einzelnen Cluster</th>
  </thead>
  <tbody>
    <tr>
      <td><code>allow-all-outbound</code></td>
      <td>Lässt den gesamten ausgehenden Datenverkehr zu.</td>
    </tr>
    <tr>
      <td><code>allow-icmp</code></td>
      <td>Lässt eingehende 'icmp'-Pakete (Pings) zu.</td>
     </tr>
     <tr>
      <td><code>allow-kubelet-port</code></td>
      <td>Lässt den gesamten eingehenden Datenverkehr zu Port 10250 zu; dabei handelt es sich um den von Kubelet verwendeten Port. Aufgrund dieser Richtlinie funktionieren `kubectl logs` und `kubectl exec` ordnungsgemäß im Kubernetes-Cluster.</td>
    </tr>
    <tr>
      <td><code>allow-node-port-dnat</code></td>
      <td>Lässt eingehenden Datenverkehr für den Knotenport, die Lastausgleichsfunktion und den Ingress-Service zu den Pods zu, die diese Services zugänglich machen. Beachten Sie, dass der Port, den diese Services in der öffentlichen
Schnittstelle zugänglich machen, nicht angegeben werden muss, weil Kubernetes DNAT (Destination Network Address Translation, Zielnetzadressumsetzung) verwendet, um diese Serviceanforderungen an die korrekten Pods weiterzuleiten. Diese Weiterleitung findet statt, bevor der Host-Endpunkt in 'iptables' angewendet wird.</td>
   </tr>
   <tr>
      <td><code>allow-sys-mgmt</code></td>
      <td>Lässt eingehende Verbindungen für bestimmte {{site.data.keyword.BluSoftlayer_notm}}-Systeme zu, die zum Verwalten der Workerknoten verwendet werden.</td>
   </tr>
   <tr>
    <td><code>allow-vrrp</code></td>
    <td>Lässt 'vrrp'-Pakete zu, die zum Überwachen und Verschieben von virtuellen IP-Adressen zwischen Workerknoten verwendet werden.</td>
   </tr>
  </tbody>
</table>


### Netzrichtlinien hinzufügen
{: #adding_network_policies}

In den meisten Fällen müssen die Standardrichtlinien nicht geändert werden. Nur erweiterte Szenarios können unter Umständen Änderungen erforderlich machen. Wenn Sie feststellen, dass Sie Änderungen vornehmen müssen,
installieren Sie die Calico-CLI und erstellen Sie Ihre eigenen Netzrichtlinien.

Führen Sie zunächst die folgenden Schritte aus.

1.  [Installieren Sie die {{site.data.keyword.containershort_notm}}- und Kubernetes-CLIs.](cs_cli_install.html#cs_cli_install)
2.  [Erstellen Sie einen Lite-Cluster oder Standardcluster.](cs_cluster.html#cs_cluster_ui)
3.  [Richten Sie die Kubernetes-CLI auf den Cluster aus](cs_cli_install.html#cs_cli_configure). Schließen Sie die Option `--admin` mit dem Befehl `bx cs cluster-config` ein, der zum Herunterladen der Zertifikate und Berechtigungsdateien verwendet wird. In diesem Download sind auch die Schlüssel für die RBAC-Rolle 'Administrator' enthalten, die Sie zum Ausführen von Calico-Befehlen benötigen.

  ```
  bx cs cluster-config <clustername>
  ```
  {: pre}


Gehen Sie wie folgt vor, um Netzrichtlinien hinzuzufügen:
1.  Installieren Sie die Calico-CLI.
    1.  [Laden Sie die Calico-CLI ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link") herunter](https://github.com/projectcalico/calicoctl/releases/). 

        **Tipp:** Wenn Sie Windows verwenden, installieren Sie die Calico-CLI in demselben Verzeichnis wie die {{site.data.keyword.Bluemix_notm}}-CLI. Diese Konstellation erspart Ihnen einige Dateipfadänderungen, wenn Sie spätere Befehle ausführen.

    2.  OSX- und Linux-Benutzer müssen die folgenden Schritte ausführen.
        1.  Verschieben Sie die ausführbare Datei in das Verzeichnis '/usr/local/bin'. 
            -   Linux:

              ```
              mv /<dateipfad>/calicoctl /usr/local/bin/calicoctl
              ```
              {: pre}

            -   OS
X:

              ```
              mv /<dateipfad>/calico-darwin-amd64 /usr/local/bin/calicoctl
              ```
              {: pre}

        2.  Konvertieren Sie die Binärdatei in eine ausführbare Datei.

            ```
            chmod +x /usr/local/bin/calicoctl
            ```
            {: pre}

    3.  Stellen Sie sicher, dass die `calico`-Befehle ordnungsgemäß ausgeführt wurden. Überprüfen Sie dazu die Clientversion der Calico-CLI. 

        ```
        calicoctl version
        ```
        {: pre}

2.  Konfigurieren Sie die Calico-CLI.

    1.  Erstellen Sie für Linux und OS X das Verzeichnis '/etc/calico'. Unter Windows kann ein beliebiges Verzeichnis verwendet werden.

      ```
      mkdir -p /etc/calico/
      ```
      {: pre}

    2.  Erstellen Sie die Datei 'calicoctl.cfg'. 
        -   Linux und OS X:

          ```
          sudo vi /etc/calico/calicoctl.cfg
          ```
          {: pre}

        -   Windows: Erstellen Sie die Datei mit einem Texteditor.

    3.  Geben Sie die folgenden Informationen in der Datei <code>calicoctl.cfg</code> ein.

      ```
      apiVersion: v1
      kind: calicoApiConfig
      metadata:
      spec:
          etcdEndpoints: <ETCD-URL>
          etcdKeyFile: <ZERTIFIKATSVERZEICHNIS>/admin-key.pem
          etcdCertFile: <ZERTIFIKATSVERZEICHNIS>/admin.pem
          etcdCACertFile: <ZERTIFIKATSVERZEICHNIS>/<ca-*pem-datei>
      ```
      {: pre}

        1.  Rufen Sie die `<ETCD-URL>` ab.

          -   Linux und OS X:

              ```
              kubectl describe pod -n kube-system `kubectl get pod -n kube-system | grep calico-policy-controller | awk '{print $1}'` | grep ETCD_ENDPOINTS | awk '{print $2}'
              ```
              {: pre}

          -   Ausgabebeispiel:

              ```
              https://169.1.1.1:30001
              ```
              {: screen}

          -   Windows:
            <ol>
            <li>Rufen Sie eine Liste der Pods im Namensbereich des kube-Systems ab und suchen Sie nach dem Calico-Controller-Pod. </br><pre class="codeblock"><code>kubectl get pod -n kube-system</code></pre></br>Beispiel:</br><pre class="screen"><code>calico-policy-controller-1674857634-k2ckm</code></pre>
            <li>Zeigen Sie die Details des Calico-Controller-Pods an.</br> <pre class="codeblock"><code>kubectl describe pod -n kube-system calico-policy-controller-&lt;ID&gt;</code></pre>
            <li>Suchen Sie den etcd-Endpunktwert. Beispiel: <code>https://169.1.1.1:30001</code>
            </ol>

        2.  Rufen Sie das `<CZERTIFIKATSVERZEICHNIS>` ab. Dies ist das Verzeichnis, in das die Kubernetes-Zertifikate heruntergeladen werden.

            -   Linux und OS X:

              ```
              dirname $KUBECONFIG
              ```
              {: pre}

                Ausgabebeispiel:

              ```
              /home/sysadmin/.bluemix/plugins/container-service/clusters/<clustername>-admin/
              ```
              {: screen}

            -   Windows:

              ```
              ECHO %KUBECONFIG%
              ```
              {: pre}

                Ausgabebeispiel:

              ```
              C:/Benutzer/<benutzer>/.bluemix/plugins/container-service/<clustername>-admin/kube-config-prod-<standort>-<clustername>.yml
              ```
              {: screen}

            **Hinweis**: Entfernen Sie den Dateinamen `kube-config-prod-<location>-<clustername>.yml` am Ende der Ausgabe, um den Verzeichnispfad zu erhalten. 

        3.  Rufen Sie die <code>ca-*pem-datei<code> ab.

            -   Linux und OS X:

              ```
              ls `dirname $KUBECONFIG` | grep ca-.*pem
              ```
              {: pre}

            -   Windows:
              <ol><li>Öffnen Sie das Verzeichnis, das Sie im letzten Schritt abgerufen haben.</br><pre class="codeblock"><code>C:\Benutzer\<benutzer>\.bluemix\plugins\container-service\&#60;clustername&#62;-admin\</code></pre>
              <li> Suchen Sie die Datei <code>ca-*pem-datei</code>.</ol>

        4.  Überprüfen Sie, dass die Calico-Konfiguration ordnungsgemäß arbeitet.

            -   Linux und OS X:

              ```
              calicoctl get nodes
              ```
              {: pre}

            -   Windows:

              ```
              calicoctl get nodes --config=<pfad_zu_>/calicoctl.cfg
              ```
              {: pre}

              Ausgabe:

              ```
              NAME
              kube-dal10-crc21191ee3997497ca90c8173bbdaf560-w1.cloud.ibm
              kube-dal10-crc21191ee3997497ca90c8173bbdaf560-w2.cloud.ibm
              kube-dal10-crc21191ee3997497ca90c8173bbdaf560-w3.cloud.ibm
              ```
              {: screen}

3.  Prüfen Sie die vorhandenen Netzrichtlinien.

    -   Zeigen Sie den Calico-Host-Endpunkt an.

      ```
      calicoctl get hostendpoint -o yaml
      ```
      {: pre}

    -   Zeigen Sie alle Calico- und Kubernetes-Netzrichtlinien an, die für den Cluster erstellt wurden. Diese Liste enthält Richtlinien, die möglicherweise noch nicht auf Pods oder Hosts angewendet wurden. Damit eine Netzrichtlinie
erzwungen wird, muss sie eine Kubernetes-Ressource finden, die mit dem Selektor übereinstimmt, der in der Calico-Netzrichtlinie definiert wurde.

      ```
      calicoctl get policy -o wide
      ```
      {: pre}

    -   Zeigen Sie Details für ein Netzrichtlinie an.

      ```
      calicoctl get policy -o yaml <richtlinienname>
      ```
      {: pre}

    -   Zeigen Sie die Details aller Netzrichtlinien für den Cluster an.

      ```
      calicoctl get policy -o yaml
      ```
      {: pre}

4.  Erstellen Sie die Calico-Netzrichtlinien zum Zulassen oder Blockieren von Datenverkehr.

    1.  Definieren Sie Ihre [Calico-Netzrichtlinie ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](http://docs.projectcalico.org/v2.1/reference/calicoctl/resources/policy), indem Sie ein Konfigurationsscript erstellen (.yaml). Diese Konfigurationsdateien enthalten die Selektoren, die beschreiben, auf welche Pods, Namensbereiche oder Hosts diese Richtlinien angewendet werden. Ziehen Sie diese [Calico-Beispielrichtlinien ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](http://docs.projectcalico.org/v2.0/getting-started/kubernetes/tutorials/advanced-policy) als Hilfestellung heran, wenn Sie Ihre eigenen erstellen. 

    2.  Wenden Sie die Richtlinien auf den Cluster an.
        -   Linux und OS X:

          ```
          calicoctl apply -f <richtliniendateiname.yaml>
          ```
          {: pre}

        -   Windows:

          ```
          calicoctl apply -f <pfad_zu_>/<richtliniendateiname.yaml> --config=<pfad_zu_>/calicoctl.cfg
          ```
          {: pre}


## Images
{: #cs_security_deployment}

Verwenden Sie integrierte Sicherheitsfunktionen, um die Sicherheit und Integrität Ihrer Images zu verwalten.
{: shortdesc}

### Geschütztes privates Docker-Image-Repository in {{site.data.keyword.registryshort_notm}}:

 Sie können ein eigenes Docker-Image-Repository in einer hoch verfügbaren, skalierbaren, privaten Multi-Tenant-Image-Registry einrichten, die von IBM gehostet und verwaltet wird, um Docker-Images zu erstellen, sicher zu speichern und gemeinsam mit anderen Clusterbenutzern zu nutzen.

### Einhaltung von Sicherheitsbestimmungen für Images:

Wenn Sie {{site.data.keyword.registryshort_notm}} verwenden, können Sie die integrierte Sicherheitsfunktion zum Scannen einsetzen, die Vulnerability Advisor bereitstellt. Jedes Image, das mit einer Push-Operation an Ihren Namensbereich übertragen wird, wird automatisch auf Schwachstellen und Sicherheitslücken gescannt. Dieser Scanvorgang erfolgt im Abgleich mit einer Datenbank mit bekannten CentOS-, Debian-, Red Hat- und Ubuntu-Problemen. Werden derartige Schwachstellen oder Sicherheitslücken festgestellt, stellt Vulnerability Advisor Anweisung dazu bereit, wie Sie diese beseitigen bzw. schließen, um die Integrität und Sicherheit des Image sicherzustellen.

Gehen Sie wie folgt vor, um die Schwachstellenanalyse für das Image anzuzeigen:

1.  Wählen Sie im **Katalog** den Eintrag für **Container** aus.
2.  Wählen Sie das Image aus, dessen Schwachstellenanalyse angezeigt werden soll.
3.  Klicken Sie im Bereich **Schwachstellenanalyse** auf **Bericht anzeigen**.
