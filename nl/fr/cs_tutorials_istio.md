---

copyright:
  years: 2014, 2018
lastupdated: "2018-12-05"

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



# Tutoriel : Installation d'Istio sur {{site.data.keyword.containerlong_notm}}
{: #istio_tutorial}

[Istio ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://www.ibm.com/cloud/info/istio) est une plateforme ouverte permettant de connecter, de sécuriser, de contrôler et d'observer des services sur des plateformes cloud comme Kubernetes dans {{site.data.keyword.containerlong}}. Istio vous permet de gérer le trafic réseau, d'équilibrer la charge entre les microservices, d'appliquer des règles d'accès, de vérifier l'identité des services, etc.
{:shortdesc}

Dans ce tutoriel, vous découvrirez comment installer Istio de pair avec quatre microservices pour une application de librairie fictive dénommée BookInfo. Les microservices incluent une page de projet Web, les détails de livres, leurs revues et évaluations. Lorsque vous déployez des microservices BookInfo sur un cluster {{site.data.keyword.containerlong}} sur lequel Istio est installé, vous injectez les proxys sidecar Istio Envoy dans les pods de chaque microservice.

## Objectifs

-   Déployer la charte Helm Istio dans votre cluster
-   Déployer le modèle d'application BookInfo
-   Vérifier le déploiement de l'application BookInfo sur les trois versions du service d'évaluation

## Durée

30 minutes

## Public

Ce tutoriel est destiné aux développeurs de logiciel et aux administrateurs réseau qui utilisent Istio pour la première fois.

## Conditions prérequises

-  [Installez l'interface de ligne de commande d'IBM Cloud, le plug-in {{site.data.keyword.containerlong_notm}} et l'interface de ligne de commande de Kubernetes](cs_cli_install.html#cs_cli_install_steps). Veillez à installer la version de l'interface CLI `kubectl` correspondant à la version Kubernetes de votre cluster.
-  [Créez un cluster ](cs_clusters.html#clusters_cli). 
-  [Ciblez l'interface CLI sur votre cluster](cs_cli_install.html#cs_cli_configure).

## Leçon 1 : Téléchargement et installation d'Istio
{: #istio_tutorial1}

Téléchargez et installez Istio dans votre cluster.
{:shortdesc}

1. Installez Istio en utilisant la [charte Helm IBM Istio ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://console.bluemix.net/containers-kubernetes/solutions/helm-charts/ibm-charts/ibm-istio).
    1. [Configurez Helm dans votre cluster et ajoutez le référentiel `ibm-charts` dans votre instance Helm](cs_integrations.html#helm).
    2.  **Pour Helm versions 2.9 ou ultérieures uniquement** : installez les définitions de ressources personnalisées d'Istio.
        ```
        kubectl apply -f https://raw.githubusercontent.com/IBM/charts/master/stable/ibm-istio/templates/crds.yaml
        ```
        {: pre}
    3. Installez la charte Helm dans votre cluster.
        ```
        helm install ibm-charts/ibm-istio --name=istio --namespace istio-system
        ```
        {: pre}

2. Vérifiez que les pods des 9 services Istio et que le pod de Prometheus sont complètement déployés avant de continuer.
    ```
    kubectl get pods -n istio-system
    ```
    {: pre}

    ```
    NAME                                       READY     STATUS      RESTARTS   AGE
    istio-citadel-748d656b-pj9bw               1/1       Running     0          2m
    istio-egressgateway-6c65d7c98d-l54kg       1/1       Running     0          2m
    istio-galley-65cfbc6fd7-bpnqx              1/1       Running     0          2m
    istio-ingressgateway-f8dd85989-6w6nj       1/1       Running     0          2m
    istio-pilot-5fd885964b-l4df6               2/2       Running     0          2m
    istio-policy-56f4f4cbbd-2z2bk              2/2       Running     0          2m
    istio-sidecar-injector-646655c8cd-rwvsx    1/1       Running     0          2m
    istio-statsd-prom-bridge-7fdbbf769-8k42l   1/1       Running     0          2m
    istio-telemetry-8687d9d745-mwjbf           2/2       Running     0          2m
    prometheus-55c7c698d6-f4drj                1/1       Running     0          2m
    ```
    {: screen}

Bien joué ! L'installation d'Istio dans votre cluster a abouti. Déployez ensuite le modèle d'application BookInfo dans votre cluster.


## Leçon 2 : Déploiement de l'application BookInfo
{: #istio_tutorial2}

Déployez les microservices du modèle d'application BookInfo dans votre cluster Kubernetes.
{:shortdesc}

Ces quatre microservices incluent une page Web de produit, les détails des livres, leurs revues (avec plusieurs versions du microservice de revue), et leurs évaluations. Lorsque vous déployez BookInfo, des proxys sidecar Envoy sont injectés en tant que conteneurs dans les pods des microservices de votre application avant que ces pods ne soient déployés. Istio utilise une version étendue du proxy Envoy pour arbitrer tout le trafic entrant et sortant de tous les microservices du maillage de services. Pour plus d'informations sur Envoy, reportez-vous à la [Documentation Istio ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://istio.io/docs/concepts/what-is-istio/overview/#envoy).

1. Téléchargez le package Istio contenant les fichiers BookInfo nécessaires.
    1. Téléchargez directement Istio depuis [https://github.com/istio/istio/releases ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://github.com/istio/istio/releases) ou obtenez la version la plus récente avec cURL :
       ```
       curl -L https://git.io/getLatestIstio | sh -
       ```
       {: pre}

    2. Changez de répertoire pour accéder à l'emplacement du fichier Istio.
       ```
       cd <filepath>/istio-1.0
       ```
       {: pre}

    3. Ajoutez le client `istioctl` à votre variable PATH. Par exemple, sur un système MacOS ou Linux, exécutez la commande suivante :
        ```
        export PATH=$PWD/istio-1.0/bin:$PATH
        ```
        {: pre}

2. Labellisez l'espace de nom `default` avec `istio-injection=enabled`.
    ```
    kubectl label namespace default istio-injection=enabled
    ```
    {: pre}

3. Déployez l'application BookInfo. Lors du déploiement des microservices d'application, le sidecar Envoy est également déployé dans chaque pod de microservice.

   ```
   kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml
   ```
   {: pre}

4. Vérifiez que les microservices et leur pods correspondants ont été déployés :
    ```
    kubectl get svc
    ```
    {: pre}

    ```
    NAME                      TYPE           CLUSTER-IP       EXTERNAL-IP    PORT(S)          AGE
    details                   ClusterIP      172.21.19.104    <none>         9080/TCP         1m
    productpage               ClusterIP      172.21.168.196   <none>         9080/TCP         1m
    ratings                   ClusterIP      172.21.11.131    <none>         9080/TCP         1m
    reviews                   ClusterIP      172.21.117.164   <none>         9080/TCP         1m
    ```
    {: screen}

    ```
    kubectl get pods
    ```
    {: pre}

    ```
    NAME                                     READY     STATUS      RESTARTS   AGE
    details-v1-6865b9b99d-7v9h8              2/2       Running     0          2m
    productpage-v1-f8c8fb8-tbsz9             2/2       Running     0          2m
    ratings-v1-77f657f55d-png6j              2/2       Running     0          2m
    reviews-v1-6b7f6db5c5-fdmbq              2/2       Running     0          2m
    reviews-v2-7ff5966b99-zflkv              2/2       Running     0          2m
    reviews-v3-5df889bcff-nlmjp              2/2       Running     0          2m
    ```
    {: screen}

5. Pour vérifier le déploiement de l'application, obtenez l'adresse publique de votre cluster.
    * Clusters standard :
        1. Pour exposer votre application sur une adresse IP Ingress publique, déployez la passerelle BookInfo.
            ```
            kubectl apply -f samples/bookinfo/networking/bookinfo-gateway.yaml
            ```
            {: pre}

        2. Définissez l'hôte Ingress.
            ```
            export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
            ```
            {: pre}

        3. Définissez le port Ingress.
            ```
            export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')
            ```
            {: pre}

        4. Créez une variable d'environnement `GATEWAY_URL` utilisant le port et l'hôte Ingress.

           ```
           export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT
           ```
           {: pre}

    * Clusters gratuits :
        1. Obtenez l'adresse IP publique de tous les noeuds worker figurant dans votre cluster.
            ```
            ibmcloud ks workers <cluster_name_or_ID>
            ```
            {: pre}

        2. Créez une variable d'environnement GATEWAY_URL utilisant l'adresse IP publique du noeud worker.
            ```
            export GATEWAY_URL=<worker_node_public_IP>:$(kubectl get svc istio-ingressgateway -n istio-system -o jsonpath='{.spec.ports[0].nodePort}')
            ```
            {: pre}

5. Exécutez la commande curl sur la variable `GATEWAY_URL` pour vérifier que l'application BookInfo est en cours d'exécution. Une réponse `200` indique que l'application  BookInfo s'exécute correctement avec Istio.
     ```
     curl -o /dev/null -s -w "%{http_code}\n" http://${GATEWAY_URL}/productpage
     ```
     {: pre}

6.  Affichez la page Web BookInfo dans un navigateur.

    Pour Mac OS ou Linux :
    ```
    open http://$GATEWAY_URL/productpage
    ```
    {: pre}

    Pour Windows :
    ```
    start http://$GATEWAY_URL/productpage
    ```
    {: pre}

7. Essayez d'actualiser la page plusieurs fois. Différentes versions de la section des revues affichent des étoiles rouges, des étoiles noires, ou pas d'étoiles.

Bien joué ! Vous avez déployé le modèle d'application BookInfo avec des sidecars Istio Envoy. Vous pouvez ensuite nettoyer vos ressources ou continuer avec d'autres tutoriels pour explorer davantage Istio.

## Nettoyage
{: #istio_tutorial_cleanup}

Si vous avez fini d'utiliser Istio et que vous ne voulez pas [continuer à l'explorer](#istio_tutorial_whatsnext), vous pouvez procéder au nettoyage des ressources Istio dans votre cluster.
{:shortdesc}

1. Supprimez tous les services, les pods et les déploiements BookInfo dans le cluster.
    ```
    samples/bookinfo/platform/kube/cleanup.sh
    ```
    {: pre}

2. Désinstallez le déploiement Helm Istio.
    ```
    helm del istio --purge
    ```
    {: pre}

3. Si vous avez utilisé Helm version 2.9 ou ultérieure :
    1. Supprimez la ressource de travail en supplément.
      ```
      kubectl -n istio-system delete job --all
      ```
      {: pre}
    2. Facultatif : supprimez les définitions de ressources personnalisées.
      ```
      kubectl delete -f https://raw.githubusercontent.com/IBM/charts/master/stable/ibm-istio/templates/crds.yaml
      ```
      {: pre}

## Etape suivante ?
{: #istio_tutorial_whatsnext}

* Vous cherchez à exposer vos applications avec à la fois {{site.data.keyword.containerlong_notm}} et Istio ? Découvrez comment connecter l'équilibreur de charge d'application (ALB) Ingress d'{{site.data.keyword.containerlong_notm}} et une passerelle Istio dans cet [article de blogue ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://www.ibm.com/blogs/bluemix/2018/09/transitioning-your-service-mesh-from-ibm-cloud-kubernetes-service-ingress-to-istio-ingress/).
* Si vous désirez explorer davantage Istio, d'autres guides figurent dans la [Documentation Istio ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://istio.io/).
    * [Intelligent Routing ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://istio.io/docs/guides/intelligent-routing.html) : cet exemple illustre comment acheminer le trafic vers une version spécifique de microservices de revue et d'évaluation BookInfo en utilisant les capacités de gestion de trafic d'Istio.
    * [In-Depth Telemetry ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://istio.io/docs/guides/telemetry.html) : cet exemple comprend les instructions pour obtenir des métriques, des journaux et des traces uniformes sur tous les microservices BookInfo en utilisant Istio Mixer et le proxy Envoy.
* Suivez le cours [Cognitive Class: Getting started with Microservices with Istio and IBM Cloud Kubernetes Service ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://cognitiveclass.ai/courses/get-started-with-microservices-istio-and-ibm-cloud-container-service/). **Remarque** : vous pouvez ignorer la section sur l'installation d'Istio de ce cours.
* Consultez cet article de blogue sur l'utilisation de [Vistio ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://itnext.io/vistio-visualize-your-istio-mesh-using-netflixs-vizceral-b075c402e18e) pour visualiser le maillage de vos services Istio.
