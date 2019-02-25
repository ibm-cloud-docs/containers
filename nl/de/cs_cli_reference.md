---

copyright:
  years: 2014, 2018
lastupdated: "2018-12-05"

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



# Befehlsreferenz
{: #cs_cli_reference}

Verwenden Sie diese Befehle, um Kubernetes-Cluster im {{site.data.keyword.containerlong}} zu erstellen und zu verwalten.
{:shortdesc}

Informationen zum Installieren des CLI-Plug-ins finden Sie im Abschnitt [CLI installieren](cs_cli_install.html#cs_cli_install_steps).

Sie werden im Terminal benachrichtigt, wenn Aktualisierungen für die `ibmcloud`-CLI und -Plug-ins verfügbar sind. Halten Sie Ihre CLI stets aktuell, sodass Sie alle verfügbaren Befehle und Flags verwenden können.

Suchen Sie nach `ibmcloud cr`-Befehlen? Werfen Sie einen Blick in die [{{site.data.keyword.registryshort_notm}}-CLI-Referenz ](/docs/container-registry-cli-plugin/container-registry-cli.html#containerregcli). Suchen Sie nach `kubectl`-Befehlen? Werfen Sie einen Blick in die [Kubernetes-Dokumentation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/reference/kubectl/overview/).
{:tip}

## ibmcloud ks-Befehle
{: #cs_commands}

**Tipp:** Sie können die Version des {{site.data.keyword.containerlong_notm}}-Plug-ins abrufen, indem Sie den folgenden Befehl ausführen.

```
ibmcloud plugin list
```
{: pre}



<table summary="Tabelle mit API-Befehlen">
<caption>API-Befehle</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>API-Befehle</th>
 </thead>
 <tbody>
  <tr>
    <td>[ibmcloud ks api](#cs_api)</td>
    <td>[ibmcloud ks api-key-info](#cs_api_key_info)</td>
    <td>[ibmcloud ks api-key-reset](#cs_api_key_reset)</td>
    <td>[ibmcloud ks apiserver-config-get](#cs_apiserver_config_get)</td>
  </tr>
  <tr>
    <td>[ibmcloud ks apiserver-config-set](#cs_apiserver_config_set)</td>
    <td>[ibmcloud ks apiserver-config-unset](#cs_apiserver_config_unset)</td>
    <td>[ibmcloud ks apiserver-refresh](#cs_apiserver_refresh)</td>
    <td></td>
 </tr>
</tbody>
</table>

<br>

<table summary="Tabelle mit Befehlen für die Verwendung des CLI-Plug-ins">
<caption>Befehle für die Verwendung des CLI-Plug-ins</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>Befehle für die Verwendung des CLI-Plug-ins</th>
 </thead>
 <tbody>
  <tr>
    <td>[ibmcloud ks help](#cs_help)</td>
    <td>[ibmcloud ks init](#cs_init)</td>
    <td>[ibmcloud ks messages](#cs_messages)</td>
    <td></td>
  </tr>
</tbody>
</table>

<br>

<table summary="Clusterbefehle: Tabelle mit Managementbefehlen">
<caption>Clusterbefehle: Managementbefehle</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>Clusterbefehle: Management</th>
 </thead>
 <tbody>
  <tr>
    <td>[ibmcloud ks cluster-config](#cs_cluster_config)</td>
    <td>[ibmcloud ks cluster-create](#cs_cluster_create)</td>
    <td>[ibmcloud ks cluster-feature-enable](#cs_cluster_feature_enable)</td>
    <td>[ibmcloud ks cluster-get](#cs_cluster_get)</td>
  </tr>
  <tr>
    <td>[ibmcloud ks cluster-refresh](#cs_cluster_refresh)</td>
    <td>[ibmcloud ks cluster-rm](#cs_cluster_rm)</td>
    <td>[ibmcloud ks cluster-update](#cs_cluster_update)</td>
    <td>[ibmcloud ks clusters](#cs_clusters)</td>
  </tr>
  <tr>
    <td>[ibmcloud ks kube-versions](#cs_kube_versions)</td>
    <td> </td>
    <td> </td>
    <td> </td>
  </tr>
</tbody>
</table>

<br>

<table summary="Clusterbefehle: Tabelle mit Befehlen für Services und Integrationen">
<caption>Clusterbefehle: Befehle für Services und Integrationen</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>Clusterbefehle: Services und Integrationen</th>
 </thead>
 <tbody>
  <tr>
    <td>[ibmcloud ks cluster-service-bind](#cs_cluster_service_bind)</td>
    <td>[ibmcloud ks cluster-service-unbind](#cs_cluster_service_unbind)</td>
    <td>[ibmcloud ks cluster-services](#cs_cluster_services)</td>
    <td>[ibmcloud ks va](#cs_va)</td>
  </tr>
    <td>[ibmcloud ks webhook-create](#cs_webhook_create)</td>
  <tr>
  </tr>
</tbody>
</table>

</br>

<table summary="Clusterbefehle: Tabelle mit Befehlen für Teilnetze">
<caption>Clusterbefehle: Befehle für Teilnetze</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>Clusterbefehle: Teilnetze</th>
 </thead>
 <tbody>
  <tr>
    <td>[ibmcloud ks cluster-subnet-add](#cs_cluster_subnet_add)</td>
    <td>[ibmcloud ks cluster-subnet-create](#cs_cluster_subnet_create)</td>
    <td>[ibmcloud ks cluster-user-subnet-add](#cs_cluster_user_subnet_add)</td>
    <td>[ibmcloud ks cluster-user-subnet-rm](#cs_cluster_user_subnet_rm)</td>
  </tr>
  <tr>
    <td>[ibmcloud ks subnets](#cs_subnets)</td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
</tbody>
</table>

</br>

<table summary="Tabelle mit Befehlen für die Infrastruktur">
<caption>Clusterbefehle: Befehle für die Infrastruktur</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>Befehle für die Infrastruktur</th>
 </thead>
 <tbody>
  <tr>
    <td>[        ibmcloud ks credential-get
        ](#cs_credential_get)</td>
    <td>[ibmcloud ks credential-set](#cs_credentials_set)</td>
    <td>[ibmcloud ks credential-unset](#cs_credentials_unset)</td>
    <td>[ibmcloud ks machine-types](#cs_machine_types)</td>
  </tr>
  <tr>
    <td>[ibmcloud ks vlans](#cs_vlans)</td>
    <td>[ibmcloud ks vlan-spanning-get](#cs_vlan_spanning_get)</td>
    <td> </td>
    <td> </td>
  </tr>
</tbody>
</table>

</br>

<table summary="Tabelle mit Ingress-Befehlen für die Lastausgleichsfunktion für Anwendungen (ALB)">
<caption>Ingress-Befehle für die Lastausgleichsfunktion für Anwendungen (ALB)</caption>
<col width = 25%>
<col width = 25%>
<col width = 25%>
  <thead>
    <tr>
      <th colspan=4>Ingress-Befehle für die Lastausgleichsfunktion für Anwendungen (ALB)</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>[ibmcloud ks alb-autoupdate-disable](#cs_alb_autoupdate_disable)</td>
      <td>[ibmcloud ks alb-autoupdate-enable](#cs_alb_autoupdate_enable)</td>
      <td>[ibmcloud ks alb-autoupdate-get](#cs_alb_autoupdate_get)</td>
      <td>[ibmcloud ks alb-cert-deploy](#cs_alb_cert_deploy)</td>
    </tr>
    <tr>
      <td>[ibmcloud ks alb-cert-get](#cs_alb_cert_get)</td>
      <td>[ibmcloud ks alb-cert-rm](#cs_alb_cert_rm)</td>
      <td>[ibmcloud ks alb-certs](#cs_alb_certs)</td>
      <td>[ibmcloud ks alb-configure](#cs_alb_configure)</td>
    </tr>
    <tr>
      <td>[ibmcloud ks alb-get](#cs_alb_get)</td>
      <td>[ibmcloud ks alb-rollback](#cs_alb_rollback)</td>
      <td>[ibmcloud ks alb-types](#cs_alb_types)</td>
      <td>[ibmcloud ks alb-update](#cs_alb_update)</td>
    </tr>
    <tr>
      <td>[ibmcloud ks albs](#cs_albs)</td>
      <td> </td>
      <td> </td>
      <td> </td>
    </tr>
  </tbody>
</table>

</br>

<table summary="Tabelle mit Protokollierungsbefehlen">
<caption>Protokollierungsbefehle</caption>
<col width = 25%>
<col width = 25%>
<col width = 25%>
  <thead>
    <tr>
      <th colspan=4>Protokollierungsbefehle</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>[ibmcloud ks logging-autoupdate-enable](#cs_log_autoupdate_enable)</td>
      <td>[ibmcloud ks logging-autoupdate-disable](#cs_log_autoupdate_disable)</td>
      <td>[ibmcloud ks logging-autoupdate-get](#cs_log_autoupdate_get)</td>
      <td>[ibmcloud ks logging-config-create](#cs_logging_create)</td>
    </tr>
    <tr>
      <td>[ibmcloud ks logging-config-get](#cs_logging_get)</td>
      <td>[ibmcloud ks logging-config-refresh](#cs_logging_refresh)</td>
      <td>[ibmcloud ks logging-config-rm](#cs_logging_rm)</td>
      <td>[ibmcloud ks logging-config-update](#cs_logging_update)</td>
    </tr>
    <tr>
      <td>[ibmcloud ks logging-filter-create](#cs_log_filter_create)</td>
      <td>[ibmcloud ks logging-filter-update](#cs_log_filter_update)</td>
      <td>[ibmcloud ks logging-filter-get](#cs_log_filter_view)</td>
      <td>[ibmcloud ks logging-filter-rm](#cs_log_filter_delete)</td>
    </tr>
    <tr>
      <td>[ibmcloud ks logging-collect](#cs_log_collect)</td>
      <td>[ibmcloud ks logging-collect-status](#cs_log_collect_status)</td>
      <td> </td>
      <td> </td>
    </tr>
  </tbody>
</table>

</br>

<table summary="Tabelle mit Regionsbefehlen">
<caption>Regionsbefehle</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>Regionsbefehle</th>
 </thead>
 <tbody>
  <tr>
    <td>[ibmcloud ks region](#cs_region)</td>
    <td>[ibmcloud ks region-set](#cs_region-set)</td>
    <td>[ibmcloud ks regions](#cs_regions)</td>
    <td>[ibmcloud ks zones](#cs_datacenters)</td>
  </tr>
</tbody>
</table>

</br>

<table summary="Tabelle mit Befehlen für Workerknoten">
<caption>Befehle für Workerknoten</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>Befehle für Workerknoten</th>
 </thead>
 <tbody>
    <tr>
      <td>Veraltet: [ibmcloud ks worker-add](#cs_worker_add)</td>
      <td>[ibmcloud ks worker-get](#cs_worker_get)</td>
      <td>[ibmcloud ks worker-reboot](#cs_worker_reboot)</td>
      <td>[ibmcloud ks worker-reload](#cs_worker_reload)</td>
    </tr>
    <tr>
      <td>[ibmcloud ks worker-rm](#cs_worker_rm)</td>
      <td>[ibmcloud ks worker-update](#cs_worker_update)</td>
      <td>[ibmcloud ks workers](#cs_workers)</td>
      <td> </td>
    </tr>
  </tbody>
</table>

<table summary="Tabelle mit Befehlen für Worker-Pools">
<caption>Befehle für Worker-Pools</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>Befehle für Worker-Pools</th>
 </thead>
 <tbody>
    <tr>
      <td>[ibmcloud ks worker-pool-create](#cs_worker_pool_create)</td>
      <td>[ibmcloud ks worker-pool-get](#cs_worker_pool_get)</td>
      <td>[ibmcloud ks worker-pool-rebalance](#cs_rebalance)</td>
      <td>[ibmcloud ks worker-pool-resize](#cs_worker_pool_resize)</td>
    </tr>
    <tr>
      <td>[ibmcloud ks worker-pool-rm](#cs_worker_pool_rm)</td>
      <td>[ibmcloud ks worker-pools](#cs_worker_pools)</td>
      <td>[ibmcloud ks zone-add](#cs_zone_add)</td>
      <td>[ibmcloud ks zone-network-set](#cs_zone_network_set)</td>
    </tr>
    <tr>
     <td>[ibmcloud ks zone-rm](#cs_zone_rm)</td>
     <td></td>
    </tr>
  </tbody>
</table>

## API-Befehle
{: #api_commands}

### ibmcloud ks api --endpoint ENDPUNKT [--insecure][--skip-ssl-validation] [--api-version WERT][-s]
{: #cs_api}

Legen Sie den API-Endpunkt als ziel für {{site.data.keyword.containerlong_notm}} fest. Wenn Sie keinen Endpunkt angeben, können Sie Informationen zu dem aktuellen Endpunkt anzeigen, der als Ziel angegeben wurde.

Zwischen Regionen wechseln? Verwenden Sie stattdessen den [Befehl `ibmcloud ks region-set`](#cs_region-set).
{: tip}

<strong>Erforderliche Mindestberechtigungen:</strong> Keine

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code>--endpoint <em>ENDPUNKT</em></code></dt>
   <dd>Der {{site.data.keyword.containerlong_notm}}-API-Endpunkt. Beachten Sie, dass sich dieser Endpunkt von {{site.data.keyword.Bluemix_notm}}-Endpunkten unterscheidet. Dieser Wert ist zum Festlegen der API-Endpunkte erforderlich. Folgende Werte sind zulässig:<ul>
   <li>Globaler Endpunkt: https://containers.bluemix.net</li>
   <li>Endpunkt für Asien-Pazifik (Norden): https://ap-north.containers.bluemix.net</li>
   <li>Endpunkt für Asien-Pazifik (Süden): https://ap-south.containers.bluemix.net</li>
   <li>Endpunkt für Mitteleuropa: https://eu-central.containers.bluemix.net</li>
   <li>Endpunkt für Vereinigtes Königreich (Süden): https://uk-south.containers.bluemix.net</li>
   <li>Endpunkt für Vereinigte Staaten (Osten): https://us-east.containers.bluemix.net</li>
   <li>Endpunkt für Vereinigte Staaten (Süden): https://us-south.containers.bluemix.net</li></ul>
   </dd>

   <dt><code>--insecure</code></dt>
   <dd>Lässt eine unsichere HTTP-Verbindung zu. Dieses Flag ist optional.</dd>

   <dt><code>--skip-ssl-validation</code></dt>
   <dd>Lässt unsichere SSL-Zertifikate zu. Dieses Flag ist optional.</dd>

   <dt><code>--api-version VALUE</code></dt>
   <dd>Gibt die API-Version des Service an, den Sie verwenden möchten. Dieser Wert ist optional.</dd>

   <dt><code>-s</code></dt>
   <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>

   </dl>

**Beispiel**: Zeigen Sie Informationen zu dem aktuellen Endpunkt an, der als Ziel angegeben wurde.
```
ibmcloud ks api
```
{: pre}

```
API Endpoint:          https://containers.bluemix.net   
API Version:           v1   
Skip SSL Validation:   false   
Region:                us-south
```
{: screen}


### ibmcloud ks api-key-info --cluster CLUSTER [--json][-s]
{: #cs_api_key_info}

Zeigen Sie den Namen und die E-Mail-Adresse für den Eigner des {{site.data.keyword.Bluemix_notm}} IAM-API-Schlüssels (Identity and Access Management) in einer {{site.data.keyword.containerlong_notm}}-Ressourcengruppe und -Region an.

Der {{site.data.keyword.Bluemix_notm}}-API-Schlüssel wird automatisch für eine Ressourcengruppe und Region festgelegt, wenn die erste Aktion ausgeführt wird, für die die {{site.data.keyword.containerlong_notm}}-Administratorzugriffsrichtlinie ausgeführt werden muss. Zum Beispiel erstellt einer Ihrer Benutzer mit Administratorberechtigung den ersten Cluster in der Ressourcengruppe `default` in der Region `us-south`. Dadurch wird der {{site.data.keyword.Bluemix_notm}} IAM-API-Schlüssel für diesen Benutzer in dem Konto für diese Ressourcengruppe und diese Region gespeichert. Der API-Schlüssel wird verwendet, um Ressourcen in der IBM Cloud-Infrastruktur (SoftLayer) zu bestellen, z. B. neue Workerknoten oder VLANs. Für jede Region in einer Ressourcengruppe kann ein anderer API-Schlüssel festgelegt werden.

Wenn ein anderer Benutzer eine Aktion in dieser Ressourcengruppe und Region ausführt, die eine Interaktion mit dem Portfolio der IBM Cloud-Infrastruktur (SoftLayer) erfordert, wie z. B. die Erstellung eines neuen Clusters oder das erneute Laden eines Workerknotens, wird der gespeicherte API-Schlüssel verwendet, um festzustellen, ob ausreichende Berechtigungen vorhanden sind, um diese Aktion auszuführen. Um sicherzustellen, dass infrastrukturbezogene Aktionen in Ihrem Cluster erfolgreich ausgeführt werden können, weisen Sie Ihre {{site.data.keyword.containerlong_notm}}-Benutzer mit Administratorberechtigung der Infrastrukturzugriffsrichtlinie **Superuser** zu. Weitere Informationen finden unter [Benutzerzugriff verwalten](cs_users.html#infra_access).

Wenn Sie feststellen, dass Sie den API-Schlüssel aktualisieren müssen, der für eine Ressourcengruppe und Region gespeichert ist, können Sie dies tun, indem Sie den Befehl [ibmcloud ks api-key-reset](#cs_api_key_reset) ausführen. Dieser Befehl erfordert die {{site.data.keyword.containerlong_notm}}-Administratorzugriffsrichtlinie und speichert den API-Schlüssel des Benutzers, der diesen Befehl ausführt, im Konto.

**Tipp:** Der API-Schlüssel, der in diesem Befehl zurückgegeben wird, wird möglicherweise nicht verwendet, wenn die Berechtigungsnachweise der IBM Cloud-Infrastruktur (SoftLayer) manuell mithilfe des Befehls [ibmcloud ks credential-set](#cs_credentials_set) festgelegt wurden.

<strong>Erforderliche Mindestberechtigungen:</strong> Plattformrolle **Anzeigeberechtigter** für {{site.data.keyword.containerlong_notm}}

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>

   <dt><code>--json</code></dt>
   <dd>Druckt die Befehlsausgabe im JSON-Format. Dieser Wert ist optional.</dd>

   <dt><code>-s</code></dt>
   <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>

   </dl>

**Beispiel**:

  ```
  ibmcloud ks api-key-info --cluster mein_cluster
  ```
  {: pre}


### ibmcloud ks api-key-reset [-s]
{: #cs_api_key_reset}

Ersetzen Sie den aktuellen {{site.data.keyword.Bluemix_notm}} IAM-API-Schlüssel in einer {{site.data.keyword.containerlong_notm}}-Region.
{: shortdesc}

Dieser Befehl erfordert die {{site.data.keyword.containerlong_notm}}-Administratorzugriffsrichtlinie und speichert den API-Schlüssel des Benutzers, der diesen Befehl ausführt, im Konto. Der {{site.data.keyword.Bluemix_notm}} IAM-API-Schlüssel ist erforderlich, um Infrastruktur aus dem Portfolio der IBM Cloud-Infrastruktur (SoftLayer) zu bestellen. Einmal gespeichert, wird der API-Schlüssel unabhängig vom Benutzer, der diesen Befehl ausführt, für jede Aktion in einer Region verwendet, die Infrastrukturberechtigungen erfordert. Weitere Informationen zur Funktionsweise von {{site.data.keyword.Bluemix_notm}} IAM-API-Schlüsseln finden Sie im Abschnitt zum [Befehl `ibmcloud ks api-key-info`](#cs_api_key_info).

Stellen Sie vor Verwendung dieses Befehls sicher, dass der Benutzer, der diesen Befehl ausführt, über die erforderlichen Berechtigungen für [{{site.data.keyword.containerlong_notm}} und die IBM Cloud-Infrastruktur (SoftLayer) verfügt.](cs_users.html#users).
{: important}

<strong>Erforderliche Mindestberechtigungen:</strong> Plattformrolle **Administrator** für {{site.data.keyword.containerlong_notm}}

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code>-s</code></dt>
   <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>
   </dl>


**Beispiel**:

  ```
  ibmcloud ks api-key-reset
  ```
  {: pre}


### ibmcloud ks apiserver-config-get
{: #cs_apiserver_config_get}

Abrufen von Informationen zu einer Option für die Kubernetes-API-Serverkonfiguration eines Clusters. Dieser Befehl muss mit einem der folgenden Unterbefehle für die Konfigurationsoption kombiniert werden, zu der Sie Informationen abrufen möchten.

#### ibmcloud ks apiserver-config-get audit-webhook --cluster CLUSTER
{: #cs_apiserver_config_get_audit_webhook}

Zeigen Sie die URL für den fernen Protokollierungsservice an, an den Sie API-Serverauditprotokolle senden. Die URL wurde angegeben, als Sie das Webhook-Back-End für die API-Serverkonfiguration erstellt haben.

<strong>Erforderliche Mindestberechtigungen:</strong> Plattformrolle **Anzeigeberechtigter** für {{site.data.keyword.containerlong_notm}}

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>
   </dl>

**Beispiel**:

  ```
  ibmcloud ks apiserver-config-get audit-webhook --cluster mein_cluster
  ```
  {: pre}

### ibmcloud ks apiserver-config-set
{: #cs_apiserver_config_set}

Legen Sie eine Option für die Kubernetes-API-Serverkonfiguration eines Clusters fest. Dieser Befehl muss mit einem der folgenden Unterbefehle für die Konfigurationsoption, die Sie festlegen möchten, kombiniert werden.

#### ibmcloud ks apiserver-config-set audit-webhook --cluster CLUSTER [--remoteServer SERVER-URL_ODER_-IP][--caCert CA_CERT_PATH] [--clientCert PFAD_DES_CLIENTZERTIFIKATS][--clientKey CLIENT_KEY_PATH]
{: #cs_apiserver_set}

Legen Sie das Webhook-Back-End für die API-Serverkonfiguration fest. Das Webhook-Back-End leitet API-Serverauditprotokolle an einen fernen Server weiter. Eine Webhook-Konfiguration wird auf der Grundlage der Informationen erstellt, die Sie in den Flags dieses Befehls bereitstellen. Wenn Sie keine Informationen in den Flags bereitstellen, wird eine Standard-Webhook-Konfiguration verwendet.

<strong>Erforderliche Mindestberechtigungen:</strong> Plattformrolle **Editor** für {{site.data.keyword.containerlong_notm}}

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>

   <dt><code>--remoteServer <em>SERVER-URL</em></code></dt>
   <dd>Die URL oder IP-Adresse für den fernen Protokollierungsservice, an den Sie Auditprotokolle senden möchten. Wenn Sie eine unsichere Server-URL angeben, werden alle Zertifikate ignoriert. Dieser Wert ist optional.</dd>

   <dt><code>--caCert <em>PFAD_DES_CA-ZERTIFIKATS</em></code></dt>
   <dd>Der Dateipfad für das CA-Zertifikat, das zum Überprüfen des fernen Protokollierungsservice verwendet wird. Dieser Wert ist optional.</dd>

   <dt><code>--clientCert <em>PFAD_DES_CLIENTZERTIFIKATS</em></code></dt>
   <dd>Der Dateipfad des Clientzertifikats, das zum Authentifizieren beim fernen Protokollierungsservice verwendet wird. Dieser Wert ist optional.</dd>

   <dt><code>--clientKey <em>PFAD_DES_CLIENTSCHLÜSSELS</em></code></dt>
   <dd>Der Dateipfad für den entsprechenden Clientschlüssel, der zum Verbinden mit dem fernen Protokollierungsservice verwendet wird. Dieser Wert ist optional.</dd>
   </dl>

**Beispiel**:

  ```
  ibmcloud ks apiserver-config-set audit-webhook --cluster mein_cluster --remoteServer https://audit.example.com/audit --caCert /mnt/etc/kubernetes/apiserver-audit/ca.pem --clientCert /mnt/etc/kubernetes/apiserver-audit/cert.pem --clientKey /mnt/etc/kubernetes/apiserver-audit/key.pem
  ```
  {: pre}


### ibmcloud ks apiserver-config-unset
{: #cs_apiserver_config_unset}

Inaktivieren Sie eine Option für die Kubernetes-API-Serverkonfiguration eines Clusters. Dieser Befehl muss mit einem der folgenden Unterbefehle für die Konfigurationsoption kombiniert werden, die Sie inaktivieren möchten.

#### ibmcloud ks apiserver-config-unset audit-webhook --cluster CLUSTER
{: #cs_apiserver_unset}

Inaktivieren Sie die Webhook-Back-End-Konfiguration für den API-Server des Clusters. Wenn Sie das Webhook-Back-End inaktivieren, wird die Weiterleitung von Prüfprotokollen des API-Servers an einen fernen Server gestoppt.

<strong>Erforderliche Mindestberechtigungen:</strong> Plattformrolle **Editor** für {{site.data.keyword.containerlong_notm}}

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>
   </dl>

**Beispiel**:

  ```
  ibmcloud ks apiserver-config-unset audit-webhook --cluster mein_cluster
  ```
  {: pre}

### ibmcloud ks apiserver-refresh --cluster CLUSTER [-s]
{: #cs_apiserver_refresh}

Starten Sie den Cluster-Master erneut, um die neuen Änderungen an der Kubernetes-API-Konfiguration anzuwenden. Die Workerknoten, Apps und Ressourcen werden nicht geändert und weiterhin ausgeführt.
{: shortdesc}

<strong>Erforderliche Mindestberechtigungen:</strong> Plattformrolle **Operator** für {{site.data.keyword.containerlong_notm}}

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>

   <dt><code>-s</code></dt>
   <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>

   </dl>

**Beispiel**:

  ```
  ibmcloud ks apiserver-refresh --cluster mein_cluster
  ```
  {: pre}


<br />


## Befehle für die Verwendung des CLI-Plug-ins
{: #cli_plug-in_commands}

### ibmcloud ks help
{: #cs_help}

Anzeigen einer Liste der unterstützten Befehle und Parameter.

<strong>Erforderliche Mindestberechtigungen:</strong> Keine

<strong>Befehlsoptionen</strong>:

   Keine

**Beispiel**:

  ```
  ibmcloud ks help
  ```
  {: pre}


### ibmcloud ks init [--host HOST][--insecure] [-p][-u] [-s]
{: #cs_init}

Initialisieren des {{site.data.keyword.containerlong_notm}}-Plug-ins oder Angeben der Region, in der Sie Kubernetes-Cluster erstellen oder darauf zugreifen möchten.
{: shortdesc}

<strong>Erforderliche Mindestberechtigungen:</strong> Keine

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code>--host <em>HOST</em></code></dt>
   <dd>Der zu verwendende {{site.data.keyword.containerlong_notm}}-API-Endpunkt.  Dieser Wert ist optional. [Zeigen Sie die verfügbaren API-Endpunktwerte an.](cs_regions.html#container_regions)</dd>

   <dt><code>--insecure</code></dt>
   <dd>Lässt eine unsichere HTTP-Verbindung zu.</dd>

   <dt><code>-p</code></dt>
   <dd>Ihr IBM Cloud-Kennwort.</dd>

   <dt><code>-u</code></dt>
   <dd>Ihr IBM Cloud-Benutzername.</dd>

   <dt><code>-s</code></dt>
   <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>

   </dl>

**Beispiel**:


```
ibmcloud ks init --host https://uk-south.containers.bluemix.net
```
{: pre}


### ibmcloud ks messages
{: #cs_messages}

Aktuelle Nachrichten für den Benutzer der IBMid anzeigen.
{: shortdesc}

<strong>Erforderliche Mindestberechtigungen:</strong> Keine

**Beispiel**:

```
ibmcloud ks messages
```
{: pre}


<br />


## Clusterbefehle: Management
{: #cluster_mgmt_commands}



### ibmcloud ks cluster-config --cluster CLUSTER [--admin][--export] [--network][-s] [--yaml]
{: #cs_cluster_config}

Laden Sie nach erfolgter Anmeldung Kubernetes-Konfigurationsdaten und -Zertifikate herunter, um eine Verbindung zum Cluster herzustellen und `kubectl`-Befehle auszuführen. Die Dateien werden in `ausgangsverzeichnis_des_benutzers/.bluemix/plugins/container-service/clusters/<cluster_name>`.
{: shortdesc}

**Erforderliche Mindestberechtigungen:** Keine

**Befehlsoptionen**:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>

   <dt><code>--admin</code></dt>
   <dd>Laden Sie die TLS-Zertifikate und die entsprechenden Berechtigungsdateien für die Rolle 'Superuser' herunter. Sie können die Zertifikate verwenden, um Tasks in einem Cluster zu automatisieren, ohne eine erneute Authentifizierung durchführen zu müssen. Die Dateien werden in  `<user_home_directory>/.bluemix/plugins/container-service/clusters/<clustername>-admin` heruntergeladen. Dieser Wert ist optional.</dd>

   <dt><code>--network</code></dt>
   <dd>Laden Sie die Calico-Konfigurationsdatei, die TLS-Zertifikate und die Berechtigungsdateien herunter, die für die Ausführung von <code>calicoctl</code>-Befehlen im Cluster erforderlich sind. Dieser Wert ist optional. **Hinweis:** Zum Abrufen des Exportbefehls für das Herunterladen der Kubernetes-Konfigurationsdaten und -Zertifikate müssen Sie diesen Befehl ohne dieses Flag ausführen.</dd>

   <dt><code>--export</code></dt>
   <dd>Laden Sie die Kubernetes-Konfigurationsdaten und -Zertifikate ohne Nachrichten außer dem Exportbefehl herunter. Da keine Nachrichten angezeigt werden, können Sie dieses Flag verwenden, wenn Sie automatisierte Scripts erstellen. Dieser Wert ist optional.</dd>

  <dt><code>-s</code></dt>
  <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>

  <dt><code>--yaml</code></dt>
  <dd>Druckt die Befehlsausgabe im YAML-Format. Dieser Wert ist optional.</dd>

   </dl>

**Beispiel**:

```
ibmcloud ks cluster-config --cluster mein_cluster
```
{: pre}


### ibmcloud ks cluster-create [--file FILE_LOCATION][--hardware HARDWARE] --zone ZONE --machine-type MACHINE_TYPE --name NAME [--kube-version MAJOR.MINOR.PATCH][--no-subnet] [--private-vlan PRIVATE_VLAN][--public-vlan PUBLIC_VLAN] [--private-only][--workers WORKER] [--disable-disk-encrypt][--trusted] [-s]
{: #cs_cluster_create}

Erstellen Sie einen Cluster in Ihrer Organisation. Für kostenlose Cluster geben Sie den Clusternamen an; alles andere ist auf einen Standardwert gesetzt. Ein kostenloser Cluster wird nach 30 Tagen automatisch gelöscht. Sie können zu einem Zeitpunkt jeweils nur über einen kostenlosen Cluster verfügen. Wenn Sie die volle Funktionalität von Kubernetes nutzen möchten, erstellen Sie einen Standardcluster.

<strong>Erforderliche Mindestberechtigungen:</strong>
* Die Plattformrolle **Administrator** für {{site.data.keyword.containerlong_notm}} auf Kontoebene
* Die Plattformrolle **Administrator** für {{site.data.keyword.registrylong_notm}} auf Kontoebene
* Die Rolle **Superuser** für die IBM Cloud-Infrastruktur (SoftLayer)

<strong>Befehlsoptionen</strong>

<dl>
<dt><code>--file <em>DATEISTANDORT</em></code></dt>

<dd>Der Pfad zur YAML-Datei für die Erstellung Ihres Standardclusters. Statt die Merkmale Ihres Clusters mithilfe der in diesem Befehl bereitgestellten Optionen zu definieren, können Sie eine YAML-Datei verwenden.  Dieser Wert ist für Standardcluster optional und steht für kostenlose Cluster nicht zur Verfügung.

<p class="note">Wenn Sie dieselbe Option wie im Befehl als Parameter in der YAML-Datei bereitstellen, hat der Wert im Befehl Vorrang vor dem Wert in der YAML. Beispiel: Sie definieren eine Position in Ihrer YAML-Datei und verwenden die Option <code>--zone</code> im Befehl. Der Wert, den Sie in die Befehlsoption eingegeben haben, überschreibt den Wert in der YAML-Datei.</p>

<pre class="codeblock">
<code>name: <em>&lt;clustername&gt;</em>
zone: <em>&lt;zone&gt;</em>
no-subnet: <em>&lt;kein_teilnetz&gt;</em>
machine-type: <em>&lt;maschinentyp&gt;</em>
private-vlan: <em>&lt;privates_vlan&gt;</em>
public-vlan: <em>&lt;öffentliches_vlan&gt;</em>
hardware: <em>&lt;shared_oder_dedicated&gt;</em>
workerNum: <em>&lt;anzahl_worker&gt;</em>
kube-version: <em>&lt;kube-version&gt;</em>
diskEncryption: <em>false</em>
trusted: <em>true</em>
</code></pre>


<table>
    <caption>Erklärung der Komponenten der YAML-Datei</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der YAML-Dateikomponenten</th>
    </thead>
    <tbody>
    <tr>
    <td><code><em>name</em></code></td>
    <td>Ersetzen Sie <code><em>&lt;clustername&gt;</em></code> durch den Namen Ihres Clusters. Der Name muss mit einem Buchstaben beginnen, darf Buchstaben, Ziffern und den Bindestrich (-) enthalten und darf maximal 35 Zeichen lang sein. Der vollständig qualifizierte Domänenname für die Ingress-Unterdomäne setzt sich aus dem Clusternamen und der Region zusammen, in der der Cluster bereitgestellt wird. Um sicherzustellen, dass die Ingress-Unterdomäne innerhalb einer Region eindeutig ist, wird der Clustername möglicherweise abgeschnitten und es wird ein beliebiger Wert innerhalb des Ingress-Domänennamens angehängt.
</td>
    </tr>
    <tr>
    <td><code><em>zone</em></code></td>
    <td>Ersetzen Sie <code><em>&lt;zone&gt;</em></code> durch die Zone, in der der Cluster erstellt werden soll. Die verfügbaren Zonen sind abhängig von der Region, in der Sie angemeldet sind. Führen Sie den Befehl <code>ibmcloud ks zones</code> aus, um die verfügbaren Zonen aufzuführen. </td>
     </tr>
     <tr>
     <td><code><em>kein_teilnetz</em></code></td>
     <td>Standardmäßig werden sowohl ein öffentliches als auch ein privates portierbares Teilnetz in dem VLAN erstellt, das dem Cluster zugeordnet ist. Ersetzen Sie <code><em>&lt;kein_teilnetz&gt;</em></code> durch <code><em>true</em></code>, um zu verhindern, dass Teilnetze für den Cluster erstellt werden. Sie können Teilnetze zu einem späteren Zeitpunkt [erstellen](#cs_cluster_subnet_create) oder zu einem Cluster [hinzufügen](#cs_cluster_subnet_add).</td>
      </tr>
     <tr>
     <td><code><em>maschinentyp</em></code></td>
     <td>Ersetzen Sie <code><em>&lt;maschinentyp&gt;</em></code> durch den Maschinentyp, auf dem Sie Ihre Workerknoten bereitstellen möchten. Sie können Ihre Workerknoten als virtuelle Maschinen auf gemeinsam genutzter oder dedizierter Hardware oder als physische Maschinen auf Bare-Metal-Systemen bereitstellen. Die Typen der verfügbaren physischen und virtuellen Maschinen variieren je nach der Zone, in der Sie den Cluster implementieren. Weitere Informationen finden Sie in der Dokumentation zum [Befehl `ibmcloud ks machine-type`](cs_cli_reference.html#cs_machine_types).</td>
     </tr>
     <tr>
     <td><code><em>privates_vlan</em></code></td>
     <td>Ersetzen Sie <code><em>&lt;privates_vlan&gt;</em></code> durch die ID des privaten VLANs, das Sie für Ihre Workerknoten verwenden möchten. Führen Sie <code>ibmcloud ks vlans <em>&lt;zone&gt;</em></code> aus und suchen Sie nach VLAN-Routern, die mit <code>bcr</code> (Back-End-Router) beginnen, um verfügbare VLANs aufzulisten.</td>
     </tr>
     <tr>
     <td><code><em>öffentliches_vlan</em></code></td>
     <td>Ersetzen Sie <code><em>&lt;öffentliches_vlan&gt;</em></code> durch die ID des öffentlichen VLANs, das Sie für Ihre Workerknoten verwenden möchten. Führen Sie <code>ibmcloud ks vlans <em>&lt;zone&gt;</em></code> aus und suchen Sie nach VLAN-Routern, die mit <code>fcr</code> (Front-End-Router) beginnen, um verfügbare VLANs aufzulisten.</td>
     </tr>
     <tr>
     <td><code><em>hardware</em></code></td>
     <td>Für virtuelle Maschinentypen: Der Grad an Hardware-Isolation für Ihren Workerknoten. Verwenden Sie 'dedicated', wenn
Sie verfügbare physische Ressourcen haben möchten, die nur Sie nutzen können, oder 'shared', um zuzulassen, dass
physische Ressourcen mit anderen IBM Kunden gemeinsam genutzt werden können. Die Standardeinstellung ist
<code>shared</code>.</td>
     </tr>
     <tr>
     <td><code><em>anzahl_worker</em></code></td>
     <td>Ersetzen Sie <code><em>&lt;anzahl_worker&gt;</em></code> durch die Anzahl von Workerknoten, die Sie implementieren wollen.</td>
     </tr>
     <tr>
      <td><code><em>kube-version</em></code></td>
      <td>Die Kubernetes-Version für den Cluster-Masterknoten. Dieser Wert ist optional. Wenn die Version nicht angegeben ist, wird der Cluster mit dem Standard für unterstützte Kubernetes-Versionen erstellt. Führen Sie den Befehl <code>ibmcloud ks kube-versions</code> aus, um die verfügbaren Versionen anzuzeigen.
</td></tr> 
      <tr>
      <td><code>diskEncryption: <em>false</em></code></td>
      <td>Workerknoten weisen standardmäßig Verschlüsselung auf. [Weitere Informationen finden Sie hier](cs_secure.html#encrypted_disk). Um die Verschlüsselung zu inaktivieren, schließen Sie diese Option ein und legen Sie den Wert auf <code>false</code> fest.</td></tr>
      <tr>
      <td><code>trusted: <em>true</em></code></td>
      <td>**Nur für Bare-Metal**: Aktivieren Sie [Trusted Compute](cs_secure.html#trusted_compute), um Ihre Bare-Metal-Workerknoten auf Manipulation zu überprüfen. Wenn Sie Trusted Compute während der Clustererstellung nicht aktivieren, dies jedoch später nachholen möchten, können Sie den [Befehl](cs_cli_reference.html#cs_cluster_feature_enable) `ibmcloud ks feature-enable` verwenden. Nachdem Sie Trusted Compute aktiviert haben, können Sie es später nicht mehr inaktivieren.</td></tr>
     </tbody></table>
    </p></dd>

<dt><code>--hardware <em>HARDWARE</em></code></dt>
<dd>Der Grad an Hardware-Isolation für Ihren Workerknoten. Verwenden Sie 'dedicated', wenn Sie verfügbare physische Ressourcen haben möchten, die nur Sie nutzen können, oder 'shared', um zuzulassen, dass physische Ressourcen mit anderen IBM Kunden gemeinsam genutzt werden können. Die Standardeinstellung ist
'shared'.  Dieser Wert ist für Standardcluster optional und steht für kostenlose Cluster nicht zur Verfügung.</dd>

<dt><code>--zone <em>ZONE</em></code></dt>
<dd>Die Zone, in der der Cluster erstellt werden soll. Die Zonen, die Ihnen zur Verfügung stehen, hängen von der {{site.data.keyword.Bluemix_notm}}-Region ab, in der Sie angemeldet sind. Wählen Sie die Region aus,
die Ihrem Standort am nächsten ist, um eine optimale Leistung zu erhalten. Dieser Wert ist für Standardcluster erforderlich und für kostenlose Cluster optional.

<p>Überprüfen Sie die [verfügbaren Zonen](cs_regions.html#zones).</p>

<p class="note">Wenn Sie eine Zone auswählen, die sich außerhalb Ihres Landes befindet, müssen Sie daran denken, dass Sie möglicherweise eine Berechtigung benötigen, bevor Daten physisch in einem fremden Land gespeichert werden können.</p>
</dd>

<dt><code>--machine-type <em>MASCHINENTYP</em></code></dt>
<dd>Wählen Sie einen Maschinentyp aus. Sie können Ihre Workerknoten als virtuelle Maschinen auf gemeinsam genutzter oder dedizierter Hardware oder als physische Maschinen auf Bare-Metal-Systemen bereitstellen. Die Typen der verfügbaren physischen und virtuellen Maschinen variieren je nach der Zone, in der Sie den Cluster implementieren. Weitere Informationen finden Sie in der Dokumentation zum [Befehl `ibmcloud ks machine-types`](cs_cli_reference.html#cs_machine_types). Dieser Wert ist für Standardcluster erforderlich und steht für kostenlose Cluster nicht zur Verfügung.</dd>

<dt><code>--name <em>NAME</em></code></dt>
<dd>Der Name für den Cluster.  Dieser Wert ist erforderlich. Der Name muss mit einem Buchstaben beginnen, darf Buchstaben, Ziffern und den Bindestrich (-) enthalten und darf maximal 35 Zeichen lang sein. Der vollständig qualifizierte Domänenname für die Ingress-Unterdomäne setzt sich aus dem Clusternamen und der Region zusammen, in der der Cluster bereitgestellt wird. Um sicherzustellen, dass die Ingress-Unterdomäne innerhalb einer Region eindeutig ist, wird der Clustername möglicherweise abgeschnitten und es wird ein beliebiger Wert innerhalb des Ingress-Domänennamens angehängt.
</dd>

<dt><code>--kube-version <em>MAJOR.MINOR.PATCH</em></code></dt>
<dd>Die Kubernetes-Version für den Cluster-Masterknoten. Dieser Wert ist optional. Wenn die Version nicht angegeben ist, wird der Cluster mit dem Standard für unterstützte Kubernetes-Versionen erstellt. Führen Sie den Befehl <code>ibmcloud ks kube-versions</code> aus, um die verfügbaren Versionen anzuzeigen.
</dd>

<dt><code>--no-subnet</code></dt>
<dd>Standardmäßig werden sowohl ein öffentliches als auch ein privates portierbares Teilnetz in dem VLAN erstellt, das dem Cluster zugeordnet ist. Schließen Sie das Flag <code>--no-subnet</code> ein, um zu verhindern, dass Teilnetze für den Cluster erstellt werden. Sie können Teilnetze zu einem späteren Zeitpunkt [erstellen](#cs_cluster_subnet_create) oder zu einem Cluster [hinzufügen](#cs_cluster_subnet_add).</dd>

<dt><code>--private-vlan <em>PRIVATES_VLAN</em></code></dt>
<dd>

<ul>
<li>Dieser Parameter ist für kostenlose Cluster nicht verfügbar.</li>
<li>Wenn es sich bei diesem Standardcluster um den ersten Standardcluster handelt, den Sie in dieser Zone erstellen, schließen Sie dieses Flag nicht ein. Ein privates VLAN wird zusammen mit den Clustern für Sie erstellt.</li>
<li>Wenn Sie bereits einen Standardcluster in dieser Zone oder ein privates VLAN in der IBM Cloud-Infrastruktur (SoftLayer) erstellt haben, müssen Sie dieses private VLAN angeben. Private VLAN-Router beginnen immer mit <code>bcr</code> (Back-End-Router) und öffentliche VLAN-Router immer mit <code>fcr</code> (Front-End-Router). Wenn Sie einen Cluster erstellen und die öffentlichen und privaten VLANs angeben, müssen die Zahlen- und Buchstabenkombinationen nach diesen Präfixen übereinstimmen.</li>
</ul>

<p>Führen Sie <code>ibmcloud ks vlans <em>&lt;zone&gt;</em></code> aus, um herauszufinden, ob Sie bereits über ein privates VLAN für eine bestimmte Zone verfügen, oder um den Namen eines vorhandenen privaten VLANs zu erfahren.</p></dd>

<dt><code>--public-vlan <em>ÖFFENTLICHES_VLAN</em></code></dt>
<dd>
<ul>
<li>Dieser Parameter ist für kostenlose Cluster nicht verfügbar.</li>
<li>Wenn es sich bei diesem Standardcluster um den ersten Standardcluster handelt, den Sie in dieser Zone erstellen, verwenden Sie dieses Flag nicht. Ein öffentliches VLAN wird zusammen mit dem Cluster für Sie erstellt.</li>
<li>Wenn Sie bereits einen Standardcluster in dieser Zone oder ein öffentliches VLAN in der IBM Cloud-Infrastruktur (SoftLayer) erstellt haben, geben Sie dieses öffentliche VLAN an. Wenn Sie Ihre Workerknoten nur mit einem private VLAN verbinden möchten, geben Sie diese Option nicht an. Private VLAN-Router beginnen immer mit <code>bcr</code> (Back-End-Router) und öffentliche VLAN-Router immer mit <code>fcr</code> (Front-End-Router). Wenn Sie einen Cluster erstellen und die öffentlichen und privaten VLANs angeben, müssen die Zahlen- und Buchstabenkombinationen nach diesen Präfixen übereinstimmen.</li>
</ul>

<p>Führen Sie <code>ibmcloud ks vlans <em>&lt;zone&gt;</em></code> aus, um herauszufinden, ob Sie bereits über ein öffentliches VLAN für einen bestimmten Standort verfügen, oder um den Namen eines vorhandenen öffentlichen VLANs zu erfahren.</p></dd>

<dt><code>--private-only </code></dt>
  <dd>Verwenden Sie diese Option, um zu verhindern, dass ein öffentliches VLAN erstellt wird. Dieser Wert ist nur erforderlich, wenn Sie das Flag `--private-vlan` angeben und das Flag `--public-vlan` nicht einschließen.  <p class="note">Wenn Sie mit einem ausschließlich privaten Cluster (private-only) arbeiten möchten, müssen sie eine Gateway-Appliance für die Netzkonnektivität konfigurieren. Weitere Informationen finden Sie in [Private Cluster](cs_clusters_planning.html#private_clusters).</p></dd>

<dt><code>--workers WORKER</code></dt>
<dd>Die Anzahl von Workerknoten, die Sie in Ihrem Cluster bereitstellen wollen. Wenn Sie diese Option nicht angeben, wird ein Cluster mit einem Workerknoten erstellt. Dieser Wert ist für Standardcluster optional und steht für kostenlose Cluster nicht zur Verfügung.

<p class="important">Jedem Workerknoten werden eine eindeutige Workerknoten-ID und ein Domänenname zugewiesen, die nach dem manuellen Erstellen des Clusters nicht geändert werden dürfen. Wenn die ID oder der Domänenname geändert wird, kann der Kubernetes-Master Ihren Cluster nicht mehr verwalten.</p></dd>

<dt><code>--disable-disk-encrypt</code></dt>
<dd>Workerknoten weisen standardmäßig Verschlüsselung auf. [Weitere Informationen finden Sie hier](cs_secure.html#encrypted_disk). Wenn Sie die Verschlüsselung inaktivieren möchten, schließen Sie diese Option ein.</dd>

<dt><code>--trusted</code></dt>
<dd><p>**Nur für Bare-Metal**: Aktivieren Sie [Trusted Compute](cs_secure.html#trusted_compute), um Ihre Bare-Metal-Workerknoten auf Manipulation zu überprüfen. Wenn Sie Trusted Compute während der Clustererstellung nicht aktivieren, dies jedoch später nachholen möchten, können Sie den [Befehl](cs_cli_reference.html#cs_cluster_feature_enable) `ibmcloud ks feature-enable` verwenden. Nachdem Sie Trusted Compute aktiviert haben, können Sie es später nicht mehr inaktivieren.</p>
<p>Um zu überprüfen, ob der Bare-Metal-Maschinentyp Trusted Compute unterstützt, überprüfen Sie das Feld `Trustable` in der Ausgabe des [Befehls](#cs_machine_types) `ibmcloud ks machine-types <zone>`. Um zu überprüfen, ob für ein Cluster Trusted Compute aktiviert wurde, sehen Sie sich das Feld **Trust ready** in der Ausgabe des [Befehls](#cs_cluster_get) `ibmcloud ks cluster-get` an. Um zu überprüfen, ob für einen Bare-Metal-Workerknoten Trusted Compute aktiviert wurde, sehen Sie sich das Feld **Trust** in der Ausgabe des [Befehls](#cs_worker_get)`ibmcloud ks worker-get` an.</p></dd>

<dt><code>-s</code></dt>
<dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>
</dl>

**Beispiele**:

  

  **Kostenlosen Cluster erstellen**: Geben Sie nur den Clusternamen an; alles andere ist auf einen Standardwert gesetzt. Ein kostenloser Cluster wird nach 30 Tagen automatisch gelöscht. Sie können zu einem Zeitpunkt jeweils nur über einen kostenlosen Cluster verfügen. Wenn Sie die volle Funktionalität von Kubernetes nutzen möchten, erstellen Sie einen Standardcluster.

  ```
  ibmcloud ks cluster-create --name mein_cluster
  ```
  {: pre}

  **Den ersten Standardcluster erstellen**: Für den ersten Standardcluster, der in einer Zone erstellt wird, wird auch ein privates VLAN erstellt. Schließen Sie daher nicht das Flag `--public-vlan` ein.
  {: #example_cluster_create}

  ```
  ibmcloud ks cluster-create --zone dal10 --private-vlan meine_private_vlan-id --machine-type b2c.4x16 --name mein_cluster --hardware shared --workers 2
  ```
  {: pre}

  **Nachfolgende Standardcluster erstellen**: Wenn Sie bereits einen Standardcluster in dieser Zone oder ein öffentliches VLAN in der IBM Cloud-Infrastruktur (SoftLayer) erstellt haben, geben Sie dieses öffentliche VLAN mit dem Flag `--public-vlan` an. Führen Sie `ibmcloud ks vlans <zone>` aus, um herauszufinden, ob Sie bereits über ein öffentliches VLAN für eine bestimmte Zone verfügen, oder um den Namen eines vorhandenen öffentlichen VLANs zu erfahren.

  ```
  ibmcloud ks cluster-create --zone dal10 --public-vlan meine_öffentliche_vlan-id --private-vlan meine_private_vlan-id --machine-type b2c.4x16 --name mein_cluster --hardware shared --workers 2
  ```
  {: pre}

  **Erstellen Sie einen Cluster in einer {{site.data.keyword.Bluemix_dedicated_notm}}-Umgebung**:

  ```
  ibmcloud ks cluster-create --machine-type maschinentyp --workers number --name clustername
  ```
  {: pre}

### ibmcloud ks cluster-feature-enable [-f] --cluster CLUSTER [--trusted][-s]
{: #cs_cluster_feature_enable}

Funktion auf einem vorhandenen Cluster aktivieren.
{: shortdesc}

<strong>Erforderliche Mindestberechtigungen:</strong> Plattformrolle **Administrator** für {{site.data.keyword.containerlong_notm}}

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>

   <dt><code>-f</code></dt>
   <dd>Verwenden Sie diese Option, um die Option <code>--trusted</code> ohne Benutzereingabeaufforderungen zu erzwingen. Dieser Wert ist optional.</dd>

   <dt><code><em>--trusted</em></code></dt>
   <dd><p>Das Flag zum Aktivieren von [Trusted Compute](cs_secure.html#trusted_compute) für alle unterstützten Bare-Metal-R einschließen, die sich im Cluster befinden. Nachdem Sie Trusted Compute aktiviert haben, können Sie es später nicht mehr inaktivieren.</p>
   <p>Um zu überprüfen, ob der Bare-Metal-Maschinentyp Trusted Compute unterstützt, überprüfen Sie das Feld **Trustable** in der Ausgabe des [Befehls](#cs_machine_types) `ibmcloud ks machine-types <zone>`. Um zu überprüfen, ob für ein Cluster Trusted Compute aktiviert wurde, sehen Sie sich das Feld **Trust ready** in der Ausgabe des [Befehls](#cs_cluster_get) `ibmcloud ks cluster-get` an. Um zu überprüfen, ob für einen Bare-Metal-Workerknoten Trusted Compute aktiviert wurde, sehen Sie sich das Feld **Trust** in der Ausgabe des [Befehls](#cs_worker_get)`ibmcloud ks worker-get` an.</p></dd>

  <dt><code>-s</code></dt>
   <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>
</dl>

**Beispielbefehl**:

  ```
  ibmcloud ks cluster-feature-enable --cluster mein_cluster --trusted=true
  ```
  {: pre}

### ibmcloud ks cluster-get --cluster CLUSTER [--json][--showResources] [-s]
{: #cs_cluster_get}

Anzeigen von Informationen zu einem Cluster in Ihrer Organisation.
{: shortdesc}

<strong>Erforderliche Mindestberechtigungen:</strong> Plattformrolle **Anzeigeberechtigter** für {{site.data.keyword.containerlong_notm}}

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>

   <dt><code>--json</code></dt>
   <dd>Druckt die Befehlsausgabe im JSON-Format. Dieser Wert ist optional.</dd>

   <dt><code><em>--showResources</em></code></dt>
   <dd>Weitere Clusterressourcen wie z. B. Add-ons, VLANs, Teilnetze und Speicher anzeigen.</dd>


  <dt><code>-s</code></dt>
  <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>
  </dl>

**Beispielbefehl**:

  ```
  ibmcloud ks cluster-get --cluster mein_cluster --showResources
  ```
  {: pre}

**Beispielausgabe**:

  ```
  Name:                   mycluster
  ID:                     df253b6025d64944ab99ed63bb4567b6
  State:                  normal
  Created:                2018-09-28T15:43:15+0000
  Location:               dal10
  Master URL:             https://169.xx.xxx.xxx:30426
  Master Location:        Dallas
  Master Status:          Ready (21 hours ago)
  Ingress Subdomain:      ...
  Ingress Secret:         mycluster
  Workers:                6
  Worker Zones:           dal10, dal12
  Version:                1.11.3_1524
  Owner:                  owner@email.com
  Monitoring Dashboard:   ...
  Resource Group ID:      a8a12accd63b437bbd6d58fb6a462ca7
  Resource Group Name:    Default

  Addons
  Name                   Enabled
  customer-storage-pod   true
  basic-ingress-v2       true
  storage-watcher-pod    true

  Subnet VLANs
  VLAN ID   Subnet CIDR         Public   User-managed
  2234947   10.xxx.xx.xxx/29    false    false
  2234945   169.xx.xxx.xxx/29  true    false

  ```
  {: screen}

### ibmcloud ks cluster-refresh --cluster CLUSTER [-f][-s]
{: #cs_cluster_refresh}

Starten Sie den Cluster-Masterknoten erneut, um die neuen Änderungen an der Kubernetes-API-Konfiguration anzuwenden. Die Workerknoten, Apps und Ressourcen werden nicht geändert und weiterhin ausgeführt.
{: shortdesc}

<strong>Erforderliche Mindestberechtigungen:</strong> Plattformrolle **Operator** für {{site.data.keyword.containerlong_notm}}

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>

   <dt><code>-f</code></dt>
   <dd>Geben Sie diese Option an, um das Entfernen eines Clusters ohne Benutzereingabeaufforderungen zu erzwingen. Dieser Wert ist optional.</dd>

   <dt><code>-s</code></dt>
   <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>

   </dl>

**Beispiel**:

  ```
  ibmcloud ks cluster-refresh --cluster mein_cluster
  ```
  {: pre}

### ibmcloud ks cluster-rm --cluster CLUSTER [--force-delete-storage][-f] [-s]
{: #cs_cluster_rm}

Entfernen eines Clusters aus der Organisation.
{: shortdesc}

<strong>Erforderliche Mindestberechtigungen:</strong> Plattformrolle **Administrator** für {{site.data.keyword.containerlong_notm}}

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>

   <dt><code>--force-delete-storage</code></dt>
   <dd>Löscht den Cluster und alle persistenten Speicher, die der Cluster verwendet. **Achtung**: Wenn Sie dieses Flag einschließen, können die im Cluster gespeicherten Daten oder die zugehörigen Speicherinstanzen nicht wiederhergestellt werden. Dieser Wert ist optional.</dd>

   <dt><code>-f</code></dt>
   <dd>Geben Sie diese Option an, um das Entfernen eines Clusters ohne Benutzereingabeaufforderungen zu erzwingen. Dieser Wert ist optional.</dd>

   <dt><code>-s</code></dt>
   <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>

   </dl>

**Beispiel**:

  ```
  ibmcloud ks cluster-rm --cluster mein_cluster
  ```
  {: pre}


### ibmcloud ks cluster-update --cluster CLUSTER [--kube-version MAJOR.MINOR.PATCH][--force-update] [-f][-s]
{: #cs_cluster_update}

Aktualisieren des Kubernetes-Masters auf die API-Standardversion. Während der Aktualisierung können Sie weder auf den Cluster zugreifen noch eine Änderung am Cluster vornehmen. Workerknoten, Apps und Ressourcen, die vom Benutzer bereitgestellt wurden, werden nicht geändert und weiterhin ausgeführt.
{: shortdesc}

Möglicherweise müssen Sie Ihre YAML-Dateien für zukünftige Bereitstellungen ändern. Lesen Sie die detaillierten Informationen in diesen [Releaseinformationen](cs_versions.html).

<strong>Erforderliche Mindestberechtigungen:</strong> Plattformrolle **Operator** für {{site.data.keyword.containerlong_notm}}

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>

   <dt><code>--kube-version <em>MAJOR.MINOR.PATCH</em></code></dt>
   <dd>Die Kubernetes-Version des Clusters. Wenn Sie keine Version angeben, wird der Kubernetes-Master auf die API-Standardversion aktualisiert. Führen Sie den Befehl [ibmcloud ks kube-versions](#cs_kube_versions) aus, um die verfügbaren Versionen anzuzeigen. Dieser Wert ist optional.</dd>

   <dt><code>--force-update</code></dt>
   <dd>Versuch einer Aktualisierung, selbst wenn die Änderung sich über mehr als zwei Nebenversionen erstreckt. Dieser Wert ist optional.</dd>

   <dt><code>-f</code></dt>
   <dd>Erzwingen Sie die Ausführung des Befehls ohne Eingabeaufforderungen. Dieser Wert ist optional.</dd>

   <dt><code>-s</code></dt>
   <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>
   </dl>

**Beispiel**:

  ```
  ibmcloud ks cluster-update --cluster mein_cluster
  ```
  {: pre}


### ibmcloud ks clusters [--json][-s]
{: #cs_clusters}

Anzeigen einer Liste der Cluster in Ihrer Organisation.
{: shortdesc}

<strong>Erforderliche Mindestberechtigungen:</strong> Plattformrolle **Anzeigeberechtigter** für {{site.data.keyword.containerlong_notm}}

<strong>Befehlsoptionen</strong>:

  <dl>
  <dt><code>--json</code></dt>
  <dd>Druckt die Befehlsausgabe im JSON-Format. Dieser Wert ist optional.</dd>

  <dt><code>-s</code></dt>
  <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>
  </dl>

**Beispiel**:

  ```
  ibmcloud ks clusters
  ```
  {: pre}


### ibmcloud ks kube-versions [--json][-s]
{: #cs_kube_versions}

Anzeigen einer Liste der Kubernetes-Versionen, die in {{site.data.keyword.containerlong_notm}} unterstützt werden. Aktualisieren Sie den [Cluster-Master](#cs_cluster_update) und die [Workerknoten](cs_cli_reference.html#cs_worker_update) auf die Standardversion für die aktuellen und stabilen Leistungsmerkmale.
{: shortdesc}

<strong>Erforderliche Mindestberechtigungen:</strong> Keine

**Befehlsoptionen**:

  <dl>
  <dt><code>--json</code></dt>
  <dd>Druckt die Befehlsausgabe im JSON-Format. Dieser Wert ist optional.</dd>

  <dt><code>-s</code></dt>
  <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>
  </dl>

**Beispiel**:

  ```
  ibmcloud ks kube-versions
  ```
  {: pre}

<br />



## Clusterbefehle: Services und Integrationen
{: #cluster_services_commands}


### ibmcloud ks cluster-service-bind --cluster CLUSTER --namespace KUBERNETES-NAMENSBEREICH --service SERVICEINSTANZNAME [-s]
{: #cs_cluster_service_bind}

Hinzufügen eines {{site.data.keyword.Bluemix_notm}}-Service zu einem Cluster. Um die verfügbaren {{site.data.keyword.Bluemix_notm}}-Services aus dem {{site.data.keyword.Bluemix_notm}}-Katalog anzuzeigen, führen Sie den Befehl `ibmcloud service offerings` aus. **Hinweis**: Es können nur {{site.data.keyword.Bluemix_notm}}-Services hinzugefügt werden, die Serviceschlüssel unterstützen.
{: shortdesc}

<strong>Erforderliche Mindestberechtigungen:</strong> Plattformrolle **Editor** für den Cluster in {{site.data.keyword.containerlong_notm}} und die Cloud Foundry-Rolle **Entwickler**

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>

   <dt><code>--namespace <em>KUBERNETES-NAMENSBEREICH</em></code></dt>
   <dd>Der Name des Kubernetes-Namensbereichs. Dieser Wert ist erforderlich.</dd>

   <dt><code>--service <em>SERVICEINSTANZNAME</em></code></dt>
   <dd>Der Name der {{site.data.keyword.Bluemix_notm}}-Serviceinstanz, die Sie binden möchten. Führen Sie <code>ibmcloud service list</code> aus, um den Namen Ihrer Serviceinstanz zu ermitteln. Wenn mehr als eine Instanz im Account denselben Namen hat, verwenden Sie die Serviceinstanz-ID anstelle des Namens. Um die ID zu suchen, führen Sie den Befehl <code>ibmcloud service show <serviceinstanzname> --guid</code> aus. Einer dieser Werte ist erforderlich.</dd>

   <dt><code>-s</code></dt>
   <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>

   </dl>

**Beispiel**:

  ```
  ibmcloud ks cluster-service-bind --cluster mein_cluster --namespace mein_namensbereich --service meine_serviceinstanz
  ```
  {: pre}


### ibmcloud ks cluster-service-unbind --cluster CLUSTER --namespace KUBERNETES-NAMENSBEREICH --service GUID_DER_SERVICEINSTANZ [-s]
{: #cs_cluster_service_unbind}

Entfernen eines {{site.data.keyword.Bluemix_notm}}-Service aus einem Cluster.
{: shortdesc}

Wenn Sie einen {{site.data.keyword.Bluemix_notm}}-Service entfernen, werden die Serviceberechtigungsnachweise aus dem Cluster entfernt. Wenn ein Pod den Service noch verwendet,
schlägt er fehl, weil die Serviceberechtigungsnachweise nicht gefunden werden können.
{: note}

<strong>Erforderliche Mindestberechtigungen:</strong> Plattformrolle **Editor** für den Cluster in {{site.data.keyword.containerlong_notm}} und die Cloud Foundry-Rolle **Entwickler**

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>

   <dt><code>--namespace <em>KUBERNETES-NAMENSBEREICH</em></code></dt>
   <dd>Der Name des Kubernetes-Namensbereichs. Dieser Wert ist erforderlich.</dd>

   <dt><code>--service <em>GUID_DER_SERVICEINSTANZ</em></code></dt>
   <dd>Die ID der {{site.data.keyword.Bluemix_notm}}-Serviceinstanz, die Sie entfernen möchten. Führen Sie `ibmcloud ks cluster-services <cluster_name_or_ID>` aus, um die ID der Serviceinstanz abzurufen. Dieser Wert ist erforderlich.</dd>

   <dt><code>-s</code></dt>
   <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>

   </dl>

**Beispiel**:

  ```
  ibmcloud ks cluster-service-unbind --cluster mein_cluster --namespace mein_namensbereich --service 8567221
  ```
  {: pre}


### ibmcloud ks cluster-services --cluster CLUSTER [--namespace KUBERNETES-NAMENSBEREICH][--all-namespaces] [--json][-s]
{: #cs_cluster_services}

Auflisten der Services, die an einen oder an alle Kubernetes-Namensbereiche in einem Cluster gebunden sind. Sind keine Optionen angegeben, werden die Services für den Standardnamensbereich angezeigt.

<strong>Erforderliche Mindestberechtigungen:</strong> Plattformrolle **Anzeigeberechtigter** für {{site.data.keyword.containerlong_notm}}

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>

   <dt><code>--namespace <em>KUBERNETES-NAMENSBEREICH</em></code>, <code>-n
<em>KUBERNETES-NAMENSBEREICH</em></code></dt>
   <dd>Schließen Sie die Services ein, die an einen bestimmten Namensbereich in einem Cluster gebunden sind. Dieser Wert ist optional.</dd>

   <dt><code>--all-namespaces</code></dt>
   <dd>Schließen Sie die Services ein, die an alle Namensbereiche in einem Cluster gebunden sind. Dieser Wert ist optional.</dd>

   <dt><code>--json</code></dt>
   <dd>Druckt die Befehlsausgabe im JSON-Format. Dieser Wert ist optional.</dd>

   <dt><code>-s</code></dt>
   <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>
   </dl>

**Beispiel**:

  ```
  ibmcloud ks cluster-services --cluster mein_cluster --namespace mein_namensbereich
  ```
  {: pre}

### ibmcloud ks va --container CONTAINER-ID [--extended][--vulnerabilities] [--configuration-issues][--json]
{: #cs_va}

Nachdem Sie [den Container-Scanner installiert haben](/docs/services/va/va_index.html#va_install_container_scanner), sehen Sie sich einen detaillierten Bericht zur Schwachstellenanalyse für einen Container in Ihrem Cluster an.

<strong>Erforderliche Mindestberechtigungen:</strong> Servicezugriffsrolle **Leseberechtigter** für {{site.data.keyword.registrylong_notm}}. **Hinweis**: Ordnen Sie keine Richtlinien für {{site.data.keyword.registryshort_notm}} auf Ressourcengruppenebene zu.

**Befehlsoptionen**:

<dl>
<dt><code>--container CONTAINER-ID</code></dt>
<dd><p>Die ID des Containers. Dieser Wert ist erforderlich.</p>
<p>Gehen Sie wie folgt vor, um nach der ID Ihres Containers zu suchen:<ol><li>[Richten Sie die Kubernetes-CLI auf Ihren Cluster aus](cs_cli_install.html#cs_cli_configure).</li><li>Listen Sie Ihre Pods auf, indem Sie `kubectl get pods` ausführen.</li><li>Suchen Sie nach dem Feld **Container ID** in der Ausgabe des Befehls `kubectl describe pod <pod_name>`. Beispiel: `Container ID: containerd://1a11a1aa2b2b22223333c44444ccc555667d7dd777888e8ef99f1011121314g15`.</li><li>Entfernen Sie das Präfix `containerd://` aus der ID, bevor Sie die Container-ID für den Befehl `ibmcloud ks va` verwenden. Beispiel: `1a11a1aa2b2b22223333c44444ccc555667d7dd777888e8ef99f1011121314g15`.</li></ol></p></dd>

<dt><code>--extended</code></dt>
<dd><p>Erweitern Sie die Befehlsausgabe, um mehr Korrekturinformationen für anfällige Pakete anzuzeigen. Dieser Wert ist optional.</p>
<p>Standardmäßig enthalten die Scanergebnisse die ID, den Richtlinienstatus, die betroffenen Pakete und einen Lösungsvorschlag. Mit dem Flag `--extended` werden Informationen wie die Zusammenfassung, der Sicherheitshinweis für Anbieter und der Link zum offiziellen Hinweis hinzugefügt.</p></dd>

<dt><code>--vulnerabilities</code></dt>
<dd>Beschränken Sie die Befehlsausgabe so, dass nur Paketschwachstellen angezeigt werden. Dieser Wert ist optional. Sie können dieses Flag nicht verwenden, wenn Sie das Flag `--configuration-issues` verwenden.</dd>

<dt><code>--configuration-issues</code></dt>
<dd>Beschränken Sie die Befehlsausgabe so, dass nur Konfigurationsprobleme angezeigt werden. Dieser Wert ist optional. Sie können dieses Flag nicht verwenden, wenn Sie das Flag `--vulnerabilities` verwenden.</dd>

<dt><code>--json</code></dt>
<dd>Druckt die Befehlsausgabe im JSON-Format. Dieser Wert ist optional.</dd>
</dl>

**Beispiel**:

```
ibmcloud ks va --container 1a11a1aa2b2b22223333c44444ccc555667d7dd777888e8ef99f1011121314g15 --extended --vulnerabilities --json
```
{: pre}

### ibmcloud ks key-protect-enable --cluster CLUSTER_NAME_OR_ID --key-protect-url ENDPOINT --key-protect-instance INSTANCE_GUID --crk ROOT_KEY_ID
{: #cs_key_protect}

Verschlüsseln Sie geheime Kubernetes-Schlüssel mithilfe von [{{site.data.keyword.keymanagementservicefull}} ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](/docs/services/key-protect/index.html#getting-started-with-key-protect) als [KMS-Provider (KMS - Key Management Service)![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tasks/administer-cluster/kms-provider/) im Cluster.
{: shortdesc}

Wenn Sie den Rootschlüssel in der {{site.data.keyword.keymanagementserviceshort}}-Instanz löschen, können Sie weder auf die Daten in den geheimen Schlüsseln im Cluster zugreifen noch diese Daten entfernen.
{: important}

<strong>Erforderliche Mindestberechtigungen:</strong> Plattformrolle **Administrator** für {{site.data.keyword.containerlong_notm}}

**Befehlsoptionen**:

<dl>
<dt><code>--container CLUSTER_NAME_OR_ID</code></dt>
<dd>Der Name oder die ID des Clusters.</dd>

<dt><code>--key-protect-url ENDPOINT</code></dt>
<dd>Der {{site.data.keyword.keymanagementserviceshort}}-Endpunkt für die Clusterinstanz. Informationen zum Abrufen des Endpunkts finden Sie unter [Serviceendpunkte nach Region](/docs/services/key-protect/regions.html#endpoints).</dd>

<dt><code>--key-protect-instance INSTANCE_GUID</code></dt>
<dd>Die GUID der {{site.data.keyword.keymanagementserviceshort}}-Instanz. Führen Sie zum Abrufen der Instanz-GUID <code>ibmcloud resource service-instance SERVICE_INSTANCE_NAME --id</code> aus und kopieren Sie den zweiten Wert (nicht den vollständigen Cloudressourcennamen).</dd>

<dt><code>--crk ROOT_KEY_ID</code></dt>
<dd>Die ID des {{site.data.keyword.keymanagementserviceshort}}-Rootschlüssels. Informationen zum Abrufen des CRK finden Sie unter [Schlüssel anzeigen](/docs/services/key-protect/view-keys.html#view-keys).</dd>
</dl>

**Beispiel**:

```
ibmcloud ks key-protect-enable --cluster mycluster --key-protect-url keyprotect.us-south.bluemix.net --key-protect-instance a11aa11a-bbb2-3333-d444-e5e555e5ee5 --crk 1a111a1a-bb22-3c3c-4d44-55e555e55e55
```
{: pre}


### ibmcloud ks webhook-create --cluster CLUSTER --level STUFE --type slack --url URL  [-s]
{: #cs_webhook_create}

Registrieren Sie einen Webhook.

<strong>Erforderliche Mindestberechtigungen:</strong> Plattformrolle **Editor** für {{site.data.keyword.containerlong_notm}}

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>

   <dt><code>--level <em>STUFE</em></code></dt>
   <dd>Die Benachrichtigungsstufe wie etwa <code>Normal</code> oder <code>Warnung</code>. <code>Warnung</code> ist der Standardwert. Dieser Wert ist optional.</dd>

   <dt><code>--type <em>slack</em></code></dt>
   <dd>Der Typ des Webhook. Gegenwärtig wird 'slack' unterstützt. Dieser Wert ist erforderlich.</dd>

   <dt><code>--url <em>URL</em></code></dt>
   <dd>Die URL für den Webhook. Dieser Wert ist erforderlich.</dd>

   <dt><code>-s</code></dt>
   <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>
   </dl>

**Beispiel**:

  ```
  ibmcloud ks webhook-create --cluster mein_cluster --level Normal --type slack --url http://github.com/mywebhook
  ```
  {: pre}


<br />


## Clusterbefehle: Teilnetze
{: #cluster_subnets_commands}

### ibmcloud ks cluster-subnet-add --cluster CLUSTER --subnet-id TEILNETZ [-s]
{: #cs_cluster_subnet_add}

Sie können vorhandene portierbare öffentliche oder private Teilnetze von Ihrem IBM Cloud-Infrastrukturkonto (SoftLayer) zu Ihrem Kubernetes-Cluster hinzufügen oder Teilnetze aus einem gelöschten Cluster wiederverwenden, anstatt die automatisch bereitgestellten Teilnetze zu verwenden.
{: shortdesc}

<p class="important">Portierbare öffentliche IP-Adressen werden monatlich berechnet. Wenn Sie nach der Bereitstellung Ihres Clusters portierbare öffentliche IP-Adressen entfernen, müssen Sie trotzdem die monatliche Gebühr bezahlen, auch wenn sie sie nur über einen kurzen Zeitraum genutzt haben.</br>
</br>Wenn Sie ein Teilnetz in einem Cluster verfügbar machen, werden IP-Adressen dieses Teilnetzes zum Zweck von Clusternetzen verwendet. Vermeiden Sie IP-Adresskonflikte, indem Sie ein Teilnetz mit nur einem Cluster verwenden. Verwenden Sie kein Teilnetz für mehrere Cluster oder für andere
Zwecke außerhalb von {{site.data.keyword.containerlong_notm}} gleichzeitig.</br>
</br>Um die Kommunikation zwischen Workern, die sich in verschiedenen Teilnetzen im selben VLAN befinden, zu aktivieren, müssen Sie [die Weiterleitung zwischen Teilnetzen im selben VLAN aktivieren](cs_subnets.html#subnet-routing).</p>

<strong>Erforderliche Mindestberechtigungen:</strong> Plattformrolle **Operator** für {{site.data.keyword.containerlong_notm}}

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>

   <dt><code>--subnet-id <em>TEILNETZ</em></code></dt>
   <dd>Die ID des Teilnetzes. Dieser Wert ist erforderlich.</dd>

   <dt><code>-s</code></dt>
   <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>

   </dl>

**Beispiel**:

  ```
  ibmcloud ks cluster-subnet-add --cluster mein_cluster --subnet-id 1643389
  ```
  {: pre}


### ibmcloud ks cluster-subnet-create --cluster CLUSTER --size GRÖSSE --vlan VLAN-ID [-s]
{: #cs_cluster_subnet_create}

Erstellung eines Teilnetzes in einem Konto der IBM Cloud-Infrastruktur (SoftLayer) und Zurverfügungstellung dieses Teilnetzes für einen angegebenen Cluster in {{site.data.keyword.containerlong_notm}}.

<p class="important">Wenn Sie ein Teilnetz in einem Cluster verfügbar machen, werden IP-Adressen dieses Teilnetzes zum Zweck von Clusternetzen verwendet. Vermeiden Sie IP-Adresskonflikte, indem Sie ein Teilnetz mit nur einem Cluster verwenden. Verwenden Sie kein Teilnetz für mehrere Cluster oder für andere
Zwecke außerhalb von {{site.data.keyword.containerlong_notm}} gleichzeitig.</br>
</br>Wenn Sie über mehrere VLANs für einen Cluster, mehrere Teilnetze in demselben VLAN oder einen Cluster mit mehreren Zonen verfügen, müssen Sie [VLAN-Spanning](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) für Ihr Konto für die IBM Cloud-Infrastruktur (SoftLayer) aktivieren, damit die Workerknoten in dem privaten Netz miteinander kommunizieren können. Um diese Aktion durchführen zu können, müssen Sie über die [Infrastrukturberechtigung](cs_users.html#infra_access) **Netz > VLAN-Spanning im Netz verwalten** verfügen oder Sie können den Kontoeigner bitte, diese zu aktivieren. Um zu prüfen, ob das VLAN-Spanning bereits aktiviert ist, verwenden Sie den [Befehl](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`. Wenn Sie {{site.data.keyword.BluDirectLink}} verwenden, müssen Sie stattdessen eine [ VRF-Funktion (Virtual Router Function)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf) verwenden. Um VRF zu aktivieren, wenden Sie sich an Ihren Ansprechpartner für die IBM Cloud-Infrastruktur (SoftLayer).</p>

<strong>Erforderliche Mindestberechtigungen:</strong> Plattformrolle **Operator** für {{site.data.keyword.containerlong_notm}}

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich. Zum Auflisten Ihrer Cluster verwenden Sie den [Befehl `ibmcloud ks clusters`](#cs_clusters).</dd>

   <dt><code>--size <em>GRÖSSE</em></code></dt>
   <dd>Die Anzahl der IP-Teilnetzadressen. Dieser Wert ist erforderlich. Gültige Werte sind 8, 16, 32 oder 64.</dd>

   <dd>Das VLAN, in dem das Teilnetz erstellt werden soll. Dieser Wert ist erforderlich. Verwenden Sie zum Auflisten der verfügbaren VLANs den [Befehl `ibmcloud ks vlans <zone>`](#cs_vlans). Das Teilnetz wird in derselben Zone bereitgestellt, in der sich das VLAN befindet.</dd>

   <dt><code>-s</code></dt>
   <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>

   </dl>

**Beispiel**:

  ```
  ibmcloud ks cluster-subnet-create --cluster mein_cluster --size 8 --vlan 1764905
  ```
  {: pre}


### ibmcloud ks cluster-user-subnet-add --cluster CLUSTER --subnet-cidr TEILNETZ-CIDR --private-vlan PRIVATES_VLAN
{: #cs_cluster_user_subnet_add}

Verwenden Sie das eigene private Teilnetz in Ihren {{site.data.keyword.containerlong_notm}}-Clustern.

Dieses private Teilnetz wird nicht von der IBM Cloud-Infrastruktur (SoftLayer) bereitgestellt. Deshalb müssen Sie das gesamte Routing für ein- und ausgehenden Netzverkehr für das Teilnetz konfigurieren. Um ein Teilnetz der IBM Cloud-Infrastruktur (SoftLayer) hinzuzufügen, verwenden Sie den [Befehl `ibmcloud ks cluster-subnet-add`](#cs_cluster_subnet_add).

<p class="important">Wenn Sie ein Teilnetz in einem Cluster verfügbar machen, werden IP-Adressen dieses Teilnetzes zum Zweck von Clusternetzen verwendet. Vermeiden Sie IP-Adresskonflikte, indem Sie ein Teilnetz mit nur einem Cluster verwenden. Verwenden Sie kein Teilnetz für mehrere Cluster oder für andere
Zwecke außerhalb von {{site.data.keyword.containerlong_notm}} gleichzeitig.</br>
</br>Wenn Sie über mehrere VLANs für einen Cluster, mehrere Teilnetze in demselben VLAN oder einen Cluster mit mehreren Zonen verfügen, müssen Sie [VLAN-Spanning](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) für Ihr Konto für die IBM Cloud-Infrastruktur (SoftLayer) aktivieren, damit die Workerknoten in dem privaten Netz miteinander kommunizieren können. Um diese Aktion durchführen zu können, müssen Sie über die [Infrastrukturberechtigung](cs_users.html#infra_access) **Netz > VLAN-Spanning im Netz verwalten** verfügen oder Sie können den Kontoeigner bitte, diese zu aktivieren. Um zu prüfen, ob das VLAN-Spanning bereits aktiviert ist, verwenden Sie den [Befehl](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`. Wenn Sie {{site.data.keyword.BluDirectLink}} verwenden, müssen Sie stattdessen eine [ VRF-Funktion (Virtual Router Function)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf) verwenden. Um VRF zu aktivieren, wenden Sie sich an Ihren Ansprechpartner für die IBM Cloud-Infrastruktur (SoftLayer).</p>

<strong>Erforderliche Mindestberechtigungen:</strong> Plattformrolle **Operator** für {{site.data.keyword.containerlong_notm}}

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>

   <dt><code>--subnet-cidr <em>TEILNETZ-CIDR</em></code></dt>
   <dd>Das CIDR (Classless InterDomain Routing) des Teilnetzes. Dieser Wert ist erforderlich und darf keinen Konflikt mit einem anderen Teilnetz verursachen, das von der IBM Cloud-Infrastruktur (SoftLayer) verwendet wird.

   Die unterstützten Präfixe liegen zwischen `/30` (1 IP-Adresse) und `/24` (253 IP-Adressen). Wenn Sie das CIDR mit einer Präfixlänge festlegen und später ändern müssen, dann sollten Sie zuerst das neue CIDR hinzufügen und anschließend das [alte CIDR entfernen](#cs_cluster_user_subnet_rm).</dd>

   <dt><code>--private-vlan <em>PRIVATES_VLAN</em></code></dt>
   <dd>Die ID des privaten VLAN. Dieser Wert ist erforderlich. Er muss mit der ID des privaten VLAN für mindestens einen Workerknoten im Cluster übereinstimmen.</dd>
   </dl>

**Beispiel**:

  ```
  ibmcloud ks cluster-user-subnet-add --cluster mein_cluster --subnet-cidr 169.xx.xxx.xxx/29 --private-vlan 1502175
  ```
  {: pre}


### ibmcloud ks cluster-user-subnet-rm --cluster CLUSTER --subnet-cidr TEILNETZ-CIDR --private-vlan PRIVATES_VLAN
{: #cs_cluster_user_subnet_rm}

Entfernen des eigenen privaten Teilnetzes aus einem angegebenen Cluster. Jeder Service, der für eine IP-Adresse aus dem eigenen privaten Teilnetz bereitgestellt wurde, bleibt nach der Entfernung des Teilnetzes weiterhin aktiv.

<strong>Erforderliche Mindestberechtigungen:</strong> Plattformrolle **Operator** für {{site.data.keyword.containerlong_notm}}

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>

   <dt><code>--subnet-cidr <em>TEILNETZ-CIDR</em></code></dt>
   <dd>Das CIDR (Classless InterDomain Routing) des Teilnetzes. Dieser Wert ist erforderlich und muss mit dem CIDR übereinstimmen, das mit dem [Befehl `ibmcloud ks cluster-user-subnet-add`](#cs_cluster_user_subnet_add) festgelegt wurde.</dd>

   <dt><code>--private-vlan <em>PRIVATES_VLAN</em></code></dt>
   <dd>Die ID des privaten VLAN. Dieser Wert ist erforderlich und muss mit der VLAN-ID übereinstimmen, die mit dem [Befehl `bmcloud ks cluster-user-subnet-add`](#cs_cluster_user_subnet_add) festgelegt wurde.</dd>
   </dl>

**Beispiel**:

  ```
  ibmcloud ks cluster-user-subnet-rm --cluster mein_cluster --subnet-cidr 169.xx.xxx.xxx/29 --private-vlan 1502175
  ```
  {: pre}

### ibmcloud ks subnets [--json][-s]
{: #cs_subnets}

Anzeigen einer Liste der Teilnetze, die in einem Konto der IBM Cloud-Infrastruktur (SoftLayer) verfügbar sind.

<strong>Erforderliche Mindestberechtigungen:</strong> Plattformrolle **Anzeigeberechtigter** für {{site.data.keyword.containerlong_notm}}

<strong>Befehlsoptionen</strong>:

  <dl>
  <dt><code>--json</code></dt>
  <dd>Druckt die Befehlsausgabe im JSON-Format. Dieser Wert ist optional.</dd>

  <dt><code>-s</code></dt>
  <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>
  </dl>

**Beispiel**:

  ```
  ibmcloud ks subnets
  ```
  {: pre}


<br />


## Ingress-Befehle für die Lastausgleichsfunktion für Anwendungen (ALB)
{: #alb_commands}

### ibmcloud ks alb-autoupdate-disable --cluster CLUSTER
{: #cs_alb_autoupdate_disable}

Standardmäßig sind automatische Aktualisierungen für das Ingress-ALB-Add-on (Application Load Balancer, Lastausgleichsfunktion für Anwendungen) aktiviert. ALB-Pods werden automatisch aktualisiert, wenn eine neue Buildversion verfügbar ist. Wenn Sie das Add-on stattdessen manuell aktualisieren möchten, inaktivieren Sie mit diesem Befehl die automatischen Aktualisierungen. Anschließend können Sie ALB-Pods aktualisieren, indem Sie den [Befehl `ibmcloud ks alb-update`](#cs_alb_update) ausführen.

Wenn Sie die Kubernetes-Hauptversion oder -Nebenversion Ihres Clusters aktualisieren, nimmt IBM automatisch die erforderlichen Änderungen an der Ingress-Bereitstellung vor, ändert aber nicht die Buildversion Ihres Add-ons für die Lastausgleichsfunktion für Ihre Ingress-Anwendungen. Sie sind dafür verantwortlich, die Kompatibilität der aktuellen Kubernetes-Versionen und Ihrer Images des Add-ons für die Lastausgleichsfunktion für Ingress-Anwendungen zu prüfen.

**Erforderliche Mindestberechtigungen:** Plattformrolle **Editor** für {{site.data.keyword.containerlong_notm}}

**Beispiel**:

```
ibmcloud ks alb-autoupdate-disable --cluster mycluster
```
{: pre}

### ibmcloud ks alb-autoupdate-enable --cluster CLUSTER
{: #cs_alb_autoupdate_enable}

Wenn die automatischen Aktualisierungen für das Ingress-ALB-Add-on inaktiviert sind, können Sie diese wieder aktivieren. Sobald die nächste Buildversion verfügbar ist, werden die ALBs automatisch auf den neuen Build aktualisiert.

**Erforderliche Mindestberechtigungen:** Plattformrolle **Editor** für {{site.data.keyword.containerlong_notm}}

**Beispiel**:

```
ibmcloud ks alb-autoupdate-enable --cluster mycluster
```
{: pre}

### ibmcloud ks alb-autoupdate-get --cluster CLUSTER
{: #cs_alb_autoupdate_get}

Prüfen Sie, ob die automatischen Aktualisierungen für das Ingress-ALB-Add-on aktiviert sind und ob Ihre ALBs auf die neue Buildversion aktualisiert wurden.

**Erforderliche Mindestberechtigungen:** Plattformrolle **Editor** für {{site.data.keyword.containerlong_notm}}

**Beispiel**:

```
ibmcloud ks alb-autoupdate-get --cluster mycluster
```
{: pre}

### ibmcloud ks alb-cert-deploy [--update] --cluster CLUSTER --secret-name NAME_DES_GEHEIMEN_SCHLÜSSELS --cert-crn CRN_DES_ZERTIFIKATS [--update][-s]
{: #cs_alb_cert_deploy}

Stellen Sie für die Lastausgleichsfunktion für Anwendungen (ALB) in einem Cluster ein Zertifikat bereit oder aktualisieren Sie ein Zertifikat aus der verwendeten Instanz von {{site.data.keyword.cloudcerts_long_notm}}. Sie können lediglich Zertifikate aktualisieren, die aus derselben Instanz von {{site.data.keyword.cloudcerts_long_notm}} importiert werden.

<strong>Erforderliche Mindestberechtigungen:</strong> Plattformrolle **Administrator** für {{site.data.keyword.containerlong_notm}}

<strong>Befehlsoptionen</strong>

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>

   <dt><code>--update</code></dt>
   <dd>Aktualisieren Sie das Zertifikat für einen geheimen Schlüssel der Lastausgleichsfunktion für Anwendungen (ALB) in einem Cluster. Dieser Wert ist optional.</dd>

   <dt><code>--secret-name <em>NAME_DES_GEHEIMEN_SCHLÜSSELS</em></code></dt>
   <dd>Der Name des geheimen Schlüssels der Lastausgleichsfunktion für Anwendungen (Application Load Balancer, ALB). Dieser Wert ist erforderlich.</dd>

   <dt><code>--cert-crn <em>CRN_DES_ZERTIFIKATS</em></code></dt>
   <dd>Die CRN des Zertifikats. Dieser Wert ist erforderlich.</dd>

   <dt><code>-s</code></dt>
   <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>
   </dl>

**Beispiele**:

Beispiel für die Bereitstellung eines geheimen ALB-Schlüssels:

   ```
   ibmcloud ks alb-cert-deploy --secret-name mein_geheimer_schlüssel_der_alb --cluster mein_cluster --cert-crn crn:v1:staging:public:cloudcerts:us-south:a/06580c923e40314421d3b6cb40c01c68:0db4351b-0ee1-479d-af37-56a4da9ef30f:certificate:4bc35b7e0badb304e60aef00947ae7ff
   ```
   {: pre}

Beispiel für die Aktualisierung eines vorhandenen geheimen ALB-Schlüssels:

 ```
 ibmcloud ks alb-cert-deploy --update --secret-name mein_geheimer_schlüssel_der_alb --cluster mein_cluster --cert-crn crn:v1:staging:public:cloudcerts:us-south:a/06580c923e40314421d3b6cb40c01c68:0db4351b-0ee1-479d-af37-56a4da9ef30f:certificate:7e21fde8ee84a96d29240327daee3eb2
 ```
 {: pre}


### ibmcloud ks alb-cert-get --cluster CLUSTER [--secret-name NAME_DES_GEHEIMEN_SCHLÜSSELS][--cert-crn CERTIFICATE_CRN] [--json][-s]
{: #cs_alb_cert_get}

Informationen über einen geheimen ALB-Schlüssel in einem Cluster anzeigen.

<strong>Erforderliche Mindestberechtigungen:</strong> Plattformrolle **Administrator** für {{site.data.keyword.containerlong_notm}}

<strong>Befehlsoptionen</strong>

  <dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
  <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>

  <dt><code>--secret-name <em>NAME_DES_GEHEIMEN_SCHLÜSSELS</em></code></dt>
  <dd>Der Name des geheimen Schlüssels der Lastausgleichsfunktion für Anwendungen (Application Load Balancer, ALB). Dieser Wert ist erforderlich, um Informationen zu einem bestimmten geheimen ALB-Schlüssel im Cluster abzurufen.</dd>

  <dt><code>--cert-crn <em>CRN_DES_ZERTIFIKATS</em></code></dt>
  <dd>Die CRN des Zertifikats. Dieser Wert ist erforderlich, um Informationen zu allen geheimen ALB-Schlüsseln abzurufen, die mit der CRN eines bestimmten Zertifikats im Cluster übereinstimmen.</dd>

  <dt><code>--json</code></dt>
  <dd>Druckt die Befehlsausgabe im JSON-Format. Dieser Wert ist optional.</dd>

  <dt><code>-s</code></dt>
  <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>
  </dl>

**Beispiele**:

 Beispiel für das Abrufen von Informationen zu einem geheimen ALB-Schlüssel:

 ```
 ibmcloud ks alb-cert-get --cluster mein_cluster --secret-name mein_geheimer_schlüssel_der_alb
 ```
 {: pre}

 Beispiel für das Abrufen von Informationen zu allen geheimen ALB-Schlüsseln, die mit der CRN eines bestimmten Zertifikats übereinstimmen:

 ```
 ibmcloud ks alb-cert-get --cluster mein_cluster --cert-crn  crn:v1:staging:public:cloudcerts:us-south:a/06580c923e40314421d3b6cb40c01c68:0db4351b-0ee1-479d-af37-56a4da9ef30f:certificate:4bc35b7e0badb304e60aef00947ae7ff
 ```
 {: pre}


### ibmcloud ks alb-cert-rm --cluster CLUSTER [--secret-name NAME_DES_GEHEIMEN_SCHLÜSSELS][--cert-crn CERTIFICATE_CRN] [-s]
{: #cs_alb_cert_rm}

Entfernen eines geheimen ALB-Schlüssels in einem Cluster.

<strong>Erforderliche Mindestberechtigungen:</strong> Plattformrolle **Administrator** für {{site.data.keyword.containerlong_notm}}

<strong>Befehlsoptionen</strong>

  <dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
  <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>

  <dt><code>--secret-name <em>NAME_DES_GEHEIMEN_SCHLÜSSELS</em></code></dt>
  <dd>Der Name des geheimen Schlüssels der Lastausgleichsfunktion für Anwendungen (Application Load Balancer, ALB). Dieser Wert ist erforderlich, um einen bestimmten geheimen ALB-Schlüssel im Cluster zu entfernen.</dd>

  <dt><code>--cert-crn <em>CRN_DES_ZERTIFIKATS</em></code></dt>
  <dd>Die CRN des Zertifikats. Dieser Wert ist erforderlich, um alle geheimen ALB-Schlüssel zu entfernen, die mit der CRN eines bestimmten Zertifikats im Cluster übereinstimmen.</dd>

  <dt><code>-s</code></dt>
  <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>

  </dl>

**Beispiele**:

 Beispiel für das Entfernen eines geheimen ALB-Schlüssels:

 ```
 ibmcloud ks alb-cert-rm --cluster mein_cluster --secret-name mein_geheimer_schlüssel_der_alb
 ```
 {: pre}

 Beispiel für das Entfernen aller geheimen ALB-Schlüssel, die mit der CRN eines bestimmten Zertifikats übereinstimmen:

 ```
 ibmcloud ks alb-cert-rm --cluster mein_cluster --cert-crn crn:v1:staging:public:cloudcerts:us-south:a/06580c923e40314421d3b6cb40c01c68:0db4351b-0ee1-479d-af37-56a4da9ef30f:certificate:4bc35b7e0badb304e60aef00947ae7ff
 ```
 {: pre}


### ibmcloud ks alb-certs --cluster CLUSTER [--json][-s]
{: #cs_alb_certs}

Anzeigen einer Liste der geheimen ALB-Schlüssel in einem Cluster.

<strong>Erforderliche Mindestberechtigungen:</strong> Plattformrolle **Administrator** für {{site.data.keyword.containerlong_notm}}

<strong>Befehlsoptionen</strong>

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>
   <dt><code>--json</code></dt>
   <dd>Druckt die Befehlsausgabe im JSON-Format. Dieser Wert ist optional.</dd>
   <dt><code>-s</code></dt>
   <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>
   </dl>

**Beispiel**:

 ```
 ibmcloud ks alb-certs --cluster mein_cluster
 ```
 {: pre}

### ibmcloud ks alb-configure --albID ALB_ID [--enable][--user-ip USERIP] [--disable][--disable-deployment] [-s]
{: #cs_alb_configure}

Aktivieren oder Inaktivieren einer Lastausgleichsfunktion für Anwendungen (ALB) in Ihrem Standardcluster. Die öffentliche Lastausgleichsfunktion für Anwendungen (ALB) ist standardmäßig aktiviert.

<strong>Erforderliche Mindestberechtigungen:</strong> Plattformrolle **Editor** für {{site.data.keyword.containerlong_notm}}

**Befehlsoptionen**:

   <dl>
   <dt><code><em>--albID </em>ALB-ID</code></dt>
   <dd>Die ID für eine ALB. Führen Sie <code>ibmcloud ks albs <em>--cluster </em>CLUSTER</code> aus, um die IDs für die ALBs in einem Cluster anzuzeigen. Dieser Wert ist erforderlich.</dd>

   <dt><code>--enable</code></dt>
   <dd>Schließen Sie dieses Flag ein, um eine ALB in einem Cluster zu aktivieren.</dd>

   <dt><code>--disable</code></dt>
   <dd>Schließen Sie dieses Flag ein, um eine ALB in einem Cluster zu inaktivieren.</dd>

   <dt><code>--disable-deployment</code></dt>
   <dd>Schließen Sie dieses Flag ein, um die von IBM bereitgestellte ALB-Bereitstellung zu inaktivieren. Bei Verwendung dieses Flags wird nicht die DNS-Registrierung für die von IBM bereitgestellte Ingress-Unterdomäne oder der Lastausgleichsservice, der zum Bereitstellen des Ingress-Controllers verwendet wird, entfernt.</dd>

   <dt><code>--user-ip <em>BENUTZER-IP</em></code></dt>
   <dd>

   <ul>
    <li>Dieser Parameter ist nur für die Aktivierung einer privaten Lastausgleichsfunktion für Anwendungen (ALB) verfügbar.</li>
    <li>Die private ALB wird mit einer IP-Adresse aus einem von einem Benutzer bereitgestellten privaten Teilnetz implementiert. Wird keine IP-Adresse bereitgestellt, wird die Lastausgleichsfunktion für Anwendungen (ALB) mit einer privaten IP-Adresse aus dem portierbaren, privaten Teilnetz bereitgestellt, die beim Erstellen des Clusters automatisch bereitgestellt wurde.</li>
   </ul>
   </dd>

   <dt><code>-s</code></dt>
   <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>

   </dl>

**Beispiele**:

  Beispiel für die Aktivierung einer ALB:

  ```
  ibmcloud ks alb-configure --albID private-cr18a61a63a6a94b658596aa93a087aaa9-alb1 --enable
  ```
  {: pre}

  Beispiel für die Aktivierung einer ALB mit einer von einem Benutzer bereitgestellten IP-Adresse:

  ```
  ibmcloud ks alb-configure --albID private-cr18a61a63a6a94b658596aa93a087aaa9-alb1 --enable --user-ip benutzer-ip
  ```
  {: pre}

  Beispiel für die Inaktivierung einer ALB:

  ```
  ibmcloud ks alb-configure --albID public-cr18a61a63a6a94b658596aa93a087aaa9-alb1 --disable
  ```
  {: pre}

### ibmcloud ks alb-get --albID ALB-ID [--json][-s]
{: #cs_alb_get}

Zeigen Sie die Details einer Lastausgleichsfunktion für Anwendungen (ALB) an.

<strong>Erforderliche Mindestberechtigungen:</strong> Plattformrolle **Anzeigeberechtigter** für {{site.data.keyword.containerlong_notm}}

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code><em>--albID </em>ALB-ID</code></dt>
   <dd>Die ID für eine ALB. Führen Sie <code>ibmcloud ks albs --cluster <em>CLUSTER</em></code> aus, um die IDs für die ALBs in einem Cluster anzuzeigen. Dieser Wert ist erforderlich.</dd>

   <dt><code>--json</code></dt>
   <dd>Druckt die Befehlsausgabe im JSON-Format. Dieser Wert ist optional.</dd>

  <dt><code>-s</code></dt>
  <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>

   </dl>

**Beispiel**:

  ```
  ibmcloud ks alb-get --albID public-cr18a61a63a6a94b658596aa93a087aaa9-alb1
  ```
  {: pre}

### ibmcloud ks alb-rollback --cluster CLUSTER
{: #cs_alb_rollback}

Wenn Ihre ALB-Pods vor Kurzem aktualisiert wurden, aber eine angepasste Konfiguration für Ihre ALBs von dem letzten Build betroffen ist, können Sie die Aktualisierung rückgängig machen und wieder den Build herstellen, den Ihre ALB-Pods zuvor ausgeführt hatten. Nachdem Sie eine Aktualisierung rückgängig gemacht haben, werden die automatischen Aktualisierungen für ALB-Pods inaktiviert. Um die automatischen Aktualisierungen wieder zu aktivieren, verwenden Sie den [Befehl `alb-autoupdate-enable`](#cs_alb_autoupdate_enable).

**Erforderliche Mindestberechtigungen:** Plattformrolle **Editor** für {{site.data.keyword.containerlong_notm}}

**Beispiel**:

```
ibmcloud ks alb-rollback --cluster mycluster
```
{: pre}

### ibmcloud ks alb-types [--json][-s]
{: #cs_alb_types}

Anzeigen der ALB-Typen, die in der Region unterstützt werden.

<strong>Erforderliche Mindestberechtigungen:</strong> Plattformrolle **Anzeigeberechtigter** für {{site.data.keyword.containerlong_notm}}

<strong>Befehlsoptionen</strong>:

  <dl>
  <dt><code>--json</code></dt>
  <dd>Druckt die Befehlsausgabe im JSON-Format. Dieser Wert ist optional.</dd>

  <dt><code>-s</code></dt>
  <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>
  </dl>

**Beispiel**:

  ```
  ibmcloud ks alb-types
  ```
  {: pre}

### ibmcloud ks alb-update --cluster CLUSTER
{: #cs_alb_update}

Wenn die automatischen Aktualisierungen für das Ingress-ALB-Add-on inaktiviert sind und Sie das Add-on aktualisieren möchten, können Sie eine einmalige Aktualisierung Ihrer ALB-Pods erzwingen. Wenn Sie das Add-on manuell aktualisieren, werden alle ALB-Pods in dem Cluster auf den neuen Build aktualisiert. Sie können nicht eine einzelne ALB aktualisieren oder auswählen, auf welchen Build das Add-on aktualisiert werden soll. Die automatischen Aktualisierungen bleiben inaktiviert.

Wenn Sie die Kubernetes-Hauptversion oder -Nebenversion Ihres Clusters aktualisieren, nimmt IBM automatisch die erforderlichen Änderungen an der Ingress-Bereitstellung vor, ändert aber nicht die Buildversion Ihres Add-ons für die Lastausgleichsfunktion für Ihre Ingress-Anwendungen. Sie sind dafür verantwortlich, die Kompatibilität der aktuellen Kubernetes-Versionen und Ihrer Images des Add-ons für die Lastausgleichsfunktion für Ingress-Anwendungen zu prüfen.

**Erforderliche Mindestberechtigungen:** Plattformrolle **Editor** für {{site.data.keyword.containerlong_notm}}

**Beispiel**:

```
ibmcloud ks alb-update --cluster <clustername_oder_-id>
```
{: pre}

### ibmcloud ks albs --cluster CLUSTER [--json][-s]
{: #cs_albs}

Anzeigen des Status aller Lastausgleichsfunktionen für Anwendungen (ALBs) in einem Cluster. Wenn keine ALB-IDs zurückgegeben werden, verfügt der Cluster nicht über ein portierbares Teilnetz. Sie können Teilnetze [erstellen](#cs_cluster_subnet_create) oder zu einem Cluster [hinzufügen](#cs_cluster_subnet_add).

<strong>Erforderliche Mindestberechtigungen:</strong> Plattformrolle **Anzeigeberechtigter** für {{site.data.keyword.containerlong_notm}}

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code><em>--cluster </em>CLUSTER</code></dt>
   <dd>Der Name oder die ID des Clusters, in dem Sie verfügbare Lastausgleichsfunktionen für Anwendungen (ALBs) auflisten. Dieser Wert ist erforderlich.</dd>

   <dt><code>--json</code></dt>
   <dd>Druckt die Befehlsausgabe im JSON-Format. Dieser Wert ist optional.</dd>

   <dt><code>-s</code></dt>
   <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>

   </dl>

**Beispiel**:

  ```
  ibmcloud ks albs --cluster mein_cluster
  ```
  {: pre}


<br />


## Befehle für die Infrastruktur
{: #infrastructure_commands}

### ibmcloud ks credential-get [-s][--json]
{: #cs_credential_get}

Wenn Sie Ihr IBM Cloud-Konto so konfigurieren, dass für den Zugriff auf das IBM Cloud-Infrastrukturportfolio unterschiedliche Berechtigungsnachweise verwendet werden, rufen Sie den Infrastrukturbenutzernamen für die Region und die Ressourcengruppe ab, die derzeit das Ziel sind.

<strong>Erforderliche Mindestberechtigungen:</strong> Plattformrolle **Anzeigeberechtigter** für {{site.data.keyword.containerlong_notm}}

<strong>Befehlsoptionen</strong>:

 <dl>
 <dt><code>--json</code></dt>
 <dd>Druckt die Befehlsausgabe im JSON-Format. Dieser Wert ist optional.</dd>
 <dt><code>-s</code></dt>
 <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>
 </dl>

**Beispiel:**
```
ibmcloud ks credential-get
```
{: pre}

**Beispielausgabe:**
```
Infrastructure credentials for user name user@email.com set for resource group default.
```

### ibmcloud ks credential-set --infrastructure-api-key API-SCHLÜSSEL --infrastructure-username BENUTZERNAME [-s]
{: #cs_credentials_set}

Festlegen von Berechtigungsnachweisen für das Konto der IBM Cloud-Infrastruktur (SoftLayer) für eine {{site.data.keyword.containerlong_notm}}-Ressourcengruppe und -Region.

Wenn Sie über ein nutzungsabhängiges {{site.data.keyword.Bluemix_notm}}-Konto verfügen, haben Sie standardmäßig Zugriff auf das Portfolio der IBM Cloud-Infrastruktur. Es kann jedoch sein, dass Sie ein anderes IBM Cloud-Infrastrukturkonto (SoftLayer) verwenden möchten, das Sie bereits für die Infrastrukturbestellung verwenden. Sie können dieses Infrastrukturkonto über den folgenden Befehl mit Ihrem {{site.data.keyword.Bluemix_notm}}-Konto verknüpfen.

Falls die Berechtigungsnachweise für die IBM Cloud-Infrastruktur (SoftLayer) für eine Region und Ressourcengruppe manuell definiert wurden, werden diese Berechtigungsnachweise für die Bestellung von Infrastruktur für alle Cluster in der Region verwendet. Diese Berechtigungsnachweise werden verwendet, um Infrastrukturberechtigungen zu bestimmen, selbst wenn bereits ein [{{site.data.keyword.Bluemix_notm}}IAM-API-Schlüssel](#cs_api_key_info) für die Ressourcengruppe und Region vorhanden ist. Wenn der Benutzer, dessen Berechtigungsnachweise gespeichert wurden, nicht über die erforderlichen Berechtigungen zum Bestellen von Infrastruktur verfügt, können infrastrukturbezogene Aktionen, wie z. B. das Erstellen eines Clusters oder das erneute Laden eines Workerknotens, fehlschlagen.

Sie können nicht mehrere Berechtigungsnachweise für dieselbe {{site.data.keyword.containerlong_notm}}-Ressourcengruppe und -Region festlegen.

Stellen Sie vor Verwendung dieses Befehls sicher, dass der Benutzer, dessen Berechtigungsnachweise verwendet werden, über die erforderlichen Berechtigungen für [{{site.data.keyword.containerlong_notm}} und die IBM Cloud-Infrastruktur (SoftLayer) verfügt](cs_users.html#users).
{: important}

<strong>Erforderliche Mindestberechtigungen:</strong> Plattformrolle **Administrator** für {{site.data.keyword.containerlong_notm}}

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code>--infrastructure-username <em>BENUTZERNAME</em></code></dt>
   <dd>Der API-Benutzername für ein Konto der IBM Cloud-Infrastruktur (SoftLayer). Dieser Wert ist erforderlich. Beachten Sie, dass der API-Benutzername nicht der IBMid entspricht. Gehen Sie wie folgt vor, um den API-Benutzernamen für die IBM Cloud-Infrastruktur anzuzeigen:
   <ol><li>Melden Sie sich beim [{{site.data.keyword.Bluemix_notm}}-Portal ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://console.bluemix.net/) an.</li>
   <li>Wählen Sie im Menü ![Menüsymbol](../icons/icon_hamburger.svg "Menüsymbol") die Option **Infrastruktur** aus.</li>
   <li>Wählen Sie in der Menüleiste **Konto** > **Benutzer** > **Benutzerliste** aus.</li>
   <li>Klicken Sie für den Benutzer, der angezeigt werden soll, auf **IBMid oder Benutzername**.</li>
   <li>Rufen Sie im Abschnitt **API-Zugriffsinformationen** den **API-Benutzernamen** auf.</li>
   </ol></dd>


   <dt><code>--infrastructure-api-key <em>API-SCHLÜSSEL</em></code></dt>
   <dd>Der API-Schlüssel für ein Konto der IBM Cloud-Infrastruktur (SoftLayer). Dieser Wert ist erforderlich.

 <p>
  Gehen Sie wie folgt vor, um einen API-Schlüssel zu generieren:

  <ol>
  <li>Melden Sie sich beim [Portal der IBM Cloud-Infrastruktur (SoftLayer) ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://control.bluemix.net/) an.</li>
  <li>Wählen Sie <strong>Konto</strong> und dann <strong>Benutzer</strong> aus.</li>
  <li>Klicken Sie auf <strong>Generieren</strong>, um einen API-Schlüssel der IBM Cloud-Infrastruktur (SoftLayer) für Ihr Konto zu generieren.</li>
  <li>Kopieren Sie den API-Schlüssel, um diesen Befehl verwenden zu können.</li>
  </ol>

  Gehen Sie wie folgt vor, um Ihren API-Schlüssel anzuzeigen:
  <ol>
  <li>Melden Sie sich beim [Portal der IBM Cloud-Infrastruktur (SoftLayer) ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://control.bluemix.net/) an.</li>
  <li>Wählen Sie <strong>Konto</strong> und dann <strong>Benutzer</strong> aus.</li>
  <li>Klicken Sie auf <strong>Anzeigen</strong>, um den bestehenden API-Schlüssel anzuzeigen.</li>
  <li>Kopieren Sie den API-Schlüssel, um diesen Befehl verwenden zu können.</li>
  </ol>
  </p></dd>

  <dt><code>-s</code></dt>
  <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>

  </dl>

**Beispiel**:

  ```
  ibmcloud ks credential-set --infrastructure-api-key <api-schlüssel> --infrastructure-username dbmanager
  ```
  {: pre}

### ibmcloud ks credential-unset
{: #cs_credentials_unset}

Entfernen Sie die Kontoberechtigungsnachweise der IBM Cloud-Infrastruktur (SoftLayer) aus einer {{site.data.keyword.containerlong_notm}}-Region.

Nachdem Sie die Berechtigungsnachweise entfernt haben, wird der [{{site.data.keyword.Bluemix_notm}}IAM-API-Schlüssel](#cs_api_key_info) verwendet, um Ressourcen in der IBM Cloud-Infrastruktur (SoftLayer) zu bestellen.

<strong>Erforderliche Mindestberechtigungen:</strong> Plattformrolle **Administrator** für {{site.data.keyword.containerlong_notm}}

<strong>Befehlsoptionen</strong>:

  <dl>
  <dt><code>-s</code></dt>
  <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>
  </dl>

**Beispiel**:

  ```
  ibmcloud ks credential-unset
  ```
  {: pre}


### ibmcloud ks machine-types --zone ZONE [--json][-s]
{: #cs_machine_types}

Anzeige einer Liste der für Ihre Workerknoten verfügbaren Maschinentypen. Maschinentypen variieren je nach Zone. Jeder Maschinentyp enthält die Menge an virtueller CPU, an Hauptspeicher und an Plattenspeicher für jeden Workerknoten im Cluster. Das sekundäre Speicherplattenverzeichnis, in dem alle Containerdaten gespeichert sind, wird standardmäßig mit der LUKS-Verschlüsselung verschlüsselt. Wenn die Option `disable-disk-encrypt` während der Clustererstellung eingeschlossen wird, werden die Containerlaufzeitdaten des Hosts nicht verschlüsselt. [Weitere Informationen zur Verschlüsselung](cs_secure.html#encrypted_disk).
{:shortdesc}

Sie können Ihre Workerknoten als virtuelle Maschine auf gemeinsam genutzter oder dedizierter Hardware bereitstellen oder als physische Maschine auf Bare-Metal-Systemen. [Erfahren Sie mehr über die Optionen für Maschinentypen](cs_clusters_planning.html#shared_dedicated_node).

<strong>Erforderliche Mindestberechtigungen:</strong> Keine

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code>--zone <em>ZONE</em></code></dt>
   <dd>Geben Sie die Zone ein, in der die verfügbaren Maschinentypen aufgelistet werden sollen. Dieser Wert ist erforderlich. Überprüfen Sie die [verfügbaren Zonen](cs_regions.html#zones).</dd>

   <dt><code>--json</code></dt>
  <dd>Druckt die Befehlsausgabe im JSON-Format. Dieser Wert ist optional.</dd>

  <dt><code>-s</code></dt>
  <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>
  </dl>

**Beispielbefehl**:

  ```
  ibmcloud ks machine-types --zone dal10
  ```
  {: pre}

### ibmcloud ks vlans --zone ZONE [--all][--json] [-s]
{: #cs_vlans}

Auflisten der öffentlichen und der privaten VLANs, die in einer Zone in Ihrem Konto der IBM Cloud-Infrastruktur (SoftLayer) zur Verfügung stehen. Um verfügbare VLANs auflisten zu können, müssen Sie über ein gebührenpflichtiges Konto verfügen.

<strong>Erforderliche Mindestberechtigungen:</strong>
* Anzeigen der VLANs, mit denen der Cluster in einer Zone verbunden ist: Plattformrolle **Anzeigeberechtigter** für den Cluster in {{site.data.keyword.containerlong_notm}}
* Auflisten aller verfügbaren VLANs in einer Zone: Plattformrolle **Anzeigeberechtigter** für die Region in {{site.data.keyword.containerlong_notm}}

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code>--zone <em>ZONE</em></code></dt>
   <dd>Geben Sie die Zone ein, in der Sie Ihre privaten und öffentlichen VLANs auflisten möchten. Dieser Wert ist erforderlich. Überprüfen Sie die [verfügbaren Zonen](cs_regions.html#zones).</dd>

   <dt><code>--all</code></dt>
   <dd>Listet alle verfügbaren VLANs auf. VLANs werden standardmäßig gefiltert, um nur diejenigen anzuzeigen, die gültig sind. Damit ein VLAN gültig ist, muss es einer Infrastruktur zugeordnet sein, die einen Worker mit lokalem Plattenspeicher hosten kann.</dd>

   <dt><code>--json</code></dt>
  <dd>Druckt die Befehlsausgabe im JSON-Format. Dieser Wert ist optional.</dd>

  <dt><code>-s</code></dt>
  <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>
   </dl>

**Beispiel**:

  ```
  ibmcloud ks vlans --zone dal10
  ```
  {: pre}


### ibmcloud ks vlan-spanning-get [--json][-s]
{: #cs_vlan_spanning_get}

Anzeigen des VLAN-Spanning-Status für ein Konto der IBM Cloud-Infrastruktur (SoftLayer). Über das VLAN-Spanning können alle Geräte eines Kontos über das private Netz miteinander kommunizieren, unabhängig von dem zugeordneten VLAN.

<strong>Erforderliche Mindestberechtigungen:</strong> Plattformrolle **Anzeigeberechtigter** für {{site.data.keyword.containerlong_notm}}

<strong>Befehlsoptionen</strong>:

   <dl>
    <dt><code>--json</code></dt>
      <dd>Druckt die Befehlsausgabe im JSON-Format. Dieser Wert ist optional.</dd>

    <dt><code>-s</code></dt>
      <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>
   </dl>

**Beispiel**:

  ```
  ibmcloud ks vlan-spanning-get
  ```
  {: pre}

<br />


## Protokollierungsbefehle
{: #logging_commands}

### ibmcloud ks logging-autoupdate-disable --cluster CLUSTER
{: #cs_log_autoupdate_disable}

Inaktivieren der automatischen Aktualisierungen der Fluentd-Pods in einem bestimmten Cluster. Wenn Sie die Kubernetes-Hauptversion oder -Nebenversion Ihres Clusters aktualisieren, nimmt IBM automatisch die erforderlichen Änderungen an der Fluentd-Konfigurationszuordnung vor, ändert aber nicht die Buildversion Ihres Fluentd-Add-ons für die Protokollierung. Sie sind dafür verantwortlich, die Kompatibilität der aktuellen Kubernetes-Versionen und Ihrer Add-on-Images zu prüfen.

<strong>Befehlsoptionen</strong>:

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>Der Name oder die ID des Clusters, für den Sie automatische Aktualisierungen für das Fluentd-Add-on inaktivieren möchten. Dieser Wert ist erforderlich.</dd>
</dl>

### ibmcloud ks logging-autoupdate-enable --cluster CLUSTER
{: #cs_log_autoupdate_enable}

Aktivieren der automatischen Aktualisierungen für Ihre Fluentd-Pods in einem bestimmten Cluster. Fluentd-Pods werden automatisch aktualisiert, wenn eine neue Buildversion verfügbar ist.

<strong>Befehlsoptionen</strong>:

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>Der Name oder die ID des Clusters, für den Sie automatische Aktualisierungen für das Fluentd-Add-on aktivieren möchten. Dieser Wert ist erforderlich.</dd>
</dl>

### ibmcloud ks logging-autoupdate-get --cluster CLUSTER
{: #cs_log_autoupdate_get}

Prüfen Sie, ob Ihre Fluentd-Pods so eingestellt sind, dass sie automatisch in einem bestimmten Cluster aktualisiert werden.

<strong>Befehlsoptionen</strong>:

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>Der Name oder die ID des Clusters, für den Sie prüfen möchten, ob automatische Aktualisierungen für das Fluentd-Add-on aktiviert sind. Dieser Wert ist erforderlich.</dd>
</dl>

### ibmcloud ks logging-config-create --cluster CLUSTER --logsource PROTOKOLLQUELLE --type PROTOKOLLTYP [--namespace KUBERNETES-NAMENSBEREICH][--hostname LOG_SERVER_HOSTNAME_OR_IP] [--port PROTOKOLLSERVERPORT][--space CLUSTER_SPACE] [--org CLUSTER-ORG][--app-containers CONTAINERS] [--app-paths PFADE_ZU_PROTOKOLLEN][--syslog-protocol PROTOCOL]  [--json][--skip-validation] [--force-update][-s]
{: #cs_logging_create}

Erstellen Sie eine Protokollierungskonfiguration. Sie können diesen Befehl verwenden, um Protokolle für Container, Anwendungen, Workerknoten, Kubernetes-Cluster und Ingress-Lastausgleichsfunktionen für Anwendungen an {{site.data.keyword.loganalysisshort_notm}} oder an einen externen Systemprotokollserver weiterzuleiten.

<strong>Erforderliche Mindestberechtigungen</strong>: Plattformrolle **Editor** für den Cluster für alle Protokollquellen außer `kube-audit` und Plattformrolle **Administrator** für den Cluster für die Protokollquelle `kube-audit`

<strong>Befehlsoptionen</strong>:

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>Der Name oder die ID des Clusters.</dd>

  <dt><code>--logsource <em>PROTOKOLLQUELLE</em></code></dt>    
    <dd>Die Protokollquelle, für die die Protokollweiterleitung aktiviert werden soll. Dieses Argument unterstützt eine durch Kommas getrennte Liste mit Protokollquellen, auf die die Konfiguration angewendet werden soll. Gültige Werte sind <code>container</code>, <code>application</code>, <code>worker</code>, <code>kubernetes</code>, <code>storage</code>, <code>ingress</code> und <code>kube-audit</code>. Wenn Sie keine Protokollquelle bereitstellen, werden Konfigurationen für <code>container</code> und <code>ingress</code> erstellt.</dd>

  <dt><code>--type <em>PROTOKOLLTYP</em></code></dt>
    <dd>Gibt an, wohin Sie Ihre Protokolle weiterleiten möchten. Optionen sind <code>ibm</code>, wodurch Ihre Protokolle an {{site.data.keyword.loganalysisshort_notm}} weitergeleitet werden, und <code>syslog</code>, wodurch Ihre Protokolle an externe Server weitergeleitet werden.</dd>

  <dt><code>--namespace <em>KUBERNETES-NAMENSBEREICH</em></code></dt>
    <dd>Der Kubernetes-Namensbereich, von dem aus Protokolle weitergeleitet werden sollen. Die Weiterleitung von Protokollen wird für die Kubernetes-Namensbereiche <code>ibm-system</code> und <code>kube-system</code> nicht unterstützt. Dieser Wert ist nur für die Containerprotokollquelle gültig und optional. Wenn Sie keinen Namensbereich angeben, verwenden alle Namensbereiche im Cluster diese Konfiguration.</dd>

  <dt><code>--hostname <em>PROTOKOLLSERVER-HOSTNAME</em></code></dt>
    <dd>Wenn der Protokollierungstyp <code>syslog</code> lautet, der Hostname oder die IP-Adresse des Protokollcollector-Servers. Dieser Wert ist für <code>syslog</code> erforderlich. Wenn der Protokollierungstyp <code>ibm</code> lautet, die {{site.data.keyword.loganalysislong_notm}}-Einpflege-URL. Sie finden die Liste von verfügbaren Einpflege-URLs [hier](/docs/services/CloudLogAnalysis/log_ingestion.html#log_ingestion_urls). Wenn Sie keine Einpflege-URL angeben, wird der Endpunkt für die Region, in der Ihr Cluster erstellt wurde, verwendet.</dd>

  <dt><code>--port <em>PROTOKOLLSERVER-PORT</em></code></dt>
    <dd>Der Port des Protokollcollector-Servers. Dieser Wert ist optional. Wenn Sie keinen Port angeben, wird der Standardport <code>514</code> für <code>syslog</code> und der Standardport <code>9091</code> für <code>ibm</code> verwendet.</dd>

  <dt><code>--space <em>CLUSTERBEREICH</em></code></dt>
    <dd>Optional: Der Name des Cloud Foundry-Bereichs, an den Sie die Protokolle senden möchten. Dieser Wert ist nur für den Protokolltyp <code>ibm</code> gültig und optional. Wenn Sie keinen Bereich angeben, werden Protokolle an die Kontoebene gesendet. Wenn Sie dies tun, müssen Sie auch eine Organisation angeben.</dd>

  <dt><code>--org <em>CLUSTERORG</em></code></dt>
    <dd>Optional: Der Name der Cloud Foundry-Organisation, in der sich der Bereich befindet. Dieser Wert ist nur für den Protokolltyp <code>ibm</code> gültig und erforderlich, wenn Sie einen Bereich angegeben haben.</dd>

  <dt><code>--app-paths</code></dt>
    <dd>Der Pfad zu dem Container, an den die Apps Protokolle senden. Wenn Sie Protokolle mit dem Quellentyp <code>application</code> weiterleiten möchten, müssen Sie einen Pfad angeben. Wenn Sie mehr als einen Pfad angeben, verwenden Sie eine durch Kommas getrennte Liste. Dieser Wert ist für <code>application</code> der Protokollquelle erforderlich. Beispiel: <code>/var/log/myApp1/&ast;,/var/log/myApp2/&ast;</code></dd>

  <dt><code>--syslog-protocol</code></dt>
    <dd>Das Netzprotokoll (Transportschicht), das verwendet wird, wenn der Protokollierungstyp <code>syslog</code> lautet. Unterstützte Werte sind <code>tcp</code>, <code>tls</code> und der Standardwert <code>udp</code>. Bei einer Weiterleitung an einen rsyslog-Server mit dem <code>udp</code>-Protokoll werden Protokolle, die größer sind als 1 KB, abgeschnitten.</dd>

  <dt><code>--app-containers</code></dt>
    <dd>Zum Weiterleiten von Protokollen von Apps können Sie den Namen des Containers angeben, der Ihre App enthält. Sie können mehr als einen Container angeben, indem Sie eine durch Kommas getrennte Liste verwenden. Falls keine Container angegeben sind, werden Protokolle von allen Containern weitergeleitet, die die von Ihnen bereitgestellten Pfade enthalten. Diese Option ist nur für <code>application</code> der Protokollquelle gültig.</dd>

  <dt><code>--json</code></dt>
    <dd>Druckt die Befehlsausgabe im JSON-Format. Dieser Wert ist optional.</dd>

  <dt><code>--skip-validation</code></dt>
    <dd>Überspringt die Validierung der Organisations- und Bereichsnamen, wenn sie angegeben werden. Das Überspringen der Validierung verringert die Bearbeitungszeit. Eine ungültige Protokollierungskonfiguration aber führt dazu, dass Protokolle nicht ordnungsgemäß weitergeleitet werden. Dieser Wert ist optional.</dd>

  <dt><code>--force-update</code></dt>
    <dd>Erzwingen Sie eine Aktualisierung der Fluentd-Pods auf die aktuelle Version. Fluentd muss die aktuelle Version aufweisen, um Änderungen an den Protokollierungskonfigurationen vornehmen zu können.</dd>

    <dt><code>-s</code></dt>
    <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>
</dl>

**Beispiele**:

Beispiel für Protokolltyp `ibm`, der aus einer `container`-Protokollquelle am Standardport 9091 weiterleitet:

  ```
  ibmcloud ks logging-config-create mein_cluster --logsource container --namespace mein_namensbereich --hostname ingest.logging.ng.bluemix.net --type ibm
  ```
  {: pre}

Beispiel für Protokolltyp `syslog` für Weiterleitung aus der Protokollquelle `container` am Standardport 514:

  ```
  ibmcloud ks logging-config-create mein_cluster --logsource container --namespace mein_namensbereich  --hostname 169.xx.xxx.xxx --type syslog
  ```
  {: pre}

Beispiel für Protokolltyp `syslog`, der Protokolle aus einer `ingress`-Quelle an einen anderen Port als den Standardport weiterleitet:

  ```
  ibmcloud ks logging-config-create --cluster mein_cluster --logsource container --hostname 169.xx.xxx.xxx --port 5514 --type syslog
  ```
  {: pre}

### ibmcloud ks logging-config-get --cluster CLUSTER [--logsource PROTOKOLLQUELLE][--json] [-s]
{: #cs_logging_get}

Zeigen Sie alle Protokollweiterleitungskonfigurationen für einen Cluster an oder filtern Sie die Protokollierungskonfigurationen auf Basis der Protokollquelle.

<strong>Erforderliche Mindestberechtigungen:</strong> Plattformrolle **Anzeigeberechtigter** für {{site.data.keyword.containerlong_notm}}

<strong>Befehlsoptionen</strong>:

 <dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>

  <dt><code>--logsource <em>PROTOKOLLQUELLE</em></code></dt>
    <dd>Die Art der Protokollquelle, für die die Filterung durchgeführt werden soll. Nur Protokollierungskonfigurationen dieser Protokollquelle im Cluster werden zurückgegeben. Gültige Werte sind <code>container</code>, <code>storage</code>, <code>application</code>, <code>worker</code>, <code>kubernetes</code> <code>ingress</code> und <code>kube-audit</code>. Dieser Wert ist optional.</dd>

  <dt><code>--show-covering-filters</code></dt>
    <dd>Zeigt die Protokollierungsfilter an, wodurch die vorherige Filter obsolet werden.</dd>

  <dt><code>--json</code></dt>
    <dd>Druckt die Befehlsausgabe im JSON-Format. Dieser Wert ist optional.</dd>

  <dt><code>-s</code></dt>
    <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>
 </dl>

**Beispiel**:

  ```
  ibmcloud ks logging-config-get --cluster mein_cluster --logsource worker
  ```
  {: pre}


### ibmcloud ks logging-config-refresh --cluster CLUSTER  [--force-update][-s]
{: #cs_logging_refresh}

Aktualisierung der Protokollierungskonfiguration für den Cluster. Dadurch wird das Protokollierungstoken für alle Protokollierungskonfigurationen aktualisiert, bei denen die Weiterleitung an die Bereichsebene in Ihrem Cluster erfolgt.

<strong>Erforderliche Mindestberechtigungen:</strong> Plattformrolle **Editor** für {{site.data.keyword.containerlong_notm}}

<strong>Befehlsoptionen</strong>:

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>

   <dt><code>--force-update</code></dt>
     <dd>Erzwingen Sie eine Aktualisierung der Fluentd-Pods auf die aktuelle Version. Fluentd muss die aktuelle Version aufweisen, um Änderungen an den Protokollierungskonfigurationen vornehmen zu können.</dd>

   <dt><code>-s</code></dt>
     <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>
</dl>

**Beispiel**:

  ```
  ibmcloud ks logging-config-refresh --cluster mein_cluster
  ```
  {: pre}


### ibmcloud ks logging-config-rm --cluster CLUSTER [--id PROTOKOLLKONFIGURATIONS-ID][--all] [--force-update][-s]
{: #cs_logging_rm}

Löschen einer Protokollweiterleitungskonfiguration oder aller Protokollierungskonfigurationen für einen Cluster. Dadurch wird die Protokollweiterleitung an einen fernen Systemprotokollserver bzw. an {{site.data.keyword.loganalysisshort_notm}} gestoppt.

<strong>Erforderliche Mindestberechtigungen</strong>: Plattformrolle **Editor** für den Cluster für alle Protokollquellen außer `kube-audit` und Plattformrolle **Administrator** für den Cluster für die Protokollquelle `kube-audit`

<strong>Befehlsoptionen</strong>:

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>

  <dt><code>--id <em>PROTOKOLLKONFIGURATIONS-ID</em></code></dt>
   <dd>Wenn Sie eine einzelne Protokollierungskonfiguration entfernen möchten, die ID der Protokollierungskonfiguration.</dd>

  <dt><code>--all</code></dt>
   <dd>Das Flag zum Entfernen aller Protokollierungskonfigurationen in einem Cluster.</dd>

  <dt><code>--force-update</code></dt>
    <dd>Erzwingen Sie eine Aktualisierung der Fluentd-Pods auf die aktuelle Version. Fluentd muss die aktuelle Version aufweisen, um Änderungen an den Protokollierungskonfigurationen vornehmen zu können.</dd>

   <dt><code>-s</code></dt>
     <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>
</dl>

**Beispiel**:

  ```
  ibmcloud ks logging-config-rm --cluster mein_cluster --id f4bc77c0-ee7d-422d-aabf-a4e6b977264e
  ```
  {: pre}


### ibmcloud ks logging-config-update --cluster CLUSTER --id PROTOKOLLKONFIGURATIONS-ID --type PROTOKOLLTYP [--namespace NAMENSBEREICH][--hostname LOG_SERVER_HOSTNAME_OR_IP] [--port PROTOKOLLSERVER-PORT][--space CLUSTER_SPACE] [--org CLUSTERORG][--app-paths PATH] [--app-containers PFAD][--json] [--skipValidation][--force-update] [-s]
{: #cs_logging_update}

Aktualisieren Sie die Details einer Protokollweiterleitungskonfiguration.

<strong>Erforderliche Mindestberechtigungen:</strong> Plattformrolle **Editor** für {{site.data.keyword.containerlong_notm}}

<strong>Befehlsoptionen</strong>:

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>

  <dt><code>--id <em>PROTOKOLLKONFIGURATIONS-ID</em></code></dt>
   <dd>Die ID der Protokollierungskonfiguration, die aktualisiert werden soll. Dieser Wert ist erforderlich.</dd>

  <dt><code>--type <em>PROTOKOLLTYP</em></code></dt>
   <dd>Das Protokollweiterleitungsprotokoll, das Sie verwenden möchten. Momentan werden <code>syslog</code> und <code>ibm</code> unterstützt. Dieser Wert ist erforderlich.</dd>

  <dt><code>--namespace <em>NAMENSBEREICH</em></code>
    <dd>Der Kubernetes-Namensbereich, von dem aus Protokolle weitergeleitet werden sollen. Die Weiterleitung von Protokollen wird für die Kubernetes-Namensbereiche <code>ibm-system</code> und <code>kube-system</code> nicht unterstützt. Dieser Wert ist nur für die Protokollquelle <code>container</code> gültig. Wenn Sie keinen Namensbereich angeben, verwenden alle Namensbereiche im Cluster diese Konfiguration.</dd>

  <dt><code>--hostname <em>PROTOKOLLSERVER-HOSTNAME</em></code></dt>
   <dd>Wenn der Protokollierungstyp <code>syslog</code> lautet, der Hostname oder die IP-Adresse des Protokollcollector-Servers. Dieser Wert ist für <code>syslog</code> erforderlich. Wenn der Protokollierungstyp <code>ibm</code> lautet, die {{site.data.keyword.loganalysislong_notm}}-Einpflege-URL. Sie finden die Liste von verfügbaren Einpflege-URLs [hier](/docs/services/CloudLogAnalysis/log_ingestion.html#log_ingestion_urls). Wenn Sie keine Einpflege-URL angeben, wird der Endpunkt für die Region, in der Ihr Cluster erstellt wurde, verwendet.</dd>

   <dt><code>--port <em>PROTOKOLLSERVER-PORT</em></code></dt>
   <dd>Der Port des Protokollcollector-Servers. Dieser Wert ist optional, wenn der Protokollierungstyp <code>syslog</code> lautet. Wenn Sie keinen Port angeben, wird der Standardport <code>514</code> für <code>syslog</code> und <code>9091</code> für <code>ibm</code> verwendet.</dd>

   <dt><code>--space <em>CLUSTERBEREICH</em></code></dt>
   <dd>Optional: Der Name des Bereichs, an den die Protokolle gesendet werden sollen. Dieser Wert ist nur für den Protokolltyp <code>ibm</code> gültig und optional. Wenn Sie keinen Bereich angeben, werden Protokolle an die Kontoebene gesendet. Wenn Sie dies tun, müssen Sie auch eine Organisation angeben.</dd>

   <dt><code>--org <em>CLUSTERORG</em></code></dt>
   <dd>Optional: Der Name der Cloud Foundry-Organisation, in der sich der Bereich befindet. Dieser Wert ist nur für den Protokolltyp <code>ibm</code> gültig und erforderlich, wenn Sie einen Bereich angegeben haben.</dd>

   <dt><code>--app-paths <em>PFAD</em>,<em>PFAD</em></code></dt>
     <dd>Ein absoluter Dateipfad in dem Container, aus dem Protokolle erfasst werden. Platzhalter, wie '/var/log/*.log', können zwar verwendet werden, nicht jedoch rekursive Globale, wie '/var/log/**/test.log'. Wenn Sie mehr als einen Pfad angeben, verwenden Sie eine durch Kommas getrennte Liste. Dieser Wert ist erforderlich, wenn Sie 'application' für die Protokollquelle angeben. </dd>

   <dt><code>--app-containers <em>PFAD</em>,<em>PFAD</em></code></dt>
     <dd>Der Pfad für die Container, in die die Apps die Protokolle schreiben. Wenn Sie Protokolle mit dem Quellentyp <code>application</code> weiterleiten möchten, müssen Sie einen Pfad angeben. Wenn Sie mehr als einen Pfad angeben, verwenden Sie eine durch Kommas getrennte Liste. Beispiel: <code>/var/log/myApp1/&ast;,/var/log/myApp2/&ast;</code></dd>

   <dt><code>--json</code></dt>
    <dd>Druckt die Befehlsausgabe im JSON-Format. Dieser Wert ist optional.</dd>

   <dt><code>--skipValidation</code></dt>
    <dd>Überspringt die Validierung der Organisations- und Bereichsnamen, wenn sie angegeben werden. Das Überspringen der Validierung verringert die Bearbeitungszeit. Eine ungültige Protokollierungskonfiguration aber führt dazu, dass Protokolle nicht ordnungsgemäß weitergeleitet werden. Dieser Wert ist optional.</dd>

  <dt><code>--force-update</code></dt>
    <dd>Erzwingen Sie eine Aktualisierung der Fluentd-Pods auf die aktuelle Version. Fluentd muss die aktuelle Version aufweisen, um Änderungen an den Protokollierungskonfigurationen vornehmen zu können.</dd>

   <dt><code>-s</code></dt>
     <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>
  </dl>

**Beispiel für Protokolltyp `ibm`**:

  ```
  ibmcloud ks logging-config-update mein_cluster --id f4bc77c0-ee7d-422d-aabf-a4e6b977264e --type ibm
  ```
  {: pre}

**Beispiel für Protokolltyp `syslog`**:

  ```
  ibmcloud ks logging-config-update --cluster mein_cluster --id f4bc77c0-ee7d-422d-aabf-a4e6b977264e --hostname localhost --port 5514 --type syslog
  ```
  {: pre}


### ibmcloud ks logging-filter-create --cluster CLUSTER --type LOG_TYPE [--logging-configs CONFIGS][--namespace KUBERNETES_NAMESPACE] [--container CONTAINER_NAME][--level LOGGING_LEVEL] [--message MESSAGE][--regex-message MESSAGE] [--force-update][--json] [-s]
{: #cs_log_filter_create}

Erstellen Sie einen Protokollierungsfilter. Mit diesem Befehl können Sie Protokolle herausfiltern, die von Ihrer Protokollierungskonfiguration weitergeleitet werden.

<strong>Erforderliche Mindestberechtigungen:</strong> Plattformrolle **Editor** für {{site.data.keyword.containerlong_notm}}

<strong>Befehlsoptionen</strong>:

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>Der Name oder die ID des Clusters, für das Sie einen Protokollierungsfilter erstellen möchten. Dieser Wert ist erforderlich.</dd>

  <dt><code>--type <em>PROTOKOLLTYP</em></code></dt>
    <dd>Der Typ von Protokollen, auf die Sie den Filter anwenden möchten. Momentan werden <code>all</code>, <code>container</code> und <code>host</code> unterstützt.</dd>

  <dt><code>--logging-configs <em>KONFIGURATIONEN</em></code></dt>
    <dd>Eine durch Kommas getrennte Liste Ihrer Protokollierungskonfigurations-IDs. Wird sie nicht bereitgestellt, wird der Filter auf alle Clusterprotokollierungskonfigurationen angewendet, die an den Filter übergeben werden. Sie können mit dem Filter übereinstimmende Protokollkonfigurationen anzeigen, indem Sie das Flag <code>--show-matching-configs</code> mit dem Befehl verwenden. Dieser Wert ist optional.</dd>

  <dt><code>--namespace <em>KUBERNETES-NAMENSBEREICH</em></code></dt>
    <dd>Der Kubernetes-Namensbereich, in dem Sie Protokolle filtern möchten. Dieser Wert ist optional.</dd>

  <dt><code>--container <em>CONTAINERNAME</em></code></dt>
    <dd>Der Name des Containers, in dem Sie Protokolle filtern möchten. Dieses Flag ist nur mit dem Protokolltyp <code>container</code> anwendbar. Dieser Wert ist optional.</dd>

  <dt><code>--level <em>PROTOKOLLIERUNGSSTUFE</em></code></dt>
    <dd>Filtert Protokolle auf einer angegebenen Stufe oder den darunterliegenden Stufen heraus. Zulässige Werte in ihrer kanonischen Reihenfolge sind <code>fatal</code>, <code>error</code>, <code>warn/warning</code>, <code>info</code>, <code>debug</code> und <code>trace</code>. Dieser Wert ist optional. Beispiel: Wenn Sie Protokolle auf der Stufe <code>info</code> filtern, wird auch auf den Stufen <code>debug</code> und <code>trace</code> gefiltert. **Hinweis**: Sie können dieses Flag nur dann verwenden, wenn Protokollnachrichten das JSON-Format aufweisen und ein Feld für die Stufe enthalten. Beispielausgabe: <code>{"log": "hello", "level": "info"}</code></dd>

  <dt><code>--message <em>NACHRICHT</em></code></dt>
    <dd>Filtert alle Protokolle mit einer bestimmten Nachricht heraus. Dieser Wert ist optional. Beispiel: Die Nachrichten "Hello", "!"und "Hello, World!"würden im Protokoll "Hello, World!" wiedergefunden.</dd>

  <dt><code>--regex-message <em>NACHRICHT</em></code></dt>
    <dd>Optional: Filtert alle Protokolle heraus, die eine angegebene Nachricht enthalten, die als regulärer Ausdruck an einer beliebigen Stelle im Protokoll geschrieben wird. Dieser Wert ist optional. Beispiel: Das Muster "hello [0-9]" würde auf "hello 1", "hello 2" und "hello 9" angewendet werden.</dd>

  <dt><code>--force-update</code></dt>
    <dd>Erzwingen Sie eine Aktualisierung der Fluentd-Pods auf die aktuelle Version. Fluentd muss die aktuelle Version aufweisen, um Änderungen an den Protokollierungskonfigurationen vornehmen zu können.</dd>

  <dt><code>--json</code></dt>
    <dd>Druckt die Befehlsausgabe im JSON-Format. Dieser Wert ist optional.</dd>

  <dt><code>-s</code></dt>
    <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>
</dl>

**Beispiele**:

In diesem Beispiel werden alle Protokolle herausgefiltert, die von Containern mit dem Namen `test-container` im Standardnamensbereich weitergeleitet werden, die sich auf der Stufe 'debug' oder einer niedrigeren Stufe befinden und eine Protokollnachricht haben, die 'GET request' enthält.

  ```
  ibmcloud ks logging-filter-create --cluster example-cluster --type container --namespace default --container test-container --level debug --message "GET request"
  ```
  {: pre}

In diesem Beispiel werden alle Protokolle herausgefiltert, die von einem bestimmten Cluster auf der Stufe 'info' oder einer niedrigeren Stufe weitergeleitet werden. Die Ausgabe wird als JSON zurückgegeben.

  ```
  ibmcloud ks logging-filter-create --cluster example-cluster --type all --level info --json
  ```
  {: pre}



### ibmcloud ks logging-filter-get --cluster CLUSTER [--id FILTER-ID][--show-matching-configs] [--show-covering-filters][--json] [-s]
{: #cs_log_filter_view}

Zeigen Sie eine Protokollierungsfilterkonfiguration an. Mit diesem Befehl können Sie die selbst erstellten Protokollierungsfilter anzeigen.

<strong>Erforderliche Mindestberechtigungen:</strong> Plattformrolle **Anzeigeberechtigter** für {{site.data.keyword.containerlong_notm}}

<strong>Befehlsoptionen</strong>:

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>Der Name oder die ID des Clusters, für das Sie Filter anzeigen möchten. Dieser Wert ist erforderlich.</dd>

  <dt><code>--id <em>FILTER-ID</em></code></dt>
    <dd>Die ID des Protokollfilters, den Sie anzeigen möchten.</dd>

  <dt><code>--show-matching-configs</code></dt>
    <dd>Zeigt die Protokollierungskonfigurationen an, die mit der überprüften Konfiguration übereinstimmen. Dieser Wert ist optional.</dd>

  <dt><code>--show-covering-filters</code></dt>
    <dd>Zeigt die Protokollierungsfilter an, wodurch die vorherigen Filter obsolet werden. Dieser Wert ist optional.</dd>

  <dt><code>--json</code></dt>
    <dd>Druckt die Befehlsausgabe im JSON-Format. Dieser Wert ist optional.</dd>

   <dt><code>-s</code></dt>
     <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>
</dl>

**Beispiel**:

```
ibmcloud ks logging-filter-get mycluster --id 885732 --show-matching-configs
```
{: pre}

### ibmcloud ks logging-filter-rm --cluster CLUSTER [--id FILTER-ID][--all] [--force-update][-s]
{: #cs_log_filter_delete}

Löschen Sie einen Protokollierungsfilter. Mit diesem Befehl können Sie einen selbst erstellten Protokollierungsfilter entfernen.

<strong>Erforderliche Mindestberechtigungen:</strong> Plattformrolle **Editor** für {{site.data.keyword.containerlong_notm}}

<strong>Befehlsoptionen</strong>:

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>Der Name oder die ID des Clusters, aus dem Sie einen Protokollierungsfilter löschen möchten.</dd>

  <dt><code>--id <em>FILTER-ID</em></code></dt>
    <dd>Die ID des Protokollfilters, der gelöscht werden soll.</dd>

  <dt><code>--all</code></dt>
    <dd>Löscht alle Protokollweiterleitungsfilter. Dieser Wert ist optional.</dd>

  <dt><code>--force-update</code></dt>
    <dd>Erzwingen Sie eine Aktualisierung der Fluentd-Pods auf die aktuelle Version. Fluentd muss die aktuelle Version aufweisen, um Änderungen an den Protokollierungskonfigurationen vornehmen zu können.</dd>

  <dt><code>-s</code></dt>
    <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>
</dl>

**Beispiel**:

```
ibmcloud ks logging-filter-rm mycluster --id 885732
```
{: pre}

### ibmcloud ks logging-filter-update --cluster CLUSTER --id FILTER_ID --type LOG_TYPE [--logging-configs CONFIGS][--namespace KUBERNETES_NAMESPACE] [--container CONTAINER_NAME][--level LOGGING_LEVEL] [--message MESSAGE][--regex-message MESSAGE] [--force-update][--json] [-s]
{: #cs_log_filter_update}

Aktualisieren Sie einen Protokollierungsfilter. Mit diesem Befehl können Sie einen selbst erstellten Protokollierungsfilter aktualisieren.

<strong>Erforderliche Mindestberechtigungen:</strong> Plattformrolle **Editor** für {{site.data.keyword.containerlong_notm}}

<strong>Befehlsoptionen</strong>:

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>Der Name oder die ID des Clusters, für den Sie einen Protokollierungsfilter aktualisieren möchten. Dieser Wert ist erforderlich.</dd>

 <dt><code>--id <em>FILTER-ID</em></code></dt>
    <dd>Die ID des Protokollfilters, der aktualisiert werden soll.</dd>

  <dt><code>--type <em>PROTOKOLLTYP</em></code></dt>
    <dd>Der Typ von Protokollen, auf die Sie den Filter anwenden möchten. Momentan werden <code>all</code>, <code>container</code> und <code>host</code> unterstützt.</dd>

  <dt><code>--logging-configs <em>KONFIGURATIONEN</em></code></dt>
    <dd>Eine durch Kommas getrennte Liste Ihrer Protokollierungskonfigurations-IDs. Wird sie nicht bereitgestellt, wird der Filter auf alle Clusterprotokollierungskonfigurationen angewendet, die an den Filter übergeben werden. Sie können mit dem Filter übereinstimmende Protokollkonfigurationen anzeigen, indem Sie das Flag <code>--show-matching-configs</code> mit dem Befehl verwenden. Dieser Wert ist optional.</dd>

  <dt><code>--namespace <em>KUBERNETES-NAMENSBEREICH</em></code></dt>
    <dd>Der Kubernetes-Namensbereich, in dem Sie Protokolle filtern möchten. Dieser Wert ist optional.</dd>

  <dt><code>--container <em>CONTAINERNAME</em></code></dt>
    <dd>Der Name des Containers, in dem Sie Protokolle filtern möchten. Dieses Flag ist nur mit dem Protokolltyp <code>container</code> anwendbar. Dieser Wert ist optional.</dd>

  <dt><code>--level <em>PROTOKOLLIERUNGSSTUFE</em></code></dt>
    <dd>Filtert Protokolle auf einer angegebenen Stufe oder den darunterliegenden Stufen heraus. Zulässige Werte in ihrer kanonischen Reihenfolge sind <code>fatal</code>, <code>error</code>, <code>warn/warning</code>, <code>info</code>, <code>debug</code> und <code>trace</code>. Dieser Wert ist optional. Beispiel: Wenn Sie Protokolle auf der Stufe <code>info</code> filtern, wird auch auf den Stufen <code>debug</code> und <code>trace</code> gefiltert. **Hinweis**: Sie können dieses Flag nur dann verwenden, wenn Protokollnachrichten das JSON-Format aufweisen und ein Feld für die Stufe enthalten. Beispielausgabe: <code>{"log": "hello", "level": "info"}</code></dd>

  <dt><code>--message <em>NACHRICHT</em></code></dt>
    <dd>Filtert alle Protokolle mit einer bestimmten Nachricht heraus. Dieser Wert ist optional. Beispiel: Die Nachrichten "Hello", "!"und "Hello, World!"würden im Protokoll "Hello, World!" wiedergefunden.</dd>

  <dt><code>--regex-message <em>NACHRICHT</em></code></dt>
    <dd>Optional: Filtert alle Protokolle heraus, die eine angegebene Nachricht enthalten, die als regulärer Ausdruck an einer beliebigen Stelle im Protokoll geschrieben wird. Dieser Wert ist optional. Beispiel: Das Muster "hello [0-9]" würde auf "hello 1", "hello 2" und "hello 9" angewendet werden.</dd>

  <dt><code>--force-update</code></dt>
    <dd>Erzwingen Sie eine Aktualisierung der Fluentd-Pods auf die aktuelle Version. Fluentd muss die aktuelle Version aufweisen, um Änderungen an den Protokollierungskonfigurationen vornehmen zu können.</dd>

  <dt><code>--json</code></dt>
    <dd>Druckt die Befehlsausgabe im JSON-Format. Dieser Wert ist optional.</dd>

  <dt><code>-s</code></dt>
    <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>
</dl>

**Beispiele**:

In diesem Beispiel werden alle Protokolle herausgefiltert, die von Containern mit dem Namen `test-container` im Standardnamensbereich weitergeleitet werden, die sich auf der Stufe 'debug' oder einer niedrigeren Stufe befinden und eine Protokollnachricht haben, die 'GET request' enthält.

  ```
  ibmcloud ks logging-filter-update --cluster example-cluster --id 885274 --type container --namespace default --container test-container --level debug --message "GET request"
  ```
  {: pre}

In diesem Beispiel werden alle Protokolle herausgefiltert, die von einem bestimmten Cluster auf der Stufe 'info' oder einer niedrigeren Stufe weitergeleitet werden. Die Ausgabe wird als JSON zurückgegeben.

  ```
  ibmcloud ks logging-filter-update --cluster example-cluster --id 274885 --type all --level info --json
  ```
  {: pre}

### ibmcloud ks logging-collect --cluster CLUSTER --cos-bucket BUCKET_NAME --cos-endpoint ENDPOINT --hmac-key-id HMAC_KEY_ID --hmac-key HMAC_KEY --type LOG_TYPE [-s]
{: #cs_log_collect}

Erstellen Sie eine Anforderung für einen Snapshot der Protokolle zu einem bestimmten Zeitpunkt und speichern Sie die Protokolle anschließend in einem {{site.data.keyword.cos_full_notm}}-Bucket.

<strong>Erforderliche Mindestberechtigungen:</strong> Plattformrolle **Administrator** für {{site.data.keyword.containerlong_notm}}

<strong>Befehlsoptionen</strong>:

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>Der Name oder die ID des Clusters, für den Sie einen Snapshot erstellen möchten. Dieser Wert ist erforderlich.</dd>

 <dt><code>--cos-bucket <em>BUCKETNAME</em></code></dt>
    <dd>Der Name des {{site.data.keyword.cos_short}}-Buckets, in dem die Protokolle gespeichert werden sollen. Dieser Wert ist erforderlich.</dd>

  <dt><code>--cos-endpoint <em>ENDPUNKT</em></code></dt>
    <dd>Der {{site.data.keyword.cos_short}}-Endpunkt für das Bucket, in dem die Protokolle gespeichert werden. Dieser Wert ist erforderlich.</dd>

  <dt><code>--hmac-key-id <em>HMAC-SCHLÜSSEL-ID</em></code></dt>
    <dd>Die eindeutige ID für die HMAC-Berechtigungsnachweise für die Objektspeicherinstanz. Dieser Wert ist erforderlich.</dd>

  <dt><code>--hmac-key <em>HMAC-SCHLÜSSEL</em></code></dt>
    <dd>Der HMAC-Schlüssel für die {{site.data.keyword.cos_short}}-Instanz. Dieser Wert ist erforderlich.</dd>

  <dt><code>--type <em>PROTOKOLLTYP</em></code></dt>
    <dd>Der Typ der Protokolle, für die ein Snapshot erstellt werden soll. Derzeit ist `master` die einzige Option und die Standardeinstellung.</dd>

  <dt><code>-s</code></dt>
    <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>
</dl>

**Beispiel**:

  ```
  ibmcloud ks logging-collect --cluster mycluster --cos-bucket mybucket --cos-endpoint s3-api.us-geo.objectstorage.softlayer.net --hmac-key-id e2e7f5c9fo0144563c418dlhi3545m86 --hmac-key c485b9b9fo4376722f692b63743e65e1705301ab051em96j
  ```
  {: pre}

**Beispielausgabe**:

  ```
  There is no specified log type. The default master will be used.
  Submitting log collection request for master logs for cluster mycluster...
  OK
  The log collection request was successfully submitted. To view the status of the request run ibmcloud ks logging-collect-status mycluster.
  ```
  {: screen}

### ibmcloud ks logging-collect-status --cluster CLUSTER [--json][-s]
{: #cs_log_collect_status}

Überprüfen Sie den Status der Snapshotanforderung für die Protokollerfassung im Cluster.

<strong>Erforderliche Mindestberechtigungen:</strong> Plattformrolle **Administrator** für {{site.data.keyword.containerlong_notm}}

<strong>Befehlsoptionen</strong>:

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>Der Name oder die ID des Clusters, für den Sie einen Snapshot erstellen möchten. Dieser Wert ist erforderlich.</dd>

  <dt><code>--json</code></dt>
    <dd>Druckt die Befehlsausgabe im JSON-Format. Dieser Wert ist optional.</dd>

  <dt><code>-s</code></dt>
    <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>
</dl>

**Beispiel**:

  ```
  ibmcloud ks logging-collect-status --cluster mycluster
  ```
  {: pre}

**Beispielausgabe**:

  ```
  Getting the status of the last log collection request for cluster mycluster...
  OK
  State     Start Time             Error   Log URLs
  success   2018-09-18 16:49 PDT   - s3-api.us-geo.objectstorage.softlayer.net/mybucket/master-0-0862ae70a9ae6c19845ba3pc0a2a6o56-1297318756.tgz
  s3-api.us-geo.objectstorage.softlayer.net/mybucket/master-1-0862ae70a9ae6c19845ba3pc0a2a6o56-1297318756.tgz
  s3-api.us-geo.objectstorage.softlayer.net/mybucket/master-2-0862ae70a9ae6c19845ba3pc0a2a6o56-1297318756.tgz
  ```
  {: screen}

<br />


## Regionsbefehle
{: #region_commands}

### ibmcloud ks region
{: #cs_region}

Suchen Sie nach der {{site.data.keyword.containerlong_notm}}-Region, in der Sie sich aktuell befinden. Sie erstellen und verwalten Cluster, die für diese Region spezifisch sind. Verwenden Sie den Befehl `ibmcloud ks region-set`, um die Region zu ändern.

<strong>Erforderliche Mindestberechtigungen:</strong> Keine

**Beispiel**:

```
ibmcloud ks region
```
{: pre}

**Ausgabe**:
```
Region: us-south
```
{: screen}

### ibmcloud ks region-set [--region REGION]
{: #cs_region-set}

Legen Sie die Region für {{site.data.keyword.containerlong_notm}} fest. Sie erstellen und verwalten Cluster, die für die Region spezifisch sind, und benötigen zum Zwecke der Hochverfügbarkeit unter Umständen Cluster in mehreren Regionen.

Sie können sich beispielsweise bei {{site.data.keyword.Bluemix_notm}} in der Region 'Vereinigte Staaten (Süden)' anmelden und einen Cluster erstellen. Anschließend können Sie `ibmcloud ks region-set eu-central` verwenden, um die Region 'Mitteleuropa' als Ziel festzulegen, und einen weiteren Cluster erstellen. Schließlich können Sie `ibmcloud ks region-set us-south` verwenden, um zur Region 'Vereinigte Staaten (Süden)' zurückzukehren und Ihren Cluster in dieser Region zu verwalten.

<strong>Erforderliche Mindestberechtigungen:</strong> Keine

**Befehlsoptionen**:

<dl>
<dt><code>--region <em>REGION</em></code></dt>
<dd>Geben Sie die Region ein, die Sie als Ziel festlegen möchten. Dieser Wert ist optional. Wenn Sie die Region nicht angeben, können Sie sie aus der Liste in der Ausgabe auswählen.

Eine Liste von verfügbaren Regionen finden Sie unter [Regionen und Zonen](cs_regions.html). Oder setzen Sie den [Befehl `ibmcloud ks regions`](#cs_regions) ab.</dd></dl>

**Beispiel**:

```
ibmcloud ks region-set eu-central
```
{: pre}

```
ibmcloud ks region-set
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



### ibmcloud ks regions
{: #cs_regions}

Listet die verfügbaren Regionen auf. Der `Region Name` ist der {{site.data.keyword.containerlong_notm}}-Name und der `Region Alias` ist der allgemeine {{site.data.keyword.Bluemix_notm}}-Name für die Region.

<strong>Erforderliche Mindestberechtigungen:</strong> Keine

**Beispiel**:

```
ibmcloud ks regions
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

### ibmcloud ks zones [--region-only][--json] [-s]
{: #cs_datacenters}

Zeigen Sie eine Liste der verfügbaren Zonen an, in denen Sie einen Cluster erstellen können. Welche Zonen verfügbar sind, hängt von der Region ab, bei der Sie angemeldet sind. Um zwischen Regionen zu wechseln, führen Sie den Befehl `ibmcloud ks region-set` aus.

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code>--region-only</code></dt>
   <dd>Listen Sie nur Mehrzonencluster in der Region auf, in der Sie angemeldet sind. Dieser Wert ist optional.</dd>

   <dt><code>--json</code></dt>
   <dd>Druckt die Befehlsausgabe im JSON-Format. Dieser Wert ist optional.</dd>

   <dt><code>-s</code></dt>
   <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>
   </dl>

**Beispiel**:

  ```
  ibmcloud ks zones
  ```
  {: pre}

<br />


## Befehle für Workerknoten
{: worker_node_commands}


### Veraltet: ibmcloud ks worker-add --cluster CLUSTER [--file DATEIPOSITION][--hardware HARDWARE] --machine-type MASCHINENTYP --workers ANZAHL --private-vlan PRIVATES_VLAN --public-vlan ÖFFENTLICHES_VLAN [--disable-disk-encrypt][-s]
{: #cs_worker_add}

Fügen Sie eigenständige Workerknoten zu Ihrem Standardcluster hinzu, die sich nicht in einem Worker-Pool befinden.
{: deprecated}

<strong>Erforderliche Mindestberechtigungen:</strong> Plattformrolle **Operator** für {{site.data.keyword.containerlong_notm}}

<strong>Befehlsoptionen</strong>:

<dl>
<dt><code>--cluster <em>CLUSTER</em></code></dt>
<dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>

<dt><code>--file <em>DATEISTANDORT</em></code></dt>
<dd>Der Pfad zur YAML-Datei für das Hinzufügen von Workerknoten zum Cluster. Statt zusätzliche Workerknoten mithilfe der in diesem Befehl bereitgestellten Optionen zu definieren, können Sie eine YAML-Datei verwenden. Dieser Wert ist optional.

<p class="note">Wenn Sie dieselbe Option wie im Befehl als Parameter in der YAML-Datei bereitstellen, hat der Wert im Befehl Vorrang vor dem Wert in der YAML. Beispiel: Sie definieren einen Maschinentyp in Ihrer YAML-Datei und verwenden die Option '--machine-type' im Befehl. Der Wert, den Sie in der Befehlsoption eingegeben haben, überschreibt den Wert in der YAML-Datei.</p>

<pre class="codeblock">
<code>name: <em>&lt;clustername_oder_-id&gt;</em>
zone: <em>&lt;zone&gt;</em>
machine-type: <em>&lt;maschinentyp&gt;</em>
private-vlan: <em>&lt;privates_vlan&gt;</em>
public-vlan: <em>&lt;öffentliches_vlan&gt;</em>
hardware: <em>&lt;shared_oder_dedicated&gt;</em>
workerNum: <em>&lt;anzahl_worker&gt;</em>
diskEncryption: <em>false</em></code></pre>

<table>
<caption>Erklärung der Komponenten der YAML-Datei</caption>
<thead>
<th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der YAML-Dateikomponenten</th>
</thead>
<tbody>
<tr>
<td><code><em>name</em></code></td>
<td>Ersetzen Sie <code><em>&lt;clustername_oder_-id&gt;</em></code> durch den Namen oder die ID des Clusters, in dem Sie Workerknoten hinzufügen möchten.</td>
</tr>
<tr>
<td><code><em>zone</em></code></td>
<td>Ersetzen Sie <code><em>&lt;zone&gt;</em></code> durch die Zone, in der die Workerknoten bereitgestellt werden sollen. Die verfügbaren Zonen sind abhängig von der Region, in der Sie angemeldet sind. Führen Sie den Befehl <code>ibmcloud ks zones</code> aus, um die verfügbaren Zonen aufzuführen.</td>
</tr>
<tr>
<td><code><em>maschinentyp</em></code></td>
<td>Ersetzen Sie <code><em>&lt;maschinentyp&gt;</em></code> durch den Maschinentyp, auf dem Sie Ihre Workerknoten bereitstellen möchten. Sie können Ihre Workerknoten als virtuelle Maschinen auf gemeinsam genutzter oder dedizierter Hardware oder als physische Maschinen auf Bare-Metal-Systemen bereitstellen. Die Typen der verfügbaren physischen und virtuellen Maschinen variieren je nach der Zone, in der Sie den Cluster implementieren. Weitere Informationen finden Sie im Abschnitt zum [Befehl `ibmcloud ks machine-types`](cs_cli_reference.html#cs_machine_types).</td>
</tr>
<tr>
<td><code><em>privates_vlan</em></code></td>
<td>Ersetzen Sie <code><em>&lt;privates_vlan&gt;</em></code> durch die ID des privaten VLANs, das Sie für Ihre Workerknoten verwenden möchten. Führen Sie <code>ibmcloud ks vlans <em>&lt;zone&gt;</em></code> aus und suchen Sie nach VLAN-Routern, die mit <code>bcr</code> (Back-End-Router) beginnen, um verfügbare VLANs aufzulisten.</td>
</tr>
<tr>
<td><code>public-vlan</code></td>
<td>Ersetzen Sie <code>&lt;öffentliches_vlan&gt;</code> durch die ID des öffentlichen VLANs, das Sie für Ihre Workerknoten verwenden möchten. Führen Sie <code>ibmcloud ks vlans &lt;zone&gt;</code> aus und suchen Sie nach VLAN-Routern, die mit <code>fcr</code> (Front-End-Router) beginnen, um verfügbare VLANs aufzulisten. <br><strong>Hinweis</strong>: Wenn Workerknoten nur mit einem privaten VLAN eingerichtet werden, müssen Sie eine alternative Lösung für die Netzkonnektivität konfigurieren. Weitere Informationen finden Sie unter [Ausschließlich private Clusternetze planen](cs_network_cluster.html#private_vlan).</td>
</tr>
<tr>
<td><code>hardware</code></td>
<td>Für virtuelle Maschinentypen: Der Grad an Hardware-Isolation für Ihren Workerknoten. Verwenden Sie 'dedicated', wenn
Sie verfügbare physische Ressourcen haben möchten, die nur Sie nutzen können, oder 'shared', um zuzulassen, dass
physische Ressourcen mit anderen IBM Kunden gemeinsam genutzt werden können. Die Standardeinstellung ist
'shared'.</td>
</tr>
<tr>
<td><code>anzahl_worker</code></td>
<td>Ersetzen Sie <code><em>&lt;anzahl_worker&gt;</em></code> durch die Anzahl von Workerknoten, die Sie implementieren wollen.</td>
</tr>
<tr>
<td><code>diskEncryption: <em>false</em></code></td>
<td>Workerknoten weisen standardmäßig Verschlüsselung auf. [Weitere Informationen finden Sie hier](cs_secure.html#encrypted_disk). Um die Verschlüsselung zu inaktivieren, schließen Sie diese Option ein und legen Sie den Wert auf <code>false</code> fest.</td></tr>
</tbody></table></p></dd>

<dt><code>--hardware <em>HARDWARE</em></code></dt>
<dd>Der Grad an Hardware-Isolation für Ihren Workerknoten. Verwenden Sie 'dedicated', wenn
Sie verfügbare physische Ressourcen haben möchten, die nur Sie nutzen können, oder 'shared', um zuzulassen, dass
physische Ressourcen mit anderen IBM Kunden gemeinsam genutzt werden können. Die Standardeinstellung ist
'shared'. Dieser Wert ist optional.</dd>

<dt><code>--machine-type <em>MASCHINENTYP</em></code></dt>
<dd>Wählen Sie einen Maschinentyp aus. Sie können Ihre Workerknoten als virtuelle Maschinen auf gemeinsam genutzter oder dedizierter Hardware oder als physische Maschinen auf Bare-Metal-Systemen bereitstellen. Die Typen der verfügbaren physischen und virtuellen Maschinen variieren je nach der Zone, in der Sie den Cluster implementieren. Weitere Informationen finden Sie in der Dokumentation zum [Befehl `ibmcloud ks machine-types`](cs_cli_reference.html#cs_machine_types). Dieser Wert ist für Standardcluster erforderlich und steht für kostenlose Cluster nicht zur Verfügung.</dd>

<dt><code>--workers <em>ANZAHL</em></code></dt>
<dd>Die durch eine Ganzzahl angegebene Anzahl der Workerknoten, die im Cluster erstellt werden sollen. Der Standardwert ist 1. Dieser Wert ist optional.</dd>

<dt><code>--private-vlan <em>PRIVATES_VLAN</em></code></dt>
<dd>Das private VLAN, das bei der Erstellung des Clusters angegeben wurde. Dieser Wert ist erforderlich. Private VLAN-Router beginnen immer mit <code>bcr</code> (Back-End-Router) und öffentliche VLAN-Router immer mit <code>fcr</code> (Front-End-Router). Wenn Sie einen Cluster erstellen und die öffentlichen und privaten VLANs angeben, müssen die Zahlen- und Buchstabenkombinationen nach diesen Präfixen übereinstimmen.</dd>

<dt><code>--public-vlan <em>ÖFFENTLICHES_VLAN</em></code></dt>
<dd>Das öffentliche VLAN, das bei der Erstellung des Clusters angegeben wurde. Dieser Wert ist optional. Wenn Ihre Workerknoten ausschließlich in einem privaten VLAN bereitgestellt werden sollen, geben Sie keine öffentliche VLAN-ID an. Private VLAN-Router beginnen immer mit <code>bcr</code> (Back-End-Router) und öffentliche VLAN-Router immer mit <code>fcr</code> (Front-End-Router). Wenn Sie einen Cluster erstellen und die öffentlichen und privaten VLANs angeben, müssen die Zahlen- und Buchstabenkombinationen nach diesen Präfixen übereinstimmen.<p class="note">Wenn Workerknoten nur mit einem privaten VLAN eingerichtet werden, müssen Sie eine alternative Lösung für die Netzkonnektivität konfigurieren. Weitere Informationen finden Sie unter [Ausschließlich private Clusternetze planen](cs_network_cluster.html#private_vlan).</p></dd>

<dt><code>--disable-disk-encrypt</code></dt>
<dd>Workerknoten weisen standardmäßig Verschlüsselung auf. [Weitere Informationen finden Sie hier](cs_secure.html#encrypted_disk). Wenn Sie die Verschlüsselung inaktivieren möchten, schließen Sie diese Option ein.</dd>

<dt><code>-s</code></dt>
<dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>

</dl>

**Beispiele**:

  ```
  ibmcloud ks worker-add --cluster mein_cluster --workers 3 --public-vlan meine_öffentliche_vlan-id --private-vlan meine_private_vlan-id --machine-type b2c.4x16 --hardware shared
  ```
  {: pre}

  Beispiel für {{site.data.keyword.Bluemix_dedicated_notm}}:

  ```
  ibmcloud ks worker-add --cluster mein_cluster --workers 3 --machine-type b2c.4x16
  ```
  {: pre}

### ibmcloud ks worker-get --cluster [CLUSTERNAME_ODER_-ID] --worker WORKERKNOTEN-ID [--json][-s]
{: #cs_worker_get}

Zeigen Sie die Details eines Workerknotens an.

<strong>Erforderliche Mindestberechtigungen:</strong> Plattformrolle **Anzeigeberechtigter** für {{site.data.keyword.containerlong_notm}}

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTERNAME_ODER_-ID</em></code></dt>
   <dd>Der Name oder die ID des Workerknotenclusters. Dieser Wert ist optional.</dd>

   <dt><code>--worker <em>WORKERKNOTEN-ID</em></code></dt>
   <dd>Der Name Ihres Workerknotens. Führen Sie <code>ibmcloud ks workers <em>CLUSTER</em></code> aus, um die IDs für die Workerknoten in einem Cluster anzuzeigen. Dieser Wert ist erforderlich.</dd>

   <dt><code>--json</code></dt>
   <dd>Druckt die Befehlsausgabe im JSON-Format. Dieser Wert ist optional.</dd>

   <dt><code>-s</code></dt>
   <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>
   </dl>

**Beispielbefehl**:

  ```
  ibmcloud ks worker-get --cluster mein_cluster --worker kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w1
  ```
  {: pre}

**Beispielausgabe**:

  ```
  ID:           kube-dal10-123456789-w1
  State:        normal
  Status:       Ready
  Trust:        disabled
  Private VLAN: 223xxxx
  Public VLAN:  223xxxx
  Private IP:   10.xxx.xx.xxx
  Public IP:    169.xx.xxx.xxx
  Hardware:     shared
  Zone:         dal10
  Version:      1.8.11_1509
  ```
  {: screen}

### ibmcloud ks worker-reboot [-f][--hard] --cluster CLUSTER --worker WORKER [WORKER][--skip-master-healthcheck] [-s]
{: #cs_worker_reboot}

Führen Sie einen Warmstart eines Workerknotens in einem Cluster durch. Während des Warmstarts ändert sich der Status Ihres Workerknotens nicht. Sie können z. B. einen Warmstart durchführen, wenn der Status des Workerknotens in der IBM Cloud-Infrastruktur (SoftLayer) `Powered Off` (ausgeschaltet) lautet und Sie den Workerknoten aktivieren müssen.

**Achtung:** Der Warmstart eines Workerknotens kann zu Datenverlust auf dem Workerknoten führen. Verwenden Sie diesen Befehl mit Bedacht und wenn Sie wissen, dass ein Warmstart die Wiederherstellung Ihres Workerknotens unterstützen kann. In allen anderen Fällen sollten Sie stattdessen [Ihren Workerknoten erneut laden](#cs_worker_reload).

<strong>Erforderliche Mindestberechtigungen:</strong> Plattformrolle **Operator** für {{site.data.keyword.containerlong_notm}}

Stellen Sie, bevor Sie einen Warmstart für Ihren Workerknoten durchführen, sicher, dass die Pods erneut auf anderen Workerknoten geplant werden, um Ausfallzeiten für Ihre App oder Datenverlust auf Ihrem Workerknoten zu vermeiden.

1. Listen Sie die Workerknoten in Ihrem Cluster auf und notieren Sie sich den **Namen** des Workerknotens, für den Sie einen Warmstart durchführen möchten.
   ```
   kubectl get nodes
   ```
   {: pre}
   Der **Name**, der in diesem Befehl zurückgegeben wird, ist die private IP-Adresse, die Ihrem Workerknoten zugewiesen ist. Weitere Informationen zu Ihrem Workerknoten finden Sie, wenn Sie den Befehl `ibmcloud ks workers <cluster_name_or_ID>` ausführen und nach dem Workerknoten mit derselben **privaten IP**-Adresse suchen.
2. Markieren Sie den Workerknoten in einem Prozess, der als Abriegelung oder "Cordoning" bezeichnet wird, als nicht planbar ("unschedulable"). Wenn Sie einen Workerknoten abriegeln, ist er für die künftige Pod-Planung nicht mehr verfügbar. Verwenden Sie den **Namen** des Workerknotens, den Sie im vorherigen Schritt erhalten haben.
   ```
   kubectl cordon <workername>
   ```
   {: pre}

3. Überprüfen Sie, ob die Pod-Planung für Ihren Workerknoten inaktiviert ist
   ```
   kubectl get nodes
   ```
   {: pre}
   Ihr Workerknoten ist für die Pod-Planung inaktiviert, wenn der Status **SchedulingDisabled** angezeigt wird.
 4. Pods müssen aus Ihrem Workerknoten entfernt und auf den verbleibenden Workerknoten im Cluster erneut geplant werden.
    ```
    kubectl drain <workername>
    ```
    {: pre}
    Dieser Prozess kann einige Minuten dauern.
 5. Führen Sie einen Warmstart für den Workerknoten durch. Verwenden Sie die Worker-ID, die vom Befehl `ibmcloud ks workers <cluster_name_or_ID>` zurückgegeben wird.
    ```
    ibmcloud ks worker-reboot --cluster <clustername_oder_-id> --workers <workername_oder_-id>
    ```
    {: pre}
 6. Warten Sie ungefähr 5 Minuten, bevor Sie Ihre Workerknoten für die Pod-Planung zur Verfügung stellen, um sicherzustellen, dass der Warmstart abgeschlossen ist. Während des Warmstarts ändert sich der Status Ihres Workerknotens nicht. Der Warmstart eines Workerknotens ist in der Regel in wenigen Sekunden abgeschlossen.
 7. Stellen Sie Ihre Workerknoten für die Pod-Planung zur Verfügung. Verwenden Sie für Ihren Workerknoten den **Namen**, der vom Befehl `kubectl get nodes` zurückgegeben wurde.
    ```
    kubectl uncordon <workername>
    ```
    {: pre}

    </br>

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>

   <dt><code>-f</code></dt>
   <dd>Verwenden Sie diese Option, um den Neustart des Workerknotens ohne Benutzereingabeaufforderungen zu erzwingen. Dieser Wert ist optional.</dd>

   <dt><code>--hard</code></dt>
   <dd>Geben Sie diese Option an, um einen plötzlichen Neustart eines Workerknotens zu erzwingen, indem Sie die Stromversorgung zum Workerknoten kappen. Verwenden Sie diese Option, wenn der Workerknoten oder die Containerlaufzeit des Workerknotens nicht antwortet. Dieser Wert ist optional.</dd>

   <dt><code>--workers <em>WORKER</em></code></dt>
   <dd>Der Name oder die ID einzelner oder mehrerer Workerknoten. Trennen Sie bei einer Auflistung mehrerer Workerknoten die einzelnen Auflistungselemente jeweils durch ein Leerzeichen. Dieser Wert ist erforderlich.</dd>

   <dt><code>--skip-master-healthcheck</code></dt>
   <dd>Überspringen Sie die Statusprüfung des Masters, bevor Sie die Workerknoten erneut laden oder erneut starten.</dd>

   <dt><code>-s</code></dt>
   <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>
   </dl>

**Beispiel**:

  ```
  ibmcloud ks worker-reboot --cluster mein_cluster --worker kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w1 kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w2
  ```
  {: pre}


### ibmcloud ks worker-reload [-f] --cluster CLUSTER --workers WORKER [WORKER][--skip-master-healthcheck] [-s]
{: #cs_worker_reload}

Laden Sie die Konfigurationen für einen Workerknoten erneut. Ein erneutes Laden kann sinnvoll sein, wenn Ihr Workerknoten Probleme wie zum Beispiel langsames Laden aufweist oder wenn Ihr Knoten in einem nicht einwandfreien Zustand verharrt. Beachten Sie, dass Ihre Workerknotenmaschine während eines Neuladens mit dem neuen Image aktualisiert wird und dass dabei Daten gelöscht werden, die nicht [außerhalb des Workerknotens gespeichert sind](cs_storage_planning.html#persistent_storage_overview).
{: shortdesc}

Durch das erneute Laden eines Workerknotens werden Aktualisierungen von Patchversionen auf den Workerknoten angewendet; dies gilt jedoch nicht für Aktualisierungen von Haupt- oder Nebenversionen. Informationen zu den Änderungen von einer Patchversion zur nächsten finden Sie in der Dokumentation zum [Änderungsprotokoll der Version](cs_versions_changelog.html#changelog).
{: tip}

<strong>Erforderliche Mindestberechtigungen:</strong> Plattformrolle **Operator** für {{site.data.keyword.containerlong_notm}}

Stellen Sie, bevor Sie Ihren Workerknoten erneut laden, sicher, dass die Pods erneut auf anderen Workerknoten geplant werden, um Ausfallzeiten für Ihre App oder Datenverlust auf Ihrem Workerknoten zu vermeiden.

1. Listen Sie die Workerknoten in Ihrem Cluster auf und notieren Sie sich den **Namen** des Workerknotens, den Sie erneut laden möchten.
   ```
   kubectl get nodes
   ```
   Der **Name**, der in diesem Befehl zurückgegeben wird, ist die private IP-Adresse, die Ihrem Workerknoten zugewiesen ist. Weitere Informationen zu Ihrem Workerknoten finden Sie, wenn Sie den Befehl `ibmcloud ks workers <cluster_name_or_ID>` ausführen und nach dem Workerknoten mit derselben **privaten IP**-Adresse suchen.
2. Markieren Sie den Workerknoten in einem Prozess, der als Abriegelung oder "Cordoning" bezeichnet wird, als nicht planbar ("unschedulable"). Wenn Sie einen Workerknoten abriegeln, ist er für die künftige Pod-Planung nicht mehr verfügbar. Verwenden Sie den **Namen** des Workerknotens, den Sie im vorherigen Schritt erhalten haben.
   ```
   kubectl cordon <workername>
   ```
   {: pre}

3. Überprüfen Sie, ob die Pod-Planung für Ihren Workerknoten inaktiviert ist
   ```
   kubectl get nodes
   ```
   {: pre}
   Ihr Workerknoten ist für die Pod-Planung inaktiviert, wenn der Status **SchedulingDisabled** angezeigt wird.
 4. Pods müssen aus Ihrem Workerknoten entfernt und auf den verbleibenden Workerknoten im Cluster erneut geplant werden.
    ```
    kubectl drain <workername>
    ```
    {: pre}
    Dieser Prozess kann einige Minuten dauern.
 5. Laden Sie den Workerknoten erneut. Verwenden Sie die Worker-ID, die vom Befehl `ibmcloud ks workers <cluster_name_or_ID>` zurückgegeben wird.
    ```
    ibmcloud ks worker-reload --cluster <clustername_oder_-id> --workers <workername_oder_-id>
    ```
    {: pre}
 6. Warten Sie, bis das erneute Laden abgeschlossen ist.
 7. Stellen Sie Ihre Workerknoten für die Pod-Planung zur Verfügung. Verwenden Sie für Ihren Workerknoten den **Namen**, der vom Befehl `kubectl get nodes` zurückgegeben wurde.
    ```
    kubectl uncordon <workername>
    ```
</br>
<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>

   <dt><code>-f</code></dt>
   <dd>Verwenden Sie diese Option, um das erneute Laden eines Workerknotens ohne Benutzereingabeaufforderungen zu erzwingen. Dieser Wert ist optional.</dd>

   <dt><code>--worker <em>WORKER</em></code></dt>
   <dd>Der Name oder die ID einzelner oder mehrerer Workerknoten. Trennen Sie bei einer Auflistung mehrerer Workerknoten die einzelnen Auflistungselemente jeweils durch ein Leerzeichen. Dieser Wert ist erforderlich.</dd>

   <dt><code>--skip-master-healthcheck</code></dt>
   <dd>Überspringen Sie die Statusprüfung des Masters, bevor Sie die Workerknoten erneut laden oder erneut starten.</dd>

   <dt><code>-s</code></dt>
   <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>
   </dl>

**Beispiel**:

  ```
  ibmcloud ks worker-reload --cluster mein_cluster --workers kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w1 kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w2
  ```
  {: pre}


### ibmcloud ks worker-rm [-f] --cluster CLUSTER --workers WORKER[,WORKER][-s]
{: #cs_worker_rm}

Entfernen Sie einen oder mehrere Workerknoten von einem Cluster. Wenn Sie einen Workerknoten entfernen, ist Ihr Cluster nicht mehr ausgeglichen. Sie können Ihren Worker-Pool automatisch neu ausgleichen, indem Sie den [Befehl `ibmcloud ks worker-pool-rebalance`](#cs_rebalance) ausführen.

<strong>Erforderliche Mindestberechtigungen:</strong> Plattformrolle **Operator** für {{site.data.keyword.containerlong_notm}}

Stellen Sie, bevor Sie Ihren Workerknoten entfernen, sicher, dass die Pods erneut auf anderen Workerknoten geplant werden, um Ausfallzeiten für Ihre App oder Datenverlust auf Ihrem Workerknoten zu vermeiden.
{: tip}

1. Listen Sie die Workerknoten in Ihrem Cluster auf und notieren Sie sich den **Namen** des Workerknotens, den Sie entfernen möchten.
   ```
   kubectl get nodes
   ```
   Der **Name**, der in diesem Befehl zurückgegeben wird, ist die private IP-Adresse, die Ihrem Workerknoten zugewiesen ist. Weitere Informationen zu Ihrem Workerknoten finden Sie, wenn Sie den Befehl `ibmcloud ks workers <cluster_name_or_ID>` ausführen und nach dem Workerknoten mit derselben **privaten IP**-Adresse suchen.
2. Markieren Sie den Workerknoten in einem Prozess, der als Abriegelung oder "Cordoning" bezeichnet wird, als nicht planbar ("unschedulable"). Wenn Sie einen Workerknoten abriegeln, ist er für die künftige Pod-Planung nicht mehr verfügbar. Verwenden Sie den **Namen** des Workerknotens, den Sie im vorherigen Schritt erhalten haben.
   ```
   kubectl cordon <workername>
   ```
   {: pre}

3. Überprüfen Sie, ob die Pod-Planung für Ihren Workerknoten inaktiviert ist
   ```
   kubectl get nodes
   ```
   {: pre}
   Ihr Workerknoten ist für die Pod-Planung inaktiviert, wenn der Status **SchedulingDisabled** angezeigt wird.
4. Pods müssen aus Ihrem Workerknoten entfernt und auf den verbleibenden Workerknoten im Cluster erneut geplant werden.
   ```
   kubectl drain <workername>
   ```
   {: pre}
   Dieser Prozess kann einige Minuten dauern.
5. Entfernen Sie den Workerknoten. Verwenden Sie die Worker-ID, die vom Befehl `ibmcloud ks workers <cluster_name_or_ID>` zurückgegeben wird.
   ```
   ibmcloud ks worker-rm --cluster <clustername_oder_-id> --worker <workername_oder_-id>
   ```
   {: pre}

6. Überprüfen Sie, ob der Workerknoten entfernt wurde.
   ```
   ibmcloud ks workers --cluster <clustername_oder_-id>
   ```
</br>
<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>

   <dt><code>-f</code></dt>
   <dd>Verwenden Sie diese Option, um das Entfernen eines Workerknotens ohne Benutzereingabeaufforderungen zu erzwingen. Dieser Wert ist optional.</dd>

   <dt><code>--workers <em>WORKER</em></code></dt>
   <dd>Der Name oder die ID einzelner oder mehrerer Workerknoten. Trennen Sie bei einer Auflistung mehrerer Workerknoten die einzelnen Auflistungselemente jeweils durch ein Leerzeichen. Dieser Wert ist erforderlich.</dd>

   <dt><code>-s</code></dt>
   <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>
   </dl>

**Beispiel**:

  ```
  ibmcloud ks worker-rm --cluster mein_cluster --workers kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w1 kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w2
  ```
  {: pre}


### ibmcloud ks worker-update [-f] --cluster CLUSTER --workers WORKER[,WORKER][--force-update] [-s]
{: #cs_worker_update}

Aktualisieren Sie Workerknoten, um die neuesten Sicherheitsupdates und Patches auf das Betriebssystem anzuwenden und um die Kubernetes-Version auf die Version des Kubernetes-Master zu aktualisieren. Sie können die Version des Kubernetes-Masters mit dem [Befehl `ibmcloud ks cluster-update`](cs_cli_reference.html#cs_cluster_update) aktualisieren.

<strong>Erforderliche Mindestberechtigungen:</strong> Plattformrolle **Operator** für {{site.data.keyword.containerlong_notm}}

Durch die Ausführung von `ibmcloud ks worker-update` kann es zu Ausfallzeiten bei Ihren Apps und Services kommen. Während der Aktualisierung wird die Planung aller Pods auf anderen Workerknoten neu erstellt, es wird ein neues Image vom Workerknoten erstellt und die Daten werden gelöscht, wenn sie nicht außerhalb des Pods gespeichert wurden. Um Ausfallzeiten zu vermeiden, sollten Sie [sicherstellen, dass genügend Workerknoten vorhanden sind, um die Workload zu verarbeiten, während die ausgewählten Workerknoten aktualisiert werden](cs_cluster_update.html#worker_node).
{: important}

Möglicherweise müssen Sie Ihre YAML-Dateien für Bereitstellungen vor der Aktualisierung ändern. Lesen Sie die detaillierten Informationen in diesen [Releaseinformationen](cs_versions.html).

<strong>Befehlsoptionen</strong>:

   <dl>

   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Der Name oder die ID des Clusters, in dem Sie verfügbare Workerknoten auflisten. Dieser Wert ist erforderlich.</dd>

   <dt><code>-f</code></dt>
   <dd>Verwenden Sie diese Option, um die Aktualisierung des Masters ohne Benutzereingabeaufforderungen zu erzwingen. Dieser Wert ist optional.</dd>

   <dt><code>--force-update</code></dt>
   <dd>Versuch einer Aktualisierung, selbst wenn die Änderung sich über mehr als zwei Nebenversionen erstreckt. Dieser Wert ist optional.</dd>

   <dt><code>--workers <em>WORKER</em></code></dt>
   <dd>Die ID einzelner oder mehrerer Workerknoten. Trennen Sie bei einer Auflistung mehrerer Workerknoten die einzelnen Auflistungselemente jeweils durch ein Leerzeichen. Dieser Wert ist erforderlich.</dd>

   <dt><code>-s</code></dt>
   <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>

   </dl>

**Beispiel**:

  ```
  ibmcloud ks worker-update --cluster mein_cluster --worker kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w1 kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w2
  ```
  {: pre}

### ibmcloud ks workers --cluster CLUSTER [--worker-pool POOL][--show-pools] [--show-deleted][--json] [-s]
{: #cs_workers}

Anzeigen einer Liste der der Workerknoten und ihres jeweiligen Status in einem Cluster.

<strong>Erforderliche Mindestberechtigungen:</strong> Plattformrolle **Anzeigeberechtigter** für {{site.data.keyword.containerlong_notm}}

<strong>Befehlsoptionen</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Der Name oder die ID des Clusters für die verfügbaren Workerknoten. Dieser Wert ist erforderlich.</dd>

   <dt><code>--worker-pool <em>POOL</em></code></dt>
   <dd>Zeigen Sie nur die Workerknoten an, die zum Worker-Pool gehören. Führen Sie den Befehl `ibmcloud ks worker-pools --cluster <clustername_oder_-id>` aus, um verfügbare Worker-Pools aufzulisten. Dieser Wert ist optional.</dd>

   <dt><code>--show-pools</code></dt>
   <dd>Listen Sie den Worker-Pool auf, zu dem jeder Workerknoten gehört. Dieser Wert ist optional.</dd>

   <dt><code>--show-deleted</code></dt>
   <dd>Zeigen Sie Workerknoten an, die aus dem Cluster gelöscht wurden, und den Grund für das Löschen. Dieser Wert ist optional.</dd>

   <dt><code>--json</code></dt>
   <dd>Druckt die Befehlsausgabe im JSON-Format. Dieser Wert ist optional.</dd>

  <dt><code>-s</code></dt>
  <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>
   </dl>

**Beispiel**:

  ```
  ibmcloud ks workers --cluster mein_cluster
  ```
  {: pre}

<br />


## Befehle für Worker-Pools
{: #worker-pool}

### ibmcloud ks worker-pool-create --name POOL_NAME --cluster CLUSTER --machine-type MACHINE_TYPE --size-per-zone WORKERS_PER_ZONE --hardware ISOLATION [--labels LABELS][--disable-disk-encrypt] [-s][--json]
{: #cs_worker_pool_create}

Sie können einen Worker-Pool in Ihrem Cluster erstellen. Wenn Sie einen Worker-Pool hinzufügen, wird ihm standardmäßig keine Zone zugeordnet. Sie geben die gewünschte Anzahl von Workern für jede Zone und die Maschinentypen für die Worker an. Der Worker-Pool erhält die Standardversionen von Kubernetes. Um das Erstellen der Worker zu beenden, [fügen Sie eine Zone oder Zonen](#cs_zone_add) zu Ihrem Pool hinzu.

<strong>Erforderliche Mindestberechtigungen:</strong> Plattformrolle **Operator** für {{site.data.keyword.containerlong_notm}}

<strong>Befehlsoptionen</strong>:
<dl>

  <dt><code>--name <em>POOLNAME</em></code></dt>
    <dd>Der Name, den Sie Ihrem Worker-Pool geben wollen.</dd>

  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>

  <dt><code>--machine-type <em>MASCHINENTYP</em></code></dt>
    <dd>Wählen Sie einen Maschinentyp aus. Sie können Ihre Workerknoten als virtuelle Maschinen auf gemeinsam genutzter oder dedizierter Hardware oder als physische Maschinen auf Bare-Metal-Systemen bereitstellen. Die Typen der verfügbaren physischen und virtuellen Maschinen variieren je nach der Zone, in der Sie den Cluster implementieren. Weitere Informationen finden Sie in der Dokumentation zum [Befehl `ibmcloud ks machine-types`](cs_cli_reference.html#cs_machine_types). Dieser Wert ist für Standardcluster erforderlich und steht für kostenlose Cluster nicht zur Verfügung.</dd>

  <dt><code>--size-per-zone <em>WORKER_PRO_ZONE</em></code></dt>
    <dd>Die Anzahl der Worker, die in jeder Zone erstellt werden sollen. Dieser Wert ist erforderlich und muss '1' oder größer sein.</dd>

  <dt><code>--hardware <em>ISOLATION</em></code></dt>
    <dd>Der Grad an Hardware-Isolation für Ihren Workerknoten. Verwenden Sie `dedicated`, wenn Sie verfügbare physische Ressourcen haben möchten, die nur Sie nutzen können, oder `shared`, um zuzulassen, dass physische Ressourcen mit anderen IBM Kunden gemeinsam genutzt werden können. Die Standardeinstellung ist `shared`. Geben Sie für Bare-Metal-Maschinentypen `dedicated` an. Dieser Wert ist erforderlich.</dd>

  <dt><code>--labels <em>BEZEICHNUNGEN</em></code></dt>
    <dd>Die Bezeichnungen, die Sie den Workern im Pool zuweisen möchten. Beispiel: `<key1>=<val1>`,`<key2>=<val2>`</dd>

  <dt><code>--disable-disk-encrpyt</code></dt>
    <dd>Gibt an, dass die Platte nicht verschlüsselt ist. Der Standardwert ist <code>false</code>.</dd>

  <dt><code>--json</code></dt>
    <dd>Druckt die Befehlsausgabe im JSON-Format. Dieser Wert ist optional.</dd>

  <dt><code>-s</code></dt>
    <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>
</dl>

**Beispielbefehl**:

  ```
  ibmcloud ks worker-pool-create --name mein_pool --cluster mein_cluster --machine-type b2c.4x16 --size-per-zone 6
  ```
  {: pre}

### ibmcloud ks worker-pool-get --worker-pool WORKERPOOL --cluster CLUSTER [-s][--json]
{: #cs_worker_pool_get}

Zeigen Sie die Details eines Worker-Pools an.

<strong>Erforderliche Mindestberechtigungen:</strong> Plattformrolle **Anzeigeberechtigter** für {{site.data.keyword.containerlong_notm}}

<strong>Befehlsoptionen</strong>:

<dl>
  <dt><code>--worker-pool <em>WORKER-POOL</em></code></dt>
    <dd>Der Name des Workerknoten-Pools, für den die Details angezeigt werden sollen. Führen Sie den Befehl `ibmcloud ks worker-pools --cluster <clustername_oder_-id>` aus, um verfügbare Worker-Pools aufzulisten. Dieser Wert ist erforderlich.</dd>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>Der Name oder die ID des Clusters, in dem sich der Worker-Pool befindet. Dieser Wert ist erforderlich.</dd>

  <dt><code>--json</code></dt>
    <dd>Druckt die Befehlsausgabe im JSON-Format. Dieser Wert ist optional.</dd>

  <dt><code>-s</code></dt>
    <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>
</dl>

**Beispielbefehl**:

  ```
  ibmcloud ks worker-pool-get --worker-pool pool1 --cluster mein_cluster
  ```
  {: pre}

**Beispielausgabe**:

  ```
  Name:               pool   
  ID:                 a1a11b2222222bb3c33c3d4d44d555e5-f6f777g   
  State:              active   
  Hardware:           shared   
  Zones:              dal10,dal12   
  Workers per zone:   3   
  Machine type:       b2c.4x16.encrypted   
  Labels:             -   
  Version:            1.10.11_1512
  ```
  {: screen}

### ibmcloud ks worker-pool-rebalance --cluster CLUSTER --worker-pool WORKER-POOL [-s]
{: #cs_rebalance}

Nach dem Löschen eines Workerknotens können Sie den Worker-Pool neu ausgleichen. Wenn Sie diesen Befehl ausführen, wird Ihrem Worker-Pool mindestens ein neuer Worker hinzugefügt.

<strong>Erforderliche Mindestberechtigungen:</strong> Plattformrolle **Operator** für {{site.data.keyword.containerlong_notm}}

<strong>Befehlsoptionen</strong>:

<dl>
  <dt><code><em>--cluster CLUSTER</em></code></dt>
    <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>
  <dt><code><em>--worker-pool WORKER-POOL</em></code></dt>
    <dd>Der Worker-Pool, den Sie neu ausgleichen möchten. Dieser Wert ist erforderlich.</dd>
  <dt><code>-s</code></dt>
    <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>
</dl>

**Beispiel**:

  ```
  ibmcloud ks worker-pool-rebalance --cluster mein_cluster --worker-pool mein_pool
  ```
  {: pre}

### ibmcloud ks worker-pool-resize --worker-pool WORKER-POOL --cluster CLUSTER --size-per-zone WORKER_PRO_ZONE [-s]
{: #cs_worker_pool_resize}

Ändern Sie die Größe des Worker-Pools, um die Anzahl der Workerknoten zu erhöhen oder zu verringern, die sich in den einzelnen Zonen des Clusters befinden. Der Worker-Pool muss mindestens einen Workerknoten aufweisen.

<strong>Erforderliche Mindestberechtigungen:</strong> Plattformrolle **Operator** für {{site.data.keyword.containerlong_notm}}

<strong>Befehlsoptionen</strong>:

<dl>
  <dt><code>--worker-pool <em>WORKER-POOL</em></code></dt>
    <dd>Der Name des Workerknoten-Pools, der aktualisiert werden soll. Dieser Wert ist erforderlich.</dd>

  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>Der Name oder die ID des Clusters, für den die Größe von Worker-Pools geändert werden soll. Dieser Wert ist erforderlich.</dd>

  <dt><code>--size-per-zone <em>WORKER_PRO_ZONE</em></code></dt>
    <dd>Die Anzahl der Worker, die in jeder Zone vorhanden sein sollen. Dieser Wert ist erforderlich und muss '1' oder größer sein.</dd>

  <dt><code>-s</code></dt>
    <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>

</dl>

**Beispielbefehl**:

  ```
  ibmcloud ks worker-pool-resize --cluster mein_cluster --worker-pool mein_pool --size-per-zone 3
  ```
  {: pre}

### ibmcloud ks worker-pool-rm --worker-pool WORKER-POOL --cluster CLUSTER [-s]
{: #cs_worker_pool_rm}

Entfernen Sie einen Worker-Pool aus dem Cluster. Alle Workerknoten im Pool werden gelöscht. Die Pods werden beim Löschvorgang neu terminiert. Um Ausfallzeiten zu vermeiden, stellen Sie sicher, dass Sie über genügend Worker zum Ausführen Ihrer Workload verfügen.

<strong>Erforderliche Mindestberechtigungen:</strong> Plattformrolle **Operator** für {{site.data.keyword.containerlong_notm}}

<strong>Befehlsoptionen</strong>:

<dl>
  <dt><code>--worker-pool <em>WORKER-POOL</em></code></dt>
    <dd>Der Name des Workerknoten-Pools, der entfernt werden soll. Dieser Wert ist erforderlich.</dd>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>Der Name oder die ID des Clusters, aus dem der Worker-Pool entfernt werden soll. Dieser Wert ist erforderlich.</dd>
  <dt><code>-s</code></dt>
    <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>
</dl>

**Beispielbefehl**:

  ```
  ibmcloud ks worker-pool-rm --cluster mein_cluster --worker-pool pool1
  ```
  {: pre}

### ibmcloud ks worker-pools --cluster CLUSTER [--json][-s]
{: #cs_worker_pools}

Zeigen Sie die Worker-Pools in einem Cluster an.

<strong>Erforderliche Mindestberechtigungen:</strong> Plattformrolle **Anzeigeberechtigter** für {{site.data.keyword.containerlong_notm}}

<strong>Befehlsoptionen</strong>:

<dl>
  <dt><code>--cluster <em>CLUSTERNAME_ODER_-ID</em></code></dt>
    <dd>Der Name oder die ID des Clusters, für den Worker-Pools aufgelistet werden sollen. Dieser Wert ist erforderlich.</dd>
  <dt><code>--json</code></dt>
    <dd>Druckt die Befehlsausgabe im JSON-Format. Dieser Wert ist optional.</dd>
  <dt><code>-s</code></dt>
    <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>
</dl>

**Beispielbefehl**:

  ```
  ibmcloud ks worker-pools --cluster mein_cluster
  ```
  {: pre}

### ibmcloud ks zone-add --zone ZONE --cluster CLUSTER --worker-pools WORKER-POOL1[,WORKER-POOL2] --private-vlan PRIVATES_VLAN [--public-vlan ÖFFENTLICHES_VLAN][--private-only] [--json][-s]
{: #cs_zone_add}

**Nur Mehrzonencluster**: Nachdem Sie einen Cluster oder Worker-Pool erstellt haben, können Sie eine Zone hinzufügen. Wenn Sie eine Zone hinzufügen, werden die Workerknoten der neuen Zone hinzugefügt, damit sie der Anzahl der Worker pro Zone entsprechen, die Sie für den Worker-Pool angegeben haben.

<strong>Erforderliche Mindestberechtigungen:</strong> Plattformrolle **Operator** für {{site.data.keyword.containerlong_notm}}

<strong>Befehlsoptionen</strong>:

<dl>
  <dt><code>--zone <em>ZONE</em></code></dt>
    <dd>Die Zone, die Sie hinzufügen möchten. Es muss sich um eine [für mehrere Zonen geeignete Zone](cs_regions.html#zones) in der Region des Clusters handeln. Dieser Wert ist erforderlich.</dd>

  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>

  <dt><code>--worker-pool <em>WORKER-POOLS</em></code></dt>
    <dd>Eine durch Kommas getrennte Liste der Worker-Pools, zu denen die Zone hinzugefügt wird. Es ist mindestens ein Worker-Pool erforderlich.</dd>

  <dt><code>--private-vlan <em>PRIVATES_VLAN</em></code></dt>
    <dd><p>Die ID des privaten VLAN. Dieser Wert ist bedingt.</p>
    <p>Wenn Sie über ein privates VLAN in der Zone verfügen, muss dieser Wert mit der privaten VLAN-ID von mindestens einem Workerknoten im Cluster übereinstimmen. Wenn Sie die verfügbaren VLANs anzeigen möchten, führen Sie den Befehl <code>ibmcloud ks cluster-get --cluster &lt;cluster&gt; --showResources</code> aus. Neue Workerknoten werden dem von Ihnen angegebenen VLAN hinzugefügt, die VLANs für alle vorhandenen Workerknoten werden jedoch nicht geändert.</p>
    <p>Wenn Sie in dieser Zone kein privates oder öffentliches VLAN haben, geben Sie diese Option nicht an. Ein privates und ein öffentliches VLAN werden automatisch für Sie erstellt, wenn Sie Ihrem Worker-Pool anfänglich eine neue Zone hinzufügen.</p>
    <p>Wenn Sie über mehrere VLANs für einen Cluster, mehrere Teilnetze in demselben VLAN oder einen Cluster mit mehreren Zonen verfügen, müssen Sie [VLAN-Spanning](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) für Ihr Konto für die IBM Cloud-Infrastruktur (SoftLayer) aktivieren, damit die Workerknoten in dem privaten Netz miteinander kommunizieren können. Um diese Aktion durchführen zu können, müssen Sie über die [Infrastrukturberechtigung](cs_users.html#infra_access) **Netz > VLAN-Spanning im Netz verwalten** verfügen oder Sie können den Kontoeigner bitte, diese zu aktivieren. Um zu prüfen, ob das VLAN-Spanning bereits aktiviert ist, verwenden Sie den [Befehl](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`. Wenn Sie {{site.data.keyword.BluDirectLink}} verwenden, müssen Sie stattdessen eine [ VRF-Funktion (Virtual Router Function)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf) verwenden. Um VRF zu aktivieren, wenden Sie sich an Ihren Ansprechpartner für die IBM Cloud-Infrastruktur (SoftLayer).</p></dd>

  <dt><code>--public-vlan <em>ÖFFENTLICHES_VLAN</em></code></dt>
    <dd><p>Die ID des öffentlichen VLANs. Dieser Wert ist erforderlich, wenn Sie Workloads auf den Knoten der Öffentlichkeit zugänglich machen möchten, nachdem Sie den Cluster erstellt haben. Die ID muss mit der öffentlichen VLAN-ID eines oder mehrerer Workerknoten im Cluster für die Zone übereinstimmen. Wenn Sie die verfügbaren VLANs anzeigen möchten, führen Sie den Befehl <code>ibmcloud ks cluster-get --cluster &lt;cluster&gt; --showResources</code> aus. Neue Workerknoten werden dem von Ihnen angegebenen VLAN hinzugefügt, die VLANs für alle vorhandenen Workerknoten werden jedoch nicht geändert.</p>
    <p>Wenn Sie in dieser Zone kein privates oder öffentliches VLAN haben, geben Sie diese Option nicht an. Ein privates und ein öffentliches VLAN werden automatisch für Sie erstellt, wenn Sie Ihrem Worker-Pool anfänglich eine neue Zone hinzufügen.</p>
    <p>Wenn Sie über mehrere VLANs für einen Cluster, mehrere Teilnetze in demselben VLAN oder einen Cluster mit mehreren Zonen verfügen, müssen Sie [VLAN-Spanning](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) für Ihr Konto für die IBM Cloud-Infrastruktur (SoftLayer) aktivieren, damit die Workerknoten in dem privaten Netz miteinander kommunizieren können. Um diese Aktion durchführen zu können, müssen Sie über die [Infrastrukturberechtigung](cs_users.html#infra_access) **Netz > VLAN-Spanning im Netz verwalten** verfügen oder Sie können den Kontoeigner bitte, diese zu aktivieren. Um zu prüfen, ob das VLAN-Spanning bereits aktiviert ist, verwenden Sie den [Befehl](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`. Wenn Sie {{site.data.keyword.BluDirectLink}} verwenden, müssen Sie stattdessen eine [ VRF-Funktion (Virtual Router Function)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf) verwenden. Um VRF zu aktivieren, wenden Sie sich an Ihren Ansprechpartner für die IBM Cloud-Infrastruktur (SoftLayer).</p></dd>

  <dt><code>--private-only </code></dt>
    <dd>Verwenden Sie diese Option, um zu verhindern, dass ein öffentliches VLAN erstellt wird. Dieser Wert ist nur erforderlich, wenn Sie das Flag `--private-vlan` angeben und das Flag `--public-vlan` nicht einschließen.<p class="note">Wenn Sie mit einem ausschließlich privaten Cluster (private-only) arbeiten möchten, müssen sie eine Gateway-Appliance für die Netzkonnektivität konfigurieren. Weitere Informationen finden Sie in [Private Cluster](cs_clusters_planning.html#private_clusters).</p></dd>

  <dt><code>--json</code></dt>
    <dd>Druckt die Befehlsausgabe im JSON-Format. Dieser Wert ist optional.</dd>

  <dt><code>-s</code></dt>
    <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>
</dl>

**Beispiel**:

  ```
  ibmcloud ks zone-add --zone dal10 --cluster mein_cluster --worker-pools pool1,pool2,pool3 --private-vlan 2294021
  ```
  {: pre}

  ### ibmcloud ks zone-network-set --zone ZONE --cluster CLUSTER --worker-pools WORKER-POOL1[,WORKER-POOL2] --private-vlan PRIVATES_VLAN [--public-vlan ÖFFENTLICHES_VLAN][-f] [-s]
  {: #cs_zone_network_set}

  **Nur Mehrzonencluster**: Legen Sie die Netzmetadaten für einen Worker-Pool so fest, dass sie ein anderes öffentliches oder privates VLAN als zuvor für die Zone verwenden. Workerknoten, die bereits im Pool erstellt wurden, verwenden weiterhin das vorherige öffentliche oder private VLAN, neue Workerknoten in dem Pool verwenden jedoch die neuen Netzdaten.

  <strong>Erforderliche Mindestberechtigungen:</strong> Plattformrolle **Operator** für {{site.data.keyword.containerlong_notm}}

  Private VLAN-Router beginnen immer mit <code>bcr</code> (Back-End-Router) und öffentliche VLAN-Router immer mit <code>fcr</code> (Front-End-Router). Wenn Sie einen Cluster erstellen und die öffentlichen und privaten VLANs angeben, müssen die Zahlen- und Buchstabenkombinationen nach diesen Präfixen übereinstimmen.
  <ol><li>Überprüfen Sie die VLANs, die in Ihrem Cluster verfügbar sind. <pre class="pre"><code>ibmcloud ks cluster-get --cluster &lt;clustername_oder_-id&gt; --showResources</code></pre><p>Beispielausgabe:</p>
  <pre class="screen"><code>Subnet VLANs
VLAN ID   Subnet CIDR         Public   User-managed
229xxxx   169.xx.xxx.xxx/29   true     false
229xxxx   10.xxx.xx.x/29      false    false</code></pre></li>
  <li>Prüfen Sie, ob die öffentlichen und privaten VLAN-IDs, die Sie verwenden möchten, kompatibel sind. Um kompatibel zu sein, muss der <strong>Router</strong> dieselbe Pod-ID aufweisen.<pre class="pre"><code>ibmcloud ks vlans --zone &lt;zone&gt;</code></pre><p>Beispielausgabe:</p>
  <pre class="screen"><code>ID        Name   Number   Type      Router         Supports Virtual Workers
229xxxx          1234     private   bcr01a.dal12   true
229xxxx          5678     public    fcr01a.dal12   true</code></pre><p>Beachten Sie, dass die Pod-IDs des <strong>Routers</strong> übereinstimmen: `01a` und `01a`. Wenn eine Pod-ID `01a` und die andere Pod-ID `02a` ist, können Sie diese öffentlichen und privaten VLAN-IDs nicht für Ihren Worker-Pool festlegen.</p></li>
  <li>Wenn keine VLANs verfügbar sind, können Sie <a href="/docs/infrastructure/vlans/order-vlan.html#ordering-premium-vlans">neue VLANs bestellen</a>.</li></ol>

  <strong>Befehlsoptionen</strong>:

  <dl>
    <dt><code>--zone <em>ZONE</em></code></dt>
      <dd>Die Zone, die Sie hinzufügen möchten. Es muss sich um eine [für mehrere Zonen geeignete Zone](cs_regions.html#zones) in der Region des Clusters handeln. Dieser Wert ist erforderlich.</dd>

  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>

  <dt><code>--worker-pool <em>WORKER-POOLS</em></code></dt>
    <dd>Eine durch Kommas getrennte Liste der Worker-Pools, zu denen die Zone hinzugefügt wird. Es ist mindestens ein Worker-Pool erforderlich.</dd>

  <dt><code>--private-vlan <em>PRIVATES_VLAN</em></code></dt>
    <dd>Die ID des privaten VLAN. Dieser Wert ist erforderlich, unabhängig davon, ob Sie dasselbe oder ein anderes privates VLAN als dasjenige verwenden möchten, das Sie für Ihre anderen Workerknoten verwendet haben. Neue Workerknoten werden dem von Ihnen angegebenen VLAN hinzugefügt, die VLANs für alle vorhandenen Workerknoten werden jedoch nicht geändert.<p class="note">Die privaten und öffentlichen VLANs müssen kompatibel sein, was sich anhand des ID-Präfix **Router** bestimmen lässt.</p></dd>

  <dt><code>--public-vlan <em>ÖFFENTLICHES_VLAN</em></code></dt>
    <dd>Die ID des öffentlichen VLANs. Dieser Wert ist nur erforderlich, wenn Sie das öffentliche VLAN für die Zone ändern möchten. Um das öffentliche VLAN zu ändern, müssen Sie immer ein kompatibles privates VLAN angeben. Neue Workerknoten werden dem von Ihnen angegebenen VLAN hinzugefügt, die VLANs für alle vorhandenen Workerknoten werden jedoch nicht geändert.<p class="note">Die privaten und öffentlichen VLANs müssen kompatibel sein, was sich anhand des ID-Präfix **Router** bestimmen lässt.</p></dd>

  <dt><code>-f</code></dt>
    <dd>Erzwingen Sie die Ausführung des Befehls ohne Eingabeaufforderungen. Dieser Wert ist optional.</dd>

  <dt><code>-s</code></dt>
    <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>
  </dl>

  **Beispiel**:

  ```
  ibmcloud ks zone-network-set --zone dal10 --cluster mein_cluster --worker-pools pool1,pool2,pool3 --private-vlan 2294021
  ```
  {: pre}

### ibmcloud ks zone-rm --zone ZONE --cluster CLUSTER [-f][-s]
{: #cs_zone_rm}

**Nur Mehrzonencluster**: Entfernen Sie eine Zone aus allen Worker-Pools in Ihrem Cluster. Alle Workerknoten im Worker-Pool für diese Zone werden gelöscht.

Bevor Sie eine Zone entfernen, stellen Sie sicher, dass genügend Workerknoten in anderen Zonen im Cluster vorhanden sind, damit Ihre Pods neu geplant werden können, um eine Ausfallzeit für Ihre App oder die Beschädigung von Daten auf Ihrem Workerknoten zu vermeiden.
{: tip}

<strong>Erforderliche Mindestberechtigungen:</strong> Plattformrolle **Operator** für {{site.data.keyword.containerlong_notm}}

<strong>Befehlsoptionen</strong>:

<dl>
  <dt><code>--zone <em>ZONE</em></code></dt>
    <dd>Die Zone, die Sie hinzufügen möchten. Es muss sich um eine [für mehrere Zonen geeignete Zone](cs_regions.html#zones) in der Region des Clusters handeln. Dieser Wert ist erforderlich.</dd>

  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>Der Name oder die ID des Clusters. Dieser Wert ist erforderlich.</dd>

  <dt><code>-f</code></dt>
    <dd>Erzwingen Sie die Aktualisierung ohne Benutzereingabeaufforderungen. Dieser Wert ist optional.</dd>

  <dt><code>-s</code></dt>
    <dd>Die Tagesnachricht wird nicht angezeigt oder es werden keine Erinnerungen aktualisiert. Dieser Wert ist optional.</dd>
</dl>

**Beispiel**:

  ```
  ibmcloud ks zone-rm --zone dal10 --cluster mein_cluster
  ```
  {: pre}
