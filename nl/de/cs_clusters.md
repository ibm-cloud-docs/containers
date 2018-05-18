---

copyright:
  years: 2014, 2018
lastupdated: "2018-03-16"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Cluster einrichten
{: #clusters}

Konzipieren Sie die Konfiguration Ihres Kubernetes-Cluster, um das größtmögliche Maß an Verfügbarkeit und Kapazität mit {{site.data.keyword.containerlong}} zu erzielen.
{:shortdesc}

## Clusterkonfiguration planen
{: #planning_clusters}

Verwenden Sie Standardcluster, um die Verfügbarkeit von Apps zu erhöhen.
{:shortdesc}

Die Wahrscheinlichkeit, dass Ihre Benutzer Ausfallzeiten verzeichnen, ist
geringer, wenn Sie Ihre Containerkonfiguration auf mehrere Workerknoten und Cluster verteilen. Integrierte Funktionen wie Lastausgleich (Load Balancing) und Isolation erhöhen die Ausfallsicherheit gegenüber möglichen Fehlerbedingungen mit Hosts,
Netzen oder Apps.

Betrachten Sie diese potenziellen Clusterkonfigurationen, die nach zunehmendem Grad der Verfügbarkeit angeordnet sind:

![Stufen der Hochverfügbarkeit für einen Cluster](images/cs_cluster_ha_roadmap.png)

1.  Ein Cluster mit mehreren Workerknoten.
2.  Zwei Cluster, die an verschiedenen Standorten in derselben Region ausgeführt werden und jeweils mehrere Workerknoten besitzen.
3.  Zwei Cluster, die in verschiedenen Regionen ausgeführt werden und jeweils mehrere Workerknoten besitzen.

Steigern Sie die Verfügbarkeit Ihres Clusters mithilfe dieser Verfahren:

<dl>
<dt>Streuung von Apps durch Verteilen auf mehrere Workerknoten</dt>
<dd>Erlauben Sie den Entwicklern die Streuung ihrer Apps in Containern auf mehrere Workerknoten pro Cluster. Eine App-Instanz in jedem dritten Workerknoten ermöglicht, die Ausfallzeit eines Workerknotens abzufangen, ohne dass die Nutzung der App unterbrochen wird. Sie können angeben, wie viele Workerknoten eingeschlossen werden, wenn Sie einen Cluster über die [{{site.data.keyword.Bluemix_notm}}-GUI](cs_clusters.html#clusters_ui) oder die [CLI](cs_clusters.html#clusters_cli) erstellen. Kubernetes beschränkt die maximale Anzahl von Workerknoten, die in einem Cluster vorhanden sein können. Beachten Sie deshalb die [Kontingente für Workerknoten und Pods ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/admin/cluster-large/).
<pre class="codeblock">
<code>bx cs cluster-create --location &lt;dal10&gt; --workers 3 --public-vlan &lt;meine_id_des_öffentlichen_vlan&gt; --private-vlan &lt;meine_id_des_privaten_vlan&gt; --machine-type &lt;u2c.2x4&gt; --name &lt;mein_cluster&gt;</code>
</pre>
</dd>
<dt>Streuung von Apps durch Verteilen auf mehrere Cluster</dt>
<dd>Erstellen Sie mehrere Cluster, die jeweils mehrere Workerknoten besitzen. Sollte es bei einem Cluster zu einem Ausfall kommen, können Benutzer immer noch auf eine App zugreifen, die auch auf einem anderen Cluster bereitgestellt ist.
<p>Cluster
1:</p>
<pre class="codeblock">
<code>bx cs cluster-create --location &lt;dal10&gt; --workers 3 --public-vlan &lt;meine_id_des_öffentlichen_vlan&gt; --private-vlan &lt;meine_id_des_privaten_vlan&gt; --machine-type &lt;u2c.2x4&gt; --name &lt;mein_cluster1&gt;</code>
</pre>
<p>Cluster
2:</p>
<pre class="codeblock">
<code>bx cs cluster-create --location &lt;dal12&gt; --workers 3 --public-vlan &lt;meine_id_des_öffentlichen_vlan&gt; --private-vlan &lt;meine_id_des_privaten_vlan&gt; --machine-type &lt;u2c.2x4&gt;  --name &lt;mein_cluster2&gt;</code>
</pre>
</dd>
<dt>Streuung von Apps durch Verteilen auf mehrere Cluster in verschiedenen Regionen</dt>
<dd>Wenn Sie Apps auf mehrere Cluster in verschiedenen Regionen verteilen, kann der Lastausgleich auf der Grundlage der Region erfolgen, in der sich der Benutzer befindet. Wenn der Cluster, die Hardware oder gar ein kompletter Standort in einer Region ausfällt, wird der Datenverkehr an den Container weitergeleitet, der an einem anderen Standort bereitgestellt ist.
<p><strong>Wichtig:</strong> Nachdem Sie eine angepasste Domäne konfiguriert haben, können Sie die Cluster anhand der folgenden Befehle erstellen.</p>
<p>Standort
1:</p>
<pre class="codeblock">
<code>bx cs cluster-create --location &lt;dal10&gt; --workers 3 --public-vlan &lt;meine_id_des_öffentlichen_vlan&gt; --private-vlan &lt;meine_id_des_privaten_vlan&gt; --machine-type &lt;u2c.2x4&gt; --name &lt;mein_cluster1&gt;</code>
</pre>
<p>Standort
2:</p>
<pre class="codeblock">
<code>bx cs cluster-create --location &lt;ams03&gt; --workers 3 --public-vlan &lt;meine_id_des_öffentlichen_vlan&gt; --private-vlan &lt;meine_id_des_privaten_vlan&gt; --machine-type &lt;u2c.2x4&gt; --name &lt;mein_cluster2&gt;</code>
</pre>
</dd>
</dl>

<br />





## Konfiguration von Workerknoten planen
{: #planning_worker_nodes}

Ein Kubernetes-Cluster besteht aus Workerknoten, die vom Kubernetes-Master zentral überwacht und verwaltet werden. Clusteradministratoren entscheiden, wie sie den Cluster aus Workerknoten einrichten, um sicherzustellen, dass den Clusterbenutzern alle Ressourcen für die Bereitstellung und Ausführung von Apps im Cluster zur Verfügung stehen.
{:shortdesc}

Wenn Sie einen Standardcluster erstellen, werden in IBM Cloud Infrastructure (SoftLayer) in Ihrem Namen Workerknoten bestellt und zum Standardpool der Workerknoten in Ihrem Cluster hinzugefügt. Jedem Workerknoten werden eine eindeutige Workerknoten-ID und ein Domänenname zugeordnet, die nach dem Erstellen des Clusters nicht geändert werden dürfen.

Sie können zwischen virtuellen oder physischen Servern (Bare-Metal-Servern) wählen. Abhängig von dem ausgewählten Grad an Hardware-Isolation können virtuelle Workerknoten als gemeinsam genutzte oder als dedizierte Knoten eingerichtet werden. Außerdem können Sie auswählen, ob Workerknoten mit einem öffentlichen und einem privaten VLAN verbunden werden sollen oder nur mit einem privaten VLAN. Jeder Workerknoten wird mit einem bestimmten Maschinentyp bereitgestellt, der die Anzahl von vCPUs sowie die Menge an Haupt- und an Plattenspeicher festlegt, die den auf Ihrem Workerknoten bereitgestellten Containern zur Verfügung stehen. Kubernetes beschränkt die maximale Anzahl von Workerknoten, die in einem Cluster vorhanden sein können. Weitere Informationen finden Sie unter [Worker node and pod quotas ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/admin/cluster-large/).





### Hardware für Workerknoten
{: #shared_dedicated_node}

Wenn Sie einen Standardcluster in {{site.data.keyword.Bluemix_notm}} erstellen, wählen Sie Ihre Workerknoten als physische Maschinen (Bare-Metal) oder als virtuelle Maschinen, die auf physischer Hardware ausgeführt werden, aus. Wenn Sie einen kostenlosen Cluster erstellen, wird Ihr Workerknoten automatisch als gemeinsam genutzter, virtueller Knoten im Konto der IBM Cloud-Infrastruktur (SoftLayer) bereitgestellt.{:shortdesc}

![Hardwaresystemerweiterungen für Workerknoten in einem Standardcluster](images/cs_clusters_hardware.png)

<dl>
<dt>Physische Maschinen (Bare-Metal)</dt>
<dd>Sie können Ihre Workerknoten als physischen Single-Tenant Server bereitstellen, der auch als Bare-Metal-Server bezeichnet wird. Mit Bare-Metal haben Sie direkten Zugriff auf die physischen Ressourcen auf der Maschine, wie z. B. Speicher oder CPU. Durch diese Konfiguration wird der Hypervisor der virtuellen Maschine entfernt, der physische Ressourcen zu virtuellen Maschinen zuordnet, die auf dem Host ausgeführt werden. Stattdessen sind alle Ressourcen der Bare-Metal-Maschine ausschließlich dem Worker gewidmet, also müssen Sie sich keine Sorgen machen, dass "lärmende Nachbarn" Ressourcen gemeinsam nutzen oder die Leistung verlangsamen. <p><strong>Monatliche Abrechnung</strong>: Die Nutzung von Bare-Metal-Servern ist teurer als die Nutzung virtueller Server. Bare-Metal-Server eignen sich für Hochleistungsanwendungen, die mehr Ressourcen und mehr Hoststeuerung benötigen. Die Abrechnung für Bare-Metal-Server erfolgt monatlich. Wenn Sie einen Bare-Metal-Server vor Monatsende stornieren, werden Ihnen die Kosten bis zum Ende dieses Monats belastet. Wenn Sie Bare-Metal-Server bereitstellen, interagieren Sie direkt mit IBM Cloud Infrastructure (SoftLayer) und die Ausführung dieses manuellen Prozesses kann daher mehr als einen Arbeitstag dauern. </p>
<p><strong>Option zum Aktivieren von Trusted Compute</strong>: Sie können Trusted Compute nur auf ausgewählten Workerknoten aktivieren, auf denen Kubernetes Version 1.9 oder eine neuere Version ausgeführt wird. Mit Trusted Compute überprüfen Sie Ihre Workerknoten auf Manipulation. Wenn Sie Trusted Compute während der Clustererstellung nicht aktivieren, dies jedoch später nachholen möchten, können Sie den [Befehl](cs_cli_reference.html#cs_cluster_feature_enable) `bx cs feature-enable` verwenden. Nachdem Sie Trusted Compute aktiviert haben, können Sie es später nicht mehr inaktivieren. Weitere Informationen zur Funktionsweise von Trusted Compute während des Startprozesses für den Knoten finden Sie in [{{site.data.keyword.containershort_notm}} mit Trusted Compute](cs_secure.html#trusted_compute). Bei der Ausführung des[ Befehls](cs_cli_reference.html#cs_machine_types) `bx cs machine-types <location>` können Sie im Feld `Trustable` ablesen, welche Maschinen Trusted Compute unterstützen. </p>
<p><strong>Bare-Metal-Maschinentypgruppen</strong>: Bare-Metal-Maschinentypen werden in Gruppen mit unterschiedlichen Rechenressourcen bereitgestellt, aus denen Sie auswählen können, um die Anforderungen Ihrer Anwendung zu erfüllen.
Physische Maschinentypen verfügen über einen größeren lokalen Speicher als virtuelle und einige verfügen zudem über RAID für die Sicherung lokaler Daten. Weitere Informationen zu den unterschiedlichen Typen von Bare-Metal-Produktangeboten finden Sie unter dem [Befehl](cs_cli_reference.html#cs_machine_types) `bx cs machine-type`.
<ul><li>`mb1c`: Wählen Sie diesen Typ für eine ausgewogene Konfiguration physischer Maschinenressourcen für Ihre Workerknoten aus. Dieser Typ umfasst Zugriff auf die 10 GBps Dual-Redundant-Netze und eine duale SSD-HDD-Konfiguration. In der Regel verfügt dieser Typ über eine 1 TB-Primärspeicherplatte und eine 1,7 oder 2 TB-Sekundärplatte. </li>
<li>`mr1c`: Wählen Sie diesen Typ aus, um den verfügbaren RAM-Speicher für Ihre Workerknoten zu maximieren. </li>
<li>`md1c`: Wählen Sie diesen Typ aus, wenn Ihre Workerknoten eine bedeutsame Menge lokalen Festplattenspeicherplatz einschließlich RAID für die Sicherung der lokal auf der Maschine gespeicherten Daten benötigen. Die 1 TB-Primärspeicherplatten sind für RAID1 konfiguriert und die 4 TB-Sekundärspeicherplatten sind für RAID10 konfiguriert. </li>

</ul></p></dd>
<dt>Virtuelle Maschinen</dt>
<dd>Wenn Sie einen virtuellen Standardcluster erstellen, müssen Sie auswählen, ob die zugrunde liegende Hardware von mehreren {{site.data.keyword.IBM_notm}} Kunden gemeinsam genutzt werden kann (Multi-Tenant-Konfiguration) oder ob Sie die ausschließlich Ihnen vorbehaltene, dedizierte Nutzung vorziehen (Single-Tenant-Konfiguration).
<p>Bei einer Multi-Tenant-Konfiguration werden physische Ressourcen wie CPU und Speicher von allen virtuellen Maschinen, die auf derselben physischen Hardware bereitgestellt wurden, gemeinsam genutzt. Um sicherzustellen, dass jede virtuelle Maschine unabhängig von anderen Maschinen ausgeführt werden kann, segmentiert ein VM-Monitor, d. h. eine Überwachungsfunktion für virtuelle Maschinen, die auch als Hypervisor bezeichnet wird, die physischen Ressourcen in isolierte Entitäten und ordnet diese einer virtuellen Maschine als dedizierte Ressourcen zu. Dies wird als Hypervisor-Isolation bezeichnet.</p>
<p>Bei einer Single-Tenant-Konfiguration ist die Nutzung aller physischen Ressourcen ausschließlich Ihnen vorbehalten. Sie können mehrere Workerknoten als virtuelle Maschinen auf demselben physischen Host bereitstellen. Ähnlich wie bei der Multi-Tenant-Konfiguration stellt der Hypervisor auch hier sicher, dass jeder Workerknoten seinen Anteil an den verfügbaren physischen Ressourcen erhält.</p>
<p>Gemeinsam genutzte Knoten sind in der Regel kostengünstiger als dedizierte Knoten, weil die Kosten für die ihnen zugrunde liegende Hardware von mehreren Kunden getragen werden. Bei der Entscheidungsfindung hinsichtlich gemeinsam genutzter Knoten versus dedizierter Knoten sollten Sie mit Ihrer Rechtsabteilung Rücksprache halten, um zu klären, welcher Grad an Infrastrukturisolation und Compliance für Ihre App-Umgebung erforderlich ist.</p></dd>
</dl>

Die verfügbaren physischen und virtuellen Maschinentypen variieren je nach dem Standort, an dem Sie den Cluster bereitstellen. Weitere Informationen finden Sie im [Befehl](cs_cli_reference.html#cs_machine_types) `bx cs machine-type`. Sie können Cluster mithilfe der [Konsolen-UI](#clusters_ui) oder mithilfe der [CLI](#clusters_cli) bereitstellen.

### VLAN-Verbindung für Workerknoten
{: #worker_vlan_connection}

Bei der Clustererstellung wird jeder Cluster automatisch mit einem VLAN in Ihrem Konto der IBM Cloud-Infrastruktur (SoftLayer) verbunden.
{:shortdesc}

Ein VLAN konfiguriert eine Gruppe von Workerknoten und Pods so, als wären diese an dasselbe physische Kabel angeschlossen. Das private VLAN bestimmt, welche private IP-Adresse einem Workerknoten bei der Clustererstellung zugewiesen wird. Das öffentliche VLAN bestimmt, welche öffentliche IP-Adresse einem Workerknoten bei der Clustererstellung zugewiesen wird.

Bei kostenlosen Clustern werden die Workerknoten des Clusters während der Clustererstellung mit einem IBM eigenen öffentlichen VLAN und privaten VLAN verbunden. Bei Standardknoten müssen Ihre Workerknoten mit einem privaten VLAN verbunden sein. Sie können Ihre Workerknoten entweder mit einem öffentlichen und einem privaten VLAN verbinden oder nur mit einem privaten VLAN. Wenn Ihre Workerknoten nur mit einem privaten VLAN verbunden werden sollen, können Sie während der Clustererstellung die ID eines vorhandenen privaten VLANs angeben oder [ein neues privates VLAN erstellen](/docs/cli/reference/softlayer/index.html#sl_vlan_create). Sie müssen zusätzlich eine alternative Lösung konfigurieren, um eine sichere Verbindung zwischen Workerknoten und dem Kubernetes-Master zu ermöglichen. Sie können zum Beispiel eine Vyatta-Instanz konfigurieren, um Datenverkehr von Workerknoten im privaten VLAN an den Kubernetes-Master weiterzuleiten. Weitere Informationen hierzu finden Sie im Abschnitt "Set up a custom Vyatta to securely connect your worker nodes to the Kubernetes master" in der [Dokumentation für die IBM Cloud-Infrastruktur (SoftLayer)](https://knowledgelayer.softlayer.com/procedure/basic-configuration-vyatta).

**Hinweis**: Wenn Sie über mehrere VLANs für ein Cluster oder über mehrere Teilnetze in demselben VLAN verfügen, müssen Sie VLAN-Spanning aktivieren, damit die Workerknoten in dem privaten Netz miteinander kommunizieren können. Entsprechende Anweisungen finden Sie in [VLAN-Spanning aktivieren oder inaktivieren](/docs/infrastructure/vlans/vlan-spanning.html#enable-or-disable-vlan-spanning).

### Speicherbegrenzung für Workerknoten
{: #resource_limit_node}

{{site.data.keyword.containershort_notm}} legt für jeden Workerknoten eine Speicherbegrenzung fest. Wenn Pods, die auf einem Workerknoten ausgeführt werden, diese Speicherbegrenzung überschreiten, werden die Pods entfernt. In Kubernetes wird diese Begrenzung als [harte Räumungsschwelle ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tasks/administer-cluster/out-of-resource/#hard-eviction-thresholds) bezeichnet.
{:shortdesc}

Wenn Ihre Pods häufig entfernt werden, fügen Sie zusätzliche Workerknoten zu Ihrem Cluster hinzu oder legen Sie [Ressourcenbegrenzungen ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#resource-requests-and-limits-of-pod-and-container) für die Pods fest.

Jeder Maschinentyp verfügt über eine andere Speicherkapazität. Wenn weniger Speicher auf dem Workerknoten als der zulässige Mindestschwellenwert verfügbar ist, entfernt Kubernetes den Pod sofort. Wenn ein anderer Workerknoten verfügbar ist, wird die Planung für den Pod auf diesem Workerknoten neu erstellt.

|Speicherkapazität für Workerknoten|Mindestspeicherschwellenwert eines Workerknotens|
|---------------------------|------------|
|4 GB  | 256 MB |
|16 GB | 1024 MB |
|64 GB | 4096 MB |
|128 GB| 4096 MB |
|242 GB| 4096 MB |

Um zu sehen, wie viel Speicher auf dem Workerknoten belegt ist, führen Sie [kubectl top node ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#top) aus.

### Automatische Wiederherstellung für Ihren Workerknoten
`Docker`, `kubelet`, `kube-proxy` und `calico` sind wichtige Komponenten, die funktionieren müssen, damit die Kubernetes-Workerknoten einen einwandfreiem Zustand aufweisen. Im Laufe der Zeit können diese Komponenten kaputt gehen und ihre Workerknoten möglicherweise in einem nicht funktionsbereiten Zustand versetzen. Nicht funktionsbereite Workerknoten verringern die Gesamtkapazität des Clusters und können zu Ausfallzeiten für Ihre App führen. 

Sie können [Statusprüfungen für Ihre Workerknoten konfigurieren und die automatische Wiederherstellung aktiveren](cs_health.html#autorecovery). Wenn die automatische Wiederherstellung basierend auf den konfigurierten Prüfungen einen nicht ordnungsgemäß funktionierenden Workerknoten erkennt, löst das System eine Korrekturmaßnahme, wie das erneute Laden des Betriebssystems, auf dem Workerknoten aus. Weitere Informationen zur Funktionsweise der automatischen Wiederherstellung finden Sie im [Blogbeitrag zur automatischen Wiederherstellung![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/blogs/bluemix/2017/12/autorecovery-utilizes-consistent-hashing-high-availability/).

<br />



## Cluster über die GUI erstellen
{: #clusters_ui}

Der Zweck des Kubernetes-Clusters besteht darin, eine Gruppe von Ressourcen, Knoten, Netzen und Speichereinheiten zu definieren, die die Hochverfügbarkeit von Apps sicherstellen. Bevor Sie eine App bereitstellen können, müssen Sie zunächst einen Cluster erstellen und die Definitionen für die Workerknoten in diesem Cluster festlegen.
{:shortdesc}

Bevor Sie beginnen, müssen Sie über ein nutzungsabhängiges [{{site.data.keyword.Bluemix_notm}}-Konto](https://console.bluemix.net/registration/) oder über ein Abonnementkonto verfügen. Sie können 1 kostenlosen Cluster erstellen, um einige der Leistungsmerkmale zu testen. Oder Sie können Standardcluster mit Ihrer Auswahl an Hardwareisolation erstellen. 

Gehen Sie wie folgt vor, um einen Cluster zu erstellen:

1. Wählen Sie im Katalog die Option **Kubernetes-Cluster** aus.

2. Wählen Sie eine Region aus, in der Ihr Cluster bereitgestellt werden soll.

3. Wählen Sie einen Clusterplantyp aus. Sie können entweder **Kostenlos** oder **Standard** auswählen. Bei einem Standardcluster erhalten Sie Zugriff auf Features wie beispielsweise mehrere Workerknoten für eine hoch verfügbare Umgebung. 

4. Konfigurieren Sie die Clusterdetails.

    1. **Kostenlos und Standard**: Geben Sie Ihrem Cluster einen Namen. Der Name muss mit einem Buchstaben beginnen, darf Buchstaben, Ziffern und den Bindestrich enthalten und darf maximal 35 Zeichen lang sein. Beachten Sie, dass die {{site.data.keyword.IBM_notm}}-zugeordnete Ingress-Unterdomäne aus dem Clusternamen abgeleitet wird. Der Clustername und die Ingress-Unterdomäne bilden zusammen den vollständig qualifizierten Domänennamen, der innerhalb einer Region eindeutig sein muss und maximal 63 Zeichen lang sein darf. Um diese Anforderungen zu erfüllen, kann der Clustername abgeschnitten werden oder der Unterdomäne können zufällige Zeichenwerte zugeordnet werden.

    2. **Standard**: Wählen Sie eine Kubernetes-Version aus und anschließend eine Position für die Bereitstellung Ihres Clusters. Wählen Sie die Position aus, die Ihrem Standort am nächsten ist, um eine optimale Leistung zu erhalten. Beachten Sie bei der Auswahl eines Standorts außerhalb Ihres Landes, dass Sie gegebenenfalls eine gesetzliche Genehmigung benötigen, bevor Daten physisch in einem anderen Land gespeichert werden können.

    3. **Standard**: Wählen Sie einen Typ der Hardwareisolation aus. Virtuell wird auf Stundenbasis berechnet und Bare-Metal wird monatlich in Rechnung gestellt. 

        - **Virtuell - Dediziert**: Ihre Workerknoten werden in einer Infrastruktur gehostet, die Ihrem Konto vorbehalten ist. Ihre physischen Ressourcen sind vollständig isoliert.

        - **Virtuell - Gemeinsam genutzt**: Infrastrukturressourcen wie der Hypervisor und physische Hardware werden von Ihnen und anderen IBM Kunden gemeinsam genutzt, aber jeder Workerknoten ist ausschließlich für Sie zugänglich. Obwohl diese Option in den meisten Fällen ausreicht und kostengünstiger ist, sollten Sie die Leistungs- und Infrastrukturanforderungen anhand der Richtlinien Ihres Unternehmens prüfen.

        - **Bare-Metal**: Bare-Metal-Server werden monatlich abgerechnet und durch manuelle Interaktion mit der IBM Cloud-Infrastructure (SoftLayer) bereitgestellt, daher kann die Ausführung mehr als einen Arbeitstag dauern. Bare-Metal-Server eignen sich am besten für Hochleistungsanwendungen, die mehr Ressourcen und Hoststeuerung erfordern.
Für Cluster, die Kubernetes Version 1.9 oder eine höhere Version ausführen, können Sie auch auswählen, dass [Trusted Compute](cs_secure.html#trusted_compute) aktiviert wird, um Ihre Workerknoten auf Manipulation zu überprüfen. Wenn Sie Trusted Compute während der Clustererstellung nicht aktivieren, dies jedoch später nachholen möchten, können Sie den [Befehl](cs_cli_reference.html#cs_cluster_feature_enable) `bx cs feature-enable` verwenden. Nachdem Sie Trusted Compute aktiviert haben, können Sie es später nicht mehr inaktivieren. 

        Stellen Sie sicher, dass Sie eine Bare-Metal-Maschine bereitstellen wollen. Da die Abrechnung monatlich erfolgt, wird Ihnen ein voller Monat auch dann berechnet, wenn Sie versehentlich bestellen und sofort danach Ihre Bestellung wieder stornieren. {:tip}

    4.  **Standard**: Wählen Sie einen Maschinentyp aus und geben Sie die Anzahl der Workerknoten an, die Sie benötigen. Der Maschinentyp definiert die Menge an virtueller CPU, Hauptspeicher und Festplattenspeicher, die in jedem Workerknoten eingerichtet wird und allen Containern zur Verfügung steht. Die verfügbaren Bare-Metal- und virtuellen Maschinentypen variieren je nach dem Standort, an dem Sie den Cluster bereitstellen. Weitere Informationen finden Sie in der Dokumentation zum [Befehl](cs_cli_reference.html#cs_machine_types) `bx cs machine-type`. Nachdem Sie Ihre Cluster erstellt haben, können Sie unterschiedliche Maschinentypen hinzufügen, indem Sie einen neuen Workerknoten zum Cluster hinzufügen. 

    5. **Standard**: Wählen Sie ein öffentliches VLAN (optional) und ein privates VLAN (erforderlich) in Ihrem Konto von IBM Cloud Infrastructure (SoftLayer) aus. Beide VLANs kommunizieren zwischen Workerknoten, das öffentliche VLAN kommuniziert jedoch auch mit dem von IBM verwalteten Kubernetes-Master. Sie können dasselbe VLAN für mehrere Cluster verwenden.
        **Hinweis:** Falls Sie sich gegen die Verwendung eines öffentlichen VLAN entscheiden, müssen Sie eine alternative Lösung konfigurieren. Weitere Informationen hierzu finden Sie unter [VLAN-Verbindung für Workerknoten](#worker_vlan_connection).

    6. Standardmäßig ist **Lokale Festplatte verschlüsseln** ausgewählt. Wenn Sie dieses Kontrollkästchen abwählen, werden die Docker-Daten des Hosts nicht verschlüsselt.[Hier erfahren Sie mehr zur Verschlüsselung](cs_secure.html#encrypted_disks).

4. Klicken Sie auf **Cluster einrichten**. Auf der Registerkarte **Workerknoten** können Sie den Fortschritt der Bereitstellung des Workerknotens überprüfen. Nach Abschluss der Bereitstellung können Sie auf der Registerkarte **Übersicht** sehen, dass Ihr Cluster bereit ist.
    **Hinweis:** Jedem Workerknoten werden eine eindeutige Workerknoten-ID und ein Domänenname zugeordnet, die nach dem Erstellen des Clusters nicht manuell geändert werden dürfen. Wenn die ID oder der Domänenname geändert wird, kann der Kubernetes-Master Ihren Cluster nicht mehr verwalten.

**Womit möchten Sie fortfahren? **

Wenn der Cluster betriebsbereit ist, können Sie sich mit den folgenden Tasks vertraut machen:

-   [Installieren Sie die Befehlszeilenschnittstellen (CLIs) und nehmen Sie die Arbeit mit dem Cluster auf.](cs_cli_install.html#cs_cli_install)
-   [Stellen Sie eine App in Ihrem Cluster bereit.](cs_app.html#app_cli)
-   [Richten Sie Ihre eigene private Registry in {{site.data.keyword.Bluemix_notm}} ein, um Docker-Images zu speichern und gemeinsam mit
anderen Benutzern zu verwenden.](/docs/services/Registry/index.html)
- Wenn Sie über mehrere VLANs für einen Cluster oder über mehrere Teilnetze in demselben VLAN verfügen, müssen Sie [VLAN-Spanning aktivieren](/docs/infrastructure/vlans/vlan-spanning.html#enable-or-disable-vlan-spanning), damit die Workerknoten in dem privaten Netz miteinander kommunizieren können. 
- Wenn Sie eine Firewall haben, müssen Sie unter Umständen [die erforderlichen Ports öffnen](cs_firewall.html#firewall), um die Befehle `bx`, `kubectl` oder `calicotl` zu verwenden, um von Ihrem Cluster ausgehenden Datenverkehr bzw. eingehenden Datenverkehr für Netzservices zuzulassen.

<br />


## Cluster über die CLI erstellen
{: #clusters_cli}

Der Zweck des Kubernetes-Clusters besteht darin, eine Gruppe von Ressourcen, Knoten, Netzen und Speichereinheiten zu definieren, die die Hochverfügbarkeit von Apps sicherstellen. Bevor Sie eine App bereitstellen können, müssen Sie zunächst einen Cluster erstellen und die Definitionen für die Workerknoten in diesem Cluster festlegen.
{:shortdesc}

Vorbemerkungen:
- Sie müssen über ein nutzungsabhängiges [{{site.data.keyword.Bluemix_notm}}-Konto](https://console.bluemix.net/registration/) oder über ein Abonnementkonto verfügen. Sie können 1 kostenlosen Cluster erstellen, um einige der Leistungsmerkmale zu testen. Oder Sie können Standardcluster mit Ihrer Auswahl an Hardwareisolation erstellen. 
- [Stellen Sie sicher, dass Sie die erforderlichen Berechtigungen zum Bereitstellen eines Standardclusters in IBM Cloud Infrastructure (SoftLayer) haben](cs_users.html#infra_access).

Gehen Sie wie folgt vor, um einen Cluster zu erstellen:

1.  Installieren Sie die {{site.data.keyword.Bluemix_notm}}-CLI sowie das [{{site.data.keyword.containershort_notm}}-Plug-in](cs_cli_install.html#cs_cli_install).

2.  Melden Sie sich an der {{site.data.keyword.Bluemix_notm}}-CLI an. Geben Sie Ihre
{{site.data.keyword.Bluemix_notm}}-Berechtigungsnachweise ein, wenn
Sie dazu aufgefordert werden.

    ```
    bx login
    ```
    {: pre}

    **Hinweis:** Falls Sie über eine eingebundene ID verfügen, geben Sie `bx login --sso` ein, um sich an der Befehlszeilenschnittstelle von {{site.data.keyword.Bluemix_notm}} anzumelden. Geben Sie Ihren Benutzernamen ein und verwenden Sie die bereitgestellte URL in Ihrer CLI-Ausgabe, um Ihren einmaligen Kenncode abzurufen. Bei Verwendung einer eingebundenen ID schlägt die Anmeldung ohne die Option `--sso` fehl, mit der Option `--sso` ist sie erfolgreich.

3. Wenn Sie über mehrere {{site.data.keyword.Bluemix_notm}}-Konten verfügen, dann wählen Sie das Konto aus, unter dem Sie Ihren Kubernetes-Cluster erstellen wollen.

4.  Wenn Sie Kubernetes-Cluster in einer anderen als der zuvor ausgewählten {{site.data.keyword.Bluemix_notm}}-Region erstellen wollen, führen Sie `bx cs region-set` aus.

6.  Erstellen Sie einen Cluster.

    1.  **Standardcluster**: Überprüfen Sie, welche Standorte verfügbar sind. Welche Standorte angezeigt werden, hängt von der {{site.data.keyword.containershort_notm}}-Region ab, bei der Sie angemeldet sind.

        ```
        bx cs locations
        ```
        {: pre}

        Ihre CLI-Ausgabe stimmt mit den [Standorten für die Containerregion überein](cs_regions.html#locations).

    2.  **Standardcluster**: Wählen Sie einen Standort aus und prüfen Sie, welche Maschinentypen an diesem Standort verfügbar sind. Der Maschinentyp gibt an, welche virtuellen oder physischen Rechenhosts jedem Workerknoten zur Verfügung stehen. 

        -  Zeigen Sie das Feld **Servertyp** an, um zwischen virtuellen oder physischen Maschinen (Bare-Metal-Maschinen) auszuwählen. 
        -  **Virtuell**: Die Abrechnung erfolgt stündlich. Virtuelle Maschinen werden auf gemeinsam genutzter oder dedizierter Hardware bereitgestellt. 
        -  **Physisch**: Die Abrechnung erfolgt monatlich. Bare-Metal-Server werden durch manuelle Interaktion mit IBM Cloud Infrastructure (SoftLayer) bereitgestellt, daher kann die Ausführung mehr als einen Arbeitstag dauern. Bare-Metal-Server eignen sich am besten für Hochleistungsanwendungen, die mehr Ressourcen und Hoststeuerung erfordern.

        - **Physische Maschinen mit Trusted Compute**: Für Bare-Metal-Cluster, auf denen Kubernetes Version 1.9 oder höher ausgeführt wird, können Sie auch auswählen, dass [Trusted Compute](cs_secure.html#trusted_compute) aktiviert wird, um Ihre Bare-Metal-Workerknoten auf Manipulation zu überprüfen. Wenn Sie Trusted Compute während der Clustererstellung nicht aktivieren, dies jedoch später nachholen möchten, können Sie den [Befehl](cs_cli_reference.html#cs_cluster_feature_enable) `bx cs feature-enable` verwenden. Nachdem Sie Trusted Compute aktiviert haben, können Sie es später nicht mehr inaktivieren. 
        -  **Maschinentypen**: Um zu entscheiden, welcher Maschinentyp bereitgestellt werden soll, überprüfen Sie die Kombination aus Kern, Hauptspeicher und Speicher oder sehen Sie in der [Dokumentation zum Befehl](cs_cli_reference.html#cs_machine_types) `bx cs machine-type` nach. Nachdem Sie Ihre Cluster erstellt haben, können Sie unterschiedliche physische oder virtuelle Maschinentypen hinzufügen, indem Sie den [Befehl](cs_cli_reference.html#cs_worker_add) `bx cs worker-add` verwenden.

           Stellen Sie sicher, dass Sie eine Bare-Metal-Maschine bereitstellen wollen. Da die Abrechnung monatlich erfolgt, wird Ihnen ein voller Monat auch dann berechnet, wenn Sie versehentlich bestellen und sofort danach Ihre Bestellung wieder stornieren. {:tip}

        <pre class="pre">bx cs machine-types &lt;standort&gt;</pre>

    3.  **Standardcluster**: Prüfen Sie, ob in IBM Cloud Infrastructure (SoftLayer) bereits ein öffentliches und ein privates VLAN für dieses Konto vorhanden ist.

        ```
        bx cs vlans <standort>
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

        Falls bereits ein öffentliches oder privates VLAN vorhanden ist, notieren Sie sich die passenden Router. Private VLAN-Router beginnen immer mit `bcr` (Back-End-Router) und öffentliche VLAN-Router immer mit `fcr` (Front-End-Router). Die Zahlen- und Buchstabenkombination nach diesen Präfixen muss übereinstimmen, damit diese VLANs beim Erstellen eines Clusters verwendet werden können. In der Beispielausgabe können alle privaten VLANs mit allen öffentlichen VLANs verwendet werden, weil alle Router `02a.dal10` enthalten.

        Sie müssen Ihre Workerknoten mit einem privaten VLAN verbinden und Sie können Ihre Workerknoten optional auch mit einem öffentliches VLAN verbinden. **Hinweis:** Falls Sie sich gegen die Verwendung eines öffentlichen VLAN entscheiden, müssen Sie eine alternative Lösung konfigurieren. Weitere Informationen hierzu finden Sie unter [VLAN-Verbindung für Workerknoten](#worker_vlan_connection).

    4.  **Kostenlose und Standardcluster**: Führen Sie den Befehl `cluster-create` aus. Sie haben die Wahl zwischen einem kostenlosen Cluster, der einen Workerknoten mit zwei virtuellen CPUs (vCPUs) und 4 GB Hauptspeicher umfasst, und einem Standardcluster in Ihrem Konto in der IBM Cloud-Infrastructure (SoftLayer), der nach Bedarf beliebig viele Workerknoten umfassen kann. Wenn Sie einen Standardcluster erstellen, werden die Platten der Workerknoten standardmäßig verschlüsselt, die zugehörige Hardware wird von mehreren IBM Kunden gemeinsam genutzt und es wird nach Nutzungsstunden abgerechnet. </br>Beispiel eines Standardclusters. Geben Sie die Optionen für den Cluster an: 

        ```
        bx cs cluster-create --location dal10 --machine-type u2c.2x4 --hardware <shared_or_dedicated> --public-vlan <public_vlan_id> --private-vlan <private_vlan_id> --workers 3 --name <cluster_name> --kube-version <major.minor.patch> [--disable-disk-encrypt] [--trusted]
        ```
        {: pre}

        Beispiel für einen kostenlosen Cluster. Geben Sie den Clusternamen an: 

        ```
        bx cs cluster-create --name mein_cluster
        ```
        {: pre}

        <table>
        <caption>Tabelle. Erklärung der Bestandteile des Befehls <code>bx cs cluster-create</code></caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der Bestandteile dieses Befehls</th>
        </thead>
        <tbody>
        <tr>
        <td><code>cluster-create</code></td>
        <td>Der Befehl zum Erstellen eines Clusters in Ihrer {{site.data.keyword.Bluemix_notm}}-Organisation.</td>
        </tr>
        <tr>
        <td><code>--location <em>&lt;standort&gt;</em></code></td>
        <td>**Standardcluster**: Ersetzen Sie <em>&lt;standort&gt;</em> durch die {{site.data.keyword.Bluemix_notm}}-Standort-ID, an der Sie Ihren Cluster erstellen möchten. [Verfügbare Standorte](cs_regions.html#locations) sind von der {{site.data.keyword.containershort_notm}}-Region abhängig, bei der Sie angemeldet sind.</td>
        </tr>
        <tr>
        <td><code>--machine-type <em>&lt;maschinentyp&gt;</em></code></td>
        <td>**Standardcluster**: Wählen Sie einen Maschinentyp aus. Sie können Ihre Workerknoten als virtuelle Maschinen auf gemeinsam genutzter oder dedizierter Hardware oder als physische Maschinen auf Bare-Metal-Systemen bereitstellen. Die verfügbaren physischen und virtuellen Maschinentypen variieren je nach dem Standort, an dem Sie den Cluster bereitstellen. Weitere Informationen finden Sie in der Dokumentation zum [Befehl](cs_cli_reference.html#cs_machine_types) `bx cs machine-type`. Bei kostenlosen Clustern muss kein Maschinentyp definiert werden.</td>
        </tr>
        <tr>
        <td><code>--hardware <em>&lt;shared_oder_dedicated&gt;</em></code></td>
        <td>**Standardcluster, nur virtuell**: Die Stufe der Hardwareisolation für Ihren Workerknoten. Verwenden Sie 'dedicated', wenn Sie verfügbare physische Ressourcen haben möchten, die nur Sie nutzen können, oder 'shared', um zuzulassen, dass physische Ressourcen mit anderen IBM Kunden gemeinsam genutzt werden können. Die Standardeinstellung ist 'shared'. Dieser Wert ist für Standardcluster optional und steht für kostenlose Cluster nicht zur Verfügung.</td>
        </tr>
        <tr>
        <td><code>--public-vlan <em>&lt;id_des_öffentlichen_vlan&gt;</em></code></td>
        <td><ul>
          <li>**Kostenlose Cluster**: Sie müssen kein öffentliches VLAN definieren. Ihr kostenloser Cluster wird automatisch mit einem öffentlichen VLAN von IBM verbunden.</li>
          <li>**Standardcluster**: Wenn für diesen Standort bereits ein öffentliches VLAN in Ihrem Konto von IBM Cloud Infrastructure (SoftLayer) eingerichtet ist, geben Sie die ID des öffentlichen VLAN ein. Wenn Sie Ihre Workerknoten nur mit einem private VLAN verbinden möchten, geben Sie diese Option nicht an. **Hinweis:** Falls Sie sich gegen die Verwendung eines öffentlichen VLAN entscheiden, müssen Sie eine alternative Lösung konfigurieren. Weitere Informationen hierzu finden Sie unter [VLAN-Verbindung für Workerknoten](#worker_vlan_connection).<br/><br/>
          <strong>Hinweis</strong>: Private VLAN-Router beginnen immer mit <code>bcr</code> (Back-End-Router) und öffentliche VLAN-Router immer mit <code>fcr</code> (Front-End-Router). Die Zahlen- und Buchstabenkombination nach diesen Präfixen muss übereinstimmen, damit diese VLANs beim Erstellen eines Clusters verwendet werden können.</li>
        </ul></td>
        </tr>
        <tr>
        <td><code>--private-vlan <em>&lt;id_des_privaten_vlan&gt;</em></code></td>
        <td><ul><li>**Kostenlose Cluster**: Sie müssen kein privates VLAN definieren. Ihr kostenloser Cluster wird automatisch mit einem privaten VLAN von IBM verbunden.</li><li>**Standardcluster**: Wenn für diesen Standort bereits ein privates VLAN in Ihrem Konto von IBM Cloud Infrastructure (SoftLayer) eingerichtet ist, geben Sie die ID des privaten VLAN ein. Wenn Sie noch nicht über ein privates VLAN für dieses Konto verfügen, geben Sie diese Option nicht an. {{site.data.keyword.containershort_notm}} erstellt automatisch ein privates VLAN für Sie.<br/><br/><strong>Hinweis</strong>: Private VLAN-Router beginnen immer mit <code>bcr</code> (Back-End-Router) und öffentliche VLAN-Router immer mit <code>fcr</code> (Front-End-Router). Die Zahlen- und Buchstabenkombination nach diesen Präfixen muss übereinstimmen, damit diese VLANs beim Erstellen eines Clusters verwendet werden können.</li></ul></td>
        </tr>
        <tr>
        <td><code>--name <em>&lt;name&gt;</em></code></td>
        <td>**Kostenlose und Standardcluster**: Ersetzen Sie <em>&lt;name&gt;</em> durch den Namen Ihres Clusters. Der Name muss mit einem Buchstaben beginnen, darf Buchstaben, Ziffern und den Bindestrich enthalten und darf maximal 35 Zeichen lang sein. Beachten Sie, dass die {{site.data.keyword.IBM_notm}}-zugeordnete Ingress-Unterdomäne aus dem Clusternamen abgeleitet wird. Der Clustername und die Ingress-Unterdomäne bilden zusammen den vollständig qualifizierten Domänennamen, der innerhalb einer Region eindeutig sein muss und maximal 63 Zeichen lang sein darf. Um diese Anforderungen zu erfüllen, kann der Clustername abgeschnitten werden oder der Unterdomäne können zufällige Zeichenwerte zugeordnet werden.</td>
        </tr>
        <tr>
        <td><code>--workers <em>&lt;anzahl&gt;</em></code></td>
        <td>**Standardcluster**: Die Anzahl der Workerknoten, die im Cluster eingebunden werden sollen. Wird die Option <code>--workers</code> nicht angegeben, wird 1 Workerknoten erstellt.</td>
        </tr>
        <tr>
          <td><code>--kube-version <em>&lt;major.minor.patch&gt;</em></code></td>
          <td>**Standardcluster**: Die Kubernetes-Version für den Cluster-Masterknoten. Dieser Wert ist optional. Wenn nicht anders angegeben, wird der Cluster mit dem Standard für unterstützte Kubernetes-Versionen erstellt. Führen Sie den Befehl <code>bx cs kube-versions</code> aus, um die verfügbaren Versionen anzuzeigen.</td>
        </tr>
        <tr>
        <td><code>--disable-disk-encrypt</code></td>
        <td>**Kostenloser und Standardcluster**: Workerknoten weisen standardmäßig Verschlüsselung auf: [Weitere Informationen finden Sie hier](cs_secure.html#encrypted_disks). Wenn Sie die Verschlüsselung inaktivieren möchten, schließen Sie diese Option ein.</td>
        </tr>
        <tr>
        <td><code>--trusted</code></td>
        <td>**Standard-Bare-Metal-Cluster**: Aktivieren Sie [Trusted Compute](cs_secure.html#trusted_compute), um Ihre Bare-Metal-Workerknoten auf Manipulation zu überprüfen. Wenn Sie Trusted Compute während der Clustererstellung nicht aktivieren, dies jedoch später nachholen möchten, können Sie den [Befehl](cs_cli_reference.html#cs_cluster_feature_enable) `bx cs feature-enable` verwenden. Nachdem Sie Trusted Compute aktiviert haben, können Sie es später nicht mehr inaktivieren. </td>
        </tr>
        </tbody></table>

7.  Prüfen Sie, ob die Erstellung des Clusters angefordert wurde.

    ```
    bx cs clusters
    ```
    {: pre}

    **Hinweis:** Bei virtuellen Maschinen kann es einige Minuten dauern, bis die Workerknotenmaschinen angewiesen werden und der Cluster in Ihrem
Konto eingerichtet und bereitgestellt wird. Physische Bare-Metal-Maschinen werden durch einen manuelle Interaktion mit IBM Cloud Infrastructure (SoftLayer) bereitgestellt, daher kann die Ausführung mehr als einen Arbeitstag dauern. 

    Nach Abschluss der Bereitstellung Ihres Clusters wird der Status des
Clusters in **deployed** (Bereitgestellt) geändert.

    ```
    Name         ID                                   State      Created          Workers   Location   Version
    my_cluster   paf97e8843e29941b49c598f516de72101   deployed   20170201162433   1         mil01      1.8.8
    ```
    {: screen}

8.  Überprüfen Sie den Status der Workerknoten.

    ```
    bx cs workers <cluster>
    ```
    {: pre}

    Wenn die Workerknoten bereit sind, wechselt der Zustand (State) zu **Normal**, während für den Status die Angabe **Bereit** angezeigt wird. Wenn der Knotenstatus **Bereit** lautet, können Sie auf den Cluster zugreifen.

    **Hinweis:** Jedem Workerknoten werden eine eindeutige Workerknoten-ID und ein Domänenname zugeordnet, die nach der Erstellung des Clusters nicht manuell geändert werden dürfen. Wenn die ID oder der Domänenname geändert wird, kann der Kubernetes-Master Ihren Cluster nicht mehr verwalten.

    ```
    ID                                                 Public IP       Private IP       Machine Type   State    Status   Location   Version
    kube-mil01-paf97e8843e29941b49c598f516de72101-w1   169.47.223.113  10.171.42.93    free           normal   Ready    mil01      1.8.8
    ```
    {: screen}

9. Legen Sie den von Ihnen erstellten Cluster als Kontext für diese Sitzung fest. Führen Sie diese Konfigurationsschritte jedes Mal aus, wenn Sie mit Ihrem Cluster arbeiten.
    1.  Ermitteln Sie den Befehl zum Festlegen der Umgebungsvariablen und laden Sie die Kubernetes-Konfigurationsdateien herunter.

        ```
        bx cs cluster-config <clustername_oder_-id>
        ```
        {: pre}

        Wenn
der Download der Konfigurationsdateien abgeschlossen ist, wird ein Befehl angezeigt, den Sie verwenden können,
um den Pfad zu der lokalen Kubernetes-Konfigurationsdatei als Umgebungsvariable festzulegen.

        Beispiel für OS X:

        ```
        export KUBECONFIG=/Users/<benutzername>/.bluemix/plugins/container-service/clusters/<clustername>/kube-config-prod-dal10-<clustername>.yml
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
        /Users/<benutzername>/.bluemix/plugins/container-service/clusters/<clustername>/kube-config-prod-dal10-<clustername>.yml

        ```
        {: screen}

10. Starten Sie Ihr Kubernetes-Dashboard über den Standardport `8001`.
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

-   [Stellen Sie eine App in Ihrem Cluster bereit.](cs_app.html#app_cli)
-   [Verwalten Sie Ihren Cluster über die Befehlszeile `kubectl`. ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/user-guide/kubectl/)
-   [Richten Sie Ihre eigene private Registry in {{site.data.keyword.Bluemix_notm}} ein, um Docker-Images zu speichern und gemeinsam mit
anderen Benutzern zu verwenden.](/docs/services/Registry/index.html)
- Wenn Sie über mehrere VLANs für einen Cluster oder über mehrere Teilnetze in demselben VLAN verfügen, müssen Sie [VLAN-Spanning aktivieren](/docs/infrastructure/vlans/vlan-spanning.html#enable-or-disable-vlan-spanning), damit die Workerknoten in dem privaten Netz miteinander kommunizieren können. 
- Wenn Sie eine Firewall haben, müssen Sie unter Umständen [die erforderlichen Ports öffnen](cs_firewall.html#firewall), um die Befehle `bx`, `kubectl` oder `calicotl` zu verwenden, um von Ihrem Cluster ausgehenden Datenverkehr bzw. eingehenden Datenverkehr für Netzservices zuzulassen.

<br />




## Clusterstatus anzeigen
{: #states}

Überprüfen Sie den Status eines Kubernetes-Clusters, um Informationen zur Verfügbarkeit und Kapazität des Clusters sowie zu möglichen Problemen, die aufgetreten sein können, zu erhalten.
{:shortdesc}

Wenn Sie Informationen zu einem bestimmten Cluster anzeigen möchten, z. B. Standort, Master-URL, Ingress-Subdomain, Version, Worker, Eigner und Überwachungsdashboard, verwenden Sie den [Befehl](cs_cli_reference.html#cs_cluster_get) `bx cs cluster-get<mycluster>`. Schließen Sie das Flag `-- showResources` ein, um weitere Clusterressourcen, wie z. B. Add-ons für Speicherpods oder Teilnetz-VLANs für öffentliche und private IPs anzuzeigen.

Sie können den aktuellen Clusterstatus anzeigen, indem Sie den Befehl `bx cs clusters` ausführen. Der Status wird im entsprechenden **Statusfeld** angezeigt. Informationen zum Beheben von Fehlern bei Clustern und Workerknoten finden Sie im Abschnitt [Fehlerbehebung bei Clustern](cs_troubleshoot.html#debug_clusters).

<table summary="Jede Tabellenzeile sollte von links nach rechts gelesen werden, wobei der Clusterstatus in der ersten Spalte und eine Beschreibung in der zweiten Spalte angegeben ist.">
   <thead>
   <th>Clusterstatus</th>
   <th>Beschreibung</th>
   </thead>
   <tbody>
<tr>
   <td>Aborted (Abgebrochen)</td>
   <td>Das Löschen des Clusters wird vom Benutzer angefordert, bevor der Kubernetes Master bereitgestellt ist. Nachdem das Löschen des Clusters abgeschlossen ist, wird der Cluster aus dem Dashboard entfernt. Wenn Ihr Cluster in diesem Status lange Zeit blockiert ist, öffnen Sie ein [ {{site.data.keyword.Bluemix_notm}}-Support-Ticket](/docs/get-support/howtogetsupport.html#using-avatar). </td>
   </tr>
 <tr>
     <td>Critical (Kritisch)</td>
     <td>Der Kubernetes-Master kann nicht erreicht werden oder alle Workerknoten in dem Cluster sind inaktiv. </td>
    </tr>
   <tr>
     <td>Delete failed (Löschen fehlgeschlagen)</td>
     <td>Der Kubernetes Masterknoten oder mindestens ein Workerknoten kann nicht gelöscht werden. </td>
   </tr>
   <tr>
     <td>Deleted (Gelöscht)</td>
     <td>Der Cluster wird gelöscht, aber noch nicht aus dem Dashboard entfernt. Wenn Ihr Cluster in diesem Status lange Zeit blockiert ist, öffnen Sie ein [ {{site.data.keyword.Bluemix_notm}}Support-Ticket](/docs/get-support/howtogetsupport.html#using-avatar). </td>
   </tr>
   <tr>
   <td>Deleting (Löschen)</td>
   <td>Der Cluster wird gelöscht, und die Clusterinfrastruktur wird abgebaut. Der Zugriff auf den Cluster ist nicht möglich. </td>
   </tr>
   <tr>
     <td>Deploy failed (Bereitstellung fehlgeschlagen)</td>
     <td>Die Bereitstellung des Kubernetes-Masters konnte nicht abgeschlossen werden. Sie können diesen Status nicht auflösen. WenSnen Sie sich an den Support für IBM Cloud, indem Sie ein [{{site.data.keyword.Bluemix_notm}}-Support-Ticket](/docs/get-support/howtogetsupport.html#using-avatar) öffnen.</td>
   </tr>
     <tr>
       <td>Deploying (Wird bereitgestellt)</td>
       <td>Der Kubernetes-Master ist noch nicht vollständig implementiert. Sie können auf Ihren Cluster nicht zugreifen. Warten Sie, bis Ihr Cluster vollständig bereitgestellt wurde, und überprüfen Sie dann den Status Ihres Clusters. </td>
      </tr>
      <tr>
       <td>Normal</td>
       <td>Alle Workerknoten in einem Cluster sind betriebsbereit. Sie können auf den Cluster zugreifen und Apps auf dem Cluster bereitstellen. Dieser Status wird als einwandfreier Zustand betrachtet und erfordert keine Aktion von Ihnen.</td>
    </tr>
      <tr>
       <td>Pending (Anstehend)</td>
       <td>Der Kubernetes-Master ist bereitgestellt. Die Workerknoten werden gerade eingerichtet und sind noch nicht im Cluster verfügbar. Sie können auf den Cluster zugreifen, aber Sie können keine Apps auf dem Cluster bereitstellen.  </td>
     </tr>
   <tr>
     <td>Requested (Angefordert)</td>
     <td>Eine Anforderung zum Erstellen des Clusters und zum Bestellen der Infrastruktur für die Kubernetes Master- und Worker-Knoten wird gesendet. Wenn die Bereitstellung des Clusters gestartet wird, ändert sich der Clusterstatus in <code>Deploying</code> (Wird bereitgestellt). Wenn Ihr Cluster lange Zeit im Status <code>Requested</code> (Angefordert) blockiert ist, öffnen Sie ein [{{site.data.keyword.Bluemix_notm}}-Support-Ticket](/docs/get-support/howtogetsupport.html#using-avatar). </td>
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

Wenn Sie den Vorgang für einen Cluster beendet haben, können Sie den Cluster entfernen, sodass dieser keine Ressourcen mehr verbraucht.
{:shortdesc}

Kostenlose Cluster und Standardcluster, die mit einem nutzungsabhängigen Konto erstellt wurden, müssen vom Benutzer manuell entfernt werden, wenn sie nicht mehr benötigt werden.

Wenn Sie einen Cluster löschen, so löschen Sie zugleich auch Ressourcen, die sich diesem Cluster befinden, wie unter anderem Container, Pods, gebundene Services und geheime Schlüssel. Wenn Sie Ihren Speicher beim Löschen Ihres Clusters nicht löschen, können Sie Ihren Speicher über das Dashboard von IBM Cloud Infrastructure (SoftLayer) in der {{site.data.keyword.Bluemix_notm}}-GUI löschen. Bedingt durch den monatlichen Abrechnungszyklus kann ein Persistent Volume Claim (PVC) nicht am letzten Tag des Monats gelöscht werden. Wenn Sie den Persistent Volume Claim am letzten Tag des Monats entfernen, verbleibt die Löschung bis zum Beginn des nächsten Monats in einem anstehenden Zustand.

**Warnung:** In Ihrem persistenten Speicher werden keine Sicherungen Ihres Clusters oder Ihrer Daten erstellt. Das Löschen des Clusters kann nicht rückgängig gemacht werden.

-   Vorgehensweise bei Verwendung der {{site.data.keyword.Bluemix_notm}}-GUI:
    1.  Wählen Sie Ihren Cluster aus und klicken Sie im Menü **Weitere Aktionen...** auf **Löschen**.
-   Vorgehensweise bei Verwendung der {{site.data.keyword.Bluemix_notm}}-CLI:
    1.  Listen Sie die verfügbaren Cluster auf.

        ```
        bx cs clusters
        ```
        {: pre}

    2.  Löschen Sie den Cluster.

        ```
        bx cs cluster-rm mein_cluster
        ```
        {: pre}

    3.  Befolgen Sie die Eingabeaufforderungen und wählen Sie aus, ob Clusterressourcen gelöscht werden sollen.

Wenn Sie einen Cluster entfernen, können Sie auch die portierbaren Teilnetze und den zugehörigen persistenten Speicher entfernen:
- Teilnetze dienen zum Zuweisen von portierbaren öffentlichen IP-Adressen für Lastausgleichsservices oder für Ihre Ingress-Lastausgleichsfunktion für Anwendungen. Wenn Sie sie behalten, können Sie sie in einem neuen Cluster wiederverwenden oder manuell zu einem späteren Zeitpunkt aus Ihrem IBM Cloud Infrastructure (SoftLayer)-Portfolio löschen.
- Wenn Sie mithilfe einer [vorhandenen Dateifreigabe](cs_storage.html#existing) einen Persistent Volume Claim (PVC) erstellt haben, dann können Sie beim Löschen des Clusters die Dateifreigabe nicht löschen. Sie müssen die Dateifreigabe zu einem späteren Zeitpunkt manuell aus Ihrem IBM Cloud Infrastructure (SoftLayer)-Portfolio löschen.
- Persistenter Speicher bietet eine hohe Verfügbarkeit für Ihre Daten. Wenn Sie ihn löschen, können Sie Ihre Daten nicht wiederherstellen.
