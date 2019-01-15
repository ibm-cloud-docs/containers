---

copyright:
  years: 2014, 2018
lastupdated: "2018-12-06"

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




# Rubriques les plus consultées pour {{site.data.keyword.containerlong_notm}}
{: #cs_popular_topics}

Tenez-vous au courant de ce qui se passe dans {{site.data.keyword.containerlong}}. Découvrez les nouvelles fonctions à explorer, une astuce pour les expérimenter ou quelques rubriques populaires que d'autres développeurs jugent désormais utiles.
{:shortdesc}

## Rubriques les plus consultées en décembre 2018
{: #dec18}

<table summary="Ce tableau présente les rubriques les plus consultées. La lecture des lignes s'effectue de gauche à droite, avec la date indiquée dans la première colonne, le titre de la fonction dans la deuxième colonne et la description dans la troisième colonne.">
<caption>Rubriques les plus consultées pour les conteneurs et les clusters Kubernetes en décembre 2018</caption>
<thead>
<th>Date</th>
<th>Titre</th>
<th>Description</th>
</thead>
<tbody>
<tr>
<td>6 décembre</td>
<td>{{site.data.keyword.mon_full_notm}}</td>
<td>Gagnez en visibilité opérationnelle sur les performances et l'état de santé de vos applications en déployant Sysdig en tant que service tiers sur vos noeuds worker pour transférer des métriques à {{site.data.keyword.monitoringlong}}. Pour plus d'informations, voir [Analyzing metrics for an app that is deployed in a Kubernetes cluster](/docs/services/Monitoring-with-Sysdig/tutorials/kubernetes_cluster.html#kubernetes_cluster). **Remarque** : si vous utilisez {{site.data.keyword.mon_full_notm}} avec des clusters exécutant Kubernetes version 1.11 ou ultérieure, toutes les métriques ne sont pas collectées car Sysdig ne prend pas en charge `containerd` actuellement.</td>
</tr>
</tbody></table>

## Rubriques les plus consultées en novembre 2018
{: #nov18}

<table summary="Ce tableau présente les rubriques les plus consultées. La lecture des lignes s'effectue de gauche à droite, avec la date indiquée dans la première colonne, le titre de la fonction dans la deuxième colonne et la description dans la troisième colonne.">
<caption>Rubriques les plus consultées pour les conteneurs et les clusters Kubernetes en novembre 2018</caption>
<thead>
<th>Date</th>
<th>Titre</th>
<th>Description</th>
</thead>
<tbody>
<tr>
<td>29 novembre</td>
<td>[Zone disponible dans Chennai](cs_regions.html)</td>
<td>Bienvenue à Chennai en Inde, une nouvelle zone pour les clusters dans la zone Asie-Pacifique nord. Si vous disposez d'un pare-feu, veillez à [ouvrir les ports de pare-feu](cs_firewall.html#firewall) correspondant à cette zone et aux autres zones situées dans la région où se trouve votre cluster.</td>
</tr>
<tr>
<td>27 novembre</td>
<td>{{site.data.keyword.la_full_notm}}</td>
<td>Ajoutez des fonctionnalités de gestion de journaux à votre cluster en déployant LogDNA en tant que service tiers sur vos noeuds worker afin de gérer les journaux à partir de vos conteneurs de pod. Pour plus d'informations, voir [Managing Kubernetes cluster logs with {{site.data.keyword.loganalysisfull_notm}} with LogDNA](/docs/services/Log-Analysis-with-LogDNA/tutorials/kube.html#kube).</td>
</tr>
<tr>
<td>7 novembre</td>
<td>Equilibreur de charge 2.0 (bêta)</td>
<td>Vous pouvez désormais choisir entre un [équilibreur de charge 1.0 ou 2.0](cs_loadbalancer.html#planning_ipvs) pour exposer vos applications de cluster au public de manière sécurisée.</td>
</tr>
<tr>
<td>7 novembre</td>
<td>La version Kubernetes 1.12 est disponible</td>
<td>Désormais, vous pouvez mettre à jour ou créer des clusters exécutant [Kubernetes version 1.12](cs_versions.html#cs_v112). Par défaut, les clusters 1.12 sont fournis avec des maîtres Kubernetes à haute disponibilité.</td>
</tr>
<tr>
<td>7 novembre</td>
<td>Maîtres à haute disponibilité dans les clusters exécutant Kubernetes version 1.10</td>
<td>Des maîtres à haute disponibilité sont disponibles pour les clusters qui exécutent Kubernetes version 1.10. Tous les avantages décrits dans l'entrée précédente pour les clusters 1.11 s'appliquent aux clusters 1.10, ainsi que les [étapes de préparation](cs_versions.html#110_ha-masters) que vous devez suivre.</td>
</tr>
<tr>
<td>1er novembre</td>
<td>Maîtres à haute disponibilité dans les clusters exécutant Kubernetes version 1.11</td>
<td>Dans une zone unique, votre maître est hautement disponible et comprend des répliques sur des hôtes physiques distincts pour le serveur d'API Kubernetes, le composant etcd, le planificateur et le gestionnaire de contrôleurs afin de les protéger en cas d'indisponibilité due par exemple à une mise à jour de cluster. Si votre cluster se trouve dans une zone compatible avec plusieurs zones, votre maître à haute disponibilité est également réparti sur plusieurs zones pour le protéger en cas de défaillance d'une zone.<br>Pour connaître les actions que vous devez effectuer, voir [Mise à jour des maîtres de cluster pour la haute disponibilité](cs_versions.html#ha-masters). Ces actions de préparation sont applicables dans les cas suivants :<ul>
<li>Si vous disposez d'un pare-feu ou de règles réseau Calico personnalisées.</li>
<li>Si vous utilisez les ports d'hôte `2040` ou `2041` sur vos noeuds worker.</li>
<li>Si vous avez utilisé l'adresse IP du noeud maître du cluster pour accéder au maître depuis le cluster.</li>
<li>Si vous disposez d'un processus automatique pour appeler l'API ou l'interface de ligne de commande Calico (`calicoctl`), par exemple pour créer des règles Calico.</li>
<li>Si vous utilisez des règles réseau Kubernetes ou Calico pour contrôler l'accès du trafic sortant du pod vers le maître.</li></ul></td>
</tr>
</tbody></table>

## Rubriques les plus consultées en octobre 2018
{: #oct18}

<table summary="Ce tableau présente les rubriques les plus consultées. La lecture des lignes s'effectue de gauche à droite, avec la date indiquée dans la première colonne, le titre de la fonction dans la deuxième colonne et la description dans la troisième colonne.">
<caption>Rubriques les plus consultées pour les conteneurs et les clusters Kubernetes en octobre 2018</caption>
<thead>
<th>Date</th>
<th>Titre</th>
<th>Description</th>
</thead>
<tbody>
<tr>
<td>25 octobre</td>
<td>[Zone disponible à Milan](cs_regions.html)</td>
<td>Bienvenue à Milan en Italie, une nouvelle zone pour les clusters payants dans la région Europe centrale. Auparavant, Milan n'était disponible que pour les clusters gratuits. Si vous disposez d'un pare-feu, veillez à [ouvrir les ports de pare-feu](cs_firewall.html#firewall) correspondant à cette zone et aux autres zones situées dans la région où se trouve votre cluster.</td>
</tr>
<tr>
<td>22 octobre</td>
<td>[Nouvel emplacement à zones multiples pour Londres, `lon05`](cs_regions.html#zones)</td>
<td>La métropole de Londres à zones multiples remplace la zone `lon02` par la nouvelle zone `lon05` qui comporte plus de ressources d'infrastructure que `lon02`. Créez des clusters à zones multiples dans `lon05`. Les clusters existants de la zone `lon02` sont pris en charge mais les nouveaux clusters à zones multiples doivent dorénavant utiliser `lon05`.</td>
</tr>
<tr>
<td>5 octobre</td>
<td>Intégration avec {{site.data.keyword.keymanagementservicefull}}</td>
<td>Vous pouvez chiffrer les valeurs confidentielles (secrets) Kubernetes dans votre cluster en [activant {{site.data.keyword.keymanagementserviceshort}} (bêta)](cs_encrypt.html#keyprotect).</td>
</tr>
<tr>
<td>4 octobre</td>
<td>[{{site.data.keyword.registrylong}} est désormais intégré à {{site.data.keyword.Bluemix_notm}} Identity and Access Management (IAM)](/docs/services/Registry/iam.html#iam)</td>
<td>Vous pouvez utiliser {{site.data.keyword.Bluemix_notm}} IAM pour contrôler l'accès aux ressources de votre registre, par exemple pour extraire, envoyer et générer des images. Lorsque vous créez un cluster, vous créez également un jeton de registre pour que le cluster puisse utiliser votre registre. Par conséquent, vous avez besoin du rôle de gestion de plateforme **Administrateur** du registre au niveau du compte pour créer un cluster. Pour activer {{site.data.keyword.Bluemix_notm}} IAM pour le compte de votre registre, voir la rubrique sur l'[activation de l'application des règles aux utilisateurs existants](/docs/services/Registry/registry_users.html#existing_users).</td>
</tr>
<tr>
<td>1er octobre</td>
<td>[Groupes de ressources](cs_users.html#resource_groups)</td>
<td>Vous pouvez utiliser des groupes de ressources pour séparer vos ressources {{site.data.keyword.Bluemix_notm}} en pipelines, services ou autres regroupements pour faciliter l'affectation d'accès et les mesures du niveau d'utilisation. Désormais, {{site.data.keyword.containerlong_notm}} prend en charge la création de clusters dans le groupe `default` ou tout autre groupe de ressources que vous créez.</td>
</tr>
</tbody></table>

## Rubriques les plus consultées en septembre 2018
{: #sept18}

<table summary="Ce tableau présente les rubriques les plus consultées. La lecture des lignes s'effectue de gauche à droite, avec la date indiquée dans la première colonne, le titre de la fonction dans la deuxième colonne et la description dans la troisième colonne.">
<caption>Rubriques les plus consultées pour les conteneurs et les clusters Kubernetes en septembre 2018</caption>
<thead>
<th>Date</th>
<th>Titre</th>
<th>Description</th>
</thead>
<tbody>
<tr>
<td>25 septembre</td>
<td>[Nouvelles zones disponibles](cs_regions.html)</td>
<td>Vous disposez désormais d'autres options pour les zones de déploiement de vos applications.
<ul><li>Bienvenue à San José, avec deux nouvelles zones dans la région Sud des Etats-Unis, `sjc03` et `sjc04`. Si vous disposez d'un pare-feu, veillez à [ouvrir les ports de pare-feu](cs_firewall.html#firewall) correspondant à cette zone et aux autres zones situées dans la région où se trouve votre cluster.</li>
<li>Avec deux nouvelles zones `tok04` et `tok05`, vous pouvez désormais [créer des clusters à zones multiples](cs_clusters_planning.html#multizone) à Tokyo dans la région Asie-Pacifique nord.</li></ul></td>
</tr>
<tr>
<td>5 septembre</td>
<td>[Zone disponible à Oslo](cs_regions.html)</td>
<td>Bienvenue à Oslo en Norvège, une nouvelle zone dans la région Europe centrale. Si vous disposez d'un pare-feu, veillez à [ouvrir les ports de pare-feu](cs_firewall.html#firewall) correspondant à cette zone et aux autres zones situées dans la région où se trouve votre cluster.</td>
</tr>
</tbody></table>

## Rubriques les plus consultées en août 2018
{: #aug18}

<table summary="Ce tableau présente les rubriques les plus consultées. La lecture des lignes s'effectue de gauche à droite, avec la date indiquée dans la première colonne, le titre de la fonction dans la deuxième colonne et la description dans la troisième colonne.">
<caption>Rubriques les plus consultées pour les conteneurs et les clusters Kubernetes en août 2018</caption>
<thead>
<th>Date</th>
<th>Titre</th>
<th>Description</th>
</thead>
<tbody>
<tr>
<td>31 août</td>
<td>{{site.data.keyword.cos_full_notm}} est désormais intégré avec {{site.data.keyword.containerlong}}</td>
<td>Utilisez des réservations de volume persistant (PVC) Kubernetes natives pour mettre à disposition {{site.data.keyword.cos_full_notm}} dans votre cluster. {{site.data.keyword.cos_full_notm}} convient le mieux aux charges de travail à lecture intensive et pour le stockage de données sur plusieurs zones dans un cluster à zones multiples. Commencez par [créer une instance de service {{site.data.keyword.cos_full_notm}}](cs_storage_cos.html#create_cos_service) et [installer le plug-in {{site.data.keyword.cos_full_notm}}](cs_storage_cos.html#install_cos) dans votre cluster. </br></br>Vous n'êtes pas certain de la solution de stockage qui vous convient le mieux ? Commencez [ici](cs_storage_planning.html#choose_storage_solution) pour analyser vos données et choisir la solution de stockage appropriée pour vos données. </td>
</tr>
<tr>
<td>14 août</td>
<td>Mettez à jour vos cluster avec Kubernetes version 1.11 pour affecter des priorités aux pods</td>
<td>Après avoir mis à jour votre cluster vers [Kubernetes version 1.11](cs_versions.html#cs_v111), vous pouvez tirer parti des nouvelles fonctions, telles que des performances d'environnement d'exécution de conteneur accrues avec `containerd` ou l'[affectation de priorité aux pods](cs_pod_priority.html#pod_priority).</td>
</tr>
</tbody></table>

## Rubriques les plus consultées en juillet 2018
{: #july18}

<table summary="Ce tableau présente les rubriques les plus consultées. La lecture des lignes s'effectue de gauche à droite, avec la date indiquée dans la première colonne, le titre de la fonction dans la deuxième colonne et la description dans la troisième colonne.">
<caption>Rubriques les plus consultées pour les conteneurs et les clusters Kubernetes en juillet 2018</caption>
<thead>
<th>Date</th>
<th>Titre</th>
<th>Description</th>
</thead>
<tbody>
<tr>
<td>30 juillet</td>
<td>[Fournissez votre propre contrôleur Ingress](cs_ingress.html#user_managed)</td>
<td>Vous avez des exigences spécifiques en matière de sécurité ou d'autres exigences particulières pour le contrôleur Ingress de votre cluster ? Dans ce cas, vous pouvez envisager d'exécuter votre propre contrôleur Ingress au lieu du contrôleur par défaut.</td>
</tr>
<tr>
<td>10 juillet</td>
<td>Introduction des clusters à zones multiples</td>
<td>Vous voulez améliorer la disponibilité de votre cluster ? Vous pouvez désormais étendre votre cluster dans plusieurs zones de certaines régions métropolitaines. Pour plus d'informations, voir [Création de clusters à zones multiples dans {{site.data.keyword.containerlong_notm}}](cs_clusters_planning.html#multizone).</td>
</tr>
</tbody></table>

## Rubriques les plus consultées en juin 2018
{: #june18}

<table summary="Ce tableau présente les rubriques les plus consultées. La lecture des lignes s'effectue de gauche à droite, avec la date indiquée dans la première colonne, le titre de la fonction dans la deuxième colonne et la description dans la troisième colonne.">
<caption>Rubriques les plus consultées pour les conteneurs et les clusters Kubernetes en juin 2018</caption>
<thead>
<th>Date</th>
<th>Titre</th>
<th>Description</th>
</thead>
<tbody>
<tr>
<td>13 juin</td>
<td>Le nom de la commande `bx` de l'interface de ligne de commande a été remplacé par `ic`</td>
<td>Lorsque vous téléchargez la version la plus récente de l'interface de ligne de commande (CLI) d'{{site.data.keyword.Bluemix_notm}}, vous exécutez désormais les commandes en utilisant le préfixe `ic` au lieu de `bx`. Par exemple, pour afficher la liste de vos clusters, vous exécutez la commande `ibmcloud ks clusters`.</td>
</tr>
<tr>
<td>12 juin</td>
<td>[Politiques de sécurité de pod](cs_psp.html)</td>
<td>Pour les clusters exécutant Kubernetes version 1.10.3 ou ultérieur, vous pouvez
configurer des politiques de sécurité de pod pour autoriser certaines personnes à créer et mettre à jour des pods dans {{site.data.keyword.containerlong_notm}}.</td>
</tr>
<tr>
<td>6 juin</td>
<td>[Prise en charge de TLS pour le sous-domaine générique Ingress fourni par IBM](cs_ingress.html#wildcard_tls)</td>
<td>Pour les clusters créés à partir du 6 juin 2018, le certificat TLS du sous-domaine Ingress fourni par IBM est désormais un certificat générique pouvant être utilisé pour le sous-domaine générique enregistré. Pour les clusters créés avant le 6 juin 2018, le certificat TLS sera mis à jour et remplacé par un certificat générique lors du renouvellement du certificat TLS utilisé actuellement.</td>
</tr>
</tbody></table>

## Rubriques les plus consultées en mai 2018
{: #may18}


<table summary="Ce tableau présente les rubriques les plus consultées. La lecture des lignes s'effectue de gauche à droite, avec la date indiquée dans la première colonne, le titre de la fonction dans la deuxième colonne et la description dans la troisième colonne.">
<caption>Rubriques les plus consultées pour les conteneurs et les clusters Kubernetes en mai 2018</caption>
<thead>
<th>Date</th>
<th>Titre</th>
<th>Description</th>
</thead>
<tbody>
<tr>
<td>24 mai</td>
<td>[Nouveau format de sous-domaine Ingress](cs_ingress.html)</td>
<td>Les clusters créés après le 24 mai ont un domaine Ingress qui leur est affecté dans un nouveau format : <code>&lt;cluster_name&gt;.&lt;region&gt;.containers.appdomain.cloud</code>. Lorsque vous utilisez Ingress pour exposer vos applications, vous pouvez recourir au nouveau sous-domaine pour accéder à vos applications sur Internet.</td>
</tr>
<tr>
<td>14 mai</td>
<td>[Mise à jour : déployez vos charges de travail sur des unités bare metal GPU dans le monde entier](cs_app.html#gpu_app)</td>
<td>Si vous disposez d'un [type de machine d'unité de traitement graphique (GPU)](cs_clusters_planning.html#shared_dedicated_node) dans votre cluster, vous pouvez planifier des applications nécessitant de nombreux calculs mathématiques. Le noeud worker GPU peut traiter la charge de travail de votre application à la fois sur l'unité centrale (UC) et le processeur graphique (GPU) pour améliorer les performances.</td>
</tr>
<tr>
<td>3 mai</td>
<td>[Container Image Security Enforcement (bêta)](/docs/services/Registry/registry_security_enforce.html#security_enforce)</td>
<td>Besoin d'aide supplémentaire pour votre équipe pour savoir quelle image extraire dans vos conteneurs d'application ? Essayez la version bêta de Container Image Security Enforcement pour vérifier les images de conteneur avant de les déployer. Disponible pour les clusters exécutant Kubernetes 1.9 ou version ultérieure.</td>
</tr>
<tr>
<td>1er mai</td>
<td>[Déploiement du tableau de bord Kubernetes à partir de la console](cs_app.html#cli_dashboard)</td>
<td>Avez-vous déjà envisagé de pouvoir accéder au tableau de bord Kubernetes d'un seul clic ? Vérifiez la présence du bouton **Tableau de bord Kubernetes** dans la console {{site.data.keyword.Bluemix_notm}}.</td>
</tr>
</tbody></table>




## Rubriques les plus consultées en avril 2018
{: #apr18}

<table summary="Ce tableau présente les rubriques les plus consultées. La lecture des lignes s'effectue de gauche à droite, avec la date indiquée dans la première colonne, le titre de la fonction dans la deuxième colonne et la description dans la troisième colonne.">
<caption>Rubriques les plus consultées pour les conteneurs et les clusters Kubernetes en avril 2018</caption>
<thead>
<th>Date</th>
<th>Titre</th>
<th>Description</th>
</thead>
<tbody>
<tr>
<td>17 avril</td>
<td>{{site.data.keyword.Bluemix_notm}} Block Storage</td>
<td>Installez le [plug-in](cs_storage_block.html#install_block) {{site.data.keyword.Bluemix_notm}} Block Storage pour sauvegarder des données persistantes dans du stockage par blocs. Ensuite, vous pouvez [créer](cs_storage_block.html#add_block) ou [utiliser du stockage par blocs existant](cs_storage_block.html#existing_block) pour votre cluster.</td>
</tr>
<tr>
<td>13 avril</td>
<td>[Nouveau tutoriel pour la migration d'applications Cloud Foundry dans des clusters](cs_tutorials_cf.html#cf_tutorial)</td>
<td>Vous disposez d'une application Cloud Foundry ? Découvrez comment déployer le même code de cette application dans un conteneur qui s'exécute dans un cluster Kubernetes.</td>
</tr>
<tr>
<td>5 avril</td>
<td>[Filtrage des journaux](cs_health.html#filter-logs)</td>
<td>Filtrez des journaux spécifiques pour empêcher leur transfert. Les journaux peuvent être filtrés pour un espace de nom, un nom de conteneur, un niveau de consignation et une chaîne de message spécifiques.</td>
</tr>
</tbody></table>

## Rubriques les plus consultées en mars 2018
{: #mar18}

<table summary="Ce tableau présente les rubriques les plus consultées. La lecture des lignes s'effectue de gauche à droite, avec la date indiquée dans la première colonne, le titre de la fonction dans la deuxième colonne et la description dans la troisième colonne.">
<caption>Rubriques les plus consultées pour les conteneurs et les clusters Kubernetes en mars 2018</caption>
<thead>
<th>Date</th>
<th>Titre</th>
<th>Description</th>
</thead>
<tbody>
<tr>
<td>16 mars</td>
<td>[Mise à disposition d'un cluster bare metal avec calcul sécurisé](cs_clusters_planning.html#shared_dedicated_node)</td>
<td>Créez un cluster bare metal qui exécute [Kubernetes version 1.9](cs_versions.html#cs_v19) ou ultérieure et activez la fonction de calcul sécurisé pour vérifier que vos noeuds worker ne font pas l'objet de falsification.</td>
</tr>
<tr>
<td>14 mars</td>
<td>[Connexion sécurisée avec {{site.data.keyword.appid_full}}](cs_integrations.html#appid)</td>
<td>Améliorez vos applications qui s'exécutent dans {{site.data.keyword.containerlong_notm}} en obligeant les utilisateurs à se connecter.</td>
</tr>
<tr>
<td>13 mars</td>
<td>[Zone disponible à São Paulo](cs_regions.html)</td>
<td>Bienvenue à São Paulo au Brésil, nouvelle zone intégrée dans la région Sud des Etats-Unis. Si vous disposez d'un pare-feu, veillez à [ouvrir les ports de pare-feu](cs_firewall.html#firewall) correspondant à cette zone et aux autres zones situées dans la région où se trouve votre cluster.</td>
</tr>
<tr>
<td>12 mars</td>
<td>[Vous venez juste de rejoindre {{site.data.keyword.Bluemix_notm}} avec un compte d'essai ? Essayez gratuitement un cluster Kubernetes !](container_index.html#clusters)</td>
<td>Avec un [compte d'essai {{site.data.keyword.Bluemix_notm}}](https://console.bluemix.net/registration/), vous pouvez déployer un cluster gratuit pendant 30 jours pour expérimenter les fonctions de Kubernetes.</td>
</tr>
</tbody></table>

## Rubriques les plus consultées en février 2018
{: #feb18}

<table summary="Ce tableau présente les rubriques les plus consultées. La lecture des lignes s'effectue de gauche à droite, avec la date indiquée dans la première colonne, le titre de la fonction dans la deuxième colonne et la description dans la troisième colonne.">
<caption>Rubriques les plus consultées pour les conteneurs et les clusters Kubernetes en février 2018</caption>
<thead>
<th>Date</th>
<th>Titre</th>
<th>Description</th>
</thead>
<tbody>
<tr>
<td>27 février</td>
<td>Images HVM (Hardware virtual machine) pour les noeuds worker</td>
<td>Améliorez les performances d'E-S de vos charges de travail avec des images HVM. Activez cette fonction sur chaque noeud worker en place à l'aide de la [commande](cs_cli_reference.html#cs_worker_reload) `ibmcloud ks worker-reload` ou de la [commande](cs_cli_reference.html#cs_worker_update) `ibmcloud ks worker-update`.</td>
</tr>
<tr>
<td>26 février</td>
<td>[Mise à l'échelle automatique avec KubeDNS](https://kubernetes.io/docs/tasks/administer-cluster/dns-horizontal-autoscaling/)</td>
<td>KubeDNS s'adapte désormais à l'évolution de votre cluster. Vous pouvez ajuster les ratios de mise à l'échelle à l'aide de la commande : `kubectl -n kube-system edit cm kube-dns-autoscaler`.</td>
</tr>
<tr>
<td>23 février</td>
<td>Affichage de la console Web pour la [consignation](cs_health.html#view_logs) et les [métriques](cs_health.html#view_metrics)</td>
<td>Affichez facilement les données des journaux et des métriques sur votre cluster et ses composants avec une interface utilisateur Web améliorée. Consultez la page des détails de votre cluster pour savoir comment y accéder.</td>
</tr>
<tr>
<td>20 février</td>
<td>Images chiffrées et [contenu sécurisé, signé](../services/Registry/registry_trusted_content.html#registry_trustedcontent)</td>
<td>Dans {{site.data.keyword.registryshort_notm}}, vous pouvez signer et chiffrer des images pour assurer leur intégrité lorsque vous les stockez dans votre espace de nom de registre. Exécutez vos instances de conteneur en utilisant uniquement du contenu sécurisé.</td>
</tr>
<tr>
<td>19 février</td>
<td>[Configuration du VPN IPSec strongSwan](cs_vpn.html#vpn-setup)</td>
<td>Déployez rapidement la charte Helm du VPN IPSec strongSwan pour connecter votre cluster {{site.data.keyword.containerlong_notm}} de manière sécurisée à votre centre de données sur site sans dispositif de routeur virtuel (VRA).</td>
</tr>
<tr>
<td>14 février</td>
<td>[Zone disponible à Séoul](cs_regions.html)</td>
<td>Juste au bon moment pour les Jeux Olympiques, déployez un cluster Kubernetes à Séoul dans la région Asie-Pacifique nord. Si vous disposez d'un pare-feu, veillez à [ouvrir les ports de pare-feu](cs_firewall.html#firewall) correspondant à cette zone et aux autres zones situées dans la région où se trouve votre cluster.</td>
</tr>
<tr>
<td>8 février</td>
<td>[Mise à jour vers Kubernetes 1.9](cs_versions.html#cs_v19)</td>
<td>Examinez les modifications à apporter à vos clusters avant d'effectuer la mise à jour vers Kubernetes 1.9.</td>
</tr>
</tbody></table>

## Rubriques les plus consultées en janvier 2018
{: #jan18}

<table summary="Ce tableau présente les rubriques les plus consultées. La lecture des lignes s'effectue de gauche à droite, avec la date indiquée dans la première colonne, le titre de la fonction dans la deuxième colonne et la description dans la troisième colonne.">
<caption>Rubriques les plus consultées pour les conteneurs et les clusters Kubernetes en janvier 2018</caption>
<thead>
<th>Date</th>
<th>Titre</th>
<th>Description</th>
</thead>
<tbody>
<td>25 janvier</td>
<td>[Registre global disponible](../services/Registry/registry_overview.html#registry_regions)</td>
<td>Avec le registre {{site.data.keyword.registryshort_notm}}, vous pouvez utiliser le registre global `registry.bluemix.net` pour extraire les images publiques fournies par IBM.</td>
</tr>
<tr>
<td>23 janvier</td>
<td>[Zones disponibles à Singapour et Montréal (Canada)](cs_regions.html)</td>
<td>Singapour et Montréal sont les zones disponibles dans les régions {{site.data.keyword.containerlong_notm}} Asie-Pacifique nord et Est des Etats-Unis. Si vous disposez d'un pare-feu, veillez à [ouvrir les ports de pare-feu](cs_firewall.html#firewall) correspondant à ces zones et aux autres zones situées dans la région où se trouve votre cluster.</td>
</tr>
<tr>
<td>8 janvier</td>
<td>[Versions disponibles améliorées](cs_cli_reference.html#cs_machine_types)</td>
<td>Les types de machine virtuelle de la série 2 comprennent du stockage SSD et le chiffrement de disque. [Déplacez vos charges de travail](cs_cluster_update.html#machine_type) sur ces versions pour améliorer les performances et la stabilité.</td>
</tr>
</tbody></table>

## Discussion avec des développeurs partageant les mêmes idées sur Slack
{: #slack}

Vous pouvez voir les thèmes de discussion d'autres personnes et poser vos propres questions dans [{{site.data.keyword.containerlong_notm}} Slack. ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://ibm-container-service.slack.com)
{:shortdesc}

Si vous n'utilisez pas un ID IBM pour votre compte {{site.data.keyword.Bluemix_notm}}, [demandez une invitation](https://bxcs-slack-invite.mybluemix.net/) sur ce site Slack.
{: tip}
