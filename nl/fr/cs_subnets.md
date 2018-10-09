---

copyright:
  years: 2014, 2018
lastupdated: "2018-09-10"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Configuration de sous-réseaux pour les clusters
{: #subnets}

Vous pouvez modifier le pool d'adresses IP publiques ou privées portables disponibles pour les services d'équilibreur de charge en ajoutant des sous-réseaux à votre cluster Kubernetes.
{:shortdesc}

## Réseaux locaux virtuels (VLAN), sous-réseaux et adresses IP par défaut pour les clusters
{: #default_vlans_subnets}

Lors de la création du cluster, les noeuds worker du cluster et les sous-réseaux par défaut sont automatiquement connectés à un réseau local virtuel (VLAN).

### Réseaux locaux virtuels (VLAN)
{: #vlans}

Lorsque vous créez un cluster, les noeuds worker du cluster sont connectés automatiquement à un VLAN. Un VLAN configure un groupe de noeuds worker et de pods comme s'ils étaient reliés physiquement au même câble et fournit un canal pour la connectivité entre les noeuds worker et les pods.

<dl>
<dt>VLAN pour clusters gratuits</dt>
<dd>Dans les clusters gratuits, les noeuds worker du cluster sont connectés par défaut à un réseau virtuel public et à un réseau privé virtuel dont IBM est le propriétaire. IBM contrôlant les VLAN, les sous-réseaux et les adresses IP, vous ne pouvez pas créer des cluster à zones multiples ni ajouter des sous-réseaux à votre cluster, et vous ne pouvez utiliser que des services NodePort pour exposer votre application.</dd>
<dt>VLAN pour clusters standard</dt>
<dd>Dans les clusters standard, la première fois que vous créez un cluster dans une zone, un VLAN public et un VLAN privé sont automatiquement mis à votre disposition dans cette zone dans votre compte d'infrastructure IBM Cloud (SoftLayer). Pour tous les autres clusters que vous créez dans cette zone, vous pouvez réutiliser ces VLAN public et privé car les clusters à zones multiples peuvent partager des réseaux locaux virtuels.</br></br>Vous pouvez connecter vos noeuds worker à la fois à un VLAN public et au VLAN privé, ou seulement au VLAN privé. Si vous désirez connecter vos noeuds worker uniquement à un VLAN privé, vous pouvez utiliser l'ID d'un VLAN existant ou [créer un VLAN privé](/docs/cli/reference/ibmcloud/cli_vlan.html#ibmcloud-sl-vlan-create) et utiliser l'ID lors de la création du cluster.</dd></dl>

Pour voir les VLAN mis à disposition dans chaque zone pour votre compte, exécutez la commande `ibmcloud ks vlans <zone>.` Pour voir les VLAN sur lesquels un cluster est mis à disposition, exécutez la commande `ibmcloud ks cluster-get <cluster_name_or_ID> --showResources` et recherchez la section **Subnet VLANs**.

**Remarque **:
* Si vous disposez de plusieurs VLAN pour un cluster, de plusieurs sous-réseaux sur le même VLAN ou d'un cluster à zones multiples, vous devez activer la fonction [Spanning VLAN](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) pour votre compte d'infrastructure IBM Cloud (SoftLayer) afin que vos noeuds worker puissent communiquer entre eux sur le réseau privé. Pour effectuer cette action, vous devez disposer des [droits Infrastructure](cs_users.html#infra_access) **Réseau > Gérer spanning VLAN pour réseau** ou vous pouvez demander au propriétaire du compte de l'activer. Pour vérifier si la fonction Spanning VLAN est déjà activée, utilisez la [commande](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`. Avec {{site.data.keyword.BluDirectLink}}, vous devez utiliser à la place une [fonction VRF (Virtual Router Function)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf). Pour activer la fonction VRF, contactez le représentant de votre compte d'infrastructure IBM Cloud (SoftLayer).
* L'infrastructure IBM Cloud (SoftLayer) gère les VLAN qui sont mis à disposition automatiquement lorsque vous créez votre premier cluster dans une zone. Si vous laissez un VLAN inactif, par exemple en supprimant tous les noeuds worker qui s'y trouvent, l'infrastructure IBM Cloud (SoftLayer) récupère ce VLAN. Par la suite, si vous avez besoin d'un nouveau VLAN, [contactez le support d'{{site.data.keyword.Bluemix_notm}}](/docs/infrastructure/vlans/order-vlan.html#order-vlans).

### Sous-réseaux et adresses IP
{: #subnets_ips}

En plus des noeuds worker et des pods, des sous-réseaux sont également automatiquement mis à disposition sur les VLAN. Les sous-réseaux fournissent la connectivité réseau aux composants de votre cluster en leur affectant des adresses IP.

Les sous-réseaux suivants sont automatiquement mis à disposition sur les VLAN public et privé :

**Sous-réseaux de VLAN public**
* Le sous-réseau public principal détermine les adresses IP publiques qui sont affectées aux noeuds worker lors de la création du cluster. Plusieurs clusters figurant dans le même VLAN peuvent partager un sous-réseau public principal.
* Le sous-réseau public portable est lié à un seul cluster et fournit 8 adresses IP publiques au cluster. 3 adresses IP sont réservées aux fonctions de Softlayer. 1 adresse IP est utilisée par l'équilibreur de charge d'application (ALB) Ingress public par défaut et 4 adresses peuvent être utilisées pour créer des services réseau d'équilibreur de charge public. Les adresses IP publiques portables sont permanentes, ces adresses IP fixes peuvent être utilisées pour accéder aux service d'équilibreur de charge via Internet. Si vous avez besoin de plus de 4 adresses IP pour les équilibreurs de charge public, voir [Ajout d'adresses IP portables](#adding_ips).

**Sous-réseaux de VLAN privé**
* Le sous-réseau privé principal détermine les adresses IP privées qui sont affectées aux noeuds worker lors de la création du cluster. Plusieurs clusters figurant dans le même VLAN peuvent partager un sous-réseau privé principal.
* Le sous-réseau privé portable est lié à un seul cluster et fournit 8 adresses IP privées au cluster. 3 adresses IP sont réservées aux fonctions de SoftLayer. 1 adresse IP est utilisée par l'équilibreur de charge d'application (ALB) Ingress privé par défaut et 4 adresses peuvent être utilisées pour créer des services réseau d'équilibreur de charge privé. Les adresses IP privées portables sont permanentes, ces adresses IP fixes peuvent être utilisées pour accéder aux service d'équilibreur de charge via Internet. Si vous avez besoin de plus de 4 adresses IP pour les équilibreurs de charge privés, voir [Ajout d'adresses IP portables](#adding_ips).

Pour voir tous les sous-réseaux mis à disposition dans votre compte, exécutez la commande `ibmcloud ks subnets`. Pour voir les sous-réseaux portables publics et privés liés à un cluster, vous pouvez exécuter la commande `ibmcloud ks cluster-get <cluster_name_or_ID> --showResources` et recherchez la section **Subnet VLANs**.

**Remarque** : dans {{site.data.keyword.containerlong_notm}}, les VLAN sont limités à 40 sous-réseaux. Si vous atteignez cette limite, vérifiez d'abord si vous pouvez [réutiliser des sous-réseaux du VLAN pour créer d'autres clusters](#custom). Si vous avez besoin d'un nouveau VLAN, commandez-en un en [contactant le support {{site.data.keyword.Bluemix_notm}}](/docs/infrastructure/vlans/order-vlan.html#order-vlans). Ensuite, [créez un cluster](cs_cli_reference.html#cs_cluster_create) qui utilise ce nouveau VLAN.

<br />


## Utilisation de sous-réseaux personnalisés ou existants pour créer un cluster
{: #custom}

Lorsque vous créez un cluster standard, des sous-réseaux sont automatiquement créés pour vous. Néanmoins, au lieu d'utiliser ces sous-réseaux, vous pouvez utiliser des sous-réseaux portables existants dans votre compte d'infrastructure IBM Cloud (SoftLayer) ou réutiliser les sous-réseaux d'un cluster supprimé.
{:shortdesc}

Utilisez cette option pour conserver des adresses IP statiques stables lors de création ou de suppression de clusters ou pour commander des blocs d'adresses IP plus importants.

**Remarque :** les adresses IP publiques portables sont facturées au mois. Si vous retirez des adresses IP publiques portables après la mise en place de votre cluster, vous devez quand même payer les frais mensuels, même si vous ne les avez utilisées que brièvement.

Avant de commencer
- [Ciblez votre interface de ligne de commande](cs_cli_install.html#cs_cli_configure) sur votre cluster.
- Pour réutiliser des sous-réseaux d'un cluster que vous n'utilisez plus, supprimez le cluster inutile. Créez le nouveau cluster immédiatement car les sous-réseaux sont supprimés au bout de 24 heures si vous ne les réutilisez pas.

   ```
   ibmcloud ks cluster-rm <cluster_name_or_ID>
   ```
   {: pre}

Pour utiliser un sous-réseau existant dans votre portefeuille d'infrastructure IBM Cloud (SoftLayer) avec des règles de pare-feu personnalisées ou des adresses IP disponibles :

1. Obtenez l'ID du sous-réseau que vous souhaitez utiliser et l'ID du VLAN sur lequel figure ce sous-réseau.

    ```
    ibmcloud ks subnets
    ```
    {: pre}

    Dans cet exemple de sortie, l'ID du sous-réseau est `1602829` et l'ID du VLAN est `2234945` :
    ```
    Getting subnet list...
    OK
    ID        Network             Gateway          VLAN ID   Type      Bound Cluster
    1550165   10.xxx.xx.xxx/26    10.xxx.xx.xxx    2234947   private
    1602829   169.xx.xxx.xxx/28   169.xx.xxx.xxx   2234945   public
    ```
    {: screen}

2. [Créez un cluster](cs_clusters.html#clusters_cli) en utilisant l'ID du VLAN que vous avez identifié. Ajoutez l'indicateur `--no-subnet` pour empêcher la création automatique d'un nouveau sous-réseau d'adresses IP publiques portable et d'un nouveau sous-réseau d'adresses IP privées.

    ```
    ibmcloud ks cluster-create --zone dal10 --machine-type b2c.4x16 --no-subnet --public-vlan 2234945 --private-vlan 2234947 --workers 3 --name my_cluster
    ```
    {: pre}
    Si vous avez oublié dans quelle zone se trouve le VLAN pour l'indicateur `--zone`, vous pouvez vérifier s'il figure dans une zone particulière en exécutant la commande `ibmcloud ks vlans <zone>`.
    {: tip}

3.  Vérifiez que le cluster a été créé. **Remarque :** la commande des machines de noeud worker et la configuration et la mise à disposition du cluster dans votre compte peuvent prendre jusqu'à 15 minutes.

    ```
    ibmcloud ks clusters
    ```
    {: pre}

    Lorsque la mise à disposition de votre cluster est terminée, la valeur de **State** passe à `deployed`.

    ```
    Name         ID                                   State      Created          Workers   Zone   Version
    mycluster    aaf97a8843a29941b49a598f516da72101   deployed   20170201162433   3         dal10      1.10.7
    ```
    {: screen}

4.  Vérifiez le statut des noeuds worker.

    ```
    ibmcloud ks workers <cluster_name_or_ID>
    ```
    {: pre}

    Avant de passer à l'étape suivante, les noeuds worker doivent être prêts. La valeur de **State** passe à `normal` et la zone **Status** affiche `Ready`.

    ```
    ID                                                  Public IP        Private IP     Machine Type   State      Status   Zone   Version
    prod-dal10-pa8dfcc5223804439c87489886dbbc9c07-w1    169.xx.xxx.xxx   10.xxx.xx.xxx  free           normal     Ready    dal10      1.10.7
    ```
    {: screen}

5.  Ajoutez le sous-réseau à votre cluster en spécifiant l'ID du sous-réseau. Lorsque vous rendez disponible un sous-réseau pour un cluster, un fichier configmap Kubernetes est créé pour vous et inclut toutes les adresses IP publiques portables disponibles que vous pouvez utiliser. S'il n'existe aucun équilibreur de charge d'application (ALB) Ingress dans la zone où se trouve le VLAN du sous-réseau, une adresse IP publique portable et une adresse IP privée portable sont automatiquement utilisées pour créer les ALB public et privé pour cette zone. Vous pouvez utiliser toutes les autres adresses publiques et privées portables de ce sous-réseau pour créer de services d'équilibreur de charge pour vos applications.

    ```
    ibmcloud ks cluster-subnet-add mycluster 807861
    ```
    {: pre}

6. **Important** : pour activer la communication entre des noeuds worker qui se trouvent dans différents sous-réseaux d'un même VLAN, vous devez [activer le routage entre les sous-réseaux sur le même VLAN](#subnet-routing).

<br />


## Gestion des adresses IP portables existantes
{: #managing_ips}

Par défaut, 4 adresses IP publiques portables et 4 adresses IP privées portables peuvent être utilisées pour exposer des applications individuelles sur le réseau public ou privé en [créant un service d'équilibreur de charge](cs_loadbalancer.html). Pour créer un service d'équilibreur de charge, vous devez avoir au moins une adresse IP portable du type approprié disponible. Vous pouvez afficher les adresses IP portables disponibles ou libérer une adresse IP portable utilisée.

### Affichage des adresses IP publiques portables disponibles
{: #review_ip}

Pour afficher la liste de toutes les adresses IP portables de votre cluster, à la fois utilisées et disponibles, vous pouvez exécuter la commande suivante :

```
kubectl get cm ibm-cloud-provider-vlan-ip-config -n kube-system -o yaml
```
{: pre}

Pour afficher uniquement les adresses IP publiques portables disponibles pour créer des équilibreurs de charge, vous pouvez utiliser la procédure suivante.

Avant de commencer, [définissez le contexte du cluster que vous désirez utiliser.](cs_cli_install.html#cs_cli_configure)

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

    **Remarque :** la création de ce service échoue car le maître Kubernetes ne parvient pas à localiser l'adresse IP de l'équilibreur de charge spécifié dans le fichier configmap Kubernetes. Lorsque vous exécutez cette commande, le message d'erreur s'affiche, ainsi que la liste des adresses IP publiques disponibles pour le cluster.

    ```
    Erreur sur l'équilibreur de charge cloud a8bfa26552e8511e7bee4324285f6a4a pour le service default/myservice portant l'UID 8bfa2655-2e85-11e7-bee4-324285f6a4af: L'adresse IP 1.1.1.1 du fournisseur cloud demandée n'est pas disponible. Les adresses IP suivantes de fournisseur cloud sont disponibles : <list_of_IP_addresses>
    ```
    {: screen}

<br />


### Libération des adresses IP utilisées
{: #free}

Vous pouvez libérer une adresse IP portable utilisée en supprimant le service d'équilibreur de charge qui l'utilise.
{:shortdesc}

Avant de commencer, [définissez le contexte du cluster que vous désirez utiliser.](cs_cli_install.html#cs_cli_configure)

1.  Répertoriez les services disponibles dans votre cluster.

    ```
    kubectl get services
    ```
    {: pre}

2.  Supprimez le service d'équilibreur de charge qui utilise une adresse IP publique ou privée.

    ```
    kubectl delete service <service_name>
    ```
    {: pre}

<br />


## Ajout d'adresses IP portables
{: #adding_ips}

Par défaut, 4 adresses IP publiques portables et 4 adresses IP privées portables peuvent être utilisées pour exposer des applications individuelles sur le réseau public ou privé en [créant un service d'équilibreur de charge](cs_loadbalancer.html). Pour créer plus de 4 équilibreurs de charge publics ou 4 équilibreurs de charge privés, vous pouvez obtenir des adresses IP supplémentaires en ajoutant des sous-réseaux au cluster.

**Remarque :**
* Lorsque vous rendez un sous-réseau accessible à un cluster, les adresses IP de ce sous-réseau sont utilisées pour la mise en réseau du cluster. Pour éviter des conflits d'adresse IP, prenez soin d'utiliser un sous-réseau avec un seul cluster. N'utilisez pas en même temps un sous-réseau pour plusieurs clusters ou à d'autres fins hors d'{{site.data.keyword.containerlong_notm}}.
* Les adresses IP publiques portables sont facturées au mois. Si vous retirez des adresses IP publiques portables après la mise à disposition de votre sous-réseau, vous devez quand même payer les frais mensuels, même si vous ne les avez utilisées que brièvement.

### Ajout d'adresses IP portables en commandant d'autres sous-réseaux
{: #request}

Vous pouvez obtenir des adresses IP supplémentaires pour les services d'équilibreur de charge en créant un nouveau sous-réseau dans un compte d'infrastructure IBM Cloud (SoftLayer) et en le rendant disponible pour le cluster que vous avez spécifié.
{:shortdesc}

Avant de commencer, [ciblez votre interface de ligne de commande](cs_cli_install.html#cs_cli_configure) sur votre cluster.

1. Provisionnez un nouveau sous-réseau.

    ```
    ibmcloud ks cluster-subnet-create <cluster_name_or_id> <subnet_size> <VLAN_ID>
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
    <td><code><em>&lt;cluster_name_or_id&gt;</em></code></td>
    <td>Remplacez <code>&lt;cluster_name_or_id&gt;</code> par le nom ou l'ID du cluster.</td>
    </tr>
    <tr>
    <td><code><em>&lt;subnet_size&gt;</em></code></td>
    <td>Remplacez <code>&lt;subnet_size&gt;</code> par le nombre d'adresses IP que vous désirez ajouter depuis votre sous-réseau portable. Valeurs admises : 8, 16, 32 ou 64. <p>**Remarque :** lorsque vous ajoutez des adresses IP portables à votre sous-réseau, trois adresses IP sont utilisées pour les opérations de réseau interne au cluster. Vous ne pouvez pas utiliser ces trois adresses IP pour votre équilibreur de charge d'application ou pour créer un service d'équilibreur de charge. Par exemple, si vous demandez huit adresses IP publiques portables, vous pouvez en utiliser cinq pour exposer vos applications au public.</p> </td>
    </tr>
    <tr>
    <td><code><em>&lt;VLAN_ID&gt;</em></code></td>
    <td>Remplacez <code>&lt;VLAN_ID&gt;</code> par l'ID du réseau local virtuel (VLAN) privé ou public sur lequel vous désirez allouer les adresses IP publiques ou privées portables. Vous devez sélectionner le réseau local virtuel public ou privé auquel un noeud worker existant est connecté. Pour examiner le VLAN privé ou public d'un noeud worker, exécutez la commande <code>ibmcloud ks worker-get &lt;worker_id&gt;</code>. < Le sous-réseau est fourni dans la même zone que le VLAN.</td>
    </tr>
    </tbody></table>

2. Vérifiez que le sous-réseau a bien été créé et ajouté à votre cluster. Le CIDR du sous-réseau est répertorié dans la section **Subnet VLANs**.

    ```
    ibmcloud ks cluster-get --showResources <cluster_name_or_ID>
    ```
    {: pre}

    Dans cet exemple de sortie, un deuxième sous-réseau a été ajouté au VLAN public `2234945` :
    ```
    Subnet VLANs
    VLAN ID   Subnet CIDR          Public   User-managed
    2234947   10.xxx.xx.xxx/29     false    false
    2234945   169.xx.xxx.xxx/29    true     false
    2234945   169.xx.xxx.xxx/29    true     false
    ```
    {: screen}

3. **Important** : pour activer la communication entre des noeuds worker qui se trouvent dans différents sous-réseaux d'un même VLAN, vous devez [activer le routage entre les sous-réseaux sur le même VLAN](#subnet-routing).

<br />


### Ajout d'adresses IP privées portables en utilisant des sous-réseaux gérés par l'utilisateur
{: #user_managed}

Vous pouvez obtenir des adresses IP privées portables supplémentaires pour les services d'équilibreur de charge en rendant un sous-réseau de réseau sur site accessible au cluster que vous avez spécifié.
{:shortdesc}

Conditions requises :
- Les sous-réseaux gérés par l'utilisateur peuvent être ajoutés uniquement à des réseaux locaux virtuels (VLAN) privés.
- La limite de longueur du préfixe de sous-réseau est /24 à /30. Par exemple, `169.xx.xxx.xxx/24` indique 253 adresses IP privées utilisables, alors que `169.xx.xxx.xxx/30` indique 1 adresse IP privée utilisable.
- La première adresse IP dans le sous-réseau doit être utilisée comme passerelle du sous-réseau.

Avant de commencer :
- Configurez le routage du trafic réseau vers et depuis le sous-réseau externe.
- Confirmez que vous disposez bien d'une connectivité VPN entre la passerelle réseau du centre de données sur site et le dispositif de routeur virtuel du réseau privé ou le service VPN strongSwan qui s'exécute dans votre cluster. Pour plus d'informations, voir [Configuration de la connectivité VPN](cs_vpn.html).

Pour ajouter un sous-réseau à partir d'un réseau sur site :

1. Affichez l'ID du VLAN privé de votre cluster. Localisez la section **Subnet VLANs**. Dans la zone **User-managed**, identifiez l'ID VLAN avec la valeur _false_.

    ```
    ibmcloud ks cluster-get --showResources <cluster_name>
    ```
    {: pre}

    ```
    Subnet VLANs
  VLAN ID   Subnet CIDR         Public   User-managed
  2234947   10.xxx.xx.xxx/29    false    false
  2234945   169.xx.xxx.xxx/29  true    false
    ```
    {: screen}

2. Ajoutez le sous-réseau externe à votre VLAN privé. Les adresses IP privées portables sont ajoutées à la mappe de configuration (configmap) du cluster.

    ```
    ibmcloud ks cluster-user-subnet-add <cluster_name> <subnet_CIDR> <VLAN_ID>
    ```
    {: pre}

    Exemple :

    ```
    ibmcloud ks cluster-user-subnet-add mycluster 10.xxx.xx.xxx/24 2234947
    ```
    {: pre}

3. Vérifiez que le sous-réseau fourni par l'utilisateur a été ajouté. La zone **User-managed** a la valeur _true_.

    ```
    ibmcloud ks cluster-get --showResources <cluster_name>
    ```
    {: pre}

    Dans cet exemple de sortie, un deuxième sous-réseau a été ajouté au VLAN privé `2234947` :
    ```
    Subnet VLANs
    VLAN ID   Subnet CIDR       Public   User-managed
    2234947   10.xxx.xx.xxx/29  false    false
    2234945   169.xx.xxx.xxx/29 true     false
    2234947   10.xxx.xx.xxx/24  false    true
    ```
    {: screen}

4. [Activez le routage entre les sous-réseaux sur le même VLAN](#subnet-routing).

5. Ajoutez un [service d'équilibreur de charge privé](cs_loadbalancer.html) ou activez un [ALB Ingress privé](cs_ingress.html#private_ingress) pour accéder à votre application via le réseau privé. Pour utiliser une adresse IP privée du sous-réseau que vous avez ajouté, vous devez indiquer une adresse IP figurant dans le CIDR du sous-réseau. Autrement, une adresse IP est sélectionnée de manière aléatoire dans les sous-réseaux d'infrastructure IBM Cloud (SoftLayer) ou dans les sous-réseaux fournis par l'utilisateur sur le VLAN privé.

<br />


## Gestion du routage de sous-réseaux
{: #subnet-routing}

Si vous disposez de plusieurs VLAN pour un cluster, de plusieurs sous-réseaux sur le même VLAN ou d'un cluster à zones multiples, vous devez activer la fonction [Spanning VLAN](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) pour votre compte d'infrastructure IBM Cloud (SoftLayer) afin que vos noeuds worker puissent communiquer entre eux sur le réseau privé. Pour effectuer cette action, vous devez disposer des [droits Infrastructure](cs_users.html#infra_access) **Réseau > Gérer spanning VLAN pour réseau** ou vous pouvez demander au propriétaire du compte de l'activer. Pour vérifier si la fonction Spanning VLAN est déjà activée, utilisez la [commande](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`. Avec {{site.data.keyword.BluDirectLink}}, vous devez utiliser à la place une [fonction VRF (Virtual Router Function)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf). Pour activer la fonction VRF, contactez le représentant de votre compte d'infrastructure IBM Cloud (SoftLayer).

Passez en revue les scénarios suivants nécessitant également la fonction Spanning VLAN.

### Activation du routage entre les sous-réseaux principaux sur le même VLAN
{: #vlan-spanning}

Lorsque vous créez un cluster, un sous-réseau se terminant par `/26` est mis à disposition sur le VLAN principal privé par défaut. Un sous-réseau principal privé peut fournir des adresses IP pour un maximum de 62 noeuds worker.
{:shortdesc}

Cette limite de 62 noeuds worker peut être dépassée par un cluster volumineux ou par plusieurs clusters plus petits dans une seule région situés dans le même VLAN. Lorsque la limite de 62 noeuds worker est atteinte, un autre sous-réseau principal privé dans le même VLAN est commandé.

Pour garantir que les noeuds worker de ces sous-réseaux principaux situés sur le même VLAN peuvent communiquer, vous devez activer la fonction Spanning VLAN. Pour obtenir les instructions correspondantes, voir [Activer ou désactiver le spanning VLAN](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning).

Pour vérifier si la fonction Spanning VLAN est déjà activée, utilisez la [commande](cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`.
{: tip}

### Gestion du routage de sous-réseaux pour les dispositifs de passerelle
{: #vra-routing}

Lorsque vous créez un cluster, un sous-réseau portable public et un sous-réseau portable privé sont commandés sur les VLAN auxquels est connecté le cluster. Ces sous-réseaux fournissent les adresses IP des services réseau d'équilibreur de charge et d'Ingress.

Cependant, si vous disposez déjà d'un dispositif de routage, tel qu'un [dispositif de routeur virtuel (VRA)](/docs/infrastructure/virtual-router-appliance/about.html#about), les sous-réseaux portables récemment ajoutés des VLAN auxquels est connecté le cluster, ne sont pas configurés sur le routeur. Pour utiliser des services réseau d'équilibreur de charge ou d'Ingress, vous devez vous assurer que les dispositifs réseau peuvent effectuer le routage entre les sous-réseaux sur le même VLAN en [activant la fonction Spanning VLAN](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning).

Pour vérifier si la fonction Spanning VLAN est déjà activée, utilisez la [commande](cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`.
{: tip}
