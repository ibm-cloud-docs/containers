---

copyright:
  years: 2014, 2018
lastupdated: "2018-02-01"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# Initiation aux clusters dans {{site.data.keyword.Bluemix_dedicated_notm}}
{: #dedicated}

Si vous disposez d'un compte {{site.data.keyword.Bluemix_dedicated}}, vous pouvez déployer des clusters dans un environnement de cloud dédié (`https://<my-dedicated-cloud-instance>.bluemix.net`) et connectez-vous aux services {{site.data.keyword.Bluemix}} présélectionnés qui s'y exécutent également.
{:shortdesc}

Si vous ne disposez pas d'un compte {{site.data.keyword.Bluemix_dedicated_notm}}, vous pouvez vous [initier à {{site.data.keyword.containershort_notm}}](container_index.html#container_index) dans un compte {{site.data.keyword.Bluemix_notm}} public.

## A propos de l'environnement de cloud Dedicated
{: #dedicated_environment}

Avec un compte {{site.data.keyword.Bluemix_dedicated_notm}}, les ressources physiques disponibles sont dédiées exclusivement à votre cluster et ne sont pas partagées avec des clusters d'autres clients {{site.data.keyword.IBM_notm}}. Vous pourriez opter pour la mise en place d'un environnement {{site.data.keyword.Bluemix_dedicated_notm}} si vous voulez un isolement de votre cluster et que vous avez également besoin d'un tel isolement pour les autres services {{site.data.keyword.Bluemix_notm}} que vous utilisez. Si vous ne disposez pas d'un compte Dedicated, vous pouvez créer des clusters avec un matériel dédié dans {{site.data.keyword.Bluemix_notm}}.

Avec  la version {{site.data.keyword.Bluemix_dedicated_notm}}, vous pouvez créer des clusters depuis le catalogue dans la console Dedicated ou à l'aide de l'interface de ligne de commande d'{{site.data.keyword.containershort_notm}}. Lorsque vous utilisez la console Dedicated, vous vous connectez simultanément à vos comptes Dedicated et public à l'aide de votre IBMid. Cette double connexion vous permet d'accéder à vos clusters publics depuis votre console Dedicated. Lorsque vous utilisez l'interface de ligne de commande, vous vous connectez via votre noeud final Dedicated (`api.<my-dedicated-cloud-instance>.bluemix.net.`) et ciblez le noeud final d'API {{site.data.keyword.containershort_notm}} de la région publique associée à l'environnement Dedicated.

Les différences les plus significatives entre la version {{site.data.keyword.Bluemix_notm}} public et la version Dedicated sont les suivantes.

*   {{site.data.keyword.IBM_notm}} est propriétaire et gère le compte d'infrastructure IBM Cloud (SoftLayer) dans lequel les noeuds d'agent, les réseaux locaux virtuels (VLAN) et les sous-réseaux sont déployés, au lieu que vous en soyez le propriétaire.
*   Les spécifications pour ces réseaux locaux virtuels et sous-réseaux sont déterminées au moment où l'environnement Dedicated est activé, et non pas au moment où le cluster est créé.

### Différences en matière de gestion de cluster entre les environnements de cloud
{: #dedicated_env_differences}

|Zone|{{site.data.keyword.Bluemix_notm}} public|{{site.data.keyword.Bluemix_dedicated_notm}}|
|--|--------------|--------------------------------|
|Création de cluster|Créez un cluster gratuit ou soumettez les informations suivantes pour un cluster standard :<ul><li>Type de cluster</li><li>Nom</li><li>Emplacement</li><li>Type de machine</li><li>Nombre de noeuds d'agent</li><li>VLAN public</li><li>VLAN privé</li><li>Matériel</li></ul>|Soumettez les informations suivantes pour un cluster standard :<ul><li>Nom</li><li>Version Kubernetes</li><li>Type de machine</li><li>Nombre de noeuds d'agent</li></ul><p>**Remarque :** les paramètres de réseaux locaux virtuels et du matériel sont prédéfinis lors de la création de l'environnement {{site.data.keyword.Bluemix_notm}}.</p>|
|Matériel et propriétaire du cluster|Dans les clusters standards, le matériel peut être partagé avec d'autres clients {{site.data.keyword.IBM_notm}} ou vous être dédié exclusivement. Vous êtes propriétaire et gérez les réseaux locaux virtuels (VLAN) publics et privés dans votre compte d'infrastructure IBM Cloud (SoftLayer).|Dans les clusters sur {{site.data.keyword.Bluemix_dedicated_notm}}, le matériel est toujours dédié. IBM est le propriétaire et gère pour vous les réseaux locaux virtuels publics et privés. L'emplacement est prédéfini pour l'environnement {{site.data.keyword.Bluemix_notm}}.|
|Mise en réseau de l'équilibreur de charge et d'Ingress|Lors de la mise à disposition de clusters standards, les actions suivantes interviennent automatiquement.<ul><li>Un sous-réseau public portable et un sous-réseau portable privé sont liés à votre cluster et affectés à votre compte d'infrastructure IBM Cloud (SoftLayer).</li><li>Une adresse IP portable publique est utilisée pour un équilibreur de charge d'application à haute disponibilité et une route publique unique IP lui est affectée au format &lt;nom_cluster&gt;.containers.mybluemix.net. Vous pouvez utiliser cette route pour exposer plusieurs applications au public. Une adresse IP privée portable est utilisée pour un équilibreur de charge d'application privé.</li><li>Quatre adresses IP publiques portables et quatre adresses IP publiques privées portables sont affectées au cluster et peuvent être utilisées pour exposer des applications via des services d'équilibreur de charge. D'autres sous-réseaux peuvent être demandés via votre compte d'infrastructure IBM Cloud (SoftLayer).</li></ul>|Lorsque vous créez votre compte Dedicated, vous aboutissez à une décision de connectivité quant à la manière d'exposer et d'accéder à vos services de cluster. Si vous désirez utiliser vos propres plages d'entreprise (IP gérées par l'utilisateur, vous devez les indiquer lorsque vous [configurez un environnement {{site.data.keyword.Bluemix_dedicated_notm}}](/docs/dedicated/index.html#setupdedicated). <ul><li>Par défaut, aucun sous-réseau public portable n'est lié à des clusters que vous créez dans votre compte Dedicated. A la place, vous pouvez choisir le modèle de connectivité le mieux adapté à votre entreprise.</li><li>Après avoir créé le cluster, sélectionnez le type de sous-réseaux que vous désirez lier et utiliser avec votre cluster pour équilibreur de charge ou connectivité Ingress.<ul><li>Pour les sous-réseaux portables publics ou privés, vous pouvez [ajouter des sous-réseaux aux clusters](cs_subnets.html#subnets)</li><li>Pour les adresses IP gérées par l'utilisateur que vous avez fournies à IBM lors de l'intégration à Dedicated, vous pouvez [ajouter aux clusters des sous-réseaux gérés par l'utilisateur](#dedicated_byoip_subnets).</li></ul></li><li>Après avoir lié un  sous-réseau à votre cluster, le contrôleur Ingress est créé. Une route Ingress publique n'est créée que si vous utilisez un sous-réseau public portable.</li></ul>|
|Mise en réseau de NodePort|Vous pouvez exposer un port public sur votre noeud worker et utiliser l'adresse IP publique de ce noeud pour accès public au service dans le cluster.|Toutes les adresses IP publiques des noeuds d'agent sont bloquées par un pare-feu. Toutefois, pour les services {{site.data.keyword.Bluemix_notm}} qui sont ajoutés au cluster, le port de noeud est accessible via une adresse IP publique ou une adresse IP privée.|
|Stockage persistant|Utilisez [un provisionnement dynamique](cs_storage.html#create) ou un [provisionnement statique](cs_storage.html#existing) des volumes.|Utilisez un [provisionnement dynamique](cs_storage.html#create) des volumes. [Ouvrez un ticket de demande de service](/docs/get-support/howtogetsupport.html#getting-customer-support) pour demander une sauvegarde de vos volumes, une restauration de vos volumes et effectuer d'autres fonctions de stockage.</li></ul>|
|URL du registre d'images dans {{site.data.keyword.registryshort_notm}}|<ul><li>Sud et Est des Etats-Unis : <code>registry.ng bluemix.net</code></li><li>Sud du Royaume-Uni : <code>registry.eu-gb.bluemix.net</code></li><li>Europe centrale (Francfort) : <code>registry.eu-de.bluemix.net</code></li><li>Australie (Sydney) : <code>registry.au-syd.bluemix.net</code></li></ul>|<ul><li>Pour les nouveaux espaces de nom, utilisez les mêmes registres basés région que ceux définis pour {{site.data.keyword.Bluemix_notm}} public.</li><li>Pour les espaces de nom configurés pour les conteneurs uniques et évolutifs dans {{site.data.keyword.Bluemix_dedicated_notm}}, utilisez <code>registry.&lt;dedicated_domain&gt;</code></li></ul>|
|Accès au registre|Voir les options dans [Utilisation de registres d'images privés et publics avec {{site.data.keyword.containershort_notm}}](cs_images.html).|<ul><li>Pour les nouveaux espaces de nom, examinez les options dans [Utilisation de registres d'images privés et publics avec {{site.data.keyword.containershort_notm}}](cs_images.html).</li><li>Pour les espaces de nom configurés pour des groupes uniques et évolutifs, [utilisez un jeton et créez une valeur confidentielle Kubernetes](cs_dedicated_tokens.html#cs_dedicated_tokens) pour l'authentification.</li></ul>|
{: caption="Comparaison des fonctions entre {{site.data.keyword.Bluemix_notm}} public et {{site.data.keyword.Bluemix_dedicated_notm}}" caption-side="top"}

<br />


### Architecture de service
{: #dedicated_ov_architecture}

Chaque noeud worker est configuré avec un moteur Docker géré par {{site.data.keyword.IBM_notm}}, des ressources de traitement, un réseau et un service de volume distincts. Des fonctions de sécurité intégrées fournissent l'isolement, les capacités de gestion des ressources et la conformité de sécurité de noeud worker. Le noeud worker communique avec le maître par l'entremise de certificats TLS sécurisés et d'une connexion openVPN.
{:shortdesc}

*Architecture Kubernetes et opération réseau dans {{site.data.keyword.Bluemix_dedicated_notm}}*

![{{site.data.keyword.containershort_notm}} Architecture Kubernetes sur {{site.data.keyword.Bluemix_dedicated_notm}}](images/cs_dedicated_arch.png)

<br />


## Configuration de {{site.data.keyword.containershort_notm}} sur Dedicated
{: #dedicated_setup}

Chaque environnement {{site.data.keyword.Bluemix_dedicated_notm}} dispose d'un compte entreprise public, dont est propriétaire le client, dans {{site.data.keyword.Bluemix_notm}}. Pour que les utilisateurs de l'environnement Dedicated puissent créer des clusters, l'administrateur doit ajouter les utilisateurs à ce compte d'entreprise public pour l'environnement Dedicated.

Avant de commencer :
  * [Configurez un environnement {{site.data.keyword.Bluemix_dedicated_notm}}](/docs/dedicated/index.html#setupdedicated).
  * Si votre système local ou votre réseau d'entreprise contrôle des noeuds finaux sur l'Internet public en utilisant des proxies ou des pare-feux, vous devez [ouvrir les ports requis et les adresses IP sur votre pare-feu](cs_firewall.html#firewall).
  * [Téléchargez l'interface de ligne de commande (CLI) de Cloud Foundy![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://github.com/cloudfoundry/cli/releases) et [Ajoutez le plug-in de l'interface CLI d'IBM Cloud Admin](/docs/cli/plugins/bluemix_admin/index.html#adding-the-ibm-cloud-admin-cli-plug-in).

Pour permettre aux utilisateurs {{site.data.keyword.Bluemix_dedicated_notm}} d'accéder aux clusters :

1.  Le propriétaire de votre compte {{site.data.keyword.Bluemix_notm}} public doit générer une clé d'API.
    1.  Connectez-vous au noeud final pour votre instance {{site.data.keyword.Bluemix_dedicated_notm}}. Entrez les données d'identification {{site.data.keyword.Bluemix_notm}} pour le propriétaire du compte public et, à l'invite, sélectionnez votre compte.

        ```
        bx login -a api.<my-dedicated-cloud-instance>.<region>.bluemix.net
        ```
        {: pre}

        **Remarque :** Si vous disposez d'un ID fédéré, utilisez `bx login -a api.<my-dedicated-cloud-instance>.<region>.bluemix.net --sso` pour vous connecter à l'interface de ligne de commande {{site.data.keyword.Bluemix_notm}}. Entrez votre nom d'utilisateur et utilisez l'URL mentionnée dans la sortie CLI pour extraire votre code d'accès à usage unique. Si la connexion échoue lorsque vous omettez l'option `--sso` et aboutit en incluant l'option `--sso`, ceci indique que votre ID est fédéré.

    2.  Générez une clé d'API pour inviter des utilisateurs au compte public. Notez la valeur de la clé d'API, que l'administrateur du compte Dedicated utilisera à la prochaine étape.

        ```
        bx iam api-key-create <key_name> -d "Key to invite users to <dedicated_account_name>"
        ```
        {: pre}

    3.  Notez l'identificateur global unique (GUID) de l'organisation de compte public à laquelle vous désirez inviter des utilisateurs et que l'administrateur du compte Dedicated utilisera à la prochaine étape.

        ```
        bx account orgs
        ```
        {: pre}

2.  Le propriétaire de votre compte {{site.data.keyword.Bluemix_dedicated_notm}} peut inviter un ou plusieurs utilisateurs dans votre compte public.
    1.  Connectez-vous au noeud final pour votre instance {{site.data.keyword.Bluemix_dedicated_notm}}. Entrez les données d'identification {{site.data.keyword.Bluemix_notm}} pour le propriétaire du compte Dedicated et, à l'invite, sélectionnez votre compte.

        ```
        bx login -a api.<my-dedicated-cloud-instance>.<region>.bluemix.net
        ```
        {: pre}

        **Remarque :** Si vous disposez d'un ID fédéré, utilisez `bx login -a api.<my-dedicated-cloud-instance>.<region>.bluemix.net --sso` pour vous connecter à l'interface de ligne de commande {{site.data.keyword.Bluemix_notm}}. Entrez votre nom d'utilisateur et utilisez l'URL mentionnée dans la sortie CLI pour extraire votre code d'accès à usage unique. Si la connexion échoue lorsque vous omettez l'option `--sso` et aboutit en incluant l'option `--sso`, ceci indique que votre ID est fédéré.

    2.  Invitez les utilisateurs au compte public.
        * Pour inviter un utilisateur unique :

            ```
            bx cf bluemix-admin invite-users-to-public -userid=<user_email> -apikey=<public_api_key> -public_org_id=<public_org_id>
            ```
            {: pre}

            Remplacez <em>&lt;user_IBMid&gt;</em> par le courrier électronique de l'utilisateur à inviter, <em>&lt;public_api_key&gt;</em> par la clé d'API générée à l'étape précédente et <em>&lt;public_org_id&gt;</em> par l'identificateur global unique (GUID) de l'organisation de compte public. Voir [Invitation d'un utilisateur IBM Cloud Dedicated](/docs/cli/plugins/bluemix_admin/index.html#admin_dedicated_invite_public) pour plus d'informations sur cette commande.

        * Pour inviter tous les utilisateurs actuels d'une organisation  de compte Dedicated :

            ```
            bx cf bluemix-admin invite-users-to-public -organization=<dedicated_org_id> -apikey=<public_api_key> -public_org_id=<public_org_id>
            ```

            Remplacez <em>&lt;dedicated_org_id&gt;</em> par l'ID d'organisation de compte Dedicated, <em>&lt;public_api_key&gt;</em> par la clé d'API générée à l'étape précédente et <em>&lt;public_org_id&gt;</em> par l'identificateur global unique (GUID) de l'organisation de compte public. Voir [Invitation d'un utilisateur IBM Cloud Dedicated](/docs/cli/plugins/bluemix_admin/index.html#admin_dedicated_invite_public) pour plus d'informations sur cette commande.

    3.  Si un IBMid existe pour un utilisateur, l'utilisateur est automatiquement ajouté à l'organisation spécifiée dans le compte public. Si un IBMid n'existe pas encore pour un utilisateur, une invitation est envoyée à l'adresse électronique de l'utilisateur. Une fois que l'utilisateur accepte l'invitation, un IBMid est créé pour l'utilisateur et celui-ci est ajouté à l'organisation spécifiée dans le compte public.

    4.  Vérifiez que les utilisateurs ont été ajoutés au compte.

        ```
        bx cf bluemix-admin invite-users-status -apikey=<public_api_key>
        ```
        {: pre}

        Les utilisateurs invités avec un IBMid existant ont le statut `Actif`. Les utilisateurs invités sans IBMid existant ont un statut `En attente` ou `Actif` selon qu'ils ont déjà ou non accepté l'invitation au compte.

3.  Si un utilisateur a besoin d'autorisations de création de cluster,, vous devez lui attribuer le rôle Administrateur.

    1.  Dans la barre de menu de la console de l'édition Public, cliquez sur **Gérer > Sécurité > Identity and Access**, puis sur **Utilisateurs**.

    2.  Sur la ligne de l'utilisateur auquel vous voulez affecter un accès, sélectionnez le menu **Actions**, puis cliquez sur **Affecter un accès**.

    3.  Sélectionnez **Affecter l'accès aux ressources**.

    4.  Dans la liste **Services**, sélectionnez **IBM Cloud Container Service**.

    5.  Dans la liste **Région**, sélectionnez **Toutes les régions en cours** ou une région spécifique si vous y êtes invité.

    6. Sous **Sélectionnez des rôles**, sélectionnez Administrateur.

    7. Cliquez sur **Affecter**.

4.  Les utilisateurs peuvent à présent se connecter au noeud final du compte Dedicated pour commencer à créer des clusters.

    1.  Connectez-vous au noeud final pour votre instance {{site.data.keyword.Bluemix_dedicated_notm}}. A l'invite, entrez votre IBMid.

        ```
        bx login -a api.<my-dedicated-cloud-instance>.<region>.bluemix.net
        ```
        {: pre}

        **Remarque :** Si vous disposez d'un ID fédéré, utilisez `bx login -a api.<my-dedicated-cloud-instance>.<region>.bluemix.net --sso` pour vous connecter à l'interface de ligne de commande {{site.data.keyword.Bluemix_notm}}. Entrez votre nom d'utilisateur et utilisez l'URL mentionnée dans la sortie CLI pour extraire votre code d'accès à usage unique. Si la connexion échoue lorsque vous omettez l'option `--sso` et aboutit en incluant l'option `--sso`, ceci indique que votre ID est fédéré.

    2.  Si vous vous connectez pour la première fois, à l'invite, soumettez votre ID utilisateur Dedicated et votre mot de passe. Ceci authentifie le compte Dedicated et lie ensemble le compte Dedicated et le compte public. Chaque fois que vous vous connectez par la suite, vous n'avez besoin d'utiliser que votre IBMid. Pour plus d'informations, voir [Connexion d'un ID dédié à votre IBMid public](/docs/cli/connect_dedicated_id.html#connect_dedicated_id).

        **Remarque **: vous devez vous connecter à la fois à votre compte Dedicated et à votre compte public pour créer des clusters. Si vous désirez vous connecter seulement à votre compte Dedicated, utilisez l'indicateur `--no-iam` lors de la connexion au noeud final Dedicated.

    3.  Pour créer ou accéder à des clusters dans l'environnement dédié, vous devez définir la région associée à cet environnement.

        ```
        bx cs region-set
        ```
        {: pre}

5.  Si vous désirez annuler le lien de votre compte, vous pouvez déconnecter votre IBMid de votre ID utilisateur Dedicated . Pour plus d'informations, voir [Déconnexion de votre ID dédié de l'IBMid public](/docs/cli/connect_dedicated_id.html#disconnect-your-dedicated-id-from-the-public-ibmid).

    ```
    bx iam dedicated-id-disconnect
    ```
    {: pre}

<br />


## Création de clusters
{: #dedicated_administering}

Concevez la configuration de votre cluster {{site.data.keyword.Bluemix_dedicated_notm}} en vue d'une disponibilité et d'une capacité maximale.
{:shortdesc}

### Création de clusters depuis l'interface graphique
{: #dedicated_creating_ui}

1.  Ouvrez votre console Dedicated : `https://<my-dedicated-cloud-instance>.bluemix.net`.
2. Cochez la case **Also log in to {{site.data.keyword.Bluemix_notm}} Public** et cliquez sur **Connexion**.
3. Suivez les invites pour vous connecter avec votre IBMid. S'il s'agit de votre toutes première connexion à votre compte Dedicated, suivez les invites pour vous connecter à {{site.data.keyword.Bluemix_dedicated_notm}}.
4.  Dans le catalogue, sélectionnez **Conteneurs** et cliquez sur **Cluster Kubernetes**.
5.  Renseignez la zone **Nom du cluster**.
6.  Sélectionnez un **type de machine**. Le type de machine définit le nombre d'UC virtuelles et la mémoire configurée dans chaque noeud worker. Ces UC virtuelles et la mémoire sont disponibles pour tous les conteneurs que vous déployez dans vos noeuds.
    -   Le type de machine micro correspond à l'option la plus modique.
    -   Un type de machine équilibré a la même quantité de mémoire affectée à chaque UC, ce qui optimise les performances.
7.  Sélectionnez le **nombre de noeuds d'agent** dont vous avez besoin. Sélectionnez `3` pour assurer une haute disponibilité de votre cluster.
8.  Cliquez sur **Créer un cluster**. La section des informations détaillées sur le cluster s'ouvre, mais l'allocation de noeuds d'agent dans le cluster prend quelques minutes. Vous pouvez suivrez la progression du déploiement du noeud worker sur l'onglet **Noeuds worker**. Lorsque les noeuds d'agent sont prêts, l'état passe à **Ready**.

### Création de clusters depuis l'interface CLI
{: #dedicated_creating_cli}

1.  Installez l'interface de ligne de commande {{site.data.keyword.Bluemix_notm}} et le [plug-in {{site.data.keyword.containershort_notm}}](cs_cli_install.html#cs_cli_install).
2.  Connectez-vous au noeud final pour votre instance {{site.data.keyword.Bluemix_dedicated_notm}}. A l'invite, entrez vos données d'identification {{site.data.keyword.Bluemix_notm}} et sélectionnez votre compte.

    ```
    bx login -a api.<my-dedicated-cloud-instance>.<region>.bluemix.net
    ```
    {: pre}

    **Remarque :** Si vous disposez d'un ID fédéré, utilisez `bx login -a api.<my-dedicated-cloud-instance>.<region>.bluemix.net --sso` pour vous connecter à l'interface de ligne de commande {{site.data.keyword.Bluemix_notm}}. Entrez votre nom d'utilisateur et utilisez l'URL mentionnée dans la sortie CLI pour extraire votre code d'accès à usage unique. Si la connexion échoue lorsque vous omettez l'option `--sso` et aboutit en incluant l'option `--sso`, ceci indique que votre ID est fédéré.

3.  Pour cibler une région, exécutez la commande `bx cs region-set`.

4.  Créez un cluster avec la commande `cluster-create`. Lorsque vous créez un cluster standard, le matériel du noeud worker est facturé par heures d'utilisation.

    Exemple :

    ```
    bx cs cluster-create --location <location> --machine-type <machine-type> --name <cluster_name> --workers <number>
    ```
    {: pre}

    <table>
    <caption>Description des composantes de cette commande</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composantes de cette commande</th>
    </thead>
    <tbody>
    <tr>
    <td><code>cluster-create</code></td>
    <td>Commande de création d'un cluster dans votre organisation {{site.data.keyword.Bluemix_notm}}.</td>
    </tr>
    <tr>
    <td><code>--location <em>&lt;location&gt;</em></code></td>
    <td>Remplacez &lt;location&gt; par l'ID d'emplacement {{site.data.keyword.Bluemix_notm}} que votre environnement Dedicated est configuré pour utiliser.</td>
    </tr>
    <tr>
    <td><code>--machine-type <em>&lt;machine_type&gt;</em></code></td>
    <td>Si vous créez un cluster standard, choisissez un type de machine. Le type de machine spécifie les ressources de traitement virtuelles disponibles pour chaque noeud worker. Consultez la rubrique [Comparaison de clusters gratuits et standards {{site.data.keyword.containershort_notm}}](cs_why.html#cluster_types) pour plus d'informations. Dans le cas de clusters gratuits, vous n'avez pas besoin de définir le type de machine.</td>
    </tr>
    <tr>
    <td><code>--name <em>&lt;name&gt;</em></code></td>
    <td>Remplacez <em>&lt;name&gt;</em> par le nom de votre cluster.</td>
    </tr>
    <tr>
    <td><code>--workers <em>&lt;number&gt;</em></code></td>
    <td>Nombre de noeuds d'agent à inclure dans le cluster. Si l'option <code>--workers</code> n'est pas spécifiée, un noeud worker est créé.</td>
    </tr>
    </tbody></table>

5.  Vérifiez que la création du cluster a été demandée.

    ```
    bx cs clusters
    ```
    {: pre}

    **Remarque :** la réservation des postes de noeud worker et la mise en place et la mise à disposition du cluster dans votre compte peuvent prendre jusqu'à 15 minutes.

    Lorsque la mise à disposition de votre cluster est finalisée, l'état de votre cluster passe à **deployed**.

    ```
    Name         ID                                   State      Created          Workers
    my_cluster   paf97e8843e29941b49c598f516de72101   deployed   20170201162433   1
    ```
    {: screen}

6.  Vérifiez le statut des noeuds d'agent.

    ```
    bx cs workers <cluster>
    ```
    {: pre}

    Lorsque les noeuds d'agent sont prêts, l'état passe à **normal** et le statut indique **Ready**. Lorsque le statut du noeud indique **Ready**, vous pouvez accéder au cluster.

    ```
    ID                                                  Public IP        Private IP     Machine Type   State      Status
    prod-dal10-pa8dfcc5223804439c87489886dbbc9c07-w1   169.47.223.113   10.171.42.93   free           normal    Ready
    ```
    {: screen}

7.  Définissez le cluster que vous avez créé comme contexte de cette session. Effectuez ces étapes de configuration à chaque fois que vous utilisez votre cluster.

    1.  Obtenez la commande permettant de définir la variable d'environnement et téléchargez les fichiers de configuration Kubernetes.

        ```
        bx cs cluster-config <cluster_name_or_id>
        ```
        {: pre}

        Une fois les fichiers de configuration téléchargés, une commande s'affiche ; elle vous
permet de définir le chemin vers le fichier de configuration Kubernetes local en tant que
variable d'environnement.

        Exemple pour OS X :

        ```
        export KUBECONFIG=/Users/<user_name>/.bluemix/plugins/container-service/clusters/<cluster_name>/kube-config-prod-dal10-<cluster_name>.yml
        ```
        {: screen}

    2.  Copiez et collez la commande qui s'affiche sur votre terminal pour définir la variable d'environnement `KUBECONFIG`.
    3.  Vérifiez que la variable d'environnement `KUBECONFIG` est correctement définie.

        Exemple pour OS X :

        ```
        echo $KUBECONFIG
        ```
        {: pre}

        Sortie :

        ```
        /Users/<user_name>/.bluemix/plugins/container-service/clusters/<cluster_name>/kube-config-prod-dal10-<cluster_name>.yml

        ```
        {: screen}

8.  Accédez à votre tableau de bord Kubernetes via le port par défaut (8001).
    1.  Définissez le proxy avec le numéro de port par défaut.

        ```
        kubectl proxy
        ```
        {: pre}

        ```
        Starting to serve on 127.0.0.1:8001
        ```
        {: screen}

    2.  Ouvrez l'URL suivante dans un navigateur Web pour accéder au tableau de bord Kubernetes.

        ```
        http://localhost:8001/ui
        ```
        {: codeblock}

### Utilisation de registres d'images privés et publics
{: #dedicated_images}

Pour les nouveaux espaces de nom, examinez les options dans [Utilisation de registres d'images privés et publics avec {{site.data.keyword.containershort_notm}}](cs_images.html). Pour les espaces de nom configurés pour des groupes uniques et évolutifs, [utilisez un jeton et créez une valeur confidentielle Kubernetes](cs_dedicated_tokens.html#cs_dedicated_tokens) pour l'authentification.

### Ajout de sous-réseaux à des clusters
{: #dedicated_cluster_subnet}

Vous pouvez modifier le pool d'adresses IP portables publiques disponibles en ajoutant des sous-réseaux à votre
cluster. Pour plus d'informations, voir [Ajout de sous-réseaux à des clusters](cs_subnets.html#subnets). Examinez les différences suivantes en cas d'ajout de sous-réseaux à des clusters dans la version Dedicated.

#### Ajout à vos clusters Kubernetes de sous-réseaux et d'adresses IP gérés par l'utilisateur
{: #dedicated_byoip_subnets}

Vous pouvez ajouter d'autres sous-réseaux depuis un réseau sur site que vous désirez utiliser pour accéder à {{site.data.keyword.containershort_notm}}. Vous pouvez ajouter des adresses IP de ces sous-réseaux à Ingress et aux services d'équilibreur de charge dans votre cluster Kubernetes. Les sous-réseaux gérés par l'utilisateur sont configurés de deux manières selon le format du sous-réseau que vous désirez utiliser.

Conditions requises :
- Les sous-réseaux gérés par l'utilisateur peuvent être ajoutés uniquement à des réseaux locaux virtuels (VLAN) privés.
- La limite de longueur du préfixe de sous-réseau est /24 à /30. Par exemple, `203.0.113.0/24` indique 253 adresses IP privées utilisables, alors que `203.0.113.0/30` indique 1 adresse IP privée utilisable.
- La première adresse IP dans le sous-réseau doit être utilisée comme passerelle du sous-réseau.

Avant de commencer : Configurez le routage entrant et sortant du trafic réseau de votre entreprise afin d'utiliser le réseau {{site.data.keyword.Bluemix_dedicated_notm}} qui exploitera le sous-réseau géré par l'utilisateur.

1. Pour utiliser votre propre sous-réseau, [ouvrez un ticket de demande de service](/docs/get-support/howtogetsupport.html#getting-customer-support) et fournissez la liste des routages de sous-réseaux CIDR que vous désirez utiliser.
    **Remarque **: la manière dont les ALB et les équilibreurs de charge sont gérés pour la connectivité sur site et la connectivité de compte interne diffère selon le format du CIDR de sous-réseau. Voir la dernière étape pour les différences de configuration.

2. Après qu'{{site.data.keyword.IBM_notm}} provisionne les sous-réseaux gérés par l'utilisateur, rendez le sous-réseau disponible pour votre cluster Kubernetes.

    ```
    bx cs cluster-user-subnet-add <cluster_name> <subnet_CIDR> <private_VLAN>
    ```
    {: pre}
    Remplacez <em>&lt;cluster_name&gt;</em> par le nom ou l'ID de votre cluster, <em>&lt;subnet_CIDR&gt;</em> par l'un des CIDR de sous-réseau indiqués dans le ticket de demande de service et <em>&lt;private_VLAN&gt;</em> par un ID de VLAN privé disponible. Pour obtenir l'ID d'un VLAN privé disponible, exécutez la commande `bx cs vlans`.

3. Vérifiez que les sous-réseaux ont été ajoutés à votre cluster. La zone **User-managed** pour les sous-réseaux fournis par l'utilisateur indique _true_.

    ```
    bx cs cluster-get --showResources <cluster_name>
    ```
    {: pre}

    ```
    VLANs
    VLAN ID   Subnet CIDR         Public       User-managed
    1555503   192.0.2.0/24        true         false
    1555505   198.51.100.0/24     false        false
    1555505   203.0.113.0/24      false        true
    ```
    {: screen}

4. Pour configurer une connectivité sur site et de compte interne, sélectionnez entre les options suivantes :
  - Si vous avez sélectionnée une plage d'adresses IP privée 10.x.x.x pour le sous-réseau, utilisez des IP valides sur cette plage pour configurer la connectivité sur site et et sur compte interne avec Ingress et un équilibreur de charge. Pour plus d'informations, voir [Configuration de l'accès à une application](cs_network_planning.html#planning).
  - Si vous n'avez pas utilisé une plage d'adresses IP privée 10.x.x.x du sous-réseau, utilisez des adresses IP valides sur cette plage pour configurer une connectivité sur site avec Ingress et un équilibreur de charge. Pour plus d'informations, voir [Configuration de l'accès à une application](cs_network_planning.html#planning). Toutefois, vous devez utiliser un sous-réseau privé portable de l'infrastructure IBM Cloud (SoftLayer) pour configurer la connectivité de compte interne entre votre cluster et d'autres services basés Cloud Foundry. Vous pouvez créer un sous-réseau privé portable à l'aide de la commande [`bx cs cluster-subnet-add`](cs_cli_reference.html#cs_cluster_subnet_add). Pour ce scénario, votre cluster dispose à la fois d'un sous-réseau géré par l'utilisateur pour la connectivité sur site et d'un sous-réseau privé portable de l'infrastructure IBM Cloud (SoftLayer) pour connectivité de compte interne.

### Autres configurations de cluster
{: #dedicated_other}

Examinez les options suivantes pour d'autres configurations de cluster :
  * [Gestion de l'accès au cluster](cs_users.html#managing)
  * [Mise à jour du maître Kubernetes](cs_cluster_update.html#master)
  * [Mise à jour des noeuds d'agent](cs_cluster_update.html#worker_node)
  * [Configuration de la journalisation de cluster](cs_health.html#logging)
  * [Configuration de la surveillance de cluster](cs_health.html#monitoring)
      * **Remarque **: un cluster `ibm-monitoring` existe dans chaque compte {{site.data.keyword.Bluemix_dedicated_notm}}. Cet environnement de cluster surveille en continu la santé du service {{site.data.keyword.containerlong_notm}} dans l'environnement Dedicated, en vérifiant la stabilité et la connectivité de l'environnement. Ne retirez-pas ce cluster de l'environnement.
  * [Visualisation de ressources de cluster Kubernetes](cs_integrations.html#weavescope)
  * [Suppression de clusters](cs_clusters.html#remove)

<br />


## Déploiement d'applications dans des clusters
{: #dedicated_apps}

Vous pouvez utiliser des techniques Kubernetes pour déployer des applications dans des clusters {{site.data.keyword.Bluemix_dedicated_notm}} et vous assurer que vos applications soient toujours opérationnelles.
{:shortdesc}

Pour déployer des applications dans des clusters, suivez les instructions de la rubrique [Déploiement d'applications dans des clusters {{site.data.keyword.Bluemix_notm}} publics](cs_app.html#app). Examinez les différences suivantes pour les clusters {{site.data.keyword.Bluemix_dedicated_notm}}.

### Autorisation d'accès public aux applications
{: #dedicated_apps_public}

Pour les environnements {{site.data.keyword.Bluemix_dedicated_notm}}, les adresses IP primaires publiques sont bloquées par un pare-feu. Pour rendre une application accessible au public, utilisez un [service LoadBalancer](#dedicated_apps_public_load_balancer) ou [Ingress](#dedicated_apps_public_ingress) au lieu d'un service NodePort. Si vous avez besoin d'un accès à un service LoadBalancer ou Ingress utilisant des adresses IP publiques portables, fournissez à IBM une liste blanche de pare-feu d'entreprise au moment de l'intégration du service.

#### Configuration de l'accès public à une application à l'aide du type de service LoadBalancer
{: #dedicated_apps_public_load_balancer}

Si vous désirez utiliser des adresses IP publiques pour l'équilibreur de charge, vérifiez qu'une liste blanche de pare-feu d'entreprise a été fournie à IBM ou [ouvrez un ticket de demande de service](/docs/get-support/howtogetsupport.html#getting-customer-support) pour configurer la liste blanche de pare-feu. Suivez ensuite les étapes de la section [Configuration de l'accès à une application à l'aide du type de service d'équilibreur de charge](cs_loadbalancer.html#config).

#### Configuration de l'accès public à une application à l'aide d'Ingress
{: #dedicated_apps_public_ingress}

Si vous désirez utiliser des adresses IP publiques pour l'équilibreur de charge d'application, vérifiez qu'une liste blanche de pare-feu d'entreprise a été fournie à IBM ou [ouvrez un ticket de demande de service](/docs/get-support/howtogetsupport.html#getting-customer-support) pour configurer la liste blanche de pare-feu. Suivez ensuite les étapes de la section [Configuration de l'accès à une application à l'aide d'Ingress](cs_ingress.html#config).

### Création de stockage persistant
{: #dedicated_apps_volume_claim}

Pour examiner les options de création de stockage persistant, voir [Options de stockage persistant](cs_storage.html#planning). Pour demander une sauvegarde de vos volumes, et pour d'autres fonctions de stockage, vous devez [ouvrir un ticket de demande de service](/docs/get-support/howtogetsupport.html#getting-customer-support).
