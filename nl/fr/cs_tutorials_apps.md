---

copyright:
  years: 2014, 2018
lastupdated: "2017-12-08"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Tutoriel : Déploiement d'applications dans des clusters
{: #cs_apps_tutorial}

Ce second tutoriel vous explique comment utiliser Kubernetes pour déployer une application conteneurisée qui tire parti du service {{site.data.keyword.watson}} {{site.data.keyword.toneanalyzershort}} {{site.data.keyword.Bluemix_notm}}. L'entreprise PR utilise {{site.data.keyword.watson}} pour analyser ses communiqués de presse et recevoir un retour d'informations sur le ton dans ses messages.
{:shortdesc}

Dans ce scénario, le développeur d'applications de l'entreprise PR déploie une version Hello World de l'application dans le cluster
Kubernetes créé par l'administrateur réseau au cours du [premier tutoriel](cs_tutorials.html#cs_cluster_tutorial).

Chaque leçon explique comment déployer progressivement des versions plus compliquées de la même application. Le diagramme suivant illustre les composants des déploiements de l'application du tutoriel, excepté la quatrième partie.

![Composants de la leçon](images/cs_app_tutorial_roadmap.png)

Comme illustré dans le diagramme, Kubernetes utilise plusieurs types de ressources pour rendre vos applications opérationnelles dans des clusters. Dans Kubernetes, les déploiements et les services fonctionnent en tandem. Les déploiements incluent les définitions utilisées par l'application (par exemple, l'image à utiliser pour le conteneur et le port à exposer pour l'application). Lorsque vous créez un déploiement, un pod Kubernetes est créé pour chaque conteneur que vous avez défini dans le déploiement. Pour rendre votre application plus résiliente, vous pouvez définir plusieurs instances de la même application dans votre déploiement et
permettre à Kubernetes de créer automatiquement un jeu de répliques pour vous. Le jeu de répliques surveille les pods et garantit que le nombre de pods désiré est en opération en tout temps. Si un pod ne répond plus, il est recréé automatiquement.

Les services regroupent un ensemble de pods et fournissent une connexion réseau vers ces pods à d'autres services dans le cluster sans exposer l'adresse IP privée réelle de chaque pod. Vous pouvez utiliser les services Kubernetes pour rendre une application accessible à d'autres pods dans le cluster ou pour l'exposer sur Internet. Dans ce tutoriel, vous utiliserez un service Kubernetes pour accéder depuis Internet à votre application en opération en utilisant l'adresse IP publique affectée automatiquement à un noeud worker et un port public.

Pour rendre votre application encore plus disponible, dans les clusters standard, vous pouvez créer plusieurs noeuds d'agent, de manière à disposer encore d'un plus grand nombre de répliques de votre application. Cette tâche n'est pas couverte par le tutoriel, mais envisagez-la en vue d'améliorations futures de la disponibilité d'une application.

Une seule leçon couvre l'intégration d'un service {{site.data.keyword.Bluemix_notm}} dans une application, mais vous pouvez les utiliser qu'il s'agisse d'une application toute simple, ou aussi complexe que vous pouvez imaginer.

## Objectifs

* Assimiler la terminologie Kubernetes de base
* Envoyer par commande push une image vers votre espace de nom du registre dans {{site.data.keyword.registryshort_notm}}
* Rendre une application accessible au public
* Déployer une instance unique d'une application dans un cluster à l'aide d'une commande Kubernetes et d'un script
* Déployer plusieurs instances d'une application dans des conteneurs recréés lors de la vérification de leur état de santé
* Déployer une application utilisant des fonctionnalités d'un service {{site.data.keyword.Bluemix_notm}}

## Durée

40 minutes

## Publics

Développeurs de logiciels et administrateurs réseau n'ayant encore jamais déployé une application dans un cluster Kubernetes.

## Conditions
prérequises

[Tutoriel : Création de clusters Kubernetes dans {{site.data.keyword.containershort_notm}}](cs_tutorials.html#cs_cluster_tutorial).

## Leçon 1 : Déploiement d'applications avec instance unique dans des clusters Kubernetes
{: #cs_apps_tutorial_lesson1}

Dans cette leçon, vous déployez une seule instance de l'application Hello World dans un cluster. Le diagramme suivant inclut les composants que vous déployez dans cette leçon.
{:shortdesc}

![Configuration de déploiement](images/cs_app_tutorial_components1.png)

Depuis le tutoriel précédent, vous disposez d'un compte et d'un cluster contenant déjà un noeud worker. Dans cette leçon, vous configurez un déploiement et déployez l'application Hello world dans un pod Kubernetes du noeud worker. Pour une disponibilité publique, vous créez un service Kubernetes.


1.  Connectez-vous à l'interface CLI de {{site.data.keyword.Bluemix_notm}}. A l'invite, entrez vos données d'identification {{site.data.keyword.Bluemix_notm}}. Pour stipuler une région {{site.data.keyword.Bluemix_notm}}, [incluez son noeud final d'API](cs_regions.html#bluemix_regions).

    ```
    bx login
    ```
    {: pre}

    **Remarque :** si vous possédez un ID fédéré, exécutez la commande `bx login --sso` pour vous connecter à l'interface de ligne de commande {{site.data.keyword.Bluemix_notm}}. Entrez votre nom d'utilisateur et utilisez l'URL mentionnée dans la sortie CLI pour extraire votre code d'accès à usage unique. Si la connexion échoue alors que vous omettez l'option `--sso` et aboutit en incluant l'option `--sso`, ceci indique que votre ID est fédéré.

2.  Définissez dans votre interface CLI le contexte du cluster.
    1.  Obtenez la commande permettant de définir la variable d'environnement et téléchargez les fichiers de configuration Kubernetes.

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

    2.  Copiez et collez la commande qui s'affiche sur votre terminal pour définir la variable d'environnement `KUBECONFIG`.
    3.  Vérifiez que la variable d'environnement `KUBECONFIG` est correctement définie.

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
        Client Version: v1.7.4
        Server Version: v1.7.4
        ```
        {: screen}

3.  Lancez Docker.
    * Si vous utilisez Docker CE, aucune action n'est nécessaire.
    * Si vous utilisez Linux, reportez-vous à la [documentation Docker ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://docs.docker.com/engine/admin/) pour obtenir les instructions de lancement de Docker selon la distribution Linux que vous utilisez.
    * Si vous utilisez Docker Toolbox sur Windows ou OSX, vous pouvez utiliser le programme Docker Quickstart Terminal,
lequel démarre Docker pour vous. Utilisez ce programme dans les prochaines étapes pour exécuter les commandes
Docker, puis revenez à l'interface CLI pour définir la variable de session `KUBECONFIG`.
        * Si vous utilisez Docker QuickStart Terminal, exécutez à nouveau la commande de connexion à l'interface CLI de {{site.data.keyword.Bluemix_notm}}.

          ```
          bx login
          ```
          {: pre}

4.  Connectez-vous à l'interface CLI de {{site.data.keyword.registryshort_notm}}. **Remarque** : vérifiez que vous avez le plug-in container-registry [installé](/docs/services/Registry/index.html#registry_cli_install).

    ```
    bx cr login
    ```
    {: pre}

    -   Si vous ne vous rappelez plus de votre espace de nom dans {{site.data.keyword.registryshort_notm}}, exécutez la commande suivante.

        ```
        bx cr namespace-list
        ```
        {: pre}

5.  Clonez ou téléchargez le code source de l'[application Hello world ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://github.com/Osthanes/container-service-getting-started-wt) dans votre répertoire utilisateur personnel.

    ```
    git clone https://github.com/Osthanes/container-service-getting-started-wt.git
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

8.  Créez un déploiement Kubernetes intitulé _hello-world-deployment_ pour déployer l'application dans un pod de votre cluster. Les déploiements sont utilisés pour gérer les pods, lesquels contiennent des instances conteneurisées d'une application. Le déploiement suivant déploie l'application dans un seul pod.

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

9.  Rendez l'application accessible au public en exposant le déploiement en tant que service NodePort. Les services mettent en réseau l'application. Comme le cluster n'a qu'un seul noeud worker et non plusieurs, un équilibrage de charge entre les noeuds d'agent n'est pas nécessaire. De la sorte, un NodePort peut être utilisé pour accorder aux utilisateurs externes un accès à l'application. Tout comme quand vous exposez un port pour une application Cloud Foundry, le NodePort que vous exposez est celui sur lequel le noeud worker est à l'écoute de trafic. Dans une étape ultérieure, vous identifierez quel NodePort a été affecté aléatoirement au service.

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
    <table summary=“Information about the expose command parameters.”>
    <caption>Tableau 1. Paramètres de commande</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Idea icon"/> Informations additionnelles sur les paramètres de la commande expose</th>
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

    2.  Identifiez l'adresse IP publique du noeud worker dans le cluster.

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

11. Ouvre un navigateur et accédez à l'application via l'URL `http://<IP_address>:<NodePort>`. En utilisant les valeurs de l'exemple, l'URL serait la suivante : `http://169.47.227.138:30872`. Lorsque vous entrez cette
URL dans un navigateur, le texte suivant apparaît.

    ```
    Hello World! Your app is up and running in a cluster!
    ```
    {: screen}

    Vous pouvez communiquer cette URL à un collègue pour qu'il l'essaye, ou bien l'entrer dans le navigateur de votre téléphone portable pour constater que l'application Hello World est réellement accessible au public.

12. Lancez le tableau de bord Kubernetes via le port par défaut (8001).
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
         {: pre}

13. Vous pouvez examiner dans l'onglet **Charges de travail** les ressources que vous avez créées. Lorsque vous avez fini d'explorer le tableau de bord Kubernetes, utilisez les touches CTRL+C pour quitter la commande `proxy`.

Félicitations ! Vous venez de déployer la première version de l'application.

Trop de commandes dans cette leçon ? Nous sommes bien d'accord. Que diriez-vous d'utiliser un script de configuration pour se charger d'une partie du travail à votre place ? Pour utiliser un script de configuration pour la seconde version de l'application et pour
promouvoir une plus haute disponibilité en déployant plusieurs instances de l'application, passez à la leçon suivante.



## Leçon 2 : Déploiement et mise à jour d'applications avec une plus haute disponibilité
{: #cs_apps_tutorial_lesson2}

Dans cette leçon, vous allez déployer trois instances de l'application Hello World dans un cluster pour assurer une plus haute disponibilité de l'application que dans la première version. Une plus haute disponibilité signifie que l'accès utilisateur est divisé entre les trois
instances. Lorsqu'un trop grand nombre d'utilisateurs tentent d'accéder à la même instance de l'application, ils peuvent être confrontés à des temps de réponse lents. L'existence de plusieurs instances peut induire des temps de réponse plus rapides pour vos utilisateurs. Dans cette leçon, vous découvrirez également comment des bilans de santé et des mises à jour des déploiements peuvent opérer avec
Kubernetes.
{:shortdesc}

Le diagramme suivant inclut les composants que vous déployez dans cette leçon.

![Configuration de déploiement](images/cs_app_tutorial_components2.png)

Depuis le tutoriel précédent, vous disposez de votre compte et d'un cluster contenant un noeud worker. Dans cette leçon, vous configurez un déploiement et déployez trois instances de l'application Hello world. Chaque instance est déployée dans un pod Kubernetes dans le cadre d'un jeu de répliques dans le noeud worker. Pour une disponibilité publique, vous créez également un service Kubernetes.

Comme défini dans le script de configuration, Kubernetes peut utiliser une vérification de la disponibilité pour déterminer si un conteneur dans un pod est en opération ou non. Ces vérifications peuvent, par exemple, identifier des interblocages, où une application est en opération, mais ne parvient pas à progresser. Le redémarrage d'un conteneur dans cette situation peut aider à
rendre l'application disponible malgré les bogues. Kubernetes utilise ensuite une vérification de l'état de préparation du conteneur pour déterminer quand il est à nouveau prêt à accepter le trafic. Un pod est considéré comme prêt quand son conteneur est lui-même prêt. Une fois le pod prêt, il est redémarré. Dans l'application Stage2, le délai d'attente de l'application expire toutes les 15 secondes. Lorsqu'un bilan de santé est configuré dans le script de configuration, les conteneurs sont recréés si cette vérification détecte un problème affectant une application.

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
traiter les incidents en recréant les pods.

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

8.  Ouvrez un navigateur et accédez à l'application. Pour composer l'URL, utilisez pour votre noeud worker la même adresse IP publique que dans la leçon précédente et combinez-la avec le NodePort spécifié dans le script de configuration. Pour obtenir l'adresse IP publique du noeud worker, utilisez la commande suivante :

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
    1.  Définissez le proxy avec le numéro de port par défaut.

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
**Pods**, vous pouvez observer combien de fois les pods sont redémarrés quand leurs conteneurs sont recréés. Si l'erreur ci-après s'affiche dans le tableau de bord, ce message indique que le bilan de santé a identifié un problème. Patientez quelques minutes, puis actualisez à nouveau la page. Le nombre de tentatives de redémarrage pour chaque pod est affiché.

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

## Leçon 3 : Déploiement et mise à jour de l'application Watson Tone Analyzer
{: #cs_apps_tutorial_lesson3}

Dans les leçons précédentes, les applications étaient déployées en tant que composants uniques dans un seul noeud worker. Dans cette leçon, vous allez déployer deux composants d'une application dans un cluster
qui utilise le service Watson Tone Analyzer que vous avez ajouté à votre cluster dans le
tutoriel précédent. La dispersion des composants dans des conteneurs différents permet de mettre à jour un composant sans affecter l'autre. Vous mettrez ensuite à jour l'application pour l'étoffer avec d'autres répliques afin de la rendre plus disponible.
{:shortdesc}

Le diagramme suivant inclut les composants que vous déployez dans cette leçon.

![Configuration de déploiement](images/cs_app_tutorial_components3.png)

Depuis le tutoriel précédent, vous disposez de votre compte et d'un cluster contenant un noeud worker. Dans cette leçon, vous créez une instance de service Watson Tone Analyzer dans votre compte {{site.data.keyword.Bluemix_notm}} et configurez deux déploiements, un pour chaque composant de l'application. Chaque composant est déployé dans un pod Kubernetes dans le noeud worker. Pour que ces deux composants soient publics, vous créez également un service Kubernetes pour chaque composant.


### Leçon 3a : Déploiement de l'application Watson Tone Analyzer
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
disposition du conteneur exécuté dans votre pod. Les composants de l'application {{site.data.keyword.watson}} de ce tutoriel sont configurés pour rechercher les données d'identification du
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
volume sur le pod.

    1.  Pour identifier le nom d'un pod Watson, exécutez la commande suivante.

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

    2.  Obtenez les détails du pod et recherchez le nom de la clé confidentielle.

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

11. Vous pouvez examiner dans l'onglet **Charges de travail** les ressources que vous avez créées. Lorsque vous avez fini d'explorer le tableau de bord Kubernetes, utilisez les touches CTRL+C pour quitter la commande `proxy`.

### Leçon 3b. Mise à jour du déploiement Watson Tone Analyzer en exécution
{: #lesson3b}

Vous pouvez éditer un déploiement en cours d'exécution en modifiant des valeurs dans le modèle de pod. Cette leçon comprend la mise à jour de l'image qui a été utilisée. L'entreprise de relations publiques désire modifier l'application dans le déploiement.

Modifiez le nom de l'image :

1.  Ouvrez les détails de configuration pour le déploiement en cours.

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

4.  Appliquez les modifications au déploiement en cours.

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

    Lorsque vous déployez une modification, un autre pod est créé et testé par Kubernetes. Si le test aboutit, l'ancien pod est supprimé.

[Testez vos connaissances en répondant à un quiz !![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://ibmcloud-quizzes.mybluemix.net/containers/apps_tutorial/quiz.php)

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

## Etape suivante ?
{: #next}

Essayez d'explorer les méthodologies d'orchestration de conteneur sur le site [developerWorks ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://developer.ibm.com/code/journey/category/container-orchestration/).
