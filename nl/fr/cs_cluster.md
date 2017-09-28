---

copyright:
  years: 2014, 2017
lastupdated: "2017-08-21"

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

![Niveaux de haute disponibilité pour un cluster](images/cs_cluster_ha_roadmap.png)](https://console.bluemix.net/docs/api/content/containers/images/cs_cluster_ha_roadmap.png)

## Création de clusters depuis l'interface graphique
{: #cs_cluster_ui}

Un cluster Kubernetes est un ensemble de noeuds d'agent organisés dans un réseau. L'objet de ce cluster est de définir un ensemble de ressources, de noeuds, de réseaux et de périphériques de stockage permettant d'assurer une haute disponibilité des applications. Avant de pouvoir déployer une application, vous devez créer un cluster et spécifier les définitions des noeuds d'agent dans ce cluster. {:shortdesc}

Dans le cas d'utilisateurs de {{site.data.keyword.Bluemix_notm}} Dedicated, voir à la place la rubrique [Création de clusters depuis l'interface graphique dans {{site.data.keyword.Bluemix_notm}} Dedicated (version bêta fermée)](#creating_cli_dedicated). 

Pour créer un cluster, procédez comme suit :
1.  Dans le catalogue, sélectionnez **Conteneurs** et cliquez sur **Cluster Kubernetes**.

2.  Pour **Type de cluster**, sélectionnez **Standard**. Un cluster standard vous octroie des fonctions supplémentaires telles que des noeuds d'agent multiples pour promouvoir un environnement de haute disponibilité.
3.  Renseignez la zone **Nom du cluster**.
4.  Sélectionnez la **version Kubernetes** à utiliser dans les noeuds d'agent. 
5.  Sélectionnez un **emplacement** {{site.data.keyword.Bluemix_notm}} où déployer votre cluster. Les emplacements disponibles dépendent de la région {{site.data.keyword.Bluemix_notm}} à laquelle vous vous êtes connecté. Pour des performances optimales, sélectionnez la région physiquement la plus proche. Si vous sélectionnez un emplacement à l'étranger, il se peut que vous ayez besoin d'une autorisation des autorités pour stocker physiquement les données dans un autre pays. La région {{site.data.keyword.Bluemix_notm}} détermine le registre de conteneurs que vous pouvez utiliser et les services {{site.data.keyword.Bluemix_notm}} qui vous sont disponibles.
6.  Sélectionnez un **type de machine**. Le type de machine détermine le nombre d'UC virtuelles et la mémoire déployés dans chaque noeud d'agent et disponibles pour tous les conteneurs que vous déployez dans vos noeuds.
    -   Le type de machine micro correspond à l'option la plus modique.
    -   Un type de machine équilibré affecte la même quantité de mémoire à chaque UC, ce qui optimise les performances.
7.  Sélectionnez le **nombre de noeuds d'agent** dont vous avez besoin. Sélectionnez la valeur 3 pour assurer une haute disponibilité de votre cluster.
8.  Sélectionnez un **VLAN privé** dans votre compte {{site.data.keyword.BluSoftlayer_full}}. Ce réseau local virtuel privé est utilisé pour la communication entre les noeuds d'agent. Vous pouvez utiliser le même VLAN privé pour plusieurs clusters.
9. Sélectionnez un **VLAN public** dans votre compte {{site.data.keyword.BluSoftlayer_notm}}. Ce VLAN public est utilisé pour la communication entre les noeuds d'agent et le maître Kubernetes géré par IBM. Vous pouvez utiliser le même VLAN public pour plusieurs clusters. Si vous ne sélectionnez pas de VLAN public, vous devez configurer une solution alternative.
10. Pour **Matériel**, sélectionnez **Dédié** ou **Partagé**. **Partagé** est une option satisfaisante pour la plupart des situations.
    -   **Dédié** : assure un isolement complet de vos ressources physiques vis à vis des autres clients IBM.
    -   **Partagé** : permet à IBM de stocker vos ressources physiques sur le même matériel que pour d'autres clients IBM.
11. Cliquez sur **Créer un cluster**. La section des informations détaillées sur le cluster s'ouvre, mais l'allocation de noeuds d'agent dans le cluster prend quelques minutes. Vous pouvez suivre la progression du déploiement du noeud d'agent dans l'onglet **Noeuds d'agent**. Lorsque les noeuds d'agent sont prêts, l'état passe à **Ready**.



    **Remarque :** A chaque noeud d'agent sont affectés un ID de noeud d'agent unique et un nom de domaine qui ne doivent pas être modifiés manuellement après la création du cluster. La modification de l'ID ou du domaine empêcherait le maître Kubernetes de gérer votre cluster.


**Etape suivante ?**

Une fois le cluster opérationnel, vous pouvez réaliser les tâches suivantes :

-   [Installez les interfaces de ligne de commande pour commencer à utiliser votre cluster.](cs_cli_install.html#cs_cli_install)
-   [Déployez une application dans votre cluster.](cs_apps.html#cs_apps_cli)
-   [Configurez votre propre registre privé dans {{site.data.keyword.Bluemix_notm}} afin de stocker et de partager des images Docker avec d'autres utilisateurs.](/docs/services/Registry/index.html)

### Création de clusters à l'aide de l'interface graphique dans {{site.data.keyword.Bluemix_notm}} Dedicated (version bêta fermée)
{: #creating_ui_dedicated}

1.  Connectez-vous à la console {{site.data.keyword.Bluemix_notm}} Public ([https://console.bluemix.net ![External link icon](../icons/launch-glyph.svg "External link icon")](https://console.bluemix.net)) à l'aide de votre IBMid. 
2.  Dans le menu de compte, sélectionnez votre compte {{site.data.keyword.Bluemix_notm}} Dedicated. La console est mise à jour avec les services et les informations de votre instance {{site.data.keyword.Bluemix_notm}} Dedicated. 
3.  Dans le catalogue, sélectionnez **Conteneurs** et cliquez sur **Cluster Kubernetes**.
4.  Renseignez la zone **Nom du cluster**.
5.  Sélectionnez la **version Kubernetes** à utiliser dans les noeuds d'agent. 
6.  Sélectionnez un **type de machine**. Le type de machine détermine le nombre d'UC virtuelles et la mémoire déployés dans chaque noeud d'agent et disponibles pour tous les conteneurs que vous déployez dans vos noeuds.
    -   Le type de machine micro correspond à l'option la plus modique.
    -   Un type de machine équilibré affecte la même quantité de mémoire à chaque UC, ce qui optimise les performances.
7.  Sélectionnez le **nombre de noeuds d'agent** dont vous avez besoin. Sélectionnez la valeur 3 pour assurer une haute disponibilité de votre cluster.
8.  Cliquez sur **Créer un cluster**. La section des informations détaillées sur le cluster s'ouvre, mais l'allocation de noeuds d'agent dans le cluster prend quelques minutes. Vous pouvez suivre la progression du déploiement du noeud d'agent dans l'onglet **Noeuds d'agent**. Lorsque les noeuds d'agent sont prêts, l'état passe à **Ready**.



**Etape suivante ?**

Une fois le cluster opérationnel, vous pouvez réaliser les tâches suivantes :

-   [Installez les interfaces de ligne de commande pour commencer à utiliser votre cluster.](cs_cli_install.html#cs_cli_install)
-   [Déployez une application dans votre cluster.](cs_apps.html#cs_apps_cli)
-   [Configurez votre propre registre privé dans {{site.data.keyword.Bluemix_notm}} afin de stocker et de partager des images Docker avec d'autres utilisateurs.](/docs/services/Registry/index.html)

## Création de clusters depuis l'interface CLI
{: #cs_cluster_cli}

Un cluster est un ensemble de noeuds d'agent organisés dans un réseau. L'objet de ce cluster est de définir un ensemble de ressources, de noeuds, de réseaux et de périphériques de stockage permettant d'assurer une haute disponibilité des applications. Avant de pouvoir déployer une application, vous devez créer un cluster et spécifier les définitions des noeuds d'agent dans ce cluster. {:shortdesc}

Dans le cas d'utilisateurs de {{site.data.keyword.Bluemix_notm}} Dedicated, voir à la place la rubrique [Création de clusters depuis l'interface graphique dans {{site.data.keyword.Bluemix_notm}} Dedicated (version bêta fermée)](#creating_cli_dedicated).

Pour créer un cluster, procédez comme suit :
1.  Installez l'interface de ligne de commande {{site.data.keyword.Bluemix_notm}} et le [plug-in {{site.data.keyword.containershort_notm}}](cs_cli_install.html#cs_cli_install).
2.  Connectez-vous à l'interface de ligne de commande {{site.data.keyword.Bluemix_notm}}. A l'invite, entrez vos données d'identification {{site.data.keyword.Bluemix_notm}}.

    ```
    bx login
    ```
    {: pre}

      Pour stipuler une région {{site.data.keyword.Bluemix_notm}} spécifique, incluez son noeud final d'API. Si vous disposez d'images Docker privées stockées dans le registre de conteneurs d'une région {{site.data.keyword.Bluemix_notm}} spécifique, ou des instances de service {{site.data.keyword.Bluemix_notm}} que vous avez déjà créées, connectez-vous à cette région pour accéder à vos images et services {{site.data.keyword.Bluemix_notm}}.

      La région {{site.data.keyword.Bluemix_notm}} à laquelle vous vous connectez détermine également la région où vous pouvez créer vos clusters Kubernetes, y compris les centres de données disponibles. Si vous ne spécifiez pas de région, vous êtes automatiquement connecté à la région la plus proche de vous. 

       -  Sud des Etats-Unis

           ```
           bx login -a api.ng.bluemix.net
           ```
           {: pre}
     
       -  Sydney

           ```
           bx login -a api.au-syd.bluemix.net
           ```
           {: pre}

       -  Allemagne

           ```
           bx login -a api.eu-de.bluemix.net
           ```
           {: pre}

       -  Royaume-Uni

           ```
           bx login -a api.eu-gb.bluemix.net
           ```
           {: pre}

      **Remarque :** si vous possédez un ID fédéré, exécutez la commande `bx login --sso` pour vous connecter à l'interface de ligne de commande {{site.data.keyword.Bluemix_notm}}. Entrez votre nom d'utilisateur et utilisez l'URL mentionnée dans la sortie CLI pour extraire votre code d'accès ponctuel. Si la connexion échoue alors que vous omettez l'option `--sso` et aboutit en incluant l'option `--sso`, ceci indique que votre ID est fédéré.

3.  Si vous êtes affecté à plusieurs comptes, organisations et espaces {{site.data.keyword.Bluemix_notm}}, sélectionnez le compte dans lequel vous désirez créer votre Kubernetes. Les clusters sont spécifiques à un compte et à une organisation, mais sont indépendants de l'espace {{site.data.keyword.Bluemix_notm}}. Par conséquent, si vous avez accès à plusieurs espaces dans votre organisation, vous pouvez sélectionner n'importe lequel dans la liste.
4.  Facultatif : si vous souhaitez créer ou accéder à des clusters Kubernetes dans une région qui n'est pas la région {{site.data.keyword.Bluemix_notm}} sélectionnée plus tôt, spécifiez cette région. Par exemple, vous souhaiterez peut-être vous connecter à une autre région {{site.data.keyword.containershort_notm}} pour les raisons suivantes : 

    -   Vous avez créé des services {{site.data.keyword.Bluemix_notm}} ou des images Docker privées dans une région et vous souhaitez les utiliser avec {{site.data.keyword.containershort_notm}} dans une autre région. 
    -   Vous souhaitez accéder à un cluster dans une région différente de la région {{site.data.keyword.Bluemix_notm}} par défaut à laquelle vous êtes connecté. 
    
    Sélectionnez l'un des noeuds finaux d'API suivants :

    -   Sud des Etats-Unis :

        ```
        bx cs init --host https://us-south.containers.bluemix.net
        ```
        {: pre}

    -   Sud du Royaume-Uni :

        ```
        bx cs init --host https://uk-south.containers.bluemix.net
        ```
        {: pre}

    -   Centre Union Européenne :

        ```
        bx cs init --host https://eu-central.containers.bluemix.net
        ```
        {: pre}

    -   AP-Sud :

        ```
        bx cs init --host https://ap-south.containers.bluemix.net
        ```
        {: pre}
    
6.  Créez un cluster.
    1.  Examinez les emplacements disponibles. Les emplacements affichés dépendent de la région {{site.data.keyword.containershort_notm}} à laquelle vous êtes connecté.


        ```
        bx cs locations
        ```
        {: pre}

        La sortie de votre interface CLI sera similaire à ceci:

        -   Sud des Etats-Unis :

            ```
            dal10
            dal12
            ```
            {: screen}

        -   Sud du Royaume-Uni :

            ```
            lon02
            lon04
            ```
            {: screen}

        -   Centre Union Européenne :

            ```
            ams03
            fra02
            ```
            {: screen}

        -   AP-Sud

            ```
            syd01
            syd02
            ```
            {: screen}

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

    3.  Vérifiez si un réseau virtuel local public et privé existe déjà dans {{site.data.keyword.BluSoftlayer_notm}} pour ce compte.

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

        Si un réseau virtuel public et privé existe déjà, notez les routeurs correspondants. Les routeurs de VLAN privé commencent toujours par `bcr` (routeur dorsal) et les routeurs de VLAN public par `fcr` (routeur frontal). Le numéro et la combinaison de lettres après ces préfixes doivent correspondre pour pouvoir utiliser ces réseaux locaux virtuels lors de la création d'un cluster. Dans l'exemple de sortie, n'importe quel réseau local virtuel privé peut être utilisé avec l'un des réseaux publics virtuels privés vu que les routeurs incluent tous `02a.dal10`.

    4.  Exécutez la commande `cluster-create`. Vous avez le choix entre un cluster léger, qui inclut un noeud d'agent avec 2 UC virtuelles et 4 Go de mémoire, et un cluster standard, lequel peut inclure autant de noeuds d'agent que vous le désirez dans votre compte {{site.data.keyword.BluSoftlayer_notm}}. Lorsque vous créez un cluster standard, le matériel du noeud d'agent est partagé par défaut par plusieurs clients IBM et facturé par heures d'utilisation. </b>Exemple pour un cluster standard :

        ```
        bx cs cluster-create --location dal10; --public-vlan <public_vlan_id> --private-vlan <private_vlan_id> --machine-type u1c.2x4 --workers 3 --name <cluster_name>
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
        <td>Remplacez <em>&lt;location&gt;</em> par l'ID de l'emplacement {{site.data.keyword.Bluemix_notm}} où vous désirez créer votre cluster. Les emplacements disponibles dépendent de la région {{site.data.keyword.containershort_notm}} à laquelle vous vous êtes connecté. Les emplacements disponibles sont les suivants :<ul><li>Sud des Etats-Unis<ul><li>dal10 [Dallas]</li><li>dal12 [Dallas]</li></ul></li><li>Sud du Royaume-Uni<ul><li>lon02 [Londres]</li><li>lon04 [Londres]</li></ul></li><li>Centre Union Européenne<ul><li>ams03 [Amsterdam]</li><li>ra02 [Francfort]</li></ul></li><li>AP-Sud<ul><li>syd01 [Sydney]</li><li>syd04 [Sydney]</li></ul></li></ul></td> 
        </tr>
        <tr>
        <td><code>--machine-type <em>&lt;machine_type&gt;</em></code></td>
        <td>Si vous créez un cluster standard, choisissez un type de machine. Le type de machine spécifie les ressources de traitement virtuelles disponibles pour chaque noeud d'agent. Pour plus d'informations, consultez la rubrique [Comparaison des clusters léger et standard pour {{site.data.keyword.containershort_notm}}](cs_planning.html#cs_planning_cluster_type). Pour les clusters légers, vous n'avez pas besoin de définir le type de machine.</td> 
        </tr>
        <tr>
        <td><code>--public-vlan <em>&lt;public_vlan_id&gt;</em></code></td>
        <td><ul><li>Pour les clusters légers, vous n'avez pas besoin de définir un VLAN public. Votre cluster léger est automatiquement connecté à un VLAN public dont IBM est propriétaire. </li><li>Dans le cas d'un cluster standard, si vous avez déjà un réseau local virtuel public configuré dans votre compte {{site.data.keyword.BluSoftlayer_notm}} pour cet emplacement, entre l'ID de ce VLAN public. Autrement, vous n'avez pas besoin de spécifier cette option puisqu'{{site.data.keyword.containershort_notm}} crée automatiquement un réseau local virtuel public pour vous. <br/><br/><strong>Remarque</strong> : le VLAN public et le VLAN privé que vous spécifiez à l'aide de la commande create doivent correspondre. Les routeurs de VLAN privé commencent toujours par <code>bcr</code> (routeur dorsal) et les routeurs de VLAN public par <code>fcr</code> (routeur frontal). Le numéro et la combinaison de lettres après ces préfixes doivent correspondre pour pouvoir utiliser ces réseaux locaux virtuels lors de la création d'un cluster. N'utilisez pas de réseaux locaux virtuels publics et privés qui ne correspondent pas pour créer un cluster.</li></ul></td> 
        </tr>
        <tr>
        <td><code>--private-vlan <em>&lt;private_vlan_id&gt;</em></code></td>
        <td><ul><li>Pour les clusters légers, vous n'avez pas besoin de définir un VLAN privé. Votre cluster léger est automatiquement connecté à un VLAN privé dont IBM est propriétaire. </li><li>Dans le cas d'un cluster standard, si vous avez déjà un réseau local virtuel privé configuré dans votre compte {{site.data.keyword.BluSoftlayer_notm}} pour cet emplacement, entre l'ID de ce VLAN privé. Autrement, vous n'avez pas besoin de spécifier cette option puisqu'{{site.data.keyword.containershort_notm}} crée automatiquement un réseau local virtuel privé pour vous. <br/><br/><strong>Remarque</strong> : le VLAN public et le VLAN privé que vous spécifiez à l'aide de la commande create doivent correspondre. Les routeurs de VLAN privé commencent toujours par <code>bcr</code> (routeur dorsal) et les routeurs de VLAN public par <code>fcr</code> (routeur frontal). Le numéro et la combinaison de lettres après ces préfixes doivent correspondre pour pouvoir utiliser ces réseaux locaux virtuels lors de la création d'un cluster. N'utilisez pas de réseaux locaux virtuels publics et privés qui ne correspondent pas pour créer un cluster.</li></ul></td> 
        </tr>
        <tr>
        <td><code>--name <em>&lt;nom&gt;</em></code></td>
        <td>Remplacez <em>&lt;name&gt;</em> par le nom de votre cluster.</td> 
        </tr>
        <tr>
        <td><code>--workers <em>&lt;nombre&gt;</em></code></td>
        <td>Nombre de noeuds d'agent à inclure dans le cluster. Si l'option <code>--workers</code> n'est pas spécifiée, 1 noeud d'agent est créé.</td> 
        </tr>
        </tbody></table>

7.  Vérifiez que la création du cluster a été demandée.

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

8.  Vérifiez le statut des noeuds d'agent.

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

9. Définissez le cluster que vous avez créé comme contexte de cette session. Effectuez ces étapes de configuration à chaque fois que vous utilisez votre cluster.
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

10. Lancez le tableau de bord Kubernetes via le port par défaut (8001).
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

    **Remarque :** si vous possédez un ID fédéré, exécutez la commande `bx login --sso` pour vous connecter à l'interface de ligne de commande {{site.data.keyword.Bluemix_notm}}. Entrez votre nom d'utilisateur et utilisez l'URL mentionnée dans la sortie CLI pour extraire votre code d'accès ponctuel. Si la connexion échoue alors que vous omettez l'option `--sso` et aboutit en incluant l'option `--sso`, ceci indique que votre ID est fédéré.

3.  Créez un cluster avec la commande `cluster-create`. Lorsque vous créez un cluster standard, le matériel du noeud d'agent est facturé par heures d'utilisation.

    Exemple

    ```
    bx cs cluster-create --machine-type <machine-type> --workers <number> --name <cluster_name>
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
    <td><code>--location <em>&lt;emplacement&gt;</em></code></td>
    <td>Remplacez &lt;location&gt; par l'ID de l'emplacement {{site.data.keyword.Bluemix_notm}} où vous désirez créer votre cluster. Les emplacements disponibles dépendent de la région {{site.data.keyword.containershort_notm}} à laquelle vous vous êtes connecté. Les emplacements disponibles sont les suivants :<ul><li>Sud des Etats-Unis<ul><li>dal10 [Dallas]</li><li>dal12 [Dallas]</li></ul></li><li>Sud du Royaume-Uni<ul><li>lon02 [Londres]</li><li>lon04 [Londres]</li></ul></li><li>Centre Union Européenne<ul><li>ams03 [Amsterdam]</li><li>ra02 [Francfort]</li></ul></li><li>AP-Sud<ul><li>syd01 [Sydney]</li><li>syd04 [Sydney]</li></ul></li></ul></td> 
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

    Lorsque la mise à disposition de votre cluster est finalisée, le statut du cluster passe à **deployed**. 

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

-   [Configurez un espace de nom dans {{site.data.keyword.registryshort_notm}} sur {{site.data.keyword.Bluemix_notm}} Public ou {{site.data.keyword.Bluemix_notm}} Dedicated et transférez par commande push des images dans cet espace de nom](/docs/services/Registry/registry_setup_cli_namespace.html#registry_namespace_add).
-   [Créez un cluster](#cs_cluster_cli).
-   [Ciblez avec votre interface CLI votre cluster](cs_cli_install.html#cs_cli_configure).

Lorsque vous créez un cluster, un jeton de registre sans expiration est créé automatiquement pour le cluster. Ce jeton est utilisé pour octroyer un accès en lecture seule à n'importe lequel de vos espaces de nom configurés dans {{site.data.keyword.registryshort_notm}}, de sorte que vous pouvez utiliser aussi bien les images fournies par IBM que vos propres images
Docker privées. Les jetons doivent être stockés dans un élément Kubernetes `imagePullSecret` pour être accessibles à un cluster Kubernetes lorsque vous déployez une application conteneurisée. Lorsque votre cluster est créé, {{site.data.keyword.containershort_notm}} stocke automatiquement ce jeton dans un élément Kubernetes `imagePullSecret`. L'élément `imagePullSecret` est ajouté à l'espace de nom
Kubernetes par défaut, à la liste par défaut des valeurs confidentielles dans l'élément ServiceAccount de cet espace de nom, et à l'espace de nom kube-system.

**Remarque :** avec cette configuration initiale, vous pouvez déployer des conteneurs depuis n'importe quelle image disponible dans un espace de nom dans votre compte {{site.data.keyword.Bluemix_notm}} vers l'espace de nom nommé **default** de votre cluster. Si vous désirez déployer un conteneur dans d'autres espaces de nom de votre cluster,  ou utiliser une image stockée dans une autre région {{site.data.keyword.Bluemix_notm}},  ou dans un autre compte {{site.data.keyword.Bluemix_notm}}, vous devez [créer votre propre élément imagePullSecret pour votre cluster](#bx_registry_other).

Pour déployer un conteneur dans l'espace de nom **default** de votre cluster, créez un script de configuration de déploiement. 

1.  Ouvrez l'éditeur de votre choix et créez un script de configuration de déploiement nommé, par exemple, <em>mydeployment.yaml</em>.
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

    **Astuce :** vous pouvez également déployer un script de configuration existant, tel que l'une des images publiques fournies par IBM. Cet exemple utilise l'image **ibmliberty** dans la région Sud des Etats-Unis. 

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

**Remarque :** les valeurs ImagePullSecret ne sont valides que pour les espaces de nom Kubernetes pour lesquels elles ont été créées. Répétez ces étapes pour chaque espace de nom dans lequel vous désirez déployer des conteneurs depuis une image privée.

1.  Si vous ne possédez pas encore de jeton, [créez un jeton pour le registre auquel vous souhaitez accéder. ](/docs/services/Registry/registry_tokens.html#registry_tokens_create)
2.  Répertoriez les jetons disponibles dans votre compte {{site.data.keyword.Bluemix_notm}}.

    ```
    bx cr token-list
    ```
    {: pre}

3.  Notez l'ID du jeton que vous désirez utiliser. 
4.  Extrayez la valeur de ce jeton. Remplacez <token_id> par l'ID du jeton que vous avez extrait à l'étape précédente.

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
    <td>Obligatoire. URL du registre d'images où votre espace de nom est configuré.<ul><li>Pour les espaces de nom définis au Sud des Etats-Unis : registry.ng.bluemix.net</li><li>Pour les espaces de nom définis au Sud du Royaume-Uni : registry.eu-gb.bluemix.net</li><li>Pour les espaces de nom définis au Centre de l'Union Européenne (Francfort) : registry.eu-de.bluemix.net</li><li>Pour les espaces de nom définis en Australie (Sydney) : registry.au-syd.bluemix.net</li><li>Pour les espaces de nom définis dans le registre {{site.data.keyword.Bluemix_notm}} Dedicated : <em>&lt;dedicated_domain&gt;</em></li></ul></td> 
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

6.  Vérifiez que la création de la valeur confidentielle a abouti. Remplacez <em>&lt;kubernetes_namespace&gt;</em> par le nom de l'espace de nom sur lequel vous avez créé l'élément imagePullSecret.

    ```
    kubectl get secrets --namespace <kubernetes_namespace>
    ```
    {: pre}

7.  Créez une nacelle référençant l'élément imagePullSecret.
    1.  Ouvrez l'éditeur de votre choix et créez un script de configuration de nacelle nommé, par exemple, mypod.yaml. 
    2.  Définissez la nacelle et l'élément imagePullSecret que vous désirez utiliser pour accéder au registre {{site.data.keyword.Bluemix_notm}} privé. Pour utiliser une image privée d'un espace de nom :

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
        <td><code><em>&lt;secret_name&gt;</em></code></td>
        <td>Espace de nom sous lequel votre image est stockée. Pour répertorier les espaces de nom disponibles, exécutez la commande `bx cr namespace-list`.</td> 
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

Vous pouvez utiliser n'importe quelle image publique stockée dans Docker Hub pour déployer sans configuration supplémentaire un conteneur dans votre cluster. Créez ou déployez un fichier script de configuration de déploiement. 

Avant de commencer :

1.  [Créez un cluster](#cs_cluster_cli).
2.  [Ciblez avec votre interface CLI votre cluster](cs_cli_install.html#cs_cli_configure).

Créez un script de configuration de déploiement.

1.  Ouvrez l'éditeur de votre choix et créez un script de configuration de déploiement nommé, par exemple, mydeployment.yaml. 
2.  Définissez le déploiement et l'image Docker Hub publique que vous désirez utiliser. Le script de configuration suivant utilise l'image NGINX publique disponible dans Docker Hub.



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

    **Astuce :** vous pouvez aussi déployer un script de configuration existant. L'exemple suivant utilise la même image NGINX publique, mais l'applique directement à votre cluster.

    ```
    kubectl apply -f https://raw.githubusercontent.com/IBM-{{site.data.keyword.Bluemix_notm}}/kube-samples/master/deploy-apps-clusters/deploy-nginx.yaml
    ```
    {: pre}


### Accès à des images privées stockées dans d'autres registres privés
{: #private_registry}

Si vous disposez déjà d'un registre privé que vous désirez utiliser, vous devez stocker les données d'identification du registre dans un élément Kubernetes imagePullSecret et référencer cette valeur confidentielle dans votre script de configuration.

Avant de commencer :

1.  [Créez un cluster](#cs_cluster_cli).
2.  [Ciblez avec votre interface CLI votre cluster](cs_cli_install.html#cs_cli_configure).

Pour créer un élément imagePullSecret, procédez comme suit.

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

3.  Créez une nacelle référençant l'élément imagePullSecret.
    1.  Ouvrez l'éditeur de votre choix et créez un script de configuration de nacelle nommé, par exemple, mypod.yaml. 
    2.  Définissez la nacelle et l'élément imagePullSecret que vous désirez utiliser pour accéder au registre {{site.data.keyword.Bluemix_notm}} privé. Pour utiliser une image privée de votre registre privé :

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
        <td>Nom de la nacelle que vous désirez créer.</td> 
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


## Ajout de services {{site.data.keyword.Bluemix_notm}} à des clusters
{: #cs_cluster_service}

Ajoutez une instance de service {{site.data.keyword.Bluemix_notm}} existante à votre cluster pour permettre aux utilisateurs du cluster d'accéder et d'utiliser le service {{site.data.keyword.Bluemix_notm}} lorsqu'ils déploient une application dans le cluster.
{:shortdesc}

Avant de commencer :

-   [Ciblez votre interface de ligne de commande](cs_cli_install.html#cs_cli_configure) vers votre cluster.
-   [Demandez une instance du service {{site.data.keyword.Bluemix_notm}} ](/docs/services/reqnsi.html#req_instance) dans votre espace pour l'ajouter à votre cluster.
-   Dans le cas d'utilisateurs de {{site.data.keyword.Bluemix_notm}} Dedicated, voir à la place la rubrique [Ajout de services {{site.data.keyword.Bluemix_notm}} à des clusters dans {{site.data.keyword.Bluemix_notm}} Dedicated (version bêta fermée)](#binding_dedicated). 

**Remarque :** vous pouvez uniquement ajouter des services {{site.data.keyword.Bluemix_notm}} prenant en charge des clés de service (faites défiler l'écran jusqu'à la section [Activation d'application externes pour l'utilisation de services {{site.data.keyword.Bluemix_notm}}](/docs/services/reqnsi.html#req_instance)).

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


Pour utiliser le service dans une nacelle qui est déployée dans le cluster, les utilisateurs du cluster peuvent accéder aux données d'identification du service {{site.data.keyword.Bluemix_notm}} en [montant la valeur confidentielle Kubernetes en tant que volume secret sur une nacelle.](cs_apps.html#cs_apps_service)

### Ajout de services {{site.data.keyword.Bluemix_notm}} à des clusters dans {{site.data.keyword.Bluemix_notm}} Dedicated (version bêta fermée)
{: #binding_dedicated}

Avant de commencer, [demandez une instance du service {{site.data.keyword.Bluemix_notm}} ](/docs/services/reqnsi.html#req_instance) dans votre espace pour l'ajouter à votre cluster. 

1.  Connectez-vous à l'environnement {{site.data.keyword.Bluemix_notm}} Dedicated où l'instance de service a été créée.

    ```
    bx login -a api.<dedicated_domain>
    ```
    {: pre}

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

3.  Créez une clé de données d'identification du service contenant les informations confidentielles sur le service, telles que le nom d'utilisateur, le mot de passe et l'URL.

    ```
    bx service key-create <service_name> <service_key_name>
    ```
    {: pre}

4.  Utilisez les données d'identification du service pour créer sur votre ordinateur un fichier JSON contenant les informations confidentielles sur le service.

    ```
    bx service key-show <service_name> <service_key_name>| sed -n '/{/,/}/'p >> /filepath/<dedicated-service-key>.json
    ```
    {: pre}

5.  Connectez-vous au noeud final public d'{{site.data.keyword.containershort_notm}} et pointez votre interface CLI sur le cluster dans votre environnement {{site.data.keyword.Bluemix_notm}} Dedicated.
    1.  Connectez-vous au compte à l'aide du noeud final public {{site.data.keyword.containershort_notm}}. Entrez vos données d'identification {{site.data.keyword.Bluemix_notm}} et, à l'invite, sélectionnez le compte {{site.data.keyword.Bluemix_notm}} Dedicated. 

        ```
        bx login -a api.ng.bluemix.net
        ```
        {: pre}

        **Remarque :** si vous possédez un ID fédéré, exécutez la commande `bx login --sso` pour vous connecter à l'interface de ligne de commande {{site.data.keyword.Bluemix_notm}}. Entrez votre nom d'utilisateur et utilisez l'URL mentionnée dans la sortie CLI pour extraire votre code d'accès ponctuel. Si la connexion échoue alors que vous omettez l'option `--sso` et aboutit en incluant l'option `--sso`, ceci indique que votre ID est fédéré.

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
6.  Créez une valeur confidentielle Kubernetes depuis le fichier JSON de données d'identification du service.

    ```
    kubectl create secret generic <secret_name> --from-file=/filepath/<dedicated-service-key>.json
    ```
    {: pre}

7.  Répétez ces étapes pour chaque service {{site.data.keyword.Bluemix_notm}} que vous désirez utiliser.

Le service {{site.data.keyword.Bluemix_notm}} est lié au
cluster et peut être utilisé par toutes les nacelles déployées dans ce cluster. Pour utiliser le
service dans une nacelle, les utilisateurs du cluster peuvent [monter
la valeur confidentielle Kubernetes en tant que volume secret sur la nacelle](cs_apps.html#cs_apps_service) pour accéder aux données d'identification du service
{{site.data.keyword.Bluemix_notm}}.


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

    Chaque utilisateur auquel est affectée une règle d'accès {{site.data.keyword.containershort_notm}} se voir automatiquement affecter un rôle RBAC. Les rôles RBAC déterminent les actions que vous pouvez effectuer sur des ressources Kubernetes au sein du cluster. Les rôles RBAC ne sont configurés que pour l'espace de nom par défaut. L'administrateur du cluster peut ajouter des rôles RBAC pour d'autres espaces de nom dans le cluster. Pour plus d'informations, voir[Using RBAC Authorization ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/admin/authorization/rbac/#api-overview) dans la documentation Kubernetes. 


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
|<ul><li>Rôle : Administrateur</li><li>Instances de service : toutes les instances de service actuelles</li></ul>|<ul><li>Créer un cluster léger ou standard</li><li>Définir des données d'identification pour un compte {{site.data.keyword.Bluemix_notm}} afin d'accéder au portefeuille {{site.data.keyword.BluSoftlayer_notm}}</li><li>Supprimer un cluster</li><li>Affecter et modifier des règles d'accès {{site.data.keyword.containershort_notm}} pour d'autres utilisateurs existants dans ce compte.</li></ul><br/>Ce rôle hérite des autorisations des rôles Editeur, Opérateur et Visualiseur dans tous les clusters du compte.|<ul><li>Rôle RBAC : cluster-admin</li><li>Accès en lecture/écriture aux ressources dans tous les espaces de nom</li><li>Créer des rôles au sein d'un espace de nom</li></ul>|
|<ul><li>Rôle : Administrateur</li><li>Instances de service : ID de cluster spécifique</li></ul>|<ul><li>Retirer un cluster spécifique. </li></ul><br/>Ce rôle hérite des autorisations des rôles Editeur, Opérateur et Visualiseur dans le cluster sélectionné.|<ul><li>Rôle RBAC : cluster-admin</li><li>Accès en lecture/écriture aux ressources dans tous les espaces de nom</li><li>Créer des rôles au sein d'un espace de nom</li><li>Accès au tableau de bord Kubernetes</li></ul>|
|<ul><li>Rôle : Opérateur</li><li>Instances de service : toutes les instances de service actuelles / ID de cluster spécifique</li></ul>|<ul><li>Ajouter des noeuds d'agent supplémentaires à un cluster</li><li>Supprimer des noeuds d'agent d'un cluster</li><li>Réamorcer un noeud d'agent</li><li>Recharger un noeud d'agent</li><li>Ajouter un sous-réseau à un cluster</li></ul>|<ul><li>Rôle RBAC : admin</li><li>Accès en lecture/écriture aux ressources dans l'espace de nom par défaut, mais non pas à l'espace de nom lui-même</li><li>Créer des rôles au sein d'un espace de nom</li></ul>|
|<ul><li>Rôle : Editeur</li><li>Instances de service : toutes les instances de service actuelles/ID de cluster spécifique</li></ul>|<ul><li>Lier un service {{site.data.keyword.Bluemix_notm}} à un cluster.</li><li>Annuler la liaison d'un service {{site.data.keyword.Bluemix_notm}} à un cluster.</li><li>Créer un webhook.</li></ul><br/>Utilisez ce rôle pour vos développeurs d'applications.|<ul><li>Rôle RBAC : edit</li><li>Accès en lecture/écriture aux ressources dans l'espace de nom par défaut</li></ul>|
|<ul><li>Rôle : Visualiseur</li><li>Instances de service : toutes les instances de service actuelles / ID de cluster spécifique</li></ul>|<ul><li>Lister un cluster</li><li>Afficher les détails d'un cluster</li></ul>|<ul><li>Rôle RBAC : view</li><li>Accès en lecture aux ressources dans l'espace de nom par défaut</li><li>Pas d'accès en lecture aux valeurs confidentielles Kubernetes</li></ul>|
|<ul><li>Rôle dans l'organisation Cloud Foundry : Gestionnaire</li></ul>|<ul><li>Ajouter des utilisateurs supplémentaires dans un compte {{site.data.keyword.Bluemix_notm}}</li></ul>||
|<ul><li>Rôle dans l'espace Cloud Foundry : Développeur</li></ul>|<ul><li>Créer des instances de service {{site.data.keyword.Bluemix_notm}}</li><li>Lier des instances de service {{site.data.keyword.Bluemix_notm}} à des clusters</li></ul>||
{: caption="Tableau 7. Présentation des règles et autorisations d'accès IBM Bluemix Container Service obligatoires" caption-side="top"}

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
6.  Dans la liste déroulante **Rôles**, sélectionnez la règle d'accès que vous souhaitez affecter. La sélection d'un rôle sans le limiter à une région ou à un cluster spécifique applique automatiquement cette règle d'accès à tous les clusters qui ont été créés dans ce compte. Si vous désirez limiter l'accès à un cluster ou à une région spécifique, sélectionnez-les dans la liste déroulante **Instance de service** et **Région**. Pour consulter la liste des actions prises en charge pour chaque règle d'accès, voir [Présentation des règles et autorisations d'accès {{site.data.keyword.containershort_notm}} obligatoires](#access_ov). Pour identifier l'ID d'un cluster spécifique, exécutez la commande `bx cs clusters`.
7.  Cliquez sur **Affecter une règle** pour sauvegarder vos modifications.

### Ajout d'utilisateurs à un compte {{site.data.keyword.Bluemix_notm}}
{: #add_users}

Vous pouvez ajouter des utilisateurs supplémentaires à un compte {{site.data.keyword.Bluemix_notm}} pour leur accorder un accès à vos clusters.

Avant de commencer, vérifiez que vous avez bien été affecté au rôle Gestionnaire Cloud Foundry pour un compte {{site.data.keyword.Bluemix_notm}}.

1.  Sélectionnez le compte {{site.data.keyword.Bluemix_notm}} dans lequel vous désirez ajouter des utilisateurs.
2.  Dans la barre de menus, cliquez sur **Gérer** > **Sécurité** > **Identité et accès**. La fenêtre Utilisateurs affiche une liste des utilisateurs avec leurs adresses électroniques et leur statut actuel pour le compte sélectionné.
3.  Cliquez sur **Inviter des utilisateurs**.
4.  Dans **Adresse électronique ou IBMid existant**, entrez l'adresse électronique de l'utilisateur que vous désirez ajouter au compte {{site.data.keyword.Bluemix_notm}}.
5.  Dans la section **Accès** section, développez l'entrée **Services avec l'offre Identity and Access activée**.
6.  Dans la liste déroulante **Services**, sélectionnez **{{site.data.keyword.containershort_notm}}**.
7.  Dans la liste déroulante **Rôles**, sélectionnez la règle d'accès que vous désirez affecter. La sélection d'un rôle sans le limiter à une région ou à un cluster spécifique applique automatiquement cette règle d'accès à tous les clusters qui ont été créés dans ce compte. Si vous désirez limiter l'accès à un cluster ou à une région spécifique, sélectionnez-les dans la liste déroulante **Instance de service** et **Région**. Pour consulter la liste des actions prises en charge pour chaque règle d'accès, voir [Présentation des règles et autorisations d'accès {{site.data.keyword.containershort_notm}} obligatoires](#access_ov). Pour identifier l'ID d'un cluster spécifique, exécutez la commande `bx cs clusters`.
8.  Développez la section **Accès Cloud Foundry** et sélectionnez l'organisation {{site.data.keyword.Bluemix_notm}} à laquelle vous désirez ajouter l'utilisateur dans la liste déroulante **Organisation**.
9.  Dans la liste déroulante **Rôles d'espace**, sélectionnez les rôles de votre choix. Les clusters Kubernetes sont indépendants des espaces {{site.data.keyword.Bluemix_notm}}. Pour autoriser cet utilisateur à ajouter des utilisateurs supplémentaires à un compte {{site.data.keyword.Bluemix_notm}}, vous devez l'affecter à un **Rôle d'organisation** Cloud Foundry. Toutefois, vous ne pourrez affecter des rôles d'organisation Cloud Foundry qu'à une étape ultérieure.
10. Cliquez sur **Inviter des utilisateurs**.
11. Facultatif : dans le panneau **Utilisateurs** de l'onglet **Actions**, sélectionnez **Gérer un utilisateur**.
12. Facultatif : dans la section **Rôles Cloud Foundry**, recherchez le rôle d'organisation Cloud Foundry attribué à l'utilisateur que vous avez ajouté aux étapes précédentes.
13. Facultatif : dans l'onglet **Actions**, sélectionnez **Editer le rôle d'organisation**.
14. Facultatif : dans la liste déroulante **Rôles d'organisation**, sélectionnez **Gestionnaire**. 
15. Facultatif : cliquez sur **Sauvegarder le rôle**. 

## Ajout de sous-réseaux à des clusters
{: #cs_cluster_subnet}

Vous pouvez modifier le pool d'adresses IP portables publiques disponibles en ajoutant des sous-réseaux à votre
cluster.
{:shortdesc}

Dans {{site.data.keyword.containershort_notm}}, vous pouvez ajouter des adresses IP portables stables pour les services Kubernetes en adjoignant des sous-réseaux au cluster. Lorsque vous créez un cluster standard,
{{site.data.keyword.containershort_notm}} lui alloue automatiquement un sous-réseau public portable et 5 adresses IP. Les adresses IP publiques portables sont statiques et ne changent pas lorsqu'un noeud d'agent, ou même le cluster, est retiré.

L'une des adresses IP publiques portables est utilisée pour le [contrôleur Ingress](cs_apps.html#cs_apps_public_ingress) que vous pouvez utiliser afin d'exposer plusieurs applications dans votre cluster via une route publique. Les 4 adresses IP publiques portables restantes peuvent être utilisées pour exposer au public des applications distinctes en [créant un service d'équilibrage de charge](cs_apps.html#cs_apps_public_load_balancer).

**Remarque :** les adresses IP publiques portables sont facturées sur une base mensuelle. Si vous décidez de retirer les adresses IP portables après la mise en place de votre cluster, vous devez quand même payer les frais mensuels, même si vous ne les avez utilisées que brièvement.

### Demande de sous-réseaux supplémentaires pour votre cluster
{: #add_subnet}

Vous pouvez ajouter des adresses IP publiques portables stables au cluster en lui affectant des sous-réseaux.

Dans le cas d'utilisateurs de {{site.data.keyword.Bluemix_notm}} Dedicated, au lieu d'exécuter cette tâche, vous devez [ouvrir un ticket de demande de service](/docs/support/index.html#contacting-support) pour créer le sous-réseau, puis utiliser la commande [`bx cs cluster-subnet-add`](cs_cli_reference.html#cs_cluster_subnet_add) pour l'ajouter au cluster.

Avant de commencer, vérifiez que vous pouvez accéder au portefeuille {{site.data.keyword.BluSoftlayer_notm}} depuis l'interface graphique {{site.data.keyword.Bluemix_notm}}. Pour accéder au portefeuille, vous devez configurer ou utiliser un compte {{site.data.keyword.Bluemix_notm}} de type Paiement à la carte existant.

1.  Dans la section **Infrastructure** du catalogue, sélectionnez **Réseau**.
2.  Sélectionnez **Sous-réseau/IP** et cliquez sur **Créer**.
3.  Dans le menu déroulant **Sélectionner le type de sous-réseau à ajouter à ce compte**, sélectionnez **Public portable**.
4.  Sélectionnez le nombre d'adresses IP que vous désirez ajouter à votre sous-réseau portable.

    **Remarque :** lorsque vous ajoutez des adresses IP publiques portables à votre sous-réseau, 3 adresses IP sont utilisées pour l'opération réseau interne au cluster, de sorte que vous ne pouvez pas les utiliser pour votre contrôleur Ingress ou pour créer un service d'équilibrage de charge. Par exemple, si vous demandez 8 adresses IP publiques portables, vous pouvez en utiliser 5 pour exposer vos applications au public.

5.  Sélectionnez le réseau local virtuel public vers lequel adresser les adresses IP publiques portables. Vous devez sélectionner le réseau local virtuel public auquel un noeud d'agent existant est connecté. Identifiez le réseau local virtuel public d'un noeud d'agent.

    ```
    bx cs worker-get <worker_id>
    ```
    {: pre}

6.  Renseignez le questionnaire et cliquez sur **Passer une commande**.

    **Remarque :** les adresses IP publiques portables sont facturées sur une base mensuelle. Si vous décidez de supprimer des adresses IP publiques portables après les avoir créées, les frais pour le mois en cours vous seront néanmoins facturés, même si vous ne les avez utilisés qu'une partie du mois.
<!-- removed conref to test bx login -->
7.  Une fois le sous-réseau provisionné, rendez-le disponible pour votre cluster Kubernetes.
    1.  Dans le tableau de bord Infrastructure, sélectionnez le sous-réseau que vous avez créé et notez son ID.
    2.  Connectez-vous à l'interface de ligne de commande {{site.data.keyword.Bluemix_notm}}. 

        ```
        bx login
        ```
        {: pre}

        Pour stipuler une région {{site.data.keyword.Bluemix_notm}} spécifique, choisissez l'un des noeuds finaux d'API suivants :


       -  Sud des Etats-Unis

           ```
           bx login -a api.ng.bluemix.net
           ```
           {: pre}
     
       -  Sydney

           ```
           bx login -a api.au-syd.bluemix.net
           ```
           {: pre}

       -  Allemagne

           ```
           bx login -a api.eu-de.bluemix.net
           ```
           {: pre}

       -  Royaume-Uni

           ```
           bx login -a api.eu-gb.bluemix.net
           ```
           {: pre}

    3.  Recensez tous les clusters de votre compte et notez l'ID du cluster sur lequel vous désirez rendre disponible le sous-réseau.

        ```
        bx cs clusters
        ```
        {: pre}

    4.  Ajoutez le sous-réseau à votre cluster. Lorsque vous rendez disponible un sous-réseau pour un cluster, une mappe de configuration Kubernetes est créée pour vous et inclut toutes les adresse IP publiques portables disponibles que vous pouvez utiliser. Si aucun contrôleur Ingress n'existe pour votre cluster, une adresse IP publique portable est automatiquement utilisée pour créer le contrôleur Ingress. Toutes les autres peuvent être utilisées pour créer des services d'équilibrage de charge pour vos applications.

        ```
        bx cs cluster-subnet-add <cluster name or id> <subnet id>
        ```
        {: pre}

8.  Vérifiez que l'ajout du sous-réseau à votre cluster a abouti. L'ID de cluster est indiqué dans la colonne **Bound Cluster** (Cluster lié).

    ```
    bx cs subnets
    ```
    {: pre}

### Ajout de sous-réseaux personnalisés et existants à des clusters Kubernetes
{: #custom_subnet}

Vous pouvez ajouter des sous-réseaux publics portables existants à votre cluster Kubernetes.

Avant de commencer, [ciblez avec votre interface de ligne de commande](cs_cli_install.html#cs_cli_configure) votre cluster. 

Si vous disposez d'un sous-réseau existant dans votre portefeuille {{site.data.keyword.BluSoftlayer_notm}} avec des règles de pare-feu personnalisées ou des adresses IP disponibles que vous désirez utiliser, créez un cluster sans sous-réseau et rendez votre sous-réseau existant disponible au cluster lors de la mise à disposition du cluster.

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

6.  Ajoutez le sous-réseau à votre cluster en spécifiant l'ID du sous-réseau. Lorsque vous rendez disponible un sous-réseau pour un cluster, une mappe de configuration Kubernetes est créée pour vous et inclut toutes les adresse IP publiques portables disponibles que vous pouvez utiliser. Si aucun contrôleur Ingress n'existe encore pour votre cluster, une adresse IP publique portable est automatiquement utilisée pour créer le contrôleur Ingress. Toutes les autres peuvent être utilisées pour créer des services d'équilibrage de charge pour vos applications.

    ```
    bx cs cluster-subnet-add mycluster 807861
    ```
    {: pre}


## Utilisation de partages de fichiers NFS existants dans des clusters
{: #cs_cluster_volume_create}

Si vous disposez déjà de partages de fichiers NFS existants dans votre compte {{site.data.keyword.BluSoftlayer_notm}} et désirez les utiliser avec
Kubernetes, créez alors des volumes persistants sur votre partage de fichiers NFS existant. Un volume persistant
est un élément matériel réel qui fait office de ressource de cluster Kubernetes et peut être consommé par l'utilisateur du cluster.
{:shortdesc}

Avant de commencer, vérifiez que vous disposez d'un partage de fichiers NFS existant que vous pouvez utiliser pour créer votre
volume persistant.

[![Créer des volumes persistants et des réservations de volumes persistants](images/cs_cluster_pv_pvc.png)](https://console.bluemix.net/docs/api/content/containers/images/cs_cluster_pv_pvc.png)

Kubernetes fait une distinction entre les volumes persistants qui représentent le matériel effectif et les réservations de volume persistant qui sont des demandes de stockage déclenchées habituellement par l'utilisateur du cluster. Si vous désirez permettre
l'utilisation de partage de fichiers NLS existants avec Kubernetes, vous devez créer des volumes persistants
d'une certaine taille et avec un mode d'accès déterminé, qui soient conformes à la spécification de
volume persistant. Si le volume persistant et la réservation de volume persistant correspondent, ils sont liés l'un à l'autre. Seules les réservations de volume persistant liées peuvent être utilisées par l'utilisateur du cluster pour monter le
volume sur une nacelle. Cette procédure est dénommée provisionnement statique de stockage persistant.

**Remarque :** le provisionnement statique de stockage persistant ne s'applique qu'aux partages de fichier NFS existants. Si vous ne disposez pas de partages de fichiers
NFS existants, les utilisateurs du cluster peuvent utiliser la procédure de [provisionnement dynamique](cs_apps.html#cs_apps_volume_claim) pour ajouter des volumes persistants.

Pour créer un volume persistant et une réservation correspondante, procédez comme suit.

1.  Dans votre compte {{site.data.keyword.BluSoftlayer_notm}}, recherchez l'ID et le chemin du partage NFS où vous désirez créer votre objet de volume persistant.
    1.  Connectez-vous à votre compte {{site.data.keyword.BluSoftlayer_notm}}.
    2.  Cliquez sur **Stockage**.
    3.  Cliquez sur **Stockage de fichiers** et notez l'ID et le chemin du partage de fichiers NFS que vous désirez utiliser.
2.  Ouvrez l'éditeur de votre choix.
3.  Créez un script de configuration de stockage pour votre volume persistant.

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
    <td>Les modes d'accès définissent la manière dont une réservation de volume persistant peut être montée sur un noeud d'agent.<ul><li>ReadWriteOnce (RWO) : le volume persistant ne peut être monté sur des nacelles que dans un noeud d'agent unique. Les nacelles montées sur ce volume persistant peuvent lire et écrire sur le volume.</li><li>ReadOnlyMany (ROX) : le volume persistant peut être monté sur des nacelles hébergées sur plusieurs noeuds d'agent. Les nacelles montées sur ce volume persistant peuvent uniquement lire les données du volume.</li><li>ReadWriteMany (RWX) : le volume persistant peut être monté sur des nacelles hébergées sur plusieurs noeuds d'agent. Les nacelles montées sur ce volume persistant peuvent lire et écrire sur le volume.</li></ul></td> 
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

6.  Créez un autre script de configuration pour créer votre réservation de volume persistant. Pour que la réservation de volume persistant corresponde à l'objet de volume persistant créé auparavant, vous devez sélectionner la même valeur pour `storage` et pour `accessMode`. La zone `storage-class` doit être vide. Si l'une de ces zones ne correspond pas au volume persistant, un nouveau volume persistant est créé automatiquement à la place.

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
persistant. Les utilisateurs du cluster peuvent à présent [monter la réservation de volume persistant](cs_apps.html#cs_apps_volume_mount) sur leur nacelle et lancer une lecture et écriture sur l'objet de volume persistant.

## Visualisation de ressources de cluster Kubernetes
{: #cs_weavescope}

Weave Scope produit un diagramme visuel de vos ressources dans un cluster Kubernetes,
notamment des services, nacelles, conteneurs, processus, noeuds, et autres. Weave Scope fournit des métriques interactives
sur l'utilisation de l'UC et de la mémoire, ainsi que des outils pour suivi et exécution dans un conteneur. {:shortdesc}

Avant de commencer :

-   Prenez soin de ne pas exposer les informations de votre cluster sur l'Internet public. Procédez comme suit pour déployer de manière sécurisée Weave Scope et y accéder en local depuis un navigateur Web.
-   Si ne n'est déjà fait, [créez un cluster standard](#cs_cluster_ui). Weave Scope peut imposer une charge lourde sur l'UC, particulièrement pour les applications. Utilisez Weave Scope avec des clusters standard plus volumineux, et non pas avec des clusters légers.
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

## Suppression de clusters
{: #cs_cluster_remove}

Lorsque vous avez fini d'utiliser un cluster, vous pouvez le supprimer afin qu'il ne consomme plus de ressources.
{:shortdesc}

Les clusters léger et standard créés avec un compte {{site.data.keyword.Bluemix_notm}} standard ou de type Paiement à la carte doivent être supprimés manuellement par l'utilisateur lorsque celui-ci n'en a plus besoin. Les clusters légers créés avec un compte d'essai gratuit sont automatiquement supprimés à l'expiration de la période d'évaluation gratuite.

Lorsque vous supprimez un cluster, vous supprimez également les ressources sur le cluster, notamment les conteneurs, les nacelles, les services liés et les valeurs confidentielles. Si vous ne supprimez pas l'espace de stockage lorsque vous supprimez votre cluster, vous pouvez le supprimer via le tableau de bord {{site.data.keyword.BluSoftlayer_notm}} dans l'interface graphique de {{site.data.keyword.Bluemix_notm}}. En raison du cycle de facturation mensuel, une réservation de volume persistant ne peut pas être supprimée le dernier jour du mois. Si vous supprimez la réservation de volume persistant le dernier jour du mois, la suppression reste en attente jusqu'au début du mois suivant.

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

Lorsque vous supprimez un cluster, les sous réseaux portables publics et privés ne sont pas supprimés automatiquement. Les sous-réseaux sont utilisés pour affecter des adresses IP portables publiques aux services d'équilibrage de charge ou à votre contrôleur Ingress. Vous pouvez supprimer manuellement ces sous-réseaux ou les réutiliser dans un nouveau cluster.

