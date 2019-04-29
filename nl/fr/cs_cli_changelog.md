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



# Journal des modifications de l'interface de ligne de commande (CLI)
{: #cs_cli_changelog}

Dans le terminal, vous êtes averti des mises à jour disponibles pour l'interface de ligne de commande `ibmcloud` et les plug-ins. Veillez à maintenir votre interface de ligne de commande à jour pour pouvoir utiliser l'ensemble des commandes et des indicateurs.
{:shortdesc}

Pour installer le plug-in de l'interface CLI {{site.data.keyword.containerlong}}, voir [Installation de l'interface de ligne de commande](/docs/containers?topic=containers-cs_cli_install#cs_cli_install_steps).

Consultez le tableau suivant pour obtenir un récapitulatif des modifications de chaque version du plug-in d'interface de ligne de commande {{site.data.keyword.containerlong_notm}}.

<table summary="Présentation des modifications de version pour le plug-in de l'interface de ligne de commande {{site.data.keyword.containerlong_notm}} ">
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
<td>0.2.80</td>
<td>19 mars 2019</td>
<td><ul>
<li>Prise en charge de l'activation de la [communication entre le maître et les noeuds worker avec des noeuds finaux de service](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master) dans les clusters standard exécutant Kubernetes version 1.11 ou ultérieure dans les [comptes avec la fonction VRF activée](/docs/services/service-endpoint?topic=services/service-endpoint-getting-started#getting-started). Pour plus d'informations sur l'utilisation des commandes suivantes, voir [Configuration du noeud final de service privé](/docs/containers?topic=containers-cs_network_cluster#set-up-private-se) et [Configuration du noeud final de service public](/docs/containers?topic=containers-cs_network_cluster#set-up-public-se).<ul>
<li>Ajout des indicateurs `--private-service-endpoint` et `--public-service-endpoint` dans la commande [<code>ibmcloud ks cluster-create</code>](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_create).</li>
<li>Ajout des zones d'URL de noeud final de service public et de service privé (**Public Service Endpoint URL** et **Private Service Endpoint URL**) dans la sortie de la commande <code>ibmcloud ks cluster-get</code>.</li>
<li>Ajout de la commande [<code>ibmcloud ks cluster-feature-enable private-service-endpoint</code>](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_feature_enable_private_service_endpoint).</li>
<li>Ajout de la commande [<code>ibmcloud ks cluster-feature-enable public-service-endpoint</code>](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_feature_enable_public_service_endpoint).</li>
<li>Ajout de la commande [<code>ibmcloud ks cluster-feature-disable public-service-endpoint</code>](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_feature_disable_public_service_endpoint).</li>
<li>Ajout de la commande [<code>ibmcloud ks cluster-feature-ls</code>](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_feature_ls).</li>
</ul></li>
<li>Mise à jour de la documentation et de la traduction.</li>
<li>Mise à jour de la version Go à 1.11.6.</li>
<li>Résolution des problèmes de réseau par intermittence pour les utilisateurs macOS.</li>
</ul></td>
</tr>
<tr>
<td>0.2.75</td>
<td>14 mars 2019</td>
<td><ul><li>Masquage du code HTML brut dans les sorties d'erreur.</li>
<li>Correction de fautes de frappe dans le texte d'aide.</li>
<li>Correction de la traduction du texte d'aide.</li>
</ul></td>
</tr>
<tr>
<td>0.2.61</td>
<td>26 fév. 2019</td>
<td><ul>
<li>Ajout de la commande `cluster-pull-secret-apply`, qui crée un ID de service IAM pour le cluster, les règles, la clé d'API et les valeurs confidentielles d'extraction d'image pour que les conteneurs qui s'exécutent dans l'espace de nom Kubernetes `default` puissent extraire des images depuis IBM Cloud Container Registry. Pour les nouveaux clusters, les valeurs confidentielles d'extraction d'image qui utilisent des données d'identification IAM sont créées par défaut. Utilisez cette commande pour mettre à jour des clusters existants ou si votre cluster comporte une erreur de valeur confidentielle d'extraction d'image lors de sa création. Pour plus d'informations, voir [la documentation](https://test.cloud.ibm.com/docs/containers?topic=containers-images#cluster_registry_auth).</li>
<li>Correction d'un bogue où les échecs de la commande `ibmcloud ks init` entraînaient l'impression en sortie de l'aide.</li>
</ul></td>
</tr>
<tr>
<td>0.2.53</td>
<td>19 fév. 2019</td>
<td><ul><li>Correction d'un bogue où la région était ignorée pour les commandes `ibmcloud ks api-key-reset`, `ibmcloud ks credential-get/set` et `ibmcloud ks vlan-spanning-get`.</li>
<li>Amélioration des performances pour la commande `ibmcloud ks worker-update`.</li>
<li>Ajout de la version du module complémentaire dans les invites de la commande `ibmcloud ks cluster-addon-enable`.</li>
</ul></td>
</tr>
<tr>
<td>0.2.44</td>
<td>8 fév. 2019</td>
<td><ul>
<li>Ajout de l'option `--skip-rbac` dans la commande `ibmcloud ks cluster-config` pour ignorer l'ajout de rôles RBAC Kubernetes aux utilisateurs en fonction des rôles d'accès au service {{site.data.keyword.Bluemix_notm}} IAM dans la configuration du cluster. Incluez cette option uniquement si vous [gérez vos propres rôles Kubernetes RBAC](/docs/containers?topic=containers-users#rbac). Si vous utilisez des [rôles d'accès au service {{site.data.keyword.Bluemix_notm}} IAM](/docs/containers?topic=containers-access_reference#service) pour gérer tous vos utilisateurs RBAC, n'incluez pas cette option.</li>
<li>Mise à jour de la version Go à 1.11.5.</li>
</ul></td>
</tr>
<tr>
<td>0.2.40</td>
<td>6 fév. 2019</td>
<td><ul>
<li>Ajout des commandes [<code>ibmcloud ks cluster-addons</code>](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_addons), [<code>ibmcloud ks cluster-addon-enable</code>](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_addon_enable) et [<code>ibmcloud ks cluster-addon-disable</code>](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_addon_disable) pour utiliser des modules complémentaires de cluster gérés, tels qu'[Istio](/docs/containers?topic=containers-istio) et [Knative](/docs/containers?topic=containers-knative_tutorial) pour {{site.data.keyword.containerlong_notm}}.</li>
<li>Amélioration du texte d'aide de la commande <code>ibmcloud ks vlans</code> pour les utilisateurs d'{{site.data.keyword.Bluemix_dedicated_notm}}.</li></ul></td>
</tr>
<tr>
<td>0.2.30</td>
<td>31 jan. 2019</td>
<td>Augmentation de la valeur de délai d'attente par défaut à `500s` pour la commande `ibmcloud ks cluster-config`.</td>
</tr>
<tr>
<td>0.2.19</td>
<td>16 jan. 2019</td>
<td><ul><li>Ajout de la variable d'environnement `IKS_BETA_VERSION` pour activer la version bêta remaniée de l'interface de ligne de commande du plug-in {{site.data.keyword.containerlong_notm}}. Pour découvrir la version remaniée, voir [Utilisation de la structure de commande bêta](/docs/containers?topic=containers-cs_cli_reference#cs_beta).</li>
<li>Augmentation de la valeur du délai d'attente par défaut à `60s` pour la commande `ibmcloud ks subnets`.</li>
<li>Corrections d'erreurs mineures et de traduction.</li></ul></td>
</tr>
<tr>
<td>0.1.668</td>
<td>18 déc. 2018</td>
<td><ul><li>Le noeud final d'API par défaut <code>https://containers.bluemix.net</code> a été remplacé par <code>https://containers.cloud.ibm.com</code>.</li>
<li>Correction d'erreurs pour que les traductions s'affichent correctement dans l'aide des commandes et les messages d'erreur.</li>
<li>Affichage plus rapide de l'aide sur les commandes.</li></ul></td>
</tr>
<tr>
<td>0.1.654</td>
<td>5 déc. 2018</td>
<td>Mise à jour de la documentation et de la traduction.</td>
</tr>
<tr>
<td>0.1.638</td>
<td>15 nov. 2018</td>
<td>
<ul><li>Ajout de la commande [<code>ibmcloud ks cluster-refresh</code>](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_refresh).</li>
<li>Ajout du nom du groupe de ressources dans le résultat des commandes <code>ibmcloud ks cluster-get</code> et <code>ibmcloud ks clusters</code>.</li></ul>
</td>
</tr>
<tr>
<td>0.1.635</td>
<td>6 nov. 2018</td>
<td>Ajout de commandes pour la gestion des mises à jour automatiques du module complémentaire de cluster ALB Ingress :<ul>
<li>[<code>ibmcloud ks alb-autoupdate-disable</code>](/docs/containers?topic=containers-cs_cli_reference#cs_alb_autoupdate_disable)</li>
<li>[<code>ibmcloud ks alb-autoupdate-enable</code>](/docs/containers?topic=containers-cs_cli_reference#cs_alb_autoupdate_enable)</li>
<li>[<code>ibmcloud ks alb-autoupdate-get</code>](/docs/containers?topic=containers-cs_cli_reference#cs_alb_autoupdate_get)</li>
<li>[<code>ibmcloud ks alb-rollback</code>](/docs/containers?topic=containers-cs_cli_reference#cs_alb_rollback)</li>
<li>[<code>ibmcloud ks alb-update</code>](/docs/containers?topic=containers-cs_cli_reference#cs_alb_update)</li>
</ul></td>
</tr>
<tr>
<td>0.1.621</td>
<td>30 oct. 2018</td>
<td><ul>
<li>Ajout de la [commande <code>ibmcloud ks credential-get</code>](/docs/containers?topic=containers-cs_cli_reference#cs_credential_get).</li>
<li>Prise en charge de la source de journal <code>storage</code> pour toutes les commandes de cluster liées à la consignation. Pour plus d'informations, voir <a href="/docs/containers?topic=containers-health#logging">Description de l'acheminement des journaux de cluster et d'application</a>.</li>
<li>Ajout de l'indicateur `--network` dans la [commande <code>ibmcloud ks cluster-config</code>](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_config), qui télécharge le fichier de configuration Calico pour exécuter toutes les commandes Calico.</li>
<li>Corrections d'erreur mineures et restructuration</li></ul>
</td>
</tr>
<tr>
<td>0.1.593</td>
<td>10 oct. 2018</td>
<td><ul><li>Ajout de l'ID du groupe de ressource dans la sortie de la commande <code>ibmcloud ks cluster-get</code>.</li>
<li>Lorsque [{{site.data.keyword.keymanagementserviceshort}} est activé](/docs/containers?topic=containers-encryption#keyprotect) en tant que fournisseur de service de gestion des clés (KMS) dans votre cluster, ajout de la zone KMS activée dans la sortie de la commande <code>ibmcloud ks cluster-get</code>.</li></ul></td>
</tr>
<tr>
<td>0.1.591</td>
<td>2 oct. 2018</td>
<td>Ajout de la prise en charge des [groupes de ressources](/docs/containers?topic=containers-clusters#prepare_account_level).</td>
</tr>
<tr>
<td>0.1.590</td>
<td>1er oct. 2018</td>
<td><ul>
<li>Ajout des commandes [<code>ibmcloud ks logging-collect</code>](/docs/containers?topic=containers-cs_cli_reference#cs_log_collect) et [<code>ibmcloud ks logging-collect-status</code>](/docs/containers?topic=containers-cs_cli_reference#cs_log_collect_status) pour la collecte des journaux de serveur d'API dans votre cluster.</li>
<li>Ajout de la [commande <code>ibmcloud ks key-protect-enable</code>](/docs/containers?topic=containers-cs_cli_reference#cs_key_protect) pour activer {{site.data.keyword.keymanagementserviceshort}} en tant que fournisseur de service de gestion des clés (KMS) dans votre cluster.</li>
<li>Ajout de l'indicateur <code>--skip-master-health</code> dans les commandes [ibmcloud ks worker-reboot](/docs/containers?topic=containers-cs_cli_reference#cs_worker_reboot) et [ibmcloud ks worker-reload](/docs/containers?topic=containers-cs_cli_reference#cs_worker_reboot) pour ignorer le diagnostic d'intégrité du maître avant de lancer une opération de réamorçage ou de rechargement.</li>
<li>Remplacement du nom de l'adresse e-mail du propriétaire <code>Owner Email</code> par <code>Owner</code> dans la sortie de la commande <code>ibmcloud ks cluster-get</code>.</li></ul></td>
</tr>
</tbody>
</table>
