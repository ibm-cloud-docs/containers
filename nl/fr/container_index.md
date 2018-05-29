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


# Initiation à {{site.data.keyword.containerlong_notm}}
{: #container_index}

Prenez une longueur d'avance avec {{site.data.keyword.containerlong}} en déployant des applications à haute disponibilité dans des conteneurs Docker qui s'exécutent dans des clusters Kubernetes.
{:shortdesc}

Les conteneurs sont un moyen standard pour conditionner des applications et toutes leurs dépendances afin de déplacer de façon transparente les applications entre des environnements. A la différence des machines virtuelles, les conteneurs n'incluent pas le système d'exploitation. Seuls le code d'application, l'environnement d'exécution, les outils système, les bibliothèques et les paramètres sont inclus dans les conteneurs. Les conteneurs sont plus légers, plus portables et plus efficaces que les machines virtuelles.


Cliquez sur une option pour commencer :

<img usemap="#home_map" border="0" class="image" id="image_ztx_crb_f1b" src="images/cs_public_dedicated_options.png" width="440" alt="Cliquez sur une icône pour débuter rapidement avec {{site.data.keyword.containershort_notm}}. Avec {{site.data.keyword.Bluemix_dedicated_notm}}, cliquez sur cette icône pour examiner vos options." style="width:440px;" />
<map name="home_map" id="home_map">
<area href="#clusters" alt="Initiation aux clusters Kubernetes dans {{site.data.keyword.Bluemix_notm}}" title="Initiation aux clusters Kubernetes dans {{site.data.keyword.Bluemix_notm}}" shape="rect" coords="-7, -8, 108, 211" />
<area href="cs_cli_install.html" alt="Installation des interfaces CLI." title="Installation des interfaces CLI." shape="rect" coords="155, -1, 289, 210" />
<area href="cs_dedicated.html#dedicated_environment" alt="{{site.data.keyword.Bluemix_dedicated_notm}} environnement de cloud" title="{{site.data.keyword.Bluemix_notm}} environnement de cloud" shape="rect" coords="326, -10, 448, 218" />
</map>


## Initiation aux clusters
{: #clusters}

Vous avez l'intention de déployer une application dans un conteneur ? Pas si vite ! Commencez par créer un cluster Kubernetes. Kubernetes est un outil d'orchestration pour conteneurs. Kubernetes permet aux développeurs de déployer en un éclair des applications hautement disponibles en utilisant la puissance et la flexibilité des clusters.
{:shortdesc}

Qu'est-ce qu'un cluster ? Un cluster est un ensemble de ressources, de noeuds worker, de réseaux et de périphériques de stockage permettant d'assurer la haute disponibilité des applications. Dès que vous disposez d'un cluster, vous pouvez déployer vos applications dans des conteneurs.

Avant de commencer, vous devez disposer d'un [compte {{site.data.keyword.Bluemix_notm}}](https://console.bluemix.net/registration/) de type Paiement à la carte, Compte d'essai ou Abonnement pour créer un cluster gratuit.

**Quel type de compte {{site.data.keyword.Bluemix_notm}} obtenir ?** Avec les comptes de type Paiement à la carte et Abonnement, vous pouvez mettre à disposition des ressources d'infrastructure IBM Cloud (SoftLayer) pour vos clusters Kubernetes et créer un cluster gratuit ou des clusters standard. Avec un compte d'essai, vous pouvez créer un cluster gratuit mais pas de cluster standard. Tous les clusters gratuits sont supprimés au bout de 21 jours. Pour aller plus loin avec des clusters Kubernetes, créez un autre cluster gratuit jusqu'à expiration de votre compte d'essai ou mettez à niveau votre compte pour passer à un compte de type Paiement à la carte ou Abonnement.
{:tip}

Pour créer un cluster gratuit :

1.  Dans le [**Catalogue** {{site.data.keyword.Bluemix_notm}} ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://console.bluemix.net/catalog/?category=containers) dans la catégorie **Conteneurs**, cliquez sur **Conteneurs dans les clusters Kubernetes**.

2.  Lisez la section clusters, puis cliquez sur **Créer**. Entrez un nom dans **Nom du cluster**. Le type de cluster par défaut est gratuit. La prochaine fois, vous pourrez créer un cluster standard et définir des personnalisations supplémentaires (par exemple, le nombre de noeuds worker).

3.  Cliquez sur **Créer un cluster**. Les détails du cluster s'affichent, mais la mise à disposition du noeud worker dans le cluster prend quelques minutes. Vous pouvez examiner le statut du noeud worker dans l'onglet **Noeuds worker**. Lorsque son statut indique `Ready`, votre noeud worker est prêt à être utilisé.

Bien joué ! Vous avez créé votre premier cluster Kubernetes. Voici quelques détails sur votre cluster gratuit :

*   **Type de machine** : Le cluster gratuit dispose d'un noeud worker virtuel avec 2 UC et 4 Go de mémoire mis à la disposition de vos applications. Lorsque vous créez un cluster standard, vous pouvez choisir entre des machines physiques (bare metal) ou virtuelles, ainsi que diverses tailles de machine.
*   **Maître géré** : Le noeud worker est surveillé et géré de manière centralisée par un maître Kubernetes appartenant à {{site.data.keyword.IBM_notm}}, dédié et à haute disponibilité, qui contrôle et surveille l'ensemble des ressources Kubernetes dans le cluster. Vous pouvez vous concentrer sur votre noeud worker et sur les applications qui y sont déployées sans avoir aussi à gérer ce maître.
*   **Ressources de l'infrastructure** : Les ressources nécessaires pour l'exécution du cluster, par exemple les réseaux locaux virtuels (VLAN) et les adresses IP, sont gérées dans un compte d'infrastructure IBM Cloud (SoftLayer) appartenant à {{site.data.keyword.IBM_notm}}. Lorsque vous créez un cluster standard, vous gérez ces ressources dans votre propre compte d'infrastructure IBM Cloud (SoftLayer). Vous pouvez en savoir plus sur ces ressources et les [droits nécessaires](cs_users.html#infra_access) lorsque vous créez un cluster standard.
*   **Emplacement et autres options** : Les clusters gratuits sont déployés dans la région que vous sélectionnez, mais vous ne pouvez pas décider de leur emplacement (centre de données). Pour plus de contrôle sur l'emplacement, la mise en réseau et le stockage persistant, créez un cluster standard. [En savoir plus sur les avantages des clusters gratuits et standard](cs_why.html#cluster_types).


**Etape suivante ?**
Au cours des 21 jours de validité, expérimentez certaines opérations avec votre cluster gratuit.

* [Installer les interfaces de ligne de commande pour commencer à utiliser votre cluster.](cs_cli_install.html#cs_cli_install)
* [Déployer une application dans votre cluster.](cs_app.html#app_cli)
* [Créer un cluster standard avec plusieurs noeuds pour une plus haute disponibilité.](cs_clusters.html#clusters_ui)
* [Configurer votre propre registre privé dans {{site.data.keyword.Bluemix_notm}} pour stocker et partager des images Docker avec d'autres utilisateurs.](/docs/services/Registry/index.html)

