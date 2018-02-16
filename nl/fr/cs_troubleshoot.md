---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-09"

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

Lorsque vous utilisez {{site.data.keyword.containershort_notm}}, tenez compte des techniques décrites ci-dessous pour identifier et résoudre les incidents et obtenir de l'aide. Vous pouvez également vérifier le [statut du système {{site.data.keyword.Bluemix_notm}} ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://developer.ibm.com/bluemix/support/#status).

Vous pouvez effectuer quelques étapes générales pour vérifier que vos clusters sont à jour :
- [Redémarrez vos noeuds d'agent](cs_cli_reference.html#cs_worker_reboot) régulièrement pour garantir l'installation des mises à jour et des correctifs de sécurité déployés automatiquement par IBM sur le système d'exploitation
- Mettez à jour votre cluster à [la dernière version par défaut de Kubernetes](cs_versions.html) pour {{site.data.keyword.containershort_notm}}

{: shortdesc}

<br />




## Débogage des clusters
{: #debug_clusters}

Passez en revue les options permettant de déboguer vos clusters et d'identifier les causes premières des échecs.

1.  Affichez votre cluster et identifiez son état (`State`).

  ```
  bx cs clusters
  ```
  {: pre}

2.  Examinez l'état (`State`) de votre cluster.

  <table summary="Chaque ligne de tableau doit être lue de gauche à droite. L'état du cluster figure dans la première colonne et la description correspondante dans la seconde colonne.">
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
        <td>Le maître Kubernetes est déployé. La mise à disposition des noeuds d'agent est en cours. Ces derniers ne sont pas encore disponibles dans le cluster. Vous pouvez accéder au cluster, mais vous ne pouvez pas déployer d'applications sur le cluster.</td>
      </tr>
      <tr>
        <td>Normal</td>
        <td>Tous les noeuds d'agent d'un cluster sont opérationnels. Vous pouvez accéder au cluster et déployer les applications sur le cluster.</td>
     </tr>
     <tr>
        <td>Warning</td>
        <td>Au moins un noeud worker du cluster n'est pas disponible. Cela dit, les autres noeuds d'agent sont disponibles et peuvent prendre le relais pour la charge de travail.</td>
     </tr>
     <tr>
      <td>Critical</td>
      <td>Le maître Kubernetes est inaccessible ou tous les noeuds d'agent du cluster sont arrêtés.</td>
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
    <th>Etat du noeud worker</th>
    <th>Description</th>
    </thead>
    <tbody>
      <tr>
       <td>Unknown</td>
       <td>Le maître Kubernetes est inaccessible pour l'une des raisons suivantes :<ul><li>Vous avez demandé une mise à jour de votre maître Kubernetes. L'état du noeud worker ne peut pas être extrait lors de la mise à jour.</li><li>Peut-être possédez-vous un pare-feu qui protège vos noeuds d'agent ou avez-vous récemment modifié vos paramètres de pare-feu. {{site.data.keyword.containershort_notm}} requiert que certaines adresses IP et certains ports soient ouverts pour permettre la communication entre le noeud worker et le maître Kubernetes et inversement. Pour plus d'informations, voir [Pare-feu empêchant la connexion des noeuds d'agent](#cs_firewall).</li><li>Le maître Kubernetes est arrêté. Contactez le support {{site.data.keyword.Bluemix_notm}} en ouvrant un [ticket de demande de service {{site.data.keyword.Bluemix_notm}}](/docs/support/index.html#contacting-support).</li></ul></td>
      </tr>
      <tr>
        <td>Provisioning</td>
        <td>La mise à disposition de votre noeud worker est en cours. Ce dernier n'est pas encore disponible dans le cluster. Vous pouvez surveiller le processus de mise à disposition dans la colonne **Status** de la sortie générée par l'interface de ligne de commande. Si votre noeud worker est bloqué dans cet état depuis un certain temps et vous ne voyez aucune progression dans la colonne **Status**, passez à l'étape suivante pour voir si un problème s'est produit lors de la mise à disposition.</td>
      </tr>
      <tr>
        <td>Provision_failed</td>
        <td>Votre noeud worker n'a pas pu être mis à disposition. Passez à l'étape suivante pour rechercher les détails relatifs à cet échec.</td>
      </tr>
      <tr>
        <td>Reloading</td>
        <td>Le rechargement de votre noeud worker est en cours. Ce dernier n'est pas disponible dans le cluster. Vous pouvez surveiller le processus de rechargement dans la colonne **Status** de la sortie générée par l'interface de ligne de commande. Si votre noeud worker est bloqué dans cet état depuis un certain temps et vous ne voyez aucune progression dans la colonne **Status**, passez à l'étape suivante pour voir si un problème s'est produit lors du rechargement.</td>
       </tr>
       <tr>
        <td>Reloading_failed</td>
        <td>Votre noeud worker n'a pas pu être rechargé. Passez à l'étape suivante pour rechercher les détails relatifs à cet échec.</td>
      </tr>
      <tr>
        <td>Normal</td>
        <td>Votre noeud worker est entièrement mis à disposition et il est prêt à être utilisé dans le cluster.</td>
     </tr>
     <tr>
        <td>Warning</td>
        <td>Votre noeud worker est sur le point d'atteindre la limite en termes de mémoire ou d'espace disque.</td>
     </tr>
     <tr>
      <td>Critical</td>
      <td>Votre noeud worker ne dispose plus de suffisamment d'espace disque.</td>
     </tr>
    </tbody>
  </table>

4.  Affichez la liste des détails relatifs à votre noeud worker.

  ```
  bx cs worker-get [<cluster_name_or_id>] <worker_node_id>
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
        <td>Exception liée à l'infrastructure {{site.data.keyword.Bluemix_notm}} : votre compte n'est pas autorisé à réserver des instances de traitement pour l'instant.</td>
        <td>La réservation de ressources de traitement par votre compte d'infrastructure IBM Cloud (SoftLayer) n'est peut-être pas possible. Contactez le support {{site.data.keyword.Bluemix_notm}} en ouvrant un [ticket de demande de service {{site.data.keyword.Bluemix_notm}}](/docs/support/index.html#contacting-support).</td>
      </tr>
      <tr>
        <td>Exception liée à l'infrastructure {{site.data.keyword.Bluemix_notm}} : impossible de passer la commande. Les ressources derrière le routeur 'router_name' ne sont pas suffisantes pour satisfaire la demande pour les invités suivants : 'worker_id'.</td>
        <td>Le réseau local virtuel que vous avez sélectionné est associé à un pod du centre de données dont l'espace n'est pas suffisant pour mettre à disposition votre noeud worker. Plusieurs possibilités s'offrent à vous :<ul><li>Utilisez un autre centre de données pour mettre à disposition votre noeud worker. Exécutez la commande <code>bx cs locations</code> pour afficher la liste des centres de données disponibles.<li>Si vous possédez déjà une paire de réseaux locaux virtuels public et privé associée à un autre pod du centre de données, utilisez-la à la place.<li>Contactez le support {{site.data.keyword.Bluemix_notm}} en ouvrant un [ticket de demande de service {{site.data.keyword.Bluemix_notm}}](/docs/support/index.html#contacting-support).</ul></td>
      </tr>
      <tr>
        <td>Exception liée à l'infrastructure {{site.data.keyword.Bluemix_notm}} : impossible d'obtenir le réseau local virtuel portant l'ID : &lt;vlan id&gt;.</td>
        <td>Votre noeud worker n'a pas pu être mis à disposition car l'ID de réseau local virtuel sélectionné est introuvable pour l'une des raisons suivantes :<ul><li>Vous avez indiqué le numéro de réseau local virtuel au lieu de l'ID de réseau local virtuel. Le numéro de réseau local virtuel est composé de 3 ou 4 chiffres, tandis que l'ID de réseau local virtuel est composé de 7 chiffres. Exécutez la commande <code>bx cs vlans &lt;location&gt;</code> pour extraire l'ID de réseau local virtuel.<li>L'ID de réseau local virtuel (VLAN) n'est peut-être pas associé au compte d'infrastructure IBM Cloud (SoftLayer) que vous utilisez. Exécutez la commande <code>bx cs vlans &lt;location&gt;</code> pour afficher la liste des ID de réseau local virtuel disponibles pour votre compte. Pour modifier le compte d'infrastructure IBM Cloud (SoftLayer), voir la rubrique sur la commande [bx cs credentials-set](cs_cli_reference.html#cs_credentials_set). </ul></td>
      </tr>
      <tr>
        <td>SoftLayer_Exception_Order_InvalidLocation : l'emplacement fourni pour cette commande n'est pas valide. (HTTP 500)</td>
        <td>L'infrastructure IBM Cloud (SoftLayer) n'est pas configurée pour commander des ressources de traitement dans le centre de données sélectionné. Contactez le [support {{site.data.keyword.Bluemix_notm}} ](/docs/support/index.html#contacting-support) pour vérifier que votre compte est correctement configuré.</td>
       </tr>
       <tr>
        <td>Exception liée à l'infrastructure {{site.data.keyword.Bluemix_notm}} : l'utilisateur ne dispose pas des droits sur l'infrastructure {{site.data.keyword.Bluemix_notm}} nécessaires pour ajouter des serveurs

        </br></br>
        Exception liée à l'infrastructure {{site.data.keyword.Bluemix_notm}} : des droits sont nécessaires pour réserver 'Item'.</td>
        <td>Vous ne disposez peut-être pas des droits nécessaires pour mettre à disposition un noeud worker à partir du portefeuille d'infrastructure IBM Cloud (SoftLayer). Voir [Configuration de l'accès au portefeuille d'infrastructure IBM Cloud (SoftLayer) pour créer des clusters Kubernetes standard](cs_infrastructure.html#unify_accounts).</td>
      </tr>
    </tbody>
  </table>

<br />




## Débogage de déploiements d'application
{: #debug_apps}

Passez en revue les options dont vous disposez pour déboguer vos déploiements d'application et identifier les causes premières des échecs.

1. Recherchez les anomalies dans les ressources de service ou de déploiement en exécutant la commande `describe`.

 Exemple :
 <pre class="pre"><code>kubectl describe service &lt;service_name&gt; </code></pre>

2. [Vérifiez si les conteneurs sont bloqués à l'état ContainerCreating](#stuck_creating_state).

3. Vérifiez si le cluster est à l'état `Critical`. S'il est à l'état `Critical`, consultez les règles de pare-feu et vérifiez que le maître peut communiquer avec les noeuds d'agent.

4. Vérifiez que le service est à l'écoute sur le port correct.
   1. Obtenez le nom d'un pod.
     <pre class="pre"><code>kubectl get pods</code></pre>
   2. Connectez-vous à un conteneur.
     <pre class="pre"><code>kubectl exec -it &lt;pod_name&gt; -- /bin/bash</code></pre>
   3. Exécutez la commande curl pour l'application à partir du conteneur. Si le port n'est pas accessible, il se peut que le service ne soit pas à l'écoute sur le port approprié ou que l'application comporte des erreurs. Mettez à jour le fichier de configuration pour le service avec le port correct et redéployez ou recherchez les erreurs potentielles liées à l'application.
     <pre class="pre"><code>curl localhost: &lt;port&gt;</code></pre>

5. Vérifiez que le service est lié correctement aux pods.
   1. Obtenez le nom d'un pod.
     <pre class="pre"><code>kubectl get pods</code></pre>
   2. Connectez-vous à un conteneur.
     <pre class="pre"><code>kubectl exec -it &lt;pod_name&gt; -- /bin/bash</code></pre>
   3. Exécutez la commande curl sur l'adresse IP et le port du cluster du service. Si l'adresse IP et le port ne sont pas accessibles, examinez les noeuds finaux du service. S'il n'y a pas de noeuds finaux, le sélecteur du service ne trouvent pas les pods. S'il y a des noeuds finaux, examinez la zone du port cible sur le service et assurez-vous que ce port est identique à celui utilisé pour les pods.
     <pre class="pre"><code>curl &lt;cluster_IP&gt;:&lt;port&gt;</code></pre>

6. Pour les services Ingress, vérifiez que le service est accessible depuis le cluster.
   1. Obtenez le nom d'un pod.
     <pre class="pre"><code>kubectl get pods</code></pre>
   2. Connectez-vous à un conteneur.
     <pre class="pre"><code>kubectl exec -it &lt;pod_name&gt; -- /bin/bash</code></pre>
   2. Exécutez la commande curl sur l'URL indiquée pour le service Ingress. Si l'URL n'est pas accessible, recherchez une erreur de pare-feu entre le cluster et le noeud final externe. 
     <pre class="pre"><code>curl &lt;host_name&gt;.&lt;domain&gt;</code></pre>

<br />


## Impossible de se connecter à votre compte d'infrastructure
{: #cs_credentials}

{: tsSymptoms}
Lorsque vous créez un nouveau cluster Kubernetes, vous rencontrez le message suivant.

```
We were unable to connect to your IBM Cloud infrastructure (SoftLayer) account.
La création d'un cluster standard nécessite un compte de type Paiement à la carte lié aux
conditions d'un compte de l'infrastructure IBM Cloud (SoftLayer) ou d'avoir utilisé l'interface de ligne de commande {{site.data.keyword.Bluemix_notm}}
Container Service pour définir vos clés d'API d'{{site.data.keyword.Bluemix_notm}} Infrastructure.
```
{: screen}

{: tsCauses}
Les utilisateurs disposant d'un compte {{site.data.keyword.Bluemix_notm}} non lié doivent créer un nouveau compte de type Paiement à la carte ou ajouter manuellement des clés d'API d'infrastructure IBM Cloud (SoftLayer) à l'aide de l'interface CLI de {{site.data.keyword.Bluemix_notm}}.

{: tsResolve}
Pour ajouter des données d'identification à votre compte {{site.data.keyword.Bluemix_notm}} :

1.  Contactez l'administrateur de l'infrastructure IBM Cloud (SoftLayer) pour obtenir votre nom d'utilisateur d'infrastructure IBM Cloud (SoftLayer) et la clé d'API.

    **Remarque : ** le compte d'infrastructure IBM Cloud (SoftLayer) que vous utilisez doit être configuré avec des droits Superutilisateur pour vous permettre de créer des clusters standard.

2.  Ajoutez les données d'identification.

  ```
  bx cs credentials-set --infrastructure-username <username> --infrastructure-api-key <api_key>
  ```
  {: pre}

3.  Créez un cluster standard.

  ```
  bx cs cluster-create --location dal10 --public-vlan my_public_vlan_id --private-vlan my_private_vlan_id --machine-type u2c.2x4 --name my_cluster --hardware shared --workers 2
  ```
  {: pre}

<br />


## Le pare-feu empêche l'exécution de commandes via la ligne de commande
{: #ts_firewall_clis}

{: tsSymptoms}
Lorsque vous exécutez des commandes `bx`, `kubectl` ou `calicoctl` depuis l'interface de ligne de commande, ces commandes échouent.

{: tsCauses}
Des règles réseau d'entreprise empêchent peut-être l'accès depuis votre système local à des noeuds finaux publics via des proxies ou des pare-feux.

{: tsResolve}
[Autorisez l'accès TCP afin que les commandes CLI fonctionnent](cs_firewall.html#firewall). Cette tâche nécessite d'utiliser une [règle d'accès administrateur](cs_users.html#access_policies). Vérifiez votre [règle d'accès actuelle](cs_users.html#infra_access).


## Le pare-feu empêche le cluster de se connecter aux ressources
{: #cs_firewall}

{: tsSymptoms}
Lorsque les connexions des noeuds d'agent sont impossibles, vous pourrez voir toute une série de symptômes différents. Vous pourrez obtenir l'un des messages suivants en cas d'échec de la commande kubectl proxy ou si vous essayez d'accéder à un service dans votre cluster et que la connexion échoue.

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

Si vous exécutez les commandes kubectl exec, attach ou logs, le message suivant peut s'afficher.

  ```
  Error from server: error dialing backend: dial tcp XXX.XXX.XXX:10250: getsockopt: connection timed out
  ```
  {: screen}

Si la commande kubectl proxy aboutit, mais que le tableau de bord n'est pas disponible, vous pourrez voir le message suivant.

  ```
  timeout on 172.xxx.xxx.xxx
  ```
  {: screen}



{: tsCauses}
Vous pouvez disposer d'un pare-feu supplémentaire configuré ou avoir personnalisé vos paramètres de pare-feu existants dans votre compte d'infrastructure IBM Cloud (SoftLayer). {{site.data.keyword.containershort_notm}} requiert que certaines adresses IP et certains ports soient ouverts pour permettre la communication entre le noeud worker et le maître Kubernetes et inversement. Une autre cause peut être que les noeuds d'agent soient bloqués dans une boucle de rechargement.

{: tsResolve}
[Autorisez le cluster à accéder aux ressources d'infrastructure et à d'autres services](cs_firewall.html#firewall_outbound). Cette tâche nécessite d'utiliser une [règle d'accès administrateur](cs_users.html#access_policies). Vérifiez votre [règle d'accès actuelle](cs_users.html#infra_access).

<br />



## L'accès à votre noeud worker à l'aide de SSH échoue
{: #cs_ssh_worker}

{: tsSymptoms}
Vous ne pouvez pas accéder à votre noeud worker à l'aide d'une connexion SSH.

{: tsCauses}
L'accès SSH via un mot de passe est désactivé sur les noeuds d'agent.

{: tsResolve}
Utilisez des [ensembles de démons ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) pour tout ce que vous devez exécuter sur chaque noeud ou des travaux pour toutes les actions ponctuelles que vous devez exécuter.

<br />



## La liaison d'un service à un cluster renvoie une erreur due à une utilisation du même nom
{: #cs_duplicate_services}

{: tsSymptoms}
Lorsque vous exécutez la commande `bx cs cluster-service-bind <cluster_name> <namespace> <service_instance_name>`, le message suivant s'affiche. 

```
Multiple services with the same name were found.
Run 'bx service list' to view available Bluemix service instances...
```
{: screen}

{: tsCauses}
Il se peut que plusieurs instances de service aient le même nom dans différentes régions.

{: tsResolve}
Utilisez l'identificateur global unique (GUID) du service au lieu du nom de l'instance de service dans la commande `bx cs cluster-service-bind`.

1. [Connectez-vous à la région hébergeant l'instance de service à lier.](cs_regions.html#bluemix_regions)

2. Extrayez l'identificateur global unique (GUID) de l'instance de service.
  ```
  bx service show <service_instance_name> --guid
  ```
  {: pre}

  Sortie :
  ```
  Invoking 'cf service <service_instance_name> --guid'...
  <service_instance_GUID>
  ```
  {: screen}
3. Liez à nouveau le service au cluster.
  ```
  bx cs cluster-service-bind <cluster_name> <namespace> <service_instance_GUID>
  ```
  {: pre}

<br />



## Après avoir mis à jour ou rechargé un noeud worker, des noeuds et des pods en double apparaissent
{: #cs_duplicate_nodes}

{: tsSymptoms}
Lorsque vous exécutez la commande `kubectl get nodes`, vous voyez des noeuds d'agent en double avec le statut **NotReady**. Les noeuds d'agent avec le statut **NotReady** ont des adresses IP publiques, alors que les noeuds d'agent avec le statut **Ready** ont des adresses IP privées.

{: tsCauses}
D'anciens clusters avaient des noeuds d'agent répertoriés par l'adresse IP publique du cluster. A présent, les noeuds d'agent sont répertoriés par l'adresse IP privée du cluster. Lorsque vous rechargez ou mettez à jour un noeud, l'adresse IP est modifiée, mais la référence à l'adresse IP publique est conservée.

{: tsResolve}
Il n'y a aucune interruption de service due à ces doublons, mais vous devez retirer les références des anciens noeuds d'agent du serveur d'API.

  ```
  kubectl delete node <node_name1> <node_name2>
  ```
  {: pre}

<br />




## Echec de l'accès à un pod sur un nouveau noeud worker et dépassement du délai d'attente
{: #cs_nodes_duplicate_ip}

{: tsSymptoms}
Vous avez supprimé un noeud worker dans votre cluster et ajouté un noeud worker. Lorsque vous avez déployé un pod ou un service Kubernetes, la ressource n'a pas pu accéder au noeud worker nouvellement créé et un dépassement de délai d'attente s'est produit pour la connexion.

{: tsCauses}
Si vous supprimez un noeud worker de votre cluster et que vous ajoutez un noeud worker, il se peut que l'adresse IP privée du noeud worker supprimé soit affectée au nouveau noeud worker. Calico utilise cette adresse IP privée en tant que balise et continue d'essayer d'atteindre le noeud supprimé.

{: tsResolve}
Mettez manuellement à jour la référence de l'adresse IP privée pour qu'elle pointe vers le noeud approprié.

1.  Vérifiez que vous possédez deux noeuds d'agent associés à la même **adresse IP privée**. Notez l'**adresse IP privée** et l'**ID** de l'agent supprimé.

  ```
  bx cs workers <CLUSTER_NAME>
  ```
  {: pre}

  ```
  ID                                                 Public IP       Private IP       Machine Type   State     Status
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w1   192.0.2.0.12   203.0.113.144   b2c.4x16       normal    Ready
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w2   192.0.2.0.16   203.0.113.144   b2c.4x16       deleted    -
  ```
  {: screen}

2.  Installez l'[interface de ligne de commande Calico](cs_network_policy.html#adding_network_policies).
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

4.  Supprimez le noeud worker en double dans Calico. Remplacez NODE_ID par l'ID du noeud worker.

  ```
  calicoctl delete node NODE_ID --config=<path_to_file>/calicoctl.cfg
  ```
  {: pre}

5.  Redémarre le noeud worker qui n'a pas été supprimé.

  ```
  bx cs worker-reboot CLUSTER_ID NODE_ID
  ```
  {: pre}


Le noeud supprimé n'apparaît plus dans Calico.

<br />




## Des pods sont toujours en attente
{: #cs_pods_pending}

{: tsSymptoms}
Lorsque vous exécutez `kubectl get pods`, vous constatez que des pods sont toujours à l'état **pending**.

{: tsCauses}
Si vous venez juste de créer le cluster Kubernetes, il se peut que les noeuds d'agent soient encore en phase de configuration. S'il s'agit d'un cluster existant, sa capacité est peut-être insuffisante pour y déployer le pod.

{: tsResolve}
Cette tâche nécessite d'utiliser une [règle d'accès administrateur](cs_users.html#access_policies). Vérifiez votre [règle d'accès actuelle](cs_users.html#infra_access).

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

3.  Vérifiez que vous disposez de suffisamment de capacité dans votre cluster pour déployer le pod.

4.  Si vous ne disposez pas de suffisamment de capacité dans votre cluster, ajoutez un autre noeud worker à celui-ci.

  ```
  bx cs worker-add <cluster name or id> 1
  ```
  {: pre}

5.  Si vos pods sont toujours à l'état **pending** après le déploiement complet du noeud worker, consultez la [documentation Kubernetes![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/tasks/debug-application-cluster/debug-pod-replication-controller/#my-pod-stays-pending) pour effectuer d'autres tâches en vue d'identifier et de résoudre le problème.

<br />




## Les pods sont bloqués à l'état de création
{: #stuck_creating_state}

{: tsSymptoms}
Lorsque vous exécutez la commande `kubectl get pods -o wide`, vous voyez que plusieurs pods qui s'exécutent sur le même noeud worker sont bloqués à l'état `ContainerCreating`.

{: tsCauses}
Le système de fichiers sur le noeud worker est en lecture seule.

{: tsResolve}
1. Sauvegardez les données éventuelles stockées sur le noeud worker ou dans vos conteneurs.
2. Régénérez le noeud worker en exécutant la commande suivante.

<pre class="pre"><code>bx cs worker-reload &lt;cluster_name&gt; &lt;worker_id&gt;</code></pre>

<br />




## Les conteneurs ne démarrent pas
{: #containers_do_not_start}

{: tsSymptoms}
Les pods se déploient sur les clusters, mais les conteneurs ne démarrent pas.

{: tsCauses}
Il peut arriver que les conteneurs ne démarrent pas lorsque le quota de registre est atteint.

{: tsResolve}
[Libérez de l'espace de stockage dans {{site.data.keyword.registryshort_notm}}.](../services/Registry/registry_quota.html#registry_quota_freeup)

<br />




## Les journaux ne s'affichent pas
{: #cs_no_logs}

{: tsSymptoms}
Lorsque vous accéder au tableau de bord Kibana, les journaux ne s'affichent pas.

{: tsResolve}
Ci-dessous figurent les motifs pour lesquels les journaux peuvent ne pas apparaître, ainsi que les étapes de résolution correspondantes :

<table>
<col width="40%">
<col width="60%">
 <thead>
 <th>Motifs</th>
 <th>Procédure de résolution du problème</th>
 </thead>
 <tbody>
 <tr>
 <td>Aucune configuration de journalisation n'a été définie.</td>
 <td>Pour que les journaux soient envoyés, vous devez d'abord créer une configuration de journalisation visant à acheminer les journaux à {{site.data.keyword.loganalysislong_notm}}. Pour créer une configuration de journalisation, voir <a href="cs_health.html#log_sources_enable">Activation du transfert de journaux</a>.</td>
 </tr>
 <tr>
 <td>L'état du cluster n'indique pas <code>Normal</code>.</td>
 <td>Pour vérifier l'état de votre cluster, voir <a href="cs_troubleshoot.html#debug_clusters">Débogage des clusters</a>.</td>
 </tr>
 <tr>
 <td>Le quota de stockage des journaux a été atteint.</td>
 <td>Pour augmenter vos limites de stockage de journaux, reportez-vous à la <a href="/docs/services/CloudLogAnalysis/troubleshooting/error_msgs.html#error_msgs">Documentation d'{{site.data.keyword.loganalysislong_notm}}</a>.</td>
 </tr>
 <tr>
 <td>Si vous avez spécifié un espace lors de la création du cluster, les droits d'accès Responsable, Développeur  ou Auditeur n'ont pas été affectées au propriétaire du compte sur cet espace.</td>
 <td>Pour modifier les droits d'accès du propriétaire du compte :<ol><li>Pour identifier le propriétaire du compte pour le cluster, exécutez la commande <code>bx cs api-key-info &lt;cluster_name_or_id&gt;</code>.</li><li>Pout attribuer au propriétaire du compte les droits d'accès Responsable, Développeur ou Auditeur dans {{site.data.keyword.containershort_notm}} sur cet espace, voir <a href="cs_users.html#managing">Gestion de l'accès au cluster</a>.</li><li>Pour actualiser le jeton d'accès après que les droits d'accès ont été modifiés, exécutez la commande <code>bx cs logging-config-refresh &lt;cluster_name_or_id&gt;</code>.</li></ol></td>
 </tr>
 </tbody></table>

Pour tester les modifications apportées lors de la résolution des incidents, vous pouvez déployer l'exemple de pod Noisy, lequel génère plusieurs événements de journal sur un noeud worker dans votre cluster.

  1. [Ciblez avec votre interface de ligne de commande](cs_cli_install.html#cs_cli_configure) le cluster dans lequel vous voulez lancer la génération de journaux.

  2. Créez le fichier de configuration `deploy-noisy.yaml`.

      ```
      apiVersion: v1
      kind: Pod
      metadata:
        name: noisy
      spec:
        containers:
        - name: noisy
          image: ubuntu:16.04
          command: ["/bin/sh"]
          args: ["-c", "while true; do sleep 10; echo 'Hello world!'; done"]
          imagePullPolicy: "Always"
        ```
        {: codeblock}

  3. Exécutez le fichier de configuration dans le contexte de cluster.

        ```
        kubectl apply -f <filepath_to_noisy>
        ```
        {:pre}

  4. Au bout de quelques minutes, vos journaux s'affichent dans le tableau de bord Kibana. Pour accéder au tableau de bord Kibana, accédez à l'une des URL suivantes et sélectionnez le compte {{site.data.keyword.Bluemix_notm}} dans lequel vous avez créé le cluster. Si vous avez spécifié un espace lors de la création du cluster, accédez à la place à cet espace.
        - Sud et Est des Etats-Unis : https://logging.ng.bluemix.net
        - Sud du Royaume-Uni et Europe centrale : https://logging.eu-fra.bluemix.net
        - Asie-Pacifique sud : https://logging.au-syd.bluemix.net

<br />




## Le tableau de bord Kubernetes n'affiche pas de graphiques d'utilisation
{: #cs_dashboard_graphs}

{: tsSymptoms}
Lorsque vous accéder au tableau de bord Kubernetes, les graphiques d'utilisation ne s'affichent pas.

{: tsCauses}
Parfois, après la mise à jour d'un cluster ou le réamorçage d'un noeud worker, le pod `kube-dashboard` ne se met pas à jour.

{: tsResolve}
Supprimez le pod `kube-dashboard` pour forcer un redémarrage. Le pod est recréé avec des règles RBAC afin d'accéder à heapster pour obtenir les informations d'utilisation.

  ```
  kubectl delete pod -n kube-system $(kubectl get pod -n kube-system --selector=k8s-app=kubernetes-dashboard -o jsonpath='{.items..metadata.name}')
  ```
  {: pre}

<br />


## Impossible de se connecter à une application via un service d'équilibreur de charge
{: #cs_loadbalancer_fails}

{: tsSymptoms}
Vous avez exposé votre application au public en créant un service d'équilibreur de charge dans votre cluster. Lorsque vous avez essayé de vous connecter à votre application via l'adresse IP publique de l'équilibreur de charge, la connexion a échoué ou expiré.

{: tsCauses}
Il se peut que le service d'équilibreur de charge ne fonctionne pas correctement pour l'une des raisons suivantes :

-   Le cluster est un cluster léger ou un cluster standard avec un seul noeud worker.
-   Le cluster n'est pas encore complètement déployé.
-   Le script de configuration pour votre service d'équilibreur de charge comporte des erreurs.

{: tsResolve}
Pour identifier et résoudre les problèmes liés à votre service d'équilibreur de charge :

1.  Prenez soin de configurer un cluster standard qui est entièrement déployé et qui comporte au moins deux noeuds d'agent afin d'assurer la haute disponibilité de votre service d'équilibreur de charge.

  ```
  bx cs workers <cluster_name_or_id>
  ```
  {: pre}

    Dans la sortie générée par votre interface de ligne de commande, vérifiez que la valeur **Ready** apparaît dans la zone **Status** pour vos noeuds d'agent et qu'une valeur autre **free** est spécifiée dans la zone **Machine Type**

2.  Vérifiez que le fichier de configuration du service d'équilibreur de charge est correct.

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

    1.  Vérifiez que vous avez défini **LoadBalancer** comme type de service.
    2.  Vérifiez que vous avez utilisé les mêmes valeurs **<selectorkey>** et **<selectorvalue>** que celles que vous aviez spécifiées dans la section **label/metadata** lors du déploiement de votre application.
    3.  Vérifiez que vous avez utilisé le **port** sur lequel votre application est en mode écoute.

3.  Vérifiez votre service d'équilibreur de charge et passez en revue la section **Events** à la recherche d'éventuelles erreurs.

  ```
  kubectl describe service <myservice>
  ```
  {: pre}

    Recherchez les messages d'erreur suivants :

    <ul><li><pre class="screen"><code>Clusters with one node must use services of type NodePort</code></pre></br>Pour utiliser le service d'équilibreur de charge, vous devez disposer d'un cluster standard et d'au moins deux noeuds d'agent.</li>
    <li><pre class="screen"><code>No cloud provider IPs are available to fulfill the load balancer service request. Add a portable subnet to the cluster and try again</code></pre></br>Ce message d'erreur indique qu'il ne reste aucune adresse IP publique portable à attribuer à votre service d'équilibreur de charge. Pour savoir comment demander des adresses IP publiques portables pour votre cluster, voir la rubrique <a href="cs_subnets.html#subnets">Ajout de sous-réseaux à des clusters</a>. Dès lors que des adresses IP publiques portables sont disponibles pour le cluster, le service d'équilibreur de charge est automatiquement créé.</li>
    <li><pre class="screen"><code>Requested cloud provider IP <cloud-provider-ip> is not available. The following cloud provider IPs are available: <available-cloud-provider-ips></code></pre></br>Vous avez défini une adresse IP publique portable pour votre service d'équilibreur de charge à l'aide de la section **loadBalancerIP**, or, cette adresse IP publique portable n'est pas disponible dans votre sous-réseau public portable. Modifiez le script de configuration de votre service d'équilibreur de charge et choisissez l'une des adresses IP publiques portables disponibles ou retirez la section **loadBalancerIP** de votre script de sorte qu'une adresse IP publique portable puisse être allouée automatiquement.</li>
    <li><pre class="screen"><code>No available nodes for load balancer services</code></pre>Vous ne disposez pas de suffisamment de noeuds d'agent pour déployer un service d'équilibreur de charge. Il se pourrait que vous ayez déployé un cluster standard avec plusieurs noeuds d'agent, mais que la mise à disposition des noeuds d'agent ait échoué.</li>
    <ol><li>Affichez la liste des noeuds d'agent disponibles.</br><pre class="codeblock"><code>kubectl get nodes</code></pre></li>
    <li>Si au moins deux noeuds d'agent disponibles sont trouvés, affichez les détails de ces noeuds d'agent.</br><pre class="screen"><code>bx cs worker-get [&lt;cluster_name_or_id&gt;] &lt;worker_ID&gt;</code></pre></li>
    <li>Vérifiez que les ID de VLAN privé et public pour les noeuds worker renvoyés par les commandes <code>kubectl get nodes</code> et <code>bx cs [&lt;cluster_name_or_id&gt;] worker-get</code> correspondent.</li></ol></li></ul>

4.  Si vous utilisez un domaine personnalisé pour vous connecter à votre service d'équilibreur de charge, assurez-vous que votre domaine personnalisé est mappé à l'adresse IP publique de votre service d'équilibreur de charge.
    1.  Identifiez l'adresse IP publique de votre service d'équilibreur de charge.

      ```
      kubectl describe service <myservice> | grep "LoadBalancer Ingress"
      ```
      {: pre}

    2.  Assurez-vous que votre domaine personnalisé est mappé à l'adresse IP publique portable de votre service d'équilibreur de charge dans le pointeur (enregistrement PTR).

<br />


## Impossible de se connecter à une application via Ingress
{: #cs_ingress_fails}

{: tsSymptoms}
Vous avez exposé votre application au public en créant une ressource Ingress pour votre application dans votre cluster. Lorsque vous avez essayé de vous connecter à votre application via l'adresse IP publique ou le sous-domaine du contrôleur Ingress, la connexion a échoué ou expiré.

{: tsCauses}
Il se peut qu'Ingress ne fonctionne pas correctement pour les raisons suivantes :
<ul><ul>
<li>Le cluster n'est pas encore complètement déployé.
<li>Le cluster a été configuré en tant que cluster léger ou en tant que cluster standard avec un seul noeud worker.
<li>Le script de configuration Ingress contient des erreurs.
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
    1.  Récupérez l'ID des pods Ingress qui sont en cours d'exécution dans votre cluster.

      ```
      kubectl get pods -n kube-system | grep alb1
      ```
      {: pre}

    2.  Récupérez les journaux pour chaque pod Ingress.

      ```
      kubectl logs <ingress_pod_id> -n kube-system
      ```
      {: pre}

    3.  Recherchez les messages d'erreur dans les journaux du contrôleur Ingress.

<br />



## Problèmes de valeur confidentielle de l'équilibreur de charge d'application Ingress
{: #cs_albsecret_fails}

{: tsSymptoms}
Après avoir déployé une valeur confidentielle d'équilibreur de charge d'application Ingress dans votre cluster, la zone `Description` n'est pas actualisée avec le nom de valeur confidentielle lorsque vous examinez votre certificat dans {{site.data.keyword.cloudcerts_full_notm}}.

Lorsque vous listez les informations sur la valeur confidentielle de l'équilibreur de charge, son statut indique `*_failed` (Echec). Par exemple, `create_failed`, `update_failed`, `delete_failed`.

{: tsResolve}
Ci-dessous figurent les motifs pour lesquels la valeur confidentielle de l'équilibreur de charge d'application peut échouer, ainsi que les étapes de résolution correspondantes :

<table>
<col width="40%">
<col width="60%">
 <thead>
 <th>Motifs</th>
 <th>Procédure de résolution du problème</th>
 </thead>
 <tbody>
 <tr>
 <td>Les rôles d'accès requis pour télécharger et mettre à jour des données de certificat ne vous ont pas été attribués.</td>
 <td>Contactez l'administrateur de votre compte afin qu'il vous affecte les rôles **Opérateur** et **Editeur** sur votre instance {{site.data.keyword.cloudcerts_full_notm}}. Pour plus de détails, voir <a href="/docs/services/certificate-manager/about.html#identity-access-management">Identity and Access Management</a> pour {{site.data.keyword.cloudcerts_short}}.</td>
 </tr>
 <tr>
 <td>Le CRN de certificat indiqué lors de la création, de la mise à jour ou de la suppression ne relève pas du même compte que le cluster.</td>
 <td>Vérifiez que le CRN de certificat que vous avez fourni est importé dans une instance du service {{site.data.keyword.cloudcerts_short}} déployée dans le même compte que votre cluster.</td>
 </tr>
 <tr>
 <td>Le CRN de certificat fourni lors de la création est incorrect.</td>
 <td><ol><li>Vérifiez l'exactitude de la chaîne de CRN de certificat soumise.</li><li>S'il s'avère que le CRN de certificat est correct, essayez de mettre à jour sa valeur confidentielle. <pre class="pre"><code>bx cs alb-cert-deploy --update --cluster &lt;cluster_name_or_id&gt; --secret-name &lt;secret_name&gt; --cert-crn &lt;certificate_CRN&gt;</code></pre></li><li>Si cette commande débouche sur le statut <code>update_failed</code> (échec de la mise à jour), supprimez la valeur confidentielle. <pre class="pre"><code>bx cs alb-cert-rm --cluster &lt;cluster_name_or_id&gt; --secret-name &lt;secret_name&gt;</code></pre></li><li>Déployez à nouveau la valeur confidentielle. <pre class="pre"><code>bx cs alb-cert-deploy --cluster &lt;cluster_name_or_id&gt; --secret-name &lt;secret_name&gt; --cert-crn &lt;certificate_CRN&gt;</code></pre></li></ol></td>
 </tr>
 <tr>
 <td>Le CRN de certificat soumis lors de la mise à jour est incorrect.</td>
 <td><ol><li>Vérifiez l'exactitude de la chaîne de CRN de certificat soumise.</li><li>S'il s'avère que le CRN de certificat est correct, supprimez sa valeur confidentielle. <pre class="pre"><code>bx cs alb-cert-rm --cluster &lt;cluster_name_or_id&gt; --secret-name &lt;secret_name&gt;</code></pre></li><li>Déployez à nouveau la valeur confidentielle. <pre class="pre"><code>bx cs alb-cert-deploy --cluster &lt;cluster_name_or_id&gt; --secret-name &lt;secret_name&gt; --cert-crn &lt;certificate_CRN&gt;</code></pre></li><li>Essayez de mettre à jour la valeur confidentielle. <pre class="pre"><code>bx cs alb-cert-deploy --update --cluster &lt;cluster_name_or_id&gt; --secret-name &lt;secret_name&gt; --cert-crn &lt;certificate_CRN&gt;</code></pre></li></ol></td>
 </tr>
 <tr>
 <td>Le service {{site.data.keyword.cloudcerts_long_notm}} est confronté à un temps d'indisponibilité.</td>
 <td>Vérifiez que votre service {{site.data.keyword.cloudcerts_short}} est opérationnel.</td>
 </tr>
 </tbody></table>

<br />



## Impossible d'extraire l'URL ETCD pour la configuration d'interface CLI de Calico
{: #cs_calico_fails}

{: tsSymptoms}
Lorsque vous extrayez l'URL `<ETCD_URL>` pour [ajouter des règles réseau](cs_network_policy.html#adding_network_policies), vous obtenez le message d'erreur `calico-config not found`.

{: tsCauses}
Votre cluster n'est pas à la [version Kubernetes 1.7](cs_versions.html) ou ultérieure.

{: tsResolve}
[Mettez à jour votre cluster](cs_cluster_update.html#master) ou extrayez l'`<ETCD_URL>` avec des commandes compatibles avec les versions antérieures de Kubernetes.

Pour extraire l'URL `<ETCD_URL>`, Exécutez l'une des commandes suivantes :

- Linux et OS X :

    ```
    kubectl describe pod -n kube-system `kubectl get pod -n kube-system | grep calico-policy-controller | awk '{print $1}'` | grep ETCD_ENDPOINTS | awk '{print $2}'
    ```
    {: pre}

- Windows :
    <ol>
    <li> Extrayez la liste des pods dans l'espace de nom kube-system et localisez le pod du contrôleur Calico. </br><pre class="codeblock"><code>kubectl get pod -n kube-system</code></pre></br>Exemple :</br><pre class="screen"><code>calico-policy-controller-1674857634-k2ckm</code></pre>
    <li> Affichez les détails du pod du contrôleur Calico.</br> <pre class="codeblock"><code>kubectl describe pod -n kube-system calico-policy-controller-&lt;ID&gt;</code></pre>
    <li> Localisez la valeur des noeuds finaux ETCD. Exemple : <code>https://169.1.1.1:30001</code>
    </ol>

Lorsque vous extrayez l'URL `<ETCD_URL>`, continuez avec les étapes mentionnées dans (Ajout de règles réseau)[cs_network_policy.html#adding_network_policies].

<br />




## Aide et assistance
{: #ts_getting_help}

Par où commencer pour traiter les incidents liés à un conteneur ?

-   Pour déterminer si {{site.data.keyword.Bluemix_notm}} est disponible, [consultez la page de statut de {{site.data.keyword.Bluemix_notm}} ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://developer.ibm.com/bluemix/support/#status).
-   Publiez une question sur le site [{{site.data.keyword.containershort_notm}} Slack. ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://ibm-container-service.slack.com) Conseil : si vous n'utilisez pas un ID IBM pour votre compte {{site.data.keyword.Bluemix_notm}}, [demandez une invitation à ce ](https://bxcs-slack-invite.mybluemix.net/)Slack.
-   Consultez les forums pour établir si d'autres utilisateurs ont rencontré le même problème. Lorsque vous utilisez les forums pour poser une question, balisez votre question de sorte que les équipes de développement {{site.data.keyword.Bluemix_notm}} la voient.

    -   Si vous avez des questions d'ordre technique sur le développement ou le déploiement de clusters ou d'applications à l'aide d'{{site.data.keyword.containershort_notm}}, publiez-les sur le site [Stack Overflow ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](http://stackoverflow.com/search?q=bluemix+containers) en leur adjoignant les balises `ibm-bluemix`, `kubernetes` et `containers`.
    -   Pour des questions relatives au service et aux instructions de mise en route, utilisez le forum [IBM developerWorks dW Answers ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://developer.ibm.com/answers/topics/containers/?smartspace=bluemix). Incluez
les balises `bluemix` et `containers`.
    Voir [Comment obtenir de l'aide](/docs/support/index.html#getting-help)
pour plus d'informations sur l'utilisation des forums.

-   Contactez le support IBM. Pour plus d'informations sur l'ouverture d'un ticket de demande de service IBM, sur les niveaux de support disponibles ou les niveaux de gravité des tickets, voir la rubrique décrivant [comment contacter le support](/docs/support/index.html#contacting-support).
