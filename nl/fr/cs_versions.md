---

copyright:
  years: 2014, 2018
lastupdated: "2018-02-08"

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

{{site.data.keyword.containerlong}} gère la coexistence de plusieurs versions de Kubernetes : une version la plus récente, une version par défaut et une version prise en charge, généralement deux versions derrière la plus récente. La version par défaut peut être identique à la plus récente et elle est utilisée lorsque vous créez un cluster, à moins que vous n'en spécifiez une autre.
{:shortdesc}

Versions Kubernetes actuellement prises en charge :

- Version la plus récente : 1.9.2
- Version par défaut : 1.8.6
- Version prise en charge : 1.7.4

Si vous utilisez des clusters sur une version Kubernetes non prise en charge actuellement, [examinez les informations sur les impacts potentiels](#version_types) pour identifier les mises à jour, puis [mettez à jour votre cluster](cs_cluster_update.html#update) immédiatement pour continuer à recevoir des mises à jour de sécurité importantes et bénéficier du support. Pour identifier la version la plus récente, exécutez la commande suivante.

```
kubectl version  --short | grep -i server
```
{: pre}

Exemple de sortie :

```
Server Version: 1.8.6
```
{: screen}

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
{: tip}

Les informations qui suivent récapitulent les mises à jour susceptibles d'avoir un impact sur les applications déployées lorsque vous mettez à jour un cluster vers une nouvelle version. Consultez le journal [Kubernetes changelog ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG.md) pour obtenir la liste complète des modifications dans les versions de Kubernetes.

Pour plus d'informations sur le processus de mise à jour, voir [Mise à jour des clusters](cs_cluster_update.html#master) et [Mise à jour des noeuds d'agent](cs_cluster_update.html#worker_node).

## Version 1.9
{: #cs_v19}



Passez en revue les modifications que vous devrez peut-être apporter lors d'une mise à jour depuis la version Kubernetes antérieure vers la version 1.9.

<br/>

### Mise à jour avant le maître
{: #19_before}

<table summary="Mises à jour Kubernetes pour la version 1.9">
<caption>Modifications à apporter lors de la mise à jour du maître vers la version Kubernetes 1.9</caption>
<thead>
<tr>
<th>Type</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>API d'admission webhook</td>
<td>L'API d'admission, qui est utilisée lorsque le serveur d'API appelle des webhooks de contrôle d'admission, a été transférée de <code>admission.v1alpha1</code> à <code>admission.v1beta1</code>. <em>Vous devez supprimer les éventuels webhooks existants avant de mettre à niveau votre cluster</em> et mettre à jour les fichiers de configuration webhook afin d'utiliser l'API la plus récente. Cette modification n'est pas compatible en amont.</td>
</tr>
</tbody>
</table>

### Mise à jour après le maître
{: #19_after}

<table summary="Mises à jour Kubernetes pour la version 1.9">
<caption>Modifications à apporter après la mise à jour du maître vers la version Kubernetes 1.9</caption>
<thead>
<tr>
<th>Type</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Sortie `kubectl`</td>
<td>A présent, lorsque vous utilisez la commande `kubectl` en spécifiant `-o custom-columns` et que la colonne est introuvable dans l'objet, la sortie indique `<none>`.<br>
Auparavant, l'opération échouait et un message d'erreur `xxx is not found` (xxx introuvable) était affiché. Si vos scripts reposent sur le comportement antérieur, mettez-les à jour.</td>
</tr>
<tr>
<td>`kubectl patch`</td>
<td>Maintenant, lorsqu'aucune modification n'est apportée à la ressource concernée, la commande the `kubectl patch` échoue avec un `exit code 1`. Si vos scripts reposent sur le comportement antérieur, mettez-les à jour.</td>
</tr>
<tr>
<td>Droits sur le tableau de bord Kubernetes</td>
<td>Les utilisateurs doivent à présent se connecter au tableau de bord Kubernetes avec leurs données d'identification pour afficher les ressources du cluster. L'autorisation RBAC `ClusterRoleBinding` du tableau de bord Kubernetes par défaut a été supprimée. Pour les instructions correspondantes, voir [Lancement du tableau de bord Kubernetes](cs_app.html#cli_dashboard).</td>
</tr>
<tr>
<td>RBAC pour `ServiceAccount` `default` </td>
<td>L'administrateur `ClusterRoleBinding` pour le `ServiceAccount` `default` dans l'espace nom `default` a été supprimé. Si vos applications s'appuient sur cette règle RBAC pour accéder à l'API Kubernetes, [mettez à jour vos règles RBAC](https://kubernetes.io/docs/admin/authorization/rbac/#api-overview).</td>
</tr>
<tr>
<td>Annotations Taints et tolerations</td>
<td>Les annotations taint `node.alpha.kubernetes.io/notReady` et `node.alpha.kubernetes.io/unreachable` en été changées respectivement en `node.kubernetes.io/not-ready` et `node.kubernetes.io/unreachable`.<br>
Bien que ces annotations taint soient mises à jour automatiquement, vous devez mettre à jour manuellement leurs annotations tolerations. Pour chaque espace nom, hormis `ibm-system` et `kube-system`, déterminez si vous avez besoin de modifier les annotations tolerations :<br>
<ul><li><code>kubectl get pods -n &lt;namespace&gt; -o yaml | grep "node.alpha.kubernetes.io/notReady" && echo "Action required"</code></li><li>
<code>kubectl get pods -n &lt;namespace&gt; -o yaml | grep "node.alpha.kubernetes.io/unreachable" && echo "Action required"</code></li></ul><br>
Si `Action required` est renvoyé, modifiez les annotations tolerations de pod en conséquence.</td>
</tr>
<tr>
<td>API d'admission webhook</td>
<td>Si vous avez supprimé des webhooks existants avant de mettre à jour le cluster, créez de nouveaux webhooks.</td>
</tr>
</tbody>
</table>


## Version 1.8
{: #cs_v18}

<p><img src="images/certified_kubernetes_1x8.png" style="width:62px; height: 100px; border-style: none; padding-right: 10px;" height="100" width="62.5" align="left" alt="Ce badge indique la certification Kubernetes version 1.8 pour IBM Cloud Container Service."/> {{site.data.keyword.containerlong_notm}} est un produit certifié par Kubernetes pour la version 1.8 sous le programme CNCF de certification de conformité de logiciels Kubernetes. _Kubernetes® est une marque de la Fondation Linux aux Etats-Unis et dans d'autres pays et est utilisé dans le cadre d'une licence de la Fondation Linux._</p>

Passez en revue les modifications que vous devrez peut-être apporter lors d'une mise à jour depuis la version Kubernetes antérieure vers la version 1.8.

<br/>

### Mise à jour avant le maître
{: #18_before}

<table summary="Mises à jour Kubernetes pour les versions 1.8">
<caption>Modifications à effectuer avant mise à jour du maître vers Kubernetes 1.8</caption>
<thead>
<tr>
<th>Type</th>
<th>Description</th>
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
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Connexion au tableau de bord Kubernetes</td>
<td>L'URL d'accès au tableau de bord Kubernetes en version 1.8 a changé et le processus de connexion inclut une nouvelle étape d'authentification. Pour plus d'informations, voir [Accès au tableau de bord Kubernetes](cs_app.html#cli_dashboard).</td>
</tr>
<tr>
<td>Droits sur le tableau de bord Kubernetes</td>
<td>Pour forcer des utilisateurs à se connecter avec leurs données d'identification pour afficher des ressources de cluster en version 1.8, supprimez l'autorisation RBAC 1.7 ClusterRoleBinding. Exécutez `kubectl delete clusterrolebinding -n kube-system kubernetes-dashboard`.</td>
</tr>
<tr>
<td>`kubectl delete`</td>
<td>La commande `kubectl delete` ne réduit plus les objets d'API de charge de travail, tels que les pods, avant suppression de l'objet. Si vous avez besoin de réduire l'objet, utilisez la commande [kubectl scale ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#scale) avant de supprimer l'objet.</td>
</tr>
<tr>
<td>`kubectl run`</td>
<td>La commande `kubectl run` doit utiliser plusieurs indicateurs pour `--env` au lieu d'arguments séparés par une virgule. Par exemple, exécutez <code>kubectl run --env &lt;x&gt;=&lt;y&gt; --env &lt;z&gt;=&lt;a&gt;</code> et non pas <code>kubectl run --env &lt;x&gt;=&lt;y&gt;,&lt;z&gt;=&lt;a&gt;</code>. </td>
</tr>
<tr>
<td>`kubectl stop`</td>
<td>La commande `kubectl stop` n'est plus disponible.</td>
</tr>
</tbody>
</table>


## Version 1.7
{: #cs_v17}

<p><img src="images/certified_kubernetes_1x7.png" height="100" width="62.5" style="width:62px; height: 100px; border-style: none; padding-right: 10px;" align="left" alt="Ce badge indique une certification Kubernetes version 1.7 pour IBM Cloud Container Service."/> {{site.data.keyword.containerlong_notm}} est un produit certifié Kubernetes pour la version 1.7 sous le programme de certification de conformité de logiciel Kubernetes.</p>

Passez en revue les modifications que vous devrez peut-être apporter lors d'une mise à jour depuis la version Kubernetes antérieure vers la version 1.7.

<br/>

### Mise à jour avant le maître
{: #17_before}

<table summary="Mises à jour de Kubernetes pour les versions 1.7 et 1.6">
<caption>Modifications à effectuer avant mise à jour du maître vers Kubernetes 1.7</caption>
<thead>
<tr>
<th>Type</th>
<th>Description</th>
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
<th>Description</th>
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
  </br></li>
  <li>Si `"Action required"` es renvoyé, utilisez la zone [_PodSpec_ ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/api-reference/v1.7/#podspec-v1-core) _affinity_ au lieu de l'annotation `scheduler.alpha.kubernetes.io/affinity`.</li>
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
  </li></ol>
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
  </li></ol>
</tr>
<tr>
<td>DNS de pod StatefulSet</td>
<td>Les pods StatefulSet perdent leurs entrées DNS Kubernetes après mise à jour du maître. Pour restaurer les entrées DNS, supprimez les pods StatefulSet. Kubernetes recrée les pods et restaure automatiquement les entrées DNS. Pour plus d'informations, voir [Problèmes Kubernetes ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://github.com/kubernetes/kubernetes/issues/48327).
</tr>
</tbody>
</table>
