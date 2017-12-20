---

copyright:
  years: 2014, 2017
lastupdated: "2017-11-28"

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
{: #cs_apps}

Vous pouvez utiliser des techniques Kubernetes pour déployer des applications et faire en sorte qu'elles soient toujours opérationnelles. Par exemple, vous pouvez effectuer des mises à jour et des rétromigrations tournantes sans générer de temps d'indisponibilité pour vos utilisateurs.
{:shortdesc}

Découvrez les étapes générales de déploiement d'applications en cliquant sur une zone de l'image suivante.

<img usemap="#d62e18" border="0" class="image" id="basic_deployment_process" src="images/basic_deployment_process.png" width="780" style="width:780px;"/>
<map name="d62e18" id="d62e18">
<area href="cs_cli_install.html" target="_blank" alt="Installation des interfaces CLI." title="Installation des interfaces CLI." shape="rect" coords="30, 69, 179, 209" />
<area href="https://kubernetes.io/docs/concepts/configuration/overview/" target="_blank" alt="Création d'un fichier de configuration pour votre application. Consultez les pratiques Kubernetes recommandées." title="Création d'un fichier de configuration pour votre application. Consultez les pratiques Kubernetes recommandées." shape="rect" coords="254, 64, 486, 231" />
<area href="#cs_apps_cli" target="_blank" alt="Option 1 : Exécuter des fichiers de configuration depuis l'interface CLI de Kubernetes." title="Option 1 : Exécuter des fichiers de configuration depuis l'interface CLI de Kubernetes." shape="rect" coords="544, 67, 730, 124" />
<area href="#cs_cli_dashboard" target="_blank" alt="Option 2 : Démarrer le tableau de bord Kubernetes en local et exécuter des fichiers de configuration." title="Option 2 : Démarrer le tableau de bord Kubernetes en local et exécuter des fichiers de configuration." shape="rect" coords="544, 141, 728, 204" />
</map>


<br />


## Lancement du tableau de bord Kubernetes
{: #cs_cli_dashboard}

Ouvrez un tableau de bord Kubernetes sur votre système local pour consulter des informations sur un cluster et ses noeuds d'agent.
{:shortdesc}

Avant de commencer, [ciblez avec votre interface de ligne de commande](cs_cli_install.html#cs_cli_configure) votre cluster. Cette tâche requiert d'utiliser la [règle d'accès administrateur](cs_cluster.html#access_ov). Vérifiez votre [règle d'accès](cs_cluster.html#view_access) actuelle.

Vous pouvez utiliser le port par défaut ou définir votre propre port pour lancer le tableau de bord Kubernetes d'un cluster.

1.  Pour les clusters avec un maître Kubernetes version 1.7.4 ou antérieure :

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

    1.  Téléchargez vos données d'identification.

        ```
        bx cs cluster-config <cluster_name>
        ```
        {: codeblock}

    2.  Affichez les données d'identification de cluster que vous avez téléchargées. Utilisez le chemin d'accès au fichier indiqué dans l'exportation à l'étape précédente.

        Pour macOS ou Linux :

        ```
        cat <filepath_to_cluster_credentials>
        ```
        {: codeblock}

        Pour Windows :

        ```
        type <filepath_to_cluster_credentials>
        ```
        {: codeblock}

    3.  Copiez le jeton dans la zone **id-token**.

    4.  Affectez le numéro de port par défaut au proxy.

        ```
        kubectl proxy
        ```
        {: pre}

        La sortie de l'interface de ligne de commande se présente comme suit :

        ```
        Starting to serve on 127.0.0.1:8001
        ```
        {: screen}

    6.  Connectez-vous au tableau de bord.

        1.  Copiez l'adresse URL suivante dans votre navigateur.

            ```
            http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/
            ```
            {: codeblock}

        2.  Sur la page de connexion, sélectionnez la méthode d'authentification **Jeton**.

        3.  Ensuite, collez la valeur de la zone **id-token** dans la zone **Token**, puis cliquez sur **Se connecter**.

[Ensuite, vous pouvez exécuter un fichier de configuration à partir du tableau de bord.](#cs_apps_ui)

Lorsque vous avez fini d'examiner le tableau de bord Kubernetes, utilisez les touches `CTRL+C` pour quitter la commande
`proxy`. Après avoir quitté, le tableau de bord Kubernetes n'est plus disponible. Exécutez la commande `proxy` pour redémarrer le tableau de bord Kubernetes.



<br />


## Création de valeurs confidentielles
{: #secrets}

Les valeurs confidentielles Kubernetes permettent de stocker de manière
sécurisée des informations sensibles, comme les noms de utilisateurs, leur mots de passe ou leur clés.


<table>
<caption>Table. Fichiers devant être stockés dans des valeurs confidentielles par tâche</caption>
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
bx cs cluster-get &gt;CLUSTER-NAME&lt; | grep "Ingress secret"
</pre>
</p>
Pour créer à la place votre propre valeur confidentielle, exécutez la procédure décrite dans cette rubrique.</td>
<td>Certificat et clé de serveur : <code>server.crt</code> et <code>server.key</code></td>
<tr>
<td>Création de l'annotation mutual-authentication .</td>
<td>Certificat d'autorité de certification : <code>ca.crt</code></td>
</tr>
</tbody>
</table>

Pour plus d'informations sur les éléments que vous pouvez stocker dans les valeurs confidentielles, voir la [documentation Kubernetes](https://kubernetes.io/docs/concepts/configuration/secret/).



Pour créer une valeur confidentielle avec un certificat :

1. Procurez-vous le certificat d'autorité de certification et la clé auprès de votre fournisseur de certificat. Si vous disposez de votre propre domaine, achetez un certificat TLS officiel pour votre domaine. Pour des tests, vous pouvez générer un certificat autosigné.

 Important : Assurez-vous que la valeur [CN](https://support.dnsimple.com/articles/what-is-common-name/) est différente pour chaque certificat.

 Le certificat et la clé du client doivent être vérifiés jusqu'au niveau du certificat racine accrédité qui, dans ce cas, est le certificat de l'autorité de certification. Exemple :

 ```
 Client Certificate: issued by Intermediate Certificate
 Intermediate Certificate: issued by Root Certificate
 Root Certificate: issued by itself
 ```
 {: codeblock}

2. Créez le certificat en tant que valeur confidentielle Kubernetes.

 ```
 kubectl create secret generic <secretName> --from-file=<cert_file>=<cert_file>
 ```
 {: pre}

 Exemples :
 - Connexion TLS :

 ```
 kubectl create secret tls <secretName> --from-file=tls.crt=server.crt --from-file=tls.key=server.key
 ```
 {: pre}

 - Annotation d'authentification mutuelle :

 ```
 kubectl create secret generic <secretName> --from-file=ca.crt=ca.crt
 ```
 {: pre}

<br />



## Autorisation d'accès public aux applications
{: #cs_apps_public}

Pour rendre une application accessible au public sur Internet, vous devez mettre à jour votre fichier de configuration avant de déployer l'application dans un cluster.
{:shortdesc}

Les méthodes pour rendre votre application accessible depuis Internet diffèrent selon que vous avez créé un cluster léger ou standard.

<dl>
<dt><a href="#cs_apps_public_nodeport" target="_blank">Service NodePort</a> (clusters légers et standard)</dt>
<dd>Vous pouvez exposer un port public sur chaque noeud worker et utiliser l'adresse IP publique de n'importe quel noeud worker pour accès public à votre service dans le cluster. L'adresse IP publique du noeud worker n'est pas permanente. Lorsqu'un noeud worker est supprimé ou recréé, une nouvelle adresse IP publique lui est affectée. Vous pouvez utiliser le service NodePort pour tester l'accès public à votre application ou lorsque l'accès public n'est nécessaire que pour un temps très bref. Si vous avez besoin d'une adresse IP publique stable et d'une plus grande disponibilité de votre noeud final de service, exposez votre application en utilisant un service LoadBalancer ou Ingress.</dd>
<dt><a href="#cs_apps_public_load_balancer" target="_blank">Service LoadBalancer</a> (clusters standard uniquement)</dt>
<dd>Chaque cluster standard est mis à disposition avec 4 adresses IP publiques portables et 4 adresses IP privées portables que vous pouvez utiliser pour créer un équilibreur de charge TCP/ UDP externe pour votre application. Vous pouvez personnaliser votre équilibreur de charge en exposant n'importe quel port dont votre application a besoin. L'adresse IP publique portable affectée à l'équilibreur de charge est permanente et ne change pas en cas de recréation d'un noeud worker dans le cluster.

</br>
Si vous avez besoin d'un équilibrage de charge HTTP ou HTTPS pour votre application et désirez utiliser une seule route publique pour exposer plusieurs applications dans votre cluster sous forme de services, utilisez la prise en charge Ingress intégrée dans {{site.data.keyword.containershort_notm}}.</dd>
<dt><a href="#cs_apps_public_ingress" target="_blank">Ingress</a> (clusters standard uniquement)</dt>
<dd>Exposez plusieurs applications dans votre cluster en créant un équilibreur de charge externe HTTP ou HTTPS qui utilise un point d'entrée public sécurisé et unique pour acheminer les demandes entrantes vers vos applications. Ingress est composé de deux composants principaux ; la ressource Ingress et le contrôleur Ingress. La ressource Ingress définit les règles de routage et d'équilibrage de charge des demandes entrantes pour une application. Toutes les ressources Ingress doivent être enregistrées auprès du contrôleur Ingress qui est à l'écoute de demandes de service HTTP ou HTTPS entrantes et qui les réachemine en fonction des règles définies pour chaque ressource Ingress. Utilisez Ingress si vous désirez implémenter votre propre équilibreur de charge avec des règles de routage personnalisées et si vous avez besoin d'une terminaison SSL pour vos applications.

</dd></dl>

### Configuration de l'accès public à une application à l'aide du type de service NodePort
{: #cs_apps_public_nodeport}

Rendez votre application accessible sur Internet en utilisant l'adresse IP publique de n'importe quel noeud worker dans un cluster et en exposant un port de noeud. Utilisez cette option à des fins de test et d'un accès public à court terme.

{:shortdesc}

Vous pouvez exposer votre application en tant que service Kubernetes NodePort pour les clusters léger ou standard.

Pour les environnements {{site.data.keyword.Bluemix_dedicated_notm}}, les adresses IP publiques sont bloquées par un pare-feu. Pour rendre une application accessible au public, utilisez plutôt un [service LoadBalancer](#cs_apps_public_load_balancer) ou [Ingress](#cs_apps_public_ingress).

**Remarque :** l'adresse IP publique d'un noeud worker n'est pas permanente. Si le noeud worker doit être recréé, une nouvelle adresse IP publique lui est affectée. Si vous avez besoin d'une adresse IP publique stable et d'une plus grande disponibilité de votre service, exposez votre application en utilisant un [service LoadBalancer](#cs_apps_public_load_balancer) ou [Ingress](#cs_apps_public_ingress).




1.  Définissez une section [ ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/concepts/services-networking/service/) Service dans le fichier de configuration.
2.  Dans la section `spec` du service, ajoutez le type NodePort.

    ```
    spec:
      type: NodePort
    ```
    {: codeblock}

3.  Facultatif : dans la section `ports`, ajoutez une valeur NodePort comprise entre 30000 et 32767. Ne spécifiez pas une valeur NodePort déjà utilisée par un autre service. Si vous ne savez pas quelles valeurs NodePort sont déjà en cours d'utilisation, vous n'êtes pas obligé d'en affecter une. Si aucune valeur NodePort n'est affectée, une valeur Nodeport aléatoire est affectée pour vous.

    ```
    ports:
      - port: 80
        nodePort: 31514
    ```
    {: codeblock}

    Si vous désirez spécifier un NodePort et désirez déterminer lesquels sont déjà utilisés, vous pouvez exécuter la commande suivante.

    ```
    kubectl get svc
    ```
    {: pre}

    Sortie :

    ```
    NAME           CLUSTER-IP     EXTERNAL-IP   PORTS          AGE
    myapp          10.10.10.83    <nodes>       80:31513/TCP   28s
    redis-master   10.10.10.160   <none>        6379/TCP       28s
    redis-slave    10.10.10.194   <none>        6379/TCP       28s
    ```
    {: screen}

4.  Enregistrez vos modifications.
5.  Répétez cette procédure pour créer un service pour chaque application.

    Exemple :

    ```
    apiVersion: v1
    kind: Service
    metadata:
      name: my-nodeport-service
      labels:
        run: my-demo
    spec:
      selector:
        run: my-demo
      type: NodePort
      ports:
       - protocol: TCP
         port: 8081
         # nodePort: 31514

    ```
    {: codeblock}

**Etape suivante ?**

Une fois l'application déployée, vous pouvez utiliser l'adresse IP publique de n'importe quel noeud worker et le NodePort
pour composer l'URL publique d'accès à l'application dans un navigateur.

1.  Extrayez l'adresse IP publique d'un noeud worker dans le cluster.

    ```
    bx cs workers <cluster_name>
    ```
    {: pre}

    Sortie :

    ```
    ID                                                Public IP   Private IP    Size     State    Status
    prod-dal10-pa215dcf5bbc0844a990fa6b0fcdbff286-w1  192.0.2.23  10.100.10.10  u2c.2x4  normal   Ready
    prod-dal10-pa215dcf5bbc0844a990fa6b0fcdbff286-w2  192.0.2.27  10.100.10.15  u2c.2x4  normal   Ready
    ```
    {: screen}

2.  Si un NodePort aléatoire a été affecté, identifiez-le.

    ```
    kubectl describe service <service_name>
    ```
    {: pre}

    Sortie :

    ```
    Name:                   <service_name>
    Namespace:              default
    Labels:                 run=<deployment_name>
    Selector:               run=<deployment_name>
    Type:                   NodePort
    IP:                     10.10.10.8
    Port:                   <unset> 8080/TCP
    NodePort:               <unset> 30872/TCP
    Endpoints:              172.30.171.87:8080
    Session Affinity:       None
    No events.
    ```
    {: screen}

    Dans cet exemple, la valeur de NodePort est `30872`.

3.  Composez l'URL avec l'une des adresses IP publiques de noeud worker et le port de noeud (NodePort). Exemple : `http://192.0.2.23:30872`

### Configuration de l'accès public à une application à l'aide du type de service LoadBalancer
{: #cs_apps_public_load_balancer}

Exposez un port et utilisez l'adresse IP portable de l'équilibreur de charge pour accéder à l'application. Utilisez une adresse IP publique pour rendre une application accessible sur Internet ou une adresse IP privée pour rendre une application accessible sur votre réseau d'infrastructure privé.

Contrairement à un service NodePort, l'adresse IP portable du service d'équilibreur de charge n'est pas dépendante du noeud worker sur lequel l'application est déployée. Cependant, un service Kubernetes LoadBalancer est également un service NodePort. Un service LoadBalancer rend accessible votre application via l'adresse IP et le port de l'équilibreur de charge et la rend accessible via les ports de noeud du service.

L'adresse IP portable de l'équilibreur de charge est affectée pour vous et ne change pas lorsque vous ajoutez ou retirez des noeuds d'agent. Par conséquent, les services d'équilibreur de charge offrent une plus haute disponibilité que les services NodePort. Les utilisateurs peuvent sélectionner n'importe quel port pour l'équilibreur de charge et ne sont pas confinés à la plage de ports NodePort. Vous pouvez utiliser des services d'équilibreur de charge pour les protocoles TCP et UDP.

Lorsqu'un compte {{site.data.keyword.Bluemix_dedicated_notm}} est [activé pour des clusters](cs_ov.html#setup_dedicated), vous pouvez demander que des sous-réseaux publics soient utilisés pour les adresses IP d'équilibreur de charge. [Ouvrez un ticket de demande de service](/docs/support/index.html#contacting-support) pour créer le sous-réseau, puis utilisez la commande [`bx cs cluster-subnet-add`](cs_cli_reference.html#cs_cluster_subnet_add) pour ajouter le sous-réseau au cluster.

**Remarque :** les services d'équilibreur de charge ne prennent pas en charge la terminaison TLS. Si votre application nécessite une terminaison TLS, vous pouvez exposer votre application en utilisant [Ingress](#cs_apps_public_ingress) ou bien la configurer afin qu'elle gère la terminaison TLS.

Avant de commencer :

-   Cette fonction n'est disponible que pour les clusters standard.
-   Vous devez disposer d'une adresse IP publique ou privée disponible pour l'affecter au service d'équilibreur de charge.
-   Un service d'équilibreur de charge avec une adresse IP privée portable comporte toujours un port de noeud public ouvert sur tous les noeuds d'agent. Pour ajouter une règle réseau afin d'éviter tout trafic public, voir [Blocage de trafic entrant](cs_security.html#cs_block_ingress).

Pour créer un service d'équilibreur de charge, procédez comme suit :

1.  [Déployez votre application sur le cluster](#cs_apps_cli). Lorsque vous déployez l'application sur le cluster, un ou plusieurs pods sont créés pour vous et exécutent votre application dans un conteneur. Prenez soin d'ajouter un libellé à votre déploiement dans la section "metadata" de votre fichier de configuration. Ce libellé est nécessaire pour identifier tous les pods où s'exécute votre application afin de pouvoir les inclure dans l'équilibrage de charge.
2.  Créez un service d'équilibreur de charge pour l'application que vous désirez exposer. Pour rendre votre application accessible sur l'Internet public ou sur un réseau privé, créez un service Kubernetes pour votre application. Configurez ce service pour inclure tous les pods composant votre application dans l'équilibrage de charge.
    1.  Créez un fichier de configuration de service nommé, par exemple, `myloadbalancer.yaml`.
    2.  Définissez un service d'équilibreur de charge pour l'application vous désirez exposer.
        - Si votre cluster se trouve sur un VLAN public, une adresse IP publique portable est utilisée. La plupart des clusters se trouvent dans un VLAN public.
        - Si votre cluster est disponible uniquement sur un VLAN privé, une adresse IP privée portable est utilisée.
        - Vous pouvez demander une adresse publique ou privée portable pour un service LoadBalancer en ajoutant une annotation dans le fichier de configuration.

        Service LoadBalancer utilisant une adresse IP par défaut :

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <myservice>
        spec:
          type: LoadBalancer
          selector:
            <selectorkey>:<selectorvalue>
          ports:
           - protocol: TCP
             port: 8080
        ```
        {: codeblock}

        Service LoadBalancer utilisant une annotation pour indiquer une adresse IP privée ou publique :

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <myservice>
          annotations: 
            service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private> 
        spec:
          type: LoadBalancer
          selector:
            <selectorkey>:<selectorvalue>
          ports:
           - protocol: TCP
             port: 8080
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
        </thead>
        <tbody>
        <tr>
          <td><code>name</code></td>
          <td>Remplacez <em>&lt;myservice&gt;</em> par un nom pour votre service d'équilibreur de charge.</td>
        </tr>
        <tr>
          <td><code>selector</code></td>
          <td>Entrez la paire clé de libellé (<em>&lt;selectorkey&gt;</em>) et valeur (<em>&lt;selectorvalue&gt;</em>) que vous désirez utiliser pour cibler les pods dans lesquels s'exécute votre application. Par exemple, si vous utilisez le sélecteur <code>app: code</code> suivant, tous les pods dont les métadonnées comportent ce libellé sont inclus dans l'équilibrage de charge. Entrez le même libellé que celui utilisé lorsque vous avez déployé votre application dans le cluster. </td>
        </tr>
        <tr>
          <td><code>port</code></td>
          <td>Port sur lequel le service est à l'écoute.</td>
        </tr>
        <tr>
          <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type:`
          <td>Annotation utilisée pour indiquer le type d'équilibreur de charge (LoadBalancer). Les valeurs possibles sont `private` et `public`. Lors de la création d'un équilibreur de charge public dans les clusters dans des VLAN publics, cette annotation n'est pas nécessaire.</td>
        </tbody></table>
    3.  Facultatif : pour utiliser une adresse IP portable spécifique pour votre équilibreur de charge et disponible pour votre cluster, vous pouvez spécifier cette adresse IP en incluant l'entrée `loadBalancerIP` dans la section spec. Pour plus d'informations, voir la [documentation Kubernetes ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/concepts/services-networking/service/).
    4.  Facultatif : configurez un pare-feu en indiquant `loadBalancerSourceRanges` dans la section spec. Pour plus d'informations, voir la [documentation Kubernetes ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/).
    5.  Créez le service dans votre cluster.

        ```
        kubectl apply -f myloadbalancer.yaml
        ```
        {: pre}

        Lorsque votre service d'équilibreur de charge est créé, une adresse IP portable lui est automatiquement affectée. Si aucune adresse IP portable n'est disponible, le service d'équilibreur de charge ne peut pas être créé.
3.  Vérifiez que la création du service d'équilibreur de charge a abouti. Remplacez
_&lt;myservice&gt;_ par le nom du service d'équilibreur de charge créé à l'étape précédente.

    ```
    kubectl describe service <myservice>
    ```
    {: pre}

    **Remarque :** quelques minutes peuvent s'écouler pour que le service d'équilibreur de charge soit créé et que l'application soit disponible.

    Exemple de sortie d'interface CLI :

    ```
    Name:                   <myservice>
    Namespace:              default
    Labels:                 <none>
    Selector:               <selectorkey>=<selectorvalue>
    Type:                   LoadBalancer
    IP:                     10.10.10.90
    LoadBalancer Ingress:   192.168.10.38
    Port:                   <unset> 8080/TCP
    NodePort:               <unset> 32040/TCP
    Endpoints:              172.30.171.87:8080
    Session Affinity:       None
    Events:
    FirstSeen LastSeen Count From   SubObjectPath Type  Reason   Message
      --------- -------- ----- ----   ------------- -------- ------   -------
      10s  10s  1 {service-controller }   Normal  CreatingLoadBalancer Creating load balancer
      10s  10s  1 {service-controller }   Normal  CreatedLoadBalancer Created load balancer
    ```
    {: screen}

    L'adresse IP **LoadBalancer Ingress** est l'adresse IP portable affectée à votre service d'équilibreur de charge.
4.  Si vous avez créé un équilibreur de charge public, accédez à votre application via Internet.
    1.  Ouvrez le navigateur Web de votre choix.
    2.  Entrez l'adresse IP publique portable et le port de l'équilibreur de charge. Dans l'exemple ci-dessus, l'adresse IP publique portable `192.168.10.38` a été affectée au service d'équilibreur de charge.

        ```
        http://192.168.10.38:8080
        ```
        {: codeblock}




### Configuration de l'accès à une application à l'aide du contrôleur Ingress
{: #cs_apps_public_ingress}

Vous pouvez exposer plusieurs applications dans votre cluster en créant des ressources Ingress gérées par le contrôleur
Ingress fourni par IBM. Ce contrôleur est un équilibreur de charge HTTP ou HTTPS externe qui utilise un point d'entrée public ou privé sécurisé et unique pour acheminer les demandes entrantes vers vos applications situées dans le cluster ou en dehors.

**Remarque :** Ingress n'est disponible que pour les clusters standard et nécessite au moins deux noeuds d'agent dans le cluster pour garantir une haute disponibilité et l'application régulière de mises à jour. La configuration d'Ingress nécessite une [règle d'accès administrateur](cs_cluster.html#access_ov). Vérifiez votre [règle d'accès](cs_cluster.html#view_access) actuelle.

Lorsque vous créez un cluster standard, un contrôleur Ingress est automatiquement créé et activé, et une adresse IP portable et une route publiques lui sont affectées. Un contrôleur Ingress auquel sont affectées une adresse IP portable et une route privées est également créé automatiquement, mais il n'est pas automatiquement activé. Vous pouvez configurer le contrôleur Ingress et définir des règles de routage individuelles pour chaque application exposée sur les réseaux privés ou publics. Chaque application exposée au public via Ingress se voit affecter un chemin unique, lequel est rajouté à la route publique, de sorte que vous pouvez utiliser une URL unique pour accès public à votre application dans le cluster.

Lorsqu'un compte {{site.data.keyword.Bluemix_dedicated_notm}} est [activé pour des clusters](cs_ov.html#setup_dedicated), vous pouvez demander que des sous-réseaux publics soient utilisés pour les adresses IP de contrôleur Ingress. Ensuite, le contrôleur Ingress est créé et une route publique est affectée. [Ouvrez un ticket de demande de service](/docs/support/index.html#contacting-support) pour créer le sous-réseau, puis utilisez la commande [`bx cs cluster-subnet-add`](cs_cli_reference.html#cs_cluster_subnet_add) pour ajouter le sous-réseau au cluster.

Pour exposer votre application au public, vous pouvez configurer le contrôleur Ingress public pour les scénarios suivants.

-   [Utilisation du domaine fourni par IBM sans terminaison TLS](#ibm_domain)
-   [Utilisation du domaine fourni par IBM avec terminaison TLS](#ibm_domain_cert)
-   [Utilisation d'un domaine personnalisé et d'un certificat TLS pour la terminaison TLS](#custom_domain_cert)
-   [Utilisation du domaine fourni par IBM ou d'un domaine personnalisé avec terminaison TLS pour accéder aux applications en dehors de votre cluster](#external_endpoint)
-   [Ouverture de ports dans l'équilibreur de charge Ingress](#opening_ingress_ports)
-   [Configuration de protocoles et de chiffrements SSL au niveau HTTP](#ssl_protocols_ciphers)
-   [Personnalisation de votre contrôleur Ingress avec des annotations](cs_annotations.html)
{: #ingress_annotation}

Pour exposer votre application sur des réseaux privés, commencez par [activer le contrôleur Ingress privé](#private_ingress). Vous pouvez ensuite configurer le contrôleur Ingress privé pour les scénarios suivants.

-   [Utilisation d'un domaine personnalisé sans terminaison TLS](#private_ingress_no_tls)
-   [Utilisation d'un domaine personnalisé et d'un certificat TLS pour la terminaison TLS](#private_ingress_tls)

#### Utilisation du domaine fourni par IBM sans terminaison TLS
{: #ibm_domain}

Vous pouvez configurer le contrôleur Ingress en tant qu'équilibreur de charge HTTP pour les applications situées dans votre
cluster et utiliser le domaine fourni par IBM pour accéder à vos applications depuis Internet.

Avant de commencer :

-   Si ne n'est déjà fait, [créez un cluster standard](cs_cluster.html#cs_cluster_ui).
-   [Ciblez avec votre interface
CLI](cs_cli_install.html#cs_cli_configure) votre cluster pour exécuter des commandes kubectl.

Pour configurer le contrôleur Ingress, procédez comme suit :

1.  [Déployez votre application sur le cluster](#cs_apps_cli). Lorsque vous déployez l'application sur le cluster, un ou plusieurs pods sont créés pour vous et exécutent votre application dans un conteneur. Prenez soin d'ajouter un libellé à votre déploiement dans la section "metadata" de votre fichier de configuration. Ce libellé est nécessaire pour identifier tous les pods où s'exécute votre application afin de pouvoir les inclure dans l'équilibrage de charge Ingress.
2.  Créez un service Kubernetes pour l'application à exposer. Le contrôleur Ingress ne peut inclure votre application dans l'équilibrage de charge Ingress que si l'application est exposée via un service Kubernetes dans le cluster.
    1.  Ouvrez l'éditeur de votre choix et créez un fichier de configuration de service nommé, par exemple, `myservice.yaml`.
    2.  Définissez un service pour l'application que vous désirez exposer au public.

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <myservice>
        spec:
          selector:
            <selectorkey>: <selectorvalue>
          ports:
           - protocol: TCP
             port: 8080
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Remplacez <em>&lt;myservice&gt;</em> par un nom pour votre service d'équilibreur de charge.</td>
        </tr>
        <tr>
        <td><code>selector</code></td>
        <td>Entrez la paire clé de libellé (<em>&lt;selectorkey&gt;</em>) et valeur (<em>&lt;selectorvalue&gt;</em>) que vous désirez utiliser pour cibler les pods dans lesquels s'exécute votre application. Par exemple, si vous utilisez le sélecteur <code>app: code</code> suivant, tous les pods dont les métadonnées comportent ce libellé sont inclus dans l'équilibrage de charge. Entrez le même libellé que celui utilisé lorsque vous avez déployé votre application dans le cluster. </td>
         </tr>
         <tr>
         <td><code>port</code></td>
         <td>Port sur lequel le service est à l'écoute.</td>
         </tr>
         </tbody></table>
    3.  Sauvegardez vos modifications.
    4.  Créez le service dans votre cluster.

        ```
        kubectl apply -f myservice.yaml
        ```
        {: pre}
    5.  Répétez ces étapes pour chaque application que vous désirez exposer au public.
3.  Extrayez les informations sur votre cluster pour identifier le domaine fourni par IBM. Remplacez
_&lt;mycluster&gt;_ par le nom du cluster sur lequel l'application que vous désirez exposer au public est déployée.

    ```
    bx cs cluster-get <mycluster>
    ```
    {: pre}

    La sortie de votre interface CLI sera similaire à ceci.

    ```
    Retrieving cluster <mycluster>...
    OK
    Name:    <mycluster>
    ID:    b9c6b00dc0aa487f97123440b4895f2d
    Created:  2017-04-26T19:47:08+0000
    State:    normal
    Master URL:  https://169.57.40.165:1931
    Ingress subdomain:  <ibmdomain>
    Ingress secret:  <ibmtlssecret>
    Workers:  3
    ```
    {: screen}

    Le domaine fourni par IBM est indiqué dans la zone **Ingress subdomain**.
4.  Créez une ressource Ingress. Les ressources Ingress définissent les règles de routage pour le service Kubernetes que vous avez créé pour votre application et sont utilisées par le contrôleur Ingress pour acheminer le trafic réseau entrant au service. Vous pouvez utiliser une même ressource Ingress pour définir des règles de routage pour plusieurs applications dans la mesure où chaque application est exposée via un service Kubernetes dans le cluster.
    1.  Ouvrez l'éditeur de votre choix et créez un fichier de configuration Ingress nommé, par exemple, `myingress.yaml`.
    2.  Définissez dans votre fichier de configuration une ressource Ingress utilisant le domaine fourni par IBM pour acheminer le trafic réseau entrant au service que vous avez créé auparavant.

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: <myingressname>
        spec:
          rules:
          - host: <ibmdomain>
            http:
              paths:
              - path: /<myservicepath1>
                backend:
                  serviceName: <myservice1>
                  servicePort: 80
              - path: /<myservicepath2>
                backend:
                  serviceName: <myservice2>
                  servicePort: 80
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Remplacez <em>&lt;myingressname&gt;</em> par le nom de votre ressource Ingress.</td>
        </tr>
        <tr>
        <td><code>host</code></td>
        <td>Remplacez <em>&lt;ibmdomain&gt;</em> par le nom <strong>Ingress subdomain</strong> fourni par IBM lors de l'étape précédente.

        </br></br>
        <strong>Remarque :</strong> N'utilisez pas le signe * pour votre hôte ou laissez vide la propriété de l'hôte afin d'éviter des échecs lors de la création Ingress.</td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>Remplacez <em>&lt;myservicepath1&gt;</em> par une barre oblique, ou par le chemin unique sur lequel votre application est à l'écoute, afin que ce trafic réseau puisse être réacheminé à l'application.

        </br>
        Pour chaque service Kubernetes, vous pouvez définir un chemin individuel qui s'ajoute au domaine fourni par IBM afin de constituer un chemin unique vers votre application. Par exemple, <code>ingress_domain/myservicepath1</code>. Lorsque vous indiquez cette route dans un navigateur Web, le trafic réseau est acheminé au contrôleur Ingress. Le contrôleur Ingress recherche le service associé et lui envoie le trafic réseau, ainsi qu'aux pods sur lesquels l'application s'exécute, en utilisant ce même chemin. L'application doit être configurée pour être à l'écoute sur ce chemin afin de recevoir le trafic réseau entrant.

        </br></br>
        De nombreuses applications ne sont pas à l'écoute sur un chemin spécifique mais utilisent le chemin racine et un port spécifique. Dans ce cas, définissez le chemin racine sous la forme <code>/</code>, sans spécifier de chemin individuel pour votre application.
        </br>
        Exemples : <ul><li>Pour <code>http://ingress_host_name/</code>, entrez <code>/</code> pour le chemin.</li><li>Pour <code>http://ingress_host_name/myservicepath</code>, entrez <code>/myservicepath</code> pour le chemin.</li></ul>
        </br>
        <strong>Astuce :</strong> si vous désirez configurer Ingress pour être à l'écoute sur un chemin différent de celui où l'application est à l'écoute, vous pouvez utiliser l'[annotation rewrite](cs_annotations.html#rewrite-path) pour définir le routage approprié vers votre application.</td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td>Remplacez <em>&lt;myservice1&gt;</em> par le nom du service que vous avez utilisé lors de la création du service Kubernetes pour votre application.</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>Port sur lequel votre service est à l'écoute. Utilisez le même port que celui que vous avez défini lors de la création du service Kubernetes pour votre application.</td>
        </tr>
        </tbody></table>

    3.  Créez la ressource Ingress pour votre cluster.

        ```
        kubectl apply -f myingress.yaml
        ```
        {: pre}

5.  Vérifiez que la création de la ressource Ingress a abouti. Remplacez _&lt;myingressname&gt;_ par le nom de la ressource Ingress que vous avez créée plus tôt.

    ```
    kubectl describe ingress <myingressname>
    ```
    {: pre}

  **Remarque :** quelques minutes peuvent s'écouler avant que la ressource Ingress ne soit créée et que l'application soit disponible sur l'Internet public.
6.  Dans un navigateur Web, entrez l'URL du service d'application auquel accéder.

    ```
    http://<ibmdomain>/<myservicepath1>
    ```
    {: codeblock}


#### Utilisation du domaine fourni par IBM avec terminaison TLS
{: #ibm_domain_cert}

Vous pouvez configurer le contrôleur Ingress pour gérer les connexions TLS entrantes vers vos applications,
déchiffrer le trafic réseau à l'aide du certificat fourni par IBM et réacheminer la requête non chiffrée aux applications exposées dans votre cluster.

Avant de commencer :

-   Si ne n'est déjà fait, [créez un cluster standard](cs_cluster.html#cs_cluster_ui).
-   [Ciblez avec votre interface
CLI](cs_cli_install.html#cs_cli_configure) votre cluster pour exécuter des commandes kubectl.

Pour configurer le contrôleur Ingress, procédez comme suit :

1.  [Déployez votre application sur le cluster](#cs_apps_cli). Prenez soin d'ajouter un libellé à votre déploiement dans la section "metadata" de votre fichier de configuration. Ce libellé identifie tous les pods où s'exécute votre application afin de pouvoir les inclure dans l'équilibrage de charge Ingress.
2.  Créez un service Kubernetes pour l'application à exposer. Le contrôleur Ingress ne peut inclure votre application dans l'équilibrage de charge Ingress que si l'application est exposée via un service Kubernetes dans le cluster.
    1.  Ouvrez l'éditeur de votre choix et créez un fichier de configuration de service nommé, par exemple, `myservice.yaml`.
    2.  Définissez un service pour l'application que vous désirez exposer au public.

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <myservice>
        spec:
          selector:
            <selectorkey>: <selectorvalue>
          ports:
           - protocol: TCP
             port: 8080
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Remplacez <em>&lt;myservice&gt;</em> par le nom de votre service Kubernetes.</td>
        </tr>
        <tr>
        <td><code>selector</code></td>
        <td>Entrez la paire clé de libellé (<em>&lt;selectorkey&gt;</em>) et valeur (<em>&lt;selectorvalue&gt;</em>) que vous désirez utiliser pour cibler les pods dans lesquels s'exécute votre application. Par exemple, si vous utilisez le sélecteur <code>app: code</code> suivant, tous les pods dont les métadonnées comportent ce libellé sont inclus dans l'équilibrage de charge. Entrez le même libellé que celui utilisé lorsque vous avez déployé votre application dans le cluster. </td>
         </tr>
         <tr>
         <td><code>port</code></td>
         <td>Port sur lequel le service est à l'écoute.</td>
         </tr>
         </tbody></table>

    3.  Sauvegardez vos modifications.
    4.  Créez le service dans votre cluster.

        ```
        kubectl apply -f myservice.yaml
        ```
        {: pre}

    5.  Répétez ces étapes pour chaque application que vous désirez exposer au public.

3.  Affichez le domaine fourni par IBM et le certificat TLS. Remplacez _&lt;mycluster&gt;_ par le nom du cluster sur lequel l'application est déployée.

    ```
    bx cs cluster-get <mycluster>
    ```
    {: pre}

    La sortie de votre interface CLI sera similaire à ceci.

    ```
    bx cs cluster-get <mycluster>
    Retrieving cluster <mycluster>...
    OK
    Name:    <mycluster>
    ID:    b9c6b00dc0aa487f97123440b4895f2d
    Created:  2017-04-26T19:47:08+0000
    State:    normal
    Master URL:  https://169.57.40.165:1931
    Ingress subdomain:  <ibmdomain>
    Ingress secret:  <ibmtlssecret>
    Workers:  3
    ```
    {: screen}

    Le domaine fourni par IBM figure dans la zone **Ingress subdomain** et le certificat fourni par IBM, dans la zone **Ingress secret**.

4.  Créez une ressource Ingress. Les ressources Ingress définissent les règles de routage pour le service Kubernetes que vous avez créé pour votre application et sont utilisées par le contrôleur Ingress pour acheminer le trafic réseau entrant au service. Vous pouvez utiliser une même ressource Ingress pour définir des règles de routage pour plusieurs applications dans la mesure où chaque application est exposée via un service Kubernetes dans le cluster.
    1.  Ouvrez l'éditeur de votre choix et créez un fichier de configuration Ingress nommé, par exemple, `myingress.yaml`.
    2.  Définissez dans votre fichier de configuration une ressource Ingress utilisant le domaine fourni par IBM pour acheminer le trafic réseau entrant à vos services et le certificat fourni par IBM pour gérer la terminaison TLS pour vous. Vous pouvez définir pour chaque service un chemin d'accès individuel en l'ajoutant au domaine fourni par IBM de manière à créer un chemin unique vers votre application. Par exemple, `https://ingress_domain/myapp`. Lorsque vous indiquez cette route dans un navigateur Web, le trafic réseau est acheminé au contrôleur Ingress. Le contrôleur Ingress recherche le service associé et lui envoie le trafic réseau, ainsi qu'aux pods sur lesquels l'application s'exécute.

        **Remarque :** votre application doit être à l'écoute sur le chemin que vous avez défini dans la ressource Ingress. Si tel n'est pas le cas, le trafic réseau ne peut pas être acheminé vers l'application. La plupart des applications ne sont pas à l'écoute sur un chemin spécifique, mais utilisent le chemin racine et un port spécifique. Dans ce cas, définissez le chemin racine sous la forme `/`, sans spécifier de chemin individuel pour votre application.

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: <myingressname>
        spec:
          tls:
          - hosts:
            - <ibmdomain>
            secretName: <ibmtlssecret>
          rules:
          - host: <ibmdomain>
            http:
              paths:
              - path: /<myservicepath1>
                backend:
                  serviceName: <myservice1>
                  servicePort: 80
              - path: /<myservicepath2>
                backend:
                  serviceName: <myservice2>
                  servicePort: 80
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Remplacez <em>&lt;myingressname&gt;</em> par le nom de votre ressource Ingress.</td>
        </tr>
        <tr>
        <td><code>tls/hosts</code></td>
        <td>Remplacez <em>&lt;ibmdomain&gt;</em> par le nom <strong>Ingress subdomain</strong> fourni par IBM à l'étape précédente. Ce domaine est configuré pour terminaison TLS.

        </br></br>
        <strong>Remarque :</strong> n'utilisez pas le signe &ast; pour votre hôte ou laissez vide la propriété de l'hôte afin d'éviter des échecs lors de la création Ingress.</td>
        </tr>
        <tr>
        <td><code>tls/secretName</code></td>
        <td>Remplacez <em>&lt;ibmtlssecret&gt;</em> par le nom <strong>Ingress secret</strong> fourni par IBM à l'étape précédente. Ce certificat gère la terminaison TLS.
        </tr>
        <tr>
        <td><code>host</code></td>
        <td>Remplacez <em>&lt;ibmdomain&gt;</em> par le nom <strong>Ingress subdomain</strong> fourni par IBM à l'étape précédente. Ce domaine est configuré pour terminaison TLS.

        </br></br>
        <strong>Remarque :</strong> n'utilisez pas le signe &ast; pour votre hôte ou laissez vide la propriété de l'hôte afin d'éviter des échecs lors de la création Ingress.</td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>Remplacez <em>&lt;myservicepath1&gt;</em> par une barre oblique, ou par le chemin unique sur lequel votre application est à l'écoute, afin que ce trafic réseau puisse être réacheminé à l'application.

        </br>
        Pour chaque service Kubernetes, vous pouvez définir un chemin individuel qui s'ajoute au domaine fourni par IBM afin de constituer un chemin unique vers votre application. Par exemple, <code>ingress_domain/myservicepath1</code>. Lorsque vous indiquez cette route dans un navigateur Web, le trafic réseau est acheminé au contrôleur Ingress. Le contrôleur Ingress recherche le service associé et lui envoie le trafic réseau, ainsi qu'aux pods sur lesquels l'application s'exécute, en utilisant ce même chemin. L'application doit être configurée pour être à l'écoute sur ce chemin afin de recevoir le trafic réseau entrant.

        </br>
        De nombreuses applications ne sont pas à l'écoute sur un chemin spécifique mais utilisent le chemin racine et un port spécifique. Dans ce cas, définissez le chemin racine sous la forme
<code>/</code>, sans spécifier de chemin individuel pour votre application.

        </br>
        Exemples : <ul><li>Pour <code>http://ingress_host_name/</code>, entrez <code>/</code> pour le chemin.</li><li>Pour <code>http://ingress_host_name/myservicepath</code>, entrez <code>/myservicepath</code> pour le chemin.</li></ul>
        <strong>Astuce :</strong> si vous désirez configurer Ingress pour être à l'écoute sur un chemin différent de celui où l'application est à l'écoute, vous pouvez utiliser l'[annotation rewrite](cs_annotations.html#rewrite-path) pour définir le routage approprié vers votre application.</td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td>Remplacez <em>&lt;myservice1&gt;</em> par le nom du service que vous avez utilisé lors de la création du service Kubernetes pour votre application.</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>Port sur lequel votre service est à l'écoute. Utilisez le même port que celui que vous avez défini lors de la création du service Kubernetes pour votre application.</td>
        </tr>
        </tbody></table>

    3.  Créez la ressource Ingress pour votre cluster.

        ```
        kubectl apply -f myingress.yaml
        ```
        {: pre}

5.  Vérifiez que la création de la ressource Ingress a abouti. Remplacez _&lt;myingressname&gt;_ par le nom de la ressource Ingress que vous avez créée plus tôt.

    ```
    kubectl describe ingress <myingressname>
    ```
    {: pre}

    **Remarque :** quelques minutes peuvent s'écouler avant que la ressource Ingress ne soit correctement créée et que l'application soit disponible sur l'Internet public.
6.  Dans un navigateur Web, entrez l'URL du service d'application auquel accéder.

    ```
    https://<ibmdomain>/<myservicepath1>
    ```
    {: codeblock}

#### Utilisation du contrôleur Ingress avec un domaine personnalisé et un certificat TLS
{: #custom_domain_cert}

Vous pouvez configurer le contrôleur Ingress afin d'acheminer le trafic réseau entrant vers les applications de votre cluster et d'utiliser votre propre certificat TLS pour gérer la terminaison TLS tout en utilisant votre domaine personnalisé au lieu du domaine fourni par IBM.
{:shortdesc}

Avant de commencer :

-   Si ne n'est déjà fait, [créez un cluster standard](cs_cluster.html#cs_cluster_ui).
-   [Ciblez avec votre interface
CLI](cs_cli_install.html#cs_cli_configure) votre cluster pour exécuter des commandes kubectl.

Pour configurer le contrôleur Ingress, procédez comme suit :

1.  Créez un domaine personnalisé. Pour créer un domaine personnalisé, gérez votre fournisseur DNS (Domain Name Service) afin d'enregistrer votre domaine personnalisé.
2.  Configurez votre domaine pour acheminer le trafic réseau entrant au contrôleur Ingress IBM. Sélectionnez l'une des options suivantes :
    -   Définir un alias pour votre domaine personnalisé en spécifiant le domaine fourni par IBM sous forme d'enregistrement de nom canonique (CNAME). Pour identifier le domaine Ingress fourni par IBM, exécutez `bx cs cluster-get <mycluster>` et recherchez la zone **Ingress subdomain**.
    -   Mappez votre domaine personnalisé à l'adresse IP publique portable du contrôleur Ingress fourni par IBM en ajoutant l'adresse IP en tant qu'enregistrement. Pour déterminer l'adresse IP publique portable du contrôleur Ingress, procédez comme suit :
        1.  Exécutez `bx cs cluster-get <mycluster>` et recherchez la zone **Ingress subdomain**.
        2.  Exécutez `nslookup <Ingress subdomain>`.
3.  Créez un certificat TLS et une clé pour votre domaine codés au format PEM.
4.  Stockez votre certificat et clé TLS dans une valeur confidentielle Kubernetes.
    1.  Ouvrez l'éditeur de votre choix et créez un fichier de configuration de valeur confidentielle Kubernetes nommé, par exemple, `mysecret.yaml`.
    2.  Définissez une valeur confidentielle qui utilise le certificat et la clé TLS.

        ```
        apiVersion: v1
        kind: Secret
        metadata:
          name: <mytlssecret>
        type: Opaque
        data:
          tls.crt: <tlscert>
          tls.key: <tlskey>
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Remplacez <em>&lt;mytlssecret&gt;</em> par le nom de votre valeur confidentielle Kubernetes.</td>
        </tr>
        <tr>
        <td><code>tls.cert</code></td>
        <td>Remplacez <em>&lt;tlscert&gt;</em> par votre certificat TLS personnalisé codé en base64.</td>
         </tr>
         <td><code>tls.key</code></td>
         <td>Remplacez <em>&lt;tlskey&gt;</em> par votre clé TLS personnalisée codée en base64.</td>
         </tbody></table>

    3.  Sauvegardez votre fichier de configuration.
    4.  Créez la valeur confidentielle TLS pour votre cluster.

        ```
        kubectl apply -f mysecret.yaml
        ```
        {: pre}

5.  [Déployez votre application sur le cluster](#cs_apps_cli). Lorsque vous déployez l'application sur le cluster, un ou plusieurs pods sont créés pour vous et exécutent votre application dans un conteneur. Prenez soin d'ajouter un libellé à votre déploiement dans la section "metadata" de votre fichier de configuration. Ce libellé est nécessaire pour identifier tous les pods où s'exécute votre application afin de pouvoir les inclure dans l'équilibrage de charge Ingress.

6.  Créez un service Kubernetes pour l'application à exposer. Le contrôleur Ingress ne peut inclure votre application dans l'équilibrage de charge Ingress que si l'application est exposée via un service Kubernetes dans le cluster.

    1.  Ouvrez l'éditeur de votre choix et créez un fichier de configuration de service nommé, par exemple, `myservice.yaml`.
    2.  Définissez un service pour l'application que vous désirez exposer au public.

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <myservice>
        spec:
          selector:
            <selectorkey>: <selectorvalue>
          ports:
           - protocol: TCP
             port: 8080
        ```
       {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Remplacez <em>&lt;service_1&gt;</em> par le nom de votre service Kubernetes.</td>
        </tr>
        <tr>
        <td><code>selector</code></td>
        <td>Entrez la paire clé de libellé (<em>&lt;selectorkey&gt;</em>) et valeur (<em>&lt;selectorvalue&gt;</em>) que vous désirez utiliser pour cibler les pods dans lesquels s'exécute votre application. Par exemple, si vous utilisez le sélecteur <code>app: code</code> suivant, tous les pods dont les métadonnées comportent ce libellé sont inclus dans l'équilibrage de charge. Entrez le même libellé que celui utilisé lorsque vous avez déployé votre application dans le cluster. </td>
         </tr>
         <td><code>port</code></td>
         <td>Port sur lequel le service est à l'écoute.</td>
         </tbody></table>

    3.  Sauvegardez vos modifications.
    4.  Créez le service dans votre cluster.

        ```
        kubectl apply -f myservice.yaml
        ```
        {: pre}

    5.  Répétez ces étapes pour chaque application que vous désirez exposer au public.
7.  Créez une ressource Ingress. Les ressources Ingress définissent les règles de routage pour le service Kubernetes que vous avez créé pour votre application et sont utilisées par le contrôleur Ingress pour acheminer le trafic réseau entrant au service. Vous pouvez utiliser une même ressource Ingress pour définir des règles de routage pour plusieurs applications dans la mesure où chaque application est exposée via un service Kubernetes dans le cluster.
    1.  Ouvrez l'éditeur de votre choix et créez un fichier de configuration Ingress nommé, par exemple, `myingress.yaml`.
    2.  Définissez dans votre fichier de configuration une ressource Ingress utilisant votre domaine personnalisé pour acheminer le trafic réseau entrant à vos services et votre certificat personnalisé pour gérer la terminaison TLS. Vous pouvez définir pour chaque service un chemin d'accès individuel en l'ajoutant à votre domaine personnalisé de manière à créer un chemin unique vers votre application. Par exemple, `https://mydomain/myapp`. Lorsque vous indiquez cette route dans un navigateur Web, le trafic réseau est acheminé au contrôleur Ingress. Le contrôleur Ingress recherche le service associé et lui envoie le trafic réseau, ainsi qu'aux pods sur lesquels l'application s'exécute.

        **Remarque :** il est important que l'application soit à l'écoute sur le chemin que vous avez défini dans la ressource Ingress. Si tel n'est pas le cas, le trafic réseau ne peut pas être acheminé vers l'application. La plupart des applications ne sont pas à l'écoute sur un chemin spécifique, mais utilisent le chemin racine et un port spécifique. Dans ce cas, définissez le chemin racine sous la forme `/`, sans spécifier de chemin individuel pour votre application.

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: <myingressname>
        spec:
          tls:
          - hosts:
            - <mycustomdomain>
            secretName: <mytlssecret>
          rules:
          - host: <mycustomdomain>
            http:
              paths:
              - path: /<myservicepath1>
                backend:
                  serviceName: <myservice1>
                  servicePort: 80
              - path: /<myservicepath2>
                backend:
                  serviceName: <myservice2>
                  servicePort: 80
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Remplacez <em>&lt;myingressname&gt;</em> par le nom de votre ressource Ingress.</td>
        </tr>
        <tr>
        <td><code>tls/hosts</code></td>
        <td>Remplacez <em>&lt;mycustomdomain&gt;</em> par le domaine personnalisé que vous désirez configurer pour terminaison TLS.

        </br></br>
        <strong>Remarque :</strong> n'utilisez pas le signe &ast; pour votre hôte ou laissez vide la propriété de l'hôte afin d'éviter des échecs lors de la création Ingress.</td>
        </tr>
        <tr>
        <td><code>tls/secretName</code></td>
        <td>Remplacez <em>&lt;mytlssecret&gt;</em> par le nom de la valeur confidentielle créée plus tôt qui contient votre certificat et votre clé TLS personnalisée pour gestion de la terminaison TLS pour votre domaine personnalisé.
        </tr>
        <tr>
        <td><code>host</code></td>
        <td>Remplacez <em>&lt;mycustomdomain&gt;</em> par le domaine personnalisé que vous désirez configurer pour terminaison TLS.

        </br></br>
        <strong>Remarque :</strong> n'utilisez pas le signe &ast; pour votre hôte ou laissez vide la propriété de l'hôte afin d'éviter des échecs lors de la création Ingress.
        </td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>Remplacez <em>&lt;myservicepath1&gt;</em> par une barre oblique, ou par le chemin unique sur lequel votre application est à l'écoute, afin que ce trafic réseau puisse être réacheminé à l'application.

        </br>
        Pour chaque service Kubernetes, vous pouvez définir un chemin individuel qui s'ajoute au domaine fourni par IBM afin de constituer un chemin unique vers votre application. Par exemple, <code>ingress_domain/myservicepath1</code>. Lorsque vous indiquez cette route dans un navigateur Web, le trafic réseau est acheminé au contrôleur Ingress. Le contrôleur Ingress recherche le service associé et lui envoie le trafic réseau, ainsi qu'aux pods sur lesquels l'application s'exécute, en utilisant ce même chemin. L'application doit être configurée pour être à l'écoute sur ce chemin afin de recevoir le trafic réseau entrant.

        </br>
        De nombreuses applications ne sont pas à l'écoute sur un chemin spécifique mais utilisent le chemin racine et un port spécifique. Dans ce cas, définissez le chemin racine sous la forme
<code>/</code>, sans spécifier de chemin individuel pour votre application.

        </br></br>
        Exemples : <ul><li>Pour <code>https://mycustomdomain/</code>, entrez <code>/</code> pour le chemin.</li><li>Pour <code>https://mycustomdomain/myservicepath</code>, entrez <code>/myservicepath</code> pour le chemin.</li></ul>
        <strong>Astuce :</strong> si vous désirez configurer Ingress pour être à l'écoute sur un chemin différent de celui où l'application est à l'écoute, vous pouvez utiliser l'[annotation rewrite](cs_annotations.html#rewrite-path) pour définir le routage approprié vers votre application.
        </td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td>Remplacez <em>&lt;myservice1&gt;</em> par le nom du service que vous avez utilisé lors de la création du service Kubernetes pour votre application.</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>Port sur lequel votre service est à l'écoute. Utilisez le même port que celui que vous avez défini lors de la création du service Kubernetes pour votre application.</td>
        </tr>
        </tbody></table>

    3.  Sauvegardez vos modifications.
    4.  Créez la ressource Ingress pour votre cluster.

        ```
        kubectl apply -f myingress.yaml
        ```
        {: pre}

8.  Vérifiez que la création de la ressource Ingress a abouti. Remplacez _&lt;myingressname&gt;_ par le nom de la ressource Ingress que vous avez créée plus tôt.

    ```
    kubectl describe ingress <myingressname>
    ```
    {: pre}

    **Remarque :** quelques minutes peuvent s'écouler avant que la ressource Ingress ne soit correctement créée et que l'application soit disponible sur l'Internet public.

9.  Accédez à votre application depuis Internet.
    1.  Ouvrez le navigateur Web de votre choix.
    2.  Entrez l'URL du service d'application auquel vous désirez accéder.

        ```
        https://<mycustomdomain>/<myservicepath1>
        ```
        {: codeblock}


#### Configuration du contrôleur Ingress pour acheminer le trafic réseau aux applications en dehors du cluster
{: #external_endpoint}

Vous pouvez configurer le contrôleur Ingress pour inclure dans l'équilibrage de charge du cluster les applications situées en dehors du cluster. Les requêtes entrantes sur le domaine fourni par IBM, ou sur votre domaine personnalisé, sont acheminées automatiquement à l'application externe.

Avant de commencer :

-   Si ne n'est déjà fait, [créez un cluster standard](cs_cluster.html#cs_cluster_ui).
-   [Ciblez avec votre interface
CLI](cs_cli_install.html#cs_cli_configure) votre cluster pour exécuter des commandes kubectl.
-   Vérifiez que l'application externe que vous désirez englober dans l'équilibrage de charge du cluster est accessible via une adresse IP publique.

Vous pouvez configurer le contrôleur Ingress afin d'acheminer le trafic réseau entrant sur le domaine fourni par IBM vers les applications situées en dehors de votre cluster. Si vous désirez utiliser à la place un domaine personnalisé et un certificat TLS, remplacez le domaine fourni par IBM et le certificat TLS par vos [domaine personnalisé et certificat TLS](#custom_domain_cert).

1.  Configurez un noeud final Kubernetes définissant l'emplacement externe de l'application que vous désirez inclure dans l'équilibrage de charge du cluster.
    1.  Ouvrez l'éditeur de votre choix et créez un fichier de configuration de noeud final nommé, par exemple, `myexternalendpoint.yaml`.
    2.  Définissez votre noeud final externe. Incluez toutes les adresses IP publiques et les ports pouvant être utilisés pour accéder à votre application externe.

        ```
        kind: Endpoints
        apiVersion: v1
        metadata:
          name: <myendpointname>
        subsets:
          - addresses:
              - ip: <externalIP1>
              - ip: <externalIP2>
            ports:
              - port: <externalport>
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Remplacez <em>&lt;myendpointname&gt;</em> par le nom de votre noeud final Kubernetes.</td>
        </tr>
        <tr>
        <td><code>ip</code></td>
        <td>Remplacez <em>&lt;externalIP&gt;</em> par les adresses IP publiques permettant de se connecter à votre application externe.</td>
         </tr>
         <td><code>port</code></td>
         <td>Remplacez <em>&lt;externalport&gt;</em> par le port sur lequel votre application externe est à l'écoute.</td>
         </tbody></table>

    3.  Sauvegardez vos modifications.
    4.  Créez le noeud final Kubernetes pour votre cluster.

        ```
        kubectl apply -f myexternalendpoint.yaml
        ```
        {: pre}

2.  Créez un service Kubernetes pour votre cluster et configure-le pour acheminer les
requêtes entrantes au noeud final externe créé auparavant.
    1.  Ouvrez l'éditeur de votre choix et créez un fichier de configuration de service nommé, par exemple, `myexternalservice.yaml`.
    2.  Définissez le service.

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <myexternalservice>
          labels:
              name: <myendpointname>
        spec:
          ports:
           - protocol: TCP
             port: 8080
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>metadata/name</code></td>
        <td>Remplacez <em>&lt;myexternalservice&gt;</em> par le nom de votre service Kubernetes.</td>
        </tr>
        <tr>
        <td><code>labels/name</code></td>
        <td>Remplacez <em>&lt;myendpointname&gt;</em> par le nom du noeud final Kubernetes que vous avez créé plus tôt.</td>
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

3.  Affichez le domaine fourni par IBM et le certificat TLS. Remplacez _&lt;mycluster&gt;_ par le nom du cluster sur lequel l'application est déployée.

    ```
    bx cs cluster-get <mycluster>
    ```
    {: pre}

    La sortie de votre interface CLI sera similaire à ceci.

    ```
    Retrieving cluster <mycluster>...
    OK
    Name:    <mycluster>
    ID:    b9c6b00dc0aa487f97123440b4895f2d
    Created:  2017-04-26T19:47:08+0000
    State:    normal
    Master URL:  https://169.57.40.165:1931
    Ingress subdomain:  <ibmdomain>
    Ingress secret:  <ibmtlssecret>
    Workers:  3
    ```
    {: screen}

    Le domaine fourni par IBM figure dans la zone **Ingress subdomain** et le certificat fourni par IBM, dans la zone **Ingress secret**.

4.  Créez une ressource Ingress. Les ressources Ingress définissent les règles de routage pour le service Kubernetes que vous avez créé pour votre application et sont utilisées par le contrôleur Ingress pour acheminer le trafic réseau entrant au service. Vous pouvez utiliser une même ressource Ingress pour définir des règles de routage pour plusieurs applications externes dans la mesure où chaque application est exposée avec son nom final externe via un service Kubernetes dans le cluster.
    1.  Ouvrez l'éditeur de votre choix et créez un fichier de configuration Ingress nommé, par exemple, `myexternalingress.yaml`.
    2.  Définissez dans votre fichier de configuration une ressource Ingress utilisant le domaine fourni par IBM et le certificat TLS pour acheminer le trafic réseau entrant à votre application externe en utilisant le noeud final externe défini auparavant. Vous pouvez définir pour chaque service un chemin d'accès individuel en l'ajoutant au domaine fourni par IBM ou au domaine personnalisé de manière à créer un chemin unique vers votre application. Par exemple, `https://ingress_domain/myapp`. Lorsque vous indiquez cette route dans un navigateur Web, le trafic réseau est acheminé au contrôleur Ingress. Le contrôleur Ingress recherche le service associé et
lui envoie le trafic réseau, ainsi qu'à l'application externe.

        **Remarque :** il est important que l'application soit à l'écoute sur le chemin que vous avez défini dans la ressource Ingress. Si tel n'est pas le cas, le trafic réseau ne peut pas être acheminé vers l'application. La plupart des applications ne sont pas à l'écoute sur un chemin spécifique, mais utilisent le chemin racine et un port spécifique. Dans ce cas, définissez le chemin racine sous la forme /, sans spécifier de chemin individuel pour votre application.

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: <myingressname>
        spec:
          tls:
          - hosts:
            - <ibmdomain>
            secretName: <ibmtlssecret>
          rules:
          - host: <ibmdomain>
            http:
              paths:
              - path: /<myexternalservicepath1>
                backend:
                  serviceName: <myservice1>
                  servicePort: 80
              - path: /<myexternalservicepath2>
                backend:
                  serviceName: <myexternalservice2>
                  servicePort: 80
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Remplacez <em>&lt;myingressname&gt;</em> par le nom de la ressource Ingress.</td>
        </tr>
        <tr>
        <td><code>tls/hosts</code></td>
        <td>Remplacez <em>&lt;ibmdomain&gt;</em> par le nom <strong>Ingress subdomain</strong> fourni par IBM à l'étape précédente. Ce domaine est configuré pour terminaison TLS.

        </br></br>
        <strong>Remarque :</strong> n'utilisez pas le signe &ast; pour votre hôte ou laissez vide la propriété de l'hôte afin d'éviter des échecs lors de la création Ingress.</td>
        </tr>
        <tr>
        <td><code>tls/secretName</code></td>
        <td>Remplacez <em>&lt;ibmtlssecret&gt;</em> par la valeur <strong>Ingress secret</strong> fournie par IBM à l'étape précédente. Ce certificat gère la terminaison TLS.</td>
        </tr>
        <tr>
        <td><code>rules/host</code></td>
        <td>Remplacez <em>&lt;ibmdomain&gt;</em> par le nom <strong>Ingress subdomain</strong> fourni par IBM à l'étape précédente. Ce domaine est configuré pour terminaison TLS.

        </br></br>
        <strong>Remarque :</strong> n'utilisez pas le signe &ast; pour votre hôte ou laissez vide la propriété de l'hôte afin d'éviter des échecs lors de la création Ingress.</td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>Remplacez <em>&lt;myexternalservicepath&gt;</em> par une barre oblique, ou par le chemin unique sur lequel votre application externe est à l'écoute, afin que ce trafic réseau puisse être réacheminé à l'application.

        </br>
        Vous pouvez définir pour chaque service Kubernetes un chemin d'accès individuel en l'ajoutant à votre domaine de manière à créer un chemin unique vers votre application. Par exemple, <code>https://ibmdomain/myservicepath1</code>. Lorsque vous indiquez cette route dans un navigateur Web, le trafic réseau est acheminé au contrôleur Ingress. Le contrôleur Ingress recherche le service associé et envoie le trafic réseau à l'application externe en utilisant ce même chemin. L'application doit être configurée pour être à l'écoute sur ce chemin afin de recevoir le trafic réseau entrant.

        </br></br>
        De nombreuses applications ne sont pas à l'écoute sur un chemin spécifique mais utilisent le chemin racine et un port spécifique. Dans ce cas, définissez le chemin racine sous la forme
<code>/</code>, sans spécifier de chemin individuel pour votre application.

        </br></br>
        <strong>Astuce :</strong> si vous désirez configurer Ingress pour être à l'écoute sur un chemin différent de celui où l'application est à l'écoute, vous pouvez utiliser l'[annotation rewrite](cs_annotations.html#rewrite-path) pour définir le routage approprié vers votre application.</td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td>Remplacez <em>&lt;myexternalservice&gt;</em> par le nom du service que vous avez utilisé lorsque vous avez créé le service Kubernetes pour votre application externe.</td>
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

5.  Vérifiez que la création de la ressource Ingress a abouti. Remplacez _&lt;myingressname&gt;_ par le nom de la ressource Ingress que vous avez créée plus tôt.

    ```
    kubectl describe ingress <myingressname>
    ```
    {: pre}

    **Remarque :** quelques minutes peuvent s'écouler avant que la ressource Ingress ne soit correctement créée et que l'application soit disponible sur l'Internet public.

6.  Accédez à votre application externe.
    1.  Ouvrez le navigateur Web de votre choix.
    2.  Entrez l'URL pour accéder à votre application externe.

        ```
        https://<ibmdomain>/<myexternalservicepath>
        ```
        {: codeblock}



#### Ouverture de ports dans l'équilibreur de charge Ingress
{: #opening_ingress_ports}

Par défaut, seuls les ports 80 et 443 sont exposés dans l'équilibreur de charge Ingress. Pour exposer d'autres ports, vous pouvez éditer la ressource de mappe de configuration ibm-cloud-provider-ingress-cm.

1.  Créez une version locale du fichier de configuration pour la ressource de mappe de configuration ibm-cloud-provider-ingress-cm. Ajoutez une section <code>data</code> et spécifiez les ports publics 80 et 443 ainsi que tous les autres ports que vous voulez ajouter au fichier de mappe de configuration, séparés par un point-virgule (;).

 Remarque : lorsque vous spécifiez les ports, 80 et 443 doivent également être inclus pour rester ouverts. Tout port non spécifié est fermé.

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

2. Appliquez le fichier de configuration.

 ```
 kubectl apply -f <path/to/configmap.yaml>
 ```
 {: pre}

3. Vérifiez que le fichier de configuration a été appliqué.

 ```
 kubectl describe cm ibm-cloud-provider-ingress-cm -n kube-system
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

  public-ports: "80;443;<port3>"
 ```
 {: codeblock}

Pour plus d'informations sur les ressources de mappe de configuration, voir la [documentation Kubernetes](https://kubernetes-v1-4.github.io/docs/user-guide/configmap/).



#### Configuration de protocoles et de chiffrements SSL au niveau HTTP
{: #ssl_protocols_ciphers}

Activez les protocoles et chiffrements SSL au niveau HTTP global en éditant la mappe de configuration `ibm-cloud-provider-ingress-cm`.

Pa défaut, les valeurs suivantes sont utilisées pour et les protocoles et chiffrements SSL :

```
ssl-protocols : "TLSv1 TLSv1.1 TLSv1.2"
ssl-ciphers : "HIGH:!aNULL:!MD5"
```
{: codeblock}

Pour plus d'informations sur ces paramètres, voir la documentation NGINX pour [ssl-protocols ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](http://nginx.org/en/docs/http/ngx_http_ssl_module.html#ssl_protocols) et [ssl-ciphers ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](http://nginx.org/en/docs/http/ngx_http_ssl_module.html#ssl_ciphers).

Pour modifier les valeurs par défaut :
1. Créez une version locale du fichier de configuration pour la ressource de mappe de configuration ibm-cloud-provider-ingress-cm. 

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

2. Appliquez le fichier de configuration.

 ```
 kubectl apply -f <path/to/configmap.yaml>
 ```
 {: pre}

3. Vérifiez que le fichier de configuration a été appliqué.

 ```
 kubectl describe cm ibm-cloud-provider-ingress-cm -n kube-system
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


#### Activation du contrôleur Ingress privé
{: #private_ingress}

Lorsque vous créez un cluster standard, un contrôleur Ingress privé est automatiquement créé mais pas automatiquement activé. Pour pouvoir utiliser le contrôleur Ingress privé, vous devez l'activer avec l'adresse IP portable privée préaffectée fournie par IBM ou votre propre adresse IP portable privée. **Remarque** : si vous avez utilisé l'indicateur `--no-subnet` lors de la création du cluster, vous devez ajouter un sous-réseau portable privé ou un sous-réseau géré par l'utilisateur avant d'activer le contrôleur Ingress privé. Pour plus d'informations, voir [Demande de sous-réseaux supplémentaires pour votre cluster](cs_cluster.html#add_subnet).

Avant de commencer :

-   Si ne n'est déjà fait, [créez un cluster standard](cs_cluster.html#cs_cluster_ui).
-   [Ciblez
votre interface de ligne de commande](cs_cli_install.html#cs_cli_configure) vers votre cluster.

Pour activer le contrôleur Ingress privé à l'aide de l'adresse IP portable privée préaffectée fournie par IBM :

1. Répertoriez les contrôleurs Ingress disponibles dans votre cluster afin de vous procurer l'ID ALB du contrôleur Ingress privé. Remplacez <em>&lt;cluser_name&gt;</em> par le nom du cluster sur lequel l'application que vous voulez exposer est déployée.

    ```
    bx cs albs --cluster <my_cluster>
    ```
    {: pre}

    La zone **Status** du contrôleur Ingress privé a la valeur _disabled_.
    ```
    ALB ID                                            Enabled   Status     Type      ALB IP
    private-cr6d779503319d419ea3b4ab171d12c3b8-alb1   false     disabled   private   -
    public-cr6d779503319d419ea3b4ab171d12c3b8-alb1    true      enabled    public    169.46.63.150
    ```
    {: screen}

2. Activez le contrôleur Ingress privé. Remplacez <em>&lt;private_ALB_ID&gt;</em> par l'ID ALB du contrôleur Ingress privé obtenu dans la sortie de l'étape précédente.

   ```
   bx cs bx cs alb-configure --albID <private_ALB_ID> --enable
   ```
   {: pre}


Pour activer le contrôleur Ingress privé à l'aide de votre propre adresse IP portable privée :

1. Configurez le sous-réseau géré par l'utilisateur de l'adresse IP que vous avez choisie pour acheminer le trafic sur le VLAN privé de votre cluster. Remplacez <em>&lt;cluser_name&gt;</em> par le nom ou l'ID du cluster sur lequel l'application que vous voulez exposer est déployée, <em>&lt;subnet_CIDR&gt;</em> par le CIDR de votre sous-réseau géré par l'utilisateur et <em>&lt;private_VLAN&gt;</em> par un ID de VLAN privé disponible. Pour obtenir l'ID d'un VLAN privé disponible, exécutez la commande `bx cs vlans`.

   ```
   bx cs cluster-user-subnet-add <cluster_name> <subnet_CIDR> <private_VLAN>
   ```
   {: pre}

2. Répertoriez les contrôleurs Ingress disponibles dans votre cluster afin de vous procurer l'ID ALB du contrôleur Ingress privé. 

    ```
    bx cs albs --cluster <my_cluster>
    ```
    {: pre}

    La zone **Status** du contrôleur Ingress privé a la valeur _disabled_.
    ```
    ALB ID                                            Enabled   Status     Type      ALB IP
    private-cr6d779503319d419ea3b4ab171d12c3b8-alb1   false     disabled   private   -
    public-cr6d779503319d419ea3b4ab171d12c3b8-alb1    true      enabled    public    169.46.63.150
    ```
    {: screen}

3. Activez le contrôleur Ingress privé. Remplacez <em>&lt;private_ALB_ID&gt;</em> par l'ID ALB du contrôleur Ingress privé obtenu dans la sortie de l'étape précédente et <em>&lt;user_ip&gt;</em> par l'adresse IP du sous-réseau géré par l'utilisateur que vous voulez utiliser.

   ```
   bx cs bx cs alb-configure --albID <private_ALB_ID> --enable --user-ip <user_ip>
   ```
   {: pre}

#### Utilisation du contrôleur Ingress privé avec un domaine personnalisé
{: #private_ingress_no_tls}

Vous pouvez configurer le contrôleur Ingress privé afin d'acheminer le trafic réseau entrant vers les applications de votre cluster en utilisant un domaine personnalisé.
{:shortdesc}

Avant de commencer, [activez le contrôleur Ingress privé](#private_ingress).

Pour configurer le contrôleur Ingress privé, procédez comme suit :

1.  Créez un domaine personnalisé. Pour créer un domaine personnalisé, gérez votre fournisseur DNS (Domain Name Service) afin d'enregistrer votre domaine personnalisé.

2.  Mappez votre domaine personnalisé à l'adresse IP privée portable du contrôleur Ingress privé fourni par IBM en ajoutant l'adresse IP en tant qu'enregistrement. Pour connaître l'adresse IP privée portable du contrôleur Ingress privé, exécutez la commande `bx cs albs --cluster <cluster_name>`.

3.  [Déployez votre application sur le cluster](#cs_apps_cli). Lorsque vous déployez l'application sur le cluster, un ou plusieurs pods sont créés pour vous et exécutent votre application dans un conteneur. Prenez soin d'ajouter un libellé à votre déploiement dans la section "metadata" de votre fichier de configuration. Ce libellé est nécessaire pour identifier tous les pods où s'exécute votre application afin de pouvoir les inclure dans l'équilibrage de charge Ingress.

4.  Créez un service Kubernetes pour l'application à exposer. Le contrôleur Ingress privé ne peut inclure votre application dans l'équilibrage de charge Ingress que si l'application est exposée via un service Kubernetes dans le cluster. 

    1.  Ouvrez l'éditeur de votre choix et créez un fichier de configuration de service nommé, par exemple, `myservice.yaml`.
    2.  Définissez un service pour l'application que vous désirez exposer au public.

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <myservice>
        spec:
          selector:
            <selectorkey>: <selectorvalue>
          ports:
           - protocol: TCP
             port: 8080
        ```
       {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Remplacez <em>&lt;service_1&gt;</em> par le nom de votre service Kubernetes.</td>
        </tr>
        <tr>
        <td><code>selector</code></td>
        <td>Entrez la paire clé de libellé (<em>&lt;selectorkey&gt;</em>) et valeur (<em>&lt;selectorvalue&gt;</em>) que vous désirez utiliser pour cibler les pods dans lesquels s'exécute votre application. Par exemple, si vous utilisez le sélecteur <code>app: code</code> suivant, tous les pods dont les métadonnées comportent ce libellé sont inclus dans l'équilibrage de charge. Entrez le même libellé que celui utilisé lorsque vous avez déployé votre application dans le cluster. </td>
         </tr>
         <td><code>port</code></td>
         <td>Port sur lequel le service est à l'écoute.</td>
         </tbody></table>

    3.  Sauvegardez vos modifications.
    4.  Créez le service dans votre cluster.

        ```
        kubectl apply -f myservice.yaml
        ```
        {: pre}

    5.  Répétez ces étapes pour chaque application que vous voulez exposer sur le réseau privé.
7.  Créez une ressource Ingress. Les ressources Ingress définissent les règles de routage pour le service Kubernetes que vous avez créé pour votre application et sont utilisées par le contrôleur Ingress pour acheminer le trafic réseau entrant au service. Vous pouvez utiliser une même ressource Ingress pour définir des règles de routage pour plusieurs applications dans la mesure où chaque application est exposée via un service Kubernetes dans le cluster.
    1.  Ouvrez l'éditeur de votre choix et créez un fichier de configuration Ingress nommé, par exemple, `myingress.yaml`.
    2.  Définissez dans votre fichier de configuration une ressource Ingress utilisant votre domaine personnalisé pour acheminer le trafic réseau entrant vers vos services. Vous pouvez définir pour chaque service un chemin d'accès individuel en l'ajoutant à votre domaine personnalisé de manière à créer un chemin unique vers votre application. Par exemple, `https://mydomain/myapp`. Lorsque vous indiquez cette route dans un navigateur Web, le trafic réseau est acheminé au contrôleur Ingress. Le contrôleur Ingress recherche le service associé et lui envoie le trafic réseau, ainsi qu'aux pods sur lesquels l'application s'exécute.

        **Remarque :** il est important que l'application soit à l'écoute sur le chemin que vous avez défini dans la ressource Ingress. Si tel n'est pas le cas, le trafic réseau ne peut pas être acheminé vers l'application. La plupart des applications ne sont pas à l'écoute sur un chemin spécifique, mais utilisent le chemin racine et un port spécifique. Dans ce cas, définissez le chemin racine sous la forme `/`, sans spécifier de chemin individuel pour votre application.

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: <myingressname>
          annotations:
            ingress.bluemix.net/ALB-ID: "<private_ALB_ID>"
        spec:
          rules:
          - host: <mycustomdomain>
            http:
              paths:
              - path: /<myservicepath1>
                backend:
                  serviceName: <myservice1>
                  servicePort: 80
              - path: /<myservicepath2>
                backend:
                  serviceName: <myservice2>
                  servicePort: 80
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Remplacez <em>&lt;myingressname&gt;</em> par le nom de votre ressource Ingress.</td>
        </tr>
        <tr>
        <td><code>ingress.bluemix.net/ALB-ID</code></td>
        <td>Remplacez <em>&lt;private_ALB_ID&gt;</em> par l'ID ALB de votre contrôleur Ingress privé. Exécutez <code>bx cs albs --cluster <my_cluster></code> pour obtenir cet ID ALB.</td>
        </tr>
        <td><code>host</code></td>
        <td>Remplacez <em>&lt;mycustomdomain&gt;</em> par votre domaine personnalisé.

        </br></br>
        <strong>Remarque :</strong> n'utilisez pas le signe &ast; pour votre hôte ou laissez vide la propriété de l'hôte afin d'éviter des échecs lors de la création Ingress.
        </td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>Remplacez <em>&lt;myservicepath1&gt;</em> par une barre oblique, ou par le chemin unique sur lequel votre application est à l'écoute, afin que ce trafic réseau puisse être réacheminé à l'application.

        </br>
        Pour chaque service Kubernetes, vous pouvez définir un chemin individuel qui s'ajoute au domaine personnalisé afin de constituer un chemin unique vers votre application. Par exemple, <code>custom_domain/myservicepath1</code>. Lorsque vous indiquez cette route dans un navigateur Web, le trafic réseau est acheminé au contrôleur Ingress. Le contrôleur Ingress recherche le service associé et lui envoie le trafic réseau, ainsi qu'aux pods sur lesquels l'application s'exécute, en utilisant ce même chemin. L'application doit être configurée pour être à l'écoute sur ce chemin afin de recevoir le trafic réseau entrant.

        </br>
        De nombreuses applications ne sont pas à l'écoute sur un chemin spécifique mais utilisent le chemin racine et un port spécifique. Dans ce cas, définissez le chemin racine sous la forme
<code>/</code>, sans spécifier de chemin individuel pour votre application.

        </br></br>
        Exemples : <ul><li>Pour <code>https://mycustomdomain/</code>, entrez <code>/</code> pour le chemin.</li><li>Pour <code>https://mycustomdomain/myservicepath</code>, entrez <code>/myservicepath</code> pour le chemin.</li></ul>
        <strong>Astuce :</strong> si vous désirez configurer Ingress pour être à l'écoute sur un chemin différent de celui où l'application est à l'écoute, vous pouvez utiliser l'[annotation rewrite](cs_annotations.html#rewrite-path) pour définir le routage approprié vers votre application.
        </td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td>Remplacez <em>&lt;myservice1&gt;</em> par le nom du service que vous avez utilisé lors de la création du service Kubernetes pour votre application.</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>Port sur lequel votre service est à l'écoute. Utilisez le même port que celui que vous avez défini lors de la création du service Kubernetes pour votre application.</td>
        </tr>
        </tbody></table>

    3.  Sauvegardez vos modifications.
    4.  Créez la ressource Ingress pour votre cluster.

        ```
        kubectl apply -f myingress.yaml
        ```
        {: pre}

8.  Vérifiez que la création de la ressource Ingress a abouti. Remplacez <em>&lt;myingressname&gt;</em> par le nom de la ressource Ingress que vous avez créée à l'étape précédente.

    ```
    kubectl describe ingress <myingressname>
    ```
    {: pre}

    **Remarque :** quelques seconds peuvent s'écouler avant que la ressource Ingress ne soit correctement créée et que l'application soit disponible.

9.  Accédez à votre application depuis Internet.
    1.  Ouvrez le navigateur Web de votre choix.
    2.  Entrez l'URL du service d'application auquel vous désirez accéder.

        ```
        http://<mycustomdomain>/<myservicepath1>
        ```
        {: codeblock}

#### Utilisation du contrôleur Ingress privé avec un domaine personnalisé et un certificat TLS
{: #private_ingress_tls}

Vous pouvez configurer le contrôleur Ingress privé afin d'acheminer le trafic réseau entrant vers les applications de votre cluster et d'utiliser votre propre certificat TLS pour gérer la terminaison TLS tout en utilisant votre domaine personnalisé.
{:shortdesc}

Avant de commencer, [activez le contrôleur Ingress privé](#private_ingress).

Pour configurer le contrôleur Ingress, procédez comme suit :

1.  Créez un domaine personnalisé. Pour créer un domaine personnalisé, gérez votre fournisseur DNS (Domain Name Service) afin d'enregistrer votre domaine personnalisé.

2.  Mappez votre domaine personnalisé à l'adresse IP privée portable du contrôleur Ingress privé fourni par IBM en ajoutant l'adresse IP en tant qu'enregistrement. Pour connaître l'adresse IP privée portable du contrôleur Ingress privé, exécutez la commande `bx cs albs --cluster <cluster_name>`.

3.  Créez un certificat TLS et une clé pour votre domaine codés au format PEM.

4.  Stockez votre certificat et clé TLS dans une valeur confidentielle Kubernetes.
    1.  Ouvrez l'éditeur de votre choix et créez un fichier de configuration de valeur confidentielle Kubernetes nommé, par exemple, `mysecret.yaml`.
    2.  Définissez une valeur confidentielle qui utilise le certificat et la clé TLS.

        ```
        apiVersion: v1
        kind: Secret
        metadata:
          name: <mytlssecret>
        type: Opaque
        data:
          tls.crt: <tlscert>
          tls.key: <tlskey>
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Remplacez <em>&lt;mytlssecret&gt;</em> par le nom de votre valeur confidentielle Kubernetes.</td>
        </tr>
        <tr>
        <td><code>tls.cert</code></td>
        <td>Remplacez <em>&lt;tlscert&gt;</em> par votre certificat TLS personnalisé codé en base64.</td>
         </tr>
         <td><code>tls.key</code></td>
         <td>Remplacez <em>&lt;tlskey&gt;</em> par votre clé TLS personnalisée codée en base64.</td>
         </tbody></table>

    3.  Sauvegardez votre fichier de configuration.
    4.  Créez la valeur confidentielle TLS pour votre cluster.

        ```
        kubectl apply -f mysecret.yaml
        ```
        {: pre}

5.  [Déployez votre application sur le cluster](#cs_apps_cli). Lorsque vous déployez l'application sur le cluster, un ou plusieurs pods sont créés pour vous et exécutent votre application dans un conteneur. Prenez soin d'ajouter un libellé à votre déploiement dans la section "metadata" de votre fichier de configuration. Ce libellé est nécessaire pour identifier tous les pods où s'exécute votre application afin de pouvoir les inclure dans l'équilibrage de charge Ingress.

6.  Créez un service Kubernetes pour l'application à exposer. Le contrôleur Ingress privé ne peut inclure votre application dans l'équilibrage de charge Ingress que si l'application est exposée via un service Kubernetes dans le cluster. 

    1.  Ouvrez l'éditeur de votre choix et créez un fichier de configuration de service nommé, par exemple, `myservice.yaml`.
    2.  Définissez un service pour l'application que vous désirez exposer au public.

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <myservice>
        spec:
          selector:
            <selectorkey>: <selectorvalue>
          ports:
           - protocol: TCP
             port: 8080
        ```
       {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Remplacez <em>&lt;service_1&gt;</em> par le nom de votre service Kubernetes.</td>
        </tr>
        <tr>
        <td><code>selector</code></td>
        <td>Entrez la paire clé de libellé (<em>&lt;selectorkey&gt;</em>) et valeur (<em>&lt;selectorvalue&gt;</em>) que vous désirez utiliser pour cibler les pods dans lesquels s'exécute votre application. Par exemple, si vous utilisez le sélecteur <code>app: code</code> suivant, tous les pods dont les métadonnées comportent ce libellé sont inclus dans l'équilibrage de charge. Entrez le même libellé que celui utilisé lorsque vous avez déployé votre application dans le cluster. </td>
         </tr>
         <td><code>port</code></td>
         <td>Port sur lequel le service est à l'écoute.</td>
         </tbody></table>

    3.  Sauvegardez vos modifications.
    4.  Créez le service dans votre cluster.

        ```
        kubectl apply -f myservice.yaml
        ```
        {: pre}

    5.  Répétez ces étapes pour chaque application que vous voulez exposer sur le réseau privé.
7.  Créez une ressource Ingress. Les ressources Ingress définissent les règles de routage pour le service Kubernetes que vous avez créé pour votre application et sont utilisées par le contrôleur Ingress pour acheminer le trafic réseau entrant au service. Vous pouvez utiliser une même ressource Ingress pour définir des règles de routage pour plusieurs applications dans la mesure où chaque application est exposée via un service Kubernetes dans le cluster.
    1.  Ouvrez l'éditeur de votre choix et créez un fichier de configuration Ingress nommé, par exemple, `myingress.yaml`.
    2.  Définissez dans votre fichier de configuration une ressource Ingress utilisant votre domaine personnalisé pour acheminer le trafic réseau entrant à vos services et votre certificat personnalisé pour gérer la terminaison TLS. Vous pouvez définir pour chaque service un chemin d'accès individuel en l'ajoutant à votre domaine personnalisé de manière à créer un chemin unique vers votre application. Par exemple, `https://mydomain/myapp`. Lorsque vous indiquez cette route dans un navigateur Web, le trafic réseau est acheminé au contrôleur Ingress. Le contrôleur Ingress recherche le service associé et lui envoie le trafic réseau, ainsi qu'aux pods sur lesquels l'application s'exécute.

        **Remarque :** il est important que l'application soit à l'écoute sur le chemin que vous avez défini dans la ressource Ingress. Si tel n'est pas le cas, le trafic réseau ne peut pas être acheminé vers l'application. La plupart des applications ne sont pas à l'écoute sur un chemin spécifique, mais utilisent le chemin racine et un port spécifique. Dans ce cas, définissez le chemin racine sous la forme `/`, sans spécifier de chemin individuel pour votre application.

        ```
        apiVersion: extensions/v1beta1
        kind: Ingress
        metadata:
          name: <myingressname>
          annotations:
            ingress.bluemix.net/ALB-ID: "<private_ALB_ID>"
        spec:
          tls:
          - hosts:
            - <mycustomdomain>
            secretName: <mytlssecret>
          rules:
          - host: <mycustomdomain>
            http:
              paths:
              - path: /<myservicepath1>
                backend:
                  serviceName: <myservice1>
                  servicePort: 80
              - path: /<myservicepath2>
                backend:
                  serviceName: <myservice2>
                  servicePort: 80
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Remplacez <em>&lt;myingressname&gt;</em> par le nom de votre ressource Ingress.</td>
        </tr>
        <tr>
        <td><code>ingress.bluemix.net/ALB-ID</code></td>
        <td>Remplacez <em>&lt;private_ALB_ID&gt;</em> par l'ID ALB de votre contrôleur Ingress privé. Exécutez <code>bx cs albs --cluster <my_cluster></code> pour obtenir cet ID ALB.</td>
        </tr>
        <tr>
        <td><code>tls/hosts</code></td>
        <td>Remplacez <em>&lt;mycustomdomain&gt;</em> par le domaine personnalisé que vous désirez configurer pour terminaison TLS.

        </br></br>
        <strong>Remarque :</strong> n'utilisez pas le signe &ast; pour votre hôte ou laissez vide la propriété de l'hôte afin d'éviter des échecs lors de la création Ingress.</td>
        </tr>
        <tr>
        <td><code>tls/secretName</code></td>
        <td>Remplacez <em>&lt;mytlssecret&gt;</em> par le nom de la valeur confidentielle créée plus tôt qui contient votre certificat et votre clé TLS personnalisée pour gestion de la terminaison TLS pour votre domaine personnalisé.
        </tr>
        <tr>
        <td><code>host</code></td>
        <td>Remplacez <em>&lt;mycustomdomain&gt;</em> par le domaine personnalisé que vous désirez configurer pour terminaison TLS.

        </br></br>
        <strong>Remarque :</strong> n'utilisez pas le signe &ast; pour votre hôte ou laissez vide la propriété de l'hôte afin d'éviter des échecs lors de la création Ingress.
        </td>
        </tr>
        <tr>
        <td><code>path</code></td>
        <td>Remplacez <em>&lt;myservicepath1&gt;</em> par une barre oblique, ou par le chemin unique sur lequel votre application est à l'écoute, afin que ce trafic réseau puisse être réacheminé à l'application.

        </br>
        Pour chaque service Kubernetes, vous pouvez définir un chemin individuel qui s'ajoute au domaine fourni par IBM afin de constituer un chemin unique vers votre application. Par exemple, <code>ingress_domain/myservicepath1</code>. Lorsque vous indiquez cette route dans un navigateur Web, le trafic réseau est acheminé au contrôleur Ingress. Le contrôleur Ingress recherche le service associé et lui envoie le trafic réseau, ainsi qu'aux pods sur lesquels l'application s'exécute, en utilisant ce même chemin. L'application doit être configurée pour être à l'écoute sur ce chemin afin de recevoir le trafic réseau entrant.

        </br>
        De nombreuses applications ne sont pas à l'écoute sur un chemin spécifique mais utilisent le chemin racine et un port spécifique. Dans ce cas, définissez le chemin racine sous la forme
<code>/</code>, sans spécifier de chemin individuel pour votre application.

        </br></br>
        Exemples : <ul><li>Pour <code>https://mycustomdomain/</code>, entrez <code>/</code> pour le chemin.</li><li>Pour <code>https://mycustomdomain/myservicepath</code>, entrez <code>/myservicepath</code> pour le chemin.</li></ul>
        <strong>Astuce :</strong> si vous désirez configurer Ingress pour être à l'écoute sur un chemin différent de celui où l'application est à l'écoute, vous pouvez utiliser l'[annotation rewrite](cs_annotations.html#rewrite-path) pour définir le routage approprié vers votre application.
        </td>
        </tr>
        <tr>
        <td><code>serviceName</code></td>
        <td>Remplacez <em>&lt;myservice1&gt;</em> par le nom du service que vous avez utilisé lors de la création du service Kubernetes pour votre application.</td>
        </tr>
        <tr>
        <td><code>servicePort</code></td>
        <td>Port sur lequel votre service est à l'écoute. Utilisez le même port que celui que vous avez défini lors de la création du service Kubernetes pour votre application.</td>
        </tr>
        </tbody></table>

    3.  Sauvegardez vos modifications.
    4.  Créez la ressource Ingress pour votre cluster.

        ```
        kubectl apply -f myingress.yaml
        ```
        {: pre}

8.  Vérifiez que la création de la ressource Ingress a abouti. Remplacez <em>&lt;myingressname&gt;</em> par le nom de la ressource Ingress que vous avez créée plus tôt.

    ```
    kubectl describe ingress <myingressname>
    ```
    {: pre}

    **Remarque :** quelques seconds peuvent s'écouler avant que la ressource Ingress ne soit correctement créée et que l'application soit disponible.

9.  Accédez à votre application depuis Internet.
    1.  Ouvrez le navigateur Web de votre choix.
    2.  Entrez l'URL du service d'application auquel vous désirez accéder.

        ```
        https://<mycustomdomain>/<myservicepath1>
        ```
        {: codeblock}

## Gestion d'adresses IP et de sous-réseaux
{: #cs_cluster_ip_subnet}

Vous pouvez utiliser des sous-réseaux et des adresses IP publiques et privés portables pour exposer des applications dans votre cluster et les rendre accessibles via Internet ou sur un réseau privé.
{:shortdesc}

Dans {{site.data.keyword.containershort_notm}}, vous pouvez ajouter des adresses IP portables stables pour les services Kubernetes en adjoignant des sous-réseaux au cluster. Lorsque vous créez un cluster standard, {{site.data.keyword.containershort_notm}} lui alloue automatiquement un sous-réseau public portable avec 5 adresses IP publiques portables et un sous-réseau privé portable avec 5 adresses IP privées portables. Les adresses IP portables sont statiques et ne changent pas lorsqu'un noeud worker, ou même le cluster, est retiré.

 Deux des adresses IP portables, une publique et une privée, sont utilisées pour les [contrôleurs Ingress](#cs_apps_public_ingress) que vous pouvez utiliser afin d'exposer plusieurs applications dans votre cluster. 4 adresses IP publiques portables et 4 adresses IP privées portables peuvent être utilisées pour exposer des applications en [créant un service d'équilibreur de charge](#cs_apps_public_load_balancer).

**Remarque :** les adresses IP publiques portables sont facturées sur une base mensuelle. Si vous décidez de retirer les adresses IP portables après la mise en place de votre cluster, vous devez quand même payer les frais mensuels, même si vous ne les avez utilisées que brièvement.



1.  Créez un fichier de configuration de service Kubernetes nommé `myservice.yaml` et définissez un service de type `LoadBalancer` avec une adresse IP d'équilibreur de charge factice. L'exemple suivant utilise l'adresse IP 1.1.1.1 comme adresse IP de l'équilibreur de charge.

    ```
    apiVersion: v1
    kind: Service
    metadata:
      labels:
        run: myservice
      name: myservice
      namespace: default
    spec:
      ports:
      - port: 80
        protocol: TCP
        targetPort: 80
      selector:
        run: myservice
      sessionAffinity: None
      type: LoadBalancer
      loadBalancerIP: 1.1.1.1
    ```
    {: codeblock}

2.  Créez le service dans votre cluster.

    ```
    kubectl apply -f myservice.yaml
    ```
    {: pre}

3.  Inspectez le service.

    ```
    kubectl describe service myservice
    ```
    {: pre}

    **Remarque :** la création de ce service échoue car le maître Kubernetes ne parvient pas à localiser l'adresse IP de l'équilibreur de charge spécifié dans la mappe de configuration Kubernetes. Lorsque vous exécutez cette commande, le message d'erreur s'affiche, ainsi que la liste des adresses IP publiques disponibles pour le cluster.

    ```
    Erreur sur l'équilibreur de charge cloud a8bfa26552e8511e7bee4324285f6a4a pour le service default/myservice portant l'UID 8bfa2655-2e85-11e7-bee4-324285f6a4af: L'adresse IP 1.1.1.1 du fournisseur cloud demandée n'est pas disponible. Les adresses IP suivantes de fournisseur cloud sont disponibles : <list_of_IP_addresses>
    ```
    {: screen}




1.  Créez un fichier de configuration de service Kubernetes nommé `myservice.yaml` et définissez un service de type `LoadBalancer` avec une adresse IP d'équilibreur de charge factice. L'exemple suivant utilise l'adresse IP 1.1.1.1 comme adresse IP de l'équilibreur de charge.

    ```
    apiVersion: v1
    kind: Service
    metadata:
      labels:
        run: myservice
      name: myservice
      namespace: default
    spec:
      ports:
      - port: 80
        protocol: TCP
        targetPort: 80
      selector:
        run: myservice
      sessionAffinity: None
      type: LoadBalancer
      loadBalancerIP: 1.1.1.1
    ```
    {: codeblock}

2.  Créez le service dans votre cluster.

    ```
    kubectl apply -f myservice.yaml
    ```
    {: pre}

3.  Inspectez le service.

    ```
    kubectl describe service myservice
    ```
    {: pre}

    **Remarque :** la création de ce service échoue car le maître Kubernetes ne parvient pas à localiser l'adresse IP de l'équilibreur de charge spécifié dans la mappe de configuration Kubernetes. Lorsque vous exécutez cette commande, le message d'erreur s'affiche, ainsi que la liste des adresses IP publiques disponibles pour le cluster.

    ```
    Erreur sur l'équilibreur de charge cloud a8bfa26552e8511e7bee4324285f6a4a pour le service default/myservice portant l'UID 8bfa2655-2e85-11e7-bee4-324285f6a4af: L'adresse IP 1.1.1.1 du fournisseur cloud demandée n'est pas disponible. Les adresses IP suivantes de fournisseur cloud sont disponibles : <list_of_IP_addresses>
    ```
    {: screen}

</staging>

### Libération des adresses IP utilisées
{: #freeup_ip}

Vous pouvez libérer une adresse IP portable utilisée en supprimant le service d'équilibreur de charge qui l'utilise.

[Avant de commencer, définissez le contexte du cluster que vous désirez utiliser.](cs_cli_install.html#cs_cli_configure)

1.  Répertoriez les services disponibles dans votre cluster.

    ```
    kubectl get services
    ```
    {: pre}

2.  Supprimez le service d'équilibreur de charge qui utilise une adresse IP publique ou privée.

    ```
    kubectl delete service <myservice>
    ```
    {: pre}

<br />


## Déploiement d'applications depuis l'interface graphique
{: #cs_apps_ui}

Lorsque vous déployez une application dans votre cluster à l'aide du tableau de bord Kubernetes, une ressource de déploiement est automatiquement générée qui crée, met à jour et gère les pods de votre cluster.
{:shortdesc}

Avant de commencer :

-   Installez les
[interfaces de ligne de
commande](cs_cli_install.html#cs_cli_install) requises.
-   [Ciblez
votre interface de ligne de commande](cs_cli_install.html#cs_cli_configure) vers votre cluster.

Pour déployer votre application :

1.  [Ouvrez le tableau de bord Kubernetes](#cs_cli_dashboard).
2.  Dans le tableau de bord Kubernetes, cliquez sur **+ Créer**.
3.  Sélectionnez **Spécifier les détails de l'application ci-dessous** pour entrer les détails de l'application sur l'interface graphique ou **Télécharger un fichier YAML ou JSON** pour télécharger le [fichier de configuration de votre application ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-container/). Utilisez [cet exemple de fichier YAML![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://github.com/IBM-Bluemix/kube-samples/blob/master/deploy-apps-clusters/deploy-ibmliberty.yaml) pour déployer un conteneur depuis l'image **ibmliberty** dans la région Sud des Etats-Unis.
4.  Dans le tableau de bord Kubernetes, cliquez sur **Déploiements** pour vérifier que le déploiement a bien été créé.
5.  Si vous avez rendu votre application disponible au public en utilisant un service de port de noeud, un service d'équilibreur de charge ou Ingress, vérifiez que vous pouvez accéder à l'application.

<br />


## Déploiement d'applications depuis l'interface CLI
{: #cs_apps_cli}

Après avoir créé un cluster, vous pouvez y déployer une application à l'aide de l'interface CLI de Kubernetes.
{:shortdesc}

Avant de commencer :

-   Installez les
[interfaces de ligne de
commande](cs_cli_install.html#cs_cli_install) requises.
-   [Ciblez
votre interface de ligne de commande](cs_cli_install.html#cs_cli_configure) vers votre cluster.

Pour déployer votre application :

1.  Créez un fichier de configuration basé sur les [pratiques Kubernetes recommandées ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/concepts/configuration/overview/). En général, un fichier de configuration contient des informations de configuration détaillées pour chacune des ressources que vous créez dans Kubernetes. Votre script peut inclure une ou plusieurs des sections suivantes :

    -   [Deployments ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) : définit la création des pods et des jeux de répliques. Un pod contient une application conteneurisée unique et les jeux de répliques contrôlent plusieurs instances de pods.

    -   [Service ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/concepts/services-networking/service/) : fournit un accès frontal aux pods en utilisant une adresse IP publique de noeud worker ou d'équilibreur de charge, ou une route Ingress publique.

    -   [Ingress ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/concepts/services-networking/ingress/) : spécifie un type d'équilibreur de charge qui fournit des routes permettant d'accéder publiquement à l'application.

2.  Exécutez le fichier de configuration dans un contexte de cluster.

    ```
    kubectl apply -f deployment_script_location
    ```
    {: pre}

3.  Si vous avez rendu votre application disponible au public en utilisant un service de port de noeud, un service d'équilibreur de charge ou Ingress, vérifiez que vous pouvez accéder à l'application.

<br />





## Mise à l'échelle des applications
{: #cs_apps_scaling}

<!--Horizontal auto-scaling is not working at the moment due to a port issue with heapster. The dev team is working on a fix. We pulled out this content from the public docs. It is only visible in staging right now.-->

Déployez des applications en cloud qui répondent aux fluctuations de la demande pour vos applications et qui n'utilisent des ressources qu'en cas de besoin. La mise à l'échelle automatique étend ou réduit automatiquement le nombre d'instances de vos applications en fonction de l'unité centrale.
{:shortdesc}

Avant de commencer, [ciblez avec votre interface de ligne de commande](cs_cli_install.html#cs_cli_configure) votre cluster.

**Remarque :** recherchez-vous des informations sur la mise à l'échelle d'applications Cloud Foundry ? Consultez [IBM - Mise à l'échelle automatique pour {{site.data.keyword.Bluemix_notm}}](/docs/services/Auto-Scaling/index.html).

Avec Kubernetes, vous pouvez activer la [mise à l'échelle horizontale de pod ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/) pour dimensionner vos applications en fonction de l'UC.

1.  Déployez votre application dans le cluster depuis l'interface CLI. Lorsque vous déployez votre application vous devez solliciter une unité centrale (cpu).

    ```
    kubectl run <name> --image=<image> --requests=cpu=<cpu> --expose --port=<port_number>
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

    **Remarque :** Pour les déploiements plus complexes, vous devrez éventuellement créer un [fichier de configuration](#cs_apps_cli).
2.  Créez un service de mise à l'échelle automatique de pod et définissez votre règle. Pour plus d'informations sur l'utilisation de la commande `kubetcl autoscale`, voir [la documentation Kubernetes ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/user-guide/kubectl/v1.5/#autoscale).

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


## Gestion des déploiements tournants
{: #cs_apps_rolling}

Vous pouvez gérer un déploiement tournant automatique et contrôlé de vos modifications. S'il ne correspond pas à ce que vous anticipiez, vous pouvez rétromigrer le déploiement vers la dernière révision.
{:shortdesc}

Avant de commencer, créez un [déploiement](#cs_apps_cli).

1.  [Déployez ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/user-guide/kubectl/v1.5/#rollout) une modification. Par exemple, vous souhaiterez peut-être modifier l'image que vous avez utilisée dans votre déploiement initial.

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

    Lorsque vous exécutez les commandes, la modification est immédiatement appliquée et consignée dans l'historique des modifications tournantes.

2.  Vérifiez le statut de votre déploiement.

    ```
    kubectl rollout status deployments/<deployment_name>
    ```
    {: pre}

3.  Rétromigrez une modification.
    1.  Affichez l'historique des modifications tournantes pour le déploiement et identifiez le numéro de révision de votre dernier déploiement.

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


## Ajout de services {{site.data.keyword.Bluemix_notm}}
{: #cs_apps_service}

Des valeurs confidentielles Kubernetes chiffrées sont utilisées pour stocker les informations détaillées du service {{site.data.keyword.Bluemix_notm}} et ses données d'identification, ainsi que pour permettre une communication sécurisée entre le service et le cluster. En tant qu'utilisateur du cluster,
vous pouvez accéder à cette valeur confidentielle en la montant en tant que volume dans un pod.
{:shortdesc}

Avant de commencer, [ciblez avec votre interface de ligne de commande](cs_cli_install.html#cs_cli_configure) votre cluster. Vérifiez que le service {{site.data.keyword.Bluemix_notm}} que vous souhaitez utiliser dans votre application
a été [ajouté au cluster](cs_cluster.html#cs_cluster_service) par l'administrateur du cluster.

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

5.  Créez le pod et montez le volume secret.

    ```
    kubectl apply -f <yaml_path>
    ```
    {: pre}

6.  Vérifiez que le pod a bien été créé.

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


## Création de stockage persistant
{: #cs_apps_volume_claim}

Créez une réservation de volume persistant (pvc) pour mettre à disposition un stockage de fichiers NFS pour votre cluster. Montez ensuite cette réservation sur un pod pour garantir la disponibilité des données même en cas de panne ou d'arrêt du pod.
{:shortdesc}

Le stockage de fichiers NFS où est sauvegardé le volume persistant est mis en cluster par IBM pour une haute disponibilité de vos données.


Lorsqu'un compte {{site.data.keyword.Bluemix_dedicated_notm}} est [activé pour des clusters](cs_ov.html#setup_dedicated), au lieu d'utiliser cette tâche, vous devez[ouvrir un ticket de demande de service](/docs/support/index.html#contacting-support). L'ouverture d'un ticket, vous permet de demander une copie de sauvegarde de vos volumes, une restauration de vos volumes et autres fonctions de stockage.


1.  Examinez les classes de stockage disponibles. {{site.data.keyword.containerlong}} fournit huit classes de stockage prédéfinies afin que l'administrateur du cluster n'ait pas besoin d'en créer. La classe de stockage `ibmc-file-bronze` est identique à la classe de stockage `default`.

    ```
    kubectl get storageclasses
    ```
    {: pre}

    ```
    $ kubectl get storageclasses
    NAME                         TYPE
    default                      ibm.io/ibmc-file   
    ibmc-file-bronze (default)   ibm.io/ibmc-file   
    ibmc-file-custom             ibm.io/ibmc-file
    ibmc-file-gold               ibm.io/ibmc-file   
    ibmc-file-retain-bronze      ibm.io/ibmc-file   
    ibmc-file-retain-custom      ibm.io/ibmc-file   
    ibmc-file-retain-gold        ibm.io/ibmc-file   
    ibmc-file-retain-silver      ibm.io/ibmc-file   
    ibmc-file-silver             ibm.io/ibmc-file
    ```
    {: screen}

2.  Déterminez si vous souhaitez sauvegarder vos données et le partage de fichiers NFS après avoir supprimé la réservation de volume persistant (pvc). Pour conserver vos données, choisissez une classe de stockage `retain`. Si vous souhaitez que les données et votre partage de fichiers soient supprimés en même temps que la réservation pvc, choisissez une classe de stockage sans `retain`.

3.  Examinez les opérations d'entrée-sortie par seconde (IOPS) d'une classe de stockage et les tailles de stockage disponibles.
    - Les classes de stockage bronze, silver et gold utilisent du stockage Endurance et ont une seule opération d'entrée-sortie par seconde (IOPS) par Go définie pour chaque classe. Le nombre total d'opérations IOPS dépend de la taille du stockage. Par exemple, 1000Gi pvc à 4 IOPS par Go donne un total de 4000 IOPS.

    ```
    kubectl describe storageclasses ibmc-file-silver
    ```
    {: pre}

    La zone **parameters** indique le nombre d'IOPS per Go associé à la classe de stockage et les tailles disponibles (en Go).

    ```
    Parameters:	iopsPerGB=4,sizeRange=20Gi,40Gi,80Gi,100Gi,250Gi,500Gi,1000Gi,2000Gi,4000Gi,8000Gi,12000Gi
    ```
    {: screen}

    - Les classes de stockage personnalisées utilisent du [stockage de type Performance ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://knowledgelayer.softlayer.com/topic/performance-storage) et disposent d'options discrètes pour la taille et le nombre total d'IOPS.

    ```
    kubectl describe storageclasses ibmc-file-retain-custom
    ```
    {: pre}

    La zone **parameters** indique le nombre d'IOPS associé à la classe de stockage et les tailles disponibles en gigaoctets. Par exemple, 40Gi pvc peut sélectionner un nombre d'IOPS multiple de 100 compris entre 100 et 2000 IOPS.

    ```
    Parameters:	Note=IOPS value must be a multiple of 100,reclaimPolicy=Retain,sizeIOPSRange=20Gi:[100-1000],40Gi:[100-2000],80Gi:[100-4000],100Gi:[100-6000],1000Gi[100-6000],2000Gi:[200-6000],4000Gi:[300-6000],8000Gi:[500-6000],12000Gi:[1000-6000]
    ```
    {: screen}

4.  Créez un fichier de configuration pour définir votre réservation de volume persistant et enregistrer la configuration dans un fichier `.yaml`.

    Exemple pour les classes de type bronze, silver et gold :

    ```
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: <pvc_name>
      annotations:
        volume.beta.kubernetes.io/storage-class: "ibmc-file-silver"
    spec:
      accessModes:
        - ReadWriteMany
      resources:
        requests:
          storage: 20Gi
    ```
    {: codeblock}

    Exemple pour les classes personnalisées :

    ```
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: <pvc_name>
      annotations:
        volume.beta.kubernetes.io/storage-class: "ibmc-file-retain-custom"
    spec:
      accessModes:
        - ReadWriteMany
      resources:
        requests:
          storage: 40Gi
          iops: "500"
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code>metadata/name</code></td>
    <td>Entrez le nom de la réservation de volume persistant.</td>
    </tr>
    <tr>
    <td><code>metadata/annotations</code></td>
    <td>Indiquez la classe de stockage pour le volume persistant :
      <ul>
      <li>ibmc-file-bronze / ibmc-file-retain-bronze : 2 IOPS par Go.</li>
      <li>ibmc-file-silver / ibmc-file-retain-silver : 4 IOPS par Go.</li>
      <li>ibmc-file-gold / ibmc-file-retain-gold : 10 IOPS par Go.</li>
      <li>ibmc-file-custom / ibmc-file-retain-custom : Plusieurs valeurs d'IOPS disponibles.

    </li> Si vous ne spécifiez pas de classe de stockage, le volume persistant est créé avec la classe de stockage bronze.</td>
    </tr>
    <tr>
    <td><code>spec/accessModes</code>
    <code>resources/requests/storage</code></td>
    <td>Si vous choisissez une taille autre que celle qui est répertoriée, cette taille est arrondie vers le haut. Si vous choisissez une taille supérieure à la taille maximale, cette taille est arrondie au-dessous.</td>
    </tr>
    <tr>
    <td><code>spec/accessModes</code>
    <code>resources/requests/iops</code></td>
    <td>Cette option est applicable uniquement à ibmc-file-custom / ibmc-file-retain-custom. Indiquez le nombre total d'IOPS pour le stockage. Exécutez la commande `kubectl describe storageclasses ibmc-file-custom` pour voir toutes les options. Si vous choisissez une valeur IOPS autre que celle répertoriée, la valeur IOPS est arrondie à la valeur supérieure.</td>
    </tr>
    </tbody></table>

5.  Créez la réservation de volume persistant.

    ```
    kubectl apply -f <local_file_path>
    ```
    {: pre}

6.  Vérifiez que votre réservation de volume persistant a été créée et liée au volume persistant. Ce processus peut prendre quelques minutes.

    ```
    kubectl describe pvc <pvc_name>
    ```
    {: pre}

    Votre sortie sera similaire à ceci.

    ```
    Name:  <pvc_name>
    Namespace: default
    StorageClass: ""
    Status:  Bound
    Volume:  pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
    Labels:  <none>
    Capacity: 20Gi
    Access Modes: RWX
    Events:
      FirstSeen LastSeen Count From        SubObjectPath Type  Reason   Message
      --------- -------- ----- ----        ------------- -------- ------   -------
      3m  3m  1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 }   Normal  Provisioning  External provisioner is provisioning volume for claim "default/my-persistent-volume-claim"
      3m  1m  10 {persistentvolume-controller }       Normal  ExternalProvisioning cannot find provisioner "ibm.io/ibmc-file", expecting that a volume for the claim is provisioned either manually or via external software
      1m  1m  1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 }   Normal  ProvisioningSucceeded Successfully provisioned volume pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2

    ```
    {: screen}

6.  {: #cs_apps_volume_mount}Pour monter la réservation de volume persistant sur votre pod, créez un fichier de configuration. Enregistrez la configuration sous forme de fichier `.yaml`.

    ```
    apiVersion: v1
    kind: Pod
    metadata:
     name: <pod_name>
    spec:
     containers:
     - image: nginx
       name: mycontainer
       volumeMounts:
       - mountPath: /volumemount
         name: myvol
     volumes:
     - name: myvol
       persistentVolumeClaim:
         claimName: mypvc
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code>metadata/name</code></td>
    <td>Nom du pod.</td>
    </tr>
    <tr>
    <td><code>volumeMounts/mountPath</code></td>
    <td>Chemin d'accès absolu du répertoire dans lequel le volume est monté dans le conteneur.</td>
    </tr>
    <tr>
    <td><code>volumeMounts/name</code></td>
    <td>Nom du volume que vous montez sur votre conteneur.</td>
    </tr>
    <tr>
    <td><code>volumes/name</code></td>
    <td>Nom du volume que vous montez sur votre conteneur. Généralement, ce nom est identique à <code>volumeMounts/name</code>.</td>
    </tr>
    <tr>
    <td><code>volumes/name/persistentVolumeClaim</code></td>
    <td>Nom de la réservation de volume persistant que vous souhaitez utiliser pour votre volume. Lorsque vous montez le volume sur le pod, Kubernetes identifie le volume persistant qui est lié à la réservation de volume persistant et permet à l'utilisateur d'accéder en lecture et écriture au volume persistant.</td>
    </tr>
    </tbody></table>

8.  Créez le pod et montez la réservation de volume persistant sur le pod.

    ```
    kubectl apply -f <local_yaml_path>
    ```
    {: pre}

9.  Vérifiez que le montage du volume sur votre pod a abouti.

    ```
    kubectl describe pod <pod_name>
    ```
    {: pre}

    Le point de montage est indiqué dans la zone **Volume Mounts** et le volume est indiqué dans la zone **Volumes**.

    ```
     Volume Mounts:
          /var/run/secrets/kubernetes.io/serviceaccount from default-token-tqp61 (ro)
          /volumemount from myvol (rw)
    ...
    Volumes:
      myvol:
        Type: PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
        ClaimName: mypvc
        ReadOnly: false

    ```
    {: screen}

<br />


## Ajout d'un accès d'utilisateur non root au stockage persistant
{: #cs_apps_volumes_nonroot}

Les utilisateurs non root ne disposent pas du droit d'accès en écriture sur le chemin de montage du volume pour le stockage NFS. Pour le leur octroyer, vous devez éditer le fichier
Dockerfile de l'image afin de créer sur le chemin de montage un répertoire avec le droit d'accès approprié.
{:shortdesc}

Avant de commencer, [ciblez avec votre interface de ligne de commande](cs_cli_install.html#cs_cli_configure) votre cluster.

Si vous concevez une application avec un utilisateur non root devant disposer du droit d'accès en écriture sur le
volume, vous devez ajouter les processus suivants à votre Dockerfile et un script de point d'entrée :

-   Créez un utilisateur non root
-   Ajoutez temporairement cet utilisateur au groupe root.
-   Créez sur le chemin de montage du volume un répertoire avec les droits d'accès utilisateur appropriés.

Pour {{site.data.keyword.containershort_notm}}, le propriétaire par défaut du chemin de montage du volume est le propriétaire `nobody`. Avec le stockage NFS, si le propriétaire n'existe pas localement dans le pod, l'utilisateur `nobody` est créé. Les volumes sont configurés pour
reconnaître l'utilisateur root dans le conteneur, or, pour certaines applications, il s'agit du seul utilisateur au sein d'un conteneur. Cependant, certaines applications spécifient un utilisateur non root autre que `nobody` qui écrit des données sur le chemin de montage du conteneur. Certaines applications spécifient que le volume doit appartenir à l'utilisateur root. En général, les applications n'utilisent pas l'utilisation root pour des raisons de sécurité. Toutefois, si votre application nécessite un utilisateur root, vous pouvez contacter le [support {{site.data.keyword.Bluemix_notm}} ](/docs/support/index.html#contacting-support) pour une assistance.


1.  Créez un fichier Dockerfile sous un répertoire local. L'exemple Dockerfile suivant crée un utilisateur non root nommé `myguest`.

    ```
    FROM registry.<region>.bluemix.net/ibmnode:latest

    # Create group and user with GID & UID 1010.
    # In this case your are creating a group and user named myguest.
    # The GUID and UID 1010 is unlikely to create a conflict with any existing user GUIDs or UIDs in the image.
    # The GUID and UID must be between 0 and 65536. Otherwise, container creation fails.
    RUN groupadd --gid 1010 myguest
    RUN useradd --uid 1010 --gid 1010 -m --shell /bin/bash myguest

    ENV MY_USER=myguest

    COPY entrypoint.sh /sbin/entrypoint.sh
    RUN chmod 755 /sbin/entrypoint.sh

    EXPOSE 22
    ENTRYPOINT ["/sbin/entrypoint.sh"]
    ```
    {: codeblock}

2.  Créez le script de point d'entrée dans le même dossier local que le fichier Dockerfile. Cet exemple de script de point d'entrée spécifie
`/mnt/myvol` comme chemin de montage du volume.

    ```
    #!/bin/bash
    set -e

    # This is the mount point for the shared volume.
    # By default the mount point is owned by the root user.
    MOUNTPATH="/mnt/myvol"
    MY_USER=${MY_USER:-"myguest"}

    # This function creates a subdirectory that is owned by
    # the non-root user under the shared volume mount path.
    create_data_dir() {
      #Add the non-root user to primary group of root user.
      usermod -aG root $MY_USER

      # Provide read-write-execute permission to the group for the shared volume mount path.
      chmod 775 $MOUNTPATH

      # Create a directory under the shared path owned by non-root user myguest.
      su -c "mkdir -p ${MOUNTPATH}/mydata" -l $MY_USER
      su -c "chmod 700 ${MOUNTPATH}/mydata" -l $MY_USER
      ls -al ${MOUNTPATH}

      # For security, remove the non-root user from root user group.
      deluser $MY_USER root

      # Change the shared volume mount path back to its original read-write-execute permission.
      chmod 755 $MOUNTPATH
      echo "Created Data directory..."
    }

    create_data_dir

    # This command creates a long-running process for the purpose of this example.
    tail -F /dev/null
    ```
    {: codeblock}

3.  Connectez-vous à {{site.data.keyword.registryshort_notm}}.

    ```
    bx cr login
    ```
    {: pre}

4.  Générez l'image sur votre poste local. N'oubliez pas de remplacer _&lt;my_namespace&gt;_ par l'espace de nom de votre registre d'images privées. Exécutez la commande `bx cr namespace-get` si vous avez besoin d'identifier votre espace de nom.

    ```
    docker build -t registry.<region>.bluemix.net/<my_namespace>/nonroot .
    ```
    {: pre}

5.  Envoyez l'image par commande push à votre espace de nom dans {{site.data.keyword.registryshort_notm}} .

    ```
    docker push registry.<region>.bluemix.net/<my_namespace>/nonroot
    ```
    {: pre}

6.  Créez une réservation de volume persistant en créant un fichier de configuration `.yaml`. Cet exemple utilise une classe de stockage aux performances plus faibles. Exécutez la commande `kubectl get storageclasses` pour afficher les classes de stockage disponibles.

    ```
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: mypvc
      annotations:
        volume.beta.kubernetes.io/storage-class: "ibmc-file-bronze"
    spec:
      accessModes:
        - ReadWriteMany
      resources:
        requests:
          storage: 20Gi
    ```
    {: codeblock}

7.  Créez la réservation de volume persistant.

    ```
    kubectl apply -f <local_file_path>
    ```
    {: pre}

8.  Créez un fichier de configuration pour monter le volume et exécutez le pod à partir de l'image non root. Le chemin de montage de volume `/mnt/myvol` correspond au chemin de montage spécifié dans le fichier Dockerfile. Enregistrez la configuration sous forme de fichier `.yaml`.

    ```
    apiVersion: v1
    kind: Pod
    metadata:
     name: mypod
    spec:
     containers:
     - image: registry.<region>.bluemix.net/<my_namespace>/nonroot
       name: mycontainer
       volumeMounts:
       - mountPath: /mnt/myvol
         name: myvol
     volumes:
     - name: myvol
       persistentVolumeClaim:
         claimName: mypvc
    ```
    {: codeblock}

9.  Créez le pod et montez la réservation de volume persistant sur le pod.

    ```
    kubectl apply -f <local_yaml_path>
    ```
    {: pre}

10. Vérifiez que le montage du volume sur votre pod a abouti.

    ```
    kubectl describe pod mypod
    ```
    {: pre}

    Le point de montage du volume est indiqué dans la zone **Volume Mounts** et le volume est répertorié dans la zone **Volumes**.

    ```
     Volume Mounts:
          /var/run/secrets/kubernetes.io/serviceaccount from default-token-tqp61 (ro)
          /mnt/myvol from myvol (rw)
    ...
    Volumes:
      myvol:
        Type: PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
        ClaimName: mypvc
        ReadOnly: false

    ```
    {: screen}

11. Connectez-vous au pod une fois qu'il est lancé.

    ```
    kubectl exec -it mypod /bin/bash
    ```
    {: pre}

12. Affichez les droits d'accès au chemin de montage de votre volume.

    ```
    ls -al /mnt/myvol/
    ```
    {: pre}

    ```
    root@instance-006ff76b:/# ls -al /mnt/myvol/
    total 12
    drwxr-xr-x 3 root    root    4096 Jul 13 19:03 .
    drwxr-xr-x 3 root    root    4096 Jul 13 19:03 ..
    drwx------ 2 myguest myguest 4096 Jul 13 19:03 mydata
    ```
    {: screen}

    Cette sortie indique que l'utilisateur root dispose des droits d'accès en lecture, écriture et exécution sur le chemin de montage du volume
`mnt/myvol/`, tandis que l'utilisateur non root myguest dispose des droits d'accès en lecture et écriture sur le dossier `mnt/myvol/mydata`. Grâce
à la mise à jour de ces droits d'accès, l'utilisateur non root peut à présent écrire des données sur le volume persistant.
