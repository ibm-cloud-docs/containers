---

copyright:
  years: 2014, 2017
lastupdated: "2017-08-14"

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

**Astuce :** vous recherchez des commandes `bx cr` ? Consultez la section de [référence sur l'interface de ligne de commande {{site.data.keyword.registryshort_notm}}](/docs/cli/plugins/registry/index.html#containerregcli). Vous recherchez des commandes `kubectl` ? Consultez la [documentation Kubernetes![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/user-guide/kubectl/v1.5/).

 
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
    <td>[bx cs clusters](cs_cli_reference.html#cs_clusters)</td>
    <td>[bx cs credentials-set](cs_cli_reference.html#cs_credentials_set)</td>
 </tr>
 <tr>
   <td>[bx cs credentials-unset](cs_cli_reference.html#cs_credentials_unset)</td>
   <td>[bx cs locations](cs_cli_reference.html#cs_datacenters)</td> 
   <td>[bx cs help](cs_cli_reference.html#cs_help)</td>
   <td>[bx cs init](cs_cli_reference.html#cs_init)</td>
   <td>[bx cs machine-types](cs_cli_reference.html#cs_machine_types)</td>
   </tr>
 <tr>
    <td>[bx cs subnets](cs_cli_reference.html#cs_subnets)</td>
    <td>[bx cs vlans](cs_cli_reference.html#cs_vlans)</td> 
    <td>[bx cs webhook-create](cs_cli_reference.html#cs_webhook_create)</td>
    <td>[bx cs worker-add](cs_cli_reference.html#cs_worker_add)</td>
    <td>[bx cs worker-get](cs_cli_reference.html#cs_worker_get)</td>
    </tr>
 <tr>
   <td>[bx cs worker-reboot](cs_cli_reference.html#cs_worker_reboot)</td>
   <td>[bx cs worker-reload](cs_cli_reference.html#cs_worker_reload)</td> 
   <td>[bx cs worker-rm](cs_cli_reference.html#cs_worker_rm)</td>
   <td>[bx cs workers](cs_cli_reference.html#cs_workers)</td>
   <td></td>
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

### bx cs cluster-config CLUSTER [--admin]
{: #cs_cluster_config}

Après la connexion, téléchargez les données de configuration et les certificats Kubernetes pour vous connecter à votre
cluster et pour exécuter les commandes `kubectl`. Les fichiers sont téléchargés sous `user_home_directory/.bluemix/plugins/container-service/clusters/<cluster_name>`.

**Options de commande** :

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>(Obligatoire) Nom ou ID du cluster.</dd>

   <dt><code>--admin</code></dt>
   <dd>(Facultatif) Téléchargez les fichiers de certificats et d'autorisations pour le rôle rbac Administrateur. Les utilisateurs disposant de ces fichiers peuvent effectuer des actions d'administration sur le cluster (par exemple, le supprimer).</dd>
   </dl>

**Exemples** :

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

<dd>(Facultatif pour les clusters standard. Non disponible pour les clusters légers). Chemin d'accès au fichier YAML pour créer votre cluster standard. Au lieu de définir les caractéristiques de votre cluster à l'aide des options fournies dans cette commande, vous pouvez utiliser un fichier YAML.
<p><strong>Remarque :</strong> si vous indiquez la même option dans la commande comme paramètre dans le fichier YAML, la valeur de l'option de la commande est prioritaire sur la valeur définie dans le fichier YAML. Par exemple, si vous indiquez un emplacement dans votre fichier YAML et utilisez l'option <code>--location</code> dans la commande, la valeur que vous avez entrée dans l'option de commande se substitue à la valeur définie dans le fichier YAML. <pre class="codeblock">
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
     <td>Remplacez <code><em>&lt;private_vlan&gt;</em></code> par l'ID du réseau local virtuel privé que vous souhaitez utiliser pour vos noeuds d'agent. Pour afficher la liste des réseaux locaux virtuels disponibles, exécutez la commande <code>bx cs vlans <em>&lt;location&gt;</em></code> et recherchez les routeurs VLAN débutant par <code>bcr</code> (routeur dorsal). </td> 
     </tr>
     <tr>
     <td><code><em>public-vlan</em></code></td>
     <td>Remplacez <code><em>&lt;public_vlan&gt;</em></code> par l'ID du réseau local virtuel public que vous souhaitez utiliser pour vos noeuds d'agent. Pour afficher la liste des réseaux locaux virtuels disponibles, exécutez la commande <code>bx cs vlans <em>&lt;location&gt;</em></code> et recherchez les routeurs VLAN débutant par <code>fcr</code> (routeur frontal). </td> 
     </tr>
     <tr>
     <td><code><em>hardware</em></code></td>
     <td>Niveau d'isolation du matériel pour votre noeud d'agent. Utilisez un cluster dédié si vous désirez que toutes les ressources physiques vous soient dédiées exclusivement ou un cluster partagé pour permettre leur partage avec d'autres clients IBM. La valeur par défaut est <code>shared</code> (partagé).</td> 
     </tr>
     <tr>
     <td><code><em>workerNum</em></code></td>
     <td>Remplacez <code><em>&lt;number_workers&gt;</em></code> par le nombre de noeuds d'agent que vous souhaitez déployer. </td> 
     </tr>
     </tbody></table>
    </p></dd>
    
<dt><code>--hardware <em>HARDWARE</em></code></dt>
<dd>(Facultatif pour les clusters standard. Non disponible pour les clusters légers). Niveau d'isolation du matériel pour votre noeud d'agent. Utilisez un cluster dédié si vous désirez que toutes les ressources physiques vous soient dédiées exclusivement ou un cluster partagé pour permettre leur partage avec d'autres clients IBM. La valeur par défaut est shared. </dd>

<dt><code>--location <em>LOCATION</em></code></dt>
<dd>(Obligatoire pour les clusters standard. Facultatif pour les clusters légers). Emplacement sous lequel vous désirez créer le cluster. Les emplacements disponibles dépendent de la région
{{site.data.keyword.Bluemix_notm}} à laquelle vous vous êtes connecté. Pour des performances optimales, sélectionnez la région physiquement la plus proche.

<p>Les emplacements disponibles sont les suivants :<ul><li>Sud des Etats-Unis<ul><li>dal10 [Dallas]</li><li>dal12 [Dallas]</li></ul></li><li>Sud du Royaume-Uni<ul><li>lon02 [Londres]</li><li>lon04 [Londres]</li></ul></li><li>Centre Union Européenne<ul><li>ams03 [Amsterdam]</li><li>ra02 [Francfort]</li></ul></li><li>AP-Sud<ul><li>syd01 [Sydney]</li><li>syd04 [Sydney]</li></ul></li></ul>
</p>

<p><strong>Remarque :</strong> si vous sélectionnez un emplacement à l'étranger,
il se peut que vous ayez besoin d'une autorisation des autorités pour stocker physiquement les données dans un autre pays.</p>
</dd>

<dt><code>--machine-type <em>MACHINE_TYPE</em></code></dt>
<dd>(Obligatoire pour les clusters standard. Non disponible pour les clusters légers). Le type de machine choisi a une incidence sur la quantité de mémoire et l'espace disque disponible pour les conteneurs déployés sur votre noeud d'agent. Pour afficher la liste des types de machine disponibles, exécutez la commande[bx cs machine-types <em>LOCATION</em>](cs_cli_reference.html#cs_machine_types).</dd>

<dt><code>--name <em>NAME</em></code></dt>
<dd>(Obligatoire) Nom du cluster.</dd>

<dt><code>--no-subnet</code></dt>
<dd>Incluez l'indicateur pour créer un cluster sans sous-réseau portable. La valeur par défaut consiste à ne pas utiliser l'indicateur et à créer un sous-réseau dans votre portefeuille {{site.data.keyword.BluSoftlayer_full}}.</dd>

<dt><code>--private-vlan <em>PRIVATE_VLAN</em></code></dt>
<dd>(Non disponible pour les clusters légers). <ul>
<li>S'il s'agit du premier cluster que vous créez sous cet emplacement, n'incluez pas cet indicateur. Un
VLAN privé est créé pour vous lorsque le cluster est créé.</li>
<li>Si vous avez créé un cluster auparavant dans cet emplacement ou créé un VLAN privé dans {{site.data.keyword.BluSoftlayer_notm}}, vous devez spécifier ce
VLAN privé.

<p><strong>Remarque</strong> : le VLAN public et le VLAN privé que vous spécifiez à l'aide de la commande create doivent correspondre. Les routeurs de VLAN privé
commencent toujours par <code>bcr</code> (routeur dorsal) et les routeurs de VLAN public par
<code>fcr</code> (routeur frontal). Le numéro et la combinaison de lettres après ces préfixes doivent correspondre pour pouvoir utiliser ces réseaux locaux virtuels lors de la création d'un cluster. N'utilisez pas de réseaux locaux virtuels publics et privés qui ne correspondent pas pour créer un cluster.</p></li>
</ul>

<p>Pour déterminer si vous disposez déjà d'un VLAN privé pour un emplacement spécifique ou pour identifier le nom d'un VLAN privé existant, exécutez la commande <code>bx cs vlans <em>&lt;location&gt;</em></code>.
</p></dd>

<dt><code>--public-vlan <em>PUBLIC_VLAN</em></code></dt>
<dd>(Non disponible pour les clusters légers). <ul>
<li>S'il s'agit du premier cluster que vous créez sous cet emplacement, n'utilisez pas cet indicateur. Un
VLAN public est créé pour vous lorsque le cluster est créé.</li>
<li>Si vous avez créé un cluster auparavant dans cet emplacement ou créé un VLAN public dans {{site.data.keyword.BluSoftlayer_notm}}, vous devez spécifier ce
VLAN public.

<p><strong>Remarque</strong> : le VLAN public et le VLAN privé que vous spécifiez à l'aide de la commande create doivent correspondre. Les routeurs de VLAN privé
commencent toujours par <code>bcr</code> (routeur dorsal) et les routeurs de VLAN public par
<code>fcr</code> (routeur frontal). Le numéro et la combinaison de lettres après ces préfixes doivent correspondre pour pouvoir utiliser ces réseaux locaux virtuels lors de la création d'un cluster. N'utilisez pas de réseaux locaux virtuels publics et privés qui ne correspondent pas pour créer un cluster.</p></li>
</ul>

<p>Pour déterminer si vous disposez déjà d'un VLAN public pour un emplacement spécifique ou pour identifier le nom d'un VLAN public existant, exécutez la commande <code>bx cs vlans <em>&lt;location&gt;</em></code>.
</p></dd>

<dt><code>--workers WORKER</code></dt>
<dd>(Facultatif pour les clusters standard. Non disponible pour les clusters légers). Nombre de noeuds d'agent que vous désirez déployer dans votre cluster. Si vous ne spécifiez pas cette
option, un cluster avec 1 noeud d'agent est créé.

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

  Exemple pour un environnement {{site.data.keyword.Bluemix_notm}} Dedicated :

  ```
  bx cs cluster-create --machine-type machine-type --workers number --name cluster_name
  ```
  {: pre}


### bx cs cluster-get CLUSTER
{: #cs_cluster_get}

Affiche des informations sur un cluster dans votre organisation.

<strong>Options de commande</strong> :

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>(Obligatoire) Nom ou ID du cluster.</dd>
   </dl>

**Exemples** :

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
   <dd>(Obligatoire) Nom ou ID du cluster.</dd>

   <dt><code>-f</code></dt>
   <dd>(Facultatif) Utilisez cette option pour forcer la suppression d'un cluster sans invites utilisateur.</dd>
   </dl>

**Exemples** :

  ```
        bx cs cluster-rm my_cluster
        ```
  {: pre}


### bx cs cluster-service-bind CLUSTER KUBERNETES_NAMESPACE SERVICE_INSTANCE_GUID
{: #cs_cluster_service_bind}

Ajoute un service {{site.data.keyword.Bluemix_notm}} à un cluster.

**Astuce :** dans le cas d'utilisateurs de {{site.data.keyword.Bluemix_notm}} Dedicated, voir à la place la rubrique [Ajout de services {{site.data.keyword.Bluemix_notm}} à des clusters dans {{site.data.keyword.Bluemix_notm}} Dedicated(version bêta fermée)](cs_cluster.html#binding_dedicated).

<strong>Options de commande</strong> :

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>(Obligatoire) Nom ou ID du cluster.</dd>

   <dt><code><em>KUBERNETES_NAMESPACE</em></code></dt>
   <dd>(Obligatoire) Nom de l'espace de nom Kubernetes.</dd>

   <dt><code><em>SERVICE_INSTANCE_GUID</em></code></dt>
   <dd>(Obligatoire) ID de l'instance de service {{site.data.keyword.Bluemix_notm}} que vous désirez lier.</dd>
   </dl>

**Exemples** :

  ```
  bx cs cluster-service-bind my_cluster my_namespace my_service_instance_GUID
  ```
  {: pre}


### bx cs cluster-service-unbind CLUSTER KUBERNETES_NAMESPACE SERVICE_INSTANCE_GUID
{: #cs_cluster_service_unbind}

Supprime un service {{site.data.keyword.Bluemix_notm}} d'un
cluster.

**Remarque :** lorsque vous retirez un service {{site.data.keyword.Bluemix_notm}}, ses données d'identification du service sont retirées du cluster. Si une nacelle utilise encore ce service, son opération échoue vu que les données d'identification du service sont introuvables.

<strong>Options de commande</strong> :

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>(Obligatoire) Nom ou ID du cluster.</dd>

   <dt><code><em>KUBERNETES_NAMESPACE</em></code></dt>
   <dd>(Obligatoire) Nom de l'espace de nom Kubernetes.</dd>

   <dt><code><em>SERVICE_INSTANCE_GUID</em></code></dt>
   <dd>(Obligatoire) ID de l'instance de service {{site.data.keyword.Bluemix_notm}} que vous désirez retirer.</dd>
   </dl>

**Exemples** :

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
   <dd>(Obligatoire) Nom ou ID du cluster.</dd>

   <dt><code>--namespace <em>KUBERNETES_NAMESPACE</em></code>, <code>-n <em>KUBERNETES_NAMESPACE</em></code></dt>
   <dd>(Facultatif) Inclut les services liés à un espace de nom spécifique dans un cluster.</dd>

   <dt><code>--all-namespaces</code></dt>
    <dd>(Facultatif) Inclut les services liés à tous les espaces de nom dans un cluster.</dd>
    </dl>

**Exemples** :

  ```
  bx cs cluster-services my_cluster --namespace my_namespace
  ```
  {: pre}


### bx cs cluster-subnet-add CLUSTER SUBNET
{: #cs_cluster_subnet_add}

Rend disponible au cluster spécifié un sous-réseau dans le compte {{site.data.keyword.BluSoftlayer_notm}}.

**Remarque :** lorsque vous rendez un sous-réseau disponible pour un cluster, les adresses IP du sous-réseau sont utilisées pour l'opération réseau du cluster. Pour éviter des conflits d'adresse IP, prenez soin de n'utiliser le sous-réseau qu'avec un seul cluster. N'utilisez pas en même temps un sous-réseau pour plusieurs clusters ou à d'autres fins hors d'{{site.data.keyword.containershort_notm}}.

<strong>Options de commande</strong> :

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>(Obligatoire) Nom ou ID du cluster.</dd>

   <dt><code><em>SUBNET</em></code></dt>
   <dd>(Obligatoire) ID du sous-réseau.</dd>
   </dl>

**Exemples** :

  ```
  bx cs cluster-subnet-add my_cluster subnet
  ```
  {: pre}

### bx cs clusters
{: #cs_clusters}

Affiche la liste des clusters dans votre organisation.

<strong>Options de commande</strong> :

  Aucun

**Exemples** :

  ```
  bx cs clusters
  ```
  {: pre}


### bx cs credentials-set --infrastructure-api-key API_KEY --infrastructure-username USERNAME
{: #cs_credentials_set}

Définit des informations d'authentification de compte {{site.data.keyword.BluSoftlayer_notm}} pour votre compte {{site.data.keyword.Bluemix_notm}}. Ces informations vous permettent d'accéder au portefeuille {{site.data.keyword.BluSoftlayer_notm}} via votre compte {{site.data.keyword.Bluemix_notm}}.

<strong>Options de commande</strong> :

   <dl>
   <dt><code>--infrastructure-username <em>USERNAME</em></code></dt>
   <dd>(Obligatoire) Nom d'utilisateur du compte {{site.data.keyword.BluSoftlayer_notm}}.</dd>
   </dl>

   <dt><code>--infrastructure-api-key <em>API_KEY</em></code></dt>
   <dd>(Obligatoire) Clé d'API du compte {{site.data.keyword.BluSoftlayer_notm}}.
   
 <p>
  Pour générer une clé d'API, procédez comme suit :
    
  <ol>
  <li>Connectez-vous au portail [ {{site.data.keyword.BluSoftlayer_notm}} ![External link icon](../icons/launch-glyph.svg "External link icon")](https://control.softlayer.com/).</li>
  <li>Sélectionnez <strong>Compte</strong>, puis <strong>Utilisateurs</strong>.</li>
  <li>Cliquez sur <strong>Générer</strong> afin de générer une clé d'API {{site.data.keyword.BluSoftlayer_notm}} pour votre compte.</li>
  <li>Copiez la clé d'API à utiliser dans cette commande.</li>
  </ol>

  Pour afficher votre clé d'API existante, procédez comme suit :
  <ol>
  <li>Connectez-vous au portail [ {{site.data.keyword.BluSoftlayer_notm}} ![External link icon](../icons/launch-glyph.svg "External link icon")](https://control.softlayer.com/).</li>
  <li>Sélectionnez <strong>Compte</strong>, puis <strong>Utilisateurs</strong>.</li>
  <li>Cliquez sur <strong>Afficher</strong> pour afficher votre clé d'API existante.</li>
  <li>Copiez la clé d'API à utiliser dans cette commande.</li>
  </ol></p></dd>
    
**Exemples** :

  ```
  bx cs credentials-set --infrastructure-api-key API_KEY --infrastructure-username USERNAME
  ```
  {: pre}


### bx cs credentials-unset
{: #cs_credentials_unset}

Supprime les informations d'authentification de compte {{site.data.keyword.BluSoftlayer_notm}} de votre compte {{site.data.keyword.Bluemix_notm}}. Après cette suppression, vous ne pouvez plus accéder au portefeuille {{site.data.keyword.BluSoftlayer_notm}} via votre compte {{site.data.keyword.Bluemix_notm}}.

<strong>Options de commande</strong> :

   Aucun

**Exemples** :

  ```
  bx cs credentials-unset
  ```
  {: pre}


###         bx cs locations
        
{: #cs_datacenters}

Affiche la liste de tous les emplacements disponibles pour créer un cluster.

<strong>Options de commande</strong> :

   Aucun

**Exemples** :

  ```
        bx cs locations
        ```
  {: pre}


###   bx cs help
  
{: #cs_help}

Affiche la liste des commandes et des paramètres pris en charge.

<strong>Options de commande</strong> :

   Aucun

**Exemples** :

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
   <dd>(Facultatif) Noeud final d'API {{site.data.keyword.containershort_notm}} que vous désirez utiliser. Exemples :

    <ul>
    <li>Sud des Etats-Unis :

    <pre class="codeblock">
    <code>bx cs init --host https://us-south.containers.bluemix.net</code>
    </pre></li>

    <li>Sud du Royaume-Uni :

    <pre class="codeblock">
    <code>bx cs init --host https://uk-south.containers.bluemix.net</code>
    </pre></li>

    <li>Centre Union Européenne :

    <pre class="codeblock">
    <code>bx cs init --host https://eu-central.containers.bluemix.net</code>
    </pre></li>

    <li>AP-Sud :

    <pre class="codeblock">
    <code>bx cs init --host https://ap-south.containers.bluemix.net</code>
    </pre></li></ul>
</dd>
</dl>


### bx cs machine-types LOCATION
{: #cs_machine_types}

Affichez la liste des types de machine disponibles pour vos noeuds d'agent. Chaque type de machine inclut la quantité d'UC virtuelles, de mémoire et d'espace disque pour chaque noeud d'agent dans le cluster.

<strong>Options de commande</strong> :

   <dl>
   <dt><em>LOCATION</em></dt>
   <dd>(Obligatoire) Indiquez l'emplacement où répertorier les types de machine disponibles. Les emplacements disponibles sont les suivants : <ul><li>Sud des Etats-Unis<ul><li>dal10 [Dallas]</li><li>dal12 [Dallas]</li></ul></li><li>Sud du Royaume-Uni<ul><li>lon02 [Londres]</li><li>lon04 [Londres]</li></ul></li><li>Centre Union Européenne<ul><li>ams03 [Amsterdam]</li><li>ra02 [Francfort]</li></ul></li><li>AP-Sud<ul><li>syd01 [Sydney]</li><li>syd04 [Sydney]</li></ul></li></ul></dd></dl>
   
**Exemples** :

  ```
  bx cs machine-types LOCATION
  ```
  {: pre}


### bx cs subnets
{: #cs_subnets}

Affiche la liste des sous-réseaux disponibles dans un compte {{site.data.keyword.BluSoftlayer_notm}}.

<strong>Options de commande</strong> :

   Aucun

**Exemples** :

  ```
  bx cs subnets
  ```
  {: pre}


### bx cs vlans LOCATION
{: #cs_vlans}

Répertorie les réseaux locaux virtuels publics et privés disponibles pour un emplacement dans votre compte {{site.data.keyword.BluSoftlayer_notm}}. Pour répertorier ces réseaux, vous devez disposer d'un compte payant.

<strong>Options de commande</strong> :

   <dl>
   <dt>LOCATION</dt>
   <dd>(Obligatoire) Indiquez l'emplacement où répertorier les réseaux locaux virtuels privés et publics. Les emplacements disponibles sont les suivants : <ul><li>Sud des Etats-Unis<ul><li>dal10 [Dallas]</li><li>dal12 [Dallas]</li></ul></li><li>Sud du Royaume-Uni<ul><li>lon02 [Londres]</li><li>lon04 [Londres]</li></ul></li><li>Centre Union Européenne<ul><li>ams03 [Amsterdam]</li><li>ra02 [Francfort]</li></ul></li><li>AP-Sud<ul><li>syd01 [Sydney]</li><li>syd04 [Sydney]</li></ul></li></ul></dd>
   </dl>
   
**Exemples** :

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
   <dd>(Obligatoire) Nom ou ID du cluster.</dd>

   <dt><code>--level <em>LEVEL</em></code></dt>
   <dd>(Facultatif) Niveau de notification, tel que <code>Normal</code> ou
<code>Warning</code> (avertissement). <code>Warning</code> est la valeur par défaut.</dd>

   <dt><code>--type <em>slack</em></code></dt>
   <dd>(Obligatoire) Type de webhook, tel que slack. Seul le type slack est pris en charge.</dd>

   <dt><code>--URL <em>URL</em></code></dt>
   <dd>(Obligatoire) URL du webhook.</dd>
   </dl>

**Exemples** :

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
<dd>(Obligatoire) Nom ou ID du cluster.</dd>

<dt><code>--file <em>FILE_LOCATION</em></code></dt>
<dd>Chemin d'accès au fichier YAML pour ajouter des noeuds d'agent à votre cluster. Au lieu de définir les caractéristiques de vos noeuds d'agent supplémentaires à l'aide des options fournies dans cette commande, vous pouvez utiliser un fichier YAML.
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
<td>Remplacez <code><em>&lt;cluster_name_or_id&gt;</em></code> par le nom ou l'ID du cluster sur lequel vous souhaitez ajouter des noeuds d'agent. </td> 
</tr>
<tr>
<td><code><em>location</em></code></td>
<td>Remplacez <code><em>&lt;location&gt;</em></code> par l'emplacement où vous souhaitez déployer vos noeuds d'agent. Les emplacements disponibles dépendent de la région à laquelle vous êtes connecté. Pour afficher la liste des emplacements disponibles, exécutez la commande <code>bx cs locations</code>. </td> 
</tr>
<tr>
<td><code><em>machine-type</em></code></td>
<td>Remplacez <code><em>&lt;machine_type&gt;</em></code> par le type de machine souhaité pour vos noeuds d'agent. Pour afficher la liste des types de machine disponibles pour votre emplacement, exécutez la commande <code>bx cs machine-types <em>&lt;location&gt;</em></code>.</td> 
</tr>
<tr>
<td><code><em>private-vlan</em></code></td>
<td>Remplacez <code><em>&lt;private_vlan&gt;</em></code> par l'ID du réseau local virtuel privé que vous souhaitez utiliser pour vos noeuds d'agent. Pour afficher la liste des réseaux locaux virtuels disponibles, exécutez la commande <code>bx cs vlans <em>&lt;location&gt;</em></code> et recherchez les routeurs VLAN débutant par <code>bcr</code> (routeur dorsal). </td> 
</tr>
<tr>
<td><code>public-vlan</code></td>
<td>Remplacez <code>&lt;public_vlan&gt;</code> par l'ID du réseau local virtuel public que vous souhaitez utiliser pour vos noeuds d'agent. Pour afficher la liste des réseaux locaux virtuels disponibles, exécutez la commande <code>bx cs vlans &lt;location&gt;</code> et recherchez les routeurs VLAN débutant par <code>fcr</code> (routeur frontal). </td> 
</tr>
<tr>
<td><code>hardware</code></td>
<td>Niveau d'isolation du matériel pour votre noeud d'agent. Utilisez un cluster dédié si vous désirez que toutes les ressources physiques vous soient dédiées exclusivement ou un cluster partagé pour permettre leur partage avec d'autres clients IBM. La valeur par défaut est shared. </td> 
</tr>
<tr>
<td><code>workerNum</code></td>
<td>Remplacez <code><em>&lt;number_workers&gt;</em></code> par le nombre de noeuds d'agent que vous souhaitez déployer. </td> 
</tr>
</tbody></table></p></dd>

<dt><code>--hardware <em>HARDWARE</em></code></dt>
<dd>(Facultatif) Niveau d'isolation du matériel pour votre noeud d'agent. Utilisez un cluster dédié si vous désirez que toutes les ressources physiques vous soient dédiées exclusivement ou un cluster partagé pour permettre leur partage avec d'autres clients IBM. La valeur par défaut est shared. </dd>

<dt><code>--machine-type <em>MACHINE_TYPE</em></code></dt>
<dd>(Obligatoire) Le type de machine choisi a une incidence sur la quantité de mémoire et l'espace disque disponible pour les conteneurs déployés sur votre noeud d'agent. Pour afficher la liste des types de machine disponibles, exécutez la commande [bx cs machine-types LOCATION](cs_cli_reference.html#cs_machine_types).</dd>

<dt><code>--number <em>NUMBER</em></code></dt>
<dd>(Obligatoire) Entier représentant le nombre de noeuds d'agent à créer dans le cluster.</dd>

<dt><code>--private-vlan <em>PRIVATE_VLAN</em></code></dt>
<dd>(Obligatoire) Si vous disposez d'un réseau local virtuel privé disponible pour son utilisation à cet emplacement, vous devez l'indiquer. S'il s'agit du premier cluster que vous créez sous cet emplacement, n'utilisez pas cet indicateur. Un
VLAN privé est créé pour vous.

<p><strong>Remarque</strong> : le VLAN public et le VLAN privé que vous spécifiez à l'aide de la commande create doivent correspondre. Les routeurs de VLAN privé
commencent toujours par <code>bcr</code> (routeur dorsal) et les routeurs de VLAN public par
<code>fcr</code> (routeur frontal). Le numéro et la combinaison de lettres après ces préfixes doivent correspondre pour pouvoir utiliser ces réseaux locaux virtuels lors de la création d'un cluster. N'utilisez pas de réseaux locaux virtuels publics et privés qui ne correspondent pas pour créer un cluster.</p></dd>

<dt><code>--public-vlan <em>PUBLIC_VLAN</em></code></dt>
<dd>(Obligatoire) Si vous disposez d'un réseau local virtuel public disponible pour son utilisation à cet emplacement, vous devez l'indiquer. S'il s'agit du premier cluster que vous créez sous cet emplacement, n'utilisez pas cet indicateur. Un
VLAN public est créé pour vous.

<p><strong>Remarque</strong> : le VLAN public et le VLAN privé que vous spécifiez à l'aide de la commande create doivent correspondre. Les routeurs de VLAN privé
commencent toujours par <code>bcr</code> (routeur dorsal) et les routeurs de VLAN public par
<code>fcr</code> (routeur frontal). Le numéro et la combinaison de lettres après ces préfixes doivent correspondre pour pouvoir utiliser ces réseaux locaux virtuels lors de la création d'un cluster. N'utilisez pas de réseaux locaux virtuels publics et privés qui ne correspondent pas pour créer un cluster.</p></dd>
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
   <dt><em>WORKER_NODE_ID</em></dt>
   <dd>ID d'un noeud d'agent. Exécutez la commande <code>bx cs workers <em>CLUSTER</em></code> pour afficher les ID des noeuds d'agent dans un cluster. </dd>
   </dl>

**Exemples** :

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
   <dd>(Obligatoire) Nom ou ID du cluster.</dd>

   <dt><code>-f</code></dt>
   <dd>(Facultatif) Utilisez cette option pour forcer le redémarrage du noeud d'agent sans invites utilisateur.</dd>

   <dt><code>--hard</code></dt>
   <dd>(Facultatif) Utilisez cette option pour forcer un redémarrage à froid d'un noeud d'agent en coupant son alimentation. Utilisez cette option si le noeud d'agent ne répond plus ou connaît un blocage Docker.</dd>

   <dt><code><em>WORKER</em></code></dt>
   <dd>(Obligatoire) Nom ou ID d'un ou de plusieurs noeuds d'agent. Utilisez un espace pour répertorier plusieurs noeuds d'agent.</dd>
   </dl>

**Exemples** :

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
   <dd>(Obligatoire) Nom ou ID du cluster.</dd>

   <dt><code>-f</code></dt>
   <dd>(Facultatif) Utilisez cette option pour forcer le rechargement d'un noeud d'agent sans invites utilisateur.</dd>

   <dt><code><em>WORKER</em></code></dt>
   <dd>(Obligatoire) Nom ou ID d'un ou de plusieurs noeuds d'agent. Utilisez un espace pour répertorier plusieurs noeuds d'agent.</dd>
   </dl>

**Exemples** :

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
   <dd>(Obligatoire) Nom ou ID du cluster.</dd>

   <dt><code>-f</code></dt>
   <dd>(Facultatif) Utilisez cette option pour forcer la suppression d'un noeud d'agent sans invites utilisateur.</dd>

   <dt><code><em>WORKER</em></code></dt>
   <dd>(Obligatoire) Nom ou ID d'un ou de plusieurs noeuds d'agent. Utilisez un espace pour répertorier plusieurs noeuds d'agent.</dd>
   </dl>

**Exemples** :

  ```
  bx cs worker-rm my_cluster my_node1 my_node2
  ```
  {: pre}

### bx cs workers CLUSTER
{: #cs_workers}

Affiche la liste des noeuds d'agent dans un cluster et la statut de chacun d'eux.

<strong>Options de commande</strong> :

   <dl>
   <dt><em>CLUSTER</em></dt>
   <dd>(Obligatoire) Nom ou ID du cluster sur lequel répertorier les noeuds d'agent disponibles.</dd>
   </dl>

**Exemples** :

  ```
  bx cs workers mycluster
  ```
  {: pre}

## Etats de cluster
{: #cs_cluster_states}

Vous pouvez visualiser l'état de cluster en cours en exécutant la commande bx cs clusters et en localisant la zone **State**. L'état du cluster vous donne des informations sur la disponibilité et de la capacité du cluster, et sur les problèmes qui se sont éventuellement produits. {:shortdesc}

|Etat du cluster|Cause|
|-------------|------|
|Deploying|Le maître Kubernetes n'est pas encore complètement déployé. Vous ne pouvez pas accéder à votre cluster.|
|Pending|Le maître Kubernetes est déployé. La mise à disposition des noeuds d'agent est en cours. Ces derniers ne sont pas encore disponibles dans le cluster. Vous pouvez accéder au cluster, mais vous ne pouvez pas déployer d'applications sur le cluster. |
|Normal|Tous les noeuds d'agent d'un cluster sont opérationnels. Vous pouvez accéder au cluster et déployer les applications sur le cluster. |
|Warning|Au moins un noeud d'agent du cluster n'est pas disponible. Cela dit, les autres noeuds d'agent sont disponibles et peuvent prendre le relais pour la charge de travail. <ol><li>Répertoriez les noeuds d'agent présents dans votre cluster et notez l'ID des noeuds d'agent dont l'état indique <strong>Warning</strong>.
<pre class="pre"><code>bx cs workers &lt;cluster_name_or_id&gt;</code></pre><li>Affichez les détails relatifs à votre noeud d'agent. <pre class="pre"><code>bx cs worker-get &lt;worker_id&gt;</code></pre><li>Passez en revue les champs <strong>State</strong>, <strong>Status</strong> et <strong>Details</strong> pour identifier la principale cause de l'arrêt du noeud d'agent. </li><li>Si votre noeud d'agent a pratiquement atteint sa limite en termes de mémoire ou d'espace disque, réduisez la charge de travail sur votre noeud d'agent ou ajoutez un noeud d'agent à votre cluster pour contribuer à l'équilibrage de la charge de travail. </li></ol>|
|Critical|Le maître Kubernetes est inaccessible ou tous les noeuds d'agent du cluster sont arrêtés. <ol><li>Affichez la liste des noeuds d'agent présents dans votre cluster.<pre class="pre"><code>bx cs workers &lt;cluster_name_or_id&gt;</code></pre><li>Affichez les détails relatifs à chaque noeud d'agent. <pre class="pre"><code>bx cs worker-get &lt;worker_id&gt;</code></pre></li><li>Passez en revue les champs <strong>State</strong>, <strong>Status</strong> et <strong>Details</strong> pour identifier la principale cause de l'arrêt du noeud d'agent. </li><li>Si l'état du noeud d'agent est <strong>Provision_failed</strong>, vous ne disposez peut-être pas des droits nécessaires pour mettre à disposition un noeud d'agent à partir du portefeuille {{site.data.keyword.BluSoftlayer_notm}}. Pour identifier les droits nécessaires, voir [Configuration de l'accès au portefeuille {{site.data.keyword.BluSoftlayer_notm}} pour créer des clusters Kubernetes standard](cs_planning.html#cs_planning_unify_accounts).</li><li>Si l'état du noeud d'agent est <strong>Critical</strong> et que son statut est <strong>Out of disk</strong>, cela signifie que votre noeud d'agent ne dispose pas de suffisamment de capacité. Vous pouvez réduire la charge de travail sur votre noeud d'agent ou ajouter un noeud d'agent à votre cluster pour contribuer à l'équilibrage de la charge de travail. </li><li>Si l'état du noeud d'agent est <strong>Critical</strong> et que son statut est <strong>Unknown</strong>, cela signifie que le maître Kubernetes est indisponible. Contactez le support {{site.data.keyword.Bluemix_notm}} en ouvrant un [ticket de demande de service {{site.data.keyword.Bluemix_notm}}](/docs/support/index.html#contacting-support).</li></ol>|
{: caption="Tableau 3. Etats de cluster" caption-side="top"}
