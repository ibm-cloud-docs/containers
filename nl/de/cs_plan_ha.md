---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-19"

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



# Cluster für hohe Verfügbarkeit planen
{: #ha_clusters}

Konzipieren Sie Ihren Standard-Community-Cluster (Kubernetes oder OpenShift) mit {{site.data.keyword.containerlong}} für maximale Verfügbarkeit und Kapazität für Ihre App.
{: shortdesc}

Die Wahrscheinlichkeit, dass Ihre Benutzer Ausfallzeiten verzeichnen, ist geringer, wenn Sie Ihre Apps auf mehrere Workerknoten, Zonen und Cluster verteilen. Integrierte Funktionen wie Lastausgleich (Load Balancing) und Isolation erhöhen die Ausfallsicherheit gegenüber möglichen Fehlerbedingungen mit Hosts, Netzen oder Apps. Betrachten Sie diese potenziellen Clusterkonfigurationen, die nach zunehmendem Grad der Verfügbarkeit angeordnet sind.

![Hochverfügbarkeit für Cluster](images/cs_cluster_ha_roadmap_multizone_public.png)

1. Ein [Einzelzonencluster](#single_zone) mit mehreren Workerknoten in einem Worker-Pool.
2. Ein [Mehrzonencluster](#multizone), der Workerknoten über Zonen hinweg in einer Region verteilt.
3. **Cluster, die nur mit öffentlichen oder privaten VLANs verbunden sind**: [Mehrere Cluster](#multiple_clusters), die über Zonen oder Regionen hinweg eingerichtet werden und über eine globale Lastausgleichsfunktion verbunden sind.

## Einzelzonencluster
{: #single_zone}

Um die Verfügbarkeit für Ihre App zu verbessern und einen Failover für den Fall zu ermöglichen, dass ein Workerknoten in Ihrem Cluster nicht verfügbar ist, fügen Sie Ihrem Einzelzonencluster zusätzliche Workerknoten hinzu.
{: shortdesc}

<img src="images/cs_cluster_singlezone.png" alt="Hochverfügbarkeit für Cluster in einer einzelnen Zone" width="230" style="width:230px; border-style: none"/>

Standardmäßig wird der Einzelzonencluster mit einem Worker-Pool konfiguriert, der den Namen `default` hat. Der Worker-Pool gruppiert Workerknoten mit derselben Konfiguration, wie z. B. dem Maschinentyp, die Sie während der Clustererstellung definiert haben. Sie können Ihrem Cluster weitere Workerknoten hinzufügen, indem Sie [die Größe eines vorhandenen Worker-Pools ändern](/docs/containers?topic=containers-add_workers#resize_pool) oder [einen neuen Worker-Pool hinzufügen](/docs/containers?topic=containers-add_workers#add_pool).

Wenn Sie weitere Workerknoten hinzufügen, können App-Instanzen auf mehrere Workerknoten verteilt werden. Wenn ein Workerknoten ausfällt, werden die App-Instanzen auf den verfügbaren Workerknoten weiter ausgeführt. Kubernetes plant Pods von nicht verfügbaren Workerknoten automatisch neu, um die Leistung und Kapazität für Ihre App zu gewährleisten. Um sicherzustellen, dass die Pods gleichmäßig auf die Workerknoten verteilt werden, implementieren Sie [Pod-Affinität](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#inter-pod-affinity-and-anti-affinity-beta-feature).

**Kann ich einen Einzelzonencluster in einen Mehrzonencluster konvertieren?**</br>
Ja, wenn sich der Cluster in einer der [unterstützten Standorte in einer Mehrzonen-Metropole](/docs/containers?topic=containers-regions-and-zones#zones) befindet. Weitere Informationen finden Sie im Abschnitt [Von eigenständigen Workerknoten auf Worker-Pools aktualisieren](/docs/containers?topic=containers-update#standalone_to_workerpool).


**Muss ich Mehrzonencluster verwenden?**</br>
Nein. Sie können so viele Einzelzonencluster erstellen, wie Sie möchten. Möglicherweise bevorzugen Sie tatsächlich Einzelzonencluster für ein vereinfachtes Management oder für den Fall, dass Ihr Cluster sich in einer bestimmten [Stadt mit einer einzigen Zone](/docs/containers?topic=containers-regions-and-zones#zones) befinden muss.

**Kann ich einen hoch verfügbaren Master in einer Einzelzone haben?**</br>
Ja. In einer Einzelzone ist Ihr Master hoch verfügbar und umfasst Replikate auf separaten physischen Hosts für Ihren Kubernetes-API-Server, für 'etcd', für Ihren Scheduler und Ihren Controller-Manager, um beispielsweise vor Ausfällen während der Aktualisierung eines Masters zu schützen. Für den Schutz vor einem Zonenausfall können Sie Folgendes tun:
* [Erstellen Sie einen Cluster in einer mehrzonenfähigen Zone](#multizone), wobei sich der Master über mehrere Zonen erstreckt.
* [Erstellen Sie mehrere Cluster, die mit öffentlichen und privaten VLANs verbunden sind](#multiple_clusters), und verbinden Sie sie mit einer globalen Lastausgleichsfunktion.

## Mehrzonencluster
{: #multizone}

Mit {{site.data.keyword.containerlong_notm}} können Sie Mehrzonencluster erstellen. Die Wahrscheinlichkeit, dass Ihre Benutzer Ausfallzeiten verzeichnen, ist geringer, wenn Sie Ihre Apps mithilfe von Worker-Pools auf mehrere Workerknoten und Zonen verteilen. Integrierte Funktionen wie der Lastausgleich erhöhen die Ausfallsicherheit bei potenziellen Zonenausfällen mit Hosts, Netzwerken oder Apps. Wenn Ressourcen in einer Zone inaktiv sind, werden Ihre Cluster-Workloads in den anderen Zonen immer noch verarbeitet.
{: shortdesc}

**Was ist ein Worker-Pool?**</br>
Bei einem Worker-Pool handelt es sich um eine Sammlung von Workerknoten mit derselben Version, wie Maschinentyp, CPU und Speicher. Wenn Sie einen Cluster erstellen, wird automatisch ein Worker-Pool für Sie erstellt. Sie können neue `ibmcloud ks worker-pool`-Befehle verwenden, um die Workerknoten in Ihrem Pool über Zonen zu verteilen, Workerknoten zum Pool hinzuzufügen oder Workerknoten zu aktualisieren.

**Kann ich noch eigenständige Workerknoten verwenden?**</br>
Das bisherige Cluster-Setup mit eigenständigen Workerknoten wird zwar noch unterstützt, jedoch nicht mehr weiterentwickelt. Stellen Sie sicher, dass Sie [einen Worker-Pool zu Ihrem Cluster hinzufügen](/docs/containers?topic=containers-planning_worker_nodes#add_pool) und anschließend anstelle von eigenständigen Workerknoten [Worker-Pools verwenden](/docs/containers?topic=containers-update#standalone_to_workerpool), um Ihre Workerknoten zu organisieren.

**Kann ich einen Einzelzonencluster in einen Mehrzonencluster konvertieren?**</br>
Ja, wenn sich der Cluster in einer der [unterstützten Standorte in einer Mehrzonen-Metropole](/docs/containers?topic=containers-regions-and-zones#zones) befindet. Weitere Informationen finden Sie im Abschnitt [Von eigenständigen Workerknoten auf Worker-Pools aktualisieren](/docs/containers?topic=containers-update#standalone_to_workerpool).


### Ich möchte mehr über die Mehrzonenclusterkonfiguration erfahren
{: #mz_setup}

<img src="images/cs_cluster_multizone-ha.png" alt="Hochverfügbarkeit für Mehrzonencluster" width="500" style="width:500px; border-style: none"/>

Sie können zusätzliche Zonen zu Ihrem Cluster hinzufügen, um die Workerknoten in den Worker-Pools über mehrere Zonen in einer Region zu replizieren. Mehrzonencluster sind so konzipiert, dass die Pods gleichmäßig auf die Workerknoten und Zonen verteilt werden, um die Verfügbarkeit und Wiederherstellung nach einem Ausfall zu gewährleisten. Wenn die Workerknoten nicht gleichmäßig über die Zonen verteilt sind oder die Kapazität in einer der Zonen nicht ausreicht, kann der Kubernetes-Scheduler möglicherweise nicht alle angeforderten Pods planen. Daher können Pods in den Status **Anstehend** wechseln, bis eine ausreichende Kapazität verfügbar ist. Wenn Sie das Standardverhalten ändern möchten, damit der Kubernetes-Scheduler Pods in Zonen optimal verteilen kann, verwenden Sie die [Pod-Affinitätsrichtlinie](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#inter-pod-affinity-and-anti-affinity-beta-feature) `preferredDuringSchedulingIgnoredDuringExecution`.

**Warum benötige ich Workerknoten in drei Zonen?** </br>
Durch die Verteilung der Arbeitslast auf drei Zonen wird die hohe Verfügbarkeit Ihrer App für den Fall sichergestellt, dass eine oder zwei Zonen nicht verfügbar sind. Zusätzlich kann eine solche Verteilung Ihr Cluster-Setup auch kosteneffizienter machen. Sie fragen sich, warum das so ist? Hier ist ein Beispiel.

Angenommen, Sie benötigen einen Workerknoten mit sechs Kernen, um die Arbeitslast für Ihre App zu verarbeiten. Für eine höhere Verfügbarkeit Ihres Clusters stehen Ihnen die folgenden Optionen zur Verfügung:

- **Ressourcen in einer anderen Zone duplizieren:** Mit dieser Option erhalten Sie zwei Workerknoten mit jeweils sechs Kernen in jeder Zone, wodurch insgesamt 12 Kerne verfügbar sind. </br>
- **Ressourcen auf drei Zonen verteilen:** Mit dieser Option stellen Sie drei Kerne pro Zone bereit, wodurch Sie eine Gesamtkapazität von neun Kernen erhalten. Um Ihre Arbeitslast verarbeiten zu können, müssen zwei Zonen gleichzeitig aktiv sein. Wenn eine Zone nicht verfügbar ist, können die anderen beiden Zonen die Arbeitslast verarbeiten. Wenn zwei Zonen nicht verfügbar sind, können die drei verbleibenden Kerne die Arbeitslast übernehmen. Durch die Bereitstellung von drei Kernen pro Zone können Sie mit kleineren Maschinen arbeiten und somit Kosten senken.</br>

**Wie wird mein Kubernetes-Master eingerichtet?** </br>
Wenn Sie einen Cluster an einem [Standort in einer Mehrzonen-Metropole](/docs/containers?topic=containers-regions-and-zones#zones) erstellen, wird automatisch ein hoch verfügbarer Kubernetes-Master bereitgestellt und drei Replikate werden über die Zonen der Metropole verteilt. Wenn sich der Cluster beispielsweise in den Zonen `dal10`, `dal12` oder `dal13` befindet, werden die Replikate des Kubernetes-Masters auf alle Zonen in der Mehrzonen-Metropole 'Dallas' verteilt.

**Was passiert, wenn der Kubernetes-Master nicht mehr verfügbar ist?** </br>
Der [Kubernetes-Master](/docs/containers?topic=containers-ibm-cloud-kubernetes-service-technology#architecture) ist die Hauptkomponente, die den Cluster betriebsbereit hält. Der Master speichert Clusterressourcen und ihre Konfigurationen in der etcd-Datenbank, die als Single Point of Truth für Ihren Cluster dient. Der Kubernetes-API-Server dient als Haupteinstiegspunkt für alle Anforderungen der Clusterverwaltung von den Workerknoten zum Master oder wenn Sie mit Ihren Clusterressourcen interagieren möchten.<br><br>Wenn ein Masterausfall auftritt, werden Ihre Workloads weiterhin auf den Workerknoten ausgeführt, Sie können jedoch erst wieder `kubectl`-Befehle verwenden, um mit Ihren Clusterressourcen zu arbeiten oder den Clusterzustand anzuzeigen, wenn der Kubernetes-API-Server im Master wieder betriebsbereit ist. Wenn ein Pod während des Ausfalls des Masters inaktiv ist, kann der Pod erst wieder ausgeführt werden, wenn der Workerknoten den Kubernetes-API-Server wieder erreichen kann.<br><br>Während eines Masterausfalls können Sie `ibmcloud ks`-Befehle weiterhin für die {{site.data.keyword.containerlong_notm}}-API ausführen, um mit Ihren Infrastrukturressourcen zu arbeiten (z. B. Workerknoten oder VLANs). Wenn Sie die aktuelle Clusterkonfiguration ändern, indem Sie Workerknoten zum Cluster hinzufügen oder aus ihm entfernen, werden die Änderungen erst wirksam, wenn der Master wieder betriebsbereit ist.

Ein Workerknoten darf während eines Masterausfalls nicht neu gestartet werden. Durch diese Aktion werden die Pods aus dem Workerknoten entfernt. Da der Kubernetes-API-Server nicht verfügbar ist, können die Pods nicht auf andere Workerknoten im Cluster umgestellt werden.
{: important}


Um Ihren Cluster vor einem Ausfall des Kubernetes-Masters oder in Regionen zu schützen, in denen Mehrzonencluster nicht verfügbar sind, können Sie [mehrere Cluster einrichten, die mit öffentlichen und privaten VLANs verbunden sind, und diese mit einer globalen Lastausgleichsfunktion verbinden](#multiple_clusters).

**Muss ich etwas tun, damit der Master über Zonen hinweg mit den Workern kommunizieren kann?**</br>
Ja. Wenn Sie über mehrere VLANs für einen Cluster, mehrere Teilnetze in demselben VLAN oder einen Cluster mit mehreren Zonen verfügen, müssen Sie eine [VRF-Funktion (Virtual Router Function)](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud) für Ihr Konto für die IBM Cloud-Infrastruktur aktivieren, damit die Workerknoten über das private Netz miteinander kommunizieren können. Zur Aktivierung von VRF [wenden Sie sich an Ihren Ansprechpartner für die IBM Cloud-Infrastruktur](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#how-you-can-initiate-the-conversion). Wenn Sie VRF nicht aktivieren können oder wollen, aktivieren Sie das [VLAN-Spanning](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning). Um diese Aktion durchführen zu können, müssen Sie über die [Infrastrukturberechtigung](/docs/containers?topic=containers-users#infra_access) **Netz > VLAN-Spanning im Netz verwalten** verfügen oder Sie können den Kontoeigner bitten, diese zu aktivieren. Zum Prüfen, ob das VLAN-Spanning bereits aktiviert ist, verwenden Sie den [Befehl](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get --region <region>`.

**Wie kann ich meine Benutzer über das öffentliche Internet auf meine App zugreifen lassen?**</br>
Sie können Ihre Apps über eine Ingress-Lastausgleichsfunktion für Anwendungen (ALB) oder einen LoadBalancer-Service zugänglich machen.

- **Ingress-Lastausgleichsfunktion für Anwendungen (ALB):** Standardmäßig werden öffentliche ALBs automatisch in jeder Zone in Ihrem Cluster erstellt und aktiviert. Außerdem wird auch automatisch eine Cloudflare-Lastausgleichsfunktion für mehrere Zonen (Multizone Load Balancer, MZLB) für Ihren Cluster erstellt und bereitgestellt, sodass eine MZLB für jede Region vorhanden ist. Die MZLB stellt die IP-Adressen Ihrer ALBs hinter denselben Hostnamen und aktiviert die Zustandsprüfungen für diese IP-Adressen, um zu ermitteln, ob sie verfügbar sind oder nicht. Wenn Sie beispielsweise Workerknoten in drei (3) Zonen in der Region 'Vereinigte Staaten (Osten)' haben, hat der Hostname `yourcluster.us-east.containers.appdomain.cloud` drei ALB-IP-Adressen. Der MZLB-Status überprüft die öffentliche ALB-IP in jeder Zone des Clusters und hält die Ergebnisse der DNS-Suche auf der Basis dieser Zustandsprüfungen aktualisiert. Weitere Informationen finden Sie im Abschnitt [Komponenten und Architektur von Ingress](/docs/containers?topic=containers-ingress-about#ingress_components).

- **Lastausgleichsservices:** Lastausgleichsservices werden nur in einer Zone konfiguriert. Eingehende Anforderungen an Ihre App werden von dieser einen Zone an alle App-Instanzen in anderen Zonen weitergeleitet. Wenn diese Zone nicht mehr verfügbar ist, ist Ihre App möglicherweise nicht über das Internet erreichbar. Um einem Ausfall einer einzelnen Zone gerecht zu werden, können Sie zusätzliche LoadBalancer-Services in weiteren Zonen einrichten. Weitere Informationen finden Sie im Abschnitt zu den hoch verfügbaren [LoadBalancer-Services](/docs/containers?topic=containers-loadbalancer#multi_zone_config).

**Kann ich persistenten Speicher für meinen Mehrzonencluster einrichten?**</br>
Verwenden Sie für hoch verfügbaren persistenten Speicher einen Cloud-Service wie [{{site.data.keyword.cloudant_short_notm}}](/docs/services/Cloudant?topic=cloudant-getting-started#getting-started) oder [{{site.data.keyword.cos_full_notm}}](/docs/services/cloud-object-storage?topic=cloud-object-storage-about-ibm-cloud-object-storage). Sie können auch eine SDS-Lösung (SDS - Software-Defined Storage) wie [Portworx](/docs/containers?topic=containers-portworx#portworx) ausprobieren, die [SDS-Maschinen](/docs/containers?topic=containers-planning_worker_nodes#sds) verwendet. Weitere Informationen finden Sie unter [Vergleich der Optionen für persistenten Speicher für Mehrzonencluster](/docs/containers?topic=containers-storage_planning#persistent_storage_overview).

Der NFS-Datei- und -Blockspeicher kann nicht über Zonen hinweg gemeinsam genutzt werden. Persistente Datenträger können nur in der Zone verwendet werden, in der sich die tatsächliche Speichereinheit befindet. Wenn Sie über NFS-Datei- oder -Blockspeicher in Ihrem Cluster verfügen, den Sie weiterhin verwenden möchten, müssen Sie Regions- und Zonenbezeichnungen auf vorhandene persistente Datenträger anwenden. Mithilfe dieser Bezeichnungen kann 'kube-scheduler' bestimmen, wo eine App geplant werden soll, die den persistenten Datenträger verwendet. Führen Sie den folgenden Befehl aus und ersetzen Sie `<meincluster>` durch den Namen Ihres Clusters.

```
bash <(curl -Ls https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/file-pv-labels/apply_pv_labels.sh) <meincluster>
```
{: pre}

** Ich habe meinen Mehrzonencluster erstellt. Warum gibt es immer noch immer nur eine Zone? Wie füge ich meinem Cluster Zonen hinzu?**</br>
Wenn Sie [Ihren Mehrzonencluster mit der CLI erstellen](/docs/containers?topic=containers-clusters#clusters_ui), wird der Cluster zwar erstellt, Sie müssen jedoch Zonen zum Worker-Pool hinzufügen, um den Prozess abzuschließen. Damit sich der Cluster über mehrere Zonen erstreckt, muss er sich an einem [Standort in einer Mehrzonen-Metropole](/docs/containers?topic=containers-regions-and-zones#zones) befinden. Informationen zum Hinzufügen einer Zone zu Ihrem Cluster und zum Verteilen von Workerknoten auf Zonen finden Sie im Abschnitt [Zone zu Ihrem Cluster hinzufügen](/docs/containers?topic=containers-add_workers#add_zone).

### Wie wird sich das zukünftige Management meiner Cluster vom aktuellen Management unterscheiden?
{: #mz_new_ways}

Mit der Einführung von Worker-Pools können Sie eine neue Gruppe von APIs und Befehlen zum Verwalten des Clusters verwenden. Sie finden diese neuen Befehle auf der [Seite mit der CLI-Dokumentation](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli). In Ihrem Terminal können Sie sie durch Ausführen des Befehls `ibmcloud ks help` anzeigen.
{: shortdesc}

In der folgenden Tabelle werden die alten und neuen Methoden für einige allgemeine Aktionen der Clusterverwaltung miteinander verglichen.
<table summary="Die Tabelle enthält die Beschreibung der neuen Vorgehensweisen zum Ausführen von Mehrzonenbefehlen. Die Tabellenzeilen enthalten von links nach rechts die Beschreibung in der ersten Spalte, die alte Vorgehensweise in der zweiten Spalte und die neue Vorgehensweise für Worker-Pools mit mehreren Zonen in der dritten Spalte.">
<caption>Neue Methoden für Befehle für Worker-Pools mit mehreren Zonen.</caption>
  <thead>
  <th>Beschreibung</th>
  <th>Alte eigenständige Workerknoten</th>
  <th>Neue Worker-Pools mit mehreren Zonen</th>
  </thead>
  <tbody>
    <tr>
    <td>Hinzufügen von Workerknoten zum Cluster.</td>
    <td><p class="deprecated"><code>ibmcloud ks worker-add</code> zum Hinzufügen eigenständiger Workerknoten.</p></td>
    <td><ul><li>Um andere Maschinentypen als Ihren vorhandenen Pool hinzuzufügen, erstellen Sie einen neuen Worker-Pool: [Befehl](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_pool_create) <code>ibmcloud ks worker-pool-create</code>.</li>
    <li>Wenn Sie Workerknoten einem vorhandenen Pool hinzufügen möchten, ändern Sie die Anzahl der Knoten pro Zone im Pool: [Befehl](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_pool_resize) <code>ibmcloud ks worker-pool-resize</code>.</li></ul></td>
    </tr>
    <tr>
    <td>Entfernen von Workerknoten aus dem Cluster.</td>
    <td><code>ibmcloud ks worker-rm</code>: Sie können diesen Befehl immer noch zum Löschen eines problematischen Workerknoten aus dem Cluster verwenden.</td>
    <td><ul><li>Wenn ein Worker-Pool nicht ausgeglichen ist, z. B. nach dem Entfernen eines Workerknotens, gleichen Sie ihn neu aus: [Befehl](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_rebalance) <code>ibmcloud ks worker-pool-rebalance</code>.</li>
    <li>Um die Anzahl der Workerknoten in einem Pool zu reduzieren, ändern Sie die Anzahl pro Zone (Mindestwert `1`): [Befehl](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_pool_resize) <code>ibmcloud ks worker-pool-resize</code> .</li></ul></td>
    </tr>
    <tr>
    <td>Verwenden Sie ein neues VLAN für Workerknoten.</td>
    <td><p class="deprecated">Fügen Sie einen neuen Workerknoten hinzu, der das neue private oder öffentliche VLAN verwendet: <code>ibmcloud ks worker-add</code>.</p></td>
    <td>Legen Sie den Worker-Pool so fest, dass er ein anderes öffentliches oder privates VLAN als zuvor verwendet: [Befehl](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_zone_network_set) <code>ibmcloud ks zone-network-set</code>.</td>
    </tr>
  </tbody>
  </table>

## Mehrere öffentliche Cluster, die mit einer globalen Lastausgleichsfunktion verbunden sind
{: #multiple_clusters}

Um Ihre App bei einem Ausfall eines Kubernetes-Masters zu schützen und für Regionen, in denen Mehrzonencluster nicht verfügbar sind, können Sie mehrere Cluster in verschiedenen Zonen in einer Region erstellen und diese mit einer globalen Lastausgleichsfunktion verbinden.
{: shortdesc}

Um mehrere Cluster mit einer globalen Lastausgleichsfunktion zu verbinden, müssen die Cluster mit öffentlichen und privaten VLANs verbunden sein.
{: note}

<img src="images/cs_multiple_cluster_zones.png" alt="Hochverfügbarkeit für mehrere Cluster" width="700" style="width:700px; border-style: none"/>

Um Ihre Arbeitslast auf mehrere Cluster zu verteilen, müssen Sie eine globale Lastausgleichsfunktion einrichten und die öffentlichen IP-Adressen der Lastausgleichsfunktionen für Anwendungen (ALBs) oder LoadBalancer-Services zu Ihrer Domäne hinzufügen. Durch das Hinzufügen dieser IP-Adressen können Sie eingehenden Datenverkehr zwischen Ihren Clustern weiterleiten. Damit die globale Lastausgleichsfunktion erkennen kann, ob einer der Cluster nicht verfügbar ist, sollten Sie in Betracht ziehen, jeder IP-Adresse eine Ping-basierte Statusprüfung hinzuzufügen. Wenn Sie diese Prüfung einrichten, überprüft Ihr DNS-Provider regelmäßig mit Ping die IP-Adressen, die Sie zu Ihrer Domäne hinzugefügt haben. Wenn eine IP-Adresse nicht mehr verfügbar ist, wird der Datenverkehr nicht mehr an diese IP-Adresse gesendet. Kubernetes startet jedoch nicht automatisch erneut Pods von dem nicht verfügbaren Cluster auf Workerknoten in verfügbaren Clustern. Wenn Kubernetes die Pods automatisch in verfügbaren Clustern erneut starten soll, sollten Sie einen [Mehrzonencluster](#multizone) einrichten.

**Warum benötige ich drei Cluster in drei Zonen?** </br>
Ähnlich wie bei der Verwendung von [drei Zonen in Mehrzonenclustern](#multizone) können Sie mehr Verfügbarkeit für Ihre App bereitstellen, indem Sie drei Cluster über Zonen hinweg einrichten. Sie können auch Kosten reduzieren, indem Sie sich kleinere Maschinen für die Verarbeitung Ihrer Arbeitslast anschaffen.

**Was ist, wenn ich mehrere Cluster in mehreren Regionen einrichten möchte?** </br>
Sie können mehrere Cluster in verschiedenen Regionen eines geografischen Standortes (wie 'Vereinigte Staaten (Süden)' und 'Vereinigte Staaten (Osten)') oder über geografische Standorte hinweg ('Vereinigte Staaten (Süden)' und 'Mitteleuropa') einrichten. Beide Setups bieten das gleiche Maß an Verfügbarkeit für Ihre App, sind aber bei der gemeinsamen Nutzung von Daten und der Datenreplikation komplexer als andere Lösungen. In den meisten Fällen reicht es aus, am selben geografischen Standort zu bleiben. Wenn Sie jedoch Benutzer auf der ganzen Welt haben, kann es besser sein, einen Cluster dort einzurichten, wo sich Ihre Benutzer befinden, damit diese keine langen Wartezeiten beim Senden einer Anforderung an Ihre App haben.

**Gehen Sie wie folgt vor, um eine globale Lastausgleichsfunktion für mehrere Cluster einzurichten:**

1. [Erstellen Sie Cluster](/docs/containers?topic=containers-clusters#clusters) in mehreren Zonen oder Regionen.
2. Wenn Sie über mehrere VLANs für einen Cluster, mehrere Teilnetze in demselben VLAN oder einen Cluster mit mehreren Zonen verfügen, müssen Sie eine [VRF-Funktion (Virtual Router Function)](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud) für Ihr Konto für die IBM Cloud-Infrastruktur aktivieren, damit die Workerknoten über das private Netz miteinander kommunizieren können. Zur Aktivierung von VRF [wenden Sie sich an Ihren Ansprechpartner für die IBM Cloud-Infrastruktur](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#how-you-can-initiate-the-conversion). Wenn Sie VRF nicht aktivieren können oder wollen, aktivieren Sie das [VLAN-Spanning](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning). Um diese Aktion durchführen zu können, müssen Sie über die [Infrastrukturberechtigung](/docs/containers?topic=containers-users#infra_access) **Netz > VLAN-Spanning im Netz verwalten** verfügen oder Sie können den Kontoeigner bitten, diese zu aktivieren. Zum Prüfen, ob das VLAN-Spanning bereits aktiviert ist, verwenden Sie den [Befehl](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get --region <region>`.
3. Stellen Sie in jedem Cluster Ihre App mit einer [Lastausgleichsfunktion für Anwendungen (ALB)](/docs/containers?topic=containers-ingress#ingress_expose_public) oder einem [NLB](/docs/containers?topic=containers-loadbalancer)-Service (Netzlastausgleichsfunktion) bereit.
4. Listen Sie für jeden Cluster die öffentlichen IP-Adressen für Ihre ALBs oder NLB-Services auf.
   - Gehen Sie wie folgt vor, um die IP-Adresse aller öffentlichen aktivierten ALBs in Ihrem Cluster aufzulisten:
     ```
     ibmcloud ks albs --cluster <clustername_oder_-id>
     ```
     {: pre}

   - Gehen Sie wie folgt vor, um die IP-Adresse für den NLB-Service aufzulisten:
     ```
     kubectl describe service <mein_service>
     ```
     {: pre}

     Die IP-Adresse für **Load Balancer Ingress** ist die portierbare IP-Adresse, die dem NLB-Service zugewiesen wurde.

4.  Richten Sie eine globale Lastausgleichsfunktion ein, indem Sie {{site.data.keyword.cloud_notm}} Internet Services (CIS) verwenden oder eine eigene globale Lastausgleichsfunktion einrichten.

    **Gehen Sie wie folgt vor, um eine globale CIS-Lastausgleichsfunktion zu verwenden**:
    1.  Richten Sie den Service ein, indem Sie die Schritte 1 bis 5 in der [Einführung in {{site.data.keyword.cloud_notm}} Internet Services (CIS)](/docs/infrastructure/cis?topic=cis-getting-started#getting-started) ausführen. Diese Schritte führen Sie durch die Bereitstellung der Serviceinstanz, das Hinzufügen Ihrer App-Domäne, die Konfiguration Ihrer Namensserver und die Erstellung von DNS-Datensätzen. Erstellen Sie einen DNS-Datensatz für alle IP-Adressen der ALBs oder NLBs, die Sie erfasst haben. Diese DNS-Datensätze ordnen Ihre App-Domäne allen Ihren Cluster-ALBs oder NLBs zu und stellen sicher, dass Anforderungen an Ihre App-Domäne in einem Umlaufzyklus an Ihre Cluster weitergeleitet werden.
    2. [Fügen Sie Statusprüfungen](/docs/infrastructure/cis?topic=cis-set-up-and-configure-your-load-balancers#add-a-health-check) für die ALBs oder NLBs hinzu. Sie können dieselbe Statusprüfung für die ALBs oder NLBs in allen Clustern verwenden oder bestimmte Statusprüfungen erstellen, die für bestimmte Cluster verwendet werden.
    3. [Fügen Sie einen Ursprungspool](/docs/infrastructure/cis?topic=cis-set-up-and-configure-your-load-balancers#add-a-pool) für jeden Cluster hinzu, indem Sie die ALB- oder NLB-IPs des Clusters hinzufügen. Wenn Sie beispielsweise über drei Cluster mit jeweils zwei ALBs verfügen, erstellen Sie drei Ursprungspools, die jeweils zwei ALB-IP-Adressen aufweisen. Fügen Sie jedem Ursprungspool, den Sie erstellen, eine Statusprüfung hinzu.
    4. [Fügen Sie eine globale Lastausgleichsfunktion hinzu](/docs/infrastructure/cis?topic=cis-set-up-and-configure-your-load-balancers#set-up-and-configure-your-load-balancers).

    **Gehen Sie wie folgt vor, um Ihre eigene globale Lastausgleichsfunktion zu verwenden**:
    1. Konfigurieren Sie Ihre Domäne für die Weiterleitung des eingehenden Datenverkehrs an Ihre ALB- oder NLB-Services, indem Sie die IP-Adressen aller öffentlichen aktivierten ALB- und NLB-Services in Ihre Domäne hinzufügen.
    2. Aktivieren Sie für jede IP-Adresse eine Ping-basierte Statusüberprüfung, damit Ihr DNS-Provider fehlerhafte IP-Adressen erkennen kann. Wird eine fehlerhafte IP-Adresse erkannt, wird der Datenverkehr nicht mehr an diese IP-Adresse weitergeleitet.
