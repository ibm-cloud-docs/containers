---

copyright:
  years: 2014, 2019
lastupdated: "2019-03-21"

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



# Vos responsabilités liées à l'utilisation d'{{site.data.keyword.containerlong_notm}}
Prenez connaissance des responsabilités qui vous incombent en matière de gestion de cluster et des dispositions applicables lorsque vous utilisez {{site.data.keyword.containerlong}}.
{:shortdesc}

## Responsabilités en matière de gestion de cluster
{: #responsibilities}

Passez en revue les responsabilités que vous partagez avec IBM pour gérer vos clusters.
{:shortdesc}

**IBM est chargé de :**

- Déployer le maître, les noeuds worker et les composants de gestion au sein du cluster, tels que l'équilibreur de charge d'application Ingress, en phase de création du cluster
- Fournir les mises à jour de sécurité, la surveillance, l'isolement et la reprise du maître Kubernetes pour le cluster
- Mettre à votre disposition les mises à jour et les correctifs de sécurité que vous êtes chargé d'appliquer aux noeuds worker de votre cluster
- Surveiller l'état de santé des noeuds worker et fournir l'automatisation pour leur mise à jour et leur reprise
- Effectuer des tâches d'automatisation dans votre compte d'infrastructure, notamment ajouter des noeuds worker, retirer des noeuds worker et créer un sous-réseau par défaut
- Gérer, mettre à jour et récupérer des composants opérationnels dans le cluster, tels que l'équilibreur de charge d'application Ingress et le plug-in de stockage
- Mettre à disposition des volumes de stockage lorsqu'ils sont demandés par des réservations de volume persistant
- Fournir des paramètres de sécurité sur tous les noeuds worker

</br>

**Vous êtes chargé de :**

- [Configurer la clé d'API {{site.data.keyword.containerlong_notm}} avec les droits appropriés pour accéder au portefeuille de l'infrastructure IBM Cloud (SoftLayer) et à d'autres services {{site.data.keyword.Bluemix_notm}}](/docs/containers?topic=containers-users#api_key)
- [Déployer et gérer les ressources Kubernetes, telles que les pods, services et déploiements, au sein du cluster](/docs/containers?topic=containers-app#app_cli)
- [Tirer parti des capacités du service et de Kubernetes pour assurer la haute disponibilité des applications](/docs/containers?topic=containers-app#highly_available_apps)
- [Ajouter ou retirer de la capacité d'un cluster en redimensionnant vos pools de noeuds worker](/docs/containers?topic=containers-clusters#add_workers)
- [Activer la fonction Spanning VLAN et maintenir vos pools de noeuds worker à zones multiples équilibrés entre les différentes zones](/docs/containers?topic=containers-plan_clusters#ha_clusters)
- [Créer des réseaux locaux virtuels (VLAN) publics et privés dans l'infrastructure IBM Cloud (SoftLayer) pour l'isolement réseau de votre cluster](/docs/infrastructure/vlans?topic=vlans-getting-started-with-vlans#getting-started-with-vlans)
- [Assurer que tous les noeuds worker ont une connectivité réseau avec les URL de noeud final de service Kubernetes](/docs/containers?topic=containers-firewall#firewall) <p class="note">Si un noeud worker comporte à la fois des VLAN public et privé, la connectivité réseau est configurée. Si les noeuds worker sont configurés uniquement avec un VLAN privé, vous devez permettre aux noeuds worker et au maître cluster de communiquer en [activant le noeud final de service privé](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_private) ou en [configurant un périphérique de passerelle](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_gateway). Si vous avez configuré un pare-feu, vous devez gérer et configurer ses paramètres pour autoriser l'accès à {{site.data.keyword.containerlong_notm}} et à d'autres services {{site.data.keyword.Bluemix_notm}} que vous utilisez avec le cluster.</p>
- [Mettre à jour le processus kube-apiserver du maître lorsque des mises à jour de la version Kubernetes sont disponibles](/docs/containers?topic=containers-update#master)
- [Conserver les noeuds worker à jour sur les versions principale et secondaire, ainsi que les versions de correctif](/docs/containers?topic=containers-update#worker_node) <p class="note">Vous ne pouvez pas modifier le système d'exploitation de votre noeud worker ou vous connecter au noeud worker. Les mises à jour de noeud worker sont fournies par IBM sous forme d'image du noeud worker complet incluant les derniers correctifs de sécurité. Pour appliquer les mises à jour, le noeud worker doit être réimagé et rechargé avec la nouvelle image. Les clés des superutilisateurs (root) font automatiquement l'objet d'une rotation lorsque le noeud est rechargé.</p>
- [Surveiller l'intégrité de votre cluster en configurant l'acheminement des journaux pour les composants de votre cluster](/docs/containers?topic=containers-health#health).   
- [Récupérer les noeuds worker problématiques en exécutant des commandes `kubectl`, comme `cordon` ou `drain`, et des commandes `ibmcloud ks`, comme `reboot`, `reload` ou `delete`](/docs/containers?topic=containers-cs_cli_reference#cs_worker_reboot)
- [Ajouter ou supprimer des sous-réseaux dans l'infrastructure IBM Cloud (SoftLayer) selon les besoins](/docs/containers?topic=containers-subnets#subnets)
- [Sauvegarder et restaurer des données dans du stockage persistant dans l'infrastructure IBM Cloud (SoftLayer) ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](/docs/services/RegistryImages/ibm-backup-restore?topic=RegistryImages-ibmbackup_restore_starter)
- Configurer des services de [consignation](/docs/containers?topic=containers-health#logging) et de [surveillance](/docs/containers?topic=containers-health#view_metrics) pour gérer la santé et les performances de votre cluster
- [Configurer la surveillance de l'état de santé des noeuds worker avec le système de reprise automatique](/docs/containers?topic=containers-health#autorecovery)
- Effectuer l'audit des événements qui modifient les ressources dans votre cluster, en utilisant par exemple [{{site.data.keyword.cloudaccesstrailfull}}](/docs/containers?topic=containers-at_events#at_events) pour afficher les activités initiées par l'utilisateur qui modifient l'état de votre instance {{site.data.keyword.containerlong_notm}}

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

Voir [Dispositions des services cloud](https://cloud.ibm.com/docs/overview/terms-of-use/notices.html#terms) pour prendre connaissance des conditions générales d'utilisation.
