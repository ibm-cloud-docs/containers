---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-29"

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

<br />


## Installation de l'interface de ligne de commande
{: #cs_cli_install_steps}

Installez les interfaces CLI requises pour créer et gérer vos clusters Kubernetes dans {{site.data.keyword.containershort_notm}} et pour déployer des applications conteneurisées dans votre
cluster.
{:shortdesc}

Cette tâche inclut les informations relatives à l'installation de ces interfaces CLI et des plug-ins :

-   Interface CLI de {{site.data.keyword.Bluemix_notm}} version 0.5.0 ou ultérieure
-   Plug-in de {{site.data.keyword.containershort_notm}}
-   Interface CLI de Kubernetes, version 1.8.6 ou ultérieure
-   Facultatif : plug-in de {{site.data.keyword.registryshort_notm}}
-   Facultatif : Docker version 1.9 ou ultérieure

<br>
Pour installer les interfaces CLI, procédez comme suit :

1.  Comme condition prérequise pour le plug-in {{site.data.keyword.containershort_notm}}, installez l'[interface CLI de {{site.data.keyword.Bluemix_notm}} ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://clis.ng.bluemix.net/ui/home.html). Le préfixe pour l'exécution de commandes via l'interface CLI de {{site.data.keyword.Bluemix_notm}} est `bx`.

2.  Connectez-vous à l'interface CLI de {{site.data.keyword.Bluemix_notm}}. A l'invite, entrez vos données
d'identification {{site.data.keyword.Bluemix_notm}}.

    ```
    bx login
    ```
    {: pre}

    **Remarque :** si vous possédez un ID fédéré, exécutez la commande `bx login --sso` pour vous connecter à l'interface de ligne de commande {{site.data.keyword.Bluemix_notm}}. Entrez votre nom d'utilisateur et utilisez l'URL mentionnée dans la sortie CLI pour extraire votre code d'accès à usage unique. Si la connexion échoue alors que vous omettez l'option `--sso`
et aboutit en incluant l'option `--sso`, ceci indique que votre ID est fédéré.

3.  Pour créer des clusters Kubernetes et gérer les noeuds d'agent, installez le plug-in {{site.data.keyword.containershort_notm}}. Le préfixe pour l'exécution de commandes via le plug-in de {{site.data.keyword.containershort_notm}} est `bx`.

    ```
    bx plugin install container-service -r Bluemix
    ```
    {: pre}

    Pour vérifier que le plug-in a été correctement installé, exécutez la commande suivante :

    ```
    bx plugin list
    ```
    {: pre}

    Le plug-in {{site.data.keyword.containershort_notm}} est affiché dans les résultats en tant que container-service (service de conteneur).

4.  Pour afficher une version locale du tableau de bord Kubernetes et déployer des applications dans vos clusters, [installez l'interface CLI de Kubernetes ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/tasks/tools/install-kubectl/). Le préfixe pour l'exécution de commandes via l'interface CLI de Kubernetes est `kubectl`.

    1.  Pour obtenir la compatibilité fonctionnelle complète, téléchargez la version de l'interface CLI de Kubernetes qui correspond à la version du cluster Kubernetes que vous envisagez d'utiliser. La version {{site.data.keyword.containershort_notm}} actuelle par défaut de Kubernetes est la version 1.8.6.

        OS X :   [https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/darwin/amd64/kubectl ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/darwin/amd64/kubectl)

        Linux :   [https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/linux/amd64/kubectl ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/linux/amd64/kubectl)

        Windows :   [https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/windows/amd64/kubectl.exe ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/windows/amd64/kubectl.exe)

        **Astuce :** si vous utilisez Windows, installez l'interface CLI de Kubernetes dans le même répertoire que l'interface CLI de {{site.data.keyword.Bluemix_notm}}. Cette configuration vous évite diverses modifications de chemin de fichier lorsque vous exécuterez des commandes plus tard.

    2.  Utilisateurs OSX et Linux : procédez comme suit.
        1.  Déplacez le fichier exécutable vers le répertoire `/usr/local/bin`.

            ```
            mv /<path_to_file>/kubectl /usr/local/bin/kubectl
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

        3.  Rendez le fichier exécutable.

            ```
            chmod +x /usr/local/bin/kubectl
            ```
            {: pre}

5.  Pour gérer un référentiel d'images privé, installez le plug-in {{site.data.keyword.registryshort_notm}}. Utilisez ce plug-in pour mettre en place votre propre espace de nom dans un registre d'images privé à service partagé, haute disponibilité et évolutif, hébergé par IBM, et pour stocker et partager des images Docker avec d'autres utilisateurs. Des images Docker sont requises pour pouvoir déployer des conteneurs dans un cluster. Le préfixe pour l'exécution de commandes de registre est `bx cr`.

    ```
    bx plugin install container-registry -r Bluemix
    ```
    {: pre}

    Pour vérifier que le plug-in a été correctement installé, exécutez la commande suivante :

    ```
    bx plugin list
    ```
    {: pre}

    Le plug-in est affiché dans les résultats sous le nom container-registry.

6.  Pour générer des images locales et les envoyer par commande push vers votre espace de nom du registre, [installez Docker ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://www.docker.com/community-edition#/download). Si vous utilisez Windows 8 ou version antérieure, vous pouvez installer à la place la trousse [Docker Toolbox ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://docs.docker.com/toolbox/toolbox_install_windows/). L'interface CLI de Docker est utilisée pour générer des images d'applications. Le préfixe pour l'exécution de commandes via l'interface CLI de Docker est `docker`.

Ensuite, passez à l'étape [Création de clusters Kubernetes depuis l'interface CLI d'{{site.data.keyword.containershort_notm}}](cs_clusters.html#clusters_cli).

Pour des informations de référence sur ces interfaces de ligne de commande,
reportez-vous à la documentation relative à ces outils.

-   [Commandes `bx`](/docs/cli/reference/bluemix_cli/bx_cli.html)
-   [Commandes `bx cs`](cs_cli_reference.html#cs_cli_reference)
-   [Commandes `kubectl` ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands)
-   [Commandes `bx cr`](/docs/cli/plugins/registry/index.html)

<br />


## Configuration de l'interface CLI pour exécution de commandes `kubectl`
{: #cs_cli_configure}

Vous pouvez utiliser les commandes fournies avec l'interface de ligne de commande Kubernetes pour gérer les clusters dans {{site.data.keyword.Bluemix_notm}}. Toutes les commandes `kubectl` disponibles dans Kubernetes version 1.8.6 sont prises en charge pour leur utilisation avec des clusters dans {{site.data.keyword.Bluemix_notm}}. Après avoir créé un cluster, définissez le contexte de votre interface de ligne de commande locale vers ce cluster à l'aide d'une variable d'environnement. Vous pouvez ensuite exécuter les commandes Kubernetes `kubectl` pour utiliser votre cluster dans {{site.data.keyword.Bluemix_notm}}.
{:shortdesc}

Avant de pouvoir lancer des commandes `kubectl`, vous devez [installer les interfaces CLI requises](#cs_cli_install) et [créer un cluster](cs_clusters.html#clusters_cli).

1.  Connectez-vous à l'interface CLI de {{site.data.keyword.Bluemix_notm}}. A l'invite, entrez vos données d'identification {{site.data.keyword.Bluemix_notm}}. Pour stipuler une région {{site.data.keyword.Bluemix_notm}}, [incluez son noeud final d'API](cs_regions.html#bluemix_regions).

      ```
      bx login
      ```
      {: pre}

      **Remarque :** si vous possédez un ID fédéré, exécutez la commande `bx login --sso` pour vous connecter à l'interface de ligne de commande {{site.data.keyword.Bluemix_notm}}. Entrez votre nom d'utilisateur et utilisez l'URL mentionnée dans la sortie CLI pour extraire votre code d'accès à usage unique. Si la connexion échoue alors que vous omettez l'option `--sso`
et aboutit en incluant l'option `--sso`, ceci indique que votre ID est fédéré.

  2.  Sélectionnez un compte {{site.data.keyword.Bluemix_notm}}. Si vous êtes affecté à plusieurs organisations {{site.data.keyword.Bluemix_notm}}, sélectionnez celle dans laquelle le cluster a été créé. Les clusters sont spécifiques à une organisation, mais sont indépendants d'un espace {{site.data.keyword.Bluemix_notm}}. Vous n'avez donc pas besoin de sélectionner un espace.

  3.  Si vous désirez créer ou accéder à des clusters Kubernetes dans une région {{site.data.keyword.Bluemix_notm}} autre que celle que vous aviez sélectionnée auparavant, exécutez la commande `bx cs region-set`.

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
      Client Version: v1.8.6
      Server Version: v1.8.6
      ```
      {: screen}

Vous pouvez à présent exécuter des commandes `kubectl` pour gérer
vos clusters dans {{site.data.keyword.Bluemix_notm}}. Pour obtenir la liste complète des commandes, voir la [documentation Kubernetes![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands).

**Astuce :** si vous utilisez Windows et que l'interface CLI de Kubernetes n'est pas installée dans le même répertoire que l'interface CLI de {{site.data.keyword.Bluemix_notm}}, vous devez basculer entre les répertoires en spécifiant le chemin d'accès de l'installation de l'interface CLI de Kubernetes pour que l'exécution de `kubectl` puisse aboutir.


<br />


## Mise à jour de l'interface de ligne de commande
{: #cs_cli_upgrade}

Vous pouvez mettre régulièrement à jour les interfaces de ligne de commande
afin d'utiliser les nouvelles fonctions.
{:shortdesc}

Cette tâche inclut les informations pour la mise à jour de ces interfaces
CLI.

-   Interface CLI de {{site.data.keyword.Bluemix_notm}} version 0.5.0 ou ultérieure
-   Plug-in de {{site.data.keyword.containershort_notm}}
-   Interface CLI de Kubernetes, version 1.8.6 ou ultérieure
-   Plug-in de {{site.data.keyword.registryshort_notm}}
-   Docker version 1.9. ou ultérieure

<br>
Pour mettre à jour les interfaces de ligne de commande, procédez comme suit :

1.  Mettez à jour l'interface de ligne de commande
{{site.data.keyword.Bluemix_notm}}. Téléchargez la [version la plus récente ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://clis.ng.bluemix.net/ui/home.html) et exécutez le programme d'installation.

2. Connectez-vous à l'interface CLI de {{site.data.keyword.Bluemix_notm}}. A l'invite, entrez vos données d'identification {{site.data.keyword.Bluemix_notm}}. Pour stipuler une région {{site.data.keyword.Bluemix_notm}}, [incluez son noeud final d'API](cs_regions.html#bluemix_regions).

    ```
    bx login
    ```
    {: pre}

     **Remarque :** si vous possédez un ID fédéré, exécutez la commande `bx login --sso` pour vous connecter à l'interface de ligne de commande {{site.data.keyword.Bluemix_notm}}. Entrez votre nom d'utilisateur et utilisez l'URL mentionnée dans la sortie CLI pour extraire votre code d'accès à usage unique. Si la connexion échoue alors que vous omettez l'option `--sso`
et aboutit en incluant l'option `--sso`, ceci indique que votre ID est fédéré.

3.  Mettez à jour le plug-in {{site.data.keyword.containershort_notm}}.
    1.  Installez la mise à jour à partir du référentiel de plug-in {{site.data.keyword.Bluemix_notm}}.

        ```
        bx plugin update container-service -r Bluemix
        ```
        {: pre}

    2.  Vérifiez l'installation du plug-in en exécutant la commande suivante et en vérifiant la liste des
plug-in installés.

        ```
        bx plugin list
        ```
        {: pre}

        Le plug-in {{site.data.keyword.containershort_notm}} est affiché dans les résultats en tant que container-service (service de conteneur).

    3.  Initialisez l'interface CLI.

        ```
        bx cs init
        ```
        {: pre}

4.  Mettez à jour l'interface de ligne de commande Kubernetes.
    1.  Mettez à jour l'interface CLI de Kubernetes qui correspond à la version du cluster Kubernetes que vous envisagez d'utiliser. La version {{site.data.keyword.containershort_notm}} actuelle par défaut de Kubernetes est la version 1.8.6.

        OS X :   [https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/darwin/amd64/kubectl ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/darwin/amd64/kubectl)

        Linux :   [https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/linux/amd64/kubectl ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/linux/amd64/kubectl)

        Windows :   [https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/windows/amd64/kubectl.exe ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/windows/amd64/kubectl.exe)

        **Astuce :** si vous utilisez Windows, installez l'interface CLI de Kubernetes dans le même répertoire que l'interface CLI de {{site.data.keyword.Bluemix_notm}}. Cette configuration vous évite diverses modifications de chemin de fichier lorsque vous exécuterez des commandes plus tard.

    2.  Utilisateurs OSX et Linux : procédez comme suit.
        1.  Déplacez le fichier exécutable vers le répertoire `/usr/local/bin`.

            ```
            mv /<path_to_file>/kubectl /usr/local/bin/kubectl
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

        3.  Rendez le fichier exécutable.

            ```
            chmod +x /usr/local/bin/kubectl
            ```
            {: pre}

5.  Mettez à jour le plug-in {{site.data.keyword.registryshort_notm}}.
    1.  Installez la mise à jour à partir du référentiel de plug-in {{site.data.keyword.Bluemix_notm}}.

        ```
        bx plugin update container-registry -r Bluemix
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
    -   Si vous utilisez Docker Toolbox, téléchargez la [version la plus récente ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://docs.docker.com/toolbox/toolbox_install_windows/) et exécutez le programme d'installation.

<br />


## Désinstallation de l'interface de ligne de commande
{: #cs_cli_uninstall}

Si vous n'avez plus besoin de l'interface CLI, vous pouvez la désinstaller.
{:shortdesc}

Cette tâche inclut les informations relatives au retrait de ces interfaces CLI :


-   Plug-in de {{site.data.keyword.containershort_notm}}
-   Interface CLI de Kubernetes, version 1.8.6 ou ultérieure
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

    - [OSX ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://docs.docker.com/docker-for-mac/#uninstall-or-reset)
    - [Linux ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#uninstall-docker-ce)
    - [Windows ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://docs.docker.com/toolbox/toolbox_install_windows/#how-to-uninstall-toolbox)

<br />


## Automatisation des déploiements de cluster à l'aide de l'API
{: #cs_api}

Vous pouvez utiliser l'API {{site.data.keyword.containershort_notm}} pour automatiser la création le déploiement et la gestion de vos clusters Kubernetes.
{:shortdesc}

L'API {{site.data.keyword.containershort_notm}} requiert de fournir des informations d'en-tête dans votre demande d'API, lesquelles peuvent varier selon l'API à utiliser. Pour déterminer les informations d'en-tête requises pour votre API, voir la [documentation d'API {{site.data.keyword.containershort_notm}} ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://us-south.containers.bluemix.net/swagger-api).

**Remarque :** pour s'authentifier auprès d'{{site.data.keyword.containershort_notm}}, vous devez fournir un jeton IAM (Identity and Access Management) qui est généré avec vos données d'identification {{site.data.keyword.Bluemix_notm}} et qui comprend l'ID du compte {{site.data.keyword.Bluemix_notm}} dans lequel a été créé le cluster. Selon votre mode d'authentification auprès de {{site.data.keyword.Bluemix_notm}}, vous pouvez choisir parmi les options suivantes pour automatiser la création du jeton IAM.

<table>
<thead>
<th>ID {{site.data.keyword.Bluemix_notm}}</th>
<th>Mes options</th>
</thead>
<tbody>
<tr>
<td>ID non fédéré</td>
<td><ul><li><strong>Nom d'utilisateur et mot de passe {{site.data.keyword.Bluemix_notm}} :</strong> vous pouvez suivre la procédure indiquée dans cette rubrique pour automatiser complètement la création de votre jeton d'accès IAM.</li>
<li><strong>Générez une clé d'API {{site.data.keyword.Bluemix_notm}} :</strong> en guise d'alternative à l'utilisation du nom d'utilisateur et du mot de passe {{site.data.keyword.Bluemix_notm}}, vous pouvez <a href="../iam/apikeys.html#manapikey" target="_blank">utiliser des clés d'API {{site.data.keyword.Bluemix_notm}}</a>. Les clés d'API {{site.data.keyword.Bluemix_notm}} dépendent du compte {{site.data.keyword.Bluemix_notm}} pour lequel elles ont été générées. Vous ne pouvez pas combiner votre clé d'API {{site.data.keyword.Bluemix_notm}} avec un autre ID de compte dans le même jeton IAM. Pour accéder aux clusters créés avec un compte autre que celui sur lequel votre clé d'API {{site.data.keyword.Bluemix_notm}} est basée, vous devez vous connecter au compte pour générer une nouvelle clé d'API. </li></ul></tr>
<tr>
<td>ID fédéré</td>
<td><ul><li><strong>Générez une clé d'API {{site.data.keyword.Bluemix_notm}} :</strong> <a href="../iam/apikeys.html#manapikey" target="_blank"> les clés d'API {{site.data.keyword.Bluemix_notm}}</a> dépendent du compte {{site.data.keyword.Bluemix_notm}} pour lequel elles ont été générées. Vous ne pouvez pas combiner votre clé d'API {{site.data.keyword.Bluemix_notm}} avec un autre ID de compte dans le même jeton IAM. Pour accéder aux clusters créés avec un compte autre que celui sur lequel votre clé d'API {{site.data.keyword.Bluemix_notm}} est basée, vous devez vous connecter au compte pour générer une nouvelle clé d'API. </li><li><strong>Utilisez un code d'accès à usage unique : </strong> si vous vous authentifiez auprès de {{site.data.keyword.Bluemix_notm}} en utilisant un code d'accès à usage unique, vous ne pouvez pas automatiser complètement la création de votre jeton IAM car l'extraction de ce code d'accès nécessite une interaction manelle avec votre navigateur Web. Pour automatiser complètement la création de votre jeton IAM, vous devez créer une clé d'API {{site.data.keyword.Bluemix_notm}} à la place. </ul></td>
</tr>
</tbody>
</table>

1.  Créez votre jeton d'accès IAM (Identity and Access Management). Les informations de corps contenues dans votre demande varient en fonction de la méthode d'authentification {{site.data.keyword.Bluemix_notm}} que vous utilisez. Remplacez les valeurs suivantes :
  - _&lt;my_username&gt;_ : votre nom d'utilisateur {{site.data.keyword.Bluemix_notm}}.
  - _&lt;my_password&gt;_ : votre mot de passe {{site.data.keyword.Bluemix_notm}}.
  - _&lt;my_api_key&gt;_ : votre clé d'API {{site.data.keyword.Bluemix_notm}}.
  - _&lt;my_passcode&gt;_ : votre code d'accès à usage unique {{site.data.keyword.Bluemix_notm}}. Exécutez la commande `bx login --sso` et suivez les instructions de la sortie de l'interface CLI pour extraire votre code d'accès à usage unique en utilisant votre navigateur Web.

    ```
    POST https://iam.<region>.bluemix.net/oidc/token
    ```
    {: codeblock}

    Exemple :
    ```
    POST https://iam.ng.bluemix.net/oidc/token
    ```
    {: pre}

    Pour spécifier une région {{site.data.keyword.Bluemix_notm}}, [examinez les abréviations de régions utilisées dans les noeuds finaux d'API](cs_regions.html#bluemix_regions).

    <table summary-"Input parameters to get tokens">
    <thead>
        <th>Paramètres d'entrée</th>
        <th>Valeurs</th>
    </thead>
    <tbody>
    <tr>
    <td>En-tête</td>
    <td><ul><li>Content-Type:application/x-www-form-urlencoded</li> <li>Authorization: Basic Yng6Yng=<p><b>Remarque</b> : Yng6Yng= est fourni automatiquement ; il s'agit de l'autorisation en codage URL pour le nom d'utilisateur **bx** et le mot de passe **bx**.</p></li></ul>
    </td>
    </tr>
    <tr>
    <td>Corps pour le nom d'utilisateur et le mot de passe {{site.data.keyword.Bluemix_notm}}</td>
    <td><ul><li>grant_type: password</li>
    <li>response_type: cloud_iam, uaa</li>
    <li>username: <em>&lt;my_username&gt;</em></li>
    <li>password: <em>&lt;my_password&gt;</em></li>
    <li>uaa_client_id: cf</li>
    <li>uaa_client_secret:</li></ul>
    <p><b>Remarque</b> : ajoutez la clé uaa_client_secret sans spécifier de valeur.</p></td>
    </tr>
    <tr>
    <td>Corps pour les clés d'API {{site.data.keyword.Bluemix_notm}}</td>
    <td><ul><li>grant_type: urn:ibm:params:oauth:grant-type:apikey</li>
    <li>response_type: cloud_iam, uaa</li>
    <li>apikey: <em>&lt;my_api_key&gt;</em></li>
    <li>uaa_client_id: cf</li>
    <li>uaa_client_secret:</li></ul>
    <p><b>Remarque</b> : ajoutez la clé uaa_client_secret sans spécifier de valeur.</p></td>
    </tr>
    <tr>
    <td>Corps pour le code d'accès à usage unique {{site.data.keyword.Bluemix_notm}}</td>
    <td><ul><li>grant_type: urn:ibm:params:oauth:grant-type:passcode</li>
    <li>response_type: cloud_iam, uaa</li>
    <li>passcode: <em>&lt;my_passcode&gt;</em></li>
    <li>uaa_client_id: cf</li>
    <li>uaa_client_secret:</li></ul>
    <p><b>Remarque</b> : ajoutez la clé uaa_client_secret sans spécifier de valeur.</p></td>
    </tr>
    </tbody>
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

    Le jeton IAM figure dans la zone **access_token** de la sortie de votre API. Notez la valeur du jeton IAM pour extraire des informations d'en-tête supplémentaires dans les étapes suivantes.

2.  Extrayez l'ID du compte {{site.data.keyword.Bluemix_notm}} dans lequel a été créé le cluster. Remplacez _&lt;iam_token&gt;_ par le jeton IAM extrait à l'étape précédente.

    ```
    GET https://accountmanagement.<region>.bluemix.net/v1/accounts
    ```
    {: codeblock}

    <table summary="Paramètres d'entrée pour obtenir l'ID du compte {{site.data.keyword.Bluemix_notm}}">
    <thead>
  	<th>Paramètres d'entrée</th>
  	<th>Valeurs</th>
    </thead>
    <tbody>
  	<tr>
  		<td>En-têtes</td>
  		<td><ul><li>Content-Type: application/json</li>
      <li>Authorization: bearer &lt;iam_token&gt;</li>
      <li>Accept: application/json</li></ul></td>
  	</tr>
    </tbody>
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
            "guid": "<my_account_id>",
            "url": "/v1/accounts/<my_account_id>",
            "created_at": "2016-01-07T18:55:09.726Z",
            "updated_at": "2017-04-28T23:46:03.739Z",
            "origin": "BSS"
    ...
    ```
    {: screen}

    L'ID de votre compte {{site.data.keyword.Bluemix_notm}} figure dans la zone **resources/metadata/guid** de la sortie de votre API.

3.  Générez un nouveau jeton IAM comprenant vos données d'identification {{site.data.keyword.Bluemix_notm}} et l'ID du compte sur lequel a été créé le cluster. Remplacez _&lt;my_account_id&gt;_ par l'ID du compte {{site.data.keyword.Bluemix_notm}} extrait à l'étape précédente.

    **Remarque :** si vous utilisez une clé d'API {{site.data.keyword.Bluemix_notm}}, vous devez utiliser l'ID du compte {{site.data.keyword.Bluemix_notm}} pour lequel a été créée la clé d'API. Pour accéder aux clusters figurant dans un autre compte, connectez-vous à ce compte et créez une clé d'API {{site.data.keyword.Bluemix_notm}} basée sur ce compte.

    ```
    POST https://iam.<region>.bluemix.net/oidc/token
    ```
    {: codeblock}

    Exemple :
    ```
    POST https://iam.ng.bluemix.net/oidc/token
    ```
    {: pre}

    Pour spécifier une région {{site.data.keyword.Bluemix_notm}}, [examinez les abréviations de régions utilisées dans les noeuds finaux d'API](cs_regions.html#bluemix_regions).

    <table summary-"Input parameters to get tokens">
    <thead>
        <th>Paramètres d'entrée</th>
        <th>Valeurs</th>
    </thead>
    <tbody>
    <tr>
    <td>En-tête</td>
    <td><ul><li>Content-Type:application/x-www-form-urlencoded</li> <li>Authorization: Basic Yng6Yng=<p><b>Remarque</b> : Yng6Yng= est fourni automatiquement ; il s'agit de l'autorisation en codage URL pour le nom d'utilisateur **bx** et le mot de passe **bx**.</p></li></ul>
    </td>
    </tr>
    <tr>
    <td>Corps pour le nom d'utilisateur et le mot de passe {{site.data.keyword.Bluemix_notm}}</td>
    <td><ul><li>grant_type: password</li>
    <li>response_type: cloud_iam, uaa</li>
    <li>username: <em>&lt;my_username&gt;</em></li>
    <li>password: <em>&lt;my_password&gt;</em></li>
    <li>uaa_client_id: cf</li>
    <li>uaa_client_secret:</li>
    <li>bss_account: <em>&lt;my_account_id&gt;</em></li></ul>
    <p><b>Remarque</b> : ajoutez la clé uaa_client_secret sans spécifier de valeur.</p></td>
    </tr>
    <tr>
    <td>Corps pour les clés d'API {{site.data.keyword.Bluemix_notm}}</td>
    <td><ul><li>grant_type: urn:ibm:params:oauth:grant-type:apikey</li>
    <li>response_type: cloud_iam, uaa</li>
    <li>apikey: <em>&lt;my_api_key&gt;</em></li>
    <li>uaa_client_id: cf</li>
    <li>uaa_client_secret:</li>
    <li>bss_account: <em>&lt;my_account_id&gt;</em></li></ul>
    <p><b>Remarque</b> : ajoutez la clé uaa_client_secret sans spécifier de valeur.</p></td>
    </tr>
    <tr>
    <td>Corps pour le code d'accès à usage unique {{site.data.keyword.Bluemix_notm}}</td>
    <td><ul><li>grant_type: urn:ibm:params:oauth:grant-type:passcode</li>
    <li>response_type: cloud_iam, uaa</li>
    <li>passcode: <em>&lt;my_passcode&gt;</em></li>
    <li>uaa_client_id: cf</li>
    <li>uaa_client_secret:</li>
    <li>bss_account: <em>&lt;my_account_id&gt;</em></li></ul>
    <p><b>Remarque<b> : ajoutez la clé uaa_client_secret sans spécifier de valeur.</p></td>
    </tr>
    </tbody>
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

    Le jeton IAM figure dans la zone **access_token** et le jeton d'actualisation IAM dans la zone **refresh_token**.

4.  Répertoriez tous les clusters Kubernetes dans votre compte. Utilisez les informations extraites auparavant pour construire vos informations d'en-tête.

        ```
        GET https://containers.bluemix.net/v1/clusters
        ```
        {: codeblock}

        <table summary="Paramètres d'entrée pour gérer l'API">
        <thead>
        <th>Paramètres d'entrée</th>
        <th>Valeurs</th>
        </thead>
        <tbody>
        <tr>
        <td>En-tête</td>
        <td><ul><li>Authorization: bearer <em>&lt;iam_token&gt;</em></li>
        <li>X-Auth-Refresh-Token: <em>&lt;refresh_token&gt;</em></li></ul></td>
        </tr>
        </tbody>
        </table>

5.  Examinez la documentation de l'API [{{site.data.keyword.containershort_notm}} ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://containers.bluemix.net/swagger-api) pour la liste des API prises en charge.

<br />


## Actualisation des jetons d'accès IAM
{: #cs_api_refresh}

Chaque jeton d'accès IAM (Identity and Access Management) émis via l'API expire au bout d'une heure. Vous devez actualiser régulièrement votre jeton d'accès pour garantir l'accès à l'API {{site.data.keyword.containershort_notm}}.
{:shortdesc}

Avant de commencer, vérifiez que vous disposez d'un jeton d'actualisation IAM que vous pourrez utiliser pour réclamer un nouveau jeton d'accès. Si vous ne disposez pas d'un jeton d'actualisation, consultez la rubrique [Automatisation de la procédure de création et de gestion de cluster via l'API {{site.data.keyword.containershort_notm}}](#cs_api) pour extraire votre jeton d'accès.

Procédez comme suit si vous désirez actualiser votre jeton IAM.

1.  Générez un nouveau jeton d'accès IAM. Remplacez _&lt;iam_refresh_token&gt;_ par le jeton d'actualisation IAM que vous avez reçu lors de votre authentification auprès de {{site.data.keyword.Bluemix_notm}}.

    ```
    POST https://iam.bluemix.net/identity/token
    ```
    {: codeblock}

    <table summary="Paramètres d'entrée pour le nouveau jeton IAM">
    <thead>
    <th>Paramètres d'entrée</th>
    <th>Valeurs</th>
    </thead>
    <tbody>
    <tr>
    <td>En-tête</td>
    <td><ul><li>Content-Type: application/x-www-form-urlencoded</li>
    <li>Authorization: Basic Yng6Yng=<p><b>Remarque</b> : Yng6Yng= est fourni automatiquement ; il s'agit de l'autorisation en codage URL pour le nom d'utilisateur **bx** et le mot de passe **bx**.</p></li></ul></td>
    </tr>
    <tr>
    <td>Body</td>
    <td><ul><li>grant_type: refresh_token</li>
    <li>response_type: cloud_iam, uaa</li>
    <li>refresh_token: <em>&lt;iam_refresh_token&gt;</em></li>
    <li>uaa_client_id: cf</li>
    <li>uaa_client_secret:</li>
    <li>bss_account: <em>&lt;account_id&gt;</em></li></ul><p><b>Remarque</b> : ajoutez la clé uaa_client_secret sans spécifier de valeur.</p></td>
    </tr>
    </tbody>
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

2.  Continuez à travailler avec la [documentation d'API {{site.data.keyword.containershort_notm}}![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://us-south.containers.bluemix.net/swagger-api) en utilisant le jeton de l'étape précédente.
