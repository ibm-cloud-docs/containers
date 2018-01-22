---

copyright:
  years: 2014, 2017
lastupdated: "2017-12-11"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# A propos d'{{site.data.keyword.containerlong_notm}}
{: #cs_ov}

{{site.data.keyword.containershort}} proposes des outils puissants en combinant les technologies Docker et Kubernetes, une expérience utilisateur intuitive et une sécurité et un isolement intégrés pour automatiser le déploiement, l'opération, la mise à l'échelle et la surveillance d'applications conteneurisées dans un cluster d'hôtes de traitement.
{:shortdesc}


<br />


## Conteneurs Docker
{: #cs_ov_docker}

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
<dd>Les conteneurs simplifient l'administration du système en fournissant des environnements standardisés pour des déploiements en espace de développement et de production. L'environnement d'exécution simple un dimensionnement rapide par majoration ou atténuation des déploiements. Libérez-vous de la complexité de gérer des plateformes de système d'exploitation différentes et leur infrastructures sous-jacentes eu utilisant des conteneurs qui vous aideront à déployer et à exécuter rapidement et de manière fiable n'importe quelle application sur une infrastructure quelconque.</dd>
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
<dd>Un déploiement est une ressource Kubernetes où vous pouvez spécifier des informations sur d'autres ressources ou capacités requises pour exécuter votre application, telles que services, stockage persistant ou annotations. Vous documentez un déploiement dans un fichier de configuration YAML que vous appliquez au cluster. Le maître Kubernetes configure les ressources et déploie des conteneurs dans des pods sur les noueds worker avec la capacité disponible.
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


## Avantages de l'utilisation de clusters
{: #cs_ov_benefits}

Les clusters sont déployés sur des hôtes de calcul qui fournissent des capacités Kubernetes natives et des capacités ajoutées par {{site.data.keyword.IBM_notm}}.
{:shortdesc}

|Avantage|Description|
|-------|-----------|
|Clusters Kubernetes à service exclusif avec isolement de l'infrastructure de traitement, de réseau et de stockage|<ul><li>réez votre propre infrastructure personnalisée afin de répondre aux besoins de votre organisation.</li><li>Allouez à un maître Kubernetes dédié et sécurisé, des noeuds d'agent, des réseaux virtuels et un espace de stockage en utilisant les ressources fournies par l'infrastructure IBM Cloud (SoftLayer).</li><li>Stockez les données persistantes, partagez les données entre les pods Kubernetes et restaurez les données en cas de besoin avec le service de volumes intégré et sécurisé.</li><li>Le maître Kubernetes entièrement géré est constamment surveillé et mis à jour par {{site.data.keyword.IBM_notm}} pour que votre cluster soit toujours disponible.</li><li>Tirez parti de la prise en charge complète de toutes les API Kubernetes natives.</li></ul>|
|Conformité en matière de sécurité d'image avec Vulnerability Advisor|<ul><li>Configurez votre propre registre d'images Docker privé et sécurisée où les images sont stockées et partagés par tous les utilisateurs dans l'organisation.</li><li>Tirez parti de l'analyse automatique des images dans votre registre {{site.data.keyword.Bluemix_notm}} privé.</li><li>Examinez les recommandations spécifiques au système d'exploitation utilisé dans l'image afin de corriger les vulnérabilités potentielles.</li></ul>|
|Mise à l'échelle automatique des applications|<ul><li>Définissez des règles personnalisées afin d'élargir ou de contracter vos applications en fonction de la consommation d'UC et de mémoire.</li></ul>|
|Surveillance continue de l'état de santé du cluster|<ul><li>Utilisez le tableau de bord du cluster pour déterminer rapidement et gérer l'état de santé de votre cluster, des noeuds d'agent et des déploiements de conteneurs.</li><li>Accédez à des métriques de consommation détaillées en utilisant {{site.data.keyword.monitoringlong}} et élargissez rapidement votre cluster pour répondre aux charges de travail.</li><li>Examinez les informations de journalisation à l'aide d'{{site.data.keyword.loganalysislong}} pour voir les activités détaillées du cluster.</li></ul>|
|Reprise en ligne automatique des conteneurs défectueux|<ul><li>Vérifications en continu de l'état de santé des conteneurs déployés sur un noeud worker.</li><li>Recréation automatique des conteneurs en cas de défaillances.</li></ul>|
|Reconnaissance et gestion de services|<ul><li>Enregistrement centralisé des services d'application pour les rendre disponibles à d'autres applications dans votre cluster sans les exposer publiquement.</li><li>Reconnaissance des services enregistrés sans avoir à suivre le fil des modifications de leurs adresses IP ou des ID de conteneurs et exploitation du routage automatique vers les instances disponibles.</li></ul>|
|Exposition sécurisée des services au public|<ul><li>Réseaux privés superposés avec prise en charge complète d'équilibreur de charge et d'Ingress pour rendre vos applications accessibles au public et équilibrer les charges de travail entre plusieurs noeuds d'agent sans avoir à suivre le fil des changements d'adresse IP dans votre cluster.</li><li>Possibilité de sélection d'une adresse IP publique, d'une route fournie par {{site.data.keyword.IBM_notm}} ou de votre propre domaine personnalisé pour accéder à des services dans votre cluster depuis Internet.</li></ul>|
|Intégration de services {{site.data.keyword.Bluemix_notm}}|<ul><li>Ajoutez des fonctionnalités supplémentaires à votre application via l'intégration de services {{site.data.keyword.Bluemix_notm}}, tels que les API Watson, Blockchain, services de données, Internet of Things, et facilitation de la simplification du processus de développement d'application et de gestion des conteneurs.</li></ul>|
{: caption="Tableau 1. Avantages de l'utilisation de clusters avec {{site.data.keyword.containerlong_notm}}" caption-side="top"}

<br />


## Architecture de service
{: #cs_ov_architecture}

Chaque noeud worker est configuré avec un moteur Docker Engine géré par {{site.data.keyword.IBM_notm}}, des ressources de traitement, réseau, et service de volume séparées, ainsi que des fonctions de sécurité intégrées assurant l'isolation des ressources et offrant des fonctionnalités pour leur gestion tout en assurant la conformité des noeuds d'agent avec les règles de sécurité. Le noeud worker communique avec le maître par l'entremise de certificats TLS sécurisés et d'une connexion openVPN.
{:shortdesc}

*Figure 1. Architecture de Kubernetes et opération réseau dans {{site.data.keyword.containershort_notm}}*

![{{site.data.keyword.containerlong_notm}} Architecture Kubernetes](images/cs_org_ov.png)

Le diagramme présente les éléments dont vous êtes responsable dans un cluster et ceux dont IBM se charge. Pour plus d'informations sur ces tâches de maintenance, voir [Responsabilités de gestion de cluster](cs_planning.html#responsibilities).

<br />


## Usage abusif de conteneurs
{: #cs_terms}

Les clients ne doivent pas utiliser à mauvais escient {{site.data.keyword.containershort_notm}}.
{:shortdesc}

L'utilisation à mauvais escient inclut :

*   Toute activité illégale
*   Distribution ou exécution de logiciel malveillant
*   Endommager {{site.data.keyword.containershort_notm}} ou porter atteinte à l'utilisation
d'{{site.data.keyword.containershort_notm}} par autrui
*   Endommager ou porter atteinte à l'utilisation d'un autre service ou système par autrui
*   Accès non autorisé à un service ou système quelconque
*   Modification non autorisée d'un service ou système quelconque
*   Violation des droits d'autrui

Voir [Dispositions des services cloud](/docs/navigation/notices.html#terms) pour les conditions générales d'utilisation.
