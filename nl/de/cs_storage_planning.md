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




# Persistenten Hochverfügbarkeitsspeicher planen
{: #storage_planning}

## Optionen für nicht persistente Datenspeicherung
{: #non_persistent}

Optionen für nicht persistente Speicherung können verwendet werden, wenn die zu speichernden Daten nicht permanent verfügbar sein müssen oder nicht von App-Instanzen gemeinsam genutzt werden. Außerdem können diese Speicheroptionen zum Testen von App-Komponenten oder neuen Funktionen verwendet werden.
{: shortdesc}

Die folgende Abbildung zeigt die verfügbaren Optionen für nicht persistente Datenspeicherung in {{site.data.keyword.containerlong_notm}}. Diese Optionen stehen für kostenlose Cluster und für Standardcluster zur Verfügung.
<p>
<img src="images/cs_storage_nonpersistent.png" alt="Nicht persistente Datenspeicherungsoptionen" width="500" style="width: 500px; border-style: none"/></p>

<table summary="Die Tabelle zeigt nicht persistente Datenspeicherungsoptionen. Die Tabellenzeilen enthalten von links nach rechts die Nummer der Option in der ersten Spalte, den Titel der Option in der zweiten Spalte und die Beschreibung in der dritten Spalte." style="width: 100%">
<caption>Nicht persistente Speicheroptionen</caption>
  <thead>
  <th>Option</th>
  <th>Beschreibung</th>
  </thead>
  <tbody>
    <tr>
      <td>1. Innerhalb des Containers oder Pods</td>
      <td>Container und Pods sind per Definition Komponenten mit kurzer Lebensdauer, die kurzfristig und unerwartet ausfallen können. Sie können jedoch Daten in das lokale Dateisystem eines Containers schreiben, um diese Daten für die Lebensdauer des Containers zu speichern. Daten in einem Container können nicht mit anderen Containern oder Pods gemeinsam genutzt werden und gehen verloren, wenn der Container ausfällt oder entfernt wird. Weitere Informationen finden Sie unter [Storing data in a container](https://docs.docker.com/storage/).</td>
    </tr>
  <tr>
    <td>2. Auf dem Workerknoten</td>
    <td>Für jeden Workerknoten wird primärer und sekundärer Speicher entsprechend dem Maschinentyp eingerichtet, den Sie für Ihren Workerknoten auswählen. Der primäre Speicher dient zum Speichern von Betriebssystemdaten und auf ihn kann mithilfe eines [Kubernetes-<code>HostPath</code>-Datenträgers![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/concepts/storage/volumes/#hostpath) zugegriffen werden. The secondary storage is used to store data from thDer sekundäre Speicher dient zum Speichern von Daten aus `kubelet` und der Laufzeitengine des Containers. Sie können auf den zweiten Speicher zugreifen, indem Sie einen [Kubernetes-<code>emptyDir</code>-Datenträger verwenden![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/concepts/storage/volumes/#emptydir)<br/><br/>Während <code>HostPath</code>-Datenträger verwendet werden, um Dateien vom Dateisystem des Workerknotens auf Ihrem Pod anzuhängen (mount), erstellt <code>emptyDir</code> ein leeres Verzeichnis, das einem Pod in Ihrem Cluster zugewiesen ist. Alle Container in diesem Pod können von diesem Datenträger lesen und auf diesen Datenträger schreiben. Da der Datenträger einem ganz bestimmten Pod zugewiesen ist, können Daten nicht mit anderen Pods in einer Replikatgruppe gemeinsam genutzt werden.<br/><br/><p>Ein <code>HostPath</code>- oder <code>emptyDir</code>-Datenträger und die zugehörigen Daten werden in folgenden Situationen entfernt: <ul><li>Der Workerknoten wird gelöscht.</li><li>Der Workerknoten wird neu geladen oder aktualisiert.</li><li>Der Cluster wird gelöscht.</li><li>Das {{site.data.keyword.Bluemix_notm}}-Konto wird ausgesetzt. </li></ul></p><p>Zusätzlich werden Daten auf einem <code>emptyDir</code>-Datenträger in folgenden Situationen entfernt: <ul><li>Der zugewiesene Pod auf dem Workerknoten wird permanent gelöscht.</li><li>Der zugewiesene Pod wird auf einem anderen Workerknoten terminiert.</li></ul></p><p><strong>Hinweis:</strong> Wenn der Container im Pod ausfällt, sind die im Datenträger enthaltenen Daten trotzdem noch auf dem Workerknoten verfügbar.</p></td>
    </tr>
    </tbody>
    </table>


## Optionen für persistenten Datenspeicher mit hoher Verfügbarkeit
{: #persistent}

Die größte Herausforderung bei der Erstellung von hoch verfügbaren, statusabhängigen Apps besteht in der Persistenz von Daten zwischen mehreren App-Instanzen in mehreren Zonen und darin, die Daten ständig synchron zu halten. Bei hoch verfügbaren Daten sollten Sie sicherstellen, dass eine Masterdatenbank mit mehreren Instanzen vorhanden ist, die auf mehrere Rechenzentren oder Regionen verteilt ist. Diese Masterdatenbank muss fortlaufend repliziert werden, um eine einzelne Wissensressource beizubehalten. Alle Instanzen in Ihrem Cluster müssen aus dieser Masterdatenbank lesen und in sie schreiben. Wenn eine Instanz der Masterdatenbank nicht betriebsbereit ist, übernehmen anderen Instanzen die Arbeitslast, damit keine Ausfallzeiten für Ihre Apps entstehen.
{: shortdesc}

Die folgende Abbildung zeigt, mit welchen Optionen Sie Ihre Daten in {{site.data.keyword.containerlong_notm}} in einem Standardcluster hoch verfügbar machen können. Welche Option für Ihr Szenario am besten geeignet ist, hängt von den folgenden Faktoren ab:
  * **Typ der verwendeten App:** Möglicherweise muss Ihre App Daten in Dateien speichern und nicht in einer Datenbank.
  * **Gesetzliche Anforderungen für das Speichern und Weiterleiten der Daten:** Möglicherweise sind Sie dazu verpflichtet, Daten ausschließlich in den USA zu speichern und weiterzuleiten, d. h. Sie dürfen keinen Service mit Standort in Europa verwenden.
  * **Optionen für Sicherung und Wiederherstellung:** Jede Speicheroption bietet Funktionen zum Sichern und Wiederherstellen von Daten. Überprüfen Sie, dass die verfügbaren Optionen für Sicherung und Wiederherstellung den Anforderungen (z. B. Häufigkeit der Sicherungen oder Möglichkeiten zur Datenspeicherung außerhalb Ihres primären Rechenzentrums) Ihres Disaster-Recovery-Plans entsprechen.
  * **Globale Replikation:** Für die Hochverfügbarkeit kann es sinnvoll sein, mehrere Speicherinstanzen einzurichten, die auf Rechenzentren in der ganzen Welt verteilt und repliziert werden.

<br/>
<img src="images/cs_storage_mz-ha.png" alt="Hochverfügbarkeitsoptionen für persistenten Speicher"/>

<table summary="Die Tabelle zeigt persistente Speicheroptionen. Die Zeilen sind von links nach rechts zu lesen, wobei die Optionsnummer in der ersten Spalte, der Optionstitel in der zweiten Spalte und eine Beschreibung in der dritten Spalte steht" style="width: 100%">
<caption>Persistente Speicheroptionen</caption>
  <thead>
  <th>Option</th>
  <th>Beschreibung</th>
  </thead>
  <tbody>
  <tr>
  <td>1. NFS- oder Blockspeicher</td>
  <td>Diese Option stellt persistente App- und Containerdaten innerhalb derselben Zone mithilfe von persistenten Kubernetes-Datenträgern bereit.</br></br><strong>Wie kann ich Datei- oder Blockspeicher bereitstellen?</strong></br>Um Dateispeicher und Blockspeicher in einem Cluster bereitzustellen, verwenden Sie [persistente Datenträger (PVs) und Persistent Volume Claims (PVCs)](cs_storage_basics.html#pvc_pv). PVCs und PVs sind Kubernetes-Konzepte, die die API zusammenfassen, um die physische Datei- oder Blockspeichereinheit bereitzustellen. Sie können PVCs und PVs erstellen, indem Sie die [dynamische](cs_storage_basics.html#dynamic_provisioning) oder die [statische](cs_storage_basics.html#static_provisioning) Bereitstellung verwenden.</br></br><strong>Kann ich Datei- oder Blockspeicher in einem Mehrzonencluster verwenden?</strong></br> Datei- und Blockspeichereinheiten sind für eine Zone spezifisch und können nicht zonen- oder regionsübergreifend gemeinsam genutzt werden. Um diesen Typ von Speicher in einem Cluster zu verwenden, müssen Sie in der Zone, in der sich auch der Speicher befindet, über mindestens einen Workerknoten verfügen.</br></br>Wenn Sie in einem Cluster, der sich über mehrere Zonen erstreckt, Datei- und Blockspeicher [dynamisch bereitstellen](cs_storage_basics.html#dynamic_provisioning), wird der Speicher nur in einer einzigen Zone bereitgestellt, die im Umlaufverfahren ausgewählt wird. Um persistenten Speicher in allen Zonen Ihres Mehrzonenclusters bereitzustellen, müssen Sie die Schritte wiederholen, um in jeder einzelnen Zone dynamischen Speicher bereitzustellen. Wenn Ihr Cluster sich z. B. über die Zonen `dal10`, `dal12` und `dal13` erstreckt, wird bei der ersten dynamischen Bereitstellung von persistentem Speicher der Speicher möglicherweise in `dal10` bereitgestellt. Erstellen Sie zwei weitere PVCs, um auch `dal12` und `dal13` abzudecken.</br></br><strong>Wie gehe ich vor, wenn ich Daten zonenübergreifend gemeinsam nutzen will?</strong></br>Wenn Sie Daten zonenübergreifend nutzen möchten, müssen Sie einen Cloud-Datenbankservice wie z. B. [{{site.data.keyword.cloudant_short_notm}}](/docs/services/Cloudant/getting-started.html#getting-started-with-cloudant) oder [{{site.data.keyword.cos_full_notm}}](/docs/services/cloud-object-storage/about-cos.html#about-ibm-cloud-object-storage) verwenden. </td>
  </tr>
  <tr id="cloud-db-service">
    <td>2. Cloud-Datenbankservice</td>
    <td>Mit dieser Option können Sie über einen {{site.data.keyword.Bluemix_notm}}-Datenbankservice (z. B. [IBM Cloudant NoSQL DB](/docs/services/Cloudant/getting-started.html#getting-started-with-cloudant)) Daten persistent speichern. </br></br><strong>Kann ich einen Cloud-Datenbankservice für meinen Mehrzonencluster verwenden?</strong></br>Bei einem Cloud-Datenbankservice werden die Daten außerhalb des Clusters in der angegebenen Serviceinstanz gespeichert. Die Serviceinstanz wird in einer einzigen Zone bereitgestellt. Jede Serviceinstanz wird jedoch mit einer externen Schnittstelle geliefert, die Sie für den Zugriff auf Ihre Daten verwenden können. Wenn Sie für einen Mehrzonencluster einen Datenbankservice verwenden, können Sie Daten cluster-, zonen- und regionsübergreifend gemeinsam nutzen. Damit Ihre Serviceinstanz umfassender verfügbar ist, können Sie wählen, zonenübergreifend mehrere Instanzen zu konfigurieren und für die Hochverfügbarkeit zwischen den Instanzen die Replikation einzurichten. </br></br><strong>Wie kann ich meinem Cluster einen Cloud-Datenbankservice hinzufügen?</strong></br>Um einen Service in Ihrem Cluster zu verwenden, [binden Sie den {{site.data.keyword.Bluemix_notm}}-Service](cs_integrations.html#adding_app) an einen Namensbereich in Ihrem Cluster. Bei diesem Vorgang wird ein geheimer Kubernetes-Schlüssel erstellt. Der geheime Kubernetes-Schlüssel enthält vertrauliche Informationen zu dem Service (z. B. die URL für den Service, Ihren Benutzernamen und das Kennwort). Sie können den geheimen Schlüssel als Datenträger für geheime Schlüssel an Ihren Pod anhängen und unter Verwendung der im geheimen Schlüssel gespeicherten Berechtigungsnachweise auf den Service zugreifen. Durch Anhängen des Datenträgers für geheime Schlüssel an andere Pods können Sie Daten podübergreifend gemeinsam nutzen. Wenn ein Container ausfällt oder ein Pod von einem Workerknoten entfernt wird, werden die Daten selbst nicht entfernt; auf sie kann über andere Pods zugegriffen werden, an die der Datenträger für geheime Schlüssel angehängt ist. </br></br>Die meisten {{site.data.keyword.Bluemix_notm}}-Datenbankservices stellen Plattenspeicher für ein geringes Datenvolumen gebührenfrei zur Verfügung, damit Sie dessen Funktionen testen können.</p></td>
  </tr>
  <tr>
    <td>3. Lokale Datenbank</td>
    <td>Wenn Ihre Daten aus rechtlichen Gründen lokal gespeichert werden müssen, können Sie eine [VPN-Verbindung zur lokalen Datenbank einrichten](cs_vpn.html#vpn) und die in Ihrem Rechenzentrum vorhandenen Sicherungs- und Wiederherstellungsverfahren verwenden.</td>
  </tr>
  </tbody>
  </table>

{: caption="Tabelle. Optionen für persistentes Speichern von Daten bei Bereitstellungen in Kubernetes-Clustern" caption-side="top"}
