---

copyright:
  years: 2014, 2018
lastupdated: "2017-01-24"

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

**Tipp:** Suchen Sie nach `bx cr`-Befehlen? Werfen Sie einen Blick in die [{{site.data.keyword.registryshort_notm}}-CLI-Referenz ](/docs/cli/plugins/registry/index.html). Suchen Sie nach `kubectl`-Befehlen? Werfen Sie einen Blick in die [Kubernetes-Dokumentation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands).




<table summary="Befehle zum Erstellen von Clustern in {{site.data.keyword.Bluemix_notm}}">
 <thead>
    <th colspan=5>Befehle zum Erstellen von Clustern in {{site.data.keyword.Bluemix_notm}}</th>
 </thead>
 <tbody>
  <tr>
    <td>[bx cs albs](#cs_albs)</td>
    <td>[bx cs alb-configure](#cs_alb_configure)</td>
    <td>[bx cs alb-get](#cs_alb_get)</td>
    <td>[bx cs alb-types](#cs_alb_types)</td>
    <td>[bx cs cluster-config](#cs_cluster_config)</td>
  </tr>
 <tr>
    <td>[bx cs cluster-create](#cs_cluster_create)</td>
    <td>[bx cs cluster-get](#cs_cluster_get)</td>
    <td>[bx cs cluster-rm](#cs_cluster_rm)</td>
    <td>[bx cs cluster-service-bind](#cs_cluster_service_bind)</td>
    <td>[bx cs cluster-service-unbind](#cs_cluster_service_unbind)</td>
 </tr>
 <tr>
    <td>[bx cs cluster-services](#cs_cluster_services)</td>
    <td>[bx cs cluster-subnet-add](#cs_cluster_subnet_add)</td>
    <td>[bx cs cluster-subnet-create](#cs_cluster_subnet_create)</td>
    <td>[bx cs cluster-user-subnet-add](#cs_cluster_user_subnet_add)</td>
    <td>[bx cs cluster-user-subnet-rm](#cs_cluster_user_subnet_rm)</td>
 </tr>
 <tr>
    <td>[bx cs cluster-update](#cs_cluster_update)</td>
    <td>[bx cs clusters](#cs_clusters)</td>
    <td>[bx cs credentials-set](#cs_credentials_set)</td>
    <td>[bx cs credentials-unset](#cs_credentials_unset)</td>
    <td>[bx cs help](#cs_help)</td>
 </tr>
 <tr>
    <td>[bx cs init](#cs_init)</td>
    <td>[bx cs kube-versions](#cs_kube_versions)</td>
    <td>[bx cs locations](#cs_datacenters)</td>
    <td>[bx cs logging-config-create](#cs_logging_create)</td>
    <td>[bx cs logging-config-get](#cs_logging_get)</td>
 </tr>
 <tr>
    <td>[bx cs logging-config-rm](#cs_logging_rm)</td>
    <td>[bx cs logging-config-update](#cs_logging_update)</td>
    <td>[bx cs machine-types](#cs_machine_types)</td>
    <td>[bx cs subnets](#cs_subnets)</td>
    <td>[bx cs vlans](#cs_vlans)</td>
 </tr>
 <tr>
    <td>[bx cs webhook-create](#cs_webhook_create)</td>
    <td>[bx cs worker-add](#cs_worker_add)</td>
    <td>[bx cs worker-get](#cs_worker_get)</td>
    <td>[bx cs worker-rm](#cs_worker_rm)</td>
    <td>[bx cs worker-update](#cs_worker_update)</td>
 </tr>
 <tr>
    <td>[bx cs worker-reboot](#cs_worker_reboot)</td>
    <td>[bx cs worker-reload](#cs_worker_reload)</td>
    <td>[bx cs workers](#cs_workers)</td>
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

### bx cs albs --cluster CLUSTER
{: #cs_albs}

Anzeigen des Status aller Lastausgleichsfunktionen für Anwendungen (Application Load Balancers, ALBs) in einem Cluster. Wenn keine ALB-IDs zurückgegeben werden, verfügt der Cluster nicht über ein portierbares Teilnetz. Sie können Teilnetze [erstellen](#cs_cluster_subnet_create) oder zu einem Cluster [hinzufügen](#cs_cluster_subnet_add).

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code><em>--cluster </em>CLUSTER</code></dt>
   <dd>Der Name oder die ID des Clusters, in dem Sie verfügbare Lastausgleichsfunktionen für Anwendungen auflisten. Dieser Wert ist erforderlich.</dd>
   </dl>

**Beispiel**:

  ```
  bx cs albs --cluster mycluster
  ```
  {: pre}



### bx cs alb-configure --albID ALB-ID [--enable][--disable][--user-ip BENUTZER-IP]
{: #cs_alb_configure}

Aktivieren oder Inaktivieren einer Lastausgleichsfunktion für Anwendungen (Application Load Balancer, ALB) in Ihrem Standardcluster. Die öffentliche Lastausgleichsfunktion für Anwendungen ist standardmäßig aktiviert.

**Befehlsoptionen**:

   <dl>
   <dt><code><em>--albID </em>ALB-ID</code></dt>
   <dd>Die ID für eine Lastausgleichsfunktion für Anwendungen. Führen Sie <code>bx cs albs <em>--cluster </em>CLUSTER</code> aus, um die IDs für die Lastausgleichsfunktionen für Anwendungen in einem Cluster anzuzeigen. Dieser Wert ist erforderlich.</dd>

   <dt><code>--enable</code></dt>
   <dd>Schließen Sie dieses Flag ein, um eine Lastausgleichsfunktion für Anwendungen in einem Cluster zu aktivieren.</dd>

   <dt><code>--disable</code></dt>
   <dd>Schließen Sie dieses Flag ein, um eine Lastausgleichsfunktion für Anwendungen in einem Cluster zu inaktivieren.</dd>

   <dt><code>--user-ip <em>BENUTZER-IP</em></code></dt>
   <dd>

   <ul>
    <li>Dieser Parameter ist nur für eine private Lastausgleichsfunktion für Anwendungen verfügbar.</li>
    <li>Die private Lastausgleichsfunktion für Anwendungen wird mit einer IP-Adresse aus einem von einem Benutzer bereitgestellten privaten Teilnetz implementiert. Wird keine IP-Adresse bereitgestellt, wird die Lastausgleichsfunktion für Anwendungen mit einer privaten IP-Adresse aus dem portierbaren privaten Teilnetz bereitgestellt, die beim Erstellen des Clusters automatisch bereitgestellt wurde.</li>
   </ul>
   </dd>
   </dl>

**Beispiele**:

  Beispiel für die Aktivierung einer Lastausgleichsfunktion für Anwendungen:

  ```
  bx cs alb-configure --albID meine_alb-id --enable
  ```
  {: pre}

  Beispiel für die Inaktivierung einer Lastausgleichsfunktion für Anwendungen:

  ```
  bx cs alb-configure --albID meine_alb-id --disable
  ```
  {: pre}

  Beispiel für die Aktivierung einer Lastausgleichsfunktion für Anwendungen mit einer vom Benutzer bereitgestellten IP-Adresse:

  ```
  bx cs alb-configure --albID meine_private_alb-id --enable --user-ip benutzer-ip
  ```
  {: pre}

### bx cs alb-get --albID ALB-ID
{: #cs_alb_get}

Zeigen Sie die Details einer Lastausgleichsfunktion für Anwendungen an.

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code><em>--albID </em>ALB-ID</code></dt>
   <dd>Die ID für eine Lastausgleichsfunktion für Anwendungen. Führen Sie <code>bx cs albs --cluster <em>CLUSTER</em></code> aus, um die IDs für die Lastausgleichsfunktionen für Anwendungen in einem Cluster anzuzeigen. Dieser Wert ist erforderlich.</dd>
   </dl>

**Beispiel**:

  ```
  bx cs alb-get --albID ALB-ID
  ```
  {: pre}

### bx cs alb-types
{: #cs_alb_types}

Anzeigen der Lastverteilertypen für Anwendungen, die in der Region unterstützt werden.

<strong>Befehlsoptionen</strong>:

   Keine

**Beispiel**:

  ```
  bx cs alb-types
  ```
  {: pre}


### bx cs apiserver-config-set
{: #cs_apiserver_config_set}

Legen Sie eine Option für die Kubernetes-API-Serverkonfiguration eines Clusters fest. Dieser Befehl muss mit einem der folgenden Unterbefehle für die Konfigurationsoption, die Sie festlegen möchten, kombiniert werden.

#### bx cs apiserver-config-get audit-webhook CLUSTER
{: #cs_apiserver_api_webhook_get}

Zeigen Sie die URL für den fernen Protokollierungsservice an, an den Sie API-Serverauditprotokolle senden. Die URL wurde angegeben, als Sie das Webhook-Back-End für die API-Serverkonfiguration erstellt haben.

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>
   </dl>

**Beispiel**:

  ```
  bx cs apiserver-config-get audit-webhook mein_cluster
  ```
  {: pre}

#### bx cs apiserver-config-set audit-webhook CLUSTER [--remoteServer SERVER-URL_ODER_-IP][--caCert CA_CERT_PATH] [--clientCert PFAD_DES_CLIENTZERTIFIKATS][--clientKey CLIENT_KEY_PATH]
{: #cs_apiserver_api_webhook_set}

Legen Sie das Webhook-Back-End für die API-Serverkonfiguration fest. Das Webhook-Back-End leitet API-Serverauditprotokolle an einen fernen Server weiter. Eine Webhook-Konfiguration wird auf der Grundlage der Informationen erstellt, die Sie in den Flags dieses Befehls bereitstellen. Wenn Sie keine Informationen in den Flags bereitstellen, wird eine Standard-Webhook-Konfiguration verwendet.

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>

   <dt><code>--remoteServer <em>SERVER-URL</em></code></dt>
   <dd>Die URL oder IP-Adresse für den fernen Protokollierungsservice, an den Sie Auditprotokolle senden möchten. Wenn Sie eine unsichere Server-URL angeben, werden alle Zertifikate ignoriert. Dieser Wert ist optional.</dd>

   <dt><code>--caCert <em>PFAD_DES_CA-ZERTIFIKATS</em></code></dt>
   <dd>Der Dateipfad für das CA-Zertifikat, das zum Überprüfen des fernen Protokollierungsservice verwendet werden. Dieser Wert ist optional.</dd>

   <dt><code>--clientCert <em>PFAD_DES_CLIENTZERTIFIKATS</em></code></dt>
   <dd>Der Dateipfad des Clientzertifikats, das zum Authentifizieren beim fernen Protokollierungsservice verwendet wird. Dieser Wert ist optional.</dd>

   <dt><code>--clientKey <em>PFAD_DES_CLIENTSCHLÜSSELS</em></code></dt>
   <dd>Der Dateipfad für den entsprechenden Clientschlüssel, der zum Verbinden mit dem fernen Protokollierungsservice verwendet wird. Dieser Wert ist optional.</dd>
   </dl>

**Beispiel**:

  ```
  bx cs apiserver-config-set audit-webhook mein_cluster --remoteServer https://audit.example.com/audit --caCert /mnt/etc/kubernetes/apiserver-audit/ca.pem --clientCert /mnt/etc/kubernetes/apiserver-audit/cert.pem --clientKey /mnt/etc/kubernetes/apiserver-audit/key.pem
  ```
  {: pre}

#### bx cs apiserver-config-unset audit-webhook CLUSTER
{: #cs_apiserver_api_webhook_unset}

Inaktivieren Sie die Webhook-Back-End-Konfiguration für den API-Server des Clusters. Wenn Sie das Webhook-Back-End inaktivieren, wird die Weiterleitung von API-Serverauditprotokollen an einen fernen Server gestoppt.

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>
   </dl>

**Beispiel**:

  ```
  bx cs apiserver-config-unset audit-webhook mein_cluster
  ```
  {: pre}

### bx cs apiserver-refresh CLUSTER
{: #cs_apiserver_refresh}

Starten Sie den Kubernetes-Master im Cluster, um Änderungen an der API-Serverkonfiguration anzuwenden.

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>
   </dl>

**Beispiel**:

  ```
  bx cs apiserver-refresh mein_cluster
  ```
  {: pre}


### bx cs cluster-config CLUSTER [--admin][--export]
{: #cs_cluster_config}

Nach erfolgter Anmeldung das Herunterladen von Kubernetes-Konfigurationsdaten und -Zertifikaten, um eine Verbindung zum Cluster herzustellen und `kubectl`-Befehle auszuführen. Die Dateien werden in `ausgangsverzeichnis_des_benutzers/.bluemix/plugins/container-service/clusters/<cluster_name>`.

**Befehlsoptionen**:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>

   <dt><code>--admin</code></dt>
   <dd>Laden Sie die TLS-Zertifikate und die entsprechenden Berechtigungsdateien für die Rolle 'Superuser' herunter. Sie können die Zertifikate verwenden, um Tasks in einem Cluster zu automatisieren, ohne eine erneute Authentifizierung durchführen zu müssen. Die Dateien werden in  `<user_home_directory>/.bluemix/plugins/container-service/clusters/<cluster_name>-admin` heruntergeladen. Dieser Wert ist optional.</dd>

   <dt><code>--export</code></dt>
   <dd>Laden Sie die Kubernetes-Konfigurationsdaten und -Zertifikate ohne Nachrichten außer dem Exportbefehl herunter. Da keine Nachrichten angezeigt werden, können Sie dieses Flag verwenden, wenn Sie automatisierte Scripts erstellen. Dieser Wert ist optional.</dd>
   </dl>

**Beispiel**:

```
bx cs cluster-config mein_cluster
```
{: pre}



### bx cs cluster-create [--file DATEISTANDORT][--hardware HARDWARE] --location STANDORT --machine-type MASCHINENTYP --name NAME [--kube-version MAJOR.MINOR.PATCH][--no-subnet] [--private-vlan PRIVATES_VLAN][--public-vlan PUBLIC_VLAN] [--workers WORKER][--disable-disk-encrypt]
{: #cs_cluster_create}

Erstellung eines Clusters in Ihrer Organisation.

<strong>Befehlsoptionen</strong>

<dl>
<dt><code>--file <em>DATEISTANDORT</em></code></dt>

<dd>Der Pfad zur YAML-Datei für die Erstellung Ihres Standardclusters. Statt die Merkmale Ihres Clusters mithilfe der in diesem Befehl bereitgestellten Optionen zu definieren, können Sie eine YAML-Datei verwenden. Dieser Wert ist für Standardcluster optional und steht für kostenlose Cluster nicht zur Verfügung.

<p><strong>Hinweis:</strong> Wenn Sie dieselbe Option wie im Befehl als Parameter in der YAML-Datei bereitstellen, hat der Wert im Befehl Vorrang vor dem Wert in der YAML. Beispiel: Sie definieren eine Position in Ihrer YAML-Datei und verwenden die Option <code>--location</code> im Befehl. Der Wert, den Sie in die Befehlsoption eingegeben haben, überschreibt den Wert in der YAML-Datei.

<pre class="codeblock">
<code>name: <em>&lt;clustername&gt;</em>
location: <em>&lt;standort&gt;</em>
no-subnet: <em>&lt;kein_teilnetz&gt;</em>
machine-type: <em>&lt;maschinentyp&gt;</em>
private-vlan: <em>&lt;privates_vlan&gt;</em>
public-vlan: <em>&lt;öffentliches_vlan&gt;</em>
hardware: <em>&lt;shared_oder_dedicated&gt;</em>
workerNum: <em>&lt;anzahl_worker&gt;</em>
kube-version: <em>&lt;kube-version&gt;</em>

</code></pre>


<table>
    <caption>Tabelle 1. Erklärung der Komponenten der YAML-Datei</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der YAML-Dateikomponenten</th>
    </thead>
    <tbody>
    <tr>
    <td><code><em>name</em></code></td>
    <td>Ersetzen Sie <code><em>&lt;clustername&gt;</em></code> durch den Namen Ihres Clusters.</td>
    </tr>
    <tr>
    <td><code><em>standort</em></code></td>
    <td>Ersetzen Sie <code><em>&lt;standort&gt;</em></code> durch den Standort, an dem Sie Ihren Cluster erstellen möchten. Welche Standorte verfügbar sind, hängt von der Region ab, bei der Sie angemeldet sind. Führen Sie den Befehl <code>bx cs locations</code> aus, um die verfügbaren Standorte aufzulisten. </td>
     </tr>
     <tr>
     <td><code><em>kein_teilnetz</em></code></td>
     <td>Standardmäßig werden sowohl ein öffentliches als auch ein privates portierbares Teilnetz in dem VLAN erstellt, das dem Cluster zugeordnet ist. Ersetzen Sie <code><em>&lt;no-subnet&gt;</em></code> durch <code><em>true</em></code>, um zu verhindern, dass Teilnetze für den Cluster erstellt werden. Sie können Teilnetze zu einem späteren Zeitpunkt [erstellen](#cs_cluster_subnet_create) oder zu einem Cluster [hinzufügen](#cs_cluster_subnet_add).</td>
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
     <tr>
      <td><code><em>kube-version</em></code></td>
      <td>Die Kubernetes-Version für den Cluster-Masterknoten. Dieser Wert ist optional. Wenn nicht anders angegeben, wird der Cluster mit dem Standard für unterstützte Kubernetes-Versionen erstellt. Führen Sie den Befehl <code>bx cs kube-versions</code> aus, um die verfügbaren Versionen anzuzeigen.</td></tr>
      <tr>
      <td><code>diskEncryption: <em>false</em></code></td>
      <td>Workerknoten weisen standardmäßig Verschlüsselung auf. [Weitere Informationen finden Sie hier](cs_secure.html#worker). Um die Verschlüsselung zu inaktivieren, schließen Sie diese Option ein und legen Sie den Wert auf <code>false</code> fest.</td></tr>
     </tbody></table>
    </p></dd>

<dt><code>--hardware <em>HARDWARE</em></code></dt>
<dd>Der Grad an Hardware-Isolation für Ihren Workerknoten. Verwenden Sie 'dedicated', wenn Sie verfügbare physische Ressourcen haben möchten, die nur Sie nutzen können, oder 'shared', um zuzulassen, dass physische Ressourcen mit anderen IBM Kunden gemeinsam genutzt werden können. Die Standardeinstellung ist 'shared'. Dieser Wert ist für Standardcluster optional und steht für kostenlose Cluster nicht zur Verfügung.</dd>

<dt><code>--location <em>STANDORT</em></code></dt>
<dd>Der Standort, an dem Sie den Cluster erstellen möchten. Welche Standorte Ihnen zur Verfügung stehen, hängt von der {{site.data.keyword.Bluemix_notm}}-Region ab, bei der Sie angemeldet sind. Wählen Sie die Region aus, die Ihrem Standort am nächsten ist, um eine optimale Leistung zu erhalten. Dieser Wert ist für Standardcluster erforderlich und für kostenlose Cluster optional.

<p>Überprüfen Sie die [verfügbaren Standorte](cs_regions.html#locations).
</p>

<p><strong>Hinweis:</strong> Beachten Sie bei der Auswahl eines Standorts außerhalb Ihres Landes, dass Sie gegebenenfalls eine gesetzliche Genehmigung benötigen, bevor Daten physisch in einem anderen Land gespeichert werden können.</p>
</dd>

<dt><code>--machine-type <em>MASCHINENTYP</em></code></dt>
<dd>Der Maschinentyp, den Sie auswählen, wirkt sich auf die Menge an Hauptspeicher und Plattenspeicher aus, die den in Ihrem Workerknoten bereitgestellten Containern zur Verfügung steht. Führen Sie [bx cs machine-types <em>STANDORT</em>](#cs_machine_types) aus, um verfügbare Maschinentypen aufzulisten. Dieser Wert ist für Standardcluster erforderlich und steht für kostenlose Cluster nicht zur Verfügung.</dd>

<dt><code>--name <em>NAME</em></code></dt>
<dd>Der Name für den Cluster.  Dieser Wert ist erforderlich.</dd>

<dt><code>--kube-version <em>MAJOR.MINOR.PATCH</em></code></dt>
<dd>Die Kubernetes-Version für den Cluster-Masterknoten. Dieser Wert ist optional. Wenn nicht anders angegeben, wird der Cluster mit dem Standard für unterstützte Kubernetes-Versionen erstellt. Führen Sie den Befehl <code>bx cs kube-versions</code> aus, um die verfügbaren Versionen anzuzeigen.</dd>

<dt><code>--no-subnet</code></dt>
<dd>Standardmäßig werden sowohl ein öffentliches als auch ein privates portierbares Teilnetz in dem VLAN erstellt, das dem Cluster zugeordnet ist. Schließen Sie das Flag <code>--no-subnet</code> ein, um zu verhindern, dass Teilnetze für den Cluster erstellt werden. Sie können Teilnetze zu einem späteren Zeitpunkt [erstellen](#cs_cluster_subnet_create) oder zu einem Cluster [hinzufügen](#cs_cluster_subnet_add).</dd>

<dt><code>--private-vlan <em>PRIVATES_VLAN</em></code></dt>
<dd>

<ul>
<li>Dieser Parameter ist für kostenlose Cluster nicht verfügbar.</li>
<li>Wenn dieser Standardcluster der erste Standardcluster ist, den Sie an diesem Standort erstellen, schließen Sie dieses Flag nicht ein. Ein privates VLAN wird zusammen mit den Clustern für Sie erstellt.</li>
<li>Wenn Sie bereits einen Standardcluster an diesem Standort oder ein privates VLAN in IBM Cloud Infrastructure (SoftLayer) erstellt haben, müssen Sie dieses private VLAN angeben.

<p><strong>Hinweis:</strong> Die öffentlichen und privaten VLANs, die Sie mit dem 'create'-Befehl angeben, müssen übereinstimmen. Private VLAN-Router beginnen immer mit <code>bcr</code> (Back-End-Router) und öffentliche VLAN-Router immer mit <code>fcr</code> (Front-End-Router). Die Zahlen- und Buchstabenkombination nach diesen Präfixen muss übereinstimmen, damit diese VLANs beim Erstellen eines Clusters verwendet werden können. Verwenden Sie keine abweichenden öffentlichen und privaten VLANs, um ein Cluster zu erstellen.</p></li>
</ul>

<p>Führen Sie <code>bx cs vlans <em>&lt;standort&gt;</em></code> aus, um herauszufinden, ob Sie bereits über ein privates VLAN für einen bestimmten Standort verfügen, oder um den Namen eines vorhandenen privaten VLANs zu erfahren.</p></dd>

<dt><code>--public-vlan <em>ÖFFENTLICHES_VLAN</em></code></dt>
<dd>
<ul>
<li>Dieser Parameter ist für kostenlose Cluster nicht verfügbar.</li>
<li>Wenn dieser Standardcluster der erste Standardcluster ist, den Sie an diesem Standort erstellen, verwenden Sie dieses Flag nicht. Ein öffentliches VLAN wird zusammen mit dem Cluster für Sie erstellt.</li>
<li>Wenn Sie bereits einen Standardcluster an diesem Standort oder ein öffentliches VLAN in IBM Cloud Infrastructure (SoftLayer) erstellt haben, müssen Sie dieses öffentliche VLAN angeben.

<p><strong>Hinweis:</strong> Die öffentlichen und privaten VLANs, die Sie mit dem 'create'-Befehl angeben, müssen übereinstimmen. Private VLAN-Router beginnen immer mit <code>bcr</code> (Back-End-Router) und öffentliche VLAN-Router immer mit <code>fcr</code> (Front-End-Router). Die Zahlen- und Buchstabenkombination nach diesen Präfixen muss übereinstimmen, damit diese VLANs beim Erstellen eines Clusters verwendet werden können. Verwenden Sie keine abweichenden öffentlichen und privaten VLANs, um ein Cluster zu erstellen.</p></li>
</ul>

<p>Führen Sie <code>bx cs vlans <em>&lt;standort&gt;</em></code> aus, um herauszufinden, ob Sie bereits über ein öffentliches VLAN für einen bestimmten Standort verfügen, oder um den Namen eines vorhandenen öffentlichen VLANs zu erfahren.</p></dd>

<dt><code>--workers WORKER</code></dt>
<dd>Die Anzahl von Workerknoten, die Sie in Ihrem Cluster bereitstellen wollen. Wenn Sie diese Option nicht angeben, wird ein Cluster mit einem Workerknoten erstellt. Dieser Wert ist für Standardcluster optional und steht für kostenlose Cluster nicht zur Verfügung.

<p><strong>Hinweis:</strong> Jedem Workerknoten werden eine eindeutige Workerknoten-ID und ein Domänenname zugeordnet, die nach dem Erstellen des Clusters nicht manuell geändert werden dürfen. Wenn die ID oder der Domänenname geändert wird, kann der Kubernetes-Master Ihren Cluster nicht mehr verwalten.</p></dd>

<dt><code>--disable-disk-encrypt</code></dt>
<dd>Workerknoten weisen standardmäßig Verschlüsselung auf. [Weitere Informationen finden Sie hier](cs_secure.html#worker). Wenn Sie die Verschlüsselung inaktivieren möchten, schließen Sie diese Option ein.</dd>
</dl>

**Beispiele**:

  

  Beispiel eines Standardclusters:
  {: #example_cluster_create}

  ```
  bx cs cluster-create --location dal10 --public-vlan meine_id_des_öffentlichen_vlan --private-vlan meine_id_des_privaten_vlan --machine-type u2c.2x4 --name mein_cluster --hardware shared --workers 2
  ```
  {: pre}

  Beispiel für einen kostenlosen Cluster:

  ```
  bx cs cluster-create --name mein_cluster
  ```
  {: pre}

  Beispiel für eine {{site.data.keyword.Bluemix_dedicated_notm}}-Umgebung:

  ```
  bx cs cluster-create --machine-type maschinentyp --workers anzahl --name clustername
  ```
  {: pre}


### bx cs cluster-get CLUSTER [--showResources]
{: #cs_cluster_get}

Anzeigen von Informationen zu einem Cluster in Ihrer Organisation.

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>

   <dt><code><em>--showResources</em></code></dt>
   <dd>Zeigt die VLANs und Teilnetze für einen Cluster an.</dd>
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

Zurverfügungstellung eines Teilnetzes in einem Konto von IBM Cloud Infrastructure (SoftLayer) für einen angegebenen Cluster.

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
  bx cs cluster-subnet-add mein_cluster teilnetz
  ```
  {: pre}

### bx cs cluster-subnet-create CLUSTER GRÖSSE VLAN-ID
{: #cs_cluster_subnet_create}

Erstellung eines Teilnetzes in einem Konto von IBM Cloud Infrastructure (SoftLayer) und Zurverfügungstellung dieses Teilnetzes für einen angegebenen Cluster in {{site.data.keyword.containershort_notm}}.

**Hinweis:** Wenn Sie ein Teilnetz in einem Cluster verfügbar machen, werden IP-Adressen dieses Teilnetzes zum Zweck von Clusternetzen verwendet. Vermeiden Sie IP-Adresskonflikte, indem Sie ein Teilnetz mit nur einem Cluster verwenden. Verwenden Sie kein Teilnetz für mehrere Cluster oder für andere
Zwecke außerhalb von {{site.data.keyword.containershort_notm}} gleichzeitig.

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich. Zum Auflisten Ihrer Cluster verwenden Sie den [Befehl](#cs_clusters) `bx cs clusters`.</dd>

   <dt><code><em>GRÖSSE</em></code></dt>
   <dd>Die Anzahl der IP-Teilnetzadressen. Dieser Wert ist erforderlich. Gültige Werte sind 8, 16, 32 oder 64.</dd>

   <dt><code><em>VLAN-ID</em></code></dt>
   <dd>Das VLAN, in dem das Teilnetz erstellt werden soll. Dieser Wert ist erforderlich. Verwenden Sie zum Auflisten der verfügbaren VLANs den [Befehl](#cs_vlans) `bx cs vlans <location>`.</dd>
   </dl>

**Beispiel**:

  ```
  bx cs cluster-subnet-create mein_cluster 8 1764905
  ```
  {: pre}

### bx cs cluster-user-subnet-add CLUSTER TEILNETZ-CIDR PRIVATES_VLAN
{: #cs_cluster_user_subnet_add}

Verwenden Sie das eigene private Teilnetz in Ihren {{site.data.keyword.containershort_notm}}-Clustern.

Dieses private Teilnetz wird nicht von IBM Cloud Infrastructure (SoftLayer) bereitgestellt. Deshalb müssen Sie das gesamte Routing für ein- und ausgehenden Netzverkehr für das Teilnetz konfigurieren. Wenn Sie ein Teilnetz von IBM Cloud Infrastructure (SoftLayer) hinzufügen möchten, dann verwenden Sie den [Befehl](#cs_cluster_subnet_add) `bx cs cluster-subnet-add`.

**Hinweis**: Wenn Sie ein privates Benutzerteilnetz zu einem Cluster hinzufügen, dann werden die IP-Adressen dieses Teilnetzes für private Lastausgleichsfunktionen im Cluster verwendet. Vermeiden Sie IP-Adresskonflikte, indem Sie ein Teilnetz mit nur einem Cluster verwenden. Verwenden Sie kein Teilnetz für mehrere Cluster oder für andere
Zwecke außerhalb von {{site.data.keyword.containershort_notm}} gleichzeitig.

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>

   <dt><code><em>TEILNETZ-CIDR</em></code></dt>
   <dd>Das CIDR (Classless InterDomain Routing) des Teilnetzes. Dieser Wert ist erforderlich und darf keinen Konflikt mit einem anderen Teilnetz verursachen, das von IBM Cloud Infrastructure (SoftLayer) verwendet wird.

   Die unterstützten Präfixe liegen zwischen `/30` (1 IP-Adresse) und `/24` (253 IP-Adressen). Wenn Sie das CIDR mit einer Präfixlänge festlegen und später ändern müssen, dann sollten Sie zuerst das neue CIDR hinzufügen und anschließend das [alte CIDR entfernen](#cs_cluster_user_subnet_rm).</dd>

   <dt><code><em>PRIVATES_VLAN</em></code></dt>
   <dd>Die ID des privaten VLAN. Dieser Wert ist erforderlich. Er muss mit der ID des privaten VLAN für mindestens einen Workerknoten im Cluster übereinstimmen.</dd>
   </dl>

**Beispiel**:

  ```
  bx cs cluster-user-subnet-add mein_cluster 192.168.10.0/29 1502175
  ```
  {: pre}


### bx cs cluster-user-subnet-rm CLUSTER TEILNETZ-CIDR PRIVATES_VLAN
{: #cs_cluster_user_subnet_rm}

Entfernen Sie Ihr eigenes privates Teilnetz aus einem angegebenen Cluster.

**Hinweis:** Jeder Service, der für eine IP-Adresse aus dem eigenen privaten Teilnetz bereitgestellt wurde, bleibt nach der Entfernung des Teilnetzes weiterhin aktiv.

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>

   <dt><code><em>TEILNETZ-CIDR</em></code></dt>
   <dd>Das CIDR (Classless InterDomain Routing) des Teilnetzes. Dieser Wert ist erforderlich und muss mit dem CIDR übereinstimmen, das mit dem [Befehl](#cs_cluster_user_subnet_add) `bx cs cluster-user-subnet-add` festgelegt wurde.</dd>

   <dt><code><em>PRIVATES_VLAN</em></code></dt>
   <dd>Die ID des privaten VLAN. Dieser Wert ist erforderlich und muss mit der VLAN-ID übereinstimmen, die mit dem [Befehl](#cs_cluster_user_subnet_add) `bx cs cluster-user-subnet-add` festgelegt wurde.</dd>
   </dl>

**Beispiel**:

  ```
  bx cs cluster-user-subnet-rm mein_cluster 192.168.10.0/29 1502175
  ```
  {: pre}


### bx cs cluster-update [-f] CLUSTER [--kube-version MAJOR.MINOR.PATCH][--force-update]
{: #cs_cluster_update}

Aktualisieren Sie den Kubernetes-Master auf die API-Standardversion. Während der Aktualisierung können Sie weder auf den Cluster zugreifen noch eine Änderung am Cluster vornehmen. Workerknoten, Apps und Ressourcen, die vom Benutzer bereitgestellt wurden, werden nicht geändert und weiterhin ausgeführt.

Möglicherweise müssen Sie Ihre YAML-Dateien für zukünftige Bereitstellungen ändern. Lesen Sie die detaillierten Informationen in diesen [Releaseinformationen](cs_versions.html).

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>

   <dt><code>--kube-version <em>MAJOR.MINOR.PATCH</em></code></dt>
   <dd>Die Kubernetes-Version des Clusters. Wenn dieses Flag nicht angegeben ist, wird der Kubernetes-Master auf die API-Standardversion aktualisiert. Führen Sie den Befehl [bx cs kube-versions](#cs_kube_versions) aus, um die verfügbaren Versionen anzuzeigen. Dieser Wert ist optional.</dd>

   <dt><code>-f</code></dt>
   <dd>Geben Sie diese Option an, um die Aktualisierung des Masters ohne Benutzereingabeaufforderungen zu erzwingen. Dieser Wert ist optional.</dd>

   <dt><code>--force-update</code></dt>
   <dd>Versuch einer Aktualisierung, selbst wenn die Änderung sich über mehr als zwei Nebenversionen erstreckt. Dieser Wert ist optional.</dd>
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

Festlegen von Berechtigungsnachweisen für das Konto von IBM Cloud Infrastructure (SoftLayer) für Ihr {{site.data.keyword.Bluemix_notm}}-Konto. Mit diesen Berechtigungsnachweisen können Sie über Ihr {{site.data.keyword.Bluemix_notm}}-Konto auf das Portfolio von IBM Cloud Infrastructure (SoftLayer) zugreifen.

**Hinweis:** Das Festlegen mehrerer Berechtigungsnachweise für ein {{site.data.keyword.Bluemix_notm}}-Konto ist nicht zulässig. Jedes {{site.data.keyword.Bluemix_notm}}-Konto ist nur mit einem Portfolio von IBM Cloud Infrastructure (SoftLayer) verbunden.

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code>--infrastructure-username <em>BENUTZERNAME</em></code></dt>
   <dd>Der Benutzername für ein Konto von IBM Cloud Infrastructure (SoftLayer). Dieser Wert ist erforderlich.</dd>


   <dt><code>--infrastructure-api-key <em>API-SCHLÜSSEL</em></code></dt>
   <dd>Der API-Schlüssel für ein Konto von IBM Cloud Infrastructure (SoftLayer). Dieser Wert ist erforderlich.

 <p>
  Gehen Sie wie folgt vor, um einen API-Schlüssel zu generieren:

  <ol>
  <li>Melden Sie sich beim [Portal von IBM Cloud Infrastructure (SoftLayer) ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://control.softlayer.com/) an.</li>
  <li>Wählen Sie <strong>Konto</strong> und dann <strong>Benutzer</strong> aus.</li>
  <li>Klicken Sie auf <strong>Generieren</strong>, um einen API-Schlüssel von IBM Cloud Infrastructure (SoftLayer) für Ihr Konto zu generieren.</li>
  <li>Kopieren Sie den API-Schlüssel, um diesen Befehl verwenden zu können.</li>
  </ol>

  Gehen Sie wie folgt vor, um Ihren API-Schlüssel anzuzeigen:
  <ol>
  <li>Melden Sie sich beim [Portal von IBM Cloud Infrastructure (SoftLayer) ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://control.softlayer.com/) an.</li>
  <li>Wählen Sie <strong>Konto</strong> und dann <strong>Benutzer</strong> aus.</li>
  <li>Klicken Sie auf <strong>Anzeigen</strong>, um den bestehenden API-Schlüssel anzuzeigen.</li>
  <li>Kopieren Sie den API-Schlüssel, um diesen Befehl verwenden zu können.</li>
  </ol>
  </p></dd>
  </dl>

**Beispiel**:

  ```
  bx cs credentials-set --infrastructure-api-key API-SCHLÜSSEL --infrastructure-username BENUTZERNAME
  ```
  {: pre}


### bx cs credentials-unset
{: #cs_credentials_unset}

Entfernen Sie die Kontoberechtigungsnachweise von IBM Cloud Infrastructure (SoftLayer) aus Ihrem {{site.data.keyword.Bluemix_notm}}-Konto. Nachdem Sie die Berechtigungsnachweise entfernt haben, können Sie über Ihr {{site.data.keyword.Bluemix_notm}}-Konto nicht mehr auf das Portfolio von IBM Cloud Infrastructure (SoftLayer) zugreifen.

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
   <dd>Der zu verwendende {{site.data.keyword.containershort_notm}}-API-Endpunkt.  Dieser Wert ist optional. [Zeigen Sie die verfügbaren API-Endpunktwerte an.](cs_regions.html#container_regions)</dd>
   </dl>



```
bx cs init --host https://uk-south.containers.bluemix.net
```
{: pre}

### bx cs kube-versions
{: #cs_kube_versions}

Anzeigen einer Liste der Kubernetes-Versionen, die in {{site.data.keyword.containershort_notm}} unterstützt werden. Aktualisieren Sie den [Cluster-Master](#cs_cluster_update) und die [Workerknoten](#cs_worker_update) auf die Standardversion für die aktuellen und stabilen Leistungsmerkmale.

**Befehlsoptionen**:

  Keine

**Beispiel**:

  ```
  bx cs kube-versions
  ```
  {: pre}

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

### bx cs logging-config-create CLUSTER --logsource PROTOKOLLQUELLE [--namespace KUBERNETES-NAMENSBEREICH][--hostname LOG_SERVER_HOSTNAME_OR_IP] [--port PROTOKOLLSERVER-PORT][--space CLUSTER_SPACE] [--org CLUSTERORG] --type PROTOKOLLTYP [--json]
{: #cs_logging_create}

Erstellen Sie eine Protokollierungskonfiguration. Sie können diesen Befehl verwenden, um Protokolle für Container, Anwendungen, Workerknoten, Kubernetes-Cluster und Ingress-Lastausgleichsfunktionen für Anwendungen an {{site.data.keyword.loganalysisshort_notm}} oder an einen externen Systemprotokollserver weiterzuleiten.

<strong>Befehlsoptionen</strong>:

<dl>
<dt><code><em>CLUSTER</em></code></dt>
<dd>Der Name oder die ID des Clusters.</dd>
<dt><code>--logsource <em>PROTOKOLLQUELLE</em></code></dt>
<dd>Die Protokollquelle, für die Sie die Protokollweiterleitung aktivieren möchten. Gültige Werte sind <code>container</code>, <code>application</code>, <code>worker</code>, <code>kubernetes</code> und <code>ingress</code>. Dieser Wert ist erforderlich.</dd>
<dt><code>--namespace <em>KUBERNETES-NAMENSBEREICH</em></code></dt>
<dd>Der Namensbereich für Docker-Container, von dem aus Protokolle weitergeleitet werden sollen. Die Weiterleitung von Protokollen wird für die Kubernetes-Namensbereiche <code>ibm-system</code> und <code>kube-system</code> nicht unterstützt. Dieser Wert ist nur für die Containerprotokollquelle gültig und optional. Wenn Sie keinen Namensbereich angeben, verwenden alle Namensbereiche im Container diese Konfiguration.</dd>
<dt><code>--hostname <em>PROTOKOLLSERVER-HOSTNAME</em></code></dt>
<dd>Wenn der Protokollierungstyp <code>syslog</code> lautet, der Hostname oder die IP-Adresse des Protokollcollector-Servers. Dieser Wert ist für <code>syslog</code> erforderlich. Wenn der Protokollierungstyp <code>ibm</code> lautet, die {{site.data.keyword.loganalysislong_notm}}-Einpflege-URL. Sie finden die Liste von verfügbaren Einpflege-URLs [hier](/docs/services/CloudLogAnalysis/log_ingestion.html#log_ingestion_urls). Wenn Sie keine Einpflege-URL angeben, wird der Endpunkt für die Region, in der Ihr Cluster erstellt wurde, verwendet.</dd>
<dt><code>--port <em>PROTOKOLLSERVER-PORT</em></code></dt>
<dd>Der Port des Protokollcollector-Servers. Dieser Wert ist optional. Wenn Sie keinen Port angeben, wird der Standardport <code>514</code> für <code>syslog</code> und der Standardport <code>9091</code> für <code>ibm</code> verwendet.</dd>
<dt><code>--space <em>CLUSTERBEREICH</em></code></dt>
<dd>Der Name des Bereichs, an den Protokolle gesendet werden sollen. Dieser Wert ist nur für den Protokolltyp <code>ibm</code> gültig und optional. Wenn Sie keinen Bereich angeben, werden Protokolle an die Kontoebene gesendet.</dd>
<dt><code>--org <em>CLUSTERORG</em></code></dt>
<dd>Der Name der Organisation, in der sich der Bereich befindet. Dieser Wert ist nur für den Protokolltyp <code>ibm</code> gültig und erforderlich, wenn Sie einen Bereich angegeben haben.</dd>
<dt><code>--type <em>PROTOKOLLTYP</em></code></dt>
<dd>Das Protokollweiterleitungsprotokoll, das Sie verwenden möchten. Momentan werden <code>syslog</code> und <code>ibm</code> unterstützt. Dieser Wert ist erforderlich.</dd>
<dt><code>--json</code></dt>
<dd>Druckt die Befehlsausgabe optional im JSON-Format.</dd>
</dl>

**Beispiele**:

Beispiel für Protokolltyp `ibm`, der aus einer `container`-Protokollquelle am Standardport 9091 weiterleitet:

  ```
  bx cs logging-config-create mein_cluster --logsource container --namespace mein_namensbereich --hostname ingest.logging.ng.bluemix.net --type ibm
  ```
  {: pre}

Beispiel für Protokolltyp `syslog`, der aus einer `container`-Protokollquelle am Standardport 514 weiterleitet:

  ```
  bx cs logging-config-create mein_cluster --logsource container --namespace mein_namensbereich  --hostname mein_hostname_oder_meine_IP --type syslog
  ```
  {: pre}

  Beispiel für Protokolltyp `syslog`, der Protokolle aus einer `ingress`-Quelle an einen anderen Port als den Standardport weiterleitet:

    ```
    bx cs logging-config-create mein_cluster --logsource container --hostname mein_hostname_oder_meine_IP --port 5514 --type syslog
    ```
    {: pre}

### bx cs logging-config-get CLUSTER [--logsource PROTOKOLLQUELLE][--json]
{: #cs_logging_get}

Zeigen Sie alle Protokollweiterleitungskonfigurationen für einen Cluster an oder filtern Sie die Protokollierungskonfigurationen auf Basis der Protokollquelle.

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>
   <dt><code>--logsource <em>PROTOKOLLQUELLE</em></code></dt>
   <dd>Die Art der Protokollquelle, für die die Filterung durchgeführt werden soll. Nur Protokollierungskonfigurationen dieser Protokollquelle im Cluster werden zurückgegeben. Gültige Werte sind <code>container</code>, <code>application</code>, <code>worker</code>, <code>kubernetes</code> und <code>ingress</code>. Dieser Wert ist optional.</dd>
   <dt><code>--json</code></dt>
   <dd>Druckt die Befehlsausgabe optional im JSON-Format.</dd>
   </dl>

**Beispiel**:

  ```
  bx cs logging-config-get mein_cluster --logsource worker
  ```
  {: pre}


### bx cs logging-config-rm CLUSTER PROTOKOLLKONFIGURATIONS-ID
{: #cs_logging_rm}

Löscht eine Protokollweiterleitungskonfiguration. Dies stoppt die Protokollweiterleitung an einen Systemprotokollserver bzw. an {{site.data.keyword.loganalysisshort_notm}}.

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>
   <dt><code><em>PROTOKOLLKONFIGURATIONS-ID</em></code></dt>
   <dd>Die ID der Protokollierungskonfiguration, die aus der Protokollquelle entfernt werden soll. Dieser Wert ist erforderlich.</dd>
   </dl>

**Beispiel**:

  ```
  bx cs logging-config-rm mein_cluster f4bc77c0-ee7d-422d-aabf-a4e6b977264e
  ```
  {: pre}


### bx cs logging-config-update CLUSTER PROTOKOLLKONFIGURATIONS-ID [--hostname PROTOKOLLSERVER-HOSTNAME_ODER_-IP][--port LOG_SERVER_PORT] [--space CLUSTERBEREICH][--org CLUSTER_ORG] --type PROTOKOLLTYP [--json]
{: #cs_logging_update}

Aktualisieren Sie die Details einer Protokollweiterleitungskonfiguration.

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>
   <dt><code><em>PROTOKOLLKONFIGURATIONS-ID</em></code></dt>
   <dd>Die ID der Protokollierungskonfiguration, die aktualisiert werden soll. Dieser Wert ist erforderlich.</dd>
   <dt><code>--hostname <em>PROTOKOLLSERVER-HOSTNAME</em></code></dt>
   <dd>Wenn der Protokollierungstyp <code>syslog</code> lautet, der Hostname oder die IP-Adresse des Protokollcollector-Servers. Dieser Wert ist für <code>syslog</code> erforderlich. Wenn der Protokollierungstyp <code>ibm</code> lautet, die {{site.data.keyword.loganalysislong_notm}}-Einpflege-URL. Sie finden die Liste von verfügbaren Einpflege-URLs [hier](/docs/services/CloudLogAnalysis/log_ingestion.html#log_ingestion_urls). Wenn Sie keine Einpflege-URL angeben, wird der Endpunkt für die Region, in der Ihr Cluster erstellt wurde, verwendet.</dd>
   <dt><code>--port <em>PROTOKOLLSERVER-PORT</em></code></dt>
   <dd>Der Port des Protokollcollector-Servers. Dieser Wert ist optional, wenn der Protokollierungstyp <code>syslog</code> lautet. Wenn Sie keinen Port angeben, wird der Standardport <code>514</code> für <code>syslog</code> und <code>9091</code> für <code>ibm</code> verwendet.</dd>
   <dt><code>--space <em>CLUSTERBEREICH</em></code></dt>
   <dd>Der Name des Bereichs, an den Protokolle gesendet werden sollen. Dieser Wert ist nur für den Protokolltyp <code>ibm</code> gültig und optional. Wenn Sie keinen Bereich angeben, werden Protokolle an die Kontoebene gesendet.</dd>
   <dt><code>--org <em>CLUSTERORG</em></code></dt>
   <dd>Der Name der Organisation, in der sich der Bereich befindet. Dieser Wert ist nur für den Protokolltyp <code>ibm</code> gültig und erforderlich, wenn Sie einen Bereich angegeben haben.</dd>
   <dt><code>--type <em>PROTOKOLLTYP</em></code></dt>
   <dd>Das Protokollweiterleitungsprotokoll, das Sie verwenden möchten. Momentan werden <code>syslog</code> und <code>ibm</code> unterstützt. Dieser Wert ist erforderlich.</dd>
   <dt><code>--json</code></dt>
   <dd>Druckt die Befehlsausgabe optional im JSON-Format.</dd>
   </dl>

**Beispiel für Protokolltyp `ibm`**:

  ```
  bx cs logging-config-update mein_cluster f4bc77c0-ee7d-422d-aabf-a4e6b977264e --type ibm
  ```
  {: pre}

**Beispiel für Protokolltyp `syslog`**:

  ```
  bx cs logging-config-update mein_cluster f4bc77c0-ee7d-422d-aabf-a4e6b977264e --hostname localhost --port 5514 --type syslog
  ```
  {: pre}


### bx cs machine-types STANDORT
{: #cs_machine_types}

Anzeige einer Liste der für Ihre Workerknoten verfügbaren Maschinentypen. Jeder Maschinentyp enthält die Menge an virtueller CPU, an Hauptspeicher und an Plattenspeicher für jeden Workerknoten im Cluster.
- Maschinentypen mit `u2c` oder `b2c` im Namen verwenden anstelle von Storage Area Networking (SAN) die lokale Festplatte für mehr Zuverlässigkeit. Zu den Vorteilen zählen ein höherer Durchsatz beim Serialisieren von Bytes für die lokale Festplatte und weniger Beeinträchtigungen des Dateisystems aufgrund von Netzausfällen. Diese Maschinentypen weisen 25 GB lokalen Plattenspeicher für das Dateisystem des Betriebssystems auf und 100 GB lokalen Plattenspeicher für `/var/lib/docker`, dem Verzeichnis, in das alle Containerdaten geschrieben werden.
- Maschinentypen mit `encrypted` im Namen verschlüsseln die Dockerdaten des Hosts. Das Verzeichnis `/var/lib/docker`, in dem alle Containerdaten gespeichert sind, ist mit der LUKS-Verschlüsselung verschlüsselt.
- Maschinentypen mit `u1c` oder `b1c` im Namen, wie `u1c.2x4`, werden nicht mehr verwendet. Um die Maschinentypen `u2c` und `b2c` zu verwenden, setzen Sie den Befehl `bx cs worker-add` ab, um Workerknoten mit dem aktualisierten Maschinentyp hinzuzufügen. Entfernen Sie dann die Workerknoten, die die veralteten Maschinentypen verwenden, mithilfe des Befehls `bx cs worker-rm`.
</p>


<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code><em>STANDORT</em></code></dt>
   <dd>Geben Sie den Standort ein, an dem Sie verfügbare Maschinentypen auflisten möchten. Dieser Wert ist erforderlich. Überprüfen Sie die [verfügbaren Standorte](cs_regions.html#locations).</dd></dl>

**Beispiel**:

  ```
  bx cs machine-types dal10
  ```
  {: pre}

### bx cs region
{: #cs_region}

Suchen Sie nach der {{site.data.keyword.containershort_notm}}-Region, in der Sie sich aktuell befinden. Sie erstellen und verwalten Cluster, die für diese Region spezifisch sind. Verwenden Sie den Befehl `bx cs region-set`, um die Region zu ändern.

**Beispiel**:

```
bx cs region
```
{: pre}

**Ausgabe**:
```
Region: us-south
```
{: screen}

### bx cs region-set [REGION]
{: #cs_region-set}

Legen Sie die Region für {{site.data.keyword.containershort_notm}} fest. Sie erstellen und verwalten Cluster, die für die Region spezifisch sind, und benötigen zum Zwecke der Hochverfügbarkeit unter Umständen Cluster in mehreren Regionen.

Sie können sich beispielsweise bei {{site.data.keyword.Bluemix_notm}} in der Region 'Vereinigte Staaten (Süden)' anmelden und einen Cluster erstellen. Anschließend können Sie `bx cs region-set eu-central` verwenden, um die Region 'Zentraleuropa' als Ziel festzulegen, und einen weiteren Cluster erstellen. Und schließlich können Sie `bx cs region-set us-south` verwenden, um zur Region 'Vereinigte Staaten (Süden)' zurückzukehren und Ihren Cluster in dieser Region zu verwalten.

**Befehlsoptionen**:

<dl>
<dt><code><em>REGION</em></code></dt>
<dd>Geben Sie die Region ein, die Sie als Ziel festlegen möchten. Dieser Wert ist optional. Wenn Sie die Region nicht angeben, können Sie sie aus der Liste in der Ausgabe auswählen.

Eine Liste von verfügbaren Regionen finden Sie unter [Regionen und Standorte](cs_regions.html). Oder setzen Sie den [Befehl](#cs_regions) `bx cs regions` ab.</dd></dl>

**Beispiel**:

```
bx cs region-set eu-central
```
{: pre}

```
bx cs region-set
```
{: pre}

**Ausgabe**:
```
Choose a region:
1. ap-north
2. ap-south
3. eu-central
4. uk-south
5. us-east
6. us-south
Enter a number> 3
OK
```
{: screen}

### bx cs regions
{: #cs_regions}

Listet die verfügbaren Regionen auf. Der `Region Name` ist der {{site.data.keyword.containershort_notm}}-Name und der `Region Alias` ist der allgemeine {{site.data.keyword.Bluemix_notm}}-Name für die Region.

**Beispiel**:

```
bx cs regions
```
{: pre}

**Ausgabe**:
```
Region Name   Region Alias
ap-north      jp-tok
ap-south      au-syd
eu-central    eu-de
uk-south      eu-gb
us-east       us-east
us-south      us-south
```
{: screen}

### bx cs subnets
{: #cs_subnets}

Anzeigen einer Liste der Teilnetze, die in einem Konto von IBM Cloud Infrastructure (SoftLayer) verfügbar sind.

<strong>Befehlsoptionen</strong>:

   Keine

**Beispiel**:

  ```
  bx cs subnets
  ```
  {: pre}


### bx cs vlans STANDORT
{: #cs_vlans}

Auflisten der öffentlichen und der privaten VLANs, die für einen Standort in Ihrem Konto von IBM Cloud Infrastructure (SoftLayer) zur Verfügung stehen. Um verfügbare VLANs auflisten zu können, müssen Sie über ein gebührenpflichtiges Konto verfügen.

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code><em>STANDORT</em></code></dt>
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


### bx cs worker-add --cluster CLUSTER [--file DATEISTANDORT][--hardware HARDWARE] --machine-type MASCHINENTYP --number ANZAHL --private-vlan PRIVATES_VLAN --public-vlan ÖFFENTLICHES_VLAN [--disable-disk-encrypt]
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
<code>name: <em>&lt;clustername_oder_-id&gt;</em>
location: <em>&lt;standort&gt;</em>
machine-type: <em>&lt;maschinentyp&gt;</em>
private-vlan: <em>&lt;privates_vlan&gt;</em>
public-vlan: <em>&lt;öffentliches_vlan&gt;</em>
hardware: <em>&lt;shared_oder_dedicated&gt;</em>
workerNum: <em>&lt;anzahl_worker&gt;</em>
</code></pre>

<table>
<caption>Tabelle 2. Erklärung der Komponenten der YAML-Datei</caption>
<thead>
<th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der YAML-Dateikomponenten</th>
</thead>
<tbody>
<tr>
<td><code><em>name</em></code></td>
<td>Ersetzen Sie <code><em>&lt;clustername_oder_-id&gt;</em></code> durch den Namen oder die ID des Clusters, in dem Sie Workerknoten hinzufügen möchten.</td>
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
<tr>
<td><code>diskEncryption: <em>false</em></code></td>
<td>Workerknoten weisen standardmäßig Verschlüsselung auf. [Weitere Informationen finden Sie hier](cs_secure.html#worker). Um die Verschlüsselung zu inaktivieren, schließen Sie diese Option ein und legen Sie den Wert auf <code>false</code> fest.</td></tr>
</tbody></table></p></dd>

<dt><code>--hardware <em>HARDWARE</em></code></dt>
<dd>Der Grad an Hardware-Isolation für Ihren Workerknoten. Verwenden Sie 'dedicated', wenn Sie verfügbare physische Ressourcen haben möchten, die nur Sie nutzen können, oder 'shared', um zuzulassen, dass physische Ressourcen mit anderen IBM Kunden gemeinsam genutzt werden können. Die Standardeinstellung ist 'shared'. Dieser Wert ist optional.</dd>

<dt><code>--machine-type <em>MASCHINENTYP</em></code></dt>
<dd>Der Maschinentyp, den Sie auswählen, wirkt sich auf die Menge an Hauptspeicher und Plattenspeicher aus, die den in Ihrem Workerknoten bereitgestellten Containern zur Verfügung steht. Dieser Wert ist erforderlich. Führen Sie [bx cs machine-types STANDORT](#cs_machine_types) aus, um verfügbare Maschinentypen aufzulisten.</dd>

<dt><code>--number <em>ANZAHL</em></code></dt>
<dd>Die durch eine Ganzzahl angegebene Anzahl der Workerknoten, die im Cluster erstellt werden sollen. Der Standardwert ist 1. Dieser Wert ist optional.</dd>

<dt><code>--private-vlan <em>PRIVATES_VLAN</em></code></dt>
<dd>Das private VLAN, das bei der Erstellung des Clusters angegeben wurde. Dieser Wert ist erforderlich.

<p><strong>Hinweis:</strong> Die öffentlichen und privaten VLANs, die Sie angeben, müssen übereinstimmen. Private VLAN-Router beginnen immer mit <code>bcr</code> (Back-End-Router) und öffentliche VLAN-Router immer mit <code>fcr</code> (Front-End-Router). Die Zahlen- und Buchstabenkombination nach diesen Präfixen muss übereinstimmen, damit diese VLANs beim Erstellen eines Clusters verwendet werden können. Verwenden Sie keine abweichenden öffentlichen und privaten VLANs, um ein Cluster zu erstellen.</p></dd>

<dt><code>--public-vlan <em>ÖFFENTLICHES_VLAN</em></code></dt>
<dd>Das öffentliche VLAN, das bei der Erstellung des Clusters angegeben wurde. Dieser Wert ist optional.

<p><strong>Hinweis:</strong> Die öffentlichen und privaten VLANs, die Sie angeben, müssen übereinstimmen. Private VLAN-Router beginnen immer mit <code>bcr</code> (Back-End-Router) und öffentliche VLAN-Router immer mit <code>fcr</code> (Front-End-Router). Die Zahlen- und Buchstabenkombination nach diesen Präfixen muss übereinstimmen, damit diese VLANs beim Erstellen eines Clusters verwendet werden können. Verwenden Sie keine abweichenden öffentlichen und privaten VLANs, um ein Cluster zu erstellen.</p></dd>

<dt><code>--disable-disk-encrypt</code></dt>
<dd>Workerknoten weisen standardmäßig Verschlüsselung auf. [Weitere Informationen finden Sie hier](cs_secure.html#worker). Wenn Sie die Verschlüsselung inaktivieren möchten, schließen Sie diese Option ein.</dd>
</dl>

**Beispiele**:

  ```
  bx cs worker-add --cluster mein_cluster --number 3 --public-vlan meine_id_des_öffentlichen_vlan --private-vlan meine_id_des_privaten_vlan --machine-type u2c.2x4 --hardware shared
  ```
  {: pre}

  Beispiel für {{site.data.keyword.Bluemix_dedicated_notm}}:

  ```
  bx cs worker-add --cluster mein_cluster --number 3 --maschinentyp u2c.2x4
  ```
  {: pre}


### bx cs worker-get [CLUSTERNAME_ODER_-ID] WORKERKNOTEN-ID
{: #cs_worker_get}

Anzeigen der Details eines Workerknotens.

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code><em>CLUSTERNAME_ODER_-ID</em></code></dt>
   <dd>Der Name oder die ID des Workerknotenclusters. Dieser Wert ist optional.</dd>
   <dt><code><em>WORKERKNOTEN-ID</em></code></dt>
   <dd>Die ID für einen Workerknoten. Führen Sie den Befehl <code>bx cs workers <em>CLUSTER</em></code> aus, um die IDs für die Workerknoten in einem Cluster anzuzeigen. Dieser Wert ist erforderlich.</dd>
   </dl>

**Beispiel**:

  ```
  bx cs worker-get [CLUSTERNAME_ODER_-ID] WORKERKNOTEN_ID
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

   <dt><code><em>WORKER</em></code></dt>
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

   <dt><code><em>WORKER</em></code></dt>
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

   <dt><code><em>WORKER</em></code></dt>
   <dd>Der Name oder die ID einzelner oder mehrerer Workerknoten. Trennen Sie bei einer Auflistung mehrerer Workerknoten die einzelnen Auflistungselemente jeweils durch ein Leerzeichen. Dieser Wert ist erforderlich.</dd>
   </dl>

**Beispiel**:

  ```
  bx cs worker-rm mein_cluster mein_knoten1 mein_knoten2
  ```
  {: pre}

### bx cs worker-update [-f] CLUSTER WORKER [WORKER][--kube-version MAJOR.MINOR.PATCH] [--force-update]
{: #cs_worker_update}

Aktualisieren Sie die Workerknoten auf die aktuellste Kubernetes-Version. Durch die Ausführung von `bx cs worker-update` kann es zu Ausfallzeiten bei Ihren Apps und Services kommen. Während der Aktualisierung wird die Planung aller Pods auf anderen Workerknoten neu erstellt und die Daten werden gelöscht, wenn sie nicht außerhalb des Pods gespeichert wurden. Um Ausfallzeiten zu vermeiden, sollten Sie sicherstellen, dass genügend Workerknoten vorhanden sind, um die Arbeitslast zu verarbeiten, während für die ausgewählten Workerknoten eine Aktualisierung durchgeführt wird.

Möglicherweise müssen Sie Ihre YAML-Dateien für Bereitstellungen vor der Aktualisierung ändern. Lesen Sie die detaillierten Informationen in diesen [Releaseinformationen](cs_versions.html).

<strong>Befehlsoptionen</strong>:

   <dl>

   <dt><em>CLUSTER</em></dt>
   <dd>Der Name oder die ID des Clusters, in dem Sie verfügbare Workerknoten auflisten. Dieser Wert ist erforderlich.</dd>

   <dt><code>--kube-version <em>MAJOR.MINOR.PATCH</em></code></dt>
   <dd>Die Kubernetes-Version des Clusters. Wenn dieses Flag nicht angegeben ist, wird der Workerknoten auf die Standardversion aktualisiert. Führen Sie den Befehl [bx cs kube-versions](#cs_kube_versions) aus, um die verfügbaren Versionen anzuzeigen. Dieser Wert ist optional.</dd>

   <dt><code>-f</code></dt>
   <dd>Geben Sie diese Option an, um die Aktualisierung des Masters ohne Benutzereingabeaufforderungen zu erzwingen. Dieser Wert ist optional.</dd>

   <dt><code>--force-update</code></dt>
   <dd>Versuch einer Aktualisierung, selbst wenn die Änderung sich über mehr als zwei Nebenversionen erstreckt. Dieser Wert ist optional.</dd>

   <dt><code><em>WORKER</em></code></dt>
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

<br />

