---

copyright:
  years: 2014, 2017
lastupdated: "2017-11-03"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# Versions de Kubernetes pour {{site.data.keyword.containerlong_notm}}
{: #cs_versions}

Passez en revue les versions de Kubernetes disponibles sur {{site.data.keyword.containerlong}}.
{:shortdesc}

{{site.data.keyword.containershort_notm}} prend en charge plusieurs versions de Kubernetes. La version par défaut est utilisée lorsque vous créez ou mettez à jour un cluster, sauf si vous spécifiez une autre version. Les versions disponibles de Kubernetes sont les suivantes :
- 1.8.2
- 1.7.4 (version par défaut)
- 1.5.6

Les informations qui suivent récapitulent les mises à jour susceptibles d'avoir un impact sur les applications déployées lorsque vous mettez à jour un cluster vers une nouvelle version. Consultez le journal [Kubernetes changelog ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG.md) pour obtenir la liste complète des modifications dans les versions de Kubernetes.

Pour plus d'informations sur le processus de mise à jour, voir [Mise à jour des clusters](cs_cluster.html#cs_cluster_update) et [Mise à jour des noeuds d'agent](cs_cluster.html#cs_cluster_worker_update).

## Types de mise à jour
{: #version_types}

Kubernetes fournit les types de mise à jour de version suivants :
{:shortdesc}

|Type de mise à jour|Exemples de libellé de version|Mis à jour par|Impact
|-----|-----|-----|-----|
|Principale|1.x.x|Vous|Modifications d'opérations pour des clusters, y compris scripts ou déploiements.|
|Secondaire|x.5.x|Vous|Modifications d'opérations pour des clusters, y compris scripts ou déploiements.|
|Correctif|x.x.3|IBM et vous|Pas de modifications des scripts ou des déploiements. IBM met automatiquement à jour les maîtres, mais vous appliquez les correctifs à vos noeuds d'agent.|
{: caption="Impacts des mises à jour Kubernetes" caption-side="top"}

Par défaut, vous ne pouvez pas mettre à jour le maître Kubernetes de plus de deux versions mineures. Par exemple, si votre version maître actuelle est la version 1.5 et que vous voulez passer à la version 1.8, vous devez d'abord passer en version 1.7. Vous pouvez forcer la mise à jour pour continuer, mais passer à plus de deux versions au-dessus de la version en cours risque d'entraîner des résultats inattendus.

## Version 1.8
{: #cs_v18}
Passez en revue les modifications éventuellement nécessaires si vous procédez à une mise à jour vers Kubernetes version 1.8.

### Mise à jour avant le maître
{: #18_before}

<table summary="Mises à jour Kubernetes pour les versions 1.8">
<caption>Modifications à effectuer avant mise à jour du maître vers Kubernetes 1.8</caption>
<thead>
<tr>
<th>Type</th>
<th>Description
</tr>
</thead>
<tbody>
<tr>
<td colspan='2'>Aucune modification requise avant mise à jour du maître</td>
</tr>
</tbody>
</table>

### Mise à jour après le maître
{: #18_after}

<table summary="Mises à jour Kubernetes pour les versions 1.8">
<caption>Modifications à effectuer après mise à jour du maître vers Kubernetes 1.8</caption>
<thead>
<tr>
<th>Type</th>
<th>Description
</tr>
</thead>
<tbody>
<tr>
<td>Connexion au tableau de bord Kubernetes</td>
<td>L'URL d'accès au tableau de bord Kubernetes en version 1.8 a changé et le processus de connexion inclut une nouvelle étape d'authentification. Pour plus d'informations, voir [Accès au tableau de bord Kubernetes](cs_apps.html#cs_cli_dashboard).</td>
</tr>
<tr>
<tr>
<td>Droits sur le tableau de bord Kubernetes</td>
<td>Pour forcer des utilisateurs à se connecter avec leurs données d'identification pour afficher des ressources de cluster en version 1.8, supprimez l'autorisation RBAC 1.7 ClusterRoleBinding. Exécutez `kubectl delete clusterrolebinding -n kube-system kubernetes-dashboard`.</td>
</tr>
<tr>
<td>`kubectl delete`</td>
<td>La commande `kubectl delete` ne réduit plus les objets d'API de charge de travail, tels que les pods, avant suppression de l'objet. Si vous avez besoin de réduire l'objet, utilisez la commande [kubectl scale ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/user-guide/kubectl/v1.8/#scale) avant de supprimer l'objet.</td>
</tr>
<tr>
<td>`kubectl run`</td>
<td>La commande `kubectl run` doit utiliser plusieurs indicateurs pour `--env` au lieu d'arguments séparés par une virgule. Par exemple, exécutez `kubectl run --env <x>=<y> --env <z>=<k>` et non `kubectl run --env <x>=<y>,<z>=<k>`.</td>
</tr>
<td>`kubectl stop`</td>
<td>La commande `kubectl stop` n'est plus disponible.</td>
</tr>
</tbody>
</table>


## Version 1.7
{: #cs_v17}

Passez en revue les modifications éventuellement nécessaires si vous procédez à une mise à jour vers Kubernetes version 1.7.

### Mise à jour avant le maître
{: #17_before}

<table summary="Mises à jour de Kubernetes pour les versions 1.7 et 1.6">
<caption>Modifications à effectuer avant mise à jour du maître vers Kubernetes 1.7</caption>
<thead>
<tr>
<th>Type</th>
<th>Description
</tr>
</thead>
<tbody>
<tr>
<td>Stockage</td>
<td>Les scripts de configuration avec les éléments `hostPath` et `mountPath` avec des références de répertoire parent, telles que `../to/dir` ne sont pas autorisés. Remplacez les chemins d'accès par des chemins absolus simples, par exemple, `/path/to/dir`.
<ol>
  <li>Déterminez si vous devez modifier des chemins de stockage :</br>
  ```
  kubectl get pods --all-namespaces -o yaml | grep "\.\." && echo "Action required"
  ```
  </br>

  <li>Si `Action required` est renvoyé, modifiez les pods de manière à référencer le chemin absolu avant de mettre à jour tous vos noeuds d'agent. Si le pod est détenu par une autre ressource, par exemple un déploiement, modifiez [_PodSpec_ ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/api-reference/v1.7/#podspec-v1-core) dans cette ressource.
</ol>
</td>
</tr>
</tbody>
</table>

### Mise à jour après le maître
{: #17_after}

<table summary="Mises à jour de Kubernetes pour les versions 1.7 et 1.6">
<caption>Modifications à effectuer après mise à jour du maître vers Kubernetes 1.7</caption>
<thead>
<tr>
<th>Type</th>
<th>Description
</tr>
</thead>
<tbody>
<tr>
<td>kubectl</td>
<td>Après avoir mis à jour l'interface CLI `kubectl`, ces commandes `kubectl create` doivent utiliser plusieurs indicateurs à la place d'arguments séparés par des virgules :<ul>
 <li>`role`
 <li>`clusterrole`
 <li>`rolebinding`
 <li>`clusterrolebinding`
 <li>`secret`
 </ul>
</br>  Par exemple, exécutez la commande `kubectl create role --resource-name <x> --resource-name <y>` et non pas `kubectl create role --resource-name <x>,<y>`.</td>
</tr>
<tr>
<td>Planification d'affinité de pods</td>
<td> L'annotation `scheduler.alpha.kubernetes.io/affinity` est obsolète.
<ol>
  <li>Pour chaque espace de nom à l'exception d'`ibm-system` et de `kube-system`, déterminez si vous devez mettre à jour la planification d'affinité des pods :</br>
  ```
  kubectl get pods -n <namespace> -o yaml | grep "scheduler.alpha.kubernetes.io/affinity" && echo "Action required"
  ```
  </br>
  <li>Si `"Action required"` es renvoyé, utilisez la zone [_PodSpec_ ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/api-reference/v1.7/#podspec-v1-core) _affinity_ au lieu de l'annotation `scheduler.alpha.kubernetes.io/affinity`.
</ol>
</tr>
<tr>
<td>Règles réseau</td>
<td>L'annotation `net.beta.kubernetes.io/network-policy` n'est plus disponible.
<ol>
  <li>Déterminez si vous devez modifier des règles :</br>
  ```
  kubectl get ns -o yaml | grep "net.beta.kubernetes.io/network-policy" | grep "DefaultDeny" && echo "Action required"
  ```
  <li>Si `"Action required"` est renvoyé, ajoutez la règle réseau suivante à chaque espace de nom Kubernetes répertorié :</br>

  <pre class="codeblock">
  <code>
  kubectl create -n &lt;namespace&gt; -f - &lt;&lt;EOF
  kind: NetworkPolicy
  apiVersion: networking.k8s.io/v1
  metadata:
    name: default-deny
    namespace: &lt;namespace&gt;
  spec:
    podSelector: {}
  EOF
  </code>
  </pre>

  <li> Après avoir ajouté la règle réseau, supprimez l'annotation `net.beta.kubernetes.io/network-policy` :
  ```
  kubectl annotate ns <namespace> --overwrite "net.beta.kubernetes.io/network-policy-"
  ```
  </ol>
</tr>
<tr>
<td>Annotation tolerations</td>
<td>L'annotation `scheduler.alpha.kubernetes.io/tolerations` n'est plus disponible.
<ol>
  <li>Pour chaque espace de nom à l'exception d'`ibm-system` et de `kube-system`, déterminez si vous devez modifier des tolérances :</br>
  ```
  kubectl get pods -n <namespace> -o yaml | grep "scheduler.alpha.kubernetes.io/tolerations" && echo "Action required"
  ```
  </br>

  <li>Si `"Action required"` es renvoyé, utilisez la zone [_PodSpec_ ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/api-reference/v1.7/#podspec-v1-core) _tolerations_ au lieu de l'annotation `scheduler.alpha.kubernetes.io/tolerations`
</ol>
</tr>
<tr>
<td>Annotation taints</td>
<td>L'annotation `scheduler.alpha.kubernetes.io/taints` n'est plus disponible.
<ol>
  <li>Déterminez si vous devez modifier des annotations taints :</br>
  ```
  kubectl get nodes -o yaml | grep "scheduler.alpha.kubernetes.io/taints" && echo "Action required"
  ```
  <li>Si `"Action required"` est renvoyé, supprimez l'annotation `scheduler.alpha.kubernetes.io/taints` pour chaque noeud :</br>
  `kubectl annotate nodes <node> scheduler.alpha.kubernetes.io/taints-`
  <li>Ajoutez une annotation taint à chaque noeud :</br>
  `kubectl taint node <node> <taint>`
  </ol>
</tr>
<tr>
<td>DNS de pod StatefulSet</td>
<td>Les pods StatefulSet perdent leurs entrées DNS Kubernetes après mise à jour du maître. Pour restaurer les entrées DNS, supprimez les pods StatefulSet. Kubernetes recrée les pods et restaure automatiquement les entrées DNS. Pour plus d'informations, voir [Problèmes Kubernetes ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://github.com/kubernetes/kubernetes/issues/48327).
</tr>
</tbody>
</table>
