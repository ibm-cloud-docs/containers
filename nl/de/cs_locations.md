---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

keywords: kubernetes, iks, mzr, szr, multizone, multi az

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


# Standorte
{: #regions-and-zones}

Sie können {{site.data.keyword.containerlong}}-Cluster weltweit implementieren. Wenn Sie einen Cluster erstellen, verbleiben seine Ressourcen an dem Standort, an dem Sie den Cluster bereitgestellt haben. Sie können über einen globalen API-Endpunkt auf den Kubernetes-Service zugreifen, um mit Ihrem Cluster zu arbeiten.
{:shortdesc}

![{{site.data.keyword.containerlong_notm}}-Standorte](images/locations.png)

_{{site.data.keyword.containerlong_notm}}-Standorte_

{{site.data.keyword.cloud_notm}}-Ressourcen waren bisher in Regionen organisiert, auf die über [regionsspezifische Endpunkte](#bluemix_regions) zugegriffen wurde. Verwenden Sie stattdessen den [globalen Endpunkt](#endpoint).
{: deprecated}

## {{site.data.keyword.containerlong_notm}}-Standorte
{: #locations}

{{site.data.keyword.cloud_notm}}-Ressourcen sind in einer Hierarchie von Standorten organisiert. {{site.data.keyword.containerlong_notm}} ist in einer Untergruppe dieser Standorte verfügbar, einschließlich aller sechs weltweiten für mehrere Zonen geeigneten Regionen. Kostenlose Cluster sind nur in ausgewählten Standorten verfügbar. Andere {{site.data.keyword.cloud_notm}}-Services können global oder innerhalb eines bestimmten Standorts verfügbar sein.
{: shortdesc}

### Verfügbare Standorte
{: #available-locations}

Verwenden Sie zum Auflisten der verfügbaren {{site.data.keyword.containerlong_notm}}-Standorte den Befehl `ibmcloud ks supported-locations`.
{: shortdesc}

Die Organisation der {{site.data.keyword.containerlong_notm}}-Standorte wird anhand des Beispiels in der folgenden Abbildung erklärt.

![Organisation der {{site.data.keyword.containerlong_notm}}-Standorte](images/cs_regions_hierarchy.png)

<table summary="Die Tabelle zeigt die Organisation der {{site.data.keyword.containerlong_notm}}-Standorte. Die Zeilen sind von links nach rechts zu lesen. In Spalte 1 finden Sie den Standorttyp, ein Beispiel für den Typ in Spalte 2 und die Beschreibung in Spalte 3.">
<caption>Organisation von {{site.data.keyword.containerlong_notm}}-Standorten.</caption>
  <thead>
  <th>Typ</th>
  <th>Beispiel</th>
  <th>Beschreibung</th>
  </thead>
  <tbody>
    <tr>
      <td>Geografie</td>
      <td>Nordamerika (`na`)</td>
      <td>Eine Organisationsgruppierung, die auf geografischen Kontinenten basiert.</td>
    </tr>
    <tr>
      <td>Land</td>
      <td>Kanada (`ca`)</td>
      <td>Das Land des Standorts innerhalb der Geografie.</td>
    </tr>
    <tr>
      <td>Metropole</td>
      <td>Mexico-Stadt (`mex-cty`), Dallas (`dal`)</td>
      <td>Der Name einer Stadt, in der sich ein oder mehrere Rechenzentren (Zonen) befinden. Eine Metropole kann mehrzonenfähig sein und über mehrzonenfähige Rechenzentren verfügbar, z. B. Dallas, oder sie kann ausschließlich Rechenzentren mit jeweils einer Zone enthalten, z. B. Mexico-Stadt. Wenn Sie einen Cluster in einer mehrzonenfähigen Metropole erstellen, können Kubernetes-Masterknoten und -Workerknoten für Hochverfügbarkeit über Zonen verteilt werden.</td>
    </tr>
    <tr>
      <td>Rechenzentrum (Zone)</td>
      <td>Dallas 12 (`dal12`)</td>
      <td>Ein physischer Standort für die Berechnungs-, Netz- und Speicherinfrastruktur sowie die zugehörige Kühlung und Stromversorgung zum Hosten von Cloud-Services und -anwendungen. Cluster können für Hochverfügbarkeit in einer Mehrzonenarchitektur über Rechenzentren oder Zone verteilt werden. Zonen sind isoliert voneinander, wodurch sichergestellt wird, dass es keinen gemeinsamen Fehlerpunkt gibt.</td>
    </tr>
  </tbody>
  </table>

### Einzelzonen- und Mehrzonenstandorte in {{site.data.keyword.containerlong_notm}}
{: #zones}

In den folgenden Tabellen werden die verfügbaren Einzelzonen- und Mehrzonenstandorte in {{site.data.keyword.containerlong_notm}} aufgelistet. Beachten Sie, dass Sie einen Cluster in bestimmten Metropolen als Einzelzonen- oder Mehrzonencluster bereitstellen können. Kostenlose Cluster sind in ausgewählten Geografien als Einzelzonencluster mit einem Workerknoten verfügbar.
{: shortdesc}

* **Mehrzonig**: Wenn Sie einen Cluster in einer Mehrzonen-Metropole erstellen, werden die Replikate Ihres hoch verfügbaren Kubernetes-Masters automatisch auf Zonen verteilt. Sie haben die Option, Ihre Workerknoten auf Zonen zu verteilen, um Ihre App gegen Zonenausfall zu schützen.
* **Einzonig**: Wenn Sie einen Cluster an einem Standort mit nur einer Zone (oder einem Rechenzentrum) erstellen, können Sie mehrere Workerknoten erstellen, diese jedoch nicht auf mehrere Zonen verteilen. Der hoch verfügbare Master enthält drei Replikate auf separaten Hosts, ist jedoch nicht über mehrere Zonen verteilt.

Um schnell zu bestimmen, ob eine Zone mehrzonenfähig ist, können Sie den Befehl `ibmcloud ks supported-locations` ausführen und nach dem Wert in der Spalte für Mehrzonen-Metropolen (`Multizone Metro`) suchen.
{: tip}

{{site.data.keyword.cloud_notm}}-Ressourcen waren bisher in Regionen organisiert, auf die über [regionsspezifische Endpunkte](#bluemix_regions) zugegriffen wurde. In den Tabellen sind die bisherigen Regionen zur Information aufgelistet. In Zukunft können Sie den [globalen Endpunkt](#endpoint) verwenden, um zu einer regionslosen Architektur zu wechseln.
{: deprecated}

**Standorte mit Mehrzonen-Metropolen**

<table summary="Die Tabelle zeigt die verfügbaren Standorte mit Mehrzonen-Metropolen in {{site.data.keyword.containerlong_notm}}. Zeilen sind von links nach rechts zu lesen. Spalte 1 enthält die Geografie, in der der Standort sich befindet, Spalte 2 gibt das Land des Standorts an, Spalte 3 enthält die Metropole des Standorts, Spalte 4 das Rechenzentrum und Spalte 5 die veraltete Region, der der Standort bisher zugeordnet wurde.">
<caption>Verfügbare Standorte mit Mehrzonen-Metropolen in {{site.data.keyword.containerlong_notm}}.</caption>
  <thead>
  <th>Geografie</th>
  <th>Land</th>
  <th>Metropole</th>
  <th>Rechenzentrum</th>
  <th>Veraltete Region</th>
  </thead>
  <tbody>
    <tr>
      <td>Asien/Pazifik</td>
      <td>Australien</td>
      <td>Sydney</td>
      <td>syd01, syd04, syd05</td>
      <td>Asien-Pazifik (Süden) (`ap-south`, `au-syd`)</td>
    </tr>
    <tr>
      <td>Asien/Pazifik</td>
      <td>Japan</td>
      <td>Tokio</td>
      <td>tok02, tok04, tok05</td>
      <td>Asien-Pazifik (Norden) (`ap-north`, `jp-tok`)</td>
    </tr>
    <tr>
      <td>Europa</td>
      <td>Deutschland</td>
      <td>Frankfurt</td>
      <td>fra02, fra04, fra05</td>
      <td>Mitteleuropa (`eu-central`, `eu-de`)</td>
    </tr>
    <tr>
      <td>Europa</td>
      <td>Vereintes Königreich</td>
      <td>London</td>
      <td>lon04, lon05`*`, lon06</td>
      <td>Vereinigtes Königreich (Süden) (`uk-south`, `eu-gb`)</td>
    </tr>
    <tr>
      <td>Nordamerika</td>
      <td>Vereinigte Staaten</td>
      <td>Dallas</td>
      <td>dal10, dal12, dal13</td>
      <td>Vereinigte Staaten (Süden) (`us-south`)</td>
    </tr>
    <tr>
      <td>Nordamerika</td>
      <td>Vereinigte Staaten</td>
      <td>Washington, D.C.</td>
      <td>wdc04, wdc06, wdc07</td>
      <td>Vereinigte Staaten (Osten) (`us-east`)</td>
    </tr>
  </tbody>
  </table>

**Standorte mit Einzelzonenrechenzentren**

<table summary="Die Tabelle zeigt die verfügbaren Standorte mit Einzelzonenrechenzentren in {{site.data.keyword.containerlong_notm}}. Zeilen sind von links nach rechts zu lesen. Spalte 1 enthält die Geografie, in der der Standort sich befindet, Spalte 2 gibt das Land des Standorts an, Spalte 3 enthält die Metropole des Standorts, Spalte 4 das Rechenzentrum und Spalte 5 die veraltete Region, der der Standort bisher zugeordnet war.">
<caption>Verfügbare Standorte mit einer Zone in {{site.data.keyword.containerlong_notm}}.</caption>
  <thead>
  <th>Geografie</th>
  <th>Land</th>
  <th>Metropole</th>
  <th>Rechenzentrum</th>
  <th>Veraltete Region</th>
  </thead>
  <tbody>
    <tr>
      <td>Asien/Pazifik</td>
      <td>Australien</td>
      <td>Melbourne</td>
      <td>mel01</td>
      <td>Asien-Pazifik (Süden) (`ap-south`, `au-syd`)</td>
    </tr>
    <tr>
      <td>Asien/Pazifik</td>
      <td>Australien</td>
      <td>Sydney</td>
      <td>syd01, syd04, syd05</td>
      <td>Asien-Pazifik (Süden) (`ap-south`, `au-syd`)</td>
    </tr>
    <tr>
      <td>Asien/Pazifik</td>
      <td>China</td>
      <td>Hongkong<br>Sonderverwaltungszone der VR China</td>
      <td>hkg02</td>
      <td>Asien-Pazifik (Norden) (`ap-north`, `jp-tok`)</td>
    </tr>
    <tr>
      <td>Asien/Pazifik</td>
      <td>Indien</td>
      <td>Chennai</td>
      <td>che01</td>
      <td>Asien-Pazifik (Norden) (`ap-north`, `jp-tok`)</td>
    </tr>
    <tr>
      <td>Asien/Pazifik</td>
      <td>Japan</td>
      <td>Tokio</td>
      <td>tok02, tok04, tok05</td>
      <td>Asien-Pazifik (Norden) (`ap-north`, `jp-tok`)</td>
    </tr>
    <tr>
      <td>Asien/Pazifik</td>
      <td>Korea</td>
      <td>Seoul</td>
      <td>seo01</td>
      <td>Asien-Pazifik (Norden) (`ap-north`, `jp-tok`)</td>
    </tr>
    <tr>
      <td>Asien/Pazifik</td>
      <td>Singapur</td>
      <td>Singapur</td>
      <td>sng01</td>
      <td>Asien-Pazifik (Norden) (`ap-north`, `jp-tok`)</td>
    </tr>
    <tr>
      <td>Europa</td>
      <td>Frankreich</td>
      <td>Paris</td>
      <td>par01</td>
      <td>Mitteleuropa (`eu-central`, `eu-de`)</td>
    </tr>
    <tr>
      <td>Europa</td>
      <td>Deutschland</td>
      <td>Frankfurt</td>
      <td>fra02, fra04, fra05</td>
      <td>Mitteleuropa (`eu-central`, `eu-de`)</td>
    </tr>
    <tr>
      <td>Europa</td>
      <td>Italien</td>
      <td>Mailand</td>
      <td>mil01</td>
      <td>Mitteleuropa (`eu-central`, `eu-de`)</td>
    </tr>
    <tr>
      <td>Europa</td>
      <td>Niederlande</td>
      <td>Amsterdam</td>
      <td>ams03</td>
      <td>Mitteleuropa (`eu-central`, `eu-de`)</td>
    </tr>
    <tr>
      <td>Europa</td>
      <td>Norwegen</td>
      <td>Oslo</td>
      <td>osl</td>
      <td>Mitteleuropa (`eu-central`, `eu-de`)</td>
    </tr>
    <tr>
      <td>Europa</td>
      <td>Vereintes Königreich</td>
      <td>London</td>
      <td>lon02`*`, lon04, lon05`*`, lon06</td>
      <td>Vereinigtes Königreich (Süden) (`uk-south`, `eu-gb`)</td>
    </tr>
    <tr>
      <td>Nordamerika</td>
      <td>Kanada</td>
      <td>Montreal</td>
      <td>mon01</td>
      <td>Vereinigte Staaten (Osten) (`us-east`)</td>
    </tr>
    <tr>
      <td>Nordamerika</td>
      <td>Kanada</td>
      <td>Toronto</td>
      <td>tor01</td>
      <td>Vereinigte Staaten (Osten) (`us-east`)</td>
    </tr>
    <tr>
      <td>Nordamerika</td>
      <td>Mexico</td>
      <td>Mexiko-Stadt</td>
      <td>mex01</td>
      <td>Vereinigte Staaten (Süden) (`us-south`)</td>
    </tr>
    <tr>
      <td>Nordamerika</td>
      <td>Vereinigte Staaten</td>
      <td>Dallas</td>
      <td>dal10, dal12, dal13</td>
      <td>Vereinigte Staaten (Süden) (`us-south`)</td>
    </tr>
    <tr>
      <td>Nordamerika</td>
      <td>Vereinigte Staaten</td>
      <td>San Jose</td>
      <td>sjc03, sjc04</td>
      <td>Vereinigte Staaten (Süden) (`us-south`)</td>
    </tr>
    <tr>
      <td>Nordamerika</td>
      <td>Vereinigte Staaten</td>
      <td>Washington, D.C.</td>
      <td>wdc04, wdc06, wdc07</td>
      <td>Vereinigte Staaten (Osten) (`us-east`)</td>
    </tr>
    <tr>
      <td>Südamerika</td>
      <td>Brasilien</td>
      <td>São Paulo</td>
      <td>sao01</td>
      <td>Vereinigte Staaten (Süden) (`us-south`)</td>
    </tr>
  </tbody>
  </table>

`*` lon05 ersetzt lon02. Neue Cluster müssen lon05 verwenden; lon05 unterstützt hoch verfügbare Master, die über mehrere Zonen verteilt sind.
{: note}

### Einzelzonencluster
{: #regions_single_zone}

In einem Einzelzonencluster bleiben die Ressourcen Ihres Clusters in der Zone, in der der Cluster bereitgestellt wird. Die folgende Abbildung stellt die Beziehung zwischen Komponenten eines Einzelzonenclusters am Beispiel des Standorts Toronto, Kanada (`tor01`), dar.
{: shortdesc}

<img src="/images/location-cluster-resources.png" width="650" alt="Erklärung, wo Ihre Clusterressourcen sich befinden" style="width:650px; border-style: none"/>

_Erklärung, wo Ihre Einzelzonenclusterressourcen sich befinden._

1.  Die Ressourcen Ihres Clusters, einschließlich der Master- und Workerknoten, befinden sich in dem Rechenzentrum, in dem Sie auch den Cluster bereitgestellt haben. Wenn Sie lokale Container-Orchestrierungsaktionen wie z. B. `kubectl`-Befehle einleiten, werden die Informationen zwischen den Master- und Workerknoten innerhalb derselben Zone ausgetauscht.

2.  Wenn Sie andere Clusterressourcen konfigurieren, z. B. Speicher-, Netz- und Rechenressourcen oder Apps, die in Pods ausgeführt werden, verbleiben die Ressourcen und ihre Daten in der Zone, in der Sie den Cluster bereitgestellt haben.

3.  Wenn Sie Clusterverwaltungsaktionen wie `ibmcloud ks`-Befehle ausführen, werden Basisinformationen über die Cluster (wie z. B. Name, ID, Benutzer, Befehl) über einen globalen Endpunkt an den regionalen Endpunkt weitergeleitet. Regionale Endpunkte befinden sich in der nächstgelegenen Region mit einer Mehrzonen-Metropole. In diesem Beispiel ist die Metropolregion Washington, D.C.

### Mehrzonencluster
{: #regions_multizone}

In einem Mehrzonencluster werden die Ressourcen Ihres Clusters für höhere Verfügbarkeit über mehrere Zonen verteilt.
{: shortdesc}

1.  Die Workerknoten verteilen sich auf mehrere Zonen des Metropolstandorts, um mehr Verfügbarkeit für Ihren Cluster bereitzustellen. Die Kubernetes-Masterreplikate werden ebenfalls über mehrere Zonen verteilt. Wenn Sie lokale Container-Orchestrierungsaktionen (z. B. `kubectl`-Befehle) einleiten, werden die Informationen zwischen Ihrem Master- und Workerknoten über den globalen Endpunkt ausgetauscht.

2.  Andere Clusterressourcen, z. B. Speicher-, Netz- und Rechenressourcen oder Apps, die in Pods ausgeführt werden, variieren in der Art und Weise, wie sie in den Zonen in Ihrem Mehrzonencluster bereitgestellt werden. Weitere Informationen finden Sie in den folgenden Abschnitten:
    *   [Dateispeicher](/docs/containers?topic=containers-file_storage#add_file) und [Blockspeicher](/docs/containers?topic=containers-block_storage#add_block) in Mehrzonenclustern einrichten oder [eine Mehrzonenlösung für persistenten Speicher auswählen](/docs/containers?topic=containers-storage_planning#persistent_storage_overview).
    *   [Öffentlichen oder privaten Zugriff auf eine App mithilfe einer Netzlastausgleichsfunktion (NLB) in einem Mehrzonencluster aktivieren](/docs/containers?topic=containers-loadbalancer#multi_zone_config).
    *   [Netzverkehr mithilfe von Ingress verwalten](/docs/containers?topic=containers-ingress-about)
    *   [Verfügbarkeit Ihrer App erhöhen](/docs/containers?topic=containers-app#increase_availability)

3.  Wenn Sie Clusterverwaltungsaktionen initiieren, wie z. B. die Verwendung von [`ibmcloud ks`-Befehlen](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli), werden grundlegende Informationen (wie Name, ID, Benutzer, Befehl) über den globalen Endpunkt weitergeleitet.

### Kostenlose Cluster
{: #regions_free}

Kostenlose Cluster sind auf bestimmte Standorte beschränkt.
{: shortdesc}

**Kostenlosen Cluster in der CLI erstellen**: Bevor Sie einen kostenlosten Cluster erstellen, müssen Sie eine Region als Ziel festlegen, indem Sie den Befehl `ibmcloud ks region-set` ausführen. Ihr Cluster wird in einer Metropole in der von Ihnen als Ziel festgelegten Region erstellt: Metropole Sydney in `ap-south`, Metropole Frankfurt in `eu-central`, Metropole London in `uk-south` oder Metropole Dallas in `us-south`. Beachten Sie, dass Sie keine Zone innerhalb der Metropole angeben können.

**Kostenlosen Cluster in der {{site.data.keyword.cloud_notm}}-Konsole erstellen**: Wenn Sie die Konsole verwenden, können Sie eine Geografie und innerhalb der Geografie einen Standort auswählen. Sie können die Metropole Dallas in Nordamerika, die Metropolen Frankfurt oder London in Europa oder die Metropole Sydney im asiatisch-pazifischen Raum auswählen. Ihr Cluster wird in einer Zone in der von Ihnen ausgewählten Metropole erstellt.

Um mit einem freien Cluster in der Metropole London zu arbeiten, müssen Sie die regionale API für 'Zentraleuropa' als Ziel festzulegen, indem Sie Folgendes ausführen: `ibmcloud ks init --host https://eu-gb.containers.cloud.ibm.com`.
{: important}

<br />


## Auf den globalen Endpunkt zugreifen
{: #endpoint}

Sie können Ihre Ressourcen über die {{site.data.keyword.cloud_notm}}-Services hinweg organisieren, indem Sie die {{site.data.keyword.cloud_notm}}-Standorte(bisher Regionen genannt) verwenden. Sie können beispielsweise einen Kubernetes-Cluster mithilfe eines privaten Docker-Images erstellen, das in Ihrem {{site.data.keyword.registryshort_notm}} an demselben Standort gespeichert ist. Um auf diese Ressourcen zugreifen zu können, können Sie die globalen Endpunkte verwenden und nach Standort filtern.
{:shortdesc}

### Bei {{site.data.keyword.cloud_notm}} anmelden
{: #login-ic}

Wenn Sie sich an der {{site.data.keyword.cloud_notm}}-Befehlszeile (`ibmcloud`) anmelden, werden Sie aufgefordert, eine Region auszuwählen. Diese Region wirkt sich jedoch nicht auf den Endpunkt des {{site.data.keyword.containerlong_notm}}-Plug-ins (`ibmcloud ks`) aus, das weiterhin den globalen Endpunkt verwendet. Beachten Sie, dass Sie weiterhin die Ressourcengruppe als Ziel angeben müssen, in der sich Ihr Cluster befindet, wenn er sich nicht in der Standardressourcengruppe befindet.
{: shortdesc}

Gehen Sie wie folgt vor, um sich am globalen Endpunkt der {{site.data.keyword.cloud_notm}}-API anzumelden und die Ressourcengruppe als Ziel anzugeben, in der sich Ihr Cluster befindet:
```
ibmcloud login -a https://cloud.ibm.com -g <name_der_vom_standard_abweichenden_ressourcengruppe>
```
{: pre}

### Bei {{site.data.keyword.containerlong_notm}} anmelden
{: #login-iks}

Wenn Sie sich bei {{site.data.keyword.cloud_notm}} anmelden, können Sie auf {{site.data.keyword.containershort_notm}} zugreifen. Um Ihnen den Einstieg zu erleichtern, überprüfen Sie die folgenden Ressourcen für die Verwendung der CLI und der API von {{site.data.keyword.containerlong_notm}}.
{: shortdesc}

**{{site.data.keyword.containerlong_notm}}-CLI**:
* [Richten Sie Ihre CLI für die Verwendung des Plug-ins `ibmcloud ks` ein](/docs/containers?topic=containers-cs_cli_install#cs_cli_install).
* [Konfigurieren Sie Ihre CLI für die Herstellung einer Verbindung zu einem bestimmten Cluster und die Ausführung von `kubectl`-Befehlen](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure).

Standardmäßig sind Sie beim globalen Endpunkt von {{site.data.keyword.containerlong_notm}}, `https://containers.cloud.ibm.com`, angemeldet.

Wenn Sie die neue globale Funktionalität in der {{site.data.keyword.containerlong_notm}}-CLI verwenden, sollten Sie die folgenden Änderungen im Vergleich zur traditionellen regionsbasierten Funktionalität berücksichtigen.

* Ressourcen auflisten:
  * Wenn Sie Ressourcen auflisten, beispielsweise mit dem Befehl `ibmcloud ks clusters`, `ibmcloud ks subnets` oder `ibmcloud ks zones`, werden die Ressourcen aller Standorte zurückgegeben. Um Ressourcen nach einem bestimmten Standort zu filtern, schließen bestimmte Befehle ein Flag `--locations` ein. Wenn Sie beispielsweise Cluster nach der Metropole `dal` filtern, werden Mehrzonencluster in dieser Metropole und Einzelzonencluster in Rechenzentren (Zonen) innerhalb dieser Metropole zurückgegeben. Wenn Sie Cluster nach dem Rechenzentrum (Zone) `dal10` filtern, werden Mehrzonencluster mit einem Workerknoten in dieser Zone und Einzelzonencluster in dieser Zone zurückgegeben. Beachten Sie, dass Sie einen Standort oder eine durch Kommas getrennte Liste mit Standorten übergeben können.
    Beispiel für das Filtern nach Standort:
    ```
    ibmcloud ks clusters --locations dal
    ```
    {: pre}
  * Andere Befehle geben nicht für alle Standorte Ressourcen zurück. Zum Ausführen der Befehle `credential-set/unset/get`, `api-key-reset` und `vlan-spanning-get` müssen Sie in `--region` eine Region angeben.

* Mit Ressourcen arbeiten:
  * Wenn Sie den globalen Endpunkt verwenden, können Sie mit Ressourcen arbeiten, für die Sie an jedem beliebigen Standort über Zugriffsberechtigungen verfügen, selbst wenn Sie eine Region festlegen, indem Sie `ibmcloud ks region-set` ausführen, und die Ressource, mit der Sie arbeiten möchten, sich in einer anderen Region befindet.
  * Wenn Sie Cluster mit demselben Namen in verschiedenen Regionen haben, können Sie entweder die Cluster-ID verwenden, wenn Sie Befehle ausführen oder eine Region mit dem Befehl `ibmcloud ks region-set` festlegen und den Clusternamen bei der Ausführung von Befehlen verwenden.

* Traditionelle Funktionalität:
  * Wenn Sie nur Ressourcen aus einer Region auflisten und mit ihnen arbeiten müssen, können Sie den [Befehl](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_init) `ibmcloud ks init` verwenden, um einen regionalen Endpunkt anstelle des globalen Endpunkts zu verwenden.
    Beispiel für das Festlegen des regionalen Endpunkts "Vereinigte Staaten (Süden)":
    ```
    ibmcloud ks init --host https://us-south.containers.cloud.ibm.com
    ```
    {: pre}
  * Um die globale Funktionalität zu verwenden, können Sie den Befehl `ibmcloud ks init` erneut verwenden, um den globalen Endpunkt als Ziel festzulegen. Beispiel für das erneute Festlegen des globalen Endpunkts:
    ```
    ibmcloud ks init --host https://containers.cloud.ibm.com
    ```
    {: pre}

</br></br>
**{{site.data.keyword.containerlong_notm}}-API**:
* [Machen Sie sich mit der API vertraut.](/docs/containers?topic=containers-cs_cli_install#cs_api).
* [Zeigen Sie die Dokumentation zu den API-Befehlen an](https://containers.cloud.ibm.com/global/swagger-global-api/).
* Generieren Sie einen Client der API zur Verwendung in der Automatisierung, indem Sie die [API `swagger.json`](https://containers.cloud.ibm.com/global/swagger-global-api/swagger.json) verwenden.

Um mit der {{site.data.keyword.containerlong_notm}}-API interagieren zu können, müssen Sie den Befehlstyp eingeben und die Zeichenfolge `global/v1/command` an den Endpunkt anfügen.

Beispiel für die globale API `GET /clusters`:
```
GET https://containers.cloud.ibm.com/global/v1/clusters
```
{: codeblock}

</br>

Wenn Sie in einem API-Aufruf eine Region angeben müssen, entfernen Sie den Parameter `/global` aus dem Pfad und übergeben Sie den Regionsnamen im Header `X-Region`. Führen Sie den Befehl `ibmcloud ks regions` aus, um die verfügbaren Regionen aufzuführen.

<br />



## Veraltet: Bisherige Struktur der {{site.data.keyword.cloud_notm}}-Regionen und -Zonen
{: #bluemix_regions}

Bisher waren Ihre {{site.data.keyword.cloud_notm}}-Ressourcen in Zonen organisiert. Regionen sind ein konzeptionelles Hilfsmittel, um Zonen zu organisieren und können Zonen (Rechenzentren) in verschiedenen Ländern und Geografien umfassen. In der folgenden Tabelle werden die bisherigen {{site.data.keyword.cloud_notm}}-Regionen, {{site.data.keyword.containerlong_notm}}-Regionen und {{site.data.keyword.containerlong_notm}}-Zonen zugeordnet. Mehrzonenfähige Zonen sind fett dargestellt.
{: shortdesc}

Regionsspezifische Endpunkte werden nicht mehr verwendet. Verwenden Sie stattdessen den [globalen Endpunkt](#endpoint). Wenn Sie regionale Endpunkte verwenden müssen, [setzen Sie die Umgebungsvariable `IKS_BETA_VERSION` im {{site.data.keyword.containerlong_notm}}-Plug-in auf `0.2`](/docs/containers-cli-plugin?topic=containers-cli-plugin-kubernetes-service-cli#cs_beta).
{: deprecated}

| {{site.data.keyword.containerlong_notm}}-Region | Entsprechende {{site.data.keyword.cloud_notm}}-Regionen | In der Region verfügbare Zonen |
| --- | --- | --- |
| Asien-Pazifik (nur Standardcluster) | Tokio | che01, hkg02, seo01, sng01, **tok02, tok04, tok05** |
| Asien-Pazifik (Süden) | Sydney | mel01, **syd01, syd04, syd05** |
| Mitteleuropa | Frankfurt | ams03, **fra02, fra04, fra05**, mil01, osl01, par01 |
| Vereinigtes Königreich (Süden) | London | lon02, **lon04, lon05, lon06** |
| Vereinigte Staaten (Osten) (nur Standardcluster) | Washington DC | mon01, tor01, **wdc04, wdc06, wdc07** |
| Vereinigte Staaten (Süden) | Dallas | **dal10, dal12, dal13**, mex01, sjc03, sjc04, sao01 |
{: caption="Entsprechende {{site.data.keyword.containershort_notm}}- und {{site.data.keyword.cloud_notm}}-Regionen mit Zonen. Mehrzonenfähige Zonen sind fett dargestellt." caption-side="top"}

Mithilfe von {{site.data.keyword.containerlong_notm}}-Regionen können Sie Kubernetes-Cluster erstellen oder auf Kubernetes-Cluster in einer Region zugreifen, die von der {{site.data.keyword.cloud_notm}}-Region abweicht, in der Sie angemeldet sind. Die Endpunkte für die {{site.data.keyword.containerlong_notm}}-Region verweisen speziell auf {{site.data.keyword.containerlong_notm}} und nicht auf {{site.data.keyword.cloud_notm}} im Allgemeinen.

Sie können sich beispielsweise aus den folgenden Gründen bei einer anderen Region als der {{site.data.keyword.containerlong_notm}}-Region anmelden:
  * Sie haben {{site.data.keyword.cloud_notm}}-Services oder private Docker-Images in einer Region erstellt und wollen sie mit {{site.data.keyword.containerlong_notm}} in einer anderen Region verwenden.
  * Sie möchten auf einen Cluster in einer Region zugreifen, die sich von der {{site.data.keyword.cloud_notm}}-Standardregion unterscheidet, bei der Sie angemeldet sind.

Um schnell zwischen Regionen wechseln zu können, verwenden Sie den [Befehl](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_region-set) `ibmcloud ks region-set`.
