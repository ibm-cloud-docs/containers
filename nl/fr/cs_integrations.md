---

copyright:
  years: 2014, 2018
lastupdated: "2018-09-10"

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

Vous pouvez utiliser différents services externes et services de catalogue avec un cluster Kubernetes standard dans {{site.data.keyword.containerlong}}.
{:shortdesc}


## Services d'application
{: #application_services}
<table summary="Récapitulatif de l'accessibilité">
<caption>Services d'application</caption>
<thead>
<tr>
<th>Service</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>{{site.data.keyword.blockchainfull}}</td>
<td>Permet de déployer un environnement de développement disponible publiquement pour IBM Blockchain sur un cluster Kubernetes dans {{site.data.keyword.containerlong_notm}}. Utilisez cet environnement pour développer et personnaliser votre propre réseau de blockchain afin de déployer des applications qui partagent un grand livre non modifiable dédié à l'enregistrement de l'historique des transactions. Pour plus d'informations, voir <a href="https://ibm-blockchain.github.io" target="_blank">Develop in a cloud sandbox IBM Blockchain Platform <img src="../icons/launch-glyph.svg" alt="Icône de lien externe"></a>. </td>
</tr>
</tbody>
</table>

<br />



## Services DevOps
{: #devops_services}
<table summary="Récapitulatif de l'accessibilité">
<caption>Services DevOps</caption>
<thead>
<tr>
<th>Service</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Codeship</td>
<td>Vous pouvez utiliser <a href="https://codeship.com" target="_blank">Codeship <img src="../icons/launch-glyph.svg" alt="Icône de lien externe"></a> pour l'intégration et la distribution continues de conteneurs. Pour plus d'informations, voir <a href="https://www.ibm.com/blogs/bluemix/2017/10/using-codeship-pro-deploy-workloads-ibm-container-service/" target="_blank">Using Codeship Pro To Deploy Workloads to {{site.data.keyword.containerlong_notm}} <img src="../icons/launch-glyph.svg" alt="Icône de lien externe"></a>. </td>
</tr>
<tr>
<td>Helm</td>
<td> <a href="https://helm.sh" target="_blank">Helm <img src="../icons/launch-glyph.svg" alt="Icône de lien externe"></a> est un gestionnaire de package Kubernetes. Vous pouvez créer de nouvelles chartes Helm ou utiliser des chartes Helm préexistantes pour définir, installer et mettre à niveau des applications Kubernetes complexes qui s'exécutent dans les clusters {{site.data.keyword.containerlong_notm}}. <p>Pour plus d'informations, voir [Configuration de Helm dans {{site.data.keyword.containerlong_notm}}](cs_integrations.html#helm).</p></td>
</tr>
<tr>
<td>{{site.data.keyword.contdelivery_full}}</td>
<td>Permet d'automatiser vos générations d'applications et vos déploiements de conteneur sur les clusters Kubernetes en utilisant une chaîne d'outils. Pour obtenir des informations de configuration, voir le blogue <a href="https://developer.ibm.com/recipes/tutorials/deploy-kubernetes-pods-to-the-bluemix-container-service-using-devops-pipelines/" target="_blank">Deploy Kubernetes pods to the {{site.data.keyword.containerlong_notm}} using DevOps Pipelines <img src="../icons/launch-glyph.svg" alt="Icône de lien externe"></a>. </td>
</tr>
<tr>
<td>Istio</td>
<td><a href="https://www.ibm.com/cloud/info/istio" target="_blank">Istio <img src="../icons/launch-glyph.svg" alt="Icône de lien externe"></a> est un service open source qui permet aux développeurs de connecter, de sécuriser et de gérer de manière uniforme un réseau de microservices, également dénommé maillage de services, sur des plateformes d'orchestration cloud telles que Kubernetes. Pour en savoir plus sur le projet open source, consultez l'article de blogue qui révèle <a href="https://developer.ibm.com/dwblog/2017/istio/" target="_blank">comment IBM a cofondé et lancé Istio<img src="../icons/launch-glyph.svg" alt="Icône de lien externe"></a>. Pour installer Istio sur votre cluster Kubernetes dans {{site.data.keyword.containerlong_notm}} et commencer à utiliser un modèle d'application, voir [Tutoriel : Gestion de microservices avec Istio](cs_tutorials_istio.html#istio_tutorial).</td>
</tr>
</tbody>
</table>

<br />



## Services de consignation et de surveillance
{: #health_services}
<table summary="Récapitulatif de l'accessibilité">
<caption>Services de consignation et de surveillance</caption>
<thead>
<tr>
<th>Service</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>CoScale</td>
<td>Vous pouvez surveiller les noeuds worker, les conteneurs, les jeux de répliques, les contrôleurs de réplication et les services à l'aide de <a href="https://www.coscale.com/" target="_blank">CoScale <img src="../icons/launch-glyph.svg" alt="Icône de lien externe"></a>. Pour plus d'informations, voir <a href="https://www.ibm.com/blogs/bluemix/2017/06/monitoring-ibm-bluemix-container-service-coscale/" target="_blank">Monitoring {{site.data.keyword.containerlong_notm}} with CoScale <img src="../icons/launch-glyph.svg" alt="Icône de lien externe"></a>. </td>
</tr>
<tr>
<td>Datadog</td>
<td>Vous pouvez surveiller votre cluster et examiner les performances de l'infrastructure et les métriques d'application à l'aide de <a href="https://www.datadoghq.com/" target="_blank">Datadog <img src="../icons/launch-glyph.svg" alt="Icône de lien externe"></a>. Pour plus d'informations, voir <a href="https://www.ibm.com/blogs/bluemix/2017/07/monitoring-ibm-bluemix-container-service-datadog/" target="_blank">Monitoring {{site.data.keyword.containerlong_notm}} with Datadog <img src="../icons/launch-glyph.svg" alt="Icône de lien externe"></a>. </td>
</tr>
<tr>
<td> {{site.data.keyword.cloudaccesstrailfull}}</td>
<td>Surveillez les activités d'administration intervenant dans votre cluster en analysant les journaux via Grafana. Pour plus d'informations sur ce service, voir la documentation d'[Activity Tracker](/docs/services/cloud-activity-tracker/index.html). Pour plus d'informations sur les types d'événement dont vous pouvez assurer le suivi, voir [Evénements Activity Tracker](/cs_at_events.html).</td>
</tr>
<tr>
<td>{{site.data.keyword.loganalysisfull}}</td>
<td>Développez vos capacités de collecte, de conservation et de recherche de journaux avec {{site.data.keyword.loganalysisfull_notm}}. Pour plus d'informations, voir <a href="../services/CloudLogAnalysis/containers/containers_kube_other_logs.html" target="_blank">Activation de la collecte automatique des journaux de cluster <img src="../icons/launch-glyph.svg" alt="Icône de lien externe"></a>. </td>
</tr>
<tr>
<td>{{site.data.keyword.monitoringlong}}</td>
<td>Développez vos capacités de collecte et de conservation des métriques en définissant des règles et des alertes avec {{site.data.keyword.monitoringlong_notm}}. Pour plus d'informations, voir <a href="../services/cloud-monitoring/tutorials/container_service_metrics.html" target="_blank">Analyse des métriques dans Grafana pour une application qui est déployée dans un cluster Kubernetes <img src="../icons/launch-glyph.svg" alt="Icône de lien externe"></a>. </td>
</tr>
<tr>
<td>Instana</td>
<td> <a href="https://www.instana.com/" target="_blank">Instana <img src="../icons/launch-glyph.svg" alt="Icône de lien externe"></a> permet de surveiller les performances de l'infrastructure et des applications à l'aide d'une interface graphique qui découvre et mappe automatiquement vos applications. Instana capture toutes les demandes adressées à vos applications, que vous pouvez utiliser pour identifier et résoudre les problèmes et effectuer une analyse de leur cause première pour éviter qu'ils ne se reproduisent. Pour en savoir plus, consultez l'article de blogue sur le <a href="https://www.instana.com/blog/precise-visibility-applications-ibm-bluemix-container-service/" target="_blank">déploiement d'Instana dans {{site.data.keyword.containerlong_notm}} <img src="../icons/launch-glyph.svg" alt="Icône de lien externe"></a>.</td>
</tr>
<tr>
<td>Prometheus</td>
<td>Prometheus est un outil open source de surveillance, de consignation et d'alerte spécialement conçu pour Kubernetes. Prometheus extrait des informations détaillées sur le cluster, les noeuds worker et l'état de santé du déploiement à partir des informations de consignation de Kubernetes. L'activité de l'UC, de la mémoire, des E-S et du réseau est collectée pour chaque conteneur s'exécutant dans un cluster. Vous pouvez utiliser les données collectées dans des demandes ou des alertes personnalisées pour surveiller les performances et les charges de travail dans votre cluster.

<p>Pour utiliser Prometheus, suivez les <a href="https://github.com/coreos/prometheus-operator/tree/master/contrib/kube-prometheus" target="_blank">instructions CoreOS <img src="../icons/launch-glyph.svg" alt="Icône de lien externe"></a>.</p>
</td>
</tr>
<tr>
<td>Sematext</td>
<td>Vous pouvez afficher les métriques et les journaux de vos applications conteneurisées à l'aide de <a href="https://sematext.com/" target="_blank">Sematext <img src="../icons/launch-glyph.svg" alt="Icône de lien externe"></a>. Pour plus d'informations, voir la rubrique sur <a href="https://www.ibm.com/blogs/bluemix/2017/09/monitoring-logging-ibm-bluemix-container-service-sematext/" target="_blank">la surveillance et la consignation des conteneurs avec Sematext <img src="../icons/launch-glyph.svg" alt="Icône de lien externe"></a>. </td>
</tr>
<tr>
<td>Sysdig</td>
<td>Vous pouvez capturer des métriques d'application, de conteneur, de démon statsd et sur l'hôte depuis un point d'instrumentation unique à l'aide de <a href="https://sysdig.com/" target="_blank">Sysdig <img src="../icons/launch-glyph.svg" alt="Icône de lien externe"></a>. Pour plus d'informations, voir <a href="https://www.ibm.com/blogs/bluemix/2017/08/monitoring-ibm-bluemix-container-service-sysdig-container-intelligence/" target="_blank">Monitoring {{site.data.keyword.containerlong_notm}} with Sysdig Container Intelligence <img src="../icons/launch-glyph.svg" alt="Icône de lien externe"></a>. </td>
</tr>
<tr>
<td>Weave Scope</td>
<td>Weave Scope produit un diagramme visuel de vos ressources dans un cluster Kubernetes, notamment des services, pods, conteneurs, processus, noeuds, et autres. Weave Scope fournit des métriques interactives sur l'utilisation de l'UC et de la mémoire, ainsi que des outils pour suivi et exécution dans un conteneur.<p>Pour plus d'informations, voir [Visualisation de ressources de cluster Kubernetes via Weave Scope et {{site.data.keyword.containerlong_notm}}](cs_integrations.html#weavescope).</p></li></ol>
</td>
</tr>
</tbody>
</table>

<br />



## Services de sécurité
{: #security_services}
<table summary="Récapitulatif de l'accessibilité">
<caption>Services de sécurité</caption>
<thead>
<tr>
<th>Service</th>
<th>Description</th>
</tr>
</thead>
<tbody>
  <tr id="appid">
    <td>{{site.data.keyword.appid_full}}</td>
    <td>Ajoutez un niveau de sécurité à vos applications avec [{{site.data.keyword.appid_short}}](/docs/services/appid/index.html#gettingstarted) en obligeant les utilisateurs à se connecter. Pour l'authentification de demandes HTTP/HTTPS Web ou d'API vers votre application, vous pouvez intégrer {{site.data.keyword.appid_short_notm}} au service Ingress en utilisant l'[annotation Ingress d'authentification {{site.data.keyword.appid_short_notm}}](cs_annotations.html#appid-auth).</td>
  </tr>
<tr>
<td>Aqua Security</td>
  <td>En complément de <a href="/docs/services/va/va_index.html" target="_blank">Vulnerability Advisor</a>, vous pouvez utiliser <a href="https://www.aquasec.com/" target="_blank">Aqua Security <img src="../icons/launch-glyph.svg" alt="Icône de lien externe"></a> pour renforcer la sécurité de vos déploiements de conteneurs en limitant ce que votre application est autorisée à effectuer. Pour plus d'informations, voir l'article <a href="https://blog.aquasec.com/securing-container-deployments-on-bluemix-with-aqua-security" target="_blank">Securing container deployments on {{site.data.keyword.Bluemix_notm}} with Aqua Security <img src="../icons/launch-glyph.svg" alt="Icône de lien externe"></a>. </td>
</tr>
<tr>
<td>{{site.data.keyword.cloudcerts_full}}</td>
<td>Vous pouvez utiliser <a href="../services/certificate-manager/index.html" target="_blank">{{site.data.keyword.cloudcerts_long}} <img src="../icons/launch-glyph.svg" alt="Icône de lien externe"></a> pour stocker et gérer les certificats SSL pour vos applications. Pour plus d'informations, voir <a href="https://www.ibm.com/blogs/bluemix/2018/01/use-ibm-cloud-certificate-manager-ibm-cloud-container-service-deploy-custom-domain-tls-certificates/" target="_blank">Use {{site.data.keyword.cloudcerts_long_notm}} with {{site.data.keyword.containerlong_notm}} to deploy custom domain TLS Certificates <img src="../icons/launch-glyph.svg" alt="Icône de lien externe"></a>. </td>
</tr>
<tr>
  <td>{{site.data.keyword.registrylong}}</td>
  <td>Configurez votre propre référentiel d'images Docker sécurisé où vous pourrez stocker et partager des images en toute sécurité entre les utilisateurs du cluster. Pour plus d'informations, voir la <a href="/docs/services/Registry/index.html" target="_blank">documentation d'{{site.data.keyword.registrylong}} <img src="../icons/launch-glyph.svg" alt="Icône de lien externe"></a>.</td>
</tr>
<tr>
<td>NeuVector</td>
<td>Vous pouvez protéger vos conteneurs avec un pare-feu natif pour le cloud à l'aide de <a href="https://neuvector.com/" target="_blank">NeuVector <img src="../icons/launch-glyph.svg" alt="Icône de lien externe"></a>. Pour plus d'informations, voir <a href="https://www.ibm.com/us-en/marketplace/neuvector-container-security" target="_blank">NeuVector Container Security <img src="../icons/launch-glyph.svg" alt="Icône de lien externe"></a>. </td>
</tr>
<tr>
<td>Twistlock</td>
<td>En complément de <a href="/docs/services/va/va_index.html" target="_blank">Vulnerability Advisor</a>, vous pouvez utiliser <a href="https://www.twistlock.com/" target="_blank">Twistlock <img src="../icons/launch-glyph.svg" alt="Icône de lien externe"></a> pour gérer les pare-feux, la protection contre les menaces et les réponses aux incidents. Pour plus d'informations, voir <a href="https://www.ibm.com/blogs/bluemix/2017/07/twistlock-ibm-bluemix-container-service/" target="_blank">Twistlock on {{site.data.keyword.containerlong_notm}} <img src="../icons/launch-glyph.svg" alt="Icône de lien externe"></a>. </td>
</tr>
</tbody>
</table>

<br />



## Services de stockage
{: #storage_services}
<table summary="Récapitulatif de l'accessibilité">
<caption>Services de stockage</caption>
<thead>
<tr>
<th>Service</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
  <td>Heptio Ark</td>
  <td>Vous pouvez utiliser <a href="https://github.com/heptio/ark" target="_blank">Heptio Ark <img src="../icons/launch-glyph.svg" alt="Icône de lien externe"></a> pour effectuer la sauvegarde et la restauration de vos ressources de cluster et vos volumes persistants. Pour plus d'informations, voir <a href="https://github.com/heptio/ark/blob/master/docs/use-cases.md#use-cases" target="_blank">les cas d'utilisation pour la reprise après incident et la migration de cluster <img src="../icons/launch-glyph.svg" alt="Icône de lien externe"></a> de Heptio Ark.</td>
</tr>
<tr>
  <td>{{site.data.keyword.cos_full}}</td>
  <td>Les données stockées avec {{site.data.keyword.cos_short}} sont chiffrées et disséminées entre plusieurs emplacements géographiques. Elles sont accessibles via HTTP en utilisant une API REST. Vous pouvez utiliser l'[image ibm-backup-restore](/docs/services/RegistryImages/ibm-backup-restore/index.html) pour configurer le service de sorte à effectuer des sauvegardes ponctuelles ou planifiées pour les données figurant dans vos clusters. Pour obtenir des informations générales sur le service, voir la <a href="/docs/services/cloud-object-storage/about-cos.html" target="_blank">documentation d'{{site.data.keyword.cos_short}} <img src="../icons/launch-glyph.svg" alt="Icône de lien externe"></a>.</td>
</tr>
  <tr>
    <td>{{site.data.keyword.cloudantfull}}</td>
    <td>{{site.data.keyword.cloudant_short_notm}} est une base de données orientée document de type DBaas (DataBase as a Service) qui stocke les données sous forme de documents au format JSON. Le service est construit pour favoriser l'évolutivité, la haute disponibilité et la durabilité. Pour plus d'informations, voir la <a href="/docs/services/Cloudant/getting-started.html" target="_blank">documentation de {{site.data.keyword.cloudant_short_notm}} <img src="../icons/launch-glyph.svg" alt="Icône de lien externe"></a>.</td>
  </tr>
  <tr>
    <td>{{site.data.keyword.composeForMongoDB_full}}</td>
    <td>{{site.data.keyword.composeForMongoDB}} assure la redondance et la haute disponibilité, fournit des sauvegardes automatiques et à la demande en continu, ainsi que des outils de surveillance, l'intégration à des systèmes d'alerte, des vues d'analyses de performances, et bien plus encore. Pour plus d'informations, voir la <a href="/docs/services/ComposeForMongoDB/index.html" target="_blank">documentation de {{site.data.keyword.composeForMongoDB}} <img src="../icons/launch-glyph.svg" alt="Icône de lien externe"></a>.</td>
  </tr>
</tbody>
</table>


<br />



## Ajout de services {{site.data.keyword.Bluemix_notm}} à des clusters
{: #adding_cluster}

Ajoutez des services {{site.data.keyword.Bluemix_notm}} pour améliorer votre cluster Kubernetes en ajoutant des fonctionnalités supplémentaires dans des domaines tels que Watson AI, les données, la sécurité et Internet of Things (IoT).
{:shortdesc}

**Important :** vous ne pouvez lier que des services prenant en charge les clés de service. Pour trouver une liste avec des services compatibles avec les clés de service, voir [Utilisation des services {{site.data.keyword.Bluemix_notm}} avec des applications externes](/docs/apps/reqnsi.html#accser_external).

Avant de commencer, [ciblez votre interface de ligne de commande](cs_cli_install.html#cs_cli_configure) sur votre cluster.

Pour ajouter un service {{site.data.keyword.Bluemix_notm}} dans votre cluster :
1. [Créez une instance du service {{site.data.keyword.Bluemix_notm}}](/docs/apps/reqnsi.html#req_instance). </br></br>**Remarque :** certains services {{site.data.keyword.Bluemix_notm}} ne sont disponibles que dans des régions éligibles. Vous pouvez lier un service à votre cluster uniquement si ce service est disponible dans la même région que votre cluster. En outre, si vous souhaitez créer une instance de service dans la zone Washington DC, vous devez utiliser l'interface CLI.

2. Vérifiez le type de service que vous avez créé et notez le **nom** de l'instance de service.
   - **Services Cloud Foundry :**
     ```
     ibmcloud service list
     ```
     {: pre}

     Exemple de sortie :
     ```
     name                         service           plan    bound apps   last operation
     <cf_service_instance_name>   <service_name>    spark                create succeeded
     ```
     {: screen}

  - **Services activés pour IAM :**
     ```
     ibmcloud resource service-instances
     ```
     {: pre}

     Exemple de sortie :
     ```
     Name                          Location   State    Type               Tags   
     <iam_service_instance_name>   <region>   active   service_instance      
     ```
     {: screen}

   Vous pouvez également voir les différents types de service dans votre tableau de bord sous **Services Cloud Foundry** et **Services**.

3. Pour les services activés pour IAM, créez un alias Cloud Foundry de sorte à pouvoir lier ce service à votre cluster. Si votre service est déjà un service Cloud Foundry, cette étape n'est pas nécessaire et vous pouvez passer à l'étape suivante.
   1. Ciblez une organisation et un espace Cloud Foundry.
      ```
      ibmcloud target --cf
      ```
      {: pre}

   2. Créez un alias Cloud Foundry pour l'instance de service.
      ```
      ibmcloud resource service-alias-create <service_alias_name> --instance-name <iam_service_instance_name>
      ```
      {: pre}

   3. Vérifiez que l'alias du service a été créé.
      ```
      ibmcloud service list
      ```
      {: pre}

4. Identifiez l'espace de nom du cluster que vous désirez ajouter à votre service. Sélectionnez l'une des options suivantes.
   - Listez les espaces de nom existants et sélectionnez l'espace de nom à utiliser.
     ```
     kubectl get namespaces
     ```
     {: pre}

   - Créez un espace de nom dans votre cluster.
     ```
     kubectl create namespace <namespace_name>
     ```
     {: pre}

5.  Ajoutez le service à votre cluster. Pour les services activés pour IAM, veillez à utiliser l'alias Cloud Foundry que vous avez créé précédemment.
    ```
    ibmcloud ks cluster-service-bind <cluster_name_or_ID> <namespace> <service_instance_name>
    ```
    {: pre}

    Une fois que le service a été correctement ajouté à votre cluster, une valeur confidentielle de cluster est créée pour héberger les données d'identification de votre instance de service. Les valeurs confidentielles sont chiffrées automatiquement dans etcd pour protéger vos données.

    Exemple de sortie :
    ```
    ibmcloud ks cluster-service-bind mycluster mynamespace cleardb
    Binding service instance to namespace...
    OK
    Namespace:	mynamespace
    Secret name:     binding-<service_instance_name>
    ```
    {: screen}

6.  Vérifiez les données d'identification du service dans votre valeur confidentielle Kubernetes.
    1. Obtenez les détails de la valeur confidentielle et notez la valeur de **binding**. La valeur de **binding** est codée en base64 et contient les données d'identification pour votre instance de service au format JSON.
       ```
       kubectl get secrets binding-<service_instance_name> --namespace=<namespace> -o yaml
       ```
       {: pre}

       Exemple de sortie :
       ```
       apiVersion: v1
       data:
         binding: <binding>
       kind: Secret
       metadata:
         annotations:
           service-instance-id: 1111aaaa-a1aa-1aa1-1a11-111aa111aa11
           service-key-id: 2b22bb2b-222b-2bb2-2b22-b22222bb2222
         creationTimestamp: 2018-08-07T20:47:14Z
         name: binding-<service_instance_name>
         namespace: <namespace>
         resourceVersion: "6145900"
         selfLink: /api/v1/namespaces/default/secrets/binding-mycloudant
         uid: 33333c33-3c33-33c3-cc33-cc33333333c
       type: Opaque
       ```
       {: screen}

    2. Décodez la valeur de binding.
       ```
       echo "<binding>" | base64 -D
       ```
       {: pre}

       Exemple de sortie :
       ```
       {"apikey":"KL34Ys893284NGJEPFjgrioJ12NElpow","host":"98765aab-9ce1-7tr3-ba87-bfbab6e6d9d6-bluemix.cloudant.com","iam_apikey_description":"Auto generated apikey during resource-key operation for Instance - crn:v1:bluemix:public:cloudantnosqldb:us-south:a/1234g56789cfe8e6388dd2ec098:98746cw-43d7-49ce-947a-d8fe3eebb381::","iam_apikey_name":"auto-generated-apikey-1234abcde-987f-3t64-9d96-d13775ec5663","iam_role_crn":"crn:v1:bluemix:public:iam::::serviceRole:Writer","iam_serviceid_crn":"crn:v1:bluemix:public:iam-identity::a/1234567890brasge5htn2ec098::serviceid:ServiceId-12345vgh-6c4c-ytr12-af6b-467d30d6ef44","password":"jfiavhui12484fnivhuo472nvei23913c3ff","port":443,"url":"https://25c73aac-9ce1-4c24-ba98-bfbab6e6d9d6-bluemix:ugvioev823inreuiegn43donvri29989wiu9t22@25c73aac-9ce1-4c24-ba98-abdrjio123562lnsb-bluemix.cloudant.com","username":"123b45da-9ce1-4c24-ab12-rinwnwub1294-bluemix"}
       ```
       {: screen}

    3. Facultatif : comparez les données d'identification du service que vous avez décodées à l'étape précédente aux données d'identification du service que vous trouvez pour votre instance de service dans le tableau de bord {{site.data.keyword.Bluemix_notm}}.

7. Votre service étant désormais lié à votre cluster, vous devez configurer votre application pour [accéder aux données d'identification du service dans la valeur confidentielle Kubernetes](#adding_app).


## Accès aux données d'identification à partir de vos applications
{: #adding_app}

Pour accéder à une instance de service {{site.data.keyword.Bluemix_notm}} à partir de votre application, vous devez rendre les données d'identification stockées dans la valeur confidentielle Kubernetes accessibles à votre application.
{: shortdesc}

Les données d'identification d'une instance de service sont codées en base64 et stockées au format JSON dans votre valeur confidentielle. Pour accéder aux données figurant dans votre valeur confidentielle, choisissez l'une des options suivantes :
- [Monter la valeur confidentielle sous forme de volume sur votre pod](#mount_secret)
- [Référencer la valeur confidentielle dans les variables d'environnement](#reference_secret)

Avant de commencer :
- [Ciblez votre interface de ligne de commande](cs_cli_install.html#cs_cli_configure) sur votre cluster.
- [Ajoutez un service {{site.data.keyword.Bluemix_notm}} à votre cluster](#adding_cluster).

### Montage de la valeur confidentielle sous forme de volume dans votre pod
{: #mount_secret}

Lorsque vous montez la valeur confidentielle sous forme de volume dans votre pod, un fichier nommé `binding` est stocké dans le répertoire de montage du volume. Le fichier `binding` au format JSON comprend toutes les informations et les données d'identification dont vous avez besoin pour accéder au service {{site.data.keyword.Bluemix_notm}}.
{: shortdesc}

1.  Répertoriez les valeurs confidentielles disponibles dans votre cluster et notez le **nom** de la vôtre. Recherchez une valeur confidentielle de type **Opaque**. S'il existe plusieurs valeurs confidentielles, contactez l'administrateur de votre cluster pour identifier la valeur confidentielle appropriée.

    ```
    kubectl get secrets
    ```
    {: pre}

    Exemple de sortie :

    ```
    NAME                                    TYPE                                  DATA      AGE
    binding-<service_instance_name>         Opaque                                1         3m

    ```
    {: screen}

2.  Créez un fichier YAML pour votre déploiement Kubernetes et montez la valeur confidentielle sous forme de volume sur votre pod.
    ```
    apiVersion: apps/v1beta1
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
          - image: registry.bluemix.net/ibmliberty:latest
            name: secret-test
            volumeMounts:
            - mountPath: <mount_path>
              name: <volume_name>
          volumes:
          - name: <volume_name>
            secret:
              defaultMode: 420
              secretName: binding-<service_instance_name>
    ```
    {: codeblock}

    <table>
    <caption>Description des composants du fichier YAML</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code>volumeMounts/mountPath</code></td>
    <td>Chemin absolu du répertoire où est monté le volume dans le conteneur.</td>
    </tr>
    <tr>
    <td><code>volumeMounts/name</code></br><code>volumes/name</code></td>
    <td>Nom du volume à monter sur votre pod.</td>
    </tr>
    <tr>
    <td><code>secret/defaultMode</code></td>
    <td>Droits d'accès en lecture et en écriture sur la valeur confidentielle. Utilisez `420` pour définir les droits en lecture seule. </td>
    </tr>
    <tr>
    <td><code>secret/secretName</code></td>
    <td>Nom de la valeur confidentielle que vous avez notée à l'étape précédente.</td>
    </tr></tbody></table>

3.  Créez le pod et montez la valeur confidentielle sous forme de volume.
    ```
    kubectl apply -f secret-test.yaml
    ```
    {: pre}

4.  Vérifiez que le pod a bien été créé.
    ```
    kubectl get pods
    ```
    {: pre}

    Exemple de sortie d'interface CLI :

    ```
    NAME                           READY     STATUS    RESTARTS   AGE
    secret-test-1111454598-gfx32   1/1       Running   0          1m
    ```
    {: screen}

5.  Accédez aux données d'identification pour le service.
    1. Connectez-vous à votre pod.
       ```
       kubectl exec <pod_name> -it bash
       ```
       {: pre}

    2. Accédez au chemin de montage du volume que vous avez défini précédemment et répertoriez les fichiers figurant dans ce chemin.
       ```
       cd <volume_mountpath> && ls
       ```
       {: pre}

       Exemple de sortie :
       ```
       binding
       ```
       {: screen}

       Le fichier `binding` comprend les données d'identification pour le service que vous avez stockées dans la valeur confidentielle Kubernetes.

    4. Affichez les données d'identification du service. Ces données sont stockées sous forme de paires clé-valeur au format JSON.
       ```
       cat binding
       ```
       {: pre}

       Exemple de sortie :
       ```
       {"apikey":"KL34Ys893284NGJEPFjgrioJ12NElpow","host":"98765aab-9ce1-7tr3-ba87-bfbab6e6d9d6-bluemix.cloudant.com","iam_apikey_description":"Auto generated apikey during resource-key operation for Instance - crn:v1:bluemix:public:cloudantnosqldb:us-south:a/1234g56789cfe8e6388dd2ec098:98746cw-43d7-49ce-947a-d8fe3eebb381::","iam_apikey_name":"auto-generated-apikey-1234abcde-987f-3t64-9d96-d13775ec5663","iam_role_crn":"crn:v1:bluemix:public:iam::::serviceRole:Writer","iam_serviceid_crn":"crn:v1:bluemix:public:iam-identity::a/1234567890brasge5htn2ec098::serviceid:ServiceId-12345vgh-6c4c-ytr12-af6b-467d30d6ef44","password":"jfiavhui12484fnivhuo472nvei23913c3ff","port":443,"url":"https://25c73aac-9ce1-4c24-ba98-bfbab6e6d9d6-bluemix:ugvioev823inreuiegn43donvri29989wiu9t22@25c73aac-9ce1-4c24-ba98-abdrjio123562lnsb-bluemix.cloudant.com","username":"123b45da-9ce1-4c24-ab12-rinwnwub1294-bluemix"}
       ```
       {: screen}

    5. Configurez votre application pour analyser le contenu JSON et extraire les informations dont vous avez besoin pour accéder à votre service.


### Référencement de la valeur confidentielle dans les variables d'environnement
{: #reference_secret}

Vous pouvez ajouter les données d'identification du service et d'autres paires clé-valeur figurant dans votre valeur confidentielle Kubernetes sous forme de variables d'environnement dans votre déploiement.   
{: shortdesc}

1. Répertoriez les valeurs confidentielles disponibles dans votre cluster et notez le **nom** de la vôtre. Recherchez une valeur confidentielle de type **Opaque**. S'il existe plusieurs valeurs confidentielles, contactez l'administrateur de votre cluster pour identifier la valeur confidentielle appropriée.

    ```
    kubectl get secrets
    ```
    {: pre}

    Exemple de sortie :

    ```
    NAME                                    TYPE                                  DATA      AGE
    binding-<service_instance_name>         Opaque                                1         3m
    ```
    {: screen}

2. Obtenez les détails de votre valeur confidentielle pour rechercher les paires clé-valeur potentielles que vous pouvez référencer sous forme de variables d'environnement dans votre pod. Les données d'identification du service sont stockées dans la clé `binding` de votre valeur confidentielle.
   ```
   kubectl get secrets binding-<service_instance_name> --namespace=<namespace> -o yaml
   ```
   {: pre}

   Exemple de sortie :
   ```
   apiVersion: v1
   data:
     binding: <binding>
   kind: Secret
   metadata:
     annotations:
       service-instance-id: 7123acde-c3ef-4ba2-8c52-439ac007fa70
       service-key-id: 9h30dh8a-023f-4cf4-9d96-d12345ec7890
     creationTimestamp: 2018-08-07T20:47:14Z
     name: binding-<service_instance_name>
     namespace: <namespace>
     resourceVersion: "6145900"
     selfLink: /api/v1/namespaces/default/secrets/binding-mycloudant
     uid: 12345a31-9a83-11e8-ba83-cd49014748f
   type: Opaque
   ```
   {: screen}

3. Créez un fichier YAML pour votre déploiement Kubernetes et indiquez une variable d'environnement qui référence la clé `binding`.
   ```
   apiVersion: apps/v1beta1
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
     template:
       metadata:
         labels:
           app: secret-test
       spec:
         containers:
         - image: registry.bluemix.net/ibmliberty:latest
           name: secret-test
           env:
           - name: BINDING
             valueFrom:
               secretKeyRef:
                 name: binding-<service_instance_name>
                 key: binding
     ```
     {: codeblock}

     <table>
     <caption>Description des composants du fichier YAML</caption>
     <thead>
     <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
     </thead>
     <tbody>
     <tr>
     <td><code>containers/env/name</code></td>
     <td>Nom de votre variable d'environnement.</td>
     </tr>
     <tr>
     <td><code>env/valueFrom/secretKeyRef/name</code></td>
     <td>Nom de la valeur confidentielle que vous avez notée à l'étape précédente.</td>
     </tr>
     <tr>
     <td><code>env/valueFrom/secretKeyRef/key</code></td>
     <td>Clé faisant partie de votre valeur confidentielle que vous voulez référencer dans votre variable d'environnement. Pour référencer les données d'identification du service, vous devez utiliser la clé <strong>binding</strong>.  </td>
     </tr>
     </tbody></table>

4. Créez le pod qui référence la clé `binding` de votre valeur confidentielle sous forme de variable d'environnement.
   ```
   kubectl apply -f secret-test.yaml
   ```
   {: pre}

5. Vérifiez que le pod a bien été créé.
   ```
   kubectl get pods
   ```
   {: pre}

   Exemple de sortie d'interface CLI :
   ```
   NAME                           READY     STATUS    RESTARTS   AGE
    secret-test-1111454598-gfx32   1/1       Running   0          1m
   ```
   {: screen}

6. Vérifiez que la variable d'environnement est définie correctement.
   1. Connectez-vous à votre pod.
      ```
      kubectl exec <pod_name> -it bash
      ```
      {: pre}

   2. Répertoriez toutes les variables d'environnement dans le pod.
      ```
      env
      ```
      {: pre}

      Exemple de sortie :
      ```
      BINDING={"apikey":"KL34Ys893284NGJEPFjgrioJ12NElpow","host":"98765aab-9ce1-7tr3-ba87-bfbab6e6d9d6-bluemix.cloudant.com","iam_apikey_description":"Auto generated apikey during resource-key operation for Instance - crn:v1:bluemix:public:cloudantnosqldb:us-south:a/1234g56789cfe8e6388dd2ec098:98746cw-43d7-49ce-947a-d8fe3eebb381::","iam_apikey_name":"auto-generated-apikey-1234abcde-987f-3t64-9d96-d13775ec5663","iam_role_crn":"crn:v1:bluemix:public:iam::::serviceRole:Writer","iam_serviceid_crn":"crn:v1:bluemix:public:iam-identity::a/1234567890brasge5htn2ec098::serviceid:ServiceId-12345vgh-6c4c-ytr12-af6b-467d30d6ef44","password":"jfiavhui12484fnivhuo472nvei23913c3ff","port":443,"url":"https://25c73aac-9ce1-4c24-ba98-bfbab6e6d9d6-bluemix:ugvioev823inreuiegn43donvri29989wiu9t22@25c73aac-9ce1-4c24-ba98-abdrjio123562lnsb-bluemix.cloudant.com","username":"123b45da-9ce1-4c24-ab12-rinwnwub1294-bluemix"}
      ```
      {: screen}

7. Configurez votre application pour lire la variable d'environnement et analyser le contenu JSON pour extraire les informations dont vous avez besoin pour accéder à votre service.

   Exemple de code en Python :
   ```
   if os.environ.get('BINDING'):
        credentials = json.loads(os.environ.get('BINDING'))
   ```
   {: codeblock}

## Configuration de Helm dans {{site.data.keyword.containerlong_notm}}
{: #helm}

[Helm ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://helm.sh) est un gestionnaire de packages Kubernetes. Vous pouvez créer des chartes Helm ou utiliser des chartes Helm préexistantes pour définir, installer et mettre à niveau des applications Kubernetes complexes qui s'exécutent dans les clusters {{site.data.keyword.containerlong_notm}}.
{:shortdesc}

Avant d'utiliser des chartes Helm avec {{site.data.keyword.containerlong_notm}}, vous devez installer et initialiser une instance Helm dans votre cluster. Vous pouvez ensuite ajouter le référentiel Helm {{site.data.keyword.Bluemix_notm}} à votre instance Helm.

Avant de commencer, [ciblez votre interface de ligne de commande (CLI)](cs_cli_install.html#cs_cli_configure) sur le cluster dans lequel vous désirez utiliser une charte Helm.

1. Installez l'<a href="https://docs.helm.sh/using_helm/#installing-helm" target="_blank">interface de ligne de commande Helm  <img src="../icons/launch-glyph.svg" alt="Icône de lien externe"></a>.

2. **Important** : pour assurer la sécurité du cluster, créez un compte de service pour Tiller dans l'espace de nom `kube-system` et une liaison de rôle de cluster RBAC Kubernetes pour le pod `tiller-deploy`.

    1. Dans l'éditeur de votre choix, créez le fichier suivant et sauvegardez-le avec le nom `rbac-config.yaml`. **Remarque** : pour installer Tiller avec le compte de service et la liaison de rôle de cluster dans l'espace de nom `kube-system`, vous devez disposer du [rôle `cluster-admin`](cs_users.html#access_policies). Vous pouvez choisir un autre espace de nom que `kube-system`, mais toutes les chartes IBM Helm doivent être installées dans `kube-system`. Chaque fois que vous exécutez une commande `helm`, vous devez utiliser l'indicateur `tiller-namespace <namespace>` pour pointer vers l'autre espace de nom dans lequel est installé Tiller.

      ```
      apiVersion: v1
      kind: ServiceAccount
      metadata:
        name: tiller
        namespace: kube-system
      ---
      apiVersion: rbac.authorization.k8s.io/v1
      kind: ClusterRoleBinding
      metadata:
        name: tiller
      roleRef:
        apiGroup: rbac.authorization.k8s.io
        kind: ClusterRole
        name: cluster-admin
      subjects:
        - kind: ServiceAccount
          name: tiller
          namespace: kube-system
      ```
      {: codeblock}

    2. Créez le compte de service et la liaison de rôle de cluster.

        ```
        kubectl create -f rbac-config.yaml
        ```
        {: pre}

3. Initialisez Helm et installez `tiller` avec le compte de service que vous avez créé.

    ```
    helm init --service-account tiller
    ```
    {: pre}

4. Vérifiez que la zone **Status** du pod `tiller-deploy` indique `Running` dans votre cluster.

    ```
    kubectl get pods -n kube-system -l app=helm
    ```
    {: pre}

    Exemple de sortie :

    ```
    NAME                            READY     STATUS    RESTARTS   AGE
    tiller-deploy-352283156-nzbcm   1/1       Running   0          2m
    ```
    {: screen}

5. Ajoutez le référentiel {{site.data.keyword.Bluemix_notm}} Helm à votre instance Helm.

    ```
    helm repo add ibm  https://registry.bluemix.net/helm/ibm
    ```
    {: pre}

6. Répertoriez les chartes Helm actuellement disponibles dans le référentiel {{site.data.keyword.Bluemix_notm}}.

    ```
    helm search ibm
    ```
    {: pre}

7. Pour en savoir plus sur une charte, affichez la liste de ses paramètres et valeurs par défaut.

    Par exemple, pour afficher les paramètres, la documentation et les valeurs par défaut de la charte Helm du service VPN IPSec strongSwan, exécutez la commande :

    ```
    helm inspect ibm/strongswan
    ```
    {: pre}


### Liens associés à Helm
{: #helm_links}

* Pour utiliser la charte Helm strongSwan, voir [Configuration de la connectivité VPN avec la charte Helm du service VPN IPsec strongSwan](cs_vpn.html#vpn-setup).
* Affichez les chartes Helm disponibles que vous pouvez utiliser avec {{site.data.keyword.Bluemix_notm}} dans l'interface graphique du [catalogue des chartes Helm ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://console.bluemix.net/containers-kubernetes/solutions/helm-charts).
* Pour en savoir plus sur les commandes Helm utilisées pour configurer et gérer des chartes Helm, voir la <a href="https://docs.helm.sh/helm/" target="_blank">documentation Helm <img src="../icons/launch-glyph.svg" alt="Icône de lien externe"></a>.
* Pour en savoir plus sur comment augmenter la vitesse de déploiement avec les chartes Helm de Kubernetes, voir [Increase deployment velocity with Kubernetes Helm Charts ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://developer.ibm.com/recipes/tutorials/increase-deployment-velocity-with-kubernetes-helm-charts/).

## Visualisation de ressources de cluster Kubernetes
{: #weavescope}

Weave Scope produit un diagramme visuel de vos ressources dans un cluster Kubernetes, notamment des services, pods, conteneurs, etc. Weave Scope fournit des métriques interactives sur l'utilisation de l'UC et de la mémoire, ainsi que des outils pour suivi et exécution dans un conteneur.
{:shortdesc}

Avant de commencer :

-   Prenez soin de ne pas exposer les informations de votre cluster sur l'Internet public. Procédez comme suit pour déployer de manière sécurisée Weave Scope et y accéder en local depuis un navigateur Web.
-   Si ce n'est déjà fait, [créez un cluster standard](cs_clusters.html#clusters_ui). Weave Scope peut solliciter énormément l'unité centrale, surtout l'application. Exécutez Weave Scope avec des clusters standard plus volumineux et non pas des clusters gratuits.
-   [Ciblez votre interface CLI](cs_cli_install.html#cs_cli_configure) sur votre cluster pour exécuter des commandes `kubectl`.


Pour utiliser Weave Scope avec un cluster, procédez comme suit :
2.  Déployez dans le cluster l'un des fichiers de configuration d'autorisations RBAC fournis.

    Pour activer les droits d'accès en lecture / écriture, exécutez la commande suivante :

    ```
    kubectl apply -f "https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/weave-scope/weave-scope-rbac.yaml"
    ```
    {: pre}

    Pour activer les droits d'accès en lecture seule, exécutez la commande suivante :

    ```
    kubectl apply --namespace weave -f "https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/weave-scope/weave-scope-rbac-readonly.yaml"
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
    <code>kubectl apply --namespace weave -f "https://cloud.weave.works/k8s/scope.yaml?k8s-version=$(kubectl version | base64 | tr -d '&bsol;n')"</code>
    </pre>

    Sortie :

    ```
    serviceaccount "weave-scope" created
    deployment "weave-scope-app" created
    service "weave-scope-app" created
    daemonset "weave-scope-agent" created
    ```
    {: screen}

4.  Exécutez une commande d'acheminement de port pour ouvrir le service sur votre ordinateur. La prochaine fois que vous accéderez à Weave Scope, vous pourrez exécuter cette commande d'acheminement de port sans avoir à compléter à nouveau les étapes de configuration précédentes.

    ```
    kubectl port-forward -n weave "$(kubectl get -n weave pod --selector=weave-scope-component=app -o jsonpath='{.items..metadata.name}')" 4040
    ```
    {: pre}

    Sortie :

    ```
    Forwarding from 127.0.0.1:4040 -> 4040
    Forwarding from [::1]: :1]:4040 -> 4040
    Handling connection for 4040
    ```
    {: screen}

5.  Ouvrez votre navigateur Web et accédez à l'adresse `http://localhost:4040`. Si les composants par défaut ne sont pas déployés, vous obtenez le diagramme suivant. Vous pouvez choisir d'afficher des diagrammes de topologie ou bien des tableaux des ressources Kubernetes dans le cluster.

     <img src="images/weave_scope.png" alt="Exemple de topologie Weave Scope" style="width:357px;" />


[En savoir plus sur les fonctions Weave Scope ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://www.weave.works/docs/scope/latest/features/).

<br />

