---

copyright:
  years: 2014, 2018
lastupdated: "2018-4-20"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Déploiement d'applications dans des clusters
{: #app}

Vous pouvez recourir à des techniques Kubernetes dans {{site.data.keyword.containerlong}} pour déployer des applications et faire en sorte qu'elles soient toujours opérationnelles. Par exemple, vous pouvez effectuer des mises à jour et des rétromigrations en continu sans générer de temps d'indisponibilité pour vos utilisateurs.
{: shortdesc}

Découvrez les étapes générales de déploiement d'applications en cliquant sur une zone de l'image suivante.

<img usemap="#d62e18" border="0" class="image" id="basic_deployment_process" src="images/basic_deployment_process.png" width="780" style="width:780px;" alt="Processus de déploiement de base"/>
<map name="d62e18" id="d62e18">
<area href="cs_cli_install.html" target="_blank" alt="Installation des interfaces CLI." title="Installation des interfaces CLI." shape="rect" coords="30, 69, 179, 209" />
<area href="https://kubernetes.io/docs/concepts/configuration/overview/" target="_blank" alt="Création d'un fichier de configuration pour votre application. Consultez les pratiques Kubernetes recommandées." title="Création d'un fichier de configuration pour votre application. Consultez les pratiques Kubernetes recommandées." shape="rect" coords="254, 64, 486, 231" />
<area href="#app_cli" target="_blank" alt="Option 1 : Exécuter des fichiers de configuration depuis l'interface CLI de Kubernetes." title="Option 1 : Exécuter des fichiers de configuration depuis l'interface CLI de Kubernetes." shape="rect" coords="544, 67, 730, 124" />
<area href="#cli_dashboard" target="_blank" alt="Option 2 : Démarrer le tableau de bord Kubernetes en local et exécuter des fichiers de configuration." title="Option 2 : Démarrer le tableau de bord Kubernetes en local et exécuter des fichiers de configuration." shape="rect" coords="544, 141, 728, 204" />
</map>


<br />


## Planification de déploiements à haute disponibilité
{: #highly_available_apps}

Plus votre configuration sera distribuée entre plusieurs noeuds worker et clusters, et moins vos utilisateurs seront susceptibles d'encourir des temps d'indisponibilité de votre application.
{: shortdesc}

Examinez les configurations potentielles d'application suivantes, classées par ordre de disponibilité croissante.

![Niveaux de haute disponibilité pour une application](images/cs_app_ha_roadmap.png)

1.  Déploiement avec n+2 pods gérés par un jeu de répliques.
2.  Déploiement avec n+2 pods gérés par un jeu de répliques et disséminés entre plusieurs noeuds (anti-affinité) sur le même emplacement.
3.  Déploiement avec n+2 pods gérés par un jeu de répliques et disséminés entre plusieurs noeuds (anti-affinité) dans des emplacements différents.
4.  Déploiement avec n+2 pods gérés par un jeu de répliques et disséminés entre plusieurs noeuds (anti-affinité) dans des régions différentes.




### Augmentation de la disponibilité de votre application

<dl>
  <dt>Utilisez des déploiements et des jeux de répliques pour déployer votre application et ses dépendances</dt>
    <dd><p>Un déploiement est une ressource Kubernetes que vous pouvez utiliser pour déclarer tous les composants de votre application et ses dépendances. Avec les déploiements, vous n'avez pas à noter toutes les étapes, ce qui vous permet de vous concentrer sur votre application.</p>
    <p>Lorsque vous déployez plusieurs pods, un jeu de répliques est créé automatiquement pour vos déploiements afin de surveiller les pods et de garantir que le nombre voulu de pods est opérationnel en tout temps. Lorsqu'un pod tombe en panne, le jeu de répliques remplace le pod ne répondant plus par un nouveau.</p>
    <p>Vous pouvez utiliser un déploiement pour définir des stratégies de mise à jour de votre application, notamment le nombre de pods que vous désirez ajouter lors d'une mise à jour en continu et le nombre de pods pouvant être indisponibles à un moment donné. Lorsque vous effectuez une mise à jour en continu, le déploiement vérifie si la révision est fonctionnelle et l'arrête si des échecs sont détectés.</p>
    <p>Avec les déploiements, vous pouvez déployer simultanément plusieurs révisions avec différents indicateurs. Par exemple, vous pouvez d'abord tester un déploiement avant de décider de l'utiliser en environnement de production.</p>
    <p>Les déploiements vous permettent de suivre toutes les révisions déployées. Vous pouvez utiliser cet historique pour rétablir une version antérieure si vous constatez que vos mises à jour ne fonctionnent pas comme prévu.</p></dd>
  <dt>Incluez suffisamment de répliques pour répondre à la charge de travail de votre application, plus deux répliques</dt>
    <dd>Pour rendre votre application encore plus disponible et réfractaire aux échecs, envisagez d'inclure des répliques supplémentaires au-delà du strict minimum requis pour gérer la charge de travail anticipée. Ces répliques supplémentaires pourront gérer la charge de travail en cas de panne d'un pod et avant que le jeu de répliques n'ait encore rétabli le pod défaillant. Pour une protection face à deux défaillances simultanées de pods, incluez deux répliques supplémentaires. Cette configuration correspond à un canevas N+2, où N désigne le nombre de pods destinés à traiter la charge de travail entrante et +2 indique deux répliques supplémentaires. Tant qu'il y a suffisamment d'espace dans votre cluster, vous pouvez avoir autant de pods que vous voulez.</dd>
  <dt>Disséminez les pods entre plusieurs noeuds (anti-affinité)</dt>
    <dd><p>Lorsque vous créez votre déploiement, vous pouvez déployer tous les pods sur le même noeud worker. C'est ce qu'on appelle affinité ou collocation. Pour protéger votre application contre une défaillance de noeud worker, vous pouvez configurer votre déploiement de sorte à disséminer les pods entre plusieurs noeuds worker, et ce en utilisant l'option <em>podAntiAffinity</em> avec vos clusters standard. Vous pouvez définir deux types d'anti-affinité de pod : préféré ou obligatoire. Pour plus d'informations, voir la documentation Kubernetes sur l'<a href="https://kubernetes.io/docs/concepts/configuration/assign-pod-node/" rel="external" target="_blank" title="(S'ouvre dans un nouvel onglet ou une nouvelle fenêtre)">affectation de pods à des noeuds</a>.</p>
    <p><strong>Remarque</strong> : avec l'anti-affinité obligatoire, vous ne pouvez déployer que le nombre de répliques correspondant au nombre de noeuds worker. Par exemple, si vous disposez de 3 noeuds worker dans votre cluster mais que vous définissez 5 répliques dans votre fichier YAML, seules 3 répliques sont déployées. Chaque réplique réside sur un noeud worker distinct. Les deux autres répliques restent en attente. Si vous ajoutez un autre noeud worker dans votre cluster, l'une de ces répliques restantes se déploie automatiquement sur ce nouveau noeud.<p>
    <p><strong>Exemples de fichiers YAML de déploiement</strong>:<ul>
    <li><a href="https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/deploy-apps-clusters/nginx_preferredAntiAffinity.yaml" rel="external" target="_blank" title="(S'ouvre dans un nouvel onglet ou une nouvelle fenêtre)">Application Nginx avec anti-affinité de pod préférée.</a></li>
    <li><a href="https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/deploy-apps-clusters/liberty_requiredAntiAffinity.yaml" rel="external" target="_blank" title="(S'ouvre dans un nouvel onglet ou une nouvelle fenêtre)">Application IBM WebSphere Application Server Liberty avec anti-affinité de pod obligatoire.</a></li></ul></p>
    </dd>
<dt>Disséminez les pods entre plusieurs zones ou régions</dt>
  <dd>Pour protéger votre application en cas de défaillance d'un emplacement ou d'une région, vous pouvez créer un second cluster dans un autre emplacement ou une autre région et utiliser un fichier YAML de déploiement afin de déployer un doublon du jeu de répliques pour votre application. En ajoutant une route partagée et un équilibreur de charge devant vos clusters, vous pouvez répartir votre charge de travail entre plusieurs emplacements et régions. Pour plus d'informations, voir [Haute disponibilité de cluster](cs_clusters.html#clusters).
  </dd>
</dl>


### Déploiement d'application minimal
{: #minimal_app_deployment}

Un déploiement élémentaire d'application dans un cluster gratuit ou standard pourrait inclure les composants suivants.
{: shortdesc}

![Configuration de déploiement](images/cs_app_tutorial_components1.png)

Pour déployer les composants pour une application minimale comme illustré dans le diagramme, vous utilisez un fichier de configuration semblable à l'exemple suivant :
```
apiVersion: apps/v1beta1
kind: Deployment
metadata:
  name: ibmliberty
spec:
  replicas: 1
  template:
    metadata:
      labels:
        app: ibmliberty
    spec:
      containers:
      - name: ibmliberty
        image: registry.bluemix.net/ibmliberty:latest
        ports:
        - containerPort: 9080        
---
apiVersion: v1
kind: Service
metadata:
  name: ibmliberty-service
  labels:
    app: ibmliberty
spec:
  selector:
    app: ibmliberty
  type: NodePort
  ports:
   - protocol: TCP
     port: 9080
```
{: codeblock}

**Remarque :** pour exposer votre service, assurez-vous que la paire clé-valeur que vous utilisez dans la section `spec.selector` du service est identique à celle que vous utilisez dans la section `spec.template.metadata.labels` du fichier YAML de déploiement.
Pour en savoir plus sur chaque composant, consultez les [concepts de base de Kubernetes](cs_tech.html#kubernetes_basics).

<br />




## Lancement du tableau de bord Kubernetes
{: #cli_dashboard}

Ouvrez un tableau de bord Kubernetes sur votre système local pour consulter des informations sur un cluster et ses noeuds worker.
{:shortdesc}

Avant de commencer, [ciblez avec votre interface de ligne de commande](cs_cli_install.html#cs_cli_configure) votre cluster. Cette tâche requiert d'utiliser la [règle d'accès administrateur](cs_users.html#access_policies). Vérifiez votre [règle d'accès actuelle](cs_users.html#infra_access).

Vous pouvez utiliser le port par défaut ou définir votre propre port pour lancer le tableau de bord Kubernetes d'un cluster.

1.  Pour les clusters avec un maître Kubernetes version 1.7.16 ou antérieure :

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

    2.  Ouvrez le tableau de bord Kubernetes dans un navigateur Web.

        ```
        http://localhost:8001/ui
        ```
        {: codeblock}

2.  Pour les clusters avec un maître Kubernetes version 1.8.2 ou supérieure :

    1.  Extrayez vos données d'identification pour Kubernetes.

        ```
        kubectl config view -o jsonpath='{.users[0].user.auth-provider.config.id-token}'
        ```
        {: pre}

    2.  Copiez la valeur **id-token** affichée dans la sortie.

    3.  Affectez le numéro de port par défaut au proxy.

        ```
        kubectl proxy
        ```
        {: pre}

        Exemple de sortie :

        ```
        Starting to serve on 127.0.0.1:8001
        ```
        {: screen}

    4.  Connectez-vous au tableau de bord.

      1.  Dans votre navigateur, accédez à l'URL suivante :

          ```
          http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/
          ```
          {: codeblock}

      2.  Sur la page de connexion, sélectionnez la méthode d'authentification par **Jeton**.

      3.  Collez ensuite la valeur **id-token** que vous aviez copiée dans la zone **Jeton** et cliquez sur **Connexion**.

[Ensuite, vous pouvez exécuter un fichier de configuration à partir du tableau de bord.](#app_ui)

Lorsque vous avez fini d'examiner le tableau de bord Kubernetes, utilisez les touches `CTRL+C` pour quitter la commande
`proxy`. Après avoir quitté, le tableau de bord Kubernetes n'est plus disponible. Exécutez la commande `proxy` pour redémarrer le tableau de bord Kubernetes.



<br />




## Création de valeurs confidentielles
{: #secrets}

Les valeurs confidentielles Kubernetes permettent de stocker de manière
sécurisée des informations sensibles, comme les noms des utilisateurs, leurs mots de passe ou leurs clés.
{:shortdesc}

<table>
<caption>Fichiers requis à stocker dans les valeurs confidentielles par tâche</caption>
<thead>
<th>Tâche</th>
<th>Fichiers à stocker dans des valeurs confidentielles</th>
</thead>
<tbody>
<tr>
<td>Ajout d'un service à un cluster</td>
<td>Aucun. Une valeur confidentielle est automatiquement créée lorsque vous liez un service à un cluster.</td>
</tr>
<tr>
<td>Facultatif : Configurez le service Ingress avec TLS, si vous n'utilisez pas ingress-secret. <p><b>Remarque</b> : TLS est déjà activé par défaut et une valeur confidentielle créée pour la connexion TLS.

Pour afficher la valeur confidentielle TLS par défaut :
<pre>
bx cs cluster-get &lt;cluster_name_or_ID&gt; | grep "Ingress secret"
</pre>
</p>
Pour créer à la place votre propre valeur confidentielle, exécutez la procédure décrite dans cette rubrique.</td>
<td>Certificat et clé de serveur : <code>server.crt</code> et <code>server.key</code></td>
<tr>
<td>Création de l'annotation mutual-authentication.</td>
<td>Certificat d'autorité de certification : <code>ca.crt</code></td>
</tr>
</tbody>
</table>

Pour plus d'informations sur les éléments que vous pouvez stocker dans les valeurs confidentielles, voir la [documentation Kubernetes](https://kubernetes.io/docs/concepts/configuration/secret/).



Pour créer une valeur confidentielle avec un certificat :

1. Procurez-vous le certificat d'autorité de certification et la clé auprès de votre fournisseur de certificat. Si vous disposez de votre propre domaine, achetez un certificat TLS officiel pour votre domaine. Pour des tests, vous pouvez générer un certificat autosigné.

 **Important** : assurez-vous que la valeur [CN](https://support.dnsimple.com/articles/what-is-common-name/) est différente pour chaque certificat.

 Le certificat et la clé du client doivent être vérifiés jusqu'au niveau du certificat racine accrédité qui, dans ce cas, est le certificat de l'autorité de certification. Exemple :

 ```
 Client Certificate: issued by Intermediate Certificate
 Intermediate Certificate: issued by Root Certificate
 Root Certificate: issued by itself
 ```
 {: codeblock}

2. Créez le certificat en tant que valeur confidentielle Kubernetes.

   ```
   kubectl create secret generic <secret_name> --from-file=<cert_file>=<cert_file>
   ```
   {: pre}

   Exemples :
   - Connexion TLS :

     ```
     kubectl create secret tls <secret_name> --from-file=tls.crt=server.crt --from-file=tls.key=server.key
     ```
     {: pre}

   - Annotation d'authentification mutuelle :

     ```
     kubectl create secret generic <secret_name> --from-file=ca.crt=ca.crt
     ```
     {: pre}

<br />





## Déploiement d'applications depuis l'interface graphique
{: #app_ui}

Lorsque vous déployez une application dans votre cluster à l'aide du tableau de bord Kubernetes, une ressource de déploiement crée, met à jour et gère automatiquement les pods dans votre cluster.
{:shortdesc}

Avant de commencer :

-   Installez les [interfaces de ligne de commande](cs_cli_install.html#cs_cli_install) requises.
-   [Ciblez votre interface de ligne de commande](cs_cli_install.html#cs_cli_configure) vers votre cluster.

Pour déployer votre application :

1.  Ouvrez le [tableau de bord](#cli_dashboard) Kubernetes et cliquez sur **+ Créer**.
2.  Entrez les détails de votre application en choisissant l'une de ces deux méthodes :
  * Sélectionnez **Spécifier les détails de l'application ci-dessous** et entrez les détails.
  * Sélectionnez **Télécharger un fichier YAML ou JSON** pour télécharger le [fichier de configuration ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe") de votre application](https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-container/).

  Besoin d'aide sur votre fichier de configuration ? Consultez cet [exemple de fichier YAML ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://github.com/IBM-Cloud/kube-samples/blob/master/deploy-apps-clusters/deploy-ibmliberty.yaml). Dans cet exemple, un conteneur est déployé à partir d'une image **ibmliberty** dans la région du Sud des Etats-Unis (US-South).
  {: tip}

3.  Vérifiez que vous avez déployé correctement votre application à l'aide de l'une des méthodes suivantes :
  * Dans le tableau de bord Kubernetes, cliquez sur **Déploiements**. La liste des déploiements ayant abouti s'affiche.
  * Si votre application est [accessible au public](cs_network_planning.html#public_access), accédez à la page de présentation du cluster dans votre tableau de bord {{site.data.keyword.containerlong}}. Copiez le sous-domaine qui se trouve dans la section récapitulatif des clusters et collez-le dans un navigateur pour afficher votre application.

<br />


## Déploiement d'applications depuis l'interface CLI
{: #app_cli}

Après avoir créé un cluster, vous pouvez y déployer une application à l'aide de l'interface CLI de Kubernetes.
{:shortdesc}

Avant de commencer :

-   Installez les
[interfaces de ligne de
commande](cs_cli_install.html#cs_cli_install) requises.
-   [Ciblez votre interface de ligne de commande](cs_cli_install.html#cs_cli_configure) vers votre cluster.

Pour déployer votre application :

1.  Créez un fichier de configuration basé sur les [pratiques Kubernetes recommandées ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/concepts/configuration/overview/). En général, un fichier de configuration contient des informations de configuration détaillées pour chacune des ressources que vous créez dans Kubernetes. Votre script peut inclure une ou plusieurs des sections suivantes :

    -   [Deployments ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) : définit la création des pods et des jeux de répliques. Un pod contient une application conteneurisée unique et les jeux de répliques contrôlent plusieurs instances de pods.

    -   [Service ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/concepts/services-networking/service/) : fournit un accès frontal aux pods en utilisant une adresse IP publique de noeud worker ou d'équilibreur de charge, ou une route Ingress publique.

    -   [Ingress ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/concepts/services-networking/ingress/) : spécifie un type d'équilibreur de charge qui fournit des routes permettant d'accéder publiquement à l'application.

    

2.  Exécutez le fichier de configuration dans un contexte de cluster.

    ```
    kubectl apply -f config.yaml
    ```
    {: pre}

3.  Si vous avez rendu votre application disponible au public en utilisant un service de port de noeud, un service d'équilibreur de charge ou Ingress, vérifiez que vous pouvez accéder à l'application.

<br />




## Mise à l'échelle des applications 
{: #app_scaling}

Avec Kubernetes, vous pouvez activer la [mise à l'échelle automatique horizontale de pod ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/) pour augmenter ou diminuer automatiquement le nombre d'instances de vos applications en fonction de l'UC.
{:shortdesc}

Vous recherchez des informations sur la mise à l'échelle des applications Cloud Foundry ? Consultez [IBM - Mise à l'échelle automatique pour {{site.data.keyword.Bluemix_notm}}](/docs/services/Auto-Scaling/index.html). 
{: tip}

Avant de commencer :
- [Ciblez votre interface de ligne de commande](cs_cli_install.html#cs_cli_configure) vers votre cluster.
- La surveillance avec Heapster doit être déployée dans le cluster qui doit faire l'objet de la mise à l'échelle automatique.

Etapes :

1.  Déployez votre application dans le cluster depuis l'interface CLI. Lorsque vous déployez votre application vous devez solliciter une unité centrale (cpu).

    ```
    kubectl run <app_name> --image=<image> --requests=cpu=<cpu> --expose --port=<port_number>
    ```
    {: pre}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composantes de cette commande</th>
    </thead>
    <tbody>
    <tr>
    <td><code>--image</code></td>
    <td>Application que vous désirez déployer.</td>
    </tr>
    <tr>
    <td><code>--request=cpu</code></td>
    <td>UC requise pour le conteneur, exprimée en milli-coeurs. Par exemple, <code>--requests=200m</code>.</td>
    </tr>
    <tr>
    <td><code>--expose</code></td>
    <td>Lorsque la valeur est true, un service externe est créé.</td>
    </tr>
    <tr>
    <td><code>--port</code></td>
    <td>Port sur lequel votre application est disponible en externe.</td>
    </tr></tbody></table>

    Pour les déploiements plus complexes, vous devrez éventuellement créer un [fichier de configuration](#app_cli).
    {: tip}

2.  Créez un service de mise à l'échelle automatique et définissez votre règle. Pour plus d'informations sur l'utilisation de la commande `kubectl autoscale`, voir la [documentation Kubernetes ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://v1-8.docs.kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#autoscale).

    ```
    kubectl autoscale deployment <deployment_name> --cpu-percent=<percentage> --min=<min_value> --max=<max_value>
    ```
    {: pre}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composantes de cette commande</th>
    </thead>
    <tbody>
    <tr>
    <td><code>--cpu-percent</code></td>
    <td>Utilisation d'UC moyenne gérée par le programme de mise à l'échelle automatique de pod horizontale, exprimée en pourcentage.</td>
    </tr>
    <tr>
    <td><code>--min</code></td>
    <td>Nombre minimal de pods déployés utilisés pour gérer le pourcentage d'utilisation d'UC spécifié.</td>
    </tr>
    <tr>
    <td><code>--max</code></td>
    <td>Nombre maximum de pods déployés utilisés pour gérer le pourcentage d'utilisation d'UC spécifié.</td>
    </tr>
    </tbody></table>


<br />


## Gestion des déploiements en continu
{: #app_rolling}

Vous pouvez gérer un déploiement en continu automatique et contrôlé de vos modifications. S'il ne correspond pas à ce que vous aviez prévu, vous pouvez rétromigrer le déploiement vers la dernière révision.
{:shortdesc}

Avant de commencer, créez un [déploiement](#app_cli).

1.  [Déployez ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#rollout) une modification. Par exemple, vous souhaiterez peut-être modifier l'image que vous avez utilisée dans votre déploiement initial.

    1.  Identifiez le nom du déploiement.

        ```
        kubectl get deployments
        ```
        {: pre}

    2.  Identifiez le nom du pod.

        ```
        kubectl get pods
        ```
        {: pre}

    3.  Identifiez le nom du conteneur s'exécutant dans le pod.

        ```
        kubectl describe pod <pod_name>
        ```
        {: pre}

    4.  Définissez la nouvelle image à utiliser par le déploiement.

        ```
        kubectl set image deployment/<deployment_name><container_name>=<image_name>
        ```
        {: pre}

    Lorsque vous exécutez les commandes, la modification est immédiatement appliquée et consignée dans l'historique de déploiement.

2.  Vérifiez le statut de votre déploiement.

    ```
    kubectl rollout status deployments/<deployment_name>
    ```
    {: pre}

3.  Rétromigrez une modification.
    1.  Affichez l'historique des modifications en continu du déploiement et identifiez le numéro de révision de votre dernier déploiement.

        ```
        kubectl rollout history deployment/<deployment_name>
        ```
        {: pre}

        **Astuce :** pour afficher les détails d'une révision spécifique, incluez le numéro de la révision.

        ```
        kubectl rollout history deployment/<deployment_name> --revision=<number>
        ```
        {: pre}

    2.  Rétablissez la version précédente ou spécifiez la révision à rétablir. Pour rétromigrer vers la révision précédente, utilisez la commande suivante.

        ```
        kubectl rollout undo deployment/<depoyment_name> --to-revision=<number>
        ```
        {: pre}

<br />


