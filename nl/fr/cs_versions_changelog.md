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



# Journal des modifications de version
{: #changelog}

Affichez des informations sur les modifications de version correspondant à des mises à jour principale, secondaire ou de correctif disponibles pour vos clusters Kubernetes {{site.data.keyword.containerlong}}. Les modifications comprennent des mises à jour pour les composants de Kubernetes et d'{{site.data.keyword.Bluemix_notm}} Provider.
{:shortdesc}

IBM applique automatiquement les mises à jour de correctif du maître, mais vous devez [mettre à jour les correctifs de vos noeuds worker](cs_cluster_update.html#worker_node). Pour le maître et les noeuds worker, vous devez appliquer des mises à jour [principales et secondaires](cs_versions.html#update_types). Vérifiez tous les mois s'il y a des mises à jour disponibles. Dès que des mises à jour deviennent disponibles, vous en êtes informé lorsque vous affichez des informations sur le maître ou les noeuds worker dans l'interface graphique ou l'interface de ligne de commande (CLI), par exemple en exécutant les commandes suivantes : `ibmcloud ks clusters`, `cluster-get`, `workers` ou `worker-get`.

Pour obtenir un récapitulatif des actions de migration, voir [Versions de Kubernetes](cs_versions.html).
{: tip}

Pour plus d'informations sur les modifications apportées depuis la version précédente, voir les journaux de modifications suivants.
-  [Journal des modifications](#110_changelog) - Version 1.10.
-  [Journal des modifications](#19_changelog) - Version 1.9.
-  [Journal des modifications](#18_changelog) - Version 1.8.
-  [Archive](#changelog_archive) des journaux des modifications pour les versions dépréciées ou non prises en charge.

## Journal des modifications - Version 1.10
{: #110_changelog}

Passez en revue les modifications suivantes.

### Journal des modifications pour la version 1.10.5_1517, publié le 27 juillet 2018
{: #1105_1517}

<table summary="Modifications effectuées depuis la version 1.10.3_1514">
<caption>Modifications depuis la version 1.10.3_1514</caption>
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
<td>Calico</td>
<td>v3.1.1</td>
<td>v3.1.3</td>
<td>Voir les [notes sur l'édition de Calico ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://docs.projectcalico.org/v3.1/releases/#v313).</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.10.3-85</td>
<td>v1.10.5-118</td>
<td>Mis à jour pour prendre en charge l'édition Kubernetes 1.10.5. En outre, les événements `create failure` du service LoadBalancer incluent désormais toutes les erreurs des sous-réseaux portables.</td>
</tr>
<tr>
<td>Plug-in IBM File Storage</td>
<td>320</td>
<td>334</td>
<td>Le délai de création d'un volume persistant a augmenté pour passer de 15 à 30 minutes. Le type de facturation par défaut a été changé pour passer à une facturation à l'heure (`hourly`). Des options de montage ont été ajoutées aux classes de stockage prédéfinies. Dans l'instance de stockage de fichiers NFS dans votre compte d'infrastructure IBM Cloud (SoftLayer), la zone **Notes** est désormais au format JSON et l'espace de nom Kubernetes dans lequel le volume persistant est déployé a été ajouté. Pour prendre en charge les clusters à zones multiples, des libellés de zone et de région ont été ajoutés pour les volumes persistants.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.10.3</td>
<td>v1.10.5</td>
<td>Voir les [notes sur l'édition de Kubernetes ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.5).</td>
</tr>
<tr>
<td>Noyau</td>
<td>N/A</td>
<td>N/A</td>
<td>De légères améliorations ont été apportées aux paramètres réseau des noeuds worker pour les charges de travail réseau à hautes performances.</td>
</tr>
<tr>
<td>Client OpenVPN</td>
<td>N/A</td>
<td>N/A</td>
<td>Le déploiement du `vpn` du client OpenVPN qui s'exécute dans l'espace de nom `kube-system` est désormais géré par le gestionnaire `addon-manager` de Kubernetes.</td>
</tr>
</tbody>
</table>

### Journal des modifications de noeud worker - Groupe de correctifs 1.10.3_1514, publié le 3 juillet 2018
{: #1103_1514}

<table summary="Modifications effectuées depuis la version 1.10.3_1513">
<caption>Modifications depuis la version 1.10.3_1513</caption>
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
<td>Noyau</td>
<td>N/A</td>
<td>N/A</td>
<td>Optimisation de `sysctl` pour les charges de travail réseau hautes performances.</td>
</tr>
</tbody>
</table>


### Journal des modifications de noeud worker - Groupe de correctifs 1.10.3_1513, publié le 21 juin 2018
{: #1103_1513}

<table summary="Modifications effectuées depuis la version 1.10.3_1512">
<caption>Modifications depuis la version 1.10.3_1512</caption>
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
<td>Docker</td>
<td>N/A</td>
<td>N/A</td>
<td>Pour les types de machine non chiffrés, le disque secondaire est nettoyé en obtenant un nouveau système de fichiers lors du rechargement ou de la mise à jour du noeud worker.</td>
</tr>
</tbody>
</table>

### Journal des modifications pour la version 1.10.3_1512, publié le 12 juin 2018
{: #1103_1512}

<table summary="Modifications effectuées depuis la version 1.10.1_1510">
<caption>Modifications depuis la version 1.10.1_1510</caption>
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
<td>v1.10.1</td>
<td>v1.10.3</td>
<td>Voir les [notes sur l'édition de Kubernetes ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.3).</td>
</tr>
<tr>
<td>Configuration de Kubernetes</td>
<td>N/A</td>
<td>N/A</td>
<td>Ajout de `PodSecurityPolicy` dans l'option `--enable-admission-plugins` pour le serveur d'API Kubernetes du cluster et configuration du cluster pour prendre en charge les politiques de sécurité de pod. Pour plus d'informations, voir [Configuration de politiques de sécurité de pod](cs_psp.html).</td>
</tr>
<tr>
<td>Configuration de Kubelet</td>
<td>N/A</td>
<td>N/A</td>
<td>L'option `--authentication-token-webhook` a été activée pour prendre en charge les jetons porteur pour API et les jetons de compte de service pour l'authentification avec le noeud final HTTPS `kubelet`.</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.10.1-52</td>
<td>v1.10.3-85</td>
<td>Mis à jour pour prendre en charge l'édition Kubernetes 1.10.3.</td>
</tr>
<tr>
<td>Client OpenVPN</td>
<td>N/A</td>
<td>N/A</td>
<td>Ajout de `livenessProbe` dans le déploiement du `vpn` du client OpenVPN qui s'exécute dans l'espace de nom `kube-system`.</td>
</tr>
<tr>
<td>Mise à jour du noyau</td>
<td>4.4.0-116</td>
<td>4.4.0-127</td>
<td>Nouvelles images de noeuds worker avec la mise à jour du noyau pour [CVE-2018-3639 ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-3639).</td>
</tr>
</tbody>
</table>



### Journal des modifications de noeud worker - Groupe de correctifs 1.10.1_1510, publié le 18 mai 2018
{: #1101_1510}

<table summary="Modifications effectuées depuis la version 1.10.1_1509">
<caption>Modifications depuis la version 1.10.1_1509</caption>
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
<td>Kubelet</td>
<td>N/A</td>
<td>N/A</td>
<td>Correctif pour résoudre un bogue qui se produisait lorsque vous utilisiez un plug-in de stockage par blocs.</td>
</tr>
</tbody>
</table>

### Journal des modifications de noeud worker - Groupe de correctifs 1.10.1_1509, publié le 16 mai 2018
{: #1101_1509}

<table summary="Modifications effectuées depuis la version 1.10.1_1508">
<caption>Modifications depuis la version 1.10.1_1508</caption>
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
<td>Kubelet</td>
<td>N/A</td>
<td>N/A</td>
<td>Les données que vous stockez dans le répertoire racine `kubelet` sont désormais sauvegardées dans un disque secondaire plus volumineux de la machine du noeud worker.</td>
</tr>
</tbody>
</table>

### Journal des modifications pour la version 10. 1_1508, publié le 1er mai 2018
{: #1101_1508}

<table summary="Modifications effectuées depuis la version 1.9.7_1510">
<caption>Modifications depuis la version 1.9.7_1510</caption>
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
<td>Calico</td>
<td>v2.6.5</td>
<td>v3.1.1</td>
<td>Voir les [notes sur l'édition de Calico ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://docs.projectcalico.org/v3.1/releases/#v311).</td>
</tr>
<tr>
<td>Kubernetes Heapster</td>
<td>v1.5.0</td>
<td>v1.5.2</td>
<td>Voir les [notes sur l'édition de Kubernetes Heapster ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://github.com/kubernetes/heapster/releases/tag/v1.5.2).</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.9.7</td>
<td>v1.10.1</td>
<td>Voir les [notes sur l'édition de Kubernetes ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.1).</td>
</tr>
<tr>
<td>Configuration de Kubernetes</td>
<td>N/A</td>
<td>N/A</td>
<td>Ajout de <code>StorageObjectInUseProtection</code> à l'option <code>--enable-admission-plugins</code> pour le serveur d'API Kubernetes du cluster.</td>
</tr>
<tr>
<td>Kubernetes DNS</td>
<td>1.14.8</td>
<td>1.14.10</td>
<td>Voir les [notes sur l'édition de Kubernetes DNS ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://github.com/kubernetes/dns/releases/tag/1.14.10).</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.9.7-102</td>
<td>v1.10.1-52</td>
<td>Mis à jour pour prendre en charge la version Kubernetes 1.10.</td>
</tr>
<tr>
<td>Prise en charge de GPU</td>
<td>N/A</td>
<td>N/A</td>
<td>La prise en charge des [charges de travail de conteneur d'unité de traitement graphique (GPU)](cs_app.html#gpu_app) est désormais disponible pour la planification et l'exécution. Pour obtenir la liste des types de machine GPU disponibles, voir [Matériel pour les noeuds worker](cs_clusters.html#shared_dedicated_node). Pour plus d'informations, voir la documentation Kubernetes relative à la [planification d'unités GPU ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/tasks/manage-gpus/scheduling-gpus/).</td>
</tr>
</tbody>
</table>

## Journal des modifications - Version 1.9
{: #19_changelog}

Passez en revue les modifications suivantes.

### Journal des modifications pour la version 1.9.9_1520, publié le 27 juillet 2018
{: #199_1520}

<table summary="Modifications effectuées depuis la version 1.9.8_1517">
<caption>Modifications depuis la version 1.9.8_1517</caption>
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
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.9.8-141</td>
<td>v1.9.9-167</td>
<td>Mis à jour pour prendre en charge l'édition Kubernetes 1.9.9. En outre, les événements `create failure` du service LoadBalancer incluent désormais toutes les erreurs des sous-réseaux portables.</td>
</tr>
<tr>
<td>Plug-in IBM File Storage</td>
<td>320</td>
<td>334</td>
<td>Le délai de création d'un volume persistant a augmenté pour passer de 15 à 30 minutes. Le type de facturation par défaut a été changé pour passer à une facturation à l'heure (`hourly`). Des options de montage ont été ajoutées aux classes de stockage prédéfinies. Dans l'instance de stockage de fichiers NFS dans votre compte d'infrastructure IBM Cloud (SoftLayer), la zone **Notes** est désormais au format JSON et l'espace de nom Kubernetes dans lequel le volume persistant est déployé a été ajouté. Pour prendre en charge les clusters à zones multiples, des libellés de zone et de région ont été ajoutés pour les volumes persistants.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.9.8</td>
<td>v1.9.9</td>
<td>Voir les [notes sur l'édition de Kubernetes ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://github.com/kubernetes/kubernetes/releases/tag/v1.9.9).</td>
</tr>
<tr>
<td>Noyau</td>
<td>N/A</td>
<td>N/A</td>
<td>De légères améliorations ont été apportées aux paramètres réseau des noeuds worker pour les charges de travail réseau à hautes performances.</td>
</tr>
<tr>
<td>Client OpenVPN</td>
<td>N/A</td>
<td>N/A</td>
<td>Le déploiement du `vpn` du client OpenVPN qui s'exécute dans l'espace de nom `kube-system` est désormais géré par le gestionnaire `addon-manager` de Kubernetes.</td>
</tr>
</tbody>
</table>

### Journal des modifications de noeud worker - Groupe de correctifs 1.9.8_1517, publié le 3 juillet 2018
{: #198_1517}

<table summary="Modifications effectuées depuis la version 1.9.8_1516">
<caption>Modifications depuis la version 1.9.8_1516</caption>
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
<td>Noyau</td>
<td>N/A</td>
<td>N/A</td>
<td>Optimisation de `sysctl` pour les charges de travail réseau hautes performances.</td>
</tr>
</tbody>
</table>


### Journal des modifications de noeud worker - Groupe de correctifs 1.9.8_1516, publié le 21 juin 2018
{: #198_1516}

<table summary="Modifications effectuées depuis la version 1.9.8_1515">
<caption>Modifications depuis la version 1.9.8_1515</caption>
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
<td>Docker</td>
<td>N/A</td>
<td>N/A</td>
<td>Pour les types de machine non chiffrés, le disque secondaire est nettoyé en obtenant un nouveau système de fichiers lors du rechargement ou de la mise à jour du noeud worker.</td>
</tr>
</tbody>
</table>

### Journal des modifications pour la version 1.9.8_1515, publié le 19 juin 2018
{: #198_1515}

<table summary="Modifications effectuées depuis la version 1.9.7_1513">
<caption>Modifications depuis la version 1.9.7_1513</caption>
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
<td>v1.9.7</td>
<td>v1.9.8</td>
<td>Voir les [notes sur l'édition de Kubernetes![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://github.com/kubernetes/kubernetes/releases/tag/v1.9.8). </td>
</tr>
<tr>
<td>Configuration de Kubernetes</td>
<td>N/A</td>
<td>N/A</td>
<td>Ajout de PodSecurityPolicy dans l'option --admission-control pour le serveur d'API Kubernetes du cluster et configuration du cluster pour prendre en charge les politiques de sécurité de pod. Pour plus d'informations, voir [Configuration de politiques de sécurité de pod](cs_psp.html).</td>
</tr>
<tr>
<td>IBM Cloud Provider</td>
<td>v1.9.7-102</td>
<td>v1.9.8-141</td>
<td>Mis à jour pour prendre en charge l'édition Kubernetes 1.9.8. </td>
</tr>
<tr>
<td>Client OpenVPN</td>
<td>N/A</td>
<td>N/A</td>
<td>Ajout de <code>livenessProbe</code> dans le déploiement du <code>vpn</code> du client OpenVPN qui s'exécute dans l'espace de nom <code>kube-system</code>.</td>
</tr>
</tbody>
</table>


### Journal des modifications de noeud worker - Groupe de correctifs 1.9.7_1513, publié le 11 juin 2018
{: #197_1513}

<table summary="Modifications effectuées depuis la version 1.9.7_1512">
<caption>Modifications depuis la version 1.9.7_1512</caption>
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
<td>Mise à jour du noyau</td>
<td>4.4.0-116</td>
<td>4.4.0-127</td>
<td>Nouvelles images de noeuds worker avec la mise à jour du noyau pour [CVE-2018-3639 ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-3639).</td>
</tr>
</tbody>
</table>

### Journal des modifications de noeud worker - Groupe de correctifs 1.9.7_1512, publié le 18 mai 2018
{: #197_1512}

<table summary="Modifications effectuées depuis la version 1.9.7_1511">
<caption>Modifications depuis la version 1.9.7_1511</caption>
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
<td>Kubelet</td>
<td>N/A</td>
<td>N/A</td>
<td>Correctif pour résoudre un bogue qui se produisait lorsque vous utilisiez un plug-in de stockage par blocs.</td>
</tr>
</tbody>
</table>

### Journal des modifications de noeud worker - Groupe de correctifs 1.9.7_1511, publié le 16 mai 2018
{: #197_1511}

<table summary="Modifications effectuées depuis la version 1.9.7_1510">
<caption>Modifications depuis la version 1.9.7_1510</caption>
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
<td>Kubelet</td>
<td>N/A</td>
<td>N/A</td>
<td>Les données que vous stockez dans le répertoire racine `kubelet` sont désormais sauvegardées dans un disque secondaire plus volumineux de la machine du noeud worker.</td>
</tr>
</tbody>
</table>

### Journal des modifications pour la version 1.9.7_1510, publié le 30 avril 2018
{: #197_1510}

<table summary="Modifications effectuées depuis la version 1.9.3_1506">
<caption>Modifications depuis la version 1.9.3_1506</caption>
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
<td>v1.9.3</td>
<td>v1.9.7	</td>
<td><p>Voir les [notes sur l'édition de Kubernetes![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://github.com/kubernetes/kubernetes/releases/tag/v1.9.7). Cette édition traite les vulnérabilités [CVE-2017-1002101 ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002101) et [CVE-2017-1002102 ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002102).</p><p><strong>Remarque</strong> : désormais les éléments `secret`, `configMap`, `downwardAPI` et les volumes projetés sont montés en lecture seule. Auparavant, les applications écrivaient des données dans ces volumes que le système pouvait rétablir automatiquement. Si vos applications s'appuient sur ce comportement peu fiable en matière de sécurité, modifiez-les en conséquence.</p></td>
</tr>
<tr>
<td>Configuration de Kubernetes</td>
<td>N/A</td>
<td>N/A</td>
<td>Ajout de `admissionregistration.k8s.io/v1alpha1=true` à l'option `--runtime-config` pour le serveur d'API Kubernetes du cluster.</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.9.3-71</td>
<td>v1.9.7-102</td>
<td>Les services `NodePort` et `LoadBalancer` prennent désormais en charge la [conservation de l'adresse IP source du client](cs_loadbalancer.html#node_affinity_tolerations) en définissant l'élément `service.spec.externalTrafficPolicy` sur `Local`.</td>
</tr>
<tr>
<td></td>
<td></td>
<td></td>
<td>Correction de la configuration de tolérance des [noeuds de périphérie](cs_edge.html#edge) pour les clusters plus anciens.</td>
</tr>
</tbody>
</table>

## Journal des modifications - Version 1.8
{: #18_changelog}

Passez en revue les modifications suivantes.

### Journal des modifications pour la version 1.8.15_1518, publié le 27 juillet 2018
{: #1815_1518}

<table summary="Modifications effectuées depuis la version 1.8.13_1516">
<caption>Modifications depuis la version 1.8.13_1516</caption>
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
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.8.13-176</td>
<td>v1.8.15-204</td>
<td>Mis à jour pour prendre en charge l'édition Kubernetes 1.8.15. En outre, les événements `create failure` du service LoadBalancer incluent désormais toutes les erreurs des sous-réseaux portables.</td>
</tr>
<tr>
<td>Plug-in IBM File Storage</td>
<td>320</td>
<td>334</td>
<td>Le délai de création d'un volume persistant a augmenté pour passer de 15 à 30 minutes. Le type de facturation par défaut a été changé pour passer à une facturation à l'heure (`hourly`). Des options de montage ont été ajoutées aux classes de stockage prédéfinies. Dans l'instance de stockage de fichiers NFS dans votre compte d'infrastructure IBM Cloud (SoftLayer), la zone **Notes** est désormais au format JSON et l'espace de nom Kubernetes dans lequel le volume persistant est déployé a été ajouté. Pour prendre en charge les clusters à zones multiples, des libellés de zone et de région ont été ajoutés pour les volumes persistants.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.8.13</td>
<td>v1.8.15</td>
<td>Voir les [notes sur l'édition de Kubernetes ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://github.com/kubernetes/kubernetes/releases/tag/v1.8.15).</td>
</tr>
<tr>
<td>Noyau</td>
<td>N/A</td>
<td>N/A</td>
<td>De légères améliorations ont été apportées aux paramètres réseau des noeuds worker pour les charges de travail réseau à hautes performances.</td>
</tr>
<tr>
<td>Client OpenVPN</td>
<td>N/A</td>
<td>N/A</td>
<td>Le déploiement du `vpn` du client OpenVPN qui s'exécute dans l'espace de nom `kube-system` est désormais géré par le gestionnaire `addon-manager` de Kubernetes.</td>
</tr>
</tbody>
</table>

### Journal des modifications de noeud worker - Groupe de correctifs 1.8.13_1516, publié le 3 juillet 2018
{: #1813_1516}

<table summary="Modifications effectuées depuis la version 1.8.13_1515">
<caption>Modifications depuis la version 1.8.13_1515</caption>
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
<td>Noyau</td>
<td>N/A</td>
<td>N/A</td>
<td>Optimisation de `sysctl` pour les charges de travail réseau hautes performances.</td>
</tr>
</tbody>
</table>


### Journal des modifications de noeud worker - Groupe de correctifs 1.8.13_1515, publié le 21 juin 2018
{: #1813_1515}

<table summary="Modifications effectuées depuis la version 1.8.13_1514">
<caption>Modifications depuis la version 1.8.13_1514</caption>
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
<td>Docker</td>
<td>N/A</td>
<td>N/A</td>
<td>Pour les types de machine non chiffrés, le disque secondaire est nettoyé en obtenant un nouveau système de fichiers lors du rechargement ou de la mise à jour du noeud worker.</td>
</tr>
</tbody>
</table>

### Journal des modifications pour la version 1.8.13_1514, publié le 19 juin 2018
{: #1813_1514}

<table summary="Modifications effectuées depuis la version 1.8.11_1512">
<caption>Modifications depuis la version 1.8.11_1512</caption>
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
<td>v1.8.11</td>
<td>v1.8.13</td>
<td>Voir les [notes sur l'édition de Kubernetes![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://github.com/kubernetes/kubernetes/releases/tag/v1.8.13). </td>
</tr>
<tr>
<td>Configuration de Kubernetes</td>
<td>N/A</td>
<td>N/A</td>
<td>Ajout de PodSecurityPolicy dans l'option --admission-control pour le serveur d'API Kubernetes du cluster et configuration du cluster pour prendre en charge les politiques de sécurité de pod. Pour plus d'informations, voir [Configuration de politiques de sécurité de pod](cs_psp.html).</td>
</tr>
<tr>
<td>IBM Cloud Provider</td>
<td>v1.8.11-126</td>
<td>v1.8.13-176</td>
<td>Mis à jour pour prendre en charge l'édition Kubernetes 1.8.13. </td>
</tr>
<tr>
<td>Client OpenVPN</td>
<td>N/A</td>
<td>N/A</td>
<td>Ajout de <code>livenessProbe</code> dans le déploiement du <code>vpn</code> du client OpenVPN qui s'exécute dans l'espace de nom <code>kube-system</code>.</td>
</tr>
</tbody>
</table>


### Journal des modifications de noeud worker - Groupe de correctifs 1.8.11_1512, publié le 11 juin 2018
{: #1811_1512}

<table summary="Modifications effectuées depuis la version 1.8.11_1511">
<caption>Modifications depuis la version 1.8.11_1511</caption>
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
<td>Mise à jour du noyau</td>
<td>4.4.0-116</td>
<td>4.4.0-127</td>
<td>Nouvelles images de noeuds worker avec la mise à jour du noyau pour [CVE-2018-3639 ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-3639).</td>
</tr>
</tbody>
</table>


### Journal des modifications de noeud worker - Groupe de correctifs 1.8.11_1511, publié le 18 mai 2018
{: #1811_1511}

<table summary="Modifications effectuées depuis la version 1.8.11_1510">
<caption>Modifications depuis la version 1.8.11_1510</caption>
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
<td>Kubelet</td>
<td>N/A</td>
<td>N/A</td>
<td>Correctif pour résoudre un bogue qui se produisait lorsque vous utilisiez un plug-in de stockage par blocs.</td>
</tr>
</tbody>
</table>

### Journal des modifications de noeud worker - Groupe de correctifs 1.8.11_1510, publié le 16 mai 2018
{: #1811_1510}

<table summary="Modifications effectuées depuis la version 1.8.11_1509">
<caption>Modifications depuis la version 1.8.11_1509</caption>
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
<td>Kubelet</td>
<td>N/A</td>
<td>N/A</td>
<td>Les données que vous stockez dans le répertoire racine `kubelet` sont désormais sauvegardées dans un disque secondaire plus volumineux de la machine du noeud worker.</td>
</tr>
</tbody>
</table>


### Journal des modifications pour la version 1.8.11_1509, publié le 19 avril 2018
{: #1811_1509}

<table summary="Modifications effectuées depuis la version 1.8.8_1507">
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
<td><p>Voir les [notes sur l'édition de Kubernetes![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://github.com/kubernetes/kubernetes/releases/tag/v1.8.11). Cette édition traite les vulnérabilités [CVE-2017-1002101 ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002101) et [CVE-2017-1002102 ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002102).</p><p><strong>Remarque</strong> : désormais les éléments `secret`, `configMap`, `downwardAPI` et les volumes projetés sont montés en lecture seule. Auparavant, les applications écrivaient des données dans ces volumes que le système pouvait rétablir automatiquement. Si vos applications s'appuient sur ce comportement peu fiable en matière de sécurité, modifiez-les en conséquence.</p></td>
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
<td>Correction de la configuration de tolérance des [noeuds de périphérie](cs_edge.html#edge) pour les clusters plus anciens.</td>
</tr>
</tbody>
</table>

## Archive
{: #changelog_archive}

### Journal des modifications pour la version 1.7 (non prise en charge)
{: #17_changelog}

Passez en revue les modifications suivantes.

#### Journal des modifications de noeud worker - Groupe de correctifs 1.7.16_1514, publié le 11 juin 2018
{: #1716_1514}

<table summary="Modifications effectuées depuis la version 1.7.16_1513">
<caption>Modifications depuis la version 1.7.16_1513</caption>
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
<td>Mise à jour du noyau</td>
<td>4.4.0-116</td>
<td>4.4.0-127</td>
<td>Nouvelles images de noeuds worker avec la mise à jour du noyau pour [CVE-2018-3639 ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-3639).</td>
</tr>
</tbody>
</table>

#### Journal des modifications de noeud worker - Groupe de correctifs 1.7.16_1513, publié le 18 mai 2018
{: #1716_1513}

<table summary="Modifications effectuées depuis la version 1.7.16_1512">
<caption>Modifications depuis la version 1.7.16_1512</caption>
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
<td>Kubelet</td>
<td>N/A</td>
<td>N/A</td>
<td>Correctif pour résoudre un bogue qui se produisait lorsque vous utilisiez un plug-in de stockage par blocs.</td>
</tr>
</tbody>
</table>

#### Journal des modifications de noeud worker - Groupe de correctifs 1.7.16_1512, publié le 16 mai 2018
{: #1716_1512}

<table summary="Modifications effectuées depuis la version 1.7.16_1511">
<caption>Modifications depuis la version 1.7.16_1511</caption>
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
<td>Kubelet</td>
<td>N/A</td>
<td>N/A</td>
<td>Les données que vous stockez dans le répertoire racine `kubelet` sont désormais sauvegardées dans un disque secondaire plus volumineux de la machine du noeud worker.</td>
</tr>
</tbody>
</table>

#### Journal des modifications pour la version 1.7.16_1511, publié le 19 avril 2018
{: #1716_1511}

<table summary="Modifications effectuées depuis la version 1.7.4_1509">
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
<td><p>Voir les [Notes sur l'édition de Kubernetes![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://github.com/kubernetes/kubernetes/releases/tag/v1.7.16). Cette édition traite les vulnérabilités [CVE-2017-1002101 ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002101) et [CVE-2017-1002102 ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002102).</p><p><strong>Remarque</strong> : désormais les éléments `secret`, `configMap`, `downwardAPI` et les volumes projetés sont montés en lecture seule. Auparavant, les applications écrivaient des données dans ces volumes que le système pouvait rétablir automatiquement. Si vos applications s'appuient sur ce comportement peu fiable en matière de sécurité, modifiez-les en conséquence.</p></td>
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
<td>Correction de la configuration de tolérance des [noeuds de périphérie](cs_edge.html#edge) pour les clusters plus anciens.</td>
</tr>
</tbody>
</table>
