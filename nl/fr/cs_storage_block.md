---

copyright:
  years: 2014, 2018
lastupdated: "2018-08-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}





# Stockage de données sur IBM Block Storage pour IBM Cloud
{: #block_storage}


## Installation du plug-in {{site.data.keyword.Bluemix_notm}} Block Storage sur votre cluster
{: #install_block}

Installez le plug-in {{site.data.keyword.Bluemix_notm}} Block Storage avec une charte Helm pour configurer des classes de stockage prédéfinies pour le stockage par blocs. Ces classes de stockage vous permettent de créer une réservation de volume persistant pour mettre à disposition du stockage par blocs pour vos applications.
{: shortdesc}

Avant de commencer, [ciblez votre interface de ligne de commande](cs_cli_install.html#cs_cli_configure) sur le cluster dans lequel vous souhaitez installer le plug-in {{site.data.keyword.Bluemix_notm}} Block Storage.


1. Suivez les [instructions](cs_integrations.html#helm) pour installer le client Helm sur votre machine locale, installer le serveur Helm (tiller) sur votre cluster et ajouter le {{site.data.keyword.Bluemix_notm}} référentiel de charte Helm dans le cluster où vous souhaitez utiliser le plug-in {{site.data.keyword.Bluemix_notm}} Block Storage.
2. Mettez à jour le référentiel Helm pour extraire la dernière version de toutes les chartes Helm figurant dans ce référentiel.
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
   kubectl get pod -n kube-system | grep block
   ```
   {: pre}

   Exemple de sortie :
   ```
   ibmcloud-block-storage-driver-kh4mt                              1/1       Running   0          27d       10.118.98.19   10.118.98.19
   ibmcloud-block-storage-plugin-58c5f9dc86-pbl4t                   1/1       Running   0          14d       172.21.0.204   10.118.98.19
   ```
   {: screen}

   L'installation réussit lorsque vous voyez un pod `ibmcloud-block-storage-plugin` et un ou plusieurs pods `ibmcloud-block-storage-driver`. Le nombre de pods `ibmcloud-block-storage-driver` est égal au nombre de noeuds worker dans votre cluster. Tous les pods doivent être à l'état **Running**.

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

Vous pouvez maintenant passer à la [création d'une réservation de volume persistant (PVC)](#add_block) pour mettre à disposition du stockage par blocs pour votre application.


### Mise à jour du plug-in {{site.data.keyword.Bluemix_notm}} Block Storage
Vous pouvez mettre à niveau le plug-in {{site.data.keyword.Bluemix_notm}} Block Storage existant à la version la plus récente.
{: shortdesc}

Avant de commencer, [ciblez votre interface de ligne de commande](cs_cli_install.html#cs_cli_configure) sur le cluster.

1. Mettez à jour le référentiel Helm pour extraire la dernière version de toutes les chartes Helm figurant dans ce référentiel.
   ```
   helm repo update
   ```
   {: pre}
   
2. Facultatif : téléchargez la charte Helm la plus récente sur votre machine locale. Ensuite, décompressez le package et consultez le fichier `release.md` pour trouver les informations relatives à la dernière édition. 
   ```
   helm fetch ibm/ibmcloud-block-storage-plugin
   ```
   {: pre}

3. Recherchez le nom de la charte Helm correspondant au stockage par blocs que vous avez installée dans votre cluster.
   ```
   helm ls | grep ibmcloud-block-storage-plugin
   ```
   {: pre}

   Exemple de sortie :
   ```
   myhelmchart 	1       	Mon Sep 18 15:31:40 2017	DEPLOYED	ibmcloud-block-storage-plugin-0.1.0	default
   ```
   {: screen}

4. Mettez à niveau le plug-in {{site.data.keyword.Bluemix_notm}} Block Storage à la version la plus récente.
   ```
   helm upgrade --force --recreate-pods <helm_chart_name>  ibm/ibmcloud-block-storage-plugin
   ```
   {: pre}

5. Facultatif : lorsque vous mettez à jour le plug-in, la classe de stockage `default` n'est pas définie. Pour définir la classe de stockage par défaut par une classe de stockage de votre choix, exécutez la commande suivante.
   ```
   kubectl patch storageclass <storageclass> -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
   ```
   {: pre}


### Retrait du plug-in {{site.data.keyword.Bluemix_notm}} Block Storage
Si vous ne souhaitez pas mettre à disposition et utiliser {{site.data.keyword.Bluemix_notm}} Block Storage dans votre cluster, vous pouvez désinstaller la charte Helm.
{: shortdesc}

**Remarque :** le retrait du plug-in ne retire pas les réservations de volume persistant (PVC), les volumes persistants (PV) ou les données. Lorsque vous retirez le plug-in, tous les pods associés et les ensembles de démons sont retirés de votre cluster. Vous ne pouvez pas fournir de nouveau stockage par blocs pour votre cluster ou utiliser des réservations de volume persistant et des volumes persistant de stockage par blocs existants une fois le plug-in retiré.

Avant de commencer :
- [Ciblez votre interface de ligne de commande](cs_cli_install.html#cs_cli_configure) sur le cluster. 
- Vérifiez que vous n'avez plus de réservation de volume persistant (PVC) ou de volume persistant (PV) dans votre cluster utilisant du stockage par blocs.

Pour supprimer le plug-in : 

1. Recherchez le nom de la charte Helm correspondant au stockage par blocs que vous avez installée dans votre cluster.
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



## Détermination de la configuration de stockage par blocs
{: #predefined_storageclass}

{{site.data.keyword.containerlong}} fournit des classes de stockage prédéfinies pour le stockage par blocs que vous pouvez utiliser pour mettre à disposition du stockage par blocs avec une configuration spécifique.
{: shortdesc}

Toutes les classes de stockage indiquent le type de stockage par blocs à mettre à disposition, y compris la taille disponible, les opérations d'entrée-sortie par seconde (IOPS), le système de fichiers, ainsi que la règle de conservation.  

**Important :** choisissez votre configuration de stockage avec précaution pour disposer d'une capacité suffisante pour stocker vos données. Après avoir mis à disposition un type de stockage spécifique en utilisant une classe de stockage, vous ne pouvez plus modifier la taille, le type, IOPS ou la règle de conservation de l'unité de stockage. Si vous avez besoin de plus de stockage ou de stockage avec une configuration différente, vous devez [créer une nouvelle instance de stockage et copier les données](cs_storage_basics.html#update_storageclass) de l'ancienne instance de stockage sur la nouvelle. 

1. Répertoriez les classes de stockage disponibles dans {{site.data.keyword.containerlong}}.
    ```
    kubectl get storageclasses | grep block
    ```
    {: pre}

    Exemple de sortie : 
    ```
    $ kubectl get storageclasses
    NAME                         TYPE
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

2. Examinez la configuration d'une classe de stockage. 
   ```
   kubectl describe storageclass <storageclass_name>
   ```
   {: pre}
   
   Pour plus d'informations sur chaque classe de stockage, voir [Référence des classes de stockage](#storageclass_reference). Si vous ne trouvez pas ce que vous cherchez, envisagez de créer votre propre classe de stockage personnalisée. Pour commencer, consultez les [exemples de classes de stockage personnalisées](#custom_storageclass).
   {: tip}
   
3. Sélectionnez le type de stockage par blocs que vous désirez mettre à disposition. 
   - **Classes de stockage Bronze, Silver et Gold :** ces classes de stockage mettent à disposition du [stockage Endurance ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://knowledgelayer.softlayer.com/topic/endurance-storage). Le stockage Endurance vous permet de choisir la taille de stockage en gigaoctets à des niveaux d'opérations d'entrée-sortie par seconde prédéfinis.
   - **Classe de stockage personnalisée :** cette classe de stockage met à disposition du [stockage Performance ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://knowledgelayer.softlayer.com/topic/performance-storage). Avec le stockage Performance, vous disposez d'un contrôle accru sur la taille de stockage et les opérations d'entrée-sortie par seconde. 
     
4. Choisissez la taille et la valeur des opérations d'entrée-sortie par seconde (IOPS) de votre stockage par blocs. La taille et le nombre d'IOPS définissent le nombre total d'IOPS (opérations d'entrée-sortie par seconde) qui sert d'indicateur pour mesurer la rapidité de votre stockage. Plus votre stockage comporte d'IOPS, plus il traite rapidement les opérations de lecture/écriture. 
   - **Classes de stockage Bronze, Silver et Gold :** ces classes de stockage sont fournies avec un nombre fixe d'IOPS par gigaoctet et sont mises à disposition sur des disques durs SSD. Le nombre total d'IOPS dépend de la taille de stockage que vous choisissez. Vous pouvez sélectionner tout nombre entier représentant la taille en gigaoctets dans la plage de taille autorisée, par exemple 20 Gi, 256 Gi ou 11854 Gi. Pour déterminer le nombre total d'IOPS, vous devez multiplier les IOPS par la taille sélectionnée. Par exemple, si vous sélectionnez la taille de stockage 1000Gi dans la classe de stockage Silver fournie avec 4 IOPS par Go, vous disposerez d'un stockage avec au total 4000 IOPS.  
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
   - **Classe de stockage personnalisée :** lorsque vous choisissez cette classe de stockage, vous disposez d'un contrôle accru sur la taille et les IOPS que vous souhaitez. En ce qui concerne la taille, vous pouvez sélectionner n'importe quel nombre entier comme valeur de gigaoctets dans la plage de tailles autorisée. La taille que vous choisissez détermine la plage d'IOPS dont vous pourrez bénéficier. Vous pouvez choisir une valeur d'IOPS multiple de 100 comprise dans la plage spécifiée. Le nombre d'IOPS que vous choisissez est statique et ne s'adapte pas à la taille du stockage. Par exemple, si vous choisissez 40Gi avec 100 IOPS, le nombre total d'IOPS restera 100. </br></br>Le rapport IOPS/gigaoctets détermine le type de disque dur mis à votre disposition. Par exemple, si vous avez 500Gi à 100 IOPS, votre rapport IOPS/gigaoctet est 0,2. Un stockage avec un rapport inférieur ou égal à 0,3 est fourni sur des disques durs SATA. Si votre rapport est supérieur à 0,3, votre stockage est fourni sur des disques durs SSD.
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
   - Pour conserver vos données, choisissez une classe de stockage `retain`. Lorsque vous supprimez la réservation PVC, seule la PVC est supprimée. Le volume persistant (PV), l'unité de stockage physique dans votre compte d'infrastructure IBM Cloud (SoftLayer), ainsi que vous données existent toujours. Pour récupérer le stockage et l'utiliser à nouveau dans votre cluster, vous devez supprimer le volume persistant et suivre les étapes pour [utiliser du stockage par blocs existant](#existing_block). 
   - Si vous souhaitez que le volume persistant, les données et votre unité physique de stockage par blocs soient supprimés en même temps que la réservation PVC, choisissez une classe de stockage sans `retain`.
   
6. Choisissez une facturation à l'heure ou mensuelle. Pour plus d'informations, consultez la [tarification ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://www.ibm.com/cloud/block-storage/pricing). Par défaut, toutes les unités de stockage par blocs sont mises à disposition avec une facturation à l'heure. 

<br />



## Ajout de stockage par blocs à des applications
{: #add_block}

Créez une réservation de volume persistant (PVC) pour le [provisionnement dynamique](cs_storage_basics.html#dynamic_provisioning) de stockage par blocs pour votre cluster. Le provisionnement dynamique crée automatiquement le volume persistant (PV) correspondant et commande l'unité de stockage réelle dans votre compte d'infrastructure IBM Cloud (SoftLayer).
{:shortdesc}

**Important** : le stockage par blocs est fourni avec un mode d'accès de type `ReadWriteOnce`. Vous ne pouvez le monter que sur un seul pod dans un seul noeud worker du cluster à la fois.

Avant de commencer :
- Si vous disposez d'un pare-feu, [autorisez l'accès sortant](cs_firewall.html#pvc) pour les plages d'adresses IP de l'infrastructure IBM Cloud (SoftLayer) des zones dans lesquelles résident vos clusters, de manière à pouvoir créer des réservations de volume persistant (PVC).
- Installez le [plug-in {{site.data.keyword.Bluemix_notm}} Block Storage](#install_block).
- [Optez pour une classe de stockage prédéfinie](#predefined_storageclass) ou créez une [classe de stockage personnalisée](#custom_storageclass). 

Pour ajouter du stockage par blocs :

1.  Créez un fichier de configuration pour définir votre réservation de volume persistant (PVC) et sauvegardez la configuration sous forme de fichier `.yaml`.

    -  **Exemple d'utilisation de classes de stockage Bronze, Silver et Gold** :
       Le fichier `.yaml` suivant crée une réservation nommée `mypvc` de la classe de stockage `"ibmc-block-silver"`, facturée à l'heure (`"hourly"`), avec une taille de `24Gi`.  

       ```
       apiVersion: v1
       kind: PersistentVolumeClaim
       metadata:
         name: mypvc
         annotations:
           volume.beta.kubernetes.io/storage-class: "ibmc-block-silver"
         labels:
           billingType: "hourly"
	   region: us-south
           zone: dal13
       spec:
         accessModes:
           - ReadWriteOnce
         resources:
           requests:
             storage: 24Gi
        ```
        {: codeblock}

    -  **Exemple d'utilisation de la classe de stockage personnalisée** :
       Le fichier `.yaml` suivant crée une réservation nommée `mypvc` de la classe de stockage `ibmc-block-retain-custom`, facturée à l'heure (`"hourly"`), avec une taille en gigaoctets de `45Gi` et `"300"` IOPS. 

       ```
       apiVersion: v1
       kind: PersistentVolumeClaim
       metadata:
         name: mypvc
         annotations:
           volume.beta.kubernetes.io/storage-class: "ibmc-block-retain-custom"
         labels:
           billingType: "hourly"
	   region: us-south
           zone: dal13
       spec:
         accessModes:
           - ReadWriteOnce
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
        <td>Nom de la classe de stockage que vous envisagez d'utiliser pour mettre à disposition du stockage par blocs. </br> Si vous n'indiquez pas de classe de stockage, le volume persistant (PV) est créé avec la classe de stockage par défaut <code>ibmc-file-bronze</code>. <p>**Astuce :** pour modifier la classe de stockage par défaut, exécutez la commande <code>kubectl patch storageclass &lt;storageclass&gt; -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'</code> et remplacez <code>&lt;storageclass&gt;</code> par le nom de la classe de stockage.</p></td>
        </tr>
        <tr>
          <td><code>metadata/labels/billingType</code></td>
          <td>Indiquez la fréquence de calcul de votre facture de stockage, au mois ("monthly") ou à l'heure ("hourly"). La valeur par défaut est "hourly".</td>
        </tr>
	<tr>
	<td><code>metadata/region</code></td>
        <td>Indiquez la région dans laquelle vous souhaitez mettre à disposition votre stockage par blocs. Si vous spécifiez la région, vous devez également indiquer une zone. Si vous n'indiquez pas de région, ou si la région indiquée est introuvable, le stockage est créé dans la même région que votre cluster. </br><strong>Remarque :</strong> cette option est uniquement prise en charge avec le plug-in IBM Cloud Block Storage version 1.0.1 ou supérieure. Pour les versions antérieures du plug-in, si vous disposez d'un cluster à zones multiples, la zone dans laquelle votre stockage est mis à disposition est sélectionnée en mode circulaire pour équilibrer les demandes de volume uniformément dans toutes les zones. Si vous souhaitez indiquer la zone destinée à votre stockage, créez d'abord une [classe de stockage personnalisée](#multizone_yaml). Créez ensuite une réservation de volume persistant (PVC) avec votre classe de stockage personnalisée.</td>
	</tr>
	<tr>
	<td><code>metadata/zone</code></td>
	<td>Indiquez la zone dans laquelle vous souhaitez mettre à disposition votre stockage par blocs. Si vous spécifiez la zone, vous devez également indiquer une région. Si vous n'indiquez pas de zone, ou si la zone indiquée est introuvable dans un cluster à zones multiples, la zone est sélectionnée en mode circulaire. </br><strong>Remarque :</strong> cette option est uniquement prise en charge avec le plug-in IBM Cloud Block Storage version 1.0.1 ou supérieure. Pour les versions antérieures du plug-in, si vous disposez d'un cluster à zones multiples, la zone dans laquelle votre stockage est mis à disposition est sélectionnée en mode circulaire pour équilibrer les demandes de volume uniformément dans toutes les zones. Si vous souhaitez indiquer la zone destinée à votre stockage, créez d'abord une [classe de stockage personnalisée](#multizone_yaml). Créez ensuite une réservation de volume persistant (PVC) avec votre classe de stockage personnalisée.</td>
	</tr>
        <tr>
        <td><code>spec/resources/requests/storage</code></td>
        <td>Entrez la taille du stockage par blocs en gigaoctets (Gi). </br></br><strong>Remarque : </strong> une fois le stockage mis à disposition, vous ne pouvez plus modifier la taille de votre stockage par blocs. Veillez à indiquer une taille correspondant à la quantité de données que vous envisagez de stocker. </td>
        </tr>
        <tr>
        <td><code>spec/resources/requests/iops</code></td>
        <td>Cette option est disponible uniquement pour les classes de stockage personnalisées (`ibmc-block-custom / ibmc-block-retain-custom`). Indiquez le nombre total d'opérations d'entrée-sortie par seconde (IOPS) pour le stockage, en sélectionnant un multiple de 100 dans la plage autorisée. Si vous choisissez une valeur IOPS autre que celle répertoriée, la valeur IOPS est arrondie à la valeur supérieure.</td>
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
      3m 3m 1 {ibm.io/ibmc-block 31898035-3011-11e7-a6a4-7a08779efd33 } Normal Provisioning External provisioner is provisioning volume  for claim "default/my-persistent-volume-claim"
       3m 1m	 10 {persistentvolume-controller } Normal ExternalProvisioning cannot find provisioner "ibm.io/ibmc-block", expecting that  a volume for the claim is provisioned either manually or via external software
       1m 1m 1 {ibm.io/ibmc-block 31898035-3011-11e7-a6a4-7a08779efd33 } Normal ProvisioningSucceeded	Successfully provisioned volume  pvc-0d787071-3a67-11e7-aafc-eef80dd2dea2

    ```
    {: screen}

4.  {: #app_volume_mount}Pour monter le volume persistant (PV) sur votre déploiement, créez un fichier de configuration `.yaml` et spécifiez la réservation de volume persistant (PVC) associée au PV.

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




## Utilisation de stockage par blocs existant dans votre cluster
{: #existing_block}

Si vous disposez déjà d'une unité de stockage physique que vous souhaitez utiliser dans votre cluster, vous pouvez créer le volume persistant (PV) et la réservation de volume persistant (PVC) manuellement pour un [provisionnement statique](cs_storage_basics.html#static_provisioning) du stockage.

Avant de commencer à monter votre stockage existant sur une application, vous devez obtenir toutes les informations nécessaires pour votre volume persistant.  
{: shortdesc}

### Etape 1 : Récupération des informations de votre stockage par blocs existant

1.  Récupérez ou générez une clé d'API pour votre compte d'infrastructure IBM Cloud (SoftLayer).
    1. Connectez-vous au [portail d'infrastructure IBM Cloud (SoftLayer) ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://control.bluemix.net/).
    2. Sélectionnez **Compte**, puis **Utilisateurs** et ensuite **Liste d'utilisateurs**.
    3. Recherchez votre ID utilisateur.
    4. Dans la colonne **Clé d'API**, cliquez sur **Générer** pour générer la clé d'API ou sur **Afficher** pour afficher votre clé d'API existante.
2.  Récupérez le nom d'utilisateur d'API correspondant à votre compte d'infrastructure IBM Cloud (SoftLayer).
    1. Dans le menu **Liste d'utilisateurs**, sélectionnez votre ID utilisateur.
    2. Dans la section **Informations d'accès à l'API**, retrouvez votre **Nom d'utilisateur de l'API**.
3.  Connectez-vous au plug-in d'interface de ligne de commande (CLI) de l'infrastructure IBM Cloud.
    ```
    ibmcloud sl init
    ```
    {: pre}

4.  Optez pour l'authentification à l'aide du nom d'utilisateur et de la clé d'API de votre compte d'infrastructure IBM Cloud (SoftLayer).
5.  Entrez le nom d'utilisateur et la clé d'API que vous avez récupérés dans les étapes précédentes.
6.  Affichez la liste des unités de stockage par blocs.
    ```
    ibmcloud sl block volume-list
    ```
    {: pre}

    Exemple de sortie :
    ```
    id         username            datacenter   storage_type              capacity_gb   bytes_used   ip_addr         lunId   active_transactions
    38642141   IBM02SEL1543159-1   dal10        endurance_block_storage   20            -            169.xx.xxx.xxx   170     0
    ```
    {: screen}

7.  Notez les valeurs correspondant à `id`, `ip_addr`, `capacity_gb`, `datacenter` et `lunId` de l'unité de stockage par blocs que vous souhaitez monter dans votre cluster. **Remarque :** pour monter du stockage existant sur un cluster, vous devez disposer d'un noeud worker dans la même zone que votre stockage. Pour vérifier la zone de votre noeud worker, exécutez la commande `ibmcloud ks workers <cluster_name_or_ID>`. 

### Etape 2 : Création d'un volume persistant (PV) et d'une réservation de volume persistant (PVC) correspondante

1.  Facultatif : si vous disposez de stockage mis à disposition avec une classe de stockage `retain`, lorsque vous supprimez la réservation de volume persistant (PVC), le volume persistant (PV) et l'unité de stockage physique ne sont pas supprimés. Pour réutiliser le stockage dans votre cluster, vous devez d'abord supprimer le volume persistant. 
    1. Répertoriez les volumes persistants (PV) existants.
       ```
       kubectl get pv
       ```
       {: pre}
     
       Recherchez le volume persistant (PV) appartenant à votre stockage persistant. Ce PV est à l'état `released`. 
     
    2. Supprimez le volume persistant.
       ```
       kubectl delete pv <pv_name>
       ```
       {: pre}
   
    3. Vérifiez que la suppression du volume persistant a abouti.
       ```
       kubectl get pv
       ```
       {: pre}

2.  Créez un fichier de configuration pour votre volume persistant. Incluez les valeurs des paramètres de stockage par blocs suivants : `id`, `ip_addr`, `capacity_gb`, `datacenter` et `lunIdID` que vous avez récupérées précédemment.

    ```
    apiVersion: v1
    kind: PersistentVolume
    metadata:
      name: mypv
      labels:
         failure-domain.beta.kubernetes.io/region=<region>
         failure-domain.beta.kubernetes.io/zone=<zone>
    spec:
      capacity:
        storage: "<storage_size>"
      accessModes:
        - ReadWriteOnce
      flexVolume:
        driver: "ibm/ibmc-block"
        fsType: "<fs_type>"
        options:
          "Lun": "<lun_ID>"
          "TargetPortal": "<IP_address>"
          "VolumeID": "<volume_ID>"
          "volumeName": "<volume_name>"
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
    <td>Entrez le nom du volume persistant que vous désirez créer.</td>
    </tr>
    <tr>
    <td><code>metadata/labels</code></td>
    <td>Entrez la région et la zone que vous avez récupérées précédemment. Vous devez disposer d'au moins un noeud worker dans la même région et dans la même zone que votre stockage persistant pour monter le stockage sur votre cluster. S'il existe déjà un volume persistant pour votre stockage, [ajouter un libellé de zone et de région](cs_storage_basics.html#multizone) à votre volume persistant.
    </tr>
    <tr>
    <td><code>spec/flexVolume/fsType</code></td>
    <td>Entrez le type de système de fichiers configuré pour votre stockage par blocs existant. Choisissez entre <code>ext4</code> ou <code>xfs</code>. Si vous ne spécifiez pas cette option, le volume persistant (PV) prend la valeur par défaut <code>ext4</code>. Si le mauvais type fsType est défini, la création du volume persistant aboutit, mais le montage de ce volume sur un pod est voué à l'échec. </td></tr>	    
    <tr>
    <td><code>spec/capacity/storage</code></td>
    <td>Entrez la taille de stockage du stockage par blocs existant que vous avez récupérée à l'étape précédente dans <code>capacity-gb</code>. La taille de stockage doit être indiquée en gigaoctets, par exemple 20Gi (20 Go) ou 1000Gi (1 To).</td>
    </tr>
    <tr>
    <td><code>flexVolume/options/Lun</code></td>
    <td>Entrez l'ID de numéro d'unité logique de votre stockage par blocs que vous avez récupéré précédemment dans l'élément <code>lunId</code>.</td>
    </tr>
    <tr>
    <td><code>flexVolume/options/TargetPortal</code></td>
    <td>Entrez l'adresse IP de votre stockage par blocs que vous avez récupérée précédemment dans l'élément <code>ip_addr</code>. </td>
    </tr>
    <tr>
	    <td><code>flexVolume/options/VolumeId</code></td>
	    <td>Entrez l'ID de votre stockage par blocs que vous avez récupéré précédemment dans l'élément <code>id</code>.</td>
	    </tr>
	    <tr>
		    <td><code>flexVolume/options/volumeName</code></td>
		    <td>Entrez un nom pour votre volume.</td>
	    </tr>
    </tbody></table>

3.  Créez le volume persistant dans votre cluster.
    ```
    kubectl apply -f mypv.yaml
    ```
    {: pre}

4. Vérifiez que le volume persistant (PV) est créé.
    ```
    kubectl get pv
    ```
    {: pre}

5. Créez un autre fichier de configuration pour créer votre réservation de volume persistant (PVC). Pour que cette réservation corresponde au volume persistant que vous avez créé auparavant, vous devez sélectionner la même valeur pour `storage` et `accessMode`. La zone `storage-class` doit être vide. Si une de ces zones ne correspond pas au volume persistant (PV), un nouveau PV est créé automatiquement à la place.

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
          storage: "<storage_size>"
     ```
     {: codeblock}

6.  Créez votre réservation de volume persistant (PVC).
     ```
     kubectl apply -f mypvc.yaml
     ```
     {: pre}

7.  Vérifiez que votre réservation PVC est créée et liée au volume persistant que vous avec créé auparavant. Ce processus peut prendre quelques minutes.
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



## Sauvegarde et restauration des données 
{: #backup_restore}

Le stockage par blocs est mis à disposition au même emplacement que les noeuds worker dans votre cluster. Le stockage est hébergé par IBM sur des serveurs en cluster pour qu'il soit disponible si un serveur tombe en panne. Cependant, le stockage par blocs n'est pas sauvegardé automatiquement et risque d'être inaccessible en cas de défaillance de l'emplacement global. Pour éviter que vos données soient perdues ou endommagées, vous pouvez configurer des sauvegardes régulières que vous pourrez utiliser pour récupérer vos données si nécessaire.

Passez en revue les options de sauvegarde et restauration suivantes pour votre stockage par blocs :

<dl>
  <dt>Configurer la prise d'instantanés régulière</dt>
  <dd><p>Vous pouvez [configurer la prise d'instantanés régulière de votre stockage par blocs](/docs/infrastructure/BlockStorage/snapshots.html#snapshots). Un instantané est une image en lecture seule qui capture l'état de l'instance à un moment donné. Pour stocker l'instantané, vous devez demander de l'espace d'image instantanée dans votre stockage par blocs. Les instantanés sont stockés dans l'instance de stockage existante figurant dans la même zone. Vous pouvez restaurer des données à partir d'un instantané si l'utilisateur supprime accidentellement des données importantes du volume. </br></br> <strong>Pour créer un instantané de votre volume :</strong><ol><li>Répertoriez les volumes persistants (PV) existants dans votre cluster. <pre class="pre"><code>    kubectl get pv
    </code></pre></li><li>Obtenez les détails du volume persistant pour lequel vous voulez créer un espace d'instantané et notez l'ID du volume, la taille et le nombre d'entrées-sorties par seconde (IOPS). <pre class="pre"><code>kubectl describe pv &lt;pv_name&gt;</code></pre> La taille et le nombre d'IOPS sont affichés dans la section <strong>Labels</strong> de la sortie de l'interface CLI. Pour trouver l'ID du volume, consultez l'annotation <code>ibm.io/network-storage-id</code> dans la sortie de l'interface CLI. </li><li>Créez la taille de l'instantané pour le volume existant avec les paramètres que vous avez récupérés à l'étape précédente. <pre class="pre"><code>slcli block snapshot-order --capacity &lt;size&gt; --tier &lt;iops&gt; &lt;volume_id&gt;</code></pre></li><li>Attendez que la taille de l'instantané soit créée. <pre class="pre"><code>slcli block volume-detail &lt;volume_id&gt;</code></pre>La taille de l'instantané est mise à disposition lorsque la section <strong>Snapshot Capacity (GB)</strong> de la sortie de l'interface CLI passe de 0 à la taille que vous avez commandée. </li><li>Créez l'instantané de votre volume et notez l'ID de l'instantané qui a été créé pour vous. <pre class="pre"><code>slcli block snapshot-create &lt;volume_id&gt;</code></pre></li><li>Vérifiez que la création de l'instantané a abouti. <pre class="pre"><code>slcli block volume-detail &lt;snapshot_id&gt;</code></pre></li></ol></br><strong>Pour restaurer les données d'un instantané sur un volume existant : </strong><pre class="pre"><code>slcli block snapshot-restore -s &lt;snapshot_id&gt; &lt;volume_id&gt;</code></pre></p></dd>
  <dt>Répliquer les instantanés dans une autre zone</dt>
 <dd><p>Pour protéger vos données en cas de défaillance d'une zone, vous pouvez [répliquer des instantanés](/docs/infrastructure/BlockStorage/replication.html#replicating-data) sur une instance de stockage par blocs configurée dans une autre zone. Les données peuvent être répliquées du stockage principal uniquement vers le stockage de sauvegarde. Vous ne pouvez pas monter une instance de stockage par blocs répliquée dans un cluster. En cas de défaillance de votre stockage principal, vous pouvez manuellement définir votre stockage de sauvegarde répliqué comme stockage principal. Vous pouvez ensuite le monter sur votre cluster. Une fois votre stockage principal restauré, vous pouvez récupérer les données dans le stockage de sauvegarde.</p></dd>
 <dt>Dupliquer le stockage</dt>
 <dd><p>Vous pouvez [dupliquer votre instance de stockage par blocs](/docs/infrastructure/BlockStorage/how-to-create-duplicate-volume.html#creating-a-duplicate-block-volume) dans la même zone que l'instance de stockage d'origine. Un doublon contient les mêmes données que l'instance de stockage d'origine au moment où vous créez le doublon. Contrairement aux répliques, le doublon s'utilise comme une instance de stockage indépendante de l'original. Pour effectuer la duplication, configurez d'abord des instantanés pour le volume.</p></dd>
  <dt>Sauvegarder les données dans {{site.data.keyword.cos_full}}</dt>
  <dd><p>Vous pouvez utiliser l'[**image ibm-backup-restore**](/docs/services/RegistryImages/ibm-backup-restore/index.html#ibmbackup_restore_starter) pour constituer un pod de sauvegarde et de restauration dans votre cluster. Ce pod contient un script pour exécuter une sauvegarde unique ou régulière d'une réservation de volume persistant (PVC) dans votre cluster. Les données sont stockées dans votre instance {{site.data.keyword.cos_full} que vous avez configurée dans une zone.</p><strong>Remarque :</strong> le stockage par blocs est monté avec un mode d'accès RWO. Ce type d'accès autorise uniquement le montage d'un pod à la fois sur le stockage par blocs. Pour sauvegarder vos données, vous devez démonter le pod d'application du stockage, le monter sur votre pod de sauvegarde, sauvegardez les données et monter à nouveau le stockage sur votre pod d'application. </br></br>
Pour rendre vos données hautement disponibles et protéger votre application en cas de défaillance d'une zone, configurez une deuxième instance {{site.data.keyword.cos_full}} et répliquez les données entre les différentes zones. Si vous devez restaurer des données à partir de votre instance {{site.data.keyword.cos_full}}, utilisez le script de restauration fourni avec l'image.</dd>
<dt>Copier les données depuis et vers des pods et des conteneurs</dt>
<dd><p>Vous pouvez utiliser la [commande![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/reference/kubectl/overview/#cp) `kubectl cp` pour copier des fichiers et des répertoires depuis et vers des pods ou des conteneurs spécifiques dans votre cluster.</p>
<p>Avant de commencer, [ciblez avec votre interface de ligne de commande Kubernetes](cs_cli_install.html#cs_cli_configure) le cluster que vous voulez utiliser. Si vous n'indiquez pas de conteneur avec <code>-c</code>, la commande utilise le premier conteneur disponible dans le pod.</p>
<p>Vous pouvez utiliser la commande de plusieurs manières :</p>
<ul>
<li>Copier les données de votre machine locale vers un pod dans votre cluster : <pre class="pre"><code>kubectl cp <var>&lt;local_filepath&gt;/&lt;filename&gt;</var> <var>&lt;namespace&gt;/&lt;pod&gt;:&lt;pod_filepath&gt;</var></code></pre></li>
<li>Copier les données d'un pod de votre cluster vers votre machine locale : <pre class="pre"><code>kubectl cp <var>&lt;namespace&gt;/&lt;pod&gt;:&lt;pod_filepath&gt;/&lt;filename&gt;</var> <var>&lt;local_filepath&gt;/&lt;filename&gt;</var></code></pre></li>
<li>Copier les données d'un pod de votre cluster vers un conteneur spécifique dans un autre pod : <pre class="pre"><code>kubectl cp <var>&lt;namespace&gt;/&lt;pod&gt;:&lt;pod_filepath&gt;</var> <var>&lt;namespace&gt;/&lt;other_pod&gt;:&lt;pod_filepath&gt;</var> -c <var>&lt;container></var></code></pre></li>
</ul></dd>
  </dl>

<br />


## Référence des classes de stockage
{: #storageclass_reference}

### Bronze
{: #bronze}

<table>
<caption>Classe de stockage par blocs : bronze</caption>
<thead>
<th>Caractéristiques</th>
<th>Paramètre</th>
</thead>
<tbody>
<tr>
<td>Nom</td>
<td><code>ibmc-block-bronze</code></br><code>ibmc-block-retain-bronze</code></td>
</tr>
<tr>
<td>Type</td>
<td>[Stockage Endurance ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://knowledgelayer.softlayer.com/topic/endurance-storage)</td>
</tr>
<tr>
<td>Système de fichiers</td>
<td>ext4</td>
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
<td>Le type de facturation par défaut dépend de votre version de plug-in {{site.data.keyword.Bluemix_notm}} Block Storage : <ul><li> Version 1.0.1 et supérieure : à l'heure</li><li>Version 1.0.0 et inférieure : au mois</li></ul></td>
</tr>
<tr>
<td>Tarification</td>
<td>[Informations de tarification ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://www.ibm.com/cloud/block-storage/pricing)</td>
</tr>
</tbody>
</table>


### Silver
{: #silver}

<table>
<caption>Classe de stockage par blocs : silver</caption>
<thead>
<th>Caractéristiques</th>
<th>Paramètre</th>
</thead>
<tbody>
<tr>
<td>Nom</td>
<td><code>ibmc-block-silver</code></br><code>ibmc-block-retain-silver</code></td>
</tr>
<tr>
<td>Type</td>
<td>[Stockage Endurance ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://knowledgelayer.softlayer.com/topic/endurance-storage)</td>
</tr>
<tr>
<td>Système de fichiers</td>
<td>ext4</td>
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
<td>Le type de facturation par défaut dépend de votre version de plug-in {{site.data.keyword.Bluemix_notm}} Block Storage : <ul><li> Version 1.0.1 et supérieure : à l'heure</li><li>Version 1.0.0 et inférieure : au mois</li></ul></td>
</tr>
<tr>
<td>Tarification</td>
<td>[Informations de tarification ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://www.ibm.com/cloud/block-storage/pricing)</td>
</tr>
</tbody>
</table>

### Gold
{: #gold}

<table>
<caption>Classe de stockage par blocs : gold</caption>
<thead>
<th>Caractéristiques</th>
<th>Paramètre</th>
</thead>
<tbody>
<tr>
<td>Nom</td>
<td><code>ibmc-block-gold</code></br><code>ibmc-block-retain-gold</code></td>
</tr>
<tr>
<td>Type</td>
<td>[Stockage Endurance ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://knowledgelayer.softlayer.com/topic/endurance-storage)</td>
</tr>
<tr>
<td>Système de fichiers</td>
<td>ext4</td>
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
<td>Le type de facturation par défaut dépend de votre version de plug-in {{site.data.keyword.Bluemix_notm}} Block Storage : <ul><li> Version 1.0.1 et supérieure : à l'heure</li><li>Version 1.0.0 et inférieure : au mois</li></ul></td>
</tr>
<tr>
<td>Tarification</td>
<td>[Informations de tarification ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://www.ibm.com/cloud/block-storage/pricing)</td>
</tr>
</tbody>
</table>

### Personnalisée
{: #custom}

<table>
<caption>Classe de stockage de bloc : personnalisée</caption>
<thead>
<th>Caractéristiques</th>
<th>Paramètre</th>
</thead>
<tbody>
<tr>
<td>Nom</td>
<td><code>ibmc-block-custom</code></br><code>ibmc-block-retain-custom</code></td>
</tr>
<tr>
<td>Type</td>
<td>[Performance ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://knowledgelayer.softlayer.com/topic/performance-storage)</td>
</tr>
<tr>
<td>Système de fichiers</td>
<td>ext4</td>
</tr>
<tr>
<td>IOPS et taille</td>
<td><strong>Plage de tailles en gigaoctets / plage d'IOPS en multiples de 100</strong><ul><li>20-39 Gi / 100-1000 IOPS</li><li>40-79 Gi / 100-2000 IOPS</li><li>80-99 Gi / 100-4000 IOPS</li><li>100-499 Gi / 100-6000 IOPS</li><li>500-999 Gi / 100-10000 IOPS</li><li>1000-1999 Gi / 100-20000 IOPS</li><li>2000-2999 Gi / 200-40000 IOPS</li><li>3000-3999 Gi / 200-48000 IOPS</li><li>4000-7999 Gi / 300-48000 IOPS</li><li>8000-9999 Gi / 500-48000 IOPS</li><li>10000-12000 Gi / 1000-48000 IOPS</li></ul></td>
</tr>
<tr>
<td>Disque dur</td>
<td>Rapport IOPS/gigaoctets qui détermine le type de disque dur mis à disposition. Pour déterminer ce rapport, divisez la valeur des IOPS par la taille de votre stockage. </br></br>Exemple : </br>Vous avez choisi 500Gi de stockage avec 100 IOPS. Votre rapport est 0,2 (100 IOPS/500Gi). </br></br><strong>Présentation des types de disque dur en fonction du rapport :</strong><ul><li>Inférieur ou égal à 0,3 : SATA</li><li>Supérieur à 0,3 : SSD</li></ul></td>
</tr>
<tr>
<td>Facturation</td>
<td>Le type de facturation par défaut dépend de votre version de plug-in {{site.data.keyword.Bluemix_notm}} Block Storage : <ul><li> Version 1.0.1 et supérieure : à l'heure</li><li>Version 1.0.0 et inférieure : au mois</li></ul></td>
</tr>
<tr>
<td>Tarification</td>
<td>[Informations de tarification ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://www.ibm.com/cloud/block-storage/pricing)</td>
</tr>
</tbody>
</table>

<br />


## Exemples de classes de stockage personnalisées
{: #custom_storageclass}

### Spécification de zone pour les clusters à zones multiples
{: #multizone_yaml}

Le fichier `.yaml` suivant personnalise une classe de stockage basée sur la classe de stockage `ibm-block-silver` sans retain : le type `type` est `"Endurance"`, le nombre d'IOPS par gigaoctet (`iopsPerGB`) est `4`, la plage de tailles (`sizeRange`) est `"[20-12000]Gi"` et la règle de récupération (`reclaimPolicy`) est définie par `"Delete"`. La zone indiquée est `dal12`. Vous pouvez consulter les informations précédentes sur les classes de stockage `ibmc` pour vous aider à choisir des valeurs acceptables pour ces éléments. </br>

Pour utiliser une autre classe de stockage comme référence, voir la rubrique [Référence des classes de stockage](#storageclass_reference). 

```
apiVersion: storage.k8s.io/v1beta1
kind: StorageClass
metadata:
  name: ibmc-block-silver-mycustom-storageclass
  labels:
    kubernetes.io/cluster-service: "true"
provisioner: ibm.io/ibmc-block
parameters:
  zone: "dal12"
  type: "Endurance"
  iopsPerGB: "4"
  sizeRange: "[20-12000]Gi"
reclaimPolicy: "Delete"
```
{: codeblock}

### Montage d'un stockage par blocs avec un système de fichiers `XFS`
{: #xfs}

L'exemple suivant crée une classe de stockage nommée `ibmc-block-custom-xfs` qui met à disposition du stockage par blocs de type Performance avec un système de fichiers `XFS`. 

```
apiVersion: storage.k8s.io/v1
   kind: StorageClass
   metadata:
     name: ibmc-block-custom-xfs
     labels:
       addonmanager.kubernetes.io/mode: Reconcile
   provisioner: ibm.io/ibmc-block
   parameters:
     type: "Performance"
     sizeIOPSRange: |-
       [20-39]Gi:[100-1000]
       [40-79]Gi:[100-2000]
       [80-99]Gi:[100-4000]
       [100-499]Gi:[100-6000]
       [500-999]Gi:[100-10000]
       [1000-1999]Gi:[100-20000]
       [2000-2999]Gi:[200-40000]
       [3000-3999]Gi:[200-48000]
       [4000-7999]Gi:[300-48000]
       [8000-9999]Gi:[500-48000]
       [10000-12000]Gi:[1000-48000]
  fsType: "xfs"
     reclaimPolicy: "Delete"
     classVersion: "2"
```
{: codeblock}

<br />

