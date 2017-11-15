---

copyright:
  years: 2014, 2017
lastupdated: "2017-10-13"

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

**Tipp:** Suchen Sie nach `bx cr`-Befehlen? Werfen Sie einen Blick in die [{{site.data.keyword.registryshort_notm}}-CLI-Referenz ](/docs/cli/plugins/registry/index.html). Suchen Sie nach `kubectl`-Befehlen? Werfen Sie einen Blick in die [Kubernetes-Dokumentation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/user-guide/kubectl/v1.5/).


<!--[https://github.ibm.com/alchemy-containers/armada-cli ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.ibm.com/alchemy-containers/armada-cli)-->

<table summary="Befehle zum Erstellen von Clustern in {{site.data.keyword.Bluemix_notm}}">
 <thead>
    <th colspan=5>Befehle zum Erstellen von Clustern in {{site.data.keyword.Bluemix_notm}}</th>
 </thead>
 <tbody>
 <tr>
    <td>[bx cs cluster-config](cs_cli_devtools.html#cs_cluster_config)</td>
    <td>[bx cs cluster-create](cs_cli_devtools.html#cs_cluster_create)</td>
    <td>[bx cs cluster-get](cs_cli_devtools.html#cs_cluster_get)</td>
    <td>[bx cs cluster-rm](cs_cli_devtools.html#cs_cluster_rm)</td>
    <td>[bx cs cluster-service-bind](cs_cli_devtools.html#cs_cluster_service_bind)</td>
 </tr>
 <tr>
    <td>[bx cs cluster-service-unbind](cs_cli_devtools.html#cs_cluster_service_unbind)</td>
    <td>[bx cs cluster-services](cs_cli_devtools.html#cs_cluster_services)</td>
    <td>[bx cs cluster-subnet-add](cs_cli_devtools.html#cs_cluster_subnet_add)</td>
    <td>[bx cs clusters](cs_cli_devtools.html#cs_clusters)</td>
    <td>[bx cs credentials-set](cs_cli_devtools.html#cs_credentials_set)</td>
 </tr>
 <tr>
   <td>[bx cs credentials-unset](cs_cli_devtools.html#cs_credentials_unset)</td>
   <td>[bx cs help](cs_cli_devtools.html#cs_help)</td>
   <td>[bx cs init](cs_cli_devtools.html#cs_init)</td>
   <td>[bx cs locations](cs_cli_devtools.html#cs_datacenters)</td>
   <td>[bx cs machine-types](cs_cli_devtools.html#cs_machine_types)</td>
   </tr>
 <tr>
    <td>[bx cs subnets](cs_cli_devtools.html#cs_subnets)</td>
    <td>[bx cs vlans](cs_cli_devtools.html#cs_vlans)</td>
    <td>[bx cs webhook-create](cs_cli_devtools.html#cs_webhook_create)</td>
    <td>[bx cs worker-add](cs_cli_devtools.html#cs_worker_add)</td>
    <td>[bx cs worker-get](cs_cli_devtools.html#cs_worker_get)</td>
    </tr>
 <tr>
   <td>[bx cs worker-reboot](cs_cli_devtools.html#cs_worker_reboot)</td>
   <td>[bx cs worker-reload](cs_cli_devtools.html#cs_worker_reload)</td>
   <td>[bx cs worker-rm](cs_cli_devtools.html#cs_worker_rm)</td>
   <td>[bx cs workers](cs_cli_devtools.html#cs_workers)</td>
   
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

Nach erfolgter Anmeldung das Herunterladen von Kubernetes-Konfigurationsdaten und -Zertifikaten, um eine Verbindung zum Cluster herzustellen und `kubectl`-Befehle auszuführen. Die Dateien werden in `ausgangsverzeichnis_des_benutzers/.bluemix/plugins/container-service/clusters/<cluster_name>`.

**Befehlsoptionen**:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>

   <dt><code>--admin</code></dt>
   <dd>Laden Sie die Zertifikate und Berechtigungsdateien für die RBAC-Rolle 'Administrator' herunter. Benutzer mit diesen Dateien können Administratoraktionen für den Cluster ausführen, z. B. den Cluster entfernen. Dieser Wert ist optional.</dd>
   </dl>

**Beispiel**:

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

<dd>Der Pfad zur YAML-Datei für die Erstellung Ihres Standardclusters. Statt die Merkmale Ihres Clusters mithilfe der in diesem Befehl bereitgestellten Optionen zu definieren, können Sie eine YAML-Datei verwenden. Dieser Wert ist für Standardcluster optional und steht für Lite-Cluster nicht zur Verfügung.

<p><strong>Hinweis:</strong> Wenn Sie dieselbe Option wie im Befehl als Parameter in der YAML-Datei bereitstellen, hat der Wert im Befehl Vorrang vor dem Wert in der YAML. Beispiel: Sie definieren eine Position in Ihrer YAML-Datei und verwenden die Option <code>--location</code> im Befehl. Der Wert, den Sie in die Befehlsoption eingegeben haben, überschreibt den Wert in der YAML-Datei.

<pre class="codeblock">
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
    <td>Ersetzen Sie <code><em>&lt;clustername&gt;</em></code> durch den Namen Ihres Clusters.</td>
    </tr>
    <tr>
    <td><code><em>standort</em></code></td>
    <td>Ersetzen Sie <code><em>&lt;standort&gt;</em></code> durch den Standort, an dem Sie Ihren Cluster erstellen möchten. Welche Standorte verfügbar sind, hängt von der Region ab, bei der Sie angemeldet sind. Führen Sie den Befehl <code>bx cs locations</code> aus, um die verfügbaren Standorte aufzulisten.</td>
     </tr>
     <tr>
     <td><code><em>maschinentyp</em></code></td>
     <td>Ersetzen Sie <code><em>&lt;maschinentyp&gt;</em></code> durch den Maschinentyp, den Sie für Ihre Workerknoten verwenden möchten. Führen Sie <code>bx cs machine-types <em>&lt;standort&gt;</em></code> aus, um verfügbare Maschinentypen für Ihren Standort aufzulisten.</td>
     </tr>
     <tr>
     <td><code><em>privates_vlan</em></code></td>
     <td>Ersetzen Sie <code><em>&lt;privates_vlan&gt;</em></code> durch die ID des privaten VLANs, das Sie für Ihre Workerknoten verwenden möchten. Führen Sie <code>bx cs vlans <em>&lt;standort&gt;</em></code> aus und suchen Sie nach VLAN-Routern, die mit <code>bcr</code> (Back-End-Router) beginnen, um verfügbare VLANs aufzulisten.</td>
     </tr>
     <tr>
     <td><code><em>öffentliches_vlan</em></code></td>
     <td>Ersetzen Sie <code><em>&lt;öffentliches_vlan&gt;</em></code> durch die ID des öffentlichen VLANs, das Sie für Ihre Workerknoten verwenden möchten. Führen Sie <code>bx cs vlans <em>&lt;standort&gt;</em></code> aus und suchen Sie nach VLAN-Routern, die mit <code>fcr</code> (Front-End-Router) beginnen, um verfügbare VLANs aufzulisten.</td>
     </tr>
     <tr>
     <td><code><em>hardware</em></code></td>
     <td>Der Grad an Hardware-Isolation für Ihren Workerknoten. Verwenden Sie 'dedicated', wenn Sie verfügbare physische Ressourcen haben möchten, die nur Sie nutzen können, oder 'shared', um zuzulassen, dass physische Ressourcen mit anderen IBM Kunden gemeinsam genutzt werden können. Die Standardeinstellung ist <code>shared</code>.</td>
     </tr>
     <tr>
     <td><code><em>anzahl_worker</em></code></td>
     <td>Ersetzen Sie <code><em>&lt;anzahl_worker&gt;</em></code> durch die Anzahl von Workerknoten, die Sie implementieren wollen.</td>
     </tr>
     </tbody></table>
    </p></dd>

<dt><code>--hardware <em>HARDWARE</em></code></dt>
<dd>Der Grad an Hardware-Isolation für Ihren Workerknoten. Verwenden Sie 'dedicated', wenn Sie verfügbare physische Ressourcen haben möchten, die nur Sie nutzen können, oder 'shared', um zuzulassen, dass physische Ressourcen mit anderen IBM Kunden gemeinsam genutzt werden können. Die Standardeinstellung ist 'shared'. Dieser Wert ist für Standardcluster optional und steht für Lite-Cluster nicht zur Verfügung.</dd>

<dt><code>--location <em>STANDORT</em></code></dt>
<dd>Der Standort, an dem Sie den Cluster erstellen möchten. Welche Standorte Ihnen zur Verfügung stehen, hängt von der {{site.data.keyword.Bluemix_notm}}-Region ab, bei der Sie angemeldet sind. Wählen Sie die Region aus, die Ihrem Standort am nächsten ist, um eine optimale Leistung zu erhalten.  Dieser Wert ist für Standardcluster erforderlich und für Lite-Cluster optional.

<p>Überprüfen Sie die [verfügbaren Standorte](cs_regions.html#locations).
</p>

<p><strong>Hinweis:</strong> Beachten Sie bei der Auswahl eines Standorts außerhalb Ihres Landes, dass Sie gegebenenfalls eine gesetzliche Genehmigung benötigen, bevor Daten physisch in einem anderen Land gespeichert werden können.</p>
</dd>

<dt><code>--machine-type <em>MASCHINENTYP</em></code></dt>
<dd>Der Maschinentyp, den Sie auswählen, wirkt sich auf die Menge an Hauptspeicher und Plattenspeicher aus, die den in Ihrem Workerknoten bereitgestellten Containern zur Verfügung steht. Führen Sie [bx cs machine-types <em>STANDORT</em>](cs_cli_reference.html#cs_machine_types) aus, um verfügbare Maschinentypen aufzulisten.  Dieser Wert ist für Standardcluster erforderlich und steht für Lite-Cluster nicht zur Verfügung.</dd>

<dt><code>--name <em>NAME</em></code></dt>
<dd>Der Name für den Cluster. Dieser Wert ist erforderlich.</dd>

<dt><code>--no-subnet</code></dt>
<dd>Schließen Sie das Flag ein, um einen Cluster ohne portierbares Teilnetz zu erstellen. Standardmäßig wird das Flag nicht verwendet und ein Teilnetz im Portfolio von IBM Bluemix Infrastructure (SoftLayer) erstellt. Dieser Wert ist optional.</dd>

<dt><code>--private-vlan <em>PRIVATES_VLAN</em></code></dt>
<dd>

<ul>
<li>Dieser Parameter ist für Lite-Cluster nicht verfügbar.</li>
<li>Wenn dieser Standardcluster der erste Standardcluster ist, den Sie an diesem Standort erstellen, schließen Sie dieses Flag nicht ein. Ein privates VLAN wird zusammen mit den Clustern für Sie erstellt.</li>
<li>Wenn Sie bereits einen Standardcluster an diesem Standort oder ein privates VLAN in IBM Bluemix Infrastructure (SoftLayer) erstellt haben, müssen Sie dieses private VLAN angeben.

<p><strong>Hinweis:</strong> Die öffentlichen und privaten VLANs, die Sie mit dem 'create'-Befehl angeben, müssen übereinstimmen. Private VLAN-Router beginnen immer mit <code>bcr</code> (Back-End-Router) und öffentliche VLAN-Router immer mit <code>fcr</code> (Front-End-Router). Die Zahlen- und Buchstabenkombination nach diesen Präfixen muss übereinstimmen, damit diese VLANs beim Erstellen eines Clusters verwendet werden können. Verwenden Sie keine abweichenden öffentlichen und privaten VLANs, um ein Cluster zu erstellen.</p></li>
</ul>

<p>Führen Sie <code>bx cs vlans <em>&lt;standort&gt;</em></code> aus, um herauszufinden, ob Sie bereits über ein privates VLAN für einen bestimmten Standort verfügen, oder um den Namen eines vorhandenen privaten VLANs zu erfahren.</p></dd>

<dt><code>--public-vlan <em>ÖFFENTLICHES_VLAN</em></code></dt>
<dd>
<ul>
<li>Dieser Parameter ist für Lite-Cluster nicht verfügbar.</li>
<li>Wenn dieser Standardcluster der erste Standardcluster ist, den Sie an diesem Standort erstellen, verwenden Sie dieses Flag nicht. Ein öffentliches VLAN wird zusammen mit dem Cluster für Sie erstellt.</li>
<li>Wenn Sie bereits einen Standardcluster an diesem Standort oder ein öffentliches VLAN in IBM Bluemix Infrastructure (SoftLayer) erstellt haben, müssen Sie dieses öffentliche VLAN angeben.

<p><strong>Hinweis:</strong> Die öffentlichen und privaten VLANs, die Sie mit dem 'create'-Befehl angeben, müssen übereinstimmen. Private VLAN-Router beginnen immer mit <code>bcr</code> (Back-End-Router) und öffentliche VLAN-Router immer mit <code>fcr</code> (Front-End-Router). Die Zahlen- und Buchstabenkombination nach diesen Präfixen muss übereinstimmen, damit diese VLANs beim Erstellen eines Clusters verwendet werden können. Verwenden Sie keine abweichenden öffentlichen und privaten VLANs, um ein Cluster zu erstellen.</p></li>
</ul>

<p>Führen Sie <code>bx cs vlans <em>&lt;standort&gt;</em></code> aus, um herauszufinden, ob Sie bereits über ein öffentliches VLAN für einen bestimmten Standort verfügen, oder um den Namen eines vorhandenen öffentlichen VLANs zu erfahren.</p></dd>

<dt><code>--workers WORKER</code></dt>
<dd>Die Anzahl von Workerknoten, die Sie in Ihrem Cluster bereitstellen wollen. Wenn Sie diese Option nicht angeben, wird ein Cluster mit einem Workerknoten erstellt. Dieser Wert ist für Standardcluster optional und steht für Lite-Cluster nicht zur Verfügung.

<p><strong>Hinweis:</strong> Jedem Workerknoten werden eine eindeutige Workerknoten-ID und ein Domänenname zugeordnet, die nach dem Erstellen des Clusters nicht manuell geändert werden dürfen. Wenn die ID oder der Domänenname geändert wird, kann der Kubernetes-Master Ihren Cluster nicht mehr verwalten.</p></dd>
</dl>

**Beispiele**:

  

  Beispiel eines Standardclusters:
  {: #example_cluster_create}

  ```
  bx cs cluster-create --location dal10 --public-vlan meine_id_des_öffentlichen_vlan --private-vlan meine_id_des_privaten_vlan --machine-type u1c.2x4 --name mein_cluster --hardware shared --workers 2
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
   <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>
   </dl>

**Beispiel**:

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
   <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>

   <dt><code>-f</code></dt>
   <dd>Geben Sie diese Option an, um das Entfernen eines Clusters ohne Benutzereingabeaufforderungen zu erzwingen. Dieser Wert ist optional.</dd>
   </dl>

**Beispiel**:

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
   <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>

   <dt><code><em>KUBERNETES-NAMENSBEREICH</em></code></dt>
   <dd>Der Name des Kubernetes-Namensbereichs. Dieser Wert ist erforderlich.</dd>

   <dt><code><em>GUID_DER_SERVICEINSTANZ</em></code></dt>
   <dd>Die ID der {{site.data.keyword.Bluemix_notm}}-Serviceinstanz, die Sie binden möchten. Dieser Wert ist erforderlich.</dd>
   </dl>

**Beispiel**:

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
   <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>

   <dt><code><em>KUBERNETES-NAMENSBEREICH</em></code></dt>
   <dd>Der Name des Kubernetes-Namensbereichs. Dieser Wert ist erforderlich.</dd>

   <dt><code><em>GUID_DER_SERVICEINSTANZ</em></code></dt>
   <dd>Die ID der {{site.data.keyword.Bluemix_notm}}-Serviceinstanz, die Sie entfernen möchten. Dieser Wert ist erforderlich.</dd>
   </dl>

**Beispiel**:

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
   <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>

   <dt><code>--namespace <em>KUBERNETES-NAMENSBEREICH</em></code>, <code>-n
<em>KUBERNETES-NAMENSBEREICH</em></code></dt>
   <dd>Schließen Sie die Services ein, die an einen bestimmten Namensbereich in einem Cluster gebunden sind. Dieser Wert ist optional.</dd>

   <dt><code>--all-namespaces</code></dt>
    <dd>Schließen Sie die Services ein, die an alle Namensbereiche in einem Cluster gebunden sind. Dieser Wert ist optional.</dd>
    </dl>

**Beispiel**:

  ```
  bx cs cluster-services mein_cluster --namespace mein_namensbereich
  ```
  {: pre}


### bx cs cluster-subnet-add CLUSTER TEILNETZ
{: #cs_cluster_subnet_add}

Zurverfügungstellung eines Teilnetzes in einem Konto von IBM Bluemix Infrastructure (SoftLayer) für einen angegebenen Cluster.

**Hinweis:** Wenn Sie ein Teilnetz in einem Cluster verfügbar machen, werden IP-Adressen dieses Teilnetzes zum Zweck von Clusternetzen verwendet. Vermeiden Sie IP-Adresskonflikte, indem Sie ein Teilnetz mit nur einem Cluster verwenden. Verwenden Sie kein Teilnetz für mehrere Cluster oder für andere
Zwecke außerhalb von {{site.data.keyword.containershort_notm}} gleichzeitig.

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>

   <dt><code><em>TEILNETZ</em></code></dt>
   <dd>Die ID des Teilnetzes. Dieser Wert ist erforderlich.</dd>
   </dl>

**Beispiel**:

  ```
  bx cs cluster-subnet-add mein_cluster subnet
  ```
  {: pre}


### bx cs cluster-user-subnet-add CLUSTER SUBNET_CIDR PRIVATE_VLAN
{: #cs_cluster_user_subnet_add}

Verwenden Sie das eigene private Teilnetz in Ihren {{site.data.keyword.containershort_notm}}-Clustern.

Dieses private Teilnetz wird nicht von IBM Bluemix Infrastructure (SoftLayer) bereitgestellt. Deshalb müssen Sie das gesamte Routing für ein- und ausgehenden Netzverkehr für das Teilnetz konfigurieren. Wenn Sie ein Teilnetz von IBM Bluemix Infrastructure (SoftLayer) hinzufügen möchten, dann verwenden Sie den [Befehl](#cs_cluster_subnet_add) `bx cs cluster-subnet-add`.

**Hinweis**: Wenn Sie ein privates Benutzerteilnetz zu einem Cluster hinzufügen, dann werden die IP-Adressen dieses Teilnetzes für private Lastausgleichsfunktionen im Cluster verwendet. Vermeiden Sie IP-Adresskonflikte, indem Sie ein Teilnetz mit nur einem Cluster verwenden. Verwenden Sie kein Teilnetz für mehrere Cluster oder für andere
Zwecke außerhalb von {{site.data.keyword.containershort_notm}} gleichzeitig.

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>

   <dt><code><em>TEILNETZ_CIDR</em></code></dt>
   <dd>Das CIDR (Classless InterDomain Routing) des Teilnetzes. Dieser Wert ist erforderlich und darf keinen Konflikt mit einem anderen Teilnetz verursachen, das von IBM Bluemix Infrastructure (SoftLayer) verwendet wird.

   Die unterstützten Präfixe liegen zwischen `/30` (1 IP-Adresse) und `/24` (253 IP-Adressen). Wenn Sie das CIDR mit einer Präfixlänge festlegen und später ändern müssen, dann sollten Sie zuerst das neue CIDR hinzufügen und anschließend das [alte CIDR entfernen](#cs_cluster_user_subnet_rm).</dd>

   <dt><code><em>PRIVATES_VLAN</em></code></dt>
   <dd>Die ID des privaten VLAN. Dieser Wert ist erforderlich. Er muss mit der ID des privaten VLAN für mindestens einen Workerknoten im Cluster übereinstimmen.</dd>
   </dl>

**Beispiel**:

  ```
  bx cs cluster-user-subnet-add my_cluster 192.168.10.0/29 1502175
  ```
  {: pre}


### bx cs cluster-user-subnet-rm CLUSTER SUBNET_CIDR PRIVATE_VLAN
{: #cs_cluster_user_subnet_rm}

Entfernen Sie Ihr eigenes privates Teilnetz aus einem angegebenen Cluster.

**Hinweis:** Jeder Service, der für eine IP-Adresse aus dem eigenen privaten Teilnetz bereitgestellt wurde, bleibt nach der Entfernung des Teilnetzes weiterhin aktiv.

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>

   <dt><code><em>TEILNETZ_CIDR</em></code></dt>
   <dd>Das CIDR (Classless InterDomain Routing) des Teilnetzes. Dieser Wert ist erforderlich und muss mit dem CIDR übereinstimmen, das mit dem [Befehl](#cs_cluster_user_subnet_add) `bx cs cluster-user-subnet-add` festgelegt wurde.</dd>

   <dt><code><em>PRIVATES_VLAN</em></code></dt>
   <dd>Die ID des privaten VLAN. Dieser Wert ist erforderlich und muss mit der VLAN-ID übereinstimmen, die mit dem [Befehl](#cs_cluster_user_subnet_add) `bx cs cluster-user-subnet-add` festgelegt wurde.</dd>
   </dl>

**Beispiel**:

  ```
  bx cs cluster-user-subnet-rm my_cluster 192.168.10.0/29 1502175
  ```
  {: pre}


### bx cs cluster-update [-f] CLUSTER
{: #cs_cluster_update}

Aktualisieren Sie den Kubernetes-Master auf die aktuellste API-Version. Während der Aktualisierung können Sie weder auf den Cluster zugreifen noch eine Änderung am Cluster vornehmen. Workerknoten, Apps und Ressourcen, die vom Benutzer bereitgestellt wurden, werden nicht geändert und weiterhin ausgeführt.

Möglicherweise müssen Sie Ihre YAML-Dateien für zukünftige Bereitstellungen ändern. Lesen Sie die detaillierten Informationen in diesen [Releaseinformationen](cs_versions.html).

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>

   <dt><code>-f</code></dt>
   <dd>Geben Sie diese Option an, um die Aktualisierung des Masters ohne Benutzereingabeaufforderungen zu erzwingen. Dieser Wert ist optional.</dd>
   </dl>

**Beispiel**:

  ```
  bx cs cluster-update my_cluster
  ```
  {: pre}

### bx cs clusters
{: #cs_clusters}

Anzeigen einer Liste der Cluster in Ihrer Organisation.

<strong>Befehlsoptionen</strong>:

  Keine

**Beispiel**:

  ```
  bx cs clusters
  ```
  {: pre}


### bx cs credentials-set --infrastructure-api-key API-SCHLÜSSEL --infrastructure-username BENUTZERNAME
{: #cs_credentials_set}

Festlegen von Berechtigungsnachweisen für das Konto von IBM Bluemix Infrastructure (SoftLayer) für Ihr {{site.data.keyword.Bluemix_notm}}-Konto. Mit diesen Berechtigungsnachweisen können Sie über Ihr {{site.data.keyword.Bluemix_notm}}-Konto auf das Portfolio von IBM Bluemix Infrastructure (SoftLayer) zugreifen.

**Hinweis:** Das Festlegen mehrerer Berechtigungsnachweise für ein {{site.data.keyword.Bluemix_notm}}-Konto ist nicht zulässig. Jedes {{site.data.keyword.Bluemix_notm}}-Konto ist nur mit einem Portfolio von IBM Bluemix Infrastructure (SoftLayer) verbunden.

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code>--infrastructure-username <em>BENUTZERNAME</em></code></dt>
   <dd>Ein Benutzername für ein Konto von IBM Bluemix Infrastructure (SoftLayer). Dieser Wert ist erforderlich.</dd>
   </dl>

   <dt><code>--infrastructure-api-key <em>API-SCHLÜSSEL</em></code></dt>
   <dd>Ein API-Schlüssel für ein Konto von IBM Bluemix Infrastructure (SoftLayer). Dieser Wert ist erforderlich.

 <p>
  Gehen Sie wie folgt vor, um einen API-Schlüssel zu generieren:

  <ol>
  <li>Melden Sie sich beim [Portal von IBM Bluemix Infrastructure (SoftLayer) ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://control.softlayer.com/) an.</li>
  <li>Wählen Sie <strong>Konto</strong> und dann <strong>Benutzer</strong> aus.</li>
  <li>Klicken Sie auf <strong>Generieren</strong>, um einen API-Schlüssel von IBM Bluemix Infrastructure (SoftLayer) für Ihr Konto zu generieren.</li>
  <li>Kopieren Sie den API-Schlüssel, um diesen Befehl verwenden zu können.</li>
  </ol>

  Gehen Sie wie folgt vor, um Ihren API-Schlüssel anzuzeigen:
  <ol>
  <li>Melden Sie sich beim [Portal von IBM Bluemix Infrastructure (SoftLayer) ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://control.softlayer.com/) an.</li>
  <li>Wählen Sie <strong>Konto</strong> und dann <strong>Benutzer</strong> aus.</li>
  <li>Klicken Sie auf <strong>Anzeigen</strong>, um den bestehenden API-Schlüssel anzuzeigen.</li>
  <li>Kopieren Sie den API-Schlüssel, um diesen Befehl verwenden zu können.</li>
  </ol></p></dd>

**Beispiel**:

  ```
  bx cs credentials-set --infrastructure-api-key API-SCHLÜSSEL --infrastructure-username BENUTZERNAME
  ```
  {: pre}


### bx cs credentials-unset
{: #cs_credentials_unset}

Entfernen Sie die Kontoberechtigungsnachweise von IBM Bluemix Infrastructure (SoftLayer) aus Ihrem {{site.data.keyword.Bluemix_notm}}-Konto. Nachdem Sie die Berechtigungsnachweise entfernt haben, können Sie über Ihr {{site.data.keyword.Bluemix_notm}}-Konto nicht mehr auf das Portfolio von IBM Bluemix Infrastructure (SoftLayer) zugreifen.

<strong>Befehlsoptionen</strong>:

   Keine

**Beispiel**:

  ```
  bx cs credentials-unset
  ```
  {: pre}



### bx cs help
{: #cs_help}

Anzeigen einer Liste der unterstützten Befehle und Parameter.

<strong>Befehlsoptionen</strong>:

   Keine

**Beispiel**:

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
   <dd>Der {{site.data.keyword.containershort_notm}}-API-Endpunkt, den Sie verwenden möchten. Dieser Wert ist optional. Beispiel:

    <ul>
    <li>Vereinigte Staaten (Süden):

    <pre class="codeblock">
    <code>bx cs init --host https://us-south.containers.bluemix.net</code>
    </pre></li>

    <li>Vereinigte Staaten (Osten):

    <pre class="codeblock">
    <code>bx cs init --host https://us-east.containers.bluemix.net</code>
    </pre>
    <p><strong>Hinweis</strong>: Die Region 'Vereinigte Staaten (Osten)' ist nur zur Verwendung mit CLI-Befehlen verfügbar.</p></li>

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




### bx cs locations
{: #cs_datacenters}

Anzeigen einer Liste von verfügbaren Standorten, in denen Sie einen Cluster erstellen können.

<strong>Befehlsoptionen</strong>:

   Keine

**Beispiel**:

  ```
  bx cs locations
  ```
  {: pre}


### bx cs machine-types STANDORT
{: #cs_machine_types}

Anzeige einer Liste der für Ihre Workerknoten verfügbaren Maschinentypen. Jeder Maschinentyp enthält die Menge an virtueller CPU, an Hauptspeicher und an Plattenspeicher für jeden Workerknoten im Cluster.

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><em>STANDORT</em></dt>
   <dd>Geben Sie den Standort ein, an dem Sie verfügbare Maschinentypen auflisten möchten. Dieser Wert ist erforderlich. Überprüfen Sie die [verfügbaren Standorte](cs_regions.html#locations).</dd></dl>

**Beispiel**:

  ```
  bx cs machine-types STANDORT
  ```
  {: pre}


### bx cs subnets
{: #cs_subnets}

Anzeigen einer Liste der Teilnetze, die in einem Konto von IBM Bluemix Infrastructure (SoftLayer) verfügbar sind.

<strong>Befehlsoptionen</strong>:

   Keine

**Beispiel**:

  ```
  bx cs subnets
  ```
  {: pre}


### bx cs vlans STANDORT
{: #cs_vlans}

Auflisten der öffentlichen und der privaten VLANs, die für einen Standort in Ihrem Konto von IBM Bluemix Infrastructure (SoftLayer) zur Verfügung stehen. Um verfügbare VLANs auflisten zu können, müssen Sie über ein gebührenpflichtiges Konto verfügen.

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt>STANDORT</dt>
   <dd>Geben Sie den Standort ein, an dem Sie Ihre privaten und öffentlichen VLANs auflisten möchten. Dieser Wert ist erforderlich. Überprüfen Sie die [verfügbaren Standorte](cs_regions.html#locations).</dd>
   </dl>

**Beispiel**:

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
   <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>

   <dt><code>--level <em>STUFE</em></code></dt>
   <dd>Die Benachrichtigungsstufe wie etwa <code>Normal</code> oder <code>Warnung</code>. <code>Warnung</code> ist der Standardwert. Dieser Wert ist optional.</dd>

   <dt><code>--type <em>slack</em></code></dt>
   <dd>Der Typ des Webhook, z. B. 'slack'. Es wird nur 'slack' unterstützt. Dieser Wert ist erforderlich.</dd>

   <dt><code>--URL <em>URL</em></code></dt>
   <dd>Die URL für den Webhook. Dieser Wert ist erforderlich.</dd>
   </dl>

**Beispiel**:

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
<dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>

<dt><code>--file <em>DATEISTANDORT</em></code></dt>
<dd>Der Pfad zur YAML-Datei für das Hinzufügen von Workerknoten zu Ihrem Cluster. Statt Ihre zusätzlichen Workerknoten mithilfe der in diesem Befehl bereitgestellten Optionen zu definieren, können Sie eine YAML-Datei verwenden. Dieser Wert ist optional.

<p><strong>Hinweis:</strong> Wenn Sie dieselbe Option wie im Befehl als Parameter in der YAML-Datei bereitstellen, hat der Wert im Befehl Vorrang vor dem Wert in der YAML. Beispiel: Sie definieren einen Maschinentyp in Ihrer YAML-Datei und verwenden die Option '--machine-type' im Befehl. Der Wert, den Sie in der Befehlsoption eingegeben haben, überschreibt den Wert in der YAML-Datei.

<pre class="codeblock">
<code>name: <em>&lt;clustername_oder_id&gt;</em>
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
<td>Ersetzen Sie <code><em>&lt;clustername_oder_id&gt;</em></code> durch den Namen oder die ID des Clusters, in dem Sie Workerknoten hinzufügen möchten.</td>
</tr>
<tr>
<td><code><em>standort</em></code></td>
<td>Ersetzen Sie <code><em>&lt;standort&gt;</em></code> durch den Standort, an dem Sie Ihre Workerknoten bereitstellen möchten. Welche Standorte verfügbar sind, hängt von der Region ab, bei der Sie angemeldet sind. Führen Sie den Befehl <code>bx cs locations</code> aus, um die verfügbaren Standorte aufzulisten.</td>
</tr>
<tr>
<td><code><em>maschinentyp</em></code></td>
<td>Ersetzen Sie <code><em>&lt;maschinentyp&gt;</em></code> durch den Maschinentyp, den Sie für Ihre Workerknoten verwenden möchten. Führen Sie <code>bx cs machine-types <em>&lt;standort&gt;</em></code> aus, um verfügbare Maschinentypen für Ihren Standort aufzulisten.</td>
</tr>
<tr>
<td><code><em>privates_vlan</em></code></td>
<td>Ersetzen Sie <code><em>&lt;privates_vlan&gt;</em></code> durch die ID des privaten VLANs, das Sie für Ihre Workerknoten verwenden möchten. Führen Sie <code>bx cs vlans <em>&lt;standort&gt;</em></code> aus und suchen Sie nach VLAN-Routern, die mit <code>bcr</code> (Back-End-Router) beginnen, um verfügbare VLANs aufzulisten.</td>
</tr>
<tr>
<td><code>öffentliches_vlan</code></td>
<td>Ersetzen Sie <code>&lt;öffentliches_vlan&gt;</code> durch die ID des öffentlichen VLANs, das Sie für Ihre Workerknoten verwenden möchten. Führen Sie <code>bx cs vlans &lt;standort&gt;</code> aus und suchen Sie nach VLAN-Routern, die mit <code>fcr</code> (Front-End-Router) beginnen, um verfügbare VLANs aufzulisten.</td>
</tr>
<tr>
<td><code>hardware</code></td>
<td>Der Grad an Hardware-Isolation für Ihren Workerknoten. Verwenden Sie 'dedicated', wenn Sie verfügbare physische Ressourcen haben möchten, die nur Sie nutzen können, oder 'shared', um zuzulassen, dass physische Ressourcen mit anderen IBM Kunden gemeinsam genutzt werden können. Die Standardeinstellung ist 'shared'.</td>
</tr>
<tr>
<td><code>anzahl_worker</code></td>
<td>Ersetzen Sie <code><em>&lt;anzahl_worker&gt;</em></code> durch die Anzahl von Workerknoten, die Sie implementieren wollen.</td>
</tr>
</tbody></table></p></dd>

<dt><code>--hardware <em>HARDWARE</em></code></dt>
<dd>Der Grad an Hardware-Isolation für Ihren Workerknoten. Verwenden Sie 'dedicated', wenn Sie verfügbare physische Ressourcen haben möchten, die nur Sie nutzen können, oder 'shared', um zuzulassen, dass physische Ressourcen mit anderen IBM Kunden gemeinsam genutzt werden können. Die Standardeinstellung ist 'shared'. Dieser Wert ist optional.</dd>

<dt><code>--machine-type <em>MASCHINENTYP</em></code></dt>
<dd>Der Maschinentyp, den Sie auswählen, wirkt sich auf die Menge an Hauptspeicher und Plattenspeicher aus, die den in Ihrem Workerknoten bereitgestellten Containern zur Verfügung steht. Dieser Wert ist erforderlich. Führen Sie [bx cs machine-types STANDORT](cs_cli_reference.html#cs_machine_types) aus, um verfügbare Maschinentypen aufzulisten.</dd>

<dt><code>--number <em>ANZAHL</em></code></dt>
<dd>Die durch eine Ganzzahl angegebene Anzahl der Workerknoten, die im Cluster erstellt werden sollen. Der Standardwert ist 1. Dieser Wert ist optional.</dd>

<dt><code>--private-vlan <em>PRIVATES_VLAN</em></code></dt>
<dd>Das private VLAN, das bei der Erstellung des Clusters angegeben wurde. Dieser Wert ist erforderlich.

<p><strong>Hinweis:</strong> Die öffentlichen und privaten VLANs, die Sie angeben, müssen übereinstimmen. Private VLAN-Router beginnen immer mit <code>bcr</code> (Back-End-Router) und öffentliche VLAN-Router immer mit <code>fcr</code> (Front-End-Router). Die Zahlen- und Buchstabenkombination nach diesen Präfixen muss übereinstimmen, damit diese VLANs beim Erstellen eines Clusters verwendet werden können. Verwenden Sie keine abweichenden öffentlichen und privaten VLANs, um ein Cluster zu erstellen.</p></dd>

<dt><code>--public-vlan <em>ÖFFENTLICHES_VLAN</em></code></dt>
<dd>Das öffentliche VLAN, das bei der Erstellung des Clusters angegeben wurde. Dieser Wert ist optional.

<p><strong>Hinweis:</strong> Die öffentlichen und privaten VLANs, die Sie angeben, müssen übereinstimmen. Private VLAN-Router beginnen immer mit <code>bcr</code> (Back-End-Router) und öffentliche VLAN-Router immer mit <code>fcr</code> (Front-End-Router). Die Zahlen- und Buchstabenkombination nach diesen Präfixen muss übereinstimmen, damit diese VLANs beim Erstellen eines Clusters verwendet werden können. Verwenden Sie keine abweichenden öffentlichen und privaten VLANs, um ein Cluster zu erstellen.</p></dd>
</dl>

**Beispiele**:

  ```
  bx cs worker-add --cluster mein_cluster --number 3 --public-vlan meine_id_des_öffentlichen_vlan --private-vlan meine_id_des_privaten_vlan --machine-type u1c.2x4 --hardware shared
  ```
  {: pre}

  Beispiel für {{site.data.keyword.Bluemix_notm}} Dedicated:

  ```
  bx cs worker-add --cluster mein_cluster --number 3 --machine-type u1c.2x4
  ```
  {: pre}


### bx cs worker-get WORKERKNOTEN-ID
{: #cs_worker_get}

Anzeigen der Details eines Workerknotens.

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><em>WORKERKNOTEN-ID</em></dt>
   <dd>Die ID für einen Workerknoten. Führen Sie den Befehl <code>bx cs workers <em>CLUSTER</em></code> aus, um die IDs für die Workerknoten in einem Cluster anzuzeigen. Dieser Wert ist erforderlich.</dd>
   </dl>

**Beispiel**:

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
   <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>

   <dt><code>-f</code></dt>
   <dd>Geben Sie diese Option an, um den Neustart des Workerknotens ohne Benutzereingabeaufforderungen zu erzwingen. Dieser Wert ist optional.</dd>

   <dt><code>--hard</code></dt>
   <dd>Geben Sie diese Option an, um einen plötzlichen Neustart eines Workerknotens zu erzwingen, indem Sie die Stromversorgung zum Workerknoten kappen. Verwenden Sie diese Option, wenn der Workerknoten nicht antwortet oder Docker blockiert ist. Dieser Wert ist optional.</dd>

   <dt><code><em>WORKERKNOTEN</em></code></dt>
   <dd>Der Name oder die ID einzelner oder mehrerer Workerknoten. Trennen Sie bei einer Auflistung mehrerer Workerknoten die einzelnen Auflistungselemente jeweils durch ein Leerzeichen. Dieser Wert ist erforderlich.</dd>
   </dl>

**Beispiel**:

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
   <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>

   <dt><code>-f</code></dt>
   <dd>Geben Sie diese Option ein, um das Neuladen eines Workerknotens ohne Benutzereingabeaufforderungen zu erzwingen. Dieser Wert ist optional.</dd>

   <dt><code><em>WORKERKNOTEN</em></code></dt>
   <dd>Der Name oder die ID einzelner oder mehrerer Workerknoten. Trennen Sie bei einer Auflistung mehrerer Workerknoten die einzelnen Auflistungselemente jeweils durch ein Leerzeichen. Dieser Wert ist erforderlich.</dd>
   </dl>

**Beispiel**:

  ```
  bx cs worker-reload mein_cluster mein_knoten1 mein_knoten2
  ```
  {: pre}

### bx cs worker-rm [-f] CLUSTER WORKER [WORKER]
{: #cs_worker_rm}

Entfernen einzelner oder mehrerer Workerknoten von einem Cluster.

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>

   <dt><code>-f</code></dt>
   <dd>Geben Sie diese Option ein, um die Entfernung eines Workerknotens ohne Benutzereingabeaufforderungen zu erzwingen. Dieser Wert ist optional.</dd>

   <dt><code><em>WORKERKNOTEN</em></code></dt>
   <dd>Der Name oder die ID einzelner oder mehrerer Workerknoten. Trennen Sie bei einer Auflistung mehrerer Workerknoten die einzelnen Auflistungselemente jeweils durch ein Leerzeichen. Dieser Wert ist erforderlich.</dd>
   </dl>

**Beispiel**:

  ```
  bx cs worker-rm mein_cluster mein_knoten1 mein_knoten2
  ```
  {: pre}

### bx cs worker-update [-f] CLUSTER WORKER [WORKER]
{: #cs_worker_update}

Aktualisieren Sie die Workerknoten auf die aktuellste Kubernetes-Version. Durch die Ausführung von `bx cs worker-update` kann es zu Ausfallzeiten bei Ihren Apps und Services kommen. Während der Aktualisierung wird die Planung aller Pods auf anderen Workerknoten neu erstellt und die Daten werden gelöscht, wenn sie nicht außerhalb des Pods gespeichert wurden. Um Ausfallzeiten zu vermeiden, sollten Sie sicherstellen, dass genügend Workerknoten vorhanden sind, um die Arbeitslast zu verarbeiten, während für die ausgewählten Workerknoten eine Aktualisierung durchgeführt wird.

Möglicherweise müssen Sie Ihre YAML-Dateien für Bereitstellungen vor der Aktualisierung ändern. Lesen Sie die detaillierten Informationen in diesen [Releaseinformationen](cs_versions.html).

<strong>Befehlsoptionen</strong>:

   <dl>

   <dt><em>CLUSTER</em></dt>
   <dd>Der Name oder die ID des Clusters, in dem Sie verfügbare Workerknoten auflisten. Dieser Wert ist erforderlich.</dd>

   <dt><code>-f</code></dt>
   <dd>Geben Sie diese Option an, um die Aktualisierung des Masters ohne Benutzereingabeaufforderungen zu erzwingen. Dieser Wert ist optional.</dd>

   <dt><code><em>WORKERKNOTEN</em></code></dt>
   <dd>Die ID einzelner oder mehrerer Workerknoten. Trennen Sie bei einer Auflistung mehrerer Workerknoten die einzelnen Auflistungselemente jeweils durch ein Leerzeichen. Dieser Wert ist erforderlich.</dd>
   </dl>

**Beispiel**:

  ```
  bx cs worker-update mein_cluster mein_knoten1 mein_knoten2
  ```
  {: pre}

### bx cs workers CLUSTER
{: #cs_workers}

Anzeigen einer Liste der Workerknoten und ihres jeweiligen Status in einem Cluster.

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><em>CLUSTER</em></dt>
   <dd>Der Name oder die ID des Clusters, in dem Sie verfügbare Workerknoten auflisten. Dieser Wert ist erforderlich.</dd>
   </dl>

**Beispiel**:

  ```
  bx cs workers mein_cluster
  ```
  {: pre}
