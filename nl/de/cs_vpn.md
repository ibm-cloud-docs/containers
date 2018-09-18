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


# VPN-Konnektivität einrichten
{: #vpn}

Mit der VPN-Konnektivität können Sie Apps in einem Kubernetes-Cluster unter {{site.data.keyword.containerlong}} sicher mit einem lokalen Netz verbinden. Sie können auch Apps, die nicht in Ihrem Cluster enthalten sind, mit Apps verbinden, die Teil Ihres Clusters sind.
{:shortdesc}

Um eine Verbindung Ihrer Workerknoten und Apps mit einem lokalen Rechenzentrum einzurichten, können Sie eine der folgenden Optionen konfigurieren.

- **StrongSwan-IPSec-VPN-Service**: Sie können einen [StrongSwan-IPSec-VPN-Service ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.strongswan.org/about.html) konfigurieren, der Ihren Kubernetes-Cluster sicher mit einem lokalen Netz verbindet. Der StrongSwan-IPSec-VPN-Service stellt einen sicheren End-to-End-Kommunikationskanal über das Internet bereit, der auf der standardisierten IPSec-Protokollsuite (IPSec – Internet Protocol Security) basiert. Um eine sichere Verbindung zwischen Ihrem Cluster und einem lokalen Netz einzurichten, [konfigurieren und implementieren Sie den StrongSwan-IPSec-VPN-Service](#vpn-setup) direkt in einem Pod in Ihrem Cluster.

- **Virtual Router Appliance (VRA) oder Fortigate Security Appliance (FSA)**: Sie können zum Konfigurieren eines IPSec-VPN-Endpunkts entweder eine [VRA](/docs/infrastructure/virtual-router-appliance/about.html) oder eine [FSA](/docs/infrastructure/fortigate-10g/about.html) einrichten. Diese Option ist hilfreich, wenn der Cluster größer ist, Sie über ein einzelnes VPN auf mehrere Cluster zugreifen möchten oder Sie ein routenbasiertes VPN benötigen. Informationen zum Konfigurieren einer VRA finden Sie unter [VPN-Konnektivität mit VRA konfigurieren](#vyatta).

## Helm-Diagramm für StrongSwan-IPSec-VPN-Service
{: #vpn-setup}

Verwenden Sie ein Helm-Diagramm, um den StrongSwan-IPSec-VPN-Service innerhalb eines Kubernetes-Pods zu konfigurieren und bereitzustellen.
{:shortdesc}

Da strongSwan in Ihren Cluster integriert ist, benötigen Sie keine externe Gateway-Einheit. Beim Einrichten der VPN-Konnektivität werden automatisch Routen auf allen Workerknoten im Cluster konfiguriert. Diese Routen ermöglichen eine bidirektionale Konnektivität über den VPN-Tunnel zwischen Pods auf allen Workerknoten und dem fernen System. Das folgende Diagramm zeigt beispielsweise, wie eine App in {{site.data.keyword.containershort_notm}} mit einem lokalen Server über eine strongSwan-VPN-Verbindung kommunizieren kann:

<img src="images/cs_vpn_strongswan.png" width="700" alt="App in {{site.data.keyword.containershort_notm}} mithilfe einer Lastausgleichsfunktion zugänglich machen" style="width:700px; border-style: none"/>

1. Eine App in Ihrem Cluster, `myapp`, empfängt eine Anforderung von einem Ingress- oder LoadBalancer-Service und muss eine sichere Verbindung mit Daten in Ihrem lokalen Netz herstellen.

2. Die Anforderung an das lokale Rechenzentrum wird an den IPSec-strongSwan-VPN-Pod weitergeleitet. Die IP-Zieladresse wird verwendet, um zu bestimmen, welche Netzpakete an den IPSec-strongSwan-VPN-Pod gesendet werden sollen.

3. Die Anforderung wird verschlüsselt und über den VPN-Tunnel an das lokale Rechenzentrum gesendet.

4. Die eingehende Anforderung passiert die lokale Firewall und wird an den VPN-Tunnelendpunkt (Router) zugestellt, wo sie entschlüsselt wird.

5. Der VPN-Tunnelendpunkt (Router) leitet die Anforderung abhängig von der in Schritt 2 angegebenen Ziel-IP-Adresse an den lokalen Server oder den Mainframe weiter. Die erforderlichen Daten werden auf dieselbe Weise über die VPN-Verbindung zurück an `myapp` gesendet.

## Überlegungen zum StrongSwan-VPN-Service
{: strongswan_limitations}

Prüfen Sie folgende Überlegungen und Einschränkungen, bevor Sie das StrongSwan-Helm-Diagramm verwenden.

* Für das StrongSwan-Helm-Diagramm ist erforderlich, dass die NAT-Traversierung (NAT – Network Address Translation) vom fernen VPN-Endpunkt aktiviert wird. Für die NAT-Traversierung ist neben dem IPSec-UDP-Standardport 500 der UDP-Port 4500 erforderlich. Für beide UDP-Ports muss eine eventuell konfigurierte Firewall Durchlass gewähren.
* Das StrongSwan-Helm-Diagramm unterstützt keine routenbasierten IPSec-VPNs.
* Das StrongSwan-Helm-Diagramm unterstützt IPSec-VPNs, die vorab bekannte verteilte Schlüssel verwenden, unterstützt jedoch nicht IPSec-VPNs, die Zertifikate erfordern.
* Das StrongSwan-Helm-Diagramm lässt nicht zu, dass mehrere Cluster und andere IaaS-Ressourcen eine einzige VPN-Verbindung gemeinsam nutzen.
* Das StrongSwan-Helm-Diagramm wird innerhalb des Clusters als Kubernetes-Pod ausgeführt. Die Speicher- und Netzverwendung von Kubernetes und anderen Pods, die im Cluster ausgeführt werden, wirkt sich auf die VPN-Leistung aus. Wenn Sie eine leistungskritische Umgebung haben, sollten Sie in Betracht ziehen, eine VPN-Lösung zu verwenden, die außerhalb des Clusters auf dedizierter Hardware ausgeführt wird.
* Das StrongSwan-Helm-Diagramm führt einen einzelnen VPN-Pod als IPSec-Tunnel-Endpunkt aus. Wenn der Pod fehlschlägt, startet der Cluster den Pod erneut. Es kann jedoch sein, dass eine kurze Ausfallzeit auftritt, während der neue Pod gestartet wird und die VPN-Verbindung neu eingerichtet wird. Wenn für Sie eine schnellere Fehlerbehebung oder eine ausgefeiltere Hochverfügbarkeitslösung erforderlich ist, sollten Sie in Betracht ziehen, eine VPN-Lösung zu verwenden, die außerhalb des Clusters auf dedizierter Hardware ausgeführt wird.
* Das StrongSwan-Helm-Diagramm stellt keine Messwerte oder eine Überwachung des Netzwerkverkehrs bereit, der über die VPN-Verbindung fließt. Eine Liste der unterstützten Überwachungstools finden Sie im Abschnitt [Protokollierungs- und Überwachungsservices](cs_integrations.html#health_services).

## StrongSwan-Helm-Diagramm konfigurieren
{: #vpn_configure}

Vorbemerkungen:
* [Installieren Sie ein IPSec-VPN-Gateway in Ihrem lokalen Rechenzentrum](/docs/infrastructure/iaas-vpn/set-up-ipsec-vpn.html#setting-up-an-ipsec-connection).
* [Erstellen Sie einen Standardcluster](cs_clusters.html#clusters_cli).
* [Richten Sie die Kubernetes-CLI auf den Cluster aus](cs_cli_install.html#cs_cli_configure).

### Schritt 1: StrongSwan-Helm-Diagramm abrufen
{: #strongswan_1}

1. [Installieren Sie Helm für Ihr Cluster und fügen Sie das {{site.data.keyword.Bluemix_notm}}-Repository zu Ihrer Helm-Instanz hinzu](cs_integrations.html#helm).

2. Speichern Sie die Standardkonfigurationseinstellungseinstellungen für das StrongSwan-Helm-Diagramm in einer lokalen YAML-Datei.

    ```
    helm inspect values ibm/strongswan > config.yaml
    ```
    {: pre}

3. Öffnen Sie die Datei `config.yaml`.

### Schritt 2: Grundlegende IPSec-Einstellungen konfigurieren
{: #strongswan_2}

Ändern Sie zum Steuern der Einrichtung der VPN-Verbindung die folgenden grundlegenden IPSec-Einstellungen.

Weitere Informationen zu den einzelnen Einstellungen finden Sie in der Dokumentation, die in der Datei `config.yaml` für das Helm-Diagramm bereitgestellt wird.
{: tip}

1. Wenn Ihr lokaler VPN-Tunnelendpunkt `ikev2` als Protokoll für die Initialisierung der Verbindung nicht unterstützt, ändern Sie den Wert von `ipsec.keyexchange` in `ikev1` oder `ike`.
2. Legen Sie als `ipsec.esp` die Liste von ESP-Verschlüsselungs-/Authentifizierungsalgorithmen fest, die Ihr lokaler VPN-Tunnelendpunkt für die Verbindung verwendet.
    * Wenn `ipsec.keyexchange` auf `ikev1` festgelegt ist, muss diese Einstellung angegeben werden.
    * Wenn `ipsec.keyexchange` auf `ikev2` festgelegt ist, ist diese Einstellung optional.
    * Wenn Sie diese Einstellung leer lassen, wird der Standardwert für strongSwan-Algorithmen `aes128-sha1,3des-sha1` für die Verbindung verwendet.
3. Legen Sie als `ipsec.ike` die Liste von IKE/ISAKMP-SA-Verschlüsselungs-/Authentifizierungsalgorithmen fest, die Ihr lokaler VPN-Tunnelendpunkt für die Verbindung verwendet. Die Algorithmen müssen im Format `encryption-integrity[-prf]-dhgroup` angegeben werden.
    * Wenn `ipsec.keyexchange` auf `ikev1` festgelegt ist, muss diese Einstellung angegeben werden.
    * Wenn `ipsec.keyexchange` auf `ikev2` festgelegt ist, ist diese Einstellung optional.
    * Wenn Sie diese Einstellung leer lassen, wird der Standardwert für strongSwan-Algorithmen `aes128-sha1-modp2048,3des-sha1-modp1536` für die Verbindung verwendet.
4. Ändern Sie den Wert von `local.id` in eine beliebige Zeichenfolge, die Sie zum Identifizieren der lokalen Seite des Kubernetes-Clusters verwenden möchten, die Ihr VPN-Tunnelendpunkt verwendet. Die Standardeinstellung ist `ibm-cloud`. Für einige VPN-Implementierungen ist es erforderlich, dass Sie für den lokalen Endpunkt die öffentliche IP-Adresse verwenden.
5. Ändern Sie den Wert von `remote.id` in eine beliebige Zeichenfolge, die Sie zum Identifizieren der fernen lokalen Seite verwenden möchten, die Ihr VPN-Tunnelendpunkt verwendet. Die Standardeinstellung ist `on-prem`. Für einige VPN-Implementierungen ist es erforderlich, dass Sie für den fernen Endpunkt die öffentliche IP-Adresse verwenden.
6. Ändern Sie den Wert von `preshared.secret` in den vorab verteilten geheimen Schlüssel, den Ihr lokaler VPN-Tunnelendpunkt für die Verbindung verwendet. Dieser Wert wird in `ipsec.secrets` gespeichert.
7. Optional: Legen Sie für `remote.privateIPtoPing` eine beliebige private IP-Adresse im fernen Teilnetz fest, die im Rahmen des Helm-Tests zur Konnektivitätsprüfung mit Ping überprüft wird.

### Schritt 3: Eingehende oder ausgehende VPN-Verbindung auswählen
{: #strongswan_3}

Wenn Sie eine StrongSwan-VPN-Verbindung konfigurieren, wählen Sie aus, ob die VPN-Verbindung für den Cluster eingehend oder ausgehend ist.
{: shortdesc}

<dl>
<dt>Eingehend</dt>
<dd>Der lokale VPN-Endpunkt des fernen Netzes initialisiert die VPN-Verbindung und der Cluster ist für die Verbindung empfangsbereit.</dd>
<dt>Ausgehend</dt>
<dd>Der Cluster initialisiert die VPN-Verbindung und der lokale VPN-Endpunkt des fernen Netzes ist für die Verbindung empfangsbereit.</dd>
</dl>

Ändern Sie zum Einrichten einer eingehenden VPN-Verbindung folgende Einstellungen:
1. Überprüfen Sie, dass für `ipsec.auto` die Einstellung `add` festgelegt ist.
2. Optional: Legen Sie für `loadBalancerIP` eine portierbare öffentliche IP-Adresse fest, die für den StrongSwan-VPN-Service gilt. Die Angabe einer IP-Adresse ist nützlich, wenn Sie eine fixe IP-Adresse benötigen, z. B. wenn Sie festlegen müssen, welche IP-Adressen von einer lokalen Firewall zugelassen werden. Das Cluster muss mindestens eine verfügbare öffentliche Load Balancer-IP-Adresse haben. [Sie können Ihre verfügbaren öffentlichen IP-Adressen zur Überprüfung anzeigen](cs_subnets.html#review_ip) oder [eine bereits verwendete IP-Adresse freigeben](cs_subnets.html#free).<br>**Hinweis**:
    * Wenn Sie diese Einstellung leer lassen, wird eine der verfügbaren und portierbaren öffentlichen IP-Adressen verwendet.
    * Sie müssen auch die öffentliche IP-Adresse konfigurieren, die Sie für den VPN-Endpunkt des Clusters im lokalen VPN-Endpunkt auswählen oder die diesem VPN-Endpunkt des Clusters im lokalen VPN-Endpunkt zugewiesen ist.

Ändern Sie zum Einrichten einer ausgehenden VPN-Verbindung folgende Einstellungen:
1. Ändern Sie `ipsec.auto` in `start`.
2. Legen Sie für `remote.gateway` die öffentliche IP-Adresse für den lokalen VPN-Endpunkt im fernen Netz fest.
3. Wählen Sie als IP-Adresse für den VPN-Endpunkt des Clusters eine der folgenden Optionen:
    * **Öffentliche IP-Adresse des privaten Gateways des Clusters**: Wenn Ihre Workerknoten nur mit einem privaten VLAN verbunden sind, wird die ausgehende VPN-Anforderung über das private Gateway weitergeleitet, um das Internet zu erreichen. Die öffentliche IP-Adresse des privaten Gateways wird für die VPN-Verbindung verwendet.
    * **Öffentliche IP-Adresse des Workerknotens, auf dem der StrongSwan-Pod ausgeführt wird**: Wenn der Workerknoten, auf dem der StrongSwan-Pod ausgeführt wird, mit einem öffentlichen VLAN verbunden ist, wird für die VPN-Verbindung die öffentliche IP-Adresse des Workerknotens verwendet.
<br>**Anmerkung**:
        * Wenn der StrongSwan-Pod gelöscht und auf einem anderen Workerknoten im Cluster neu geplant wird, ändert sich die öffentliche IP-Adresse des VPNs. Der lokale VPN-Endpunkt des fernen Netzes muss zulassen, dass die VPN-Verbindung über die öffentliche IP-Adresse eines der Workerknoten des Clusters hergestellt wird.
        * Wenn der ferne VPN-Endpunkt VPN-Verbindungen über mehrere öffentliche IP-Adressen nicht handhaben kann, begrenzen Sie die Knoten, auf denen der StrongSwan-VPN-Pod bereitgestellt wird. Legen Sie für `nodeSelector` die IP-Adressen bestimmter Workerknoten oder eine Workerknotenbezeichnung fest. Der Wert `kubernetes.io/hostname: 10.232.xx.xx` lässt beispielsweise nur zu, dass der VPN-Pod auf diesem Workerknoten bereitgestellt wird. Der Wert `strongswan: vpn` beschränkt die Ausführung des VPN-Pods auf alle Workerknoten mit dieser Bezeichnung. Sie können eine beliebige Workerknotenbezeichnung auswählen. Verwenden Sie `strongswan: <release_name>`, um zuzulassen, dass mit unterschiedlichen Helm-Diagramm-Bereitstellungen auch unterschiedliche Workerknoten verwendet werden können. Wählen Sie für hohe Verfügbarkeit mindestens zwei Workerknoten aus.
    * **Öffentliche IP-Adresse des StrongSwan-Service**: Zum Herstellen einer Verbindung mithilfe der IP-Addresse des StrongSwan-VPN-Service legen Sie für `connectUsingLoadBalancerIP` die Einstellung `true` fest. Die IP-Adresse des StrongSwan-Service ist entweder eine portierbare öffentliche IP-Adresse, die Sie in der Einstellung `loadBalancerIP` angeben können, oder eine verfügbare portierbare öffentliche IP-Adresse, die dem Service automatisch zugeordnet wird.
<br>**Anmerkung**:
        * Wenn Sie wählen, eine IP-Adresse mithilfe der Einstellung `loadBalancerIP` auszuwählen, muss der Cluster über mindestens eine verfügbare öffentliche IP-Adresse der Lastausgleichsfunktion verfügen. [Sie können Ihre verfügbaren öffentlichen IP-Adressen zur Überprüfung anzeigen](cs_subnets.html#review_ip) oder [eine bereits verwendete IP-Adresse freigeben](cs_subnets.html#free).
        * Alle Workerknoten des Clusters müssen sich im selben öffentlichen VLAN befinden. Andernfalls müssen Sie die Einstellung `nodeSelector` verwenden, um sicherzustellen, dass der VPN-Pod auf einem Workerknoten in demselben öffentliche VLAN wie `loadBalancerIP` bereitgestellt wird.
        * Wenn für `connectUsingLoadBalancerIP` die Einstellung `true` festgelegt wurde und für `ipsec.keyexchange` die Einstellung `ikev1` gewählt wurde, müssen Sie für `enableServiceSourceIP` die Einstellung `true` festlegen.

### Schritt 4: Über die VPN-Verbindung auf Clusterressourcen zugreifen
{: #strongswan_4}

Ermitteln Sie, welche Clusterressourcen für das ferne Netz über die VPN-Verbindung zugänglich sein müssen.
{: shortdesc}

1. Fügen Sie die CIDRs mindestens eines Cluster-Teilnetzes zur Einstellung `local.subnet` hinzu. Sie müssen die CIDRs des lokalen Teilnetzes im lokalen VPN-Endpunkt konfigurieren. Diese Liste kann die folgenden Teilnetze enthalten:  
    * Die Teilnetz-CIDR des Kubernetes-Pods: `172.30.0.0/16`. Die bidirektionale Kommunikation ist zwischen allen Cluster-Pods und jedem der Hosts in den Teilnetzen des fernen Netzes aktiviert, die Sie in der Einstellung `remote.subnet` auflisten. Wenn Sie aus Sicherheitsgründen verhindern müssen, dass einer der Hosts des fernen Teilnetzes (`remote.subnet`) auf Cluster-Pods zugreift, dürfen Sie das Teilnetz des Kubernetes-Pods nicht der Einstellung `local.subnet` hinzufügen.
    * Die Teilnetz-CIDR des Kubernetes-Service: `172.21.0.0/16`. Service-IP-Adressen bieten die Möglichkeit, mehrere App-Pods verfügbar zu machen, die auf mehreren Workerknoten mit einer einzigen IP bereitgestellt sind.
    * Wenn Ihre Apps über einen NodePort-Service im privaten Netz oder in einer privaten Ingress-ALB (ALB – Application Load Balancer) zugänglich gemacht werden, müssen Sie die private Teilnetz-CIDR des Workerknotens hinzufügen. Rufen Sie die ersten drei Oktette der privaten IP-Adresse Ihres Workers ab, indem Sie `ibmcloud ks worker <cluster_name>` ausführen. Beispiel: Bei `10.176.48.xx` notieren Sie sich `10.176.48`. Rufen Sie als Nächstes die private Teilnetz-CIDR Ihre Workers ab, indem Sie den folgenden Befehl ausführen. Ersetzen Sie dabei `<xxx.yyy.zz>` durch das zuvor abgerufene Oktett: `ibmcloud sl subnet list | grep <xxx.yyy.zzz>`. <br>**Anmerkung**: Wenn ein Workerknoten in einem neuen privaten Teilnetz hinzugefügt wird, müssen Sie die neue private Teilnetz-CIDR zur `local.subnet`-Einstellung und zum lokalen VPN-Endpunkt hinzufügen. Anschließend muss die VPN-Verbindung erneut gestartet werden.
    * Wenn Sie Apps über LoadBalancer-Services im privaten Netz zugänglich machen, müssen Sie die private benutzerverwaltete Teilnetz-CIDR des Clusters hinzufügen. Sie finden diese Werte, indem Sie `ibmcloud ks cluster-get <cluster_name> --showResources` ausführen. Suchen Sie im Abschnitt **VLANS** nach CIDRs, deren **Public**-Wert `false` lautet.<br>
    **Hinweis**: Wenn `ipsec.keyexchange` auf `ikev1` festgelegt ist, können Sie nur ein Teilnetz angeben. Sie können jedoch die Einstellung `localSubnetNAT` verwenden, um mehrere Teilnetze eines Clusters zu einem einzigen Teilnetz zu kombinieren.

2. Optional: Ordnen Sie Teilnetze eines Clusters erneut zu, indem Sie die Einstellung `localSubnetNAT` verwenden. Network Address Translation (NAT) für Teilnetze bietet eine Ausweichlösung für Teilnetzkonflikte zwischen dem Clusternetz und dem lokalen fernen Netz. Sie können NAT verwenden, um die privaten lokalen IP-Teilnetze des Clusters, das Pod-Teilnetz (172.30.0.0/16) oder das Teilnetz des Pod-Service (172.21.0.0/16) zu einem anderen privaten Teilnetz zuzuordnen. Der VPN-Tunnel erkennt erneut zugeordnete IP-Teilnetze, die an Stelle der ursprünglichen Teilnetze treten. Die erneute Zuordnung erfolgt vor dem Senden der Pakete über den VPN-Tunnel sowie nach dem Eintreffen der Pakete aus dem VPN-Tunnel. Sie können sowohl erneut zugeordnete als auch nicht erneut zugeordnete Teilnetze gleichzeitig über VPN bereitstellen. Um NAT aktivieren zu können, können Sie entweder ein vollständiges Teilnetz oder einzelne IP-Adressen hinzufügen.
    * Wenn Sie ein vollständiges Teilnetz im Format `10.171.42.0/24=10.10.10.0/24` hinzufügen, erfolgt die erneute Zuordnung 1-zu-1: Alle IP-Adressen im internen Teilnetz werden einem externen Teilnetz zugeordnet und umgekehrt.
    * Wenn Sie einzelne IP-Adressen im Format `10.171.42.17/32=10.10.10.2/32,10.171.42.29/32=10.10.10.3/32` zuordnen, werden nur diese internen IP-Adressen den angegebenen externen IP-Adressen zugeordnet.

3. Optional für StrongSwan-Helm-Diagramme der Version 2.2.0 und höher: Verbergen Sie alle Cluster-IP-Adressen hinter einer einzigen IP-Adresse, indem Sie für `enableSingleSourceIP` die Einstellung `true` festlegen. Diese Option stellt eine der sichersten Konfigurationen für die VPN-Verbindung bereit, da keine Verbindungen vom fernen Netz zurück in den Cluster zulässig sind.
<br>**Anmerkung**:
    * Diese Einstellung erfordert, dass der gesamte Datenfluss über die VPN-Verbindung ausgehend sein muss; dies ist unabhängig davon, ob die VPN-Verbindung vom Cluster oder vom fernen Netz eingerichtet wird.
    * Für `local.subnet` muss lediglich ein /32-Teilnetz festgelegt werden. 

4. Optional für StrongSwan-Helm-Diagramme der Version 2.2.0 und höher: Aktivieren Sie den StrongSwan-Service, sodass eingehende Anforderungen des fernen Netzes an einen Service weitergeleitet werden, der sich außerhalb des Clusters befindet. Verwenden Sie dazu die Einstellung `localNonClusterSubnet`.
    <br>**Anmerkung**:
    * Der nicht zum Cluster gehörende Service muss im selben privaten Netz oder in einem privaten Netz vorhanden sein, das für die Workerknoten erreichbar ist.
    * Der nicht zum Cluster gehörende Workerknoten kann keinen Datenverkehr zum fernen Netz über die VPN-Verbindung einleiten, aber der nicht zum Cluster gehörende Knoten kann das Ziel eingehender Anforderungen des fernen Netzes sein.
    * Sie müssen die CIDRs der nicht zum Cluster gehörenden Teilnetze in der Einstellung `local.subnet` auflisten.

### Schritt 5: Über die VPN-Verbindung auf ferne Netzressourcen zugreifen
{: #strongswan_5}

Ermitteln Sie, welche fernen Netzressourcen für das Cluster über die VPN-Verbindung zugänglich sein müssen.
{: shortdesc}

1. Fügen Sie die CIDRs mindestens eines lokalen privaten Teilnetzes zur Einstellung `remote.subnet` hinzu.
<br>**Anmerkung**: Wenn `ipsec.keyexchange` auf `ikev1` festgelegt ist, können Sie nur ein Teilnetz angeben.
2. Optional für StrongSwan-Helm-Diagramme der Version 2.2.0 und höher: Ordnen Sie Teilnetze des fernen Netzes neu zu, indem Sie die Einstellung `remoteSubnetNAT` verwenden. Network Address Translation (NAT) für Teilnetze bietet eine Ausweichlösung für Teilnetzkonflikte zwischen dem Clusternetz und dem lokalen fernen Netz. Sie können NAT verwenden, um die IP-Teilnetze des fernen Netzes einem anderen privaten Teilnetz zuzuordnen. Der VPN-Tunnel erkennt erneut zugeordnete IP-Teilnetze, die an Stelle der ursprünglichen Teilnetze treten. Die erneute Zuordnung erfolgt vor dem Senden der Pakete über den VPN-Tunnel sowie nach dem Eintreffen der Pakete aus dem VPN-Tunnel. Sie können sowohl erneut zugeordnete als auch nicht erneut zugeordnete Teilnetze gleichzeitig über VPN bereitstellen.

### Schritt 6: Helm-Diagramm bereitstellen
{: #strongswan_6}

1. Beachten Sie die Dokumentation, die für jede Einstellung im Helm-Diagramm bereitgestellt ist, wenn Sie weitere erweiterte Einstellungen konfigurieren müssen.

2. **Wichtig**: Wenn Sie eine Einstellung im Helm-Diagramm nicht benötigen, kommentieren Sie diese Eigenschaft aus, indem Sie jeweils ein `#` davorsetzen.

3. Speichern Sie die aktualisierte Datei `config.yaml`.

4. Installieren Sie das Helm-Diagramm auf Ihrem Cluster mit der aktualisierten Datei `config.yaml`. Die aktualisierten Eigenschaften werden in einer Konfigurationszuordnung für Ihr Diagramm gespeichert.

    **Hinweis**: Wenn Sie über mehrere VPN-Bereitstellungen in einem einzelnen Cluster verfügen, können Sie Namenskonflikte vermeiden und zwischen Ihren Bereitstellungen unterscheiden, indem Sie aussagekräftigere Releasenamen als `vpn` verwenden. Um das Abschneiden des Releasenamens zu vermeiden, begrenzen Sie den Releasenamen auf maximal 35 Zeichen.

    ```
    helm install -f config.yaml --name=vpn ibm/strongswan
    ```
    {: pre}

5. Prüfen Sie den Status der Diagrammbereitstellung. Sobald das Diagramm bereit ist, hat das Feld **STATUS** oben in der Ausgabe den Wert `DEPLOYED`.

    ```
    helm status vpn
    ```
    {: pre}

6. Sobald das Diagramm bereitgestellt ist, überprüfen Sie, dass die aktualisierten Einstellungen in der Datei `config.yaml` verwendet wurden.

    ```
    helm get values vpn
    ```
    {: pre}

## StrongSwan-VPN-Konnektivität testen und überprüfen
{: #vpn_test}

Nachdem Sie Ihr Helm-Diagramm bereitgestellt haben, testen Sie die VPN-Konnektivität.
{:shortdesc}

1. Wenn das VPN im lokalen Gateway nicht aktiv ist, starten Sie das VPN.

2. Legen Sie die Umgebungsvariable `STRONGSWAN_POD` fest.

    ```
    export STRONGSWAN_POD=$(kubectl get pod -l app=strongswan,release=vpn -o jsonpath='{ .items[0].metadata.name }')
    ```
    {: pre}

3. Prüfen Sie den Status des VPN. Der Status `ESTABLISHED` bedeutet, dass die VPN-Verbindung erfolgreich war.

    ```
    kubectl exec $STRONGSWAN_POD -- ipsec status
    ```
    {: pre}

    Beispielausgabe:

    ```
    Security Associations (1 up, 0 connecting):
    k8s-conn[1]: ESTABLISHED 17 minutes ago, 172.30.xxx.xxx[ibm-cloud]...192.xxx.xxx.xxx[on-premises]
    k8s-conn{2}: INSTALLED, TUNNEL, reqid 12, ESP in UDP SPIs: c78cb6b1_i c5d0d1c3_o
    k8s-conn{2}: 172.21.0.0/16 172.30.0.0/16 === 10.91.152.xxx/26
    ```
    {: screen}

    **Hinweis**:

    <ul>
    <li>Wenn Sie versuchen, die VPN-Konnektivität mit dem StrongSwan-Helm-Diagramm zu erstellen, ist es wahrscheinlich, dass das VPN beim ersten Mal nicht den Status `ESTABLISHED` aufweist. Unter Umständen müssen Sie die Einstellungen des lokalen VPN-Endpunkts prüfen und die Konfigurationsdatei mehrmals ändern, bevor die Verbindung erfolgreich ist: <ol><li>Führen Sie folgenden Befehl aus: `helm delete --purge <release_name>`</li><li>Korrigieren Sie die falschen Werte in der Konfigurationsdatei.</li><li>Führen Sie `helm install -f config.yaml --name=<release_name> ibm/strongswan` aus.</li></ol>Sie können im nächsten Schritt noch weitere Prüfungen ausführen.</li>
    <li>Falls der VPN-Pod den Status `ERROR` aufweist oder immer wieder ausfällt und neu startet, kann dies an der Parametervalidierung der `ipsec.conf`-Einstellungen in der Konfigurationszuordnung des Diagramms liegen.<ol><li>Prüfen Sie, ob dies der Fall ist, indem Sie mithilfe des Befehls `kubectl logs -n $STRONGSWAN_POD` in den Protokollen des StrongSwan-Pods nach Validierungsfehlern suchen.</li><li>Wenn Gültigkeitsfehler vorhanden sind, führen Sie den folgenden Befehl aus: `helm delete --purge <release_name>`<li>Korrigieren Sie die falschen Werte in der Konfigurationsdatei.</li><li>Führen Sie `helm install -f config.yaml --name=<release_name> ibm/strongswan` aus.</li></ol>Wenn Ihr Cluster viele Workerknoten umfasst, können Sie mit `helm upgrade` Ihre Änderungen schneller anwenden, anstatt erst `helm delete` und `helm install` auszuführen.</li>
    </ul>

4. Sie können die VPN-Konnektivität weiter testen, indem Sie die fünf Helm-Tests ausführen, die in der StrongSwan-Diagrammdefinition enthalten sind.

    ```
    helm test vpn
    ```
    {: pre}

    * Wenn alle Tests erfolgreich sind, wurde Ihre StrongSwan-VPN-Verbindung erfolgreich konfiguriert.

    * Wenn ein Test fehlschlägt, fahren Sie mit dem nächsten Schritt fort.

5. Zeigen Sie die Ausgabe eines fehlgeschlagenen Tests an, indem Sie die Protokolle des Testpods anzeigen.

    ```
    kubectl logs <testprogramm>
    ```
    {: pre}

    **Hinweis**: Einige der Tests haben als Voraussetzungen optionale Einstellungen in der VPN-Konfiguration. Wenn einige der Tests fehlschlagen, kann dies abhängig davon, ob Sie diese optionalen Einstellungen angegeben haben, zulässig sein. Suchen Sie in der folgenden Tabelle nach Informationen zu den einzelnen Tests und warum ein Test fehlschlagen könnte.

    {: #vpn_tests_table}
    <table>
    <caption>Erklärung der Helm-VPN-Konnektivitätstests</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der Helm-VPN-Konnektivitätstests</th>
    </thead>
    <tbody>
    <tr>
    <td><code>vpn-strongswan-check-config</code></td>
    <td>Überprüft die Syntax der Datei <code>ipsec.conf</code>, die von der Datei <code>config.yaml</code> generiert wird. Dieser Test kann aufgrund von falschen Werten in der Datei <code>config.yaml</code> fehlschlagen.</td>
    </tr>
    <tr>
    <td><code>vpn-strongswan-check-state</code></td>
    <td>Überprüft, ob die VPN-Verbindung den Status <code>ESTABLISHED</code> aufweist. Dieser Test kann aus folgenden Gründen fehlschlagen:<ul><li>Unterschiede zwischen den Werten in der Datei <code>config.yaml</code> und den lokalen VPN-Endpunkteinstellungen im Unternehmen.</li><li>Wenn der Cluster empfangsbereit ist (im Modus "listen") (für <code>ipsec.auto</code> ist <code>add</code> festgelegt), ist die Verbindung auf der lokalen Unternehmensseite nicht eingerichtet.</li></ul></td>
    </tr>
    <tr>
    <td><code>vpn-strongswan-ping-remote-gw</code></td>
    <td>Überprüfen Sie die öffentliche IP-Adresse <code>remote.gateway</code>, die Sie in der Datei <code>config.yaml</code> konfiguriert haben mit einem Pingsignal, Dieser Test kann aus folgenden Gründen fehlschlagen:<ul><li>Sie haben keine IP-Adresse für das lokalen VPN-Gateway im Unternehmen angegeben. Falls für <code>ipsec.auto</code> die Einstellung <code>start</code> festgelegt ist, ist die IP-Adresse <code>remote.gateway</code> erforderlich.</li><li>Die VPN-Verbindung weist nicht den Status <code>ESTABLISHED</code> auf. Weitere Informationen finden Sie unter <code>vpn-strongswan-check-state</code>.</li><li>Die VPN-Konnektivität weist den Status <code>ESTABLISHED</code> auf aber ICMP-Pakete werden von der Firewall geblockt.</li></ul></td>
    </tr>
    <tr>
    <td><code>vpn-strongswan-ping-remote-ip-1</code></td>
    <td>Die private IP-Adresse <code>remote.privateIPtoPing</code> des lokalen VPN-Gateways im Unternehmen wird vom VPN-Pod im Cluster mit einem Pingsignal überprüft. Dieser Test kann aus folgenden Gründen fehlschlagen:<ul><li>Sie haben keine IP-Adresse <code>remote.privateIPtoPing</code> angegeben. Wenn Sie absichtlich keine IP-Adresse angegeben haben, ist dieser Fehler akzeptabel.</li><li>Sie haben das Teilnetz-CIDR für den Cluster-Pod, <code>172.30.0.0/16</code>, nicht in der Liste <code>local.subnet</code> angegeben.</li></ul></td>
    </tr>
    <tr>
    <td><code>vpn-strongswan-ping-remote-ip-2</code></td>
    <td>Die private IP-Adresse <code>remote.privateIPtoPing</code> des lokalen VPN-Gateways im Unternehmen wird vom Workerknoten im Cluster mit einem Pingsignal überprüft. Dieser Test kann aus folgenden Gründen fehlschlagen:<ul><li>Sie haben keine IP-Adresse <code>remote.privateIPtoPing</code> angegeben. Wenn Sie absichtlich keine IP-Adresse angegeben haben, ist dieser Fehler akzeptabel.</li><li>Sie haben das private Teilnetz-CIDR für den Workernoten im Cluster nicht in der Liste <code>local.subnet</code> angegeben.</li></ul></td>
    </tr>
    </tbody></table>

6. Löschen Sie das Helm-Diagramm.

    ```
    helm delete --purge vpn
    ```
    {: pre}

7. Öffnen Sie die Datei `config.yaml` und korrigieren Sie die falschen Werte.

8. Speichern Sie die aktualisierte Datei `config.yaml`.

9. Installieren Sie das Helm-Diagramm auf Ihrem Cluster mit der aktualisierten Datei `config.yaml`. Die aktualisierten Eigenschaften werden in einer Konfigurationszuordnung für Ihr Diagramm gespeichert.

    ```
    helm install -f config.yaml --name=<releasename> ibm/strongswan
    ```
    {: pre}

10. Prüfen Sie den Status der Diagrammbereitstellung. Sobald das Diagramm bereit ist, hat das Feld **STATUS** oben in der Ausgabe den Wert `DEPLOYED`.

    ```
    helm status vpn
    ```
    {: pre}

11. Sobald das Diagramm bereitgestellt ist, überprüfen Sie, dass die aktualisierten Einstellungen in der Datei `config.yaml` verwendet wurden.

    ```
    helm get values vpn
    ```
    {: pre}

12. Bereinigen Sie die aktuellen Testpods.

    ```
    kubectl get pods -a -l app=strongswan-test
    ```
    {: pre}

    ```
    kubectl delete pods -l app=strongswan-test
    ```
    {: pre}

13. Führen Sie die Tests erneut aus.

    ```
    helm test vpn
    ```
    {: pre}

<br />


## Aktualisieren Sie das StrongSwan-Helm-Diagramm
{: #vpn_upgrade}

Stellen Sie sicher, dass Ihr StrongSwan-Helm-Diagramm aktuell ist, indem Sie es aktualisieren.
{:shortdesc}

Gehen Sie wie folge vor, um das StrongSwan-Helm-Diagramm auf die neueste Version zu aktualisieren.

  ```
  helm upgrade -f config.yaml <releasename> ibm/strongswan
  ```
  {: pre}

**Wichtig**: Das strongSwan 2.0.0-Helm-Diagramm ist nicht mit Calico Version 3 oder Kubernetes Version 1.10 kompatibel. Bevor Sie [Ihr Cluster auf 1.10 aktualisieren](cs_versions.html#cs_v110), aktualisieren Sie StrongSwan auf das Helm-Diagramm der Version 2.2.0, das abwärtskompatibel zu Calico 2.6 und Kubernetes 1.8 und 1.9 ist.

Cluster auf Kubernetes 1.10 aktualisieren? Stellen Sie sicher, dass Sie zuvor Ihr StrongSwan-Helm-Diagramm löschen. Installieren Sie es erneut nach der Aktualisierung.
{:tip}

### Upgrade von Version 1.0.0 durchführen
{: #vpn_upgrade_1.0.0}

Aufgrund einiger Einstellungen, die in der Version 1.0.0 des Helm-Diagramms verwendet werden, können Sie `helm upgrade` nicht für eine Aktualisierung ´von Version 1.0.0 auf die neueste Version verwenden.
{:shortdesc}

Um ein Upgrade von Version 1.0.0 auszuführen, müssen Sie das Diagramm der Version 1.0.0 löschen und die neueste Version installieren.

1. Löschen Sie das Helm-Diagramm der Version 1.0.0

    ```
    helm delete --purge <releasename>
    ```
    {: pre}

2. Speichern Sie die Standardkonfigurationseinstellungen für das StrongSwan-Helm-Diagramm in einer lokalen YAML-Datei.

    ```
    helm inspect values ibm/strongswan > config.yaml
    ```
    {: pre}

3. Aktualisieren Sie die Konfigurationsdatei, und speichern Sie die Datei mit den Änderungen.

4. Installieren Sie das Helm-Diagramm auf Ihrem Cluster mit der aktualisierten Datei `config.yaml`.

    ```
    helm install -f config.yaml --name=<releasename> ibm/strongswan
    ```
    {: pre}

Zusätzlich werden bestimmte `ipsec.conf`-Einstellungen für die Zeitlimitüberschreitung, die in Version 1.0.0 fest codiert waren, in nachfolgenden Versionen als konfigurierbare Eigenschaften bereitgestellt. Die Namen und Standardwerte einiger dieser konfigurierbaren `ipsec.conf`-Einstellungen für die Zeitlimitüberschreitung wurden ferner geändert, damit Sie mit den Standardwerten von StrongSwan besser harmonieren. Wenn Sie ein Upgrade für Ihr Helm-Diagramm von Version 1.0.0 durchführen und die Standardwerte der Version 1.0.0 für die Zeitlimitüberschreitung beibehalten möchten, fügen Sie die alten Standardwerte als neue Einstellungen zu Ihrer Diagrammkonfigurationsdatei hinzu.



  <table>
  <caption>Unterschiede der ipsec.conf-Einstellungen zwischen Version 1.0.0 und der neuesten Version</caption>
  <thead>
  <th>Einstellungsnamen in Version 1.0.0</th>
  <th>Standardwert in Version 1.0.0</th>
  <th>Einstellungsname in der neusten Version</th>
  <th>Standardwert in der neuesten Version</th>
  </thead>
  <tbody>
  <tr>
  <td><code>ikelifetime</code></td>
  <td>60m</td>
  <td><code>ikelifetime</code></td>
  <td>3h</td>
  </tr>
  <tr>
  <td><code>keylife</code></td>
  <td>20m</td>
  <td><code>lifetime</code></td>
  <td>1h</td>
  </tr>
  <tr>
  <td><code>rekeymargin</code></td>
  <td>3m</td>
  <td><code>margintime</code></td>
  <td>9m</td>
  </tr>
  </tbody></table>


## StrongSwan-IPSec-VPN-Service inaktivieren
{: vpn_disable}

Sie können die VPN-Verbindung inaktivieren, indem Sie das Helm-Diagramm löschen .
{:shortdesc}

  ```
  helm delete --purge <releasename>
  ```
  {: pre}

<br />


## Virtual Router Appliance verwenden
{: #vyatta}

[Virtual Router Appliance (VRA)](/docs/infrastructure/virtual-router-appliance/about.html) stellt das aktuelle Vyatta 5600-Betriebssystem für x86-Bare-Metal-Server bereit. Sie können eine VRA-Instanz als VPN-Gateway verwenden, um eine sichere Verbindung zu einem lokalen Netz herzustellen.
{:shortdesc}

Der gesamte öffentliche und private Netzverkehr, der in die Cluster-VLANs eintritt oder sie verlässt, wird über eine VRA geleitet. Sie können die VRA als VPN-Endpunkt einsetzen, um einen verschlüsselten IPSec-Tunnel zwischen Servern in IBM Cloud Infrastructure- (SoftLayer) und lokalen Ressourcen zu erstellen. Das folgende Diagramm zeigt beispielsweise, wie eine App auf einem privaten Workerknoten in {{site.data.keyword.containershort_notm}} mit einem lokalen Server über eine VRA-VPN-Verbindung kommunizieren kann:

<img src="images/cs_vpn_vyatta.png" width="725" alt="App in {{site.data.keyword.containershort_notm}} mithilfe einer Lastausgleichsfunktion zugänglich machen" style="width:725px; border-style: none"/>

1. Eine App in Ihrem Cluster, `myapp2`, empfängt eine Anforderung von einem Ingress- oder LoadBalancer-Service und muss eine sichere Verbindung mit Daten in Ihrem lokalen Netz herstellen.

2. Da `myapp2` sich auf einem Workerknoten in einem rein privaten VLAN befindet, fungiert die VRA als sichere Verbindung zwischen den Workerknoten und dem lokalen Netz. Die VRA verwendet die IP-Zieladresse, um zu bestimmen, welche Netzpakete an das lokale Netz gesendet werden sollen.

3. Die Anforderung wird verschlüsselt und über den VPN-Tunnel an das lokale Rechenzentrum gesendet.

4. Die eingehende Anforderung passiert die lokale Firewall und wird an den VPN-Tunnelendpunkt (Router) zugestellt, wo sie entschlüsselt wird.

5. Der VPN-Tunnelendpunkt (Router) leitet die Anforderung abhängig von der in Schritt 2 angegebenen Ziel-IP-Adresse an den lokalen Server oder den Mainframe weiter. Die erforderlichen Daten werden auf dieselbe Weise über die VPN-Verbindung zurück an `myapp2` gesendet.

Führen Sie die folgenden Schritte aus, um eine Virtual Router Appliance einzurichten:

1. [Bestellen Sie eine Virtual Router Appliance (VRA)](/docs/infrastructure/virtual-router-appliance/getting-started.html).

2. [Konfigurieren Sie das private VLAN auf der VRA](/docs/infrastructure/virtual-router-appliance/manage-vlans.html).

3. Um eine VPN-Verbindung mithilfe der VRA zu aktivieren, [konfigurieren Sie VRRP auf der VRA](/docs/infrastructure/virtual-router-appliance/vrrp.html#high-availability-vpn-with-vrrp).

**Anmerkung**: Wenn Sie über eine vorhandene Router Appliance verfügen und dann einen Cluster hinzufügen, werden die neuen portierbaren Teilnetze, die für den Cluster bestellt sind, nicht in der Router Appliance konfiguriert. Zum Verwenden von Netzservices müssen Sie die Weiterleitung zwischen den Teilnetzen im selben VLAN aktivieren, indem Sie das [VLAN-Spanning aktivieren](cs_subnets.html#subnet-routing).
