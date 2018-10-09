---

copyright:
  years: 2014, 2018
lastupdated: "2018-09-10"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}





# {{site.data.keyword.containerlong_notm}} Guida di riferimento alla CLI
{: #cs_cli_reference}

Fai riferimento a questi comandi per creare e gestire i cluster Kubernetes in {{site.data.keyword.containerlong}}.
{:shortdesc}

Per installare il plug-in della CLI, vedi [Installazione della CLI](cs_cli_install.html#cs_cli_install_steps).

Nel terminale, ricevi una notifica quando sono disponibili degli aggiornamenti ai plug-in e alla CLI `ibmcloud`. Assicurati di mantenere la tua CLI aggiornata in modo che tu possa utilizzare tutti i comandi e gli indicatori disponibili.

Cerchi i comandi `ibmcloud cr`? Consulta i riferimenti CLI [{{site.data.keyword.registryshort_notm}} ](/docs/cli/plugins/registry/index.html). Stai cercando i comandi `kubectl`? Consulta la [Documentazione Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/reference/kubectl/overview/).
{:tip}

## Comandi ibmcloud ks
{: #cs_commands}

**Suggerimento:** per visualizzare la versione del plug-in {{site.data.keyword.containerlong_notm}}, esegui il seguente comando.

```
ibmcloud plugin list
```
{: pre}



<table summary="Tabella comandi API">
<caption>Comandi API</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>Comandi API</th>
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

<table summary="Tabella comandi utilizzo plugin CLI">
<caption>Comandi utilizzo plugin CLI</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>Comandi utilizzo plugin CLI</th>
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

<table summary="Comandi cluster: tabella di gestione">
<caption>Comandi cluster: comandi di gestione</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>Comandi cluster: gestione</th>
 </thead>
 <tbody>
  <tr>
    <td>[ibmcloud ks cluster-config](#cs_cluster_config)</td>
    <td>[ibmcloud ks cluster-create](#cs_cluster_create)</td>
    <td>[ibmcloud ks cluster-feature-enable](#cs_cluster_feature_enable)</td>
    <td>[ibmcloud ks cluster-get](#cs_cluster_get)</td>
  </tr>
  <tr>
    <td>[ibmcloud ks cluster-rm](#cs_cluster_rm)</td>
    <td>[ibmcloud ks cluster-update](#cs_cluster_update)</td>
    <td>[ibmcloud ks clusters](#cs_clusters)</td>
    <td>[ibmcloud ks kube-versions](#cs_kube_versions)</td>
  </tr>
</tbody>
</table>

<br>

<table summary="Comandi cluster: tabella servizi e integrazioni">
<caption>Comandi cluster: comandi di servizi e integrazioni</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>Comandi cluster: servizi e integrazioni</th>
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

<table summary="Comandi cluster: tabella sottoreti">
<caption>Comandi cluster: comandi sottoreti</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>Comandi cluster: sottoreti</th>
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

<table summary="Tabella comandi infrastruttura">
<caption>Comandi cluster: comandi infrastruttura</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>Comandi infrastruttura</th>
 </thead>
 <tbody>
  <tr>
    <td>[ibmcloud ks credentials-set](#cs_credentials_set)</td>
    <td>[ibmcloud ks credentials-unset](#cs_credentials_unset)</td>
    <td>[ibmcloud ks machine-types](#cs_machine_types)</td>
    <td>[ibmcloud ks vlans](#cs_vlans)</td>
  </tr>
  <tr>
    <td>[ibmcloud ks vlan-spanning-get](#cs_vlan_spanning_get)</td>
    <td> </td>
    <td> </td>
    <td> </td>
  </tr>
</tbody>
</table>

</br>

<table summary="Tabella comandi del programma di bilanciamento del carico dell'applicazione (ALB) Ingress">
<caption>Comandi del programma di bilanciamento del carico dell'applicazione (ALB) Ingress</caption>
<col width = 25%>
<col width = 25%>
<col width = 25%>
  <thead>
    <tr>
      <th colspan=4>Comandi del programma di bilanciamento del carico dell'applicazione (ALB) Ingress</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>[ibmcloud ks alb-cert-deploy](#cs_alb_cert_deploy)</td>
      <td>[ibmcloud ks alb-cert-get](#cs_alb_cert_get)</td>
      <td>[ibmcloud ks alb-cert-rm](#cs_alb_cert_rm)</td>
      <td>[ibmcloud ks alb-certs](#cs_alb_certs)</td>
    </tr>
    <tr>
      <td>[ibmcloud ks alb-configure](#cs_alb_configure)</td>
      <td>[ibmcloud ks alb-get](#cs_alb_get)</td>
      <td>[ibmcloud ks alb-types](#cs_alb_types)</td>
      <td>[ibmcloud ks albs](#cs_albs)</td>
    </tr>
  </tbody>
</table>

</br>

<table summary="Tabella comandi registrazione">
<caption>Comandi registrazione</caption>
<col width = 25%>
<col width = 25%>
<col width = 25%>
  <thead>
    <tr>
      <th colspan=4>Comandi registrazione</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>[ibmcloud ks logging-config-create](#cs_logging_create)</td>
      <td>[ibmcloud ks logging-config-get](#cs_logging_get)</td>
      <td>[ibmcloud ks logging-config-refresh](#cs_logging_refresh)</td>
      <td>[ibmcloud ks logging-config-rm](#cs_logging_rm)</td>
    </tr>
    <tr>
      <td>[ibmcloud ks logging-config-update](#cs_logging_update)</td>
      <td>[ibmcloud ks logging-filter-create](#cs_log_filter_create)</td>
      <td>[ibmcloud ks logging-filter-update](#cs_log_filter_update)</td>
      <td>[ibmcloud ks logging-filter-get](#cs_log_filter_view)</td>
    </tr>
    <tr>
      <td>[ibmcloud ks logging-filter-rm](#cs_log_filter_delete)</td>
      <td>[ibmcloud ks logging-autoupdate-enable](#cs_log_autoupdate_enable)</td>
      <td>[ibmcloud ks logging-autoupdate-disable](#cs_log_autoupdate_disable)</td>
      <td>[ibmcloud ks logging-autoupdate-get](#cs_log_autoupdate_get)</td>
    </tr>
  </tbody>
</table>

</br>

<table summary="Tabella comandi regione">
<caption>Comandi regione</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>Comandi regione</th>
 </thead>
 <tbody>
  <tr>
    <td>[ibmcloud ks zones](#cs_datacenters)</td>
    <td>[ibmcloud ks region](#cs_region)</td>
    <td>[ibmcloud ks region-set](#cs_region-set)</td>
    <td>[ibmcloud ks regions](#cs_regions)</td>
  </tr>
</tbody>
</table>

</br>

<table summary="Tabella comandi nodo di lavoro">
<caption>Comandi nodo di lavoro</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>Comandi nodo di lavoro</th>
 </thead>
 <tbody>
    <tr>
      <td>Obsoleto: [ibmcloud ks worker-add](#cs_worker_add)</td>
      <td>[ibmcloud ks worker-get](#cs_worker_get)</td>
      <td>[ibmcloud ks worker-reboot](#cs_worker_reboot)</td>
      <td>[ibmcloud ks worker-reload](#cs_worker_reload)</td>
    </tr>
    <tr>
      <td>[ibmcloud ks worker-rm](#cs_worker_rm)</td>
      <td>[ibmcloud ks worker-update](#cs_worker_update)</td>
      <td>[ibmcloud ks workers](#cs_workers)</td>
      <td>[ibmcloud ks worker-get](#cs_worker_get)</td>
    </tr>
    <tr>
      <td>[ibmcloud ks worker-reboot](#cs_worker_reboot)</td>
      <td>[ibmcloud ks worker-reload](#cs_worker_reload)</td>
      <td>[ibmcloud ks worker-rm](#cs_worker_rm)</td>
      <td>[ibmcloud ks workers](#cs_workers)</td>
    </tr>
  </tbody>
</table>

<table summary="Tabella comandi pool di nodi di lavoro">
<caption>Comandi pool di nodi di lavoro</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>Comandi pool di nodi di lavoro</th>
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

## Comandi API
{: #api_commands}

### ibmcloud ks api --endpoint ENDPOINT [--insecure][--skip-ssl-validation] [--api-version VALUE][-s]
{: #cs_api}

Specifica l'endpoint API per {{site.data.keyword.containerlong_notm}}. Se non specifichi un endpoint, puoi visualizzare le informazioni sull'endpoint corrente che viene specificato.

Cambio di regioni? Utilizza invece il comando `ibmcloud ks region-set` [](#cs_region-set).
{: tip}

<strong>Opzioni comando</strong>:

   <dl>
   <dt><code>--endpoint <em>ENDPOINT</em></code></dt>
   <dd>L'endpoint API {{site.data.keyword.containerlong_notm}}. Tieni presente che questo endpoint è diverso dagli endpoint {{site.data.keyword.Bluemix_notm}}. Questo valore è obbligatorio per configurare l'endpoint API. I valori accettati sono:<ul>
   <li>Endpoint globale: https://containers.bluemix.net</li>
   <li>Endpoint Asia Pacifico Nord: https://ap-north.containers.bluemix.net</li>
   <li>Endpoint Asia Pacifico Sud: https://ap-south.containers.bluemix.net</li>
   <li>Endpoint Europa Centrale: https://eu-central.containers.bluemix.net</li>
   <li>Endpoint Regno Unito Sud: https://uk-south.containers.bluemix.net</li>
   <li>Endpoint Stati Uniti Est: https://us-east.containers.bluemix.net</li>
   <li>Endpoint Stati Uniti Sud: https://us-south.containers.bluemix.net</li></ul>
   </dd>

   <dt><code>--insecure</code></dt>
   <dd>Consente una connessione HTTP non sicura. Questo indicatore è facoltativo.</dd>

   <dt><code>--skip-ssl-validation</code></dt>
   <dd>Consente i certificati SSL non sicuri. Questo indicatore è facoltativo.</dd>

   <dt><code>--api-version VALUE</code></dt>
   <dd>Specifica la versione dell'API del servizio che vuoi utilizzare. Questo valore è facoltativo.</dd>

   <dt><code>-s</code></dt>
   <dd>Non visualizza il messaggio dei promemoria di aggiornamento o del giorno. Questo valore è facoltativo.</dd>

   </dl>

**Esempio**: visualizza le informazioni sull'endpoint API corrente che viene specificato.
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

Visualizza il nome e l'indirizzo e-mail del proprietario della chiave API IAM in una regione {{site.data.keyword.containerlong_notm}}.

La chiave API IAM (Identity and Access Management) viene impostata automaticamente per una regione quando viene eseguita la prima azione che richiede la politica di accesso come amministratore {{site.data.keyword.containerlong_notm}}. Ad esempio, uno dei tuoi utenti amministratore crea il primo cluster nella regione `us-south`. In questo modo, la chiave API IAM di questo utente viene memorizzata nell'account per questa regione. La chiave API viene utilizzata per ordinare le risorse nell'infrastruttura IBM Cloud (SoftLayer), come nuovi nodi di lavoro o VLAN.

Quando un altro utente esegue un'azione in questa regione che richiede l'interazione con il portfolio dell'infrastruttura IBM Cloud (SoftLayer), come la creazione di un nuovo cluster o il ricaricamento di un nodo di lavoro, la chiave API memorizzata viene utilizzata per determinare se esistono autorizzazioni sufficienti per eseguire tale azione. Per garantire che le azioni correlate all'infrastruttura nel tuo cluster possano essere eseguite correttamente, assegna ai tuoi utenti amministratore {{site.data.keyword.containerlong_notm}} la politica di accesso all'infrastruttura **Super utente**. Per ulteriori informazioni, vedi [Gestione dell'accesso utente](cs_users.html#infra_access).

Se ritieni di dover aggiornare la chiave API memorizzata per una regione, puoi farlo eseguendo il comando [ibmcloud ks api-key-reset](#cs_api_key_reset). Questo comando richiede la politica di accesso come amministratore {{site.data.keyword.containerlong_notm}} e memorizza la chiave API dell'utente che esegue questo comando nell'account.

**Suggerimento:** la chiave API restituita in questo comando potrebbe non essere utilizzata se le credenziali dell'infrastruttura IBM Cloud (SoftLayer) sono state impostate manualmente utilizzando il comando [ibmcloud ks credentials-set](#cs_credentials_set).

<strong>Opzioni comando</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Il nome o l'ID del cluster. Questo valore è obbligatorio.</dd>

   <dt><code>--json</code></dt>
   <dd>Stampa l'output del comando in formato JSON. Questo valore è facoltativo.</dd>

   <dt><code>-s</code></dt>
   <dd>Non visualizza il messaggio dei promemoria di aggiornamento o del giorno. Questo valore è facoltativo.</dd>

   </dl>

**Esempio**:

  ```
  ibmcloud ks api-key-info --cluster my_cluster
  ```
  {: pre}


### ibmcloud ks api-key-reset [-s]
{: #cs_api_key_reset}

Sostituisci la chiave API IAM corrente in una regione {{site.data.keyword.containerlong_notm}}.

Questo comando richiede la politica di accesso come amministratore {{site.data.keyword.containerlong_notm}} e memorizza la chiave API dell'utente che esegue questo comando nell'account. La chiave API IAM è necessaria per ordinare l'infrastruttura dal portfolio dell'infrastruttura IBM Cloud (SoftLayer). Una volta memorizzata, la chiave API viene utilizzata per ogni azione in una regione che richiede autorizzazioni di infrastruttura indipendenti dall'utente che esegue questo comando. Per ulteriori informazioni su come funzionano le chiavi API IAM, vedi il [comando `ibmcloud ks api-key-info`](#cs_api_key_info).

**Importante:** prima di utilizzare questo comando, assicurati che l'utente che lo esegue abbia le [autorizzazioni necessarie per {{site.data.keyword.containerlong_notm}} e l'infrastruttura IBM Cloud (SoftLayer)](cs_users.html#users).

<strong>Opzioni comando</strong>:

   <dl>
   <dt><code>-s</code></dt>
   <dd>Non visualizza il messaggio dei promemoria di aggiornamento o del giorno. Questo valore è facoltativo.</dd>
   </dl>


**Esempio**:

  ```
  ibmcloud ks api-key-reset
  ```
  {: pre}


### ibmcloud ks apiserver-config-get
{: #cs_apiserver_config_get}

Ottieni le informazioni su un'opzione per una configurazione del server API Kubernetes del cluster. Questo comando deve essere combinato con uno dei seguenti comandi secondari per l'opzione di configurazione per cui vuoi le informazioni.

#### ibmcloud ks apiserver-config-get audit-webhook --cluster CLUSTER
{: #cs_apiserver_api_webhook_get}

Visualizza l'URL del servizio di registrazione remoto a cui stai inviando i log di controllo del server API. L'URL è stato specificato quando hai creato il backend webhook per la configurazione del server API.

<strong>Opzioni comando</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Il nome o l'ID del cluster. Questo valore è obbligatorio.</dd>
   </dl>

**Esempio**:

  ```
  ibmcloud ks apiserver-config-get audit-webhook --cluster my_cluster
  ```
  {: pre}

### ibmcloud ks apiserver-config-set
{: #cs_apiserver_config_set}

Imposta un'opzione per una configurazione del server API Kubernetes del cluster. Questo comando deve essere combinato con uno dei seguenti comandi secondari per l'opzione di configurazione che vuoi impostare.

#### ibmcloud ks apiserver-config-set audit-webhook --cluster CLUSTER [--remoteServer SERVER_URL_OR_IP][--caCert CA_CERT_PATH] [--clientCert CLIENT_CERT_PATH][--clientKey CLIENT_KEY_PATH]
{: #cs_apiserver_api_webhook_set}

Imposta il backend webhook per la configurazione del server API. Il backend webhook inoltra i log di controllo del server API a un server remoto. Una configurazione webhook viene creata in base alle informazioni che fornisci negli indicatori di questo comando. Se non fornisci alcuna informazione negli indicatori, viene utilizzata una configurazione webhook predefinita.

<strong>Opzioni comando</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Il nome o l'ID del cluster. Questo valore è obbligatorio.</dd>

   <dt><code>--remoteServer <em>SERVER_URL</em></code></dt>
   <dd>L'URL o l'indirizzo IP del servizio di registrazione remoto a cui vuoi inviare i log di controllo. Se fornisci un URL del server non sicuro, vengono ignorati tutti i certificati. Questo valore è facoltativo.</dd>

   <dt><code>--caCert <em>CA_CERT_PATH</em></code></dt>
   <dd>Il percorso del file di un certificato CA utilizzato per verificare il servizio di registrazione remoto. Questo valore è facoltativo.</dd>

   <dt><code>--clientCert <em>CLIENT_CERT_PATH</em></code></dt>
   <dd>Il percorso del file di un certificato client utilizzato per l'autenticazione con il servizio di registrazione remoto. Questo valore è facoltativo.</dd>

   <dt><code>--clientKey <em> CLIENT_KEY_PATH</em></code></dt>
   <dd>Il percorso del file della chiave client corrispondente utilizzata per il collegamento al servizio di registrazione remoto. Questo valore è facoltativo.</dd>
   </dl>

**Esempio**:

  ```
  ibmcloud ks apiserver-config-set audit-webhook --cluster my_cluster --remoteServer https://audit.example.com/audit --caCert /mnt/etc/kubernetes/apiserver-audit/ca.pem --clientCert /mnt/etc/kubernetes/apiserver-audit/cert.pem --clientKey /mnt/etc/kubernetes/apiserver-audit/key.pem
  ```
  {: pre}


### ibmcloud ks apiserver-config-unset
{: #cs_apiserver_config_unset}

Disabilita un'opzione per una configurazione del server API Kubernetes del cluster. Questo comando deve essere combinato con uno dei seguenti comandi secondari per l'opzione di configurazione che vuoi disabilitare.

#### ibmcloud ks apiserver-config-unset audit-webhook --cluster CLUSTER
{: #cs_apiserver_api_webhook_unset}

Disabilita la configurazione backend webhook per il server API del cluster. La disabilitazione del backend webhook arresta l'inoltro dei log di controllo del server API a un server remoto.

<strong>Opzioni comando</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Il nome o l'ID del cluster. Questo valore è obbligatorio.</dd>
   </dl>

**Esempio**:

  ```
  ibmcloud ks apiserver-config-unset audit-webhook --cluster my_cluster
  ```
  {: pre}

### ibmcloud ks apiserver-refresh --cluster CLUSTER [-s]
{: #cs_apiserver_refresh}

Riavvia il master Kubernetes nel cluster per applicare le modifiche alla configurazione del server API.

<strong>Opzioni comando</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Il nome o l'ID del cluster. Questo valore è obbligatorio.</dd>

   <dt><code>-s</code></dt>
   <dd>Non visualizza il messaggio dei promemoria di aggiornamento o del giorno. Questo valore è facoltativo.</dd>

   </dl>

**Esempio**:

  ```
  ibmcloud ks apiserver-refresh --cluster my_cluster
  ```
  {: pre}


<br />


## Comandi utilizzo plugin CLI
{: #cli_plug-in_commands}

### ibmcloud ks help
{: #cs_help}

Visualizzare un elenco di comandi e parametri supportati.

<strong>Opzioni comando</strong>:

   Nessuno

**Esempio**:

  ```
  ibmcloud ks help
  ```
  {: pre}


### ibmcloud ks init [--host HOST][--insecure] [-p][-u] [-s]
{: #cs_init}

Inizializza il plugin {{site.data.keyword.containerlong_notm}} o specificare la regione in cui desideri creare o accedere ai cluster Kubernetes.

<strong>Opzioni comando</strong>:

   <dl>
   <dt><code>--host <em>HOST</em></code></dt>
   <dd>L'endpoint API {{site.data.keyword.containerlong_notm}} da utilizzare.  Questo valore è facoltativo. [Visualizza i valori dell'endpoint API disponibili.](cs_regions.html#container_regions)</dd>

   <dt><code>--insecure</code></dt>
   <dd>Consente una connessione HTTP non sicura.</dd>

   <dt><code>-p</code></dt>
   <dd>La tua password IBM Cloud.</dd>

   <dt><code>-u</code></dt>
   <dd>Il tuo nome utente IBM Cloud.</dd>

   <dt><code>-s</code></dt>
   <dd>Non visualizza il messaggio dei promemoria di aggiornamento o del giorno. Questo valore è facoltativo.</dd>

   </dl>

**Esempio**:


```
ibmcloud ks init --host https://uk-south.containers.bluemix.net
```
{: pre}


### ibmcloud ks messages
{: #cs_messages}

Visualizza i messaggi correnti dell'utente ID IBM.

**Esempio**:

```
ibmcloud ks messages
```
{: pre}


<br />


## Comandi cluster: gestione
{: #cluster_mgmt_commands}


### ibmcloud ks cluster-config --cluster CLUSTER [--admin][--export] [-s][--yaml]
{: #cs_cluster_config}

Dopo aver eseguito l'accesso, scarica i certificati e i dati di configurazione Kubernetes per collegare il tuo cluster ed eseguire i comandi `kubectl`. I file vengono scaricati in `user_home_directory/.bluemix/plugins/container-service/clusters/<cluster_name>`.

**Opzioni comando**:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Il nome o l'ID del cluster. Questo valore è obbligatorio.</dd>

   <dt><code>--admin</code></dt>
   <dd>Scarica i certificati TLS e i file di autorizzazione per il ruolo Super utente. Puoi utilizzare i certificati per automatizzare le attività senza doverti riautenticare. I file vengono scaricati in `<user_home_directory>/.bluemix/plugins/container-service/clusters/<cluster_name>-admin`. Questo valore è facoltativo.</dd>

   <dt><code>--export</code></dt>
   <dd>Scarica i certificati e i dati di configurazione Kubernetes senza un messaggio diverso dal comando export. Poiché non viene visualizzato alcun messaggio, puoi utilizzare questo indicatore quando crei gli script automatizzati. Questo valore è facoltativo.</dd>

  <dt><code>-s</code></dt>
  <dd>Non visualizza il messaggio dei promemoria di aggiornamento o del giorno. Questo valore è facoltativo.</dd>

  <dt><code>--yaml</code></dt>
  <dd>Stampa l'output del comando in formato YAML. Questo valore è facoltativo.</dd>

   </dl>

**Esempio**:

```
ibmcloud ks cluster-config --cluster my_cluster
```
{: pre}


### ibmcloud ks cluster-create [--file FILE_LOCATION][--hardware HARDWARE] --zone ZONE --machine-type MACHINE_TYPE --name NAME [--kube-version MAJOR.MINOR.PATCH][--no-subnet] [--private-vlan PRIVATE_VLAN][--public-vlan PUBLIC_VLAN] [--workers WORKER][--disable-disk-encrypt] [--trusted][-s]
{: #cs_cluster_create}

Crea un cluster nella tua organizzazione. Per i cluster gratuiti, specifica il nome del cluster; tutto il resto è impostato su un valore predefinito. Un cluster gratuito viene cancellato automaticamente dopo 30 giorni. Puoi avere un solo cluster gratuito alla volta. Per sfruttare tutte le funzionalità di Kubernetes, crea un cluster standard.

<strong>Opzioni comando</strong>

<dl>
<dt><code>--file <em>FILE_LOCATION</em></code></dt>

<dd>Il percorso del file YAML per creare il tuo cluster standard. Invece di definire le caratteristiche del cluster utilizzando le opzioni fornite in questo comando, puoi utilizzare un file YAML.  Questo valore è facoltativo per i cluster standard e non è disponibile per i cluster gratuiti.

<p><strong>Nota:</strong> se fornisci la stessa opzione nel comando come parametro nel file YAML, il valore nel comando ha la precedenza rispetto al valore nel YAML. Ad esempio, definisci un'ubicazione nel tuo file YAML e utilizzi l'opzione <code>--zone</code> nel comando, il valore che hai immesso nell'opzione del comando sovrascrive il valore nel file YAML.

<pre class="codeblock">
<code>name: <em>&lt;cluster_name&gt;</em>
zone: <em>&lt;zone&gt;</em>
no-subnet: <em>&lt;no-subnet&gt;</em>
machine-type: <em>&lt;machine_type&gt;</em>
private-vlan: <em>&lt;private_VLAN&gt;</em>
public-vlan: <em>&lt;public_VLAN&gt;</em>
hardware: <em>&lt;shared_or_dedicated&gt;</em>
workerNum: <em>&lt;number_workers&gt;</em>
kube-version: <em>&lt;kube-version&gt;</em>
diskEncryption: <em>false</em>
trusted: <em>true</em>
</code></pre>


<table>
    <caption>Descrizione dei componenti del file YAML</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code><em>name</em></code></td>
    <td>Sostituisci <code><em>&lt;cluster_name&gt;</em></code> con un nome per il tuo cluster. Il nome deve iniziare con una lettera, può contenere lettere, numeri e un trattino (-) e non può contenere più di 35 caratteri. Il nome cluster e la regione in cui viene distribuito il cluster formano il nome dominio completo per il dominio secondario Ingress. Per garantire che il dominio secondario Ingress sia univoco all'interno di una regione, è possibile che il nome cluster venga troncato e vi venga aggiunto un valore casuale all'interno del nome dominio Ingress.
</td>
    </tr>
    <tr>
    <td><code><em>zone</em></code></td>
    <td>Sostituisci <code><em>&lt;zone&gt;</em></code> con la zona in cui vuoi creare il tuo cluster. Le zone disponibili dipendono dalla regione a cui hai eseguito l'accesso. Per elencare le zone disponibili, esegui <code>ibmcloud ks zones</code>. </td>
     </tr>
     <tr>
     <td><code><em>no-subnet</em></code></td>
     <td>Per impostazione predefinita, vengono create una sottorete portatile pubblica e una privata sulla VLAN associata al cluster. Sostituisci <code><em>&lt;no-subnet&gt;</em></code> con <code><em>true</em></code> per evitare di creare sottoreti con il cluster. Puoi [creare](#cs_cluster_subnet_create) o [aggiungere](#cs_cluster_subnet_add) le sottoreti a un cluster in seguito.</td>
      </tr>
     <tr>
     <td><code><em>machine-type</em></code></td>
     <td>Sostituisci <code><em>&lt;machine_type&gt;</em></code> con il tipo di macchina in cui vuoi distribuire i tuoi nodi di lavoro. Puoi distribuire i tuoi nodi di lavoro come macchine virtuali su hardware condiviso o dedicato o come macchine fisiche su bare metal. I tipi di macchine fisiche e virtuali disponibili variano in base alla zona in cui distribuisci il cluster. Per ulteriori informazioni, consulta la documentazione per il [comando](cs_cli_reference.html#cs_machine_types) `ibmcloud ks machine-type`.</td>
     </tr>
     <tr>
     <td><code><em>private-vlan</em></code></td>
     <td>Sostituisci <code><em>&lt;private_VLAN&gt;</em></code> con l'ID della VLAN privata che vuoi utilizzare per i tuoi nodi di lavoro. Per elencare le VLAN disponibili, esegui <code>ibmcloud ks vlans <em>&lt;zone&gt;</em></code> e ricerca i router VLAN che iniziano con <code>bcr</code> (router di back-end).</td>
     </tr>
     <tr>
     <td><code><em>public-vlan</em></code></td>
     <td>Sostituisci <code><em>&lt;public_VLAN&gt;</em></code> con l'ID della VLAN pubblica che vuoi utilizzare per i tuoi nodi di lavoro. Per elencare le VLAN disponibili, esegui <code>ibmcloud ks vlans <em>&lt;zone&gt;</em></code> e ricerca i router VLAN che iniziano con <code>fcr</code> (router di front-end).</td>
     </tr>
     <tr>
     <td><code><em>hardware</em></code></td>
     <td>Per i tipi di macchina virtuale: il livello di isolamento hardware per il tuo nodo di lavoro. Utilizza dedicato se vuoi avere risorse fisiche dedicate disponibili solo per te o condiviso per consentire la condivisione delle risorse fisiche con altri clienti IBM. L'impostazione predefinita è
<code>condiviso</code>.</td>
     </tr>
     <tr>
     <td><code><em>workerNum</em></code></td>
     <td>Sostituisci <code><em>&lt;number_workers&gt;</em></code> con il numero di nodi di lavoro che vuoi distribuire.</td>
     </tr>
     <tr>
      <td><code><em>kube-version</em></code></td>
      <td>La versione di Kubernetes per il nodo master del cluster. Questo valore è facoltativo. Quando la versione non viene specificata, il cluster viene creato con l'impostazione predefinita delle versioni di Kubernetes supportate. Per visualizzare le versioni disponibili, esegui <code>ibmcloud ks kube-versions</code>.
</td></tr>
      <tr>
      <td><code>diskEncryption: <em>false</em></code></td>
      <td>Codifica del disco della funzione dei nodi di lavoro predefinita; [ulteriori informazioni](cs_secure.html#encrypted_disk). Per disabilitare la codifica, includi questa opzione e imposta il valore su <code>false</code>.</td></tr>
      <tr>
      <td><code>trusted: <em>true</em></code></td>
      <td>**Solo bare metal**: abilita [Trusted Compute](cs_secure.html#trusted_compute) per verificare i tentativi di intrusione nei tuoi nodi di lavoro bare metal. Se non abiliti l'attendibilità durante la creazione del cluster ma vuoi farlo in seguito, puoi usare il [comando](cs_cli_reference.html#cs_cluster_feature_enable) `ibmcloud ks feature-enable`. Dopo aver abilitato l'attendibilità, non puoi disabilitarla successivamente.</td></tr>
     </tbody></table>
    </p></dd>

<dt><code>--hardware <em>HARDWARE</em></code></dt>
<dd>Il livello di isolamento hardware per il nodo di lavoro. Utilizza dedicato per avere risorse fisiche dedicate disponibili solo per te o condiviso per consentire la condivisione delle risorse fisiche con altri clienti IBM. L'impostazione predefinita è condiviso.  Questo valore è facoltativo per i cluster standard e non è disponibile per i cluster gratuiti.</dd>

<dt><code>--zone <em>ZONE</em></code></dt>
<dd>La zona in cui vuoi creare il cluster. Le zone disponibili dipendono dalla regione {{site.data.keyword.Bluemix_notm}} a cui hai eseguito l'accesso. Per
prestazioni ottimali, seleziona la regione fisicamente più vicina a te.  Questo valore è obbligatorio per i cluster standard ed è facoltativo per i cluster gratuiti.

<p>Controlla le [zone disponibili](cs_regions.html#zones).</p>

<p><strong>Nota:</strong> quando selezioni una zona che si trova al di fuori del tuo paese, tieni presente che potresti aver bisogno di un'autorizzazione legale prima di poter fisicamente archiviare i dati in un paese straniero.</p>
</dd>

<dt><code>--machine-type <em>MACHINE_TYPE</em></code></dt>
<dd>Scegli un tipo di macchina. Puoi distribuire i tuoi nodi di lavoro come macchine virtuali su hardware condiviso o dedicato o come macchine fisiche su bare metal. I tipi di macchine fisiche e virtuali disponibili variano in base alla zona in cui distribuisci il cluster. Per ulteriori informazioni, consulta la documentazione per il [comando](cs_cli_reference.html#cs_machine_types) `ibmcloud ks machine-types`. Questo valore è obbligatorio per i cluster standard e non è disponibile per i cluster gratuiti.</dd>

<dt><code>--name <em>NAME</em></code></dt>
<dd>Il nome del cluster.  Questo valore è obbligatorio. Il nome deve iniziare con una lettera, può contenere lettere, numeri e un trattino (-) e non può contenere più di 35 caratteri. Il nome cluster e la regione in cui viene distribuito il cluster formano il nome dominio completo per il dominio secondario Ingress. Per garantire che il dominio secondario Ingress sia univoco all'interno di una regione, è possibile che il nome cluster venga troncato e vi venga aggiunto un valore casuale all'interno del nome dominio Ingress.
</dd>

<dt><code>--kube-version <em>MAJOR.MINOR.PATCH</em></code></dt>
<dd>La versione di Kubernetes per il nodo master del cluster. Questo valore è facoltativo. Quando la versione non viene specificata, il cluster viene creato con l'impostazione predefinita delle versioni di Kubernetes supportate. Per visualizzare le versioni disponibili, esegui <code>ibmcloud ks kube-versions</code>.
</dd>

<dt><code>--no-subnet</code></dt>
<dd>Per impostazione predefinita, vengono create una sottorete portatile pubblica e una privata sulla VLAN associata al cluster. Includi l'indicatore <code>--no-subnet</code> per evitare di creare sottoreti con il cluster. Puoi [creare](#cs_cluster_subnet_create) o [aggiungere](#cs_cluster_subnet_add) le sottoreti a un cluster in seguito.</dd>

<dt><code>--private-vlan <em>PRIVATE_VLAN</em></code></dt>
<dd>

<ul>
<li>Questo parametro non è disponibile per i cluster gratuiti.</li>
<li>Se si tratta del primo cluster standard che crei in questa zona, non includere questo indicatore. Alla creazione dei cluster, viene creata per te una VLAN privata.</li>
<li>Se hai creato prima un cluster standard in questa zona o hai creato una VLAN privata nell'infrastruttura IBM Cloud (SoftLayer), devi specificare tale VLAN privata.

<p><strong>Nota:</strong> i router della VLAN privata iniziano sempre con <code>bcr</code> (router back-end) e i router della VLAN pubblica iniziano sempre con <code>fcr</code> (router front-end). Quando crei un cluster e specifichi le VLAN private e pubbliche, la combinazione di numero e lettera dopo tali prefissi deve corrispondere.</p></li>
</ul>

<p>Per scoprire se già hai una VLAN privata per una specifica zona o per trovare il nome di una VLAN privata esistente, esegui <code>ibmcloud ks vlans <em>&lt;zone&gt;</em></code>.</p></dd>

<dt><code>--public-vlan <em>PUBLIC_VLAN</em></code></dt>
<dd>
<ul>
<li>Questo parametro non è disponibile per i cluster gratuiti.</li>
<li>Se si tratta del primo cluster standard che crei in questa zona, non utilizzare questo indicatore. Alla creazione
del cluster, viene creata per te una VLAN pubblica.</li>
<li>Se hai creato prima un cluster standard in questa zona o hai creato una VLAN pubblica nell'infrastruttura IBM Cloud (SoftLayer), specifica tale VLAN pubblica. Se vuoi collegare i tuoi nodi di lavoro solo a una VLAN privata, non specificare questa opzione.

<p><strong>Nota:</strong> i router della VLAN privata iniziano sempre con <code>bcr</code> (router back-end) e i router della VLAN pubblica iniziano sempre con <code>fcr</code> (router front-end). Quando crei un cluster e specifichi le VLAN private e pubbliche, la combinazione di numero e lettera dopo tali prefissi deve corrispondere.</p></li>
</ul>

<p>Per scoprire se già hai una VLAN pubblica per una specifica zona o per trovare il nome di una VLAN pubblica esistente, esegui <code>ibmcloud ks vlans <em>&lt;zone&gt;</em></code>.</p></dd>

<dt><code>--private-only </code></dt>
  <dd>Utilizza questa opzione per impedire la creazione di una VLAN pubblica. Obbligatoria solo quando specifichi l'indicatore `--private-vlan` e non includi l'indicatore `--public-vlan`.  **Nota**: se vuoi un cluster solamente privato, devi configurare un'applicazione gateway per la connettività di rete. Per ulteriori informazioni, vedi [Pianificazione di una rete esterna privata per la configurazione di solo una VLAN privata](cs_network_planning.html#private_vlan).</dd>

<dt><code>--workers WORKER</code></dt>
<dd>Il numero di nodi di lavoro che vuoi distribuire nel tuo cluster. Se non specifici
questa opzione, viene creato un cluster con 1 nodo di lavoro. Questo valore è facoltativo per i cluster standard e non è disponibile per i cluster gratuiti.

<p><strong>Nota:</strong> a ogni nodo di lavoro viene assegnato
un ID e nome dominio univoco che non deve essere modificato manualmente dopo la creazione del
cluster. La modifica dell'ID o del nome dominio impedisce al master Kubernetes di gestire il tuo
cluster.</p></dd>

<dt><code>--disable-disk-encrypt</code></dt>
<dd>Codifica del disco della funzione dei nodi di lavoro predefinita; [ulteriori informazioni](cs_secure.html#encrypted_disk). Per disabilitare la codifica, includi questa opzione.</dd>

<dt><code>--trusted</code></dt>
<dd><p>**Solo bare metal**: abilita [Trusted Compute](cs_secure.html#trusted_compute) per verificare i tentativi di intrusione nei tuoi nodi di lavoro bare metal. Se non abiliti l'attendibilità durante la creazione del cluster ma vuoi farlo in seguito, puoi usare il [comando](cs_cli_reference.html#cs_cluster_feature_enable) `ibmcloud ks feature-enable`. Dopo aver abilitato l'attendibilità, non puoi disabilitarla successivamente.</p>
<p>Per verificare se il tipo di macchina bare metal supporta l'attendibilità, controlla il campo `Trustable` nell'output del [comando](#cs_machine_types) `ibmcloud ks machine-types <zone>`. Per verificare che un cluster sia abilitato all'attendibilità, controlla il campo **Trust ready** nell'output del [comando](#cs_cluster_get) `ibmcloud ks cluster-get`. Per verificare che un nodo di lavoro bare metal sia abilitato all'attendibilità, controlla il campo **Trust** nell'output del [comando](#cs_worker_get) `ibmcloud ks worker-get`.</p></dd>

<dt><code>-s</code></dt>
<dd>Non visualizza il messaggio dei promemoria di aggiornamento o del giorno. Questo valore è facoltativo.</dd>
</dl>

**Esempi**:



  **Crea un cluster gratuito**: specifica solo il nome del cluster; tutto il resto è impostato su un valore predefinito. Un cluster gratuito viene cancellato automaticamente dopo 30 giorni. Puoi avere un solo cluster gratuito alla volta. Per sfruttare tutte le funzionalità di Kubernetes, crea un cluster standard.

  ```
  ibmcloud ks cluster-create --name my_cluster
  ```
  {: pre}

  **Crea il tuo primo cluster standard**: il primo cluster standard che viene creato in una zona crea anche una VLAN privata. Pertanto, non includere l'indicatore `--public-vlan`.
  {: #example_cluster_create}

  ```
  ibmcloud ks cluster-create --zone dal10 --private-vlan my_private_VLAN_ID --machine-type b2c.4x16 --name my_cluster --hardware shared --workers 2
  ```
  {: pre}

  **Crea i successivi cluster standard**: se hai già creato un cluster standard in questa zona o hai creato una VLAN pubblica nell'infrastruttura IBM Cloud (SoftLayer), specifica tale VLAN pubblica con l'indicatore `--public-vlan`. Per scoprire se già hai una VLAN pubblica per una specifica zona o per trovare il nome di una VLAN pubblica esistente, esegui `ibmcloud ks vlans <zone>`.

  ```
  ibmcloud ks cluster-create --zone dal10 --public-vlan my_public_VLAN_ID --private-vlan my_private_VLAN_ID --machine-type b2c.4x16 --name my_cluster --hardware shared --workers 2
  ```
  {: pre}

  **Crea un cluster in un ambiente {{site.data.keyword.Bluemix_dedicated_notm}}**:

  ```
  ibmcloud ks cluster-create --machine-type machine-type --workers number --name cluster_name
  ```
  {: pre}

### ibmcloud ks cluster-feature-enable [-f] --cluster CLUSTER [--trusted][-s]
{: #cs_cluster_feature_enable}

Abilita una funzione su un cluster esistente.

<strong>Opzioni comando</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Il nome o l'ID del cluster. Questo valore è obbligatorio.</dd>

   <dt><code>-f</code></dt>
   <dd>Utilizza questa opzione per forzare l'opzione <code>--trusted</code> senza richiedere l'intervento dell'utente. Questo valore è facoltativo.</dd>

   <dt><code><em>--trusted</em></code></dt>
   <dd><p>Includi l'indicatore per abilitare [Trusted Compute](cs_secure.html#trusted_compute) per tutti i nodi di lavoro bare metal supportati che si trovano nel cluster. Dopo aver abilitato l'attendibilità, non puoi disabilitarla successivamente per il cluster.</p>
   <p>Per verificare se il tipo di macchina bare metal supporta l'attendibilità, controlla il campo **Trustable** nell'output del [comando](#cs_machine_types) `ibmcloud ks machine-types <zone>`. Per verificare che un cluster sia abilitato all'attendibilità, controlla il campo **Trust ready** nell'output del [comando](#cs_cluster_get) `ibmcloud ks cluster-get`. Per verificare che un nodo di lavoro bare metal sia abilitato all'attendibilità, controlla il campo **Trust** nell'output del [comando](#cs_worker_get) `ibmcloud ks worker-get`.</p></dd>

  <dt><code>-s</code></dt>
   <dd>Non visualizza il messaggio dei promemoria di aggiornamento o del giorno. Questo valore è facoltativo.</dd>
</dl>

**Comando di esempio**:

  ```
  ibmcloud ks cluster-feature-enable --cluster my_cluster --trusted=true
  ```
  {: pre}

### ibmcloud ks cluster-get --cluster CLUSTER [--json][--showResources] [-s]
{: #cs_cluster_get}

Visualizzare le informazioni su un cluster nella tua organizzazione.

<strong>Opzioni comando</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Il nome o l'ID del cluster. Questo valore è obbligatorio.</dd>

   <dt><code>--json</code></dt>
   <dd>Stampa l'output del comando in formato JSON. Questo valore è facoltativo.</dd>

   <dt><code><em>--showResources</em></code></dt>
   <dd>Mostra più risorse del cluster come componenti aggiuntivi, VLAN, sottoreti e archiviazione.</dd>


  <dt><code>-s</code></dt>
  <dd>Non visualizza il messaggio dei promemoria di aggiornamento o del giorno. Questo valore è facoltativo.</dd>
  </dl>



**Comando di esempio**:

  ```
  ibmcloud ks cluster-get --cluster my_cluster --showResources
  ```
  {: pre}

**Output di esempio**:

  ```
  Name:        my_cluster
  ID:          abc1234567
  State:       normal
  Trust ready: false
  Created:     2018-01-01T17:19:28+0000
  Zone:        dal10
  Master URL:  https://169.xx.xxx.xxx:xxxxx
  Master Location: Dallas
  Ingress subdomain: my_cluster.us-south.containers.appdomain.cloud
  Ingress secret:    my_cluster
  Workers:      3
  Worker Zones: dal10
  Version:      1.11.2
  Owner Email:  name@example.com
  Monitoring dashboard: https://metrics.ng.bluemix.net/app/#/grafana4/dashboard/db/link

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

### ibmcloud ks cluster-rm --cluster CLUSTER [--force-delete-storage][-f] [-s]
{: #cs_cluster_rm}

Rimuovere un cluster dalla tua organizzazione.

<strong>Opzioni comando</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Il nome o l'ID del cluster. Questo valore è obbligatorio.</dd>

   <dt><code>--force-delete-storage</code></dt>
   <dd>Elimina il cluster e l'archiviazione persistente utilizzata dal cluster. **Attenzione**: se includi questo indicatore, non sarà possibile ripristinare i dati memorizzati nel cluster o le sue istanze di archiviazione associate. Questo valore è facoltativo.</dd>

   <dt><code>-f</code></dt>
   <dd>Utilizza questa opzione per forzare la rimozione di un cluster senza richiedere l'intervento dell'utente. Questo valore è facoltativo.</dd>

   <dt><code>-s</code></dt>
   <dd>Non visualizza il messaggio dei promemoria di aggiornamento o del giorno. Questo valore è facoltativo.</dd>

   </dl>

**Esempio**:

  ```
  ibmcloud ks cluster-rm --cluster my_cluster
  ```
  {: pre}


### ibmcloud ks cluster-update [-f] --cluster CLUSTER [--kube-version MAJOR.MINOR.PATCH][--force-update] [-f][-s]
{: #cs_cluster_update}

Aggiorna il master Kubernetes alla versione API predefinita. Durante l'aggiornamento, non è possibile accedere o modificare il cluster. I nodi di lavoro, le applicazioni e le risorse che sono state distribuite dall'utente non vengono modificate e continuano a essere eseguite.

Potresti dover modificare i tuoi file YAML per distribuzioni future. Controlla questa [nota sulla release](cs_versions.html) per i dettagli.

<strong>Opzioni comando</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Il nome o l'ID del cluster. Questo valore è obbligatorio.</dd>

   <dt><code>--kube-version <em>MAJOR.MINOR.PATCH</em></code></dt>
   <dd>La versione Kubernetes del cluster. Se non specifichi una versione, il master Kubernetes viene aggiornato alla versione API predefinita. Per visualizzare le versioni disponibili, esegui [ibmcloud ks kube-versions](#cs_kube_versions). Questo valore è facoltativo.</dd>

   <dt><code>-f</code></dt>
   <dd>Utilizza questa opzione per forzare l'aggiornamento del master senza richiedere l'intervento dell'utente. Questo valore è facoltativo.</dd>

   <dt><code>--force-update</code></dt>
   <dd>Tenta l'aggiornamento anche se la modifica è maggiore di due versioni secondarie. Questo valore è facoltativo.</dd>

   <dt><code>-f</code></dt>
   <dd>Forza l'esecuzione del comando senza richiedere l'intervento dell'utente. Questo valore è facoltativo.</dd>

   <dt><code>-s</code></dt>
   <dd>Non visualizza il messaggio dei promemoria di aggiornamento o del giorno. Questo valore è facoltativo.</dd>
   </dl>

**Esempio**:

  ```
  ibmcloud ks cluster-update --cluster my_cluster
  ```
  {: pre}


### ibmcloud ks clusters [--json][-s]
{: #cs_clusters}

Visualizzare un elenco di cluster nella tua organizzazione.

<strong>Opzioni comando</strong>:

  <dl>
  <dt><code>--json</code></dt>
  <dd>Stampa l'output del comando in formato JSON. Questo valore è facoltativo.</dd>

  <dt><code>-s</code></dt>
  <dd>Non visualizza il messaggio dei promemoria di aggiornamento o del giorno. Questo valore è facoltativo.</dd>
  </dl>

**Esempio**:

  ```
  ibmcloud ks clusters
  ```
  {: pre}


### ibmcloud ks kube-versions [--json][-s]
{: #cs_kube_versions}

Visualizza un elenco di versioni di Kubernetes supportate in {{site.data.keyword.containerlong_notm}}. Aggiorna i tuoi [master cluster](#cs_cluster_update) e [nodi di lavoro](cs_cli_reference.html#cs_worker_update) alla versione predefinita per le funzionalità stabili più recenti.

**Opzioni comando**:

  <dl>
  <dt><code>--json</code></dt>
  <dd>Stampa l'output del comando in formato JSON. Questo valore è facoltativo.</dd>

  <dt><code>-s</code></dt>
  <dd>Non visualizza il messaggio dei promemoria di aggiornamento o del giorno. Questo valore è facoltativo.</dd>
  </dl>

**Esempio**:

  ```
  ibmcloud ks kube-versions
  ```
  {: pre}

<br />



## Comandi cluster: servizi e integrazioni
{: #cluster_services_commands}


### ibmcloud ks cluster-service-bind --cluster CLUSTER --namespace KUBERNETES_NAMESPACE --service SERVICE_INSTANCE_NAME [-s]
{: #cs_cluster_service_bind}

Aggiungi un servizio {{site.data.keyword.Bluemix_notm}} a un cluster. Per visualizzare i servizi {{site.data.keyword.Bluemix_notm}} disponibili dal catalogo {{site.data.keyword.Bluemix_notm}}, esegui `ibmcloud service offerings`. **Nota**: puoi aggiungere solo servizi {{site.data.keyword.Bluemix_notm}} che supportano le chiavi del servizio.

<strong>Opzioni comando</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Il nome o l'ID del cluster. Questo valore è obbligatorio.</dd>

   <dt><code>--namespace <em>KUBERNETES_NAMESPACE</em></code></dt>
   <dd>Il nome dello spazio dei nomi Kubernetes. Questo valore è obbligatorio.</dd>

   <dt><code>--service <em>SERVICE_INSTANCE_NAME</em></code></dt>
   <dd>Il nome dell'istanza del servizio {{site.data.keyword.Bluemix_notm}} di cui vuoi eseguire il bind. Per trovare il nome della tua istanza del servizio, esegui <code>ibmcloud service list</code>. Se nell'account più di un'istanza ha lo stesso nome, utilizza l'ID dell'istanza del servizio anziché il nome. Per trovare l'ID, esegui <code>ibmcloud service show <service instance name> --guid</code>. Uno di questi valori è obbligatorio.</dd>

   <dt><code>-s</code></dt>
   <dd>Non visualizza il messaggio dei promemoria di aggiornamento o del giorno. Questo valore è facoltativo.</dd>

   </dl>

**Esempio**:

  ```
  ibmcloud ks cluster-service-bind --cluster my_cluster --namespace my_namespace --service my_service_instance
  ```
  {: pre}


### ibmcloud ks cluster-service-unbind --cluster CLUSTER --namespace KUBERNETES_NAMESPACE --service SERVICE_INSTANCE_GUID [-s]
{: #cs_cluster_service_unbind}

Rimuovi un servizio {{site.data.keyword.Bluemix_notm}} da un cluster.

**Nota:** quando rimuovi un servizio {{site.data.keyword.Bluemix_notm}}, le credenziali del servizio vengono rimosse dal cluster. Se un pod sta ancora utilizzando il servizio,
si verificherà un errore perché non è possibile trovare le credenziali del servizio.

<strong>Opzioni comando</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Il nome o l'ID del cluster. Questo valore è obbligatorio.</dd>

   <dt><code>--namespace <em>KUBERNETES_NAMESPACE</em></code></dt>
   <dd>Il nome dello spazio dei nomi Kubernetes. Questo valore è obbligatorio.</dd>

   <dt><code>--service <em>SERVICE_INSTANCE_GUID</em></code></dt>
   <dd>L'ID dell'istanza del servizio {{site.data.keyword.Bluemix_notm}}
che vuoi rimuovere. Per trovare l'ID dell'istanza del servizio, esegui `ibmcloud ks cluster-services <cluster_name_or_ID>`.Questo valore è obbligatorio.</dd>

   <dt><code>-s</code></dt>
   <dd>Non visualizza il messaggio dei promemoria di aggiornamento o del giorno. Questo valore è facoltativo.</dd>

   </dl>

**Esempio**:

  ```
  ibmcloud ks cluster-service-unbind --cluster my_cluster --namespace my_namespace --service 8567221
  ```
  {: pre}


### ibmcloud ks cluster-services --cluster CLUSTER [--namespace KUBERNETES_NAMESPACE][--all-namespaces] [--json][-s]
{: #cs_cluster_services}

Elencare i servizi associati a uno o a tutti gli spazi dei nomi Kubernetes in un cluster. Se non viene specificata
alcuna opzione, vengono visualizzati i servizi per lo spazio dei nomi predefinito.

<strong>Opzioni comando</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Il nome o l'ID del cluster. Questo valore è obbligatorio.</dd>

   <dt><code>--namespace <em>KUBERNETES_NAMESPACE</em></code>, <code>-n
<em>KUBERNETES_NAMESPACE</em></code></dt>
   <dd>Includi i servizi associati a uno specifico spazio dei nomi in un cluster. Questo valore è facoltativo.</dd>

   <dt><code>--all-namespaces</code></dt>
   <dd>Includi i servizi associati a tutti gli spazi dei nomi in un cluster. Questo valore è facoltativo.</dd>

   <dt><code>--json</code></dt>
   <dd>Stampa l'output del comando in formato JSON. Questo valore è facoltativo.</dd>

   <dt><code>-s</code></dt>
   <dd>Non visualizza il messaggio dei promemoria di aggiornamento o del giorno. Questo valore è facoltativo.</dd>
   </dl>

**Esempio**:

  ```
  ibmcloud ks cluster-services --cluster my_cluster --namespace my_namespace
  ```
  {: pre}

### ibmcloud ks va --container CONTAINER_ID [--extended][--vulnerabilities] [--configuration-issues][--json]
{: #cs_va}

Una volta che hai [installato il programma di scansione del contenitore](/docs/services/va/va_index.html#va_install_container_scanner), esamina un report dettagliato della valutazione della vulnerabilità per un contenitore nel tuo cluster.

**Opzioni comando**:

<dl>
<dt><code>--container CONTAINER_ID</code></dt>
<dd><p>L'ID del contenitore. Questo valore è obbligatorio.</p>
<p>Per trovare l'ID del tuo contenitore:<ol><li>[Indirizza la CLI Kubernetes al tuo cluster](cs_cli_install.html#cs_cli_configure).</li><li>Elenca i tuoi pod eseguendo `kubectl get pods`.</li><li>Trova il campo **Container ID** nell'output del comando `kubectl describe pod <pod_name>`. Ad esempio, `Container ID: containerd://1a11a1aa2b2b22223333c44444ccc555667d7dd777888e8ef99f1011121314g15`.</li><li>Rimuovi il prefisso `containerd://` dall'ID prima di utilizzare l'ID contenitore per il comando `ibmcloud ks va`. Ad esempio, `1a11a1aa2b2b22223333c44444ccc555667d7dd777888e8ef99f1011121314g15`.</li></ol></p></dd>

<dt><code>--extended</code></dt>
<dd><p>Estende l'output del comando per mostrare maggiori informazioni di correzione per i pacchetti vulnerabili. Questo valore è facoltativo.</p>
<p>Per impostazione predefinita, i risultati della scansione mostrano l'ID, lo stato della politica, i pacchetti interessati e come risolvere il problema. Con l'indicatore `--extended`, aggiunge le informazioni come il riepilogo, gli avvisi di sicurezza del fornitore e il link all'avviso ufficiale.</p></dd>

<dt><code>--vulnerabilities</code></dt>
<dd>Limita l'output del comando in modo da visualizzare solo le vulnerabilità del pacchetto. Questo valore è facoltativo. Non puoi utilizzare questo indicatore se usi l'indicatore `--configuration-issues`.</dd>

<dt><code>--configuration-issues</code></dt>
<dd>Limita l'output del comando in modo da visualizzare solo i problemi di configurazione. Questo valore è facoltativo. Non puoi utilizzare questo indicatore se usi l'indicatore `--vulnerabilities` flag.</dd>

<dt><code>--json</code></dt>
<dd>Stampa l'output del comando in formato JSON. Questo valore è facoltativo.</dd>
</dl>

**Esempio**:

```
ibmcloud ks va --container 1a11a1aa2b2b22223333c44444ccc555667d7dd777888e8ef99f1011121314g15 --extended --vulnerabilities --json
```
{: pre}


### ibmcloud ks webhook-create --cluster CLUSTER --level LEVEL --type slack --url URL  [-s]
{: #cs_webhook_create}

Registra un webhook.

<strong>Opzioni comando</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Il nome o l'ID del cluster. Questo valore è obbligatorio.</dd>

   <dt><code>--level <em>LEVEL</em></code></dt>
   <dd>Il livello di notifica, come ad esempio <code>Normal</code> o
<code>Warning</code>. <code>Warning</code> è il valore predefinito. Questo valore è facoltativo.</dd>

   <dt><code>--type <em>slack</em></code></dt>
   <dd>Il tipo di webhook. Al momento è supportato slack. Questo valore è obbligatorio.</dd>

   <dt><code>--url <em>URL</em></code></dt>
   <dd>L'URL del webhook. Questo valore è obbligatorio.</dd>

   <dt><code>-s</code></dt>
   <dd>Non visualizza il messaggio dei promemoria di aggiornamento o del giorno. Questo valore è facoltativo.</dd>
   </dl>

**Esempio**:

  ```
  ibmcloud ks webhook-create --cluster my_cluster --level Normal --type slack --url http://github.com/mywebhook
  ```
  {: pre}


<br />


## Comandi cluster: sottoreti
{: #cluster_subnets_commands}

### ibmcloud ks cluster-subnet-add --cluster CLUSTER --subnet-id SUBNET [-s]
{: #cs_cluster_subnet_add}

Puoi aggiungere sottoreti pubbliche o private esistenti dal tuo account dell'infrastruttura IBM Cloud (SoftLayer) al tuo cluster Kubernetes oppure puoi riutilizzare le sottoreti da un cluster eliminato invece di utilizzare le sottoreti di cui viene eseguito automaticamente il provisioning.

**Nota:**
* Gli indirizzi IP pubblici portatili vengono addebitati mensilmente. Se rimuovi gli indirizzi IP pubblici portatili dopo aver eseguito il provisioning del tuo cluster, devi comunque pagare l'addebito mensile anche se li hai utilizzati solo per un breve periodo di tempo.
* Quando rendi disponibile una sottorete a un cluster, gli indirizzi IP di questa sottorete vengono utilizzati per scopi di rete del cluster. Per evitare conflitti di indirizzi IP, assicurati
di utilizzare una sottorete con un solo cluster. Non utilizzare una sottorete per più cluster o per altri
scopi al di fuori di {{site.data.keyword.containerlong_notm}}
contemporaneamente.
* Per consentire le comunicazioni tra i nodi di lavoro che si trovano in diverse sottoreti sulla stessa VLAN, devi [abilitare l'instradamento tra le sottoreti sulla stessa VLAN](cs_subnets.html#subnet-routing).

<strong>Opzioni comando</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Il nome o l'ID del cluster. Questo valore è obbligatorio.</dd>

   <dt><code>--subnet-id <em>SUBNET</em></code></dt>
   <dd>L'ID della sottorete. Questo valore è obbligatorio.</dd>

   <dt><code>-s</code></dt>
   <dd>Non visualizza il messaggio dei promemoria di aggiornamento o del giorno. Questo valore è facoltativo.</dd>

   </dl>

**Esempio**:

  ```
  ibmcloud ks cluster-subnet-add --cluster my_cluster --subnet-id 1643389
  ```
  {: pre}


### ibmcloud ks cluster-subnet-create --cluster CLUSTER --size SIZE --vlan VLAN_ID [-s]
{: #cs_cluster_subnet_create}

Crea una sottorete in un account dell'infrastruttura IBM Cloud (SoftLayer) e la rende disponibile per un cluster specificato in {{site.data.keyword.containerlong_notm}}.

**Nota:**
* Quando rendi disponibile una sottorete a un cluster, gli indirizzi IP di questa sottorete vengono utilizzati per scopi di rete del cluster. Per evitare conflitti di indirizzi IP, assicurati
di utilizzare una sottorete con un solo cluster. Non utilizzare una sottorete per più cluster o per altri
scopi al di fuori di {{site.data.keyword.containerlong_notm}}
contemporaneamente.
* Se hai più VLAN per un cluster, più sottoreti sulla stessa VLAN o un cluster multizona, devi abilitare lo [spanning della VLAN](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) per il tuo account dell'infrastruttura IBM Cloud (SoftLayer) in modo che i tuoi nodi di lavoro possano comunicare tra loro sulla rete privata. Per eseguire questa azione, ti serve l'[autorizzazione dell'infrastruttura](cs_users.html#infra_access) **Rete > Gestisci il VLAN Spanning di rete** oppure puoi richiedere al proprietario dell'account di abilitarlo. Per controllare se lo spanning di VLAN è già abilitato, usa il [comando](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`.Se stai utilizzando {{site.data.keyword.BluDirectLink}}, devi invece utilizzare una [VRF (Virtual Router Function)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf). Per abilitare la VRF, contatta il tuo rappresentante dell'account dell'infrastruttura IBM Cloud (SoftLayer).

<strong>Opzioni comando</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Il nome o l'ID del cluster. Questo valore è obbligatorio. Per elencare i tuoi cluster, utilizza il [comando](#cs_clusters) `ibmcloud ks clusters`.</dd>

   <dt><code>--size <em>SIZE</em></code></dt>
   <dd>Il nome di indirizzi IP della sottorete. Questo valore è obbligatorio. I valori possibili sono 8, 16, 32 o 64.</dd>

   <dd>La VLAN in cui creare la sottorete. Questo valore è obbligatorio. Per elencare le VLAN disponibili, utilizza il [comando](#cs_vlans) `ibmcloud ks vlans <zone>`. Il provisioning della sottorete viene eseguito nella stessa zona in cui si trova la VLAN.</dd>

   <dt><code>-s</code></dt>
   <dd>Non visualizza il messaggio dei promemoria di aggiornamento o del giorno. Questo valore è facoltativo.</dd>

   </dl>

**Esempio**:

  ```
  ibmcloud ks cluster-subnet-create --cluster my_cluster --size 8 --vlan 1764905
  ```
  {: pre}


### ibmcloud ks cluster-user-subnet-add --cluster CLUSTER --subnet-cidr SUBNET_CIDR --private-vlan PRIVATE_VLAN
{: #cs_cluster_user_subnet_add}

Porta la tua sottorete privata nei cluster {{site.data.keyword.containerlong_notm}}.

Questa sottorete privata non è una di quelle fornite dall'infrastruttura IBM Cloud (SoftLayer). In quanto tale, devi configurare l'instradamento del traffico di rete in entrata e in uscita per la sottorete. Per aggiungere una sottorete dell'infrastruttura IBM Cloud (SoftLayer), utilizza il [comando](#cs_cluster_subnet_add) `ibmcloud ks cluster-subnet-add`.

**Nota**:
* Quando aggiungi una sottorete utente privata a un cluster, gli indirizzi IP di questa sottorete vengono utilizzati per Load Balancers privati nel cluster. Per evitare conflitti di indirizzi IP, assicurati
di utilizzare una sottorete con un solo cluster. Non utilizzare una sottorete per più cluster o per altri
scopi al di fuori di {{site.data.keyword.containerlong_notm}}
contemporaneamente.
* Se hai più VLAN per un cluster, più sottoreti sulla stessa VLAN o un cluster multizona, devi abilitare lo [spanning della VLAN](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) per il tuo account dell'infrastruttura IBM Cloud (SoftLayer) in modo che i tuoi nodi di lavoro possano comunicare tra loro sulla rete privata. Per eseguire questa azione, ti serve l'[autorizzazione dell'infrastruttura](cs_users.html#infra_access) **Rete > Gestisci il VLAN Spanning di rete** oppure puoi richiedere al proprietario dell'account di abilitarlo. Per controllare se lo spanning di VLAN è già abilitato, usa il [comando](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`.Se stai utilizzando {{site.data.keyword.BluDirectLink}}, devi invece utilizzare una [VRF (Virtual Router Function)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf). Per abilitare la VRF, contatta il tuo rappresentante dell'account dell'infrastruttura IBM Cloud (SoftLayer).

<strong>Opzioni comando</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Il nome o l'ID del cluster. Questo valore è obbligatorio.</dd>

   <dt><code>--subnet-cidr <em>SUBNET_CIDR</em></code></dt>
   <dd>La sottorete CIDR (Classless InterDomain Routing). Questo valore è obbligatorio e non deve essere in conflitto con una delle sottoreti utilizzate dall'infrastruttura IBM Cloud (SoftLayer).

   L'intervallo di prefissi supportati è compreso tra `/30` (1 indirizzo IP) e `/24` (253 indirizzi IP). Se configuri il CIDR con una lunghezza di prefisso e successivamente devi modificarla, aggiungi prima il nuovo CIDR e quindi [rimuovi il vecchio CIDR](#cs_cluster_user_subnet_rm).</dd>

   <dt><code>--private-vlan <em>PRIVATE_VLAN</em></code></dt>
   <dd>L'ID della VLAN privata. Questo valore è obbligatorio. Deve corrispondere all'ID della VLAN privata di uno o più nodi di lavoro nel cluster.</dd>
   </dl>

**Esempio**:

  ```
  ibmcloud ks cluster-user-subnet-add --cluster my_cluster --subnet-cidr 169.xx.xxx.xxx/29 --private-vlan 1502175
  ```
  {: pre}


### ibmcloud ks cluster-user-subnet-rm --cluster CLUSTER --subnet-cidr SUBNET_CIDR --private-vlan PRIVATE_VLAN
{: #cs_cluster_user_subnet_rm}

Rimuovi la tua propria sottorete privata da un cluster specificato.

**Nota:** ogni servizio distribuito a un indirizzo IP dalla tua propria sottorete privata rimane attivo dopo la rimozione della sottorete.

<strong>Opzioni comando</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Il nome o l'ID del cluster. Questo valore è obbligatorio.</dd>

   <dt><code>--subnet-cidr <em>SUBNET_CIDR</em></code></dt>
   <dd>La sottorete CIDR (Classless InterDomain Routing). Questo valore è obbligatorio e deve corrispondere al CIDR configurato dal [comando](#cs_cluster_user_subnet_add) `ibmcloud ks cluster-user-subnet-add`.</dd>

   <dt><code>--private-vlan <em>PRIVATE_VLAN</em></code></dt>
   <dd>L'ID della VLAN privata. Questo valore è obbligatorio e deve corrispondere all'ID della VLAN configurato dal [comando](#cs_cluster_user_subnet_add) `ibmcloud ks cluster-user-subnet-add`.</dd>
   </dl>

**Esempio**:

  ```
  ibmcloud ks cluster-user-subnet-rm --cluster my_cluster --subnet-cidr 169.xx.xxx.xxx/29 --private-vlan 1502175
  ```
  {: pre}

### ibmcloud ks subnets [--json][-s]
{: #cs_subnets}

Visualizza un elenco di sottoreti disponibili in un account dell'infrastruttura IBM Cloud (SoftLayer).

<strong>Opzioni comando</strong>:

  <dl>
  <dt><code>--json</code></dt>
  <dd>Stampa l'output del comando in formato JSON. Questo valore è facoltativo.</dd>

  <dt><code>-s</code></dt>
  <dd>Non visualizza il messaggio dei promemoria di aggiornamento o del giorno. Questo valore è facoltativo.</dd>
  </dl>

**Esempio**:

  ```
  ibmcloud ks subnets
  ```
  {: pre}


<br />


## Comandi del programma di bilanciamento del carico dell'applicazione (ALB) Ingress
{: #alb_commands}

### ibmcloud ks alb-cert-deploy [--update] --cluster CLUSTER --secret-name SECRET_NAME --cert-crn CERTIFICATE_CRN [--update][-s]
{: #cs_alb_cert_deploy}

Distribuisci o aggiorna un certificato dalla tua istanza {{site.data.keyword.cloudcerts_long_notm}} all'ALB in un cluster.

**Nota:**
* Solo un utente con il ruolo di accesso di amministratore può eseguire questo comando.
* Puoi soltanto aggiornare i certificati importati dalla stessa istanza {{site.data.keyword.cloudcerts_long_notm}}.

<strong>Opzioni comando</strong>

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Il nome o l'ID del cluster. Questo valore è obbligatorio.</dd>

   <dt><code>--update</code></dt>
   <dd>Aggiorna il certificato per un segreto dell'ALB in un cluster. Questo valore è facoltativo.</dd>

   <dt><code>--secret-name <em>SECRET_NAME</em></code></dt>
   <dd>Il nome del segreto ALB. Questo valore è obbligatorio.</dd>

   <dt><code>--cert-crn <em>CERTIFICATE_CRN</em></code></dt>
   <dd>Il CRN del certificato. Questo valore è obbligatorio.</dd>

   <dt><code>-s</code></dt>
   <dd>Non visualizza il messaggio dei promemoria di aggiornamento o del giorno. Questo valore è facoltativo.</dd>
   </dl>

**Esempi**:

Esempio per distribuire un segreto dell'ALB:

   ```
   ibmcloud ks alb-cert-deploy --secret-name my_alb_secret --cluster my_cluster --cert-crn crn:v1:staging:public:cloudcerts:us-south:a/06580c923e40314421d3b6cb40c01c68:0db4351b-0ee1-479d-af37-56a4da9ef30f:certificate:4bc35b7e0badb304e60aef00947ae7ff
   ```
   {: pre}

Esempio per aggiornare un segreto dell'ALB esistente:

 ```
 ibmcloud ks alb-cert-deploy --update --secret-name my_alb_secret --cluster my_cluster --cert-crn crn:v1:staging:public:cloudcerts:us-south:a/06580c923e40314421d3b6cb40c01c68:0db4351b-0ee1-479d-af37-56a4da9ef30f:certificate:7e21fde8ee84a96d29240327daee3eb2
 ```
 {: pre}


### ibmcloud ks alb-cert-get --cluster CLUSTER [--secret-name SECRET_NAME][--cert-crn CERTIFICATE_CRN] [--json][-s]
{: #cs_alb_cert_get}

Visualizza le informazioni su un segreto dell'ALB in un cluster.

**Nota:** solo un utente con il ruolo di accesso di amministratore può eseguire questo comando.

<strong>Opzioni comando</strong>

  <dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
  <dd>Il nome o l'ID del cluster. Questo valore è obbligatorio.</dd>

  <dt><code>--secret-name <em>SECRET_NAME</em></code></dt>
  <dd>Il nome del segreto ALB. Questo valore è obbligatorio per ottenere le informazioni su un segreto specifico dell'ALB nel cluster.</dd>

  <dt><code>--cert-crn <em>CERTIFICATE_CRN</em></code></dt>
  <dd>Il CRN del certificato. Questo valore è obbligatorio per ottenere le informazioni su tutti i segreti dell'ALB che corrispondono a un CRN del certificato specifico nel cluster.</dd>

  <dt><code>--json</code></dt>
  <dd>Stampa l'output del comando in formato JSON. Questo valore è facoltativo.</dd>

  <dt><code>-s</code></dt>
  <dd>Non visualizza il messaggio dei promemoria di aggiornamento o del giorno. Questo valore è facoltativo.</dd>
  </dl>

**Esempi**:

 Esempio per recuperare le informazioni su un segreto dell'ALB:

 ```
 ibmcloud ks alb-cert-get --cluster my_cluster --secret-name my_alb_secret
 ```
 {: pre}

 Esempio per recuperare le informazioni su tutti i segreti dell'ALB che corrispondono a un CRN del certificato specificato:

 ```
 ibmcloud ks alb-cert-get --cluster my_cluster --cert-crn  crn:v1:staging:public:cloudcerts:us-south:a/06580c923e40314421d3b6cb40c01c68:0db4351b-0ee1-479d-af37-56a4da9ef30f:certificate:4bc35b7e0badb304e60aef00947ae7ff
 ```
 {: pre}


### ibmcloud ks alb-cert-rm --cluster CLUSTER [--secret-name SECRET_NAME][--cert-crn CERTIFICATE_CRN] [-s]
{: #cs_alb_cert_rm}

Rimuovi un segreto dell'ALB in un cluster.

**Nota:** solo un utente con il ruolo di accesso di amministratore può eseguire questo comando.

<strong>Opzioni comando</strong>

  <dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
  <dd>Il nome o l'ID del cluster. Questo valore è obbligatorio.</dd>

  <dt><code>--secret-name <em>SECRET_NAME</em></code></dt>
  <dd>Il nome del segreto ALB. Questo valore è obbligatorio per rimuovere un segreto specifico dell'ALB nel cluster.</dd>

  <dt><code>--cert-crn <em>CERTIFICATE_CRN</em></code></dt>
  <dd>Il CRN del certificato. Questo valore è obbligatorio per rimuovere tutti i segreti dell'ALB che corrispondono a un CRN del certificato specifico nel cluster.</dd>

  <dt><code>-s</code></dt>
  <dd>Non visualizza il messaggio dei promemoria di aggiornamento o del giorno. Questo valore è facoltativo.</dd>

  </dl>

**Esempi**:

 Esempio per rimuovere un segreto dell'ALB:

 ```
 ibmcloud ks alb-cert-rm --cluster my_cluster --secret-name my_alb_secret
 ```
 {: pre}

 Esempio per rimuovere tutti i segreti dell'ALB che corrispondono a un CRN del certificato specificato:

 ```
 ibmcloud ks alb-cert-rm --cluster my_cluster --cert-crn crn:v1:staging:public:cloudcerts:us-south:a/06580c923e40314421d3b6cb40c01c68:0db4351b-0ee1-479d-af37-56a4da9ef30f:certificate:4bc35b7e0badb304e60aef00947ae7ff
 ```
 {: pre}


### ibmcloud ks alb-certs --cluster CLUSTER [--json][-s]
{: #cs_alb_certs}

Visualizza un elenco di segreti dell'ALB in un cluster.

**Nota:** solo gli utenti con il ruolo di accesso di amministratore possono eseguire questo comando.

<strong>Opzioni comando</strong>

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Il nome o l'ID del cluster. Questo valore è obbligatorio.</dd>
   <dt><code>--json</code></dt>
   <dd>Stampa l'output del comando in formato JSON. Questo valore è facoltativo.</dd>
   <dt><code>-s</code></dt>
   <dd>Non visualizza il messaggio dei promemoria di aggiornamento o del giorno. Questo valore è facoltativo.</dd>
   </dl>

**Esempio**:

 ```
 ibmcloud ks alb-certs --cluster my_cluster
 ```
 {: pre}

### ibmcloud ks alb-configure --albID ALB_ID [--enable][--disable] [--user-ip USERIP][-s]
{: #cs_alb_configure}

Abilita o disabilita un ALB nel tuo cluster standard. L'ALB pubblico è abilitato per impostazione predefinita.

**Opzioni comando**:

   <dl>
   <dt><code><em>--albID </em>ALB_ID</code></dt>
   <dd>L'ID per un ALB. Esegui <code>ibmcloud ks albs <em>--cluster </em>CLUSTER</code> per visualizzare gli ID degli ALB in un cluster. Questo valore è obbligatorio.</dd>

   <dt><code>--enable</code></dt>
   <dd>Includi questo indicatore per abilitare un ALB in un cluster.</dd>

   <dt><code>--disable</code></dt>
   <dd>Includi questo indicatore per disabilitare un ALB in un cluster.</dd>

   <dt><code>--user-ip <em>USER_IP</em></code></dt>
   <dd>

   <ul>
    <li>Questo parametro è disponibile solo per abilitare un ALB privato.</li>
    <li>L'ALB privato viene distribuito con un indirizzo IP da una sottorete privata fornita dall'utente. Se non viene fornito alcun indirizzo IP, l'ALB viene distribuito con un indirizzo IP privato dalla sottorete privata portatile che è stata fornita automaticamente quando hai creato il cluster.</li>
   </ul>
   </dd>

   <dt><code>-s</code></dt>
   <dd>Non visualizza il messaggio dei promemoria di aggiornamento o del giorno. Questo valore è facoltativo.</dd>

   </dl>

**Esempi**:

  Esempio per abilitare un ALB:

  ```
  ibmcloud ks alb-configure --albID private-cr18a61a63a6a94b658596aa93a087aaa9-alb1 --enable
  ```
  {: pre}

  Esempio per abilitare un ALB con un indirizzo IP fornito dall'utente:

  ```
  ibmcloud ks alb-configure --albID private-cr18a61a63a6a94b658596aa93a087aaa9-alb1 --enable --user-ip user_ip
  ```
  {: pre}

  Esempio per disabilitare un ALB:

  ```
  ibmcloud ks alb-configure --albID public-cr18a61a63a6a94b658596aa93a087aaa9-alb1 --disable
  ```
  {: pre}

### ibmcloud ks alb-get --albID ALB_ID [--json][-s]
{: #cs_alb_get}

Visualizza i dettagli di un ALB.

<strong>Opzioni comando</strong>:

   <dl>
   <dt><code><em>--albID </em>ALB_ID</code></dt>
   <dd>L'ID per un ALB. Esegui <code>ibmcloud ks albs --cluster <em>CLUSTER</em></code> per visualizzare gli ID degli ALB in un cluster. Questo valore è obbligatorio.</dd>

   <dt><code>--json</code></dt>
   <dd>Stampa l'output del comando in formato JSON. Questo valore è facoltativo.</dd>

  <dt><code>-s</code></dt>
  <dd>Non visualizza il messaggio dei promemoria di aggiornamento o del giorno. Questo valore è facoltativo.</dd>

   </dl>

**Esempio**:

  ```
  ibmcloud ks alb-get --albID public-cr18a61a63a6a94b658596aa93a087aaa9-alb1
  ```
  {: pre}

### ibmcloud ks alb-types [--json][-s]
{: #cs_alb_types}

Visualizza i tipi di ALB supportati nella regione.

<strong>Opzioni comando</strong>:

  <dl>
  <dt><code>--json</code></dt>
  <dd>Stampa l'output del comando in formato JSON. Questo valore è facoltativo.</dd>

  <dt><code>-s</code></dt>
  <dd>Non visualizza il messaggio dei promemoria di aggiornamento o del giorno. Questo valore è facoltativo.</dd>
  </dl>

**Esempio**:

  ```
  ibmcloud ks alb-types
  ```
  {: pre}


### ibmcloud ks albs --cluster CLUSTER [--json][-s]
{: #cs_albs}

Visualizza lo stato di tutti gli ALB in un cluster. Se non viene restituito alcun ID ALB, il cluster non ha una sottorete portatile. Puoi [creare](#cs_cluster_subnet_create) o [aggiungere](#cs_cluster_subnet_add) le sottoreti a un cluster.

<strong>Opzioni comando</strong>:

   <dl>
   <dt><code><em>--cluster </em>CLUSTER</code></dt>
   <dd>Il nome o l'ID del cluster in cui elenchi gli ALB disponibili. Questo valore è obbligatorio.</dd>

   <dt><code>--json</code></dt>
   <dd>Stampa l'output del comando in formato JSON. Questo valore è facoltativo.</dd>

   <dt><code>-s</code></dt>
   <dd>Non visualizza il messaggio dei promemoria di aggiornamento o del giorno. Questo valore è facoltativo.</dd>

   </dl>

**Esempio**:

  ```
  ibmcloud ks albs --cluster my_cluster
  ```
  {: pre}


<br />


## Comandi infrastruttura
{: #infrastructure_commands}

### ibmcloud ks credentials-set --infrastructure-api-key API_KEY --infrastructure-username USERNAME [-s]
{: #cs_credentials_set}

Imposta le credenziali di account dell'infrastruttura IBM Cloud (SoftLayer) per una regione {{site.data.keyword.containerlong_notm}}.

Se hai un account Pagamento a consumo {{site.data.keyword.Bluemix_notm}}, hai accesso al portfolio dell'infrastruttura IBM Cloud (SoftLayer) per impostazione predefinita. Tuttavia, potresti voler utilizzare un altro account dell'infrastruttura IBM Cloud (SoftLayer) di cui già disponi per ordinare l'infrastruttura. Puoi collegare l'account dell'infrastruttura al tuo account {{site.data.keyword.Bluemix_notm}} utilizzando questo comando.

Se le credenziali dell'infrastruttura IBM Cloud (SoftLayer) vengono impostate manualmente per una regione, esse vengono utilizzate per ordinare l'infrastruttura per tutti i cluster in tale regione. Queste credenziali vengono utilizzate per determinare le autorizzazioni dell'infrastruttura, anche se una [chiave API IAM](#cs_api_key_info) già esiste per la regione. Se l'utente di cui sono state memorizzate le credenziali non dispone delle autorizzazioni necessarie per ordinare l'infrastruttura, le azioni relative all'infrastruttura, come la creazione di un cluster o il ricaricamento di un nodo di lavoro, possono avere esito negativo.

Non puoi impostare più credenziali per la stessa regione {{site.data.keyword.containerlong_notm}}.

**Importante:** prima di utilizzare questo comando, assicurati che l'utente di cui vengono utilizzate le credenziali abbia le [autorizzazioni necessarie per {{site.data.keyword.containerlong_notm}} e l'infrastruttura IBM Cloud (SoftLayer)](cs_users.html#users).

<strong>Opzioni comando</strong>:

   <dl>
   <dt><code>--infrastructure-username <em>USERNAME</em></code></dt>
   <dd>Nome utente API dell'account dell'infrastruttura IBM Cloud (SoftLayer). Questo valore è obbligatorio. **Nota**: il nome utente API dell'infrastruttura non è lo stesso dell'IBMid. Per visualizzare il nome utente API dell'infrastruttura:
   <ol><li>Accedi al portale [{{site.data.keyword.Bluemix_notm}} ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://console.bluemix.net/).</li>
   <li>Dal menu che si espande, seleziona **Infrastruttura**.</li>
   <li>Dalla barra dei menu, seleziona **Account** > **Utenti** > **Elenco utenti**.</li>
   <li>Per l'utente che desideri visualizzare, fai clic su **IBMid o Nome utente**.</li>
   <li>Nella sezione **Informazioni di accesso API**, esamina il **Nome utente API**.</li>
   </ol></dd>


   <dt><code>--infrastructure-api-key <em>API_KEY</em></code></dt>
   <dd>Chiave API dell'account dell'infrastruttura IBM Cloud (SoftLayer). Questo valore è obbligatorio.

 <p>
  Per generare una chiave API:

  <ol>
  <li>Accedi al [portale dell'infrastruttura IBM Cloud (SoftLayer) ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://control.bluemix.net/).</li>
  <li>Seleziona <strong>Account</strong> e quindi <strong>Utenti</strong>.</li>
  <li>Fai clic su <strong>Genera</strong> per generare una chiave API dell'infrastruttura IBM Cloud (SoftLayer) per il tuo account.</li>
  <li>Copia la chiave API da utilizzare in questo comando.</li>
  </ol>

  Per visualizzare la tua chiave API esistente:
  <ol>
  <li>Accedi al [portale dell'infrastruttura IBM Cloud (SoftLayer) ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://control.bluemix.net/).</li>
  <li>Seleziona <strong>Account</strong> e quindi <strong>Utenti</strong>.</li>
  <li>Fai clic su <strong>Visualizza</strong> per vedere la tua chiave API esistente.</li>
  <li>Copia la chiave API da utilizzare in questo comando.</li>
  </ol>
  </p></dd>

  <dt><code>-s</code></dt>
  <dd>Non visualizza il messaggio dei promemoria di aggiornamento o del giorno. Questo valore è facoltativo.</dd>

  </dl>

**Esempio**:

  ```
  ibmcloud ks credentials-set --infrastructure-api-key <api_key> --infrastructure-username dbmanager
  ```
  {: pre}


### ibmcloud ks credentials-unset
{: #cs_credentials_unset}

Rimuovi le credenziali dell'account dell'infrastruttura IBM Cloud (SoftLayer) da una regione {{site.data.keyword.containerlong_notm}}.

Dopo aver rimosso le credenziali, la [chiave API IAM](#cs_api_key_info) viene utilizzata per ordinare le risorse nell'infrastruttura IBM Cloud (SoftLayer).

<strong>Opzioni comando</strong>:

  <dl>
  <dt><code>-s</code></dt>
  <dd>Non visualizza il messaggio dei promemoria di aggiornamento o del giorno. Questo valore è facoltativo.</dd>
  </dl>

**Esempio**:

  ```
  ibmcloud ks credentials-unset
  ```
  {: pre}


### ibmcloud ks machine-types --zone ZONE [--json][-s]
{: #cs_machine_types}

Visualizzare un elenco di tipi di macchina disponibili per i tuoi nodi di lavoro. I tipi di macchina variano per zona. Ogni tipo di macchina include
la quantità di CPU virtuale, memoria e spazio su disco per ogni nodo di lavoro nel cluster. Per impostazione predefinita, la directory del disco di archiviazione secondario, in cui vengono memorizzati tutti i dati del contenitore, è codificata con la crittografia LUKS. Se l'opzione `disable-disk-encrypt` viene inclusa durante la creazione del cluster, i dati di runtime del contenitore dell'host non vengono crittografati. [Ulteriori informazioni sulla crittografia](cs_secure.html#encrypted_disk).
{:shortdesc}

Puoi eseguire il provisioning del tuo nodo di lavoro come macchina virtuale su hardware condiviso o dedicato o come macchina fisica su bare metal. [Ulteriori informazioni sulle opzioni del tuo tipo di macchina](cs_clusters_planning.html#shared_dedicated_node).

<strong>Opzioni comando</strong>:

   <dl>
   <dt><code>--zone <em>ZONE</em></code></dt>
   <dd>Immetti la zona in cui vuoi elencare i tipi di macchina disponibili. Questo valore è obbligatorio. Controlla le [zone disponibili](cs_regions.html#zones).</dd>

   <dt><code>--json</code></dt>
  <dd>Stampa l'output del comando in formato JSON. Questo valore è facoltativo.</dd>

  <dt><code>-s</code></dt>
  <dd>Non visualizza il messaggio dei promemoria di aggiornamento o del giorno. Questo valore è facoltativo.</dd>
  </dl>

**Comando di esempio**:

  ```
  ibmcloud ks machine-types --zone dal10
  ```
  {: pre}

### ibmcloud ks vlans --zone ZONE [--all][--json] [-s]
{: #cs_vlans}

Elenca le VLAN pubbliche e private disponibili per una zona nel tuo account dell'infrastruttura IBM Cloud (SoftLayer). Per elencare le VLAN disponibili,
devi avere un account a pagamento.

<strong>Opzioni comando</strong>:

   <dl>
   <dt><code>--zone <em>ZONE</em></code></dt>
   <dd>Immetti la zona in cui vuoi elencare le tue VLAN pubbliche e private. Questo valore è obbligatorio. Controlla le [zone disponibili](cs_regions.html#zones).</dd>

   <dt><code>--all</code></dt>
   <dd>Elenca tutte le VLAN disponibili. Per impostazione predefinita, le VLAN vengono filtrate per mostrare solo quelle VLAN che sono valide. Perché sia valida, una VLAN deve essere associata a un'infrastruttura in grado di ospitare un nodo di lavoro con archiviazione su disco locale.</dd>

   <dt><code>--json</code></dt>
  <dd>Stampa l'output del comando in formato JSON. Questo valore è facoltativo.</dd>

  <dt><code>-s</code></dt>
  <dd>Non visualizza il messaggio dei promemoria di aggiornamento o del giorno. Questo valore è facoltativo.</dd>
   </dl>

**Esempio**:

  ```
  ibmcloud ks vlans --zone dal10
  ```
  {: pre}


### ibmcloud ks vlan-spanning-get [--json][-s]
{: #cs_vlan_spanning_get}

Visualizza lo stato dello spanning della VLAN per un account dell'infrastruttura IBM Cloud (SoftLayer). Lo spanning della VLAN abilita tutti i dispositivi su un account a comunicare tra loro tramite la rete privata, indipendentemente dalla loro VLAN assegnata.

<strong>Opzioni comando</strong>:

   <dl>
    <dt><code>--json</code></dt>
      <dd>Stampa l'output del comando in formato JSON. Questo valore è facoltativo.</dd>

    <dt><code>-s</code></dt>
      <dd>Non visualizza il messaggio dei promemoria di aggiornamento o del giorno. Questo valore è facoltativo.</dd>
   </dl>

**Esempio**:

  ```
  ibmcloud ks vlan-spanning-get
  ```
  {: pre}

<br />


## Comandi registrazione
{: #logging_commands}

### ibmcloud ks logging-config-create --cluster CLUSTER --logsource LOG_SOURCE --type LOG_TYPE [--namespace KUBERNETES_NAMESPACE][--hostname LOG_SERVER_HOSTNAME_OR_IP] [--port LOG_SERVER_PORT][--space CLUSTER_SPACE] [--org CLUSTER_ORG][--app-containers CONTAINERS] [--app-paths PATHS_TO_LOGS][--syslog-protocol PROTOCOL]  [--json][--skip-validation] [--force-update][-s]
{: #cs_logging_create}

Crea una configurazione di registrazione. Puoi utilizzare questo comando per inoltrare i log dei contenitori, delle applicazioni, dei nodi di lavoro, dei cluster Kubernetes e dei programmi di bilanciamento del carico dell'applicazione Ingress a {{site.data.keyword.loganalysisshort_notm}} o a un server syslog esterno.

<strong>Opzioni comando</strong>:

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>Il nome o l'ID del cluster.</dd>

  <dt><code>--logsource <em>LOG_SOURCE</em></code></dt>    
    <dd>'origine del log per abilitare l'inoltro di log. Questo argomento supporta un elenco separato da virgole di origini log per cui applicare la configurazione. I valori accettati sono <code>container</code>, <code>application</code>, <code>worker</code>, <code>kubernetes</code>, <code>ingress</code> e <code>kube-audit</code>. Se non fornisci un'origine log, vengono create le configurazioni per <code>container</code> e <code>ingress</code>.</dd>

  <dt><code>--type <em>LOG_TYPE</em></code></dt>
    <dd>Il luogo in cui vuoi inoltrare i tuoi log. Le opzioni sono <code>ibm</code>, che inoltra i tuoi log a {{site.data.keyword.loganalysisshort_notm}} e <code>syslog</code>, che inoltra i log a un server esterno.</dd>

  <dt><code>--namespace <em>KUBERNETES_NAMESPACE</em></code></dt>
    <dd>Lo spazio dei nomi Kubernetes dal quale desideri inoltrare i log. L'inoltro del log non è supportato per gli spazi dei nomi Kubernetes <code>ibm-system</code> e <code>kube-system</code>. Questo valore è valido solo per l'origine del log del contenitore ed è facoltativo. Se non specifichi uno spazio dei nomi, tutti gli spazi dei nomi nel cluster utilizzeranno questa configurazione.</dd>

  <dt><code>--hostname <em>LOG_SERVER_HOSTNAME</em></code></dt>
    <dd>Quando il tipo di registrazione è <code>syslog</code>, il nome host o l'indirizzo IP del server di raccolta del log. Questo valore è obbligatorio per <code>syslog</code>. Quando il tipo di registrazione è <code>ibm</code>, l'URL di inserimento {{site.data.keyword.loganalysislong_notm}}. Puoi trovare l'elenco degli URL di inserimento disponibili [qui](/docs/services/CloudLogAnalysis/log_ingestion.html#log_ingestion_urls). Se non specifichi un URL di inserimento, viene utilizzato l'endpoint della regione in cui è stato creato il tuo cluster.</dd>

  <dt><code>--port <em>LOG_SERVER_PORT</em></code></dt>
    <dd>La porta del server di raccolta del log. Questo valore è facoltativo. Se non specifichi una porta, viene utilizzata la porta standard <code>514</code> per <code>syslog</code> e <code>9091</code> per <code>ibm</code>.</dd>

  <dt><code>--space <em>CLUSTER_SPACE</em></code></dt>
    <dd>Facoltativo: il nome dello spazio Cloud Foundry a cui vuoi inviare i log. Questo valore è valido solo per il tipo di log <code>ibm</code> ed è facoltativo. Se non specifichi uno spazio, i log vengono inviati al livello dell'account. Se lo specifichi, devi specificare anche un'organizzazione.</dd>

  <dt><code>--org <em>CLUSTER_ORG</em></code></dt>
    <dd>Facoltativo: il nome dell'organizzazione Cloud Foundry in cui si trova lo spazio. Questo valore è valido solo per il tipo di log <code>ibm</code> ed è obbligatorio se hai specificato uno spazio.</dd>

  <dt><code>--app-paths</code></dt>
    <dd>Il percorso sul contenitore a cui si collegano le applicazioni. Per inoltrare i log con il tipo di origine <code>application</code>, devi fornire un percorso. Per specificare più di un percorso, utilizza un elenco separato da virgole. Questo valore è necessario per l'origine log <code>application</code>. Esempio: <code>/var/log/myApp1/&ast;,/var/log/myApp2/&ast;</code></dd>

  <dt><code>--syslog-protocol</code></dt>
    <dd>Il protocollo del livello di trasferimento utilizzato quando il tipo di registrazione è <code>syslog</code>. I valori supportati sono <code>tcp</code>, <code>tls</code> e il valore predefinito <code>udp</code>. Quando esegui l'inoltro a un server rsyslog con il protocollo <code>udp</code>, i log superiori a 1KB vengono troncati.</dd>

  <dt><code>--app-containers</code></dt>
    <dd>Per inoltrare i log dalle applicazioni, puoi specificare il nome del contenitore che contiene la tua applicazione. Puoi specificare più di un contenitore utilizzando un elenco separato da virgole. Se non si specificano i contenitori, i log vengono inoltrati da tutti i contenitori che contengono i percorsi da te forniti. Questa opzione è valida solo per l'origine log <code>application</code>.</dd>

  <dt><code>--json</code></dt>
    <dd>Stampa l'output del comando in formato JSON. Questo valore è facoltativo.</dd>

  <dt><code>--skip-validation</code></dt>
    <dd>Ignora la convalida dei nomi di organizzazione e spazio quando vengono specificati. La mancata convalida riduce il tempo di elaborazione, ma una configurazione di registrazione non valida non inoltra correttamente i log. Questo valore è facoltativo.</dd>

  <dt><code>--force-update</code></dt>
    <dd>Forza i tuoi pod Fluentd ad eseguire l'aggiornamento alla versione più recente. La versione di Fluentd deve essere la più recente per poter modificare le tue configurazioni di registrazione.</dd>

    <dt><code>-s</code></dt>
    <dd>Non visualizza il messaggio dei promemoria di aggiornamento o del giorno. Questo valore è facoltativo.</dd>
</dl>

**Esempi**:

Esempio del tipo di log `ibm` che inoltra da un'origine log `container` sulla porta predefinita 9091:

  ```
  ibmcloud ks logging-config-create my_cluster --logsource container --namespace my_namespace --hostname ingest.logging.ng.bluemix.net --type ibm
  ```
  {: pre}

Esempio del tipo di log `syslog` che inoltra da un'origine log `container` sulla porta predefinita 514:

  ```
  ibmcloud ks logging-config-create my_cluster --logsource container --namespace my_namespace  --hostname 169.xx.xxx.xxx --type syslog
  ```
  {: pre}

Esempio di un tipo di log `syslog` che inoltra i log da un'origine `ingress` su una porta differente dalla predefinita:

  ```
  ibmcloud ks logging-config-create --cluster my_cluster --logsource container --hostname 169.xx.xxx.xxx --port 5514 --type syslog
  ```
  {: pre}

### ibmcloud ks logging-config-get --cluster CLUSTER [--logsource LOG_SOURCE][--json] [-s]
{: #cs_logging_get}

Visualizza tutte le configurazioni di inoltro di un cluster o filtrale in base all'origine del log.

<strong>Opzioni comando</strong>:

 <dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>Il nome o l'ID del cluster. Questo valore è obbligatorio.</dd>

  <dt><code>--logsource <em>LOG_SOURCE</em></code></dt>
    <dd>Il tipo di origine del log per la quale desideri eseguire il filtro. Vengono restituite solo le configurazioni di registrazione di questa origine del log nel cluster. I valori accettati sono <code>container</code>, <code>application</code>, <code>worker</code>, <code>kubernetes</code>, <code>ingress</code> e <code>kube-audit</code>. Questo valore è facoltativo.</dd>

  <dt><code>--show-covering-filters</code></dt>
    <dd>Mostra i filtri di registrazione che rendono i precedenti filtri obsoleti.</dd>

  <dt><code>--json</code></dt>
    <dd>Stampa l'output del comando in formato JSON. Questo valore è facoltativo.</dd>

  <dt><code>-s</code></dt>
    <dd>Non visualizza il messaggio dei promemoria di aggiornamento o del giorno. Questo valore è facoltativo.</dd>
 </dl>

**Esempio**:

  ```
  ibmcloud ks logging-config-get --cluster my_cluster --logsource worker
  ```
  {: pre}


### ibmcloud ks logging-config-refresh --cluster CLUSTER  [--force-update][-s]
{: #cs_logging_refresh}

Aggiorna la configurazione di registrazione per il cluster. Questo aggiorna il token di registrazione per tutte le configurazioni di registrazione che stanno eseguendo l'inoltro al livello dello spazio nel tuo cluster.

<strong>Opzioni comando</strong>:

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Il nome o l'ID del cluster. Questo valore è obbligatorio.</dd>

   <dt><code>--force-update</code></dt>
     <dd>Forza i tuoi pod Fluentd ad eseguire l'aggiornamento alla versione più recente. La versione di Fluentd deve essere la più recente per poter modificare le tue configurazioni di registrazione.</dd>

   <dt><code>-s</code></dt>
     <dd>Non visualizza il messaggio dei promemoria di aggiornamento o del giorno. Questo valore è facoltativo.</dd>
</dl>

**Esempio**:

  ```
  ibmcloud ks logging-config-refresh --cluster my_cluster
  ```
  {: pre}


### ibmcloud ks logging-config-rm --cluster CLUSTER [--id LOG_CONFIG_ID][--all] [--force-update][-s]
{: #cs_logging_rm}

Elimina una configurazione di inoltro dei log o tutte le configurazioni di registrazione per un cluster. Questo arresta l'inoltro dei log a un server syslog remoto o a {{site.data.keyword.loganalysisshort_notm}}.

<strong>Opzioni comando</strong>:

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Il nome o l'ID del cluster. Questo valore è obbligatorio.</dd>

  <dt><code>--id <em>LOG_CONFIG_ID</em></code></dt>
   <dd>Se vuoi rimuovere una singola configurazione di registrazione, l'ID della configurazione di registrazione.</dd>

  <dt><code>--all</code></dt>
   <dd>L'indicatore per rimuovere tutte le configurazioni di registrazione in un cluster.</dd>

  <dt><code>--force-update</code></dt>
    <dd>Forza i tuoi pod Fluentd ad eseguire l'aggiornamento alla versione più recente. La versione di Fluentd deve essere la più recente per poter modificare le tue configurazioni di registrazione.</dd>

   <dt><code>-s</code></dt>
     <dd>Non visualizza il messaggio dei promemoria di aggiornamento o del giorno. Questo valore è facoltativo.</dd>
</dl>

**Esempio**:

  ```
  ibmcloud ks logging-config-rm --cluster my_cluster --id f4bc77c0-ee7d-422d-aabf-a4e6b977264e
  ```
  {: pre}


### ibmcloud ks logging-config-update --cluster CLUSTER --id LOG_CONFIG_ID --type LOG_TYPE  [--namespace NAMESPACE][--hostname LOG_SERVER_HOSTNAME_OR_IP] [--port LOG_SERVER_PORT][--space CLUSTER_SPACE] [--org CLUSTER_ORG][--app-paths PATH] [--app-containers PATH][--json] [--skipValidation][--force-update] [-s]
{: #cs_logging_update}

Aggiorna i dettagli di una configurazione di inoltro del log.

<strong>Opzioni comando</strong>:

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Il nome o l'ID del cluster. Questo valore è obbligatorio.</dd>

  <dt><code>--id <em>LOG_CONFIG_ID</em></code></dt>
   <dd>L'ID di configurazione di registrazione che desideri aggiornare. Questo valore è obbligatorio.</dd>

  <dt><code>--type <em>LOG_TYPE</em></code></dt>
   <dd>Il protocollo di inoltro del log che desideri utilizzare. Al momento, sono supportati <code>syslog</code> e <code>ibm</code>. Questo valore è obbligatorio.</dd>

  <dt><code>--namespace <em>NAMESPACE</em></code>
    <dd>Lo spazio dei nomi Kubernetes dal quale desideri inoltrare i log. L'inoltro del log non è supportato per gli spazi dei nomi Kubernetes <code>ibm-system</code> e <code>kube-system</code>. Questo valore è valido solo per l'origine log <code>container</code>. Se non specifichi uno spazio dei nomi, tutti gli spazi dei nomi nel cluster utilizzeranno questa configurazione.</dd>

  <dt><code>--hostname <em>LOG_SERVER_HOSTNAME</em></code></dt>
   <dd>Quando il tipo di registrazione è <code>syslog</code>, il nome host o l'indirizzo IP del server di raccolta del log. Questo valore è obbligatorio per <code>syslog</code>. Quando il tipo di registrazione è <code>ibm</code>, l'URL di inserimento {{site.data.keyword.loganalysislong_notm}}. Puoi trovare l'elenco degli URL di inserimento disponibili [qui](/docs/services/CloudLogAnalysis/log_ingestion.html#log_ingestion_urls). Se non specifichi un URL di inserimento, viene utilizzato l'endpoint della regione in cui è stato creato il tuo cluster.</dd>

   <dt><code>--port <em>LOG_SERVER_PORT</em></code></dt>
   <dd>La porta del server di raccolta del log. Questo valore è facoltativo quando il tipo di registrazione è <code>syslog</code>. Se non specifichi una porta, viene utilizzata la porta standard <code>514</code> per <code>syslog</code> e <code>9091</code> per <code>ibm</code>.</dd>

   <dt><code>--space <em>CLUSTER_SPACE</em></code></dt>
   <dd>Facoltativo: il nome dello spazio a cui vuoi inviare i log. Questo valore è valido solo per il tipo di log <code>ibm</code> ed è facoltativo. Se non specifichi uno spazio, i log vengono inviati al livello dell'account. Se lo specifichi, devi specificare anche un'organizzazione. </dd>

   <dt><code>--org <em>CLUSTER_ORG</em></code></dt>
   <dd>Facoltativo: il nome dell'organizzazione Cloud Foundry in cui si trova lo spazio. Questo valore è valido solo per il tipo di log <code>ibm</code> ed è obbligatorio se hai specificato uno spazio.</dd>

   <dt><code>--app-paths <em>PATH</em>,<em>PATH</em></code></dt>
     <dd>Un percorso file assoluto nel contenitore da cui raccogliere i log. Possono essere utilizzati i caratteri jolly, come '/var/log/*.log', ma non possono essere utilizzati i glob ricorrenti come '/var/log/**/test.log'. Per specificare più di un percorso, utilizza un elenco separato da virgole. Questo valore è obbligatorio quando specifichi 'application' per l'origine log. </dd>

   <dt><code>--app-containers <em>PATH</em>,<em>PATH</em></code></dt>
     <dd>Il percorso nei contenitori a cui si collegano le applicazioni. Per inoltrare i log con il tipo di origine <code>application</code>, devi fornire un percorso. Per specificare più di un percorso, utilizza un elenco separato da virgole. Esempio: <code>/var/log/myApp1/&ast;,/var/log/myApp2/&ast;</code></dd>

   <dt><code>--json</code></dt>
    <dd>Stampa l'output del comando in formato JSON. Questo valore è facoltativo.</dd>

   <dt><code>--skipValidation</code></dt>
    <dd>Ignora la convalida dei nomi di organizzazione e spazio quando vengono specificati. La mancata convalida riduce il tempo di elaborazione, ma una configurazione di registrazione non valida non inoltra correttamente i log. Questo valore è facoltativo.</dd>

  <dt><code>--force-update</code></dt>
    <dd>Forza i tuoi pod Fluentd ad eseguire l'aggiornamento alla versione più recente. La versione di Fluentd deve essere la più recente per poter modificare le tue configurazioni di registrazione.</dd>

   <dt><code>-s</code></dt>
     <dd>Non visualizza il messaggio dei promemoria di aggiornamento o del giorno. Questo valore è facoltativo.</dd>
  </dl>

**Esempio di tipo di log `ibm`**:

  ```
  ibmcloud ks logging-config-update my_cluster --id f4bc77c0-ee7d-422d-aabf-a4e6b977264e --type ibm
  ```
  {: pre}

**Esempio di tipo di log `syslog`**:

  ```
  ibmcloud ks logging-config-update --cluster my_cluster --id f4bc77c0-ee7d-422d-aabf-a4e6b977264e --hostname localhost --port 5514 --type syslog
  ```
  {: pre}


### ibmcloud ks logging-filter-create --cluster CLUSTER --type LOG_TYPE [--logging-configs CONFIGS][--namespace KUBERNETES_NAMESPACE] [--container CONTAINER_NAME][--level LOGGING_LEVEL] [--regex-message MESSAGE][--force-update]  [--json][-s]
{: #cs_log_filter_create}

Crea un filtro di registrazione. Puoi usare questo comando per filtrare le registrazioni che vengono inoltrate dalla tua configurazione di registrazione.

<strong>Opzioni comando</strong>:

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>Il nome o l'ID del cluster per il quale vuoi creare un filtro di registrazione. Questo valore è obbligatorio.</dd>

  <dt><code>--type <em>LOG_TYPE</em></code></dt>
    <dd>Il tipo di log a cui desideri applicare il filtro. Attualmente sono supportati <code>all</code>, <code>container</code> e <code>host</code>.</dd>

  <dt><code>--logging-configs <em>CONFIGS</em></code></dt>
    <dd>Un elenco separato da virgole dei tuoi ID di configurazione di registrazione. Se non viene fornito, il filtro viene applicato a tutte le configurazioni di registrazione cluster passate al filtro. Puoi visualizzare le configurazioni di registrazione che corrispondono al filtro utilizzando l'indicatore <code>--show-matching-configs</code> con il comando. Questo valore è facoltativo.</dd>

  <dt><code>--namespace <em>KUBERNETES_NAMESPACE</em></code></dt>
    <dd>Lo spazio dei nomi Kubernetes da cui desideri filtrare i log. Questo valore è facoltativo.</dd>

  <dt><code>--container <em>CONTAINER_NAME</em></code></dt>
    <dd>Il nome del contenitore da cui desideri filtrare i log. Questo indicatore si applica solo quando utilizzi il tipo di log <code>container</code>. Questo valore è facoltativo.</dd>

  <dt><code>--level <em>LOGGING_LEVEL</em></code></dt>
    <dd>Filtra i log che si trovano al livello specificato e a quelli inferiori ad esso. I valori accettabili nel loro ordine canonico sono <code>fatal</code>, <code>error</code>, <code>warn/warning</code>, <code>info</code>, <code>debug</code> e <code>trace</code>. Questo valore è facoltativo. Ad esempio, se hai filtrato i log a livello <code>info</code>, vengono filtrati anche <code>debug</code> e <code>trace</code>. **Nota**: puoi utilizzare questo indicatore solo quando i messaggi di log sono in formato JSON e contengono un campo di livello. Output di esempio: <code>{"log": "hello", "level": "info"}</code></dd>

  <dt><code>--regex-message <em>MESSAGE</em></code></dt>
    <dd>Filtra i log che contengono un messaggio specificato scritto come un'espressione regolare in un qualsiasi punto nel log. Questo valore è facoltativo.</dd>

  <dt><code>--force-update</code></dt>
    <dd>Forza i tuoi pod Fluentd ad eseguire l'aggiornamento alla versione più recente. La versione di Fluentd deve essere la più recente per poter modificare le tue configurazioni di registrazione.</dd>

  <dt><code>--json</code></dt>
    <dd>Stampa l'output del comando in formato JSON. Questo valore è facoltativo.</dd>

  <dt><code>-s</code></dt>
    <dd>Non visualizza il messaggio dei promemoria di aggiornamento o del giorno. Questo valore è facoltativo.</dd>
</dl>

**Esempi**:

Questo esempio filtra tutti i log che sono stati inoltrati dai contenitori con il nome `test-container` nello spazio dei nomi predefinito che si trovano a livello debug o inferiore e che hanno un messaggio di log che contiene "GET request".

  ```
  ibmcloud ks logging-filter-create --cluster example-cluster --type container --namespace default --container test-container --level debug --message "GET request"
  ```
  {: pre}

Questo esempio filtra tutti i log che sono stati inoltrati, ad un livello info o inferiore, da uno specifico cluster. L'output viene restituito come un JSON.

  ```
  ibmcloud ks logging-filter-create --cluster example-cluster --type all --level info --json
  ```
  {: pre}



### ibmcloud ks logging-filter-get --cluster CLUSTER [--id FILTER_ID][--show-matching-configs] [--show-covering-filters][--json] [-s]
{: #cs_log_filter_view}

Visualizza la configurazione di un filtro di registrazione. Puoi utilizzare questo comando per visualizzare i filtri di registrazione che hai creato.

<strong>Opzioni comando</strong>:

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>Il nome o l'ID del cluster dal quale desideri visualizzare i filtri. Questo valore è obbligatorio.</dd>

  <dt><code>--id <em>FILTER_ID</em></code></dt>
    <dd>L'ID del filtro di log che desideri visualizzare.</dd>

  <dt><code>--show-matching-configs</code></dt>
    <dd>Mostra le configurazioni di registrazione che corrispondono alla configurazione che stai visualizzando. Questo valore è facoltativo.</dd>

  <dt><code>--show-covering-filters</code></dt>
    <dd>Mostra i filtri di registrazione che rendono i precedenti filtri obsoleti. Questo valore è facoltativo.</dd>

  <dt><code>--json</code></dt>
    <dd>Stampa l'output del comando in formato JSON. Questo valore è facoltativo.</dd>

   <dt><code>-s</code></dt>
     <dd>Non visualizza il messaggio dei promemoria di aggiornamento o del giorno. Questo valore è facoltativo.</dd>
</dl>


### ibmcloud ks logging-filter-rm --cluster CLUSTER [--id FILTER_ID][--all] [--force-update][-s]
{: #cs_log_filter_delete}

Elimina un filtro di registrazione. Puoi utilizzare questo comando per eliminare un filtro di registrazione che hai creato.

<strong>Opzioni comando</strong>:

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>Il nome o l'ID del cluster da cui desideri eliminare un filtro.</dd>

  <dt><code>--id <em>FILTER_ID</em></code></dt>
    <dd>L'ID del filtro di log da eliminare.</dd>

  <dt><code>--all</code></dt>
    <dd>Elimina tutti i tuoi filtri di inoltro del log. Questo valore è facoltativo.</dd>

  <dt><code>--force-update</code></dt>
    <dd>Forza i tuoi pod Fluentd ad eseguire l'aggiornamento alla versione più recente. La versione di Fluentd deve essere la più recente per poter modificare le tue configurazioni di registrazione.</dd>

  <dt><code>-s</code></dt>
    <dd>Non visualizza il messaggio dei promemoria di aggiornamento o del giorno. Questo valore è facoltativo.</dd>
</dl>

### ibmcloud ks logging-filter-update --cluster CLUSTER --id FILTER_ID --type LOG_TYPE [--logging-configs CONFIGS][--namespace KUBERNETES_NAMESPACE] [--container CONTAINER_NAME][--level LOGGING_LEVEL] [--message MESSAGE][--force-update] [--json][-s]
{: #cs_log_filter_update}

Aggiorna un filtro di registrazione. Puoi utilizzare questo comando per aggiornare un filtro di registrazione che hai creato.

<strong>Opzioni comando</strong>:

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>Il nome o l'ID del cluster per il quale vuoi aggiornare un filtro di registrazione. Questo valore è obbligatorio.</dd>

 <dt><code>--id <em>FILTER_ID</em></code></dt>
    <dd>L'ID del filtro di log da aggiornare.</dd>

  <dt><code>--type <em>LOG_TYPE</em></code></dt>
    <dd>Il tipo di log a cui desideri applicare il filtro. Attualmente sono supportati <code>all</code>, <code>container</code> e <code>host</code>.</dd>

  <dt><code>--logging-configs <em>CONFIGS</em></code></dt>
    <dd>Un elenco separato da virgole dei tuoi ID di configurazione di registrazione. Se non viene fornito, il filtro viene applicato a tutte le configurazioni di registrazione cluster passate al filtro. Puoi visualizzare le configurazioni di registrazione che corrispondono al filtro utilizzando l'indicatore <code>--show-matching-configs</code> con il comando. Questo valore è facoltativo.</dd>

  <dt><code>--namespace <em>KUBERNETES_NAMESPACE</em></code></dt>
    <dd>Lo spazio dei nomi Kubernetes da cui desideri filtrare i log. Questo valore è facoltativo.</dd>

  <dt><code>--container <em>CONTAINER_NAME</em></code></dt>
    <dd>Il nome del contenitore da cui desideri filtrare i log. Questo indicatore si applica solo quando utilizzi il tipo di log <code>container</code>. Questo valore è facoltativo.</dd>

  <dt><code>--level <em>LOGGING_LEVEL</em></code></dt>
    <dd>Filtra i log che si trovano al livello specificato e a quelli inferiori ad esso. I valori accettabili nel loro ordine canonico sono <code>fatal</code>, <code>error</code>, <code>warn/warning</code>, <code>info</code>, <code>debug</code> e <code>trace</code>. Questo valore è facoltativo. Ad esempio, se hai filtrato i log a livello <code>info</code>, vengono filtrati anche <code>debug</code> e <code>trace</code>. **Nota**: puoi utilizzare questo indicatore solo quando i messaggi di log sono in formato JSON e contengono un campo di livello. Output di esempio: <code>{"log": "hello", "level": "info"}</code></dd>

  <dt><code>--message <em>MESSAGE</em></code></dt>
    <dd>Filtra i log che contengono un messaggio specificato in un qualsiasi punto nel log. Il messaggio viene messo in corrispondenza parola per parole e non come un'espressione. Esempio: i messaggi “Hello”, “!”e “Hello, World!”, si applicano al log come “Hello, World!”. Questo valore è facoltativo.</dd>

  <dt><code>--force-update</code></dt>
    <dd>Forza i tuoi pod Fluentd ad eseguire l'aggiornamento alla versione più recente. La versione di Fluentd deve essere la più recente per poter modificare le tue configurazioni di registrazione.</dd>

  <dt><code>--json</code></dt>
    <dd>Stampa l'output del comando in formato JSON. Questo valore è facoltativo.</dd>

  <dt><code>-s</code></dt>
    <dd>Non visualizza il messaggio dei promemoria di aggiornamento o del giorno. Questo valore è facoltativo.</dd>
</dl>

### ibmcloud ks logging-autoupdate-enable --cluster CLUSTER
{: #cs_log_autoupdate_enable}

Abilita l'aggiornamento automatico per i tuoi pod Fluentd in uno specifico cluster.

<strong>Opzioni comando</strong>:

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>Il nome o l'ID del cluster per il quale vuoi aggiornare un filtro di registrazione. Questo valore è obbligatorio.</dd>
</dl>

### ibmcloud ks logging-autoupdate-disable --cluster CLUSTER
{: #cs_log_autoupdate_disable}

Disabilita l'aggiornamento automatico per i tuoi pod Fluentd in uno specifico cluster.

<strong>Opzioni comando</strong>:

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>Il nome o l'ID del cluster per il quale vuoi aggiornare un filtro di registrazione. Questo valore è obbligatorio.</dd>
</dl>

### ibmcloud ks logging-autoupdate-get --cluster CLUSTER
{: #cs_log_autoupdate_get}

Visualizza se i tuoi pod Fluentd sono impostati per l'aggiornamento automatico in uno specifico cluster.

<strong>Opzioni comando</strong>:

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>Il nome o l'ID del cluster per il quale vuoi aggiornare un filtro di registrazione. Questo valore è obbligatorio.</dd>
</dl>

<br />


## Comandi regione
{: #region_commands}

### ibmcloud ks zones [--region-only][--json] [-s]
{: #cs_datacenters}

Visualizza un elenco delle zone disponibili in cui puoi creare un cluster. Le zone disponibili variano in base alla regione a cui hai eseguito l'accesso. Per selezionare la regione, esegui `ibmcloud ks region-set`.

<strong>Opzioni comando</strong>:

   <dl>
   <dt><code>--region-only</code></dt>
   <dd>Elenca solo gli elementi multizona all'interno della regione a cui hai eseguito l'accesso. Questo valore è facoltativo.</dd>

   <dt><code>--json</code></dt>
   <dd>Stampa l'output del comando in formato JSON. Questo valore è facoltativo.</dd>

   <dt><code>-s</code></dt>
   <dd>Non visualizza il messaggio dei promemoria di aggiornamento o del giorno. Questo valore è facoltativo.</dd>
   </dl>

**Esempio**:

  ```
  ibmcloud ks zones
  ```
  {: pre}


### ibmcloud ks region
{: #cs_region}

Trova la regione {{site.data.keyword.containerlong_notm}} in cui sei al momento. Crei e gestisci i cluster specifici della regione. Utilizza il comando `ibmcloud ks region-set` per modificare le regioni.

**Esempio**:

```
ibmcloud ks region
```
{: pre}

**Output**:
```
Region: us-south
```
{: screen}

### ibmcloud ks region-set [--region REGION]
{: #cs_region-set}

Imposta la regione per {{site.data.keyword.containerlong_notm}}. Crei e gestisci i cluster specifici della regione e puoi volere i cluster in più regioni per l'alta disponibilità.

Ad esempio, puoi accedere a {{site.data.keyword.Bluemix_notm}} nella regione Stati Uniti Sud e creare un cluster. Successivamente, puoi utilizzare `ibmcloud ks region-set eu-central` per specificare la regione Europa Centrale e creare un altro cluster. Infine, puoi utilizzare `ibmcloud ks region-set us-south` per ritornare alla regione Stati Uniti Sud per gestire il tuo cluster in tale regione.

**Opzioni comando**:

<dl>
<dt><code>--region <em>REGION</em></code></dt>
<dd>Immetti la regione che vuoi specificare. Questo valore è facoltativo. Se non fornisci la regione, puoi selezionarla dall'elenco nell'output.

Per un elenco di regioni disponibili, controlla [regioni e zone](cs_regions.html) o utilizza il [comando](#cs_regions) `ibmcloud ks regions`.</dd></dl>

**Esempio**:

```
ibmcloud ks region-set eu-central
```
{: pre}

```
ibmcloud ks region-set
```
{: pre}

**Output**:
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

Elenca le regioni disponibili. `Region Name` è il nome {{site.data.keyword.containerlong_notm}} e `Region Alias` è il nome {{site.data.keyword.Bluemix_notm}} generale della regione.

**Esempio**:

```
ibmcloud ks regions
```
{: pre}

**Output**:
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


<br />


## Comandi nodo di lavoro
{: worker_node_commands}


### Obsoleto: ibmcloud ks worker-add --cluster CLUSTER [--file FILE_LOCATION][--hardware HARDWARE] --machine-type MACHINE_TYPE --workers NUMBER --private-vlan PRIVATE_VLAN --public-vlan PUBLIC_VLAN [--disable-disk-encrypt][-s]
{: #cs_worker_add}

Aggiungi i nodi di lavoro autonomi che non si trovano in un pool di nodi di lavoro al tuo cluster standard.

<strong>Opzioni comando</strong>:

<dl>
<dt><code>--cluster <em>CLUSTER</em></code></dt>
<dd>Il nome o l'ID del cluster. Questo valore è obbligatorio.</dd>

<dt><code>--file <em>FILE_LOCATION</em></code></dt>
<dd>Il percorso al file YAML per aggiungere i nodi di lavoro al cluster. Invece di definire ulteriori nodi di lavoro utilizzando le opzioni fornite in questo comando, puoi utilizzare un file YAML. Questo valore è facoltativo.

<p><strong>Nota:</strong> se fornisci la stessa opzione nel comando come parametro nel file YAML, il valore nel comando ha la precedenza rispetto al valore nel YAML. Ad esempio, definisci un tipo di macchina nel tuo file YAML e utilizzi l'opzione --machine-type nel comando, il valore che hai immesso nell'opzione del comando sovrascrive il valore nel file YAML.

<pre class="codeblock">
<code>name: <em>&lt;cluster_name_or_ID&gt;</em>
zone: <em>&lt;zone&gt;</em>
machine-type: <em>&lt;machine_type&gt;</em>
private-vlan: <em>&lt;private_VLAN&gt;</em>
public-vlan: <em>&lt;public_VLAN&gt;</em>
hardware: <em>&lt;shared_or_dedicated&gt;</em>
workerNum: <em>&lt;number_workers&gt;</em>
diskEncryption: <em>false</em></code></pre>

<table>
<caption>Descrizione dei componenti del file YAML</caption>
<thead>
<th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
</thead>
<tbody>
<tr>
<td><code><em>name</em></code></td>
<td>Sostituisci <code><em>&lt;cluster_name_or_ID&gt;</em></code> con il nome o l'ID del cluster in cui desideri aggiungere nodi di lavoro.</td>
</tr>
<tr>
<td><code><em>zone</em></code></td>
<td>Sostituisci <code><em>&lt;zone&gt;</em></code> con la zona in cui distribuire i tuoi nodi di lavoro. Le zone disponibili dipendono dalla regione a cui hai eseguito l'accesso. Per elencare le zone disponibili, esegui <code>ibmcloud ks zones</code>.</td>
</tr>
<tr>
<td><code><em>machine-type</em></code></td>
<td>Sostituisci <code><em>&lt;machine_type&gt;</em></code> con il tipo di macchina in cui vuoi distribuire i tuoi nodi di lavoro. Puoi distribuire i tuoi nodi di lavoro come macchine virtuali su hardware condiviso o dedicato o come macchine fisiche su bare metal. I tipi di macchine fisiche e virtuali disponibili variano in base alla zona in cui distribuisci il cluster. Per ulteriori informazioni, vedi il [comando](cs_cli_reference.html#cs_machine_types) `ibmcloud ks machine-types`.</td>
</tr>
<tr>
<td><code><em>private-vlan</em></code></td>
<td>Sostituisci <code><em>&lt;private_VLAN&gt;</em></code> con l'ID della VLAN privata che vuoi utilizzare per i tuoi nodi di lavoro. Per elencare le VLAN disponibili, esegui <code>ibmcloud ks vlans <em>&lt;zone&gt;</em></code> e ricerca i router VLAN che iniziano con <code>bcr</code> (router di back-end).</td>
</tr>
<tr>
<td><code>public-vlan</code></td>
<td>Sostituisci <code>&lt;public_VLAN&gt;</code> con l'ID della VLAN pubblica che vuoi utilizzare per i tuoi nodi di lavoro. Per elencare le VLAN disponibili, esegui <code>ibmcloud ks vlans &lt;zone&gt;</code> e ricerca i router VLAN che iniziano con <code>fcr</code> (router di front-end). <br><strong>Nota</strong>: {[private_VLAN_vyatta]}</td>
</tr>
<tr>
<td><code>hardware</code></td>
<td>Per i tipi di macchina virtuale: il livello di isolamento hardware per il tuo nodo di lavoro. Utilizza dedicato se vuoi avere risorse fisiche dedicate disponibili solo per te o condiviso per consentire la condivisione delle risorse fisiche con altri clienti IBM. L'impostazione predefinita è condiviso.</td>
</tr>
<tr>
<td><code>workerNum</code></td>
<td>Sostituisci <code><em>&lt;number_workers&gt;</em></code> con il numero di nodi di lavoro che vuoi distribuire.</td>
</tr>
<tr>
<td><code>diskEncryption: <em>false</em></code></td>
<td>Codifica del disco della funzione dei nodi di lavoro predefinita; [ulteriori informazioni](cs_secure.html#encrypted_disk). Per disabilitare la codifica, includi questa opzione e imposta il valore su <code>false</code>.</td></tr>
</tbody></table></p></dd>

<dt><code>--hardware <em>HARDWARE</em></code></dt>
<dd>Il livello di isolamento hardware per il nodo di lavoro. Utilizza dedicato se vuoi avere risorse fisiche dedicate disponibili solo per te o condiviso per consentire la condivisione delle risorse fisiche con altri clienti IBM. L'impostazione predefinita è condiviso. Questo valore è facoltativo.</dd>

<dt><code>--machine-type <em>MACHINE_TYPE</em></code></dt>
<dd>Scegli un tipo di macchina. Puoi distribuire i tuoi nodi di lavoro come macchine virtuali su hardware condiviso o dedicato o come macchine fisiche su bare metal. I tipi di macchine fisiche e virtuali disponibili variano in base alla zona in cui distribuisci il cluster. Per ulteriori informazioni, consulta la documentazione per il [comando](cs_cli_reference.html#cs_machine_types) `ibmcloud ks machine-types`. Questo valore è obbligatorio per i cluster standard e non è disponibile per i cluster gratuiti.</dd>

<dt><code>--workers <em>NUMBER</em></code></dt>
<dd>Un numero intero che rappresenta il numero di nodi di lavoro da creare nel cluster. Il valore predefinito è 1. Questo valore è facoltativo.</dd>

<dt><code>--private-vlan <em>PRIVATE_VLAN</em></code></dt>
<dd>La VLAN privata specificata quando è stato creato il cluster. Questo valore è obbligatorio.

<p><strong>Nota:</strong> i router della VLAN privata iniziano sempre con <code>bcr</code> (router back-end) e i router della VLAN pubblica iniziano sempre con <code>fcr</code> (router front-end). Quando crei un cluster e specifichi le VLAN private e pubbliche, la combinazione di numero e lettera dopo tali prefissi deve corrispondere.</p></dd>

<dt><code>--public-vlan <em>PUBLIC_VLAN</em></code></dt>
<dd>La VLAN pubblica specificata quando è stato creato il cluster. Questo valore è facoltativo. Se vuoi che i tuoi nodi di lavoro siano solo su una VLAN privata, non fornire un ID VLAN pubblico. <strong>Nota</strong>: {[private_VLAN_vyatta]}

<p><strong>Nota:</strong> i router della VLAN privata iniziano sempre con <code>bcr</code> (router back-end) e i router della VLAN pubblica iniziano sempre con <code>fcr</code> (router front-end). Quando crei un cluster e specifichi le VLAN private e pubbliche, la combinazione di numero e lettera dopo tali prefissi deve corrispondere.</p></dd>

<dt><code>--disable-disk-encrypt</code></dt>
<dd>Codifica del disco della funzione dei nodi di lavoro predefinita; [ulteriori informazioni](cs_secure.html#encrypted_disk). Per disabilitare la codifica, includi questa opzione.</dd>

<dt><code>-s</code></dt>
<dd>Non visualizza il messaggio dei promemoria di aggiornamento o del giorno. Questo valore è facoltativo.</dd>

</dl>

**Esempi**:

  ```
  ibmcloud ks worker-add --cluster my_cluster --workers 3 --public-vlan my_public_VLAN_ID --private-vlan my_private_VLAN_ID --machine-type b2c.4x16 --hardware shared
  ```
  {: pre}

  Esempio per {{site.data.keyword.Bluemix_dedicated_notm}}:

  ```
  ibmcloud ks worker-add --cluster my_cluster --workers 3 --machine-type b2c.4x16
  ```
  {: pre}

### ibmcloud ks worker-get --cluster [CLUSTER_NAME_OR_ID] --worker WORKER_NODE_ID [--json][-s]
{: #cs_worker_get}

Visualizza i dettagli di un nodo di lavoro.

<strong>Opzioni comando</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER_NAME_OR_ID</em></code></dt>
   <dd>Il nome o l'ID del cluster del nodo di lavoro. Questo valore è facoltativo.</dd>

   <dt><code>--worker <em>WORKER_NODE_ID</em></code></dt>
   <dd>Il nome del tuo nodo di lavoro. Esegui <code>ibmcloud ks workers <em>CLUSTER</em></code> per visualizzare gli ID per i nodi di lavoro in un cluster. Questo valore è obbligatorio.</dd>

   <dt><code>--json</code></dt>
   <dd>Stampa l'output del comando in formato JSON. Questo valore è facoltativo.</dd>

   <dt><code>-s</code></dt>
   <dd>Non visualizza il messaggio dei promemoria di aggiornamento o del giorno. Questo valore è facoltativo.</dd>
   </dl>

**Comando di esempio**:

  ```
  ibmcloud ks worker-get --cluster my_cluster --worker kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w1
  ```
  {: pre}

**Output di esempio**:

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

### ibmcloud ks worker-reboot [-f][--hard] --cluster CLUSTER --worker WORKER [WORKER][-s]
{: #cs_worker_reboot}

Riavvia un nodo di lavoro in un cluster. Durante il riavvio, lo stato del tuo nodo di lavoro non cambia. Ad esempio, potresti utilizzare un riavvio se lo stato del nodo di lavoro nell'infrastruttura IBM Cloud (SoftLayer) è `Powered Off` e hai bisogno di attivare il nodo di lavoro.

**Attenzione:** il riavvio di un nodo di lavoro può causare il danneggiamento dei dati sul nodo di lavoro. Utilizza questo comando con cautela e quando sai che un riavvio può aiutare a ripristinare il tuo nodo di lavoro. In tutti gli altri casi, [ricarica il tuo nodo di lavoro](#cs_worker_reload).

Prima di riavviare il tuo nodo di lavoro, assicurati che i pod vengano ripianificati su altri nodi di lavoro per evitare un periodo di inattività per la tua applicazione o il danneggiamento dei dati sul nodo di lavoro.

1. Elenca tutti i nodi di lavoro presenti nel tuo cluster e prendi nota del **nome** del nodo di lavoro che vuoi riavviare.
   ```
   kubectl get nodes
   ```
   Il **nome** che viene restituito in questo comando è l'indirizzo IP privato che è assegnato al tuo nodo di lavoro. Puoi trovare ulteriori informazioni sul tuo nodo di lavoro quando esegui il comando `ibmcloud ks workers <cluster_name_or_ID>` e cerchi il nodo di lavoro con lo stesso indirizzo **IP privato**.
2. Contrassegna il nodo di lavoro come non pianificabile in un processo noto come delimitazione. Quando delimiti un nodo di lavoro, lo rendi non disponibile per una futura pianificazione di pod. Utilizza il **nome** del nodo di lavoro che hai recuperato nel passo precedente.
   ```
   kubectl cordon <worker_name>
   ```
   {: pre}

3. Verifica che la pianificazione di pod sia disabilitata per il tuo nodo di lavoro.
   ```
   kubectl get nodes
   ```
   {: pre}
   Il tuo nodo di lavoro è disabilitato per la pianificazione di pod se lo stato visualizza **SchedulingDisabled**.
 4. Forza la rimozione dei pod dal tuo nodo di lavoro e la loro ripianificazione sui nodi di lavoro rimanenti nel cluster.
    ```
    kubectl drain <worker_name>
    ```
    {: pre}
    Questo processo può richiedere qualche minuto.
 5. Riavvia il nodo di lavoro. Utilizza l'ID nodo di lavoro restituito dal comando `ibmcloud ks workers <cluster_name_or_ID>`.
    ```
    ibmcloud ks worker-reboot --cluster <cluster_name_or_ID> --worker <worker_name_or_ID>
    ```
    {: pre}
 6. Attendi circa 5 minuti prima di rendere disponibile il tuo nodo di lavoro per la pianificazione di pod per assicurarti che il riavvio sia terminato. Durante il riavvio, lo stato del tuo nodo di lavoro non cambia. Il riavvio di un nodo di lavoro viene in genere completato in pochi secondi.
 7. Rendi disponibile il tuo nodo di lavoro per la pianificazione di pod. Utilizza il **nome** del tuo nodo di lavoro restituito dal comando `kubectl get nodes`.
    ```
    kubectl uncordon <worker_name>
    ```
    {: pre}
    </br>

<strong>Opzioni comando</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Il nome o l'ID del cluster. Questo valore è obbligatorio.</dd>

   <dt><code>-f</code></dt>
   <dd>Utilizza questa opzione per forzare il riavvio del nodo di lavoro senza richiedere l'intervento dell'utente. Questo valore è facoltativo.</dd>

   <dt><code>--hard</code></dt>
   <dd>Utilizza questa opzione per effettuare un riavvio forzato di un nodo di lavoro togliendo l'alimentazione al nodo di lavoro. Utilizza questa opzione se il nodo di lavoro non risponde o se il runtime del contenitore del nodo di lavoro non risponde. Questo valore è facoltativo.</dd>

   <dt><code>--worker <em>WORKER</em></code></dt>
   <dd>Il nome o l'ID di uno o più nodi di lavoro. Utilizza uno spazio per elencare più nodi di lavoro. Questo valore è obbligatorio.</dd>

   <dt><code>-s</code></dt>
   <dd>Non visualizza il messaggio dei promemoria di aggiornamento o del giorno. Questo valore è facoltativo.</dd>
   </dl>

**Esempio**:

  ```
  ibmcloud ks worker-reboot --cluster my_cluster --worker kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w1 kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w2
  ```
  {: pre}


### ibmcloud ks worker-reload [-f] --cluster CLUSTER --worker WORKER [WORKER][-s]
{: #cs_worker_reload}

Ricarica tutte le configurazioni necessarie per un nodo di lavoro. Un ricaricamento può essere utile se il tuo nodo di lavoro riscontra dei problemi, come prestazioni scarse o se il nodo di lavoro è bloccato in uno stato non integro.

Il ricaricamento di un nodo di lavoro viene applicato agli aggiornamenti della versione patch per il tuo nodo di lavoro, ma non per aggiornamenti maggiori o minori. Per visualizzare le modifiche da un versione patch alla successiva, controlla la documentazione [Changelog versione](cs_versions_changelog.html#changelog).
{: tip}

Prima di ricaricare il tuo nodo di lavoro, assicurati che i pod vengano ripianificati su altri nodi di lavoro per evitare un periodo di inattività per la tua applicazione o il danneggiamento dei dati sul nodo di lavoro.

1. Elenca tutti i nodi di lavoro presenti nel tuo cluster e prendi nota del **nome** del nodo di lavoro che vuoi ricaricare.
   ```
   kubectl get nodes
   ```
   Il **nome** che viene restituito in questo comando è l'indirizzo IP privato che è assegnato al tuo nodo di lavoro. Puoi trovare ulteriori informazioni sul tuo nodo di lavoro quando esegui il comando `ibmcloud ks workers <cluster_name_or_ID>` e cerchi il nodo di lavoro con lo stesso indirizzo **IP privato**.
2. Contrassegna il nodo di lavoro come non pianificabile in un processo noto come delimitazione. Quando delimiti un nodo di lavoro, lo rendi non disponibile per una futura pianificazione di pod. Utilizza il **nome** del nodo di lavoro che hai recuperato nel passo precedente.
   ```
   kubectl cordon <worker_name>
   ```
   {: pre}

3. Verifica che la pianificazione di pod sia disabilitata per il tuo nodo di lavoro.
   ```
   kubectl get nodes
   ```
   {: pre}
   Il tuo nodo di lavoro è disabilitato per la pianificazione di pod se lo stato visualizza **SchedulingDisabled**.
 4. Forza la rimozione dei pod dal tuo nodo di lavoro e la loro ripianificazione sui nodi di lavoro rimanenti nel cluster.
    ```
    kubectl drain <worker_name>
    ```
    {: pre}
    Questo processo può richiedere qualche minuto.
 5. Ricarica il nodo di lavoro. Utilizza l'ID nodo di lavoro restituito dal comando `ibmcloud ks workers <cluster_name_or_ID>`.
    ```
    ibmcloud ks worker-reload --cluster <cluster_name_or_ID> --worker <worker_name_or_ID>
    ```
    {: pre}
 6. Attendi il termine del ricaricamento.
 7. Rendi disponibile il tuo nodo di lavoro per la pianificazione di pod. Utilizza il **nome** del tuo nodo di lavoro restituito dal comando `kubectl get nodes`.
    ```
    kubectl uncordon <worker_name>
    ```
</br>
<strong>Opzioni comando</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Il nome o l'ID del cluster. Questo valore è obbligatorio.</dd>

   <dt><code>-f</code></dt>
   <dd>Utilizza questa opzione per forzare il ricaricamento di un nodo di lavoro senza richiedere l'intervento dell'utente. Questo valore è facoltativo.</dd>

   <dt><code>--worker <em>WORKER</em></code></dt>
   <dd>Il nome o l'ID di uno o più nodi di lavoro. Utilizza uno spazio per elencare più nodi di lavoro. Questo valore è obbligatorio.</dd>

   <dt><code>-s</code></dt>
   <dd>Non visualizza il messaggio dei promemoria di aggiornamento o del giorno. Questo valore è facoltativo.</dd>
   </dl>

**Esempio**:

  ```
  ibmcloud ks worker-reload --cluster my_cluster --worker kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w1 kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w2
  ```
  {: pre}


### ibmcloud ks worker-rm [-f] --cluster CLUSTER --workers WORKER[,WORKER][-s]
{: #cs_worker_rm}

Rimuovere uno o più nodi di lavoro da un cluster. Se rimuovi un nodo di lavoro, il tuo cluster perde il bilanciamento. Puoi bilanciare automaticamente di nuovo il tuo pool di nodi di lavoro eseguendo il [comando](#cs_rebalance) `ibmcloud ks worker-pool-rebalance`.

Prima di rimuovere il tuo nodo di lavoro, assicurati che i pod vengano ripianificati su altri nodi di lavoro per evitare un periodo di inattività per la tua applicazione o il danneggiamento dei dati sul nodo di lavoro.
{: tip}

1. Elenca tutti i nodi di lavoro presenti nel tuo cluster e prendi nota del **nome** del nodo di lavoro che vuoi rimuovere.
   ```
   kubectl get nodes
   ```
   Il **nome** che viene restituito in questo comando è l'indirizzo IP privato che è assegnato al tuo nodo di lavoro. Puoi trovare ulteriori informazioni sul tuo nodo di lavoro quando esegui il comando `ibmcloud ks workers <cluster_name_or_ID>` e cerchi il nodo di lavoro con lo stesso indirizzo **IP privato**.
2. Contrassegna il nodo di lavoro come non pianificabile in un processo noto come delimitazione. Quando delimiti un nodo di lavoro, lo rendi non disponibile per una futura pianificazione di pod. Utilizza il **nome** del nodo di lavoro che hai recuperato nel passo precedente.
   ```
   kubectl cordon <worker_name>
   ```
   {: pre}

3. Verifica che la pianificazione di pod sia disabilitata per il tuo nodo di lavoro.
   ```
   kubectl get nodes
   ```
   {: pre}
   Il tuo nodo di lavoro è disabilitato per la pianificazione di pod se lo stato visualizza **SchedulingDisabled**.
4. Forza la rimozione dei pod dal tuo nodo di lavoro e la loro ripianificazione sui nodi di lavoro rimanenti nel cluster.
   ```
   kubectl drain <worker_name>
   ```
   {: pre}
   Questo processo può richiedere qualche minuto.
5. Rimuovi il nodo di lavoro. Utilizza l'ID nodo di lavoro restituito dal comando `ibmcloud ks workers <cluster_name_or_ID>`.
   ```
   ibmcloud ks worker-rm --cluster <cluster_name_or_ID> --worker <worker_name_or_ID>
   ```
   {: pre}

6. Verifica che il nodo di lavoro venga rimosso.
   ```
   ibmcloud ks workers --cluster <cluster_name_or_ID>
   ```
</br>
<strong>Opzioni comando</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Il nome o l'ID del cluster. Questo valore è obbligatorio.</dd>

   <dt><code>-f</code></dt>
   <dd>Utilizza questa opzione per forzare la rimozione di un nodo di lavoro senza richiedere l'intervento dell'utente. Questo valore è facoltativo.</dd>

   <dt><code>--workers <em>WORKER</em></code></dt>
   <dd>Il nome o l'ID di uno o più nodi di lavoro. Utilizza uno spazio per elencare più nodi di lavoro. Questo valore è obbligatorio.</dd>

   <dt><code>-s</code></dt>
   <dd>Non visualizza il messaggio dei promemoria di aggiornamento o del giorno. Questo valore è facoltativo.</dd>
   </dl>

**Esempio**:

  ```
  ibmcloud ks worker-rm --cluster my_cluster --workers kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w1 kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w2
  ```
  {: pre}


### ibmcloud ks worker-update [-f] --cluster CLUSTER --workers WORKER[,WORKER][--kube-version MAJOR.MINOR.PATCH] [--force-update][-s]
{: #cs_worker_update}

Aggiorna i nodi di lavoro per applicare le patch e gli aggiornamenti di sicurezza più recenti al sistema operativo e per aggiornare la versione Kubernetes in modo che corrisponda a quella del nodo master. Puoi aggiornare la versione Kubernetes del nodo master con il [comando](cs_cli_reference.html#cs_cluster_update) `ibmcloud ks cluster-update`.

**Importante**: l'esecuzione di `ibmcloud ks worker-update` può causare tempi di inattività per le tue applicazioni e i tuoi servizi. Durante l'aggiornamento, tutti i pod vengono ripianificati in altri nodi di lavoro e i dati vengono eliminati se non archiviati al di fuori del pod. Per evitare il tempo di inattività, [assicurati di avere abbastanza nodi di lavoro per gestire il carico di lavoro mentre vengono aggiornati i nodi di lavoro selezionati](cs_cluster_update.html#worker_node).

Potresti dover modificare i tuoi file YAML per le distribuzioni prima dell'aggiornamento. Controlla questa [nota sulla release](cs_versions.html) per i dettagli.

<strong>Opzioni comando</strong>:

   <dl>

   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Il nome o l'ID del cluster in cui elenchi i nodi di lavoro disponibili. Questo valore è obbligatorio.</dd>

   <dt><code>-f</code></dt>
   <dd>Utilizza questa opzione per forzare l'aggiornamento del master senza richiedere l'intervento dell'utente. Questo valore è facoltativo.</dd>

   <dt><code>--force-update</code></dt>
   <dd>Tenta l'aggiornamento anche se la modifica è maggiore di due versioni secondarie. Questo valore è facoltativo.</dd>

   <dt><code>--kube-version <em>MAJOR.MINOR.PATCH</em></code></dt>
     <dd>La versione di Kubernetes con cui vuoi vengano aggiornati i tuoi nodi di lavoro. Viene utilizzata la versione predefinita se questo valore non viene specificato.</dd>

   <dt><code>--workers <em>WORKER</em></code></dt>
   <dd>L'ID di uno o più nodi di lavoro. Utilizza uno spazio per elencare più nodi di lavoro. Questo valore è obbligatorio.</dd>

   <dt><code>-s</code></dt>
   <dd>Non visualizza il messaggio dei promemoria di aggiornamento o del giorno. Questo valore è facoltativo.</dd>

   </dl>

**Esempio**:

  ```
  ibmcloud ks worker-update --cluster my_cluster --worker kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w1 kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w2
  ```
  {: pre}

### ibmcloud ks workers --cluster CLUSTER [--worker-pool POOL][--show-pools] [--show-deleted][--json] [-s]
{: #cs_workers}

Visualizzare un elenco di nodi di lavoro e lo stato di ciascun cluster.

<strong>Opzioni comando</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Il nome o l'ID del cluster dei nodi di lavoro disponibili. Questo valore è obbligatorio.</dd>

   <dt><code>--worker-pool <em>POOL</em></code></dt>
   <dd>Visualizza solo i nodi di lavoro che appartengono al pool di nodi di lavoro. Per elencare i pool di nodi di lavoro disponibili, esegui `ibmcloud ks worker-pools --cluster <cluster_name_or_ID>`. Questo valore è facoltativo.</dd>

   <dt><code>--show-pools</code></dt>
   <dd>Elenca il pool di nodi di lavoro a cui appartiene ciascun nodo di lavoro. Questo valore è facoltativo.</dd>

   <dt><code>--show-deleted</code></dt>
   <dd>Visualizza i nodi di lavoro che sono stati eliminati dal cluster, incluso il motivo dell'eliminazione. Questo valore è facoltativo.</dd>

   <dt><code>--json</code></dt>
   <dd>Stampa l'output del comando in formato JSON. Questo valore è facoltativo.</dd>

  <dt><code>-s</code></dt>
  <dd>Non visualizza il messaggio dei promemoria di aggiornamento o del giorno. Questo valore è facoltativo.</dd>
   </dl>

**Esempio**:

  ```
  ibmcloud ks workers --cluster my_cluster
  ```
  {: pre}

<br />


## Comandi pool di nodi di lavoro
{: #worker-pool}

### ibmcloud ks worker-pool-create --name POOL_NAME --cluster CLUSTER --machine-type MACHINE_TYPE --size-per-zone WORKERS_PER_ZONE [--hardware ISOLATION][--labels LABELS] [--disable-disk-encrypt][-s] [--json]
{: #cs_worker_pool_create}

Puoi creare un pool di nodi di lavoro nel tuo cluster. Quando aggiungi un pool di nodi di lavoro, per impostazione predefinita, non viene assegnata una zona. Specifica il numero di nodi di lavoro che desideri in ciascuna zona e i tipi di macchina per i nodi di lavoro. Al pool di nodi di lavoro vengono fornite le versioni Kubernetes predefinite. Per terminare la creazione dei nodi di lavoro, [aggiungi una zona o le zone](#cs_zone_add) al tuo pool.

<strong>Opzioni comando</strong>:
<dl>

  <dt><code>--name <em>POOL_NAME</em></code></dt>
    <dd>Il nome che desideri utilizzare per il tuo pool di nodi di lavoro.</dd>

  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>Il nome o l'ID del cluster. Questo valore è obbligatorio.</dd>

  <dt><code>--machine-type <em>MACHINE_TYPE</em></code></dt>
    <dd>Scegli un tipo di macchina. Puoi distribuire i tuoi nodi di lavoro come macchine virtuali su hardware condiviso o dedicato o come macchine fisiche su bare metal. I tipi di macchine fisiche e virtuali disponibili variano in base alla zona in cui distribuisci il cluster. Per ulteriori informazioni, consulta la documentazione per il [comando](cs_cli_reference.html#cs_machine_types) `ibmcloud ks machine-types`. Questo valore è obbligatorio per i cluster standard e non è disponibile per i cluster gratuiti.</dd>

  <dt><code>--size-per-zone <em>WORKERS_PER_ZONE</em></code></dt>
    <dd>Il numero di nodi di lavoro da creare in ogni zona. Questo valore è obbligatorio e deve essere pari a 1 o superiore. </dd>

  <dt><code>--hardware <em>HARDWARE</em></code></dt>
    <dd>Il livello di isolamento hardware per il nodo di lavoro. Utilizza dedicato se vuoi avere risorse fisiche dedicate disponibili solo per te o condiviso per consentire la condivisione delle risorse fisiche con altri clienti IBM. L'impostazione predefinita è condiviso. Questo valore è facoltativo.</dd>

  <dt><code>--labels <em>LABELS</em></code></dt>
    <dd>Le etichette che vuoi assegnare ai nodi di lavoro nel tuo pool. Esempio: <key1>=<val1>,<key2>=<val2></dd>

  <dt><code>--diable-disk-encrpyt</code></dt>
    <dd>Specifica che il disco non è crittografato. Il valore predefinito è <code>false</code>.</dd>

  <dt><code>--json</code></dt>
    <dd>Stampa l'output del comando in formato JSON. Questo valore è facoltativo.</dd>

  <dt><code>-s</code></dt>
    <dd>Non visualizza il messaggio dei promemoria di aggiornamento o del giorno. Questo valore è facoltativo.</dd>
</dl>

**Comando di esempio**:

  ```
  ibmcloud ks worker-pool-create --name my_pool --cluster my_cluster --machine-type b2c.4x16 --size-per-zone 6
  ```
  {: pre}

### ibmcloud ks worker-pool-get --worker-pool WORKER_POOL --cluster CLUSTER [-s][--json]
{: #cs_worker_pool_get}

Visualizza i dettagli di un pool di nodi di lavoro.

<strong>Opzioni comando</strong>:

<dl>
  <dt><code>--worker-pool <em>WORKER_POOL</em></code></dt>
    <dd>Il nome del pool del nodo di lavoro di cui vuoi visualizzare i dettagli. Per elencare i pool di nodi di lavoro disponibili, esegui `ibmcloud ks worker-pools --cluster <cluster_name_or_ID>`. Questo valore è obbligatorio.</dd>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>Il nome o l'ID del cluster in cui si trova il pool di nodi di lavoro. Questo valore è obbligatorio.</dd>

  <dt><code>--json</code></dt>
    <dd>Stampa l'output del comando in formato JSON. Questo valore è facoltativo.</dd>

  <dt><code>-s</code></dt>
    <dd>Non visualizza il messaggio dei promemoria di aggiornamento o del giorno. Questo valore è facoltativo.</dd>
</dl>

**Comando di esempio**:

  ```
  ibmcloud ks worker-pool-get --worker-pool pool1 --cluster my_cluster
  ```
  {: pre}

**Output di esempio**:

  ```
  Name:               pool
  ID:                 a1a11b2222222bb3c33c3d4d44d555e5-f6f777g
  State:              active
  Hardware:           shared
  Zones:              dal10,dal12
  Workers per zone:   3
  Machine type:       b2c.4x16.encrypted
  Labels:             -
  Version:            1.10.7_1512
  ```
  {: screen}

### ibmcloud ks worker-pool-rebalance --cluster CLUSTER --worker-pool WORKER_POOL [-s]
{: #cs_rebalance}

Puoi bilanciare di nuovo il tuo pool di nodi di lavoro dopo aver eliminato un nodo di lavoro. Quando esegui questo comando, vengono aggiunti nuovi nodi di lavoro al tuo pool di nodi di lavoro. 

<strong>Opzioni comando</strong>:

<dl>
  <dt><code><em>--cluster CLUSTER</em></code></dt>
    <dd>Il nome o l'ID del cluster. Questo valore è obbligatorio.</dd>
  <dt><code><em>--worker-pool WORKER_POOL</em></code></dt>
    <dd>Il pool di nodi di lavoro che desideri bilanciare di nuovo. Questo valore è obbligatorio.</dd>
  <dt><code>-s</code></dt>
    <dd>Non visualizza il messaggio dei promemoria di aggiornamento o del giorno. Questo valore è facoltativo.</dd>
</dl>

**Esempio**:

  ```
  ibmcloud ks worker-pool-rebalance --cluster my_cluster --worker-pool my_pool
  ```
  {: pre}

### ibmcloud ks worker-pool-resize --worker-pool WORKER_POOL --cluster CLUSTER --size-per-zone WORKERS_PER_ZONE [-s]
{: #cs_worker_pool_resize}

Ridimensiona il tuo pool di nodi di lavoro per aumentare o diminuire il numero di nodi di lavoro presenti in ogni zona del tuo cluster. Il tuo pool di nodi di lavoro deve avere almeno 1 nodo di lavoro.

<strong>Opzioni comando</strong>:

<dl>
  <dt><code>--worker-pool <em>WORKER_POOL</em></code></dt>
    <dd>Il nome del pool del nodo di lavoro che vuoi aggiornare. Questo valore è obbligatorio.</dd>

  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>Il nome o l'ID del cluster per cui vuoi ridimensionare i pool di nodi di lavoro. Questo valore è obbligatorio.</dd>

  <dt><code>--size-per-zone <em>WORKERS_PER_ZONE</em></code></dt>
    <dd>Il numero di nodi di lavoro che vuoi avere in ciascuna zona. Questo valore è obbligatorio e deve essere pari a 1 o superiore. </dd>

  <dt><code>-s</code></dt>
    <dd>Non visualizza il messaggio dei promemoria di aggiornamento o del giorno. Questo valore è facoltativo.</dd>

</dl>

**Comando di esempio**:

  ```
  ibmcloud ks worker-pool-resize --cluster my_cluster --worker-pool my_pool --size-per-zone 3
  ```
  {: pre}

### ibmcloud ks worker-pool-rm --worker-pool WORKER_POOL --cluster CLUSTER [-s]
{: #cs_worker_pool_rm}

Rimuovi un pool di nodi di lavoro dal tuo cluster. Tutti i nodi di lavoro nel pool vengono eliminati. I tuoi pod vengono ripianificati quando esegui un'eliminazione. Per evitare tempi di inattività, assicurati di avere abbastanza nodi di lavoro per eseguire il tuo carico di lavoro.

<strong>Opzioni comando</strong>:

<dl>
  <dt><code>--worker-pool <em>WORKER_POOL</em></code></dt>
    <dd>Il nome del pool del nodo di lavoro che vuoi rimuovere. Questo valore è obbligatorio.</dd>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>Il nome o l'ID del cluster da cui desideri rimuovere il pool di nodi di lavoro. Questo valore è obbligatorio.</dd>
  <dt><code>-s</code></dt>
    <dd>Non visualizza il messaggio dei promemoria di aggiornamento o del giorno. Questo valore è facoltativo.</dd>
</dl>

**Comando di esempio**:

  ```
  ibmcloud ks worker-pool-rm --cluster my_cluster --worker-pool pool1
  ```
  {: pre}

### ibmcloud ks worker-pools --cluster CLUSTER [--json][-s]
{: #cs_worker_pools}

Visualizza i pool di nodi di lavoro che hai in un cluster.

<strong>Opzioni comando</strong>:

<dl>
  <dt><code>--cluster <em>CLUSTER_NAME_OR_ID</em></code></dt>
    <dd>Il nome o l'ID del cluster per cui vuoi elencare i pool di nodi di lavoro. Questo valore è obbligatorio.</dd>
  <dt><code>--json</code></dt>
    <dd>Stampa l'output del comando in formato JSON. Questo valore è facoltativo.</dd>
  <dt><code>-s</code></dt>
    <dd>Non visualizza il messaggio dei promemoria di aggiornamento o del giorno. Questo valore è facoltativo.</dd>
</dl>

**Comando di esempio**:

  ```
  ibmcloud ks worker-pools --cluster my_cluster
  ```
  {: pre}

### ibmcloud ks zone-add --zone ZONE --cluster CLUSTER --worker-pools WORKER_POOL1[,WORKER_POOL2] --private-vlan PRIVATE_VLAN [--public-vlan PUBLIC_VLAN][--private-only] [--json][-s]
{: #cs_zone_add}

**Solo cluster multizona**: una volta creato un cluster o un pool di nodi di lavoro, puoi aggiungere una zona. Quando aggiungi una zona, i nodi di lavoro vengono aggiunti alla nuova zona in modo da corrispondere al numero di nodi di lavoro per zona che hai specificato per il pool di nodi di lavoro. 

<strong>Opzioni comando</strong>:

<dl>
  <dt><code>--zone <em>ZONE</em></code></dt>
    <dd>La zona che desideri aggiungere. Deve essere una [zona che supporta il multizona](cs_regions.html#zones) all'interno della regione del cluster. Questo valore è obbligatorio.</dd>

  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>Il nome o l'ID del cluster. Questo valore è obbligatorio.</dd>

  <dt><code>--worker-pool <em>WORKER_POOLS</em></code></dt>
    <dd>Un elenco separato da virgole dei pool di nodi di lavoro a cui viene aggiunta la zona. È necessario almeno 1 pool di nodi di lavoro.</dd>

  <dt><code>--private-vlan <em>PRIVATE_VLAN</em></code></dt>
    <dd><p>L'ID della VLAN privata. Questo valore è condizionato.</p>
    <p>Se hai una VLAN privata nella zona, questo valore deve corrispondere all'ID VLAN privata di uno o più nodi di lavoro nel cluster. Per vedere le VLAN disponibili, esegui <code>ibmcloud ks cluster-get --cluster &lt;cluster&gt; --showResources</code>.</p>
    <p>Se non hai una VLAN privata o pubblica in tale zona, non specificare questa opzione. Vengono create automaticamente per te una VLAN privata e una pubblica quando aggiungi inizialmente una nuova zona al tuo pool di nodi di lavoro. </p>
    <p>Se hai più VLAN per un cluster, più sottoreti sulla stessa VLAN o un cluster multizona, devi abilitare lo [spanning della VLAN](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) per il tuo account dell'infrastruttura IBM Cloud (SoftLayer) in modo che i tuoi nodi di lavoro possano comunicare tra loro sulla rete privata. Per eseguire questa azione, ti serve l'[autorizzazione dell'infrastruttura](cs_users.html#infra_access) **Rete > Gestisci il VLAN Spanning di rete** oppure puoi richiedere al proprietario dell'account di abilitarlo. Per controllare se lo spanning di VLAN è già abilitato, usa il [comando](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`.Se stai utilizzando {{site.data.keyword.BluDirectLink}}, devi invece utilizzare una [VRF (Virtual Router Function)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf). Per abilitare la VRF, contatta il tuo rappresentante dell'account dell'infrastruttura IBM Cloud (SoftLayer).</p>
<p>**Nota**: i nuovi nodi di lavoro vengono aggiunti alle VLAN che hai specificato, ma le VLAN per i nodi di lavoro esistenti non vengono modificate.</p></dd>

  <dt><code>--public-vlan <em>PUBLIC_VLAN</em></code></dt>
    <dd><p>L'ID della VLAN pubblica. Questo valore è obbligatorio se desideri esporre i carichi di lavoro sui nodi al pubblico una volta che hai creato il cluster. Deve corrispondere all'ID VLAN pubblica di uno o più nodi di lavoro nel cluster per la zona. Per vedere le VLAN disponibili, esegui <code>ibmcloud ks cluster-get --cluster &lt;cluster&gt; --showResources</code>.</p>
    <p>Se non hai una VLAN privata o pubblica in tale zona, non specificare questa opzione. Vengono create automaticamente per te una VLAN privata e una pubblica quando aggiungi inizialmente una nuova zona al tuo pool di nodi di lavoro. </p>
    <p>Se hai più VLAN per un cluster, più sottoreti sulla stessa VLAN o un cluster multizona, devi abilitare lo [spanning della VLAN](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) per il tuo account dell'infrastruttura IBM Cloud (SoftLayer) in modo che i tuoi nodi di lavoro possano comunicare tra loro sulla rete privata. Per eseguire questa azione, ti serve l'[autorizzazione dell'infrastruttura](cs_users.html#infra_access) **Rete > Gestisci il VLAN Spanning di rete** oppure puoi richiedere al proprietario dell'account di abilitarlo. Per controllare se lo spanning di VLAN è già abilitato, usa il [comando](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`.Se stai utilizzando {{site.data.keyword.BluDirectLink}}, devi invece utilizzare una [VRF (Virtual Router Function)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf). Per abilitare la VRF, contatta il tuo rappresentante dell'account dell'infrastruttura IBM Cloud (SoftLayer).</p>
    <p>**Nota**: i nuovi nodi di lavoro vengono aggiunti alle VLAN che hai specificato, ma le VLAN per i nodi di lavoro esistenti non vengono modificate.</p></dd>

  <dt><code>--private-only </code></dt>
    <dd>Utilizza questa opzione per impedire la creazione di una VLAN pubblica. Obbligatoria solo quando specifichi l'indicatore `--private-vlan` e non includi l'indicatore `--public-vlan`.  **Nota**: se vuoi un cluster solamente privato, devi configurare un'applicazione gateway per la connettività di rete. Per ulteriori informazioni, vedi [Pianificazione di una rete esterna privata per la configurazione di solo una VLAN privata](cs_network_planning.html#private_vlan).</dd>

  <dt><code>--json</code></dt>
    <dd>Stampa l'output del comando in formato JSON. Questo valore è facoltativo.</dd>

  <dt><code>-s</code></dt>
    <dd>Non visualizza il messaggio dei promemoria di aggiornamento o del giorno. Questo valore è facoltativo.</dd>
</dl>

**Esempio**:

  ```
  ibmcloud ks zone-add --zone dal10 --cluster my_cluster --worker-pools pool1,pool2,pool3 --private-vlan 2294021
  ```
  {: pre}

  ### ibmcloud ks zone-network-set --zone ZONE --cluster CLUSTER --worker-pools WORKER_POOL1[,WORKER_POOL2] --private-vlan PRIVATE_VLAN [--public-vlan PUBLIC_VLAN][-f] [-s]
  {: #cs_zone_network_set}

  **Solo cluster multizona**: imposta i metadati di rete per un pool di nodi di lavoro per utilizzare una VLAN pubblica o privata diversa per la zona rispetto a quella utilizzata in precedenza. I nodi di lavoro che sono stati già creati nel pool continuano ad utilizzare la VLAN pubblica o privata precedente, ma i nuovi nodi di lavoro nel pool utilizzeranno i nuovi dati di rete.

  I router della VLAN privata iniziano sempre con <code>bcr</code> (router back-end) e i router della VLAN pubblica iniziano sempre con <code>fcr</code> (router front-end). Quando crei un cluster e specifichi le VLAN private e pubbliche, la combinazione di numero e lettera dopo tali prefissi deve corrispondere.
  <ol><li>Controlla le VLAN che sono disponibili nel tuo cluster. <pre class="pre"><code>ibmcloud ks cluster-get --cluster &lt;cluster_name_or_ID&gt; --showResources</code></pre><p>Output di esempio:</p>
  <pre class="screen"><code>Subnet VLANs
VLAN ID   Subnet CIDR         Public   User-managed
229xxxx   169.xx.xxx.xxx/29   true     false
229xxxx   10.xxx.xx.x/29      false    false</code></pre></li>
  <li>Controlla che gli ID VLAN pubblici e privati che vuoi utilizzare siano compatibili. Per essere compatibili, il <strong>Router</strong> deve avere lo stesso ID pod.<pre class="pre"><code>ibmcloud ks vlans --zone &lt;zone&gt;</code></pre><p>Output di esempio:</p>
  <pre class="screen"><code>ID        Name   Number   Type      Router         Supports Virtual Workers
229xxxx          1234     private   bcr01a.dal12   true
229xxxx          5678     public    fcr01a.dal12   true</code></pre><p>Nota che gli ID pod <strong>Router</strong> corrispondono: `01a` e `01a`. Se un ID pod fosse `01a` e l'altro `02a`, non potresti impostare questi ID VLAN pubblici e privati per il tuo pool di nodi di lavoro.</p></li>
  <li>Se non hai alcuna VLAN disponibile, puoi <a href="/docs/infrastructure/vlans/order-vlan.html#order-vlans">ordinare delle nuove VLAN</a>.</li></ol>

  <strong>Opzioni comando</strong>:

  <dl>
    <dt><code>--zone <em>ZONE</em></code></dt>
      <dd>La zona che desideri aggiungere. Deve essere una [zona che supporta il multizona](cs_regions.html#zones) all'interno della regione del cluster. Questo valore è obbligatorio.</dd>

  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>Il nome o l'ID del cluster. Questo valore è obbligatorio.</dd>

  <dt><code>--worker-pool <em>WORKER_POOLS</em></code></dt>
    <dd>Un elenco separato da virgole dei pool di nodi di lavoro a cui viene aggiunta la zona. È necessario almeno 1 pool di nodi di lavoro.</dd>

  <dt><code>--private-vlan <em>PRIVATE_VLAN</em></code></dt>
    <dd>L'ID della VLAN privata. Questo valore è obbligatorio, indipendentemente dal fatto che tu voglia utilizzare lo stesso VLAN privato oppure uno differente da quello che hai usato per gli altri tuoi nodi di lavoro. <br><br><strong>Importante</strong>: i VLAN privati e pubblici devono essere compatibili, cosa che puoi determinare dal prefisso ID **Router**.<br><br>**Nota**: i nuovi nodi di lavoro vengono aggiunti alle VLAN che hai specificato, ma le VLAN per i nodi di lavoro esistenti non vengono modificate.</dd>

  <dt><code>--public-vlan <em>PUBLIC_VLAN</em></code></dt>
    <dd>L'ID della VLAN pubblica. Questo valore è obbligatorio solo se vuoi modificare la VLAN pubblica per la zona. Per modificare la VLAN pubblica, devi sempre fornire una VLAN privata compatibile.<br><br><strong>Importante</strong>: i VLAN privati e pubblici devono essere compatibili, cosa che puoi determinare dal prefisso ID **Router**.<br><br>**Nota**: i nuovi nodi di lavoro vengono aggiunti alle VLAN che hai specificato, ma le VLAN per i nodi di lavoro esistenti non vengono modificate.</dd>

  <dt><code>-f</code></dt>
    <dd>Forza l'esecuzione del comando senza richiedere l'intervento dell'utente. Questo valore è facoltativo.</dd>

  <dt><code>-s</code></dt>
    <dd>Non visualizza il messaggio dei promemoria di aggiornamento o del giorno. Questo valore è facoltativo.</dd>
  </dl>

  **Esempio**:

  ```
  ibmcloud ks zone-network-set --zone dal10 --cluster my_cluster --worker-pools pool1,pool2,pool3 --private-vlan 2294021
  ```
  {: pre}

### ibmcloud ks zone-rm --zone ZONE --cluster CLUSTER [-f][-s]
{: #cs_zone_rm}

**Solo cluster multizona**: rimuovi una zona da tutti i pool di nodi di lavoro nel tuo cluster. Tutti i nodi di lavoro nel pool di nodi di lavoro per questa zona vengono eliminati.

Prima di rimuovere una zona, assicurati di avere nodi di lavoro sufficienti in altre zone nel cluster in modo che i tuoi pod possano essere ripianificati per evitare un periodo di inattività per la tua applicazione o il danneggiamento dei dati sul nodo di lavoro.
{: tip}

<strong>Opzioni comando</strong>:

<dl>
  <dt><code>--zone <em>ZONE</em></code></dt>
    <dd>La zona che desideri aggiungere. Deve essere una [zona che supporta il multizona](cs_regions.html#zones) all'interno della regione del cluster. Questo valore è obbligatorio.</dd>

  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>Il nome o l'ID del cluster. Questo valore è obbligatorio.</dd>

  <dt><code>-f</code></dt>
    <dd>Forza l'aggiornamento senza richiedere l'intervento dell'utente. Questo valore è facoltativo.</dd>

  <dt><code>-s</code></dt>
    <dd>Non visualizza il messaggio dei promemoria di aggiornamento o del giorno. Questo valore è facoltativo.</dd>
</dl>

**Esempio**:

  ```
  ibmcloud ks zone-rm --zone dal10 --cluster my_cluster
  ```
  {: pre}
