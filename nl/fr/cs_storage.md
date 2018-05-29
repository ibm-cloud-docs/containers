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


# Sauvegarde des données dans votre cluster
{: #storage}
Vous pouvez conserver des données dans {{site.data.keyword.containerlong}} pour les partager entre des instances d'application et pour éviter la perte de ces données en cas de défaillance d'un composant dans votre cluster Kubernetes.

## Planification de stockage à haute disponibilité
{: #planning}

Dans {{site.data.keyword.containerlong_notm}}, vous disposez de plusieurs options pour stocker des données d'application et partager des données entre les pods dans votre cluster. Cependant, les options de stockage n'offrent pas toutes le même niveau de conservation et de disponibilité en cas de défaillance d'un composant de votre cluster ou d'un site complet.
{: shortdesc}

### Options de stockage de données non persistant
{: #non_persistent}

Vous pouvez utiliser des options de stockage non persistant si vos données n'ont pas besoin d'être stockées de manière permanente, de sorte à pouvoir les récupérer en cas de défaillance d'un composant de votre cluster, ou si elles n'ont pas besoin d'être partagées entre les instances d'application. Ces options peuvent également être utilisées afin d'effectuer un test d'unité sur vos composants d'application ou d'essayer de nouvelles fonctions.
{: shortdesc}

L'illustration suivante présente les options de stockage de données non persistant disponibles dans {{site.data.keyword.containerlong_notm}}. Ces options sont disponibles pour les clusters gratuits et standard.
<p>
<img src="images/cs_storage_nonpersistent.png" alt="Options de stockage de données non persistant" width="500" style="width: 500px; border-style: none"/></p>

<table summary="Le tableau présente les options de stockage non persistant. La lecture des lignes s'effectue de gauche à droite, avec le numéro de l'option dans la première colonne, son titre dans la deuxième colonne et une description dans la troisième colonne." style="width: 100%">
<caption>Options de stockage non persistant</caption>
  <thead>
  <th>Option</th>
  <th>Description</th>
  </thead>
  <tbody>
    <tr>
      <td>1. Dans le conteneur ou dans le pod</td>
      <td>De par leur conception, les conteneurs ont une durée de vie brève et ne sont pas à l'abri de défaillances inattendues. Toutefois, vous pouvez consigner des données sur le système de fichiers local afin de stocker des données tout au long du cycle de vie du conteneur. Les données hébergées au sein d'un conteneur ne peuvent pas être partagées avec d'autres conteneurs ou pods et sont perdues en cas de panne ou de suppression du conteneur. Pour plus d'informations, voir [Stockage de données dans un conteneur](https://docs.docker.com/storage/).</td>
    </tr>
  <tr>
    <td>2. Sur le noeud worker</td>
    <td>Chaque noeud worker est configuré avec un stockage principal et un stockage secondaire déterminés par le type de machine que vous sélectionnez pour votre noeud worker. Le stockage principal est utilisé pour stocker les données du système d'exploitation. Il est accessible par le biais d'un [volume <code>hostPath</code> Kubernetes ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/concepts/storage/volumes/#hostpath). Le stockage secondaire est utilisé pour stocker des données dans <code>/var/lib/docker</code>, à savoir, le répertoire dans lequel toutes les données de conteneur sont consignées. Vous pouvez accéder au stockage secondaire en utilisant un [volume <code>emptyDir</code> Kubernetes ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/concepts/storage/volumes/#emptydir)<br/><br/>Alors que les volumes <code>hostPath</code> sont utilisés pour monter des fichiers à partir du système de fichiers du noeud worker sur votre pod, un volume <code>emptyDir</code> crée un répertoire vide qui est affecté à un pod dans votre cluster. Tous les conteneurs figurant dans ce pod peuvent effectuer des opérations de lecture/écriture dans ce volume. Comme le volume est affecté à un pod spécifique, les données ne peuvent pas être partagées avec d'autres pods dans un jeu de répliques.<br/><br/><p>Un volume <code>hostPath</code> ou <code>emptyDir</code> et ses données sont supprimés dans les cas suivants : <ul><li>Le noeud worker est supprimé.</li><li>Le noeud worker est rechargé ou mis à jour.</li><li>Le cluster est supprimé.</li><li>Le compte {{site.data.keyword.Bluemix_notm}} passe à un état 'suspendu'. </li></ul></p><p>Par ailleurs, les données d'un volume <code>emptyDir</code> sont supprimées dans les cas suivants : <ul><li>Le pod auquel il est affecté est supprimé définitivement du noeud worker.</li><li>Le pod auquel il est affecté est planifié pour opérer sur un autre noeud worker.</li></ul></p><p><strong>Remarque :</strong> si le conteneur à l'intérieur du pod tombe en panne, les données du volume restent disponibles sur le noeud worker.</p></td>
    </tr>
    </tbody>
    </table>

### Options de stockage de données persistant pour haute disponibilité
{: persistent}

La principale difficulté lorsque vous créez des applications avec état à haute disponibilité consiste à rendre les données persistantes entre instances d'application et emplacements multiples, et de les maintenir synchronisées en tout temps. Pour les données à haute disponibilité, vous voudrez vous assurer de disposer d'une base de données maître répartie entre plusieurs centres de données, ou même plusieurs régions, et que les données dans cette base de données maître soient répliquées en permanence. Toutes les instances dans votre cluster doivent pouvoir lire et écrire dans cette base de données maître. En cas de défaillance d'une instance de la base de données maître, les autres instances doivent assumer la charge de travail afin que vos applications ne connaissent pas de temps d'indisponibilité.
{: shortdesc}

L'illustration suivante présente les options disponibles dans {{site.data.keyword.containerlong_notm}} pour assurer une haute disponibilité de vos données dans un cluster standard. L'option pertinente dépend des facteurs suivants :
  * **Le type de votre application :** vous pourriez, par exemple, utiliser une application nécessitant le stockage des données dans un fichier et non pas dans une base de données.
  * **Les exigences légales quant au stockage et au routage des données :** vous pourriez, par exemple, être obligé de stocker et de router vos données aux Etats-Unis, sans pouvoir utiliser un service situé en Europe.
  * **Options de sauvegarde et de restauration :** toutes les options de stockage disposent de capacités de sauvegarde et de restauration des données. Vérifiez que les options disponibles répondent aux exigences de votre plan de reprise après incident, telles que la fréquence des sauvegardes ou la possibilité de stocker vos données hors de votre centre de données principal.
  * **Réplication globale :** pour haute disponibilité, vous souhaiterez éventuellement configurer plusieurs instances de stockage, lesquelles seront distribuées et répliquées entre vos centres de données à travers le monde.

<br/>
<img src="images/cs_storage_ha.png" alt="Options de haute disponibilité pour stockage persistant"/>

<table summary="Ce tableau présente les options de stockage persistant. La lecture des lignes s'effectue de gauche à droite, le numéro de l'option figurant dans la première colonne, son titre dans la seconde et une description dans la troisième.">
<caption>Options de stockage persistant</caption>
  <thead>
  <th>Option</th>
  <th>Description</th>
  </thead>
  <tbody>
  <tr>
  <td>1. Stockage de fichiers NFS ou stockage par blocs</td>
  <td>Cette option vous permet de rendre persistantes les données d'application et de conteneur via des volumes Kubernetes persistants. Les volumes sont hébergés dans un [stockage de fichiers NFS ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe") Endurance et Performance](https://www.ibm.com/cloud/file-storage/details) ou dans du [stockage par blocs ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://www.ibm.com/cloud/block-storage) pouvant être utilisé pour des applications qui stockent les données dans un fichier ou sous forme de blocs plutôt que dans une base de données. Le stockage de fichiers et le stockage par blocs sont chiffrés au niveau de l'API REST.<p>{{site.data.keyword.containershort_notm}} fournit des classes de stockage prédéfinies qui définissent les plages de tailles de stockage, les opérations IOPS, la règle de suppression et les autorisations d'accès en écriture au volume. Pour lancer une demande de stockage de fichiers ou de stockage par blocs, vous devez créer une [réservation de volume persistant (PVC)](cs_storage.html#create). Après avoir soumis une réservation PVC, {{site.data.keyword.containershort_notm}} met à disposition dynamiquement un volume persistant qui est hébergé dans du stockage de fichiers NFS ou du stockage par blocs. [Vous pouvez monter une réservation PVC](cs_storage.html#app_volume_mount) en tant que volume dans votre déploiement pour permettre aux conteneurs d'effectuer des opérations de lecture-écriture dans le volume. </p><p>Les volumes persistants sont provisionnés dans le centre de données où est situé le noeud worker. Vous pouvez partager les données avec la même réplique et/ou d'autres déploiements dans le même cluster. Vous ne pouvez pas partager les données lorsqu'elles sont situées dans des centres de données ou des régions différents. </p><p>Par défaut, le stockage NFS et le stockage par blocs ne sont pas sauvegardés automatiquement. Vous pouvez configurer une sauvegarde périodique pour votre cluster en exploitant les [mécanismes de sauvegarde et de restauration](cs_storage.html#backup_restore) fournis. Lorsqu'un conteneur tombe en panne ou qu'un pod est retiré d'un noeud worker, les données ne sont pas supprimées et sont toujours accessibles par d'autres déploiements qui montent le volume. </p><p><strong>Remarque :</strong> le stockage de partage de fichiers NFS et le stockage par blocs sont facturés sur une base mensuelle. Si vous provisionnez un stockage persistant pour votre cluster et le retirez immédiatement, vous devrez néanmoins payer la redevance mensuelle pour le stockage persistant, même si vous ne l'avez utilisé que très brièvement.</p></td>
  </tr>
  <tr id="cloud-db-service">
    <td>2. Service de base de données Cloud</td>
    <td>Cette option vous permet de rendre persistantes les données via un service de base de données cloud {{site.data.keyword.Bluemix_notm}}, tel qu'[IBM Cloudant NoSQL DB](/docs/services/Cloudant/getting-started.html#getting-started-with-cloudant). Les données stockées via cette option sont accessibles entre les clusters, les emplacements et les régions. <p> Vous pouvez vous contenter de configurer une seule instance base de données à laquelle accéderont toutes vos applications ou bien [configurer plusieurs instances entre les centres de données, et une réplication](/docs/services/Cloudant/guides/active-active.html#configuring-cloudant-nosql-db-for-cross-region-disaster-recovery) entre les instances pour une plus haute disponibilité. Dans la base de données IBM Cloudant NoSQL, les données ne sont pas sauvegardées automatiquement. Vous pouvez utiliser les [mécanismes de sauvegarde et de restauration](/docs/services/Cloudant/guides/backup-cookbook.html#cloudant-nosql-db-backup-and-recovery) fournis afin de protéger vos données en cas de panne du site.</p> <p> Pour utiliser un service dans votre cluster, vous devez [lier le {{site.data.keyword.Bluemix_notm}} service ](cs_integrations.html#adding_app) à un espace de nom dans votre cluster. Lorsque vous liez le service au cluster, une valeur confidentielle Kubernetes est créée. Celle-ci héberge des informations confidentielles relatives au service, comme son URL, votre nom d'utilisateur et votre mot de passe. Vous pouvez monter le volume en tant que volume secret sur votre pod et accéder au service en utilisant les données d'identification dans la valeur confidentielle. En montant le volume sur d'autres pods, vous pouvez également partager les données entre les pods. Lorsqu'un conteneur tombe en panne ou qu'un pod est retiré d'un noeud worker, les données ne sont pas perdues et restent accessibles aux autres pods qui montent le volume secret. <p>La plupart des services de base de données {{site.data.keyword.Bluemix_notm}} proposent un espace disque gratuit pour une petite quantité de données, de sorte que vous puissiez tester ses caractéristiques.</p></td>
  </tr>
  <tr>
    <td>3. Base de données sur site</td>
    <td>Si vos données doivent être stockées sur site en raison de contraintes légales, vous pouvez [configurer une connexion VPN (réseau privé virtuel)](cs_vpn.html#vpn) vers votre base de données locale et utiliser les mécanismes de stockage, de sauvegarde et de réplication existants dans votre centre de données.</td>
  </tr>
  </tbody>
  </table>

{: caption="Tableau. Options de stockage de données persistant pour les déploiements dans des clusters Kubernetes" caption-side="top"}

<br />



## Utilisation de partages de fichiers NFS existants dans des clusters
{: #existing}

Si vous disposez déjà de partages de fichiers NFS existants dans votre compte d'infrastructure IBM Cloud (SoftLayer) et que vous voulez les utiliser avec Kubernetes, vous pouvez le faire en créant un volume persistant (PV) pour votre stockage existant.
{:shortdesc}

Un volume persistant (PV) est une ressource Kubernetes qui représente une unité de stockage réelle mise à disposition dans un centre de données. Les volumes persistants condensent les détails de mise à disposition d'un type de stockage spécifique par {{site.data.keyword.Bluemix_notm}} Storage. Pour monter un volume persistant sur votre cluster, vous devez demander du stockage persistant pour votre pod en créant une réservation de volume persistant (PVC). Le diagramme suivant illustre les relations entre les volumes persistants (PV) et les réservations de volume persistant (PVC).

![Créer des volumes persistants et des réservations de volumes persistants](images/cs_cluster_pv_pvc.png)

 Comme illustré dans le diagramme, pour permettre l'utilisation de partage de fichiers NFS existants avec Kubernetes, vous devez créer des volumes persistants (PV) d'une certaine taille et avec un mode d'accès déterminé, ainsi qu'une réservation de volume persistant (PVC) qui soit conforme à la spécification de volume persistant (PV). Si le volume persistant (PV) et la réservation PVC correspondent, ils sont liés à l'un à l'autre. Seules les PVC peuvent être utilisées par l'utilisateur du cluster pour monter le volume dans un déploiement. Cette procédure est dénommée provisionnement statique de stockage persistant.

Avant de commencer, vérifiez que vous disposez d'un partage de fichiers NFS existant que vous pouvez utiliser pour créer votre volume persistant (PV). Par exemple, si vous avez [créé une réservation PVC avec une politique de classe de stockage `retain`](#create) auparavant, vous pouvez utiliser ces données conservées dans le partage de fichiers NFS pour cette nouvelle réservation PVC.

**Remarque :** le provisionnement statique de stockage persistant ne s'applique qu'aux partages de fichiers NFS existants. Si vous ne disposez pas de partages de fichiers NFS existants, les utilisateurs du cluster peuvent utiliser le processus de [provisionnement dynamique](cs_storage.html#create) pour ajouter des volumes persistants (PV).

Pour créer un volume persistant (PV) et une réservation de volume persistant (PVC) correspondante, procédez comme suit :

1.  Dans votre compte d'infrastructure IBM Cloud (SoftLayer), recherchez l'ID et le chemin d'accès du partage de fichiers NFS dans lequel créer votre objet PV. Par ailleurs, autorisez le stockage de fichiers sur les sous-réseaux du cluster. Cette autorisation permet à votre cluster d'accéder au stockage.
    1.  Connectez-vous à votre compte d'infrastructure IBM Cloud (SoftLayer).
    2.  Cliquez sur **Stockage**.
    3.  Cliquez sur **Stockage de fichiers** et, dans le menu **Actions**, sélectionnez **Autoriser l'hôte**.
    4.  Sélectionnez **Sous-réseaux**.
    5.  Dans la liste déroulante, sélectionnez le sous-réseau de VLAN privé auquel est connecté votre noeud worker. Pour obtenir le sous-réseau de votre noeud worker, exécutez la commande `bx cs workers <cluster_name>` et comparez l'adresse IP privée (`Private IP`) de votre noeud worker au sous-réseau que vous avez trouvé dans la liste déroulante.
    6.  Cliquez sur **Soumettre**.
    6.  Cliquez sur le nom du stockage de fichiers.
    7.  Notez la valeur de la zone **Point de montage**. Cette zone est affichée sous la forme `<server>:/<path>`.
2.  Créez un fichier de configuration de stockage pour votre volume persistant. Incluez le serveur et le chemin de la zone **Point de montage** du système de fichiers.

    ```
    apiVersion: v1
    kind: PersistentVolume
    metadata:
     name: mypv
    spec:
     capacity:
       storage: "20Gi"
     accessModes:
       - ReadWriteMany
     nfs:
       server: "nfslon0410b-fz.service.networklayer.com"
       path: "/IBM01SEV8491247_0908/data01"
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code>name</code></td>
    <td>Entrez le nom de l'objet PV que vous désirez créer.</td>
    </tr>
    <tr>
    <td><code>spec/capacity/storage</code></td>
    <td>Entrez la taille de stockage du partage de fichiers NFS existant. Cette taille doit être indiquée en gigaoctets, par exemple 20Gi (20 Go) ou 1000Gi (1 To), et correspondre à celle du partage de fichiers existant.</td>
    </tr>
    <tr>
    <td><code>accessMode</code></td>
    <td>Les modes d'accès définissent le mode de montage d'une réservation de volume persistant (PVC) sur un noeud worker.<ul><li>ReadWriteOnce (RWO) : Le volume persistant ne peut être monté sur des déploiements que dans un seul noeud worker. Les conteneurs dans des déploiements qui sont montés sur ce volume persistant peuvent effectuer des opérations de lecture-écriture dans le volume.</li><li>ReadOnlyMany (ROX) : le volume persistant peut être monté sur des déploiements hébergés sur plusieurs noeuds worker. Les déploiements montés sur ce volume persistant ne peuvent accéder au volume qu'en mode lecture.</li><li>ReadWriteMany (RWX) : ce volume persistant peut être monté sur des déploiements hébergés sur plusieurs noeuds worker. Les déploiements montés sur ce volume persistant peuvent accéder en lecture et en écriture au volume.</li></ul></td>
    </tr>
    <tr>
    <td><code>spec/nfs/server</code></td>
    <td>Entrez l'ID du serveur du partage de fichiers NFS.</td>
    </tr>
    <tr>
    <td><code>path</code></td>
    <td>Entrez le chemin d'accès au partage de fichiers NFS dans lequel vous désirez créer l'objet PV.</td>
    </tr>
    </tbody></table>

3.  Créez l'objet PV dans votre cluster.

    ```
    kubectl apply -f deploy/kube-config/mypv.yaml
    ```
    {: pre}

4.  Vérifiez que le volume persistant (PV) est créé.

    ```
    kubectl get pv
    ```
    {: pre}

5.  Créez un autre fichier de configuration pour créer votre réservation de volume persistant (PVC). Pour que la PVC corresponde à l'objet PV que vous avez créé auparavant, vous devez sélectionner la même valeur pour `storage` et `accessMode`. La zone `storage-class` doit être vide. Si une de ces zones ne correspond pas au volume persistant (PV), un nouveau PV est créé automatiquement à la place.

    ```
    kind: PersistentVolumeClaim
    apiVersion: v1
    metadata:
     name: mypvc
     annotations:
       volume.beta.kubernetes.io/storage-class: ""
    spec:
     accessModes:
       - ReadWriteMany
     resources:
       requests:
         storage: "20Gi"
    ```
    {: codeblock}

6.  Créez votre réservation de volume persistant (PVC).

    ```
    kubectl apply -f deploy/kube-config/mypvc.yaml
    ```
    {: pre}

7.  Vérifiez que votre PVC est créée et liée à l'objet PV. Ce processus peut prendre quelques minutes.

    ```
    kubectl describe pvc mypvc
    ```
    {: pre}

    Votre sortie sera similaire à ceci.

    ```
    Name: mypvc
    Namespace: default
    StorageClass: ""
    Status: Bound
    Volume: pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
    Labels: <none>
    Capacity: 20Gi
    Access Modes: RWX
    Events:
      FirstSeen LastSeen Count From        SubObjectPath Type Reason Message
      --------- -------- ----- ----        ------------- -------- ------ -------
      3m 3m 1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 } Normal Provisioning External provisioner is provisioning volume for claim "default/my-persistent-volume-claim"
      3m 1m  10 {persistentvolume-controller } Normal ExternalProvisioning cannot find provisioner "ibm.io/ibmc-file", expecting that a volume for the claim is provisioned either manually or via external software
      1m 1m 1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 } Normal ProvisioningSucceeded Successfully provisioned volume pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
    ```
    {: screen}


Vous venez de créer un objet PV que vous avez lié à une PVC. Les utilisateurs du cluster peuvent désormais [monter la PVC](#app_volume_mount) sur leurs déploiements et commencer à effectuer des opérations de lecture et d'écriture sur l'objet PV.

<br />



## Utilisation de stockage par blocs existant dans votre cluster
{: #existing_block}

Avant de commencer, vérifiez que vous disposez d'une instance de stockage par blocs existante que vous pouvez utiliser pour créer votre volume persistant (PV). Par exemple, si vous avez [créé une réservation PVC avec une politique de classe de stockage `retain`](#create) auparavant, vous pouvez utiliser ces données conservées dans le stockage par blocs existant pour cette nouvelle réservation PVC.

Pour créer un volume persistant (PV) et une réservation de volume persistant (PVC) correspondante, procédez comme suit :

1.  Récupérez ou générez une clé d'API pour votre compte d'infrastructure IBM Cloud (SoftLayer).
    1. Connectez-vous au [portail d'infrastructure IBM Cloud (SoftLayer) ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://control.softlayer.com/).
    2. Sélectionnez **Compte**, puis **Utilisateurs** et ensuite **Liste d'utilisateurs**.
    3. Recherchez votre ID utilisateur.
    4. Dans la colonne **Clé d'API**, cliquez sur **Générer** pour générer la clé d'API ou sur **Afficher** pour afficher votre clé d'API existante.
2.  Récupérez le nom d'utilisateur d'API correspondant à votre compte d'infrastructure IBM Cloud (SoftLayer).
    1. Dans le menu **Liste d'utilisateurs**, sélectionnez votre ID utilisateur.
    2. Dans la section **Informations d'accès à l'API**, retrouvez votre **Nom d'utilisateur de l'API**.
3.  Connectez-vous au plug-in d'interface de ligne de commande (CLI) de l'infrastructure IBM Cloud.
    ```
    bx sl init
    ```
    {: pre}

4.  Optez pour l'authentification à l'aide du nom d'utilisateur et de la clé d'API de votre compte d'infrastructure IBM Cloud (SoftLayer).
5.  Entrez le nom d'utilisateur et la clé d'API que vous avez récupérés dans les étapes précédentes.
6.  Affichez la liste des unités de stockage par blocs.
    ```
    bx sl block volume-list
    ```
    {: pre}

    Vous obtenez une sortie similaire à ceci :
    ```
    id         username            datacenter   storage_type              capacity_gb   bytes_used   ip_addr         lunId   active_transactions
    38642141   IBM02SEL1543159-1   dal10        endurance_block_storage   20            -            169.xx.xxx.xxx   170     0
    ```
    {: screen}

7.  Notez les valeurs `id`, `ip_addr`, `capacity_gb` et `lunId` de l'unité de stockage par blocs que vous voulez monter sur votre cluster.
8.  Créez un fichier de configuration pour votre volume persistant. Incluez l'ID de stockage par blocs, l'adresse IP, la taille et l'ID de numéro d'unité logique (lun) que vous avez récupérés à l'étape précédente.

    ```
    apiVersion: v1
    kind: PersistentVolume
    metadata:
      name: mypv
    spec:
      capacity:
        storage: "<storage_size>"
      accessModes:
        - ReadWriteOnce
      flexVolume:
        driver: "ibm/ibmc-block"
        fsType: "ext4"
        options:
          "Lun": "<lun_ID>"
          "TargetPortal": "<IP_address>"
          "VolumeID": "<volume_ID>"
          "volumeName": "<volume_name>"
      ```
      {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code>metadata/name</code></td>
    <td>Entrez le nom du volume persistant que vous désirez créer.</td>
    </tr>
    <tr>
    <td><code>spec/capacity/storage</code></td>
    <td>Entrez la taille de stockage du stockage par blocs existant que vous avez récupérée à l'étape précédente dans <code>capacity-gb</code>. La taille de stockage doit être indiquée en gigaoctets, par exemple 20Gi (20 Go) ou 1000Gi (1 To).</td>
    </tr>
    <tr>
    <td><code>flexVolume/options/Lun</code></td>
    <td>Entrez l'ID de numéro d'unité logique (lun) de votre stockage par blocs que vous avez récupéré à l'étape précédente dans <code>lunId</code>.</td>
    </tr>
    <tr>
    <td><code>flexVolume/options/TargetPortal</code></td>
    <td>Entrez l'adresse IP de votre stockage par blocs que vous avez récupérée à l'étape précédente dans <code>ip_addr</code>. </td>
    </tr>
    <tr>
	    <td><code>flexVolume/options/VolumeId</code></td>
	    <td>Entrez l'ID de votre stockage par blocs que vous avez récupéré à l'étape précédente dans <code>id</code>.</td>
	    </tr>
	    <tr>
		    <td><code>flexVolume/options/volumeName</code></td>
		    <td>Entrez un nom pour votre volume.</td>
	    </tr>
    </tbody></table>

9.  Créez le volume persistant dans votre cluster.
    ```
    kubectl apply -f mypv.yaml
    ```
    {: pre}

10. Vérifiez que le volume persistant (PV) est créé.
    ```
    kubectl get pv
    ```
    {: pre}

11. Créez un autre fichier de configuration pour créer votre réservation de volume persistant (PVC). Pour que cette réservation corresponde au volume persistant que vous avez créé auparavant, vous devez sélectionner la même valeur pour `storage` et `accessMode`. La zone `storage-class` doit être vide. Si une de ces zones ne correspond pas au volume persistant (PV), un nouveau PV est créé automatiquement à la place.

     ```
     kind: PersistentVolumeClaim
    apiVersion: v1
    metadata:
     name: mypvc
     annotations:
       volume.beta.kubernetes.io/storage-class: ""
     spec:
      accessModes:
        - ReadWriteOnce
      resources:
        requests:
          storage: "20Gi"
     ```
     {: codeblock}

12.  Créez votre réservation de volume persistant (PVC).
     ```
     kubectl apply -f mypvc.yaml
     ```
     {: pre}

13.  Vérifiez que votre réservation PVC est créée et liée au volume persistant que vous avec créé auparavant. Ce processus peut prendre quelques minutes.
     ```
     kubectl describe pvc mypvc
     ```
     {: pre}

     Votre sortie sera similaire à ceci.

     ```
     Name: mypvc
    Namespace: default
    StorageClass: ""
     Status: Bound
     Volume: pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
     Labels: <none>
     Capacity: 20Gi
     Access Modes: RWO
     Events:
       FirstSeen LastSeen Count From        SubObjectPath Type Reason Message
       --------- -------- ----- ----        ------------- -------- ------ -------
       3m 3m 1 {ibm.io/ibmc-block 31898035-3011-11e7-a6a4-7a08779efd33 } Normal Provisioning External provisioner is provisioning volume  for claim "default/my-persistent-volume-claim"
       3m 1m	 10 {persistentvolume-controller } Normal ExternalProvisioning cannot find provisioner "ibm.io/ibmc-block", expecting that  a volume for the claim is provisioned either manually or via external software
       1m 1m 1 {ibm.io/ibmc-block 31898035-3011-11e7-a6a4-7a08779efd33 } Normal ProvisioningSucceeded	Successfully provisioned volume  pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
     ```
     {: screen}

Vous venez de créer un objet PV que vous avez lié à une réservation PVC. Les utilisateurs du cluster peuvent désormais [monter la réservation PVC](#app_volume_mount) sur leurs déploiements et commencer à effectuer des opérations de lecture et d'écriture sur le volume persistant.

<br />



## Ajout de stockage de fichiers NFS ou de stockage par blocs à des applications
{: #create}

Créez une réservation de volume persistant (PVC) pour mettre à disposition un stockage de fichiers NFS ou un stockage par blocs pour votre cluster. Ensuite, montez cette réservation sur un volume persistant (PV) pour vous assurer que ces données sont disponibles même en cas de défaillance ou d'arrêt des pods.
{:shortdesc}

Le stockage de fichiers NFS et le stockage par blocs sur lesquels s'appuie le volume persistant sont mis en cluster par IBM pour assurer la haute disponibilité de vos données. Les classes de stockage décrivent les offres de types de stockage disponibles et définissent des caractéristiques telles que la politique de conservation des données, leur taille en gigaoctets et le nombre d'entrées-sorties par seconde (IOPS) lorsque vous créez votre volume persistant (PV).

Avant de commencer :
- Si vous disposez d'un pare-feu, [autorisez l'accès sortant](cs_firewall.html#pvc) pour les plages d'adresses IP de l'infrastructure IBM Cloud (SoftLayer) des emplacements sur lesquels résident vos clusters, de manière à pouvoir créer des réservations de volume persistant (PVC).
- Si vous souhaitez monter du stockage par blocs sur vos applications, vous devez d'abord installer le [plug-in {{site.data.keyword.Bluemix_notm}} Storage pour le stockage par blocs](#install_block).

Pour ajouter du stockage persistant :

1.  Examinez les classes de stockage disponibles. {{site.data.keyword.containerlong}} fournit des classes de stockage prédéfinies pour le stockage de fichiers NFS et le stockage par blocs afin que l'administrateur du cluster n'ait pas besoin d'en créer. La classe de stockage `ibmc-file-bronze` est identique à la classe de stockage `default`.

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
    ibmc-block-custom            ibm.io/ibmc-block
    ibmc-block-bronze            ibm.io/ibmc-block
    ibmc-block-gold              ibm.io/ibmc-block
    ibmc-block-silver            ibm.io/ibmc-block
    ibmc-block-retain-bronze     ibm.io/ibmc-block
    ibmc-block-retain-silver     ibm.io/ibmc-block
    ibmc-block-retain-gold       ibm.io/ibmc-block
    ibmc-block-retain-custom     ibm.io/ibmc-block
    ```
    {: screen}

    **Astuce :** pour modifier la classe de stockage, exécutez la commande `kubectl patch storageclass <storageclass> -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'` et remplacez `<storageclass>` par le nom de la classe de stockage.

2.  Déterminez si vous voulez conserver vos données et le partage de fichiers NFS ou le stockage par blocs après avoir supprimé la réservation de volume persistant (PVC).
    - Pour conserver vos données, choisissez une classe de stockage `retain`. Lorsque vous supprimez la réservation PVC, le volume persistant est retiré, mais le fichier NFS ou le stockage par blocs, ainsi que vos données existent toujours dans votre compte d'infrastructure IBM Cloud (SoftLayer). Plus tard, pour accéder à ces données dans votre cluster, créez une réservation de volume persistant (PVC) et un volume persistant (PV) correspondant qui se réfère à votre [fichier NFS](#existing) ou votre [stockage par blocs](#existing_block) existant.
    - Si vous souhaitez que les données et votre partage de fichiers NFS ou votre stockage par blocs soient supprimés en même temps que la réservation PVC, choisissez une classe de stockage sans `retain`.

3.  **Si vous choisissez une classe de stockage Bronze, Silver ou Gold** : vous obtenez un [stockage Endurance ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://knowledgelayer.softlayer.com/topic/endurance-storage) qui définit le nombre d'entrées-sorties par seconde (IOPS) par Go pour chaque classe. Vous pouvez toutefois déterminer le nombre total d'IOPS en sélectionnant une taille sur la plage disponible. Vous pouvez sélectionner le nombre entier de votre choix pour les tailles en gigaoctets dans la limite de la plage autorisée (telle que 20 Gi, 256 Gi, 11854 Gi). Par exemple, si vous sélectionnez une taille de partage de fichiers ou de stockage par blocs de 1000 Gi dans la classe de stockage Silver de 4 IOPS par Go, votre volume dispose d'un total de 4000 IOPS. Plus votre volume persistant (PV) dispose d'IOPS, plus vite il peut traiter les opérations d'entrée-sortie. Le tableau suivant décrit le nombre d'IOPS par gigaoctet et la plage de tailles de chaque classe de stockage.

    <table>
         <caption>Tableau des plages de tailles de classe de stockage et nombre d'opérations d'entrée-sortie par seconde (IOPS) par gigaoctet</caption>
         <thead>
         <th>Classe de stockage</th>
         <th>IOPS par gigaoctet</th>
         <th>Plage de tailles en gigaoctets</th>
         </thead>
         <tbody>
         <tr>
         <td>Bronze (valeur par défaut)</td>
         <td>2 IOPS/Go</td>
         <td>20-12000 Gi</td>
         </tr>
         <tr>
         <td>Silver</td>
         <td>4 IOPS/Go</td>
         <td>20-12000 Gi</td>
         </tr>
         <tr>
         <td>Gold</td>
         <td>10 IOPS/Go</td>
         <td>20-4000 Gi</td>
         </tr>
         </tbody></table>

    <p>**Exemple de commande illustrant les caractéristiques d'une classe de stockage** :</p>

    <pre class="pre"><code>kubectl describe storageclasses ibmc-file-silver</code></pre>

4.  **Si vous sélectionnez la classe de stockage personnalisée** : vous obtenez un [stockage de type Performance ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://knowledgelayer.softlayer.com/topic/performance-storage) et un contrôle accru sur la sélection des combinaisons d'IOPS et de taille. Par exemple, si vous sélectionnez une taille de 40 Gi pour votre réservation de volume persistant (PVC), vous pouvez choisir un nombre d'IOPS multiple de 100 compris entre 100 et 2000 IOPS. Le tableau suivant indique la plage d'IOPS que vous pouvez choisir en fonction de la taille que vous sélectionnez.

    <table>
         <caption>Tableau des plages de tailles de classe de stockage et nombre d'opérations d'entrée-sortie par seconde (IOPS)</caption>
         <thead>
         <th>Plage de tailles en gigaoctets</th>
         <th>Plage d'IOPS en multiples de 100</th>
         </thead>
         <tbody>
         <tr>
         <td>20-39 Gi</td>
         <td>100-1000 IOPS</td>
         </tr>
         <tr>
         <td>40-79 Gi</td>
         <td>100-2000 IOPS</td>
         </tr>
         <tr>
         <td>80-99 Gi</td>
         <td>100-4000 IOPS</td>
         </tr>
         <tr>
         <td>100-499 Gi</td>
         <td>100-6000 IOPS</td>
         </tr>
         <tr>
         <td>500-999 Gi</td>
         <td>100-10000 IOPS</td>
         </tr>
         <tr>
         <td>1000-1999 Gi</td>
         <td>100-20000 IOPS</td>
         </tr>
         <tr>
         <td>2000-2999 Gi</td>
         <td>200-40000 IOPS</td>
         </tr>
         <tr>
         <td>3000-3999 Gi</td>
         <td>200-48000 IOPS</td>
         </tr>
         <tr>
         <td>4000-7999 Gi</td>
         <td>300-48000 IOPS</td>
         </tr>
         <tr>
         <td>8000-9999 Gi</td>
         <td>500-48000 IOPS</td>
         </tr>
         <tr>
         <td>10000-12000 Gi</td>
         <td>1000-48000 IOPS</td>
         </tr>
         </tbody></table>

    <p>**Exemple de commande illustrant les caractéristiques d'une classe de stockage personnalisée** :</p>

    <pre class="pre"><code>kubectl describe storageclasses ibmc-file-retain-custom</code></pre>

5.  Déterminez le mode de facturation de votre choix soit sur une base horaire ou mensuelle. Par défaut, vous êtes facturé au mois.

6.  Créez un fichier de configuration pour définir votre PVC et sauvegardez la configuration sous forme de fichier `.yaml`.

    -  **Exemple de classes de stockage Bronze, Silver et Gold** :
       Le fichier `.yaml` suivant crée une réservation nommée `mypvc` de la classe de stockage `"ibmc-file-silver"`, facturée à l'heure (`"hourly"`), avec une taille de `24Gi`. Si vous souhaitez créer une réservation de volume persistant (PVC) pour monter le stockage par blocs sur votre cluster, veillez à entrer `ReadWriteOnce` dans la section `accessModes`.

       ```
       apiVersion: v1
       kind: PersistentVolumeClaim
       metadata:
         name: mypvc
         annotations:
           volume.beta.kubernetes.io/storage-class: "ibmc-file-silver"
         labels:
           billingType: "hourly"
       spec:
         accessModes:
           - ReadWriteMany
         resources:
           requests:
             storage: 24Gi
        ```
        {: codeblock}

    -  **Exemple de classes de stockage personnalisées** :
       Le fichier `.yaml` suivant crée une réservation nommée `mypvc` de la classe de stockage `ibmc-file-retain-custom`, facturée par défaut au mois (`"monthly"`), avec une taille de `45Gi` et `"300"` opérations d'entrée-sortie par seconde (IOPS). Si vous souhaitez créer une réservation de volume persistant (PVC) pour monter le stockage par blocs sur votre cluster, veillez à entrer `ReadWriteOnce` dans la section `accessModes`.

       ```
       apiVersion: v1
       kind: PersistentVolumeClaim
       metadata:
         name: mypvc
         annotations:
           volume.beta.kubernetes.io/storage-class: "ibmc-file-retain-custom"
         labels:
           billingType: "monthly"
       spec:
         accessModes:
           - ReadWriteMany
         resources:
           requests:
             storage: 45Gi
             iops: "300"
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>metadata/name</code></td>
        <td>Entrez le nom de la réservation de volume persistant (PVC).</td>
        </tr>
        <tr>
        <td><code>metadata/annotations</code></td>
        <td>Indiquez la classe de stockage du volume persistant (PV) :
          <ul>
          <li>ibmc-file-bronze / ibmc-file-retain-bronze : 2 IOPS par Go.</li>
          <li>ibmc-file-silver / ibmc-file-retain-silver : 4 IOPS par Go.</li>
          <li>ibmc-file-gold / ibmc-file-retain-gold : 10 IOPS par Go.</li>
          <li>ibmc-file-custom / ibmc-file-retain-custom : Plusieurs valeurs d'IOPS disponibles.</li>
          <li>ibmc-block-bronze / ibmc-block-retain-bronze : 2 IOPS par Go.</li>
          <li>ibmc-block-silver / ibmc-block-retain-silver : 4 IOPS par Go.</li>
          <li>ibmc-block-gold / ibmc-block-retain-gold : 10 IOPS par Go.</li>
          <li>ibmc-block-custom / ibmc-block-retain-custom : Plusieurs valeurs d'IOPS disponibles.</li></ul>
          <p>Si vous n'indiquez pas de classe de stockage, le volume persistant (PV) est créé avec la classe de stockage par défaut.</p><p>**Astuce :** pour modifier la classe de stockage par défaut, exécutez la commande <code>kubectl patch storageclass &lt;storageclass&gt; -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'</code> et remplacez <code>&lt;storageclass&gt;</code> par le nom de la classe de stockage.</p></td>
        </tr>
        <tr>
          <td><code>metadata/labels/billingType</code></td>
          <td>Indiquez la fréquence de calcul de votre facture de stockage, au mois ("monthly") ou à l'heure ("hourly"). La valeur par défaut est "monthly".</td>
        </tr>
        <tr>
        <td><code>spec/resources/requests/storage</code></td>
        <td>Entrez la taille du stockage de fichiers, en gigaoctets (Gi). Choisissez un nombre entier compris dans la plage de tailles autorisée. </br></br><strong>Remarque : </strong> une fois le stockage alloué, vous ne pouvez plus modifier la taille de votre partage de fichiers NFS ou de votre stockage par blocs. Veillez à indiquer une taille correspondant à la quantité de données que vous envisagez de stocker. </td>
        </tr>
        <tr>
        <td><code>spec/resources/requests/iops</code></td>
        <td>Cette option s'applique uniquement aux classes de stockage personnalisées (`ibmc-file-custom / ibmc-file-retain-custom / ibmc-block-custom / ibmc-block-retain-custom`). Indiquez le nombre total d'opérations d'entrée-sortie par seconde (IOPS) pour le stockage, en sélectionnant un multiple de 100 dans la plage autorisée. Pour voir toutes les options, exécutez la commande `kubectl describe storageclasses <storageclass>`. Si vous choisissez une valeur IOPS autre que celle répertoriée, la valeur IOPS est arrondie à la valeur supérieure.</td>
        </tr>
        </tbody></table>

7.  Créez la réservation de volume persistant (PVC).

    ```
    kubectl apply -f mypvc.yaml
    ```
    {: pre}

8.  Vérifiez que votre PVC est créée et liée au volume persistant (PV). Ce processus peut prendre quelques minutes.

    ```
    kubectl describe pvc mypvc
    ```
    {: pre}

    Exemple de sortie :

    ```
    Name: mypvc
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

9.  {: #app_volume_mount}Pour monter la PVC sur votre déploiement, créez un fichier de configuration `.yaml`.

    ```
    apiVersion: apps/v1beta1
    kind: Deployment
    metadata:
      name: <deployment_name>
      labels:
        app: <deployment_label>
    spec:
      selector:
        matchLabels:
          app: <app_name>
      template:
        metadata:
          labels:
            app: <app_name>
        spec:
          containers:
          - image: <image_name>
            name: <container_name>
            volumeMounts:
            - name: <volume_name>
              mountPath: /<file_path>
          volumes:
          - name: <volume_name>
            persistentVolumeClaim:
              claimName: <pvc_name>
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
    </thead>
    <tbody>
        <tr>
    <td><code>metadata/labels/app</code></td>
    <td>Libellé du déploiement.</td>
      </tr>
      <tr>
        <td><code>spec/selector/matchLabels/app</code> <br/> <code>spec/template/metadata/labels/app</code></td>
        <td>Libellé de votre application.</td>
      </tr>
    <tr>
    <td><code>template/metadata/labels/app</code></td>
    <td>Libellé du déploiement.</td>
      </tr>
    <tr>
    <td><code>spec/containers/image</code></td>
    <td>Nom de l'image que vous désirez utiliser. Pour répertorier les images disponibles dans un votre compte {{site.data.keyword.registryshort_notm}}, exécutez la commande `bx cr image-list`.</td>
    </tr>
    <tr>
    <td><code>spec/containers/name</code></td>
    <td>Nom du conteneur que vous désirez déployer dans votre cluster.</td>
    </tr>
    <tr>
    <td><code>spec/containers/volumeMounts/mountPath</code></td>
    <td>Chemin absolu du répertoire où est monté le volume dans le conteneur.</td>
    </tr>
    <tr>
    <td><code>spec/containers/volumeMounts/name</code></td>
    <td>Nom du volume à monter sur votre pod.</td>
    </tr>
    <tr>
    <td><code>volumes/name</code></td>
    <td>Nom du volume à monter sur votre pod. Généralement, ce nom est identique à <code>volumeMounts/name</code>.</td>
    </tr>
    <tr>
    <td><code>volumes/persistentVolumeClaim/claimName</code></td>
    <td>Nom de la réservation de volume persistant (PVC) que vous voulez utiliser comme volume. Lorsque vous montez le volume sur le pod, Kubernetes identifie le volume persistant (PV) lié à la PVC et permet à l'utilisateur d'effectuer des opérations de lecture et d'écriture dans ce PV.</td>
    </tr>
    </tbody></table>

10.  Créez le déploiement et montez la PVC.
     ```
     kubectl apply -f <local_yaml_path>
     ```
     {: pre}

11.  Vérifiez que le montage du volume a abouti.

     ```
     kubectl describe deployment <deployment_name>
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

{: #nonroot}
{: #enabling_root_permission}

**Droits NFS** : vous cherchez de la documentation sur l'activation de droits non root pour NFS ? Voir [Ajout d'un accès d'utilisateur non root au stockage de fichiers NFS](cs_troubleshoot_storage.html#nonroot).

<br />




## Installation du plug-in {{site.data.keyword.Bluemix_notm}} Block Storage dans votre cluster
{: #install_block}

Installez le plug-in {{site.data.keyword.Bluemix_notm}} Block Storage avec une charte Helm pour configurer des classes de stockage prédéfinies pour le stockage par blocs. Ces classes de stockage vous permettent de créer une réservation de volume persistant pour mettre à disposition du stockage par blocs pour vos applications.
{: shortdesc}

Avant de commencer, [ciblez avec votre interface de ligne de commande](cs_cli_install.html#cs_cli_configure) le cluster dans lequel vous souhaitez installer le plug-in {{site.data.keyword.Bluemix_notm}} Block Storage.

1. Installez [Helm](cs_integrations.html#helm) sur le cluster dans lequel vous souhaitez utiliser le plug-in {{site.data.keyword.Bluemix_notm}} Block Storage.
2. Mettez à jour le référentiel helm repo pour extraire la dernière version de toutes les chartes Helm dans ce référentiel.
   ```
   helm repo update
   ```
   {: pre}

3. Installez le plug-in {{site.data.keyword.Bluemix_notm}} Block Storage. Lorsque vous installez ce plug-in, des classes de stockage par blocs prédéfinies sont ajoutées dans votre cluster.
   ```
   helm install ibm/ibmcloud-block-storage-plugin
   ```
   {: pre}

   Exemple de sortie :
   ```
   NAME:   bald-olm
   LAST DEPLOYED: Wed Apr 18 10:02:55 2018
   NAMESPACE: default
   STATUS: DEPLOYED

   RESOURCES:
   ==> v1beta1/DaemonSet
   NAME                           DESIRED  CURRENT  READY  UP-TO-DATE  AVAILABLE  NODE SELECTOR  AGE
   ibmcloud-block-storage-driver  0        0        0      0           0          <none>         0s

   ==> v1beta1/Deployment
   NAME                           DESIRED  CURRENT  UP-TO-DATE  AVAILABLE  AGE
   ibmcloud-block-storage-plugin  1        0        0           0          0s

   ==> v1/StorageClass
   NAME                      PROVISIONER        AGE
   ibmc-block-bronze         ibm.io/ibmc-block  0s
   ibmc-block-custom         ibm.io/ibmc-block  0s
   ibmc-block-gold           ibm.io/ibmc-block  0s
   ibmc-block-retain-bronze  ibm.io/ibmc-block  0s
   ibmc-block-retain-custom  ibm.io/ibmc-block  0s
   ibmc-block-retain-gold    ibm.io/ibmc-block  0s
   ibmc-block-retain-silver  ibm.io/ibmc-block  0s
   ibmc-block-silver         ibm.io/ibmc-block  0s

   ==> v1/ServiceAccount
   NAME                           SECRETS  AGE
   ibmcloud-block-storage-plugin  1        0s

   ==> v1beta1/ClusterRole
   NAME                           AGE
   ibmcloud-block-storage-plugin  0s

   ==> v1beta1/ClusterRoleBinding
   NAME                           AGE
   ibmcloud-block-storage-plugin  0s

   NOTES:
   Thank you for installing: ibmcloud-block-storage-plugin.   Your release is named: bald-olm
   ```
   {: screen}

4. Vérifiez que l'installation a abouti.
   ```
   kubectl get pod -n kube-system | grep ibmcloud-block-storage-plugin
   ```
   {: pre}

   Exemple de sortie :
   ```
   ibmcloud-block-storage-plugin-58c5f9dc86-js6fd                    1/1       Running   0          4m
   ```
   {: screen}

5. Vérifiez que les classes de stockage pour le stockage par blocs ont été ajoutées dans votre cluster.
   ```
   kubectl get storageclasses | grep block
   ```
   {: pre}

   Exemple de sortie :
   ```
   ibmc-block-bronze            ibm.io/ibmc-block
   ibmc-block-custom            ibm.io/ibmc-block
   ibmc-block-gold              ibm.io/ibmc-block
   ibmc-block-retain-bronze     ibm.io/ibmc-block
   ibmc-block-retain-custom     ibm.io/ibmc-block
   ibmc-block-retain-gold       ibm.io/ibmc-block
   ibmc-block-retain-silver     ibm.io/ibmc-block
   ibmc-block-silver            ibm.io/ibmc-block
   ```
   {: screen}

6. Répétez ces étapes pour chaque cluster sur lequel vous souhaitez fournir du stockage par blocs.

Vous pouvez maintenant passer à la [création d'une réservation de volume persistant (PVC)](#create) pour mettre à disposition du stockage par blocs pour votre application.

<br />


### Mise à jour du plug-in {{site.data.keyword.Bluemix_notm}} Block Storage
Vous pouvez mettre à niveau le plug-in {{site.data.keyword.Bluemix_notm}} Block Storage existant à la version la plus récente.
{: shortdesc}

Avant de commencer, [ciblez votre interface de ligne de commande](cs_cli_install.html#cs_cli_configure) sur le cluster.

1. Recherchez le nom de la charte Helm du stockage par blocs que vous avez installée dans votre cluster.
   ```
   helm ls | grep ibmcloud-block-storage-plugin
   ```
   {: pre}

   Exemple de sortie :
   ```
   myhelmchart 	1       	Mon Sep 18 15:31:40 2017	DEPLOYED	ibmcloud-block-storage-plugin-0.1.0	default
   ```
   {: screen}

2. Mettez à niveau le plug-in {{site.data.keyword.Bluemix_notm}} Block Storage à la version la plus récente.
   ```
   helm upgrade --force --recreate-pods <helm_chart_name>  ibm/ibmcloud-block-storage-plugin
   ```
   {: pre}

<br />


### Retrait du plug-in {{site.data.keyword.Bluemix_notm}} Block Storage
Si vous ne souhaitez pas mettre à disposition et utiliser {{site.data.keyword.Bluemix_notm}} Block Storage pour votre cluster, vous pouvez désinstaller la charte Helm.
{: shortdesc}

**Remarque :** le retrait du plug-in ne retire pas les réservations de volume persistant (PVC), les volumes persistants (PV) ou les données. Lorsque vous retirez le plug-in, tous les pods associés et les ensembles de démons sont retirés de votre cluster. Vous ne pouvez pas fournir de nouveau stockage par blocs pour votre cluster ou utiliser des réservations de volume persistant et des volumes persistant de stockage par blocs existants une fois le plug-in retiré.

Avant de commencer, [ciblez avec votre interface de ligne de commande (CLI)](cs_cli_install.html#cs_cli_configure) le cluster et vérifiez que vous n'avez plus de réservation de volume persistant ou de volume persistant dans votre cluster qui utilise du stockage par blocs.

1. Recherchez le nom de la charte Helm du stockage par blocs que vous avez installée dans votre cluster.
   ```
   helm ls | grep ibmcloud-block-storage-plugin
   ```
   {: pre}

   Exemple de sortie :
   ```
   myhelmchart 	1       	Mon Sep 18 15:31:40 2017	DEPLOYED	ibmcloud-block-storage-plugin-0.1.0	default
   ```
   {: screen}

2. Supprimez le plug-in {{site.data.keyword.Bluemix_notm}} Block Storage.
   ```
   helm delete <helm_chart_name>
   ```
   {: pre}

3. Vérifiez que les pods de stockage par blocs sont retirés.
   ```
   kubectl get pod -n kube-system | grep ibmcloud-block-storage-plugin
   ```
   {: pre}
   Le retrait des pods aboutit lorsqu'aucun pod n'est affiché dans la sortie de votre interface de ligne de commande.

4. Vérifiez que les classes de stockage du stockage par blocs sont retirées.
   ```
   kubectl get storageclasses | grep block
   ```
   {: pre}
   Le retrait des classes de stockage aboutit lorsqu'aucune classe de stockage n'est affichée dans la sortie de votre interface de ligne de commande.

<br />



## Configuration des solutions de sauvegarde et de restauration pour les partages de fichiers NFS et le stockage par blocs
{: #backup_restore}

Les partages de fichiers et le stockage par blocs sont mis à disposition au même emplacement que votre cluster. Le stockage réside sur des serveurs en cluster par {{site.data.keyword.IBM_notm}} pour assurer la disponibilité en cas de panne de serveur. Cependant, les partages de fichiers et le stockage par blocs ne sont pas sauvegardés automatiquement et risquent d'être inaccessibles en cas de défaillance de l'emplacement global. Pour éviter que vos données soient perdues ou endommagées, vous pouvez configurer des sauvegardes régulières que vous pourrez utiliser pour récupérer vos données si nécessaire.
{: shortdesc}

Passez en revue les options de sauvegarde et restauration suivantes pour vos partages de fichiers NFS et votre stockage par blocs :

<dl>
  <dt>Configurer la prise d'instantanés régulière</dt>
  <dd><p>Vous pouvez configurer la [prise d'instantanés régulière](/docs/infrastructure/FileStorage/snapshots.html) de votre partage de fichiers NFS ou de votre stockage par blocs. Un instantané est une image en lecture seule qui capture l'état de l'instance à un moment donné. Les instantanés sont stockés dans le même partage de fichiers ou le même stockage par blocs au même emplacement. Vous pouvez restaurer des données à partir d'un instantané si l'utilisateur supprime accidentellement des données importantes du volume.</p>
  <p>Pour plus d'informations, voir :<ul><li>[Capture régulière d'instantanés NFS](/docs/infrastructure/FileStorage/snapshots.html)</li><li>[Captures régulière d'instantanés de blocs](/docs/infrastructure/BlockStorage/snapshots.html#snapshots)</li></ul></p></dd>
  <dt>Répliquer les instantanés à un autre emplacement</dt>
 <dd><p>Pour protéger vos données en cas de défaillance d'emplacement, vous pouvez [répliquer des instantanés](/docs/infrastructure/FileStorage/replication.html#working-with-replication) sur une instance de partage de fichiers NFS ou de stockage par blocs configurée à un autre emplacement. Les données peuvent être répliquées du stockage principal uniquement vers le stockage de sauvegarde. Vous ne pouvez pas monter une instance de partage de fichiers NFS ou de stockage par blocs répliquée sur un cluster. En cas de défaillance de votre stockage principal, vous pouvez manuellement définir votre stockage de sauvegarde répliqué comme stockage principal. Vous pouvez ensuite le monter sur votre cluster. Une fois votre stockage principal restauré, vous pouvez récupérer les données dans le stockage de sauvegarde.</p>
 <p>Pour plus d'informations, voir :<ul><li>[Réplication d'instantanés NFS](/docs/infrastructure/FileStorage/replication.html#working-with-replication)</li><li>[Réplication d'instantanés de blocs](/docs/infrastructure/BlockStorage/replication.html#working-with-replication)</li></ul></p></dd>
 <dt>Dupliquer le stockage</dt>
 <dd><p>Vous pouvez dupliquer votre instance de partage de fichiers NFS ou de stockage par blocs au même emplacement que l'instance de stockage d'origine. Un doublon contient les même données que l'instance de stockage d'origine au moment où vous créez le doublon. Contrairement aux répliques, le doublon s'utilise comme une instance de stockage totalement indépendante de l'original. Pour effectuer la duplication, configurez d'abord des instantanés pour le volume.</p>
 <p>Pour plus d'informations, voir :<ul><li>[Duplication d'instantanés NFS](/docs/infrastructure/FileStorage/how-to-create-duplicate-volume.html#creating-a-duplicate-file-storage)</li><li>[Dupliction d'instantanés de blocs](/docs/infrastructure/BlockStorage/how-to-create-duplicate-volume.html#creating-a-duplicate-block-volume)</li></ul></p></dd>
  <dt>Sauvegarder les données dans Object Storage</dt>
  <dd><p>Vous pouvez utiliser l'[**image ibm-backup-restore**](/docs/services/RegistryImages/ibm-backup-restore/index.html#ibmbackup_restore_starter) pour constituer un pod de sauvegarde et de restauration dans votre cluster. Ce pod contient un script pour exécuter une sauvegarde unique ou régulière d'une réservation de volume persistant (PVC) dans votre cluster. Les données sont stockées dans votre instance {{site.data.keyword.objectstoragefull}} que vous configurez à un emplacement.</p>
  <p>Pour rendre vos données hautement disponibles et protéger votre application en cas de défaillance d'emplacement, configurez une deuxième instance {{site.data.keyword.objectstoragefull}} et répliquez les données entre les différents emplacements. Si vous devez restaurer des données à partir de votre instance {{site.data.keyword.objectstoragefull}}, utilisez le script de restauration fourni avec l'image.</p></dd>
<dt>Copier les données depuis et vers des pods et des conteneurs</dt>
<dd><p>Vous pouvez utiliser la [commande![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#cp) `kubectl cp` pour copier des fichiers et des répertoires depuis et vers des pods ou des conteneurs spécifiques dans votre cluster.</p>
<p>Avant de commencer, [ciblez avec votre interface de ligne de commande Kubernetes](cs_cli_install.html#cs_cli_configure) le cluster que vous voulez utiliser. Si vous n'indiquez pas de conteneur avec <code>-c</code>, la commande utilise le premier conteneur disponible dans le pod.</p>
<p>Vous pouvez utiliser la commande de plusieurs manières :</p>
<ul>
<li>Copier les données de votre machine locale vers un pod dans votre cluster : <code>kubectl cp <var>&lt;local_filepath&gt;/&lt;filename&gt;</var> <var>&lt;namespace&gt;/&lt;pod&gt;:&lt;pod_filepath&gt;</var></code></li>
<li>Copier les données d'un pod de votre cluster vers votre machine locale : <code>kubectl cp <var>&lt;namespace&gt;/&lt;pod&gt;:&lt;pod_filepath&gt;/&lt;filename&gt;</var> <var>&lt;local_filepath&gt;/&lt;filename&gt;</var></code></li>
<li>Copier les données d'un pod de votre cluster vers un conteneur spécifique dans un autre pod : <code>kubectl cp <var>&lt;namespace&gt;/&lt;pod&gt;:&lt;pod_filepath&gt;</var> <var>&lt;namespace&gt;/&lt;other_pod&gt;:&lt;pod_filepath&gt;</var> -c <var>&lt;container></var></code></li>
</ul>
</dd>
  </dl>

