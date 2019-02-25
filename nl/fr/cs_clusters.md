---

copyright:
  years: 2014, 2018
lastupdated: "2018-12-05"

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
{:gif: data-image-type='gif'}


# Configuration de clusters et de noeuds worker
{: #clusters}
Créez des clusters et ajoutez des noeuds worker pour augmenter la capacité des clusters dans {{site.data.keyword.containerlong}}. Vous démarrez ? Suivez le [tutoriel de création d'un cluster Kubernetes](cs_tutorials.html#cs_cluster_tutorial).
{: shortdesc}

## Préparation à la création des clusters
{: #cluster_prepare}

Avec {{site.data.keyword.containerlong_notm}}, vous pouvez créer un environnement sécurisé à haute disponibilité pour vos applications, avec de nombreuses autres fonctionnalités intégrées ou configurables. Les nombreuses possibilités qui s'offrent à vous avec les clusters supposent beaucoup de décisions à prendre lorsque vous créez un cluster. La procédure suivante indique ce que vous devez prendre en compte pour configurer votre compte, les droits, les groupes de ressources, la fonction Spanning VLAN et la configuration de cluster (zone et matériel), ainsi que les informations sur la facturation.
{: shortdesc}

La liste est divisée en deux parties :
*  **Au niveau du compte** : préparations, qui, une fois créées par l'administrateur du compte, n'ont plus besoin d'être modifiées à chaque fois que vous créez un cluster. Cependant, chaque fois que vous créez un cluster, vous souhaitez quand même vérifier que l'état actuel au niveau du compte correspond bien à celui qu'il vous faut.
*  **Au niveau du cluster** : préparations qui affectent votre cluster chaque fois que vous créez un cluster.

### Au niveau du compte
{: #prepare_account_level}

1.  [Créez ou mettez à jour votre compte pour passer à un compte facturable ({{site.data.keyword.Bluemix_notm}} Paiement à la carte ou Abonnement)](https://console.bluemix.net/registration/).
2.  [Configurez une clé d'API {{site.data.keyword.containerlong_notm}}](cs_users.html#api_key) dans les régions où vous souhaitez créer des clusters. Affectez la clé d'API avec les droits appropriés pour créer des clusters :
    *  Rôle **Superutilisateur** pour l'infrastructure IBM Cloud (SoftLayer).
    *  Rôle de gestion de plateforme **Administrateur** pour {{site.data.keyword.containerlong_notm}} au niveau du compte.
    *  Rôle de gestion de plateforme **Administrateur** pour {{site.data.keyword.registrylong_notm}} au niveau du compte.

    Vous êtes le propriétaire du compte ? Dans ce cas vous disposez déjà des droits nécessaires. Lorsque vous créez un cluster, la clé d'API de cette région et de ce groupe de ressources est définie avec vos données d'identification.
    {: tip}

3.  Si votre compte utilise plusieurs groupes de ressources, envisagez la stratégie de votre compte à utiliser pour [gérer les groupes de ressources](cs_users.html#resource_groups). 
    *  Le cluster est créé dans le groupe de ressources que vous ciblez lorsque vous vous connectez à {{site.data.keyword.Bluemix_notm}}. Si vous ne ciblez pas de groupe de ressources, le groupe de ressources par défaut est automatiquement ciblé.
    *  Si vous désirez créer un cluster dans un autre groupe de ressources que le groupe par défaut, vous devez au moins disposer du rôle **Afficheur** pour le groupe de ressources. Si aucun rôle ne vous est affecté pour le groupe de ressources et que vous êtes toujours **Administrateur** du service au sein du groupe de ressources, votre cluster est créé dans le groupe de ressources par défaut.
    *  Vous ne pouvez pas modifier le groupe de ressources d'un cluster. Le cluster ne peut s'intégrer qu'à d'autres services {{site.data.keyword.Bluemix_notm}} figurant dans le même groupe de ressources ou à des services qui ne prennent pas en charge les groupes de ressources, tels qu'{{site.data.keyword.registrylong_notm}}.
    *  Si vous envisagez d'utiliser [{{site.data.keyword.monitoringlong_notm}} pour les métriques](cs_health.html#view_metrics), pensez à donner un nom à votre cluster qui soit unique pour tous les groupes de ressources et toutes les régions de votre compte afin d'éviter des conflits de noms pour les métriques.
    * Si vous avez un compte {{site.data.keyword.Bluemix_dedicated}}, vous devez créer des clusters dans le groupe de ressources par défaut uniquement.
4.  Activez le spanning VLAN. Si vous disposez de plusieurs VLAN pour un cluster, de plusieurs sous-réseaux sur le même VLAN ou d'un cluster à zones multiples, vous devez activer la fonction [Spanning VLAN](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) pour votre compte d'infrastructure IBM Cloud (SoftLayer) afin que vos noeuds worker puissent communiquer entre eux sur le réseau privé. Pour effectuer cette action, vous devez disposer des [droits Infrastructure](cs_users.html#infra_access) **Réseau > Gérer spanning VLAN pour réseau** ou vous pouvez demander au propriétaire du compte de l'activer. Pour vérifier si la fonction Spanning VLAN est déjà activée, utilisez la [commande](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`. Avec {{site.data.keyword.BluDirectLink}}, vous devez utiliser à la place une [fonction VRF (Virtual Router Function)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf). Pour activer la fonction VRF, contactez le représentant de votre compte d'infrastructure IBM Cloud (SoftLayer).

### Au niveau du cluster
{: #prepare_cluster_level}

1.  Vérifiez que vous disposez du rôle de plateforme **Administrateur** pour {{site.data.keyword.containerlong_notm}}.
    1.  Depuis la [console {{site.data.keyword.Bluemix_notm}}](https://console.bluemix.net/), cliquez sur **Gérer > Compte > Utilisateurs**.
    2.  Dans le tableau, sélectionnez-vous.
    3.  Dans l'onglet **Règles d'accès**, confirmez que votre **Rôle** est **Administrateur**. Vous pouvez être **Administrateur** de toutes les ressources du compte ou au moins pour {{site.data.keyword.containershort_notm}}. **Remarque** : si vous disposez du rôle **Administrateur** pour {{site.data.keyword.containershort_notm}} dans un seul groupe de ressources ou une seule région plutôt que pour tout le compte, vous devez au moins disposer du rôle **Afficheur** au niveau du compte pour voir les réseaux locaux virtuels (VLAN) du compte.
2.  Faites votre choix entre un [cluster gratuit ou standard](cs_why.html#cluster_types). Vous pouvez créer 1 cluster gratuit pour expérimenter certaines fonctionnalités pour une durée de 30 jours ou créer des clusters standard entièrement personnalisables avec l'isolement matériel de votre choix. Créez un cluster standard pour obtenir d'autres avantages et contrôler les performances de votre cluster.
3.  [Planifiez la configuration de votre cluster](cs_clusters_planning.html#plan_clusters).
    *  Déterminez le type de cluster à créer : [cluster à zone unique](cs_clusters_planning.html#single_zone) ou [cluster à zones multiples](cs_clusters_planning.html#multizone). Notez que les clusters à zones multiples sont disponibles uniquement à certains emplacements.
    *  Si vous envisagez de créer un cluster qui n'est pas accessible au public, consultez la [procédure relative aux clusters privés](cs_clusters_planning.html#private_clusters).
    *  Choisissez le type de [matériel et d'isolement](cs_clusters_planning.html#shared_dedicated_node) à appliquer aux noeuds worker de votre cluster, y compris votre choix entre des machines virtuelles ou bare metal.
4.  Pour les clusters standard, vous pouvez [estimer les coûts avec l'estimateur de coût ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://console.bluemix.net/pricing/configure/iaas/containers-kubernetes). Pour plus d'informations sur les frais qui ne sont pas forcément compris dans l'estimateur, voir [Tarification et facturation](cs_why.html#pricing).
<br>
<br>

**Etape suivante ?**
* [Création de clusters avec la console {{site.data.keyword.Bluemix_notm}}](#clusters_ui)
* [Création de clusters avec l'interface de ligne de commande (CLI) {{site.data.keyword.Bluemix_notm}}](#clusters_cli)

## Création de clusters avec la console {{site.data.keyword.Bluemix_notm}}
{: #clusters_ui}

L'objectif du cluster Kubernetes est de définir un ensemble de ressources, de noeuds, de réseaux et de périphériques de stockage permettant d'assurer une haute disponibilité des applications. Avant de pouvoir déployer une application, vous devez créer un cluster et spécifier les définitions des noeuds worker dans ce cluster.
{:shortdesc}

### Création d'un cluster gratuit
{: #clusters_ui_free}

Vous pouvez utiliser votre premier cluster gratuit pour vous familiariser avec le mode de fonctionnement d'{{site.data.keyword.containerlong_notm}}. Avec les clusters gratuits, vous pouvez faire connaissance avec la terminologie utilisée, exécuter un tutoriel et prendre vos repères avant de vous lancer dans les clusters standard de niveau production. Ne vous inquiétez pas, vous bénéficiez toujours d'un cluster gratuit même si vous avez un compte facturable.

Les clusters gratuits ont une durée de vie de 30 jours. A l'issue de cette période, le cluster arrive à expiration et il est supprimé ainsi que toutes les données qu'il contient. Les données supprimées ne sont pas sauvegardées par {{site.data.keyword.Bluemix_notm}} et ne peuvent pas être récupérées. Veillez à effectuer la sauvegarde des données importantes.
{: note}

1. [Préparez-vous à créer un cluster](#cluster_prepare) pour vous assurer que vous disposez d'une configuration de compte {{site.data.keyword.Bluemix_notm}} et de droits utilisateur corrects, et pour déterminer la configuration du cluster et du groupe de ressources que vous souhaitez utiliser.

2. Dans le [catalogue ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://console.bluemix.net/catalog/?category=containers), sélectionnez **{{site.data.keyword.containershort_notm}}** pour créer un cluster.

3. Sélectionnez un emplacement dans lequel déployer votre cluster. **Remarque** : vous ne pouvez pas créer de clusters gratuits dans les emplacements Washington DC (Est des Etats-Unis) ou Tokyo (Asie-Pacifique nord).

4. Sélectionnez le plan de cluster **Gratuit**.

5. Attribuez un nom à votre cluster. Le nom doit commencer par une lettre, peut contenir des lettres, des nombres et des tirets (-) et ne doit pas dépasser 35 caractères. Le nom du cluster et la région dans laquelle est déployé le cluster constituent le nom de domaine qualifié complet du sous-domaine Ingress. Pour garantir que ce sous-domaine est unique dans une région, le nom de cluster peut être tronqué et complété par une valeur aléatoire dans le nom de domaine Ingress.


6. Cliquez sur **Créer un cluster**. Par défaut un pool de noeuds worker contenant un noeud worker est créé. Vous pouvez voir la progression du déploiement du noeud worker dans l'onglet **Noeuds worker**. Une fois le déploiement terminé, vous pouvez voir si le cluster est prêt dans l'onglet **Vue d'ensemble**.

    Toute modification de l'ID unique ou du nom de domaine affecté lors de la création empêche le maître Kubernetes de gérer votre cluster.
    {: tip}

</br>

### Création d'un cluster standard
{: #clusters_ui_standard}

1. [Préparez-vous à créer un cluster](#cluster_prepare) pour vous assurer que vous disposez d'une configuration de compte {{site.data.keyword.Bluemix_notm}} et de droits utilisateur corrects, et pour déterminer la configuration du cluster et du groupe de ressources que vous souhaitez utiliser.

2. Dans le [catalogue ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://console.bluemix.net/catalog/?category=containers), sélectionnez **{{site.data.keyword.containershort_notm}}** pour créer un cluster.

3. Sélectionnez un groupe de ressources dans lequel créer votre cluster.
  **Remarque **:
    * Un cluster ne peut être créé que dans un seul groupe de ressources, et une fois le cluster créé, vous ne pouvez pas modifier son groupe de ressources.
    * Les clusters gratuits sont automatiquement créés dans le groupe de ressources par défaut.
    * Pour créer des clusters dans un autre groupe de ressources que le groupe par défaut, vous devez au moins disposer du [rôle **Afficheur**](cs_users.html#platform) pour le groupe de ressources.

4. Sélectionnez un [emplacement {{site.data.keyword.Bluemix_notm}}](cs_regions.html#regions-and-zones) dans lequel déployer votre cluster. Pour des performances optimales, sélectionnez l'emplacement le plus proche de vous. N'oubliez pas que si vous sélectionnez une zone à l'étranger, il se peut que vous ayez besoin d'une autorisation légale pour pouvoir stocker des données.

5. Sélectionnez le plan de cluster **Standard**. Avec un cluster standard, vous avez accès à des fonctions, par exemple plusieurs noeuds worker, pour bénéficier d'un environnement à haute disponibilité.

6. Entrez les détails de votre zone.

    1. Sélectionnez la disponibilité **Zone unique** ou **Zones multiples**. Dans un cluster à zones multiples, le noeud maître est déployé dans une zone compatible avec plusieurs zones et les ressources de votre cluster sont réparties sur plusieurs zones. Vos options peuvent être limitées par région.

    2. Sélectionnez les zones spécifiques dans lesquelles vous souhaitez héberger votre cluster. Vous devez sélectionner au moins 1 zone mais vous pouvez en sélectionner autant que vous voulez. Si vous sélectionnez plusieurs zones, les noeuds worker sont répartis sur les zones que vous avez choisies ce qui vous offre une plus grande disponibilité. Si vous vous contentez de sélectionner 1 zone, vous pouvez [ajouter des zones dans votre cluster](#add_zone) une fois qu'il a été créé.

    3. Sélectionnez un VLAN public (facultatif) et un VLAN privé (obligatoire) dans votre compte d'infrastructure IBM Cloud (SoftLayer). Les noeuds worker communiquent entre eux via le VLAN privé. Pour communiquer avec le maître Kubernetes, vous devez configurer la connectivité publique pour votre noeud worker.  Si vous n'avez aucun VLAN public ou privé dans cette zone, n'indiquez rien. Un VLAN public et un VLAN privé sont automatiquement créés pour vous. Si vous disposez déjà de VLAN et que vous ne spécifiez pas de VLAN public, envisagez la configuration d'un pare-feu, par exemple un [dispositif de routeur virtuel](/docs/infrastructure/virtual-router-appliance/about.html#about-the-vra). Vous pouvez utiliser le même VLAN pour plusieurs clusters.
        Si les noeuds worker sont configurés uniquement avec un VLAN privé, vous devez configurer une autre solution pour la connectivité du réseau. Pour plus d'informations, voir [Planification des réseaux de cluster privés uniquement](cs_network_cluster.html#private_vlan).
        {: note}

7. Configurez votre pool de noeuds worker par défaut. Les pools de noeuds worker sont des groupes de noeuds worker qui partagent la même configuration. Vous pouvez toujours ajouter d'autres pools de noeuds worker à votre cluster par la suite.

    1. Sélectionnez un type d'isolement matériel. Le type virtuel est facturé à l'heure et le type bare metal est facturé au mois.

        - **Virtuel - Dédié** : vos noeuds worker sont hébergés sur l'infrastructure réservée à votre compte. Vos ressources physiques sont complètement isolées.

        - **Virtuel - Partagé** : les ressources de l'infrastructure, telles que l'hyperviseur et le matériel physique, sont partagées par vous et d'autres clients IBM, mais vous êtes seul à accéder à chaque noeud worker. Bien que cette solution soit moins onéreuse et suffisante dans la plupart des cas, vérifiez cependant les consignes de votre entreprise relatives aux exigences en termes de performance et d'infrastructure.

        - **Bare Metal** : facturés au mois, les serveurs bare metal sont mis à disposition par interaction manuelle avec l'infrastructure IBM Cloud (SoftLayer) et cette opération peut prendre plus d'un jour ouvrable. La configuration bare metal convient le mieux aux applications à hautes performances qui nécessitent plus de ressources et de contrôle hôte. Vous pouvez également choisir d'activer la fonction [Calcul sécurisé](cs_secure.html#trusted_compute) pour vérifier que vous noeuds worker ne font pas l'objet de falsification. La fonction de calcul sécurisé (Trusted Compute) est disponible pour les types de machine bare metal sélectionnés. Par exemple, les versions GPU `mgXc` ne prennent pas en charge la fonction de calcul sécurisé. Si vous n'activez pas cette fonction lors de la création du cluster mais souhaitez le faire ultérieurement, vous pouvez utiliser la [commande](cs_cli_reference.html#cs_cluster_feature_enable) `ibmcloud ks feature-enable`. Après avoir activé cette fonction, vous ne pourrez plus la désactiver par la suite.

        Assurez-vous de vouloir mettre à disposition une machine bare metal. Comme elle est facturée au mois, si vous l'annulez immédiatement après l'avoir commandée par erreur, vous serez toujours redevable pour le mois complet.
        {:tip}

    2. Sélectionnez un type de machine. Le type de machine définit le nombre d'UC virtuelles, la mémoire et l'espace disque configurés dans chaque noeud worker et rendus disponibles aux conteneurs. Les types de machines virtuelles et bare metal disponibles varient en fonction de la zone de déploiement du cluster. Après avoir créé votre cluster, vous pouvez ajouter différents types de machine en ajoutant un noeud worker ou un pool de noeuds worker dans le cluster.

    3. Indiquez le nombre de noeuds worker dont vous avez besoin dans le cluster. Le nombre de noeuds worker que vous entrez est répliqué sur le nombre de zones que vous avez sélectionnées. Cela signifie que si vous disposez de 2 zones et que vous sélectionnez 3 noeuds worker, 6 noeuds sont mis à disposition et 3 noeuds résident dans chaque zone.

8. Attribuez un nom unique à votre cluster. **Remarque** : toute modification de l'ID unique ou du nom de domaine affecté lors de la création empêche le maître Kubernetes de gérer votre cluster.

9. Sélectionnez la version du serveur d'API Kubernetes pour le noeud maître du cluster.

10. Cliquez sur **Créer un cluster**. Un pool de noeuds worker est créé avec le nombre de noeuds worker que vous avez spécifié. Vous pouvez voir la progression du déploiement du noeud worker dans l'onglet **Noeuds worker**. Une fois le déploiement terminé, vous pouvez voir si le cluster est prêt dans l'onglet **Vue d'ensemble**.

**Etape suivante ?**

Une fois le cluster opérationnel, vous pouvez réaliser les tâches suivantes :

-   Si vous avez créé le cluster dans une zone compatible avec plusieurs zones, répartissez les noeuds worker en [ajoutant une zone à votre cluster](#add_zone).
-   [Installez les interfaces de ligne de commande pour commencer à utiliser votre cluster.](cs_cli_install.html#cs_cli_install)
-   [Déployez une application dans votre cluster.](cs_app.html#app_cli)
-   [Configurez votre propre registre privé dans {{site.data.keyword.Bluemix_notm}} pour stocker et partager des images Docker avec d'autres utilisateurs.](/docs/services/Registry/index.html)
-   Si vous utilisez un pare-feu, vous devrez peut-être [ouvrir les ports requis](cs_firewall.html#firewall) afin d'utiliser les commandes `ibmcloud`, `kubectl` ou `calicotl` pour autoriser le trafic sortant de votre cluster ou le trafic entrant pour les services réseau.
-   Pour les clusters avec Kubernetes version 1.10 ou ultérieure : Contrôlez qui peut créer des pods dans votre cluster avec les [politiques de sécurité de pod](cs_psp.html).

<br />


## Création de cluster avec l'interface de ligne de commande (CLI) {{site.data.keyword.Bluemix_notm}}
{: #clusters_cli}

L'objectif du cluster Kubernetes est de définir un ensemble de ressources, de noeuds, de réseaux et de périphériques de stockage permettant d'assurer une haute disponibilité des applications. Avant de pouvoir déployer une application, vous devez créer un cluster et spécifier les définitions des noeuds worker dans ce cluster.
{:shortdesc}

Avant de commencer, installez l'interface de ligne de commande {{site.data.keyword.Bluemix_notm}} et le [plug-in {{site.data.keyword.containerlong_notm}}](cs_cli_install.html#cs_cli_install).

Pour créer un cluster, procédez comme suit :

1. [Préparez-vous à créer un cluster](#cluster_prepare) pour vous assurer que vous disposez d'une configuration de compte {{site.data.keyword.Bluemix_notm}} et de droits utilisateur corrects, et pour déterminer la configuration du cluster et du groupe de ressources que vous souhaitez utiliser.

2.  Connectez-vous à l'interface de ligne de commande d'{{site.data.keyword.Bluemix_notm}}.

    1.  Connectez-vous et entrez vos données d'identification {{site.data.keyword.Bluemix_notm}} lorsque vous y êtes invité.

        ```
        ibmcloud login
        ```
        {: pre}

        Si vous disposez d'un ID fédéré, utilisez `ibmcloud login --sso` pour vous connecter à l'interface de ligne de commande {{site.data.keyword.Bluemix_notm}}. Entrez votre nom d'utilisateur et utilisez l'URL mentionnée dans la sortie de l'interface de ligne de commande pour extraire votre code d'accès à usage unique. Si la connexion échoue alors que vous omettez l'option `--sso` et aboutit en incluant l'option `--sso`, ceci indique que votre ID est fédéré.
        {: tip}

    2. Si vous disposez de plusieurs comptes {{site.data.keyword.Bluemix_notm}}, sélectionnez le compte que vous voulez utiliser pour créer votre cluster Kubernetes.

    3.  Pour créer des clusters dans un autre groupe de ressources que le groupe par défaut, ciblez ce groupe de ressources.
      **Remarque **:
        * Un cluster ne peut être créé que dans un seul groupe de ressources, et une fois le cluster créé, vous ne pouvez pas modifier son groupe de ressources.
        * Vous devez au moins disposer du [rôle **Afficheur**](cs_users.html#platform) pour le groupe de ressources.
        * Les clusters gratuits sont automatiquement créés dans le groupe de ressources par défaut.
      ```
      ibmcloud target -g <resource_group_name>
      ```
      {: pre}

    4.  Si vous désirez créer ou accéder à des clusters Kubernetes dans une région {{site.data.keyword.Bluemix_notm}} autre que celle que vous aviez sélectionnée auparavant, exécutez la commande `ibmcloud ks region-set`.


4.  Créez un cluster. Les clusters standard peuvent être créés dans n'importe quelle région et dans une zone disponible. Les clusters gratuits ne peuvent pas être créés dans les régions Est des Etats-Unis et Asie-Pacifique nord, ainsi que les zones correspondantes. Vous ne pouvez pas sélectionner la zone.

    1.  **Clusters standard** : examinez les zones disponibles. Les zones affichées dépendent de la région {{site.data.keyword.containerlong_notm}} à laquelle vous êtes connecté. Pour étendre votre cluster entre les différentes zones, vous devez créer le cluster dans une [zone compatible avec plusieurs zones](cs_regions.html#zones).

        ```
        ibmcloud ks zones
        ```
        {: pre}

    2.  **Clusters standard** : sélectionnez une zone et examinez les types de machine disponibles dans cette zone. Le type de machine spécifie les hôtes de calcul virtuels ou physiques disponibles pour chaque noeud worker.

        -  Consultez la zone **Type de serveur** pour sélectionner des machines virtuelles ou physiques (bare metal).
        -  **Virtuel** : facturées à l'heure, les machines virtuelles sont mises à disposition sur du matériel partagé ou dédié.
        -  **Physique** : facturés au mois, les serveurs bare metal sont mis à disposition par interaction manuelle avec l'infrastructure IBM Cloud (SoftLayer) et cette opération peut prendre plus d'un jour ouvrable. La configuration bare metal convient le mieux aux applications à hautes performances qui nécessitent plus de ressources et de contrôle hôte.
        - **Machines physiques avec la fonction de calcul sécurisé** : vous pouvez choisir d'activer la fonction de [calcul sécurisé](cs_secure.html#trusted_compute) pour vérifier que vos noeuds worker ne font pas l'objet de falsification. La fonction de calcul sécurisé (Trusted Compute) est disponible pour les types de machine bare metal sélectionnés. Par exemple, les versions GPU `mgXc` ne prennent pas en charge la fonction de calcul sécurisé. Si vous n'activez pas cette fonction lors de la création du cluster mais souhaitez le faire ultérieurement, vous pouvez utiliser la [commande](cs_cli_reference.html#cs_cluster_feature_enable) `ibmcloud ks feature-enable`. Après avoir activé cette fonction, vous ne pourrez plus la désactiver par la suite.
        -  **Types de machine** : pour décider du type de machine à déployer, examinez les combinaisons coeur/mémoire/stockage du [matériel disponible pour les noeuds worker](cs_clusters_planning.html#shared_dedicated_node). Après avoir créé votre cluster, vous pouvez ajouter différents types de machine physique ou virtuelle en [ajoutant un pool de noeuds worker](#add_pool).

           Assurez-vous de vouloir mettre à disposition une machine bare metal. Comme elle est facturée au mois, si vous l'annulez immédiatement après l'avoir commandée par erreur, vous serez toujours redevable pour le mois complet.
           {:tip}

        ```
        ibmcloud ks machine-types <zone>
        ```
        {: pre}

    3.  **Clusters standard** : vérifiez s'il existe des réseaux VLAN publics et privés dans l'infrastructure IBM Cloud (SoftLayer) pour ce compte.

        ```
        ibmcloud ks vlans <zone>
        ```
        {: pre}

        ```
        ID        Name                Number   Type      Router  
        1519999   vlan   1355     private   bcr02a.dal10  
        1519898   vlan   1357     private   bcr02a.dal10 
        1518787   vlan   1252     public   fcr02a.dal10 
        1518888   vlan   1254     public    fcr02a.dal10
        ```
        {: screen}

        S'il existe déjà un réseau virtuel public et privé, notez les routeurs correspondants. Les routeurs de VLAN privé commencent toujours par <code>bcr</code> (routeur de back-end) et les routeurs de VLAN public par <code>fcr</code> (routeur de front-end). Lors de la création d'un cluster et de la spécification des VLAN publics et privés, le nombre et la combinaison de lettres après ces préfixes doivent correspondre. Dans l'exemple de sortie, n'importe quel VLAN privé peut être utilisé avec l'un des VLAN publics étant donné que les routeurs incluent tous `02a.dal10`.

        Vous devez connecter vos noeuds worker à un VLAN privé et vous pouvez éventuellement connecter vos noeuds worker à un VLAN public. **Remarque** : si les noeuds worker sont configurés uniquement avec un VLAN privé, vous devez configurer une autre solution pour la connectivité du réseau. Pour plus d'informations, voir [Planification des réseaux de cluster privés uniquement](cs_network_cluster.html#private_vlan).

    4.  **Clusters gratuits et standard** : exécutez la commande `cluster-create`. Vous pouvez opter pour un cluster gratuit qui inclut un noeud worker configuré avec 2 UC virtuelles et 4 Go de mémoire qui sera supprimé automatiquement au bout de 30 jours. Lorsque vous créez un cluster standard, par défaut, les disques de noeud worker sont chiffrés, son matériel est partagé par plusieurs clients IBM et il est facturé par heures d'utilisation. </br>Exemple pour un cluster standard. Indiquez les options du cluster :

        ```
        ibmcloud ks cluster-create --zone dal10 --machine-type b2c.4x16 --hardware <shared_or_dedicated> --public-vlan <public_VLAN_ID> --private-vlan <private_VLAN_ID> --workers 3 --name <cluster_name> --kube-version <major.minor.patch> [--disable-disk-encrypt][--trusted]
        ```
        {: pre}

        Exemple pour un cluster gratuit. Indiquez le nom du cluster :

        ```
        ibmcloud ks cluster-create --name my_cluster
        ```
        {: pre}

        <table>
        <caption>Composantes de la commande cluster-create</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composantes de cette commande</th>
        </thead>
        <tbody>
        <tr>
        <td><code>cluster-create</code></td>
        <td>Commande de création d'un cluster dans votre organisation {{site.data.keyword.Bluemix_notm}}.</td>
        </tr>
        <tr>
        <td><code>--zone <em>&lt;zone&gt;</em></code></td>
        <td>**Clusters standard** : remplacez <em>&lt;zone&gt;</em> par l'ID de la zone {{site.data.keyword.Bluemix_notm}} où vous souhaitez créer votre cluster. Les zones  disponibles dépendent de la région {{site.data.keyword.containerlong_notm}} à laquelle vous êtes connecté.<p class="note">Les noeuds worker du cluster sont déployés dans cette zone. Pour étendre votre cluster entre les différentes zones, vous devez créer le cluster dans une [zone compatible avec plusieurs zones](cs_regions.html#zones). Une fois le cluster créé, vous pouvez [ajouter une zone dans le cluster](#add_zone).</p></td>
        </tr>
        <tr>
        <td><code>--machine-type <em>&lt;machine_type&gt;</em></code></td>
        <td>**Clusters standard** : choisissez un type de machine. Vous pouvez déployer vos noeuds worker en tant que machines virtuelles sur du matériel partagé ou dédié ou en tant que machines physiques sur un serveur bare metal. Les types de machines virtuelles et physiques disponibles varient en fonction de la zone de déploiement du cluster. Pour plus d'informations, voir la documentation correspondant à la [commande](cs_cli_reference.html#cs_machine_types) `ibmcloud ks machine-type`. Dans le cas de clusters gratuits, vous n'avez pas besoin de définir le type de machine.</td>
        </tr>
        <tr>
        <td><code>--hardware <em>&lt;shared_or_dedicated&gt;</em></code></td>
        <td>**Clusters standard (virtuels uniquement)** : niveau d'isolation du matériel pour votre noeud worker. Utilisez dedicated pour que toutes les ressources physiques vous soient dédiées exclusivement ou shared pour permettre leur partage avec d'autres clients IBM. La valeur par défaut est shared. Cette valeur est facultative pour les clusters standard et n'est pas disponible pour les clusters gratuits.</td>
        </tr>
        <tr>
        <td><code>--public-vlan <em>&lt;public_vlan_id&gt;</em></code></td>
        <td><ul>
          <li>**Clusters gratuits** : vous n'avez pas besoin de définir de réseau local virtuel (VLAN) public. Votre cluster gratuit est automatiquement connecté à un VLAN public dont IBM est propriétaire.</li>
          <li>**Clusters standard** : si vous disposez déjà d'un VLAN public configuré dans votre compte d'infrastructure IBM Cloud (SoftLayer) pour cette zone, entrez l'ID du VLAN public. Si vous désirez connecter vos noeuds worker uniquement à un VLAN privé, n'indiquez pas cette option.
          <p>Les routeurs de VLAN privé commencent toujours par <code>bcr</code> (routeur de back-end) et les routeurs de VLAN public par <code>fcr</code> (routeur de front-end). Lors de la création d'un cluster et de la spécification des VLAN publics et privés, le nombre et la combinaison de lettres après ces préfixes doivent correspondre.</p>
          <p class="note">Si les noeuds worker sont configurés uniquement avec un VLAN privé, vous devez configurer une autre solution pour la connectivité du réseau. Pour plus d'informations, voir [Planification des réseaux de cluster privés uniquement](cs_network_cluster.html#private_vlan).</p></li>
        </ul></td>
        </tr>
        <tr>
        <td><code>--private-vlan <em>&lt;private_vlan_id&gt;</em></code></td>
        <td><ul><li>**Clusters gratuits** : vous n'avez pas besoin de définir de VLAN privé. Votre cluster gratuit est automatiquement connecté à un VLAN privé dont IBM est propriétaire.</li><li>**Clusters standard** : si vous disposez déjà d'un VLAN privé configuré dans votre compte d'infrastructure IBM Cloud (SoftLayer) pour cette zone, entrez l'ID du VLAN privé. Si vous ne disposez pas d'un VLAN privé dans votre compte, ne spécifiez pas cette option. {{site.data.keyword.containerlong_notm}} crée automatiquement un VLAN privé pour vous.<p>Les routeurs de VLAN privé commencent toujours par <code>bcr</code> (routeur de back-end) et les routeurs de VLAN public par <code>fcr</code> (routeur de front-end). Lors de la création d'un cluster et de la spécification des VLAN publics et privés, le nombre et la combinaison de lettres après ces préfixes doivent correspondre.</p></li></ul></td>
        </tr>
        <tr>
        <td><code>--name <em>&lt;name&gt;</em></code></td>
        <td>**Clusters gratuits et standard** : remplacez <em>&lt;name&gt;</em> par le nom de votre cluster. Le nom doit commencer par une lettre, peut contenir des lettres, des nombres et des tirets (-) et ne doit pas dépasser 35 caractères. Le nom du cluster et la région dans laquelle est déployé le cluster constituent le nom de domaine qualifié complet du sous-domaine Ingress. Pour garantir que ce sous-domaine est unique dans une région, le nom de cluster peut être tronqué et complété par une valeur aléatoire dans le nom de domaine Ingress.
</td>
        </tr>
        <tr>
        <td><code>--workers <em>&lt;number&gt;</em></code></td>
        <td>**Clusters standard** : nombre de noeuds worker à inclure dans le cluster. Si l'option <code>--workers</code> n'est pas spécifiée, 1 noeud worker est créé.</td>
        </tr>
        <tr>
          <td><code>--kube-version <em>&lt;major.minor.patch&gt;</em></code></td>
          <td>**Clusters standard** : version Kubernetes du noeud maître du cluster. Cette valeur est facultative. Lorsque la version n'est pas spécifiée, le cluster est créé avec la valeur par défaut des versions Kubernetes prises en charge. Pour voir les versions disponibles, exécutez la commande <code>ibmcloud ks kube-versions</code>.
</td>
        </tr>
        <tr>
        <td><code>--disable-disk-encrypt</code></td>
        <td>**Clusters gratuits et standard** : les noeuds worker proposent le chiffrement de disque par défaut. [En savoir plus](cs_secure.html#encrypted_disk). Incluez cette option si vous désirez désactiver le chiffrement.</td>
        </tr>
        <tr>
        <td><code>--trusted</code></td>
        <td>**Clusters bare metal standard** : activez la fonction [Calcul sécurisé](cs_secure.html#trusted_compute) pour vérifier que vos noeuds worker bare metal ne font pas l'objet de falsification. La fonction de calcul sécurisé (Trusted Compute) est disponible pour les types de machine bare metal sélectionnés. Par exemple, les versions GPU `mgXc` ne prennent pas en charge la fonction de calcul sécurisé. Si vous n'activez pas cette fonction lors de la création du cluster mais souhaitez le faire ultérieurement, vous pouvez utiliser la [commande](cs_cli_reference.html#cs_cluster_feature_enable) `ibmcloud ks feature-enable`. Après avoir activé cette fonction, vous ne pourrez plus la désactiver par la suite.</td>
        </tr>
        </tbody></table>

5.  Vérifiez que la création du cluster a été demandée. Pour les machines virtuelles, la commande des postes de noeud worker et la mise à disposition et la configuration du cluster dans votre compte peuvent prendre quelques minutes. Les machines physiques bare metal sont mises à disposition par interaction manuelle avec l'infrastructure IBM Cloud (SoftLayer) et cette opération peut prendre plus d'un jour ouvrable.

    ```
    ibmcloud ks clusters
    ```
    {: pre}

    Lorsque la mise à disposition de votre cluster est finalisée, le statut du cluster passe à **deployed**.

    ```
    Name         ID                                   State      Created          Workers   Zone       Version     Resource Group Name
    my_cluster   paf97e8843e29941b49c598f516de72101   deployed   20170201162433   1         mil01      1.10.11      Default
    ```
    {: screen}

6.  Vérifiez le statut des noeuds worker.

    ```
    ibmcloud ks workers <cluster_name_or_ID>
    ```
    {: pre}

    Lorsque les noeuds worker sont prêts, l'état passe à **normal** et le statut indique **Ready**. Lorsque le statut du noeud indique **Ready**, vous pouvez accéder au cluster.

    A chaque noeud worker sont affectés un ID de noeud worker unique et un nom de domaine qui ne doivent pas être modifiés manuellement après la création du cluster. La modification de l'ID ou du domaine empêcherait le maître Kubernetes de gérer votre cluster.
    {: important}

    ```
    ID                                                 Public IP       Private IP      Machine Type   State    Status   Zone        Version     Resource Group Name
    kube-mil01-paf97e8843e29941b49c598f516de72101-w1   169.xx.xxx.xxx  10.xxx.xx.xxx   free           normal   Ready    mil01       1.10.11      Default
    ```
    {: screen}

7.  Définissez le cluster que vous avez créé comme contexte de cette session. Effectuez ces étapes de configuration à chaque fois que vous utilisez votre cluster.
    1.  Obtenez la commande permettant de définir la variable d'environnement et téléchargez les fichiers de configuration Kubernetes.

        ```
        ibmcloud ks cluster-config <cluster_name_or_ID>
        ```
        {: pre}

        Une fois les fichiers de configuration téléchargés, une commande s'affiche ; elle vous permet de définir le chemin vers le fichier de configuration Kubernetes local en tant que variable d'environnement.

        Exemple pour OS X :

        ```
        export KUBECONFIG=/Users/<user_name>/.bluemix/plugins/container-service/clusters/mycluster/kube-config-prod-dal10-mycluster.yml
        ```
        {: screen}

    2.  Copiez et collez la commande qui s'affiche sur votre terminal pour définir la variable d'environnement `KUBECONFIG`.
    3.  Vérifiez que la variable d'environnement `KUBECONFIG` est correctement définie.

        Exemple pour OS X :

        ```
        echo $KUBECONFIG
        ```
        {: pre}

        Sortie :

        ```
        /Users/<user_name>/.bluemix/plugins/container-service/clusters/mycluster/kube-config-prod-dal10-mycluster.yml

        ```
        {: screen}

8.  Lancez le tableau de bord Kubernetes via le port par défaut `8001`.
    1.  Affectez le numéro de port par défaut au proxy.

        ```
        kubectl proxy
        ```
        {: pre}

        ```
        Starting to serve on 127.0.0.1:8001
        ```
        {: screen}

    2.  Ouvrez l'URL suivante dans un navigateur Web pour accéder au tableau de bord Kubernetes.

        ```
        http://localhost:8001/ui
        ```
        {: codeblock}


**Etape suivante ?**

-   Si vous avez créé le cluster dans une zone compatible avec plusieurs zones, répartissez les noeuds worker en [ajoutant une zone à votre cluster](#add_zone).
-   [Déployez une application dans votre cluster.](cs_app.html#app_cli)
-   [Gérez votre cluster à l'aide de la ligne de commande `kubectl`. ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/reference/kubectl/overview/)
-   [Configurez votre propre registre privé dans {{site.data.keyword.Bluemix_notm}} pour stocker et partager des images Docker avec d'autres utilisateurs.](/docs/services/Registry/index.html)
- Si vous utilisez un pare-feu, vous devrez peut-être [ouvrir les ports requis](cs_firewall.html#firewall) afin d'utiliser les commandes `ibmcloud`, `kubectl` ou `calicotl` pour autoriser le trafic sortant de votre cluster ou le trafic entrant pour les services réseau.
-  Pour les clusters avec Kubernetes version 1.10 ou ultérieure : Contrôlez qui peut créer des pods dans votre cluster avec les [politiques de sécurité de pod](cs_psp.html).

<br />



## Ajout de noeuds worker et de zones dans les clusters
{: #add_workers}

Afin d'augmenter la disponibilité de vos applications, vous pouvez ajouter des noeuds worker à une ou plusieurs zones déjà présentes dans votre cluster. Pour protéger vos applications en cas de défaillance d'une zone, vous pouvez ajouter des zones dans votre cluster.
{:shortdesc}

Lorsque vous créez un cluster, les noeuds worker sont mis à disposition dans un pool de noeuds worker. Après la création du cluster, vous pouvez ajouter d'autres noeuds worker à un pool en le redimensionnant ou en ajoutant d'autres pools de noeuds worker. Par défaut, le pool de noeuds worker est présent dans une zone. Les clusters disposant d'un pool de noeuds worker dans une seule zone sont appelés des clusters à zone unique. Lorsque vous ajoutez d'autres zones dans le cluster, le pool de noeuds worker est présent dans les différentes zones. Les clusters ayant un pool de noeuds worker réparti sur plusieurs zones sont appelés des clusters à zones multiples.

Si vous disposez d'un cluster à zones multiples, conservez les ressources des noeuds worker associés équilibrées. Assurez-vous que tous les pools de noeuds worker sont répartis sur les mêmes zones et ajoutez ou supprimez des noeuds worker en redimensionnant les pools au lieu d'ajouter des noeuds individuels.
{: tip}

Avant de commencer, assurez-vous de disposer du [rôle de plateforme {{site.data.keyword.Bluemix_notm}} IAM **Opérateur** ou **Administrateur**](cs_users.html#platform). Ensuite, choisissez l'une des sections suivantes :
  * [Ajouter des noeuds worker en redimensionnant un pool de noeuds worker existant dans votre cluster](#resize_pool)
  * [Ajouter des noeuds worker en ajoutant un pool de noeuds worker dans votre cluster](#add_pool)
  * [Ajouter une zone dans votre cluster et répliquer les noeuds worker de vos pools de noeuds worker dans plusieurs zones](#add_zone)
  * [Déprécié : Ajouter un noeud worker autonome dans un cluster](#standalone)


### Ajout de noeuds worker en redimensionnant un pool de noeuds worker existant
{: #resize_pool}

Vous pouvez ajouter ou réduire le nombre de noeuds worker présents dans votre cluster en redimensionnant un pool de noeuds worker existant, que ce pool figure dans une zone ou soit réparti sur plusieurs zones.
{: shortdesc}

Prenons l'exemple d'un cluster avec un pool de noeuds worker comportant trois noeuds worker par zone.
* S'il s'agit d'un cluster à zone unique présent dans la zone `dal10`, le pool de noeuds worker a trois noeuds worker dans `dal10`. Le cluster dispose d'un total de trois noeuds worker.
* S'il s'agit d'un cluster à zones multiples, présent dans les zones `dal10` et `dal12`, le pool de noeuds worker a trois noeuds dans `dal10` et trois autres dans `dal12`. Le cluster dispose d'un total de six noeuds worker.

Pour les pools de noeuds worker bare metal, n'oubliez pas que la facture est mensuelle. Si vous en augmentez ou en réduisez la taille, il y aura des répercussions sur les coûts mensuels.
{: tip}

Pour redimensionner le pool de noeuds worker, modifiez le nombre de noeuds worker déployés par le pool de noeuds worker dans chaque zone :

1. Récupérez le nom du pool de noeuds worker que vous souhaitez redimensionner.
    ```
    ibmcloud ks worker-pools --cluster <cluster_name_or_ID>
    ```
    {: pre}

2. Redimensionnez le pool de noeuds worker en indiquant le nombre de noeuds worker que vous voulez déployer dans chaque zone. La valeur minimale est 1.
    ```
    ibmcloud ks worker-pool-resize --cluster <cluster_name_or_ID> --worker-pool <pool_name>  --size-per-zone <number_of_workers_per_zone>
    ```
    {: pre}

3. Vérifiez que le pool de noeuds worker est redimensionné.
    ```
    ibmcloud ks workers <cluster_name_or_ID> --worker-pool <pool_name>
    ```
    {: pre}

    Exemple de sortie pour un pool de noeuds worker présents dans deux zones, `dal10` et `dal12` qui est redimensionné à deux noeuds worker par zone :
    ```
    ID                                                 Public IP        Private IP      Machine Type      State    Status  Zone    Version
    kube-dal10-crb20b637238ea471f8d4a8b881aae4962-w7   169.xx.xxx.xxx   10.xxx.xx.xxx   b2c.4x16          normal   Ready   dal10   1.8.6_1504
    kube-dal10-crb20b637238ea471f8d4a8b881aae4962-w8   169.xx.xxx.xxx   10.xxx.xx.xxx   b2c.4x16          normal   Ready   dal10   1.8.6_1504
    kube-dal12-crb20b637238ea471f8d4a8b881aae4962-w9   169.xx.xxx.xxx   10.xxx.xx.xxx   b2c.4x16          normal   Ready   dal12   1.8.6_1504
    kube-dal12-crb20b637238ea471f8d4a8b881aae4962-w10  169.xx.xxx.xxx   10.xxx.xx.xxx   b2c.4x16          normal   Ready   dal12   1.8.6_1504
    ```
    {: screen}

### Ajout de noeuds worker en créant un nouveau pool de noeuds worker
{: #add_pool}

Vous pouvez ajouter des noeuds worker dans votre cluster en créant un nouveau pool de noeuds worker.
{:shortdesc}

1. Extrayez les zones de noeud worker (**Worker Zones**) de votre cluster et choisissez la zone dans laquelle vous souhaitez déployer les noeuds worker dans votre pool de noeuds worker. Si vous avez un cluster à zone unique, vous devez utiliser la zone que vous voyez dans la zone **Worker Zones**. Pour les clusters à zones multiples, vous pouvez choisir l'une des **zones de noeud worker** de votre cluster, ou ajouter l'une des [métropoles à zones multiples](cs_regions.html#zones) de la région dans laquelle se trouve votre cluster. Vous pouvez obtenir la liste des zones disponibles en exécutant la commande `ibmcloud ks zones`.
   ```
   ibmcloud ks cluster-get --cluster <cluster_name_or_ID>
   ```
   {: pre}

   Exemple de sortie :
   ```
   ...
   Worker Zones: dal10, dal12, dal13
   ```
   {: screen}

2. Pour chaque zone, répertoriez les VLAN publics et privés disponibles. Notez le VLAN privé et le VLAN public que vous souhaitez utiliser. Si vous ne disposez pas de VLAN privé ou public, ils sont automatiquement créés pour vous lorsque vous ajoutez une zone dans votre pool de noeuds worker.
   ```
   ibmcloud ks vlans <zone>
   ```
   {: pre}

3.  Pour chaque zone, consultez les [types de machine disponibles pour les noeuds worker](cs_clusters_planning.html#shared_dedicated_node).

    ```
    ibmcloud ks machine-types <zone>
    ```
    {: pre}

4. Créez un pool de noeuds worker. Si vous avez mis à disposition un pool de noeuds worker bare metal, indiquez `--hardware dedicated`.
   ```
   ibmcloud ks worker-pool-create --name <pool_name> --cluster <cluster_name_or_ID> --machine-type <machine_type> --size-per-zone <number_of_workers_per_zone> --hardware <dedicated_or_shared>
   ```
   {: pre}

5. Vérifiez que le pool de noeuds worker est créé.
   ```
   ibmcloud ks worker-pools --cluster <cluster_name_or_ID>
   ```
   {: pre}

6. Par défaut, l'ajout d'un pool de noeuds worker crée un pool sans aucune zone. Pour déployer les noeuds worker dans une zone, vous devez ajouter les zones que vous avez récupérées auparavant dans le pool de noeuds worker. Si vous souhaitez répartir vos noeuds worker sur plusieurs zones, répétez cette commande pour chaque zone.  
   ```
   ibmcloud ks zone-add --zone <zone> --cluster <cluster_name_or_ID> --worker-pools <pool_name> --private-vlan <private_VLAN_ID> --public-vlan <public_VLAN_ID>
   ```
   {: pre}

7. Vérifiez que les noeuds worker sont présents dans la zone que vous avez ajoutée. Vos noeuds worker sont prêts lorsque leur statut passe de **provision_pending** à **normal**.
   ```
   ibmcloud ks workers <cluster_name_or_ID> --worker-pool <pool_name>
   ```
   {: pre}

   Exemple de sortie :
   ```
   ID                                                 Public IP        Private IP      Machine Type      State    Status  Zone    Version
   kube-dal10-crb20b637238ea471f8d4a8b881aae4962-w7   169.xx.xxx.xxx   10.xxx.xx.xxx   b2c.4x16          provision_pending   Ready   dal10   1.8.6_1504
   kube-dal10-crb20b637238ea471f8d4a8b881aae4962-w8   169.xx.xxx.xxx   10.xxx.xx.xxx   b2c.4x16          provision_pending   Ready   dal10   1.8.6_1504
   ```
   {: screen}

### Ajout de noeuds worker en ajoutant une zone dans un pool de noeuds worker
{: #add_zone}

Vous pouvez étendre votre cluster sur plusieurs zones au sein d'une région en ajoutant une zone dans votre pool de noeuds worker.
{:shortdesc}

Lorsque vous ajoutez une zone dans un pool de noeuds worker, les noeuds worker définis dans votre pool de noeuds worker sont mis à disposition dans la nouvelle zone et pris en compte pour la planification des charges de travail à venir. {{site.data.keyword.containerlong_notm}} ajoute automatiquement le libellé `failure-domain.beta.kubernetes.io/region` pour la région et le libellé `failure-domain.beta.kubernetes.io/zone` pour la zone dans chaque noeud worker. Le planificateur de Kubernetes utilise ces libellés pour répartir les pods sur les zones situées dans la même région.

Si vous disposez de plusieurs pools de noeuds worker dans votre cluster, ajoutez la zone à tous ces pools de sorte que les noeuds worker soient répartis uniformément dans votre cluster.

Avant de commencer :
*  Pour ajouter une zone à votre pool de noeuds worker, ce pool doit se trouver dans une [zone compatible avec plusieurs zones](cs_regions.html#zones). Si ce n'est pas le cas, envisagez la [création d'un nouveau pool de noeuds worker](#add_pool).
*  Si vous disposez de plusieurs VLAN pour un cluster, de plusieurs sous-réseaux sur le même VLAN ou d'un cluster à zones multiples, vous devez activer la fonction [Spanning VLAN](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) pour votre compte d'infrastructure IBM Cloud (SoftLayer) afin que vos noeuds worker puissent communiquer entre eux sur le réseau privé. Pour effectuer cette action, vous devez disposer des [droits Infrastructure](cs_users.html#infra_access) **Réseau > Gérer spanning VLAN pour réseau** ou vous pouvez demander au propriétaire du compte de l'activer. Pour vérifier si la fonction Spanning VLAN est déjà activée, utilisez la [commande](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`. Avec {{site.data.keyword.BluDirectLink}}, vous devez utiliser à la place une [fonction VRF (Virtual Router Function)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf). Pour activer la fonction VRF, contactez le représentant de votre compte d'infrastructure IBM Cloud (SoftLayer).

Pour ajouter une zone avec des noeuds worker dans votre pool de noeuds worker :

1. Répertoriez les zones disponibles et sélectionnez la zone que vous souhaitez ajouter à votre pool de noeuds worker. La zone que vous choisissez doit être une zone compatible avec plusieurs zones.
   ```
   ibmcloud ks zones
   ```
   {: pre}

2. Répertoriez les VLAN disponibles dans cette zone. Si vous ne disposez pas de VLAN privé ou public, ils sont automatiquement créés pour vous lorsque vous ajoutez une zone dans votre pool de noeuds worker.
   ```
   ibmcloud ks vlans <zone>
   ```
   {: pre}

3. Répertoriez les pools de noeuds worker dans votre cluster et notez leurs noms.
   ```
   ibmcloud ks worker-pools --cluster <cluster_name_or_ID>
   ```
   {: pre}

4. Ajoutez la zone dans votre pool de noeuds worker. Si vous disposez de plusieurs pools de noeuds worker, ajoutez la zone à tous vos pools, pour que votre cluster soit équilibré dans toutes les zones. Remplacez `<pool1_id_or_name,pool2_id_or_name,...>` par les noms de tous vos pools de noeuds worker dans une liste séparée par des virgules.

    Un VLAN privé et un VLAN public doivent exister avant d'ajouter une zone à plusieurs pools de noeuds worker. Si vous ne disposez pas de VLAN privé et public dans cette zone, ajoutez d'abord la zone à un pool de noeuds worker pour que ces VLAN soient créés pour vous. Ensuite, vous pouvez ajouter cette zone à d'autres pools de noeuds worker en spécifiant le VLAN privé et le VLAN public créés pour vous.
    {: note}

   Si vous souhaitez utiliser des VLAN différents pour des pools de noeuds worker différents, répétez cette commande pour chaque VLAN et les pools de noeuds worker correspondants associés. Les nouveaux noeuds worker sont ajoutés aux VLAN que vous spécifiez, mais les VLAN pour les noeuds worker existants restent inchangés.
   {: tip}
   ```
   ibmcloud ks zone-add --zone <zone> --cluster <cluster_name_or_ID> --worker-pools <pool1_name,pool2_name,...> --private-vlan <private_VLAN_ID> --public-vlan <public_VLAN_ID>
   ```
   {: pre}

5. Vérifiez que la zone est ajoutée dans votre cluster. Recherchez la zone ajoutée dans la zone **Worker zones** dans la sortie. Notez que le nombre total de noeuds worker dans la zone **Workers** a augmenté avec l'ajout de nouveaux noeuds worker dans la zone ajoutée.
    ```
    ibmcloud ks cluster-get <cluster_name_or_ID>
    ```
    {: pre}

    Exemple de sortie :
    ```
    Name:                   mycluster
    ID:                     df253b6025d64944ab99ed63bb4567b6
    State:                  normal
    Created:                2018-09-28T15:43:15+0000
    Location:               dal10
    Master URL:             https://169.xx.xxx.xxx:30426
    Master Location:        Dallas
    Master Status:          Ready (21 hours ago)
    Ingress Subdomain:      ...
    Ingress Secret:         mycluster
    Workers:                6
    Worker Zones:           dal10, dal12
    Version:                1.11.3_1524
    Owner:                  owner@email.com
    Monitoring Dashboard:   ...
    Resource Group ID:      a8a12accd63b437bbd6d58fb6a462ca7
    Resource Group Name:    Default
    ```
    {: screen}  

### Déprécié : Ajout de noeuds worker autonomes
{: #standalone}

Si vous disposez d'un cluster qui a été créé avant l'introduction des pools de noeuds worker, vous pouvez utiliser les commandes dépréciées pour ajouter des noeuds worker autonomes.
{: deprecated}

Si vous disposez d'un cluster qui a été créé après l'introduction des pools de noeuds worker, vous ne pouvez pas ajouter des noeuds worker autonomes. A la place, vous pouvez [créer un pool de noeuds worker](#add_pool), [redimensionner un pool de noeuds worker existant](#resize_pool) ou [ajouter une zone dans un pool de noeuds worker](#add_zone) pour ajouter des noeuds worker dans votre cluster.
{: note}

1. Répertoriez les zones disponibles et sélectionnez la zone dans laquelle vous souhaitez ajouter des noeuds worker.
   ```
   ibmcloud ks zones
   ```
   {: pre}

2. Répertoriez les VLAN disponibles dans cette zone et notez leur ID.
   ```
   ibmcloud ks vlans <zone>
   ```
   {: pre}

3. Répertoriez les types de machine disponibles dans cette zone.
   ```
   ibmcloud ks machine-types <zone>
   ```
   {: pre}

4. Ajoutez des noeuds worker autonomes dans le cluster.
   ```
   ibmcloud ks worker-add --cluster <cluster_name_or_ID> --number <number_of_worker_nodes> --public-vlan <public_VLAN_ID> --private-vlan <private_VLAN_ID> --machine-type <machine_type> --hardware <shared_or_dedicated>
   ```
   {: pre}

5. Vérifiez que les noeuds worker ont été créés.
   ```
   ibmcloud ks workers <cluster_name_or_ID>
   ```
   {: pre}



## Affichage des états d'un cluster
{: #states}

Examinez l'état d'un cluster Kubernetes pour obtenir des informations sur la disponibilité et la capacité du cluster, et sur les problèmes qui se sont éventuellement produits.
{:shortdesc}

Pour afficher des informations sur un cluster particulier (notamment les zones, l'URL principale, le sous-domaine Ingress, la version, le propriétaire et le tableau de bord de surveillance), utilisez la [commande](cs_cli_reference.html#cs_cluster_get) `ibmcloud ks cluster-get <cluster_name_or_ID>`. Incluez l'indicateur `--showResources` pour afficher des ressources de cluster supplémentaires, telles que des modules complémentaires pour les pods de stockage ou des VLAN de sous-réseau pour des adresses IP publiques et privées.

Vous pouvez vérifier l'état actuel du cluster en exécutant la commande `ibmcloud ks clusters` et en accédant à la zone **State**. Pour identifier et résoudre les incidents liés à votre cluster et aux noeuds worker, voir [Traitement des incidents affectant les clusters](cs_troubleshoot.html#debug_clusters).

<table summary="Chaque ligne de tableau doit être lue de gauche à droite. L'état du cluster figure dans la première colonne et la description correspondante dans la seconde colonne.">
<caption>Etats du cluster</caption>
   <thead>
   <th>Etat du cluster</th>
   <th>Description</th>
   </thead>
   <tbody>
<tr>
   <td>Aborted</td>
   <td>La suppression du cluster est demandée par l'utilisateur avant le déploiement du maître Kubernetes. Une fois le cluster supprimé, le cluster est retiré de votre tableau de bord. Si votre cluster est bloqué dans cet état depuis un moment, ouvrez un [cas de support {{site.data.keyword.Bluemix_notm}}](cs_troubleshoot.html#ts_getting_help).</td>
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
     <td>Le cluster a bien été supprimé mais n'est pas encore retiré de votre tableau de bord. Si votre cluster est bloqué dans cet état depuis un moment, ouvrez un [cas de support {{site.data.keyword.Bluemix_notm}}](cs_troubleshoot.html#ts_getting_help). </td>
   </tr>
   <tr>
   <td>Deleting</td>
   <td>Le cluster est en cours de suppression et son infrastructure est en cours de démantèlement. Vous ne pouvez pas accéder au cluster.  </td>
   </tr>
   <tr>
     <td>Deploy failed</td>
     <td>Le déploiement du maître Kubernetes n'a pas abouti. Vous ne pouvez pas résoudre cet état. Contactez le support IBM Cloud en ouvrant un [cas de support {{site.data.keyword.Bluemix_notm}}](cs_troubleshoot.html#ts_getting_help).</td>
   </tr>
     <tr>
       <td>Deploying</td>
       <td>Le maître Kubernetes n'est pas encore complètement déployé. Vous ne pouvez pas accéder à votre cluster. Patientez jusqu'à la fin du déploiement complet de votre cluster pour examiner l'état de santé de votre cluster.</td>
      </tr>
      <tr>
       <td>Normal</td>
       <td>Tous les noeuds worker d'un cluster sont opérationnels. Vous pouvez accéder au cluster et déployer les applications sur le cluster. Cet état est considéré comme bon et ne nécessite aucune action de votre part.<p class="note">Même si les noeuds worker peuvent être normaux, d'autres ressources d'infrastructure, telles que les [réseaux](cs_troubleshoot_network.html) et le [stockage](cs_troubleshoot_storage.html), peuvent continuer à exiger de l'attention.</p></td>
    </tr>
      <tr>
       <td>Pending</td>
       <td>Le maître Kubernetes est déployé. La mise à disposition des noeuds worker est en cours. Ces derniers ne sont pas encore disponibles dans le cluster. Vous pouvez accéder au cluster, mais vous ne pouvez pas déployer d'applications sur le cluster.  </td>
     </tr>
   <tr>
     <td>Requested</td>
     <td>Une demande de création du cluster et d'organisation de l'infrastructure du maître Kubernetes et des noeuds worker est envoyée. Lorsque le déploiement du cluster commence, l'état du cluster passe à <code>Deploying</code>. Si votre cluster est bloqué à l'état <code>Requested</code> depuis un moment, ouvrez un [cas de support {{site.data.keyword.Bluemix_notm}}](cs_troubleshoot.html#ts_getting_help). </td>
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


<br />


## Suppression de clusters
{: #remove}

Les clusters gratuits et standard créés avec un compte facturable doivent être supprimés manuellement lorsqu'ils ne sont plus nécessaires afin qu'ils ne consomment plus de ressources.
{:shortdesc}

<p class="important">
Aucune sauvegarde de votre cluster ou de vos données n'est effectuée dans votre stockage persistant. La suppression d'un cluster ou d'un stockage persistant est définitive et irréversible.</br>
</br>Lorsque vous supprimez un cluster, vous supprimez également les sous-réseaux éventuels qui sont automatiquement fournis lorsque vous avez créé le cluster et que vous avez créés en exécutant la commande `ibmcloud ks cluster-subnet-create`. Cependant, si vous avez ajouté manuellement des sous-réseaux existants à votre cluster avec la commande `ibmcloud ks cluster-subnet-add`, ces sous-réseaux ne sont pas retirés de votre compte d'infrastructure IBM Cloud (SoftLayer) et vous pouvez les réutiliser dans d'autres clusters.</p>

Avant de commencer :
* Notez l'ID de votre cluster. Vous en aurez besoin pour rechercher et retirer les ressources d'infrastructure IBM Cloud (SoftLayer) associées qui ne sont pas automatiquement supprimées avec votre cluster.
* Si vous souhaitez supprimer les données dans votre stockage persistant, [familiarisez-vous avec les options de suppression](cs_storage_remove.html#cleanup).
* Vérifiez que vous disposez du [rôle de plateforme {{site.data.keyword.Bluemix_notm}} IAM **Administrateur**](cs_users.html#platform).

Pour supprimer un cluster :

-   Depuis la console {{site.data.keyword.Bluemix_notm}}
    1.  Sélectionnez votre cluster et cliquez sur **Supprimer** dans le menu **Plus d'actions...**.

-   Depuis l'interface CLI d'{{site.data.keyword.Bluemix_notm}}
    1.  Répertoriez les clusters disponibles.

        ```
        ibmcloud ks clusters
        ```
        {: pre}

    2.  Supprimez le cluster.

        ```
        ibmcloud ks cluster-rm <cluster_name_or_ID>
        ```
        {: pre}

    3.  Suivez les invites et indiquez si vous souhaitez supprimer des ressources de cluster, notamment des conteneurs, des pods, des services liés, du stockage persistant et des valeurs confidentielles.
      - **Stockage persistant** : un stockage persistant procure une haute disponibilité à vos données. Si vous avez créé une réservation de volume persistant via un [partage de fichiers existant](cs_storage_file.html#existing_file), vous ne pouvez pas supprimer ce dernier lorsque vous supprimez le cluster. Vous devez ultérieurement supprimer ce partage de fichiers manuellement de votre portefeuille d'infrastructure IBM Cloud (SoftLayer).

          En raison du cycle de facturation mensuel, une réservation de volume persistant ne peut pas être supprimée le dernier jour du mois. Si vous supprimez la réservation de volume persistant le dernier jour du mois, la suppression reste en attente jusqu'au début du mois suivant.
          {: note}

Etapes suivantes :
- Lorsqu'il n'est plus répertorié dans la liste des clusters disponibles lorsque vous exécutez la commande `ibmcloud ks clusters`, vous pouvez réutiliser le nom d'un cluster supprimé.
- Si vous conservez les sous-réseaux, vous pouvez [les réutiliser dans un nouveau cluster](cs_subnets.html#custom) ou les supprimer manuellement de votre portefeuille d'infrastructure IBM Cloud (SoftLayer).
- Si vous conservez du stockage persistant, vous pouvez [supprimer votre stockage](cs_storage_remove.html#cleanup) par la suite dans le tableau de bord de l'infrastructure IBM Cloud (SoftLayer) dans la console {{site.data.keyword.Bluemix_notm}}.
