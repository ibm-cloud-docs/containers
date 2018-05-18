---

copyright:
  years: 2014, 2018
lastupdated: "2018-03-06"


---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Affectation d'accès utilisateur aux clusters
{: #users}

Vous pouvez octroyez l'accès à un cluster Kubernetes pour vous assurer que seuls les utilisateurs autorisés peuvent travailler avec le cluster et déployer des conteneurs sur le cluster dans {{site.data.keyword.containerlong}}.
{:shortdesc}


## Planification des processus de communication
En tant qu'administrateur de cluster, envisagez comment établir un processus de communication pour que les membres de votre organisation vous communiquent les demandes d'accès et faciliter votre organisation.
{:shortdesc}

Fournissez aux utilisateurs de votre cluster les instructions permettant de demander l'accès à un cluster ou d'obtenir l'aide d'un administrateur de cluster sur tout type de tâches courantes. Kubernetes ne facilitant pas ce type de communication, chaque équipe peut connaître des variations en terme de processus préféré.

Vous pouvez choisir l'une des méthodes suivantes ou constituer votre propre méthode.
- Créer un système de tickets
- Créer un modèle de formulaire
- Créer une page wiki
- Nécessiter une demande par e-mail
- Utiliser la méthode de suivi des incidents que vous employez déjà pour suivre le travail quotidien de votre équipe


## Gestion de l'accès au cluster
{: #managing}

Chaque utilisateur d'{{site.data.keyword.containershort_notm}} doit être affecté à une combinaison de rôles utilisateur spécifique au service qui détermine les actions qu'il peut effectuer.
{:shortdesc}

<dl>
<dt>Règles d'accès {{site.data.keyword.containershort_notm}}</dt>
<dd>Dans Identity and Access Management, les règles d'accès {{site.data.keyword.containershort_notm}} déterminent les actions de gestion de cluster que vous pouvez effectuer, comme la création ou la suppression de clusters, ou l'ajout ou la suppression de noeuds worker. Ces règles doivent être définies en conjonction avec des règles d'infrastructure. Vous pouvez octroyer l'accès aux clusters de façon régulière.</dd>
<dt>Règles d'accès d'infrastructure</dt>
<dd>Dans Identity and Access Management, les règles d'accès d'infrastructure permettent aux actions demandées dans l'interface utilisateur ou l'interface de ligne de commande d'{{site.data.keyword.containershort_notm}} de s'exécuter dans l'infrastructure IBM Cloud (SoftLayer). Ces règles doivent être définies en conjonction avec des règles d'accès {{site.data.keyword.containershort_notm}}. [En savoir plus sur les rôles d'infrastructure disponibles](/docs/iam/infrastructureaccess.html#infrapermission).</dd>
<dt>Groupes de ressources</dt>
<dd>Un groupe de ressources permet de regrouper des services {{site.data.keyword.Bluemix_notm}} de manière à pouvoir affecter rapidement des accès à des utilisateurs à plusieurs ressources à la fois. [Découvrez comment gérer des utilisateurs à l'aide de groupes de ressources](/docs/account/resourcegroups.html#rgs).</dd>
<dt>Rôles Cloud Foundry</dt>
<dd>Dans Identity and Access Management, chaque utilisateur doit être affecté à un rôle utilisateur Cloud Foundry. Ce rôle détermine les actions que peut effectuer l'utilisateur sur le compte {{site.data.keyword.Bluemix_notm}} (par exemple, inviter d'autres utilisateurs ou examiner l'utilisation du quota). [En savoir plus sur les rôles Cloud Foundry disponibles](/docs/iam/cfaccess.html#cfaccess).</dd>
<dt>Rôles RBAC Kubernetes</dt>
<dd>Chaque utilisateur auquel est affectée une règle d'accès {{site.data.keyword.containershort_notm}} est automatiquement affecté à un rôle RBAC Kubernetes.  Dans Kubernetes, les rôles RBAC déterminent les actions que vous pouvez effectuer sur des ressources Kubernetes dans le cluster. Les rôles RBAC ne sont configurés que pour l'espace de nom par défaut. L'administrateur du cluster peut ajouter des rôles RBAC pour d'autres espaces de nom dans le cluster. Consultez le tableau suivant dans la section [Règles et droits d'accès](#access_policies) pour voir le rôle RBAC qui correspond à la règle d'accès {{site.data.keyword.containershort_notm}}. Pour plus d'informations sur les rôles RBAC en général, voir [Using RBAC Authorization ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/admin/authorization/rbac/#api-overview) dans la documentation Kubernetes.</dd>
</dl>

<br />


## Règles et droits d'accès
{: #access_policies}

Examinez les règles d'accès et les autorisations que vous pouvez attribuer à des utilisateurs dans votre compte {{site.data.keyword.Bluemix_notm}}.
{:shortdesc}

Les rôles Opérateur et Editeur d'{{site.data.keyword.Bluemix_notm}} Identity Access and Management (IAM) ont des droits distincts. Si vous voulez qu'un utilisateur puisse, par exemple, ajouter des noeuds worker et lier des services, vous devez lui attribuer le rôle opérateur et le rôle éditeur. Pour plus d'informations sur les règles d'accès d'infrastructure correspondantes, voir [Personnalisation des droits de l'infrastructure pour un utilisateur](#infra_access).<br/><br/>Si vous modifiez la règle d'accès d'un utilisateur, les règles RBAC associées à cette modification dans votre cluster sont supprimées pour vous. </br></br>**Remarque :** lorsque vous rétromigrez des droits, par exemple si vous voulez affecter un accès de Visualiseur à un ancien administrateur de cluster, vous devez patienter quelques minutes, le temps que la rétromigration s'exécute.

|Règles d'accès {{site.data.keyword.containershort_notm}}|Autorisations de gestion de cluster|Autorisations sur les ressources Kubernetes|
|-------------|------------------------------|-------------------------------|
|Administrateur|Ce rôle hérite des autorisations des rôles Editeur, Opérateur et Visualiseur dans tous les clusters du compte. <br/><br/>Lorsqu'il est défini pour toutes les instances de service en cours :<ul><li>Créer un cluster gratuit ou standard</li><li>Définir les données d'identification pour un compte {{site.data.keyword.Bluemix_notm}} afin d'accéder au portefeuille d'infrastructure IBM Cloud (SoftLayer)</li><li>Supprimer un cluster</li><li>Affecter et modifier des règles d'accès {{site.data.keyword.containershort_notm}} pour d'autres utilisateurs existants dans ce compte.</li></ul><p>Lorsqu'il est défini pour un ID de cluster spécifique :<ul><li>Supprimer un cluster spécifique</li></ul></p>Règle d'accès d'infrastructure correspondante : Superutilisateur<br/><br/><strong>Remarque </strong>: pour créer des ressources telles que des machines, des réseaux locaux virtuels (VLAN) et des sous-réseaux, les utilisateurs ont besoin du rôle d'infrastructure **Superutilisateur**.|<ul><li>Rôle RBAC : cluster-admin</li><li>Accès en lecture/écriture aux ressources dans tous les espaces de nom</li><li>Créer des rôles au sein d'un espace de nom</li><li>Accès au tableau de bord Kubernetes</li><li>Créer une ressource Ingress permettant de rendre les applications publiquement disponibles</li></ul>|
|Opérateur|<ul><li>Ajouter des noeuds worker supplémentaires à un cluster</li><li>Supprimer des noeuds worker d'un cluster</li><li>Réamorcer un noeud worker</li><li>Recharger un noeud worker</li><li>Ajouter un sous-réseau à un cluster</li></ul><p>Règle d'accès d'infrastructure correspondante : [Personnalisée](#infra_access)</p>|<ul><li>Rôle RBAC : admin</li><li>Accès en lecture/écriture aux ressources dans l'espace de nom par défaut, mais non pas à l'espace de nom lui-même</li><li>Créer des rôles au sein d'un espace de nom</li></ul>|
|Editeur <br/><br/><strong>Conseil </strong>: utilisez ce rôle pour les développeurs d'application.|<ul><li>Lier un service {{site.data.keyword.Bluemix_notm}} à un cluster.</li><li>Dissocier un service {{site.data.keyword.Bluemix_notm}} d'un cluster.</li><li>Créer un webhook.</li></ul><p>Règle d'accès d'infrastructure correspondante : [Personnalisée](#infra_access)|<ul><li>Rôle RBAC : edit</li><li>Accès en lecture/écriture aux ressources dans l'espace de nom par défaut</li></ul></p>|
|Afficheur|<ul><li>Lister un cluster</li><li>Afficher les détails d'un cluster</li></ul><p>Règles d'accès d'infrastructure correspondante : visualisation uniquement</p>|<ul><li>Rôle RBAC : view</li><li>Accès en lecture aux ressources dans l'espace de nom par défaut</li><li>Pas d'accès en lecture aux valeurs confidentielles Kubernetes</li></ul>|

|Règles d'accès Cloud Foundry|Autorisations de gestion des comptes|
|-------------|------------------------------|
|Rôle d'organisation : gestionnaire|<ul><li>Ajouter des utilisateurs supplémentaires dans un compte {{site.data.keyword.Bluemix_notm}}</li></ul>| |
|Rôle d'espace : développeur|<ul><li>Créer des instances de service {{site.data.keyword.Bluemix_notm}}</li><li>Lier des instances de service {{site.data.keyword.Bluemix_notm}} à des clusters</li></ul>| 

<br />



## Description de la clé d'API IAM et de la commande `bx cs credentials-set`
{: #api_key}

Pour mettre à disposition et travailler avec des clusters dans votre compte, vous devez vérifier que vous avez un compte défini correctement pour accéder au portefeuille d'infrastructure IBM Cloud (SoftLayer). Selon la configuration de votre compte, vous pouvez utiliser la clé d'API IAM ou les données d'identification d'Infrastructure que vous avez définies manuellement avec la commande `bx cs credentials-set`.

<dl>
  <dt>Clé d'API IAM</dt>
  <dd>La clé d'API IAM (Identity and Access Management) est définie automatiquement pour une région lorsque la première action qui nécessite la politique de contrôle d'accès admin {{site.data.keyword.containershort_notm}} est effectuée. Par exemple, supposons que l'un de vos administrateurs crée le premier cluster dans la région <code>us-south</code>. Pour cette opération, la clé d'API IAM de cet utilisateur est stockée dans le compte correspondant à cette région. La clé d'API est utilisée pour commander l'infrastructure IBM Cloud (SoftLayer), par exemple de nouveaux noeuds worker ou réseaux locaux virtuels (VLAN).</br></br>
Lorsqu'un autre utilisateur effectue une action qui nécessite une interaction avec le portefeuille d'infrastructure IBM Cloud (SoftLayer) dans cette région, par exemple la création d'un nouveau cluster ou le rechargement d'un noeud worker, la clé d'API stockée est utilisée pour déterminer s'il dispose des droits suffisants requis pour effectuer cette action. Pour vous assurer que les actions liées à l'infrastructure dans votre cluster peuvent être effectuées sans problème, affectez à vos administrateurs la politique d'accès de l'infrastructure {{site.data.keyword.containershort_notm}} <strong>Superutilisateur</strong>. </br></br>Vous pouvez trouver le propriétaire actuel de la clé d'API en exécutant la commande [<code>bx cs api-key-info</code>](cs_cli_reference.html#cs_api_key_info). Si vous constatez que la clé d'API stockée pour une région nécessite une mise à jour, vous pouvez le faire en exécutant la commande [<code>bx cs api-key-reset</code>](cs_cli_reference.html#cs_api_key_reset). Cette commande nécessite la politique d'accès admin {{site.data.keyword.containershort_notm}} et stocke la clé d'API de l'utilisateur qui exécute cette commande dans le compte. </br></br> <strong>Remarque :</strong> la clé d'API stockée pour la région ne peut pas être utilisée si les données d'identification de l'infrastructure IBM Cloud (SoftLayer) ont été définies manuellement à l'aide de la commande <code>bx cs credentials-set</code>. </dd>
<dt>Données d'identification de l'infrastructure IBM Cloud (SoftLayer) via <code>bx cs credentials-set</code></dt>
<dd>Si vous disposez d'un compte de paiement à la carte {{site.data.keyword.Bluemix_notm}}, vous avez accès au portefeuille d'infrastructure IBM Cloud (SoftLayer) par défaut. Cependant, vous pouvez utiliser un autre compte d'infrastructure IBM Cloud (SoftLayer) dont vous disposez déjà pour commander l'infrastructure. Vous pouvez lier le compte de cette infrastructure à votre compte {{site.data.keyword.Bluemix_notm}} en utilisant la commande [<code>bx cs credentials-set</code>](cs_cli_reference.html#cs_credentials_set). </br></br>Si les données d'identification de l'infrastructure IBM Cloud (SoftLayer) sont définies manuellement, ces données sont utilisées pour commander l'infrastructure, même s'il existe déjà une clé d'API IAM pour ce compte. Si l'utilisateur dont les données d'identification sont stockées ne dispose pas des droits requis pour commander l'infrastructure, les actions liées à l'infrastructure, par exemple la création d'un cluster ou le rechargement d'un noeud worker risquent d'échouer.</br></br> Pour supprimer les données d'identification de l'infrastructure IBM Cloud (SoftLayer) définies manuellement, vous pouvez utiliser la commande [<code>bx cs credentials-unset</code>](cs_cli_reference.html#cs_credentials_unset). Une fois ces données supprimées, la clé d'API IAM est utilisée pour commander l'infrastructure. </dd>
</dl>

## Ajout d'utilisateurs à un compte {{site.data.keyword.Bluemix_notm}}
{: #add_users}

Vous pouvez ajouter des utilisateurs à un compte {{site.data.keyword.Bluemix_notm}} pour leur accorder un accès à vos clusters.
{:shortdesc}

Avant de commencer, vérifiez que vous détenez le rôle Gestionnaire Cloud Foundry pour un compte {{site.data.keyword.Bluemix_notm}}.

1.  [Ajoutez l'utilisateur au compte](../iam/iamuserinv.html#iamuserinv).
2.  Dans la section **Accès**, développez **Services**.
3.  Affectez un rôle d'accès {{site.data.keyword.containershort_notm}}. Dans la liste déroulante **Affecter l'accès à**, déterminez si vous voulez accorder l'accès uniquement à votre compte {{site.data.keyword.containershort_notm}} (**Ressource**) ou à un ensemble de diverses ressources de votre compte (**Groupe de ressources**).
  -  Pour **Ressource** :
      1. Dans la liste déroulante **Services**, sélectionnez **{{site.data.keyword.containershort_notm}}**.
      2. Dans la liste déroulante **Région**, sélectionnez celle où inviter l'utilisateur. **Remarque** : pour accéder aux clusters dans la [région Asie-Pacifique nord](cs_regions.html#locations), voir [Octroyer l'accès IAM aux utilisateurs pour les clusters dans la région Asie-Pacifique nord](#iam_cluster_region).
      3. Dans la liste déroulante **Instance de service**, sélectionnez le cluster où inviter l'utilisateur. Pour identifier l'ID d'un cluster spécifique, exécutez la commande `bx cs clusters`.
      4. Dans la section **Sélectionnez des rôles**, choisissez un rôle. Pour consulter la liste des actions prises en charge pour chaque rôle, voir [Règles et droits d'accès](#access_policies).
  - Pour **Groupe de ressources** :
      1. Dans la liste déroulante **Groupe de ressources**, sélectionnez le groupe de ressources qui contient des droits sur la ressource {{site.data.keyword.containershort_notm}} de votre compte.
      2. Dans la liste déroulante **Affecter l'accès à un groupe de ressources**, sélectionnez un rôle. Pour consulter la liste des actions prises en charge pour chaque rôle, voir [Règles et droits d'accès](#access_policies).
4. [Facultatif : affectez un rôle Cloud Foundry](/docs/iam/mngcf.html#mngcf).
5. [Facultatif : affectez un rôle d'infrastructure](/docs/iam/infrastructureaccess.html#infrapermission).
6. Cliquez sur **Inviter des utilisateurs**.

<br />


### Octroyer l'accès IAM aux utilisateurs pour les clusters dans la région Asie-Pacifique nord
{: #iam_cluster_region}

Lorsque vous [ajouter des utilisateurs dans votre compte {{site.data.keyword.Bluemix_notm}}](#add_users), vous sélectionnez les régions qui leur sont accessibles. Cependant, certaines régions, telles que l'Asie-Pacifique nord, ne sont pas forcément disponibles dans la console et doivent être ajoutées via l'interface de ligne de commande (CLI).
{:shortdesc}

Avant de commencer, vérifiez que vous êtes administrateur du compte {{site.data.keyword.Bluemix_notm}}.

1.  Connectez-vous à l'interface CLI {{site.data.keyword.Bluemix_notm}}. Sélectionnez le compte que vous voulez utiliser.

    ```
    bx login [--sso]
    ```
    {: pre}

    **Remarque :** si vous possédez un ID fédéré, exécutez la commande `bx login --sso` pour vous connecter à l'interface de ligne de commande {{site.data.keyword.Bluemix_notm}}. Entrez votre nom d'utilisateur et utilisez l'URL mentionnée dans la sortie CLI pour extraire votre code d'accès à usage unique. Si la connexion échoue alors que vous omettez l'option `--sso` et aboutit en incluant l'option `--sso`, ceci indique que votre ID est fédéré.

2.  Ciblez l'environnement auquel vous souhaitez accorder des droits, par exemple la région Asie-Pacifique nord (`jp-tok`). Pour plus d'informations sur les options de la commande, par exemple l'organisation et l'espace, voir la commande [`bluemix target`](../cli/reference/bluemix_cli/bx_cli.html#bluemix_target).

    ```
    bx target -r jp-tok
    ```
    {: pre}

3.  Récupérez le nom ou les ID des clusters de la région auxquels vous voulez octroyer l'accès.

    ```
    bx cs clusters
    ```
    {: pre}

4.  Récupérez les ID utilisateur auxquels vous voulez octroyer l'accès.

    ```
    bx account users
    ```
    {: pre}

5.  Sélectionnez les rôles pour la règle d'accès.

    ```
    bx iam roles --service containers-kubernetes
    ```
    {: pre}

6.  Octroyez l'accès utilisateur au cluster avec le rôle approprié. Dans cet exemple, les rôles `Operator` et `Editor` sont affectés à `user@example.com` pour trois clusters.

    ```
    bx iam user-policy-create user@example.com --roles Operator,Editor --service-name containers-kubernetes --region jp-tok --service-instance cluster1,cluster2,cluster3
    ```
    {: pre}

    Pour octroyer l'accès aux clusters existants et à venir dans la région, ne spécifiez pas l'indicateur `--service-instance`. Pour plus d'informations, voir la [commande `bluemix iam user-policy-create`](../cli/reference/bluemix_cli/bx_cli.html#bluemix_iam_user_policy_create).
    {:tip}

## Personnalisation des droits Infrastructure pour un utilisateur
{: #infra_access}

Lorsque vous définissez des règles d'infrastructure dans Identity and Access Management, des droits associés à un rôle sont attribués à un utilisateur. Pour personnaliser ces droits, vous devez vous connecter à l'infrastructure IBM Cloud (SoftLayer) et adapter ces droits.
{: #view_access}

Par exemple, les **utilisateurs de base** peuvent redémarrer un noeud worker, mais ne peuvent pas recharger un noeud worker. Sans attribuer à cette personne des droits **Superutilisateur**, vous pouvez adapter les droits sur l'infrastructure IBM Cloud (SoftLayer) et autoriser l'utilisateur à exécuter une commande de rechargement.

1.  Connectez-vous à votre [compte {{site.data.keyword.Bluemix_notm}}](https://console.bluemix.net/), puis sélectionnez **Infrastructure** dans le menu.

2.  Accédez à **Compte** > **Utilisateurs** > **Liste d'utilisateurs**.

3.  Pour modifier les droits, sélectionnez un nom de profil utilisateur ou la colonne **Accès à l'unité**.

4.  Dans l'onglet **Autorisations du portail**, personnalisez l'accès de l'utilisateur. Les droits dont les utilisateurs ont besoin dépendent des ressources d'infrastructure qu'ils doivent utiliser :

    * Utilisez la liste déroulante **Droits rapides** pour affecter le rôle **Superutilisateur** qui octroie tous les droits à l'utilisateur.
    * Utilisez la liste déroulante **Droits rapides** pour affecter le rôle **Utilisateur de base** qui octroie à l'utilisateur certains droits, mais pas la totalité.
    * Si vous ne voulez pas octroyer tous les droits avec le rôle **Superutilisateur** ou si vous devez ajouter des droits au-delà du rôle **Utilisateur de base**, consultez le tableau suivant qui décrit les droits nécessaires pour exécuter des tâches courantes dans {{site.data.keyword.containershort_notm}}.

    <table summary="Droits Infrastructure pour les scénarios {{site.data.keyword.containershort_notm}} courants.">
     <caption>Droits Infrastructure souvent requis pour {{site.data.keyword.containershort_notm}}</caption>
     <thead>
     <th>Tâches courantes dans {{site.data.keyword.containershort_notm}}</th>
     <th>Droits Infrastructure requis par onglet</th>
     </thead>
     <tbody>
     <tr>
     <td><strong>Droits minimum</strong>: <ul><li>Créer un cluster.</li></ul></td>
     <td><strong>Equipements</strong> :<ul><li>Afficher les détails du serveur virtuel</li><li>Réamorcer le serveur et afficher les informations système IPMI (Intelligent Platform Management Interface)</li><li>Emettre les rechargements de système d'exploitation et lancer le noyau de secours</li></ul><strong>Compte</strong> : <ul><li>Ajouter/mettre à niveau des instances cloud</li><li>Ajouter un serveur</li></ul></td>
     </tr>
     <tr>
     <td><strong>Administration de clusters</strong> : <ul><li>Créer, mettre à jour et supprimer des clusters.</li><li>Ajouter, recharger et redémarrer les noeuds worker.</li><li>Afficher les réseaux locaux virtuels (VLAN).</li><li>Créer des sous-réseaux.</li><li>Déployer des pods et charger des services d'équilibreur de charge.</li></ul></td>
     <td><strong>Support</strong> :<ul><li>Afficher les tickets</li><li>Ajouter des tickets</li><li>Editer des tickets</li></ul>
     <strong>Equipements</strong> :<ul><li>Afficher les détails du serveur virtuel</li><li>Réamorcer le serveur et afficher les informations système IPMI (Intelligent Platform Management Interface)</li><li>Mettre à niveau le serveur</li><li>Emettre les rechargements de système d'exploitation et lancer le noyau de secours</li></ul>
     <strong>Services</strong> :<ul><li>Gérer les clés SSH</li></ul>
     <strong>Compte</strong> :<ul><li>Afficher le récapitulatif du compte</li><li>Ajouter/mettre à niveau des instances cloud</li><li>Annuler le serveur</li><li>Ajouter un serveur</li></ul></td>
     </tr>
     <tr>
     <td><strong>Stockage</strong> : <ul><li>Créer des réservations de volumes persistants pour mettre à disposition des volumes persistants.</li><li>Créer et gérer des ressources d'infrastructure de stockage.</li></ul></td>
     <td><strong>Services</strong> :<ul><li>Gérer le stockage</li></ul><strong>Compte</strong> :<ul><li>Ajouter du stockage</li></ul></td>
     </tr>
     <tr>
     <td><strong>Réseau privé</strong> : <ul><li>Gérer les VLAN privés pour la mise en réseau au sein d'un cluster.</li><li>Configurer la connectivité VPN pour les réseaux privés.</li></ul></td>
     <td><strong>Réseau</strong> :<ul><li>Gérer les routes de sous-réseau du réseau</li><li>Gérer le spanning VLAN du réseau</li><li>Gérer les tunnels réseau IPSEC</li><li>Gérer les passerelles réseau</li><li>Administration VPN</li></ul></td>
     </tr>
     <tr>
     <td><strong>Réseau public</strong> :<ul><li>Configurer un équilibreur de charge public ou un réseau Ingress pour exposer des applications.</li></ul></td>
     <td><strong>Equipements</strong> :<ul><li>Gérer les équilibreurs de charge</li><li>Editer le nom d'hôte/domaine</li><li>Gérer le contrôle de port</li></ul>
     <strong>Réseau</strong> :<ul><li>Ajouter la fonction de calcul avec le port réseau public</li><li>Gérer les routes de sous-réseau du réseau</li><li>Gérer le spanning VLAN du réseau</li><li>Ajouter des adresses IP</li></ul>
     <strong>Services</strong> :<ul><li>Gérer DNS, RDNS et WHOIS</li><li>Afficher les certificats (SSL)</li><li>Gérer les certificats (SSL)</li></ul></td>
     </tr>
     </tbody></table>

5.  Pour enregistrer vos modifications, cliquez sur **Modifier droits pour le portail**.

6.  Dans l'onglet **Accès à l'unité**, sélectionnez les unités auxquelles accorder l'accès.

    * Dans la liste déroulante **Type d'unité**, vous pouvez octroyer l'accès à **Tous les serveurs virtuels**.
    * Pour autoriser l'accès utilisateur aux nouvelles unités créées, cochez la case **Accorder l'accès automatiquement lors de l'ajout de nouveaux appareils**.
    * Pour enregistrer vos modifications, cliquez sur **Mettre à jour l'accès à l'unité**.

7.  Revenez à la liste des profils utilisateur et vérifiez que l'**accès à l'unité** est accordé.

## Autorisation des utilisateurs avec des droits RBAC Kubernetes personnalisés
{: #rbac}

Les règles d'accès d'{{site.data.keyword.containershort_notm}} correspondent à certains rôles RBAC (Role-Based Access Control) de Kubernetes comme indiqué à la section [Règles et droits d'accès](#access_policies). Pour autoriser d'autres rôles Kubernetes qui diffèrent de la règle d'accès correspondante, vous pouvez personnaliser les rôles RBAC, puis affecter ces rôles à des personnes ou à des groupes d'utilisateurs.
{: shortdesc}

Par exemple, vous pouvez envisager d'octroyer des droits à une équipe de développeurs pour qu'ils travaillent sur un groupe d'API spécifique ou avec des ressources au sein d'un espace de nom Kubernetes dans le cluster, mais pas sur l'ensemble du cluster. Vous créez alors un rôle, puis associez ce rôle à des utilisateurs, en utilisant un nom d'utilisateur unique à {{site.data.keyword.containershort_notm}}. Pour plus d'informations, voir [Using RBAC Authorization ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/admin/authorization/rbac/#api-overview) dans la documentation Kubernetes.

Avant de commencer, [ciblez l'interface CLI de Kubernetes sur le cluster](cs_cli_install.html#cs_cli_configure).

1.  Créez le rôle avec l'accès que vous souhaitez affecter.

    1. Créez un fichier `.yaml` pour définir le rôle avec l'accès que vous souhaitez affecter.

        ```
        kind: Role
        apiVersion: rbac.authorization.k8s.io/v1
        metadata:
          namespace: default
          name: my_role
        rules:
        - apiGroups: [""]
          resources: ["pods"]
          verbs: ["get", "watch", "list"]
        - apiGroups: ["apps", "extensions"]
          resources: ["daemonsets", "deployments"]
          verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
        ```
        {: codeblock}

        <table>
        <caption>Tableau. Description des composants de ce fichier YAML</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants de ce fichier YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>kind</code></td>
        <td>Indiquez `Role` pour octroyer l'accès aux ressources au sein d'un seul espace de nom, ou `ClusterRole` pour l'accès aux ressources sur l'ensemble du cluster.</td>
        </tr>
        <tr>
        <td><code>apiVersion</code></td>
        <td><ul><li>Pour les clusters exécutant Kubernetes 1.8 ou version ultérieure, utilisez `rbac.authorization.k8s.io/v1`. </li><li>Pour les versions antérieures, utilisez `apiVersion: rbac.authorization.k8s.io/v1beta1`.</li></ul></td>
        </tr>
        <tr>
        <td><code>metadata/namespace</code></td>
        <td><ul><li>Pour kind: `Role` : Indiquez l'espace de nom Kubernetes auquel l'accès est octroyé.</li><li>N'utilisez pas la zone `namespace` si vous créez un rôle `ClusterRole` qui s'applique au niveau du cluster.</li></ul></td>
        </tr>
        <tr>
        <td><code>metadata/name</code></td>
        <td>Attribuez un nom au rôle et utilisez ce nom par la suite lorsque vous liez le rôle.</td>
        </tr>
        <tr>
        <td><code>rules/apiGroups</code></td>
        <td><ul><li>Indiquez les groupes d'API Kubernetes avec lesquels vous voulez que les utilisateurs puissent interagir, par exemple `"apps"`, `"batch"` ou `"extensions"`. </li><li>Pour accéder au groupe d'API principal sur le chemin REST `api/v1`, laissez le groupe vide : `[""]`.</li><li>Pour plus d'informations, voir [API groups![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/reference/api-overview/#api-groups) dans la documentation Kubernetes.</li></ul></td>
        </tr>
        <tr>
        <td><code>rules/resources</code></td>
        <td><ul><li>Indiquez les ressources Kubernetes auxquelles vous souhaitez octroyer l'accès, par exemple `"daemonsets"`, `"deployments"`, `"events"` ou `"ingresses"`.</li><li>Si vous indiquez `"nodes"`, le rôle dans la zone kind doit être `ClusterRole`.</li><li>Pour obtenir la liste des ressources, consultez le tableau intitulé [Resource types![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/reference/kubectl/cheatsheet/) dans l'aide-mémoire Kubernetes.</li></ul></td>
        </tr>
        <tr>
        <td><code>rules/verbs</code></td>
        <td><ul><li>Indiquez les types d'action que vous souhaitez que les utilisateurs soient en mesure d'effectuer, par exemple `"get"`, `"list"`, `"describe"`, `"create"` ou `"delete"`. </li><li>Pour obtenir la liste complètes des verbes, voir la documentation [`kubectl`![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands).</li></ul></td>
        </tr>
        </tbody>
        </table>

    2.  Créez le rôle dans votre cluster.

        ```
        kubectl apply -f <path_to_yaml_file>
        ```
        {: pre}

    3.  Vérifiez que le rôle est créé.

        ```
        kubectl get roles
        ```
        {: pre}

2.  Associez des utilisateurs au rôle.

    1. Créez un fichier `.yaml` pour associer les utilisateurs au rôle que vous avez créé. Notez l'unique URL à utiliser pour chaque nom dans 'subjects'.

        ```
        kind: RoleBinding
        apiVersion: rbac.authorization.k8s.io/v1
        metadata:
          name: my_role_team1
          namespace: default
        subjects:
        - kind: User
          name: https://iam.ng.bluemix.net/kubernetes#user1@example.com
          apiGroup: rbac.authorization.k8s.io
        - kind: User
          name: https://iam.ng.bluemix.net/kubernetes#user2@example.com
          apiGroup: rbac.authorization.k8s.io
        roleRef:
          kind: Role
          name: custom-rbac-test
          apiGroup: rbac.authorization.k8s.io
        ```
        {: codeblock}

        <table>
        <caption>Tableau. Description des composants de ce fichier YAML</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants de ce fichier YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>kind</code></td>
        <td>Pour `kind`, indiquez `RoleBinding` pour les deux types de fichiers `.yaml` de rôle : `Role` (espace de nom) et `ClusterRole` (ensemble du cluster).</td>
        </tr>
        <tr>
        <td><code>apiVersion</code></td>
        <td><ul><li>Pour les clusters exécutant Kubernetes 1.8 ou version ultérieure, utilisez `rbac.authorization.k8s.io/v1`. </li><li>Pour les versions antérieures, utilisez `apiVersion: rbac.authorization.k8s.io/v1beta1`.</li></ul></td>
        </tr>
        <tr>
        <td><code>metadata/namespace</code></td>
        <td><ul><li>Pour kind: `Role` : Indiquez l'espace de nom Kubernetes auquel l'accès est octroyé.</li><li>N'utilisez pas la zone `namespace` si vous créez un rôle `ClusterRole` qui s'applique au niveau du cluster.</li></ul></td>
        </tr>
        <tr>
        <td><code>metadata/name</code></td>
        <td>Indiquez le nom de liaison du rôle.</td>
        </tr>
        <tr>
        <td><code>subjects/kind</code></td>
        <td>Pour kind, indiquez `User`.</td>
        </tr>
        <tr>
        <td><code>subjects/name</code></td>
        <td><ul><li>Ajoutez l'adresse e-mail de l'utilisateur à l'URL suivante : `https://iam.ng.bluemix.net/kubernetes#`.</li><li>Par exemple, `https://iam.ng.bluemix.net/kubernetes#user1@example.com`</li></ul></td>
        </tr>
        <tr>
        <td><code>subjects/apiGroup</code></td>
        <td>Utilisez `rbac.authorization.k8s.io`.</td>
        </tr>
        <tr>
        <td><code>roleRef/kind</code></td>
        <td>Entrez la même valeur que pour `kind` dans le fichier `.yaml` du rôle : `Role` ou `ClusterRole`.</td>
        </tr>
        <tr>
        <td><code>roleRef/name</code></td>
        <td>Entrez le nom du fichier `.yaml` du rôle.</td>
        </tr>
        <tr>
        <td><code>roleRef/apiGroup</code></td>
        <td>Utilisez `rbac.authorization.k8s.io`.</td>
        </tr>
        </tbody>
        </table>

    2. Créez la ressource de liaison de rôle (rolebinding) dans votre cluster.

        ```
        kubectl apply -f <path_to_yaml_file>
        ```
        {: pre}

    3.  Vérifiez que la liaison est créée.

        ```
        kubectl get rolebinding
        ```
        {: pre}

Vous venez de créer et de lier un rôle RBAC Kubernetes personnalisé, effectuez à présent le suivi auprès des utilisateurs. Demandez-leur de tester une action qu'ils ont le droit d'effectuer en fonction du rôle, par exemple, supprimer un pod.
