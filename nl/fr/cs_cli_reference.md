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



# Guide de référence des commandes
{: #cs_cli_reference}

Reportez-vous aux commandes suivantes pour créer et gérer des clusters Kubernetes dans {{site.data.keyword.containerlong}}.
{:shortdesc}

Pour installer le plug-in de l'interface CLI, voir [Installation de l'interface de ligne de commande](cs_cli_install.html#cs_cli_install_steps).

Dans le terminal, vous êtes averti des mises à jour disponibles pour l'interface de ligne de commande `ibmcloud` et les plug-ins. Veillez à maintenir votre interface de ligne de commande à jour pour pouvoir utiliser l'ensemble des commandes et des indicateurs.

Vous recherchez des commandes `ibmcloud cr` ? Consultez le [guide de référence de l'interface CLI {{site.data.keyword.registryshort_notm}}](/docs/cli/plugins/registry/index.html). Vous recherchez des commandes `kubectl` ? Consultez la [documentation Kubernetes ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/reference/kubectl/overview/).
{:tip}

## Commandes ibmcloud ks
{: #cs_commands}

**Astuce :** pour identifier la version du plug-in {{site.data.keyword.containerlong_notm}}, exécutez la commande suivante :

```
ibmcloud plugin list
```
{: pre}



<table summary="Tableau des commandes d'API">
<caption>Commandes d'API</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>Commandes d'API</th>
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

<table summary="Tableau des commandes d'utilisation du plug-in de l'interface CLI">
<caption>Commandes d'utilisation du plug-in de l'interface CLI</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>Commandes d'utilisation du plug-in de l'interface CLI</th>
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

<table summary="Tableau des commandes de cluster : Gestion">
<caption>Commandes de cluster : commandes de gestion</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>Commandes de cluster : Gestion</th>
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

<table summary="Tableau des commandes de cluster : Services et intégrations">
<caption>Commandes de cluster : commandes de services et intégrations</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>Commandes de cluster : Services et intégrations</th>
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

<table summary="Tableau des commandes de cluster : Sous-réseaux">
<caption>Commandes de cluster : commandes de sous-réseaux</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>Commandes de cluster : Sous-réseaux</th>
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



<table summary="Tableau des commandes de l'infrastructure">
<caption>Commandes de cluster : commandes de l'infrastructure</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>Commandes de l'infrastructure</th>
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

<table summary="Tableau des commandes de l'équilibreur de charge d'application (ALB) Ingress">
<caption>Commandes de l'équilibreur de charge d'application (ALB) Ingress</caption>
<col width = 25%>
<col width = 25%>
<col width = 25%>
  <thead>
    <tr>
      <th colspan=4>Commandes de l'équilibreur de charge d'application (ALB) Ingress</th>
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

<table summary="Tableau des commandes de consignation">
<caption>Commandes de consignation</caption>
<col width = 25%>
<col width = 25%>
<col width = 25%>
  <thead>
    <tr>
      <th colspan=4>Commandes de consignation</th>
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
    <tr>
      <td>[ibmcloud ks logging-collect](#cs_log_collect)</td>
      <td>[ibmcloud ks logging-collect-status](#cs_log_collect_status)</td>
      <td> </td>
      <td> </td>
    </tr>
  </tbody>
</table>

</br>

<table summary="Tableau des commandes de région">
<caption>Commandes de région</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>Commandes de région</th>
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

<table summary="Tableau des commandes de noeud worker">
<caption>Commandes de noeud worker</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>Commandes de noeud worker</th>
 </thead>
 <tbody>
    <tr>
      <td>Déprécié : [ibmcloud ks worker-add](#cs_worker_add)</td>
      <td>[ibmcloud ks worker-get](#cs_worker_get)</td>
      <td>[ibmcloud ks worker-reboot](#cs_worker_reboot)</td>
      <td>[ibmcloud ks worker-reload](#cs_worker_reload)</td>
    </tr>
    <tr>
      <td>[ibmcloud ks worker-rm](#cs_worker_rm)</td>
      <td>[ibmcloud ks worker-update](#cs_worker_update)</td>
      <td>[ibmcloud ks workers](#cs_workers)</td>
    </tr>
  </tbody>
</table>

<table summary="Tableau des commandes de pool de noeuds worker">
<caption>Commandes de pool de noeuds worker</caption>
<col width="25%">
<col width="25%">
<col width="25%">
 <thead>
    <th colspan=4>Commandes de pool de noeuds worker</th>
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

## Commandes d'API
{: #api_commands}

### ibmcloud ks api --endpoint ENDPOINT [--insecure][--skip-ssl-validation] [--api-version VALUE][-s]
{: #cs_api}

Permet de cibler le noeud final d'API pour {{site.data.keyword.containerlong_notm}}. Si vous n'indiquez pas de noeud final, vous pourrez voir les informations sur le noeud final actuellement ciblé.

Vous changez de région ? Utilisez la [commande](#cs_region-set) `ibmcloud ks region-set` à la place.
{: tip}

<strong>Droits minimum requis</strong> : aucun

<strong>Options de commande</strong> :

   <dl>
   <dt><code>--endpoint <em>ENDPOINT</em></code></dt>
   <dd>Noeud final d'API {{site.data.keyword.containerlong_notm}}. Notez que ce noeud final est différent des noeuds finaux {{site.data.keyword.Bluemix_notm}}. Cette valeur est obligatoire pour définir le noeud final d'API. Valeurs admises :<ul>
   <li>Noeud final global : https://containers.bluemix.net</li>
   <li>Noeud final d'Asie-Pacifique nord : https://ap-north.containers.bluemix.net</li>
   <li>Noeud final d'Asie-Pacifique sud : https://ap-south.containers.bluemix.net</li>
   <li>Noeud final d'Europe centrale : https://eu-central.containers.bluemix.net</li>
   <li>Noeud final du Sud du Royaume-Uni : https://uk-south.containers.bluemix.net</li>
   <li>Noeud final de l'Est des Etats-Unis : https://us-east.containers.bluemix.net</li>
   <li>Noeud final du Sud des Etats-Unis : https://us-south.containers.bluemix.net</li></ul>
   </dd>

   <dt><code>--insecure</code></dt>
   <dd>Autoriser une connexion HTTP non sécurisée. Cet indicateur est facultatif.</dd>

   <dt><code>--skip-ssl-validation</code></dt>
   <dd>Autoriser les certificats SSL non sécurisés. Cet indicateur est facultatif.</dd>

   <dt><code>--api-version VALUE</code></dt>
   <dd>Indiquez la version d'API du service que vous souhaitez utiliser. Cette valeur est facultative.</dd>

   <dt><code>-s</code></dt>
   <dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>

   </dl>

**Exemple** : Affichage d'informations sur le noeud final d'API actuellement ciblé.
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

Permet d'afficher le nom et l'adresse e-mail du propriétaire de la clé d'API IAM dans un groupe de ressources et une région {{site.data.keyword.containerlong_notm}}.

La clé d'API IAM (Identity and Access Management) est définie automatiquement pour un groupe de ressources et une région lorsque la première action qui nécessite la règle d'accès admin {{site.data.keyword.containerlong_notm}} est effectuée. Par exemple, supposons que l'un de vos administrateurs crée le premier cluster dans le groupe de ressources `default` dans la région `us-south`. Pour cette opération, la clé d'API IAM de cet utilisateur est stockée dans le compte correspondant à ce groupe de ressources et à cette région. La clé d'API est utilisée pour commander des ressources dans l'infrastructure IBM Cloud (SoftLayer), par exemple de nouveaux noeuds worker ou réseaux locaux virtuels (VLAN). Une autre clé d'API peut être définie pour chaque région au sein d'un groupe de ressources.

Lorsqu'un autre utilisateur effectue une action qui nécessite une interaction avec le portefeuille d'infrastructure IBM Cloud (SoftLayer) dans ce groupe de ressources et dans cette région, par exemple la création d'un nouveau cluster ou le rechargement d'un noeud worker, la clé d'API stockée est utilisée pour déterminer s'il existe des droits suffisants pour effectuer cette action. Pour vous assurer que les actions liées à l'infrastructure dans votre cluster peuvent être effectuées sans problème, affectez à vos administrateurs {{site.data.keyword.containerlong_notm}} la règle d'accès **Superutilisateur** de l'infrastructure. Pour plus d'informations, voir [Gestion de l'accès utilisateur](cs_users.html#infra_access).

Si vous constatez que la clé d'API stockée pour un groupe de ressources ou une région nécessite une mise à jour, vous pouvez le faire en exécutant la commande [ibmcloud ks api-key-reset](#cs_api_key_reset). Cette commande nécessite la règle d'accès admin {{site.data.keyword.containerlong_notm}} et stocke la clé d'API de l'utilisateur qui exécute cette commande dans le compte.

**Astuce :** la clé d'API renvoyée par cette commande ne peut pas être utilisée si les données d'identification ont été définies manuellement à l'aide de la commande [ibmcloud ks credentials-set](#cs_credentials_set).

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Afficheur** pour {{site.data.keyword.containerlong_notm}}

<strong>Options de commande</strong> :

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>

   <dt><code>--json</code></dt>
   <dd>Imprime le résultat de la commande au format JSON. Cette valeur est facultative.</dd>

   <dt><code>-s</code></dt>
   <dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>

   </dl>

**Exemple** :

  ```
  ibmcloud ks api-key-info --cluster my_cluster
  ```
  {: pre}


### ibmcloud ks api-key-reset [-s]
{: #cs_api_key_reset}

Permet de remplacer la clé d'API IAM actuelle dans une région {{site.data.keyword.containerlong_notm}}.

Cette commande nécessite la règle d'accès admin {{site.data.keyword.containerlong_notm}} et stocke la clé d'API de l'utilisateur qui exécute cette commande dans le compte. La clé d'API IAM est nécessaire pour commander l'infrastructure depuis le portefeuille d'infrastructure IBM Cloud (SoftLayer). Une fois stockée, la clé d'API est utilisée pour toutes les actions dans une région qui nécessite des droits d'accès à l'infrastructure indépendamment de l'utilisateur qui exécute cette commande. Pour plus d'informations sur le mode de fonctionnement des clés d'API IAM, voir la [commande `ibmcloud ks api-key-info`](#cs_api_key_info).

**Important** : avant d'utiliser cette commande, assurez-vous que l'utilisateur qui l'exécute dispose des droits [{{site.data.keyword.containerlong_notm}} et des droit de l'infrastructure IBM Cloud (SoftLayer)](cs_users.html#users) requis.

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Administrateur** pour {{site.data.keyword.containerlong_notm}}

<strong>Options de commande</strong> :

   <dl>
   <dt><code>-s</code></dt>
   <dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>
   </dl>


**Exemple** :

  ```
  ibmcloud ks api-key-reset
  ```
  {: pre}


### ibmcloud ks apiserver-config-get
{: #cs_apiserver_config_get}

Extrait des informations sur une option pour une configuration du serveur d'API Kubernetes du cluster. Cette commande doit être combinée avec l'une des sous-commandes suivantes pour l'option de configuration sur laquelle vous désirez des informations.

#### ibmcloud ks apiserver-config-get audit-webhook --cluster CLUSTER
{: #cs_apiserver_config_get}

Affiche l'URL du service de consignation distant auquel vous envoyez les journaux d'audit de serveur d'API. L'URL a été spécifiée lorsque vous avez créé le back end du webhook pour la configuration de serveur d'API.

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Afficheur** pour {{site.data.keyword.containerlong_notm}}

<strong>Options de commande</strong> :

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>
   </dl>

**Exemple** :

  ```
  ibmcloud ks apiserver-config-get audit-webhook --cluster my_cluster
  ```
  {: pre}

### ibmcloud ks apiserver-config-set
{: #cs_apiserver_config_set}

Définit une option pour la configuration du serveur d'API Kubernetes d'un cluster. Cette commande doit être associée à l'une des sous-commandes suivantes pour l'option de configuration que vous voulez définir.

#### ibmcloud ks apiserver-config-set audit-webhook --cluster CLUSTER [--remoteServer SERVER_URL_OR_IP][--caCert CA_CERT_PATH] [--clientCert CLIENT_CERT_PATH][--clientKey CLIENT_KEY_PATH]
{: #cs_apiserver_set}

Définissez le back end du webhook pour la configuration de serveur d'API. Le back end du webhook achemine les journaux d'audit de serveur d'API à un serveur distant. Une configuration webhook est créée compte tenu des informations que vous soumettez dans les indicateurs de cette commande. Si vous ne soumettez pas d'informations dans les indicateurs, une configuration webhook par défaut est utilisée.

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Editeur** pour {{site.data.keyword.containerlong_notm}}

<strong>Options de commande</strong> :

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>

   <dt><code>--remoteServer <em>SERVER_URL_OR_IP</em></code></dt>
   <dd>URL ou adresse IP du service de consignation distant auquel vous désirez envoyer les journaux d'audit. Si vous indiquez une URL de serveur non sécurisée, les certificats éventuels sont ignorés. Cette valeur est facultative.</dd>

   <dt><code>--caCert <em>CA_CERT_PATH</em></code></dt>
   <dd>Chemin de fichier du certificat d'autorité de certification utilisé pour vérifier le service de consignation distant. Cette valeur est facultative.</dd>

   <dt><code>--clientCert <em>CLIENT_CERT_PATH</em></code></dt>
   <dd>Chemin de fichier du certificat d'autorité de certification utilisé pour l'authentification auprès du service de consignation distant. Cette valeur est facultative.</dd>

   <dt><code>--clientKey <em> CLIENT_KEY_PATH</em></code></dt>
   <dd>Chemin de fichier de la clé client correspondante utilisée pour la connexion au service de consignation distant. Cette valeur est facultative.</dd>
   </dl>

**Exemple** :

  ```
  ibmcloud ks apiserver-config-set audit-webhook --cluster my_cluster --remoteServer https://audit.example.com/audit --caCert /mnt/etc/kubernetes/apiserver-audit/ca.pem --clientCert /mnt/etc/kubernetes/apiserver-audit/cert.pem --clientKey /mnt/etc/kubernetes/apiserver-audit/key.pem
  ```
  {: pre}


### ibmcloud ks apiserver-config-unset
{: #cs_apiserver_config_unset}

Désactive une option pour une configuration de serveur d'API Kubernetes d'un cluster. Cette commande doit être combinée avec l'une des sous-commandes suivantes pour l'option de configuration que vous désirez désactiver.

#### ibmcloud ks apiserver-config-unset audit-webhook --cluster CLUSTER
{: #cs_apiserver_unset}

Désactivez la configuration de back end du webhook pour le serveur d'API du cluster. La désactivation du back end de webhook arrête le transfert des journaux d'audit du serveur d'API à un serveur distant.

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Editeur** pour {{site.data.keyword.containerlong_notm}}

<strong>Options de commande</strong> :

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>
   </dl>

**Exemple** :

  ```
  ibmcloud ks apiserver-config-unset audit-webhook --cluster my_cluster
  ```
  {: pre}

### ibmcloud ks apiserver-refresh --cluster CLUSTER [-s]
{: #cs_apiserver_refresh}

Redémarre le noeud maître du cluster pour appliquer les nouvelles modifications apportées à la configuration de l'API Kubernetes. Vos noeuds worker, applications et ressources ne sont pas modifiés et continuent à s'exécuter.

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Opérateur** pour {{site.data.keyword.containerlong_notm}}

<strong>Options de commande</strong> :

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>

   <dt><code>-s</code></dt>
   <dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>

   </dl>

**Exemple** :

  ```
  ibmcloud ks apiserver-refresh --cluster my_cluster
  ```
  {: pre}


<br />


## Commandes d'utilisation du plug-in de l'interface CLI
{: #cli_plug-in_commands}

### ibmcloud ks help
{: #cs_help}

Affiche la liste des commandes et des paramètres pris en charge.

<strong>Droits minimum requis</strong> : aucun

<strong>Options de commande</strong> :

   Aucune

**Exemple** :

  ```
  ibmcloud ks help
  ```
  {: pre}


### ibmcloud ks init [--host HOST][--insecure] [-p][-u] [-s]
{: #cs_init}

Initialisez le plug-in {{site.data.keyword.containerlong_notm}} ou spécifiez la région dans laquelle vous souhaitez créer ou accéder à des clusters Kubernetes.

<strong>Droits minimum requis</strong> : aucun

<strong>Options de commande</strong> :

   <dl>
   <dt><code>--host <em>HOST</em></code></dt>
   <dd>Noeud final d'API {{site.data.keyword.containerlong_notm}} à utiliser.  Cette valeur est facultative. [Afficher les valeurs de noeud final d'API disponibles.](cs_regions.html#container_regions)</dd>

   <dt><code>--insecure</code></dt>
   <dd>Autoriser une connexion HTTP non sécurisée.</dd>

   <dt><code>-p</code></dt>
   <dd>Votre mot de passe IBM Cloud.</dd>

   <dt><code>-u</code></dt>
   <dd>Votre nom d'utilisateur IBM Cloud.</dd>

   <dt><code>-s</code></dt>
   <dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>

   </dl>

**Exemple** :


```
ibmcloud ks init --host https://uk-south.containers.bluemix.net
```
{: pre}


### ibmcloud ks messages
{: #cs_messages}

Affiche les messages en cours pour l'utilisateur IBMid.

<strong>Droits minimum requis</strong> : aucun

**Exemple** :

```
ibmcloud ks messages
```
{: pre}


<br />


## Commandes de cluster : Gestion
{: #cluster_mgmt_commands}



### ibmcloud ks cluster-config --cluster CLUSTER [--admin][--export] [--network][-s] [--yaml]
{: #cs_cluster_config}

Après la connexion, téléchargez les données de configuration et les certificats Kubernetes pour vous connecter à votre cluster et exécuter des commandes `kubectl`. Les fichiers sont téléchargés sous `user_home_directory/.bluemix/plugins/container-service/clusters/<cluster_name>`.

**Droits minimum requis** : aucun

**Options de commande** :

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>

   <dt><code>--admin</code></dt>
   <dd>Téléchargez les fichiers de certificat et d'autorisations TLS pour le rôle Superutilisateur. Vous pouvez utiliser les certificats pour automatiser les tâches d'un cluster sans avoir à vous authentifier à nouveau. Les fichiers sont téléchargés dans `<user_home_directory>/.bluemix/plugins/container-service/clusters/<cluster_name>-admin`. Cette valeur est facultative.</dd>

   <dt><code>--network</code></dt>
   <dd>Téléchargez le fichier de configuration Calico, les certificats TLS et les fichiers d'autorisation requis pour exécuter des commandes <code>calicoctl</code> dans votre cluster. Cette valeur est facultative. **Remarque** : afin d'obtenir la commande export pour les certificats et les données de certification Kubernetes téléchargés, vous devez exécuter cette commande sans cet indicateur.</dd>

   <dt><code>--export</code></dt>
   <dd>Téléchargez les certificats et les données de configuration Kubernetes sans autre message que la commande export. Comme aucun message ne s'affiche, vous pouvez utiliser cet indicateur lorsque vous créez des scripts automatisés. Cette valeur est facultative.</dd>

  <dt><code>-s</code></dt>
  <dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>

  <dt><code>--yaml</code></dt>
  <dd>Imprime le résultat de la commande au format YAML. Cette valeur est facultative.</dd>

   </dl>

**Exemple** :

```
ibmcloud ks cluster-config --cluster my_cluster
```
{: pre}


### ibmcloud ks cluster-create [--file FILE_LOCATION][--hardware HARDWARE] --zone ZONE --machine-type MACHINE_TYPE --name NAME [--kube-version MAJOR.MINOR.PATCH][--no-subnet] [--private-vlan PRIVATE_VLAN][--public-vlan PUBLIC_VLAN] [--private-only][--workers WORKER] [--disable-disk-encrypt][--trusted] [-s]
{: #cs_cluster_create}

Permet de créer un cluster dans votre organisation. Pour les clusters gratuits, indiquez le nom du cluster, tout le reste est défini avec des valeurs par défaut. Un cluster gratuit est supprimé automatiquement au bout de 30 jours. Vous ne pouvez disposer que d'un cluster gratuit à la fois. Pour tirer parti de toutes les fonctions de Kubernetes, créez un cluster standard.

<strong>Droits minimum requis</strong> :
* Rôle de plateforme IAM **Administrateur** pour {{site.data.keyword.containerlong_notm}}
* Rôle de plateforme IAM **Administrateur** pour {{site.data.keyword.registrylong_notm}}
* Rôle d'infrastructure **Superutilisateur** pour l'infrastructure IBM Cloud (SoftLayer).

<strong>Options de commande</strong>

<dl>
<dt><code>--file <em>FILE_LOCATION</em></code></dt>

<dd>Chemin d'accès au fichier YAML pour créer votre cluster standard. Au lieu de définir les caractéristiques de votre cluster à l'aide des options fournies dans cette commande, vous pouvez utiliser un fichier YAML.  Cette valeur est facultative pour les clusters standard et n'est pas disponible pour les clusters gratuits.

<p><strong>Remarque :</strong> si vous indiquez la même option dans la commande comme paramètre dans le fichier YAML, la valeur de l'option de la commande est prioritaire sur la valeur définie dans le fichier YAML. Par exemple, si vous indiquez un emplacement dans votre fichier YAML et utilisez l'option <code>--zone</code> dans la commande, la valeur que vous avez entrée dans l'option de commande se substitue à la valeur définie dans le fichier YAML.

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
    <caption>Description des composants du fichier YAML</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code><em>name</em></code></td>
    <td>Remplacez <code><em>&lt;cluster_name&gt;</em></code> par le nom de votre cluster. Le nom doit commencer par une lettre, peut contenir des lettres, des nombres et des tirets (-) et ne doit pas dépasser 35 caractères. Le nom du cluster et la région dans laquelle est déployé le cluster constituent le nom de domaine qualifié complet du sous-domaine Ingress. Pour garantir que ce sous-domaine est unique dans une région, le nom de cluster peut être tronqué et complété par une valeur aléatoire dans le nom de domaine Ingress.
</td>
    </tr>
    <tr>
    <td><code><em>zone</em></code></td>
    <td>Remplacez <code><em>&lt;zone&gt;</em></code> par la zone dans laquelle vous souhaitez créer votre cluster. Les zones disponibles dépendent de la région à laquelle vous êtes connecté. Pour afficher les zones disponibles, exécutez la commande <code>ibmcloud ks zones</code>. </td>
     </tr>
     <tr>
     <td><code><em>no-subnet</em></code></td>
     <td>Par défaut, un sous-réseau public et un sous-réseau privé portables sont créés sur le réseau local virtuel (VLAN) associé au cluster. Remplacez <code><em>&lt;no-subnet&gt;</em></code> par <code><em>true</em></code> afin d'éviter de créer des sous-réseaux avec le cluster. Vous pouvez [créer](#cs_cluster_subnet_create) ou [ajouter](#cs_cluster_subnet_add) des sous-réseaux à un cluster ultérieurement.</td>
      </tr>
     <tr>
     <td><code><em>machine-type</em></code></td>
     <td>Remplacez <code><em>&lt;machine_type&gt;</em></code> par le type de machine sur lequel vous envisagez de déployer vos noeuds worker. Vous pouvez déployer vos noeuds worker en tant que machines virtuelles sur du matériel partagé ou dédié ou en tant que machines physiques sur un serveur bare metal. Les types de machines virtuelles et physiques disponibles varient en fonction de la zone de déploiement du cluster. Pour plus d'informations, voir la documentation correspondant à la [commande](cs_cli_reference.html#cs_machine_types) `ibmcloud ks machine-type`.</td>
     </tr>
     <tr>
     <td><code><em>private-vlan</em></code></td>
     <td>Remplacez <code><em>&lt;private_VLAN&gt;</em></code> par l'ID du réseau local virtuel privé que vous souhaitez utiliser pour vos noeuds worker. Pour afficher la liste des réseaux locaux virtuels disponibles, exécutez la commande <code>ibmcloud ks vlans <em>&lt;zone&gt;</em></code> et recherchez les routeurs VLAN commençant par <code>bcr</code> (routeur de back-end).</td>
     </tr>
     <tr>
     <td><code><em>public-vlan</em></code></td>
     <td>Remplacez <code><em>&lt;public_VLAN&gt;</em></code> par l'ID du réseau local virtuel public que vous souhaitez utiliser pour vos noeuds worker. Pour afficher la liste des réseaux locaux virtuels disponibles, exécutez la commande <code>ibmcloud ks vlans <em>&lt;zone&gt;</em></code> et recherchez les routeurs VLAN commençant par <code>fcr</code> (routeur de front-end).</td>
     </tr>
     <tr>
     <td><code><em>hardware</em></code></td>
     <td>Pour les types de machine virtuelle : niveau d'isolement de votre noeud worker. Utilisez un cluster dédié si vous désirez que toutes les ressources physiques vous soient dédiées exclusivement ou un cluster partagé pour permettre leur partage avec d'autres clients IBM. La valeur par défaut est <code>shared</code> (partagé).</td>
     </tr>
     <tr>
     <td><code><em>workerNum</em></code></td>
     <td>Remplacez <code><em>&lt;number_workers&gt;</em></code> par le nombre de noeuds worker que vous souhaitez déployer.</td>
     </tr>
     <tr>
      <td><code><em>kube-version</em></code></td>
      <td>Version Kubernetes du noeud maître du cluster. Cette valeur est facultative. Lorsque la version n'est pas spécifiée, le cluster est créé avec la valeur par défaut des versions Kubernetes prises en charge. Pour voir les versions disponibles, exécutez la commande <code>ibmcloud ks kube-versions</code>.
</td></tr>
      <tr>
      <td><code>diskEncryption: <em>false</em></code></td>
      <td>Les noeuds worker disposent par défaut du chiffrement de disque. [En savoir plus](cs_secure.html#encrypted_disk). Pour désactiver le chiffrement, incluez cette option en lui attribuant la valeur <code>false</code>.</td></tr>
      <tr>
      <td><code>trusted: <em>true</em></code></td>
      <td>**Serveur bare metal uniquement** : activez la fonction [Calcul sécurisé](cs_secure.html#trusted_compute) pour vérifier que vos noeuds worker bare metal ne font pas l'objet de falsification. Si vous n'activez pas cette fonction lors de la création du cluster mais souhaitez le faire ultérieurement, vous pouvez utiliser la [commande](cs_cli_reference.html#cs_cluster_feature_enable) `ibmcloud ks feature-enable`. Après avoir activé cette fonction, vous ne pourrez plus la désactiver par la suite.</td></tr>
     </tbody></table>
    </p></dd>

<dt><code>--hardware <em>HARDWARE</em></code></dt>
<dd>Niveau d'isolation du matériel pour votre noeud worker. Utilisez dedicated pour que toutes les ressources physiques vous soient dédiées exclusivement ou shared pour permettre leur partage avec d'autres clients IBM. La valeur par défaut est shared.  Cette valeur est facultative pour les clusters standard et n'est pas disponible pour les clusters gratuits.</dd>

<dt><code>--zone <em>ZONE</em></code></dt>
<dd>Zone dans laquelle vous désirez créer le cluster. Les zones disponibles dépendent de la région {{site.data.keyword.Bluemix_notm}} à laquelle vous êtes connecté. Pour des performances optimales, sélectionnez la région physiquement la plus proche. Cette valeur est obligatoire pour les clusters standard et facultative pour les clusters gratuits.

<p>Passez en revue les [zones disponibles](cs_regions.html#zones).</p>

<p><strong>Remarque :</strong> si vous sélectionnez une zone à l'étranger, il se peut que vous ayez besoin d'une autorisation légale pour stocker physiquement les données dans un autre pays.</p>
</dd>

<dt><code>--machine-type <em>MACHINE_TYPE</em></code></dt>
<dd>Choisissez un type de machine. Vous pouvez déployer vos noeuds worker en tant que machines virtuelles sur du matériel partagé ou dédié ou en tant que machines physiques sur un serveur bare metal. Les types de machines virtuelles et physiques disponibles varient en fonction de la zone de déploiement du cluster. Pour plus d'informations, voir la documentation correspondant à la [commande](cs_cli_reference.html#cs_machine_types) `ibmcloud ks machine-types`. Cette valeur est obligatoire pour les clusters standard et n'est pas disponible pour les clusters gratuits.</dd>

<dt><code>--name <em>NAME</em></code></dt>
<dd>Nom du cluster.  Cette valeur est obligatoire. Le nom doit commencer par une lettre, peut contenir des lettres, des nombres et des tirets (-) et ne doit pas dépasser 35 caractères. Le nom du cluster et la région dans laquelle est déployé le cluster constituent le nom de domaine qualifié complet du sous-domaine Ingress. Pour garantir que ce sous-domaine est unique dans une région, le nom de cluster peut être tronqué et complété par une valeur aléatoire dans le nom de domaine Ingress.
</dd>

<dt><code>--kube-version <em>MAJOR.MINOR.PATCH</em></code></dt>
<dd>Version Kubernetes du noeud maître du cluster. Cette valeur est facultative. Lorsque la version n'est pas spécifiée, le cluster est créé avec la valeur par défaut des versions Kubernetes prises en charge. Pour voir les versions disponibles, exécutez la commande <code>ibmcloud ks kube-versions</code>.
</dd>

<dt><code>--no-subnet</code></dt>
<dd>Par défaut, un sous-réseau public et un sous-réseau privé portables sont créés sur le réseau local virtuel (VLAN) associé au cluster. Incluez l'indicateur <code>--no-subnet</code> afin d'éviter la création de sous-réseaux avec le cluster. Vous pouvez [créer](#cs_cluster_subnet_create) ou [ajouter](#cs_cluster_subnet_add) des sous-réseaux à un cluster ultérieurement.</dd>

<dt><code>--private-vlan <em>PRIVATE_VLAN</em></code></dt>
<dd>

<ul>
<li>Ce paramètre n'est pas disponible pour les clusters gratuits.</li>
<li>S'il s'agit du premier cluster standard que vous créez dans cette zone, n'incluez pas cet indicateur. Un VLAN privé est créé pour vous lorsque le cluster est créé.</li>
<li>Si vous avez déjà créé un cluster standard dans cette zone ou créé un VLAN privé dans l'infrastructure IBM Cloud (SoftLayer), vous devez spécifier ce VLAN privé.

<p><strong>Remarque</strong> : les routeurs de VLAN privé commencent toujours par <code>bcr</code> (routeur de back-end) et les routeurs de VLAN public par <code>fcr</code> (routeur de front-end). Lors de la création d'un cluster et de la spécification des VLAN publics et privés, le nombre et la combinaison de lettres après ces préfixes doivent correspondre.</p></li>
</ul>

<p>Pour déterminer si vous disposez déjà d'un VLAN privé pour une zone spécifique ou afin d'identifier le nom d'un VLAN privé existant, exécutez la commande <code>ibmcloud ks vlans <em>&lt;zone&gt;</em></code>.</p></dd>

<dt><code>--public-vlan <em>PUBLIC_VLAN</em></code></dt>
<dd>
<ul>
<li>Ce paramètre n'est pas disponible pour les clusters gratuits.</li>
<li>S'il s'agit du premier cluster standard que vous créez dans cette zone, n'utilisez pas cet indicateur. Un VLAN public est créé pour vous lorsque le cluster est créé.</li>
<li>Si vous avez déjà créé un cluster standard dans cette zone ou créé un VLAN public dans l'infrastructure IBM Cloud (SoftLayer), spécifiez ce VLAN public. Si vous désirez connecter vos noeuds worker uniquement à un VLAN privé, n'indiquez pas cette option.

<p><strong>Remarque</strong> : les routeurs de VLAN privé commencent toujours par <code>bcr</code> (routeur de back-end) et les routeurs de VLAN public par <code>fcr</code> (routeur de front-end). Lors de la création d'un cluster et de la spécification des VLAN publics et privés, le nombre et la combinaison de lettres après ces préfixes doivent correspondre.</p></li>
</ul>

<p>Pour déterminer si vous disposez déjà d'un VLAN public pour une zone spécifique ou afin d'identifier le nom d'un VLAN public existant, exécutez la commande <code>ibmcloud ks vlans <em>&lt;zone&gt;</em></code>.</p></dd>

<dt><code>--private-only </code></dt>
  <dd>Utilisez cette option pour empêcher la création d'un VLAN public. Cette valeur est obligatoire uniquement si vous spécifiez l'indicateur `--private-vlan` sans inclure l'indicateur `--public-vlan`.  **Remarque** : si vous souhaitez avoir un cluster privé uniquement, vous devez configurer un dispositif de passerelle pour la connectivité du réseau. Pour plus d'informations, voir [Clusters privés](cs_clusters_planning.html#private_clusters).</dd>

<dt><code>--workers WORKER</code></dt>
<dd>Nombre de noeuds worker que vous désirez déployer dans votre cluster. Si vous ne spécifiez pas cette option, un cluster avec 1 noeud worker est créé. Cette valeur est facultative pour les clusters standard et n'est pas disponible pour les clusters gratuits.

<p><strong>Remarque :</strong> à chaque noeud worker sont affectés un ID de noeud worker unique et un nom de domaine qui ne doivent pas être modifiés manuellement après la création du cluster. La modification de l'ID ou du domaine empêcherait le maître Kubernetes de gérer votre cluster.</p></dd>

<dt><code>--disable-disk-encrypt</code></dt>
<dd>Les noeuds worker disposent par défaut du chiffrement de disque. [En savoir plus](cs_secure.html#encrypted_disk). Pour désactiver le chiffrement, incluez cette option.</dd>

<dt><code>--trusted</code></dt>
<dd><p>**Serveur bare metal uniquement** : activez la fonction [Calcul sécurisé](cs_secure.html#trusted_compute) pour vérifier que vos noeuds worker bare metal ne font pas l'objet de falsification. Si vous n'activez pas cette fonction lors de la création du cluster mais souhaitez le faire ultérieurement, vous pouvez utiliser la [commande](cs_cli_reference.html#cs_cluster_feature_enable) `ibmcloud ks feature-enable`. Après avoir activé cette fonction, vous ne pourrez plus la désactiver par la suite.</p>
<p>Pour vérifier si le type de machine bare metal prend en charge la fonction trust, vérifiez la zone `Trustable` dans la sortie de la [commande](#cs_machine_types) `ibmcloud ks machine-types <zone>`. Pour vérifier que la fonction trust est activée sur un cluster, visualisez la zone **Trust ready** dans la sortie de la [commande](#cs_cluster_get) `ibmcloud ks cluster-get`. Pour vérifier que la fonction trust est activée sur un noeud worker bare metal, visualisez la zone **Trust** dans la sortie de la [commande](#cs_worker_get) `ibmcloud ks worker-get`.</p></dd>

<dt><code>-s</code></dt>
<dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>
</dl>

**Exemples** :

  

  **Création d'un cluster gratuit** : indiquez le nom du cluster uniquement. Tout le reste est défini avec des valeurs par défaut. Un cluster gratuit est supprimé automatiquement au bout de 30 jours. Vous ne pouvez disposer que d'un cluster gratuit à la fois. Pour tirer parti de toutes les fonctions de Kubernetes, créez un cluster standard.

  ```
  ibmcloud ks cluster-create --name my_cluster
  ```
  {: pre}

  **Création de votre premier cluster standard** : le premier cluster standard créé dans une zone génère également un VLAN privé. Par conséquent, n'incluez pas l'indicateur `--public-vlan`.
  {: #example_cluster_create}

  ```
  ibmcloud ks cluster-create --zone dal10 --private-vlan my_private_VLAN_ID --machine-type b2c.4x16 --name my_cluster --hardware shared --workers 2
  ```
  {: pre}

  **Création des clusters standard suivants** : si vous avez déjà créé un cluster standard auparavant dans cette zone ou créé un VLAN public dans l'infrastructure IBM Cloud (SoftLayer), indiquez ce VLAN public avec l'indicateur `--public-vlan`. Pour déterminer si vous disposez déjà d'un VLAN public pour une zone spécifique ou pour identifier le nom d'un VLAN public existant, exécutez la commande `ibmcloud ks vlans <zone>`.

  ```
  ibmcloud ks cluster-create --zone dal10 --public-vlan my_public_VLAN_ID --private-vlan my_private_VLAN_ID --machine-type b2c.4x16 --name my_cluster --hardware shared --workers 2
  ```
  {: pre}

  **Création d'un cluster dans un environnement {{site.data.keyword.Bluemix_dedicated_notm}}** :

  ```
  ibmcloud ks cluster-create --machine-type machine-type --workers number --name cluster_name
  ```
  {: pre}

### ibmcloud ks cluster-feature-enable [-f] --cluster CLUSTER [--trusted][-s]
{: #cs_cluster_feature_enable}

Active une fonction sur un cluster existant.

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Administrateur** pour {{site.data.keyword.containerlong_notm}}

<strong>Options de commande</strong> :

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>

   <dt><code>-f</code></dt>
   <dd>Utilisez cette option pour forcer l'option <code>--trusted</code> sans invites utilisateur. Cette valeur est facultative.</dd>

   <dt><code><em>--trusted</em></code></dt>
   <dd><p>Incluez cet indicateur pour activer la fonction [Calcul sécurisé](cs_secure.html#trusted_compute) pour tous les noeuds worker bare metal présents dans le cluster. Après avoir activé cette fonction, vous ne pourrez plus la désactiver pour le cluster.</p>
   <p>Pour vérifier si le type de machine bare metal prend en charge la fonction de confiance (trust), vérifiez la zone **Trustable** dans la sortie de la [commande](#cs_machine_types) `ibmcloud ks machine-types <zone>`. Pour vérifier que la fonction trust est activée sur un cluster, visualisez la zone **Trust ready** dans la sortie de la [commande](#cs_cluster_get) `ibmcloud ks cluster-get`. Pour vérifier que la fonction trust est activée sur un noeud worker bare metal, visualisez la zone **Trust** dans la sortie de la [commande](#cs_worker_get) `ibmcloud ks worker-get`.</p></dd>

  <dt><code>-s</code></dt>
   <dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>
</dl>

**Exemple de commande** :

  ```
  ibmcloud ks cluster-feature-enable --cluster my_cluster --trusted=true
  ```
  {: pre}

### ibmcloud ks cluster-get --cluster CLUSTER [--json][--showResources] [-s]
{: #cs_cluster_get}

Affiche des informations sur un cluster dans votre organisation.

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Afficheur** pour {{site.data.keyword.containerlong_notm}}

<strong>Options de commande</strong> :

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>

   <dt><code>--json</code></dt>
   <dd>Imprime le résultat de la commande au format JSON. Cette valeur est facultative.</dd>

   <dt><code><em>--showResources</em></code></dt>
   <dd>Affiche d'autres ressources de cluster, telles que des modules complémentaires, des réseaux locaux virtuels (VLAN), des sous-réseaux et du stockage.</dd>


  <dt><code>-s</code></dt>
  <dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>
  </dl>



**Exemple de commande** :

  ```
  ibmcloud ks cluster-get --cluster my_cluster --showResources
  ```
  {: pre}

**Exemple de sortie** :

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

Supprime un cluster de votre organisation.

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Administrateur** pour {{site.data.keyword.containerlong_notm}}

<strong>Options de commande</strong> :

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>

   <dt><code>--force-delete-storage</code></dt>
   <dd>Supprime le cluster et tout stockage persistant utilisé par le cluster. **Attention** : si vous incluez cet indicateur, les données stockées dans le cluster ou dans les instances de stockage associées ne seront plus récupérables. Cette valeur est facultative.</dd>

   <dt><code>-f</code></dt>
   <dd>Utilisez cette option pour forcer la suppression d'un cluster sans invites utilisateur. Cette valeur est facultative.</dd>

   <dt><code>-s</code></dt>
   <dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>

   </dl>

**Exemple** :

  ```
  ibmcloud ks cluster-rm --cluster my_cluster
  ```
  {: pre}


### ibmcloud ks cluster-update [-f] --cluster CLUSTER [--kube-version MAJOR.MINOR.PATCH][--force-update] [-f][-s]
{: #cs_cluster_update}

Mettez à jour le maître Kubernetes à la version par défaut de l'API. Pendant la mise à jour, vous ne pouvez ni accéder au cluster, ni le modifier. Les noeuds worker, les applications et les ressources déployés par l'utilisateur ne sont pas modifiés et continuent à s'exécuter.

Vous pourriez devoir modifier vos fichiers YAML en vue de déploiements ultérieurs. Consultez cette [note sur l'édition](cs_versions.html) pour plus de détails.

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Opérateur** pour {{site.data.keyword.containerlong_notm}}

<strong>Options de commande</strong> :

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>

   <dt><code>--kube-version <em>MAJOR.MINOR.PATCH</em></code></dt>
   <dd>Version Kubernetes du cluster. Si vous ne spécifiez pas de version, la maître Kubernetes est mis à jour vers la version d'API par défaut. Pour voir les versions disponibles, exécutez la commande [ibmcloud ks kube-versions](#cs_kube_versions). Cette valeur est facultative.</dd>

   <dt><code>-f</code></dt>
   <dd>Utilisez cette option pour forcer la mise à jour du maître sans invites utilisateur. Cette valeur est facultative.</dd>

   <dt><code>--force-update</code></dt>
   <dd>Cette option tente d'effectuer la mise à jour même si la modification est supérieure à deux niveaux de version secondaire. Cette valeur est facultative.</dd>

   <dt><code>-f</code></dt>
   <dd>Force la commande à s'exécuter sans invites utilisateur. Cette valeur est facultative.</dd>

   <dt><code>-s</code></dt>
   <dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>
   </dl>

**Exemple** :

  ```
  ibmcloud ks cluster-update --cluster my_cluster
  ```
  {: pre}


### ibmcloud ks clusters [--json][-s]
{: #cs_clusters}

Affiche la liste des clusters dans votre organisation.

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Afficheur** pour {{site.data.keyword.containerlong_notm}}

<strong>Options de commande</strong> :

  <dl>
  <dt><code>--json</code></dt>
  <dd>Imprime le résultat de la commande au format JSON. Cette valeur est facultative.</dd>

  <dt><code>-s</code></dt>
  <dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>
  </dl>

**Exemple** :

  ```
  ibmcloud ks clusters
  ```
  {: pre}


### ibmcloud ks kube-versions [--json][-s]
{: #cs_kube_versions}

Affiche la liste des versions Kubernetes prises en charge dans {{site.data.keyword.containerlong_notm}}. Mettez à jour votre [maître de cluster](#cs_cluster_update) et vos [noeuds worker](cs_cli_reference.html#cs_worker_update) à la version par défaut pour bénéficier des fonctionnalités stables les plus récentes.

<strong>Droits minimum requis</strong> : aucun

**Options de commande** :

  <dl>
  <dt><code>--json</code></dt>
  <dd>Imprime le résultat de la commande au format JSON. Cette valeur est facultative.</dd>

  <dt><code>-s</code></dt>
  <dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>
  </dl>

**Exemple** :

  ```
  ibmcloud ks kube-versions
  ```
  {: pre}

<br />



## Commandes de cluster : Services et intégrations
{: #cluster_services_commands}


### ibmcloud ks cluster-service-bind --cluster CLUSTER --namespace KUBERNETES_NAMESPACE --service SERVICE_INSTANCE_NAME [-s]
{: #cs_cluster_service_bind}

Ajoutez un service {{site.data.keyword.Bluemix_notm}} à un cluster. Pour afficher les services {{site.data.keyword.Bluemix_notm}} disponibles dans le catalogue {{site.data.keyword.Bluemix_notm}}, exécutez la commande `ibmcloud service offerings`. **Remarque **: vous ne pouvez ajouter que des services {{site.data.keyword.Bluemix_notm}} qui prennent en charge les clés de service.

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Editeur** pour {{site.data.keyword.containerlong_notm}} et rôle **Développeur** de Cloud Foundry

<strong>Options de commande</strong> :

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>

   <dt><code>--namespace <em>KUBERNETES_NAMESPACE</em></code></dt>
   <dd>Nom de l'espace de nom Kubernetes. Cette valeur est obligatoire.</dd>

   <dt><code>--service <em>SERVICE_INSTANCE_NAME</em></code></dt>
   <dd>Nom de l'instance de service {{site.data.keyword.Bluemix_notm}} que vous voulez lier. Pour connaître le nom de votre instance de service, exécutez la commande <code>ibmcloud service list</code>. Si plusieurs instances ont le même nom dans le compte, utilisez l'ID d'instance à la place du nom. Pour obtenir l'ID, exécutez la commande <code>ibmcloud service show <service instance name> --guid</code>. L'une de ces valeurs est obligatoire.</dd>

   <dt><code>-s</code></dt>
   <dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>

   </dl>

**Exemple** :

  ```
  ibmcloud ks cluster-service-bind --cluster my_cluster --namespace my_namespace --service my_service_instance
  ```
  {: pre}


### ibmcloud ks cluster-service-unbind --cluster CLUSTER --namespace KUBERNETES_NAMESPACE --service SERVICE_INSTANCE_GUID [-s]
{: #cs_cluster_service_unbind}

Supprimez un service {{site.data.keyword.Bluemix_notm}} d'un cluster.

**Remarque :** lorsque vous supprimez un service {{site.data.keyword.Bluemix_notm}}, ses données d'identification du service sont supprimées du cluster. Si un pod utilise encore ce service, son opération échoue vu que les données d'identification du service sont introuvables.

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Editeur** pour {{site.data.keyword.containerlong_notm}} et rôle **Développeur** de Cloud Foundry

<strong>Options de commande</strong> :

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>

   <dt><code>--namespace <em>KUBERNETES_NAMESPACE</em></code></dt>
   <dd>Nom de l'espace de nom Kubernetes. Cette valeur est obligatoire.</dd>

   <dt><code>--service <em>SERVICE_INSTANCE_GUID</em></code></dt>
   <dd>ID de l'instance de service {{site.data.keyword.Bluemix_notm}} que vous désirez retirer. Pour identifier l'ID de l'instance de service, exécutez la commande `ibmcloud ks cluster-services <cluster_name_or_ID>`. Cette valeur est obligatoire.</dd>

   <dt><code>-s</code></dt>
   <dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>

   </dl>

**Exemple** :

  ```
  ibmcloud ks cluster-service-unbind --cluster my_cluster --namespace my_namespace --service 8567221
  ```
  {: pre}


### ibmcloud ks cluster-services --cluster CLUSTER [--namespace KUBERNETES_NAMESPACE][--all-namespaces] [--json][-s]
{: #cs_cluster_services}

Répertorie les services liés à un ou à tous les espaces de nom Kubernetes dans un cluster. Si aucune option n'est spécifiée, les services pour l'espace de nom par défaut sont affichés.

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Afficheur** pour {{site.data.keyword.containerlong_notm}}

<strong>Options de commande</strong> :

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>

   <dt><code>--namespace <em>KUBERNETES_NAMESPACE</em></code>, <code>-n <em>KUBERNETES_NAMESPACE</em></code></dt>
   <dd>Inclut les services liés à un espace de nom spécifique dans un cluster. Cette valeur est facultative.</dd>

   <dt><code>--all-namespaces</code></dt>
   <dd>Inclut les services liés à tous les espaces de nom dans un cluster. Cette valeur est facultative.</dd>

   <dt><code>--json</code></dt>
   <dd>Imprime le résultat de la commande au format JSON. Cette valeur est facultative.</dd>

   <dt><code>-s</code></dt>
   <dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>
   </dl>

**Exemple** :

  ```
  ibmcloud ks cluster-services --cluster my_cluster --namespace my_namespace
  ```
  {: pre}

### ibmcloud ks va --container CONTAINER_ID [--extended][--vulnerabilities] [--configuration-issues][--json]
{: #cs_va}

Après avoir [installé le scanner de conteneur](/docs/services/va/va_index.html#va_install_container_scanner), affichez un rapport d'évaluation des vulnérabilités d'un conteneur présent dans votre cluster.

<strong>Droits minimum requis</strong> : rôle d'accès au service IAM **Lecteur** pour {{site.data.keyword.registryshort_notm}}

**Options de commande** :

<dl>
<dt><code>--container CONTAINER_ID</code></dt>
<dd><p>ID du conteneur. Cette valeur est obligatoire.</p>
<p>Pour déterminer l'ID de votre conteneur :<ol><li>[Ciblez l'interface CLI de Kubernetes sur votre cluster](cs_cli_install.html#cs_cli_configure).</li><li>Répertoriez vos pods en exécutant la commande `kubectl get pods`.</li><li>Recherchez la zone **Container ID** dans la sortie de la commande `kubectl describe pod <pod_name>`. Par exemple, `Container ID: containerd://1a11a1aa2b2b22223333c44444ccc555667d7dd777888e8ef99f1011121314g15`.</li><li>Supprimez le préfixe `containerd://` de l'ID avant d'utiliser l'ID de conteneur pour la commande `ibmcloud ks va`. Par exemple, `1a11a1aa2b2b22223333c44444ccc555667d7dd777888e8ef99f1011121314g15`.</li></ol></p></dd>

<dt><code>--extended</code></dt>
<dd><p>Développer la sortie de la commande pour afficher plus d'informations sur les correctifs correspondant aux packages vulnérables. Cette valeur est facultative.</p>
<p>Par défaut, les résultats de l'analyse présentent l'ID, le statut de la règle, les packages concernés et comment y remédier. Avec l'indicateur `--extended`, des informations, telles que le récapitulatif, les consignes de sécurité du fournisseur et le lien vers les mentions légales.</p></dd>

<dt><code>--vulnerabilities</code></dt>
<dd>Restreindre la sortie de commande pour n'afficher que les vulnérabilités de package. Cette valeur est facultative. Vous ne pouvez pas utiliser cet indicateur avec `--configuration-issues`.</dd>

<dt><code>--configuration-issues</code></dt>
<dd>Restreindre la sortie de commande pour n'afficher que les problèmes de configuration. Cette valeur est facultative. Vous ne pouvez pas utiliser cet indicateur avec `--vulnerabilities`.</dd>

<dt><code>--json</code></dt>
<dd>Imprime le résultat de la commande au format JSON. Cette valeur est facultative.</dd>
</dl>

**Exemple** :

```
ibmcloud ks va --container 1a11a1aa2b2b22223333c44444ccc555667d7dd777888e8ef99f1011121314g15 --extended --vulnerabilities --json
```
{: pre}

### ibmcloud ks key-protect-enable --cluster CLUSTER_NAME_OR_ID --key-protect-url ENDPOINT --key-protect-instance INSTANCE_GUID --crk ROOT_KEY_ID
{: #cs_key_protect}

Chiffrez vos valeurs confidentielles (secrets) Kubernetes à l'aide d'[{{site.data.keyword.keymanagementservicefull}} ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](/docs/services/key-protect/index.html#getting-started-with-key-protect) comme [fournisseur KMS (Key Management Service) ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/tasks/administer-cluster/kms-provider/) dans votre cluster.
{: shortdesc}

**Important** : si vous supprimez la clé racine (root) dans votre instance {{site.data.keyword.keymanagementserviceshort}}, vous ne pouvez plus accéder ou supprimer les données des valeurs confidentielles dans votre cluster.

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Administrateur** pour {{site.data.keyword.containerlong_notm}}

**Options de commande** :

<dl>
<dt><code>--container CLUSTER_NAME_OR_ID</code></dt>
<dd>Nom ou ID du cluster.</dd>

<dt><code>--key-protect-url ENDPOINT</code></dt>
<dd>Noeud final {{site.data.keyword.keymanagementserviceshort}} pour votre instance de cluster. Pour l'obtenir, voir [Noeuds finaux de service par région](/docs/services/key-protect/regions.html#endpoints).</dd>

<dt><code>--key-protect-instance INSTANCE_GUID</code></dt>
<dd>Identificateur global unique (GUID) de votre instance {{site.data.keyword.keymanagementserviceshort}}. Pour l'obtenir le GUID, exécutez la commande <code>ibmcloud resource service-instance SERVICE_INSTANCE_NAME --id</code> et copiez la seconde valeur (et non pas le CRN complet).</dd>

<dt><code>--crk ROOT_KEY_ID</code></dt>
<dd>ID de votre clé racine {{site.data.keyword.keymanagementserviceshort}}. Pour obtenir la valeur de CRK, voir [Affichage des clés](/docs/services/key-protect/view-keys.html#view-keys).</dd>
</dl>

**Exemple** :

```
ibmcloud ks key-protect-enable --cluster mycluster --key-protect-url keyprotect.us-south.bluemix.net --key-protect-instance a11aa11a-bbb2-3333-d444-e5e555e5ee5 --crk 1a111a1a-bb22-3c3c-4d44-55e555e55e55
```
{: pre}


### ibmcloud ks webhook-create --cluster CLUSTER --level LEVEL --type slack --url URL  [-s]
{: #cs_webhook_create}

Permet d'enregistrer un webhook.

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Editeur** pour {{site.data.keyword.containerlong_notm}}

<strong>Options de commande</strong> :

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>

   <dt><code>--level <em>LEVEL</em></code></dt>
   <dd>Niveau de notification, tel que <code>Normal</code> ou <code>Warning</code>. <code>Warning</code> est la valeur par défaut. Cette valeur est facultative.</dd>

   <dt><code>--type <em>slack</em></code></dt>
   <dd>Type de webhook. Seul le type slack est pris en charge actuellement. Cette valeur est obligatoire.</dd>

   <dt><code>--url <em>URL</em></code></dt>
   <dd>URL du webhook. Cette valeur est obligatoire.</dd>

   <dt><code>-s</code></dt>
   <dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>
   </dl>

**Exemple** :

  ```
  ibmcloud ks webhook-create --cluster my_cluster --level Normal --type slack --url http://github.com/mywebhook
  ```
  {: pre}


<br />


## Commandes de cluster : Sous-réseaux
{: #cluster_subnets_commands}

### ibmcloud ks cluster-subnet-add --cluster CLUSTER --subnet-id SUBNET [-s]
{: #cs_cluster_subnet_add}

Depuis votre compte d'infrastructure IBM Cloud (SoftLayer), vous pouvez ajouter des sous-réseaux publics ou privés portables existants à votre cluster Kubernetes ou réutiliser des sous-réseaux d'un cluster supprimé au lieu d'utiliser les sous-réseaux automatiquement mis à disposition.

**Remarque :**
* Les adresses IP publiques portables sont facturées au mois. Si vous retirez des adresses IP publiques portables après la mise en place de votre cluster, vous devez quand même payer les frais mensuels, même si vous ne les avez utilisées que brièvement.
* Lorsque vous rendez un sous-réseau accessible à un cluster, les adresses IP de ce sous-réseau sont utilisées pour la mise en réseau du cluster. Pour éviter des conflits d'adresse IP, prenez soin de n'utiliser le sous-réseau qu'avec un seul cluster. N'utilisez pas en même temps un sous-réseau pour plusieurs clusters ou à d'autres fins hors d'{{site.data.keyword.containerlong_notm}}.
* Pour activer la communication entre des noeuds worker qui se trouvent dans différents sous-réseaux d'un même VLAN, vous devez [activer le routage entre les sous-réseaux sur le même VLAN](cs_subnets.html#subnet-routing).

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Opérateur** pour {{site.data.keyword.containerlong_notm}}

<strong>Options de commande</strong> :

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>

   <dt><code>--subnet-id <em>SUBNET</em></code></dt>
   <dd>ID du sous-réseau. Cette valeur est obligatoire.</dd>

   <dt><code>-s</code></dt>
   <dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>

   </dl>

**Exemple** :

  ```
  ibmcloud ks cluster-subnet-add --cluster my_cluster --subnet-id 1643389
  ```
  {: pre}


### ibmcloud ks cluster-subnet-create --cluster CLUSTER --size SIZE --vlan VLAN_ID [-s]
{: #cs_cluster_subnet_create}

Créez un sous-réseau dans un compte d'infrastructure IBM Cloud (SoftLayer) et le rend disponible pour le cluster spécifié dans {{site.data.keyword.containerlong_notm}}.

**Remarque :**
* Lorsque vous rendez un sous-réseau accessible à un cluster, les adresses IP de ce sous-réseau sont utilisées pour la mise en réseau du cluster. Pour éviter des conflits d'adresse IP, prenez soin de n'utiliser le sous-réseau qu'avec un seul cluster. N'utilisez pas en même temps un sous-réseau pour plusieurs clusters ou à d'autres fins hors d'{{site.data.keyword.containerlong_notm}}.
* Si vous disposez de plusieurs VLAN pour un cluster, de plusieurs sous-réseaux sur le même VLAN ou d'un cluster à zones multiples, vous devez activer la fonction [Spanning VLAN](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) pour votre compte d'infrastructure IBM Cloud (SoftLayer) afin que vos noeuds worker puissent communiquer entre eux sur le réseau privé. Pour effectuer cette action, vous devez disposer des [droits Infrastructure](cs_users.html#infra_access) **Réseau > Gérer spanning VLAN pour réseau** ou vous pouvez demander au propriétaire du compte de l'activer. Pour vérifier si la fonction Spanning VLAN est déjà activée, utilisez la [commande](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`. Avec {{site.data.keyword.BluDirectLink}}, vous devez utiliser à la place une [fonction VRF (Virtual Router Function)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf). Pour activer la fonction VRF, contactez le représentant de votre compte d'infrastructure IBM Cloud (SoftLayer).

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Opérateur** pour {{site.data.keyword.containerlong_notm}}

<strong>Options de commande</strong> :

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Nom ou ID du cluster. Cette valeur est obligatoire. Pour afficher la liste de vos clusters, utilisez la [commande](#cs_clusters) `ibmcloud ks clusters`.</dd>

   <dt><code>--size <em>SIZE</em></code></dt>
   <dd>Nombre d'adresses IP du sous-réseau. Cette valeur est obligatoire. Les valeurs possibles sont : 8, 16, 32 ou 64.</dd>

   <dd>Réseau local virtuel (VLAN) dans lequel créer le sous-réseau. Cette valeur est obligatoire. Pour afficher la liste des VLAN disponibles, utilisez la [commande](#cs_vlans) `ibmcloud ks vlans <zone>`. Le sous-réseau est fourni dans la même zone que le VLAN.</dd>

   <dt><code>-s</code></dt>
   <dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>

   </dl>

**Exemple** :

  ```
  ibmcloud ks cluster-subnet-create --cluster my_cluster --size 8 --vlan 1764905
  ```
  {: pre}


### ibmcloud ks cluster-user-subnet-add --cluster CLUSTER --subnet-cidr SUBNET_CIDR --private-vlan PRIVATE_VLAN
{: #cs_cluster_user_subnet_add}

Mettez à disposition votre propre sous-réseau privé sur vos clusters {{site.data.keyword.containerlong_notm}}.

Ce sous-réseau privé n'est pas celui qui est fourni par l'infrastructure IBM Cloud (SoftLayer). De ce fait, vous devez configurer tout routage de trafic entrant et sortant pour le sous-réseau. Pour ajouter un sous-réseau d'infrastructure IBM Cloud (SoftLayer), utilisez la [commande](#cs_cluster_subnet_add) `ibmcloud ks cluster-subnet-add`.

**Remarque **:
* Lorsque vous ajoutez un sous-réseau utilisateur privé à un cluster, les adresses IP de ce sous-réseau sont utilisées pour les équilibreurs de charge privés figurant dans le cluster. Pour éviter des conflits d'adresse IP, prenez soin de n'utiliser le sous-réseau qu'avec un seul cluster. N'utilisez pas en même temps un sous-réseau pour plusieurs clusters ou à d'autres fins hors d'{{site.data.keyword.containerlong_notm}}.
* Si vous disposez de plusieurs VLAN pour un cluster, de plusieurs sous-réseaux sur le même VLAN ou d'un cluster à zones multiples, vous devez activer la fonction [Spanning VLAN](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) pour votre compte d'infrastructure IBM Cloud (SoftLayer) afin que vos noeuds worker puissent communiquer entre eux sur le réseau privé. Pour effectuer cette action, vous devez disposer des [droits Infrastructure](cs_users.html#infra_access) **Réseau > Gérer spanning VLAN pour réseau** ou vous pouvez demander au propriétaire du compte de l'activer. Pour vérifier si la fonction Spanning VLAN est déjà activée, utilisez la [commande](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`. Avec {{site.data.keyword.BluDirectLink}}, vous devez utiliser à la place une [fonction VRF (Virtual Router Function)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf). Pour activer la fonction VRF, contactez le représentant de votre compte d'infrastructure IBM Cloud (SoftLayer).

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Opérateur** pour {{site.data.keyword.containerlong_notm}}

<strong>Options de commande</strong> :

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>

   <dt><code>--subnet-cidr <em>SUBNET_CIDR</em></code></dt>
   <dd>CIDR (Classless InterDomain Routing) du sous-réseau. Cette valeur est obligatoire et ne doit pas entrer en conflit avec un sous-réseau utilisé par l'infrastructure IBM Cloud (SoftLayer).

   Les préfixes pris en charge sont compris entre `/30` (1 adresse IP) et `/24` (253 adresses IP). Si vous avez défini un CIDR avec une longueur de préfixe et que vous devez modifier sa valeur, ajoutez d'abord le nouveau CIDR, puis [supprimez l'ancien CIDR](#cs_cluster_user_subnet_rm).</dd>

   <dt><code>--private-vlan <em>PRIVATE_VLAN</em></code></dt>
   <dd>ID du VLAN privé. Cette valeur est obligatoire. Elle doit correspondre à l'ID du VLAN privé d'un ou plusieurs noeuds worker dans le cluster.</dd>
   </dl>

**Exemple** :

  ```
  ibmcloud ks cluster-user-subnet-add --cluster my_cluster --subnet-cidr 169.xx.xxx.xxx/29 --private-vlan 1502175
  ```
  {: pre}


### ibmcloud ks cluster-user-subnet-rm --cluster CLUSTER --subnet-cidr SUBNET_CIDR --private-vlan PRIVATE_VLAN
{: #cs_cluster_user_subnet_rm}

Supprimez votre propre sous-réseau privé du cluster indiqué.

**Remarque :** tout service déployé sur une adresse IP depuis votre propre sous-réseau privé reste actif une fois le sous-réseau supprimé.

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Opérateur** pour {{site.data.keyword.containerlong_notm}}

<strong>Options de commande</strong> :

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>

   <dt><code>--subnet-cidr <em>SUBNET_CIDR</em></code></dt>
   <dd>CIDR (Classless InterDomain Routing) du sous-réseau. Cette valeur est obligatoire et doit correspondre au CIDR défini par la [commande](#cs_cluster_user_subnet_add) `ibmcloud ks cluster-user-subnet-add`.</dd>

   <dt><code>--private-vlan <em>PRIVATE_VLAN</em></code></dt>
   <dd>ID du VLAN privé. Cette valeur est obligatoire et doit correspondre à l'ID du VLAN défini par la [commande](#cs_cluster_user_subnet_add) `ibmcloud ks cluster-user-subnet-add`.</dd>
   </dl>

**Exemple** :

  ```
  ibmcloud ks cluster-user-subnet-rm --cluster my_cluster --subnet-cidr 169.xx.xxx.xxx/29 --private-vlan 1502175
  ```
  {: pre}

### ibmcloud ks subnets [--json][-s]
{: #cs_subnets}

Affichez la liste des sous-réseaux disponibles dans un compte d'infrastructure IBM Cloud (SoftLayer).

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Afficheur** pour {{site.data.keyword.containerlong_notm}}

<strong>Options de commande</strong> :

  <dl>
  <dt><code>--json</code></dt>
  <dd>Imprime le résultat de la commande au format JSON. Cette valeur est facultative.</dd>

  <dt><code>-s</code></dt>
  <dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>
  </dl>

**Exemple** :

  ```
  ibmcloud ks subnets
  ```
  {: pre}


<br />


## Commandes de l'équilibreur de charge d'application (ALB) Ingress
{: #alb_commands}

### ibmcloud ks alb-cert-deploy [--update] --cluster CLUSTER --secret-name SECRET_NAME --cert-crn CERTIFICATE_CRN [--update][-s]
{: #cs_alb_cert_deploy}

Déploiement ou mise à jour d'un certificat à partir de votre instance {{site.data.keyword.cloudcerts_long_notm}} vers l'équilibreur de charge d'application (ALB) dans un cluster.

**Remarque :** vous ne pouvez mettre à jour que des certificats importés depuis la même instance {{site.data.keyword.cloudcerts_long_notm}}.

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Administrateur** pour {{site.data.keyword.containerlong_notm}}

<strong>Options de commande</strong>

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>

   <dt><code>--update</code></dt>
   <dd>Met à jour le certificat d'une valeur confidentielle d'équilibreur de charge d'application (ALB) dans un cluster. Cette valeur est facultative.</dd>

   <dt><code>--secret-name <em>SECRET_NAME</em></code></dt>
   <dd>Nom de la valeur confidentielle ALB. Cette valeur est obligatoire.</dd>

   <dt><code>--cert-crn <em>CERTIFICATE_CRN</em></code></dt>
   <dd>CRN du certificat. Cette valeur est obligatoire.</dd>

   <dt><code>-s</code></dt>
   <dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>
   </dl>

**Exemples** :

Exemple de déploiement d'une valeur confidentielle ALB :

   ```
   ibmcloud ks alb-cert-deploy --secret-name my_alb_secret --cluster my_cluster --cert-crn crn:v1:staging:public:cloudcerts:us-south:a/06580c923e40314421d3b6cb40c01c68:0db4351b-0ee1-479d-af37-56a4da9ef30f:certificate:4bc35b7e0badb304e60aef00947ae7ff
   ```
   {: pre}

Exemple de mise à jour d'une valeur confidentielle ALB existante :

 ```
 ibmcloud ks alb-cert-deploy --update --secret-name my_alb_secret --cluster my_cluster --cert-crn crn:v1:staging:public:cloudcerts:us-south:a/06580c923e40314421d3b6cb40c01c68:0db4351b-0ee1-479d-af37-56a4da9ef30f:certificate:7e21fde8ee84a96d29240327daee3eb2
 ```
 {: pre}


### ibmcloud ks alb-cert-get --cluster CLUSTER [--secret-name SECRET_NAME][--cert-crn CERTIFICATE_CRN] [--json][-s]
{: #cs_alb_cert_get}

Affichage d'informations sur une valeur confidentielle ALB dans un cluster.

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Administrateur** pour {{site.data.keyword.containerlong_notm}}

<strong>Options de commande</strong>

  <dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
  <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>

  <dt><code>--secret-name <em>SECRET_NAME</em></code></dt>
  <dd>Nom de la valeur confidentielle ALB. Cette valeur est requise pour obtenir des informations sur une valeur confidentielle ALB spécifique dans le cluster.</dd>

  <dt><code>--cert-crn <em>CERTIFICATE_CRN</em></code></dt>
  <dd>CRN du certificat. Cette valeur est requise pour obtenir des informations sur toutes les valeurs confidentielles ALB correspondant à un CRN de certificat spécifique dans le cluster.</dd>

  <dt><code>--json</code></dt>
  <dd>Imprime le résultat de la commande au format JSON. Cette valeur est facultative.</dd>

  <dt><code>-s</code></dt>
  <dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>
  </dl>

**Exemples** :

 Exemple d'extraction d'informations sur une valeur confidentielle ALB :

 ```
 ibmcloud ks alb-cert-get --cluster my_cluster --secret-name my_alb_secret
 ```
 {: pre}

 Exemple d'extraction d'informations sur toutes les valeurs confidentielles ALB correspondant à un CRN de certificat spécifié :

 ```
 ibmcloud ks alb-cert-get --cluster my_cluster --cert-crn  crn:v1:staging:public:cloudcerts:us-south:a/06580c923e40314421d3b6cb40c01c68:0db4351b-0ee1-479d-af37-56a4da9ef30f:certificate:4bc35b7e0badb304e60aef00947ae7ff
 ```
 {: pre}


### ibmcloud ks alb-cert-rm --cluster CLUSTER [--secret-name SECRET_NAME][--cert-crn CERTIFICATE_CRN] [-s]
{: #cs_alb_cert_rm}

Retrait d'une valeur confidentielle ALB dans un cluster.

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Administrateur** pour {{site.data.keyword.containerlong_notm}}

<strong>Options de commande</strong>

  <dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
  <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>

  <dt><code>--secret-name <em>SECRET_NAME</em></code></dt>
  <dd>Nom de la valeur confidentielle ALB. Cette valeur est requise pour retirer une valeur confidentielle ALB spécifique dans le cluster.</dd>

  <dt><code>--cert-crn <em>CERTIFICATE_CRN</em></code></dt>
  <dd>CRN du certificat. Cette valeur est requise pour retirer toutes les valeurs confidentielles ALB correspondant à un CRN de certificat spécifique dans le cluster.</dd>

  <dt><code>-s</code></dt>
  <dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>

  </dl>

**Exemples** :

 Exemple de retrait d'une valeur confidentielle ALB :

 ```
 ibmcloud ks alb-cert-rm --cluster my_cluster --secret-name my_alb_secret
 ```
 {: pre}

 Exemple de retrait de toutes les valeurs confidentielles ALB correspondant à un CRN de certificat spécifié :

 ```
 ibmcloud ks alb-cert-rm --cluster my_cluster --cert-crn crn:v1:staging:public:cloudcerts:us-south:a/06580c923e40314421d3b6cb40c01c68:0db4351b-0ee1-479d-af37-56a4da9ef30f:certificate:4bc35b7e0badb304e60aef00947ae7ff
 ```
 {: pre}


### ibmcloud ks alb-certs --cluster CLUSTER [--json][-s]
{: #cs_alb_certs}

Affichage d'une liste de valeurs confidentielles ALB dans un cluster.

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Administrateur** pour {{site.data.keyword.containerlong_notm}}

<strong>Options de commande</strong>

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>
   <dt><code>--json</code></dt>
   <dd>Imprime le résultat de la commande au format JSON. Cette valeur est facultative.</dd>
   <dt><code>-s</code></dt>
   <dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>
   </dl>

**Exemple** :

 ```
 ibmcloud ks alb-certs --cluster my_cluster
 ```
 {: pre}

### ibmcloud ks alb-configure --albID ALB_ID [--enable][--user-ip USERIP] [--disable][--disable-deployment] [-s]
{: #cs_alb_configure}

Activation ou désactivation d'un équilibreur de charge ALB dans votre cluster standard. L'ALB public est activé par défaut.

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Editeur** pour {{site.data.keyword.containerlong_notm}}

**Options de commande** :

   <dl>
   <dt><code><em>--albID </em>ALB_ID</code></dt>
   <dd>ID d'un équilibreur de charge ALB. Exécutez la commande <code>ibmcloud ks albs <em>--cluster </em>CLUSTER</code> pour afficher les ID des équilibreurs de charge ALB d'un cluster. Cette valeur est obligatoire.</dd>

   <dt><code>--enable</code></dt>
   <dd>Incluez cet indicateur pour activer un équilibreur de charge ALB dans un cluster.</dd>

   <dt><code>--disable</code></dt>
   <dd>Incluez cet indicateur pour désactiver un équilibreur de charge ALB dans un cluster.</dd>

   <dt><code>--disable-deployment</code></dt>
   <dd>Incluez cet indicateur pour désactiver le déploiement de l'équilibreur de charge ALB fourni par IBM. Il ne supprime pas l'enregistrement DNS du sous-domaine Ingress fourni par IBM ou le service d'équilibreur de charge utilisé pour exposer le contrôleur Ingress.
    </dd>

   <dt><code>--user-ip <em>USER_IP</em></code></dt>
   <dd>

   <ul>
    <li>Ce paramètre n'est disponible que pour activer un équilibreur de charge d'application (ALB) privé</li>
    <li>L'ALB privé est déployé avec une adresse IP à partir d'un sous-réseau privé fourni par l'utilisateur. Si aucune adresse IP n'est fournie, l'ALB est déployé avec une adresse IP privée issue du sous-réseau privé portable qui est mis à disposition automatiquement lorsque vous avez créé le cluster.</li>
   </ul>
   </dd>

   <dt><code>-s</code></dt>
   <dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>

   </dl>

**Exemples** :

  Exemple d'activation d'un équilibreur de charge ALB :

  ```
  ibmcloud ks alb-configure --albID private-cr18a61a63a6a94b658596aa93a087aaa9-alb1 --enable
  ```
  {: pre}

  Exemple d'activation d'un équilibreur de charge ALB avec une adresse IP fournie par l'utilisateur :

  ```
  ibmcloud ks alb-configure --albID private-cr18a61a63a6a94b658596aa93a087aaa9-alb1 --enable --user-ip user_ip
  ```
  {: pre}

  Exemple de désactivation d'un équilibreur de charge ALB :

  ```
  ibmcloud ks alb-configure --albID public-cr18a61a63a6a94b658596aa93a087aaa9-alb1 --disable
  ```
  {: pre}

### ibmcloud ks alb-get --albID ALB_ID [--json][-s]
{: #cs_alb_get}

Affichage des détails d'un équilibreur de charge ALB.

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Afficheur** pour {{site.data.keyword.containerlong_notm}}

<strong>Options de commande</strong> :

   <dl>
   <dt><code><em>--albID </em>ALB_ID</code></dt>
   <dd>ID d'un équilibreur de charge ALB. Exécutez la commande <code>ibmcloud ks albs --cluster <em>CLUSTER</em></code> pour afficher les ID des équilibreurs de charge ALB d'un cluster. Cette valeur est obligatoire.</dd>

   <dt><code>--json</code></dt>
   <dd>Imprime le résultat de la commande au format JSON. Cette valeur est facultative.</dd>

  <dt><code>-s</code></dt>
  <dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>

   </dl>

**Exemple** :

  ```
  ibmcloud ks alb-get --albID public-cr18a61a63a6a94b658596aa93a087aaa9-alb1
  ```
  {: pre}

### ibmcloud ks alb-types [--json][-s]
{: #cs_alb_types}

Affichage des types d'équilibreur de charge ALB pris en charge dans la région.

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Afficheur** pour {{site.data.keyword.containerlong_notm}}

<strong>Options de commande</strong> :

  <dl>
  <dt><code>--json</code></dt>
  <dd>Imprime le résultat de la commande au format JSON. Cette valeur est facultative.</dd>

  <dt><code>-s</code></dt>
  <dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>
  </dl>

**Exemple** :

  ```
  ibmcloud ks alb-types
  ```
  {: pre}


### ibmcloud ks albs --cluster CLUSTER [--json][-s]
{: #cs_albs}

Affichage du statut de tous les équilibreurs de charge ALB dans un cluster. Si aucun ID ALB n'est renvoyé, le cluster n'a pas de sous-réseau portable. Vous pouvez [créer](#cs_cluster_subnet_create) ou [ajouter](#cs_cluster_subnet_add) des sous-réseaux à un cluster.

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Afficheur** pour {{site.data.keyword.containerlong_notm}}

<strong>Options de commande</strong> :

   <dl>
   <dt><code><em>--cluster </em>CLUSTER</code></dt>
   <dd>Nom ou ID du cluster sur lequel répertorier les équilibreurs de charge ALB disponibles. Cette valeur est obligatoire.</dd>

   <dt><code>--json</code></dt>
   <dd>Imprime le résultat de la commande au format JSON. Cette valeur est facultative.</dd>

   <dt><code>-s</code></dt>
   <dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>

   </dl>

**Exemple** :

  ```
  ibmcloud ks albs --cluster my_cluster
  ```
  {: pre}


<br />


## Commandes de l'infrastructure
{: #infrastructure_commands}



### ibmcloud ks credentials-set --infrastructure-api-key API_KEY --infrastructure-username USERNAME [-s]
{: #cs_credentials_set}

Définissez les données d'identification du compte d'infrastructure IBM Cloud (SoftLayer) pour un groupe de ressources et une région {{site.data.keyword.containerlong_notm}}.

Si vous disposez d'un compte de paiement à la carte {{site.data.keyword.Bluemix_notm}}, vous avez accès au portefeuille d'infrastructure IBM Cloud (SoftLayer) par défaut. Cependant, vous pouvez utiliser un autre compte d'infrastructure IBM Cloud (SoftLayer) dont vous disposez déjà pour commander l'infrastructure. Vous pouvez lier le compte de cette infrastructure à votre compte {{site.data.keyword.Bluemix_notm}} en utilisant cette commande.

Si les données d'identification de l'infrastructure IBM Cloud (SoftLayer) sont définies manuellement pour une région et un groupe de ressources, ces données sont utilisées pour commander l'infrastructure de tous les clusters au sein de cette région dans le groupe de ressources. Ces données d'identification sont utilisées pour déterminer des droits d'infrastructure, même s'il existe déjà une [clé d'API IAM](#cs_api_key_info) pour la région et le groupe de ressources. Si l'utilisateur dont les données d'identification sont stockées ne dispose pas des droits requis pour commander l'infrastructure, les actions liées à l'infrastructure, par exemple la création d'un cluster ou le rechargement d'un noeud worker risquent d'échouer.

Vous ne pouvez pas définir plusieurs données d'identification pour la même région et le même groupe de ressources {{site.data.keyword.containerlong_notm}}. 

**Important :** avant d'utiliser cette commande, assurez-vous que l'utilisateur dont les données d'identification sont utilisées dispose des droits [{{site.data.keyword.containerlong_notm}} et des droits de l'infrastructure IBM Cloud (SoftLayer)](cs_users.html#users) requis.

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Administrateur** pour {{site.data.keyword.containerlong_notm}}

<strong>Options de commande</strong> :

   <dl>
   <dt><code>--infrastructure-username <em>USERNAME</em></code></dt>
   <dd>Nom d'utilisateur d'API du compte d'infrastructure IBM Cloud (SoftLayer). Cette valeur est obligatoire. **Remarque** : Le nom d'utilisateur de l'API d'infrastructure est différent de l'IBMid. Pour afficher le nom d'utilisateur de l'API :
   <ol><li>Connectez-vous au portail [{{site.data.keyword.Bluemix_notm}} ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://console.bluemix.net/).</li>
   <li>Dans le menu qui s'affiche, sélectionnez **Infrastructure**.</li>
   <li>Dans la barre de menu, sélectionnez **Compte** > **Utilisateurs** > **Liste d'utilisateurs**.</li>
   <li>Pour l'utilisateur que vous souhaitez afficher, cliquez sur **IBMid ou nom d'utilisateur**.</li>
   <li>Dans la section **Informations d'accès à l'API**, reportez-vous à **Nom d'utilisateur de l'API**.</li>
   </ol></dd>


   <dt><code>--infrastructure-api-key <em>API_KEY</em></code></dt>
   <dd>Clé d'API du compte d'infrastructure IBM Cloud (SoftLayer). Cette valeur est obligatoire.

 <p>
  Pour générer une clé d'API, procédez comme suit :

  <ol>
  <li>Connectez-vous au [portail d'infrastructure IBM Cloud (SoftLayer) ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://control.bluemix.net/).</li>
  <li>Sélectionnez <strong>Compte</strong>, puis <strong>Utilisateurs</strong>.</li>
  <li>Cliquez sur <strong>Générer</strong> pour générer une clé d'API d'infrastructure IBM Cloud (SoftLayer) pour votre compte.</li>
  <li>Copiez la clé d'API à utiliser dans cette commande.</li>
  </ol>

  Pour afficher votre clé d'API existante, procédez comme suit :
  <ol>
  <li>Connectez-vous au [portail d'infrastructure IBM Cloud (SoftLayer) ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://control.bluemix.net/).</li>
  <li>Sélectionnez <strong>Compte</strong>, puis <strong>Utilisateurs</strong>.</li>
  <li>Cliquez sur <strong>Afficher</strong> pour afficher votre clé d'API existante.</li>
  <li>Copiez la clé d'API à utiliser dans cette commande.</li>
  </ol>
  </p></dd>

  <dt><code>-s</code></dt>
  <dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>

  </dl>

**Exemple** :

  ```
  ibmcloud ks credentials-set --infrastructure-api-key <api_key> --infrastructure-username dbmanager
  ```
  {: pre}

### ibmcloud ks credentials-unset
{: #cs_credentials_unset}

Supprimez les données d'identification du compte d'infrastructure IBM Cloud (SoftLayer) dans une région {{site.data.keyword.containerlong_notm}}.

Après avoir supprimé les données d'identification, la [clé d'API IAM](#cs_api_key_info) est utilisée pour commander des ressources dans l'infrastructure IBM Cloud (SoftLayer).

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Administrateur** pour {{site.data.keyword.containerlong_notm}}

<strong>Options de commande</strong> :

  <dl>
  <dt><code>-s</code></dt>
  <dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>
  </dl>

**Exemple** :

  ```
  ibmcloud ks credentials-unset
  ```
  {: pre}


### ibmcloud ks machine-types --zone ZONE [--json][-s]
{: #cs_machine_types}

Affichez la liste des types de machine disponibles pour vos noeuds worker. Les types de machine varient en fonction de la zone. Chaque type de machine inclut la quantité d'UC virtuelles, de mémoire et d'espace disque pour chaque noeud worker dans le cluster. Par défaut, le répertoire du disque de stockage secondaire dans lequel sont stockées toutes les données des conteneurs, est chiffré avec le chiffrement LUKS. Si l'option `disable-disk-encrypt` est incluse lors de la création du cluster, les données de l'environnement d'exécution de conteneur de l'hôte ne sont pas chiffrées. [En savoir plus sur le chiffrement](cs_secure.html#encrypted_disk).
{:shortdesc}

Vous pouvez mettre à disposition votre noeud worker en tant que machine virtuelle sur un matériel dédié ou partagé, ou en tant que machine physique sur un serveur bare metal. [En savoir plus sur les options correspondant à votre type de machine](cs_clusters_planning.html#shared_dedicated_node).

<strong>Droits minimum requis</strong> : aucun

<strong>Options de commande</strong> :

   <dl>
   <dt><code>--zone <em>ZONE</em></code></dt>
   <dd>Indiquez la zone dans laquelle vous souhaitez afficher la liste des types de machine disponibles. Cette valeur est obligatoire. Passez en revue les [zones disponibles](cs_regions.html#zones).</dd>

   <dt><code>--json</code></dt>
  <dd>Imprime le résultat de la commande au format JSON. Cette valeur est facultative.</dd>

  <dt><code>-s</code></dt>
  <dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>
  </dl>

**Exemple de commande** :

  ```
  ibmcloud ks machine-types --zone dal10
  ```
  {: pre}

### ibmcloud ks vlans --zone ZONE [--all][--json] [-s]
{: #cs_vlans}

Répertoriez les VLAN publics et privés disponibles pour une zone dans votre compte d'infrastructure IBM Cloud (SoftLayer). Pour répertorier ces réseaux, vous devez disposer d'un compte payant.

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Afficheur** pour {{site.data.keyword.containerlong_notm}}

<strong>Options de commande</strong> :

   <dl>
   <dt><code>--zone <em>ZONE</em></code></dt>
   <dd>Indiquez la zone où répertorier vos VLAN privés et publics. Cette valeur est obligatoire. Passez en revue les [zones disponibles](cs_regions.html#zones).</dd>

   <dt><code>--all</code></dt>
   <dd>Répertorie tous les VLAN disponibles. Par défaut, les VLAN sont filtrés pour n'afficher que les VLAN valides. Pour être valide, un VLAN doit être associé à l'infrastructure qui peut héberger un noeud worker avec un stockage sur disque local.</dd>

   <dt><code>--json</code></dt>
  <dd>Imprime le résultat de la commande au format JSON. Cette valeur est facultative.</dd>

  <dt><code>-s</code></dt>
  <dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>
   </dl>

**Exemple** :

  ```
  ibmcloud ks vlans --zone dal10
  ```
  {: pre}


### ibmcloud ks vlan-spanning-get [--json][-s]
{: #cs_vlan_spanning_get}

Affichez le statut de la fonction Spanning VLAN d'un compte d'infrastructure IBM Cloud (SoftLayer). La fonction Spanning VLAN permet à toutes les unités d'un même compte de communiquer les unes avec les autres par le biais du réseau privé, indépendamment du VLAN qui leur est affecté.

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Afficheur** pour {{site.data.keyword.containerlong_notm}}

<strong>Options de commande</strong> :

   <dl>
    <dt><code>--json</code></dt>
      <dd>Imprime le résultat de la commande au format JSON. Cette valeur est facultative.</dd>

    <dt><code>-s</code></dt>
      <dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>
   </dl>

**Exemple** :

  ```
  ibmcloud ks vlan-spanning-get
  ```
  {: pre}

<br />


## Commandes de consignation
{: #logging_commands}

### ibmcloud ks logging-config-create --cluster CLUSTER --logsource LOG_SOURCE --type LOG_TYPE [--namespace KUBERNETES_NAMESPACE][--hostname LOG_SERVER_HOSTNAME_OR_IP] [--port LOG_SERVER_PORT][--space CLUSTER_SPACE] [--org CLUSTER_ORG][--app-containers CONTAINERS] [--app-paths PATHS_TO_LOGS][--syslog-protocol PROTOCOL]  [--json][--skip-validation] [--force-update][-s]
{: #cs_logging_create}

Créez une configuration de consignation. Vous pouvez utiliser cette commande pour acheminer des journaux de conteneurs, applications, noeuds worker, clusters Kubernetes et équilibreurs de charge d'application Ingress à {{site.data.keyword.loganalysisshort_notm}} ou à un serveur syslog externe.

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Editeur** pour {{site.data.keyword.containerlong_notm}} pour toutes les sources de journal sauf `kube-audit` et rôle de plateforme IAM **Administrateur** pour {{site.data.keyword.containerlong_notm}} pour la source de journal `kube-audit`

<strong>Options de commande</strong> :

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>Nom ou ID du cluster.</dd>

  <dt><code>--logsource <em>LOG_SOURCE</em></code></dt>    
    <dd>Source de journal pour laquelle activer l'acheminement des journaux. Cet argument prend en charge une liste séparée par des virgules de sources de journal auxquelles appliquer la configuration. Valeurs admises : <code>container</code>, <code>application</code>, <code>worker</code>, <code>kubernetes</code>, <code>ingress</code> et <code>kube-audit</code>. Si vous ne fournissez pas de source de journal, des configurations sont créées pour <code>container</code> et <code>ingress</code>.</dd>

  <dt><code>--type <em>LOG_TYPE</em></code></dt>
    <dd>Destination de transfert de vos journaux. Les options possibles sont : <code>ibm</code> pour transférer vos journaux vers {{site.data.keyword.loganalysisshort_notm}} et <code>syslog</code> pour les transférer vers un serveur externe.</dd>

  <dt><code>--namespace <em>KUBERNETES_NAMESPACE</em></code></dt>
    <dd>Espace de nom Kubernetes depuis lequel vous désirez acheminer des journaux. L'acheminement des journaux n'est pas pris en charge pour les espaces de nom Kubernetes <code>ibm-system</code> et <code>kube-system</code>. Cette valeur est facultative et n'est valide que pour la source de journal conteneur. Si vous n'indiquez pas d'espace de nom, tous les espaces de nom du cluster utilisent cette configuration.</dd>

  <dt><code>--hostname <em>LOG_SERVER_HOSTNAME</em></code></dt>
    <dd>Si le type de consignation correspond à <code>syslog</code>, nom d'hôte ou adresse ID du serveur collecteur de journal. Cette valeur est obligatoire pour <code>syslog</code>. Si le type de consignation correspond à <code>ibm</code>, URL d'ingestion {{site.data.keyword.loganalysislong_notm}}. Vous trouverez [ici](/docs/services/CloudLogAnalysis/log_ingestion.html#log_ingestion_urls) la liste des URL d'ingestion disponibles. Si vous ne spécifiez pas d'URL d'ingestion, le noeud final de la région où votre cluster a été créé est utilisé.</dd>

  <dt><code>--port <em>LOG_SERVER_PORT</em></code></dt>
    <dd>Port du serveur collecteur de journal. Cette valeur est facultative. Si vous ne spécifiez pas de port, le port standard <code>514</code> est utilisé pour <code>syslog</code> et le port standard <code>9091</code> pour <code>ibm</code>.</dd>

  <dt><code>--space <em>CLUSTER_SPACE</em></code></dt>
    <dd>Facultatif : nom de l'espace Cloud Foundry auquel envoyer les journaux. Cette valeur est facultative et n'est valide que pour le type de journal <code>ibm</code>. Si vous ne spécifiez pas d'espace, les journaux sont envoyés au niveau du compte. Si vous en indiquez un, vous devez également spécifier une organisation.</dd>

  <dt><code>--org <em>CLUSTER_ORG</em></code></dt>
    <dd>Facultatif : nom de l'organisation Cloud Foundry où réside l'espace. Cette valeur n'est valide que pour le type de journal <code>ibm</code> et est obligatoire si vous avez spécifié un espace.</dd>

  <dt><code>--app-paths</code></dt>
    <dd>Chemin dans le conteneur utilisé par les applications pour la consignation. Pour transférer des journaux avec le type de source <code>application</code>, vous devez indiquer un chemin. Pour indiquer plusieurs chemins, utilisez une liste séparée par des virgules. Cette valeur est obligatoire pour la source de journal <code>application</code>. Exemple : <code>/var/log/myApp1/&ast;,/var/log/myApp2/&ast;</code></dd>

  <dt><code>--syslog-protocol</code></dt>
    <dd>Protocole de couche de transfert utilisé lorsque le type de consignation est <code>syslog</code>. Valeurs admises : <code>tcp</code>, <code>tls</code> et la valeur par défaut <code>udp</code>. Lors du transfert vers un serveur rsyslog avec le protocole <code>udp</code>, les journaux dont la taille est supérieure à 1 ko sont tronqués.</dd>

  <dt><code>--app-containers</code></dt>
    <dd>Pour transférer les journaux à partir d'une application, vous pouvez indiquer le nom du conteneur contenant votre application. Vous pouvez spécifier plusieurs conteneurs en utilisant une liste séparée par des virgules. Si aucun conteneur n'est indiqué, les journaux sont transférés à partir de tous les conteneurs contenant les chemins que vous avez fournis. Cette option n'est valide que pour la source de journal <code>application</code>.</dd>

  <dt><code>--json</code></dt>
    <dd>Imprime le résultat de la commande au format JSON. Cette valeur est facultative.</dd>

  <dt><code>--skip-validation</code></dt>
    <dd>Ignore la validation des noms d'organisation et d'espace lorsqu'ils sont spécifiés. Cette opération permet de réduire le temps de traitement, mais une configuration de consignation non valide ne transfère pas correctement les journaux. Cette valeur est facultative.</dd>

  <dt><code>--force-update</code></dt>
    <dd>Force la mise à jour de vos pods Fluentd à la version la plus récente. Fluentd doit être à la version la plus récente pour apporter des modifications à vos configurations de consignation.</dd>

    <dt><code>-s</code></dt>
    <dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>
</dl>

**Exemples** :

Exemple pour le type de journal `ibm` qui achemine les données depuis une source de journal `container` sur le port par défaut :

  ```
  ibmcloud ks logging-config-create my_cluster --logsource container --namespace my_namespace --hostname ingest.logging.ng.bluemix.net --type ibm
  ```
  {: pre}

Exemple pour le type de journal `syslog` acheminé depuis une source de journal `container` sur le port par défaut 514 :

  ```
  ibmcloud ks logging-config-create my_cluster --logsource container --namespace my_namespace  --hostname 169.xx.xxx.xxx --type syslog
  ```
  {: pre}

Exemple pour le type de journal `syslog` qui achemine des journaux depuis une source `ingress` sur un port différent de celui par défaut :

  ```
  ibmcloud ks logging-config-create --cluster my_cluster --logsource container --hostname 169.xx.xxx.xxx --port 5514 --type syslog
  ```
  {: pre}

### ibmcloud ks logging-config-get --cluster CLUSTER [--logsource LOG_SOURCE][--json] [-s]
{: #cs_logging_get}

Affichez toutes les configurations d'acheminement de journaux d'un cluster ou filtrez les configurations de consignation en fonction de la source de journal.

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Afficheur** pour {{site.data.keyword.containerlong_notm}}

<strong>Options de commande</strong> :

 <dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>

  <dt><code>--logsource <em>LOG_SOURCE</em></code></dt>
    <dd>Type de source de journal que vous voulez filtrer. Seules les configurations de consignation de cette source de journal dans le cluster sont renvoyées. Valeurs admises : <code>container</code>, <code>application</code>, <code>worker</code>, <code>kubernetes</code>, <code>ingress</code> et <code>kube-audit</code>. Cette valeur est facultative.</dd>

  <dt><code>--show-covering-filters</code></dt>
    <dd>Affiche les filtres de consignation qui rendent obsolètes les filtres précédents.</dd>

  <dt><code>--json</code></dt>
    <dd>Imprime le résultat de la commande au format JSON. Cette valeur est facultative.</dd>

  <dt><code>-s</code></dt>
    <dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>
 </dl>

**Exemple** :

  ```
  ibmcloud ks logging-config-get --cluster my_cluster --logsource worker
  ```
  {: pre}


### ibmcloud ks logging-config-refresh --cluster CLUSTER  [--force-update]  [-s]
{: #cs_logging_refresh}

Actualise la configuration de consignation pour le cluster. Ceci actualise le jeton de consignation de toute configuration de consignation qui achemine des données au niveau de l'espace dans votre cluster.

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Editeur** pour {{site.data.keyword.containerlong_notm}}

<strong>Options de commande</strong> :

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>

   <dt><code>--force-update</code></dt>
     <dd>Force la mise à jour de vos pods Fluentd à la version la plus récente. Fluentd doit être à la version la plus récente pour apporter des modifications à vos configurations de consignation.</dd>

   <dt><code>-s</code></dt>
     <dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>
</dl>

**Exemple** :

  ```
  ibmcloud ks logging-config-refresh --cluster my_cluster
  ```
  {: pre}


### ibmcloud ks logging-config-rm --cluster CLUSTER [--id LOG_CONFIG_ID][--all] [--force-update][-s]
{: #cs_logging_rm}

Supprimez une configuration d'acheminement des journaux ou toutes les configurations de consignation d'un cluster. Ceci cesse l'acheminement des journaux à un serveur syslog distant ou à {{site.data.keyword.loganalysisshort_notm}}.

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Editeur** pour {{site.data.keyword.containerlong_notm}} pour toutes les sources de journal sauf `kube-audit` et rôle de plateforme IAM **Administrateur** pour {{site.data.keyword.containerlong_notm}} pour la source de journal `kube-audit`

<strong>Options de commande</strong> :

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>

  <dt><code>--id <em>LOG_CONFIG_ID</em></code></dt>
   <dd>Si vous souhaitez supprimer une seule configuration de consignation, ID de la configuration de consignation.</dd>

  <dt><code>--all</code></dt>
   <dd>Indicateur permettant de supprimer toutes les configurations de consignation dans un cluster.</dd>

  <dt><code>--force-update</code></dt>
    <dd>Force la mise à jour de vos pods Fluentd à la version la plus récente. Fluentd doit être à la version la plus récente pour apporter des modifications à vos configurations de consignation.</dd>

   <dt><code>-s</code></dt>
     <dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>
</dl>

**Exemple** :

  ```
  ibmcloud ks logging-config-rm --cluster my_cluster --id f4bc77c0-ee7d-422d-aabf-a4e6b977264e
  ```
  {: pre}


### ibmcloud ks logging-config-update --cluster CLUSTER --id LOG_CONFIG_ID --type LOG_TYPE  [--namespace NAMESPACE][--hostname LOG_SERVER_HOSTNAME_OR_IP] [--port LOG_SERVER_PORT][--space CLUSTER_SPACE] [--org CLUSTER_ORG][--app-paths PATH] [--app-containers PATH][--json] [--skipValidation][--force-update] [-s]
{: #cs_logging_update}

Mettez à jour les détails d'une configuration d'acheminement des journaux.

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Editeur** pour {{site.data.keyword.containerlong_notm}}

<strong>Options de commande</strong> :

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>

  <dt><code>--id <em>LOG_CONFIG_ID</em></code></dt>
   <dd>ID de configuration de consignation que vous souhaitez mettre à jour. Cette valeur est obligatoire.</dd>

  <dt><code>--type <em>LOG_TYPE</em></code></dt>
   <dd>Protocole de transfert de journal que vous souhaitez utiliser. Actuellement, <code>syslog</code> et <code>ibm</code> sont pris en charge. Cette valeur est obligatoire.</dd>

  <dt><code>--namespace <em>NAMESPACE</em></code>
    <dd>Espace de nom Kubernetes depuis lequel vous désirez acheminer des journaux. L'acheminement des journaux n'est pas pris en charge pour les espaces de nom Kubernetes <code>ibm-system</code> et <code>kube-system</code>. Cette valeur n'est valide que pour la source de journal <code>container</code>. Si vous n'indiquez pas d'espace de nom, tous les espaces de nom du cluster utilisent cette configuration.</dd>

  <dt><code>--hostname <em>LOG_SERVER_HOSTNAME</em></code></dt>
   <dd>Si le type de consignation correspond à <code>syslog</code>, nom d'hôte ou adresse ID du serveur collecteur de journal. Cette valeur est obligatoire pour <code>syslog</code>. Si le type de consignation correspond à <code>ibm</code>, URL d'ingestion {{site.data.keyword.loganalysislong_notm}}. Vous trouverez [ici](/docs/services/CloudLogAnalysis/log_ingestion.html#log_ingestion_urls) la liste des URL d'ingestion disponibles. Si vous ne spécifiez pas d'URL d'ingestion, le noeud final de la région où votre cluster a été créé est utilisé.</dd>

   <dt><code>--port <em>LOG_SERVER_PORT</em></code></dt>
   <dd>Port du serveur collecteur de journal. Cette valeur est facultative lorsque le type de consignation est <code>syslog</code>. Si vous ne spécifiez pas de port, le port standard <code>514</code> est utilisé pour <code>syslog</code> et le port <code>9091</code> pour <code>ibm</code>.</dd>

   <dt><code>--space <em>CLUSTER_SPACE</em></code></dt>
   <dd>Facultatif : nom de l'espace auquel vous désirez envoyer les journaux. Cette valeur est facultative et n'est valide que pour le type de journal <code>ibm</code>. Si vous ne spécifiez pas d'espace, les journaux sont envoyés au niveau du compte. Si vous en indiquez un, vous devez également spécifier une organisation.</dd>

   <dt><code>--org <em>CLUSTER_ORG</em></code></dt>
   <dd>Facultatif : nom de l'organisation Cloud Foundry où réside l'espace. Cette valeur n'est valide que pour le type de journal <code>ibm</code> et est obligatoire si vous avez spécifié un espace.</dd>

   <dt><code>--app-paths <em>PATH</em>,<em>PATH</em></code></dt>
     <dd>Chemin de fichier absolu dans le conteneur, à partir duquel les journaux sont collectés. Les caractères génériques, tels que '/var/log/*.log', peuvent être utilisés, mais les modules glob récursifs, tels que '/var/log/**/test.log', ne peuvent pas être utilisés. Pour indiquer plusieurs chemins, utilisez une liste séparée par des virgules. Cette valeur est obligatoire lorsque vous spécifiez 'application' pour la source journal. </dd>

   <dt><code>--app-containers <em>PATH</em>,<em>PATH</em></code></dt>
     <dd>Chemin dans les conteneurs utilisés par les applications pour la consignation. Pour transférer des journaux avec le type de source <code>application</code>, vous devez indiquer un chemin. Pour indiquer plusieurs chemins, utilisez une liste séparée par des virgules. Exemple : <code>/var/log/myApp1/&ast;,/var/log/myApp2/&ast;</code></dd>

   <dt><code>--json</code></dt>
    <dd>Imprime le résultat de la commande au format JSON. Cette valeur est facultative.</dd>

   <dt><code>--skipValidation</code></dt>
    <dd>Ignore la validation des noms d'organisation et d'espace lorsqu'ils sont spécifiés. Cette opération permet de réduire le temps de traitement, mais une configuration de consignation non valide ne transfère pas correctement les journaux. Cette valeur est facultative.</dd>

  <dt><code>--force-update</code></dt>
    <dd>Force la mise à jour de vos pods Fluentd à la version la plus récente. Fluentd doit être à la version la plus récente pour apporter des modifications à vos configurations de consignation.</dd>

   <dt><code>-s</code></dt>
     <dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>
  </dl>

**Exemple pour le type de journal `ibm`** :

  ```
  ibmcloud ks logging-config-update my_cluster --id f4bc77c0-ee7d-422d-aabf-a4e6b977264e --type ibm
  ```
  {: pre}

**Exemple pour le type de journal `syslog`** :

  ```
  ibmcloud ks logging-config-update --cluster my_cluster --id f4bc77c0-ee7d-422d-aabf-a4e6b977264e --hostname localhost --port 5514 --type syslog
  ```
  {: pre}


### ibmcloud ks logging-filter-create --cluster CLUSTER --type LOG_TYPE [--logging-configs CONFIGS][--namespace KUBERNETES_NAMESPACE] [--container CONTAINER_NAME][--level LOGGING_LEVEL] [--message MESSAGE][--regex-message MESSAGE] [--force-update][--json] [-s]
{: #cs_log_filter_create}

Créez un filtre de consignation. Cette commande vous permet de filtrer les journaux transférés par votre configuration de consignation.

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Editeur** pour {{site.data.keyword.containerlong_notm}}

<strong>Options de commande</strong> :

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>Nom ou ID du cluster pour lequel vous souhaitez créer un filtre de consignation. Cette valeur est obligatoire.</dd>

  <dt><code>--type <em>LOG_TYPE</em></code></dt>
    <dd>Type des journaux auquel vous voulez appliquer le filtre. Les types <code>all</code>, <code>container</code> et <code>host</code> sont actuellement pris en charge.</dd>

  <dt><code>--logging-configs <em>CONFIGS</em></code></dt>
    <dd>Liste séparée par des virgules contenant les ID de vos configurations de consignation. Si cette liste n'est pas fournie, le filtre s'applique à toutes les configurations de consignation du cluster qui sont transmises au filtre. Vous pouvez afficher les configurations de journal qui correspondent au filtre en utilisant l'indicateur <code>--show-matching-configs</code> avec la commande. Cette valeur est facultative.</dd>

  <dt><code>--namespace <em>KUBERNETES_NAMESPACE</em></code></dt>
    <dd>Espace de nom Kubernetes à partir duquel vous souhaitez filtrer les journaux. Cette valeur est facultative.</dd>

  <dt><code>--container <em>CONTAINER_NAME</em></code></dt>
    <dd>Nom du conteneur à partir duquel vous voulez filtrer les journaux. Cet indicateur s'applique uniquement lorsque vous utilisez le type de journal <code>container</code>. Cette valeur est facultative.</dd>

  <dt><code>--level <em>LOGGING_LEVEL</em></code></dt>
    <dd>Filtre les journaux dont le niveau est inférieur ou égal au niveau spécifié. Les valeurs admises, par ordre canonique, sont : <code>fatal</code>, <code>error</code>, <code>warn/warning</code>, <code>info</code>, <code>debug</code> et <code>trace</code>. Cette valeur est facultative. Par exemple, si vous avez filtré les journaux au niveau <code>info</code>, les niveaux <code>debug</code> et <code>trace</code> sont également filtrés. **Remarque** : vous pouvez utiliser cet indicateur uniquement si les messages de journal sont au format JSON et contiennent une zone de niveau. Exemple de sortie : <code>{"log": "hello", "level": "info"}</code></dd>

  <dt><code>--message <em>MESSAGE</em></code></dt>
    <dd>Filtre les journaux contenant un message particulier n'importe où dans le journal. Cette valeur est facultative. Exemple : les messages "Hello", "!" et "Hello, World!", s'appliqueront au journal "Hello, World!".</dd>

  <dt><code>--regex-message <em>MESSAGE</em></code></dt>
    <dd>Filtre les journaux qui contiennent un message particulier écrit sous forme d'expression régulière n'importe où dans le journal. Cette valeur est facultative. Exemple : le masque "hello [0-9]" s'appliquera à "hello 1", "hello 2" et "hello 9".</dd>

  <dt><code>--force-update</code></dt>
    <dd>Force la mise à jour de vos pods Fluentd à la version la plus récente. Fluentd doit être à la version la plus récente pour apporter des modifications à vos configurations de consignation.</dd>

  <dt><code>--json</code></dt>
    <dd>Imprime le résultat de la commande au format JSON. Cette valeur est facultative.</dd>

  <dt><code>-s</code></dt>
    <dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>
</dl>

**Exemples** :

L'exemple suivant permet de filtrer tous les journaux transmis à partir de conteneurs nommés `test-container` dans l'espace de nom par défaut dont le niveau est debug ou inférieur et dont le message de journal contient "GET request".

  ```
  ibmcloud ks logging-filter-create --cluster example-cluster --type container --namespace default --container test-container --level debug --message "GET request"
  ```
  {: pre}

L'exemple suivant permet de filtrer tous les journaux transférés, de niveau info ou inférieur, à partir d'un cluster spécifique. La sortie est renvoyée au format JSON.

  ```
  ibmcloud ks logging-filter-create --cluster example-cluster --type all --level info --json
  ```
  {: pre}



### ibmcloud ks logging-filter-get --cluster CLUSTER [--id FILTER_ID][--show-matching-configs] [--show-covering-filters][--json] [-s]
{: #cs_log_filter_view}

Affichez une configuration de filtre de consignation. Vous pouvez utiliser cette commande pour afficher les filtres de consignation que vous avez créés.

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Afficheur** pour {{site.data.keyword.containerlong_notm}}

<strong>Options de commande</strong> :

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>Nom ou ID du cluster à partir duquel vous souhaitez afficher les filtres. Cette valeur est obligatoire.</dd>

  <dt><code>--id <em>FILTER_ID</em></code></dt>
    <dd>ID du filtre de journal que vous désirez afficher.</dd>

  <dt><code>--show-matching-configs</code></dt>
    <dd>Affiche les configurations de consignation qui correspondent à la configuration que vous consultez actuellement. Cette valeur est facultative.</dd>

  <dt><code>--show-covering-filters</code></dt>
    <dd>Affiche les filtres de consignation qui rendent obsolètes les filtres précédents. Cette valeur est facultative.</dd>

  <dt><code>--json</code></dt>
    <dd>Imprime le résultat de la commande au format JSON. Cette valeur est facultative.</dd>

   <dt><code>-s</code></dt>
     <dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>
</dl>

**Exemple** :

```
ibmcloud ks logging-filter-get mycluster --id 885732 --show-matching-configs
```
{: pre}

### ibmcloud ks logging-filter-rm --cluster CLUSTER [--id FILTER_ID][--all] [--force-update][-s]
{: #cs_log_filter_delete}

Supprimez un filtre de consignation. Vous pouvez utiliser cette commande pour supprimer un filtre de consignation que vous avez créé.

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Editeur** pour {{site.data.keyword.containerlong_notm}}

<strong>Options de commande</strong> :

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>Nom ou ID du cluster duquel vous souhaitez supprimer un filtre.</dd>

  <dt><code>--id <em>FILTER_ID</em></code></dt>
    <dd>ID du filtre de journal à supprimer.</dd>

  <dt><code>--all</code></dt>
    <dd>Supprime tous vos filtres d'acheminement de journaux. Cette valeur est facultative.</dd>

  <dt><code>--force-update</code></dt>
    <dd>Force la mise à jour de vos pods Fluentd à la version la plus récente. Fluentd doit être à la version la plus récente pour apporter des modifications à vos configurations de consignation.</dd>

  <dt><code>-s</code></dt>
    <dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>
</dl>

**Exemple** :

```
ibmcloud ks logging-filter-rm mycluster --id 885732
```
{: pre}

### ibmcloud ks logging-filter-update --cluster CLUSTER --id FILTER_ID --type LOG_TYPE [--logging-configs CONFIGS][--namespace KUBERNETES_NAMESPACE] [--container CONTAINER_NAME][--level LOGGING_LEVEL] [--message MESSAGE][--regex-message MESSAGE] [--force-update][--json] [-s]
{: #cs_log_filter_update}

Mettez à jour un filtre de consignation. Vous pouvez utiliser cette commande pour mettre à jour un filtre de consignation que vous avez créé.

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Editeur** pour {{site.data.keyword.containerlong_notm}}

<strong>Options de commande</strong> :

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>Nom ou ID du cluster pour lequel vous souhaitez mettre à jour un filtre de consignation. Cette valeur est obligatoire.</dd>

 <dt><code>--id <em>FILTER_ID</em></code></dt>
    <dd>ID du filtre de journal à mettre à jour.</dd>

  <dt><code>--type <em>LOG_TYPE</em></code></dt>
    <dd>Type des journaux auquel vous voulez appliquer le filtre. Les types <code>all</code>, <code>container</code> et <code>host</code> sont actuellement pris en charge.</dd>

  <dt><code>--logging-configs <em>CONFIGS</em></code></dt>
    <dd>Liste séparée par des virgules contenant les ID de vos configurations de consignation. Si cette liste n'est pas fournie, le filtre s'applique à toutes les configurations de consignation du cluster qui sont transmises au filtre. Vous pouvez afficher les configurations de journal qui correspondent au filtre en utilisant l'indicateur <code>--show-matching-configs</code> avec la commande. Cette valeur est facultative.</dd>

  <dt><code>--namespace <em>KUBERNETES_NAMESPACE</em></code></dt>
    <dd>Espace de nom Kubernetes à partir duquel vous souhaitez filtrer les journaux. Cette valeur est facultative.</dd>

  <dt><code>--container <em>CONTAINER_NAME</em></code></dt>
    <dd>Nom du conteneur à partir duquel vous voulez filtrer les journaux. Cet indicateur s'applique uniquement lorsque vous utilisez le type de journal <code>container</code>. Cette valeur est facultative.</dd>

  <dt><code>--level <em>LOGGING_LEVEL</em></code></dt>
    <dd>Filtre les journaux dont le niveau est inférieur ou égal au niveau spécifié. Les valeurs admises, par ordre canonique, sont : <code>fatal</code>, <code>error</code>, <code>warn/warning</code>, <code>info</code>, <code>debug</code> et <code>trace</code>. Cette valeur est facultative. Par exemple, si vous avez filtré les journaux au niveau <code>info</code>, les niveaux <code>debug</code> et <code>trace</code> sont également filtrés. **Remarque** : vous pouvez utiliser cet indicateur uniquement si les messages de journal sont au format JSON et contiennent une zone de niveau. Exemple de sortie : <code>{"log": "hello", "level": "info"}</code></dd>

  <dt><code>--message <em>MESSAGE</em></code></dt>
    <dd>Filtre les journaux contenant un message particulier n'importe où dans le journal. Cette valeur est facultative. Exemple : les messages "Hello", "!" et "Hello, World!", s'appliqueront au journal "Hello, World!".</dd>

  <dt><code>--regex-message <em>MESSAGE</em></code></dt>
    <dd>Filtre les journaux qui contiennent un message particulier écrit sous forme d'expression régulière n'importe où dans le journal. Cette valeur est facultative. Exemple : le masque "hello [0-9]" s'appliquera à "hello 1", "hello 2" et "hello 9".</dd>

  <dt><code>--force-update</code></dt>
    <dd>Force la mise à jour de vos pods Fluentd à la version la plus récente. Fluentd doit être à la version la plus récente pour apporter des modifications à vos configurations de consignation.</dd>

  <dt><code>--json</code></dt>
    <dd>Imprime le résultat de la commande au format JSON. Cette valeur est facultative.</dd>

  <dt><code>-s</code></dt>
    <dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>
</dl>

**Exemples** :

L'exemple suivant permet de filtrer tous les journaux transmis à partir de conteneurs nommés `test-container` dans l'espace de nom par défaut dont le niveau est debug ou inférieur et dont le message de journal contient "GET request".

  ```
  ibmcloud ks logging-filter-update --cluster example-cluster --id 885274 --type container --namespace default --container test-container --level debug --message "GET request"
  ```
  {: pre}

L'exemple suivant permet de filtrer tous les journaux transférés, de niveau info ou inférieur, à partir d'un cluster spécifique. La sortie est renvoyée au format JSON.

  ```
  ibmcloud ks logging-filter-update --cluster example-cluster --id 274885 --type all --level info --json
  ```
  {: pre}

### ibmcloud ks logging-autoupdate-enable --cluster CLUSTER
{: #cs_log_autoupdate_enable}

Activez la mise à jour automatique de vos pods Fluentd dans un cluster spécifique.

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Administrateur** pour {{site.data.keyword.containerlong_notm}}

<strong>Options de commande</strong> :

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>Nom ou ID du cluster pour lequel vous souhaitez mettre à jour un filtre de consignation. Cette valeur est obligatoire.</dd>
</dl>

**Exemple :**
```
ibmcloud ks logging-autoupdate-enable --cluster mycluster
```
{: pre}

### ibmcloud ks logging-autoupdate-disable --cluster CLUSTER
{: #cs_log_autoupdate_disable}

Désactivez la mise à jour automatique de vos pods Fluentd dans un cluster spécifique.

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Administrateur** pour {{site.data.keyword.containerlong_notm}}

<strong>Options de commande</strong> :

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>Nom ou ID du cluster pour lequel vous souhaitez mettre à jour un filtre de consignation. Cette valeur est obligatoire.</dd>
</dl>

**Exemple :**
```
ibmcloud ks logging-autoupdate-disable --cluster mycluster
```
{: pre}

### ibmcloud ks logging-autoupdate-get --cluster CLUSTER
{: #cs_log_autoupdate_get}

Visualisez si vos pods Fluentd sont définis pour se mettre à jour automatiquement dans un cluster spécifique.

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Afficheur** pour {{site.data.keyword.containerlong_notm}}

<strong>Options de commande</strong> :

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>Nom ou ID du cluster pour lequel vous souhaitez mettre à jour un filtre de consignation. Cette valeur est obligatoire.</dd>
</dl>

**Exemple :**
```
ibmcloud ks logging-autoupdate-get --cluster mycluster
```
{: pre}

### ibmcloud ks logging-collect --cluster CLUSTER --cos-bucket BUCKET_NAME --cos-endpoint ENDPOINT --hmac-key-id HMAC_KEY_ID --hmac-key HMAC_KEY --type LOG_TYPE [-s]
{: #cs_log_collect}

Effectuez une demande d'instantané de vos journaux à un moment précis et stockez les journaux dans un compartiment {{site.data.keyword.cos_full_notm}}.

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Administrateur** pour {{site.data.keyword.containerlong_notm}}

<strong>Options de commande</strong> :

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>Nom ou ID du cluster pour lequel vous souhaitez créer un instantané. Cette valeur est obligatoire.</dd>

 <dt><code>--cos-bucket <em>BUCKET_NAME</em></code></dt>
    <dd>Nom du compartiment {{site.data.keyword.cos_short}} dans lequel vous souhaitez stocker vos journaux. Cette valeur est obligatoire.</dd>

  <dt><code>--cos-endpoint <em>ENDPOINT</em></code></dt>
    <dd>Noeud final {{site.data.keyword.cos_short}} pour le compartiment dans lequel vous stockez vos journaux. Cette valeur est obligatoire.</dd>

  <dt><code>--hmac-key-id <em>HMAC_KEY_ID</em></code></dt>
    <dd>ID unique de vos données d'identification HMAC pour votre instance Object Storage. Cette valeur est obligatoire.</dd>

  <dt><code>--hmac-key <em>HMAC_KEY</em></code></dt>
    <dd>Clé HMAC pour votre instance {{site.data.keyword.cos_short}}. Cette valeur est obligatoire.</dd>

  <dt><code>--type <em>LOG_TYPE</em></code></dt>
    <dd>Type des journaux dont vous souhaitez créer un instantané. Actuellement, la valeur par défaut `master` est la seule option possible.</dd>

  <dt><code>-s</code></dt>
    <dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>
</dl>

**Exemple** :

  ```
  ibmcloud ks logging-collect --cluster mycluster --cos-bucket mybucket --cos-endpoint s3-api.us-geo.objectstorage.softlayer.net --hmac-key-id e2e7f5c9fo0144563c418dlhi3545m86 --hmac-key c485b9b9fo4376722f692b63743e65e1705301ab051em96j
  ```
  {: pre}

**Exemple de sortie** :

  ```
  There is no specified log type. The default master will be used.
  Submitting log collection request for master logs for cluster mycluster...
  OK
  The log collection request was successfully submitted. To view the status of the request run ibmcloud ks logging-collect-status mycluster.
  ```
  {: screen}

### ibmcloud ks logging-collect-status --cluster CLUSTER [--json][-s]
{: #cs_log_collect_status}

Vérifiez le statut de demande d'instantané de la collecte de journaux pour votre cluster.

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Administrateur** pour {{site.data.keyword.containerlong_notm}}

<strong>Options de commande</strong> :

<dl>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>Nom ou ID du cluster pour lequel vous souhaitez créer un instantané. Cette valeur est obligatoire.</dd>

  <dt><code>--json</code></dt>
    <dd>Imprime le résultat de la commande au format JSON. Cette valeur est facultative.</dd>

  <dt><code>-s</code></dt>
    <dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>
</dl>

**Exemple** :

  ```
  ibmcloud ks logging-collect-status --cluster mycluster
  ```
  {: pre}

**Exemple de sortie** :

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


## Commandes de région
{: #region_commands}

### ibmcloud ks zones [--region-only][--json] [-s]
{: #cs_datacenters}

Affichez la liste de toutes les zones disponibles pour créer un cluster. Ces zones varient selon la région à laquelle vous êtes connecté. Pour changer de région, exécutez la commande `ibmcloud ks region-set`.

<strong>Droits minimum requis</strong> : aucun

<strong>Options de commande</strong> :

   <dl>
   <dt><code>--region-only</code></dt>
   <dd>Affiche uniquement la liste des zones multiples qui se trouvent dans la région à laquelle vous êtes connecté. Cette valeur est facultative.</dd>

   <dt><code>--json</code></dt>
   <dd>Imprime le résultat de la commande au format JSON. Cette valeur est facultative.</dd>

   <dt><code>-s</code></dt>
   <dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>
   </dl>

**Exemple** :

  ```
  ibmcloud ks zones
  ```
  {: pre}


### ibmcloud ks region
{: #cs_region}

Identifiez la région {{site.data.keyword.containerlong_notm}} où vous êtes actuellement situé. Vous pouvez créer et gérer des clusters spécifiques à la région. Utilisez la commande `ibmcloud ks region-set` pour changer de région.

<strong>Droits minimum requis</strong> : aucun

**Exemple** :

```
ibmcloud ks region
```
{: pre}

**Sortie **:
```
Region: us-south
```
{: screen}

### ibmcloud ks region-set [--region REGION]
{: #cs_region-set}

Définissez la région pour {{site.data.keyword.containerlong_notm}}. Vous pouvez créer et gérer des clusters spécifiques à la région, et aussi désirer disposer de clusters dans plusieurs régions en vue d'une haute disponibilité.

Par exemple, vous pourriez vous connecter à {{site.data.keyword.Bluemix_notm}} dans la région Sud des Etats-Unis et y créer un cluster. Vous pourriez ensuite utiliser la commande `ibmcloud ks region-set eu-central` pour cibler la région Europe centrale et y créer un autre cluster. Enfin, vous pourriez utiliser la commande `ibmcloud ks region-set us-south` pour revenir à la région Sud des Etats-Unis et gérer votre cluster dans cette région.

<strong>Droits minimum requis</strong> : aucun

**Options de commande** :

<dl>
<dt><code>--region <em>REGION</em></code></dt>
<dd>Entrez la région que vous désirez cibler. Cette valeur est facultative. Si vous n'indiquez pas la région, vous pouvez la sélectionner dans la liste figurant dans la sortie.

Pour obtenir la liste des régions disponibles, consultez la rubrique [régions et zones](cs_regions.html) ou utilisez la commande `ibmcloud ks regions` [](#cs_regions).</dd></dl>

**Exemple** :

```
ibmcloud ks region-set eu-central
```
{: pre}

```
ibmcloud ks region-set
```
{: pre}

**Sortie **:
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

Répertorie les régions disponibles. Le nom indiqué dans `Region Name` correspond au nom {{site.data.keyword.containerlong_notm}} et `Region Alias` correspond au nom {{site.data.keyword.Bluemix_notm}} général pour la région.

<strong>Droits minimum requis</strong> : aucun

**Exemple** :

```
ibmcloud ks regions
```
{: pre}

**Sortie **:
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


## Commandes de noeud worker
{: worker_node_commands}


### Déprécié : ibmcloud ks worker-add --cluster CLUSTER [--file FILE_LOCATION][--hardware HARDWARE] --machine-type MACHINE_TYPE --workers NUMBER --private-vlan PRIVATE_VLAN --public-vlan PUBLIC_VLAN [--disable-disk-encrypt][-s]
{: #cs_worker_add}

Ajoutez dans votre cluster des noeuds worker autonomes qui ne figurent pas dans un pool de noeuds worker.

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Opérateur** pour {{site.data.keyword.containerlong_notm}}

<strong>Options de commande</strong> :

<dl>
<dt><code>--cluster <em>CLUSTER</em></code></dt>
<dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>

<dt><code>--file <em>FILE_LOCATION</em></code></dt>
<dd>Chemin d'accès au fichier YAML pour ajouter des noeuds worker au cluster. Au lieu de définir des noeuds worker supplémentaires à l'aide des options fournies dans cette commande, vous pouvez utiliser un fichier YAML. Cette valeur est facultative.

<p><strong>Remarque :</strong> si vous indiquez la même option dans la commande comme paramètre dans le fichier YAML, la valeur de l'option de la commande est prioritaire sur la valeur définie dans le fichier YAML. Par exemple, si vous définissez un type de machine dans votre fichier YAML et que vous utilisez l'option --machine-type dans la commande, la valeur que vous avez entrée dans l'option de commande se substitue à la valeur définie dans le fichier YAML.

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
<caption>Description des composants du fichier YAML</caption>
<thead>
<th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
</thead>
<tbody>
<tr>
<td><code><em>name</em></code></td>
<td>Remplacez <code><em>&lt;cluster_name_or_ID&gt;</em></code> par le nom ou l'ID du cluster sur lequel vous souhaitez ajouter des noeuds worker.</td>
</tr>
<tr>
<td><code><em>zone</em></code></td>
<td>Remplacez <code><em>&lt;zone&gt;</em></code> par la zone dans laquelle déployer vos noeuds worker. Les zones disponibles dépendent de la région à laquelle vous êtes connecté. Pour afficher les zones disponibles, exécutez la commande <code>ibmcloud ks zones</code>.</td>
</tr>
<tr>
<td><code><em>machine-type</em></code></td>
<td>Remplacez <code><em>&lt;machine_type&gt;</em></code> par le type de machine sur lequel vous envisagez de déployer vos noeuds worker. Vous pouvez déployer vos noeuds worker en tant que machines virtuelles sur du matériel partagé ou dédié ou en tant que machines physiques sur un serveur bare metal. Les types de machines virtuelles et physiques disponibles varient en fonction de la zone de déploiement du cluster. Pour plus d'informations, voir la [commande](cs_cli_reference.html#cs_machine_types) `ibmcloud ks machine-types`.</td>
</tr>
<tr>
<td><code><em>private-vlan</em></code></td>
<td>Remplacez <code><em>&lt;private_VLAN&gt;</em></code> par l'ID du réseau local virtuel privé que vous souhaitez utiliser pour vos noeuds worker. Pour afficher la liste des réseaux locaux virtuels disponibles, exécutez la commande <code>ibmcloud ks vlans <em>&lt;zone&gt;</em></code> et recherchez les routeurs VLAN commençant par <code>bcr</code> (routeur de back-end).</td>
</tr>
<tr>
<td><code>public-vlan</code></td>
<td>Remplacez <code>&lt;public_VLAN&gt;</code> par l'ID du réseau local virtuel public que vous souhaitez utiliser pour vos noeuds worker. Pour afficher la liste des réseaux locaux virtuels disponibles, exécutez la commande <code>ibmcloud ks vlans &lt;zone&gt;</code> et recherchez les routeurs VLAN commençant par <code>fcr</code> (routeur de front-end). <br><strong>Remarque</strong> : si les noeuds worker sont configurés uniquement avec un VLAN privé, vous devez configurer une autre solution pour la connectivité du réseau. Pour plus d'informations, voir [Planification des réseaux de cluster privés uniquement](cs_network_cluster.html#private_vlan).</td>
</tr>
<tr>
<td><code>hardware</code></td>
<td>Pour les types de machine virtuelle : niveau d'isolement de votre noeud worker. Utilisez un cluster dédié si vous désirez que toutes les ressources physiques vous soient dédiées exclusivement ou un cluster partagé pour permettre leur partage avec d'autres clients IBM. La valeur par défaut est shared.</td>
</tr>
<tr>
<td><code>workerNum</code></td>
<td>Remplacez <code><em>&lt;number_workers&gt;</em></code> par le nombre de noeuds worker que vous souhaitez déployer.</td>
</tr>
<tr>
<td><code>diskEncryption: <em>false</em></code></td>
<td>Les noeuds worker disposent par défaut du chiffrement de disque. [En savoir plus](cs_secure.html#encrypted_disk). Pour désactiver le chiffrement, incluez cette option en lui attribuant la valeur <code>false</code>.</td></tr>
</tbody></table></p></dd>

<dt><code>--hardware <em>HARDWARE</em></code></dt>
<dd>Niveau d'isolation du matériel pour votre noeud worker. Utilisez un cluster dédié si vous désirez que toutes les ressources physiques vous soient dédiées exclusivement ou un cluster partagé pour permettre leur partage avec d'autres clients IBM. La valeur par défaut est shared. Cette valeur est facultative.</dd>

<dt><code>--machine-type <em>MACHINE_TYPE</em></code></dt>
<dd>Choisissez un type de machine. Vous pouvez déployer vos noeuds worker en tant que machines virtuelles sur du matériel partagé ou dédié ou en tant que machines physiques sur un serveur bare metal. Les types de machines virtuelles et physiques disponibles varient en fonction de la zone de déploiement du cluster. Pour plus d'informations, voir la documentation correspondant à la [commande](cs_cli_reference.html#cs_machine_types) `ibmcloud ks machine-types`. Cette valeur est obligatoire pour les clusters standard et n'est pas disponible pour les clusters gratuits.</dd>

<dt><code>--workers <em>NUMBER</em></code></dt>
<dd>Entier représentant le nombre de noeuds worker à créer dans le cluster. La valeur par défaut est 1. Cette valeur est facultative.</dd>

<dt><code>--private-vlan <em>PRIVATE_VLAN</em></code></dt>
<dd>VLAN privé spécifié lors de la création du cluster. Cette valeur est obligatoire.

<p><strong>Remarque</strong> : les routeurs de VLAN privé commencent toujours par <code>bcr</code> (routeur de back-end) et les routeurs de VLAN public par <code>fcr</code> (routeur de front-end). Lors de la création d'un cluster et de la spécification des VLAN publics et privés, le nombre et la combinaison de lettres après ces préfixes doivent correspondre.</p></dd>

<dt><code>--public-vlan <em>PUBLIC_VLAN</em></code></dt>
<dd>VLAN public spécifié lors de la création du cluster. Cette valeur est facultative. Si vous désirez que vos noeuds worker ne soient présents que sur un réseau virtuel local privé, n'indiquez pas d'ID de réseau virtuel local public. <strong>Remarque</strong> : si les noeuds worker sont configurés uniquement avec un VLAN privé, vous devez configurer une autre solution pour la connectivité du réseau. Pour plus d'informations, voir [Planification des réseaux de cluster privés uniquement](cs_network_cluster.html#private_vlan).

<p><strong>Remarque</strong> : les routeurs de VLAN privé commencent toujours par <code>bcr</code> (routeur de back-end) et les routeurs de VLAN public par <code>fcr</code> (routeur de front-end). Lors de la création d'un cluster et de la spécification des VLAN publics et privés, le nombre et la combinaison de lettres après ces préfixes doivent correspondre.</p></dd>

<dt><code>--disable-disk-encrypt</code></dt>
<dd>Les noeuds worker disposent par défaut du chiffrement de disque. [En savoir plus](cs_secure.html#encrypted_disk). Pour désactiver le chiffrement, incluez cette option.</dd>

<dt><code>-s</code></dt>
<dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>

</dl>

**Exemples** :

  ```
  ibmcloud ks worker-add --cluster my_cluster --workers 3 --public-vlan my_public_VLAN_ID --private-vlan my_private_VLAN_ID --machine-type b2c.4x16 --hardware shared
  ```
  {: pre}

  Exemple pour {{site.data.keyword.Bluemix_dedicated_notm}} :

  ```
  ibmcloud ks worker-add --cluster my_cluster --workers 3 --machine-type b2c.4x16
  ```
  {: pre}

### ibmcloud ks worker-get --cluster [CLUSTER_NAME_OR_ID] --worker WORKER_NODE_ID [--json][-s]
{: #cs_worker_get}

Affichez les détails d'un noeud worker.

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Afficheur** pour {{site.data.keyword.containerlong_notm}}

<strong>Options de commande</strong> :

   <dl>
   <dt><code>--cluster <em>CLUSTER_NAME_OR_ID</em></code></dt>
   <dd>Nom ou ID du cluster du noeud worker. Cette valeur est facultative.</dd>

   <dt><code>--worker <em>WORKER_NODE_ID</em></code></dt>
   <dd>Nom de votre noeud worker. Exécutez la commande <code>ibmcloud ks workers <em>CLUSTER</em></code> pour afficher les ID des noeuds worker dans un cluster. Cette valeur est obligatoire.</dd>

   <dt><code>--json</code></dt>
   <dd>Imprime le résultat de la commande au format JSON. Cette valeur est facultative.</dd>

   <dt><code>-s</code></dt>
   <dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>
   </dl>

**Exemple de commande** :

  ```
  ibmcloud ks worker-get --cluster my_cluster --worker kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w1
  ```
  {: pre}

**Exemple de sortie** :

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

Réamorcez un noeud worker dans un cluster. Lors du réamorçage, l'état de votre noeud worker reste inchangé. Par exemple, vous pouvez recourir à un réamorçage si le statut du noeud worker dans l'infrastructure IBM Cloud (SoftLayer) est `Powered Off` et qu'il vous faut mettre le noeud worker sous tension.

**Attention :** le réamorçage d'un noeud worker peut entraîner l'altération des données sur le noeud worker. Utilisez cette commande avec précaution et lorsque vous savez qu'un réamorçage pourra vous aider à restaurer le noeud worker. Dans tous les autres cas de figure,  [rechargez votre noeud worker](#cs_worker_reload) à la place.

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Opérateur** pour {{site.data.keyword.containerlong_notm}}

Avant de réamorcer votre noeud worker, assurez-vous que les pods sont replanifiés sur d'autres noeuds worker afin d'éviter toute indisponibilité de votre application ou l'altération des données sur votre noeud worker.

1. Répertoriez tous les noeuds worker présents dans votre cluster et notez le **nom** de celui que vous envisagez de réamorcer.
   ```
   kubectl get nodes
   ```
   {: pre}
   Le **nom** renvoyé dans cette commande correspond à l'adresse IP privée affectée à votre noeud worker. Vous pouvez obtenir plus d'informations sur votre noeud worker lorsque vous exécutez la commande `ibmcloud ks workers <cluster_name_or_ID>` et que vous recherchez le noeud worker avec la même adresse **IP privée**.
2. Marquez le noeud worker comme non planifiable dans un processus désigné par cordon. Lorsque vous exécutez ce processus sur un noeud worker, vous le rendez indisponible pour toute planification de pod ultérieure. Utilisez le **nom** du noeud worker que vous avez récupéré à l'étape précédente.
   ```
   kubectl cordon <worker_name>
   ```
   {: pre}

3. Vérifiez que la planification de pod est désactivée pour votre noeud worker.
   ```
   kubectl get nodes
   ```
   {: pre}
   Votre noeud worker ne sera pas activé pour la planification de pod si le statut affiché est **SchedulingDisabled**.
 4. Imposez le retrait des pods de votre noeud worker et leur replanification sur les noeuds worker restants dans le cluster.
    ```
    kubectl drain <worker_name>
    ```
    {: pre}
    Ce processus peut prendre quelques minutes.
 5. Réamorcez le noeud worker. Utilisez l'ID du noeud worker renvoyé dans la commande `ibmcloud ks workers <cluster_name_or_ID>`.
    ```
    ibmcloud ks worker-reboot --cluster <cluster_name_or_ID> --workers <worker_name_or_ID>
    ```
    {: pre}
 6. Patientez environ 5 minutes avant de rendre votre noeud worker disponible pour la planification de pod pour vous assurer que le réamorçage est terminé. Lors du réamorçage, l'état de votre noeud worker reste inchangé. Le réamorçage d'un noeud worker s'effectue en principe en quelques secondes.
 7. Rendez votre noeud worker disponible pour la planification de pod. Utilisez le **nom** de noeud worker renvoyé par la commande `kubectl get nodes`.
    ```
    kubectl uncordon <worker_name>
    ```
    {: pre}

    </br>

<strong>Options de commande</strong> :

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>

   <dt><code>-f</code></dt>
   <dd>Utilisez cette option pour forcer le redémarrage du noeud worker sans invites utilisateur. Cette valeur est facultative.</dd>

   <dt><code>--hard</code></dt>
   <dd>Utilisez cette option pour forcer un redémarrage à froid d'un noeud worker en coupant son alimentation. Utilisez cette option si le noeud worker ou l'environnement d'exécution de conteneur du noeud worker ne répond plus. Cette valeur est facultative.</dd>

   <dt><code>--workers <em>WORKER</em></code></dt>
   <dd>Nom ou ID d'un ou de plusieurs noeuds worker. Utilisez un espace pour répertorier plusieurs noeuds worker. Cette valeur est obligatoire.</dd>

   <dt><code>--skip-master-healthcheck</code></dt>
   <dd>Ignorer le diagnostic d'intégrité de votre maître avant de recharger et de réamorcer vos noeuds worker.</dd>

   <dt><code>-s</code></dt>
   <dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>
   </dl>

**Exemple** :

  ```
  ibmcloud ks worker-reboot --cluster my_cluster --worker kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w1 kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w2
  ```
  {: pre}


### ibmcloud ks worker-reload [-f] --cluster CLUSTER --worker WORKER [WORKER][--skip-master-healthcheck] [-s]
{: #cs_worker_reload}

Rechargez toutes les configurations nécessaires relatives à un noeud worker. Un rechargement peut s'avérer utile en cas de problème sur votre noeud worker, par exemple une dégradation des performances ou une immobilisation dans un mauvais état de santé.

Le rechargement d'un noeud worker applique des mises à jour de version de correctif à votre noeud worker mais pas de mise à jour principale ou secondaire. Pour voir les modifications d'une version de correctif à une autre, consultez la documentation [Journal des modifications de version](cs_versions_changelog.html#changelog).
{: tip}

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Opérateur** pour {{site.data.keyword.containerlong_notm}}

Avant de recharger le noeud worker, assurez-vous que les pods sont replanifiés sur d'autres noeuds worker afin d'éviter toute indisponibilité de votre application ou l'altération des données sur votre noeud worker.

1. Répertoriez tous les noeuds worker dans votre cluster et notez le **nom** de celui que vous envisagez de recharger.
   ```
   kubectl get nodes
   ```
   Le **nom** renvoyé dans cette commande correspond à l'adresse IP privée affectée à votre noeud worker. Vous pouvez obtenir plus d'informations sur votre noeud worker lorsque vous exécutez la commande `ibmcloud ks workers <cluster_name_or_ID>` et que vous recherchez le noeud worker avec la même adresse **IP privée**.
2. Marquez le noeud worker comme non planifiable dans un processus désigné par cordon. Lorsque vous exécutez ce processus sur un noeud worker, vous le rendez indisponible pour toute planification de pod ultérieure. Utilisez le **nom** du noeud worker que vous avez récupéré à l'étape précédente.
   ```
   kubectl cordon <worker_name>
   ```
   {: pre}

3. Vérifiez que la planification de pod est désactivée pour votre noeud worker.
   ```
   kubectl get nodes
   ```
   {: pre}
   Votre noeud worker ne sera pas activé pour la planification de pod si le statut affiché est **SchedulingDisabled**.
 4. Imposez le retrait des pods de votre noeud worker et leur replanification sur les noeuds worker restants dans le cluster.
    ```
    kubectl drain <worker_name>
    ```
    {: pre}
    Ce processus peut prendre quelques minutes.
 5. Rechargez le noeud worker. Utilisez l'ID du noeud worker renvoyé dans la commande `ibmcloud ks workers <cluster_name_or_ID>`.
    ```
    ibmcloud ks worker-reload --cluster <cluster_name_or_ID> --worker <worker_name_or_ID>
    ```
    {: pre}
 6. Patientez jusqu'à la fin du rechargement.
 7. Rendez votre noeud worker disponible pour la planification de pod. Utilisez le **nom** de noeud worker renvoyé par la commande `kubectl get nodes`.
    ```
    kubectl uncordon <worker_name>
    ```
</br>
<strong>Options de commande</strong> :

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>

   <dt><code>-f</code></dt>
   <dd>Utilisez cette option pour forcer le rechargement d'un noeud worker sans invites utilisateur. Cette valeur est facultative.</dd>

   <dt><code>--worker <em>WORKER</em></code></dt>
   <dd>Nom ou ID d'un ou de plusieurs noeuds worker. Utilisez un espace pour répertorier plusieurs noeuds worker. Cette valeur est obligatoire.</dd>

   <dt><code>--skip-master-healthcheck</code></dt>
   <dd>Ignorer le diagnostic d'intégrité de votre maître avant de recharger et de réamorcer vos noeuds worker.</dd>

   <dt><code>-s</code></dt>
   <dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>
   </dl>

**Exemple** :

  ```
  ibmcloud ks worker-reload --cluster my_cluster --worker kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w1 kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w2
  ```
  {: pre}


### ibmcloud ks worker-rm [-f] --cluster CLUSTER --workers WORKER[,WORKER][-s]
{: #cs_worker_rm}

Supprimez un ou plusieurs noeuds worker d'un cluster. Si vous supprimez un noeud worker, votre cluster n'est plus équilibré. Vous pouvez rééquilibrer automatiquement votre pool de noeuds worker en exécutant la [commande](#cs_rebalance) `ibmcloud ks worker-pool-rebalance`.

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Opérateur** pour {{site.data.keyword.containerlong_notm}}

Avant de supprimer le noeud worker, assurez-vous que les pods sont replanifiés sur d'autres noeuds worker afin d'éviter toute indisponibilité de votre application ou l'altération des données sur votre noeud worker.
{: tip}

1. Répertoriez tous les noeuds worker dans votre cluster et notez le **nom** de celui que vous envisagez de supprimer.
   ```
   kubectl get nodes
   ```
   Le **nom** renvoyé dans cette commande correspond à l'adresse IP privée affectée à votre noeud worker. Vous pouvez obtenir plus d'informations sur votre noeud worker lorsque vous exécutez la commande `ibmcloud ks workers <cluster_name_or_ID>` et que vous recherchez le noeud worker avec la même adresse **IP privée**.
2. Marquez le noeud worker comme non planifiable dans un processus désigné par cordon. Lorsque vous exécutez ce processus sur un noeud worker, vous le rendez indisponible pour toute planification de pod ultérieure. Utilisez le **nom** du noeud worker que vous avez récupéré à l'étape précédente.
   ```
   kubectl cordon <worker_name>
   ```
   {: pre}

3. Vérifiez que la planification de pod est désactivée pour votre noeud worker.
   ```
   kubectl get nodes
   ```
   {: pre}
   Votre noeud worker ne sera pas activé pour la planification de pod si le statut affiché est **SchedulingDisabled**.
4. Imposez le retrait des pods de votre noeud worker et leur replanification sur les noeuds worker restants dans le cluster.
   ```
   kubectl drain <worker_name>
   ```
   {: pre}
   Ce processus peut prendre quelques minutes.
5. Supprimez le noeud worker. Utilisez l'ID du noeud worker renvoyé dans la commande `ibmcloud ks workers <cluster_name_or_ID>`.
   ```
   ibmcloud ks worker-rm --cluster <cluster_name_or_ID> --worker <worker_name_or_ID>
   ```
   {: pre}

6. Vérifiez que le noeud worker est supprimé.
   ```
   ibmcloud ks workers --cluster <cluster_name_or_ID>
   ```
</br>
<strong>Options de commande</strong> :

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>

   <dt><code>-f</code></dt>
   <dd>Utilisez cette option pour forcer la suppression d'un noeud worker sans invites utilisateur. Cette valeur est facultative.</dd>

   <dt><code>--workers <em>WORKER</em></code></dt>
   <dd>Nom ou ID d'un ou de plusieurs noeuds worker. Utilisez un espace pour répertorier plusieurs noeuds worker. Cette valeur est obligatoire.</dd>

   <dt><code>-s</code></dt>
   <dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>
   </dl>

**Exemple** :

  ```
  ibmcloud ks worker-rm --cluster my_cluster --workers kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w1 kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w2
  ```
  {: pre}


### ibmcloud ks worker-update [-f] --cluster CLUSTER --workers WORKER[,WORKER][--kube-version MAJOR.MINOR.PATCH] [--force-update][-s]
{: #cs_worker_update}

Mettez à jour les noeuds worker pour appliquer les correctifs et mises à jour de sécurité les plus récents sur le système d'exploitation et mettre à jour la version du maître Kubernetes. Vous pouvez mettre à jour cette version avec la [commande](cs_cli_reference.html#cs_cluster_update) `ibmcloud ks cluster-update`.

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Opérateur** pour {{site.data.keyword.containerlong_notm}}

**Important** : l'exécution de la commande `ibmcloud ks worker-update` peut entraîner l'indisponibilité de vos services et applications. Lors de la mise à jour, tous les pods sont replanifiés sur d'autres noeuds worker et les données sont supprimées si elles ne sont pas stockées hors du pod. Pour éviter des temps d'indisponibilité, [vérifiez que vous disposez de suffisamment de noeuds worker pour traiter votre charge de travail alors que les noeuds worker sélectionnés sont en cours de mise à jour](cs_cluster_update.html#worker_node).

Vous pourriez devoir modifier vos fichiers YAML en vue des déploiements avant la mise à jour. Consultez cette [note sur l'édition](cs_versions.html) pour plus de détails.

<strong>Options de commande</strong> :

   <dl>

   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Nom ou ID du cluster sur lequel répertorier les noeuds worker disponibles. Cette valeur est obligatoire.</dd>

   <dt><code>-f</code></dt>
   <dd>Utilisez cette option pour forcer la mise à jour du maître sans invites utilisateur. Cette valeur est facultative.</dd>

   <dt><code>--force-update</code></dt>
   <dd>Cette option tente d'effectuer la mise à jour même si la modification est supérieure à deux niveaux de version secondaire. Cette valeur est facultative.</dd>

   <dt><code>--kube-version <em>MAJOR.MINOR.PATCH</em></code></dt>
     <dd>Version de Kubernetes avec laquelle vous souhaitez mettre à jour vos noeuds worker. La version par défaut est utilisée si cette valeur n'est pas spécifiée.</dd>

   <dt><code>--workers <em>WORKER</em></code></dt>
   <dd>ID d'un ou de plusieurs noeuds worker. Utilisez un espace pour répertorier plusieurs noeuds worker. Cette valeur est obligatoire.</dd>

   <dt><code>-s</code></dt>
   <dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>

   </dl>

**Exemple** :

  ```
  ibmcloud ks worker-update --cluster my_cluster --worker kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w1 kube-dal10-cr18a61a63a6a94b658596aa93d087aaa9-w2
  ```
  {: pre}

### ibmcloud ks workers --cluster CLUSTER [--worker-pool POOL][--show-pools] [--show-deleted][--json] [-s]
{: #cs_workers}

Affiche la liste des noeuds worker dans un cluster et la statut de chacun d'eux.

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Afficheur** pour {{site.data.keyword.containerlong_notm}}

<strong>Options de commande</strong> :

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Nom ou ID du cluster pour les noeuds worker disponibles. Cette valeur est obligatoire.</dd>

   <dt><code>--worker-pool <em>POOL</em></code></dt>
   <dd>Affiche uniquement les noeuds worker appartenant au pool de noeuds worker. Pour afficher la liste des pools de noeuds worker disponibles, exécutez la commande `ibmcloud ks worker-pools --cluster <cluster_name_or_ID>`. Cette valeur est facultative.</dd>

   <dt><code>--show-pools</code></dt>
   <dd>Répertorie les pools de noeuds worker auquel appartient chaque noeud worker. Cette valeur est facultative.</dd>

   <dt><code>--show-deleted</code></dt>
   <dd>Affiche les noeuds worker qui ont été supprimés du cluster, y compris la raison de la suppression. Cette valeur est facultative.</dd>

   <dt><code>--json</code></dt>
   <dd>Imprime le résultat de la commande au format JSON. Cette valeur est facultative.</dd>

  <dt><code>-s</code></dt>
  <dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>
   </dl>

**Exemple** :

  ```
  ibmcloud ks workers --cluster my_cluster
  ```
  {: pre}

<br />


## Commandes de pool de noeuds worker
{: #worker-pool}

### ibmcloud ks worker-pool-create --name POOL_NAME --cluster CLUSTER --machine-type MACHINE_TYPE --size-per-zone WORKERS_PER_ZONE --hardware ISOLATION [--labels LABELS][--disable-disk-encrypt] [-s][--json]
{: #cs_worker_pool_create}

Vous pouvez créer un pool de noeuds worker dans votre cluster. Par défaut, lorsque vous ajoutez un pool de noeuds worker, il n'est affecté à aucune zone. Vous spécifiez le nombre de noeuds worker dont vous souhaitez disposer dans chaque zone, ainsi que les types de machine de ces noeuds. Le pool de noeuds worker est fourni avec les versions Kubernetes par défaut. Pour finaliser la création de noeuds worker, [ajoutez une ou plusieurs zones](#cs_zone_add) dans votre pool.

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Opérateur** pour {{site.data.keyword.containerlong_notm}}

<strong>Options de commande</strong> :
<dl>

  <dt><code>--name <em>POOL_NAME</em></code></dt>
    <dd>Nom que vous souhaitez attribuer à votre pool de noeuds worker.</dd>

  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>

  <dt><code>--machine-type <em>MACHINE_TYPE</em></code></dt>
    <dd>Choisissez un type de machine. Vous pouvez déployer vos noeuds worker en tant que machines virtuelles sur du matériel partagé ou dédié ou en tant que machines physiques sur un serveur bare metal. Les types de machines virtuelles et physiques disponibles varient en fonction de la zone de déploiement du cluster. Pour plus d'informations, voir la documentation correspondant à la [commande](cs_cli_reference.html#cs_machine_types) `ibmcloud ks machine-types`. Cette valeur est obligatoire pour les clusters standard et n'est pas disponible pour les clusters gratuits.</dd>

  <dt><code>--size-per-zone <em>WORKERS_PER_ZONE</em></code></dt>
    <dd>Nombre de noeuds worker à créer dans chaque zone. Cette valeur est obligatoire et doit être supérieure ou égale à 1.</dd>

  <dt><code>--hardware <em>ISOLATION</em></code></dt>
    <dd>Niveau d'isolation du matériel pour votre noeud worker. Utilisez `dedicated` si vous désirez que toutes les ressources physiques vous soient dédiées exclusivement ou `shared` pour permettre leur partage avec d'autres clients IBM. La valeur par défaut est `shared`. Pour les types de machine bare metal, indiquez `dedicated`. Cette valeur est obligatoire.</dd>

  <dt><code>--labels <em>LABELS</em></code></dt>
    <dd>Libellés que vous voulez affecter aux noeuds worker dans votre pool. Exemple : <key1>=<val1>,<key2>=<val2></dd>

  <dt><code>--disable-disk-encrpyt</code></dt>
    <dd>Indique si le disque n'est pas chiffré. La valeur par défaut est <code>false</code>.</dd>

  <dt><code>--json</code></dt>
    <dd>Imprime le résultat de la commande au format JSON. Cette valeur est facultative.</dd>

  <dt><code>-s</code></dt>
    <dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>
</dl>

**Exemple de commande** :

  ```
  ibmcloud ks worker-pool-create --name my_pool --cluster my_cluster --machine-type b2c.4x16 --size-per-zone 6
  ```
  {: pre}

### ibmcloud ks worker-pool-get --worker-pool WORKER_POOL --cluster CLUSTER [-s][--json]
{: #cs_worker_pool_get}

Affichez les détails d'un pool de noeuds worker.

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Afficheur** pour {{site.data.keyword.containerlong_notm}}

<strong>Options de commande</strong> :

<dl>
  <dt><code>--worker-pool <em>WORKER_POOL</em></code></dt>
    <dd>Nom du pool de noeuds worker dont vous voulez afficher les détails. Pour afficher la liste des pools de noeuds worker disponibles, exécutez la commande `ibmcloud ks worker-pools --cluster <cluster_name_or_ID>`. Cette valeur est obligatoire.</dd>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>Nom ou ID du cluster dans lequel se trouve le pool de noeuds worker. Cette valeur est obligatoire.</dd>

  <dt><code>--json</code></dt>
    <dd>Imprime le résultat de la commande au format JSON. Cette valeur est facultative.</dd>

  <dt><code>-s</code></dt>
    <dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>
</dl>

**Exemple de commande** :

  ```
  ibmcloud ks worker-pool-get --worker-pool pool1 --cluster my_cluster
  ```
  {: pre}

**Exemple de sortie** :

  ```
  Name:               pool   
  ID:                 a1a11b2222222bb3c33c3d4d44d555e5-f6f777g   
  State:              active   
  Hardware:           shared   
  Zones:              dal10,dal12   
  Workers per zone:   3   
  Machine type:       b2c.4x16.encrypted   
  Labels:             -   
  Version:            1.10.8_1512
  ```
  {: screen}

### ibmcloud ks worker-pool-rebalance --cluster CLUSTER --worker-pool WORKER_POOL [-s]
{: #cs_rebalance}

Vous pouvez rééquilibrer votre pool de noeuds worker après la suppression d'un noeud worker. Lorsque vous exécutez cette commande, un ou plusieurs nouveaux noeuds worker sont ajoutés dans votre pool.

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Opérateur** pour {{site.data.keyword.containerlong_notm}}

<strong>Options de commande</strong> :

<dl>
  <dt><code><em>--cluster CLUSTER</em></code></dt>
    <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>
  <dt><code><em>--worker-pool WORKER_POOL</em></code></dt>
    <dd>Pool de noeuds worker que vous souhaitez rééquilibrer. Cette valeur est obligatoire.</dd>
  <dt><code>-s</code></dt>
    <dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>
</dl>

**Exemple** :

  ```
  ibmcloud ks worker-pool-rebalance --cluster my_cluster --worker-pool my_pool
  ```
  {: pre}

### ibmcloud ks worker-pool-resize --worker-pool WORKER_POOL --cluster CLUSTER --size-per-zone WORKERS_PER_ZONE [-s]
{: #cs_worker_pool_resize}

Redimensionnez votre pool de noeuds worker pour augmenter ou réduire le nombre de noeuds worker figurant dans chaque zone de votre cluster. Votre pool de noeuds worker doit comporter au moins 1 noeud worker.

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Opérateur** pour {{site.data.keyword.containerlong_notm}}

<strong>Options de commande</strong> :

<dl>
  <dt><code>--worker-pool <em>WORKER_POOL</em></code></dt>
    <dd>Nom du pool de noeuds worker que vous voulez mettre à jour. Cette valeur est obligatoire.</dd>

  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>Nom ou ID du cluster dont vous voulez redimensionner les pools de noeuds worker. Cette valeur est obligatoire.</dd>

  <dt><code>--size-per-zone <em>WORKERS_PER_ZONE</em></code></dt>
    <dd>Nombre de noeuds worker dont vous souhaitez disposer dans chaque zone. Cette valeur est obligatoire et doit être supérieure ou égale à 1.</dd>

  <dt><code>-s</code></dt>
    <dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>

</dl>

**Exemple de commande** :

  ```
  ibmcloud ks worker-pool-resize --cluster my_cluster --worker-pool my_pool --size-per-zone 3
  ```
  {: pre}

### ibmcloud ks worker-pool-rm --worker-pool WORKER_POOL --cluster CLUSTER [-s]
{: #cs_worker_pool_rm}

Retirez un pool de noeuds worker de votre cluster. Tous les noeuds worker du pool sont supprimés. Vos pods sont replanifiés lors de la suppression. Pour éviter des interruptions, veillez à disposer d'un nombre suffisant de noeuds worker pour exécuter votre charge de travail.

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Opérateur** pour {{site.data.keyword.containerlong_notm}}

<strong>Options de commande</strong> :

<dl>
  <dt><code>--worker-pool <em>WORKER_POOL</em></code></dt>
    <dd>Nom du pool de noeuds worker que vous voulez retirer. Cette valeur est obligatoire.</dd>
  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>Nom ou ID du cluster duquel vous souhaitez retirer le pool de noeuds worker. Cette valeur est obligatoire.</dd>
  <dt><code>-s</code></dt>
    <dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>
</dl>

**Exemple de commande** :

  ```
  ibmcloud ks worker-pool-rm --cluster my_cluster --worker-pool pool1
  ```
  {: pre}

### ibmcloud ks worker-pools --cluster CLUSTER [--json][-s]
{: #cs_worker_pools}

Affichez les pools de noeuds worker dont vous disposez dans un cluster.

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Afficheur** pour {{site.data.keyword.containerlong_notm}}

<strong>Options de commande</strong> :

<dl>
  <dt><code>--cluster <em>CLUSTER_NAME_OR_ID</em></code></dt>
    <dd>Nom ou ID du cluster pour lequel vous souhaitez afficher la liste des pools de noeuds worker. Cette valeur est obligatoire.</dd>
  <dt><code>--json</code></dt>
    <dd>Imprime le résultat de la commande au format JSON. Cette valeur est facultative.</dd>
  <dt><code>-s</code></dt>
    <dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>
</dl>

**Exemple de commande** :

  ```
  ibmcloud ks worker-pools --cluster my_cluster
  ```
  {: pre}

### ibmcloud ks zone-add --zone ZONE --cluster CLUSTER --worker-pools WORKER_POOL1[,WORKER_POOL2] --private-vlan PRIVATE_VLAN [--public-vlan PUBLIC_VLAN][--private-only] [--json][-s]
{: #cs_zone_add}

**Clusters à zones multiples uniquement** : après avoir créé un cluster ou un pool de noeuds worker, vous pouvez ajouter une zone. Lorsque vous ajoutez une zone, des noeuds worker sont ajoutés dans la nouvelle zone pour correspondre au nombre de noeuds worker par zone que vous avez indiqué pour le pool de noeuds worker.

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Opérateur** pour {{site.data.keyword.containerlong_notm}}

<strong>Options de commande</strong> :

<dl>
  <dt><code>--zone <em>ZONE</em></code></dt>
    <dd>Zone que vous désirez ajouter. Il doit s'agir d'une [zone compatible avec plusieurs zones](cs_regions.html#zones) présente dans la région du cluster. Cette valeur est obligatoire.</dd>

  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>

  <dt><code>--worker-pool <em>WORKER_POOLS</em></code></dt>
    <dd>Liste séparée par une virgule de pools de noeuds worker auxquels est ajoutée la zone. Il doit y avoir au moins 1 pool de noeuds worker.</dd>

  <dt><code>--private-vlan <em>PRIVATE_VLAN</em></code></dt>
    <dd><p>ID du VLAN privé. Cette valeur est conditionnelle.</p>
    <p>Si vous disposez d'un VLAN privé dans cette zone, cette valeur doit correspondre à l'ID du VLAN privé d'un ou plusieurs noeuds worker dans le cluster. Pour voir les VLAN à votre disposition, exécutez la commande <code>ibmcloud ks cluster-get --cluster &lt;cluster&gt; --showResources</code>.</p>
    <p>Si vous ne disposez pas de VLAN public ou privé dans cette zone, n'indiquez pas cette option. Un VLAN privé et un VLAN public sont automatiquement créés pour vous la première fois que vous ajoutez une nouvelle zone dans votre pool de noeuds worker.</p>
    <p>Si vous disposez de plusieurs VLAN pour un cluster, de plusieurs sous-réseaux sur le même VLAN ou d'un cluster à zones multiples, vous devez activer la fonction [Spanning VLAN](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) pour votre compte d'infrastructure IBM Cloud (SoftLayer) afin que vos noeuds worker puissent communiquer entre eux sur le réseau privé. Pour effectuer cette action, vous devez disposer des [droits Infrastructure](cs_users.html#infra_access) **Réseau > Gérer spanning VLAN pour réseau** ou vous pouvez demander au propriétaire du compte de l'activer. Pour vérifier si la fonction Spanning VLAN est déjà activée, utilisez la [commande](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`. Avec {{site.data.keyword.BluDirectLink}}, vous devez utiliser à la place une [fonction VRF (Virtual Router Function)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf). Pour activer la fonction VRF, contactez le représentant de votre compte d'infrastructure IBM Cloud (SoftLayer).</p>
<p>**Remarque** : les nouveaux noeuds worker sont ajoutés aux VLAN que vous spécifiez, mais les VLAN pour les noeuds worker existants restent inchangés.</p></dd>

  <dt><code>--public-vlan <em>PUBLIC_VLAN</em></code></dt>
    <dd><p>ID du VLAN public. Cette valeur est obligatoire si vous souhaitez exposer au public des charges de travail sur les noeuds après avoir créé le cluster. Elle doit correspondre à l'ID du VLAN public d'un ou plusieurs noeuds worker dans le cluster pour la zone. Pour voir les VLAN à votre disposition, exécutez la commande <code>ibmcloud ks cluster-get --cluster &lt;cluster&gt; --showResources</code>.</p>
    <p>Si vous ne disposez pas de VLAN public ou privé dans cette zone, n'indiquez pas cette option. Un VLAN privé et un VLAN public sont automatiquement créés pour vous la première fois que vous ajoutez une nouvelle zone dans votre pool de noeuds worker.</p>
    <p>Si vous disposez de plusieurs VLAN pour un cluster, de plusieurs sous-réseaux sur le même VLAN ou d'un cluster à zones multiples, vous devez activer la fonction [Spanning VLAN](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) pour votre compte d'infrastructure IBM Cloud (SoftLayer) afin que vos noeuds worker puissent communiquer entre eux sur le réseau privé. Pour effectuer cette action, vous devez disposer des [droits Infrastructure](cs_users.html#infra_access) **Réseau > Gérer spanning VLAN pour réseau** ou vous pouvez demander au propriétaire du compte de l'activer. Pour vérifier si la fonction Spanning VLAN est déjà activée, utilisez la [commande](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`. Avec {{site.data.keyword.BluDirectLink}}, vous devez utiliser à la place une [fonction VRF (Virtual Router Function)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf). Pour activer la fonction VRF, contactez le représentant de votre compte d'infrastructure IBM Cloud (SoftLayer).</p>
    <p>**Remarque** : les nouveaux noeuds worker sont ajoutés aux VLAN que vous spécifiez, mais les VLAN pour les noeuds worker existants restent inchangés.</p></dd>

  <dt><code>--private-only </code></dt>
    <dd>Utilisez cette option pour empêcher la création d'un VLAN public. Cette valeur est obligatoire uniquement si vous spécifiez l'indicateur `--private-vlan` sans inclure l'indicateur `--public-vlan`.  **Remarque** : si vous souhaitez avoir un cluster privé uniquement, vous devez configurer un dispositif de passerelle pour la connectivité du réseau. Pour plus d'informations, voir [Clusters privés](cs_clusters_planning.html#private_clusters).</dd>

  <dt><code>--json</code></dt>
    <dd>Imprime le résultat de la commande au format JSON. Cette valeur est facultative.</dd>

  <dt><code>-s</code></dt>
    <dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>
</dl>

**Exemple** :

  ```
  ibmcloud ks zone-add --zone dal10 --cluster my_cluster --worker-pools pool1,pool2,pool3 --private-vlan 2294021
  ```
  {: pre}

  ### ibmcloud ks zone-network-set --zone ZONE --cluster CLUSTER --worker-pools WORKER_POOL1[,WORKER_POOL2] --private-vlan PRIVATE_VLAN [--public-vlan PUBLIC_VLAN][-f] [-s]
  {: #cs_zone_network_set}

  **Clusters à zones multiples uniquement** : définissez les métadonnées du réseau d'un pool de noeuds worker pour utiliser un autre VLAN public ou privé pour la zone que celui qu'elle utilisait auparavant. Les noeuds worker déjà créés dans le pool continuent à utiliser le VLAN public ou privé précédent, mais les nouveaux noeuds worker du pool utilisent les données du nouveau réseau.

  <strong>Droits minimum requis</strong> : rôle de plateforme IAM **Opérateur** pour {{site.data.keyword.containerlong_notm}}

  Les routeurs de VLAN privé commencent toujours par <code>bcr</code> (routeur de back-end) et les routeurs de VLAN public par <code>fcr</code> (routeur de front-end). Lors de la création d'un cluster et de la spécification des VLAN publics et privés, le nombre et la combinaison de lettres après ces préfixes doivent correspondre.
  <ol><li>Vérifiez les VLAN disponibles dans votre cluster. <pre class="pre"><code>ibmcloud ks cluster-get --cluster &lt;cluster_name_or_ID&gt; --showResources</code></pre><p>Exemple de sortie :</p>
  <pre class="screen"><code>Subnet VLANs
VLAN ID   Subnet CIDR         Public   User-managed
229xxxx   169.xx.xxx.xxx/29   true     false
229xxxx   10.xxx.xx.x/29      false    false</code></pre></li>
  <li>Vérifiez si les ID de VLAN public et privé que vous souhaitez utiliser sont compatibles. Pour qu'ils soient compatibles, le routeur (<strong>Router</strong>) doit avoir le même ID de pod.<pre class="pre"><code>ibmcloud ks vlans --zone &lt;zone&gt;</code></pre><p>Exemple de sortie :</p>
  <pre class="screen"><code>ID        Name   Number   Type      Router         Supports Virtual Workers
229xxxx          1234     private   bcr01a.dal12   true
229xxxx          5678     public    fcr01a.dal12   true</code></pre><p>Notez que les ID de pod de la section <strong>Router</strong> correspondent à : `01a` et `01a`. Si un ID de pod était `01a` et que l'autre était `02a`, vous ne pourriez pas définir ces ID de VLAN public et privé pour votre pool de noeuds worker.</p></li>
  <li>Si vous n'avez aucun VLAN disponible, vous pouvez <a href="/docs/infrastructure/vlans/order-vlan.html#order-vlans">commander de nouveaux VLAN</a>.</li></ol>

  <strong>Options de commande</strong> :

  <dl>
    <dt><code>--zone <em>ZONE</em></code></dt>
      <dd>Zone que vous désirez ajouter. Il doit s'agir d'une [zone compatible avec plusieurs zones](cs_regions.html#zones) présente dans la région du cluster. Cette valeur est obligatoire.</dd>

  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>

  <dt><code>--worker-pool <em>WORKER_POOLS</em></code></dt>
    <dd>Liste séparée par une virgule de pools de noeuds worker auxquels est ajoutée la zone. Il doit y avoir au moins 1 pool de noeuds worker.</dd>

  <dt><code>--private-vlan <em>PRIVATE_VLAN</em></code></dt>
    <dd>ID du VLAN privé. Cette valeur est obligatoire, même si vous souhaitez utiliser le même VLAN privé ou un autre VLAN privé que celui que vous avez utilisé pour vos autres noeuds worker. <br><br><strong>Important</strong> : Les VLAN public et privé doivent être compatibles, ce que vous pouvez vérifier à partir du préfixe d'ID du **routeur**.<br><br>**Remarque** : les nouveaux noeuds worker sont ajoutés aux VLAN que vous spécifiez, mais les VLAN pour les noeuds worker existants restent inchangés.</dd>

  <dt><code>--public-vlan <em>PUBLIC_VLAN</em></code></dt>
    <dd>ID du VLAN public. Cette valeur est obligatoire uniquement si vous envisagez de changer de VLAN public pour la zone. Pour changer de VLAN public, vous devez toujours fournir un VLAN privé compatible.<br><br><strong>Important</strong> : Les VLAN public et privé doivent être compatibles, ce que vous pouvez vérifier à partir du préfixe d'ID du **routeur**.<br><br>**Remarque** : les nouveaux noeuds worker sont ajoutés aux VLAN que vous spécifiez, mais les VLAN pour les noeuds worker existants restent inchangés.</dd>

  <dt><code>-f</code></dt>
    <dd>Force la commande à s'exécuter sans invites utilisateur. Cette valeur est facultative.</dd>

  <dt><code>-s</code></dt>
    <dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>
  </dl>

  **Exemple** :

  ```
  ibmcloud ks zone-network-set --zone dal10 --cluster my_cluster --worker-pools pool1,pool2,pool3 --private-vlan 2294021
  ```
  {: pre}

### ibmcloud ks zone-rm --zone ZONE --cluster CLUSTER [-f][-s]
{: #cs_zone_rm}

**Clusters à zones multiples uniquement** : supprimez une zone de tous les pools de noeuds worker dans votre cluster. Tous les noeuds worker du pool correspondant à cette zone sont supprimés.

Avant de supprimer une zone, assurez-vous de disposer d'un nombre de noeuds worker suffisants dans d'autres zones du cluster de sorte que vos pods puissent être replanifiés afin d'éviter toute indisponibilité de votre application ou l'altération des données sur votre noeud worker.
{: tip}

<strong>Droits minimum requis</strong> : rôle de plateforme IAM **Opérateur** pour {{site.data.keyword.containerlong_notm}}

<strong>Options de commande</strong> :

<dl>
  <dt><code>--zone <em>ZONE</em></code></dt>
    <dd>Zone que vous désirez ajouter. Il doit s'agir d'une [zone compatible avec plusieurs zones](cs_regions.html#zones) présente dans la région du cluster. Cette valeur est obligatoire.</dd>

  <dt><code>--cluster <em>CLUSTER</em></code></dt>
    <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>

  <dt><code>-f</code></dt>
    <dd>Forcer la mise à jour sans invites utilisateur. Cette valeur est facultative.</dd>

  <dt><code>-s</code></dt>
    <dd>Ne pas afficher le message du jour ni les rappels de mise à jour. Cette valeur est facultative.</dd>
</dl>

**Exemple** :

  ```
  ibmcloud ks zone-rm --zone dal10 --cluster my_cluster
  ```
  {: pre}
