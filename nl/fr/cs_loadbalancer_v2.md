---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

keywords: kubernetes, iks, lb2.0, nlb

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



# Configuration d'un équilibreur de charge de réseau 2.0 (bêta)
{: #loadbalancer-v2}

Exposez un port et utilisez une adresse IP portable pour un équilibreur de charge de réseau de couche 4 afin d'exposer une application conteneurisée.
Pour plus d'informations sur les équilibreurs de charge de réseau 2.0, voir [Composants et architecture d'un équilibreur de charge de réseau 2.0](/docs/containers?topic=containers-loadbalancer-about#planning_ipvs).
{:shortdesc}

## Prérequis
{: #ipvs_provision}

Vous ne pouvez pas mettre à jour un équilibreur de charge de réseau 1.0 vers la version 2.0. Vous devez créer un nouvel équilibreur de charge de réseau 2.0. Notez que vous pouvez exécuter des équilibreurs de charge de réseau 1.0 et 2.0 simultanément dans un cluster.
{: shortdesc}

Avant de créer un équilibreur de charge de réseau 2.0, vous devez respecter la procédure prérequise suivante.

1. [Mettez à jour le maître et les noeuds worker de votre cluster](/docs/containers?topic=containers-update) vers Kubernetes version 1.12 ou ultérieure.

2. Pour permettre à votre équilibreur de charge de réseau version 2.0 de transférer les demandes aux pods d'application dans plusieurs zones, ouvrez un cas de support afin de demander l'agrégation de capacité pour vos réseaux locaux virtuels (VLAN). Ce paramètre de configuration ne provoque pas d'indisponibilité ou d'interruption de réseau.
    1. Connectez-vous à la [console{{site.data.keyword.cloud_notm}}](https://cloud.ibm.com/). 
    2. Dans la barre de menu, cliquez sur **Support**, cliquez sur l'onglet **Gérer les cas**, puis sur **Créer un cas**.
    3. Dans les zones correspondant au cas, indiquez ceci :
       * Comme type de support, sélectionnez **Technique**.
       * Comme catégorie, sélectionnez **Spanning VLAN**.
       * Comme objet, saisissez **Public and private VLAN network question**. 
    4. Ajoutez les informations suivantes à la description : "Please set up the network to allow capacity aggregation on the public and private VLANs associated with my account. The reference ticket for this request is: https://control.softlayer.com/support/tickets/63859145". Notez que si vous souhaitez autoriser l'agrégation de capacité sur des réseaux VLAN spécifiques, tels que les VLAN publics pour un seul cluster, vous pouvez spécifier ces ID VLAN dans la description.
    5. Cliquez sur **Soumettre**.

3. Activez une fonction [VRF (Virtual Router Function)](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud) pour votre compte d'infrastructure IBM Cloud. Pour activer la fonction VRF, [contactez le représentant de votre compte d'infrastructure IBM Cloud](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#how-you-can-initiate-the-conversion). Pour vérifier si la fonction VRF est déjà activée, utilisez la commande `ibmcloud account show`. Si vous ne parvenez pas à activer la fonction VRF ou si vous ne souhaitez pas le faire, activez la fonction [Spanning VLAN](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning). Lorsqu'une fonction VRF ou Spanning VLAN est activée, l'équilibreur de charge de réseau 2.0 peut router des paquets vers différents sous-réseaux dans le compte.

4. Si vous utilisez des [règles réseau Calico pre-DNAT](/docs/containers?topic=containers-network_policies#block_ingress) pour gérer le trafic à destination de l'adresse IP d'un équilibreur de charge de réseau 2.0, vous devez ajouter les zones `applyOnForward: true` et `doNotTrack: true` et retirer la zone `preDNAT: true` dans la section `spec` dans ces règles. `applyOnForward: true` garantit l'application de la règle Calico au trafic à mesure qu'il est encapsulé et transféré. `doNotTrack: true` garantit que les noeuds worker peuvent utiliser le mode DSR pour renvoyer un paquet de réponses directement au client sans avoir besoin d'assurer le suivi de la connexion. Par exemple, si vous utilisez une règle Calico pour placer en liste blanche le trafic provenant uniquement d'adresses IP spécifiques vers l'adresse IP de votre équilibreur de charge de réseau, la règle ressemble à ce qui suit :
    ```
    apiVersion: projectcalico.org/v3
    kind: GlobalNetworkPolicy
    metadata:
      name: whitelist
    spec:
      applyOnForward: true
      doNotTrack: true
      ingress:
      - action: Allow
        destination:
          nets:
          - <loadbalancer_IP>/32
          ports:
          - 80
        protocol: TCP
        source:
          nets:
          - <client_address>/32
      selector: ibm.role=='worker_public'
      order: 500
      types:
      - Ingress
    ```
    {: screen}

Vous pouvez ensuite suivre la procédure décrite dans [Configuration d'un équilibreur de charge de réseau 2.0 dans un cluster à zones multiples](#ipvs_multi_zone_config) ou [dans un cluster à zone unique](#ipvs_single_zone_config).

<br />


## Configuration d'un équilibreur de charge de réseau 2.0 dans un cluster à zones multiples
{: #ipvs_multi_zone_config}

**Avant de commencer** :

* **Important** : effectuez les [tâches prérequises relatives à l'équilibreur de charge de réseau 2.0](#ipvs_provision).
* Pour pouvoir créer des équilibreurs de charge de réseau publics dans plusieurs zones, au moins un VLAN public doit comporter des sous-réseaux portables disponibles dans chaque zone. Pour pouvoir créer des équilibreurs de charge de réseau (NLB) privés dans plusieurs zones, au moins un VLAN privé doit comporter des sous-réseaux portables disponibles dans chaque zone. Vous pouvez ajouter des sous-réseaux en suivant la procédure indiquée dans [Configuration de sous-réseaux pour les clusters](/docs/containers?topic=containers-subnets).
* Si vous limitez le trafic réseau aux noeuds worker de périphérie, vérifiez qu'au moins deux [noeuds worker de périphérie](/docs/containers?topic=containers-edge#edge) sont activés dans chaque zone pour assurer le déploiement uniforme des équilibreurs de charge de réseau. 
* Vérifiez que vous disposez du [rôle de service {{site.data.keyword.cloud_notm}} IAM **Auteur** ou **Responsable**](/docs/containers?topic=containers-users#platform) pour l'espace de nom `default`. 


Pour configurer un équilibreur de charge de réseau 2.0 dans un cluster à zones multiples :
1.  [Déployez votre application sur le cluster](/docs/containers?topic=containers-app#app_cli). Prenez soin d'ajouter un libellé à votre déploiement dans la section "metadata" de votre fichier de configuration. Ce libellé est nécessaire pour identifier tous les pods dans lesquels s'exécute votre application afin de pouvoir les inclure dans l'équilibrage de charge.

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
          service.kubernetes.io/ibm-load-balancer-cloud-provider-enable-features: "ipvs"
          service.kubernetes.io/ibm-load-balancer-cloud-provider-scheduler: "<algorithm>"
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
        <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-enable-features: "ipvs"</code>
        <td>Annotation utilisée pour spécifier un équilibreur de charge version 2.0.</td>
      </tr>
      <tr>
        <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-scheduler:</code>
        <td>Facultatif : annotation utilisée pour spécifier l'algorithme de planification. Les valeurs admises sont : <code>"rr"</code> pour Round Robin (valeur par défaut) ou <code>"sh"</code> pour Source Hashing. Pour plus d'informations, voir [2.0 : Algorithmes de planification](#scheduling).</td>
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
        <td>Facultatif : pour créer un équilibreur de charge de réseau privé ou utiliser une adresse IP portable spécifique pour un équilibreur de charge de réseau public, indiquez l'adresse IP que vous désirez utiliser. Cette adresse IP doit se trouver dans la zone et dans le VLAN que vous avez spécifiés dans les annotations. Si vous n'indiquez pas d'adresse IP :<ul><li>Si votre cluster se trouve sur un VLAN public, une adresse IP publique portable est utilisée. La plupart des clusters se trouvent sur un VLAN public.</li><li>Si votre cluster se trouve sur un VLAN privé uniquement, une adresse IP privée portable est utilisée.</li></ul></td>
      </tr>
      <tr>
        <td><code>externalTrafficPolicy: Local</code></td>
        <td>Défini avec <code>Local</code>.</td>
      </tr>
      </tbody></table>

      Exemple de fichier de configuration utilisé pour créer un service d'équilibreur de charge de réseau 2.0 dans la zone `dal12` utilisant l'algorithme de planification Round Robin :

      ```
      apiVersion: v1
      kind: Service
      metadata:
        name: myloadbalancer
        annotations:
          service.kubernetes.io/ibm-load-balancer-cloud-provider-zone: "dal12"
          service.kubernetes.io/ibm-load-balancer-cloud-provider-enable-features: "ipvs"
          service.kubernetes.io/ibm-load-balancer-cloud-provider-scheduler: "rr"
      spec:
        type: LoadBalancer
        selector:
          app: nginx
        ports:
         - protocol: TCP
           port: 8080
        externalTrafficPolicy: Local
      ```
      {: codeblock}

  3. Facultatif : rendez votre service d'équilibreur de charge de réseau accessible uniquement à une plage d'adresses IP limitée en spécifiant les adresses IP dans la zone `spec.loadBalancerSourceRanges`.  La zone `loadBalancerSourceRanges` est implémentée par `kube-proxy` dans votre cluster via des règles Iptables sur les noeuds worker. Pour plus d'informations, voir la [documentation Kubernetes ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/).

  4. Créez le service dans votre cluster.

      ```
      kubectl apply -f myloadbalancer.yaml
      ```
      {: pre}

3. Vérifiez que la création du service d'équilibreur de charge de réseau a abouti. La création du service d'équilibreur de charge de réseau et la mise à disposition de l'application peuvent prendre quelques minutes.

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

5. Pour assurer la haute disponibilité, répétez les étapes 2 à 4 pour ajouter un équilibreur de charge de réseau 2.0 dans chaque zone où vous disposez d'instances d'application.

6. Facultatif : un service d'équilibreur de charge de réseau rend votre application accessible via les ports de noeud du service. Les [ports de noeud (NodePort)](/docs/containers?topic=containers-nodeport) sont accessibles sur toutes les adresses IP publiques et privées pour tous les noeuds figurant dans le cluster. Pour bloquer le trafic vers les ports de noeud lorsque vous utilisez un service d'équilibreur de charge de réseau, voir [Contrôle du trafic entrant vers les services d'équilibreur de charge de réseau (NLB) ou NodePort](/docs/containers?topic=containers-network_policies#block_ingress).

Ensuite, vous pouvez [enregistrer un nom d'hôte NLB](/docs/containers?topic=containers-loadbalancer_hostname).

<br />


## Configuration d'un équilibreur de charge de réseau 2.0 dans un cluster à zone unique
{: #ipvs_single_zone_config}

**Avant de commencer** :

* **Important** : effectuez les [tâches prérequises relatives à l'équilibreur de charge de réseau 2.0](#ipvs_provision).
* Vous devez disposer d'une adresse IP publique ou privée portable disponible pour l'affecter au service d'équilibreur de charge de réseau. Pour plus d'informations, voir [Configuration de sous-réseaux pour les clusters](/docs/containers?topic=containers-subnets).
* Vérifiez que vous disposez du [rôle de service {{site.data.keyword.cloud_notm}} IAM **Auteur** ou **Responsable**](/docs/containers?topic=containers-users#platform) pour l'espace de nom `default`. 

Pour créer un service d'équilibreur de charge de réseau 2.0 dans un cluster à zone unique :

1.  [Déployez votre application sur le cluster](/docs/containers?topic=containers-app#app_cli). Prenez soin d'ajouter un libellé à votre déploiement dans la section "metadata" de votre fichier de configuration. Ce libellé est nécessaire pour identifier tous les pods dans lesquels s'exécute votre application afin de pouvoir les inclure dans l'équilibrage de charge.
2.  Créez un service d'équilibreur de charge pour l'application que vous désirez exposer sur l'Internet public ou sur un réseau privé.
    1.  Créez un fichier de configuration de service nommé, par exemple, `myloadbalancer.yaml`.

    2.  Définissez un service d'équilibreur de charge 2.0 pour l'application que vous souhaitez exposer.
        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: myloadbalancer
          annotations:
            service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>
            service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan: "<vlan_id>"
            service.kubernetes.io/ibm-load-balancer-cloud-provider-enable-features: "ipvs"
            service.kubernetes.io/ibm-load-balancer-cloud-provider-scheduler: "<algorithm>"
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
          <td>Facultatif : annotation utilisée pour spécifier un VLAN sur lequel est déployé le service d'équilibreur de charge. Pour voir les VLAN, exécutez la commande <code>ibmcloud ks vlans --zone <zone></code>.</td>
        </tr>
        <tr>
          <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-enable-features: "ipvs"</code>
          <td>Annotation utilisée pour spécifier un équilibreur de charge 2.0.</td>
        </tr>
        <tr>
          <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-scheduler:</code>
          <td>Facultatif : annotation utilisée pour spécifier un algorithme de planification. Les valeurs admises sont : <code>"rr"</code> pour Round Robin (valeur par défaut) ou <code>"sh"</code> pour Source Hashing. Pour plus d'informations, voir [2.0 : Algorithmes de planification](#scheduling).</td>
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
          <td>Facultatif : pour créer un équilibreur de charge de réseau privé ou utiliser une adresse IP portable spécifique pour un équilibreur de charge de réseau public, indiquez l'adresse IP que vous désirez utiliser. Cette adresse IP doit se trouver sur le VLAN que vous avez spécifié dans les annotations. Si vous n'indiquez pas d'adresse IP :<ul><li>Si votre cluster se trouve sur un VLAN public, une adresse IP publique portable est utilisée. La plupart des clusters se trouvent sur un VLAN public.</li><li>Si votre cluster se trouve sur un VLAN privé uniquement, une adresse IP privée portable est utilisée.</li></ul></td>
        </tr>
        <tr>
          <td><code>externalTrafficPolicy: Local</code></td>
          <td>Défini avec <code>Local</code>.</td>
        </tr>
        </tbody></table>

    3.  Facultatif : rendez votre service d'équilibreur de charge de réseau accessible uniquement à une plage d'adresses IP limitée en spécifiant les adresses IP dans la zone `spec.loadBalancerSourceRanges`. La zone `loadBalancerSourceRanges` est implémentée par `kube-proxy` dans votre cluster via des règles Iptables sur les noeuds worker. Pour plus d'informations, voir la [documentation Kubernetes ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/).

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

5. Facultatif : un service d'équilibreur de charge de réseau rend votre application accessible via les ports de noeud du service. Les [ports de noeud (NodePort)](/docs/containers?topic=containers-nodeport) sont accessibles sur toutes les adresses IP publiques et privées pour tous les noeuds figurant dans le cluster. Pour bloquer le trafic vers les ports de noeud lorsque vous utilisez un service d'équilibreur de charge de réseau, voir [Contrôle du trafic entrant vers les services d'équilibreur de charge de réseau (NLB) ou NodePort](/docs/containers?topic=containers-network_policies#block_ingress).

Ensuite, vous pouvez [enregistrer un nom d'hôte NLB](/docs/containers?topic=containers-loadbalancer_hostname).

<br />


## Algorithmes de planification
{: #scheduling}

Les algorithmes de planification déterminent comment un équilibreur de charge de réseau 2.0 affecte des connexions réseau à vos pods d'application. Lorsque les demandes du client parviennent à votre cluster, l'équilibreur de charge de réseau achemine les paquets de demandes aux noeuds worker en fonction de l'algorithme de planification. Pour utiliser un algorithme de planification, indiquez son nom abrégé Keepalived dans l'annotation du planificateur du fichier de configuration de votre service d'équilibreur de charge de réseau : `service.kubernetes.io/ibm-load-balancer-cloud-provider-scheduler: "rr"`. Consultez les listes suivantes pour voir les algorithmes de planification pris en charge dans {{site.data.keyword.containerlong_notm}}. Si vous n'indiquez pas d'algorithme de planification, l'algorithme Round Robin (rr) est utilisé par défaut. Pour plus d'informations, voir la [documentation Keepalived ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](http://www.Keepalived.org/doc/scheduling_algorithms.html).
{: shortdesc}

### Algorithmes de planification pris en charge
{: #scheduling_supported}

<dl>
<dt>Round Robin (<code>rr</code>)</dt>
<dd>L'équilibreur de charge de réseau parcourt la liste des pods d'application lors de l'acheminement des connexions aux noeuds worker, en traitant chaque pod d'application de la même manière. Round Robin (rr) est l'algorithme de planification par défaut des équilibreurs de charge de réseau 2.0.</dd>
<dt>Source Hashing (<code>sh</code>)</dt>
<dd>L'équilibreur de charge de réseau génère une clé de hachage en fonction de l'adresse IP source du paquet de demandes du client. L'équilibreur de charge de réseau recherche ensuite la clé de hachage dans une table de hachage affectée de manière statique et achemine la demande au pod d'application qui traite les hachages de cette plage. Cet algorithme garantit que les demandes d'un client particulier sont toujours dirigées vers le même pod d'application. </br>**Remarque** : Kubernetes utilise des règles Iptables, ce qui entraîne l'envoi des demandes à un pod aléatoire sur le noeud worker. Pour utiliser cet algorithme de planification, vous devez vous assurer qu'il n'y a qu'un seul pod de votre application déployé par noeud worker. Par exemple, si chaque pod est labellisé <code>run=&lt;app_name&gt;</code>, ajoutez la règle d'anti-affinité suivante dans la section <code>spec</code> du déploiement de votre application : </br>
<pre class="codeblock">
<code>
    spec:
      affinity:
        podAntiAffinity:
          preferredDuringSchedulingIgnoredDuringExecution:
          - weight: 100
        podAffinityTerm:
          labelSelector:
            matchExpressions:
                - key: run
                  operator: In
                  values:
                  - <APP_NAME>
              topologyKey: kubernetes.io/hostname</code></pre>

Vous pouvez retrouver l'exemple complet dans [ce blogue de modèles de déploiement IBM Cloud ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://www.ibm.com/blogs/bluemix/2018/10/ibm-cloud-kubernetes-service-deployment-patterns-4-multi-zone-cluster-app-exposed-via-loadbalancer-aggregating-whole-region-capacity/).</dd>
</dl>

### Algorithmes de planification non pris en charge
{: #scheduling_unsupported}

<dl>
<dt>Destination Hashing (<code>dh</code>)</dt>
<dd>La destination du paquet, qui correspond à l'adresse IP et au port de l'équilibreur de charge de réseau, est utilisée pour déterminer le noeud worker qui traite la demande entrante. Cependant, l'adresse IP et le port des équilibreurs de charge de réseau dans {{site.data.keyword.containerlong_notm}} ne bougent pas. L'équilibreur de charge de réseau est obligé de conserver la demande dans le même noeud worker où il se trouve, donc seuls les pods d'application sur un noeud worker traitent toutes les demandes entrantes.</dd>
<dt>Algorithmes de comptabilisation dynamique des connexions</dt>
<dd>Les algorithmes suivants dépendent de la comptabilisation dynamique des connexions entre les clients et les équilibreurs de charge de réseau. Cependant le mode DSR (Direct Service Return) empêche les pods d'équilibreur de charge de réseau 2.0 d'être dans le chemin des paquets renvoyés et les équilibreurs de charge de réseau n'assurent pas le suivi des connexions établies. <ul>
<li>Least Connection (<code>lc</code>)</li>
<li>Locality-Based Least Connection (<code>lblc</code>)</li>
<li>Locality-Based Least Connection with Replication (<code>lblcr</code>)</li>
<li>Never Queue (<code>nq</code>)</li>
<li>Shortest Expected Delay (<code>seq</code>)</li></ul></dd>
<dt>Algorithmes de pods pondérés</dt>
<dd>Les algorithmes suivants dépendent des pods d'application pondérés. Cependant, dans {{site.data.keyword.containerlong_notm}}, une pondération égale est affectée à tous les pods d'application pour l'équilibrage de charge.<ul>
<li>Weighted Least Connection (<code>wlc</code>)</li>
<li>Weighted Round Robin (<code>wrr</code>)</li></ul></dd></dl>
