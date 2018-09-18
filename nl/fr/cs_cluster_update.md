---

copyright:
  years: 2014, 2018
lastupdated: "2018-08-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}





# Mises à jour des clusters, des noeuds worker et des modules complémentaires
{: #update}

Vous pouvez installer des mises à jour pour maintenir vos clusters Kubernetes à jour dans {{site.data.keyword.containerlong}}.
{:shortdesc}

## Mise à jour du maître Kubernetes
{: #master}

Régulièrement, Kubernetes publie des [mises à jour principales, secondaires ou des correctifs](cs_versions.html#version_types). Les mises à jour peuvent affecter la version du serveur d'API Kubernetes ou d'autres composants dans le maître Kubernetes. IBM met à jour la version de correctif, mais vous devez mettre à jour les versions principales et secondaires.
{:shortdesc}

**Comment savoir à quel moment effectuer la mise à jour du maître ?**</br>
Dès que des mises à jour sont disponibles, vous recevez une notification dans l'interface graphique ou l'interface de ligne de commande, et vous pouvez également consulter la page des [versions prises en charge](cs_versions.html).

**Combien de versions peut avoir le maître derrière la version la plus récente ?**</br>
En principe, IBM prend en charge 3 versions de Kubernetes à un moment donné. Vous ne pouvez pas mettre à jour le serveur d'API Kubernetes à une version deux fois supérieure à sa version actuelle.

Par exemple, si la version actuelle de votre serveur d'API Kubernetes est 1.7 et que vous voulez le mettre à jour à la version 1.10, vous devez d'abord effectuer une mise à jour vers la version 1.8 ou 1.9. Vous pouvez forcer la mise à jour, mais au-delà de trois versions secondaires, une mise à jour peut entraîner des échecs ou des résultats inattendus. 

Si votre cluster s'exécute sur une version non prise en charge de Kubernetes, il vous faudra peut-être forcer la mise à jour. Par conséquent, maintenez votre cluster à jour pour éviter des répercussions opérationnelles.

**Mes noeuds worker peuvent-ils s'exécuter avec une version ultérieure à celle du maître ?**</br>
Non. Commencez par [mettre à jour le maître](#update_master) à la version de Kubernetes la plus récente. Ensuite, [mettez à jour les noeuds worker](#worker_node) dans votre cluster. Contrairement au maître, vous devez également mettre à jour vos noeuds worker pour chaque version de module de correction.

**Que se passe-t-il lors de la mise à jour du maître ?**</br>
Lorsque vous mettez à jour le serveur d'API Kubernetes, il est indisponible durant 5 à 10 minutes environ. Pendant la mise à jour, vous ne pouvez ni accéder au cluster, ni le modifier. En revanche, les noeuds worker, les applications et les ressources que les utilisateurs du cluster ont déployés ne sont pas modifiés et poursuivent leur exécution.

**Puis-je annuler la mise à jour effectuée ?**</br>
Non, vous ne pouvez pas restaurer la version antérieure d'un cluster une fois le processus de mise à jour enclenché. Prenez soin d'utiliser un cluster de test et de suivre les instructions afin d'éviter des problèmes potentiels avant de mettre à jour votre maître en production.

**Quelle procédure dois-je suivre pour la mise à jour du maître ?**</br>
Le diagramme suivant illustre la procédure que vous pouvez suivre pour mettre à jour le maître.

![Procédure recommandée pour la mise à jour du maître](/images/update-tree.png)

Figure 1. Diagramme de la procédure de mise à jour du maître Kubernetes

{: #update_master}
Pour mettre à jour la version _principale_ ou _secondaire_ du maître Kubernetes :

1.  Passez en revue les [modifications de Kubernetes](cs_versions.html) et effectuez les mises à jour marquées _Mise à jour avant le maître_.

2.  Mettez à jour le serveur d'API Kubernetes et les composants associés du maître Kubernetes en utilisant l'interface graphique ou en exécutant la [commande](cs_cli_reference.html#cs_cluster_update) `ibmcloud ks cluster-update` de l'interface CLI.

3.  Patientez quelques minutes, puis confirmez que la mise à jour est terminée. Examinez la version du serveur d'API Kubernetes sur le tableau de bord {{site.data.keyword.Bluemix_notm}} ou exécutez la commande `ibmcloud ks clusters`.

4.  Installez la version de l'interface CLI [`kubectl cli`](cs_cli_install.html#kubectl) qui correspond à la version du serveur d'API qui s'exécute sur le maître Kubernetes.

Lorsque la mise à jour du serveur d'API Kubernetes est terminée, vous pouvez mettre à jour vos noeuds worker.

<br />


## Mise à jour des noeuds worker
{: #worker_node}

Vous avez reçu une notification vous invitant à mettre à jour vos noeuds worker. Qu'est-ce que cela signifie ? Comme les mises à jour de sécurité et les correctifs sont mis en place pour le serveur d'API Kubernetes et d'autres composants du maître Kubernetes, vous devez vérifier que les noeuds worker soient toujours synchronisés.
{: shortdesc}

Avant de commencer :
- [Ciblez votre interface de ligne de commande](cs_cli_install.html#cs_cli_configure) sur votre cluster.
- [Mettez à jour le maître Kubernetes](#master). La version Kubernetes du noeud worker ne peut pas être supérieure à celle du serveur d'API Kubernetes qui s'exécute sur votre maître Kubernetes.
- Apportez toutes les modifications indiquées dans _Mise à jour après le maître_ sur la page des [modifications de Kubernetes](cs_versions.html).
- Pour appliquer une mise à jour de module de correction, consultez les [journaux de modifications de version Kubernetes](cs_versions_changelog.html#changelog). </br>

**Attention** : les mises à jour des noeuds worker peuvent provoquer l'indisponibilité de vos services et applications. Les données sont supprimées si elles ne sont pas [stockées hors du pool](cs_storage_planning.html#persistent).


**Qu'advient-il de mes applications au cours d'une mise à jour ?**</br>
Si vous exécutez des applications dans le cadre d'un déploiement sur des noeuds worker faisant l'objet d'une mise à jour, les applications sont replanifiées sur d'autres noeuds worker dans le cluster. Ces noeuds worker peuvent se trouver dans des pools de noeuds worker différents ou, si vous disposez de noeuds worker autonomes, les applications peuvent être planifiées sur ces noeuds. Pour éviter toute interruption d'application, vous devez veiller à ce que le cluster dispose d'une capacité suffisante pour traiter la charge de travail.

**Comment contrôler le nombre de noeuds worker indisponibles à moment donné durant la mise à jour ?**
Si vous avez besoin que tous vos noeuds worker soient opérationnels, envisagez de [redimensionner votre pool de noeuds worker](cs_cli_reference.html#cs_worker_pool_resize) ou d'[ajouter des noeuds worker autonomes](cs_cli_reference.html#cs_worker_add) pour ajouter des noeuds worker supplémentaires. Vous pourrez supprimer ces noeuds supplémentaires une fois la mise à jour terminée.

De plus, vous pouvez créer une mappe de configuration (ConfigMap) Kubernetes qui indique le nombre maximal de noeuds worker pouvant être indisponibles à moment donné pendant la mise à jour. Les noeuds worker sont identifiés par leur libellé. Vous pouvez utiliser les libellés fournis par IBM ou des libellés personnalisés que vous avez ajouté au noeud worker.

**Et si je n'envisage pas de définir une mappe de configuration ?**</br>
Lorsque la mappe de configuration n'est pas définie, la valeur par défaut est utilisée. Par défaut, il peut y avoir au maximum 20% de noeuds worker indisponibles dans chaque cluster pendant le processus de mise à jour.

Pour créer une mappe de configuration et mettre à jour des noeuds worker :

1.  Affichez la liste des noeuds worker disponibles et notez leur adresse IP privée.

    ```
    ibmcloud ks workers <cluster_name_or_ID>
    ```
    {: pre}

2. Affichez les libellés d'un noeud worker. Vous pouvez identifier les libellés des noeuds worker dans la section **Labels** de la sortie de l'interface CLI. Chaque libellé est constitué de deux éléments `NodeSelectorKey` et `NodeSelectorValue`.
   ```
   kubectl describe node <private_worker_IP>
   ```
   {: pre}

   Exemple de sortie :
   ```
   Name:               10.184.58.3
   Roles:              <none>
   Labels:             arch=amd64
                    beta.kubernetes.io/arch=amd64
                    beta.kubernetes.io/os=linux
                    failure-domain.beta.kubernetes.io/region=us-south
                    failure-domain.beta.kubernetes.io/zone=dal12
                    ibm-cloud.kubernetes.io/encrypted-docker-data=true
                    ibm-cloud.kubernetes.io/iaas-provider=softlayer
                    ibm-cloud.kubernetes.io/machine-type=u2c.2x4.encrypted
                    kubernetes.io/hostname=10.123.45.3
                    privateVLAN=2299001
                    publicVLAN=2299012
   Annotations:        node.alpha.kubernetes.io/ttl=0
                    volumes.kubernetes.io/controller-managed-attach-detach=true
   CreationTimestamp:  Tue, 03 Apr 2018 15:26:17 -0400
   Taints:             <none>
   Unschedulable:      false
   ```
   {: screen}

3. Créez une mappe de configuration et définissez les règles d'indisponibilité applicables à vos noeuds worker. L'exemple suivant présente 4 vérifications : `zonecheck.json`, `regioncheck.json`, `defaultcheck.json` et un modèle de vérification. Vous pouvez utiliser ces exemples de vérification pour définir les règles de vos noeuds worker dans une zone spécifique (`zonecheck.json`), une région (`regioncheck.json`) ou pour tous les noeuds worker qui ne correspondent à aucune des vérifications que vous avez définies dans la mappe de configuration (`defaultcheck.json`). Utilisez le modèle de vérification pour créer votre propre vérification. Pour chaque vérification, vous devez choisir un des libellés de noeud worker obtenus à l'étape précédente pour identifier un noeud worker.  

   **Remarque :** pour chaque vérification, vous ne pouvez définir qu'une seule valeur pour <code>NodeSelectorKey</code> et <code>NodeSelectorValue</code>. Si vous souhaitez définir des règles pour plusieurs régions, zones ou d''autres libellés de noeud worker, créez une nouvelle vérification. Vous pouvez définir jusqu'à 10 vérifications dans une mappe de configuration. Si vous ajoutez d'autres vérifications, elles sont ignorées.

   Exemple :
   ```
   apiVersion: v1
    kind: ConfigMap
    metadata:
      name: ibm-cluster-update-configuration
      namespace: kube-system
    data:
     drain_timeout_seconds: "120"
     zonecheck.json: |
       {
        "MaxUnavailablePercentage": 30,
        "NodeSelectorKey": "failure-domain.beta.kubernetes.io/zone",
        "NodeSelectorValue": "dal13"
      }
    regioncheck.json: |
       {
        "MaxUnavailablePercentage": 20,
        "NodeSelectorKey": "failure-domain.beta.kubernetes.io/region",
        "NodeSelectorValue": "us-south"
      }
    defaultcheck.json: |
       {
        "MaxUnavailablePercentage": 20
      }
    <check_name>: |
      {
        "MaxUnavailablePercentage": <value_in_percentage>,
        "NodeSelectorKey": "<node_selector_key>",
        "NodeSelectorValue": "<node_selector_value>"
      }
   ```
   {:pre}

   <table summary="La première ligne du tableau est répartie sur deux colonnes. La lecture des autres lignes s'effectue de gauche à droite, le paramètre figurant dans la première colonne et les descriptions correspondantes dans la deuxième colonne.">
   <caption>Composants de ConfigMap</caption>
    <thead>
      <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants </th>
    </thead>
    <tbody>
      <tr>
        <td><code>drain_timeout_seconds</code></td>
        <td> Facultatif : délai d'attente en seconde nécessaire à l'exécution de l'opération [drain ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/tasks/administer-cluster/safely-drain-node/). L'arrêt avec drain d'un noeud worker en toute sécurité supprime tous les pods existants du noeuds worker et replanifie les pods sur d'autres noeuds worker du cluster. Les valeurs admises sont des entiers compris entre 1 et 180. La valeur par défaut est 30.</td>
      </tr>
      <tr>
        <td><code>zonecheck.json</code></br><code>regioncheck.json</code></td>
        <td>Deux vérifications utilisées pour définir une règle pour un ensemble de noeuds worker que vous pouvez identifier à l'aide des éléments <code>NodeSelectorKey</code> et <code>NodeSelectorValue</code>. La vérification <code>zonecheck.json</code> identifie les noeuds worker en fonction du libellé de leur zone et la vérification <code>regioncheck.json</code> utilise le libellé de la région ajouté à chaque noeud worker lors de la mise à disposition. Dans l'exemple, 30% de tous les noeuds worker ayant <code>dal13</code> comme libellé de zone et 20% de tous les noeuds worker dans la région du Sud des Etats-Unis (<code>us-south</code>) peuvent être indisponibles lors de la mise à jour.</td>
      </tr>
      <tr>
        <td><code>defaultcheck.json</code></td>
        <td>Si vous ne créez pas de mappe de configuration ou si la mappe n'est pas configurée correctement, la valeur par défaut de Kubernetes est appliquée. Par défaut, uniquement 20% des noeuds worker du cluster peuvent être indisponibles à moment donné. Vous pouvez remplacer la valeur par défaut en ajoutant la vérification par défaut dans votre mappe de configuration. Dans cet exemple, tous les noeuds worker qui ne sont pas indiqués dans les vérifications de zone et de région (<code>dal13</code> ou <code>us-south</code>) peuvent être indisponibles lors de la mise à jour. </td>
      </tr>
      <tr>
        <td><code>MaxUnavailablePercentage</code></td>
        <td>Quantité maximale de noeuds pouvant être indisponibles pour un libellé clé-valeur spécifique, exprimée en pourcentage. Un noeud worker est indisponible lorsqu'il est en cours de déploiement, de rechargement ou de mise à disposition. Les noeuds worker en file d'attente sont bloqués pour la mise à jour s'ils dépassent un pourcentage maximum de noeuds indisponibles défini.</td>
      </tr>
      <tr>
        <td><code>NodeSelectorKey</code></td>
        <td>Clé de libellé du noeud worker pour lequel vous voulez définir une règle. Vous pouvez définir des règles pour les libellés par défaut fournis par IBM, ainsi que sur les libellés de noeuds worker que vous avez créés. <ul><li>Si vous souhaitez ajouter une règle pour les noeuds worker appartenant à un pool de noeuds worker, vous pouvez utiliser le libellé <code>ibm-cloud.kubernetes.io/machine-type</code>. </li><li> Si vous disposez de plusieurs pools de noeuds worker avec le même type de machine, utilisez un libellé personnalisé. </li></ul></td>
      </tr>
      <tr>
        <td><code>NodeSelectorValue</code></td>
        <td>Valeur de libellé que doit avoir le noeud worker pour être pris en compte dans la règle que vous définissez. </td>
      </tr>
    </tbody>
   </table>

4. Créez la mappe de configuration dans votre cluster.
   ```
   kubectl apply -f <filepath/configmap.yaml>
   ```
   {: pre}

5. Vérifiez que la mappe de configuration est créée.
   ```
   kubectl get configmap --namespace kube-system
   ```
   {: pre}

6.  Mettez à jour les noeuds worker.

    ```
    ibmcloud ks worker-update <cluster_name_or_ID> <worker_node1_ID> <worker_node2_ID>
    ```
    {: pre}

7. Facultatif : vérifiez les événements déclenchés par la mappe de configuration et les éventuelles erreurs de validation. Les événements peuvent être consultés dans la section **Events** de la sortie de l'interface CLI.
   ```
   kubectl describe -n kube-system cm ibm-cluster-update-configuration
   ```
   {: pre}

8. Confirmez que la mise à jour est terminée en examinant la version Kubernetes de vos noeuds worker.  
   ```
   kubectl get nodes
   ```
   {: pre}

9. Vérifiez que vous n'avez pas de noeuds worker en double. Dans certains cas, des clusters plus anciens peuvent répertorier des noeuds worker en double avec un statut **NotReady** après une mise à jour. Pour supprimer ces doublons, voir la section de [traitement des incidents](cs_troubleshoot_clusters.html#cs_duplicate_nodes).

Etapes suivantes :
  - Répétez le processus de mise à jour pour les autres pools de noeuds worker.
  - Informez les développeurs qui travaillent dans le cluster pour qu'ils mettent à jour leur interface de ligne de commande `kubectl` à la version du maître Kubernetes.
  - Si le tableau de bord Kubernetes n'affiche pas les graphiques d'utilisation, [supprimez le pod `kube-dashboard`](cs_troubleshoot_health.html#cs_dashboard_graphs).

<br />



## Mise à jour des types de machine
{: #machine_type}

Vous pouvez mettre à jour les types de machine de vos noeuds worker en ajoutant de nouveaux noeuds worker et en supprimant les anciens. Par exemple, si vous disposez de noeuds worker sur des types de machine dépréciés comportant `u1c` ou `b1c` dans le nom, créez des noeuds worker ayant `u2c` ou `b2c` dans le nom.
{: shortdesc}

Avant de commencer :
- [Ciblez votre interface de ligne de commande](cs_cli_install.html#cs_cli_configure) sur votre cluster.
- Si vous stockez des données sur votre noeud worker, les données sont supprimées si elles ne sont pas [stockées hors du noeud worker](cs_storage_planning.html#persistent).


**Attention** : les mises à jour des noeuds worker peuvent provoquer l'indisponibilité de vos services et applications. Les données sont supprimées si elles ne sont pas [stockées hors du pool](cs_storage_planning.html#persistent).

1. Affichez la liste des noeuds worker disponibles et notez leur adresse IP privée.
   - **Pour les noeuds worker figurant dans un pool de noeuds worker** :
     1. Affichez la liste des pools de noeuds worker disponibles dans votre cluster.
        ```
        ibmcloud ks worker-pools --cluster <cluster_name_or_ID>
        ```
        {: pre}

     2. Affichez la liste des noeuds worker figurant dans le pool de noeuds worker.
        ```
        ibmcloud ks workers <cluster_name_or_ID> --worker-pool <pool_name>
        ```
        {: pre}

     3. Obtenez les détails d'un noeud worker et notez la zone, ainsi que l'ID du VLAN privé et du VLAN public.
        ```
        ibmcloud ks worker-get <cluster_name_or_ID> <worker_ID>
        ```
        {: pre}

   - **Déprécié : pour les noeuds worker autonomes** :
     1. Affichez la liste des noeuds worker disponibles.
        ```
        ibmcloud ks workers <cluster_name_or_ID>
        ```
        {: pre}

     2. Obtenez les détails d'un noeud worker et notez la zone, ainsi que l'ID du VLAN privé et du VLAN public.
        ```
        ibmcloud ks worker-get <cluster_name_or_ID> <worker_ID>
        ```
        {: pre}

2. Affichez la liste des types de machine disponibles dans la zone.
   ```
   ibmcloud ks machine-types <zone>
   ```
   {: pre}

3. Créez un noeud worker avec le nouveau type de machine.
   - **Pour les noeuds worker figurant dans un pool de noeuds worker** :
     1. Créez un pool de noeuds worker avec le nombre de noeuds worker que vous désirez remplacer.
        ```
        ibmcloud ks worker-pool-create --name <pool_name> --cluster <cluster_name_or_ID> --machine-type <machine_type> --size-per-zone <number_of_workers_per_zone>
        ```
        {: pre}

     2. Vérifiez que le pool de noeuds worker est créé.
        ```
        ibmcloud ks worker-pools --cluster <cluster_name_or_ID>
        ```
        {: pre}

     3. Ajoutez la zone de votre pool de noeuds worker que vous avez récupérée auparavant. Lorsque vous ajoutez une zone, les noeuds worker définis dans votre pool de noeuds worker sont mis à disposition dans cette zone et pris en compte pour la planification des charges de travail à venir. Si vous souhaitez répartir vos noeuds worker sur plusieurs zones, sélectionnez une [zone compatible avec plusieurs zones](cs_regions.html#zones).
        ```
        ibmcloud ks zone-add --zone <zone> --cluster <cluster_name_or_ID> --worker-pools <pool_name> --private-vlan <private_VLAN_ID> --public-vlan <public_VLAN_ID>
        ```
        {: pre}

   - **Déprécié : pour les noeuds worker autonomes** :
       ```
       ibmcloud ks worker-add --cluster <cluster_name> --machine-type <machine_type> --number <number_of_worker_nodes> --private-vlan <private_VLAN_ID> --public-vlan <public_VLAN_ID>
       ```
       {: pre}

4. Patientez jusqu'à la fin du déploiement des noeuds worker.
   ```
   ibmcloud ks workers <cluster_name_or_ID>
   ```
   {: pre}

   Lorsque l'état des noeuds worker passe à **Normal**, le déploiement est terminé.

5. Supprimez l'ancien noeud worker. **Remarque** : si vous supprimez un type de machine qui est facturé au mois (par exemple bare metal), vous êtes facturé pour le mois complet.
   - **Pour les noeuds worker figurant dans un pool de noeuds worker** :
     1. Supprimez le pool de noeuds worker associé à l'ancien type de machine. Cette opération supprime tous les noeuds worker qui se trouvent dans le pool dans toutes les zones. L'exécution de ce processus peut prendre quelques minutes.
        ```
        ibmcloud ks worker-pool-rm --worker-pool <pool_name> --cluster <cluster_name_or_ID>
        ```
        {: pre}

     2. Vérifiez que le pool de noeuds worker est supprimé.
        ```
        ibmcloud ks worker-pools --cluster <cluster_name_or_ID>
        ```
        {: pre}

   - **Déprécié : pour les noeuds worker autonomes** :
      ```
      ibmcloud ks worker-rm <cluster_name> <worker_node>
      ```
      {: pre}

6. Vérifiez que les noeuds worker ont été supprimés de votre cluster.
   ```
   ibmcloud ks workers <cluster_name_or_ID>
   ```
   {: pre}

7. Répétez ces étapes pour mettre à jour d'autres pools de noeuds worker ou d'autres noeuds worker autonomes sur différents types de machine.

## Mise à jour de modules complémentaires de cluster
{: #addons}

Votre cluster {{site.data.keyword.containershort_notm}} est livré avec des **modules complémentaires**, par exemple Fluentd utilisé pour la consignation. Ces modules s'installent automatiquement lorsque vous mettez à disposition le cluster. Ils peuvent être mis à jour séparément du maître et des noeuds worker.
{: shortdesc}

**Quels sont les modules complémentaires par défaut que je dois mettre à jour séparément du cluster ?**
* [Fluentd utilisé pour la consignation](#logging)

**Puis-je installer d'autres modules complémentaires que ceux par défaut ?**</br>
Oui. {{site.data.keyword.containershort_notm}} offre d'autres modules complémentaires que vous pouvez sélectionner pour ajouter des fonctionnalités à votre cluster. Par exemple, vous envisagerez peut-être d'[utiliser des chartes Helm](cs_integrations.html#helm) pour installer le [plug-in Block Storage](cs_storage_block.html#install_block), [Istio](cs_tutorials_istio.html#istio_tutorial) ou le [VPN strongSwan](cs_vpn.html#vpn-setup). Vous devez mettre à jour chacun de ces modules séparément en suivant les instructions de mise à jour des chartes Helm.

### Fluentd utilisé pour la consignation
{: #logging}

Pour modifier vos configurations de consignation ou de filtrage, le module Fluentd doit avoir le dernier niveau de version. Par défaut, les mises à jour automatiques sont activées pour ce module.
{: shortdesc}

Vous pouvez vérifier si les mises à jour automatiques sont activées en exécutant la [commande](cs_cli_reference.html#cs_log_autoupdate_get) `ibmcloud ks logging-autoupdate-get --cluster <cluster_name_or_ID>`.

Pour désactiver les mises à jour automatiques, exécutez la [commande](cs_cli_reference.html#cs_log_autoupdate_disable) `ibmcloud ks logging-autoupdate-disable`.

Si les mises à jour automatiques sont désactivées et que vous devez effectuer une modification dans votre configuration, il y a deux options possibles :

*  Activer les mises à jour automatique pour vos pods Fluentd.

    ```
    ibmcloud ks logging-autoupdate-enable --cluster <cluster_name_or_ID>
    ```
    {: pre}

*  Forcer une mise à jour unique lorsque vous utilisez une commande de consignation comportant l'option `--force-update`. **Remarque** : vos pods se mettent à jour à la version la plus récente du module complémentaire Fluentd, mais Fluentd ne se mettra plus à jour automatiquement par la suite.

    Exemple de commande :

    ```
    ibmcloud ks logging-config-update --cluster <cluster_name_or_ID> --id <log_config_ID> --type <log_type> --force-update
    ```
    {: pre}

## Mise à jour pour passer des noeuds worker autonomes aux pools de noeuds worker
{: #standalone_to_workerpool}

Avec l'introduction des clusters à zones multiples, les noeuds worker avec la même configuration, par exemple, le type de machine, sont regroupés en pools. Lorsque vous créez un cluster, un pool de noeuds worker nommé `default` est automatiquement créé pour vous.
{: shortdesc}

Vous pouvez utiliser des pools de noeuds worker pour répartir vos noeuds worker uniformément entre les zones et réaliser un cluster équilibré. Les clusters équilibrés sont encore plus disponibles et offrent moins de défaillances. En cas de suppression d'un noeud worker dans une zone, vous pouvez rééquilibrer le pool de noeuds worker et insérer automatiquement de nouveaux noeuds worker dans cette zone. Les pools de noeuds worker sont également utilisés pour installer des mises à jour de version Kubernetes sur tous vos noeuds worker.  

**Important :** si vous avez créé des clusters avant l'introduction des clusters à zones multiples, vos noeuds worker sont toujours autonomes et ne sont pas automatiquement regroupés dans les pools de noeuds worker. Vous devez mettre à jour ces clusters de sorte à utiliser des pools de noeuds worker. Si vous n'effectuez pas cette mise à jour, vous ne pourrez pas passer d'un cluster à zone unique à un cluster à zones multiples.

Examinez l'image suivante pour voir comment évolue la configuration de votre cluster lorsque vous passez des noeuds worker autonomes aux pools de noeuds worker.

<img src="images/cs_cluster_migrate.png" alt="Mise à jour de votre cluster pour passer des noeuds worker autonomes aux pools de noeuds worker" width="600" style="width:600px; border-style: none"/>

Avant de commencer, [ciblez votre interface de ligne de commande](cs_cli_install.html#cs_cli_configure) sur votre cluster.

1. Affichez la liste des noeuds worker autonomes de votre cluster et notez leur **ID**, **Type de machine** et **Adresse IP privée**.
   ```
   ibmcloud ks workers <cluster_name_or_ID>
   ```
   {: pre}

2. Créez un pool de noeuds worker et déterminez le type de machine et le nombre de noeuds worker que vous souhaitez ajouter dans ce pool.
   ```
   ibmcloud ks worker-pool-create --name <pool_name> --cluster <cluster_name_or_ID> --machine-type <machine_type> --size-per-zone <number_of_workers_per_zone>
   ```
   {: pre}

3. Répertoriez les zones disponibles et choisissez où vous souhaitez déployer les noeuds worker dans votre pool de noeuds worker. Pour afficher la zone dans laquelle se trouvent vos noeuds worker autonomes, exécutez la commande `ibmcloud ks cluster-get <cluster_name_or_ID>`. Si vous souhaitez répartir vos noeuds worker sur plusieurs zones, sélectionnez une [zone compatible avec plusieurs zones](cs_regions.html#zones).
   ```
   ibmcloud ks zones
   ```
   {: pre}

4. Répertoriez les VLAN disponibles pour la zone que vous avez choisie à l'étape précédente. Si vous ne disposez pas encore de VLAN dans cette zone, un VLAN est automatiquement créé pour vous lorsque vous ajoutez la zone dans le pool de noeuds worker.
   ```
   ibmcloud ks vlans <zone>
   ```
   {: pre}

5. Ajoutez la zone dans votre pool de noeuds worker. Lorsque vous ajoutez une zone dans un pool de noeuds worker, les noeuds worker définis dans votre pool de noeuds worker sont mis à disposition dans cette zone et pris en compte pour la planification des charges de travail à venir. {{site.data.keyword.containerlong}} ajoute automatiquement le libellé `failure-domain.beta.kubernetes.io/region` pour la région et le libellé `failure-domain.beta.kubernetes.io/zone` pour la zone à chaque noeud worker. Le planificateur de Kubernetes utilise ces libellés pour répartir les pods sur les zones situées dans la même région.
   1. **Pour ajouter une zone à un pool de noeuds worker** : remplacez `<pool_name>` par le nom de votre pool de noeuds worker et indiquez l'ID de cluster, la zone et les VLAN avec les informations que vous avez récupérées précédemment. Si vous ne disposez pas de VLAN public et privé dans cette zone, n'indiquez pas cette option. Un VLAN privé et un VLAN public sont automatiquement créés pour vous. 

      Si vous souhaitez utiliser des VLAN différents pour des pools de noeuds worker différents, répétez cette commande pour chaque VLAN et les pools de noeuds worker correspondants associés. Les nouveaux noeuds worker sont ajoutés aux VLAN que vous spécifiez, mais les VLAN pour les noeuds worker existants restent inchangés.
   ```
      ibmcloud ks zone-add --zone <zone> --cluster <cluster_name_or_ID> --worker-pools <pool_name> --private-vlan <private_VLAN_ID> --public-vlan <public_VLAN_ID>
      ```
      {: pre}

   2. **Pour ajouter la zone dans plusieurs pools de noeuds worker** : ajoutez plusieurs pools de noeuds worker dans la commande `ibmcloud ks zone-add`. Pour ajouter plusieurs pools de noeuds worker dans une zone, vous devez déjà disposer de VLAN privé et public dans cette zone. Si vous ne disposez pas de VLAN public et privé dans cette zone, envisagez d'ajouter d'abord la zone à un pool de noeuds worker pour qu'un VLAN public et un VLAN privé soient créés pour vous. Ensuite, vous pouvez ajouter cette zone à d'autres pools de noeuds worker.</br></br>Il est important que les noeuds worker de tous vos pools de noeuds worker soient mis à disposition dans toutes les zones pour que votre cluster soit équilibré entre les zones. Si vous souhaitez utiliser des VLAN différents pour des pools de noeuds worker différents, répétez cette commande avec les VLAN que vous souhaitez utiliser pour votre pool de noeuds worker. Pour activer la communication sur le réseau privé entre les noeuds worker situés dans différentes zones, vous devez activer la fonction [Spanning VLAN](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning).
      ```
      ibmcloud ks zone-add --zone <zone> --cluster <cluster_name_or_ID> --worker-pools <pool_name1,pool_name2,pool_name3> --private-vlan <private_VLAN_ID> --public-vlan <public_VLAN_ID>
      ```
      {: pre}

   3. **Pour ajouter plusieurs zones dans vos pools de noeuds worker** : répétez la commande `ibmcloud ks zone-add` avec une zone différente et indiquez les pools de noeuds worker que vous voulez mettre à disposition dans cette zone. En ajoutant des zones supplémentaires dans votre cluster, vous passez d'un cluster à zone unique à un [cluster à zones multiples](cs_clusters.html#multi_zone).

6. Patientez jusqu'à la fin du déploiement des noeuds worker dans chaque zone.
   ```
   ibmcloud ks workers <cluster_name_or_ID>
   ```
   {: pre}
   Lorsque l'état des noeuds worker passe à **Normal**, le déploiement est terminé.

7. Supprimez vos noeuds worker autonomes. Si vous en avez plusieurs, supprimez-les un par un.
   1. Répertoriez les noeuds worker dans votre cluster et comparez l'adresse IP privée de cette commande à l'adresse IP privée que vous avez récupérée au début pour rechercher vos noeuds worker autonomes.
      ```
      kubectl get nodes
      ```
      {: pre}
   2. Marquez le noeud worker comme non planifiable dans un processus désigné par cordon. Lorsque vous exécutez ce processus sur un noeud worker, vous le rendez indisponible pour toute planification de pod ultérieure. Utilisez le nom indiqué dans la section `name` renvoyé dans la commande `kubectl get nodes`.
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
   4. Forcez la suppression des pods de votre noeud worker autonome et leur replanification sur des noeuds worker autonomes restants éligibles pour la création de pods, ainsi que sur les noeuds worker de votre pool de noeuds worker.
      ```
      kubectl drain <worker_name> --ignore-daemonsets
      ```
      {: pre}
      Ce processus peut prendre quelques minutes.

   5. Supprimez votre noeud worker autonome. Utilisez l'ID du noeud worker que vous avez récupéré avec la commande `ibmcloud ks workers <cluster_name_or_ID>`.
      ```
      ibmcloud ks worker-rm <cluster_name_or_ID> <worker_ID>
      ```
      {: pre}
   6. Répétez ces étapes jusqu'à ce que tous vos noeuds worker autonomes soient supprimés.


**Etape suivante ?** </br>
Maintenant que vous avez mis à jour votre cluster pour utiliser des pools de noeuds worker, vous pouvez améliorer la disponibilité en ajoutant d'autres zones dans votre cluster. L'ajout de zones supplémentaires dans votre cluster, vous fait passer d'un cluster à zone unique à un [cluster à zones multiples](cs_clusters.html#ha_clusters). Lorsque vous passez d'un cluster à zone unique à un cluster à zones multiples, votre domaine Ingress `<cluster_name>.<region>.containers.mybluemix.net` devient `<cluster_name>.<region_or_zone>.containers.appdomain.cloud`. Le domaine Ingress existant est toujours valide et peut être utilisé pour envoyer des demandes à vos applications.
