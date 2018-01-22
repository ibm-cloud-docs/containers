---

copyright:
  years: 2014, 2017
lastupdated: "2017-12-13"

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

## Sicherheit nach Clusterkomponente
{: #cs_security_cluster}

Jeder {{site.data.keyword.containerlong_notm}}-Cluster verfügt über in seine [Master](#cs_security_master)- und [Workerknoten](#cs_security_worker) integrierte Sicherheitsfeatures. Wenn Sie eine Firewall haben, auf den Lastausgleich von außerhalb des Clusters zugreifen müssen oder `kubectl`-Befehle aus Ihrem lokalen System ausführen möchten, aber Unternehmensnetzrichtlinien den Zugriff auf öffentliche Internetendpunkte verhindern, [öffnen Sie Ports in Ihrer Firewall](#opening_ports). Wenn Sie Apps in Ihrem Cluster mit einem lokalen Netz oder mit anderen Apps, die sich außerhalb Ihres Netzes befinden, verbinden möchten, [richten Sie VPN-Konnektivität ein](#vpn).
{: shortdesc}

Das folgende Diagramm zeigt die Sicherheitsfunktionen gruppiert nach Kubernetes-Master, Workerknoten und Container-Images.

<img src="images/cs_security.png" width="400" alt="{{site.data.keyword.containershort_notm}}-Clustersicherheit" style="width:400px; border-style: none"/>


  <table summary="Die erste Zeile in der Tabelle erstreckt sich über beide Spalten. Der Rest der Zeilen sollte von links nach rechts gelesen werden, wobei die Serverposition in der ersten Spalte und die passenden IP-Adressen in der zweiten Spalte angegeben sind.">
  <caption>Tabelle 1. Sicherheitsfeatures</caption>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Integrierte Clustersicherheitseinstellungen in {{site.data.keyword.containershort_notm}}</th>
  </thead>
  <tbody>
    <tr>
      <td>Kubernetes-Master</td>
      <td>Der Kubernetes-Master in jedem Cluster wird von IBM verwaltet und ist hoch verfügbar. Er enthält Sicherheitseinstellungen für {{site.data.keyword.containershort_notm}}, mit denen die Einhaltung der Sicherheitsbestimmungen und eine sichere Kommunikation von und zu den Workerknoten sichergestellt wird. Aktualisierungen werden von IBM bei Bedarf durchgeführt. Vom dedizierten Kubernetes-Master werden alle Kubernetes-Ressourcen im Cluster zentral gesteuert und überwacht. Abhängig von den Bereitstellungsvoraussetzungen und der Kapazität im Cluster werden die containerisierten Apps vom Kubernetes-Master automatisch zur Bereitstellung für die verfügbaren Workerknoten geplant. Weitere Informationen enthält [Sicherheit des Kubernetes-Masters](#cs_security_master).</td>
    </tr>
    <tr>
      <td>Workerknoten</td>
      <td>Container werden auf Workerknoten bereitgestellt, die der Nutzung durch einen Cluster vorbehalten sind und gegenüber IBM Kunden die Berechnungs-, Netz- und Speicherisolation sicherstellen. {{site.data.keyword.containershort_notm}} stellt integrierte Sicherheitsfunktionen zur Verfügung, um die Sicherheit
Ihrer Workerknoten im privaten und im öffentlichen Netz sicherzustellen und für die Einhaltung von Sicherheitsbestimmungen für Workerknoten zu sorgen. Weitere Informationen enthält [Sicherheit von Workerknoten](#cs_security_worker). Zusätzlich können Sie [Calico-Netzrichtlinien](#cs_security_network_policies) hinzufügen, um den Netzverkehr anzugeben, den Sie zu und von einem Pod in einem Workerknoten zulassen oder blockieren. </td>
     </tr>
     <tr>
      <td>Images</td>
      <td>Als Clusteradministrator können Sie ein eigenes sicheres Docker-Image-Repository in {{site.data.keyword.registryshort_notm}} einrichten, in dem Sie Docker-Images sicher speichern und zur gemeinsamen Nutzung durch Ihre Clusterbenutzer freigeben können. Jedes Image in Ihrer privaten Registry wird von Vulnerability Advisor überprüft, um die Bereitstellung sicherer Container sicherzustellen. Vulnerability Advisor ist eine Komponente von {{site.data.keyword.registryshort_notm}}, die nach potenziellen Sicherheitslücken sucht, Sicherheitsempfehlungen ausgibt und Anweisungen zur Schließung von Sicherheitslücken bereitstellt. Weitere Informationen finden Sie unter [Imagesicherheit in {{site.data.keyword.containershort_notm}}](#cs_security_deployment).</td>
    </tr>
  </tbody>
</table>

### Kubernetes-Master
{: #cs_security_master}

Prüfen Sie die integrierten Sicherheitsfeatures, die den Kubernetes-Master schützt und die Netzkommunikation für den Cluster sichert.
{: shortdesc}

<dl>
  <dt>Vollständig verwalteter und dedizierter Kubernetes-Master</dt>
    <dd>Jeder Kubernetes-Cluster in {{site.data.keyword.containershort_notm}} wird von einem dedizierten Kubernetes-Master gesteuert, der von IBM in einem IBM eigenen Konto von IBM Cloud Infrastructure (SoftLayer) verwaltet wird. Der Kubernetes-Master ist mit den folgenden dedizierten Komponenten konfiguriert, die nicht mit anderen IBM Kunden gemeinsam genutzt werden.
    <ul><li>Datenspeicher 'etcd': Speichert alle Kubernetes-Ressourcen eines Clusters, z. B. Services, Bereitstellungen und Pods. Kubernetes-Konfigurationsübersichten und geheime Kubernetes-Schlüssel sind App-Daten, die in Form von Schlüssel/Wert-Paaren gespeichert werden, damit sie von einer in einem Pod ausgeführten App verwendet werden können. Daten in 'etcd' werden auf einem verschlüsselten
Datenträger gespeichert, der von IBM verwaltet wird, und mit TLS verschlüsselt, wenn sie an einen Pod gesendet werden, um Datenschutz und die Datenintegrität sicherzustellen.</li>
    <li>'kube-apiserver': Dient als Haupteinstiegspunkt für alle Anforderungen vom Workerknoten zum Kubernetes-Master. Die Komponente 'kube-apiserver' validiert und verarbeitet Anforderungen und besitzt Lese- und Schreibberechtigungen für den Datenspeicher 'etcd'.</li>
    <li>'kube-scheduler': Entscheidet unter Berücksichtigung von Kapazitätsbedarf und Leistungsanforderungen, Beschränkungen durch Hardware- und Softwarerichtlinien, Anti-Affinitäts-Spezifikationen und Anforderungen für Arbeitslasten darüber, wo die Bereitstellung von Pods erfolgt. Wird kein Workerknoten gefunden, der mit den Anforderungen übereinstimmt, so wird der Pod nicht im Cluster bereitgestellt.</li>
    <li>'kube-controller-manager': Verantwortlich für die Überwachung von Replikatgruppen und für die Erstellung entsprechender Pods, um den gewünschten Zustand (Soll-Status) zu erreichen.</li>
    <li>'OpenVPN': Für {{site.data.keyword.containershort_notm}} spezifische Komponente, die sichere Netzkonnektivität für die gesamte Kommunikation zwischen dem Kubernetes-Master und dem Workerknoten bereitstellt.</li></ul></dd>
  <dt>Mit TLS geschützte Netzkonnektivität für die gesamte Kommunikation von den Workerknoten zum Kubernetes-Master</dt>
    <dd>{{site.data.keyword.containershort_notm}} schützt die Netzkommunikation zum Kubernetes-Master durch Generieren von TLS-Zertifikaten, mit denen für jeden Cluster die Kommunikation zu und von den Komponenten 'kube-apiserver' und 'etcd' verschlüsselt wird. Diese Zertifikate werden zu keinem Zeitpunkt von mehreren Clustern oder Komponenten des Kubernetes-Masters gemeinsam genutzt.</dd>
  <dt>Mit OpenVPN geschützte Netzkonnektivität für die gesamte Kommunikation vom Kubernetes-Master zu den Workerknoten</dt>
    <dd>Kubernetes schützt die Kommunikation zwischen dem Kubernetes-Master und den Workerknoten zwar durch die Verwendung des Protokolls `https`, doch auf dem Workerknoten wird keine standardmäßige Authentifizierung bereitgestellt. Zum Schutz dieser Kommunikation richtet {{site.data.keyword.containershort_notm}} bei der Erstellung des Clusters automatisch eine OpenVPN-Verbindung zwischen dem Kubernetes-Master und den Workerknoten ein.</dd>
  <dt>Kontinuierliche Überwachung des Kubernetes-Master-Netzes</dt>
    <dd>Jeder Kubernetes-Master wird kontinuierlich von IBM überwacht, um Denial-of-Service-Attacken (DoS) auf Prozessebene zu steuern und zu korrigieren.</dd>
  <dt>Einhaltung der Sicherheitsbestimmungen durch die Kubernetes-Master-Knoten</dt>
    <dd>{{site.data.keyword.containershort_notm}} überprüft automatisch jeden Knoten, auf dem der Kubernetes-Master bereitgestellt ist, auf Schwachstellen bzw. Sicherheitslücken, die in Kubernetes festgestellt wurden, und auf betriebssystemspezifische Korrekturen (Fixes) für die Sicherheit, die gegebenenfalls angewendet werden müssen, um den Schutz des Masterknotens sicherzustellen. Werden Schwachstellen bzw. Sicherheitslücken festgestellt, wendet {{site.data.keyword.containershort_notm}} automatisch entsprechende Korrekturen (Fixes) und beseitigt Schwachstellen bzw. Sicherheitslücken zugunsten des Benutzers.</dd>
</dl>

<br />


### Workerknoten
{: #cs_security_worker}

Prüfen Sie die integrierten Sicherheitsfeatures für Workerknoten, die die Workerknotenumgebung schützen und die Ressourcen-, Netz- und
Speicherisolation sicherstellen.
{: shortdesc}

<dl>
  <dt>Isolation der Berechnungs-, Netz- und Speicherinfrastruktur</dt>
    <dd>Wenn Sie einen Cluster bereitstellen, werden im Konto von IBM Cloud Infrastructure (SoftLayer) oder im dedizierten Konto von IBM Cloud Infrastructure (SoftLayer) von IBM virtuelle Maschinen als Workerknoten eingerichtet. Workerknoten sind einem Cluster zugeordnet und hosten nicht die Arbeitslast anderer Cluster.</br> Jedes {{site.data.keyword.Bluemix_notm}}-Konto wird mit VLANs von IBM Cloud Infrastructure (SoftLayer) eingerichtet, um die Qualität der Netzleistung und Isolation auf den Workerknoten sicherzustellen. </br>Damit Daten in Ihrem Cluster als persistent erhalten bleiben, können Sie den dedizierten NFS-basierten Dateispeicher von IBM Cloud Infrastructure (SoftLayer) einrichten und die integrierten Funktionen für Datensicherheit dieser Plattform nutzen.</dd>
  <dt>Einrichtung geschützter Workerknoten</dt>
    <dd>Alle Workerknoten werden mit dem Betriebssystem Ubuntu eingerichtet, das nicht vom Benutzer geändert werden kann. Um das Betriebssystem der Workerknoten gegen potenzielle Angriffe zu schützen,
wird jeder Workerknoten mit extrem fortgeschrittenen Firewalleinstellungen konfiguriert,
die durch iptables-Regeln von Linux umgesetzt werden.</br> Alle Container,
die auf Kubernetes ausgeführt werden, sind durch vordefinierte Calico-Netzrichtlinieneinstellungen geschützt,
die bei der Clustererstellung auf jedem Workerknoten konfiguriert werden. Diese Konstellation stellt die sichere Netzkommunikation zwischen Workerknoten und Pods sicher. Um die Aktionen, die ein Container auf einem Workerknoten ausführen kann, weiter einzuschränken, können die Benutzer
[AppArmor-Richtlinien ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tutorials/clusters/apparmor/)
auf den Workerknoten konfigurieren.</br> SSH-Zugriff ist auf dem Workerknoten inaktiviert. Wenn Sie zusätzliche Features auf dem Workerknoten installieren wollen, können Sie [Kubernetes-Dämon-Sets verwenden ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset) für Vorgänge, die auf jedem Knoten ausgeführt werden müssen, bzw. [Kubernetes-Jobs ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/) für alle einmaligen Aktionen, die Sie ausführen müssen.</dd>
  <dt>Einhaltung der Sicherheitsbestimmungen für die Kubernetes-Workerknoten</dt>
    <dd>IBM arbeitet mit internen und externen Beratungsteams für Sicherheit zusammen, um potenzielle Schwachstellen in Bezug auf die Einhaltung von Sicherheitsbestimmungen zu beseitigen. IBM verwaltet den Zugriff auf die Workerknoten, um Aktualisierungen und Sicherheitspatches für das Betriebssystem bereitzustellen. </br> <b>Wichtig</b>: Führen Sie regelmäßig einen Warmstart für Ihre Workerknoten durch, um sicherzustellen, dass die Installation von Aktualisierungen und Sicherheitspatches, die automatisch für das Betriebssystem bereitgestellt werden, auch durchgeführt wird. IBM führt für Ihre Workerknoten keinen Warmstart durch.</dd>
  <dt>Verschlüsselte Platte</dt>
  <dd>Standardmäßig stellt {{site.data.keyword.containershort_notm}} zwei lokale SSD-verschlüsselte Datenpartitionen für alle Workerknoten bereit, wenn diese bereitgestellt werden. Die erste Partition ist nicht verschlüsselt und die zweite Partition, die an _/var/lib/docker_ angehängt ist, wird bei der Bereitstellung mithilfe von LUKS-Verschlüsselungsschlüsseln entsperrt. Alle Worker in den einzelnen Kubernetes-Clustern haben ihren eigenen eindeutigen LUKS-Verschlüsselungsschlüssel, der von {{site.data.keyword.containershort_notm}} verwaltet wird. Wenn Sie einen Cluster erstellen oder einen Workerknoten zu einem vorhandenen Cluster hinzufügen, werden die Schlüssel sicher extrahiert und nach dem Entsperren der verschlüsselten Platte gelöscht.
  <p><b>Hinweis</b>: Verschlüsselung kann sich negativ auf die Platten-E/A-Leistung auswirken. Für Arbeitslasten, die eine eine leistungsfähige Platten-E/A erfordern, sollten Sie einen Cluster mit aktivierter und mit inaktivierter Verschlüsselung testen, um besser entscheiden zu können, ob die Verschlüsselung ausgeschaltet werden muss. </p>
  </dd>
  <dt>Unterstützung für Netzfirewalls von IBM Cloud Infrastructure (SoftLayer)</dt>
    <dd>{{site.data.keyword.containershort_notm}} ist mit allen [Firewallangeboten von IBM Cloud Infrastructure (SoftLayer) ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link") kompatibel](https://www.ibm.com/cloud-computing/bluemix/network-security). Sie können unter
{{site.data.keyword.Bluemix_notm}} Public eine Firewall mit angepassten Netzrichtlinien einrichten, um für Ihren Cluster dedizierte Netzsicherheit zu erzielen und unbefugten Zugriff zu erkennen und zu unterbinden. Sie können beispielsweise [Vyatta ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://knowledgelayer.softlayer.com/topic/vyatta-1) als Ihre Firewall und zum Blockieren unerwünschten Datenverkehrs einrichten. Wenn Sie eine Firewall einrichten, [müssen Sie auch die erforderlichen Ports und IP-Adressen für die einzelnen Regionen öffnen](#opening_ports), damit der Master und die Workerknoten kommunizieren können. </dd>
  <dt>Services privat belassen oder Service und Apps selektiv dem öffentlichen Internet zugänglich machen</dt>
    <dd>Sie können entscheiden, ob Sie Ihre Services und Apps privat belassen wollen. Durch Nutzung der in diesem Abschnitt beschriebenen integrierten
Sicherheitsfeatures können Sie außerdem die geschützte Kommunikation zwischen Workerknoten und Pods sicherstellen. Um Services und Apps dem öffentlichen Internet zugänglich zu machen, können Sie die Ingress-Unterstützung und die
Unterstützung der Lastausgleichsfunktion nutzen, um Ihre Services auf sichere Weise öffentlich verfügbar zu machen.</dd>
  <dt>Sichere Verbindung Ihrer Workerknoten und Apps mit einem lokalen Rechenzentrum</dt>
  <dd>Um eine Verbindung Ihrer Workerknoten und Apps mit einem lokalen Rechenzentrum einzurichten, können Sie einen VPN-IPSec-Endpunkt mit einem Strongswan-Service oder mit einer Vyatta-Gateway-Appliance bzw. einer Fortigate-Appliance konfigurieren. <br><ul><li><b>Strongswan-IPSec-VPN-Service</b>: Sie können einen [Strongswan-IPSec-VPN-Service ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.strongswan.org/) konfigurieren, der Ihren Kubernetes-Cluster sicher mit einem lokalen Netz verbindet. Der Strongswan-IPSec-VPN-Service stellt einen sicheren End-to-End-Kommunikationskanal über das Internet bereit, der auf der standardisierten IPsec-Protokollsuite (IPsec - Internet Protocol Security) basiert. Um eine sichere Verbindung zwischen Ihrem Cluster und einem lokalen Netz einrichten zu können, muss in Ihrem Rechenzentrum vor Ort ein IPsec-VPN-Gateway oder eine IBM Cloud Infrastructure (SoftLayer)-Server installiert sein. Dann können Sie den [Strongswan-IPSec-VPN-Service](cs_security.html#vpn) in einem Kubernetes-Pod konfigurieren und bereitstellen. </li><li><b>Vyatta-Gateway-Appliance oder Fortigate-Appliance</b>: Wenn Ihr Cluster größer ist, können Sie eine Vyatta-Gateway-Appliance oder eine Fortigate-Appliance einrichten, um einen IPSec-VPN-Endpunkt zu konfigurieren. Weitere Informationen finden Sie in diesem Blogbeitrag zum Thema [Verbinden eines Clusters mit einem lokalen Rechenzentrum ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/blogs/bluemix/2017/07/kubernetes-and-bluemix-container-based-workloads-part4/). </li></ul></dd>
  <dt>Kontinuierliche Überwachung und Protokollierung der Clusteraktivität</dt>
    <dd>Bei Standardclustern können alle clusterbezogenen Ereignisse wie das Hinzufügen eines Workerknotens, der Fortschritt bei einer rollierenden Aktualisierung oder Informationen zur Kapazitätsnutzung von {{site.data.keyword.containershort_notm}} protokolliert, überwacht und an {{site.data.keyword.loganalysislong_notm}} und {{site.data.keyword.monitoringlong_notm}} gesendet werden. Weitere Informationen zum Einrichten der Protokollierung und Überwachung finden Sie unter [Clusterprotokollierung konfigurieren](https://console.bluemix.net/docs/containers/cs_cluster.html#cs_logging) und [Clusterüberwachung konfigurieren](https://console.bluemix.net/docs/containers/cs_cluster.html#cs_monitoring). </dd>
</dl>

### Images
{: #cs_security_deployment}

Verwenden Sie integrierte Sicherheitsfunktionen, um die Sicherheit und Integrität Ihrer Images zu verwalten.
{: shortdesc}

<dl>
<dt>Geschütztes privates Docker-Image-Repository in {{site.data.keyword.registryshort_notm}}</dt>
<dd>Sie können ein eigenes Docker-Image-Repository in einer hoch verfügbaren, skalierbaren, privaten Multi-Tenant-Image-Registry einrichten, die von IBM gehostet und verwaltet wird, um Docker-Images zu erstellen, sicher zu speichern und gemeinsam mit anderen Clusterbenutzern zu nutzen.</dd>

<dt>Einhaltung von Sicherheitsbestimmungen für Images</dt>
<dd>Wenn Sie {{site.data.keyword.registryshort_notm}} verwenden, können Sie die integrierte Sicherheitsfunktion zum Scannen einsetzen, die Vulnerability Advisor bereitstellt. Jedes Image, das mit einer Push-Operation an Ihren Namensbereich übertragen wird, wird automatisch auf Schwachstellen und Sicherheitslücken gescannt. Dieser Scanvorgang erfolgt im Abgleich mit einer Datenbank mit bekannten CentOS-, Debian-, Red Hat- und Ubuntu-Problemen. Werden derartige Schwachstellen oder Sicherheitslücken festgestellt, stellt Vulnerability Advisor Anweisung dazu bereit, wie Sie diese beseitigen bzw. schließen, um die Integrität und Sicherheit des Image sicherzustellen.</dd>
</dl>

Informationen darüber, wie Sie die Schwachstellenanalyse für Ihre Images anzeigen, finden Sie in der [Dokumentation zu Vulnerability Advisor](/docs/services/va/va_index.html#va_registry_cli).

<br />


## Erforderliche Ports und IP-Adressen in Ihrer Firewall öffnen
{: #opening_ports}

Überprüfen Sie die hier aufgeführten Situationen, in denen Sie möglicherweise bestimmte Ports und IP-Adressen in Ihren Firewalls öffnen müssen, um folgende Aktionen zu ermöglichen:
* [Ausführen von `bx`-Befehlen](#firewall_bx) aus Ihrem lokalen System, wenn die Netzrichtlinien eines Unternehmens den Zugriff auf öffentliche Internetendpunkte über Proxys oder Firewalls verhindern. 
* [Ausführen von `kubectl`-Befehlen](#firewall_kubectl) aus Ihrem lokalen System, wenn die Netzrichtlinien eines Unternehmens den Zugriff auf öffentliche Internetendpunkte über Proxys oder Firewalls verhindern. 
* [Ausführen von `calicoctl`-Befehlen](#firewall_calicoctl) aus Ihrem lokalen System, wenn die Netzrichtlinien eines Unternehmens den Zugriff auf öffentliche Internetendpunkte über Proxys oder Firewalls verhindern. 
* [Zulassen der Kommunikation zwischen dem Kubernetes-Master und den Workerknoten](#firewall_outbound), wenn entweder eine Firewall für die Workerknoten eingerichtet wurde oder wenn die Firewalleinstellungen in Ihrem Konto von IBM Cloud Infrastructure (SoftLayer) angepasst wurden.
* [Zugreifen auf den NodePort-Service, LoadBalancer-Service oder auf Ingress von außerhalb des Clusters](#firewall_inbound). 

### `bx cs`-Befehle von hinter einer Firewall ausführen
{: #firewall_bx}

Falls Unternehmensnetzrichtlinien den Zugriff von Ihrem lokalen System auf öffentliche Endpunkte über Proxys oder Firewalls verhindern, müssen Sie TCP-Zugriff für {{site.data.keyword.containerlong_notm}} zulassen, um `bx cs`-Befehle auszuführen. 

1. Ermöglichen Sie Zugriff auf `containers.bluemix.net` an Port 443. 
2. Überprüfen Sie Ihre Verbindung. Ist der Zugriff korrekt konfiguriert, werden in der Ausgabe Schiffe angezeigt. 
   ```
   curl https://containers.bluemix.net/v1/
   ```
   {: pre}

   Beispielausgabe:
   ```
                                     )___(
                              _______/__/_
                     ___     /===========|   ___
    ____       __   [\\\]___/____________|__[///]   __
    \   \_____[\\]__/___________________________\__[//]___
     \                                                    |
      \                                                  /
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

   ```
   {: screen}

### `kubectl`-Befehle von hinter einer Firewall ausführen
{: #firewall_kubectl}

Falls Unternehmensnetzrichtlinien den Zugriff von Ihrem lokalen System auf öffentliche Endpunkte über Proxys oder Firewalls verhindern, müssen Sie TCP-Zugriff für den Cluster zulassen, um `kubectl`-Befehle auszuführen. 

Wenn ein Cluster erstellt wird, wird der Port in der Master-URL zufällig einer Zahl zwischen 20000-32767 zugewiesen. Sie können entweder den Portbereich 20000-32767 für alle Cluster öffnen, die eventuell erstellt werden, oder Sie können den Zugriff für einen spezifischen vorhandenen Cluster gewähren. 

Vorab müssen Sie zulassen, dass [`bx cs`-Befehle ausgeführt werden](#firewall_bx).

Gehen Sie wie folgt vor, um Zugriff auf einen bestimmten Cluster zu gewähren: 

1. Melden Sie sich an der {{site.data.keyword.Bluemix_notm}}-CLI an. Geben Sie Ihre {{site.data.keyword.Bluemix_notm}}-Berechtigungsnachweise ein, wenn Sie dazu aufgefordert werden. Wenn Sie über ein föderiertes Konto verfügen, schließen Sie die Option `--sso` ein. 

    ```
    bx login [--sso]
    ```
    {: pre}

2. Wählen Sie die Region aus, in der sich Ihr Cluster befindet. 

   ```
   bx cs region-set
   ```
   {: pre}

3. Rufen Sie den Namen Ihres Clusters ab. 

   ```
   bx cs clusters
   ```
   {: pre}

4. Rufen Sie die **Master-URL** für Ihren Cluster ab. 

   ```
   bx cs cluster-get <clustername_oder_id>
   ```
   {: pre}

   Beispielausgabe:
   ```
   ...
   Master URL:		https://169.46.7.238:31142
   ...
   ```
   {: screen}

5. Ermöglichen Sie Zugriff auf die **Master-URL** an dem Port, z. B. an Port `31142` im vorherigen Beispiel. 

6. Überprüfen Sie Ihre Verbindung. 

   ```
   curl --insecure <master-URL>/version
   ```
   {: pre}

   Beispielbefehl: 
   ```
   curl --insecure https://169.46.7.238:31142/version
   ```
   {: pre}

   Beispielausgabe: 
   ```
   {
     "major": "1",
     "minor": "7+",
     "gitVersion": "v1.7.4-2+eb9172c211dc41",
     "gitCommit": "eb9172c211dc4108341c0fd5340ee5200f0ec534",
     "gitTreeState": "clean",
     "buildDate": "2017-11-16T08:13:08Z",
     "goVersion": "go1.8.3",
     "compiler": "gc",
     "platform": "linux/amd64"
   }
   ```
   {: screen}

7. Optional: Wiederholen Sie diese Schritte für jeden Cluster, den Sie zugänglich machen müssen. 

### `calicoctl`-Befehle von hinter einer Firewall ausführen
{: #firewall_calicoctl}

Falls Unternehmensnetzrichtlinien den Zugriff von Ihrem lokalen System auf öffentliche Endpunkte über Proxys oder Firewalls verhindern, müssen Sie TCP-Zugriff für die Calico-Befehle zulassen, um `calicoctl`-Befehle auszuführen. 

Vorab müssen Sie zulassen, dass [`bx`-Befehle](#firewall_bx) und [`kubectl`-Befehle](#firewall_kubectl) ausgeführt werden. 

1. Rufen Sie die IP-Adresse aus der Master-URL ab, die Sie verwendet haben, um die [`kubectl`-Befehle](#firewall_kubectl) zuzulassen. 

2. Rufen Sie den Port für ETCD ab. 

  ```
  kubectl get cm -n kube-system calico-config -o yaml | grep etcd_endpoints
  ```
  {: pre}

3. Ermöglichen Sie Zugriff für die Calico-Richtlinien über die IP-Adresse und den ETCD-Port der Master-URL. 

### Zugriff des Clusters auf Infrastrukturressourcen und andere Services ermöglichen
{: #firewall_outbound}

  1.  Notieren Sie die öffentlichen IP-Adressen für alle Workerknoten im Cluster. 

      ```
      bx cs workers <clustername_oder_id>
      ```
      {: pre}

  2.  Ermöglichen Sie Netzverkehr von der Quelle _<öffentliche_IP_für_jeden_workerknoten>_ zum Ziel-TCP/UDP-Portbereich 20000-32767 und zum Port 443 sowie für die folgenden IP-Adressen und Netzgruppen. Wenn Ihre Unternehmensfirewall verhindert, dass Ihr lokales System auf öffentliche Internetendpunkte zugreifen kann, führen Sie diesen Schritt sowohl für Ihre Quellen-Workerknoten als auch für Ihr lokales System aus. 
      - **Wichtig**: Sie müssen den ausgehenden Datenverkehr am Port 443 für alle Standorte in der Region zu den jeweils anderen Standorten zulassen, um die Arbeitslast während des Bootstrap-Prozesses auszugleichen. Wenn Ihr Cluster sich beispielsweise in der Region 'Vereinigte Staaten (Süden)' befindet, dann müssen Sie Datenverkehr über den Port 443 an die IP-Adressen aller Standorte ('dal10', 'dal12' und 'dal13') zulassen.
      <p>
  <table summary="Die erste Zeile in der Tabelle erstreckt sich über beide Spalten. Der Rest der Zeilen sollte von links nach rechts gelesen werden, wobei die Serverposition in der ersten Spalte und die passenden IP-Adressen in der zweiten Spalte angegeben sind.">
      <thead>
      <th>Region</th>
      <th>Standort</th>
      <th>IP-Adresse</th>
      </thead>
    <tbody>
      <tr>
        <td>Asien-Pazifik (Norden)</td>
        <td>hkg02<br>tok02</td>
        <td><code>169.56.132.234</code><br><code>161.202.126.210</code></td>
       </tr>
      <tr>
         <td>Asien-Pazifik (Süden)</td>
         <td>mel01<br>syd01<br>syd04</td>
         <td><code>168.1.97.67</code><br><code>168.1.8.195</code><br><code>130.198.64.19, 130.198.66.34</code></td>
      </tr>
      <tr>
         <td>Zentraleuropa</td>
         <td>ams03<br>fra02<br>mil01<br>par01</td>
         <td><code>169.50.169.106, 169.50.154.194</code><br><code>169.50.56.170, 169.50.56.174</code><br><code>159.122.190.98</code><br><code>159.8.86.149, 159.8.98.170</code></td>
        </tr>
      <tr>
        <td>Großbritannien (Süden)</td>
        <td>lon02<br>lon04</td>
        <td><code>159.122.242.78</code><br><code>158.175.65.170, 158.175.74.170, 158.175.76.2</code></td>
      </tr>
      <tr>
        <td>Vereinigte Staaten (Osten)</td>
         <td>tor01<br>wdc06<br>wdc07</td>
         <td><code>169.53.167.50</code><br><code>169.60.73.142</code><br><code>169.61.83.62</code></td>
      </tr>
      <tr>
        <td>Vereinigte Staaten (Süden)</td>
        <td>dal10<br>dal12<br>dal13</td>
        <td><code>169.47.234.18, 169.46.7.234</code><br><code>169.47.70.10</code><br><code>169.60.128.2</code></td>
      </tr>
      </tbody>
    </table>
</p>

  3.  Erlauben Sie den ausgehenden Netzverkehr von den Workerknoten an {{site.data.keyword.registrylong_notm}}:
      - `TCP port 443 FROM <each_worker_node_publicIP> TO <registry_publicIP>`
      - Ersetzen Sie <em>&lt;registry_publicIP&gt;</em> durch alle Adressen für Registry-Regionen, an die der Datenverkehr als zulässig definiert werden soll:
        <p>
<table summary="Die erste Zeile in der Tabelle erstreckt sich über beide Spalten. Der Rest der Zeilen sollte von links nach rechts gelesen werden, wobei die Serverposition in der ersten Spalte und die passenden IP-Adressen in der zweiten Spalte angegeben sind.">
      <thead>
        <th>Containerregion</th>
        <th>Registryadresse</th>
        <th>Registry-IP-Adresse</th>
      </thead>
      <tbody>
        <tr>
          <td>Asien-Pazifik (Norden), Asien-Pazifik (Süden)</td>
          <td>registry.au-syd.bluemix.net</td>
          <td><code>168.1.45.160/27</code></br><code>168.1.139.32/27</code></td>
        </tr>
        <tr>
          <td>Zentraleuropa</td>
          <td>registry.eu-de.bluemix.net</td>
          <td><code>169.50.56.144/28</code></br><code>159.8.73.80/28</code></td>
         </tr>
         <tr>
          <td>Großbritannien (Süden)</td>
          <td>registry.eu-gb.bluemix.net</td>
          <td><code>159.8.188.160/27</code></br><code>169.50.153.64/27</code></td>
         </tr>
         <tr>
          <td>Vereinigte Staaten (Osten), Vereinigte Staaten (Süden)</td>
          <td>registry.ng.bluemix.net</td>
          <td><code>169.55.39.112/28</code></br><code>169.46.9.0/27</code></br><code>169.55.211.0/27</code></td>
         </tr>
        </tbody>
      </table>
</p>

  4.  Optional: Erlauben Sie den ausgehenden Netzverkehr von den Workerknoten an {{site.data.keyword.monitoringlong_notm}} und die {{site.data.keyword.loganalysislong_notm}}-Services:
      - `TCP port 443, port 9095 FROM <each_worker_node_publicIP> TO <monitoring_publicIP>`
      - Ersetzen Sie <em>&lt;monitoring_publicIP&gt;</em> durch alle Adressen für die Überwachungsregionen, an die der Datenverkehr als zulässig definiert werden soll:
        <p><table summary="Die erste Zeile in der Tabelle erstreckt sich über beide Spalten. Der Rest der Zeilen sollte von links nach rechts gelesen werden, wobei die Serverposition in der ersten Spalte und die passenden IP-Adressen in der zweiten Spalte angegeben sind.">
        <thead>
        <th>Containerregion</th>
        <th>Überwachungsadresse</th>
        <th>IP-Adressen für die Überwachung</th>
        </thead>
      <tbody>
        <tr>
         <td>Zentraleuropa</td>
         <td>metrics.eu-de.bluemix.net</td>
         <td><code>159.122.78.136/29</code></td>
        </tr>
        <tr>
         <td>Großbritannien (Süden)</td>
         <td>metrics.eu-gb.bluemix.net</td>
         <td><code>169.50.196.136/29</code></td>
        </tr>
        <tr>
          <td>Vereinigte Staaten (Osten), Vereinigte Staaten (Süden), Asien-Pazifik (Norden)</td>
          <td>metrics.ng.bluemix.net</td>
          <td><code>169.47.204.128/29</code></td>
         </tr>
         
        </tbody>
      </table>
</p>
      - `TCP port 443, port 9091 FROM <each_worker_node_publicIP> TO <logging_publicIP>`
      - Ersetzen Sie <em>&lt;logging_publicIP&gt;</em> durch alle Adressen für die Protokollierungsregionen, an die der Datenverkehr als zulässig definiert werden soll:
        <p><table summary="Die erste Zeile in der Tabelle erstreckt sich über beide Spalten. Der Rest der Zeilen sollte von links nach rechts gelesen werden, wobei die Serverposition in der ersten Spalte und die passenden IP-Adressen in der zweiten Spalte angegeben sind.">
        <thead>
        <th>Containerregion</th>
        <th>Protokollierungsadresse</th>
        <th>IP-Adressen für die Protokollierung</th>
        </thead>
        <tbody>
          <tr>
            <td>Vereinigte Staaten (Osten), Vereinigte Staaten (Süden)</td>
            <td>ingest.logging.ng.bluemix.net</td>
            <td><code>169.48.79.236</code><br><code>169.46.186.113</code></td>
           </tr>
          <tr>
           <td>Zentraleuropa, Großbritannien (Süden)</td>
           <td>ingest-eu-fra.logging.bluemix.net</td>
           <td><code>158.177.88.43</code><br><code>159.122.87.107</code></td>
          </tr>
          <tr>
           <td>Asien-Pazifik (Süden), Asien-Pazifik (Norden)</td>
           <td>ingest-au-syd.logging.bluemix.net</td>
           <td><code>130.198.76.125</code><br><code>168.1.209.20</code></td>
          </tr>
         </tbody>
       </table>
</p>

  5. Für private Firewalls müssen Sie die entsprechenden Bereiche privater IPs für IBM Cloud Infrastructure (SoftLayer) zulassen. Weitere Informationen finden Sie unter [diesem Link](https://knowledgelayer.softlayer.com/faq/what-ip-ranges-do-i-allow-through-firewall) ausgehend vom Abschnitt **Back-End-Netz (Privat)**.
      - Fügen Sie alle [Standorte in den Regionen](cs_regions.html#locations) hinzu, die von Ihnen verwendet werden. 
      - Beachten Sie, dass Sie den Standort 'dal01' (Rechenzentrum) hinzufügen müssen. 
      - Öffnen Sie die Ports 80 und 443, um die Durchführung des Cluster-Bootstrap-Prozesses zu erlauben. 

  6. Um Persistent Volume Claims für Datenspeicher zu erstellen, lassen Sie Egress-Zugriff über Ihre Firewall für die [IBM Cloud Infrastructure (SoftLayer)-IP-Adressen](https://knowledgelayer.softlayer.com/faq/what-ip-ranges-do-i-allow-through-firewall) des Standorts (Rechenzentrums) zu, in dem sich Ihr Cluster befindet. 
      - Führen Sie `bx cs clusters` aus, um den Standort (das Rechenzentrum) Ihres Clusters abzurufen. 
      - Ermöglichen Sie Zugriff auf den IP-Bereich des **(öffentlichen) Front-End-Netzes** und des **privaten Back-End-Netzes**. 
      - Beachten Sie, dass Sie den Standort 'dal01' (Rechenzentrum) für das **(private) Back-End--Netz** hinzufügen müssen. 

### Auf NodePort-, LoadBalancer- und Ingress-Services von außerhalb des Clusters zugreifen
{: #firewall_inbound}

Sie können eingehenden Zugriff auf NodePort-, LoadBalancer- und Ingress-Services zulassen. 

<dl>
  <dt>NodePort-Service</dt>
  <dd>Öffnen Sie den Port, den Sie bei der Bereitstellung des Service an den öffentlichen IP-Adressen für alle Workerknoten konfiguriert haben, mit denen Datenverkehr möglich sein soll. Führen Sie `kubectl get svc` aus, um den Port zu suchen. Der Port liegt im Bereich 20000-32000. <dd>
  <dt>LoadBalancer-Service</dt>
  <dd>Öffnen Sie den Port, den Sie bei der Bereitstellung des LoadBalancer-Service an der öffentlichen IP-Adresse konfiguriert haben. </dd>
  <dt>Ingress</dt>
  <dd>Öffnen Sie Port 80 für HTTP oder Port 443 für HTTPS an der IP-Adresse für die Ingress-Lastausgleichsfunktion für Anwendungen. </dd>
</dl>

<br />


## Helm-Diagramm zur Einrichtung von VPN-Konnektivität mit dem Strongswan-IPSec-VPN-Service
{: #vpn}

VPN-Konnektivität ermöglicht Ihnen auch das sichere Verbinden von Apps in einem Kubernetes-Cluster mit einem lokalen Netz. Sie können auch Apps, die nicht in Ihrem Cluster enthalten sind, mit Apps verbinden, die Teil Ihres Clusters sind. Bei der Konfiguration von VPN-Konnektivität können Sie ein Helm-Diagramm verwenden, um den [Strongswan-IPSec-VPN-Service ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.strongswan.org/) in einem Kubernetes-Pod einzurichten und bereitzustellen. Der gesamte VPN-Datenverkehr wird dann durch diesen Pod weitergeleitet. Weitere Informationen zu den Helm-Befehlen zum Konfigurieren des Strongswan-Diagramms finden Sie in der [Helm-Dokumentation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://docs.helm.sh/helm/). 

Vorbemerkungen:

- [Erstellen Sie einen Standardcluster.](cs_cluster.html#cs_cluster_cli)
- [Wenn Sie ein vorhandenes Cluster verwenden, aktualisieren Sie es auf Version 1.7.4 oder höher.](cs_cluster.html#cs_cluster_update) 
- Das Cluster muss mindestens eine verfügbare öffentliche Load Balancer-IP-Adresse haben. 
- [Richten Sie die Kubernetes-CLI auf den Cluster aus](cs_cli_install.html#cs_cli_configure).

Gehen Sie wie folgt vor, um VPN-Konnektivität mit Strongswan einzurichten: 

1. Falls Helm noch nicht aktiviert ist, installieren und initialisieren Sie es für Ihren Cluster. 

    1. [Installieren Sie die Helm-CLI ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://docs.helm.sh/using_helm/#installing-helm). 

    2. Initialisieren Sie Helm und installieren Sie `tiller`. 

        ```
        helm init
        ```
        {: pre}

    3. Überprüfen Sie, dass der Pod `tiller-deploy` den Status `Running` in Ihrem Cluster hat. 

        ```
        kubectl get pods -n kube-system -l app=helm
        ```
        {: pre}

        Beispielausgabe:

        ```
        NAME                            READY     STATUS    RESTARTS   AGE
        tiller-deploy-352283156-nzbcm   1/1       Running   0          10m
        ```
        {: screen}

    4. Fügen Sie das {{site.data.keyword.containershort_notm}}-Helm-Repository zu Ihrer Helm-Instanz hinzu. 

        ```
        helm repo add bluemix  https://registry.bluemix.net/helm
        ```
        {: pre}

    5. Überprüfen Sie, dass das Strongswan-Diagramm im Helm-Repository aufgelistet ist. 

        ```
        helm search bluemix
        ```
        {: pre}

2. Speichern Sie die Standardkonfigurationseinstellung für das Strongswan-Helm-Diagramm in einer lokalen YAML-Datei. 

    ```
    helm inspect values bluemix/strongswan > config.yaml
    ```
    {: pre}

3. Öffnen Sie die Datei `config.yaml` und nehmen Sie die folgenden Änderungen an den Standardwerten entsprechend der gewünschten VPN-Konfiguration vor. Wenn Sie für eine Eigenschaft aus verschiedenen Werten wählen können, sind diese in Kommentaren über den einzelnen Eigenschaften in der Datei aufgeführt. **Wichtig**: Wenn Sie keine Eigenschaft ändern müssen, kommentieren Sie diese Eigenschaft aus, indem Sie jeweils ein `#` davorsetzen. 

    <table>
    <caption>Tabelle 2. Erklärung der Komponenten der YAML-Datei</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der YAML-Dateikomponenten</th>
    </thead>
    <tbody>
    <tr>
    <td><code>overRideIpsecConf</code></td>
    <td>Wenn Sie über eine vorhandene <code>ipsec.conf</code>-Datei verfügen, die Sie verwenden möchten, entfernen Sie die geschweiften Klammern (<code>{}</code>) und fügen Sie die Inhalte Ihrer Datei nach dieser Eigenschaft hinzu. Die Dateiinhalte müssem eingerückt sein. **Hinweis:** Wenn Sie Ihre eigene Datei verwenden, werden die Werte für die Abschnitte <code>ipsec</code>, <code>local</code> und <code>remote</code> nicht verwendet. </td>
    </tr>
    <tr>
    <td><code>overRideIpsecSecrets</code></td>
    <td>Wenn Sie über eine vorhandene <code>ipsec.secrets</code>-Datei verfügen, die Sie verwenden möchten, entfernen Sie die geschweiften Klammern (<code>{}</code>) und fügen Sie die Inhalte Ihrer Datei nach dieser Eigenschaft hinzu. Die Dateiinhalte müssem eingerückt sein. **Hinweis:** Wenn Sie Ihre eigene Datei verwenden, werden die Werte für den Abschnitt <code>preshared</code> nicht verwendet. </td>
    </tr>
    <tr>
    <td><code>ipsec.keyexchange</code></td>
    <td>Wenn Ihr lokaler VPN-Tunnelendpunkt <code>ikev2</code> nicht als Protokoll für die Initialisierung der Verbindung unterstützt, ändern Sie diesen Wert in <code>ikev1</code>. </td>
    </tr>
    <tr>
    <td><code>ipsec.esp</code></td>
    <td>Ändern Sie diesen Wert in die Liste von ESP-Verschlüsselungs-/Authentifizierungsalgorithmen, die Ihr lokaler VPN-Tunnelendpunkt für die Verbindung verwendet. </td>
    </tr>
    <tr>
    <td><code>ipsec.ike</code></td>
    <td>Ändern Sie diesen Wert in die Liste von IKE/ISAKMP-SA-Verschlüsselungs-/Authentifizierungsalgorithmen, die Ihr lokaler VPN-Tunnelendpunkt für die Verbindung verwendet. </td>
    </tr>
    <tr>
    <td><code>ipsec.auto</code></td>
    <td>Wenn Sie möchten, dass der Cluster die VPN-Verbindung initialisiert, ändern Sie diesen Wert in <code>start</code>. </td>
    </tr>
    <tr>
    <td><code>local.subnet</code></td>
    <td>Ändern Sie diesen Wert in die Liste von Clusterteilnetz-CIDRs, die über die VPN-Verbindung für das lokale Netz zugänglich sein sollen. Diese Liste kann die folgenden Teilnetze enthalten: <ul><li>Die Teilnetz-CIDR des Kubernetes-Pods: <code>172.30.0.0/16</code> </li><li>Die Teilnetz-CIDR des Kubernetes-Service: <code>172.21.0.0/16</code> </li><li>Wenn Sie Anwendungen über einen NodePort-Service im privaten Netz zugänglich machen, die private Teilnetz-CIDR des Workerknotens. Sie finden diesen Wert, indem Sie <code>bx cs subnets | grep <xxx.yyy.zzz></code> ausführen, wobei &lt;xxx.yyy.zzz&gt; das erste von drei Oktetts der privaten IP-Adresse des Workerknotens ist. </li><li>Wenn Sie Anwendungen über LoadBalancer-Services im privaten Netz zugänglich machen, die private oder benutzerverwaltete Teilnetz-CIDR des Clusters. Sie finden diese Werte, indem Sie <code>bx cs cluster-get <clustername> --showResources</code> ausführen. Suchen Sie im Abschnitt <b>VLANS</b> nach CIDRs, deren <b>Public</b>-Wert <code>false</code> lautet. </li></ul></td>
    </tr>
    <tr>
    <td><code>local.id</code></td>
    <td>Ändern Sie diesen Wert in die Zeichenfolge-ID für die lokale Kubernetes-Clusterseite, die Ihr VPN-Tunnelendpunkt für die Verbindung verwendet. </td>
    </tr>
    <tr>
    <td><code>remote.gateway</code></td>
    <td>Ändern Sie diesen Wert in die öffentliche IP-Adresse für das lokale VPN-Gateway. </td>
    </tr>
    <td><code>remote.subnet</code></td>
    <td>Ändern Sie diesen Wert in die Liste von lokalen privaten Teilnetz-CIDRs, auf die der Kubernetes-Cluster zugreifen kann. </td>
    </tr>
    <tr>
    <td><code>remote.id</code></td>
    <td>Ändern Sie diesen Wert in die Zeichenfolge-ID für die ferne lokale Seite, die Ihr VPN-Tunnelendpunkt für die Verbindung verwendet. </td>
    </tr>
    <tr>
    <td><code>preshared.secret</code></td>
    <td>Ändern Sie diesen Wert in den vorab geteilten geheimen Schlüssel, den das Gateway Ihres lokalen VPN-Tunnelendpunkts für die Verbindung verwendet. </td>
    </tr>
    </tbody></table>

4. Speichern Sie die aktualisierte Datei `config.yaml`. 

5. Installieren Sie das Helm-Diagramm auf Ihrem Cluster mit der aktualisierten Datei `config.yaml`. Die aktualisierten Eigenschaften werden in einer Konfigurationsmap für Ihr Diagramm gespeichert. 

    ```
    helm install -f config.yaml --namespace=kube-system --name=vpn bluemix/strongswan
    ```
    {: pre}

6. Prüfen Sie den Status der Diagrammbereitstellung. Sobald das Diagramm bereit ist, hat das Feld **STATUS** oben in der Ausgabe den Wert `DEPLOYED`. 

    ```
    helm status vpn
    ```
    {: pre}

7. Sobald das Diagramm bereitgestellt ist, überprüfen Sie, dass die aktualisierten Einstellungen in der Datei `config.yaml` verwendet wurden. 

    ```
    helm get values vpn
    ```
    {: pre}

8. Testen Sie die neue VPN-Konnektivität. 
    1. Wenn das VPN im lokalen Gateway nicht aktiv ist, starten Sie das VPN. 

    2. Legen Sie die Umgebungsvariable `STRONGSWAN_POD` fest. 

        ```
        export STRONGSWAN_POD=$(kubectl get pod -n kube-system -l app=strongswan,release=vpn -o jsonpath='{ .items[0].metadata.name }')
        ```
        {: pre}

    3. Prüfen Sie den Status des VPN. Der Status `ESTABLISHED` bedeutet, dass die VPN-Verbindung erfolgreich war. 

        ```
        kubectl exec -n kube-system  $STRONGSWAN_POD -- ipsec status
        ```
        {: pre}

        Beispielausgabe:
        ```
        Security Associations (1 up, 0 connecting):
            k8s-conn[1]: ESTABLISHED 17 minutes ago, 172.30.244.42[ibm-cloud]...192.168.253.253[on-prem]
            k8s-conn{2}:  INSTALLED, TUNNEL, reqid 12, ESP in UDP SPIs: c78cb6b1_i c5d0d1c3_o
            k8s-conn{2}:   172.21.0.0/16 172.30.0.0/16 === 10.91.152.128/26
        ```
        {: screen}

        **Hinweis**:
          - Es ist sehr wahrscheinlich, dass das VPN nicht den Status `ESTABLISHED` hat, wenn Sie das erste Mal dieses Helm-Diagramm verwenden. Unter Umständen müssen Sie die Einstellungen des lokalen VPN-Endpunkts prüfen und zu Schritt 3 zurückkehren, um die Datei `config.yaml` mehrfach zu ändern, bevor die Verbindung erfolgreich ist. 
          - Falls der VPN-Pod den Status `ERROR` hat oder immer wieder ausfällt und neu startet, kann dies an der Parametervalidierung der `ipsec.conf`-Einstellungen in der Konfigurationsmap des Diagramms liegen. Prüfen Sie, ob dies der Fall ist, indem Sie mithilfe des Befehls `kubectl logs -n kube-system $STRONGSWAN_POD` in den Protokollen des Strongswan-Pods nach Validierungsfehlern suchen. Falls Sie Validierungsfehler finden, führen Sie `helm delete --purge vpn` aus, kehren Sie zu Schritt 3 zurück, um die falschen Werte in der Datei `config.yaml` zu korrigieren, und wiederholen Sie dann die Schritte 4 bis 8. Wenn Ihr Cluster viele Workerknoten umfasst, können Sie mit `helm upgrade` Ihre Änderungen schneller anwenden, anstatt erst `helm delete` und dann `helm install` auszuführen. 

    4. Sobald das VPN den Status `ESTABLISHED` hat, testen Sie die Verbindung mit `ping`. Im folgenden Beispiel wird ein Ping vom VPN-Pod im Kubernetes-Cluster an die private IP-Adresse des lokalen VPN-Gateways gesendet. Stellen Sie sicher, dass `remote.subnet` und `local.subnet` in der Konfigurationsdatei richtig angegeben sind und dass die lokale Teilnetzliste die Quellen-IP-Adresse umfasst, von der aus Sie das Ping-Signal senden. 

        ```
        kubectl exec -n kube-system  $STRONGSWAN_POD -- ping -c 3  <private_ip_des_lokalen_gateways>
        ```
        {: pre}

Gehen Sie wie folgt vor, um den Strongswan-IPSec-VPN-Service zu inaktivieren: 

1. Löschen Sie das Helm-Diagramm. 

    ```
    helm delete --purge vpn
    ```
    {: pre}

<br />


## Netzrichtlinien
{: #cs_security_network_policies}

Jeder Kubernetes-Cluster wird mit einem Netz-Plug-in namens Calico eingerichtet. Standardnetzrichtlinien werden zum Schutz der öffentlichen Netzschnittstelle der einzelnen Workerknoten eingerichtet. Sie können Calico und native
Kubernetes-Funktionen verwenden, um weitere Netzrichtlinien für einen Cluster zu konfigurieren, wenn Sie eindeutige Sicherheitsanforderungen haben. Diese Netzrichtlinien geben Sie den Netzverkehr an, den Sie zu und von einem Pod in einem Cluster zulassen oder blockieren
möchten.
{: shortdesc}

Sie können zwischen Calico und nativen Kubernetes-Funktionen wählen, um Netzrichtlinien für Ihren Cluster zu erstellen. Für den Anfang reichen Kubernetes-Netzrichtlinien aus, aber für stabilere Funktionen sollten Sie
die Calico-Netzrichtlinien verwenden.

<ul>
  <li>[Kubernetes-Netzrichtlinien ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/concepts/services-networking/network-policies/): Es werden grundlegende Optionen bereitgestellt, z. B. das Angeben der Pods, die miteinander kommunizieren können. Eingehender Netzverkehr kann für ein Protokoll und einen Port zugelassen oder blockiert werden. Dieser Datenverkehr kann auf Basis der Bezeichnungen und Kubernetes-Namensbereiche des Pods gefiltert werden, der versucht, eine Verbindung zu anderen Pods herzustellen.</br>Diese Richtlinien
können mithilfe von `kubectl`-Befehlen oder den Kubernetes-APIs angewendet werden. Werden diese Richtlinien angewendet, werden sie in Calico-Netzrichtlinien konvertiert und Calico erzwingt sie.</li>
  <li>[Calico-Netzrichtlinien ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](http://docs.projectcalico.org/v2.4/getting-started/kubernetes/tutorials/advanced-policy): Diese Richtlinien sind eine Obermenge
der Kubernetes-Netzrichtlinien und erweitern die nativen Kubernetes-Funktionen um die folgenden Features.</li>
    <ul><ul><li>Zulassen oder Blockieren von Netzverkehr in bestimmten Netzschnittstellen, nicht nur Kubernetes-Pod-Datenverkehr.</li>
    <li>Zulassen oder Blockieren eingehenden (Ingress) und ausgehenden (Egress) Netzverkehrs.</li>
    <li>[Blockieren von eingehendem Datenverkehr (Ingress) an die LoadBalancer- oder NodePort-Services von Kubernetes](#cs_block_ingress).</li>
    <li>Zulassen oder Blockieren von Datenverkehr auf der Basis einer Quellen- oder Ziel-IP-Adresse oder -CIDR.</li></ul></ul></br>

Diese Richtlinien werden mithilfe von `calicoctl`-Befehlen angewendet. Calico erzwingt
diese Richtlinien, einschließlich aller Kubernetes-Netzrichtlinien, die in Calico-Richtlinien konvertiert werden, indem 'iptables'-Regeln von Linux in den Kubernetes-Workerknoten konfiguriert werden. 'iptables'-Regeln dienen als
Firewall für den Workerknoten, um die Merkmale zu definieren, die der Netzverkehr erfüllen muss, damit er an die Zielressource weitergeleitet wird.</ul>


### Standardrichtlinienkonfiguration
{: #concept_nq1_2rn_4z}

Wenn ein Cluster erstellt wird, werden Standardnetzrichtlinien automatisch für die öffentliche Netzschnittstelle
jedes Workerknotens konfiguriert, um eingehenden Datenverkehr für einen Workerknoten aus dem öffentlichen Internet zu begrenzen. Diese Richtlinien wirken sich nicht auf Datenverkehr zwischen Pods aus
und werden konfiguriert, um Zugriff auf den Kubernetes-Knotenport, die Lastausgleichsfunktion und die Ingress-Services zu ermöglichen.

Standardrichtlinien werden nicht direkt auf Pods angewendet. Sie werden mithilfe eines Calico-Host-Endpunkts auf die öffentliche Netzschnittstelle eines Workerknotens angewendet. Wenn ein Host-Endpunkt in Calico erstellt wird, wird der gesamte Datenverkehr zu und von der Netzschnittstelle dieses Workerknotens blockiert, es sei denn, eine Richtlinien lässt diesen Datenverkehr zu.

**Wichtig:** Entfernen Sie keine Richtlinien, die auf einen Host-Endpunkt angewendet sind, es sei denn, Sie kennen die Richtlinie und wissen, dass Sie den Datenverkehr, der durch diese Richtlinie zugelassen wird, nicht benötigen.


 <table summary="Die erste Zeile in der Tabelle erstreckt sich über beide Spalten. Der Rest der Zeilen sollte von links nach rechts gelesen werden, wobei die Serverposition in der ersten Spalte und die passenden IP-Adressen in der zweiten Spalte angegeben sind.">
 <caption>Tabelle 3. Standardrichtlinien für jeden Cluster</caption>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Standardrichtlinien für die einzelnen Cluster</th>
  </thead>
  <tbody>
    <tr>
      <td><code>allow-all-outbound</code></td>
      <td>Lässt den gesamten ausgehenden Datenverkehr zu.</td>
    </tr>
    <tr>
      <td><code>allow-bixfix-port</code></td>
      <td>Lässt eingehenden Datenverkehr an Port 52311 zur BigFix-App zu, um erforderliche Aktualisierungen für Workerknoten zu ermöglichen.</td>
    </tr>
    <tr>
      <td><code>allow-icmp</code></td>
      <td>Lässt eingehende 'icmp'-Pakete (Pings) zu.</td>
     </tr>
    <tr>
      <td><code>allow-node-port-dnat</code></td>
      <td>Lässt eingehenden Datenverkehr für den Knotenport, die Lastausgleichsfunktion und den Ingress-Service zu den Pods zu, die diese Services zugänglich machen. Beachten Sie, dass der Port, den diese Services in der öffentlichen
Schnittstelle zugänglich machen, nicht angegeben werden muss, weil Kubernetes DNAT (Destination Network Address Translation, Zielnetzadressumsetzung) verwendet, um diese Serviceanforderungen an die korrekten Pods weiterzuleiten. Diese Weiterleitung findet statt, bevor der Host-Endpunkt in 'iptables' angewendet wird.</td>
   </tr>
   <tr>
      <td><code>allow-sys-mgmt</code></td>
      <td>Lässt eingehende Verbindungen für bestimmte Systeme von IBM Cloud Infrastructure (SoftLayer) zu, die zum Verwalten der Workerknoten verwendet werden.</td>
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

Vorbemerkungen:

1.  [Installieren Sie die {{site.data.keyword.containershort_notm}}- und Kubernetes-CLIs.](cs_cli_install.html#cs_cli_install)
2.  [Erstellen Sie einen Lite-Cluster oder Standardcluster.](cs_cluster.html#cs_cluster_ui)
3.  [Richten Sie die Kubernetes-CLI auf den Cluster aus](cs_cli_install.html#cs_cli_configure). Schließen Sie die Option `--admin` mit dem Befehl `bx cs cluster-config` ein, der zum Herunterladen der Zertifikate und Berechtigungsdateien verwendet wird. In diesem Download sind auch die Schlüssel für die Rolle 'Superuser' enthalten, die Sie zum Ausführen von Calico-Befehlen benötigen.

  ```
  bx cs cluster-config <clustername> --admin
  ```
  {: pre}

  **Hinweis**: Die Calico-CLI-Version 1.6.1 wird unterstützt.

Gehen Sie wie folgt vor, um Netzrichtlinien hinzuzufügen:
1.  Installieren Sie die Calico-CLI.
    1.  [Laden Sie die Calico-CLI ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/projectcalico/calicoctl/releases/tag/v1.6.1) herunter.

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
              mv /<dateipfad>/calicoctl-darwin-amd64 /usr/local/bin/calicoctl
              ```
              {: pre}

        2.  Konvertieren Sie die Datei in eine ausführbare Datei.

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

    1.  Erstellen Sie für Linux und OS X das Verzeichnis `/etc/calico`. Unter Windows kann ein beliebiges Verzeichnis verwendet werden.

      ```
      sudo mkdir -p /etc/calico/
      ```
      {: pre}

    2.  Erstellen Sie die Datei `calicoctl.cfg`.
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
        {: codeblock}

        1.  Rufen Sie die `<ETCD_URL>` ab. Schlägt die Ausführung dieses Befehls mit dem Fehler `calico-config nicht gefunden` fehl, dann lesen Sie die Informationen in diesem [Abschnitt zur Fehlerbehebung](cs_troubleshoot.html#cs_calico_fails).

          -   Linux und OS X:

              ```
              kubectl get cm -n kube-system calico-config -o yaml | grep "etcd_endpoints:" | awk '{ print $2 }'
              ```
              {: pre}

          -   Ausgabebeispiel:

              ```
              https://169.1.1.1:30001
              ```
              {: screen}

          -   Windows:
            <ol>
            <li>Rufen Sie die Calico-Konfigurationswerte aus der Konfigurationsübersicht ab. </br><pre class="codeblock"><code>kubectl get cm -n kube-system calico-config -o yaml</code></pre></br>
            <li>Suchen Sie im Abschnitt `data` nach dem Wert für 'etcd_endpoints'. Beispiel: <code>https://169.1.1.1:30001</code>
            </ol>

        2.  Rufen Sie das Verzeichnis `<CERTS_DIR>` ab. Dies ist das Verzeichnis, in das die Kubernetes-Zertifikate heruntergeladen werden.

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

            **Hinweis**: Entfernen Sie den Dateinamen `kube-config-prod-<location>-<cluster_name>.yml` am Ende der Ausgabe, um den Verzeichnispfad zu erhalten.

        3.  Rufen Sie die <code>ca-*pem-datei<code> ab.

            -   Linux und OS X:

              ```
              ls `dirname $KUBECONFIG` | grep "ca-"
              ```
              {: pre}

            -   Windows:
              <ol><li>Öffnen Sie das Verzeichnis, das Sie im letzten Schritt abgerufen haben.</br><pre class="codeblock"><code>C:\Benutzer\<user>\.bluemix\plugins\container-service\&lt;clustername&gt;-admin\</code></pre>
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

### Eingehenden Datenverkehr zu LoadBalancer- oder NodePort-Services blockieren
{: #cs_block_ingress}

Standardmäßig sind die Kubernetes-Services `NodePort` und `LoadBalancer` so konzipiert, dass Ihre App in allen öffentlichen und privaten Clusterschnittstellen verfügbar ist. Allerdings können Sie den eingehenden Datenverkehr zu Ihren Services auf Basis der Datenverkehrsquelle oder des Ziels blockieren. Zum Blockieren von Datenverkehr müssen Sie Calico-Netzrichtlinien vom Typ `preDNAT` erstellen.

Ein Kubernetes-LoadBalancer-Service stellt auch einen NodePort-Service dar. Ein LoadBalancer-Service stellt Ihre App über die IP-Adresse der Lastausgleichsfunktion und den zugehörigen Port zur Verfügung und macht sie über die Knotenports des Service verfügbar. Auf Knotenports kann über jede IP-Adresse (öffentlich und privat) für jeden Knoten innerhalb des Clusters zugegriffen werden.

Der Clusteradministrator kann die Calico-Netzrichtlinien vom Typ `preDNAT` verwenden, um folgenden Datenverkehr zu blockieren:

  - Den Datenverkehr zu den NodePort-Services. Der Datenverkehr zu LoadBalancer-Services ist zulässig.
  - Den Datenverkehr, der auf einer Quellenadresse oder einem CIDR basiert.

Nachfolgend finden Sie einige gängige Anwendungsbereiche für die Calico-Netzrichtlinien des Typs

  - Blockieren des Datenverkehrs an öffentliche Knotenports eines privaten LoadBalancer-Service.
  - Blockieren des Datenverkehrs an öffentliche Knotenports in Clustern, in denen [Edge-Workerknoten](#cs_edge) ausgeführt werden. Durch das Blockieren von Knotenports wird sichergestellt, dass die Edge-Workerknoten die einzigen Workerknoten sind, die eingehenden Datenverkehr verarbeiten.

Die Netzrichtlinien vom Typ `preDNAT` sind nützlich, weil die standardmäßigen Kubernetes- und Calico-Richtlinien aufgrund der DNAT-iptables-Regeln, die für die Kubernetes-NodePort- und Kubernetes-LoadBalancer-Services generiert werden, zum Schutz dieser Services schwierig anzuwenden sind.

Die Calico-Netzrichtlinien vom Typ `preDNAT` generieren iptables-Regeln auf Basis einer [Calico-Netzrichtlinienressource ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://docs.projectcalico.org/v2.4/reference/calicoctl/resources/policy).

1. Definieren Sie eine Calico-Netzrichtlinie vom Typ `preDNAT` für den Ingress-Zugriff auf Kubernetes-Services.

  Beispiel für die Blockierung aller Knotenports:

  ```
  apiVersion: v1
  kind: policy
  metadata:
    name: deny-kube-node-port-services
  spec:
    preDNAT: true
    selector: ibm.role in { 'worker_public', 'master_public' }
    ingress:
    - action: deny
      protocol: tcp
      destination:
        ports:
        - 30000:32767
    - action: deny
      protocol: udp
      destination:
        ports:
        - 30000:32767
  ```
  {: codeblock}

2. Wenden Sie die Calico-Netzrichtlinie vom Typ 'preDNAT' an. Es dauert ca. eine Minute, bis die Richtlinienänderungen im Cluster angewendet sind.

  ```
  calicoctl apply -f deny-kube-node-port-services.yaml
  ```
  {: pre}

<br />



## Netzverkehr zu Edge-Workerknoten beschränken
{: #cs_edge}

Fügen Sie die Bezeichnung `dedicated=edge` zu mindestens zwei Workerknoten in Ihrem Cluster hinzu, um sicherzustellen, dass Ingress- und Lastausgleichsservices nur für diese Workerknoten bereitgestellt werden.

Mit Edge-Workerknoten kann die Sicherheit des Clusters verbessert werden, indem der externe Zugriff auf Workerknoten beschränkt und die Netzarbeitslast isoliert wird. Wenn diese Workerknoten nur für den Netzbetrieb markiert sind, können andere Arbeitslasten nicht die CPU oder den Speicher des entsprechenden Workerknotens nutzen und somit Auswirkungen auf den Netzbetrieb haben.

Vorbemerkungen:

- [Erstellen Sie einen Standardcluster.](cs_cluster.html#cs_cluster_cli)
- Stellen Sie sicher, dass der Cluster mindestens über ein öffentliches VLAN verfügt. Edge-Workerknoten stehen nicht für Cluster mit ausschließlich privaten VLANs zur Verfügung.
- [Richten Sie die Kubernetes-CLI auf den Cluster aus](cs_cli_install.html#cs_cli_configure).


1. Listen Sie alle Workerknoten im Cluster auf. Verwenden Sie die private IP-Adresse aus der Spalte **NAME**, um die Knoten anzugeben. Wählen Sie mindestens zwei Workerknoten als Edge-Workerknoten aus. Durch die Verwendung von zwei oder mehr Workerknoten wird die Verfügbarkeit der Netzressourcen verbessert.

  ```
  kubectl get nodes -L publicVLAN,privateVLAN,dedicated
  ```
  {: pre}

2. Ordnen Sie den Workerknoten die Bezeichnung `dedicated=edge` zu. Nachdem ein Workerknoten mit der Bezeichnung `dedicated=edge` markiert wurde, werden alle Ingress- und Lastausgleichsservices auf einem Edge-Workerknoten bereitgestellt.

  ```
  kubectl label nodes <knotenname> <knotenname2> dedicated=edge
  ```
  {: pre}

3. Rufen Sie alle vorhandenen Lastausgleichsservices in Ihrem Cluster auf.

  ```
  kubectl get services --all-namespaces -o jsonpath='{range .items[*]}kubectl get service -n {.metadata.namespace} {.metadata.name} -o yaml | kubectl apply -f - :{.spec.type},{end}' | tr "," "\n" | grep "LoadBalancer" | cut -d':' -f1
  ```
  {: pre}

  Ausgabe:

  ```
  kubectl get service -n <namensbereich> <name> -o yaml | kubectl apply -f
  ```
  {: screen}

4. Kopieren Sie unter Verwendung der Ausgabe aus dem vorherigen Schritt jede Zeile `kubectl get service` und fügen Sie sie ein. Mit diesem Befehl wird die Lastausgleichsfunktion erneut auf einem Edge-Workerknoten bereitgestellt. Nur öffentliche Lastausgleichsfunktionen müssen erneut bereitgestellt werden.

  Ausgabe:

  ```
  service "<name>" configured
  ```
  {: screen}

Sie haben Workerknoten mit der Bezeichnung `dedicated=edge` markiert und alle vorhandenen Lastausgleichs- sowie Ingress-Services erneut auf den Workerknoten bereitgestellt. Verhindern Sie nun als nächsten Schritt, dass andere [Arbeitslasten auf Edge-Workerknoten ausgeführt werden](#cs_edge_workloads) und [blockieren Sie eingehenden Datenverkehr an Knotenports auf Workerknoten](#cs_block_ingress).

### Verhindern, dass Arbeitslasten auf Edge-Workerknoten ausgeführt werden
{: #cs_edge_workloads}

Einer der Vorteile von Edge-Workerknoten ist, dass diese so konfiguriert werden können, dass sie nur Netzservices ausführen. Die Verwendung der Tolerierung `dedicated=edge` bedeutet, dass alle Lastausgleichs- und Ingress-Services nur auf den markierten Workerknoten ausgeführt werden. Um jedoch zu verhindern, dass andere Arbeitslasten auf Edge-Workerknoten ausgeführt werden und deren Ressourcen verbrauchen, müssen Sie [Kubernetes-Taints ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/) verwenden.

1. Listen Sie alle Workerknoten mit der Bezeichnung `edge` auf.

  ```
  kubectl get nodes -L publicVLAN,privateVLAN,dedicated -l dedicated=edge
  ```
  {: pre}

2. Wenden Sie einen Taint auf alle Workerknoten an, der verhindert, dass Pods auf den entsprechenden Workerknoten ausgeführt werden und der Pods von den Workerknoten entfernt, die nicht die Bezeichnung `edge` aufweisen. Die entfernten Pods werden auf anderen Workerknoten mit entsprechender Kapazität erneut bereitgestellt.

  ```
  kubectl taint node <knotenname> dedicated=edge:NoSchedule dedicated=edge:NoExecute
  ```

Nun werden nur Pods mit der Tolerierung `dedicated=edge` auf Ihren Edge-Workerknoten bereitgestellt.
