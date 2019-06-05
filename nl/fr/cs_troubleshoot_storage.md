---

copyright:
  years: 2014, 2019
lastupdated: "2019-04-05"

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
{:tsSymptoms: .tsSymptoms}
{:tsCauses: .tsCauses}
{:tsResolve: .tsResolve}


# Traitement des incidents liés au stockage en cluster
{: #cs_troubleshoot_storage}

Lorsque vous utilisez {{site.data.keyword.containerlong}}, tenez compte des techniques décrites ci-dessous pour identifier et résoudre les incidents liés au stockage en cluster.
{: shortdesc}

Si vous rencontrez un problème d'ordre plus général, expérimentez le [débogage de cluster](/docs/containers?topic=containers-cs_troubleshoot).
{: tip}

## Dans un cluster à zones multiples, le montage d'un volume persistant sur un pod échoue
{: #mz_pv_mount}

{: tsSymptoms}
Votre cluster était auparavant un cluster à zone unique avec des noeuds worker autonomes qui ne se trouvaient pas dans des pools de noeuds worker. Vous avez réussi à monter une réservation de volume persistant (PVC) qui décrivait le volume persistant (PV) à utiliser pour le déploiement du pod de votre application. Maintenant que vous disposez de pools de noeuds worker et de zones ajoutées dans votre cluster, le montage du volume persistant sur un pod se solde par un échec.

{: tsCauses}
Pour les clusters à zones multiples, les volumes persistants ont les libellés suivants pour que les pods ne puissent pas tenter de monter des volumes dans une autre zone.
* `failure-domain.beta.kubernetes.io/region`
* `failure-domain.beta.kubernetes.io/zone`

Par défaut, les nouveaux clusters avec des pools de noeuds worker pouvant couvrir plusieurs zones fournissent ces labels aux volumes persistants. Si vous avez créé vos clusters avant l'introduction des pools de noeuds worker, vous devez ajouter ces libellés manuellement.

{: tsResolve}
[Mettez à jour les volumes persistants dans votre cluster avec des libellés de région et de zone](/docs/containers?topic=containers-kube_concepts#storage_multizone).

<br />


## Stockage de fichiers : les systèmes de fichiers de vos noeuds worker passent en mode lecture seule
{: #readonly_nodes}

{: tsSymptoms}
{: #stuck_creating_state}
Vous pouvez voir l'un des symptômes suivants :
- Lorsque vous exécutez la commande `kubectl get pods -o wide`, vous voyez que plusieurs pods qui s'exécutent sur le même noeud worker sont bloqués à l'état `ContainerCreating`.
- Lorsque vous exécutez une commande `kubectl describe`, vous voyez s'afficher l'erreur suivante à la section **Events** : `MountVolume.SetUp failed for volume ... read-only file system`.

{: tsCauses}
Le système de fichiers sur le noeud worker est en lecture seule.

{: tsResolve}
1.  Sauvegardez les données éventuelles stockées sur le noeud worker ou dans vos conteneurs.
2.  Pour une solution à court terme sur le noeud worker existant, rechargez le noeud worker.
    <pre class="pre"><code>ibmcloud ks worker-reload --cluster &lt;cluster_name&gt; --worker &lt;worker_ID&gt;</code></pre>

Pour une solution à long terme, [mettez à jour le type de machine de votre pool de noeuds worker](/docs/containers?topic=containers-update#machine_type).

<br />



## Stockage de fichiers : l'application échoue lorsqu'un utilisateur non root détient le chemin de montage du stockage de fichiers NFS
{: #nonroot}

{: tsSymptoms}
Une fois que vous [ajoutez du stockage NFS](/docs/containers?topic=containers-file_storage#file_app_volume_mount) dans votre déploiement, le conteneur ne parvient pas à se déployer. Lorsque vous extrayez les journaux de votre conteneur, vous pourrez voir les messages d'erreur suivants. Il y a échec du pod qui est bloqué dans un cycle de rechargement.

```
write-permission
```
{: screen}

```
do not have required permission
```
{: screen}

```
cannot create directory '/bitnami/mariadb/data': Permission denied
```
{: screen}

{: tsCauses}
Par défaut, les utilisateurs non root ne disposent pas de droits en écriture sur le chemin de montage du volume correspondant au stockage sauvegardé par NFS. Certaines images d'application courantes, telles que Jenkins et Nexus3, spécifient un utilisateur non root qui détient le chemin de montage dans le fichier Dockerfile. Lorsque vous créez un conteneur à partir de ce fichier Dockerfile, la création échoue car l'utilisateur non root ne dispose pas des droits nécessaires pour accéder au chemin de montage. Pour octroyer des droits en écriture, vous pouvez modifier le fichier Dockerfile pour ajouter temporairement l'utilisateur non root au groupe d'utilisateurs root avant que les droits sur le chemin de montage soient modifiés, ou utiliser un conteneur init.

Si vous utilisez une charte Helm pour déployer l'image, modifiez le déploiement Helm pour utiliser un conteneur init.
{:tip}



{: tsResolve}
Lorsque vous ajoutez un [conteneur init![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/) dans votre déploiement, vous pouvez octroyer à un utilisateur non root spécifié dans votre fichier Dockerfile les droits en écriture pour le chemin de montage du volume à l'intérieur du conteneur qui pointe vers votre partage de fichiers NFS. Le conteneur init démarre avant le conteneur de votre application. Le conteneur init crée le chemin de montage du volume dans le conteneur, modifie le chemin de montage de sorte à ce que l'utilisateur (non root) correct en soit détenteur, puis se ferme. Ensuite, le conteneur de votre application avec l'utilisateur non root qui doit écrire dans le chemin de montage démarre. Comme le chemin est déjà détenu par l'utilisateur non root, l'écriture dans le chemin de montage aboutit. Si vous ne voulez pas utiliser un conteneur init, vous pouvez modifier le fichier Dockerfile afin d'ajouter l'accès d'utilisateur non root au stockage de fichiers NFS.


Avant de commencer : [connectez-vous à votre compte. Ciblez la région appropriée et, le cas échéant, le groupe de ressources. Définissez le contexte de votre cluster](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure).

1.  Ouvrez le fichier Dockerfile de votre application et récupérez l'ID utilisateur (UID) et l'ID du groupe (GID) de l'utilisateur auquel vous voulez accorder les droits en écriture sur le chemin de montage du volume. Dans l'exemple d'un fichier Dockerfile Jenkins, les informations sont :
    - UID : `1000`
    - GID : `1000`

    **Exemple** :

    ```
    FROM openjdk:8-jdk

    RUN apt-get update &&apt-get install -y git curl &&rm -rf /var/lib/apt/lists/*

    ARG user=jenkins
    ARG group=jenkins
    ARG uid=1000
    ARG gid=1000
    ARG http_port=8080
    ARG agent_port=50000

    ENV JENKINS_HOME /var/jenkins_home
    ENV JENKINS_SLAVE_AGENT_PORT ${agent_port}
    ...
    ```
    {:screen}

2.  Ajoutez du stockage persistant à votre application en créant une réservation de volume persistant (PVC). Cet exemple utilise la classe de stockage `ibmc-file-bronze`. Pour consulter les classes de stockage disponibles, exécutez la commande `kubectl get storageclasses`.

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

3.  Créez la réservation de volume persistant (PVC).

    ```
    kubectl apply -f mypvc.yaml
    ```
    {: pre}

4.  Dans votre fichier `.yaml` de déploiement, ajoutez le conteneur init. Insérez les identificateurs UID et GID que vous avez récupérés précédemment.

    ```
    initContainers:
    - name: initcontainer # Or replace the name
      image: alpine:latest
      command: ["/bin/sh", "-c"]
      args:
        - chown <UID>:<GID> /mount; # Replace UID and GID with values from the Dockerfile
      volumeMounts:
      - name: volume # Or you can replace with any name
        mountPath: /mount # Must match the mount path in the args line
    ```
    {: codeblock}

    **Exemple** pour un déploiement Jenkins :

    ```
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: my_pod
    spec:
      replicas: 1
      selector:
        matchLabels:
          app: jenkins      
      template:
        metadata:
          labels:
            app: jenkins
        spec:
          containers:
          - name: jenkins
            image: jenkins
            volumeMounts:
            - mountPath: /var/jenkins_home
              name: volume
          volumes:
          - name: volume
            persistentVolumeClaim:
              claimName: mypvc
          initContainers:
          - name: permissionsfix
            image: alpine:latest
            command: ["/bin/sh", "-c"]
            args:
              - chown 1000:1000 /mount;
            volumeMounts:
            - name: volume
              mountPath: /mount
    ```
    {: codeblock}

5.  Créez le pod et montez la PVC dessus.

    ```
    kubectl apply -f my_pod.yaml
    ```
    {: pre}

6. Vérifiez que le montage du volume sur votre pod a réussi. Notez le nom du pod et le chemin **Containers/Mounts**.

    ```
    kubectl describe pod <my_pod>
    ```
    {: pre}

    **Exemple de sortie** :

    ```
    Name:		    mypod-123456789
    Namespace:	default
    ...
    Init Containers:
    ...
    Mounts:
      /mount from volume (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-cp9f0 (ro)
    ...
    Containers:
      jenkins:
        Container ID:
        Image:		jenkins
        Image ID:
        Port:		  <none>
        State:		Waiting
          Reason:		PodInitializing
        Ready:		False
        Restart Count:	0
        Environment:	<none>
        Mounts:
          /var/jenkins_home from volume (rw)
          /var/run/secrets/kubernetes.io/serviceaccount from default-token-cp9f0 (ro)
    ...
    Volumes:
      myvol:
        Type: PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
        ClaimName: mypvc
        ReadOnly: false

    ```
    {: screen}

7.  Connectez-vous au pod en utilisant le nom du pod que vous avez noté précédemment.

    ```
    kubectl exec -it <my_pod-123456789> /bin/bash
    ```
    {: pre}

8. Vérifiez les droits octroyés pour le chemin de montage de votre conteneur. Dans l'exemple, le chemin de montage est `/var/jenkins_home`.

    ```
    ls -ln /var/jenkins_home
    ```
    {: pre}

    **Exemple de sortie** :

    ```
    jenkins@mypod-123456789:/$ ls -ln /var/jenkins_home
    total 12
    -rw-r--r-- 1 1000 1000  102 Mar  9 19:58 copy_reference_file.log
    drwxr-xr-x 2 1000 1000 4096 Mar  9 19:58 init.groovy.d
    drwxr-xr-x 9 1000 1000 4096 Mar  9 20:16 war
    ```
    {: screen}

    Cette sortie montre que les identificateurs GID et UID de votre fichier Dockerfile (dans cet exemple, `1000` et `1000`) sont propriétaires du chemin de montage à l'intérieur du conteneur.

<br />


## Stockage de fichiers : échec de l'ajout de l'accès d'utilisateur non root au stockage persistant
{: #cs_storage_nonroot}

{: tsSymptoms}
Une fois que vous avez [ajouté l'accès d'utilisateur non root au stockage persistant](#nonroot) ou déployé une charte Helm avec un ID d'utilisateur non root, l'utilisateur n'a pas accès en écriture au stockage monté.

{: tsCauses}
Le déploiement ou la configuration de la charte Helm indique le [contexte de sécurité](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/) pour `fsGroup` (ID de groupe) et `runAsUser` (ID utilisateur) du pod. Actuellement, {{site.data.keyword.containerlong_notm}} ne prend pas en charge la spécification `fsGroup` et n'accepte que `runAsUser` défini avec la valeur `0` (droits de l'utilisateur root).

{: tsResolve}
Supprimez les zones `securityContext` dans la configuration pour `fsGroup` et `runAsUser` du fichier de configuration de l'image, du déploiement ou de la charte Helm, et effectuez un redéploiement. Si vous devez remplacer la propriété du chemin de montage `nobody`, [ajoutez un accès d'utilisateur non root](#nonroot). Une fois que vous avez ajouté la propriété [non root `initContainer`](#nonroot), définissez `runAsUser` au niveau du conteneur et non pas au niveau du pod.

<br />




## Stockage par blocs : le stockage par blocs passe en lecture seule
{: #readonly_block}

{: tsSymptoms}
Vous pouvez voir les symptômes suivants :
- Lorsque vous exécutez la commande `kubectl get pods -o wide`, vous voyez que plusieurs pods sur le même noeud worker sont bloqués à l'état `ContainerCreating` ou `CrashLoopBackOff`. Tous ces pods utilisent la même instance de stockage par blocs.
- Lorsque vous exécutez une commande `kubectl describe pod`, vous voyez s'afficher l'erreur suivante dans la section **Events** : `MountVolume.SetUp failed for volume ... read-only`.

{: tsCauses}
Si une erreur réseau se produit lorsqu'un pod effectue une opération d'écriture dans un volume, l'infrastructure IBM Cloud (SoftLayer) protège les données sur le volume de toute corruption en faisant passer le volume en mode lecture seule. Les pods qui utilisent ce volume ne peuvent plus continuer à écrire dans le volume et sont en échec.

{: tsResolve}
1. Vérifiez la version du plug-in {{site.data.keyword.Bluemix_notm}} Block Storage installée dans votre cluster.
   ```
   helm ls
   ```
   {: pre}

2. Vérifiez que vous utilisez la [dernière version du plug-in {{site.data.keyword.Bluemix_notm}} Block Storage](https://cloud.ibm.com/kubernetes/solutions/helm-charts/ibm/ibmcloud-block-storage-plugin). Si ce n'est pas le cas, [mettez votre plug-in à jour](/docs/containers?topic=containers-block_storage#updating-the-ibm-cloud-block-storage-plug-in).
3. Si vous avez utilisé un déploiement Kubernetes pour votre pod, redémarrez le pod en échec en le retirant et en laissant Kubernetes le recréer. Si vous n'avez pas utilisé un déploiement, extrayez le fichier YAML qui a été utilisé pour créer votre pod en exécutant la commande `kubectl get pod <pod_name> -o yaml >pod.yaml`. Ensuite, supprimez le pod et recréez-le manuellement.
    ```
    kubectl delete pod <pod_name>
    ```
    {: pre}

4. Vérifiez si le fait de recréer votre pod a résolu le problème. Dans le cas contraire, rechargez le noeud worker.
   1. Retrouvez dans quel noeud worker s'exécute votre pod et notez l'adresse IP privée affectée à votre noeud worker.
      ```
      kubectl describe pod <pod_name> | grep Node
      ```
      {: pre}

      Exemple de sortie :
      ```
      Node:               10.75.XX.XXX/10.75.XX.XXX
      Node-Selectors:  <none>
      ```
      {: screen}

   2. Récupérez l'**ID** de votre noeud worker en utilisant l'adresse IP privée que vous avez obtenue à l'étape précédente.
      ```
      ibmcloud ks workers --cluster <cluster_name_or_ID>
      ```
      {: pre}

   3. [Rechargez le noeud worker](/docs/containers?topic=containers-cs_cli_reference#cs_worker_reload) normalement.


<br />


## Stockage par blocs : échec de montage d'un stockage par blocs existant sur un pod en raison d'un système de fichiers incorrect
{: #block_filesystem}

{: tsSymptoms}
Lorsque vous exécutez la commande `kubectl describe pod <pod_name>`, l'erreur suivante s'affiche :
```
failed to mount the volume as "ext4", it already contains xfs. Mount error: mount failed: exit status 32
```
{: screen}

{: tsCauses}
Vous disposez d'une unité de stockage par blocs configurée avec un système de fichiers `XFS`. Pour monter cette unité sur votre pod, vous [avez créé un volume persistant (PV)](/docs/containers?topic=containers-block_storage#existing_block) qui spécifiait `ext4` pour votre système de fichiers dans la section `spec/flexVolume/fsType`. Si aucun système de fichiers n'est défini, le volume persistant prend la valeur par défaut `ext4`.
Le volume persistant a été créé et lié à votre instance de stockage par blocs. Cependant, lorsque vous tentez de monter le volume persistant sur votre cluster en utilisant une réservation de volume persistant (PVC) correspondante, le montage du volume échoue. Vous ne pouvez pas monter votre instance de stockage par blocs `XFS` avec un système de fichiers `ext4` sur le pod.

{: tsResolve}
Mettez à jour le système de fichiers dans le volume persistant (PV) existant en remplaçant `ext4` par `XFS`.

1. Affichez la liste des volumes persistants existants dans votre cluster et notez le nom du volume persistant que vous avez utilisé pour votre instance de stockage par blocs.
   ```
   kubectl get pv
   ```
   {: pre}

2. Sauvegardez le fichier YAML du volume persistant (PV) sur votre machine locale.
   ```
   kubectl get pv <pv_name> -o yaml > <filepath/xfs_pv.yaml>
   ```
   {: pre}

3. Ouvrez le fichier YAML et modifiez `fsType` en remplaçant `ext4` par `xfs`.
4. Replacez le volume persistant dans votre cluster.
   ```
   kubectl replace --force -f <filepath/xfs_pv.yaml>
   ```
   {: pre}

5. Connectez-vous au pod sur lequel vous avez monté le volume persistant.
   ```
   kubectl exec -it <pod_name> sh
   ```
   {: pre}

6. Vérifiez que le système de fichiers est passé à `XFS`.
   ```
   df -Th
   ```
   {: pre}

   Exemple de sortie :
   ```
   Filesystem Type Size Used Avail Use% Mounted on /dev/mapper/3600a098031234546d5d4c9876654e35 xfs 20G 33M 20G 1% /myvolumepath
   ```
   {: screen}

<br />



## Stockage d'objets : l'installation du plug-in Helm `ibmc` d'{{site.data.keyword.cos_full_notm}} échoue
{: #cos_helm_fails}

{: tsSymptoms}
Lorsque vous installez le plug-in Helm `ibmc` d'{{site.data.keyword.cos_full_notm}}, l'installation échoue avec l'erreur suivante :
```
Error: symlink /Users/ibm/ibmcloud-object-storage-plugin/helm-ibmc /Users/ibm/.helm/plugins/helm-ibmc: file exists
```
{: screen}

{: tsCauses}
Lorsque le plug-in Helm `ibmc` est installé, un lien symbolique (symlink) est créé du répertoire `./helm/plugins/helm-ibmc` vers le répertoire dans lequel set trouve le plug-in Helm `ibmc` sur votre système local, il s'agit en général de `./ibmcloud-object-storage-plugin/helm-ibmc`. Lorsque vous retirez le plug-in Helm `ibmc` de votre système local, ou que vous déplacez le répertoire du plug-in Helm `ibmc` à un autre emplacement, le lien symbolique est conservé.

{: tsResolve}
1. Retirez le plug-in Helm d'{{site.data.keyword.cos_full_notm}}.
   ```
   rm -rf ~/.helm/plugins/helm-ibmc
   ```
   {: pre}

2. [Installez {{site.data.keyword.cos_full_notm}}](/docs/containers?topic=containers-object_storage#install_cos).

<br />


## Stockage d'objets : La création de la réservation de volume persistant (PVC) ou du pod échoue car la valeur confidentielle Kubernetes est introuvable
{: #cos_secret_access_fails}

{: tsSymptoms}
Lorsque vous créez votre réservation de volume persistant ou déployez un pod qui monte la PVC, la création ou le déploiement échoue.

- Exemple de message d'erreur pour l'échec de la création d'une PVC :
  ```
  pvc-3:1b23159vn367eb0489c16cain12345:cannot get credentials: cannot get secret tsecret-key: secrets "secret-key" not found
  ```
  {: screen}

- Exemple de message d'erreur pour l'échec de la création d'un pod :
  ```
  persistentvolumeclaim "pvc-3" not found (répété à 3 reprises)
  ```
  {: screen}

{: tsCauses}
La valeur confidentielle (secret) Kubernetes dans laquelle vous stockez les données d'identification du service {{site.data.keyword.cos_full_notm}}, la PVC et le pod ne figure pas dans le même espace de nom Kubernetes. Lorsque la valeur confidentielle est déployée dans un autre espace de nom que votre PVC ou votre pod, la valeur confidentielle est inaccessible.

{: tsResolve}
Cette tâche nécessite le [rôle de service {{site.data.keyword.Bluemix_notm}} IAM **Auteur** ou **Responsable**](/docs/containers?topic=containers-users#platform) pour tous les espaces de nom.

1. Répertoriez les valeurs confidentielles figurant dans votre cluster et examinez l'espace de nom Kubernetes dans lequel est créée la valeur confidentielle Kubernetes pour votre instance de service {{site.data.keyword.cos_full_notm}}. La valeur confidentielle doit afficher `ibm/ibmc-s3fs` comme **Type**.
   ```
   kubectl get secrets --all-namespaces
   ```
   {: pre}

2. Examinez le fichier de configuration YAML de votre PVC et de votre pod pour vérifier que vous avez utilisé le même espace de nom. Si vous voulez déployer un pod dans un autre espace de nom que celui dans lequel figure votre valeur confidentielle, [créez une autre valeur confidentielle](/docs/containers?topic=containers-object_storage#create_cos_secret) dans cet espace de nom.

3. Créez la PVC ou déployez le pod dans l'espace de nom approprié.

<br />


## Stockage d'objets : la création de la PVC échoue en raison de données d'identification incorrectes ou d'un accès refusé
{: #cred_failure}

{: tsSymptoms}
Lorsque vous créez la PVC, vous voyez un message d'erreur de ce type :

```
SignatureDoesNotMatch: The request signature we calculated does not match the signature you provided. Check your AWS Secret Access Key and signing method. For more information, see REST Authentication and SOAP Authentication for details.
```
{: screen}

```
AccessDenied: Access Denied status code: 403
```
{: screen}

```
CredentialsEndpointError: failed to load credentials
```
{: screen}

{: tsCauses}
Les données d'identification du service {{site.data.keyword.cos_full_notm}} que vous utilisez pour accéder à l'instance de service sont peut-être incorrectes ou n'autorisent que l'accès en lecture à votre compartiment.

{: tsResolve}
1. Dans la navigation de la page des détails du service, cliquez sur **Données d'identification pour le service**.
2. Recherchez vos données d'identification, puis cliquez sur **Afficher les données d'identification**.
3. Vérifiez que vous utilisez l'ID **access_key_id** et la clé **secret_access_key** appropriés dans votre valeur confidentielle Kubernetes. Dans le cas contraire, mettez à jour la valeur confidentielle Kubernetes.
   1. Obtenez le fichier YAML que vous avez utilisé pour créer la valeur confidentielle.
      ```
      kubectl get secret <secret_name> -o yaml
      ```
      {: pre}

   2. Mettez à jour les valeurs **access_key_id** et **secret_access_key**.
   3. Mettez à jour la valeur confidentielle.
      ```
      kubectl apply -f secret.yaml
      ```
      {: pre}

4. Dans la section **iam_role_crn**, vérifiez que vous disposez du rôle `Writer` ou `Manager`. Si vous n'avez pas le rôle approprié, vous devez [créer de nouvelles données d'identification de service {{site.data.keyword.cos_full_notm}} avec les droits adéquats](/docs/containers?topic=containers-object_storage#create_cos_service). Ensuite, mettez à jour la valeur confidentielle existante ou [créez une nouvelle valeur confidentielle](/docs/containers?topic=containers-object_storage#create_cos_secret) avec vos nouvelles données d'identification pour le service.

<br />


## Stockage d'objets : accès impossible à un compartiment existant

{: tsSymptoms}
Lorsque vous créez la PVC, le compartiment dans {{site.data.keyword.cos_full_notm}} est inaccessible. Vous voyez un message d'erreur de ce type :

```
Failed to provision volume with StorageClass "ibmc-s3fs-standard-regional": pvc:1b2345678b69175abc98y873e2:cannot access bucket <bucket_name>: NotFound: Not Found
```
{: screen}

{: tsCauses}
Il se peut que vous ayez utilisé la mauvaise classe de stockage pour accéder à votre compartiment ou que vous ayez tenté d'accéder à un compartiment que vous n'avez pas créé.

{: tsResolve}
1. Dans le [tableau de bord {{site.data.keyword.Bluemix_notm}} ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://cloud.ibm.com/), sélectionnez votre instance de service {{site.data.keyword.cos_full_notm}}.
2. Sélectionnez **Compartiments**.
3. Examinez les informations de **Classe** et d'**Emplacement** de votre compartiment existant.
4. Choisissez la [classe de stockage appropriée](/docs/containers?topic=containers-object_storage#cos_storageclass_reference).

<br />


## Stockage d'objets : l'accès aux fichiers avec un utilisateur non root échoue
{: #cos_nonroot_access}

{: tsSymptoms}
Vous avez téléchargé des fichiers dans votre instance de service {{site.data.keyword.cos_full_notm}} en utilisant la console ou l'API REST. Lorsque vous essayez d'accéder à ces fichiers avec un utilisateur non root que vous avez défini avec `runAsUser` dans le déploiement de votre application, l'accès à ces fichiers est refusé.

{: tsCauses}
Dans Linux, un fichier ou un répertoire comporte 3 groupes d'accès : `Owner`, `Group` et `Other`. Lorsque vous téléchargez un fichier dans {{site.data.keyword.cos_full_notm}} en utilisant la console ou l'API REST, les droits pour les groupes `Owner`, `Group` et `Other` sont retirés. Les droits correspondant à chaque fichier ressemblent à ceci :

```
d--------- 1 root root 0 Jan 1 1970 <file_name>
```
{: screen}

Lorsque vous téléchargez un fichier en utilisant le plug-in {{site.data.keyword.cos_full_notm}}, les droits correspondant à ce fichier sont conservés et ne changent pas.

{: tsResolve}
Pour accéder au fichier avec un utilisateur non root, cet utilisateur doit disposer des droits en lecture et en écriture pour le fichier. Modifier les droits sur un fichier dans le cadre du déploiement de votre pod nécessite une opération d'écriture. {{site.data.keyword.cos_full_notm}} n'est pas conçu pour les charges de travail d'écriture. La mise à jour des droits lors du déploiement du pod peut empêcher votre pod de passer à l'état `Running` (en cours d'exécution).

Pour y remédier, avant de monter la PVC sur votre pod d'application, créez un autre pod pour définir les droits nécessaires pour l'utilisateur non root.

1. Vérifiez les droits de vos fichiers dans votre compartiment.
   1. Créez un fichier de configuration pour votre pod `test-permission` et nommez le fichier `test-permission.yaml`.
      ```
      apiVersion: v1
      kind: Pod
      metadata:
        name: test-permission
      spec:
        containers:
        - name: test-permission
          image: nginx
          volumeMounts:
          - name: cos-vol
            mountPath: /test
        volumes:
        - name: cos-vol
          persistentVolumeClaim:
            claimName: <pvc_name>
      ```
      {: codeblock}

   2. Créez le pod `test-permission`.
      ```
      kubectl apply -f test-permission.yaml
      ```
      {: pre}

   3. Connectez-vous à votre pod.
      ```
      kubectl exec test-permission -it bash
      ```
      {: pre}

   4. Accédez à votre chemin de montage et répertoriez les droits correspondant à vos fichiers.
      ```
      cd test && ls -al
      ```
      {: pre}

      Exemple de sortie :
      ```
      d--------- 1 root root 0 Jan 1 1970 <file_name>
      ```
      {: screen}

2. Supprimez le pod.
   ```
   kubectl delete pod test-permission
   ```
   {: pre}

3. Créez un fichier de configuration pour le pod que vous utilisez pour corriger les droits de vos fichiers et nommez-le `fix-permission.yaml`.
   ```
   apiVersion: v1
   kind: Pod
   metadata:
     name: fix-permission 
     namespace: <namespace>
   spec:
     containers:
     - name: fix-permission
       image: busybox
       command: ['sh', '-c']
       args: ['chown -R <nonroot_userID> <mount_path>/*; find <mount_path>/ -type d -print -exec chmod u=+rwx,g=+rx {} \;']
       volumeMounts:
       - mountPath: "<mount_path>"
         name: cos-volume
     volumes:
     - name: cos-volume
       persistentVolumeClaim:
         claimName: <pvc_name>
    ```
    {: codeblock}

3. Créez le pod `fix-permission`.
   ```
   kubectl apply -f fix-permission.yaml
   ```
   {: pre}

4. Patientez jusqu'à ce que le pod passe à l'état `Completed`.  
   ```
   kubectl get pod fix-permission
   ```
   {: pre}

5. Supprimez le pod `fix-permission`.
   ```
   kubectl delete pod fix-permission
   ```
   {: pre}

5. Recréez le pod `test-permission` que vous avez utilisé auparavant pour vérifier les droits.
   ```
   kubectl apply -f test-permission.yaml
   ```
   {: pre}

5. Vérifiez que les droits de vos fichiers sont mis à jour.
   1. Connectez-vous à votre pod.
      ```
      kubectl exec test-permission -it bash
      ```
      {: pre}

   2. Accédez à votre chemin de montage et répertoriez les droits correspondant à vos fichiers.
      ```
      cd test && ls -al
      ```
      {: pre}

      Exemple de sortie :
      ```
      -rwxrwx--- 1 <nonroot_userID> root 6193 Aug 21 17:06 <file_name>
      ```
      {: screen}

6. Supprimez le pod `test-permission`.
   ```
   kubectl delete pod test-permission
   ```
   {: pre}

7. Montez la PVC sur l'application avec l'utilisateur non root.

   Définissez l'utilisateur non root sous `runAsUser` sans définir `fsGroup` dans votre fichier YAML de déploiement en même temps. Définir `fsGroup` déclenche la mise à jour par le plug-in {{site.data.keyword.cos_full_notm}} des droits du groupe pour tous les fichiers dans un compartiment lorsque le pod est déployé. La mise à jour des droits est une opération d'écriture qui peut empêcher votre pod de passer à l'état `Running` (en cours d'exécution).
   {: important}

Après avoir défini les droits de fichier corrects dans votre instance de service {{site.data.keyword.cos_full_notm}}, ne téléchargez pas de fichiers via la console ou l'API REST. Utilisez le plug-in {{site.data.keyword.cos_full_notm}} pour ajouter des fichiers dans votre instance de service.
{: tip}

<br />




## Aide et assistance
{: #storage_getting_help}

Vous avez encore des problèmes avec votre cluster ?
{: shortdesc}

-  Dans le terminal, vous êtes averti des mises à jour disponibles pour l'interface de ligne de commande `ibmcloud` et les plug-ins. Veillez à maintenir votre interface de ligne de commande à jour pour pouvoir utiliser l'ensemble des commandes et des indicateurs.
-   Pour voir si {{site.data.keyword.Bluemix_notm}} est disponible, [vérifiez la page Statut d'{{site.data.keyword.Bluemix_notm}} ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://cloud.ibm.com/status?selected=status).
-   Publiez une question sur le site [{{site.data.keyword.containerlong_notm}} Slack ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://ibm-container-service.slack.com).
    Si vous n'utilisez pas un ID IBM pour votre compte {{site.data.keyword.Bluemix_notm}}, [demandez une invitation](https://bxcs-slack-invite.mybluemix.net/) sur ce site Slack.
    {: tip}
-   Consultez les forums pour établir si d'autres utilisateurs ont rencontré le même problème. Lorsque vous utilisez les forums pour poser une question, balisez votre question de sorte que les équipes de développement {{site.data.keyword.Bluemix_notm}} la voient.
    -   Si vous avez des questions d'ordre technique sur le développement ou le déploiement de clusters ou d'applications à l'aide d'{{site.data.keyword.containerlong_notm}}, publiez-les sur le site [Stack Overflow ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://stackoverflow.com/questions/tagged/ibm-cloud+containers) en leur adjoignant les balises `ibm-cloud`, `kubernetes` et `containers`.
    -   Pour toute question sur le service et les instructions de mise en route, utilisez le forum [IBM Developer Answers ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://developer.ibm.com/answers/topics/containers/?smartspace=bluemix). Incluez les balises `ibm-cloud` et `containers`.
    Voir [Comment obtenir de l'aide](/docs/get-support?topic=get-support-getting-customer-support#using-avatar) pour plus d'informations sur l'utilisation des forums.
-   Contactez le support IBM en ouvrant un cas. Pour savoir comment ouvrir un cas de support IBM ou obtenir les niveaux de support et la gravité des cas, voir [Contacter le support](/docs/get-support?topic=get-support-getting-customer-support#getting-customer-support).
Lorsque vous signalez un problème, incluez l'ID de votre cluster. Pour identifier l'ID du cluster, exécutez la commande `ibmcloud ks clusters`. Vous pouvez également utiliser l'[outil de débogage et de diagnostic d'{{site.data.keyword.containerlong_notm}}](/docs/containers?topic=containers-cs_troubleshoot#debug_utility) pour regrouper et exporter des informations pertinentes de votre cluster à partager avec le support IBM.
{: tip}

