---

copyright:
  years: 2014, 2019
lastupdated: "2019-06-11"

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



# Konfiguration Ihres Workerknotens planen
{: #planning_worker_nodes}

Ein Kubernetes-Cluster besteht aus Workerknoten, die in Worker-Pools gruppiert sind und zentral vom Kubernetes-Master überwacht und verwaltet werden. Clusteradministratoren entscheiden, wie sie den Cluster aus Workerknoten einrichten, um sicherzustellen, dass den Clusterbenutzern alle Ressourcen für die Bereitstellung und Ausführung von Apps im Cluster zur Verfügung stehen.
{:shortdesc}

Wenn Sie einen Standardcluster erstellen, werden die Workerknoten mit denselben Speicher-, CPU- und Plattenspeicherspezifikationen (Typ) in Ihrer IBM Cloud-Infrastruktur (SoftLayer) in Ihrem Namen bestellt und dem Standard-Worker-Pool in Ihrem Cluster hinzugefügt. Jedem Workerknoten werden eine eindeutige Workerknoten-ID und ein Domänenname zugewiesen, die nach dem Erstellen des Clusters nicht geändert werden dürfen. Sie können zwischen virtuellen oder physischen Servern (Bare-Metal-Servern) wählen. Abhängig von dem ausgewählten Grad an Hardware-Isolation können virtuelle Workerknoten als gemeinsam genutzte oder als dedizierte Knoten eingerichtet werden. Wenn Sie Ihrem Cluster unterschiedliche Typen hinzufügen möchten, [erstellen Sie einen weiteren Worker-Pool](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_pool_create).

Kubernetes beschränkt die maximale Anzahl von Workerknoten, die in einem Cluster vorhanden sein können. Weitere Informationen finden Sie unter [Worker node and pod quotas ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/setup/cluster-large/).


Wollen Sie sichergehen, dass Sie immer ausreichend Workerknoten für Ihre Workload zur Verfügung haben? Probieren Sie den [Cluster-Autoscaler](/docs/containers?topic=containers-ca#ca) aus.
{: tip}

<br />


## Verfügbare Hardware für Workerknoten
{: #shared_dedicated_node}

Wenn Sie einen Standardcluster in {{site.data.keyword.Bluemix_notm}} erstellen, wählen Sie, ob Ihre Worker-Pools aus Workerknoten bestehen, die entweder physische Maschinen (Bare-Metal-Maschinen) sind oder die virtuelle Maschinen sind, die auf physischer Hardware ausgeführt werden. Sie wählen außerdem den Typ des Workerknotens oder die Kombination aus Speicher-, CPU- und anderen Maschinenspezifikationen (wie z. B. Plattenspeicher).
{:shortdesc}

<img src="images/cs_clusters_hardware.png" width="700" alt="Hardwareoptionen für Workerknoten in einem Standardcluster" style="width:700px; border-style: none"/>

Wenn Sie mehr als einen Typ des Workerknotens benötigen, müssen Sie für jeden Typ einen Worker-Pool erstellen. Sie können vorhandene Workerknoten in ihrer Größe nicht ändern, um andere Ressourcen wie CPU und Hauptspeicher zu erhalten. Wenn Sie einen kostenlosen Cluster erstellen, wird Ihr Workerknoten automatisch als gemeinsam genutzter, virtueller Knoten im Konto der IBM Cloud-Infrastruktur (SoftLayer) bereitgestellt. In Standardclustern können Sie den Typ der Maschine auswählen, der sich am besten für Ihre Workload eignet. Berücksichtigen Sie bei Ihrer Planung die [Reserven für Workerknotenressourcen](#resource_limit_node) bei der Gesamt-CPU und der Speicherkapazität.

Wählen Sie eine der folgenden Optionen aus, um zu entscheiden, welchen Typ von Worker-Pool Sie wünschen.
* [Virtuelle Maschinen](#vm)
* [Physische Maschinen (Bare-Metal-Maschinen)](#bm)
* [SDS-Maschinen (Software-defined Storage)](#sds)

## Virtuelle Maschinen
{: #vm}

Virtuelle Maschinen bieten eine größere Flexibilität, schnellere Bereitstellungszeiten und mehr automatische Skalierbarkeitsfunktionen als Bare-Metal-Maschinen und sind zudem kostengünstiger. Sie können virtuelle Maschinen für die meisten allgemeinen Anwendungsfälle, wie Test- und Entwicklungsumgebungen, Staging- und Produktionsumgebungen, Microservices und Business-Apps, verwenden. Allerdings müssen bei der Leistung Kompromisse gemacht werden. Wenn Sie für RAM-, GPU- oder datenintensive Workloads eine Datenverarbeitung mit hoher Leistung benötigen, verwenden Sie [Bare-Metal-Maschinen](#bm).
{: shortdesc}

**Soll gemeinsam genutzte oder dedizierte Hardware verwendet werden?**</br>
Wenn Sie einen virtuellen Standardcluster erstellen, müssen Sie auswählen, ob die zugrunde liegende Hardware von mehreren {{site.data.keyword.IBM_notm}} Kunden gemeinsam genutzt werden kann (Multi-Tenant-Konfiguration) oder ob Sie die ausschließlich Ihnen vorbehaltene, dedizierte Nutzung vorziehen (Single-Tenant-Konfiguration).

* **In einer Multi-Tenant-Konfiguration mit gemeinsam genutzter Hardware**: Physische Ressourcen wie CPU und Speicher werden von allen virtuellen Maschinen, die auf derselben physischen Hardware bereitgestellt werden, gemeinsam genutzt. Um sicherzustellen, dass jede virtuelle Maschine unabhängig von anderen Maschinen ausgeführt werden kann, segmentiert ein VM-Monitor, d. h. eine Überwachungsfunktion für virtuelle Maschinen, die auch als Hypervisor bezeichnet wird, die physischen Ressourcen in isolierte Entitäten und ordnet diese einer virtuellen Maschine als dedizierte Ressourcen zu. Dies wird als Hypervisor-Isolation bezeichnet.
* **In einer Single-Tenant-Konfiguration mit dedizierter Hardware**: Die Nutzung aller physischen Ressourcen ist ausschließlich Ihnen vorbehalten. Sie können mehrere Workerknoten als virtuelle Maschinen auf demselben physischen Host bereitstellen. Ähnlich wie bei der Multi-Tenant-Konfiguration stellt der Hypervisor auch hier sicher, dass jeder Workerknoten seinen Anteil an den verfügbaren physischen Ressourcen erhält.

Gemeinsam genutzte Knoten sind in der Regel kostengünstiger als dedizierte Knoten, weil die Kosten für die ihnen zugrunde liegende Hardware von mehreren Kunden getragen werden. Bei der Entscheidungsfindung hinsichtlich gemeinsam genutzter Knoten versus dedizierter Knoten sollten Sie mit Ihrer Rechtsabteilung Rücksprache halten, um zu klären, welcher Grad an Infrastrukturisolation und Compliance für Ihre App-Umgebung erforderlich ist.

Einige Typen sind nur für einen Typ von Tenant-Setup verfügbar. Zum Beispiel sind VMs vom Typ `m3c` nur als Tenant-Setup `shared` verfügbar.
{: note}

**Was sind die allgemeinen Features von VMs?**</br>
Virtuelle Maschinen verwenden lokale Platten anstelle von SAN (Storage Area Networking) für die Zuverlässigkeit. Zu den Vorteilen zählen ein höherer Durchsatz beim Serialisieren von Bytes für die lokale Festplatte und weniger Beeinträchtigungen des Dateisystems aufgrund von Netzausfällen. Jede VM bietet eine Netzgeschwindigkeit von 1000 MB/s, 25 GB primären lokalen Plattenspeicher für das Dateisystem des Betriebssystems und 100 GB sekundären lokalen Plattenspeicher für Daten, wie z. B. die Containerlaufzeit und `kubelet`. Der lokale Speicher auf dem Workerknoten ist nur für die kurzfristige Verarbeitung vorgesehen; die primäre und die sekundäre Platte werden gelöscht, wenn Sie den Workerknoten aktualisieren oder erneut laden. Informationen zu persistenten Speicherlösungen finden Sie im Abschnitt [Persistenten Hochverfügbarkeitsspeicher planen](/docs/containers?topic=containers-storage_planning#storage_planning).

**Was passiert, wenn meine Maschinentypen älter sind?**</br>
Wenn Ihr Cluster über die veralteten `x1c`- (oder ältere) Ubuntu 16 `x2c`-Workerknoten-Typen verfügt, können Sie Ihren [Cluster auf Ubuntu 18 `x3c`-Workerknoten aktualisieren](/docs/containers?topic=containers-update#machine_type).

**Welche Typen sind bei virtuellen Maschinen verfügbar?**</br>
Die Typen der Workerknoten variieren je nach Zone. Die folgende Tabelle enthält die neueste Version des jeweiligen Typs, z. B. `x3c` Ubuntu 18-Workerknoten-Typen, im Gegensatz zu den älteren `x2c` Ubuntu 16-Workerknoten-Typen. Um die in Ihrer Zone verfügbaren Maschinentypen anzuzeigen, führen Sie den Befehl `ibmcloud ks machine-types <zone>` aus. Sie können sich außerdem die verfügbaren [Bare-Metal](#bm)- oder [SDS](#sds)-Maschinentypen ansehen.

{: #vm-table}
<table>
<caption>Verfügbare virtuelle Maschinentypen in {{site.data.keyword.containerlong_notm}}.</caption>
<thead>
<th>Name und Anwendungsfall</th>
<th>Kerne/Speicher</th>
<th>Primäre/Sekundäre Platte</th>
<th>Netzgeschwindigkeit</th>
</thead>
<tbody>
<tr>
<td><strong>Virtuell, u3c.2x4</strong>: Verwenden Sie diese kompakte virtuelle Maschine für Schnelltests, Machbarkeitsnachweise und andere geringe Workloads.</td>
<td>2/4 GB</td>
<td>25 GB/100 GB</td>
<td>1000 Mbit/s</td>
</tr>
<tr>
<td><strong>Virtuell, b3c.4x16</strong>: Wählen Sie diese ausgeglichene virtuelle Maschine für Tests und Entwicklung und andere geringe Workloads.</td>
<td>4/16 GB</td>
<td>25 GB/100 GB</td>
<td>1000 Mbit/s</td>
</tr>
<tr>
<td><strong>Virtuell, b3c.16x64</strong>: Wählen Sie diese ausgeglichene virtuelle Maschine für mittlere Workloads aus.</td></td>
<td>16/64 GB</td>
<td>25 GB/100 GB</td>
<td>1000 Mbit/s</td>
</tr>
<tr>
<td><strong>Virtuell, b3c.32x128</strong>: Wählen Sie diese ausgeglichene virtuelle Maschine für mittlere bis große Workloads, wie eine Datenbank und eine dynamische Website mit vielen gleichzeitigen Benutzern, aus.</td>
<td>32/128 GB</td>
<td>25 GB/100 GB</td>
<td>1000 Mbit/s</td>
</tr>
<tr>
<td><strong>Virtuell, c3c.16x16</strong>: Verwenden Sie diesen Typ, wenn Sie eine gleichmäßige Verteilung der Rechenressourcen vom Workerknoten für geringe Workloads wünschen.</td>
<td>16/16 GB</td>
<td>25 GB/100 GB</td>
<td>1000 Mbit/s</td>
</tr><tr>
<td><strong>Virtuell, c3c.16x32</strong>: Verwenden Sie diesen Typ, wenn Sie ein 1:2-Verhältnis von CPU- und Speicherressourcen vom Workerknoten für geringe bis mittlere Workloads wünschen.</td>
<td>16/32 GB</td>
<td>25 GB/100 GB</td>
<td>1000 Mbit/s</td>
</tr><tr>
<td><strong>Virtuell, c3c.32x32</strong>: Verwenden Sie diesen Typ, wenn Sie eine gleichmäßige Verteilung der Rechenressourcen vom Workerknoten für mittlere Workloads wünschen.</td>
<td>32/32 GB</td>
<td>25 GB/100 GB</td>
<td>1000 Mbit/s</td>
</tr><tr>
<td><strong>Virtuell, c3c.32x64</strong>: Verwenden Sie diesen Typ, wenn Sie ein 1:2-Verhältnis von CPU- und Speicherressourcen vom Workerknoten für mittlere Workloads wünschen.</td>
<td>32/ 4 GB</td>
<td>25 GB/100 GB</td>
<td>1000 Mbit/s</td>
</tr>
<tr>
<td><strong>Virtuell, m3c.8x64</strong>: Verwenden Sie diesen Typ, wenn Sie ein 1:8-Verhältnis von CPU- und Speicherressourcen für geringe bis mittlere Workloads wünschen, die mehr Hauptspeicher erfordern, zum Beispiel Datenbanken wie {{site.data.keyword.Db2_on_Cloud_short}}. Nur in Dallas und als Tenant-Setup `--hardware shared` verfügbar.</td>
<td>8/64 GB</td>
<td>25 GB/100 GB</td>
<td>1000 Mbit/s</td>
</tr><tr>
<td><strong>Virtuell, m3c.16x128</strong>: Verwenden Sie diesen Typ, wenn Sie ein 1:8-Verhältnis von CPU- und Speicherressourcen für mittlere Workloads wünschen, die mehr Hauptspeicher erfordern, zum Beispiel Datenbanken wie {{site.data.keyword.Db2_on_Cloud_short}}. Nur in Dallas und als Tenant-Setup `--hardware shared` verfügbar.</td>
<td>16/128 GB</td>
<td>25 GB/100 GB</td>
<td>1000 Mbit/s</td>
</tr><tr>
<td><strong>Virtuell, m3c.30x240</strong>: Verwenden Sie diesen Typ, wenn Sie ein 1:8-Verhältnis von CPU- und Speicherressourcen für mittlere bis große Workloads wünschen, die mehr Hauptspeicher erfordern, zum Beispiel Datenbanken wie {{site.data.keyword.Db2_on_Cloud_short}}. Nur in Dallas und als Tenant-Setup `--hardware shared` verfügbar.</td>
<td>30/240 GB</td>
<td>25 GB/100 GB</td>
<td>1000 Mbit/s</td>
</tr>
<tr>
<td><strong>Virtuell, z1.2x4</strong>: Verwenden Sie diesen Typ, wenn ein Workerknoten in Hyper Protect-Containern unter IBM Z Systems erstellt werden soll.</td>
<td>2/4 GB</td>
<td>25 GB/100 GB</td>
<td>1000 Mbit/s</td>
</tr>
</tbody>
</table>

## Physische Maschinen (Bare-Metal-Maschinen)
{: #bm}

Sie können Ihre Workerknoten als physischen Single-Tenant-Server bereitstellen, der auch als Bare-Metal-Server bezeichnet wird.
{: shortdesc}

**Wie unterscheiden sich Bare-Metal-Maschinen von VMs?**</br>
Mit Bare-Metal haben Sie direkten Zugriff auf die physischen Ressourcen auf der Maschine, wie z. B. Speicher oder CPU. Durch diese Konfiguration wird der Hypervisor der virtuellen Maschine entfernt, der physische Ressourcen zu virtuellen Maschinen zuordnet, die auf dem Host ausgeführt werden. Stattdessen sind alle Ressourcen der Bare-Metal-Maschine ausschließlich dem Worker gewidmet, also müssen Sie sich keine Sorgen machen, dass "lärmende Nachbarn" Ressourcen gemeinsam nutzen oder die Leistung verlangsamen. Physische Maschinentypen verfügen über einen größeren lokalen Speicher als virtuelle und einige verfügen zudem über RAID zur Steigerung der Datenverfügbarkeit. Der lokale Speicher auf dem Workerknoten ist nur für die kurzfristige Verarbeitung vorgesehen; die primäre und die sekundäre Platte werden gelöscht, wenn Sie den Workerknoten aktualisieren oder erneut laden. Informationen zu persistenten Speicherlösungen finden Sie im Abschnitt [Persistenten Hochverfügbarkeitsspeicher planen](/docs/containers?topic=containers-storage_planning#storage_planning).

**Bietet mir Bare-Metal mehr Möglichkeiten als VMs - abgesehen von besseren Spezifikationen für die Leistung?**</br>
Ja. Mit Bare-Metal haben Sie die Möglichkeit, Trusted Compute zu aktivieren, um Ihre Workerknoten auf Manipulation zu überprüfen. Wenn Sie Trusted Compute während der Clustererstellung nicht aktivieren, dies jedoch später nachholen möchten, können Sie den [Befehl](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_feature_enable) `ibmcloud ks feature-enable` verwenden. Nachdem Sie Trusted Compute aktiviert haben, können Sie es später nicht mehr inaktivieren. Sie können einen neuen Cluster ohne Trusted Compute erstellen. Weitere Informationen zur Funktionsweise von Trusted Compute während des Startprozesses für den Knoten finden Sie in [{{site.data.keyword.containerlong_notm}} mit Trusted Compute](/docs/containers?topic=containers-security#trusted_compute). Trusted Compute ist für bestimmte Bare-Metal-Maschinentypen verfügbar. Bei der Ausführung des [Befehls](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_machine_types) `ibmcloud ks machine-types <zone>` können Sie im Feld **Trustable** ablesen, welche Maschinen Trusted Compute unterstützen. Beispielsweise unterstützen die GPU-Typen `mgXc` Trusted Compute nicht.

Neben Trusted Compute können Sie auch {{site.data.keyword.datashield_full}} (Beta) nutzen. {{site.data.keyword.datashield_short}} ist in Intel® Software Guard Extensions (SGX) und Fortanix®-Technologie integriert, sodass der Workload-Code und die Daten Ihres {{site.data.keyword.Bluemix_notm}}-Containers während der Nutzung geschützt werden. Der App-Code und die Daten werden in speziellen CPU-Schutzenklaven ausgeführt. Dabei handelt es sich um vertrauenswürdige Speicherbereiche auf dem Workerknoten, die kritische Aspekte der App schützen und dabei helfen, Code und Daten vertraulich und unverändert zu halten. Wenn Sie oder Ihr Unternehmen aufgrund interner Richtlinien, behördlicher Regelungen oder branchenspezifischer Konformitätsanforderungen eine Sicherheitsstufe für Daten benötigen, kann Sie diese Lösung beim Wechsel zur Cloud unterstützen. Beispiele für Anwendungsfälle beziehen sich auf Finanzdienstleister und Einrichtungen des Gesundheitswesen oder auf Länder mit behördlichen Richtlinien, die eine On-Premises-Cloud-Lösung erfordern.

**Bare-Metal scheint nur Vorteile zu bieten. Was könnte dagegen sprechen, diese Lösung zu bestellen?**</br>
Die Nutzung von Bare-Metal-Servern ist teurer als die Nutzung virtueller Server. Bare-Metal-Server eignen sich für Hochleistungsanwendungen, die mehr Ressourcen und mehr Hoststeuerung benötigen.

Die Abrechnung für Bare-Metal-Server erfolgt monatlich. Wenn Sie einen Bare-Metal-Server vor Monatsende stornieren, werden Ihnen die Kosten bis zum Ende dieses Monats in Rechnung gestellt. Nachdem Sie einen Bare-Metal-Server bestellt oder storniert haben, wird der Prozess manuell in Ihrem Konto für die IBM Cloud-Infrastruktur (SoftLayer) ausgeführt. Die Ausführung kann daher länger als einen Geschäftstag dauern.
{: important}

**Welche Bare-Metal-Typen kann ich bestellen?**</br>
Die Typen der Workerknoten variieren je nach Zone. Die folgende Tabelle enthält die neueste Version des jeweiligen Typs, z. B. `x3c` Ubuntu 18-Workerknoten-Typen, im Gegensatz zu den älteren `x2c` Ubuntu 16-Workerknoten-Typen. Um die in Ihrer Zone verfügbaren Maschinentypen anzuzeigen, führen Sie den Befehl `ibmcloud ks machine-types <zone>` aus. Sie können außerdem die verfügbaren [VM](#vm)- oder [SDS](#sds)-Maschinentypen ansehen.

Bare-Metal-Maschinen sind für verschiedene Anwendungsfälle optimiert (z. B. für RAM-intensive, datenintensive oder GPU-intensive Workloads).

Wählen Sie einen Maschinentyp mit der richtigen Speicherkonfiguration aus, um Ihre Workload zu unterstützen. Einige Typen verfügen über eine Kombination aus den folgenden Platten und Speicherkonfigurationen. Beispielsweise können bestimmte Typen über eine SATA-Primärplatte mit einer unformatierten SSD-Sekundärplatte verfügen.

* **SATA**: Ein herkömmliches Magnetplattenspeichergerät, das häufig als primärer Datenträger des Workerknotens verwendet wird, auf dem das Dateisystem des Betriebssystems gespeichert ist.
* **SSD**: Ein Solid-State-Speichergerät für hohe Leistungsdaten.
* **Raw**: Das Speichergerät ist nicht formatiert und es steht die volle Kapazität zur Verfügung.
* **RAID**: Das Speichergerät verteilt die Daten für Redundanz und Leistung, abhängig von der jeweiligen RAID-Stufe. Die nutzbare Plattenkapazität variiert daher.


{: #bm-table}
<table>
<caption>Verfügbare Bare-Metal-Maschinentypen in {{site.data.keyword.containerlong_notm}}.</caption>
<thead>
<th>Name und Anwendungsfall</th>
<th>Kerne/Speicher</th>
<th>Primäre/Sekundäre Platte</th>
<th>Netzgeschwindigkeit</th>
</thead>
<tbody>
<tr>
<td><strong>RAM-intensiv, Bare-Metal, mr3c.28x512</strong>: Maximieren Sie den verfügbaren RAM-Speicher für Ihre Workerknoten.</td>
<td>28/512 GB</td>
<td>2 TB SATA / 960 GB SSD</td>
<td>10000 Mbit/s</td>
</tr>
<tr>
<td><strong>GPU, Bare-Metal, mg3c.16x128</strong>: Wählen Sie diesen Typ für rechenintensive Workloads, wie Datenverarbeitungen mit hoher Leistung, maschinelles Lernen oder 3D-Anwendungen. Dieser Typ verfügt über eine physische Tesla K80-Karte mit zwei GPUs (Graphics Processing Units) pro Karte für insgesamt zwei GPUs.</td>
<td>16/128 GB</td>
<td>2 TB SATA / 960 GB SSD</td>
<td>10000 Mbit/s</td>
</tr>
<tr>
<td><strong>GPU, Bare-Metal, mg3c.28x256</strong>: Wählen Sie diesen Typ für rechenintensive Workloads, wie Datenverarbeitungen mit hoher Leistung, maschinelles Lernen oder 3D-Anwendungen. Dieser Typ verfügt über zwei physische Tesla K80-Karten, die zwei GPUs (Graphics Processing Units) pro Karte für insgesamt vier GPUs aufweisen.</td>
<td>28/256 GB</td>
<td>2 TB SATA / 960 GB SSD</td>
<td>10000 Mbit/s</td>
</tr>
<tr>
<td><strong>Datenintensiv, Bare-Metal, md3c.16x64.4x4tb</strong>: Verwenden Sie diesen Typ für einen beträchtlichen Teil des lokalen Plattenspeichers, einschließlich RAID zur Steigerung der Datenverfügbarkeit, für Workloads wie verteilte Dateisysteme, große Datenbanken und Big-Data-Analysen.</td>
<td>16/64 GB</td>
<td>2 x 2 TB RAID1 / 4 x 4 TB SATA RAID10</td>
<td>10000 Mbit/s</td>
</tr>
<tr>
<td><strong>Datenintensiv, Bare-Metal, md3c.28x512.4x4tb</strong>: Verwenden Sie diesen Typ für einen beträchtlichen Teil des lokalen Plattenspeichers, einschließlich RAID zur Steigerung der Datenverfügbarkeit, für Workloads wie verteilte Dateisysteme, große Datenbanken und Big-Data-Analysen.</td>
<td>28/512 GB</td>
<td>2 x 2 TB RAID1 / 4 x 4 TB SATA RAID10</td>
<td>10000 Mbit/s</td>
</tr>
<tr>
<td><strong>Ausgeglichen, Bare-Metal, mb3c.4x32</strong>: Verwenden Sie diesen Typ für ausgeglichene Workloads, die mehr Ressourcen für die Datenverarbeitung benötigen, als virtuelle Maschinen bieten können. Dieser Typ kann auch mit Intel® Software Guard Extensions (SGX) eingerichtet werden, sodass Sie <a href="/docs/services/data-shield?topic=data-shield-getting-started#getting-started" target="_blank">{{site.data.keyword.datashield_short}} (Beta)<img src="../icons/launch-glyph.svg" alt="Symbol für externen Link"></a> zum Verschlüsseln Ihres Datenspeichers verwenden können.</td>
<td>4/32 GB</td>
<td>2 TB SATA / 2 TB SATA</td>
<td>10000 Mbit/s</td>
</tr>
<tr>
<td><strong>Ausgeglichen, Bare-Metal, mb3c.16x64</strong>: Verwenden Sie diesen Typ für ausgeglichene Workloads, die mehr Ressourcen für die Datenverarbeitung benötigen, als virtuelle Maschinen bieten können.</td>
<td>16/64 GB</td>
<td>2 TB SATA / 960 GB SSD</td>
<td>10000 Mbit/s</td>
</tr>
<tr>
</tbody>
</table>

## SDS-Maschinen (Software-defined Storage)
{: #sds}

SDS-Typen (SDS = Software-Defined Storage) sind physische Maschinen, die mit einer zusätzlichen unformatierten Platten für den physischen lokalen Speicher bereitgestellt werden. Im Gegensatz zur primären und sekundären lokalen Platte werden diese unformatierten Platten beim Aktualisieren oder erneuten Laden eines Workerknotens nicht gelöscht. Da sich die Daten auf derselben Maschine wie der Rechenknoten befinden, eignen sich SDS-Maschinen für Workloads mit hoher Leistungsanforderung.
{: shortdesc}

**Wann verwende ich SDS-Typen?**</br>
Normalerweise verwenden Sie SDS-Maschinen in den folgenden Fällen:
*  Wenn Sie ein SDS-Add-on wie [Portworx](/docs/containers?topic=containers-portworx#portworx) für den Cluster verwenden, verwenden Sie Sie eine SDS-Maschine.
*  Wenn Ihre App ein [StatefulSet ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/) ist, das lokalen Speicher voraussetzt, können Sie SDS-Maschinen verwenden und [lokale Kubernetes-PVs (Beta) ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/blog/2018/04/13/local-persistent-volumes-beta/) einrichten.
*  Möglicherweise verfügen Sie über angepasste Apps, die zusätzlichen unformatierten lokalen Speicher erfordern.

Informationen zu weiteren Speicherlösungen finden Sie im Abschnitt [Persistenten Hochverfügbarkeitsspeicher planen](/docs/containers?topic=containers-storage_planning#storage_planning).

**Welche SDS-Typen kann ich bestellen?**</br>
Die Typen der Workerknoten variieren je nach Zone. Die folgende Tabelle enthält die neueste Version des jeweiligen Typs, z. B. `x3c` Ubuntu 18-Workerknoten-Typen, im Gegensatz zu den älteren `x2c` Ubuntu 16-Workerknoten-Typen. Um die in Ihrer Zone verfügbaren Maschinentypen anzuzeigen, führen Sie den Befehl `ibmcloud ks machine-types <zone>` aus. Sie können außerdem die verfügbaren [Bare-Metal](#bm)- oder [VM](#vm)-Maschinentypen ansehen.

Wählen Sie einen Maschinentyp mit der richtigen Speicherkonfiguration aus, um Ihre Workload zu unterstützen. Einige Typen verfügen über eine Kombination aus den folgenden Platten und Speicherkonfigurationen. Beispielsweise können bestimmte Typen über eine SATA-Primärplatte mit einer unformatierten SSD-Sekundärplatte verfügen.

* **SATA**: Ein herkömmliches Magnetplattenspeichergerät, das häufig als primärer Datenträger des Workerknotens verwendet wird, auf dem das Dateisystem des Betriebssystems gespeichert ist.
* **SSD**: Ein Solid-State-Speichergerät für hohe Leistungsdaten.
* **Raw**: Das Speichergerät ist nicht formatiert und es steht die volle Kapazität zur Verfügung.
* **RAID**: Das Speichergerät verteilt die Daten für Redundanz und Leistung, abhängig von der jeweiligen RAID-Stufe. Die nutzbare Plattenkapazität variiert daher.


{: #sds-table}
<table>
<caption>Verfügbare SDS-Maschinentypen in {{site.data.keyword.containerlong_notm}}.</caption>
<thead>
<th>Name und Anwendungsfall</th>
<th>Kerne/Speicher</th>
<th>Primäre/Sekundäre Platte</th>
<th>Zusätzliche unformatierte Platten</th>
<th>Netzgeschwindigkeit</th>
</thead>
<tbody>
<tr>
<td><strong>Bare-Metal mit SDS, ms3c.4x32.1.9tb.ssd</strong>: Wenn Sie zusätzlichen lokalen Speicher zur Leistungssteigerung benötigen, verwenden Sie diesen Typ mit hoher Plattenkapazität, der SDS (Software-Defined Storage) unterstützt.</td>
<td>4/32 GB</td>
<td>2 TB SATA / 960 GB SSD</td>
<td>1,9 TB Raw SSD (Einheitenpfad: `/dev/sdc`)</td>
<td>10000 Mbit/s</td>
</tr>
<tr>
<td><strong>Bare-Metal mit SDS, ms3c.16x64.1.9tb.ssd</strong>: Wenn Sie zusätzlichen lokalen Speicher zur Leistungssteigerung benötigen, verwenden Sie diesen Typ mit hoher Plattenkapazität, der SDS (Software-Defined Storage) unterstützt.</td>
<td>16/64 GB</td>
<td>2 TB SATA / 960 GB SSD</td>
<td>1,9 TB Raw SSD (Einheitenpfad: `/dev/sdc`)</td>
<td>10000 Mbit/s</td>
</tr>
<tr>
<td><strong>Bare-Metal mit SDS, ms3c.28x256.3.8tb.ssd</strong>: Wenn Sie zusätzlichen lokalen Speicher zur Leistungssteigerung benötigen, verwenden Sie diesen Typ mit hoher Plattenkapazität, der SDS (Software-Defined Storage) unterstützt.</td>
<td>28/256 GB</td>
<td>2 TB SATA / 1,9 TB SSD</td>
<td>3,8 TB Raw SSD (Einheitenpfad: `/dev/sdc`)</td>
<td>10000 Mbit/s</td>
</tr>
<tr>
<td><strong>Bare-Metal mit SDS, ms3c.28x512.4x3.8tb.ssd</strong>: Wenn Sie zusätzlichen lokalen Speicher zur Leistungssteigerung benötigen, verwenden Sie diesen Typ mit hoher Plattenkapazität, der SDS (Software-Defined Storage) unterstützt.</td>
<td>28/512 GB</td>
<td>2 TB SATA / 1,9 TB SSD</td>
<td>4 Platten, 3,8 TB Raw SSD (Einheitenpfade: `/dev/sdc`, `/dev/sdd`, `/dev/sde`, `/dev/sdf`)</td>
<td>10000 Mbit/s</td>
</tr>
</tbody>
</table>

## Reserven für Workerknotenressourcen
{: #resource_limit_node}

{{site.data.keyword.containerlong_notm}} legt Reserven für Rechenressourcen fest, die die verfügbaren Rechenressourcen auf den einzelnen Workerknoten begrenzen. Reservierte Speicher- und CPU-Ressourcen können von Pods auf dem Workerknoten nicht verwendet werden. Auf diese Weise werden die zuordnungsfähigen Ressourcen auf den Workerknoten reduziert. Wenn Sie ursprünglich Pods bereitstellen, der Workerknoten aber nicht über ausreichend zuordnungsfähige Ressourcen verfügt, schlägt die Bereitstellung fehl. Und wenn Pods das Limit für Workerknotenressourcen überschreiten, werden die Pods entfernt. In Kubernetes wird dieses Limit als [harte Räumungsschwelle ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tasks/administer-cluster/out-of-resource/#hard-eviction-thresholds) bezeichnet.
{:shortdesc}

Wenn weniger CPU oder Speicher verfügbar ist als der Workerknoten reserviert, beginnt Kubernetes damit, Pods zu entfernen, um ausreichend Rechenressourcen verfügbar zu machen. Wenn ein anderer Workerknoten verfügbar ist, wird die Planung für die Pods auf diesem Workerknoten neu erstellt. Wenn Ihre Pods häufig entfernt werden, fügen Sie zusätzliche Workerknoten zu Ihrem Cluster hinzu oder legen Sie [Ressourcenbegrenzungen ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#resource-requests-and-limits-of-pod-and-container) für die Pods fest.

Welche Ressourcen auf Ihrem Workerknoten reserviert werden, hängt von der Menge an CPU und Speicher ab, mit der Ihr Workerknoten geliefert wird. {{site.data.keyword.containerlong_notm}} definiert die Speicher- und CPU-Ebenen wie in der folgenden Tabelle dargestellt. Wenn Ihr Workerknoten über Rechenressourcen in mehreren Ebenen verfügt, wird ein Prozentsatz der CPU- und Speicherressourcen für jede Ebene reserviert.

Um zu sehen, wie viele Rechenressourcen derzeit auf dem Workerknoten verwendet werden, führen Sie [`kubectl top node` ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/reference/kubectl/overview/#top) aus.
{: tip}

<table summary="Diese Tabelle enthält für Workerknoten reservierten Speicher nach Ebene.">
<caption>Für Workerknoten reservierter Speicher nach Ebene</caption>
<thead>
<tr>
  <th>Speicherebene</th>
  <th>% oder Menge reserviert</th>
  <th>`b3c.4x16` Workerknoten (16 GB), Beispiel</th>
  <th>`mg1c.28x256` Workerknoten (256 GB), Beispiel</th>
</tr>
</thead>
<tbody>
<tr>
  <td>Erste 4 GB (0-4 GB)</td>
  <td>25% des Speichers</td>
  <td>1 GB</td>
  <td>1 GB</td>
</tr>
<tr>
  <td>Nächste 4 GB (5-8 GB)</td>
  <td>20% des Speichers</td>
  <td>0,8 GB</td>
  <td>0,8 GB</td>
</tr>
<tr>
  <td>Nächste 8 GB (9-16 GB)</td>
  <td>10 % des Speichers</td>
  <td>0,8 GB</td>
  <td>0,8 GB</td>
</tr>
<tr>
  <td>Nächste 112 GB (17-128 GB)</td>
  <td>6 % des Speichers</td>
  <td>n.z.</td>
  <td>6,72 GB</td>
</tr>
<tr>
  <td>Die verbleibenden GB (129 GB+)</td>
  <td>2 % des Speichers</td>
  <td>n.z.</td>
  <td>2,54 GB</td>
</tr>
<tr>
  <td>Zusätzliche Reserve für [`kubelet`-Entfernung ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tasks/administer-cluster/out-of-resource/)</td>
  <td>100 MB</td>
  <td>100 MB (unstrukturierte Menge)</td>
  <td>100 MB (unstrukturierte Menge)</td>
</tr>
<tr>
  <td>**Insgesamt reserviert**</td>
  <td>**(variiert)**</td>
  <td>**2,7 GB von insgesamt 16 GB**</td>
  <td>**11,96 GB von insgesamt 256 GB**</td>
</tr>
</tbody>
</table>

<table summary="Diese Tabelle enthält die für Workerknoten reservierte CPU nach Ebene.">
<caption>Für Workerknoten reservierte CPU nach Ebene</caption>
<thead>
<tr>
  <th>CPU-Ebene</th>
  <th>% reserviert</th>
  <th>`b3c.4x16`-Workerknoten (4 Cores), Beispiel</th>
  <th>`mg1c.28x256` Workerknoten (28 Cores), Beispiel</th>
</tr>
</thead>
<tbody>
<tr>
  <td>Erster Core (Core 1)</td>
  <td>6 % Cores</td>
  <td>0,06 Cores</td>
  <td>0,06 Cores</td>
</tr>
<tr>
  <td>Die nächsten 2 Cores (Cores 2-3)</td>
  <td>1 % Cores</td>
  <td>0,02 Cores</td>
  <td>0,02 Cores</td>
</tr>
<tr>
  <td>Die nächsten 2 Cores (Cores 4-5)</td>
  <td>0,5 % Cores</td>
  <td>0,005 Cores</td>
  <td>0,01 Cores</td>
</tr>
<tr>
  <td>Die verbleibenden Cores (Cores 6+)</td>
  <td>0,25 % Cores</td>
  <td>n.z.</td>
  <td>0,0575 Cores</td>
</tr>
<tr>
  <td>**Insgesamt reserviert**</td>
  <td>**(variiert)**</td>
  <td>**0,085 Cores von insgesamt 4 Cores**</td>
  <td>**0,1475 Cores von insgesamt 28 Cores**</td>
</tr>
</tbody>
</table>
