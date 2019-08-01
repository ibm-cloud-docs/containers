---

copyright:
  years: 2014, 2019
lastupdated: "2019-06-06"

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



# Workerknoten und Zonen zu Clustern hinzufügen
{: #add_workers}

Wenn Sie die Verfügbarkeit Ihrer Apps erhöhen möchten, können Sie Workerknoten zu einer vorhandenen Zone oder mehreren vorhandenen Zonen in Ihrem Cluster hinzufügen. Um Ihre Apps vor Zonenausfällen zu schützen, können Sie Zonen zu Ihrem Cluster hinzufügen.
{:shortdesc}

Wenn Sie einen Cluster erstellen, werden die Workerknoten in einem Worker-Pool bereitgestellt. Nach der Clustererstellung können Sie weitere Workerknoten zu einem Pool hinzufügen, indem Sie die Größe ändern oder weitere Worker-Pools hinzufügen. Der Worker-Pool ist standardmäßig in einer Zone vorhanden. Cluster, die über einen Worker-Pool in nur einer Zone verfügen, werden als Einzelzonencluster bezeichnet. Wenn Sie dem Cluster weitere Zonen hinzufügen, ist der Worker-Pool zonenübergreifend vorhanden. Cluster, die über einen Worker-Pool verfügen, der über mehrere Zonen verteilt ist, werden als Mehrzonencluster bezeichnet.

Wenn Sie über einen Mehrzonencluster verfügen, müssen seine Workerknotenressourcen ausgeglichen sein. Stellen Sie sicher, dass alle Worker-Pools über dieselben Zonen verteilt sind und fügen Sie Worker hinzu oder entfernen Sie sie, indem Sie die Größe der Pools ändern, anstatt einzelne Knoten hinzuzufügen.
{: tip}

Bevor Sie beginnen, stellen Sie sicher, dass Sie die [{{site.data.keyword.Bluemix_notm}} IAM-Plattformrolle **Operator** oder **Administrator**](/docs/containers?topic=containers-users#platform) innehaben. Wählen Sie dann einen der folgenden Abschnitte aus:
  * [Workerknoten durch Ändern der Größe eines vorhandenen Worker-Pools in Ihrem Cluster hinzufügen](#resize_pool)
  * [Workerknoten durch Hinzufügen eines Worker-Pools zu Ihrem Cluster hinzufügen](#add_pool)
  * [Eine Zone zu Ihrem Cluster hinzufügen und die Workerknoten in den Worker-Pools über mehrere Zonen replizieren](#add_zone)
  * [Einen eigenständigen Workerknoten zu einem Cluster hinzufügen (veraltet)](#standalone)

Nach der Einrichtung Ihres Worker-Pools können Sie den [Cluster-Autoscaler einrichten](/docs/containers?topic=containers-ca#ca), um Workerknoten in Ihren Worker-Pools automatisch entsprechend den Workloadressourcenanforderungen hinzuzufügen oder zu entfernen.
{:tip}

## Workerknoten durch Ändern der Größe eines vorhandenen Worker-Pools hinzufügen
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
    ibmcloud ks workers --cluster <clustername_oder_-id> --worker-pool <poolname>
    ```
    {: pre}

    Beispielausgabe für einen Worker-Pool, der sich in zwei Zonen (`dal10` und `dal12`) befindet und dessen Größe auf zwei Workerknoten pro Zone geändert wird:
    ```
    ID                                                 Public IP        Private IP      Machine Type      State    Status  Zone    Version
    kube-dal10-crb20b637238ea471f8d4a8b881aae4962-w7   169.xx.xxx.xxx   10.xxx.xx.xxx   b3c.4x16          normal   Ready   dal10   1.8.6_1504
    kube-dal10-crb20b637238ea471f8d4a8b881aae4962-w8   169.xx.xxx.xxx   10.xxx.xx.xxx   b3c.4x16          normal   Ready   dal10   1.8.6_1504
    kube-dal12-crb20b637238ea471f8d4a8b881aae4962-w9   169.xx.xxx.xxx   10.xxx.xx.xxx   b3c.4x16          normal   Ready   dal12   1.8.6_1504
    kube-dal12-crb20b637238ea471f8d4a8b881aae4962-w10  169.xx.xxx.xxx   10.xxx.xx.xxx   b3c.4x16          normal   Ready   dal12   1.8.6_1504
    ```
    {: screen}

## Workerknoten durch Erstellen eines neuen Worker-Pools hinzufügen
{: #add_pool}

Sie können Workerknoten zu Ihrem Cluster hinzufügen, indem Sie einen neuen Worker-Pool erstellen.
{:shortdesc}

1. Rufen Sie die **Workerzonen** Ihres Clusters ab und wählen Sie die Zone aus, in der Sie die Workerknoten in Ihrem Workerpool bereitstellen möchten. Wenn Sie über ein Einzelzonencluster verfügen, müssen Sie die Zone verwenden, die im Feld **Workerzonen** angegeben ist. Bei Mehrzonenclustern können Sie eine der vorhandenen **Workerzonen** Ihres Clusters auswählen oder einen der [Standorte in einer Mehrzonen-Metropole](/docs/containers?topic=containers-regions-and-zones#zones) für die Region hinzufügen, in der sich Ihr Cluster befindet. Verfügbare Zonen können Sie durch Ausführen von `ibmcloud ks zones` auflisten.
   ```
   ibmcloud ks cluster-get --cluster <clustername_oder_-id>
   ```
   {: pre}

   Beispielausgabe:
   ```
   ...
   Worker Zones: dal10, dal12, dal13
   ```
   {: screen}

2. Listen Sie für jede Zone private und öffentliche VLANs auf. Notieren Sie sich das private und das öffentliche VLAN, das Sie verwenden möchten. Wenn Sie nicht über ein privates oder ein öffentliches VLAN verfügen, wird das VLAN automatisch für Sie erstellt, wenn Sie eine Zone zu Ihrem Worker-Pool hinzufügen.
   ```
   ibmcloud ks vlans --zone <zone>
   ```
   {: pre}

3.  Überprüfen Sie für jede Zone die [verfügbaren Maschinentypen für die Workerknoten](/docs/containers?topic=containers-planning_worker_nodes#planning_worker_nodes).

    ```
    ibmcloud ks machine-types <zone>
    ```
    {: pre}

4. Erstellen Sie einen Worker-Pool. Schließen Sie die Option `--labels` ein, um Workerknoten, die sich mit der Bezeichnung `schlüssel=wert` im Pool befinden, automatisch eine Bezeichnung zuzuordnen. Falls Sie einen Bare-Metal-Worker-Pool bereitstellen, geben Sie `--hardware dedicated` an.
   ```
   ibmcloud ks worker-pool-create --name <poolname> --cluster <clustername_oder_-id> --machine-type <machinentyp> --size-per-zone <anzahl_der_worker_pro_zone> --hardware <dediziert_oder_gemeinsam_genutzt> --labels <schlüssel=wert>
   ```
   {: pre}

5. Stellen Sie sicher, dass der Worker-Pool erstellt wird.
   ```
   ibmcloud ks worker-pools --cluster <clustername_oder_-id>
   ```
   {: pre}

6. Standardmäßig wird durch das Hinzufügen eines Worker-Pools ein Pool ohne Zonen erstellt. Um Workerknoten in einer Zone bereitzustellen, müssen Sie die Zonen zum Worker-Pool hinzufügen, die Sie vorher abgerufen haben. Wenn Sie die Workerknoten auf mehrere Zonen verteilen möchten, wiederholen Sie diesen Befehl für jede einzelne Zone.
   ```
   ibmcloud ks zone-add --zone <zone> --cluster <clustername_oder_-id> --worker-pools <poolname> --private-vlan <private_vlan-id> --public-vlan <öffentliche_vlan-id>
   ```
   {: pre}

7. Stellen Sie sicher, dass die Workerknoten in der Zone bereitgestellt werden, die Sie hinzugefügt haben. Die Workerknoten sind bereit, wenn der Status von **provision_pending** zu **normal** wechselt.
   ```
   ibmcloud ks workers --cluster <clustername_oder_-id> --worker-pool <poolname>
   ```
   {: pre}

   Beispielausgabe:
   ```
   ID                                                 Public IP        Private IP      Machine Type      State    Status  Zone    Version
   kube-dal10-crb20b637238ea471f8d4a8b881aae4962-w7   169.xx.xxx.xxx   10.xxx.xx.xxx   b3c.4x16          provision_pending   Ready   dal10   1.8.6_1504
   kube-dal10-crb20b637238ea471f8d4a8b881aae4962-w8   169.xx.xxx.xxx   10.xxx.xx.xxx   b3c.4x16          provision_pending   Ready   dal10   1.8.6_1504
   ```
   {: screen}

## Workerknoten durch Hinzufügen einer Zone zu einem Worker-Pool hinzufügen
{: #add_zone}

Sie können Ihren Cluster über mehrere Zonen in einer Region verteilen, indem Sie eine Zone zu dem vorhandenen Worker-Pool hinzufügen.
{:shortdesc}

Wenn Sie eine Zone zu einem Worker-Pool hinzufügen, werden die in Ihrem Worker-Pool definierten Workerknoten in der neuen Zone bereitgestellt und für die zukünftige Planung von Arbeitslasten berücksichtigt. {{site.data.keyword.containerlong_notm}} fügt automatisch die Bezeichnung `failure-domain.beta.kubernetes.io/region` für die Region und die Bezeichnung `failure-domain.beta.kubernetes.io/zone` für die Zone für jeden Workerknoten hinzu. Der Kubernetes-Scheduler verwendet diese Bezeichnungen, um Pods auf Zonen innerhalb derselben Region zu verteilen.

Wenn Sie über mehrere Worker-Pools in Ihrem Cluster verfügen, fügen Sie die Zone zu allen Pools hinzu, sodass die Workerknoten gleichmäßig über den Cluster hinweg verteilt sind.

Vorbereitende Schritte:
*  Wenn Sie eine Zone zu Ihrem Worker-Pool hinzufügen möchten, muss sich Ihr Worker-Pool in einer [mehrzonenfähigen Zone](/docs/containers?topic=containers-regions-and-zones#zones) befinden. Wenn sich der Worker-Pool nicht in einer solchen Zone befindet, sollten Sie [einen neuen Worker-Pool erstellen](#add_pool).
*  Wenn Sie über mehrere VLANs für einen Cluster, mehrere Teilnetze in demselben VLAN oder einen Cluster mit mehreren Zonen verfügen, müssen Sie eine [VRF-Funktion (Virtual Router Function)](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud) für Ihr Konto für die IBM Cloud-Infrastruktur (SoftLayer) aktivieren, damit die Workerknoten über das private Netz miteinander kommunizieren können. Zur Aktivierung von VRF [wenden Sie sich an Ihren Ansprechpartner für die IBM Cloud-Infrastruktur (SoftLayer)](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#how-you-can-initiate-the-conversion). Wenn Sie VRF nicht aktivieren können oder wollen, aktivieren Sie das [VLAN-Spanning](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning). Um diese Aktion durchführen zu können, müssen Sie über die [Infrastrukturberechtigung](/docs/containers?topic=containers-users#infra_access) **Netz > VLAN-Spanning im Netz verwalten** verfügen oder Sie können den Kontoeigner bitten, diese zu aktivieren. Zum Prüfen, ob das VLAN-Spanning bereits aktiviert ist, verwenden Sie den [Befehl](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get --region <region>`.

Gehen Sie wie folgt vor, um eine Zone mit Workerknoten zum Worker-Pool hinzuzufügen:

1. Listen Sie die verfügbaren Zonen auf und wählen Sie die Zone aus, die Sie Ihrem Worker-Pool hinzufügen möchten. Die Zone, die Sie auswählen, muss eine mehrzonenfähige Zone sein.
   ```
   ibmcloud ks zones
   ```
   {: pre}

2. Listen Sie die verfügbaren VLANs in dieser Zone auf. Wenn Sie nicht über ein privates oder ein öffentliches VLAN verfügen, wird das VLAN automatisch für Sie erstellt, wenn Sie eine Zone zu Ihrem Worker-Pool hinzufügen.
   ```
   ibmcloud ks vlans --zone <zone>
   ```
   {: pre}

3. Listen Sie die Worker-Pools in Ihrem Cluster auf und notieren Sie deren Namen.
   ```
   ibmcloud ks worker-pools --cluster <clustername_oder_-id>
   ```
   {: pre}

4. Fügen Sie die Zone zu Ihrem Worker-Pool hinzu. Wenn Sie mehrere Worker-Pools haben, fügen Sie die Zone allen Worker-Pools hinzu, sodass Ihr Cluster in allen Zonen ausgeglichen ist. Ersetzen Sie `<pool1_id_or_name,pool2_id_or_name,...>` durch die Namen aller Worker-Pools in einer durch Kommas getrennten Liste.

    Es muss ein privates und ein öffentliches VLAN vorhanden sein, bevor Sie eine Zone zu mehreren Worker-Pools hinzufügen können. Wenn Sie nicht über ein privates und ein öffentliches VLAN in dieser Zone verfügen, fügen Sie zuerst die Zone zu einem Worker-Pool hinzu, sodass ein privates und ein öffentliches VLAN für Sie erstellt wird. Anschließend können Sie die Zone zu anderen Worker-Pools hinzufügen, indem Sie das private und das öffentliche VLAN angeben, das für Sie erstellt wurde.
    {: note}

   Wenn Sie verschiedene VLANs für unterschiedliche Worker-Pools verwenden möchten, wiederholen Sie diesen Befehl für jedes VLAN und die entsprechenden Worker-Pools. Alle neuen Workerknoten werden den von Ihnen angegebenen VLANs hinzugefügt, die VLANs für alle vorhandenen Workerknoten werden jedoch nicht geändert.
   {: tip}
   ```
   ibmcloud ks zone-add --zone <zone> --cluster <clustername_oder_-id> --worker-pools <pool1-name,pool2-name,...> --private-vlan <private_vlan-id> --public-vlan <öffentliche_vlan-id>
   ```
   {: pre}

5. Überprüfen Sie, ob die Zone Ihrem Cluster hinzugefügt wurde. Suchen Sie die hinzugefügte Zone im Feld für die **Workerzonen** der Ausgabe. Beachten Sie, dass die Gesamtanzahl der Worker im Feld für die **Worker** sich erhöht hat, da neue Workerknoten in der hinzugefügten Zone bereitgestellt werden.
  ```
  ibmcloud ks cluster-get --cluster <clustername_oder_-id>
  ```
  {: pre}

  Beispielausgabe:
  ```
  Name:                           mycluster
  ID:                             df253b6025d64944ab99ed63bb4567b6
  State:                          normal
  Created:                        2018-09-28T15:43:15+0000
  Location:                       dal10
  Master URL:                     https://c3.<region>.containers.cloud.ibm.com:30426
  Public Service Endpoint URL:    https://c3.<region>.containers.cloud.ibm.com:30426
  Private Service Endpoint URL:   https://c3-private.<region>.containers.cloud.ibm.com:31140
  Master Location:                Dallas
  Master Status:                  Ready (21 hours ago)
  Ingress Subdomain:              mycluster.us-south.containers.appdomain.cloud
  Ingress Secret:                 mycluster
  Workers:                        6
  Worker Zones:                   dal10, dal12
  Version:                        1.11.3_1524
  Owner:                          owner@email.com
  Resource Group ID:              a8a12accd63b437bbd6d58fb6a462ca7
  Resource Group Name:            Default
  ```
  {: screen}

## Veraltet: Eigenständige Workerknoten hinzufügen
{: #standalone}

Wenn Sie über einen Cluster verfügen, der vor der Einführung von Worker-Pools erstellt wurde, können Sie die veralteten Befehle verwenden, um eigenständige Workerknoten hinzuzufügen.
{: deprecated}

Wenn Sie über einen Cluster verfügen, der nach der Einführung von Worker-Pools erstellt wurde, können Sie keine eigenständigen Workerknoten hinzufügen. Stattdessen können Sie [einen Worker-Pool erstellen](#add_pool), [die Größe eines vorhandenen Worker-Pools ändern](#resize_pool) oder [eine Zone zu einem Worker-Pool hinzufügen](#add_zone), um Workerknoten zu Ihrem Cluster hinzuzufügen.
{: note}

1. Listen Sie die verfügbaren Zonen auf und wählen Sie die Zone aus, in der Sie Workerknoten hinzufügen möchten.
   ```
   ibmcloud ks zones
   ```
   {: pre}

2. Listen Sie die verfügbaren VLANs in dieser Zone auf und notieren Sie ihre ID.
   ```
   ibmcloud ks vlans --zone <zone>
   ```
   {: pre}

3. Listen Sie die verfügbaren Maschinentypen in der Zone auf.
   ```
   ibmcloud ks machine-types --zone <zone>
   ```
   {: pre}

4. Fügen Sie eigenständige Workerknoten zum Cluster hinzu. Geben Sie für Bare-Metal-Maschinentypen `dedicated` an.
   ```
   ibmcloud ks worker-add --cluster <clustername_oder_-id> --workers <anzahl_der_workerknoten> --public-vlan <öffentliche_vlan-id> --private-vlan <private_vlan-id> --machine-type <maschinentyp> --hardware <shared_oder_dedicated>
   ```
   {: pre}

5. Stellen Sie sicher, dass die Workerknoten erstellt werden.
   ```
   ibmcloud ks workers --cluster <clustername_oder_-id>
   ```
   {: pre}

<br />


## Bezeichnungen zu vorhandenen Worker-Pools hinzufügen
{: #worker_pool_labels}

Sie können einem Worker-Pool [bei der Erstellung](#add_pool) eine Bezeichnung zuordnen. Sie können dies aber auch später tun, indem Sie diese Schritte ausführen. Wenn einem Worker-Pool eine Bezeichnung zugeordnet wurde, gilt diese Bezeichnung für alle vorhandenen und nachfolgenden Workerknoten. Sie können Bezeichnungen verwenden, um bestimmte Workloads nur auf Workerknoten im Worker-Pool bereitzustellen, z. B. [Edge-Knoten für den Lastausgleichsnetzverkehr](/docs/containers?topic=containers-edge).
{: shortdesc}

Vorbereitende Schritte: [Melden Sie sich an Ihrem Konto an. Geben Sie, sofern anwendbar, die richtige Ressourcengruppe als Ziel an. Legen Sie den Kontext für den Cluster fest.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

1.  Listen Sie die Worker-Pools in Ihrem Cluster auf.
    ```
    ibmcloud ks worker-pools --cluster <clustername_oder_-id>
    ```
    {: pre}
2.  Um dem Worker-Pool eine Schlüssel/Wert-Bezeichnung (`key=value`) zuzuordnen, verwenden Sie die [PATCH-Worker-Pool-API ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://containers.cloud.ibm.com/global/swagger-global-api/#/clusters/PatchWorkerPool). Formatieren Sie den Hauptteil der Anforderung wie in dem folgenden JSON-Beispiel.

```
    {
      "labels": {"key":"value"},
      "state": "labels"
    }
    ```
    {: codeblock}
3.  Stellen Sie sicher, dass der Worker-Pool und der Workerknoten die Schlüssel/Wert-Bezeichnung (`key=value`) haben, die Sie zugeordnet haben.
    *   Gehen Sie wie folgt vor, um Worker-Pools zu überprüfen:
        ```
        ibmcloud ks worker-pool-get --cluster <clustername_oder_-id> --worker-pool <worker-poolname_oder_-id>
        ```
        {: pre}
    *   Gehen Sie wie folgt vor, um Workerknoten zu überprüfen:
        1.  Listen Sie die Worker-Knoten im Worker-Pool auf und notieren Sie sich die **private IP**.
            ```
            ibmcloud ks workers --cluster <clustername_oder_-id> --worker-pool <worker-poolname_oder_-id>
            ```
            {: pre}
        2.  Überprüfen Sie das Feld **Labels** der Ausgabe.
            ```
            kubectl describe node <private_workerknoten-ip>
            ```
            {: pre}

Nachdem Sie Ihrem Worker-Pool eine Bezeichnung zugeordnet haben, können Sie die [Bezeichnung in Ihren App-Bereitstellungen verwenden](/docs/containers?topic=containers-app#label), sodass Ihre Workloads nur auf diesen Workerknoten ausgeführt werden. Sie können auch [Taints ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/) verwenden, um zu verhindern, dass Bereitstellungen auf diesen Workerknoten ausgeführt werden. 

<br />


## Automatische Wiederherstellung für Ihren Workerknoten
{: #planning_autorecovery}

Kritische Komponenten - wie z. B. `containerd`, `kubelet`, `kube-proxy` und `calico` - müssen richtig ausgeführt werden, damit die Kubernetes-Workerknoten einen einwandfreiem Zustand aufweisen. Im Laufe der Zeit können diese Komponenten kaputt gehen und ihre Workerknoten möglicherweise in einem nicht funktionsbereiten Zustand versetzen. Nicht funktionsbereite Workerknoten verringern die Gesamtkapazität des Clusters und können zu Ausfallzeiten für Ihre App führen.
{:shortdesc}

Sie können [Statusprüfungen für Ihre Workerknoten konfigurieren und die automatische Wiederherstellung aktiveren](/docs/containers?topic=containers-health#autorecovery). Wenn die automatische Wiederherstellung basierend auf den konfigurierten Prüfungen einen nicht ordnungsgemäß funktionierenden Workerknoten erkennt, löst das System eine Korrekturmaßnahme, wie das erneute Laden des Betriebssystems, auf dem Workerknoten aus. Weitere Informationen zur Funktionsweise der automatischen Wiederherstellung finden Sie im [Blogbeitrag zur automatischen Wiederherstellung![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/blogs/bluemix/2017/12/autorecovery-utilizes-consistent-hashing-high-availability/).
