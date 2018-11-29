---

copyright:
  years: 2014, 2018
lastupdated: "2018-10-25"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}



# Änderungsprotokoll der Version
{: #changelog}

Zeigen Sie Informationen zu Versionsänderungen für Hauptversions-, Nebenversions- und Patchaktualisierungen an, die für Ihre {{site.data.keyword.containerlong}}-Kubernetes-Cluster verfügbar sind. Diese Änderungen umfassen Updates für Kubernetes und {{site.data.keyword.Bluemix_notm}} Provider-Komponenten.
{:shortdesc}

Weitere Informationen zu Hauptversionen, Nebenversionen und Patchversionen sowie Migrationsaktionen zwischen Nebenversionen finden Sie unter [Kubernetes-Versionen](cs_versions.html).
{: tip}

Weitere Informationen zu Änderungen seit der vorherigen Version finden Sie in den Änderungsprotokollen.
-  Version 1.11 [changelog](#111_changelog).
-  Version 1.10, [Änderungsprotokoll](#110_changelog).
-  Version 1.9, [Änderungsprotokoll](#19_changelog).
-  [Archiv](#changelog_archive) der Änderungsprotokolle veralteter oder nicht unterstützter Versionen.

**Anmerkung**: Manche Änderungsprotokolle sind für _Fixpacks für Workerknoten_ konzipiert und können nur auf Workerknoten angewendet werden. Sie müssen [diese Patches anwenden](cs_cli_reference.html#cs_worker_update), um die Einhaltung der Sicherheitsbestimmungen für die Workerknoten sicherzustellen. Manche Änderungsprotokolle sind für _Master-Fixpacks_ konzipiert und können nur auf den Cluster-Master angewendet werden. Es kann vorkommen, dass Master-Fixpacks nicht automatisch angewendet werden. Sie können [sie manuell anwenden](cs_cli_reference.html#cs_cluster_update). Weitere Informationen zu Patchtypen finden Sie unter [Aktualisierungstypen](cs_versions.html#update_types).

</br>

## Version 1.11, Änderungsprotokoll
{: #111_changelog}

Überprüfen Sie die folgenden Änderungen.


### Änderungsprotokoll für Master-Fixpack 1.11.3_1527, veröffentlicht am 15. Oktober 2018
{: #1113_1527}

<table summary="Seit Version 1.11.3_1524 vorgenommene Änderungen">
<caption>Änderungen seit Version 1.11.3_1524</caption>
<thead>
<tr>
<th>Komponente</th>
<th>Vorher</th>
<th>Aktuell</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico-Konfiguration</td>
<td>n.z.</td>
<td>n.z.</td>
<td>Korrigiert Bereitschaftsprüfung für Container `calico-node` zur besseren Verarbeitung von Knotenfehlern.</td>
</tr>
<tr>
<td>Clusteraktualisierung</td>
<td>n.z.</td>
<td>n.z.</td>
<td>Korrigiert Problem beim Aktualisieren von Cluster-Add-ons, wenn der Master von einer nicht unterstützten Version aktualisiert wird.</td>
</tr>
</tbody>
</table>

### Änderungsprotokoll für Workerknoten-Fixpack 1.11.3_1525, veröffentlicht am 10. Oktober 2018
{: #1113_1525}

<table summary="Seit Version 1.11.3_1524 vorgenommene Änderungen">
<caption>Änderungen seit Version 1.11.3_1524</caption>
<thead>
<tr>
<th>Komponente</th>
<th>Vorher</th>
<th>Aktuell</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>4.4.0-133</td>
<td>4.4.0-137</td>
<td>Aktualisierte Workerknoten-Images mit Kernelaktualisierung für [CVE-2018-14633,CVE-2018-17182 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-137.163/changelog).</td>
</tr>
<tr>
<td>Inaktives Sitzungszeitlimit</td>
<td>n.z.</td>
<td>n.z.</td>
<td>Legen Sie für das Zeitlimit für inaktive Sitzungen 5 Minuten fest, damit die Anforderungen erfüllt werden.</td>
</tr>
</tbody>
</table>


### Änderungsprotokoll für 1.11.3_1524, veröffentlicht am 2. Oktober 2018
{: #1113_1524}

<table summary="Seit Version 1.11.3_1521 vorgenommene Änderungen">
<caption>Änderungen seit Version 1.11.3_1521</caption>
<thead>
<tr>
<th>Komponente</th>
<th>Vorher</th>
<th>Aktuell</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>containerd</td>
<td>1.1.3</td>
<td>1.1.4</td>
<td>Lesen Sie die [containerd-Releaseinformationen ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/containerd/containerd/releases/tag/v1.1.4).</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.11.3-91</td>
<td>v1.11.3-100</td>
<td>Der Dokumentationslink zu den Fehlernachrichten für die Lastausgleichsfunktion wurde aktualisiert.</td>
</tr>
<tr>
<td>IBM File Storage-Klassen</td>
<td>n.z.</td>
<td>n.z.</td>
<td>Der doppelte Parameter `reclaimPolicy` wurde in den IBM File Storage-Klassen entfernt.<br><br>
Außerdem bleibt die IBM File Storage-Standardklasse beim Aktualisieren des Cluster-Masters unverändert. Falls Sie die Standardspeicherklasse ändern möchten, führen Sie `kubectl patch storageclass <storageclass> -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'` aus und ersetzen `<storageclass>` durch den Namen der Speicherklasse.</td>
</tr>
</tbody>
</table>

### Änderungsprotokoll für 1.11.3_1521, veröffentlicht am 20. September 2018
{: #1113_1521}

<table summary="Seit Version 1.11.2_1516 vorgenommene Änderungen">
<caption>Änderungen seit Version 1.11.2_1516</caption>
<thead>
<tr>
<th>Komponente</th>
<th>Vorher</th>
<th>Aktuell</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>Version 1.11.2-71</td>
<td>v1.11.3-91</td>
<td>Wurde für die Unterstützung von Kubernetes 1.11.3 aktualisiert. </td>
</tr>
<tr>
<td>IBM File Storage-Klassen</td>
<td>n.z.</td>
<td>n.z.</td>
<td>`mountOptions` wurde in den IBM File Storage-Klassen entfernt, damit der Standardwert verwendet wird, der vom Workerknoten bereitgestellt wird.<br><br>
Außerdem bleibt die IBM File Storage-Standardklasse beim Aktualisieren des Cluster-Masters `ibmc-file-bronze`. Falls Sie die Standardspeicherklasse ändern möchten, führen Sie `kubectl patch storageclass <storageclass> -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'` aus und ersetzen `<storageclass>` durch den Namen der Speicherklasse.</td>
</tr>
<tr>
<td>Key Management Service-Provider</td>
<td>n.z.</td>
<td>n.z.</td>
<td>Die Möglichkeit zum Verwenden des Kubernetes-KMS-Providers (KMS - Key Management Service, Schlüsselmanagementservice) im Cluster wurde hinzugefügt, damit {{site.data.keyword.keymanagementservicefull}} unterstützt wird. Wenn Sie [{{site.data.keyword.keymanagementserviceshort}} im Cluster aktivieren](cs_encrypt.html#keyprotect), werden alle geheimen Kubernetes-Schlüssel verschlüsselt.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>Version 1.11.2</td>
<td>v1.11.3</td>
<td>Werfen Sie einen Blick auf die [Kubernetes-Releaseinformationen ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/kubernetes/kubernetes/releases/tag/v1.11.3).</td>
</tr>
<tr>
<td>Automatische Kubernetes DNS-Skalierung</td>
<td>1.1.2-r2</td>
<td>1.2.0</td>
<td>Lesen Sie die [Releaseinformationen zur automatischen Kubernetes-DNS-Skalierung ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes-incubator/cluster-proportional-autoscaler/releases/tag/1.2.0).</td>
</tr>
<tr>
<td>Protokollrotation</td>
<td>n.z.</td>
<td>n.z.</td>
<td>Von Zeitgebern des Typs `cronjobs` wurde zu `systemd` gewechselt, um ein Fehlschlagen von `logrotate` auf Workerknoten zu vermeiden, die nicht innerhalb von 90 Tagen erneute geladen oder aktualisiert werden. **Anmerkung**: In allen früheren Versionen für dieses Unterrelease war die primäre Platte mit Daten gefüllt, nachdem der Cron-Job fehlgeschlagen war, weil die Protokolle nicht rotiert wurden. Der Cron-Job schlägt fehl, nachdem der Workerknoten 90 Tage aktiv ist, ohne erneut aktualisiert oder geladen zu werden. Wenn die gesamte Speicherkapazität der primären Platte durch Protokolle erschöpft ist, wechselt der Workerknoten in den Status 'Fehlgeschlagen'. Der Fehler auf dem Workerknoten kann mit dem [Befehl](cs_cli_reference.html#cs_worker_reload) `ibmcloud ks worker-reload` oder dem [Befehl](cs_cli_reference.html#cs_worker_update) `ibmcloud ks worker-update` behoben werden.</td>
</tr>
<tr>
<td>Ablauf des Rootkennworts</td>
<td>n.z.</td>
<td>n.z.</td>
<td>Rootkennwörter für Workerknoten laufen aus Konformitätsgründen nach 90 Tagen ab. Wenn für die Automatisierungstools eine Anmeldung am Workerknoten erforderlich ist oder wenn sie auf Cron-Jobs angewiesen sind, die als Root ausgeführt werden, können Sie den Ablauf der Kennwortgültigkeit inaktivieren, indem Sie sich am Workerknoten anmelden und `chage -M -1 root` ausführen. **Anmerkung**: Falls Konformitätsanforderungen für die Sicherheit gelten, die eine Ausführung als Root oder eine Entfernung des Ablaufs der Kennwortgültigkeit verhindern, inaktivieren Sie nicht das Ablaufdatum. Stattdessen können Sie die Workerknoten mindestens alle 90 Tage [aktualisieren](cs_cli_reference.html#cs_worker_update) oder [erneut laden](cs_cli_reference.html#cs_worker_reload).</td>
</tr>
<tr>
<td>Laufzeitkomponenten für Workerknoten (`kubelet`, `kube-proxy`, `containerd`)</td>
<td>n.z.</td>
<td>n.z.</td>
<td>Entfernte Abhängigkeiten der Laufzeitkomponenten auf der primären Platte. Diese Erweiterung verhindert das Fehlschlagen von Workerknoten, wenn die Speicherkapazität auf der primären Platte erschöpft ist.</td>
</tr>
<tr>
<td>Systemd</td>
<td>n.z.</td>
<td>n.z.</td>
<td>Bereinigen Sie die temporären Mounteinheiten in regelmäßigen Abständen, um zu verhindern, dass sie unbegrenzt werden. Diese Aktion ist für [Kubernetes-Fehler 57345 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/kubernetes/kubernetes/issues/57345) vorgesehen.</td>
</tr>
</tbody>
</table>

### Änderungsprotokoll für 1.11.2_1516, veröffentlicht am 4. September 2018
{: #1112_1516}

<table summary="Seit Version 1.11.2_1514 vorgenommene Änderungen">
<caption>Änderungen seit Version 1.11.2_1514</caption>
<thead>
<tr>
<th>Komponente</th>
<th>Vorher</th>
<th>Aktuell</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>Version 3.1.3</td>
<td>Version 3.2.1</td>
<td>Werfen Sie einen Blick auf die [Calico-Releaseinformationen ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://docs.projectcalico.org/v3.2/releases/#v321).</td>
</tr>
<tr>
<td>containerd</td>
<td>1.1.2</td>
<td>1.1.3</td>
<td>Werfen Sie einen Blick auf die [`containerd`-Releaseinformationen ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/containerd/containerd/releases/tag/v1.1.3).</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>Version 1.11.2-60</td>
<td>Version 1.11.2-71</td>
<td>Die Cloud-Provider-Konfiguration wurde geändert, um die Verarbeitung von Aktualisierungen für die Lastausgleichsfunktionsservices zu verbessern, wenn `externalTrafficPolicy` auf `local` eingestellt ist.</td>
</tr>
<tr>
<td>Konfiguration des IBM File Storage-Plug-ins</td>
<td>n.z.</td>
<td>n.z.</td>
<td>Die NFS-Standardversion wurde aus den Mountoptionen in den von IBM bereitgestellten Dateispeicherklassen entfernt. Das Betriebssystem des Hosts vereinbart die NFS-Version jetzt mit dem NFS-Server der IBM Cloud-Infrastruktur (SoftLayer). Wenn Sie eine bestimmte NFS-Version manuell festlegen oder die NFS-Version Ihres PV ändern, die vom Betriebssystem des Hosts vereinbart wurde, finden Sie Informationen hierzu im Abschnitt [NFS-Standardversion ändern](cs_storage_file.html#nfs_version_class).</td>
</tr>
</tbody>
</table>

### Änderungsprotokoll für Workerknoten-Fixpack 1.11.2_1514, veröffentlicht am 23. August 2018
{: #1112_1514}

<table summary="Seit Version 1.11.2_1513 vorgenommene Änderungen">
<caption>Änderungen seit Version 1.11.2_1513</caption>
<thead>
<tr>
<th>Komponente</th>
<th>Vorher</th>
<th>Aktuell</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>`systemd`</td>
<td>229</td>
<td>230</td>
<td>Aktualisierung von `systemd` zur Korrektur des `cgroup`-Lecks.</td>
</tr>
<tr>
<td>Kernel</td>
<td>4.4.0-127</td>
<td>4.4.0-133</td>
<td>Aktualisierte Workerknoten-Images mit Kernelaktualisierung für [CVE-2018-3620,CVE-2018-3646 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://usn.ubuntu.com/3741-1/).</td>
</tr>
</tbody>
</table>

### Änderungsprotokoll für 1.11.2_1513, veröffentlicht am 14. August 2018
{: #1112_1513}

<table summary="Seit Version 1.10.5_1518 vorgenommene Änderungen">
<caption>Änderungen seit Version 1.10.5_1518</caption>
<thead>
<tr>
<th>Komponente</th>
<th>Vorher</th>
<th>Aktuell</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>containerd</td>
<td>n.z.</td>
<td>1.1.2</td>
<td>`containerd` ersetzt Docker als neue Containerlaufzeit für Kubernetes. Werfen Sie einen Blick auf die [`containerd`-Releaseinformationen ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/containerd/containerd/releases/tag/v1.1.2). Weitere Informationen zu den Maßnahmen, die Sie ergreifen müssen, finden Sie im Abschnitt zum [Migrieren auf `containerd` als Containerlaufzeit](cs_versions.html#containerd).</td>
</tr>
<tr>
<td>Docker</td>
<td>n.z.</td>
<td>n.z.</td>
<td>`containerd` ersetzt Docker zur Verbesserung der Leistung als neue Containerlaufzeit für Kubernetes. Weitere Informationen zu den Maßnahmen, die Sie ergreifen müssen, finden Sie im Abschnitt zum [Migrieren auf `containerd` als Containerlaufzeit](cs_versions.html#containerd).</td>
</tr>
<tr>
<td>etcd</td>
<td>Version 3.2.14</td>
<td>Version 3.2.18</td>
<td>Werfen Sie einen Blick auf die [etcd-Releaseinformationen ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/coreos/etcd/releases/v3.2.18).</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>Version 1.10.5-118</td>
<td>Version 1.11.2-60</td>
<td>Wurde für die Unterstützung von Kubernetes 1.11 aktualisiert. Darüber hinaus verwenden die Pods der Lastausgleichsfunktion jetzt die neue Podprioritätsklasse `ibm-app-cluster-critical`.</td>
</tr>
<tr>
<td>IBM File Storage-Plug-in</td>
<td>334</td>
<td>338</td>
<td>Aktualisierung von `incubator` auf Version 1.8. Der Dateispeicher wird für die von Ihnen ausgewählte Zone bereitgestellt. Sie können die Bezeichnungen einer vorhandenen (statischen) PV-Instanz nicht aktualisieren, es sei denn, Sie verwenden einen Mehrzonencluster und müssen die [Regions- und Zonenbezeichnungen hinzufügen](cs_storage_basics.html#multizone).</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>Version 1.10.5</td>
<td>Version 1.11.2</td>
<td>Werfen Sie einen Blick auf die [Kubernetes-Releaseinformationen ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/kubernetes/kubernetes/releases/tag/v1.11.2).</td>
</tr>
<tr>
<td>Kubernetes-Konfiguration</td>
<td>n.z.</td>
<td>n.z.</td>
<td>Aktualisierung der OpenID Connect-Konfiguration für den Kubernetes-API-Server zur Unterstützung von {{site.data.keyword.Bluemix_notm}} Identity and Access Management-Zugriffsgruppen. Der Option `--enable-admission-plugins` wurde `Priority` für den Kubernetes-API-Server des Clusters hinzugefügt und der Cluster wurde für die Unterstützung der Podpriorität konfiguriert. Weitere Informationen finden Sie unter:
<ul><li>[IAM-Zugriffsgruppen](cs_users.html#rbac)</li>
<li>[Podpriorität konfigurieren](cs_pod_priority.html#pod_priority)</li></ul></td>
</tr>
<tr>
<td>Kubernetes Heapster</td>
<td>Version 1.5.2</td>
<td>Version 1.5.4</td>
<td>Höhere Ressourcengrenzen für den Container `heapster-nanny`. Werfen Sie einen Blick auf die [Kubernetes Heapster-Releaseinformationen ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/kubernetes/heapster/releases/tag/v1.5.4).</td>
</tr>
<tr>
<td>Protokollierungskonfiguration</td>
<td>n.z.</td>
<td>n.z.</td>
<td>Als Containerprotokollverzeichnis wird nun `/var/log/pods/` anstelle von `/var/lib/docker/containers/` verwendet.</td>
</tr>
</tbody>
</table>

<br />


## Version 1.10, Änderungsprotokoll
{: #110_changelog}

Überprüfen Sie die folgenden Änderungen.

### Änderungsprotokoll für Master-Fixpack 1.10.8_1527, veröffentlicht am 15. Oktober 2018
{: #1108_1527}

<table summary="Seit Version 1.10.8_1524 vorgenommene Änderungen">
<caption>Änderungen seit Version 1.10.8_1524</caption>
<thead>
<tr>
<th>Komponente</th>
<th>Vorher</th>
<th>Aktuell</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico-Konfiguration</td>
<td>n.z.</td>
<td>n.z.</td>
<td>Korrigiert Bereitschaftsprüfung für Container `calico-node` zur besseren Verarbeitung von Knotenfehlern.</td>
</tr>
<tr>
<td>Clusteraktualisierung</td>
<td>n.z.</td>
<td>n.z.</td>
<td>Korrigiert Problem beim Aktualisieren von Cluster-Add-ons, wenn der Master von einer nicht unterstützten Version aktualisiert wird.</td>
</tr>
</tbody>
</table>

### Änderungsprotokoll für Workerknoten-Fixpack 1.10.8_1525, veröffentlicht am 10. Oktober 2018
{: #1108_1525}

<table summary="Seit Version 1.10.8_1524 vorgenommene Änderungen">
<caption>Änderungen seit Version 1.10.8_1524</caption>
<thead>
<tr>
<th>Komponente</th>
<th>Vorher</th>
<th>Aktuell</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>4.4.0-133</td>
<td>4.4.0-137</td>
<td>Aktualisierte Workerknoten-Images mit Kernelaktualisierung für [CVE-2018-14633,CVE-2018-17182 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-137.163/changelog).</td>
</tr>
<tr>
<td>Inaktives Sitzungszeitlimit</td>
<td>n.z.</td>
<td>n.z.</td>
<td>Legen Sie für das Zeitlimit für inaktive Sitzungen 5 Minuten fest, damit die Anforderungen erfüllt werden.</td>
</tr>
</tbody>
</table>


### Änderungsprotokoll für 1.10.8_1524, veröffentlicht am 2. Oktober 2018
{: #1108_1524}

<table summary="Seit Version 1.10.7_1520 vorgenommene Änderungen">
<caption>Änderungen seit Version 1.10.7_1520</caption>
<thead>
<tr>
<th>Komponente</th>
<th>Vorher</th>
<th>Aktuell</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>Key Management Service-Provider</td>
<td>n.z.</td>
<td>n.z.</td>
<td>Die Möglichkeit zum Verwenden des Kubernetes-KMS-Providers (KMS - Key Management Service, Schlüsselmanagementservice) im Cluster wurde hinzugefügt, damit {{site.data.keyword.keymanagementservicefull}} unterstützt wird. Wenn Sie [{{site.data.keyword.keymanagementserviceshort}} im Cluster aktivieren](cs_encrypt.html#keyprotect), werden alle geheimen Kubernetes-Schlüssel verschlüsselt.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>Version 1.10.7</td>
<td>v1.10.8</td>
<td>Lesen Sie die [Kubernetes-Releaseinformationen ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.8). </td>
</tr>
<tr>
<td>Automatische Kubernetes DNS-Skalierung</td>
<td>1.1.2-r2</td>
<td>1.2.0</td>
<td>Lesen Sie die [Releaseinformationen zur automatischen Kubernetes-DNS-Skalierung ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes-incubator/cluster-proportional-autoscaler/releases/tag/1.2.0).</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>Version 1.10.7-146</td>
<td>v1.10.8-172</td>
<td>Wurde für die Unterstützung von Kubernetes 1.10.8 aktualisiert. Der Dokumentationslink zu den Fehlernachrichten für die Lastausgleichsfunktion wurde auch aktualisiert.</td>
</tr>
<tr>
<td>IBM File Storage-Klassen</td>
<td>n.z.</td>
<td>n.z.</td>
<td>`mountOptions` wurde in den IBM File Storage-Klassen entfernt, damit der Standardwert verwendet wird, der vom Workerknoten bereitgestellt wird. Der doppelte Parameter `reclaimPolicy` wurde in den IBM File Storage-Klassen entfernt.<br><br>
Außerdem bleibt die IBM File Storage-Standardklasse beim Aktualisieren des Cluster-Masters unverändert. Falls Sie die Standardspeicherklasse ändern möchten, führen Sie `kubectl patch storageclass <storageclass> -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'` aus und ersetzen `<storageclass>` durch den Namen der Speicherklasse.</td>
</tr>
</tbody>
</table>

### Änderungsprotokoll für Workerknoten-Fixpack 1.10.7_1521, veröffentlicht am 20. September 2018
{: #1107_1521}

<table summary="Seit Version 1.10.7_1520 vorgenommene Änderungen">
<caption>Änderungen seit Version 1.10.7_1520</caption>
<thead>
<tr>
<th>Komponente</th>
<th>Vorher</th>
<th>Aktuell</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>Protokollrotation</td>
<td>n.z.</td>
<td>n.z.</td>
<td>Von Zeitgebern des Typs `cronjobs` wurde zu `systemd` gewechselt, um ein Fehlschlagen von `logrotate` auf Workerknoten zu vermeiden, die nicht innerhalb von 90 Tagen erneute geladen oder aktualisiert werden. **Anmerkung**: In allen früheren Versionen für dieses Unterrelease war die primäre Platte mit Daten gefüllt, nachdem der Cron-Job fehlgeschlagen war, weil die Protokolle nicht rotiert wurden. Der Cron-Job schlägt fehl, nachdem der Workerknoten 90 Tage aktiv ist, ohne erneut aktualisiert oder geladen zu werden. Wenn die gesamte Speicherkapazität der primären Platte durch Protokolle erschöpft ist, wechselt der Workerknoten in den Status 'Fehlgeschlagen'. Der Fehler auf dem Workerknoten kann mit dem [Befehl](cs_cli_reference.html#cs_worker_reload) `ibmcloud ks worker-reload` oder dem [Befehl](cs_cli_reference.html#cs_worker_update) `ibmcloud ks worker-update` behoben werden.</td>
</tr>
<tr>
<td>Laufzeitkomponenten für Workerknoten (`kubelet`, `kube-proxy`, `docker`)</td>
<td>n.z.</td>
<td>n.z.</td>
<td>Entfernte Abhängigkeiten der Laufzeitkomponenten auf der primären Platte. Diese Erweiterung verhindert das Fehlschlagen von Workerknoten, wenn die Speicherkapazität auf der primären Platte erschöpft ist.</td>
</tr>
<tr>
<td>Ablauf des Rootkennworts</td>
<td>n.z.</td>
<td>n.z.</td>
<td>Rootkennwörter für Workerknoten laufen aus Konformitätsgründen nach 90 Tagen ab. Wenn für die Automatisierungstools eine Anmeldung am Workerknoten erforderlich ist oder wenn sie auf Cron-Jobs angewiesen sind, die als Root ausgeführt werden, können Sie den Ablauf der Kennwortgültigkeit inaktivieren, indem Sie sich am Workerknoten anmelden und `chage -M -1 root` ausführen. **Anmerkung**: Falls Konformitätsanforderungen für die Sicherheit gelten, die eine Ausführung als Root oder eine Entfernung des Ablaufs der Kennwortgültigkeit verhindert, inaktivieren Sie nicht das Ablaufdatum. Stattdessen können Sie die Workerknoten mindestens alle 90 Tage [aktualisieren](cs_cli_reference.html#cs_worker_update) oder [erneut laden](cs_cli_reference.html#cs_worker_reload).</td>
</tr>
<tr>
<td>Systemd</td>
<td>n.z.</td>
<td>n.z.</td>
<td>Bereinigen Sie die temporären Mounteinheiten in regelmäßigen Abständen, um zu verhindern, dass sie unbegrenzt werden. Diese Aktion ist für [Kubernetes-Fehler 57345 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/kubernetes/kubernetes/issues/57345) vorgesehen.</td>
</tr>
<tr>
<td>Docker</td>
<td>n.z.</td>
<td>n.z.</td>
<td>Inaktiviert die Docker-Standard-Bridge, sodass der IP-Bereich `172.17.0.0/ 16` jetzt für private Routen verwendet wird. Wenn die Docker-Container in Workerknoten erstellt werden, weil `docker`-Befehle direkt auf dem Host ausgeführt werden oder weil ein Pod verwendet wird, von dem der Docker-Socket angehängt wird, wählen Sie eine der folgenden Optionen aus. <ul><li>Wenn Sie die externe Netzkonnektivität sicherstellen möchten, wenn Sie den Container erstellen, führen Sie `docker build --network host` aus.</li>
<li>Wenn Sie explizit ein Netz erstellen möchten, das beim Erstellen des Containers verwendet werden soll, führen Sie `docker network create` aus, und verwenden Sie anschließend dieses Netz.</li></ul>
**Anmerkung**: Sind Abhängigkeiten vom Docker-Socket oder direkt von Docker vorhanden? [Migrieren Sie auf `containerd` anstatt auf `docker` als Containerlaufzeit](cs_versions.html#containerd), sodass die Cluster auf die Ausführung von Kubernetes Version 1.11 oder eine aktuellere Version vorbereitet sind.</td>
</tr>
</tbody>
</table>

### Änderungsprotokoll für 1.10.7_1520, veröffentlicht am 4. September 2018
{: #1107_1520}

<table summary="Seit Version 1.10.5_1519 vorgenommene Änderungen">
<caption>Änderungen seit Version 1.10.5_1519</caption>
<thead>
<tr>
<th>Komponente</th>
<th>Vorher</th>
<th>Aktuell</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>Version 3.1.3</td>
<td>Version 3.2.1</td>
<td>Werfen Sie einen Blick auf die Calico-[Releaseinformationen ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://docs.projectcalico.org/v3.2/releases/#v321).</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>Version 1.10.5-118</td>
<td>Version 1.10.7-146</td>
<td>Wurde für die Unterstützung von Kubernetes 1.10.7 aktualisiert. Darüber hinaus wurde die Cloud-Provider-Konfiguration geändert, um die Verarbeitung von Aktualisierungen der Services für die Lastausgleichsfunktion zu verbessern, wenn für `externalTrafficPolicy` der Wert `local` eingestellt ist.</td>
</tr>
<tr>
<td>IBM File Storage-Plug-in</td>
<td>334</td>
<td>338</td>
<td>Aktualisierung des Inkubators auf Version 1.8. Der Dateispeicher wird für die von Ihnen ausgewählte Zone bereitgestellt. Sie können die Bezeichnungen einer vorhandenen (statischen) PV-Instanz nicht aktualisieren, es sei denn, Sie verwenden einen Mehrzonencluster und müssen die Regions- und Zonenbezeichnungen hinzufügen.<br><br> Die NFS-Standardversion wurde aus den Mountoptionen in den von IBM bereitgestellten Dateispeicherklassen entfernt. Das Betriebssystem des Hosts vereinbart die NFS-Version jetzt mit dem NFS-Server der IBM Cloud-Infrastruktur (SoftLayer). Wenn Sie eine bestimmte NFS-Version manuell festlegen oder die NFS-Version Ihres PV ändern, die vom Betriebssystem des Hosts vereinbart wurde, finden Sie Informationen hierzu im Abschnitt [NFS-Standardversion ändern](cs_storage_file.html#nfs_version_class).</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>Version 1.10.5</td>
<td>Version 1.10.7</td>
<td>Werfen Sie einen Blick auf die Kubernetes-[Releaseinformationen ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.7).</td>
</tr>
<tr>
<td>Konfiguration von Kubernetes Heapster</td>
<td>n.z.</td>
<td>n.z.</td>
<td>Höhere Ressourcengrenzen für den Container `heapster-nanny`.</td>
</tr>
</tbody>
</table>

### Änderungsprotokoll für Workerknoten-Fixpack 1.10.5_1519, veröffentlicht am 23. August 2018
{: #1105_1519}

<table summary="Seit Version 1.10.5_1518 vorgenommene Änderungen">
<caption>Änderungen seit Version 1.10.5_1518</caption>
<thead>
<tr>
<th>Komponente</th>
<th>Vorher</th>
<th>Aktuell</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>`systemd`</td>
<td>229</td>
<td>230</td>
<td>Aktualisierung von `systemd` zur Korrektur des `cgroup`-Lecks.</td>
</tr>
<tr>
<td>Kernel</td>
<td>4.4.0-127</td>
<td>4.4.0-133</td>
<td>Aktualisierte Workerknoten-Images mit Kernelaktualisierung für [CVE-2018-3620,CVE-2018-3646 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://usn.ubuntu.com/3741-1/).</td>
</tr>
</tbody>
</table>


### Änderungsprotokoll für Workerknoten-Fixpack 1.10.5_1518, veröffentlicht am 13. August 2018
{: #1105_1518}

<table summary="Seit Version 1.10.5_1517 vorgenommene Änderungen">
<caption>Änderungen seit Version 1.10.5_1517</caption>
<thead>
<tr>
<th>Komponente</th>
<th>Vorher</th>
<th>Aktuell</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu-Pakete</td>
<td>n.z.</td>
<td>n.z.</td>
<td>Aktualisierungen an installierten Ubuntu-Paketen.</td>
</tr>
</tbody>
</table>

### Änderungsprotokoll für 1.10.5_1517, veröffentlicht am 27. Juli 2018
{: #1105_1517}

<table summary="Seit Version 1.10.3_1514 vorgenommene Änderungen">
<caption>Änderungen seit Version 1.10.3_1514</caption>
<thead>
<tr>
<th>Komponente</th>
<th>Vorher</th>
<th>Aktuell</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>Version 3.1.1</td>
<td>Version 3.1.3</td>
<td>Werfen Sie einen Blick auf die Calico-[Releaseinformationen ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://docs.projectcalico.org/v3.1/releases/#v313).</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>Version 1.10.3-85</td>
<td>Version 1.10.5-118</td>
<td>Wurde für die Unterstützung von Kubernetes 1.10.5 aktualisiert. Darüber hinaus enthalten `create failure`-Ereignisse des LoadBalancer-Service nun alle Fehler portierbarer Teilnetze.</td>
</tr>
<tr>
<td>IBM File Storage-Plug-in</td>
<td>320</td>
<td>334</td>
<td>Das Zeitlimit bei der Erstellung persistenter Datenträger wurde von 15 auf 30 Minuten erhöht. Der Standardabrechnungstyp wurde in 'Stündlich' (`hourly`) geändert. Es wurden Mountoptionen zu den vordefinierten Speicherklassen hinzugefügt. In der NFS-Dateispeicherinstanz in Ihrem Konto der IBM Cloud-Infrastruktur (SoftLayer) wurde das Format des Felds **Anmerkungen** in JSON geändert und der Kubernetes-Namensbereich hinzugefügt, in dem der persistente Datenträger bereitgestellt ist. Für die Unterstützung von Mehrzonenclustern wurden persistenten Datenträgern Zonen- und Regionsbezeichnungen hinzugefügt.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>Version 1.10.3</td>
<td>Version 1.10.5</td>
<td>Werfen Sie einen Blick auf die Kubernetes-[Releaseinformationen ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.5).</td>
</tr>
<tr>
<td>Kernel</td>
<td>n.z.</td>
<td>n.z.</td>
<td>An den Netzeinstellungen für Workerknoten wurden kleinere Verbesserungen vorgenommen, um Netzarbeitslasten mit hoher Leistung zu unterstützen.</td>
</tr>
<tr>
<td>OpenVPN-Client</td>
<td>n.z.</td>
<td>n.z.</td>
<td>Die `vpn`-Bereitstellung des OpenVPN-Clients, die im Namensbereich `kube-system` ausgeführt wird, wird nun von `addon-manager` von Kubernetes verwaltet.</td>
</tr>
</tbody>
</table>

### Änderungsprotokoll für Workerknoten-Fixpack 1.10.3_1514, veröffentlicht 3. Juli 2018
{: #1103_1514}

<table summary="Seit Version 1.10.3_1513 vorgenommene Änderungen">
<caption>Änderungen seit Version 1.10.3_1513</caption>
<thead>
<tr>
<th>Komponente</th>
<th>Vorher</th>
<th>Aktuell</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>n.z.</td>
<td>n.z.</td>
<td>Optimiertes `sysctl` für Netzauslastungen mit hoher Leistung.</td>
</tr>
</tbody>
</table>


### Änderungsprotokoll für Workerknoten-Fixpack 1.10.3_1513, veröffentlicht 21. Juni 2018
{: #1103_1513}

<table summary="Seit Version 1.10.3_1512 vorgenommene Änderungen">
<caption>Änderungen seit Version 1.10.3_1512</caption>
<thead>
<tr>
<th>Komponente</th>
<th>Vorher</th>
<th>Aktuell</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>Docker</td>
<td>n.z.</td>
<td>n.z.</td>
<td>Bei nicht verschlüsselten Maschinentypen wird die sekundäre Platte bereinigt, indem Sie beim erneuten Laden oder Aktualisieren des Workerknotens ein neues Dateisystem abrufen.</td>
</tr>
</tbody>
</table>

### Änderungsprotokoll für 1.10.3_1512, veröffentlicht 12. Juni 2018
{: #1103_1512}

<table summary="Seit Version 1.10.1_1510 vorgenommene Änderungen">
<caption>Änderungen seit Version 1.10.1_1510</caption>
<thead>
<tr>
<th>Komponente</th>
<th>Vorher</th>
<th>Aktuell</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>Version 1.10.1</td>
<td>Version 1.10.3</td>
<td>Werfen Sie einen Blick auf die Kubernetes-[Releaseinformationen ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.3).</td>
</tr>
<tr>
<td>Kubernetes-Konfiguration</td>
<td>n.z.</td>
<td>n.z.</td>
<td>Der Option `--enable-admission-plugins` wurde `PodSecurityPolicy` für den Kubernetes-API-Server des Clusters hinzugefügt und das Cluster wurde für die Unterstützung von Sicherheitsrichtlinien für Pods konfiguriert. Weitere Informationen finden Sie unter [Sicherheitsrichtlinien für Pods konfigurieren](cs_psp.html).</td>
</tr>
<tr>
<td>Kubelet-Konfiguration</td>
<td>n.z.</td>
<td>n.z.</td>
<td>Es wurde die Option `--authentication-token-webhook` aktiviert, um das Trägertoken und das Servicekontotoken der API zur Authentifizierung am HTTPS-Endpunkt `kubelet` zu unterstützen.</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>Version 1.10.1-52</td>
<td>Version 1.10.3-85</td>
<td>Wurde für die Unterstützung von Kubernetes 1.10.3 aktualisiert.</td>
</tr>
<tr>
<td>OpenVPN-Client</td>
<td>n.z.</td>
<td>n.z.</td>
<td>`livenessProbe` wurde der `vpn`-Bereitstellung des OpenVPN-Clients hinzugefügt, die im Namensbereich `kube-system` ausgeführt wird.</td>
</tr>
<tr>
<td>Kernelaktualisierung</td>
<td>4.4.0-116</td>
<td>4.4.0-127</td>
<td>Neue Workerknoten-Images mit Kernelaktualisierung für [CVE-2018-3639 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-3639).</td>
</tr>
</tbody>
</table>



### Änderungsprotokoll für Workerknoten-Fixpack 1.10.1_1510, veröffentlicht am 18. Mai 2018
{: #1101_1510}

<table summary="Seit Version 1.10.1_1509 vorgenommene Änderungen">
<caption>Änderungen seit Version 1.10.1_1509</caption>
<thead>
<tr>
<th>Komponente</th>
<th>Vorher</th>
<th>Aktuell</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>n.z.</td>
<td>n.z.</td>
<td>Fix für einen Programmfehler, der bei der Verwendung des Blockspeicher-Plug-ins auftrat.</td>
</tr>
</tbody>
</table>

### Änderungsprotokoll für Workerknoten Fixpack 1.10.1_1509, veröffentlicht am 16. Mai 2018
{: #1101_1509}

<table summary="Seit Version 1.10.1_1508 vorgenommene Änderungen">
<caption>Änderungen seit Version 1.10.1_1508</caption>
<thead>
<tr>
<th>Komponente</th>
<th>Vorher</th>
<th>Aktuell</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>n.z.</td>
<td>n.z.</td>
<td>Die im Stammverzeichnis `kubelet` gespeicherten Daten werden nun auf einer größeren sekundären Platte der Maschine mit dem Workerknoten gespeichert.</td>
</tr>
</tbody>
</table>

### Änderungsprotokoll für 1.10.1_1508, veröffentlicht am 1. Mai 2018
{: #1101_1508}

<table summary="Seit Version 1.9.7_1510 vorgenommene Änderungen">
<caption>Änderungen seit Version 1.9.7_1510</caption>
<thead>
<tr>
<th>Komponente</th>
<th>Vorher</th>
<th>Aktuell</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>Version 2.6.5</td>
<td>Version 3.1.1</td>
<td>Werfen Sie einen Blick auf die Calico-[Releaseinformationen ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://docs.projectcalico.org/v3.1/releases/#v311).</td>
</tr>
<tr>
<td>Kubernetes Heapster</td>
<td>Version 1.5.0</td>
<td>Version 1.5.2</td>
<td>Werfen Sie einen Blick auf die Kubernetes Heapster-[Releaseinformationen ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/kubernetes/heapster/releases/tag/v1.5.2).</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>Version 1.9.7</td>
<td>Version 1.10.1</td>
<td>Werfen Sie einen Blick auf die Kubernetes-[Releaseinformationen ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.1).</td>
</tr>
<tr>
<td>Kubernetes-Konfiguration</td>
<td>n.z.</td>
<td>n.z.</td>
<td><code>StorageObjectInUseProtection</code> wurde zur Option <code>--enable-admission-plugins</code> für den Kubernetes-API-Server des Clusters hinzugefügt.</td>
</tr>
<tr>
<td>Kubernetes-DNS</td>
<td>1.14.8</td>
<td>1.14.10</td>
<td>Werfen Sie einen Blick auf die Kubernetes-DNS-[Releaseinformationen ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/kubernetes/dns/releases/tag/1.14.10).</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>Version 1.9.7-102</td>
<td>Version 1.10.1-52</td>
<td>Wurde für die Unterstützung von Kubernetes 1.10 aktualisiert.</td>
</tr>
<tr>
<td>GPU-Unterstützung</td>
<td>n.z.</td>
<td>n.z.</td>
<td>Unterstützung für [Container-Workloads der Graphics Processing Unit (GPU)](cs_app.html#gpu_app) ist jetzt für die Terminierung und Ausführung verfügbar. Eine Liste der verfügbaren GPU-Maschinentypen finden Sie unter [Hardware für Workerknoten](cs_clusters_planning.html#shared_dedicated_node). Weitere Informationen finden Sie in der Kubernetes-Dokumentation zum [Terminieren von GPUs ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tasks/manage-gpus/scheduling-gpus/).</td>
</tr>
</tbody>
</table>

<br />


## Version 1.9, Änderungsprotokoll
{: #19_changelog}

Überprüfen Sie die folgenden Änderungen.

### Änderungsprotokoll für Master-Fixpack 1.9.10_1530, veröffentlicht am 15. Oktober 2018
{: #1910_1530}

<table summary="Seit Version 1.9.10_1527 vorgenommene Änderungen">
<caption>Änderungen seit Version 1.9.10_1527</caption>
<thead>
<tr>
<th>Komponente</th>
<th>Vorher</th>
<th>Aktuell</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>Clusteraktualisierung</td>
<td>n.z.</td>
<td>n.z.</td>
<td>Korrigiert Problem beim Aktualisieren von Cluster-Add-ons, wenn der Master von einer nicht unterstützten Version aktualisiert wird.</td>
</tr>
</tbody>
</table>

### Änderungsprotokoll für Workerknoten-Fixpack 1.9.10_1528, veröffentlicht am 10. Oktober 2018
{: #1910_1528}

<table summary="Seit Version 1.9.10_1527 vorgenommene Änderungen">
<caption>Änderungen seit Version 1.9.10_1527</caption>
<thead>
<tr>
<th>Komponente</th>
<th>Vorher</th>
<th>Aktuell</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>4.4.0-133</td>
<td>4.4.0-137</td>
<td>Aktualisierte Workerknoten-Images mit Kernelaktualisierung für [CVE-2018-14633,CVE-2018-17182 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-137.163/changelog).</td>
</tr>
<tr>
<td>Inaktives Sitzungszeitlimit</td>
<td>n.z.</td>
<td>n.z.</td>
<td>Legen Sie für das Zeitlimit für inaktive Sitzungen 5 Minuten fest, damit die Anforderungen erfüllt werden.</td>
</tr>
</tbody>
</table>


### Änderungsprotokoll für 1.9.10_1527, veröffentlicht am 2. Oktober 2018
{: #1910_1527}

<table summary="Seit Version 1.9.10_1523 vorgenommene Änderungen">
<caption>Änderungen seit Version 1.9.10_1523</caption>
<thead>
<tr>
<th>Komponente</th>
<th>Vorher</th>
<th>Aktuell</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>Version 1.9.10-192</td>
<td>v1.9.10-219</td>
<td>Der Dokumentationslink zu den Fehlernachrichten für die Lastausgleichsfunktion wurde aktualisiert.</td>
</tr>
<tr>
<td>IBM File Storage-Klassen</td>
<td>n.z.</td>
<td>n.z.</td>
<td>`mountOptions` wurde in den IBM File Storage-Klassen entfernt, damit der Standardwert verwendet wird, der vom Workerknoten bereitgestellt wird. Der doppelte Parameter `reclaimPolicy` wurde in den IBM File Storage-Klassen entfernt.<br><br>
Außerdem bleibt die IBM File Storage-Standardklasse beim Aktualisieren des Cluster-Masters unverändert. Falls Sie die Standardspeicherklasse ändern möchten, führen Sie `kubectl patch storageclass <storageclass> -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'` aus und ersetzen `<storageclass>` durch den Namen der Speicherklasse.</td>
</tr>
</tbody>
</table>

### Änderungsprotokoll für Workerknoten-Fixpack 1.9.10_1524, veröffentlicht am 20. September 2018
{: #1910_1524}

<table summary="Seit Version 1.9.10_1523 vorgenommene Änderungen">
<caption>Änderungen seit Version 1.9.10_1523</caption>
<thead>
<tr>
<th>Komponente</th>
<th>Vorher</th>
<th>Aktuell</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>Protokollrotation</td>
<td>n.z.</td>
<td>n.z.</td>
<td>Von Zeitgebern des Typs `cronjobs` wurde zu `systemd` gewechselt, um ein Fehlschlagen von `logrotate` auf Workerknoten zu vermeiden, die nicht innerhalb von 90 Tagen erneute geladen oder aktualisiert werden. **Anmerkung**: In allen früheren Versionen für dieses Unterrelease war die primäre Platte mit Daten gefüllt, nachdem der Cron-Job fehlgeschlagen war, weil die Protokolle nicht rotiert wurden. Der Cron-Job schlägt fehl, nachdem der Workerknoten 90 Tage aktiv ist, ohne erneut aktualisiert oder geladen zu werden. Wenn die gesamte Speicherkapazität der primären Platte durch Protokolle erschöpft ist, wechselt der Workerknoten in den Status 'Fehlgeschlagen'. Der Fehler auf dem Workerknoten kann mit dem [Befehl](cs_cli_reference.html#cs_worker_reload) `ibmcloud ks worker-reload` oder dem [Befehl](cs_cli_reference.html#cs_worker_update) `ibmcloud ks worker-update` behoben werden.</td>
</tr>
<tr>
<td>Laufzeitkomponenten für Workerknoten (`kubelet`, `kube-proxy`, `docker`)</td>
<td>n.z.</td>
<td>n.z.</td>
<td>Entfernte Abhängigkeiten der Laufzeitkomponenten auf der primären Platte. Diese Erweiterung verhindert das Fehlschlagen von Workerknoten, wenn die Speicherkapazität auf der primären Platte erschöpft ist.</td>
</tr>
<tr>
<td>Ablauf des Rootkennworts</td>
<td>n.z.</td>
<td>n.z.</td>
<td>Rootkennwörter für Workerknoten laufen aus Konformitätsgründen nach 90 Tagen ab. Wenn für die Automatisierungstools eine Anmeldung am Workerknoten erforderlich ist oder wenn sie auf Cron-Jobs angewiesen sind, die als Root ausgeführt werden, können Sie den Ablauf der Kennwortgültigkeit inaktivieren, indem Sie sich am Workerknoten anmelden und `chage -M -1 root` ausführen. **Anmerkung**: Falls Konformitätsanforderungen für die Sicherheit gelten, die eine Ausführung als Root oder eine Entfernung des Ablaufs der Kennwortgültigkeit verhindern, inaktivieren Sie nicht das Ablaufdatum. Stattdessen können Sie die Workerknoten mindestens alle 90 Tage [aktualisieren](cs_cli_reference.html#cs_worker_update) oder [erneut laden](cs_cli_reference.html#cs_worker_reload).</td>
</tr>
<tr>
<td>Systemd</td>
<td>n.z.</td>
<td>n.z.</td>
<td>Bereinigen Sie die temporären Mounteinheiten in regelmäßigen Abständen, um zu verhindern, dass sie unbegrenzt werden. Diese Aktion ist für [Kubernetes-Fehler 57345 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/kubernetes/kubernetes/issues/57345) vorgesehen.</td>
</tr>
<tr>
<td>Docker</td>
<td>n.z.</td>
<td>n.z.</td>
<td>Inaktiviert die Docker-Standard-Bridge, sodass der IP-Bereich `172.17.0.0/ 16` jetzt für private Routen verwendet wird. Wenn die Docker-Container in Workerknoten erstellt werden, weil `docker`-Befehle direkt auf dem Host ausgeführt werden oder weil ein Pod verwendet wird, von dem der Docker-Socket angehängt wird, wählen Sie eine der folgenden Optionen aus. <ul><li>Wenn Sie die externe Netzkonnektivität sicherstellen möchten, wenn Sie den Container erstellen, führen Sie `docker build --network host` aus.</li>
<li>Wenn Sie explizit ein Netz erstellen möchten, das beim Erstellen des Containers verwendet werden soll, führen Sie `docker network create` aus, und verwenden Sie anschließend dieses Netz.</li></ul>
**Anmerkung**: Sind Abhängigkeiten vom Docker-Socket oder direkt von Docker vorhanden? [Migrieren Sie auf `containerd` anstatt auf `docker` als Containerlaufzeit](cs_versions.html#containerd), sodass die Cluster auf die Ausführung von Kubernetes Version 1.11 oder eine aktuallere Version vorbereitet sind.</td>
</tr>
</tbody>
</table>

### Änderungsprotokoll für 1.9.10_1523, veröffentlicht am 4. September 2018
{: #1910_1523}

<table summary="Seit Version 1.9.9_1522 vorgenommene Änderungen">
<caption>Änderungen seit Version 1.9.9_1522</caption>
<thead>
<tr>
<th>Komponente</th>
<th>Vorher</th>
<th>Aktuell</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>Version 1.9.9-167</td>
<td>Version 1.9.10-192</td>
<td>Wurde für die Unterstützung von Kubernetes 1.9.10 aktualisiert. Darüber hinaus wurde die Cloud-Provider-Konfiguration geändert, um die Verarbeitung von Aktualisierungen für Lastausgleichsfunktionsservices zu verbessern, wenn für `externalTrafficPolicy` der Wert `local` eingestellt ist.</td>
</tr>
<tr>
<td>IBM File Storage-Plug-in</td>
<td>334</td>
<td>338</td>
<td>Aktualisierung des Inkubators auf Version 1.8. Der Dateispeicher wird für die von Ihnen ausgewählte Zone bereitgestellt. Sie können die Bezeichnungen einer vorhandenen (statischen) PV-Instanz nicht aktualisieren, es sei denn, Sie verwenden einen Mehrzonencluster und müssen die Regions- und Zonenbezeichnungen hinzufügen.<br><br>Die NFS-Standardversion wurde aus den Mountoptionen in den von IBM bereitgestellten Dateispeicherklassen entfernt. Das Betriebssystem des Hosts vereinbart die NFS-Version jetzt mit dem NFS-Server der IBM Cloud-Infrastruktur (SoftLayer). Wenn Sie eine bestimmte NFS-Version manuell festlegen oder die NFS-Version Ihres PV ändern, die vom Betriebssystem des Hosts vereinbart wurde, finden Sie Informationen hierzu im Abschnitt [NFS-Standardversion ändern](cs_storage_file.html#nfs_version_class).</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>Version 1.9.9</td>
<td>Version 1.9.10</td>
<td>Werfen Sie einen Blick auf die Kubernetes-[Releaseinformationen ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/kubernetes/kubernetes/releases/tag/v1.9.10).</td>
</tr>
<tr>
<td>Konfiguration von Kubernetes Heapster</td>
<td>n.z.</td>
<td>n.z.</td>
<td>Höhere Ressourcengrenzen für den Container `heapster-nanny`.</td>
</tr>
</tbody>
</table>

### Änderungsprotokoll für Workerknoten-Fixpack 1.9.9_1522, veröffentlicht am 23. August 2018
{: #199_1522}

<table summary="Seit Version 1.9.9_1521 vorgenommene Änderungen">
<caption>Änderungen seit Version 1.9.9_1521</caption>
<thead>
<tr>
<th>Komponente</th>
<th>Vorher</th>
<th>Aktuell</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>`systemd`</td>
<td>229</td>
<td>230</td>
<td>Aktualisierung von `systemd` zur Korrektur des `cgroup`-Lecks.</td>
</tr>
<tr>
<td>Kernel</td>
<td>4.4.0-127</td>
<td>4.4.0-133</td>
<td>Aktualisierte Workerknoten-Images mit Kernelaktualisierung für [CVE-2018-3620,CVE-2018-3646 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://usn.ubuntu.com/3741-1/).</td>
</tr>
</tbody>
</table>


### Änderungsprotokoll für Workerknoten-Fixpack 1.9.9_1521, veröffentlicht am 13. August 2018
{: #199_1521}

<table summary="Seit Version 1.9.9_1520 vorgenommene Änderungen">
<caption>Änderungen seit Version 1.9.9_1520</caption>
<thead>
<tr>
<th>Komponente</th>
<th>Vorher</th>
<th>Aktuell</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu-Pakete</td>
<td>n.z.</td>
<td>n.z.</td>
<td>Aktualisierungen an installierten Ubuntu-Paketen.</td>
</tr>
</tbody>
</table>

### Änderungsprotokoll für 1.9.9_1520, veröffentlicht 27. Juli 2018
{: #199_1520}

<table summary="Seit Version 1.9.8_1517 vorgenommene Änderungen">
<caption>Änderungen seit Version 1.9.8_1517</caption>
<thead>
<tr>
<th>Komponente</th>
<th>Vorher</th>
<th>Aktuell</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>Version 1.9.8-141</td>
<td>Version 1.9.9-167</td>
<td>Wurde für die Unterstützung von Kubernetes 1.9.9 aktualisiert. Darüber hinaus enthalten `create failure`-Ereignisse des LoadBalancer-Service nun alle Fehler portierbarer Teilnetze.</td>
</tr>
<tr>
<td>IBM File Storage-Plug-in</td>
<td>320</td>
<td>334</td>
<td>Das Zeitlimit bei der Erstellung persistenter Datenträger wurde von 15 auf 30 Minuten erhöht. Der Standardabrechnungstyp wurde in 'Stündlich' (`hourly`) geändert. Es wurden Mountoptionen zu den vordefinierten Speicherklassen hinzugefügt. In der NFS-Dateispeicherinstanz in Ihrem Konto der IBM Cloud-Infrastruktur (SoftLayer) wurde das Format des Felds **Anmerkungen** in JSON geändert und der Kubernetes-Namensbereich hinzugefügt, in dem der persistente Datenträger bereitgestellt ist. Für die Unterstützung von Mehrzonenclustern wurden persistenten Datenträgern Zonen- und Regionsbezeichnungen hinzugefügt.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>Version 1.9.8</td>
<td>Version 1.9.9</td>
<td>Werfen Sie einen Blick auf die Kubernetes-[Releaseinformationen ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/kubernetes/kubernetes/releases/tag/v1.9.9).</td>
</tr>
<tr>
<td>Kernel</td>
<td>n.z.</td>
<td>n.z.</td>
<td>An den Netzeinstellungen für Workerknoten wurden kleinere Verbesserungen vorgenommen, um Netzarbeitslasten mit hoher Leistung zu unterstützen.</td>
</tr>
<tr>
<td>OpenVPN-Client</td>
<td>n.z.</td>
<td>n.z.</td>
<td>Die `vpn`-Bereitstellung des OpenVPN-Clients, die im Namensbereich `kube-system` ausgeführt wird, wird nun von `addon-manager` von Kubernetes verwaltet.</td>
</tr>
</tbody>
</table>

### Änderungsprotokoll für Workerknoten-Fixpack 1.9.8_1517, veröffentlicht am 3. Juli 2018
{: #198_1517}

<table summary="Seit Version 1.9.8_1516 vorgenommene Änderungen">
<caption>Änderungen seit Version 1.9.8_1516</caption>
<thead>
<tr>
<th>Komponente</th>
<th>Vorher</th>
<th>Aktuell</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>n.z.</td>
<td>n.z.</td>
<td>Optimiertes `sysctl` für Netzauslastungen mit hoher Leistung.</td>
</tr>
</tbody>
</table>


### Änderungsprotokoll für Workerknoten-Fixpack 1.9.8_1516, veröffentlicht am 21. Juni 2018
{: #198_1516}

<table summary="Seit Version 1.9.8_1515 vorgenommene Änderungen">
<caption>Änderungen seit Version 1.9.8_1515</caption>
<thead>
<tr>
<th>Komponente</th>
<th>Vorher</th>
<th>Aktuell</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>Docker</td>
<td>n.z.</td>
<td>n.z.</td>
<td>Bei nicht verschlüsselten Maschinentypen wird die sekundäre Platte bereinigt, indem Sie beim erneuten Laden oder Aktualisieren des Workerknotens ein neues Dateisystem abrufen.</td>
</tr>
</tbody>
</table>

### Änderungsprotokoll für 1.9.8_1515, veröffentlicht 19. Juni 2018
{: #198_1515}

<table summary="Seit Version 1.9.7_1513 vorgenommene Änderungen">
<caption>Änderungen seit Version 1.9.7_1513</caption>
<thead>
<tr>
<th>Komponente</th>
<th>Vorher</th>
<th>Aktuell</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>Version 1.9.7</td>
<td>Version 1.9.8</td>
<td>Werfen Sie einen Blick auf die [Kubernetes-Releaseinformationen ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/kubernetes/kubernetes/releases/tag/v1.9.8).</td>
</tr>
<tr>
<td>Kubernetes-Konfiguration</td>
<td>n.z.</td>
<td>n.z.</td>
<td>Der Option '--admission-control' wurde 'PodSecurityPolicy' für den Kubernetes API-Server des Clusters hinzugefügt und das Cluster wurde für die Unterstützung von Sicherheitsrichtlinien für Pods konfiguriert. Weitere Informationen finden Sie unter [Sicherheitsrichtlinien für Pods konfigurieren](cs_psp.html).</td>
</tr>
<tr>
<td>IBM Cloud-Provider</td>
<td>Version 1.9.7-102</td>
<td>Version 1.9.8-141</td>
<td>Wurde für die Unterstützung von Kubernetes 1.9.8 aktualisiert.</td>
</tr>
<tr>
<td>OpenVPN-Client</td>
<td>n.z.</td>
<td>n.z.</td>
<td><code>livenessProbe</code> wurde der <code>vpn</code>-Bereitstellung des OpenVPN-Clients hinzugefügt, die im Namensbereich <code>kube-system</code> ausgeführt wird.</td>
</tr>
</tbody>
</table>


### Änderungsprotokoll für Workerknoten-Fixpack 1.9.7_1513, veröffentlicht am 11. Juni 2018
{: #197_1513}

<table summary="Seit Version 1.9.7_1512 vorgenommene Änderungen">
<caption>Änderungen seit Version 1.9.7_1512</caption>
<thead>
<tr>
<th>Komponente</th>
<th>Vorher</th>
<th>Aktuell</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernelaktualisierung</td>
<td>4.4.0-116</td>
<td>4.4.0-127</td>
<td>Neue Workerknoten-Images mit Kernelaktualisierung für [CVE-2018-3639 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-3639).</td>
</tr>
</tbody>
</table>

### Änderungsprotokoll für Workerknoten-Fixpack 1.9.7_1512, veröffentlicht am 18. Mai 2018
{: #197_1512}

<table summary="Seit Version 1.9.7_1511 vorgenommene Änderungen">
<caption>Änderungen seit Version 1.9.7_1511</caption>
<thead>
<tr>
<th>Komponente</th>
<th>Vorher</th>
<th>Aktuell</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>n.z.</td>
<td>n.z.</td>
<td>Fix für einen Programmfehler, der bei der Verwendung des Blockspeicher-Plug-ins auftrat.</td>
</tr>
</tbody>
</table>

### Änderungsprotokoll für Workerknoten Fixpack 1.9.7_1511, veröffentlicht am 16. Mai 2018
{: #197_1511}

<table summary="Seit Version 1.9.7_1510 vorgenommene Änderungen">
<caption>Änderungen seit Version 1.9.7_1510</caption>
<thead>
<tr>
<th>Komponente</th>
<th>Vorher</th>
<th>Aktuell</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>n.z.</td>
<td>n.z.</td>
<td>Die im Stammverzeichnis `kubelet` gespeicherten Daten werden nun auf einer größeren sekundären Platte der Maschine mit dem Workerknoten gespeichert.</td>
</tr>
</tbody>
</table>

### Änderungsprotokoll für 1.9.7_1510, veröffentlicht am 30. April 2018
{: #197_1510}

<table summary="Seit Version 1.9.3_1506 vorgenommene Änderungen">
<caption>Änderungen seit Version 1.9.3_1506</caption>
<thead>
<tr>
<th>Komponente</th>
<th>Vorher</th>
<th>Aktuell</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>Version 1.9.3</td>
<td>Version 1.9.7	</td>
<td><p>Werfen Sie einen Blick auf die [Kubernetes-Releaseinformationen ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/kubernetes/kubernetes/releases/tag/v1.9.7). Dieses Release befasst sich mit den Schwachstellen [CVE-2017-1002101 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002101) und [CVE-2017-1002102 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002102).</p><p><strong>Anmerkung</strong>: `secret`, `configMap`, `downwardAPI` und projizierte Datenträger werden nun als schreibgeschützte Datenträger angehängt. Bisher konnten Apps Daten in diese Datenträger schreiben, aber das System konnte die Daten möglicherweise automatisch zurücksetzen. Wenn Ihre Apps das bisherige unsichere Verhalten erwarten, ändern Sie sie entsprechend.</p></td>
</tr>
<tr>
<td>Kubernetes-Konfiguration</td>
<td>n.z.</td>
<td>n.z.</td>
<td>`admissionregistration.k8s.io/v1alpha1=true` wurde zur Option `--runtime-config` für den Kubernetes-API-Server des Clusters hinzugefügt.</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>Version 1.9.3-71</td>
<td>Version 1.9.7-102</td>
<td>`NodePort`- und `LoadBalancer`-Services unterstützen jetzt [das Beibehalten der Client-Quellen-IP](cs_loadbalancer.html#node_affinity_tolerations) durch Festlegen von `service.spec.externalTrafficPolicy` auf `Local`.</td>
</tr>
<tr>
<td></td>
<td></td>
<td></td>
<td>Korrigiert die [Edge-Knoten](cs_edge.html#edge)-Tolerierungskonfiguration für ältere Cluster.</td>
</tr>
</tbody>
</table>

<br />


## Archiv
{: #changelog_archive}

Nicht unterstützte Kubernetes-Versionen:
*  [Version 1.8](#18_changelog)
*  [Version 1.7](#17_changelog)

### Änderungsprotokoll Version 1.8 (nicht unterstützt)
{: #18_changelog}

Überprüfen Sie die folgenden Änderungen.

### Änderungsprotokoll für Workerknoten-Fixpack 1.8.15_1521, veröffentlicht am 20. September 2018
{: #1815_1521}

<table summary="Seit Version 1.8.15_1520 vorgenommene Änderungen">
<caption>Änderungen seit Version 1.8.15_1520</caption>
<thead>
<tr>
<th>Komponente</th>
<th>Vorher</th>
<th>Aktuell</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>Protokollrotation</td>
<td>n.z.</td>
<td>n.z.</td>
<td>Von Zeitgebern des Typs `cronjobs` wurde zu `systemd` gewechselt, um ein Fehlschlagen von `logrotate` auf Workerknoten zu vermeiden, die nicht innerhalb von 90 Tagen erneute geladen oder aktualisiert werden. **Anmerkung**: In allen früheren Versionen für dieses Unterrelease war die primäre Platte mit Daten gefüllt, nachdem der Cron-Job fehlgeschlagen war, weil die Protokolle nicht rotiert wurden. Der Cron-Job schlägt fehl, nachdem der Workerknoten 90 Tage aktiv ist, ohne erneut aktualisiert oder geladen zu werden. Wenn die gesamte Speicherkapazität der primären Platte durch Protokolle erschöpft ist, wechselt der Workerknoten in den Status 'Fehlgeschlagen'. Der Fehler auf dem Workerknoten kann mit dem [Befehl](cs_cli_reference.html#cs_worker_reload) `ibmcloud ks worker-reload` oder dem [Befehl](cs_cli_reference.html#cs_worker_update) `ibmcloud ks worker-update` behoben werden.</td>
</tr>
<tr>
<td>Laufzeitkomponenten für Workerknoten (`kubelet`, `kube-proxy`, `docker`)</td>
<td>n.z.</td>
<td>n.z.</td>
<td>Entfernte Abhängigkeiten der Laufzeitkomponenten auf der primären Platte. Diese Erweiterung verhindert das Fehlschlagen von Workerknoten, wenn die Speicherkapazität auf der primären Platte erschöpft ist.</td>
</tr>
<tr>
<td>Ablauf des Rootkennworts</td>
<td>n.z.</td>
<td>n.z.</td>
<td>Rootkennwörter für Workerknoten laufen aus Konformitätsgründen nach 90 Tagen ab. Wenn für die Automatisierungstools eine Anmeldung am Workerknoten erforderlich ist oder wenn sie auf Cron-Jobs angewiesen sind, die als Root ausgeführt werden, können Sie den Ablauf der Kennwortgültigkeit inaktivieren, indem Sie sich am Workerknoten anmelden und `chage -M -1 root` ausführen. **Anmerkung**: Falls Konformitätsanforderungen für die Sicherheit gelten, die eine Ausführung als Root oder eine Entfernung des Ablaufs der Kennwortgültigkeit verhindern, inaktivieren Sie nicht das Ablaufdatum. Stattdessen können Sie die Workerknoten mindestens alle 90 Tage [aktualisieren](cs_cli_reference.html#cs_worker_update) oder [erneut laden](cs_cli_reference.html#cs_worker_reload).</td>
</tr>
<tr>
<td>Systemd</td>
<td>n.z.</td>
<td>n.z.</td>
<td>Bereinigen Sie die temporären Mounteinheiten in regelmäßigen Abständen, um zu verhindern, dass sie unbegrenzt werden. Diese Aktion ist für [Kubernetes-Fehler 57345 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/kubernetes/kubernetes/issues/57345) vorgesehen.</td>
</tr>
</tbody>
</table>

### Änderungsprotokoll für Workerknoten-Fixpack 1.8.15_1520, veröffentlicht am 23. August 2018
{: #1815_1520}

<table summary="Seit Version 1.9.9_1519 vorgenommene Änderungen">
<caption>Änderungen seit Version 1.8.15_1519</caption>
<thead>
<tr>
<th>Komponente</th>
<th>Vorher</th>
<th>Aktuell</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>`systemd`</td>
<td>229</td>
<td>230</td>
<td>Aktualisierung von `systemd` zur Korrektur des `cgroup`-Lecks.</td>
</tr>
<tr>
<td>Kernel</td>
<td>4.4.0-127</td>
<td>4.4.0-133</td>
<td>Aktualisierte Workerknoten-Images mit Kernelaktualisierung für [CVE-2018-3620,CVE-2018-3646 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://usn.ubuntu.com/3741-1/).</td>
</tr>
</tbody>
</table>

### Änderungsprotokoll für Workerknoten-Fixpack 1.8.15_1519, veröffentlicht am 13. August 2018
{: #1815_1519}

<table summary="Seit Version 1.9.9_1518 vorgenommene Änderungen">
<caption>Änderungen seit Version 1.8.15_1518</caption>
<thead>
<tr>
<th>Komponente</th>
<th>Vorher</th>
<th>Aktuell</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>Ubuntu-Pakete</td>
<td>n.z.</td>
<td>n.z.</td>
<td>Aktualisierungen an installierten Ubuntu-Paketen.</td>
</tr>
</tbody>
</table>

### Änderungsprotokoll für 1.8.15_1518, veröffentlicht 27. Juli 2018
{: #1815_1518}

<table summary="Seit Version 1.8.13_1516 vorgenommene Änderungen">
<caption>Änderungen seit Version 1.8.13_1516</caption>
<thead>
<tr>
<th>Komponente</th>
<th>Vorher</th>
<th>Aktuell</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>Version 1.8.13-176</td>
<td>Version 1.8.15-204</td>
<td>Wurde für die Unterstützung von Kubernetes 1.8.15 aktualisiert. Darüber hinaus enthalten `create failure`-Ereignisse des LoadBalancer-Service nun alle Fehler portierbarer Teilnetze.</td>
</tr>
<tr>
<td>IBM File Storage-Plug-in</td>
<td>320</td>
<td>334</td>
<td>Das Zeitlimit bei der Erstellung persistenter Datenträger wurde von 15 auf 30 Minuten erhöht. Der Standardabrechnungstyp wurde in 'Stündlich' (`hourly`) geändert. Es wurden Mountoptionen zu den vordefinierten Speicherklassen hinzugefügt. In der NFS-Dateispeicherinstanz in Ihrem Konto der IBM Cloud-Infrastruktur (SoftLayer) wurde das Format des Felds **Anmerkungen** in JSON geändert und der Kubernetes-Namensbereich hinzugefügt, in dem der persistente Datenträger bereitgestellt ist. Für die Unterstützung von Mehrzonenclustern wurden persistenten Datenträgern Zonen- und Regionsbezeichnungen hinzugefügt.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>Version 1.8.13</td>
<td>Version 1.8.15</td>
<td>Werfen Sie einen Blick auf die Kubernetes-[Releaseinformationen ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/kubernetes/kubernetes/releases/tag/v1.8.15).</td>
</tr>
<tr>
<td>Kernel</td>
<td>n.z.</td>
<td>n.z.</td>
<td>An den Netzeinstellungen für Workerknoten wurden kleinere Verbesserungen vorgenommen, um Netzarbeitslasten mit hoher Leistung zu unterstützen.</td>
</tr>
<tr>
<td>OpenVPN-Client</td>
<td>n.z.</td>
<td>n.z.</td>
<td>Die `vpn`-Bereitstellung des OpenVPN-Clients, die im Namensbereich `kube-system` ausgeführt wird, wird nun von `addon-manager` von Kubernetes verwaltet.</td>
</tr>
</tbody>
</table>

### Änderungsprotokoll für Workerknoten-Fixpack 1.8.13_1516, veröffentlicht am 3. Juli 2018
{: #1813_1516}

<table summary="Seit Version 1.8.13_1515 vorgenommene Änderungen">
<caption>Änderungen seit Version 1.8.13_1515</caption>
<thead>
<tr>
<th>Komponente</th>
<th>Vorher</th>
<th>Aktuell</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>n.z.</td>
<td>n.z.</td>
<td>Optimiertes `sysctl` für Netzauslastungen mit hoher Leistung.</td>
</tr>
</tbody>
</table>


### Änderungsprotokoll für Workerknoten-Fixpack 1.8.13_1515, veröffentlicht am 21. Juni 2018
{: #1813_1515}

<table summary="Seit Version 1.8.13_1514 vorgenommene Änderungen">
<caption>Änderungen seit Version 1.8.13_1514</caption>
<thead>
<tr>
<th>Komponente</th>
<th>Vorher</th>
<th>Aktuell</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>Docker</td>
<td>n.z.</td>
<td>n.z.</td>
<td>Bei nicht verschlüsselten Maschinentypen wird die sekundäre Platte bereinigt, indem Sie beim erneuten Laden oder Aktualisieren des Workerknotens ein neues Dateisystem abrufen.</td>
</tr>
</tbody>
</table>

### Änderungsprotokoll für 1.8.13_1514, veröffentlicht 19. Juni 2018
{: #1813_1514}

<table summary="Seit Version 1.8.11_1512 vorgenommene Änderungen">
<caption>Änderungen seit Version 1.8.11_1512</caption>
<thead>
<tr>
<th>Komponente</th>
<th>Vorher</th>
<th>Aktuell</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>Version 1.8.11</td>
<td>Version 1.8.13</td>
<td>Werfen Sie einen Blick auf die [Kubernetes-Releaseinformationen ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/kubernetes/kubernetes/releases/tag/v1.8.13).</td>
</tr>
<tr>
<td>Kubernetes-Konfiguration</td>
<td>n.z.</td>
<td>n.z.</td>
<td>Der Option '--admission-control' wurde 'PodSecurityPolicy' für den Kubernetes API-Server des Clusters hinzugefügt und das Cluster wurde für die Unterstützung von Sicherheitsrichtlinien für Pods konfiguriert. Weitere Informationen finden Sie unter [Sicherheitsrichtlinien für Pods konfigurieren](cs_psp.html).</td>
</tr>
<tr>
<td>IBM Cloud-Provider</td>
<td>Version 1.8.11-126</td>
<td>Version 1.8.13-176</td>
<td>Wurde für die Unterstützung von Kubernetes 1.8.13 aktualisiert.</td>
</tr>
<tr>
<td>OpenVPN-Client</td>
<td>n.z.</td>
<td>n.z.</td>
<td><code>livenessProbe</code> wurde der <code>vpn</code>-Bereitstellung des OpenVPN-Clients hinzugefügt, die im Namensbereich <code>kube-system</code> ausgeführt wird.</td>
</tr>
</tbody>
</table>


### Änderungsprotokoll für Workerknoten-Fixpack 1.8.11_1512, veröffentlicht am 11. Juni 2018
{: #1811_1512}

<table summary="Seit Version 1.8.11_1511 vorgenommene Änderungen">
<caption>Änderungen seit Version 1.8.11_1511</caption>
<thead>
<tr>
<th>Komponente</th>
<th>Vorher</th>
<th>Aktuell</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernelaktualisierung</td>
<td>4.4.0-116</td>
<td>4.4.0-127</td>
<td>Neue Workerknoten-Images mit Kernelaktualisierung für [CVE-2018-3639 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-3639).</td>
</tr>
</tbody>
</table>


### Änderungsprotokoll für Workerknoten Fixpack 1.8.11_1511, veröffentlicht am 18. Mai 2018
{: #1811_1511}

<table summary="Seit Version 1.8.11_1510 vorgenommene Änderungen">
<caption>Änderungen seit Version 1.8.11_1510</caption>
<thead>
<tr>
<th>Komponente</th>
<th>Vorher</th>
<th>Aktuell</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>n.z.</td>
<td>n.z.</td>
<td>Fix für einen Programmfehler, der bei der Verwendung des Blockspeicher-Plug-ins auftrat.</td>
</tr>
</tbody>
</table>

### Änderungsprotokoll für Workerknoten Fixpack 1.8.11_1510, veröffentlicht am 16. Mai 2018
{: #1811_1510}

<table summary="Seit Version 1.8.11_1509 vorgenommene Änderungen">
<caption>Änderungen seit Version 1.8.11_1509</caption>
<thead>
<tr>
<th>Komponente</th>
<th>Vorher</th>
<th>Aktuell</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>n.z.</td>
<td>n.z.</td>
<td>Die im Stammverzeichnis `kubelet` gespeicherten Daten werden nun auf einer größeren sekundären Platte der Maschine mit dem Workerknoten gespeichert.</td>
</tr>
</tbody>
</table>


### Änderungsprotokoll für 1.8.11_1509, veröffentlicht am 19. April 2018
{: #1811_1509}

<table summary="Seit Version 1.8.8_1507 vorgenommene Änderungen">
<caption>Änderungen seit Version 1.8.8_1507</caption>
<thead>
<tr>
<th>Komponente</th>
<th>Vorher</th>
<th>Aktuell</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>v1.8.8</td>
<td>v1.8.11	</td>
<td><p>Werfen Sie einen Blick auf die [Kubernetes-Releaseinformationen ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/kubernetes/kubernetes/releases/tag/v1.8.11). Dieses Release befasst sich mit den Schwachstellen [CVE-2017-1002101 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002101) und [CVE-2017-1002102 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002102).</p><p><strong>Anmerkung</strong>: `secret`, `configMap`, `downwardAPI` und projizierte Datenträger werden nun als schreibgeschützte Datenträger angehängt. Bisher konnten Apps Daten in diese Datenträger schreiben, aber das System konnte die Daten möglicherweise automatisch zurücksetzen. Wenn Ihre Apps das bisherige unsichere Verhalten erwarten, ändern Sie sie entsprechend.</p></td>
</tr>
<tr>
<td>Containerimage anhalten</td>
<td>3.0</td>
<td>3.1</td>
<td>Entfernt geerbte verwaiste Zombie-Prozesse.</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>Version 1.8.8-86</td>
<td>Version 1.8.11-126</td>
<td>`NodePort`- und `LoadBalancer`-Services unterstützen jetzt [das Beibehalten der Client-Quellen-IP](cs_loadbalancer.html#node_affinity_tolerations) durch Festlegen von `service.spec.externalTrafficPolicy` auf `Local`.</td>
</tr>
<tr>
<td></td>
<td></td>
<td></td>
<td>Korrigiert die [Edge-Knoten](cs_edge.html#edge)-Tolerierungskonfiguration für ältere Cluster.</td>
</tr>
</tbody>
</table>

<br />


### Version 1.7, Änderungsprotokoll (nicht unterstützt)
{: #17_changelog}

Überprüfen Sie die folgenden Änderungen.

#### Änderungsprotokoll für Workerknoten-Fixpack 1.7.16_1514, veröffentlicht am 11. Juni 2018
{: #1716_1514}

<table summary="Seit Version 1.7.16_1513 vorgenommene Änderungen">
<caption>Änderungen seit Version 1.7.16_1513</caption>
<thead>
<tr>
<th>Komponente</th>
<th>Vorher</th>
<th>Aktuell</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernelaktualisierung</td>
<td>4.4.0-116</td>
<td>4.4.0-127</td>
<td>Neue Workerknoten-Images mit Kernelaktualisierung für [CVE-2018-3639 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-3639).</td>
</tr>
</tbody>
</table>

#### Änderungsprotokoll für Workerknoten Fixpack 1.7.16_1513, veröffentlicht am 18. Mai 2018
{: #1716_1513}

<table summary="Seit Version 1.7.16_1512 vorgenommene Änderungen">
<caption>Änderungen seit Version 1.7.16_1512</caption>
<thead>
<tr>
<th>Komponente</th>
<th>Vorher</th>
<th>Aktuell</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>n.z.</td>
<td>n.z.</td>
<td>Fix für einen Programmfehler, der bei der Verwendung des Blockspeicher-Plug-ins auftrat.</td>
</tr>
</tbody>
</table>

#### Änderungsprotokoll für Workerknoten Fixpack 1.7.16_1512, veröffentlicht am 16. Mai 2018
{: #1716_1512}

<table summary="Seit Version 1.7.16_1511 vorgenommene Änderungen">
<caption>Änderungen seit Version 1.7.16_1511</caption>
<thead>
<tr>
<th>Komponente</th>
<th>Vorher</th>
<th>Aktuell</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>n.z.</td>
<td>n.z.</td>
<td>Die im Stammverzeichnis `kubelet` gespeicherten Daten werden nun auf einer größeren sekundären Platte der Maschine mit dem Workerknoten gespeichert.</td>
</tr>
</tbody>
</table>

#### Änderungsprotokoll für 1.7.16_1511, veröffentlicht am 19. April 2018
{: #1716_1511}

<table summary="Seit Version 1.7.4_1509 vorgenommene Änderungen">
<caption>Änderungen seit Version 1.7.4_1509</caption>
<thead>
<tr>
<th>Komponente</th>
<th>Vorher</th>
<th>Aktuell</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>v1.7.4</td>
<td>v1.7.16	</td>
<td><p>Werfen Sie einen Blick auf die [Kubernetes-Releaseinformationen ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/kubernetes/kubernetes/releases/tag/v1.7.16). Dieses Release befasst sich mit den Schwachstellen [CVE-2017-1002101 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002101) und [CVE-2017-1002102 ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002102).</p><p><strong>Anmerkung</strong>: `secret`, `configMap`, `downwardAPI` und projizierte Datenträger werden nun als schreibgeschützte Datenträger angehängt. Bisher konnten Apps Daten in diese Datenträger schreiben, aber das System konnte die Daten möglicherweise automatisch zurücksetzen. Wenn Ihre Apps das bisherige unsichere Verhalten erwarten, ändern Sie sie entsprechend.</p></td>
</tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.7.4-133</td>
<td>v1.7.16-17</td>
<td>`NodePort`- und `LoadBalancer`-Services unterstützen jetzt [das Beibehalten der Client-Quellen-IP](cs_loadbalancer.html#node_affinity_tolerations) durch Festlegen von `service.spec.externalTrafficPolicy` auf `Local`.</td>
</tr>
<tr>
<td></td>
<td></td>
<td></td>
<td>Korrigiert die [Edge-Knoten](cs_edge.html#edge)-Tolerierungskonfiguration für ältere Cluster.</td>
</tr>
</tbody>
</table>
