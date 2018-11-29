---

copyright:
  years: 2014, 2018
lastupdated: "2018-10-25"


---

{:new_window: target="blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# Droits d'accès des utilisateurs
{: #understanding}



Lorsque vous [affectez des droits pour un cluster](cs_users.html), il peut être difficile de déterminer le rôle à attribuer à un utilisateur. Utilisez les tableaux présentés dans les sections suivantes pour déterminer les droits minimum requis pour effectuer des tâches courantes dans {{site.data.keyword.containerlong}}.
{: shortdesc}

## Plateforme IAM et RBAC Kubernetes
{: #platform}

{{site.data.keyword.containerlong_notm}} est configuré pour utiliser des rôles Identity and Access Management (IAM) d'{{site.data.keyword.Bluemix_notm}}. Les rôles de plateforme IAM déterminent les actions que les utilisateurs peuvent effectuer sur un cluster. Tous les utilisateurs auxquels est affecté un rôle de plateforme IAM ont un rôle de contrôle d'accès basé sur les rôles (RBAC) Kubernetes correspondant qui leur est automatiquement affecté dans l'espace de nom par défaut. De plus, les rôles de plateforme IAM définissent automatiquement des droits d'infrastructure de base pour les utilisateurs. Pour définir des règles IAM, voir [Affectation de droits de plateforme IAM](cs_users.html#platform). Pour en savoir plus sur les rôles RBAC, voir [Affectation de droits RBAC](cs_users.html#role-binding).

Le tableau suivant présente les droits de gestion de cluster octroyés par chaque rôle de plateforme IAM et les droits sur les ressources Kubernetes des rôles RBAC correspondants.

<table>
  <tr>
    <th>Rôle de plateforme IAM</th>
    <th>Droits de gestion de cluster</th>
    <th>Rôle RBAC correspondant et droits sur les ressources</th>
  </tr>
  <tr>
    <td>**Afficheur**</td>
    <td>
      Cluster :<ul>
        <li>Afficher le nom et l'adresse e-mail du propriétaire de la clé d'API d'un groupe de ressources et d'une région</li>
        <li>Si le compte {{site.data.keyword.Bluemix_notm}} utilise d'autres données d'identification pour accéder au portefeuille de l'infrastructure IBM Cloud (SoftLayer), afficher le nom de l'utilisateur de l'infrastructure</li>
        <li>Afficher tout ou les détails des clusters, des noeuds worker, des pools de noeuds worker, des services dans un cluster et des webhooks</li>
        <li>Afficher le statut de la fonction spanning VLAN pour le compte d'infrastructure</li>
        <li>Afficher la liste de tous les sous-réseaux disponibles dans le compte d'infrastructure</li>
        <li>Lorsque ce rôle est défini pour un cluster unique : afficher la liste des VLAN auxquels est connecté le cluster dans une zone</li>
        <li>Lorsque ce rôle est défini pour tous les clusters du compte : afficher la liste de tous les réseaux locaux virtuels (VLAN) disponibles dans une zone</li></ul>
      Consignation :<ul>
        <li>Afficher le noeud final de consignation par défaut correspondant à la région cible</li>
        <li>Afficher la liste ou les détails des configurations de filtrage et d'acheminement des journaux</li>
        <li>Afficher le statut des mises à jour automatiques du module complémentaire Fluent</li></ul>
      Ingress :<ul>
        <li>Afficher la liste ou les détails des équilibreurs de charge d'application (ALB) d'un cluster</li>
        <li>Afficher les types d'ALB pris en charge dans la région</li></ul>
    </td>
    <td>Le rôle de cluster <code>view</code> est appliqué par la liaison de rôle <code>ibm-view</code>, il fournit les droits suivants dans l'espace de nom <code>default</code> :<ul>
      <li>Accès en lecture aux ressources dans l'espace de nom par défaut</li>
      <li>Aucun accès en lecture aux valeurs confidentielles (secrets) de Kubernetes</li></ul>
    </td>
  </tr>
  <tr>
    <td>**Editeur** <br/><br/><strong>Astuce</strong> : utilisez ce rôle pour les développeurs d'applications, et affectez le rôle **Developer** de <a href="#cloud-foundry">Cloud Foundry</a>.</td>
    <td>Ce rôle dispose de tous les droits du rôle Afficheur avec en plus les droits suivants :</br></br>
      Cluster :<ul>
        <li>Lier des services {{site.data.keyword.Bluemix_notm}} à un cluster et les dissocier</li></ul>
      Consignation :<ul>
        <li>Créer, mettre à jour et supprimer des webhooks d'audit de serveur d'API</li>
        <li>Créer des webhooks de cluster</li>
        <li>Créer et supprimer des configurations d'acheminement des journaux pour tous les types sauf `kube-audit`</li>
        <li>Mettre à jour et actualiser les configurations d'acheminement des journaux</li>
        <li>Créer, mettre à jour et supprimer des configurations de filtrage de journaux</li></ul>
      Ingress :<ul>
        <li>Activer ou désactiver des équilibreurs de charge d'application (ALB)</li></ul>
    </td>
    <td>Le rôle de cluster <code>edit</code> est appliqué par la liaison de rôle <code>ibm-edit</code>, il fournit les droits suivants dans l'espace de nom <code>default</code> :
      <ul><li>Accès en lecture/écriture aux ressources dans l'espace de nom par défaut</li></ul></td>
  </tr>
  <tr>
    <td>**Opérateur**</td>
    <td>Ce rôle dispose de tous les droits du rôle Afficheur avec en plus les droits suivants :</br></br>
      Cluster :<ul>
        <li>Mettre à jour un cluster</li>
        <li>Actualiser le maître Kubernetes</li>
        <li>Ajouter et retirer des noeuds worker</li>
        <li>Réamorcer, recharger et mettre à jour des noeuds worker</li>
        <li>Créer et supprimer des pools de noeuds worker</li>
        <li>Ajouter et retirer des zones dans les pools de noeuds worker</li>
        <li>Mettre à jour la configuration réseau pour une zone donnée dans les pools de noeuds worker</li>
        <li>Redimensionner et rééquilibrer les pools de noeuds worker</li>
        <li>Créer et ajouter des sous-réseaux dans un cluster</li>
        <li>Ajouter et retirer des sous-réseaux gérés par l'utilisateur dans un cluster</li></ul>
    </td>
    <td>Le rôle de cluster <code>admin</code> est appliqué par la liaison de rôle de cluster <code>ibm-operate</code>, il fournit les droits suivants :<ul>
      <li>Accès en lecture/écriture aux ressources dans un espace de nom mais pas à l'espace de nom même</li>
      <li>Créer des rôles RBAC dans un espace de nom</li></ul></td>
  </tr>
  <tr>
    <td>**Administrateur**</td>
    <td>Ce rôle dispose de tous les droits des rôles Editeur, Opérateur et Afficheur, avec en plus les droits suivants :</br></br>
      Cluster :<ul>
        <li>Créer des clusters gratuits ou standard</li>
        <li>Supprimer des clusters</li>
        <li>Chiffrer des valeurs confidentielles (secrets) de Kubernetes à l'aide d'{{site.data.keyword.keymanagementservicefull}}</li>
        <li>Définir la clé d'API pour le compte {{site.data.keyword.Bluemix_notm}} afin d'accéder au portefeuille de l'infrastructure IBM Cloud (SoftLayer) lié</li>
        <li>Définir, afficher et retirer des données d'identification pour le compte {{site.data.keyword.Bluemix_notm}} afin d'accéder à un autre portefeuille de l'infrastructure IBM Cloud (SoftLayer)</li>
        <li>Affecter et modifier des rôles de plateforme IAM pour d'autres utilisateurs existants dans le compte</li>
        <li>Lorsque ce rôle est défini pour toutes les instances {{site.data.keyword.containerlong_notm}} instances (clusters) dans toutes les régions : afficher tous les VLAN disponibles dans le compte</ul>
      Consignation :<ul>
        <li>Créer et mettre à jour des configurations d'acheminement des journaux de type `kube-audit`</li>
        <li>Collecter un instantané des journaux de serveur d'API dans un compartiment {{site.data.keyword.cos_full_notm}}</li>
        <li>Activer et désactiver les mises à jour automatiques du module complémentaire de cluster Fluentd</li></ul>
      Ingress :<ul>
        <li>Afficher tout ou les détails des valeurs confidentielles (secrets) d'ALB dans un cluster</li>
        <li>Déployer un certificat depuis votre instance {{site.data.keyword.cloudcerts_long_notm}} vers un équilibreur de charge d'application (ALB)</li>
        <li>Mettre jour ou retirer des valeurs confidentielles d'ALB dans un cluster</li></ul>
      <strong>Remarque</strong> : pour créer des ressources, telles que des machines, des VLAN et des sous-réseaux, les administrateurs requièrent le rôle d'infrastructure **Superutilisateur**.
    </td>
    <td>Le rôle de cluster <code>cluster-admin</code> est appliqué par la liaison de rôle de cluster <code>ibm-admin</code>, il fournit les droits suivants :
      <ul><li>Accès en lecture/écriture aux ressources dans tous les espaces de nom</li>
      <li>Créer des rôles RBAC dans un espace de nom</li>
      <li>Accéder au tableau de bord Kubernetes</li>
      <li>Créer une ressource Ingress qui rend les applications accessibles au public</li></ul>
    </td>
  </tr>
</table>



## Rôles Cloud Foundry
{: #cloud-foundry}

Les rôles Cloud Foundry octroient l'accès aux organisations et espaces figurant dans le compte. Pour afficher la liste des services Cloud Foundry dans {{site.data.keyword.Bluemix_notm}}, exécutez la commande `ibmcloud service list`. Pour en savoir plus, voir tous les [rôles d'organisation et d'espace](/docs/iam/cfaccess.html) ou la procédure à utiliser pour [gérer l'accès à Cloud Foundry](/docs/iam/mngcf.html) dans la documentation IAM.

Le tableau suivant présente les rôles Cloud Foundry requis pour pouvoir effectuer des actions dans les clusters.

<table>
  <tr>
    <th>Rôle Cloud Foundry</th>
    <th>Droits de gestion de cluster</th>
  </tr>
  <tr>
    <td>Rôle d'espace : Responsable</td>
    <td>Gérer l'accès utilisateur à un espace {{site.data.keyword.Bluemix_notm}}</td>
  </tr>
  <tr>
    <td>Rôle d'espace : Développeur</td>
    <td>
      <ul><li>Créer des instances de service {{site.data.keyword.Bluemix_notm}}</li>
      <li>Lier des instances de service {{site.data.keyword.Bluemix_notm}} à des clusters</li>
      <li>Afficher les journaux à partir d'une configuration d'acheminement des journaux au niveau de l'espace</li></ul>
    </td>
  </tr>
</table>

## Rôles Infrastructure
{: #infra}

**Remarque** : lorsqu'un utilisateur avec le rôle d'accès Infrastructure **Superutilisateur** [définit la clé d'API pour une région et un groupe de ressources](cs_users.html#api_key), les droits d'infrastructure pour les autres utilisateurs du compte sont définis par des rôles de plateforme IAM. Vous n'avez pas besoin de modifier les droits de l'infrastructure IBM Cloud (SoftLayer) des autres utilisateurs. Utilisez uniquement le tableau suivant pour personnaliser les droits de l'infrastructure IBM Cloud (SoftLayer) des utilisateurs lorsque vous ne pouvez pas affecter le rôle **Superutilisateur** à l'utilisateur qui définit la clé d'API. Pour plus d'informations, voir [Personnalisation des droits Infrastructure](cs_users.html#infra_access).

Le tableau suivant présente les droits requis pour effectuer des ensembles de tâches courantes.

<table summary="Droits Infrastructure pour les scénarios {{site.data.keyword.containerlong_notm}} courants.">
 <caption>Droits Infrastructure souvent requis pour {{site.data.keyword.containerlong_notm}}</caption>
 <thead>
  <th>Tâches courantes dans {{site.data.keyword.containerlong_notm}}</th>
  <th>Droits Infrastructure requis par onglet</th>
 </thead>
 <tbody>
   <tr>
     <td><strong>Droits minimum</strong> : <ul><li>Créer un cluster.</li></ul></td>
     <td><strong>Equipements</strong> :<ul><li>Afficher les détails du serveur virtuel</li><li>Réamorcer le serveur et afficher les informations système IPMI (Intelligent Platform Management Interface)</li><li>Emettre les rechargements de système d'exploitation et lancer le noyau de secours</li></ul><strong>Compte</strong> : <ul><li>Ajouter un serveur</li></ul></td>
   </tr>
   <tr>
     <td><strong>Administration de clusters</strong> : <ul><li>Créer, mettre à jour et supprimer des clusters.</li><li>Ajouter, recharger et réamorcer des noeuds worker.</li><li>Afficher les réseaux locaux virtuels (VLAN).</li><li>Créer des sous-réseaux.</li><li>Déployer des pods et charger des services d'équilibreur de charge.</li></ul></td>
     <td><strong>Support</strong> :<ul><li>Afficher les tickets</li><li>Ajouter des tickets</li><li>Editer des tickets</li></ul>
     <strong>Equipements</strong> :<ul><li>Afficher les informations détaillées sur le matériel</li><li>Afficher les détails du serveur virtuel</li><li>Réamorcer le serveur et afficher les informations système IPMI (Intelligent Platform Management Interface)</li><li>Emettre les rechargements de système d'exploitation et lancer le noyau de secours</li></ul>
     <strong>Réseau</strong> :<ul><li>Ajouter la fonction de calcul avec le port réseau public</li></ul>
     <strong>Compte</strong> :<ul><li>Annuler un serveur</li><li>Ajouter un serveur</li></ul></td>
   </tr>
   <tr>
     <td><strong>Stockage</strong> : <ul><li>Créer des réservations de volumes persistants pour mettre à disposition des volumes persistants.</li><li>Créer et gérer des ressources d'infrastructure de stockage.</li></ul></td>
     <td><strong>Services</strong> :<ul><li>Gérer le stockage</li></ul><strong>Compte</strong> :<ul><li>Ajouter du stockage</li></ul></td>
   </tr>
   <tr>
     <td><strong>Réseau privé</strong> : <ul><li>Gérer les VLAN privés pour la mise en réseau au sein d'un cluster.</li><li>Configurer la connectivité VPN pour les réseaux privés.</li></ul></td>
     <td><strong>Réseau</strong> :<ul><li>Gérer les routes de sous-réseau du réseau</li></ul></td>
   </tr>
   <tr>
     <td><strong>Réseau public</strong> :<ul><li>Configurer un équilibreur de charge public ou un réseau Ingress pour exposer des applications.</li></ul></td>
     <td><strong>Equipements</strong> :<ul><li>Editer le nom d'hôte/domaine</li><li>Gérer le contrôle de port</li></ul>
     <strong>Réseau</strong> :<ul><li>Ajouter la fonction de calcul avec le port réseau public</li><li>Gérer les routes de sous-réseau du réseau</li><li>Ajouter des adresses IP</li></ul>
     <strong>Services</strong> :<ul><li>Gérer DNS, RDNS et WHOIS</li><li>Afficher les certificats (SSL)</li><li>Gérer les certificats (SSL)</li></ul></td>
   </tr>
 </tbody>
</table>
