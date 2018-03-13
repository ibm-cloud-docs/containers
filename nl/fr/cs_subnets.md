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


# Configuration de sous-réseaux pour des clusters
{: #subnets}

Vous pouvez modifier le pool d'adresses IP portables publiques ou privées disponibles en ajoutant des sous-réseaux à votre cluster.
{:shortdesc}

Dans {{site.data.keyword.containershort_notm}}, vous pouvez ajouter des adresses IP portables stables pour les services Kubernetes en adjoignant des sous-réseaux au cluster. Dans ce cas, des sous-réseaux ne sont pas utilisés avec le masque réseau pour créer une connectivité à travers un ou plusieurs clusters. A la place, les sous-réseaux sont utilisés pour fournir des adresses IP permanentes fixes pour un service d'un cluster pouvant être utilisées pour accéder à ce service.

Lorsque vous créez un cluster standard, {{site.data.keyword.containershort_notm}} lui alloue automatiquement un sous-réseau public portable avec 5 adresses IP publiques et un sous-réseau privé portable avec 5 adresses IP privées. Les adresses IP publiques et privées portables sont statiques et ne changent pas lorsqu'un noeud worker, ou même le cluster, est retiré. Pour chaque sous-réseau, une adresse IP portable publique et une adresse IP portable privée sont utilisées pour les [équilibreurs de charge d'application](cs_ingress.html) que vous pouvez utiliser pour exposer plusieurs applications dans votre cluster. Les 4 adresses IP publiques portables et les 4 adresses IP privées portables restantes peuvent être utilisées pour exposer au public des applications distinctes en [créant un service d'équilibreur de charge](cs_loadbalancer.html).

**Remarque :** les adresses IP publiques portables sont facturées sur une base mensuelle. Si vous décidez de retirer les adresses IP portables après la mise en place de votre cluster, vous devez quand même payer les frais mensuels, même si vous ne les avez utilisées que brièvement.

## Demande de sous-réseaux supplémentaires pour votre cluster
{: #request}

Vous pouvez ajouter des adresses IP publiques ou privées portables stables au cluster en lui affectant des sous-réseaux.

**Remarque :** lorsque vous rendez un sous-réseau disponible pour un cluster, les adresses IP du sous-réseau sont utilisées pour l'opération réseau du cluster. Pour éviter des conflits d'adresse IP, prenez soin de n'utiliser le sous-réseau qu'avec un seul cluster. N'utilisez pas en même temps un sous-réseau pour plusieurs clusters ou à d'autres fins hors d'{{site.data.keyword.containershort_notm}}.

Avant de commencer, [ciblez avec votre interface de ligne de commande](cs_cli_install.html#cs_cli_configure) votre cluster.

Pour créer un sous-réseau dans un compte d'infrastructure IBM Cloud (SoftLayer) et le rendre disponible pour un cluster spécifié :

1. Provisionnez un nouveau sous-réseau.

    ```
    bx cs cluster-subnet-create <nom_ou_ID_cluster> <taille_sous-réseau> <ID_VLAN>
    ```
    {: pre}

    <table>
    <caption>Description des composantes de cette commande</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composantes de cette commande</th>
    </thead>
    <tbody>
    <tr>
    <td><code>cluster-subnet-create</code></td>
    <td>Commande de création d'un sous-réseau pour votre cluster.</td>
    </tr>
    <tr>
    <td><code><em>&lt;nom_ou_ID_cluster&gt;</em></code></td>
    <td>Remplacez <code>&lt;nom_ou_ID_cluste&gt;</code> par le nom ou l'ID du cluster.</td>
    </tr>
    <tr>
    <td><code><em>&lt;taille_sous-réseau&gt;</em></code></td>
    <td>Remplacez <code>&lt;taille_sous-réseau&gt;</code> par le nombre d'adresses IP que vous désirez ajouter depuis votre sous-réseau portable. Valeurs admises : 8, 16, 32 ou 64. <p>**Remarque :** lorsque vous ajoutez des adresses IP portables pour votre sous-réseau, trois adresses IP sont utilisées pour l'opération réseau interne au cluster, de sorte que vous ne pouvez pas les utiliser pour votre équilibreur de charge d'application ou pour créer un service d'équilibreur de charge. Par exemple, si vous demandez huit adresses IP publiques portables, vous pouvez en utiliser cinq pour exposer vos applications au public.</p> </td>
    </tr>
    <tr>
    <td><code><em>&lt;VLAN_ID&gt;</em></code></td>
    <td>Remplacez <code>&lt;ID_VLAN&gt;</code> par l'ID du VLAN privé ou public sur lequel vous désirez allouer les adresses IP portables publiques ou privées. Vous devez sélectionner le réseau local virtuel public ou privé auquel un noeud worker existant est connecté. Pour examiner le VLAN privé ou public d'un noeud worker, exécutez la commande <code>bx cs worker-get &lt;worker_id&gt;</code>. </td>
    </tr>
    </tbody></table>

2.  Vérifiez que le sous-réseau a bien été créé et ajouté à votre cluster. Le CIDR de sous-réseau est répertorié dans la section **VLAN**.

    ```
    bx cs cluster-get --showResources <cluster name or id>
    ```
    {: pre}

<br />


## Ajout de sous-réseaux personnalisés et existants à des clusters Kubernetes
{: #custom}

Vous pouvez ajouter des sous-réseaux publics ou privés portables existants à votre cluster Kubernetes.

Avant de commencer, [ciblez avec votre interface de ligne de commande](cs_cli_install.html#cs_cli_configure) votre cluster.

Si vous disposez d'un sous-réseau existant dans votre portefeuille d'infrastructure IBM Cloud (SoftLayer) avec des règles de pare-feu personnalisées ou des adresses IP disponibles que vous souhaitez utiliser, créez un cluster sans sous-réseau et rendez votre sous-réseau existant disponible au cluster lors de la mise à disposition du cluster.

1.  Identifiez le sous-réseau à utiliser. Notez l'ID du sous-réseau et l'ID du réseau local virtuel. Dans cet exemple,  l'ID du sous-réseau est 807861 et l'ID du réseau local virtuel est 1901230.

    ```
    bx cs subnets
    ```
    {: pre}

    ```
    Getting subnet list...
    OK
    ID        Network                                      Gateway                                   VLAN ID   Type      Bound Cluster   
    553242    203.0.113.0/24                               10.87.15.00                               1565280   private      
    807861    192.0.2.0/24                                 10.121.167.180                            1901230   public

    ```
    {: screen}

2.  Vérifiez l'emplacement du réseau local virtuel. Dans cet exemple, son emplacement est dal10.

    ```
    bx cs vlans dal10
    ```
    {: pre}

    ```
    Getting VLAN list...
    OK
    ID        Name                  Number   Type      Router   
    1900403   vlan                    1391     private   bcr01a.dal10   
    1901230   vlan                    1180     public   fcr02a.dal10
    ```
    {: screen}

3.  Créez un cluster en utilisant l'emplacement et l'ID du réseau local virtuel que vous avez identifiés. Incluez l'indicateur `--no-subnet` pour empêcher la création automatique d'un nouveau sous-réseau d'adresses IP publiques portables et d'un nouveau sous-réseau d'adresses IP privées portables.

    ```
    bx cs cluster-create --location dal10 --machine-type u2c.2x4 --no-subnet --public-vlan 1901230 --private-vlan 1900403 --workers 3 --name my_cluster
    ```
    {: pre}

4.  Vérifiez que la création du cluster a été demandée.

    ```
    bx cs clusters
    ```
    {: pre}

    **Remarque :** la réservation des postes de noeud worker et la mise en place et la mise à disposition du cluster dans votre compte peuvent prendre jusqu'à 15 minutes.

    Lorsque la mise à disposition de votre cluster est finalisée, le statut du cluster passe à **deployed**.

    ```
    Name         ID                                   State      Created          Workers   
    my_cluster   paf97e8843e29941b49c598f516de72101   deployed   20170201162433   3
    ```
    {: screen}

5.  Vérifiez le statut des noeuds d'agent.

    ```
    bx cs workers <cluster>
    ```
    {: pre}

    Lorsque les noeuds d'agent sont prêts, l'état passe à **normal** et le statut indique **Ready**. Lorsque le statut du noeud indique **Ready**, vous pouvez accéder au cluster.

    ```
    ID                                                  Public IP        Private IP     Machine Type   State      Status
    prod-dal10-pa8dfcc5223804439c87489886dbbc9c07-w1   169.47.223.113   10.171.42.93   free           normal    Ready
    ```
    {: screen}

6.  Ajoutez le sous-réseau à votre cluster en spécifiant l'ID du sous-réseau. Lorsque vous rendez disponible un sous-réseau pour un cluster, une mappe de configuration Kubernetes est créée pour vous et inclut toutes les adresses IP publiques portables disponibles que vous pouvez utiliser. Si aucun équilibreur de charge d'application n'existe encore pour votre cluster, une adresse IP portable publique et une adresse IP portable privée sont automatiquement utilisées pour créer les équilibreurs de charge d'application privés et publics. Toutes les autres adresses peuvent être utilisées pour créer des services d'équilibreur de charge pour vos applications.

    ```
    bx cs cluster-subnet-add mycluster 807861
    ```
    {: pre}

<br />


## Ajout de sous-réseaux et d'adresses IP gérés par l'utilisateur aux clusters Kubernetes
{: #user_managed}

Fournissez votre propre sous-réseau à partir d'un réseau sur site que vous souhaitez accessible à {{site.data.keyword.containershort_notm}}. Vous pouvez ensuite ajouter des adresses IP privées de ce sous-réseau aux services d'équilibreur de charge dans votre cluster Kubernetes.

Conditions requises :
- Les sous-réseaux gérés par l'utilisateur peuvent être ajoutés uniquement à des réseaux locaux virtuels (VLAN) privés.
- La limite de longueur du préfixe de sous-réseau est /24 à /30. Par exemple, `203.0.113.0/24` indique 253 adresses IP privées utilisables, alors que `203.0.113.0/30` indique 1 adresse IP privée utilisable.
- La première adresse IP dans le sous-réseau doit être utilisée comme passerelle du sous-réseau.

Avant de commencer :
- Configurez le routage du trafic réseau vers et depuis le sous-réseau externe.
- Vérifiez la connectivité de réseau privé virtuel entre le périphérique de passerelle du centre de données sur site et le réseau privé Vyatta dans votre portefeuille d'infrastructure IBM Cloud (SoftLayer) ou le service de réseau privé virtuel Strongswan opérant dans votre cluster. Pour utiliser un réseau Vyatta, consultez cet [article de blogue![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://www.ibm.com/blogs/bluemix/2017/07/kubernetes-and-bluemix-container-based-workloads-part4/)]. Pour utiliser Strongswan, voir [Configuration d'une connectivité VPN avec le service de VPN Strongswan IPSec](cs_vpn.html).

1. Affichez l'ID du réseau local virtuel privé de votre cluster. Localisez la section **VLANs**. Dans la zone **User-managed**, identifiez l'ID VLAN avec la valeur _false_.

    ```
    bx cs cluster-get --showResources <cluster_name>
    ```
    {: pre}

    ```
    VLANs
    VLAN ID   Subnet CIDR         Public       User-managed
    1555503   192.0.2.0/24        true         false
    1555505   198.51.100.0/24     false        false
    ```
    {: screen}

2. Ajoutez le sous-réseau externe à votre VLAN privé. Les adresses IP privées portables sont ajoutées à la mappe de configuration du cluster.

    ```
    bx cs cluster-user-subnet-add <cluster_name> <subnet_CIDR> <VLAN_ID>
    ```
    {: pre}

    Exemple :

    ```
    bx cs cluster-user-subnet-add my_cluster 203.0.113.0/24 1555505
    ```
    {: pre}

3. Vérifiez que le sous-réseau fourni par l'utilisateur a été ajouté. La zone **User-managed** a la valeur _true_.

    ```
    bx cs cluster-get --showResources <cluster_name>
    ```
    {: pre}

    ```
    VLANs
    VLAN ID   Subnet CIDR         Public       User-managed
    1555503   192.0.2.0/24        true         false
    1555505   198.51.100.0/24     false        false
    1555505   203.0.113.0/24      false        true
    ```
    {: screen}

4. Ajoutez un service d'équilibrage de charge privé ou un équilibreur de charge d'application Ingress privé pour accéder à votre application à travers le réseau privé. Si vous désirez utiliser une adresse IP privée du sous-réseau que vous avez ajouté lorsque vous avez créé un équilibreur de charge privé ou un équilibreur de charge d'application Ingress privé, vous devez spécifier une adresse IP. Autrement, une adresse IP est sélectionnée de manière aléatoire dans les sous-réseaux d'infrastructure IBM Cloud (SoftLayer) ou dans les sous-réseaux fournis par l'utilisateur sur le VLAN privé. Pour plus d'informations, voir [Configuration de l'accès une application à l'aide du type de service d'équilibreur de charge](cs_loadbalancer.html#config) ou [Activation de l'équilibreur de charge d'application privé](cs_ingress.html#private_ingress).

<br />


## Gestion d'adresses IP et de sous-réseaux
{: #manage}

Vous pouvez utiliser des sous-réseaux et des adresses IP publiques et privés portables pour exposer des applications dans votre cluster et les rendre accessibles via Internet ou sur un réseau privé.
{:shortdesc}

Dans {{site.data.keyword.containershort_notm}}, vous pouvez ajouter des adresses IP portables stables pour les services Kubernetes en adjoignant des sous-réseaux au cluster. Lorsque vous créez un cluster standard, {{site.data.keyword.containershort_notm}} lui alloue automatiquement un sous-réseau public portable avec 5 adresses IP publiques portables et un sous-réseau privé portable avec 5 adresses IP privées portables. Les adresses IP portables sont statiques et ne changent pas lorsqu'un noeud worker, ou même le cluster, est retiré.

Deux des adresses IP portables, l'une publique et l'autre privée, sont utilisées pour les [équilibreurs de charge d'application Ingress](cs_ingress.html) que vous pouvez utiliser pour exposer plusieurs applications dans votre cluster. 4 adresses IP publiques portables et 4 adresses IP privées portables peuvent être utilisées pour exposer des applications en [créant un service d'équilibreur de charge](cs_loadbalancer.html).

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

<br />




## Libération des adresses IP utilisées
{: #free}

Vous pouvez libérer une adresse IP portable utilisée en supprimant le service d'équilibreur de charge qui l'utilise.

Avant de commencer, [définissez le contexte du cluster que vous désirez utiliser.](cs_cli_install.html#cs_cli_configure)

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
