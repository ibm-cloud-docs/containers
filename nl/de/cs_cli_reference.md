---

copyright:
  years: 2014, 2017
lastupdated: "2017-08-14"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip} 
{:download: .download}


# CLI-Referenz zum Verwalten von Clustern
{: #cs_cli_reference}

Verwenden Sie diese Befehle, um Cluster zu erstellen und zu verwalten.
{:shortdesc}

**Tipp:** Suchen Sie nach `bx cr`-Befehlen? Werfen Sie einen Blick in die [{{site.data.keyword.registryshort_notm}}-CLI-Referenz ](/docs/cli/plugins/registry/index.html#containerregcli). Suchen Sie nach `kubectl`-Befehlen? Werfen Sie einen Blick in die [Kubernetes-Dokumentation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/user-guide/kubectl/v1.5/). 

 
<!--[https://github.ibm.com/alchemy-containers/armada-cli ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.ibm.com/alchemy-containers/armada-cli)-->

<table summary="Befehle zum Erstellen von Clustern in {{site.data.keyword.Bluemix_notm}}">
 <thead>
    <th colspan=5>Befehle zum Erstellen von Clustern in {{site.data.keyword.Bluemix_notm}}</th>
 </thead>
 <tbody>
 <tr>
    <td>[bx cs cluster-config](cs_cli_reference.html#cs_cluster_config)</td>
    <td>[bx cs cluster-create](cs_cli_reference.html#cs_cluster_create)</td> 
    <td>[bx cs cluster-get](cs_cli_reference.html#cs_cluster_get)</td>
    <td>[bx cs cluster-rm](cs_cli_reference.html#cs_cluster_rm)</td>
    <td>[bx cs cluster-service-bind](cs_cli_reference.html#cs_cluster_service_bind)</td>
 </tr>
 <tr>
    <td>[bx cs cluster-service-unbind](cs_cli_reference.html#cs_cluster_service_unbind)</td>
    <td>[bx cs cluster-services](cs_cli_reference.html#cs_cluster_services)</td> 
    <td>[bx cs cluster-subnet-add](cs_cli_reference.html#cs_cluster_subnet_add)</td>
    <td>[bx cs clusters](cs_cli_reference.html#cs_clusters)</td>
    <td>[bx cs credentials-set](cs_cli_reference.html#cs_credentials_set)</td>
 </tr>
 <tr>
   <td>[bx cs credentials-unset](cs_cli_reference.html#cs_credentials_unset)</td>
   <td>[bx cs locations](cs_cli_reference.html#cs_datacenters)</td> 
   <td>[bx cs help](cs_cli_reference.html#cs_help)</td>
   <td>[bx cs init](cs_cli_reference.html#cs_init)</td>
   <td>[bx cs machine-types](cs_cli_reference.html#cs_machine_types)</td>
   </tr>
 <tr>
    <td>[bx cs subnets](cs_cli_reference.html#cs_subnets)</td>
    <td>[bx cs vlans](cs_cli_reference.html#cs_vlans)</td> 
    <td>[bx cs webhook-create](cs_cli_reference.html#cs_webhook_create)</td>
    <td>[bx cs worker-add](cs_cli_reference.html#cs_worker_add)</td>
    <td>[bx cs worker-get](cs_cli_reference.html#cs_worker_get)</td>
    </tr>
 <tr>
   <td>[bx cs worker-reboot](cs_cli_reference.html#cs_worker_reboot)</td>
   <td>[bx cs worker-reload](cs_cli_reference.html#cs_worker_reload)</td> 
   <td>[bx cs worker-rm](cs_cli_reference.html#cs_worker_rm)</td>
   <td>[bx cs workers](cs_cli_reference.html#cs_workers)</td>
   <td></td>
  </tr>
 </tbody>
 </table> 
    
**Tipp:** Sie können die Version des {{site.data.keyword.containershort_notm}}-Plug-ins abrufen, indem Sie den folgenden Befehl ausführen. 

```
bx plugin list
```
{: pre}

## 'bx cs'-Befehle
{: #cs_commands}

### bx cs cluster-config CLUSTER [--admin]
{: #cs_cluster_config}

Nach erfolgter Anmeldung das Herunterladen von Kubernetes-Konfigurationsdaten und -Zertifikaten, um eine Verbindung zum Cluster herzustellen und `kubectl`-Befehle auszuführen. Die Dateien werden in `ausgangsverzeichnis_des_benutzers/.bluemix/plugins/container-service/clusters/<clustername>` heruntergeladen. 

**Befehlsoptionen**:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>(Erforderlich) Der Name oder die ID des Clusters.</dd>

   <dt><code>--admin</code></dt>
   <dd>(Optional) Laden Sie die Zertifikate und Berechtigungsdateien für die RBAC-Rolle 'Administrator' herunter. Benutzer mit diesen Dateien können Administratoraktionen für den Cluster ausführen, z. B. den Cluster entfernen.</dd>
   </dl>

**Beispiele**:

```
bx cs cluster-config mein_cluster
```
{: pre}



### bx cs cluster-create [--file DATEISTANDORT][--hardware HARDWARE] --location STANDORT --machine-type MASCHINENTYP --name NAME [--no-subnet][--private-vlan PRIVATE_VLAN] [--public-vlan ÖFFENTLICHES_VLAN][--workers WORKER]
{: #cs_cluster_create}

Erstellung eines Clusters in Ihrer Organisation.

<strong>Befehlsoptionen</strong>

<dl>
<dt><code>--file <em>DATEISTANDORT</em></code></dt>

<dd>(Optional für Standardcluster. Nicht verfügbar für Lite-Cluster.) Der Pfad zur YAML-Datei für die Erstellung Ihres Standardclusters. Statt die Merkmale Ihres Clusters mithilfe der in diesem Befehl bereitgestellten Optionen zu definieren, können Sie eine YAML-Datei verwenden.

<p><strong>Hinweis:</strong> Wenn Sie dieselbe Option wie im Befehl als Parameter in der YAML-Datei bereitstellen, hat der Wert im Befehl Vorrang vor dem Wert in der YAML. Beispiel: Sie definieren eine Position in Ihrer YAML-Datei und verwenden die Option <code>--location</code> im Befehl. Der Wert, den Sie in die Befehlsoption eingegeben haben, überschreibt den Wert in der YAML-Datei. <pre class="codeblock">
<code>name: <em>&lt;clustername&gt;</em>
location: <em>&lt;standort&gt;</em>
machine-type: <em>&lt;maschinentyp&gt;</em>
private-vlan: <em>&lt;privates_vlan&gt;</em>
public-vlan: <em>&lt;öffentliches_vlan&gt;</em>
hardware: <em>&lt;shared_oder_dedicated&gt;</em>
workerNum: <em>&lt;anzahl_worker&gt;</em></code></pre>


<table>
    <caption>Tabelle 1. Erklärung der Komponenten der YAML-Datei</caption>
    <thead>
    <th colspan=2><img src="images/idea.png"/> Erklärung der Komponenten der YAML-Datei</th>
    </thead>
    <tbody>
    <tr>
    <td><code><em>name</em></code></td>
    <td>Ersetzen Sie <code><em>&lt;clustername&gt;</em></code> durch den Namen Ihres Clusters. </td> 
    </tr>
    <tr>
    <td><code><em>location</em></code></td>
    <td>Ersetzen Sie <code><em>&lt;standort&gt;</em></code> durch den Standort, an dem Sie Ihren Cluster erstellen möchten. Welche Standorte verfügbar sind, hängt von der Region ab, bei der Sie angemeldet sind. Führen Sie den Befehl <code>bx cs locations</code> aus, um die verfügbaren Standorte aufzulisten. </td> 
     </tr>
     <tr>
     <td><code><em>machine-type</em></code></td>
     <td>Ersetzen Sie <code><em>&lt;maschinentyp&gt;</em></code> durch den Maschinentyp, den Sie für Ihre Workerknoten verwenden möchten. Führen Sie <code>bx cs machine-types
<em>&lt;standort&gt;</em></code> aus, um verfügbare Maschinentypen für Ihren Standort aufzulisten. </td> 
     </tr>
     <tr>
     <td><code><em>private-vlan</em></code></td>
     <td>Ersetzen Sie <code><em>&lt;privates_vlan&gt;</em></code> durch die ID des privaten VLANs, das Sie für Ihre Workerknoten verwenden möchten. Führen Sie <code>bx cs vlans <em>&lt;standort&gt;</em></code> aus und suchen Sie nach VLAN-Routern, die mit <code>bcr</code> (Back-End-Router) beginnen, um verfügbare VLANs aufzulisten. </td> 
     </tr>
     <tr>
     <td><code><em>public-vlan</em></code></td>
     <td>Ersetzen Sie <code><em>&lt;öffentliches_vlan&gt;</em></code> durch die ID des öffentlichen VLANs, das Sie für Ihre Workerknoten verwenden möchten. Führen Sie <code>bx cs vlans <em>&lt;standort&gt;</em></code> aus und suchen Sie nach VLAN-Routern, die mit <code>fcr</code> (Front-End-Router) beginnen, um verfügbare VLANs aufzulisten. </td> 
     </tr>
     <tr>
     <td><code><em>hardware</em></code></td>
     <td>Der Grad an Hardware-Isolation für Ihren Workerknoten. Verwenden Sie 'dedicated', wenn
Sie verfügbare physische Ressourcen haben möchten, die nur Sie nutzen können, oder 'shared', um zuzulassen, dass
physische Ressourcen mit anderen IBM Kunden gemeinsam genutzt werden können. Die Standardeinstellung ist
<code>shared</code>.</td> 
     </tr>
     <tr>
     <td><code><em>workerNum</em></code></td>
     <td>Ersetzen Sie <code><em>&lt;anzahl_worker&gt;</em></code> durch die Anzahl von Workerknoten, die Sie implementieren wollen. </td> 
     </tr>
     </tbody></table>
    </p></dd>
    
<dt><code>--hardware <em>HARDWARE</em></code></dt>
<dd>(Optional für Standardcluster. Nicht verfügbar für Lite-Cluster.) Der Grad an Hardware-Isolation für Ihren Workerknoten. Verwenden Sie 'dedicated', wenn
Sie verfügbare physische Ressourcen haben möchten, die nur Sie nutzen können, oder 'shared', um zuzulassen, dass
physische Ressourcen mit anderen IBM Kunden gemeinsam genutzt werden können. Die Standardeinstellung ist
'shared'. </dd>

<dt><code>--location <em>STANDORT</em></code></dt>
<dd>(Erforderlich für Standardcluster. Optional für Lite-Cluster.) Der Standort, an dem Sie den Cluster erstellen möchten. Welche Standorte Ihnen zur Verfügung stehen, hängt von der {{site.data.keyword.Bluemix_notm}}-Region ab, bei der Sie angemeldet sind. Wählen Sie die Region aus,
die Ihrem Standort am nächsten ist, um eine optimale Leistung zu erhalten.

<p>Verfügbare Standorte sind:<ul><li>Vereinigte Staaten (Süden)<ul><li>dal10 [Dallas]</li><li>dal12 [Dallas]</li></ul></li><li>Großbritannien (Süden)<ul><li>lon02 [London]</li><li>lon04 [London]</li></ul></li><li>Zentraleuropa<ul><li>ams03 [Amsterdam]</li><li>ra02 [Frankfurt]</li></ul></li><li>Asiatisch-pazifischer Raum (Süden)<ul><li>syd01 [Sydney]</li><li>syd04 [Sydney]</li></ul></li></ul>
</p>

<p><strong>Hinweis:</strong> Beachten Sie bei der Auswahl eines Standorts außerhalb Ihres Landes, dass Sie gegebenenfalls eine gesetzliche Genehmigung benötigen, bevor Daten physisch in einem anderen Land gespeichert werden können. </p>
</dd>

<dt><code>--machine-type <em>MASCHINENTYP</em></code></dt>
<dd>(Erforderlich für Standardcluster. Nicht verfügbar für Lite-Cluster.) Der Maschinentyp, den Sie auswählen,
wirkt sich auf die Menge an Hauptspeicher und Plattenspeicher aus, die den in Ihrem Workerknoten
bereitgestellten Containern zur Verfügung steht. Führen Sie [bx cs machine-types <em>STANDORT</em>](cs_cli_reference.html#cs_machine_types) aus, um verfügbare Maschinentypen aufzulisten. </dd>

<dt><code>--name <em>NAME</em></code></dt>
<dd>(Erforderlich) Der Name für den Cluster.</dd>

<dt><code>--no-subnet</code></dt>
<dd>Schließen Sie das Flag ein, um einen Cluster ohne portierbares Teilnetz zu erstellen. Standardmäßig wird das Flag nicht verwendet und ein Teilnetz im Portfolio von {{site.data.keyword.BluSoftlayer_full}} erstellt.</dd>

<dt><code>--private-vlan <em>PRIVATES_VLAN</em></code></dt>
<dd>(Nicht verfügbar für Lite-Cluster.)
<ul>
<li>Wenn dieser Cluster der erste Cluster ist, den Sie
an diesem Standort erstellen, schließen Sie diesen Flag nicht ein. Ein privates VLAN wird zusammen mit den Clustern für Sie erstellt.</li>
<li>Wenn Sie bereits einen Cluster an diesem Standort oder ein privates VLAN in {{site.data.keyword.BluSoftlayer_notm}} erstellt haben, müssen Sie dieses private
VLAN angeben.

<p><strong>Hinweis:</strong> Die öffentlichen und privaten VLANs, die Sie mit dem 'create'-Befehl angeben, müssen übereinstimmen. Private VLAN-Router beginnen immer mit
<code>bcr</code> (Back-End-Router) und öffentliche VLAN-Router immer mit
<code>fcr</code> (Front-End-Router). Die Zahlen- und Buchstabenkombination nach diesen Präfixen muss übereinstimmen, damit diese VLANs beim Erstellen eines Clusters verwendet werden können. Verwenden Sie keine abweichenden öffentlichen und privaten VLANs, um ein Cluster zu erstellen.</p></li>
</ul>

<p>Führen Sie <code>bx cs vlans <em>&lt;standort&gt;</em></code> aus, um herauszufinden, ob Sie bereits über ein privates VLAN für einen bestimmten Standort verfügen, oder um den Namen eines vorhandenen
privaten VLANs zu erfahren. </p></dd>

<dt><code>--public-vlan <em>ÖFFENTLICHES_VLAN</em></code></dt>
<dd>(Nicht verfügbar für Lite-Cluster.)
<ul>
<li>Wenn dieser Cluster der erste Cluster ist, den Sie
an diesem Standort erstellen, verwenden Sie diesen Flag nicht. Ein öffentliches VLAN wird zusammen mit dem Cluster für Sie erstellt.</li>
<li>Wenn Sie bereits einen Cluster an diesem Standort oder ein öffentliches VLAN in {{site.data.keyword.BluSoftlayer_notm}} erstellt haben, müssen Sie dieses öffentliche VLAN angeben.

<p><strong>Hinweis:</strong> Die öffentlichen und privaten VLANs, die Sie mit dem 'create'-Befehl angeben, müssen übereinstimmen. Private VLAN-Router beginnen immer mit
<code>bcr</code> (Back-End-Router) und öffentliche VLAN-Router immer mit
<code>fcr</code> (Front-End-Router). Die Zahlen- und Buchstabenkombination nach diesen Präfixen muss übereinstimmen, damit diese VLANs beim Erstellen eines Clusters verwendet werden können. Verwenden Sie keine abweichenden öffentlichen und privaten VLANs, um ein Cluster zu erstellen.</p></li>
</ul>

<p>Führen Sie <code>bx cs vlans <em>&lt;standort&gt;</em></code> aus, um herauszufinden, ob Sie bereits über ein öffentliches VLAN für einen bestimmten Standort verfügen, oder um den Namen eines vorhandenen
öffentlichen VLANs zu erfahren. </p></dd>

<dt><code>--workers WORKER</code></dt>
<dd>(Optional für Standardcluster. Nicht verfügbar für Lite-Cluster.) Die Anzahl von Workerknoten, die Sie in Ihrem Cluster bereitstellen wollen. Wenn Sie diese Option nicht angeben, wird ein Cluster mit einem Workerknoten erstellt.

<p><strong>Hinweis:</strong> Jedem Workerknoten werden eine eindeutige Workerknoten-ID und ein Domänenname zugeordnet, die nach dem Erstellen des Clusters nicht manuell geändert
werden dürfen. Wenn die ID oder der Domänenname geändert wird, kann der Kubernetes-Master Ihren Cluster nicht mehr verwalten.</p></dd>
</dl>

**Beispiele**:

  
  
  Beispiel eines Standardclusters:
  {: #example_cluster_create}

  ```
  bx cs cluster-create --location dal10 --public-vlan meine_ID_für_öffentliches_VLAN --private-vlan meine_ID_für_privates_VLAN --machine-type u1c.2x4 --name mein_cluster --hardware gemeinsam genutzt --workers 2
  ```
  {: pre}

  Beispiel eines Lite-Clusters:

  ```
  bx cs cluster-create --name mein_cluster
  ```
  {: pre}

  Beispiel einer {{site.data.keyword.Bluemix_notm}} Dedicated-Umgebung:

  ```
  bx cs cluster-create --machine-type maschinentyp --workers anzahl --name clustername
  ```
  {: pre}


### bx cs cluster-get CLUSTER
{: #cs_cluster_get}

Anzeigen von Informationen zu einem Cluster in Ihrer Organisation.

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>(Erforderlich) Der Name oder die ID des Clusters.</dd>
   </dl>

**Beispiele**:

  ```
  bx cs cluster-get mein_cluster
  ```
  {: pre}


### bx cs cluster-rm [-f] CLUSTER
{: #cs_cluster_rm}

Entfernen eines Clusters aus der Organisation.

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>(Erforderlich) Der Name oder die ID des Clusters.</dd>

   <dt><code>-f</code></dt>
   <dd>(Optional) Geben Sie diese Option an, um das Entfernen eines Clusters ohne Benutzereingabeaufforderungen zu erzwingen.</dd>
   </dl>

**Beispiele**:

  ```
  bx cs cluster-rm mein_cluster
  ```
  {: pre}


### bx cs cluster-service-bind CLUSTER KUBERNETES-NAMENSBEREICH GUID_DER_SERVICEINSTANZ
{: #cs_cluster_service_bind}

Hinzufügen eines {{site.data.keyword.Bluemix_notm}}-Service zu einem Cluster.

**Tipp:** Für {{site.data.keyword.Bluemix_notm}} Dedicated-Benutzer finden Sie weitere Informationen unter [{{site.data.keyword.Bluemix_notm}}-Services zu Clustern in {{site.data.keyword.Bluemix_notm}} Dedicated (Closed Beta) hinzufügen](cs_cluster.html#binding_dedicated). 

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>(Erforderlich) Der Name oder die ID des Clusters.</dd>

   <dt><code><em>KUBERNETES-NAMENSBEREICH</em></code></dt>
   <dd>(Erforderlich) Der Name des Kubernetes-Namensbereichs.</dd>

   <dt><code><em>GUID_DER_SERVICEINSTANZ</em></code></dt>
   <dd>(Erforderlich) Die ID der {{site.data.keyword.Bluemix_notm}}-Serviceinstanz, die Sie binden möchten.</dd>
   </dl>

**Beispiele**:

  ```
  bx cs cluster-service-bind mein_cluster mein_namensbereich GUID_meiner_serviceinstanz
  ```
  {: pre}


### bx cs cluster-service-unbind CLUSTER KUBERNETES-NAMENSBEREICH GUID_DER_SERVICEINSTANZ
{: #cs_cluster_service_unbind}

Entfernen eines {{site.data.keyword.Bluemix_notm}}-Service aus einem Cluster.

**Hinweis:** Wenn Sie einen {{site.data.keyword.Bluemix_notm}}-Service entfernen, werden die Serviceberechtigungsnachweise aus dem Cluster entfernt. Wenn ein Pod den Service noch verwendet,
schlägt er fehl, weil die Serviceberechtigungsnachweise nicht gefunden werden können.

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>(Erforderlich) Der Name oder die ID des Clusters.</dd>

   <dt><code><em>KUBERNETES-NAMENSBEREICH</em></code></dt>
   <dd>(Erforderlich) Der Name des Kubernetes-Namensbereichs.</dd>

   <dt><code><em>GUID_DER_SERVICEINSTANZ</em></code></dt>
   <dd>(Erforderlich) Die ID der {{site.data.keyword.Bluemix_notm}}-Serviceinstanz, die Sie entfernen möchten.</dd>
   </dl>

**Beispiele**:

  ```
  bx cs cluster-service-unbind mein_cluster mein_namensbereich GUID_meiner_serviceinstanz
  ```
  {: pre}


### bx cs cluster-services CLUSTER [--namespace KUBERNETES-NAMENSBEREICH][--all-namespaces]
{: #cs_cluster_services}

Auflisten der Services, die an einen oder an alle Kubernetes-Namensbereiche in einem Cluster gebunden sind. Sind keine Optionen angegeben, werden die Services für den Standardnamensbereich angezeigt.

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>(Erforderlich) Der Name oder die ID des Clusters.</dd>

   <dt><code>--namespace <em>KUBERNETES-NAMENSBEREICH</em></code>, <code>-n
<em>KUBERNETES-NAMENSBEREICH</em></code></dt>
   <dd>(Optional) Schließen Sie die Services ein, die an einen bestimmten Namensbereich in einem Cluster gebunden sind.</dd>

   <dt><code>--all-namespaces</code></dt>
    <dd>(Optional) Schließen Sie die Services ein, die an alle Namensbereiche in einem Cluster gebunden sind.</dd>
    </dl>

**Beispiele**:

  ```
  bx cs cluster-services mein_cluster --namespace mein_namensbereich
  ```
  {: pre}


### bx cs cluster-subnet-add CLUSTER TEILNETZ
{: #cs_cluster_subnet_add}

Zurverfügungstellung eines Teilnetzes in einem {{site.data.keyword.BluSoftlayer_notm}}-Konto für einen angegebenen Cluster.

**Hinweis:** Wenn Sie ein Teilnetz in einem Cluster verfügbar machen, werden IP-Adressen dieses Teilnetzes zum Zweck von Clusternetzen verwendet. Vermeiden Sie IP-Adresskonflikte, indem Sie ein Teilnetz mit nur einem Cluster verwenden. Verwenden Sie kein Teilnetz für mehrere Cluster oder für andere
Zwecke außerhalb von {{site.data.keyword.containershort_notm}} gleichzeitig.

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>(Erforderlich) Der Name oder die ID des Clusters.</dd>

   <dt><code><em>TEILNETZ</em></code></dt>
   <dd>(Erforderlich) Die ID des Teilnetzes.</dd>
   </dl>

**Beispiele**:

  ```
  bx cs cluster-subnet-add mein_cluster subnet
  ```
  {: pre}

### bx cs clusters
{: #cs_clusters}

Anzeigen einer List der Cluster in Ihrer Organisation.

<strong>Befehlsoptionen</strong>:

  Keine

**Beispiele**:

  ```
  bx cs clusters
  ```
  {: pre}


### bx cs credentials-set --infrastructure-api-key API-SCHLÜSSEL --infrastructure-username BENUTZERNAME
{: #cs_credentials_set}

Festlegen von {{site.data.keyword.BluSoftlayer_notm}}-Kontoberechtigungsnachweisen für
Ihr {{site.data.keyword.Bluemix_notm}}-Konto. Mit diesen Berechtigungsnachweisen können
Sie über Ihr {{site.data.keyword.Bluemix_notm}}-Konto auf das {{site.data.keyword.BluSoftlayer_notm}}-Portfolio zugreifen.

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code>--infrastructure-username <em>BENUTZERNAME</em></code></dt>
   <dd>(Erforderlich) Der Benutzername für ein {{site.data.keyword.BluSoftlayer_notm}}-Konto.</dd>
   </dl>

   <dt><code>--infrastructure-api-key <em>API-SCHLÜSSEL</em></code></dt>
   <dd>(Erforderlich) Der API-Schlüssel für ein {{site.data.keyword.BluSoftlayer_notm}}-Konto.
   
 <p>
  Gehen Sie wie folgt vor, um einen API-Schlüssel zu generieren:
    
  <ol>
  <li>Melden Sie sich beim [{{site.data.keyword.BluSoftlayer_notm}}-Portal ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://control.softlayer.com/) an. </li>
  <li>Wählen Sie <strong>Konto</strong> und dann <strong>Benutzer</strong> aus.</li>
  <li>Klicken Sie auf <strong>Generieren</strong>, um einen {{site.data.keyword.BluSoftlayer_notm}}-API-Schlüssel
für Ihr Konto zu generieren.</li>
  <li>Kopieren Sie den API-Schlüssel, um diesen Befehl verwenden zu können.</li>
  </ol>

  Gehen Sie wie folgt vor, um Ihren API-Schlüssel anzuzeigen:
  <ol>
  <li>Melden Sie sich beim [{{site.data.keyword.BluSoftlayer_notm}}-Portal ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://control.softlayer.com/) an. </li>
  <li>Wählen Sie <strong>Konto</strong> und dann <strong>Benutzer</strong> aus.</li>
  <li>Klicken Sie auf <strong>Anzeigen</strong>, um den bestehenden API-Schlüssel anzuzeigen.</li>
  <li>Kopieren Sie den API-Schlüssel, um diesen Befehl verwenden zu können.</li>
  </ol></p></dd>
    
**Beispiele**:

  ```
bx cs credentials-set --infrastructure-api-key API-SCHLÜSSEL --infrastructure-username BENUTZERNAME
```
  {: pre}


### bx cs credentials-unset
{: #cs_credentials_unset}

Entfernen von {{site.data.keyword.BluSoftlayer_notm}}-Kontoberechtigungsnachweisen aus
Ihrem {{site.data.keyword.Bluemix_notm}}-Konto. Nachdem Sie die Berechtigungsnachweise entfernt haben, können Sie über Ihr {{site.data.keyword.Bluemix_notm}}-Konto nicht mehr auf das {{site.data.keyword.BluSoftlayer_notm}}-Portfolio zugreifen.

<strong>Befehlsoptionen</strong>:

   Keine

**Beispiele**:

  ```
  bx cs credentials-unset
  ```
  {: pre}


### bx cs locations
{: #cs_datacenters}

Anzeigen einer Liste von verfügbaren Standorten, in denen Sie ein Cluster erstellen können.

<strong>Befehlsoptionen</strong>:

   Keine

**Beispiele**:

  ```
  bx cs locations
  ```
  {: pre}


### bx cs help
{: #cs_help}

Anzeigen einer Liste der unterstützten Befehle und Parameter.

<strong>Befehlsoptionen</strong>:

   Keine

**Beispiele**:

  ```
  bx cs help
  ```
  {: pre}


### bx cs init [--host HOST]
{: #cs_init}

Initialisieren des {{site.data.keyword.containershort_notm}}-Plug-ins oder Angeben der Region, in der Sie Kubernetes-Cluster erstellen oder darauf zugreifen möchten. 

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code>--host <em>HOST</em></code></dt>
   <dd>(Optional) Der {{site.data.keyword.containershort_notm}}-API-Endpunkt, den Sie verwenden möchten. Beispiel:

    <ul>
    <li>Vereinigte Staaten (Süden):

    <pre class="codeblock">
    <code>bx cs init --host https://us-south.containers.bluemix.net</code>
    </pre></li>

    <li>Großbritannien (Süden):

    <pre class="codeblock">
    <code>bx cs init --host https://uk-south.containers.bluemix.net</code>
    </pre></li>

    <li>Zentraleuropa:

    <pre class="codeblock">
    <code>bx cs init --host https://eu-central.containers.bluemix.net</code>
    </pre></li>

    <li>Asiatisch-pazifischer Raum (Süden):

    <pre class="codeblock">
    <code>bx cs init --host https://ap-south.containers.bluemix.net</code>
    </pre></li></ul>
</dd>
</dl>


### bx cs machine-types STANDORT 
{: #cs_machine_types}

Anzeige einer Liste der für Ihre Workerknoten verfügbaren Maschinentypen. Jeder Maschinentyp enthält die Menge an virtueller CPU, an Hauptspeicher und an Plattenspeicher für jeden Workerknoten im Cluster.

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><em>STANDORT</em></dt>
   <dd>(Erforderlich) Geben Sie den Standort ein, an dem Sie verfügbare Maschinentypen auflisten möchten. Verfügbare Standorte sind: <ul><li>Vereinigte Staaten (Süden)<ul><li>dal10 [Dallas]</li><li>dal12 [Dallas]</li></ul></li><li>Großbritannien (Süden)<ul><li>lon02 [London]</li><li>lon04 [London]</li></ul></li><li>Zentraleuropa<ul><li>ams03 [Amsterdam]</li><li>ra02 [Frankfurt]</li></ul></li><li>Asiatisch-pazifischer Raum (Süden)<ul><li>syd01 [Sydney]</li><li>syd04 [Sydney]</li></ul></li></ul></dd></dl>
   
**Beispiele**:

  ```
  bx cs machine-types STANDORT
  ```
  {: pre}


### bx cs subnets
{: #cs_subnets}

Anzeigen einer Liste der Teilnetze, die in einem {{site.data.keyword.BluSoftlayer_notm}}-Konto verfügbar sind.

<strong>Befehlsoptionen</strong>:

   Keine

**Beispiele**:

  ```
  bx cs subnets
  ```
  {: pre}


### bx cs vlans STANDORT
{: #cs_vlans}

Auflisten der öffentlichen und der privaten VLANs, die für
einen Standort in Ihrem {{site.data.keyword.BluSoftlayer_notm}}-Konto zur Verfügung stehen. Um verfügbare VLANs auflisten zu können, müssen Sie über ein gebührenpflichtiges Konto verfügen.

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt>STANDORT</dt>
   <dd>(Erforderlich) Geben Sie den Standort ein, an dem Sie Ihre privaten und öffentlichen VLANs auflisten möchten. Verfügbare Standorte sind: <ul><li>Vereinigte Staaten (Süden)<ul><li>dal10 [Dallas]</li><li>dal12 [Dallas]</li></ul></li><li>Großbritannien (Süden)<ul><li>lon02 [London]</li><li>lon04 [London]</li></ul></li><li>Zentraleuropa<ul><li>ams03 [Amsterdam]</li><li>ra02 [Frankfurt]</li></ul></li><li>Asiatisch-pazifischer Raum (Süden)<ul><li>syd01 [Sydney]</li><li>syd04 [Sydney]</li></ul></li></ul></dd>
   </dl>
   
**Beispiele**:

  ```
  bx cs vlans dal10
  ```
  {: pre}


### bx cs webhook-create --cluster CLUSTER --level STUFE --type slack --URL URL
{: #cs_webhook_create}

Erstellen von Webhooks.

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>(Erforderlich) Der Name oder die ID des Clusters.</dd>

   <dt><code>--level <em>STUFE</em></code></dt>
   <dd>(Optional) Die Benachrichtigungsstufe wie etwa <code>Normal</code> oder <code>Warnung</code>. <code>Warnung</code> ist der Standardwert.</dd>

   <dt><code>--type <em>slack</em></code></dt>
   <dd>(Erforderlich) Der Typ von Webhook, z. B. 'slack'. Es wird nur 'slack' unterstützt. </dd>

   <dt><code>--URL <em>URL</em></code></dt>
   <dd>(Erforderlich) Die URL für den Webhook.</dd>
   </dl>

**Beispiele**:

  ```
  bx cs webhook-create --cluster mein_cluster --level Normal --type slack --URL http://github.com/<mein_webhook>
  ```
  {: pre}


### bx cs worker-add --cluster CLUSTER [--file DATEISTANDORT][--hardware HARDWARE] --machine-type MASCHINENTYP --number ANZAHL --private-vlan PRIVATES_VLAN --public-vlan ÖFFENTLICHES_VLAN
{: #cs_worker_add}

Fügen Sie Ihrem Standardcluster Workerknoten hinzu.

<strong>Befehlsoptionen</strong>:

<dl>
<dt><code>--cluster <em>CLUSTER</em></code></dt>
<dd>(Erforderlich) Der Name oder die ID des Clusters.</dd>

<dt><code>--file <em>DATEISTANDORT</em></code></dt>
<dd>Der Pfad zur YAML-Datei für das Hinzufügen von Workerknoten zu Ihrem Cluster. Statt Ihre zusätzlichen Workerknoten mithilfe der in diesem Befehl bereitgestellten Optionen zu definieren, können Sie eine YAML-Datei verwenden.

<p><strong>Hinweis:</strong> Wenn Sie dieselbe Option wie im Befehl als Parameter in der YAML-Datei bereitstellen, hat der Wert im Befehl Vorrang vor dem Wert in der YAML. Beispiel: Sie definieren einen Maschinentyp in Ihrer YAML-Datei und verwenden die Option '--machine-type' im Befehl. Der Wert, den Sie in der Befehlsoption eingegeben haben, überschreibt den Wert in der YAML-Datei.

      <pre class="codeblock">
<code>name: <em>&lt;clustername_oder_-id&gt;</em>
location: <em>&lt;standort&gt;</em>
machine-type: <em>&lt;maschinentyp&gt;</em>
private-vlan: <em>&lt;privates_vlan&gt;</em>
public-vlan: <em>&lt;öffentliches_vlan&gt;</em>
hardware: <em>&lt;shared_oder_dedicated&gt;</em>
workerNum: <em>&lt;anzahl_worker&gt;</em></code></pre>
        
<table>
<caption>Tabelle 2. Erklärung der Komponenten der YAML-Datei</caption>
<thead>
<th colspan=2><img src="images/idea.png"/> Erklärung der Komponenten der YAML-Datei</th>
</thead>
<tbody>
<tr>
<td><code><em>name</em></code></td>
<td>Ersetzen Sie <code><em>&lt;clustername_oder_-id&gt;</em></code> durch den Namen oder die ID des Clusters, in dem Sie Workerknoten hinzufügen möchten.</td> 
</tr>
<tr>
<td><code><em>location</em></code></td>
<td>Ersetzen Sie <code><em>&lt;standort&gt;</em></code> durch den Standort, an dem Sie Ihre Workerknoten bereitstellen möchten. Welche Standorte verfügbar sind, hängt von der Region ab, bei der Sie angemeldet sind. Führen Sie den Befehl <code>bx cs locations</code> aus, um die verfügbaren Standorte aufzulisten. </td> 
</tr>
<tr>
<td><code><em>machine-type</em></code></td>
<td>Ersetzen Sie <code><em>&lt;maschinentyp&gt;</em></code> durch den Maschinentyp, den Sie für Ihre Workerknoten verwenden möchten. Führen Sie <code>bx cs machine-types
<em>&lt;standort&gt;</em></code> aus, um verfügbare Maschinentypen für Ihren Standort aufzulisten. </td> 
</tr>
<tr>
<td><code><em>private-vlan</em></code></td>
<td>Ersetzen Sie <code><em>&lt;privates_vlan&gt;</em></code> durch die ID des privaten VLANs, das Sie für Ihre Workerknoten verwenden möchten. Führen Sie <code>bx cs vlans <em>&lt;standort&gt;</em></code> aus und suchen Sie nach VLAN-Routern, die mit <code>bcr</code> (Back-End-Router) beginnen, um verfügbare VLANs aufzulisten. </td> 
</tr>
<tr>
<td><code>public-vlan</code></td>
<td>Ersetzen Sie <code>&lt;öffentliches_vlan&gt;</code> durch die ID des öffentlichen VLANs, das Sie für Ihre Workerknoten verwenden möchten. Führen Sie <code>bx cs vlans &lt;standort&gt;</code> aus und suchen Sie nach VLAN-Routern, die mit <code>fcr</code> (Front-End-Router) beginnen, um verfügbare VLANs aufzulisten. </td> 
</tr>
<tr>
<td><code>hardware</code></td>
<td>Der Grad an Hardware-Isolation für Ihren Workerknoten. Verwenden Sie 'dedicated', wenn
Sie verfügbare physische Ressourcen haben möchten, die nur Sie nutzen können, oder 'shared', um zuzulassen, dass
physische Ressourcen mit anderen IBM Kunden gemeinsam genutzt werden können. Die Standardeinstellung ist
'shared'. </td> 
</tr>
<tr>
<td><code>workerNum</code></td>
<td>Ersetzen Sie <code><em>&lt;anzahl_worker&gt;</em></code> durch die Anzahl von Workerknoten, die Sie implementieren wollen. </td> 
</tr>
</tbody></table></p></dd>

<dt><code>--hardware <em>HARDWARE</em></code></dt>
<dd>(Optional) Der Grad an Hardware-Isolation für Ihren Workerknoten. Verwenden Sie 'dedicated', wenn
Sie verfügbare physische Ressourcen haben möchten, die nur Sie nutzen können, oder 'shared', um zuzulassen, dass
physische Ressourcen mit anderen IBM Kunden gemeinsam genutzt werden können. Die Standardeinstellung ist
'shared'. </dd>

<dt><code>--machine-type <em>MASCHINENTYP</em></code></dt>
<dd>(Erforderlich) Der Maschinentyp, den Sie auswählen,
wirkt sich auf die Menge an Hauptspeicher und Plattenspeicher aus, die den in Ihrem Workerknoten
bereitgestellten Containern zur Verfügung steht. Führen Sie [bx cs machine-types STANDORT](cs_cli_reference.html#cs_machine_types) aus, um verfügbare Maschinentypen aufzulisten. </dd>

<dt><code>--number <em>ANZAHL</em></code></dt>
<dd>(Erforderlich) Die durch eine Ganzzahl angegebene Anzahl der Workerknoten, die im Cluster erstellt werden sollen.</dd>

<dt><code>--private-vlan <em>PRIVATES_VLAN</em></code></dt>
<dd>(Erforderlich) Wenn Sie über ein privates VLAN verfügen, um es
an dem Standort zu verwenden,
müssen Sie das VLAN angeben. Wenn dieser Cluster der erste Cluster ist, den Sie
an diesem Standort erstellen, verwenden Sie diesen Flag nicht. Ein privates VLAN wird für Sie erstellt.

<p><strong>Hinweis:</strong> Die öffentlichen und privaten VLANs, die Sie mit dem 'create'-Befehl angeben, müssen übereinstimmen. Private VLAN-Router beginnen immer mit
<code>bcr</code> (Back-End-Router) und öffentliche VLAN-Router immer mit
<code>fcr</code> (Front-End-Router). Die Zahlen- und Buchstabenkombination nach diesen Präfixen muss übereinstimmen, damit diese VLANs beim Erstellen eines Clusters verwendet werden können. Verwenden Sie keine abweichenden öffentlichen und privaten VLANs, um ein Cluster zu erstellen.</p></dd>

<dt><code>--public-vlan <em>ÖFFENTLICHES_VLAN</em></code></dt>
<dd>(Erforderlich) Wenn Sie über ein öffentliches VLAN verfügen, um es
an dem Standort zu verwenden,
müssen Sie das VLAN angeben. Wenn dieser Cluster der erste Cluster ist, den Sie
an diesem Standort erstellen, verwenden Sie diesen Flag nicht. Ein öffentliches VLAN wird für Sie erstellt.

<p><strong>Hinweis:</strong> Die öffentlichen und privaten VLANs, die Sie mit dem 'create'-Befehl angeben, müssen übereinstimmen. Private VLAN-Router beginnen immer mit
<code>bcr</code> (Back-End-Router) und öffentliche VLAN-Router immer mit
<code>fcr</code> (Front-End-Router). Die Zahlen- und Buchstabenkombination nach diesen Präfixen muss übereinstimmen, damit diese VLANs beim Erstellen eines Clusters verwendet werden können. Verwenden Sie keine abweichenden öffentlichen und privaten VLANs, um ein Cluster zu erstellen.</p></dd>
</dl>

**Beispiele**:

  ```
  bx cs worker-add --cluster mein_cluster --number 3 --public-vlan meine_ID_für_öffentliches_VLAN --private-vlan meine_ID_für_privates_VLAN --machine-type u1c.2x4 --hardware shared
  ```
  {: pre}

  Beispiel für {{site.data.keyword.Bluemix_notm}} Dedicated:

  ```
  bx cs worker-add --cluster mein_cluster --number 3 --maschinentyp u1c.2x4
  ```
  {: pre}


### bx cs worker-get WORKERKNOTEN-ID
{: #cs_worker_get}

Anzeigen der Details eines Workerknotens.

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><em>WORKERKNOTEN-ID</em></dt>
   <dd>Die ID für einen Workerknoten. Führen Sie den Befehl <code>bx cs workers <em>CLUSTER</em></code> aus, um die IDs für die Workerknoten in einem Cluster anzuzeigen. </dd>
   </dl>

**Beispiele**:

  ```
  bx cs worker-get WORKERKNOTEN-ID
  ```
  {: pre}


### bx cs worker-reboot [-f][--hard] CLUSTER WORKER [WORKER]
{: #cs_worker_reboot}

Erneutes Starten (Warmstart) der Workerknoten in einem Cluster. Wenn bei einem Workerknoten ein Problem auftritt, versuchen Sie zuerst, für diesen Workerknoten einen Warmstart durchzuführen. Dadurch wird der Knoten neu gestartet. Sollte das Problem auch nach dem Warmstart weiterhin bestehen, führen Sie den Befehl `worker-reload` aus. Der Zustand der Workerknoten ändert sich während des Warmstarts nicht. Der Zustand lautet weiterhin `Deployed` (Bereitgestellt), doch der Status wird aktualisiert.

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>(Erforderlich) Der Name oder die ID des Clusters.</dd>

   <dt><code>-f</code></dt>
   <dd>(Optional) Geben Sie diese Option an, um den Neustart des Workerknotens ohne Benutzereingabeaufforderungen zu erzwingen.</dd>

   <dt><code>--hard</code></dt>
   <dd>(Optional) Geben Sie diese Option an, um einen plötzlichen Neustart eines Workerknotens zu erzwingen, indem Sie die Stromversorgung zum Workerknoten kappen. Verwenden Sie diese Option, wenn der Workerknoten nicht antwortet oder Docker blockiert ist.</dd>

   <dt><code><em>WORKERKNOTEN</em></code></dt>
   <dd>(Erforderlich) Der Name oder die ID eines oder mehrerer Workerknoten. Trennen Sie bei einer Auflistung mehrerer Workerknoten die einzelnen Auflistungselemente jeweils durch ein Leerzeichen.</dd>
   </dl>

**Beispiele**:

  ```
  bx cs worker-reboot mein_cluster mein_knoten1 mein_knoten2
  ```
  {: pre}


### bx cs worker-reload [-f] CLUSTER WORKER [WORKER]
{: #cs_worker_reload}

Erneutes Laden der Workerknoten in einem Cluster. Wenn bei einem Workerknoten ein Problem auftritt, versuchen Sie zuerst, für diesen Workerknoten einen Warmstart durchzuführen. Sollte das Problem auch nach dem Warmstart weiterhin bestehen, führen Sie den Befehl `worker-reload` aus. Dieser bewirkt, dass alle erforderlichen Konfigurationen für den Workerknoten erneut geladen werden.

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>(Erforderlich) Der Name oder die ID des Clusters.</dd>

   <dt><code>-f</code></dt>
   <dd>(Optional) Geben Sie diese Option ein, um das Neuladen eines Workerknotens ohne Benutzereingabeaufforderungen zu erzwingen.</dd>

   <dt><code><em>WORKERKNOTEN</em></code></dt>
   <dd>(Erforderlich) Der Name oder die ID eines oder mehrerer Workerknoten. Trennen Sie bei einer Auflistung mehrerer Workerknoten die einzelnen Auflistungselemente jeweils durch ein Leerzeichen.</dd>
   </dl>

**Beispiele**:

  ```
  bx cs worker-reload mein_cluster mein_knoten1 mein_knoten2
  ```
  {: pre}

### bx cs worker-rm [-f] CLUSTER WORKER [WORKER]
{: #cs_worker_rm}

Entfernen eines oder mehrerer Workerknoten von einem Cluster.

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>(Erforderlich) Der Name oder die ID des Clusters.</dd>

   <dt><code>-f</code></dt>
   <dd>(Optional) Geben Sie diese Option an, um das Entfernen eines Workerknotens ohne Benutzereingabeaufforderungen zu erzwingen.</dd>

   <dt><code><em>WORKERKNOTEN</em></code></dt>
   <dd>(Erforderlich) Der Name oder die ID eines oder mehrerer Workerknoten. Trennen Sie bei einer Auflistung mehrerer Workerknoten die einzelnen Auflistungselemente jeweils durch ein Leerzeichen.</dd>
   </dl>

**Beispiele**:

  ```
  bx cs worker-rm mein_cluster mein_knoten1 mein_knoten2
  ```
  {: pre}

### bx cs workers CLUSTER
{: #cs_workers}

Anzeigen einer Liste der der Workerknoten und ihres jeweiligen Status in einem Cluster.

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><em>CLUSTER</em></dt>
   <dd>(Erforderlich) Der Name oder die ID des Clusters, in dem Sie verfügbare Workerknoten auflisten.</dd>
   </dl>

**Beispiele**:

  ```
  bx cs workers mein_cluster
  ```
  {: pre}

## Clusterstatus
{: #cs_cluster_states}

Sie können den aktuellen Clusterstatus sehen, indem Sie den Befehl 'bx cs clusters' ausführen und das Feld **State** ausfindig machen. Der Clusterstatus liefert Informationen zur Verfügbarkeit und Kapazität des Clusters sowie zu möglichen Problemen, die aufgetreten sein können.
{:shortdesc}

|Clusterstatus|Grund|
|-------------|------|
|Deploying (Wird bereitgestellt)|Der Kubernetes-Master ist noch nicht vollständig implementiert. Sie können auf Ihren Cluster nicht zugreifen.|
|Pending (Anstehend)|Der Kubernetes-Master ist bereitgestellt. Die Workerknoten werden gerade eingerichtet und sind noch nicht im Cluster verfügbar. Sie können auf den Cluster zugreifen, aber Sie können keine Apps auf dem Cluster bereitstellen. |
|Normal|Alle Workerknoten in einem Cluster sind betriebsbereit. Sie können auf den Cluster zugreifen und Apps auf dem Cluster bereitstellen. |
|Warning (Warnung)|Mindestens ein Workerknoten in dem Cluster ist nicht verfügbar, aber andere Workerknoten sind verfügbar und können die Workload übernehmen. <ol><li>Listen Sie die Workerknoten in Ihrem Cluster auf und notieren Sie sich die ID der Workerknoten mit dem Status <strong>Warning</strong>. <pre class="pre"><code>bx cs workers &lt;clustername_oder_-id&gt;</code></pre><li>Rufen Sie die Details für einen Workerknoten auf. <pre class="pre"><code>bx cs worker-get &lt;worker-id&gt;</code></pre><li>Überprüfen Sie die Felder <strong>State</strong> (Zustand), <strong>Status</strong> und <strong>Details</strong>, um die Fehlerursache für die Inaktivität des Workerknotens herauszufinden. </li><li>Falls Ihr Workerknoten praktisch die Speicher- oder Plattenkapazitätslimits erreicht hat, reduzieren Sie die Arbeitslast auf Ihren Workerknoten oder fügen einen Workerknoten zu Ihrem Cluster hinzu und verbessern Sie so den Lastausgleich. </li></ol>|
|Critical (Kritisch)|Der Kubernetes-Master kann nicht erreicht werden oder alle Workerknoten in dem Cluster sind inaktiv. <ol><li>Listen Sie die Workerknoten in Ihrem Cluster auf. <pre class="pre"><code>bx cs workers &lt;clustername_oder_-id&gt;</code></pre><li>Rufen Sie die Details für die einzelnen Workerknoten ab. <pre class="pre"><code>bx cs worker-get &lt;worker-id&gt;</code></pre></li><li>Überprüfen Sie die Felder <strong>State</strong> (Zustand), <strong>Status</strong> und <strong>Details</strong>, um die Fehlerursache für die Inaktivität des Workerknotens herauszufinden. </li><li>Falls der Zustand des Workerknotens <strong>Provision_failed</strong> (Bereitstellung fehlgeschlagen) lautet, verfügen Sie möglicherweise nicht über die erforderlichen Berechtigungen, um einen Workerknoten aus dem {{site.data.keyword.BluSoftlayer_notm}}-Portfolio bereitzustellen. Informationen zu den erforderlichen Berechtigungen finden Sie unter [Zugriff auf das {{site.data.keyword.BluSoftlayer_notm}}-Portfolio konfigurieren, um Kubernetes-Standardcluster zu erstellen](cs_planning.html#cs_planning_unify_accounts). </li><li>Falls der Zustand des Workerknotens <strong>Critical</strong> (Kritisch) und der Status <strong>Out of disk</strong> (Kein Plattenspeicher) lautet, hat Ihr Workerknoten keine Kapazität mehr. Sie können entweder die Arbeitslast auf Ihrem Workerknoten reduzieren oder einen Workerknoten zu Ihrem Cluster hinzufügen und so den Lastausgleich verbessern. </li><li>Falls der Zustand des Workerknotens <strong>Critical</strong> (Kritisch) und der Status <strong>Unknown</strong> (Unbekannt) lautet, ist der Kubernetes-Master nicht verfügbar. Wenden Sie sich an den {{site.data.keyword.Bluemix_notm}}-Support, indem Sie ein [{{site.data.keyword.Bluemix_notm}}-Support-Ticket](/docs/support/index.html#contacting-support) öffnen. </li></ol>|
{: caption="Tabelle 3. Clusterstatus" caption-side="top"}
