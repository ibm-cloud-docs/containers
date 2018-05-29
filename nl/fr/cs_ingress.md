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


# Exposition d'applications avec Ingress
{: #ingress}

Vous pouvez exposer plusieurs applications dans votre cluster Kubernetes en créant des ressources Ingress gérées par l'équilibreur de charge d'application (ALB) fourni par IBM dans {{site.data.keyword.containerlong}}.
{:shortdesc}

## Gestion de trafic réseau à l'aide d'Ingress
{: #planning}

Ingress est un service Kubernetes qui permet d'équilibrer les charges de travail du trafic réseau dans votre cluster en transférant des demandes publiques ou privées à vos applications. Vous pouvez utiliser Ingress pour exposer plusieurs services d'application sur un réseau public ou privé en utilisant une seule route publique ou privée.
{:shortdesc}

Ingress comporte deux composants :
<dl>
<dt>Equilibreur de charge d'application</dt>
<dd>L'équilibreur de charge d'application (ALB) est un équilibreur de charge externe qui est à l'écoute des demandes de service HTTP, HTTPS, TCP ou UDP entrantes et transmet les demandes au pod d'application approprié. Lorsque vous créez un cluster standard, {{site.data.keyword.containershort_notm}} crée automatiquement un équilibreur ALB à haute disponibilité pour votre cluster et lui affecte une route publique unique. La route publique est liée à une adresse IP publique portable allouée à votre compte d'infrastructure IBM Cloud (SoftLayer) lors de la création du cluster. Un équilibreur de charge ALB privé par défaut est également créé automatiquement, mais n'est pas activé automatiquement.</dd>
<dt>Ressource Ingress</dt>
<dd>Pour exposer une application à l'aide d'Ingress, vous devez créer un service Kubernetes pour votre application et enregistrer ce service auprès de l'équilibreur de charge ALB en définissant une ressource Ingress. La ressource Ingress est une ressource Kubernetes qui définit les règles de routage des demandes entrantes pour une application. Elle spécifie également le chemin d'accès à votre service d'application, qui est ajouté à la route publique pour composer une URL d'application unique, telle que `mycluster.us-south.containers.mybluemix.net/myapp`.</dd>
</dl>

Le diagramme suivant montre comment Ingress achemine la communication vers une application depuis Internet :

<img src="images/cs_ingress_planning.png" width="550" alt="Exposer une application dans {{site.data.keyword.containershort_notm}} en utilisant Ingress" style="width:550px; border-style: none"/>

1. Un utilisateur envoie une demande à votre application en accédant à l'URL de votre application. Il s'agit de l'URL publique de votre application exposée à laquelle est ajouté le chemin d'accès à la ressource Ingress, par exemple `mycluster.us-south.containers.mybluemix.net/myapp`.

2. Un service système DNS qui fait office d'équilibreur de charge global résout l'URL avec l'adresse IP publique portable de l'équilibreur de charge d'application (ALB) public par défaut dans le cluster.

3. `kube-proxy` achemine la demande vers le service ALB Kubernetes correspondant à l'application.

4. Le service Kubernetes achemine la demande à l'équilibreur de charge ALB.

5. L'équilibreur de charge ALB vérifie s'il existe une règle de routage pour le chemin `myapp` dans le cluster. Si une règle correspondante est trouvée, la demande est transmise en fonction des règles que vous avez définies dans la ressource Ingress au pod sur lequel est déployée l'application. Si plusieurs instances sont déployées dans le cluster, l'équilibreur de charge ALB équilibre les demandes entre les pods d'application.



**Remarque :** Ingress n'est disponible que pour les clusters standard et nécessite au moins deux noeuds worker dans le cluster pour garantir une haute disponibilité et l'application régulière de mises à jour. La configuration d'Ingress nécessite une [règle d'accès administrateur](cs_users.html#access_policies). Vérifiez votre [règle d'accès actuelle](cs_users.html#infra_access).

Pour sélectionner la configuration optimale pour Ingress, vous pouvez suivre l'arbre de décisions suivant :

<img usemap="#ingress_map" border="0" class="image" src="images/networkingdt-ingress.png" width="750px" alt="Cette image vous guide pour sélectionner la configuration optimale pour votre équilibreur de charge Ingress. Si elle ne s'affiche pas, ces informations sont cependant disponibles dans la documentation." style="width:750px;" />
<map name="ingress_map" id="ingress_map">
<area href="/docs/containers/cs_ingress.html#private_ingress_no_tls" alt="Exposition privée d'applications à l'aide d'un domaine personnalisé sans TLS" shape="rect" coords="25, 246, 187, 294"/>
<area href="/docs/containers/cs_ingress.html#private_ingress_tls" alt="Exposition privée d'applications à l'aide d'un domaine personnalisé avec TLS" shape="rect" coords="161, 337, 309, 385"/>
<area href="/docs/containers/cs_ingress.html#external_endpoint" alt="Exposition publique d'applications résidant hors de votre cluster à l'aide du domaine fourni par IBM en utilisant TLS" shape="rect" coords="313, 229, 466, 282"/>
<area href="/docs/containers/cs_ingress.html#custom_domain_cert" alt="Exposition publique d'applications à l'aide d'un domaine personnalisé avec TLS" shape="rect" coords="365, 415, 518, 468"/>
<area href="/docs/containers/cs_ingress.html#ibm_domain" alt="Exposition publique d'applications à l'aide du domaine fourni par IBM sans utiliser TLS" shape="rect" coords="414, 629, 569, 679"/>
<area href="/docs/containers/cs_ingress.html#ibm_domain_cert" alt="Exposition publique d'applications à l'aide du domaine fourni par IBM en utilisant TLS" shape="rect" coords="563, 711, 716, 764"/>
</map>

<br />


## Exposition d'applications au public
{: #ingress_expose_public}

Lorsque vous créez un cluster standard, un équilibreur de charge d'application (ALB) fourni par IBM est automatiquement activé et une adresse IP publique portable et une route publique lui sont affectées.
{:shortdesc}

Chaque application exposée au public via Ingress se voit affecter un chemin unique, lequel est rajouté à la route publique, de sorte que vous pouvez utiliser une URL unique pour accès public à votre application dans le cluster. Pour exposer votre application au public, vous pouvez configurer Ingress pour les scénarios suivants.

-   [Exposition d'applications au public à l'aide du domaine fourni par IBM sans utiliser TLS](#ibm_domain)
-   [Exposition d'applications au public à l'aide du domaine fourni par IBM en utilisant TLS](#ibm_domain_cert)
-   [Exposition d'applications au public à l'aide d'un domaine personnalisé en utilisant TLS](#custom_domain_cert)
-   [Exposition au public d'applications résidant hors de votre cluster à l'aide du domaine fourni par IBM ou d'un domaine personnalisé et en utilisant TLS](#external_endpoint)

### Exposition d'applications au public à l'aide du domaine fourni par IBM sans TLS
{: #ibm_domain}

Vous pouvez configurer l'équilibreur de charge ALB pour opérer sur le trafic réseau HTTP entrant vers les applications dans votre cluster et utiliser le domaine fourni par IBM pour accéder à vos applications depuis Internet.
{:shortdesc}

Avant de commencer :

-   Si ce n'est déjà fait, [créez un cluster standard](cs_clusters.html#clusters_ui).
-   [Ciblez avec votre interface CLI](cs_cli_install.html#cs_cli_configure) votre cluster pour exécuter des commandes `kubectl`.

Pour exposer une application à l'aide du domaine fourni par IBM :

1.  [Déployez votre application sur le cluster](cs_app.html#app_cli). Prenez soin d'ajouter un libellé à votre déploiement dans la section "metadata" de votre fichier de configuration, par exemple `app: code`. Ce libellé est nécessaire pour identifier tous les pods où s'exécute votre application afin de pouvoir inclure ces pods dans l'équilibrage de charge Ingress.

2.   Créez un service Kubernetes pour l'application que vous désirez exposer. Votre application doit être exposée par un service Kubernetes pour que l'équilibreur de charge ALB du cluster puisse l'inclure dans l'équilibrage de charge Ingress.
      1.  Ouvrez l'éditeur de votre choix et créez un fichier de configuration de service nommé, par exemple, `myalbservice.yaml`.
      2.  Définissez un service pour l'application que l'équilibreur de charge ALB exposera au public.

          ```
          apiVersion: v1
          kind: Service
          metadata:
            name: myalbservice
          spec:
            selector:
              <selector_key>: <selector_value>
            ports:
             - protocol: TCP
               port: 8080
          ```
          {: codeblock}

          <table>
          <caption>Description des composants du fichier du service ALB</caption>
          <thead>
          <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
          </thead>
          <tbody>
          <tr>
          <td><code>selector</code></td>
          <td>Entrez la paire clé de libellé (<em>&lt;selector_key&gt;</em>) et valeur (<em>&lt;selector_value&gt;</em>) que vous désirez utiliser pour cibler les pods dans lesquels s'exécute votre application. Pour cibler vos pods et les inclure dans l'équilibrage de charge du service, vérifiez que <em>&lt;selector_key&gt;</em> et <em>&lt;selector_value&gt;</em> sont identiques à la paire clé/valeur que vous avez utilisée dans la section <code>spec.template.metadata.labels</code> du fichier YAML de déploiement.</td>
           </tr>
           <tr>
           <td><code>port</code></td>
           <td>Port sur lequel le service est à l'écoute.</td>
           </tr>
           </tbody></table>
      3.  Sauvegardez vos modifications.
      4.  Créez le service dans votre cluster.

          ```
          kubectl apply -f myalbservice.yaml
          ```
          {: pre}
      5.  Répétez ces étapes pour chaque application que vous désirez exposer au public.

3. Extrayez les informations sur votre cluster pour identifier le domaine fourni par IBM. Remplacez _&lt;cluster_name_or_ID&gt;_ par le nom du cluster sur lequel l'application que vous désirez exposer au public est déployée.

    ```
    bx cs cluster-get <cluster_name_or_ID>
    ```
    {: pre}

    Exemple de sortie :

    ```
    Name:                   mycluster
    ID:                     18a61a63c6a94b658596ca93d087aad9
    State:                  normal
    Created:                2018-01-12T18:33:35+0000
    Location:               dal10
    Master URL:             https://169.xx.xxx.xxx:26268
    Ingress Subdomain:      mycluster-12345.us-south.containers.mybluemix.net
    Ingress Secret:         <tls_secret>
    Workers:                3
    Version:                1.8.11
    Owner Email:            owner@email.com
    Monitoring Dashboard:   <dashboard_URL>
    ```
    {: screen}

    Le domaine fourni par IBM est indiqué dans la zone **Ingress subdomain**.
4.  Créez une ressource Ingress. Les ressources Ingress définissent les règles de routage pour le service Kubernetes que vous avez créé pour votre application et sont utilisées par l'équilibreur de charge ALB pour acheminer le trafic réseau entrant au service. Vous devez utiliser une même ressource Ingress pour définir les règles de routage pour plusieurs applications si chaque application est exposée via un service Kubernetes dans le cluster.
    1.  Ouvrez l'éditeur de votre choix et créez un fichier de configuration Ingress nommé, par exemple, `myingressresource.yaml`.
    2.  Définissez dans votre fichier de configuration une ressource Ingress utilisant le domaine fourni par IBM pour acheminer le trafic réseau entrant aux services que vous avez créés auparavant.

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: myingressresource
        spec:
          rules:
          - host: <ibm_domain>
            http:
              paths:
              - path: /<service1_path>
                backend:
                  serviceName: <service1>
                  servicePort: 80
              - path: /<service2_path>
                backend:
                  serviceName: <service2>
                  servicePort: 80
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>host</code></td>
        <td>Remplacez <em>&lt;ibm_domain&gt;</em> par le nom du domaine <strong>Ingress subdomain</strong> fourni par IBM indiqué à l'étape précédente.

        </br></br>
        <strong>Remarque :</strong> n'utilisez pas le signe * pour votre hôte ou laissez vide la propriété de l'hôte afin d'éviter des échecs lors de la création Ingress.</td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>Remplacez <em>&lt;service1_path&gt;</em> par une barre oblique ou par le chemin unique sur lequel votre application est à l'écoute, afin que le trafic réseau puisse être acheminé vers l'application.

        </br>
        Pour chaque service Kubernetes, vous pouvez définir un chemin individuel qui s'ajoute au domaine fourni par IBM afin de constituer un chemin unique vers votre application ; par exemple <code>ibm_domain/service1_path</code>. Lorsque vous indiquez cette route dans un navigateur Web, le trafic réseau est acheminé vers l'équilibreur de charge ALB. L'équilibreur de charge ALB recherche le service associé et lui envoie le trafic réseau. Le service transfère ensuite le trafic aux pods sur lesquels s'exécute l'application. L'application doit être configurée pour être à l'écoute sur ce chemin afin de recevoir le trafic réseau entrant.

        </br></br>
        De nombreuses applications ne sont pas à l'écoute sur un chemin spécifique mais utilisent le chemin racine et un port spécifique. Dans ce cas, définissez le chemin racine sous la forme <code>/</code>, sans spécifier de chemin individuel pour votre application.
        </br>
        Exemples : <ul><li>Pour <code>http://ibm_domain/</code>, entrez <code>/</code> pour le chemin.</li><li>Pour <code>http://ibm_domain/service1_path</code>, entrez <code>/service1_path</code> pour le chemin.</li></ul>
        </br>
        <strong>Astuce :</strong> pour configurer Ingress pour qu'il soit à l'écoute sur un chemin différent de celui où l'application est à l'écoute, vous pouvez utiliser l'[annotation rewrite](cs_annotations.html#rewrite-path) pour définir le routage approprié vers votre application.</td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td>Remplacez <em>&lt;service1&gt;</em> par le nom du service que vous avez utilisé lors de la création du service Kubernetes pour votre application.</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>Port sur lequel votre service est à l'écoute. Utilisez le même port que celui que vous avez défini lors de la création du service Kubernetes pour votre application.</td>
        </tr>
        </tbody></table>

    3.  Créez la ressource Ingress pour votre cluster.

        ```
        kubectl apply -f myingressresource.yaml
        ```
        {: pre}
5.   Vérifiez que la création de la ressource Ingress a abouti.

      ```
      kubectl describe ingress myingressresource
      ```
      {: pre}

      1. Si les messages compris dans les événements indiquent une erreur dans la configuration de votre ressource, modifiez les valeurs du fichier de votre ressource et réappliquez le fichier correspondant à la ressource.

6.   Dans un navigateur Web, entrez l'URL du service d'application auquel accéder.

      ```
      https://<ibm_domain>/<service1_path>
      ```
      {: codeblock}


<br />


### Exposition d'applications au public à l'aide du domaine fourni par IBM en utilisant TLS
{: #ibm_domain_cert}

Vous pouvez configurer l'équilibreur de charge d'application (ALB) Ingress pour gérer les connexions TLS entrantes vers vos applications, déchiffrer le trafic réseau en utilisant le certificat TLS fourni par IBM et acheminer la demande déchiffrée aux applications exposées dans votre cluster.
{:shortdesc}

Avant de commencer :

-   Si ce n'est déjà fait, [créez un cluster standard](cs_clusters.html#clusters_ui).
-   [Ciblez avec votre interface CLI](cs_cli_install.html#cs_cli_configure) votre cluster pour exécuter des commandes `kubectl`.

Pour exposer une application à l'aide du domaine fourni par IBM avec TLS :

1.  [Déployez votre application sur le cluster](cs_app.html#app_cli). Prenez soin d'ajouter un libellé à votre déploiement dans la section "metadata" de votre fichier de configuration, par exemple `app: code`. Ce libellé est nécessaire pour identifier tous les pods où s'exécute votre application afin de pouvoir inclure ces pods dans l'équilibrage de charge Ingress.

2.   Créez un service Kubernetes pour l'application que vous désirez exposer. Votre application doit être exposée par un service Kubernetes pour que l'équilibreur de charge ALB du cluster puisse l'inclure dans l'équilibrage de charge Ingress.
      1.  Ouvrez l'éditeur de votre choix et créez un fichier de configuration de service nommé, par exemple, `myalbservice.yaml`.
      2.  Définissez un service pour l'application que l'équilibreur de charge ALB exposera au public.

          ```
          apiVersion: v1
          kind: Service
          metadata:
            name: myalbservice
          spec:
            selector:
              <selector_key>: <selector_value>
            ports:
             - protocol: TCP
               port: 8080
          ```
          {: codeblock}

          <table>
          <caption>Description des composants du fichier du service ALB</caption>
          <thead>
          <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
          </thead>
          <tbody>
          <tr>
          <td><code>selector</code></td>
          <td>Entrez la paire clé de libellé (<em>&lt;selector_key&gt;</em>) et valeur (<em>&lt;selector_value&gt;</em>) que vous désirez utiliser pour cibler les pods dans lesquels s'exécute votre application. Pour cibler vos pods et les inclure dans l'équilibrage de charge du service, vérifiez que <em>&lt;selector_key&gt;</em> et <em>&lt;selector_value&gt;</em> sont identiques à la paire clé/valeur que vous avez utilisée dans la section <code>spec.template.metadata.labels</code> du fichier YAML de déploiement.</td>
           </tr>
           <tr>
           <td><code>port</code></td>
           <td>Port sur lequel le service est à l'écoute.</td>
           </tr>
           </tbody></table>
      3.  Sauvegardez vos modifications.
      4.  Créez le service dans votre cluster.

          ```
          kubectl apply -f myalbservice.yaml
          ```
          {: pre}
      5.  Répétez ces étapes pour chaque application que vous désirez exposer au public.

3.   Affichez le domaine fourni par IBM et le certificat TLS. Remplacez _&lt;cluster_name_or_ID&gt;_ par le nom du cluster sur lequel l'application est déployée.

      ```
      bx cs cluster-get <cluster_name_or_ID>
      ```
      {: pre}

      Exemple de sortie :

      ```
      Name:                   mycluster
      ID:                     18a61a63c6a94b658596ca93d087aad9
      State:                  normal
      Created:                2018-01-12T18:33:35+0000
      Location:               dal10
      Master URL:             https://169.xx.xxx.xxx:26268
      Ingress Subdomain:      mycluster-12345.us-south.containers.mybluemix.net
      Ingress Secret:         <ibm_tls_secret>
      Workers:                3
      Version:                1.8.11
      Owner Email:            owner@email.com
      Monitoring Dashboard:   <dashboard_URL>
      ```
      {: screen}

      Le domaine fourni par IBM est visible dans la zone **Ingress subdomain** et le certificat fourni par IBM, dans la zone **Ingress secret**.

4.  Créez une ressource Ingress. Les ressources Ingress définissent les règles de routage pour le service Kubernetes que vous avez créé pour votre application et sont utilisées par l'équilibreur de charge ALB pour acheminer le trafic réseau entrant au service. Vous devez utiliser une même ressource Ingress pour définir les règles de routage pour plusieurs applications si chaque application est exposée via un service Kubernetes dans le cluster.
    1.  Ouvrez l'éditeur de votre choix et créez un fichier de configuration Ingress nommé, par exemple, `myingressresource.yaml`.
    2.  Définissez dans votre fichier de configuration une ressource Ingress utilisant le domaine fourni par IBM pour acheminer le trafic réseau entrant aux services que vous avez créés auparavant, et votre certificat personnalisé pour gérer la terminaison TLS.

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: myingressresource
        spec:
          tls:
          - hosts:
            - <ibm_domain>
            secretName: <ibm_tls_secret>
          rules:
          - host: <ibm_domain>
            http:
              paths:
              - path: /<service1_path>
                backend:
                  serviceName: <service1>
                  servicePort: 80
              - path: /<service2_path>
                backend:
                  serviceName: <service2>
                  servicePort: 80
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>tls/hosts</code></td>
        <td>Remplacez <em>&lt;ibm_domain&gt;</em> par le nom du domaine <strong>Ingress subdomain</strong> fourni par IBM indiqué à l'étape précédente. Ce domaine est configuré pour la terminaison TLS.

        </br></br>
        <strong>Remarque :</strong> n'utilisez pas le signe &ast; pour votre hôte ou laissez vide la propriété de l'hôte afin d'éviter des échecs lors de la création Ingress.</td>
        </tr>
        <tr>
        <td><code>tls/secretName</code></td>
        <td>Remplacez <em>&lt;<ibm_tls_secret>&gt;</em> par la valeur confidentielle <strong>Ingress secret</strong> fournie par IBM indiquée à l'étape précédente. Ce certificat gère la terminaison TLS.
        </tr>
        <tr>
        <td><code>host</code></td>
        <td>Remplacez <em>&lt;ibm_domain&gt;</em> par le nom du domaine <strong>Ingress subdomain</strong> fourni par IBM indiqué à l'étape précédente. Ce domaine est configuré pour la terminaison TLS.

        </br></br>
        <strong>Remarque :</strong> n'utilisez pas le signe &ast; pour votre hôte ou laissez vide la propriété de l'hôte afin d'éviter des échecs lors de la création Ingress.</td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>Remplacez <em>&lt;service1_path&gt;</em> par une barre oblique ou par le chemin unique sur lequel votre application est à l'écoute, afin que le trafic réseau puisse être acheminé vers l'application.

        </br>
        Pour chaque service Kubernetes, vous pouvez définir un chemin individuel qui s'ajoute au domaine fourni par IBM afin de constituer un chemin unique vers votre application. Lorsque vous indiquez cette route dans un navigateur Web, le trafic réseau est acheminé vers l'équilibreur de charge ALB. L'équilibreur de charge ALB recherche le service associé et lui envoie le trafic réseau. Le service transfère ensuite le trafic aux pods sur lesquels s'exécute l'application. L'application doit être configurée pour être à l'écoute sur ce chemin afin de recevoir le trafic réseau entrant.

        </br>
        De nombreuses applications ne sont pas à l'écoute sur un chemin spécifique mais utilisent le chemin racine et un port spécifique. Dans ce cas, définissez le chemin racine sous la forme
<code>/</code>, sans spécifier de chemin individuel pour votre application.

        </br>
        Exemples : <ul><li>Pour <code>http://ibm_domain/</code>, entrez <code>/</code> pour le chemin.</li><li>Pour <code>http://ibm_domain/service1_path</code>, entrez <code>/service1_path</code> pour le chemin.</li></ul>
        <strong>Astuce :</strong> pour configurer Ingress pour qu'il soit à l'écoute sur un chemin différent de celui où l'application est à l'écoute, vous pouvez utiliser l'[annotation rewrite](cs_annotations.html#rewrite-path) pour définir le routage approprié vers votre application.</td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td>Remplacez <em>&lt;service1&gt;</em> par le nom du service que vous avez utilisé lors de la création du service Kubernetes pour votre application.</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>Port sur lequel votre service est à l'écoute. Utilisez le même port que celui que vous avez défini lors de la création du service Kubernetes pour votre application.</td>
        </tr>
        </tbody></table>

    3.  Créez la ressource Ingress pour votre cluster.

        ```
        kubectl apply -f myingressresource.yaml
        ```
        {: pre}
5.   Vérifiez que la création de la ressource Ingress a abouti.

      ```
      kubectl describe ingress myingressresource
      ```
      {: pre}

      1. Si les messages compris dans les événements indiquent une erreur dans la configuration de votre ressource, modifiez les valeurs du fichier de votre ressource et réappliquez le fichier correspondant à la ressource.

6.   Dans un navigateur Web, entrez l'URL du service d'application auquel accéder.

      ```
      https://<ibm_domain>/<service1_path>
      ```
      {: codeblock}


<br />


### Exposition d'applications au public à l'aide d'un domaine personnalisé en utilisant TLS
{: #custom_domain_cert}

Vous pouvez configurer l'équilibreur de charge ALB afin d'acheminer le trafic réseau entrant vers les applications dans votre cluster et d'utiliser votre propre certificat TLS pour gérer la terminaison TLS, tout en utilisant votre domaine personnalisé au lieu du domaine fourni par IBM.
{:shortdesc}

Avant de commencer :

-   Si ce n'est déjà fait, [créez un cluster standard](cs_clusters.html#clusters_ui).
-   [Ciblez avec votre interface CLI](cs_cli_install.html#cs_cli_configure) votre cluster pour exécuter des commandes `kubectl`.

Pour exposer une application à l'aide d'un domaine personnalisé avec TLS :

1.  Créez un domaine personnalisé. Pour cela, travaillez avec votre fournisseur DNS (Domain Name Service) ou [{{site.data.keyword.Bluemix_notm}} ](/docs/infrastructure/dns/getting-started.html#getting-started-with-dns) afin d'enregistrer votre domaine personnalisé.
2.  Configurez votre domaine pour acheminer le trafic réseau entrant à l'équilibreur de charge ALB fourni par IBM. Sélectionnez l'une des options suivantes :
    -   Définir un alias pour votre domaine personnalisé en spécifiant le domaine fourni par IBM sous forme d'enregistrement de nom canonique (CNAME). Pour identifier le domaine Ingress fourni par IBM, exécutez `bx cs cluster-get <cluster_name>` et recherchez la zone **Ingress subdomain**.
    -   Mappez votre domaine personnalisé à l'adresse IP publique portable de l'équilibreur de charge ALB fourni par IBM en ajoutant l'adresse IP en tant qu'enregistrement. Pour identifier l'adresse IP publique portable de l'équilibreur de charge ALB, exécutez la commande `bx cs alb-get <public_alb_ID>`.
3.  Importez ou créez un certificat TLS et une valeur confidentielle de clé :
    * Si un certificat TLS que vous désirez utiliser est stocké dans {{site.data.keyword.cloudcerts_long_notm}}, vous pouvez importer sa valeur confidentielle associée dans votre cluster en exécutant la commande suivante :

      ```
      bx cs alb-cert-deploy --secret-name <secret_name> --cluster <cluster_name_or_ID> --cert-crn <certificate_crn>
      ```
      {: pre}

    * Si vous ne disposez pas de certificat TLS, procédez comme suit :
        1. Créez un certificat TLS et une clé pour votre domaine codés au format PEM.
        2. Créez une valeur confidentielle qui utilise le certificat et la clé TLS. Remplacez <em>&lt;tls_secret_name&gt;</em> par le nom de votre valeur confidentielle Kubernetes, <em>&lt;tls_key_filepath&gt;</em> par le chemin de votre fichier de clés TLS et <em>&lt;tls_cert_filepath&gt;</em> par le chemin d'accès à votre fichier de certificat TLS personnalisé.

            ```
            kubectl create secret tls <tls_secret_name> --key <tls_key_filepath> --cert <tls_cert_filepath>
            ```
            {: pre}
4.  [Déployez votre application sur le cluster](cs_app.html#app_cli). Prenez soin d'ajouter un libellé à votre déploiement dans la section "metadata" de votre fichier de configuration, par exemple `app: code`. Ce libellé est nécessaire pour identifier tous les pods où s'exécute votre application afin de pouvoir inclure ces pods dans l'équilibrage de charge Ingress.

5.   Créez un service Kubernetes pour l'application que vous désirez exposer. Votre application doit être exposée par un service Kubernetes pour que l'équilibreur de charge ALB du cluster puisse l'inclure dans l'équilibrage de charge Ingress.
      1.  Ouvrez l'éditeur de votre choix et créez un fichier de configuration de service nommé, par exemple, `myalbservice.yaml`.
      2.  Définissez un service pour l'application que l'équilibreur de charge ALB exposera au public.

          ```
          apiVersion: v1
          kind: Service
          metadata:
            name: myalbservice
          spec:
            selector:
              <selector_key>: <selector_value>
            ports:
             - protocol: TCP
               port: 8080
          ```
          {: codeblock}

          <table>
          <caption>Description des composants du fichier du service ALB</caption>
          <thead>
          <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
          </thead>
          <tbody>
          <tr>
          <td><code>selector</code></td>
          <td>Entrez la paire clé de libellé (<em>&lt;selector_key&gt;</em>) et valeur (<em>&lt;selector_value&gt;</em>) que vous désirez utiliser pour cibler les pods dans lesquels s'exécute votre application. Pour cibler vos pods et les inclure dans l'équilibrage de charge du service, vérifiez que <em>&lt;selector_key&gt;</em> et <em>&lt;selector_value&gt;</em> sont identiques à la paire clé/valeur que vous avez utilisée dans la section <code>spec.template.metadata.labels</code> du fichier YAML de déploiement.</td>
           </tr>
           <tr>
           <td><code>port</code></td>
           <td>Port sur lequel le service est à l'écoute.</td>
           </tr>
           </tbody></table>
      3.  Sauvegardez vos modifications.
      4.  Créez le service dans votre cluster.

          ```
          kubectl apply -f myalbservice.yaml
          ```
          {: pre}
      5.  Répétez ces étapes pour chaque application que vous désirez exposer au public.

6.  Créez une ressource Ingress. Les ressources Ingress définissent les règles de routage pour le service Kubernetes que vous avez créé pour votre application et sont utilisées par l'équilibreur de charge ALB pour acheminer le trafic réseau entrant au service. Vous devez utiliser une même ressource Ingress pour définir les règles de routage pour plusieurs applications si chaque application est exposée via un service Kubernetes dans le cluster.
    1.  Ouvrez l'éditeur de votre choix et créez un fichier de configuration Ingress nommé, par exemple, `myingressresource.yaml`.
    2.  Définissez dans votre fichier de configuration une ressource Ingress utilisant votre domaine personnalisé pour acheminer le trafic réseau entrant à vos services et votre certificat personnalisé pour gérer la terminaison TLS.

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: myingressresource
        spec:
          tls:
          - hosts:
            - <custom_domain>
            secretName: <tls_secret_name>
          rules:
          - host: <custom_domain>
            http:
              paths:
              - path: /<service1_path>
                backend:
                  serviceName: <service1>
                  servicePort: 80
              - path: /<service2_path>
                backend:
                  serviceName: <service2>
                  servicePort: 80
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>tls/hosts</code></td>
        <td>Remplacez <em>&lt;custom_domain&gt;</em> par le domaine personnalisé que vous désirez configurer pour la terminaison TLS.

        </br></br>
        <strong>Remarque :</strong> n'utilisez pas le signe &ast; pour votre hôte ou laissez vide la propriété de l'hôte afin d'éviter des échecs lors de la création Ingress.</td>
        </tr>
        <tr>
        <td><code>tls/secretName</code></td>
        <td>Remplacez <em>&lt;tls_secret_name&gt;</em> par le nom de la valeur confidentielle que vous avez créée auparavant qui contient votre certificat et votre clé TLS personnalisés. Si vous avez importé un certificat depuis {{site.data.keyword.cloudcerts_short}}, vous pouvez exécuter la commande <code>bx cs alb-cert-get --cluster <cluster_name_or_ID> --cert-crn <certificate_crn></code> pour examiner les valeurs confidentielles qui sont associées à un certificat TLS.
        </tr>
        <tr>
        <td><code>host</code></td>
        <td>Remplacez <em>&lt;custom_domain&gt;</em> par le domaine personnalisé que vous désirez configurer pour la terminaison TLS.

        </br></br>
        <strong>Remarque :</strong> n'utilisez pas le signe &ast; pour votre hôte ou laissez vide la propriété de l'hôte afin d'éviter des échecs lors de la création Ingress.
        </td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>Remplacez <em>&lt;service1_path&gt;</em> par une barre oblique ou par le chemin unique sur lequel votre application est à l'écoute, afin que le trafic réseau puisse être acheminé vers l'application.

        </br>
        Pour chaque service, vous pouvez définir un chemin individuel qui s'ajoute à votre domaine personnalisé afin de constituer un chemin unique vers votre application. Lorsque vous indiquez cette route dans un navigateur Web, le trafic réseau est acheminé vers l'équilibreur de charge ALB. L'équilibreur de charge ALB recherche le service associé et lui envoie le trafic réseau. Le service transfère ensuite le trafic aux pods sur lesquels s'exécute l'application. L'application doit être configurée pour être à l'écoute sur ce chemin afin de recevoir le trafic réseau entrant.

        </br>
        De nombreuses applications ne sont pas à l'écoute sur un chemin spécifique mais utilisent le chemin racine et un port spécifique. Dans ce cas, définissez le chemin racine sous la forme <code>/</code>, sans spécifier de chemin individuel pour votre application.

        </br></br>
        Exemples : <ul><li>Pour <code>https://custom_domain/</code>, entrez <code>/</code> pour le chemin.</li><li>Pour <code>https://custom_domain/service1_path</code>, entrez <code>/service1_path</code> pour le chemin.</li></ul>
        <strong>Astuce :</strong> pour configurer Ingress pour qu'il soit à l'écoute sur un chemin différent de celui où l'application est à l'écoute, vous pouvez utiliser l'[annotation rewrite](cs_annotations.html#rewrite-path) pour définir le routage approprié vers votre application.
        </td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td>Remplacez <em>&lt;service1&gt;</em> par le nom du service que vous avez utilisé lors de la création du service Kubernetes pour votre application.</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>Port sur lequel votre service est à l'écoute. Utilisez le même port que celui que vous avez défini lors de la création du service Kubernetes pour votre application.</td>
        </tr>
        </tbody></table>

    3.  Sauvegardez vos modifications.
    4.  Créez la ressource Ingress pour votre cluster.

        ```
        kubectl apply -f myingressresource.yaml
        ```
        {: pre}
7.   Vérifiez que la création de la ressource Ingress a abouti.

      ```
      kubectl describe ingress myingressresource
      ```
      {: pre}

      1. Si les messages compris dans les événements indiquent une erreur dans la configuration de votre ressource, modifiez les valeurs du fichier de votre ressource et réappliquez le fichier correspondant à la ressource.

8.   Dans un navigateur Web, entrez l'URL du service d'application auquel accéder.

      ```
      https://<custom_domain>/<service1_path>
      ```
      {: codeblock}


<br />


### Exposition au public d'applications résidant hors de votre cluster à l'aide du domaine fourni par IBM ou d'un domaine personnalisé et en utilisant TLS
{: #external_endpoint}

Vous pouvez configurer l'équilibreur de charge ALB pour inclure des applications situées hors de votre cluster. Les requêtes entrantes sur le domaine fourni par IBM, ou sur votre domaine personnalisé, sont acheminées automatiquement à l'application externe.
{:shortdesc}

Avant de commencer :

-   Si ce n'est déjà fait, [créez un cluster standard](cs_clusters.html#clusters_ui).
-   [Ciblez avec votre interface CLI](cs_cli_install.html#cs_cli_configure) votre cluster pour exécuter des commandes `kubectl`.
-   Vérifiez que l'application externe que vous désirez englober dans l'équilibrage de charge du cluster est accessible via une adresse IP publique.

Vous pouvez acheminer le trafic réseau entrant sur le domaine fourni par IBM vers des applications situées hors de votre cluster. Si vous désirez utiliser à la place un domaine personnalisé et un certificat TLS, remplacez le domaine fourni par IBM et le certificat TLS par vos [domaine personnalisé et certificat TLS](#custom_domain_cert).

1.  Créez un service Kubernetes pour votre cluster qui transmettra les demandes entrantes au noeud final externe que vous allez créer.
    1.  Ouvrez l'éditeur de votre choix et créez un fichier de configuration de service nommé, par exemple, `myexternalservice.yaml`.
    2.  Définissez le service ALB.

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: myexternalservice
        spec:
          ports:
           - protocol: TCP
             port: 8080
        ```
        {: codeblock}

        <table>
        <caption>Description des composants du fichier du service ALB</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>metadata/name</code></td>
        <td>Remplacez <em>&lt;myexternalservice&gt;</em> par le nom de votre service.</td>
        </tr>
        <tr>
        <td><code>port</code></td>
        <td>Port sur lequel le service est à l'écoute.</td>
        </tr></tbody></table>

    3.  Sauvegardez vos modifications.
    4.  Créez le service Kubernetes pour votre cluster.

        ```
        kubectl apply -f myexternalservice.yaml
        ```
        {: pre}
2.  Configurez un noeud final Kubernetes définissant l'emplacement externe de l'application que vous désirez inclure dans l'équilibrage de charge du cluster.
    1.  Ouvrez l'éditeur de votre choix et créez un fichier de configuration de noeud final nommé, par exemple, `myexternalendpoint.yaml`.
    2.  Définissez votre noeud final externe. Incluez toutes les adresses IP publiques et les ports pouvant être utilisés pour accéder à votre application externe.

        ```
        kind: Endpoints
        apiVersion: v1
        metadata:
          name: myexternalendpoint
        subsets:
          - addresses:
              - ip: <external_IP1>
              - ip: <external_IP2>
            ports:
              - port: <external_port>
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Remplacez <em>&lt;myexternalendpoint&gt;</em> par le nom du service Kubernetes que vous avez créé plus tôt.</td>
        </tr>
        <tr>
        <td><code>ip</code></td>
        <td>Remplacez <em>&lt;external_IP&gt;</em> par les adresses IP publiques permettant de se connecter à votre application externe.</td>
         </tr>
         <td><code>port</code></td>
         <td>Remplacez <em>&lt;external_port&gt;</em> par le port sur lequel votre application externe est à l'écoute.</td>
         </tbody></table>

    3.  Sauvegardez vos modifications.
    4.  Créez le noeud final Kubernetes pour votre cluster.

        ```
        kubectl apply -f myexternalendpoint.yaml
        ```
        {: pre}
3.   Affichez le domaine fourni par IBM et le certificat TLS. Remplacez _&lt;cluster_name_or_ID&gt;_ par le nom du cluster sur lequel l'application est déployée.

      ```
      bx cs cluster-get <cluster_name_or_ID>
      ```
      {: pre}

      Exemple de sortie :

      ```
      Name:                   mycluster
      ID:                     18a61a63c6a94b658596ca93d087aad9
      State:                  normal
      Created:                2018-01-12T18:33:35+0000
      Location:               dal10
      Master URL:             https://169.xx.xxx.xxx:26268
      Ingress Subdomain:      mycluster-12345.us-south.containers.mybluemix.net
      Ingress Secret:         <ibm_tls_secret>
      Workers:                3
      Version:                1.8.11
      Owner Email:            owner@email.com
      Monitoring Dashboard:   <dashboard_URL>
      ```
      {: screen}

      Le domaine fourni par IBM est visible dans la zone **Ingress subdomain** et le certificat fourni par IBM, dans la zone **Ingress secret**.

4.  Créez une ressource Ingress. Les ressources Ingress définissent les règles de routage pour le service Kubernetes que vous avez créé pour votre application et sont utilisées par l'équilibreur de charge ALB pour acheminer le trafic réseau entrant au service. Vous pouvez utiliser une même ressource Ingress pour définir des règles de routage pour plusieurs applications externes dans la mesure où chaque application est exposée avec son nom final externe via un service Kubernetes dans le cluster.
    1.  Ouvrez l'éditeur de votre choix et créez un fichier de configuration Ingress nommé, par exemple, `myexternalingress.yaml`.
    2.  Définissez dans votre fichier de configuration une ressource Ingress utilisant le domaine fourni par IBM et le certificat TLS pour acheminer le trafic réseau entrant à votre application externe en utilisant le noeud final externe défini auparavant.

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: myexternalingress
        spec:
          tls:
          - hosts:
            - <ibm_domain>
            secretName: <ibm_tls_secret>
          rules:
          - host: <ibm_domain>
            http:
              paths:
              - path: /<external_service1_path>
                backend:
                  serviceName: <external_service1>
                  servicePort: 80
              - path: /<external_service2_path>
                backend:
                  serviceName: <external_service2>
                  servicePort: 80
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>tls/hosts</code></td>
        <td>Remplacez <em>&lt;ibm_domain&gt;</em> par le nom du domaine <strong>Ingress subdomain</strong> fourni par IBM indiqué à l'étape précédente. Ce domaine est configuré pour la terminaison TLS.

        </br></br>
        <strong>Remarque :</strong> n'utilisez pas le signe &ast; pour votre hôte ou laissez vide la propriété de l'hôte afin d'éviter des échecs lors de la création Ingress.</td>
        </tr>
        <tr>
        <td><code>tls/secretName</code></td>
        <td>Remplacez <em>&lt;ibm_tls_secret&gt;</em> par la valeur confidentielle <strong>Ingress secret</strong> fournie par IBM indiquée à l'étape précédente. Ce certificat gère la terminaison TLS.</td>
        </tr>
        <tr>
        <td><code>rules/host</code></td>
        <td>Remplacez <em>&lt;ibm_domain&gt;</em> par le nom du domaine <strong>Ingress subdomain</strong> fourni par IBM indiqué à l'étape précédente. Ce domaine est configuré pour la terminaison TLS.

        </br></br>
        <strong>Remarque :</strong> n'utilisez pas le signe &ast; pour votre hôte ou laissez vide la propriété de l'hôte afin d'éviter des échecs lors de la création Ingress.</td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>Remplacez <em>&lt;external_service_path&gt;</em> par une barre oblique, ou par le chemin unique sur lequel votre application externe est à l'écoute, afin que ce trafic réseau puisse être transféré à l'application.

        </br>
        Pour chaque service, vous pouvez définir un chemin d'accès individuel qui s'ajoute au domaine fourni par IBM ou au domaine personnalisé de manière à créer un chemin unique vers votre application, par exemple <code>http://ibm_domain/external_service_path</code> ou <code>http://custom_domain/</code>. Lorsque vous indiquez cette route dans un navigateur Web, le trafic réseau est acheminé vers l'équilibreur de charge ALB. L'équilibreur de charge ALB recherche le service associé et lui envoie le trafic réseau. Le service achemine ensuite le trafic vers l'application externe. L'application doit être configurée pour être à l'écoute sur ce chemin afin de recevoir le trafic réseau entrant.

        </br></br>
        De nombreuses applications ne sont pas à l'écoute sur un chemin spécifique mais utilisent le chemin racine et un port spécifique. Dans ce cas, définissez le chemin racine sous la forme
<code>/</code>, sans spécifier de chemin individuel pour votre application.

        </br></br>
        <strong>Astuce :</strong> pour configurer Ingress pour qu'il soit à l'écoute sur un chemin différent de celui où l'application est à l'écoute, vous pouvez utiliser l'[annotation rewrite](cs_annotations.html#rewrite-path) pour définir le routage approprié vers votre application.</td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td>Remplacez <em>&lt;external_service&gt;</em> par le nom du service que vous avez utilisé lorsque vous avez créé le service Kubernetes pour votre application externe.</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>Port sur lequel votre service est à l'écoute.</td>
        </tr>
        </tbody></table>

    3.  Sauvegardez vos modifications.
    4.  Créez la ressource Ingress pour votre cluster.

        ```
        kubectl apply -f myexternalingress.yaml
        ```
        {: pre}
5.   Vérifiez que la création de la ressource Ingress a abouti.

      ```
      kubectl describe ingress myingressresource
      ```
      {: pre}

      1. Si les messages compris dans les événements indiquent une erreur dans la configuration de votre ressource, modifiez les valeurs du fichier de votre ressource et réappliquez le fichier correspondant à la ressource.

6.   Dans un navigateur Web, entrez l'URL du service d'application auquel accéder.

      ```
      https://<ibm_domain>/<service1_path>
      ```
      {: codeblock}


<br />


## Exposition d'applications à un réseau privé
{: #ingress_expose_private}

Lorsque vous créez un cluster standard, un équilibreur de charge d'application (ALB) fourni par IBM est créé et une adresse IP privée portable et une route privée lui sont affectées. Toutefois, l'équilibreur de charge ALB privé par défaut n'est pas automatiquement activé.
{:shortdesc}

Pour exposer votre application à des réseaux privés, commencez par [activer l'équilibreur de charge d'application privé par défaut](#private_ingress).

Vous pouvez ensuite configurer Ingress pour les scénarios suivants.
-   [Exposition privée d'applications à l'aide d'un domaine personnalisé sans utiliser TLS avec un fournisseur de DNS externe](#private_ingress_no_tls)
-   [Exposition privée d'applications à l'aide d'un domaine personnalisé en utilisant TLS avec un fournisseur de DNS externe](#private_ingress_tls)
-   [Exposition privée d'applications à l'aide d'un service DNS sur site](#private_ingress_onprem_dns)

### Activation de l'équilibreur de charge d'application privé par défaut
{: #private_ingress}

Avant d'utiliser l'équilibreur de charge ALB privé par défaut, vous devez l'activer avec l'adresse IP privée portable fournie par IBM, ou votre propre adresse IP privée portable.
{:shortdesc}

**Remarque** : si vous avez utilisé l'indicateur `--no-subnet` lors de la création du cluster, vous devez ajouter un sous-réseau privé portable ou un sous-réseau géré par l'utilisateur avant de pouvoir activer l'équilibreur de charge ALB privé. Pour plus d'informations, voir [Demande de sous-réseaux supplémentaires pour votre cluster](cs_subnets.html#request).

Avant de commencer :

-   Si ce n'est déjà fait, [créez un cluster standard](cs_clusters.html#clusters_ui).
-   [Ciblez votre interface de ligne de commande](cs_cli_install.html#cs_cli_configure) vers votre cluster.

Pour utiliser l'équilibreur de charge ALB privé avec l'adresse IP privée portable pré-affectée fournie par IBM :

1. Répertoriez les équilibreurs de charge ALB disponibles dans votre cluster pour identifier l'ID de l'ALB privé. Remplacez <em>&lt;cluser_name&gt;</em> par le nom du cluster sur lequel l'application que vous voulez exposer est déployée.

    ```
    bx cs albs --cluster <cluser_name>
    ```
    {: pre}

    La zone **Status** pour l'ALB privé indique _disabled_.
    ```
    ALB ID                                            Enabled   Status     Type      ALB IP
    private-cr6d779503319d419ea3b4ab171d12c3b8-alb1   false     disabled   private   -
    public-cr6d779503319d419ea3b4ab171d12c3b8-alb1    true      enabled    public    169.xx.xxx.xxx
    ```
    {: screen}

2. Activez l'équilibreur de charge ALB privé. Remplacez <em>&lt;private_ALB_ID&gt;</em> par l'ID de l'ALB privé indiqué dans la sortie de l'étape précédente.

   ```
   bx cs alb-configure --albID <private_ALB_ID> --enable
   ```
   {: pre}


Pour activer l'équilibreur de charge ALB privé à l'aide de votre propre adresse IP privée portable :

1. Configurez le sous-réseau géré par l'utilisateur de l'adresse IP que vous avez choisie pour acheminer le trafic sur le VLAN privé de votre cluster. Remplacez <em>&lt;cluster_name&gt;</em> par le nom ou l'ID du cluster sur lequel l'application que vous voulez exposer est déployée, <em>&lt;subnet_CIDR&gt;</em> par le CIDR de votre sous-réseau géré par l'utilisateur et <em>&lt;private_VLAN_ID&gt;</em> par un ID de VLAN privé disponible. Pour obtenir l'ID d'un VLAN privé disponible, exécutez la commande `bx cs vlans`.

   ```
   bx cs cluster-user-subnet-add <cluster_name> <subnet_CIDR> <private_VLAN_ID>
   ```
   {: pre}

2. Répertoriez les équilibreurs de charge ALB disponibles dans votre cluster pour identifier l'ID de l'ALB privé.

    ```
    bx cs albs --cluster <cluster_name>
    ```
    {: pre}

    La zone **Status** pour l'ALB privé indique _disabled_.
    ```
    ALB ID                                            Enabled   Status     Type      ALB IP
    private-cr6d779503319d419ea3b4ab171d12c3b8-alb1   false     disabled   private   -
    public-cr6d779503319d419ea3b4ab171d12c3b8-alb1    true      enabled    public    169.xx.xxx.xxx
    ```
    {: screen}

3. Activez l'équilibreur de charge ALB privé. Remplacez <em>&lt;private_ALB_ID&gt;</em> par l'ID de l'équilibreur de charge ALB privé indiqué dans la sortie de l'étape précédente et <em>&lt;user_IP&gt;</em> par l'adresse IP du sous-réseau géré par l'utilisateur que vous désirez utiliser.

   ```
   bx cs alb-configure --albID <private_ALB_ID> --enable --user-ip <user_IP>
   ```
   {: pre}

<br />


### Exposition privée d'applications à l'aide d'un domaine personnalisé sans utiliser TLS avec un fournisseur de DNS externe
{: #private_ingress_no_tls}

Vous pouvez configurer l'équilibreur de charge ALB privé afin d'acheminer le trafic réseau entrant aux applications dans votre cluster en utilisant un domaine personnalisé.
{:shortdesc}

Avant de commencer :
* [Activez l'équilibreur de charge d'application privé](#private_ingress).
* Si vous disposez de noeuds worker privés et que vous souhaitez utiliser un fournisseur de DNS externe, vous devez [configurer des noeuds de périphérie avec accès public](cs_edge.html#edge) et [configurer un dispositif de passerelle Vyatta ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://www.ibm.com/blogs/bluemix/2017/07/kubernetes-and-bluemix-container-based-workloads-part4/). Pour rester sur réseau privé uniquement, voir [Exposition privée d'applications à l'aide d'un service DNS sur site](#private_ingress_onprem_dns) à la place.

Pour une exposition privée d'application à l'aide d'un domaine personnalisé sans utiliser TLS avec un fournisseur de DNS externe :

1.  Créez un domaine personnalisé. Pour cela, travaillez avec votre fournisseur DNS (Domain Name Service) ou [{{site.data.keyword.Bluemix_notm}} ](/docs/infrastructure/dns/getting-started.html#getting-started-with-dns) afin d'enregistrer votre domaine personnalisé.
2.  Mappez votre domaine personnalisé à l'adresse IP privée portable de l'équilibreur de charge ALB privé fourni par IBM en ajoutant l'adresse IP en tant qu'enregistrement. Pour identifier l'adresse IP privée portable de l'équilibreur de charge ALB privé, exécutez la commande `bx cs albs --cluster <cluster_name>`.
3.  [Déployez votre application sur le cluster](cs_app.html#app_cli). Prenez soin d'ajouter un libellé à votre déploiement dans la section "metadata" de votre fichier de configuration, par exemple `app: code`. Ce libellé est nécessaire pour identifier tous les pods où s'exécute votre application afin de pouvoir inclure ces pods dans l'équilibrage de charge Ingress.

4.   Créez un service Kubernetes pour l'application que vous désirez exposer. Votre application doit être exposée par un service Kubernetes pour que l'équilibreur de charge ALB du cluster puisse l'inclure dans l'équilibrage de charge Ingress.
      1.  Ouvrez l'éditeur de votre choix et créez un fichier de configuration de service nommé, par exemple, `myalbservice.yaml`.
      2.  Définissez un service pour l'application que l'équilibreur de charge ALB exposera sur le réseau privé.

          ```
          apiVersion: v1
          kind: Service
          metadata:
            name: myalbservice
          spec:
            selector:
              <selector_key>: <selector_value>
            ports:
             - protocol: TCP
               port: 8080
          ```
          {: codeblock}

          <table>
          <caption>Description des composants du fichier du service ALB</caption>
          <thead>
          <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
          </thead>
          <tbody>
          <tr>
          <td><code>selector</code></td>
          <td>Entrez la paire clé de libellé (<em>&lt;selector_key&gt;</em>) et valeur (<em>&lt;selector_value&gt;</em>) que vous désirez utiliser pour cibler les pods dans lesquels s'exécute votre application. Pour cibler vos pods et les inclure dans l'équilibrage de charge du service, vérifiez que <em>&lt;selector_key&gt;</em> et <em>&lt;selector_value&gt;</em> sont identiques à la paire clé/valeur que vous avez utilisée dans la section <code>spec.template.metadata.labels</code> du fichier YAML de déploiement.</td>
           </tr>
           <tr>
           <td><code>port</code></td>
           <td>Port sur lequel le service est à l'écoute.</td>
           </tr>
           </tbody></table>
      3.  Sauvegardez vos modifications.
      4.  Créez le service dans votre cluster.

          ```
          kubectl apply -f myalbservice.yaml
          ```
          {: pre}
      5.  Répétez ces étapes pour chaque application que vous voulez exposer sur le réseau privé.

5.  Créez une ressource Ingress. Les ressources Ingress définissent les règles de routage pour le service Kubernetes que vous avez créé pour votre application et sont utilisées par l'équilibreur de charge ALB pour acheminer le trafic réseau entrant au service. Vous devez utiliser une même ressource Ingress pour définir les règles de routage pour plusieurs applications si chaque application est exposée via un service Kubernetes dans le cluster.
    1.  Ouvrez l'éditeur de votre choix et créez un fichier de configuration Ingress nommé, par exemple, `myingressresource.yaml`.
    2.  Définissez dans votre fichier de configuration une ressource Ingress utilisant votre domaine personnalisé pour acheminer le trafic réseau entrant vers vos services.

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: myingressresource
          annotations:
            ingress.bluemix.net/ALB-ID: "<private_ALB_ID>"
        spec:
          rules:
          - host: <custom_domain>
            http:
              paths:
              - path: /<service1_path>
                backend:
                  serviceName: <service1>
                  servicePort: 80
              - path: /<service2_path>
                backend:
                  serviceName: <service2>
                  servicePort: 80
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>ingress.bluemix.net/ALB-ID</code></td>
        <td>Remplacez <em>&lt;private_ALB_ID&gt;</em> par l'ID de votre équilibreur de charge ALB privé. Exécutez la commande <code>bx cs albs --cluster <my_cluster></code> pour trouver l'ID de l'ALB. Pour plus d'informations sur cette annotation Ingress, voir [Routage de l'équilibreur de charge d'application privé](cs_annotations.html#alb-id).</td>
        </tr>
        <td><code>host</code></td>
        <td>Remplacez <em>&lt;custom_domain&gt;</em> par votre domaine personnalisé.

        </br></br>
        <strong>Remarque :</strong> n'utilisez pas le signe &ast; pour votre hôte ou laissez vide la propriété de l'hôte afin d'éviter des échecs lors de la création Ingress.
        </td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>Remplacez <em>&lt;service1_path&gt;</em> par une barre oblique ou par le chemin unique sur lequel votre application est à l'écoute, afin que le trafic réseau puisse être acheminé vers l'application.

        </br>

        Pour chaque service, vous pouvez définir un chemin individuel qui s'ajoute à votre domaine personnalisé afin de constituer un chemin unique vers votre application. Lorsque vous indiquez cette route dans un navigateur Web, le trafic réseau est acheminé vers l'équilibreur de charge ALB. L'équilibreur de charge ALB recherche le service associé et lui envoie le trafic réseau. Le service transfère ensuite le trafic aux pods sur lesquels s'exécute l'application. L'application doit être configurée pour être à l'écoute sur ce chemin afin de recevoir le trafic réseau entrant.

        </br>
        De nombreuses applications ne sont pas à l'écoute sur un chemin spécifique mais utilisent le chemin racine et un port spécifique. Dans ce cas, définissez le chemin racine sous la forme <code>/</code>, sans spécifier de chemin individuel pour votre application.

        </br></br>
        Exemples : <ul><li>Pour <code>https://custom_domain/</code>, entrez <code>/</code> pour le chemin.</li><li>Pour <code>https://custom_domain/service1_path</code>, entrez <code>/service1_path</code> pour le chemin.</li></ul>
        <strong>Astuce :</strong> pour configurer Ingress pour qu'il soit à l'écoute sur un chemin différent de celui où l'application est à l'écoute, vous pouvez utiliser l'[annotation rewrite](cs_annotations.html#rewrite-path) pour définir le routage approprié vers votre application.
        </td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td>Remplacez <em>&lt;service1&gt;</em> par le nom du service que vous avez utilisé lors de la création du service Kubernetes pour votre application.</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>Port sur lequel votre service est à l'écoute. Utilisez le même port que celui que vous avez défini lors de la création du service Kubernetes pour votre application.</td>
        </tr>
        </tbody></table>

    3.  Sauvegardez vos modifications.
    4.  Créez la ressource Ingress pour votre cluster.

        ```
        kubectl apply -f myingressresource.yaml
        ```
        {: pre}
6.   Vérifiez que la création de la ressource Ingress a abouti.

      ```
      kubectl describe ingress myingressresource
      ```
      {: pre}

      1. Si les messages compris dans les événements indiquent une erreur dans la configuration de votre ressource, modifiez les valeurs du fichier de votre ressource et réappliquez le fichier correspondant à la ressource.

7.   Dans un navigateur Web, entrez l'URL du service d'application auquel accéder.

      ```
      https://<custom_domain>/<service1_path>
      ```
      {: codeblock}


<br />


### Exposition privée d'applications à l'aide d'un domaine personnalisé en utilisant TLS avec un fournisseur de DNS externe
{: #private_ingress_tls}

Vous pouvez utiliser des équilibreurs de charge ALB privés pour acheminer le trafic réseau entrant vers les applications dans votre cluster. Employez également votre propre certificat TLS pour gérer la terminaison TLS lorsque vous utilisez votre domaine personnalisé.
{:shortdesc}

Avant de commencer :
* [Activez l'équilibreur de charge d'application privé](#private_ingress).
* Si vous disposez de noeuds worker privés et que vous souhaitez utiliser un fournisseur de DNS externe, vous devez [configurer des noeuds de périphérie avec accès public](cs_edge.html#edge) et [configurer un dispositif de passerelle Vyatta ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://www.ibm.com/blogs/bluemix/2017/07/kubernetes-and-bluemix-container-based-workloads-part4/). Pour rester sur réseau privé uniquement, voir [Exposition privée d'applications à l'aide d'un service DNS sur site](#private_ingress_onprem_dns) à la place.

Pour une exposition privée d'application à l'aide d'un domaine personnalisé en utilisant TLS avec un fournisseur de DNS externe :

1.  Créez un domaine personnalisé. Pour cela, travaillez avec votre fournisseur DNS (Domain Name Service) ou [{{site.data.keyword.Bluemix_notm}} ](/docs/infrastructure/dns/getting-started.html#getting-started-with-dns) afin d'enregistrer votre domaine personnalisé.
2.  Mappez votre domaine personnalisé à l'adresse IP privée portable de l'équilibreur de charge ALB privé fourni par IBM en ajoutant l'adresse IP en tant qu'enregistrement. Pour identifier l'adresse IP privée portable de l'équilibreur de charge ALB privé, exécutez la commande `bx cs albs --cluster <cluster_name>`.
3.  Importez ou créez un certificat TLS et une valeur confidentielle de clé :
    * Si un certificat TLS que vous désirez utiliser est stocké dans {{site.data.keyword.cloudcerts_long_notm}}, vous pouvez importer sa valeur confidentielle associée dans votre cluster en exécutant la commande `bx cs alb-cert-deploy --secret-name <secret_name> --cluster <cluster_name_or_ID> --cert-crn <certificate_crn>`.
    * Si vous ne disposez pas de certificat TLS, procédez comme suit :
        1. Créez un certificat TLS et une clé pour votre domaine codés au format PEM.
        2. Créez une valeur confidentielle qui utilise le certificat et la clé TLS. Remplacez <em>&lt;tls_secret_name&gt;</em> par le nom de votre valeur confidentielle Kubernetes, <em>&lt;tls_key_filepath&gt;</em> par le chemin de votre fichier de clés TLS et <em>&lt;tls_cert_filepath&gt;</em> par le chemin d'accès à votre fichier de certificat TLS personnalisé.

            ```
            kubectl create secret tls <tls_secret_name> --key <tls_key_filepath> --cert <tls_cert_filepath>
            ```
            {: pre}
4.  [Déployez votre application sur le cluster](cs_app.html#app_cli). Prenez soin d'ajouter un libellé à votre déploiement dans la section "metadata" de votre fichier de configuration, par exemple `app: code`. Ce libellé est nécessaire pour identifier tous les pods où s'exécute votre application afin de pouvoir inclure ces pods dans l'équilibrage de charge Ingress.

5.   Créez un service Kubernetes pour l'application que vous désirez exposer. Votre application doit être exposée par un service Kubernetes pour que l'équilibreur de charge ALB du cluster puisse l'inclure dans l'équilibrage de charge Ingress.
      1.  Ouvrez l'éditeur de votre choix et créez un fichier de configuration de service nommé, par exemple, `myalbservice.yaml`.
      2.  Définissez un service pour l'application que l'équilibreur de charge ALB exposera sur le réseau privé.

          ```
          apiVersion: v1
          kind: Service
          metadata:
            name: myalbservice
          spec:
            selector:
              <selector_key>: <selector_value>
            ports:
             - protocol: TCP
               port: 8080
          ```
          {: codeblock}

          <table>
          <caption>Description des composants du fichier du service ALB</caption>
          <thead>
          <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
          </thead>
          <tbody>
          <tr>
          <td><code>selector</code></td>
          <td>Entrez la paire clé de libellé (<em>&lt;selector_key&gt;</em>) et valeur (<em>&lt;selector_value&gt;</em>) que vous désirez utiliser pour cibler les pods dans lesquels s'exécute votre application. Pour cibler vos pods et les inclure dans l'équilibrage de charge du service, vérifiez que <em>&lt;selector_key&gt;</em> et <em>&lt;selector_value&gt;</em> sont identiques à la paire clé/valeur que vous avez utilisée dans la section <code>spec.template.metadata.labels</code> du fichier YAML de déploiement.</td>
           </tr>
           <tr>
           <td><code>port</code></td>
           <td>Port sur lequel le service est à l'écoute.</td>
           </tr>
           </tbody></table>
      3.  Sauvegardez vos modifications.
      4.  Créez le service dans votre cluster.

          ```
          kubectl apply -f myalbservice.yaml
          ```
          {: pre}
      5.  Répétez ces étapes pour chaque application que vous voulez exposer sur le réseau privé.

6.  Créez une ressource Ingress. Les ressources Ingress définissent les règles de routage pour le service Kubernetes que vous avez créé pour votre application et sont utilisées par l'équilibreur de charge ALB pour acheminer le trafic réseau entrant au service. Vous devez utiliser une même ressource Ingress pour définir les règles de routage pour plusieurs applications si chaque application est exposée via un service Kubernetes dans le cluster.
    1.  Ouvrez l'éditeur de votre choix et créez un fichier de configuration Ingress nommé, par exemple, `myingressresource.yaml`.
    2.  Définissez dans votre fichier de configuration une ressource Ingress utilisant votre domaine personnalisé pour acheminer le trafic réseau entrant à vos services et votre certificat personnalisé pour gérer la terminaison TLS.

          ```
          apiVersion: extensions/v1beta1
          kind: Ingress
          metadata:
            name: myingressresource
            annotations:
              ingress.bluemix.net/ALB-ID: "<private_ALB_ID>"
          spec:
            tls:
            - hosts:
              - <custom_domain>
              secretName: <tls_secret_name>
            rules:
            - host: <custom_domain>
              http:
                paths:
                - path: /<service1_path>
                  backend:
                    serviceName: <service1>
                    servicePort: 80
                - path: /<service2_path>
                  backend:
                    serviceName: <service2>
                    servicePort: 80
           ```
           {: pre}

           <table>
          <thead>
          <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
          </thead>
          <tbody>
          <tr>
          <td><code>ingress.bluemix.net/ALB-ID</code></td>
          <td>Remplacez <em>&lt;private_ALB_ID&gt;</em> par l'ID de votre équilibreur de charge ALB privé. Exécutez la commande <code>bx cs albs --cluster <cluster_name></code> pour trouver l'ID de l'équilibreur de charge ALB. Pour plus d'informations sur cette annotation Ingress, voir [Routage de l'équilibreur de charge d'application privé (ALB-ID)](cs_annotations.html#alb-id).</td>
          </tr>
          <tr>
          <td><code>tls/hosts</code></td>
          <td>Remplacez <em>&lt;custom_domain&gt;</em> par le domaine personnalisé que vous désirez configurer pour la terminaison TLS.

          </br></br>
          <strong>Remarque :</strong> n'utilisez pas le signe &ast; pour votre hôte ou laissez vide la propriété de l'hôte afin d'éviter des échecs lors de la création Ingress.</td>
          </tr>
          <tr>
          <td><code>tls/secretName</code></td>
          <td>Remplacez <em>&lt;tls_secret_name&gt;</em> par le nom de la valeur confidentielle que vous avez créée auparavant et qui contient votre certificat et votre clé TLS personnalisés. Si vous avez importé un certificat depuis {{site.data.keyword.cloudcerts_short}}, vous pouvez exécuter la commande <code>bx cs alb-cert-get --cluster <cluster_name_or_ID> --cert-crn <certificate_crn></code> pour examiner les valeurs confidentielles qui sont associées à un certificat TLS.
          </tr>
          <tr>
          <td><code>host</code></td>
          <td>Remplacez <em>&lt;custom_domain&gt;</em> par le domaine personnalisé que vous désirez configurer pour la terminaison TLS.

          </br></br>
          <strong>Remarque :</strong> n'utilisez pas le signe &ast; pour votre hôte ou laissez vide la propriété de l'hôte afin d'éviter des échecs lors de la création Ingress.
          </td>
          </tr>
          <tr>
          <td><code>path</code></td>
          <td>Remplacez <em>&lt;service1_path&gt;</em> par une barre oblique ou par le chemin unique sur lequel votre application est à l'écoute, afin que le trafic réseau puisse être acheminé vers l'application.

          </br>
          Pour chaque service, vous pouvez définir un chemin individuel qui s'ajoute à votre domaine personnalisé afin de constituer un chemin unique vers votre application. Lorsque vous indiquez cette route dans un navigateur Web, le trafic réseau est acheminé vers l'équilibreur de charge ALB. Cet équilibreur de charge recherche le service associé et envoie le trafic réseau au service, ainsi qu'aux pods où l'application s'exécute en utilisant le même chemin. L'application doit être configurée pour être à l'écoute sur ce chemin afin de recevoir le trafic réseau entrant.

          </br>
          De nombreuses applications ne sont pas à l'écoute sur un chemin spécifique mais utilisent le chemin racine et un port spécifique. Dans ce cas, définissez le chemin racine sous la forme <code>/</code>, sans spécifier de chemin individuel pour votre application.

          </br></br>
          Exemples : <ul><li>Pour <code>https://custom_domain/</code>, entrez <code>/</code> pour le chemin.</li><li>Pour <code>https://custom_domain/service1_path</code>, entrez <code>/service1_path</code> pour le chemin.</li></ul>
          <strong>Astuce :</strong> pour configurer Ingress pour qu'il soit à l'écoute sur un chemin différent de celui où l'application est à l'écoute, vous pouvez utiliser l'[annotation rewrite](cs_annotations.html#rewrite-path) pour définir le routage approprié vers votre application.
          </td>
          </tr>
          <tr>
          <td><code>serviceName</code></td>
          <td>Remplacez <em>&lt;service1&gt;</em> par le nom du service que vous avez utilisé lors de la création du service Kubernetes pour votre application.</td>
          </tr>
          <tr>
          <td><code>servicePort</code></td>
          <td>Port sur lequel votre service est à l'écoute. Utilisez le même port que celui que vous avez défini lors de la création du service Kubernetes pour votre application.</td>
          </tr>
           </tbody></table>

    3.  Sauvegardez vos modifications.
    4.  Créez la ressource Ingress pour votre cluster.

        ```
        kubectl apply -f myingressresource.yaml
        ```
        {: pre}
7.   Vérifiez que la création de la ressource Ingress a abouti.

      ```
      kubectl describe ingress myingressresource
      ```
      {: pre}

      1. Si les messages compris dans les événements indiquent une erreur dans la configuration de votre ressource, modifiez les valeurs du fichier de votre ressource et réappliquez le fichier correspondant à la ressource.

8.   Dans un navigateur Web, entrez l'URL du service d'application auquel accéder.

      ```
      https://<custom_domain>/<service1_path>
      ```
      {: codeblock}


Pour obtenir un tutoriel complet sur la sécurisation d'une communication de microservice à microservice entre vos clusters en utilisant l'équilibreur de charge ALB privé avec TLS, consultez [cet article de blogue ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")]](https://medium.com/ibm-cloud/secure-microservice-to-microservice-communication-across-kubernetes-clusters-using-a-private-ecbe2a8d4fe2).

<br />


### Exposition privée d'applications à l'aide d'un service DNS sur site
{: #private_ingress_onprem_dns}

Vous pouvez configurer l'équilibreur de charge ALB privé afin d'acheminer le trafic réseau entrant aux applications dans votre cluster en utilisant un domaine personnalisé. Lorsque vous disposez de noeuds worker privés et que vous souhaitez rester uniquement sur un réseau privé, vous pouvez utiliser un service DNS sur site privé pour résoudre les demandes d'URL vers vos applications.
{:shortdesc}

1. [Activez l'équilibreur de charge d'application privé](#private_ingress).
2. Pour autoriser vos noeuds worker privés à communiquer avec le maître Kubernetes, [configurez la connectivité VPN](cs_vpn.html).
3. [Configurez votre service DNS ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/).
4. Créez un domaine personnalisé et enregistrez-le avec votre service DNS.
5.  Mappez votre domaine personnalisé à l'adresse IP privée portable de l'équilibreur de charge ALB privé fourni par IBM en ajoutant l'adresse IP en tant qu'enregistrement. Pour identifier l'adresse IP privée portable de l'équilibreur de charge ALB privé, exécutez la commande `bx cs albs --cluster <cluster_name>`.
6.  [Déployez votre application sur le cluster](cs_app.html#app_cli). Prenez soin d'ajouter un libellé à votre déploiement dans la section "metadata" de votre fichier de configuration, par exemple `app: code`. Ce libellé est nécessaire pour identifier tous les pods où s'exécute votre application afin de pouvoir inclure ces pods dans l'équilibrage de charge Ingress.

7.   Créez un service Kubernetes pour l'application que vous désirez exposer. Votre application doit être exposée par un service Kubernetes pour que l'équilibreur de charge ALB du cluster puisse l'inclure dans l'équilibrage de charge Ingress.
      1.  Ouvrez l'éditeur de votre choix et créez un fichier de configuration de service nommé, par exemple, `myalbservice.yaml`.
      2.  Définissez un service pour l'application que l'équilibreur de charge ALB exposera sur le réseau privé.

          ```
          apiVersion: v1
          kind: Service
          metadata:
            name: myalbservice
          spec:
            selector:
              <selector_key>: <selector_value>
            ports:
             - protocol: TCP
               port: 8080
          ```
          {: codeblock}

          <table>
          <caption>Description des composants du fichier du service ALB</caption>
          <thead>
          <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
          </thead>
          <tbody>
          <tr>
          <td><code>selector</code></td>
          <td>Entrez la paire clé de libellé (<em>&lt;selector_key&gt;</em>) et valeur (<em>&lt;selector_value&gt;</em>) que vous désirez utiliser pour cibler les pods dans lesquels s'exécute votre application. Pour cibler vos pods et les inclure dans l'équilibrage de charge du service, vérifiez que <em>&lt;selector_key&gt;</em> et <em>&lt;selector_value&gt;</em> sont identiques à la paire clé/valeur que vous avez utilisée dans la section <code>spec.template.metadata.labels</code> du fichier YAML de déploiement.</td>
           </tr>
           <tr>
           <td><code>port</code></td>
           <td>Port sur lequel le service est à l'écoute.</td>
           </tr>
           </tbody></table>
      3.  Sauvegardez vos modifications.
      4.  Créez le service dans votre cluster.

          ```
          kubectl apply -f myalbservice.yaml
          ```
          {: pre}
      5.  Répétez ces étapes pour chaque application que vous voulez exposer sur le réseau privé.

8.  Créez une ressource Ingress. Les ressources Ingress définissent les règles de routage pour le service Kubernetes que vous avez créé pour votre application et sont utilisées par l'équilibreur de charge ALB pour acheminer le trafic réseau entrant au service. Vous devez utiliser une même ressource Ingress pour définir les règles de routage pour plusieurs applications si chaque application est exposée via un service Kubernetes dans le cluster.
  1.  Ouvrez l'éditeur de votre choix et créez un fichier de configuration Ingress nommé, par exemple, `myingressresource.yaml`.
  2.  Définissez dans votre fichier de configuration une ressource Ingress utilisant votre domaine personnalisé pour acheminer le trafic réseau entrant vers vos services.

    **Remarque** : si vous ne voulez pas utiliser TLS, supprimez la section `tls` dans l'exemple suivant.

    ```
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: myingressresource
      annotations:
        ingress.bluemix.net/ALB-ID: "<private_ALB_ID>"
    spec:
      tls:
      - hosts:
        - <custom_domain>
        secretName: <tls_secret_name>
      rules:
      - host: <custom_domain>
        http:
          paths:
          - path: /<service1_path>
            backend:
              serviceName: <service1>
              servicePort: 80
          - path: /<service2_path>
            backend:
              serviceName: <service2>
              servicePort: 80
     ```
     {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code>ingress.bluemix.net/ALB-ID</code></td>
    <td>Remplacez <em>&lt;private_ALB_ID&gt;</em> par l'ID de votre équilibreur de charge ALB privé. Exécutez la commande <code>bx cs albs --cluster <my_cluster></code> pour trouver l'ID de l'ALB. Pour plus d'informations sur cette annotation Ingress, voir [Routage de l'équilibreur de charge d'application privé (ALB-ID)](cs_annotations.html#alb-id).</td>
    </tr>
    <tr>
    <td><code>tls/hosts</code></td>
    <td>Si vous utilisez la section `tls`, remplacez <em>&lt;custom_domain&gt;</em> par le domaine personnalisé que vous voulez configurer pour la terminaison TLS.
    </br></br>
    <strong>Remarque :</strong> n'utilisez pas le signe &ast; pour votre hôte ou laissez vide la propriété de l'hôte afin d'éviter des échecs lors de la création Ingress. </td>
    </tr>
    <tr>
    <td><code>tls/secretName</code></td>
    <td>Si vous utilisez la section `tls`, remplacez <em>&lt;tls_secret_name&gt;</em> par le nom de la valeur confidentielle que vous avez créée auparavant et qui contient votre certificat et votre clé TLS personnalisés. Si vous avez importé un certificat depuis {{site.data.keyword.cloudcerts_short}}, vous pouvez exécuter la commande <code>bx cs alb-cert-get --cluster <cluster_name_or_ID> --cert-crn <certificate_crn></code> pour examiner les valeurs confidentielles qui sont associées à un certificat TLS.
    </tr>
    <tr>
    <td><code>host</code></td>
    <td>Remplacez <em>&lt;custom_domain&gt;</em> par le domaine personnalisé que vous désirer configurer pour la terminaison TLS.
    </br></br>
    <strong>Remarque :</strong> n'utilisez pas le signe &ast; pour votre hôte ou laissez vide la propriété de l'hôte afin d'éviter des échecs lors de la création Ingress.
    </td>
    </tr>
    <tr>
    <td><code>path</code></td>
    <td>Remplacez <em>&lt;service1_path&gt;</em> par une barre oblique ou par le chemin unique sur lequel votre application est à l'écoute, afin que le trafic réseau puisse être acheminé vers l'application.
    </br>
    Pour chaque service, vous pouvez définir un chemin individuel qui s'ajoute à votre domaine personnalisé afin de constituer un chemin unique vers votre application. Lorsque vous indiquez cette route dans un navigateur Web, le trafic réseau est acheminé vers l'équilibreur de charge ALB. Cet équilibreur de charge recherche le service associé et envoie le trafic réseau au service, ainsi qu'aux pods où l'application s'exécute en utilisant le même chemin. L'application doit être configurée pour être à l'écoute sur ce chemin afin de recevoir le trafic réseau entrant.</br>
    De nombreuses applications ne sont pas à l'écoute sur un chemin spécifique mais utilisent le chemin racine et un port spécifique. Dans ce cas, définissez le chemin racine sous la forme <code>/</code>, sans spécifier de chemin individuel pour votre application.
    </br></br>
    Exemples : <ul><li>Pour <code>https://custom_domain/</code>, entrez <code>/</code> pour le chemin.</li><li>Pour <code>https://custom_domain/service1_path</code>, entrez <code>/service1_path</code> pour le chemin.</li></ul>
    <strong>Astuce :</strong> pour configurer Ingress pour qu'il soit à l'écoute sur un chemin différent de celui où l'application est à l'écoute, vous pouvez utiliser l'[annotation rewrite](cs_annotations.html#rewrite-path) pour définir le routage approprié vers votre application.
    </td>
    </tr>
    <tr>
    <td><code>serviceName</code></td>
    <td>Remplacez <em>&lt;service1&gt;</em> par le nom du service que vous avez utilisé lors de la création du service Kubernetes pour votre application.</td>
    </tr>
    <tr>
    <td><code>servicePort</code></td>
    <td>Port sur lequel votre service est à l'écoute. Utilisez le même port que celui que vous avez défini lors de la création du service Kubernetes pour votre application.</td>
    </tr>
    </tbody></table>

  3.  Sauvegardez vos modifications.
  4.  Créez la ressource Ingress pour votre cluster.

      ```
      kubectl apply -f myingressresource.yaml
      ```
      {: pre}
9.   Vérifiez que la création de la ressource Ingress a abouti.

      ```
      kubectl describe ingress myingressresource
      ```
      {: pre}

      1. Si les messages compris dans les événements indiquent une erreur dans la configuration de votre ressource, modifiez les valeurs du fichier de votre ressource et réappliquez le fichier correspondant à la ressource.

10.   Dans un navigateur Web, entrez l'URL du service d'application auquel accéder.

      ```
      https://<custom_domain>/<service1_path>
      ```
      {: codeblock}


<br />





## Configurations facultatives de l'équilibreur de charge d'application
{: #configure_alb}

Vous pouvez configurer plus encore un équilibreur de charge d'application à l'aide des options suivantes.

-   [Ouverture de ports dans l'équilibreur de charge d'application Ingress](#opening_ingress_ports)
-   [Configuration de protocoles et de chiffrements SSL au niveau HTTP](#ssl_protocols_ciphers)
-   [Personnalisation du format des journaux Ingress](#ingress_log_format)
-   [Personnalisation de votre équilibreur de charge d'application à l'aide d'annotations](cs_annotations.html)
{: #ingress_annotation}


### Ouverture de ports dans l'équilibreur de charge d'application Ingress
{: #opening_ingress_ports}

Par défaut, seuls les ports 80 et 443 sont exposés dans l'équilibreur de charge ALB Ingress. Pour exposer d'autres ports, vous pouvez éditer la ressource configmap `ibm-cloud-provider-ingress-cm`.
{:shortdesc}

1. Créez et ouvrez une version locale du fichier de configuration pour la ressource configmap `ibm-cloud-provider-ingress-cm`.

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Ajoutez une section <code>data</code> et spécifiez les ports publics `80`, `443`, ainsi que tous les autres ports que vous voulez exposer, séparés par un point virgule (;).

    **Remarque** : Lorsque vous spécifiez des ports, 80 et 443 doivent également être inclus pour rester ouverts. Tout port non spécifié est fermé.

    ```
    apiVersion: v1
 data:
   public-ports: "80;443;<port3>"
 kind: ConfigMap
 metadata:
   name: ibm-cloud-provider-ingress-cm
   namespace: kube-system
    ```
    {: codeblock}

    Exemple :
    ```
    apiVersion: v1
 data:
   public-ports: "80;443;9443"
 kind: ConfigMap
 metadata:
   name: ibm-cloud-provider-ingress-cm
   namespace: kube-system
    ```
    {: screen}

3. Sauvegardez le fichier de configuration.

4. Vérifiez que les modifications apportées à configmap ont été appliquées.

 ```
 kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
 ```
 {: pre}

 Sortie :
 ```
 Name:        ibm-cloud-provider-ingress-cm
 Namespace:    kube-system
 Labels:        <none>
 Annotations:    <none>

 Data
 ====

  public-ports: "80;443;9443"
 ```
 {: screen}

Pour plus d'informations sur les ressources configmap, voir la [documentation Kubernetes](https://kubernetes-v1-4.github.io/docs/user-guide/configmap/).

### Configuration de protocoles et de chiffrements SSL au niveau HTTP
{: #ssl_protocols_ciphers}

Activez les protocoles et chiffrements SSL au niveau HTTP global en éditant configmap `ibm-cloud-provider-ingress-cm`.
{:shortdesc}



**Remarque** : lorsque vous indiquez les protocoles activés pour tous les hôtes, les paramètres TLSv1.1 et TLSv1.2 (1.1.13, 1.0.12) fonctionnent uniquement avec l'utilisation d'OpenSSL 1.0.1 ou version supérieure. Le paramètre TLSv1.3 (1.13.0) fonctionne uniquement avec l'utilisation d'OpenSSL 1.1.1 généré avec le support TLSv1.3.

Pour éditer le fichier configmap pour activer les chiffrements et protocoles SSL :

1. Créez et ouvrez une version locale du fichier de configuration pour la ressource configmap `ibm-cloud-provider-ingress-cm`.

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Ajoutez les chiffrements et protocoles SSL. Configurez les chiffrements en fonction du [format de liste de chiffrements de la bibliothèque OpenSSL ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://www.openssl.org/docs/man1.0.2/apps/ciphers.html).

   ```
   apiVersion: v1
 data:
   ssl-protocols: "TLSv1 TLSv1.1 TLSv1.2"
   ssl-ciphers: "HIGH:!aNULL:!MD5"
 kind: ConfigMap
 metadata:
   name: ibm-cloud-provider-ingress-cm
   namespace: kube-system
   ```
   {: codeblock}

3. Sauvegardez le fichier de configuration.

4. Vérifiez que les modifications apportées à configmap ont été appliquées.

   ```
   kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
   ```
   {: pre}

   Sortie :
   ```
   Name:        ibm-cloud-provider-ingress-cm
 Namespace:    kube-system
 Labels:        <none>
 Annotations:    <none>

   Data
 ====

    ssl-protocols: "TLSv1 TLSv1.1 TLSv1.2"
  ssl-ciphers: "HIGH:!aNULL:!MD5"
   ```
   {: screen}

### Personnalisation du contenu et du format des journaux Ingress
{: #ingress_log_format}

Vous pouvez personnaliser le contenu et le format des journaux collectés par l'équilibreur de charge d'application (ALB) Ingress.
{:shortdesc}

Par défaut, les journaux Ingress sont au format JSON et affichent des zones de journal communes. Vous pouvez toutefois créer un format personnalisé pour les journaux. Pour choisir les composants de journal qui seront transférés et leur mode d'organisation dans la sortie du journal :

1. Créez et ouvrez une version locale du fichier de configuration pour la ressource configmap `ibm-cloud-provider-ingress-cm`.

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Ajoutez une section <code>data</code>. Ajoutez la zone `log-format` et, éventuellement, la zone `log-format-escape-json`.

    ```
    apiVersion: v1
    data:
      log-format: '{<key1>: <log_variable1>, <key2>: <log_variable2>, <key3>: <log_variable3>}'
      log-format-escape-json: "true"
    kind: ConfigMap
    metadata:
      name: ibm-cloud-provider-ingress-cm
      namespace: kube-system
    ```
    {: pre}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description de la configuration du format de journal (log-format)</th>
    </thead>
    <tbody>
    <tr>
    <td><code>log-format</code></td>
    <td>Remplacez <code>&lt;key&gt;</code> par le nom du composant de journal et <code>&lt;log_variable&gt;</code> par une variable du composant de journal que vous voulez collecter dans les entrées de journal. Vous pouvez inclure le texte et la ponctuation que vous souhaitez dans l'entrée de journal, par exemple des guillemets autour des valeurs de chaîne et des virgules pour séparer les composants de journal. Par exemple, si vous formatez un composant ainsi : <code>request: "$request",</code>, vous obtenez ceci dans une entrée de journal : <code>request: "GET / HTTP/1.1",</code> . Pour obtenir la liste de toutes les variables que vous pouvez utiliser, voir le document <a href="http://nginx.org/en/docs/varindex.html">Nginx variable index</a>.<br><br>Pour consigner un en-tête supplémentaire, par exemple, <em>x-custom-ID</em>, ajoutez la paire clé-valeur suivante au contenu de journal personnalisé : <br><pre class="pre"><code>customID: $http_x_custom_id</code></pre> <br>Notez que les traits d'union (<code>-</code>) sont convertis en traits de soulignement (<code>_</code>) et que <code>$http_</code> doit être ajouté en préfixe au nom d'en-tête personnalisé.</td>
    </tr>
    <tr>
    <td><code>log-format-escape-json</code></td>
    <td>Facultatif : par défaut, les journaux sont générés en format texte. Pour générer les fichiers au format JSON, ajoutez la zone <code>log-format-escape-json</code> et utilisez la valeur <code>true</code>.</td>
    </tr>
    </tbody></table>
    </dd>
    </dl>

    Par exemple, votre format de journal peut contenir les variables suivantes :
    ```
    apiVersion: v1
    data:
      log-format: '{remote_address: $remote_addr, remote_user: "$remote_user",
                    time_date: [$time_local], request: "$request",
                    status: $status, http_referer: "$http_referer",
                    http_user_agent: "$http_user_agent",
                    request_id: $request_id}'
    kind: ConfigMap
    metadata:
      name: ibm-cloud-provider-ingress-cm
      namespace: kube-system
    ```
    {: screen}

    Une entrée de journal correspondant à ce format aura l'aspect suivant :
    ```
    remote_address: 127.0.0.1, remote_user: "dbmanager", time_date: [30/Mar/2018:18:52:17 +0000], request: "GET / HTTP/1.1", status: 401, http_referer: "-", http_user_agent: "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:47.0) Gecko/20100101 Firefox/47.0", request_id: a02b2dea9cf06344a25611c1d7ad72db
    ```
    {: screen}

    Si vous souhaitez créer un format de journal personnalisé en fonction du format par défaut des journaux de l'équilibreur de charge d'application (ALB), vous pouvez ajouter la section suivante à votre fichier configmap et la modifier selon vos besoins :
    ```
    apiVersion: v1
    data:
      log-format: '{"time_date": "$time_iso8601", "client": "$remote_addr",
                    "host": "$http_host", "scheme": "$scheme",
                    "request_method": "$request_method", "request_uri": "$uri",
                    "request_id": "$request_id", "status": $status,
                    "upstream_addr": "$upstream_addr", "upstream_status":
                    $upstream_status, "request_time": $request_time,
                    "upstream_response_time": $upstream_response_time,
                    "upstream_connect_time": $upstream_connect_time,
                    "upstream_header_time": $upstream_header_time}'
      log-format-escape-json: "true"
    kind: ConfigMap
    metadata:
      name: ibm-cloud-provider-ingress-cm
      namespace: kube-system
    ```
    {: codeblock}

4. Sauvegardez le fichier de configuration.

5. Vérifiez que les modifications apportées à configmap ont été appliquées.

 ```
 kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
 ```
 {: pre}

 Exemple de sortie :
 ```
 Name:        ibm-cloud-provider-ingress-cm
 Namespace:    kube-system
 Labels:        <none>
 Annotations:    <none>

 Data
 ====

  log-format: '{remote_address: $remote_addr, remote_user: "$remote_user", time_date: [$time_local], request: "$request", status: $status, http_referer: "$http_referer", http_user_agent: "$http_user_agent", request_id: $request_id}'
  log-format-escape-json: "true"
 ```
 {: screen}

4. Pour afficher les journaux de l'équilibreur de charge ALB, [créez une configuration de consignation pour le service Ingress](cs_health.html#logging) dans votre cluster.

<br />




