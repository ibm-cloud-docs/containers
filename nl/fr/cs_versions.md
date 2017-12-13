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

# Versions de Kubernetes pour {{site.data.keyword.containerlong_notm}}
{: #cs_versions}

Passez en revue les versions de Kubernetes disponibles sur {{site.data.keyword.containerlong}}.
{:shortdesc}

Le tableau contient les mises à jour susceptibles d'avoir un impact sur les applications déployées lorsque vous mettez à jour un cluster vers une nouvelle version. Consultez le journal [Kubernetes changelog ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG.md) pour obtenir la liste complète des modifications dans les versions de Kubernetes.

Pour plus d'informations sur le processus de mise à jour, voir [Mise à jour des clusters](cs_cluster.html#cs_cluster_update) et [Mise à jour des noeuds d'agent](cs_cluster.html#cs_cluster_worker_update).



## Version 1.7
{: #cs_v17}

### Mise à jour avant le maître
{: #17_before}

<table summary="Mises à jour de Kubernetes pour les versions 1.7 et 1.6">
<caption>Tableau 1. Modifications à effectuer avant la mise à jour du maître à la version 1.7 de Kubernetes</caption>
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
  <li>Exécutez cette commande pour déterminer s'il est nécessaire de mettre à jour vos chemins de stockage.</br>
  ```
  kubectl get pods --all-namespaces -o yaml | grep "\.\." && echo "Action required"
  ```
  </br>

  <li>Si `Action required` est renvoyé, modifiez chaque pod impacté de sorte à référencer le chemin absolu avant de mettre à jour tous vos noeuds d'agent. Si le pod est détenu par une autre ressource, par exemple un déploiement, modifiez [_PodSpec_ ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/api-reference/v1.7/#podspec-v1-core) dans cette ressource.
</ol>
</td>
</tr>
</tbody>
</table>

### Mise à jour après le maître
{: #17_after}

<table summary="Mises à jour de Kubernetes pour les versions 1.7 et 1.6">
<caption>Tableau 2. Modifications à effectuer après la mise à jour du maître à la version 1.7 de Kubernetes</caption>
<thead>
<tr>
<th>Type</th>
<th>Description
</tr>
</thead>
<tbod>
<tr>
<td>kubectl</td>
<td>Après avoir mis à jour l'interface CLI `kubectl` à la version de votre cluster, ces commandes `kubectl` doivent utiliser plusieurs indicateurs à la place d'arguments séparés par des virgules. <ul>
 <li>`create role`
 <li>`create clusterrole`
 <li>`create rolebinding`
 <li>`create clusterrolebinding`
 <li>`create secret`
 </ul>
</br>  Par exemple, exécutez la commande `kubectl create role --resource-name <x> --resource-name <y>` et non pas `kubectl create role --resource-name <x>,<y>`.</td>
</tr>
<tr>
<td>Planification d'affinité de pods</td>
<td> L'annotation `scheduler.alpha.kubernetes.io/affinity` est obsolète.
<ol>
  <li>Exécutez cette commande pour chaque espace de nom à l'exception d'`ibm-system` et de `kube-system`, afin de déterminer si vous devez mettre à jour la planification d'affinité des pods.</br>
  ```
  kubectl get pods -n <namespace> -o yaml | grep "scheduler.alpha.kubernetes.io/affinity" && echo "Action required"
  ```
  </br>
  <li>Si `"Action required"` est renvoyé, modifiez les pods impactés pour utiliser la zone [_PodSpec_ ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/api-reference/v1.7/#podspec-v1-core) _affinity_ à la place de l'annotation `scheduler.alpha.kubernetes.io/affinity`.
</ol>
</tr>
<tr>
<td>Règles réseau</td>
<td>L'annotation `net.beta.kubernetes.io/network-policy` n'est plus prise en charge.
<ol>
  <li>Exécutez cette commande pour déterminer s'il est nécessaire de mettre à jour vos règles réseau.</br>
  ```
  kubectl get ns -o yaml | grep "net.beta.kubernetes.io/network-policy" | grep "DefaultDeny" && echo "Action required"
  ```
  <li>Si `Action required` est renvoyé, ajoutez la règle réseau suivante à chaque espace de nom Kubernetes répertorié.</br>

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

  <li> Avec cette règle réseau en place, supprimez l'annotation `net.beta.kubernetes.io/network-policy`.
  ```
  kubectl annotate ns <namespace> --overwrite "net.beta.kubernetes.io/network-policy-"
  ```
  </ol>
</tr>
<tr>
<td>Annotation tolerations</td>
<td>L'annotation `scheduler.alpha.kubernetes.io/tolerations` n'est plus prise en charge.
<ol>
  <li>Exécutez cette commande pour chaque espace de nom à l'exception d'`ibm-system` et de `kube-system`, afin de déterminer si vous devez mettre à jour les tolérances.</br>
  ```
  kubectl get pods -n <namespace> -o yaml | grep "scheduler.alpha.kubernetes.io/tolerations" && echo "Action required"
  ```
  </br>

  <li>Si `"Action required"` est renvoyé, modifiez les pods impactés pour utiliser la zone [_PodSpec_ ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/api-reference/v1.7/#podspec-v1-core) _tolerations_ à la place de l'annotation `scheduler.alpha.kubernetes.io/tolerations`
</ol>
</tr>
<tr>
<td>Annotation taints</td>
<td>L'annotation `scheduler.alpha.kubernetes.io/taints` n'est plus prise en charge.
<ol>
  <li>Exécutez cette commande pour déterminer s'il est nécessaire de mettre à jour les annotations taints.</br>
  ```
  kubectl get nodes -o yaml | grep "scheduler.alpha.kubernetes.io/taints" && echo "Action required"
  ```
  <li>Si `"Action required"` est renvoyé, supprimez l'annotation `scheduler.alpha.kubernetes.io/taints` pour chaque noeud détenant cette annotation non prise en charge.</br>
  `kubectl annotate nodes <node> scheduler.alpha.kubernetes.io/taints-`
  <li>Lorsque l'annotation non prise en charge est supprimée, ajoutez taint à chaque noeud. Vous devez disposer de l'interface CLI `kubectl` version 1.6 ou ultérieure.</br>
  `kubectl taint node <node> <taint>`
  </ol>
</tr>
</tbody>
</table></staging>
