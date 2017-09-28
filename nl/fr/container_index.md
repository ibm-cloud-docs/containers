---

copyright:
  years: 2014, 2017
lastupdated: "2017-08-014"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip} 
{:download: .download}


# Initiation à {{site.data.keyword.containerlong_notm}}
{: #container_index}

Vous pouvez gérer des applications à haute disponibilité dans des conteneurs Docker et des clusters Kubernetes sur le cloud {{site.data.keyword.IBM}}. Un conteneur est un moyen standard permettant de
conditionner une application et toutes ses dépendances. L'application peut ainsi être
déplacée d'un environnement à l'autre et exécutée sans modifications. 
A la différence des machines virtuelles, les conteneurs n'incluent pas le système d'exploitation. Seuls le code de l'application, le contexte d'exécution, les outils système, les bibliothèques et les paramètres sont conditionnés au sein du conteneur, ce qui le rend plus léger, plus portable et plus efficace qu'une machine virtuelle.

Cliquez sur une option pour commencer :

<img usemap="#home_map" border="0" class="image" id="image_ztx_crb_f1b" src="images/cs_public_dedicated_options.png" width="440" alt="Avec Bluemix Public, vous pouvez créer des clusters Kubernetes ou faire migrer des groupes de conteneurs uniques et évolutifs. Avec Bluemix, cliquez sur cette icône pour voir vos options." style="width:440px;" />
<map name="home_map" id="home_map">
<area href="#clusters" alt="Initiation aux clusters Kubernetes dans Bluemix" title="Initiation aux clusters Kubernetes dans Bluemix" shape="rect" coords="-7, -8, 108, 211" />
    <area href="cs_classic.html#cs_classic" alt="Exécution de conteneurs uniques et évolutifs dans IBM Bluemix Container Service (Kraken)" title="Exécution de conteneurs uniques et évolutifs dans IBM Bluemix Container Service (Kraken)" shape="rect" coords="155, -1, 289, 210" />
    <area href="cs_ov.html#dedicated_environment" alt="Environnement de cloud Bluemix Dedicated" title="Environnement de cloud Bluemix Dedicated" shape="rect" coords="326, -10, 448, 218" />
</map>


## Initiation aux clusters dans {{site.data.keyword.Bluemix_notm}}
{: #clusters}

Kubernetes est un outil d'orchestration dédié à la planification de conteneurs d'application sur un cluster de machines de traitement. Kubernetes permet aux développeurs de développer rapidement des applications hautement disponibles en utilisant la puissance et la flexibilité de conteneurs. {:shortdesc}

Avant de déployer une application à l'aide de Kubernetes, commencez par créer un cluster. Un cluster est un ensemble de noeuds d'agent organisés dans un réseau. L'objet de ce cluster est de définir un ensemble de ressources, de noeuds, de réseaux et de périphériques de stockage susceptible d'assurer une haute disponibilité des applications.

Pour créer un cluster léger :

1.  Dans le [**catalogue** ![External link icon](../icons/launch-glyph.svg "External link icon")](https://console.bluemix.net/catalog/?category=containers), dans la catégorie **Conteneurs**, cliquez sur **Cluster Kubernetes**.

2.  Entrez les détails du cluster. Le type de conteneur par défaut est léger, de sorte que vous n'avez à personnaliser que quelques zones. La prochaine fois, vous pourrez créer un cluster standard et définir des personnalisations supplémentaires (par exemple, le nombre de noeuds d'agent dans le cluster).
    1.  Renseignez la zone **Nom du cluster**.
    2.  Sélectionnez un **emplacement** dans lequel déployer votre cluster. Les emplacements disponibles dépendent de la région à laquelle vous êtes connecté. Pour des performances optimales, sélectionnez la région physiquement la plus proche.

    Les emplacements disponibles sont les suivants :

    <ul><li>Sud des Etats-Unis<ul><li>dal10 [Dallas]</li><li>dal12 [Dallas]</li></ul></li><li>Sud du Royaume-Uni<ul><li>lon02 [Londres]</li><li>lon04 [Londres]</li></ul></li><li>Centre Union Européenne<ul><li>ams03 [Amsterdam]</li><li>ra02 [Francfort]</li></ul></li><li>AP-Sud<ul><li>syd01 [Sydney]</li><li>syd04 [Sydney]</li></ul></li></ul>
        
3.  Cliquez sur **Créer un cluster**. Les détails du cluster s'affichent, mais l'allocation du noeud d'agent dans le cluster prend quelques minutes. Vous pouvez examiner le statut du noeud d'agent dans l'onglet **Noeuds d'agent**. Lorsque son statut indique `Ready`, votre noeud d'agent est prêt à être utilisé. 

Bien joué ! Vous venez de créer votre premier cluster !

*   Le cluster léger dispose d'un noeud d'agent avec 2 UC et 4 Go de mémoire disponibles pour leur utilisation par vos applications.
*   Le noeud d'agent est surveillé et géré de manière centralisée par un maître Kubernetes dédié et à haute disponibilité dont {{site.data.keyword.IBM_notm}} est le propriétaire et qui contrôle et surveille toutes les ressources Kubernetes dans le cluster. Vous pouvez vous concentrer sur votre noeud d'agent et sur les applications qui y sont déployées sans avoir aussi à gérer ce maître.
*   Les ressources requises pour l'exécution du cluster, comme les réseaux locaux virtuels et les adresses IP, sont gérées dans un compte {{site.data.keyword.BluSoftlayer_full}} dont {{site.data.keyword.IBM_notm}} est propriétaire. Lorsque vous créez un cluster standard, vous gérez ces ressources dans votre propre compte {{site.data.keyword.BluSoftlayer_notm}}. Vous pouvez en apprendre plus sur ces ressources lorsque vous créez un cluster standard.
*   **Astuce :** les clusters légers créés avec un compte d'essai gratuit {{site.data.keyword.Bluemix_notm}} sont automatiquement supprimés à l'expiration de la période d'évaluation gratuite, sauf si vous effectuez une [mise à niveau vers un compte {{site.data.keyword.Bluemix_notm}} de type Paiement à la carte.](/docs/pricing/billable.html#upgradetopayg)


**Etape suivante ?**

Une fois le cluster opérationnel, vous pouvez réaliser les tâches suivantes.

* [Installez les interfaces de ligne de commande pour commencer à utiliser votre cluster.](cs_cli_install.html#cs_cli_install)
* [Déployez une application dans votre cluster.](cs_apps.html#cs_apps_cli)
* [Créez un cluster standard avec plusieurs noeuds pour une plus haute disponibilité.](cs_cluster.html#cs_cluster_ui)
* [Configurez votre propre registre privé dans {{site.data.keyword.Bluemix_notm}} afin de stocker et de partager des images Docker avec d'autres utilisateurs.](/docs/services/Registry/index.html)


## Initiation aux clusters dans {{site.data.keyword.Bluemix_notm}} Dedicated (version bêta fermée)
{: #dedicated}

Kubernetes est un outil d'orchestration dédié à la planification de conteneurs d'application sur un cluster de machines de traitement. Grâce à Kubernetes, les développeurs peuvent développer rapidement des applications à haute disponibilité en utilisant la puissance et de la souplesse des conteneurs dans leur instance {{site.data.keyword.Bluemix_notm}} Dedicated. {:shortdesc}

Avant de commencer, [configurez votre environnement {{site.data.keyword.Bluemix_notm}} Dedicated](cs_ov.html#setup_dedicated). Vous pouvez alors créer un
cluster. Un cluster est un ensemble de noeuds d'agent organisés dans un réseau. L'objet de ce cluster est de définir un ensemble de ressources, de noeuds, de réseaux et de périphériques de stockage permettant d'assurer une haute disponibilité des applications. Une fois que vous disposez d'un
cluster, vous pouvez y déployer votre application.

**Astuce :** si votre organisation ne dispose pas encore d'un environnement {{site.data.keyword.Bluemix_notm}} Dedicated, il se peut que vous n'en ayez pas besoin. [Essayez d'abord un cluster dédié, standard, dans l'environnement {{site.data.keyword.Bluemix_notm}} Public.](cs_cluster.html#cs_cluster_ui)

Pour déployer un cluster dans {{site.data.keyword.Bluemix_notm}} Dedicated :

1.  Connectez-vous à la console {{site.data.keyword.Bluemix_notm}} Public  ([https://console.bluemix.net ![External link icon](../icons/launch-glyph.svg "External link icon")](https://console.bluemix.net/catalog/?category=containers)) avec votre IBMid. Bien que vous deviez utiliser {{site.data.keyword.Bluemix_notm}} Public pour demander un cluster, celui-ci est déployé dans votre compte {{site.data.keyword.Bluemix_notm}} Dedicated. 
2.  Si vous possédez plusieurs comptes, dans le menu de compte, sélectionnez un compte {{site.data.keyword.Bluemix_notm}}. 
3.  Dans le catalogue, dans la catégorie **Conteneurs**, cliquez sur **Cluster Kubernetes**.
4.  Entrez les détails du cluster.
    1.  Renseignez la zone **Nom du cluster**.
    2.  Sélectionnez la **version Kubernetes** à utiliser dans les noeuds d'agent. 
    3.  Sélectionnez un **type de machine**. Le type de machine détermine le nombre d'UC virtuelles et la mémoire déployés dans chaque noeud d'agent et disponibles pour tous les conteneurs
que vous déployez dans vos noeuds.
    4.  Sélectionnez le **nombre de noeuds d'agent** dont vous avez besoin. Sélectionnez la valeur 3 pour assurer une haute disponibilité de votre cluster.
    
    Les zones afférentes au type de cluster, son emplacement, au réseau local virtuel privé, public, et au matériel sont définies lors de la procédure de création du compte {{site.data.keyword.Bluemix_notm}} Dedicated, et vous ne pouvez donc pas les modifier.
5.  Cliquez sur **Créer un cluster**. La section des informations détaillées sur le cluster s'ouvre, mais l'allocation de noeuds d'agent dans le cluster prend quelques minutes. Vous pouvez examiner le statut des noeuds d'agent dans l'onglet **Noeuds d'agent**. Lorsque leur statut indique `Ready`, vos noeuds d'agent sont prêts à être utilisés. 

    Les noeuds d'agent sont surveillés et gérés de manière centralisée par un maître Kubernetes dédié et à haute disponibilité dont {{site.data.keyword.IBM_notm}} est le propriétaire et qui contrôle et surveille toutes les ressources Kubernetes dans le cluster. Vous pouvez vous concentrer sur vos noeuds d'agent et sur les applications qui y sont déployées sans avoir aussi à gérer ce maître.

Bien joué ! Vous venez de créer votre premier cluster !


**Etape suivante ?**

Une fois le cluster opérationnel, vous pouvez réaliser les tâches suivantes.

* [Installez les interfaces de ligne de commande pour commencer à utiliser votre cluster.](cs_cli_install.html#cs_cli_install)
* [Déployez une application sur votre cluster.](cs_apps.html#cs_apps_cli)
* [Ajoutez des services {{site.data.keyword.Bluemix_notm}} à votre cluster.](cs_cluster.html#binding_dedicated)
* [Découvrez ce qui différencie les clusters dans les environnements {{site.data.keyword.Bluemix_notm}} Dedicated et Public.](cs_ov.html#env_differences)

