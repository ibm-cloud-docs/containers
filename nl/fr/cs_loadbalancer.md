---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

keywords: kubernetes, iks, lb1.0, nlb

subcollection: containers

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
{:preview: .preview}


# Configuration d'un équilibreur de charge de réseau 1.0
{: #loadbalancer}

Exposez un port et utilisez une adresse IP portable pour un équilibreur de charge de réseau de couche 4 afin d'exposer une application conteneurisée.
Pour toute information sur les équilibreurs de charge de réseau 1.0, voir [Composants et architecture d'un équilibreur de charge de réseau 1.0](/docs/containers?topic=containers-loadbalancer-about#v1_planning).
{:shortdesc}

Pour commencer rapidement, vous pouvez exécuter la commande suivante et créer un équilibreur de charge 1.0 :
```
kubectl expose deploy my-app --port=80 --target-port=8080 --type=LoadBalancer --name my-lb-svc
```
{: pre}

## Configuration d'un équilibreur de charge de réseau 1.0 dans un cluster à zones multiples
{: #multi_zone_config}

**Avant de commencer** :
* Pour pouvoir créer des équilibreurs de charge de réseau (NLB) publics dans plusieurs zones, au moins un VLAN public doit comporter des sous-réseaux portables disponibles dans chaque zone. Pour pouvoir créer des équilibreurs de charge de réseau (NLB) privés dans plusieurs zones, au moins un VLAN privé doit comporter des sous-réseaux portables disponibles dans chaque zone. Vous pouvez ajouter des sous-réseaux en suivant la procédure indiquée dans [Configuration de sous-réseaux pour les clusters](/docs/containers?topic=containers-subnets).
* Si vous limitez le trafic réseau aux noeuds worker de périphérie, vérifiez qu'au moins 2 [noeuds worker de périphérie](/docs/containers?topic=containers-edge#edge) sont activés dans chaque zone pour assurer le déploiement uniforme des équilibreurs de charge de réseau.
* Activez la fonction [Spanning VLAN](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning) pour votre compte d'infrastructure IBM Cloud afin que vos noeuds worker puissent communiquer entre eux sur le réseau privé. Pour effectuer cette action, vous devez disposer du [droit d'infrastructure](/docs/containers?topic=containers-users#infra_access) **Réseau > Gérer le spanning VLAN pour réseau**, ou vous pouvez demander au propriétaire du compte de l'activer. Pour vérifier si le spanning VLAN est déjà activé, utilisez la [commande](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get --region <region>`.
* Vérifiez que vous disposez du [rôle de service {{site.data.keyword.cloud_notm}} IAM **Auteur** ou **Responsable**](/docs/containers?topic=containers-users#platform) pour l'espace de nom `default`. 


Pour configurer un service d'équilibreur de charge de réseau 1.0 dans un cluster à zones multiples :
1.  [Déployez votre application sur le cluster](/docs/containers?topic=containers-app#app_cli). Prenez soin d'ajouter un libellé à votre déploiement dans la section "metadata" de votre fichier de configuration de déploiement. Ce libellé est nécessaire pour identifier tous les pods dans lesquels s'exécute votre application afin de pouvoir les inclure dans l'équilibrage de charge.

2.  Créez un service d'équilibreur de charge pour l'application que vous désirez exposer sur l'Internet public ou sur un réseau privé.
  1. Créez un fichier de configuration de service nommé, par exemple, `myloadbalancer.yaml`.
  2. Définissez un service d'équilibreur de charge pour l'application que vous désirez exposer. Vous pouvez spécifier une zone, un VLAN et une adresse IP.

      ```
      apiVersion: v1
      kind: Service
      metadata:
        name: myloadbalancer
        annotations:
          service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>
          service.kubernetes.io/ibm-load-balancer-cloud-provider-zone: "<zone>"
          service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan: "<vlan_id>"
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
        <td>Annotation utilisée pour spécifier un équilibreur de charge privé (<code>private</code>) ou public (<code>public</code>).</td>
      </tr>
      <tr>
        <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-zone:</code>
        <td>Annotation utilisée pour indiquer la zone dans laquelle est déployé le service d'équilibreur de charge. Pour voir les zones, exécutez la commande <code>ibmcloud ks zones</code>.</td>
      </tr>
      <tr>
        <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan:`
        <td>Annotation utilisée pour spécifier un VLAN sur lequel est déployé le service d'équilibreur de charge. Pour voir les VLAN, exécutez la commande <code>ibmcloud ks vlans --zone <zone></code>.</td>
      </tr>
      <tr>
        <td><code>selector</code></td>
        <td>Paire de libellés clé (<em>&lt;selector_key&gt;</em>)/valeur (<em>&lt;selector_value&gt;</em>) que vous avez utilisée dans la section <code>spec.template.metadata.labels</code> de votre fichier YAML de déploiement d'application.</td>
      </tr>
      <tr>
        <td><code>port</code></td>
        <td>Port sur lequel le service est à l'écoute.</td>
      </tr>
      <tr>
        <td><code>loadBalancerIP</code></td>
        <td>Facultatif : pour créer un équilibreur de charge privé ou utiliser une adresse IP portable spécifique pour un équilibreur de charge public, indiquez l'adresse IP que vous désirez utiliser. Cette adresse IP doit se trouver sur le VLAN et dans la zone que vous avez spécifiés dans les annotations. Si vous n'indiquez pas d'adresse IP :<ul><li>Si votre cluster se trouve sur un VLAN public, une adresse IP publique portable est utilisée. La plupart des clusters se trouvent sur un VLAN public.</li><li>Si votre cluster se trouve sur un VLAN privé uniquement, une adresse IP privée portable est utilisée.</li></ul></td>
      </tr>
      </tbody></table>

      Exemple de fichier de configuration utilisé pour créer un service d'équilibreur de charge de réseau 1.0 privé qui utilise une adresse IP indiquée sur le VLAN privé `2234945` dans la zone `dal12`:

      ```
      apiVersion: v1
      kind: Service
      metadata:
        name: myloadbalancer
        annotations:
          service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: private
          service.kubernetes.io/ibm-load-balancer-cloud-provider-zone: "dal12"
          service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan: "2234945"
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

  3. Facultatif : rendez votre service d'équilibreur de charge de réseau accessible uniquement à une plage d'adresses IP limitée en spécifiant les adresses IP dans la zone `spec.loadBalancerSourceRanges`. La zone `loadBalancerSourceRanges` est implémentée par `kube-proxy` dans votre cluster via des règles Iptables sur les noeuds worker. Pour plus d'informations, voir la [documentation Kubernetes ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/).

  4. Créez le service dans votre cluster.

      ```
      kubectl apply -f myloadbalancer.yaml
      ```
      {: pre}

3. Vérifiez que la création du service d'équilibreur de charge de réseau a abouti. La création du service et la mise à disposition de l'application peuvent prendre quelques minutes.

    ```
    kubectl describe service myloadbalancer
    ```
    {: pre}

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

    L'adresse IP **LoadBalancer Ingress** est l'adresse IP portable affectée à votre service d'équilibreur de charge de réseau.

4.  Si vous avez créé un équilibreur de charge de réseau public, accédez à votre application via Internet.
    1.  Ouvrez le navigateur Web de votre choix.
    2.  Entrez l'adresse IP publique portable de l'équilibreur de charge de réseau et le port.

        ```
        http://169.xx.xxx.xxx:8080
        ```
        {: codeblock}    

5. Répétez les étapes 2 à 4 pour ajouter un équilibreur de charge de réseau 1.0 dans chaque zone.    

6. Si vous choisissez d'[activer la conservation de l'adresse IP source pour un service d'équilibreur de charge de réseau 1.0](#node_affinity_tolerations), assurez-vous que les pods d'application sont planifiés sur les noeuds worker de périphérie en [ajoutant l'affinité de noeud de périphérie aux pods d'application](#lb_edge_nodes). Les pods d'application doivent être planifiés sur des noeuds de périphérie pour recevoir des demandes entrantes.

7. Facultatif : un service d'équilibreur de charge rend votre application accessible via les ports de noeud du service. Les [ports de noeud (NodePort)](/docs/containers?topic=containers-nodeport) sont accessibles sur toutes les adresses IP publiques et privées pour tous les noeuds figurant dans le cluster. Pour bloquer le trafic vers les ports de noeud lorsque vous utilisez un service d'équilibreur de charge de réseau, voir [Contrôle du trafic entrant vers les services d'équilibreur de charge de réseau (NLB) ou NodePort](/docs/containers?topic=containers-network_policies#block_ingress).

Ensuite, vous pouvez [enregistrer un nom d'hôte NLB](/docs/containers?topic=containers-loadbalancer_hostname).

<br />


## Configuration d'un équilibreur de charge de réseau 1.0 dans un cluster à zone unique
{: #lb_config}

**Avant de commencer** :
* Vous devez disposer d'une adresse IP publique ou privée portable disponible pour l'affecter au service d'équilibreur de charge de réseau. Pour plus d'informations, voir [Configuration de sous-réseaux pour les clusters](/docs/containers?topic=containers-subnets).
* Vérifiez que vous disposez du [rôle de service {{site.data.keyword.cloud_notm}} IAM **Auteur** ou **Responsable**](/docs/containers?topic=containers-users#platform) pour l'espace de nom `default`. 

Pour créer un service d'équilibreur de charge de réseau 1.0 dans un cluster à zone unique :

1.  [Déployez votre application sur le cluster](/docs/containers?topic=containers-app#app_cli). Prenez soin d'ajouter un libellé à votre déploiement dans la section "metadata" de votre fichier de configuration. Ce libellé est nécessaire pour identifier tous les pods dans lesquels s'exécute votre application afin de pouvoir les inclure dans l'équilibrage de charge.
2.  Créez un service d'équilibreur de charge pour l'application que vous désirez exposer sur l'Internet public ou sur un réseau privé.
    1.  Créez un fichier de configuration de service nommé, par exemple, `myloadbalancer.yaml`.

    2.  Définissez un service d'équilibreur de charge pour l'application que vous désirez exposer.
        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: myloadbalancer
          annotations:
            service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>
            service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan: "<vlan_id>"
        spec:
          type: LoadBalancer
          selector:
            <selector_key>: <selector_value>
          ports:
           - protocol: TCP
             port: 8080
          loadBalancerIP: <IP_address>
          externalTrafficPolicy: Local
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
          <td>Annotation utilisée pour spécifier un équilibreur de charge privé (<code>private</code>) ou public (<code>public</code>).</td>
        </tr>
        <tr>
          <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan:`
          <td>Annotation utilisée pour spécifier un VLAN sur lequel est déployé le service d'équilibreur de charge. Pour voir les VLAN, exécutez la commande <code>ibmcloud ks vlans --zone <zone></code>.</td>
        </tr>
        <tr>
          <td><code>selector</code></td>
          <td>Paire de libellés clé (<em>&lt;selector_key&gt;</em>)/valeur (<em>&lt;selector_value&gt;</em>) que vous avez utilisée dans la section <code>spec.template.metadata.labels</code> de votre fichier YAML de déploiement d'application.</td>
        </tr>
        <tr>
          <td><code>port</code></td>
          <td>Port sur lequel le service est à l'écoute.</td>
        </tr>
        <tr>
          <td><code>loadBalancerIP</code></td>
          <td>Facultatif : pour créer un équilibreur de charge privé ou utiliser une adresse IP portable spécifique pour un équilibreur de charge public, indiquez l'adresse IP que vous désirez utiliser. Cette adresse IP doit se trouver sur le VLAN que vous avez spécifié dans les annotations. Si vous n'indiquez pas d'adresse IP :<ul><li>Si votre cluster se trouve sur un VLAN public, une adresse IP publique portable est utilisée. La plupart des clusters se trouvent sur un VLAN public.</li><li>Si votre cluster se trouve sur un VLAN privé uniquement, une adresse IP privée portable est utilisée.</li></ul></td>
        </tr>
        </tbody></table>

        Exemple de fichier de configuration utilisé pour créer un service d'équilibreur de charge de réseau 1.0 privé qui utilise une adresse IP indiquée sur le VLAN privé `2234945` :

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: myloadbalancer
          annotations:
            service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: private
            service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan: "2234945"
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

    3. Facultatif : rendez votre service d'équilibreur de charge de réseau accessible uniquement à une plage d'adresses IP limitée en spécifiant les adresses IP dans la zone `spec.loadBalancerSourceRanges`. La zone `loadBalancerSourceRanges` est implémentée par `kube-proxy` dans votre cluster via des règles Iptables sur les noeuds worker. Pour plus d'informations, voir la [documentation Kubernetes ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/).

    4.  Créez le service dans votre cluster.

        ```
        kubectl apply -f myloadbalancer.yaml
        ```
        {: pre}

3.  Vérifiez que la création du service d'équilibreur de charge de réseau a abouti. La création du service et la mise à disposition de l'application peuvent prendre quelques minutes.

    ```
    kubectl describe service myloadbalancer
    ```
    {: pre}

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

    L'adresse IP **LoadBalancer Ingress** est l'adresse IP portable affectée à votre service d'équilibreur de charge de réseau.

4.  Si vous avez créé un équilibreur de charge de réseau public, accédez à votre application via Internet.
    1.  Ouvrez le navigateur Web de votre choix.
    2.  Entrez l'adresse IP publique portable de l'équilibreur de charge de réseau et le port.

        ```
        http://169.xx.xxx.xxx:8080
        ```
        {: codeblock}

5. Si vous choisissez d'[activer la conservation de l'adresse IP source pour un service d'équilibreur de charge de réseau 1.0](#node_affinity_tolerations), assurez-vous que les pods d'application sont planifiés sur les noeuds worker de périphérie en [ajoutant l'affinité de noeud de périphérie aux pods d'application](#lb_edge_nodes). Les pods d'application doivent être planifiés sur des noeuds de périphérie pour recevoir des demandes entrantes.

6. Facultatif : un service d'équilibreur de charge rend votre application accessible via les ports de noeud du service. Les [ports de noeud (NodePort)](/docs/containers?topic=containers-nodeport) sont accessibles sur toutes les adresses IP publiques et privées pour tous les noeuds figurant dans le cluster. Pour bloquer le trafic vers les ports de noeud lorsque vous utilisez un service d'équilibreur de charge de réseau, voir [Contrôle du trafic entrant vers les services d'équilibreur de charge de réseau (NLB) ou NodePort](/docs/containers?topic=containers-network_policies#block_ingress).

Ensuite, vous pouvez [enregistrer un nom d'hôte NLB](/docs/containers?topic=containers-loadbalancer_hostname#loadbalancer_hostname).

<br />


## Activation de la conservation de l'adresse IP source
{: #node_affinity_tolerations}

Cette fonction est applicable uniquement aux équilibreurs de charge de réseau 1.0. Par défaut, l'adresse IP source des demandes du client est conservée dans les équilibreurs de charge de réseau 2.0.
{: note}

Lorsqu'une demande du client destinée à votre application est envoyée à votre cluster, un pod de service d'équilibreur de charge reçoit la demande. S'il n'existe aucun pod d'application sur le même noeud worker que le pod de service d'équilibreur de charge, l'équilibreur de charge de réseau transmet la demande à un pod d'application sur un autre noeud worker. L'adresse IP source du package est remplacée par l'adresse IP publique du noeud worker sur lequel s'exécute le pod de service d'équilibreur de charge.
{: shortdesc}

Pour conserver l'adresse IP source d'origine de la demande du client, vous pouvez [activer l'adresse IP source ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/#preserving-the-client-source-ip) pour les services d'équilibreur de charge. La connexion TCP se poursuit jusqu'aux pods d'application de sorte que l'application puisse voir l'adresse IP source réelle du demandeur. Conserver l'adresse IP du client est pratique, notamment lorsque les serveurs d'applications doivent appliquer des règles de sécurité et de contrôle d'accès.

Après avoir activé l'adresse IP source, les pods de service d'équilibreur de charge doivent transférer les demandes aux pods d'application déployés sur le même noeud worker uniquement. En principe, des pods de service d'équilibreur de charge sont également déployés sur les noeuds worker sur lesquels sont déployés les pods d'application. Il existe cependant des situations où les pods d'équilibreur de charge et les pods d'application ne sont pas forcément planifiés sur le même noeud worker :

* Vous disposez de noeuds de périphérie avec des annotations taint de sorte que seuls les pods du service d'équilibreur de charge puissent se déployer sur ces noeuds. Le déploiement des pods d'application n'est pas autorisé sur ces noeuds.
* Votre cluster est connecté à plusieurs réseaux locaux virtuels (VLAN) publics ou privés, et vos pods d'application peuvent se déployer sur des noeuds worker connectés uniquement à un seul VLAN. Les pods de service d'équilibreur de charge risquent de ne pas se déployer sur ces noeuds worker car l'adresse IP de l'équilibreur de charge de réseau est connectée à un autre VLAN que les noeuds worker.

Pour forcer le déploiement de votre application sur des noeuds worker spécifiques sur lesquels peuvent se déployer des pods de service d'équilibreur de charge, vous devez ajouter des règles d'affinité et des tolérances au déploiement de votre application.

### Ajout de règles d'affinité et de tolérances pour les noeuds de périphérie
{: #lb_edge_nodes}

Lorsque vous [labellisez des noeuds worker en tant que noeuds de périphérie](/docs/containers?topic=containers-edge#edge_nodes) et que vous ajoutez des [annotations taint à ces noeuds de périphérie](/docs/containers?topic=containers-edge#edge_workloads), les pods de service d'équilibreur de charge se déploient uniquement sur ces noeuds de périphérie et les pods d'application ne peuvent pas se déployer sur les noeuds de périphérie. Lorsque l'adresse IP source est activée pour le service d'équilibreur de charge de réseau, les pods d'équilibreur de charge sur les noeuds de périphérie ne peuvent pas transférer les demandes entrantes vers vos pods d'application sur d'autres noeuds worker.
{:shortdesc}

Pour forcer le déploiement de vos pods d'application sur des noeuds de périphérie, ajoutez une [règle d'affinité ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#node-affinity-beta-feature) et une [tolérance (toleration) ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/#concepts) de noeud de périphérie au déploiement de l'application.

Exemple de fichier YAML de déploiement avec les règles d'affinité et de tolérance pour les noeuds de périphérie :

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: with-node-affinity
spec:
  selector:
    matchLabels:
      <label_name>: <label_value>
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

Lorsque votre cluster est connecté à plusieurs réseaux locaux virtuels (VLAN) publics ou privés, vos pods d'application peuvent se déployer sur des noeuds worker connectés uniquement à un seul VLAN. Si l'adresse IP de l'équilibreur de charge de réseau est connectée à un autre VLAN que ces noeuds worker, les pods de service d'équilibreur de charge ne pourront pas se déployer sur ces noeuds worker.
{:shortdesc}

Lorsque l'adresse IP source est activée, planifiez les pods d'application sur les noeuds worker avec le même VLAN que l'adresse IP de l'équilibreur de charge de réseau en ajoutant une règle d'affinité au déploiement de l'application.

Avant de commencer : [connectez-vous à votre compte. Le cas échéant, ciblez le groupe de ressources approprié. Définissez le contexte pour votre cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

1. Procurez-vous l'adresse IP du service d'équilibreur de charge de réseau. Recherchez cette adresse dans la zone **LoadBalancer Ingress**.
    ```
    kubectl describe service <loadbalancer_service_name>
    ```
    {: pre}

2. Récupérez l'ID VLAN auquel votre service d'équilibreur de charge de réseau est connecté.

    1. Affichez la liste des VLAN publics portables de votre cluster.
        ```
        ibmcloud ks cluster-get --cluster <cluster_name_or_ID> --showResources
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

    2. Dans la sortie sous **Subnet VLANs**, recherchez le routage CIDR de sous-réseau correspondant à l'adresse IP NLB que vous avez récupérée précédemment et notez l'ID du VLAN.

        Par exemple, si l'adresse IP du service d'équilibreur de charge de réseau est `169.36.5.xxx`, le sous-réseau correspondant dans l'exemple de sortie de l'étape précédente est `169.36.5.xxx/29`. L'ID du VLAN auquel est connecté ce sous-réseau est `2234945`.

3. [Ajoutez une règle d'affinité ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#node-affinity-beta-feature) au déploiement d'application pour l'ID du VLAN que vous avez noté à l'étape précédente.

    Par exemple, si vous disposez de plusieurs VLAN et que vous souhaitez que vos pods d'application se déploient sur des noeuds worker résidant uniquement sur le VLAN public `2234945` :

    ```
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: with-node-affinity
    spec:
      selector:
        matchLabels:
          <label_name>: <label_value>
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
