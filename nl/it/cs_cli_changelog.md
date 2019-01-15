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


# Changelog della CLI
{: #cs_cli_changelog}

Nel terminale, ricevi una notifica quando sono disponibili degli aggiornamenti ai plug-in e alla CLI `ibmcloud`. Assicurati di mantenere la tua CLI aggiornata in modo che tu possa utilizzare tutti i comandi e gli indicatori disponibili.
{:shortdesc}

Per installare il plug-in della CLI, vedi [Installazione della CLI](cs_cli_install.html#cs_cli_install_steps).

Fai riferimento alla seguente tabella per un riepilogo delle modifiche per ogni versione del plug-in della CLI.

<table summary="Panoramica delle modifiche alla versione per il plug-in della CLI {{site.data.keyword.containerlong_notm}} ">
<caption>Changelog per il plug-in della CLI {{site.data.keyword.containerlong_notm}}</caption>
<thead>
<tr>
<th>Versione</th>
<th>Data di rilascio</th>
<th>Modifiche</th>
</tr>
</thead>
<tbody>
<tr>
<td>0.1.654</td>
<td>05 dicembre 2018</td>
<td>Aggiorna la documentazione e la traduzione.</td>
</tr>
<tr>
<td>0.1.638</td>
<td>15 novembre 2018</td>
<td>
<ul><li>Aggiunge il comando [<code>ibmcloud ks cluster-refresh</code>](cs_cli_reference.html#cs_cluster_refresh).</li>
<li>Aggiunge il nome del gruppo di risorse all'output di <code>ibmcloud ks cluster-get</code> e <code>ibmcloud ks clusters</code>.</li></ul>
</td>
</tr>
<tr>
<td>0.1.635</td>
<td>06 novembre 2018</td>
<td>Aggiunge i comandi [<code>ibmcloud ks alb-autoupdate-disable</code>](cs_cli_reference.html#cs_alb_autoupdate_disable), [<code>ibmcloud ks alb-autoupdate-enable</code>](cs_cli_reference.html#cs_alb_autoupdate_enable), [<code>ibmcloud ks alb-autoupdate-get</code>](cs_cli_reference.html#cs_alb_autoupdate_get), [<code>ibmcloud ks alb-rollback</code>](cs_cli_reference.html#cs_alb_rollback) e [<code>ibmcloud ks alb-update</code>](cs_cli_reference.html#cs_alb_update) per la gestione degli aggiornamenti automatici del componente aggiuntivo del cluster ALB Ingress.
</td>
</tr>
<tr>
<td>0.1.621</td>
<td>30 ottobre 2018</td>
<td><ul>
<li>Aggiunge il comando [<code>ibmcloud ks credential-get</code>](cs_cli_reference.html#cs_credential_get).</li>
<li>Aggiunge supporto per l'origine log <code>storage</code> a tutti i comandi di registrazione cluster. Per ulteriori informazioni, vedi <a href="cs_health.html#logging">Descrizione del cluster e inoltro del log dell'applicazione</a>.</li>
<li>Aggiunge l'indicatore `--network` al [comando <code>ibmcloud ks cluster-config</code>](cs_cli_reference.html#cs_cluster_config), che scarica il file di configurazione di Calico per eseguire tutti i comandi Calico.</li>
<li>Correzioni di bug minori e refactoring</li></ul>
</td>
</tr>
<tr>
<td>0.1.593</td>
<td>10 ottobre 2018</td>
<td><ul><li>Aggiunge l'ID gruppo di risorse all'output di <code>ibmcloud ks cluster-get</code>.</li>
<li>Quando [{{site.data.keyword.keymanagementserviceshort}} è abilitato](cs_encrypt.html#keyprotect) come provider KMS (key management service) nel tuo cluster, aggiunge il campo abilitato a KMS nell'output di <code>ibmcloud ks cluster-get</code>.</li></ul></td>
</tr>
<tr>
<td>0.1.591</td>
<td>02 ottobre 2018</td>
<td>Aggiunge supporto per i [gruppi di risorse](cs_clusters.html#prepare_account_level).</td>
</tr>
<tr>
<td>0.1.590</td>
<td>01 ottobre 2018</td>
<td><ul>
<li>Aggiunge i comandi [<code>ibmcloud ks logging-collect</code>](cs_cli_reference.html#cs_log_collect) e [<code>ibmcloud ks logging-collect-status</code>](cs_cli_reference.html#cs_log_collect_status) per la raccolta dei log del server API nel cluster.</li>
<li>Aggiunge il [comando <code>ibmcloud ks key-protect-enable</code>](cs_cli_reference.html#cs_key_protect) per abilitare {{site.data.keyword.keymanagementserviceshort}} come provider KMS (key management service) nel cluster.</li>
<li>Aggiunge l'indicatore <code>--skip-master-health</code> ai comandi [ibmcloud ks worker-reboot](cs_cli_reference.html#cs_worker_reboot) e [ibmcloud ks worker-reload](cs_cli_reference.html#cs_worker_reboot) per ignorare il controllo integrità master prima di iniziare il riavvio o il caricamento.</li>
<li>Rinomina <code>Owner Email</code> in <code>Owner</code> nell'output di <code>ibmcloud ks cluster-get</code>.</li></ul></td>
</tr>
</tbody>
</table>
