---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

keywords: kubernetes, iks

subcollection: containers

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:note: .note}
{:important: .important}
{:deprecated: .deprecated}
{:download: .download}
{:preview: .preview}



# Tutoriel : Création de clusters Kubernetes
{: #cs_cluster_tutorial}

Avec ce tutoriel, vous allez pouvoir déployer et gérer un cluster Kubernetes dans {{site.data.keyword.containerlong}}. Poursuivons avec une société de relations publiques (RP) fictive pour apprendre à automatiser le déploiement, le fonctionnement, la mise à l'échelle et la surveillance d'applications conteneurisées dans un cluster qui s'intègrent à d'autres services de cloud, tels que {{site.data.keyword.ibmwatson}}.
{:shortdesc}

## Objectifs
{: #tutorials_objectives}

Dans ce tutoriel, vous travaillez pour une société de relations publiques (RP) et exécutez une série de leçons pour configurer un environnement de cluster Kubernetes personnalisé. Tout d'abord, vous configurez votre interface CLI {{site.data.keyword.cloud_notm}}, vous créez un conteneur {{site.data.keyword.containershort_notm}} et vous stockez les images de votre entreprise de relations publiques dans un registre {{site.data.keyword.registrylong}} privé. Ensuite, vous mettez à disposition un service {{site.data.keyword.toneanalyzerfull}} et vous le liez à votre cluster. Après avoir déployé et testé une application Hello World dans votre cluster, vous déployez progressivement des versions plus complexes et hautement disponibles de votre application {{site.data.keyword.watson}} afin que votre entreprise de relations publiques puisse analyser des communiqués de presse et recevoir des commentaires à l'aide des dernières technologies d'intelligence artificielle. {:shortdesc}

Le diagramme suivant fournit une vue d'ensemble de ce que vous configurez dans ce tutoriel :

<img src="images/tutorial_ov.png" width="500" alt="Diagramme de présentation de la création d'un cluster et du déploiement d'une application Watson" style="width:500px; border-style: none"/>

## Durée
{: #tutorials_time}

60 minutes


## Public
{: #tutorials_audience}

Ce tutoriel est destiné aux développeurs de logiciels et aux administrateurs système qui créent un cluster Kubernetes et déploient une application pour la première fois.
{: shortdesc}

## Prérequis
{: #tutorials_prereqs}

-  Consultez la procédure à suivre pour [préparer la création du cluster](/docs/containers?topic=containers-clusters#cluster_prepare).
-  Vérifiez que vous disposez des règles d'accès suivantes :
    - [Rôle de plateforme {{site.data.keyword.Bluemix_notm}} IAM **Administrateur**](/docs/containers?topic=containers-users#platform) pour {{site.data.keyword.containerlong_notm}}
    - [Rôle de plateforme {{site.data.keyword.Bluemix_notm}} IAM **Administrateur**](/docs/containers?topic=containers-users#platform) pour {{site.data.keyword.registrylong_notm}}
    - [Rôle de service {{site.data.keyword.Bluemix_notm}} IAM **Auteur** ou **Responsable**](/docs/containers?topic=containers-users#platform) pour {{site.data.keyword.containerlong_notm}}

## Leçon 1 : Configuration de votre environnement de cluster
{: #cs_cluster_tutorial_lesson1}

Créez votre cluster Kubernetes dans la console {{site.data.keyword.Bluemix_notm}}, installez les interfaces CLI requises, configurez votre registre de conteneur et définissez le contexte pour votre cluster Kubernetes dans l'interface CLI.
{: shortdesc}

Comme la mise à disposition peut prendre quelques minutes, créez votre cluster avant de configurer le reste de votre environnement de cluster. 

1.  [Dans la console {{site.data.keyword.Bluemix_notm}} ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://cloud.ibm.com/kubernetes/catalog/cluster/create), créez un cluster gratuit ou standard avec un pool de noeuds worker comportant un noeud worker. 

    Vous pouvez également créer un [cluster dans l'interface CLI](/docs/containers?topic=containers-clusters#clusters_cli_steps).
    {: tip}
2.  Pendant la mise à disposition par votre cluster, installez l'[interface CLI {{site.data.keyword.Bluemix_notm}}![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](/docs/cli?topic=cloud-cli-getting-started). Cette installation inclut :
    -   L'interface CLI {{site.data.keyword.Bluemix_notm}} de base (`ibmcloud`).
    -   Le plug-in {{site.data.keyword.containerlong_notm}} (`ibmcloud ks`). Utilisez ce plug-in pour gérer vos clusters Kubernetes, par exemple, pour redimensionner des pools de noeuds worker afin d'obtenir davantage de capacité de calcul ou pour lier des services {{site.data.keyword.Bluemix_notm}} au cluster. 
    -   Le plug-in {{site.data.keyword.registryshort_notm}} (`ibmcloud cr`). Utilisez ce plug-in pour configurer et gérer un référentiel d'images privé dans {{site.data.keyword.registryshort_notm}}.
    -   L'interface CLI Kubernetes (`kubectl`). Utilisez cette interface CLI pour déployer et gérer des ressources Kubernetes, telles que les pods et les services de votre application. 

    Si vous souhaitez utiliser la console {{site.data.keyword.Bluemix_notm}} à la place, une fois votre cluster créé, vous pouvez exécuter des commandes CLI directement depuis votre navigateur Web dans le [terminal Kubernetes](/docs/containers?topic=containers-cs_cli_install#cli_web).
    {: tip}
3.  Dans votre terminal, connectez-vous à votre compte {{site.data.keyword.Bluemix_notm}}. A l'invite, entrez vos données d'identification {{site.data.keyword.Bluemix_notm}}. Si vous disposez d'un ID fédéré, utilisez l'indicateur `--sso` pour vous connecter. Sélectionnez la région et, le cas échéant, ciblez le groupe de ressources (`-g`) dans lequel vous avez créé votre cluster.
    ```
    ibmcloud login [-g <resource_group>] [--sso]
    ```
    {: pre}
5.  Vérifiez que les plug-ins sont correctement installés.
    ```
    ibmcloud plugin list
    ```
    {: pre}

    Le plug-in {{site.data.keyword.containerlong_notm}} est affiché dans les résultats en tant que **kubernetes-service**, et le plug-in {{site.data.keyword.registryshort_notm}} est affiché dans les résultats en tant que **container-registry**.
6.  Configurez votre référentiel d'images privé dans {{site.data.keyword.registryshort_notm}} pour stocker de manière sécurisée et partager vos images Docker avec tous les utilisateurs du cluster. Un référentiel d'images privé dans {{site.data.keyword.Bluemix_notm}} est identifié par un espace de nom. L'espace de nom est utilisé pour créer une URL unique vers votre référentiel d'images que vos développeurs peuvent utiliser pour accéder aux images Docker privées.
    Découvrez comment [sécuriser vos informations personnelles](/docs/containers?topic=containers-security#pi) lorsque vous utilisez des images de conteneur.

    Dans cet exemple, l'entreprise de RP désire créer un seul registre d'images dans {{site.data.keyword.registryshort_notm}} et spécifie donc `pr_firm` comme nom d'espace dans lequel regrouper toutes les images de leur compte. Remplacez `<namespace>` par un espace de nom de votre choix sans rapport avec le tutoriel. 

    ```
    ibmcloud cr namespace-add <namespace>
    ```
    {: pre}
7.  Avant de passer à l'étape suivante, vérifiez que le déploiement de votre noeud worker a abouti.
    ```
    ibmcloud ks workers --cluster <cluster_name_or_ID>
    ```
    {: pre}

    Lorsque l'allocation de votre noeud worker a abouti, son statut passe à **Ready** et vous pouvez alors commencer à lier des services {{site.data.keyword.Bluemix_notm}}.

    ```
    ID                                                 Public IP       Private IP       Machine Type   State    Status   Zone   Version
    kube-mil01-pafe24f557f070463caf9e31ecf2d96625-w1   169.xx.xxx.xxx   10.xxx.xx.xxx   free           normal   Ready    mil01      1.13.8
    ```
    {: screen}
8.  Définissez le contexte de votre cluster Kubernetes dans l'interface CLI.
    1.  Obtenez la commande permettant de définir la variable d'environnement et téléchargez les fichiers de configuration Kubernetes. Chaque fois que vous vous connectez à l'interface CLI d'{{site.data.keyword.containerlong}} pour gérer vos clusters, vous devez lancer ces commandes pour définir le chemin d'accès au fichier de configuration du cluster par le biais d'une variable de session. L'interface CLI de Kubernetes utilise cette variable pour localiser un fichier de configuration local et les certificats requis pour connexion au cluster dans {{site.data.keyword.Bluemix_notm}}.<p class="tip">Vous utilisez Windows PowerShell ? Ajoutez l'indicateur `--powershell` pour obtenir des variables d'environnement au format Windows PowerShell.</p>
        ```
        ibmcloud ks cluster-config --cluster <cluster_name_or_ID>
        ```
        {: pre}

        Une fois les fichiers de configuration téléchargés, une commande s'affiche ; elle vous permet de définir le chemin vers le fichier de configuration Kubernetes local en tant que variable d'environnement.

        Exemple pour OS X :
        ```
        export KUBECONFIG=/Users/<user_name>/.bluemix/plugins/kubernetes-service/clusters/    pr_firm_cluster/kube-config-prod-mil01-pr_firm_cluster.yml
        ```
        {: screen}
    2.  Copiez et collez la commande qui s'affiche sur votre terminal pour définir la variable d'environnement `KUBECONFIG`.
    3.  Vérifiez que la variable d'environnement `KUBECONFIG` est correctement définie.

        Exemple pour OS X :
        ```
        echo $KUBECONFIG
        ```
        {: pre}

        Exemple de sortie :

        ```
        /Users/<user_name>/.bluemix/plugins/kubernetes-service/clusters/pr_firm_cluster/kube-config-prod-mil01-pr_firm_cluster.yml
        ```
        {: screen}

    4.  Vérifiez que les commandes `kubectl` fonctionnent correctement avec votre cluster en vérifiant la version du serveur CLI de Kubernetes.
        ```
        kubectl version  --short
        ```
        {: pre}

        Exemple de sortie :

        ```
        Client Version: v1.13.8
        Server Version: v1.13.8
        ```
        {: screen}

Bien joué ! Vous avez installé les interfaces CLI et configuré votre contexte de cluster pour les leçons suivantes. Configurez ensuite votre environnement de cluster et ajoutez le service {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}}.

<br />


## Leçon 2 : Ajout d'un service IBM Cloud à votre cluster
{: #cs_cluster_tutorial_lesson2}

Via les services {{site.data.keyword.Bluemix_notm}}, vous pouvez tirer parti dans vos applications des fonctionnalités que vous avez déjà développées. Tout service {{site.data.keyword.Bluemix_notm}} lié au cluster Kubernetes peut être utilisé par une application quelconque déployée dans ce cluster. Répétez les étapes ci-après pour chaque service {{site.data.keyword.Bluemix_notm}} que vous désirez utiliser avec vos applications.
{: shortdesc}

1.  Ajoutez le service {{site.data.keyword.toneanalyzershort}} à votre compte {{site.data.keyword.Bluemix_notm}} dans la même région que votre cluster. Remplacez `<service_name>` par un nom pour votre instance de service et `<region>` par une région, telle que celle dans laquelle se trouve votre cluster. 

    Lorsque vous ajoutez le service {{site.data.keyword.toneanalyzershort}} à votre compte, un message s'affiche pour indiquer que ce service n'est pas gratuit. Si vous modérez votre appel d'API, ce tutoriel n'est pas assujetti à des frais pour le service {{site.data.keyword.watson}}. [Consultez les informations de tarification du service {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://cloud.ibm.com/catalog/services/tone-analyzer).
    {: note}

    ```
    ibmcloud resource service-instance-create <service_name> tone-analyzer standard <region>
    ```
    {: pre}
2.  Associez l'instance {{site.data.keyword.toneanalyzershort}} à l'espace de nom Kubernetes `default` pour le cluster. Ensuite, vous pourrez créer vos propres espaces de nom pour gérer les accès utilisateur aux ressources Kubernetes, mais dans l'immédiat, utilisez l'espace de nom `default`. Les espaces de nom Kubernetes sont différents de l'espace de nom du registre que vous avez créé auparavant.
    ```
    ibmcloud ks cluster-service-bind --cluster <cluster_name> --namespace default --service <service_name>
    ```
    {: pre}

    Exemple de sortie :
    ```
    ibmcloud ks cluster-service-bind pr_firm_cluster default mytoneanalyzer
    Binding service instance to namespace...
    OK
    Namespace:	default
    Secret name:	binding-mytoneanalyzer
    ```
    {: screen}
3.  Vérifiez que le secret Kubernetes a bien été créé dans votre espace de nom de cluster. Lorsque vous [liez un service {{site.data.keyword.Bluemix_notm}} à votre cluster](/docs/containers?topic=containers-service-binding), un fichier JSON est généré avec des informations confidentielles, telles que la clé d'API {{site.data.keyword.Bluemix_notm}} Identity and Access Management (IAM) et l'URL dont se sert le conteneur pour accéder au service. Le fichier JSON est stocké dans un secret Kubernetes pour assurer le stockage sécurisé de ces informations. 

    ```
    kubectl get secrets --namespace=default
    ```
    {: pre}

    Exemple de sortie :

    ```
    NAME                       TYPE                                  DATA      AGE
    binding-mytoneanalyzer     Opaque                                1         1m
    bluemix-default-secret     kubernetes.io/dockercfg               1         1h
    default-token-kf97z        kubernetes.io/service-account-token   3         1h
    ```
    {: screen}

</br>
Parfait ! Votre cluster est configuré et votre environnement local est prêt pour le déploiement d'applications dans le cluster.

Avant de passer à la leçon suivante, pourquoi ne pas tester vos connaissances en [répondant à un petit quiz![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://ibmcloud-quizzes.mybluemix.net/containers/cluster_tutorial/quiz.php) ?
{: note}

<br />


## Leçon 3 : Déploiement d'applications avec instance unique sur des clusters Kubernetes
{: #cs_cluster_tutorial_lesson3}

Dans la leçon précédente, vous avez configuré un cluster avec un noeud worker. Dans cette leçon, vous allez configurer un déploiement et déployer une instance unique de l'application sur un pod Kubernetes dans le noeud worker.
{:shortdesc}

Les composants que vous déployez en suivant cette leçon sont illustrés dans le diagramme suivant.

![Configuration de déploiement](images/cs_app_tutorial_mz-components1.png)

Pour déployer l'application :

1.  Clonez le code source de l'application [Hello World ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://github.com/IBM/container-service-getting-started-wt) dans votre répertoire utilisateur de base. Ce répertoire héberge différentes versions d'une application similaire dans des dossiers débutant chacun par `Lab`. Chaque version contient les fichiers suivants :
    *   `Dockerfile` : définitions pour génération de l'image.
    *   `app.js` : application Hello World.
    *   `package.json` : métadonnées de l'application.

    ```
    git clone https://github.com/IBM/container-service-getting-started-wt.git
    ```
    {: pre}

2.  Accédez au répertoire `Lab 1`.
    ```
    cd 'container-service-getting-started-wt/Lab 1'
    ```
    {: pre}
3.  Connectez-vous à l'interface de ligne de commande {{site.data.keyword.registryshort_notm}}.
    ```
    ibmcloud cr login
    ```
    {: pre}

    Si vous ne vous rappelez plus de votre espace de nom dans {{site.data.keyword.registryshort_notm}}, exécutez la commande suivante.
    ```
    ibmcloud cr namespace-list
    ```
    {: pre}
4.  Générez une image Docker incluant les fichiers d'application du répertoire `Lab 1` et insérez cette image dans l'espace de nom {{site.data.keyword.registryshort_notm}} que vous avez créé lors de la leçon précédente. Si vous avez besoin de modifier l'application plus tard, répétez ces étapes pour créer une autre version de l'image. **Remarque** : découvrez comment [sécuriser vos informations personnelles](/docs/containers?topic=containers-security#pi) lorsque vous utilisez des images de conteneur.

    Utilisez uniquement des caractères alphanumériques en minuscules ou des traits de soulignement (`_`) dans le nom de l'image. N'oubliez pas le point (`.`) à la fin de la commande. Ce point indique à Docker de rechercher le Dockerfile et les artefacts de génération de l'image dans le répertoire actuel. **Remarque** : vous devez spécifier une [région de registre](/docs/services/Registry?topic=registry-registry_overview#registry_regions), par exemple, `us`. Pour obtenir la région de registre dans laquelle vous vous trouvez, exécutez la commande `ibmcloud cr region`.

    ```
    ibmcloud cr build -t <region>.icr.io/<namespace>/hello-world:1 .
    ```
    {: pre}

    Lorsque la génération est terminée, vérifiez que le message de réussite suivant est bien affiché :

    ```
    Successfully built <image_ID>
    Successfully tagged <region>.icr.io/<namespace>/hello-world:1
    The push refers to a repository [<region>.icr.io/<namespace>/hello-world]
    29042bc0b00c: Pushed
    f31d9ee9db57: Pushed
    33c64488a635: Pushed
    0804854a4553: Layer already exists
    6bd4a62f5178: Layer already exists
    9dfa40a0da3b: Layer already exists
    1: digest: sha256:f824e99435a29e55c25eea2ffcbb84be4b01345e0a3efbd7d9f238880d63d4a5 size: 1576
    ```
    {: screen}
5.  Créez un déploiement. Les déploiements sont utilisés pour gérer les pods, lesquels contiennent des instances conteneurisées d'une application. La commande suivante déploie l'application dans un seul pod en faisant référence à l'image que vous avez créée dans votre registre privé. Dans le cadre de ce tutoriel, le déploiement est intitulé **hello-world-deployment**, mais vous pouvez lui donner un nom de votre choix.
    ```
    kubectl create deployment hello-world-deployment --image=<region>.icr.io/<namespace>/hello-world:1
    ```
    {: pre}

    Exemple de sortie :
    ```
    deployment "hello-world-deployment" created
    ```
    {: screen}

    Découvrez comment [sécuriser vos informations personnelles](/docs/containers?topic=containers-security#pi) lorsque vous utilisez des ressources Kubernetes.
6.  Rendez l'application accessible au public en exposant le déploiement en tant que service NodePort. Tout comme l'exposition d'un port pour une application Cloud Foundry, le port de noeud (NodePort) que vous exposez est celui sur lequel le noeud worker est à l'écoute de trafic.
    ```
    kubectl expose deployment/hello-world-deployment --type=NodePort --port=8080 --name=hello-world-service --target-port=8080
    ```
    {: pre}

    Exemple de sortie :
    ```
    service "hello-world-service" exposed
    ```
    {: screen}

    <table summary="Informations sur les paramètres de la commande expose.">
    <caption>Informations supplémentaires sur les paramètres de la commande expose</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Informations supplémentaires sur les paramètres de la commande expose</th>
    </thead>
    <tbody>
    <tr>
    <td><code>expose</code></td>
    <td>Expose une ressource en tant que service Kubernetes et la rend disponible publiquement aux utilisateurs.</td>
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
    <td>Port utilisé par le service.</td>
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
7. Maintenant que la tâche de déploiement est terminée, vous pouvez tester votre application dans un navigateur. Extrayez les informations détaillées pour composer l'URL.
    1.  Extrayez les informations sur le service pour déterminer le port de noeud (NodePort) qui a été affecté.
        ```
        kubectl describe service hello-world-service
        ```
        {: pre}

        Exemple de sortie :
        ```
        Name:                   hello-world-service
        Namespace:              default
        Labels:                 run=hello-world-deployment
        Selector:               run=hello-world-deployment
        Type:                   NodePort
        IP:                     10.xxx.xx.xxx
        Port:                   <unset> 8080/TCP
        NodePort:               <unset> 30872/TCP
        Endpoints:              172.30.xxx.xxx:8080
        Session Affinity:       None
        No events.
        ```
        {: screen}

        Les ports de noeud (NodePorts) sont affectés aléatoirement lorsqu'ils sont générés par la commande `expose`, mais ils sont compris entre 30000 et 32767. Dans cet exemple, la valeur de NodePort est 30872.
    2.  Identifiez l'adresse IP publique du noeud worker dans le cluster.
        ```
        ibmcloud ks workers --cluster <cluster_name_or_ID>
        ```
        {: pre}

        Exemple de sortie :
        ```
        ibmcloud ks workers --cluster pr_firm_cluster
        Listing cluster workers...
        OK
        ID                                                 Public IP       Private IP       Machine Type   State    Status   Zone   Version
        kube-mil01-pa10c8f571c84d4ac3b52acbf50fd11788-w1   169.xx.xxx.xxx  10.xxx.xx.xxx    free           normal   Ready    mil01      1.13.8
        ```
        {: screen}
8. Ouvrez un navigateur et accédez à l'application via l'URL `http://<IP_address>:<NodePort>`. En utilisant les valeurs de l'exemple, l'URL est `http://169.xx.xxx.xxx:30872`. Lorsque vous entrez cette URL dans un navigateur, le texte suivant apparaît.
    ```
    Hello World! Your app is up and running in a cluster!
    ```
    {: screen}

    Pour voir si l'application est accessible au public, essayez de l'entrer dans un navigateur sur votre téléphone portable.
    {: tip}
9. [Lancez le tableau de bord Kubernetes](/docs/containers?topic=containers-app#cli_dashboard).

    Si vous sélectionnez votre cluster dans la [console {{site.data.keyword.Bluemix_notm}}](https://cloud.ibm.com/), vous pouvez utiliser le bouton **Tableau de bord Kubernetes** pour lancer votre tableau de bord en un seul clic.
    {: tip}
10. Vous pouvez examiner dans l'onglet **Charges de travail** les ressources que vous avez créées.

Bien joué ! Vous venez de déployer la première version de l'application.

Trop de commandes dans cette leçon ? Nous sommes bien d'accord. Que diriez-vous d'utiliser un script de configuration pour se charger d'une partie du travail à votre place ? Pour utiliser un script de configuration pour la seconde version de l'application et promouvoir une plus haute disponibilité en déployant plusieurs instances de l'application, passez à la leçon suivante.

**Nettoyage**<br>
Vous souhaitez supprimer les ressources que vous avez créées au cours de cette leçon avant de poursuivre ? Lorsque vous avez créé le déploiement, Kubernetes lui a affecté un libellé, `app=hello-world-deployment` (ou le nom que vous avez donné au déploiement, quel qu'il soit). Ensuite, lorsque vous avez exposé le déploiement, Kubernetes a appliqué le même libellé au service qui a été créé. Les libellés sont des outils utiles qui vous permettent d'organiser des ressources Kubernetes de telle manière que vous puissiez y appliquer des actions en bloc telles que `get` ou `delete`. 

  Vous pouvez vérifier toutes vos ressources ayant le libellé `app=hello-world-deployment`. 
  ```
  kubectl get all -l app=hello-world-deployment
  ```
  {: pre}

  Ensuite, vous pouvez supprimer toutes les ressources ayant le libellé. 
  ```
  kubectl delete all -l app=hello-world-deployment
  ```
  {: pre}

  Exemple de sortie :
  ```
  pod "hello-world-deployment-5c78f9b898-b9klb" deleted
  service "hello-world-service" deleted
  deployment.apps "hello-world-deployment" deleted
  ```
  {: screen}

<br />


## Leçon 4 : Déploiement et mise à jour d'applications avec une plus haute disponibilité
{: #cs_cluster_tutorial_lesson4}

Dans cette leçon, vous allez déployer trois instances de l'application Hello World dans un cluster pour assurer une plus haute disponibilité de l'application qu'avec la première version.
{:shortdesc}

Une plus haute disponibilité signifie que l'accès utilisateur est réparti sur les trois instances. Lorsqu'un trop grand nombre d'utilisateurs tentent d'accéder à la même instance de l'application, ils peuvent être confrontés à des temps de réponse lents. L'existence de plusieurs instances peut induire des temps de réponse plus rapides pour vos utilisateurs. Dans cette leçon, vous allez également découvrir comment des diagnostics d'intégrité et des mises à jour de déploiements peuvent opérer avec Kubernetes. Le diagramme suivant inclut les composants que vous déployez dans cette leçon.

![Configuration de déploiement](images/cs_app_tutorial_mz-components2.png)

Au cours des leçons précédentes, vous avez créé un cluster avec un seul noeud worker et déployé une seule instance d'une application. Dans cette leçon, vous configurez un déploiement et déployez trois instances de l'application Hello world. Chaque instance est déployée dans un pod Kubernetes dans le cadre d'un jeu de répliques dans le noeud worker. Pour une disponibilité publique, vous créez également un service Kubernetes.

Comme défini dans le script de configuration, Kubernetes peut utiliser une vérification de la disponibilité pour déterminer si un conteneur dans un pod est en opération ou non. Ces vérifications peuvent, par exemple, identifier des interblocages, où une application est opérationnelle, mais ne parvient pas à progresser. Le redémarrage d'un conteneur dans cette situation peut aider à rendre l'application disponible malgré les bogues. Kubernetes utilise ensuite une vérification de disponibilité pour déterminer à quel moment un conteneur est prêt à accepter le trafic. Un pod est considéré comme prêt quand son conteneur est lui-même prêt. Une fois le pod prêt, il est redémarré. Dans cette version de l'application, son délai d'attente expire toutes les 15 secondes. Lorsqu'un diagnostic d'intégrité est configuré dans le script de configuration, les conteneurs sont recréés si cette vérification détecte un problème affectant une application.

Si vous avez fait une pause après la dernière leçon et démarré une nouvelle session de terminal, prenez soin de vous reconnecter à votre cluster.

1.  Dans votre terminal, accédez au répertoire `Lab 2`.
    ```
    cd 'container-service-getting-started-wt/Lab 2'
    ```
    {: pre}
2.  Générez, balisez et insérez l'application sous forme d'image dans votre espace de nom dans {{site.data.keyword.registryshort_notm}}. N'oubliez pas le point (`.`) à la fin de la commande.
    ```
    ibmcloud cr build -t <region>.icr.io/<namespace>/hello-world:2 .
      ```
    {: pre}

    Vérifiez qu'un message de réussite est bien affiché.
    ```
    Successfully built <image_ID>
    Successfully tagged <region>.icr.io/<namespace>/hello-world:1
    The push refers to a repository [<region>.icr.io/<namespace>/hello-world]
    29042bc0b00c: Pushed
    f31d9ee9db57: Pushed
    33c64488a635: Pushed
    0804854a4553: Layer already exists
    6bd4a62f5178: Layer already exists
    9dfa40a0da3b: Layer already exists
    1: digest: sha256:f824e99435a29e55c25eea2ffcbb84be4b01345e0a3efbd7d9f238880d63d4a5 size: 1576
    ```
    {: screen}
3.  Dans le répertoire `Lab 2`, ouvrez le fichier `healthcheck.yml` à l'aide d'un éditeur de texte. Ce script de configuration agrège quelques étapes de la leçon précédente pour créer en même temps un déploiement et un service. Les développeurs d'application de l'entreprise de RP peuvent utiliser ces scripts lors de mises à jour ou pour traiter les incidents en recréant les pods.
    1.  Mettez à jour les informations de l'image dans votre espace de nom du registre privé.
        ```
        image: "<region>.icr.io/<namespace>/hello-world:2"
        ```
        {: codeblock}
    2.  Dans la section **Deployment**, observez la valeur de `replicas`. la valeur de replicas désigne le nombre d'instances de votre application. L'exécution de trois instances assure une plus haute disponibilité de votre application qu'une seule instance.
        ```
        replicas: 3
        ```
        {: codeblock}
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
    4.  Dans la section **Service**, observez la valeur de `NodePort`. Au lieu de générer aléatoirement un NodePort comme dans la leçon précédente, vous pouvez spécifier un port sur la plage 30000 à 32767. Cet exemple utilise le port 30072.
4.  Revenez à l'interface CLI que vous avez utilisée pour définir le contexte de votre cluster et exécutez le script de configuration. Une fois le déploiement et le service créés, l'application est visible aux utilisateurs de l'entreprise de RP.
    ```
    kubectl apply -f healthcheck.yml
    ```
    {: pre}

    Exemple de sortie :
    ```
    deployment "hw-demo-deployment" created
  service "hw-demo-service" created
    ```
    {: screen}
5.  A présent que la tâche de déploiement est terminée, ouvrez un navigateur et vérifiez le fonctionnement de l'application. Pour composer l'URL, utilisez pour votre noeud worker la même adresse IP publique que dans la leçon précédente et combinez-la avec le NodePort spécifié dans le script de configuration. Pour obtenir l'adresse IP publique du noeud worker, utilisez la commande suivante :
    ```
    ibmcloud ks workers --cluster <cluster_name_or_ID>
    ```
    {: pre}

    En utilisant les valeurs de l'exemple, l'URL est `http://169.xx.xxx.xxx:30072`. Dans un navigateur, le texte suivant pourrait s'afficher. Si ce n'est pas le cas, ne vous inquiétez pas. Cette application est conçue pour s'ouvrir et se fermer.
    ```
    Hello World! Great job getting the second stage up and running!
    ```
    {: screen}

    Vous pouvez également vérifier l'URL `http://169.xx.xxx.xxx:30072/healthz` pour obtenir le statut.

    Pour les premières 10 - 15 secondes, un message 200 est renvoyé, ce qui indique que l'application fonctionne correctement. Au bout de ces 15 secondes, un message d'expiration du délai imparti s'affiche. Ce comportement est inattendu.
    ```
    {
      "error": "Timeout, Health check error!"
  }
    ```
    {: screen}
6.  Vérifiez le statut de votre pod pour surveiller l'état de santé de votre application dans Kubernetes. Vous pouvez le faire à partir de l'interface de ligne de commande (CLI) ou dans le tableau de bord Kubernetes.
    *   **A partir de l'interface CLI** : observez ce qui se passe pour vos pods lorsqu'ils changent de statut.
        ```
        kubectl get pods -o wide -w
        ```
        {: pre}
    *   **Dans le tableau de bord Kubernetes** :
        1.  [Lancez le tableau de bord Kubernetes](/docs/containers?topic=containers-app#cli_dashboard).
        2.  Vous pouvez examiner dans l'onglet **Charges de travail** les ressources que vous avez créées. Depuis cet onglet, vous pouvez actualiser l'écran continuellement et constater que le diagnostic d'intégrité opère. Dans la section **Pods**, vous pouvez observer combien de fois les pods sont redémarrés lorsque leurs conteneurs sont recréés. Si l'erreur ci-après s'affiche dans le tableau de bord, ce message indique que le diagnostic d'intégrité a identifié un problème. Patientez quelques minutes, puis actualisez à nouveau la page. Le nombre de tentatives de redémarrage pour chaque pod est affiché.
        ```
        Liveness probe failed: HTTP probe failed with statuscode: 500
        Back-off restarting failed docker container
        Error syncing pod, skipping: failed to "StartContainer" for "hw-container" w      CrashLoopBackOff: "Back-off 1m20s restarting failed container=hw-container pod=hw-d     deployment-3090568676-3s8v1_default(458320e7-059b-11e7-8941-56171be20503)"
        ```
        {: screen}

Vous avez déployé la seconde version de l'application. Vous avez eu à utiliser moins de commandes, vous avez appris comment opère le diagnostic d'intégrité et vous avez édité un déploiement, ce qui est parfait ! L'application Hello World pour l'entreprise de RP a réussi le test. Vous pouvez maintenant déployer une application plus utile pour l'entreprise de RP et commencer à analyser les communiqués de presse.

**Nettoyage**<br>
Prêt à supprimer ce que vous avez créé avant de passer à la leçon suivante ? Cette fois, vous pouvez utiliser le même script de configuration pour supprimer les deux ressources que vous avez créées.

  ```
  kubectl delete -f healthcheck.yml
  ```
  {: pre}

  Exemple de sortie :

  ```
  deployment "hw-demo-deployment" deleted
  service "hw-demo-service" deleted
  ```
  {: screen}

<br />


## Leçon 5 : Déploiement et mise à jour de l'application Watson Tone Analyzer
{: #cs_cluster_tutorial_lesson5}

Dans les leçons précédentes, les applications étaient déployées en tant que composants uniques dans un seul noeud worker. Dans cette leçon, vous pouvez déployer deux composants d'une application dans un cluster qui utilise le service {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}}.
{:shortdesc}

La dispersion des composants dans des conteneurs différents permet de mettre à jour un composant sans affecter l'autre. Ensuite, vous procédez à la mise à jour de l'application pour l'étoffer avec d'autres répliques afin de la rendre encore plus disponible. Le diagramme suivant inclut les composants que vous déployez dans cette leçon.

![Configuration de déploiement](images/cs_app_tutorial_mz-components3.png)

Depuis le tutoriel précédent, vous disposez de votre compte et d'un cluster contenant un noeud worker. Dans cette leçon, vous allez créer une instance du service {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} dans votre compte {{site.data.keyword.Bluemix_notm}} et configurer deux déploiements, un pour chaque composant de l'application. Chaque composant est déployé dans un pod Kubernetes dans le noeud worker. Pour que ces deux composants soient publics, vous créez également un service Kubernetes pour chaque composant.


### Leçon 5a : Déploiement de l'application {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}}
{: #lesson5a}

Déployez les applications {{site.data.keyword.watson}}, accédez au service publiquement et analysez du texte à l'aide de l'application.
{: shortdesc}

Si vous avez fait une pause après la dernière leçon et démarré une nouvelle session de terminal, prenez soin de vous reconnecter à votre cluster.

1.  Depuis une interface CLI, accédez au répertoire `Lab 3`.
    ```
    cd 'container-service-getting-started-wt/Lab 3'
    ```
    {: pre}

2.  Générez la première image {{site.data.keyword.watson}}.
    1.  Accédez au répertoire `watson`.
        ```
        cd watson
        ```
        {: pre}
    2.  Générez, balisez et insérez l'application `watson` sous forme d'image dans votre espace de nom dans {{site.data.keyword.registryshort_notm}}. Ici aussi, n'oubliez pas le point (`.`) à la fin de la commande.
        ```
        ibmcloud cr build -t <region>.icr.io/<namespace>/watson .
        ```
        {: pre}

        Vérifiez qu'un message de réussite est bien affiché.
        ```
        Successfully built <image_id>
        ```
        {: screen}
    3.  Répétez ces étapes pour construire la seconde image `watson-talk`.
        ```
        cd 'container-service-getting-started-wt/Lab 3/watson-talk'
        ```
        {: pre}

        ```
        ibmcloud cr build -t <region>.icr.io/<namespace>/watson-talk .
        ```
        {: pre}
3.  Vérifiez que les images ont bien été ajoutées à votre espace de nom du registre.
    ```
    ibmcloud cr images
    ```
    {: pre}

    Exemple de sortie :

    ```
    Listing images...

    REPOSITORY                        NAMESPACE  TAG      DIGEST         CREATED         SIZE     VULNERABILITY STATUS
    us.icr.io/namespace/watson        namespace  latest   fedbe587e174   3 minutes ago   274 MB   OK
    us.icr.io/namespace/watson-talk   namespace  latest   fedbe587e174   2 minutes ago   274 MB   OK
    ```
    {: screen}
4.  Dans le répertoire `Lab 3`, ouvrez le fichier `watson-deployment.yml` à l'aide d'un éditeur de texte. Ce script de configuration inclut un déploiement et un service tant pour le composant `watson` que pour le composant `watson-talk` de l'application.
    1.  Mettez à jour les informations de l'image dans votre espace de nom du registre pour les deux déploiements.
        **watson** :
        ```
        image: "<region>.icr.io/<namespace>/watson"
        ```
        {: codeblock}

        **watson-talk**:
        ```
        image: "<region>.icr.io/<namespace>/watson-talk"
        ```
        {: codeblock}
    2.  Dans la section des volumes du déploiement `watson-pod`, mettez à jour le nom du secret {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} que vous avez créé dans la [leçon 2](#cs_cluster_tutorial_lesson2). En montant le secret Kubernetes en tant que volume sur votre déploiement, vous rendez la clé d'API {{site.data.keyword.Bluemix_notm}} Identity and Access Management (IAM) disponible sur le conteneur qui s'exécute dans votre pod. Les composants de l'application {{site.data.keyword.watson}} de ce tutoriel sont configurés pour rechercher la clé d'API en utilisant le chemin de montage du volume.
        ```
        volumes:
                - name: service-bind-volume
                  secret:
                    defaultMode: 420
                    secretName: binding-mytoneanalyzer
        ```
        {: codeblock}

        Si vous avez oublié le nom du secret, exécutez la commande suivante.
        ```
        kubectl get secrets --namespace=default
        ```
        {: pre}
    3.  Dans la section du service watson-talk, notez la valeur définie pour `NodePort`. Cet exemple utilise 30080.
5.  Exécutez le script de configuration.
    ```
    kubectl apply -f watson-deployment.yml
    ```
    {: pre}
6.  Facultatif : vérifiez que le secret de {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} est monté en tant que volume sur le pod.
    1.  Pour identifier le nom d'un pod Watson, exécutez la commande suivante.
        ```
        kubectl get pods
        ```
        {: pre}

        Exemple de sortie :
        ```
        NAME                                 READY     STATUS    RESTARTS  AGE
        watson-pod-4255222204-rdl2f          1/1       Running   0         13h
        watson-talk-pod-956939399-zlx5t      1/1       Running   0         13h
        ```
        {: screen}
    2.  Obtenez les détails du pod et recherchez le nom de la clé confidentielle (SecretName).
        ```
        kubectl describe pod <pod_name>
        ```
        {: pre}

        Exemple de sortie :
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
7.  Ouvrez un navigateur et analysez un texte. Le format de l'URL est `http://<worker_node_IP_address>:<watson-talk-nodeport>/analyze/"<text_to_analyze>"`.
    Exemple :
    ```
    http://169.xx.xxx.xxx:30080/analyze/"Today is a beautiful day"
    ```
    {: codeblock}

    Dans un navigateur, vous pouvez voir la réponse JSON pour le texte que vous avez saisi.
    ```
    {
      "document_tone": {
        "tone_categories": [
          {
            "tones": [
              {
                "score": 0.011593,
                "tone_id": "anger",
                "tone_name": "Anger"
              },
              ...
            "category_id": "social_tone",
            "category_name": "Social Tone"
          }
        ]
      }
    }
    ```
    {: screen}
8. [Lancez le tableau de bord Kubernetes](/docs/containers?topic=containers-app#cli_dashboard).
9. Vous pouvez examiner dans l'onglet **Charges de travail** les ressources que vous avez créées.

### Leçon 5b : Mise à jour du déploiement Watson Tone Analyzer en cours d'exécution
{: #lesson5b}

Vous pouvez éditer un déploiement en cours d'exécution en modifiant des valeurs dans le modèle de pod. Dans cette leçon, l'entreprise FR souhaite modifier l'application dans le déploiement en mettant à jour l'image qui est utilisée.
{: shortdesc}

Modifiez le nom de l'image :

1.  Ouvrez les détails de configuration pour le déploiement en cours.
    ```
    kubectl edit deployment/watson-talk-pod
    ```
    {: pre}

    En fonction de votre système d'exploitation, un éditeur vi ou un éditeur de texte s'ouvre.
2.  Modifiez le nom de l'image et remplacez-le par `ibmliberty`.
    ```
    spec:
          containers:
          - image: <region>.icr.io/ibmliberty:latest
    ```
    {: codeblock}
3.  Enregistrez vos modifications et quittez l'éditeur.
4.  Appliquez les modifications au déploiement en cours.
    ```
    kubectl rollout status deployment/watson-talk-pod
    ```
    {: pre}

    Attendez la confirmation indiquant que le déploiement est terminé.
    ```
    deployment "watson-talk-pod" successfully rolled out
    ```
    {: screen}
    Lorsque vous déployez une modification, un autre pod est créé et testé par Kubernetes. Si le test aboutit, l'ancien pod est supprimé.

Bien joué ! Vous avez déployé l'application {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} et appris comment effectuer une mise à jour d'application simple. L'entreprise de RP peut utiliser ce déploiement pour commencer à analyser ses communiqués de presse avec la dernière technologie d'intelligence artificielle. 

**Nettoyage**<br>
Prêt à supprimer l'application {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} que vous avez créée dans votre cluster {{site.data.keyword.containerlong_notm}} ? Vous pouvez utiliser le script de configuration pour supprimer les ressources que vous avez créées.

  ```
  kubectl delete -f watson-deployment.yml
  ```
  {: pre}

  Exemple de sortie :

  ```
  deployment "watson-pod" deleted
  deployment "watson-talk-pod" deleted
  service "watson-service" deleted
  service "watson-talk-service" deleted
  ```
  {: screen}

  Si vous ne voulez pas conserver le cluster, vous pouvez également le supprimer.

  ```
  ibmcloud ks cluster-rm --cluster <cluster_name_or_ID>
  ```
  {: pre}

Nous vous proposons de répondre à un quiz. Vous avez passé en revue beaucoup de documents et vous devez [vous assurer que vous avez bien tout assimilé![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://ibmcloud-quizzes.mybluemix.net/containers/apps_tutorial/quiz.php). Ne vous inquiétez pas, le quiz n'est pas cumulable.
{: note}

<br />


## Etape suivante ?
{: #tutorials_next}

Maintenant que vous maîtrisez les bases, vous pouvez passer à des activités plus avancées. Vous pourriez envisager l'une des tâches suivantes pour en faire plus avec {{site.data.keyword.containerlong_notm}} :
{: shortdesc}

*   Compléter un [lab plus complexe ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://github.com/IBM/container-service-getting-started-wt#lab-overview) dans le référentiel. 
*   Découvrir comment créer des [applications hautement disponibles](/docs/containers?topic=containers-ha) en utilisant des fonctions telles que des clusters à zones multiples, du stockage persistant, le programme de mise à l'échelle automatique de cluster et la mise à l'échelle automatique de pod horizontale pour des applications. 
*   Explorer les modèles de code d'orchestration de conteneur sur le site [IBM Developer ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://developer.ibm.com/technologies/containers/). 
