---

copyright:
  years: 2014, 2019
lastupdated: "2019-03-21"

keywords: kubernetes, iks

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



# Configuration de sous-réseaux pour les clusters
{: #subnets}

Vous pouvez modifier le pool d'adresses IP publiques ou privées portables disponibles pour les services d'équilibreur de charge en ajoutant des sous-réseaux à votre cluster Kubernetes.
{:shortdesc}

## Utilisation de sous-réseaux d'infrastructure IBM Cloud (SoftLayer) personnalisés ou existants pour créer un cluster
{: #subnets_custom}

Lorsque vous créez un cluster standard, des sous-réseaux sont automatiquement créés pour vous. Néanmoins, au lieu d'utiliser ces sous-réseaux, vous pouvez utiliser des sous-réseaux portables existants dans votre compte d'infrastructure IBM Cloud (SoftLayer) ou réutiliser les sous-réseaux d'un cluster supprimé.
{:shortdesc}

Utilisez cette option pour conserver des adresses IP statiques stables lors de création ou de suppression de clusters ou pour commander des blocs d'adresses IP plus importants. Si vous souhaitez à la place obtenir plus d'adresses IP privées portables pour vos services d'équilibreur de charge de cluster en utilisant votre propre sous-réseau de réseau sur site, voir [Ajout d'adresses IP privées portables en ajoutant des sous-réseaux gérés par l'utilisateur aux VLAN privés](#user_managed).

Les adresses IP publiques portables sont facturées au mois. Si vous retirez des adresses IP publiques portables après la mise en place de votre cluster, vous devez quand même payer les frais mensuels, même si vous ne les avez utilisées que brièvement.
{: note}

Avant de commencer :
- [Connectez-vous à votre compte. Ciblez la région appropriée et, le cas échéant, le groupe de ressources. Définissez le contexte de votre cluster](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure).
- Pour réutiliser des sous-réseaux d'un cluster que vous n'utilisez plus, supprimez le cluster inutile. Créez le nouveau cluster immédiatement car les sous-réseaux sont supprimés au bout de 24 heures si vous ne les réutilisez pas.

   ```
   ibmcloud ks cluster-rm --cluster <cluster_name_or_ID>
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

2. [Créez un cluster](/docs/containers?topic=containers-clusters#clusters_cli) en utilisant l'ID du VLAN que vous avez identifié. Ajoutez l'indicateur `--no-subnet` pour empêcher la création automatique d'un nouveau sous-réseau d'adresses IP publiques portable et d'un nouveau sous-réseau d'adresses IP privées portable.

    ```
    ibmcloud ks cluster-create --zone dal10 --machine-type b2c.4x16 --no-subnet --public-vlan 2234945 --private-vlan 2234947 --workers 3 --name my_cluster
    ```
    {: pre}
    Si vous avez oublié dans quelle zone se trouve le VLAN pour l'indicateur `--zone`, vous pouvez vérifier s'il figure dans une zone particulière en exécutant la commande `ibmcloud ks vlans --zone <zone>`.
    {: tip}

3.  Vérifiez que le cluster a été créé. La commande des machines de noeud worker et la configuration et la mise à disposition du cluster dans votre compte peuvent prendre jusqu'à 15 minutes.

    ```
    ibmcloud ks clusters
    ```
    {: pre}

    Lorsque la mise à disposition de votre cluster est terminée, la valeur de **State** passe à `deployed`.

    ```
    Name         ID                                   State      Created          Workers    Zone      Version     Resource Group Name
    mycluster    aaf97a8843a29941b49a598f516da72101   deployed   20170201162433   3          dal10     1.12.6      Default
    ```
    {: screen}

4.  Vérifiez le statut des noeuds worker.

    ```
    ibmcloud ks workers --cluster <cluster_name_or_ID>
    ```
    {: pre}

    Avant de passer à l'étape suivante, les noeuds worker doivent être prêts. La valeur de **State** passe à `normal` et la zone **Status** affiche `Ready`.

    ```
    ID                                                  Public IP        Private IP     Machine Type   State      Status   Zone     Version
    prod-dal10-pa8dfcc5223804439c87489886dbbc9c07-w1    169.xx.xxx.xxx   10.xxx.xx.xxx  free           normal     Ready    dal10      1.12.6
    ```
    {: screen}

5.  Ajoutez le sous-réseau à votre cluster en spécifiant l'ID du sous-réseau. Lorsque vous rendez disponible un sous-réseau pour un cluster, un fichier configmap Kubernetes est créé pour vous et inclut toutes les adresses IP publiques portables disponibles que vous pouvez utiliser. S'il n'existe aucun équilibreur de charge d'application (ALB) Ingress dans la zone où se trouve le VLAN du sous-réseau, une adresse IP publique portable et une adresse IP privée portable sont automatiquement utilisées pour créer les ALB public et privé pour cette zone. Vous pouvez utiliser toutes les autres adresses publiques et privées portables de ce sous-réseau pour créer de services d'équilibreur de charge pour vos applications.

  ```
  ibmcloud ks cluster-subnet-add --cluster <cluster_name_or_id> --subnet-id <subnet_ID>
  ```
  {: pre}

  Exemple de commande :
  ```
  ibmcloud ks cluster-subnet-add --cluster mycluster --subnet-id 807861
  ```
  {: screen}

6. **Important** : pour activer la communication entre des noeuds worker qui se trouvent dans différents sous-réseaux d'un même VLAN, vous devez [activer le routage entre les sous-réseaux sur le même VLAN](#subnet-routing).

<br />


## Gestion des adresses IP portables existantes
{: #managing_ips}

Par défaut, 4 adresses IP publiques portables et 4 adresses IP privées portables peuvent être utilisées pour exposer des applications individuelles sur le réseau public ou privé en [créant un service d'équilibreur de charge](/docs/containers?topic=containers-loadbalancer). Pour créer un service d'équilibreur de charge, vous devez avoir au moins une adresse IP portable du type approprié disponible. Vous pouvez afficher les adresses IP portables disponibles ou libérer une adresse IP portable utilisée.
{: shortdesc}

### Affichage des adresses IP publiques portables disponibles
{: #review_ip}

Pour afficher la liste de toutes les adresses IP portables utilisées et disponibles dans votre cluster, vous pouvez exécuter la commande suivante :
{: shortdesc}

```
kubectl get cm ibm-cloud-provider-vlan-ip-config -n kube-system -o yaml
```
{: pre}

Pour afficher uniquement les adresses IP publiques portables disponibles pour créer des équilibreurs de charge, vous pouvez utiliser la procédure suivante.

Avant de commencer :
-  Vérifiez que vous disposez du [rôle de service {{site.data.keyword.Bluemix_notm}} IAM **Auteur** ou **Responsable**](/docs/containers?topic=containers-users#platform) pour l'espace de nom `default`.
- [Connectez-vous à votre compte. Ciblez la région appropriée et, le cas échéant, le groupe de ressources. Définissez le contexte de votre cluster](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure).

Pour répertorier les adresses IP publiques portables disponibles :

1.  Créez un fichier de configuration de service Kubernetes nommé `myservice.yaml` et définissez un service de type `LoadBalancer` avec une adresse IP d'équilibreur de charge factice. L'exemple suivant utilise l'adresse IP 1.1.1.1 comme adresse IP de l'équilibreur de charge. Remplacez `<zone>` par la zone dans laquelle vous voulez rechercher des adresses IP disponibles.

    ```
    apiVersion: v1
    kind: Service
    metadata:
      labels:
        run: myservice
      name: myservice
      namespace: default
      annotations:
        service.kubernetes.io/ibm-load-balancer-cloud-provider-zone: "<zone>"
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

    La création de ce service échoue car le maître Kubernetes ne parvient pas à localiser l'adresse IP de l'équilibreur de charge spécifié dans le fichier configmap Kubernetes. Lorsque vous exécutez cette commande, le message d'erreur s'affiche, ainsi que la liste des adresses IP publiques disponibles pour le cluster.

    ```
    Erreur sur l'équilibreur de charge cloud a8bfa26552e8511e7bee4324285f6a4a pour le service default/myservice portant l'UID 8bfa2655-2e85-11e7-bee4-324285f6a4af: L'adresse IP 1.1.1.1 du fournisseur cloud demandée n'est pas disponible. Les adresses IP suivantes de fournisseur cloud sont disponibles : <list_of_IP_addresses>
    ```
    {: screen}

<br />


### Libération des adresses IP utilisées
{: #free}

Vous pouvez libérer une adresse IP portable utilisée en supprimant le service d'équilibreur de charge qui l'utilise.
{:shortdesc}

Avant de commencer :
-  Vérifiez que vous disposez du [rôle de service {{site.data.keyword.Bluemix_notm}} IAM **Auteur** ou **Responsable**](/docs/containers?topic=containers-users#platform) pour l'espace de nom `default`.
- [Connectez-vous à votre compte. Ciblez la région appropriée et, le cas échéant, le groupe de ressources. Définissez le contexte de votre cluster](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure).

Pour supprimer un équilibreur de charge :

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

Par défaut, 4 adresses IP publiques portables et 4 adresses IP privées portables peuvent être utilisées pour exposer des applications individuelles sur le réseau public ou privé en [créant un service d'équilibreur de charge](/docs/containers?topic=containers-loadbalancer). Pour créer plus de 4 équilibreurs de charge publics ou 4 équilibreurs de charge privés, vous pouvez obtenir des adresses IP supplémentaires en ajoutant des sous-réseaux au cluster.
{: shortdesc}

Lorsque vous rendez un sous-réseau accessible à un cluster, les adresses IP de ce sous-réseau sont utilisées pour la mise en réseau du cluster. Pour éviter des conflits d'adresse IP, prenez soin d'utiliser un sous-réseau avec un seul cluster. N'utilisez pas en même temps un sous-réseau pour plusieurs clusters ou à d'autres fins hors d'{{site.data.keyword.containerlong_notm}}.
{: important}

Les adresses IP publiques portables sont facturées au mois. Si vous retirez des adresses IP publiques portables après la mise à disposition de votre sous-réseau, vous devez quand même payer les frais mensuels, même si vous ne les avez utilisées que brièvement.
{: note}

### Ajout d'adresses IP portables en commandant d'autres sous-réseaux
{: #request}

Vous pouvez obtenir des adresses IP supplémentaires pour les services d'équilibreur de charge en créant un nouveau sous-réseau dans un compte d'infrastructure IBM Cloud (SoftLayer) et en le rendant disponible pour le cluster que vous avez spécifié.
{:shortdesc}

Avant de commencer :
-  Vérifiez que vous disposez du [rôle de plateforme {{site.data.keyword.Bluemix_notm}} IAM **Opérateur** ou **Administrateur**](/docs/containers?topic=containers-users#platform) pour le cluster.
- [Connectez-vous à votre compte. Ciblez la région appropriée et, le cas échéant, le groupe de ressources. Définissez le contexte de votre cluster](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure).

Pour commander un sous-réseau :

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
    <td>Remplacez <code>&lt;subnet_size&gt;</code> par le nombre d'adresses IP que vous désirez ajouter depuis votre sous-réseau portable. Valeurs admises : 8, 16, 32 ou 64. <p class="note"> Lorsque vous ajoutez des adresses IP portables à votre sous-réseau, trois adresses IP sont utilisées pour les opérations de réseau internes au cluster. Vous ne pouvez pas utiliser ces trois adresses IP pour votre équilibreur de charge d'application ou pour créer un service d'équilibreur de charge. Par exemple, si vous demandez huit adresses IP publiques portables, vous pouvez en utiliser cinq pour exposer vos applications au public.</p> </td>
    </tr>
    <tr>
    <td><code><em>&lt;VLAN_ID&gt;</em></code></td>
    <td>Remplacez <code>&lt;VLAN_ID&gt;</code> par l'ID du réseau local virtuel (VLAN) privé ou public sur lequel vous désirez allouer les adresses IP publiques ou privées portables. Vous devez sélectionner le réseau local virtuel public ou privé auquel un noeud worker existant est connecté. Pour examiner le VLAN privé ou public d'un noeud worker, exécutez la commande <code>ibmcloud ks worker-get --worker &lt;worker_id&gt;</code>. Le sous-réseau est fourni dans la même zone que le VLAN.</td>
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


### Ajout d'adresses IP privées portables en ajoutant des sous-réseaux gérés par l'utilisateur aux VLAN privés
{: #user_managed}

Vous pouvez obtenir des adresses IP privées portables supplémentaires pour les services d'équilibreur de charge en rendant un sous-réseau de réseau sur site disponible pour votre cluster.
{:shortdesc}

Vous préférez réutiliser des sous-réseaux portables existants dans votre compte d'infrastructure IBM Cloud (SoftLayer) à la place ? Voir [Utilisation de sous-réseaux d'infrastructure IBM Cloud (SoftLayer) personnalisés ou existants pour créer un cluster](#subnets_custom).
{: tip}

Conditions requises :
- Les sous-réseaux gérés par l'utilisateur peuvent être ajoutés uniquement à des réseaux locaux virtuels (VLAN) privés.
- La limite de longueur du préfixe de sous-réseau est /24 à /30. Par exemple, `169.xx.xxx.xxx/24` indique 253 adresses IP privées utilisables, alors que `169.xx.xxx.xxx/30` indique 1 adresse IP privée utilisable.
- La première adresse IP dans le sous-réseau doit être utilisée comme passerelle du sous-réseau.

Avant de commencer :
- Configurez le routage du trafic réseau vers et depuis le sous-réseau externe.
- Confirmez que vous disposez bien d'une connectivité VPN entre la passerelle réseau du centre de données sur site et le dispositif de routeur virtuel du réseau privé ou le service VPN strongSwan qui s'exécute dans votre cluster. Pour plus d'informations, voir [Configuration de la connectivité VPN](/docs/containers?topic=containers-vpn).
-  Vérifiez que vous disposez du [rôle de plateforme {{site.data.keyword.Bluemix_notm}} IAM **Opérateur** ou **Administrateur**](/docs/containers?topic=containers-users#platform) pour le cluster.
- [Connectez-vous à votre compte. Ciblez la région appropriée et, le cas échéant, le groupe de ressources. Définissez le contexte de votre cluster](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure).


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

5. Ajoutez un [service d'équilibreur de charge privé](/docs/containers?topic=containers-loadbalancer) ou activez un [ALB Ingress privé](/docs/containers?topic=containers-ingress#private_ingress) pour accéder à votre application via le réseau privé. Pour utiliser une adresse IP privée du sous-réseau que vous avez ajouté, vous devez indiquer une adresse IP figurant dans le CIDR du sous-réseau. Autrement, une adresse IP est sélectionnée de manière aléatoire dans les sous-réseaux d'infrastructure IBM Cloud (SoftLayer) ou dans les sous-réseaux fournis par l'utilisateur sur le VLAN privé.

<br />


## Gestion du routage de sous-réseaux
{: #subnet-routing}

Si vous disposez de plusieurs VLAN pour un cluster, de plusieurs sous-réseaux sur le même VLAN ou d'un cluster à zones multiples, vous devez activer une fonction [VRF (Virtual Router Function)](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#customer-vrf-overview) pour votre compte d'infrastructure IBM Cloud (SoftLayer) pour que vos noeuds worker puissent communiquer entre eux sur le réseau privé. Pour activer la fonction VRF, [contactez le représentant de votre compte d'infrastructure IBM Cloud (SoftLayer)](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#how-you-can-initiate-the-conversion). Si vous ne parvenez pas à activer la fonction VRF ou si vous ne souhaitez pas le faire, activez la fonction [Spanning VLAN](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning). Pour effectuer cette action, vous devez disposer du [droit d'infrastructure](/docs/containers?topic=containers-users#infra_access) **Réseau > Gérer le spanning VLAN pour réseau**, ou vous pouvez demander au propriétaire du compte de l'activer. Pour vérifier si le spanning VLAN est déjà activé, utilisez la [commande](/docs/containers?topic=containers-cs_cli_reference#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`.

Passez en revue les scénarios suivants nécessitant également la fonction Spanning VLAN.

### Activation du routage entre les sous-réseaux principaux sur le même VLAN
{: #vlan-spanning}

Lorsque vous créez un cluster, des sous-réseaux public et privé principaux sont mis à disposition sur les VLAN public et privé. Le sous-réseau public principal se termine par `/28` et fournit 14 adresses IP publiques pour vos noeuds worker. Le sous-réseau privé principal se termine par `/26` et fournit jusqu'à 62 adresses IP privées pour les noeuds worker.
{:shortdesc}

Vous pouvez dépasser les 14 adresses IP publiques et les 62 adresses IP privées initiales correspondant à vos noeuds worker en disposant d'un cluster volumineux ou de plusieurs clusters de taille plus petite au même emplacement sur le même VLAN. Lorsqu'un sous-réseau public ou privé atteint le nombre limite de noeuds worker, un autre sous-réseau principal est commandé dans le même VLAN.

Pour garantir que les noeuds worker de ces sous-réseaux principaux situés sur le même VLAN peuvent communiquer, vous devez activer la fonction Spanning VLAN. Pour obtenir les instructions correspondantes, voir [Activer ou désactiver le spanning VLAN](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning).

Pour vérifier si le spanning VLAN est déjà activé, utilisez la [commande](/docs/containers?topic=containers-cs_cli_reference#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`.
{: tip}

### Gestion du routage de sous-réseaux pour les dispositifs de passerelle
{: #vra-routing}

Lorsque vous créez un cluster, un sous-réseau portable public et un sous-réseau portable privé sont commandés sur les VLAN auxquels est connecté le cluster. Ces sous-réseaux fournissent les adresses IP des services réseau d'équilibreur de charge et d'Ingress.
{: shortdesc}

Cependant, si vous disposez déjà d'un dispositif de routage, tel qu'un [dispositif de routeur virtuel (VRA)](/docs/infrastructure/virtual-router-appliance?topic=virtual-router-appliance-about-the-vra#about-the-vra), les sous-réseaux portables récemment ajoutés des VLAN auxquels est connecté le cluster, ne sont pas configurés sur le routeur. Pour utiliser des services réseau d'équilibreur de charge ou d'Ingress, vous devez vous assurer que les dispositifs réseau peuvent effectuer le routage entre les sous-réseaux sur le même VLAN en [activant la fonction Spanning VLAN](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning).

Pour vérifier si le spanning VLAN est déjà activé, utilisez la [commande](/docs/containers?topic=containers-cs_cli_reference#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`.
{: tip}
