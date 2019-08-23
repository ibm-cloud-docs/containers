---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

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
{:preview: .preview}


# Notes sur l'édition
{: #iks-release}

Utilisez les notes sur l'édition pour en savoir plus sur les dernières modifications apportées à la documentation {{site.data.keyword.containerlong}} qui sont regroupées par mois.
{:shortdesc}

Les icônes suivantes sont utilisées pour indiquer si une note sur l'édition s'applique uniquement à une certaine plateforme de conteneur. Si aucune icône n'est utilisée, la note sur l'édition s'applique aux clusters Kubernetes de communauté et au clusters OpenShift. <br>
<img src="images/logo_kubernetes.svg" alt="Icône Kubernetes" width="15" style="width:15px; border-style: none"/> S'applique uniquement aux clusters Kubernetes de communauté. <br>
<img src="images/logo_openshift.svg" alt="Icône OpenShift" width="15" style="width:15px; border-style: none"/> S'applique uniquement aux clusters OpenShift, commercialisés en version bêta le 5 juin 2019.
{: note}

## Août 2019
{: #aug19}

<table summary="Le tableau présente des notes sur l'édition. La lecture des lignes s'effectue de gauche à droite, avec la date dans la première colonne, l'intitulé de la fonction dans la deuxième colonne et une description dans la troisième colonne.">
<caption>Mises à jour de la documentation apportées en août 2019</caption>
<thead>
<th>Date</th>
<th>Description</th>
</thead>
<tbody>
<tr>
  <td>1er août 2019</td>
  <td><img src="images/logo_openshift.svg" alt="Icône OpenShift" width="15" style="width:15px; border-style: none"/> <strong>Red Hat OpenShift on IBM Cloud</strong> : la disponibilité générale de Red Hat OpenShift on IBM est effective depuis le 1er août 2019, à 0:00 UTC. Les clusters bêta expireront dans un délai de 30 jours. Vous pouvez [créer un cluster GA (disponibilité générale)](/docs/openshift?topic=openshift-openshift_tutorial), puis redéployer les applications que vous utilisez dans les clusters bêta avant que ce derniers ne soient retirés. <br><br>Etant donné que la logique {{site.data.keyword.containerlong_notm}} et l'infrastructure de cloud sous-jacente sont identiques, de nombreuses rubriques sont réutilisées dans la documentation sur les clusters [Kubernetes de communauté](/docs/containers?topic=containers-getting-started) et les clusters [OpenShift](/docs/openshift?topic=openshift-getting-started), telles que cette rubrique de notes sur l'édition.</td>
</tr>
</tbody></table>

## Juillet 2019
{: #jul19}

<table summary="Le tableau présente des notes sur l'édition. La lecture des lignes s'effectue de gauche à droite, avec la date dans la première colonne, l'intitulé de la fonction dans la deuxième colonne et une description dans la troisième colonne.">
<caption>Mises à jour de la documentation {{site.data.keyword.containerlong_notm}} apportées en juillet 2019</caption>
<thead>
<th>Date</th>
<th>Description</th>
</thead>
<tbody>
<tr>
  <td>30 juillet 2019</td>
  <td><ul>
  <li><strong>Journal des modifications de l'interface de ligne de commande (CLI)</strong> : mise à jour de la page de journal des modifications du plug-in de l'interface de ligne de commande {{site.data.keyword.containerlong_notm}} pour l'[édition de la version 0.3.95](/docs/containers?topic=containers-cs_cli_changelog). </li>
  <li><strong>Journal des modifications de l'ALB Ingress</strong> : mise à jour de l'image `nginx-ingress` de l'ALB vers la génération 515 pour la [vérification de disponibilité de pod d'ALB](/docs/containers?topic=containers-cluster-add-ons-changelog#alb_changelog). </li>
  <li><strong>Retrait des sous-réseaux d'un cluster</strong> : ajout d'étapes permettant de retirer d'un cluster des sous-réseaux [figurant dans un compte d'infrastructure IBM Cloud](/docs/containers?topic=containers-subnets#remove-sl-subnets) ou [existant dans un réseau sur site](/docs/containers?topic=containers-subnets#remove-user-subnets). </li>
  </ul></td>
</tr>
<tr>
  <td>26 juillet 2019</td>
  <td><img src="images/logo_openshift.svg" alt="Icône OpenShift" width="15" style="width:15px; border-style: none"/> <strong>Red Hat OpenShift on IBM Cloud</strong> : Ajout de rubriques [Intégrations](/docs/openshift?topic=openshift-openshift_integrations), [Emplacements](/docs/openshift?topic=openshift-regions-and-zones) et [Contraintes de contexte de sécurité](/docs/openshift?topic=openshift-openshift_scc). Ajout des rôles de cluster `basic-users` et `self-provisioning` à la rubrique sur la [synchronisation du rôle de service IAM avec RBAC](/docs/openshift?topic=openshift-access_reference#service). </td>
</tr>
<tr>
  <td>23 juillet 2019</td>
  <td><strong>Journal des modifications de Fluentd changelog</strong> : Correction des [vulnérabilités Alpine](/docs/containers?topic=containers-cluster-add-ons-changelog#fluentd_changelog). </td>
</tr>
<tr>
  <td>22 juillet 2019</td>
  <td><ul>
  <li><img src="images/logo_kubernetes.svg" alt="Icône Kubernetes" width="15" style="width:15px; border-style: none"/> <strong>Règle de version</strong> : augmentation de la période de [d'obsolescence de la version](/docs/containers?topic=containers-cs_versions#version_types) de 30 à 45 jours. </li>
      <li><img src="images/logo_kubernetes.svg" alt="Icône Kubernetes" width="15" style="width:15px; border-style: none"/> <strong>Journal des modifications de version</strong> : Mise à jour des journaux de modifications pour les mises à jour de correctif de noeud worker [1.14.4_1526](/docs/containers?topic=containers-changelog#1144_1526_worker), [1.13.8_1529](/docs/containers?topic=containers-changelog#1138_1529_worker) et [1.12.10_1560](/docs/containers?topic=containers-changelog#11210_1560_worker). </li>
    <li><img src="images/logo_kubernetes.svg" alt="Icône Kubernetes" width="15" style="width:15px; border-style: none"/> <strong>Journal des modifications de version</strong> : [la version 1.11](/docs/containers?topic=containers-changelog#111_changelog) n'est pas prise en charge. </li></ul>
  </td>
</tr>
<tr>
  <td>19 juillet 2019</td>
  <td><img src="images/logo_openshift.svg" alt="Icône OpenShift" width="15" style="width:15px; border-style: none"/> <strong>Red Hat OpenShift on IBM Cloud</strong> : ajout de la [documentation Red Hat OpenShift on IBM Cloud dans un référentiel distinct](/docs/openshift?topic=openshift-getting-started). Etant donné que la logique {{site.data.keyword.containerlong_notm}} et l'infrastructure de cloud sous-jacente sont identiques, de nombreuses rubriques sont réutilisées dans la documentation sur les clusters Kubernetes de communauté et les clusters OpenShift, telles que cette rubrique de notes sur l'édition.</td>
</tr>
<tr>
  <td>17 juillet 2019</td>
  <td><strong>Journal des modifications de l'ALB Ingress</strong> : [Correction des vulnérabilités `rbash`](/docs/containers?topic=containers-cluster-add-ons-changelog#alb_changelog).
  </td>
</tr>
<tr>
  <td>15 juillet 2019</td>
  <td><ul>
  <li><img src="images/logo_kubernetes.svg" alt="Icône Kubernetes" width="15" style="width:15px; border-style: none"/> <strong>ID de noeud worker et de cluster</strong> : le format d'ID des clusters et des noeuds worker a été modifié. Les clusters et les noeuds worker existants conservent leurs ID existants. Si vous disposez d'une procédure d'automatisation qui repose sur le format précédent, mettez-la à jour pour les nouveaux clusters. <ul>
  <li>**ID de cluster** : au format regex `{a-v0-9}[7]{a-z0-9}[2]{a-v0-9}[11]`</li>
  <li>**ID de noeud worker** : au format `kube-<cluster_ID>-<cluster_name_truncated>-<resource_group_truncated>-<worker_ID>`</li></ul></li>
  <li><strong>Journal des modifications de l'ALB Ingress</strong> : mise à jour de l'image [`nginx-ingress` de l'ALB vers la génération 497](/docs/containers?topic=containers-cluster-add-ons-changelog#alb_changelog). </li>
  <li><strong>Traitement des incidents liés aux clusters</strong> : ajout d'[étapes de traitement des incidents](/docs/containers?topic=containers-cs_troubleshoot_clusters#cs_totp) à utiliser lorsque vous ne parvenez pas à gérer des clusters et des noeuds worker car l'option de code d'accès à usage unique est activée pour votre compte. </li>
  <li><img src="images/logo_kubernetes.svg" alt="Icône Kubernetes" width="15" style="width:15px; border-style: none"/> <strong>Journaux de modifications de version</strong> : mise à jour des journaux de modifications pour les mises à jour du groupe de correctifs de maître [1.14.4_1526](/docs/containers?topic=containers-changelog#1144_1526), [1.13.8_1529](/docs/containers?topic=containers-changelog#1138_1529) et [1.12.10_1560](/docs/containers?topic=containers-changelog#11210_1560). </li></ul>
  </td>
</tr>
<tr>
  <td>8 juillet 2019</td>
  <td><ul>
  <li><strong>Mise en réseau d'application</strong> : vous pouvez désormais trouver des informations sur la mise en réseau d'applications à l'aide de NLB et d'ALB Ingress sur les pages suivantes :
    <ul><li>[Equilibrage de charge de base et DSR à l'aide d'équilibreurs de charge de réseau (NLB)](/docs/containers?topic=containers-cs_sitemap#sitemap-nlb)</li>
    <li>[Equilibrage de charge HTTPS à l'aide d'équilibreurs de charge d'application Ingress](/docs/containers?topic=containers-cs_sitemap#sitemap-ingress)</li></ul>
  </li>
  <li><img src="images/logo_kubernetes.svg" alt="Icône Kubernetes" width="15" style="width:15px; border-style: none"/> <strong>Journaux de modifications de version</strong> : mise à jour des journaux de modifications pour les mises à jour de correctif de noeud worker [1.14.3_1525](/docs/containers?topic=containers-changelog#1143_1525), [1.13.7_1528](/docs/containers?topic=containers-changelog#1137_1528), [1.12.9_1559](/docs/containers?topic=containers-changelog#1129_1559) et [1.11.10_1564](/docs/containers?topic=containers-changelog#11110_1564). </li></ul>
  </td>
</tr>
<tr>
  <td>2 juillet 2019</td>
  <td><strong>Journal des modifications de l'interface de ligne de commande (CLI)</strong> : mise à jour de la page de journal des modifications du plug-in de l'interface de ligne de commande {{site.data.keyword.containerlong_notm}} pour l'[édition de la version 0.3.58](/docs/containers?topic=containers-cs_cli_changelog). </td>
</tr>
<tr>
  <td>1er juillet 2019</td>
  <td><ul>
  <li><strong>Droits d'infrastructure</strong> : mise à jour des [rôles d'infrastructure classique](/docs/containers?topic=containers-access_reference#infra) requis pour les cas d'utilisation courants. </li>
  <li><img src="images/logo_openshift.svg" alt="Icône OpenShift" width="15" style="width:15px; border-style: none"/> <strong>Foire aux questions sur OpenShift</strong> : développement de la [foire aux questions](/docs/containers?topic=containers-faqs#container_platforms) afin d'inclure des informations sur les clusters OpenShift. </li>
  <li><strong>Sécurisation des applications gérées par Istio à l'aide d'{{site.data.keyword.appid_short_notm}}</strong> : ajout d'informations sur l'[adaptateur App Identity and Access](/docs/containers?topic=containers-istio#app-id). </li>
  <li><strong>Service VPN strongSwan</strong> : si vous installez strongSwan dans un cluster à zones multiples et que vous utilisez le paramétrage `enableSingleSourceIP=true`, vous pouvez désormais [affecter la variable `%zoneSubnet` à `local.subnet` et utiliser `local.zoneSubnet` pour spécifier une adresse IP en tant que sous-réseau /32 pour chaque zone du cluster](/docs/containers?topic=containers-vpn#strongswan_4). </li>
  </ul></td>
</tr>
</tbody></table>


## Juin 2019
{: #jun19}

<table summary="Le tableau présente des notes sur l'édition. La lecture des lignes s'effectue de gauche à droite, avec la date dans la première colonne, l'intitulé de la fonction dans la deuxième colonne et une description dans la troisième colonne.">
<caption>Mises à jour de la documentation {{site.data.keyword.containerlong_notm}} apportées en juin 2019</caption>
<thead>
<th>Date</th>
<th>Description</th>
</thead>
<tbody>
<tr>
  <td>24 juin 2019</td>
  <td><ul>
  <li><strong>Règles réseau Calico</strong> : ajout d'un ensemble de [règles Calico publiques](/docs/containers?topic=containers-network_policies#isolate_workers_public) et développement de l'ensemble de [règles Calico privées](/docs/containers?topic=containers-network_policies#isolate_workers) afin de protéger votre cluster sur les réseaux publics et privés. </li>
  <li><strong>Journal des modifications de l'ALB Ingress</strong> : mise à jour de l'image `nginx-ingress` de l'[ALB vers la génération 477](/docs/containers?topic=containers-cluster-add-ons-changelog#alb_changelog). </li>
  <li><img src="images/logo_kubernetes.svg" alt="Icône Kubernetes" width="15" style="width:15px; border-style: none"/> <strong>Limitations de service</strong> : mise à jour de la [limite du nombre maximal de pods par noeud worker](/docs/containers?topic=containers-ibm-cloud-kubernetes-service-technology#tech_limits). Les noeuds worker qui exécutent Kubernetes 1.13.7_1527, 1.14.3_1524 ou plus et qui possèdent plus de 11 coeurs d'UC peuvent prendre en charge 10 pods par coeur, jusqu'à une limite de 250 pods par noeud worker.
</li>
  <li><img src="images/logo_kubernetes.svg" alt="Icône Kubernetes" width="15" style="width:15px; border-style: none"/> <strong>Journaux de modifications de version</strong> : ajout de journaux de modifications pour les mises à jour de correctif de noeud worker [1.14.3_1524](/docs/containers?topic=containers-changelog#1143_1524), [1.13.7_1527](/docs/containers?topic=containers-changelog#1137_1527), [1.12.9_1558](/docs/containers?topic=containers-changelog#1129_1558) et [1.11.10_1563](/docs/containers?topic=containers-changelog#11110_1563). </li>
  </ul></td>
</tr>
<tr>
  <td>21 juin 2019</td>
  <td><ul>
  <li><img src="images/logo_openshift.svg" alt="Icône OpenShift" width="15" style="width:15px; border-style: none"/> <strong>Accès aux clusters OpenShift</strong> : ajout d'étapes pour [l'automatisation de l'accès à un cluster OpenShift en utilisant un jeton de connexion OpenShift](/docs/containers?topic=containers-cs_cli_install#openshift_cluster_login). </li>
  <li><img src="images/logo_kubernetes.svg" alt="Icône Kubernetes" width="15" style="width:15px; border-style: none"/> <strong>Accès au maître Kubernetes via le noeud final de service privé</strong> : ajout d'étapes pour l'[édition du fichier de configuration Kubernetes local](/docs/containers?topic=containers-clusters#access_on_prem) lorsque les noeuds finaux de service public et de service privé sont activés, mais que vous souhaitez accéder au maître Kubernetes uniquement via le noeud final de service privé. </li>
  <li><img src="images/logo_openshift.svg" alt="Icône OpenShift" width="15" style="width:15px; border-style: none"/> <strong>Traitement des incidents liés aux clusters OpenShift</strong> : ajout d'une [section sur le traitement des incidents](/docs/openshift?topic=openshift-openshift_tutorial#openshift_troubleshoot) au tutoriel Création d'un cluster Red Hat OpenShift on IBM Cloud (bêta). </li>
  </ul></td>
</tr>
<tr>
  <td>18 juin 2019</td>
  <td><ul>
  <li><strong>Journal des modifications de l'interface de ligne de commande (CLI)</strong> : mise à jour de la page de journal des modifications du plug-in de l'interface de ligne de commande {{site.data.keyword.containerlong_notm}} pour l'[édition des versions 0.3.47 et 0.3.49](/docs/containers?topic=containers-cs_cli_changelog). </li>
  <li><strong>Journal des modifications de l'ALB Ingress</strong> : mise à jour de l'image `nginx-ingress` de l'[ALB vers la génération 473 et de l'image `ingress-auth` vers la génération 331](/docs/containers?topic=containers-cluster-add-ons-changelog#alb_changelog). </li>
  <li><strong>Versions de module complémentaire gérées</strong> : mise à jour de la version du module complémentaire géré par Istio vers 1.1.7 et du module complémentaire géré par Knative vers 0.6.0. </li>
  <li><strong>Retrait du stockage persistant</strong> : mise à jour des informations relatives à la façon dont vous êtes facturé lorsque vous [supprimez le stockage persistant](/docs/containers?topic=containers-cleanup). </li>
  <li><strong>Liaisons de service avec un noeud final privé</strong> : [ajout d'étapes](/docs/containers?topic=containers-service-binding) illustrant la création manuelle de données d'identification de service avec le noeud final de service privé lorsque vous liez le service à votre cluster. </li>
  <li><img src="images/logo_kubernetes.svg" alt="Icône Kubernetes" width="15" style="width:15px; border-style: none"/> <strong>Journaux de modifications de version</strong> : mise à jour des journaux de modifications pour les mises à jour de correctif [1.14.3_1523](/docs/containers?topic=containers-changelog#1143_1523), [1.13.7_1526](/docs/containers?topic=containers-changelog#1137_1526), [1.12.9_1557](/docs/containers?topic=containers-changelog#1129_1557) et [1.11.10_1562](/docs/containers?topic=containers-changelog#11110_1562). </li>
  </ul></td>
</tr>
<tr>
  <td>14 juin 2019</td>
  <td><ul>
  <li><strong>Traitement des incidents liés à `kubectl`</strong> : ajout d'une [rubrique de traitement des incidents](/docs/containers?topic=containers-cs_troubleshoot_clusters#kubectl_fails) à utiliser lorsque vous disposez d'une version client de `kubectl` qui diffère d'au moins deux niveaux par rapport à la version du serveur ou à la version OpenShift de `kubectl`, qui ne fonctionne pas avec les clusters Kubernetes de communauté. </li>
  <li><strong>Page d'arrivée des tutoriels</strong> : remplacement de la page de liens connexes par une nouvelle [page d'arrivée des tutoriels](/docs/containers?topic=containers-tutorials-ov) pour tous les tutoriels propres à {{site.data.keyword.containershort_notm}}. </li>
  <li><img src="images/logo_kubernetes.svg" alt="Icône Kubernetes" width="15" style="width:15px; border-style: none"/> <strong>Tutoriel relatif à la création d'un cluster et au déploiement d'une application</strong> : association des tutoriels relatifs à la création de clusters et au déploiement d'applications dans un [tutoriel](/docs/containers?topic=containers-cs_cluster_tutorial) complet. </li>
  <li><strong>Utilisation de sous-réseaux existants pour créer un cluster</strong> : pour [réutiliser des sous-réseaux à partir d'un cluster inutile lorsque vous créez un nouveau cluster](/docs/containers?topic=containers-subnets#subnets_custom), les sous-réseaux doivent être des sous-réseaux gérés par un utilisateur que vous avez ajoutés manuellement à partir d'un réseau sur site. Tous les sous-réseaux qui ont été automatiquement commandés lors de la création du cluster sont immédiatement supprimés après que vous avez supprimé ce cluster, et vous ne pouvez pas les réutiliser pour créer un nouveau cluster. </li>
  </ul></td>
</tr>
<tr>
  <td>12 juin 2019</td>
  <td><strong>Agrégation de rôles de cluster</strong> : ajout d'étapes pour l'[extension des droits existants des utilisateurs en agrégeant des rôles de cluster](/docs/containers?topic=containers-users#rbac_aggregate).</td>
</tr>
<tr>
  <td>7 juin 2019</td>
  <td><ul>
  <li><strong>Accès au maître Kubernetes via le noeud final de service privé</strong> : ajout d'[étapes](/docs/containers?topic=containers-clusters#access_on_prem) pour exposer le noeud final de service privé via un équilibreur de charge privé. Une fois que vous avez exécuté ces étapes, vos utilisateurs de cluster autorisés peuvent accéder au maître Kubernetes à partir d'une connexion VPN ou {{site.data.keyword.cloud_notm}} Direct Link.</li>
  <li><strong>{{site.data.keyword.BluDirectLink}}</strong> : Ajout de {{site.data.keyword.cloud_notm}} Direct Link aux pages [Connectivité VPN](/docs/containers?topic=containers-vpn) et [Cloud hybride](/docs/containers?topic=containers-hybrid_iks_icp) afin de pouvoir créer une connexion privée directe entre vos environnements de réseau distants et {{site.data.keyword.containerlong_notm}} sans routage sur l'Internet public.</li>
  <li><strong>Journal des modifications de l'ALB Ingress</strong> : Mise à jour de l'image `ingress-auth` de l'[ALB vers la génération 330](/docs/containers?topic=containers-cluster-add-ons-changelog#alb_changelog).</li>
  <li><img src="images/logo_openshift.svg" alt="Icône OpenShift" width="15" style="width:15px; border-style: none"/> <strong>Bêta OpenShift</strong> : [Ajout d'une leçon](/docs/openshift?topic=openshift-openshift_tutorial#openshift_logdna_sysdig) expliquant comment modifier des déploiements d'application pour des contraintes de contexte de sécurité privilégiées pour les modules complémentaires {{site.data.keyword.la_full_notm}} et {{site.data.keyword.mon_full_notm}}. </li>
  </ul></td>
</tr>
<tr>
  <td>6 juin 2019</td>
  <td><ul>
  <li><strong>Journal des modifications de Fluentd</strong> : Ajout d'un [journal des modifications version Fluentd](/docs/containers?topic=containers-cluster-add-ons-changelog#fluentd_changelog).</li>
  <li><strong>Journal des modifications de l'ALB Ingress</strong> : Mise à jour de l'image `nginx-ingress` de l'[ALB vers la génération 470](/docs/containers?topic=containers-cluster-add-ons-changelog#alb_changelog).</li>
  </ul></td>
</tr>
<tr>
  <td>5 juin 2019</td>
  <td><ul>
  <li><strong>Référence CLI</strong> : Mise à jour de la [page de référence CLI](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli) afin de refléter plusieurs modifications apportées à l'[édition de la version 0.3.34](/docs/containers?topic=containers-cs_cli_changelog) du plug-in CLI {{site.data.keyword.containerlong_notm}}.</li>
  <li><img src="images/logo_openshift.svg" alt="OpenShift icon" width="15" style="width:15px; border-style: none"/> <strong>Nouveau ! Clusters Red Hat OpenShift on IBM Cloud (bêta)</strong> : Avec la version bêta Red Hat OpenShift on IBM Cloud, vous pouvez créer des clusters {{site.data.keyword.containerlong_notm}} dotés de noeuds worker qui sont fournis installés avec le logiciel de plateforme d'orchestration de conteneur OpenShift. Vous bénéficiez de tous les avantages d'{{site.data.keyword.containerlong_notm}} géré pour votre environnement d'infrastructure de cluster tout en utilisant les [outils OpenShift et le catalogue ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://docs.openshift.com/container-platform/3.11/welcome/index.html) qui s'exécute sur Red Hat Enterprise Linux pour vos déploiements d'application. Pour commencer, voir [Tutoriel : Création d'un cluster Red Hat OpenShift on IBM Cloud (bêta)](/docs/openshift?topic=openshift-openshift_tutorial).</li>
  </ul></td>
</tr>
<tr>
  <td>4 juin 2019</td>
  <td><ul>
  <li><img src="images/logo_kubernetes.svg" alt="Icône Kubernetes" width="15" style="width:15px; border-style: none"/> <strong>Journaux de modifications de version</strong> : mise à jour des journaux de modifications pour les éditions de correctif [1.14.2_1521](/docs/containers?topic=containers-changelog#1142_1521), [1.13.6_1524](/docs/containers?topic=containers-changelog#1136_1524), [1.12.9_1555](/docs/containers?topic=containers-changelog#1129_1555) et [1.11.10_1561](/docs/containers?topic=containers-changelog#11110_1561). </li></ul>
  </td>
</tr>
<tr>
  <td>3 juin 2019</td>
  <td><ul>
  <li><strong>Utilisation de votre propre contrôleur Ingress</strong> : Mise à jour des [étapes](/docs/containers?topic=containers-ingress-user_managed) visant à répercuter les modifications apportées au contrôleur de communauté par défaut et à imposer un diagnostic d'intégrité pour les adresses IP de contrôleur dans des clusters à zones multiples.</li>
  <li><strong>{{site.data.keyword.cos_full_notm}}</strong> : Mise à jour des [étapes](/docs/containers?topic=containers-object_storage#install_cos) d'installation du plug-in {{site.data.keyword.cos_full_notm}} avec ou sans le serveur Helm, Tiller.</li>
  <li><strong>Journal des modifications de l'ALB Ingress</strong> : Mise à jour de l'image `nginx-ingress` de l'[ALB vers la génération 467](/docs/containers?topic=containers-cluster-add-ons-changelog#alb_changelog).</li>
  <li><strong>Kustomize</strong> : Ajout d'un exemple de [réutilisation des fichiers de configuration Kubernetes dans plusieurs environnements avec Kustomize](/docs/containers?topic=containers-app#kustomize).</li>
  <li><strong>Razee</strong> : Ajout de [Razee ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://github.com/razee-io/Razee) aux intégrations prises en charge afin de visualiser des informations de déploiement dans le cluster et d'automatiser le déploiement de ressources Kubernetes. </li></ul>
  </td>
</tr>
</tbody></table>


## Mai 2019
{: #may19}

<table summary="Le tableau présente des notes sur l'édition. La lecture des lignes s'effectue de gauche à droite, avec la date dans la première colonne, l'intitulé de la fonction dans la deuxième colonne et une description dans la troisième colonne.">
<caption>Mises à jour de la documentation {{site.data.keyword.containerlong_notm}} apportées en mai 2019</caption>
<thead>
<th>Date</th>
<th>Description</th>
</thead>
<tbody>
<tr>
  <td>30 mai 2019</td>
  <td><ul>
  <li><strong>Référence CLI</strong> : Mise à jour de la [page de référence CLI](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli) afin de refléter plusieurs modifications apportées à l'[édition de la version 0.3.33](/docs/containers?topic=containers-cs_cli_changelog) du plug-in CLI {{site.data.keyword.containerlong_notm}}.</li>
  <li><strong>Traitement des incidents liés au stockage</strong> : <ul>
  <li>Ajout d'une rubrique de traitement des incidents liés au stockage de fichiers et au stockage par blocs pour les [états de réservation de volume persistant en attente](/docs/containers?topic=containers-cs_troubleshoot_storage#file_pvc_pending).</li>
  <li>Ajout d'une rubrique de traitement des incidents liés au stockage par blocs traitant de l'impossibilité pour [une application d'accéder à une réservation de volume persistant ou d'écrire des données sur une réservation de volume persistant](/docs/containers?topic=containers-cs_troubleshoot_storage#block_app_failures).</li>
  </ul></li>
  </ul></td>
</tr>
<tr>
  <td>28 mai 2019</td>
  <td><ul>
  <li><strong>Journal des modifications de modules complémentaires de cluster</strong> : Mise à jour de l'image `nginx-ingress` de l'[ALB vers la génération 462](/docs/containers?topic=containers-cluster-add-ons-changelog).</li>
  <li><strong>Traitement des incidents liés au registre</strong> : Ajout d'une [rubrique de traitement des incidents](/docs/containers?topic=containers-cs_troubleshoot_clusters#ts_image_pull_create) traitant de l'impossibilité pour votre cluster d'extraire des images d'{{site.data.keyword.registryfull}} en raison d'une erreur lors de la création du cluster.
  </li>
  <li><strong>Traitement des incidents liés au stockage</strong> : <ul>
  <li>Ajout d'une rubrique de [débogage des échecs de stockage persistant](/docs/containers?topic=containers-cs_troubleshoot_storage#debug_storage).</li>
  <li>Ajout d'une rubrique de traitement des incidents liés aux [échecs de création de réservation de volume persistant en raison de droits manquants](/docs/containers?topic=containers-cs_troubleshoot_storage#missing_permissions).</li>
  </ul></li>
  </ul></td>
</tr>
<tr>
  <td>23 mai 2019</td>
  <td><ul>
  <li><strong>Référence CLI</strong> : Mise à jour de la [page de référence CLI](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli) afin de refléter plusieurs modifications apportées à l'[édition de la version 0.3.28](/docs/containers?topic=containers-cs_cli_changelog) du plug-in CLI {{site.data.keyword.containerlong_notm}}.</li>
  <li><strong>Journal des modifications de modules complémentaires de cluster</strong> : Mise à jour de l'image `nginx-ingress` de l'[ALB vers la génération 457](/docs/containers?topic=containers-cluster-add-ons-changelog).</li>
  <li><strong>Etats de cluster et de noeud worker</strong> : Mise à jour de la [page de journalisation et de surveillance](/docs/containers?topic=containers-health#states) avec l'ajout de tableaux de référence sur les états de cluster et de noeud worker.</li>
  <li><strong>Création et planification de cluster</strong> : Des informations sur la planification, la création et le retrait de cluster et sur la planification de réseau sont désormais disponibles sur les pages suivantes :
    <ul><li>[Planification d'une configuration de réseau pour votre cluster](/docs/containers?topic=containers-plan_clusters)</li>
    <li>[Planification de votre cluster pour la haute disponibilité](/docs/containers?topic=containers-ha_clusters)</li>
    <li>[Planification de la configuration de noeud worker](/docs/containers?topic=containers-planning_worker_nodes)</li>
    <li>[Création de clusters](/docs/containers?topic=containers-clusters)</li>
    <li>[Ajout de noeuds worker et de zones dans les clusters](/docs/containers?topic=containers-add_workers)</li>
    <li>[Suppression de clusters](/docs/containers?topic=containers-remove)</li>
    <li>[Modification des noeuds finaux de service ou des connexions VLAN](/docs/containers?topic=containers-cs_network_cluster)</li></ul>
  </li>
  <li><strong>Mises à jour de version de cluster</strong> : Mise à jour de la [politique de versions non prises en charge](/docs/containers?topic=containers-cs_versions) avec une remarque indiquant que vous ne pouvez pas mettre à jour des clusters si la version maître est antérieure d'au moins trois versions à la plus ancienne version prise en charge. Vous pouvez voir si le cluster n'est **pas pris en charge** en examinant la zone **Etat** lorsque vous répertoriez les clusters.</li>
  <li><strong>Istio</strong> : Mise à jour de la [page Istio](/docs/containers?topic=containers-istio) avec le retrait de la limitation selon laquelle Istio ne fonctionne pas dans des clusters qui sont connectés à un VLAN privé uniquement. Ajout d'une étape à la [rubrique Mise à jour des modules complémentaires gérés](/docs/containers?topic=containers-managed-addons#updating-managed-add-ons) afin de recréer des passerelles Istio qui utilisent des sections TLS une fois la mise à jour du module complémentaire géré Istio terminée.</li>
  <li><strong>Rubriques populaires</strong> : Remplacement des rubriques populaires par cette page de notes sur l'édition pour les nouvelles fonctions et les mises à jour qui sont propres à {{site.data.keyword.containershort_notm}}. Pour obtenir les dernières informations sur les produits {{site.data.keyword.cloud_notm}}, voir la page [Announcements](https://www.ibm.com/cloud/blog/announcements).</li>
  </ul></td>
</tr>
<tr>
  <td>20 mai 2019</td>
  <td><ul>
  <li><strong>Journaux de modifications de version</strong> : Ajout de [journaux de modifications pour les groupes de correctifs de noeud worker](/docs/containers?topic=containers-changelog).</li>
  </ul></td>
</tr>
<tr>
  <td>16 mai 2019</td>
  <td><ul>
  <li><strong>Référence CLI</strong> : Mise à jour de la [page de référence CLI](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli) afin d'ajouter des noeuds finaux COS pour les commandes `logging-collect` et de stipuler que `apiserver-refresh` redémarre les composants maître Kubernetes.</li>
  <li><strong>Non prise en charge : Kubernetes version 1.10</strong> : [Kubernetes version 1.10](/docs/containers?topic=containers-cs_versions#cs_v114) est désormais non pris en charge.</li>
  </ul></td>
</tr>
<tr>
  <td>15 mai 2019</td>
  <td><ul>
  <li><strong>Version Kubernetes par défaut</strong> : La version Kubernetes par défaut est désormais la version 1.13.6.</li>
  <li><strong>Limites de service</strong> : Ajout d'une [rubrique sur les limites de service](/docs/containers?topic=containers-ibm-cloud-kubernetes-service-technology#tech_limits).</li>
  </ul></td>
</tr>
<tr>
  <td>13 mai 2019</td>
  <td><ul>
  <li><strong>Journaux de modifications de version</strong> : Ajout d'informations stipulant que de nouvelles mises à jour de correctif sont disponibles pour les version [1.14.1_1518](/docs/containers?topic=containers-changelog#1141_1518), [1.13.6_1521](/docs/containers?topic=containers-changelog#1136_1521), [1.12.8_1552](/docs/containers?topic=containers-changelog#1128_1552), [1.11.10_1558](/docs/containers?topic=containers-changelog#11110_1558) et [1.10.13_1558](/docs/containers?topic=containers-changelog#11013_1558).</li>
  <li><strong>Versions de noeud worker</strong> : Retrait de toutes les [versions de noeud worker de machine virtuelle](/docs/containers?topic=containers-planning_worker_nodes#vm) avec au moins 48 coeurs par [statut de cloud ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://cloud.ibm.com/status?component=containers-kubernetes&selected=status). Vous pouvez tout de même mettre à disposition des [noeuds worker bare metal](/docs/containers?topic=containers-plan_clusters#bm) avec au moins 48 coeurs.</li></ul></td>
</tr>
<tr>
  <td>8 mai 2019</td>
  <td><ul>
  <li><strong>API</strong> : Ajout d'un lien vers la [documentation swagger d'API globale ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://containers.cloud.ibm.com/global/swagger-global-api/#/).</li>
  <li><strong>Stockage d'objets Cloud</strong> : [Ajout d'un guide de traitement des incidents liés au stockage d'objets Cloud](/docs/containers?topic=containers-cs_troubleshoot_storage#cos_pvc_pending) dans vos clusters {{site.data.keyword.containerlong_notm}}.</li>
  <li><strong>Stratégie Kubernetes</strong> : Ajout d'une rubrique décrivant les [connaissances et les compétences techniques qu'il est recommandé de posséder avant de déplacer ses applications vers {{site.data.keyword.containerlong_notm}}?](/docs/containers?topic=containers-strategy#knowledge).</li>
  <li><strong>Kubernetes version 1.14</strong> : Ajout d'une remarque stipulant que l'[édition 1.14 de Kubernetes](/docs/containers?topic=containers-cs_versions#cs_v114) est certifiée.</li>
  <li><strong>Rubriques de référence</strong> : Mise à jour d'informations pour différentes opérations de liaison de service, de `consignation` et `nlb` sur la pages de référence [d'accès utilisateur](/docs/containers?topic=containers-access_reference) et [CLI](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli).</li></ul></td>
</tr>
<tr>
  <td>7 mai 2019</td>
  <td><ul>
  <li><strong>Fournisseur DNS de cluster</strong> : [Description des avantages de CoreDNS](/docs/containers?topic=containers-cluster_dns) maintenant que les clusters qui exécutent Kubernetes 1.14 et plus prennent en charge uniquement CoreDNS.</li>
  <li><strong>Noeuds de périphérie</strong> : Ajout d'une prise en charge d'équilibreur de charge privé pour des [noeuds de périphérie](/docs/containers?topic=containers-edge).</li>
  <li><strong>Clusters gratuits</strong> : Précision des emplacements où les [clusters gratuits](/docs/containers?topic=containers-regions-and-zones#regions_free) sont pris en charge.</li>
  <li><strong>Nouveau ! Intégrations</strong> : ajout et restructuration d'informations sur les [services et les intégrations tierces {{site.data.keyword.cloud_notm}} ](/docs/containers?topic=containers-ibm-3rd-party-integrations), les [intégrations populaires](/docs/containers?topic=containers-supported_integrations) et les [partenariats](/docs/containers?topic=containers-service-partners). </li>
  <li><strong>Nouveau ! Kubernetes version 1.14</strong> : Créez ou mettez à jour vos clusters vers [Kubernetes 1.14](/docs/containers?topic=containers-cs_versions#cs_v114).</li>
  <li><strong>Dépréciation de Kubernetes version 1.11</strong> : [Mettez à jour](/docs/containers?topic=containers-update) les clusters qui exécutent [Kubernetes 1.11](/docs/containers?topic=containers-cs_versions#cs_v111) avant qu'ils ne soient plus pris en charge.</li>
  <li><strong>Droits</strong> : Ajout d'une questions à la foire aux questions, [Quelles politiques d'accès dois-je fournir à mes utilisateurs de cluster ?](/docs/containers?topic=containers-faqs#faq_access)</li>
  <li><strong>Pools de noeuds worker</strong> : Ajout d'instructions expliquant comment [appliquer des libellés à des pools de noeuds worker existants](/docs/containers?topic=containers-add_workers#worker_pool_labels).</li>
  <li><strong>Rubriques de référence</strong> : Mise à jour de pages de référence [Journal des modifications](/docs/containers?topic=containers-changelog#changelog) pour la prise en charge de nouvelles fonctions, telles que Kubernetes 1.14.</li></ul></td>
</tr>
<tr>
  <td>1 mai 2019</td>
  <td><strong>Affectation d'un accès d'infrastructure</strong> : Révision des [étapes permettant d'affecter des droits IAM pour l'ouverture de cas de support](/docs/containers?topic=containers-users#infra_access).</td>
</tr>
</tbody></table>


