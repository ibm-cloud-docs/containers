---

copyright:
  years: 2014, 2017
lastupdated: "2017-08-14"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Configuration de l'interface CLI et de l'API
{: #cs_cli_install}

Vous pouvez utiliser l'interface CLI ou l'API {{site.data.keyword.containershort_notm}} pour créer et gérer vos clusters Kubernetes.
{:shortdesc}

## Installation de l'interface de ligne de commande
{: #cs_cli_install_steps}

Installez les interfaces CLI requises pour créer et gérer vos clusters Kubernetes dans {{site.data.keyword.containershort_notm}} et pour déployer des applications conteneurisées dans votre
cluster.
{:shortdesc}

Cette tâche inclut les informations relatives à l'installation de ces interfaces CLI et des plug-ins :

-   Interface CLI de {{site.data.keyword.Bluemix_notm}} version 0.5.0 ou ultérieure
-   Plug-in de {{site.data.keyword.containershort_notm}}
-   Interface CLI de Kubernetes version 1.5.6 ou ultérieure
-   Facultatif : plug-in de {{site.data.keyword.registryshort_notm}}
-   Facultatif : Docker version 1.9. ou ultérieure

<br>
Pour installer les interfaces CLI, procédez comme suit :

1.  Comme condition prérequise pour le plug-in {{site.data.keyword.containershort_notm}}, installez l'[interface CLI de {{site.data.keyword.Bluemix_notm}} ![External link icon](../icons/launch-glyph.svg "External link icon")](https://clis.ng.bluemix.net/ui/home.html). Le préfixe pour l'exécution de commandes via l'interface CLI de {{site.data.keyword.Bluemix_notm}} est `bx`.

2.  Connectez-vous à l'interface CLI de {{site.data.keyword.Bluemix_notm}}. A l'invite, entrez vos données
d'identification {{site.data.keyword.Bluemix_notm}}.

    ```
    bx login
    ```
    {: pre}

    **Remarque :** si vous possédez un ID fédéré, exécutez la commande `bx login --sso` pour vous connecter à l'interface de ligne de commande {{site.data.keyword.Bluemix_notm}}. Entrez votre nom d'utilisateur et utilisez l'URL mentionnée dans la sortie CLI pour extraire votre code d'accès ponctuel. Si la connexion échoue alors que vous omettez l'option `--sso`
et aboutit en incluant l'option `--sso`, ceci indique que votre ID est fédéré.



4.  Pour créer des clusters Kubernetes et gérer les noeuds d'agent, installez le plug-in {{site.data.keyword.containershort_notm}}. Le préfixe pour l'exécution de commandes via le plug-in de {{site.data.keyword.containershort_notm}} est `bx`.

    ```
    bx plugin install container-service -r {{site.data.keyword.Bluemix_notm}}
    ```
    {: pre}

    Pour vérifier que le plug-in a été correctement installé, exécutez la commande suivante :

    ```
    bx plugin list
    ```
    {: pre}

    Le plug-in de {{site.data.keyword.containershort_notm}} est affiché dans les résultats sous le nom container-service. 

5.  Pour afficher une version locale du tableau de bord Kubernetes et déployer des applications dans vos clusters, [installez l'interface CLI de Kubernetes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/tasks/tools/install-kubectl/). Le préfixe pour l'exécution de commandes via l'interface CLI de Kubernetes est `kubectl`.

    1.  Téléchargez l'interface CLI de Kubernetes.

        OS X :   [https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/darwin/amd64/kubectl ![External link icon](../icons/launch-glyph.svg "External link icon")](https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/darwin/amd64/kubectl)

        Linux :   [https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/linux/amd64/kubectl ![External link icon](../icons/launch-glyph.svg "External link icon")](https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/linux/amd64/kubectl)

        Windows :   [https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/windows/amd64/kubectl.exe ![External link icon](../icons/launch-glyph.svg "External link icon")](https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/windows/amd64/kubectl.exe)

        **Astuce :** si vous utilisez Windows, installez l'interface CLI de Kubernetes dans le même répertoire que l'interface CLI de {{site.data.keyword.Bluemix_notm}}. Cette configuration vous évite diverses modifications de chemin de fichier lorsque vous exécuterez des commandes plus tard.

    2.  Utilisateurs OSX et Linux : procédez comme suit.
        1.  Déplacez le fichier exécutable vers le répertoire `/usr/local/bin`.

            ```
            mv /<path_to_file>/kubectl/usr/local/bin/kubectl
            ```
            {: pre}

        2.  Vérifiez que `/usr/local/bin` est listé dans votre variable système `PATH`. La variable `PATH` contient tous les répertoires où votre système d'exploitation peut trouver des fichiers exécutables. Les répertoires mentionnés dans la variable `PATH` ont des objets différents. `/usr/local/bin` stocke les fichiers exécutables de logiciels qui ne font pas partie du système d'exploitation et qui ont été installés manuellement par l'administrateur système.

            ```
            echo $PATH
            ```
            {: pre}

            Exemple de sortie d'interface CLI :

            ```
            /usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
            ```
            {: screen}

        3.  Convertissez le fichier binaire en exécutable.

            ```
            chmod +x /usr/local/bin/kubectl
            ```
            {: pre}

6.  Pour gérer un référentiel d'images privé, installez le plug-in {{site.data.keyword.registryshort_notm}}. Utilisez ce plug-in pour mettre en place votre propre espace de nom dans un registre d'images privé à service partagé, haute disponibilité et évolutif, hébergé par IBM, et pour stocker et partager des images Docker avec d'autres utilisateurs. Des images Docker sont requises pour pouvoir déployer des conteneurs dans un cluster. Le préfixe pour l'exécution de commandes de registre est `bx cr`. 

    ```
    bx plugin install container-registry -r {{site.data.keyword.Bluemix_notm}}
    ```
    {: pre}

    Pour vérifier que le plug-in a été correctement installé, exécutez la commande suivante :

    ```
    bx plugin list
    ```
    {: pre}

    Le plug-in est affiché dans les résultats sous le nom container-registry.

7.  Pour générer des images locales et les envoyer par commande push vers votre espace de nom du registre, [installez Docker ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.docker.com/community-edition#/download). Si vous utilisez Windows 8 ou version antérieure, vous pouvez installer à la place la trousse [Docker Toolbox ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.docker.com/products/docker-toolbox). L'interface CLI de Docker est utilisée pour générer des images d'applications. Le préfixe pour l'exécution de commandes via l'interface CLI de Docker est `docker`.

Ensuite, passez à l'étape [Création de clusters Kubernetes depuis l'interface CLI d'{{site.data.keyword.containershort_notm}}](cs_cluster.html#cs_cluster_cli).

Pour des informations de référence sur ces interfaces de ligne de commande,
reportez-vous à la documentation relative à ces outils.

-   [Commandes `bx`](/docs/cli/reference/bluemix_cli/bx_cli.html)
-   [Commandes `bx cs`](cs_cli_reference.html#cs_cli_reference)
-   [Commandes `kubectl` ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/user-guide/kubectl/v1.5/)
-   [Commandes `bx cr`](/docs/cli/plugins/registry/index.html#containerregcli)

## Configuration de l'interface CLI pour exécution de commandes `kubectl`
{: #cs_cli_configure}

Vous pouvez utiliser les commandes fournies avec l'interface de ligne de
commande Kubernetes pour gérer les clusters dans {{site.data.keyword.Bluemix_notm}}. Toutes les commandes `kubectl` disponibles dans Kubernetes 1.5.6 sont prises en charge pour utilisation avec des clusters dans {{site.data.keyword.Bluemix_notm}}. Après
avoir créé un cluster, définissez le contexte de votre interface de ligne de commande
locale vers ce cluster à l'aide d'une variable d'environnement. Vous pouvez ensuite
exécuter les commandes Kubernetes `kubectl` pour utiliser votre cluster
dans {{site.data.keyword.Bluemix_notm}}.
{:shortdesc}

Avant de pouvoir lancer des commandes `kubectl`, vous devez [installer les interfaces CLI requises](#cs_cli_install) et [créer un cluster](cs_cluster.html#cs_cluster_cli).

1.  Connectez-vous à l'interface CLI d'{{site.data.keyword.Bluemix_notm}}. A l'invite, entrez vos données
d'identification {{site.data.keyword.Bluemix_notm}}.

    ```
    bx login
    ```
    {: pre}

    Pour stipuler une région
{{site.data.keyword.Bluemix_notm}} spécifique, incluez son noeud final d'API. Si vous disposez d'images Docker privées stockées dans le registre de conteneurs d'une région
{{site.data.keyword.Bluemix_notm}} spécifique, ou des instances de service {{site.data.keyword.Bluemix_notm}} que vous avez déjà créées, connectez-vous à cette région pour accéder à vos images et services {{site.data.keyword.Bluemix_notm}}.

    La région {{site.data.keyword.Bluemix_notm}} à laquelle vous vous connectez détermine également la région où vous pouvez créer vos clusters Kubernetes, y compris les centres de données disponibles. Si vous ne spécifiez pas de région, vous êtes automatiquement connecté à la région la plus proche de vous. 
      -   Sud des Etats-Unis

          ```
          bx login -a api.ng.bluemix.net
          ```
          {: pre}

      -   Sydney

          ```
          bx login -a api.au-syd.bluemix.net
          ```
          {: pre}

      -   Allemagne

          ```
          bx login -a api.eu-de.bluemix.net
          ```
          {: pre}

      -   Royaume-Uni

          ```
          bx login -a api.eu-gb.bluemix.net
          ```
          {: pre}

    **Remarque :** si vous possédez un ID fédéré, exécutez la commande `bx login --sso` pour vous connecter à l'interface de ligne de commande {{site.data.keyword.Bluemix_notm}}. Entrez votre nom d'utilisateur et utilisez l'URL mentionnée dans la sortie CLI pour extraire votre code d'accès ponctuel. Si la connexion échoue alors que vous omettez l'option `--sso`
et aboutit en incluant l'option `--sso`, ceci indique que votre ID est fédéré.

2.  Sélectionnez un compte {{site.data.keyword.Bluemix_notm}}. i vous êtes affecté à plusieurs organisations
{{site.data.keyword.Bluemix_notm}},
sélectionnez celle dans laquelle le cluster a été créé. Les clusters sont spécifiques à une organisation, mais sont indépendants
de l'espace {{site.data.keyword.Bluemix_notm}}. Vous n'avez donc pas besoin de sélectionner un espace.

3.  Si vous souhaitez créer ou accéder à des clusters Kubernetes dans une région qui n'est pas la région {{site.data.keyword.Bluemix_notm}} sélectionnée plus tôt, spécifiez cette région. Par exemple, vous souhaiterez peut-être vous connecter à une autre région {{site.data.keyword.containershort_notm}} pour les raisons suivantes : 
   -   Vous avez créé des services {{site.data.keyword.Bluemix_notm}} ou des images Docker privées dans une région et vous souhaitez les utiliser avec {{site.data.keyword.containershort_notm}} dans une autre région. 
   -   Vous souhaitez accéder à un cluster dans une région différente de la région {{site.data.keyword.Bluemix_notm}} par défaut à laquelle vous êtes connecté. <br>
Sélectionnez l'un des noeuds finaux d'API suivants :
        - Sud des Etats-Unis :
          ```
          bx cs init --host https://us-south.containers.bluemix.net
          ```
          {: pre}

        - Sud du Royaume-Uni :
          ```
          bx cs init --host https://uk-south.containers.bluemix.net
          ```
          {: pre}

        - Centre Union Européenne :
          ```
          bx cs init --host https://eu-central.containers.bluemix.net
          ```
          {: pre}

        - AP-Sud :
          ```
          bx cs init --host https://ap-south.containers.bluemix.net
          ```
          {: pre}

4.  Répertoriez tous les clusters du compte pour obtenir le nom du cluster.

    ```
    bx cs clusters
    ```
    {: pre}

5.  Définissez le cluster que vous avez créé comme contexte de cette session. Effectuez ces étapes de configuration à chaque fois que vous utilisez votre cluster.
    1.  Obtenez la commande permettant de définir la variable d'environnement et téléchargez
les fichiers de configuration Kubernetes.

        ```
        bx cs cluster-config <cluster_name_or_id>
        ```
        {: pre}

        Une fois les fichiers de configuration téléchargés, une commande s'affiche ; elle vous
permet de définir le chemin vers le fichier de configuration Kubernetes local en tant que
variable d'environnement.

        Exemple :

        ```
        export KUBECONFIG=/Users/<user_name>/.bluemix/plugins/container-service/clusters/<cluster_name>/kube-config-prod-dal10-<cluster_name>.yml
        ```
        {: screen}

    2.  Copiez et collez la commande qui s'affiche sur votre terminal pour définir la
variable d'environnement `KUBECONFIG`.
    3.  Vérifiez que la variable d'environnement `KUBECONFIG` est
correctement définie.

        Exemple :

        ```
        echo $KUBECONFIG
        ```
        {: pre}

        Sortie :
        ```
        /Users/<user_name>/.bluemix/plugins/container-service/clusters/<cluster_name>/kube-config-prod-dal10-<cluster_name>.yml
        ```
        {: screen}

6.  Vérifiez que les commandes `kubectl` fonctionnent correctement avec votre cluster en vérifiant la version du serveur CLI de
Kubernetes.

    ```
    kubectl version  --short
    ```
    {: pre}

    Exemple de sortie :

    ```
    Client Version: v1.5.6
    Server Version: v1.5.6
    ```
    {: screen}


Vous pouvez à présent exécuter des commandes `kubectl` pour gérer
vos clusters dans {{site.data.keyword.Bluemix_notm}}. Pour obtenir la liste complète des commandes, voir la [documentation Kubernetes![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/user-guide/kubectl/v1.5/).

**Astuce :** si vous utilisez Windows et que l'interface CLI de Kubernetes n'est pas installée dans le même répertoire que l'interface CLI de {{site.data.keyword.Bluemix_notm}}, vous devez basculer entre les répertoires en spécifiant le chemin d'accès de l'installation de l'interface CLI de Kubernetes pour que l'exécution de `kubectl` puisse aboutir. 

## Mise à jour de l'interface de ligne de commande
{: #cs_cli_upgrade}

Vous pouvez mettre régulièrement à jour les interfaces de ligne de commande
afin d'utiliser les nouvelles fonctions.
{:shortdesc}

Cette tâche inclut les informations pour la mise à jour de ces interfaces
CLI.

-   Interface CLI de {{site.data.keyword.Bluemix_notm}} version 0.5.0 ou ultérieure
-   Plug-in de {{site.data.keyword.containershort_notm}}
-   Interface CLI de Kubernetes version 1.5.6 ou ultérieure
-   Plug-in de {{site.data.keyword.registryshort_notm}}
-   Docker version 1.9. ou ultérieure

<br>
Pour mettre à jour les interfaces de ligne de commande, procédez comme suit :
1.  Mettez à jour l'interface de ligne de commande
{{site.data.keyword.Bluemix_notm}}. Téléchargez la [version la plus récente ![External link icon](../icons/launch-glyph.svg "External link icon")](https://clis.ng.bluemix.net/ui/home.html) et exécutez le programme d'installation. 

2.  Connectez-vous à l'interface CLI de {{site.data.keyword.Bluemix_notm}}. A l'invite, entrez vos données
d'identification {{site.data.keyword.Bluemix_notm}}.

    ```
    bx login
    ```
     {: pre}

    Pour stipuler une région
{{site.data.keyword.Bluemix_notm}} spécifique, incluez son noeud final d'API. Si vous disposez d'images Docker privées stockées dans le registre de conteneurs d'une région
{{site.data.keyword.Bluemix_notm}} spécifique, ou des instances de service {{site.data.keyword.Bluemix_notm}} que vous avez déjà créées, connectez-vous à cette région pour accéder à vos images et services {{site.data.keyword.Bluemix_notm}}.

    La région {{site.data.keyword.Bluemix_notm}} à laquelle vous vous connectez détermine également la région où vous pouvez créer vos clusters Kubernetes, y compris les centres de données disponibles. Si vous ne spécifiez pas de région, vous êtes automatiquement connecté à la région la plus proche de vous. 

    -   Sud des Etats-Unis

        ```
        bx login -a api.ng.bluemix.net
        ```
        {: pre}

    -   Sydney

        ```
        bx login -a api.au-syd.bluemix.net
        ```
        {: pre}

    -   Allemagne

        ```
        bx login -a api.eu-de.bluemix.net
        ```
        {: pre}

    -   Royaume-Uni

        ```
        bx login -a api.eu-gb.bluemix.net
        ```
        {: pre}

        **Remarque :** si vous possédez un ID fédéré, exécutez la commande `bx login --sso` pour vous connecter à l'interface de ligne de commande {{site.data.keyword.Bluemix_notm}}. Entrez votre nom d'utilisateur et utilisez l'URL mentionnée dans la sortie CLI pour extraire votre code d'accès ponctuel. Si la connexion échoue alors que vous omettez l'option `--sso`
et aboutit en incluant l'option `--sso`, ceci indique que votre ID est fédéré.

3.  Mettez à jour le plug-in {{site.data.keyword.containershort_notm}}.
    1.  Installez la mise à jour à partir du référentiel de plug-in {{site.data.keyword.Bluemix_notm}}. 

        ```
        bx plugin update container-service -r {{site.data.keyword.Bluemix_notm}}
        ```
        {: pre}

    2.  Vérifiez l'installation du plug-in en exécutant la commande suivante et en vérifiant la liste des
plug-in installés.

        ```
        bx plugin list
        ```
        {: pre}

        Le plug-in d'{{site.data.keyword.containershort_notm}} est affiché dans les résultats sous le nom container-service. 

    3.  Initialisez l'interface CLI.

        ```
        bx cs init
        ```
        {: pre}

4.  Mettez à jour l'interface de ligne de commande Kubernetes.
    1.  Téléchargez l'interface CLI de Kubernetes.

        OS X :   [https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/darwin/amd64/kubectl ![External link icon](../icons/launch-glyph.svg "External link icon")](https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/darwin/amd64/kubectl)

        Linux :   [https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/linux/amd64/kubectl ![External link icon](../icons/launch-glyph.svg "External link icon")](https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/linux/amd64/kubectl)

        Windows :   [https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/windows/amd64/kubectl.exe ![External link icon](../icons/launch-glyph.svg "External link icon")](https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/windows/amd64/kubectl.exe)

        **Astuce :** si vous utilisez Windows, installez l'interface CLI de Kubernetes dans le même répertoire que l'interface CLI de {{site.data.keyword.Bluemix_notm}}. Cette configuration vous évite diverses modifications de chemin de fichier lorsque vous exécuterez des commandes plus tard.

    2.  Utilisateurs OSX et Linux : procédez comme suit.
        1.  Déplacez le fichier exécutable vers le répertoire /usr/local/bin. 

            ```
            mv /<path_to_file>/kubectl/usr/local/bin/kubectl
            ```
            {: pre}

        2.  Vérifiez que `/usr/local/bin` est listé dans votre variable système `PATH`. La variable `PATH` contient tous les répertoires où votre système d'exploitation peut trouver des fichiers exécutables. Les répertoires mentionnés dans la variable `PATH` ont des objets différents. `/usr/local/bin` stocke les fichiers exécutables de logiciels qui ne font pas partie du système d'exploitation et qui ont été installés manuellement par l'administrateur système.

            ```
            echo $PATH
            ```
            {: pre}

            Exemple de sortie d'interface CLI :

            ```
            /usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
            ```
            {: screen}

        3.  Convertissez le fichier binaire en exécutable.

            ```
            chmod +x /usr/local/bin/kubectl
            ```
            {: pre}

5.  Mettez à jour le plug-in {{site.data.keyword.registryshort_notm}}.
    1.  Installez la mise à jour à partir du référentiel de plug-in {{site.data.keyword.Bluemix_notm}}. 

        ```
        bx plugin update container-registry -r {{site.data.keyword.Bluemix_notm}}
        ```
        {: pre}

    2.  Vérifiez l'installation du plug-in en exécutant la commande suivante et en vérifiant la liste des
plug-in installés.

        ```
        bx plugin list
        ```
        {: pre}

        Le plug-in du registre s'affiche dans les résultats sous la forme container-registry.

6.  Mettez à jour Docker.
    -   Si vous utilisez Docker Community Edition, démarrez Docker, cliquez sur l'icône
**Docker**, puis sur **Check for updates**.
    -   Si vous utilisez Docker Toolbox, téléchargez la [version la plus récente ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.docker.com/products/docker-toolbox) et exécutez le programme d'installation. 

## Désinstallation de l'interface de ligne de commande
{: #cs_cli_uninstall}

Si vous n'avez plus besoin de l'interface CLI, vous pouvez la désinstaller.
{:shortdesc}

Cette tâche inclut les informations relatives au retrait de ces interfaces CLI :


-   Plug-in de {{site.data.keyword.containershort_notm}}
-   Interface CLI de Kubernetes version 1.5.6 ou ultérieure
-   Plug-in de {{site.data.keyword.registryshort_notm}}
-   Docker version 1.9. ou ultérieure

<br>
Pour désinstaller les interfaces CLI, procédez comme suit :

1.  Désinstallez le plug-in
{{site.data.keyword.containershort_notm}}.

    ```
    bx plugin uninstall container-service
    ```
    {: pre}

2.  Désinstallez le plug-in
{{site.data.keyword.registryshort_notm}}.

    ```
    bx plugin uninstall container-registry
    ```
    {: pre}

3.  Vérifiez que les plug-ins ont bien été désinstallés en exécutant la commande suivante et en examinant la liste des
plug-in installés.

    ```
    bx plugin list
    ```
    {: pre}

    Les plug-ins container-service et container-registry ne sont pas affichés dans les résultats. 





6.  Désinstallez Docker. Les instructions de désinstallation de Docker varient selon le système d'exploitation
utilisé.

    <table summary="Instructions de désinstallation de Docker propres au système d'exploitation">
<tr>
      <th>Système d'exploitation</th>
      <th>Lien</th>
     </tr>
     <tr>
      <td>OSX</td>
      <td>Choisissez de désinstaller Docker depuis [l'interface graphique ou la ligne de commande ![External link icon](../icons/launch-glyph.svg "External link icon")](https://docs.docker.com/docker-for-mac/#uninstall-or-reset)</td>
     </tr>
     <tr>
      <td>Linux</td>
      <td>Les instructions de désinstallation de Docker varient selon la distribution Linux utilisée. Pour désinstaller Docker for Ubuntu, voir [Uninstall Docker ![External link icon](../icons/launch-glyph.svg "External link icon")](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#uninstall-docker-ce). Utilisez ce lien pour rechercher des instructions sur la désinstallation de
pour d'autres distributions Linux en sélectionnant la vôtre dans la navigation.</td>
     </tr>
      <tr>
        <td>Windows</td>
        <td>Désinstallez la [boîte à outils Docker ![External link icon](../icons/launch-glyph.svg "External link icon")](https://docs.docker.com/toolbox/toolbox_install_mac/#how-to-uninstall-toolbox).</td>
      </tr>
    </table>

## Automatisation des déploiements de cluster à l'aide de l'API
{: #cs_api}

Vous pouvez utiliser l'API {{site.data.keyword.containershort_notm}} pour automatiser la création le déploiement et la gestion de vos clusters Kubernetes.
{:shortdesc}

L'API {{site.data.keyword.containershort_notm}} requiert de fournir des informations d'en-tête dans votre demande d'API, lesquelles peuvent varier selon l'API à utiliser. Pour déterminer les informations d'en-tête requises pour votre API, voir la [documentation d'API {{site.data.keyword.containershort_notm}} ![External link icon](../icons/launch-glyph.svg "External link icon")](https://us-south.containers.bluemix.net/swagger-api).

Les étapes suivantes fournissent des instructions sur la manière de récupérer ces informations d'en-tête, de manière à pouvoir les inclure dans votre demande d'API.

1.  Extrayez votre jeton d'accès IAM (Identity and Access Management). Le jeton d'accès IAM est requis pour vous connecter à
{{site.data.keyword.containershort_notm}}. Remplacez
_&lt;my_bluemix_username&gt;_ et _&lt;my_bluemix_password&gt;_ par vos données d'identification
{{site.data.keyword.Bluemix_notm}}.

    ```
    POST https://iam.<region>.bluemix.net/oidc/token
    ```
     {: pre}

    <table summary-"Paramètres d'entrée pour obtenir les jetons">
      <tr>
        <th>Paramètres d'entrée</th>
        <th>Valeurs</th>
      </tr>
      <tr>
        <td>En-tête</td>
        <td>
          <ul><li>Content-Type:application/x-www-form-urlencoded</li> <li>Authorization: Basic Yng6Yng=</li></ul>
        </td>
      </tr>
      <tr>
        <td>Body</td>
        <td><ul><li>grant_type: password</li>
        <li>response_type: cloud_iam, uaa</li>
        <li>username: <em>&lt;my_bluemix_username&gt;</em></li>
        <li>password: <em>&lt;my_bluemix_password&gt;</em></li>
        <li>uaa_client_id: cf</li>
        <li>uaa_client_secret:</li></ul>
        <p>**Remarque :** ajoutez la clé uaa_client_secret sans spécifier de valeur. </p></td>
      </tr>
    </table>

    Exemple de sortie d'API :

    ```
    {
    "access_token": "<iam_token>",
    "refresh_token": "<iam_refresh_token>",
    "uaa_token": "<uaa_token>",
    "uaa_refresh_token": "<uaa_refresh_token>",
    "token_type": "Bearer",
    "expires_in": 3600,
    "expiration": 1493747503
    }

    ```
    {: screen}

    Le jeton d'accès figure dans la zone
**access_token** et le jeton UAA dans la zone
**uaa_token** de la sortie d'API. Notez la valeur du jeton IAM et du jeton UAA pour extraire des informations d'en-tête supplémentaires dans les étapes suivantes.

2.  Extrayez l'ID du compte {{site.data.keyword.Bluemix_notm}} dans lequel vous désirez créer et gérer vos clusters. Remplacez _&lt;iam_token&gt;_ par le jeton IAM extrait à l'étape précédente.

    ```
    GET https://accountmanagement.<region>.bluemix.net/v1/accounts
    ```
    {: pre}

    <table summary="Paramètres d'entrée pour obtenir l'ID de compte Bluemix">
<tr>
    <th>Paramètres d'entrée</th>
    <th>Valeurs</th>
   </tr>
   <tr>
    <td>En-têtes</td>
    <td><ul><li>Content-Type: application/json</li>
      <li>Authorization: bearer &lt;iam_token&gt;</li>
      <li>Accept: application/json</li></ul></td>
   </tr>
    </table>

    Exemple de sortie d'API :

    ```
    {
      "total_results": 3,
      "total_pages": 1,
      "prev_url": null,
      "next_url": null,
      "resources":
        {
          "metadata": {
            "guid": "<my_bluemix_account_id>",
            "url": "/v1/accounts/<my_bluemix_account_id>",
            "created_at": "2016-01-07T18:55:09.726Z",
            "updated_at": "2017-04-28T23:46:03.739Z",
            "origin": "BSS"
    ...
    ```
    {: screen}

    L'ID de votre compte {{site.data.keyword.Bluemix_notm}} figure dans la zone
**resources/metadata/guid** de la sortie de votre API.

3.  Extrayez un nouveau jeton IAM incluant vos informations de compte {{site.data.keyword.Bluemix_notm}}. Remplacez
_&lt;my_bluemix_account_id&gt;_ par l'ID de votre compte {{site.data.keyword.Bluemix_notm}} extrait à l'étape précédente.

    **Remarque :** les jetons d'accès IAM expirent au bout d'une heure. Voir la rubrique [Actualisation de votre jeton d'accès IAM avec l'API](#cs_api_refresh) pour savoir comment actualiser votre jeton d'accès.

    ```
    POST https://iam.<region>.bluemix.net/oidc/token
    ```
    {: pre}

    <table summary="Paramètres d'entrée pour obtenir des jetons d'accès">
<tr>
      <th>Paramètres d'entrée</th>
      <th>Valeurs</th>
     </tr>
     <tr>
      <td>En-têtes</td>
      <td><ul><li>Content-Type: application/x-www-form-urlencoded</li>
        <li>Authorization: Basic Yng6Yng=</li></ul></td>
     </tr>
     <tr>
      <td>Body</td>
      <td><ul><li>grant_type: password</li><li>response_type: cloud_iam, uaa</li>
        <li>username: <em>&lt;my_bluemix_username&gt;</em></li>
        <li>password: <em>&lt;my_bluemix_password&gt;</em></li>
        <li>uaa_client_id: cf</li>
        <li>uaa_client_secret:<p>**Remarque :** ajoutez la clé uaa_client_secret sans spécifier de valeur. </p>
        <li>bss_account: <em>&lt;my_bluemix_account_id&gt;</em></li></ul></td>
     </tr>
    </table>

    Exemple de sortie d'API :

    ```
    {
      "access_token": "<iam_token>",
      "refresh_token": "<iam_refresh_token>",
      "uaa_token": "<uaa_token>",
      "uaa_refresh_token": "<uaa_refresh_token>",
      "token_type": "Bearer",
      "expires_in": 3600,
      "expiration": 1493747503
    }

    ```
    {: screen}

    Le jeton IAM figure dans la zone **access_token** et votre jeton d'actualisation IAM dans la zone
**refresh_token** de la sortie CLI.

4.  Extrayez l'ID de l'espace {{site.data.keyword.Bluemix_notm}} où vous désirez créer ou gérer votre cluster.
    1.  Extrayez le noeud final d'API pour accès à votre ID d'espace. Remplacez
_&lt;juaa_token&gt;_ par le jeton UAA extrait lors de la première étape.

        ```
        GET https://api.<region>.bluemix.net/v2/organizations
        ```
        {: pre}

        <table summary="Paramètres d'entrée pour extraire l'ID d'espace">
<tr>
          <th>Paramètres d'entrée</th>
          <th>Valeurs</th>
         </tr>
         <tr>
          <td>En-tête</td>
          <td><ul><li>Content-Type: application/x-www-form-urlencoded;charset=utf</li>
            <li>Authorization: bearer &lt;uaa_token&gt;</li>
            <li>Accept: application/json;charset=utf-8</li></ul></td>
         </tr>
        </table>

      Exemple de sortie d'API :

      ```
      {
            "metadata": {
              "guid": "<my_bluemix_org_id>",
              "url": "/v2/organizations/<my_bluemix_org_id>",
              "created_at": "2016-01-07T18:55:19Z",
              "updated_at": "2016-02-09T15:56:22Z"
            },
            "entity": {
              "name": "<my_bluemix_org_name>",
              "billing_enabled": false,
              "quota_definition_guid": "<my_bluemix_org_id>",
              "status": "active",
              "quota_definition_url": "/v2/quota_definitions/<my_bluemix_org_id>",
              "spaces_url": "/v2/organizations/<my_bluemix_org_id>/spaces",
      ...

      ```
      {: screen}

5.  Notez la sortie de la zone **spaces_url**.
6.  Extrayez l'ID de votre espace {{site.data.keyword.Bluemix_notm}} en utilisant le noeud final **spaces_url**.

      ```
      GET https://api.<region>.bluemix.net/v2/organizations/<my_bluemix_org_id>/spaces
      ```
      {: pre}

      Exemple de sortie d'API :

      ```
      {
            "metadata": {
              "guid": "<my_bluemix_space_id>",
              "url": "/v2/spaces/<my_bluemix_space_id>",
              "created_at": "2016-01-07T18:55:22Z",
              "updated_at": null
            },
            "entity": {
              "name": "<my_bluemix_space_name>",
              "organization_guid": "<my_bluemix_org_id>",
              "space_quota_definition_guid": null,
              "allow_ssh": true,
      ...
      ```
      {: screen}

      L'ID de votre espace {{site.data.keyword.Bluemix_notm}} figure dans la zone
**metadata/guid** de la sortie de votre API.

7.  Répertoriez tous les clusters Kubernetes dans votre compte. Utilisez les informations extraites auparavant pour construire vos informations d'en-tête.

    -   Sud des Etats-Unis

        ```
        GET https://us-south.containers.bluemix.net/v1/clusters
        ```
        {: pre}

    -   Sud du Royaume-Uni

        ```
        GET https://uk-south.containers.bluemix.net/v1/clusters
        ```
        {: pre}

    -   Centre Union Européenne

        ```
        GET https://eu-central.containers.bluemix.net/v1/clusters
        ```
        {: pre}

    -   AP-Sud

        ```
        GET https://ap-south.containers.bluemix.net/v1/clusters
        ```
        {: pre}

        <table summary="Paramètres d'entrée pour gérer l'API">
<thead>
          <th>Paramètres d'entrée</th>
          <th>Valeurs</th>
         </thead>
          <tbody>
         <tr>
          <td>En-tête</td>
            <td><ul><li>Authorization: bearer <em>&lt;iam_token&gt;</em></li></ul>
         </tr>
          </tbody>
        </table>

8.  Consultez la [documentation d'API {{site.data.keyword.containershort_notm}}![External link icon](../icons/launch-glyph.svg "External link icon")](https://us-south.containers.bluemix.net/swagger-api) pour obtenir la liste des API prises en charge. 

## Actualisation des jetons d'accès IAM
{: #cs_api_refresh}

Chaque jeton d'accès IAM (Identity and Access Management) émis via l'API expire au bout d'une heure. Vous devez actualiser régulièrement votre jeton d'accès pour garantir l'accès à l'API {{site.data.keyword.containershort_notm}}.
{:shortdesc}

Avant de commencer, vérifiez que vous disposez d'un jeton d'actualisation IAM que vous pourrez utiliser pour réclamer un nouveau jeton d'accès. Si vous ne disposez pas d'un jeton d'actualisation, consultez la rubrique [Automatisation de la procédure de création et de gestion de cluster via l'API {{site.data.keyword.containershort_notm}} API](#cs_api) pour extraire votre jeton d'accès. 

Procédez comme suit si vous désirez actualiser votre jeton IAM.

1.  Extrayez un nouveau jeton d'accès IAM. Remplacez _&lt;iam_refresh_token&gt;_ par le jeton d'actualisation
IAM que vous avez reçu lors de votre première authentification auprès de {{site.data.keyword.Bluemix_notm}}.

    ```
    POST https://iam.ng.bluemix.net/oidc/token
    ```
    {: pre}

    <table summary="Paramètres d'entrée pour le nouveau jeton IAM">
<tr>
      <th>Paramètres d'entrée</th>
      <th>Valeurs</th>
     </tr>
     <tr>
      <td>En-tête</td>
      <td><ul><li>Content-Type: application/x-www-form-urlencoded</li>
        <li>Authorization: Basic Yng6Yng=</li><ul></td>
     </tr>
     <tr>
      <td>Body</td>
      <td><ul><li>grant_type: refresh_token</li>
        <li>response_type: cloud_iam, uaa</li>
        <li>refresh_token: <em>&lt;iam_refresh_token&gt;</em></li>
        <li>uaa_client_id: cf</li>
        <li>uaa_client_secret:<p>**Remarque :** ajoutez la clé uaa_client_secret sans spécifier de valeur. </p></li><ul></td>
     </tr>
    </table>

    Exemple de sortie d'API :

    ```
    {
      "access_token": "<iam_token>",
      "refresh_token": "<iam_refresh_token>",
      "uaa_token": "<uaa_token>",
      "uaa_refresh_token": "<uaa_refresh_token>",
      "token_type": "Bearer",
      "expires_in": 3600,
      "expiration": 1493747503
    }

    ```
    {: screen}

    Votre nouveau jeton IAM figure dans la zone **access_token** et le jeton d'actualisation IAM dans la zone
**refresh_token** de la sortie d'API.

2.  Continuez à travailler avec la [documentation d'API {{site.data.keyword.containershort_notm}}![External link icon](../icons/launch-glyph.svg "External link icon")](https://us-south.containers.bluemix.net/swagger-api) en utilisant le jeton de l'étape précédente. 
