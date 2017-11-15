---

copyright:
  years: 2014, 2017
lastupdated: "2017-10-24"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:codeblock: .codeblock}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Configuration de clusters
{: #cs_cluster}

Concevez la configuration de vos clusters en vue d'une disponibilité et d'une capacité maximale.
{:shortdesc}

Avant de commencer, examinez les options de [configurations de cluster à haute disponibilité](cs_planning.html#cs_planning_cluster_config).

![Niveaux de haute disponibilité pour un cluster](images/cs_cluster_ha_roadmap.png)

<br />


## Création de clusters depuis l'interface graphique
{: #cs_cluster_ui}

Un cluster Kubernetes est un ensemble de noeuds d'agent organisés dans un réseau. L'objet de ce cluster est de définir un ensemble de ressources, de noeuds, de réseaux et de périphériques de stockage permettant d'assurer une haute disponibilité des applications. Avant de pouvoir déployer une application, vous devez créer un cluster et spécifier les définitions des noeuds d'agent dans ce cluster.
{:shortdesc}

Dans le cas d'utilisateurs de {{site.data.keyword.Bluemix_notm}} Dedicated, voir à la place la rubrique [Création de clusters depuis l'interface graphique dans {{site.data.keyword.Bluemix_notm}} Dedicated (version bêta fermée)](#creating_ui_dedicated).

Pour créer un cluster, procédez comme suit :
1. Dans le catalogue, sélectionnez **Cluster Kubernetes**.
2. Sélectionnez un type de plan de cluster. Vous pouvez choisir entre **Lite** ou **Paiement à la carte**. Avec le plan Paiement à la carte, vous pouvez mettre à disposition un cluster standard avec des fonctions, telles que des noeuds d'agent multiples pour un environnement à haute disponibilité.
3. Configurez les détails de votre cluster.
    1. Donnez un nom à votre cluster, choisissez une version de Kubernetes et sélectionnez un emplacement pour le déploiement. Sélectionnez l'emplacement qui est le plus proche de vous physiquement pour obtenir les meilleures performances. N'oubliez pas qu'il se peut que vous ayez besoin d'une autorisation des autorités pour stocker physiquement les données dans un autre pays, si vous sélectionnez un emplacement à l'étranger.
    2. Sélectionnez un type de machine et indiquez le nombre de noeuds d'agent dont vous avez besoin. Le type de machine détermine le nombre d'UC virtuelles et la mémoire configurés dans chaque noeud d'agent et rendus accessibles aux conteneurs. 
        - Le type de machine micro correspond à l'option la plus modique.
        - Une machine équilibrée comporte la même quantité de mémoire qui est affectée à chaque UC, ce qui optimise les performances.
    3. Sélectionnez un réseau local virtuel (VLAN) public et un VLAN privé à partir de votre compte IBM Bluemix Infrastructure (SoftLayer). Ces deux réseaux VLAN communiquent entre les noeuds d'agent mais le réseau VLAN public communique également avec le noeud maître Kubernetes géré par IBM. Vous pouvez utiliser le même VLAN pour plusieurs clusters.
        **Remarque** : si vous choisissez de ne pas sélectionner de VLAN public, vous devez configurer une solution alternative.
    4. Sélectionnez un type de matériel. Partagé est une option satisfaisante pour la plupart des situations.
        - **Dédié** : assure un isolement complet de vos ressources physiques.
        - **Partagé** : permet le stockage de vos ressources physiques sur le même matériel que pour d'autres clients IBM.
4. Cliquez sur **Créer un cluster**. Vous pouvez voir la progression du déploiement du noeud d'agent dans l'onglet **Noeuds d'agent**. Une fois le déploiement terminé, vous pouvez voir si le cluster est prêt dans l'onglet **Vue d'ensemble**.
    **Remarque :** A chaque noeud d'agent sont affectés un ID de noeud d'agent unique et un nom de domaine qui ne doivent pas être modifiés manuellement après la création du cluster. La modification de l'ID ou du domaine empêcherait le maître Kubernetes de gérer votre cluster.


**Etape suivante ?**

Une fois le cluster opérationnel, vous pouvez réaliser les tâches suivantes :

-   [Installer les interfaces de ligne de commande pour commencer à utiliser votre cluster.](cs_cli_install.html#cs_cli_install)
-   [Déployer une application dans votre cluster.](cs_apps.html#cs_apps_cli)
-   [Configurer votre propre registre privé dans {{site.data.keyword.Bluemix_notm}} afin de stocker et de partager des images Docker avec d'autres utilisateurs.](/docs/services/Registry/index.html)


### Création de clusters à l'aide de l'interface graphique dans {{site.data.keyword.Bluemix_notm}} Dedicated (version bêta fermée)
{: #creating_ui_dedicated}

1.  Connectez-vous à la console {{site.data.keyword.Bluemix_notm}} Public ([https://console.bluemix.net ![External link icon](../icons/launch-glyph.svg "External link icon")](https://console.bluemix.net)) avec votre IBMid.
2.  Dans le menu de compte, sélectionnez votre compte {{site.data.keyword.Bluemix_notm}} Dedicated. La console est mise à jour avec les services et les informations de votre instance {{site.data.keyword.Bluemix_notm}} Dedicated.
3.  Dans le catalogue, sélectionnez **Conteneurs** et cliquez sur **Cluster Kubernetes**.
4.  Renseignez la zone **Nom du cluster**.
5.  Sélectionnez un **type de machine**. Le type de machine détermine le nombre d'UC virtuelles et la mémoire déployés dans chaque noeud d'agent et disponibles pour tous les conteneurs que vous déployez dans vos noeuds.
    -   Le type de machine micro correspond à l'option la plus modique.
    -   Un type de machine équilibré affecte la même quantité de mémoire à chaque UC, ce qui optimise les performances.
6.  Sélectionnez le **nombre de noeuds d'agent** dont vous avez besoin. Sélectionnez `3` pour assurer une haute disponibilité de votre cluster.
7.  Cliquez sur **Créer un cluster**. La section des informations détaillées sur le cluster s'ouvre, mais l'allocation de noeuds d'agent dans le cluster prend quelques minutes. Vous pouvez suivre la progression du déploiement du noeud d'agent dans l'onglet **Noeuds d'agent**. Lorsque les noeuds d'agent sont prêts, l'état passe à **Ready**.

**Etape suivante ?**

Une fois le cluster opérationnel, vous pouvez réaliser les tâches suivantes :

-   [Installer les interfaces de ligne de commande pour commencer à utiliser votre cluster.](cs_cli_install.html#cs_cli_install)
-   [Déployer une application dans votre cluster.](cs_apps.html#cs_apps_cli)
-   [Configurer votre propre registre privé dans {{site.data.keyword.Bluemix_notm}} afin de stocker et de partager des images Docker avec d'autres utilisateurs.](/docs/services/Registry/index.html)

<br />


## Création de clusters depuis l'interface CLI
{: #cs_cluster_cli}

Un cluster est un ensemble de noeuds d'agent organisés dans un réseau. L'objet de ce cluster est de définir un ensemble de ressources, de noeuds, de réseaux et de périphériques de stockage permettant d'assurer une haute disponibilité des applications. Avant de pouvoir déployer une application, vous devez créer un cluster et spécifier les définitions des noeuds d'agent dans ce cluster.
{:shortdesc}

Dans le cas d'utilisateurs de {{site.data.keyword.Bluemix_notm}} Dedicated, voir à la place la rubrique [Création de clusters depuis l'interface graphique dans {{site.data.keyword.Bluemix_notm}} Dedicated (version bêta fermée)](#creating_cli_dedicated).

Pour créer un cluster, procédez comme suit :
1.  Installez l'interface de ligne de commande {{site.data.keyword.Bluemix_notm}} et le [plug-in {{site.data.keyword.containershort_notm}}](cs_cli_install.html#cs_cli_install).
2.  Connectez-vous à l'interface de ligne de commande {{site.data.keyword.Bluemix_notm}}. A l'invite, entrez vos données d'identification {{site.data.keyword.Bluemix_notm}}. Pour stipuler une région {{site.data.keyword.Bluemix_notm}}, [incluez le noeud final d'API](cs_regions.html#bluemix_regions).

    ```
    bx login
    ```
    {: pre}

    **Remarque :** si vous possédez un ID fédéré, exécutez la commande `bx login --sso` pour vous connecter à l'interface de ligne de commande {{site.data.keyword.Bluemix_notm}}. Entrez votre nom d'utilisateur et utilisez l'URL mentionnée dans la sortie CLI pour extraire votre code d'accès à usage unique. Si la connexion échoue alors que vous omettez l'option `--sso` et aboutit en incluant l'option `--sso`, ceci indique que votre ID est fédéré.

3. Si vous disposez de plusieurs comptes {{site.data.keyword.Bluemix_notm}}, sélectionnez le compte que vous voulez utiliser pour créer votre cluster Kubernetes.

4.  Spécifiez l'organisation et l'espace {{site.data.keyword.Bluemix_notm}} où vous souhaitez créer le cluster Kubernetes.
    ```
    bx target --cf
    ```
    {: pre}

    **Remarque** : les clusters sont spécifiques à un compte et à une organisation, mais sont indépendants de l'espace {{site.data.keyword.Bluemix_notm}}. Par exemple, si vous créez un cluster dans votre organisation dans l'espace `test`, vous pouvez toujours utiliser ce cluster si vous envisagez de travailler dans l'espace `dev`.

5.  Si vous souhaitez créer ou accéder à des clusters Kubernetes dans une région qui n'est pas la région {{site.data.keyword.Bluemix_notm}} sélectionnée précédemment, [spécifiez le noeud final d'API de la région {{site.data.keyword.containershort_notm}}](cs_regions.html#container_login_endpoints).

    **Remarque** : si vous souhaitez créer un cluster dans l'Est des Etats-Unis, vous devez spécifiez le noeud final d'API de la région du conteneur Est des Etats-Unis, à l'aide de la commande `bx cs init --host https://us-east.containers.bluemix.net`.

7.  Créez un cluster.
    1.  Examinez les emplacements disponibles. Les emplacements affichés dépendent de la région {{site.data.keyword.containershort_notm}} à laquelle vous êtes connecté.

        ```
        bx cs locations
        ```
        {: pre}

        La sortie de l'interface de ligne de commande correspond aux [emplacements de la région du conteneur](cs_regions.html#locations).

    2.  Sélectionnez un emplacement et examinez les types de machine disponibles sur celui-ci. Le type de machine spécifie les ressources de traitement virtuelles disponibles pour chaque noeud d'agent.

        ```
        bx cs machine-types <location>
        ```
        {: pre}

        ```
        Getting machine types list...
        OK
        Machine Types
        Name         Cores   Memory   Network Speed   OS             Storage   Server Type   
        u1c.2x4      2       4GB      1000Mbps        UBUNTU_16_64   100GB     virtual   
        b1c.4x16     4       16GB     1000Mbps        UBUNTU_16_64   100GB     virtual   
        b1c.16x64    16      64GB     1000Mbps        UBUNTU_16_64   100GB     virtual   
        b1c.32x128   32      128GB    1000Mbps        UBUNTU_16_64   100GB     virtual   
        b1c.56x242   56      242GB    1000Mbps        UBUNTU_16_64   100GB     virtual
        ```
        {: screen}

    3.  Vérifiez s'il existe des réseaux VLAN public et privé dans IBM Bluemix Infrastructure (SoftLayer) pour ce compte.

        ```
        bx cs vlans <location>
        ```
        {: pre}

        ```
        ID        Name                Number   Type      Router  
        1519999   vlan   1355     private   bcr02a.dal10  
        1519898   vlan   1357     private   bcr02a.dal10 
        1518787   vlan   1252     public   fcr02a.dal10 
        1518888   vlan   1254     public    fcr02a.dal10
        ```
        {: screen}

        S'il existe déjà un réseau virtuel public et privé, notez les routeurs correspondants. Les routeurs de VLAN privé commencent toujours par `bcr` (routeur dorsal) et les routeurs de VLAN public par `fcr` (routeur frontal). Le numéro et la combinaison de lettres après ces préfixes doivent correspondre pour pouvoir utiliser ces réseaux locaux virtuels lors de la création d'un cluster. Dans l'exemple de sortie, n'importe quel réseau local virtuel privé peut être utilisé avec l'un des réseaux publics virtuels privés vu que les routeurs incluent tous `02a.dal10`.

    4.  Exécutez la commande `cluster-create`. Vous avez le choix entre un cluster léger, qui inclut un noeud d'agent avec 2 UC virtuelles et 4 Go de mémoire, ou un cluster standard, lequel peut inclure autant de noeuds d'agent que vous le désirez dans votre compte IBM Bluemix Infrastructure (SoftLayer). Lorsque vous créez un cluster standard, le matériel du noeud d'agent est partagé par défaut par plusieurs clients IBM et facturé par heures d'utilisation. </br>Exemple pour un cluster standard :

        ```
        bx cs cluster-create --location dal10 --public-vlan <public_vlan_id> --private-vlan <private_vlan_id> --machine-type u1c.2x4 --workers 3 --name <cluster_name>
        ```
        {: pre}

        Exemple pour un cluster léger :

        ```
        bx cs cluster-create --name my_cluster
        ```
        {: pre}

        <table>
        <caption>Tableau 1. Description des composantes de cette commande</caption>
        <thead>
        <th colspan=2><img src="images/idea.png"/> Description des composantes de cette commande</th>
        </thead>
        <tbody>
        <tr>
        <td><code>cluster-create</code></td>
        <td>Commande de création d'un cluster dans votre organisation {{site.data.keyword.Bluemix_notm}}.</td>
        </tr>
        <tr>
        <td><code>--location <em>&lt;location&gt;</em></code></td>
        <td>Remplacez <em>&lt;location&gt;</em> par l'ID de l'emplacement {{site.data.keyword.Bluemix_notm}} où vous désirez créer votre cluster. Les [emplacements disponibles](cs_regions.html#locations) dépendent de la région {{site.data.keyword.containershort_notm}} à laquelle vous êtes connecté.</td>
        </tr>
        <tr>
        <td><code>--machine-type <em>&lt;machine_type&gt;</em></code></td>
        <td>Si vous créez un cluster standard, choisissez un type de machine. Le type de machine spécifie les ressources de traitement virtuelles disponibles pour chaque noeud d'agent. Pour plus d'informations, consultez la rubrique [Comparaison des clusters léger et standard pour {{site.data.keyword.containershort_notm}}](cs_planning.html#cs_planning_cluster_type). Pour les clusters légers, vous n'avez pas besoin de définir le type de machine.</td>
        </tr>
        <tr>
        <td><code>--public-vlan <em>&lt;public_vlan_id&gt;</em></code></td>
        <td><ul>
          <li>Pour les clusters légers, vous n'avez pas besoin de définir un VLAN public. Votre cluster léger est automatiquement connecté à un VLAN public dont IBM est propriétaire.</li>
          <li>Pour un cluster standard, si vous disposez déjà d'un VLAN public configuré dans votre compte IBM Bluemix Infrastructure (SoftLayer) pour cet emplacement, entrez l'ID du VLAN public. Si vous ne disposez pas d'un VLAN public et d'un VLAN privé dans votre compte, ne spécifiez pas cette option. {{site.data.keyword.containershort_notm}} crée automatiquement un VLAN public pour vous.<br/><br/>
          <strong>Remarque</strong> : les routeurs de VLAN privé commencent toujours par <code>bcr</code> (routeur dorsal) et les routeurs de VLAN public par <code>fcr</code> (routeur frontal). Le numéro et la combinaison de lettres après ces préfixes doivent correspondre pour pouvoir utiliser ces réseaux locaux virtuels lors de la création d'un cluster.</li>
        </ul></td>
        </tr>
        <tr>
        <td><code>--private-vlan <em>&lt;private_vlan_id&gt;</em></code></td>
        <td><ul><li>Pour les clusters légers, vous n'avez pas besoin de définir un VLAN privé. Votre cluster léger est automatiquement connecté à un VLAN privé dont IBM est propriétaire.</li><li>Pour un cluster standard, si vous disposez déjà d'un VLAN privé configuré dans votre compte IBM Bluemix Infrastructure (SoftLayer) pour cet emplacement, entrez l'ID du VLAN privé. Si vous ne disposez pas d'un VLAN public et d'un VLAN privé dans votre compte, ne spécifiez pas cette option. {{site.data.keyword.containershort_notm}} crée automatiquement un VLAN public pour vous.<br/><br/><strong>Remarque</strong> : les routeurs de VLAN privé commencent toujours par <code>bcr</code> (routeur dorsal) et les routeurs de VLAN public par <code>fcr</code> (routeur frontal). Le numéro et la combinaison de lettres après ces préfixes doivent correspondre pour pouvoir utiliser ces réseaux locaux virtuels lors de la création d'un cluster.</li></ul></td>
        </tr>
        <tr>
        <td><code>--name <em>&lt;name&gt;</em></code></td>
        <td>Remplacez <em>&lt;name&gt;</em> par le nom de votre cluster.</td>
        </tr>
        <tr>
        <td><code>--workers <em>&lt;number&gt;</em></code></td>
        <td>Nombre de noeuds d'agent à inclure dans le cluster. Si l'option <code>--workers</code> n'est pas spécifiée, 1 noeud d'agent est créé.</td>
        </tr>
        </tbody></table>

8.  Vérifiez que la création du cluster a été demandée.

    ```
    bx cs clusters
    ```
    {: pre}

    **Remarque :** la réservation des postes de noeud d'agent et la mise en place et la mise à disposition du cluster dans votre compte peuvent prendre jusqu'à 15 minutes.

    Lorsque la mise à disposition de votre cluster est finalisée, le statut du cluster passe à **deployed**.

    ```
    Name         ID                                   State      Created          Workers
    my_cluster   paf97e8843e29941b49c598f516de72101   deployed   20170201162433   1
    ```
    {: screen}

9.  Vérifiez le statut des noeuds d'agent.

    ```
    bx cs workers <cluster>
    ```
    {: pre}

    Lorsque les noeuds d'agent sont prêts, l'état passe à **normal** et le statut indique **Ready**. Lorsque le statut du noeud indique **Ready**, vous pouvez accéder au cluster.

    **Remarque :** A chaque noeud d'agent sont affectés un ID de noeud d'agent unique et un nom de domaine qui ne doivent pas être modifiés manuellement après la création du cluster. La modification de l'ID ou du domaine empêcherait le maître Kubernetes de gérer votre cluster.

    ```
    ID                                                  Public IP        Private IP     Machine Type   State      Status
    prod-dal10-pa8dfcc5223804439c87489886dbbc9c07-w1   169.47.223.113   10.171.42.93   free           normal    Ready
    ```
    {: screen}

10. Définissez le cluster que vous avez créé comme contexte de cette session. Effectuez ces étapes de configuration à chaque fois que vous utilisez votre cluster.
    1.  Obtenez la commande permettant de définir la variable d'environnement et téléchargez les fichiers de configuration Kubernetes.

        ```
        bx cs cluster-config <cluster_name_or_id>
        ```
        {: pre}

        Une fois les fichiers de configuration téléchargés, une commande s'affiche ; elle vous permet de définir le chemin vers le fichier de configuration Kubernetes local en tant que variable d'environnement.

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

11. Lancez le tableau de bord Kubernetes via le port par défaut `8001`.
    1.  Affectez le numéro de port par défaut au proxy.

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


**Etape suivante ?**

-   [Déployez une application dans votre cluster.](cs_apps.html#cs_apps_cli)
-   [Gérez votre cluster à l'aide de la ligne de commande `kubectl`. ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/user-guide/kubectl/)
-   [Configurez votre propre registre privé dans {{site.data.keyword.Bluemix_notm}} afin de stocker et de partager des images Docker avec d'autres utilisateurs.](/docs/services/Registry/index.html)

### Création de clusters à l'aide de l'interface de ligne de commande dans {{site.data.keyword.Bluemix_notm}} Dedicated (version bêta fermée)
{: #creating_cli_dedicated}

1.  Installez l'interface de ligne de commande {{site.data.keyword.Bluemix_notm}} et le [plug-in {{site.data.keyword.containershort_notm}}](cs_cli_install.html#cs_cli_install).
2.  Connectez-vous au noeud final public d'{{site.data.keyword.containershort_notm}}. Entrez vos données d'identification {{site.data.keyword.Bluemix_notm}} et, à l'invite, sélectionnez le compte {{site.data.keyword.Bluemix_notm}} Dedicated. 

    ```
    bx login -a api.<region>.bluemix.net
    ```
    {: pre}

    **Remarque :** si vous possédez un ID fédéré, exécutez la commande `bx login --sso` pour vous connecter à l'interface de ligne de commande {{site.data.keyword.Bluemix_notm}}. Entrez votre nom d'utilisateur et utilisez l'URL mentionnée dans la sortie CLI pour extraire votre code d'accès à usage unique. Si la connexion échoue alors que vous omettez l'option `--sso` et aboutit en incluant l'option `--sso`, ceci indique que votre ID est fédéré.

3.  Créez un cluster avec la commande `cluster-create`. Lorsque vous créez un cluster standard, le matériel du noeud d'agent est facturé par heures d'utilisation.

    Exemple :

    ```
    bx cs cluster-create --location <location> --machine-type <machine-type> --name <cluster_name> --workers <number>
    ```
    {: pre}

    <table>
    <caption>Tableau 2. Description des composantes de cette commande</caption>
    <thead>
    <th colspan=2><img src="images/idea.png"/> Description des composantes de cette commande</th>
    </thead>
    <tbody>
    <tr>
    <td><code>cluster-create</code></td>
    <td>Commande de création d'un cluster dans votre organisation {{site.data.keyword.Bluemix_notm}}.</td>
    </tr>
    <tr>
    <td><code>--location <em>&lt;location&gt;</em></code></td>
    <td>Remplacez &lt;location&gt; par l'ID de l'emplacement {{site.data.keyword.Bluemix_notm}} où vous désirez créer votre cluster. Les [emplacements disponibles](cs_regions.html#locations) dépendent de la région {{site.data.keyword.containershort_notm}} à laquelle vous êtes connecté.</td>
    </tr>
    <tr>
    <td><code>--machine-type <em>&lt;machine_type&gt;</em></code></td>
    <td>Si vous créez un cluster standard, choisissez un type de machine. Le type de machine spécifie les ressources de traitement virtuelles disponibles pour chaque noeud d'agent. Pour plus d'informations, consultez la rubrique [Comparaison des clusters léger et standard pour {{site.data.keyword.containershort_notm}}](cs_planning.html#cs_planning_cluster_type). Pour les clusters légers, vous n'avez pas besoin de définir le type de machine.</td>
    </tr>
    <tr>
    <td><code>--name <em>&lt;name&gt;</em></code></td>
    <td>Remplacez <em>&lt;name&gt;</em> par le nom de votre cluster.</td>
    </tr>
    <tr>
    <td><code>--workers <em>&lt;number&gt;</em></code></td>
    <td>Nombre de noeuds d'agent à inclure dans le cluster. Si l'option <code>--workers</code> n'est pas spécifiée, 1 noeud d'agent est créé.</td>
    </tr>
    </tbody></table>

4.  Vérifiez que la création du cluster a été demandée.

    ```
    bx cs clusters
    ```
    {: pre}

    **Remarque :** la réservation des postes de noeud d'agent et la mise en place et la mise à disposition du cluster dans votre compte peuvent prendre jusqu'à 15 minutes.

    Lorsque la mise à disposition de votre cluster est finalisée, l'état de votre cluster passe à **deployed**.

    ```
    Name         ID                                   State      Created          Workers
    my_cluster   paf97e8843e29941b49c598f516de72101   deployed   20170201162433   1
    ```
    {: screen}

5.  Vérifiez le statut des noeuds d'agent.

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

6.  Définissez le cluster que vous avez créé comme contexte de cette session. Effectuez ces étapes de configuration à chaque fois que vous utilisez votre cluster.

    1.  Obtenez la commande permettant de définir la variable d'environnement et téléchargez les fichiers de configuration Kubernetes.

        ```
        bx cs cluster-config <cluster_name_or_id>
        ```
        {: pre}

        Une fois les fichiers de configuration téléchargés, une commande s'affiche ; elle vous permet de définir le chemin vers le fichier de configuration Kubernetes local en tant que variable d'environnement.

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

7.  Accédez à votre tableau de bord Kubernetes via le port par défaut (8001).
    1.  Affectez le numéro de port par défaut au proxy.

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


**Etape suivante ?**

-   [Déployez une application dans votre cluster.](cs_apps.html#cs_apps_cli)
-   [Gérez votre cluster à l'aide de la ligne de commande `kubectl`. ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/user-guide/kubectl/)
-   [Configurez votre propre registre privé dans {{site.data.keyword.Bluemix_notm}} afin de stocker et de partager des images Docker avec d'autres utilisateurs.](/docs/services/Registry/index.html)

<br />


## Utilisation de registres d'images privés et publics
{: #cs_apps_images}

Une image Docker est la base de chaque conteneur que vous créez. L'image est créée depuis un
Dockerfile, lequel est un fichier contenant des instructions pour générer l'image. Un Dockerfile peut référencer dans ses
instructions des artefacts de génération stockés séparément, comme une application, sa configuration, et ses dépendances. Les images sont généralement stockées dans un registre d'images pouvant être accessible au public (registre public)  ou, au contraire, dont l'accès est limité à un petit groupe d'utilisateurs (registre privé).
{:shortdesc}

Examinez les options suivantes pour plus d'informations sur la configuration d'un registre d'images et l'utilisation d'une
image du registre.

-   [Accès à un espace de nom dans {{site.data.keyword.registryshort_notm}} en vue d'utiliser des images fournies par IBM et vos propres images Docker privées ](#bx_registry_default)
-   [Accès aux images publiques de Docker Hub](#dockerhub)
-   [Accès à des images privées stockées dans d'autres registres privés](#private_registry).

### Accès à un espace de nom dans {{site.data.keyword.registryshort_notm}} en vue d'utiliser des images fournies par IBM et vos propres images Docker privées
{: #bx_registry_default}

Vous pouvez déployer dans votre cluster des conteneurs depuis une image fournie par IBM ou depuis une image privée stockée dans votre espace de nom dans {{site.data.keyword.registryshort_notm}}.

Avant de commencer :

1. [Configurez un espace de nom dans {{site.data.keyword.registryshort_notm}} sur {{site.data.keyword.Bluemix_notm}} Public ou {{site.data.keyword.Bluemix_notm}} Dedicated et transférez par commande push des images dans cet espace de nom](/docs/services/Registry/registry_setup_cli_namespace.html#registry_namespace_add).
2. [Créez un cluster](#cs_cluster_cli).
3. [Ciblez avec votre interface CLI votre cluster](cs_cli_install.html#cs_cli_configure).

Lorsque vous créez un cluster, un jeton de registre sans date d'expiration est créé automatiquement pour le cluster. Ce jeton est utilisé pour octroyer un accès en lecture seule à n'importe lequel de vos espaces de nom configurés dans {{site.data.keyword.registryshort_notm}}, de sorte que vous pouvez utiliser aussi bien les images fournies par IBM que vos propres images
Docker privées. Les jetons doivent être stockés dans un élément Kubernetes `imagePullSecret` pour être accessibles à un cluster Kubernetes lorsque vous déployez une application conteneurisée. Lorsque votre cluster est créé, {{site.data.keyword.containershort_notm}} stocke automatiquement ce jeton dans un élément Kubernetes `imagePullSecret`. L'élément `imagePullSecret` est ajouté à l'espace de nom
Kubernetes par défaut, à la liste par défaut des valeurs confidentielles dans l'élément ServiceAccount de cet espace de nom, et à l'espace de nom kube-system.

**Remarque :** avec cette configuration initiale, vous pouvez déployer des conteneurs depuis n'importe quelle image disponible dans un espace de nom dans votre compte {{site.data.keyword.Bluemix_notm}} vers l'espace de nom nommé **default** de votre cluster. Si vous désirez déployer un conteneur dans d'autres espaces de nom de votre cluster,  ou utiliser une image stockée dans une autre région {{site.data.keyword.Bluemix_notm}},  ou dans un autre compte {{site.data.keyword.Bluemix_notm}}, vous devez [créer votre propre élément imagePullSecret pour votre cluster](#bx_registry_other).

Pour déployer un conteneur dans l'espace de nom **default** de votre cluster, créez un fichier de configuration. 

1.  Créez un fichier de configuration de déploiement nommé `mydeployment.yaml`.
2.  Définissez le déploiement et l'image de votre espace de nom que vous désirez utiliser dans {{site.data.keyword.registryshort_notm}}.

    Pour utiliser une image privée d'un espace de nom dans {{site.data.keyword.registryshort_notm}} :

    ```
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
      name: ibmliberty-deployment
    spec:
      replicas: 3
      template:
        metadata:
          labels:
            app: ibmliberty
        spec:
          containers:
          - name: ibmliberty
            image: registry.<region>.bluemix.net/<namespace>/<my_image>:<tag>
    ```
    {: codeblock}

    **Astuce :** pour extraire vos informations d'espace de nom, exécutez la commande `bx cr namespace-list`.

3.  Créez le déploiement dans votre cluster.

    ```
    kubectl apply -f mydeployment.yaml
    ```
    {: pre}

    **Astuce :** vous pouvez également déployer un fichier de configuration existant, tel que l'une des images publiques fournies par IBM. Cet exemple utilise l'image **ibmliberty** dans la région Sud des Etats-Unis.

    ```
    kubectl apply -f https://raw.githubusercontent.com/IBM-{{site.data.keyword.Bluemix_notm}}/kube-samples/master/deploy-apps-clusters/deploy-ibmliberty.yaml
    ```
    {: pre}

### Déploiement d'images dans d'autres espaces de nom Kubernetes ou accès à des images dans d'autres régions et comptes {{site.data.keyword.Bluemix_notm}}
{: #bx_registry_other}

Vous pouvez déployer des conteneurs vers d'autres espaces de nom Kubernetes, utiliser des images stockées dans d'autres régions ou comptes {{site.data.keyword.Bluemix_notm}}, ou encore des images stockées dans {{site.data.keyword.Bluemix_notm}} Dedicated, en créant votre propre élément imagePullSecret.

Avant de commencer :

1.  [Configurez un espace de nom dans {{site.data.keyword.registryshort_notm}} sur {{site.data.keyword.Bluemix_notm}} Public ou {{site.data.keyword.Bluemix_notm}} Dedicated et transférez par commande push des images dans cet espace de nom](/docs/services/Registry/registry_setup_cli_namespace.html#registry_namespace_add).
2.  [Créez un cluster](#cs_cluster_cli).
3.  [Ciblez avec votre interface CLI votre cluster](cs_cli_install.html#cs_cli_configure).

Pour créer votre propre élément imagePullSecret :

**Remarque :** les valeurs ImagePullSecret ne sont valides que pour les espaces de nom Kubernetes pour lesquels elles ont été créées. Répétez ces étapes pour chaque espace de nom dans lequel vous désirez déployer des conteneurs. Les images de [DockerHub](#dockerhub) ne nécessitent pas ImagePullSecrets.

1.  Si vous ne possédez pas de jeton, [créez un jeton pour le registre auquel vous souhaitez accéder. ](/docs/services/Registry/registry_tokens.html#registry_tokens_create)
2.  Répertoriez les jetons dans votre compte {{site.data.keyword.Bluemix_notm}}. 

    ```
    bx cr token-list
    ```
    {: pre}

3.  Notez l'ID du jeton que vous désirez utiliser.
4.  Extrayez la valeur de ce jeton. Remplacez <em>&lt;token_id&gt;</em> par l'ID du jeton que vous avez extrait à l'étape précédente.

    ```
    bx cr token-get <token_id>
    ```
    {: pre}

    La valeur de ce jeton est affichée dans la zone **Token** de votre sortie CLI.

5.  Créez la valeur confidentielle Kubernetes pour stocker votre information de jeton.

    ```
    kubectl --namespace <kubernetes_namespace> create secret docker-registry <secret_name>  --docker-server=<registry_url> --docker-username=token --docker-password=<token_value> --docker-email=<docker_email>
    ```
    {: pre}

    <table>
    <caption>Tableau 3. Description des composantes de cette commande</caption>
    <thead>
    <th colspan=2><img src="images/idea.png"/> Description des composantes de cette commande</th>
    </thead>
    <tbody>
    <tr>
    <td><code>--namespace <em>&lt;kubernetes_namespace&gt;</em></code></td>
    <td>Obligatoire. Espace de nom Kubernetes de votre cluster dans lequel vous désirez utiliser la valeur confidentielle et déployer des conteneurs. Exécutez la commande <code>kubectl get namespaces</code> pour répertorier tous les espaces de nom dans votre cluster.</td>
    </tr>
    <tr>
    <td><code><em>&lt;secret_name&gt;</em></code></td>
    <td>Obligatoire. Nom que vous désirez utiliser pour l'élément imagePullSecret.</td>
    </tr>
    <tr>
    <td><code>--docker-server <em>&lt;registry_url&gt;</em></code></td>
    <td>Obligatoire. URL du registre d'images où votre espace de nom est configuré.<ul><li>Pour les espaces de nom définis au Sud et à l'Est des Etats-Unis  : registry.ng.bluemix.net</li><li>Pour les espaces de nom définis au Sud du Royaume-Uni : registry.eu-gb.bluemix.net</li><li>Pour les espaces de nom définis en Europe centrale (Francfort) : registry.eu-de.bluemix.net</li><li>Pour les espaces de nom définis en Australie (Sydney) : registry.au-syd.bluemix.net</li><li>Pour les espaces de nom définis dans le registre {{site.data.keyword.Bluemix_notm}} Dedicated : <em>&lt;dedicated_domain&gt;</em></li></ul></td>
    </tr>
    <tr>
    <td><code>--docker-username <em>&lt;docker_username&gt;</em></code></td>
    <td>Obligatoire. Nom d'utilisateur pour connexion à votre registre privé. Pour {{site.data.keyword.registryshort_notm}}, le nom d'utilisateur est défini avec <code>token</code>.</td>
    </tr>
    <tr>
    <td><code>--docker-password <em>&lt;token_value&gt;</em></code></td>
    <td>Obligatoire. Valeur de votre jeton de registre extraite auparavant.</td>
    </tr>
    <tr>
    <td><code>--docker-email <em>&lt;docker-email&gt;</em></code></td>
    <td>Obligatoire. Si vous en avez une, entrez votre adresse e-mail Docker. Si vous n'en avez pas, indiquez une adresse e-mail fictive (par exemple, a@b.c). Cet e-mail est obligatoire pour créer une valeur confidentielle Kubernetes, mais n'est pas utilisé après la création.</td>
    </tr>
    </tbody></table>

6.  Vérifiez que la création de la valeur confidentielle a abouti. Remplacez <em>&lt;kubernetes_namespace&gt;</em> par le nom de l'espace de nom sur lequel vous avez créé l'élément imagePullSecret.

    ```
    kubectl get secrets --namespace <kubernetes_namespace>
    ```
    {: pre}

7.  Créez un pod référençant l'élément imagePullSecret.
    1.  Créez un fichier de configuration de pod nommé `mypod.yaml`.
    2.  Définissez le pod et l'élément imagePullSecret que vous désirez utiliser pour accéder au registre {{site.data.keyword.Bluemix_notm}} privé.

        Une image privée d'un espace de nom :

        ```
        apiVersion: v1
        kind: Pod
        metadata:
          name: <pod_name>
        spec:
          containers:
            - name: <container_name>
              image: registry.<region>.bluemix.net/<my_namespace>/<my_image>:<tag>  
          imagePullSecrets:
            - name: <secret_name>
        ```
        {: codeblock}

        Une image publique {{site.data.keyword.Bluemix_notm}} :

        ```
        apiVersion: v1
        kind: Pod
        metadata:
          name: <pod_name>
        spec:
          containers:
            - name: <container_name>
              image: registry.<region>.bluemix.net/
          imagePullSecrets:
            - name: <secret_name>
        ```
        {: codeblock}

        <table>
        <caption>Tableau 4. Description des composants du fichier YAML</caption>
        <thead>
        <th colspan=2><img src="images/idea.png"/> Description des composants du fichier YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code><em>&lt;container_name&gt;</em></code></td>
        <td>Nom du conteneur que vous désirez déployer dans votre cluster.</td>
        </tr>
        <tr>
        <td><code><em>&lt;my_namespace&gt;</em></code></td>
        <td>Espace de nom sous lequel votre image est stockée. Pour répertorier les espaces de nom disponibles, exécutez la commande `bx cr namespace-list`.</td>
        </tr>
        <tr>
        <td><code><em>&lt;my_image&gt;</em></code></td>
        <td>Nom de l'image que vous désirez utiliser. Pour répertorier les images disponibles dans un compte {{site.data.keyword.Bluemix_notm}}, exécutez la commande `bx cr image-list`.</td>
        </tr>
        <tr>
        <td><code><em>&lt;tag&gt;</em></code></td>
        <td>Version de l'image que vous désirez utiliser. Si aucune étiquette n'est spécifiée, celle correspondant à <strong>latest</strong> (la plus récente) est utilisée par défaut.</td>
        </tr>
        <tr>
        <td><code><em>&lt;secret_name&gt;</em></code></td>
        <td>Nom de l'élément imagePullSecret que vous avez créé plus tôt.</td>
        </tr>
        </tbody></table>

   3.  Sauvegardez vos modifications.
   4.  Créez le déploiement dans votre cluster.

        ```
        kubectl apply -f mypod.yaml
        ```
        {: pre}


### Accès aux images publiques de Docker Hub
{: #dockerhub}

Vous pouvez utiliser n'importe quelle image publique stockée dans Docker Hub pour déployer sans configuration supplémentaire un conteneur dans votre cluster.

Avant de commencer :

1.  [Créez un cluster](#cs_cluster_cli).
2.  [Ciblez avec votre interface CLI votre cluster](cs_cli_install.html#cs_cli_configure).

Créez un fichier de configuration de déploiement.

1.  Créez un fichier de configuration nommé `mydeployment.yaml`.
2.  Définissez le déploiement et l'image Docker Hub publique que vous désirez utiliser. Le fichier de configuration suivant utilise l'image NGINX publique disponible dans Docker Hub.


    ```
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
      name: nginx-deployment
    spec:
      replicas: 3
      template:
        metadata:
          labels:
            app: nginx
        spec:
          containers:
          - name: nginx
            image: nginx
    ```
    {: codeblock}

3.  Créez le déploiement dans votre cluster.

    ```
    kubectl apply -f mydeployment.yaml
    ```
    {: pre}

    **Astuce :** vous pouvez aussi déployer un fichier de configuration existant. L'exemple suivant utilise la même image NGINX publique, mais l'applique directement à votre cluster.

    ```
    kubectl apply -f https://raw.githubusercontent.com/IBM-{{site.data.keyword.Bluemix_notm}}/kube-samples/master/deploy-apps-clusters/deploy-nginx.yaml
    ```
    {: pre}


### Accès à des images privées stockées dans d'autres registres privés
{: #private_registry}

Si vous disposez déjà d'un registre privé que vous désirez utiliser, vous devez stocker les données d'identification du registre dans un élément Kubernetes imagePullSecret et référencer cette valeur confidentielle dans votre fichier de configuration. 

Avant de commencer :

1.  [Créez un cluster](#cs_cluster_cli).
2.  [Ciblez avec votre interface CLI votre cluster](cs_cli_install.html#cs_cli_configure).

Pour créer un élément imagePullSecret :

**Remarque :** les valeurs ImagePullSecret sont valides pour les espaces de nom Kubernetes pour lesquels elles ont été créées. Répétez ces étapes pour chaque espace de nom dans lequel vous désirez déployer des conteneurs depuis une image d'un registre {{site.data.keyword.Bluemix_notm}} privé.

1.  Créez la valeur confidentielle Kubernetes pour stocker vos données d'identification de registre privé.

    ```
    kubectl --namespace <kubernetes_namespace> create secret docker-registry <secret_name>  --docker-server=<registry_url> --docker-username=<docker_username> --docker-password=<docker_password> --docker-email=<docker_email>
    ```
    {: pre}

    <table>
    <caption>Tableau 5. Description des composantes de cette commande</caption>
    <thead>
    <th colspan=2><img src="images/idea.png"/> Description des composantes de cette commande</th>
    </thead>
    <tbody>
    <tr>
    <td><code>--namespace <em>&lt;kubernetes_namespace&gt;</em></code></td>
    <td>Obligatoire. Espace de nom Kubernetes de votre cluster dans lequel vous désirez utiliser la valeur confidentielle et déployer des conteneurs. Exécutez la commande <code>kubectl get namespaces</code> pour répertorier tous les espaces de nom dans votre cluster.</td>
    </tr>
    <tr>
    <td><code><em>&lt;secret_name&gt;</em></code></td>
    <td>Obligatoire. Nom que vous désirez utiliser pour l'élément imagePullSecret.</td>
    </tr>
    <tr>
    <td><code>--docker-server <em>&lt;registry_url&gt;</em></code></td>
    <td>Obligatoire. URL du registre dans lequel sont stockées vos images privées.</td>
    </tr>
    <tr>
    <td><code>--docker-username <em>&lt;docker_username&gt;</em></code></td>
    <td>Obligatoire. Nom d'utilisateur pour connexion à votre registre privé.</td>
    </tr>
    <tr>
    <td><code>--docker-password <em>&lt;token_value&gt;</em></code></td>
    <td>Obligatoire. Valeur de votre jeton de registre extraite auparavant.</td>
    </tr>
    <tr>
    <td><code>--docker-email <em>&lt;docker-email&gt;</em></code></td>
    <td>Obligatoire. Si vous en avez une, entrez votre adresse e-mail Docker. Si vous n'en avez pas, indiquez une adresse e-mail fictive (par exemple, a@b.c). Cet e-mail est obligatoire pour créer une valeur confidentielle Kubernetes, mais n'est pas utilisé après la création.</td>
    </tr>
    </tbody></table>

2.  Vérifiez que la création de la valeur confidentielle a abouti. Remplacez <em>&lt;kubernetes_namespace&gt;</em> par le nom de l'espace de nom sur lequel vous avez créé l'élément imagePullSecret.

    ```
    kubectl get secrets --namespace <kubernetes_namespace>
    ```
    {: pre}

3.  Créez un pod référençant l'élément imagePullSecret.
    1.  Créez un fichier de configuration de pod nommé `mypod.yaml`.
    2.  Définissez le pod et l'élément imagePullSecret que vous désirez utiliser pour accéder au registre {{site.data.keyword.Bluemix_notm}} privé. Pour utiliser une image privée de votre registre privé :

        ```
        apiVersion: v1
        kind: Pod
        metadata:
          name: <pod_name>
        spec:
          containers:
            - name: <container_name>
              image: <my_image>:<tag>  
          imagePullSecrets:
            - name: <secret_name>
        ```
        {: codeblock}

        <table>
        <caption>Tableau 6. Description des composants du fichier YAML</caption>
        <thead>
        <th colspan=2><img src="images/idea.png"/> Description des composants du fichier YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code><em>&lt;pod_name&gt;</em></code></td>
        <td>Nom du pod que vous désirez créer.</td>
        </tr>
        <tr>
        <td><code><em>&lt;container_name&gt;</em></code></td>
        <td>Nom du conteneur que vous désirez déployer dans votre cluster.</td>
        </tr>
        <tr>
        <td><code><em>&lt;my_image&gt;</em></code></td>
        <td>Chemin d'accès complet à l'image dans votre registre privé que vous désirez utiliser.</td>
        </tr>
        <tr>
        <td><code><em>&lt;tag&gt;</em></code></td>
        <td>Version de l'image que vous désirez utiliser. Si aucune étiquette n'est spécifiée, celle correspondant à <strong>latest</strong> (la plus récente) est utilisée par défaut.</td>
        </tr>
        <tr>
        <td><code><em>&lt;secret_name&gt;</em></code></td>
        <td>Nom de l'élément imagePullSecret que vous avez créé plus tôt.</td>
        </tr>
        </tbody></table>

  3.  Sauvegardez vos modifications.
  4.  Créez le déploiement dans votre cluster.

        ```
        kubectl apply -f mypod.yaml
        ```
        {: pre}

<br />


## Ajout de services {{site.data.keyword.Bluemix_notm}} à des clusters
{: #cs_cluster_service}

Ajoutez une instance de service {{site.data.keyword.Bluemix_notm}} existante à votre cluster pour permettre aux utilisateurs du cluster d'accéder et d'utiliser le service {{site.data.keyword.Bluemix_notm}} lorsqu'ils déploient une application dans le cluster.
{:shortdesc}

Avant de commencer :

1. [Ciblez votre interface de ligne de commande](cs_cli_install.html#cs_cli_configure) vers votre cluster.
2. [Demandez une instance du service {{site.data.keyword.Bluemix_notm}}](/docs/services/reqnsi.html#req_instance) dans votre espace.
   **Remarque :** pour créer une instance de service sur le site Washington DC, vous devez utiliser l'interface CLI.
3. Dans le cas d'utilisateurs de {{site.data.keyword.Bluemix_notm}} Dedicated, voir à la place la rubrique [Ajout de services {{site.data.keyword.Bluemix_notm}} à des clusters dans {{site.data.keyword.Bluemix_notm}} Dedicated (version bêta fermée)](#binding_dedicated).

**Remarque :**
<ul><ul>
<li>Vous ne pouvez ajouter que des services {{site.data.keyword.Bluemix_notm}} qui prennent en charge les clés de service. Si le service ne prend pas en charge les clés de service, voir [Utilisation des services {{site.data.keyword.Bluemix_notm}} avec des applications externes](/docs/services/reqnsi.html#req_instance).</li>
<li>Le cluster et les noeuds d'agent doivent être complètement déployés pour pouvoir ajouter un service.</li>
</ul></ul>


Pour ajouter un service, procédez comme suit :
2.  Répertoriez tous les services existants dans votre espace {{site.data.keyword.Bluemix_notm}}.

    ```
    bx service list
    ```
    {: pre}

    Exemple de sortie d'interface CLI :

    ```
    name                      service           plan    bound apps   last operation   
    <service_instance_name>   <service_name>    spark                create succeeded
    ```
    {: screen}

3.  Notez la valeur du nom (**name**) de l'instance de service que vous souhaitez ajouter au cluster.
4.  Identifiez l'espace de nom du cluster que vous désirez ajouter à votre service. Sélectionnez l'une des options suivantes.
    -   Listez les espaces de nom existants et sélectionnez l'espace de nom à utiliser.

        ```
        kubectl get namespaces
        ```
        {: pre}

    -   Créez un nouvel espace de nom dans votre cluster.

        ```
        kubectl create namespace <namespace_name>
        ```
        {: pre}

5.  Ajoutez le service à votre cluster.

    ```
    bx cs cluster-service-bind <cluster_name_or_id> <namespace> <service_instance_name>
    ```
    {: pre}

    Une fois que le service a été correctement ajouté à votre cluster, une valeur confidentielle de cluster est créée pour héberger les données d'identification de votre instance de service. Exemple de sortie d'interface CLI :

    ```
    bx cs cluster-service-bind mycluster mynamespace cleardb 
    Binding service instance to namespace...
    OK
    Namespace: mynamespace
    Secret name:     binding-<service_instance_name>
    ```
    {: screen}

6.  Vérifiez que la valeur confidentielle a bien été créée dans l'espace de nom de votre cluster.

    ```
    kubectl get secrets --namespace=<namespace>
    ```
    {: pre}


Pour utiliser le service dans un pod qui est déployé dans le cluster, les utilisateurs du cluster peuvent accéder aux données d'identification du service {{site.data.keyword.Bluemix_notm}} en [montant la valeur confidentielle Kubernetes en tant que volume secret sur un pod.](cs_apps.html#cs_apps_service)

### Ajout de services {{site.data.keyword.Bluemix_notm}} à des clusters dans {{site.data.keyword.Bluemix_notm}} Dedicated (version bêta fermée)
{: #binding_dedicated}

**Remarque** : le cluster et les noeuds d'agent doivent être complètement déployés pour pouvoir ajouter un service.

1.  Définissez le chemin vers le fichier de configuration {{site.data.keyword.Bluemix_notm}} Dedicated local en tant que variable d'environnement `DEDICATED_BLUEMIX_CONFIG`.

    ```
    export DEDICATED_BLUEMIX_CONFIG=<path_to_config_directory>
    ```
    {: pre}

2.  Définissez le même chemin défini ci-dessus en tant que variable d'environnement `BLUEMIX_HOME`.

    ```
    export BLUEMIX_HOME=$DEDICATED_BLUEMIX_CONFIG
    ```
    {: pre}

3.  Connectez-vous à l'environnement {{site.data.keyword.Bluemix_notm}} Dedicated dans lequel vous souhaitez créer l'instance de service.

    ```
    bx login -a api.<dedicated_domain> -u <user> -p <password> -o <org> -s <space>
    ```
    {: pre}

4.  Répertoriez les services disponibles dans le catalogue {{site.data.keyword.Bluemix_notm}}.

    ```
    bx service offerings
    ```
    {: pre}

5.  Créez une instance du service que vous voulez lier au cluster.

    ```
    bx service create <service_name> <service_plan> <service_instance_name>
    ```
    {: pre}

6.  Vérifiez que votre instance de service est créée en répertoriant tous les services existants dans votre espace {{site.data.keyword.Bluemix_notm}}.

    ```
    bx service list
    ```
    {: pre}

    Exemple de sortie d'interface CLI :

    ```
    name                      service           plan    bound apps   last operation   
    <service_instance_name>   <service_name>    spark                create succeeded
    ```
    {: screen}

7.  Annulez la définition de la variable d'environnement `BLUEMIX_HOME` pour revenir à l'utilisation de {{site.data.keyword.Bluemix_notm}} Public.

    ```
    unset $BLUEMIX_HOME
    ```
    {: pre}

8.  Connectez-vous au noeud final public d'{{site.data.keyword.containershort_notm}} et pointez votre interface CLI sur le cluster dans votre environnement {{site.data.keyword.Bluemix_notm}} Dedicated.
    1.  Connectez-vous au compte à l'aide du noeud final public {{site.data.keyword.containershort_notm}}. Entrez vos données d'identification {{site.data.keyword.Bluemix_notm}} et, à l'invite, sélectionnez le compte {{site.data.keyword.Bluemix_notm}} Dedicated. 

        ```
        bx login -a api.ng.bluemix.net
        ```
        {: pre}

        **Remarque :** si vous possédez un ID fédéré, exécutez la commande `bx login --sso` pour vous connecter à l'interface de ligne de commande {{site.data.keyword.Bluemix_notm}}. Entrez votre nom d'utilisateur et utilisez l'URL mentionnée dans la sortie CLI pour extraire votre code d'accès à usage unique. Si la connexion échoue alors que vous omettez l'option `--sso` et aboutit en incluant l'option `--sso`, ceci indique que votre ID est fédéré.

    2.  Extrayez la liste des clusters disponibles et identifiez le cluster à cibler dans votre interface CLI.

        ```
        bx cs clusters
        ```
        {: pre}

    3.  Obtenez la commande permettant de définir la variable d'environnement et téléchargez les fichiers de configuration Kubernetes.

        ```
        bx cs cluster-config <cluster_name_or_id>
        ```
        {: pre}

        Une fois les fichiers de configuration téléchargés, une commande s'affiche ; elle vous permet de définir le chemin vers le fichier de configuration Kubernetes local en tant que variable d'environnement.

        Exemple pour OS X :

        ```
        export KUBECONFIG=/Users/<user_name>/.bluemix/plugins/container-service/clusters/<cluster_name>/kube-config-prod-dal10-<cluster_name>.yml
        ```
        {: screen}

    4.  Copiez et collez la commande qui s'affiche sur votre terminal pour définir la variable d'environnement `KUBECONFIG`.

9.  Identifiez l'espace de nom du cluster que vous désirez ajouter à votre service. Sélectionnez l'une des options suivantes.
    * Listez les espaces de nom existants et sélectionnez l'espace de nom à utiliser.
        ```
        kubectl get namespaces
        ```
        {: pre}

    * Créez un nouvel espace de nom dans votre cluster.
        ```
        kubectl create namespace <namespace_name>
        ```
        {: pre}

10.  Liez l'instance de service à votre cluster.

      ```
      bx cs cluster-service-bind <cluster_name_or_id> <namespace> <service_instance_name>
      ```
      {: pre}

<br />


## Gestion de l'accès au cluster
{: #cs_cluster_user}

Vous pouvez accorder à d'autres utilisateurs un accès à votre cluster pour leur permettre d'y accéder, de le gérer et d'y déployer des applications.
{:shortdesc}

Chaque utilisateur qui utilise {{site.data.keyword.containershort_notm}} doit se voir affecter dans Identity and Access Management un rôle utilisateur spécifique au service et qui détermine les actions qu'il peut effectuer. Identity and Access Management fait une distinction entre les autorisations d'accès suivantes.

-   Règles d'accès {{site.data.keyword.containershort_notm}}

    Ces règles d'accès déterminent les actions de gestion du cluster que vous pouvez effectuer (par exemple, la création ou la suppression de clusters, ou l'ajout ou la suppression de noeuds d'agent).

<!-- If you want to prevent a user from deploying apps to a cluster or creating other Kubernetes resources, you must create RBAC policies for the cluster. -->

-   Rôles Cloud Foundry

    Chaque utilisateur doit se voir affecter un rôle utilisateur Cloud Foundry. Ce rôle détermine les actions que peut effectuer l'utilisateur sur le compte {{site.data.keyword.Bluemix_notm}} (par exemple, inviter d'autres utilisateurs ou examiner l'utilisation du quota). Pour examiner les autorisations correspondant à chaque rôle, voir [Rôles Cloud Foundry](/docs/iam/users_roles.html#cfroles).

-   Rôles RBAC

    Chaque utilisateur auquel est affectée une règle d'accès {{site.data.keyword.containershort_notm}} se voit automatiquement affecter un rôle RBAC. Les rôles RBAC déterminent les actions que vous pouvez effectuer sur des ressources Kubernetes au sein du cluster. Les rôles RBAC ne sont configurés que pour l'espace de nom par défaut. L'administrateur du cluster peut ajouter des rôles RBAC pour d'autres espaces de nom dans le cluster. Pour plus d'informations, voir [Using RBAC Authorization ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/admin/authorization/rbac/#api-overview) dans la documentation Kubernetes.


Sélectionnez l'une des actions suivantes pour continuer :

-   [Examen des règles d'accès et des autorisations requises pour utiliser des clusters](#access_ov).
-   [Examen de votre règle d'accès actuelle](#view_access).
-   [Modification de la règle d'accès d'un utilisateur existant](#change_access).
-   [Ajout d'utilisateurs supplémentaires au compte {{site.data.keyword.Bluemix_notm}} account](#add_users).

### Description des règles d'accès et des autorisations {{site.data.keyword.containershort_notm}} requises
{: #access_ov}

Examinez les règles d'accès et les autorisations que vous pouvez attribuer à des utilisateurs dans votre compte {{site.data.keyword.Bluemix_notm}}.

|Règle d'accès|Autorisations de gestion du cluster|Autorisations sur les ressources Kubernetes|
|-------------|------------------------------|-------------------------------|
|<ul><li>Rôle : Administrateur</li><li>Instances de service : toutes les instances de service actuelles</li></ul>|<ul><li>Créer un cluster léger ou standard</li><li>Définir les données d'identification pour un compte {{site.data.keyword.Bluemix_notm}} afin d'accéder au portefeuille IBM Bluemix Infrastructure (SoftLayer)</li><li>Supprimer un cluster</li><li>Affecter et modifier des règles d'accès {{site.data.keyword.containershort_notm}} pour d'autres utilisateurs existants dans ce compte.</li></ul><br/>Ce rôle hérite des autorisations des rôles Editeur, Opérateur et Visualiseur dans tous les clusters du compte.|<ul><li>Rôle RBAC : cluster-admin</li><li>Accès en lecture/écriture aux ressources dans tous les espaces de nom</li><li>Créer des rôles au sein d'un espace de nom</li><li>Accès au tableau de bord Kubernetes</li><li>Créer une ressource Ingress permettant de rendre les applications publiquement disponibles</li></ul>|
|<ul><li>Rôle : Administrateur</li><li>Instances de service : ID de cluster spécifique</li></ul>|<ul><li>Retirer un cluster spécifique.</li></ul><br/>Ce rôle hérite des autorisations des rôles Editeur, Opérateur et Visualiseur dans le cluster sélectionné.|<ul><li>Rôle RBAC : cluster-admin</li><li>Accès en lecture/écriture aux ressources dans tous les espaces de nom</li><li>Créer des rôles au sein d'un espace de nom</li><li>Accès au tableau de bord Kubernetes</li><li>Créer une ressource Ingress permettant de rendre les applications publiquement disponibles</li></ul>|
|<ul><li>Rôle : Opérateur</li><li>Instances de service : toutes les instances de service actuelles / ID de cluster spécifique</li></ul>|<ul><li>Ajouter des noeuds d'agent supplémentaires à un cluster</li><li>Supprimer des noeuds d'agent d'un cluster</li><li>Réamorcer un noeud d'agent</li><li>Recharger un noeud d'agent</li><li>Ajouter un sous-réseau à un cluster</li></ul>|<ul><li>Rôle RBAC : admin</li><li>Accès en lecture/écriture aux ressources dans l'espace de nom par défaut, mais non pas à l'espace de nom lui-même</li><li>Créer des rôles au sein d'un espace de nom</li></ul>|
|<ul><li>Rôle : Editeur</li><li>Instances de service : toutes les instances de service actuelles/ID de cluster spécifique</li></ul>|<ul><li>Lier un service {{site.data.keyword.Bluemix_notm}} à un cluster.</li><li>Annuler la liaison d'un service {{site.data.keyword.Bluemix_notm}} à un cluster.</li><li>Créer un webhook.</li></ul><br/>Utilisez ce rôle pour vos développeurs d'applications.|<ul><li>Rôle RBAC : edit</li><li>Accès en lecture/écriture aux ressources dans l'espace de nom par défaut</li></ul>|
|<ul><li>Rôle : Visualiseur</li><li>Instances de service : toutes les instances de service actuelles / ID de cluster spécifique</li></ul>|<ul><li>Lister un cluster</li><li>Afficher les détails d'un cluster</li></ul>|<ul><li>Rôle RBAC : view</li><li>Accès en lecture aux ressources dans l'espace de nom par défaut</li><li>Pas d'accès en lecture aux valeurs confidentielles Kubernetes</li></ul>|
|<ul><li>Rôle dans l'organisation Cloud Foundry : Gestionnaire</li></ul>|<ul><li>Ajouter des utilisateurs supplémentaires dans un compte {{site.data.keyword.Bluemix_notm}}</li></ul>| |
|<ul><li>Rôle dans l'espace Cloud Foundry : Développeur</li></ul>|<ul><li>Créer des instances de service {{site.data.keyword.Bluemix_notm}}</li><li>Lier des instances de service {{site.data.keyword.Bluemix_notm}} à des clusters</li></ul>| |
{: caption="Tableau 7. Présentation des règles d'accès et des autorisations {{site.data.keyword.containershort_notm}} requises" caption-side="top"}

### Vérification de votre règle d'accès {{site.data.keyword.containershort_notm}}
{: #view_access}

Vous pouvez examiner et vérifier la règle d'accès qui vous est affectée pour {{site.data.keyword.containershort_notm}}. La règle d'accès détermine les actions de gestion de cluster que vous pouvez effectuer.

1.  Sélectionnez le compte {{site.data.keyword.Bluemix_notm}} pour lequel vous désirez vérifier votre règle d'accès {{site.data.keyword.containershort_notm}}.
2.  Dans la barre de menus, cliquez sur **Gérer** > **Sécurité** > **Identité et accès**. La fenêtre **Utilisateurs** affiche une liste des utilisateurs avec leurs adresses électroniques et leur statut actuel pour le compte sélectionné.
3.  Sélectionnez l'utilisateur pour lequel vous désirez vérifier la règle d'accès.
4.  Dans la section **Règles de service**, examinez la règle d'accès affectée à l'utilisateur. Pour obtenir des informations détaillées sur les actions que vous pouvez effectuer avec ce rôle, voir [Présentation des règles et autorisations d'accès {{site.data.keyword.containershort_notm}} obligatoires](#access_ov).
5.  Facultatif : [Modifiez votre règle d'accès actuelle](#change_access).

    **Remarque :** Seuls les utilisateurs auxquels une règle de service Administrateur est affectée sur toutes les ressources dans {{site.data.keyword.containershort_notm}} peuvent modifier la règle d'accès d'un utilisateur existant. Pour ajouter d'autres utilisateurs à un compte {{site.data.keyword.Bluemix_notm}}, vous devez être affecté au rôle Gestionnaire Cloud Foundry pour ce compte. Pour identifier l'ID du propriétaire du compte {{site.data.keyword.Bluemix_notm}}, exécutez la commande `bx iam accounts` et recherchez la zone **Owner User ID**.


### Modification de la règle d'accès {{site.data.keyword.containershort_notm}} pour un utilisateur existant
{: #change_access}

Vous pouvez modifier la règle d'accès pour un utilisateur existant en lui accordant des autorisations de gestion d'un cluster dans votre compte
{{site.data.keyword.Bluemix_notm}}.

Avant de commencer, [vérifiez que vous avez bien été affecté à la règle d'accès
Administrateur](#view_access) sur toutes les ressources dans {{site.data.keyword.containershort_notm}}.

1.  Sélectionnez le compte {{site.data.keyword.Bluemix_notm}} pour lequel vous désirez modifier la règle d'accès {{site.data.keyword.containershort_notm}} d'un utilisateur existant.
2.  Dans la barre de menus, cliquez sur **Gérer** > **Sécurité** > **Identité et accès**. La fenêtre **Utilisateurs** affiche une liste des utilisateurs avec leurs adresses électroniques et leur statut actuel pour le compte sélectionné.
3.  Recherchez l'utilisateur dont vous désirez modifier la règle d'accès. S'il est introuvable, [invitez cet utilisateur sur le compte {{site.data.keyword.Bluemix_notm}}](#add_users).
4.  Dans l'onglet **Actions**, cliquez sur **Affecter une règle**.
5.  Dans la liste déroulante **Service**, sélectionnez **{{site.data.keyword.containershort_notm}}**.
6.  Dans la liste déroulante **Rôles**, sélectionnez la règle d'accès que vous désirez affecter. La sélection d'un rôle sans le limiter à une région ou à un cluster spécifique applique automatiquement cette règle d'accès à tous les clusters qui ont été créés dans ce compte. Si vous désirez limiter l'accès à un cluster ou à une région spécifique, sélectionnez-les dans la liste déroulante **Instance de service** et **Région**. Pour consulter la liste des actions prises en charge pour chaque règle d'accès, voir [Présentation des règles et autorisations d'accès {{site.data.keyword.containershort_notm}} obligatoires](#access_ov). Pour identifier l'ID d'un cluster spécifique, exécutez la commande `bx cs clusters`.
7.  Cliquez sur **Affecter une règle** pour sauvegarder vos modifications.

### Ajout d'utilisateurs à un compte {{site.data.keyword.Bluemix_notm}}
{: #add_users}

Vous pouvez ajouter des utilisateurs supplémentaires à un compte {{site.data.keyword.Bluemix_notm}} pour leur accorder un accès à vos clusters.

Avant de commencer, vérifiez que vous avez bien été affecté au rôle Gestionnaire Cloud Foundry pour un compte {{site.data.keyword.Bluemix_notm}}.

1.  Sélectionnez le compte {{site.data.keyword.Bluemix_notm}} dans lequel vous désirez ajouter des utilisateurs.
2.  Dans la barre de menus, cliquez sur **Gérer** > **Sécurité** > **Identité et accès**. La fenêtre Utilisateurs affiche une liste des utilisateurs avec leurs adresses électroniques et leur statut actuel pour le compte sélectionné.
3.  Cliquez sur **Inviter des utilisateurs**.
4.  Dans **Adresse électronique ou IBMid existant**, entrez l'adresse électronique de l'utilisateur que vous désirez ajouter au compte {{site.data.keyword.Bluemix_notm}}.
5.  Dans la section **Accès**, développez l'entrée **Services avec l'offre Identity and Access activée**.
6.  Dans la liste déroulante **Services**, sélectionnez **{{site.data.keyword.containershort_notm}}**.
7.  Dans la liste déroulante **Région**, sélectionnez une région. Si la région désirée n'est pas répertoriée et est [prise en charge pour {{site.data.keyword.containershort_notm}}](cs_regions.html), sélectionnez **Toutes les régions**.
8.  Dans la liste déroulante **Rôles**, sélectionnez la règle d'accès que vous désirez affecter. La sélection d'un rôle sans le limiter à une région ou à un cluster spécifique applique automatiquement cette règle d'accès à tous les clusters qui ont été créés dans ce compte. Pour limiter l'accès à un cluster ou à une région spécifique, sélectionnez une valeur dans les listes déroulantes **Instance de service** et **Région**. Pour consulter la liste des actions prises en charge pour chaque règle d'accès, voir [Présentation des règles et autorisations d'accès {{site.data.keyword.containershort_notm}} obligatoires](#access_ov). Pour identifier l'ID d'un cluster spécifique, exécutez la commande `bx cs clusters`.
9.  Développez la section **Accès Cloud Foundry** et sélectionnez l'organisation {{site.data.keyword.Bluemix_notm}} à laquelle vous désirez ajouter l'utilisateur dans la liste déroulante **Organisation**.
10.  Dans la liste déroulante **Rôles d'espace**, sélectionnez les rôles de votre choix. Les clusters Kubernetes sont indépendants des espaces {{site.data.keyword.Bluemix_notm}}.
11. Cliquez sur **Inviter des utilisateurs**.
12. Facultatif : pour autoriser cet utilisateur à ajouter des utilisateurs supplémentaires à un compte {{site.data.keyword.Bluemix_notm}}, affectez-lui le rôle d'organisation Cloud Foundry.
    1. Dans la table de la vue d'ensemble **Utilisateurs**, dans la colonne **Actions**, sélectionnez **Gérer un utilisateur**.
    2. Dans la section **Rôles Cloud Foundry**, recherchez le rôle d'organisation Cloud Foundry attribué à l'utilisateur que vous avez ajouté aux étapes précédentes.
    3. Dans l'onglet **Actions**, sélectionnez **Editer le rôle d'organisation**.
    4. Dans la liste déroulante **Rôles d'organisation**, sélectionnez **Gestionnaire**.
    5. Cliquez sur **Sauvegarder le rôle**.

<br />


## Mise à jour du maître Kubernetes
{: #cs_cluster_update}

La mise à jour d'un cluster est un processus en deux étapes. Vous devez d'abord mettre à jour le maître Kubernetes pour pouvoir mettre à jour chacun des noeuds d'agent.

**Attention** : les mises à jour _peuvent_ rendre vos applications indisponibles ou les interrompre sauf si vous les planifiez en conséquence.

Kubernetes fournit ces types de mise à jour :

|Type de mise à jour|Libellé de version|Mis à jour par|Impact
|-----|-----|-----|-----|
|Principale|exemple : 1.x.x|Utilisateur|Peut impliquer des changements de fonctionnement d'un cluster et peut nécessiter des modifications dans les scripts ou les déploiements.|
|Secondaire|exemple : x.5.x|Utilisateur|Peut impliquer des changements de fonctionnement d'un cluster et peut nécessiter des modifications dans les scripts et les déploiements.
|Correctif|exemple : x.x.3|IBM/Utilisateur|Il s'agit d'un petit correctif qui ne nécessite pas d'interruption. Un correctif ne nécessite aucune modification de script ou de déploiement. IBM met à jour les maîtres automatiquement, mais l'utilisateur doit mettre à jour les noeuds d'agent pour appliquer les correctifs.|
{: caption="Types de mise à jour Kubernetes" caption-side="top"}


Lorsque vous effectuez une mise à jour _principale_ ou _secondaire_, procédez comme suit. Avant de mettre à jour un environnement de production, utilisez un cluster de test. Vous ne pouvez pas revenir à la version précédente d'un cluster.

1. Passez en revue les [modifications Kubernetes](cs_versions.html) et effectuez les mises à jour marquées _Mise à jour avant le maître_.
2. Mettez à jour le maître Kubernetes à l'aide de l'interface graphique ou en exécutant la [commande CLI](cs_cli_reference.html#cs_cluster_update). Lorsque vous le mettez à jour, le maître Kubernetes est indisponible pendant 5 à 10 minutes. Pendant la mise à jour, vous ne pouvez ni accéder au cluster, ni le modifier. En revanche, les noeuds d'agent, les applications et les ressources que les utilisateurs du cluster ont déployés ne sont pas modifiés et poursuivent leur exécution.
3. Confirmez que la mise à jour est terminée. Vérifiez la version Kubernetes dans le tableau de bord {{site.data.keyword.Bluemix_notm}} ou exécutez la commande `bx cs clusters`.

Lorsque la mise à jour du maître Kubernetes est terminée, vous pouvez mettre à jour les noeuds d'agent à la version la plus récente.

<br />


## Mise à jour des noeuds d'agent
{: #cs_cluster_worker_update}

Les noeuds d'agent peuvent être mis à jour à la version Kubernetes du maître Kubernetes. Alors qu'IBM applique automatiquement des correctifs au maître Kubernetes, les noeuds d'agent nécessitent une commande utilisateur pour les mises à jour et l'application des correctifs.

**Attention** : la mise à jour de la version des noeuds d'agent peut provoquer l'indisponibilité de vos services et applications. Des données sont supprimées si elles ne sont pas stockées hors du pod. Utilisez des [répliques ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#replicas) dans vos déploiements pour permettre la replanification des pods sur les noeuds disponibles.

Mise à jour des clusters au niveau de la production :
- Utilisez un cluster de test pour valider que vos charges de travail et le processus de livraison ne sont pas impactés par la mise à jour. Vous ne pouvez pas revenir à la version précédente des noeuds d'agent.
- Les clusters au niveau de la production doivent être en mesure de surmonter l'échec d'un noeud d'agent. Si ce n'est pas le cas de votre cluster, ajoutez un noeud d'agent avant de mettre à jour le cluster.
- Le processus de mise à jour n'arrête pas les noeuds avant la mise à jour. Envisagez d'utiliser les commandes [`drain` ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes-v1-4.github.io/docs/user-guide/kubectl/kubectl_drain/) et [`uncordon` ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes-v1-4.github.io/docs/user-guide/kubectl/kubectl_uncordon/) pour éviter l'interruption de vos applications.

Avant de commencer, installez la version de l'[`interface CLI kubectl` ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/tasks/tools/install-kubectl/) correspondant à la version Kubernetes du maître Kubernetes.

1. Passez en revue les [modifications Kubernetes](cs_versions.html) et effectuez les modifications marquées _Mise à jour après le maître_ dans vos scripts de déploiement, si nécessaire.

2. Mettez à jour vos noeuds d'agent. Pour effectuer la mise à jour à partir du tableau de bord {{site.data.keyword.Bluemix_notm}}, accédez à la section `Worker nodes` de votre cluster, et cliquez sur `Update Worker`. Pour obtenir les ID des noeuds d'agent, exécutez la commande `bx cs workers <cluster_name_or_id>`. Si vous sélectionnez plusieurs noeuds d'agent, ils sont mis à jour un par un.

    ```
    bx cs worker-update <cluster_name_or_id> <worker_node_id1> <worker_node_id2>
    ```
    {: pre}

3. Vérifiez que vos noeuds d'agent ont été mis à jour. Vérifiez la version Kubernetes dans le tableau de bord {{site.data.keyword.Bluemix_notm}} ou exécutez la commande `bx cs workers <cluster_name_or_id>`. Confirmez aussi que la version Kubernetes répertoriée par `kubectl` a été mise à jour. Dans certains cas, des clusters plus anciens peuvent répertorier des noeuds d'agent en double avec un statut **NotReady** après une mise à jour. Pour supprimer ces doublons, voir la section de [traitement des incidents](cs_troubleshoot.html#cs_duplicate_nodes).

    ```
    kubectl get nodes
    ```
    {: pre}

5. Vérifiez le tableau de bord Kubernetes. Si les graphiques d'utilisation ne s'affichent pas dans le tableau de bord Kubernetes, supprimez le pod `kube-dashboard` pour forcer un redémarrage. Le pod sera recréé avec des règles RBAC afin d'accéder à Heapster pour obtenir les informations d'utilisation.

    ```
    kubectl delete pod -n kube-system $(kubectl get pod -n kube-system --selector=k8s-app=kubernetes-dashboard -o jsonpath='{.items..metadata.name}')
    ```
    {: pre}

Une fois la mise à jour terminée, répétez le processus de mise à jour pour les autres clusters. De plus, informez les développeurs qui travaillent dans le cluster pour qu'ils mettent à jour leur interface CLI `kubectl` à la version du maître Kubernetes.

<br />


## Ajout de sous-réseaux à des clusters
{: #cs_cluster_subnet}

Vous pouvez modifier le pool d'adresses IP portables publiques disponibles en ajoutant des sous-réseaux à votre
cluster.
{:shortdesc}

Dans {{site.data.keyword.containershort_notm}}, vous pouvez ajouter des adresses IP portables stables pour les services Kubernetes en adjoignant des sous-réseaux au cluster. Lorsque vous créez un cluster standard,
{{site.data.keyword.containershort_notm}} lui alloue automatiquement un sous-réseau public portable et 5 adresses IP. Les adresses IP publiques portables sont statiques et ne changent pas lorsqu'un noeud d'agent, ou même le cluster, est retiré.

L'une des adresses IP publiques portables est utilisée pour le [contrôleur Ingress](cs_apps.html#cs_apps_public_ingress) que vous pouvez utiliser afin d'exposer plusieurs applications dans votre cluster via une route publique. Les 4 adresses IP publiques portables restantes peuvent être utilisées pour exposer au public des applications distinctes en [créant un service d'équilibreur de charge](cs_apps.html#cs_apps_public_load_balancer).

**Remarque :** les adresses IP publiques portables sont facturées sur une base mensuelle. Si vous décidez de retirer les adresses IP portables après la mise en place de votre cluster, vous devez quand même payer les frais mensuels, même si vous ne les avez utilisées que brièvement.

### Demande de sous-réseaux supplémentaires pour votre cluster
{: #add_subnet}

Vous pouvez ajouter des adresses IP publiques portables stables au cluster en lui affectant des sous-réseaux.

Dans le cas d'utilisateurs de {{site.data.keyword.Bluemix_notm}} Dedicated, au lieu d'exécuter cette tâche, vous devez [ouvrir un ticket de demande de service](/docs/support/index.html#contacting-support) pour créer le sous-réseau, puis utiliser la commande [`bx cs cluster-subnet-add`](cs_cli_reference.html#cs_cluster_subnet_add) pour l'ajouter au cluster.

Avant de commencer, vérifiez que vous pouvez accéder au portefeuille IBM Bluemix Infrastructure (SoftLayer) via l'interface graphique {{site.data.keyword.Bluemix_notm}}. Pour accéder au portefeuille, vous devez configurer ou utiliser un compte {{site.data.keyword.Bluemix_notm}} de type Paiement à la carte existant.

1.  Dans la section **Infrastructure** du catalogue, sélectionnez **Réseau**.
2.  Sélectionnez **Sous-réseau/IP** et cliquez sur **Créer**.
3.  Dans le menu déroulant **Sélectionner le type de sous-réseau à ajouter à ce compte**, sélectionnez **Public portable**.
4.  Sélectionnez le nombre d'adresses IP que vous désirez ajouter à votre sous-réseau portable.

    **Remarque :** lorsque vous ajoutez des adresses IP publiques portables à votre sous-réseau, trois adresses IP sont utilisées pour l'opération réseau interne au cluster, de sorte que vous ne pouvez pas les utiliser pour votre contrôleur Ingress ou pour créer un service d'équilibreur de charge. Par exemple, si vous demandez huit adresses IP publiques portables, vous pouvez en utiliser cinq pour exposer vos applications au public. 

5.  Sélectionnez le réseau local virtuel public vers lequel adresser les adresses IP publiques portables. Vous devez sélectionner le réseau local virtuel public auquel un noeud d'agent existant est connecté. Identifiez le réseau local virtuel public d'un noeud d'agent.

    ```
    bx cs worker-get <worker_id>
    ```
    {: pre}

6.  Renseignez le questionnaire et cliquez sur **Passer une commande**.

    **Remarque :** les adresses IP publiques portables sont facturées sur une base mensuelle. Si vous décidez de supprimer des adresses IP publiques portables après les avoir créées, les frais pour le mois en cours vous seront néanmoins facturés, même si vous ne les avez utilisées qu'une partie du mois.

7.  Une fois le sous-réseau provisionné, rendez-le disponible pour votre cluster Kubernetes.
    1.  Dans le tableau de bord Infrastructure, sélectionnez le sous-réseau que vous avez créé et notez son ID.
    2.  Connectez-vous à l'interface de ligne de commande {{site.data.keyword.Bluemix_notm}}. Pour stipuler une région {{site.data.keyword.Bluemix_notm}}, [incluez le noeud final d'API](cs_regions.html#bluemix_regions).

        ```
        bx login
        ```
        {: pre}

        **Remarque :** si vous possédez un ID fédéré, exécutez la commande `bx login --sso` pour vous connecter à l'interface de ligne de commande {{site.data.keyword.Bluemix_notm}}. Entrez votre nom d'utilisateur et utilisez l'URL mentionnée dans la sortie CLI pour extraire votre code d'accès à usage unique. Si la connexion échoue alors que vous omettez l'option `--sso` et aboutit en incluant l'option `--sso`, ceci indique que votre ID est fédéré.

    3.  Recensez tous les clusters de votre compte et notez l'ID du cluster sur lequel vous désirez rendre disponible le sous-réseau.

        ```
        bx cs clusters
        ```
        {: pre}

    4.  Ajoutez le sous-réseau à votre cluster. Lorsque vous rendez disponible un sous-réseau pour un cluster, une mappe de configuration Kubernetes est créée pour vous et inclut toutes les adresses IP publiques portables disponibles que vous pouvez utiliser. Si aucun contrôleur Ingress n'existe pour votre cluster, une adresse IP publique portable est automatiquement utilisée pour créer le contrôleur Ingress. Toutes les autres peuvent être utilisées pour créer des services d'équilibreur de charge pour vos applications.

        ```
        bx cs cluster-subnet-add <cluster name or id> <subnet id>
        ```
        {: pre}

8.  Vérifiez que l'ajout du sous-réseau à votre cluster a abouti. Le CIDR de sous-réseau est répertorié dans la section **VLAN**.

    ```
    bx cs cluster-get --showResources <cluster name or id>
    ```
    {: pre}

### Ajout de sous-réseaux personnalisés et existants à des clusters Kubernetes
{: #custom_subnet}

Vous pouvez ajouter des sous-réseaux publics portables existants à votre cluster Kubernetes.

Avant de commencer, [ciblez avec votre interface de ligne de commande](cs_cli_install.html#cs_cli_configure) votre cluster.

Si vous disposez d'un sous-réseau existant dans votre portefeuille IBM Bluemix Infrastructure (SoftLayer) avec des règles de pare-feu personnalisées ou des adresses IP disponibles que vous désirez utiliser, créez un cluster sans sous-réseau et rendez votre sous-réseau existant disponible au cluster lors de la mise à disposition du cluster.

1.  Identifiez le sous-réseau à utiliser. Notez l'ID du sous-réseau et l'ID du réseau local virtuel. Dans cet exemple,  l'ID du sous-réseau est 807861 et l'ID du réseau local virtuel est 1901230.

    ```
    bx cs subnets
    ```
    {: pre}

    ```
    Getting subnet list...
    OK
    ID        Network                                      Gateway                                   VLAN ID   Type      Bound Cluster   
    553242    203.0.113.0/24                               10.87.15.00                               1565280   private      
    807861    192.0.2.0/24                                 10.121.167.180                            1901230   public

    ```
    {: screen}

2.  Vérifiez l'emplacement du réseau local virtuel. Dans cet exemple, son emplacement est dal10.

    ```
    bx cs vlans dal10
    ```
    {: pre}

    ```
    Getting VLAN list...
    OK
    ID        Name                  Number   Type      Router   
    1900403   vlan                    1391     private   bcr01a.dal10   
    1901230   vlan                    1180     public   fcr02a.dal10
    ```
    {: screen}

3.  Créez un cluster en utilisant l'emplacement et l'ID du réseau local virtuel que vous avez identifiés. Incluez l'indicateur `--no-subnet` pour empêcher la création automatique d'un nouveau sous-réseau d'adresses IP publiques portables.

    ```
    bx cs cluster-create --location dal10 --machine-type u1c.2x4 --no-subnet --public-vlan 1901230 --private-vlan 1900403 --workers 3 --name my_cluster
    ```
    {: pre}

4.  Vérifiez que la création du cluster a été demandée.

    ```
    bx cs clusters
    ```
    {: pre}

    **Remarque :** la réservation des postes de noeud d'agent et la mise en place et la mise à disposition du cluster dans votre compte peuvent prendre jusqu'à 15 minutes.

    Lorsque la mise à disposition de votre cluster est finalisée, le statut du cluster passe à **deployed**.

    ```
    Name         ID                                   State      Created          Workers   
    my_cluster   paf97e8843e29941b49c598f516de72101   deployed   20170201162433   3
    ```
    {: screen}

5.  Vérifiez le statut des noeuds d'agent.

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

6.  Ajoutez le sous-réseau à votre cluster en spécifiant l'ID du sous-réseau. Lorsque vous rendez disponible un sous-réseau pour un cluster, une mappe de configuration Kubernetes est créée pour vous et inclut toutes les adresses IP publiques portables disponibles que vous pouvez utiliser. Si aucun contrôleur Ingress n'existe encore pour votre cluster, une adresse IP publique portable est automatiquement utilisée pour créer le contrôleur Ingress. Toutes les autres peuvent être utilisées pour créer des services d'équilibreur de charge pour vos applications.

    ```
    bx cs cluster-subnet-add mycluster 807861
    ```
    {: pre}

### Ajout de sous-réseaux et d'adresses IP gérés par l'utilisateur aux clusters Kubernetes
{: #user_subnet}

Fournissez votre propre sous-réseau à partir d'un réseau sur site que vous souhaitez accessible à {{site.data.keyword.containershort_notm}}. Vous pouvez ensuite ajouter des adresses IP privées de ce sous-réseau aux services d'équilibreur de charge dans votre cluster Kubernetes.

Conditions requises :
- Les sous-réseaux gérés par l'utilisateur peuvent être ajoutés uniquement à des réseaux locaux virtuels (VLAN) privés.
- La limite de longueur du préfixe de sous-réseau est /24 à /30. Par exemple, `203.0.113.0/24` indique 253 adresses IP privées utilisables, alors que `203.0.113.0/30` indique 1 adresse IP privée utilisable.
- La première adresse IP dans le sous-réseau doit être utilisée comme passerelle du sous-réseau.

Avant de commencer, configurez le routage du trafic réseau entrant et sortant du sous-réseau externe. Confirmez également qu'il existe une connectivité VPN entre le périphérique de passerelle du centre de données sur site et le réseau privé Vyatta de votre portefeuille IBM Bluemix Infrastructure (SoftLayer). Pour plus d'informations, voir cet [article de blogue ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/blogs/bluemix/2017/07/kubernetes-and-bluemix-container-based-workloads-part4/).

1. Affichez l'ID du réseau local virtuel privé de votre cluster. Localisez la section **VLANs**. Dans la zone **Is Public?**, identifiez l'ID VLAN avec la valeur _false_.

    ```
    bx cs cluster-get --showResources <cluster_name>
    ```
    {: pre}

    ```
    VLANs
    VLAN ID   Subnet CIDR         Is Public?   Is BYOIP?
    1555503   192.0.2.0/24        true         false
    1555505   198.51.100.0/24     false        false
    ```
    {: screen}

2. Ajoutez le sous-réseau externe à votre VLAN privé. Les adresses IP privées portables sont ajoutées à la mappe de configuration du cluster.

    ```
    bx cs cluster-user-subnet-add <subnet_CIDR> <VLAN_ID>
    ```
    {: pre}

    Exemple :

    ```
    bx cs cluster-user-subnet-add 203.0.113.0/24 1555505
    ```
    {: pre}

3. Vérifiez que le sous-réseau fourni par l'utilisateur a été ajouté. La zone **Is BYOIP?** a la valeur _true_.

    ```
    bx cs cluster-get --showResources <cluster_name>
    ```
    {: pre}

    ```
    VLANs
    VLAN ID   Subnet CIDR         Is Public?   Is BYOIP?
    1555503   192.0.2.0/24        true         false
    1555505   198.51.100.0/24     false        false
    1555505   203.0.113.0/24      false        true
    ```
    {: screen}

4. Ajoutez un équilibreur de charge privé pour accéder à votre application via le réseau privé. Si vous voulez utiliser une adresse IP privée à partir du sous-réseau que vous avez ajouté, vous devez spécifier une adresse IP lorsque vous créez un équilibreur de charge privé. Autrement, une adresse IP est sélectionnée de manière aléatoire dans les sous-réseaux IBM Bluemix Infrastructure (SoftLayer) ou dans les sous-réseaux fournis par l'utilisateur sur le VLAN privé. Pour plus d'informations, voir [Configuration de l'accès à une application](cs_apps.html#cs_apps_public_load_balancer).

    Exemple de fichier de configuration pour un service d'équilibreur de charge privé avec une adresse IP spécifiée :

    ```
    apiVersion: v1
    kind: Service
    metadata:
      name: <myservice>
      annotations:
        service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: private
    spec:
      type: LoadBalancer
      selector:
        <selectorkey>:<selectorvalue>
      ports:
       - protocol: TCP
         port: 8080
      loadBalancerIP: <private_ip_address>
    ```
    {: codeblock}

<br />


## Utilisation de partages de fichiers NFS existants dans des clusters
{: #cs_cluster_volume_create}

Si vous disposez déjà de partages de fichiers NFS existants dans votre compte IBM Bluemix Infrastructure (SoftLayer) et désirez les utiliser avec Kubernetes, créez alors des volumes persistants sur votre partage de fichiers NFS existant. Un volume persistant est un élément matériel réel qui fait office de ressource de cluster Kubernetes et peut être consommé par l'utilisateur du cluster.
{:shortdesc}

Avant de commencer, vérifiez que vous disposez d'un partage de fichiers NFS existant que vous pouvez utiliser pour créer votre volume persistant.

[![Créer des volumes persistants et des réservations de volumes persistants](images/cs_cluster_pv_pvc.png)](https://console.bluemix.net/docs/api/content/containers/images/cs_cluster_pv_pvc.png)

Kubernetes fait une distinction entre les volumes persistants qui représentent le matériel effectif et les réservations de volume persistant qui sont des demandes de stockage déclenchées habituellement par l'utilisateur du cluster. Si vous désirez permettre
l'utilisation de partage de fichiers NLS existants avec Kubernetes, vous devez créer des volumes persistants
d'une certaine taille et avec un mode d'accès déterminé, qui soient conformes à la spécification de
volume persistant. Si le volume persistant et la réservation de volume persistant correspondent, ils sont liés l'un à l'autre. Seules les réservations de volume persistant liées peuvent être utilisées par l'utilisateur du cluster pour monter le volume sur un pod. Cette procédure est dénommée provisionnement statique de stockage persistant.

**Remarque :** le provisionnement statique de stockage persistant ne s'applique qu'aux partages de fichiers NFS existants. Si vous ne disposez pas de partages de fichiers
NFS existants, les utilisateurs du cluster peuvent utiliser la procédure de [provisionnement dynamique](cs_apps.html#cs_apps_volume_claim) pour ajouter des volumes persistants.

Pour créer un volume persistant et une réservation correspondante, procédez comme suit.

1.  Dans votre compte Bluemix Infrastructure (SoftLayer), recherchez l'ID et le chemin du partage NFS où vous désirez créer votre objet de volume persistant.
    1.  Connectez-vous à votre compte IBM Bluemix Infrastructure (SoftLayer).
    2.  Cliquez sur **Stockage**.
    3.  Cliquez sur **Stockage de fichiers** et notez l'ID et le chemin du partage de fichiers NFS que vous désirez utiliser.
2.  Ouvrez l'éditeur de votre choix.
3.  Créez un fichier de configuration de stockage pour votre volume persistant.

    ```
    apiVersion: v1
    kind: PersistentVolume
    metadata:
     name: mypv
    spec:
     capacity:
       storage: "20Gi"
     accessModes:
       - ReadWriteMany
     nfs:
       server: "nfslon0410b-fz.service.softlayer.com"
       path: "/IBM01SEV8491247_0908"
    ```
    {: codeblock}

    <table>
    <caption>Tableau 8. Description des composants du fichier YAML</caption>
    <thead>
    <th colspan=2><img src="images/idea.png"/> Description des composants du fichier YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code>name</code></td>
    <td>Entrez le nom de l'objet de volume persistant que vous désirez créer.</td>
    </tr>
    <tr>
    <td><code>stockage</code></td>
    <td>Entrez la taille de stockage du partage de fichiers NFS existant. Cette taille doit être indiquée en gigaoctets, par exemple 20Gi (20 Go) ou 1000Gi (1 To), et correspondre à celle du partage de fichiers existant.</td>
    </tr>
    <tr>
    <td><code>accessMode</code></td>
    <td>Les modes d'accès définissent la manière dont une réservation de volume persistant peut être montée sur un noeud d'agent.<ul><li>ReadWriteOnce (RWO) : le volume persistant ne peut être monté sur des pods que dans un noeud d'agent unique. Les pods montés sur ce volume persistant peuvent lire et écrire sur le volume.</li><li>ReadOnlyMany (ROX) : le volume persistant peut être monté sur des pods hébergés sur plusieurs noeuds d'agent. Les pods montés sur ce volume persistant peuvent uniquement lire les données du volume.</li><li>ReadWriteMany (RWX) : le volume persistant peut être monté sur des pods hébergés sur plusieurs noeuds d'agent. Les pods montés sur ce volume persistant peuvent lire et écrire sur le volume.</li></ul></td>
    </tr>
    <tr>
    <td><code>server</code></td>
    <td>Entrez l'ID du serveur du partage de fichiers NFS.</td>
    </tr>
    <tr>
    <td><code>path</code></td>
    <td>Entrez le chemin du partage de fichiers NFS où vous désirez créer l'objet de volume persistant.</td>
    </tr>
    </tbody></table>

4.  Créez le volume persistent dans votre cluster.

    ```
    kubectl apply -f <yaml_path>
    ```
    {: pre}

    Exemple

    ```
    kubectl apply -f deploy/kube-config/pv.yaml
    ```
    {: pre}

5.  Vérifiez que le volume persistant a été créé.

    ```
    kubectl get pv
    ```
    {: pre}

6.  Créez un autre fichier de configuration pour créer votre réservation de volume persistant. Pour que la réservation de volume persistant corresponde à l'objet de volume persistant créé auparavant, vous devez sélectionner la même valeur pour `storage` et pour `accessMode`. La zone `storage-class` doit être vide. Si l'une de ces zones ne correspond pas au volume persistant, un nouveau volume persistant est créé automatiquement à la place.

    ```
    kind: PersistentVolumeClaim
    apiVersion: v1
    metadata:
     name: mypvc
     annotations:
       volume.beta.kubernetes.io/storage-class: ""
    spec:
     accessModes:
       - ReadWriteMany
     resources:
       requests:
         storage: "20Gi"
    ```
    {: codeblock}

7.  Créez votre réservation de volume persistant.

    ```
    kubectl apply -f deploy/kube-config/mypvc.yaml
    ```
    {: pre}

8.  Vérifiez que votre réservation de volume persistant a été créée et liée à l'objet de volume persistant. Ce processus peut prendre quelques minutes.

    ```
    kubectl describe pvc mypvc
    ```
    {: pre}

    Votre sortie sera similaire à ceci.

    ```
    Name: mypvc
    Namespace: default
    StorageClass: ""
    Status: Bound
    Volume: pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
    Labels: <none>
    Capacity: 20Gi
    Access Modes: RWX
    Events:
      FirstSeen LastSeen Count From        SubObjectPath Type Reason Message
      --------- -------- ----- ----        ------------- -------- ------ -------
      3m 3m 1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 } Normal Provisioning External provisioner is provisioning volume for claim "default/my-persistent-volume-claim"
      3m 1m  10 {persistentvolume-controller } Normal ExternalProvisioning cannot find provisioner "ibm.io/ibmc-file", expecting that a volume for the claim is provisioned either manually or via external software
      1m 1m 1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 } Normal ProvisioningSucceeded Successfully provisioned volume pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
    ```
    {: screen}


Vous avez créé correctement un objet de stockage persistant et l'avez lié à une réclamation de volume
persistant. Les utilisateurs du cluster peuvent à présent [monter la réservation de volume persistant](cs_apps.html#cs_apps_volume_mount) sur leur pod et lancer une lecture et écriture sur l'objet de volume persistant.

<br />


## Configuration de la journalisation de cluster
{: #cs_logging}

Les journaux vous aident à identifier et résoudre les incidents liés à vos clusters et à vos applications. Vous pouvez activer le transfert de journaux pour plusieurs sources de journaux de cluster et choisir l'emplacement de destination de vos transferts de journaux.
{:shortdesc}

### Affichage des journaux
{: #cs_view_logs}

Pour afficher les journaux des clusters et des conteneurs, vous pouvez utiliser les fonctions de journalisation standard de Kubernetes et Docker.
{:shortdesc}

#### {{site.data.keyword.loganalysislong_notm}}
{: #cs_view_logs_k8s}

Pour les clusters standard, les journaux se trouvent dans l'espace {{site.data.keyword.Bluemix_notm}} où vous vous êtes connecté lorsque vous avez créé le cluster Kubernetes. Les journaux de conteneur sont surveillés et réacheminés depuis l'extérieur du conteneur. Vous pouvez accéder aux journaux d'un conteneur via le tableau de bord Kibana. Pour plus d'informations sur la journalisation, voir [Journalisation pour {{site.data.keyword.containershort_notm}}](/docs/services/CloudLogAnalysis/containers/logging_containers_ov.html#logging_containers_ov).

Pour accéder au tableau de bord Kibana, accédez à l'une des URL suivantes et sélectionnez l'organisation et l'espace {{site.data.keyword.Bluemix_notm}} dans lesquels vous avez créé le cluster.
- Sud et Est des Etats-Unis : https://logging.ng.bluemix.net
- Sud du Royaume-Uni : https://logging.eu-gb.bluemix.net
- Europe centrale : https://logging.eu-de.bluemix.net

#### Journaux Docker
{: #cs_view_logs_docker}

Vous pouvez exploiter les capacités de journalisation intégrées de Docker pour examiner les activités sur les flux de sortie
STDOUT et STDERR standard. Pour plus d'informations, voir [Affichage des journaux pour un conteneur s'exécutant dans un cluster Kubernetes](/docs/services/CloudLogAnalysis/containers/logging_containers_ov.html#logging_containers_ov_methods_view_kube).

### Configuration de transfert des journaux pour un espace de nom du conteneur Docker
{: #cs_configure_namespace_logs}

Par défaut, {{site.data.keyword.containershort_notm}} transfère les journaux de l'espace de nom du conteneur Docker à {{site.data.keyword.loganalysislong_notm}}. Vous pouvez également transférer ces journaux à un serveur syslog externe en créant une nouvelle configuration de transfert de journaux.
{:shortdesc}

**Remarque** : pour afficher les journaux sur le site de Sydney, vous devez transférer les journaux à un serveur syslog externe.

#### Activation du transfert de journaux vers syslog
{: #cs_namespace_enable}

Avant de commencer :

1. Configurez un serveur en mesure d'accepter un protocole syslog. Vous pouvez exécuter un serveur syslog de deux manières :
  * Configurer et gérer votre propre serveur ou confier la gestion du serveur à un fournisseur. Dans ce cas, obtenez le noeud final de journalisation du fournisseur de journalisation.
  * Exécuter syslog à partir d'un conteneur. Par exemple, vous pouvez utiliser ce [fichier .yaml de déploiement](https://github.com/IBM-Bluemix/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube) pour extraire une image publique Docker qui exécute un conteneur dans un cluster Kubernetes. L'image publie le port `30514` sur l'adresse IP du cluster public et utilise cette adresse pour configurer l'hôte syslog.

2. [Ciblez avec votre interface CLI](cs_cli_install.html#cs_cli_configure) le cluster où se trouve l'espace de nom.

Pour transférer vos journaux d'espace de nom à un serveur syslog :

1. Créez la configuration de journalisation.

    ```
    bx cs logging-config-update <my_cluster> --namespace <my_namespace> --hostname <log_server_hostname> --port <log_server_port> --type syslog
    ```
    {: pre}

    <table>
    <caption>Tableau 1. Description des composantes de cette commande</caption>
    <thead>
    <th colspan=2><img src="images/idea.png"/> Description des composantes de cette commande</th>
    </thead>
    <tbody>
    <tr>
    <td><code>logging-config-create</code></td>
    <td>Commande pour créer la configuration de transfert des journaux pour votre espace de nom.</td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td>Remplacez <em>&lt;my_cluster&gt;</em> par le nom ou l'ID du cluster.</td>
    </tr>
    <tr>
    <td><code>--namespace <em>&lt;my_namespace&gt;</em></code></td>
    <td>Remplacez <em>&lt;my_namespace&gt;</em> par le nom de l'espace de nom. Le transfert des journaux n'est pas pris en charge pour les espaces de nom Kubernetes <code>ibm-system</code> et <code>kube-system</code>. Si vous n'indiquez pas d'espace de nom, tous les espaces de nom du conteneur utilisent cette configuration.</td>
    </tr>
    <tr>
    <td><code>--hostname <em>&lt;log_server_hostname&gt;</em></code></td>
    <td>Remplacez <em>&lt;log_server_hostname&gt;</em> par le nom d'hôte ou l'adresse IP du serveur collecteur de journal.</td>
    </tr>
    <tr>
    <td><code>--port <em>&lt;log_server_port&gt;</em></code></td>
    <td>Remplacez <em>&lt;log_server_port&gt;</em> par le port du serveur collecteur de journal. Si vous n'indiquez pas de port, le port standard <code>514</code> est utilisé pour syslog.</td>
    </tr>
    <tr>
    <td><code>--type syslog</code></td>
    <td>Type de journal pour syslog.</td>
    </tr>
    </tbody></table>

2. Vérifiez que la configuration de transfert des journaux a été créée.

  * Pour répertorier toutes les configurations de journalisation dans le cluster :
    ```
    bx cs logging-config-get <my_cluster>
    ```
    {: pre}

    Exemple de sortie :

    ```
    Logging Configurations
    ---------------------------------------------
    Id                                    Source      Protocol Host       Port
    f4bc77c0-ee7d-422d-aabf-a4e6b977264e  kubernetes  syslog   localhost  5514
    5bd9c609-13c8-4c48-9d6e-3a6664c825a9  ingress     ibm      -          -

    Container Log Namespace configurations
    ---------------------------------------------
    Namespace         Protocol    Host        Port
    default           syslog      localhost   5514
    my-namespace      syslog      localhost   5514   
    ```
    {: screen}

  * Pour répertorier uniquement les configurations de journalisation d'espaces de nom :
    ```
    bx cs logging-config-get <my_cluster> --logsource namespaces
    ```
    {: pre}

    Exemple de sortie :

    ```
    Namespace         Protocol    Host        Port
    default           syslog      localhost   5514
    myapp-namespace   syslog      localhost   5514
    ```
    {: screen}

#### Mise à jour de la configuration de serveur syslog
{: #cs_namespace_update}

Si vous souhaitez mettre à jour les détails de la configuration de serveur syslog actuelle ou changer de serveur syslog, vous pouvez mettre à jour la configuration de transfert des journaux.
{:shortdesc}

Avant de commencer :

1. [Ciblez avec votre interface CLI](cs_cli_install.html#cs_cli_configure) le cluster où se trouve l'espace de nom.

Pour modifier les détails de la configuration de transfert syslog :

1. Mettez à jour la configuration de transfert des journaux.

    ```
    bx cs logging-config-update <my_cluster> --namespace <my_namespace> --hostname <log_server_hostname> --port <log_server_port> --type syslog
    ```
    {: pre}

    <table>
    <caption>Tableau 2. Description des composantes de cette commande</caption>
    <thead>
    <th colspan=2><img src="images/idea.png"/> Description des composantes de cette commande</th>
    </thead>
    <tbody>
    <tr>
    <td><code>logging-config-update</code></td>
    <td>Commande utilisée pour mettre à jour la configuration de transfert des journaux pour votre espace de nom.</td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td>Remplacez <em>&lt;my_cluster&gt;</em> par le nom ou l'ID du cluster.</td>
    </tr>
    <tr>
    <td><code>--namepsace <em>&lt;my_namespace&gt;</em></code></td>
    <td>Remplacez <em>&lt;log_source_id&gt;</em> par le nom de l'espace de nom avec la configuration de journalisation.</td>
    </tr>
    <tr>
    <td><code>--hostname <em>&lt;log_server_hostname&gt;</em></code></td>
    <td>Remplacez <em>&lt;log_server_hostname&gt;</em> par le nom d'hôte ou l'adresse IP du serveur collecteur de journal.</td>
    </tr>
    <tr>
    <td><code>--port <em>&lt;log_collector_port&gt;</em></code></td>
    <td>Remplacez <em>&lt;log_server_port&gt;</em> par le port du serveur collecteur de journal. Si vous n'indiquez pas de port, le port standard <code>514</code> est utilisé.</td>
    </tr>
    <tr>
    <td><code>--type syslog</code></td>
    <td>Type de journalisation pour <code>syslog</code>.</td>
    </tr>
    </tbody></table>

2. Vérifiez que la configuration de transfert des journaux a été mise à jour.
    ```
    bx cs logging-config-get <my_cluster> --logsource namespaces
    ```
    {: pre}

    Exemple de sortie :

    ```
    Namespace         Protocol    Host        Port
    default           syslog      localhost   5514
    myapp-namespace   syslog      localhost   5514
    ```
    {: screen}

#### Arrêt du transfert de journaux vers syslog
{: #cs_namespace_delete}

Vous pouvez arrêter de transférer les journaux d'un espace de nom en supprimant la configuration de journalisation.

**Remarque** : cette action supprime uniquement la configuration du transfert de journaux vers un serveur syslog. Les journaux de l'espace de nom continuent à être transférés à {{site.data.keyword.loganalysislong_notm}}.

Avant de commencer :

1. [Ciblez avec votre interface CLI](cs_cli_install.html#cs_cli_configure) le cluster où se trouve l'espace de nom.

Pour arrêter de transférer les journaux vers syslog :

1. Supprimez la configuration de journalisation.

    ```
    bx cs logging-config-rm <my_cluster> --namespace <my_namespace>
    ```
    {: pre}
    Remplacez <em>&lt;my_cluster&gt;</em> par le nom du cluster dans lequel se trouve la configuration de journalisation et <em>&lt;my_namespace&gt;</em> par le nom de l'espace de nom.


<br />


## Visualisation de ressources de cluster Kubernetes
{: #cs_weavescope}

Weave Scope produit un diagramme visuel de vos ressources dans un cluster Kubernetes, notamment des services, pods, conteneurs, processus, noeuds, et autres. Weave Scope fournit des métriques interactives sur l'utilisation de l'UC et de la mémoire, ainsi que des outils pour suivi et exécution dans un conteneur.
{:shortdesc}

Avant de commencer :

-   Prenez soin de ne pas exposer les informations de votre cluster sur l'Internet public. Procédez comme suit pour déployer de manière sécurisée Weave Scope et y accéder en local depuis un navigateur Web.
-   Si ne n'est déjà fait, [créez un cluster standard](#cs_cluster_ui). Weave Scope peut solliciter énormément l'unité centrale, surtout l'application. Utilisez Weave Scope avec des clusters standard plus volumineux, et non pas avec des clusters légers.
-   [Ciblez avec votre interface CLI](cs_cli_install.html#cs_cli_configure) votre cluster pour exécuter des commandes `kubectl`.


Pour utiliser Weave Scope avec un cluster, procédez comme suit :
2.  Déployez dans le cluster l'un des fichiers de configuration d'autorisations RBAC fournis.

    Pour activer les droits d'accès en lecture / écriture, exécutez la commande suivante :

    ```
    kubectl apply -f "https://raw.githubusercontent.com/IBM-{{site.data.keyword.Bluemix_notm}}/kube-samples/master/weave-scope/weave-scope-rbac.yaml"
    ```
    {: pre}

    Pour activer les droits d'accès en lecture seule, exécutez la commande suivante :

    ```
    kubectl apply -f "https://raw.githubusercontent.com/IBM-{{site.data.keyword.Bluemix_notm}}/kube-samples/master/weave-scope/weave-scope-rbac-readonly.yaml"
    ```
    {: pre}

    Sortie :

    ```
    clusterrole "weave-scope-mgr" created
    clusterrolebinding "weave-scope-mgr-role-binding" created
    ```
    {: screen}

3.  Déployez le service Weave Scope, lequel est accessible en mode privé via l'adresse IP du cluster.

    <pre class="pre">
    <code>kubectl apply --namespace kube-system -f "https://cloud.weave.works/k8s/scope.yaml?k8s-version=$(kubectl version | base64 | tr -d '&bsol;n')"</code>
    </pre>

    Sortie :

    ```
    serviceaccount "weave-scope" created
    deployment "weave-scope-app" created
    service "weave-scope-app" created
    daemonset "weave-scope-agent" created
    ```
    {: screen}

4.  Exécutez une commande d'acheminement de port pour accéder au service sur votre ordinateur. A présent que Weave Scope est configuré avec le cluster, pour accéder à Weave Scope la prochaine fois, vous pouvez lancer cette commande d'acheminement de port sans avoir à exécuter à nouveau la procédure de configuration précédente.

    ```
    kubectl port-forward -n kube-system "$(kubectl get -n kube-system pod --selector=weave-scope-component=app -o jsonpath='{.items..metadata.name}')" 4040
    ```
    {: pre}

    Sortie :

    ```
    Forwarding from 127.0.0.1:4040 -> 4040
    Forwarding from [::1]:4040 -> 4040
    Handling connection for 4040
    ```
    {: screen}

5.  Ouvrez votre navigateur Web sur l'adresse `http://localhost:4040`. Choisissez d'afficher des diagrammes de topologie ou bien des tableaux des ressources Kubernetes dans le cluster.

     <img src="images/weave_scope.png" alt="Exemple de topologie Weave Scope" style="width:357px;" />


[En savoir plus sur les fonctions Weave Scope ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.weave.works/docs/scope/latest/features/).

<br />


## Suppression de clusters
{: #cs_cluster_remove}

Lorsque vous avez fini d'utiliser un cluster, vous pouvez le supprimer afin qu'il ne consomme plus de ressources.
{:shortdesc}

Les clusters léger et standard créés avec un compte {{site.data.keyword.Bluemix_notm}} standard ou de type Paiement à la carte doivent être supprimés manuellement par l'utilisateur lorsque celui-ci n'en a plus besoin. Les clusters légers créés avec un compte d'essai gratuit sont automatiquement supprimés à l'expiration de la période d'évaluation gratuite.

Lorsque vous supprimez un cluster, vous supprimez également les ressources sur le cluster, notamment les conteneurs, les pods, les services liés et les valeurs confidentielles. Si vous ne supprimez pas l'espace de stockage lorsque vous supprimez votre cluster, vous pouvez le supprimer via le tableau de bord IBM Bluemix Infrastructure (SoftLayer) dans l'interface graphique de {{site.data.keyword.Bluemix_notm}}. En raison du cycle de facturation mensuel, une réservation de volume persistant ne peut pas être supprimée le dernier jour du mois. Si vous supprimez la réservation de volume persistant le dernier jour du mois, la suppression reste en attente jusqu'au début du mois suivant.

**Avertissement :** aucune sauvegarde de votre cluster ou de vos données n'est effectuée dans votre stockage persistant. La suppression d'un cluster est définitive et irréversible.

-   Dans l'interface graphique {{site.data.keyword.Bluemix_notm}}
    1.  Sélectionnez votre cluster et cliquez sur **Supprimer** dans le menu **Plus d'actions...**.
-   Depuis l'interface CLI de {{site.data.keyword.Bluemix_notm}}
    1.  Répertoriez les clusters disponibles.

        ```
        bx cs clusters
        ```
        {: pre}

    2.  Supprimez le cluster.

        ```
        bx cs cluster-rm my_cluster
        ```
        {: pre}

    3.  Suivez les invites et indiquez si vous souhaitez supprimer les ressources de cluster.

Lorsque vous supprimez un cluster, les sous-réseaux portables publics et privés ne sont pas supprimés automatiquement. Les sous-réseaux sont utilisés pour affecter des adresses IP portables publiques aux services d'équilibreur de charge ou à votre contrôleur Ingress. Vous pouvez supprimer manuellement ces sous-réseaux ou les réutiliser dans un nouveau cluster.
