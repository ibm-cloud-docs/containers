---

copyright:
  years: 2014, 2018
lastupdated: "2018-4-20"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# Journal des modifications de version
{: #changelog}

Affichez des informations sur les modifications de version correspondant à des mises à jour principale, secondaire ou de correctif disponibles pour vos clusters Kubernetes {{site.data.keyword.containerlong}}. Les modifications comprennent des mises à jour pour les composants de Kubernetes et d'{{site.data.keyword.Bluemix_notm}} Provider.
{:shortdesc}

IBM applique automatiquement les mises à jour du maîtres incluant des correctifs, mais vous devez [mettre à jour vos noeuds worker](cs_cluster_update.html#worker_node). Vérifiez tous les mois s'il y a des mises à jour disponibles. A mesure que des mises à jour deviennent disponibles, vous en êtes informé lorsque vous affichez des informations sur les noeuds worker, par exemple avec les commandes `bx cs workers <cluster>` ou `bx cs worker-get <cluster> <worker>`.

Pour obtenir un récapitulatif des actions de migration, voir [Versions de Kubernetes](cs_versions.html).
{: tip}

Pour plus d'informations sur les modifications apportées depuis la version précédente, voir les journaux de modifications suivants.
-  [Journal des modifications](#18_changelog) - Version 1.8.
-  [Journal des modifications](#17_changelog) - Version 1.7.


## Journal des modifications - Version 1.8
{: #18_changelog}

Passez en revue les modifications suivantes.

### Journal des modifications pour la version 1.8.11_1509
{: #1811_1509}

<table summary="Modifications depuis la version 1.8.8_1507">
<caption>Modifications depuis la version 1.8.8_1507</caption>
<thead>
<tr>
<th>Composant</th>
<th>V. précédente</th>
<th>V. en cours</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>v1.8.8</td>
<td>v1.8.11	</td>
<td>Voir les [Notes sur l'édition de Kubernetes![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://github.com/kubernetes/kubernetes/releases/tag/v1.8.11).</td>
</tr>
<tr>
<td>Image de conteneur Pause</td>
<td>3.0</td>
<td>3.1</td>
<td>Supprime les processus zombie orphelins hérités.</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.8.8-86</td>
<td>v1.8.11-126</td>
<td>Les services `NodePort` et `LoadBalancer` prennent désormais en charge la [conservation de l'adresse IP source du client](cs_loadbalancer.html#node_affinity_tolerations) en définissant l'élément `service.spec.externalTrafficPolicy` sur `Local`.</td>
</tr>
<tr>
<td></td>
<td></td>
<td></td>
<td>Corrigez la configuration de la tolérance envers les [noeuds de périphérie](cs_edge.html#edge) pour les anciens clusters.</td>
</tr>
</tbody>
</table>

## Journal des modifications - Version 1.7
{: #17_changelog}

Passez en revue les modifications suivantes.

### Journal de modifications pour la version 1.7.16_1511
{: #1716_1511}

<table summary="Modifications depuis la version 1.7.4_1509">
<caption>Modifications depuis la version 1.7.4_1509</caption>
<thead>
<tr>
<th>Composant</th>
<th>V. précédente</th>
<th>V. en cours</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>v1.7.4</td>
<td>v1.7.16	</td>
<td>Voir les [Notes sur l'édition de Kubernetes![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://github.com/kubernetes/kubernetes/releases/tag/v1.7.16).</td>
</tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.7.4-133</td>
<td>v1.7.16-17</td>
<td>Les services `NodePort` et `LoadBalancer` prennent désormais en charge la [conservation de l'adresse IP source du client](cs_loadbalancer.html#node_affinity_tolerations) en définissant l'élément `service.spec.externalTrafficPolicy` sur `Local`.</td>
</tr>
<tr>
<td></td>
<td></td>
<td></td>
<td>Corrigez la configuration de tolérance des [noeuds de périphérie](cs_edge.html#edge) pour les anciens clusters.</td>
</tr>
</tbody>
</table>

