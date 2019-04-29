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
{:tsSymptoms: .tsSymptoms}
{:tsCauses: .tsCauses}
{:tsResolve: .tsResolve}



# Débogage de votre cluster
{: #cs_troubleshoot}

Lorsque vous utilisez {{site.data.keyword.containerlong}}, tenez compte des techniques décrites ci-dessous pour identifier et résoudre les incidents d'ordre général et déboguer vos clusters. Vous pouvez également vérifier le [statut du système {{site.data.keyword.Bluemix_notm}} ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://developer.ibm.com/bluemix/support/#status).
{: shortdesc}

Vous pouvez effectuer ces étapes générales pour vérifier que vos clusters sont à jour :
- Vérifiez tous les mois les mises à jour de sécurité et de système d'exploitation disponibles pour [mettre à jour vos noeuds worker](/docs/containers?topic=containers-cs_cli_reference#cs_worker_update).
- [Mettez à jour votre cluster](/docs/containers?topic=containers-cs_cli_reference#cs_cluster_update) à la [version de Kubernetes](/docs/containers?topic=containers-cs_versions) par défaut la plus récente pour {{site.data.keyword.containerlong_notm}}

## Exécution de tests avec l'outil de débogage et de diagnostic d'{{site.data.keyword.containerlong_notm}}
{: #debug_utility}

Lorsque vous traitez les incidents, vous pouvez utiliser l'outil de débogage et de diagnostic d'{{site.data.keyword.containerlong_notm}} pour exécuter des tests et regrouper des informations pertinentes concernant votre cluster. Pour utiliser l'outil de débogage, installez la [charte Helm `ibmcloud-iks-debug` ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://cloud.ibm.com/containers-kubernetes/solutions/helm-charts/ibm/ibmcloud-iks-debug) :
{: shortdesc}


1. [Configurez Helm dans votre cluster, créez un compte de service pour Tiller et ajoutez le référentiel `ibm` dans votre instance Helm](/docs/containers?topic=containers-integrations#helm).

2. Installez la charte Helm dans votre cluster.
  ```
  helm install ibm/ibmcloud-iks-debug --name debug-tool
  ```
  {: pre}


3. Démarrez un serveur proxy pour afficher l'interface de l'outil de débogage.
  ```
  kubectl proxy --port 8080
  ```
  {: pre}

4. Dans un navigateur Web, ouvrez l'URL de l'interface de l'outil de débogage : http://localhost:8080/api/v1/namespaces/default/services/debug-tool-ibmcloud-iks-debug:8822/proxy/page

5. Sélectionnez des tests individuels ou une série de tests à exécuter. Certains tests vérifient les avertissements, erreurs ou problèmes potentiels, d'autres se contentent de rassembler des informations que vous pouvez utiliser comme référence lorsque vous traitez les incidents. Pour plus d'informations sur la fonction de chaque test, cliquez sur l'icône d'information en regard du nom du test.

6. Cliquez sur **Exécuter**.

7. Vérifiez les résultats de chaque test.
  * Si un test échoue, cliquez sur l'icône d'information en regard du nom du test dans la colonne de gauche pour savoir comment résoudre le problème.
  * Vous pouvez également utiliser les résultats des tests pour regrouper des informations, par exemple des fichiers YAML complets, qui pourront vous aider à déboguer votre cluster dans les sections suivantes.

## Débogage des clusters
{: #debug_clusters}

Passez en revue les options permettant de déboguer vos clusters et d'identifier les causes premières des échecs.

1.  Affichez votre cluster et identifiez son état (`State`).

  ```
  ibmcloud ks clusters
  ```
  {: pre}

2.  Examinez l'état (`State`) de votre cluster. S'il est à l'état **Critical**, **Delete failed** ou **Warning**, ou s'il est bloqué à l'état **Pending** depuis longtemps, commencez à [déboguer les noeuds worker](#debug_worker_nodes).

    <table summary="Chaque ligne de tableau doit être lue de gauche à droite. L'état du cluster figure dans la première colonne et la description correspondante dans la seconde colonne.">
<caption>Etats du cluster</caption>
   <thead>
   <th>Etat du cluster</th>
   <th>Description</th>
   </thead>
   <tbody>
<tr>
   <td>Aborted</td>
   <td>La suppression du cluster est demandée par l'utilisateur avant le déploiement du maître Kubernetes. Une fois supprimé, le cluster est retiré de votre tableau de bord. Si votre cluster est bloqué dans cet état depuis longtemps, ouvrez un [cas de support {{site.data.keyword.Bluemix_notm}}](/docs/containers?topic=containers-cs_troubleshoot#ts_getting_help).</td>
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
     <td>Le cluster a bien été supprimé mais n'est pas encore retiré de votre tableau de bord. Si votre cluster est bloqué dans cet état depuis longtemps, ouvrez un [cas de support {{site.data.keyword.Bluemix_notm}}](/docs/containers?topic=containers-cs_troubleshoot#ts_getting_help).</td>
   </tr>
   <tr>
   <td>Deleting</td>
   <td>Le cluster est en cours de suppression et son infrastructure est en cours de démantèlement. Vous ne pouvez pas accéder au cluster.  </td>
   </tr>
   <tr>
     <td>Deploy failed</td>
     <td>Le déploiement du maître Kubernetes n'a pas abouti. Vous ne pouvez pas résoudre cet état. Contactez le support IBM Cloud en ouvrant un [cas de support {{site.data.keyword.Bluemix_notm}}](/docs/containers?topic=containers-cs_troubleshoot#ts_getting_help).</td>
   </tr>
     <tr>
       <td>Deploying</td>
       <td>Le maître Kubernetes n'est pas encore complètement déployé. Vous ne pouvez pas accéder à votre cluster. Patientez jusqu'à la fin du déploiement complet de votre cluster pour examiner l'état de santé de votre cluster.</td>
      </tr>
      <tr>
       <td>Normal</td>
       <td>Tous les noeuds worker d'un cluster sont opérationnels. Vous pouvez accéder au cluster et déployer les applications sur le cluster. Cet état est considéré comme bon et ne nécessite aucune action de votre part.<p class="note">Même si les noeuds worker peuvent être normaux, d'autres ressources d'infrastructure, telles que les [réseaux](/docs/containers?topic=containers-cs_troubleshoot_network) et le [stockage](/docs/containers?topic=containers-cs_troubleshoot_storage), peuvent continuer à exiger de l'attention.</p></td>
    </tr>
      <tr>
       <td>Pending</td>
       <td>Le maître Kubernetes est déployé. La mise à disposition des noeuds worker est en cours. Ces derniers ne sont pas encore disponibles dans le cluster. Vous pouvez accéder au cluster, mais vous ne pouvez pas déployer d'applications sur le cluster.  </td>
     </tr>
   <tr>
     <td>Requested</td>
     <td>Une demande de création du cluster et d'organisation de l'infrastructure du maître Kubernetes et des noeuds worker est envoyée. Lorsque le déploiement du cluster commence, l'état du cluster passe à <code>Deploying</code>. Si votre cluster est bloqué à l'état <code>Requested</code> depuis longtemps, ouvrez un [cas de support {{site.data.keyword.Bluemix_notm}}](/docs/containers?topic=containers-cs_troubleshoot#ts_getting_help).</td>
   </tr>
   <tr>
     <td>Updating</td>
     <td>Le serveur d'API Kubernetes qui s'exécute sur votre maître Kubernetes est en cours de mise à jour pour passer à une nouvelle version d'API Kubernetes. Pendant la mise à jour, vous ne pouvez ni accéder au cluster, ni le modifier. Les noeuds worker, les applications et les ressources que l'utilisateur a déployés ne sont pas modifiés et continuent à s'exécuter. Patientez jusqu'à la fin de la mise à jour pour examiner l'état de santé de votre cluster. </td>
   </tr>
    <tr>
       <td>Warning</td>
       <td>Au moins un noeud worker du cluster n'est pas disponible. Cela dit, les autres noeuds worker sont disponibles et peuvent prendre le relais pour la charge de travail. </td>
    </tr>
   </tbody>
 </table>


Le [maître Kubernetes](/docs/containers?topic=containers-ibm-cloud-kubernetes-service-technology#architecture) est le composant principal qui permet de garder votre cluster opérationnel. Le maître stocke les ressources du cluster et leurs configurations dans la base de données etcd qui assure le bon fonctionnement de votre cluster. Le serveur d'API Kubernetes correspond au point d'entrée principal pour toutes les demandes de gestion de cluster des noeuds worker au maître, ou lorsque vous souhaitez interagir avec les ressources de votre cluster.<br><br>En cas de défaillance du maître, vos charges de travail continuent à s'exécuter sur les noeuds worker, mais vous ne pouvez pas utiliser des commandes `kubectl` pour gérer les ressources de votre cluster ou afficher l'état de santé du cluster tant que le serveur d'API Kubernetes dans le maître n'est pas opérationnel. Si un pod tombe en panne lors d'une indisponibilité du maître, le pod ne peut pas être replanifié tant que le noeud worker n'a pas rétabli le contact avec le serveur d'API Kubernetes.<br><br>Lors d'une indisponibilité du maître, vous pouvez toujours exécuter des commandes `ibmcloud ks` pour l'API {{site.data.keyword.containerlong_notm}} pour gérer vos ressources d'infrastructure, telles que les noeuds worker ou les réseaux locaux virtuels (VLAN). Si vous modifiez la configuration actuelle du cluster en ajoutant ou en retirant des noeuds worker dans le cluster, vos modifications ne sont pas appliquées tant que le maître n'est pas opérationnel.

Ne pas redémarrer ou réamorcer un noeud worker pendant la durée d'indisponibilité du maître. Cette action retire les pods de votre noeud worker. Comme le serveur d'API Kubernetes n'est pas disponible, les pods ne peuvent pas être replanifiés sur d'autres noeuds worker dans le cluster.
{: important}


<br />


## Débogage des noeuds worker
{: #debug_worker_nodes}

Passez en revue les options permettant de déboguer vos noeuds worker et d'identifier les causes premières des échecs.


1.  Si votre cluster est à l'état **Critical**, **Delete failed** ou **Warning**, ou s'il est bloqué à l'état **Pending** depuis longtemps, vérifiez l'état de vos noeuds worker.

  ```
  ibmcloud ks workers --cluster <cluster_name_or_id>
  ```
  {: pre}

2.  Consultez les zones `State` et `Status` correspondant à chaque noeud worker dans votre sortie d'interface CLI.

  <table summary="Chaque ligne de tableau doit être lue de gauche à droite. L'état du cluster figure dans la première colonne et la description correspondante dans la seconde colonne.">
  <caption>Etats du noeud worker</caption>
    <thead>
    <th>Etat du noeud worker</th>
    <th>Description</th>
    </thead>
    <tbody>
  <tr>
      <td>Critical</td>
      <td>Un noeud worker peut passer à l'état critique (Critical) pour de nombreuses raisons : <ul><li>Vous avez lancé un réamorçage de votre noeud worker sans avoir exécuté les commandes cordon et drain sur votre noeud worker. Le réamorçage d'un noeud worker peut entraîner des altérations de données dans <code>containerd</code>, <code>kubelet</code>, <code>kube-proxy</code> et <code>calico</code>. </li>
      <li>Les pods qui sont déployés sur votre noeud worker n'utilisent pas de limites de ressources de [mémoire ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/tasks/configure-pod-container/assign-memory-resource/) et d'[UC ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/tasks/configure-pod-container/assign-cpu-resource/). Sans limite de ressources, les pods peuvent consommer toutes les ressources disponibles, sans en laisser pour l'exécution d'autres pods sur ce noeud worker. Cette sursollicitation de charge de travail entraîne l'échec du noeud worker. </li>
      <li><code>containerd</code>, <code>kubelet</code> ou <code>calico</code> sont passés dans un état irrémédiable après avoir exécuté des centaines ou des milliers de conteneurs à la longue. </li>
      <li>Vous avez configuré un dispositif de routeur virtuel (VRA) pour votre noeud worker qui n'est plus opérationnel et a interrompu la communication entre votre noeud worker et le maître Kubernetes. </li><li> Des problèmes réseau dans {{site.data.keyword.containerlong_notm}} ou dans l'infrastructure IBM Cloud (SoftLayer) qui entraînent une coupure de communication entre votre noeud worker et le maître Kubernetes.</li>
      <li>La capacité de votre noeud worker a été dépassée. Vérifiez l'état (<strong>Status</strong>) du noeud worker pour voir s'il indique un espace disque insuffisant (<strong>Out of disk</strong>) ou une mémoire insuffisante (<strong>Out of memory</strong>). Si votre noeud worker n'a plus de capacité disponible, envisagez de réduire la charge de travail sur ce noeud ou ajoutez un noeud worker à votre cluster pour mieux équilibrer la charge de travail.</li>
      <li>Le périphérique est hors tension dans la [liste de ressources de la console {{site.data.keyword.Bluemix_notm}} ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://cloud.ibm.com/resources). Ouvrez la liste de ressources et recherchez l'ID de votre noeud worker dans la liste **Périphériques**. Dans le menu Actions, cliquez sur **Mettre sous tension**.</li></ul>
      Dans de nombreux cas, [recharger](/docs/containers?topic=containers-cs_cli_reference#cs_worker_reload) votre noeud worker peut résoudre le problème. Lorsque vous rechargez votre noeud worker, la [version de correctif](/docs/containers?topic=containers-cs_versions#version_types) la plus récente est appliquée à votre noeud worker. La version principale et secondaire reste inchangée. Avant de recharger votre noeud worker,  assurez-vous d'effectuer les opérations cordon et drain sur le noeud pour garantir l'interruption en douceur des pods existants et leur replanification sur les noeuds worker restants. </br></br> Si le rechargement du noeud worker ne résout pas le problème, passez à l'étape suivante pour poursuivre l'identification et la résolution des problèmes de votre noeud worker. </br></br><strong>Astuce :</strong> vous pouvez [configurer des diagnostics d'intégrité de votre noeud worker et activer la reprise automatique](/docs/containers?topic=containers-health#autorecovery). Si le système de reprise automatique détecte un mauvais état de santé d'un noeud worker d'après les vérifications configurées, il déclenche une mesure corrective (par exemple, un rechargement du système d'exploitation) sur le noeud worker. Pour plus d'informations sur le fonctionnement de la reprise automatique, consultez le [blogue Autorecovery ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://www.ibm.com/blogs/bluemix/2017/12/autorecovery-utilizes-consistent-hashing-high-availability/).
      </td>
     </tr>
     <tr>
     <td>Deployed</td>
     <td>Les mises à jour sont déployées correctement sur votre noeud worker. Une fois les mises à jour déployées, {{site.data.keyword.containerlong_notm}} lance un diagnostic d'intégrité sur le noeud worker. Lorsque le diagnostic est concluant, le noeud worker passe à l'état <code>Normal</code>. Les noeuds worker à l'état <code>Deployed</code> sont en principe prêts à recevoir des charges de travail. Vous pouvez le vérifier en exécutant la commande <code>kubectl get nodes</code> et en confirmant que l'état indique bien <code>Normal</code>. </td>
     </tr>
      <tr>
        <td>Deploying</td>
        <td>Lorsque vous mettez à jour la version Kubernetes de votre noeud worker, le noeud est redéployé pour installer les mises à jour. Si vous rechargez ou réamorcez votre noeud worker, celui-ci est redéployé pour installer automatiquement la dernière version de correctif. Si votre noeud worker est bloqué dans cet état depuis longtemps, passez à l'étape suivante pour voir s'il y a eu un problème lors du déploiement. </td>
     </tr>
        <tr>
        <td>Normal</td>
        <td>Votre noeud worker est entièrement mis à disposition et il est prêt à être utilisé dans le cluster. Cet état est considéré comme bon et ne nécessite aucune action de l'utilisateur. **Remarque** : même si les noeuds worker peuvent être normaux, d'autres ressources d'infrastructure, telles que les [réseaux](/docs/containers?topic=containers-cs_troubleshoot_network) et le [stockage](/docs/containers?topic=containers-cs_troubleshoot_storage), peuvent continuer à exiger de l'attention.</td>
     </tr>
   <tr>
        <td>Provisioning</td>
        <td>La mise à disposition de votre noeud worker est en cours. Ce dernier n'est pas encore disponible dans le cluster. Vous pouvez surveiller le processus de mise à disposition dans la colonne <strong>Status</strong> de la sortie générée par l'interface de ligne de commande. Si votre noeud worker est bloqué dans cet état depuis longtemps, passez à l'étape suivante pour voir s'il y a eu un problème lors de la mise à disposition.</td>
      </tr>
      <tr>
        <td>Provision_failed</td>
        <td>Votre noeud worker n'a pas pu être mis à disposition. Passez à l'étape suivante pour rechercher les détails relatifs à cet échec.</td>
      </tr>
   <tr>
        <td>Reloading</td>
        <td>Le rechargement de votre noeud worker est en cours. Ce dernier n'est pas disponible dans le cluster. Vous pouvez surveiller le processus de rechargement dans la colonne <strong>Status</strong> de la sortie générée par l'interface de ligne de commande. Si votre noeud worker est bloqué dans cet état depuis longtemps, passez à l'étape suivante pour voir s'il y a eu un problème lors du rechargement.</td>
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
       <td>Le maître Kubernetes est inaccessible pour l'une des raisons suivantes :<ul><li>Vous avez demandé une mise à jour de votre maître Kubernetes. L'état du noeud worker ne peut pas être extrait lors de la mise à jour. Si le noeud worker reste dans cet état sur une période prolongée même une fois que la mise à jour du maître Kubernetes a abouti, essayez de [recharger](/docs/containers?topic=containers-cs_cli_reference#cs_worker_reload) le noeud worker.</li><li>Peut-être possédez-vous un autre pare-feu qui protège vos noeuds worker ou avez-vous récemment modifié vos paramètres de pare-feu. {{site.data.keyword.containerlong_notm}} requiert que certaines adresses IP et certains ports soient ouverts pour permettre la communication entre le noeud worker et le maître Kubernetes et inversement. Pour plus d'informations, voir [Pare-feu empêchant la connexion des noeuds worker](/docs/containers?topic=containers-cs_troubleshoot_clusters#cs_firewall).</li><li>Le maître Kubernetes est arrêté. Contactez le support {{site.data.keyword.Bluemix_notm}} en ouvrant un [cas de support {{site.data.keyword.Bluemix_notm}}](#ts_getting_help).</li></ul></td>
  </tr>
     <tr>
        <td>Warning</td>
        <td>Votre noeud worker est sur le point d'atteindre la limite en termes de mémoire ou d'espace disque. Vous pouvez réduire la charge de travail sur votre noeud worker ou ajouter un noeud worker à votre cluster pour contribuer à l'équilibrage de la charge de travail.</td>
  </tr>
    </tbody>
  </table>

5.  Affichez la liste des détails relatifs à votre noeud worker. Si les détails comprennent un message d'erreur, consultez la liste des [messages d'erreur courants concernant les noeuds worker](#common_worker_nodes_issues) pour savoir comment résoudre le problème.
  ```
  ibmcloud ks worker-get --cluster <cluster_name_or_id> --worker <worker_node_id>
  ```
  {: pre}

<br />


## Erreurs courantes avec les noeuds worker
{: #common_worker_nodes_issues}

Passez en revue les messages d'erreurs courantes et apprenez à résoudre les problèmes correspondants.

  <table>
  <caption>Messages d'erreur courants</caption>
    <thead>
    <th>Message d'erreur</th>
    <th>Description et résolution
    </thead>
    <tbody>
      <tr>
        <td>Exception liée à l'infrastructure {{site.data.keyword.Bluemix_notm}} : votre compte n'est pas autorisé à réserver des instances de traitement pour l'instant.</td>
        <td>La réservation de ressources de traitement par votre compte d'infrastructure IBM Cloud (SoftLayer) n'est peut-être pas possible. Contactez le support {{site.data.keyword.Bluemix_notm}} en ouvrant un [cas de support {{site.data.keyword.Bluemix_notm}}](#ts_getting_help).</td>
      </tr>
      <tr>
      <td>Exception liée à l'infrastructure {{site.data.keyword.Bluemix_notm}} : impossible de passer une commande.<br><br>
      Exception liée à l'infrastructure {{site.data.keyword.Bluemix_notm}} : impossible de passer la commande. Les ressources derrière le routeur 'router_name' ne sont pas suffisantes pour satisfaire la demande pour les invités suivants : 'worker_id'.</td>
      <td>La zone que vous avez sélectionnée ne dispose peut-être pas de la capacité d'infrastructure suffisante pour mettre à disposition vos noeuds worker. Ou, il se peut que vous ayez dépassé une limite dans votre compte d'infrastructure IBM Cloud (SoftLayer). Pour y remédier, essayez l'une des options suivantes :
      <ul><li>La disponibilité des ressources de l'infrastructure dans les zones peut souvent varier. Patientez quelques minutes et réessayez.</li>
      <li>Pour un cluster à zone unique, créez le cluster dans une autre zone. Pour un cluster à zones multiples, ajoutez une zone dans le cluster.</li>
      <li>Indiquez une paire de VLAN public et privé différente pour vos noeuds worker dans votre compte d'infrastructure IBM Cloud (SoftLayer). Pour les noeuds worker inclus dans un pool de noeuds worker, vous pouvez utiliser la [commande](/docs/containers?topic=containers-cs_cli_reference#cs_zone_network_set) <code>ibmcloud ks zone-network-set</code>.</li>
      <li>Contactez votre chargé de compte d'infrastructure IBM Cloud (SoftLayer) pour vérifier que vous ne dépassez pas une limite, par exemple un quota global.</li>
      <li>Ouvrez un [cas de support IBM Cloud infrastructure (SoftLayer)](#ts_getting_help)</li></ul></td>
      </tr>
      <tr>
        <td>Exception liée à l'infrastructure {{site.data.keyword.Bluemix_notm}} : impossible d'obtenir le réseau local virtuel avec l'ID : <code>&lt;vlan id&gt;</code>.</td>
        <td>Votre noeud worker n'a pas pu être mis à disposition car l'ID de réseau local virtuel sélectionné est introuvable pour l'une des raisons suivantes :<ul><li>Vous avez indiqué le numéro de réseau local virtuel au lieu de l'ID de réseau local virtuel. Le numéro de réseau local virtuel est composé de 3 ou 4 chiffres, tandis que l'ID de réseau local virtuel est composé de 7 chiffres. Exécutez la commande <code>ibmcloud ks vlans --zone &lt;zone&gt;</code> pour extraire l'ID du réseau local virtuel.<li>L'ID de réseau local virtuel (VLAN) n'est peut-être pas associé au compte d'infrastructure IBM Cloud (SoftLayer) que vous utilisez. Exécutez la commande <code>ibmcloud ks vlans --zone &lt;zone&gt;</code> pour afficher la liste des ID de VLAN disponibles pour votre compte. Pour changer de compte d'infrastructure IBM Cloud (SoftLayer), voir la commande [`ibmcloud ks credential-set`](/docs/containers?topic=containers-cs_cli_reference#cs_credentials_set). </ul></td>
      </tr>
      <tr>
        <td>SoftLayer_Exception_Order_InvalidLocation : l'emplacement fourni pour cette commande n'est pas valide. (HTTP 500)</td>
        <td>L'infrastructure IBM Cloud (SoftLayer) n'est pas configurée pour commander des ressources de traitement dans le centre de données sélectionné. Contactez le [support {{site.data.keyword.Bluemix_notm}}](#ts_getting_help) pour vérifier que votre compte est configuré correctement.</td>
       </tr>
       <tr>
        <td>Exception liée à l'infrastructure {{site.data.keyword.Bluemix_notm}} : l'utilisateur ne dispose pas des droits sur l'infrastructure {{site.data.keyword.Bluemix_notm}} nécessaires pour ajouter des serveurs
        </br></br>
        Exception liée à l'infrastructure {{site.data.keyword.Bluemix_notm}} : des droits sont nécessaires pour réserver 'Item'.
        </br></br>
        Les données d'identification de l'infrastructure {{site.data.keyword.Bluemix_notm}} n'ont pas pu être validées.</td>
        <td>Vous ne disposez peut-être pas des droits nécessaires pour effectuer cette action dans votre portefeuille d'infrastructure IBM Cloud (SoftLayer) ou vous utilisez des données d'identification d'infrastructure incorrectes. Voir [Configuration de la clé d'API pour activer l'accès au portefeuille de l'infrastructure](/docs/containers?topic=containers-users#api_key).</td>
      </tr>
      <tr>
       <td>Le noeud worker ne parvient pas à communiquer avec les serveurs {{site.data.keyword.containerlong_notm}}. Vérifiez si la configuration de votre pare-feu autorise le trafic à partir de ce noeud worker.
       <td><ul><li>Si vous disposez d'un pare-feu, [configurez les paramètres de votre pare-feu de sorte à autoriser le trafic sortant vers les ports et les adresses IP appropriés](/docs/containers?topic=containers-firewall#firewall_outbound).</li>
       <li>Déterminez si votre cluster n'a pas une adresse IP publique en exécutant la commande `ibmcloud ks workers --cluster &lt;mycluster&gt;`. Si aucune adresse IP publique n'est répertoriée, votre cluster ne dispose que de réseaux locaux virtuels (VLAN) privés.
       <ul><li>Si vous voulez que le cluster ne dispose que de VLAN privés, configurez votre [connexion de réseau local virtuel (VLAN)](/docs/containers?topic=containers-plan_clusters#private_clusters) et votre [pare-feu](/docs/containers?topic=containers-firewall#firewall_outbound).</li>
       <li>Si vous voulez que votre cluster dispose d'une adresse IP publique, [ajoutez de nouveaux noeuds worker](/docs/containers?topic=containers-cs_cli_reference#cs_worker_add) avec à la fois des VLAN publics et privés.</li></ul></li></ul></td>
     </tr>
      <tr>
  <td>Impossible de créer un jeton de portail IMS, car aucun compte IMS n'est lié au compte BSS sélectionné</br></br>Utilisateur indiqué introuvable ou actif</br></br>SoftLayer_Exception_User_Customer_InvalidUserStatus : Le compte utilisateur est actuellement en attente d'annulation (cancel_pending).</br></br>Attente nécessaire pour que la machine soit visible pour l'utilisateur</td>
  <td>Le propriétaire de la clé d'API utilisée pour accéder au portefeuille d'infrastructure IBM Cloud (SoftLayer) ne dispose pas des droits nécessaires pour effectuer l'action ou est peut-être en attente de suppression.</br></br><strong>En tant qu'utilisateur</strong>, procédez comme suit :
  <ol><li>Si vous avez accès à plusieurs comptes, assurez-vous d'être connecté au compte que vous souhaitez utiliser avec {{site.data.keyword.containerlong_notm}}. </li>
  <li>Exécutez la commande <code>ibmcloud ks api-key-info</code> pour afficher le propriétaire de la clé d'API utilisée pour accéder au portefeuille d'infrastructure IBM Cloud (SoftLayer). </li>
  <li>Exécutez la commande <code>ibmcloud account list</code> pour afficher le propriétaire du compte {{site.data.keyword.Bluemix_notm}} que vous utilisez actuellement. </li>
  <li>Contactez le propriétaire du compte {{site.data.keyword.Bluemix_notm}} et signalez que le propriétaire de la clé d'API ne dispose pas des droits requis dans l'infrastructure IBM Cloud (SoftLayer) ou est peut-être en attente de suppression. </li></ol>
  </br><strong>En tant que propriétaire du compte</strong>, procédez comme suit :
  <ol><li>Consultez les [droits requis dans l'infrastructure IBM Cloud (SoftLayer)](/docs/containers?topic=containers-users#infra_access) pour effectuer l'action qui a échoué. </li>
  <li>Définissez les droits du propriétaire de la clé d'API ou créez une nouvelle clé d'API en exécutant la commande [<code>ibmcloud ks api-key-reset</code>](/docs/containers?topic=containers-cs_cli_reference#cs_api_key_reset). </li>
  <li>Si vous ou un autre administrateur de compte avez défini manuellement des données d'identification de l'infrastructure IBM Cloud (SoftLayer) dans votre compte, exécutez la commande [<code>ibmcloud ks credential-unset</code>](/docs/containers?topic=containers-cs_cli_reference#cs_credentials_unset) pour supprimer ces données de votre compte.</li></ol></td>
  </tr>
    </tbody>
  </table>



<br />




## Débogage de déploiements d'application
{: #debug_apps}

Passez en revue les options dont vous disposez pour déboguer vos déploiements d'application et identifier les causes premières des échecs.

Avant de commencer, vérifiez que vous disposez du [rôle de service {{site.data.keyword.Bluemix_notm}} IAM **Auteur** ou **Responsable**](/docs/containers?topic=containers-users#platform) pour l'espace de nom dans lequel est déployée votre application.

1. Recherchez les anomalies dans les ressources de service ou de déploiement en exécutant la commande `describe`.

 Exemple :
 <pre class="pre"><code>kubectl describe service &lt;service_name&gt; </code></pre>

2. [Vérifiez si les conteneurs sont bloqués à l'état `ContainerCreating`](/docs/containers?topic=containers-cs_troubleshoot_storage#stuck_creating_state).

3. Vérifiez si le cluster est à l'état critique (`Critical`). S'il est à l'état `Critical`, consultez les règles de pare-feu et vérifiez que le maître peut communiquer avec les noeuds worker.

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
   3. Exécutez la commande curl sur l'adresse IP et le port du cluster du service. Si l'adresse IP et le port ne sont pas accessibles, examinez les noeuds finaux du service. S'il n'y a aucun noeud final répertorié, le sélecteur du service ne trouve pas de correspondance avec les pods. S'il y a des noeuds finaux répertoriés, examinez la zone du port cible sur le service et assurez-vous que ce port est identique à celui utilisé pour les pods.
     <pre class="pre"><code>curl &lt;cluster_IP&gt;:&lt;port&gt;</code></pre>

6. Pour les services Ingress, vérifiez que le service est accessible depuis le cluster.
   1. Obtenez le nom d'un pod.
     <pre class="pre"><code>kubectl get pods</code></pre>
   2. Connectez-vous à un conteneur.
     <pre class="pre"><code>kubectl exec -it &lt;pod_name&gt; -- /bin/bash</code></pre>
   2. Exécutez la commande curl sur l'URL indiquée pour le service Ingress. Si l'URL n'est pas accessible, recherchez une erreur de pare-feu entre le cluster et le noeud final externe. 
     <pre class="pre"><code>curl &lt;host_name&gt;.&lt;domain&gt;</code></pre>

<br />



## Aide et assistance
{: #ts_getting_help}

Vous avez encore des problèmes avec votre cluster ?
{: shortdesc}

-  Dans le terminal, vous êtes averti des mises à jour disponibles pour l'interface de ligne de commande `ibmcloud` et les plug-ins. Veillez à maintenir votre interface de ligne de commande à jour pour pouvoir utiliser l'ensemble des commandes et des indicateurs.
-   Pour voir si {{site.data.keyword.Bluemix_notm}} est disponible, [vérifiez la page Statut d'{{site.data.keyword.Bluemix_notm}} ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://cloud.ibm.com/status?selected=status).
-   Publiez une question sur le site [{{site.data.keyword.containerlong_notm}} Slack ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://ibm-container-service.slack.com).
    Si vous n'utilisez pas un ID IBM pour votre compte {{site.data.keyword.Bluemix_notm}}, [demandez une invitation](https://bxcs-slack-invite.mybluemix.net/) sur ce site Slack.
    {: tip}
-   Consultez les forums pour établir si d'autres utilisateurs ont rencontré le même problème. Lorsque vous utilisez les forums pour poser une question, balisez votre question de sorte que les équipes de développement {{site.data.keyword.Bluemix_notm}} la voient.
    -   Si vous avez des questions d'ordre technique sur le développement ou le déploiement de clusters ou d'applications à l'aide d'{{site.data.keyword.containerlong_notm}}, publiez-les sur le site [Stack Overflow ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://stackoverflow.com/questions/tagged/ibm-cloud+containers) en leur adjoignant les balises `ibm-cloud`, `kubernetes` et `containers`.
    -   Pour toute question sur le service et les instructions de mise en route, utilisez le forum [IBM Developer Answers ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://developer.ibm.com/answers/topics/containers/?smartspace=bluemix). Incluez les balises `ibm-cloud` et `containers`.
    Voir [Comment obtenir de l'aide](/docs/get-support?topic=get-support-getting-customer-support#using-avatar) pour plus d'informations sur l'utilisation des forums.
-   Contactez le support IBM en ouvrant un cas. Pour savoir comment ouvrir un cas de support IBM ou obtenir les niveaux de support et la gravité des cas, voir [Contacter le support](/docs/get-support?topic=get-support-getting-customer-support#getting-customer-support).
Lorsque vous signalez un problème, incluez l'ID de votre cluster. Pour identifier l'ID du cluster, exécutez la commande `ibmcloud ks clusters`. Vous pouvez également utiliser l'[outil de débogage et de diagnostic d'{{site.data.keyword.containerlong_notm}}](/docs/containers?topic=containers-cs_troubleshoot#debug_utility) pour regrouper et exporter des informations pertinentes de votre cluster à partager avec le support IBM.
{: tip}

