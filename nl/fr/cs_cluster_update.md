---

copyright:
  years: 2014, 2018
lastupdated: "2018-02-02"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Mise à jour des clusters et des noeuds worker
{: #update}

## Mise à jour du maître Kubernetes
{: #master}

Kubernetes publie périodiquement des mises à jour. Il peut s'agir d'une [mise à jour majeure, mineure, ou d'un correctif](cs_versions.html#version_types). Selon le type de mise à jour, la mise à jour de votre maître Kubernetes peut vous incomber. Vous êtes toujours responsable de l'application des mises à jour à vos noeuds worker. Lors de l'application de mises à jour, le maître Kubernetes est actualisé avant vos noeuds worker.
{:shortdesc}

Par défaut, vous ne pouvez mettre à jour votre maître Kubernetes que vers les deux versions mineures suivantes après votre version actuelle. Par exemple, si votre maître actuel est de la version 1.5 et que vous désirez le mettre à jour vers la version 1.8, vous devez tout d'abord le mettre à jour vers la version 1.7. Vous pouvez forcer la mise à jour au delà de deux versions mineures, mais ceci peut entraîner des résultats inattendus.

Le diagramme suivant illustre la procédure que vous pourriez suivre pour mettre à jour votre maître.

![Procédure recommandée pour mise à jour du maître](/images/update-tree.png)

Figure 1. Diagramme de la procédure de mise à jour du maître Kubernetes

**Attention** : Vous ne pouvez pas revenir à une version antérieure du cluster une fois réalisée la procédure de mise à jour. Prenez soin d'utiliser un cluster de test et de suivre les instructions afin d'éviter des problèmes potentiels avant de mettre à jour votre maître de production.

Pour des mises à jour _majeures_ ou _mineures_, procédez comme suit :

1. Passez en revue les [modifications Kubernetes](cs_versions.html) et effectuez les mises à jour marquées _Mise à jour avant le maître_.
2. Mettez à jour le maître Kubernetes à l'aide de l'interface graphique ou en exécutant la [commande CLI](cs_cli_reference.html#cs_cluster_update). Lorsque vous le mettez à jour, le maître Kubernetes est indisponible pendant 5 à 10 minutes. Pendant la mise à jour, vous ne pouvez ni accéder au cluster, ni le modifier. En revanche, les noeuds d'agent, les applications et les ressources que les utilisateurs du cluster ont déployés ne sont pas modifiés et poursuivent leur exécution.
3. Confirmez que la mise à jour est terminée. Vérifiez la version Kubernetes dans le tableau de bord {{site.data.keyword.Bluemix_notm}} ou exécutez la commande `bx cs clusters`.

Une fois la mise à jour du maître Kubernetes terminée, vous pouvez mettre à jour vos noeuds d'agent.

<br />


## Mise à jour des noeuds d'agent
{: #worker_node}

Vous avez donc reçu une notification pour mettre à jour vos noeuds worker. Qu'est-ce que cela signifie ? Vos données sont hébergées dans les pods de vos noeuds worker. Au fur et à mesure que des mises à jour et des correctifs sont installés pour le maître Kubernetes, vous devez vous assurer que vos noeuds worker restent synchronisés. Le maître du noeud worker ne peut pas être à un niveau plus élevé que le maître Kubernetes.
{: shortdesc}

<ul>**Attention** :</br>
<li>Les mises à jour des noeuds worker peuvent entraîner des temps d'indisponibilité de vos applications et services.</li>
<li>Des données sont supprimées si elles ne sont pas stockées hors du pod.</li>
<li>Utilisez des [répliques ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#replicas) dans vos déploiements pour replanifier des pods sur les noeuds disponibles.</li></ul>

Que faire si je ne dispose pas de temps d'indisponibilité ?

Dans le cadre de la procédure de mise à jour, des noeuds spécifiques deviendront indisponibles pendant un certain temps. En vue d'éviter des temps d'indisponibilité de votre application, vous pouvez définir des clés uniques dans une mappe de configuration qui spécifie des pourcentages de seuil pour des types de noeud spécifiques lors de la procédure de mise à jour. En définissant des règles basées sur des labels Kubernetes standard et en attribuant un pourcentage en nombre maximal de noeuds pouvant être indisponibles, vous pouvez vous assurer que votre application demeure opérationnelle. Un noeud est considéré être indisponible s'il doit encore effectuer la procédure de mise à jour.

Comment sont définies les clés ?

Dans la section des informations sur les données de la mappe de configuration, vous pouvez définir jusqu'à 10 règles distinctes en vigueur simultanément. Pour pouvoir être mis à niveau, les noeuds worker doivent satisfaire chaque règle définie.

Les clés ont été définies. Que faire maintenant ?

Après avoir défini vos règles, exécutez la commande `worker-upgrade`. Si une réponse positive est renvoyée, les noeuds worker sont placés en file d'attente pour leur mise à niveau. Cependant, la procédure de mise à jour des noeuds n'est pas engagée tant que toutes les règles ne sont pas satisfaites. Une fois les noeuds placés en file d'attente, les règles sont vérifiées périodiquement pour déterminer si l'un des noeuds peut être mis à niveau.

Que se passe-t-il si je choisis de ne pas définir de mappe de configuration ?

Si aucune mappe de configuration n'est définie, celle par défaut est utilisée. Par défaut, 20 % au maximum de vos noeuds worker sont indisponibles au cours de la procédure de mise à jour.

Pour mettre à jour vos noeuds worker, procédez comme suit :

1. Installez la version de l'[`interface de ligne de commande kubectl` ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/tasks/tools/install-kubectl/) correspondant à la version Kubernetes du maître Kubernetes.

2. Apportez toutes les modifications indiquées par _Mise à jour après le maître_ dans [Modifications Kubernetes](cs_versions.html).

3. Facultatif : Définissez votre mappe de configuration.
    Exemple :

    ```
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: ibm-cluster-update-configuration
      namespace: kube-system
    data:
     zonecheck.json: |
       {
         "MaxUnavailablePercentage": 70,
         "NodeSelectorKey": "failure-domain.beta.kubernetes.io/zone",
         "NodeSelectorValue": "dal13"
       }
     regioncheck.json: |
       {
         "MaxUnavailablePercentage": 80,
         "NodeSelectorKey": "failure-domain.beta.kubernetes.io/region",
         "NodeSelectorValue": "us-south"
       }
    ...
     defaultcheck.json: |
       {
         "MaxUnavailablePercentage": 100
       }
    ```
    {:pre}
  <table summary="La première ligne du tableau couvre les deux colonnes. Le reste des lignes doit être lu de gauche à droite, le paramètre figurant dans la première colonne et les descriptions correspondantes dans la seconde colonne.">
    <thead>
      <th colspan=2><img src="images/idea.png"/> Description des composants </th>
    </thead>
    <tbody>
      <tr>
        <td><code>defaultcheck.json</code></td>
        <td> Par défaut, si une mappe de configuration ibm-cluster-update-configuration valide n'est pas définie, seuls 20 % de vos clusters peuvent être indisponibles à un moment donné. Si une ou plusieurs règles valides sont définies sans mappe de configuration globale par défaut celle utilisée par défaut autorise 100 % des noeuds worker à être indisponibles à un moment donné. Vous pouvez contrôler ce comportement en créant un pourcentage par défaut. </td>
      </tr>
      <tr>
        <td><code>zonecheck.json</code></br><code>regioncheck.json</code></td>
        <td> Exemple de clés uniques pour lesquelles vous désirez définir des règles. Vous pouvez nommer les clés à votre gré ; les informations sont analysées par les configurations définies dans la clé. Pour chaque clé que vous définissez, vous ne pouvez affecter qu'une seule valeur à <code>NodeSelectorKey</code> et <code>NodeSelectorValue</code>. Si vous désirez définir des règles pour plusieurs régions ou emplacements (centres de données), créez une nouvelle entrée de clé. </td>
      </tr>
      <tr>
        <td><code>MaxUnavailablePercentage</code></td>
        <td> Nombre maximal de noeuds autorisés à être indisponibles pour la clé spécifiée, sous forme de pourcentage. Un noeud est indisponible lorsqu'il est en cours de déploiement, de rechargement ou de provisionnement. La mise à jour des noeuds worker placés en file d'attente est bloquée si les pourcentages maximum définis pour les noeuds indisponibles sont dépassés. </td>
      </tr>
      <tr>
        <td><code>NodeSelectorKey</code></td>
        <td> Type de label pour lequel vous désirez définir une règle pour la clé spécifiée. Vous pouvez définir des règles pour les labels par défaut fournis par IBM, tout comme pour ceux que vous créez. </td>
      </tr>
      <tr>
        <td><code>NodeSelectorValue</code></td>
        <td> Sous-ensemble de noeuds dans la clé spécifiée que la règle doit évaluer. </td>
      </tr>
    </tbody>
  </table>

    **Remarque **: Vous pouvez définir 10 règles au maximum. Si vous ajoutez plus de 10 clés à un fichier, seul un sous-ensemble des informations est analysé.

3. Mettez à jour vos noeuds worker depuis l'interface graphique ou la ligne de commande (CLI).
  * Pour effectuer la mise à jour à partir du tableau de bord {{site.data.keyword.Bluemix_notm}}, accédez à la section `Worker nodes` de votre cluster, et cliquez sur `Update Worker`.
  * Pour obtenir les ID des noeuds d'agent, exécutez la commande `bx cs workers <cluster_name_or_id>`. Si vous sélectionnez plusieurs noeuds worker, ceux-ci sont placés en file d'attente pour évaluation de la mise à jour. S'ils sont considérés comme prêts au terme de l'évaluation, ils seront mis à jour d'après les règles définies dans les configurations.

    ```
    bx cs worker-update <cluster_name_or_id> <worker_node_id1> <worker_node_id2>
    ```
    {: pre}

4. Facultatif : Vérifiez les événements déclenchés par la mappe de configuration et les éventuelles erreurs de validation en exécutant la commande suivante et en examinant la zone **Events**.
    ```
    kubectl describe -n kube-system cm ibm-cluster-update-configuration
    ```
    {: pre}

5. Confirmez que la mise à jour est terminée :
  * Vérifiez la version Kubernetes dans le tableau de bord {{site.data.keyword.Bluemix_notm}} ou exécutez la commande `bx cs workers <cluster_name_or_id>`.
  * Vérifiez la version Kubernets des noeuds d'agent en exécutant la commande `kubectl get nodes`.
  * Dans certains cas, des clusters plus anciens peuvent répertorier des noeuds d'agent en double avec un statut **NotReady** après une mise à jour. Pour supprimer ces doublons, voir la section de [traitement des incidents](cs_troubleshoot.html#cs_duplicate_nodes).

Etapes suivantes :
  - Répétez le processus de mise à jour pour les autres clusters.
  - Informez les développeurs qui travaillent dans le cluster pour qu'ils mettent à jour leur interface de ligne de commande `kubectl` à la version du maître Kubernetes.
  - Si le tableau de bord Kubernetes n'affiche pas les graphiques d'utilisation, [supprimez le pod `kube-dashboard`](cs_troubleshoot.html#cs_dashboard_graphs).
<br />

