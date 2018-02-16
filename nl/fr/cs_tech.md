---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-11"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# Technologie d'{{site.data.keyword.containerlong_notm}}

## Conteneurs Docker
{: #docker_containers}

Docker est un projet open source diffusé par dotCloud en 2013. Basé sur les fonctions de la technologie conteneur de Linux (LXC), Docker est devenu une plateforme logicielle que vous pouvez utiliser pour construire, tester, déployer et mettre à l'échelle rapidement des applications. Docker livre les logiciels dans des unités standardisées dénommées conteneurs qui incluent tous les éléments dont une application a besoin pour s'exécuter.
{:shortdesc}

En savoir plus sur certains concepts Docker de base :

<dl>
<dt>Image</dt>
<dd>Une image Docker est générée à partir d'un Dockerfile, lequel est un fichier texte qui définit comment générer l'image et les artefacts de génération qu'elle doit inclure, comme l'application, la configuration de l'application et ses dépendances. Les images sont toujours construites à partir d'autres images, ce qui les rend faciles à configurer. Quelqu'un d'autre peut faire le gros du travail sur une image en vous laissant la personnaliser.</dd>
<dt>Registre</dt>
<dd>Un registre d'images est un emplacement où stocker, extraire et partager des images Docker. Les images stockées dans un registre peuvent être accessibles au public (registre public) ou seulement par un petit groupe d'utilisateurs (registre privé). {{site.data.keyword.containershort_notm}} propose des images publiques, telles que ibmliberty, que vous pouvez utiliser pour créer votre première application conteneurisée. Dans le cas d'applications d'entreprise, utilisez un registre privé tel que celui fourni dans {{site.data.keyword.Bluemix_notm}} pour protéger vos images contre une utilisation par des utilisateurs non autorisés.
</dd>
<dt>Conteneur</dt>
<dd>Chaque conteneur est créé depuis une image. Un conteneur est un package d'application avec toutes ses dépendances de sorte que l'application puisse être transférées entre des environnements et exécutée sans modifications. Contrairement aux machines virtuelles, les conteneurs ne virtualisent pas une unité, son système d'exploitation et le matériel sous-jacent. Seuls le code d'application, l'environnement d'exécution, les outils système, les bibliothèques et les paramètres sont inclus dans le conteneur. Les conteneurs opèrent sous forme de processus isolés sur des hôtes de traitement et partagent le système d'exploitation hôte et ses ressources matérielles. Cette approche rend le conteneur plus léger, portable, et efficace, qu'une machine virtuelle.</dd>
</dl>

### Principaux avantages de l'utilisation de conteneurs
{: #container_benefits}

<dl>
<dt>Les conteneurs sont agiles</dt>
<dd>Les conteneurs simplifient l'administration du système en fournissant des environnements standardisés pour des déploiements en espace de développement et de production. L'environnement d'exécution simple un dimensionnement rapide par majoration ou atténuation des déploiements. Libérez-vous de la complexité de gérer des plateformes de système d'exploitation différentes et leurs infrastructures sous-jacentes eu utilisant des conteneurs qui vous aideront à déployer et à exécuter rapidement et de manière fiable n'importe quelle application sur une infrastructure quelconque.</dd>
<dt>Les conteneurs sont de taille modeste</dt>
<dd>Vous pouvez intégrer beaucoup de conteneurs dans l'espace monopolisé par une seule machine virtuelle.</dd>
<dt>Les conteneurs sont portables</dt>
<dd><ul>
  <li>Réutiliser des éléments d'image pour construire des conteneurs. </li>
  <li>Déplacer rapidement le code d'application de l'environnement de transfert aux environnements de production.</li>
  <li>Automatiser vos processus avec des outils de distribution continue.</li> </ul></dd>
</dl>


<br />


## Concepts de base de Kubernetes
{: #kubernetes_basics}

Kubernetes a été développé par Google dans le cadre du projet Borg et légué à la communauté open source en 2014. Kubernetes combine plus de 15 années de recherche Google dans l'opération d'un infrastructure conteneurisée avec des charges de travail en production, des contributions open source et des outils de gestion de conteneur Docker afin de fournir une plateforme d'application isolée et sécurisée pour gestion de conteneurs qui soit portable, extensible et avec réparation spontanée en cas de basculements.
{:shortdesc}

En savoir plus sur certains concepts Kubernetes illustré dans le diagramme suivant.

![Configuration de déploiement](images/cs_app_tutorial_components1.png)

<dl>
<dt>Compte</dt>
<dd>Les termes "votre compte" font référence à votre compte {{site.data.keyword.Bluemix_notm}}.</dd>

<dt>Cluster</dt>
<dd>Un cluster Kubernetes est composé d'un ou de plusieurs hôte de traitement dénommés noeuds worker. Les noeuds d'agent sont gérés par un maître Kubernetes qui assure le contrôle centralisé et la surveillance de toutes les ressources Kubernetes dans le cluster. Donc lorsque vous déployez les ressources pour une application conteneurisée, la maître Kubernetes décide sur quel noeud worker déployer ces ressources, en prenant en compte les exigences de déploiement et la capacité disponible dans le cluster. Les ressources Kubernetes incluent des services, des déploiements et des pods.</dd>

<dt>Service</dt>
<dd>Un service est une ressource Kubernetes qui regroupe un ensemble de pods et fournit la connectivité réseau à ces pods sans exposer l'adresse IP privée réelle de chaque pod. Vous pouvez utiliser un service pour rendre votre application accessible dans votre cluster ou sur l'Internet public.
</dd>

<dt>Déploiement</dt>
<dd>Un déploiement est une ressource Kubernetes où vous pouvez spécifier des informations sur d'autres ressources ou capacités requises pour exécuter votre application, telles que services, stockage persistant ou annotations. Vous documentez un déploiement dans un fichier de configuration YAML que vous appliquez au cluster. Le maître Kubernetes configure les ressources et déploie des conteneurs dans des pods sur les noeuds worker avec la capacité disponible.
</br></br>
Définissez des stratégies de mise à jour de votre application, notamment le nombre de pods que vous voulez ajouter lors d'une mise à jour tournante et le nombre de pods pouvant être indisponibles à un moment donné. Lorsque vous effectuez une mise à jour tournante, le déploiement vérifie si la mise à jour fonctionne et l'arrête si des échecs sont détectés.</dd>

<dt>Pod</dt>
<dd>Chaque application conteneurisée déployée dans un cluster est déployée, exécutée et gérée par une ressource a Kubernetes dénommée pod. Les pods sont de petites unités déployables dans un cluster Kubernetes et servent à regrouper des conteneurs devant être traités comme une seule unité. Dans la plupart des cas, chaque conteneur est déployé sur son propre pod. Toutefois, une application peut nécessiter qu'un conteneur et d'autres conteneurs auxiliaires soient déployés dans un même pod afin qu'ils soient accessibles via la même adresse IP privée.</dd>

<dt>Application</dt>
<dd>Une application peut se référer à une application complète ou à un composant d'une application. Vous pourriez déployer des composants d'une application dans des composants séparée ou des noeuds worker séparés.
</br></br>
Pour en savoir plus sur la terminologie de Kubernetes, <a href="cs_tutorials.html#cs_cluster_tutorial" target="_blank">exécutez le tutoriel</a>.</dd>

</dl>

<br />


## Architecture de service
{: #architecture}

Chaque noeud worker est configuré avec un moteur Docker Engine géré par {{site.data.keyword.IBM_notm}}, des ressources de traitement, réseau, et service de volume séparées, ainsi que des fonctions de sécurité intégrées assurant l'isolation des ressources et offrant des fonctionnalités pour leur gestion tout en assurant la conformité des noeuds d'agent avec les règles de sécurité. Le noeud worker communique avec le maître par l'entremise de certificats TLS sécurisés et d'une connexion openVPN.
{:shortdesc}

![{{site.data.keyword.containerlong_notm}} Architecture Kubernetes](images/cs_org_ov.png)

Le diagramme présente les éléments dont vous êtes responsable dans un cluster et ceux dont IBM se charge. Pour plus d'informations sur ces tâches de maintenance, voir [Responsabilités de gestion de cluster](cs_why.html#responsibilities).

<br />

