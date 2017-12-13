---

copyright:
  years: 2014, 2017
lastupdated: "2017-10-16"

---

{:new_window: target="blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Tutoriel : Création de clusters
{: #cs_cluster_tutorial}

Déployez et gérez vos propres clusters Kubernetes dans le cloud. Vous pouvez automatiser le déploiement, l'exploitation, la mise à l'échelle et la surveillance d'applications conteneurisées dans un cluster d'hôtes de calcul indépendants nommés noeuds d'agent.
{:shortdesc}

Dans ce tutoriel, vous verrez comment une entreprise fictive de relations publiques utilise Kubernetes pour déployer une application conteneurisée {{site.data.keyword.Bluemix_short}}. En tirant parti d'{{site.data.keyword.toneanalyzerfull}}, l'entreprise de RP analyse ses communiqués de presse et reçoit des commentaires en retour.


## Objectifs

Dans ce premier tutoriel, vous endossez le rôle d'administrateur réseau de l'entreprise de relations publiques. Vous configurez un cluster Kubernetes personnalisé utilisé pour déployer et tester une version Hello World de l'application.

Pour configurer l'infrastructure :

-   Créez un cluster Kubernetes avec un noeud worker
-   Installez des interfaces CLI pour utiliser l'API Kubernetes et gérer des images Docker
-   Créez un référentiel d'images privé dans {{site.data.keyword.registrylong_notm}} pour y stocker vos images
-   Ajoutez le service {{site.data.keyword.toneanalyzershort}} au cluster de sorte qu'une application du cluster puisse utiliser le service


## Durée

40 minutes


## Public

Ce tutoriel est destiné aux développeurs de logiciel et aux administrateurs réseau qui n'ont encore jamais créé de cluster Kubernetes.


## Conditions prérequises

-  Un compte [{{site.data.keyword.Bluemix_notm}} ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://console.bluemix.net/registration/)



## Leçon 1 : Création d'un cluster et configuration de l'interface CLI
{: #cs_cluster_tutorial_lesson1}

Créez votre cluster dans l'interface graphique et installez les interfaces CLI requises. Dans le cadre de ce tutoriel, créez votre cluster dans la région Sud du Royaume-Uni.


Pour créer votre cluster :

1. La mise à disposition de votre cluster peut prendre quelques minutes. Pour gagner du temps, [créez votre cluster ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://console.bluemix.net/containers-kubernetes/launch?env_id=ibm:yp:united-kingdom) avant d'installer les interfaces CLI. Un cluster léger est accompagné d'un noeud worker sur lequel déployer des pods de conteneurs. Un noeud worker est l'hôte de calcul, en principe une machine virtuelle, sur lequel s'exécutent vos applications.


Les interfaces CLI suivantes et leurs prérequis sont utilisés pour gérer les clusters via l'interface de ligne de commande :
-   Interface CLI de {{site.data.keyword.Bluemix_notm}}
-   Plug-in de {{site.data.keyword.containershort_notm}}
-   Interface CLI de Kubernetes
-   Plug-in de {{site.data.keyword.registryshort_notm}}
-   Interface CLI de Docker

</br>
Pour installer les interfaces CLI, procédez comme suit :

1.  Comme condition prérequise pour le plug-in {{site.data.keyword.containershort_notm}}, installez l'[interface CLI de {{site.data.keyword.Bluemix_notm}} ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://clis.ng.bluemix.net/ui/home.html). Pour exécuter des commandes CLI {{site.data.keyword.Bluemix_notm}}, utilisez le préfixe `bx`.
2.  Suivez les invites pour sélectionner un compte et une organisation {{site.data.keyword.Bluemix_notm}}. Les clusters sont associés à un compte, mais sont indépendants de l'organisation ou d'un espace {{site.data.keyword.Bluemix_notm}}. 

4.  Installez le plug-in {{site.data.keyword.containershort_notm}} pour créer des clusters Kubernetes et gérer les noeuds d'agent. Pour exécuter des commandes du plug-in {{site.data.keyword.containershort_notm}}, utilisez le préfixe `bx cs`.

    ```
    bx plugin install container-service -r Bluemix
    ```
    {: pre}

5.  Pour afficher une version locale du tableau de bord Kubernetes et déployer des applications dans vos clusters, [installez l'interface CLI de Kubernetes ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/tasks/tools/install-kubectl/). Pour exécuter des commandes à l'aide de l'interface CLI de Kubernetes, utilisez le préfixe `kubectl`.
    1.  Pour obtenir la compatibilité fonctionnelle complète, téléchargez la version de l'interface CLI de Kubernetes qui correspond à la version du cluster Kubernetes que vous envisagez d'utiliser. La version de Kubernetes par défaut d'{{site.data.keyword.containershort_notm}} actuelle est 1.7.4.

        OS X :   [https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/darwin/amd64/kubectl ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/darwin/amd64/kubectl)

        Linux :   [https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/linux/amd64/kubectl ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/linux/amd64/kubectl)

        Windows :   [https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/windows/amd64/kubectl.exe ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/windows/amd64/kubectl.exe)

          **Astuce :** si vous utilisez Windows, installez l'interface CLI de Kubernetes dans le même répertoire que l'interface CLI de {{site.data.keyword.Bluemix_notm}}. Cette configuration vous évite diverses modifications de chemin de fichier lorsque vous exécuterez des commandes plus tard.

    2.  Si vous utilisez un système OS X ou Linux, procédez comme suit :
        1.  Déplacez le fichier exécutable vers le répertoire `/usr/local/bin`.

            ```
            mv /<path_to_file>/kubectl /usr/local/bin/kubectl
            ```
            {: pre}

        2.  Assurez-vous que le répertoire /usr/local/bin est répertorié dans votre variable système `PATH`. La variable `PATH` contient tous les répertoires où votre système d'exploitation peut trouver des fichiers exécutables. Les répertoires mentionnés dans la variable `PATH` ont des objets différents. `/usr/local/bin` stocke les fichiers exécutables de logiciels qui ne font pas partie du système d'exploitation et qui ont été installés manuellement par l'administrateur système.

            ```
            echo $PATH
            ```
            {: pre}

            La sortie de votre interface CLI sera similaire à ceci.

            ```
            /usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
            ```
            {: screen}

        3.  Rendez le fichier exécutable.

            ```
            chmod +x /usr/local/bin/kubectl
            ```
            {: pre}

6. Pour configurer et gérer un référentiel d'images privé dans {{site.data.keyword.registryshort_notm}}, installez le plug-in d'{{site.data.keyword.registryshort_notm}}. Pour exécuter des commandes Registry, utilisez le préfixe `bx cr`.

    ```
    bx plugin install container-registry -r Bluemix
    ```
    {: pre}

    Pour vérifier si les plug-in container-service et container-registry sont installés correctement, exécutez la commande suivante :

    ```
    bx plugin list
    ```
    {: pre}

7. Pour générer des images locales et les envoyer par commande push vers votre référentiel d'images privé, [installez l'interface CLI de Docker CE ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://www.docker.com/community-edition#/download). Si vous utilisez Windows 8 ou version antérieure, vous pouvez installer à la place la trousse [Docker Toolbox ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://www.docker.com/products/docker-toolbox).

Félicitations ! Vous avez installé les interfaces CLI utilisées dans les prochaines leçons et tutoriels. Configurez ensuite votre environnement de cluster et ajoutez le service {{site.data.keyword.toneanalyzershort}}.


## Leçon 2 : Configuration de votre environnement de cluster
{: #cs_cluster_tutorial_lesson2}

Créez votre cluster Kubernetes, configurez un registre d'images privé dans {{site.data.keyword.registryshort_notm}} et ajoutez des valeurs confidentielles à votre cluster afin que l'application puisse accéder au service {{site.data.keyword.toneanalyzershort}}.

1.  A l'invite, connectez-vous à l'interface CLI de {{site.data.keyword.Bluemix_notm}} en utilisant vos données d'identification {{site.data.keyword.Bluemix_notm}}.

    ```
    bx login [--sso] -a api.eu-gb.bluemix.net
    ```
    {: pre}

    **Remarque :** si vous disposez d'un ID fédéré, utilisez l'indicateur `--sso` pour vous connecter. Entrez votre nom d'utilisateur et utilisez l'URL mentionnée dans la sortie CLI pour extraire votre code d'accès à usage unique.

2.  Configurez votre référentiel d'images privé dans {{site.data.keyword.registryshort_notm}}
pour stocker de manière sécurisée et partager vos images Docker avec tous les utilisateurs du cluster. Un référentiel d'images privé dans {{site.data.keyword.Bluemix_notm}} est identifié par un espace de nom. L'espace de nom est utilisé pour créer une URL unique vers votre référentiel d'images que vos développeurs peuvent utiliser pour accéder aux images Docker privées.

    Dans cet exemple, l'entreprise PR désire créer un seul registre d'images dans {{site.data.keyword.registryshort_notm}} et spécifie donc _pr_firm_ comme nom d'espace dans lequel regrouper toutes les images de leur compte. Remplacez
_&lt;your_namespace&gt;_ par l'espace de nom de votre choix, sans rapport
avec ce tutoriel.

    ```
    bx cr namespace-add <your_namespace>
    ```
    {: pre}

3.  Avant de passer à l'étape suivante, vérifiez que le déploiement de votre noeud worker a abouti.

    ```
    bx cs workers <cluster_name>
    ```
     {: pre}

    Lorsque l'allocation de votre noeud worker a abouti, son statut passe à **Ready** et vous pouvez alors commencer à lier des services {{site.data.keyword.Bluemix_notm}} en vue de leur utilisation dans un tutoriel ultérieur.

    ```
    ID                                                 Public IP       Private IP       Machine Type   State    Status
    kube-par02-pafe24f557f070463caf9e31ecf2d96625-w1   169.48.131.37   10.177.161.132   free           normal    Ready
    ```
    {: screen}

4.  Définissez le contexte de votre cluster dans l'interface CLI. Chaque fois que vous vous connectez à l'interface CLI du conteneur pour gérer vos clusters, vous devez lancer ces commandes pour définir le chemin d'accès au fichier de configuration du cluster par le biais d'une variable de session. L'interface CLI de Kubernetes utilise cette variable pour localiser un fichier de configuration local et les certificats requis pour connexion au cluster dans {{site.data.keyword.Bluemix_notm}}.

    1.  Obtenez la commande permettant de définir la variable d'environnement et téléchargez les fichiers de configuration Kubernetes.

        ```
        bx cs cluster-config <cluster_name>
        ```
        {: pre}

        Une fois les fichiers de configuration téléchargés, une commande s'affiche ; elle vous permet de définir le chemin vers le fichier de configuration Kubernetes local en tant que variable d'environnement.

        Exemple pour OS X :

        ```
        export KUBECONFIG=/Users/<user_name>/.bluemix/plugins/container-service/clusters/pr_firm_cluster/kube-config-prod-par02-pr_firm_cluster.yml
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
        /Users/<user_name>/.bluemix/plugins/container-service/clusters/pr_firm_cluster/kube-config-prod-par02-pr_firm_cluster.yml
        ```
        {: screen}

    4.  Vérifiez que les commandes `kubectl` fonctionnent correctement avec votre cluster en vérifiant la version du serveur CLI de Kubernetes.

        ```
        kubectl version  --short
        ```
        {: pre}

        Exemple de sortie :

        ```
        Client Version: v1.7.4
        Server Version: v1.7.4
        ```
        {: screen}

5.  Ajoutez le service {{site.data.keyword.toneanalyzershort}} au cluster. Via les services {{site.data.keyword.Bluemix_notm}}, vous pouvez tirer parti dans vos applications des fonctionnalités que vous avez déjà développées. Tout service {{site.data.keyword.Bluemix_notm}} lié au cluster peut être utilisé par une application quelconque déployée dans ce cluster. Répétez les étapes ci-après pour chaque service {{site.data.keyword.Bluemix_notm}} que vous désirez utiliser avec vos applications.
    1.  Ajoutez le service {{site.data.keyword.toneanalyzershort}} à votre compte {{site.data.keyword.Bluemix_notm}}.

        **Remarque :** lorsque vous ajoutez le service {{site.data.keyword.toneanalyzershort}} à votre compte, un message s'affiche pour indiquer que ce service n'est pas gratuit. Si vous modérez votre appel d'API, ce tutoriel n'est pas assujetti à des frais pour le service {{site.data.keyword.watson}}. [Consultez les informations de tarification du service {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://www.ibm.com/watson/developercloud/tone-analyzer.html#pricing-block).

        ```
        bx service create tone_analyzer standard <mytoneanalyzer>
        ```
        {: pre}

    2.  Associez l'instance {{site.data.keyword.toneanalyzershort}} à l'espace de nom Kubernetes `default` pour le cluster. Ensuite, vous pourrez créer vos propres espaces de nom pour gérer les accès utilisateur aux ressources Kubernetes, mais dans l'immédiat, utilisez l'espace de nom`default`. Les espaces de nom Kubernetes sont différents de l'espace de nom du registre que vous avez créé auparavant.

        ```
        bx cs cluster-service-bind <cluster_name> default <mytoneanalyzer>
        ```
        {: pre}

        Sortie :

        ```
        bx cs cluster-service-bind <cluster_name> default <mytoneanalyzer>
        Binding service instance to namespace...
        OK
        Namespace:	default
        Secret name:	binding-mytoneanalyzer
        ```
        {: screen}

6.  Vérifiez que la valeur confidentielle Kubernetes a bien été créée dans votre espace de nom de cluster. Chaque service {{site.data.keyword.Bluemix_notm}} est défini par un fichier JSON qui inclut des informations confidentielles sur le service, comme le nom de l'utilisateur, son mot de passe et l'URL qu'utilise le conteneur pour accéder au service. Des valeurs confidentielles Kubernetes sont utilisées pour un stockage sécurisé de ces informations. Dans cet exemple, les valeurs confidentielles incluent les données d'identification permettant d'accéder à l'instance du service {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} allouée à votre compte.

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

</br>
Parfait ! Vous avez configuré votre cluster et votre environnement local est prêt pour commencer le déploiement d'applications dans le cluster.

## Etape suivante ?

* [Testez vos connaissances en répondant à un quiz !![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://ibmcloud-quizzes.mybluemix.net/containers/cluster_tutorial/quiz.php)

* Exécutez le [Tutoriel : Déploiement d'applications dans des clusters Kubernetes dans {{site.data.keyword.containershort_notm}}](cs_tutorials_apps.html#cs_apps_tutorial) pour déployer l'application de l'entreprise PR dans le cluster que vous avez créé.
