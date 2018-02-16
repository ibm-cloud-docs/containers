---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-12"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Configuration de services d'équilibreur de charge
{: #loadbalancer}

Exposez un port et utilisez l'adresse IP portable de l'équilibreur de charge pour accéder à l'application. Utilisez une adresse IP publique pour rendre une application accessible sur Internet ou une adresse IP privée pour rendre une application accessible sur votre réseau d'infrastructure privé.
{:shortdesc}

## Configuration de l'accès public à une application à l'aide du type de service LoadBalancer
{: #config}

Contrairement à un service NodePort, l'adresse IP portable du service d'équilibreur de charge n'est pas dépendante du noeud worker sur lequel l'application est déployée. Cependant, un service Kubernetes LoadBalancer est également un service NodePort. Un service LoadBalancer rend accessible votre application via l'adresse IP et le port de l'équilibreur de charge et la rend accessible via les ports de noeud du service.
{:shortdesc}

L'adresse IP portable de l'équilibreur de charge est affectée pour vous et ne change pas lorsque vous ajoutez ou retirez des noeuds d'agent. Par conséquent, les services d'équilibreur de charge offrent une plus haute disponibilité que les services NodePort. Les utilisateurs peuvent sélectionner n'importe quel port pour l'équilibreur de charge et ne sont pas confinés à la plage de ports NodePort. Vous pouvez utiliser des services d'équilibreur de charge pour les protocoles TCP et UDP.

**Remarque :** les services d'équilibreur de charge ne prennent pas en charge la terminaison TLS. Si votre application nécessite une terminaison TLS, vous pouvez exposer votre application en utilisant [Ingress](cs_ingress.html) ou bien la configurer afin qu'elle gère la terminaison TLS.

Avant de commencer :

-   Cette fonction n'est disponible que pour les clusters standard.
-   Vous devez disposer d'une adresse IP publique ou privée disponible pour l'affecter au service d'équilibreur de charge.
-   Un service d'équilibreur de charge avec une adresse IP privée portable comporte toujours un port de noeud public ouvert sur tous les noeuds d'agent. Pour ajouter une règle réseau afin d'éviter tout trafic public, voir [Blocage de trafic entrant](cs_network_policy.html#block_ingress).

Pour créer un service d'équilibreur de charge, procédez comme suit :

1.  [Déployez votre application sur le cluster](cs_app.html#app_cli). Lorsque vous déployez l'application sur le cluster, un ou plusieurs pods sont créés pour vous et exécutent votre application dans un conteneur. Prenez soin d'ajouter un libellé à votre déploiement dans la section "metadata" de votre fichier de configuration. Ce libellé est nécessaire pour identifier tous les pods où s'exécute votre application afin de pouvoir les inclure dans l'équilibrage de charge.
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
          loadBalancerIP: <private_ip_address>
        ```
        {: codeblock}

        <table>
        <caption>Description des composants du fichier du service LoadBalancer</caption>
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
        </tr>
        <tr>
          <td><code>loadBalancerIP</code></td>
          <td>Lors de la création d'un service LoadBalancer privé ou pour utiliser une adresse IP portable spécifique pour un service LoadBalancer public, remplacez <em>&lt;loadBalancerIP&gt;</em> par l'adresse IP que vous désirez utiliser. Pour plus d'informations, voir la [documentation Kubernetes ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/concepts/services-networking/service/#type-loadbalancer).</td>
        </tr>
        </tbody></table>

    3.  Facultatif : configurez un pare-feu en indiquant `loadBalancerSourceRanges` dans la section spec. Pour plus d'informations, voir la [documentation Kubernetes ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/).

    4.  Créez le service dans votre cluster.

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
