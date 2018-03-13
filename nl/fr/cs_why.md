---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-30"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# Pourquoi utiliser {{site.data.keyword.containerlong_notm}}
{: #cs_ov}

{{site.data.keyword.containershort}} propose des outils puissants en combinant les technologies Docker et Kubernetes, une expérience utilisateur intuitive et une sécurité et un isolement intégrés pour automatiser le déploiement, l'opération, la mise à l'échelle et la surveillance d'applications conteneurisées dans un cluster d'hôtes de traitement.
{:shortdesc}

## Avantages de l'utilisation du service
{: #benefits}

Les clusters sont déployés sur des hôtes de calcul qui fournissent des capacités Kubernetes natives et des capacités spécifiques à {{site.data.keyword.IBM_notm}}.
{:shortdesc}

|Avantage|Description|
|-------|-----------|
|Clusters Kubernetes à service exclusif avec isolement de l'infrastructure de traitement, de réseau et de stockage|<ul><li>Créez votre propre infrastructure personnalisée afin de répondre aux besoins de votre organisation.</li><li>Allouez à un maître Kubernetes dédié et sécurisé, des noeuds d'agent, des réseaux virtuels et un espace de stockage en utilisant les ressources fournies par l'infrastructure IBM Cloud (SoftLayer).</li><li>Le maître Kubernetes entièrement géré est constamment surveillé et mis à jour par {{site.data.keyword.IBM_notm}} pour que votre cluster soit toujours disponible.</li><li>Stockez les données persistantes, partagez les données entre les pods Kubernetes et restaurez les données en cas de besoin avec le service de volumes intégré et sécurisé.</li><li>Tirez parti de la prise en charge complète de toutes les API Kubernetes natives.</li></ul>|
|Conformité en matière de sécurité d'image avec Vulnerability Advisor|<ul><li>Configurez votre propre registre d'images Docker privé et sécurisée où les images sont stockées et partagés par tous les utilisateurs dans l'organisation.</li><li>Tirez parti de l'analyse automatique des images dans votre registre {{site.data.keyword.Bluemix_notm}} privé.</li><li>Examinez les recommandations spécifiques au système d'exploitation utilisé dans l'image afin de corriger les vulnérabilités potentielles.</li></ul>|
|Surveillance continue de l'état de santé du cluster|<ul><li>Utilisez le tableau de bord du cluster pour déterminer rapidement et gérer l'état de santé de votre cluster, des noeuds d'agent et des déploiements de conteneurs.</li><li>Accédez à des métriques de consommation détaillées en utilisant {{site.data.keyword.monitoringlong}} et élargissez rapidement votre cluster pour répondre aux charges de travail.</li><li>Examinez les informations de journalisation à l'aide d'{{site.data.keyword.loganalysislong}} pour voir les activités détaillées du cluster.</li></ul>|
|Exposition sécurisée des applications au public|<ul><li>Possibilité de sélection d'une adresse IP publique, d'une route fournie par {{site.data.keyword.IBM_notm}} ou de votre propre domaine personnalisé pour accéder à des services dans votre cluster depuis Internet.</li></ul>|
|Intégration de services {{site.data.keyword.Bluemix_notm}}|<ul><li>Vous pouvez ajouter des fonctionnalités supplémentaires à votre application via l'intégration de services {{site.data.keyword.Bluemix_notm}}, tels que les API Watson, Blockchain, services de données ou Internet of Things.</li></ul>|



<br />


## Comparaison des clusters gratuits et standards
{: #cluster_types}

Vous pouvez créer un cluster gratuit ou n'importe quel nombre de clusters standards. Faites-vous la main avec les clusters gratuits pour vous familiariser et tester diverses fonctionnalités Kubernetes ou créez des clusters standards pour exploiter les pleines capacités Kubernetes pour déployer des applications.
{:shortdesc}

|Caractéristiques|Clusters gratuits|Clusters standard|
|---------------|-------------|-----------------|
|[Mise en réseau au sein d'un cluster](cs_secure.html#in_cluster_network)|<img src="images/confirm.svg" width="32" alt="Fonction disponible" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Fonction disponible" style="width:32px;" />|
|[Accès à des applications réseau publiques par un service NodePort](cs_network_planning.html#nodeport)|<img src="images/confirm.svg" width="32" alt="Fonction disponible" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Fonction disponible" style="width:32px;" />|
|[Gestion de l'accès utilisateur](cs_users.html#managing)|<img src="images/confirm.svg" width="32" alt="Fonction disponible" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Fonction disponible" style="width:32px;" />|
|[Accès au service {{site.data.keyword.Bluemix_notm}} depuis le cluster et les applications](cs_integrations.html#adding_cluster)|<img src="images/confirm.svg" width="32" alt="Fonction disponible" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Fonction disponible" style="width:32px;" />|
|[Espace disque sur le noeud worker pour stockage](cs_storage.html#planning)|<img src="images/confirm.svg" width="32" alt="Fonction disponible" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Fonction disponible" style="width:32px;" />|
|[Stockage de fichiers NFS persistant avec volumes](cs_storage.html#planning)| |<img src="images/confirm.svg" width="32" alt="Fonction disponible" style="width:32px;" />|
|[Accès à des applications réseau publiques ou privées par un service d'équilibreur de charge](cs_network_planning.html#loadbalancer)| |<img src="images/confirm.svg" width="32" alt="Fonction disponible" style="width:32px;" />|
|[Accès à des applications réseau publiques par un service Ingress](cs_network_planning.html#ingress)| |<img src="images/confirm.svg" width="32" alt="Fonction disponible" style="width:32px;" />|
|[Adresses IP publiques portables](cs_subnets.html#manage)| |<img src="images/confirm.svg" width="32" alt="Fonction disponible" style="width:32px;" />|
|[Surveillance et journalisation](cs_health.html#logging)| |<img src="images/confirm.svg" width="32" alt="Fonction disponible" style="width:32px;" />|
|[Disponible dans {{site.data.keyword.Bluemix_dedicated_notm}}](cs_dedicated.html#dedicated_environment)| |<img src="images/confirm.svg" width="32" alt="Fonction disponible" style="width:32px;" />|

<br />



## Responsabilités de gestion de cluster
{: #responsibilities}

Passez en revue les responsabilités que vous partagez avec IBM pour gérer vos clusters.
{:shortdesc}

**IBM est chargé de :**

- Déployer le maître, les noeuds d'agent et les composants de gestion au sein du cluster, tels que le contrôleur Ingress, en phase de création du cluster
- Gérer les mises à jour, la surveillance et la reprise du maître Kubernetes pour le cluster
- Surveiller l'état de santé des noeuds d'agent et fournir l'automatisation pour leur mise à jour et leur reprise
- Effectuer des tâches d'automatisation dans votre compte d'infrastructure, notamment ajouter des noeuds d'agent, retirer des noeuds d'agent et créer un sous-réseau par défaut
- Gérer, mettre à jour et récupérer des composants opérationnels dans le cluster, tels que le contrôleur Ingress et le plug-in de stockage
- Mettre à disposition des volumes de stockage lorsqu'ils sont demandés par des réservations de volume persistant
- Fournir des paramètres de sécurité sur tous les noeuds d'agent

</br>
**Vous êtes chargé de :**

- [Déployer et gérer les ressources Kubernetes, telles que les pods, services et déploiements, au sein du cluster](cs_app.html#app_cli)
- [Tirer parti des capacités du service et de Kubernetes pour assurer la haute disponibilité des applications](cs_app.html#highly_available_apps)
- [Ajouter ou retirer de la capacité en utilisant l'interface CLI pour ajouter ou retirer des noeuds d'agent](cs_cli_reference.html#cs_worker_add)
- [Création de réseaux locaux virtuels (VLAN) publics et privés dans l'infrastructure IBM Cloud (SoftLayer) pour isolement de votre cluster dans le réseau](/docs/infrastructure/vlans/getting-started.html#getting-started-with-vlans)
- [Assurer que tous les noeuds d'agent ont une connectivité réseau avec l'URL du maître Kubernetes](cs_firewall.html#firewall) <p>**Remarque** : si un noeud worker comporte à la fois des VLAN public et privé, la connectivité réseau est configurée. Si le noeud worker est configuré uniquement avec un VLAN privé, un Vyatta est requis pour fournir la connectivité réseau.</p>
- [Mettre à jour le kube-apiserver maître et les noeuds d'agent lorsque des mises à jour principales ou secondaires de Kubernetes sont disponibles](cs_cluster_update.html#master)
- [Récupération de noeuds worker problématiques en exécutant des commandes `kubectl`, comme `cordon` ou `drain`, et des commandes `bx cs`, comme `reboot`, `reload` ou `delete`](cs_cli_reference.html#cs_worker_reboot)
- [Ajout ou suppression de sous-réseaux dans IBM Cloud infrastructure (SoftLayer) selon les besoins](cs_subnets.html#subnets)
- [Sauvegarder et restaurer des données dans du stockage persistant dans l'infrastructure IBM Cloud (SoftLayer) ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](../services/RegistryImages/ibm-backup-restore/index.html)

<br />


## Usage abusif de conteneurs
{: #terms}

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
