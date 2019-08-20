---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

keywords: kubernetes, iks, vlan

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



# Serviceendpunkte oder VLAN-Verbindungen ändern
{: #cs_network_cluster}

Nach der erstmaligen Einrichtung Ihres Netzes während der [Erstellung eines Clusters](/docs/containers?topic=containers-clusters) können Sie die Serviceendpunkte, über die auf Ihren Kubernetes-Master zugegriffen werden kann, oder die VLAN-Verbindungen für Ihre Workerknoten ändern.
{: shortdesc}

## Privaten Serviceendpunkt einrichten
{: #set-up-private-se}

In Clustern mit Kubernetes Version 1.11 oder höher können Sie den privaten Serviceendpunkt für Ihren Cluster aktivieren oder inaktivieren.
{: shortdesc}

Der private Serviceendpunkt macht Ihren Kubernetes-Master privat zugänglich. Ihre Workerknoten und Ihre berechtigten Clusterbenutzer können mit dem Kubernetes-Master über das private Netz kommunizieren. Informationen dazu, ob Sie den privaten Serviceendpunkt aktivieren können, finden Sie unter [Worker-zu-Master- und Benutzer-zu-Master-Kommunikation](/docs/containers?topic=containers-plan_clusters#internet-facing). Beachten Sie, dass Sie den privaten Serviceendpunkt nicht inaktivieren können, nachdem Sie ihn aktiviert haben.

Haben Sie einen Cluster mit nur einem privaten Serviceendpunkt erstellt, bevor Sie Ihr Konto für [VRF](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud) und [Serviceendpunkte](/docs/resources?topic=resources-private-network-endpoints#getting-started) aktiviert haben? Versuchen Sie, [den öffentlichen Serviceendpunkt einzurichten](#set-up-public-se), damit Sie Ihren Cluster verwenden können, bis Ihre Supportfälle zur Aktualisierung Ihres Kontos bearbeitet wurden.
{: tip}

1. Aktivieren Sie [VRF](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud) in Ihrem Konto für die IBM Cloud-Infrastruktur. Zum Prüfen, ob VRF bereits aktiviert ist, verwenden Sie den Befehl `ibmcloud account show`. 
2. [Aktivieren Sie Ihr {{site.data.keyword.cloud_notm}}-Konto zur Verwendung von Serviceendpunkten](/docs/resources?topic=resources-private-network-endpoints#getting-started).
3. Aktivieren Sie den privaten Serviceendpunkt.
   ```
   ibmcloud ks cluster-feature-enable private-service-endpoint --cluster <clustername_oder_-id>
   ```
   {: pre}
4. Aktualisieren Sie den API-Server des Kubernetes-Masters, sodass er den privaten Serviceendpunkt verwendet. Sie können der Eingabeaufforderung in der CLI folgen oder den folgenden Befehl manuell ausführen.
   ```
   ibmcloud ks apiserver-refresh --cluster <clustername_oder_-id>
   ```
   {: pre}

5. [Erstellen Sie eine Konfigurationszuordnung (Configmap)](/docs/containers?topic=containers-update#worker-up-configmap), um die maximale Anzahl von Workerknoten zu steuern, die gleichzeitig in Ihrem Cluster nicht verfügbar sein können. Wenn Sie Ihre Workerknoten aktualisieren, hilft die Konfigurationszuordnung bei der Vermeidung von Ausfallzeiten für Ihre Apps, wenn die Apps ordentlich auf verfügbaren Workerknoten erneut geplant werden.
6. Aktualisieren Sie alle Workerknoten in Ihrem Cluster, um die Konfiguration des privaten Serviceendpunkts aufzunehmen.

   <p class="important">Durch Absetzen des Update-Befehls werden die Workerknoten erneut geladen, um die Konfiguration des Serviceendpunkts aufzunehmen. Wenn keine Workeraktualisierung verfügbar ist, müssen Sie [Workerknoten manuell erneut laden](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli). Wenn Sie erneut laden, stellen Sie sicher, dass Sie die Bestellung abriegeln ('cordon'), entleeren ('drain') und verwalten, um die maximale Anzahl der Workerknoten zu steuern, die gleichzeitig nicht verfügbar sind.</p>
   ```
   ibmcloud ks worker-update --cluster <clustername_oder_-id> --workers <worker1,worker2>
   ```
   {: pre}

8. Wenn sich der Cluster in einer Umgebung hinter einer Firewall befindet:
  * [Lassen Sie zu, dass berechtigte Clusterbenutzer `kubectl`-Befehle ausführen, um auf den Master über den privaten Serviceendpunkt zuzugreifen.](/docs/containers?topic=containers-firewall#firewall_kubectl)
  * [Lassen Sie ausgehenden Netzverkehr an die privaten IP-Adressen](/docs/containers?topic=containers-firewall#firewall_outbound) für Infrastrukturressourcen und für die {{site.data.keyword.cloud_notm}}-Services zu, deren Einsatz Sie planen.

9.  Optional: Wenn Sie nur den privaten Serviceendpunkt verwenden wollen:
    1.  [Inaktivieren Sie den öffentlichen Serviceendpunkt](#disable-public-se).
    2.  [Konfigurieren Sie den Zugriff auf den Master am privaten Serviceendpunkt](/docs/containers?topic=containers-clusters#access_on_prem).


<br />


## Öffentlichen Serviceendpunkt einrichten
{: #set-up-public-se}

Sie können den öffentlichen Serviceendpunkt für Ihren Cluster aktivieren oder inaktivieren.
{: shortdesc}

Der öffentliche Serviceendpunkt macht Ihren Kubernetes-Master öffentlich zugänglich. Ihre Workerknoten und Ihre berechtigten Clusterbenutzer können mit dem Kubernetes-Master sicher über das öffentliche Netz kommunizieren. Weitere Informationen finden Sie unter [Worker-zu-Master- und Benutzer-zu-Master-Kommunikation](/docs/containers?topic=containers-plan_clusters#internet-facing).

**Schritte zur Aktivierung**</br>
Wenn Sie den öffentlichen Endpunkt zuvor inaktiviert haben, können Sie ihn wieder aktivieren.
1. Aktivieren Sie den öffentlichen Serviceendpunkt.
   ```
   ibmcloud ks cluster-feature-enable public-service-endpoint --cluster <clustername_oder_-id>
   ```
   {: pre}
2. Aktualisieren Sie den API-Server des Kubernetes-Masters, sodass er den öffentlichen Serviceendpunkt verwendet. Sie können der Eingabeaufforderung in der CLI folgen oder den folgenden Befehl manuell ausführen.
   ```
   ibmcloud ks apiserver-refresh --cluster <clustername_oder_-id>
   ```
   {: pre}
3. [Erstellen Sie eine Konfigurationszuordnung (Configmap)](/docs/containers?topic=containers-update#worker-up-configmap), um die maximale Anzahl von Workerknoten zu steuern, die gleichzeitig in Ihrem Cluster nicht verfügbar sein können. Wenn Sie Ihre Workerknoten aktualisieren, hilft die Konfigurationszuordnung bei der Vermeidung von Ausfallzeiten für Ihre Apps, wenn die Apps ordentlich auf verfügbaren Workerknoten erneut geplant werden.
4. Aktualisieren Sie alle Workerknoten in Ihrem Cluster, um die Konfiguration des öffentlichen Serviceendpunkts zu entfernen. <p class="important">Durch Absetzen des Update-Befehls werden die Workerknoten erneut geladen, um die Konfiguration des Serviceendpunkts aufzunehmen. Wenn keine Workeraktualisierung verfügbar ist, müssen Sie die Workerknoten manuell mit dem [Befehl](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_reload) `ibmcloud ks worker-reload` erneut laden. Wenn Sie erneut laden, stellen Sie sicher, dass Sie die Bestellung abriegeln ('cordon'), entleeren ('drain') und verwalten, um die maximale Anzahl der Workerknoten zu steuern, die gleichzeitig nicht verfügbar sind.</p>
   ```
   ibmcloud ks worker-update --cluster <clustername_oder_-id> --workers <worker1,worker2>
   ```
  {: pre}
   </br>

{: #disable-public-se}
**Schritte zur Inaktivierung**</br>
Zum Inaktivieren des öffentlichen Serviceendpunkts müssen Sie zuerst den privaten Serviceendpunkt aktivieren, sodass Ihre Workerknoten mit dem Kubernetes-Master kommunizieren können.
1. [Aktivieren Sie den privaten Serviceendpunkt.](#set-up-private-se).
2. Inaktivieren Sie den öffentlichen Serviceendpunkt.
   ```
   ibmcloud ks cluster-feature-disable public-service-endpoint --cluster <clustername_oder_-id>
   ```
   {: pre}
3. Aktualisieren Sie den API-Server des Kubernetes-Masters, sodass er den öffentlichen Serviceendpunkt entfernt, indem Sie der CLI-Eingabeaufforderung folgen oder den folgenden Befehl manuell ausführen.
   ```
   ibmcloud ks apiserver-refresh --cluster <clustername_oder_-id>
   ```
   {: pre}
4. [Erstellen Sie eine Konfigurationszuordnung (Configmap)](/docs/containers?topic=containers-update#worker-up-configmap), um die maximale Anzahl von Workerknoten zu steuern, die gleichzeitig in Ihrem Cluster nicht verfügbar sein können. Wenn Sie Ihre Workerknoten aktualisieren, hilft die Konfigurationszuordnung bei der Vermeidung von Ausfallzeiten für Ihre Apps, wenn die Apps ordentlich auf verfügbaren Workerknoten erneut geplant werden.
5. Aktualisieren Sie alle Workerknoten in Ihrem Cluster, um die Konfiguration des öffentlichen Serviceendpunkts zu entfernen. <p class="important">Durch Absetzen des Update-Befehls werden die Workerknoten erneut geladen, um die Konfiguration des Serviceendpunkts aufzunehmen. Wenn keine Workeraktualisierung verfügbar ist, müssen Sie die Workerknoten manuell mit dem [Befehl](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_reload) `ibmcloud ks worker-reload` erneut laden. Wenn Sie erneut laden, stellen Sie sicher, dass Sie die Bestellung abriegeln ('cordon'), entleeren ('drain') und verwalten, um die maximale Anzahl der Workerknoten zu steuern, die gleichzeitig nicht verfügbar sind.</p>
   ```
   ibmcloud ks worker-update --cluster <clustername_oder_-id> --workers <worker1,worker2>
   ```
  {: pre}

## Vom öffentlichen Serviceendpunkt zum privaten Serviceendpunkt wechseln
{: #migrate-to-private-se}

In Clustern mit Kubernetes Version 1.11 oder höher können Sie Workerknoten zur Kommunikation mit dem Master über das private Netz anstelle des öffentlichen Netzes einrichten, indem Sie den privaten Serviceendpunkt aktivieren.
{: shortdesc}

Alle Cluster, die mit einem öffentlichen und einem privaten VLAN verbunden sind, verwenden standardmäßig den öffentlichen Serviceendpunkt. Ihre Workerknoten und Ihre berechtigten Clusterbenutzer können mit dem Kubernetes-Master sicher über das öffentliche Netz kommunizieren. Um Workerknoten für die Kommunikation mit dem Kubernetes-Master über das private Netz anstelle des öffentlichen Netzes einzurichten, können Sie den privaten Serviceendpunkt aktivieren. Anschließend können Sie optional den öffentlichen Serviceendpunkt inaktivieren.
* Wenn Sie den privaten Serviceendpunkt aktivieren und den öffentlichen Serviceendpunkt behalten, kommunizieren Worker mit dem Master immer über das private Netz, während Ihre Benutzer mit dem Master entweder über das öffentliche oder über das private Netz kommunizieren können.
* Wenn Sie den privaten Serviceendpunkt aktivieren, jedoch den öffentlichen Serviceendpunkt inaktivieren, müssen Worker und Benutzer mit dem Master über das private Netz kommunizieren.

Beachten Sie, dass Sie den privaten Serviceendpunkt nicht inaktivieren können, nachdem Sie ihn aktiviert haben.

1. Aktivieren Sie [VRF](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud) in Ihrem Konto für die IBM Cloud-Infrastruktur. Zum Prüfen, ob VRF bereits aktiviert ist, verwenden Sie den Befehl `ibmcloud account show`. 
2. [Aktivieren Sie Ihr {{site.data.keyword.cloud_notm}}-Konto zur Verwendung von Serviceendpunkten](/docs/resources?topic=resources-private-network-endpoints#getting-started).
3. Aktivieren Sie den privaten Serviceendpunkt.
   ```
   ibmcloud ks cluster-feature-enable private-service-endpoint --cluster <clustername_oder_-id>
   ```
   {: pre}
4. Aktualisieren Sie den API-Server des Kubernetes-Masters, sodass er den privaten Serviceendpunkt verwendet, indem Sie der CLI-Eingabeaufforderung folgen oder den folgenden Befehl manuell ausführen.
   ```
   ibmcloud ks apiserver-refresh --cluster <clustername_oder_-id>
   ```
   {: pre}
5. [Erstellen Sie eine Konfigurationszuordnung (Configmap)](/docs/containers?topic=containers-update#worker-up-configmap), um die maximale Anzahl von Workerknoten zu steuern, die gleichzeitig in Ihrem Cluster nicht verfügbar sein können. Wenn Sie Ihre Workerknoten aktualisieren, hilft die Konfigurationszuordnung bei der Vermeidung von Ausfallzeiten für Ihre Apps, wenn die Apps ordentlich auf verfügbaren Workerknoten erneut geplant werden.

6.  Aktualisieren Sie alle Workerknoten in Ihrem Cluster, um die Konfiguration des privaten Serviceendpunkts aufzunehmen.

    <p class="important">Durch Absetzen des Update-Befehls werden die Workerknoten erneut geladen, um die Konfiguration des Serviceendpunkts aufzunehmen. Wenn keine Workeraktualisierung verfügbar ist, müssen Sie [Workerknoten manuell erneut laden](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli). Wenn Sie erneut laden, stellen Sie sicher, dass Sie die Bestellung abriegeln ('cordon'), entleeren ('drain') und verwalten, um die maximale Anzahl der Workerknoten zu steuern, die gleichzeitig nicht verfügbar sind.</p>
    ```
    ibmcloud ks worker-update --cluster <clustername_oder_-id> --workers <worker1,worker2>
    ```
    {: pre}

7.  Optional: Wenn Sie nur den privaten Serviceendpunkt verwenden wollen:
    1.  Inaktivieren Sie den öffentlichen Serviceendpunkt.
        ```
        ibmcloud ks cluster-feature-disable public-service-endpoint --cluster <clustername_oder_-id>
        ```
        {: pre}
    2.  [Konfigurieren Sie den Zugriff auf den Master am privaten Serviceendpunkt](/docs/containers?topic=containers-clusters#access_on_prem).

<br />


## VLAN-Verbindungen für Workerknoten ändern
{: #change-vlans}

Wenn Sie einen Cluster erstellen, wählen Sie aus, ob Ihre Workerknoten mit einem privaten und einem öffentlichen VLAN oder nur mit einem privaten VLAN verbunden werden sollen. Ihre Workerknoten gehören zu Worker-Pools, die Netzmetadaten speichern, die die VLANs enthalten, die zur Bereitstellung zukünftiger Workerknoten im Pool verwendet werden sollen. Sie haben die Möglichkeit, die Einrichtung der VLAN-Konnektivität Ihres Clusters später zu ändern, wie zum Beispiel in folgenden Fällen.
{: shortdesc}

* Die Kapazität der VLANs für den Worker-Pool in einer Zone wird knapp und Sie müssen ein neues VLAN bereitstellen, das Ihre Cluster-Workerknoten verwenden können.
* Sie haben einen Cluster mit Workerknoten, die sich sowohl in öffentlichen als auch in privaten VLANs befinden, Sie wollen jedoch zu einem [rein privaten Cluster](/docs/containers?topic=containers-plan_clusters#private_clusters) wechseln.
* Sie haben einen reinen privaten Cluster, Sie wollen jedoch einige Workerknoten als Worker-Pool von [Edge-Knoten](/docs/containers?topic=containers-edge#edge) im öffentlichen VLAN haben, um Ihre Apps im Internet zugänglich zu machen.

Versuchen Sie stattdessen den Serviceendpunkt für die Kommunikation zwischen Master- und Workerknoten zu ändern? Prüfen Sie die Abschnitte zur Einrichtung [öffentlicher](#set-up-public-se) und [privater](#set-up-private-se) Serviceendpunkte.
{: tip}

Vorbereitende Schritte:
* [Melden Sie sich an Ihrem Konto an. Geben Sie, sofern anwendbar, die richtige Ressourcengruppe als Ziel an. Legen Sie den Kontext für den Cluster fest.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)
* Wenn Ihre Workerknoten eigenständig sind (nicht zu einem Worker-Pool gehören), [aktualisieren Sie sie zu Worker-Pools](/docs/containers?topic=containers-update#standalone_to_workerpool).

Gehen Sie wie folgt vor, um die VLANs zu ändern, die ein Worker-Pool zur Bereitstellung von Workerknoten verwendet:

1. Listen Sie die Namen der Worker-Pools in Ihrem Cluster auf.
  ```
  ibmcloud ks worker-pools --cluster <clustername_oder_-id>
  ```
  {: pre}

2. Bestimmen Sie die Zonen für einen der Worker-Pools. Suchen Sie in der Ausgabe nach dem Feld **Zones**.
  ```
  ibmcloud ks worker-pool-get --cluster <clustername_oder_-id> --worker-pool <poolname>
  ```
  {: pre}

3. Ermitteln Sie für jede Zone, die Sie im vorherigen Schritt gefunden haben, ein verfügbares öffentliches VLAN und ein verfügbares privates VLAN, die miteinander kompatibel sind.

  1. Prüfen Sie die verfügbaren öffentlichen und privaten VLANs, die unter **Type** in der Ausgabe aufgelistet werden.
     ```
     ibmcloud ks vlans --zone <zone>
     ```
     {: pre}

  2. Prüfen Sie, ob die öffentlichen und privaten VLANs in der Zone kompatibel sind. Um kompatibel zu sein, muss der **Router** dieselbe Pod-ID aufweisen. In der folgenden Beispielausgabe stimmen die Pod-IDs für **Router** überein: `01a` und `01a`. Wenn eine Pod-ID `01a` und die andere Pod-ID `02a` ist, können Sie diese öffentlichen und privaten VLAN-IDs nicht für Ihren Worker-Pool festlegen.
     ```
     ID        Name   Number   Type      Router         Supports Virtual Workers
    229xxxx          1234     private   bcr01a.dal12   true
    229xxxx          5678     public    fcr01a.dal12   true
     ```
     {: screen}

  3. Wenn Sie ein neues öffentliches oder privates VLAN für die Zone bestellen müssen, können Sie über die [{{site.data.keyword.cloud_notm}}-Konsole](/docs/infrastructure/vlans?topic=vlans-ordering-premium-vlans#ordering-premium-vlans) bestellen oder den folgenden Befehl verwenden. Beachten Sie, dass die VLANs mit übereinstimmenden Pod-IDs für **Router** wie im vorherigen Schritt kompatibel sein müssen. Wenn Sie ein Paar aus einem neuen öffentlichen VLAN und einem neuen privaten VLAN erstellen, müssen diese miteinander kompatibel sein.
     ```
     ibmcloud sl vlan create -t [public|private] -d <zone> -r <kompatibler_router>
     ```
     {: pre}

  4. Notieren Sie die IDs der kompatiblen VLANs.

4. Richten Sie einen Worker-Pool mit den neuen VLAN-Netzmetadaten für jede Zone ein. Sie können einen neuen Worker-Pool erstellen oder einen vorhandenen Worker-Pool ändern.

  * **Neuen Worker-Pool erstellen:** Siehe [Workerknoten durch Erstellen eines neuen Worker-Pools hinzufügen](/docs/containers?topic=containers-add_workers#add_pool).

  * **Vorhandenen Worker-Pool ändern:** Legen Sie die Netzmetadaten des Worker-Pools zur Verwendung des VLAN für jede Zone fest. Workerknoten, die bereits im Pool erstellt wurden, verwenden weiterhin die vorherigen VLANs, während neue Workerknoten im Pool die neuen VLAN-Metadaten verwenden, die Sie festlegen.

    * Beispiel für das Hinzufügen eines öffentlichen und eines privaten VLAN wie beim Wechseln von einer rein privaten Netzkonfiguration zu einer privaten und öffentlichen Netzkonfiguration:
      ```
      ibmcloud ks zone-network-set --zone <zone> --cluster <clustername_oder_-id> --worker-pools <poolname> --private-vlan <id_des_privaten_vlan> --public-vlan <id_des_öffentlichen_vlan>
      ```
      {: pre}

    * Beispiel für das Hinzufügen eines privaten VLAN wie beim Wechsel von öffentlichen und privaten VLANs zu nur privaten, wenn Sie ein [VRF-aktiviertes Konto, das Serviceendpunkte verwendet,](/docs/resources?topic=resources-private-network-endpoints#getting-started) haben:
      ```
      ibmcloud ks zone-network-set --zone <zone> --cluster <clustername_oder_-id> --worker-pools <poolname> --private-vlan <id_des_privaten_vlan> --public-vlan <id_des_öffentlichen_vlan>
      ```
      {: pre}

5. Fügen Sie dem Worker-Pool Workerknoten hinzu, indem Sie die Größe des Pools ändern.
   ```
   ibmcloud ks worker-pool-resize --cluster <clustername_oder_-id> --worker-pool <poolname>  --size-per-zone <anzahl_der_worker_pro_zone>
   ```
   {: pre}

   Wenn Sie Workerknoten, die die vorherigen Netzmetadaten verwenden, entfernen wollen, ändern Sie die Anzahl der Worker pro Zone, um die vorherige Anzahl der Worker pro Zone zu verdoppeln. In späteren dieser Schritte können Sie die vorherigen Workerknoten abriegeln ('cordon'), entleeren ('drain') und entfernen.
  {: tip}

6. Überprüfen Sie in der Ausgabe, ob die neuen Workerknoten mit den entsprechenden Werten für **Public IP** und **Private IP** erstellt wurden. Beispiel: Wenn Sie den Worker-Pool von einem öffentlichen und privaten VLAN in ein nur privates VLAN ändern, haben die neuen Workerknoten nur eine private IP-Adresse. Wenn Sie den Worker-Pool von nur privaten VLANs in öffentliche und private VLANs ändern, haben die Workerknoten sowohl öffentliche als auch private IP-Adressen.
   ```
   ibmcloud ks workers --cluster <clustername_oder_-id> --worker-pool <poolname>
   ```
   {: pre}

7. Optional: Entfernen Sie die Workerknoten mit den vorherigen Netzmetadaten aus dem Worker-Pool.
  1. Notieren Sie in der Ausgabe des vorherigen Schritts die Werte für **ID** und **Private IP** der Workerknoten, die Sie aus dem Worker-Pool entfernen wollen.
  2. Markieren Sie den Workerknoten in einem Prozess, der als Abriegelung oder "Cordoning" bezeichnet wird, als nicht planbar ("unschedulable"). Wenn Sie einen Workerknoten abriegeln, ist er für die künftige Pod-Planung nicht mehr verfügbar.
     ```
     kubectl cordon <private_ip_des_workerknotens>
     ```
     {: pre}
  3. Überprüfen Sie, ob die Pod-Planung für Ihren Workerknoten inaktiviert ist
     ```
     kubectl get nodes
     ```
     {: pre}
     Ihr Workerknoten ist für die Pod-Planung inaktiviert, wenn der Status **`SchedulingDisabled`** angezeigt wird.
  4. Erzwingen Sie, dass Pods aus Ihrem Workerknoten entfernt und auf den verbleibenden Workerknoten im Cluster erneut geplant werden.
     ```
     kubectl drain <private_ip_des_workerknotens>
     ```
     {: pre}
     Dieser Prozess kann einige Minuten dauern.
  5. Entfernen Sie den Workerknoten. Verwenden Sie die Worker-ID, die Sie zuvor abgerufen haben.
     ```
     ibmcloud ks worker-rm --cluster <clustername_oder_-id> --worker <workername_oder_-id>
     ```
     {: pre}
  6. Überprüfen Sie, ob der Workerknoten entfernt wurde.
     ```
     ibmcloud ks workers --cluster <clustername_oder_-id> --worker-pool <poolname>
     ```
     {: pre}

8. Optional: Sie können die Schritte 2 bis 7 für jeden Worker-Pool in Ihrem Cluster wiederholen. Nachdem Sie diese Schritte ausgeführt haben, sind alle Workerknoten in Ihrem Cluster mit den neuen VLANs eingerichtet.

10. Optional: Wenn Sie die Teilnetze in den alten VLANs nicht mehr benötigen, können Sie sie [entfernen](/docs/containers?topic=containers-subnets#remove-subnets).
