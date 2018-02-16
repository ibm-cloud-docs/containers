---

copyright:
  years: 2014, 2018
lastupdated: "2017-01-02"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Référence de l'interface de ligne de commande pour la gestion de clusters
{: #cs_cli_reference}

Reportez-vous à ces commandes pour créer et gérer des clusters.
{:shortdesc}

**Astuce :** vous recherchez des commandes `bx cr` ? Consultez la [référence de l'interface CLI {{site.data.keyword.registryshort_notm}}](/docs/cli/plugins/registry/index.html). Vous recherchez des commandes `kubectl` ? Consultez la [documentation Kubernetes![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands).


<!--[https://github.ibm.com/alchemy-containers/armada-cli ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.ibm.com/alchemy-containers/armada-cli)-->

<table summary="Commandes de création de clusters sur {{site.data.keyword.Bluemix_notm}}">
 <thead>
    <th colspan=5>Commandes de création de clusters sur {{site.data.keyword.Bluemix_notm}}</th>
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

**Astuce :** pour identifier la version du plug-in {{site.data.keyword.containershort_notm}}, exécutez la commande suivante :

```
bx plugin list
```
{: pre}

## Commandes bx cs
{: #cs_commands}

### bx cs albs --cluster CLUSTER
{: #cs_albs}

Affiche le statut de tous les équilibreurs de charge d'application dans un cluster. Si aucun ID d'équilibreur de charge d'application n'est renvoyé, le cluster ne dispose pas de sous-réseau portable. Vous pouvez [créer](#cs_cluster_subnet_create) ou [ajouter](#cs_cluster_subnet_add) des sous-réseaux à un cluster.

<strong>Options de commande</strong> :

   <dl>
   <dt><code><em>--cluster </em>CLUSTER</code></dt>
   <dd>Le nom ou l'ID du cluster dans lequel vous répertoriez les équilibreurs de charge d'application disponibles. Cette valeur est obligatoire.</dd>
   </dl>

**Exemple** :

  ```
  bx cs albs --cluster mycluster
  ```
  {: pre}



### bx cs alb-configure --albID ALB_ID [--enable][--disable][--user-ip USERIP]
{: #cs_alb_configure}

Activez ou désactivez un équilibreur de charge d'application dans votre cluster standard. L'équilibreur de charge d'application public est activé par défaut.

**Options de commande** :

   <dl>
   <dt><code><em>--albID </em>ALB_ID</code></dt>
   <dd>ID de l'équilibreur de charge d'application. Exécutez la commande <code>bx cs albs <em>--cluster </em>CLUSTER</code> pour afficher les ID des équilibreurs de charge d'application dans un cluster. Cette valeur est obligatoire.</dd>

   <dt><code>--enable</code></dt>
   <dd>Incluez cet indicateur pour activer un équilibreur de charge d'application dans un cluster.</dd>

   <dt><code>--disable</code></dt>
   <dd>Incluez cet indicateur pour désactiver un équilibreur de charge d'application dans un cluster.</dd>

   <dt><code>--user-ip <em>USER_IP</em></code></dt>
   <dd>

   <ul>
    <li>Ce paramètre n'est disponible que pour un équilibreur de charge d'application privé</li>
    <li>L'équilibreur de charge d'application privé est déployé avec une adresse IP issue d'un sous-réseau privé fourni par l'utilisateur. Si aucune adresse IP n'est fournie, l'équilibreur de charge d'application est déployé avec une adresse IP privée issue du sous-réseau privé portable provisionné automatiquement lorsque vous avez créé le cluster.</li>
   </ul>
   </dd>
   </dl>

**Exemples** :

  Exemple d'activation d'un équilibreur de charge d'application :

  ```
  bx cs alb-configure --albID my_alb_id --enable
  ```
  {: pre}

  Exemple de désactivation d'un équilibreur de charge d'application :

  ```
  bx cs alb-configure --albID my_alb_id --disable
  ```
  {: pre}

  Exemple d'activation d'un équilibreur de charge d'application avec une adresse IP fournie par l'utilisateur :

  ```
  bx cs alb-configure --albID my_private_alb_id --enable --user-ip user_ip
  ```
  {: pre}

### bx cs alb-get --albID ALB_ID
{: #cs_alb_get}

Affiche les détails d'un équilibreur de charge d'application.

<strong>Options de commande</strong> :

   <dl>
   <dt><code><em>--albID </em>ALB_ID</code></dt>
   <dd>ID de l'équilibreur de charge d'application. Exécutez la commande <code>bx cs albs --cluster <em>CLUSTER</em></code> pour afficher les ID des équilibreurs de charge d'application dans un cluster. Cette valeur est obligatoire.</dd>
   </dl>

**Exemple** :

  ```
  bx cs alb-get --albID ALB_ID
  ```
  {: pre}

### bx cs alb-types
{: #cs_alb_types}

Affichez les types d'équilibreur de charge d'application pris en charge dans la région.

<strong>Options de commande</strong> :

   Aucune

**Exemple** :

  ```
  bx cs alb-types
  ```
  {: pre}


### bx cs apiserver-config-set
{: #cs_apiserver_config_set}

Définit une option pour configuration de serveur d'API Kubernetes d'un cluster. Cette commande doit être associée à l'une des sous-commandes suivantes pour l'option de configuration que vous voulez configurer.

#### bx cs apiserver-config-get audit-webhook CLUSTER
{: #cs_apiserver_api_webhook_get}

Affiche l'URL du service de journalisation distant auquel vous envoyez les journaux d'audit de serveur d'API. L'URL a été spécifiée lorsque vous avez créé le backend webhook pour la configuration de serveur d'API.

<strong>Options de commande</strong> :

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>
   </dl>

**Exemple** :

  ```
  bx cs apiserver-config-get audit-webhook my_cluster
  ```
  {: pre}

#### bx cs apiserver-config-set audit-webhook CLUSTER [--remoteServer SERVER_URL_OR_IP][--caCert CA_CERT_PATH] [--clientCert CLIENT_CERT_PATH][--clientKey CLIENT_KEY_PATH]
{: #cs_apiserver_api_webhook_set}

Définissez le backend webhook pour la configuration de serveur d'API. Le backend webhook achemine les journaux d'audit de serveur d'API à un serveur distant. Une configuration webhook est créée compte tenu des informations que vous soumettez dans les indicateurs de cette commande. Si vous ne soumettez pas d'informations dans les indicateurs, une configuration webhook par défaut est utilisée.

<strong>Options de commande</strong> :

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>

   <dt><code>--remoteServer <em>SERVER_URL</em></code></dt>
   <dd>URL ou adresse IP du service de journalisation distant auquel vous désirez envoyer les journaux d'audit. Si vous indiquez une URL de serveur non sécurisée, les certificats éventuels sont ignorés. Cette valeur est facultative.</dd>

   <dt><code>--caCert <em>CA_CERT_PATH</em></code></dt>
   <dd>Chemin de fichier du certificat d'autorité de certification utilisé pour vérifier le service de journalisation distant. Cette valeur est facultative.</dd>

   <dt><code>--clientCert <em>CLIENT_CERT_PATH</em></code></dt>
   <dd>Chemin de fichier du certificat d'autorité de certification utilisé pour authentification vis à vis du service de journalisation distant. Cette valeur est facultative.</dd>

   <dt><code>--clientKey <em> CLIENT_KEY_PATH</em></code></dt>
   <dd>Chemin de fichier da la clé client correspondante utilisée pour la connexion au service de journalisation distant. Cette valeur est facultative.</dd>
   </dl>

**Exemple** :

  ```
  bx cs apiserver-config-set audit-webhook my_cluster --remoteServer https://audit.example.com/audit --caCert /mnt/etc/kubernetes/apiserver-audit/ca.pem --clientCert /mnt/etc/kubernetes/apiserver-audit/cert.pem --clientKey /mnt/etc/kubernetes/apiserver-audit/key.pem
  ```
  {: pre}

#### bx cs apiserver-config-unset audit-webhook CLUSTER
{: #cs_apiserver_api_webhook_unset}

Désactivez la configuration de serveur dorsal webhook pour le serveur d'API du cluster. La désactivation du serveur dorsal webhook arrête le transfert des journaux d'audit du serveur d'API à un serveur distant.

<strong>Options de commande</strong> :

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>
   </dl>

**Exemple** :

  ```
  bx cs apiserver-config-unset audit-webhook my_cluster
  ```
  {: pre}

### bx cs apiserver-refresh CLUSTER
{: #cs_apiserver_refresh}

Redémarrez le maître Kubernetes dans le cluster pour appliquer les modifications éventuelles de la configuration de serveur d'API.

<strong>Options de commande</strong> :

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>
   </dl>

**Exemple** :

  ```
  bx cs apiserver-refresh my_cluster
  ```
  {: pre}


### bx cs cluster-config CLUSTER [--admin][--export]
{: #cs_cluster_config}

Après la connexion, téléchargez les données de configuration et les certificats Kubernetes pour vous connecter à votre
cluster et pour exécuter les commandes `kubectl`. Les fichiers sont téléchargés sous `user_home_directory/.bluemix/plugins/container-service/clusters/<cluster_name>`.

**Options de commande** :

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>

   <dt><code>--admin</code></dt>
   <dd>Téléchargez les fichiers de certificat et d'autorisations TLS pour le rôle Superutilisateur. Vous pouvez utiliser les certificats pour automatiser les tâches d'un cluster sans avoir à s'authentifier à nouveau. Les fichiers sont téléchargés dans `<user_home_directory>/.bluemix/plugins/container-service/clusters/<cluster_name>-admin`. Cette valeur est facultative.</dd>

   <dt><code>--export</code></dt>
   <dd>Téléchargez les certificats et les données de configuration Kubernetes sans autre message que la commande export. Comme aucun message ne s'affiche, vous pouvez utiliser cet indicateur lorsque vous créez des scripts automatisés. Cette valeur est facultative.</dd>
   </dl>

**Exemple** :

```
bx cs cluster-config my_cluster
```
{: pre}



### bx cs cluster-create [--file FILE_LOCATION][--hardware HARDWARE] --location LOCATION --machine-type MACHINE_TYPE --name NAME [--kube-version MAJOR.MINOR.PATCH][--no-subnet] [--private-vlan PRIVATE_VLAN][--public-vlan PUBLIC_VLAN] [--workers WORKER][--disable-disk-encrypt]
{: #cs_cluster_create}

Créez un cluster dans votre organisation.

<strong>Options de commande</strong>

<dl>
<dt><code>--file <em>FILE_LOCATION</em></code></dt>

<dd>Chemin d'accès au fichier YAML pour créer votre cluster standard. Au lieu de définir les caractéristiques de votre cluster à l'aide des options fournies dans cette commande, vous pouvez utiliser un fichier YAML.  Cette valeur est facultative pour les clusters standard et n'est pas disponible pour les clusters légers.

<p><strong>Remarque :</strong> si vous indiquez la même option dans la commande comme paramètre dans le fichier YAML, la valeur de l'option de la commande est prioritaire sur la valeur définie dans le fichier YAML. Par exemple, si vous indiquez un emplacement dans votre fichier YAML et utilisez l'option <code>--location</code> dans la commande, la valeur que vous avez entrée dans l'option de commande se substitue à la valeur définie dans le fichier YAML.

<pre class="codeblock">
<code>name: <em>&lt;cluster_name&gt;</em>
location: <em>&lt;location&gt;</em>
no-subnet: <em>&lt;no-subnet&gt;</em>
machine-type: <em>&lt;machine_type&gt;</em>
private-vlan: <em>&lt;private_vlan&gt;</em>
public-vlan: <em>&lt;public_vlan&gt;</em>
hardware: <em>&lt;shared_or_dedicated&gt;</em>
workerNum: <em>&lt;number_workers&gt;</em>
kube-version: <em>&lt;kube-version&gt;</em>

</code></pre>


<table>
    <caption>Tableau 1. Description des composants du fichier YAML</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code><em>name</em></code></td>
    <td>Remplacez <code><em>&lt;cluster_name&gt;</em></code> par le nom de votre cluster.</td>
    </tr>
    <tr>
    <td><code><em>location</em></code></td>
    <td>Remplacez <code><em>&lt;location&gt;</em></code> par l'emplacement où vous souhaitez créer votre cluster. Les emplacements disponibles dépendent de la région à laquelle vous êtes connecté. Pour afficher la liste des emplacements disponibles, exécutez la commande <code>bx cs locations</code>. </td>
     </tr>
     <tr>
     <td><code><em>no-subnet</em></code></td>
     <td>Par défaut, un sous-réseau public et un sous-réseau privé portables sont créés sur le réseau local virtuel (VLAN) associé au cluster. Remplacez <code><em>&lt;no-subnet&gt;</em></code> par <code><em>true</em></code> afin d'éviter de créer des sous-réseaux avec le cluster. Vous pouvez [créer](#cs_cluster_subnet_create) ou [ajouter](#cs_cluster_subnet_add) des sous-réseaux à un cluster ultérieurement.</td>
      </tr>
     <tr>
     <td><code><em>machine-type</em></code></td>
     <td>Remplacez <code><em>&lt;machine_type&gt;</em></code> par le type de machine souhaité pour vos noeuds d'agent. Pour afficher la liste des types de machine disponibles pour votre emplacement, exécutez la commande <code>bx cs machine-types <em>&lt;location&gt;</em></code>.</td>
     </tr>
     <tr>
     <td><code><em>private-vlan</em></code></td>
     <td>Remplacez <code><em>&lt;private_vlan&gt;</em></code> par l'ID du réseau local virtuel privé que vous souhaitez utiliser pour vos noeuds d'agent. Pour afficher la liste des réseaux locaux virtuels disponibles, exécutez la commande <code>bx cs vlans <em>&lt;location&gt;</em></code> et recherchez les routeurs VLAN débutant par <code>bcr</code> (routeur dorsal).</td>
     </tr>
     <tr>
     <td><code><em>public-vlan</em></code></td>
     <td>Remplacez <code><em>&lt;public_vlan&gt;</em></code> par l'ID du réseau local virtuel public que vous souhaitez utiliser pour vos noeuds d'agent. Pour afficher la liste des réseaux locaux virtuels disponibles, exécutez la commande <code>bx cs vlans <em>&lt;location&gt;</em></code> et recherchez les routeurs VLAN débutant par <code>fcr</code> (routeur frontal).</td>
     </tr>
     <tr>
     <td><code><em>hardware</em></code></td>
     <td>Niveau d'isolation du matériel pour votre noeud worker. Utilisez un cluster dédié si vous désirez que toutes les ressources physiques vous soient dédiées exclusivement ou un cluster partagé pour permettre leur partage avec d'autres clients IBM. La valeur par défaut est <code>shared</code>.</td>
     </tr>
     <tr>
     <td><code><em>workerNum</em></code></td>
     <td>Remplacez <code><em>&lt;number_workers&gt;</em></code> par le nombre de noeuds d'agent que vous souhaitez déployer.</td>
     </tr>
     <tr>
      <td><code><em>kube-version</em></code></td>
      <td>Version Kubernetes du noeud maître du cluster. Cette valeur est facultative. Sans spécification, le cluster est créé avec les versions Kubernetes prises en charge par défaut. Pour connaître les versions disponibles, exécutez la commande <code>bx cs kube-versions</code>.</td></tr>
      <tr>
      <td><code>diskEncryption: <em>false</em></code></td>
      <td>Les noeuds Worker exploitent par défaut le chiffrement de disque ; [En savoir plus](cs_secure.html#worker). Pour désactiver le chiffrement, incluez cette option en lui attribuant la valeur <code>false</code>.</td></tr>
     </tbody></table>
    </p></dd>

<dt><code>--hardware <em>HARDWARE</em></code></dt>
<dd>Niveau d'isolation du matériel pour votre noeud worker. Utilisez dedicated pour que toutes les ressources physiques vous soient dédiées exclusivement ou shared pour permettre leur partage avec d'autres clients IBM. La valeur par défaut est shared.  Cette valeur est facultative pour les clusters standard et n'est pas disponible pour les clusters légers.</dd>

<dt><code>--location <em>LOCATION</em></code></dt>
<dd>Emplacement sous lequel vous désirez créer le cluster. Les emplacements disponibles dépendent de la région
{{site.data.keyword.Bluemix_notm}} à laquelle vous vous êtes connecté. Pour des performances optimales, sélectionnez la région physiquement la plus proche.  Cette valeur est obligatoire pour les clusters standard et facultative pour les clusters légers.

<p>Passez en revue les [emplacements disponibles](cs_regions.html#locations).
</p>

<p><strong>Remarque :</strong> si vous sélectionnez un emplacement à l'étranger, il se peut que vous ayez besoin d'une autorisation des autorités pour stocker physiquement les données dans un autre pays.</p>
</dd>

<dt><code>--machine-type <em>MACHINE_TYPE</em></code></dt>
<dd>Le type de machine choisi a une incidence sur la quantité de mémoire et l'espace disque disponible pour les conteneurs déployés sur votre noeud worker. Pour afficher la liste des types de machine disponibles, exécutez la commande [bx cs machine-types <em>LOCATION</em>](#cs_machine_types).  Cette valeur est obligatoire pour les clusters standard et n'est pas disponible pour les clusters légers.</dd>

<dt><code>--name <em>NAME</em></code></dt>
<dd>Nom du cluster.  Cette valeur est obligatoire.</dd>

<dt><code>--kube-version <em>MAJOR.MINOR.PATCH</em></code></dt>
<dd>Version Kubernetes du noeud maître du cluster. Cette valeur est facultative. Sans spécification, le cluster est créé avec les versions Kubernetes prises en charge par défaut. Pour connaître les versions disponibles, exécutez la commande <code>bx cs kube-versions</code>.</dd>

<dt><code>--no-subnet</code></dt>
<dd>Par défaut, un sous-réseau public et un sous-réseau privé portables sont créés sur le réseau local virtuel (VLAN) associé au cluster. Incluez l'indicateur <code>--no-subnet</code> afin d'éviter la création de sous-réseaux avec le cluster. Vous pouvez [créer](#cs_cluster_subnet_create) ou [ajouter](#cs_cluster_subnet_add) des sous-réseaux à un cluster ultérieurement.</dd>

<dt><code>--private-vlan <em>PRIVATE_VLAN</em></code></dt>
<dd>

<ul>
<li>Ce paramètre n'est pas disponible pour les clusters légers.</li>
<li>S'il s'agit du premier cluster standard que vous créez à cet emplacement, n'incluez pas cet indicateur. Un VLAN privé est créé pour vous lorsque le cluster est créé.</li>
<li>Si vous avez créé un cluster standard auparavant dans cet emplacement ou créé un VLAN privé dans l'infrastructure IBM Cloud (SoftLayer), vous devez spécifier ce VLAN privé.

<p><strong>Remarque</strong> : le VLAN public et le VLAN privé que vous spécifiez à l'aide de la commande create doivent correspondre. Les routeurs de VLAN privé commencent toujours par <code>bcr</code> (routeur dorsal) et les routeurs de VLAN public par <code>fcr</code> (routeur frontal). Le numéro et la combinaison de lettres après ces préfixes doivent correspondre pour pouvoir utiliser ces réseaux locaux virtuels lors de la création d'un cluster. N'utilisez pas de réseaux locaux virtuels publics et privés qui ne correspondent pas pour créer un cluster.</p></li>
</ul>

<p>Pour déterminer si vous disposez déjà d'un VLAN privé pour un emplacement spécifique ou pour identifier le nom d'un VLAN privé existant, exécutez la commande <code>bx cs vlans <em>&lt;location&gt;</em></code>.</p></dd>

<dt><code>--public-vlan <em>PUBLIC_VLAN</em></code></dt>
<dd>
<ul>
<li>Ce paramètre n'est pas disponible pour les clusters légers.</li>
<li>S'il s'agit du premier cluster standard que vous créez à cet emplacement, n'utilisez pas cet indicateur. Un VLAN public est créé pour vous lorsque le cluster est créé.</li>
<li>Si vous avez créé un cluster standard auparavant dans cet emplacement ou créé un VLAN public dans l'infrastructure IBM Cloud (SoftLayer), vous devez spécifier ce VLAN public.

<p><strong>Remarque</strong> : le VLAN public et le VLAN privé que vous spécifiez à l'aide de la commande create doivent correspondre. Les routeurs de VLAN privé commencent toujours par <code>bcr</code> (routeur dorsal) et les routeurs de VLAN public par <code>fcr</code> (routeur frontal). Le numéro et la combinaison de lettres après ces préfixes doivent correspondre pour pouvoir utiliser ces réseaux locaux virtuels lors de la création d'un cluster. N'utilisez pas de réseaux locaux virtuels publics et privés qui ne correspondent pas pour créer un cluster.</p></li>
</ul>

<p>Pour déterminer si vous disposez déjà d'un VLAN public pour un emplacement spécifique ou pour identifier le nom d'un VLAN public existant, exécutez la commande <code>bx cs vlans <em>&lt;location&gt;</em></code>.</p></dd>

<dt><code>--workers WORKER</code></dt>
<dd>Nombre de noeuds d'agent que vous désirez déployer dans votre cluster. Si vous ne spécifiez pas cette
option, un cluster avec 1 noeud worker est créé. Cette valeur est facultative pour les clusters standard et n'est pas disponible pour les clusters légers.

<p><strong>Remarque :</strong> A chaque noeud worker sont affectés un ID de noeud worker unique et un nom de domaine qui ne doivent pas être modifiés manuellement après la création du cluster. La modification de l'ID ou du domaine empêcherait le maître
Kubernetes de gérer votre cluster.</p></dd>

<dt><code>--disable-disk-encrypt</code></dt>
<dd>Les noeuds Worker exploitent par défaut le chiffrement de disque ; [En savoir plus](cs_secure.html#worker). Pour désactiver le chiffrement, incluez cette option.</dd>
</dl>

**Exemples** :

  

  Exemple pour un cluster standard :
  {: #example_cluster_create}

  ```
  bx cs cluster-create --location dal10 --public-vlan my_public_vlan_id --private-vlan my_private_vlan_id --machine-type u2c.2x4 --name my_cluster --hardware shared --workers 2
  ```
  {: pre}

  Exemple pour un cluster léger :

  ```
  bx cs cluster-create --name my_cluster
  ```
  {: pre}

  Exemple pour un environnement {{site.data.keyword.Bluemix_dedicated_notm}} :

  ```
  bx cs cluster-create --machine-type machine-type --workers number --name cluster_name
  ```
  {: pre}


### bx cs cluster-get CLUSTER [--showResources]
{: #cs_cluster_get}

Affichez des informations sur un cluster dans votre organisation.

<strong>Options de commande</strong> :

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>

   <dt><code><em>--showResources</em></code></dt>
   <dd>Affiche les VLAN et les sous-réseaux pour un cluster.</dd>
   </dl>

**Exemple** :

  ```
  bx cs cluster-get my_cluster
  ```
  {: pre}


### bx cs cluster-rm [-f] CLUSTER
{: #cs_cluster_rm}

Supprimez un cluster de votre organisation.

<strong>Options de commande</strong> :

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>

   <dt><code>-f</code></dt>
   <dd>Utilisez cette option pour forcer la suppression d'un cluster sans invites utilisateur. Cette valeur est facultative.</dd>
   </dl>

**Exemple** :

  ```
  bx cs cluster-rm my_cluster
  ```
  {: pre}


### bx cs cluster-service-bind CLUSTER KUBERNETES_NAMESPACE SERVICE_INSTANCE_GUID
{: #cs_cluster_service_bind}

Ajoutez un service {{site.data.keyword.Bluemix_notm}} à un cluster.

<strong>Options de commande</strong> :

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>

   <dt><code><em>KUBERNETES_NAMESPACE</em></code></dt>
   <dd>Nom de l'espace de nom Kubernetes. Cette valeur est obligatoire.</dd>

   <dt><code><em>SERVICE_INSTANCE_GUID</em></code></dt>
   <dd>ID de l'instance de service {{site.data.keyword.Bluemix_notm}} que vous désirez lier. Cette valeur est obligatoire.</dd>
   </dl>

**Exemple** :

  ```
  bx cs cluster-service-bind my_cluster my_namespace my_service_instance_GUID
  ```
  {: pre}


### bx cs cluster-service-unbind CLUSTER KUBERNETES_NAMESPACE SERVICE_INSTANCE_GUID
{: #cs_cluster_service_unbind}

Supprimez un service {{site.data.keyword.Bluemix_notm}} d'un cluster.

**Remarque :** lorsque vous supprimez un service {{site.data.keyword.Bluemix_notm}}, ses données d'identification du service sont supprimées du cluster. Si un pod utilise encore ce service, son opération échoue vu que les données d'identification du service sont introuvables.

<strong>Options de commande</strong> :

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>

   <dt><code><em>KUBERNETES_NAMESPACE</em></code></dt>
   <dd>Nom de l'espace de nom Kubernetes. Cette valeur est obligatoire.</dd>

   <dt><code><em>SERVICE_INSTANCE_GUID</em></code></dt>
   <dd>ID de l'instance de service {{site.data.keyword.Bluemix_notm}} que vous désirez retirer. Cette valeur est obligatoire.</dd>
   </dl>

**Exemple** :

  ```
  bx cs cluster-service-unbind my_cluster my_namespace my_service_instance_GUID
  ```
  {: pre}


### bx cs cluster-services CLUSTER [--namespace KUBERNETES_NAMESPACE][--all-namespaces]
{: #cs_cluster_services}

Répertoriez les services liés à un ou à tous les espaces de nom Kubernetes dans un cluster. Si aucune option n'est spécifiée, les services pour l'espace de nom par défaut sont affichés.

<strong>Options de commande</strong> :

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>

   <dt><code>--namespace <em>KUBERNETES_NAMESPACE</em></code>, <code>-n <em>KUBERNETES_NAMESPACE</em></code></dt>
   <dd>Inclut les services liés à un espace de nom spécifique dans un cluster. Cette valeur est facultative.</dd>

   <dt><code>--all-namespaces</code></dt>
    <dd>Inclut les services liés à tous les espaces de nom dans un cluster. Cette valeur est facultative.</dd>
    </dl>

**Exemple** :

  ```
  bx cs cluster-services my_cluster --namespace my_namespace
  ```
  {: pre}


### bx cs cluster-subnet-add CLUSTER SUBNET
{: #cs_cluster_subnet_add}

Rendez un sous-réseau d'un compte d'infrastructure IBM Cloud (SoftLayer) disponible pour le cluster spécifié.

**Remarque :** lorsque vous rendez un sous-réseau disponible pour un cluster, les adresses IP du sous-réseau sont utilisées pour l'opération réseau du cluster. Pour éviter des conflits d'adresse IP, prenez soin de n'utiliser le sous-réseau qu'avec un seul cluster. N'utilisez pas en même temps un sous-réseau pour plusieurs clusters ou à d'autres fins hors d'{{site.data.keyword.containershort_notm}}.

<strong>Options de commande</strong> :

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>

   <dt><code><em>SUBNET</em></code></dt>
   <dd>ID du sous-réseau. Cette valeur est obligatoire.</dd>
   </dl>

**Exemple** :

  ```
  bx cs cluster-subnet-add my_cluster subnet
  ```
  {: pre}

### bx cs cluster-subnet-create CLUSTER SIZE VLAN_ID
{: #cs_cluster_subnet_create}

Créez un sous-réseau dans un compte d'infrastructure IBM Cloud (SoftLayer) et le rend disponible pour le cluster spécifié dans {{site.data.keyword.containershort_notm}}.

**Remarque :** lorsque vous rendez un sous-réseau disponible pour un cluster, les adresses IP du sous-réseau sont utilisées pour l'opération réseau du cluster. Pour éviter des conflits d'adresse IP, prenez soin de n'utiliser le sous-réseau qu'avec un seul cluster. N'utilisez pas en même temps un sous-réseau pour plusieurs clusters ou à d'autres fins hors d'{{site.data.keyword.containershort_notm}}.

<strong>Options de commande</strong> :

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>Nom ou ID du cluster. Cette valeur est obligatoire. Pour répertorier vos clusters, utilisez la [commande](#cs_clusters) `bx cs clusters`.</dd>

   <dt><code><em>SIZE</em></code></dt>
   <dd>Nombre d'adresses IP du sous-réseau. Cette valeur est obligatoire. Les valeurs possibles sont : 8, 16, 32 ou 64.</dd>

   <dt><code><em>VLAN_ID</em></code></dt>
   <dd>Réseau local virtuel(VLAN) dans lequel créer le sous-réseau. Cette valeur est obligatoire. Pour répertorier les VLAN disponibles, utilisez la [commande](#cs_vlans) `bx cs vlans<location>`.</dd>
   </dl>

**Exemple** :

  ```
  bx cs cluster-subnet-create my_cluster 8 1764905
  ```
  {: pre}

### bx cs cluster-user-subnet-add CLUSTER SUBNET_CIDR PRIVATE_VLAN
{: #cs_cluster_user_subnet_add}

Mettez à disposition votre propre sous-réseau privé sur vos clusters {{site.data.keyword.containershort_notm}}.

Ce sous-réseau privé n'est pas celui qui est fourni par l'infrastructure IBM Cloud (SoftLayer). De ce fait, vous devez configurer tout routage de trafic entrant et sortant pour le sous-réseau. Pour ajouter un sous-réseau d'infrastructure IBM Cloud (SoftLayer), utilisez la [commande](#cs_cluster_subnet_add) `bx cs cluster-subnet-add`.

**Remarque** : lorsque vous ajoutez un sous-réseau utilisateur privé à un cluster, les adresses IP de ce sous-réseau sont utilisées pour les équilibreurs de charge privés figurant dans le cluster. Pour éviter des conflits d'adresse IP, prenez soin de n'utiliser le sous-réseau qu'avec un seul cluster. N'utilisez pas en même temps un sous-réseau pour plusieurs clusters ou à d'autres fins hors d'{{site.data.keyword.containershort_notm}}.

<strong>Options de commande</strong> :

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>

   <dt><code><em>SUBNET_CIDR</em></code></dt>
   <dd>CIDR (Classless InterDomain Routing) du sous-réseau. Cette valeur est obligatoire et ne doit pas entrer en conflit avec un sous-réseau utilisé par l'infrastructure IBM Cloud (SoftLayer).

   Les préfixes pris en charge sont compris entre `/30` (1 adresse IP) et `/24` (253 adresses IP). Si vous avez défini un CIDR avec une longueur de préfixe et que vous devez modifier sa valeur, ajoutez d'abord le nouveau CIDR, puis [supprimer l'ancien CIDR](#cs_cluster_user_subnet_rm).</dd>

   <dt><code><em>PRIVATE_VLAN</em></code></dt>
   <dd>ID du VLAN privé. Cette valeur est obligatoire. Elle doit correspondre à l'ID du VLAN privé d'un ou plusieurs noeuds d'agent dans le cluster.</dd>
   </dl>

**Exemple** :

  ```
  bx cs cluster-user-subnet-add my_cluster 192.168.10.0/29 1502175
  ```
  {: pre}


### bx cs cluster-user-subnet-rm CLUSTER SUBNET_CIDR PRIVATE_VLAN
{: #cs_cluster_user_subnet_rm}

Supprimez votre propre sous-réseau privé du cluster indiqué.

**Remarque :** tout service déployé sur une adresse IP depuis votre propre sous-réseau privé reste actif une fois le sous-réseau supprimé.

<strong>Options de commande</strong> :

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>

   <dt><code><em>SUBNET_CIDR</em></code></dt>
   <dd>CIDR (Classless InterDomain Routing) du sous-réseau. Cette valeur est obligatoire et doit correspondre au CIDR défini par la [commande](#cs_cluster_user_subnet_add) `bx cs cluster-user-subnet-add`.</dd>

   <dt><code><em>PRIVATE_VLAN</em></code></dt>
   <dd>ID du VLAN privé. Cette valeur est obligatoire et doit correspondre à l'ID du VLAN défini par la [commande](#cs_cluster_user_subnet_add) `bx cs cluster-user-subnet-add`.</dd>
   </dl>

**Exemple** :

  ```
  bx cs cluster-user-subnet-rm my_cluster 192.168.10.0/29 1502175
  ```
  {: pre}


### bx cs cluster-update [-f] CLUSTER [--kube-version MAJOR.MINOR.PATCH][--force-update]
{: #cs_cluster_update}

Mettez à jour le maître Kubernetes à la version par défaut de l'API. Pendant la mise à jour, vous ne pouvez ni accéder au cluster, ni le modifier. Les noeuds d'agent, applis et ressources qui ont été déployés par l'utilisateur ne sont pas modifiés et poursuivront leur exécution.

Vous pourriez devoir modifier vos fichiers YAML en vue de déploiements ultérieurs. Consultez cette [note sur l'édition](cs_versions.html) pour plus de détails.

<strong>Options de commande</strong> :

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>

   <dt><code>--kube-version <em>MAJOR.MINOR.PATCH</em></code></dt>
   <dd>Version Kubernetes du cluster. Si cet indicateur n'est pas spécifié, le maître Kubernetes est mis à jour à la version par défaut de l'API. Pour connaître les versions disponibles, exécutez la commande [bx cs kube-versions](#cs_kube_versions). Cette valeur est facultative.</dd>

   <dt><code>-f</code></dt>
   <dd>Utilisez cette option pour forcer la mise à jour du maître sans invites utilisateur. Cette valeur est facultative.</dd>

   <dt><code>--force-update</code></dt>
   <dd>Tentative de mise à jour alors que la modification est supérieure à deux niveaux de version mineure. Cette valeur est facultative.</dd>
   </dl>

**Exemple** :

  ```
  bx cs cluster-update my_cluster
  ```
  {: pre}

### bx cs clusters
{: #cs_clusters}

Affichez la liste des clusters dans votre organisation.

<strong>Options de commande</strong> :

  Aucune

**Exemple** :

  ```
  bx cs clusters
  ```
  {: pre}


### bx cs credentials-set --infrastructure-api-key API_KEY --infrastructure-username USERNAME
{: #cs_credentials_set}

Définissez les données d'identification du compte d'infrastructure IBM Cloud (SoftLayer) pour votre compte {{site.data.keyword.Bluemix_notm}}. Elles vous permettront d'accéder au portefeuille d'infrastructure IBM Cloud (SoftLayer) via votre compte {{site.data.keyword.Bluemix_notm}}.

**Remarque :** ne définissez pas plusieurs données d'identification pour un compte {{site.data.keyword.Bluemix_notm}}. Tout compte {{site.data.keyword.Bluemix_notm}} est lié à un seul portefeuille d'infrastructure IBM Cloud (SoftLayer).

<strong>Options de commande</strong> :

   <dl>
   <dt><code>--infrastructure-username <em>USERNAME</em></code></dt>
   <dd>Nom d'utilisateur du compte d'infrastructure IBM Cloud (SoftLayer). Cette valeur est obligatoire.</dd>


   <dt><code>--infrastructure-api-key <em>API_KEY</em></code></dt>
   <dd>Clé d'API du compte d'infrastructure IBM Cloud (SoftLayer). Cette valeur est obligatoire.

 <p>
  Pour générer une clé d'API, procédez comme suit :

  <ol>
  <li>Connectez-vous au [portail d'infrastructure IBM Cloud (SoftLayer) ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://control.softlayer.com/).</li>
  <li>Sélectionnez <strong>Compte</strong>, puis <strong>Utilisateurs</strong>.</li>
  <li>Cliquez sur <strong>Générer</strong> pour générer une clé d'API d'infrastructure IBM Cloud (SoftLayer) pour votre compte.</li>
  <li>Copiez la clé d'API à utiliser dans cette commande.</li>
  </ol>

  Pour afficher votre clé d'API existante, procédez comme suit :
  <ol>
  <li>Connectez-vous au [portail d'infrastructure IBM Cloud (SoftLayer) ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://control.softlayer.com/).</li>
  <li>Sélectionnez <strong>Compte</strong>, puis <strong>Utilisateurs</strong>.</li>
  <li>Cliquez sur <strong>Afficher</strong> pour afficher votre clé d'API existante.</li>
  <li>Copiez la clé d'API à utiliser dans cette commande.</li>
  </ol>
  </p></dd>
  </dl>

**Exemple** :

  ```
  bx cs credentials-set --infrastructure-api-key API_KEY --infrastructure-username USERNAME
  ```
  {: pre}


### bx cs credentials-unset
{: #cs_credentials_unset}

Supprimez les données d'identification du compte d'infrastructure IBM Cloud (SoftLayer) de votre compte {{site.data.keyword.Bluemix_notm}}. Une fois les données d'identification supprimées, vous ne pouvez plus accéder au portefeuille d'infrastructure IBM Cloud (SoftLayer) via votre compte {{site.data.keyword.Bluemix_notm}}.

<strong>Options de commande</strong> :

   Aucune

**Exemple** :

  ```
  bx cs credentials-unset
  ```
  {: pre}



### bx cs help
{: #cs_help}

Affichez la liste des commandes et des paramètres pris en charge.

<strong>Options de commande</strong> :

   Aucune

**Exemple** :

  ```
  bx cs help
  ```
  {: pre}


### bx cs init [--host HOST]
{: #cs_init}

Initialisez le plug-in {{site.data.keyword.containershort_notm}} ou spécifiez la région dans laquelle vous souhaitez créer ou accéder à des clusters Kubernetes.

<strong>Options de commande</strong> :

   <dl>
   <dt><code>--host <em>HOST</em></code></dt>
   <dd>Noeud final d'API {{site.data.keyword.containershort_notm}} à utiliser.  Cette valeur est facultative. [Afficher les valeurs de noeud final d'API disponibles.](cs_regions.html#container_regions)</dd>
   </dl>



```
bx cs init --host https://uk-south.containers.bluemix.net
```
{: pre}

### bx cs kube-versions
{: #cs_kube_versions}

Affichez la liste des versions Kubernetes prises en charge dans {{site.data.keyword.containershort_notm}}. Mettez à jour votre [maître de cluster](#cs_cluster_update) et vos [noeuds d'agent](#cs_worker_update) à la version par défaut pour bénéficier des fonctionnalités stables les plus récentes.

**Options de commande** :

  Aucune

**Exemple** :

  ```
  bx cs kube-versions
  ```
  {: pre}

### bx cs locations
{: #cs_datacenters}

Affichez la liste de tous les emplacements disponibles pour créer un cluster.

<strong>Options de commande</strong> :

   Aucune

**Exemple** :

  ```
  bx cs locations
  ```
  {: pre}

### bx cs logging-config-create CLUSTER --logsource LOG_SOURCE [--namespace KUBERNETES_NAMESPACE][--hostname LOG_SERVER_HOSTNAME_OR_IP] [--port LOG_SERVER_PORT][--space CLUSTER_SPACE] [--org CLUSTER_ORG] --type LOG_TYPE [--json]
{: #cs_logging_create}

Créez une configuration de journalisation. Vous pouvez utiliser cette commande pour acheminer des journaux de conteneurs, applications, noeuds worker, clusters Kubernetes et équilibreurs de charge d'application Ingress à {{site.data.keyword.loganalysisshort_notm}} ou à un serveur syslog externe.

<strong>Options de commande</strong> :

<dl>
<dt><code><em>CLUSTER</em></code></dt>
<dd>Nom ou ID du cluster.</dd>
<dt><code>--logsource <em>LOG_SOURCE</em></code></dt>
<dd>Source de journal pour laquelle activer l'acheminement de journal. Valeurs admises : <code>container</code>, <code>application</code>, <code>worker</code>, <code>kubernetes</code> et <code>ingress</code>. Cette valeur est obligatoire.</dd>
<dt><code>--namespace <em>KUBERNETES_NAMESPACE</em></code></dt>
<dd>Espace de nom de conteneur Docker pour lequel acheminer les journaux. Le transfert des journaux n'est pas pris en charge pour les espaces de nom Kubernetes <code>ibm-system</code> et <code>kube-system</code>. Cette valeur n'est valide que pour la source de journal de conteneur et est facultative. Si vous n'indiquez pas d'espace de nom, tous les espaces de nom du conteneur utilisent cette configuration.</dd>
<dt><code>--hostname <em>LOG_SERVER_HOSTNAME</em></code></dt>
<dd>Si le type de journalisation correspond à <code>syslog</code>, nom d'hôte ou adresse ID du serveur collecteur de journal. Cette valeur est obligatoire pour <code>syslog</code>. Si le type de journalisation correspond à <code>ibm</code>, URL d'ingestion {{site.data.keyword.loganalysislong_notm}}. Vous trouverez [ici](/docs/services/CloudLogAnalysis/log_ingestion.html#log_ingestion_urls) la liste des URL d'ingestion disponibles. Si vous n'en indiquez aucune, le noeud final de la région où a été créé votre cluster est utilisé.</dd>
<dt><code>--port <em>LOG_SERVER_PORT</em></code></dt>
<dd>Port du serveur collecteur de journal. Cette valeur est facultative. Si vous ne spécifiez pas de port, le port standard <code>514</code> est utilisé pour <code>syslog</code> et le port standard <code>9091</code> pour <code>ibm</code>.</dd>
<dt><code>--space <em>CLUSTER_SPACE</em></code></dt>
<dd>Nom de l'espace auquel vous désirez envoyer les journaux. Cette valeur est facultative et n'est valide que pour le type de journal <code>ibm</code>. Si vous n'en spécifiez pas un, les journaux sont envoyés au niveau du compte.</dd>
<dt><code>--org <em>CLUSTER_ORG</em></code></dt>
<dd>Nom de l'organisation où réside l'espace. Cette valeur n'est valide que pour le type de journal <code>ibm</code> et est obligatoire si vous avez spécifié un espace.</dd>
<dt><code>--type <em>LOG_TYPE</em></code></dt>
<dd>Protocole de transfert de journal que vous souhaitez utiliser. Actuellement, <code>syslog</code> et <code>ibm</code> sont pris en charge. Cette valeur est obligatoire.</dd>
<dt><code>--json</code></dt>
<dd>(Facultatif) Imprime la sortie de la commande au format JSON.</dd>
</dl>

**Exemples** :

Exemple pour le type de journal `ibm` qui achemine les données depuis une source de journal `container` sur le port par défaut :

  ```
  bx cs logging-config-create my_cluster --logsource container --namespace my_namespace --hostname ingest.logging.ng.bluemix.net --type ibm
  ```
  {: pre}

Exemple pour le type de journal `syslog` qui achemine les données depuis une source de journal `container` sur le port par défaut :

  ```
  bx cs logging-config-create my_cluster --logsource container --namespace my_namespace  --hostname my_hostname-or-IP --type syslog
  ```
  {: pre}

  Exemple pour le type de journal `syslog` qui achemine des journaux depuis une source `ingress` sur un port différent de celui par défaut :

    ```
    bx cs logging-config-create my_cluster --logsource container --hostname my_hostname-or-IP --port 5514 --type syslog
    ```
    {: pre}

### bx cs logging-config-get CLUSTER [--logsource LOG_SOURCE][--json]
{: #cs_logging_get}

Affichez toutes les configurations de transfert de journaux d'un cluster ou filtrez les configurations de journalisation en fonction de la source de journal.

<strong>Options de commande</strong> :

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>
   <dt><code>--logsource <em>LOG_SOURCE</em></code></dt>
   <dd>Type de source de journal que vous voulez filtrer. Seules les configurations de journalisation de cette source de journal dans le cluster sont renvoyées. Valeurs admises : <code>container</code>, <code>application</code>, <code>worker</code>, <code>kubernetes</code> et <code>ingress</code>. Cette valeur est facultative.</dd>
   <dt><code>--json</code></dt>
   <dd>(Facultatif) Imprime la sortie de la commande au format JSON.</dd>
   </dl>

**Exemple** :

  ```
  bx cs logging-config-get my_cluster --logsource worker
  ```
  {: pre}


### bx cs logging-config-rm CLUSTER LOG_CONFIG_ID
{: #cs_logging_rm}

Supprimez une configuation de transfert de journaux. Ceci cesse l'acheminement des journaux à un serveur syslog ou à {{site.data.keyword.loganalysisshort_notm}}.

<strong>Options de commande</strong> :

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>
   <dt><code><em>LOG_CONFIG_ID</em></code></dt>
   <dd>ID de configuration de journalisation que vous souhaitez retirer de la source de journal. Cette valeur est obligatoire.</dd>
   </dl>

**Exemple** :

  ```
  bx cs logging-config-rm my_cluster f4bc77c0-ee7d-422d-aabf-a4e6b977264e
  ```
  {: pre}


### bx cs logging-config-update CLUSTER LOG_CONFIG_ID [--hostname LOG_SERVER_HOSTNAME_OR_IP][--port LOG_SERVER_PORT] [--space CLUSTER_SPACE][--org CLUSTER_ORG] --type LOG_TYPE [--json]
{: #cs_logging_update}

Mettez à jour les détails d'une configuration d'acheminement de journaux.

<strong>Options de commande</strong> :

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>
   <dt><code><em>LOG_CONFIG_ID</em></code></dt>
   <dd>ID de configuration de journalisation que vous souhaitez mettre à jour. Cette valeur est obligatoire.</dd>
   <dt><code>--hostname <em>LOG_SERVER_HOSTNAME</em></code></dt>
   <dd>Si le type de journalisation correspond à <code>syslog</code>, nom d'hôte ou adresse ID du serveur collecteur de journal. Cette valeur est obligatoire pour <code>syslog</code>. Si le type de journalisation correspond à <code>ibm</code>, URL d'ingestion {{site.data.keyword.loganalysislong_notm}}. Vous trouverez [ici](/docs/services/CloudLogAnalysis/log_ingestion.html#log_ingestion_urls) la liste des URL d'ingestion disponibles. Si vous n'en indiquez aucune, le noeud final de la région où a été créé votre cluster est utilisé.</dd>
   <dt><code>--port <em>LOG_SERVER_PORT</em></code></dt>
   <dd>Port du serveur collecteur de journal. Cette valeur est facultative lorsque le type de journalisation est <code>syslog</code>. Si vous ne spécifiez pas de port, le port standard <code>514</code> est utilisé pour <code>syslog</code> et le port <code>9091</code> pour <code>ibm</code>.</dd>
   <dt><code>--space <em>CLUSTER_SPACE</em></code></dt>
   <dd>Nom de l'espace auquel vous désirez envoyer les journaux. Cette valeur est facultative et n'est valide que pour le type de journal <code>ibm</code>. Si vous n'en spécifiez pas un, les journaux sont envoyés au niveau du compte.</dd>
   <dt><code>--org <em>CLUSTER_ORG</em></code></dt>
   <dd>Nom de l'organisation où réside l'espace. Cette valeur n'est valide que pour le type de journal <code>ibm</code> et est obligatoire si vous avez spécifié un espace.</dd>
   <dt><code>--type <em>LOG_TYPE</em></code></dt>
   <dd>Protocole de transfert de journal que vous souhaitez utiliser. Actuellement, <code>syslog</code> et <code>ibm</code> sont pris en charge. Cette valeur est obligatoire.</dd>
   <dt><code>--json</code></dt>
   <dd>(Facultatif) Imprime la sortie de la commande au format JSON.</dd>
   </dl>

**Exemple pour le type de journal `ibm`** :

  ```
  bx cs logging-config-update my_cluster f4bc77c0-ee7d-422d-aabf-a4e6b977264e --type ibm
  ```
  {: pre}

**Exemple pour le type de journal `syslog`** :

  ```
  bx cs logging-config-update my_cluster f4bc77c0-ee7d-422d-aabf-a4e6b977264e --hostname localhost --port 5514 --type syslog
  ```
  {: pre}


### bx cs machine-types LOCATION
{: #cs_machine_types}

Affichez la liste des types de machine disponibles pour vos noeuds d'agent. Chaque type de machine inclut la quantité d'UC virtuelles, de mémoire et d'espace disque pour chaque noeud worker dans le cluster.
- Les types de machine dont le nom inclut `u2c` ou `b2c` utilisent un disque local au lieu du réseau de stockage SAN pour plus de fiabilité. Un SAN procure, entre autres, une capacité de traitement plus élevée lors de la sérialisation des octets sur le disque local et réduit les risques de dégradation du système de fichiers en cas de défaillance du réseau. Ces types de machine contiennent un stockage sur disque local de 25 Go pour le système de fichiers du système d'exploitation et 100 Go de stockage sur disque local pour `/var/lib/docker`, répertoire dans lequel sont écrites toutes les données des conteneurs.
- Les types de machine dont le nom inclut `encrypted` chiffrent les données Docker de l'hôte. Le répertoire `/var/lib/docker`, dans lequel sont stockées toutes les données des conteneurs, est chiffré avec le chiffrement LUKS.
- Les types de machine dont le nom inclut `u1c` ou `b1c` sont obsolètes. Par exemple, `u1c.2x4`. Pour démarrer des machines de type `u2c` et`b2c`, utilisez la commande `bx cs worker-add` afin d'ajouter des noeuds d'agent avec les types de machine mis à jour. Ensuite, supprimez les noeuds d'agent qui utilisent les types de machine obsolètes à l'aide de la commande `bx cs worker-rm`.
</p>


<strong>Options de commande</strong> :

   <dl>
   <dt><code><em>LOCATION</em></code></dt>
   <dd>Indiquez l'emplacement où répertorier les types de machine disponibles. Cette valeur est obligatoire. Passez en revue les [emplacements disponibles](cs_regions.html#locations).</dd></dl>

**Exemple** :

  ```
  bx cs machine-types dal10
  ```
  {: pre}

### bx cs region
{: #cs_region}

Identifiez la région {{site.data.keyword.containershort_notm}} où vous êtes actuellement situé. Vous pouvez créer et gérer des clusters spécifiques à la région. Utilisez la commande `bx cs region-set` pour changer de région.

**Exemple** :

```
bx cs region
```
{: pre}

**Sortie **:
```
Region: us-south
```
{: screen}

### bx cs region-set [REGION]
{: #cs_region-set}

Définissez la région pour {{site.data.keyword.containershort_notm}}. Vous pouvez créer et gérer des clusters spécifiques à la région, et aussi désirer disposer de clusters dans plusieurs régions en vue d'une haute disponibilité.

Par exemple, vous pourriez vous connecter à {{site.data.keyword.Bluemix_notm}} dans la région Sud des Etats-Unis et y créer un cluster. Vous pourriez ensuite utiliser la commande `bx cs region-set eu-central` pour cibler la région Centre des Etats-Unis et y créer un autre cluster. Enfin, vous pourriez utiliser la commande `bx cs region-set us-south` pour revenir à la région Sud des Etats-Unis et gérer votre cluster dans cette région.

**Options de commande** :

<dl>
<dt><code><em>REGION</em></code></dt>
<dd>Entrez la région que vous désirez cibler. Cette valeur est facultative. Si vous n'indiquez pas la région, vous pouvez la sélectionner dans la liste dans la sortie.

Pour la liste des régions disponibles, consultez la rubrique [régions et emplacements](cs_regions.html) ou utilisez la commande `bx cs regions` [](#cs_regions).</dd></dl>

**Exemple** :

```
bx cs region-set eu-central
```
{: pre}

```
bx cs region-set
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

### bx cs regions
{: #cs_regions}

Répertorie les régions disponibles. La zone `Region Name` indique le nom du {{site.data.keyword.containershort_notm}} et la zone `Region Alias` est le nom {{site.data.keyword.Bluemix_notm}} général pour la région.

**Exemple** :

```
bx cs regions
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

### bx cs subnets
{: #cs_subnets}

Affiches la liste des sous-réseaux disponibles dans un compte d'infrastructure IBM Cloud (SoftLayer).

<strong>Options de commande</strong> :

   Aucune

**Exemple** :

  ```
  bx cs subnets
  ```
  {: pre}


### bx cs vlans LOCATION
{: #cs_vlans}

Répertoriez les VLAN publics et privés disponibles pour un emplacement dans votre compte d'infrastructure IBM Cloud (SoftLayer). Pour répertorier ces réseaux, vous devez disposer d'un compte payant.

<strong>Options de commande</strong> :

   <dl>
   <dt><code><em>LOCATION</em></code></dt>
   <dd>Indiquez l'emplacement où répertorier vos VLAN privés et publics. Cette valeur est obligatoire. Passez en revue les [emplacements disponibles](cs_regions.html#locations).</dd>
   </dl>

**Exemple** :

  ```
  bx cs vlans dal10
  ```
  {: pre}


### bx cs webhook-create --cluster CLUSTER --level LEVEL --type slack --URL URL
{: #cs_webhook_create}

Créez des webhooks.

<strong>Options de commande</strong> :

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>

   <dt><code>--level <em>LEVEL</em></code></dt>
   <dd>Niveau de notification, tel que <code>Normal</code> ou <code>Warning</code>. <code>Warning</code> est la valeur par défaut. Cette valeur est facultative.</dd>

   <dt><code>--type <em>slack</em></code></dt>
   <dd>Type de webhook, tel que slack. Seul le type slack est pris en charge. Cette valeur est obligatoire.</dd>

   <dt><code>--URL <em>URL</em></code></dt>
   <dd>URL du webhook. Cette valeur est obligatoire.</dd>
   </dl>

**Exemple** :

  ```
  bx cs webhook-create --cluster my_cluster --level Normal --type slack --URL http://github.com/<mywebhook>
  ```
  {: pre}


### bx cs worker-add --cluster CLUSTER [--file FILE_LOCATION][--hardware HARDWARE] --machine-type MACHINE_TYPE --number NUMBER --private-vlan PRIVATE_VLAN --public-vlan PUBLIC_VLAN [--disable-disk-encrypt]
{: #cs_worker_add}

Ajoutez des noeuds d'agent à votre cluster standard.

<strong>Options de commande</strong> :

<dl>
<dt><code>--cluster <em>CLUSTER</em></code></dt>
<dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>

<dt><code>--file <em>FILE_LOCATION</em></code></dt>
<dd>Chemin d'accès au fichier YAML pour ajouter des noeuds d'agent à votre cluster. Au lieu de définir les caractéristiques de vos noeuds d'agent supplémentaires à l'aide des options fournies dans cette commande, vous pouvez utiliser un fichier YAML. Cette valeur est facultative.

<p><strong>Remarque :</strong> si vous indiquez la même option dans la commande comme paramètre dans le fichier YAML, la valeur de l'option de la commande est prioritaire sur la valeur définie dans le fichier YAML. Par exemple, si vous définissez un type de machine dans votre fichier YAML et que vous utilisez l'option --machine-type dans la commande, la valeur que vous avez entrée dans l'option de commande se substitue à la valeur définie dans le fichier YAML.

<pre class="codeblock">
<code>name: <em>&lt;cluster_name_or_id&gt;</em>
location: <em>&lt;location&gt;</em>
machine-type: <em>&lt;machine_type&gt;</em>
private-vlan: <em>&lt;private_vlan&gt;</em>
public-vlan: <em>&lt;public_vlan&gt;</em>
hardware: <em>&lt;shared_or_dedicated&gt;</em>
workerNum: <em>&lt;number_workers&gt;</em>
</code></pre>

<table>
<caption>Tableau 2. Description des composants du fichier YAML</caption>
<thead>
<th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
</thead>
<tbody>
<tr>
<td><code><em>name</em></code></td>
<td>Remplacez <code><em>&lt;cluster_name_or_id&gt;</em></code> par le nom ou l'ID du cluster sur lequel vous souhaitez ajouter des noeuds d'agent.</td>
</tr>
<tr>
<td><code><em>location</em></code></td>
<td>Remplacez <code><em>&lt;location&gt;</em></code> par l'emplacement où vous souhaitez déployer vos noeuds d'agent. Les emplacements disponibles dépendent de la région à laquelle vous êtes connecté. Pour afficher la liste des emplacements disponibles, exécutez la commande <code>bx cs locations</code>.</td>
</tr>
<tr>
<td><code><em>machine-type</em></code></td>
<td>Remplacez <code><em>&lt;machine_type&gt;</em></code> par le type de machine souhaité pour vos noeuds d'agent. Pour afficher la liste des types de machine disponibles pour votre emplacement, exécutez la commande <code>bx cs machine-types <em>&lt;location&gt;</em></code>.</td>
</tr>
<tr>
<td><code><em>private-vlan</em></code></td>
<td>Remplacez <code><em>&lt;private_vlan&gt;</em></code> par l'ID du réseau local virtuel privé que vous souhaitez utiliser pour vos noeuds d'agent. Pour afficher la liste des réseaux locaux virtuels disponibles, exécutez la commande <code>bx cs vlans <em>&lt;location&gt;</em></code> et recherchez les routeurs VLAN débutant par <code>bcr</code> (routeur dorsal).</td>
</tr>
<tr>
<td><code>public-vlan</code></td>
<td>Remplacez <code>&lt;public_vlan&gt;</code> par l'ID du réseau local virtuel public que vous souhaitez utiliser pour vos noeuds d'agent. Pour afficher la liste des réseaux locaux virtuels disponibles, exécutez la commande <code>bx cs vlans &lt;location&gt;</code> et recherchez les routeurs VLAN débutant par <code>fcr</code> (routeur frontal).</td>
</tr>
<tr>
<td><code>hardware</code></td>
<td>Niveau d'isolation du matériel pour votre noeud worker. Utilisez un cluster dédié si vous désirez que toutes les ressources physiques vous soient dédiées exclusivement ou un cluster partagé pour permettre leur partage avec d'autres clients IBM. La valeur par défaut est shared.</td>
</tr>
<tr>
<td><code>workerNum</code></td>
<td>Remplacez <code><em>&lt;number_workers&gt;</em></code> par le nombre de noeuds d'agent que vous souhaitez déployer.</td>
</tr>
<tr>
<td><code>diskEncryption: <em>false</em></code></td>
<td>Les noeuds Worker exploitent par défaut le chiffrement de disque ; [En savoir plus](cs_secure.html#worker). Pour désactiver le chiffrement, incluez cette option en lui attribuant la valeur <code>false</code>.</td></tr>
</tbody></table></p></dd>

<dt><code>--hardware <em>HARDWARE</em></code></dt>
<dd>Niveau d'isolation du matériel pour votre noeud worker. Utilisez un cluster dédié si vous désirez que toutes les ressources physiques vous soient dédiées exclusivement ou un cluster partagé pour permettre leur partage avec d'autres clients IBM. La valeur par défaut est shared. Cette valeur est facultative.</dd>

<dt><code>--machine-type <em>MACHINE_TYPE</em></code></dt>
<dd>Le type de machine choisi a une incidence sur la quantité de mémoire et l'espace disque disponible pour les conteneurs déployés sur votre noeud worker. Cette valeur est obligatoire. Pour afficher la liste des types de machine disponibles, exécutez la commande [bx cs machine-types LOCATION](#cs_machine_types).</dd>

<dt><code>--number <em>NUMBER</em></code></dt>
<dd>Entier représentant le nombre de noeuds d'agent à créer dans le cluster. La valeur par défaut est 1. Cette valeur est facultative.</dd>

<dt><code>--private-vlan <em>PRIVATE_VLAN</em></code></dt>
<dd>VLAN privé spécifié lors de la création du cluster. Cette valeur est obligatoire.

<p><strong>Remarque :</strong> Les VLAN publics et privés que vous indiquez doivent correspondre. Les routeurs de VLAN privé commencent toujours par <code>bcr</code> (routeur dorsal) et les routeurs de VLAN public par <code>fcr</code> (routeur frontal). Le numéro et la combinaison de lettres après ces préfixes doivent correspondre pour pouvoir utiliser ces réseaux locaux virtuels lors de la création d'un cluster. N'utilisez pas de réseaux locaux virtuels publics et privés qui ne correspondent pas pour créer un cluster.</p></dd>

<dt><code>--public-vlan <em>PUBLIC_VLAN</em></code></dt>
<dd>VLAN public spécifié lors de la création du cluster. Cette valeur est facultative.

<p><strong>Remarque :</strong> Les VLAN publics et privés que vous indiquez doivent correspondre. Les routeurs de VLAN privé commencent toujours par <code>bcr</code> (routeur dorsal) et les routeurs de VLAN public par <code>fcr</code> (routeur frontal). Le numéro et la combinaison de lettres après ces préfixes doivent correspondre pour pouvoir utiliser ces réseaux locaux virtuels lors de la création d'un cluster. N'utilisez pas de réseaux locaux virtuels publics et privés qui ne correspondent pas pour créer un cluster.</p></dd>

<dt><code>--disable-disk-encrypt</code></dt>
<dd>Les noeuds Worker exploitent par défaut le chiffrement de disque ; [En savoir plus](cs_secure.html#worker). Pour désactiver le chiffrement, incluez cette option.</dd>
</dl>

**Exemples** :

  ```
  bx cs worker-add --cluster my_cluster --number 3 --public-vlan my_public_vlan_id --private-vlan my_private_vlan_id --machine-type u2c.2x4 --hardware shared
  ```
  {: pre}

  Exemple pour {{site.data.keyword.Bluemix_dedicated_notm}}:

  ```
  bx cs worker-add --cluster my_cluster --number 3 --machine-type u2c.2x4
  ```
  {: pre}


### bx cs worker-get [CLUSTER_NAME_OR_ID] WORKER_NODE_ID
{: #cs_worker_get}

Affichez les informations détaillées d'un noeud worker.

<strong>Options de commande</strong> :

   <dl>
   <dt><code><em>CLUSTER_NAME_OR_ID</em></code></dt>
   <dd>Nom ou ID du cluster du noeud worker. Cette valeur est facultative.</dd>
   <dt><code><em>WORKER_NODE_ID</em></code></dt>
   <dd>ID d'un noeud worker. Exécutez la commande <code>bx cs workers <em>CLUSTER</em></code> pour afficher les ID des noeuds d'agent dans un cluster. Cette valeur est obligatoire.</dd>
   </dl>

**Exemple** :

  ```
  bx cs worker-get [CLUSTER_NAME_OR_ID] WORKER_NODE_ID
  ```
  {: pre}


### bx cs worker-reboot [-f][--hard] CLUSTER WORKER [WORKER]
{: #cs_worker_reboot}

Redémarrez les noeuds d'agent d'un cluster. Si un problème affecte un noeud worker, essayez d'abord de réamorcer celui-ci, ce qui a pour effet de redémarrer le noeud worker. Si le réamorçage ne résout pas le problème, essayez alors la commande `worker-reload`. L'état des agents ne change pas pendant le réamorçage. L'état continue à indiquer `deployed` (déployé), mais le statut de l'agent est mis à jour.

<strong>Options de commande</strong> :

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>

   <dt><code>-f</code></dt>
   <dd>Utilisez cette option pour forcer le redémarrage du noeud worker sans invites utilisateur. Cette valeur est facultative.</dd>

   <dt><code>--hard</code></dt>
   <dd>Utilisez cette option pour forcer un redémarrage à froid d'un noeud worker en coupant son alimentation. Utilisez cette option si le noeud worker ne répond plus ou connaît un blocage Docker. Cette valeur est facultative.</dd>

   <dt><code><em>WORKER</em></code></dt>
   <dd>Nom ou ID d'un ou de plusieurs noeuds d'agent. Utilisez un espace pour répertorier plusieurs noeuds d'agent. Cette valeur est obligatoire.</dd>
   </dl>

**Exemple** :

  ```
  bx cs worker-reboot my_cluster my_node1 my_node2
  ```
  {: pre}


### bx cs worker-reload [-f] CLUSTER WORKER [WORKER]
{: #cs_worker_reload}

Rechargez les noeuds d'agent d'un cluster. Si un problème affecte un noeud worker, essayez d'abord de le réamorcer. Si le réamorçage ne résout pas le problème, essayez alors la commande `worker-reload`, laquelle recharge toutes les configurations requises pour le noeud worker.

<strong>Options de commande</strong> :

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>

   <dt><code>-f</code></dt>
   <dd>Utilisez cette option pour forcer le rechargement d'un noeud worker sans invites utilisateur. Cette valeur est facultative.</dd>

   <dt><code><em>WORKER</em></code></dt>
   <dd>Nom ou ID d'un ou de plusieurs noeuds d'agent. Utilisez un espace pour répertorier plusieurs noeuds d'agent. Cette valeur est obligatoire.</dd>
   </dl>

**Exemple** :

  ```
  bx cs worker-reload my_cluster my_node1 my_node2
  ```
  {: pre}

### bx cs worker-rm [-f] CLUSTER WORKER [WORKER]
{: #cs_worker_rm}

Supprimez un ou plusieurs noeuds d'agent d'un cluster.

<strong>Options de commande</strong> :

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>

   <dt><code>-f</code></dt>
   <dd>Utilisez cette option pour forcer la suppression d'un noeud worker sans invites utilisateur. Cette valeur est facultative.</dd>

   <dt><code><em>WORKER</em></code></dt>
   <dd>Nom ou ID d'un ou de plusieurs noeuds d'agent. Utilisez un espace pour répertorier plusieurs noeuds d'agent. Cette valeur est obligatoire.</dd>
   </dl>

**Exemple** :

  ```
  bx cs worker-rm my_cluster my_node1 my_node2
  ```
  {: pre}

### bx cs worker-update [-f] CLUSTER WORKER [WORKER][--kube-version MAJOR.MINOR.PATCH] [--force-update]
{: #cs_worker_update}

Mettez à jour des noeuds d'agent à la dernière version Kubernetes. L'exécution de la commande `bx cs worker-update` peut entraîner l'indisponibilité de vos services et applications. Lors de la mise à jour, tous les pods sont replanifiés sur d'autres noeuds d'agent et les données sont supprimées si elles elles ne sont pas stockées hors du pod. Pour éviter le temps d'indisponibilité, assurez-vous que vous avez assez de noeuds d'agent pour gérer votre charge de travail pendant la mise à jour des noeuds d'agent sélectionnés.

Vous pourriez devoir modifier vos fichiers YAML en vue des déploiements avant la mise à jour. Consultez cette [note sur l'édition](cs_versions.html) pour plus de détails.

<strong>Options de commande</strong> :

   <dl>

   <dt><em>CLUSTER</em></dt>
   <dd>Nom ou ID du cluster sur lequel répertorier les noeuds d'agent disponibles. Cette valeur est obligatoire.</dd>

   <dt><code>--kube-version <em>MAJOR.MINOR.PATCH</em></code></dt>
   <dd>Version Kubernetes du cluster. Si cet indicateur n'est pas spécifié, le noeud worker est mis à jour à la version par défaut. Pour connaître les versions disponibles, exécutez la commande [bx cs kube-versions](#cs_kube_versions). Cette valeur est facultative.</dd>

   <dt><code>-f</code></dt>
   <dd>Utilisez cette option pour forcer la mise à jour du maître sans invites utilisateur. Cette valeur est facultative.</dd>

   <dt><code>--force-update</code></dt>
   <dd>Tentative de mise à jour alors que la modification est supérieure à deux niveaux de version mineure. Cette valeur est facultative.</dd>

   <dt><code><em>WORKER</em></code></dt>
   <dd>ID d'un ou de plusieurs noeuds d'agent. Utilisez un espace pour répertorier plusieurs noeuds d'agent. Cette valeur est obligatoire.</dd>
   </dl>

**Exemple** :

  ```
  bx cs worker-update my_cluster my_node1 my_node2
  ```
  {: pre}

### bx cs workers CLUSTER
{: #cs_workers}

Affichez la liste des noeuds d'agent d'un cluster et le statut de chacun d'eux.

<strong>Options de commande</strong> :

   <dl>
   <dt><em>CLUSTER</em></dt>
   <dd>Nom ou ID du cluster sur lequel répertorier les noeuds d'agent disponibles. Cette valeur est obligatoire.</dd>
   </dl>

**Exemple** :

  ```
  bx cs workers mycluster
  ```
  {: pre}

<br />

