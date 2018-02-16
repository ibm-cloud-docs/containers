---

copyright:
  years: 2014, 2018
lastupdated: "2017-12-13"

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

Prenez une longueur d'avance avec {{site.data.keyword.Bluemix_notm}} en déployant des application à haute disponibilité dans des conteurs Docker qui s'exécutent dans des clusters Kubernetes. Les conteneurs sont un moyen standard pour conditionner des applications et toutes leurs dépendances afin de déplacer de façon transparente les applications entre des environnements. A la différence des machines virtuelles, les conteneurs n'incluent pas le système d'exploitation. Seuls le code d'application, l'environnement d'exécution, les outils système, les bibliothèques et les paramètres sont inclus dans les conteneurs. Les conteneurs plus légers, portables et efficaces qu'une machines virtuelle.
{:shortdesc}


Cliquez sur une option pour commencer :

<img usemap="#home_map" border="0" class="image" id="image_ztx_crb_f1b" src="images/cs_public_dedicated_options.png" width="440" alt="Cliquez sur une icône pour débuter rapidement avec {{site.data.keyword.containershort_notm}}. Avec {{site.data.keyword.Bluemix_dedicated_notm}}, cliquez sur cette icône pour examiner vos options." style="width:440px;" />
<map name="home_map" id="home_map">
<area href="#clusters" alt="Initiation aux clusters Kubernetes dans {{site.data.keyword.Bluemix_notm}}" title="Initiation aux clusters Kubernetes dans {{site.data.keyword.Bluemix_notm}}" shape="rect" coords="-7, -8, 108, 211" />
<area href="cs_cli_install.html" alt="Installation des interfaces CLI." title="Installation des interfaces CLI." shape="rect" coords="155, -1, 289, 210" />
<area href="cs_dedicated.html#dedicated_environment" alt="{{site.data.keyword.Bluemix_dedicated_notm}} environnement de cloud" title="{{site.data.keyword.Bluemix_notm}} environnement de cloud" shape="rect" coords="326, -10, 448, 218" />
</map>


## Initiation aux clusters
{: #clusters}

Vous voulez déployer une application dans un conteneur ? Ne quittez pas. Commencez par créer un cluster Kubernetes. Kubernetes est un outil d'orchestration pour conteneurs. Kubernetes permet aux développeurs de développer en un éclair des applications hautement disponibles en utilisant la puissance et la flexibilité des clusters.
{:shortdesc}

Qu'est-ce qu'un cluster ? Un cluster est un ensemble de ressources, de noeuds d'agents, de réseaux et de périphériques de stockage permettant d'assurer une haute disponibilité des applications. Une fois que vous disposez d'un cluster, vous pouvez déployer vos applications dans des conteneurs.

[Avant de commencer : vous devez disposer d'un compte {{site.data.keyword.Bluemix_notm}} de type Pay-As-You-Go (Paiement à la carte) ou Subscription (Abonnement) pour créer un cluster léger.](https://console.bluemix.net/registration/)


Pour créer un cluster léger :

1.  Dans le [**catalogue** ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://console.bluemix.net/catalog/?category=containers), dans la catégorie **Conteneurs**, cliquez sur **Cluster Kubernetes**.

2.  Entrez un **nom de cluster**. Par défaut, il s'agit d'un type de cluster léger. La prochaine fois, vous pourrez créer un cluster standard et définir des personnalisations supplémentaires (par exemple, le nombre de noeuds d'agent dans le cluster).

3.  Cliquez sur **Créer un cluster**. Les détails du cluster s'affichent, mais l'allocation du noeud worker dans le cluster prend quelques minutes. Vous pouvez examiner le statut du noeud worker dans l'onglet **Noeuds d'agent**. Lorsque son statut indique `Ready`, votre noeud worker est prêt à être utilisé.

Bien joué ! Vous venez de créer votre premier cluster !

*   Le cluster léger dispose d'un noeud worker avec 2 UC et 4 Go de mémoire disponibles pour leur utilisation par vos applications.
*   Le noeud worker est surveillé et géré de manière centralisée par un maître Kubernetes dédié et à haute disponibilité dont {{site.data.keyword.IBM_notm}} est le propriétaire et qui contrôle et surveille toutes les ressources Kubernetes dans le cluster. Vous pouvez vous concentrer sur votre noeud worker et sur les applications qui y sont déployées sans avoir aussi à gérer ce maître.
*   Les ressources requises pour l'exécution du cluster, comme les réseaux locaux virtuels (VLAN) et les adresses IP, sont gérées dans un compte d'infrastructure IBM Cloud (SoftLayer) dont {{site.data.keyword.IBM_notm}} est propriétaire. Lorsque vous créez un cluster standard, vous gérez ces ressources dans votre propre compte d'infrastructure IBM Cloud (SoftLayer). Vous pouvez en apprendre plus sur ces ressources lorsque vous créez un cluster standard.


**Etape suivante ?**

Une fois le cluster opérationnel, vous pouvez commencer à l'utiliser.

* [Installez les interfaces de ligne de commande pour commencer à utiliser votre cluster.](cs_cli_install.html#cs_cli_install)
* [Déployer une application dans votre cluster.](cs_app.html#app_cli)
* [Créez un cluster standard avec plusieurs noeuds pour une plus haute disponibilité.](cs_clusters.html#clusters_ui)
* [Configurez votre propre registre privé dans {{site.data.keyword.Bluemix_notm}} afin de stocker et de partager des images Docker avec d'autres utilisateurs.](/docs/services/Registry/index.html)
