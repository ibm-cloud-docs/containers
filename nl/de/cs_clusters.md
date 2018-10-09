---

copyright:
  years: 2014, 2018
lastupdated: "2018-09-10"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Cluster und Workerknoten einrichten
{: #clusters}
Erstellen Sie Cluster und fügen Sie Workerknoten hinzu, um die Clusterkapazität in {{site.data.keyword.containerlong}} zu erhöhen. Machen Sie sich noch mit der Anwendung vertraut? Sehen Sie sich dazu das [Lernprogramm zum Erstellen von Kubernetes-Clustern](cs_tutorials.html#cs_cluster_tutorial) an.
{: shortdesc}

## Cluster über die GUI erstellen
{: #clusters_ui}

Der Zweck des Kubernetes-Clusters besteht darin, eine Gruppe von Ressourcen, Knoten, Netzen und Speichereinheiten zu definieren, die die Hochverfügbarkeit von Apps sicherstellen. Bevor Sie eine App bereitstellen können, müssen Sie zunächst einen Cluster erstellen und die Definitionen für die Workerknoten in diesem Cluster festlegen.
{:shortdesc}

**Vorbereitende Schritte**
* Sie müssen über ein Testkonto, ein nutzungsabhängiges Konto oder ein Abonnementkonto als [{{site.data.keyword.Bluemix_notm}}-Konto](https://console.bluemix.net/registration/) verfügen.
* Entscheiden Sie sich zwischen einem [kostenlosen Cluster und einem Standardcluster](cs_why.html#cluster_types).
* Wenn Sie einen Standardcluster erstellen, können Sie [die Kosten mit dem Preisrechner![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link") ](https://console.bluemix.net/pricing/configure/iaas/containers-kubernetes) schätzen. **Hinweis**: Sie müssen für jeden Cluster ein **dediziertes Netz (1 Teilnetz mit 8 portierbaren öffentlichen IPs)** zu Ihrer Schätzung hinzufügen. Außerdem variieren die Kosten für die Bandbreite für abgehende Netze je nach Nutzung und stellen eine zusätzliche Gebühr dar, die über die Gebühren im Preisrechner hinausgeht.

Um Ihre Cluster mit der Hardwareisolation, der Zone, der API-Version Ihrer Wahl usw. umfassend anzupassen, erstellen Sie zunächst einen Standardcluster.
{: tip}

**Gehen Sie wie folgt vor, um einen kostenlosen Cluster zu erstellen**

Sie können sich mit Ihrem kostenlosen Cluster mit der Funktionsweise von {{site.data.keyword.containerlong_notm}} vertraut machen. Mit kostenlosen Clustern können Sie die Terminologie kennenlernen, das Lernprogramm ausführen und sich mit der Anwendung vertraut machen, bevor Sie den Sprung zu Standardclustern auf Produktebene wagen. Auch bei einem nutzungsabhängigen Konto oder einem Abonnementkonto erhalten Sie einen kostenlosen Cluster. **Hinweis**: Kostenlose Cluster sind 30 Tage lang gültig. Nach Ablauf dieser Zeit verfällt der Cluster und der Cluster und seine Daten werden gelöscht. Die gelöschten Daten werden nicht von {{site.data.keyword.Bluemix_notm}} gesichert und können nicht wiederhergestellt werden. Stellen Sie sicher, dass alle wichtigen Daten gesichert werden.

1. Wählen Sie im Katalog die Option **{{site.data.keyword.containerlong_notm}}** aus.

2. Wählen Sie eine Region aus, in der Ihr Cluster bereitgestellt werden soll. **Hinweis**: Sie können keine kostenlosen Cluster in den Regionen 'Vereinigte Staaten (Osten)' oder 'Asien-Pazifik (Norden)' und den entsprechenden Zonen erstellen.

3. Wählen Sie den **kostenlosen** Clusterplan aus.

4. Geben Sie Ihrem Cluster einen Namen. Der Name muss mit einem Buchstaben beginnen, darf Buchstaben, Ziffern und den Bindestrich (-) enthalten und darf maximal 35 Zeichen lang sein. Der vollständig qualifizierte Domänenname für die Ingress-Unterdomäne setzt sich aus dem Clusternamen und der Region zusammen, in der der Cluster bereitgestellt wird. Um sicherzustellen, dass die Ingress-Unterdomäne innerhalb einer Region eindeutig ist, wird der Clustername möglicherweise abgeschnitten und es wird ein beliebiger Wert innerhalb des Ingress-Domänennamens angehängt.


5. Klicken Sie auf **Cluster einrichten**. Standardmäßig wird ein Worker-Pool mit einem Workerknoten erstellt. Auf der Registerkarte **Workerknoten** können Sie den Fortschritt der Bereitstellung des Workerknotens überprüfen. Nach Abschluss der Bereitstellung können Sie auf der Registerkarte **Übersicht** sehen, dass Ihr Cluster bereit ist.

    Wenn die eindeutige ID oder der Domänenname geändert wird, die/der während der Erstellung zugeordnet wird, kann der Kubernetes-Master Ihren Cluster nicht mehr verwalten.
    {: tip}

</br>

**Gehen Sie wie folgt vor, um einen Standardcluster zu erstellen**:

1. Wählen Sie im Katalog die Option **{{site.data.keyword.containerlong_notm}}** aus.

2. Wählen Sie eine Region aus, in der Ihr Cluster bereitgestellt werden soll. Wählen Sie die Region aus, die Ihrem Standort am nächsten ist, um eine optimale Leistung zu erhalten. Wenn Sie eine Zone auswählen, die sich außerhalb Ihres Landes befindet, müssen Sie daran denken, dass Sie vor dem Speichern der Daten möglicherweise eine entsprechende Berechtigung benötigen.

3. Wählen Sie den **Standard**-Cluster-Plan aus. Bei einem Standardcluster erhalten Sie Zugriff auf Features wie beispielsweise mehrere Workerknoten für eine hoch verfügbare Umgebung.

4. Geben Sie Ihre Zonendetails ein.

    1. Wählen Sie für die Verfügbarkeit die Option für **Einzelzonencluster** oder **Mehrzonencluster** aus. In einem Mehrzonencluster wird der Masterknoten in einer auf mehrere Zonen ausgelegten Zone bereitgestellt und die Ressourcen Ihres Clusters werden auf mehrere Zonen verteilt. Ihre Auswahl kann durch die Region begrenzt werden.

    2. Wählen Sie die Zonen aus, in denen der Cluster als Host für den Cluster verwendet werden soll. Sie müssen mindestens eine Zone auswählen, können jedoch so viele Zonen auswählen, wie Sie möchten. Wenn Sie mehr als eine Zone auswählen, werden die Workerknoten auf die Zonen verteilt, die Sie auswählen, wodurch eine höhere Verfügbarkeit erzielt werden kann. Wenn Sie nur eine Zone auswählen, [fügen Sie Zonen zu Ihrem Cluster hinzu](#add_zone), nachdem dieser erstellt wurde.

    3. Wählen Sie ein öffentliches VLAN (optional) und ein privates VLAN (erforderlich) in Ihrem IBM Cloud-Infrastrukturkonto (SoftLayer) aus. Workerknoten kommunizieren miteinander, indem sie das private VLAN verwenden. Um mit dem Kubernetes-Master kommunizieren zu können, müssen Sie die öffentliche Konnektivität für Ihren Workerknoten konfigurieren.  Wenn Sie in dieser Zone kein privates oder öffentliches VLAN haben, geben Sie diese Option nicht an. Ein privates und ein öffentliches VLAN werden automatisch für Sie erstellt. Wenn Sie über vorhandene VLANs verfügen und kein öffentliches VLAN angeben, sollten Sie eine Firewall konfigurieren, z. B. eine [Virtual Router Appliance](/docs/infrastructure/virtual-router-appliance/about.html#about). Sie können dasselbe VLAN für mehrere Cluster verwenden.
        **Hinweis**: Wenn Workerknoten nur mit einem privaten VLAN eingerichtet werden, müssen Sie eine alternative Lösung für die Netzkonnektivität konfigurieren. Weitere Informationen finden Sie unter [Ausschließlich private Clusternetze planen](cs_network_cluster.html#private_vlan). 

5. Konfigurieren Sie Ihren Standard-Worker-Pool. Worker-Pools sind Gruppen von Workerknoten, die dieselbe Konfiguration aufweisen. Sie können auch noch zu einem späteren Zeitpunkt weitere Worker-Pools hinzufügen.

    1. Wählen Sie einen Typ von Hardwareisolation aus. Virtuell wird auf Stundenbasis berechnet und Bare-Metal wird monatlich in Rechnung gestellt.

        - **Virtuell - Dediziert**: Ihre Workerknoten werden in einer Infrastruktur gehostet, die Ihrem Konto vorbehalten ist. Ihre physischen Ressourcen sind vollständig isoliert.

        - **Virtuell - Gemeinsam genutzt**: Infrastrukturressourcen wie der Hypervisor und physische Hardware werden von Ihnen und anderen IBM Kunden gemeinsam genutzt, aber jeder Workerknoten ist ausschließlich für Sie zugänglich. Obwohl diese Option in den meisten Fällen ausreicht und kostengünstiger ist, sollten Sie die Leistungs- und Infrastrukturanforderungen anhand der Richtlinien Ihres Unternehmens prüfen.

        - **Bare-Metal**: Bare-Metal-Server werden monatlich abgerechnet und durch manuelle Interaktion mit der IBM Cloud-Infrastructure (SoftLayer) bereitgestellt, daher kann die Ausführung mehr als einen Arbeitstag dauern. Bare-Metal-Server eignen sich am besten für Hochleistungsanwendungen, die mehr Ressourcen und Hoststeuerung erfordern. Für Cluster, auf denen Kubernetes Version 1.9 oder höher ausgeführt wird, können Sie auch auswählen, dass [Trusted Compute](cs_secure.html#trusted_compute) aktiviert wird, um Ihre Workerknoten auf Manipulation zu überprüfen. Trusted Compute ist für ausgewählte Bare-Metal-Maschinentypen verfügbar. Beispielsweise unterstützen die GPU-Typen `mgXc` Trusted Compute nicht. Wenn Sie Trusted Compute während der Clustererstellung nicht aktivieren, dies jedoch später nachholen möchten, können Sie den [Befehl](cs_cli_reference.html#cs_cluster_feature_enable) `ibmcloud ks feature-enable` verwenden. Nachdem Sie Trusted Compute aktiviert haben, können Sie es später nicht mehr inaktivieren.

        Stellen Sie sicher, dass Sie eine Bare-Metal-Maschine bereitstellen wollen. Da die Abrechnung monatlich erfolgt, wird Ihnen ein voller Monat auch dann berechnet, wenn Sie versehentlich bestellen und sofort danach Ihre Bestellung wieder stornieren.
        {:tip}

    2. Wählen Sie einen Maschinentyp aus. Der Maschinentyp definiert die Menge an virtueller CPU, Hauptspeicher und Festplattenspeicher, die in jedem Workerknoten eingerichtet wird und allen Containern zur Verfügung steht. Die verfügbaren Bare-Metal- und virtuellen Maschinentypen variieren je nach Zone, in der Sie den Cluster implementieren. Nachdem Sie Ihre Cluster erstellt haben, können Sie unterschiedliche Maschinentypen hinzufügen, indem Sie einen Worker oder Pool zum Cluster hinzufügen.

    3. Geben Sie die Anzahl der Workerknoten an, die Sie im Cluster benötigen. Die von Ihnen eingegebene Anzahl der Worker wird über die Anzahl der von Ihnen ausgewählten Zonen repliziert. Wenn Sie beispielsweise über zwei Zonen verfügen und drei Workerknoten auswählen, bedeutet das, dass sechs Knoten bereitgestellt werden und drei Knoten in jeder Zone vorhanden sind.

6. Geben Sie dem Cluster einen eindeutigen Namen. **Hinweis**: Wenn die eindeutige ID oder der Domänenname geändert wird, die/der während der Erstellung zugeordnet wird, kann der Kubernetes-Master Ihren Cluster nicht mehr verwalten.

7. Wählen Sie die Kubernetes-API-Serverversion für den Cluster-Masterknoten aus.

8. Klicken Sie auf **Cluster einrichten**. Ein Worker-Pool wird mit der Anzahl der Worker erstellt, die Sie angegeben haben. Auf der Registerkarte **Workerknoten** können Sie den Fortschritt der Bereitstellung des Workerknotens überprüfen. Nach Abschluss der Bereitstellung können Sie auf der Registerkarte **Übersicht** sehen, dass Ihr Cluster bereit ist.

**Womit möchten Sie fortfahren? **

Wenn der Cluster betriebsbereit ist, können Sie sich mit den folgenden Tasks vertraut machen:

-   Verteilen Sie Workerknoten über mehrere Zonen hinweg, indem Sie [eine Zone zu Ihrem Cluster hinzufügen](#add_zone).
-   [Installieren Sie die Befehlszeilenschnittstellen (CLIs) und nehmen Sie die Arbeit mit dem Cluster auf.](cs_cli_install.html#cs_cli_install)
-   [Stellen Sie eine App in Ihrem Cluster bereit.](cs_app.html#app_cli)
-   [Richten Sie Ihre eigene private Registry in {{site.data.keyword.Bluemix_notm}} ein, um Docker-Images zu speichern und gemeinsam mit anderen Benutzern zu verwenden.](/docs/services/Registry/index.html)
- Wenn Sie über mehrere VLANs für einen Cluster, mehrere Teilnetze in demselben VLAN oder einen Cluster mit mehreren Zonen verfügen, müssen Sie [VLAN-Spanning](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) für Ihr Konto für die IBM Cloud-Infrastruktur (SoftLayer) aktivieren, damit die Workerknoten in dem privaten Netz miteinander kommunizieren können. Um diese Aktion durchführen zu können, müssen Sie über die [Infrastrukturberechtigung](cs_users.html#infra_access) **Netz > VLAN-Spanning im Netz verwalten** verfügen oder Sie können den Kontoeigner bitte, diese zu aktivieren. Um zu prüfen, ob das VLAN-Spanning bereits aktiviert ist, verwenden Sie den [Befehl](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`. Wenn Sie {{site.data.keyword.BluDirectLink}} verwenden, müssen Sie stattdessen eine [ VRF-Funktion (Virtual Router Function)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf) verwenden. Um VRF zu aktivieren, wenden Sie sich an Ihren Ansprechpartner für die IBM Cloud-Infrastruktur (SoftLayer). 
- Wenn Sie über eine Firewall verfügen, müssen Sie unter Umständen [die erforderlichen Ports öffnen](cs_firewall.html#firewall), um `ibmcloud`-, `kubectl`- oder `calicotl`-Befehle zu verwenden, um abgehenden Datenverkehr von Ihrem Cluster zu ermöglichen oder um eingehenden Datenverkehr für Netzservices zuzulassen.
-  Cluster mit Kubernetes Version 1.10 oder höher: Steuern Sie mit [Pod-Sicherheitsrichtlinien](cs_psp.html), wer Pods in Ihrem Cluster erstellen kann.

<br />


## Cluster über die CLI erstellen
{: #clusters_cli}

Der Zweck des Kubernetes-Clusters besteht darin, eine Gruppe von Ressourcen, Knoten, Netzen und Speichereinheiten zu definieren, die die Hochverfügbarkeit von Apps sicherstellen. Bevor Sie eine App bereitstellen können, müssen Sie zunächst einen Cluster erstellen und die Definitionen für die Workerknoten in diesem Cluster festlegen.
{:shortdesc}

Vorbemerkungen:
- Sie müssen über ein nutzungsabhängiges [{{site.data.keyword.Bluemix_notm}}-Konto](https://console.bluemix.net/registration/) oder über ein Abonnementkonto verfügen, das für den [Zugriff auf das Portfolio der IBM Cloud-Infrastruktur (SoftLayer)](cs_troubleshoot_clusters.html#cs_credentials) konfiguriert ist. Sie können einen kostenlosen Cluster erstellen, um 30 Tage lang einige der Leistungsmerkmale zu testen. Oder Sie können umfassend anpassbare Standardcluster mit Ihrer gewünschten Hardwareisolation erstellen.
- [Stellen Sie sicher, dass Sie die erforderlichen Berechtigungen zum Bereitstellen eines Standardclusters in der IBM Cloud-Infrastruktur (SoftLayer) haben](cs_users.html#infra_access).
- Installieren Sie die {{site.data.keyword.Bluemix_notm}}-CLI sowie das [{{site.data.keyword.containerlong_notm}}-Plug-in](cs_cli_install.html#cs_cli_install).
- Wenn Sie über mehrere VLANs für einen Cluster, mehrere Teilnetze in demselben VLAN oder einen Cluster mit mehreren Zonen verfügen, müssen Sie [VLAN-Spanning](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) für Ihr Konto für die IBM Cloud-Infrastruktur (SoftLayer) aktivieren, damit die Workerknoten in dem privaten Netz miteinander kommunizieren können. Um diese Aktion durchführen zu können, müssen Sie über die [Infrastrukturberechtigung](cs_users.html#infra_access) **Netz > VLAN-Spanning im Netz verwalten** verfügen oder Sie können den Kontoeigner bitte, diese zu aktivieren. Um zu prüfen, ob das VLAN-Spanning bereits aktiviert ist, verwenden Sie den [Befehl](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`. Wenn Sie {{site.data.keyword.BluDirectLink}} verwenden, müssen Sie stattdessen eine [ VRF-Funktion (Virtual Router Function)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf) verwenden. Um VRF zu aktivieren, wenden Sie sich an Ihren Ansprechpartner für die IBM Cloud-Infrastruktur (SoftLayer). 
- Entscheiden Sie sich zwischen einem [kostenlosen Cluster und einem Standardcluster](cs_why.html#cluster_types). Mit dem kostenlosen Cluster können Sie die Kubernetes-Features für eine begrenzte Anzahl von Tagen auszuprobieren. Erstellen Sie einen Standardcluster, um weitere Vorteile nutzen zu können und die Clusterleistung besser steuern zu können. 
- Wenn Sie einen Standardcluster erstellen, können Sie [die Kosten mit dem Preisrechner![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link") ](https://console.bluemix.net/pricing/configure/iaas/containers-kubernetes) schätzen. **Hinweis**: Sie müssen für jeden Cluster ein **dediziertes Netz (1 Teilnetz mit 8 portierbaren öffentlichen IPs)** zu Ihrer Schätzung hinzufügen. Außerdem variieren die Kosten für die Bandbreite für abgehende Netze je nach Nutzung und stellen eine zusätzliche Gebühr dar, die über die Gebühren im Preisrechner hinausgeht.

Gehen Sie wie folgt vor, um einen Cluster zu erstellen:

1.  Melden Sie sich an der {{site.data.keyword.Bluemix_notm}}-CLI an.

    1.  Melden Sie sich an und geben Sie Ihre {{site.data.keyword.Bluemix_notm}}-Berechtigungsnachweise ein, wenn Sie dazu aufgefordert werden.

        ```
        ibmcloud login
        ```
        {: pre}

        **Hinweis:** Falls Sie über eine eingebundene ID verfügen, geben Sie `ibmcloud login --sso` ein, um sich an der Befehlszeilenschnittstelle von {{site.data.keyword.Bluemix_notm}} anzumelden. Geben Sie Ihren Benutzernamen ein und verwenden Sie die bereitgestellte URL in Ihrer CLI-Ausgabe, um Ihren einmaligen Kenncode abzurufen. Bei Verwendung einer eingebundenen ID schlägt die Anmeldung ohne die Option `--sso` fehl, mit der Option `--sso` ist sie erfolgreich.

    2. Wenn Sie über mehrere {{site.data.keyword.Bluemix_notm}}-Konten verfügen, dann wählen Sie das Konto aus, unter dem Sie Ihren Kubernetes-Cluster erstellen wollen.

    3.  Wenn Sie Kubernetes-Cluster in einer anderen Region als der von Ihnen zuvor ausgewählten {{site.data.keyword.Bluemix_notm}}-Region erstellen oder auf diese Cluster zugreifen möchten, führen Sie `ibmcloud ks region-set` aus.

3.  Erstellen Sie einen Cluster. **Hinweis**: Standardcluster können in jeder Region und jeder verfügbaren Zone erstellt werden. Kostenlose Cluster können nicht in den Regionen 'Vereinigte Staaten (Osten)' oder 'Asien-Pazifik (Norden)' und den entsprechenden Zonen erstellt werden und Sie können die Zone nicht auswählen.

    1.  **Standardcluster**: Überprüfen Sie, welche Zonen verfügbar sind. Welche Zonen angezeigt werden, hängt von der {{site.data.keyword.containerlong_notm}}-Region ab, bei der Sie angemeldet sind.

        **Hinweis**: Damit sich Ihr Cluster über Zonen erstreckt, müssen Sie den Cluster in einer [mehrzonenfähigen Zone](cs_regions.html#zones) erstellen.

        ```
        ibmcloud ks zones
        ```
        {: pre}

    2.  **Standardcluster**: Wählen Sie eine Zone aus und prüfen Sie, welche Maschinentypen in dieser Zone verfügbar sind. Der Maschinentyp gibt an, welche virtuellen oder physischen Rechenhosts jedem Workerknoten zur Verfügung stehen.

        -  Zeigen Sie das Feld **Servertyp** an, um zwischen virtuellen oder physischen Maschinen (Bare-Metal-Maschinen) auszuwählen.
        -  **Virtuell**: Die Abrechnung erfolgt stündlich. Virtuelle Maschinen werden auf gemeinsam genutzter oder dedizierter Hardware bereitgestellt.
        -  **Physisch**: Die Abrechnung erfolgt monatlich. Bare-Metal-Server werden durch manuelle Interaktion mit der IBM Cloud-Infrastruktur (SoftLayer) bereitgestellt, daher kann die Ausführung mehr als einen Arbeitstag dauern. Bare-Metal-Server eignen sich am besten für Hochleistungsanwendungen, die mehr Ressourcen und Hoststeuerung erfordern.
        - **Physische Maschinen mit Trusted Compute**: Für Bare-Metal-Cluster, auf denen Kubernetes Version 1.9 oder höher ausgeführt wird, können Sie auch auswählen, dass [Trusted Compute](cs_secure.html#trusted_compute) aktiviert wird, um Ihre Bare-Metal-Workerknoten auf Manipulation zu überprüfen. Trusted Compute ist für ausgewählte Bare-Metal-Maschinentypen verfügbar. Beispielsweise unterstützen die GPU-Typen `mgXc` Trusted Compute nicht. Wenn Sie Trusted Compute während der Clustererstellung nicht aktivieren, dies jedoch später nachholen möchten, können Sie den [Befehl](cs_cli_reference.html#cs_cluster_feature_enable) `ibmcloud ks feature-enable` verwenden. Nachdem Sie Trusted Compute aktiviert haben, können Sie es später nicht mehr inaktivieren.
        -  **Maschinentypen**: Um zu entscheiden, welcher Maschinentyp implementiert werden soll, überprüfen Sie die Kombination aus Kern, Hauptspeicher und Speicher der [verfügbaren Hardware für Workerknoten](cs_clusters_planning.html#shared_dedicated_node). Nachdem Sie den Cluster erstellt haben, können Sie verschiedene physische oder virtuelle Maschinentypen hinzufügen, indem Sie [einen Worker-Pool hinzufügen](#add_pool).

           Stellen Sie sicher, dass Sie eine Bare-Metal-Maschine bereitstellen wollen. Da die Abrechnung monatlich erfolgt, wird Ihnen ein voller Monat auch dann berechnet, wenn Sie versehentlich bestellen und sofort danach Ihre Bestellung wieder stornieren.
           {:tip}

        ```
        ibmcloud ks machine-types <zone>
        ```
        {: pre}

    3.  **Standardcluster**: Prüfen Sie, ob in der IBM Cloud-Infrastruktur (SoftLayer) bereits ein öffentliches und ein privates VLAN für dieses Konto vorhanden ist.

        ```
        ibmcloud ks vlans <zone>
        ```
        {: pre}

        ```
        ID        Name                Number   Type      Router  
        1519999   vlan   1355     private   bcr02a.dal10  
        1519898   vlan   1357     private   bcr02a.dal10 
        1518787   vlan   1252     public   fcr02a.dal10 
        1518888   vlan   1254     public    fcr02a.dal10
        ```
        {: screen}

        Falls bereits ein öffentliches oder privates VLAN vorhanden ist, notieren Sie sich die passenden Router. Private VLAN-Router beginnen immer mit <code>bcr</code> (Back-End-Router) und öffentliche VLAN-Router immer mit <code>fcr</code> (Front-End-Router). Wenn Sie einen Cluster erstellen und die öffentlichen und privaten VLANs angeben, müssen die Zahlen- und Buchstabenkombinationen nach diesen Präfixen übereinstimmen. In der Beispielausgabe können alle privaten VLANs mit allen öffentlichen VLANs verwendet werden, weil alle Router `02a.dal10` enthalten.

        Sie müssen Ihre Workerknoten mit einem privaten VLAN verbinden und können sie optional auch mit einem öffentliches VLAN verbinden. **Hinweis**: Wenn Workerknoten nur mit einem privaten VLAN eingerichtet werden, müssen Sie eine alternative Lösung für die Netzkonnektivität konfigurieren. Weitere Informationen finden Sie unter [Ausschließlich private Clusternetze planen](cs_network_cluster.html#private_vlan). 

    4.  **Kostenlose und Standardcluster**: Führen Sie den Befehl `cluster-create` aus. Sie können einen kostenlosen Cluster wählen, der einen Workerknoten mit zwei virtuellen CPUs (vCPUs) und 4 GB Hauptspeicher umfasst und automatisch nach 30 Tagen gelöscht wird. Wenn Sie einen Standardcluster erstellen, werden die Platten der Workerknoten standardmäßig verschlüsselt, die zugehörige Hardware wird von mehreren IBM Kunden gemeinsam genutzt und es wird nach Nutzungsstunden abgerechnet. </br>Beispiel eines Standardclusters. Geben Sie die Optionen für den Cluster an:

        ```
        ibmcloud ks cluster-create --zone dal10 --machine-type b2c.4x16 --hardware <shared_oder_dedicated> --public-vlan <öffentliche_vlan-id> --private-vlan <private_vlan-id> --workers 3 --name <clustername> --kube-version <major.minor.patch> [--disable-disk-encrypt][--trusted]
        ```
        {: pre}

        Beispiel für einen kostenlosen Cluster. Geben Sie den Clusternamen an:

        ```
        ibmcloud ks cluster-create --name mein_cluster
        ```
        {: pre}

        <table>
        <caption>Komponenten von 'cluster-create'</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der Bestandteile dieses Befehls</th>
        </thead>
        <tbody>
        <tr>
        <td><code>cluster-create</code></td>
        <td>Der Befehl zum Erstellen eines Clusters in Ihrer {{site.data.keyword.Bluemix_notm}}-Organisation.</td>
        </tr>
        <tr>
        <td><code>--zone <em>&lt;zone&gt;</em></code></td>
        <td>**Standardcluster**: Ersetzen Sie <em>&lt;zone&gt;</em> durch die {{site.data.keyword.Bluemix_notm}}-Zonen-ID, für die Sie den Cluster erstellen möchten. Verfügbare Zonen hängen von der {{site.data.keyword.containerlong_notm}}-Region ab, bei der Sie angemeldet sind.<br></br>**Hinweis**: Die Cluster-Workerknoten werden in dieser Zone bereitgestellt. Damit sich Ihr Cluster über Zonen erstreckt, müssen Sie den Cluster in einer [mehrzonenfähigen Zone](cs_regions.html#zones) erstellen. Nachdem der Cluster erstellt wurde, können Sie [eine Zone zum Cluster hinzufügen](#add_zone).</td>
        </tr>
        <tr>
        <td><code>--machine-type <em>&lt;maschinentyp&gt;</em></code></td>
        <td>**Standardcluster**: Wählen Sie einen Maschinentyp aus. Sie können Ihre Workerknoten als virtuelle Maschinen auf gemeinsam genutzter oder dedizierter Hardware oder als physische Maschinen auf Bare-Metal-Systemen bereitstellen. Die Typen der verfügbaren physischen und virtuellen Maschinen variieren je nach der Zone, in der Sie den Cluster implementieren. Weitere Informationen finden Sie in der Dokumentation zum [Befehl `ibmcloud ks machine-type`](cs_cli_reference.html#cs_machine_types). Bei kostenlosen Clustern muss kein Maschinentyp definiert werden.</td>
        </tr>
        <tr>
        <td><code>--hardware <em>&lt;shared_oder_dedicated&gt;</em></code></td>
        <td>**Standardcluster, nur virtuell**: Die Stufe der Hardwareisolation für Ihren Workerknoten. Verwenden Sie 'dedicated', wenn Sie verfügbare physische Ressourcen haben möchten, die nur Sie nutzen können, oder 'shared', um zuzulassen, dass physische Ressourcen mit anderen IBM Kunden gemeinsam genutzt werden können. Die Standardeinstellung ist 'shared'. Dieser Wert ist für Standardcluster optional und steht für kostenlose Cluster nicht zur Verfügung.</td>
        </tr>
        <tr>
        <td><code>--public-vlan <em>&lt;öffentliche_vlan-id&gt;</em></code></td>
        <td><ul>
          <li>**Kostenlose Cluster**: Sie müssen kein öffentliches VLAN definieren. Ihr kostenloser Cluster wird automatisch mit einem öffentlichen VLAN von IBM verbunden.</li>
          <li>**Standardcluster**: Wenn für diese Zone bereits ein öffentliches VLAN in Ihrem IBM Cloud-Infrastrukturkonto (SoftLayer) eingerichtet ist, geben Sie die ID des öffentlichen VLAN ein. Wenn Sie Ihre Workerknoten nur mit einem private VLAN verbinden möchten, geben Sie diese Option nicht an. **Hinweis**: Wenn Workerknoten nur mit einem privaten VLAN eingerichtet werden, müssen Sie eine alternative Lösung für die Netzkonnektivität konfigurieren. Weitere Informationen finden Sie unter [Ausschließlich private Clusternetze planen](cs_network_cluster.html#private_vlan). <br/><br/>
          <strong>Hinweis</strong>: Private VLAN-Router beginnen immer mit <code>bcr</code> (Back-End-Router) und öffentliche VLAN-Router immer mit <code>fcr</code> (Front-End-Router). Wenn Sie einen Cluster erstellen und die öffentlichen und privaten VLANs angeben, müssen die Zahlen- und Buchstabenkombinationen nach diesen Präfixen übereinstimmen.</li>
        </ul></td>
        </tr>
        <tr>
        <td><code>--private-vlan <em>&lt;private_vlan-id&gt;</em></code></td>
        <td><ul><li>**Kostenlose Cluster**: Sie müssen kein privates VLAN definieren. Ihr kostenloser Cluster wird automatisch mit einem privaten VLAN von IBM verbunden.</li><li>**Standardcluster**: Wenn für diese Zone bereits ein privates VLAN in Ihrem IBM Cloud-Infrastrukturkonto (SoftLayer) eingerichtet ist, geben Sie die ID des privaten VLAN ein. Wenn Sie noch nicht über ein privates VLAN für dieses Konto verfügen, geben Sie diese Option nicht an. {{site.data.keyword.containerlong_notm}} erstellt automatisch ein privates VLAN für Sie.<br/><br/><strong>Hinweis</strong>: Private VLAN-Router beginnen immer mit <code>bcr</code> (Back-End-Router) und öffentliche VLAN-Router immer mit <code>fcr</code> (Front-End-Router). Wenn Sie einen Cluster erstellen und die öffentlichen und privaten VLANs angeben, müssen die Zahlen- und Buchstabenkombinationen nach diesen Präfixen übereinstimmen.</li></ul></td>
        </tr>
        <tr>
        <td><code>--name <em>&lt;name&gt;</em></code></td>
        <td>**Kostenlose und Standardcluster**: Ersetzen Sie <em>&lt;name&gt;</em> durch den Namen Ihres Clusters. Der Name muss mit einem Buchstaben beginnen, darf Buchstaben, Ziffern und den Bindestrich (-) enthalten und darf maximal 35 Zeichen lang sein. Der vollständig qualifizierte Domänenname für die Ingress-Unterdomäne setzt sich aus dem Clusternamen und der Region zusammen, in der der Cluster bereitgestellt wird. Um sicherzustellen, dass die Ingress-Unterdomäne innerhalb einer Region eindeutig ist, wird der Clustername möglicherweise abgeschnitten und es wird ein beliebiger Wert innerhalb des Ingress-Domänennamens angehängt.
</td>
        </tr>
        <tr>
        <td><code>--workers <em>&lt;anzahl&gt;</em></code></td>
        <td>**Standardcluster**: Die Anzahl der Workerknoten, die im Cluster eingebunden werden sollen. Wird die Option <code>--workers</code> nicht angegeben, wird 1 Workerknoten erstellt.</td>
        </tr>
        <tr>
          <td><code>--kube-version <em>&lt;major.minor.patch&gt;</em></code></td>
          <td>**Standardcluster**: Die Kubernetes-Version für den Cluster-Masterknoten. Dieser Wert ist optional. Wenn die Version nicht angegeben ist, wird der Cluster mit dem Standard für unterstützte Kubernetes-Versionen erstellt. Führen Sie den Befehl <code>ibmcloud ks kube-versions</code> aus, um die verfügbaren Versionen anzuzeigen.
</td>
        </tr>
        <tr>
        <td><code>--disable-disk-encrypt</code></td>
        <td>**Kostenloser und Standardcluster**: Workerknoten weisen standardmäßig Verschlüsselung auf: [Weitere Informationen finden Sie hier](cs_secure.html#encrypted_disk). Wenn Sie die Verschlüsselung inaktivieren möchten, schließen Sie diese Option ein.</td>
        </tr>
        <tr>
        <td><code>--trusted</code></td>
        <td>**Standard-Bare-Metal-Cluster**: Aktivieren Sie [Trusted Compute](cs_secure.html#trusted_compute), um Ihre Bare-Metal-Workerknoten auf Manipulation zu überprüfen. Trusted Compute ist für ausgewählte Bare-Metal-Maschinentypen verfügbar. Beispielsweise unterstützen die GPU-Typen `mgXc` Trusted Compute nicht. Wenn Sie Trusted Compute während der Clustererstellung nicht aktivieren, dies jedoch später nachholen möchten, können Sie den [Befehl](cs_cli_reference.html#cs_cluster_feature_enable) `ibmcloud ks feature-enable` verwenden. Nachdem Sie Trusted Compute aktiviert haben, können Sie es später nicht mehr inaktivieren.</td>
        </tr>
        </tbody></table>

4.  Prüfen Sie, ob die Erstellung des Clusters angefordert wurde.

    ```
    ibmcloud ks clusters
    ```
    {: pre}

    **Hinweis:** Bei virtuellen Maschinen kann es einige Minuten dauern, bis die Workerknotenmaschinen angewiesen werden und der Cluster in Ihrem Konto eingerichtet und bereitgestellt wird. Physische Bare-Metal-Maschinen werden durch einen manuelle Interaktion mit der IBM Cloud-Infrastruktur (SoftLayer) bereitgestellt, daher kann die Ausführung mehr als einen Arbeitstag dauern.

    Nach Abschluss der Bereitstellung Ihres Clusters wird der Status des Clusters in **deployed** (bereitgestellt) geändert.

    ```
    Name         ID                                   State      Created          Workers   Zone   Version
    my_cluster   paf97e8843e29941b49c598f516de72101   deployed   20170201162433   1         mil01      1.10.7
    ```
    {: screen}

5.  Überprüfen Sie den Status der Workerknoten.

    ```
    ibmcloud ks workers <clustername_oder_-id>
    ```
    {: pre}

    Wenn die Workerknoten bereit sind, wechselt der Zustand (State) zu **Normal**, während für den Status die Angabe **Bereit** angezeigt wird. Wenn der Knotenstatus **Bereit** lautet, können Sie auf den Cluster zugreifen.

    **Hinweis:** Jedem Workerknoten werden eine eindeutige Workerknoten-ID und ein Domänenname zugewiesen, die nach der Erstellung des Clusters nicht manuell geändert werden dürfen. Wenn die ID oder der Domänenname geändert wird, kann der Kubernetes-Master Ihren Cluster nicht mehr verwalten.

    ```
    ID                                                 Public IP       Private IP      Machine Type   State    Status   Zone   Version
    kube-mil01-paf97e8843e29941b49c598f516de72101-w1   169.xx.xxx.xxx  10.xxx.xx.xxx   free           normal   Ready    mil01      1.10.7
    ```
    {: screen}

6.  Legen Sie den von Ihnen erstellten Cluster als Kontext für diese Sitzung fest. Führen Sie diese Konfigurationsschritte jedes Mal aus, wenn Sie mit Ihrem Cluster arbeiten.
    1.  Ermitteln Sie den Befehl zum Festlegen der Umgebungsvariablen und laden Sie die Kubernetes-Konfigurationsdateien herunter.

        ```
        ibmcloud ks cluster-config <clustername_oder_-id>
        ```
        {: pre}

        Wenn der Download der Konfigurationsdateien abgeschlossen ist, wird ein Befehl angezeigt, den Sie verwenden können, um den Pfad zu der lokalen Kubernetes-Konfigurationsdatei als Umgebungsvariable festzulegen.

        Beispiel für OS X:

        ```
        export KUBECONFIG=/Users/<benutzername>/.bluemix/plugins/container-service/clusters/mycluster/kube-config-prod-dal10-mycluster.yml
        ```
        {: screen}

    2.  Kopieren Sie den Befehl, der in Ihrem Terminal angezeigt wird, um die Umgebungsvariable `KUBECONFIG` festzulegen.
    3.  Stellen Sie sicher, dass die Umgebungsvariable `KUBECONFIG` richtig eingestellt ist.

        Beispiel für OS X:

        ```
        echo $KUBECONFIG
        ```
        {: pre}

        Ausgabe:

        ```
        /Users/<benutzername>/.bluemix/plugins/container-service/clusters/mycluster/kube-config-prod-dal10-mycluster.yml

        ```
        {: screen}

7.  Starten Sie Ihr Kubernetes-Dashboard über den Standardport `8001`.
    1.  Legen Sie die Standardportnummer für den Proxy fest.

        ```
        kubectl proxy
        ```
        {: pre}

        ```
        Starting to serve on 127.0.0.1:8001
        ```
        {: screen}

    2.  Öffnen Sie die folgende URL in einem Web-Browser, um das Kubernetes-Dashboard anzuzeigen:

        ```
        http://localhost:8001/ui
        ```
        {: codeblock}


**Womit möchten Sie fortfahren? **

-   Verteilen Sie Workerknoten über mehrere Zonen hinweg, indem Sie [eine Zone zu Ihrem Cluster hinzufügen](#add_zone).
-   [Stellen Sie eine App in Ihrem Cluster bereit.](cs_app.html#app_cli)
-   [Verwalten Sie Ihren Cluster über die Befehlszeile `kubectl`. ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/reference/kubectl/overview/)
-   [Richten Sie Ihre eigene private Registry in {{site.data.keyword.Bluemix_notm}} ein, um Docker-Images zu speichern und gemeinsam mit anderen Benutzern zu verwenden.](/docs/services/Registry/index.html)
- Wenn Sie über eine Firewall verfügen, müssen Sie unter Umständen [die erforderlichen Ports öffnen](cs_firewall.html#firewall), um `ibmcloud`-, `kubectl`- oder `calicotl`-Befehle zu verwenden, um abgehenden Datenverkehr von Ihrem Cluster zu ermöglichen oder um eingehenden Datenverkehr für Netzservices zuzulassen.
-  Cluster mit Kubernetes Version 1.10 oder höher: Steuern Sie mit [Pod-Sicherheitsrichtlinien](cs_psp.html), wer Pods in Ihrem Cluster erstellen kann.

<br />



## Workerknoten und Zonen zu Clustern hinzufügen
{: #add_workers}

Wenn Sie die Verfügbarkeit Ihrer Apps erhöhen möchten, können Sie Workerknoten zu einer vorhandenen Zone oder mehreren vorhandenen Zonen in Ihrem Cluster hinzufügen. Um Ihre Apps vor Zonenausfällen zu schützen, können Sie Zonen zu Ihrem Cluster hinzufügen.
{:shortdesc}

Wenn Sie einen Cluster erstellen, werden die Workerknoten in einem Worker-Pool bereitgestellt. Nach der Clustererstellung können Sie weitere Workerknoten zu einem Pool hinzufügen, indem Sie die Größe ändern oder weitere Worker-Pools hinzufügen. Der Worker-Pool ist standardmäßig in einer Zone vorhanden. Cluster, die über einen Worker-Pool in nur einer Zone verfügen, werden als Einzelzonencluster bezeichnet. Wenn Sie dem Cluster weitere Zonen hinzufügen, ist der Worker-Pool zonenübergreifend vorhanden. Cluster, die über einen Worker-Pool verfügen, der über mehrere Zonen verteilt ist, werden als Mehrzonencluster bezeichnet.

Wenn Sie über einen Mehrzonencluster verfügen, müssen seine Workerknotenressourcen ausgeglichen sein. Stellen Sie sicher, dass alle Worker-Pools über dieselben Zonen verteilt sind und fügen Sie Worker hinzu oder entfernen Sie sie, indem Sie die Größe der Pools ändern, anstatt einzelne Knoten hinzuzufügen.
{: tip}

In den folgenden Abschnitten erfahren Sie, wie Sie:
  * [Workerknoten durch Ändern der Größe eines vorhandenen Worker-Pools in Ihrem Cluster hinzufügen](#resize_pool)
  * [Workerknoten durch Hinzufügen eines Worker-Pools zu Ihrem Cluster hinzufügen](#add_pool)
  * [Eine Zone zu Ihrem Cluster hinzufügen und die Workerknoten in den Worker-Pools über mehrere Zonen replizieren](#add_zone)
  * [Einen eigenständigen Workerknoten zu einem Cluster hinzufügen (veraltet)](#standalone)


### Workerknoten durch Ändern der Größe eines vorhandenen Worker-Pools hinzufügen
{: #resize_pool}

Sie können die Anzahl der Workerknoten in Ihrem Cluster erhöhen oder verringern, indem Sie die Größe eines vorhandenen Worker-Pools ändern, unabhängig davon, ob sich der Worker-Pool in einer Zone befindet oder über mehrere Zonen verteilt ist.
{: shortdesc}

Angenommen, Sie verfügen über einen Cluster mit einem Worker-Pool, der drei Workerknoten pro Zone aufweist.
* Wenn es sich bei dem Cluster um einen Einzelzonencluster handelt und er sich in `dal10` befindet, dann verfügt der Worker-Pool über drei Workerknoten in `dal10`. Der Cluster verfügt über insgesamt drei Workerknoten.
* Wenn es sich bei dem Cluster um einen Mehrzonencluster handelt und er sich in `dal10` und `dal12` befindet, dann verfügt der Worker-Pool über drei Workerknoten in `dal10` und drei Workerknoten in `dal12`. Der Cluster verfügt über insgesamt sechs Workerknoten.

Bei Bare-Metal-Worker-Pools sollten Sie beachten, dass die Rechnungsstellung monatlich erfolgt. Je nachdem, wie Sie die Größe eines Pools verändern, wirkt sich dies auf die Kosten für den Monat aus.
{: tip}

Ändern Sie die Anzahl der Workerknoten, die der Worker-Pool in jeder Zone bereitstellt, um die Größe des Worker-Pools zu ändern:

1. Rufen Sie den Namen des Worker-Pools ab, dessen Größe Sie ändern möchten.
    ```
    ibmcloud ks worker-pools --cluster <clustername_oder_-id>
    ```
    {: pre}

2. Ändern Sie die Größe des Worker-Pools, indem Sie die Anzahl der Workerknoten angeben, die Sie in jeder Zone bereitstellen möchten. Der Mindestwert ist '1'.
    ```
    ibmcloud ks worker-pool-resize --cluster <clustername_oder_-id> --worker-pool <poolname>  --size-per-zone <anzahl_der_worker_pro_zone>
    ```
    {: pre}

3. Stellen Sie sicher, dass die Größe des Worker-Pools geändert wurde.
    ```
    ibmcloud ks workers <clustername_oder_-id> --worker-pool <poolname>
    ```
    {: pre}

    Beispielausgabe für einen Worker-Pool, der sich in zwei Zonen (`dal10` und `dal12`) befindet und dessen Größe auf zwei Workerknoten pro Zone geändert wird:
    ```
    ID                                                 Public IP        Private IP      Machine Type      State    Status  Zone    Version
    kube-dal10-crb20b637238ea471f8d4a8b881aae4962-w7   169.xx.xxx.xxx   10.xxx.xx.xxx   b2c.4x16          normal   Ready   dal10   1.8.6_1504
    kube-dal10-crb20b637238ea471f8d4a8b881aae4962-w8   169.xx.xxx.xxx   10.xxx.xx.xxx   b2c.4x16          normal   Ready   dal10   1.8.6_1504
    kube-dal12-crb20b637238ea471f8d4a8b881aae4962-w9   169.xx.xxx.xxx   10.xxx.xx.xxx   b2c.4x16          normal   Ready   dal12   1.8.6_1504
    kube-dal12-crb20b637238ea471f8d4a8b881aae4962-w10  169.xx.xxx.xxx   10.xxx.xx.xxx   b2c.4x16          normal   Ready   dal12   1.8.6_1504
    ```
    {: screen}

### Workerknoten durch Erstellen eines neuen Worker-Pools hinzufügen
{: #add_pool}

Sie können Workerknoten zu Ihrem Cluster hinzufügen, indem Sie einen neuen Worker-Pool erstellen.
{:shortdesc}

1. Listen Sie die verfügbaren Zonen auf und wählen Sie die Zone aus, in der die Workerknoten in Ihrem Worker-Pool bereitgestellt werden sollen. Wenn Sie die Workerknoten auf mehrere Zonen verteilen möchten, wählen Sie eine [mehrzonenfähige Zone](cs_regions.html#zones) aus.
   ```
   ibmcloud ks zones
   ```
   {: pre}

2. Listen Sie für jede Zone private und öffentliche VLANs auf. Notieren Sie sich das private und das öffentliche VLAN, das Sie verwenden möchten. Wenn Sie nicht über ein privates oder ein öffentliches VLAN verfügen, wird das VLAN automatisch für Sie erstellt, wenn Sie eine Zone zu Ihrem Worker-Pool hinzufügen.
   ```
   ibmcloud ks vlans <zone>
   ```
   {: pre}

3. Erstellen Sie einen Worker-Pool. Informationen zu den Optionen für Maschinentypen finden Sie in der Dokumentation zum [Befehl `machine-types`](cs_cli_reference.html#cs_machine_types).
   ```
   ibmcloud ks worker-pool-create --name <poolname> --cluster <clustername_oder_-id> --machine-type <maschinentyp> --size-per-zone <anzahl_der_worker_pro_zone>
   ```
   {: pre}

4. Stellen Sie sicher, dass der Worker-Pool erstellt wird.
   ```
   ibmcloud ks worker-pools --cluster <clustername_oder_-id>
   ```
   {: pre}

5. Standardmäßig wird durch das Hinzufügen eines Worker-Pools ein Pool ohne Zonen erstellt. Um Workerknoten in einer Zone bereitzustellen, müssen Sie Zonen zum Worker-Pool hinzufügen. Wenn Sie die Workerknoten auf mehrere Zonen verteilen möchten, wiederholen Sie diesen Befehl mit einer anderen mehrzonenfähigen Zone.  
   ```
   ibmcloud ks zone-add --zone <zone> --cluster <clustername_oder_-id> --worker-pools <poolname> --private-vlan <private_vlan-id> --public-vlan <public_vlan-id>
   ```
   {: pre}

6. Stellen Sie sicher, dass die Workerknoten in der Zone bereitgestellt werden, die Sie hinzugefügt haben.
   ```
   ibmcloud ks workers <clustername_oder_-id> --worker-pool <poolname>
   ```
   {: pre}

   Beispielausgabe:
   ```
   ID                                                 Public IP        Private IP      Machine Type      State    Status  Zone    Version
   kube-dal10-crb20b637238ea471f8d4a8b881aae4962-w7   169.xx.xxx.xxx   10.xxx.xx.xxx   b2c.4x16          normal   Ready   dal10   1.8.6_1504
   kube-dal10-crb20b637238ea471f8d4a8b881aae4962-w8   169.xx.xxx.xxx   10.xxx.xx.xxx   b2c.4x16          normal   Ready   dal10   1.8.6_1504
   ```
   {: screen}

### Workerknoten durch Hinzufügen einer Zone zu einem Worker-Pool hinzufügen
{: #add_zone}

Sie können Ihren Cluster über mehrere Zonen in einer Region verteilen, indem Sie eine Zone zu dem vorhandenen Worker-Pool hinzufügen.
{:shortdesc}

Wenn Sie eine Zone zu einem Worker-Pool hinzufügen, werden die in Ihrem Worker-Pool definierten Workerknoten in der neuen Zone bereitgestellt und für die zukünftige Planung von Arbeitslasten berücksichtigt. {{site.data.keyword.containerlong_notm}} fügt automatisch die Bezeichnung `failure-domain.beta.kubernetes.io/region` für die Region und die Bezeichnung `failure-domain.beta.kubernetes.io/zone` für die Zone für jeden Workerknoten hinzu. Der Kubernetes-Scheduler verwendet diese Bezeichnungen, um Pods auf Zonen innerhalb derselben Region zu verteilen.

**Hinweis**: Wenn Sie über mehrere Worker-Pools in Ihrem Cluster verfügen, fügen Sie die Zone zu allen Pools hinzu, sodass die Workerknoten gleichmäßig über den Cluster hinweg verteilt sind.

Vorbemerkungen:
*  Wenn Sie eine Zone zu Ihrem Worker-Pool hinzufügen möchten, muss sich Ihr Worker-Pool in einer [mehrzonenfähigen Zone](cs_regions.html#zones) befinden. Wenn sich der Worker-Pool nicht in einer solchen Zone befindet, sollten Sie [einen neuen Worker-Pool erstellen](#add_pool).
*  Wenn Sie über mehrere VLANs für einen Cluster, mehrere Teilnetze in demselben VLAN oder einen Cluster mit mehreren Zonen verfügen, müssen Sie [VLAN-Spanning](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) für Ihr Konto für die IBM Cloud-Infrastruktur (SoftLayer) aktivieren, damit die Workerknoten in dem privaten Netz miteinander kommunizieren können. Um diese Aktion durchführen zu können, müssen Sie über die [Infrastrukturberechtigung](cs_users.html#infra_access) **Netz > VLAN-Spanning im Netz verwalten** verfügen oder Sie können den Kontoeigner bitte, diese zu aktivieren. Um zu prüfen, ob das VLAN-Spanning bereits aktiviert ist, verwenden Sie den [Befehl](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`. Wenn Sie {{site.data.keyword.BluDirectLink}} verwenden, müssen Sie stattdessen eine [ VRF-Funktion (Virtual Router Function)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf) verwenden. Um VRF zu aktivieren, wenden Sie sich an Ihren Ansprechpartner für die IBM Cloud-Infrastruktur (SoftLayer). 

Gehen Sie wie folgt vor, um eine Zone mit Workerknoten zum Worker-Pool hinzuzufügen:

1. Listen Sie die verfügbaren Zonen auf und wählen Sie die Zone aus, die Sie Ihrem Worker-Pool hinzufügen möchten. Die Zone, die Sie auswählen, muss eine mehrzonenfähige Zone sein.
   ```
   ibmcloud ks zones
   ```
   {: pre}

2. Listen Sie die verfügbaren VLANs in dieser Zone auf. Wenn Sie nicht über ein privates oder ein öffentliches VLAN verfügen, wird das VLAN automatisch für Sie erstellt, wenn Sie eine Zone zu Ihrem Worker-Pool hinzufügen.
   ```
   ibmcloud ks vlans <zone>
   ```
   {: pre}

3. Listen Sie die Worker-Pools in Ihrem Cluster auf und notieren Sie deren Namen.
   ```
   ibmcloud ks worker-pools --cluster <clustername_oder_-id>
   ```
   {: pre}

4. Fügen Sie die Zone zu Ihrem Worker-Pool hinzu. Wenn Sie mehrere Worker-Pools haben, fügen Sie die Zone allen Worker-Pools hinzu, sodass Ihr Cluster in allen Zonen ausgeglichen ist. Ersetzen Sie `<pool1_id_or_name,pool2_id_or_name,...>` mit den Namen aller Worker-Pools in einer durch Kommas getrennten Liste. </br>**Hinweis:** Es muss ein privates und ein öffentliches VLAN vorhanden sein, bevor Sie eine Zone zu mehreren Worker-Pools hinzufügen können. Wenn Sie nicht über ein privates und ein öffentliches VLAN in dieser Zone verfügen, fügen Sie zuerst die Zone zu einem Worker-Pool hinzu, sodass ein privates und ein öffentliches VLAN für Sie erstellt wird. Anschließend können Sie die Zone zu anderen Worker-Pools hinzufügen, indem Sie das private und das öffentliche VLAN angeben, das für Sie erstellt wurde.

   Wenn Sie verschiedene VLANs für unterschiedliche Worker-Pools verwenden möchten, wiederholen Sie diesen Befehl für jedes VLAN und die entsprechenden Worker-Pools. Alle neuen Workerknoten werden den von Ihnen angegebenen VLANs hinzugefügt, die VLANs für alle vorhandenen Workerknoten werden jedoch nicht geändert.
   {: tip}
   ```
   ibmcloud ks zone-add --zone <zone> --cluster <clustername_oder_-id> --worker-pools <pool1-name,pool2-name,...> --private-vlan <private_vlan-id> --public-vlan <öffentliche_vlan-id>
   ```
   {: pre}

5. Überprüfen Sie, ob die Zone Ihrem Cluster hinzugefügt wurde. Suchen Sie die hinzugefügte Zone im Feld für die **Workerzonen** der Ausgabe. Beachten Sie, dass die Gesamtanzahl der Worker im Feld für die **Worker** sich erhöht hat, da neue Workerknoten in der hinzugefügten Zone bereitgestellt werden.
    ```
    ibmcloud ks cluster-get <clustername_oder_-id>
    ```
    {: pre}

    Beispielausgabe:
    ```
    Name:               mycluster
    ID:                 a20a637238aa471f8d4a8b881aaa4988
    State:              normal
    Created:            2018-04-19T01:49:22+0000
    Master zone:    us-south
    Worker zones:       dal10,dal12
    Master URL:         https://169.xx.xxx.xxx:21111
    Ingress subdomain:  ...
    Ingress secret:     ...
    Workers:            6
    Version:            1.8.6_1504
    ```
    {: screen}  

### Veraltet: Eigenständige Workerknoten hinzufügen
{: #standalone}

Wenn Sie über einen Cluster verfügen, der vor der Einführung von Worker-Pools erstellt wurde, können Sie die veralteten Befehle verwenden, um eigenständige Workerknoten hinzuzufügen.
{: shortdesc}

**Hinweis:** Wenn Sie über einen Cluster verfügen, der nach der Einführung von Worker-Pools erstellt wurde, können Sie keine eigenständigen Workerknoten hinzufügen. Stattdessen können Sie [einen Worker-Pool erstellen](#add_pool), [die Größe eines vorhandenen Worker-Pools ändern](#resize_pool) oder [eine Zone zu einem Worker-Pool hinzufügen](#add_zone), um Workerknoten zu Ihrem Cluster hinzuzufügen.

1. Listen Sie die verfügbaren Zonen auf und wählen Sie die Zone aus, in der Sie Workerknoten hinzufügen möchten.
   ```
   ibmcloud ks zones
   ```
   {: pre}

2. Listen Sie die verfügbaren VLANs in dieser Zone auf und notieren Sie ihre ID.
   ```
   ibmcloud ks vlans <zone>
   ```
   {: pre}

3. Listen Sie die verfügbaren Maschinentypen in der Zone auf.
   ```
   ibmcloud ks machine-types <zone>
   ```
   {: pre}

4. Fügen Sie eigenständige Workerknoten zum Cluster hinzu.
   ```
   ibmcloud ks worker-add --cluster <clustername_oder_-id> --number <anzahl_der_workerknoten> --public-vlan <öffentliche_vlan-id> --private-vlan <private_vlan-id> --machine-type <maschinentyp> --hardware <shared_oder_dedicated>
   ```
   {: pre}

5. Stellen Sie sicher, dass die Workerknoten erstellt werden.
   ```
   ibmcloud ks workers <clustername_oder_-id>
   ```
   {: pre}



## Clusterstatus anzeigen
{: #states}

Überprüfen Sie den Status eines Kubernetes-Clusters, um Informationen zur Verfügbarkeit und Kapazität des Clusters sowie zu möglichen Problemen, die aufgetreten sein können, zu erhalten.
{:shortdesc}

Wenn Sie Informationen zu einem bestimmten Cluster anzeigen möchten, z. B. Zonen, Master-URL, Ingress-Unterdomäne, Version, Eigner und Überwachungsdashboard, verwenden Sie den [Befehl `ibmcloud ks cluster-get <cluster_name_or_ID>`](cs_cli_reference.html#cs_cluster_get). Schließen Sie das Flag `--showResources` ein, um weitere Clusterressourcen, wie z. B. Add-ons für Speicherpods oder Teilnetz-VLANs für öffentliche und private IPs anzuzeigen.

Sie können den aktuellen Clusterstatus anzeigen, indem Sie den Befehl `ibmcloud ks clusters` ausführen. Der Status wird im entsprechenden **Statusfeld** angezeigt. Informationen zum Beheben von Fehlern bei Clustern und Workerknoten finden Sie im Abschnitt [Fehlerbehebung bei Clustern](cs_troubleshoot.html#debug_clusters).

<table summary="Jede Tabellenzeile sollte von links nach rechts gelesen werden, wobei der Clusterstatus in der ersten Spalte und eine Beschreibung in der zweiten Spalte angegeben ist.">
<caption>Clusterstatus</caption>
   <thead>
   <th>Clusterstatus</th>
   <th>Beschreibung</th>
   </thead>
   <tbody>
<tr>
   <td>Aborted (Abgebrochen)</td>
   <td>Das Löschen des Clusters wird vom Benutzer angefordert, bevor der Kubernetes Master bereitgestellt ist. Nachdem das Löschen des Clusters abgeschlossen ist, wird der Cluster aus dem Dashboard entfernt. Wenn Ihr Cluster in diesem Status lange Zeit blockiert ist, öffnen Sie ein [{{site.data.keyword.Bluemix_notm}}-Support-Ticket](cs_troubleshoot.html#ts_getting_help).</td>
   </tr>
 <tr>
     <td>Critical (Kritisch)</td>
     <td>Der Kubernetes-Master kann nicht erreicht werden oder alle Workerknoten in dem Cluster sind inaktiv. </td>
    </tr>
   <tr>
     <td>Delete failed (Löschen fehlgeschlagen)</td>
     <td>Der Kubernetes Masterknoten oder mindestens ein Workerknoten kann nicht gelöscht werden.  </td>
   </tr>
   <tr>
     <td>Deleted (Gelöscht)</td>
     <td>Der Cluster wird gelöscht, aber noch nicht aus dem Dashboard entfernt. Wenn Ihr Cluster in diesem Status lange Zeit blockiert ist, öffnen Sie ein [{{site.data.keyword.Bluemix_notm}}-Support-Ticket](cs_troubleshoot.html#ts_getting_help). </td>
   </tr>
   <tr>
   <td>Deleting (Löschen)</td>
   <td>Der Cluster wird gelöscht, und die Clusterinfrastruktur wird abgebaut. Der Zugriff auf den Cluster ist nicht möglich.  </td>
   </tr>
   <tr>
     <td>Deploy failed (Bereitstellung fehlgeschlagen)</td>
     <td>Die Bereitstellung des Kubernetes-Masters konnte nicht abgeschlossen werden. Sie können diesen Status nicht auflösen. Wenden Sie sich an den Support für IBM Cloud, indem Sie ein [{{site.data.keyword.Bluemix_notm}}-Support-Ticket](cs_troubleshoot.html#ts_getting_help) öffnen.</td>
   </tr>
     <tr>
       <td>Deploying (Wird bereitgestellt)</td>
       <td>Der Kubernetes-Master ist noch nicht vollständig implementiert. Sie können auf Ihren Cluster nicht zugreifen. Warten Sie, bis Ihr Cluster vollständig bereitgestellt wurde, und überprüfen Sie dann den Status Ihres Clusters.</td>
      </tr>
      <tr>
       <td>Normal</td>
       <td>Alle Workerknoten in einem Cluster sind betriebsbereit. Sie können auf den Cluster zugreifen und Apps auf dem Cluster bereitstellen. Dieser Status wird als einwandfreier Zustand betrachtet und erfordert keine Aktion von Ihnen. **Hinweis**: Auch wenn die Workerknoten ordnungsgemäß funktionieren, bedürfen andere Infrastrukturressourcen wie [Netz](cs_troubleshoot_network.html) und [Speicher](cs_troubleshoot_storage.html) möglicherweise Ihrer Aufmerksamkeit.</td>
    </tr>
      <tr>
       <td>Pending (Anstehend)</td>
       <td>Der Kubernetes-Master ist bereitgestellt. Die Workerknoten werden gerade eingerichtet und sind noch nicht im Cluster verfügbar. Sie können auf den Cluster zugreifen, aber Sie können keine Apps auf dem Cluster bereitstellen.  </td>
     </tr>
   <tr>
     <td>Requested (Angefordert)</td>
     <td>Eine Anforderung zum Erstellen des Clusters und zum Bestellen der Infrastruktur für die Kubernetes Master- und Workerknoten wird gesendet. Wenn die Bereitstellung des Clusters gestartet wird, ändert sich der Clusterstatus in <code>Deploying</code> (Wird bereitgestellt). Wenn Ihr Cluster lange Zeit im Status <code>Requested</code> (Angefordert) blockiert ist, öffnen Sie ein [{{site.data.keyword.Bluemix_notm}}-Support-Ticket](cs_troubleshoot.html#ts_getting_help). </td>
   </tr>
   <tr>
     <td>Updating (Aktualisierung)</td>
     <td>Der Kubernetes API-Server, der in Ihrem Kubernetes-Master ausgeführt wird, wird auf eine neue Version der Kubernetes-API aktualisiert. Während der Aktualisierung können Sie weder auf den Cluster zugreifen noch Änderungen am Cluster vornehmen. Workerknoten, Apps und Ressourcen, die vom Benutzer bereitgestellt wurden, werden nicht geändert und weiterhin ausgeführt. Warten Sie, bis die Aktualisierung abgeschlossen ist, und überprüfen Sie dann den Status Ihres Clusters. </td>
   </tr>
    <tr>
       <td>Warning (Warnung)</td>
       <td>Mindestens ein Workerknoten in dem Cluster ist nicht verfügbar, aber andere Workerknoten sind verfügbar und können die Workload übernehmen. </td>
    </tr>
   </tbody>
 </table>


<br />


## Cluster entfernen
{: #remove}

Kostenlose Cluster und Standardcluster, die mit einem nutzungsabhängigen Konto erstellt wurden, müssen manuell entfernt werden, wenn sie nicht mehr benötigt werden, damit sie nicht länger Ressourcen verbrauchen.
{:shortdesc}

**Warnung:**
  - In Ihrem persistenten Speicher werden keine Sicherungen Ihres Clusters oder Ihrer Daten erstellt. Das Löschen des Clusters oder persistenten Speichers kann nicht rückgängig gemacht werden.
  - Wenn Sie einen Cluster entfernen, entfernen Sie auch alle Teilnetze, die automatisch bereitgestellt wurden, als Sie den Cluster erstellt haben, und solche, die Sie mithilfe des Befehls `ibmcloud ks cluster-subnet-create` erstellt haben. Wenn Sie jedoch vorhandene Teilnetze manuell mithilfe des Befehls `ibmcloud ks cluster-subnet-add command` zu Ihrem Cluster hinzugefügt haben, werden diese Teilnetze nicht aus Ihrem IBM Cloud-Infrastrukturkonto (SoftLayer) entfernt und können in anderen Clustern wiederverwendet werden.

Vorbemerkungen:
* Notieren Sie sich Ihre Cluster-ID. Möglicherweise benötigen Sie die Cluster-ID, um zugehörige Ressourcen der IBM Cloud-Infrastruktur (SoftLayer) zu untersuchen und zu entfernen, die nicht automatisch mit Ihrem Cluster gelöscht werden.
* Wenn Sie die Daten in Ihrem persistenten Speicher löschen möchten, [sollten Sie mit den Löschoptionen vertraut sein](cs_storage_remove.html#cleanup).

Gehen Sie wie folgt vor, um einen Cluster zu entfernen:

-   Vorgehensweise bei Verwendung der {{site.data.keyword.Bluemix_notm}}-GUI:
    1.  Wählen Sie Ihren Cluster aus und klicken Sie im Menü **Weitere Aktionen...** auf **Löschen**.

-   Vorgehensweise bei Verwendung der {{site.data.keyword.Bluemix_notm}}-CLI:
    1.  Listen Sie die verfügbaren Cluster auf.

        ```
        ibmcloud ks clusters
        ```
        {: pre}

    2.  Löschen Sie den Cluster.

        ```
        ibmcloud ks cluster-rm <clustername_oder_-id>
        ```
        {: pre}

    3.  Befolgen Sie die Eingabeaufforderungen und wählen Sie aus, ob Clusterressourcen, darunter Container, Pods, gebundene Services, persistenter Speicher und geheime Schlüssel, gelöscht werden sollen.
      - **Persistenter Speicher**: Persistenter Speicher stellt Hochverfügbarkeit für Ihre Daten bereit. Wenn Sie mithilfe einer [vorhandenen Dateifreigabe](cs_storage_file.html#existing_file) einen Persistent Volume Claim (PVC) erstellt haben, dann können Sie beim Löschen des Clusters die Dateifreigabe nicht löschen. Sie müssen die Dateifreigabe zu einem späteren Zeitpunkt manuell aus Ihrem Portfolio der IBM Cloud-Infrastruktur (SoftLayer) löschen.

          **Hinweis**: Bedingt durch den monatlichen Abrechnungszyklus kann ein Persistent Volume Claim (PVC) nicht am letzten Tag des Monats gelöscht werden. Wenn Sie den Persistent Volume Claim am letzten Tag des Monats entfernen, verbleibt die Löschung bis zum Beginn des nächsten Monats in einem anstehenden Zustand.

Nächste Schritte:
- Nachdem ein Cluster nicht länger in der Liste verfügbarer Cluster enthalten ist, wenn Sie den Befehl `ibmcloud ks clusters` ausführen, können Sie den Namen eines entfernten Clusters wiederverwenden.
- Wenn Sie die Teilnetze behalten, können Sie [sie in einem neuen Cluster wiederverwenden](cs_subnets.html#custom) oder manuell zu einem späteren Zeitpunkt aus dem Portfolio der IBM Cloud-Infrastruktur (SoftLayer) löschen.
- Wenn Sie den persistenten Speicher beibehalten haben, können Sie den [Speicher](cs_storage_remove.html#cleanup) später über das Dashboard der IBM Cloud-Infrastruktur (SoftLayer) in der {{site.data.keyword.Bluemix_notm}}-GUI löschen.
