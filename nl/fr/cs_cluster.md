---

copyright:
  years: 2014, 2017
lastupdated: "2017-12-14"

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

Le diagramme suivant inclut des configurations de cluster communes avec une augmentation de disponibilité.

![Niveaux de haute disponibilité pour un cluster](images/cs_cluster_ha_roadmap.png)

Comme illustré dans le diagramme, le déploiement de vos applications dans plusieurs noeuds d'agent rend vos applications hautement disponibles. Le déploiement de vos applications dans plusieurs clusters les rend encore plus disponibles. Pour obtenir la disponibilité la plus élevée, déployez vos applications dans des clusters dans différentes régions. [Pour plus d'informations, revoyez les options pour les configurations de cluster à haute disponibilité.](cs_planning.html#cs_planning_cluster_config)

<br />


## Création de clusters depuis l'interface graphique
{: #cs_cluster_ui}

Un cluster Kubernetes est un ensemble de noeuds d'agent organisés dans un réseau. L'objet de ce cluster est de définir un ensemble de ressources, de noeuds, de réseaux et de périphériques de stockage permettant d'assurer une haute disponibilité des applications. Avant de pouvoir déployer une application, vous devez créer un cluster et spécifier les définitions des noeuds d'agent dans ce cluster.
{:shortdesc}

Pour créer un cluster, procédez comme suit :
1. Dans le catalogue, sélectionnez **Cluster Kubernetes**.
2. Sélectionnez un type de plan de cluster. Vous pouvez choisir entre **Lite** ou **Paiement à la carte**. Avec le plan Paiement à la carte, vous pouvez mettre à disposition un cluster standard avec des fonctions, telles que des noeuds d'agent multiples pour un environnement à haute disponibilité.
3. Configurez les détails de votre cluster.
    1. Donnez un nom à votre cluster, choisissez une version de Kubernetes et sélectionnez un emplacement pour le déploiement. Sélectionnez l'emplacement qui est le plus proche de vous physiquement pour obtenir les meilleures performances. N'oubliez pas qu'il se peut que vous ayez besoin d'une autorisation des autorités pour stocker physiquement les données dans un autre pays, si vous sélectionnez un emplacement à l'étranger.
    2. Sélectionnez un type de machine et indiquez le nombre de noeuds d'agent dont vous avez besoin. Le type de machine détermine le nombre d'UC virtuelles et la mémoire configurés dans chaque noeud worker et rendus accessibles aux conteneurs.
        - Le type de machine micro correspond à l'option la plus modique.
        - Une machine équilibrée comporte la même quantité de mémoire qui est affectée à chaque UC, ce qui optimise les performances.
        - Les types de machine dont le nom inclut `encrypted` chiffrent les données Docker de l'hôte. Le répertoire `/var/lib/docker`, dans lequel sont stockées toutes les données des conteneurs, est chiffré avec le chiffrement LUKS.
    3. Sélectionnez un réseau local virtuel (VLAN) public et un VLAN privé à partir de votre compte d'infrastructure IBM Cloud (SoftLayer). Ces deux réseaux VLAN communiquent entre les noeuds d'agent mais le réseau VLAN public communique également avec le noeud maître Kubernetes géré par IBM. Vous pouvez utiliser le même VLAN pour plusieurs clusters.
        **Remarque** : si vous choisissez de ne pas sélectionner de VLAN public, vous devez configurer une solution alternative.
    4. Sélectionnez un type de matériel. Partagé est une option satisfaisante pour la plupart des situations.
        - **Dédié** : assure un isolement complet de vos ressources physiques.
        - **Partagé** : permet le stockage de vos ressources physiques sur le même matériel que pour d'autres clients IBM.
        - Les noeuds Worker exploitent par défaut le chiffrement de disque ; [En savoir plus](cs_security.html#cs_security_worker). Si vous désirez désactiver le chiffrement, décochez la case **Chiffrer le disque local**.
4. Cliquez sur **Créer un cluster**. Vous pouvez voir la progression du déploiement du noeud worker dans l'onglet **Noeuds d'agent**. Une fois le déploiement terminé, vous pouvez voir si le cluster est prêt dans l'onglet **Vue d'ensemble**.
    **Remarque :** A chaque noeud worker sont affectés un ID de noeud worker unique et un nom de domaine qui ne doivent pas être modifiés manuellement après la création du cluster. La modification de l'ID ou du domaine empêcherait le maître Kubernetes de gérer votre cluster.


**Etape suivante ?**

Une fois le cluster opérationnel, vous pouvez réaliser les tâches suivantes :

-   [Installer les interfaces de ligne de commande pour commencer à utiliser votre cluster.](cs_cli_install.html#cs_cli_install)
-   [Déployer une application dans votre cluster.](cs_apps.html#cs_apps_cli)
-   [Configurer votre propre registre privé dans {{site.data.keyword.Bluemix_notm}} pour stocker et partager des Docker avec d'autres utilisateurs.](/docs/services/Registry/index.html)
- Si vous utilisez un pare-feu, vous devrez peut-être [ouvrir les ports requis](cs_security.html#opening_ports) afin d'utiliser les commandes `bx`, `kubectl` ou `calicotl`, autoriser le trafic sortant de votre cluster ou le trafic entrant pour les services réseau.

<br />


## Création de clusters depuis l'interface CLI
{: #cs_cluster_cli}

Un cluster est un ensemble de noeuds d'agent organisés dans un réseau. L'objet de ce cluster est de définir un ensemble de ressources, de noeuds, de réseaux et de périphériques de stockage permettant d'assurer une haute disponibilité des applications. Avant de pouvoir déployer une application, vous devez créer un cluster et spécifier les définitions des noeuds d'agent dans ce cluster.
{:shortdesc}

Pour créer un cluster, procédez comme suit :
1.  Installez l'interface de ligne de commande {{site.data.keyword.Bluemix_notm}} et le [plug-in {{site.data.keyword.containershort_notm}}](cs_cli_install.html#cs_cli_install).
2.  Connectez-vous à l'interface de ligne de commande {{site.data.keyword.Bluemix_notm}}. A l'invite, entrez vos données
d'identification {{site.data.keyword.Bluemix_notm}}.

    ```
    bx login
    ```
    {: pre}

    **Remarque :** si vous possédez un ID fédéré, exécutez la commande `bx login --sso` pour vous connecter à l'interface de ligne de commande {{site.data.keyword.Bluemix_notm}}. Entrez votre nom d'utilisateur et utilisez l'URL mentionnée dans la sortie CLI pour extraire votre code d'accès à usage unique. Si la connexion échoue alors que vous omettez l'option `--sso` et aboutit en incluant l'option `--sso`, ceci indique que votre ID est fédéré.

3. Si vous disposez de plusieurs comptes {{site.data.keyword.Bluemix_notm}}, sélectionnez le compte que vous voulez utiliser pour créer votre cluster Kubernetes.

4.  Si vous désirez créer ou accéder à des clusters Kubernetes dans une région {{site.data.keyword.Bluemix_notm}} autre que celle que vous aviez sélectionné auparavant, exécutez la commande `bx cs region-set`.

6.  Créez un cluster.
    1.  Examinez les emplacements disponibles. Les emplacements affichés dépendent de la région {{site.data.keyword.containershort_notm}} à laquelle vous êtes connecté.

        ```
        bx cs locations
        ```
        {: pre}

        La sortie de l'interface de ligne de commande correspond aux [emplacements de la région du conteneur](cs_regions.html#locations).

    2.  Sélectionnez un emplacement et examinez les types de machine disponibles sur celui-ci. Le type de machine spécifie les ressources de traitement virtuelles disponibles pour chaque noeud worker.

        ```
        bx cs machine-types <location>
        ```
        {: pre}

        ```
        Getting machine types list...
        OK
        Machine Types
        Name         Cores   Memory   Network Speed   OS             Storage   Server Type
        u2c.2x4      2       4GB      1000Mbps        UBUNTU_16_64   100GB     virtual
        b2c.4x16     4       16GB     1000Mbps        UBUNTU_16_64   100GB     virtual
        b2c.16x64    16      64GB     1000Mbps        UBUNTU_16_64   100GB     virtual
        b2c.32x128   32      128GB    1000Mbps        UBUNTU_16_64   100GB     virtual
        b2c.56x242   56      242GB    1000Mbps        UBUNTU_16_64   100GB     virtual
        ```
        {: screen}

    3.  Vérifiez s'il existe des réseaux VLAN public et privé dans l'infrastructure IBM Cloud (SoftLayer) pour ce compte.

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

    4.  Exécutez la commande `cluster-create`. Vous avez le choix entre un cluster léger, qui inclut un noeud worker avec 2 UC virtuelles et 4 Go de mémoire, ou un cluster standard, lequel peut inclure autant de noeuds d'agent que vous le souhaitez dans votre compte d'infrastructure IBM Cloud (SoftLayer). Lorsque vous créez un cluster standard, par défaut, les disques de noeud worker sont chiffrés, son matériel est partagé par plusieurs clients IBM et il est facturé par heures d'utilisation. </br>Exemple pour un cluster standard :

        ```
        bx cs cluster-create --location dal10 --public-vlan <public_vlan_id> --private-vlan <private_vlan_id> --machine-type u2c.2x4 --workers 3 --name <cluster_name> --kube-version <major.minor.patch> 
        ```
        {: pre}

        Exemple pour un cluster léger :

        ```
        bx cs cluster-create --name my_cluster
        ```
        {: pre}

        <table>
        <caption>Tableau 1. Description des composantes de la commande <code>bx cs cluster-create</code></caption>
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
        <td>Remplacez <em>&lt;location&gt;</em> par l'ID de l'emplacement {{site.data.keyword.Bluemix_notm}} où vous désirez créer votre cluster. Les [emplacements disponibles](cs_regions.html#locations) dépendent de la région {{site.data.keyword.containershort_notm}} à laquelle vous êtes connecté.</td>
        </tr>
        <tr>
        <td><code>--machine-type <em>&lt;machine_type&gt;</em></code></td>
        <td>Si vous créez un cluster standard, choisissez un type de machine. Le type de machine spécifie les ressources de traitement virtuelles disponibles pour chaque noeud worker. Pour plus d'informations, consultez la rubrique [Comparaison des clusters léger et standard pour {{site.data.keyword.containershort_notm}}](cs_planning.html#cs_planning_cluster_type). Pour les clusters légers, vous n'avez pas besoin de définir le type de machine.</td>
        </tr>
        <tr>
        <td><code>--public-vlan <em>&lt;public_vlan_id&gt;</em></code></td>
        <td><ul>
          <li>Pour les clusters légers, vous n'avez pas besoin de définir un VLAN public. Votre cluster léger est automatiquement connecté à un VLAN public dont IBM est propriétaire.</li>
          <li>Pour un cluster standard, si vous disposez déjà d'un VLAN public configuré dans votre compte d'infrastructure IBM Cloud (SoftLayer) pour cet emplacement, entrez l'ID du VLAN public. Si vous ne disposez pas d'un VLAN public et d'un VLAN privé dans votre compte, ne spécifiez pas cette option. {{site.data.keyword.containershort_notm}} crée automatiquement un VLAN public pour vous.<br/><br/>
          <strong>Remarque</strong> : les routeurs de VLAN privé commencent toujours par <code>bcr</code> (routeur dorsal) et les routeurs de VLAN public par <code>fcr</code> (routeur frontal). Le numéro et la combinaison de lettres après ces préfixes doivent correspondre pour pouvoir utiliser ces réseaux locaux virtuels lors de la création d'un cluster.</li>
        </ul></td>
        </tr>
        <tr>
        <td><code>--private-vlan <em>&lt;private_vlan_id&gt;</em></code></td>
        <td><ul><li>Pour les clusters légers, vous n'avez pas besoin de définir un VLAN privé. Votre cluster léger est automatiquement connecté à un VLAN privé dont IBM est propriétaire.</li><li>Pour un cluster standard, si vous disposez déjà d'un VLAN privé configuré dans votre compte d'infrastructure IBM Cloud (SoftLayer) pour cet emplacement, entrez l'ID du VLAN privé. Si vous ne disposez pas d'un VLAN public et d'un VLAN privé dans votre compte, ne spécifiez pas cette option. {{site.data.keyword.containershort_notm}} crée automatiquement un VLAN public pour vous.<br/><br/><strong>Remarque</strong> : les routeurs de VLAN privé commencent toujours par <code>bcr</code> (routeur dorsal) et les routeurs de VLAN public par <code>fcr</code> (routeur frontal). Le numéro et la combinaison de lettres après ces préfixes doivent correspondre pour pouvoir utiliser ces réseaux locaux virtuels lors de la création d'un cluster.</li></ul></td>
        </tr>
        <tr>
        <td><code>--name <em>&lt;name&gt;</em></code></td>
        <td>Remplacez <em>&lt;name&gt;</em> par le nom de votre cluster.</td>
        </tr>
        <tr>
        <td><code>--workers <em>&lt;number&gt;</em></code></td>
        <td>Nombre de noeuds d'agent à inclure dans le cluster. Si l'option <code>--workers</code> n'est pas spécifiée, 1 noeud worker est créé.</td>
        </tr>
        <tr>
          <td><code>--kube-version <em>&lt;major.minor.patch&gt;</em></code></td>
          <td>Version Kubernetes du noeud maître du cluster. Cette valeur est facultative. Sans spécification, le cluster est créé avec les versions Kubernetes prises en charge par défaut. Pour connaître les versions disponibles, exécutez la commande <code>bx cs kube-versions</code>.</td>
        </tr>
        <tr>
        <td><code>--disable-disk-encrypt</code></td>
        <td>Les noeuds Worker exploitent par défaut le chiffrement de disque ; [En savoir plus](cs_security.html#cs_security_worker). Incluez cette option si Si vous désirez désactiver le chiffrement.</td>
        </tr>
        </tbody></table>

7.  Vérifiez que la création du cluster a été demandée.

    ```
    bx cs clusters
    ```
    {: pre}

    **Remarque :** la réservation des postes de noeud worker et la mise en place et la mise à disposition du cluster dans votre compte peuvent prendre jusqu'à 15 minutes.

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

    **Remarque :** A chaque noeud worker sont affectés un ID de noeud worker unique et un nom de domaine qui ne doivent pas être modifiés manuellement après la création du cluster. La modification de l'ID ou du domaine empêcherait le maître Kubernetes de gérer votre cluster.

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

10. Lancez le tableau de bord Kubernetes via le port par défaut `8001`.
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
-   [Gérez votre cluster à l'aide de la ligne de commande `kubectl`. ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/user-guide/kubectl/)
-   [Configurez votre propre registre privé dans {{site.data.keyword.Bluemix_notm}} afin de stocker et de partager des images Docker avec d'autres utilisateurs.](/docs/services/Registry/index.html)
- Si vous utilisez un pare-feu, vous devrez peut-être [ouvrir les ports requis](cs_security.html#opening_ports) afin d'utiliser les commandes `bx`, `kubectl` ou `calicotl`, autoriser le trafic sortant de votre cluster ou le trafic entrant pour les services réseau.

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

1. [Configurez un espace de nom dans {{site.data.keyword.registryshort_notm}} sur {{site.data.keyword.Bluemix_notm}} public ou {{site.data.keyword.Bluemix_dedicated_notm}} et transférez par commande push des images dans cet espace de nom](/docs/services/Registry/registry_setup_cli_namespace.html#registry_namespace_add).
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

Vous pouvez déployer des conteneurs vers d'autres espaces de nom Kubernetes, utiliser des images stockées dans d'autres régions ou comptes {{site.data.keyword.Bluemix_notm}}, ou encore des images stockées dans {{site.data.keyword.Bluemix_dedicated_notm}}, en créant votre propre élément imagePullSecret.

Avant de commencer :

1.  [Configurez un espace de nom dans {{site.data.keyword.registryshort_notm}} sur {{site.data.keyword.Bluemix_notm}} public ou {{site.data.keyword.Bluemix_dedicated_notm}} et transférez par commande push des images dans cet espace de nom](/docs/services/Registry/registry_setup_cli_namespace.html#registry_namespace_add).
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
    <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composantes de cette commande</th>
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
    <td>Obligatoire. URL du registre d'images où votre espace de nom est configuré.<ul><li>Pour les espaces de nom définis au Sud et à l'Est des Etats-Unis  : registry.ng.bluemix.net</li><li>Pour les espaces de nom définis au Sud du Royaume-Uni : registry.eu-gb.bluemix.net</li><li>Pour les espaces de nom définis en Europe centrale (Francfort) : registry.eu-de.bluemix.net</li><li>Pour les espaces de nom définis en Australie (Sydney) : registry.au-syd.bluemix.net</li><li>Pour les espaces de nom définis dans le registre {{site.data.keyword.Bluemix_dedicated_notm}}.<em>&lt;dedicated_domain&gt;</em></li></ul></td>
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
        <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
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
    <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composantes de cette commande</th>
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
        <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
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
2. [Demandez une instance du service {{site.data.keyword.Bluemix_notm}} service](/docs/manageapps/reqnsi.html#req_instance).
   **Remarque :** pour créer une instance de service sur le site Washington DC, vous devez utiliser l'interface CLI.

**Remarque :**
<ul><ul>
<li>Vous ne pouvez ajouter que des services {{site.data.keyword.Bluemix_notm}} qui prennent en charge les clés de service. Si le service ne prend pas en charge les clés de service, voir [Utilisation des services {{site.data.keyword.Bluemix_notm}} avec des applications externes](/docs/manageapps/reqnsi.html#req_instance).</li>
<li>Le cluster et les noeuds d'agent doivent être complètement déployés pour pouvoir ajouter un service.</li>
</ul></ul>


Pour ajouter un service, procédez comme suit :
2.  Répertoriez les services {{site.data.keyword.Bluemix_notm}} disponibles.

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

<br />



## Gestion de l'accès au cluster
{: #cs_cluster_user}

Chaque utilisateur d'{{site.data.keyword.containershort_notm}} doit être affecté à une combinaison de rôles utilisateur spécifique au service qui détermine les actions qu'il peut effectuer.
{:shortdesc}

<dl>
<dt>Règles d'accès {{site.data.keyword.containershort_notm}}</dt>
<dd>Dans Identity and Access Management, les règles d'accès {{site.data.keyword.containershort_notm}} déterminent les actions de gestion de cluster que vous pouvez effectuer, comme la création ou la suppression de clusters, ou l'ajout ou la suppression de noeuds worker. Ces règles doivent être définies en conjonction avec des règles d'infrastructure.</dd>
<dt>Règles d'accès à l'infrastructure</dt>
<dd>Dans Identity and Access Management, les règles d'accès à l'infrastructure permettent aux actions demandées dans l'interface utilisateur ou l'interface de ligne de commande d'{{site.data.keyword.containershort_notm}} de s'exécuter dans l'infrastructure IBM Cloud (SoftLayer). Ces règles doivent être définies en conjonction avec des règles d'accès à {{site.data.keyword.containershort_notm}}. [En savoir plus sur les rôles d'infrastructure disponibles](/docs/iam/infrastructureaccess.html#infrapermission).</dd>
<dt>Groupes de ressources</dt>
<dd>Un groupe de ressources permet de regrouper des services {{site.data.keyword.Bluemix_notm}} de manière à pouvoir affecter rapidement des accès à des utilisateurs à plusieurs ressources à la fois. [Découvrez comment gérer des utilisateurs à l'aide de groupes de ressources](/docs/admin/resourcegroups.html#rgs).</dd>
<dt>Rôles Cloud Foundry</dt>
<dd>Dans Identity and Access Management, chaque utilisateur doit être affecté à un rôle utilisateur Cloud Foundry. Ce rôle détermine les actions que peut effectuer l'utilisateur sur le compte {{site.data.keyword.Bluemix_notm}} (par exemple, inviter d'autres utilisateurs ou examiner l'utilisation du quota). [En savoir plus sur les rôles Cloud Foundry disponibles](/docs/iam/cfaccess.html#cfaccess).</dd>
<dt>Rôles RBAC Kubernetes</dt>
<dd>Chaque utilisateur auquel est affectée une règle d'accès {{site.data.keyword.containershort_notm}} est automatiquement affecté à un rôle RBAC Kubernetes. Dans Kubernetes, les rôles RBAC déterminent les actions que vous pouvez effectuer sur des ressources Kubernetes dans le cluster. Les rôles RBAC ne sont configurés que pour l'espace de nom par défaut. L'administrateur du cluster peut ajouter des rôles RBAC pour d'autres espaces de nom dans le cluster. Pour plus d'informations, voir [Using RBAC Authorization ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/admin/authorization/rbac/#api-overview) dans la documentation Kubernetes.</dd>
</dl>

Cette section aborde les points suivants :

-   [Règles et droits d'accès](#access_ov)
-   [Ajout d'utilisateurs au compte {{site.data.keyword.Bluemix_notm}}](#add_users)
-   [Personnalisation des droits sur l'infrastructure pour un utilisateur](#infrastructure_permissions)

### Règles et droits d'accès
{: #access_ov}

Examinez les règles d'accès et les autorisations que vous pouvez attribuer à des utilisateurs dans votre compte {{site.data.keyword.Bluemix_notm}}. Les rôles opérateur et éditeur ont des droits distincts. Si vous voulez qu'un utilisateur puisse, par exemple, ajouter des noeuds d'agent et lier des services, vous devez lui attribuer le rôle opérateur et le rôle éditeur.

|Règles d'accès {{site.data.keyword.containershort_notm}}|Autorisations de gestion de cluster|Autorisations sur les ressources Kubernetes|
|-------------|------------------------------|-------------------------------|
|Administrateur|Ce rôle hérite des autorisations des rôles Editeur, Opérateur et Visualiseur dans tous les clusters du compte. <br/><br/>Lorsqu'il est défini pour toutes les instances de service en cours :<ul><li>Créer un cluster léger ou standard</li><li>Définir les données d'identification pour un compte {{site.data.keyword.Bluemix_notm}} afin d'accéder au portefeuille d'infrastructure IBM Cloud (SoftLayer)</li><li>Supprimer un cluster</li><li>Affecter et modifier des règles d'accès {{site.data.keyword.containershort_notm}} pour d'autres utilisateurs existants dans ce compte.</li></ul><p>Lorsqu'il est défini pour un ID de cluster spécifique :<ul><li>Supprimer un cluster spécifique</li></ul></p>Règle d'accès à l'infrastructure correspondante : Superutilisateur<br/><br/><b>Remarque </b>: pour créer des ressources telles que des machines, des réseaux locaux virtuels (VLAN) et des sous-réseaux, les utilisateurs ont besoin du rôle d'infrastructure **Superutilisateur**.|<ul><li>Rôle RBAC : cluster-admin</li><li>Accès en lecture/écriture aux ressources dans tous les espaces de nom</li><li>Créer des rôles au sein d'un espace de nom</li><li>Accès au tableau de bord Kubernetes</li><li>Créer une ressource Ingress permettant de rendre les applications publiquement disponibles</li></ul>|
|Opérateur|<ul><li>Ajouter des noeuds worker supplémentaires à un cluster</li><li>Supprimer des noeuds worker d'un cluster</li><li>Réamorcer un noeud worker</li><li>Recharger un noeud worker</li><li>Ajouter un sous-réseau à un cluster</li></ul><p>Règles d'accès à l'infrastructure correspondante : Utilisateur de base</p>|<ul><li>Rôle RBAC : admin</li><li>Accès en lecture/écriture aux ressources dans l'espace de nom par défaut, mais non pas à l'espace de nom lui-même</li><li>Créer des rôles au sein d'un espace de nom</li></ul>|
|Editeur <br/><br/><b>Conseil </b>: utilisez ce rôle pour les développeurs d'application.|<ul><li>Lier un service {{site.data.keyword.Bluemix_notm}} à un cluster.</li><li>Dissocier un service {{site.data.keyword.Bluemix_notm}} d'un cluster.</li><li>Créer un webhook.</li></ul><p>Règles d'accès à l'infrastructure correspondante : Utilisateur de base|<ul><li>Rôle RBAC : edit</li><li>Accès en lecture/écriture aux ressources dans l'espace de nom par défaut</li></ul></p>|
|Afficheur|<ul><li>Lister un cluster</li><li>Afficher les détails d'un cluster</li></ul><p>Règles d'accès à l'infrastructure correspondante : visualisation uniquement</p>|<ul><li>Rôle RBAC : view</li><li>Accès en lecture aux ressources dans l'espace de nom par défaut</li><li>Pas d'accès en lecture aux valeurs confidentielles Kubernetes</li></ul>|
{: caption="Tableau 7. {{site.data.keyword.containershort_notm}} Règles et droits d'accès" caption-side="top"}

|Règles d'accès Cloud Foundry|Autorisations de gestion des comptes|
|-------------|------------------------------|
|Rôle d'organisation : gestionnaire|<ul><li>Ajouter des utilisateurs supplémentaires dans un compte {{site.data.keyword.Bluemix_notm}}</li></ul>| |
|Rôle d'espace : développeur|<ul><li>Créer des instances de service {{site.data.keyword.Bluemix_notm}}</li><li>Lier des instances de service {{site.data.keyword.Bluemix_notm}} à des clusters</li></ul>| 
{: caption="Tableau 8. Règles et droits d'accès Cloud Foundry" caption-side="top"}


### Ajout d'utilisateurs à un compte {{site.data.keyword.Bluemix_notm}}
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
      4. Dans la section **Sélectionnez des rôles**, choisissez un rôle. Pour consulter la liste des actions prises en charge pour chaque rôle, voir [Règles et droits d'accès](#access_ov).
  - Pour **Groupe de ressources** :
      1. Dans la liste déroulante **Groupe de ressources**, sélectionnez le groupe de ressources qui contient des droits sur la ressource {{site.data.keyword.containershort_notm}} de votre compte.
      2. Dans la liste déroulante **Affecter l'accès à un groupe de ressources**, sélectionnez un rôle. Pour consulter la liste des actions prises en charge pour chaque rôle, voir [Règles et droits d'accès](#access_ov).
4. [Facultatif : affectez un rôle d'infrastructure](/docs/iam/mnginfra.html#managing-infrastructure-access).
5. [Facultatif : affectez un rôle Cloud Foundry](/docs/iam/mngcf.html#mngcf).
5. Cliquez sur **Inviter des utilisateurs**.



### Personnalisation des autorisations utilisateur pour l'infrastructure
{: #infrastructure_permissions}

Lorsque vous définissez des règles sur l'infrastructure dans Identity and Access Management, des droits associés à un rôle sont attribués à un utilisateur. Pour personnaliser ces droits, vous devez vous connecter à l'infrastructure IBM Cloud (SoftLayer) et adapter ces droits.
{: #view_access}

Par exemple, les utilisateurs de base peuvent redémarrer un noeud worker, mais ne peuvent pas recharger un noeud worker. Sans attribuer à cette personne des doits superutilisateur, vous pouvez adapter les droits sur l'infrastructure IBM Cloud (SoftLayer) et autoriser l'utilisateur à exécuter une commande de rechargement.

1.  Connectez-vous à votre compte d'infrastructure IBM Cloud (SoftLayer).
2.  Sélectionnez un profil utilisateur à mettre à jour.
3.  Dans **Autorisations du portail**, personnalisez l'accès de l'utilisateur. Par exemple, pour ajouter une autorisation de rechargement, dans l'onglet **Périphériques**, sélectionnez **Rechargement du système d'exploitation et lancement du noyau de secours**.
9.  Sauvegardez vos modifications.

<br />



## Mise à jour du maître Kubernetes
{: #cs_cluster_update}

Kubernetes met régulièrement à jour les [versions principales, mineures et correctives ](cs_versions.html#version_types), qui ont un impact sur vos clusters. La mise à jour d'un cluster est un processus en deux étapes. Vous devez d'abord mettre à jour le maître Kubernetes pour pouvoir mettre à jour chacun des noeuds d'agent.

Par défaut, vous ne pouvez pas mettre à jour le maître Kubernetes de plus de deux versions mineures. Par exemple, si votre version maître actuelle est la version 1.5 et que vous voulez passer à la version 1.8, vous devez d'abord passer en version 1.7. Vous pouvez forcer la mise à jour pour continuer, mais passer à plus de deux versions au-dessus de la version en cours risque d'entraîner des résultats inattendus.

**Attention** : Respectez les instructions de mise à jour et utilisez un cluster de test pour traiter les indisponibilités et interruptions d'application potentielles au cours de la mise à jour. Vous ne pouvez pas revenir à la version précédente d'un cluster.

Lorsque vous effectuez une mise à jour _principale_ ou _secondaire_, procédez comme suit.

1. Passez en revue les [modifications Kubernetes](cs_versions.html) et effectuez les mises à jour marquées _Mise à jour avant le maître_.
2. Mettez à jour le maître Kubernetes à l'aide de l'interface graphique ou en exécutant la [commande CLI](cs_cli_reference.html#cs_cluster_update). Lorsque vous le mettez à jour, le maître Kubernetes est indisponible pendant 5 à 10 minutes. Pendant la mise à jour, vous ne pouvez ni accéder au cluster, ni le modifier. En revanche, les noeuds d'agent, les applications et les ressources que les utilisateurs du cluster ont déployés ne sont pas modifiés et poursuivent leur exécution.
3. Confirmez que la mise à jour est terminée. Vérifiez la version Kubernetes dans le tableau de bord {{site.data.keyword.Bluemix_notm}} ou exécutez la commande `bx cs clusters`.

Une fois la mise à jour du maître Kubernetes terminée, vous pouvez mettre à jour vos noeuds d'agent.

<br />


## Mise à jour des noeuds d'agent
{: #cs_cluster_worker_update}

Alors qu'IBM applique automatiquement des correctifs au maître de Kubernetes, vous devez explicitement appliquer les mises à jour principales et mineures aux noeuds d'agent. La version d'un noeud worker ne peut pas être supérieure à la version du maître Kubernetes.

**Attention** : Les mises à jour des noeuds d'agent peuvent provoquer l'indisponibilité de vos services et applications :
- Des données sont supprimées si elles ne sont pas stockées hors du pod.
- Utilisez des [répliques ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#replicas) dans vos déploiements pour replanifier des pods sur les noeuds disponibles.

Mise à jour des clusters au niveau de la production :
- Pour vous aider à éviter des temps d'indisponibilité de vos applications, le processus de mise à jour empêche la planification de pods sur le noeud worker pendant la mise à jour. Pour plus d'informations, voir [`Flux kubectl` ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#drain).
- Utilisez un cluster de test pour valider que vos charges de travail et le processus de livraison ne sont pas impactés par la mise à jour. Vous ne pouvez pas revenir à la version précédente des noeuds d'agent.
- Les clusters au niveau de la production doivent être en mesure de surmonter l'échec d'un noeud worker. Si ce n'est pas le cas de votre cluster, ajoutez un noeud worker avant de mettre à jour le cluster.
- Une mise à jour tournante est effectuée lorsque plusieurs noeuds d'agent doivent être mis à niveau. Une mise à niveau peut s'appliquer simultanément à 20 pourcent maximum du nombre total de noeuds d'agent d'un cluster. Le processus de mise à niveau attend que la mise à niveau d'un noeud worker soit terminée avant de commencer la mise à niveau d'un autre agent.


1. Installez la version de l'[`interface de ligne de commande kubectl` ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/tasks/tools/install-kubectl/) correspondant à la version Kubernetes du maître Kubernetes.

2. Apportez toutes les modifications indiquées par _Mise à jour après le maître_ dans [Modifications Kubernetes](cs_versions.html).

3. Mettez à jour vos noeuds d'agent :
  * Pour effectuer la mise à jour à partir du tableau de bord {{site.data.keyword.Bluemix_notm}}, accédez à la section `Worker nodes` de votre cluster, et cliquez sur `Update Worker`.
  * Pour obtenir les ID des noeuds d'agent, exécutez la commande `bx cs workers <cluster_name_or_id>`. Si vous sélectionnez plusieurs noeuds d'agent, ils sont mis à jour un par un.

    ```
    bx cs worker-update <cluster_name_or_id> <worker_node_id1> <worker_node_id2>
    ```
    {: pre}

4. Confirmez que la mise à jour est terminée :
  * Vérifiez la version Kubernetes dans le tableau de bord {{site.data.keyword.Bluemix_notm}} ou exécutez la commande `bx cs workers <cluster_name_or_id>`.
  * Vérifiez la version Kubernets des noeuds d'agent en exécutant la commande `kubectl get nodes`.
  * Dans certains cas, des clusters plus anciens peuvent répertorier des noeuds d'agent en double avec un statut **NotReady** après une mise à jour. Pour supprimer ces doublons, voir la section de [traitement des incidents](cs_troubleshoot.html#cs_duplicate_nodes).

Une fois la mise à jour terminée :
  - Répétez le processus de mise à jour pour les autres clusters.
  - Informez les développeurs qui travaillent dans le cluster pour qu'ils mettent à jour leur interface de ligne de commande `kubectl` à la version du maître Kubernetes.
  - Si le tableau de bord Kubernetes n'affiche pas les graphiques d'utilisation, [supprimez le pod `kube-dashboard`](cs_troubleshoot.html#cs_dashboard_graphs).

<br />


## Ajout de sous-réseaux à des clusters
{: #cs_cluster_subnet}

Vous pouvez modifier le pool d'adresses IP portables publiques ou privées disponibles en ajoutant des sous-réseaux à votre cluster.
{:shortdesc}

Dans {{site.data.keyword.containershort_notm}}, vous pouvez ajouter des adresses IP portables stables pour les services Kubernetes en adjoignant des sous-réseaux au cluster. Dans ce cas, des sous-réseaux ne sont pas utilisés avec le masque réseau pour créer une connectivité à travers un ou pluisurs clusters. A la place, les sous-réseaux sont utilisés pour fournir des adresses IP permanentes fixes pour un service d'un cluster pouvant être utilisées pour accéder à ce service.

Lorsque vous créez un cluster standard, {{site.data.keyword.containershort_notm}} lui alloue automatiquement un sous-réseau public portable avec 5 adresses IP publiques et un sous-réseau privé portable avec 5 adresses IP privées. Les adresses IP publiques et privées portables sont statiques et ne changent pas lorsqu'un noeud worker, ou même le cluster, est retiré. Pour chaque sous-réseau, une adresse IP portable publique et une adresse IP portable privée sont utilisées pour les [équilibreurs de charge d'application](cs_apps.html#cs_apps_public_ingress) que vous pouvez utiliser pour exposer plusieurs applications dans votre cluster. Les 4 adresses IP publiques portables et les 4 adresses IP privées portables restantes peuvent être utilisées pour exposer au public des applications distinctes en [créant un service d'équilibreur de charge](cs_apps.html#cs_apps_public_load_balancer).

**Remarque :** les adresses IP publiques portables sont facturées sur une base mensuelle. Si vous décidez de retirer les adresses IP portables après la mise en place de votre cluster, vous devez quand même payer les frais mensuels, même si vous ne les avez utilisées que brièvement.

### Demande de sous-réseaux supplémentaires pour votre cluster
{: #add_subnet}

Vous pouvez ajouter des adresses IP publiques ou privées portables stables au cluster en lui affectant des sous-réseaux.

**Remarque :** lorsque vous rendez un sous-réseau disponible pour un cluster, les adresses IP du sous-réseau sont utilisées pour l'opération réseau du cluster. Pour éviter des conflits d'adresse IP, prenez soin de n'utiliser le sous-réseau qu'avec un seul cluster. N'utilisez pas en même temps un sous-réseau pour plusieurs clusters ou à d'autres fins hors d'{{site.data.keyword.containershort_notm}}.

Avant de commencer, [ciblez avec votre interface de ligne de commande](cs_cli_install.html#cs_cli_configure) votre cluster.

Pour créer un sous-réseau dans un compte d'infrastructure IBM Cloud (SoftLayer) et le rendre disponible pour un cluster spécifié :

1. Provisionnez un nouveau sous-réseau.

    ```
    bx cs cluster-subnet-create <nom_ou_ID_cluster> <taille_sous-réseau> <ID_VLAN>
    ```
    {: pre}

    <table>
    <caption>Tableau 8. Description des composantes de cette commande</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composantes de cette commande</th>
    </thead>
    <tbody>
    <tr>
    <td><code>cluster-subnet-create</code></td>
    <td>Commande de création d'un sous-réseau pour votre cluster.</td>
    </tr>
    <tr>
    <td><code><em>&lt;nom_ou_ID_cluster&gt;</em></code></td>
    <td>Remplacez <code>&gt;nom_ou_ID_cluste&lt;</code> par le nom ou l'ID du cluster.</td>
    </tr>
    <tr>
    <td><code><em>&lt;taille_sous-réseau&gt;</em></code></td>
    <td>Remplacez <code>&gt;taille_sous-réseau&lt;</code> par le nombre d'adresses IP que vous désirez ajouter depuis votre sous-réseau portable. Valeurs admises : 8, 16, 32 ou 64. <p>**Remarque :** lorsque vous ajoutez des adresses IP portables pour votre sous-réseau, trois adresses IP sont utilisées pour l'opération réseau interne au cluster, de sorte que vous ne pouvez pas les utiliser pour votre équilibreur de charge d'application ou pour créer un service d'équilibreur de charge. Par exemple, si vous demandez huit adresses IP publiques portables, vous pouvez en utiliser cinq pour exposer vos applications au public.</p> </td>
    </tr>
    <tr>
    <td><code><em>&lt;VLAN_ID&gt;</em></code></td>
    <td>Remplacez <code>&gt;ID_VLAN&lt;</code> par l'ID du VLAN privé ou public sur lequel vous désirez allouer les adresses IP portables publiques ou privées. Vous devez sélectionner le réseau local virtuel public ou privé auquel un noeud worker existant est connecté. Pour examiner le VLAN privé ou public d'un noeud worker, exécutez la commande <code>bx cs worker-get &gt;worker_id&lt;</code>.</td>
    </tr>
    </tbody></table>

2.  Vérifiez que le sous-réseau a bien été créé et ajouté à votre cluster. Le CIDR de sous-réseau est répertorié dans la section **VLAN**.

    ```
    bx cs cluster-get --showResources <cluster name or id>
    ```
    {: pre}

### Ajout de sous-réseaux personnalisés et existants à des clusters Kubernetes
{: #custom_subnet}

Vous pouvez ajouter des sous-réseaux publics ou privés portables existants à votre cluster Kubernetes.

Avant de commencer, [ciblez avec votre interface de ligne de commande](cs_cli_install.html#cs_cli_configure) votre cluster.

Si vous disposez d'un sous-réseau existant dans votre portefeuille d'infrastructure IBM Cloud (SoftLayer) avec des règles de pare-feu personnalisées ou des adresses IP disponibles que vous souhaitez utiliser, créez un cluster sans sous-réseau et rendez votre sous-réseau existant disponible au cluster lors de la mise à disposition du cluster.

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

3.  Créez un cluster en utilisant l'emplacement et l'ID du réseau local virtuel que vous avez identifiés. Incluez l'indicateur `--no-subnet` pour empêcher la création automatique d'un nouveau sous-réseau d'adresses IP publiques portables et d'un nouveau sous-réseau d'adresses IP privées portables.

    ```
    bx cs cluster-create --location dal10 --machine-type u2c.2x4 --no-subnet --public-vlan 1901230 --private-vlan 1900403 --workers 3 --name my_cluster
    ```
    {: pre}

4.  Vérifiez que la création du cluster a été demandée.

    ```
    bx cs clusters
    ```
    {: pre}

    **Remarque :** la réservation des postes de noeud worker et la mise en place et la mise à disposition du cluster dans votre compte peuvent prendre jusqu'à 15 minutes.

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

6.  Ajoutez le sous-réseau à votre cluster en spécifiant l'ID du sous-réseau. Lorsque vous rendez disponible un sous-réseau pour un cluster, une mappe de configuration Kubernetes est créée pour vous et inclut toutes les adresses IP publiques portables disponibles que vous pouvez utiliser. Si aucun équilibreur de charge d'application n'existe encore pour votre cluster, une adresse IP portable publique et une adresse IP portable privée sont automatiquement utilisées pour créer les équilibreurs de charge d'application privés et publics. Toutes les autres adresses peuvent être utilisées pour créer des services d'équilibreur de charge pour vos applications.

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

Avant de commencer, configurez le routage du trafic réseau entrant et sortant du sous-réseau externe. Confirmez également qu'il existe une connectivité VPN entre le périphérique de passerelle du centre de données sur site et le réseau privé Vyatta de votre portefeuille d'infrastructure IBM Cloud (SoftLayer). Pour plus d'informations, voir cet [article de blogue ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://www.ibm.com/blogs/bluemix/2017/07/kubernetes-and-bluemix-container-based-workloads-part4/).

1. Affichez l'ID du réseau local virtuel privé de votre cluster. Localisez la section **VLANs**. Dans la zone **User-managed**, identifiez l'ID VLAN avec la valeur _false_.

    ```
    bx cs cluster-get --showResources <cluster_name>
    ```
    {: pre}

    ```
    VLANs
    VLAN ID   Subnet CIDR         Public       User-managed
    1555503   192.0.2.0/24        true         false
    1555505   198.51.100.0/24     false        false
    ```
    {: screen}

2. Ajoutez le sous-réseau externe à votre VLAN privé. Les adresses IP privées portables sont ajoutées à la mappe de configuration du cluster.

    ```
    bx cs cluster-user-subnet-add <cluster_name> <subnet_CIDR> <VLAN_ID>
    ```
    {: pre}

    Exemple :

    ```
    bx cs cluster-user-subnet-add my_cluster 203.0.113.0/24 1555505
    ```
    {: pre}

3. Vérifiez que le sous-réseau fourni par l'utilisateur a été ajouté. La zone **User-managed** a la valeur _true_.

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

4. Ajoutez un service d'équilibrage de charge privé ou un équilibreur de charge d'application Ingress privé pour accéder à votre application à travers le réseau privé. Si vous désirez utiliser une adresse IP privée du sous-réseau que vous avez ajouté lorsque vous avez créé un équilibreur de charge privé ou un équilibreur de charge d'application Ingress privé, vous devez spécifier une adresse IP. Autrement, une adresse IP est sélectionnée de manière aléatoire dans les sous-réseaux d'infrastructure IBM Cloud (SoftLayer) ou dans les sous-réseaux fournis par l'utilisateur sur le VLAN privé. Pour plus d'informations, voir [Configuration de l'accès une application à l'aide du type de service d'équilibreur de charge](cs_apps.html#cs_apps_public_load_balancer) ou [Activation de l'équilibreur de charge d'application privé](cs_apps.html#private_ingress).

<br />


## Utilisation de partages de fichiers NFS existants dans des clusters
{: #cs_cluster_volume_create}

Si vous disposez déjà de partages de fichiers NFS existants dans votre compte d'infrastructure IBM Cloud (SoftLayer) et que vous voulez les utiliser avec Kubernetes, créez alors des volumes persistants sur votre partage de fichiers NFS existant. Un volume persistant est un élément matériel réel qui fait office de ressource de cluster Kubernetes et peut être consommé par l'utilisateur du cluster.
{:shortdesc}

Kubernetes fait une distinction entre les volumes persistants qui représentent le matériel effectif et les réservations de volume persistant qui sont des demandes de stockage déclenchées habituellement par l'utilisateur du cluster. Le diagramme suivant illustre la relation entre des volumes persistants et des réservations de volume persistant persistent volume.

![Créer des volumes persistants et des réservations de volumes persistants](images/cs_cluster_pv_pvc.png)

 Comme illustré dans le diagramme, pour permettre l'utilisation de partage de fichiers NLS existants avec Kubernetes, vous devez créer des volumes persistants d'une certaine taille et avec un mode d'accès déterminé,
qui soient conformes à la spécification de volume persistant. Si le volume persistant et la réservation de volume persistant correspondent, ils sont liés l'un à l'autre. Seules les réservations de volume persistant liées peuvent être utilisées par l'utilisateur du cluster pour monter le
volume sur un déploiement. Cette procédure est dénommée provisionnement statique de stockage persistant.

Avant de commencer, vérifiez que vous disposez d'un partage de fichiers NFS existant que vous pouvez utiliser pour créer votre volume persistant.

**Remarque :** le provisionnement statique de stockage persistant ne s'applique qu'aux partages de fichiers NFS existants. Si vous ne disposez pas de partages de fichiers
NFS existants, les utilisateurs du cluster peuvent utiliser la procédure de [provisionnement dynamique](cs_apps.html#cs_apps_volume_claim) pour ajouter des volumes persistants.

Pour créer un volume persistant et une réservation correspondante, procédez comme suit.

1.  Dans votre compte d'infrastructure IBM Cloud (SoftLayer), recherchez l'ID et le chemin du partage NFS où vous désirez créer votre objet de volume persistant. Par ailleurs, autorisez le stockage de fichiers sur les sous-réseaux du cluster. Cette autorisation permet à votre cluster d'accéder au stockage.
    1.  Connectez-vous à votre compte d'infrastructure IBM Cloud (SoftLayer).
    2.  Cliquez sur **Stockage**.
    3.  Cliquez sur **Stockage de fichiers** et, dans le menu **Actions**, sélectionnez **Autoriser l'hôte**.
    4.  Cliquez sur **Sous-réseaux**. Après l'autorisation, chaque noeud worker sur le sous-réseau a accès au stockage de fichiers.
    5.  Sélectionnez dans le menu le sous-réseau du VLAN public de votre cluster et cliquez sur **Soumettre**. Si vous devez identifier le sous-réseau, exécutez la commande `bx cs cluster-get <cluster_name> --showResources`.
    6.  Cliquez sur le nom du stockage de fichiers.
    7.  Notez la valeur de la zone **Point de montage**. Cette zone est affichée sous la forme `<server>:/<path>`.
2.  Créez un fichier de configuration de stockage pour votre volume persistant. Incluez le serveur et le chemin de la zone**Point de montage** du système de fichiers.

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
       server: "nfslon0410b-fz.service.networklayer.com"
       path: "/IBM01SEV8491247_0908"
    ```
    {: codeblock}

    <table>
    <caption>Tableau 9. Description des composantes du fichier YAML</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
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
    <td>Les modes d'accès définissent la manière dont une réservation de volume persistant peut être montée sur un noeud worker.<ul><li>ReadWriteOnce (RWO): le volume persistant ne peut être monté sur des déploiements que dans un seul noeud worker. Les conteneurs dans des déploiements montés sur ce volume persistant peuvent accéder en lecture et en écriture au volume.</li><li>ReadOnlyMany (ROX) : le volume persistant peut être monté sur des déploiements hébergés sur plusieurs noeuds worker. Les déploiements montés sur ce volume persistant ne peuvent accéder au volume qu'en lecture.</li><li>ReadWriteMany (RWX) : ce volume persistant peut être monté sur des déploiements hébergés sur plusieurs noeuds worker. Les déploiements montés sur ce volume persistant peuvent accéder en lecture et en écriture au volume.</li></ul></td>
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

3.  Créez le volume persistent dans votre cluster.

    ```
    kubectl apply -f <yaml_path>
    ```
    {: pre}

    Exemple

    ```
    kubectl apply -f deploy/kube-config/pv.yaml
    ```
    {: pre}

4.  Vérifiez que le volume persistant a été créé.

    ```
    kubectl get pv
    ```
    {: pre}

5.  Créez un autre fichier de configuration pour créer votre réservation de volume persistant. Pour que la réservation de volume persistant corresponde à l'objet de volume persistant créé auparavant, vous devez sélectionner la même valeur pour `storage` et pour `accessMode`. La zone `storage-class` doit être vide. Si l'une de ces zones ne correspond pas au volume persistant, un nouveau volume persistant est créé automatiquement à la place.

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

6.  Créez votre réservation de volume persistant.

    ```
    kubectl apply -f deploy/kube-config/mypvc.yaml
    ```
    {: pre}

7.  Vérifiez que votre réservation de volume persistant a été créée et liée à l'objet de volume persistant. Ce processus peut prendre quelques minutes.

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
persistant. Les utilisateurs du cluster peuvent à présent [monter la réservation de volume persistant](cs_apps.html#cs_apps_volume_mount) sur leurs déploiements et lancer une lecture et une écriture sur l'objet de volume persistant.

<br />


## Configuration de la journalisation de cluster
{: #cs_logging}

Les journaux vous aident à identifier et résoudre les incidents liés à vos clusters et à vos applications. Vous voudrez parfois envoyer des journaux à un emplacement spécifique pour traitement ou stockage à long terme. Sur un cluster Kubernetes dans {{site.data.keyword.containershort_notm}}, vous pouvez activer le transfert de journaux pour votre cluster et choisir l'emplacement de destination de vos transferts de journaux. **Remarque** : le transfert de journaux n'est pris en charge que pour les clusters standard.
{:shortdesc}

Vous pouvez réacheminer les journaux de sources de journal telles que des conteneurs, des applications, des noeuds worker, des clusters Kubernetes et des contrôleurs Ingress. Examinez le tableau suivant pour plus d'information sur chaque source de journal.

|Source de journal|Caractéristiques|Chemins d'accès aux journaux|
|----------|---------------|-----|
|`conteneur`|Journaux pour votre conteneur s'exécutant dans un cluster Kubernetes.|-|
|`application`|Journaux de votre application qui s'exécute dans un cluster Kubernetes.|`/var/log/apps/**/*.log`, `/var/log/apps/**/*.err`|
|`agent`|Journaux des noeuds d'agent de machine virtuelle dans un cluster Kubernetes.|`/var/log/syslog`, `/var/log/auth.log`|
|`kubernetes`|Journaux du composant système Kubernetes.|`/var/log/kubelet.log`, `/var/log/kube-proxy.log`|
|`ingress`|Journaux pour un équilibreur de charge d'application, géré par le conteneur Ingress et qui régit le trafic réseau entrant dans un cluster Kubernetes.|`/var/log/alb/ids/*.log`, `/var/log/alb/ids/*.err`, `/var/log/alb/customerlogs/*.log`, `/var/log/alb/customerlogs/*.err`|
{: caption="Tableau 9. Caractéristiques de la source de journal." caption-side="top"}

### Activation du transfert de journal
{: #cs_log_sources_enable}

Vous pouvez transférer des journaux vers {{site.data.keyword.loganalysislong_notm}} ou vers un serveur syslog externe. Si vous voulez transférer des journaux depuis une source de journal vers les deux serveurs collecteurs de journal, vous devez créer deux configurations de journalisation. **Remarque **: pour réacheminer des journaux d'applications, voir [Activation du transfert de journaux pour des applications](#cs_apps_enable).
{:shortdesc}

Avant de commencer :

1. Si vous voulez transférer des journaux vers un serveur syslog externe, vous pouvez configurer un serveur qui accepte un protocole syslog de deux manières :
  * Configurer et gérer votre propre serveur ou confier la gestion du serveur à un fournisseur. Dans ce cas, obtenez le noeud final de journalisation du fournisseur de journalisation.
  * Exécuter syslog à partir d'un conteneur. Par exemple, vous pouvez utiliser ce [fichier de déploiement .yaml ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://github.com/IBM-Bluemix/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml) pour extraire une image publique Docker qui exécute un conteneur dans un cluster Kubernetes. L'image publie le port `514` sur l'adresse IP du cluster public et utilise cette adresse pour configurer l'hôte syslog.

2. [Ciblez avec votre interface de ligne de commande](cs_cli_install.html#cs_cli_configure) le cluster où se trouve la source de journal.

Pour activer le transfert de journal pour un conteneur, un noeud worker, un composant du système Kubernetes ou un équilibreur de charge d'application :

1. Créez une configuration de transfert de journaux.

  * Pour transférer les journaux vers {{site.data.keyword.loganalysislong_notm}} :

    ```
    bx cs logging-config-create <my_cluster> --logsource <my_log_source> --namespace <kubernetes_namespace> --hostname <ingestion_URL> --port <ingestion_port> --spaceName <cluster_space> --orgName <cluster_org> --type ibm
    ```
    {: pre}

    <table>
    <caption>Tableau 10. Description des composantes de cette commande</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composantes de cette commande</th>
    </thead>
    <tbody>
    <tr>
    <td><code>logging-config-create</code></td>
    <td>Commande de création d'une configuration de transfert de journal {{site.data.keyword.loganalysislong_notm}}.</td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td>Remplacez <em>&lt;my_cluster&gt;</em> par le nom ou l'ID du cluster.</td>
    </tr>
    <tr>
    <td><code>--logsource <em>&lt;my_log_source&gt;</em></code></td>
    <td>Remplacez <em>&lt;my_log_source&gt;</em> par la source de journal. Valeurs admises : <code>container</code>, <code>application</code>, <code>worker</code>, <code>kubernetes</code> et <code>ingress</code>.</td>
    </tr>
    <tr>
    <td><code><em>&lt;kubernetes_namespace&gt;</em></code></td>
    <td>Remplacez <em>&lt;kubernetes_namespace&gt;</em> par l'espace de nom du conteneur Docker depuis lequel vous désirez réacheminer des journaux. Le transfert des journaux n'est pas pris en charge pour les espaces de nom Kubernetes <code>ibm-system</code> et <code>kube-system</code>. Cette valeur n'est valide que pour la source de journal de conteneur et est facultative. Si vous n'indiquez pas d'espace de nom, tous les espaces de nom du conteneur utilisent cette configuration.</td>
    </tr>
    <tr>
    <td><code>--hostname <em>&lt;ingestion_URL&gt;</em></code></td>
    <td>Remplacez <em>&lt;ingestion_URL&gt;</em> par l'URL d'ingestion {{site.data.keyword.loganalysisshort_notm}}. Vous trouverez [ici](/docs/services/CloudLogAnalysis/log_ingestion.html#log_ingestion_urls) la liste des URL d'ingestion disponibles. Si vous n'en indiquez aucune, le noeud final de la région où a été créé votre cluster est utilisé.</td>
    </tr>
    <tr>
    <td><code>--port <em>&lt;ingestion_port&gt;</em></code></td>
    <td>Remplacez <em>&lt;ingestion_port&gt;</em> par le port d'ingestion. Si vous n'en spécifiez pas un, le port standard, <code>9091</code>, est utilisé.</td>
    </tr>
    <tr>
    <td><code>--spaceName <em>&lt;cluster_space&gt;</em></code></td>
    <td>Remplacez <em>&lt;cluster_space&gt;</em> par le nom de l'espace où vous désirez envoyer les journaux. Si vous n'en spécifiez pas un, les journaux sont envoyés au niveau du compte.</td>
    </tr>
    <tr>
    <td><code>--orgName <em>&lt;cluster_org&gt;</em></code></td>
    <td>Remplacez <em>&lt;cluster_org&gt;</em> par le nom de l'organisation où réside votre espace. Cette valeur est obligatoire si vous avez spécifié un espace.</td>
    </tr>
    <tr>
    <td><code>--type ibm</code></td>
    <td>Type de journal pour l'envoi de journaux à {{site.data.keyword.loganalysisshort_notm}}.</td>
    </tr>
    </tbody></table>

  * Pour transférer les journaux vers un serveur syslog externe :

    ```
    bx cs logging-config-create <my_cluster> --logsource <my_log_source> --namespace <kubernetes_namespace> --hostname <log_server_hostname_or_IP> --port <log_server_port> --type syslog
    ```
    {: pre}

    <table>
    <caption>Tableau 11. Description des composantes de cette commande</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composantes de cette commande</th>
    </thead>
    <tbody>
    <tr>
    <td><code>logging-config-create</code></td>
    <td>Commande de création d'une configuration de transfert de journal syslog.</td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td>Remplacez <em>&lt;my_cluster&gt;</em> par le nom ou l'ID du cluster.</td>
    </tr>
    <tr>
    <td><code>--logsource <em>&lt;my_log_source&gt;</em></code></td>
    <td>Remplacez <em>&lt;my_log_source&gt;</em> par la source de journal. Valeurs admises : <code>container</code>, <code>application</code>, <code>worker</code>, <code>kubernetes</code> et <code>ingress</code>.</td>
    </tr>
    <tr>
    <td><code><em>&lt;kubernetes_namespace&gt;</em></code></td>
    <td>Remplacez <em>&lt;kubernetes_namespace&gt;</em> par l'espace de nom du conteneur Docker depuis lequel vous désirez réacheminer des journaux. Le transfert des journaux n'est pas pris en charge pour les espaces de nom Kubernetes <code>ibm-system</code> et <code>kube-system</code>. Cette valeur n'est valide que pour la source de journal de conteneur et est facultative. Si vous n'indiquez pas d'espace de nom, tous les espaces de nom du conteneur utilisent cette configuration.</td>
    </tr>
    <tr>
    <td><code>--hostname <em>&lt;log_server_hostname_or_IP&gt;</em></code></td>
    <td>Remplacez <em>&lt;log_server_hostname&gt;</em> par le nom d'hôte ou l'adresse IP du service de collecteur de journal.</td>
    </tr>
    <tr>
    <td><code>--port <em>&lt;log_server_port&gt;</em></code></td>
    <td>Remplacez <em>&lt;log_server_port&gt;</em> par le port du serveur collecteur de journal. Si vous n'indiquez pas de port, le port standard <code>514</code> est utilisé.</td>
    </tr>
    <tr>
    <td><code>--type syslog</code></td>
    <td>Type de journal pour envoi de journaux à un serveur syslog externe.</td>
    </tr>
    </tbody></table>

2. Vérifiez que la configuration de transfert des journaux a été créée.

    * Pour répertorier toutes les configurations de journalisation du cluster :
      ```
      bx cs logging-config-get <my_cluster>
      ```
      {: pre}

      Exemple de sortie :

      ```
      Id                                    Source       Namespace     Host                          Port   Org      Space      Protocol     Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  kubernetes   -             172.30.162.138                5514   -        -          syslog       /var/log/kubelet.log,/var/log/kube-proxy.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  application  -             ingest.logging.ng.bluemix.net 9091   my_org   my_space   ibm          /var/log/apps/**/*.log,/var/log/apps/**/*.err
      8a284f1a-451c-4c48-b1b4-a4e6b977264e  containers   my-namespace  myhostname.common             5514   -        -          syslog       -
      ```
      {: screen}

    * Pour répertorier les configurations de journalisation d'un type de source de journal :
      ```
      bx cs logging-config-get <my_cluster> --logsource worker
      ```
      {: pre}

      Exemple de sortie :

      ```
      Id                                    Source    Namespace   Host                            Port   Org    Space     Protocol    Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  worker    -           ingest.logging.ng.bluemix.net   9091   -      -         ibm         /var/log/syslog,/var/log/auth.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  worker    -           172.30.162.138                  5514   -      -         syslog      /var/log/syslog,/var/log/auth.log
      ```
      {: screen}

#### Activation du transfert de journaux pour des applications
{: #cs_apps_enable}

Les journaux issus d'applications doivent être cantonnés à un répertoire spécifique sur le noeud principal. Pour ce faire, montez un volume de chemin d'accès d'hôte sur vos conteneurs avec un chemin de montage. Ce chemin de montage sert de répertoire sur les conteneurs où sont envoyés les journaux d'application. Le répertoire de chemin d'accès d'hôte prédéfini, `/var/log/apps`, est automatiquement créé à la création du montage du volume.

Prenez connaissance des aspects suivants concernant le transfert de journaux d'application :
* Les journaux sont lus de façon récursive depuis le chemin /var/log/apps. Cela signifie que vous pouvez placer des journaux d'application dans des sous-répertoires du chemin /var/log/apps.
* Seuls les fichiers journaux d'application ayant l'extension `.log` ou `.err` sont transférés.
* Lorsque vous activez le transfert de journaux pour la première fois, les journaux d'application sont lus depuis la fin au lieu du début. Cela signifie que le contenu des journaux déjà présents avant activation du transfert de journaux n'est pas lu. Les journaux sont lus à partir du point où la consignation a été activée. Toutefois, après l'activation initiale du transfert de journaux, ceux-ci sont toujours prélevés à partir du point de dernier prélèvement.
* Lorsque vous montez le volume de chemin d'hôte `/var/log/apps` sur des conteneurs, ces derniers écrivent tous dans le même répertoire. Cela signifie que si vos conteneurs écrivent dans le même nom de fichier, il écriront dans exactement le même fichier sur l'hôte. Si cela ne vous convient pas, vous pouvez empêcher vos conteneurs de réécrire dans les mêmes fichiers journaux en nommant les fichiers journaux de chaque conteneur différemment.
* Etant donné que tous les conteneurs écrivent dans le même nom de fichier, n'utilisez pas cette méthode pour transférer des journaux d'application pour des jeux de répliques. Vous pouvez à la place consigner les journaux de l'application vers la sortie STDOUT et STDERR, lesquelles sont collectées comme journaux du conteneur. Pour transférer des journaux d'application consignés dans les sorties STDOUT et STDERR, suivez les étapes de la section [Activation du transfert des journaux](cs_cluster.html#cs_log_sources_enable).

Avant de commencer, [ciblez avec votre interface de ligne de commande](cs_cli_install.html#cs_cli_configure) le cluster où se trouve la source de journal.

1. Ouvrez le fichier de configuration `.yaml` du pod de l'application.

2. Ajoutez les éléments `volumeMounts` et `volumes` dans le fichier de configuration :

    ```
    apiVersion: v1
    kind: Pod
    metadata:
      name: <pod_name>
    containers:
    - name: fluentd
      image: "<your_registry_image>"
      volumeMounts:
        # Docker paths
          - mountPath: /var/log/my-app-log-files-directory
            name: app-log
    volumes:
    - name: app-log
      hostPath:
        path: /var/log/apps
    ```
    {: codeblock}

2. Montez le volume sur le pod.

    ```
    kubectl apply -f <local_yaml_path>
    ```
    {:pre}

3. Pour créer une configuration de transfert des journaux, suivez les étapes de la section [Activation du transfert des journaux](cs_cluster.html#cs_log_sources_enable).

### Mise à jour de la configuration d'acheminement de journal
{: #cs_log_sources_update}

Vous pouvez mettre à jour une configuration de journalisation pour un conteneur, une application, un noeud worker, un composant du système Kubernetes ou un équilibreur de charge d'application Ingress.
{: shortdesc}

Avant de commencer :

1. Si vous modifiez le serveur collecteur de journal en syslog, vous pouvez configurer un serveur qui accepte un protocole syslog de deux manières :
  * Configurer et gérer votre propre serveur ou confier la gestion du serveur à un fournisseur. Dans ce cas, obtenez le noeud final de journalisation du fournisseur de journalisation.
  * Exécuter syslog à partir d'un conteneur. Par exemple, vous pouvez utiliser ce [fichier de déploiement .yaml ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://github.com/IBM-Bluemix/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml) pour extraire une image publique Docker qui exécute un conteneur dans un cluster Kubernetes. L'image publie le port `514` sur l'adresse IP du cluster public et utilise cette adresse pour configurer l'hôte syslog.

2. [Ciblez avec votre interface de ligne de commande](cs_cli_install.html#cs_cli_configure) le cluster où se trouve la source de journal.

Pour modifier les détails d'une configuration de journalisation :

1. Mettez à jour la configuration de journalisation.

    ```
    bx cs logging-config-update <my_cluster> <log_config_id> --logsource <my_log_source> --hostname <log_server_hostname_or_IP> --port <log_server_port> --spaceName <cluster_space> --orgName <cluster_org> --type <logging_type>
    ```
    {: pre}

    <table>
    <caption>Tableau 12. Description des composantes de cette commande</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composantes de cette commande</th>
    </thead>
    <tbody>
    <tr>
    <td><code>logging-config-update</code></td>
    <td>Commande de mise à jour de la configuration de transfert des journaux pour votre source de journal.</td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td>Remplacez <em>&lt;my_cluster&gt;</em> par le nom ou l'ID du cluster.</td>
    </tr>
    <tr>
    <td><code><em>&lt;log_config_id&gt;</em></code></td>
    <td>Remplacez <em>&lt;log_config_id&gt;</em> par l'ID de la configuration de source de journal.</td>
    </tr>
    <tr>
    <td><code>--logsource <em>&lt;my_log_source&gt;</em></code></td>
    <td>Remplacez <em>&lt;my_log_source&gt;</em> par la source de journal. Valeurs admises : <code>container</code>, <code>application</code>, <code>worker</code>, <code>kubernetes</code> et <code>ingress</code>.</td>
    </tr>
    <tr>
    <td><code>--hostname <em>&lt;log_server_hostname_or_IP&gt;</em></code></td>
    <td>Si le type de journalisation correspond à <code>syslog</code>, remplacez <em>&lt;log_server_hostname_or_IP&gt;</em> par le nom d'hôte ou l'adresse IP du service de collecteur de journal. Si le type de journalisation correspond à <code>ibm</code>, remplacez <em>&lt;log_server_hostname&gt;</em> par l'URL d'ingestion {{site.data.keyword.loganalysislong_notm}}URL. Vous trouverez [ici](/docs/services/CloudLogAnalysis/log_ingestion.html#log_ingestion_urls) la liste des URL d'ingestion disponibles. Si vous n'en indiquez aucune, le noeud final de la région où a été créé votre cluster est utilisé.</td>
    </tr>
    <tr>
    <td><code>--port <em>&lt;log_collector_port&gt;</em></code></td>
    <td>Remplacez <em>&lt;log_server_port&gt;</em> par le port du serveur collecteur de journal. Si vous ne spécifiez pas de port, le port standard <code>514</code> est utilisé pour <code>syslog</code> et le port <code>9091</code> pour <code>ibm</code>.</td>
    </tr>
    <tr>
    <td><code>--spaceName <em>&lt;cluster_space&gt;</em></code></td>
    <td>Remplacez <em>&lt;cluster_space&gt;</em> par le nom de l'espace où vous désirez envoyer les journaux. Cette valeur est facultative et n'est valide que pour le type de journal <code>ibm</code>. Si vous ne spécifiez pas d'espace, les journaux sont envoyés au niveau du compte.</td>
    </tr>
    <tr>
    <td><code>--orgName <em>&lt;cluster_org&gt;</em></code></td>
    <td>Remplacez <em>&lt;cluster_org&gt;</em> par le nom de l'organisation où réside votre espace. Cette valeur n'est valide que pour le type de journal <code>ibm</code> et est obligatoire si vous avez spécifié un espace.</td>
    </tr>
    <tr>
    <td><code>--type <em>&lt;logging_type&gt;</em></code></td>
    <td>Remplacez <em>&lt;logging_type&gt;</em> par le nouveau protocole de transfert de journaux que vous voulez utiliser. Actuellement, <code>syslog</code> et <code>ibm</code> sont pris en charge.</td>
    </tr>
    </tbody></table>

2. Vérifiez que la configuration de transfert des journaux a été mise à jour.

    * Pour répertorier toutes les configurations de journalisation du cluster :

      ```
      bx cs logging-config-get <my_cluster>
      ```
      {: pre}

      Exemple de sortie :

      ```
      Id                                    Source       Namespace     Host                          Port   Org      Space      Protocol     Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  kubernetes   -             172.30.162.138                5514   -        -          syslog       /var/log/kubelet.log,/var/log/kube-proxy.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  application  -             ingest.logging.ng.bluemix.net 9091   my_org   my_space   ibm          /var/log/apps/**/*.log,/var/log/apps/**/*.err
      8a284f1a-451c-4c48-b1b4-a4e6b977264e  containers   my-namespace  myhostname.common             5514   -        -          syslog       -
      ```
      {: screen}

    * Pour répertorier les configurations de journalisation d'un type de source de journal :

      ```
      bx cs logging-config-get <my_cluster> --logsource worker
      ```
      {: pre}

      Exemple de sortie :

      ```
      Id                                    Source    Namespace   Host                            Port   Org    Space     Protocol    Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  worker    -           ingest.logging.ng.bluemix.net   9091   -      -         ibm         /var/log/syslog,/var/log/auth.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  worker    -           172.30.162.138                  5514   -      -         syslog      /var/log/syslog,/var/log/auth.log
      ```

      {: screen}

### Arrêt du transfert de journaux
{: #cs_log_sources_delete}

Vous pouvez arrêter de transférer les journaux en supprimant la configuration de journalisation.

Avant de commencer, [ciblez avec votre interface de ligne de commande](cs_cli_install.html#cs_cli_configure) le cluster où se trouve la source de journal.

1. Supprimez la configuration de journalisation.

    ```
    bx cs logging-config-rm <my_cluster> <log_config_id>
    ```
    {: pre}
    Remplacez <em>&lt;my_cluster&gt;</em> par le nom du cluster dans lequel se trouve la configuration de journalisation et <em>&lt;log_config_id&gt;</em> par l'ID de la configuration de source de journalisation

### Configuration du transfert de journaux pour les journaux d'audit d'API Kubernetes
{: #cs_configure_api_audit_logs}

Les journaux d'audit d'API Kubernetes cpaturent tous les appels au serveur d'API Kubernetes depuis votre cluster. Pour commencer à collecter les journaux d'audit d'API Kubernetes, vous pouvez configurer le serveur d'API Kubernetes afin de mettre en place un backend webhook pour votre cluster. Ce backend webhook permet aux journaux d'être envoyés à un serveur distant. Pour plus d'informations sur les journaux d'audit Kubernetes, reportez-vous à la the <a href="https://kubernetes.io/docs/tasks/debug-application-cluster/audit/" target="_blank">rubrique consacrée à l'audit <img src="../icons/launch-glyph.svg" alt="External link icon"></a> dans la documentation Kubernetes.

**Remarque **:
* L'acheminement des journaux d'audit d'API Kubernetes n'est pris en charge que pour Kubernetes version 1.7 et ultérieure.
* Actuellement, une règle d'audit pas défaut est utilisée pour tous les clusters avec cette configuration de journalisation.

#### Activation de l'acheminement de journal d'audit d'API Kubernetes
{: #cs_audit_enable}

Avant de commencer, [ciblez votre interface de ligne de commande (CLI)](cs_cli_install.html#cs_cli_configure) sur le cluster depuis lequel vous désirez collecter des journaux d'audit de serveur d'API.

1. Définissez le backend webhook pour la configuration de serveur d'API. Une configuration webhook est créé compte tenu des informations que vous soumettez dans les indicateurs de cette commande. Si vous ne soumettez pas d'informations dans les indicateurs, une configuration webhook par défaut est utilisée.

    ```
    bx cs apiserver-config-set audit-webhook <my_cluster> --remoteServer <server_URL_or_IP> --caCert <CA_cert_path> --clientCert <client_cert_path> --clientKey <client_key_path>
    ```
    {: pre}

    <table>
    <caption>Tableau 13. Description des composantes de cette commande</caption>
    <thead>
    <th colspan=2><img src="images/idea.png"/> Description des composantes de cette commande</th>
    </thead>
    <tbody>
    <tr>
    <td><code>apiserver-config-set</code></td>
    <td>Commande permettant de dédinir une option pour la configuration de serveur d'API Kubernetes du cluster.</td>
    </tr>
    <tr>
    <td><code>audit-webhook</code></td>
    <td>Sous-commande permetant de définir la configuration webhook d'audit pour le serveur d'API Kubernetes du cluster.</td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td>Remplacez <em>&lt;my_cluster&gt;</em> par le nom ou l'ID du cluster.</td>
    </tr>
    <tr>
    <td><code>--remoteServer <em>&lt;server_URL&gt;</em></code></td>
    <td>Remplacez <em>&lt;server_URL&gt;</em> par l'URL ou l'adresse IP du service de journalisation distant auquel vous désirez envoyer les journaux. Si vous indiquez une URL de serveur non sécurisée, les éventuels certificats sont ignorés. Si vous ne spécifiez pas d'URL ou d'adresse IP de serveur distant, une configuration QRadar par défaut est utilisée et les journaux sont envoyés à l'instance QRadar correspondant à la région où est situé le cluster.</td>
    </tr>
    <tr>
    <td><code>--caCert <em>&lt;CA_cert_path&gt;</em></code></td>
    <td>Remplacez <em>&lt;CA_cert_path&gt;</em> par le chemin de fichier du certificat d'autorité de certification utilisé pour vérifier le service de journalisation distant.</td>
    </tr>
    <tr>
    <td><code>--clientCert <em>&lt;client_cert_path&gt;</em></code></td>
    <td>Remplacez <em>&lt;client_cert_path&gt;</em> par le chemin de fichier du certificat client utilisé pour authentification vis à vis du service de journalisation distant.</td>
    </tr>
    <tr>
    <td><code>--clientKey <em>&lt;client_key_path&gt;</em></code></td>
    <td>Remplacez <em>&lt;client_key_path&gt;</em> par le chemin de fichier de la clé client correspondante utilisée pour connexion au service de journalisation distant.</td>
    </tr>
    </tbody></table>

2. Vérifiez que l'acheminement de journaux a été activé en examinant l'URL du service de journalisation distant.

    ```
    bx cs apiserver-config-get audit-webhook <my_cluster>
    ```
    {: pre}

    Exemple de sortie :
    ```
    OK
    Server:			https://8.8.8.8
    ```
    {: screen}

3. Appliquez la mise à jour de la configuration en redémarrant le maître Kubernetes.

    ```
    bx cs apiserver-refresh <my_cluster>
    ```
    {: pre}

#### Arrêt de l'acheminement de journaux d'audit d'API Kubernetes
{: #cs_audit_delete}

Vous pouvez cesser l'acheminement de journaux d'audit en désactivant la configuration de backend webhook pour le serveur d'API du cluster.

Avant de commencer, [ciblez votre interface de ligne de commande (CLI)](cs_cli_install.html#cs_cli_configure) sur le cluster depuis lequel vous désirez cesser de collecter des journaux d'audit de serveur d'API.

1. Désactivez la configuration de serveur dorsal webhook pour le serveur d'API du cluster. 

    ```
    bx cs apiserver-config-unset audit-webhook <my_cluster>
    ```
    {: pre}

2. Appliquez la mise à jour de la configuration en redémarrant le maître Kubernetes.

    ```
    bx cs apiserver-refresh <my_cluster>
    ```
    {: pre}

### Affichage des journaux
{: #cs_view_logs}

Pour afficher les journaux des clusters et des conteneurs, vous pouvez utiliser les fonctions de journalisation standard de Kubernetes et Docker.
{:shortdesc}

#### {{site.data.keyword.loganalysislong_notm}}
{: #cs_view_logs_k8s}

Pour les clusters standard, les journaux se trouvent dans le compte {{site.data.keyword.Bluemix_notm}} où vous vous êtes connecté lorsque vous avez créé le cluster Kubernetes. Si vous avez spécifié un espace {{site.data.keyword.Bluemix_notm}} lorsque vous avez créé le cluster ou la configuration de journalisation, les journaux sont situés dans cet espace. Les journaux sont surveillés et réacheminés depuis l'extérieur du conteneur. Vous pouvez accéder aux journaux d'un conteneur via le tableau de bord Kibana. Pour plus d'informations sur la journalisation, voir [Journalisation pour {{site.data.keyword.containershort_notm}}](/docs/services/CloudLogAnalysis/containers/containers_kubernetes.html#containers_kubernetes).

**Remarque **: si vous avez spécifié un espace lors de la création du cluster ou de la configuration de journalisation, le propriétaire du compte doit disposer des droits Responsable, Développeur ou Auditeur dans cet espace pour afficher les journaux. Pour plus d'informations sur la modification des {{site.data.keyword.containershort_notm}} droits et règles d'accès, voir [Gestion de l'accès au cluster](cs_cluster.html#cs_cluster_user). Une fois les droits modifiés, il peut s'écouler jusqu'à 24 heures avant que les journaux commencent à s'afficher.

Pour accéder au tableau de bord Kibana, accédez à l'une des URL suivantes et sélectionnez le compte ou l'espace {{site.data.keyword.Bluemix_notm}} dans lequel vous avez créé le cluster.
- Sud et Est des Etats-Unis : https://logging.ng.bluemix.net
- Sud du Royaume-Uni et Europe centrale : https://logging.eu-fra.bluemix.net
- Asie-Pacifique sud : https://logging.au-syd.bluemix.net

Pour plus d'informations sur l'affichage des journaux, voir [Accès à Kibana à partir d'un navigateur Web](/docs/services/CloudLogAnalysis/kibana/launch.html#launch_Kibana_from_browser).

#### Journaux Docker
{: #cs_view_logs_docker}

Vous pouvez exploiter les capacités de journalisation intégrées de Docker pour examiner les activités sur les flux de sortie
STDOUT et STDERR standard. Pour plus d'informations, voir [Affichage des journaux pour un conteneur s'exécutant dans un cluster Kubernetes](/docs/services/CloudLogAnalysis/containers/containers_kubernetes.html#containers_kubernetes).

<br />


## Configuration de la surveillance de cluster
{: #cs_monitoring}

Des métriques vous aident à surveiller l'état de santé et les performances de vos clusters. Vous pouvez configurer la surveillance de l'état de santé des noeuds d'agent de manière à détecter et à rectifier automatiquement tout agent dont l'état s'est dégradé ou qui n'est plus opérationnel. **Remarque** : la surveillance n'est prise en charge que pour les clusters standard.
{:shortdesc}

### Affichage des métriques
{: #cs_view_metrics}

Vous pouvez utiliser les fonctions standard de Kubernetes et Docker pour surveiller l'état de santé de vos clusters et de vos applications.
{:shortdesc}

<dl>
<dt>Page des informations détaillées sur le cluster dans {{site.data.keyword.Bluemix_notm}}</dt>
<dd>{{site.data.keyword.containershort_notm}} fournit des informations sur l'état de santé et la capacité de votre
cluster et sur l'utilisation de vos ressources de cluster. Vous pouvez utiliser cette page de l'interface graphique pour étendre votre cluster, gérer votre stockage persistant et ajouter des fonctionnalités supplémentaires à votre cluster via une liaison de service {{site.data.keyword.Bluemix_notm}}. Pour visualiser cette page, accédez à votre Tableau de bord **{{site.data.keyword.Bluemix_notm}}** et sélectionnez un cluster.</dd>
<dt>Tableau de bord Kubernetes</dt>
<dd>Le tableau de bord Kubernetes est une interface Web d'administration dans laquelle vous pouvez examiner l'état de santé de vos noeuds d'agent, rechercher des ressources Kubernetes, déployer des applications conteneurisées et résoudre les incidents liés aux applications à l'aide des informations des journaux et de surveillance. Pour plus d'informations sur l'accès à votre tableau de bord Kubernetes, voir [Lancement du tableau de bord Kubernetes pour {{site.data.keyword.containershort_notm}}](cs_apps.html#cs_cli_dashboard).</dd>
<dt>{{site.data.keyword.monitoringlong_notm}}</dt>
<dd>Les métriques des clusters standard se trouvent dans le compte {{site.data.keyword.Bluemix_notm}} connecté lorsque vous avez créé le cluster Kubernetes. Si vous avez spécifié un espace {{site.data.keyword.Bluemix_notm}} lorsque vous avez créé le cluster, les métriques se trouvent dans cet espace. Les métriques de conteneur sont collectées automatiquement pour tous les conteneurs déployés dans un cluster. Ces métriques sont envoyées et mises à disposition via Grafana. Pour plus d'informations sur les métriques, voir [Surveillance d'{{site.data.keyword.containershort_notm}}](/docs/services/cloud-monitoring/containers/monitoring_containers_ov.html#monitoring_bmx_containers_ov).<p>Pour accéder au tableau de bord Grafana, accédez à l'une des URL suivantes et sélectionnez le compte ou l'espace {{site.data.keyword.Bluemix_notm}} dans lequel vous avez créé le cluster.<ul><li>Sud et Est des Etats-Unis : https://metrics.ng.bluemix.net</li><li>Sud du Royaume-Uni : https://metrics.eu-gb.bluemix.net</li></ul></p></dd></dl>

#### Autres outils de surveillance de l'état de santé
{: #cs_health_tools}

Vous pouvez configurer d'autres outils pour disposer de capacités de surveillance supplémentaires.
<dl>
<dt>Prometheus</dt>
<dd>Prometheus est un outil open source de surveillance, de journalisation et d'alerte conçu pour Kubernetes. Cet outils extrait des informations détaillées sur le cluster, les noeuds d'agent et l'état de santé du déploiement à partir des informations de journalisation de Kubernetes. Pour obtenir des informations de configuration, voir [Intégration de services avec les {{site.data.keyword.containershort_notm}}](cs_planning.html#cs_planning_integrations).</dd>
</dl>

### Configuration de la surveillance de l'état de santé des noeuds d'agent avec le système de reprise automatique
{: #cs_configure_worker_monitoring}

Le système de reprise automatique d'{{site.data.keyword.containerlong_notm}} peut être déployé dans des clusters existants de Kubernetes version 1.7 ou ultérieure. Le système de reprise automatique effectue diverses vérifications pour obtenir l'état de santé des noeuds d'agent. Si le système de reprise automatique détecte un mauvais état de santé d'un noeud worker d'après les vérifications configurées, il déclenche une mesure corrective (par exemple, un rechargement du système d'exploitation) sur le noeud worker. Un seul noeud worker à la fois fait l'objet d'une mesure corrective. La mesure corrective doit réussir sur le noeud worker pour que d'autre noeuds d'agent bénéficient d'une mesure corrective. Pour plus d'informations, reportez-vous à cet [article du blogue Autorecovery ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/blogs/bluemix/2017/12/autorecovery-utilizes-consistent-hashing-high-availability/).
**REMARQUE** : Le système de reprise automatique nécessite qu'au moins un noeud worker soit opérationnel pour fonctionner correctement. Configurez le système de reprise automatique avec des vérifications actives uniquement dans les clusters contenant au moins deux noeuds d'agent.

Avant de commencer, [ciblez avec votre interface de ligne de commande](cs_cli_install.html#cs_cli_configure) le cluster dans lequel vous voulez vérifier les statuts des noeuds d'agent.

1. Créez un fichier de mappe de configuration qui définit vos vérifications au format JSON. Par exemple, le fichier YAML suivant définit trois vérifications : une vérification HTTP et deux vérifications de serveur d'API Kubernetes.

    ```
    kind: ConfigMap
    apiVersion: v1
    metadata:
      name: ibm-worker-recovery-checks
      namespace: kube-system
    data:
      checkhttp.json: |
        {
          "Check":"HTTP",
          "FailureThreshold":3,
          "CorrectiveAction":"REBOOT",
          "CooloffSeconds":1800,
          "IntervalSeconds":180,
          "TimeoutSeconds":10,
          "Port":80,
          "ExpectedStatus":200,
          "Route":"/myhealth",
          "Enabled":false
        }
      checknode.json: |
        {
          "Check":"KUBEAPI",
          "Resource":"NODE",
          "FailureThreshold":3,
          "CorrectiveAction":"RELOAD",
          "CooloffSeconds":1800,
          "IntervalSeconds":180,
          "TimeoutSeconds":10,
          "Enabled":false
        }
      checkpod.json: |
        {
          "Check":"KUBEAPI",
          "Resource":"POD",
          "PodFailureThresholdPercent":50,
          "FailureThreshold":3,
          "CorrectiveAction":"REBOOT",
          "CooloffSeconds":1800,
          "IntervalSeconds":180,
          "TimeoutSeconds":10,
          "Enabled":false
      }
    ```
    {:codeblock}

    <table>
    <caption>Tableau 14. Description des composants du fichier YAML</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code>name</code></td>
    <td>Le nom de configuration <code>ibm-worker-recovery-checks</code> est une constante et ne peut pas être modifié.</td>
    </tr>
    <tr>
    <td><code>espace de nom</code></td>
    <td>L'espace de nom <code>kube-system</code> est une constante et ne peut pas être modifié.</td>
    </tr>
    <tr>
    <tr>
    <td><code>Check</code></td>
    <td>Indiquez le type de vérification que le système de reprise automatique doit effectuer. <ul><li><code>HTTP</code> : La reprise automatique appelle les serveur HTTP qui s'exécutent sur chaque noeud afin de déterminer si les noeuds s'exécutent correctement.</li><li><code>KUBEAPI</code> : La reprise automatique appelle le serveur d'API Kubernetes et lit les données d'état de santé renvoyées par les noeuds d'agent.</li></ul></td>
    </tr>
    <tr>
    <td><code>Resource</code></td>
    <td>Lorsque le type de vérification est <code>KUBEAPI</code>, entrez le type de ressource que le système de reprise automatique doit vérifier. Les valeurs admises sont <code>NODE</code> ou <code>PODS</code>.</td>
    <tr>
    <td><code>FailureThreshold</code></td>
    <td>Indiquez le seuil du nombre consécutif d'échec de vérification. Lorsque ce seuil est atteint, le système de reprise automatique déclenche la mesure corrective spécifiée. Par exemple, si la valeur de seuil est 3 et qu'une vérification configurée de la reprise automatique échoue trois fois consécutivement, le système de reprise automatique déclenche la mesure corrective associée à la vérification.</td>
    </tr>
    <tr>
    <td><code>PodFailureThresholdPercent</code></td>
    <td>Lorsque le type de ressource est <code>PODS</code>, indiquez le seuil du pourcentage de pods sur un noeud worker pouvant présenter l'état [NotReady ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/#define-readiness-probes). Ce pourcentage se base sur le nombre total de pods planifiés d'un noeud worker. Lorsqu'une vérification détermine que le pourcentage de pods ayant un mauvais état de santé est supérieur au seuil spécifié, la vérification compte comme un échec.</td>
    </tr>
    <tr>
    <td><code>CorrectiveAction</code></td>
    <td>Indiquez l'action à exécuter lorsque le seuil d'échec est atteint. Une mesure corrective ne s'exécute que si aucun autre agent ne fait l'objet d'une réparation et si le noeud worker traité n'est pas hors fonction en raison d'une action précédente. <ul><li><code>REBOOT</code> : Réamorce le noeud worker.</li><li><code>RELOAD</code> : Recharge toutes les configurations requises pour le noeud worker à partir d'un système d'exploitation propre.</li></ul></td>
    </tr>
    <tr>
    <td><code>CooloffSeconds</code></td>
    <td>Indiquez le nombre de secondes que doit attendre la reprise automatique avant de lancer une autre mesure corrective pour un noeud qui a déjà fait l'objet d'une mesure corrective. Le délai d'attente commence au moment où la mesure corrective est émise.</td>
    </tr>
    <tr>
    <td><code>IntervalSeconds</code></td>
    <td>Indiquez l'intervalle en secondes entre chaque vérification. Par exemple, avec la valeur 180, la reprise automatique exécute une vérification sur chaque noeud toutes les 3 minutes.</td>
    </tr>
    <tr>
    <td><code>TimeoutSeconds</code></td>
    <td>Indiquez le nombre de secondes que prend un appel de vérification à la base de données avant que la reprise automatique mette fin à l'opération d'appel. La valeur de <code>TimeoutSeconds</code> doit être inférieure à la valeur de <code>IntervalSeconds</code>.</td>
    </tr>
    <tr>
    <td><code>Port</code></td>
    <td>Lorsque le type de vérification est <code>HTTP</code>, indiquez le port auquel le serveur HTTP doit se lier sur les noeuds d'agent. Ce port doit être exposé sur l'adresse IP de chaque noeud worker du cluster. La reprise automatique a besoin d'un numéro de port constant sur tous les noeuds pour vérifier les serveurs. Utilisez [DaemonSets ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/)lors du déploiement d'un serveur personnalisé dans un cluster.</td>
    </tr>
    <tr>
    <td><code>ExpectedStatus</code></td>
    <td>Lorsque le type de vérification est <code>HTTP</code>, indiquez le statut du serveur HTTP que la vérification doit renvoyer. Par exemple, la valeur 200 indique que vous escomptez une réponse <code>OK</code> du serveur.</td>
    </tr>
    <tr>
    <td><code>Route</code></td>
    <td>Lorsque le type de vérification est <code>HTTP</code>, indiquez le chemin demandé au serveur HTTP. Cette valeur correspond généralement au chemin des métriques du serveur qui s'exécute sur tous les noeuds d'agent.</td>
    </tr>
    <tr>
    <td><code>Enabled</code></td>
    <td>Entrez <code>true</code> pour activer la vérification ou <code>false</code> pour la désactiver.</td>
    </tr>
    </tbody></table>

2. Créez la mappe de configuration dans votre cluster.

    ```
    kubectl apply -f <my_file.yaml>
    ```
    {: pre}

3. Vérifiez que vous avez créé la mappe de configuration nommée `ibm-worker-recovery-checks` dans l'espace de nom `kube-system` avec les vérifications appropriées.

    ```
    kubectl -n kube-system get cm ibm-worker-recovery-checks -o yaml
    ```
    {: pre}

4. Vérifiez que vous avez créé une valeur confidentielle de commande docker pull nommée `international-registry-docker-secret` dans l'espace de nom `kube-system`. La reprise automatique est hébergée dans le registre Docker international de {{site.data.keyword.registryshort_notm}}. Si vous n'avez pas créé de valeur confidentielle de registre Docker contenant des données d'identification valides pour le registre international, créez-en un pour exécuter le système de reprise automatique.

    1. Installez le plug-in {{site.data.keyword.registryshort_notm}}.

        ```
        bx plugin install container-registry -r Bluemix
        ```
        {: pre}

    2. Ciblez le registre international.

        ```
        bx cr region-set international
        ```
        {: pre}

    3. Créez un jeton de registre international.

        ```
        bx cr token-add --non-expiring --description internationalRegistryToken
        ```
        {: pre}

    4. Définissez la variable d'environnement `INTERNATIONAL_REGISTRY_TOKEN` avec le jeton que vous avez créé.

        ```
        INTERNATIONAL_REGISTRY_TOKEN=$(bx cr token-get $(bx cr tokens | grep internationalRegistryToken | awk '{print $1}') -q)
        ```
        {: pre}

    5. Définissez la variable d'environnement `DOCKER_EMAIL` avec l'utilisateur en cours. Votre adresse électronique n'est requise que pour exécuter la commande `kubectl` à l'étape suivante.

        ```
        DOCKER_EMAIL=$(bx target | grep "User" | awk '{print $2}')
        ```
        {: pre}

    6. Créez la valeur confidentielle de la commande docker pull.

        ```
        kubectl -n kube-system create secret docker-registry international-registry-docker-secret --docker-username=token --docker-password="$INTERNATIONAL_REGISTRY_TOKEN" --docker-server=registry.bluemix.net --docker-email="$DOCKER_EMAIL"
        ```
        {: pre}

5. Déployez le système de reprise automatique dans votre cluster en appliquant ce fichier YAML.

   ```
   kubectl apply -f https://raw.githubusercontent.com/IBM-Bluemix/kube-samples/master/ibm-worker-recovery/ibm-worker-recovery.yml
   ```
   {: pre}

6. A bout de quelques minutes, vous pouvez vérifier la section `Events` dans la sortie de la commande suivante pour visualiser l'activité sur le déploiement du système de reprise automatique.

    ```
    kubectl -n kube-system describe deployment ibm-worker-recovery
    ```
    {: pre}

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

5.  Ouvrez votre navigateur Web sur l'adresse `http://localhost:4040`. Si les composants par défaut ne sont pas déployés, vous obtenez le diagramme suuivant. Vous pouvez choisir d'afficher des diagrammes de topologie ou bien des tableaux des ressources Kubernetes dans le cluster.

     <img src="images/weave_scope.png" alt="Exemple de topologie Weave Scope" style="width:357px;" />


[En savoir plus sur les fonctions Weave Scope ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://www.weave.works/docs/scope/latest/features/).

<br />


## Suppression de clusters
{: #cs_cluster_remove}

Lorsque vous avez fini d'utiliser un cluster, vous pouvez le supprimer afin qu'il ne consomme plus de ressources.
{:shortdesc}

Les clusters légers et standard créés avec un compte de type Paiement à la carte doivent être supprimés manuellement par l'utilisateur lorsque vous n'en avez plus besoin.

Lorsque vous supprimez un cluster, vous supprimez également les ressources sur le cluster, notamment les conteneurs, les pods, les services liés et les valeurs confidentielles. ISi vous ne supprimez pas l'espace de stockage lorsque vous supprimez votre cluster, vous pouvez le supprimer via le tableau de bord d'infrastructure IBM Cloud (SoftLayer) l'interface graphique {{site.data.keyword.Bluemix_notm}}. En raison du cycle de facturation mensuel, une réservation de volume persistant ne peut pas être supprimée le dernier jour du mois. Si vous supprimez la réservation de volume persistant le dernier jour du mois, la suppression reste en attente jusqu'au début du mois suivant.

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

Lorsque vous supprimez un cluster, vous pouvez supprimer les sous-réseaux portables et le stockage persistant associés au cluster :
- Les sous-réseaux sont utilisés pour affecter des adresses IP portables publiques aux services d'équilibreur de charge ou à votre contrôleur Ingress. Si vous les conservez, vous pouvez les réutiliser dans un nouveau cluster ou les supprimer manuellement ultérieurement de votre portefeuille d'infrastructure IBM Cloud (SoftLayer).
- Si vous avez créé une réservation de volume persistant via une commande (partage de fichiers existant)[#cs_cluster_volume_create], vous ne pouvez pas supprimer le partage de fichiers lorsque vous supprimez le cluster. Vous devez ultérieurement supprimer ce partage de fichiers manuellement de votre portefeuille d'infrastructure IBM Cloud (SoftLayer).
- Un stockage persistant procure une haute disponibilité à vos données. Si vous le supprimez, vous ne pouvez pas récupérer vos données.
