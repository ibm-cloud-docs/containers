---

copyright:
  years: 2014, 2018
lastupdated: "2018-08-06"

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

Découvrez les étapes générales de déploiement d'applications en cliquant sur une zone de l'image suivante. Vous voulez commencer par un déploiement de base ? Suivez le [tutoriel de déploiement des applications](cs_tutorials_apps.html#cs_apps_tutorial).

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

![Niveaux de haute disponibilité pour une application](images/cs_app_ha_roadmap-mz.png)

1.  Déploiement avec n+2 pods gérés par un jeu de répliques dans un seul noeud figurant dans un cluster à zone unique.
2.  Déploiement avec n+2 pods gérés par un jeu de répliques et disséminés entre plusieurs noeuds (anti-affinité) dans un cluster à zone unique.
3.  Déploiement avec n+2 pods gérés par un jeu de répliques et disséminés entre plusieurs noeuds (anti-affinité) dans un cluster à zones multiples entre différentes zones.

Vous pouvez également [connecter plusieurs clusters dans différentes régions avec un équilibreur de charge global](cs_clusters.html#multiple_clusters) pour une haute disponibilité accrue.

### Augmentation de la disponibilité de votre application
{: #increase_availability}

<dl>
  <dt>Utilisez des déploiements et des jeux de répliques pour déployer votre application et ses dépendances</dt>
    <dd><p>Un déploiement est une ressource Kubernetes que vous pouvez utiliser pour déclarer tous les composants de votre application et de ses dépendances. Avec les déploiements, vous n'avez pas à noter toutes les étapes, ce qui vous permet de vous concentrer sur votre application.</p>
    <p>Lorsque vous déployez plusieurs pods, un jeu de répliques est créé automatiquement pour vos déploiements afin de surveiller les pods et de garantir que le nombre voulu de pods est opérationnel en tout temps. Lorsqu'un pod tombe en panne, le jeu de répliques remplace le pod ne répondant plus par un nouveau.</p>
    <p>Vous pouvez utiliser un déploiement pour définir des stratégies de mise à jour de votre application, notamment le nombre de pods que vous désirez ajouter lors d'une mise à jour en continu et le nombre de pods pouvant être indisponibles à un moment donné. Lorsque vous effectuez une mise à jour en continu, le déploiement vérifie si la révision est fonctionnelle et l'arrête si des échecs sont détectés.</p>
    <p>Avec les déploiements, vous pouvez déployer simultanément plusieurs révisions avec différents indicateurs. Par exemple, vous pouvez d'abord tester un déploiement avant de décider de l'utiliser en environnement de production.</p>
    <p>Les déploiements vous permettent de suivre toutes les révisions déployées. Vous pouvez utiliser cet historique pour rétablir une version antérieure si vous constatez que vos mises à jour ne fonctionnent pas comme prévu.</p></dd>
  <dt>Incluez suffisamment de répliques pour répondre à la charge de travail de votre application, plus deux répliques</dt>
    <dd>Pour rendre votre application encore plus disponible et réfractaire aux échecs, envisagez d'inclure des répliques supplémentaires au-delà du strict minimum requis pour gérer la charge de travail anticipée. Ces répliques supplémentaires pourront gérer la charge de travail en cas de panne d'un pod et avant que le jeu de répliques n'ait encore rétabli le pod défaillant. Pour une protection face à deux défaillances simultanées de pods, incluez deux répliques supplémentaires. Cette configuration correspond à un canevas N+2, où N désigne le nombre de pods destinés à traiter la charge de travail entrante et +2 indique deux répliques supplémentaires. Tant qu'il y a suffisamment d'espace dans votre cluster, vous pouvez avoir autant de pods que vous voulez.</dd>
  <dt>Disséminez les pods entre plusieurs noeuds (anti-affinité)</dt>
    <dd><p>Lorsque vous créez votre déploiement, vous pouvez déployer tous les pods sur le même noeud worker. C'est ce qu'on appelle affinité ou collocation. Pour protéger votre application contre une défaillance de noeud worker, vous pouvez configurer votre déploiement de sorte à disséminer les pods entre plusieurs noeuds worker, et ce en utilisant l'option <em>podAntiAffinity</em> avec vos clusters standard. Vous pouvez définir deux types d'anti-affinité de pod : préféré ou obligatoire. Pour plus d'informations, voir la documentation Kubernetes sur l'<a href="https://kubernetes.io/docs/concepts/configuration/assign-pod-node/" rel="external" target="_blank" title="(S'ouvre dans un nouvel onglet ou une nouvelle fenêtre)">affectation de pods à des noeuds</a>.</p>
    <p><strong>Remarque</strong> : avec l'anti-affinité obligatoire, vous ne pouvez déployer que le nombre de répliques correspondant au nombre de noeuds worker. Par exemple, si vous disposez de 3 noeuds worker dans votre cluster mais que vous définissez 5 répliques dans votre fichier YAML, seules 3 répliques sont déployées. Chaque réplique réside sur un noeud worker distinct. Les deux autres répliques restent en attente. Si vous ajoutez un autre noeud worker dans votre cluster, l'une de ces répliques restantes se déploie automatiquement sur ce nouveau noeud.<p>
    <p><strong>Exemples de fichiers YAML de déploiement</strong> :<ul>
    <li><a href="https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/deploy-apps-clusters/nginx_preferredAntiAffinity.yaml" rel="external" target="_blank" title="(S'ouvre dans un nouvel onglet ou une nouvelle fenêtre)">Application Nginx avec anti-affinité de pod préférée.</a></li>
    <li><a href="https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/deploy-apps-clusters/liberty_requiredAntiAffinity.yaml" rel="external" target="_blank" title="(S'ouvre dans un nouvel onglet ou une nouvelle fenêtre)">Application IBM WebSphere Application Server Liberty avec anti-affinité de pod obligatoire.</a></li></ul></p>
    
    </dd>
<dt>Disséminez les pods entre plusieurs zones ou régions</dt>
  <dd><p>Pour protéger votre application en cas de défaillance d'une zone, vous pouvez créer plusieurs clusters dans des zones distinctes ou ajouter des zones dans un pool de noeuds worker dans un cluster à zones multiples. Les clusters à zones multiples sont disponibles uniquement dans certaines [métropoles](cs_regions.html#zones), comme Dallas. Si vous créez plusieurs clusters dans des zones distinctes, vous devez [configurer un équilibreur de charge global](cs_clusters.html#multiple_clusters).</p>
  <p>Lorsque vous utilisez un jeu de répliques et spécifiez l'anti-affinité pour les pods, Kubernetes répartit les pods d'application sur les différents noeuds. Si vos noeuds se trouvent dans plusieurs zones, les pods sont répartis entre les zones, pour augmenter la disponibilité de votre application. Si vous souhaitez limiter l'exécution de vos applications à une seule zone, vous pouvez configurer l'affinité de pod pour créer et labelliser un pool de noeuds worker dans une zone. Pour plus d'informations, voir [Haute disponibilité pour les clusters à zones multiples](cs_clusters.html#ha_clusters).</p>
  <p><strong>Dans le déploiement d'un cluster à zones multiples, mes pods d'application sont-ils répartis uniformément entre les noeuds ?</strong></p>
  <p>Les pods sont répartis uniformément entre les zones mais pas toujours entre les noeuds. Par exemple, si vous disposez d'un cluster avec un noeud dans chacune des trois zones et que vous déployez un jeu de répliques de 6 pods, chaque noeud obtient 2 pods. Cependant, si vous avez un cluster avec 2 noeuds dans chacune des 3 zones et que vous déployez un jeu de répliques de 6 pods, chaque zone dispose de deux pods planifiés et peut ou non planifier 1 pod par noeud. Pour avoir plus de contrôle sur la planification, vous pouvez [définir l'affinité entre les pods  ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node).</p>
  <p><strong>En cas de défaillance d'une zone, comment sont replanifiés les pods sur les noeuds restants dans les autres zones ?</strong></br>Tout dépend de la règle de planification que vous avez utilisée dans le déploiement. Si vous avez inclus l'[affinité entre pods de noeuds spécifiques ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#node-affinity-beta-feature), vos pods ne sont pas replanifiés. Si vous ne l'avez pas fait, les pods sont créés sur les noeuds worker disponibles dans d'autres zones, mais risquent de ne pas être équilibrés. Par exemple, les 2 pods peuvent être répartis sur les 2 noeuds disponibles ou peuvent être planifiés tous les deux sur 1 noeud doté de la capacité disponible. De même, lorsque la zone indisponible est restaurée, les pods ne sont pas automatiquement supprimés et rééquilibrés entre les noeuds. Pour que les pods soient rééquilibrés entre les zones une fois qu'une zone redevient opérationnelle, envisagez l'utilisation de l'[outil de déplanification de Kubernetes ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://github.com/kubernetes-incubator/descheduler).</p>
  <p><strong>Astuce</strong> : dans les clusters à zones multiples, tâchez de maintenir la capacité de vos noeuds worker à 50% par zone de sorte à disposer d'une capacité disponible suffisante pour protéger votre cluster en cas de défaillance de zone.</p>
  <p><strong>Que faire pour répartir mon application entre les différentes régions ?</strong></br>Pour protéger votre application en cas de défaillance de zone, créez un deuxième cluster dans une autre région, [configurez un équilibreur de charge global](cs_clusters.html#multiple_clusters) pour connecter vos clusters, et utilisez un fichier YAML de déploiement pour déployer un jeu de répliques dupliqué avec [anti-affinité de pod ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/) pour votre application.</p>
  <p><strong>Que faire si mes applications nécessitent du stockage persistant ?</strong></p>
  <p>Utilisez un service de cloud, comme par exemple [{{site.data.keyword.cloudant_short_notm}}](/docs/services/Cloudant/getting-started.html#getting-started-with-cloudant) ou [{{site.data.keyword.cos_full_notm}}](/docs/services/cloud-object-storage/about-cos.html#about-ibm-cloud-object-storage).</p></dd>
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

Ouvrez un tableau de bord Kubernetes sur votre système local pour consulter des informations sur un cluster et ses noeuds worker. [Dans l'interface graphique](#db_gui), vous pouvez accéder au tableau de bord par simple clic sur un bouton. [Avec l'interface de ligne de commande (CLI)](#db_cli), vous pouvez accéder au tableau de bord ou utiliser les étapes d'un processus automatique, comme pour un pipeline CI/CD.
{:shortdesc}

Avant de commencer, [ciblez votre interface de ligne de commande](cs_cli_install.html#cs_cli_configure) sur votre cluster.

Vous pouvez utiliser le port par défaut ou définir votre propre port pour lancer le tableau de bord Kubernetes d'un cluster.

**Lancement du tableau de bord Kubernetes à partir de l'interface graphique**
{: #db_gui}

1.  Connectez-vous à l'[interface graphique {{site.data.keyword.Bluemix_notm}}](https://console.bluemix.net/).
2.  Dans le profil figurant dans la barre de menu, sélectionnez le compte que vous souhaitez utiliser.
3.  Dans le menu, cliquez sur **Conteneurs**.
4.  Sur la page **Clusters**, cliquez sur le cluster auquel vous souhaitez accéder.
5.  Sur la page des détails du cluster, cliquez sur le bouton **Tableau de bord Kubernetes**.

</br>
</br>

**Lancement du tableau de bord Kubernetes à partir de l'interface de ligne de commande (CLI)**
{: #db_cli}

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

Lorsque vous avez fini d'examiner le tableau de bord Kubernetes, utilisez les touches `CTRL+C` pour quitter la commande `proxy`. Après avoir quitté, le tableau de bord Kubernetes n'est plus disponible. Exécutez la commande `proxy` pour redémarrer le tableau de bord Kubernetes.

[Ensuite, vous pouvez exécuter un fichier de configuration à partir du tableau de bord.](#app_ui)

<br />


## Création de valeurs confidentielles
{: #secrets}

Les valeurs confidentielles Kubernetes permettent de stocker de manière sécurisée des informations sensibles, comme les noms des utilisateurs, leurs mots de passe ou leurs clés.
{:shortdesc}

Passez en revue les tâches suivantes qui nécessitent des valeurs confidentielles. Pour plus d'informations sur ce que vous pouvez stocker dans les valeurs confidentielles, voir la [documentation de Kubernetes ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/concepts/configuration/secret/).

### Ajout de service dans un cluster
{: #secrets_service}

Lorsque vous liez un service à un cluster, vous n'avez pas besoin de créer une valeur confidentielle. Elle est automatiquement créée pour vous. Pour plus d'informations, voir [Ajout de services Cloud Foundry à des clusters](cs_integrations.html#adding_cluster).

### Configuration de l'équilibreur de charge d'application (ALB) Ingress pour l'utilisation de TLS
{: #secrets_tls}

L'équilibreur de charge ALB équilibre la charge du trafic réseau HTTP vers les applications de votre cluster. Pour équilibrer la charge des connexions HTTPS entrantes, vous pouvez configurer l'équilibreur de charge ALB pour déchiffrer le trafic réseau et transférer la demande déchiffrée aux applications exposées dans votre cluster.

Si vous utilisez le sous-domaine Ingress fourni par IBM, vous pouvez [utiliser le certificat TLS fourni par IBM](cs_ingress.html#public_inside_2). Pour afficher la valeur confidentielle de TLS fournie par IBM, exécutez la commande suivante :
```
ibmcloud ks cluster-get <cluster_name_or_ID> | grep "Ingress secret"
```
{: pre}

Si vous utilisez un domaine personnalisé, vous pouvez utiliser votre propre certificat pour gérer la terminaison TLS. Pour créer votre propre valeur confidentielle TLS :
1. Générez une clé et un certificat avec l'une de ces méthodes :
    * Procurez-vous un certificat d'autorité de certification et une clé auprès de votre fournisseur de certificat. Si vous disposez de votre propre domaine, achetez un certificat TLS officiel pour votre domaine.
      **Important** : vérifiez que l'élément [CN ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://support.dnsimple.com/articles/what-is-common-name/) est différent pour chaque certificat.
    * A des fins de test, vous pouvez créer un certificat autosigné en utilisant OpenSSL. Pour plus d'informations, voir ce [tutoriel sur les certificats SSL autosignés ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://www.akadia.com/services/ssh_test_certificate.html).
        1. Créez la clé `tls.key`.
            ```
            openssl genrsa -out tls.key 2048
            ```
            {: pre}
        2. Utilisez cette clé pour créer un certificat `tls.crt`.
            ```
            openssl req -new -x509 -key tls.key -out tls.crt
            ```
            {: pre}
2. [Convertissez le certificat et la clé en base 64 ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://www.base64encode.org/).
3. Créez un fichier de valeur confidentielle YAML en utilisant le certificat et la clé.
     ```
     apiVersion: v1
     kind: Secret
     metadata:
       name: ssl-my-test
     type: Opaque
     data:
       tls.crt: <client_certificate>
       tls.key: <client_key>
     ```
     {: codeblock}

4. Créez le certificat en tant que valeur confidentielle Kubernetes.
     ```
     kubectl create -f ssl-my-test
     ```
     {: pre}

### Personnalisation de l'équilibreur de charge ALB Ingress avec l'annotation des services SSL
{: #secrets_ssl_services}

Vous pouvez utiliser l'[annotation `ingress.bluemix.net/ssl-services`](cs_annotations.html#ssl-services) pour chiffrer le trafic vers vos applications en amont depuis l'équilibreur de charge ALB Ingress. Pour créer la valeur confidentielle :

1. Procurez-vous la clé et le certificat de l'autorité de certification (AC) de votre serveur en amont.
2. [Convertissez le certificat en base 64 ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://www.base64encode.org/).
3. Créez un fichier YAML de valeur confidentielle à l'aide de la valeur cert.
     ```
     apiVersion: v1
     kind: Secret
     metadata:
       name: ssl-my-test
     type: Opaque
     data:
       trusted.crt: <ca_certificate>
     ```
     {: codeblock}
     **Remarque** : si vous souhaitez également imposer l'authentification mutuelle pour le trafic en amont, vous pouvez fournir les éléments `client.crt` et `client.key` en plus de `trusted.crt` dans la section data.
4. Créez le certificat en tant que valeur confidentielle Kubernetes.
     ```
     kubectl create -f ssl-my-test
     ```
     {: pre}

### Personnalisation de l'équilibreur de charge ALB Ingress avec l'annotation d'authentification mutuelle
{: #secrets_mutual_auth}

Vous pouvez utiliser l'[annotation `ingress.bluemix.net/mutual-auth`](cs_annotations.html#mutual-auth) pour configurer l'authentification mutuelle de votre trafic en aval pour l'équilibreur de charge ALB Ingress. Pour créer une valeur confidentielle pour l'authentification mutuelle :

1. Générez une clé et un certificat avec l'une de ces méthodes :
    * Procurez-vous un certificat d'autorité de certification et une clé auprès de votre fournisseur de certificat. Si vous disposez de votre propre domaine, achetez un certificat TLS officiel pour votre domaine.
      **Important** : vérifiez que l'élément [CN ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://support.dnsimple.com/articles/what-is-common-name/) est différent pour chaque certificat.
    * A des fins de test, vous pouvez créer un certificat autosigné en utilisant OpenSSL. Pour plus d'informations, voir ce [tutoriel sur les certificats SSL autosignés ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://www.akadia.com/services/ssh_test_certificate.html).
        1. Créez une clé `ca.key`.
            ```
            openssl genrsa -out ca.key 1024
            ```
            {: pre}
        2. Utilisez cette clé pour créer un élément `ca.crt`.
            ```
            openssl req -new -x509 -key ca.key -out ca.crt
            ```
            {: pre}
        3. Utilisez l'élément `ca.crt` pour créer un certificat autosigné.
            ```
            openssl x509 -req -in example.org.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out example.org.crt
            ```
            {: pre}
2. [Convertissez le certificat en base 64 ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://www.base64encode.org/).
3. Créez un fichier YAML de valeur confidentielle à l'aide de la valeur cert.
     ```
     apiVersion: v1
     kind: Secret
     metadata:
       name: ssl-my-test
     type: Opaque
     data:
       ca.crt: <ca_certificate>
     ```
     {: codeblock}
4. Créez le certificat en tant que valeur confidentielle Kubernetes.
     ```
     kubectl create -f ssl-my-test
     ```
     {: pre}

<br />


## Déploiement d'applications depuis l'interface graphique
{: #app_ui}

Lorsque vous déployez une application dans votre cluster à l'aide du tableau de bord Kubernetes, une ressource de déploiement crée, met à jour et gère automatiquement les pods dans votre cluster.
{:shortdesc}

Avant de commencer :

-   Installez les [interfaces de ligne de commande](cs_cli_install.html#cs_cli_install) requises.
-   [Ciblez votre interface de ligne de commande](cs_cli_install.html#cs_cli_configure) sur votre cluster.

Pour déployer votre application :

1.  Ouvrez le [tableau de bord](#cli_dashboard) Kubernetes et cliquez sur **+ Créer**.
2.  Entrez les détails de votre application en choisissant l'une de ces deux méthodes :
  * Sélectionnez **Spécifier les détails de l'application ci-dessous** et entrez les détails.
  * Sélectionnez **Télécharger un fichier YAML ou JSON** pour télécharger le [fichier de configuration ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-container/) de votre application.

  Besoin d'aide sur votre fichier de configuration ? Consultez cet [exemple de fichier YAML ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://github.com/IBM-Cloud/kube-samples/blob/master/deploy-apps-clusters/deploy-ibmliberty.yaml). Dans cet exemple, un conteneur est déployé à partir d'une image **ibmliberty** dans la région du Sud des Etats-Unis (US-South). Découvrez comment [sécuriser vos informations personnelles](cs_secure.html#pi) lorsque vous utilisez des ressources Kubernetes.
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

-   Installez les [interfaces de ligne de commande](cs_cli_install.html#cs_cli_install) requises.
-   [Ciblez votre interface de ligne de commande](cs_cli_install.html#cs_cli_configure) sur votre cluster.

Pour déployer votre application :

1.  Créez un fichier de configuration basé sur les [pratiques Kubernetes recommandées ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/concepts/configuration/overview/). En général, un fichier de configuration contient des informations de configuration détaillées pour chacune des ressources que vous créez dans Kubernetes. Votre script peut inclure une ou plusieurs des sections suivantes :

    -   [Deployments ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) : définit la création des pods et des jeux de répliques. Un pod contient une application conteneurisée unique et les jeux de répliques contrôlent plusieurs instances de pods.

    -   [Service ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/concepts/services-networking/service/) : fournit un accès frontal aux pods en utilisant une adresse IP publique de noeud worker ou d'équilibreur de charge, ou une route Ingress publique.

    -   [Ingress ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/concepts/services-networking/ingress/) : spécifie un type d'équilibreur de charge qui fournit des routes permettant d'accéder publiquement à l'application.

    Découvrez comment [sécuriser vos informations personnelles](cs_secure.html#pi) lorsque vous utilisez des ressources Kubernetes.

2.  Exécutez le fichier de configuration dans un contexte de cluster.

    ```
    kubectl apply -f config.yaml
    ```
    {: pre}

3.  Si vous avez rendu votre application disponible au public en utilisant un service Nodeport, un service d'équilibreur de charge ou Ingress, vérifiez que vous pouvez accéder à l'application.

<br />


## Déploiement d'applications sur des noeuds worker spécifiques à l'aide de libellés
{: #node_affinity}

Lorsque vous déployez une application, les pods d'application déploient plusieurs noeuds worker dans votre cluster sans discernement. Dans certains cas, vous souhaiterez limiter le nombre de noeuds sur lesquels se déploient les pods d'application. Par exemple, vous pouvez opter pour le déploiement des pods d'application uniquement sur les noeuds worker d'un certain pool de noeuds worker car ces noeuds se trouvent sur des machines bare metal. Pour désigner les noeuds worker sur lesquels doivent se déployer les pods d'application, ajoutez une règle d'affinité dans le déploiement de votre application.
{:shortdesc}

Avant de commencer, [ciblez votre interface de ligne de commande](cs_cli_install.html#cs_cli_configure) sur votre cluster.

1. Récupérez le nom du pool de noeuds worker sur lequel vous souhaitez déployer des pods d'application.
    ```
    ibmcloud ks worker-pools <cluster_name_or_ID>
    ```
    {:pre}

    Dans ces étapes un nom de pool de noeuds worker est pris comme exemple. Pour déployer les pods d'application sur certains noeuds worker en fonction d'un autre facteur, utilisez cette valeur à la place. Par exemple, pour déployer des pods d'application uniquement sur les noeuds worker d'un réseau local virtuel (VLAN) spécifique, obtenez l'ID de ce VLAN en exécutant la commande `ibmcloud ks vlans <zone>`.
    {: tip}

2. [Ajoutez une règle d'affinité ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#node-affinity-beta-feature) pour le nom du pool de noeuds worker dans le déploiement de l'application.

    Exemple de fichier YAML :

    ```
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
      name: with-node-affinity
    spec:
      template:
        spec:
          affinity:
            nodeAffinity:
              requiredDuringSchedulingIgnoredDuringExecution:
                nodeSelectorTerms:
                - matchExpressions:
                  - key: workerPool
                    operator: In
                    values:
                    - <worker_pool_name>
    ...
    ```
    {: codeblock}

    Dans la section **affinity** du fichier YAML indiqué en exemple, `workerPool` est la clé (`key`) et `<worker_pool_name>` est la valeur (`value`).

3. Appliquez le fichier de configuration de déploiement mis à jour.
    ```
    kubectl apply -f with-node-affinity.yaml
    ```
    {: pre}

4. Vérifiez que les pods d'application se sont déployés sur les noeuds worker appropriés.

    1. Affichez la liste des pods de votre cluster.
        ```
        kubectl get pods -o wide
        ```
        {: pre}

        Exemple de sortie :
        ```
        NAME                   READY     STATUS              RESTARTS   AGE       IP               NODE
        cf-py-d7b7d94db-vp8pq  1/1       Running             0          15d       172.30.xxx.xxx   10.176.48.78
        ```
        {: screen}

    2. Dans la sortie, identifiez un pod pour votre application. Notez l'adresse IP privée du noeud (**NODE**) correspondant au noeud worker dans lequel figure le pod.

        Dans la sortie de l'exemple ci-dessus, le pod d'application `cf-py-d7b7d94db-vp8pq` se trouve sur un noeud worker dont l'adresse IP est `10.176.48.78`.

    3. Affichez la liste des noeuds worker figurant dans le pool de noeuds worker que vous avez désigné dans le déploiement de votre application. 

        ```
        ibmcloud ks workers <cluster_name_or_ID> --worker-pool <worker_pool_name>
        ```
        {: pre}

        Exemple de sortie :

        ```
        ID                                                 Public IP       Private IP     Machine Type      State    Status  Zone    Version
        kube-dal10-crb20b637238bb471f8b4b8b881bbb4962-w7   169.xx.xxx.xxx  10.176.48.78   b2c.4x16          normal   Ready   dal10   1.8.6_1504
        kube-dal10-crb20b637238bb471f8b4b8b881bbb4962-w8   169.xx.xxx.xxx  10.176.48.83   b2c.4x16          normal   Ready   dal10   1.8.6_1504
        kube-dal12-crb20b637238bb471f8b4b8b881bbb4962-w9   169.xx.xxx.xxx  10.176.48.69   b2c.4x16          normal   Ready   dal12   1.8.6_1504
        ```
        {: screen}

        Si vous avez créé une règle d'affinité pour l'application en fonction d'un autre facteur, récupérez cette valeur à la place. Par exemple, pour vérifier que le pod d'application est déployé sur un noeud worker d'un VLAN spécifique, affichez le VLAN dans lequel se trouve le noeud worker en exécutant la commande `ibmcloud ks worker-get <cluster_name_or_ID> <worker_ID>`.
        {: tip}

    4. Dans la sortie, vérifiez que le noeud worker avec l'adresse IP que vous avez identifiée à l'étape précédente est déployé dans ce pool de noeuds worker.

<br />


## Déploiement d'une application sur une machine GPU
{: #gpu_app}

Si vous disposez d'un [type de machine d'unité de traitement graphique (GPU)](cs_clusters.html#shared_dedicated_node), vous pouvez planifier des charges de travail nécessitant de nombreux calculs mathématiques sur le noeud worker. Par exemple, vous pouvez exécutez une application en 3D qui utilise la plateforme CUDA (Compute Unified Device Architecture) pour partager la charge de traitement entre l'unité GPU et l'UC pour améliorer les performances.
{:shortdesc}

Dans les étapes suivantes, vous apprendrez à déployer des charges de travail nécessitant l'unité GPU. Vous pouvez également [déployer des applications](#app_ui) qui n'ont pas besoin de passer par l'unité GPU et l'UC pour traiter leurs charges de travail. Par la suite, vous trouverez peut-être utile d'expérimenter des charges de travail nécessitant de nombreux calculs par exemple avec l'infrastructure d'apprentissage automatique [TensorFlow ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://www.tensorflow.org/) avec [cette démonstration Kubernetes ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://github.com/pachyderm/pachyderm/tree/master/doc/examples/ml/tensorflow).

Avant de commencer :
* [Créez un type de machine GPU bare metal](cs_clusters.html#clusters_cli). Notez que l'exécution de ce processus peut prendre plus d'1 jour ouvrable.
* Votre maître de cluster et le noeud worker de l'unité GPU doivent exécuter Kubernetes version 1.10 ou ultérieure.

Pour exécuter une charge de travail sur une machine GPU :
1.  Créez un fichier YAML. Dans cet exemple, un fichier YALM `Job` gère des charges de travail de type lots en créant un pod provisoire qui s'exécute jusqu'à ce que l'exécution de la commande planifiée soit terminée.

    **Important** : Pour les charges de travail GPU, vous devez toujours indiquer la zone `resources: limits: nvidia.com/gpu` dans la spécification YAML.

    ```yaml
    apiVersion: batch/v1
    kind: Job
    metadata:
      name: nvidia-smi
      labels:
        name: nvidia-smi
    spec:
      template:
        metadata:
          labels:
            name: nvidia-smi
        spec:
          containers:
          - name: nvidia-smi
            image: nvidia/cuda:9.1-base-ubuntu16.04
            command: [ "/usr/test/nvidia-smi" ]
            imagePullPolicy: IfNotPresent
            resources:
              limits:
                nvidia.com/gpu: 2
            volumeMounts:
            - mountPath: /usr/test
              name: nvidia0
          volumes:
            - name: nvidia0
              hostPath:
                path: /usr/bin
          restartPolicy: Never
    ```
    {: codeblock}

    <table>
    <caption>Composants YAML</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
    </thead>
    <tbody>
    <tr>
    <td>Noms et libellé des métadonnées</td>
    <td>Indiquez un nom et un libellé (label) pour le travail et utilisez le même nom dans la zone metadata du fichier et de `spec template`. Par exemple, `nvidia-smi`.</td>
    </tr>
    <tr>
    <td><code>containers/image</code></td>
    <td>Fournissez l'image dont le conteneur est une instance d'exécution. Dans cet exemple, la valeur est définie pour utiliser l'image CUDA DockerHub : <code>nvidia/cuda:9.1-base-ubuntu16.04</code></td>
    </tr>
    <tr>
    <td><code>containers/command</code></td>
    <td>Indiquez une commande à exécuter dans le conteneur. Dans cet exemple, la commande <code>[ "/usr/test/nvidia-smi" ]</code> fait référence à un fichier binaire qui se trouve sur la machine GPU, donc vous devez également configurer un montage de volume.</td>
    </tr>
    <tr>
    <td><code>containers/imagePullPolicy</code></td>
    <td>Pour extraire une nouvelle image uniquement si l'image ne se trouve pas actuellement sur le noeud worker, indiquez <code>IfNotPresent</code>.</td>
    </tr>
    <tr>
    <td><code>resources/limits</code></td>
    <td>Pour les machines GPU, vous devez indiquer une limite de ressources. Le [plug-in d'unité![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/concepts/cluster-administration/device-plugins/) Kubernetes définit la demande de ressource par défaut pour se conformer à la limite.
    <ul><li>Vous devez indiquer la clé sous la forme <code>nvidia.com/gpu</code>.</li>
    <li>Entrez le nombre entier d'unités GPU que vous demandez, par exemple <code>2</code>. <strong>Remarque</strong> : les pods de conteneur ne partagent pas les unités GPU et les unités GPU ne peuvent pas être sursollicitées. Par exemple, si vous ne disposez que d'une machine `mg1c.16x128`, vous n'avez que 2 unités GPU dans cette machine. Vous ne pouvez donc en spécifier que `2` maximum.</li></ul></td>
    </tr>
    <tr>
    <td><code>volumeMounts</code></td>
    <td>Nom du volume monté sur le conteneur, par exemple <code>nvidia0</code>. Indiquez le chemin de montage (<code>mountPath</code>) du volume sur le conteneur. Dans cet exemple, le chemin <code>/usr/test</code> correspond au chemin utilisé dans la commande containers du travail.</td>
    </tr>
    <tr>
    <td><code> volumes</code></td>
    <td>Nom du volume de travail, par exemple <code>nvidia0</code>. Dans le chemin <code>hostPath</code> du noeud worker de l'unité GPU, indiquez le chemin (<code>path</code>) sur l'hôte, dans cet exemple, il s'agit de <code>/usr/bin</code>. Le chemin de montage (<code>mountPath</code>) du conteneur est mappé au chemin (<code>path</code>) du volume hôte, ce qui donne à ce travail l'accès aux fichiers binaires NVIDIA sur le noeud worker de l'unité GPU pour que la commande container s'exécute.</td>
    </tr>
    </tbody></table>

2.  Appliquez le fichier YAML. Exemple :

    ```
    kubectl apply -f nvidia-smi.yaml
    ```
    {: pre}

3.  Vérifiez le pod du travail en filtrant vos pods avec le libellé `nvidia-sim`. Vérifiez que la valeur de la zone **STATUS** est **Completed**.

    ```
    kubectl get pod -a -l 'name in (nvidia-sim)'
    ```
    {: pre}

    Exemple de sortie :
    ```
    NAME                  READY     STATUS      RESTARTS   AGE
    nvidia-smi-ppkd4      0/1       Completed   0          36s
    ```
    {: screen}

4.  Décrivez le pod pour voir comment le plug-in d'unité GPU a planifié le pod.
    * Dans les zones `Limits` et `Requests`, observez que la limite de ressources que vous avez spécifiée correspond à la demande définie automatiquement par le plug-in d'unité.
    * Dans les événements, vérifiez que le pod est affecté au noeud worker de votre GPU.

    ```
    kubectl describe pod nvidia-smi-ppkd4
    ```
    {: pre}

    Exemple de sortie :
    ```
    Name:           nvidia-smi-ppkd4
    Namespace:      default
    ...
    Limits:
     nvidia.com/gpu:  2
    Requests:
     nvidia.com/gpu:  2
    ...
    Events:
    Type    Reason                 Age   From                     Message
    ----    ------                 ----  ----                     -------
    Normal  Scheduled              1m    default-scheduler        Successfully assigned nvidia-smi-ppkd4 to 10.xxx.xx.xxx
    ...
    ```
    {: screen}

5.  Pour vérifier que votre travail a utilisé l'unité GPU pour calculer sa charge de travail, vous pouvez consulter les journaux. La commande `[ "/usr/test/nvidia-smi" ]` du travail interroge l'état de l'unité GPU sur le noeud worker de l'unité GPU.

    ```
    kubectl logs nvidia-sim-ppkd4
    ```
    {: pre}

    Exemple de sortie :
    ```
    +-----------------------------------------------------------------------------+
    | NVIDIA-SMI 390.12                 Driver Version: 390.12                    |
    |-------------------------------+----------------------+----------------------+
    | GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
    | Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
    |===============================+======================+======================|
    |   0  Tesla K80           Off  | 00000000:83:00.0 Off |                  Off |
    | N/A   37C    P0    57W / 149W |      0MiB / 12206MiB |      0%      Default |
    +-------------------------------+----------------------+----------------------+
    |   1  Tesla K80           Off  | 00000000:84:00.0 Off |                  Off |
    | N/A   32C    P0    63W / 149W |      0MiB / 12206MiB |      1%      Default |
    +-------------------------------+----------------------+----------------------+

    +-----------------------------------------------------------------------------+
    | Processes:                                                       GPU Memory |
    |  GPU       PID   Type   Process name                             Usage      |
    |=============================================================================|
    |  No running processes found                                                 |
    +-----------------------------------------------------------------------------+
    ```
    {: screen}

    Dans cet exemple, vous voyez que les deux unités GPU ont été utilisées pour exécuter le travail car elles étaient toutes les deux planifiées sur le noeud worker. Si la limite est définie sur 1, 1 seule unité GPU s'affiche.

## Mise à l'échelle des applications
{: #app_scaling}

Avec Kubernetes, vous pouvez activer la [mise à l'échelle automatique horizontale de pod ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/) pour augmenter ou diminuer automatiquement le nombre d'instances de vos applications en fonction de l'UC.
{:shortdesc}

Vous recherchez des informations sur la mise à l'échelle des applications Cloud Foundry ? Consultez [IBM - Mise à l'échelle automatique pour {{site.data.keyword.Bluemix_notm}}](/docs/services/Auto-Scaling/index.html). 
{: tip}

Avant de commencer :
- [Ciblez votre interface de ligne de commande](cs_cli_install.html#cs_cli_configure) sur votre cluster.
- La surveillance avec Heapster doit être déployée dans le cluster qui doit faire l'objet de la mise à l'échelle automatique.

Etapes :

1.  Déployez votre application sur un cluster à partir de l'interface de ligne de commande. Lorsque vous déployez votre application vous devez solliciter une unité centrale (cpu).

    ```
    kubectl run <app_name> --image=<image> --requests=cpu=<cpu> --expose --port=<port_number>
    ```
    {: pre}

    <table>
    <caption>Composantes de la commande kubectl run</caption>
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
    <caption>Composantes de la commande kubectl autoscale</caption>
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
    <td>Nombre maximal de pods déployés utilisés pour gérer le pourcentage d'utilisation d'UC spécifié.</td>
    </tr>
    </tbody></table>


<br />


## Gestion des déploiements en continu
{: #app_rolling}

Vous pouvez gérer le déploiement de vos modifications automatiquement et de manière contrôlée. S'il ne correspond pas à ce que vous aviez prévu, vous pouvez rétromigrer le déploiement vers la dernière révision.
{:shortdesc}

Avant de commencer, créez un [déploiement](#app_cli).

1.  [Déployez ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#updating-a-deployment) une modification. Par exemple, vous souhaiterez peut-être modifier l'image que vous avez utilisée dans votre déploiement initial.

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

