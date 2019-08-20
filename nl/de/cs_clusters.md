---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

keywords: kubernetes, iks, clusters, worker nodes, worker pools, delete

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
{:gif: data-image-type='gif'}



# Cluster erstellen
{: #clusters}

Erstellen Sie einen Kubernetes-Cluster in {{site.data.keyword.containerlong}}.
{: shortdesc}

Machen Sie sich noch mit der Anwendung vertraut? Sehen Sie sich dazu das [Lernprogramm zum Erstellen von Kubernetes-Clustern](/docs/containers?topic=containers-cs_cluster_tutorial#cs_cluster_tutorial) an. Sie sind nicht sicher, welches Cluster-Setup Sie wählen sollen? Informationen dazu finden Sie unter [Einrichtung Ihres Clusternetzes planen](/docs/containers?topic=containers-plan_clusters).
{: tip}

Haben Sie zuvor einen Cluster erstellt und suchen Sie nur schnell nach Beispielbefehlen? Versuchen Sie es mit diesen Beispielen.
*  **Kostenloser Cluster:**
   ```
   ibmcloud ks cluster-create --name mein_cluster
   ```
   {: pre}
*  **Standardcluster, gemeinsam genutzte virtuelle Maschine:**
   ```
   ibmcloud ks cluster-create --name mein_cluster --zone dal10 --machine-type b3c.4x16 --hardware shared --workers 3 --public-vlan <öffentliche_vlan-id> --private-vlan <private_vlan-id>
   ```
   {: pre}
*  **Standardcluster, Bare-Metal-Maschine**:
   ```
   ibmcloud ks cluster-create --name mein_cluster --zone dal10 --machine-type mb2c.4x32 --hardware dedicated --workers 3 --public-vlan <öffentliche_vlan-id> --private-vlan <private_vlan-id>
   ```
   {: pre}
*  **Standardcluster, virtuelle Maschine mit öffentlichem und privatem Serviceendpunkt in VRF-aktiviertem Konto**:
   ```
   ibmcloud ks cluster-create --name mein_cluster --zone dal10 --machine-type b3c.4x16 --hardware shared --workers 3 --public-service-endpoint --private-service-endpoint --public-vlan <öffentliche_vlan-id> --private-vlan <private_vlan-id>
   ```
   {: pre}
*  **Standardcluster, bei dem nur private VLANs und der private Serviceendpunkt verwendet werden**:
   ```
   ibmcloud ks cluster-create --name mein_cluster --zone dal10 --machine-type b3c.4x16 --hardware shared --workers 3 --private-service-endpoint --private-vlan <private_vlan-id> --private-only
   ```
   {: pre}
*   **Für einen Mehrzonencluster müssen Sie nach dem Erstellen des Clusters in einer [Metropole mit mehreren Zonen](/docs/containers?topic=containers-regions-and-zones#zones) die entsprechenden [Zonen hinzufügen](/docs/containers?topic=containers-add_workers#add_zone)**:
    ```
    ibmcloud ks zone-add --zone <zone> --cluster <clustername_oder_-id> --worker-pools <pool1-name,pool2-name,...> --private-vlan <private_vlan-id> --public-vlan <öffentliche_vlan-id>
    ```
    {: pre}

<br />



## Erstellung von Clustern auf Kontoebene vorbereiten
{: #cluster_prepare}

Bereiten Sie Ihr {{site.data.keyword.cloud_notm}}-Konto für {{site.data.keyword.containerlong_notm}} vor. Hierbei handelt es sich um Vorbereitungen, deren Änderung nach der Ausführung durch den Kontoadministrator nicht bei jeder Erstellung eines Clusters erforderlich ist. Es kann jedoch vorkommen, dass Sie bei jeder Erstellung eines Clusters überprüfen möchten, ob der aktuelle Status der Kontoebene dem gewünschten Status entspricht.
{: shortdesc}

1. [Erstellen Sie ein belastbares Konto oder führen Sie für Ihr Konto ein Upgrade auf ein belastbares Konto durch ({{site.data.keyword.cloud_notm}}nutzungsabhängig oder Abonnement)](https://cloud.ibm.com/registration/).

2. [Konfigurieren Sie einen {{site.data.keyword.containerlong_notm}}-API-Schlüssel](/docs/containers?topic=containers-users#api_key) in den Regionen, in denen Sie Cluster erstellen möchten. Ordnen Sie den API-Schlüssel den entsprechenden Berechtigungen zum Erstellen von Clustern hinzu:
  * Die Rolle **Superuser** oder die [mindestens erforderlichen Berechtigungen](/docs/containers?topic=containers-access_reference#infra) für die klassische Infrastruktur.
  * Die Plattformmanagementrolle **Administrator** für {{site.data.keyword.containershort_notm}} auf Kontoebene.
  * Die Plattformmanagementrolle **Administrator** für Container Registry auf Kontoebene. Wenn Ihr Konto vor dem 4. Oktober 2018 erstellt wurde, müssen Sie [{{site.data.keyword.cloud_notm}} IAM-Richtlinien für {{site.data.keyword.registryshort_notm}} aktivieren](/docs/services/Registry?topic=registry-user#existing_users). Mit IAM-Richtlinien können Sie den Zugriff auf Ressourcen wie Registry-Namensbereiche steuern.

  Sind Sie der Kontoeigner? Sie verfügen bereits über die erforderlichen Berechtigungen. Wenn Sie einen Cluster erstellen, wird der API-Schlüssel für diese Region und Ressourcengruppe mit den Berechtigungsnachweisen festgelegt.
  {: tip}

3. Stellen Sie sicher, dass Sie über die Plattformrolle **Administrator** für {{site.data.keyword.containerlong_notm}} verfügen. Damit Ihr Cluster Images aus der privaten Registry extrahieren kann, benötigen Sie auch die **Administrator**-Plattformrolle für {{site.data.keyword.registrylong_notm}}.
  1. Klicken Sie in der Menüleiste der [{{site.data.keyword.cloud_notm}}-Konsole ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cloud.ibm.com/) auf **Verwalten > Zugriff (IAM)**.
  2. Klicken Sie auf die Seite **Benutzer** und anschließend in der Tabelle auf Ihren eigenen Benutzernamen.
  3. Bestätigen Sie in der Registerkarte **Zugriffsrichtlinien**, dass Ihre **Rolle** **Administrator** ist. Sie können **Administrator** für alle Ressourcen im Konto oder zumindest für {{site.data.keyword.containershort_notm}} sein. **Hinweis:** Falls Sie über die Rolle **Administrator** für {{site.data.keyword.containershort_notm}} nur in einer Ressourcengruppe oder Region und nicht im gesamten Konto verfügen, müssen Sie mindestens auf Kontoebene über die Rolle **Anzeigeberechtigter** verfügen, um die VLANs des Kontos anzeigen zu können.
  <p class="tip">Stellen Sie sicher, dass Ihr Kontoadministrator Ihnen die **Administrator**-Plattformrolle nicht zur gleichen Zeit wie eine Servicerolle zugewiesen hat. Sie müssen Plattform- und Servicerollen separat zuweisen.</p>

4. Wenn vom Konto mehrere Ressourcengruppen verwendet werden, ermitteln Sie die Strategie Ihres Kontos für die [Verwaltung von Ressourcengruppen](/docs/containers?topic=containers-users#resource_groups).
  * Der Cluster wird in der Ressourcengruppe erstellt, die Sie während der Anmeldung an {{site.data.keyword.cloud_notm}} als Ziel angeben. Wenn Sie keine Ressourcengruppe als Ziel angeben, wird automatisch die Standardressourcengruppe als Ziel verwendet.
  * Wenn Sie einen Cluster in einer anderen Ressourcengruppe als der Standardressourcengruppe erstellen möchten, benötigen Sie mindestens die Rolle **Anzeigeberechtigter** für die Ressourcengruppe. Falls Sie über keine Rolle für die Ressourcengruppe verfügen, aber ein **Administrator** für den Service in der Ressourcengruppe sind, wird der Cluster in der Standardressourcengruppe erstellt.
  * Die Ressourcengruppe eines Clusters kann nicht geändert werden. Wenn Sie außerdem den [Befehl](/docs/containers-cli-plugin?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_service_bind) `ibmcloud ks cluster-service-bind` verwenden müssen, um eine [Integration mit einem {{site.data.keyword.cloud_notm}}-Service durchzuführen](/docs/containers?topic=containers-service-binding#bind-services), muss sich dieser Service in derselben Ressourcengruppe befinden wie der Cluster. Services, die keine Ressourcengruppen verwenden, wie {{site.data.keyword.registrylong_notm}}, oder die keine Servicebindung benötigen, wie {{site.data.keyword.la_full_notm}}, funktionieren auch dann, wenn sich der Cluster in einer anderen Ressourcengruppe befindet.
  * Wenn Sie beabsichtigen, [{{site.data.keyword.monitoringlong_notm}} für Metriken](/docs/containers?topic=containers-health#view_metrics) zu verwenden, planen Sie, dem Cluster einen Namen zu geben, der in allen Ressourcengruppen und Regionen des Kontos eindeutig ist, um Konflikte bei Metriknamen zu vermeiden.
  * In der `Standardressourcengruppe` werden freie Cluster erstellt.

5. **Standardcluster**: Planen Sie die [Einrichtung Ihres Clusternetzes](/docs/containers?topic=containers-plan_clusters), damit Ihr Cluster den Bedarf Ihrer Workloads und Ihrer Umgebung erfüllt. Richten Sie dann Ihr IBM Cloud-Infrastrukturnetz ein, um die Worker-zu-Master- und Benutzer-zu-Master-Kommunikation zu ermöglichen:
  * Gehen Sie wie folgt vor, um nur den privaten Serviceendpunkt oder den öffentlichen und den privaten Serviceendpunkt zu verwenden (mit dem Internet verbundene Workloads ausführen oder lokales Rechenzentrum erweitern):
    1. Aktivieren Sie [VRF](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud) in Ihrem Konto für die IBM Cloud-Infrastruktur. Zum Prüfen, ob VRF bereits aktiviert ist, verwenden Sie den Befehl `ibmcloud account show`. 
    2. [Aktivieren Sie Ihr {{site.data.keyword.cloud_notm}}-Konto zur Verwendung von Serviceendpunkten](/docs/resources?topic=resources-private-network-endpoints#getting-started).
    <p class="note">Der Kubernetes-Master ist über den privaten Serviceendpunkt zugänglich, wenn berechtigte Clusterbenutzer sich in Ihrem privaten {{site.data.keyword.cloud_notm}}-Netz befinden oder über eine [VPN-Verbindung](/docs/infrastructure/iaas-vpn?topic=VPN-getting-started) oder [{{site.data.keyword.cloud_notm}} Direct Link](/docs/infrastructure/direct-link?topic=direct-link-get-started-with-ibm-cloud-direct-link) mit dem privaten Netz verbunden sind. Die Kommunikation mit dem Kubernetes-Master über den privaten Serviceendpunkt muss jedoch über den IP-Adressbereich <code>166.X.X</code> erfolgen, der über eine VPN-Verbindung oder über {{site.data.keyword.cloud_notm}} Direct Link nicht angesteuert werden kann. Sie können den privaten Serviceendpunkt des Masters für Ihre Clusterbenutzer mithilfe einer privaten Netzlastausgleichsfunktion (NLB) zugänglich machen. Die private NLB macht den privaten Serviceendpunkt des Masters als internen <code>10.X.X.X</code>-IP-Adressbereich zugänglich, auf den Benutzer über eine VPN- oder {{site.data.keyword.cloud_notm}} Direct Link-Verbindung zugreifen können. Wenn Sie nur den privaten Serviceendpunkt aktivieren, können Sie das Kubernetes-Dashboard verwenden oder vorübergehend den öffentlichen Serviceendpunkt aktivieren, um die private NLB zu erstellen. Weitere Informationen finden Sie unter [Über den privaten Serviceendpunkt auf Cluster zugreifen](/docs/containers?topic=containers-clusters#access_on_prem).</p>

  * Gehen Sie wie folgt vor, um nur den öffentlichen Serviceendpunkt zu verwenden (mit dem Internet verbundene Workloads ausführen):
    1. Aktivieren Sie [VLAN-Spanning](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning) für Ihr IBM Cloud-Infrastrukturkonto, damit die Workerknoten in dem privaten Netz miteinander kommunizieren können. Um diese Aktion durchführen zu können, müssen Sie über die [Infrastrukturberechtigung](/docs/containers?topic=containers-users#infra_access) **Netz > VLAN-Spanning im Netz verwalten** verfügen oder Sie können den Kontoeigner bitten, diese zu aktivieren. Zum Prüfen, ob das VLAN-Spanning bereits aktiviert ist, verwenden Sie den [Befehl](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get --region <region>`.
  * Gehen Sie wie folgt vor, um eine Gateway-Einheit zu verwenden (lokales Rechenzentrum erweitern):
    1. Aktivieren Sie [VLAN-Spanning](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning) für Ihr IBM Cloud-Infrastrukturkonto, damit die Workerknoten in dem privaten Netz miteinander kommunizieren können. Um diese Aktion durchführen zu können, müssen Sie über die [Infrastrukturberechtigung](/docs/containers?topic=containers-users#infra_access) **Netz > VLAN-Spanning im Netz verwalten** verfügen oder Sie können den Kontoeigner bitten, diese zu aktivieren. Zum Prüfen, ob das VLAN-Spanning bereits aktiviert ist, verwenden Sie den [Befehl](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get --region <region>`.
    2. Konfigurieren Sie eine Gateway-Einheit. Sie können beispielsweise [Virtual Router Appliance](/docs/infrastructure/virtual-router-appliance?topic=virtual-router-appliance-about-the-vra) oder [Fortigate Security Appliance](/docs/services/vmwaresolutions/services?topic=vmware-solutions-fsa_considerations) als Firewall und zum Zulassen des benötigten Datenverkehrs und zum Blockieren des unerwünschten Datenverkehrs einrichten.
    3. [Öffnen Sie die erforderlichen privaten IP-Adressen und Ports](/docs/containers?topic=containers-firewall#firewall_outbound) für die einzelnen Regionen, damit der Master und die Workerknoten kommunizieren können, und für die {{site.data.keyword.cloud_notm}}-Services, die Sie verwenden wollen.

<br />


## Erstellung von Clustern auf Clusterebene vorbereiten
{: #prepare_cluster_level}

Nachdem Sie Ihr Konto zum Erstellen von Clustern eingerichtet haben, bereiten Sie die Einrichtung Ihres Clusters vor. Hierbei handelt es sich um Vorbereitungen, die sich bei jeder Erstellung eines Clusters auf Ihren Cluster auswirken.
{: shortdesc}

1. Entscheiden Sie sich zwischen einem [kostenlosen Cluster und einem Standardcluster](/docs/containers?topic=containers-cs_ov#cluster_types). Sie können einen kostenlosen Cluster erstellen, um 30 Tage lang einige der Leistungsmerkmale zu testen. Oder Sie können umfassend anpassbare Standardcluster mit Ihrer gewünschten Hardware-Isolation erstellen. Erstellen Sie einen Standardcluster, um weitere Vorteile nutzen zu können und die Clusterleistung besser steuern zu können.

2. Planen Sie das Cluster-Setup für Standardcluster.
  * Entscheiden Sie, ob ein Cluster aus einer [einzelnen Zone](/docs/containers?topic=containers-ha_clusters#single_zone) oder aus [mehreren Zonen](/docs/containers?topic=containers-ha_clusters#multizone) erstellt werden soll. Beachten Sie, dass Cluster aus mehreren Zonen nur an ausgewählten Standorten verfügbar sind.
  * Wählen Sie den Typ der [Hardware und Isolation](/docs/containers?topic=containers-planning_worker_nodes#planning_worker_nodes) aus, den Sie für die Workerknoten des Clusters verwenden möchten; entscheiden Sie hierbei auch, ob virtuelle Maschinen oder Bare-Metal-Maschinen verwendet werden sollen.

3. Für Standardcluster können Sie in der {{site.data.keyword.cloud_notm}}-Konsole [die Kosten schätzen](/docs/billing-usage?topic=billing-usage-cost#cost). Weitere Informationen zu Gebühren, die möglicherweise nicht in den Schätzungen berücksichtigt werden, finden Sie unter [Preisstruktur und Abrechnung](/docs/containers?topic=containers-faqs#charges).

4. Wenn Sie den Cluster in einer Umgebung hinter einer Firewall erstellen, wie z. B. bei Clustern, die Ihr lokales Rechenzentrum erweitern, [lassen Sie ausgehenden Netzverkehr an die öffentlichen und privaten IP-Adressen](/docs/containers?topic=containers-firewall#firewall_outbound) für die {{site.data.keyword.cloud_notm}}-Services zu, deren Einsatz Sie planen.

<br />


## Kostenlosen Cluster erstellen
{: #clusters_free}

Sie können sich mit Ihrem kostenlosen Cluster mit der Funktionsweise von {{site.data.keyword.containerlong_notm}} vertraut machen. Mit kostenlosen Clustern können Sie die Terminologie kennenlernen, das Lernprogramm ausführen und sich mit der Anwendung vertraut machen, bevor Sie den Sprung zu Standardclustern auf Produktebene wagen. Auch bei einem belastbaren Konto erhalten Sie einen kostenlosen Cluster.
{: shortdesc}

Kostenlose Cluster umfassen einen Workerknoten mit zwei virtuellen CPUs (vCPUs) und vier GB Hauptspeicher und haben eine Lebensdauer von 30 Tagen. Nach Ablauf dieser Zeit verfällt der Cluster und der Cluster und seine Daten werden gelöscht. Die gelöschten Daten werden nicht von {{site.data.keyword.cloud_notm}} gesichert und können nicht wiederhergestellt werden. Stellen Sie sicher, dass alle wichtigen Daten gesichert werden.
{: note}

### Kostenlosen Cluster in der Konsole erstellen
{: #clusters_ui_free}

1. Wählen Sie im [Katalog ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cloud.ibm.com/catalog?category=containers) den Eintrag **{{site.data.keyword.containershort_notm}}** aus, um ein Cluster zu erstellen.
2. Wählen Sie den **kostenlosen** Clusterplan aus.
3. Wählen Sie eine Region aus, in der der Cluster bereitgestellt werden soll.
4. Wählen Sie einen Metropolenstandort in der Geografie aus. Ihr Cluster wird in einer Zone innerhalb dieser Metropole erstellt.
5. Geben Sie Ihrem Cluster einen Namen. Der Name muss mit einem Buchstaben beginnen, darf Buchstaben, Ziffern und den Bindestrich (-) enthalten und darf maximal 35 Zeichen lang sein. Verwenden Sie einen Namen, der in allen Regionen eindeutig ist.
6. Klicken Sie auf **Cluster einrichten**. Standardmäßig wird ein Worker-Pool mit einem Workerknoten erstellt. Auf der Registerkarte **Workerknoten** können Sie den Fortschritt der Bereitstellung des Workerknotens überprüfen. Nach Abschluss der Bereitstellung können Sie auf der Registerkarte **Übersicht** sehen, dass Ihr Cluster bereit ist. Beachten Sie, dass selbst bei Bereitschaft des Clusters einige seiner Teile, die von anderen Services, wie z. B. geheimen Schlüsseln für Registry-Image-Pull-Operationen, verwendet werden, möglicherweise noch in Verarbeitung sind.

  Jedem Workerknoten werden eine eindeutige Workerknoten-ID und ein Domänenname zugewiesen, die nach dem Erstellen des Clusters nicht manuell geändert werden dürfen. Wenn die ID oder der Domänenname geändert wird, kann der Kubernetes-Master Ihren Cluster nicht mehr verwalten.
  {: important}
7. Nach der Erstellung des Clusters können [Sie anfangen, mit Ihrem Cluster zu arbeiten, indem Sie Ihre CLI-Sitzung konfigurieren](#access_internet).

### Kostenlosen Cluster in der CLI erstellen
{: #clusters_cli_free}

Installieren Sie zunächst die {{site.data.keyword.cloud_notm}}-CLI und das [{{site.data.keyword.containerlong_notm}}-Plug-in](/docs/containers?topic=containers-cs_cli_install#cs_cli_install).

1. Melden Sie sich an der {{site.data.keyword.cloud_notm}}-CLI an.
  1. Melden Sie sich an und geben Sie Ihre {{site.data.keyword.cloud_notm}}-Berechtigungsnachweise ein, wenn Sie dazu aufgefordert werden.
     ```
     ibmcloud login
     ```
     {: pre}

     Falls Sie über eine föderierte ID verfügen, geben Sie `ibmcloud login --sso` ein, um sich an der Befehlszeilenschnittstelle von {{site.data.keyword.cloud_notm}} anzumelden. Geben Sie Ihren Benutzernamen ein und verwenden Sie die bereitgestellte URL in Ihrer CLI-Ausgabe, um Ihren einmaligen Kenncode abzurufen. Bei Verwendung einer föderierten ID schlägt die Anmeldung ohne die Option `--sso` fehl, mit der Option `--sso` ist sie erfolgreich.
     {: tip}

  2. Wenn Sie über mehrere {{site.data.keyword.cloud_notm}}-Konten verfügen, dann wählen Sie das Konto aus, unter dem Sie Ihren Kubernetes-Cluster erstellen wollen.

  3. Zum Erstellen eines kostenlosen Clusters in einer bestimmten Region müssen Sie diese Region als Ziel festlegen. Sie können einen kostenlosen Cluster in `ap-south`, `eu-central`, `uk-south` oder `us-south` erstellen. Der Cluster wird in einer Zone innerhalb dieser Region erstellt.
     ```
     ibmcloud ks region-set
     ```
     {: pre}

2. Erstellen Sie einen Cluster.
  ```
  ibmcloud ks cluster-create --name mein_cluster
  ```
  {: pre}

3. **Freie Cluster nur in der Metropole London**: Sie müssen aktuell die regionale API 'Zentraleuropa' als Ziel festlegen, um mit Ihrem Cluster arbeiten zu können.
  ```
  ibmcloud ks init --host https://eu-gb.containers.cloud.ibm.com
  ```
  {: pre}

3. Prüfen Sie, ob die Erstellung des Clusters angefordert wurde. Es kann einige Minuten dauern, bis die Workerknotenmaschine angewiesen wird.
    ```
    ibmcloud ks clusters
    ```
    {: pre}

    Nach Abschluss der Bereitstellung Ihres Clusters wird der Status des Clusters in **deployed** (Bereitgestellt) geändert.
    ```
    Name         ID                                   State      Created          Workers   Zone       Version     Resource Group Name
    my_cluster   paf97e8843e29941b49c598f516de72101   deployed   20170201162433   1         mil01      1.13.8      Default
    ```
    {: screen}

4. Überprüfen Sie den Status des Workerknotens.
    ```
    ibmcloud ks workers --cluster <clustername_oder_-id>
    ```
    {: pre}

    Wenn der Workerknoten bereit ist, wechselt der Zustand (State) zu **normal**, während für den Status die Angabe **Ready** (Bereit) angezeigt wird. Wenn der Knotenstatus **Ready** (bereit) lautet, können Sie auf den Cluster zugreifen. Beachten Sie, dass selbst bei Bereitschaft des Clusters einige seiner Teile, die von anderen Services wie den geheimen Ingress-Schlüsseln oder geheimen Schlüsseln für Registry-Image-Pull-Operationen verwendet werden, möglicherweise noch in Verarbeitung sind.
    ```
    ID                                                 Public IP       Private IP      Machine Type   State    Status   Zone        Version     Resource Group Name
    kube-mil01-paf97e8843e29941b49c598f516de72101-w1   169.xx.xxx.xxx  10.xxx.xx.xxx   free           normal   Ready    mil01       1.13.8      Default
    ```
    {: screen}

    Jedem Workerknoten werden eine eindeutige Workerknoten-ID und ein Domänenname zugewiesen, die nach dem Erstellen des Clusters nicht manuell geändert werden dürfen. Wenn die ID oder der Domänenname geändert wird, kann der Kubernetes-Master Ihren Cluster nicht mehr verwalten.
    {: important}

5. Nach der Erstellung des Clusters können [Sie anfangen, mit Ihrem Cluster zu arbeiten, indem Sie Ihre CLI-Sitzung konfigurieren](#access_internet).

<br />


## Standardcluster erstellen
{: #clusters_standard}

Verwenden Sie die {{site.data.keyword.cloud_notm}}-CLI oder die {{site.data.keyword.cloud_notm}}-Konsole zum Erstellen eines vollständig anpassbaren Standardclusters mit Ihrer Auswahl an Hardware-Isolation und Zugriff auf Features wie beispielsweise mehrere Workerknoten für eine hoch verfügbare Umgebung.
{: shortdesc}

### Standardcluster in der Konsole erstellen
{: #clusters_ui}

1. Wählen Sie im [Katalog ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cloud.ibm.com/catalog?category=containers) den Eintrag **{{site.data.keyword.containershort_notm}}** aus, um ein Cluster zu erstellen.

2. Wählen Sie eine Ressourcengruppe aus, in der der Cluster erstellt werden soll.
    * Ein Cluster kann nur in einer Ressourcengruppe erstellt werden; nach der Erstellung des Clusters kann seine Ressourcengruppe nicht geändert werden.
    * Wenn Sie Cluster in einer anderen Ressourcengruppe als der Standardressourcengruppe erstellen möchten, müssen Sie mindestens über die [Rolle **Anzeigeberechtigter**](/docs/containers?topic=containers-users#platform) für die Ressourcengruppe verfügen.

3. Wählen Sie eine Region aus, in der der Cluster bereitgestellt werden soll.

4. Geben Sie dem Cluster einen eindeutigen Namen. Der Name muss mit einem Buchstaben beginnen, darf Buchstaben, Ziffern und den Bindestrich (-) enthalten und darf maximal 35 Zeichen lang sein. Verwenden Sie einen Namen, der in allen Regionen eindeutig ist. Der vollständig qualifizierte Domänenname für die Ingress-Unterdomäne setzt sich aus dem Clusternamen und der Region zusammen, in der der Cluster bereitgestellt wird. Um sicherzustellen, dass die Ingress-Unterdomäne innerhalb einer Region eindeutig ist, wird der Clustername möglicherweise abgeschnitten und es wird ein beliebiger Wert innerhalb des Ingress-Domänennamens angehängt.
 **Hinweis**: Wenn die eindeutige ID oder der Domänenname geändert wird, die/der während der Erstellung zugeordnet wird, kann der Kubernetes-Master Ihren Cluster nicht mehr verwalten.

5. Wählen Sie für die Verfügbarkeit die Option für **Einzelzonencluster** oder **Mehrzonencluster** aus. In einem Mehrzonencluster wird der Masterknoten in einer auf mehrere Zonen ausgelegten Zone bereitgestellt und die Ressourcen Ihres Clusters werden auf mehrere Zonen verteilt.

6. Geben Sie Ihre Metropolen- und Zonendetails ein.
  * Mehrzonencluster:
    1. Wählen Sie einen Metropolenstandort aus. Wählen Sie den Metropolenstandort aus, der Ihrem Standort am nächsten ist, um eine optimale Leistung zu erhalten. Ihre Auswahl kann durch die Region begrenzt werden.
    2. Wählen Sie die Zonen aus, in denen der Cluster als Host für den Cluster verwendet werden soll. Sie müssen mindestens eine Zone auswählen, können jedoch so viele Zonen auswählen, wie Sie möchten. Wenn Sie mehr als eine Zone auswählen, werden die Workerknoten auf die Zonen verteilt, die Sie auswählen, wodurch eine höhere Verfügbarkeit erzielt werden kann. Wenn Sie nur eine Zone auswählen, [fügen Sie Zonen zu Ihrem Cluster hinzu](/docs/containers?topic=containers-add_workers#add_zone), nachdem dieser erstellt wurde.
  * Einzelzonencluster: Wählen eine Zone aus, in der Ihr Cluster gehostet werden soll. Wählen Sie die Zone aus, die Ihrem Standort am nächsten ist, um eine optimale Leistung zu erhalten. Ihre Auswahl kann durch die Region begrenzt werden.

7. Wählen Sie für jede Zone VLANs aus.
  * Gehen Sie wie folgt vor, um einen Cluster zu erstellen, in dem Sie mit dem Internet verbundene Workloads ausführen können:
    1. Wählen Sie für jede Zone ein öffentliches VLAN und ein privates VLAN in Ihrem IBM Cloud-Infrastrukturkonto aus. Workerknoten kommunizieren miteinander über das private VLAN und mit dem Kubernetes-Master über das öffentliche oder das private VLAN. Wenn in dieser Zone kein öffentliches oder privates VLAN vorhanden ist, werden ein öffentliches und ein privates VLAN automatisch für Sie erstellt. Sie können dasselbe VLAN für mehrere Cluster verwenden.
  * Gehen Sie wie folgt vor, um einen Cluster zu erstellen, der Ihr lokales Rechenzentrum nur im privaten Netz erweitert, Ihr lokales Rechenzentrum mit der Option zum späteren Hinzufügen von begrenztem öffentlichen Zugriff erweitert oder Ihr lokales Rechenzentrum erweitert und begrenzten öffentlichen Zugriff über eine Gateway-Einheit bereitstellt:
    1. Wählen Sie für jede Zone ein privates VLAN in Ihrem IBM Cloud-Infrastrukturkonto aus. Workerknoten kommunizieren miteinander, indem sie das private VLAN verwenden. Wenn in einer Zone kein privates VLAN vorhanden ist, wird ein privates VLAN automatisch für Sie erstellt. Sie können dasselbe VLAN für mehrere Cluster verwenden.
    2. Wählen Sie für das öffentliche VLAN **None** aus.

8. Wählen Sie für den **Master-Serviceendpunkt** aus, wie Ihr Kubernetes-Master und Ihre Workerknoten kommunizieren.
  * Gehen Sie wie folgt vor, um einen Cluster zu erstellen, in dem Sie mit dem Internet verbundene Workloads ausführen können:
    * Wenn VRF und Serviceendpunkte in Ihrem {{site.data.keyword.cloud_notm}}-Konto aktiviert sind, wählen Sie **private und öffentliche Endpunkte** aus.
    * Wenn Sie VRF nicht aktivieren können oder wollen, wählen Sie **Nur öffentlicher Endpunkt** aus.
  * Wählen Sie **private und öffentliche Endpunkte** oder **Nur privater Endpunkt** aus, um einen Cluster zu erstellen, der nur Ihr lokales Rechenzentrum erweitert, oder um einen Cluster zu erstellen, der Ihr lokales Rechenzentrum erweitert und begrenzten öffentlichen Zugriff mit Edge-Workerknoten bereitstellt. Stellen Sie sicher, dass Sie VRF und Serviceendpunkte in Ihrem {{site.data.keyword.cloud_notm}}-Konto aktiviert haben. Beachten Sie, dass Sie [den Master-Endpunkt über eine private Netzlastausgleichsfunktion zugänglich machen müssen](#access_on_prem), damit Benutzer über eine VPN- oder {{site.data.keyword.BluDirectLink}}-Verbindung auf den Master zugreifen können, wenn Sie nur den privaten Serviceendpunkt aktivieren.
  * Wählen Sie **Nur öffentlicher Endpunkt** aus, um einen Cluster zu erstellen, der Ihr lokales Rechenzentrum erweitert und begrenzten öffentlichen Zugriff mit einer Gateway-Einheit bereitstellt.

9. Konfigurieren Sie Ihren Standard-Worker-Pool. Worker-Pools sind Gruppen von Workerknoten, die dieselbe Konfiguration aufweisen. Sie können auch noch zu einem späteren Zeitpunkt weitere Worker-Pools hinzufügen.
  1. Wählen Sie die Kubernetes-API-Serverversion für den Cluster-Masterknoten und die Workerknoten aus.
  2. Filtern Sie die Workertypen durch Auswahl eines Maschinentyps. Virtuell wird auf Stundenbasis berechnet und Bare-Metal wird monatlich in Rechnung gestellt.
    - **Bare-Metal**: Bare-Metal-Server werden monatlich abgerechnet und nach Bestellung manuell von der IBM Cloud-Infrastruktur bereitgestellt, daher kann die Ausführung mehr als einen Geschäftstag dauern. Bare-Metal-Server eignen sich am besten für Hochleistungsanwendungen, die mehr Ressourcen und Hoststeuerung erfordern. Stellen Sie sicher, dass Sie eine Bare-Metal-Maschine bereitstellen wollen. Da die Abrechnung monatlich erfolgt, wird Ihnen ein voller Monat auch dann berechnet, wenn Sie versehentlich bestellen und sofort danach Ihre Bestellung wieder stornieren.
    - **Virtuell - Gemeinsam genutzt**: Infrastrukturressourcen wie der Hypervisor und physische Hardware werden von Ihnen und anderen IBM Kunden gemeinsam genutzt, aber jeder Workerknoten ist ausschließlich für Sie zugänglich. Obwohl diese Option in den meisten Fällen ausreicht und kostengünstiger ist, sollten Sie die Leistungs- und Infrastrukturanforderungen anhand der Richtlinien Ihres Unternehmens prüfen.
    - **Virtuell - Dediziert**: Ihre Workerknoten werden in einer Infrastruktur gehostet, die Ihrem Konto vorbehalten ist. Ihre physischen Ressourcen sind vollständig isoliert.
  3. Wählen Sie einen Typ aus. Der Typ definiert die Menge an virtueller CPU, Hauptspeicher und Festplattenspeicher, die in jedem Workerknoten eingerichtet wird und allen Containern zur Verfügung steht. Die verfügbaren Bare-Metal- und virtuellen Maschinentypen variieren je nach Zone, in der Sie den Cluster implementieren. Nachdem Sie Ihre Cluster erstellt haben, können Sie unterschiedliche Typen hinzufügen, indem Sie einen Worker oder Pool zum Cluster hinzufügen.
  4. Geben Sie die Anzahl der Workerknoten an, die Sie im Cluster benötigen. Die von Ihnen eingegebene Anzahl der Worker wird über die Anzahl der von Ihnen ausgewählten Zonen repliziert. Wenn Sie beispielsweise über zwei Zonen verfügen und drei Workerknoten auswählen, bedeutet das, dass sechs Knoten bereitgestellt werden und drei Knoten in jeder Zone vorhanden sind.

10. Klicken Sie auf **Cluster einrichten**. Ein Worker-Pool wird mit der Anzahl der Worker erstellt, die Sie angegeben haben. Auf der Registerkarte **Workerknoten** können Sie den Fortschritt der Bereitstellung des Workerknotens überprüfen.
    *   Nach Abschluss der Bereitstellung können Sie auf der Registerkarte **Übersicht** sehen, dass Ihr Cluster bereit ist. Beachten Sie, dass selbst bei Bereitschaft des Clusters einige seiner Teile, die von anderen Services wie den geheimen Ingress-Schlüsseln oder geheimen Schlüsseln für Registry-Image-Pull-Operationen verwendet werden, möglicherweise noch in Verarbeitung sind.
    *   Jedem Workerknoten werden eine eindeutige Workerknoten-ID und ein Domänenname zugewiesen, die nach dem Erstellen des Clusters nicht manuell geändert werden dürfen. Wenn die ID oder der Domänenname geändert wird, kann der Kubernetes-Master Ihren Cluster nicht mehr verwalten.<p class="tip">Ist Ihr Cluster nicht im Zustand **deployed** (bereitgestellt)? Informationen darüber, wie Sie den Status des Clusters überprüfen können, finden Sie unter [Cluster debuggen](/docs/containers?topic=containers-cs_troubleshoot). Wenn Ihr Cluster beispielsweise in einem Konto bereitgestellt wird, das durch eine Firewall-Gateway-Einheit geschützt ist, müssen Sie [Ihre Firewalleinstellungen so konfigurieren, dass sie ausgehenden Datenverkehr zu den entsprechenden Ports und IP-Adressen zulassen](/docs/containers?topic=containers-firewall#firewall_outbound).</p>

11. Nach der Erstellung des Clusters können [Sie anfangen, mit Ihrem Cluster zu arbeiten, indem Sie Ihre CLI-Sitzung konfigurieren](#access_cluster).

### Standardcluster in der CLI erstellen
{: #clusters_cli_steps}

Installieren Sie zunächst die {{site.data.keyword.cloud_notm}}-CLI und das [{{site.data.keyword.containerlong_notm}}-Plug-in](/docs/containers?topic=containers-cs_cli_install#cs_cli_install).

1. Melden Sie sich an der {{site.data.keyword.cloud_notm}}-CLI an.
  1. Melden Sie sich an und geben Sie Ihre {{site.data.keyword.cloud_notm}}-Berechtigungsnachweise ein, wenn Sie dazu aufgefordert werden.
     ```
     ibmcloud login
     ```
     {: pre}

     Falls Sie über eine föderierte ID verfügen, geben Sie `ibmcloud login --sso` ein, um sich an der Befehlszeilenschnittstelle von {{site.data.keyword.cloud_notm}} anzumelden. Geben Sie Ihren Benutzernamen ein und verwenden Sie die bereitgestellte URL in Ihrer CLI-Ausgabe, um Ihren einmaligen Kenncode abzurufen. Bei Verwendung einer föderierten ID schlägt die Anmeldung ohne die Option `--sso` fehl, mit der Option `--sso` ist sie erfolgreich.
     {: tip}

  2. Wenn Sie über mehrere {{site.data.keyword.cloud_notm}}-Konten verfügen, dann wählen Sie das Konto aus, unter dem Sie Ihren Kubernetes-Cluster erstellen wollen.

  3. Wenn Sie Cluster in einer Ressourcengruppe erstellen möchten, die nicht mit der Standardressourcengruppe identisch ist, geben Sie die entsprechende Ressourcengruppe als Ziel an.

      * Ein Cluster kann nur in einer Ressourcengruppe erstellt werden; nach der Erstellung des Clusters kann seine Ressourcengruppe nicht geändert werden.
      * Sie müssen mindestens über die [Rolle **Anzeigeberechtigter**](/docs/containers?topic=containers-users#platform) für die Ressourcengruppe verfügen.
      ```
      ibmcloud target -g <ressourcengruppenname>
      ```
      {: pre}

3. Überprüfen Sie, welche Zonen verfügbar sind. In der Ausgabe des folgenden Befehls lautet der **Standorttyp** der Zonen `dc`. Damit sich Ihr Cluster über Zonen erstreckt, müssen Sie den Cluster in einer [mehrzonenfähigen Zone](/docs/containers?topic=containers-regions-and-zones#zones) erstellen. Mehrzonenfähige Zonen verfügen über einen Metropolenwert in der Spalte **Mehrzonen-Metropole**.
    ```
    ibmcloud ks supported-locations
    ```
    {: pre}
    Wenn Sie eine Zone auswählen, die sich außerhalb Ihres Landes befindet, müssen Sie daran denken, dass Sie möglicherweise eine Berechtigung benötigen, bevor Daten physisch in einem fremden Land gespeichert werden können.
    {: note}

4. Überprüfen Sie, welche Workerknotentypen in dieser Zone verfügbar sind. Der Workertyp gibt an, welche virtuellen oder physischen Rechenhosts jedem Workerknoten zur Verfügung stehen.
  - **Virtuell**: Die Abrechnung erfolgt stündlich. Virtuelle Maschinen werden auf gemeinsam genutzter oder dedizierter Hardware bereitgestellt.
  - **Physisch**: Bare-Metal-Server werden monatlich abgerechnet und nach Bestellung manuell von der IBM Cloud-Infrastruktur bereitgestellt, daher kann die Ausführung mehr als einen Geschäftstag dauern. Bare-Metal-Server eignen sich am besten für Hochleistungsanwendungen, die mehr Ressourcen und Hoststeuerung erfordern.
  - **Typen**: Um zu entscheiden, welcher Typ bereitgestellt werden soll, überprüfen Sie die Kombination aus Kern, Hauptspeicher und Speicher der [verfügbaren Hardware für Workerknoten](/docs/containers?topic=containers-planning_worker_nodes#shared_dedicated_node). Nachdem Sie den Cluster erstellt haben, können Sie verschiedene physische oder virtuelle Typen hinzufügen, indem Sie [einen Worker-Pool hinzufügen](/docs/containers?topic=containers-add_workers#add_pool).

     Stellen Sie sicher, dass Sie eine Bare-Metal-Maschine bereitstellen wollen. Da die Abrechnung monatlich erfolgt, wird Ihnen ein voller Monat auch dann berechnet, wenn Sie versehentlich bestellen und sofort danach Ihre Bestellung wieder stornieren.
     {:tip}

  ```
  ibmcloud ks flavors --zone <zone>
  ```
  {: pre}

4. Prüfen Sie, ob in der IBM Cloud-Infrastruktur für dieses Konto bereits VLANs für die Zone vorhanden sind.
  ```
  ibmcloud ks vlans --zone <zone>
  ```
  {: pre}

  Beispielausgabe:
  ```
  ID        Name                Number   Type      Router  
        1519999   vlan   1355     private   bcr02a.dal10  
        1519898   vlan   1357     private   bcr02a.dal10 
        1518787   vlan   1252     public   fcr02a.dal10 
        1518888   vlan   1254     public    fcr02a.dal10
  ```
  {: screen}
  * Wenn Sie einen Cluster erstellen wollen, in dem Sie mit dem Internet verbundene Workloads ausführen können, prüfen Sie, ob ein öffentliches und ein privates VLAN vorhanden sind. Falls bereits ein öffentliches oder privates VLAN vorhanden ist, notieren Sie sich die passenden Router. Private VLAN-Router beginnen immer mit <code>bcr</code> (Back-End-Router) und öffentliche VLAN-Router immer mit <code>fcr</code> (Front-End-Router). Wenn Sie einen Cluster erstellen und die öffentlichen und privaten VLANs angeben, müssen die Zahlen- und Buchstabenkombinationen nach diesen Präfixen übereinstimmen. In der Beispielausgabe können alle privaten VLANs mit allen öffentlichen VLANs verwendet werden, weil alle Router `02a.dal10` enthalten.
  * Wenn Sie einen Cluster erstellen wollen, der Ihr lokales Rechenzentrum nur im privaten Netz erweitert, Ihr lokales Rechenzentrum mit der Option zum späteren Hinzufügen von begrenztem öffentlichen Zugriff über Workerknoten erweitert oder Ihr lokales Rechenzentrum erweitert und begrenzten öffentlichen Zugriff über eine Gateway-Einheit bereitstellt, prüfen Sie, ob ein privates VLAN vorhanden ist. Wenn ein privates VLAN vorhanden ist, notieren Sie die ID.

5. Führen Sie den Befehl `cluster-create` aus. Standardmäßig werden die Platten der Workerknoten mit 256-Bit-AES verschlüsselt und der Cluster wird nach Nutzungsstunden abgerechnet.
  * Gehen Sie wie folgt vor, um einen Cluster zu erstellen, in dem Sie mit dem Internet verbundene Workloads ausführen können:
    ```
    ibmcloud ks cluster-create --zone <zone> --machine-type <typ> --hardware <shared_oder_dedicated> --public-vlan <öffentliche_vlan-id> --private-vlan <private_vlan-id> --workers <anzahl> --name <clustername> --kube-version <major.minor.patch> [--private-service-endpoint] [--public-service-endpoint] [--disable-disk-encrypt]
    ```
    {: pre}
  * Gehen Sie wie folgt vor, um einen Cluster zu erstellen, der Ihr lokales Rechenzentrum im privaten Netz mit der Option zum späteren Hinzufügen von begrenztem öffentlichen Zugriff über Edge-Workerknoten erweitert:
    ```
    ibmcloud ks cluster-create --zone <zone> --machine-type <typ> --hardware <shared_oder_dedicated> --private-vlan <private__vlan-id> --private-only --workers <anzahl> --name <clustername> --kube-version <major.minor.patch> --private-service-endpoint [--public-service-endpoint] [--disable-disk-encrypt]
    ```
    {: pre}
  * Gehen Sie wie folgt vor, um einen Cluster zu erstellen, der Ihr lokales Rechenzentrum erweitert und begrenzten öffentlichen Zugriff über eine Gateway-Einheit bereitstellt:
    ```
    ibmcloud ks cluster-create --zone <zone> --machine-type <typ> --hardware <shared_oder_dedicated> --private-vlan <private_vlan-id> --private-only --workers <anzahl> --name <clustername> --kube-version <major.minor.patch> --public-service-endpoint [--disable-disk-encrypt]
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
    <td>Der Befehl zum Erstellen eines Clusters in Ihrer {{site.data.keyword.cloud_notm}}-Organisation.</td>
    </tr>
    <tr>
    <td><code>--zone <em>&lt;zone&gt;</em></code></td>
    <td>Geben Sie die ID der {{site.data.keyword.cloud_notm}}-Zone an, in der Sie Ihren in Schritt 4 ausgewählten Cluster erstellen wollen.</td>
    </tr>
    <tr>
    <td><code>--machine-type <em>&lt;maschinentyp&gt;</em></code></td>
    <td>Geben Sie den Typ an, den Sie in Schritt 5 ausgewählt haben.</td>
    </tr>
    <tr>
    <td><code>--hardware <em>&lt;shared_oder_dedicated&gt;</em></code></td>
    <td>Geben Sie den Grad der Hardware-Isolation für Ihren Workerknoten an. Verwenden Sie 'dedicated', wenn Sie verfügbare physische Ressourcen haben möchten, die nur Sie nutzen können, oder 'shared', um zuzulassen, dass physische Ressourcen mit anderen IBM Kunden gemeinsam genutzt werden können. Die Standardeinstellung ist 'shared'. Dieser Wert ist für VM-Standardcluster optional. Geben Sie für Bare-Metal-Typen `dedicated` an. </td>
    </tr>
    <tr>
    <td><code>--public-vlan <em>&lt;öffentliche_vlan-id&gt;</em></code></td>
    <td>Wenn für diese Zone bereits ein öffentliches VLAN in Ihrem IBM Cloud-Infrastrukturkonto eingerichtet ist, geben Sie die ID des öffentlichen VLAN ein, die Sie in Schritt 4 gefunden haben.<p>Private VLAN-Router beginnen immer mit <code>bcr</code> (Back-End-Router) und öffentliche VLAN-Router immer mit <code>fcr</code> (Front-End-Router). Wenn Sie einen Cluster erstellen und die öffentlichen und privaten VLANs angeben, müssen die Zahlen- und Buchstabenkombinationen nach diesen Präfixen übereinstimmen. </p></td>
    </tr>
    <tr>
    <td><code>--private-vlan <em>&lt;private_vlan-id&gt;</em></code></td>
    <td>Wenn für diese Zone bereits ein privates VLAN in Ihrem IBM Cloud-Infrastrukturkonto eingerichtet ist, geben Sie die ID des privaten VLAN ein, die Sie in Schritt 4 gefunden haben. Wenn Sie noch nicht über ein privates VLAN für dieses Konto verfügen, geben Sie diese Option nicht an. {{site.data.keyword.containerlong_notm}} erstellt automatisch ein privates VLAN für Sie.<p>Private VLAN-Router beginnen immer mit <code>bcr</code> (Back-End-Router) und öffentliche VLAN-Router immer mit <code>fcr</code> (Front-End-Router). Wenn Sie einen Cluster erstellen und die öffentlichen und privaten VLANs angeben, müssen die Zahlen- und Buchstabenkombinationen nach diesen Präfixen übereinstimmen. </p></td>
    </tr>
    <tr>
    <td><code>--private-only </code></td>
    <td>Erstellen Sie den Cluster nur mit privaten VLANs. Wenn Sie diese Option einschließen, schließen Sie nicht die Option <code>--public-vlan</code> ein.</td>
    </tr>
    <tr>
    <td><code>--name <em>&lt;name&gt;</em></code></td>
    <td>Geben Sie einen Namen für Ihren Cluster an. Der Name muss mit einem Buchstaben beginnen, darf Buchstaben, Ziffern und den Bindestrich (-) enthalten und darf maximal 35 Zeichen lang sein. Verwenden Sie einen Namen, der in allen Regionen eindeutig ist. Der vollständig qualifizierte Domänenname für die Ingress-Unterdomäne setzt sich aus dem Clusternamen und der Region zusammen, in der der Cluster bereitgestellt wird. Um sicherzustellen, dass die Ingress-Unterdomäne innerhalb einer Region eindeutig ist, wird der Clustername möglicherweise abgeschnitten und es wird ein beliebiger Wert innerhalb des Ingress-Domänennamens angehängt.
</td>
    </tr>
    <tr>
    <td><code>--workers <em>&lt;anzahl&gt;</em></code></td>
    <td>Geben Sie die Anzahl der Workerknoten an, die im Cluster eingebunden werden sollen. Wird die Option <code>--workers</code> nicht angegeben, wird ein Workerknoten erstellt.</td>
    </tr>
    <tr>
    <td><code>--kube-version <em>&lt;major.minor.patch&gt;</em></code></td>
    <td>Die Kubernetes-Version für den Cluster-Masterknoten. Dieser Wert ist optional. Wenn die Version nicht angegeben ist, wird der Cluster mit dem Standard für unterstützte Kubernetes-Versionen erstellt. Führen Sie den Befehl <code>ibmcloud ks versions</code> aus, um die verfügbaren Versionen anzuzeigen.
</td>
    </tr>
    <tr>
    <td><code>--private-service-endpoint</code></td>
    <td>**In [VRF-aktivierten Konten](/docs/resources?topic=resources-private-network-endpoints#getting-started)**: Aktivieren Sie den privaten Serviceendpunkt, sodass Ihr Kubernetes-Master und die Workerknoten über das private VLAN kommunizieren können. Darüber hinaus können Sie den öffentlichen Serviceendpunkt mit dem Flag `--public-service-endpoint` aktivieren, um auf Ihren Cluster über das Internet zugreifen zu können. Wenn Sie nur den privaten Serviceendpunkt aktivieren, müssen Sie mit dem privaten VLAN verbunden sein, um mit Ihrem Kubernetes-Master zu kommunizieren. Nach dem Aktivieren eines privaten Serviceendpunkts können Sie diesen später nicht mehr inaktivieren.<br><br>Nach dem Erstellen des Clusters können Sie den Endpunkt mit dem Befehl `ibmcloud ks cluster-get --cluster <clustername_oder_-id>` abrufen.</td>
    </tr>
    <tr>
    <td><code>--public-service-endpoint</code></td>
    <td>Aktivieren Sie den öffentlichen Serviceendpunkt, sodass auf Ihren Kubernetes-Master über das öffentliche Netz zugegriffen werden kann, zum Beispiel um `kubectl`-Befehle über Ihr Terminal auszuführen, und damit Ihr Kubernetes-Master und die Workerknoten über das private VLAN kommunizieren können. Sie können den öffentlichen Serviceendpunkt später inaktivieren, wenn Sie einen rein privaten Cluster wünschen.<br><br>Nach dem Erstellen des Clusters können Sie den Endpunkt mit dem Befehl `ibmcloud ks cluster-get --cluster <clustername_oder_-id>` abrufen.</td>
    </tr>
    <tr>
    <td><code>--disable-disk-encrypt</code></td>
    <td>Workerknoten verfügen standardmäßig über eine [Plattenverschlüsselung](/docs/containers?topic=containers-security#encrypted_disk) (256-Bit-AES). Wenn Sie die Verschlüsselung inaktivieren möchten, schließen Sie diese Option ein.</td>
    </tr>
    </tbody></table>

6. Prüfen Sie, ob die Erstellung des Clusters angefordert wurde. Bei virtuellen Maschinen kann es einige Minuten dauern, bis die Workerknotenmaschinen angewiesen werden und der Cluster in Ihrem Konto eingerichtet und bereitgestellt wird. Physische Bare-Metal-Maschinen werden durch einen manuelle Interaktion mit der IBM Cloud-Infrastruktur bereitgestellt, daher kann die Ausführung mehr als einen Arbeitstag dauern.
    ```
    ibmcloud ks clusters
    ```
    {: pre}

    Nach Abschluss der Bereitstellung Ihres Clusters wird der Status des Clusters in **deployed** (Bereitgestellt) geändert.
    ```
    Name         ID                                   State      Created          Workers   Zone       Version     Resource Group Name
    my_cluster   paf97e8843e29941b49c598f516de72101   deployed   20170201162433   1         mil01      1.13.8      Default
    ```
    {: screen}

    Ist Ihr Cluster nicht im Zustand **deployed** (bereitgestellt)? Informationen darüber, wie Sie den Status des Clusters überprüfen können, finden Sie unter [Cluster debuggen](/docs/containers?topic=containers-cs_troubleshoot). Wenn Ihr Cluster beispielsweise in einem Konto bereitgestellt wird, das durch eine Firewall-Gateway-Einheit geschützt ist, müssen Sie [Ihre Firewalleinstellungen so konfigurieren, dass sie ausgehenden Datenverkehr zu den entsprechenden Ports und IP-Adressen zulassen](/docs/containers?topic=containers-firewall#firewall_outbound).
    {: tip}

7. Überprüfen Sie den Status der Workerknoten.
    ```
    ibmcloud ks workers --cluster <clustername_oder_-id>
    ```
    {: pre}

    Wenn die Workerknoten bereit sind, wechselt der Zustand (State) zu **Normal**, während für den Status die Angabe **Bereit** angezeigt wird. Wenn der Knotenstatus **Ready** (bereit) lautet, können Sie auf den Cluster zugreifen. Beachten Sie, dass selbst bei Bereitschaft des Clusters einige seiner Teile, die von anderen Services wie den geheimen Ingress-Schlüsseln oder geheimen Schlüsseln für Registry-Image-Pull-Operationen verwendet werden, möglicherweise noch in Verarbeitung sind. Beachten Sie, dass Ihren Workerknoten keine **öffentlichen IP-Adressen** zugeordnet werden, wenn Sie Ihren Cluster nur mit einem privaten VLAN erstellt haben.

    ```
    ID                                                 Public IP       Private IP      Machine Type   State    Status   Zone        Version     Resource Group Name
    kube-mil01-paf97e8843e29941b49c598f516de72101-w1   169.xx.xxx.xxx  10.xxx.xx.xxx   standard       normal   Ready    mil01       1.13.8      Default
    ```
    {: screen}

    Jedem Workerknoten werden eine eindeutige Workerknoten-ID und ein Domänenname zugewiesen, die nach dem Erstellen des Clusters nicht manuell geändert werden dürfen. Wenn die ID oder der Domänenname geändert wird, kann der Kubernetes-Master Ihren Cluster nicht mehr verwalten.
    {: important}

8. Nach der Erstellung des Clusters können [Sie anfangen, mit Ihrem Cluster zu arbeiten, indem Sie Ihre CLI-Sitzung konfigurieren](#access_cluster).

<br />


## Auf Ihren Cluster zugreifen
{: #access_cluster}

Nach der Erstellung des Clusters können Sie anfangen, mit Ihrem Cluster zu arbeiten, indem Sie Ihre CLI-Sitzung konfigurieren.
{: shortdesc}

### Über den öffentlichen Serviceendpunkt auf Cluster zugreifen
{: #access_internet}

Damit Sie mit Ihrem Cluster arbeiten können, legen Sie den von Ihnen erstellten Cluster als Kontext für eine CLI-Sitzung fest, um `kubectl`-Befehle auszuführen.
{: shortdesc}

Wenn Sie stattdessen die {{site.data.keyword.cloud_notm}}-Konsole verwenden möchten, können Sie CLI-Befehle direkt über Ihren Web-Browser im [Kubernetes-Terminal](/docs/containers?topic=containers-cs_cli_install#cli_web) ausführen.
{: tip}

1. Wenn Ihr Netz durch eine Firewall des Unternehmens geschützt ist, lassen Sie Zugriff auf die {{site.data.keyword.cloud_notm}}- und {{site.data.keyword.containerlong_notm}}-API-Endpunkte und -Ports zu.
  1. [Lassen Sie in Ihrer Firewall Zugriff auf die öffentlichen Endpunkte für die `ibmcloud`-API und die `ibmcloud ks`-API zu](/docs/containers?topic=containers-firewall#firewall_bx).
  2. [Lassen Sie zu, dass berechtigte Clusterbenutzer `kubectl`-Befehle ausführen](/docs/containers?topic=containers-firewall#firewall_kubectl), um auf den Master nur über den öffentlichen Serviceendpunkt, nur über den privaten Serviceendpunkt oder über den öffentlichen und den privaten Serviceendpunkt zuzugreifen.
  3. [Lassen Sie zu, dass berechtigte Clusterbenutzer `calicotl`-Befehle ausführen](/docs/containers?topic=containers-firewall#firewall_calicoctl), um Calico-Netzrichtlinien in Ihrem Cluster zu verwalten.

2. Legen Sie den von Ihnen erstellten Cluster als Kontext für diese Sitzung fest. Führen Sie diese Konfigurationsschritte jedes Mal aus, wenn Sie mit Ihrem Cluster arbeiten.
  1. Ermitteln Sie den Befehl zum Festlegen der Umgebungsvariablen und laden Sie die Kubernetes-Konfigurationsdateien herunter.
      ```
      ibmcloud ks cluster-config --cluster <clustername_oder_-id>
      ```
      {: pre}
      Wenn der Download der Konfigurationsdateien abgeschlossen ist, wird ein Befehl angezeigt, den Sie verwenden können, um den Pfad zu der lokalen Kubernetes-Konfigurationsdatei als Umgebungsvariable festzulegen.

      Beispiel für OS X:
      ```
              export KUBECONFIG=/Users/<benutzername>/.bluemix/plugins/kubernetes-service/clusters/mycluster/kube-config-prod-dal10-mycluster.yml
        ```
      {: screen}
  2. Kopieren Sie den Befehl, der in Ihrem Terminal angezeigt wird, um die Umgebungsvariable `KUBECONFIG` festzulegen.
  3. Stellen Sie sicher, dass die Umgebungsvariable `KUBECONFIG` richtig eingestellt ist.
      Beispiel für OS X:
      ```
      echo $KUBECONFIG
      ```
      {: pre}

      Ausgabe:
      ```
      /Users/<benutzername>/.bluemix/plugins/kubernetes-service/clusters/mycluster/kube-config-prod-dal10-mycluster.yml
        ```
      {: screen}

3. Starten Sie Ihr Kubernetes-Dashboard über den Standardport `8001`.
  1. Legen Sie die Standardportnummer für den Proxy fest.
      ```
      kubectl proxy
      ```
      {: pre}

      ```
      Starting to serve on 127.0.0.1:8001
      ```
      {: screen}

  2.  Öffnen Sie die folgende URL in einem Web-Browser, damit das Kubernetes-Dashboard angezeigt wird.
      ```
      http://localhost:8001/ui
      ```
      {: codeblock}

### Über den privaten Serviceendpunkt auf Cluster zugreifen
{: #access_on_prem}

Der Kubernetes-Master ist über den privaten Serviceendpunkt zugänglich, wenn berechtigte Clusterbenutzer sich in Ihrem privaten {{site.data.keyword.cloud_notm}}-Netz befinden oder über eine [VPN-Verbindung](/docs/infrastructure/iaas-vpn?topic=VPN-getting-started) oder [{{site.data.keyword.cloud_notm}} Direct Link](/docs/infrastructure/direct-link?topic=direct-link-get-started-with-ibm-cloud-direct-link) mit dem privaten Netz verbunden sind. Die Kommunikation mit dem Kubernetes-Master über den privaten Serviceendpunkt muss jedoch über den IP-Adressbereich <code>166.X.X</code> erfolgen, der über eine VPN-Verbindung oder über {{site.data.keyword.cloud_notm}} Direct Link nicht angesteuert werden kann. Sie können den privaten Serviceendpunkt des Masters für Ihre Clusterbenutzer mithilfe einer privaten Netzlastausgleichsfunktion (NLB) zugänglich machen. Die private NLB macht den privaten Serviceendpunkt des Masters als internen <code>10.X.X.X</code>-IP-Adressbereich zugänglich, auf den Benutzer über eine VPN- oder {{site.data.keyword.cloud_notm}} Direct Link-Verbindung zugreifen können. Wenn Sie nur den privaten Serviceendpunkt aktivieren, können Sie das Kubernetes-Dashboard verwenden oder vorübergehend den öffentlichen Serviceendpunkt aktivieren, um die private NLB zu erstellen.
{: shortdesc}

1. Wenn Ihr Netz durch eine Firewall des Unternehmens geschützt ist, lassen Sie Zugriff auf die {{site.data.keyword.cloud_notm}}- und {{site.data.keyword.containerlong_notm}}-API-Endpunkte und -Ports zu.
  1. [Lassen Sie in Ihrer Firewall Zugriff auf die öffentlichen Endpunkte für die `ibmcloud`-API und die `ibmcloud ks`-API zu](/docs/containers?topic=containers-firewall#firewall_bx).
  2. [Lassen Sie zu, dass berechtigte Clusterbenutzer `kubectl`-Befehle ausführen](/docs/containers?topic=containers-firewall#firewall_kubectl). Beachten Sie, dass Sie die Verbindung zu Ihrem Cluster in Schritt 6 erst testen können, nachdem Sie den privaten Serviceendpunkt des Masters mithilfe einer privaten NLB für den Cluster zugänglich gemacht haben.

2. Rufen Sie die URL und den Port des privaten Serviceendpunkts für Ihren Cluster ab.
  ```
  ibmcloud ks cluster-get --cluster <clustername_oder_-id>
  ```
  {: pre}

  In dieser Beispielausgabe lautet der Wert für **Private Service Endpoint URL** `https://c1.private.us-east.containers.cloud.ibm.com:25073`.
  ```
  Name:                           setest
  ID:                             b8dcc56743394fd19c9f3db7b990e5e3
  State:                          normal
  Created:                        2019-04-25T16:03:34+0000
  Location:                       wdc04
  Master URL:                     https://c1.private.us-east.containers.cloud.ibm.com:25073
  Public Service Endpoint URL:    -
  Private Service Endpoint URL:   https://c1.private.us-east.containers.cloud.ibm.com:25073
  Master Location:                Washington D.C.
  ...
  ```
  {: screen}

3. Erstellen Sie eine YAML-Datei mit dem Namen `kube-api-via-nlb.yaml`. Diese YAML-Datei erstellt einen privaten `LoadBalancer`-Service und macht den privaten Serviceendpunkt durch diese NLB zugänglich. Ersetzen Sie `<privater_serviceendpunktport>` durch den Port, den Sie im vorherigen Schritt gefunden haben.
  ```
  apiVersion: v1
  kind: Service
  metadata:
    name: kube-api-via-nlb
    annotations:
      service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: private
    namespace: default
  spec:
    type: LoadBalancer
    ports:
    - protocol: TCP
      port: <privater_serviceendpunktport>
      targetPort: <privater_serviceendpunktport>
  ---
  kind: Endpoints
  apiVersion: v1
  metadata:
    name: kube-api-via-nlb
  subsets:
    - addresses:
        - ip: 172.20.0.1
      ports:
        - port: 2040
  ```
  {: codeblock}

4. Damit Sie die private NLB erstellen können, müssen Sie mit dem Cluster-Master verbunden sein. Da Sie noch keine Verbindung durch den privaten Serviceendpunkt über eine VPN- oder {{site.data.keyword.cloud_notm}} Direct Link-Verbindung herstellen können, müssen Sie eine Verbindung zum Cluster-Master herstellen und die NLB mithilfe des öffentlichen Serviceendpunkts oder über das Kubernetes-Dashboard erstellen.
  * Wenn Sie nur den privaten Serviceendpunkt aktiviert haben, können Sie das Kubernetes-Dashboard verwenden, um die NLB zu erstellen. Das Dashboard leitet automatisch alle Anforderungen an den privaten Serviceendpunkt des Masters weiter.
    1.  Melden Sie sich bei der [{{site.data.keyword.cloud_notm}}-Konsole](https://cloud.ibm.com/) an.
    2.  Wählen Sie in der Menüleiste das Konto aus, das Sie verwenden möchten.
    3.  Klicken Sie im Menü ![Menüsymbol](../icons/icon_hamburger.svg "Menüsymbol") auf **Kubernetes**.
    4.  Klicken Sie auf der Seite **Cluster** auf den Cluster, auf den Sie zugreifen möchten.
    5.  Klicken Sie auf der Seite mit den Clusterdetails auf **Kubernetes-Dashboard**.
    6.  Klicken Sie auf **+ Erstellen**.
    7.  Wählen Sie **Aus Datei erstellen** aus, laden Sie die Datei `kube-api-via-nlb.yaml` hoch und klicken Sie auf **Hochladen**.
    8.  Überprüfen Sie auf der Seite **Übersicht**, ob der Service `kube-api-via-nlb` erstellt wurde. Notieren Sie die Adresse `10.x.x.x` in der Spalte **Externe Endpunkte**. Diese IP-Adresse macht den privaten Serviceendpunkt für den Kubernetes-Master an dem Port zugänglich, den Sie in Ihrer YAML-Datei angegeben haben.

  * Wenn Sie auch den öffentlichen Serviceendpunkt aktiviert haben, haben Sie bereits Zugriff auf den Master.
    1. Ermitteln Sie den Befehl zum Festlegen der Umgebungsvariablen und laden Sie die Kubernetes-Konfigurationsdateien herunter.
        ```
        ibmcloud ks cluster-config --cluster <clustername_oder_-id>
        ```
        {: pre}
        Wenn der Download der Konfigurationsdateien abgeschlossen ist, wird ein Befehl angezeigt, den Sie verwenden können, um den Pfad zu der lokalen Kubernetes-Konfigurationsdatei als Umgebungsvariable festzulegen.

        Beispiel für OS X:
        ```
                export KUBECONFIG=/Users/<benutzername>/.bluemix/plugins/kubernetes-service/clusters/mycluster/kube-config-prod-dal10-mycluster.yml
        ```
        {: screen}
    2. Kopieren Sie den Befehl, der in Ihrem Terminal angezeigt wird, um die Umgebungsvariable `KUBECONFIG` festzulegen.
    3. Erstellen Sie die NLB und den Endpunkt.
      ```
      kubectl apply -f kube-api-via-nlb.yaml
      ```
      {: pre}
    4. Überprüfen Sie, ob die NLB `kube-api-via-nlb` erstellt wurde. Notieren Sie die Adresse `10.x.x.x` unter **EXTERNAL-IP** in der Ausgabe. Diese IP-Adresse macht den privaten Serviceendpunkt für den Kubernetes-Master an dem Port zugänglich, den Sie in Ihrer YAML-Datei angegeben haben.
      ```
      kubectl get svc -o wide
      ```
      {: pre}

      In dieser Beispielausgabe lautet die IP-Adresse für den privaten Serviceendpunkt des Kubernetes-Masters `10.186.92.42`.
      ```
      NAME                     TYPE           CLUSTER-IP       EXTERNAL-IP      PORT(S)          AGE   SELECTOR
      kube-api-via-nlb         LoadBalancer   172.21.150.118   10.186.92.42     443:32235/TCP    10m   <none>
      ...
      ```
      {: screen}

  <p class="note">Wenn Sie eine Verbindung zum Master mithilfe des [strongSwan-VPN-Service](/docs/containers?topic=containers-vpn#vpn-setup) herstellen wollen, notieren Sie stattdessen die **Cluster-IP-Adresse** `172.21.x.x` für die Verwendung im nächsten Schritt. Da der strongSwan-VPN-Pod innerhalb Ihres Clusters ausgeführt wird, kann er über die IP-Adresse des internen Cluster-IP-Service auf die NLB zugreifen. Stellen Sie sicher, dass in Ihrer Datei `config.yaml` für das strongSwan-Helm-Diagramm das Teilnetz-CIDR für den Kubernetes Service, `172.21.0.0/16`, in der Einstellung `local.subnet` aufgelistet wird.</p>

5. Fügen Sie auf den Clientmaschinen, auf denen Sie oder Ihre Benutzer `kubectl`-Befehle ausführen, die NLB-IP-Adresse und die URL des privaten Serviceendpunkts zur Datei `/etc/hosts` hinzu. Schließen Sie keine Ports in der IP-Adresse und URL ein und schließen Sie nicht `https://` in der URL ein.
  * Für OS X- und Linux-Benutzer:
    ```
    sudo nano /etc/hosts
    ```
    {: pre}
  * Für Windows-Benutzer:
    ```
    notepad C:\Windows\System32\drivers\etc\hosts
    ```
    {: pre}

    Abhängig von Ihren Berechtigungen für die lokale Maschine müssen Sie Notepad als Administrator ausführen, um die Datei 'hosts' bearbeiten zu können.
    {: tip}

  Beispiel für hinzuzufügenden Text:
  ```
  10.186.92.42      c1.private.us-east.containers.cloud.ibm.com
  ```
  {: codeblock}

6. Überprüfen Sie, ob Sie über eine VPN- oder {{site.data.keyword.cloud_notm}} Direct Link-Verbindung mit dem privaten Netz verbunden sind.

7. Ermitteln Sie den Befehl zum Festlegen der Umgebungsvariablen und laden Sie die Kubernetes-Konfigurationsdateien herunter.
    ```
    ibmcloud ks cluster-config --cluster <clustername_oder_-id>
    ```
    {: pre}
    Wenn der Download der Konfigurationsdateien abgeschlossen ist, wird ein Befehl angezeigt, den Sie verwenden können, um den Pfad zu der lokalen Kubernetes-Konfigurationsdatei als Umgebungsvariable festzulegen.

    Beispiel für OS X:
    ```
            export KUBECONFIG=/Users/<benutzername>/.bluemix/plugins/kubernetes-service/clusters/mycluster/kube-config-prod-dal10-mycluster.yml
        ```
    {: screen}

8. Optional: Wenn Sie sowohl die öffentlichen als auch die privaten Serviceendpunkte aktiviert haben, können Sie Ihre lokale Kubernetes-Konfigurationsdatei so aktualisieren, dass sie den privaten Serviceendpunkt verwendet. Standardmäßig wird der öffentliche Serviceendpunkt für die Konfigurationsdatei heruntergeladen.
  1. Navigieren Sie zum Verzeichnis `kubeconfig` und öffnen Sie die Datei.
    ```
    cd /Users/<benutzername>/.bluemix/plugins/kubernetes-service/clusters/<clustername> && nano touch kube-config-prod-dal10-mycluster.yml
    ```
    {: pre}
  2. Bearbeiten Sie Ihre Kubernetes-Konfigurationsdatei, indem Sie das Wort `private` zur URL des Serviceendpunkts hinzuzufügen. In der Kubernetes-Konfigurationsdatei `kube-config-prod-dal10-mycluster.yml` kann das Serverfeld beispielsweise wie folgt aussehen: `server: https://c1.us-east.containers.cloud.ibm.com:30426`. Sie können diese URL in die URL des privaten Serviceendpunkts ändern, indem Sie den Inhalt des Serverfelds wie folgt ändern: `server: https://c1.private.us-east.containers.cloud.ibm.com:30426`.
  3. Wiederholen Sie diese Schritte jedes Mal, wenn Sie `ibmcloud ks cluster-config` ausführen.

9. Kopieren Sie den Befehl, der in Ihrem Terminal angezeigt wird, um die Umgebungsvariable `KUBECONFIG` festzulegen.

10. Stellen Sie sicher, dass die `kubectl`-Befehle mit Ihrem Cluster durch den privaten Serviceendpunkt ordnungsgemäß ausgeführt werden. Überprüfen Sie dazu die Serverversion der Kubernetes-CLI wie folgt.
  ```
  kubectl version  --short
  ```
  {: pre}

  Beispielausgabe:
  ```
  Client Version: v1.13.8
  Server Version: v1.13.8
  ```
  {: screen}

<br />


## Nächste Schritte
{: #next_steps}

Wenn der Cluster betriebsbereit ist, können Sie sich mit den folgenden Tasks vertraut machen:
- Wenn Sie den Cluster in einer mehrzonenfähigen Zone erstellt haben, [verteilen Sie Workerknoten durch Hinzufügen einer Zone zum Cluster](/docs/containers?topic=containers-add_workers).
- [Stellen Sie eine App in Ihrem Cluster bereit.](/docs/containers?topic=containers-app#app_cli)
- [Richten Sie Ihre eigene private Registry in {{site.data.keyword.cloud_notm}} ein, um Docker-Images zu speichern und gemeinsam mit anderen Benutzern zu verwenden.](/docs/services/Registry?topic=registry-getting-started)
- [Richten Sie den Cluster-Autoscaler ein](/docs/containers?topic=containers-ca#ca), um Workerknoten in Ihren Worker-Pools automatisch entsprechend den Workloadressourcenanforderungen hinzuzufügen oder zu entfernen.
- Sie können steuern, wer in Ihrem Cluster Pods mit [Pod-Sicherheitsrichtlinien](/docs/containers?topic=containers-psp) erstellen kann.
- Aktivieren Sie die verwalteten [Istio](/docs/containers?topic=containers-istio)- und [Knative](/docs/containers?topic=containers-serverless-apps-knative)-Add-ons, um Ihre Clusterfunktionen zu erweitern.

Dann können Sie sich mit den folgenden Netzkonfigurationsschritten für Ihr Cluster-Setup vertraut machen:

### Workloads von mit dem Internet verbundenen Apps in einem Cluster ausführen
{: #next_steps_internet}

* Isolieren Sie Netzworkloads an [Edge-Workerknoten](/docs/containers?topic=containers-edge).
* Machen Sie Ihre Apps mit [öffentlichen Netzservices ](/docs/containers?topic=containers-cs_network_planning#public_access) zugänglich.
* Steuern Sie den öffentlichen Datenverkehr zu den Netzservices, die Ihre Apps zugänglich machen, indem Sie [Calico-Richtlinien des Typs Pre-DNAT](/docs/containers?topic=containers-network_policies#block_ingress) erstellen, wie z. B. Whitelist- und Blacklist-Richtlinien.
* Verbinden Sie Ihren Cluster mit Services in privaten Netzen außerhalb Ihres {{site.data.keyword.cloud_notm}}-Kontos, indem Sie einen [strongSwan-IPSec-VPN-Service](/docs/containers?topic=containers-vpn) einrichten.

### Lokales Rechenzentrum in einen Cluster erweitern und begrenzten öffentlichen Zugriff mithilfe von Edge-Knoten und Calico-Netzrichtlinien zulassen
{: #next_steps_calico}

* Verbinden Sie Ihren Cluster mit Services in privaten Netzen außerhalb Ihres {{site.data.keyword.cloud_notm}}-Kontos, indem Sie [{{site.data.keyword.cloud_notm}} Direct Link](/docs/infrastructure/direct-link?topic=direct-link-get-started-with-ibm-cloud-direct-link) oder den [strongSwan-IPSec-VPN-Service](/docs/containers?topic=containers-vpn#vpn-setup) einrichten. {{site.data.keyword.cloud_notm}} Direct Link ermöglicht die Kommunikation zwischen Apps und Services in Ihrem Cluster und in einem lokalen Netz über das private Netz, während strongSwan die Kommunikation durch einen verschlüsselten VPN-Tunnel über das öffentliche Netz ermöglicht.
* Isolieren Sie Workloads im öffentlichen Netzbetrieb, indem Sie einen [Edge-Worker-Pool](/docs/containers?topic=containers-edge) mit Workerknoten erstellen, die mit öffentlichen und privaten VLANs verbunden sind.
* Machen Sie Ihre Apps mit [privaten Netzservices ](/docs/containers?topic=containers-cs_network_planning#private_access) zugänglich.
* Erstellen Sie Calico-Host-Netzrichtlinien, Ihren Cluster im [öffentlichen Netz](/docs/containers?topic=containers-network_policies#isolate_workers_public) und im [privaten Netz](/docs/containers?topic=containers-network_policies#isolate_workers) zu isolieren.

### Lokales Rechenzentrum in einen Cluster erweitern und begrenzten öffentlichen Zugriff mithilfe einer Gateway-Einheit zulassen
{: #next_steps_gateway}

* Wenn Sie Ihre Gateway-Firewall für das private Netz konfigurieren, müssen Sie [die Kommunikation zwischen Workerknoten zulassen und Ihren Cluster über das private Netz auf Infrastrukturressourcen zugreifen lassen.](/docs/containers?topic=containers-firewall#firewall_private)
* Um eine sichere Verbindung Ihrer Workerknoten und Apps zu privaten Netzen außerhalb Ihres {{site.data.keyword.cloud_notm}}-Kontos herzustellen, richten Sie einen IPSec-VPN-Endpunkt in Ihrer Gateway-Einheit ein. Richten Sie anschließend [den strongSwan-IPSec-VPN-Service in Ihrem Cluster ein](/docs/containers?topic=containers-vpn#vpn-setup), um den VPN-Endpunkt auf Ihrem Gateway zu verwenden, oder [richten Sie die VPN-Konnektivität direkt mit VRA ein](/docs/containers?topic=containers-vpn#vyatta).
* Machen Sie Ihre Apps mit [privaten Netzservices ](/docs/containers?topic=containers-cs_network_planning#private_access) zugänglich.
* [Öffnen Sie die erforderlichen Ports und IP-Adressen](/docs/containers?topic=containers-firewall#firewall_inbound) in der Firewall Ihrer Gateway-Einheit, um eingehenden Datenverkehr für Netzservices zuzulassen.

### Lokales Rechenzentrum in einen Cluster im privaten Netz erweitern
{: #next_steps_extend}

* Wenn Sie über eine Firewall im privaten Netz verfügen, [lassen Sie die Kommunikation zwischen den Workerknoten zu und lassen Sie Ihren Cluster über das private Netz auf die Infrastrukturressourcen zugreifen.](/docs/containers?topic=containers-firewall#firewall_private)
* Verbinden Sie Ihren Cluster mit Services in privaten Netzen außerhalb Ihres {{site.data.keyword.cloud_notm}}-Kontos, indem Sie [{{site.data.keyword.cloud_notm}} Direct Link](/docs/infrastructure/direct-link?topic=direct-link-get-started-with-ibm-cloud-direct-link) einrichten.
* Machen Sie Ihre Apps im privaten Netz mit [privaten Netzservices ](/docs/containers?topic=containers-cs_network_planning#private_access) zugänglich.
