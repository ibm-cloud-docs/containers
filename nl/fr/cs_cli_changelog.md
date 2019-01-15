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


# Journal des modifications de l'interface de ligne de commande (CLI)
{: #cs_cli_changelog}

Dans le terminal, vous êtes averti des mises à jour disponibles pour l'interface de ligne de commande `ibmcloud` et les plug-ins. Veillez à maintenir votre interface de ligne de commande à jour pour pouvoir utiliser l'ensemble des commandes et des indicateurs.
{:shortdesc}

Pour installer le plug-in de l'interface CLI, voir [Installation de l'interface de ligne de commande](cs_cli_install.html#cs_cli_install_steps).

Consultez le tableau suivant pour obtenir un récapitulatif des modifications de chaque version de plug-in d'interface de ligne de commande.

<table summary="Présentation des modifications de version pour le plug-in de l'interface de ligne de commande {{site.data.keyword.containerlong_notm}}">
<caption>Journal des modifications pour le plug-in de l'interface de ligne de commande {{site.data.keyword.containerlong_notm}}</caption>
<thead>
<tr>
<th>Version</th>
<th>Date de publication</th>
<th>Modifications</th>
</tr>
</thead>
<tbody>
<tr>
<td>0.1.654</td>
<td>5 déc. 2018</td>
<td>Mise à jour de la documentation et de la traduction.</td>
</tr>
<tr>
<td>0.1.638</td>
<td>15 nov. 2018</td>
<td>
<ul><li>Ajout de la commande [<code>ibmcloud ks cluster-refresh</code>](cs_cli_reference.html#cs_cluster_refresh).</li>
<li>Ajout du nom du groupe de ressources dans le résultat des commandes <code>ibmcloud ks cluster-get</code> et <code>ibmcloud ks clusters</code>.</li></ul>
</td>
</tr>
<tr>
<td>0.1.635</td>
<td>6 nov. 2018</td>
<td>Ajout des commandes [<code>ibmcloud ks alb-autoupdate-disable</code>](cs_cli_reference.html#cs_alb_autoupdate_disable), [<code>ibmcloud ks alb-autoupdate-enable</code>](cs_cli_reference.html#cs_alb_autoupdate_enable), [<code>ibmcloud ks alb-autoupdate-get</code>](cs_cli_reference.html#cs_alb_autoupdate_get), [<code>ibmcloud ks alb-rollback</code>](cs_cli_reference.html#cs_alb_rollback) et [<code>ibmcloud ks alb-update</code>](cs_cli_reference.html#cs_alb_update) pour la gestion des mises à jour automatiques du module complémentaire de cluster ALB Ingress.
</td>
</tr>
<tr>
<td>0.1.621</td>
<td>30 oct. 2018</td>
<td><ul>
<li>Ajout de la [commande <code>ibmcloud ks credential-get</code>](cs_cli_reference.html#cs_credential_get).</li>
<li>Prise en charge de la source de journal <code>storage</code> pour toutes les commandes de cluster liées à la consignation. Pour plus d'informations, voir <a href="cs_health.html#logging">Description de l'acheminement des journaux de cluster et d'application</a>.</li>
<li>Ajout de l'indicateur `--network` dans la [commande <code>ibmcloud ks cluster-config</code>](cs_cli_reference.html#cs_cluster_config), qui télécharge le fichier de configuration Calico permettant d'exécuter toutes les commandes Calico.</li>
<li>Corrections d'erreur mineures et restructuration</li></ul>
</td>
</tr>
<tr>
<td>0.1.593</td>
<td>10 oct. 2018</td>
<td><ul><li>Ajout de l'ID du groupe de ressource dans la sortie de la commande <code>ibmcloud ks cluster-get</code>.</li>
<li>Lorsque [{{site.data.keyword.keymanagementserviceshort}} est activé](cs_encrypt.html#keyprotect) en tant que fournisseur de service de gestion des clés (KMS) dans votre cluster, ajout de la zone KMS activée dans la sortie de la commande <code>ibmcloud ks cluster-get</code>.</li></ul></td>
</tr>
<tr>
<td>0.1.591</td>
<td>2 oct. 2018</td>
<td>Ajout de la prise en charge des [groupes de ressources](cs_clusters.html#prepare_account_level).</td>
</tr>
<tr>
<td>0.1.590</td>
<td>1er oct. 2018</td>
<td><ul>
<li>Ajout des commandes [<code>ibmcloud ks logging-collect</code>](cs_cli_reference.html#cs_log_collect) et [<code>ibmcloud ks logging-collect-status</code>](cs_cli_reference.html#cs_log_collect_status) pour la collecte des journaux de serveur d'API dans votre cluster.</li>
<li>Ajout de la [commande <code>ibmcloud ks key-protect-enable</code>](cs_cli_reference.html#cs_key_protect) pour activer {{site.data.keyword.keymanagementserviceshort}} comme fournisseur de service de gestion des clés (KMS) dans votre cluster.</li>
<li>Ajout de l'indicateur <code>--skip-master-health</code> dans les commandes [ibmcloud ks worker-reboot](cs_cli_reference.html#cs_worker_reboot) et [ibmcloud ks worker-reload](cs_cli_reference.html#cs_worker_reboot) pour ignorer le diagnostic d'intégrité du maître avant de lancer le réamorçage ou le rechargement.</li>
<li>Remplacement du nom de l'adresse e-mail du propriétaire <code>Owner Email</code> par <code>Owner</code> dans la sortie de la commande <code>ibmcloud ks cluster-get</code>.</li></ul></td>
</tr>
</tbody>
</table>
