---

copyright:
  years: 2014, 2018
lastupdated: "2018-09-10"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}



# Vos responsabilités liées à l'utilisation d'{{site.data.keyword.containerlong_notm}}
Prenez connaissance des responsabilités qui vous incombent en matière de gestion de cluster et des dispositions applicables lorsque vous utilisez {{site.data.keyword.containerlong}}.
{:shortdesc}

## Responsabilités en matière de gestion de cluster
{: #responsibilities}

Passez en revue les responsabilités que vous partagez avec IBM pour gérer vos clusters.
{:shortdesc}

**IBM est chargé de :**

- Déployer le maître, les noeuds worker et les composants de gestion au sein du cluster, tels que l'équilibreur de charge d'application Ingress, en phase de création du cluster
- Gérer les mises à jour de sécurité, la surveillance, l'isolement et la reprise du maître Kubernetes pour le cluster
- Surveiller l'état de santé des noeuds worker et fournir l'automatisation pour leur mise à jour et leur reprise
- Effectuer des tâches d'automatisation dans votre compte d'infrastructure, notamment ajouter des noeuds worker, retirer des noeuds worker et créer un sous-réseau par défaut
- Gérer, mettre à jour et récupérer des composants opérationnels dans le cluster, tels que l'équilibreur de charge d'application Ingress et le plug-in de stockage
- Mettre à disposition des volumes de stockage lorsqu'ils sont demandés par des réservations de volume persistant
- Fournir des paramètres de sécurité sur tous les noeuds worker

</br>

**Vous êtes chargé de :**

- [Configurer votre compte {{site.data.keyword.Bluemix_notm}} pour accéder au portefeuille d'infrastructure IBM Cloud (SoftLayer)](cs_troubleshoot_clusters.html#cs_credentials)
- [Déployer et gérer les ressources Kubernetes, telles que les pods, services et déploiements, au sein du cluster](cs_app.html#app_cli)
- [Tirer parti des capacités du service et de Kubernetes pour assurer la haute disponibilité des applications](cs_app.html#highly_available_apps)
- [Ajouter ou retirer de la capacité d'un cluster en redimensionnant vos pools de noeuds worker](cs_clusters.html#add_workers)
- [Activer la fonction Spanning VLAN et maintenir vos pools de noeuds worker à zones multiples équilibrés entre les différentes zones](cs_clusters_planning.html#ha_clusters)
- [Créer des réseaux locaux virtuels (VLAN) publics et privés dans l'infrastructure IBM Cloud (SoftLayer) pour l'isolement réseau de votre cluster](/docs/infrastructure/vlans/getting-started.html#getting-started-with-vlans)
- [Assurer que tous les noeuds worker ont une connectivité réseau avec l'URL du maître Kubernetes](cs_firewall.html#firewall) <p>**Remarque** : si un noeud worker comporte à la fois des VLAN public et privé, la connectivité réseau est configurée. Si les noeuds worker sont configurés uniquement avec un VLAN privé, vous devez configurer une autre solution pour la connectivité du réseau. Pour plus d'informations, voir [Planification des réseaux de cluster privés uniquement](cs_network_cluster.html#private_vlan).</p>
- [Mettre à jour le processus kube-apiserver du maître lorsque des mises à jour de la version Kubernetes sont disponibles](cs_cluster_update.html#master)
- [Conserver les noeuds worker à jour sur les versions principale et secondaires, ainsi que les versions de correctif](cs_cluster_update.html#worker_node)
- [Récupérer les noeuds worker problématiques en exécutant des commandes `kubectl`, comme `cordon` ou `drain`, et des commandes `ibmcloud ks`, comme `reboot`, `reload` ou `delete`](cs_cli_reference.html#cs_worker_reboot)
- [Ajouter ou supprimer des sous-réseaux dans l'infrastructure IBM Cloud (SoftLayer) selon les besoins](cs_subnets.html#subnets)
- [Sauvegarder et restaurer des données dans du stockage persistant dans l'infrastructure IBM Cloud (SoftLayer) ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](../services/RegistryImages/ibm-backup-restore/index.html)
- Configurer des services de [consignation](cs_health.html#logging) et de [surveillance](cs_health.html#view_metrics) pour gérer la santé et les performances de votre cluster
- [Configurer la surveillance de l'état de santé des noeuds worker avec le système de reprise automatique](cs_health.html#autorecovery)
- Effectuer l'audit des événements qui modifient les ressources dans votre cluster, en utilisant par exemple [{{site.data.keyword.cloudaccesstrailfull}}](cs_at_events.html#at_events) pour afficher les activités initiées par l'utilisateur qui modifient l'état de votre instance {{site.data.keyword.containerlong_notm}}

<br />


## Usage abusif d'{{site.data.keyword.containerlong_notm}}
{: #terms}

Les clients ne doivent pas utiliser à mauvais escient {{site.data.keyword.containerlong_notm}}.
{:shortdesc}

L'utilisation à mauvais escient inclut :

*   Toute activité illégale
*   Distribution ou exécution de logiciel malveillant
*   Endommager {{site.data.keyword.containerlong_notm}} ou porter atteinte à l'utilisation d'{{site.data.keyword.containerlong_notm}} par autrui
*   Endommager ou porter atteinte à l'utilisation d'un autre service ou système par autrui
*   Accès non autorisé à un service ou système quelconque
*   Modification non autorisée d'un service ou système quelconque
*   Violation des droits d'autrui


Voir [Dispositions des services cloud](https://console.bluemix.net/docs/overview/terms-of-use/notices.html#terms) pour les conditions générales d'utilisation.
