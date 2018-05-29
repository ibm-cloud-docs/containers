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
{:tsSymptoms: .tsSymptoms}
{:tsCauses: .tsCauses}
{:tsResolve: .tsResolve}


# Traitement des incidents liés aux clusters et aux noeuds worker
{: #cs_troubleshoot_clusters}

Lorsque vous utilisez {{site.data.keyword.containerlong}}, tenez compte de ces techniques pour identifier et résoudre les incidents liés à vos clusters et à vos noeuds worker.
{: shortdesc}

Si vous rencontrez un problème d'ordre plus général, expérimentez le [débogage de cluster](cs_troubleshoot.html).
{: tip}

## Impossible de se connecter à votre compte d'infrastructure
{: #cs_credentials}

{: tsSymptoms}
Lorsque vous créez un nouveau cluster Kubernetes, vous rencontrez le message suivant.

```
Nous n'avons pas pu nous connecter à votre compte d'infrastructure IBM Cloud.
La création d'un cluster standard nécessite un compte de type Paiement à la carte lié aux
conditions d'un compte de l'infrastructure IBM Cloud (SoftLayer) ou d'avoir utilisé l'interface de ligne de commande {{site.data.keyword.Bluemix_notm}}
Container Service pour définir vos clés d'API d'{{site.data.keyword.Bluemix_notm}} Infrastructure.
```
{: screen}

{: tsCauses}
Les utilisateurs disposant d'un compte {{site.data.keyword.Bluemix_notm}} non lié doivent créer un nouveau compte de type Paiement à la carte ou ajouter manuellement des clés d'API d'infrastructure IBM Cloud (SoftLayer) à l'aide de l'interface CLI d'{{site.data.keyword.Bluemix_notm}}.

{: tsResolve}
Pour ajouter des données d'identification à votre compte {{site.data.keyword.Bluemix_notm}} :

1.  Contactez l'administrateur de l'infrastructure IBM Cloud (SoftLayer) pour obtenir votre nom d'utilisateur d'infrastructure IBM Cloud (SoftLayer) et la clé d'API.

    **Remarque : ** le compte d'infrastructure IBM Cloud (SoftLayer) que vous utilisez doit être configuré avec des droits Superutilisateur pour vous permettre de créer des clusters standard.

2.  Ajoutez les données d'identification.

  ```
  bx cs credentials-set --infrastructure-username <username> --infrastructure-api-key <api_key>
  ```
  {: pre}

3.  Créez un cluster standard.

  ```
  bx cs cluster-create --location dal10 --public-vlan my_public_vlan_id --private-vlan my_private_vlan_id --machine-type u2c.2x4 --name my_cluster --hardware shared --workers 2
  ```
  {: pre}

<br />


## Le pare-feu empêche l'exécution de commandes via la ligne de commande
{: #ts_firewall_clis}

{: tsSymptoms}
Lorsque vous exécutez des commandes `bx`, `kubectl` ou `calicoctl` depuis l'interface de ligne de commande, ces commandes échouent.

{: tsCauses}
Des règles réseau d'entreprise empêchent peut-être l'accès depuis votre système local à des noeuds finaux publics via des proxies ou des pare-feux.

{: tsResolve}
[Autorisez l'accès TCP afin que les commandes CLI fonctionnent](cs_firewall.html#firewall). Cette tâche nécessite d'utiliser une [règle d'accès administrateur](cs_users.html#access_policies). Vérifiez votre [règle d'accès actuelle](cs_users.html#infra_access).


## Le pare-feu empêche le cluster de se connecter aux ressources
{: #cs_firewall}

{: tsSymptoms}
Lorsque les connexions des noeuds worker sont impossibles, vous pourrez voir toute une série de symptômes différents. Vous pourrez obtenir l'un des messages suivants en cas d'échec de la commande kubectl proxy ou si vous essayez d'accéder à un service dans votre cluster et que la connexion échoue.

  ```
  Connection refused
  ```
  {: screen}

  ```
  Connection timed out
  ```
  {: screen}

  ```
  Unable to connect to the server: net/http: TLS handshake timeout
  ```
  {: screen}

Si vous exécutez les commandes kubectl exec, attach ou logs, le message suivant peut s'afficher.

  ```
  Error from server: error dialing backend: dial tcp XXX.XXX.XXX:10250: getsockopt: connection timed out
  ```
  {: screen}

Si la commande kubectl proxy aboutit, mais que le tableau de bord n'est pas disponible, vous pourrez voir le message suivant.

  ```
  timeout on 172.xxx.xxx.xxx
  ```
  {: screen}



{: tsCauses}
Vous pouvez disposer d'un pare-feu supplémentaire configuré ou avoir personnalisé vos paramètres de pare-feu existants dans votre compte d'infrastructure IBM Cloud (SoftLayer). {{site.data.keyword.containershort_notm}} requiert que certaines adresses IP et certains ports soient ouverts pour permettre la communication entre le noeud worker et le maître Kubernetes et inversement. Une autre cause peut être que les noeuds worker soient bloqués dans une boucle de rechargement.

{: tsResolve}
[Autorisez le cluster à accéder aux ressources d'infrastructure et à d'autres services](cs_firewall.html#firewall_outbound). Cette tâche nécessite d'utiliser une [règle d'accès administrateur](cs_users.html#access_policies). Vérifiez votre [règle d'accès actuelle](cs_users.html#infra_access).

<br />



## L'accès à votre noeud worker à l'aide de SSH échoue
{: #cs_ssh_worker}

{: tsSymptoms}
Vous ne pouvez pas accéder à votre noeud worker à l'aide d'une connexion SSH.

{: tsCauses}
L'accès SSH via un mot de passe est désactivé sur les noeuds worker.

{: tsResolve}
Utilisez des [DaemonSets ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) pour tout ce que vous devez exécuter sur chaque noeud ou des travaux pour toutes les actions ponctuelles que vous devez exécuter.

<br />



## La liaison d'un service à un cluster renvoie une erreur due à une utilisation du même nom
{: #cs_duplicate_services}

{: tsSymptoms}
Lorsque vous exécutez la commande `bx cs cluster-service-bind <cluster_name> <namespace> <service_instance_name>`, le message suivant s'affiche.

```
Multiple services with the same name were found.
Run 'bx service list' to view available Bluemix service instances...
```
{: screen}

{: tsCauses}
Il se peut que plusieurs instances de service aient le même nom dans différentes régions.

{: tsResolve}
Utilisez l'identificateur global unique (GUID) du service au lieu du nom de l'instance de service dans la commande `bx cs cluster-service-bind`.

1. [Connectez-vous à la région hébergeant l'instance de service à lier.](cs_regions.html#bluemix_regions)

2. Extrayez l'identificateur global unique (GUID) de l'instance de service.
  ```
  bx service show <service_instance_name> --guid
  ```
  {: pre}

  Sortie :
  ```
  Invoking 'cf service <service_instance_name> --guid'...
  <service_instance_GUID>
  ```
  {: screen}
3. Liez à nouveau le service au cluster.
  ```
  bx cs cluster-service-bind <cluster_name> <namespace> <service_instance_GUID>
  ```
  {: pre}

<br />



## Après avoir mis à jour ou rechargé un noeud worker, des noeuds et des pods en double apparaissent
{: #cs_duplicate_nodes}

{: tsSymptoms}
Lorsque vous exécutez la commande `kubectl get nodes`, vous voyez des noeuds worker en double avec le statut **NotReady**. Les noeuds worker avec le statut **NotReady** ont des adresses IP publiques, alors que les noeuds worker avec le statut **Ready** ont des adresses IP privées.

{: tsCauses}
D'anciens clusters avaient des noeuds worker répertoriés par l'adresse IP publique du cluster. A présent, les noeuds worker sont répertoriés par l'adresse IP privée du cluster. Lorsque vous rechargez ou mettez à jour un noeud, l'adresse IP est modifiée, mais la référence à l'adresse IP publique est conservée.

{: tsResolve}
Il n'y a aucune interruption de service due à ces doublons, mais vous devez retirer les références des anciens noeuds worker du serveur d'API.

  ```
  kubectl delete node <node_name1> <node_name2>
  ```
  {: pre}

<br />


## Après avoir mis à jour ou rechargé un noeud worker, les applications reçoivent des erreurs de type RBAC DENY
{: #cs_rbac_deny}

{: tsSymptoms}
Après la mise à jour vers Kubernetes version 1.7, les applications reçoivent des erreurs de type `RBAC DENY`.

{: tsCauses}
A partir de [Kubernetes version 1.7](cs_versions.html#cs_v17), les applications qui s'exécutent dans l'espace de nom `default` ne disposent plus des privilèges d'administrateur de cluster sur l'API Kubernetes pour la sécurité renforcée.

Si votre application s'exécute dans l'espace de nom `default`, utilise le compte `default ServiceAccount` et accède à l'API Kubernetes, elle est affectée par cette modification de Kubernetes. Pour plus d'informations, voir [la documentation Kubernetes![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/admin/authorization/rbac/#upgrading-from-15).

{: tsResolve}
Avant de commencer, [ciblez avec votre interface de ligne de commande](cs_cli_install.html#cs_cli_configure) votre cluster.

1.  **Action temporaire** : lorsque vous mettez à jour les règles RBAC de votre application, vous souhaiterez peut-être rétablir temporairement l'autorisation `ClusterRoleBinding` précédente pour le compte `default ServiceAccount` dans l'espace de nom `default`.

    1.  Copiez le fichier `.yaml` suivant.

        ```yaml
        kind: ClusterRoleBinding
        apiVersion: rbac.authorization.k8s.io/v1beta1
        metadata:
         name: admin-binding-nonResourceURLSs-default
        subjects:
          - kind: ServiceAccount
            name: default
            namespace: default
        roleRef:
         kind: ClusterRole
         name: admin-role-nonResourceURLSs
         apiGroup: rbac.authorization.k8s.io
        ---
        kind: ClusterRoleBinding
        apiVersion: rbac.authorization.k8s.io/v1beta1
        metadata:
         name: admin-binding-resourceURLSs-default
        subjects:
          - kind: ServiceAccount
            name: default
            namespace: default
        roleRef:
         kind: ClusterRole
         name: admin-role-resourceURLSs
         apiGroup: rbac.authorization.k8s.io
        ```

    2.  Appliquez le fichier `.yaml` à votre cluster.

        ```
        kubectl apply -f FILENAME
        ```
        {: pre}

2.  [Créez des ressources d'autorisation RBAC![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/admin/authorization/rbac/#api-overview) pour mettre à jour l'accès administrateur `ClusterRoleBinding`.

3.  Si vous avez créé une liaison de rôle de cluster temporaire, supprimez-la.

<br />


## Echec de l'accès à un pod sur un nouveau noeud worker et dépassement du délai d'attente
{: #cs_nodes_duplicate_ip}

{: tsSymptoms}
Vous avez supprimé un noeud worker dans votre cluster et ajouté un noeud worker. Lorsque vous avez déployé un pod ou un service Kubernetes, la ressource n'a pas pu accéder au noeud worker nouvellement créé et un dépassement de délai d'attente s'est produit pour la connexion.

{: tsCauses}
Si vous supprimez un noeud worker de votre cluster et que vous ajoutez un noeud worker, il se peut que l'adresse IP privée du noeud worker supprimé soit affectée au nouveau noeud worker. Calico utilise cette adresse IP privée en tant que balise et continue d'essayer d'atteindre le noeud supprimé.

{: tsResolve}
Mettez manuellement à jour la référence de l'adresse IP privée pour qu'elle pointe vers le noeud approprié.

1.  Vérifiez que vous possédez deux noeuds worker associés à la même **adresse IP privée**. Notez l'**adresse IP privée** et l'**ID** du noeud worker supprimé.

  ```
  bx cs workers <CLUSTER_NAME>
  ```
  {: pre}

  ```
  ID                                                 Public IP       Private IP       Machine Type   State     Status   Location   Version
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w1   169.xx.xxx.xxx  10.xxx.xx.xxx    b2c.4x16       normal    Ready    dal10      1.8.11
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w2   169.xx.xxx.xxx  10.xxx.xx.xxx    b2c.4x16       deleted    -       dal10      1.8.11
  ```
  {: screen}

2.  Installez l'[interface de ligne de commande Calico](cs_network_policy.html#adding_network_policies).
3.  Répertoriez les noeuds worker disponibles dans Calico. Remplacez <path_to_file> par le chemin d'accès local au fichier de configuration Calico.

  ```
  calicoctl get nodes --config=filepath/calicoctl.cfg
  ```
  {: pre}

  ```
  NAME
  kube-dal10-cr9b7371a7faaa46d08e04f046d5e6d8b4-w1
  kube-dal10-cr9b7371a7faaa46d08e04f046d5e6d8b4-w2
  ```
  {: screen}

4.  Supprimez le noeud worker en double dans Calico. Remplacez NODE_ID par l'ID du noeud worker.

  ```
  calicoctl delete node NODE_ID --config=<path_to_file>/calicoctl.cfg
  ```
  {: pre}

5.  Redémarre le noeud worker qui n'a pas été supprimé.

  ```
  bx cs worker-reboot CLUSTER_ID NODE_ID
  ```
  {: pre}


Le noeud supprimé n'apparaît plus dans Calico.

<br />


## Le cluster reste à l'état En attente
{: #cs_cluster_pending}

{: tsSymptoms}
Lorsque vous déployez votre cluster, il reste à l'état en attente (pending) et ne démarre pas.

{: tsCauses}
Si vous venez de créer le cluster, les noeuds worker sont peut-être encore en cours de configuration. Si vous attendez depuis un bon moment, il est possible que votre réseau local virtuel (VLAN) soit non valide.

{: tsResolve}

Vous pouvez envisager l'une des solutions suivantes :
  - Vérifiez le statut de votre cluster en exécutant la commande `bx cs clusters`. Puis vérifiez que vos noeuds worker sont déployés en exécutant la commande `bx cs workers <cluster_name>`.
  - Vérifiez si votre réseau local virtuel (VLAN) est valide. Pour être valide, un VLAN doit être associé à une infrastructure pouvant héberger un noeud worker avec un stockage sur disque local. Vous pouvez [afficher la liste de vos VLAN](/docs/containers/cs_cli_reference.html#cs_vlans) en exécutant la commande `bx cs vlans LOCATION`. Si le VLAN n'apparaît pas dans la liste, il n'est pas valide. Choisissez-en un autre.

<br />


## Des pods sont toujours à l'état en attente
{: #cs_pods_pending}

{: tsSymptoms}
Lorsque vous exécutez `kubectl get pods`, vous constatez que des pods sont toujours à l'état en attente (**pending**).

{: tsCauses}
Si vous venez juste de créer le cluster Kubernetes, il se peut que les noeuds worker soient encore en phase de configuration. S'il s'agit d'un cluster existant, sa capacité est peut-être insuffisante pour y déployer le pod.

{: tsResolve}
Cette tâche nécessite d'utiliser une [règle d'accès administrateur](cs_users.html#access_policies). Vérifiez votre [règle d'accès actuelle](cs_users.html#infra_access).

Si vous venez de créer le cluster Kubernetes, exécutez la commande suivante et attendez l'initialisation des noeuds worker.

```
kubectl get nodes
```
{: pre}

S'il s'agit d'un cluster existant, vérifiez sa capacité.

1.  Définissez le proxy avec le numéro de port par défaut.

  ```
  kubectl proxy
  ```
   {: pre}

2.  Ouvrez le tableau de bord Kubernetes.

  ```
  http://localhost:8001/ui
  ```
  {: pre}

3.  Vérifiez que vous disposez de suffisamment de capacité dans votre cluster pour déployer le pod.

4.  Si vous ne disposez pas de suffisamment de capacité dans votre cluster, ajoutez un autre noeud worker à celui-ci.

  ```
  bx cs worker-add <cluster_name_or_ID> 1
  ```
  {: pre}

5.  Si vos pods sont toujours à l'état **pending** après le déploiement complet du noeud worker, consultez la [documentation Kubernetes ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/tasks/debug-application-cluster/debug-pod-replication-controller/#my-pod-stays-pending) pour effectuer d'autres tâches en vue d'identifier et de résoudre le problème.

<br />




## Les conteneurs ne démarrent pas
{: #containers_do_not_start}

{: tsSymptoms}
Les pods se déploient sur les clusters, mais les conteneurs ne démarrent pas.

{: tsCauses}
Il peut arriver que les conteneurs ne démarrent pas lorsque le quota de registre est atteint.

{: tsResolve}
[Libérez de l'espace de stockage dans {{site.data.keyword.registryshort_notm}}.](../services/Registry/registry_quota.html#registry_quota_freeup)

<br />



## Impossible d'installer une charte Helm avec les valeurs de configuration mises à jour
{: #cs_helm_install}

{: tsSymptoms}
Lorsque vous essayez d'installer une charte Helm en exécutant la commande `helm install -f config.yaml --namespace=kube-system --name=<release_name> ibm/<chart_name>`, vous obtenez le message d'erreur `Error: failed to download "ibm/<chart_name>"`.

{: tsCauses}
L'adresse URL du référentiel {{site.data.keyword.Bluemix_notm}} dans votre instance Helm est peut-être incorrecte.

{: tsResolve}
Pour identifier et résoudre les problèmes liés à votre charte Helm :

1. Affichez la liste des référentiels actuellement disponibles dans votre instance Helm.

    ```
    helm repo list
    ```
    {: pre}

2. Dans la sortie, vérifiez que l'URL du référentiel {{site.data.keyword.Bluemix_notm}}, `ibm` est `https://registry.bluemix.net/helm/ibm`.

    ```
    NAME    URL
    stable  https://kubernetes-charts.storage.googleapis.com
    local   http://127.0.0.1:8888/charts
    ibm     https://registry.bluemix.net/helm/ibm
    ```
    {: screen}

    * Si l'URL n'est pas correcte :

        1. Retirez le référentiel {{site.data.keyword.Bluemix_notm}}.

            ```
            helm repo remove ibm
            ```
            {: pre}

        2. Ajoutez à nouveau le référentiel {{site.data.keyword.Bluemix_notm}}.

            ```
            helm repo add ibm  https://registry.bluemix.net/helm/ibm
            ```
            {: pre}

    * Si l'URL est correcte, obtenez les dernières mises à jour du référentiel.

        ```
        helm repo update
        ```
        {: pre}

3. Installez la charte Helm avec vos mises à jour.

    ```
    helm install -f config.yaml --namespace=kube-system --name=<release_name> ibm/<chart_name>
    ```
    {: pre}


<br />


## Aide et assistance
{: #ts_getting_help}

Vous avez encore des problèmes avec votre cluster ?
{: shortdesc}

-   Pour déterminer si {{site.data.keyword.Bluemix_notm}} est disponible, [consultez la page de statut d'{{site.data.keyword.Bluemix_notm}} ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://developer.ibm.com/bluemix/support/#status).
-   Publiez une question sur le site [{{site.data.keyword.containershort_notm}} Slack. ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://ibm-container-service.slack.com)
    Si vous n'utilisez pas un ID IBM pour votre compte {{site.data.keyword.Bluemix_notm}}, [demandez une invitation](https://bxcs-slack-invite.mybluemix.net/) sur ce site Slack.
    {: tip}
-   Consultez les forums pour établir si d'autres utilisateurs ont rencontré le même problème. Lorsque vous utilisez les forums pour poser une question, balisez votre question de sorte que les équipes de développement {{site.data.keyword.Bluemix_notm}} la voient.

    -   Si vous avez des questions d'ordre technique sur le développement ou le déploiement de clusters ou d'applications à l'aide d'{{site.data.keyword.containershort_notm}}, publiez-les sur le site [Stack Overflow ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://stackoverflow.com/questions/tagged/ibm-cloud+containers) en leur adjoignant les balises `ibm-cloud`, `kubernetes` et `containers`.
    -   Pour des questions relatives au service et aux instructions de mise en route, utilisez le forum [IBM developerWorks dW Answers ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://developer.ibm.com/answers/topics/containers/?smartspace=bluemix). Incluez les balises `ibm-cloud` et `containers`.
    Voir [Comment obtenir de l'aide](/docs/get-support/howtogetsupport.html#using-avatar)
pour plus d'informations sur l'utilisation des forums.

-   Contactez le support IBM en ouvrant un ticket de demande de service. Pour plus d'informations sur l'ouverture d'un ticket de demande de service IBM, sur les niveaux de support disponibles ou les niveaux de gravité des tickets, voir la rubrique décrivant [comment contacter le support](/docs/get-support/howtogetsupport.html#getting-customer-support).

{:tip}
Lorsque vous signalez un problème, incluez l'ID de votre cluster. Pour identifier l'ID du cluster, exécutez la commande `bx cs clusters`.


