---

copyright:
  years: 2014, 2019
lastupdated: "2019-03-21"

keywords: kubernetes, iks

subcollection: containers

---

{:new_window: target="blank"}
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


# Droits d'accès des utilisateurs
{: #access_reference}

Lorsque vous [affectez des droits pour un cluster](/docs/containers?topic=containers-users), il peut être difficile de déterminer le rôle à attribuer à un utilisateur. Utilisez les tableaux présentés dans les sections suivantes pour déterminer les droits minimum requis pour effectuer des tâches courantes dans {{site.data.keyword.containerlong}}.
{: shortdesc}

Depuis le 30 janvier 2019, {{site.data.keyword.containerlong_notm}} dispose d'un nouveau mode d'autorisation des utilisateurs avec {{site.data.keyword.Bluemix_notm}} IAM : les [rôles d'accès au service](#service). Ces rôles de service sont utilisés pour accorder l'accès aux ressources au sein du cluster, par exemple aux espaces de nom Kubernetes. Pour plus d'informations, consultez le blogue, [Introducing service roles and namespaces in IAM for more granular control of cluster access ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://www.ibm.com/blogs/bluemix/2019/02/introducing-service-roles-and-namespaces-in-iam-for-more-granular-control-of-cluster-access/).
{: note}

## Rôles de plateforme {{site.data.keyword.Bluemix_notm}} IAM
{: #iam_platform}

{{site.data.keyword.containerlong_notm}} est configuré pour utiliser des rôles {{site.data.keyword.Bluemix_notm}} Identity and Access Management (IAM). Les rôles de plateforme {{site.data.keyword.Bluemix_notm}} IAM déterminent les actions que les utilisateurs peuvent effectuer sur des ressources {{site.data.keyword.Bluemix_notm}}, telles que des clusters, des noeuds worker et des équilibreurs de charge d'application Ingress. Les rôles de plateforme {{site.data.keyword.Bluemix_notm}} IAM définissent également automatiquement les droits d'infrastructure de base des utilisateurs. Pour définir des rôles de plateforme, voir [Affectation de droits de plateforme {{site.data.keyword.Bluemix_notm}} IAM](/docs/containers?topic=containers-users#platform).
{: shortdesc}

Dans chacune des sections suivantes, les tableaux présentent les droits de gestion de cluster, les droits de consignation et les droits Ingress octroyés par chaque rôle de plateforme {{site.data.keyword.Bluemix_notm}} IAM. Les tableaux sont organisés par ordre alphabétique de nom de commande d'interface de ligne de commande.

* [Actions ne nécessitant pas de droit](#none-actions)
* [Actions de l'afficheur](#view-actions)
* [Actions de l'éditeur](#editor-actions)
* [Actions de l'opérateur](#operator-actions)
* [Actions de l'administrateur](#admin-actions)

### Actions ne nécessitant pas de droit
{: #none-actions}

Un utilisateur de votre compte qui exécute la commande de l'interface de ligne de commande ou effectue l'appel d'API pour l'action figurant dans le tableau suivant en voit le résultat, même si aucun droit n'est affecté à cet utilisateur.
{: shortdesc}

<table>
<caption>Présentation des commandes de l'interface de ligne de commande et des appels d'API ne nécessitant aucun droit dans {{site.data.keyword.containerlong_notm}}</caption>
<thead>
<th id="none-actions-action">Action de gestion de cluster</th>
<th id="none-actions-cli">Commande de l'interface de ligne de commande</th>
<th id="none-actions-api">Appel d'API</th>
</thead>
<tbody>
<tr>
<td>Cibler ou afficher le noeud final d'API correspondant à {{site.data.keyword.containerlong_notm}}.</td>
<td><code>[ibmcloud ks api](/docs/containers?topic=containers-cs_cli_reference#cs_api)</code></td>
<td>-</td>
</tr>
<tr>
<td>Afficher la liste des commandes et des paramètres pris en charge.</td>
<td><code>[ibmcloud ks help](/docs/containers?topic=containers-cs_cli_reference#cs_help)</code></td>
<td>-</td>
</tr>
<tr>
<td>Initialiser le plug-in {{site.data.keyword.containerlong_notm}} ou spécifier la région dans laquelle vous souhaitez créer ou accéder à des clusters Kubernetes.</td>
<td><code>[ibmcloud ks init](/docs/containers?topic=containers-cs_cli_reference#cs_init)</code></td>
<td>-</td>
</tr>
<tr>
<td>Afficher la liste des versions Kubernetes prises en charge dans {{site.data.keyword.containerlong_notm}}. </td><td><code>[ibmcloud ks kube-versions](/docs/containers?topic=containers-cs_cli_reference#cs_kube_versions)</code></td>
<td><code>[GET /v1/kube-versions](https://containers.cloud.ibm.com/swagger-api/#!/util/GetKubeVersions)</code></td>
</tr>
<tr>
<td>Afficher la liste des types de machine disponibles pour vos noeuds worker.</td>
<td><code>[ibmcloud ks machine-types](/docs/containers?topic=containers-cs_cli_reference#cs_machine_types)</code></td>
<td><code>[GET /v1/datacenters/{datacenter}/machine-types](https://containers.cloud.ibm.com/swagger-api/#!/util/GetDatacenterMachineTypes)</code></td>
</tr>
<tr>
<td>Afficher les messages en cours pour l'utilisateur IBMid.</td>
<td><code>[ibmcloud ks messages](/docs/containers?topic=containers-cs_cli_reference#cs_messages)</code></td>
<td><code>[GET /v1/messages](https://containers.cloud.ibm.com/swagger-api/#!/util/GetMessages)</code></td>
</tr>
<tr>
<td>Identifier la région {{site.data.keyword.containerlong_notm}} où vous vous trouvez actuellement.</td>
<td><code>[ibmcloud ks region](/docs/containers?topic=containers-cs_cli_reference#cs_region)</code></td>
<td>-</td>
</tr>
<tr>
<td>Définir la région pour {{site.data.keyword.containerlong_notm}}.</td>
<td><code>[ibmcloud ks region-set](/docs/containers?topic=containers-cs_cli_reference#cs_region-set)</code></td>
<td>-</td>
</tr>
<tr>
<td>Répertorier les régions disponibles.</td>
<td><code>[ibmcloud ks regions](/docs/containers?topic=containers-cs_cli_reference#cs_regions)</code></td>
<td><code>[GET /v1/regions](https://containers.cloud.ibm.com/swagger-api/#!/util/GetRegions)</code></td>
</tr>
<tr>
<td>Afficher la liste de toutes les zones disponibles pour créer un cluster.</td>
<td><code>[ibmcloud ks zones](/docs/containers?topic=containers-cs_cli_reference#cs_datacenters)</code></td>
<td><code>[GET /v1/zones](https://containers.cloud.ibm.com/swagger-api/#!/util/GetZones)</code></td>
</tr>
</tbody>
</table>

### Actions de l'afficheur
{: #view-actions}

Le rôle de plateforme **Afficheur** comprend des [actions qui ne nécessitent pas de droit](#none-actions), ainsi que des droits présentés dans le tableau suivant.
{: shortdesc}

<table>
<caption>Présentation des commandes de l'interface de ligne de commande et des appels d'API de gestion de cluster qui nécessitent le rôle de plateforme Afficheur dans {{site.data.keyword.containerlong_notm}}</caption>
<thead>
<th id="view-actions-mngt">Action de gestion de cluster</th>
<th id="view-actions-cli">Commande de l'interface de ligne de commande</th>
<th id="view-actions-api">Appel d'API</th>
</thead>
<tbody>
<tr>
<td>Afficher le nom et l'adresse e-mail du propriétaire de la clé d'API {{site.data.keyword.Bluemix_notm}} IAM pour un groupe de ressources et une région.</td>
<td><code>[ibmcloud ks api-key-info](/docs/containers?topic=containers-cs_cli_reference#cs_api_key_info)</code></td>
<td><code>[GET /v1/logging/{idOrName}/clusterkeyowner](https://containers.cloud.ibm.com/swagger-logging/#!/logging/GetClusterKeyOwner)</code></td>
</tr>
<tr>
<td>Télécharger les certificats et les données de configuration de Kubernetes pour se connecter à votre cluster et exécuter des commandes `kubectl`.</td>
<td><code>[ibmcloud ks cluster-config](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_config)</code></td>
<td><code>[GET /v1/clusters/{idOrName}/config](https://containers.cloud.ibm.com/swagger-api/#!/clusters/GetClusterConfig)</code></td>
</tr>
<tr>
<td>Afficher les informations d'un cluster.</td>
<td><code>[ibmcloud ks cluster-get](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_get)</code></td>
<td><code>[GET /v1/clusters/{idOrName}](https://containers.cloud.ibm.com/swagger-api/#!/clusters/GetCluster)</code></td>
</tr>
<tr>
<td>Répertorier l'ensemble des services dans tous les espaces de nom liés à un cluster.</td>
<td><code>[ibmcloud ks cluster-services](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_services)</code></td>
<td><code>[GET /v1/clusters/{idOrName}/services](https://containers.cloud.ibm.com/swagger-api/#!/clusters/ListServicesForAllNamespaces)</code></td>
</tr>
<tr>
<td>Répertorier tous les clusters.</td>
<td><code>[ibmcloud ks clusters](/docs/containers?topic=containers-cs_cli_reference#cs_clusters)</code></td>
<td><code>[GET /v1/clusters](https://containers.cloud.ibm.com/swagger-api/#!/clusters/GetClusters)</code></td>
</tr>
<tr>
<td>Obtenir les données d'identification d'infrastructure définies pour le compte {{site.data.keyword.Bluemix_notm}} pour accéder à un autre portefeuille d'infrastructure IBM Cloud (SoftLayer).</td>
<td><code>[        ibmcloud ks credential-get
        ](/docs/containers?topic=containers-cs_cli_reference#cs_credential_get)</code></td><td><code>[GET /v1/credentials](https://containers.cloud.ibm.com/swagger-api/#!/accounts/GetUserCredentials)</code></td>
</tr>
<tr>
<td>Répertorier tous les services liés à un espace de nom spécifique.</td>
<td>-</td>
<td><code>[GET /v1/clusters/{idOrName}/services/{namespace}](https://containers.cloud.ibm.com/swagger-api/#!/clusters/ListServicesInNamespace)</code></td>
</tr>
<tr>
<td>Répertorier tous les sous-réseaux gérés par l'utilisateur liés à un cluster.</td>
<td>-</td>
<td><code>[GET /v1/clusters/{idOrName}/usersubnets](https://containers.cloud.ibm.com/swagger-api/#!/clusters/GetClusterUserSubnet)</code></td>
</tr>
<tr>
<td>Répertorier les sous-réseaux disponibles dans le compte d'infrastructure.</td>
<td><code>[ibmcloud ks subnets](/docs/containers?topic=containers-cs_cli_reference#cs_subnets)</code></td>
<td><code>[GET /v1/subnets](https://containers.cloud.ibm.com/swagger-api/#!/properties/ListSubnets)</code></td>
</tr>
<tr>
<td>Afficher le statut de spanning VLAN correspondant au compte d'infrastructure.</td>
<td><code>[ibmcloud ks vlan-spanning-get](/docs/containers?topic=containers-cs_cli_reference#cs_vlan_spanning_get)</code></td>
<td><code>[GET /v1/subnets/vlan-spanning](https://containers.cloud.ibm.com/swagger-api/#!/accounts/GetVlanSpanning)</code></td>
</tr>
<tr>
<td>Lorsque cette action est définie pour un cluster : répertorier les VLAN auquel est connecté le cluster dans une zone.</br>Lorsque cette action est définie pour tous les clusters du compte : répertorier tous les VLAN disponibles dans une zone.</td>
<td><code>[ibmcloud ks vlans](/docs/containers?topic=containers-cs_cli_reference#cs_vlans)</code></td>
<td><code>[GET /v1/datacenters/{datacenter}/vlans](https://containers.cloud.ibm.com/swagger-api/#!/properties/GetDatacenterVLANs)</code></td>
</tr>
<tr>
<td>Répertorier tous les webhooks d'un cluster.</td>
<td>-</td>
<td><code>[GET /v1/clusters/{idOrName}/webhooks](https://containers.cloud.ibm.com/swagger-api/#!/clusters/GetClusterWebhooks)</code></td>
</tr>
<tr>
<td>Afficher les informations d'un noeud worker.</td>
<td><code>[ibmcloud ks worker-get](/docs/containers?topic=containers-cs_cli_reference#cs_worker_get)</code></td>
<td><code>[GET /v1/clusters/{idOrName}/workers/{workerId}](https://containers.cloud.ibm.com/swagger-api/#!/clusters/GetWorkers)</code></td>
</tr>
<tr>
<td>Afficher les informations d'un pool de noeuds worker.</td>
<td><code>[ibmcloud ks worker-pool-get](/docs/containers?topic=containers-cs_cli_reference#cs_worker_pool_get)</code></td>
<td><code>[GET /v1/clusters/{idOrName}/workerpools/{poolidOrName}](https://containers.cloud.ibm.com/swagger-api/#!/clusters/GetWorkerPool)</code></td>
</tr>
<tr>
<td>Répertorier tous les pools de noeuds worker dans un cluster.</td>
<td><code>[ibmcloud ks worker-pools](/docs/containers?topic=containers-cs_cli_reference#cs_worker_pools)</code></td>
<td><code>[GET /v1/clusters/{idOrName}/workerpools](https://containers.cloud.ibm.com/swagger-api/#!/clusters/GetWorkerPools)</code></td>
</tr>
<tr>
<td>Répertorier tous les noeuds worker dans un cluster.</td>
<td><code>[ibmcloud ks workers](/docs/containers?topic=containers-cs_cli_reference#cs_workers)</code></td>
<td><code>[GET /v1/clusters/{idOrName}/workers](https://containers.cloud.ibm.com/swagger-api/#!/clusters/GetClusterWorkers)</code></td>
</tr>
</tbody>
</table>

<table>
<caption>Présentation des commandes de l'interface de ligne de commande et des appels d'API d'Ingress qui nécessitent le rôle de plateforme Afficheur dans {{site.data.keyword.containerlong_notm}}</caption>
<thead>
<th id="view-actions-ingress">Action Ingress</th>
<th id="view-actions-cli2">Commande de l'interface de ligne de commande</th>
<th id="view-actions-api2">Appel d'API</th>
</thead>
<tbody>
<tr>
<td>Afficher les informations d'un équilibreur de charge d'application (ALB) Ingress.</td>
<td><code>[ibmcloud ks alb-get](/docs/containers?topic=containers-cs_cli_reference#cs_alb_get)</code></td>
<td><code>[GET /albs/{albId}](https://containers.cloud.ibm.com/swagger-alb-api/#!/alb/GetClusterALB)</code></td>
</tr>
<tr>
<td>Afficher tous les types d'ALB pris en charge dans la région.</td>
<td><code>[ibmcloud ks alb-types](/docs/containers?topic=containers-cs_cli_reference#cs_alb_types)</code></td>
<td><code>[GET /albtypes](https://containers.cloud.ibm.com/swagger-alb-api/#!/util/GetAvailableALBTypes)</code></td>
</tr>
<tr>
<td>Répertorier tous les ALB Ingress dans un cluster.</td>
<td><code>[ibmcloud ks albs](/docs/containers?topic=containers-cs_cli_reference#cs_albs)</code></td>
<td><code>[GET /clusters/{idOrName}](https://containers.cloud.ibm.com/swagger-alb-api/#!/alb/GetClusterALBs)</code></td>
</tr>
</tbody>
</table>


<table>
<caption>Présentation des commandes de l'interface de ligne de commande et des appels d'API de consignation qui nécessitent le rôle de plateforme Afficheur dans {{site.data.keyword.containerlong_notm}}</caption>
<thead>
<th id="view-actions-log">Action de consignation</th>
<th id="view-actions-cli3">Commande de l'interface de ligne de commande</th>
<th id="view-actions-api3">Appel d'API</th>
</thead>
<tbody>
<tr>
<td>Afficher le statut des mises à jour automatiques du module complémentaire Fluentd.</td>
<td><code>[ibmcloud ks logging-autoupdate-get](/docs/containers?topic=containers-cs_cli_reference#cs_log_autoupdate_get)</code></td>
<td><code>[GET /v1/logging/{idOrName}/updatepolicy](https://containers.cloud.ibm.com/swagger-logging/#!/logging/GetUpdatePolicy)</code></td>
</tr>
<tr>
<td>Afficher le noeud final de consignation par défaut correspondant à la région cible.</td>
<td>-</td>
<td><code>[GET /v1/logging/{idOrName}/default](https://containers.cloud.ibm.com/swagger-logging/#!/logging/GetDefaultLoggingEndpoint)</code></td>
</tr>
<tr>
<td>Répertorier toutes les configurations d'acheminement des journaux dans le cluster ou correspondant à une source de journal spécifique dans le cluster.</td>
<td><code>[ibmcloud ks logging-config-get](/docs/containers?topic=containers-cs_cli_reference#cs_logging_get)</code></td>
<td><code>[GET /v1/logging/{idOrName}/loggingconfig](https://containers.cloud.ibm.com/swagger-logging/#!/logging/FetchLoggingConfigs) et [GET /v1/logging/{idOrName}/loggingconfig/{logSource}](https://containers.cloud.ibm.com/swagger-logging/#!/logging/FetchLoggingConfigsForSource)</code></td>
</tr>
<tr>
<td>Afficher les informations d'une configuration de filtrage des journaux.</td>
<td><code>[ibmcloud ks logging-filter-get](/docs/containers?topic=containers-cs_cli_reference#cs_log_filter_view)</code></td>
<td><code>[GET /v1/logging/{idOrName}/filterconfigs/{id}](https://containers.cloud.ibm.com/swagger-logging/#!/filter/FetchFilterConfig)</code></td>
</tr>
<tr>
<td>Répertorier toutes les configurations de filtrage des journaux dans le cluster.</td>
<td><code>[ibmcloud ks logging-filter-get](/docs/containers?topic=containers-cs_cli_reference#cs_log_filter_view)</code></td>
<td><code>[GET /v1/logging/{idOrName}/filterconfigs](https://containers.cloud.ibm.com/swagger-logging/#!/filter/FetchFilterConfigs)</code></td>
</tr>
</tbody>
</table>

### Actions de l'éditeur
{: #editor-actions}

Le rôle de plateforme **Editeur** comprend les droits octroyés par le rôle **Afficheur**, plus les droits suivants. **Astuce** : utilisez ce rôle pour les développeurs d'applications, et affectez le rôle **Développeur** de <a href="#cloud-foundry">Cloud Foundry</a>.
{: shortdesc}

<table>
<caption>Présentation des commandes de l'interface de ligne de commande et des appels d'API de gestion de cluster qui nécessitent le rôle de plateforme Editeur dans {{site.data.keyword.containerlong_notm}}</caption>
<thead>
<th id="editor-actions-mngt">Action de gestion de cluster</th>
<th id="editor-actions-cli">Commande de l'interface de ligne de commande</th>
<th id="editor-actions-api">Appel d'API</th>
</thead>
<tbody>
<tr>
<td>Lier un service à un cluster. **Remarque** : le rôle Développeur de Cloud Foundry dans l'espace où se trouve le service est également requis.</td>
<td><code>[ibmcloud ks cluster-service-bind](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_service_bind)</code></td>
<td><code>[POST /v1/clusters/{idOrName}/services](https://containers.cloud.ibm.com/swagger-api/#!/clusters/BindServiceToNamespace)</code></td>
</tr>
<tr>
<td>Annuler la liaison d'un service à un cluster. **Remarque** : le rôle Développeur de Cloud Foundry dans l'espace où se trouve le service est également requis.</td>
<td><code>[ibmcloud ks cluster-service-unbind](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_service_unbind)</code></td>
<td><code>[DELETE /v1/clusters/{idOrName}/services/{namespace}/{serviceInstanceId}](https://containers.cloud.ibm.com/swagger-api/#!/clusters/UnbindServiceFromNamespace)</code></td>
</tr>
<tr>
<td>Créer un webhook dans un cluster.</td>
<td><code>[ibmcloud ks webhook-create](/docs/containers?topic=containers-cs_cli_reference#cs_webhook_create)</code></td>
<td><code>[POST /v1/clusters/{idOrName}/webhooks](https://containers.cloud.ibm.com/swagger-api/#!/clusters/AddClusterWebhooks)</code></td>
</tr>
</tbody>
</table>

<table>
<caption>Présentation des commandes de l'interface de ligne de commande et des appels d'API d'Ingress qui nécessitent le rôle de plateforme Editeur dans {{site.data.keyword.containerlong_notm}}</caption>
<thead>
<th id="editor-actions-ingress">Action Ingress</th>
<th id="editor-actions-cli2">Commande de l'interface de ligne de commande</th>
<th id="editor-actions-api2">Appel d'API</th>
</thead>
<tbody>
<tr>
<td>Désactiver les mises à jour automatiques du module complémentaire ALB Ingress.</td>
<td><code>[ibmcloud ks alb-autoupdate-disable](/docs/containers?topic=containers-cs_cli_reference#cs_alb_autoupdate_disable)</code></td>
<td><code>[PUT /clusters/{idOrName}/updatepolicy](https://containers.cloud.ibm.com/swagger-alb-api/#!/alb/ChangeUpdatePolicy)</code></td>
</tr>
<tr>
<td>Activer les mises à jour automatiques du module complémentaire ALB Ingress.</td>
<td><code>[ibmcloud ks alb-autoupdate-enable](/docs/containers?topic=containers-cs_cli_reference#cs_alb_autoupdate_enable)</code></td>
<td><code>[PUT /clusters/{idOrName}/updatepolicy](https://containers.cloud.ibm.com/swagger-alb-api/#!/alb/ChangeUpdatePolicy)</code></td>
</tr>
<tr>
<td>Vérifier si les mises à jour automatiques du module complémentaire ALB Ingress sont activées.</td>
<td><code>[ibmcloud ks alb-autoupdate-get](/docs/containers?topic=containers-cs_cli_reference#cs_alb_autoupdate_get)</code></td>
<td><code>[GET /clusters/{idOrName}/updatepolicy](https://containers.cloud.ibm.com/swagger-alb-api/#!/alb/GetUpdatePolicy)</code></td>
</tr>
<tr>
<td>Activer ou désactiver un ALB Ingress.</td>
<td><code>[ibmcloud ks alb-configure](/docs/containers?topic=containers-cs_cli_reference#cs_alb_configure)</code></td>
<td><code>[POST /albs](https://containers.cloud.ibm.com/swagger-alb-api/#!/alb/EnableALB) et [DELETE /albs/{albId}](https://containers.cloud.ibm.com/swagger-alb-api/#/)</code></td>
</tr>
<tr>
<td>Annuler une mise à jour du module complémentaire ALB Ingress dans la génération dans laquelle s'exécutaient vos pods d'ALB auparavant.</td>
<td><code>[ibmcloud ks alb-rollback](/docs/containers?topic=containers-cs_cli_reference#cs_alb_rollback)</code></td>
<td><code>[PUT /clusters/{idOrName}/updaterollback](https://containers.cloud.ibm.com/swagger-alb-api/#!/alb/RollbackUpdate)</code></td>
</tr>
<tr>
<td>Forcer une mise à jour unique de vos pods ALB par une mise à jour manuelle du module complémentaire ALB Ingress.</td>
<td><code>[ibmcloud ks alb-update](/docs/containers?topic=containers-cs_cli_reference#cs_alb_update)</code></td>
<td><code>[PUT /clusters/{idOrName}/update](https://containers.cloud.ibm.com/swagger-alb-api/#!/alb/UpdateALBs)</code></td>
</tr>
</tbody>
</table>



<table>
<caption>Présentation des commandes de l'interface de ligne de commande et des appels d'API de consignation qui nécessitent le rôle de plateforme Editeur dans {{site.data.keyword.containerlong_notm}}</caption>
<thead>
<th id="editor-log">Action de consignation</th>
<th id="editor-cli3">Commande de l'interface de ligne de commande</th>
<th id="editor-api3">Appel d'API</th>
</thead>
<tbody>
<tr>
<td>Créer un webhook d'audit de serveur d'API.</td>
<td><code>[ibmcloud ks apiserver-config-set](/docs/containers?topic=containers-cs_cli_reference#cs_apiserver_config_set)</code></td>
<td><code>[PUT /v1/clusters/{idOrName}/apiserverconfigs/auditwebhook](https://containers.cloud.ibm.com/swagger-api/#!/clusters/apiserverconfigs/UpdateAuditWebhook)</code></td>
</tr>
<tr>
<td>Supprimer un webhook d'audit de serveur d'API.</td>
<td><code>[ibmcloud ks apiserver-config-unset](/docs/containers?topic=containers-cs_cli_reference#cs_apiserver_config_unset)</code></td>
<td><code>[DELETE /v1/clusters/{idOrName}/apiserverconfigs/auditwebhook](https://containers.cloud.ibm.com/swagger-api/#!/apiserverconfigs/DeleteAuditWebhook)</code></td>
</tr>
<tr>
<td>Créer une configuration d'acheminement des journaux pour toutes les sources de journal sauf <code>kube-audit</code>.</td>
<td><code>[ibmcloud ks logging-config-create](/docs/containers?topic=containers-cs_cli_reference#cs_logging_create)</code></td>
<td><code>[POST /v1/logging/{idOrName}/loggingconfig/{logSource}](https://containers.cloud.ibm.com/swagger-logging/#!/logging/CreateLoggingConfig)</code></td>
</tr>
<tr>
<td>Actualiser une configuration d'acheminement des journaux.</td>
<td><code>[ibmcloud ks logging-config-refresh](/docs/containers?topic=containers-cs_cli_reference#cs_logging_refresh)</code></td>
<td><code>[PUT /v1/logging/{idOrName}/refresh](https://containers.cloud.ibm.com/swagger-logging/#!/logging/RefreshLoggingConfig)</code></td>
</tr>
<tr>
<td>Supprimer une configuration d'acheminement des journaux pour toutes les sources de journal sauf <code>kube-audit</code>.</td>
<td><code>[ibmcloud ks logging-config-rm](/docs/containers?topic=containers-cs_cli_reference#cs_logging_rm)</code></td>
<td><code>[DELETE /v1/logging/{idOrName}/loggingconfig/{logSource}/{id}](https://containers.cloud.ibm.com/swagger-logging/#!/logging/DeleteLoggingConfig)</code></td>
</tr>
<tr>
<td>Supprimer toutes les configurations d'acheminement des journaux d'un cluster.</td>
<td>-</td>
<td><code>[DELETE /v1/logging/{idOrName}/loggingconfig](https://containers.cloud.ibm.com/swagger-logging/#!/logging/DeleteLoggingConfigs)</code></td>
</tr>
<tr>
<td>Mettre à jour une configuration d'acheminement des journaux.</td>
<td><code>[ibmcloud ks logging-config-update](/docs/containers?topic=containers-cs_cli_reference#cs_logging_update)</code></td>
<td><code>[PUT /v1/logging/{idOrName}/loggingconfig/{logSource}/{id}](https://containers.cloud.ibm.com/swagger-logging/#!/logging/UpdateLoggingConfig)</code></td>
</tr>
<tr>
<td>Créer une configuration de filtrage des journaux.</td>
<td><code>[ibmcloud ks logging-filter-create](/docs/containers?topic=containers-cs_cli_reference#cs_log_filter_create)</code></td>
<td><code>[POST /v1/logging/{idOrName}/filterconfigs](https://containers.cloud.ibm.com/swagger-logging/#!/filter/CreateFilterConfig)</code></td>
</tr>
<tr>
<td>Supprimer une configuration de filtrage des journaux.</td>
<td><code>[ibmcloud ks logging-filter-rm](/docs/containers?topic=containers-cs_cli_reference#cs_log_filter_delete)</code></td>
<td><code>[DELETE /v1/logging/{idOrName}/filterconfigs/{id}](https://containers.cloud.ibm.com/swagger-logging/#!/filter/DeleteFilterConfig)</code></td>
</tr>
<tr>
<td>Supprimer toutes les configurations de filtrage des journaux du cluster Kubernetes.</td>
<td>-</td>
<td><code>[DELETE /v1/logging/{idOrName}/filterconfigs](https://containers.cloud.ibm.com/swagger-logging/#!/filter/DeleteFilterConfigs)</code></td>
</tr>
<tr>
<td>Mettre à jour une configuration de filtrage des journaux.</td>
<td><code>[ibmcloud ks logging-filter-update](/docs/containers?topic=containers-cs_cli_reference#cs_log_filter_update)</code></td>
<td><code>[PUT /v1/logging/{idOrName}/filterconfigs/{id}](https://containers.cloud.ibm.com/swagger-logging/#!/filter/UpdateFilterConfig)</code></td>
</tr>
</tbody>
</table>

### Actions de l'opérateur
{: #operator-actions}

Le rôle de plateforme **Opérateur** comprend les droits octroyés par le rôle **Afficheur**, ainsi que les droits présentés dans le tableau suivant.
{: shortdesc}

<table>
<caption>Présentation des commandes de l'interface de ligne de commande et des appels d'API de gestion de cluster qui nécessitent le rôle de plateforme Opérateur dans {{site.data.keyword.containerlong_notm}}</caption>
<thead>
<th id="operator-mgmt">Action de gestion de cluster</th>
<th id="operator-cli">Commande de l'interface de ligne de commande</th>
<th id="operator-api">Appel d'API</th>
</thead>
<tbody>
<tr>
<td>Actualiser le maître Kubernetes.</td>
<td><code>[ibmcloud ks apiserver-refresh](/docs/containers?topic=containers-cs_cli_reference#cs_apiserver_refresh)</code></td>
<td><code>[PUT /v1/clusters/{idOrName}/masters](https://containers.cloud.ibm.com/swagger-api/#!/clusters/HandleMasterAPIServer)</code></td>
</tr>
<tr>
<td>Créer un ID de service {{site.data.keyword.Bluemix_notm}} IAM pour le cluster, ainsi qu'une règle pour cet ID de service pour affecter le rôle d'accès au service **Lecteur** dans {{site.data.keyword.registrylong_notm}}, puis créer une clé d'API pour l'ID de service. </td>
<td><code>[ibmcloud ks cluster-pull-secret-apply](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_pull_secret_apply)</code></td>
<td>-</td>
</tr>
<tr>
<td>Redémarrer le noeud du maître cluster pour appliquer les nouvelles modifications apportées à la configuration de l'API Kubernetes.</td>
<td><code>[ibmcloud ks cluster-refresh](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_refresh)</code></td>
<td><code>[PUT /v1/clusters/{idOrName}/masters](https://containers.cloud.ibm.com/swagger-api/#!/clusters/HandleMasterAPIServer)</code></td>
</tr>
<tr>
<td>Ajouter un sous-réseau à un cluster.</td>
<td><code>[ibmcloud ks cluster-subnet-add](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_subnet_add)</code></td>
<td><code>[PUT /v1/clusters/{idOrName}/subnets/{subnetId}](https://containers.cloud.ibm.com/swagger-api/#!/clusters/AddClusterSubnet)</code></td>
</tr>
<tr>
<td>Créer un sous-réseau.</td>
<td><code>[ibmcloud ks cluster-subnet-create](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_subnet_create)</code></td>
<td><code>[POST /v1/clusters/{idOrName}/vlans/{vlanId}](https://containers.cloud.ibm.com/swagger-api/#!/clusters/CreateClusterSubnet)</code></td>
</tr>
<tr>
<td>Mettre à jour un cluster.</td>
<td><code>[ibmcloud ks cluster-update](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_update)</code></td>
<td><code>[PUT /v1/clusters/{idOrName}](https://containers.cloud.ibm.com/swagger-api/#!/clusters/UpdateCluster)</code></td>
</tr>
<tr>
<td>Ajouter un sous-réseau géré par l'utilisateur à un cluster.</td>
<td><code>[ibmcloud ks cluster-user-subnet-add](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_user_subnet_add)</code></td>
<td><code>[POST /v1/clusters/{idOrName}/usersubnets](https://containers.cloud.ibm.com/swagger-api/#!/clusters/AddClusterUserSubnet)</code></td>
</tr>
<tr>
<td>Retirer un sous-réseau géré par l'utilisateur d'un cluster.</td>
<td><code>[ibmcloud ks cluster-user-subnet-rm](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_user_subnet_rm)</code></td>
<td><code>[DELETE /v1/clusters/{idOrName}/usersubnets/{subnetId}/vlans/{vlanId}](https://containers.cloud.ibm.com/swagger-api/#!/clusters/RemoveClusterUserSubnet)</code></td>
</tr>
<tr>
<td>Ajouter des noeuds worker.</td>
<td><code>[ibmcloud ks worker-add (deprecated)](/docs/containers?topic=containers-cs_cli_reference#cs_worker_add)</code></td>
<td><code>[POST /v1/clusters/{idOrName}/workers](https://containers.cloud.ibm.com/swagger-api/#!/clusters/AddClusterWorkers)</code></td>
</tr>
<tr>
<td>Créer un pool de noeuds worker.</td>
<td><code>[ibmcloud ks worker-pool-create](/docs/containers?topic=containers-cs_cli_reference#cs_worker_pool_create)</code></td>
<td><code>[POST /v1/clusters/{idOrName}/workerpools](https://containers.cloud.ibm.com/swagger-api/#!/clusters/CreateWorkerPool)</code></td>
</tr>
<tr>
<td>Rééquilibrer un pool de noeuds worker.</td>
<td><code>[ibmcloud ks worker-pool-rebalance](/docs/containers?topic=containers-cs_cli_reference#cs_rebalance)</code></td>
<td><code>[PATCH /v1/clusters/{idOrName}/workerpools/{poolidOrName}](https://containers.cloud.ibm.com/swagger-api/#!/clusters/PatchWorkerPool)</code></td>
</tr>
<tr>
<td>Redimensionner un pool de noeuds worker.</td>
<td><code>[ibmcloud ks worker-pool-resize](/docs/containers?topic=containers-cs_cli_reference#cs_worker_pool_resize)</code></td>
<td><code>[PATCH /v1/clusters/{idOrName}/workerpools/{poolidOrName}](https://containers.cloud.ibm.com/swagger-api/#!/clusters/PatchWorkerPool)</code></td>
</tr>
<tr>
<td>Supprimer un pool de noeuds worker.</td>
<td><code>[ibmcloud ks worker-pool-rm](/docs/containers?topic=containers-cs_cli_reference#cs_worker_pool_rm)</code></td>
<td><code>[DELETE /v1/clusters/{idOrName}/workerpools/{poolidOrName}](https://containers.cloud.ibm.com/swagger-api/#!/clusters/RemoveWorkerPool)</code></td>
</tr>
<tr>
<td>Réamorcer un noeud worker.</td>
<td><code>[ibmcloud ks worker-reboot](/docs/containers?topic=containers-cs_cli_reference#cs_worker_reboot)</code></td>
<td><code>[PUT /v1/clusters/{idOrName}/workers/{workerId}](https://containers.cloud.ibm.com/swagger-api/#!/clusters/UpdateClusterWorker)</code></td>
</tr>
<tr>
<td>Recharger un noeud worker.</td>
<td><code>[ibmcloud ks worker-reload](/docs/containers?topic=containers-cs_cli_reference#cs_worker_reload)</code></td>
<td><code>[PUT /v1/clusters/{idOrName}/workers/{workerId}](https://containers.cloud.ibm.com/swagger-api/#!/clusters/UpdateClusterWorker)</code></td>
</tr>
<tr>
<td>Retirer un noeud worker.</td>
<td><code>[ibmcloud ks worker-rm](/docs/containers?topic=containers-cs_cli_reference#cs_worker_rm)</code></td>
<td><code>[DELETE /v1/clusters/{idOrName}/workers/{workerId}](https://containers.cloud.ibm.com/swagger-api/#!/clusters/RemoveClusterWorker)</code></td>
</tr>
<tr>
<td>Mettre à jour un noeud worker.</td>
<td><code>[ibmcloud ks worker-update](/docs/containers?topic=containers-cs_cli_reference#cs_worker_update)</code></td>
<td><code>[PUT /v1/clusters/{idOrName}/workers/{workerId}](https://containers.cloud.ibm.com/swagger-api/#!/clusters/UpdateClusterWorker)</code></td>
</tr>
<tr>
<td>Ajouter une zone à un pool de noeuds worker.</td>
<td><code>[ibmcloud ks zone-add](/docs/containers?topic=containers-cs_cli_reference#cs_zone_add)</code></td>
<td><code>[POST /v1/clusters/{idOrName}/workerpools/{poolidOrName}/zones](https://containers.cloud.ibm.com/swagger-api/#!/clusters/AddWorkerPoolZone)</code></td>
</tr>
<tr>
<td>Mettre à jour la configuration réseau d'une zone donnée dans un pool de noeuds worker.</td>
<td><code>[ibmcloud ks zone-network-set](/docs/containers?topic=containers-cs_cli_reference#cs_zone_network_set)</code></td>
<td><code>[PATCH /v1/clusters/{idOrName}/workerpools/{poolidOrName}/zones/{zoneid}](https://containers.cloud.ibm.com/swagger-api/#!/clusters/AddWorkerPoolZoneNetwork)</code></td>
</tr>
<tr>
<td>Retirer une zone d'un pool de noeuds worker.</td>
<td><code>[ibmcloud ks zone-rm](/docs/containers?topic=containers-cs_cli_reference#cs_zone_rm)</code></td>
<td><code>[DELETE /v1/clusters/{idOrName}/workerpools/{poolidOrName}/zones/{zoneid}](https://containers.cloud.ibm.com/swagger-api/#!/clusters/RemoveWorkerPoolZone)</code></td>
</tr>
</tbody>
</table>

### Actions de l'administrateur
{: #admin-actions}

Le rôle de plateforme **Administrateur** comprend tous les droits octroyés par les rôles **Afficheur**, **Editeur** et **Opérateur**, ainsi que les droits suivants. Pour créer des ressources, telles que des machines, des VLAN et des sous-réseaux, les administrateurs requièrent le <a href="#infra">rôle d'infrastructure</a> **Superutilisateur**.
{: shortdesc}

<table>
<caption>Présentation des commandes de l'interface de ligne de commande et des appels d'API de gestion de cluster qui nécessitent le rôle de plateforme Administrateur dans {{site.data.keyword.containerlong_notm}}</caption>
<thead>
<th id="admin-mgmt">Action de gestion de cluster</th>
<th id="admin-cli">Commande de l'interface de ligne de commande</th>
<th id="admin-api">Appel d'API</th>
</thead>
<tbody>
<tr>
<td>Définir la clé d'API pour le compte {{site.data.keyword.Bluemix_notm}} afin d'accéder au portefeuille d'infrastructure IBM Cloud (SoftLayer) lié.</td>
<td><code>[ibmcloud ks api-key-reset](/docs/containers?topic=containers-cs_cli_reference#cs_api_key_reset)</code></td>
<td><code>[POST /v1/keys](https://containers.cloud.ibm.com/swagger-api/#!/accounts/ResetUserAPIKey)</code></td>
</tr>
<tr>
<td>Désactiver un module complémentaire géré, par exemple Istio ou Knative, dans un cluster.</td>
<td><code>[ibmcloud ks cluster-addon-disable](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_addon_disable)</code></td>
<td><code>[PATCH /v1/clusters/{idOrName}/addons](https://containers.cloud.ibm.com/swagger-api/#!/clusters/ManageClusterAddons)</code></td>
</tr>
<tr>
<td>Activer un module complémentaire géré, par exemple Istio ou Knative, dans un cluster.</td>
<td><code>[ibmcloud ks cluster-addon-enable](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_addon_enable)</code></td>
<td><code>[PATCH /v1/clusters/{idOrName}/addons](https://containers.cloud.ibm.com/swagger-api/#!/clusters/ManageClusterAddons)</code></td>
</tr>
<tr>
<td>Répertorier les modules complémentaires gérés, par exemple Istio ou Knative, activés dans un cluster.</td>
<td><code>[ibmcloud ks cluster-addons](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_addons)</code></td>
<td><code>[GET /v1/clusters/{idOrName}/addons](https://containers.cloud.ibm.com/swagger-api/#!/clusters/GetClusterAddons)</code></td>
</tr>
<tr>
<td>Créer un cluster gratuit ou standard. **Remarque** : le rôle de plateforme Administrateur pour {{site.data.keyword.registrylong_notm}} et le rôle d'infrastructure Superutilisateur sont également requis.</td>
<td><code>[ibmcloud ks cluster-create](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_create)</code></td>
<td><code>[POST /v1/clusters](https://containers.cloud.ibm.com/swagger-api/#!/clusters/CreateCluster)</code></td>
</tr>
<tr>
<td>Désactiver la fonction indiquée d'un cluster, par exemple le noeud final de service public pour le maître cluster.</td>
<td><code>[ibmcloud ks cluster-feature-disable](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_feature_disable)</code></td>
<td>-</td>
</tr>
<tr>
<td>Activer la fonction indiquée d'un cluster, par exemple le noeud final de service privé pour le maître cluster.</td>
<td><code>[ibmcloud ks cluster-feature-enable](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_feature_enable)</code></td>
<td>-</td>
</tr>
<tr>
<td>Répertorier les fonctions activées dans un cluster.</td>
<td><code>[ibmcloud ks cluster-features](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_feature_ls)</code></td>
<td>-</td>
</tr>
<tr>
<td>Supprimer un cluster.</td>
<td><code>[ibmcloud ks cluster-rm](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_rm)</code></td>
<td><code>[DELETE /v1/clusters/{idOrName}](https://containers.cloud.ibm.com/swagger-api/#!/clusters/RemoveCluster)</code></td>
</tr>
<tr>
<td>Définir les données d'identification d'infrastructure pour le compte {{site.data.keyword.Bluemix_notm}} pour accéder à un autre portefeuille d'infrastructure IBM Cloud (SoftLayer).</td>
<td><code>[ibmcloud ks credential-set](/docs/containers?topic=containers-cs_cli_reference#cs_credentials_set)</code></td>
<td><code>[POST /v1/credentials](https://containers.cloud.ibm.com/swagger-api/#!/clusters/accounts/StoreUserCredentials)</code></td>
</tr>
<tr>
<td>Retirer les données d'identification d'infrastructure pour le compte {{site.data.keyword.Bluemix_notm}} pour accéder à un autre portefeuille d'infrastructure IBM Cloud (SoftLayer).</td>
<td><code>[ibmcloud ks credential-unset](/docs/containers?topic=containers-cs_cli_reference#cs_credentials_unset)</code></td>
<td><code>[DELETE /v1/credentials](https://containers.cloud.ibm.com/swagger-api/#!/clusters/accounts/RemoveUserCredentials)</code></td>
</tr>
<tr>
<td>Chiffrer des valeurs confidentielles (secrets) de Kubernetes à l'aide d'{{site.data.keyword.keymanagementservicefull}}.</td>
<td><code>[ibmcloud ks key-protect-enable](/docs/containers?topic=containers-cs_cli_reference#cs_messages)</code></td>
<td><code>[POST /v1/clusters/{idOrName}/kms](https://containers.cloud.ibm.com/swagger-api/#!/clusters/CreateKMSConfig)</code></td>
</tr>
</tbody>
</table>

<table>
<caption>Présentation des commandes de l'interface de ligne de commande et des appels d'API d'Ingress qui nécessitent le rôle de plateforme Administrateur dans {{site.data.keyword.containerlong_notm}}</caption>
<thead>
<th id="admin-ingress">Action Ingress</th>
<th id="admin-cli2">Commande de l'interface de ligne de commande</th>
<th id="admin-api2">Appel d'API</th>
</thead>
<tbody>
<tr>
<td>Déployer ou mettre à jour un certificat à partir de votre instance {{site.data.keyword.cloudcerts_long_notm}} sur un ALB.</td>
<td><code>[ibmcloud ks alb-cert-deploy](/docs/containers?topic=containers-cs_cli_reference#cs_alb_cert_deploy)</code></td>
<td><code>[POST /albsecrets](https://containers.cloud.ibm.com/swagger-alb-api/#!/alb/CreateALBSecret) ou [PUT /albsecrets](https://containers.cloud.ibm.com/swagger-alb-api/#!/alb/UpdateALBSecret)</code></td>
</tr>
<tr>
<td>Afficher les détails d'une valeur confidentielle (secret) ALB dans un cluster.</td>
<td><code>[ibmcloud ks alb-cert-get](/docs/containers?topic=containers-cs_cli_reference#cs_alb_cert_get)</code></td>
<td><code>[GET /clusters/{idOrName}/albsecrets](https://containers.cloud.ibm.com/swagger-alb-api/#!/alb/ViewClusterALBSecrets)</code></td>
</tr>
<tr>
<td>Retirer une valeur confidentielle (secret) ALB d'un cluster.</td>
<td><code>[ibmcloud ks alb-cert-rm](/docs/containers?topic=containers-cs_cli_reference#cs_alb_cert_rm)</code></td>
<td><code>[DELETE /clusters/{idOrName}/albsecrets](https://containers.cloud.ibm.com/swagger-alb-api/#!/alb/DeleteClusterALBSecrets)</code></td>
</tr>
<tr>
<td>Répertorier toutes les valeurs confidentielles (secrets) ALB dans un cluster.</td>
<td><code>[ibmcloud ks alb-certs](/docs/containers?topic=containers-cs_cli_reference#cs_alb_certs)</code></td>
<td>-</td>
</tr>
</tbody>
</table>

<table>
<caption>Présentation des commandes de l'interface de ligne de commande et des appels d'API de consignation qui nécessitent le rôle de plateforme Administrateur dans {{site.data.keyword.containerlong_notm}}</caption>
<thead>
<th id="admin-log">Action de consignation</th>
<th id="admin-cli3">Commande de l'interface de ligne de commande</th>
<th id="admin-api3">Appel d'API</th>
</thead>
<tbody>
<tr>
<td>Désactiver les mises à jour automatiques du module complémentaire de cluster Fluentd.</td>
<td><code>[ibmcloud ks logging-autoupdate-disable](/docs/containers?topic=containers-cs_cli_reference#cs_log_autoupdate_disable)</code></td>
<td><code>[PUT /v1/logging/{idOrName}/updatepolicy](https://containers.cloud.ibm.com/swagger-logging/#!/logging/ChangeUpdatePolicy)</code></td>
</tr>
<tr>
<td>Activer les mises à jour automatiques du module complémentaire de cluster Fluentd.</td>
<td><code>[ibmcloud ks logging-autoupdate-enable](/docs/containers?topic=containers-cs_cli_reference#cs_log_autoupdate_enable)</code></td>
<td><code>[PUT /v1/logging/{idOrName}/updatepolicy](https://containers.cloud.ibm.com/swagger-logging/#!/logging/ChangeUpdatePolicy)</code></td>
</tr>
<tr>
<td>Collecter un instantané des journaux de serveur d'API dans un compartiment {{site.data.keyword.cos_full_notm}}.</td>
<td><code>[ibmcloud ks logging-collect](/docs/containers?topic=containers-cs_cli_reference#cs_log_collect)</code></td>
<td>-</td>
</tr>
<tr>
<td>Voir le statut de la demande d'instantané de journaux du serveur d'API.</td>
<td><code>[ibmcloud ks logging-collect-status](/docs/containers?topic=containers-cs_cli_reference#cs_log_collect_status)</code></td>
<td>-</td>
</tr>
<tr>
<td>Créer une configuration d'acheminement des journaux pour la source de journal <code>kube-audit</code>.</td>
<td><code>[ibmcloud ks logging-config-create](/docs/containers?topic=containers-cs_cli_reference#cs_logging_create)</code></td>
<td><code>[POST /v1/logging/{idOrName}/loggingconfig/{logSource}](https://containers.cloud.ibm.com/swagger-logging/#!/logging/CreateLoggingConfig)</code></td>
</tr>
<tr>
<td>Supprimer une configuration d'acheminement des journaux pour la source de journal <code>kube-audit</code>.</td>
<td><code>[ibmcloud ks logging-config-rm](/docs/containers?topic=containers-cs_cli_reference#cs_logging_rm)</code></td>
<td><code>[DELETE /v1/logging/{idOrName}/loggingconfig/{logSource}/{id}](https://containers.cloud.ibm.com/swagger-logging/#!/logging/DeleteLoggingConfig)</code></td>
</tr>
</tbody>
</table>

<br />


## Rôles de service {{site.data.keyword.Bluemix_notm}} IAM
{: #service}

Tous les utilisateurs auxquels est affecté un rôle d'accès au service {{site.data.keyword.Bluemix_notm}} IAM bénéficient automatiquement d'un rôle Kubernetes RBAC (contrôle d'accès à base de rôles) dans un espace de nom spécifié. Pour en savoir plus sur les rôles d'accès au service, voir [Rôles de service {{site.data.keyword.Bluemix_notm}} IAM](/docs/containers?topic=containers-users#platform). Pour en savoir plus sur les rôles RBAC, voir [Affectation de droits RBAC](/docs/containers?topic=containers-users#role-binding).
{: shortdesc}

Vous recherchez les actions Kubernetes que chaque rôle de service autorise via RBAC ? Voir [Droits d'accès aux ressources Kubernetes par rôle RBAC](#rbac).
{: tip}

Le tableau suivant présente les droits d'accès aux ressources Kubernetes octroyés par chaque rôle de service et le rôle RBAC correspondant.

<table>
<caption>Droits d'accès aux ressources Kubernetes par service et rôles RBAC correspondants</caption>
<thead>
    <th id="service-role">Rôle de service</th>
    <th id="rbac-role">Rôle RBAC correspondant, liaison et portée</th>
    <th id="kube-perm">Droits d'accès aux ressources Kubernetes</th>
</thead>
<tbody>
  <tr>
    <td id="service-role-reader" headers="service-role">Rôle Lecteur</td>
    <td headers="service-role-reader rbac-role">Lorsque sa portée comprend un espace de nom : rôle de cluster <strong><code>view</code></strong> appliqué par la liaison de rôle <strong><code>ibm-view</code></strong> dans cet espace de nom</br><br>Lorsque sa portée comprend tous les espaces de nom : rôle de cluster <strong><code>view</code></strong> appliqué par la liaison de rôle <strong><code>ibm-view</code></strong> dans chaque espace de nom du cluster</td>
    <td headers="service-role-reader kube-perm"><ul>
      <li>Accès en lecture aux ressources dans un espace de nom</li>
      <li>Aucun accès en lecture aux rôles et aux liaisons de rôle ou aux valeurs confidentielles (secrets) de Kubernetes</li>
      <li>Accès au tableau de bord pour afficher les ressources dans un espace de nom</li></ul>
    </td>
  </tr>
  <tr>
    <td id="service-role-writer" headers="service-role">Rôle Auteur</td>
    <td headers="service-role-writer rbac-role">Lorsque sa portée comprend un espace de nom : rôle de cluster <strong><code>edit</code></strong> appliqué par la liaison de rôle <strong><code>ibm-edit</code></strong> dans cet espace de nom</br><br>Lorsque sa portée comprend tous les espaces de nom : rôle de cluster <strong><code>edit</code></strong> appliqué par la liaison de rôle <strong><code>ibm-edit</code></strong> dans chaque espace de nom du cluster</td>
    <td headers="service-role-writer kube-perm"><ul><li>Accès en lecture et en écriture aux ressources dans cet espace de nom</li>
    <li>Aucun accès en lecture et en écriture aux rôles et aux liaisons de rôle</li>
    <li>Accès au tableau de bord pour afficher les ressources dans un espace de nom</li></ul>
    </td>
  </tr>
  <tr>
    <td id="service-role-manager" headers="service-role">Rôle Responsable</td>
    <td headers="service-role-manager rbac-role">Lorsque sa portée comprend un espace de nom : rôle de cluster <strong><code>admin</code></strong> appliqué par la liaison de rôle <strong><code>ibm-operate</code></strong> dans cet espace de nom</br><br>Lorsque sa portée comprend tous les espaces de nom : rôle de cluster <strong><code>cluster-admin</code></strong> appliqué par la liaison de rôle de cluster <strong><code>ibm-admin</code></strong></td> qui s'applique à tous les espaces de nom
    <td headers="service-role-manager kube-perm">Lorsque sa portée comprend un espace de nom :
      <ul><li>Accès en lecture et en écriture à toutes les ressources dans cet espace de nom sauf au quota de ressources ou à l'espace de nom en tant que tel</li>
      <li>Créer des rôles RBAC et des liaisons de rôle dans un espace de nom</li>
      <li>Accéder au tableau de bord Kubernetes pour afficher toutes les ressources d'un espace de nom</li></ul>
    </br>Lorsque sa portée comprend tous les espaces de nom :
        <ul><li>Accès en lecture et en écriture à toutes les ressources dans tous les espaces de nom</li>
        <li>Créer des rôles RBAC et des liaisons de rôle dans un espace de nom ou des rôles de cluster et des liaisons de rôle de cluster dans tous les espaces de nom</li>
        <li>Accéder au tableau de bord Kubernetes</li>
        <li>Créer une ressource Ingress qui rend les applications accessibles au public</li>
        <li>Consulter les métriques du cluster, par exemple avec les commandes <code>kubectl top pods</code>, <code>kubectl top nodes</code> ou <code>kubectl get nodes</code></li></ul>
    </td>
  </tr>
</tbody>
</table>

<br />


## Droits d'accès aux ressources Kubernetes par rôle RBAC
{: #rbac}

Tous les utilisateurs auxquels est affecté un rôle d'accès au service {{site.data.keyword.Bluemix_notm}} IAM bénéficient automatiquement d'un rôle Kubernetes RBAC (contrôle d'accès à base de rôles) prédéfini correspondant, dans un espace de nom spécifié. Si vous envisagez de gérer vos propres rôles Kubernetes RBAC personnalisés, voir [Création de droits RBAC personnalisés pour les utilisateurs, les groupes ou les comptes de service](/docs/containers?topic=containers-users#rbac).
{: shortdesc}

Vous vous demandez si vous disposez des droits appropriés pour exécuter une commande `kubectl` spécifique sur une ressource dans un espace de nom ? Testez la [commande `kubectl auth can-i` ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#-em-can-i-em-).
{: tip}

Le tableau suivant présente les droits octroyés par chaque rôle RBAC à des ressources Kubernetes individuelles. Les droits sont représentés par des verbes correspondant à des actions qu'un utilisateur disposant de ce rôle peut effectuer sur la ressource, par exemple "get" (obtenir), "list" (répertorier), "describe" (décrire), "create" (créer) ou "delete" (supprimer).

<table>
 <caption>Droits d'accès aux ressources Kubernetes octroyés par chaque rôle RBAC prédéfini</caption>
 <thead>
  <th>Ressources Kubernetes</th>
  <th><code>view</code></th>
  <th><code>edit</code></th>
  <th><code>admin</code> et <code>cluster-admin</code></th>
 </thead>
<tbody>
<tr>
  <td>bindings</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
</tr><tr>
  <td>configmaps</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>cronjobs.batch</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>daemonsets.apps </td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>daemonsets.extensions</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>deployments.apps</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>deployments.apps/rollback</td>
  <td>-</td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>deployments.apps/scale</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>deployments.extensions</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>deployments.extensions/rollback</td>
  <td>-</td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>deployments.extensions/scale</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>endpoints</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>events</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
</tr><tr>
  <td>horizontalpodautoscalers.autoscaling</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>ingresses.extensions</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>jobs.batch</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>limitranges</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
</tr><tr>
  <td>localsubjectaccessreviews</td>
  <td>-</td>
  <td>-</td>
  <td><code>create</code></td>
</tr><tr>
  <td>namespaces</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></br>**cluster-admin only:** <code>create</code>, <code>delete</code></td>
</tr><tr>
  <td>namespaces/status</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
</tr><tr>
  <td>networkpolicies</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>networkpolicies.extensions</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>persistentvolumeclaims</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>poddisruptionbudgets.policy</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>pods</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>top</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>pods/attach</td>
  <td>-</td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>pods/exec</td>
  <td>-</td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>pods/log</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
</tr><tr>
  <td>pods/portforward</td>
  <td>-</td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>pods/proxy</td>
  <td>-</td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>pods/status</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
</tr><tr>
  <td>replicasets.apps</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>replicasets.apps/scale</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>replicasets.extensions</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>replicasets.extensions/scale</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>replicationcontrollers</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>replicationcontrollers/scale</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>replicationcontrollers/status</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
</tr><tr>
  <td>replicationcontrollers.extensions/scale</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>resourcequotas</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
</tr><tr>
  <td>resourcequotas/status</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
</tr><tr>
  <td>rolebindings</td>
  <td>-</td>
  <td>-</td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>roles</td>
  <td>-</td>
  <td>-</td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>secrets</td>
  <td>-</td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>serviceaccounts</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code>, <code>impersonate</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code>, <code>impersonate</code></td>
</tr><tr>
  <td>services</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>services/proxy</td>
  <td>-</td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>statefulsets.apps</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr><tr>
  <td>statefulsets.apps/scale</td>
  <td><code>get</code>, <code>list</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
  <td><code>create</code>, <code>delete</code>, <code>deletecollection</code>, <code>get</code>, <code>list</code>, <code>patch</code>, <code>update</code>, <code>watch</code></td>
</tr>
</tbody>
</table>

<br />


## Rôles Cloud Foundry
{: #cloud-foundry}

Les rôles Cloud Foundry octroient l'accès aux organisations et espaces figurant dans le compte. Pour afficher la liste des services Cloud Foundry dans {{site.data.keyword.Bluemix_notm}}, exécutez la commande `ibmcloud service list`. Pour en savoir plus, voir tous les [rôles d'organisation et d'espace](/docs/iam?topic=iam-cfaccess) disponibles ou la procédure à utiliser pour [gérer l'accès à Cloud Foundry](/docs/iam?topic=iam-mngcf) dans la documentation {{site.data.keyword.Bluemix_notm}} IAM.
{: shortdesc}

Le tableau suivant présente les rôles Cloud Foundry requis pour pouvoir effectuer des actions dans les clusters.

<table>
  <caption>Droits de gestion de cluster par rôle Cloud Foundry</caption>
  <thead>
    <th>Rôle Cloud Foundry</th>
    <th>Droits de gestion de cluster</th>
  </thead>
  <tbody>
  <tr>
    <td>Rôle d'espace : Responsable</td>
    <td>Gérer l'accès utilisateur à un espace {{site.data.keyword.Bluemix_notm}}</td>
  </tr>
  <tr>
    <td>Rôle d'espace : Développeur</td>
    <td>
      <ul><li>Créer des instances de service {{site.data.keyword.Bluemix_notm}}</li>
      <li>Lier des instances de service {{site.data.keyword.Bluemix_notm}} à des clusters</li>
      <li>Afficher les journaux à partir d'une configuration d'acheminement des journaux au niveau de l'espace</li></ul>
    </td>
  </tr>
  </tbody>
</table>

## Rôles Infrastructure
{: #infra}

Lorsqu'un utilisateur avec le rôle d'accès Infrastructure **Superutilisateur** [définit la clé d'API pour une région et un groupe de ressources](/docs/containers?topic=containers-users#api_key), les droits d'infrastructure pour les autres utilisateurs du compte sont définis par des rôles de plateforme {{site.data.keyword.Bluemix_notm}} IAM. Vous n'avez pas besoin de modifier les droits de l'infrastructure IBM Cloud (SoftLayer) des autres utilisateurs. Utilisez uniquement le tableau suivant pour personnaliser les droits de l'infrastructure IBM Cloud (SoftLayer) des utilisateurs lorsque vous ne pouvez pas affecter le rôle **Superutilisateur** à l'utilisateur qui définit la clé d'API. Pour plus d'informations, voir [Personnalisation des droits Infrastructure](/docs/containers?topic=containers-users#infra_access).
{: shortdesc}

Le tableau suivant présente les droits requis pour effectuer des ensembles de tâches courantes.

<table>
 <caption>Droits Infrastructure souvent requis pour {{site.data.keyword.containerlong_notm}}</caption>
 <thead>
  <th>Tâches courantes dans {{site.data.keyword.containerlong_notm}}</th>
  <th>Droits Infrastructure requis par catégorie</th>
 </thead>
 <tbody>
   <tr>
     <td><strong>Droits minimum</strong> : <ul><li>Créer un cluster.</li></ul></td>
     <td><strong>Equipements</strong> :<ul><li>Afficher les détails du serveur virtuel</li><li>Réamorcer le serveur et afficher les informations système IPMI (Intelligent Platform Management Interface)</li><li>Emettre les rechargements de système d'exploitation et lancer le noyau de secours</li></ul><strong>Compte</strong> : <ul><li>Ajouter un serveur</li></ul></td>
   </tr>
   <tr>
     <td><strong>Administration de clusters</strong> : <ul><li>Créer, mettre à jour et supprimer des clusters.</li><li>Ajouter, recharger et réamorcer des noeuds worker.</li><li>Afficher les réseaux locaux virtuels (VLAN).</li><li>Créer des sous-réseaux.</li><li>Déployer des pods et charger des services d'équilibreur de charge.</li></ul></td>
     <td><strong>Support</strong> :<ul><li>Afficher les tickets</li><li>Ajouter des tickets</li><li>Editer des tickets</li></ul>
     <strong>Equipements</strong> :<ul><li>Afficher les informations détaillées sur le matériel</li><li>Afficher les détails du serveur virtuel</li><li>Réamorcer le serveur et afficher les informations système IPMI (Intelligent Platform Management Interface)</li><li>Emettre les rechargements de système d'exploitation et lancer le noyau de secours</li></ul>
     <strong>Réseau</strong> :<ul><li>Ajouter la fonction de calcul avec le port réseau public</li></ul>
     <strong>Compte</strong> :<ul><li>Annuler un serveur</li><li>Ajouter un serveur</li></ul></td>
   </tr>
   <tr>
     <td><strong>Stockage</strong> : <ul><li>Créer des réservations de volumes persistants pour mettre à disposition des volumes persistants.</li><li>Créer et gérer des ressources d'infrastructure de stockage.</li></ul></td>
     <td><strong>Services</strong> :<ul><li>Gérer le stockage</li></ul><strong>Compte</strong> :<ul><li>Ajouter du stockage</li></ul></td>
   </tr>
   <tr>
     <td><strong>Réseau privé</strong> : <ul><li>Gérer les VLAN privés pour la mise en réseau au sein d'un cluster.</li><li>Configurer la connectivité VPN pour les réseaux privés.</li></ul></td>
     <td><strong>Réseau</strong> :<ul><li>Gérer les routes de sous-réseau du réseau</li></ul></td>
   </tr>
   <tr>
     <td><strong>Réseau public</strong> :<ul><li>Configurer un équilibreur de charge public ou un réseau Ingress pour exposer des applications.</li></ul></td>
     <td><strong>Equipements</strong> :<ul><li>Editer le nom d'hôte/domaine</li><li>Gérer le contrôle de port</li></ul>
     <strong>Réseau</strong> :<ul><li>Ajouter la fonction de calcul avec le port réseau public</li><li>Gérer les routes de sous-réseau du réseau</li><li>Ajouter des adresses IP</li></ul>
     <strong>Services</strong> :<ul><li>Gérer DNS, RDNS et WHOIS</li><li>Afficher les certificats (SSL)</li><li>Gérer les certificats (SSL)</li></ul></td>
   </tr>
 </tbody>
</table>
