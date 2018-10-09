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

{: tsCauses}
Les comptes Paiement à la carte {{site.data.keyword.Bluemix_notm}} créés après l'activation de la liaison automatique de compte sont déjà configurés avec l'accès au portefeuille d'infrastructure IBM Cloud (SoftLayer). Vous pouvez acheter des ressources d'infrastructure pour votre cluster sans configuration supplémentaire. Si vous disposez d'un compte Paiement à la carte et recevez ce message d'erreur, il est possible que vous n'utilisez pas les données d'identification du compte d'infrastructure IBM Cloud (SoftLayer) appropriées pour accéder aux ressources d'infrastructure.

Les utilisateurs disposant d'autres types de compte {{site.data.keyword.Bluemix_notm}} doivent configurer leurs comptes pour créer des clusters standard. Exemples de cas de figure où vous pouvez disposer d'un autre type de compte :
* Vous disposez d'un compte d'infrastructure IBM Cloud (SoftLayer) antérieur à votre compte de plateforme {{site.data.keyword.Bluemix_notm}} et vous souhaitez continuer à l'utiliser.
* Vous désirez utiliser un autre compte d'infrastructure IBM Cloud (SoftLayer) pour mettre à disposition des ressources d'infrastructure dedans. Par exemple, vous pouvez configurer un compte {{site.data.keyword.Bluemix_notm}} d'équipe pour utiliser un compte d'infrastructure distinct pour la facturation.

{: tsResolve}
Le propriétaire de compte doit configurer correctement les données d'identification du compte d'infrastructure. Ces données dépendent du type de compte d'infrastructure que vous utilisez.

**Avant de commencer** :

1.  Vérifiez que vous avez accès à un compte d'infrastructure. Connectez-vous à la [console {{site.data.keyword.Bluemix_notm}}![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://console.bluemix.net/) et dans le menu extensible, cliquez sur **Infrastructure**. Si vous voyez le tableau de bord Infrastructure, vous avez accès à un compte d'infrastructure.
2.  Vérifiez si votre cluster utilise un autre compte d'infrastructure que celui qui est fourni avec votre compte de paiement à la carte.
    1.  Dans le menu extensible, cliquez sur **Conteneurs > Clusters**.
    2.  Dans le tableau, sélectionnez votre cluster.
    3.  Dans l'onglet **Vue d'ensemble**, recherchez une zone correspondant à un **utilisateur d'infrastructure**. 
        * Si vous ne voyez pas la zone de l'**utilisateur d'infrastructure**, vous disposez d'un compte de paiement à la carte qui utilise les mêmes données d'identification pour vos comptes d'infrastructure et de plateforme.
        * Si vous voyez une zone d'**utilisateur d'infrastructure**, votre cluster utilise un autre compte d'infrastructure que celui qui est fourni avec votre compte de paiement à la carte. Ces données d'identification s'appliquent à tous les clusters de la région. 
3.  Décidez du type de compte que vous voulez obtenir pour déterminer comment identifier et résoudre les incidents liés aux droits d'accès de l'infrastructure. Pour la plupart des utilisateurs, le compte de paiement à la carte lié par défaut suffit.
    *  Compte de paiement à la carte {{site.data.keyword.Bluemix_notm}} lié : [vérifiez que la clé d'API de l'infrastructure est configurée les droits appropriés](#apikey). Si votre cluster utilise un autre compte d'infrastructure, vous devez annuler la définition des données d'identification dans le cadre de ce processus.
    *  Comptes de plateforme et d'infrastructure {{site.data.keyword.Bluemix_notm}} différents : vérifiez que vous pouvez accéder au portefeuille de l'infrastructure et que [les données d'identification du compte d'infrastructure sont définies avec les droits appropriés](#credentials).

### Utilisation des données d'identification d'infrastructure par défaut pour les comptes de paiement à la carte liés avec la clé D'API
{: #apikey}

1.  Vérifiez que l'utilisateur dont vous voulez utiliser les données d'identification pour les actions d'infrastructure dispose des droits appropriés.

    1.  Connectez-vous à la [console {{site.data.keyword.Bluemix_notm}}![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://console.bluemix.net/).

    2.  Dans le menu extensible, sélectionnez **Infrastructure**.

    3.  Dans la barre de menu, sélectionnez **Compte** > **Utilisateurs** > **Liste d'utilisateurs**.

    4.  Dans la colonne **Clé d'API**, vérifiez que l'utilisateur dispose d'une clé d'API ou cliquez sur **Générer**.

    5.  Vérifiez ou affectez à l'utilisateur les [droits Infrastructure appropriés](cs_users.html#infra_access).

2.  Définissez la clé d'API pour la région dans laquelle se trouve le cluster.

    1.  Connectez-vous au terminal avec l'utilisateur dont vous voulez utiliser les droits d'infrastructure.
    
    2.  Si vous vous trouvez dans une autre région, accédez à la région dans laquelle vous voulez définir la clé d'API.
    
        ```
        ibmcloud ks region-set
        ```
        {: pre}

    3.  Définissez la clé d'API de l'utilisateur pour la région.
        ```
        ibmcloud ks api-key-reset
        ```
        {: pre}    

    4.  Vérifiez que la clé d'API est définie.
        ```
        ibmcloud ks api-key-info <cluster_name_or_ID>
        ```
        {: pre}

3.  **Facultatif** : si votre compte de paiement à la carte utilise un autre compte d'infrastructure pour la mise à disposition des clusters (par exemple, vous avez utilisé la commande `ibmcloud ks credentials-set`), le compte continue à utiliser ces données d'identification de l'infrastructure au lieu de la clé d'API. Vous devez retirer le compte d'infrastructure associé pour que la clé d'API que vous avez définie à l'étape précédente soit utilisée.
    ```
    ibmcloud ks credentials-unset
    ```
    {: pre}
        
4.  **Facultatif** : si vous connectez votre cluster public à des ressources sur site, vérifiez votre connectivité réseau.

    1.  Vérifiez la connectivité du réseau local virtuel (VLAN) de votre noeud worker.
    2.  Si nécessaire, [configurez la connectivité VPN](cs_vpn.html#vpn).
    3.  [Ouvrez les ports requis dans votre pare-feu](cs_firewall.html#firewall).

### Configuration des données d'identification de l'infrastructure pour des comptes de plateforme et d'infrastructure différents
{: #credentials}

1.  Obtenez le compte d'infrastructure que vous désirez utiliser pour accéder au portefeuille d'infrastructure IBM Cloud (SoftLayer). Vous avez différentes options possibles en fonction du type de compte dont vous disposez actuellement.

    <table summary="Le tableau présente les options de création de cluster standard par type de compte. La lecture des lignes s'effectue de gauche à droite, avec la description du compte dans la première colonne, et les options de création d'un cluster standard dans la deuxième colonne.">
    <caption>Options de création de cluster standard par type de compte</caption>
      <thead>
      <th>Description du compte</th>
      <th>Options de création d'un cluster standard</th>
      </thead>
      <tbody>
        <tr>
          <td>Les **comptes Lite** ne peuvent pas mettre à disposition des clusters.</td>
          <td>[Mettez à niveau votre compte Lite vers un compte {{site.data.keyword.Bluemix_notm}} Paiement à la carte](/docs/account/index.html#paygo) configuré avec accès au portefeuille d'infrastructure IBM Cloud (SoftLayer).</td>
        </tr>
        <tr>
          <td>Les comptes **Paiement à la carte récents** sont fournis avec accès au portefeuille d'infrastructure.</td>
          <td>Vous pouvez créer des clusters standard. Pour identifier et résoudre les problèmes liés aux droits Infrastructure, voir [Configuration des données d'identification d'API d'infrastructure pour les comptes liés](#apikey).</td>
        </tr>
        <tr>
          <td>Les comptes **Paiement à la carte plus anciens** qui ont été créés avant la liaison automatique des comptes ne sont pas fournis avec accès au portefeuille d'infrastructure IBM Cloud (SoftLayer).<p>Si vous disposez d'un compte d'infrastructure IBM Cloud (SoftLayer) existant, vous ne pouvez pas le lier à un ancien compte Paiement à la carte.</p></td>
          <td><p><strong>Option 1 :</strong> [créez un compte Paiement à la carte](/docs/account/index.html#paygo) configuré avec accès au portefeuille d'infrastructure IBM Cloud (SoftLayer). Si vous sélectionnez cette option, vous disposerez de deux comptes {{site.data.keyword.Bluemix_notm}} avec facturation distincte.</p><p>Pour continuer à utiliser votre ancien compte Paiement à la carte, vous pouvez utiliser votre nouveau compte Paiement à la carte pour générer une clé d'API permettant d'accéder au portefeuille d'infrastructure IBM Cloud (SoftLayer).</p><p><strong>Option 2 :</strong> si vous disposez déjà d'un compte d'infrastructure IBM Cloud (SoftLayer) que vous désirez utiliser, vous pouvez définir vos données d'identification dans votre compte {{site.data.keyword.Bluemix_notm}}.</p><p>**Remarque :** lorsque vous effectuez une liaison manuelle vers un compte d'infrastructure IBM Cloud (SoftLayer), les données d'identification sont utilisées pour toutes les actions spécifiques de l'infrastructure IBM Cloud (SoftLayer) effectuées dans votre compte {{site.data.keyword.Bluemix_notm}}. Vous devez vérifier que la clé d'API que vous avez définie dispose de [droits d'infrastructure suffisants](cs_users.html#infra_access) pour que vos utilisateurs puissent créer et gérer des clusters.</p><p>**Pour ces deux options, passez à l'étape suivante**.</p></td>
        </tr>
        <tr>
          <td>Les **comptes Abonnement** ne sont pas configurés avec l'accès au portefeuille d'infrastructure IBM Cloud (SoftLayer).</td>
          <td><p><strong>Option 1 :</strong> [créez un compte Paiement à la carte](/docs/account/index.html#paygo) configuré avec accès au portefeuille d'infrastructure IBM Cloud (SoftLayer). Si vous sélectionnez cette option, vous disposerez de deux comptes {{site.data.keyword.Bluemix_notm}} avec facturation distincte.</p><p>Si vous souhaitez continuer à utiliser votre ancien compte Abonnement, vous pouvez utiliser le nouveau compte Paiement à la carte pour générer une clé d'API dans l'infrastructure IBM Cloud (SoftLayer). Vous devez ensuite définir manuellement la clé d'API de l'infrastructure IBM Cloud (SoftLayer) pour votre compte Abonnement. N'oubliez pas que les ressources d'infrastructure IBM Cloud (SoftLayer) sont facturées via votre nouveau compte Paiement à la carte.</p><p><strong>Option 2 :</strong> si vous disposez déjà d'un compte d'infrastructure IBM Cloud (SoftLayer) existant que vous désirez utiliser, vous pouvez définir manuellement les données d'identification de votre compte d'infrastructure IBM Cloud (SoftLayer) pour votre compte {{site.data.keyword.Bluemix_notm}}.</p><p>**Remarque :** lorsque vous effectuez une liaison manuelle vers un compte d'infrastructure IBM Cloud (SoftLayer), les données d'identification sont utilisées pour toutes les actions spécifiques de l'infrastructure IBM Cloud (SoftLayer) effectuées dans votre compte {{site.data.keyword.Bluemix_notm}}. Vous devez vérifier que la clé d'API que vous avez définie dispose de [droits d'infrastructure suffisants](cs_users.html#infra_access) pour que vos utilisateurs puissent créer et gérer des clusters.</p><p>**Pour ces deux options, passez à l'étape suivante**.</p></td>
        </tr>
        <tr>
          <td>**Comptes d'infrastructure IBM Cloud (SoftLayer)**, aucun compte {{site.data.keyword.Bluemix_notm}}</td>
          <td><p>[Créez un compte Paiement à la carte {{site.data.keyword.Bluemix_notm}}](/docs/account/index.html#paygo) configuré avec accès au portefeuille d'infrastructure IBM Cloud (SoftLayer). Si vous sélectionnez cette option, un compte d'infrastructure IBM Cloud (SoftLayer) est créé pour vous. Vous disposez de deux comptes d'infrastructure IBM Cloud (SoftLayer) différents avec facturation distincte.</p><p>Par défaut, votre nouveau compte {{site.keyword.data.Bluemix_notm}} utilise le nouveau compte d'infrastructure. Pour continuer à utiliser l'ancien compte d'infrastructure, passez à l'étape suivante.</p></td>
        </tr>
      </tbody>
      </table>

2.  Vérifiez que l'utilisateur dont vous voulez utiliser les données d'identification pour les actions d'infrastructure dispose des droits appropriés.

    1.  Connectez-vous à la [console {{site.data.keyword.Bluemix_notm}}![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://console.bluemix.net/).

    2.  Dans le menu extensible, sélectionnez **Infrastructure**.

    3.  Dans la barre de menu, sélectionnez **Compte** > **Utilisateurs** > **Liste d'utilisateurs**.

    4.  Dans la colonne **Clé d'API**, vérifiez que l'utilisateur dispose d'une clé d'API ou cliquez sur **Générer**.

    5.  Vérifiez ou affectez à l'utilisateur les [droits Infrastructure appropriés](cs_users.html#infra_access).

3.  Définissez les données d'identifications d'API avec l'utilisateur pour le compte approprié.

    1.  Obtenez les données d'identification d'API d'infrastructure de l'utilisateur. **Remarque** : ces données d'identification sont différentes de l'IBMid.

        1.  Dans la console [{{site.data.keyword.Bluemix_notm}} ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://console.bluemix.net/), accédez au tableau **Infrastructure** > **Compte** > **Utilisateurs** > **Liste d'utilisateurs** et cliquez sur **IBMid ou nom d'utilisateur**.

        2.  Dans la section **Informations d'accès à l'API**, examinez les valeurs de **Nom d'utilisateur de l'API** et **Clé d'authentification**.    

    2.  Définissez les données d'identification d'API d'infrastructure à utiliser.
        ```
        ibmcloud ks credentials-set --infrastructure-username <infrastructure_API_username> --infrastructure-api-key <infrastructure_API_authentication_key>
        ```
        {: pre}

4.  **Facultatif** : si vous connectez votre cluster public à des ressources sur site, vérifiez votre connectivité réseau.

    1.  Vérifiez la connectivité du réseau local virtuel (VLAN) de votre noeud worker.
    2.  Si nécessaire, [configurez la connectivité VPN](cs_vpn.html#vpn).
    3.  [Ouvrez les ports requis dans votre pare-feu](cs_firewall.html#firewall).

<br />


## Le pare-feu empêche l'exécution de commandes via la ligne de commande
{: #ts_firewall_clis}

{: tsSymptoms}
Lorsque vous exécutez des commandes `ibmcloud`, `kubectl` ou `calicoctl` depuis l'interface de ligne de commande, ces commandes échouent.

{: tsCauses}
Des règles réseau d'entreprise empêchent peut-être l'accès depuis votre système local à des noeuds finaux publics via des proxies ou des pare-feux.

{: tsResolve}
[Autorisez l'accès TCP afin que les commandes CLI fonctionnent](cs_firewall.html#firewall). Cette tâche nécessite d'utiliser une [règle d'accès administrateur](cs_users.html#access_policies). Vérifiez votre [règle d'accès actuelle](cs_users.html#infra_access).


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
[Autorisez le cluster à accéder aux ressources d'infrastructure et à d'autres services](cs_firewall.html#firewall_outbound). Cette tâche nécessite d'utiliser une [règle d'accès administrateur](cs_users.html#access_policies). Vérifiez votre [règle d'accès actuelle](cs_users.html#infra_access).

<br />



## L'accès à votre noeud worker à l'aide de SSH échoue
{: #cs_ssh_worker}

{: tsSymptoms}
Vous ne pouvez pas accéder à votre noeud worker à l'aide d'une connexion SSH.

{: tsCauses}
La connexion SSH par mot de passe n'est pas disponible sur les noeuds worker.

{: tsResolve}
Utilisez des [DaemonSets ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) pour les actions que vous devez exécuter sur chaque noeud ou utilisez des travaux pour toutes les actions à usage unique que vous devez exécuter.

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
Pour lier des services à un cluster vous devez disposer du rôle utilisateur Développeur Cloud Foundry pour l'espace où l'instance de service est mise à disposition. Vous devez également disposer de l'accès Editeur IAM à {{site.data.keyword.containerlong}}. Pour accéder à l'instance de service, vous devez être connecté à l'espace dans lequel l'instance de service est mise à disposition.

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

5. Si le problème n'est toujours pas résolu, les droits IAM ne sont pas synchronisés et vous ne pouvez pas résoudre le problème vous-même. [Contactez le support IBM](/docs/get-support/howtogetsupport.html#getting-customer-support) en ouvrant un ticket de demande de service. Veillez à fournir l'ID du cluster, l'ID utilisateur et l'ID de l'instance de service.
   1. Récupérez l'ID du cluster.
      ```
      ibmcloud ks clusters
      ```
      {: pre}

   2. Récupérez l'ID d'instance de service.
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
Certains services dans {{site.data.keyword.Bluemix_notm}}, tels qu'{{site.data.keyword.keymanagementservicelong}} ne prennent pas en charge la création de données d'identification de service, appelées également clés de service. Si les clés de service ne sont pas prises en charge, un service ne peut pas être lié à un cluster. Pour obtenir une liste de services prenant en charge la création de clés de service, voir [Utilisation des services {{site.data.keyword.Bluemix_notm}} avec des applications externes](/docs/apps/reqnsi.html#accser_external).

{: tsResolve}
Pour intégrer de services qui ne prennent pas en charge les clés de service, vérifiez si ces services fournissent une API que vous pouvez utiliser pour accéder directement au service à partir de votre application. Par exemple, pour utiliser {{site.data.keyword.keymanagementservicelong}}, voir [Référence d'API ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://console.bluemix.net/apidocs/kms?language=curl). 

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
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w1   169.xx.xxx.xxx  10.xxx.xx.xxx    b2c.4x16       normal    Ready    dal10      1.10.7
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w2   169.xx.xxx.xxx  10.xxx.xx.xxx    b2c.4x16       deleted    -       dal10      1.10.7
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

5.  Redémarrez le noeud worker qui n'a pas été supprimé.

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

1.  [Ciblez votre interface de ligne de commande](cs_cli_install.html#cs_cli_configure) sur votre cluster.
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
    Voir [Comment obtenir de l'aide](/docs/get-support/howtogetsupport.html#using-avatar)
pour plus d'informations sur l'utilisation des forums.

-   Contactez le support IBM en ouvrant un ticket de demande de service. Pour en savoir plus sur l'ouverture d'un ticket de demande de service IBM ou sur les niveaux de support disponibles et les gravités des tickets, voir la rubrique décrivant comment [contacter le support](/docs/get-support/howtogetsupport.html#getting-customer-support).

{: tip}
Lorsque vous signalez un problème, incluez l'ID de votre cluster. Pour identifier l'ID du cluster, exécutez la commande `ibmcloud ks clusters`.

