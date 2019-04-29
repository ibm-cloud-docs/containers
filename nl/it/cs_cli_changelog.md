---

copyright:
  years: 2014, 2019
lastupdated: "2019-03-21"

keywords: kubernetes, iks

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



# Changelog della CLI
{: #cs_cli_changelog}

Nel terminale, ricevi una notifica quando sono disponibili degli aggiornamenti ai plugin e alla CLI `ibmcloud`. Assicurati di mantenere la tua CLI aggiornata in modo che tu possa utilizzare tutti i comandi e gli indicatori disponibili.
{:shortdesc}

Per installare il plugin della CLI {{site.data.keyword.containerlong}}, vedi [Installazione della CLI](/docs/containers?topic=containers-cs_cli_install#cs_cli_install_steps).

Fai riferimento alla seguente tabella per un riepilogo delle modifiche per ogni versione del plugin della CLI {{site.data.keyword.containerlong_notm}}.

<table summary="Panoramica delle modifiche alla versione per il plugin della CLI {{site.data.keyword.containerlong_notm}} ">
<caption>Changelog per il plugin della CLI {{site.data.keyword.containerlong_notm}}</caption>
<thead>
<tr>
<th>Versione</th>
<th>Data di rilascio</th>
<th>Modifiche</th>
</tr>
</thead>
<tbody>
<tr>
<td>0.2.80</td>
<td>19 marzo 2019</td>
<td><ul>
<li>Aggiunge il supporto per l'abilitazione delle [comunicazioni tra master e nodi di lavoro con gli endpoint del servizio](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master) nei cluster standard che eseguono Kubernetes versione 1.11 o successiva in [account abilitati per VRF](/docs/services/service-endpoint?topic=services/service-endpoint-getting-started#getting-started). Per informazioni su come utilizzare i seguenti comandi, vedi [Configurazione dell'endpoint del servizio privato](/docs/containers?topic=containers-cs_network_cluster#set-up-private-se) e [Configurazione dell'endpoint del servizio pubblico](/docs/containers?topic=containers-cs_network_cluster#set-up-public-se).<ul>
<li>Aggiunge gli indicatori `--private-service-endpoint` e `--public-service-endpoint` al comando [<code>ibmcloud ks cluster-create</code>](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_create).</li>
<li>Aggiunge i campi **Public Service Endpoint URL** e **Private Service Endpoint URL** all'output di <code>ibmcloud ks cluster-get</code>.</li>
<li>Aggiunge il comando [<code>ibmcloud ks cluster-feature-enable private-service-endpoint</code>](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_feature_enable_private_service_endpoint).</li>
<li>Aggiunge il comando [<code>ibmcloud ks cluster-feature-enable public-service-endpoint</code>](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_feature_enable_public_service_endpoint).</li>
<li>Aggiunge il comando [<code>ibmcloud ks cluster-feature-disable public-service-endpoint</code>](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_feature_disable_public_service_endpoint).</li>
<li>Aggiunge il comando [<code>ibmcloud ks cluster-feature-ls</code>](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_feature_ls).</li>
</ul></li>
<li>Aggiorna la documentazione e la traduzione.</li>
<li>Aggiorna la versione di Go alla 1.11.6.</li>
<li>Risolve problemi di rete intermittenti per gli utenti macOS.</li>
</ul></td>
</tr>
<tr>
<td>0.2.75</td>
<td>14 marzo 2019</td>
<td><ul><li>Nasconde l'HTML non elaborato dagli output degli errori.</li>
<li>Corregge gli errori di battitura nel testo della guida.</li>
<li>Corregge la traduzione del testo della guida.</li>
</ul></td>
</tr>
<tr>
<td>0.2.61</td>
<td>26 febbraio 2019</td>
<td><ul>
<li>Aggiunge il comando `cluster-pull-secret-apply`, che crea un ID di servizio IAM per il cluster, le politiche, la chiave API e i segreti di pull dell'immagine in modo che i contenitori che vengono eseguiti nello spazio dei nomi Kubernetes di `default` possano estrarre le immagini da IBM Cloud Container Registry. Per i nuovi cluster, i segreti di pull dell'immagine che utilizzano le credenziali IAM vengono creati per impostazione predefinita. Utilizza questo comando per aggiornare i cluster esistenti o se il tuo cluster riscontra un errore del segreto di pull dell'immagine durante la creazione. Per ulteriori informazioni, consulta [la documentazione](https://test.cloud.ibm.com/docs/containers?topic=containers-images#cluster_registry_auth).</li>
<li>Corregge un bug in cui gli errori `ibmcloud ks init` causavano la stampa dell'output della guida.</li>
</ul></td>
</tr>
<tr>
<td>0.2.53</td>
<td>19 febbraio 2019</td>
<td><ul><li>Corregge un bug in cui la regione veniva ignorata per `ibmcloud ks api-key-reset`, `ibmcloud ks credential-get/set` e `ibmcloud ks vlan-spanning-get`.</li>
<li>Migliora le prestazioni per `ibmcloud ks worker-update`.</li>
<li>Aggiunge la versione del componente aggiuntivo nei prompt `ibmcloud ks cluster-addon-enable`.</li>
</ul></td>
</tr>
<tr>
<td>0.2.44</td>
<td>08 febbraio 2019</td>
<td><ul>
<li>Aggiunge l'opzione `--skip-rbac` al comando `ibmcloud ks cluster-config` per ignorare l'aggiunta dei ruoli utente RBAC Kubernetes basati sui ruoli di accesso al servizio {{site.data.keyword.Bluemix_notm}} IAM alla configurazione del cluster. Includi questa opzione solo se [gestisci i tuoi propri ruoli RBAC Kubernetes](/docs/containers?topic=containers-users#rbac). Se utilizzi i [ruoli di accesso al servizio {{site.data.keyword.Bluemix_notm}} IAM](/docs/containers?topic=containers-access_reference#service) per gestire tutti i tuoi utenti RBAC, non includere questa opzione.</li>
<li>Aggiorna la versione di Go alla 1.11.5.</li>
</ul></td>
</tr>
<tr>
<td>0.2.40</td>
<td>06 febbraio 2019</td>
<td><ul>
<li>Aggiunge i comandi [<code>ibmcloud ks cluster-addons</code>](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_addons), [<code>ibmcloud ks cluster-addon-enable</code>](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_addon_enable) e [<code>ibmcloud ks cluster-addon-disable</code>](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_addon_disable) per lavorare con i componenti aggiuntivi del cluster come i componenti aggiuntivi gestiti di [Istio](/docs/containers?topic=containers-istio) e [Knative](/docs/containers?topic=containers-knative_tutorial) per {{site.data.keyword.containerlong_notm}}.</li>
<li>Migliora il testo della guida del comando <code>ibmcloud ks vlans</code> per gli utenti di {{site.data.keyword.Bluemix_dedicated_notm}}.</li></ul></td>
</tr>
<tr>
<td>0.2.30</td>
<td>31 gennaio 2019</td>
<td>Aumenta il valore di timeout predefinito per `ibmcloud ks cluster-config` a `500s`.</td>
</tr>
<tr>
<td>0.2.19</td>
<td>16 gennaio 2019</td>
<td><ul><li>Aggiunge la variabile di ambiente `IKS_BETA_VERSION` per abilitare la versione beta riprogettata della CLI del plugin {{site.data.keyword.containerlong_notm}}. Per provare la versione riprogettata, vedi [Utilizzo della struttura dei comandi beta](/docs/containers?topic=containers-cs_cli_reference#cs_beta).</li>
<li>Aumenta il valore di timeout predefinito per `ibmcloud ks subnets` a `60s`.</li>
<li>Correzioni di bug minori e di traduzione.</li></ul></td>
</tr>
<tr>
<td>0.1.668</td>
<td>18 dicembre 2018</td>
<td><ul><li>Modifica l'endpoint API predefinito da <code>https://containers.bluemix.net</code> a <code>https://containers.cloud.ibm.com</code>.</li>
<li>Corregge bug in modo che le traduzioni vengano visualizzate correttamente per la guida del comando e i messaggi di errore.</li>
<li>Visualizza la guida del comando più velocemente.</li></ul></td>
</tr>
<tr>
<td>0.1.654</td>
<td>05 dicembre 2018</td>
<td>Aggiorna la documentazione e la traduzione.</td>
</tr>
<tr>
<td>0.1.638</td>
<td>15 novembre 2018</td>
<td>
<ul><li>Aggiunge il comando [<code>ibmcloud ks cluster-refresh</code>](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_refresh).</li>
<li>Aggiunge il nome del gruppo di risorse all'output di <code>ibmcloud ks cluster-get</code> e <code>ibmcloud ks clusters</code>.</li></ul>
</td>
</tr>
<tr>
<td>0.1.635</td>
<td>06 novembre 2018</td>
<td>Aggiunge comandi per la gestione degli aggiornamenti automatici del componente aggiuntivo del cluster ALB Ingress:<ul>
<li>[<code>ibmcloud ks alb-autoupdate-disable</code>](/docs/containers?topic=containers-cs_cli_reference#cs_alb_autoupdate_disable)</li>
<li>[<code>ibmcloud ks alb-autoupdate-enable</code>](/docs/containers?topic=containers-cs_cli_reference#cs_alb_autoupdate_enable)</li>
<li>[<code>ibmcloud ks alb-autoupdate-get</code>](/docs/containers?topic=containers-cs_cli_reference#cs_alb_autoupdate_get)</li>
<li>[<code>ibmcloud ks alb-rollback</code>](/docs/containers?topic=containers-cs_cli_reference#cs_alb_rollback)</li>
<li>[<code>ibmcloud ks alb-update</code>](/docs/containers?topic=containers-cs_cli_reference#cs_alb_update)</li>
</ul></td>
</tr>
<tr>
<td>0.1.621</td>
<td>30 ottobre 2018</td>
<td><ul>
<li>Aggiunge il [comando <code>ibmcloud ks credential-get</code>](/docs/containers?topic=containers-cs_cli_reference#cs_credential_get).</li>
<li>Aggiunge supporto per l'origine log <code>storage</code> a tutti i comandi di registrazione cluster. Per ulteriori informazioni, vedi <a href="/docs/containers?topic=containers-health#logging">Descrizione del cluster e inoltro del log dell'applicazione</a>.</li>
<li>Aggiunge l'indicatore `--network` al [comando <code>ibmcloud ks cluster-config</code>](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_config), che scarica il file di configurazione di Calico per eseguire tutti i comandi Calico.</li>
<li>Correzioni di bug minori e refactoring</li></ul>
</td>
</tr>
<tr>
<td>0.1.593</td>
<td>10 ottobre 2018</td>
<td><ul><li>Aggiunge l'ID gruppo di risorse all'output di <code>ibmcloud ks cluster-get</code>.</li>
<li>Quando [{{site.data.keyword.keymanagementserviceshort}} è abilitato](/docs/containers?topic=containers-encryption#keyprotect) come provider KMS (key management service) nel tuo cluster, aggiunge il campo abilitato a KMS nell'output di <code>ibmcloud ks cluster-get</code>.</li></ul></td>
</tr>
<tr>
<td>0.1.591</td>
<td>02 ottobre 2018</td>
<td>Aggiunge supporto per i [gruppi di risorse](/docs/containers?topic=containers-clusters#prepare_account_level).</td>
</tr>
<tr>
<td>0.1.590</td>
<td>01 ottobre 2018</td>
<td><ul>
<li>Aggiunge i comandi [<code>ibmcloud ks logging-collect</code>](/docs/containers?topic=containers-cs_cli_reference#cs_log_collect) e [<code>ibmcloud ks logging-collect-status</code>](/docs/containers?topic=containers-cs_cli_reference#cs_log_collect_status) per la raccolta dei log del server API nel cluster.</li>
<li>Aggiunge il [comando <code>ibmcloud ks key-protect-enable</code>](/docs/containers?topic=containers-cs_cli_reference#cs_key_protect) per abilitare {{site.data.keyword.keymanagementserviceshort}} come provider KMS (Key Management Service) nel tuo cluster.</li>
<li>Aggiunge l'indicatore <code>--skip-master-health</code> ai comandi [ibmcloud ks worker-reboot](/docs/containers?topic=containers-cs_cli_reference#cs_worker_reboot) e [ibmcloud ks worker-reload](/docs/containers?topic=containers-cs_cli_reference#cs_worker_reboot) per ignorare il controllo integrità master prima di iniziare il riavvio o il caricamento.</li>
<li>Rinomina <code>Owner Email</code> in <code>Owner</code> nell'output di <code>ibmcloud ks cluster-get</code>.</li></ul></td>
</tr>
</tbody>
</table>
