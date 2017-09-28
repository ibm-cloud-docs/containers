---

copyright:
  years: 2014, 2017
lastupdated: "2017-08-15"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}
{:tsSymptoms: .tsSymptoms}
{:tsCauses: .tsCauses}
{:tsResolve: .tsResolve}


# Traitement des incidents affectant les clusters
{: #cs_troubleshoot}

Lorsque vous utilisez {{site.data.keyword.containershort_notm}}, tenez compte des techniques décrites ci-dessous pour identifier et résoudre les incidents et obtenir de l'aide. 

{: shortdesc}


## Débogage des clusters
{: #debug_clusters}

Passez en revue les options dont vous disposez pour déboguer vos clusters et identifier les causes premières des échecs. 

1.  Affichez votre cluster et identifiez son `état`. 

  ```
  bx cs clusters
  ```
  {: pre}

2.  Examinez l'`état` de votre cluster.

  <table summary="Chaque ligne de tableau se lit de gauche à droite. L'état du cluster figure dans la première colonne et la description correspondante dans la seconde colonne.">
<thead>
    <th>Etat du cluster</th>
    <th>Description</th>
    </thead>
    <tbody>
      <tr>
        <td>Deploying</td>
        <td>Le maître Kubernetes n'est pas encore complètement déployé. Vous ne pouvez pas accéder à votre cluster.</td>
       </tr>
       <tr>
        <td>Pending</td>
        <td>Le maître Kubernetes est déployé. La mise à disposition des noeuds d'agent est en cours. Ces derniers ne sont pas encore disponibles dans le cluster. Vous pouvez accéder au cluster, mais vous ne pouvez pas déployer d'applications sur le cluster. </td>
      </tr>
      <tr>
        <td>Normal</td>
        <td>Tous les noeuds d'agent d'un cluster sont opérationnels. Vous pouvez accéder au cluster et déployer les applications sur le cluster. </td>
     </tr>
     <tr>
        <td>Warning</td>
        <td>Au moins un noeud d'agent du cluster n'est pas disponible. Cela dit, les autres noeuds d'agent sont disponibles et peuvent prendre le relais pour la charge de travail. </td>
     </tr>
     <tr>
      <td>Critical</td>
      <td>Le maître Kubernetes est inaccessible ou tous les noeuds d'agent du cluster sont arrêtés. </td>
     </tr>
    </tbody>
  </table>

3.  Si votre cluster est à l'état **Warning** ou **Critical** ou s'il est bloqué à l'état **Pending** depuis un certain temps, vérifiez l'état de vos noeuds d'agent. Si votre cluster est à l'état **Deploying**, attendez la fin du déploiement pour vérifier l'état de santé de votre cluster. Les clusters à l'état **Normal** sont considérés comme sains et ne nécessitent aucune action pour le moment.  

  ```
  bx cs workers <cluster_name_or_id>
  ```
  {: pre}

  <table summary="Chaque ligne de tableau doit être lue de gauche à droite. L'état du cluster figure dans la première colonne et la description correspondante dans la seconde colonne.">
<thead>
    <th>Etat du noeud d'agent</th>
    <th>Description</th>
    </thead>
    <tbody>
      <tr>
       <td>Unknown</td>
       <td>Le maître Kubernetes est inaccessible pour l'une des raisons suivantes : <ul><li>Vous avez demandé une mise à jour de votre maître Kubernetes. L'état du noeud d'agent ne peut pas être extrait lors de la mise à jour. </li><li>Peut-être possédez-vous un pare-feu qui protège vos noeuds d'agent ou avez-vous récemment modifié vos paramètres de pare-feu. {{site.data.keyword.containershort_notm}} requiert que certaines adresses IP et certains ports soient ouverts pour permettre la communication entre le noeud d'agent et le maître Kubernetes et inversement. Pour plus d'informations, voir la rubrique [Noeuds d'agent bloqués dans une boucle de rechargement](#cs_firewall).</li><li>Le maître Kubernetes est arrêté. Contactez le support {{site.data.keyword.Bluemix_notm}} en ouvrant un [ticket de demande de service {{site.data.keyword.Bluemix_notm}}](/docs/support/index.html#contacting-support).</li></ul></td>
      </tr>
      <tr>
        <td>Provisioning</td>
        <td>La mise à disposition de votre noeud d'agent est en cours. Ce dernier n'est pas encore disponible dans le cluster. Vous pouvez surveiller le processus de mise à disposition dans la colonne **Status** de la sortie générée par l'interface de ligne de commande. Si votre noeud d'agent est bloqué dans cet état depuis un certain temps et vous ne voyez aucune progression dans la colonne **Status**, passez à l'étape suivante pour voir si un problème s'est produit lors de la mise à disposition. </td>
      </tr>
      <tr>
        <td>Provision_failed</td>
        <td>Votre noeud d'agent n'a pas pu être mis à disposition. Passez à l'étape suivante pour rechercher les détails relatifs à cet échec. </td>
      </tr>
      <tr>
        <td>Reloading</td>
        <td>Le rechargement de votre noeud d'agent est en cours. Ce dernier n'est pas disponible dans le cluster. Vous pouvez surveiller le processus de rechargement dans la colonne **Status** de la sortie générée par l'interface de ligne de commande. Si votre noeud d'agent est bloqué dans cet état depuis un certain temps et vous ne voyez aucune progression dans la colonne **Status**, passez à l'étape suivante pour voir si un problème s'est produit lors du rechargement. </td>
       </tr>
       <tr>
        <td>Reloading_failed</td>
        <td>Votre noeud d'agent n'a pas pu être rechargé. Passez à l'étape suivante pour rechercher les détails relatifs à cet échec. </td>
      </tr>
      <tr>
        <td>Normal</td>
        <td>Votre noeud d'agent est entièrement mis à disposition et il est prêt à être utilisé dans le cluster. </td>
     </tr>
     <tr>
        <td>Warning</td>
        <td>Votre noeud d'agent est sur le point d'atteindre la limite en termes de mémoire ou d'espace disque. </td>
     </tr>
     <tr>
      <td>Critical</td>
      <td>Votre noeud d'agent ne dispose plus de suffisamment d'espace disque.</td>
     </tr>
    </tbody>
  </table>

4.  Affichez la liste des détails relatifs à votre noeud d'agent. 

  ```
  bx cs worker-get <worker_node_id>
  ```
  {: pre}

5.  Passez en revue les messages d'erreur courants et apprenez à résoudre les problèmes correspondants. 

  <table>
    <thead>
    <th>Message d'erreur</th>
    <th>Description et résolution
    </thead>
    <tbody>
      <tr>
        <td>Exception liée à l'infrastructure {{site.data.keyword.Bluemix_notm}} : votre compte n'est pas autorisé à réserver des instances de traitement pour l'instant. </td>
        <td>La réservation de ressources de traitement par votre compte {{site.data.keyword.BluSoftlayer_notm}} n'est peut-être pas possible. Contactez le support {{site.data.keyword.Bluemix_notm}} en ouvrant un [ticket de demande de service {{site.data.keyword.Bluemix_notm}}](/docs/support/index.html#contacting-support).</td>
      </tr>
      <tr>
        <td>Exception liée à l'infrastructure {{site.data.keyword.Bluemix_notm}} : impossible de passer la commande. Les ressources derrière le routeur 'router_name' ne sont pas suffisantes pour satisfaire la demande pour les invités suivants : 'worker_id'.</td>
        <td>Le réseau local virtuel que vous avez sélectionné est associé à une nacelle du centre de données dont l'espace n'est pas suffisant pour mettre à disposition votre noeud d'agent. Plusieurs possibilités s'offrent à vous :<ul><li>Utilisez un autre centre de données pour mettre à disposition votre noeud d'agent. Exécutez la commande <code>bx cs locations</code> pour afficher la liste des centres de données disponibles. <li>Si vous possédez déjà une paire de réseaux locaux virtuels public et privé associée à une autre nacelle du centre de données, utilisez-la à la place. <li>Contactez le support {{site.data.keyword.Bluemix_notm}} en ouvrant un [ticket de demande de service {{site.data.keyword.Bluemix_notm}}](/docs/support/index.html#contacting-support).</ul></td>
      </tr>
      <tr>
        <td>Exception liée à l'infrastructure {{site.data.keyword.Bluemix_notm}} : impossible d'obtenir le réseau local virtuel portant l'ID : &lt;vlan id&gt;.</td>
        <td>Votre noeud d'agent n'a pas pu être mis à disposition car l'ID de réseau local virtuel sélectionné est introuvable pour l'une des raisons suivantes : <ul><li>Vous avez indiqué le numéro de réseau local virtuel au lieu de l'ID de réseau local virtuel. Le numéro de réseau local virtuel est composé de 3 ou 4 chiffres, tandis que l'ID de réseau local virtuel est composé de 7 chiffres. Exécutez la commande <code>bx cs vlans &lt;location&gt;</code> pour extraire l'ID de réseau local virtuel. <li>L'ID de réseau local virtuel n'est peut-être pas associé au compte de l'infrastructure Bluemix (SoftLayer) que vous utilisez. Exécutez la commande <code>bx cs vlans &lt;location&gt;</code> pour afficher la liste des ID de réseau local virtuel disponibles pour votre compte. Pour modifier le compte {{site.data.keyword.BluSoftlayer_notm}}, voir la rubrique sur la commande [bx cs credentials-set](cs_cli_reference.html#cs_credentials_set). </ul></td>
      </tr>
      <tr>
        <td>SoftLayer_Exception_Order_InvalidLocation : l'emplacement fourni pour cette commande n'est pas valide. (HTTP 500)</td>
        <td>Votre {{site.data.keyword.BluSoftlayer_notm}} n'est pas configuré pour commander des ressources de traitement dans le centre de données sélectionné. Contactez le [support {{site.data.keyword.Bluemix_notm}} ](/docs/support/index.html#contacting-support) pour vérifier que votre compte est correctement configuré. </td>
       </tr>
       <tr>
        <td>Exception liée à l'infrastructure {{site.data.keyword.Bluemix_notm}} : l'utilisateur ne dispose pas des droits sur l'infrastructure {{site.data.keyword.Bluemix_notm}} nécessaires pour ajouter des serveurs
        
        </br></br>
        Exception liée à l'infrastructure {{site.data.keyword.Bluemix_notm}} : des droits sont nécessaires pour réserver 'Item'. </td>
        <td>Vous ne disposez peut-être pas des droits nécessaires pour mettre à disposition un noeud d'agent à partir du portefeuille {{site.data.keyword.BluSoftlayer_notm}}. Pour identifier les droits nécessaires, voir [Configuration de l'accès au portefeuille {{site.data.keyword.BluSoftlayer_notm}} pour créer des clusters Kubernetes standard](cs_planning.html#cs_planning_unify_accounts).</td>
      </tr>
    </tbody>
  </table>

## Vous ne pouvez pas vous connecter à votre compte {{site.data.keyword.BluSoftlayer_notm}} IBM lors de la création d'un cluster
{: #cs_credentials}

{: tsSymptoms}
Lorsque vous créez un nouveau cluster Kubernetes, vous rencontrez le message suivant.

```
Impossible de vous connecter à votre compte {{site.data.keyword.BluSoftlayer_notm}}. Pour créer un cluster standard, vous devez posséder un compte de type Paiement à la carte lié à un compte {{site.data.keyword.BluSoftlayer_notm}} ou avoir utilisé l'interface CLI 
{{site.data.keyword.Bluemix_notm}} Container Service pour configurer vos clés d'API de l'infrastructure {{site.data.keyword.Bluemix_notm}}.
 ```
{: screen}

{: tsCauses}
Les utilisateurs disposant d'un compte {{site.data.keyword.Bluemix_notm}} non lié doivent créer un nouveau compte de type Paiement à la carte ou ajouter manuellement des clés d'API {{site.data.keyword.BluSoftlayer_notm}} depuis l'interface CLI de {{site.data.keyword.Bluemix_notm}}.

{: tsResolve}
Pour ajouter des données d'identification à votre compte {{site.data.keyword.Bluemix_notm}} : 

1.  Contactez votre administrateur {{site.data.keyword.BluSoftlayer_notm}} pour lui demander votre nom d'utilisateur {{site.data.keyword.BluSoftlayer_notm}} et la clé d'API.

    **Remarque : ** le compte {{site.data.keyword.BluSoftlayer_notm}} que vous utilisez doit être configuré avec des autorisations de niveau Superutilisateur pour vous permettre de créer des clusters standard.  

2.  Ajoutez les données d'identification.

  ```
  bx cs credentials-set --infrastructure-username <username> --infrastructure-api-key <api_key>
  ```
  {: pre}

3.  Créez un cluster standard.

  ```
  bx cs cluster-create --location dal10 --public-vlan my_public_vlan_id --private-vlan my_private_vlan_id --machine-type u1c.2x4 --name my_cluster --hardware shared --workers 2
  ```
  {: pre}


## L'accès à votre noeud d'agent à l'aide de SSH échoue
{: #cs_ssh_worker}

{: tsSymptoms}
Vous ne pouvez pas accéder à votre noeud d'agent à l'aide d'une connexion SSH.

{: tsCauses}
L'accès SSH via un mot de passe est désactivé sur les noeuds d'agent.

{: tsResolve}
Utilisez des [ensembles de démons ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) pour tout ce que vous devez exécuter sur chaque noeud ou des travaux pour toutes les actions ponctuelles que vous devez exécuter.


## Des nacelles sont toujours en attente
{: #cs_pods_pending}

{: tsSymptoms}
Lorsque
vous exécutez `kubectl get pods`, vous constatez que des
nacelles sont toujours à l'état **pending**.

{: tsCauses}
Si vous venez juste de créer le cluster Kubernetes, il se peut que les noeuds d'agent soient encore en phase de configuration. S'il s'agit d'un cluster existant, sa capacité est peut-être insuffisante pour y déployer la nacelle.

{: tsResolve}
Cette tâche nécessite d'utiliser une [règle d'accès administrateur](cs_cluster.html#access_ov). Vérifiez votre [règle d'accès](cs_cluster.html#view_access) actuelle.

Si vous venez de créer le cluster Kubernetes, exécutez la commande suivante et attendez l'initialisation des noeuds d'agent.

```
kubectl get nodes
```
{: pre}

S'il s'agit d'un cluster existant, vérifiez sa capacité.

1.  Affectez le numéro de port par défaut au proxy.

  ```
  kubectl proxy
  ```
   {: pre}

2.  Ouvrez le tableau de bord Kubernetes.

  ```
  http://localhost:8001/ui
  ```
  {: pre}

3.  Vérifiez que vous disposez de suffisamment de capacité dans votre cluster pour déployer la nacelle.

4.  Si vous ne disposez pas de suffisamment de capacité dans votre cluster, ajoutez un autre noeud d'agent à celui-ci.

  ```
  bx cs worker-add <cluster name or id> 1
  ```
  {: pre}

5.  Si vos nacelles sont toujours à l'état **pending** après le déploiement complet du noeud d'agent, consultez la [documentation Kubernetes![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/tasks/debug-application-cluster/debug-pod-replication-controller/#my-pod-stays-pending) pour effectuer d'autres tâches en vue d'identifier et de résoudre le problème. 

## Echec de la création du noeud d'agent avec le message provision_failed 
{: #cs_pod_space}

{: tsSymptoms}
Lorsque vous créez un cluster Kubernetes ou ajoutez des noeuds d'agent, l'état provision_failed s'affiche. Exécutez la commande suivante.

```
bx cs worker-get <WORKER_NODE_ID>
```
{: pre}

Le message ci-après s'affiche.

```
SoftLayer_Exception_Virtual_Host_Pool_InsufficientResources: Could not place order. There are insufficient resources behind router bcr<router_ID> to fulfill the request for the following guests: kube-<location>-<worker_node_ID>-w1 (HTTP 500)
```
{: screen}

{: tsCauses}
Il se peut que la capacité de {{site.data.keyword.BluSoftlayer_notm}} ait été insuffisante à ce moment pour allouer le noeud d'agent.

{: tsResolve}
Option 1 : créer le cluster sous un autre emplacement.

Option 2 : ouvrir un ticket de demande de service auprès de {{site.data.keyword.BluSoftlayer_notm}} et vous renseigner sur la disponibilité de capacité dans cet emplacement.

## Echec de l'accès à une nacelle sur un nouveau noeud d'agent et dépassement du délai d'attente
{: #cs_nodes_duplicate_ip}

{: tsSymptoms}
Vous avez supprimé un noeud d'agent dans votre cluster et ajouté un noeud d'agent. Lorsque vous avez déployé une nacelle ou un service Kubernetes, la ressource n'a pas pu accéder au noeud d'agent nouvellement créé et un dépassement de délai d'attente s'est produit pour la connexion. 

{: tsCauses}
Si vous supprimez un noeud d'agent de votre cluster et que vous ajoutez un noeud d'agent, il se peut que l'adresse IP privée du noeud d'agent supprimé soit affectée au nouveau noeud d'agent. Calico utilise cette adresse IP privée en tant que balise et continue d'essayer d'atteindre le noeud supprimé. 

{: tsResolve}
Mettez manuellement à jour la référence de l'adresse IP privée pour qu'elle pointe vers le noeud approprié. 

1.  Vérifiez que vous possédez deux noeuds d'agent associés à la même **adresse IP privée**. Notez l'**adresse IP privée** et l'**ID** de l'agent supprimé. 

  ```
  bx cs workers <CLUSTER_NAME>
  ```
  {: pre}

  ```
  ID                                                 Public IP       Private IP       Machine Type   State     Status
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w1   192.0.2.0.12   203.0.113.144   b1c.4x16       normal    Ready
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w2   192.0.2.0.16   203.0.113.144   b1c.4x16       deleted    -
  ```
  {: screen}

2.  Installez l'[interface de ligne de commande Calico](cs_security.html#adding_network_policies).
3.  Répertoriez les noeuds d'agent disponibles dans Calico. Remplacez <path_to_file> par le chemin d'accès local au fichier de configuration Calico. 

  ```
  calicoctl get nodes --config=<path_to_file>/calicoctl.cfg
  ```
  {: pre}

  ```
  NAME
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w1
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w2
  ```
  {: screen}

4.  Supprimez le noeud d'agent en double dans Calico. Remplacez NODE_ID par l'ID du noeud d'agent. 

  ```
  calicoctl delete node NODE_ID --config=<path_to_file>/calicoctl.cfg
  ```
  {: pre}

5.  Redémarre le noeud d'agent qui n'a pas été supprimé. 

  ```
  bx cs worker-reboot CLUSTER_ID NODE_ID
  ```
  {: pre}


Le noeud supprimé n'apparaît plus dans Calico.

## Echec de la connexion de noeuds d'agent
{: #cs_firewall}

{: tsSymptoms}
Lors d'un échec du proxy kubectl ou si vous tentez d'accéder à un service dans votre cluster, mais que votre connexion échoue avec l'un des messages d'erreur suivants :

  ```
  Connection refused
  ```
  {: screen}

  ```
  Connection timed out
  ```
  {: screen}

  ```
  Unable to connect to the server: net/http: TLS handshake timeout
  ```
  {: screen}

Ou que vous utilisez les commandes kubectl
exec, attach, ou logs et rencontrez l'erreur suivante :

  ```
  Error from server: error dialing backend: dial tcp XXX.XXX.XXX:10250: getsockopt: connection timed out
  ```
  {: screen}

Ou quand l'opération du proxy kubectl aboutit, mais que le tableau de bord n'est pas disponible et que vous recevez le message d'erreur suivant :

  ```
  timeout on 172.xxx.xxx.xxx
  ```
  {: screen}

Ou lorsque vos noeuds d'agent sont bloqués dans une boucle de rechargement. 

{: tsCauses}
Vous avez peut-être un pare-feu supplémentaire configuré ou personnalisé dans vos paramètres de pare-feu dans votre compte {{site.data.keyword.BluSoftlayer_notm}}. {{site.data.keyword.containershort_notm}} requiert que certaines adresses IP et certains ports soient ouverts pour permettre la communication entre le noeud d'agent et le maître Kubernetes et inversement.

{: tsResolve}
Cette tâche nécessite d'utiliser une [règle d'accès administrateur](cs_cluster.html#access_ov). Vérifiez votre [règle d'accès](cs_cluster.html#view_access) actuelle.

Ouvrez les ports et adresses IP ci-après dans votre pare-feu personnalisé.
```
TCP port 443 FROM '<each_worker_node_publicIP>' TO registry.ng.bluemix.net, apt.dockerproject.org
```
{: pre}


<!--Inbound left for existing clusters. Once existing worker nodes are reloaded, users only need the Outbound information, which is found in the regular docs.-->

1.  Notez l'adresse IP publique pour tous vos noeuds d'agent dans le cluster :

  ```
  bx cs workers '<cluster_name_or_id>'
  ```
  {: pre}

2.  Dans votre pare-feu, autorisez les connexions suivantes vers et depuis vos noeuds d'agent :

  ```
TCP port 443 FROM '<each_worker_node_publicIP>' TO registry.ng.bluemix.net, apt.dockerproject.org
```
  {: pre}

    <ul><li>Pour une connectivité ENTRANTE vers vos noeuds d'agent, autorisez le trafic réseau entrant depuis les adresses IP et groupes réseau source suivants vers le port TCP/UDP de destination 10250 et ` <public_IP_of _each_worker_node>`:</br>
    
    <table summary="La première ligne du tableau s'étend sur deux colonnes. Les autres lignes se lisent de gauche à droite. L'emplacement du serveur figure dans la première colonne et les adresses IP pour concordance dans la seconde colonne.">
      <thead>
      <th colspan=2><img src="images/idea.png"/> Adresses IP entrantes</th>
      </thead>
    <tbody>
      <tr>
        <td>ams03</td>
        <td><code>169.50.144.128/28
</code></br><code>169.50.169.104/29</code></br><code>169.50.185.32/27
</code></td>
      </tr>
      <tr>
        <td>dal10</td>
        <td><code>169.46.7.232/29 </code></br><code>169.48.138.64/26
</code></br><code>169.48.180.128/25</code></td>
       </tr>
       <tr>
        <td>dal12</td>
        <td><code>169.47.70.8/29</code></br><code>169.47.79.192/26
</code></br><code>169.47.126.192/27
</code></td>
       </tr>
       <tr>
        <td>fra02</td>
        <td><code>169.50.48.160/28
</code></br><code>169.50.56.168/29</code></br><code>169.50.58.160/27
</code></td>
       </tr>
      </tbody>
      <tr>
       <td>lon02</td>
       <td><code>159.122.242.78</code></td>
      </tr>
      <tr>
       <td>lon04</td>
       <td><code>158.175.68.192/26</code></td>
      </tr>
      <tr>
       <td>syd01</td>
       <td><code>168.1.209.192/26</code></td>
      </tr>
      <tr>
       <td>syd04</td>
       <td><code>130.198.67.0/26</code></td>
      </tr>
    </table>

    <li>Pour la connectivité SORTANTE depuis vos noeuds d'agent, autorisez le trafic réseau sortant depuis le noeud d'agent source vers la plage de ports TCP/UDP de destination 20000 à 32767 pour `
<each_worker_node_publicIP>`, et les adresses IP et groupes de réseaux suivants :</br>
    
    <table summary="La première ligne du tableau s'étend sur deux colonnes. Les autres lignes se lisent de gauche à droite. L'emplacement du serveur figure dans la première colonne et les adresses IP pour concordance dans la seconde colonne.">
      <thead>
      <th colspan=2><img src="images/idea.png"/> Adresses IP sortantes</th>
      </thead>
    <tbody>
      <tr>
        <td>ams03</td>
        <td><code>169.50.169.110</code></td>
      </tr>
      <tr>
        <td>dal10</td>
        <td><code>169.46.7.238</code></td>
       </tr>
       <tr>
        <td>dal12</td>
        <td><code>169.47.70.10</code></td>
       </tr>
       <tr>
        <td>fra02</td>
        <td><code>169.50.56.174</code></td>
       </tr>
      </tbody>
      <tr>
       <td>lon02</td>
       <td><code>159.122.242.78</code></td>
      </tr>
      <tr>
       <td>lon04</td>
       <td><code>158.175.65.170</code></td>
      </tr>
      <tr>
       <td>syd01</td>
       <td><code>168.1.8.195</code></td>
      </tr>
      <tr>
       <td>syd04</td>
       <td><code>130.198.64.19</code></td>
      </tr>
    </table>
</ul>
    
    

## Echec de la connexion à une application via Ingress
{: #cs_ingress_fails}

{: tsSymptoms}
Vous avez exposé votre application au public en créant une ressource Ingress pour votre application dans votre cluster. Lorsque vous avez essayé de vous connecter à votre application via l'adresse IP publique ou le sous-domaine du contrôleur Ingress, la connexion a échoué ou expiré.

{: tsCauses}
Il se peut qu'Ingress ne fonctionne pas correctement pour les raisons suivantes :
<ul><ul>
<li>Le cluster n'est pas encore complètement déployé.
<li>Le cluster a été configuré en tant que cluster léger ou en tant que cluster standard avec un seul noeud d'agent. <li>Le script de configuration Ingress contient des erreurs.
</ul></ul>

{: tsResolve}
Pour identifier et résoudre les problèmes liés à votre contrôleur Ingress :

1.  Prenez soin de configurer un cluster standard qui est entièrement déployé et qui comporte au moins deux noeuds d'agent afin d'assurer la haute disponibilité de votre contrôleur Ingress. 

  ```
  bx cs workers <cluster_name_or_id>
  ```
  {: pre}

    Dans la sortie générée par votre interface de ligne de commande, vérifiez que la valeur **Ready** apparaît dans la zone **Status** pour vos noeuds d'agent et qu'une valeur autre **free** est spécifiée dans la zone **Machine Type** 

2.  Récupérez le sous-domaine et l'adresse IP publique du contrôleur Ingress, puis exécutez une commande PING vers chacun d'eux. 

    1.  Récupérez le sous-domaine de contrôleur Ingress. 

      ```
      bx cs cluster-get <cluster_name_or_id> | grep "Ingress subdomain"
      ```
      {: pre}

    2.  Exécutez une commande PING vers le sous-domaine du contrôleur Ingress. 

      ```
      ping <ingress_controller_subdomain>
      ```
      {: pre}

    3.  Récupérez l'adresse IP publique de votre contrôleur Ingress. 

      ```
      nslookup <ingress_controller_subdomain>
      ```
      {: pre}

    4.  Exécutez une commande PING vers l'adresse IP publique du contrôleur Ingress. 

      ```
      ping <ingress_controller_ip>
      ```
      {: pre}

    Si l'interface de ligne de commande renvoie une erreur de dépassement de délai d'attente pour l'adresse IP publique ou le sous-domaine du contrôleur Ingress et que vous avez configuré un pare-feu personnalisé afin de protéger vos noeuds d'agent, vous devrez peut-être ouvrir des ports et des groupes réseau supplémentaires dans votre [firewall](#cs_firewall).

3.  Si vous utilisez un domaine personnalisé, assurez-vous que votre domaine personnalisé est mappé à l'adresse IP publique ou au sous-domaine du contrôleur Ingress fourni par IBM avec votre fournisseur DNS (Domain Name Service). 
    1.  Si vous avez utilisé le sous-domaine du contrôleur Ingress, vérifiez le nom canonique (enregistrement CNAME).
    2.  Si vous avez utilisé l'adresse IP publique du contrôleur Ingress, assurez-vous que votre domaine personnalisé est mappé à l'adresse IP publique portable dans le pointeur (enregistrement PTR). 
4.  Vérifiez le fichier de configuration Ingress. 

    ```
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: myingress
    spec:
      tls:
      - hosts:
        - <ingress_subdomain>
        secretName: <ingress_tlssecret>
      rules:
      - host: <ingress_subdomain>
        http:
          paths:
          - path: /
            backend:
              serviceName: myservice
              servicePort: 80
    ```
    {: codeblock}

    1.  Assurez-vous que le sous-domaine du contrôleur Ingress et le certificat TLS sont corrects. Pour identifier le sous-domaine fourni par IBM et le certificat TLS, exécutez la commande bx cs cluster-get <cluster_name_or_id>.
    2.  Assurez-vous que votre application est en mode écoute sur le même chemin que celui qui est configuré dans la section **path** de votre contrôleur Ingress. Si votre application est configurée pour être en mode écoute sur le chemin racine, ajoutez **/** comme chemin.
5.  Vérifiez le déploiement du contrôleur Ingress et recherchez les éventuels messages d'erreur. 

  ```
  kubectl describe ingress <myingress>
  ```
  {: pre}

6.  Vérifiez les journaux de votre contrôleur Ingress. 
    1.  Récupérez l'ID des nacelles Ingress qui sont en cours d'exécution dans votre cluster.

      ```
      kubectl get pods -n kube-system |grep ingress
      ```
      {: pre}

    2.  Récupérez les journaux pour chaque nacelle Ingress. 

      ```
      kubectl logs <ingress_pod_id> -n kube-system
      ```
      {: pre}

    3.  Recherchez les messages d'erreur dans les journaux du contrôleur Ingress. 

## Echec de la connexion à une application via un service d'équilibrage de charge
{: #cs_loadbalancer_fails}

{: tsSymptoms}
Vous avez exposé votre application au public en créant un service d'équilibrage de charge dans votre cluster. Lorsque vous avez essayé de vous connecter à votre application via l'adresse IP publique de l'équilibreur de charge, la connexion a échoué ou expiré.

{: tsCauses}
Il se peut que le service d'équilibrage de charge ne fonctionne pas correctement pour l'une des raisons suivantes :

-   Le cluster est un cluster léger ou un cluster standard avec un seul noeud d'agent. 
-   Le cluster n'est pas encore complètement déployé. 
-   Le script de configuration pour votre service d'équilibrage de charge comporte des erreurs. 

{: tsResolve}
Pour identifier et résoudre les problèmes liés à votre service d'équilibrage de charge :

1.  Prenez soin de configurer un cluster standard qui est entièrement déployé et qui comporte au moins deux noeuds d'agent afin d'assurer la haute disponibilité de votre service d'équilibrage de charge. 

  ```
  bx cs workers <cluster_name_or_id>
  ```
  {: pre}

    Dans la sortie générée par votre interface de ligne de commande, vérifiez que la valeur **Ready** apparaît dans la zone **Status** pour vos noeuds d'agent et qu'une valeur autre **free** est spécifiée dans la zone **Machine Type** 

2.  Vérifiez que le fichier de configuration du service d'équilibrage de charge est correct. 

  ```
  apiVersion: v1
  kind: Service
  metadata:
    name: myservice
  spec:
    type: LoadBalancer
    selector:
      <selectorkey>:<selectorvalue>
    ports:
     - protocol: TCP
       port: 8080
  ```
  {: pre}

    1.  Vérifiez que vous avez défini **LoadBlanacer** comme type de service. 
    2.  Vérifiez que vous avez utilisé les mêmes valeurs **<selectorkey>** et **<selectorvalue>** que celles que vous aviez spécifiées dans la section **label/metadata** lors du déploiement de votre application. 
    3.  Vérifiez que vous avez utilisé le **port** sur lequel votre application est en mode écoute. 

3.  Vérifiez votre service d'équilibrage de charge et passez en revue la section **Events** à la recherche d'éventuelles erreurs. 

  ```
    kubectl describe service <myservice>
    ```
  {: pre}

    Recherchez les messages d'erreur suivants :
<ul><ul><li><pre class="screen"><code>Clusters with one node must use services of type NodePort</code></pre></br>Pour utiliser le service d'équilibrage de charge, vous devez disposer d'un cluster standard et d'au moins deux noeuds d'agent.
<li><pre class="screen"><code>No cloud provider IPs are available to fulfill the load balancer service request. Add a portable subnet to the cluster and try again</code></pre></br>Ce message d'erreur indique qu'il ne reste aucune adresse IP publique portable à attribuer à votre service d'équilibrage de charge. Pour savoir comment demander des adresses IP publiques portables pour votre cluster, voir la rubrique [Ajout de sous-réseaux à des clusters](cs_cluster.html#cs_cluster_subnet). Dès lors que des adresses IP publiques portables sont disponibles pour le cluster, le service d'équilibrage de charge est automatiquement créé.
    <li><pre class="screen"><code>Requested cloud provider IP <cloud-provider-ip> is not available. The following cloud provider IPs are available: <available-cloud-provider-ips</code></pre></br>Vous avez défini une adresse IP publique portable pour votre service d'équilibrage de charge à l'aide de la section **loadBalancerIP**, or, cette adresse IP publique portable n'est pas disponible dans votre sous-réseau public portable. Modifiez le script de configuration de votre service d'équilibrage de charge et choisissez l'une des adresses IP publiques portables disponibles ou retirez la section **loadBalancerIP** de votre script de sorte qu'une adresse IP publique portable puisse être allouée automatiquement.
    <li><pre class="screen"><code>No available nodes for load balancer services</code></pre>Vous ne disposez pas de suffisamment de noeuds d'agent pour déployer un service d'équilibrage de charge. Il se pourrait que vous ayez déployé un cluster standard avec plusieurs noeuds d'agent, mais que la mise à disposition des noeuds d'agent ait échoué.
<ol><li>Affichez la liste des noeuds d'agent disponibles.</br><pre class="codeblock"><code>kubectl get nodes</code></pre>
    <li>Si au moins deux noeuds d'agent disponibles sont trouvés, affichez les détails de ces noeuds d'agent. </br><pre class="screen"><code>bx cs worker-get <worker_ID></code></pre>
    <li>Assurez-vous que les ID VLAN public et privé des noeuds d'agent qui ont été renvoyés par les commandes 'kubectl get nodes' et 'bx cs worker-get' correspondent. </ol></ul></ul>

4.  Si vous utilisez un domaine personnalisé pour vous connecter à votre service d'équilibrage de charge, assurez-vous que votre domaine personnalisé est mappé à l'adresse IP publique de votre service d'équilibrage de charge. 
    1.  Identifiez l'adresse IP publique de votre service d'équilibrage de charge. 

      ```
      kubectl describe service <myservice> | grep "LoadBalancer Ingress"
      ```
      {: pre}

    2.  Assurez-vous que votre domaine personnalisé est mappé à l'adresse IP publique portable de votre service d'équilibrage de charge dans le pointeur (enregistrement PTR).

## Problèmes connus
{: #cs_known_issues}

Prenez connaissance des problèmes connus.
{: shortdesc}

### Clusters
{: #ki_clusters}

<dl>
  <dt>Les applications Cloud Foundry dans le même espace {{site.data.keyword.Bluemix_notm}} ne parviennent pas à accéder à un cluster</dt>
    <dd>Lorsque vous créez un cluster Kubernetes, celui-ci est créé au niveau du compte et n'utilise pas l'espace, sauf si vous liez des services
{{site.data.keyword.Bluemix_notm}}. Si vous disposez d'une application Cloud Foundry
à laquelle doit accéder le cluster, vous devez rendre l'application Cloud Foundry disponible au public ou rendre l'application dans votre cluster [disponible au public](cs_planning.html#cs_planning_public_network).</dd>
  <dt>Le service NodePort du tableau de bord Kubernetes a été désactivé.</dt>
    <dd>Pour des raisons de sécurité, le service NodePort du tableau de bord Kubernetes est désactivé. Pour accéder à votre tableau de bord Kubernetes, exécutez la commande ci-après.</br><pre class="codeblock"><code>kubectl proxy</code></pre></br>Vous pouvez ensuite accéder au tableau de bord Kubernetes à l'adresse URL suivante : `http://localhost:8001/ui`.</dd>
  <dt>Limitations liées au type de service d'équilibrage de charge</dt>
    <dd><ul><li>Vous ne pouvez pas utiliser l'équilibrage de charge sur des VLAN privés.<li>Vous ne pouvez pas utiliser des annotations de service
service.beta.kubernetes.io/external-traffic et
service.beta.kubernetes.io/healthcheck-nodeport. Pour plus d'informations sur ces annotations, voir la [documentation Kubernetes![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/tutorials/services/source-ip/).</ul></dd>
  <dt>La mise à l'échelle horizontale automatique ne fonctionne pas</dt>
    <dd>Pour des raisons de sécurité, le port standard utilisé par Heapster (10255) est fermé dans tous les noeuds d'agent. Vu que ce port est fermé, Heapster ne peut pas renvoyer de métriques pour les noeuds d'agent et la mise à l'échelle horizontale automatique ne fonctionne pas comme indiqué dans [Horizontal Pod Autoscaling ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/) dans la documentation Kubernetes. </dd>
</dl>

### Stockage persistant
{: #persistent_storage}

La commande `kubectl describe <pvc_name>` affiche **ProvisioningFailed** our une réservation de volume persistant :
<ul><ul>
<li>Lorsque vous créez une réservation de volume persistant, aucun volume persistant n'est disponible, par conséquent, Kubernetes renvoie le message **ProvisioningFailed**.
<li>Lorsque le volume persistant est créé et lié à la réservation, Kubernetes renvoie le message **ProvisioningSucceeded**. Ce processus peut prendre quelques minutes.
</ul></ul>

## Aide et assistance
{: #ts_getting_help}

Par où commencer pour traiter les incidents liés à un conteneur ?

-   Pour déterminer si {{site.data.keyword.Bluemix_notm}} est disponible, [consultez la page de statut de {{site.data.keyword.Bluemix_notm}} ![External link icon](../icons/launch-glyph.svg "External link icon")](https://developer.ibm.com/bluemix/support/#status).
-   Publiez une question sur le site [{{site.data.keyword.containershort_notm}} Slack. ![External link icon](../icons/launch-glyph.svg "External link icon")](https://ibm-container-service.slack.com) Si vous n'utilisez pas un IBMid pour votre compte {{site.data.keyword.Bluemix_notm}}, écrivez à l'adresse [crosen@us.ibm.com](mailto:crosen@us.ibm.com) et demandez une invitation pour ce site Slack.
-   Consultez les forums pour établir si d'autres utilisateurs ont rencontré le même problème. Lorsque vous utilisez les forums pour poser une question, balisez votre question de sorte que les équipes de développement {{site.data.keyword.Bluemix_notm}} la voient.

    -   Si vous avez des questions d'ordre technique sur le développement ou le déploiement de clusters ou d'applications à l'aide d'{{site.data.keyword.containershort_notm}}, publiez-les sur le site [Stack Overflow ![External link icon](../icons/launch-glyph.svg "External link icon")](http://stackoverflow.com/search?q=bluemix+containers) en leur adjoignant les balises `ibm-bluemix`, `kubernetes` et `containers`.
    -   Pour des questions relatives au service et aux instructions de mise en route, utilisez le forum [IBM developerWorks dW Answers ![External link icon](../icons/launch-glyph.svg "External link icon")](https://developer.ibm.com/answers/topics/containers/?smartspace=bluemix). Incluez
les balises `bluemix` et `containers`.
    Voir [Comment obtenir de l'aide](/docs/support/index.html#getting-help)
pour plus d'informations sur l'utilisation des forums.

-   Contactez le support IBM. Pour plus d'informations sur l'ouverture d'un ticket de demande de service IBM, sur les niveaux de support disponibles ou les niveaux de gravité des tickets, voir la rubrique décrivant [comment contacter le support](/docs/support/index.html#contacting-support).
