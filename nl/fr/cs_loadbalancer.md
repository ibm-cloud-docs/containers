---

copyright:
  years: 2014, 2018
lastupdated: "2018-10-25"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}



# Exposition d'applications avec des équilibreurs de charge
{: #loadbalancer}

Exposez un port et utilisez une adresse IP pour un équilibreur de charge (couche 4) pour accéder à une application conteneurisée.
{:shortdesc}



## Composants et architecture d'un équilibreur de charge
{: #planning}

Lorsque vous créez un cluster standard, un sous-réseau public portable et un sous-réseau privé portable sont fournis automatiquement par {{site.data.keyword.containerlong_notm}}.

* Le sous-réseau public portable fournit 1 adresse IP publique portable utilisée par l'[équilibreur de charge d'application (ALB) Ingress public](cs_ingress.html) par défaut. Les 4 autres adresses IP publiques portables peuvent être utilisées pour exposer des applications individuelles sur Internet en créant un service d'équilibreur de charge public.
* Le sous-réseau privé portable fournit 1 adresse IP privée portable utilisée par l'[équilibreur de charge d'application (ALB) Ingress privé](cs_ingress.html#private_ingress) par défaut. Les 4 autres adresses IP privées portables peuvent être utilisées pour exposer des applications individuelles sur un réseau privé en créant un service d'équilibreur de charge privé.

Les adresses IP publiques et privées portables sont statiques et ne changent pas en cas de retrait d'un noeud worker. Si le noeud worker dans lequel figure l'adresse IP de l'équilibreur de charge est retiré, un démon Keepalived qui surveille en permanence l'adresse IP transfère automatiquement l'adresse IP sur un autre noeud worker. Vous pouvez affecter n'importe quel port à votre équilibreur de charge et n'êtes pas obligé d'utiliser une plage de ports particulière.

Un service d'équilibreur de charge rend votre application accessible via les ports de noeud du service. Les [ports de noeud (NodePort)](cs_nodeport.html) sont accessibles sur toutes les adresses IP publiques et privées pour tous les noeuds figurant dans le cluster. Pour bloquer le trafic vers les ports de noeud lorsque vous utilisez un service d'équilibreur de charge, voir [Contrôle du trafic entrant vers les services d'équilibreur de charge ou NodePort](cs_network_policy.html#block_ingress).

Le service d'équilibreur de charge fait office de point d'entrée externe pour les demandes entrantes vers votre application. Pour accéder au service d'équilibreur de charge depuis Internet, utilisez l'adresse IP publique de votre équilibreur de charge et le port affecté en utilisant le format `<IP_address>:<port>`. Le diagramme suivant montre comment un équilibreur de charge achemine la communication vers une application depuis Internet.

<img src="images/cs_loadbalancer_planning.png" width="550" alt="Exposition d'une application dans {{site.data.keyword.containerlong_notm}} à l'aide d'un équilibreur de charge" style="width:550px; border-style: none"/>

1. Une demande adressée à votre application utilise l'adresse IP publique de votre équilibreur de charge et le port affecté sur le noeud worker.

2. La demande est automatiquement transmise à l'adresse IP et au port du cluster interne du service d'équilibreur de charge. L'adresse IP du cluster interne est accessible uniquement à l'intérieur du cluster.

3. `kube-proxy` achemine la demande vers le service d'équilibreur de charge Kubernetes correspondant à l'application.

4. La demande est transférée à l'adresse IP privée du pod d'application. L'adresse IP source du package de demande est remplacée par l'adresse IP publique du noeud worker sur lequel s'exécute le pod d'application. Si plusieurs instances d'application sont déployées dans le cluster, l'équilibreur de charge achemine les demandes entre les pods d'application.

**Clusters à zones multiples** :

Si vous disposez d'un cluster à zones multiples, les instances d'application sont déployées dans des pods sur les noeuds worker répartis dans les différentes zones. Le diagramme suivant illustre comment un équilibreur de charge classique dirige la communication d'Internet vers une application dans un cluster à zones multiples .

<img src="images/cs_loadbalancer_planning_multizone.png" width="500" alt="Utilisation d'un service d'équilibreur de charge pour équilibrer la charge des applications dans un cluster à zones multiples" style="width:500px; border-style: none"/>

Par défaut, chaque équilibreur de charge est configuré dans une seule zone. Pour assurer la haute disponibilité, vous devez déployer un équilibreur de charge dans toutes les zones où se trouvent vos instances d'application. Les demandes sont traitées par les équilibreurs de charge dans les différentes zones à tour de rôle. De plus, l'équilibreur de charge route les demandes vers les instances d'application au sein de sa propre zone et vers les instances d'application situées dans d'autres zones.

<br />


## Activation de l'accès public ou privé à une application dans un cluster à zones multiples
{: #multi_zone_config}

Remarque :
  * Cette fonction n'est disponible que pour les clusters standard.
  * Les services d'équilibreur de charge ne prennent pas en charge les terminaisons TLS. Si votre application nécessite une terminaison TLS, vous pouvez exposer l'application en utilisant [Ingress](cs_ingress.html) ou configurer votre application pour gérer la terminaison TLS.

Avant de commencer :
  * Un service d'équilibreur de charge avec une adresse IP privée portable comporte toujours un port de noeud (NodePort) public ouvert sur tous les noeuds worker. Pour ajouter une règle réseau afin d'éviter tout trafic public, voir [Blocage de trafic entrant](cs_network_policy.html#block_ingress).
  * Vous devez déployer un équilibreur de charge dans chaque zone et à chaque équilibreur de charge est affectée sa propre adresse IP dans cette zone. Pour créer des équilibreurs de charge publics, au moins un VLAN public doit disposer de sous-réseaux portables disponibles dans chaque zone. Pour ajouter des services d'équilibreur de charge privés, au moins un VLAN privé doit disposer de sous-réseaux portables disponibles dans chaque zone. Pour ajouter des sous-réseaux, voir [Configuration de sous-réseaux pour les clusters](cs_subnets.html).
  * Si vous limitez le trafic réseau aux noeuds worker de périphérie, vérifiez qu'au moins 2 [noeuds worker de périphérie](cs_edge.html#edge) sont activés dans chaque zone. S'ils ne sont activés que dans certaines zones et pas d'autres, les équilibreurs de charge ne pourront pas se déployer uniformément. Les équilibreurs de charge seront déployés sur des noeuds de périphérie dans certaines zones mais sur des noeuds worker normaux dans d'autres zones.
  * Si vous disposez de plusieurs VLAN pour un cluster, de plusieurs sous-réseaux sur le même VLAN ou d'un cluster à zones multiples, vous devez activer la fonction [Spanning VLAN](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) pour votre compte d'infrastructure IBM Cloud (SoftLayer) afin que vos noeuds worker puissent communiquer entre eux sur le réseau privé. Pour effectuer cette action, vous devez disposer des [droits Infrastructure](cs_users.html#infra_access) **Réseau > Gérer spanning VLAN pour réseau** ou vous pouvez demander au propriétaire du compte de l'activer. Pour vérifier si la fonction Spanning VLAN est déjà activée, utilisez la [commande](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`. Avec {{site.data.keyword.BluDirectLink}}, vous devez utiliser à la place une [fonction VRF (Virtual Router Function)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf). Pour activer la fonction VRF, contactez le représentant de votre compte d'infrastructure IBM Cloud (SoftLayer).


Pour configurer un service d'équilibreur de charge dans un cluster à zones multiples :
1.  [Déployez votre application sur le cluster](cs_app.html#app_cli). Lorsque vous déployez l'application sur le cluster, un ou plusieurs pods sont créés pour vous et exécutent votre application dans un conteneur. Prenez soin d'ajouter un libellé à votre déploiement dans la section "metadata" de votre fichier de configuration. Ce libellé est nécessaire pour identifier tous les pods dans lesquels s'exécute votre application afin de pouvoir les inclure dans l'équilibrage de charge.

2.  Créez un service d'équilibreur de charge pour l'application que vous désirez exposer. Pour rendre votre application accessible sur l'Internet public ou sur un réseau privé, créez un service Kubernetes pour votre application. Configurez ce service pour inclure tous les pods composant votre application dans l'équilibrage de charge.
  1. Créez un fichier de configuration de service nommé, par exemple, `myloadbalancer.yaml`.
  2. Définissez un service d'équilibreur de charge pour l'application que vous désirez exposer. Vous pouvez spécifier une zone et une adresse IP.

      ```
      apiVersion: v1
      kind: Service
      metadata:
        name: myloadbalancer
        annotations:
          service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>
          service.kubernetes.io/ibm-load-balancer-cloud-provider-zone: "<zone>"
      spec:
        type: LoadBalancer
        selector:
          <selector_key>: <selector_value>
        ports:
         - protocol: TCP
             port: 8080
          loadBalancerIP: <IP_address>
      ```
      {: codeblock}

      <table>
      <caption>Description des composants du fichier YAML</caption>
      <thead>
      <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
      </thead>
      <tbody>
      <tr>
        <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type:</code>
        <td>Annotation utilisée pour indiquer le type d'équilibreur de charge. Les valeurs admises sont <code>private</code> et <code>public</code>. Si vous créez un équilibreur de charge public dans les clusters sur des VLAN publics, cette annotation n'est pas nécessaire.</td>
      </tr>
      <tr>
        <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-zone:</code>
        <td>Annotation utilisée pour indiquer la zone dans laquelle est déployé le service d'équilibreur de charge. Pour voir les zones, exécutez la commande <code>ibmcloud ks zones</code>.</td>
      </tr>
      <tr>
        <td><code>selector</code></td>
        <td>Entrez la paire clé de libellé (<em>&lt;selector_key&gt;</em>) et valeur (<em>&lt;selector_value&gt;</em>) à utiliser pour cibler les pods dans lesquels s'exécute votre application. Pour cibler vos pods et les inclure dans l'équilibrage de charge du service, vérifiez les valeurs <em>&lt;selectorkey&gt;</em> et <em>&lt;selectorvalue&gt;</em>. Assurez-vous qu'elles sont identiques à la paire <em>clé/valeur</em> que vous avez utilisée à la section <code>spec.template.metadata.labels</code> de votre fichier YAML de déploiement.</td>
      </tr>
      <tr>
        <td><code>port</code></td>
        <td>Port sur lequel le service est à l'écoute.</td>
      </tr>
      <tr>
        <td><code>loadBalancerIP</code></td>
        <td>Facultatif : pour créer un équilibreur de charge privé ou utiliser une adresse IP portable spécifique pour un équilibreur de charge public, remplacez <em>&lt;IP_address&gt;</em> par l'adresse IP que vous désirez utiliser. Si vous spécifiez une zone, l'adresse IP doit figurer dans ce VLAN ou dans cette zone. Si vous n'indiquez pas d'adresse IP :<ul><li>Si votre cluster se trouve sur un VLAN public, une adresse IP publique portable est utilisée. La plupart des clusters se trouvent dans un VLAN public.</li><li>Si votre cluster est disponible uniquement sur un VLAN privé, une adresse IP privée portable est utilisée.</li></td>
      </tr>
      </tbody></table>

      Exemple de fichier de configuration pour créer un service d'équilibreur de charge privé classique qui utilise une adresse IP indiquée dans la zone `dal12`:

      ```
      apiVersion: v1
      kind: Service
      metadata:
        name: myloadbalancer
        annotations:
          service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: private
          service.kubernetes.io/ibm-load-balancer-cloud-provider-zone: "dal12"
      spec:
        type: LoadBalancer
        selector:
          app: nginx
        ports:
         - protocol: TCP
           port: 8080
        loadBalancerIP: 172.21.xxx.xxx
      ```
      {: codeblock}

  3. Facultatif : configurez un pare-feu en indiquant `loadBalancerSourceRanges` dans la section **spec**. Pour plus d'informations, voir la [documentation Kubernetes ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/).

  4. Créez le service dans votre cluster.

      ```
      kubectl apply -f myloadbalancer.yaml
      ```
      {: pre}

3. Vérifiez que la création du service d'équilibreur de charge a abouti. Remplacez _&lt;myservice&gt;_ par le nom du service d'équilibreur de charge que vous avez créé à l'étape précédente.

    ```
    kubectl describe service myloadbalancer
    ```
    {: pre}

    **Remarque :** quelques minutes peuvent s'écouler pour que le service d'équilibreur de charge soit créé et que l'application soit disponible.

    Exemple de sortie d'interface CLI :

    ```
    Name:                   myloadbalancer
    Namespace:              default
    Labels:                 <none>
    Selector:               app=liberty
    Type:                   LoadBalancer
    Zone:                   dal10
    IP:                     172.21.xxx.xxx
    LoadBalancer Ingress:   169.xx.xxx.xxx
    Port:                   <unset> 8080/TCP
    NodePort:               <unset> 32040/TCP
    Endpoints:              172.30.xxx.xxx:8080
    Session Affinity:       None
    Events:
      FirstSeen	LastSeen	Count	From			SubObjectPath	Type	 Reason			          Message
      ---------	--------	-----	----			-------------	----	 ------			          -------
      10s		    10s		    1	    {service-controller }	  Normal CreatingLoadBalancer	Creating load balancer
      10s		    10s		    1	    {service-controller }		Normal CreatedLoadBalancer	Created load balancer
    ```
    {: screen}

    L'adresse IP **LoadBalancer Ingress** est l'adresse IP portable affectée à votre service d'équilibreur de charge.

4.  Si vous avez créé un équilibreur de charge public, accédez à votre application via Internet.
    1.  Ouvrez le navigateur Web de votre choix.
    2.  Entrez l'adresse IP publique portable et le port de l'équilibreur de charge.

        ```
        http://169.xx.xxx.xxx:8080
        ```
        {: codeblock}        

5. Si vous choisissez d'[activer la conservation de l'adresse IP source pour un service d'équilibreur de charge ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/tutorials/services/source-ip/#source-ip-for-services-with-typeloadbalancer), assurez-vous que tous les pods d'application sont planifiés sur les noeuds worker de périphérie en [ajoutant l'affinité de noeud de périphérie aux pods d'application](cs_loadbalancer.html#edge_nodes). Les pods d'application doivent être planifiés sur des noeuds de périphérie pour recevoir des demandes entrantes.

6. Pour traiter des demandes entrantes adressées à votre application à partir d'autres zones, répétez la procédure ci-dessus pour ajouter un équilibreur de charge dans chaque zone.

7. Facultatif : un service d'équilibreur de charge rend votre application accessible via les ports de noeud du service. Les [ports de noeud (NodePort)](cs_nodeport.html) sont accessibles sur toutes les adresses IP publiques et privées pour tous les noeuds figurant dans le cluster. Pour bloquer le trafic vers les ports de noeud lorsque vous utilisez un service d'équilibreur de charge, voir [Contrôle du trafic entrant vers les services d'équilibreur de charge ou NodePort](cs_network_policy.html#block_ingress).

## Activation de l'accès public ou privé à une application dans un cluster à zone unique
{: #config}

Avant de commencer :

-   Cette fonction n'est disponible que pour les clusters standard.
-   Vous devez disposer d'une adresse IP publique ou privée disponible pour l'affecter au service d'équilibreur de charge.
-   Un service d'équilibreur de charge avec une adresse IP privée portable comporte toujours un port de noeud (NodePort) public ouvert sur tous les noeuds worker. Pour ajouter une règle réseau afin d'éviter tout trafic public, voir [Blocage de trafic entrant](cs_network_policy.html#block_ingress).

Pour créer un service d'équilibreur de charge, procédez comme suit :

1.  [Déployez votre application sur le cluster](cs_app.html#app_cli). Lorsque vous déployez l'application sur le cluster, un ou plusieurs pods sont créés pour vous et exécutent votre application dans un conteneur. Prenez soin d'ajouter un libellé à votre déploiement dans la section "metadata" de votre fichier de configuration. Ce libellé est nécessaire pour identifier tous les pods dans lesquels s'exécute votre application afin de pouvoir les inclure dans l'équilibrage de charge.
2.  Créez un service d'équilibreur de charge pour l'application que vous désirez exposer. Pour rendre votre application accessible sur l'Internet public ou sur un réseau privé, créez un service Kubernetes pour votre application. Configurez ce service pour inclure tous les pods composant votre application dans l'équilibrage de charge.
    1.  Créez un fichier de configuration de service nommé, par exemple, `myloadbalancer.yaml`.

    2.  Définissez un service d'équilibreur de charge pour l'application que vous désirez exposer.
        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: myloadbalancer
          annotations:
            service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>
        spec:
          type: LoadBalancer
          selector:
            <selector_key>: <selector_value>
          ports:
           - protocol: TCP
             port: 8080
          loadBalancerIP: <IP_address>
        ```
        {: codeblock}

        <table>
        <caption>Description des composants du fichier YAML</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
        </thead>
        <tbody>
        <tr>
          <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type:`
          <td>Annotation utilisée pour indiquer le type d'équilibreur de charge. Les valeurs admises sont `private` et `public`. Si vous créez un équilibreur de charge public dans les clusters sur des VLAN publics, cette annotation n'est pas nécessaire.</td>
        </tr>
        <tr>
          <td><code>selector</code></td>
          <td>Entrez la paire clé de libellé (<em>&lt;selector_key&gt;</em>) et valeur (<em>&lt;selector_value&gt;</em>) à utiliser pour cibler les pods dans lesquels s'exécute votre application. Pour cibler vos pods et les inclure dans l'équilibrage de charge du service, vérifiez les valeurs <em>&lt;selector_key&gt;</em> et <em>&lt;selector_value&gt;</em>. Assurez-vous qu'elles sont identiques à la paire <em>clé/valeur</em> que vous avez utilisée à la section <code>spec.template.metadata.labels</code> de votre fichier YAML de déploiement.</td>
        </tr>
        <tr>
          <td><code>port</code></td>
          <td>Port sur lequel le service est à l'écoute.</td>
        </tr>
        <tr>
          <td><code>loadBalancerIP</code></td>
          <td>Facultatif : pour créer un équilibreur de charge privé ou utiliser une adresse IP portable spécifique pour un équilibreur de charge public, remplacez <em>&lt;IP_address&gt;</em> par l'adresse IP que vous désirez utiliser. Si vous n'indiquez pas d'adresse IP :<ul><li>Si votre cluster se trouve sur un VLAN public, une adresse IP publique portable est utilisée. La plupart des clusters se trouvent dans un VLAN public.</li><li>Si votre cluster est disponible uniquement sur un VLAN privé, une adresse IP privée portable est utilisée.</li></td>
        </tr>
        </tbody></table>

        Exemple de fichier de configuration pour créer un service d'équilibreur de charge privé classique qui utilise une adresse IP indiquée :

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: myloadbalancer
          annotations:
            service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: private
        spec:
          type: LoadBalancer
          selector:
            app: nginx
          ports:
           - protocol: TCP
             port: 8080
          loadBalancerIP: 172.21.xxx.xxx
        ```
        {: codeblock}

    3.  Facultatif : configurez un pare-feu en indiquant `loadBalancerSourceRanges` dans la section **spec**. Pour plus d'informations, voir la [documentation Kubernetes ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/).

    4.  Créez le service dans votre cluster.

        ```
        kubectl apply -f myloadbalancer.yaml
        ```
        {: pre}

        Lorsque votre service d'équilibreur de charge est créé, une adresse IP portable lui est automatiquement affectée. Si aucune adresse IP portable n'est disponible, le service d'équilibreur de charge ne peut pas être créé.

3.  Vérifiez que la création du service d'équilibreur de charge a abouti.

    ```
    kubectl describe service myloadbalancer
    ```
    {: pre}

    **Remarque :** quelques minutes peuvent s'écouler pour que le service d'équilibreur de charge soit créé et que l'application soit disponible.

    Exemple de sortie d'interface CLI :

    ```
    Name:                   myloadbalancer
    Namespace:              default
    Labels:                 <none>
    Selector:               app=liberty
    Type:                   LoadBalancer
    Location:               dal10
    IP:                     172.21.xxx.xxx
    LoadBalancer Ingress:   169.xx.xxx.xxx
    Port:                   <unset> 8080/TCP
    NodePort:               <unset> 32040/TCP
    Endpoints:              172.30.xxx.xxx:8080
    Session Affinity:       None
    Events:
      FirstSeen	LastSeen	Count	From			SubObjectPath	Type	 Reason			          Message
      ---------	--------	-----	----			-------------	----	 ------			          -------
      10s		    10s		    1	    {service-controller }	  Normal CreatingLoadBalancer	Creating load balancer
      10s		    10s		    1	    {service-controller }		Normal CreatedLoadBalancer	Created load balancer
    ```
    {: screen}

    L'adresse IP **LoadBalancer Ingress** est l'adresse IP portable affectée à votre service d'équilibreur de charge.

4.  Si vous avez créé un équilibreur de charge public, accédez à votre application via Internet.
    1.  Ouvrez le navigateur Web de votre choix.
    2.  Entrez l'adresse IP publique portable et le port de l'équilibreur de charge.

        ```
        http://169.xx.xxx.xxx:8080
        ```
        {: codeblock}

5. Si vous choisissez d'[activer la conservation de l'adresse IP source pour un service d'équilibreur de charge ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/tutorials/services/source-ip/#source-ip-for-services-with-typeloadbalancer), assurez-vous que tous les pods d'application sont planifiés sur les noeuds worker de périphérie en [ajoutant l'affinité de noeud de périphérie aux pods d'application](cs_loadbalancer.html#edge_nodes). Les pods d'application doivent être planifiés sur des noeuds de périphérie pour recevoir des demandes entrantes.

6. Facultatif : un service d'équilibreur de charge rend votre application accessible via les ports de noeud du service. Les [ports de noeud (NodePort)](cs_nodeport.html) sont accessibles sur toutes les adresses IP publiques et privées pour tous les noeuds figurant dans le cluster. Pour bloquer le trafic vers les ports de noeud lorsque vous utilisez un service d'équilibreur de charge, voir [Contrôle du trafic entrant vers les services d'équilibreur de charge ou de NodePort](cs_network_policy.html#block_ingress).

<br />


## Ajout d'affinité de noeud et de tolérance aux pods d'application pour l'adresse IP source
{: #node_affinity_tolerations}

Lorsqu'une demande client vers votre application est envoyée à votre cluster, la demande est acheminée au pod du service d'équilibreur de charge exposant votre application. S'il n'existe aucun pod d'application sur le même noeud worker que le pod de service d'équilibreur de charge, l'équilibreur de charge transmet la demande à un pod d'application sur un autre noeud worker. L'adresse IP source du package est remplacée par l'adresse IP publique du noeud worker sur lequel s'exécute le pod d'application.

Pour conserver l'adresse IP source d'origine de la demande du client, vous pouvez [activer l'adresse IP source ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/#preserving-the-client-source-ip) pour les services d'équilibreur de charge. La connexion TCP se poursuit jusqu'aux pods d'application de sorte que l'application puisse voir l'adresse IP source réelle du demandeur. Conserver l'adresse IP du client est pratique, notamment lorsque les serveurs d'applications doivent appliquer des règles de sécurité et de contrôle d'accès.

Après avoir activé l'adresse IP source, les pods de service d'équilibreur de charge doivent transférer les demandes aux pods d'application déployés sur le même noeud worker uniquement. En principe, des pods de service d'équilibreur de charge sont également déployés sur les noeuds worker sur lesquels sont déployés les pods d'application. Il existe cependant des situations où les pods d'équilibreur de charge et les pods d'application ne sont pas forcément planifiés sur le même noeud worker :

* Vous disposez de noeuds de périphérie avec des annotations taint de sorte que seuls les pods du service d'équilibreur de charge puissent se déployer sur ces noeuds. Le déploiement des pods d'application n'est pas autorisé sur ces noeuds.
* Votre cluster est connecté à plusieurs réseaux locaux virtuels (VLAN) publics ou privés, et vos pods d'application peuvent se déployer sur des noeuds worker connectés uniquement à un seul VLAN. Les pods de service d'équilibreur de charge risquent de ne pas se déployer sur ces noeuds worker car l'adresse IP de l'équilibreur de charge est connectée à un autre VLAN que les noeuds worker.

Pour forcer le déploiement de votre application sur des noeuds worker spécifiques sur lesquels peuvent se déployer des pods de service d'équilibreur de charge, vous devez ajouter des règles d'affinité et des tolérances au déploiement de votre application.

### Ajout de règles d'affinité et de tolérances pour les noeuds de périphérie
{: #edge_nodes}

Lorsque vous [labellisez des noeuds worker en tant que noeuds de périphérie](cs_edge.html#edge_nodes) et que vous ajoutez des [annotations taint à ces noeuds de périphérie](cs_edge.html#edge_workloads), les pods de service d'équilibreur de charge se déploient uniquement sur ces noeuds de périphérie et les pods d'application ne peuvent pas se déployer sur les noeuds de périphérie. Lorsque l'adresse IP source est activée pour le service d'équilibreur de charge, les pods d'équilibreur de charge sur les noeuds de périphérie ne peuvent pas transférer les demandes entrantes à vos pods d'application sur d'autres noeuds worker.
{:shortdesc}

Pour forcer le déploiement de vos pods d'application sur des noeuds de périphérie, ajoutez une [règle d'affinité ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#node-affinity-beta-feature) et une [tolérance (toleration) ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/#concepts) de noeud de périphérie au déploiement de l'application.

Exemple de fichier YAML de déploiement avec les sections node affinity et toleration appliquées à un noeud de périphérie :

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
              - key: dedicated
                operator: In
                values:
                - edge
      tolerations:
        - key: dedicated
          value: edge
...
```
{: codeblock}

Les deux sections **affinity** et **tolerations** ont la valeur `dedicated` pour `key` et `edge` pour `value`.

### Ajout de règles d'affinité à plusieurs réseaux locaux virtuels (VLAN) publics ou privés
{: #edge_nodes_multiple_vlans}

Lorsque votre cluster est connecté à plusieurs réseaux locaux virtuels (VLAN) publics ou privés, vos pods d'application peuvent se déployer sur des noeuds worker connectés uniquement à un seul VLAN. Si l'adresse IP de l'équilibreur de charge est connectée à un autre VLAN que ces noeuds worker, les pods de service d'équilibreur de charge ne pourront pas se déployer sur ces noeuds worker.
{:shortdesc}

Lorsque l'adresse IP source est activée, planifiez les pods d'application sur les noeuds worker avec le même VLAN que l'adresse IP de l'équilibreur de charge en ajoutant une règle d'affinité au déploiement de l'application.

Avant de commencer : [connectez-vous à votre compte. Ciblez la région appropriée et, le cas échéant, le groupe de ressources. Définissez le contexte de votre cluster](cs_cli_install.html#cs_cli_configure).

1. Obtenez l'adresse IP du service d'équilibreur de charge. Recherchez cette adresse dans la zone **LoadBalancer Ingress**.
    ```
    kubectl describe service <loadbalancer_service_name>
    ```
    {: pre}

2. Récupérez l'ID du réseau local virtuel auquel votre service d'équilibreur de charge est connecté.

    1. Affichez la liste des VLAN publics portables de votre cluster.
        ```
        ibmcloud ks cluster-get <cluster_name_or_ID> --showResources
        ```
        {: pre}

        Exemple de sortie :
        ```
        ...

        Subnet VLANs
        VLAN ID   Subnet CIDR       Public   User-managed
        2234947   10.xxx.xx.xxx/29  false    false
        2234945   169.36.5.xxx/29   true     false
        ```
        {: screen}

    2. Dans la sortie à la section des VLAN de sous-réseau (**Subnet VLANs**), recherchez la valeur du CIDR de sous-réseau qui correspond à l'adresse IP de l'équilibreur de charge que vous avez récupérée précédemment et notez l'ID du VLAN.

        Par exemple, si l'adresse IP du service d'équilibreur de charge est `169.36.5.xxx`, le sous-réseau correspondant dans l'exemple de sortie de l'étape précédente est `169.36.5.xxx/29`. L'ID du VLAN auquel est connecté ce sous-réseau est `2234945`.

3. [Ajoutez une règle d'affinité ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#node-affinity-beta-feature) au déploiement d'application pour l'ID du VLAN que vous avez noté à l'étape précédente.

    Par exemple, si vous disposez de plusieurs VLAN et que vous souhaitez que vos pods d'application se déploient sur des noeuds worker résidant uniquement sur le VLAN public `2234945` :

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
                  - key: publicVLAN
                    operator: In
                    values:
                    - "2234945"
    ...
    ```
    {: codeblock}

    Dans l'exemple de fichier YAML, la section **affinity** contient `publicVLAN` pour `key` et `"2234945"` pour `value`.

4. Appliquez le fichier de configuration de déploiement mis à jour.
    ```
    kubectl apply -f with-node-affinity.yaml
    ```
    {: pre}

5. Vérifiez que les pods d'application déployés sur les noeuds worker sont connectés au VLAN désigné.

    1. Affichez la liste des pods de votre cluster. Remplacez `<selector>` par le libellé que vous avez utilisé pour l'application.
        ```
        kubectl get pods -o wide app=<selector>
        ```
        {: pre}

        Exemple de sortie :
        ```
        NAME                   READY     STATUS              RESTARTS   AGE       IP               NODE
        cf-py-d7b7d94db-vp8pq  1/1       Running             0          15d       172.30.xxx.xxx   10.176.48.78
        ```
        {: screen}

    2. Dans la sortie, identifiez un pod pour votre application. Notez l'ID du noeud worker (**NODE**) sur lequel réside le pod.

        Dans l'exemple de sortie de l'étape précédente, le pod d'application `cf-py-d7b7d94db-vp8pq` réside sur le noeud worker `10.176.48.78`.

    3. Affichez la liste des détails relatifs à votre noeud worker.

        ```
        kubectl describe node <worker_node_ID>
        ```
        {: pre}

        Exemple de sortie :

        ```
        Name:                   10.xxx.xx.xxx
        Role:
        Labels:                 arch=amd64
                                beta.kubernetes.io/arch=amd64
                                beta.kubernetes.io/os=linux
                                failure-domain.beta.kubernetes.io/region=us-south
                                failure-domain.beta.kubernetes.io/zone=dal10
                                ibm-cloud.kubernetes.io/encrypted-docker-data=true
                                kubernetes.io/hostname=10.xxx.xx.xxx
                                privateVLAN=2234945
                                publicVLAN=2234967
        ...
        ```
        {: screen}

    4. Dans la section **Labels** de la sortie, vérifiez que le VLAN public ou privé correspond au VLAN que vous avez désigné dans les étapes précédentes.

