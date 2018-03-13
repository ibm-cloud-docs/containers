---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-31"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Affectation d'un accès utilisateur aux clusters
{: #users}

Vous pouvez octroyer un accès au cluster à d'autres utilisateurs pour garantir que seuls les utilisateurs habilités puissent gérer le cluster et y déployer des applications.
{:shortdesc}


## Gestion de l'accès au cluster
{: #managing}

Chaque utilisateur d'{{site.data.keyword.containershort_notm}} doit être affecté à une combinaison de rôles utilisateur spécifique au service qui détermine les actions qu'il peut effectuer.
{:shortdesc}

<dl>
<dt>Règles d'accès {{site.data.keyword.containershort_notm}}</dt>
<dd>Dans Identity and Access Management, les règles d'accès {{site.data.keyword.containershort_notm}} déterminent les actions de gestion de cluster que vous pouvez effectuer, comme la création ou la suppression de clusters, ou l'ajout ou la suppression de noeuds worker. Ces règles doivent être définies en conjonction avec des règles d'infrastructure.</dd>
<dt>Règles d'accès à l'infrastructure</dt>
<dd>Dans Identity and Access Management, les règles d'accès à l'infrastructure permettent aux actions demandées dans l'interface utilisateur ou l'interface de ligne de commande d'{{site.data.keyword.containershort_notm}} de s'exécuter dans l'infrastructure IBM Cloud (SoftLayer). Ces règles doivent être définies en conjonction avec des règles d'accès à {{site.data.keyword.containershort_notm}}. [En savoir plus sur les rôles d'infrastructure disponibles](/docs/iam/infrastructureaccess.html#infrapermission).</dd>
<dt>Groupes de ressources</dt>
<dd>Un groupe de ressources permet de regrouper des services {{site.data.keyword.Bluemix_notm}} de manière à pouvoir affecter rapidement des accès à des utilisateurs à plusieurs ressources à la fois. [Découvrez comment gérer des utilisateurs à l'aide de groupes de ressources](/docs/account/resourcegroups.html#rgs).</dd>
<dt>Rôles Cloud Foundry</dt>
<dd>Dans Identity and Access Management, chaque utilisateur doit être affecté à un rôle utilisateur Cloud Foundry. Ce rôle détermine les actions que peut effectuer l'utilisateur sur le compte {{site.data.keyword.Bluemix_notm}} (par exemple, inviter d'autres utilisateurs ou examiner l'utilisation du quota). [En savoir plus sur les rôles Cloud Foundry disponibles](/docs/iam/cfaccess.html#cfaccess).</dd>
<dt>Rôles RBAC Kubernetes</dt>
<dd>Chaque utilisateur auquel est affectée une règle d'accès {{site.data.keyword.containershort_notm}} est automatiquement affecté à un rôle RBAC Kubernetes. Dans Kubernetes, les rôles RBAC déterminent les actions que vous pouvez effectuer sur des ressources Kubernetes dans le cluster. Les rôles RBAC ne sont configurés que pour l'espace de nom par défaut. L'administrateur du cluster peut ajouter des rôles RBAC pour d'autres espaces de nom dans le cluster. Pour plus d'informations, voir [Using RBAC Authorization ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/admin/authorization/rbac/#api-overview) dans la documentation Kubernetes.</dd>
</dl>

<br />


## Règles et droits d'accès
{: #access_policies}

Examinez les règles d'accès et les autorisations que vous pouvez attribuer à des utilisateurs dans votre compte {{site.data.keyword.Bluemix_notm}}. Les rôles opérateur et éditeur ont des droits distincts. Si vous voulez qu'un utilisateur puisse, par exemple, ajouter des noeuds d'agent et lier des services, vous devez lui attribuer le rôle opérateur et le rôle éditeur. Si vous modifiez la règle d'accès d'un utilisateur, {{site.data.keyword.containershort_notm}} nettoie pour vous les règles RBAC associées à la modification dans votre cluster.

|Règles d'accès {{site.data.keyword.containershort_notm}}|Autorisations de gestion de cluster|Autorisations sur les ressources Kubernetes|
|-------------|------------------------------|-------------------------------|
|Administrateur|Ce rôle hérite des autorisations des rôles Editeur, Opérateur et Visualiseur dans tous les clusters du compte. <br/><br/>Lorsqu'il est défini pour toutes les instances de service en cours :<ul><li>Créer un cluster gratuit ou standard</li><li>Définir les données d'identification pour un compte {{site.data.keyword.Bluemix_notm}} afin d'accéder au portefeuille d'infrastructure IBM Cloud (SoftLayer)</li><li>Supprimer un cluster</li><li>Affecter et modifier des règles d'accès {{site.data.keyword.containershort_notm}} pour d'autres utilisateurs existants dans ce compte.</li></ul><p>Lorsqu'il est défini pour un ID de cluster spécifique :<ul><li>Supprimer un cluster spécifique</li></ul></p>Règle d'accès à l'infrastructure correspondante : Superutilisateur<br/><br/><b>Remarque </b>: pour créer des ressources telles que des machines, des réseaux locaux virtuels (VLAN) et des sous-réseaux, les utilisateurs ont besoin du rôle d'infrastructure **Superutilisateur**.|<ul><li>Rôle RBAC : cluster-admin</li><li>Accès en lecture/écriture aux ressources dans tous les espaces de nom</li><li>Créer des rôles au sein d'un espace de nom</li><li>Accès au tableau de bord Kubernetes</li><li>Créer une ressource Ingress permettant de rendre les applications publiquement disponibles</li></ul>|
|Opérateur|<ul><li>Ajouter des noeuds d'agent supplémentaires à un cluster</li><li>Supprimer des noeuds d'agent d'un cluster</li><li>Réamorcer un noeud worker</li><li>Recharger un noeud worker</li><li>Ajouter un sous-réseau à un cluster</li></ul><p>Règles d'accès à l'infrastructure correspondante : Utilisateur de base</p>|<ul><li>Rôle RBAC : admin</li><li>Accès en lecture/écriture aux ressources dans l'espace de nom par défaut, mais non pas à l'espace de nom lui-même</li><li>Créer des rôles au sein d'un espace de nom</li></ul>|
|Editeur <br/><br/><b>Conseil </b>: utilisez ce rôle pour les développeurs d'application.|<ul><li>Lier un service {{site.data.keyword.Bluemix_notm}} à un cluster.</li><li>Dissocier un service {{site.data.keyword.Bluemix_notm}} d'un cluster.</li><li>Créer un webhook.</li></ul><p>Règles d'accès à l'infrastructure correspondante : Utilisateur de base|<ul><li>Rôle RBAC : edit</li><li>Accès en lecture/écriture aux ressources dans l'espace de nom par défaut</li></ul></p>|
|Afficheur|<ul><li>Lister un cluster</li><li>Afficher les détails d'un cluster</li></ul><p>Règles d'accès à l'infrastructure correspondante : visualisation uniquement</p>|<ul><li>Rôle RBAC : view</li><li>Accès en lecture aux ressources dans l'espace de nom par défaut</li><li>Pas d'accès en lecture aux valeurs confidentielles Kubernetes</li></ul>|

|Règles d'accès Cloud Foundry|Autorisations de gestion des comptes|
|-------------|------------------------------|
|Rôle d'organisation : gestionnaire|<ul><li>Ajouter des utilisateurs supplémentaires dans un compte {{site.data.keyword.Bluemix_notm}}</li></ul>| |
|Rôle d'espace : développeur|<ul><li>Créer des instances de service {{site.data.keyword.Bluemix_notm}}</li><li>Lier des instances de service {{site.data.keyword.Bluemix_notm}} à des clusters</li></ul>| 

<br />


## Ajout d'utilisateurs à un compte {{site.data.keyword.Bluemix_notm}}
{: #add_users}

Vous pouvez ajouter des utilisateurs supplémentaires à un compte {{site.data.keyword.Bluemix_notm}} pour leur accorder un accès à vos clusters.

Avant de commencer, vérifiez que vous détenez le rôle Gestionnaire Cloud Foundry pour un compte {{site.data.keyword.Bluemix_notm}}.

1.  [Ajoutez l'utilisateur au compte](../iam/iamuserinv.html#iamuserinv).
2.  Dans la section **Accès**, développez **Services**.
3.  Affectez un rôle d'accès {{site.data.keyword.containershort_notm}}. Dans la liste déroulante **Affecter l'accès à**, déterminez si vous voulez accorder l'accès uniquement à votre compte {{site.data.keyword.containershort_notm}} (**Ressource**) ou à un ensemble de diverses ressources de votre compte (**Groupe de ressources**).
  -  Pour **Ressource** :
      1. Dans la liste déroulante **Services**, sélectionnez **{{site.data.keyword.containershort_notm}}**.
      2. Dans la liste déroulante **Région**, sélectionnez celle où inviter l'utilisateur.
      3. Dans la liste déroulante **Instance de service**, sélectionnez le cluster où inviter l'utilisateur. Pour identifier l'ID d'un cluster spécifique, exécutez la commande `bx cs clusters`.
      4. Dans la section **Sélectionnez des rôles**, choisissez un rôle. Pour consulter la liste des actions prises en charge pour chaque rôle, voir [Règles et droits d'accès](#access_policies).
  - Pour **Groupe de ressources** :
      1. Dans la liste déroulante **Groupe de ressources**, sélectionnez le groupe de ressources qui contient des droits sur la ressource {{site.data.keyword.containershort_notm}} de votre compte.
      2. Dans la liste déroulante **Affecter l'accès à un groupe de ressources**, sélectionnez un rôle. Pour consulter la liste des actions prises en charge pour chaque rôle, voir [Règles et droits d'accès](#access_policies).
4. [Facultatif : affectez un rôle d'infrastructure](/docs/iam/mnginfra.html#managing-infrastructure-access).
5. [Facultatif : affectez un rôle Cloud Foundry](/docs/iam/mngcf.html#mngcf).
5. Cliquez sur **Inviter des utilisateurs**.

<br />


## Personnalisation des autorisations utilisateur pour l'infrastructure
{: #infra_access}

Lorsque vous définissez des règles sur l'infrastructure dans Identity and Access Management, des droits associés à un rôle sont attribués à un utilisateur. Pour personnaliser ces droits, vous devez vous connecter à l'infrastructure IBM Cloud (SoftLayer) et adapter ces droits.
{: #view_access}

Par exemple, les utilisateurs de base peuvent redémarrer un noeud worker, mais ne peuvent pas recharger un noeud worker. Sans attribuer à cette personne des droits superutilisateur, vous pouvez adapter les droits sur l'infrastructure IBM Cloud (SoftLayer) et autoriser l'utilisateur à exécuter une commande de rechargement.

1.  Connectez-vous à votre compte d'infrastructure IBM Cloud (SoftLayer).
2.  Sélectionnez un profil utilisateur à mettre à jour.
3.  Dans **Autorisations du portail**, personnalisez l'accès de l'utilisateur. Par exemple, pour ajouter une autorisation de rechargement, dans l'onglet **Périphériques**, sélectionnez **Rechargement du système d'exploitation et lancement du noyau de secours**.
9.  Sauvegardez vos modifications.
