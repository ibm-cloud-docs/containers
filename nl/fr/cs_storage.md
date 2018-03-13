---

copyright:
  years: 2014, 2018
lastupdated: "2018-02-07"

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
Vous pouvez rendre des données persistantes en cas d'échec d'un composant dans votre cluster et pour partager des données entre les instances d'application.

## Planification de stockage hautement disponible
{: #planning}

Dans {{site.data.keyword.containerlong_notm}}, vous disposez de plusieurs options pour stocker des données d'application et partager des données entre les pods dan votre cluster. Toutefois, les options de stockage n'offrent pas toutes le même niveau de persistance et de disponibilité au cas où un composant de votre cluster ou un site complet connaisse une défaillance.
{: shortdesc}

### Options de stockage de données non persistant
{: #non_persistent}

Vous pouvez utiliser des options de stockage non persistant si vos données n'ont pas besoin d'être stockées de manière permanente, de sorte à pouvoir les récupérer en cas de défaillance d'un composant de votre cluster, ou si elles n'ont pas besoin d'être partagées entre les instances d'application. Ces options peuvent également être utilisées afin d'effectuer un test d'unité sur vos composants d'application ou d'essayer de nouvelles fonctions.
{: shortdesc}

L'illustration suivante présente les options de stockage non persistant disponibles dans {{site.data.keyword.containerlong_notm}}. Ces options sont disponibles pour les clusters de l'édition gratuite et standard.
<p>
<img src="images/cs_storage_nonpersistent.png" alt="Options de stockage non persistant de données" width="450" style="width: 450px; border-style: none"/></p>

<table summary="Le tableau présente les options de stockage non persistant. La lecture des lignes s'effectue de gauche à droite, le numéro de l'option figurant dans la première colonne, son titre dans la seconde et une description dans la troisième." style="width: 100%">
<colgroup>
       <col span="1" style="width: 5%;"/>
       <col span="1" style="width: 20%;"/>
       <col span="1" style="width: 75%;"/>
    </colgroup>
  <thead>
  <th>#</th>
  <th>Option</th>
  <th>Description</th>
  </thead>
  <tbody>
    <tr>
      <td>1</td>
      <td>Dans le conteneur ou le pod</td>
      <td>De par leur conception, les conteneurs ont une durée de vie brève et sont susceptibles à des défaillances inattendues. Toutefois, vous pouvez consigner des données sur le système de fichiers local afin de stocker des données tout au long du cycle de vie du conteneur. Les données hébergées au sein d'un conteneur ne peuvent pas être partagées avec d'autres conteneurs ou pods et sont perdues en cas de panne ou de suppression du conteneur. Pour plus d'informations, voir [Stockage de données dans un conteneur](https://docs.docker.com/storage/).</td>
    </tr>
  <tr>
    <td>2</td>
    <td>Sur le noeud worker</td>
    <td>Chaque noeud worker est configuré avec un stockage principal et un stockage secondaire déterminés par le type de machine que vous sélectionnez pour ce noeud. Le stockage principal est utilisé pour stocker les données du système d'exploitation et n'est pas accessible à l'utilisateur. Le stockage secondaire est utilisé pour stocker des données dans <code>/var/lib/docker</code>, à savoir, le répertoire dans lequel toutes les données de conteneur sont consignées. <br/><br/>Pour accéder au stockage secondaire de votre noeud of worker, vous pouvez créer un volume <code>/emptyDir</code>. Ce volume vide est affecté à un pod dans votre cluster, de sorte à ce que les conteneurs du pod puissent accéder en lecture et écriture à ce volume. Comme le volume est affecté à un pod spécifique, les données ne peuvent pas être partagées avec d'autres pods dans un jeu de répliques.<br/><p>Un volume <code>/emptyDir</code> et ses données sont supprimés quand : <ul><li>Le pod auquel il est affecté est supprimé définitivement du noeud worker.</li><li>Le pod auquel il est affecté est planifié pour opérer sur un autre noeud worker.</li><li>Le noeud worker est rechargé ou mis à jour.</li><li>Le noeud worker est supprimé.</li><li>Le cluster est supprimé.</li><li>Le compte {{site.data.keyword.Bluemix_notm}} passe à un état 'suspendu'. </li></ul></p><p><strong>Remarque :</strong> si le conteneur à l'intérieur du pod tombe en panne, les données du volume restent disponibles sur le noeud worker.</p><p>Pour plus d'informations, voir [Volumes Kubernetes ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/concepts/storage/volumes/).</p></td>
    </tr>
    </tbody>
    </table>

### Options de stockage de données persistant pour haute disponibilité
{: persistent}

La principale difficulté lorsque vous créez des applications avec état de haute disponibilité consiste à rendre les données persistantes entre instances d'application et emplacements multiples, et de les maintenir synchronisées en tout temps. Pour les données à haute disponibilité, vous voudrez vous assurer de disposer d'une base de données maître dispersée entre plusieurs centres de données, ou même plusieurs régions, et que les données dans cette base de données maître sont répliquées en permanence. Toutes les instances dans votre cluster doivent pouvoir lire et écrire dans cette base de données maître. En cas de défaillance d'une instance de la base de données maître, les autres instances doivent assumer la charge de travail afin que vos applications ne connaissent pas de temps d'indisponibilité.
{: shortdesc}

L'illustration suivante présente les options disponibles dans {{site.data.keyword.containerlong_notm}} pour assurer une haute disponibilité de vos données dans un cluster standard. L'option pertinente dépend des facteurs suivants :
  * **Le type de votre application :** vous pourriez, par exemple, utiliser une application nécessitant le stockage des données dans un fichier et non pas dans une base de données.
  * **Les exigences légales quant au stockage et au routage des données :** vous pourriez, par exemple, être obligé de stocker et de router vos données aux Etats-Unis, sans pouvoir utiliser un service situé en Europe.
  * **Options de sauvegarde et de restauration :** toutes les options de stockage disposent de capacités de sauvegarde et de restauration des données. Vérifiez que les options disponibles répondent aux exigences de votre plan de reprise après incident, telles que la fréquence des sauvegardes ou la possibilité de stocker vos données hors de votre centre de données principal.
  * **Réplication globale :** pour haute disponibilité, vous souhaiterez éventuellement configurer plusieurs instances de stockage, lesquelles seront distribuées et répliquées entre vos centres de données à travers le monde.

<br/>
<img src="images/cs_storage_ha.png" alt="Options de haute disponibilité pour stockage persistant"/>

<table summary="Ce tableau présente les options de stockage persistant. La lecture des lignes s'effectue de gauche à droite, le numéro de l'option figurant dans la première colonne, son titre dans la seconde et une description dans la troisième.">
  <thead>
  <th>#</th>
  <th>Option</th>
  <th>Description</th>
  </thead>
  <tbody>
  <tr>
  <td width="5%">1</td>
  <td width="20%">Stockage de fichiers NFS</td>
  <td width="75%">Cette option vous permet de rendre persistantes les données d'application et de conteneur via des volumes Kubernetes persistants. Les volumes sont hébergés sur [stockage de fichiers Endurance and Performance basé NFS![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/cloud/file-storage/details) qui peut être utilisé pour les applications qui stockent les données sur fichier, et non pas dans une base de données. Le stockage de fichiers est chiffré sous REST et mis en cluster par IBM pour permettre une haute disponibilité.<p>{{site.data.keyword.containershort_notm}} fournit des classes de stockage prédéfinies qui définissent les plages de taille de stockage, les opérations IOPS, la règle de suppression et les autorisations d'accès en écriture au volume. Pour lancer une demande de stockage de fichier basée NFS, vous devez créer une [réservation de volume persistant](cs_storage.html#create). Après que vous ayez soumis une demande de volume persistant, {{site.data.keyword.containershort_notm}} provisionne dynamiquement un volume persistant hébergé sur le stockage de fichiers NFS. [Vous pouvez monter la réservation de volume persistant](cs_storage.html#app_volume_mount) en tant que volume sur votre déploiement pour permettre aux conteneurs d'accéder en lecture et écriture au volume. </p><p>Les volumes persistants sont provisionnés dans le centre de données où est situé le noeud worker. Vous pouvez partager les données avec la même réplique et/ou d'autres déploiements dans le même cluster. Vous ne pouvez pas partager les données lorsqu'elles sont situées dans des centres de données ou des régions différents. </p><p>Par défaut, le stockage NFS n'est pas sauvegardé automatiquement. Vous pouvez configurer une sauvegarde périodique pour votre cluster en exploitant les mécanismes de sauvegarde et restauration fournis. Lorsqu'un conteneur tombe en panne ou qu'un pod est retiré d'un noeud worker, les données ne sont pas supprimées et sont toujours accessibles par d'autres déploiements qui montent le volume. </p><p><strong>Remarque :</strong> le stockage de partages de fichiers NFS persistants est facturé sur une base mensuelle. Si vous provisionnez un stockage persistant pour votre cluster et le retirez immédiatement, vous devrez néanmoins payer la redevance mensuelle pour le stockage persistant, même si vous ne l'avez utilisé que très brièvement.</p></td>
  </tr>
  <tr>
    <td>2</td>
    <td>Service de base de données Cloud</td>
    <td>Cette option vous permet de rendre persistantes les données via un service de base de données cloud {{site.data.keyword.Bluemix_notm}}, tel qu'[IBM Cloudant NoSQL DB](/docs/services/Cloudant/getting-started.html#getting-started-with-cloudant). Les données stockées via cette option sont accessibles entre les clusters, les emplacements et les régions. <p> Vous pouvez vous contenter de configurer une seule instance base de données à laquelle accéderont toutes vos applications ou bien [configurer plusieurs instances entre les centres de données, et une réplication](/docs/services/Cloudant/guides/active-active.html#configuring-cloudant-nosql-db-for-cross-region-disaster-recovery) entre les instances pour une plus haute disponibilité. Dans la base de données IBM Cloudant NoSQL, les données ne sont pas sauvegardées automatiquement. Vous pouvez utiliser les [mécanismes de sauvegarde et de restauration](/docs/services/Cloudant/guides/backup-cookbook.html#cloudant-nosql-db-backup-and-recovery) fournis afin de protéger vos données en cas de panne du site.</p> <p> Pour utiliser un service dans votre cluster, vous devez [lier le {{site.data.keyword.Bluemix_notm}} service ](cs_integrations.html#adding_app) à un espace de nom dans votre cluster. Lorsque vous liez le service au cluster, une valeur confidentielle Kubernetes est créée. Celle-ci héberge des informations confidentielles relatives au service, comme son URL, votre nom d'utilisateur et votre mot de passe. Vous pouvez monter le volume en tant que volume secret sur votre pod et accéder au service en utilisant les données d'identification dans la valeur confidentielle. En montant le volume sur sur d'autres pods, vous pouvez également partager les données entre les pods. Lorsqu'un conteneur tombe en panne ou qu'un pod est retiré d'un noeud worker, les données ne sont pas perdues et restent accessibles aux autres pods qui montent le volume secret. <p>La plupart des services de base de données {{site.data.keyword.Bluemix_notm}} proposent un espace disque gratuit pour une petite quantité de données, de sorte que vous pouvez tester ses caractéristiques.</p></td>
  </tr>
  <tr>
    <td>3</td>
    <td>Base de données sur site</td>
    <td>Si vos données doivent être stockées sur site en raison de contraintes légales, vous pouvez [mettre en place une connexion VPN (réseau privé virtuel)](cs_vpn.html#vpn) vers votre base de données locale et utiliser les mécanismes de stockage, de sauvegarde et de réplications existants face à votre centre de données.</td>
  </tr>
  </tbody>
  </table>

{: caption="Table. Options de stockage persistant pour les déploiements dans des clusters Kubernetes" caption-side="top"}

<br />



## Utilisation de partages de fichiers NFS existants dans des clusters
{: #existing}

Si vous disposez déjà de partages de fichiers NFS existants dans votre compte d'infrastructure IBM Cloud (SoftLayer) et que vous voulez les utiliser avec Kubernetes, créez alors des volumes persistants sur votre partage de fichiers NFS existant. Un volume persistant est un élément matériel réel qui fait office de ressource de cluster Kubernetes et peut être consommé par l'utilisateur du cluster.
{:shortdesc}

Kubernetes fait une distinction entre les volumes persistants qui représentent le matériel effectif et les réservations de volume persistant qui sont des demandes de stockage déclenchées habituellement par l'utilisateur du cluster. Le diagramme suivant illustre la relation entre des volumes persistants et des réservations de volume persistant persistent volume.

![Créer des volumes persistants et des réservations de volumes persistants](images/cs_cluster_pv_pvc.png)

 Comme illustré dans le diagramme, pour permettre l'utilisation de partage de fichiers NLS existants avec Kubernetes, vous devez créer des volumes persistants d'une certaine taille et avec un mode d'accès déterminé,
qui soient conformes à la spécification de volume persistant. Si le volume persistant et la réservation de volume persistant correspondent, ils sont liés l'un à l'autre. Seules les réservations de volume persistant liées peuvent être utilisées par l'utilisateur du cluster pour monter le
volume sur un déploiement. Cette procédure est dénommée provisionnement statique de stockage persistant.

Avant de commencer, vérifiez que vous disposez d'un partage de fichiers NFS existant que vous pouvez utiliser pour créer votre volume persistant.

**Remarque :** le provisionnement statique de stockage persistant ne s'applique qu'aux partages de fichiers NFS existants. Si vous ne disposez pas de partages de fichiers
NFS existants, les utilisateurs du cluster peuvent utiliser la procédure de [provisionnement dynamique](cs_storage.html#create) pour ajouter des volumes persistants.

Pour créer un volume persistant et une réservation correspondante, procédez comme suit.

1.  Dans votre compte d'infrastructure IBM Cloud (SoftLayer), recherchez l'ID et le chemin du partage NFS où vous désirez créer votre objet de volume persistant. Par ailleurs, autorisez le stockage de fichiers sur les sous-réseaux du cluster. Cette autorisation permet à votre cluster d'accéder au stockage.
    1.  Connectez-vous à votre compte d'infrastructure IBM Cloud (SoftLayer).
    2.  Cliquez sur **Stockage**.
    3.  Cliquez sur **Stockage de fichiers** et, dans le menu **Actions**, sélectionnez **Autoriser l'hôte**.
    4.  Cliquez sur **Sous-réseaux**. Après l'autorisation, chaque noeud worker sur le sous-réseau a accès au stockage de fichiers.
    5.  Sélectionnez dans le menu le sous-réseau du VLAN public de votre cluster et cliquez sur **Soumettre**. Si vous devez identifier le sous-réseau, exécutez la commande `bx cs cluster-get <cluster_name> --showResources`.
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
       path: "/IBM01SEV8491247_0908"
    ```
    {: codeblock}

    <table>
    <caption>Table. Description des composants du fichier YAML</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code>name</code></td>
    <td>Entrez le nom de l'objet de volume persistant que vous désirez créer.</td>
    </tr>
    <tr>
    <td><code>stockage</code></td>
    <td>Entrez la taille de stockage du partage de fichiers NFS existant. Cette taille doit être indiquée en gigaoctets, par exemple 20Gi (20 Go) ou 1000Gi (1 To), et correspondre à celle du partage de fichiers existant.</td>
    </tr>
    <tr>
    <td><code>accessMode</code></td>
    <td>Les modes d'accès définissent la manière dont une réservation de volume persistant peut être montée sur un noeud worker.<ul><li>ReadWriteOnce (RWO): le volume persistant ne peut être monté sur des déploiements que dans un seul noeud worker. Les conteneurs dans des déploiements montés sur ce volume persistant peuvent accéder en lecture et en écriture au volume.</li><li>ReadOnlyMany (ROX) : le volume persistant peut être monté sur des déploiements hébergés sur plusieurs noeuds worker. Les déploiements montés sur ce volume persistant ne peuvent accéder au volume qu'en lecture.</li><li>ReadWriteMany (RWX) : ce volume persistant peut être monté sur des déploiements hébergés sur plusieurs noeuds worker. Les déploiements montés sur ce volume persistant peuvent accéder en lecture et en écriture au volume.</li></ul></td>
    </tr>
    <tr>
    <td><code>server</code></td>
    <td>Entrez l'ID du serveur du partage de fichiers NFS.</td>
    </tr>
    <tr>
    <td><code>path</code></td>
    <td>Entrez le chemin du partage de fichiers NFS où vous désirez créer l'objet de volume persistant.</td>
    </tr>
    </tbody></table>

3.  Créez le volume persistent dans votre cluster.

    ```
    kubectl apply -f <yaml_path>
    ```
    {: pre}

    Exemple

    ```
    kubectl apply -f deploy/kube-config/pv.yaml
    ```
    {: pre}

4.  Vérifiez que le volume persistant a été créé.

    ```
    kubectl get pv
    ```
    {: pre}

5.  Créez un autre fichier de configuration pour créer votre réservation de volume persistant. Pour que la réservation de volume persistant corresponde à l'objet de volume persistant créé auparavant, vous devez sélectionner la même valeur pour `storage` et pour `accessMode`. La zone `storage-class` doit être vide. Si l'une de ces zones ne correspond pas au volume persistant, un nouveau volume persistant est créé automatiquement à la place.

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

6.  Créez votre réservation de volume persistant.

    ```
    kubectl apply -f deploy/kube-config/mypvc.yaml
    ```
    {: pre}

7.  Vérifiez que votre réservation de volume persistant a été créée et liée à l'objet de volume persistant. Ce processus peut prendre quelques minutes.

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


Vous avez créé correctement un objet de stockage persistant et l'avez lié à une réclamation de volume
persistant. Les utilisateurs du cluster peuvent à présent [monter la réservation de volume persistant](#app_volume_mount) sur leurs déploiements et lancer une lecture et une écriture sur l'objet de volume persistant.

<br />


## Création d'un stockage persistant pour les applications
{: #create}

Créez une réservation de volume persistant (pvc) pour mettre à disposition un stockage de fichiers NFS pour votre cluster. Montez ensuite cette réservation sur un déploiement afin de garantir la disponibilité des données même en cas de panne ou d'arrêt des pods.
{:shortdesc}

Le stockage de fichiers NFS où est sauvegardé le volume persistant est mis en cluster par IBM pour une haute disponibilité de vos données. Les classes de stockage décrivent les types de stockage disponibles et défissent des caractéristiques telles que la politique de rétention des données, leur taille en gigaoctets et le nombre d'IOPS lorsque vous créez votre volume persistant.

**Remarque **: si vous utilisez un pare-feu, [autorisez l'accès sortant](cs_firewall.html#pvc) pour les plages IP de l'infrastructure IBM Cloud (SoftLayer) des emplacements (centres de données) où sont situés vos clusters, de manière à pouvoir créer des réservations de volumes persistants.

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

2.  Déterminez si vous souhaitez sauvegarder vos données et le partage de fichiers NFS après avoir supprimé la réservation de volume persistant (dénommée règle de réservation). Pour conserver vos données, choisissez une classe de stockage `retain`. Si vous souhaitez que les données et votre partage de fichiers soient supprimés en même temps que la réservation pvc, choisissez une classe de stockage sans `retain`.

3.  Extrayez les informations détaillées d'une classe de stockage. Examinez le nombre d'IOPS par gigaoctet et sa plage de dimension dans la zone **paramters** de votre sortie CLI. 

    <ul>
      <li>Les classes de stockage bronze, argent ou or utilisent un stockage [Endurance![External link icon](../icons/launch-glyph.svg "External link icon")](https://knowledgelayer.softlayer.com/topic/endurance-storage) qui définit le nombre d'IOPS par Go pour chaque classe. Vous pouvez toutefois déterminer le nombre total d'IOPS en sélectionnant une taille sur la plage disponible. Par exemple, si vous sélectionnez une taille de partage de fichiers de 1000Gi dans la classe de stockage argent de 4 IOPS per GB, votre volume dispose d'un total de 4000 IOPS. Plus votre volume persistant dispose d'IOPS, et plus vite peut-il traiter les opérations d'entrée et de sortie. <p>**Exemple de commande dérivant la classe de stockage**:</p>

       <pre class="pre">kubectl describe storageclasses ibmc-file-silver</pre>

       La zone **parameters** indique le nombre d'IOPS per Go associé à la classe de stockage et les tailles disponibles (en Go).
       <pre class="pre">Parameters:	iopsPerGB=4,sizeRange=20Gi,40Gi,80Gi,100Gi,250Gi,500Gi,1000Gi,2000Gi,4000Gi,8000Gi,12000Gi</pre>
       
       </li>
      <li>En utilisant des classes de stockage personnalisées, vous obtenez un [stockage Performance ![External link icon](../icons/launch-glyph.svg "External link icon")](https://knowledgelayer.softlayer.com/topic/performance-storage) vous offrant un contrôle plus étroit quant à la combinaison du nombre IOPS et de sa taille. <p>**Exemple de commande décrivant une classe de stockage personnalisée**:</p>

       <pre class="pre">kubectl describe storageclasses ibmc-file-retain-custom</pre>

       La zone **parameters** indique le nombre d'IOPS associé à la classe de stockage et les tailles disponibles en gigaoctets. Par exemple, 40Gi pvc peut sélectionner un nombre d'IOPS multiple de 100 compris entre 100 et 2000 IOPS.

       ```
       Parameters:	Note=IOPS value must be a multiple of 100,reclaimPolicy=Retain,sizeIOPSRange=20Gi:[100-1000],40Gi:[100-2000],80Gi:[100-4000],100Gi:[100-6000],1000Gi[100-6000],2000Gi:[200-6000],4000Gi:[300-6000],8000Gi:[500-6000],12000Gi:[1000-6000]
       ```
       {: screen}
       </li></ul>
4. Créez un fichier de configuration pour définir votre réservation de volume persistant et enregistrer la configuration dans un fichier `.yaml`.

    -  **Exemples pour les classes de stockage bronze, argent et or** :
       

       ```
       apiVersion: v1
       kind: PersistentVolumeClaim
       metadata:
        name: mypvc
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

    -  **Exemple pour classes de stockage personnalisées**:
       

       ```
       apiVersion: v1
       kind: PersistentVolumeClaim
       metadata:
         name: mypvc
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
          <li>ibmc-file-custom / ibmc-file-retain-custom : Plusieurs valeurs d'IOPS disponibles.</li>
          <p>Si vous ne spécifiez pas de classe de stockage, le volume persistant est créé avec la classe de stockage bronze.</p></td>
        </tr>
        
        <tr>
        <td><code>spec/accessModes</code>
    <code>resources/requests/storage</code></td>
        <td>Si vous choisissez une taille autre que celle qui est répertoriée, cette taille est arrondie vers le haut. Si vous choisissez une taille supérieure à la taille maximale, cette taille est arrondie au-dessous.</td>
        </tr>
        <tr>
        <td><code>spec/accessModes</code>
    <code>resources/requests/iops</code></td>
        <td>Cette option ne concerne que les classe de stockage client (`ibmc-file-custom / ibmc-file-retain-custom`). Indiquez le nombre total d'IOPS pour le stockage. Pour examiner toutes les options, exécutez la commande `kubectl describe storageclasses ibmc-file-custom`. Si vous choisissez une valeur IOPS autre que celle répertoriée, la valeur IOPS est arrondie à la valeur supérieure.</td>
        </tr>
        </tbody></table>

5.  Créez la réservation de volume persistant.

    ```
    kubectl apply -f <local_file_path>
    ```
    {: pre}

6.  Vérifiez que votre réservation de volume persistant a été créée et liée au volume persistant. Ce processus peut prendre quelques minutes.

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

6.  {: #app_volume_mount}Pour monter la réservation de volume persistant sur votre déploiement, créez un fichier de configuration. Enregistrez la configuration sous forme de fichier `.yaml`.

    ```
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
     name: <deployment_name>
    replicas: 1
    template:
     metadata:
       labels:
         app: <app_name>
    spec:
     containers:
     - image: <image_name>
       name: <container_name>
       volumeMounts:
       - mountPath: /<file_path>
         name: <volume_name>
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
    <td><code>metadata/name</code></td>
    <td>Nom du déploiement.</td>
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
    <td>Nom du volume où monter sur votre pod. </td>
    </tr>
    <tr>
    <td><code>volumes/name</code></td>
    <td>Nom du volume où monter sur votre pod. Généralement, ce nom est identique à <code>volumeMounts/name</code>.</td>
    </tr>
    <tr>
    <td><code>volumes/persistentVolumeClaim/claimName</code></td>
    <td>Nom de la réservation de volume persistant que vous souhaitez utiliser pour votre volume. Lorsque vous montez le volume sur le pod, Kubernetes identifie le volume persistant lié à a réservation de volume persistant et autorise l'utilisateur à accéder à celui-ci en lecture et écriture.</td>
    </tr>
    </tbody></table>

8.  Créez le déploiement et montez la réservation de volume persistant.

    ```
    kubectl apply -f <local_yaml_path>
    ```
    {: pre}

9.  Vérifiez que le montage du volume a abouti.

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

<br />



## Ajout d'un accès d'utilisateur non root au stockage persistant
{: #nonroot}

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
reconnaître l'utilisateur root dans le conteneur, or, pour certaines applications, il s'agit du seul utilisateur au sein d'un conteneur. Cependant, certaines applications spécifient un utilisateur non root autre que `nobody` qui écrit des données sur le chemin de montage du conteneur. Certaines applications spécifient que le volume doit appartenir à l'utilisateur root. En général, les applications n'utilisent pas l'utilisation root pour des raisons de sécurité. Toutefois, si votre application exige un utilisateur racine, contactez l'[{{site.data.keyword.Bluemix_notm}} support](/docs/get-support/howtogetsupport.html#getting-customer-support) pour assistance.


1.  Créez un fichier Dockerfile sous un répertoire local. L'exemple Dockerfile suivant crée un utilisateur non root nommé `myguest`.

    ```
    FROM registry.<region>.bluemix.net/ibmliberty:latest

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


