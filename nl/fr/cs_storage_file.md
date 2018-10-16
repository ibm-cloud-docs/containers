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




# Stockage de données sur IBM File Storage pour IBM Cloud
{: #file_storage}


## Détermination de la configuration de stockage de fichiers
{: #predefined_storageclass}

{{site.data.keyword.containerlong}} fournit des classes de stockage prédéfinies pour le stockage de fichiers que vous pouvez utiliser pour mettre à disposition du stockage de fichiers avec une configuration spécifique.
{: shortdesc}

Toutes les classes de stockage indiquent le type de stockage de fichiers à mettre à disposition, y compris la taille disponible, les opérations d'entrée-sortie par seconde (IOPS), le système de fichiers, ainsi que la règle de conservation.  

**Important :** Choisissez votre configuration de stockage avec précaution pour disposer d'une capacité suffisante pour stocker vos données. Après avoir mis à disposition un type de stockage spécifique en utilisant une classe de stockage, vous ne pouvez plus modifier la taille, le type, IOPS ou la règle de conservation de l'unité de stockage. Si vous avez besoin de plus de stockage ou de stockage avec une configuration différente, vous devez [créer une nouvelle instance de stockage et copier les données](cs_storage_basics.html#update_storageclass) de l'ancienne instance de stockage sur la nouvelle.

1. Répertoriez les classes de stockage disponibles dans {{site.data.keyword.containerlong}}.
    ```
    kubectl get storageclasses | grep file
    ```
    {: pre}

    Exemple de sortie :
    ```
    $ kubectl get storageclasses
    NAME                         TYPE
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

2. Examinez la configuration d'une classe de stockage.
   ```
   kubectl describe storageclass <storageclass_name>
   ```
   {: pre}

   Pour plus d'informations sur chaque classe de stockage, voir [Référence des classes de stockage](#storageclass_reference). Si vous ne trouvez pas ce que vous cherchez, envisagez de créer votre propre classe de stockage personnalisée. Pour commencer, consultez les [exemples de classes de stockage personnalisées](#custom_storageclass).
   {: tip}

3. Sélectionnez le type de stockage de fichiers que vous désirez mettre à disposition.
   - **Classes de stockage Bronze, Silver et Gold :** ces classes de stockage mettent à disposition du [stockage Endurance ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://knowledgelayer.softlayer.com/topic/endurance-storage). Le stockage Endurance vous permet de choisir la taille de stockage en gigaoctets à des niveaux d'opérations d'entrée-sortie par seconde prédéfinis.
   - **Classe de stockage personnalisée :** cette classe de stockage met à disposition du [stockage Performance ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://knowledgelayer.softlayer.com/topic/performance-storage). Avec le stockage Performance, vous disposez d'un contrôle accru sur la taille de stockage et les opérations d'entrée-sortie par seconde.

4. Choisissez la taille et la valeur des opérations d'entrée-sortie par seconde (IOPS) de votre stockage de fichiers. La taille et le nombre d'IOPS définissent le nombre total d'IOPS (opérations d'entrée-sortie par seconde) qui sert d'indicateur pour mesurer la rapidité de votre stockage. Plus votre stockage comporte d'IOPS, plus il traite rapidement les opérations de lecture/écriture.
   - **Classes de stockage Bronze, Silver et Gold :** ces classes de stockage sont fournies avec un nombre fixe d'IOPS par gigaoctet et sont mises à disposition sur des disques durs SSD. Le nombre total d'IOPS dépend de la taille de stockage que vous choisissez. Vous pouvez sélectionner tout nombre entier représentant la taille en gigaoctets dans la plage de taille autorisée, par exemple 20 Gi, 256 Gi ou 11854 Gi. Pour déterminer le nombre total d'IOPS, vous devez multiplier les IOPS par la taille sélectionnée. Par exemple, si vous sélectionnez une taille de stockage de fichiers de 1000 Gi dans la classe de stockage Silver offrant 4 IOPS par Go, votre storage dispose d'un total de 4000 IOPS.
     <table>
         <caption>Tableau des plages de tailles de classe de stockage et nombre d'opérations d'entrée-sortie par seconde (IOPS) par gigaoctet</caption>
         <thead>
         <th>Classe de stockage</th>
         <th>IOPS par gigaoctet</th>
         <th>Plage de tailles en gigaoctets</th>
         </thead>
         <tbody>
         <tr>
         <td>Bronze</td>
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
   - **Classe de stockage personnalisée :** lorsque vous choisissez cette classe de stockage, vous disposez d'un contrôle accru sur la taille et les IOPS que vous souhaitez. En ce qui concerne la taille, vous pouvez sélectionner n'importe quel nombre entier comme valeur de gigaoctets dans la plage de tailles autorisée. La taille que vous choisissez détermine la plage d'IOPS dont vous pourrez bénéficier. Vous pouvez choisir une valeur d'IOPS multiple de 100 comprise dans la plage spécifiée. Le nombre d'IOPS que vous choisissez est statique et ne s'adapte pas à la taille du stockage. Par exemple, si vous choisissez 40Gi avec 100 IOPS, le nombre total d'IOPS restera 100. </br></br> Le rapport IOPS/gigaoctets détermine le type de disque dur mis à votre disposition. Par exemple, si vous avez 500Gi à 100 IOPS, votre rapport IOPS/gigaoctet est 0,2. Un stockage avec un rapport inférieur ou égal à 0,3 est fourni sur des disques durs SATA. Si votre rapport est supérieur à 0,3, votre stockage est fourni sur des disques durs SSD.  
     <table>
         <caption>Tableau des plages de tailles de classe de stockage personnalisée et nombre d'opérations d'entrée-sortie par seconde (IOPS)</caption>
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

5. Déterminez si vous voulez conserver vos données après la suppression du cluster ou de la réservation de volume persistant (PVC).
   - Pour conserver vos données, choisissez une classe de stockage `retain`. Lorsque vous supprimez la réservation PVC, seule la PVC est supprimée. Le volume persistant (PV), l'unité de stockage physique dans votre compte d'infrastructure IBM Cloud (SoftLayer), ainsi que vous données existent toujours. Pour récupérer le stockage et l'utiliser à nouveau dans votre cluster, vous devez supprimer le volume persistant et suivre les étapes pour [utiliser du stockage de fichiers existant](#existing_file).
   - Si vous souhaitez que le volume persistant, les données et votre unité de stockage de fichiers physique soient supprimés en même temps que la réservation PVC, choisissez une classe de stockage sans `retain`. **Remarque** : si vous disposez d'un compte Dedicated, choisissez une classe de stockage sans `retain` pour éviter les volumes orphelins dans l'infrastructure IBM Cloud (SoftLayer).

6. Choisissez une facturation à l'heure ou mensuelle. Pour plus d'informations, consultez la [tarification ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://www.ibm.com/cloud/file-storage/pricing). Par défaut, toutes les unités de stockage de fichiers sont mises à disposition avec une facturation à l'heure.
   **Remarque :** si vous optez pour un type de facturation mensuel, lorsque vous supprimez le stockage persistant, vous devez quand même payer les frais mensuel, même si vous ne l'avez utilisé pendant très peu de temps.

<br />



## Ajout de stockage de fichiers à des applications
{: #add_file}

Créez une réservation de volume persistant (PVC) pour le [provisionnement dynamique](cs_storage_basics.html#dynamic_provisioning) de stockage de fichiers pour votre cluster. Le provisionnement dynamique crée automatiquement le volume persistant (PV) correspondant et commande l'unité de stockage physique dans votre compte d'infrastructure IBM Cloud (SoftLayer).
{:shortdesc}

Avant de commencer :
- Si vous disposez d'un pare-feu, [autorisez l'accès sortant](cs_firewall.html#pvc) pour les plages d'adresses IP de l'infrastructure IBM Cloud (SoftLayer) des zones dans lesquelles résident vos clusters, de manière à pouvoir créer des réservations de volume persistant (PVC).
- [Optez pour une classe de stockage prédéfinie](#predefined_storageclass) ou créez une [classe de stockage personnalisée](#custom_storageclass).

  **Astuce :** si vous disposez d'un cluster à zones multiples, la zone dans laquelle votre stockage est mis à disposition est sélectionnée en mode circulaire pour équilibrer les demandes de volume uniformément dans toutes les zones. Si vous souhaitez indiquer la zone destinée à votre stockage, créez d'abord une [classe de stockage personnalisée](#multizone_yaml). Ensuite, suivez la procédure indiquée dans cette rubrique pour mettre à disposition du stockage en utilisant votre classe de stockage personnalisée.

Pour ajouter du stockage de fichiers :

1.  Créez un fichier de configuration pour définir votre réservation de volume persistant (PVC) et sauvegardez la configuration sous forme de fichier `.yaml`.

    -  **Exemple de classes de stockage Bronze, Silver et Gold** :
       Le fichier `.yaml` suivant crée une réservation nommée `mypvc` de la classe de stockage `"ibmc-file-silver"`, facturée au mois (`"monthly"`), avec une taille de `24Gi`.

       ```
       apiVersion: v1
       kind: PersistentVolumeClaim
       metadata:
         name: mypvc
         annotations:
           volume.beta.kubernetes.io/storage-class: "ibmc-file-silver"
         labels:
           billingType: "monthly"
       spec:
         accessModes:
           - ReadWriteMany
         resources:
           requests:
             storage: 24Gi
        ```
        {: codeblock}

    -  **Exemple d'utilisation de la classe de stockage personnalisée** :
       Le fichier `.yaml` suivant crée une réservation nommée `mypvc` de la classe de stockage `ibmc-file-retain-custom`, facturée à l'heure (`"hourly"`), avec une taille en gigaoctets de `45Gi` et `"300"` IOPS.

       ```
       apiVersion: v1
       kind: PersistentVolumeClaim
       metadata:
         name: mypvc
         annotations:
           volume.beta.kubernetes.io/storage-class: "ibmc-file-retain-custom"
         labels:
           billingType: "hourly"
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
        <caption>Description des composants du fichier YAML</caption>
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
        <td>Nom de la classe de stockage que vous envisagez d'utiliser pour mettre à disposition du stockage de fichiers. </br> Si vous n'indiquez pas de classe de stockage, le volume persistant (PV) est créé avec la classe de stockage par défaut <code>ibmc-file-bronze</code>.<p>**Astuce :** pour modifier la classe de stockage par défaut, exécutez la commande <code>kubectl patch storageclass &lt;storageclass&gt; -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'</code> et remplacez <code>&lt;storageclass&gt;</code> par le nom de la classe de stockage.</p></td>
        </tr>
        <tr>
          <td><code>metadata/labels/billingType</code></td>
          <td>Indiquez la fréquence de calcul de votre facture de stockage, au mois ("monthly") ou à l'heure ("hourly"). Si vous ne précisez pas de type de facturation, le stockage est mis à disposition avec un type de facturation à l'heure. </td>
        </tr>
        <tr>
        <td><code>spec/accessMode</code></td>
        <td>Indiquez l'une des options suivantes : <ul><li><strong>ReadWriteMany : </strong>la réservation de volume persistant (PVC) peut être montée par plusieurs pods. Tous les pods peuvent effectuer des opérations de lecture et d'écriture dans le volume. </li><li><strong>ReadOnlyMany : </strong>la réservation de volume persistant (PVC) peut être montée par plusieurs pods. Tous les pods ont un accès en lecture seule. <li><strong>ReadWriteOnce : </strong>la réservation de volume persistant (PVC) peut être montée par un seul pod. Ce pod peut effectuer des opérations de lecture et d'écriture dans le volume. </li></ul></td>
        </tr>
        <tr>
        <td><code>spec/resources/requests/storage</code></td>
        <td>Entrez la taille du stockage de fichiers, en gigaoctets (Gi). </br></br><strong>Remarque : </strong> une fois le stockage mis à disposition, vous ne pouvez plus modifier la taille de votre stockage de fichiers. Veillez à indiquer une taille correspondant à la quantité de données que vous envisagez de stocker. </td>
        </tr>
        <tr>
        <td><code>spec/resources/requests/iops</code></td>
        <td>Cette option est disponible uniquement pour les classes de stockage personnalisées (`ibmc-file-custom / ibmc-file-retain-custom`). Indiquez le nombre total d'opérations d'entrée-sortie par seconde (IOPS) pour le stockage, en sélectionnant un multiple de 100 dans la plage autorisée. Si vous choisissez une valeur IOPS autre que celle répertoriée, la valeur IOPS est arrondie à la valeur supérieure.</td>
        </tr>
        </tbody></table>

    Si vous souhaitez utiliser une classe de stockage personnalisée, créez votre réservation de volume persistant (PVC) avec le nom de classe de stockage correspondant, un nombre d'IOPS et une taille valides.   
    {: tip}

2.  Créez la réservation de volume persistant (PVC).

    ```
    kubectl apply -f mypvc.yaml
    ```
    {: pre}

3.  Vérifiez que votre PVC est créée et liée au volume persistant (PV). Ce processus peut prendre quelques minutes.

    ```
    kubectl describe pvc mypvc
    ```
    {: pre}

    Exemple de sortie :

    ```
    Name: mypvc
    Namespace: default
    StorageClass: ""
    Status:		Bound
    Volume:		pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
    Labels:		<none>
    Capacity:	20Gi
    Access Modes:	RWX
    Events:
      FirstSeen	LastSeen	Count	From								SubObjectPath	Type		Reason			Message
      ---------	--------	-----	----								-------------	--------	------			-------
      3m		3m		1	{ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 }			Normal		Provisioning		External provisioner is provisioning volume for claim "default/my-persistent-volume-claim"
      3m		1m		10	{persistentvolume-controller }							Normal		ExternalProvisioning	cannot find provisioner "ibm.io/ibmc-file", expecting that a volume for the claim is provisioned either manually or via external software
      1m		1m		1	{ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 }			Normal		ProvisioningSucceeded	Successfully provisioned volume pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2

    ```
    {: screen}

4.  {: #app_volume_mount}Pour monter le stockage sur votre déploiement, créez un fichier de configuration `.yaml` et spécifiez la réservation de volume persistant (PVC) associée au PV.

    Si vous disposez d'une application qui nécessite l'écriture de stockage persistant par un utilisateur non root ou d'une application qui nécessite que le chemin de montage appartiennent à l'utilisateur root, voir [Ajout d'un accès d'utilisateur non root au stockage de fichiers NFS](cs_troubleshoot_storage.html#nonroot) ou [Activation des droits root pour stockage de fichiers NFS](cs_troubleshoot_storage.html#nonroot).
    {: tip}

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
    <caption>Description des composants du fichier YAML</caption>
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
    <td>Nom de l'image que vous désirez utiliser. Pour répertorier les images disponibles dans un votre compte {{site.data.keyword.registryshort_notm}}, exécutez la commande `ibmcloud cr image-list`.</td>
    </tr>
    <tr>
    <td><code>spec/containers/name</code></td>
    <td>Nom du conteneur que vous désirez déployer dans votre cluster.</td>
    </tr>
    <tr>
    <td><code>spec/containers/volumeMounts/mountPath</code></td>
    <td>Chemin absolu du répertoire où est monté le volume dans le conteneur. Les données écrites dans le chemin de montage sont stockées sous le répertoire <code>root</code> dans votre instance de stockage de fichiers physique. Pour créer des répertoires dans cette instance, vous devez créer des sous-répertoires dans le chemin de montage. </td>
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
    <td>Nom de la réservation de volume persistant (PVC) liée au volume persistant (PV) que vous voulez utiliser. </td>
    </tr>
    </tbody></table>

5.  Créez le déploiement.
     ```
     kubectl apply -f <local_yaml_path>
     ```
     {: pre}

6.  Vérifiez que le montage du volume persistant (PV) a abouti.

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




## Utilisation de stockage de fichiers existant dans votre cluster
{: #existing_file}

Si vous disposez déjà d'une unité de stockage physique que vous souhaitez utiliser dans votre cluster, vous pouvez créer le volume persistant (PV) et la réservation de volume persistant (PVC) manuellement pour un [provisionnement statique](cs_storage_basics.html#static_provisioning) du stockage.

Avant de commencer, vérifiez que vous disposez d'au moins un noeud worker présent dans la même zone que votre instance de stockage de fichiers existante.

### Etape 1 : Préparation de votre stockage existant.

Avant de commencer à monter votre stockage existant sur une application, vous devez obtenir toutes les informations nécessaires pour votre volume persistant (PV) et préparer le stockage pour le rendre accessible dans votre cluster.  

**Pour du stockage mis à disposition avec une classe de stockage `retain` :** </br>
Si vous avez mis à disposition du stockage avec une classe de stockage `retain`, lorsque vous supprimez la réservation de volume persistant (PVC), le volume persistant (PV) et l'unité de stockage physique ne sont pas supprimés automatiquement. Pour réutiliser le stockage dans votre cluster, vous devez d'abord supprimer le volume persistant restant.

Pour utiliser du stockage existant dans un cluster différent de celui où vous l'avez mis à disposition, suivez les étapes concernant le [stockage créé en dehors du cluster](#external_storage) pour ajouter le stockage dans le sous-réseau de votre noeud worker.
{: tip}

1. Répertoriez les volumes persistants (PV) existants.
   ```
   kubectl get pv
   ```
   {: pre}

   Recherchez le volume persistant (PV) appartenant à votre stockage persistant. Ce PV est à l'état `released`.

2. Obtenez les détails du volume persistant.
   ```
   kubectl describe pv <pv_name>
   ```
   {: pre}

3. Notez les valeurs de `CapacityGb`, `storageClass`, `failure-domain.beta.kubernetes.io/region`, `failure-domain.beta.kubernetes.io/zone`, `server` et `path`.

4. Supprimez le volume persistant.
   ```
   kubectl delete pv <pv_name>
   ```
   {: pre}

5. Vérifiez que la suppression du volume persistant a abouti.
   ```
   kubectl get pv
   ```
   {: pre}

</br>

**Pour le stockage persistant mis à disposition en dehors du cluster :** </br>
Si vous envisagez d'utiliser du stockage existant que vous avez mis à disposition auparavant mais que vous n'avez encore jamais utilisé dans votre cluster, vous devez le rendre accessible dans le même sous-réseau que vos noeuds worker.

**Remarque** : si vous disposez d'un compte Dedicated, vous devez [ouvrir un ticket de demande de service](/docs/get-support/howtogetsupport.html#getting-customer-support).

1.  {: #external_storage}Dans le [portail de l'infrastructure IBM Cloud (SoftLayer) ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://control.bluemix.net/), cliquez sur **Stockage**.
2.  Cliquez sur **Stockage de fichiers** et, dans le menu **Actions**, sélectionnez **Autoriser l'hôte**.
3.  Sélectionnez **Sous-réseaux**.
4.  Dans la liste déroulante, sélectionnez le sous-réseau de VLAN privé auquel est connecté votre noeud worker. Pour trouver le sous-réseau de votre noeud worker, exécutez la commande `ibmcloud ks workers <cluster_name>` et comparez l'adresse IP privée (`Private IP`) de votre noeud worker au sous-réseau que vous avez trouvé dans la liste déroulante.
5.  Cliquez sur **Soumettre**.
6.  Cliquez sur le nom du stockage de fichiers.
7.  Notez les zones de point de montage (`Mount Point`), de taille (`size`) et d'emplacement (`Location`). La zone `Mount Point` s'affiche sous la forme `<nfs_server>:<file_storage_path>`.

### Etape 2 : Création d'un volume persistant (PV) et d'une réservation de volume persistant (PVC) correspondante

1.  Créez un fichier de configuration de stockage pour votre volume persistant. Incluez les valeurs que vous avez récupérées précédemment.

    ```
    apiVersion: v1
    kind: PersistentVolume
    metadata:
     name: mypv
     labels:
        failure-domain.beta.kubernetes.io/region: <region>
        failure-domain.beta.kubernetes.io/zone: <zone>
    spec:
     capacity:
       storage: "<size>"
     accessModes:
       - ReadWriteMany
     nfs:
       server: "<nfs_server>"
       path: "<file_storage_path>"
    ```
    {: codeblock}

    <table>
    <caption>Description des composants du fichier YAML</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code>name</code></td>
    <td>Entrez le nom de l'objet PV à créer.</td>
    </tr>
    <tr>
    <td><code>metadata/labels</code></td>
    <td>Entrez la région et la zone que vous avez récupérées précédemment. Vous devez disposer d'au moins un noeud worker dans la même région et dans la même zone que votre stockage persistant pour monter le stockage sur votre cluster. S'il existe déjà un volume persistant pour votre stockage, [ajouter un libellé de zone et de région](cs_storage_basics.html#multizone) à votre volume persistant.
    </tr>
    <tr>
    <td><code>spec/capacity/storage</code></td>
    <td>Entrez la taille de stockage du partage de fichiers NFS existant que vous avez récupérée précédemment. Cette taille doit être indiquée en gigaoctets, par exemple 20Gi (20 Go) ou 1000Gi (1 To), et correspondre à celle du partage de fichiers existant.</td>
    </tr>
    <tr>
    <td><code>spec/accessMode</code></td>
    <td>Indiquez l'une des options suivantes : <ul><li><strong>ReadWriteMany : </strong>la réservation de volume persistant (PVC) peut être montée par plusieurs pods. Tous les pods peuvent effectuer des opérations de lecture et d'écriture dans le volume. </li><li><strong>ReadOnlyMany : </strong>la réservation de volume persistant (PVC) peut être montée par plusieurs pods. Tous les pods ont un accès en lecture seule. <li><strong>ReadWriteOnce : </strong>la réservation de volume persistant (PVC) peut être montée par un seul pod. Ce pod peut effectuer des opérations de lecture et d'écriture dans le volume. </li></ul></td>
    </tr>
    <tr>
    <td><code>spec/nfs/server</code></td>
    <td>Entrez l'ID du serveur de partage de fichiers NFS que vous avez récupéré précédemment.</td>
    </tr>
    <tr>
    <td><code>path</code></td>
    <td>Entrez le chemin d'accès au partage de fichiers NFS que vous avez récupéré précédemment.</td>
    </tr>
    </tbody></table>

3.  Créez le volume persistant dans votre cluster.

    ```
    kubectl apply -f mypv.yaml
    ```
    {: pre}

4.  Vérifiez que le volume persistant (PV) est créé.

    ```
    kubectl get pv
    ```
    {: pre}

5.  Créez un autre fichier de configuration pour créer votre réservation de volume persistant (PVC). Pour que cette réservation corresponde au volume persistant que vous avez créé auparavant, vous devez sélectionner la même valeur pour `storage` et `accessMode`. La zone `storage-class` doit être vide. Si une de ces zones ne correspond pas au volume persistant (PV), un nouveau PV et une nouvelle instance de stockage physique sont [provisionnés dynamiquement](cs_storage_basics.html#dynamic_provisioning).

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
         storage: "<size>"
    ```
    {: codeblock}

6.  Créez votre réservation de volume persistant (PVC).

    ```
    kubectl apply -f mypvc.yaml
    ```
    {: pre}

7.  Vérifiez que votre PVC est créée et liée au volume persistant (PV). Ce processus peut prendre quelques minutes.

    ```
    kubectl describe pvc mypvc
    ```
    {: pre}

    Exemple de sortie :

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
      3m 1m	 10 {persistentvolume-controller } Normal ExternalProvisioning cannot find provisioner "ibm.io/ibmc-file", expecting that a volume for the claim is provisioned either manually or via external software
      1m 1m 1 {ibm.io/ibmc-file 31898035-3011-11e7-a6a4-7a08779efd33 } Normal ProvisioningSucceeded	Successfully provisioned volume pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2
    ```
    {: screen}


Vous venez de créer un objet PV que vous avez lié à une réservation PVC. Les utilisateurs du cluster peuvent désormais [monter la PVC](#app_volume_mount) sur leurs déploiements et commencer à effectuer des opérations de lecture et d'écriture sur l'objet PV.

<br />



## Modification de la version NFS par défaut
{: #nfs_version}

La version de stockage de fichiers détermine le protocole utilisé pour communiquer avec le serveur de stockage de fichiers {{site.data.keyword.Bluemix_notm}}. Par défaut, toutes les instances de stockage de fichiers sont configurées avec NFS version 4. Vous pouvez modifier votre volume persistant en passant à une version NFS antérieure si votre application nécessite une version particulière pour fonctionner correctement.
{: shortdesc}

Pour modifier la version NFS par défaut, vous pouvez créer une nouvelle classe de stockage pour mettre à disposition du stockage de fichiers de manière dynamique dans votre cluster ou opter pour modifier un volume persistant existant monté sur votre pod.

**Important :** pour appliquer les mises à jour de sécurité les plus récentes afin d'obtenir de meilleures performances, utilisez la version NFS par défaut et ne revenez pas à une version NFS antérieure.

**Pour créer une classe de stockage personnalisée avec la version NFS désirée :**
1. Créez une [classe de stockage personnalisée](#nfs_version_class) avec la version NFS que vous voulez mettre à disposition.
2. Créez la classe de stockage dans votre cluster.
   ```
   kubectl apply -f nfsversion_storageclass.yaml
   ```
   {: pre}

3. Vérifiez que la classe de stockage personnalisée a été créée.
   ```
   kubectl get storageclasses
   ```
   {: pre}

4. Mettez à disposition le [stockage de fichiers](#add_file) avec votre classe de stockage personnalisée.

**Pour modifier votre volume persistant existant de sorte à utiliser une autre version NFS :**

1. Récupérez le volume persistant (PV) du stockage de fichiers dont vous voulez modifier la version NFS et notez le nom de ce volume.
   ```
   kubectl get pv
   ```
   {: pre}

2. Ajoutez une annotation à votre volume persistant. Remplacez `<version_number>` par la version NFS de votre choix. Par exemple, pour passer à NFS version 3.0, entrez **3**.  
   ```
   kubectl patch pv <pv_name> -p '{"metadata": {"annotations":{"volume.beta.kubernetes.io/mount-options":"vers=<version_number>"}}}'
   ```
   {: pre}

3. Supprimez le pod qui utilise le stockage de fichiers et recréez le pod.
   1. Sauvegardez le fichier YAML du pod sur votre machine locale.
      ```
      kubectl get pod <pod_name> -o yaml > <filepath/pod.yaml>
      ```
      {: pre}

   2. Supprimez le pod.
      ```
      kubectl deleted pod <pod_name>
      ```
      {: pre}

   3. Recréez le pod.
      ```
      kubectl apply -f pod.yaml
      ```
      {: pre}

4. Patientez jusqu'à la fin du déploiement du pod.
   ```
   kubectl get pods
   ```
   {: pre}

   Le pod est complètement déployé lorsque le statut passe à `Running`.

5. Connectez-vous à votre pod.
   ```
   kubectl exec -it <pod_name> sh
   ```
   {: pre}

6. Vérifiez que le stockage de fichiers a été monté avec la version NFS que vous avez spécifiée auparavant.
   ```
   mount | grep "nfs" | awk -F" |," '{ print $5, $8 }'
   ```
   {: pre}

   Exemple de sortie :
   ```
   nfs vers=3.0
   ```
   {: screen}

<br />


## Sauvegarde et restauration des données
{: #backup_restore}

Le stockage de fichiers est mis à disposition au même emplacement que les noeuds worker dans votre cluster. Le stockage est hébergé par IBM sur des serveurs en cluster pour qu'il soit disponible si un serveur tombe en panne. Cependant, le stockage de fichiers n'est pas sauvegardé automatiquement et risque d'être inaccessible en cas de défaillance de l'emplacement global. Pour éviter que vos données soient perdues ou endommagées, vous pouvez configurer des sauvegardes régulières que vous pourrez utiliser pour récupérer vos données si nécessaire.
{: shortdesc}

Passez en revue les options de sauvegarde et restauration suivantes pour votre stockage de fichiers :

<dl>
  <dt>Configurer la prise d'instantanés régulière</dt>
  <dd><p>Vous pouvez [configurer la prise d'instantanés régulière de votre stockage de fichiers](/docs/infrastructure/FileStorage/snapshots.html). Un instantané est une image en lecture seule qui capture l'état de l'instance à un moment donné. Pour stocker l'instantané, vous devez demander de l'espace d'image instantanée dans votre stockage de fichiers. Les instantanés sont stockés dans l'instance de stockage existante figurant dans la même zone. Vous pouvez restaurer des données à partir d'un instantané si l'utilisateur supprime accidentellement des données importantes du volume. <strong>Remarque</strong> : si vous disposez d'un compte Dedicated, vous devez [ouvrir un ticket de demande de service](/docs/get-support/howtogetsupport.html#getting-customer-support).</br></br> <strong>Pour créer un instantané de votre volume :</strong><ol><li>Répertoriez les volumes persistants (PV) existants dans votre cluster. <pre class="pre"><code>    kubectl get pv
    </code></pre></li><li>Obtenez les détails du volume persistant pour lequel vous voulez créer un espace d'instantané et notez l'ID du volume, la taille et le nombre d'entrées-sorties par seconde (IOPS). <pre class="pre"><code>kubectl describe pv &lt;pv_name&gt;</code></pre> L'ID du volume, la taille et le nombre d'IOPS se trouvent dans la section <strong>Labels</strong> dans la sortie de l'interface CLI. </li><li>Créez la taille de l'instantané pour le volume existant avec les paramètres que vous avez récupérés à l'étape précédente. <pre class="pre"><code>slcli file snapshot-order --capacity &lt;size&gt; --tier &lt;iops&gt; &lt;volume_id&gt;</code></pre></li><li>Attendez que la taille de l'instantané soit créée. <pre class="pre"><code>slcli file volume-detail &lt;volume_id&gt;</code></pre>La taille de l'instantané est mise à disposition lorsque la section <strong>Snapshot Capacity (GB)</strong> de la sortie de l'interface CLI passe de 0 à la taille que vous avez commandée. </li><li>Créez l'instantané de votre volume et notez l'ID de l'instantané qui a été créé pour vous. <pre class="pre"><code>slcli file snapshot-create &lt;volume_id&gt;</code></pre></li><li>Vérifiez que la création de l'instantané a abouti. <pre class="pre"><code>slcli file volume-detail &lt;snapshot_id&gt;</code></pre></li></ol></br><strong>Pour restaurer les données d'un instantané sur un volume existant : </strong><pre class="pre"><code>slcli file snapshot-restore -s &lt;snapshot_id&gt; &lt;volume_id&gt;</code></pre></p></dd>
  <dt>Répliquer les instantanés dans une autre zone</dt>
 <dd><p>Pour protéger vos données en cas de défaillance d'une zone, vous pouvez [répliquer des instantanés](/docs/infrastructure/FileStorage/replication.html#replicating-data) sur une instance de stockage de fichiers configurée dans une autre zone. Les données peuvent être répliquées du stockage principal uniquement vers le stockage de sauvegarde. Vous ne pouvez pas monter une instance de stockage de fichiers répliquée dans un cluster. En cas de défaillance de votre stockage principal, vous pouvez manuellement définir votre stockage de sauvegarde répliqué comme stockage principal. Vous pouvez ensuite le monter sur votre cluster. Une fois votre stockage principal restauré, vous pouvez récupérer les données dans le stockage de sauvegarde. <strong>Remarque</strong> : si vous disposez d'un compte Dedicated, vous ne pouvez pas répliquer des instantanés sur une autre zone.</p></dd>
 <dt>Dupliquer le stockage</dt>
 <dd><p>Vous pouvez [dupliquer votre instance de stockage de fichiers](/docs/infrastructure/FileStorage/how-to-create-duplicate-volume.html#creating-a-duplicate-file-storage) dans la même zone que l'instance de stockage d'origine. Un doublon contient les même données que l'instance de stockage d'origine au moment où vous créez le doublon. Contrairement aux répliques, le doublon s'utilise comme une instance de stockage indépendante de l'original. Pour effectuer la duplication, commencez par [configurer des instantanés pour le volume](/docs/infrastructure/FileStorage/snapshots.html). <strong>Remarque</strong> : si vous disposez d'un compte Dedicated, vous devez <a href="/docs/get-support/howtogetsupport.html#getting-customer-support">ouvrir un ticket de demande de service</a>.</p></dd>
  <dt>Sauvegarder les données dans {{site.data.keyword.cos_full}}</dt>
  <dd><p>Vous pouvez utiliser l'[**image ibm-backup-restore**](/docs/services/RegistryImages/ibm-backup-restore/index.html#ibmbackup_restore_starter) pour constituer un pod de sauvegarde et de restauration dans votre cluster. Ce pod contient un script pour exécuter une sauvegarde unique ou régulière d'une réservation de volume persistant (PVC) dans votre cluster. Les données sont stockées dans votre instance {{site.data.keyword.cos_full}} que vous avez configuré dans une zone.</p>
  <p>Pour rendre vos données hautement disponibles et protéger votre application en cas de défaillance d'une zone, configurez une deuxième instance {{site.data.keyword.cos_full}} et répliquez les données entre les différentes zones. Si vous devez restaurer des données à partir de votre instance {{site.data.keyword.cos_full}}, utilisez le script de restauration fourni avec l'image.</p></dd>
<dt>Copier les données depuis et vers des pods et des conteneurs</dt>
<dd><p>Vous pouvez utiliser la [commande![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/reference/kubectl/overview/#cp) `kubectl cp` pour copier des fichiers et des répertoires depuis et vers des pods ou des conteneurs spécifiques dans votre cluster.</p>
<p>Avant de commencer, [ciblez avec votre interface de ligne de commande Kubernetes](cs_cli_install.html#cs_cli_configure) le cluster que vous voulez utiliser. Si vous n'indiquez pas de conteneur avec <code>-c</code>, la commande utilise le premier conteneur disponible dans le pod.</p>
<p>Vous pouvez utiliser la commande de plusieurs manières :</p>
<ul>
<li>Copier les données de votre machine locale vers un pod dans votre cluster : <pre class="pre"><code>kubectl cp <var>&lt;local_filepath&gt;/&lt;filename&gt;</var> <var>&lt;namespace&gt;/&lt;pod&gt;:&lt;pod_filepath&gt;</var></code></pre></li>
<li>Copier les données d'un pod de votre cluster vers votre machine locale : <pre class="pre"><code>kubectl cp <var>&lt;namespace&gt;/&lt;pod&gt;:&lt;pod_filepath&gt;/&lt;filename&gt;</var> <var>&lt;local_filepath&gt;/&lt;filename&gt;</var></code></pre></li>
<li>Copier les données de votre machine locale vers un conteneur spécifique qui s'exécute dans un pod de votre cluster : <pre class="pre"><code>kubectl cp <var>&lt;local_filepath&gt;/&lt;filename&gt;</var> <var>&lt;namespace&gt;/&lt;pod&gt;:&lt;pod_filepath&gt;</var> -c <var>&lt;container></var></code></pre></li>
</ul></dd>
  </dl>

<br />


## Référence des classes de stockage
{: #storageclass_reference}

### Bronze
{: #bronze}

<table>
<caption>Classe de stockage de fichiers : bronze</caption>
<thead>
<th>Caractéristiques</th>
<th>Paramètre</th>
</thead>
<tbody>
<tr>
<td>Nom</td>
<td><code>ibmc-file-bronze</code></br><code>ibmc-file-retain-bronze</code></td>
</tr>
<tr>
<td>Type</td>
<td>[Stockage Endurance ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://knowledgelayer.softlayer.com/topic/endurance-storage)</td>
</tr>
<tr>
<td>Système de fichiers</td>
<td>NFS</td>
</tr>
<tr>
<td>IOPS par gigaoctet</td>
<td>2</td>
</tr>
<tr>
<td>Plage de tailles en gigaoctets</td>
<td>20-12000 Gi</td>
</tr>
<tr>
<td>Disque dur</td>
<td>SSD</td>
</tr>
<tr>
<td>Facturation</td>
<td>A l'heure</td>
</tr>
<tr>
<td>Tarification</td>
<td>[Informations de tarification ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://www.ibm.com/cloud/file-storage/pricing)</td>
</tr>
</tbody>
</table>


### Silver
{: #silver}

<table>
<caption>Classe de stockage de fichiers : silver</caption>
<thead>
<th>Caractéristiques</th>
<th>Paramètre</th>
</thead>
<tbody>
<tr>
<td>Nom</td>
<td><code>ibmc-file-silver</code></br><code>ibmc-file-retain-silver</code></td>
</tr>
<tr>
<td>Type</td>
<td>[Stockage Endurance ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://knowledgelayer.softlayer.com/topic/endurance-storage)</td>
</tr>
<tr>
<td>Système de fichiers</td>
<td>NFS</td>
</tr>
<tr>
<td>IOPS par gigaoctet</td>
<td>4</td>
</tr>
<tr>
<td>Plage de tailles en gigaoctets</td>
<td>20-12000 Gi</td>
</tr>
<tr>
<td>Disque dur</td>
<td>SSD</td>
</tr>
<tr>
<td>Facturation</td>
<td>A l'heure</li></ul></td>
</tr>
<tr>
<td>Tarification</td>
<td>[Informations de tarification ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://www.ibm.com/cloud/file-storage/pricing)</td>
</tr>
</tbody>
</table>

### Gold
{: #gold}

<table>
<caption>Classe de stockage de fichiers : gold</caption>
<thead>
<th>Caractéristiques</th>
<th>Paramètre</th>
</thead>
<tbody>
<tr>
<td>Nom</td>
<td><code>ibmc-file-gold</code></br><code>ibmc-file-retain-gold</code></td>
</tr>
<tr>
<td>Type</td>
<td>[Stockage Endurance ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://knowledgelayer.softlayer.com/topic/endurance-storage)</td>
</tr>
<tr>
<td>Système de fichiers</td>
<td>NFS</td>
</tr>
<tr>
<td>IOPS par gigaoctet</td>
<td>10</td>
</tr>
<tr>
<td>Plage de tailles en gigaoctets</td>
<td>20-4000 Gi</td>
</tr>
<tr>
<td>Disque dur</td>
<td>SSD</td>
</tr>
<tr>
<td>Facturation</td>
<td>A l'heure</li></ul></td>
</tr>
<tr>
<td>Tarification</td>
<td>[Informations de tarification ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://www.ibm.com/cloud/file-storage/pricing)</td>
</tr>
</tbody>
</table>

### Custom
{: #custom}

<table>
<caption>Classe de stockage de fichiers : custom</caption>
<thead>
<th>Caractéristiques</th>
<th>Paramètre</th>
</thead>
<tbody>
<tr>
<td>Nom</td>
<td><code>ibmc-file-custom</code></br><code>ibmc-file-retain-custom</code></td>
</tr>
<tr>
<td>Type</td>
<td>[Performance ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://knowledgelayer.softlayer.com/topic/performance-storage)</td>
</tr>
<tr>
<td>Système de fichiers</td>
<td>NFS</td>
</tr>
<tr>
<td>IOPS et taille</td>
<td><p><strong>Plage de tailles en gigaoctets / plage d'IOPS en multiples de 100</strong></p><ul><li>20-39 Gi / 100-1000 IOPS</li><li>40-79 Gi / 100-2000 IOPS</li><li>80-99 Gi / 100-4000 IOPS</li><li>100-499 Gi / 100-6000 IOPS</li><li>500-999 Gi / 100-10000 IOPS</li><li>1000-1999 Gi / 100-20000 IOPS</li><li>2000-2999 Gi / 200-40000 IOPS</li><li>3000-3999 Gi / 200-48000 IOPS</li><li>4000-7999 Gi / 300-48000 IOPS</li><li>8000-9999 Gi / 500-48000 IOPS</li><li>10000-12000 Gi / 1000-48000 IOPS</li></ul></td>
</tr>
<tr>
<td>Disque dur</td>
<td>Rapport IOPS/gigaoctets qui détermine le type de disque dur mis à disposition. Pour déterminer ce rapport, divisez la valeur des IOPS par la taille de votre stockage. </br></br>Exemple : </br>Vous avez choisi 500Gi de stockage avec 100 IOPS. Votre rapport est 0,2 (100 IOPS/500Gi). </br></br><strong>Présentation des types de disque dur en fonction du rapport :</strong><ul><li>Inférieur ou égal à 0,3 : SATA</li><li>Supérieur à 0,3 : SSD</li></ul></td>
</tr>
<tr>
<td>Facturation</td>
<td>A l'heure</li></ul></td>
</tr>
<tr>
<td>Tarification</td>
<td>[Informations de tarification ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://www.ibm.com/cloud/file-storage/pricing)</td>
</tr>
</tbody>
</table>

<br />


## Exemples de classes de stockage personnalisées
{: #custom_storageclass}

### Spécification de zone pour les clusters à zones multiples
{: #multizone_yaml}

Le fichier `.yaml` suivant personnalise une classe de stockage basée sur la classe de stockage `ibm-file-silver` sans retain : le `type` est `"Endurance"`, la valeur de `iopsPerGB` est `4`, la valeur de `sizeRange` est `"[20-12000]Gi"` et la valeur de `reclaimPolicy` est définie avec `"Delete"`. La zone indiquée est `dal12`. Vous pouvez consulter les informations précédentes sur les classes de stockage `ibmc` pour vous aider à choisir des valeurs acceptables pour ces éléments. </br>

```
apiVersion: storage.k8s.io/v1beta1
kind: StorageClass
metadata:
  name: ibmc-file-silver-mycustom-storageclass
  labels:
    kubernetes.io/cluster-service: "true"
provisioner: ibm.io/ibmc-file
parameters:
  zone: "dal12"
  type: "Endurance"
  iopsPerGB: "4"
  sizeRange: "[20-12000]Gi"
reclaimPolicy: "Delete"
```
{: codeblock}

### Modification de la version NFS par défaut
{: #nfs_version_class}

La classe de stockage personnalisée suivante est basée sur la [classe de stockage `ibmc-file-bronze`](#bronze) et vous permet de définir la version NFS que vous souhaitez mettre à disposition. Par exemple, pour mettre à disposition NFS version 3.0, remplacez `<nfs_version>` par **3.0**.
```
apiVersion: storage.k8s.io/v1
   kind: StorageClass
   metadata:
     name: ibmc-file-mount
     #annotations:
     #  storageclass.beta.kubernetes.io/is-default-class: "true"
     labels:
       kubernetes.io/cluster-service: "true"
   provisioner: ibm.io/ibmc-file
   parameters:
     type: "Endurance"
     iopsPerGB: "2"
     sizeRange: "[1-12000]Gi"
     reclaimPolicy: "Delete"
     classVersion: "2"
     mountOptions: nfsvers=<nfs_version>
```
{: codeblock}
