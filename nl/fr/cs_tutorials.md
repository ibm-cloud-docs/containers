---

copyright:
  years: 2014, 2017
lastupdated: "2017-08-17"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Tutoriels associés aux clusters
{: #cs_tutorials}

Ces tutoriels (ainsi que d'autres ressources) vous permettront de vous familiariser avec le service.
{:shortdesc}

## Tutoriel : Création de clusters
{: #cs_cluster_tutorial}

Déployez et gérez votre propre cluster
Kubernetes dans le cloud et automatisez le déploiement, l'opération la mise à l'échelle et la surveillance de vos applications conteneurisées dans un cluster de noeuds de traitement indépendants dénommés noeuds d'agent.
{:shortdesc}

Cette série de tutoriels illustre comment une entreprise fictive de relations publiques peut utiliser Kubernetes pour déployer une application conteneurisée dans {{site.data.keyword.Bluemix_short}} qui exploite Watson Tone Analyzer. L'entreprise PR utilise Watson Tone Analyzer pour analyser ses communiqués de presse et recevoir un retour d'informations sur le ton dans ses messages. Dans ce premier tutoriel, l'administrateur réseau de l'entreprise PR
met en place un cluster Kubernetes personnalisé qui constitue l'infrastructure de traitement pour l'application Watson Tone Analyzer de l'entreprise. Ce cluster est utilisé pour déployer et tester une version Hello World de l'application de l'entreprise PR.

### Objectifs

-   Création d'un cluster Kubernetes avec un noeud d'agent
-   Installation des interfaces CLI pour utilisation de l'API Kubernetes et la gestion des images Docker
-   Création d'un référentiel d'images privé dans IBM {{site.data.keyword.Bluemix_notm}} Container Registry pour y stocker vos images
-   Ajout du service {{site.data.keyword.Bluemix_notm}} Watson Tone Analyzer au cluster afin que n'importe quelle application dans le cluster puisse utiliser ce service

### Durée

25 minutes

### Public

Ce tutoriel est destiné aux développeurs de logiciel et aux administrateurs réseau qui n'ont encore jamais créé de cluster Kubernetes.

### Leçon 1 : Configuration de l'interface CLI
{: #cs_cluster_tutorial_lesson1}

Installez l'interface CLI d'{{site.data.keyword.containershort_notm}}, l'interface CLI
{{site.data.keyword.registryshort_notm}}, et leurs prérequis. Ces interfaces CLI sont utilisées dans des leçons ultérieures et sont requises pour gérer votre cluster Kubernetes depuis votre machine locale, pour créer des images pour leur déploiement en tant que conteneurs, et, dans un tutoriel plus lointain, déployer des applications dans le cluster.

Cette leçon inclut les informations nécessaires pour installer les interfaces CLI suivantes.

-   Interface CLI de {{site.data.keyword.Bluemix_notm}}
-   Plug-in de {{site.data.keyword.containershort_notm}}
-   Interface CLI de Kubernetes
-   Plug-in de {{site.data.keyword.registryshort_notm}}
-   Interface CLI de Docker


Pour installer les interfaces CLI, procédez comme suit :
1.  Le cas échéant, créez un compte [{{site.data.keyword.Bluemix_notm}} ![External link icon](../icons/launch-glyph.svg "External link icon")](https://console.ng.bluemix.net/registration/). Notez votre nom d'utilisateur et votre mot de passe car vous en aurez besoin par la suite.
2.  Comme condition prérequise pour le plug-in {{site.data.keyword.containershort_notm}}, installez l'[interface CLI de {{site.data.keyword.Bluemix_notm}} ![External link icon](../icons/launch-glyph.svg "External link icon")](https://clis.ng.bluemix.net/ui/home.html). Le préfixe pour l'exécution de commandes via l'interface CLI de {{site.data.keyword.Bluemix_notm}} est `bx`.
3.  Suivez les invites pour sélectionner un compte et une organisation {{site.data.keyword.Bluemix_notm}}. Les clusters sont associés à un compte, mais sont indépendants de l'organisation {{site.data.keyword.Bluemix_notm}} et de l'espace.

5.  Pour créer des clusters Kubernetes et gérer les noeuds d'agent, installez le plug-in {{site.data.keyword.containershort_notm}}. Le préfixe pour l'exécution de commandes via le plug-in de {{site.data.keyword.containershort_notm}} est `bx`.

    ```
    bx plugin install container-service -r {{site.data.keyword.Bluemix_notm}}
    ```
    {: pre}
6.  Connectez-vous à l'interface CLI d'{{site.data.keyword.Bluemix_notm}}. A l'invite, entrez vos données
d'identification {{site.data.keyword.Bluemix_notm}}.

    ```
    bx login
    ```
    {: pre}

    Pour stipuler une région
{{site.data.keyword.Bluemix_notm}} spécifique, incluez son noeud final d'API. Si vous disposez d'images Docker privées stockées dans le registre de conteneurs d'une région
{{site.data.keyword.Bluemix_notm}} spécifique, ou des instances de service {{site.data.keyword.Bluemix_notm}} que vous avez déjà créées, connectez-vous à cette région pour accéder à vos images et services {{site.data.keyword.Bluemix_notm}}.

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

    **Remarque :** si vous possédez un ID fédéré, exécutez la commande `bx login --sso` pour vous connecter à l'interface de ligne de commande {{site.data.keyword.Bluemix_notm}}. Entrez votre nom d'utilisateur et utilisez l'URL mentionnée dans la sortie CLI pour extraire votre code d'accès ponctuel. Si la connexion échoue alors que vous omettez l'option `--sso`
et aboutit en incluant l'option `--sso`, ceci indique que votre ID est fédéré.

7.  Si vous souhaitez créer un cluster Kubernetes dans une région qui n'est pas la région {{site.data.keyword.Bluemix_notm}} sélectionnée plus tôt, spécifiez cette région. Par exemple, vous avez créé des services {{site.data.keyword.Bluemix_notm}} ou des images Docker privées dans une région et vous souhaitez les utiliser avec {{site.data.keyword.containershort_notm}} dans une autre région. 

    Sélectionnez l'un des noeuds finaux d'API suivants :

    * Sud des Etats-Unis :

        ```
        bx cs init --host https://us-south.containers.bluemix.net
        ```
        {: pre}

    * Sud du Royaume-Uni :

        ```
        bx cs init --host https://uk-south.containers.bluemix.net
        ```
        {: pre}

    * Centre Union Européenne :

        ```
        bx cs init --host https://eu-central.containers.bluemix.net
        ```
        {: pre}

    * AP-Sud :

        ```
        bx cs init --host https://ap-south.containers.bluemix.net
        ```
        {: pre}

8.  Pour afficher une version locale du tableau de bord Kubernetes et déployer des applications dans vos clusters, [installez l'interface CLI de Kubernetes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/tasks/tools/install-kubectl/). Le préfixe pour l'exécution de commandes via l'interface CLI de Kubernetes est `kubectl`.
    1.  Téléchargez l'interface CLI de Kubernetes.

        OS X :   [https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/darwin/amd64/kubectl ![External link icon](../icons/launch-glyph.svg "External link icon")](https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/darwin/amd64/kubectl)

        Linux :   [https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/linux/amd64/kubectl ![External link icon](../icons/launch-glyph.svg "External link icon")](https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/linux/amd64/kubectl)

        Windows :   [https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/windows/amd64/kubectl.exe ![External link icon](../icons/launch-glyph.svg "External link icon")](https://storage.googleapis.com/kubernetes-release/release/v1.5.6/bin/windows/amd64/kubectl.exe)

          **Astuce :** si vous utilisez Windows, installez l'interface CLI de Kubernetes dans le même répertoire que l'interface CLI de {{site.data.keyword.Bluemix_notm}}. Cette configuration vous évite diverses modifications de chemin de fichier lorsque vous exécuterez des commandes plus tard.

    2.  Utilisateurs OSX et Linux : procédez comme suit.
        1.  Déplacez le fichier exécutable vers le répertoire `/usr/local/bin`.

            ```
            mv /<path_to_file>/kubectl /usr/local/bin/kubectl
            ```
            {: pre}

        2.  Vérifiez que /usr/local/bin figure dans votre variable système `PATH`. La variable `PATH` contient tous les répertoires où votre système d'exploitation peut trouver des fichiers exécutables. Les répertoires mentionnés dans la variable `PATH` ont des objets différents. /usr/local/bin stocke les fichiers exécutables de logiciels qui ne font pas partie du système d'exploitation et qui ont été installés manuellement par l'administrateur système.

            ```
            echo $PATH
            ```
            {: pre}

            La sortie de votre interface CLI sera similaire à ceci.

            ```
            /usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
            ```
            {: screen}

        3.  Convertissez le fichier binaire en fichier exécutable. 

            ```
            chmod +x /usr/local/bin/kubectl
            ```
            {: pre}

9. Pour configurer et gérer un référentiel d'images privé dans {{site.data.keyword.registryshort_notm}}, installez le plug-in d'{{site.data.keyword.registryshort_notm}}. Le préfixe pour l'exécution de commandes de registre est `bx cr`. 

    ```
    bx plugin install container-registry -r {{site.data.keyword.Bluemix_notm}}
    ```
    {: pre}

    Pour vérifier que les plug-ins container-service et container-registry sont correctement installés, exécutez la commande suivante 

    ```
    bx plugin list
    ```
    {: pre}

10. Pour générer des images locales et les envoyer par commande push vers votre référentiel d'images privé, [installez l'interface CLI de Docker CE ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.docker.com/community-edition#/download). Si vous utilisez Windows 8 ou version antérieure, vous pouvez installer à la place la trousse [Docker Toolbox ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.docker.com/products/docker-toolbox). 

Félicitations ! Vous avez correctement créé votre compte {{site.data.keyword.Bluemix_notm}} et avez installé les interfaces CLI utilisées dans les prochaines leçons et tutoriels. Accédez maintenant à votre cluster à l'aide de l'interface CLI et commencez à ajouter des services
{{site.data.keyword.Bluemix_notm}}.

### Leçon 2 : Configuration de votre environnement de cluster
{: #cs_cluster_tutorial_lesson2}

Créez votre cluster Kubernetes, configurez un registre d'images privé dans {{site.data.keyword.registryshort_notm}} et ajoutez des valeurs confidentielles à votre cluster afin que l'application puisse accéder au service {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzerfull}}. 

1.  Créez votre cluster Kubernetes léger. 

    ```
    bx cs cluster-create --name <pr_firm_cluster>
    ```
    {: pre}

    Un cluster léger est accompagné d'un noeud d'agent sur lequel déployer des nacelles de conteneurs. Le noeud d'agent est
l'hôte de traitement, généralement une machine virtuelle, sur lequel s'exécutent vos applications. en environnement de production, une application exécute des répliques de l'application diffusées entre plusieurs noeuds d'agent pour permettre une plus haute disponibilité de votre application.

    **Remarque :** la réservation de la machine du noeud d'agent
et la mise en place et allocation du cluster peuvent prendre jusqu'à 15 minutes. 

2.  Configurez votre référentiel d'images privé dans {{site.data.keyword.registryshort_notm}}
pour stocker de manière sécurisée et partager vos images Docker avec tous les utilisateurs du cluster. Un référentiel d'images privé dans {{site.data.keyword.Bluemix_notm}} est identifié par un espace de nom que vous configurez lors de cette étape. L'espace de nom est utilisé pour créer une URL unique vers votre référentiel d'images que vos développeurs peuvent utiliser pour accéder aux images Docker privées. Vous pouvez créer plusieurs espaces de nom dans votre compte pour regrouper et organiser vos images. Par exemple, vous pouvez créer un espace de nom pour chaque département, environnement, ou application.

    Dans cet exemple, l'entreprise PR désire créer un seul registre d'images dans {{site.data.keyword.registryshort_notm}} et spécifie donc _pr_firm_ comme nom d'espace dans lequel regrouper toutes les images de leur compte. Remplacez
_&lt;your_namespace&gt;_ par l'espace de nom de votre choix, sans rapport
avec ce tutoriel.

    ```
    bx cr namespace-add <your_namespace>
    ```
    {: pre}

3.  Avant de passer à l'étape suivante, vérifiez que le déploiement de votre noeud d'agent a abouti.

    ```
    bx cs workers <pr_firm_cluster>
    ```
     {: pre}

    Lorsque l'allocation de votre noeud d'agent a abouti, son statut passe à **Ready** et vous pouvez alors commencer à lier des services {{site.data.keyword.Bluemix_notm}} en vue de leur utilisation dans un tutoriel ultérieur.

    ```
    ID                                                 Public IP       Private IP       Machine Type   State    Status   
    kube-dal10-pafe24f557f070463caf9e31ecf2d96625-w1   169.48.131.37   10.177.161.132   free           normal    Ready   
    ```
    {: screen}

4.  Définissez le contexte de votre cluster dans l'interface CLI. Chaque fois que vous vous connectez à l'interface CLI du conteneur pour gérer vos clusters, vous devez lancer ces commandes pour définir le chemin d'accès au fichier de configuration du cluster par le biais d'une variable de session. L'interface CLI de Kubernetes utilise cette
variable pour localiser un fichier de configuration local et les certificats requis pour connexion au
cluster dans {{site.data.keyword.Bluemix_notm}}.

    1.  Obtenez la commande permettant de définir la variable d'environnement et téléchargez
les fichiers de configuration Kubernetes.

        ```
        bx cs cluster-config pr_firm_cluster
        ```
        {: pre}

        Une fois les fichiers de configuration téléchargés, une commande s'affiche ; elle vous
permet de définir le chemin vers le fichier de configuration Kubernetes local en tant que
variable d'environnement.

        Exemple pour OS X :

        ```
        export KUBECONFIG=/Users/<user_name>/.bluemix/plugins/container-service/clusters/pr_firm_cluster/kube-config-prod-dal10-pr_firm_cluster.yml
        ```
        {: screen}

    2.  Copiez et collez la commande qui s'affiche sur votre terminal pour définir la
variable d'environnement `KUBECONFIG`.

    3.  Vérifiez que la variable d'environnement `KUBECONFIG` est
correctement définie.

        Exemple pour OS X :

        ```
        echo $KUBECONFIG
        ```
        {: pre}

        Sortie :

        ```
        /Users/<user_name>/.bluemix/plugins/container-service/clusters/pr_firm_cluster/kube-config-prod-dal10-pr_firm_cluster.yml
        ```
        {: screen}

    4.  Vérifiez que les commandes `kubectl` fonctionnent correctement avec votre cluster en vérifiant la version du serveur CLI de
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

5.  Ajoutez le service {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} {{site.data.keyword.Bluemix_notm}} au cluster. Via les services {{site.data.keyword.Bluemix_notm}} (tels que {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}}), vous pouvez tirer parti dans vos applications des fonctionnalités que vous avez déjà développées.
Tout service {{site.data.keyword.Bluemix_notm}} lié au
cluster peut être utilisé par une application quelconque déployée dans ce cluster. Répétez les étapes ci-après pour chaque service {{site.data.keyword.Bluemix_notm}} que vous désirez utiliser avec vos applications.
    1.  Ajoutez le service {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} à votre compte {{site.data.keyword.Bluemix_notm}}. 

        **Remarque :** lorsque vous ajoutez le service {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} à votre compte, un message s'affiche pour indiquer que ce service n'est pas gratuit. Si vous modérez votre appel d'API, ce tutoriel n'est pas assujetti à des frais pour le service {{site.data.keyword.watson}}.  Vous pouvez [consulter les informations de tarification du service {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/watson/developercloud/tone-analyzer.html#pricing-block).

        ```
        bx service create tone_analyzer standard <mytoneanalyzer>
        ```
        {: pre}

    2.  Associez l'instance {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} à l'espace de nom Kubernetes `default` pour le cluster. Ensuite, vous pourrez créer vos propres espaces de nom pour gérer les accès utilisateur aux ressources Kubernetes resources, mais dans l'immédiat, utilisez l'espace de nom`default`. Les espaces de nom Kubernetes
sont différents de l'espace de nom du registre que vous avez créé auparavant.

        ```
        bx cs cluster-service-bind <pr_firm_cluster> default <mytoneanalyzer>
        ```
        {: pre}

        Sortie :

        ```
        bx cs cluster-service-bind <pr_firm_cluster> default <mytoneanalyzer>
        Binding service instance to namespace...
        OK
        Namespace: default
        Secret name: binding-mytoneanalyzer
        ```
        {: screen}

6.  Vérifiez que la valeur confidentielle Kubernetes a bien été créée dans votre espace de nom de cluster. Chaque service {{site.data.keyword.Bluemix_notm}} est défini par un fichier
JSON qui inclut des informations confidentielles sur le service, comme le nom de l'utilisateur,
son mot de passe et l'URL qu'utilise le conteneur pour accéder au service. Des valeurs confidentielles Kubernetes sont utilisées pour un stockage sécurisé de ces informations. Dans cet exemple, les valeurs confidentielles incluent les données d'identification pour accès à l'instance {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} allouée dans votre compte {{site.data.keyword.Bluemix_notm}}.

    ```
    kubectl get secrets --namespace=default
    ```
    {: pre}

    Sortie :

    ```
    NAME                       TYPE                                  DATA      AGE
    binding-mytoneanalyzer     Opaque                                1         1m
    bluemix-default-secret     kubernetes.io/dockercfg               1         1h
    default-token-kf97z        kubernetes.io/service-account-token   3         1h
    ```
    {: screen}


Parfait ! Vous avez créé et configuré le cluster et votre environnement local est prêt pour le déploiement d'applications dans le
cluster.

**Etape suivante ?**

* [Testez vos connaissances en répondant à un quiz !![External link icon](../icons/launch-glyph.svg "External link icon")](https://bluemix-quizzes.mybluemix.net/containers/cluster_tutorial/quiz.php)
* Essayez le [Tutoriel : Déploiement d'applications dans des clusters Kubernetes dans {{site.data.keyword.containershort_notm}}](#cs_apps_tutorial) pour déployer l'application de l'entreprise PR dans le cluster que vous avez créé. 

## Tutoriel : Déploiement d'applications dans des clusters
{: #cs_apps_tutorial}

Ce second tutoriel vous explique comment utiliser Kubernetes pour déployer une application conteneurisée qui optimise le service{{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} {{site.data.keyword.Bluemix_notm}}. L'entreprise PR utilise {{site.data.keyword.watson}} pour analyser ses communiqués de presse et recevoir un retour d'informations sur le ton dans ses messages. {:shortdesc}

Dans ce scénario, le développeur d'applications de l'entreprise PR déploie une version Hello World de l'application dans le cluster
Kubernetes créé par l'administrateur réseau au cours du [premier tutoriel](#cs_cluster_tutorial).

Chaque leçon explique comment déployer progressivement des versions plus compliquées de la même application. Le diagramme illustre les composants des déploiements de l'application du tutoriel, excepté la quatrième partie.

<a href="https://console.bluemix.net/docs/api/content/containers/images/cs_app_tutorial_roadmap.png">![Composants de la leçon](images/cs_app_tutorial_roadmap.png)</a>

Kubernetes utilise plusieurs types de ressources pour rendre vos applications opérationnelles dans des clusters. Dans Kubernetes, les déploiements et les services fonctionnent en tandem. Les déploiements incluent les définitions utilisées par l'application (par exemple, l'image à utiliser pour le conteneur et le port à exposer pour l'application). Lorsque vous créez un déploiement, une nacelle Kubernetes est créée pour chaque conteneur que vous avez défini dans le déploiement. Pour rendre votre application plus résiliente, vous pouvez définir plusieurs instances de la même application dans votre déploiement et
permettre à Kubernetes de créer automatiquement un jeu de répliques pour vous. Le jeu de répliques surveille les nacelles
et garantit que le nombre de nacelles désiré est en opération en tout temps. Si une nacelle ne répond plus, elle est recréée automatiquement.

Les services regroupent un ensemble de nacelles et fournissent une connexion réseau vers ces nacelles à d'autres services dans le cluster sans exposer l'adresse IP privée réelle de chaque nacelle. Vous pouvez utiliser les services Kubernetes pour rendre une application accessible à d'autres nacelles dans le cluster ou pour l'exposer sur Internet. Dans ce tutoriel, vous utiliserez un service Kubernetes pour accéder depuis Internet à votre application en opération en utilisant l'adresse IP publique affectée automatiquement à un noeud d'agent et un port public.

Pour rendre votre application encore plus disponible, dans les clusters standard, vous pouvez créer plusieurs noeuds d'agent, de manière à disposer encore d'un plus grand nombre de répliques de votre application. Cette tâche n'est pas couverte par le tutoriel, mais envisagez-la en vue d'améliorations futures de la disponibilité d'une application.

Une seule leçon couvre l'intégration du service
{{site.data.keyword.Bluemix_notm}} dans une
application, mais vous pouvez les utiliser qu'il s'agisse d'une application toute simple,
ou aussi complexe que vous pouvez imaginer.

### Objectifs

* Assimiler la terminologie Kubernetes de base
* Envoyer par commande push une image vers votre espace de nom du registre dans {{site.data.keyword.registryshort_notm}}
* Rendre une application accessible au public
* Déployer une instance unique d'une application dans un cluster à l'aide d'une commande Kubernetes et d'un script
* Déployer plusieurs instances d'une application dans des conteneurs recréés lors de la vérification de leur état de santé
* Déployer une application utilisant des fonctionnalités d'un service
{{site.data.keyword.Bluemix_notm}}

### Durée

40 minutes

### Publics

Développeurs de logiciels et administrateurs réseau n'ayant encore jamais déployé une application dans un cluster Kubernetes.

### Conditions
prérequises

[Tutoriel : Création de clusters Kubernetes dans {{site.data.keyword.containershort_notm}}](#cs_cluster_tutorial).

### Leçon 1 : Déploiement d'applications avec instance unique dans des clusters Kubernetes
{: #cs_apps_tutorial_lesson1}

Dans cette leçon, vous déployez une seule instance de l'application Hello World dans un cluster.

<a href="https://console.bluemix.net/docs/api/content/containers/images/cs_app_tutorial_components1.png">![Configuration de déploiement](images/cs_app_tutorial_components1.png)</a>


1.  Connectez-vous à l'interface CLI de {{site.data.keyword.Bluemix_notm}}. A l'invite, entrez vos données
d'identification {{site.data.keyword.Bluemix_notm}}.

    ```
    bx login
    ```
    {: pre}

    Pour stipuler une région
{{site.data.keyword.Bluemix_notm}} spécifique, incluez son noeud final d'API. Si vous disposez d'images Docker privées stockées dans le registre de conteneurs d'une région
{{site.data.keyword.Bluemix_notm}} spécifique, ou des instances de service {{site.data.keyword.Bluemix_notm}} que vous avez déjà créées, connectez-vous à cette région pour accéder à vos images et services {{site.data.keyword.Bluemix_notm}}.

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

    **Remarque :** si vous possédez un ID fédéré, exécutez la commande `bx login --sso` pour vous connecter à l'interface de ligne de commande {{site.data.keyword.Bluemix_notm}}. Entrez votre nom d'utilisateur et utilisez l'URL mentionnée dans la sortie CLI pour extraire votre code d'accès ponctuel. Si la connexion échoue alors que vous omettez l'option `--sso`
et aboutit en incluant l'option `--sso`, ceci indique que votre ID est fédéré.

2.  Définissez dans votre interface CLI le contexte du cluster.
    1.  Obtenez la commande permettant de définir la variable d'environnement et téléchargez
les fichiers de configuration Kubernetes.

        ```
        bx cs cluster-config <pr_firm_cluster>
        ```
        {: pre}

        Une fois les fichiers de configuration téléchargés, une commande s'affiche ; elle vous
permet de définir le chemin vers le fichier de configuration Kubernetes local en tant que
variable d'environnement.

        Exemple pour OS X :

        ```
        export KUBECONFIG=/Users/<user_name>/.bluemix/plugins/container-service/clusters/<pr_firm_cluster>/kube-config-prod-dal10-pr_firm_cluster.yml
        ```
        {: screen}

    2.  Copiez et collez la commande qui s'affiche sur votre terminal pour définir la
variable d'environnement `KUBECONFIG`.
    3.  Vérifiez que la variable d'environnement `KUBECONFIG` est
correctement définie.

        Exemple pour OS X :

        ```
        echo $KUBECONFIG
        ```
        {: pre}

        Sortie :

        ```
        /Users/<user_name>/.bluemix/plugins/container-service/clusters/<pr_firm_cluster>/kube-config-prod-dal10-pr_firm_cluster.yml
        ```
        {: screen}

    4.  Vérifiez que les commandes `kubectl` fonctionnent correctement avec votre cluster en vérifiant la version du serveur CLI de
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

3.  Lancez Docker.
    * Si vous utilisez Docker CE, aucune action n'est nécessaire.
    * Si vous utilisez Linux, reportez-vous à la [documentation Docker ![External link icon](../icons/launch-glyph.svg "External link icon")](https://docs.docker.com/engine/admin/) pour obtenir les instructions de lancement de Docker selon la distribution Linux que vous utilisez. 
    * Si vous utilisez Docker Toolbox sur Windows ou OSX, vous pouvez utiliser le programme Docker Quickstart Terminal,
lequel démarre Docker pour vous. Utilisez ce programme dans les prochaines étapes pour exécuter les commandes
Docker, puis revenez à l'interface CLI pour définir la variable de session `KUBECONFIG`. 
        * Si vous utilisez Docker QuickStart Terminal, exécutez à nouveau la commande de connexion à l'interface CLI de {{site.data.keyword.Bluemix_notm}}.

          ```
          bx login
          ```
          {: pre}

4.  Connectez-vous à l'interface CLI de {{site.data.keyword.registryshort_notm}}. 

    ```
    bx cr login
    ```
    {: pre}

    -   Si vous ne vous rappelez plus de votre espace de nom dans {{site.data.keyword.registryshort_notm}}, exécutez la commande suivante.

        ```
        bx cr namespace-list
        ```
        {: pre}

5.  Clonez ou téléchargez le code source de l'[application Hello world ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/IBM/container-service-getting-started-wt) dans votre répertoire utilisateur personnel.

    ```
    git clone https://github.com/IBM/container-service-getting-started-wt.git
    ```
    {: pre}

    Si vous avez téléchargé le référentiel, décompressez le fichier.

    Exemples :

    * Windows : `C:Users\<my_username>\container-service-getting-started-wt`
    * OS X : `/Users/<my_username>/container-service-getting-started-wt`

    Le référentiel contient trois versions de la même application, nommées `Stage1`, `Stage2` et `Stage3`. Chaque version contient les fichiers suivants :
    * `Dockerfile` : définitions de génération de l'image
    * `app.js` : application Hello World
    * `package.json` : métadonnées de l'application

6.  Accédez au premier répertoire de l'application, `Stage1`.

    ```
    cd <username_home_directory>/container-service-getting-started-wt/Stage1
    ```
    {: pre}

7.  Générez une image Docker incluant les fichiers d'application du répertoire `Stage1`. Si vous avez besoin de modifier l'application plus tard, répétez ces étapes pour créer une autre
version de l'image.

    1.  Générez l'image localement et indexez-la avec le nom et l'étiquette que vous désirez utiliser, ainsi que l'espace de nom que vous avez créé dans {{site.data.keyword.registryshort_notm}} lors du tutoriel précédent. Le balisage de l'image avec les informations de l'espace de nom indique à Docker où la commande push doit transférer l'image lors d'une étape ultérieure . Utilisez uniquement des caractères alphanumériques en minuscules ou des traits de soulignement (`_`) dans le nom de l'image. N'oubliez pas le point (`.`à la fin de la commande. Le signe point indique à
Docker de rechercher le Dockerfile et les artefacts de génération de l'image dans le répertoire actuel.

        ```
        docker build -t registry.<region>.bluemix.net/<namespace>/hello-world:1 .
        ```
        {: pre}

        Lorsque la génération est terminée, vérifiez qu'un message de réussite est bien affiché.

        ```
        Successfully built <image_id>
        ```
        {: screen}

    2.  Transférez l'image par commande push à votre espace de nom dans le registre.

        ```
        docker push registry.<region>.bluemix.net/<namespace>/hello-world:1
        ```
        {: pre}

        Sortie :

        ```
        The push refers to a repository [registry.<region>.bluemix.net/<namespace>/hello-world]
        ea2ded433ac8: Pushed
        894eb973f4d3: Pushed
        788906ca2c7e: Pushed
        381c97ba7dc3: Pushed
        604c78617f34: Pushed
        fa18e5ffd316: Pushed
        0a5e2b2ddeaa: Pushed
        53c779688d06: Pushed
        60a0858edcd5: Pushed
        b6ca02dfe5e6: Pushed
        1: digest: sha256:0d90cb73288113bde441ae9b8901204c212c8980d6283fbc2ae5d7cf652405
        43 size: 2398
        ```
        {: screen}

        Patientez jusqu'à ce que l'image ait été envoyée par la
commande push avant de passer à l'étape suivante.

    3.  Si vous avez utilisé Docker Quickstart Terminal, revenez à l'interface CLI que vous avez utilisée pour définir la variable de session
`KUBECONFIG`.

    4.  Vérifiez que l'ajout de l'image à votre espace de nom a abouti.

        ```
        bx cr images
        ```
        {: pre}

        Sortie :

        ```
        Listing images...

        REPOSITORY                                  NAMESPACE   TAG       DIGEST         CREATED        SIZE     VULNERABILITY STATUS
        registry.<region>.bluemix.net/<namespace>/hello-world   <namespace>   1   0d90cb732881   1 minute ago   264 MB   OK
        ```
        {: screen}

8.  Créez un déploiement Kubernetes intitulé _hello-world-deployment_ pour déployer l'application dans une nacelle de votre
cluster. Les déploiements sont utilisés pour gérer les nacelles, lesquelles contiennent des instances conteneurisées d'une application. Le déploiement
suivant déploie l'application dans une seule nacelle.

    ```
    kubectl run hello-world-deployment --image=registry.<region>.bluemix.net/<namespace>/hello-world:1
    ```
    {: pre}

    Sortie :

    ```
    deployment "hello-world-deployment" created
    ```
    {: screen}

    Vu qu'il ne crée qu'une seule
instance de l'application, ce déploiement est plus rapide que dans les leçons ultérieures où plusieurs
instances de l'application seront créées.

9.  Rendez l'application accessible au public en exposant le déploiement en tant que service NodePort. Les services mettent en réseau l'application. Comme le cluster n'a qu'un seul noeud d'agent et non plusieurs, un équilibrage de charge entre les noeuds d'agent n'est pas nécessaire. De la sorte, un NodePort peut être utilisé pour accorder aux utilisateurs externes un accès à l'application. Tout comme quand vous exposez un port pour une application Cloud Foundry, le NodePort que vous exposez est celui sur lequel le noeud d'agent est à l'écoute de trafic. Dans une étape ultérieure, vous identifierez quel NodePort a été affecté aléatoirement au service.

    ```
    kubectl expose deployment/hello-world-deployment --type=NodePort --port=8080 --name=hello-world-service --target-port=8080
    ```
    {: pre}

    Sortie :

    ```
    service "hello-world-service" exposed
    ```
    {: screen}

    <table>
    <table summary=\xe2\x80\x9cInformation about the expose command parameters.\xe2\x80\x9d>
    <caption>Tableau 1. Paramètres de commande</caption>
    <thead>
    <th colspan=2><img src="images/idea.png"/> Informations additionnelles sur les paramètres de la commande expose</th>
    </thead>
    <tbody>
    <tr>
    <td><code>expose</code></td>
    <td>Expose une ressource en tant que service Kubernetes et la rend disponible au public des utilisateurs.</td>
    </tr>
    <tr>
    <td><code>deployment/<em>&lt;hello-world-deployment&gt;</em></code></td>
    <td>Type et nom de la ressource à exposer avec ce service.</td>
    </tr>
    <tr>
    <td><code>--name=<em>&lt;hello-world-service&gt;</em></code></td>
    <td>Nom du service.</td>
    </tr>
    <tr>
    <td><code>--port=<em>&lt;8080&gt;</em></code></td>
    <td>Port à utiliser pour le service.</td>
    </tr>
    <tr>
    <td><code>--type=NodePort</code></td>
    <td>Type de service à créer.</td>
    </tr>
    <tr>
    <td><code>--target-port=<em>&lt;8080&gt;</em></code></td>
    <td>Port vers lequel le service achemine le trafic. En l'occurrence, le port cible est le même que le port du service, mais d'autres applications que vous créez pourraient utiliser des ports différents.</td>
    </tr>
    </tbody></table>

    Maintenant que la tâche de déploiement est terminée, vous pouvez examiner les résultats.

10. Pour tester votre application dans un navigateur, extrayez les informations requises pour composer l'URL.
    1.  Extrayez les informations sur le service pour déterminer quel NodePort a été affecté.

        ```
        kubectl describe service <hello-world-service>
        ```
        {: pre}

        Sortie :

        ```
        Name:                   hello-world-service
        Namespace:              default
        Labels:                 run=hello-world-deployment
        Selector:               run=hello-world-deployment
        Type:                   NodePort
        IP:                     10.10.10.8
        Port:                   <unset> 8080/TCP
        NodePort:               <unset> 30872/TCP
        Endpoints:              172.30.171.87:8080
        Session Affinity:       None
        No events.
        ```
        {: screen}

        Les NodePorts sont affectés aléatoirement lorsqu'ils sont générés par la commande `expose`,
mais sur la plage 30000 à 32767. Dans cet exemple, la valeur de NodePort est 30872.

    2.  Identifiez l'adresse IP publique du noeud d'agent dans le cluster.

        ```
        bx cs workers <pr_firm_cluster>
        ```
        {: pre}

        Sortie :

        ```
        Listing cluster workers...
        OK
        ID                                            Public IP        Private IP      Machine Type   State      Status
        dal10-pa10c8f571c84d4ac3b52acbf50fd11788-w1   169.47.227.138   10.171.53.188   free           normal    Ready
        ```
        {: screen}

11. Ouvre un navigateur et accédez à l'application via l'URL `http://
<IP_address>:<NodePort>`. En utilisant les valeurs de l'exemple, l'URL serait la suivante : `http://169.47.227.138:30872`. Lorsque vous entrez cette
URL dans un navigateur, le texte suivant apparaît.

    ```
    Hello World! Your app is up and running in a cluster!
    ```
    {: screen}

    Vous pouvez communiquer cette URL à un collègue pour qu'il l'essaye, ou bien l'entrer dans le navigateur de votre téléphone portable pour constater que l'application Hello World est réellement accessible au public.

12. Lancez le tableau de bord Kubernetes via le port par défaut (8001).
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
         {: pre}

13. Vous pouvez examiner dans l'onglet **Charges de travail** les ressources que vous avez créées. Lorsque vous avez fini d'explorer le tableau de bord Kubernetes, utilisez les touches CTRL+C pour quitter la commande `proxy`.


Félicitations ! Vous venez de déployer la première version de l'application.

Trop de commandes dans cette leçon ? Nous sommes bien d'accord. Que diriez-vous d'utiliser un script de configuration pour se charger d'une partie du travail à votre place ? Pour utiliser un script de configuration pour la seconde version de l'application et pour
promouvoir une plus haute disponibilité en déployant plusieurs instances de l'application, passez à la leçon suivante.

### Leçon 2 : Déploiement et mise à jour d'applications avec une plus haute disponibilité
{: #cs_apps_tutorial_lesson2}

Dans cette leçon, vous allez déployer trois instances de l'application Hello World dans un cluster pour assurer une plus haute disponibilité de l'application que dans la première version. Une plus haute disponibilité signifie que l'accès utilisateur est divisé entre les trois
instances. Lorsqu'un trop grand nombre d'utilisateurs tentent d'accéder à la même instance de l'application, ils peuvent être confrontés à des temps de réponse lents. L'existence de plusieurs instances peut induire des temps de réponse plus rapides pour vos utilisateurs. Dans cette leçon, vous découvrirez également comment des bilans de santé et des mises à jour des déploiements peuvent opérer avec
Kubernetes.


<a href="https://console.bluemix.net/docs/api/content/containers/images/cs_app_tutorial_components2.png">![Configuration de déploiement](images/cs_app_tutorial_components2.png)</a>


Comme défini dans le script de configuration, Kubernetes peut utiliser une vérification de la disponibilité pour déterminer si un conteneur dans une nacelle est en opération ou non. Ces vérifications peuvent, par exemple, identifier des interblocages, où une application est en opération, mais ne parvient pas à progresser. Le redémarrage d'un conteneur dans cette situation peut aider à
rendre l'application disponible malgré les bogues. Kubernetes utilise ensuite une vérification de l'état de préparation du conteneur pour déterminer quand il est à nouveau prêt à accepter le trafic. Une nacelle est considérée comme prête quand son conteneur est lui-même prêt. Une fois la nacelle prête, elle est redémarrée. Dans l'application Stage2, le délai d'attente de l'application expire toutes les 15 secondes. Lorsqu'un bilan de santé est configuré dans le script de configuration, les conteneurs sont recréés si cette vérification détecte un problème affectant une application.

1.  Dans une interface CLI, accédez au second répertoire d'application, `Stage2`. Si vous utilisez Docker Toolbox pour Windows ou OS X, utilisez le programme Docker Quickstart
Terminal.

  ```
  cd <username_home_directory>/container-service-getting-started-wt/Stage2
  ```
  {: pre}

2.  Générez et indexez la seconde version de l'application localement en tant qu'image. Ici aussi, n'oubliez pas le point (`.`) à la fin de la commande.

  ```
  docker build -t registry.<region>.bluemix.net/<namespace>/hello-world:2 .
  ```
  {: pre}

  Vérifiez qu'un message de réussite est bien affiché.

  ```
  Successfully built <image_id>
  ```
  {: screen}

3.  Envoyez par commande push la seconde version de l'image à votre espace de nom du registre. Patientez jusqu'à ce que l'image ait été envoyée par la
commande push avant de passer à l'étape suivante.

  ```
  docker push registry.<region>.bluemix.net/<namespace>/hello-world:2
  ```
  {: pre}

  Sortie :

  ```
  The push refers to a repository [registry.<region>.bluemix.net/<namespace>/hello-world]
  ea2ded433ac8: Pushed
  894eb973f4d3: Pushed
  788906ca2c7e: Pushed
  381c97ba7dc3: Pushed
  604c78617f34: Pushed
  fa18e5ffd316: Pushed
  0a5e2b2ddeaa: Pushed
  53c779688d06: Pushed
  60a0858edcd5: Pushed
  b6ca02dfe5e6: Pushed
  1: digest: sha256:0d90cb73288113bde441ae9b8901204c212c8980d6283fbc2ae5d7cf652405
  43 size: 2398
  ```
  {: screen}

4.  Si vous avez utilisé Docker Quickstart Terminal, revenez à l'interface CLI que vous avez utilisée pour définir la variable de session
`KUBECONFIG`.
5.  Vérifiez que l'ajout de l'image à votre espace de nom du registre a abouti.

    ```
    bx cr images
    ```
     {: pre}

    Sortie :

    ```
    Listing images...

    REPOSITORY                                 NAMESPACE  TAG  DIGEST        CREATED        SIZE     VULNERABILITY STATUS
    registry.<region>.bluemix.net/<namespace>/hello-world  <namespace>  1    0d90cb732881  30 minutes ago 264 MB   OK
    registry.<region>.bluemix.net/<namespace>/hello-world  <namespace>  2    c3b506bdf33e  1 minute ago   264 MB   OK
    ```
    {: screen}

6.  Ouvrez le fichier `<username_home_directory>/container-service-getting-started-wt/Stage2/healthcheck.yml` dans un éditeur de texte. Ce script de configuration agrège quelques étapes de la leçon précédente pour créer en même temps un déploiement et un
service. Les développeurs d'application de l'entreprise PR peuvent utiliser ces scripts lors de mises à jour ou pour
traiter les incidents en recréant les nacelles.

    1.  Dans la section **Deployment**, observez la valeur de `replicas`. la valeur de replicas désigne le nombre d'instances de votre application. L'exécution de trois instances assure une plus haute disponibilité de votre application qu'une seule
instance.

        ```
        replicas: 3
        ```
        {: pre}

    2.  Mettez à jour les informations de l'image dans votre espace de nom du registre privé.

        ```
        image: "registry.<region>.bluemix.net/<namespace>/hello-world:2"
        ```
        {: pre}

    3.  Notez la sonde HTTP liveness qui effectue un bilan de santé du conteneur toutes les 5 secondes.

        ```
        livenessProbe:
                    httpGet:
                      path: /healthz
                      port: 8080
                    initialDelaySeconds: 5
                    periodSeconds: 5
        ```
        {: codeblock}

    4.  Dans la section **Service**, observez la valeur de `NodePort`. Au lieu de générer aléatoirement un NodePort comme dans la leçon précédente, vous pouvez spécifier un port sur la plage
30000 à 32767. Cet exemple utilise le port 30072.

7.  Exécutez le script de configuration dans le cluster. Une fois le déploiement et le service créés, l'application est visible aux utilisateurs de l'entreprise PR.

  ```
  kubectl apply -f <username_home_directory>/container-service-getting-started-wt/Stage2/healthcheck.yml
  ```
  {: pre}

  Sortie :

  ```
  deployment "hw-demo-deployment" created
  service "hw-demo-service" created
  ```
  {: screen}

  Maintenant que la tâche de déploiement est terminée, examinez les résultats. Vous pourriez constater un léger ralentissement vu que trois instances sont en exécution.

8.  Ouvrez un navigateur et accédez à l'application. Pour composer l'URL, utilisez pour votre noeud d'agent la même adresse IP publique que dans la leçon précédente et combinez-la avec le NodePort spécifié dans le script de configuration. Pour obtenir l'adresse IP publique du noeud d'agent, utilisez la commande suivante :

  ```
  bx cs workers <pr_firm_cluster>
  ```
  {: pre}

  En utilisant les valeurs de l'exemple, l'URL serait la suivante : `http://169.47.227.138:30072`. Dans un navigateur, le texte suivant pourrait s'afficher. Si ce n'est pas le cas, ne vous inquiétez pas. Cette application est conçue pour s'ouvrir et se fermer.

  ```
  Hello World! Great job getting the second stage up and running!
  ```
  {: screen}

  Vous pouvez également accéder à l'URL `http://169.47.227.138:30072/healthz` pour vérifier le statut. 

  Pour les premières 10 - 15 secondes, un message 200 est renvoyé, ce qui indique que l'application fonctionne correctement. Au bout de ces 15 secondes, un message d'expiration du délai imparti s'affiche, comme conçu dans l'application.

  ```
  {
    "error": "Timeout, Health check error!"
  }
  ```
  {: screen}

9.  Lancez le tableau de bord Kubernetes via le port par défaut (8001).
    1.  Affectez le numéro de port par défaut au proxy.

        ```
        kubectl proxy
        ```
        {: pre}

        Sortie :

        ```
        Starting to serve on 127.0.0.1:8001
        ```
        {: screen}

    2.  Ouvrez l'URL suivante dans un navigateur Web pour accéder au tableau de bord Kubernetes.

        ```
        http://localhost:8001/ui
        ```
        {: codeblock}

10. Vous pouvez examiner dans l'onglet **Charges de travail** les ressources que vous avez créées. Depuis cet onglet, vous pouvez actualiser l'écran continuellement et constater que le bilan de santé opère. Dans la section
**Pods**, vous pouvez observer combien de fois les nacelles sont redémarrées quand leurs conteneurs sont recréés. Si l'erreur ci-après If s'affiche dans le tableau de bord, ce message indique que le bilan de santé a identifié un problème. Patientez quelques minutes, puis actualisez à nouveau la page. Le nombre de tentatives de redémarrage pour chaque nacelle est affiché.

    ```
    Liveness probe failed: HTTP probe failed with statuscode: 500
    Back-off restarting failed docker container
    Error syncing pod, skipping: failed to "StartContainer" for "hw-container" with CrashLoopBackOff: "Back-off 1m20s restarting failed container=hw-container pod=hw-demo-deployment-3090568676-3s8v1_default(458320e7-059b-11e7-8941-56171be20503)"
    ```
    {: screen}

    Lorsque vous avez fini d'explorer le tableau de bord Kubernetes, utilisez dans votre interface CLI les touches CTRL+C pour quitter la commande `proxy`. 


Félicitations ! Vous avez déployé la seconde version de l'application. Vous n'avez eu à utiliser que moins de commandes,
avez appris comment opère le bilan de santé et avez édité un déploiement, ce qui est parfait ! L'application Hello World pour l'entreprise PR a réussi le test. Vous pouvez maintenant déployer une application plus utile pour l'entreprise PR et commencer à analyser les communiqués de presse.

Prêt à supprimer ce que vous avez créé avant de continuer ? Vous utiliserez cette fois le même script de configuration pour supprimer les deux ressources que vous avez créées.

```
kubectl delete -f <username_home_directory>/container-service-getting-started-wt/Stage2/healthcheck.yml
```
{: pre}

Sortie :

```
deployment "hw-demo-deployment" deleted
service "hw-demo-service" deleted
```
{: screen}

### Leçon 3 : Déploiement et mise à jour de l'application Watson Tone Analyzer
{: #cs_apps_tutorial_lesson3}

Dans les leçons précédentes, les applications étaient déployées en tant que composants uniques dans un seul noeud d'agent. Dans cette leçon, vous allez déployer deux composants d'une application dans un cluster
qui utilise le service Watson Tone Analyzer que vous avez ajouté à votre cluster dans le
tutoriel précédent. La dispersion des composants dans des conteneurs différents permet de mettre à jour un composant sans affecter l'autre. Vous mettrez ensuite à jour l'application pour l'étoffer avec d'autres répliques afin de la rendre plus disponible.

<a href="https://console.bluemix.net/docs/api/content/containers/images/cs_app_tutorial_components3.png">[![Configuration de déploiement](images/cs_app_tutorial_components3.png)</a>


#### **Leçon 3a : Déploiement de l'application Watson Tone Analyzer**
{: #lesson3a}

1.  Dans une interface CLI, accédez au troisième répertoire d'application, `Stage3`. Si vous utilisez Docker Toolbox pour Windows ou OS X, utilisez le programme Docker Quickstart
Terminal.

  ```
  cd <username_home_directory>/container-service-getting-started-wt/Stage3
  ```
  {: pre}

2.  Générez la première image {{site.data.keyword.watson}}. 

    1.  Accédez au répertoire `watson`.

        ```
        cd watson
        ```
        {: pre}

    2.  Générez et indexez la première partie de l'application localement en tant qu'image. Ici aussi, n'oubliez pas le point (`.`) à la fin de la commande.

        ```
        docker build -t registry.<region>.bluemix.net/<namespace>/watson .
        ```
        {: pre}

        Vérifiez qu'un message de réussite est bien affiché.

        ```
        Successfully built <image_id>
        ```
        {: screen}

    3.  Transférez par commande push la première partie de l'application en tant qu'image dans votre espace de nom du registre d'images privé. Patientez jusqu'à ce que l'image ait été envoyée par la
commande push avant de passer à l'étape suivante.

        ```
        docker push registry.<region>.bluemix.net/<namespace>/watson
        ```
        {: pre}

3.  Générez la seconde image {{site.data.keyword.watson}}-talk. 

    1.  Accédez au répertoire `watson-talk`.

        ```
        cd <username_home_directory>/container-service-getting-started-wt/Stage3/watson-talk
        ```
        {: pre}

    2.  Générez et indexez la seconde partie de l'application localement en tant qu'image. Ici aussi, n'oubliez pas le point (`.`) à la fin de la commande.

        ```
        docker build -t registry.<region>.bluemix.net/<namespace>/watson-talk
```
        {: pre}

        Vérifiez qu'un message de réussite est bien affiché.

        ```
        Successfully built <image_id>
        ```
        {: screen}

    3.  Transférez par commande push la seconde partie de l'application vers votre espace de nom du registre d'images privé. Patientez jusqu'à ce que l'image ait été envoyée par la
commande push avant de passer à l'étape suivante.

        ```
        docker push registry.<region>.bluemix.net/<namespace>/watson-talk
        ```
        {: pre}

4.  Si vous avez utilisé Docker Quickstart Terminal, revenez à l'interface CLI que vous avez utilisée pour définir la variable de session
`KUBECONFIG`.

5.  Vérifiez que les images ont bien été ajoutées à votre espace de nom du registre.

    ```
    bx cr images
    ```
    {: pre}

    Sortie :

    ```
    Listing images...

    REPOSITORY                                  NAMESPACE  TAG            DIGEST         CREATED         SIZE     VULNERABILITY STATUS
    registry.<region>.bluemix.net/namespace/hello-world   namespace  1              0d90cb732881   40 minutes ago  264 MB   OK
    registry.<region>.bluemix.net/namespace/hello-world   namespace  2              c3b506bdf33e   20 minutes ago  264 MB   OK
    registry.<region>.bluemix.net/namespace/watson        namespace  latest         fedbe587e174   3 minutes ago   274 MB   OK
    registry.<region>.bluemix.net/namespace/watson-talk   namespace  latest         fedbe587e174   2 minutes ago   274 MB   OK
    ```
    {: screen}

6.  Ouvrez le fichier `<username_home_directory>/container-service-getting-started-wt/Stage3/watson-deployment.yml` dans un éditeur de texte. Ce script de configuration inclut un déploiement et un service
tant pour le composant watson que pour le composant watson-talk de l'application.

    1.  Mettez à jour les informations de l'image dans votre espace de nom du registre pour les deux déploiements.

        watson:

        ```
        image: "registry.<region>.bluemix.net/namespace/watson"
        ```
        {: codeblock}

        watson-talk:

        ```
        image: "registry.<region>.bluemix.net/namespace/watson-talk"
        ```
        {: codeblock}

    2.  Dans la section volumes du déploiement Watson, mettez à jour le nom de la clé confidentielle {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} avec celle que vous avez créée dans le tutoriel précédent. En montant la valeur confidentielle Kubernetes en tant que volume dans votre
déploiement, vous mettez les données d'identification du service
{{site.data.keyword.Bluemix_notm}} à
disposition du conteneur exécuté dans votre nacelle. Les composants de l'application {{site.data.keyword.watson}} de ce tutoriel sont configurés pour rechercher les données d'identification du
service à l'aide du chemin de montage du volume. 

        ```
        volumes:
                - name: service-bind-volume
                  secret:
                    defaultMode: 420
                    secretName: binding-<mytoneanalyzer>
        ```
        {: codeblock}

        Si vous avez oublié la clé confidentielle que vous avez créée, exécutez la commande suivante.

        ```
        kubectl get secrets --namespace=default
        ```
        {: pre}

    3.  Dans la section du service watson-talk, notez la valeur définie pour `NodePort`. Cet exemple utilise 30080.

7.  Exécutez le script de configuration.

  ```
  kubectl apply -f <username_home_directory>/container-service-getting-started-wt/Stage3/watson-deployment.yml
  ```
  {: pre}

8.  Facultatif : Vérifiez que la valeur confidentielle de {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} est montée en tant que
volume sur la nacelle. 

    1.  Pour identifier le nom d'une nacelle Watson, exécutez la commande suivante.

        ```
        kubectl get pods
        ```
        {: pre}

        Sortie :

        ```
        NAME                                 READY     STATUS    RESTARTS  AGE
        watson-pod-4255222204-rdl2f          1/1       Running   0         13h
        watson-talk-pod-956939399-zlx5t      1/1       Running   0         13h
        ```
        {: screen}

    2.  Obtenez les détails de la nacelle et recherchez le nom de la clé confidentielle.

        ```
        kubectl describe pod <pod_name>
        ```
        {: pre}

        Sortie :

        ```
        Volumes:
          service-bind-volume:
            Type:       Secret (a volume populated by a Secret)
            SecretName: binding-mytoneanalyzer
          default-token-j9mgd:
            Type:       Secret (a volume populated by a Secret)
            SecretName: default-token-j9mgd
        ```
        {: codeblock}

9.  Ouvrez un navigateur et analysez un texte. Avec notre exemple d'adresse IP, le format de l'URL serait `http://<worker_node_IP_address>:<watson-talk-nodeport>/analyze/"<text_to_analyze>"`. Exemple :

    ```
    http://169.47.227.138:30080/analyze/"Today is a beautiful day"
    ```
    {: codeblock}

    Dans un navigateur, vous pouvez voir la réponse JSON pour le texte que vous avez saisi.

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

11. Vous pouvez examiner dans l'onglet **Charges de travail** les ressources que vous avez créées. Lorsque vous avez fini d'explorer le tableau de bord Kubernetes, utilisez les touches CTRL+C pour quitter la commande `proxy`.


#### Leçon 3b. Mise à jour du déploiement Watson Tone Analyzer en exécution
{: #lesson3b}

Vous pouvez éditer un déploiement en cours d'exécution en modifiant des valeurs dans le modèle de nacelle. Cette leçon comprend la mise à jour de l'image qui a été utilisée.

1.  Modifiez le nom de l'image. L'entreprise PR désire essayer une application différente dans le même déploiement, mais revenir en arrière si un problème est découvert dans la nouvelle application.

    1.  Ouvrez le script de configuration du déploiement en cours d'exécution.

        ```
        kubectl edit deployment/watson-talk-pod
        ```
        {: pre}

        En fonction de votre système d'exploitation, un éditeur vi ou un éditeur de texte s'ouvre de votre système d'exploitation.

    2.  Modifiez le nom de l'image en image ibmliberty.

        ```
        spec:
              containers:
              - image: registry.<region>.bluemix.net/ibmliberty:latest
        ```
        {: codeblock}

    3.  Enregistrez vos modifications et quittez l'éditeur.

    4.  Appliquez les modifications dans le script de configuration au déploiement en exécution.

        ```
        kubectl rollout status deployment/watson-talk-pod
        ```
        {: pre}

        Attendez la confirmation
que le déploiement s'est achevé.

        ```
        deployment "watson-talk-pod" successfully rolled out
        ```
        {: screen}

        Lorsque vous déployez une modification, une autre nacelle est créée et testée par Kubernetes. Si le test aboutit, l'ancienne nacelle est supprimée.

    5.  Si les modifications ne semblent pas conformes, vous pouvez les annuler. Il se peut que quelqu'un dans l'entreprise PR ait commis une erreur dans les modifications et qu'il faille
revenir au déploiement précédent.

        1.  Examinez les numéros de version des révisions pour identifier le numéro du déploiement précédent. La dernière révision est celle avec le numéro de version le plus élevé. Dans cet exemple, la révision 1 correspondait au déploiement initial et la révision 2 à la modification d'image réalisée à l'étape précédente.

            ```
            kubectl rollout history deployment/watson-talk-pod
            ```
            {: pre}

            Sortie :

            ```
            deployments "watson-talk-pod"
            REVISION CHANGE-CAUSE
            1          <none>
            2          <none>

            ```
            {: screen}

        2.  Exécutez la commande suivante pour rétablir le déploiement de la révision précédente. Une nouvelle nacelle est à nouveau créée et testée par
Kubernetes. Si le test aboutit, l'ancienne nacelle est supprimée.

            ```
            kubectl rollout undo deployment/watson-talk-pod --to-revision=1
            ```
            {: pre}

            Sortie :

            ```
            deployment "watson-talk-pod" rolled back
            ```
            {: screen}

        3.  Extrayez le nom de la nacelle à utiliser à l'étape suivante.

            ```
            kubectl get pods
            ```
            {: pre}

            Sortie :

            ```
            NAME                              READY     STATUS    RESTARTS   AGE
            watson-talk-pod-2511517105-6tckg  1/1       Running   0          2m
            ```
            {: screen}

        4.  Examinez les détails de la nacelle et vérifiez que l'image a été rétablie à sa version antérieure.

            ```
            kubectl describe pod <pod_name>
            ```
            {: pre}

            Sortie :

            ```
            Image: registry.<region>.bluemix.net/namespace/watson-talk
            ```
            {: screen}

2.  Facultatif : Répétez les modifications pour le déploiement watson-pod.

[Testez vos connaissances en répondant à un quiz !![External link icon](../icons/launch-glyph.svg "External link icon")](https://bluemix-quizzes.mybluemix.net/containers/apps_tutorial/quiz.php)

Félicitations ! Vous avez déployé l'application Watson Tone Analyzer. L'entreprise PR peut absolument commencer à utiliser ce déploiement de l'application pour analyser ses communiqués de presse.

Prêt à supprimer ce que vous avez créé ? Vous pouvez utiliser le script de configuration pour supprimer les ressources que vous avez créées.

```
kubectl delete -f <username_home_directory>/container-service-getting-started-wt/Stage3/watson-deployment.yml
```
{: pre}

Sortie :

```
deployment "watson-pod" deleted
deployment "watson-talk-pod" deleted
service "watson-service" deleted
service "watson-talk-service" deleted
```
{: screen}

Si vous ne voulez pas conserver le cluster, vous pouvez le supprimer lui-aussi.

```
bx cs cluster-rm <pr_firm_cluster>
```
{: pre}

**Etape suivante ?**

Essayez d'explorer les méthodologies d'orchestration de conteneur sur le site [developerWorks ![External link icon](../icons/launch-glyph.svg "External link icon")](https://developer.ibm.com/code/journey/category/container-orchestration/).
