---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-11"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Intégration de services
{: #integrations}

Vous pouvez utiliser divers services externes, ainsi que des services du catalogue {{site.data.keyword.Bluemix_notm}}, avec un cluster standard dans {{site.data.keyword.containershort_notm}}.
{:shortdesc}

<table summary="Récapitulatif de l'accessibilité">
<caption>Table. Options d'intégration pour les clusters et les applications dans Kubernetes</caption>
<thead>
<tr>
<th>Service</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Blockchain</td>
<td>Permet de déployer un environnement de développement disponible publiquement pour IBM Blockchain sur un cluster Kubernetes dans {{site.data.keyword.containerlong_notm}}. Utilisez cet environnement pour développer et personnaliser votre propre réseau de blockchain afin de déployer des applications qui partagent un grand livre non modifiable dédié à l'enregistrement de l'historique des transactions. Pour plus d'informations, voir <a href="https://ibm-blockchain.github.io" target="_blank">Develop in a cloud sandbox IBM Blockchain Platform <img src="../icons/launch-glyph.svg" alt="Icône de lien externe"></a>. </td>
</tr>
<tr>
<td>Continuous Delivery</td>
<td>Permet d'automatiser vos générations d'applications et vos déploiements de conteneur sur les clusters Kubernetes en utilisant une chaîne d'outils. Pour obtenir des informations de configuration, voir le blogue <a href="https://developer.ibm.com/recipes/tutorials/deploy-kubernetes-pods-to-the-bluemix-container-service-using-devops-pipelines/" target="_blank">Deploy Kubernetes pods to the {{site.data.keyword.containerlong_notm}} using DevOps Pipelines <img src="../icons/launch-glyph.svg" alt="Icône de lien externe"></a>. </td>
</tr>
<tr>
<td>Helm</td>
<td> <a href="https://helm.sh/" target="_blank">Helm <img src="../icons/launch-glyph.svg" alt="Icône de lien externe"></a> est un gestionnaire de package Kubernetes. Créez des graphiques Helm pour définir, installer et mettre à niveau des applications Kubernetes complexes s'exécutant dans des clusters {{site.data.keyword.containerlong_notm}}. Pour en savoir plus, voir comment <a href="https://developer.ibm.com/recipes/tutorials/increase-deployment-velocity-with-kubernetes-helm-charts/" target="_blank">augmenter la vitesse de déploiement avec les graphiques Kubernetes Helm <img src="../icons/launch-glyph.svg" alt="Icône de lien externe"></a>. </td>
</tr>
<tr>
<td>Instana</td>
<td> <a href="https://www.instana.com/" target="_blank">Instana <img src="../icons/launch-glyph.svg" alt="Icône de lien externe"></a> permet de surveiller les performances de l'infrastructure et des applications à l'aide d'une interface graphique qui découvre et mappe automatiquement vos applications. De plus, Istana capture toutes le demandes envoyées à vos applications, de sorte que vous pouvez identifier et résoudre les problèmes et procéder à l'analyse leur origine afin d'éviter qu'ils se reproduisent. Pour en savoir plus, consultez l'article de blogue sur le <a href="https://www.instana.com/blog/precise-visibility-applications-ibm-bluemix-container-service/" target="_blank">déploiement d'Istana dans {{site.data.keyword.containershort_notm}} <img src="../icons/launch-glyph.svg" alt="Icône de lien externe"></a>.</td>
</tr>
<tr>
<td>Istio</td>
<td><a href="https://www.ibm.com/cloud/info/istio" target="_blank">Istio<img src="../icons/launch-glyph.svg" alt="Icône de lien externe"></a> est un service open source qui permet aux développeurs de connecter, de sécuriser et de gérer de manière uniforme un réseau de microservices, également dénommé maillage de services, sur des plateformes d'orchestration cloud telles que Kubernetes. Pour en savoir plus sur le projet open source, consultez l'article de blogue rappelant qu'<a href="https://developer.ibm.com/dwblog/2017/istio/" target="_blank">IBM a cofondé et a lancé Istio<img src="../icons/launch-glyph.svg" alt="Icône de lien externe"></a>. Pour installer Istio sur votre cluster Kubernetes dans {{site.data.keyword.containershort_notm}} et commencer à utiliser l'exemple d'application, voir [Tutoriel : Gestion de microservices avec Istio](cs_tutorials_istio.html#istio_tutorial).</td>
</tr>
<tr>
<td>Prometheus</td>
<td>Prometheus est un outil à code source ouvert de surveillance, de journalisation et d'alerte conçu spécifiquement pour Kubernetes afin d'extraire des informations détaillées sur le cluster, les noeuds d'agent et l'état de santé du déploiement à partir des informations de journalisation de Kubernetes. Les informations d'utilisation de l'UC, de la mémoire et du réseau de tous les conteneurs en activité sont collectées et peuvent être utilisées dans des interrogations ou des alertes personnalisées pour surveiller les performances et les charges de travail de votre cluster.
<p>Pour utiliser Prometheus, procédez comme suit :</p>
<ol>
<li>Installez Prometheus en suivant <a href="https://github.com/coreos/prometheus-operator/tree/master/contrib/kube-prometheus" target="_blank">les instructions CoreOS<img src="../icons/launch-glyph.svg" alt="Icône de lien externe"></a>.
<ol>
<li>Lorsque vous exécutez la commande export, utilisez votre espace de nom kube-system. <p><code>export NAMESPACE=kube-system hack/cluster-monitoring/deploy</code></p></li>
</ol>
</li>
<li>Une fois que Prometheus a été déployé dans votre cluster, éditez dans Grafana la source de données Prometheus pour se référer à
<code>prometheus.kube-system:30900</code>.</li>
</ol>
</td>
</tr>
<tr>
<td>{{site.data.keyword.bpshort}}</td>
<td>{{site.data.keyword.bplong}} est un outil d'automatisation qui utilise Terraform pour déployer votre infrastructure sous forme de code. Lorsque vous déployez l'infrastructure en tant qu'unité simple, vous pouvez réutiliser ces définitions de ressource de cloud dans d'autres environnements. Pour définir un cluster Kubernetes comme une ressource avec {{site.data.keyword.bpshort}}, essayez de créer un environnement avec le [modèle conteneur-cluster](https://console.bluemix.net/schematics/templates/details/Cloud-Schematics%2Fcontainer-cluster). Pour plus d'informations sur Schematics, voir [A propos d'{{site.data.keyword.bplong_notm}}](/docs/services/schematics/schematics_overview.html#about).</td>
</tr>
<tr>
<td>Weave Scope</td>
<td>Weave Scope produit un diagramme visuel de vos ressources dans un cluster Kubernetes, notamment des services, pods, conteneurs, processus, noeuds, et autres. Weave Scope fournit des métriques interactives sur l'utilisation de l'UC et de la mémoire, ainsi que des outils pour suivi et exécution dans un conteneur.<p>Pour plus d'informations, voir [Visualisation de ressources de cluster Kubernetes via Weave Scope et {{site.data.keyword.containershort_notm}}](cs_integrations.html#weavescope).</p></li></ol>
</td>
</tr>
</tbody>
</table>

<br />



## Ajout de services à des clusters
{: #adding_cluster}

Ajoutez une instance de service {{site.data.keyword.Bluemix_notm}} existante à votre cluster pour permettre aux utilisateurs du cluster d'accéder et d'utiliser le service {{site.data.keyword.Bluemix_notm}} lorsqu'ils déploient une application dans le cluster.
{:shortdesc}

Avant de commencer :

1. [Ciblez votre interface de ligne de commande](cs_cli_install.html#cs_cli_configure) vers votre cluster.
2. [Demandez une instance du service {{site.data.keyword.Bluemix_notm}} service](/docs/manageapps/reqnsi.html#req_instance).
   **Remarque :** pour créer une instance de service sur le site Washington DC, vous devez utiliser l'interface CLI.

**Remarque :**
<ul><ul>
<li>Vous ne pouvez ajouter que des services {{site.data.keyword.Bluemix_notm}} qui prennent en charge les clés de service. Si le service ne prend pas en charge les clés de service, voir [Utilisation des services {{site.data.keyword.Bluemix_notm}} avec des applications externes](/docs/manageapps/reqnsi.html#accser_external).</li>
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


Pour utiliser le service dans un pod qui est déployé dans le cluster, les utilisateurs du cluster peuvent accéder aux données d'identification du service {{site.data.keyword.Bluemix_notm}} en [montant la valeur confidentielle Kubernetes en tant que volume secret sur un pod.](cs_integrations.html#adding_app)

<br />



## Ajout de services à des applications
{: #adding_app}

Des valeurs confidentielles Kubernetes chiffrées sont utilisées pour stocker les informations détaillées du service {{site.data.keyword.Bluemix_notm}} et ses données d'identification, ainsi que pour permettre une communication sécurisée entre le service et le cluster. En tant qu'utilisateur du cluster,
vous pouvez accéder à cette valeur confidentielle en la montant en tant que volume dans un pod.
{:shortdesc}

Avant de commencer, [ciblez avec votre interface de ligne de commande](cs_cli_install.html#cs_cli_configure) votre cluster. Vérifiez que le service {{site.data.keyword.Bluemix_notm}} que vous souhaitez utiliser dans votre application
a été [ajouté au cluster](cs_integrations.html#adding_cluster) par l'administrateur du cluster.

Les valeurs confidentielles Kubernetes permettent de stocker de manière
sécurisée des informations sensibles, comme les noms de utilisateurs, leur mots de passe ou leur clés. Au lieu d'exposer ces informations confidentielles via des variables d'environnement, ou
directement dans le fichier Dockerfile, ces valeurs doivent être montées en tant que
volume secret sur un pod pour être accessibles à un conteneur en exécution dans un pod.

Lorsque vous montez un volume secret sur votre pod, un fichier nommé binding est stocké dans le répertoire de montage du volume et contient toutes les informations et données d'identification dont vous avez besoin pour accéder au service {{site.data.keyword.Bluemix_notm}}.

1.  Répertoriez les valeurs confidentielles disponibles dans l'espace de nom de votre cluster.

    ```
    kubectl get secrets --namespace=<my_namespace>
    ```
    {: pre}

    Exemple de sortie :

    ```
    NAME                                    TYPE                                  DATA      AGE
    binding-<service_instance_name>         Opaque                                1         3m

    ```
    {: screen}

2.  Recherchez une valeur confidentielle du type **Opaque** et notez le
**nom** de cette valeur confidentielle. Si plusieurs valeurs confidentielles existent, contactez l'administrateur de votre cluster pour identifier la valeur confidentielle appropriée.

3.  Ouvrez l'éditeur de votre choix.

4.  Créez un fichier YAML pour configurer un pod pouvant accéder aux informations détaillées du service via un volume secret.

    ```
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
      labels:
        app: secret-test
      name: secret-test
      namespace: <my_namespace>
    spec:
      selector:
        matchLabels:
          app: secret-test
      replicas: 1
      template:
        metadata:
          labels:
            app: secret-test
        spec:
          containers:
          - image: nginx
            name: secret-test
            volumeMounts:
            - mountPath: /opt/service-bind
              name: service-bind-volume
          volumes:
          - name: service-bind-volume
            secret:
              defaultMode: 420
              secretName: binding-<service_instance_name>
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code>volumeMounts/mountPath</code></td>
    <td>Nom du volume secret que vous désirez monter dans le conteneur.</td>
    </tr>
    <tr>
    <td><code>volumes/name</code></td>
    <td>Entrez un nom pour le volume secret que vous désirez monter dans votre conteneur.</td>
    </tr>
    <tr>
    <td><code>secret/defaultMode</code></td>
    <td>Affectez des droit d'accès en lecture seule à la valeur confidentielle du service.</td>
    </tr>
    <tr>
    <td><code>secret/secretName</code></td>
    <td>Entre le nom de la valeur confidentielle que vous avez noté plus tôt.</td>
    </tr></tbody></table>

5.  Créez la nacelle et montez le volume secret.

    ```
    kubectl apply -f <yaml_path>
    ```
    {: pre}

6.  Vérifiez que la nacelle a bien été créée.

    ```
    kubectl get pods --namespace=<my_namespace>
    ```
    {: pre}

    Exemple de sortie d'interface CLI :

    ```
    NAME                           READY     STATUS    RESTARTS   AGE
    secret-test-1111454598-gfx32   1/1       Running   0          1m
    ```
    {: screen}

7.  Notez la valeur **NAME** de votre pod.
8.  Obtenez les détails du pod et recherchez le nom de la clé confidentielle.

    ```
    kubectl describe pod <pod_name>
    ```
    {: pre}

    Sortie :

    ```
    ...
    Volumes:
      service-bind-volume:
        Type:       Secret (a volume populated by a Secret)
        SecretName: binding-<service_instance_name>
    ...
    ```
    {: screen}

    

9.  Lors de l'implémentation de votre application, configurez-la afin de rechercher le fichier de valeur confidentielle nommé **binding** sous le répertoire de montage, d'analyser le contenu
JSON et de déterminer l'URL et les données d'identification du service pour accéder à votre service {{site.data.keyword.Bluemix_notm}}.

Vous pouvez à présent accéder aux informations détaillées et aux données d'identification du service {{site.data.keyword.Bluemix_notm}}. Pour utiliser votre service
{{site.data.keyword.Bluemix_notm}},
vérifiez que votre application est configurée pour rechercher le fichier de la valeur
confidentielle du service dans le répertoire de montage, analyser le contenu JSON et
examiner les informations détaillées du service.

<br />



## Visualisation de ressources de cluster Kubernetes
{: #weavescope}

Weave Scope produit un diagramme visuel de vos ressources dans un cluster Kubernetes, notamment des services, pods, conteneurs, processus, noeuds, et autres. Weave Scope fournit des métriques interactives sur l'utilisation de l'UC et de la mémoire, ainsi que des outils pour suivi et exécution dans un conteneur.
{:shortdesc}

Avant de commencer :

-   Prenez soin de ne pas exposer les informations de votre cluster sur l'Internet public. Procédez comme suit pour déployer de manière sécurisée Weave Scope et y accéder en local depuis un navigateur Web.
-   Si ne n'est déjà fait, [créez un cluster standard](cs_clusters.html#clusters_ui). Weave Scope peut solliciter énormément l'unité centrale, surtout l'application. Utilisez Weave Scope avec des clusters standard plus volumineux, et non pas avec des clusters légers.
-   [Ciblez avec votre interface CLI](cs_cli_install.html#cs_cli_configure) votre cluster pour exécuter des commandes `kubectl`.


Pour utiliser Weave Scope avec un cluster, procédez comme suit :
2.  Déployez dans le cluster l'un des fichiers de configuration d'autorisations RBAC fournis.

    Pour activer les droits d'accès en lecture / écriture, exécutez la commande suivante :

    ```
    kubectl apply -f "https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/weave-scope/weave-scope-rbac.yaml"
    ```
    {: pre}

    Pour activer les droits d'accès en lecture seule, exécutez la commande suivante :

    ```
    kubectl apply -f "https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/weave-scope/weave-scope-rbac-readonly.yaml"
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

