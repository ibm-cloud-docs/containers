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
{:tsSymptoms: .tsSymptoms}
{:tsCauses: .tsCauses}
{:tsResolve: .tsResolve}



# Traitement des incidents liés aux clusters et aux noeuds worker
{: #cs_troubleshoot_clusters}

Lorsque vous utilisez {{site.data.keyword.containerlong}}, tenez compte de ces techniques pour identifier et résoudre les incidents liés à vos clusters et à vos noeuds worker.
{: shortdesc}

Si vous rencontrez un problème d'ordre plus général, expérimentez le [débogage de cluster](cs_troubleshoot.html).
{: tip}

## Impossible de créer un cluster suite à des erreurs de droits
{: #cs_credentials}

{: tsSymptoms}
Lorsque vous créez un nouveau cluster Kubernetes, vous recevez un message d'erreur de ce type :

```
Nous n'avons pas pu nous connecter à votre compte d'infrastructure IBM Cloud.
La création d'un cluster standard nécessite un compte de type Paiement à la carte lié aux
conditions d'un compte d'infrastructure IBM Cloud (SoftLayer) ou l'utilisation de l'interface de ligne de commande {{site.data.keyword.containerlong_notm}} pour définir vos clés d'API d'infrastructure {{site.data.keyword.Bluemix_notm}}.
```
{: screen}

```
Exception liée à l'infrastructure {{site.data.keyword.Bluemix_notm}} : des droits sont nécessaires pour réserver 'Item'.
```
{: screen}

```
Exception liée à l'infrastructure {{site.data.keyword.Bluemix_notm}} : l'utilisateur ne dispose pas des droits sur l'infrastructure {{site.data.keyword.Bluemix_notm}} nécessaires pour ajouter des serveurs
```
{: screen}

```
Echec de la demande d'échange de jetons IAM : Impossible de créer un jeton de portail IMS, car aucun compte IMS n'est lié au compte BSS sélectionné
```
{: screen}

```
Le cluster n'a pas pu être configuré avec le registre. Vérifiez que vous disposez du rôle Administrateur pour {{site.data.keyword.registrylong_notm}}.
```
{: screen}

{: tsCauses}
Vous ne disposez pas des droits adéquats pour créer un cluster. Vous avez besoin des droits suivants pour créer un cluster :
*  Rôle **Superutilisateur** pour l'infrastructure IBM Cloud (SoftLayer).
*  Rôle de gestion de plateforme **Administrateur** pour {{site.data.keyword.containerlong_notm}} au niveau du compte.
*  Rôle de gestion de plateforme **Administrateur** pour {{site.data.keyword.registrylong_notm}} au niveau du compte. Ne limitez pas les règles d'{{site.data.keyword.registryshort_notm}} au niveau du groupe de ressources. Si vous avez commencé à utiliser {{site.data.keyword.registrylong_notm}} avant le 4 octobre 2018, veillez à [activer l'application des règles {{site.data.keyword.Bluemix_notm}} IAM](/docs/services/Registry/registry_users.html#existing_users).

Pour les erreurs liées à l'infrastructure, les comptes Paiement à la carte d'{{site.data.keyword.Bluemix_notm}} créés après l'activation de la liaison automatique de compte sont déjà configurés avec l'accès au portefeuille d'infrastructure IBM Cloud (SoftLayer). Vous pouvez acheter des ressources d'infrastructure pour votre cluster sans configuration supplémentaire. Si vous disposez d'un compte Paiement à la carte et recevez ce message d'erreur, il est possible que vous n'utilisez pas les données d'identification du compte d'infrastructure IBM Cloud (SoftLayer) appropriées pour accéder aux ressources d'infrastructure.

Les utilisateurs disposant d'autres types de compte {{site.data.keyword.Bluemix_notm}} doivent configurer leurs comptes pour créer des clusters standard. Exemples de cas de figure où vous pouvez disposer d'un autre type de compte :
* Vous disposez d'un compte d'infrastructure IBM Cloud (SoftLayer) antérieur à votre compte de plateforme {{site.data.keyword.Bluemix_notm}} et vous souhaitez continuer à l'utiliser.
* Vous désirez utiliser un autre compte d'infrastructure IBM Cloud (SoftLayer) pour mettre à disposition des ressources d'infrastructure dedans. Par exemple, vous pouvez configurer un compte {{site.data.keyword.Bluemix_notm}} pour une équipe afin d'utiliser un compte d'infrastructure distinct pour la facturation.

Si vous utilisez un autre compte d'infrastructure IBM Cloud (SoftLayer) pour mettre à disposition des ressources d'infrastructure, vous risquez d'avoir des [clusters orphelins](#orphaned) dans votre compte.

{: tsResolve}
Le propriétaire de compte doit configurer correctement les données d'identification du compte d'infrastructure. Ces données dépendent du type de compte d'infrastructure que vous utilisez.

1.  Vérifiez que vous avez accès à un compte d'infrastructure. Connectez-vous à la [console {{site.data.keyword.Bluemix_notm}}![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://console.bluemix.net/) et dans le menu ![Icône de menu](../icons/icon_hamburger.svg "Icône de menu"), cliquez sur **Infrastructure**. Si vous voyez le tableau de bord Infrastructure, vous avez accès à un compte d'infrastructure.
2.  Vérifiez si votre cluster utilise un autre compte d'infrastructure que celui qui est fourni avec votre compte de paiement à la carte.
    1.  Dans le menu ![Icône de menu](../icons/icon_hamburger.svg "Icône de menu"), cliquez sur **Conteneurs > Clusters**.
    2.  Dans le tableau, sélectionnez votre cluster.
    3.  Dans l'onglet **Vue d'ensemble**, recherchez une zone correspondant à un **utilisateur d'infrastructure**.
        * Si vous ne voyez pas la zone de l'**utilisateur d'infrastructure**, vous disposez d'un compte de paiement à la carte qui utilise les mêmes données d'identification pour vos comptes d'infrastructure et de plateforme.
        * Si vous voyez une zone d'**utilisateur d'infrastructure**, votre cluster utilise un autre compte d'infrastructure que celui qui est fourni avec votre compte de paiement à la carte. Ces données d'identification s'appliquent à tous les clusters de la région.
3.  Décidez du type de compte que vous voulez obtenir pour déterminer comment identifier et résoudre les incidents liés aux droits d'accès de l'infrastructure. Pour la plupart des utilisateurs, le compte de paiement à la carte lié par défaut suffit.
    *  Compte de paiement à la carte {{site.data.keyword.Bluemix_notm}} lié : [vérifiez que la clé d'API est configurée les droits appropriés](cs_users.html#default_account). Si votre cluster utilise un autre compte d'infrastructure, vous devez annuler la définition des données d'identification dans le cadre de ce processus.
    *  Comptes de plateforme et d'infrastructure {{site.data.keyword.Bluemix_notm}} différents : vérifiez que vous pouvez accéder au portefeuille de l'infrastructure et que [les données d'identification du compte d'infrastructure sont définies avec les droits appropriés](cs_users.html#credentials).
4.  Si vous ne pouvez pas voir les noeuds worker du cluster dans votre compte d'infrastructure, vous pouvez vérifier si le [cluster est orphelin](#orphaned).

<br />


## Le pare-feu empêche l'exécution de commandes via la ligne de commande
{: #ts_firewall_clis}

{: tsSymptoms}
Lorsque vous exécutez des commandes `ibmcloud`, `kubectl` ou `calicoctl` depuis l'interface de ligne de commande, ces commandes échouent.

{: tsCauses}
Des règles réseau d'entreprise empêchent peut-être l'accès depuis votre système local à des noeuds finaux publics via des proxys ou des pare-feux.

{: tsResolve}
[Autorisez l'accès TCP afin que les commandes CLI fonctionnent](cs_firewall.html#firewall_bx). Cette tâche nécessite le [rôle de plateforme {{site.data.keyword.Bluemix_notm}} IAM **Administrateur**](cs_users.html#platform) pour le cluster.


## Le pare-feu empêche le cluster de se connecter aux ressources
{: #cs_firewall}

{: tsSymptoms}
Lorsque les connexions des noeuds worker sont impossibles, vous pouvez voir toute une variété de symptômes différents. Vous pourrez obtenir l'un des messages suivants en cas d'échec de la commande kubectl proxy ou si vous essayez d'accéder à un service dans votre cluster et que la connexion échoue.

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
Vous pouvez disposer d'un autre pare-feu configuré ou avoir personnalisé vos paramètres de pare-feu existants dans votre compte d'infrastructure IBM Cloud (SoftLayer). {{site.data.keyword.containerlong_notm}} requiert que certaines adresses IP et certains ports soient ouverts pour permettre la communication entre le noeud worker et le maître Kubernetes et inversement. Une autre cause peut être que les noeuds worker soient bloqués dans une boucle de rechargement.

{: tsResolve}
[Autorisez le cluster à accéder aux ressources d'infrastructure et à d'autres services](cs_firewall.html#firewall_outbound). Cette tâche nécessite le [rôle de plateforme {{site.data.keyword.Bluemix_notm}} IAM **Administrateur**](cs_users.html#platform) pour le cluster.

<br />



## Impossible de visualiser ou d'utiliser un cluster
{: #cs_cluster_access}

{: tsSymptoms}
* Vous ne parvenez pas à trouver un cluster. Lorsque vous exécutez la commande `ibmcloud ks clusters`, le cluster n'apparaît pas dans le résultat.
* Vous n'êtes pas en mesure d'utiliser un cluster. Lorsque vous exécutez la commande `ibmcloud ks cluster-config` ou d'autres commandes spécifiques au cluster, le cluster est introuvable.


{: tsCauses}
Dans {{site.data.keyword.Bluemix_notm}}, chaque ressource doit figurer dans un groupe de ressources. Par exemple, le cluster `mycluster` doit exister dans le groupe de ressources `default`. Lorsque le propriétaire du compte vous donne accès aux ressources en vous affectant un rôle de plateforme {{site.data.keyword.Bluemix_notm}} IAM, l'accès peut être octroyé à une ressource spécifique ou au groupe de ressources. Lorsque l'accès à une ressource spécifique vous a été octroyé, vous n'avez pas accès au groupe de ressources. Dans ce cas, vous n'avez pas besoin de cibler un groupe de ressource pour utiliser les clusters auxquels vous avez accès. Si vous ciblez un autre groupe de ressources que le groupe dans lequel figure le cluster, les actions par rapport à ce cluster risquent d'échouer. Inversement, lorsque l'accès à une ressource vous est affecté dans le cadre de votre accès à un groupe de ressources, vous devez cibler un groupe de ressources pour utiliser un cluster dans ce groupe. Si vous ne ciblez pas votre session d'interface de ligne de commande sur le groupe de ressources dans lequel figure le cluster, les actions par rapport à ce cluster risquent d'échouer.

Si vous ne pouvez pas trouver ou utiliser un cluster, vous pouvez rencontrer les problèmes suivants :
* Vous avez accès au cluster et au groupe de ressources dans lequel figure le cluster mais votre session d'interface de ligne de commande n'est pas ciblée sur le groupe de ressources hébergeant le cluster.
* Vous avez accès au cluster mais pas dans le cadre du groupe de ressources dans lequel figure le cluster. Votre session d'interface de ligne de commande est ciblée sur ce groupe de ressources ou un autre groupe de ressources.
* Vous n'avez pas accès au cluster.

{: tsResolve}
Pour vérifier vos droits d'accès utilisateur :

1. Répertoriez tous les droits utilisateur dont vous disposez.
    ```
    ibmcloud iam user-policies <your_user_name>
    ```
    {: pre}

2. Vérifiez si vous avez accès au cluster et au groupe de ressources dans lequel figure le cluster.
    1. Recherchez une règle ayant une valeur **Resource Group Name** pour le groupe de ressources du cluster et une valeur **Memo** correspondant à `Policy applies to the resource group`. Si vous avez cette règle, vous avez accès au groupe de ressources. Par exemple, cette règle indique qu'un utilisateur a accès au groupe de ressources `test-rg` :
        ```
        Policy ID:   3ec2c069-fc64-4916-af9e-e6f318e2a16c
        Roles:       Viewer
        Resources:
                     Resource Group ID     50c9b81c983e438b8e42b2e8eca04065
                     Resource Group Name   test-rg
                     Memo                  Policy applies to the resource group
        ```
        {: screen}
    2. Recherchez une règle ayant une valeur **Resource Group Name** pour le groupe de ressources du cluster, une valeur de **Service Name** correspondant à `containers-kubernetes` ou aucune valeur, et une valeur de **Memo** correspondant à `Policy applies to the resource(s) within the resource group`. Si vous trouvez cette règle, vous avez accès aux clusters ou à toutes les ressources au sein du groupe de ressources. Par exemple, cette règle indique qu'un utilisateur a accès aux clusters du groupe de ressources `test-rg` :
        ```
        Policy ID:   e0ad889d-56ba-416c-89ae-a03f3cd8eeea
        Roles:       Administrator
        Resources:
                     Resource Group ID     a8a12accd63b437bbd6d58fb6a462ca7
                     Resource Group Name   test-rg
                     Service Name          containers-kubernetes
                     Service Instance
                     Region
                     Resource Type
                     Resource
                     Memo                  Policy applies to the resource(s) within the resource group
        ```
        {: screen}
    3. Si vous disposez de ces deux règles, passez au premier point de l'étape 4. Si vous ne disposez pas de la règle de l'étape 2a et que vous disposez de la règle de l'étape 2b, passez au deuxième point de l'étape 4. Si vous ne disposez d'aucune de ces règles, passez à l'étape 3.

3. Vérifiez si vous avez accès au cluster mais pas dans le cadre de l'accès au groupe de ressources dans lequel figure le cluster.
    1. Recherchez la règle n'ayant aucune valeur pour les zones **Policy ID** et **Roles**. Si vous disposez de cette règle, vous avez accès au cluster dans le cadre de l'accès à votre compte complet. Par exemple, cette règle indique qu'un utilisateur a accès à toutes les ressources du compte :
        ```
        Policy ID:   8898bdfd-d520-49a7-85f8-c0d382c4934e
        Roles:       Administrator, Manager
        Resources:
                     Service Name
                     Service Instance
                     Region
                     Resource Type
                     Resource
        ```
        {: screen}
    2. Recherchez une règle dont la valeur de **Service Name** est `containers-kubernetes` et la valeur de **Service Instance** correspond à l'ID du cluster. Vous pouvez obtenir l'ID d'un cluster en exécutant la commande `ibmcloud ks cluster-get <cluster_name>`. Par exemple, cette règle indique qu'un utilisateur a accès à un cluster spécifique :
        ```
        Policy ID:   140555ce-93ac-4fb2-b15d-6ad726795d90
        Roles:       Administrator
        Resources:
                     Service Name       containers-kubernetes
                     Service Instance   df253b6025d64944ab99ed63bb4567b6
                     Region
                     Resource Type
                     Resource
        ```
        {: screen}
    3. Si vous disposez de l'une de ces règles, passez au second point de l'étape 4. Si vous n'avez aucune de ces règles, passez au troisième point de l'étape 4.

4. En fonction de vos règles d'accès, choisissez l'une des options suivantes.
    * Si vous avez accès au cluster et au groupe de ressources dans lequel figure le cluster :
      1. Ciblez le groupe de ressources. **Remarque** : vous ne pouvez pas utiliser les clusters d'autres groupes de ressources tant que vous ciblez ce groupe de ressources.
          ```
          ibmcloud target -g <resource_group>
          ```
          {: pre}

      2. Ciblez le cluster.
          ```
          ibmcloud ks cluster-config <cluster_name_or_ID>
          ```
          {: pre}

    * Si vous avez accès au cluster mais pas au groupe de ressources dans lequel figure le cluster :
      1. Ne ciblez pas de groupe de ressources. Si vous avez déjà ciblé un groupe de ressources, ne le ciblez plus :
        ```
        ibmcloud target -g none
        ```
        {: pre}
        Cette commande échoue car il n'existe aucun groupe de ressources nommé `none`. Cependant, le groupe de ressources en cours n'est plus ciblé lorsque la commande échoue.

      2. Ciblez le cluster.
        ```
        ibmcloud ks cluster-config <cluster_name_or_ID>
        ```
        {: pre}

    * Si vous n'avez pas accès au cluster :
        1. Demandez à votre propriétaire de compte de vous affecter un [rôle de plateforme {{site.data.keyword.Bluemix_notm}} IAM](cs_users.html#platform) pour ce cluster.
        2. Ne ciblez pas de groupe de ressources. Si vous avez déjà ciblé un groupe de ressources, arrêtez de le cibler :
          ```
          ibmcloud target -g none
          ```
          {: pre}
          Cette commande échoue car il n'existe aucun groupe de ressources nommé `none`. Cependant, le groupe de ressources en cours n'est plus ciblé lorsque la commande échoue.
        3. Ciblez le cluster.
          ```
          ibmcloud ks cluster-config <cluster_name_or_ID>
          ```
          {: pre}

<br />


## L'accès à votre noeud worker à l'aide de SSH échoue
{: #cs_ssh_worker}

{: tsSymptoms}
Vous ne pouvez pas accéder à votre noeud worker à l'aide d'une connexion SSH.

{: tsCauses}
La connexion SSH par mot de passe n'est pas disponible sur les noeuds worker.

{: tsResolve}
Utilisez un objet Kubernetes [`DaemonSet` ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) pour les actions que vous devez effectuer sur tous les noeuds, ou utilisez des travaux pour les actions à usage unique que vous devez exécuter.

<br />


## L'ID d'instance bare metal n'est pas cohérent avec les enregistrements de noeuds worker
{: #bm_machine_id}

{: tsSymptoms}
Lorsque vous utilisez des commandes `ibmcloud ks worker` avec votre noeud worker bare metal, vous obtenez un message de ce type :

```
Instance ID inconsistent with worker records
```
{: screen}

{: tsCauses}
L'ID de la machine peut devenir incohérent avec l'enregistrement du noeud worker {{site.data.keyword.containerlong_notm}} lorsque cette machine fait l'objet de problèmes matériel. Lorsque l'infrastructure IBM Cloud (SoftLayer) résout un problème de ce type, un composant peut être remplacé dans le système et le service ne parvient pas à l'identifier.

{: tsResolve}
Pour qu'{{site.data.keyword.containerlong_notm}} identifie à nouveau cette machine, [rechargez le noeud worker bare metal](cs_cli_reference.html#cs_worker_reload). **Remarque** : l'opération de rechargement met également à jour la [version du correctif](cs_versions_changelog.html).

Vous pouvez également [supprimer le noeud worker bare metal](cs_cli_reference.html#cs_cluster_rm). **Remarque** : les instances bare metal sont facturées au mois.

<br />


## Impossible de modifier ou de supprimer des ressources d'infrastructure dans un cluster orphelin
{: #orphaned}

{: tsSymptoms}
Vous ne parvenez pas à exécuter des commandes liées à l'infrastructure sur votre cluster, par exemple :
* Ajouter ou retirer des noeuds worker
* Recharger ou réamorcer des noeuds worker
* Redimensionner des pools de noeuds worker
* Mettre à jour votre cluster

Vous ne pouvez pas visualiser les noeuds worker du cluster dans votre compte d'infrastructure IBM Cloud (SoftLayer). Cependant, vous ne pouvez pas mettre à jour et gérer d'autres clusters du compte.

De plus, vous avez vérifié que vous disposiez des [données d'identification d'infrastructure appropriées](#cs_credentials).

{: tsCauses}
Il se peut que le cluster soit mis à disposition dans un compte d'infrastructure IBM Cloud (SoftLayer) qui n'est plus lié à votre compte {{site.data.keyword.containerlong_notm}}. Le cluster est orphelin. Comme les ressources se trouvent dans un autre compte, vous ne disposez pas des données d'identification requises pour modifier ces ressources.

Considérez le scénario suivant pour savoir comment les clusters peuvent devenir orphelins.
1.  Vous disposez d'un compte {{site.data.keyword.Bluemix_notm}} Paiement à la carte.
2.  Vous créez un cluster nommé `Cluster1`. Les noeuds worker et d'autres ressources d'infrastructure sont mises à disposition dans le compte d'infrastructure fourni avec votre compte Paiement à la carte.
3.  Par la suite, vous constatez que votre équipe utilise un compte d'infrastructure IBM Cloud (SoftLayer) existant ou partagé. Vous utilisez la commande `ibmcloud ks credential-set` pour modifier les données d'identification du compte d'infrastructure IBM Cloud (SoftLayer) afin d'utiliser le compte de votre équipe.
4.  Vous créez un autre cluster nommé `Cluster2`. Les noeuds worker et d'autres ressources d'infrastructure sont mises à disposition dans le compte d'infrastructure de l'équipe.
5.  Vous remarquez que le cluster `Cluster1` nécessite une mise à jour ou un rechargement de noeud worker ou vous voulez juste le nettoyer en le supprimant. Cependant, comme `Cluster1` a été mis à disposition dans un autre compte d'infrastructure, vous ne pouvez pas modifier ses ressources d'infrastructure. `Cluster1` est un cluster orphelin.
6.  Vous suivez les étapes de résolution dans la section suivante, sans redéfinir vos données d'identification dans le compte de votre équipe. Vous pouvez supprimer `Cluster1`, mais `Cluster2` est orphelin.
7.  Vous restaurez vos données d'identification du compte d'infrastructure dans le compte de l'équipe qui a créé `Cluster2`. Désormais vous n'avez plus de cluster orphelin.

<br>

{: tsResolve}
1.  Vérifiez quel est le compte d'infrastructure que la région dans laquelle se trouve votre cluster utilise pour mettre à disposition des clusters.
    1.  Connectez-vous à la [console de clusters {{site.data.keyword.containerlong_notm}} ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://console.bluemix.net/containers-kubernetes/clusters).
    2.  Dans le tableau, sélectionnez votre cluster.
    3.  Dans l'onglet **Vue d'ensemble**, recherchez une zone correspondant à un **utilisateur d'infrastructure**. Cette zone vous aide à déterminer si votre compte {{site.data.keyword.containerlong_notm}} utilise un autre compte d'infrastructure que le compte par défaut.
        * Si vous ne voyez pas la zone de l'**utilisateur d'infrastructure**, vous disposez d'un compte de paiement à la carte qui utilise les mêmes données d'identification pour vos comptes d'infrastructure et de plateforme. Le cluster qui ne peut pas être modifié peut être mis à disposition dans un autre compte d'infrastructure.
        * Si vous voyez une zone de l'**utilisateur d'infrastructure**, vous utilisez un autre compte d'infrastructure que celui fourni avec votre compte Paiement à la carte. Ces données d'identification s'appliquent à tous les clusters de la région. Le cluster qui ne peut pas être modifié peut être mis à disposition dans un compte Paiement à la carte ou un autre compte d'infrastructure.
2.  Vérifiez quel est le compte d'infrastructure qui a été utilisé pour mettre à disposition le cluster.
    1.  Dans l'onglet **Noeuds worker**, sélectionnez un noeud worker et notez son **ID**.
    2.  Ouvrez le menu ![Icône de menu](../icons/icon_hamburger.svg "Icône de menu") et cliquez sur **Infrastructure**.
    3.  Dans le panneau de navigation de l'infrastructure, cliquez sur **Unités > Liste des unités**.
    4.  Recherchez l'ID du noeud worker que vous avez noté précédemment.
    5.  Si vous ne trouvez pas l'ID du noeud worker, c'est qu'il n'est pas mis à disposition dans ce compte d'infrastructure. Passez à un autre compte d'infrastructure et réessayez.
3.  Utilisez la [commande](cs_cli_reference.html#cs_credentials_set) `ibmcloud ks credential-set` pour modifier vos données d'identification d'infrastructure dans le compte où sont mis à disposition les noeuds worker du cluster, que vous avez trouvé à l'étape précédente.
    Si vous n'avez plus accès à ces données d'identification ou que vous ne pouvez pas les obtenir, vous pouvez ouvrir un cas de support {{site.data.keyword.Bluemix_notm}} pour supprimer le cluster orphelin.
    {: note}
4.  [Supprimez le cluster](cs_clusters.html#remove).
5.  Si vous le souhaitez, réinitialisez les données d'identification dans le compte précédent. Notez que si vous avez créé des clusters avec un autre compte d'infrastructure que le compte où vous avez basculé, vous pouvez rendre ces clusters orphelins.
    * Pour définir les données d'identification sur un autre compte d'infrastructure, utilisez la [commande](cs_cli_reference.html#cs_credentials_set) `ibmcloud ks credential-set`.
    * Pour utiliser les données d'identification par défaut fournies avec votre compte {{site.data.keyword.Bluemix_notm}} Paiement à la carte, utilisez la [commande](cs_cli_reference.html#cs_credentials_unset) `ibmcloud ks credential-unset`.

<br />


## Les commandes `kubectl` dépassent le délai d'attente
{: #exec_logs_fail}

{: tsSymptoms}
Si vous exécutez des commandes de type `kubectl exec`, `kubectl attach`, `kubectl proxy`, `kubectl port-forward` ou `kubectl logs`, vous voyez s'afficher le message suivant.

  ```
  <workerIP>:10250: getsockopt: connection timed out
  ```
  {: screen}

{: tsCauses}
La connexion OpenVPN entre le noeud maître et les noeuds worker ne fonctionne pas correctement.

{: tsResolve}
1. Si vous disposez de plusieurs VLAN pour un cluster, de plusieurs sous-réseaux sur le même VLAN ou d'un cluster à zones multiples, vous devez activer la fonction [Spanning VLAN](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) pour votre compte d'infrastructure IBM Cloud (SoftLayer) afin que vos noeuds worker puissent communiquer entre eux sur le réseau privé. Pour effectuer cette action, vous devez disposer des [droits Infrastructure](cs_users.html#infra_access) **Réseau > Gérer spanning VLAN pour réseau** ou vous pouvez demander au propriétaire du compte de l'activer. Pour vérifier si la fonction Spanning VLAN est déjà activée, utilisez la [commande](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`. Avec {{site.data.keyword.BluDirectLink}}, vous devez utiliser à la place une [fonction VRF (Virtual Router Function)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf). Pour activer la fonction VRF, contactez le représentant de votre compte d'infrastructure IBM Cloud (SoftLayer).
2. Redémarrez le pod du client OpenVPN.
  ```
  kubectl delete pod -n kube-system -l app=vpn
  ```
  {: pre}
3. Si le message d'erreur s'affiche toujours, le noeud worker sur lequel réside le pod VPN est peut-être défectueux. Pour redémarrer le pod VPN et le replanifier sur un autre noeud worker, utilisez les [commandes cordon, drain et réamorcez le noeud worker](cs_cli_reference.html#cs_worker_reboot) sur lequel se trouve le pod VPN.

<br />


## La liaison d'un service à un cluster renvoie une erreur due à l'utilisation du même nom
{: #cs_duplicate_services}

{: tsSymptoms}
Lorsque vous exécutez la commande `ibmcloud ks cluster-service-bind <cluster_name> <namespace> <service_instance_name>`, le message suivant s'affiche :

```
Multiple services with the same name were found.
Run 'ibmcloud service list' to view available Bluemix service instances...
```
{: screen}

{: tsCauses}
Il se peut que plusieurs instances de service aient le même nom dans différentes régions.

{: tsResolve}
Utilisez l'identificateur global unique (GUID) du service au lieu du nom de l'instance de service dans la commande `ibmcloud ks cluster-service-bind`.

1. [Connectez-vous à la région hébergeant l'instance de service à lier.](cs_regions.html#bluemix_regions)

2. Extrayez l'identificateur global unique (GUID) de l'instance de service.
  ```
  ibmcloud service show <service_instance_name> --guid
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
  ibmcloud ks cluster-service-bind <cluster_name> <namespace> <service_instance_GUID>
  ```
  {: pre}

<br />


## La liaison d'un service à un cluster renvoie une erreur indiquant que le service est introuvable
{: #cs_not_found_services}

{: tsSymptoms}
Lorsque vous exécutez la commande `ibmcloud ks cluster-service-bind <cluster_name> <namespace> <service_instance_name>`, le message suivant s'affiche :

```
Binding service to a namespace...
FAILED

The specified IBM Cloud service could not be found. If you just created the service, wait a little and then try to bind it again. To view available IBM Cloud service instances, run 'ibmcloud service list'. (E0023)
```
{: screen}

{: tsCauses}
Pour lier des services à un cluster vous devez disposer du rôle utilisateur Développeur Cloud Foundry pour l'espace où l'instance de service est mise à disposition. Vous devez également disposer du rôle d'accès de plateforme {{site.data.keyword.Bluemix_notm}} IAM Editeur à {{site.data.keyword.containerlong}}. Pour accéder à l'instance de service, vous devez être connecté à l'espace dans lequel l'instance de service est mise à disposition.

{: tsResolve}

**En tant qu'utilisateur :**

1. Connectez-vous à {{site.data.keyword.Bluemix_notm}}.
   ```
   ibmcloud login
   ```
   {: pre}

2. Ciblez l'organisation et l'espace où l'instance de service est mise à disposition.
   ```
   ibmcloud target -o <org> -s <space>
   ```
   {: pre}

3. Vérifiez que vous êtes dans le bon espace en affichant la liste de vos instances de service.
   ```
   ibmcloud service list
   ```
   {: pre}

4. Essayez d'effectuer à nouveau la liaison du service. Si vous obtenez la même erreur, contactez l'administrateur du compte et vérifiez que vous disposez des droits suffisants pour effectuer des liaisons de services (voir la procédure suivante de l'administrateur du compte).

**En tant qu'administrateur du compte :**

1. Vérifiez que l'utilisateur qui rencontre ce problème dispose des [droits d'éditeur pour {{site.data.keyword.containerlong}}](/docs/iam/mngiam.html#editing-existing-access).

2. Vérifiez que l'utilisateur qui rencontre ce problème dispose du [rôle de développeur Cloud Foundry pour l'espace](/docs/iam/mngcf.html#updating-cloud-foundry-access) dans lequel le service est mis à disposition.

3. Si les droits adéquats existent, essayez d'affecter un autre droit, puis d'affecter à nouveau le droit requis.

4. Patientez quelques minutes, puis laissez l'utilisateur effectuer une nouvelle tentative de liaison du service.

5. Si le problème n'est toujours pas résolu, les droits {{site.data.keyword.Bluemix_notm}} IAM ne sont pas synchronisés et vous ne pouvez pas résoudre le problème vous-même. [Contactez le support IBM](/docs/get-support/howtogetsupport.html#getting-customer-support) en ouvrant un cas de support. Veillez à fournir l'ID du cluster, l'ID utilisateur et l'ID de l'instance de service.
   1. Récupérez l'ID du cluster.
      ```
      ibmcloud ks clusters
      ```
      {: pre}

   2. Récupérez l'ID de l'instance de service.
      ```
      ibmcloud service show <service_name> --guid
      ```
      {: pre}


<br />


## La liaison d'un service à un cluster renvoie une erreur indiquant que le service ne prend pas en charge les clés de service
{: #cs_service_keys}

{: tsSymptoms}
Lorsque vous exécutez la commande `ibmcloud ks cluster-service-bind <cluster_name> <namespace> <service_instance_name>`, le message suivant s'affiche :

```
This service doesn't support creation of keys
```
{: screen}

{: tsCauses}
Certains services dans {{site.data.keyword.Bluemix_notm}}, tels qu'{{site.data.keyword.keymanagementservicelong}} ne prennent pas en charge la création de données d'identification de service, appelées également clés de service. Si les clés de service ne sont pas prises en charge, un service ne peut pas être lié à un cluster. Pour obtenir une liste de services prenant en charge la création de clés de service, voir [Utilisation des services {{site.data.keyword.Bluemix_notm}} avec des applications externes](/docs/resources/connect_external_app.html#externalapp).

{: tsResolve}
Pour intégrer des services qui ne prennent pas en charge les clés de service, vérifiez si ces services fournissent une API que vous pouvez utiliser pour accéder directement au service à partir de votre application. Par exemple, pour utiliser {{site.data.keyword.keymanagementservicelong}}, voir [Référence d'API ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://console.bluemix.net/apidocs/kms?language=curl).

<br />


## Après la mise à jour ou le rechargement d'un noeud worker, des noeuds et des pods en double apparaissent
{: #cs_duplicate_nodes}

{: tsSymptoms}
Lorsque vous exécutez la commande `kubectl get nodes`, vous voyez des noeuds worker en double avec le statut **NotReady**. Les noeuds worker avec le statut **NotReady** ont des adresses IP publiques, alors que les noeuds worker avec le statut **Ready** ont des adresses IP privées.

{: tsCauses}
D'anciens clusters affichaient la liste des noeuds worker avec l'adresse IP publique de cluster. A présent, les noeuds worker sont répertoriés avec l'adresse IP privée du cluster. Lorsque vous rechargez ou mettez à jour un noeud, l'adresse IP est modifiée, mais la référence à l'adresse IP publique est conservée.

{: tsResolve}
Le service n'est pas interrompu en raison de ces doublons, mais vous pouvez supprimer les références aux anciens noeuds worker du serveur d'API.

  ```
  kubectl delete node <node_name1> <node_name2>
  ```
  {: pre}

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
  ibmcloud ks workers <CLUSTER_NAME>
  ```
  {: pre}

  ```
  ID                                                 Public IP       Private IP       Machine Type   State     Status   Zone   Version
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w1   169.xx.xxx.xxx  10.xxx.xx.xxx    b2c.4x16       normal    Ready    dal10      1.10.11
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w2   169.xx.xxx.xxx  10.xxx.xx.xxx    b2c.4x16       deleted    -       dal10      1.10.11
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

5.  Réamorcez le noeud worker qui n'a pas été supprimé.

  ```
  ibmcloud ks worker-reboot CLUSTER_ID NODE_ID
  ```
  {: pre}


Le noeud supprimé n'apparaît plus dans Calico.

<br />




## Les pods ne parviennent pas à se déployer en raison d'une politique de sécurité de pod
{: #cs_psp}

{: tsSymptoms}
Après avoir créé un pod ou exécuté la commande `kubectl get events` pour vérifier le déploiement d'un pod, un message d'erreur de ce type s'affiche.

```
unable to validate against any pod security policy
```
{: screen}

{: tsCauses}
[Le contrôleur d'admission `PodSecurityPolicy`](cs_psp.html) vérifie l'autorisation du compte utilisateur ou du compte de service, par exemple un déploiement ou Helm tiller, qui a essayé de créer le pod. Si aucune politique de sécurité de pod ne prend en charge ce compte utilisateur ou ce compte de service, le contrôleur d'admission `PodSecurityPolicy` empêche la création des pods.

Si vous avez supprimé une ressources de politique de sécurité de pod pour la [gestion de cluster {{site.data.keyword.IBM_notm}}](cs_psp.html#ibm_psp), vous pouvez expérimenter des erreurs similaires.

{: tsResolve}
Vérifiez que le compte utilisateur ou le compte de service est autorisé par une politique de sécurité de pod. Vous pouvez être amené à [modifier une politique existante](cs_psp.html#customize_psp).

Si vous avez supprimé une ressource de gestion de cluster {{site.data.keyword.IBM_notm}}, actualisez le maître Kubernetes pour la restaurer.

1.  [Connectez-vous à votre compte. Ciblez la région appropriée et, le cas échéant, le groupe de ressources. Définissez le contexte de votre cluster](cs_cli_install.html#cs_cli_configure).
2.  Actualisez le maître Kubernetes pour restaurer la ressource.

    ```
    ibmcloud ks apiserver-refresh
    ```
    {: pre}


<br />




## Le cluster reste à l'état En attente
{: #cs_cluster_pending}

{: tsSymptoms}
Lorsque vous déployez votre cluster, il reste à l'état en attente (pending) et ne démarre pas.

{: tsCauses}
Si vous venez de créer le cluster, les noeuds worker sont peut-être encore en cours de configuration. Si vous patientez déjà depuis un bon moment, il se peut que votre réseau local virtuel (VLAN) soit non valide.

{: tsResolve}

Vous pouvez envisager l'une des solutions suivantes :
  - Vérifiez le statut de votre cluster en exécutant la commande `ibmcloud ks clusters`. Puis vérifiez que vos noeuds worker sont déployés en exécutant la commande `ibmcloud ks workers <cluster_name>`.
  - Vérifiez si votre réseau local virtuel (VLAN) est valide. Pour être valide, un VLAN doit être associé à une infrastructure pouvant héberger un noeud worker avec un stockage sur disque local. Vous pouvez [afficher la liste de vos VLAN](/docs/containers/cs_cli_reference.html#cs_vlans) en exécutant la commande `ibmcloud ks vlans <zone>`. Si le VLAN n'apparaît pas dans la liste, il n'est pas valide. Choisissez-en un autre.

<br />


## Des pods sont toujours à l'état en attente
{: #cs_pods_pending}

{: tsSymptoms}
Lorsque vous exécutez `kubectl get pods`, vous constatez que des pods sont toujours à l'état en attente (**pending**).

{: tsCauses}
Si vous venez juste de créer le cluster Kubernetes, il se peut que les noeuds worker soient encore en phase de configuration.

S'il s'agit d'un cluster existant :
*  Il se peut que la capacité de votre cluster soit insuffisante pour déployer le pod.
*  Le pod peut avoir dépassé une limite ou une demande de ressources.

{: tsResolve}
Cette tâche nécessite le [rôle de plateforme {{site.data.keyword.Bluemix_notm}} IAM **Administrateur**](cs_users.html#platform) pour le cluster.

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

4.  Si vous ne disposez pas d'une capacité suffisante dans votre cluster, redimensionnez votre pool de noeuds worker pour ajouter des noeuds supplémentaires.

    1.  Passez en revue les tailles et les types de machine de vos pools de noeuds worker pour décider du pool à redimensionner.

        ```
        ibmcloud ks worker-pools
        ```
        {: pre}

    2.  Redimensionnez votre pool de noeuds worker pour ajouter des noeuds supplémentaires dans toutes les zones couvertes par le pool.

        ```
        ibmcloud ks worker-pool-resize <worker_pool> --cluster <cluster_name_or_ID> --size-per-zone <workers_per_zone>
        ```
        {: pre}

5.  Facultatif : vérifiez les demandes de ressources de votre pod.

    1.  Confirmez que les valeurs des demandes de ressources (`resources.requests`) ne dépassent pas la capacité du noeud worker. Par exemple, si la demande du pod est `cpu: 4000m` ou 4 coeurs, mais que la taille du noeud worker n'est que de 2 coeurs, le pod ne peut pas être déployé.

        ```
        kubectl get pod <pod_name> -o yaml
        ```
        {: pre}

    2.  Si la demande dépasse la capacité disponible, [ajoutez un nouveau pool de noeuds worker](cs_clusters.html#add_pool) avec des noeuds worker pouvant satisfaire la demande.

6.  Si vos pods sont toujours à l'état **pending** après le déploiement complet du noeud worker, consultez la [documentation Kubernetes ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/tasks/debug-application-cluster/debug-pod-replication-controller/#my-pod-stays-pending) pour effectuer d'autres tâches en vue d'identifier et de résoudre le problème.

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


## Les pods ne parviennent pas à redémarrer à plusieurs reprises ou sont retirés de manière imprévisible
{: #pods_fail}

{: tsSymptoms}
Votre pod est sain mais a été retiré de manière imprévisible ou est bloqué dans une boucle de redémarrage.

{: tsCauses}
Vos conteneurs ont peut-être dépassé leurs limites de ressources ou vos pods ont peut-être été remplacés par des pods avec une priorité plus élevée.

{: tsResolve}
Pour voir si un conteneur est arrêté en raison d'une limite de ressources :
<ol><li>Obtenez le nom de votre pod. Si vous avez utilisé un libellé (label), vous pouvez vous en servir pour filtrer vos résultats.<pre class="pre"><code>kubectl get pods --selector='app=wasliberty'</code></pre></li>
<li>Décrivez le pod et recherchez la zone **Nombre de redémarrages**.<pre class="pre"><code>kubectl describe pod</code></pre></li>
<li>Si le pod a redémarré plusieurs fois sur une courte durée, examinez son statut. <pre class="pre"><code>kubectl get pod -o go-template={{range.status.containerStatuses}}{{"Container Name: "}}{{.name}}{{"\r\nLastState: "}}{{.lastState}}{{end}}</code></pre></li>
<li>Passez en revue la raison. Par exemple, `OOM Killed` signifie "mémoire insuffisante", ce qui indique que l'incident du conteneur est lié à une limite de ressources.</li>
<li>Ajoutez de la capacité à votre cluster de sorte à l'ajuster par rapport aux ressources.</li></ol>

<br>

Pour voir si votre pod a été remplacé par des pods de priorité plus élevée :
1.  Obtenez le nom de votre pod.

    ```
    kubectl get pods
    ```
    {: pre}

2.  Décrivez le fichier YAML de votre pod.

    ```
    kubectl get pod <pod_name> -o yaml
    ```
    {: pre}

3.  Vérifiez la zone `priorityClassName`.

    1.  S'il n'y a aucune valeur de zone `priorityClassName`, votre pod a la classe de priorité `globalDefault`. Si l'administrateur de votre cluster n'a pas défini de classe de priorité `globalDefault`, la valeur par défaut est zéro (0) ou la priorité la plus faible. Tout pod avec une classe de priorité plus élevée peut préempter ou retirer votre pod.

    2.  S'il y a une valeur de zone `priorityClassName`, obtenez la classe de priorité.

        ```
        kubectl get priorityclass <priority_class_name> -o yaml
        ```
        {: pre}

    3.  Notez la zone `value` pour vérifier la priorité de votre pod.

4.  Répertoriez les classes de priorité existantes dans le cluster.

    ```
    kubectl get priorityclasses
    ```
    {: pre}

5.  Pour chaque classe de priorité, obtenez le fichier YAML et notez la zone `value`.

    ```
    kubectl get priorityclass <priority_class_name> -o yaml
    ```
    {: pre}

6.  Comparez la classe de priorité de votre pod avec les valeurs des autres classes de priorité pour voir si elle est supérieure ou inférieure aux autres.

7.  Répétez les étapes 1 à 3 pour les autres pods du cluster, pour vérifier la classe de priorité qu'ils utilisent. Si leur classe de priorité est supérieure à celle de votre pod, votre pod n'est pas mis à disposition, sauf s'il y a suffisamment de ressources pour votre pod et tous les pods de priorité plus élevée.

8.  Contactez l'administrateur de votre cluster pour ajouter de la capacité à votre cluster et confirmer que les classes de priorité adéquates sont affectées.

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

-  Dans le terminal, vous êtes averti des mises à jour disponibles pour l'interface de ligne de commande `ibmcloud` et les plug-ins. Veillez à maintenir votre interface de ligne de commande à jour pour pouvoir utiliser l'ensemble des commandes et des indicateurs.
-   Pour déterminer si {{site.data.keyword.Bluemix_notm}} est disponible, [consultez la page de statut d'{{site.data.keyword.Bluemix_notm}} ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://developer.ibm.com/bluemix/support/#status).
-   Publiez une question sur le site [{{site.data.keyword.containerlong_notm}} Slack ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://ibm-container-service.slack.com).
    Si vous n'utilisez pas un ID IBM pour votre compte {{site.data.keyword.Bluemix_notm}}, [demandez une invitation](https://bxcs-slack-invite.mybluemix.net/) sur ce site Slack.
    {: tip}
-   Consultez les forums pour établir si d'autres utilisateurs ont rencontré le même problème. Lorsque vous utilisez les forums pour poser une question, balisez votre question de sorte que les équipes de développement {{site.data.keyword.Bluemix_notm}} la voient.
    -   Si vous avez des questions d'ordre technique sur le développement ou le déploiement de clusters ou d'applications à l'aide d'{{site.data.keyword.containerlong_notm}}, publiez-les sur le site [Stack Overflow ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://stackoverflow.com/questions/tagged/ibm-cloud+containers) en leur adjoignant les balises `ibm-cloud`, `kubernetes` et `containers`.
    -   Pour toute question sur le service et les instructions de mise en route, utilisez le forum [IBM Developer Answers ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://developer.ibm.com/answers/topics/containers/?smartspace=bluemix). Incluez les balises `ibm-cloud` et `containers`.
    Voir [Comment obtenir de l'aide](/docs/get-support/howtogetsupport.html#using-avatar) pour plus d'informations sur l'utilisation des forums.
-   Contactez le support IBM en ouvrant un cas. Pour savoir comment ouvrir un cas de support IBM ou obtenir les niveaux de support et la gravité des cas, voir [Contacter le support](/docs/get-support/howtogetsupport.html#getting-customer-support).
Lorsque vous signalez un problème, incluez l'ID de votre cluster. Pour identifier l'ID du cluster, exécutez la commande `ibmcloud ks clusters`.
{: tip}

