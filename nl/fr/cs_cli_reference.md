---

copyright:
  years: 2014, 2017
lastupdated: "2017-10-24"

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

**Astuce :** vous recherchez des commandes `bx cr` ? Consultez la [référence de l'interface CLI {{site.data.keyword.registryshort_notm}}](/docs/cli/plugins/registry/index.html). Vous recherchez des commandes `kubectl` ? Consultez la [documentation Kubernetes![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/user-guide/kubectl/v1.5/).


<!--[https://github.ibm.com/alchemy-containers/armada-cli ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.ibm.com/alchemy-containers/armada-cli)-->

<table summary="Commandes de création de clusters sur {{site.data.keyword.Bluemix_notm}}">
 <thead>
    <th colspan=5>Commandes de création de clusters sur {{site.data.keyword.Bluemix_notm}}</th>
 </thead>
 <tbody>
 <tr>
    <td>[bx cs cluster-config](cs_cli_reference.html#cs_cluster_config)</td>
    <td>[bx cs cluster-create](cs_cli_reference.html#cs_cluster_create)</td>
    <td>[bx cs cluster-get](cs_cli_reference.html#cs_cluster_get)</td>
    <td>[bx cs cluster-rm](cs_cli_reference.html#cs_cluster_rm)</td>
    <td>[bx cs cluster-service-bind](cs_cli_reference.html#cs_cluster_service_bind)</td>
 </tr>
 <tr>
    <td>[bx cs cluster-service-unbind](cs_cli_reference.html#cs_cluster_service_unbind)</td>
    <td>[bx cs cluster-services](cs_cli_reference.html#cs_cluster_services)</td>
    <td>[bx cs cluster-subnet-add](cs_cli_reference.html#cs_cluster_subnet_add)</td>
    <td>[bx cs cluster-subnet-create](cs_cli_reference.html#cs_cluster_subnet_create)</td>
    <td>[bx cs cluster-user-subnet-add](cs_cli_reference.html#cs_cluster_user_subnet_add)</td>
 </tr>
 <tr>
   <td>[bx cs cluster-user-subnet-rm](cs_cli_reference.html#cs_cluster_user_subnet_rm)</td>
   <td>[bx cs cluster-update](cs_cli_reference.html#cs_cluster_update)</td>
   <td>[bx cs clusters](cs_cli_reference.html#cs_clusters)</td>
   <td>[bx cs credentials-set](cs_cli_reference.html#cs_credentials_set)</td>
   <td>[bx cs credentials-unset](cs_cli_reference.html#cs_credentials_unset)</td>
 </tr>
 <tr>
    <td>[bx cs help](cs_cli_reference.html#cs_help)</td>
    <td>[bx cs init](cs_cli_reference.html#cs_init)</td>
    <td>[bx cs locations](cs_cli_reference.html#cs_datacenters)</td>
    <td>[bx cs logging-config-create](cs_cli_reference.html#cs_logging_create)</td>
 </tr>
 <tr>
   <td>[bx cs logging-config-get](cs_cli_reference.html#cs_logging_get)</td>
   <td>[bx cs logging-config-rm](cs_cli_reference.html#cs_logging_rm)</td>
   <td>[bx cs logging-config-update](cs_cli_reference.html#cs_logging_update)</td>
   <td>[bx cs machine-types](cs_cli_reference.html#cs_machine_types)</td>
   <td>[bx cs subnets](cs_cli_reference.html#cs_subnets)</td>
 </tr>
 <tr>
   <td>[bx cs vlans](cs_cli_reference.html#cs_vlans)</td>
   <td>[bx cs webhook-create](cs_cli_reference.html#cs_webhook_create)</td>
   <td>[bx cs worker-add](cs_cli_reference.html#cs_worker_add)</td>
   <td>[bx cs worker-rm](cs_cli_reference.html#cs_worker_rm)</td>
   <td>[bx cs worker-update](cs_cli_reference.html#cs_worker_update)</td>
 </tr>
 <tr>
    <td>[bx cs workers](cs_cli_reference.html#cs_workers)</td>
    <td>[bx cs worker-get](cs_cli_reference.html#cs_worker_get)</td>
    <td>[bx cs worker-reboot](cs_cli_reference.html#cs_worker_reboot)</td>
    <td>[bx cs worker-reload](cs_cli_reference.html#cs_worker_reload)</td>
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



### bx cs cluster-create [--file FILE_LOCATION][--hardware HARDWARE] --location LOCATION --machine-type MACHINE_TYPE --name NAME [--no-subnet][--private-vlan PRIVATE_VLAN] [--public-vlan PUBLIC_VLAN][--workers WORKER]
{: #cs_cluster_create}

Permet de créer un cluster dans votre organisation.

<strong>Options de commande</strong>

<dl>
<dt><code>--file <em>FILE_LOCATION</em></code></dt>

<dd>Chemin d'accès au fichier YAML pour créer votre cluster standard. Au lieu de définir les caractéristiques de votre cluster à l'aide des options fournies dans cette commande, vous pouvez utiliser un fichier YAML.  Cette valeur est facultative pour les clusters standard et n'est pas disponible pour les clusters légers.

<p><strong>Remarque :</strong> si vous indiquez la même option dans la commande comme paramètre dans le fichier YAML, la valeur de l'option de la commande est prioritaire sur la valeur définie dans le fichier YAML. Par exemple, si vous indiquez un emplacement dans votre fichier YAML et utilisez l'option <code>--location</code> dans la commande, la valeur que vous avez entrée dans l'option de commande se substitue à la valeur définie dans le fichier YAML.

<pre class="codeblock">
<code>name: <em>&lt;cluster_name&gt;</em>
location: <em>&lt;location&gt;</em>
machine-type: <em>&lt;machine_type&gt;</em>
private-vlan: <em>&lt;private_vlan&gt;</em>
public-vlan: <em>&lt;public_vlan&gt;</em>
hardware: <em>&lt;shared_or_dedicated&gt;</em>
workerNum: <em>&lt;number_workers&gt;</em></code></pre>


<table>
    <caption>Tableau 1. Description des composants du fichier YAML</caption>
    <thead>
    <th colspan=2><img src="images/idea.png"/> Description des composants du fichier YAML</th>
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
     <td>Niveau d'isolation du matériel pour votre noeud d'agent. Utilisez un cluster dédié si vous désirez que toutes les ressources physiques vous soient dédiées exclusivement ou un cluster partagé pour permettre leur partage avec d'autres clients IBM. La valeur par défaut est <code>shared</code> (partagé).</td>
     </tr>
     <tr>
     <td><code><em>workerNum</em></code></td>
     <td>Remplacez <code><em>&lt;number_workers&gt;</em></code> par le nombre de noeuds d'agent que vous souhaitez déployer.</td>
     </tr>
     </tbody></table>
    </p></dd>

<dt><code>--hardware <em>HARDWARE</em></code></dt>
<dd>Niveau d'isolation du matériel pour votre noeud d'agent. Utilisez dedicated pour que toutes les ressources physiques vous soient dédiées exclusivement ou shared pour permettre leur partage avec d'autres clients IBM. La valeur par défaut est shared.  Cette valeur est facultative pour les clusters standard et n'est pas disponible pour les clusters légers.</dd>

<dt><code>--location <em>LOCATION</em></code></dt>
<dd>Emplacement sous lequel vous désirez créer le cluster. Les emplacements disponibles dépendent de la région
{{site.data.keyword.Bluemix_notm}} à laquelle vous vous êtes connecté. Pour des performances optimales, sélectionnez la région physiquement la plus proche.  Cette valeur est obligatoire pour les clusters standard et facultative pour les clusters légers.

<p>Passez en revue les [emplacements disponibles](cs_regions.html#locations).
</p>

<p><strong>Remarque :</strong> si vous sélectionnez un emplacement à l'étranger,
il se peut que vous ayez besoin d'une autorisation des autorités pour stocker physiquement les données dans un autre pays.</p>
</dd>

<dt><code>--machine-type <em>MACHINE_TYPE</em></code></dt>
<dd>Le type de machine choisi a une incidence sur la quantité de mémoire et l'espace disque disponible pour les conteneurs déployés sur votre noeud d'agent. Pour afficher la liste des types de machine disponibles, exécutez la commande [bx cs machine-types <em>LOCATION</em>](cs_cli_reference.html#cs_machine_types).  Cette valeur est obligatoire pour les clusters standard et n'est pas disponible pour les clusters légers.</dd>

<dt><code>--name <em>NAME</em></code></dt>
<dd>Nom du cluster.  Cette valeur est obligatoire.</dd>

<dt><code>--no-subnet</code></dt>
<dd>Incluez l'indicateur pour créer un cluster sans sous-réseau portable. La valeur par défaut consiste à ne pas utiliser l'indicateur et à créer un sous-réseau dans votre portefeuille IBM Bluemix Infrastructure (SoftLayer). Cette valeur est facultative.</dd>

<dt><code>--private-vlan <em>PRIVATE_VLAN</em></code></dt>
<dd>

<ul>
<li>Ce paramètre n'est pas disponible pour les clusters légers.</li>
<li>S'il s'agit du premier cluster standard que vous créez à cet emplacement, n'incluez pas cet indicateur. Un VLAN privé est créé pour vous lorsque le cluster est créé.</li>
<li>Si vous avez créé un cluster standard auparavant dans cet emplacement ou créé un VLAN privé dans IBM Bluemix Infrastructure (SoftLayer), vous devez spécifier ce VLAN privé.

<p><strong>Remarque</strong> : le VLAN public et le VLAN privé que vous spécifiez à l'aide de la commande create doivent correspondre. Les routeurs de VLAN privé
commencent toujours par <code>bcr</code> (routeur dorsal) et les routeurs de VLAN public par
<code>fcr</code> (routeur frontal). Le numéro et la combinaison de lettres après ces préfixes doivent correspondre pour pouvoir utiliser ces réseaux locaux virtuels lors de la création d'un cluster. N'utilisez pas de réseaux locaux virtuels publics et privés qui ne correspondent pas pour créer un cluster.</p></li>
</ul>

<p>Pour déterminer si vous disposez déjà d'un VLAN privé pour un emplacement spécifique ou pour identifier le nom d'un VLAN privé existant, exécutez la commande <code>bx cs vlans <em>&lt;location&gt;</em></code>.</p></dd>

<dt><code>--public-vlan <em>PUBLIC_VLAN</em></code></dt>
<dd>
<ul>
<li>Ce paramètre n'est pas disponible pour les clusters légers.</li>
<li>S'il s'agit du premier cluster standard que vous créez à cet emplacement, n'utilisez pas cet indicateur. Un VLAN public est créé pour vous lorsque le cluster est créé.</li>
<li>Si vous avez créé un cluster standard auparavant dans cet emplacement ou créé un VLAN public dans IBM Bluemix Infrastructure (SoftLayer), vous devez spécifier ce VLAN public.

<p><strong>Remarque</strong> : le VLAN public et le VLAN privé que vous spécifiez à l'aide de la commande create doivent correspondre. Les routeurs de VLAN privé
commencent toujours par <code>bcr</code> (routeur dorsal) et les routeurs de VLAN public par
<code>fcr</code> (routeur frontal). Le numéro et la combinaison de lettres après ces préfixes doivent correspondre pour pouvoir utiliser ces réseaux locaux virtuels lors de la création d'un cluster. N'utilisez pas de réseaux locaux virtuels publics et privés qui ne correspondent pas pour créer un cluster.</p></li>
</ul>

<p>Pour déterminer si vous disposez déjà d'un VLAN public pour un emplacement spécifique ou pour identifier le nom d'un VLAN public existant, exécutez la commande <code>bx cs vlans <em>&lt;location&gt;</em></code>.</p></dd>

<dt><code>--workers WORKER</code></dt>
<dd>Nombre de noeuds d'agent que vous désirez déployer dans votre cluster. Si vous ne spécifiez pas cette
option, un cluster avec 1 noeud d'agent est créé. Cette valeur est facultative pour les clusters standard et n'est pas disponible pour les clusters légers.

<p><strong>Remarque :</strong> A chaque noeud d'agent sont affectés un ID de noeud d'agent unique et un nom de domaine qui ne doivent pas être modifiés manuellement après la création du cluster. La modification de l'ID ou du domaine empêcherait le maître
Kubernetes de gérer votre cluster.</p></dd>
</dl>

**Exemples** :

  

  Exemple pour un cluster standard :
  {: #example_cluster_create}

  ```
  bx cs cluster-create --location dal10 --public-vlan my_public_vlan_id --private-vlan my_private_vlan_id --machine-type u1c.2x4 --name my_cluster --hardware shared --workers 2
  ```
  {: pre}

  Exemple pour un cluster léger :

  ```
  bx cs cluster-create --name my_cluster
  ```
  {: pre}

  Exemple pour un environnement {{site.data.keyword.Bluemix_notm}}
Dedicated :

  ```
  bx cs cluster-create --machine-type machine-type --workers number --name cluster_name
  ```
  {: pre}


### bx cs cluster-get CLUSTER [--showResources]
{: #cs_cluster_get}

Affiche des informations sur un cluster dans votre organisation.

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

Supprime un cluster de votre organisation.

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

Ajoute un service {{site.data.keyword.Bluemix_notm}} à un cluster.

**Astuce :** dans le cas d'utilisateurs de {{site.data.keyword.Bluemix_notm}} Dedicated, voir [Ajout de services {{site.data.keyword.Bluemix_notm}} à des clusters dans {{site.data.keyword.Bluemix_notm}} Dedicated (version bêta fermée)](cs_cluster.html#binding_dedicated).

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

Supprime un service {{site.data.keyword.Bluemix_notm}} d'un
cluster.

**Remarque :** lorsque vous retirez un service {{site.data.keyword.Bluemix_notm}}, ses données d'identification du service sont retirées du cluster. Si un pod utilise encore ce service, son opération échoue vu que les données d'identification du service sont introuvables.

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

Répertorie les services liés à un ou à tous les espaces de nom Kubernetes dans un cluster. Si aucune option n'est spécifiée, les services pour l'espace de nom par défaut sont affichés.

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

Rend un sous-réseau d'un compte IBM Bluemix Infrastructure (SoftLayer) disponible pour le cluster spécifié.

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

Créez un sous-réseau dans un compte IBM Bluemix Infrastructure (SoftLayer) et rendez-le disponible pour le cluster spécifié dans {{site.data.keyword.containershort_notm}}.

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

Ce sous-réseau privé n'est pas celui qui est fourni par IBM Bluemix Infrastructure (SoftLayer). De ce fait, vous devez configurer tout routage de trafic entrant et sortant pour le sous-réseau. Pour ajouter un sous-réseau IBM Bluemix Infrastructure (SoftLayer), utilisez la [commande](#cs_cluster_subnet_add) `bx cs cluster-subnet-add`.

**Remarque** : lorsque vous ajoutez un sous-réseau utilisateur privé à un cluster, les adresses IP de ce sous-réseau sont utilisées pour les équilibreurs de charge privés figurant dans le cluster. Pour éviter des conflits d'adresse IP, prenez soin de n'utiliser le sous-réseau qu'avec un seul cluster. N'utilisez pas en même temps un sous-réseau pour plusieurs clusters ou à d'autres fins hors d'{{site.data.keyword.containershort_notm}}.

<strong>Options de commande</strong> :

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>

   <dt><code><em>SUBNET_CIDR</em></code></dt>
   <dd>CIDR (Classless InterDomain Routing) du sous-réseau. Cette valeur est obligatoire et ne doit pas entrer en conflit avec un sous-réseau utilisé par IBM Bluemix Infrastructure (SoftLayer).

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


### bx cs cluster-update [-f] CLUSTER
{: #cs_cluster_update}

Mettez à jour le maître Kubernetes à la dernière version de l'API. Pendant la mise à jour, vous ne pouvez ni accéder au cluster, ni le modifier. Les noeuds d'agent, applis et ressources qui ont été déployés par l'utilisateur ne sont pas modifiés et poursuivront leur exécution.

Vous pourriez devoir modifier vos fichiers YAML en vue de déploiements ultérieurs. Consultez cette [note sur l'édition](cs_versions.html) pour plus de détails.

<strong>Options de commande</strong> :

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>

   <dt><code>-f</code></dt>
   <dd>Utilisez cette option pour forcer la mise à jour d'un maître sans invites utilisateur. Cette valeur est facultative.</dd>
   </dl>

**Exemple** :

  ```
  bx cs cluster-update my_cluster
  ```
  {: pre}

### bx cs clusters
{: #cs_clusters}

Affiche la liste des clusters dans votre organisation.

<strong>Options de commande</strong> :

  Aucune

**Exemple** :

  ```
  bx cs clusters
  ```
  {: pre}


### bx cs credentials-set --infrastructure-api-key API_KEY --infrastructure-username USERNAME
{: #cs_credentials_set}

Définissez les données d'identification du compte IBM Bluemix Infrastructure (SoftLayer) pour votre compte {{site.data.keyword.Bluemix_notm}}. Elles vous permettront d'accéder au portefeuille IBM Bluemix Infrastructure (SoftLayer) via votre compte {{site.data.keyword.Bluemix_notm}}.

**Remarque :** ne définissez pas plusieurs données d'identification pour un compte {{site.data.keyword.Bluemix_notm}}. Tout compte {{site.data.keyword.Bluemix_notm}} est lié à un seul portefeuille IBM Bluemix Infrastructure (SoftLayer).

<strong>Options de commande</strong> :

   <dl>
   <dt><code>--infrastructure-username <em>USERNAME</em></code></dt>
   <dd>Nom d'utilisateur du compte IBM Bluemix Infrastructure (SoftLayer). Cette valeur est obligatoire.</dd>
   </dl>

   <dt><code>--infrastructure-api-key <em>API_KEY</em></code></dt>
   <dd>Clé d'API du compte IBM Bluemix Infrastructure (SoftLayer). Cette valeur est obligatoire.

 <p>
  Pour générer une clé d'API, procédez comme suit :

  <ol>
  <li>Connectez-vous au [portail IBM Bluemix Infrastructure (SoftLayer) ![External link icon](../icons/launch-glyph.svg "External link icon")](https://control.softlayer.com/).</li>
  <li>Sélectionnez <strong>Compte</strong>, puis <strong>Utilisateurs</strong>.</li>
  <li>Cliquez sur <strong>Générer</strong> pour générer une clé d'API IBM Bluemix Infrastructure (SoftLayer) pour votre compte.</li>
  <li>Copiez la clé d'API à utiliser dans cette commande.</li>
  </ol>

  Pour afficher votre clé d'API existante, procédez comme suit :
  <ol>
  <li>Connectez-vous au [portail IBM Bluemix Infrastructure (SoftLayer) ![External link icon](../icons/launch-glyph.svg "External link icon")](https://control.softlayer.com/).</li>
  <li>Sélectionnez <strong>Compte</strong>, puis <strong>Utilisateurs</strong>.</li>
  <li>Cliquez sur <strong>Afficher</strong> pour afficher votre clé d'API existante.</li>
  <li>Copiez la clé d'API à utiliser dans cette commande.</li>
  </ol></p></dd>

**Exemple** :

  ```
  bx cs credentials-set --infrastructure-api-key API_KEY --infrastructure-username USERNAME
  ```
  {: pre}


### bx cs credentials-unset
{: #cs_credentials_unset}

Supprimez les données d'identification du compte IBM Bluemix Infrastructure (SoftLayer) de votre compte {{site.data.keyword.Bluemix_notm}}. Une fois les données d'identification supprimées, vous ne pouvez plus accéder au portefeuille IBM Bluemix Infrastructure (SoftLayer) via votre compte {{site.data.keyword.Bluemix_notm}}.

<strong>Options de commande</strong> :

   Aucune

**Exemple** :

  ```
  bx cs credentials-unset
  ```
  {: pre}



### bx cs help
{: #cs_help}

Affiche la liste des commandes et des paramètres pris en charge.

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
   <dd>Noeud final d'API {{site.data.keyword.containershort_notm}} que vous désirez utiliser. Cette valeur est facultative. Exemples :

    <ul>
    <li>Sud des Etats-Unis :

    <pre class="codeblock">
    <code>bx cs init --host https://us-south.containers.bluemix.net</code>
    </pre></li>

    <li>Est des Etats-Unis :

    <pre class="codeblock">
    <code>bx cs init --host https://us-east.containers.bluemix.net</code>
    </pre>
    <p><strong>Remarque</strong> : l'Est des Etats-Unis est disponible uniquement avec les commandes de l'interface CLI.</p></li>

    <li>Sud du Royaume-Uni :

    <pre class="codeblock">
    <code>bx cs init --host https://uk-south.containers.bluemix.net</code>
    </pre></li>

    <li>Europe centrale :

    <pre class="codeblock">
    <code>bx cs init --host https://eu-central.containers.bluemix.net</code>
    </pre></li>

    <li>Asie-Pacifique sud :

    <pre class="codeblock">
    <code>bx cs init --host https://ap-south.containers.bluemix.net</code>
    </pre></li></ul>
</dd>
</dl>





### bx cs locations
{: #cs_datacenters}

Affiche la liste de tous les emplacements disponibles pour créer un cluster.

<strong>Options de commande</strong> :

   Aucune

**Exemple** :

  ```
  bx cs locations
  ```
  {: pre}

### bx cs logging-config-create CLUSTER [--namespace KUBERNETES_NAMESPACE][--logsource LOG_SOURCE] [--hostname LOG_SERVER_HOSTNAME][--port LOG_SERVER_PORT] --type LOG_TYPE
{: #cs_logging_create}

Créez une configuration de journalisation. Par défaut les journaux d'espace de nom sont transférés à {{site.data.keyword.loganalysislong_notm}}. Vous pouvez utiliser cette commande pour transférer les journaux d'espace de nom à un serveur syslog externe. Vous pouvez également utiliser cettecommandepour transférer des journaux d'applications, de noeuds d'agent, de clusters Kubernetes et de contrôleurs Ingress à {{site.data.keyword.loganalysisshort_notm}} ou à un serveur syslog externe.

<strong>Options de commande</strong> :

<dl>
<dt><code><em>CLUSTER</em></code></dt>
<dd>Nom ou ID du cluster. </dd>
<dt><code>--logsource <em>LOG_SOURCE</em></code></dt>
<dd>Source du journal pour laquelle vous voulez activer le transfert de journaux. Les valeurs admises sont : <code>application</code>, <code>worker</code>, <code>kubernetes</code> et <code>ingress</code>. Cette valeur est obligatoire pour les sources de journal autres que les espaces de nom de conteneur Docker.</dd>
<dt><code>--namespace <em>KUBERNETES_NAMESPACE</em></code></dt>
<dd>Espace de nom de conteneur Docker pour lequel vous souhaitez transférer les journaux à syslog. Le tranfert des journaux n'est pas pris en charge pour les espaces de nom Kubernetes <code>ibm-system</code> et <code>kube-system</code>. Cette valeur est obligatoire pour les espaces de nom. Si vous n'indiquez pas d'espace de nom, tous les espaces de nom du conteneur utilisent cette configuration.</dd>
<dt><code>--hostname <em>LOG_SERVER_HOSTNAME</em></code></dt>
<dd>Nom d'hôte ou adresse IP du serveur collecteur de journal. Cette valeur est obligatoire lorsque le type de journalisation est <code>syslog</code>.</dd>
<dt><code>--port <em>LOG_SERVER_PORT</em></code></dt>
<dd>Port du serveur collecteur de journal. Cette valeur est facultative lorsque le type de journalisation est <code>syslog</code>. Si vous n'indiquez pas de port, le port standard <code>514</code> est utilisé pour <code>syslog</code>.</dd>
<dt><code>--type <em>LOG_TYPE</em></code></dt>
<dd>Protocole de transfert de journal que vous souhaitez utiliser. Actuellement, <code>syslog</code> et <code>ibm</code> sont pris en charge. Cette valeur est obligatoire.</dd>
</dl>

**Exemple pour la source de journal `namespace`** :

  ```
  bx cs logging-config-create my_cluster --namespace my_namespace --hostname localhost --port 5514 --type syslog
  ```
  {: pre}

**Exemple pour la source de journal `ingress`** :

  ```
  bx cs logging-config-create my_cluster f4bc77c0-ee7d-422d-aabf-a4e6b977264e --type ibm
  ```
  {: pre}

### bx cs logging-config-get CLUSTER [--logsource LOG_SOURCE]
{: #cs_logging_get}

Affichez toutes les configurations de transfert de journaux d'un cluster ou filtrez les configurations de journalisation en fonction de la source de journal.

<strong>Options de commande</strong> :

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>
   <dt><code>--logsource <em>LOG_SOURCE</em></code></dt>
   <dd>Type de source de journal que vous voulez filtrer. Seules les configurations de journalisation de cette source de journal dans le cluster sont renvoyées. Les valeurs admises sont : <code>namespace</code>, <code>application</code>, <code>worker</code>, <code>kubernetes</code> et <code>ingress</code>. Cette valeur est facultative.</dd>
   </dl>

**Exemple** :

  ```
  bx cs logging-config-get my_cluster --logsource worker
  ```
  {: pre}


### bx cs logging-config-rm CLUSTER [--namespace KUBERNETES_NAMESPACE][--id LOG_SOURCE_LOGGING_ID]
{: #cs_logging_rm}

Supprime une configuation de transfert de journaux. Pour un espace de nom de conteneur Docker, vous pouvez arrêter le transfert de journaux vers un serveur syslog. L'espace de nom continue à transférer les journaux à {{site.data.keyword.loganalysislong_notm}}. Pour une source de journal autre qu'un espace de nom de conteneur Docker, vous pouvez arrêter le transfert des journaux à un serveur syslog ou à {{site.data.keyword.loganalysisshort_notm}}.

<strong>Options de commande</strong> :

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>
   <dt><code>--namespace <em>KUBERNETES_NAMESPACE</em></code></dt>
   <dd>Espace de nom de conteneur Docker pour lequel vous souhaitez arrêter le transfert de journaux à syslog. Cette valeur est obligatoire pour les espaces de nom de conteneur Docker.</dd>
   <dt><code>--id <em>LOG_SOURCE_LOGGING_ID</em></code></dt>
   <dd>ID de configuration de journalisation que vous souhaitez retirer de la source de journal. Cette valeur est obligatoire pour les sources de journal autres que les espaces de nom de conteneur Docker.</dd>
   </dl>

**Exemple** :

  ```
  bx cs logging-config-rm my_cluster --namespace my_namespace
  ```
  {: pre}


### bx cs logging-config-update CLUSTER [--namespace NAMESPACE][--id LOG_SOURCE_LOGGING_ID] [--logsource LOG_SOURCE][--hostname LOG_SERVER_HOSTNAME] [--port LOG_SERVER_PORT] --type LOG_TYPE
{: #cs_logging_update}

Mettez à jour le transfert des journaux au serveur de journalisation que vous souhaitez utiliser. Pour un espace de nom de conteneur Docker, vous pouvez utiliser cette commande pour mettre à jour les caractéristiques du serveur syslog en cours ou changer de serveur syslog. Dans le cas d'une source de journal autre qu'un espace de nom de conteneur Docker, vous pouvez utiliser cette commande pour changer de type de serveur collecteur de journal. Actuellement, les types de journal 'syslog' et 'ibm' sont pris en charge.

<strong>Options de commande</strong> :

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>
   <dt><code>--namespace <em>NAMESPACE</em></code></dt>
   <dd>Espace de nom de conteneur Docker pour lequel vous souhaitez transférer les journaux à syslog. Le transfert des journaux n'est pas pris en charge pour les espaces de nom Kubernetes <code>ibm-system</code> et <code>kube-system</code>. Cette valeur est obligatoire pour les espaces de nom. </dd>
   <dt><code>--logsource <em>LOG_SOURCE</em></code></dt>
   <dd>Source du journal pour laquelle vous voulez mettre à jour le transfert de journaux. Les valeurs admises sont : <code>application</code>, <code>worker</code>, <code>kubernetes</code> et <code>ingress</code>. Cette valeur est obligatoire pour les sources de journal autres que les espaces de nom de conteneur Docker.</dd>
   <dt><code>--id <em>LOG_SOURCE_LOGGING_ID</em></code></dt>
   <dd>ID de configuration de journalisation que vous souhaitez mettre à jour. Cette valeur est obligatoire pour les sources de journal autres que les espaces de nom de conteneur Docker.</dd>
   <dt><code>--hostname <em>LOG_SERVER_HOSTNAME</em></code></dt>
   <dd>Nom d'hôte ou adresse IP du serveur collecteur de journal. Cette valeur est obligatoire lorsque le type de journalisation est <code>syslog</code>.</dd>
   <dt><code>--port <em>LOG_SERVER_PORT</em></code></dt>
   <dd>Port du serveur collecteur de journal. Cette valeur est facultative lorsque le type de journalisation est <code>syslog</code>. Si vous n'indiquez pas de port, le port standard 514 est utilisé pour <code>syslog</code>.</dd>
   <dt><code>--type <em>LOG_TYPE</em></code></dt>
   <dd>Protocole de transfert de journal que vous souhaitez utiliser. Actuellement, <code>syslog</code> et <code>ibm</code> sont pris en charge. Cette valeur est obligatoire.</dd>
   </dl>

**Exemple pour le type de journal `ibm`** :

  ```
  bx cs logging-config-update my_cluster --id f4bc77c0-ee7d-422d-aabf-a4e6b977264e --type ibm
  ```
  {: pre}

**Exemple pour le type de journal `syslog`** :

  ```
  bx cs logging-config-update my_cluster --namespace my_namespace --hostname localhost --port 5514 --type syslog
  ```
  {: pre}

### bx cs machine-types LOCATION
{: #cs_machine_types}

Affichez la liste des types de machine disponibles pour vos noeuds d'agent. Chaque type de machine inclut la quantité d'UC virtuelles, de mémoire et d'espace disque pour chaque noeud d'agent dans le cluster.

<strong>Options de commande</strong> :

   <dl>
   <dt><code><em>LOCATION</em></code></dt>
   <dd>Indiquez l'emplacement où répertorier les types de machine disponibles. Cette valeur est obligatoire. Passez en revue les [emplacements disponibles](cs_regions.html#locations).</dd></dl>

**Exemple** :

  ```
  bx cs machine-types LOCATION
  ```
  {: pre}


### bx cs subnets
{: #cs_subnets}

Affiche la liste des sous-réseaux disponibles dans un compte IBM Bluemix Infrastructure (SoftLayer).

<strong>Options de commande</strong> :

   Aucune

**Exemple** :

  ```
  bx cs subnets
  ```
  {: pre}


### bx cs vlans LOCATION
{: #cs_vlans}

Répertorie les VLAN publics et privés disponibles pour un emplacement dans votre compte IBM Bluemix Infrastructure (SoftLayer). Pour répertorier ces réseaux, vous devez disposer d'un compte payant.

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

Crée des webhooks.

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


### bx cs worker-add --cluster CLUSTER [--file FILE_LOCATION][--hardware HARDWARE] --machine-type MACHINE_TYPE --number NUMBER --private-vlan PRIVATE_VLAN --public-vlan PUBLIC_VLAN
{: #cs_worker_add}

Ajout de noeuds d'agent à votre cluster standard.

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
workerNum: <em>&lt;number_workers&gt;</em></code></pre>

<table>
<caption>Tableau 2. Description des composants du fichier YAML</caption>
<thead>
<th colspan=2><img src="images/idea.png"/> Description des composants du fichier YAML</th>
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
<td>Niveau d'isolation du matériel pour votre noeud d'agent. Utilisez un cluster dédié si vous désirez que toutes les ressources physiques vous soient dédiées exclusivement ou un cluster partagé pour permettre leur partage avec d'autres clients IBM. La valeur par défaut est shared.</td>
</tr>
<tr>
<td><code>workerNum</code></td>
<td>Remplacez <code><em>&lt;number_workers&gt;</em></code> par le nombre de noeuds d'agent que vous souhaitez déployer.</td>
</tr>
</tbody></table></p></dd>

<dt><code>--hardware <em>HARDWARE</em></code></dt>
<dd>Niveau d'isolation du matériel pour votre noeud d'agent. Utilisez un cluster dédié si vous désirez que toutes les ressources physiques vous soient dédiées exclusivement ou un cluster partagé pour permettre leur partage avec d'autres clients IBM. La valeur par défaut est shared. Cette valeur est facultative.</dd>

<dt><code>--machine-type <em>MACHINE_TYPE</em></code></dt>
<dd>Le type de machine choisi a une incidence sur la quantité de mémoire et l'espace disque disponible pour les conteneurs déployés sur votre noeud d'agent. Cette valeur est obligatoire. Pour afficher la liste des types de machine disponibles, exécutez la commande [bx cs machine-types LOCATION](cs_cli_reference.html#cs_machine_types).</dd>

<dt><code>--number <em>NUMBER</em></code></dt>
<dd>Entier représentant le nombre de noeuds d'agent à créer dans le cluster. La valeur par défaut est 1. Cette valeur est facultative.</dd>

<dt><code>--private-vlan <em>PRIVATE_VLAN</em></code></dt>
<dd>VLAN privé spécifié lors de la création du cluster. Cette valeur est obligatoire.

<p><strong>Remarque :</strong> Les VLAN publics et privés que vous indiquez doivent correspondre. Les routeurs de VLAN privé commencent toujours par <code>bcr</code> (routeur dorsal) et les routeurs de VLAN public par <code>fcr</code> (routeur frontal). Le numéro et la combinaison de lettres après ces préfixes doivent correspondre pour pouvoir utiliser ces réseaux locaux virtuels lors de la création d'un cluster. N'utilisez pas de réseaux locaux virtuels publics et privés qui ne correspondent pas pour créer un cluster.</p></dd>

<dt><code>--public-vlan <em>PUBLIC_VLAN</em></code></dt>
<dd>VLAN public spécifié lors de la création du cluster. Cette valeur est facultative.

<p><strong>Remarque :</strong> Les VLAN publics et privés que vous indiquez doivent correspondre. Les routeurs de VLAN privé commencent toujours par <code>bcr</code> (routeur dorsal) et les routeurs de VLAN public par <code>fcr</code> (routeur frontal). Le numéro et la combinaison de lettres après ces préfixes doivent correspondre pour pouvoir utiliser ces réseaux locaux virtuels lors de la création d'un cluster. N'utilisez pas de réseaux locaux virtuels publics et privés qui ne correspondent pas pour créer un cluster.</p></dd>
</dl>

**Exemples** :

  ```
  bx cs worker-add --cluster my_cluster --number 3 --public-vlan my_public_vlan_id --private-vlan my_private_vlan_id --machine-type u1c.2x4 --hardware shared
  ```
  {: pre}

  Exemple pour {{site.data.keyword.Bluemix_notm}} Dedicated :

  ```
  bx cs worker-add --cluster my_cluster --number 3 --machine-type u1c.2x4
  ```
  {: pre}


### bx cs worker-get WORKER_NODE_ID
{: #cs_worker_get}

Affichez les informations détaillées d'un noeud d'agent.

<strong>Options de commande</strong> :

   <dl>
   <dt><code><em>WORKER_NODE_ID</em></code></dt>
   <dd>ID d'un noeud d'agent. Exécutez la commande <code>bx cs workers <em>CLUSTER</em></code> pour afficher les ID des noeuds d'agent dans un cluster. Cette valeur est obligatoire.</dd>
   </dl>

**Exemple** :

  ```
  bx cs worker-get WORKER_NODE_ID
  ```
  {: pre}


### bx cs worker-reboot [-f][--hard] CLUSTER WORKER [WORKER]
{: #cs_worker_reboot}

Redémarre les noeuds d'agent dans un cluster. Si un problème affecte un noeud d'agent, essayez d'abord de réamorcer celui-ci, ce qui a pour effet de redémarrer le noeud d'agent. Si le réamorçage ne résout pas le problème, essayez alors la commande `worker-reload`. L'état des agents ne change pas pendant le réamorçage. L'état continue à indiquer `deployed` (déployé), mais le statut de l'agent est mis à jour.

<strong>Options de commande</strong> :

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>

   <dt><code>-f</code></dt>
   <dd>Utilisez cette option pour forcer le redémarrage du noeud d'agent sans invites utilisateur. Cette valeur est facultative.</dd>

   <dt><code>--hard</code></dt>
   <dd>Utilisez cette option pour forcer un redémarrage à froid d'un noeud d'agent en coupant son alimentation. Utilisez cette option si le noeud d'agent ne répond plus ou connaît un blocage Docker. Cette valeur est facultative.</dd>

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

Recharge les noeuds d'agent dans un cluster. Si un problème affecte un noeud d'agent, essayez d'abord de le réamorcer. Si le réamorçage ne résout pas le problème, essayez alors la commande `worker-reload`, laquelle recharge toutes les configurations requises pour le noeud d'agent.

<strong>Options de commande</strong> :

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>

   <dt><code>-f</code></dt>
   <dd>Utilisez cette option pour forcer le rechargement d'un noeud d'agent sans invites utilisateur. Cette valeur est facultative.</dd>

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

Supprime un ou plusieurs noeuds d'agent d'un cluster.

<strong>Options de commande</strong> :

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>Nom ou ID du cluster. Cette valeur est obligatoire.</dd>

   <dt><code>-f</code></dt>
   <dd>Utilisez cette option pour forcer la suppression d'un noeud d'agent sans invites utilisateur. Cette valeur est facultative.</dd>

   <dt><code><em>WORKER</em></code></dt>
   <dd>Nom ou ID d'un ou de plusieurs noeuds d'agent. Utilisez un espace pour répertorier plusieurs noeuds d'agent. Cette valeur est obligatoire.</dd>
   </dl>

**Exemple** :

  ```
  bx cs worker-rm my_cluster my_node1 my_node2
  ```
  {: pre}

### bx cs worker-update [-f] CLUSTER WORKER [WORKER]
{: #cs_worker_update}

Met à jour les noeuds d'agent à la dernière version Kubernetes. L'exécution de la commande `bx cs worker-update` peut entraîner l'indisponibilité de vos services et applications. Lors de la mise à jour, tous les pods sont replanifiés sur d'autres noeuds d'agent et les données sont supprimées si elles ne sont pas stockées hors du pod. Pour éviter le temps d'indisponibilité, assurez-vous que vous avez assez de noeuds d'agent pour gérer votre charge de travail pendant la mise à jour des noeuds d'agent sélectionnés.

Vous pourriez devoir modifier vos fichiers YAML en vue des déploiements avant la mise à jour. Consultez cette [note sur l'édition](cs_versions.html) pour plus de détails.

<strong>Options de commande</strong> :

   <dl>

   <dt><em>CLUSTER</em></dt>
   <dd>Nom ou ID du cluster sur lequel répertorier les noeuds d'agent disponibles. Cette valeur est obligatoire.</dd>

   <dt><code>-f</code></dt>
   <dd>Utilisez cette option pour forcer la mise à jour du maître sans invites utilisateur. Cette valeur est facultative.</dd>

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

Affiche la liste des noeuds d'agent dans un cluster et la statut de chacun d'eux.

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


## Etats de cluster
{: #cs_cluster_states}

Vous pouvez visualiser l'état de cluster en cours en exécutant la commande bx cs clusters et en localisant la zone **State**. L'état du cluster vous donne des informations sur la disponibilité et de la capacité du cluster, et sur les problèmes qui se sont éventuellement produits.
{:shortdesc}

|Etat du cluster|Cause|
|-------------|------|
|Deploying|Le maître Kubernetes n'est pas encore complètement déployé. Vous ne pouvez pas accéder à votre cluster.|
|Pending|Le maître Kubernetes est déployé. La mise à disposition des noeuds d'agent est en cours. Ces derniers ne sont pas encore disponibles dans le cluster. Vous pouvez accéder au cluster, mais vous ne pouvez pas déployer d'applications sur le cluster.|
|Normal|Tous les noeuds d'agent d'un cluster sont opérationnels. Vous pouvez accéder au cluster et déployer les applications sur le cluster.|
|Warning|Au moins un noeud d'agent du cluster n'est pas disponible. Cela dit, les autres noeuds d'agent sont disponibles et peuvent prendre le relais pour la charge de travail. <ol><li>Répertoriez les noeuds d'agent présents dans votre cluster et notez l'ID des noeuds d'agent dont l'état indique <strong>Warning</strong>.<pre class="pre"><code>bx cs workers &lt;cluster_name_or_id&gt;</code></pre><li>Affichez les détails relatifs à votre noeud d'agent.<pre class="pre"><code>bx cs worker-get &lt;worker_id&gt;</code></pre><li>Passez en revue les champs <strong>State</strong>, <strong>Status</strong> et <strong>Details</strong> pour identifier la principale cause de l'arrêt du noeud d'agent.</li><li>Si votre noeud d'agent a pratiquement atteint sa limite en termes de mémoire ou d'espace disque, réduisez la charge de travail sur votre noeud d'agent ou ajoutez un noeud d'agent à votre cluster pour contribuer à l'équilibrage de la charge de travail.</li></ol>|
|Critical|Le maître Kubernetes est inaccessible ou tous les noeuds d'agent du cluster sont arrêtés. <ol><li>Affichez la liste des noeuds d'agent présents dans votre cluster.<pre class="pre"><code>bx cs workers &lt;cluster_name_or_id&gt;</code></pre><li>Affichez les détails relatifs à chaque noeud d'agent.<pre class="pre"><code>bx cs worker-get &lt;worker_id&gt;</code></pre></li><li>Passez en revue les champs <strong>State</strong>, <strong>Status</strong> et <strong>Details</strong> pour identifier la principale cause de l'arrêt du noeud d'agent.</li><li>Si l'état du noeud d'agent est <strong>Provision_failed</strong>, vous ne disposez peut-être pas des droits nécessaires pour mettre à disposition un noeud d'agent à partir du portefeuille IBM Bluemix Infrastructure (SoftLayer). Pour identifier les droits nécessaires, voir [Configuration de l'accès au portefeuille IBM Bluemix Infrastucture (SoftLayer) pour créer des clusters Kubernetes standard](cs_planning.html#cs_planning_unify_accounts).</li><li>Si l'état du noeud d'agent est <strong>Critical</strong> et que son statut est <strong>Out of disk</strong>, cela signifie que votre noeud d'agent ne dispose pas de suffisamment de capacité. Vous pouvez réduire la charge de travail sur votre noeud d'agent ou ajouter un noeud d'agent à votre cluster pour contribuer à l'équilibrage de la charge de travail.</li><li>Si l'état du noeud d'agent est <strong>Critical</strong> et que son statut est <strong>Unknown</strong>, cela signifie que le maître Kubernetes est indisponible. Contactez le support {{site.data.keyword.Bluemix_notm}} en ouvrant un [ticket de demande de service {{site.data.keyword.Bluemix_notm}}](/docs/support/index.html#contacting-support).</li></ol>|
{: caption="Tableau 3. Etats de cluster" caption-side="top"}
