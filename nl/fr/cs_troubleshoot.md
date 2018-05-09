---

copyright:
  years: 2014, 2018
lastupdated: "2018-03-16"

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

Lorsque vous utilisez {{site.data.keyword.containerlong}}, tenez compte des techniques décrites ci-dessous pour identifier et résoudre les incidents et obtenir de l'aide. Vous pouvez également vérifier le [statut du système {{site.data.keyword.Bluemix_notm}} ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://developer.ibm.com/bluemix/support/#status).
{: shortdesc}

Vous pouvez effectuer quelques étapes générales pour vérifier que vos clusters sont à jour :
- [Redémarrez vos noeuds worker](cs_cli_reference.html#cs_worker_reboot) régulièrement pour garantir l'installation des mises à jour et des correctifs de sécurité déployés automatiquement par IBM sur le système d'exploitation
- Mettez à jour votre cluster à [la dernière version par défaut de Kubernetes](cs_versions.html) pour {{site.data.keyword.containershort_notm}}

<br />




## Débogage des clusters
{: #debug_clusters}

Passez en revue les options permettant de déboguer vos clusters et d'identifier les causes premières des échecs.

1.  Affichez votre cluster et identifiez son état (`State`).

  ```
  bx cs clusters
  ```
  {: pre}

2.  Examinez l'état (`State`) de votre cluster. S'il est à l'état **Critical**, **Delete failed** ou **Warning**, ou s'il est bloqué à l'état **Pending** depuis un bon moment, commencez à [déboguer les noeuds worker](#debug_worker_nodes).

    <table summary="Chaque ligne de tableau doit être lue de gauche à droite. L'état du cluster figure dans la première colonne et la description correspondante dans la seconde colonne.">
   <thead>
   <th>Etat du cluster</th>
   <th>Description</th>
   </thead>
   <tbody>
<tr>
   <td>Aborted</td>
   <td>La suppression du cluster est demandée par l'utilisateur avant le déploiement du maître Kubernetes. Une fois supprimé, le cluster est retiré de votre tableau de bord. Si votre cluster est bloqué dans cet état depuis un moment, ouvrez un [ticket de demande de service {{site.data.keyword.Bluemix_notm}}](/docs/get-support/howtogetsupport.html#using-avatar).</td>
   </tr>
 <tr>
     <td>Critical</td>
     <td>Le maître Kubernetes est inaccessible ou tous les noeuds worker du cluster sont arrêtés. </td>
    </tr>
   <tr>
     <td>Delete failed</td>
     <td>Le maître Kubernetes ou au moins un noeud worker n'ont pas pu être supprimés.  </td>
   </tr>
   <tr>
     <td>Deleted</td>
     <td>Le cluster a bien été supprimé mais n'est pas encore retiré de votre tableau de bord. Si votre cluster est bloqué dans cet état depuis un moment, ouvrez un [ticket de demande de service {{site.data.keyword.Bluemix_notm}}](/docs/get-support/howtogetsupport.html#using-avatar).</td>
   </tr>
   <tr>
   <td>Deleting</td>
   <td>Le cluster est en cours de suppression et son infrastructure est en cours de démantèlement. Vous ne pouvez pas accéder au cluster.  </td>
   </tr>
   <tr>
     <td>Deploy failed</td>
     <td>Le déploiement du maître Kubernetes n'a pas abouti. Vous ne pouvez pas résoudre cet état. Contactez le support IBM Cloud en ouvrant un [ticket de demande de service {{site.data.keyword.Bluemix_notm}}](/docs/get-support/howtogetsupport.html#using-avatar).</td>
   </tr>
     <tr>
       <td>Deploying</td>
       <td>Le maître Kubernetes n'est pas encore complètement déployé. Vous ne pouvez pas accéder à votre cluster. Patientez jusqu'à la fin du déploiement complet de votre cluster pour examiner l'état de santé de votre cluster.</td>
      </tr>
      <tr>
       <td>Normal</td>
       <td>Tous les noeuds worker d'un cluster sont opérationnels. Vous pouvez accéder au cluster et déployer les applications sur le cluster. Cet état est considéré comme bon et ne nécessite aucune action de votre part.</td>
    </tr>
      <tr>
       <td>Pending</td>
       <td>Le maître Kubernetes est déployé. La mise à disposition des noeuds worker est en cours. Ces derniers ne sont pas encore disponibles dans le cluster. Vous pouvez accéder au cluster, mais vous ne pouvez pas déployer d'applications sur le cluster.  </td>
     </tr>
   <tr>
     <td>Requested</td>
     <td>Une demande de création du cluster et d'organisation de l'infrastructure du maître Kubernetes et des noeuds worker est envoyée. Lorsque le déploiement du cluster commence, l'état du cluster passe à <code>Deploying</code>. Si votre cluster est bloqué à l'état <code>Requested</code> depuis un moment, ouvrez un [ticket de demande de service {{site.data.keyword.Bluemix_notm}}](/docs/get-support/howtogetsupport.html#using-avatar).</td>
   </tr>
   <tr>
     <td>Updating</td>
     <td>Le serveur d'API Kubernetes qui s'exécute sur votre maître Kubernetes est en cours de mise à jour pour passer à une nouvelle version d'API Kubernetes. Lors de cette mise à jour, vous ne pouvez ni accéder ni modifier le cluster. Les noeuds worker, les applications et les ressources déployés par l'utilisateur ne sont pas modifiés et continuent à s'exécuter. Patientez jusqu'à la fin de la mise à jour pour examiner l'état de santé de votre cluster.</td>
   </tr>
    <tr>
       <td>Warning</td>
       <td>Au moins un noeud worker du cluster n'est pas disponible. Cela dit, les autres noeuds worker sont disponibles et peuvent prendre le relais pour la charge de travail. </td>
    </tr>
   </tbody>
 </table>

<br />


## Débogage des noeuds worker
{: #debug_worker_nodes}

Passez en revue les options permettant de déboguer vos noeuds worker et d'identifier les causes premières des échecs.


1.  Si votre cluster est à l'état **Critical**, **Delete failed** ou **Warning**, ou s'il est bloqué à l'état **Pending** depuis un bon moment, vérifiez l'état de vos noeuds worker.

  ```
  bx cs workers <cluster_name_or_id>
  ```
  {: pre}

2.  Consultez les zones `State` et `Status` correspondant à chaque noeud worker dans votre sortie d'interface CLI.

  <table summary="Chaque ligne de tableau doit être lue de gauche à droite. L'état du cluster figure dans la première colonne et la description correspondante dans la seconde colonne.">
    <thead>
    <th>Etat du noeud worker</th>
    <th>Description</th>
    </thead>
    <tbody>
  <tr>
      <td>Critical</td>
      <td>Un noeud worker peut passer à l'état critique (Critical) pour de nombreuses raisons. Les raisons les plus courantes sont les suivantes : <ul><li>Vous avez lancé un redémarrage de votre noeud worker sans avoir exécuté les commandes cordon et drain sur votre noeud worker. Le redémarrage d'un noeud worker peut entraîner des altérations de données dans <code>docker</code>, <code>kubelet</code>, <code>kube-proxy</code> et <code>calico</code>. </li><li>Les pods qui sont déployés sur votre noeud worker n'utilisent pas de limites de ressources de [mémoire ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/tasks/configure-pod-container/assign-memory-resource/) et d'[UC ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/tasks/configure-pod-container/assign-cpu-resource/). Sans limite de ressources, les pods peuvent consommer toutes les ressources disponibles, sans en laisser pour l'exécution d'autres pods sur ce noeud worker. Cette sursollicitation de charge de travail entraîne l'échec du noeud worker. </li><li><code>Docker</code>, <code>kubelet</code> ou <code>calico</code> sont passés dans un état irrémédiable après avoir exécuté des centaines ou des milliers de conteneurs à la longue. </li><li>Vous avez configuré un système Vyatta pour votre noeud worker qui n'est plus opérationnel et a interrompu la communication entre votre noeud worker et le maître Kubernetes. </li><li> Des problèmes réseau dans {{site.data.keyword.containershort_notm}} ou dans l'infrastructure IBM Cloud (SoftLayer) qui entraînent une coupure de communication entre votre noeud worker et le maître Kubernetes.</li><li>La capacité de votre noeud worker a été dépassée. Vérifiez l'état (<strong>Status</strong>) du noeud worker pour voir s'il indique <strong>Out of disk</strong> ou <strong>Out of memory</strong>. Si votre noeud worker n'a plus de capacité disponible, envisagez de réduire la charge de travail sur ce noeud ou ajoutez un noeud worker à votre cluster pour mieux équilibrer la charge de travail.</li></ul> Dans de nombreux cas, [recharger](cs_cli_reference.html#cs_worker_reload) votre noeud worker peut résoudre le problème. Avant de recharger votre noeud worker, assurez-vous d'effectuer les opérations cordon et drain sur le noeud pour garantir l'interruption en douceur des pods et leur replanification sur les noeuds worker restants. </br></br> Si le rechargement du noeud worker ne résoud pas le problème, passez à l'étape suivante pour poursuivre l'identification et la résolution des problèmes de votre noeud worker.</br></br><strong>Astuce :</strong> vous pouvez [configurer des diagnotics d'intégrité de votre noeud worker et activer la reprise automatique](cs_health.html#autorecovery). Si le système de reprise automatique détecte un mauvais état de santé d'un noeud worker d'après les vérifications configurées, il déclenche une mesure corrective (par exemple, un rechargement du système d'exploitation) sur le noeud worker. Pour plus d'informations sur le fonctionnement de la reprise automatique, consultez le [blogue Autorecovery ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://www.ibm.com/blogs/bluemix/2017/12/autorecovery-utilizes-consistent-hashing-high-availability/).
      </td>
     </tr>
      <tr>
        <td>Deploying</td>
        <td>Lorsque vous mettez à jour la version Kubernetes de votre noeud worker, le noeud est redéployé pour installer les mises à jour. Si votre noeud worker est bloqué dans cet état pendant un moment, passez à l'étape suivante pour voir s'il y a eu un problème lors du déploiement. </td>
     </tr>
        <tr>
        <td>Normal</td>
        <td>Votre noeud worker est entièrement mis à disposition et il est prêt à être utilisé dans le cluster. Cet état est considéré comme bon et ne nécessite aucune action de l'utilisateur.</td>
     </tr>
   <tr>
        <td>Provisioning</td>
        <td>La mise à disposition de votre noeud worker est en cours. Ce dernier n'est pas encore disponible dans le cluster. Vous pouvez surveiller le processus de mise à disposition dans la colonne <strong>Status</strong> de la sortie générée par l'interface de ligne de commande. Si votre noeud worker est bloqué dans cet état depuis un certain temps et que vous ne voyez aucune progression dans la colonne <strong>Status</strong>, passez à l'étape suivante pour voir si un problème s'est produit lors de la mise à disposition.</td>
      </tr>
      <tr>
        <td>Provision_failed</td>
        <td>Votre noeud worker n'a pas pu être mis à disposition. Passez à l'étape suivante pour rechercher les détails relatifs à cet échec.</td>
      </tr>
   <tr>
        <td>Reloading</td>
        <td>Le rechargement de votre noeud worker est en cours. Ce dernier n'est pas disponible dans le cluster. Vous pouvez surveiller le processus de rechargement dans la colonne <strong>Status</strong> de la sortie générée par l'interface de ligne de commande. Si votre noeud worker est bloqué dans cet état depuis un certain temps et que vous ne voyez aucune progression dans la colonne <strong>Status</strong>, passez à l'étape suivante pour voir si un problème s'est produit lors du rechargement.</td>
       </tr>
       <tr>
        <td>Reloading_failed </td>
        <td>Votre noeud worker n'a pas pu être rechargé. Passez à l'étape suivante pour rechercher les détails relatifs à cet échec.</td>
      </tr>
      <tr>
        <td>Reload_pending </td>
        <td>Une demande de rechargement ou une demande de mise à jour de la version Kubernetes de votre noeud worker a été envoyée. Lors du rechargement du noeud worker, l'état passe à <code>Reloading</code>. </td>
      </tr>
      <tr>
       <td>Unknown</td>
       <td>Le maître Kubernetes est inaccessible pour l'une des raisons suivantes :<ul><li>Vous avez demandé une mise à jour de votre maître Kubernetes. L'état du noeud worker ne peut pas être extrait lors de la mise à jour.</li><li>Peut-être possédez-vous un pare-feu qui protège vos noeuds worker ou avez-vous récemment modifié vos paramètres de pare-feu. {{site.data.keyword.containershort_notm}} requiert que certaines adresses IP et certains ports soient ouverts pour permettre la communication entre le noeud worker et le maître Kubernetes et inversement. Pour plus d'informations, voir [Pare-feu empêchant la connexion des noeuds worker](#cs_firewall).</li><li>Le maître Kubernetes est arrêté. Contactez le support {{site.data.keyword.Bluemix_notm}} en ouvrant un [ticket de demande de service {{site.data.keyword.Bluemix_notm}}](/docs/get-support/howtogetsupport.html#getting-customer-support).</li></ul></td>
  </tr>
     <tr>
        <td>Warning</td>
        <td>Votre noeud worker est sur le point d'atteindre la limite en termes de mémoire ou d'espace disque. Vous pouvez réduire la charge de travail sur votre noeud worker ou ajouter un noeud worker à votre cluster pour contribuer à l'équilibrage de la charge de travail.</td>
  </tr>
    </tbody>
  </table>

5.  Affichez la liste des détails relatifs à votre noeud worker. Si les détails comprennent un message d'erreur, consultez la liste des [messages d'erreur courants concernant les noeuds worker](#common_worker_nodes_issues) pour savoir comment résoudre le problème.

   ```
   bx cs worker-get <worker_id>
   ```
   {: pre}

  ```
  bx cs worker-get [<cluster_name_or_id>] <worker_node_id>
  ```
  {: pre}

<br />


## Erreurs courantes avec les noeuds worker
{: #common_worker_nodes_issues}

Passez en revue les messages d'erreurs courantes et apprenez à résoudre les problèmes correspondants.

  <table>
    <thead>
    <th>Message d'erreur</th>
    <th>Description et résolution
    </thead>
    <tbody>
      <tr>
        <td>Exception liée à l'infrastructure {{site.data.keyword.Bluemix_notm}} : votre compte n'est pas autorisé à réserver des instances de traitement pour l'instant.</td>
        <td>La réservation de ressources de traitement par votre compte d'infrastructure IBM Cloud (SoftLayer) n'est peut-être pas possible. Contactez le support {{site.data.keyword.Bluemix_notm}} en ouvrant un [ticket de demande de service {{site.data.keyword.Bluemix_notm}}](/docs/get-support/howtogetsupport.html#getting-customer-support).</td>
      </tr>
      <tr>
        <td>Exception liée à l'infrastructure {{site.data.keyword.Bluemix_notm}} : impossible de passer la commande. Les ressources derrière le routeur 'router_name' ne sont pas suffisantes pour satisfaire la demande pour les invités suivants : 'worker_id'.</td>
        <td>Le réseau local virtuel que vous avez sélectionné est associé à un pod du centre de données dont l'espace n'est pas suffisant pour mettre à disposition votre noeud worker. Plusieurs possibilités s'offrent à vous :<ul><li>Utilisez un autre centre de données pour mettre à disposition votre noeud worker. Exécutez la commande <code>bx cs locations</code> pour afficher la liste des centres de données disponibles.<li>Si vous possédez déjà une paire de réseaux locaux virtuels public et privé associée à un autre pod du centre de données, utilisez-la à la place.<li>Contactez le support {{site.data.keyword.Bluemix_notm}} en ouvrant un [ticket de demande de service {{site.data.keyword.Bluemix_notm}}](/docs/get-support/howtogetsupport.html#getting-customer-support).</ul></td>
      </tr>
      <tr>
        <td>Exception liée à l'infrastructure {{site.data.keyword.Bluemix_notm}} : impossible d'obtenir le réseau local virtuel portant l'ID : &lt;vlan id&gt;.</td>
        <td>Votre noeud worker n'a pas pu être mis à disposition car l'ID de réseau local virtuel sélectionné est introuvable pour l'une des raisons suivantes :<ul><li>Vous avez indiqué le numéro de réseau local virtuel au lieu de l'ID de réseau local virtuel. Le numéro de réseau local virtuel est composé de 3 ou 4 chiffres, tandis que l'ID de réseau local virtuel est composé de 7 chiffres. Exécutez la commande <code>bx cs vlans &lt;location&gt;</code> pour extraire l'ID de réseau local virtuel.<li>L'ID de réseau local virtuel (VLAN) n'est peut-être pas associé au compte d'infrastructure IBM Cloud (SoftLayer) que vous utilisez. Exécutez la commande <code>bx cs vlans &lt;location&gt;</code> pour afficher la liste des ID de réseau local virtuel disponibles pour votre compte. Pour modifier le compte d'infrastructure IBM Cloud (SoftLayer), voir la rubrique sur la commande [bx cs credentials-set](cs_cli_reference.html#cs_credentials_set). </ul></td>
      </tr>
      <tr>
        <td>SoftLayer_Exception_Order_InvalidLocation : l'emplacement fourni pour cette commande n'est pas valide. (HTTP 500)</td>
        <td>L'infrastructure IBM Cloud (SoftLayer) n'est pas configurée pour commander des ressources de traitement dans le centre de données sélectionné. Contactez le [support {{site.data.keyword.Bluemix_notm}}](/docs/get-support/howtogetsupport.html#getting-customer-support) pour vérifier que votre compte est correctement configuré.</td>
       </tr>
       <tr>
        <td>Exception liée à l'infrastructure {{site.data.keyword.Bluemix_notm}} : l'utilisateur ne dispose pas des droits sur l'infrastructure {{site.data.keyword.Bluemix_notm}} nécessaires pour ajouter des serveurs
        </br></br>
        Exception liée à l'infrastructure {{site.data.keyword.Bluemix_notm}} : des droits sont nécessaires pour réserver 'Item'.</td>
        <td>Vous ne disposez peut-être pas des droits nécessaires pour mettre à disposition un noeud worker à partir du portefeuille d'infrastructure IBM Cloud (SoftLayer). Voir [Configuration de l'accès au portefeuille d'infrastructure IBM Cloud (SoftLayer) pour créer des clusters Kubernetes standard](cs_infrastructure.html#unify_accounts).</td>
      </tr>
      <tr>
       <td>Worker ne parvient pas à communiquer avec les serveurs {{site.data.keyword.containershort_notm}}. Vérifiez si la configuration de votre pare-feu autorise le trafic à partir de ce noeud worker.
       <td><ul><li>Si vous disposez d'un pare-feu, [configurez les paramètres de votre pare-feu de sorte à autoriser le trafic sortant vers les ports et les adresses IP appropriés](cs_firewall.html#firewall_outbound).</li><li>Vérifiez si votre cluster n'a pas une adresse IP publique en exécutant la commande `bx cs workers <mycluster>`. Si aucune adresse IP publique n'est répertoriée, votre cluster ne dispose que de réseaux locaux virtuels (VLAN) privés.<ul><li>Si vous voulez que le cluster ne dispose que de VLAN privés, assurez-vous d'avoir configuré votre [connexion de réseau virtuel (VLAN)](cs_clusters.html#worker_vlan_connection) et votre [pare-feu](cs_firewall.html#firewall_outbound).</li><li>Si vous voulez que votre cluster dispose d'une adresse IP publique, [ajoutez de nouveaux noeuds worker](cs_cli_reference.html#cs_worker_add) avec à la fois des VLAN publics et privés.</li></ul></li></ul></td>
     </tr>
      <tr>
  <td>Impossible de créer un jeton de portail IMS, car aucun compte IMS n'est lié au compte BSS sélectionné</br></br>Utilisateur indiqué introuvable ou actif</br></br>SoftLayer_Exception_User_Customer_InvalidUserStatus : Le compte utilisateur est actuellement en attente d'annulation (cancel_pending).</td>
  <td>Le propriétaire de la clé d'API utilisée pour accéder au portefeuille d'infrastructure IBM Cloud (SoftLayer) ne dispose pas des droits nécessaires pour effectuer l'action ou est peut-être en attente de suppression.</br></br><strong>En tant qu'utilisateur</strong>, procédez comme suit : <ol><li>Si vous avez accès à plusieurs comptes, assurez-vous d'être connecté au compte que vous souhaitez utiliser avec {{site.data.keyword.containerlong_notm}}. </li><li>Exécutez la commande <code>bx cs api-key-info</code> pour afficher le propriétaire de la clé d'API utilisée pour accéder au portefeuille d'infrastructure IBM Cloud (SoftLayer). </li><li>Exécutez la commande <code>bx account list</code> pour afficher le propriétaire du compte {{site.data.keyword.Bluemix_notm}} que vous utilisez actuellement. </li><li>Contactez le propriétaire du compte {{site.data.keyword.Bluemix_notm}} et signalez que le propriétaire de la clé d'API que vous avez récupéré précédemment ne dispose pas des droits requis dans l'infrastructure IBM Cloud (SoftLayer) ou est peut-être en attente de suppression. </li></ol></br><strong>En tant que propriétaire du compte</strong>, procédez comme suit : <ol><li>Consultez les [droits requis dans l'infrastructure IBM Cloud (SoftLayer)](cs_users.html#managing) pour effectuer l'action qui a échoué. </li><li>Définissez les droits du propriétaire de la clé d'API ou créez une nouvelle clé d'API en exécutant la commande [<code>bx cs api-key-reset</code>](cs_cli_reference.html#cs_api_key_reset). </li><li>Si vous ou un autre administrateur de compte définissez manuellement des données d'identification de l'infrastructure IBM Cloud (SoftLayer) dans votre compte, exécutez la commande [<code>bx cs credentials-unset</code>](cs_cli_reference.html#cs_credentials_unset) pour supprimer les données d'identification de votre compte.</li></ol></td>
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

3. Vérifiez si le cluster est à l'état `Critical`. S'il est à l'état `Critical`, consultez les règles de pare-feu et vérifiez que le maître peut communiquer avec les noeuds worker.

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
Nous n'avons pas pu nous connecter à votre compte d'infrastructure IBM Cloud.
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
Lorsque les connexions des noeuds worker sont impossibles, vous pourrez voir toute une série de symptômes différents. Vous pourrez obtenir l'un des messages suivants en cas d'échec de la commande kubectl proxy ou si vous essayez d'accéder à un service dans votre cluster et que la connexion échoue.

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
Vous pouvez disposer d'un pare-feu supplémentaire configuré ou avoir personnalisé vos paramètres de pare-feu existants dans votre compte d'infrastructure IBM Cloud (SoftLayer). {{site.data.keyword.containershort_notm}} requiert que certaines adresses IP et certains ports soient ouverts pour permettre la communication entre le noeud worker et le maître Kubernetes et inversement. Une autre cause peut être que les noeuds worker soient bloqués dans une boucle de rechargement.

{: tsResolve}
[Autorisez le cluster à accéder aux ressources d'infrastructure et à d'autres services](cs_firewall.html#firewall_outbound). Cette tâche nécessite d'utiliser une [règle d'accès administrateur](cs_users.html#access_policies). Vérifiez votre [règle d'accès actuelle](cs_users.html#infra_access).

<br />



## L'accès à votre noeud worker à l'aide de SSH échoue
{: #cs_ssh_worker}

{: tsSymptoms}
Vous ne pouvez pas accéder à votre noeud worker à l'aide d'une connexion SSH.

{: tsCauses}
L'accès SSH via un mot de passe est désactivé sur les noeuds worker.

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
Lorsque vous exécutez la commande `kubectl get nodes`, vous voyez des noeuds worker en double avec le statut **NotReady**. Les noeuds worker avec le statut **NotReady** ont des adresses IP publiques, alors que les noeuds worker avec le statut **Ready** ont des adresses IP privées.

{: tsCauses}
D'anciens clusters avaient des noeuds worker répertoriés par l'adresse IP publique du cluster. A présent, les noeuds worker sont répertoriés par l'adresse IP privée du cluster. Lorsque vous rechargez ou mettez à jour un noeud, l'adresse IP est modifiée, mais la référence à l'adresse IP publique est conservée.

{: tsResolve}
Il n'y a aucune interruption de service due à ces doublons, mais vous devez retirer les références des anciens noeuds worker du serveur d'API.

  ```
  kubectl delete node <node_name1> <node_name2>
  ```
  {: pre}

<br />




## Les systèmes de fichiers des noeuds worker passent en mode lecture seule
{: #readonly_nodes}

{: tsSymptoms}
{: #stuck_creating_state}
Vous pouvez voir l'un des symptômes suivants :
- Lorsque vous exécutez la commande `kubectl get pods -o wide`, vous voyez que plusieurs pods qui s'exécutent sur le même noeud worker sont bloqués à l'état `ContainerCreating`.
- Lorsque vous exécutez la commande `kubectl describe`, vous voyez l'erreur suivante dans la section des événements : `MountVolume.SetUp failed for volume ... read-only file system`.

{: tsCauses}
Le système de fichiers sur le noeud worker est en lecture seule.

{: tsResolve}
1. Sauvegardez les données éventuelles stockées sur le noeud worker ou dans vos conteneurs.
2. Pour une solution à court terme sur le noeud worker existant, rechargez le noeud worker.

<pre class="pre"><code>bx cs worker-reload &lt;cluster_name&gt; &lt;worker_id&gt;</code></pre>

Pour une solution à long terme, [mettez à jour le type de machine en ajoutant un autre noeud worker](cs_cluster_update.html#machine_type).

<br />




## Echec de l'accès à un pod sur un nouveau noeud worker et dépassement du délai d'attente
{: #cs_nodes_duplicate_ip}

{: tsSymptoms}
Vous avez supprimé un noeud worker dans votre cluster et ajouté un noeud worker. Lorsque vous avez déployé un pod ou un service Kubernetes, la ressource n'a pas pu accéder au noeud worker nouvellement créé et un dépassement de délai d'attente s'est produit pour la connexion.

{: tsCauses}
Si vous supprimez un noeud worker de votre cluster et que vous ajoutez un noeud worker, il se peut que l'adresse IP privée du noeud worker supprimé soit affectée au nouveau noeud worker. Calico utilise cette adresse IP privée en tant que balise et continue d'essayer d'atteindre le noeud supprimé.

{: tsResolve}
Mettez manuellement à jour la référence de l'adresse IP privée pour qu'elle pointe vers le noeud approprié.

1.  Vérifiez que vous possédez deux noeuds worker associés à la même **adresse IP privée**. Notez l'**adresse IP privée** et l'**ID** du noeud worker supprimé.

  ```
  bx cs workers <CLUSTER_NAME>
  ```
  {: pre}

  ```
  ID                                                 Public IP       Private IP       Machine Type   State     Status   Location   Version
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w1   192.0.2.0.12    203.0.113.144    b2c.4x16       normal    Ready    dal10      1.8.8
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w2   192.0.2.0.16    203.0.113.144    b2c.4x16       deleted    -       dal10      1.8.8
  ```
  {: screen}

2.  Installez l'[interface de ligne de commande Calico](cs_network_policy.html#adding_network_policies).
3.  Répertoriez les noeuds worker disponibles dans Calico. Remplacez <path_to_file> par le chemin d'accès local au fichier de configuration Calico.

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


## Le cluster reste à l'état En attente
{: #cs_cluster_pending}

{: tsSymptoms}
Lorsque vous déployez votre cluster, il reste à l'état en attente (pending) et ne démarre pas.

{: tsCauses}
Si vous venez de créer le cluster, les noeuds worker sont peut-être encore en cours de configuration. Si vous attendez depuis un bon moment, il est possible que votre réseau local virtuel (VLAN) soit non valide.

{: tsResolve}

Vous pouvez envisager l'une des solutions suivantes :
  - Vérifiez le statut de votre cluster en exécutant la commande `bx cs clusters`. Puis vérifiez que vos noeuds worker sont déployés en exécutant la commande `bx cs workers <cluster_name>`.
  - Vérifiez si votre réseau local virtuel (VLAN) est valide. Pour être valide, un VLAN doit être associé à une infrastructure pouvant héberger un noeud worker avec un stockage sur disque local. Vous pouvez [afficher la liste de vos VLAN](/docs/containers/cs_cli_reference.html#cs_vlans) en exécutant la commande `bx cs vlans LOCATION`. Si le VLAN n'apparaît pas dans la liste, il n'est pas valide. Choisissez-en un autre.

<br />


## Des pods sont toujours à l'état en attente
{: #cs_pods_pending}

{: tsSymptoms}
Lorsque vous exécutez `kubectl get pods`, vous constatez que des pods sont toujours à l'état en attente (**pending**).

{: tsCauses}
Si vous venez juste de créer le cluster Kubernetes, il se peut que les noeuds worker soient encore en phase de configuration. S'il s'agit d'un cluster existant, sa capacité est peut-être insuffisante pour y déployer le pod.

{: tsResolve}
Cette tâche nécessite d'utiliser une [règle d'accès administrateur](cs_users.html#access_policies). Vérifiez votre [règle d'accès actuelle](cs_users.html#infra_access).

Si vous venez de créer le cluster Kubernetes, exécutez la commande suivante et attendez l'initialisation des noeuds worker.

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

5.  Si vos pods sont toujours à l'état **pending** après le déploiement complet du noeud worker, consultez la [documentation Kubernetes ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/tasks/debug-application-cluster/debug-pod-replication-controller/#my-pod-stays-pending) pour effectuer d'autres tâches en vue d'identifier et de résoudre le problème.

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
Lorsque vous accédez au tableau de bord Kibana, les journaux ne s'affichent pas.

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
 <td>Pour que les journaux soient envoyés, vous devez d'abord créer une configuration de journalisation visant à acheminer les journaux à {{site.data.keyword.loganalysislong_notm}}. Pour créer une configuration de journalisation, voir <a href="cs_health.html#logging">Configuration de la journalisation des clusters</a>.</td>
 </tr>
 <tr>
 <td>L'état du cluster n'indique pas <code>Normal</code>.</td>
 <td>Pour vérifier l'état de votre cluster, voir <a href="cs_troubleshoot.html#debug_clusters">Débogage des clusters</a>.</td>
 </tr>
 <tr>
 <td>Le quota de stockage des journaux a été atteint.</td>
 <td>Pour augmenter vos limites de stockage de journaux, reportez-vous à la <a href="/docs/services/CloudLogAnalysis/troubleshooting/error_msgs.html">Documentation {{site.data.keyword.loganalysislong_notm}}</a>.</td>
 </tr>
 <tr>
 <td>Si vous avez spécifié un espace lors de la création du cluster, les droits d'accès Responsable, Développeur  ou Auditeur n'ont pas été affectées au propriétaire du compte sur cet espace.</td>
 <td>Pour modifier les droits d'accès du propriétaire du compte :<ol><li>Pour identifier le propriétaire du compte pour le cluster, exécutez la commande <code>bx cs api-key-info &lt;cluster_name_or_ID&gt;</code>.</li><li>Pour attribuer au propriétaire du compte les droits d'accès Responsable, Développeur ou Auditeur dans {{site.data.keyword.containershort_notm}} sur cet espace, voir <a href="cs_users.html#managing">Gestion de l'accès au cluster</a>.</li><li>Pour actualiser le jeton d'accès après que les droits d'accès ont été modifiés, exécutez la commande <code>bx cs logging-config-refresh &lt;cluster_name_or_ID&gt;</code>.</li></ol></td>
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
      - Sud du Royaume-Uni : https://logging.eu-gb.bluemix.net
      - Europe centrale : https://logging.eu-fra.bluemix.net
      - Asie-Pacifique sud : https://logging.au-syd.bluemix.net

<br />




## Le tableau de bord Kubernetes n'affiche pas de graphiques d'utilisation
{: #cs_dashboard_graphs}

{: tsSymptoms}
Lorsque vous accédez au tableau de bord Kubernetes, les graphiques d'utilisation ne s'affichent pas.

{: tsCauses}
Parfois, après la mise à jour d'un cluster ou le réamorçage d'un noeud worker, le pod `kube-dashboard` ne se met pas à jour.

{: tsResolve}
Supprimez le pod `kube-dashboard` pour forcer un redémarrage. Le pod est recréé avec des règles RBAC afin d'accéder à heapster pour obtenir les informations d'utilisation.

  ```
  kubectl delete pod -n kube-system $(kubectl get pod -n kube-system --selector=k8s-app=kubernetes-dashboard -o jsonpath='{.items..metadata.name}')
  ```
  {: pre}

<br />


## Echec de l'ajout de l'accès d'utilisateur non root au stockage persistant
{: #cs_storage_nonroot}

{: tsSymptoms}
Après avoir [ajouté l'accès d'utilisateur non root au stockage persistant](cs_storage.html#nonroot) ou déployé une charte Helm avec un ID d'utilisateur non root, l'utilisateur n'a pas accès en écriture à un stockage monté.

{: tsCauses}
Le déploiement ou la configuration de la charte Helm indique le [contexte de sécurité](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/) pour `fsGroup` (ID de groupe) et `runAsUser` (ID utilisateur) du pod. Actuellement, {{site.data.keyword.containershort_notm}} ne prend pas en charge la spécification `fsGroup` et n'accepte que `runAsUser` défini avec la valeur `0` (droits de l'utilisateur root).

{: tsResolve}
Supprimez les zones `securityContext` dans la configuration pour `fsGroup` et `runAsUser` du fichier de configuration de l'image, du déploiement ou de la charte Helm et effectuez un redéploiement. Si vous devez remplacer la propriété du chemin de montage `nobody`, [ajoutez un accès d'utilisateur non root](cs_storage.html#nonroot).

<br />


## Impossible de se connecter à une application via un service d'équilibreur de charge
{: #cs_loadbalancer_fails}

{: tsSymptoms}
Vous avez exposé votre application au public en créant un service d'équilibreur de charge dans votre cluster. Lorsque vous avez essayé de vous connecter à votre application via l'adresse IP publique de l'équilibreur de charge, la connexion a échoué ou expiré.

{: tsCauses}
Il se peut que le service d'équilibreur de charge ne fonctionne pas correctement pour l'une des raisons suivantes :

-   Le cluster est un cluster gratuit ou un cluster standard avec un seul noeud worker.
-   Le cluster n'est pas encore complètement déployé.
-   Le script de configuration pour votre service d'équilibreur de charge comporte des erreurs.

{: tsResolve}
Pour identifier et résoudre les problèmes liés à votre service d'équilibreur de charge :

1.  Prenez soin de configurer un cluster standard qui est entièrement déployé et qui comporte au moins deux noeuds worker afin d'assurer la haute disponibilité de votre service d'équilibreur de charge.

  ```
  bx cs workers <cluster_name_or_id>
  ```
  {: pre}

    Dans la sortie générée par votre interface de ligne de commande, vérifiez que la valeur **Ready** apparaît dans la zone **Status** pour vos noeuds worker et qu'une autre valeur que **free** est spécifiée dans la zone **Machine Type**

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

    <ul><li><pre class="screen"><code>Clusters with one node must use services of type NodePort</code></pre></br>Pour utiliser le service d'équilibreur de charge, vous devez disposer d'un cluster standard et d'au moins deux noeuds worker.</li>
    <li><pre class="screen"><code>No cloud provider IPs are available to fulfill the load balancer service request. Add a portable subnet to the cluster and try again</code></pre></br>Ce message d'erreur indique qu'il ne reste aucune adresse IP publique portable à attribuer à votre service d'équilibreur de charge. Pour savoir comment demander des adresses IP publiques portables pour votre cluster, voir la rubrique <a href="cs_subnets.html#subnets">Ajout de sous-réseaux à des clusters</a>. Dès lors que des adresses IP publiques portables sont disponibles pour le cluster, le service d'équilibreur de charge est automatiquement créé.</li>
    <li><pre class="screen"><code>Requested cloud provider IP <cloud-provider-ip> is not available. The following cloud provider IPs are available: <available-cloud-provider-ips></code></pre></br>Vous avez défini une adresse IP publique portable pour votre service d'équilibreur de charge à l'aide de la section **loadBalancerIP**, or, cette adresse IP publique portable n'est pas disponible dans votre sous-réseau public portable. Modifiez le script de configuration de votre service d'équilibreur de charge et choisissez l'une des adresses IP publiques portables disponibles ou retirez la section **loadBalancerIP** de votre script de sorte qu'une adresse IP publique portable puisse être allouée automatiquement.</li>
    <li><pre class="screen"><code>No available nodes for load balancer services</code></pre>Vous ne disposez pas de suffisamment de noeuds worker pour déployer un service d'équilibreur de charge. Il se pourrait que vous ayez déployé un cluster standard avec plusieurs noeuds worker, mais que la mise à disposition des noeuds worker ait échoué.</li>
    <ol><li>Affichez la liste des noeuds worker disponibles.</br><pre class="codeblock"><code>kubectl get nodes</code></pre></li>
    <li>Si au moins deux noeuds worker disponibles sont trouvés, affichez les détails de ces noeuds worker.</br><pre class="codeblock"><code>bx cs worker-get [&lt;cluster_name_or_id&gt;] &lt;worker_ID&gt;</code></pre></li>
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
Vous avez exposé votre application au public en créant une ressource Ingress pour votre application dans votre cluster. Lorsque vous avez essayé de vous connecter à votre application via l'adresse IP publique ou le sous-domaine de l'équilibreur de charge d'application Ingress, la connexion a échoué ou expiré.

{: tsCauses}
Il se peut qu'Ingress ne fonctionne pas correctement pour les raisons suivantes :
<ul><ul>
<li>Le cluster n'est pas encore complètement déployé.
<li>Le cluster a été configuré en tant que cluster gratuit ou standard avec un seul noeud worker.
<li>Le script de configuration Ingress contient des erreurs.
</ul></ul>

{: tsResolve}
Pour identifier et résoudre les problèmes liés à votre contrôleur Ingress :

1.  Prenez soin de configurer un cluster standard qui est entièrement déployé et qui comporte au moins deux noeuds worker afin d'assurer la haute disponibilité de votre équilibreur de charge d'application Ingress.

  ```
  bx cs workers <cluster_name_or_id>
  ```
  {: pre}

    Dans la sortie générée par votre interface de ligne de commande, vérifiez que la valeur **Ready** apparaît dans la zone **Status** pour vos noeuds worker et qu'une autre valeur que **free** est spécifiée dans la zone **Machine Type**

2.  Extrayez le sous-domaine et l'adresse IP publique de l'équilibreur de charge d'application Ingress, puis exécutez une commande ping vers chacun d'eux.

    1.  Récupérez le sous-domaine de l'équilibreur de charge d'application.

      ```
      bx cs cluster-get <cluster_name_or_id> | grep "Ingress subdomain"
      ```
      {: pre}

    2.  Exécutez une commande ping vers le sous-domaine de l'équilibreur de charge d'application Ingress.

      ```
      ping <ingress_controller_subdomain>
      ```
      {: pre}

    3.  Identifiez l'adresse IP publique de votre d'équilibreur de charge d'application Ingress.

      ```
      nslookup <ingress_controller_subdomain>
      ```
      {: pre}

    4.  Exécutez une commande ping vers l'adresse IP publique de l'équilibreur de charge d'application Ingress.

      ```
      ping <ingress_controller_ip>
      ```
      {: pre}

    Si l'interface CLI renvoie un dépassement du délai d'attente pour l'adresse IP publique ou le sous-domaine de l'équilibreur de charge d'application Ingress, et que vous avez configuré un pare-feu personnalisé pour protéger vos noeuds worker, vous aurez peut-être besoin d'ouvrir des ports et des groupes réseau supplémentaires dans votre [pare-feu](#cs_firewall).

3.  Si vous utilisez un domaine personnalisé, assurez-vous qu'il est mappé à l'adresse IP publique ou au sous-domaine de l'équilibreur de charge Ingress fourni par IBM avec votre fournisseur DNS (Domain Name Service).
    1.  Si vous avez utilisé le sous-domaine de l'équilibreur de charge d'application Ingress, vérifiez le nom canonique (enregistrement CNAME).
    2.  Si vous avez utilisé l'adresse IP publique de l'équilibreur de charge d'application Ingress, assurez-vous que votre domaine personnalisé est mappé à l'adresse IP publique portable dans le pointeur (enregistrement PTR).
4.  Vérifiez le fichier de configuration de ressource Ingress.

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

    1.  Vérifiez que le sous-domaine de l'équilibreur de charge d'application Ingress et le certificat TLS sont corrects. Pour obtenir le certificat TLS et le sous-domaine fournis par IBM, exécutez la commande `bx cs cluster-get <cluster_name_or_id>`.
    2.  Assurez-vous que votre application est en mode écoute sur le même chemin que celui qui est configuré dans la section **path** de votre contrôleur Ingress. Si votre application est configurée pour être en mode écoute sur le chemin racine, ajoutez **/** comme chemin.
5.  Vérifiez le déploiement du contrôleur Ingress et recherchez les éventuels messages d'erreur ou d'avertissement.

    ```
    kubectl describe ingress <myingress>
    ```
    {: pre}

    Par exemple, dans la section **Events** de la sortie, vous pouvez voir des messages d'avertissement à propos de valeurs non valides dans votre ressource Ingress ou dans certaines annotations que vous avez utilisées.

    ```
    Name:             myingress
    Namespace:        default
    Address:          169.xx.xxx.xx,169.xx.xxx.xx
    Default backend:  default-http-backend:80 (<none>)
    Rules:
      Host                                             Path  Backends
      ----                                             ----  --------
      mycluster.us-south.containers.mybluemix.net
                                                       /tea      myservice1:80 (<none>)
                                                       /coffee   myservice2:80 (<none>)
    Annotations:
      custom-port:        protocol=http port=7490; protocol=https port=4431
      location-modifier:  modifier='~' serviceName=myservice1;modifier='^~' serviceName=myservice2
    Events:
      Type     Reason             Age   From                                                            Message
      ----     ------             ----  ----                                                            -------
      Normal   Success            1m    public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Successfully applied ingress resource.
      Warning  TLSSecretNotFound  1m    public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Failed to apply ingress resource.
      Normal   Success            59s   public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Successfully applied ingress resource.
      Warning  AnnotationError    40s   public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Failed to apply ingress.bluemix.net/custom-port annotation. Error annotation format error : One of the mandatory fields not valid/missing for annotation ingress.bluemix.net/custom-port
      Normal   Success            40s   public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Successfully applied ingress resource.
      Warning  AnnotationError    2s    public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Failed to apply ingress.bluemix.net/custom-port annotation. Invalid port 7490. Annotation cannot use ports 7481 - 7490
      Normal   Success            2s    public-cr87c198fcf4bd458ca61402bb4c7e945a-alb1-258623678-gvf9n  Successfully applied ingress resource.
    ```
    {: screen}

6.  Vérifiez les journaux de l'équilibreur de charge de votre application.
    1.  Récupérez l'ID des pods Ingress qui sont en cours d'exécution dans votre cluster.

      ```
      kubectl get pods -n kube-system | grep alb1
      ```
      {: pre}

    2.  Récupérez les journaux pour chaque pod Ingress.

      ```
      kubectl logs <ingress_pod_id> nginx-ingress -n kube-system
      ```
      {: pre}

    3.  Recherchez les messages d'erreur dans les journaux de l'équilibreur de charge d'application.

<br />



## Problèmes de valeur confidentielle de l'équilibreur de charge d'application Ingress
{: #cs_albsecret_fails}

{: tsSymptoms}
Après avoir déployé une valeur confidentielle d'équilibreur de charge d'application Ingress dans votre cluster, la zone `Description` n'est pas actualisée avec le nom de valeur confidentielle lorsque vous examinez votre certificat dans {{site.data.keyword.cloudcerts_full_notm}}.

Lorsque vous listez les informations sur la valeur confidentielle de l'équilibreur de charge, son statut indique `*_failed` (Echec). Par exemple, `create_failed`, `update_failed`, `delete_failed`.

{: tsResolve}
Ci-dessous figurent les motifs pour lesquels la valeur confidentielle de l'équilibreur de charge d'application peut échouer, ainsi que les étapes de résolution correspondantes :

<table>
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
 <td><ol><li>Vérifiez l'exactitude de la chaîne de CRN de certificat soumise.</li><li>Si le CRN du certificat est exact, essayez de mettre à jour le code confidentiel : <code>bx cs alb-cert-deploy --update --cluster &lt;cluster_name_or_id&gt; --secret-name &lt;secret_name&gt; --cert-crn &lt;certificate_CRN&gt;</code></li><li>Si cette commande indique le statut <code>update_failed</code>, supprimez le code confidentiel : <code>bx cs alb-cert-rm --cluster &lt;cluster_name_or_id&gt; --secret-name &lt;secret_name&gt;</code></li><li>Déployez à nouveau le code confidentiel : <code>bx cs alb-cert-deploy --cluster &lt;cluster_name_or_id&gt; --secret-name &lt;secret_name&gt; --cert-crn &lt;certificate_CRN&gt;</code></li></ol></td>
 </tr>
 <tr>
 <td>Le CRN de certificat soumis lors de la mise à jour est incorrect.</td>
 <td><ol><li>Vérifiez l'exactitude de la chaîne de CRN de certificat soumise.</li><li>Si le CRN de certificat est exact, supprimez le code confidentiel : <code>bx cs alb-cert-rm --cluster &lt;cluster_name_or_id&gt; --secret-name &lt;secret_name&gt;</code></li><li>Déployez à nouveau le code confidentiel : <code>bx cs alb-cert-deploy --cluster &lt;cluster_name_or_id&gt; --secret-name &lt;secret_name&gt; --cert-crn &lt;certificate_CRN&gt;</code></li><li>Essayez de mettre à jour le code confidentiel : <code>bx cs alb-cert-deploy --update --cluster &lt;cluster_name_or_id&gt; --secret-name &lt;secret_name&gt; --cert-crn &lt;certificate_CRN&gt;</code></li></ol></td>
 </tr>
 <tr>
 <td>Le service {{site.data.keyword.cloudcerts_long_notm}} est confronté à un temps d'indisponibilité.</td>
 <td>Vérifiez que votre service {{site.data.keyword.cloudcerts_short}} est opérationnel.</td>
 </tr>
 </tbody></table>

<br />


## Impossible d'installer une charte Helm avec les valeurs de configuration mises à jour
{: #cs_helm_install}

{: tsSymptoms}
Lorsque vous essayez d'installer une charte Helm en exécutant la commande `helm install -f config.yaml --namespace=kube-system --name=<release_name> ibm/<chart_name>`, vous obtenez le message d'erreur `Error: failed to download "ibm/<chart_name>"`.

{: tsCauses}
L'adresse URL du référentiel {{site.data.keyword.Bluemix_notm}} dans votre instance Helm est peut-être incorrecte.

{: tsResolve}
Pour identifier et résoudre les problèmes liés à votre charte Helm :

1. Affichez la liste des référentiels actuellement disponibles dans votre instance Helm.

    ```
    helm repo list
    ```
    {: pre}

2. Dans la sortie, vérifiez que l'URL du référentiel {{site.data.keyword.Bluemix_notm}}, `ibm` est `https://registry.bluemix.net/helm/ibm`.

    ```
    NAME    URL
    stable  https://kubernetes-charts.storage.googleapis.com
    local   http://127.0.0.1:8888/charts
    ibm     https://registry.bluemix.net/helm/ibm
    ```
    {: screen}

    * Si l'URL n'est pas correcte :

        1. Retirez le référentiel {{site.data.keyword.Bluemix_notm}}.

            ```
            helm repo remove ibm
            ```
            {: pre}

        2. Ajoutez à nouveau le référentiel {{site.data.keyword.Bluemix_notm}}.

            ```
            helm repo add ibm  https://registry.bluemix.net/helm/ibm
            ```
            {: pre}

    * Si l'URL est correcte, obtenez les dernières mises à jour du référentiel.

        ```
        helm repo update
        ```
        {: pre}

3. Installez la charte Helm avec vos mises à jour.

    ```
    helm install -f config.yaml --namespace=kube-system --name=<release_name> ibm/<chart_name>
    ```
    {: pre}


<br />


## Impossible d'établir une connectivité VPN avec la charte Helm strongSwan
{: #cs_vpn_fails}

{: tsSymptoms}
Lorsque vous vérifiez la connectivité VPN en exécutant `kubectl exec -n kube-system  $STRONGSWAN_POD -- ipsec status`, vous ne voyez pas le statut `ESTABLISHED`, ou le pod du VPN est à l'état `ERROR` ou ne cesse de planter et redémarrer.

{: tsCauses}
Le fichier de configuration de votre charte Helm contient des valeurs incorrectes ou manquantes, ou comporte des erreurs de syntaxe.

{: tsResolve}
Lorsque vous essayez d'établir une connectivité VPN avec la charte Helm strongSwan, il est fort probable que le statut du VPN ne soit pas `ESTABLISHED` la première fois. Vous pourrez vérifier plusieurs types d'erreurs et modifier votre fichier de configuration en conséquence. Pour identifier et résoudre les incidents liés à la connectivité VPN strongSwan :

1. Comparez les paramètres du noeud final VPN sur site par rapport aux paramètres de votre fichier de configuration. S'ils ne correspondent pas :

    <ol>
    <li>Supprimez la charte Helm existante.</br><pre class="codeblock"><code>helm delete --purge <release_name></code></pre></li>
    <li>Corrigez les valeurs incorrectes dans le fichier <code>config.yaml</code> et sauvegardez le fichier mis à jour.</li>
    <li>Installez la nouvelle charte Helm.</br><pre class="codeblock"><code>helm install -f config.yaml --namespace=kube-system --name=<release_name> bluemix/strongswan</code></pre></li>
    </ol>

2. Si le pod VPN est à l'état d'erreur (`ERROR`) ou continue à planter et à redémarrer, cela peut être dû à une validation de paramètres dans la section `ipsec.conf` de la mappe de configuration de la charte.

    <ol>
    <li>Vérifiez les éventuelles erreurs de validation dans les journaux du pod Strongswan.</br><pre class="codeblock"><code>kubectl logs -n kube-system $STRONGSWAN_POD</code></pre></li>
    <li>S'il y a des erreurs de validation, supprimez la charte Helm existante.</br><pre class="codeblock"><code>helm delete --purge <release_name></code></pre></li>
    <li>Corrigez les valeurs incorrectes dans le fichier `config.yaml` et sauvegardez le fichier mis à jour.</li>
    <li>Installez la nouvelle charte Helm.</br><pre class="codeblock"><code>helm install -f config.yaml --namespace=kube-system --name=<release_name> bluemix/strongswan</code></pre></li>
    </ol>

3. Exécutez les 5 tests Helm inclus dans la définition de la charte strongSwan.

    <ol>
    <li>Exécutez les tests Helm.</br><pre class="codeblock"><code>helm test vpn</code></pre></li>
    <li>En cas d'échec d'un test, référez-vous à la rubrique [Description des tests Helm de connectivité VPN](cs_vpn.html#vpn_tests_table) pour obtenir des informations sur chaque test et les causes possibles de leur échec. <b>Remarque</b> : Certains de ces tests ont des conditions requises qui font partie des paramètres facultatifs dans la configuration du VPN. En cas d'échec de certains tests, les erreurs peuvent être acceptables si vous avez indiqué ces paramètres facultatifs.</li>
    <li>Affichez la sortie d'un test ayant échoué en consultant les journaux du pod de test.<br><pre class="codeblock"><code>kubectl logs -n kube-system <test_program></code></pre></li>
    <li>Supprimez la charte Helm existante.</br><pre class="codeblock"><code>helm delete --purge <release_name></code></pre></li>
    <li>Corrigez les valeurs incorrectes dans le fichier <code>config.yaml</code> et sauvegardez le fichier mis à jour.</li>
    <li>Installez la nouvelle charte Helm.</br><pre class="codeblock"><code>helm install -f config.yaml --namespace=kube-system --name=<release_name> bluemix/strongswan</code></pre></li>
    <li>Pour vérifiez vos modifications :<ol><li>Récupérez les pods de test actuels.</br><pre class="codeblock"><code>kubectl get pods -a -n kube-system -l app=strongswan-test</code></pre></li><li>Nettoyez les pods du test en cours.</br><pre class="codeblock"><code>kubectl delete pods -n kube-system -l app=strongswan-test</code></pre></li><li>Réexécutez les tests.</br><pre class="codeblock"><code>helm test vpn</code></pre></li>
    </ol></ol>

4. Exécutez l'outil de débogage VPN inclus dans l'image du pod VPN.

    1. Définissez la variable d'environnement `STRONGSWAN_POD`.

        ```
        export STRONGSWAN_POD=$(kubectl get pod -n kube-system -l app=strongswan,release=vpn -o jsonpath='{ .items[0].metadata.name }')
        ```
        {: pre}

    2. Exécutez l'outil de débogage.

        ```
        kubectl exec -n kube-system  $STRONGSWAN_POD -- vpnDebug
        ```
        {: pre}

        L'outil renvoie plusieurs pages d'informations à mesure qu'il exécute différents tests pour détecter les problèmes réseau courants. Les lignes de sortie commençant par `ERROR`, `WARNING`, `VERIFY` ou `CHECK` indiquent des erreurs possibles liées à la connectivité VPN.

    <br />


## La connectivité VPN strongSwan échoue après l'ajout ou la suppression d'un noeud worker
{: #cs_vpn_fails_worker_add}

{: tsSymptoms}
Vous avez déjà établi une connexion VPN opérationnelle en utilisant le service VPN IPSec strongSwan. Cependant, après avoir ajouté ou supprimé un noeud worker sur votre cluster, vous expérimentez un ou plusieurs symptômes de ce type :

* vous n'obtenez pas le statut VPN `ESTABLISHED`
* vous ne parvenez pas à accéder aux nouveaux noeuds worker à partir de votre réseau local
* vous ne pouvez pas accéder au réseau distant à partir des pods qui s'exécutent sur les nouveaux noeuds worker

{: tsCauses}
Si vous avez ajouté un noeud worker :

* le noeud worker a été mis en place sur un nouveau sous-réseau privé qui n'est pas exposé via la connexion VPN avec vos paramètres `localSubnetNAT` ou `local.subnet`
* les routes VPN ne peuvent pas être ajoutées au noeud worker car celui-ci possède des annotations taint ou des étiquettes qui ne sont pas incluses dans vos paramètres `tolerations` ou `nodeSelector`
* le pod VPN s'exécute sur le nouveau noeud worker, mais l'adresse IP publique de ce noeud n'est pas autorisée via le pare-feu local

Si vous avez supprimé un noeud worker :

* ce noeud worker constituait le seul noeud sur lequel un pod VPN s'exécutait, en raison des restrictions relatives à certaines annotations taint ou étiquettes dans vos paramètres `tolerations` ou `nodeSelector`

{: tsResolve}
Mettez à jour les valeurs de la charte Helm pour répercuter les modifications du noeud worker :

1. Supprimez la charte Helm existante.

    ```
    helm delete --purge <release_name>
    ```
    {: pre}

2. Ouvrez le fichier de configuration correspondant au service VPN strongSwan.

    ```
    helm inspect values ibm/strongswan > config.yaml
    ```
    {: pre}

3. Vérifiez les paramètres suivants et effectuez les modifications nécessaires pour répercuter les noeuds worker ajoutés ou supprimés selon les besoins.

    Si vous avez ajouté un noeud worker :

    <table>
     <thead>
     <th>Paramètre</th>
     <th>Description</th>
     </thead>
     <tbody>
     <tr>
     <td><code>localSubnetNAT</code></td>
     <td>Le noeud worker ajouté peut être déployé sur un nouveau sous-réseau privé différent des autres sous-réseaux existants sur lesquels résident les autres noeuds worker. Si vous utilisez la conversion NAT de sous-réseau pour remapper les adresses IP locales privées de votre cluster et que le noeud worker a été ajouté sur un nouveau sous-réseau, ajoutez le CIDR du nouveau sous-réseau à ce paramètre.</td>
     </tr>
     <tr>
     <td><code>nodeSelector</code></td>
     <td>Si vous aviez déjà limité le pod VPN de sorte à ce qu'il s'exécute sur n'importe quels noeuds worker avec une étiquette spécifique, et que vous souhaitez que des routes VPN soient ajoutées au noeud worker, assurez-vous que le noeud worker ajouté ait cette étiquette.</td>
     </tr>
     <tr>
     <td><code>tolerations</code></td>
     <td>Si le noeud worker ajouté comporte des annotations taint et que vous souhaitez que des routes VPN soient ajoutées à ce noeud, modifiez ce paramètre pour autoriser le pod VPN à s'exécuter sur tous les noeuds worker avec des annotations taint ou ayant des annotations taint spécifiques.</td>
     </tr>
     <tr>
     <td><code>local.subnet</code></td>
     <td>Le noeud worker ajouté peut être déployé sur un nouveau sous-réseau privé différent des autres sous-réseaux existants sur lesquels résident les autres noeuds worker. Si vos applications sont exposées par les services NodePort or LoadBalancer sur le réseau privé et qu'elles sont sur un nouveau noeud worker que vous avez ajouté, ajoutez le nouveau CIDR du sous-réseau à ce paramètre. **Remarque** : Si vous ajoutez des valeurs au paramètre `local.subnet`, vérifiez les paramètres VPN du sous-réseau local pour voir s'ils doivent également faire l'objet d'une mise à jour.</td>
     </tr>
     </tbody></table>

    Si vous avez supprimé un noeud worker :

    <table>
     <thead>
     <th>Paramètre</th>
     <th>Description</th>
     </thead>
     <tbody>
     <tr>
     <td><code>localSubnetNAT</code></td>
     <td>Si vous utilisez la conversation NAT de sous-réseau pour remapper des adresses IP locale privées spécifiques, supprimez les adresses IP de l'ancien noeud worker. Si vous utilisez la conversion NAT de sous-réseau pour remapper des sous-réseaux entiers et que vous n'avez aucun noeud worker restant sur un sous-réseau, supprimez le CIDR de sous-réseau de ce paramètre.</td>
     </tr>
     <tr>
     <td><code>nodeSelector</code></td>
     <td>Si vous avez limité le pod VPN de sorte qu'il s'exécute sur un noeud worker unique et que ce noeud a été supprimé, modifiez ce paramètre pour autoriser le pod VPN à s'exécuter sur d'autres noeuds worker.</td>
     </tr>
     <tr>
     <td><code>tolerations</code></td>
     <td>Si le noeud worker que vous avez supprimé n'avait pas d'annotation taint, mais que seuls les noeuds restants ont des annotations taint, modifiez ce paramètre pour autoriser le pod VPN à s'exécuter sur tous les noeuds worker ayant des annotations taint ou ayant des annotaions taint spécifiques.
     </td>
     </tr>
     </tbody></table>

4. Installez la nouvelle charte Helm avec vos valeurs mises à jour.

    ```
    helm install -f config.yaml --namespace=kube-system --name=<release_name> ibm/strongswan
    ```
    {: pre}

5. Vérifiez le statut de déploiement de la charte. Lorsque la charte est prête, la zone **STATUS** vers le haut de la sortie indique `DEPLOYED`.

    ```
    helm status <release_name>
    ```
    {: pre}

6. Dans certains cas, il vous faudra changer vos paramètres locaux et vos paramètres de pare-feu pour les adapter aux modifications que vous avez apportées au fichier de configuration VPN.

7. Démarrez le VPN.
    * Si la connexion VPN est initialisée par le cluster (`ipsec.auto` est défini sur `start`), démarrez le VPN sur la passerelle locale, puis démarrez le VPN sur le cluster.
    * Si la connexion VPN est initialisée par la passerelle locale (`ipsec.auto` est défini sur `auto`), démarrez le VPN sur le cluster, puis démarrez le VPN sur la passerelle locale.

8. Définissez la variable d'environnement `STRONGSWAN_POD`.

    ```
    export STRONGSWAN_POD=$(kubectl get pod -n kube-system -l app=strongswan,release=<release_name> -o jsonpath='{ .items[0].metadata.name }')
    ```
    {: pre}

9. Vérifiez le statut du réseau privé virtuel.

    ```
    kubectl exec -n kube-system  $STRONGSWAN_POD -- ipsec status
    ```
    {: pre}

    * Si la connexion VPN a le statut `ESTABLISHED`, la connexion a abouti. Aucune autre action n'est requise.

    * Si vous rencontrez toujours des problèmes de connexion, voir [Impossible d'établir une connectivité VPN avec la charte Helm strongSwan](#cs_vpn_fails) pour continuer à résoudre les problèmes de connexion VPN.

<br />


## Impossible d'extraire l'URL ETCD pour la configuration d'interface CLI de Calico
{: #cs_calico_fails}

{: tsSymptoms}
Lorsque vous extrayez l'URL `<ETCD_URL>` pour [ajouter des règles réseau](cs_network_policy.html#adding_network_policies), vous obtenez le message d'erreur `calico-config not found`.

{: tsCauses}
Votre cluster n'est pas à la [version Kubernetes 1.7](cs_versions.html) ou ultérieure.

{: tsResolve}
[Mettez à jour votre cluster](cs_cluster_update.html#master) ou extrayez l'URL `<ETCD_URL>` avec des commandes compatibles avec les versions antérieures de Kubernetes.

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
{: shortdesc}

-   Pour déterminer si {{site.data.keyword.Bluemix_notm}} est disponible, [consultez la page de statut de {{site.data.keyword.Bluemix_notm}} ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://developer.ibm.com/bluemix/support/#status).
-   Publiez une question sur le site [{{site.data.keyword.containershort_notm}} Slack. ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://ibm-container-service.slack.com) Conseil : si vous n'utilisez pas un ID IBM pour votre compte {{site.data.keyword.Bluemix_notm}}, [demandez une invitation](https://bxcs-slack-invite.mybluemix.net/) à ce Slack.
-   Consultez les forums pour établir si d'autres utilisateurs ont rencontré le même problème. Lorsque vous utilisez les forums pour poser une question, balisez votre question de sorte que les équipes de développement {{site.data.keyword.Bluemix_notm}} la voient.

    -   Si vous avez des questions d'ordre technique sur le développement ou le déploiement de clusters ou d'applications à l'aide d'{{site.data.keyword.containershort_notm}}, publiez-les sur le site [Stack Overflow ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://stackoverflow.com/questions/tagged/ibm-cloud+containers) en leur adjoignant les balises `ibm-cloud`, `kubernetes` et `containers`.
    -   Pour des questions relatives au service et aux instructions de mise en route, utilisez le forum [IBM developerWorks dW Answers ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://developer.ibm.com/answers/topics/containers/?smartspace=bluemix). Incluez les balises `ibm-cloud` et `containers`.
    Voir [Comment obtenir de l'aide](/docs/get-support/howtogetsupport.html#using-avatar)
pour plus d'informations sur l'utilisation des forums.

-   Contactez le support IBM. Pour plus d'informations sur l'ouverture d'un ticket de demande de service IBM, sur les niveaux de support disponibles ou les niveaux de gravité des tickets, voir la rubrique décrivant [comment contacter le support](/docs/get-support/howtogetsupport.html#getting-customer-support).

{:tip}
Lorsque vous signalez un problème, incluez l'ID de votre cluster. Pour identifier l'ID du cluster, exécutez la commande `bx cs clusters`.
