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



# Exposition d'applications avec des équilibreurs de charge
{: #loadbalancer}

Exposez un port et utilisez une adresse IP pour un équilibreur de charge (couche 4) pour accéder à une application conteneurisée.
{:shortdesc}

Lorsque vous créez un cluster standard, un sous-réseau public portable et un sous-réseau privé portable sont fournis automatiquement par {{site.data.keyword.containerlong}}.

* Le sous-réseau public portable fournit 5 adresses IP utilisables. 1 adresse IP publique portable est utilisée par l'[équilibreur de charge d'application (ALB) Ingress public](cs_ingress.html) par défaut. Les 4 autres adresses IP publiques portables peuvent être utilisées pour exposer des applications individuelles sur Internet en créant des services d'équilibreur de charge publics.
* Le sous-réseau privé portable fournit 5 adresses IP utilisables. 1 adresse IP privée portable est utilisée par l'[équilibreur de charge d'application (ALB) Ingress privé](cs_ingress.html#private_ingress) par défaut. Les 4 autres adresses IP privées portables peuvent être utilisées pour exposer des applications individuelles sur un réseau privé en créant des services d'équilibreur de charge privés.

Les adresses IP publiques et privées portables sont des adresses IP flottantes statiques et ne changent pas en cas de retrait d'un noeud worker. Si le noeud worker dans lequel figure l'adresse IP de l'équilibreur de charge est retiré, un démon Keepalived qui surveille en permanence l'adresse IP transfère automatiquement l'adresse IP sur un autre noeud worker. Vous pouvez affecter n'importe quel port à votre équilibreur de charge et n'êtes pas obligé d'utiliser une plage de ports particulière. Le service d'équilibreur de charge fait office de point d'entrée externe pour les demandes entrantes vers votre application. Pour accéder au service d'équilibreur de charge depuis Internet, utilisez l'adresse IP publique de votre équilibreur de charge et le port affecté en utilisant le format `<IP_address>:<port>`.

Lorsque vous exposez une application avec un service d'équilibreur de charge, elle est également automatiquement mise à disposition sur les ports de noeud (NodePort) du service. Les [ports de noeud](cs_nodeport.html) sont accessibles sur toutes les adresses IP publiques et privées de tous les noeuds worker figurant dans le cluster. Pour bloquer le trafic vers les ports de noeud lorsque vous utilisez un service d'équilibreur de charge, voir [Contrôle du trafic entrant vers les services d'équilibreur de charge ou NodePort](cs_network_policy.html#block_ingress).

## Composants et architecture de l'équilibreur de charge 2.0 (bêta)
{: #planning_ipvs}

Les fonctionnalités de l'équilibreur de charge 2.0 sont en version bêta. Pour utiliser un équilibreur de charge 2.0, vous devez [mettre à jour le maître et les noeuds worker de votre cluster](cs_cluster_update.html) avec la version 1.12 ou ultérieure de Kubernetes.
{: note}

L'équilibreur de charge 2.0 est un équilibreur de charge de couche 4 qui est implémenté à l'aide du serveur IPVS (IP Virtual Server) du noyau Linux. Il prend en charge les protocoles TCP et UDP, s'exécute devant plusieurs noeuds worker et utilise un tunnel IP sur IP (IPIP) pour distribuer le trafic arrivant sur une adresse IP d'équilibreur de charge unique sur ces noeuds worker.

Pour plus de détails, vous pouvez également consulter cet [article de blogue ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://www.ibm.com/blogs/bluemix/2018/10/ibm-cloud-kubernetes-service-deployment-patterns-for-maximizing-throughput-and-availability/) sur l'équilibreur de charge 2.0.

### Les équilibreurs de charge des versions 1.0 et 2.0 sont-ils semblables ?
{: #similarities}

Les équilibreurs de charge des versions 1.0 et 2.0 sont des équilibreurs de charge de couche 4 qui n'existent que dans l'espace du noyau Linux. Ces deux versions s'exécutent dans le cluster et utilisent des ressources de noeud worker. Par conséquent, la capacité disponible des équilibreurs de charge est toujours dédiée à votre propre cluster. Par ailleurs, ces deux versions d'équilibreurs de charge ne mettent pas fin à la connexion. Les connexions sont transférées à un pod d'application à la place.

### Quelles sont les différences entre les équilibreurs de charge des versions 1.0 et 2.0 ?
{: #differences}

Lorsqu'un client envoie une demande à votre application, l'équilibreur de charge achemine des paquets de demandes à l'adresse IP du noeud worker où il existe un pod d'application. Les équilibreurs de charge de version 1.0 utilisent une conversion d'adresses réseau (NAT) pour réécrire l'adresse IP source du paquet de demandes sur l'adresse IP du noeud worker où il existe un pod d'équilibreur de charge. Lorsque le noeud worker renvoie un paquet de réponses d'application, il utilise l'adresse IP du noeud worker où se trouve l'équilibreur de charge. L'équilibreur de charge doit ensuite envoyer le paquet de réponses au client. Pour empêcher la réécriture de l'adresse IP, vous pouvez [activer la conservation de l'adresse IP source](#node_affinity_tolerations). Cependant, la conservation de l'adresse IP source nécessite que les pods d'équilibreur de charge et les pods d'application s'exécutent sur le même noeud worker pour éviter d'avoir à transférer la demande vers un autre noeud worker. Vous devez ajouter des propriétés d'affinité de noeud et de tolérance aux pods d'application.

Contrairement aux équilibreurs de charge version 1.0, les équilibreurs de charge version 2.0 n'utilisent pas la conversion NAT lors du transfert des demandes aux pods d'application sur d'autres noeuds worker. Lorsqu'un équilibreur de charge 2.0 achemine une demande client, il utilise un tunnel IP sur IP (IPIP) pour encapsuler le paquet de demandes d'origine dans un nouveau paquet distinct. Ce paquet comporte une adresse IP source du noeud worker dans lequel se trouve le pod d'équilibreur de charge, ce qui permet au paquet de demandes d'origine de conserver l'adresse IP du client comme adresse IP source. Le noeud worker utilise ensuite le mode DSR (Direct Server Return) pour envoyer le paquet de réponses de l'application à l'adresse IP du client. Le paquet de réponses ignore l'équilibreur de charge et est envoyé directement au client, réduisant ainsi la quantité de trafic que l'équilibreur de charge doit traiter.

### Comment une demande parvient-elle à mon application avec un équilibreur de charge 2.0 dans un cluster à zone unique ?
{: #ipvs_single}

Le diagramme suivant illustre comment un équilibreur de charge 2.0 dirige la communication d'Internet vers une application dans un cluster à zone unique.

<img src="images/cs_loadbalancer_ipvs_planning.png" width="550" alt="Exposition d'une application dans {{site.data.keyword.containerlong_notm}} à l'aide d'un équilibreur de charge version 2.0" style="width:550px; border-style: none"/>

1. Une demande client adressée à votre application utilise l'adresse IP publique de votre équilibreur de charge et le port affecté sur le noeud worker. Dans cet exemple, l'équilibreur de charge a l'adresse IP virtuelle 169.61.23.130, qui se trouve sur le noeud worker 10.73.14.25.

2. L'équilibreur de charge encapsule le paquet de demandes du client (labellisé "CR" dans l'image) dans un paquet IPIP (labellisé "IPIP"). Le paquet de demandes du client conserve l'adresse IP du client comme adresse IP source. Le paquet d'encapsulation IPIP utilise l'adresse IP 10.73.14.25 du noeud worker comme adresse IP source.

3. L'équilibreur de charge achemine le paquet IPIP vers un noeud worker dans lequel réside un pod d'application, 10.73.14.26. Si plusieurs instances d'application sont déployées dans le cluster, l'équilibreur de charge achemine les demandes entre les noeuds worker dans lesquels sont déployés les pods d'application.

4. Le noeud worker 10.73.14.26 décompresse le paquet d'encapsulation IPIP, puis décompresse le paquet de demandes du client. Le paquet de demandes du client est transféré au pod d'application sur ce noeud worker.

5. Le noeud worker 10.73.14.26 utilise ensuite l'adresse IP source du paquet de demandes d'origine, l'adresse IP du client, pour renvoyer le paquet de réponses du pod d'application directement au client.

### Comment une demande parvient-elle à mon application avec un équilibreur de charge 2.0 dans un cluster à zones multiples ?
{: #ipvs_multi}

Le trafic dans un cluster à zones multiples suit le même chemin que le [trafic dans un cluster à zone unique](#ipvs_single). Dans un cluster à zones multiples, l'équilibreur de charge achemine les demandes vers les instances d'application au sein de sa propre zone et vers les instances d'application situées dans d'autres zones. Le diagramme suivant illustre comment les équilibreurs de charge 2.0 de chaque zone dirigent le trafic d'Internet vers une application dans un cluster à zones multiples.

<img src="images/cs_loadbalancer_ipvs_multizone.png" alt="Exposition d'une application dans {{site.data.keyword.containerlong_notm}} à l'aide d'un équilibreur de charge 2.0" style="width:500px; border-style: none"/>

Par défaut, chaque équilibreur de charge 2.0 est configuré dans une seule zone. Vous pouvez obtenir une plus haute disponibilité en déployant un équilibreur de charge 2.0 dans toutes les zones où vous disposez d'instances d'application.

<br />


## Algorithmes de planification d'un équilibreur de charge 2.0
{: #scheduling}

Les algorithmes de planification déterminent comment un équilibreur de charge 2.0 affecte des connexions réseau à vos pods d'application. Lorsque les demandes du client parviennent à votre cluster, l'équilibreur de charge achemine les paquets de demandes aux noeuds worker en fonction de l'algorithme de planification. Pour utiliser un algorithme de planification, indiquez son nom abrégé Keepalived dans l'annotation du planificateur du fichier de configuration de votre service d'équilibreur de charge : `service.kubernetes.io/ibm-load-balancer-cloud-provider-scheduler: "rr"`. Consultez les listes suivantes pour voir les algorithmes de planification pris en charge dans {{site.data.keyword.containerlong_notm}}. Si vous n'indiquez pas d'algorithme de planification, l'algorithme Round Robin (rr) est utilisé par défaut. Pour plus d'informations, voir la [documentation Keepalived ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](http://www.Keepalived.org/doc/scheduling_algorithms.html).

### Algorithmes de planification pris en charge
{: #scheduling_supported}

<dl>
<dt>Round Robin (<code>rr</code>)</dt>
<dd>L'équilibreur de charge parcourt la liste des pods d'application lors de l'acheminement des connexions aux noeuds worker, traitant chaque pod d'application de la même manière. Round Robin (rr) est l'algorithme de planification par défaut des équilibreurs de charge version 2.0.</dd>
<dt>Source Hashing (<code>sh</code>)</dt>
<dd>L'équilibrage de charge génère une clé de hachage en fonction de l'adresse IP source du paquet de demandes du client. L'équilibreur de charge recherche ensuite la clé de hachage dans une table de hachage affectée de manière statique et achemine la demande au pod d'application qui traite les hachages de cette plage. Cet algorithme garantit que les demandes d'un client particulier sont toujours dirigées vers le même pod d'application.</br>**Remarque** : Kubernetes utilise des règles Iptables, ce qui entraîne l'envoi des demandes à un pod aléatoire sur le noeud worker. Pour utiliser cet algorithme de planification, vous devez vous assurer qu'il n'y a qu'un seul pod de votre application déployé par noeud worker. Par exemple, si chaque pod est labellisé <code>run=&lt;app_name&gt;</code>, ajoutez la règle d'anti-affinité suivante dans la section <code>spec</code> du déploiement de votre application :</br>
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
<dd>La destination du paquet, qui correspond à l'adresse IP et au port de l'équilibreur de charge, est utilisée pour déterminer le noeud worker qui traite la demande entrante. Cependant, l'adresse IP et le port des équilibreurs de charge dans {{site.data.keyword.containerlong_notm}} ne bougent pas. L'équilibreur de charge est obligé de conserver la demande dans le même noeud worker où il se trouve, donc seuls les pods d'application sur un noeud worker traitent toutes les demandes entrantes.</dd>
<dt>Algorithmes de comptabilisation dynamique des connexions</dt>
<dd>Les algorithmes suivants dépendent de la comptabilisation dynamique des connexions entre les clients et les équilibreurs de charge. Cependant le mode DSR (Direct Service Return) empêche les pods d'équilibreur de charge 2.0 d'être dans le chemin des paquets renvoyés et les équilibreurs de charge n'assurent pas le suivi des connexions établies.<ul>
<li>Least Connection (<code>lc</code>)</li>
<li>Locality-Based Least Connection (<code>lblc</code>)</li>
<li>Locality-Based Least Connection with Replication (<code>lblcr</code>)</li>
<li>Never Queue (<code>nq</code>)</li>
<li>Shortest Expected Delay (<code>seq</code>)</li></ul></dd>
<dt>Algorithmes de pods pondérés</dt>
<dd>Les algorithmes suivants dépendent des pods d'application pondérés. Cependant, dans {{site.data.keyword.containerlong_notm}}, une pondération égale est affectée à tous les pods d'application pour l'équilibrage de charge.<ul>
<li>Weighted Least Connection (<code>wlc</code>)</li>
<li>Weighted Round Robin (<code>wrr</code>)</li></ul></dd></dl>

<br />


## Prérequis pour les équilibreurs de charge 2.0
{: #ipvs_provision}

Vous ne pouvez pas mettre à jour un équilibreur de charge 1.0 à la version 2.0. Vous devez créer un nouvel équilibreur de charge version 2.0. Notez que vous pouvez exécuter des équilibreurs de charge de version 1.0 et 2.0 simultanément dans un cluster.

Avant de créer un équilibreur de charge version 2.0, vous devez respecter la procédure prérequise suivante.

1. [Mettez à jour le maître et les noeuds worker de votre cluster](cs_cluster_update.html) vers Kubernetes version 1.12 ou ultérieure.

2. Pour permettre à votre équilibreur de charge 2.0 de transférer les demandes aux pods d'application dans plusieurs zones, ouvrez un cas de support pour demander la configuration pour vos réseaux locaux virtuels (VLAN). **Important** : vous devez demander cette configuration pour tous les VLAN publics. Si vous demandez un nouveau VLAN associé, vous devez ouvrir un autre ticket pour ce VLAN.
    1. Connectez-vous à la [console {{site.data.keyword.Bluemix_notm}}](https://console.bluemix.net/).
    2. Dans le menu, accédez à **Infrastructure**, puis à **Support > Ajouter un ticket**.
    3. Dans les zones de cas, sélectionnez **Service technique**, **Infrastructure** et **Question de réseau public**.
    4. Ajoutez les informations suivantes à la description : "Please set up the network to allow capacity aggregation on the public VLANs associated with my account. The reference ticket for this request is: https://control.softlayer.com/support/tickets/63859145".
    5. Cliquez sur le bouton de **soumission du ticket**.

3. Une fois vos VLAN configurés avec l'agrégation de capacité, activez la fonction [Spanning VLAN](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) pour votre compte d'infrastructure IBM Cloud (SoftLayer). Lorsque la fonction Spanning VLAN est activée, l'équilibreur de charge 2.0 peut router des paquets vers différents sous-réseaux dans le compte.

4. Si vous utilisez des [règles réseau pre-DNAT de Calico](cs_network_policy.html#block_ingress) pour gérer le trafic vers l'adresse IP d'un équilibreur de charge version 2.0, vous devez ajouter les zones `applyOnForward: true` et `doNotTrack: true` à la section `spec` dans ces règles. `applyOnForward: true` garantit l'application de la règle Calico au trafic à mesure qu'il est encapsulé et transféré. `doNotTrack: true` garantit que les noeuds worker peuvent utiliser le mode DSR pour renvoyer un paquet de réponses directement au client sans avoir besoin d'assurer le suivi de la connexion. Par exemple, si vous utilisez une règle Calico pour placer en liste blanche le trafic provenant uniquement d'adresses IP spécifiques vers l'adresse IP de votre équilibreur de charge, la règle ressemble à ceci :
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
      preDNAT: true
      selector: ibm.role=='worker_public'
      order: 500
      types:
      - Ingress
    ```
    {: screen}

Vous pouvez ensuite suivre la procédure indiquée dans [Configuration d'un équilibreur de charge 2.0 dans un cluster à zones multiples](#ipvs_multi_zone_config) ou [dans un cluster à zone unique](#ipvs_single_zone_config).

<br />


## Configuration d'un équilibreur de charge 2.0 dans un cluster à zones multiples
{: #ipvs_multi_zone_config}

Les services d'équilibreur de charge sont disponibles uniquement pour des clusters standard et ne prennent pas en charge la terminaison TLS. Si votre application nécessite une terminaison TLS, vous pouvez exposer l'application en utilisant [Ingress](cs_ingress.html) ou configurer votre application pour gérer la terminaison TLS.
{: note}

**Avant de commencer** :

  * **Important** : remplissez les [conditions prérequises pour l'équilibreur de charge 2.0](#ipvs_provision).
  * Pour créer des équilibreurs de charge publics dans plusieurs zones, au moins un VLAN public doit comporter des sous-réseaux portables disponibles dans chaque zone. Pour créer des équilibreurs de charge privés dans plusieurs zones, au moins un VLAN privé doit comporter des sous-réseaux portables disponibles dans chaque zone. Pour ajouter des sous-réseaux, voir [Configuration de sous-réseaux pour les clusters](cs_subnets.html).
  * Si vous limitez le trafic réseau aux noeuds worker de périphérie, vérifiez qu'au moins 2 [noeuds worker de périphérie](cs_edge.html#edge) sont activés dans chaque zone. S'ils ne sont activés que dans certaines zones et pas d'autres, les équilibreurs de charge ne pourront pas se déployer uniformément. Les équilibreurs de charge seront déployés sur des noeuds de périphérie dans certaines zones mais sur des noeuds worker normaux dans d'autres zones.


Pour configurer un équilibreur de charge 2.0 dans un cluster à zones multiples :
1.  [Déployez votre application sur le cluster](cs_app.html#app_cli). Lorsque vous déployez l'application sur le cluster, un ou plusieurs pods sont créés pour vous et exécutent votre application dans un conteneur. Prenez soin d'ajouter un libellé à votre déploiement dans la section "metadata" de votre fichier de configuration. Ce libellé est nécessaire pour identifier tous les pods dans lesquels s'exécute votre application afin de pouvoir les inclure dans l'équilibrage de charge.

2.  Créez un service d'équilibreur de charge pour l'application que vous désirez exposer. Pour rendre votre application accessible sur l'Internet public ou sur un réseau privé, créez un service Kubernetes pour votre application. Configurez ce service pour inclure tous les pods composant votre application dans l'équilibrage de charge.
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
        <td>Annotation utilisée pour indiquer le type d'équilibreur de charge. Les valeurs admises sont <code>private</code> et <code>public</code>. Si vous créez un équilibreur de charge public dans les clusters sur des VLAN publics, cette annotation n'est pas nécessaire.</td>
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
        <td>Facultatif : annotation utilisée pour spécifier un algorithme de planification. Les valeurs admises sont : <code>"rr"</code> pour Round Robin (valeur par défaut) ou <code>"sh"</code> pour Source Hashing.</td>
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
        <td>Facultatif : pour créer un équilibreur de charge privé ou utiliser une adresse IP portable spécifique pour un équilibreur de charge public, remplacez <em>&lt;IP_address&gt;</em> par l'adresse IP que vous désirez utiliser. Si vous spécifiez un VLAN ou une zone, l'adresse IP doit figurer dans ce VLAN ou dans cette zone. Si vous n'indiquez pas d'adresse IP :<ul><li>Si votre cluster se trouve sur un VLAN public, une adresse IP publique portable est utilisée. La plupart des clusters se trouvent dans un VLAN public.</li><li>Si votre cluster est disponible uniquement sur un VLAN privé, une adresse IP privée portable est utilisée.</li></ul></td>
      </tr>
      <tr>
        <td><code>externalTrafficPolicy: Local</code></td>
        <td>Défini avec <code>Local</code>.</td>
      </tr>
      </tbody></table>

      Exemple de fichier de configuration utilisé pour créer un service d'équilibreur de charge 2.0 dans la zone `dal12` utilisant l'algorithme de planification Round Robin :

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

  3. Facultatif : configurez un pare-feu en indiquant `loadBalancerSourceRanges` dans la section **spec**. Pour plus d'informations, voir la [documentation Kubernetes ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/).

  4. Créez le service dans votre cluster.

      ```
      kubectl apply -f myloadbalancer.yaml
      ```
      {: pre}

3. Vérifiez que la création du service d'équilibreur de charge a abouti. Remplacez _&lt;myservice&gt;_ par le nom du service d'équilibreur de charge que vous avez créé à l'étape précédente. La création du service d'équilibreur de charge et la mise à disposition de l'application peuvent prendre quelques minutes.

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

    L'adresse IP **LoadBalancer Ingress** est l'adresse IP portable affectée à votre service d'équilibreur de charge.

4.  Si vous avez créé un équilibreur de charge public, accédez à votre application via Internet.
    1.  Ouvrez le navigateur Web de votre choix.
    2.  Entrez l'adresse IP publique portable et le port de l'équilibreur de charge.

        ```
        http://169.xx.xxx.xxx:8080
        ```
        {: codeblock}

5. Pour assurer la haute disponibilité, répétez les étapes ci-dessus pour ajouter un équilibreur de charge 2.0 dans chaque zone où vous disposez d'instances d'application.

6. Facultatif : un service d'équilibreur de charge rend votre application accessible via les ports de noeud du service. Les [ports de noeud (NodePort)](cs_nodeport.html) sont accessibles sur toutes les adresses IP publiques et privées pour tous les noeuds figurant dans le cluster. Pour bloquer le trafic vers les ports de noeud lorsque vous utilisez un service d'équilibreur de charge, voir [Contrôle du trafic entrant vers les services d'équilibreur de charge ou NodePort](cs_network_policy.html#block_ingress).

## Configuration d'un équilibreur de charge 2.0 dans un cluster à zone unique
{: #ipvs_single_zone_config}

Avant de commencer :

* Cette fonction n'est disponible que pour les clusters standard.
* Vous devez disposer d'une adresse IP publique ou privée disponible pour l'affecter au service d'équilibreur de charge.
* **Important** : remplissez les [conditions prérequises pour l'équilibreur de charge 2.0](#ipvs_provision).

Pour créer un service d'équilibreur de charge 2.0 dans un cluster à zone unique :

1.  [Déployez votre application sur le cluster](cs_app.html#app_cli). Lorsque vous déployez l'application sur le cluster, un ou plusieurs pods sont créés pour vous et exécutent votre application dans un conteneur. Prenez soin d'ajouter un libellé à votre déploiement dans la section "metadata" de votre fichier de configuration. Ce libellé est nécessaire pour identifier tous les pods dans lesquels s'exécute votre application afin de pouvoir les inclure dans l'équilibrage de charge.
2.  Créez un service d'équilibreur de charge pour l'application que vous désirez exposer. Pour rendre votre application accessible sur l'Internet public ou sur un réseau privé, créez un service Kubernetes pour votre application. Configurez ce service pour inclure tous les pods composant votre application dans l'équilibrage de charge.
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
          <td>Annotation utilisée pour indiquer le type d'équilibreur de charge. Les valeurs admises sont `private` et `public`. Si vous créez un équilibreur de charge public dans les clusters sur des VLAN publics, cette annotation n'est pas nécessaire.</td>
        </tr>
        <tr>
          <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan:`
          <td>Annotation utilisée pour spécifier un VLAN sur lequel est déployé le service d'équilibreur de charge. Pour voir les VLAN, exécutez la commande <code>ibmcloud ks vlans --zone <zone></code>.</td>
        </tr>
        <tr>
          <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-enable-features: "ipvs"</code>
          <td>Annotation utilisée pour spécifier un équilibreur de charge 2.0.</td>
        </tr>
        <tr>
          <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-scheduler:</code>
          <td>Annotation utilisée pour spécifier un algorithme de planification. Les valeurs admises sont : <code>"rr"</code> pour Round Robin (valeur par défaut) ou <code>"sh"</code> pour Source Hashing.</td>
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
          <td>Facultatif : pour créer un équilibreur de charge privé ou utiliser une adresse IP portable spécifique pour un équilibreur de charge public, remplacez <em>&lt;IP_address&gt;</em> par l'adresse IP que vous désirez utiliser. Si vous spécifiez un VLAN, l'adresse IP doit figurer sur ce VLAN. Si vous n'indiquez pas d'adresse IP :<ul><li>Si votre cluster se trouve sur un VLAN public, une adresse IP publique portable est utilisée. La plupart des clusters se trouvent dans un VLAN public.</li><li>Si votre cluster est disponible uniquement sur un VLAN privé, une adresse IP privée portable est utilisée.</li></ul></td>
        </tr>
        <tr>
          <td><code>externalTrafficPolicy: Local</code></td>
          <td>Défini avec <code>Local</code>.</td>
        </tr>
        </tbody></table>

    3.  Facultatif : configurez un pare-feu en indiquant `loadBalancerSourceRanges` dans la section **spec**. Pour plus d'informations, voir la [documentation Kubernetes ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/).

    4.  Créez le service dans votre cluster.

        ```
        kubectl apply -f myloadbalancer.yaml
        ```
        {: pre}

        Lorsque votre service d'équilibreur de charge est créé, une adresse IP portable lui est automatiquement affectée. Si aucune adresse IP portable n'est disponible, le service d'équilibreur de charge ne peut pas être créé.

3.  Vérifiez que la création du service d'équilibreur de charge a abouti. La création du service d'équilibreur de charge et la mise à disposition de l'application peuvent prendre quelques minutes.

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

    L'adresse IP **LoadBalancer Ingress** est l'adresse IP portable affectée à votre service d'équilibreur de charge.

4.  Si vous avez créé un équilibreur de charge public, accédez à votre application via Internet.
    1.  Ouvrez le navigateur Web de votre choix.
    2.  Entrez l'adresse IP publique portable et le port de l'équilibreur de charge.

        ```
        http://169.xx.xxx.xxx:8080
        ```
        {: codeblock}

5. Facultatif : un service d'équilibreur de charge rend votre application accessible via les ports de noeud du service. Les [ports de noeud (NodePort)](cs_nodeport.html) sont accessibles sur toutes les adresses IP publiques et privées pour tous les noeuds figurant dans le cluster. Pour bloquer le trafic vers les ports de noeud lorsque vous utilisez un service d'équilibreur de charge, voir [Contrôle du trafic entrant vers les services d'équilibreur de charge ou NodePort](cs_network_policy.html#block_ingress).

<br />


## Composants et architecture de l'équilibreur de charge 1.0
{: #planning}

L'équilibreur de charge 1.0 TCP/UDP utilise Iptables, une fonction du noyau Linux, pour équilibrer la charge des demandes sur les pods d'une application.

Comment une demande parvient-elle à mon application avec un équilibreur de charge 1.0 dans un cluster à zone unique ?

Le diagramme suivant illustre comment un équilibreur de charge 1.0 dirige la communication d'Internet vers une application.

<img src="images/cs_loadbalancer_planning.png" width="450" alt="Exposition d'une application dans {{site.data.keyword.containerlong_notm}} à l'aide d'un équilibreur de charge 1.0" style="width:450px; border-style: none"/>

1. Une demande adressée à votre application utilise l'adresse IP publique de votre équilibreur de charge et le port affecté sur le noeud worker.

2. La demande est automatiquement transmise à l'adresse IP et au port du cluster interne du service d'équilibreur de charge. L'adresse IP du cluster interne est accessible uniquement à l'intérieur du cluster.

3. `kube-proxy` achemine la demande vers le service d'équilibreur de charge Kubernetes correspondant à l'application.

4. La demande est transférée à l'adresse IP privée du pod d'application. L'adresse IP source du package de demande est remplacée par l'adresse IP publique du noeud worker sur lequel s'exécute le pod d'application. Si plusieurs instances d'application sont déployées dans le cluster, l'équilibreur de charge achemine les demandes entre les pods d'application.

Comment une demande parvient-elle à mon application avec un équilibreur de charge 1.0 dans un cluster à zones multiples ?

Si vous disposez d'un cluster à zones multiples, les instances d'application sont déployées dans des pods sur les noeuds worker répartis dans les différentes zones. Le diagramme suivant illustre comment un équilibreur de charge 1.0 dirige la communication d'Internet vers une application dans un cluster à zones multiples.

<img src="images/cs_loadbalancer_planning_multizone.png" width="475" alt="Utilisation d'un équilibreur de charge 1.0 pour équilibrer la charge des applications dans des clusters à zones multiples" style="width:475px; border-style: none"/>

Par défaut, chaque équilibreur de charge 1.0 est configuré dans une seule zone. Pour assurer la haute disponibilité, vous devez déployer un équilibreur de charge 1.0 dans toutes les zones où se trouvent vos instances d'application. Les demandes sont traitées par les équilibreurs de charge dans les différentes zones à tour de rôle. De plus, l'équilibreur de charge route les demandes vers les instances d'application au sein de sa propre zone et vers les instances d'application situées dans d'autres zones.

<br />


## Configuration d'un équilibreur de charge 1.0 dans un cluster à zones multiples
{: #multi_zone_config}

Les services d'équilibreur de charge sont disponibles uniquement pour des clusters standard et ne prennent pas en charge la terminaison TLS. Si votre application nécessite une terminaison TLS, vous pouvez exposer l'application en utilisant [Ingress](cs_ingress.html) ou configurer votre application pour gérer la terminaison TLS.
{: note}

**Avant de commencer** :
  * Vous devez déployer un équilibreur de charge dans chaque zone et à chaque équilibreur de charge est affectée sa propre adresse IP dans cette zone. Pour créer des équilibreurs de charge publics, au moins un VLAN public doit disposer de sous-réseaux portables disponibles dans chaque zone. Pour ajouter des services d'équilibreur de charge privés, au moins un VLAN privé doit disposer de sous-réseaux portables disponibles dans chaque zone. Pour ajouter des sous-réseaux, voir [Configuration de sous-réseaux pour les clusters](cs_subnets.html).
  * Si vous limitez le trafic réseau aux noeuds worker de périphérie, vérifiez qu'au moins 2 [noeuds worker de périphérie](cs_edge.html#edge) sont activés dans chaque zone. S'ils ne sont activés que dans certaines zones et pas d'autres, les équilibreurs de charge ne pourront pas se déployer uniformément. Les équilibreurs de charge seront déployés sur des noeuds de périphérie dans certaines zones mais sur des noeuds worker normaux dans d'autres zones.
  * Activez la fonction [Spanning VLAN](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) pour votre compte d'infrastructure IBM Cloud (SoftLayer) afin que vos noeuds worker puissent communiquer entre eux sur le réseau privé. Pour effectuer cette action, vous devez disposer des [droits Infrastructure](cs_users.html#infra_access) **Réseau > Gérer spanning VLAN pour réseau** ou vous pouvez demander au propriétaire du compte de l'activer. Pour vérifier si la fonction Spanning VLAN est déjà activée, utilisez la [commande](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`.


Pour configurer un service d'équilibreur de charge 1.0 dans un cluster à zones multiples :
1.  [Déployez votre application sur le cluster](cs_app.html#app_cli). Lorsque vous déployez l'application sur le cluster, un ou plusieurs pods sont créés pour vous et exécutent votre application dans un conteneur. Prenez soin d'ajouter un libellé à votre déploiement dans la section "metadata" de votre fichier de configuration. Ce libellé est nécessaire pour identifier tous les pods dans lesquels s'exécute votre application afin de pouvoir les inclure dans l'équilibrage de charge.

2.  Créez un service d'équilibreur de charge pour l'application que vous désirez exposer. Pour rendre votre application accessible sur l'Internet public ou sur un réseau privé, créez un service Kubernetes pour votre application. Configurez ce service pour inclure tous les pods composant votre application dans l'équilibrage de charge.
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
        <td>Annotation utilisée pour indiquer le type d'équilibreur de charge. Les valeurs admises sont <code>private</code> et <code>public</code>. Si vous créez un équilibreur de charge public dans les clusters sur des VLAN publics, cette annotation n'est pas nécessaire.</td>
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
        <td>Entrez la paire clé de libellé (<em>&lt;selector_key&gt;</em>) et valeur (<em>&lt;selector_value&gt;</em>) à utiliser pour cibler les pods dans lesquels s'exécute votre application. Pour cibler vos pods et les inclure dans l'équilibrage de charge du service, vérifiez les valeurs <em>&lt;selectorkey&gt;</em> et <em>&lt;selectorvalue&gt;</em>. Assurez-vous qu'elles sont identiques à la paire <em>clé/valeur</em> que vous avez utilisée à la section <code>spec.template.metadata.labels</code> de votre fichier YAML de déploiement.</td>
      </tr>
      <tr>
        <td><code>port</code></td>
        <td>Port sur lequel le service est à l'écoute.</td>
      </tr>
      <tr>
        <td><code>loadBalancerIP</code></td>
        <td>Facultatif : pour créer un équilibreur de charge privé ou utiliser une adresse IP portable spécifique pour un équilibreur de charge public, remplacez <em>&lt;IP_address&gt;</em> par l'adresse IP que vous désirez utiliser. Si vous spécifiez un VLAN ou une zone, l'adresse IP doit figurer dans ce VLAN ou dans cette zone. Si vous n'indiquez pas d'adresse IP :<ul><li>Si votre cluster se trouve sur un VLAN public, une adresse IP publique portable est utilisée. La plupart des clusters se trouvent dans un VLAN public.</li><li>Si votre cluster est disponible uniquement sur un VLAN privé, une adresse IP privée portable est utilisée.</li></ul></td>
      </tr>
      </tbody></table>

      Exemple de fichier de configuration utilisé pour créer un service d'équilibreur de charge 1.0 privé qui utilise une adresse IP indiquée sur le VLAN `2234945` dans la zone `dal12`:

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

  3. Facultatif : configurez un pare-feu en indiquant `loadBalancerSourceRanges` dans la section **spec**. Pour plus d'informations, voir la [documentation Kubernetes ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/).

  4. Créez le service dans votre cluster.

      ```
      kubectl apply -f myloadbalancer.yaml
      ```
      {: pre}

3. Vérifiez que la création du service d'équilibreur de charge a abouti. Remplacez _&lt;myservice&gt;_ par le nom du service d'équilibreur de charge que vous avez créé à l'étape précédente. La création du service d'équilibreur de charge et la mise à disposition de l'application peuvent prendre quelques minutes.

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

    L'adresse IP **LoadBalancer Ingress** est l'adresse IP portable affectée à votre service d'équilibreur de charge.

4.  Si vous avez créé un équilibreur de charge public, accédez à votre application via Internet.
    1.  Ouvrez le navigateur Web de votre choix.
    2.  Entrez l'adresse IP publique portable et le port de l'équilibreur de charge.

        ```
        http://169.xx.xxx.xxx:8080
        ```
        {: codeblock}        

5. Si vous choisissez d'[activer la conservation de l'adresse IP source pour un service d'équilibreur de charge 1.0  ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/tutorials/services/source-ip/#source-ip-for-services-with-typeloadbalancer), assurez-vous que tous les pods d'application sont planifiés sur les noeuds worker de périphérie en [ajoutant l'affinité de noeud de périphérie aux pods d'application](cs_loadbalancer.html#edge_nodes). Les pods d'application doivent être planifiés sur des noeuds de périphérie pour recevoir des demandes entrantes.

6. Répétez la procédure ci-dessus pour ajouter un équilibreur de charge version 1.0 dans chaque zone.

7. Facultatif : un service d'équilibreur de charge rend votre application accessible via les ports de noeud du service. Les [ports de noeud (NodePort)](cs_nodeport.html) sont accessibles sur toutes les adresses IP publiques et privées pour tous les noeuds figurant dans le cluster. Pour bloquer le trafic vers les ports de noeud lorsque vous utilisez un service d'équilibreur de charge, voir [Contrôle du trafic entrant vers les services d'équilibreur de charge ou NodePort](cs_network_policy.html#block_ingress).

## Configuration d'un équilibreur de charge 1.0 dans un cluster à zone unique
{: #config}

Avant de commencer :

* Cette fonction n'est disponible que pour les clusters standard.
* Vous devez disposer d'une adresse IP publique ou privée disponible pour l'affecter au service d'équilibreur de charge.

Pour créer un service d'équilibreur de charge 1.0 dans un cluster à zone unique :

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
          <td>Annotation utilisée pour indiquer le type d'équilibreur de charge. Les valeurs admises sont `private` et `public`. Si vous créez un équilibreur de charge public dans les clusters sur des VLAN publics, cette annotation n'est pas nécessaire.</td>
        </tr>
        <tr>
          <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan:`
          <td>Annotation utilisée pour spécifier un VLAN sur lequel est déployé le service d'équilibreur de charge. Pour voir les VLAN, exécutez la commande <code>ibmcloud ks vlans --zone <zone></code>.</td>
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
          <td>Facultatif : pour créer un équilibreur de charge privé ou utiliser une adresse IP portable spécifique pour un équilibreur de charge public, remplacez <em>&lt;IP_address&gt;</em> par l'adresse IP que vous désirez utiliser. Si vous spécifiez un VLAN, l'adresse IP doit figurer sur ce VLAN. Si vous n'indiquez pas d'adresse IP :<ul><li>Si votre cluster se trouve sur un VLAN public, une adresse IP publique portable est utilisée. La plupart des clusters se trouvent dans un VLAN public.</li><li>Si votre cluster est disponible uniquement sur un VLAN privé, une adresse IP privée portable est utilisée.</li></ul></td>
        </tr>
        </tbody></table>

        Exemple de fichier de configuration utilisé pour créer un service d'équilibreur de charge 1.0 privé qui utilise une adresse IP indiquée sur le VLAN privé `2234945` :

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

    3.  Facultatif : configurez un pare-feu en indiquant `loadBalancerSourceRanges` dans la section **spec**. Pour plus d'informations, voir la [documentation Kubernetes ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/).

    4.  Créez le service dans votre cluster.

        ```
        kubectl apply -f myloadbalancer.yaml
        ```
        {: pre}

        Lorsque votre service d'équilibreur de charge est créé, une adresse IP portable lui est automatiquement affectée. Si aucune adresse IP portable n'est disponible, le service d'équilibreur de charge ne peut pas être créé.

3.  Vérifiez que la création du service d'équilibreur de charge a abouti. La création du service d'équilibreur de charge et la mise à disposition de l'application peuvent prendre quelques minutes.

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

    L'adresse IP **LoadBalancer Ingress** est l'adresse IP portable affectée à votre service d'équilibreur de charge.

4.  Si vous avez créé un équilibreur de charge public, accédez à votre application via Internet.
    1.  Ouvrez le navigateur Web de votre choix.
    2.  Entrez l'adresse IP publique portable et le port de l'équilibreur de charge.

        ```
        http://169.xx.xxx.xxx:8080
        ```
        {: codeblock}

5. Si vous choisissez d'[activer la conservation de l'adresse IP source pour un service d'équilibreur de charge 1.0 ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/tutorials/services/source-ip/#source-ip-for-services-with-typeloadbalancer), assurez-vous que tous les pods d'application sont planifiés sur les noeuds worker de périphérie en [ajoutant l'affinité de noeud de périphérie aux pods d'application](cs_loadbalancer.html#edge_nodes). Les pods d'application doivent être planifiés sur des noeuds de périphérie pour recevoir des demandes entrantes.

6. Facultatif : un service d'équilibreur de charge rend votre application accessible via les ports de noeud du service. Les [ports de noeud (NodePort)](cs_nodeport.html) sont accessibles sur toutes les adresses IP publiques et privées pour tous les noeuds figurant dans le cluster. Pour bloquer le trafic vers les ports de noeud lorsque vous utilisez un service d'équilibreur de charge, voir [Contrôle du trafic entrant vers les services d'équilibreur de charge ou NodePort](cs_network_policy.html#block_ingress).

<br />


## Activation de la conservation de l'adresse IP source pour les équilibreurs de charge version 1.0
{: #node_affinity_tolerations}

Cette fonction est applicable uniquement aux équilibreurs de charge version 1.0. Par défaut, l'adresse IP source des demandes du client est conservée dans les équilibreurs de charge version 2.0.
{: note}

Lorsqu'une demande du client destinée à votre application est envoyée à votre cluster, un pod de service d'équilibreur de charge reçoit la demande. S'il n'existe aucun pod d'application sur le même noeud worker que le pod de service d'équilibreur de charge, l'équilibreur de charge transmet la demande à un pod d'application sur un autre noeud worker. L'adresse IP source du package est remplacée par l'adresse IP publique du noeud worker sur lequel s'exécute le pod de service d'équilibreur de charge.

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

Exemple de fichier YAML de déploiement avec les règles d'affinité et de tolérance pour les noeuds de périphérie :

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
