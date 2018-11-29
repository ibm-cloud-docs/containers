---

copyright:
  years: 2014, 2018
lastupdated: "2018-10-25"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Journal des modifications de l'interface de ligne de commande (CLI)
{: #cs_cli_changelog}

Dans le terminal, vous êtes averti des mises à jour disponibles pour l'interface de ligne de commande `ibmcloud` et les plug-ins. Veillez à maintenir votre interface de ligne de commande à jour pour pouvoir utiliser l'ensemble des commandes et des indicateurs.
{:shortdesc}

Pour installer le plug-in de l'interface CLI, voir [Installation de l'interface de ligne de commande](cs_cli_install.html#cs_cli_install_steps).

Consultez le tableau suivant pour obtenir un récapitulatif des modifications de chaque version de plug-in d'interface de ligne de commande.

<table summary="Journal de modifications pour le plug-in de l'interface de ligne de commande {{site.data.keyword.containerlong_notm}} ">
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
<td>0.1.593</td>
<td>10 octobre 2018</td>
<td><ul><li>Ajout de l'ID du groupe de ressource dans la sortie de la commande <code>ibmcloud ks cluster-get</code>.</li>
<li>Lorsque [{{site.data.keyword.keymanagementserviceshort}} est activé](cs_encrypt.html#keyprotect) en tant que fournisseur de service de gestion des clés (KMS) dans votre cluster, ajout de la zone KMS activée dans la sortie de la commande <code>ibmcloud ks cluster-get</code>.</li></ul></td>
</tr>
<tr>
<td>0.1.591</td>
<td>2 octobre 2018</td>
<td>Ajout de la prise en charge des [groupes de ressources](cs_clusters.html#prepare_account_level).</td>
</tr>
<tr>
<td>0.1.590</td>
<td>1er octobre 2018</td>
<td><ul>
<li>Ajout des commandes [<code>ibmcloud ks logging-collect</code>](cs_cli_reference.html#cs_log_collect) et [<code>ibmcloud ks logging-collect-status</code>](cs_cli_reference.html#cs_log_collect_status) pour la collecte des journaux de serveur d'API dans votre cluster.</li>
<li>Ajout de la [commande <code>ibmcloud ks key-protect-enable</code>](cs_cli_reference.html#cs_key_protect) pour activer {{site.data.keyword.keymanagementserviceshort}} comme fournisseur de service de gestion des clés (KMS) dans votre cluster.</li>
<li>Ajout de l'indicateur <code>--skip-master-health</code> dans les commandes [ibmcloud ks worker-reboot](cs_cli_reference.html#cs_worker_reboot) et [ibmcloud ks worker-reload](cs_cli_reference.html#cs_worker_reboot) pour ignorer le diagnostic d'intégrité du maître avant de lancer le réamorçage ou le rechargement.</li>
<li>Remplacement du nom de l'adresse e-mail du propriétaire <code>Owner Email</code> par <code>Owner</code> dans la sortie de la commande <code>ibmcloud ks cluster-get</code>.</li></ul></td>
</tr>
</tbody>
</table>
