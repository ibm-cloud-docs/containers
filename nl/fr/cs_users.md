---

copyright:
  years: 2014, 2018
lastupdated: "2018-08-06"


---

{:new_window: target="blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Affectation d'accès au cluster
{: #users}

En tant qu'administrateur de cluster, vous pouvez définir des règles d'accès à votre cluster Kubernetes pour créer différents niveaux d'accès pour différents utilisateurs. Par exemple, vous pouvez autoriser certains utilisateurs à travailler avec les ressources du cluster et en autoriser d'autres à déployer uniquement des conteneurs.
{: shortdesc}


## Description des règles et droits d'accès
{: #access_policies}

<dl>
  <dt>Dois-je définir des règles d'accès ?</dt>
    <dd>Vous devez définir des règles d'accès pour tous les utilisateurs qui utilisent {{site.data.keyword.containershort_notm}}. La portée d'une règle d'accès s'appuie sur un ou plusieurs rôles définis pour les utilisateurs qui déterminent les actions qu'ils sont autorisés à effectuer. Certaines règles sont prédéfinies, mais d'autres peuvent être personnalisées. La même règle s'applique que l'utilisateur effectue la demande à partir de l'interface graphique {{site.data.keyword.containershort_notm}} ou de l'interface de ligne de commande (CLI), et ce, même si les actions sont exécutées dans l'infrastructure IBM Cloud (SoftLayer).</dd>

  <dt>Quels sont les types de droits d'accès ?</dt>
    <dd><p><strong>Plateforme</strong> : {{site.data.keyword.containershort_notm}} est configuré pour utiliser des rôles de plateforme {{site.data.keyword.Bluemix_notm}} permettant de déterminer les actions que peuvent effectuer des personnes sur un cluster. Les droits associés à ce rôle se superposent, c'est-à-dire que le rôle d'éditeur (`Editor`) dispose des mêmes droits que le rôle d'afficheur (`Viewer`), en plus des droits octroyés à un éditeur. Vous pouvez définir ces règles par région. Elles doivent être définies avec des règles d'infrastructure et inclure les rôles RBAC correspondants qui sont automatiquement affectés à l'espace de nom par défaut. Exemples d'actions : créer ou retirer des clusters, ou ajouter des noeuds worker supplémentaires.</p> <p><strong>Infrastructure</strong> : vous pouvez déterminer les niveaux d'accès à votre infrastructure par exemple, les machines de noeud de cluster, les réseaux ou les ressources de stockage. Vous devez définir ce type de règle parallèlement aux règles d'accès à la plateforme {{site.data.keyword.containershort_notm}}. Pour en savoir plus sur les rôles disponibles, consultez la rubrique [Droits Infrastructure](/docs/iam/infrastructureaccess.html#infrapermission). En plus de l'octroi de rôles d'infrastructure spécifiques, vous devez également accorder l'accès aux unités pour les utilisateurs qui utilisent l'infrastructure. Pour commencer à affecter des rôles, suivez les étapes indiquées dans la rubrique [Personnalisation des droits Infrastructure pour un utilisateur](#infra_access). <strong>Remarque </strong>: Assurez-vous que votre compte {{site.data.keyword.Bluemix_notm}} est [configuré avec l'accès au portefeuille d'infrastructure IBM Cloud (SoftLayer)](cs_troubleshoot_clusters.html#cs_credentials) pour que les utilisateurs autorisés puissent effectuer des actions dans le compte d'infrastructure IBM Cloud (SoftLayer) en fonction des droits qui leur sont conférés. </p> <p><strong>RBAC </strong>: Le mécanisme de contrôle d'accès basé sur des rôles (RBAC) est une méthode de sécurisation des ressources figurant dans votre cluster qui vous permet de décider qui peut effectuer des actions Kubernetes. Tous les utilisateurs auxquels a été affectée une règle d'accès Plateforme ont un rôle Kubernetes qui leur est automatiquement affecté. Dans Kubernetes, [RBAC (Role Based Access Control) ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#api-overview) détermine les actions possibles d'un utilisateur sur les ressources d'un cluster. <strong>Remarque </strong>: les rôles RBAC sont automatiquement définis en conjonction avec le rôle de plateforme pour l'espace de nom par défaut. En tant qu'administrateur de cluster, vous pouvez [mettre à jour ou affecter des rôles](#rbac) pour d'autres espaces de nom.</p> <p><strong>Cloud Foundry </strong>: les services ne peuvent pas tous être gérés par Cloud IAM. Si vous utilisez l'un de ces services, vous pouvez continuer à utiliser les [rôles d'utilisateur Cloud Foundry](/docs/iam/cfaccess.html#cfaccess) pour contrôler l'accès à vos services. Exemples d'actions : lier un service ou créer un nouvelle instance de service.</p></dd>

  <dt>Comment définir les droits d'accès ?</dt>
    <dd><p>Lorsque vous définissez des droits d'accès pour la plateforme, vous pouvez affecter l'accès à un utilisateur spécifique, à un groupe d'utilisateurs ou au groupe de ressources par défaut. Lorsque vous définissez ces droits d'accès pour la plateforme, des rôles RBAC sont automatiquement configurés pour l'espace de nom par défaut et l'élément RoleBinding est créé.</p>
    <p><strong>Utilisateurs </strong>: vous pouvez avoir un utilisateur en particulier qui nécessite plus ou moins de droits d'accès que les autres membres de votre équipe. Vous pouvez personnaliser les droits d'accès sur une base individuelle de sorte que chaque personne dispose des droits appropriés nécessaires pour accomplir sa tâche.</p>
    <p><strong>Groupes d'accès </strong>:  vous pouvez créer des groupes d'utilisateurs et affecter des droits à un groupe spécifique. Par exemple, vous pouvez rassembler tous vos chefs d'équipe au sein d'un groupe et accorder à ce groupe un accès administrateur. Alors qu'au même moment, votre groupe de développeurs ne bénéficiera que d'un accès en écriture.</p>
    <p><strong>Groupes de ressources </strong>: avec IAM, vous pouvez créer des règles d'accès pour un groupe de ressources et accorder l'accès utilisateur à ce groupe. Ces ressources peuvent faire partie d'un service {{site.data.keyword.Bluemix_notm}} ou vous pouvez également regrouper des ressources sur des instances de service, comme par exemple un cluster {{site.data.keyword.containershort_notm}} et une application CF.</p> <p>**Important **: {{site.data.keyword.containershort_notm}} ne prend en charge que le groupe de ressources <code>default</code>. Toutes les ressources liées au cluster sont automatiquement disponibles dans le groupe de ressources <code>default</code>. Si vous disposez d'autres services dans votre compte {{site.data.keyword.Bluemix_notm}} que vous souhaitez utiliser avec votre cluster, ces services doivent également figurer dans le groupe de ressources <code>default</code>.</p></dd>
</dl>


Vous vous sentez dépassé ? Suivez ce tutoriel consacré aux [meilleures pratiques en matière d'organisation des utilisateurs, des équipes et des applications](/docs/tutorials/users-teams-applications.html).
{: tip}

<br />


## Accès au portefeuille d'infrastructure IBM Cloud (SoftLayer)
{: #api_key}

<dl>
  <dt>Pourquoi dois-je accéder au portefeuille d'infrastructure IBM Cloud (SoftLayer) ?</dt>
    <dd>Pour mettre à disposition et travailler avec des clusters dans votre compte, vous devez vérifier que vous avez un compte défini correctement pour accéder au portefeuille d'infrastructure IBM Cloud (SoftLayer). Selon la configuration de votre compte, vous pouvez utiliser la clé d'API IAM ou les données d'identification d'infrastructure que vous avez définies manuellement avec la commande `ibmcloud ks credentials-set`.</dd>

  <dt>Comment fonctionne la clé d'API avec le service de conteneur ?</dt>
    <dd><p>La clé d'API IAM (Identity and Access Management) est définie automatiquement pour une région lorsque la première action qui nécessite la règle d'accès admin {{site.data.keyword.containershort_notm}} est effectuée. Par exemple, supposons que l'un de vos administrateurs crée le premier cluster dans la région <code>us-south</code>. Pour cette opération, la clé d'API IAM de cet utilisateur est stockée dans le compte correspondant à cette région. La clé d'API est utilisée pour commander l'infrastructure IBM Cloud (SoftLayer), par exemple de nouveaux noeuds worker ou réseaux locaux virtuels (VLAN).</p> <p>Lorsqu'un autre utilisateur effectue une action qui nécessite une interaction avec le portefeuille d'infrastructure IBM Cloud (SoftLayer) dans cette région, par exemple la création d'un nouveau cluster ou le rechargement d'un noeud worker, la clé d'API stockée est utilisée pour déterminer s'il existe des droits suffisants pour effectuer cette action. Pour vous assurer que les actions liées à l'infrastructure dans votre cluster peuvent être effectuées sans problème, affectez à vos administrateurs {{site.data.keyword.containershort_notm}} la règle d'accès <strong>Superutilisateur</strong> de l'infrastructure.</p> <p>Vous pouvez trouver le propriétaire actuel de la clé d'API en exécutant la commande [<code>ibmcloud ks api-key-info</code>](cs_cli_reference.html#cs_api_key_info). Si vous constatez que la clé d'API stockée pour une région nécessite une mise à jour, vous pouvez le faire en exécutant la commande [<code>ibmcloud ks api-key-reset</code>](cs_cli_reference.html#cs_api_key_reset). Cette commande nécessite la règle d'accès admin {{site.data.keyword.containershort_notm}} et stocke la clé d'API de l'utilisateur qui exécute cette commande dans le compte. La clé d'API stockée pour la région ne peut pas être utilisée si les données d'identification de l'infrastructure IBM Cloud (SoftLayer) ont été définies manuellement à l'aide de la commande <code>ibmcloud ks credentials-set</code>.</p> <p><strong>Remarque :</strong>assurez-vous de vouloir réinitialiser la clé et d'en mesurer l'impact sur votre application. La clé est utilisée à plusieurs endroits et peut entraîner des modifications avec rupture si elle est modifiée inutilement.</p></dd>

  <dt>Que fait la commande <code>ibmcloud ks credentials-set</code> ?</dt>
    <dd><p>Si vous disposez d'un compte de paiement à la carte {{site.data.keyword.Bluemix_notm}}, vous avez accès au portefeuille d'infrastructure IBM Cloud (SoftLayer) par défaut. Cependant, vous pouvez utiliser un autre compte d'infrastructure IBM Cloud (SoftLayer) dont vous disposez déjà pour commander l'infrastructure. Vous pouvez lier ce compte d'infrastructure à votre compte {{site.data.keyword.Bluemix_notm}} en utilisant la commande [<code>ibmcloud ks credentials-set</code>](cs_cli_reference.html#cs_credentials_set).</p> <p>Pour supprimer les données d'identification de l'infrastructure IBM Cloud (SoftLayer) définies manuellement, vous pouvez utiliser la commande [<code>ibmcloud ks credentials-unset</code>](cs_cli_reference.html#cs_credentials_unset). Une fois ces données supprimées, la clé d'API IAM est utilisée pour commander l'infrastructure.</p></dd>

  <dt>Existe-t-il une différence entre les deux ?</dt>
    <dd>La clé d'API et la commande <code>ibmcloud ks credentials-set</code> accomplissent la même tâche. Si vous définissez manuellement les données d'identification avec la commande <code>ibmcloud ks credentials-set</code>, ces données d'identification remplacent tous les accès octroyés par la clé d'API. Cependant, si l'utilisateur dont les données d'identification sont stockées ne dispose pas des droits requis pour commander l'infrastructure, les actions liées à l'infrastructure, comme par exemple la création d'un cluster ou le rechargement d'un noeud worker, risquent d'échouer.</dd>
</dl>


Pour rendre l'utilisation des clés d'API un peu plus facile, essayez de créer un ID fonctionnel que vous pouvez utiliser pour définir les droits.
{: tip}

<br />



## Description des relations entre les rôles
{: #user-roles}

Avant de vous familiariser avec les rôles et avec les actions pouvant être effectuées avec chacun de ces rôles, il est important de comprendre comment les rôles s'articulent.
{: shortdesc}

La figure suivante présente les rôles dont peuvent avoir besoin les différents types de personnes au sein de votre organisation. Cependant, ces rôles peuvent varier suivant les organisations.

![Rôles d'accès {{site.data.keyword.containershort_notm}}](/images/user-policies.png)

Figure. Droits d'accès {{site.data.keyword.containershort_notm}} par type de rôle

<br />



## Affectation de rôles avec l'interface graphique
{: #add_users}

Vous pouvez ajouter des utilisateurs à un compte {{site.data.keyword.Bluemix_notm}} pour octroyer l'accès à vos clusters en utilisant l'interface graphique.
{: shortdesc}

**Avant de commencer**

- Vérifiez que votre utilisateur est ajouté dans le compte. Si ce n'est pas le cas, [ajoutez-le](../iam/iamuserinv.html#iamuserinv).
- Vérifiez que vous disposez du [rôle Cloud Foundry](/docs/iam/mngcf.html#mngcf) `Manager` pour le compte {{site.data.keyword.Bluemix_notm}} que vous utilisez pour travailler.

**Pour affecter l'accès à un utilisateur :**

1. Accédez à **Gérer > Utilisateurs**. Une liste d'utilisateurs disposant de l'accès au compte s'affiche.

2. Cliquez sur le nom de l'utilisateur auquel vous souhaitez octroyer des droits. Si cet utilisateur n'est pas présent dans la liste, cliquez sur **Inviter des utilisateurs** pour l'ajouter au compte.

3. Affectez une règle.
  * Pour un groupe de ressources :
    1. Sélectionnez le groupe de ressources **default**. L'accès à {{site.data.keyword.containershort_notm}} ne peut être configuré que pour ce groupe de ressources par défaut.
  * Pour une ressource spécifique :
    1. Dans la liste **Services**, sélectionnez **{{site.data.keyword.containershort_notm}}**.
    2. Dans la liste **Région**, sélectionnez une région.
    3. Dans la liste **Instance de service**, sélectionnez le cluster pour lequel envoyer l'invitation à l'utilisateur. Pour identifier l'ID d'un cluster spécifique, exécutez la commande `ibmcloud ks clusters`.

4. Dans la section **Sélectionner des rôles**, choisissez un rôle. 

5. Cliquez sur **Affecter**.

6. Affectez un [rôle Cloud Foundry](/docs/iam/mngcf.html#mngcf).

7. Facultatif : affectez un [rôle d'infrastructure](/docs/iam/infrastructureaccess.html#infrapermission).

</br>

**Pour affecter l'accès à un groupe**

1. Accédez à **Gérer > Groupes d'accès**.

2. Créez un groupe d'accès.
  1. Cliquez sur **Créer** et indiquez un **Nom** et une **Description** à votre groupe. Cliquez sur **Créer**.
  2. Cliquez sur **Ajouter des utilisateurs** pour ajouter des personnes dans votre groupe d'accès. Une liste d'utilisateurs ayant accès à votre compte s'affiche.
  3. Sélectionnez la case à cocher en regard des utilisateurs que vous désirez ajouter dans le groupe. Une boîte de dialogue s'affiche.
  4. Cliquez sur **Ajouter au groupe**.

3. Pour affecter l'accès à un service spécifique, ajoutez l'ID de ce service.
  1. Cliquez sur **Ajouter un ID de service**.
  2. Sélectionnez la case à cocher en regard des utilisateurs que vous désirez ajouter dans le groupe. Une fenêtre contextuelle s'affiche.
  3. Cliquez sur **Ajouter au groupe**.

4. Affectez des règles d'accès. N'oubliez pas de revérifier les personnes que vous ajoutez dans votre groupe. Toutes les personnes dans ce groupe bénéficient du même niveau d'accès.
    * Pour un groupe de ressources :
        1. Sélectionnez le groupe de ressources **default**. L'accès à {{site.data.keyword.containershort_notm}} ne peut être configuré que pour ce groupe de ressources par défaut.
    * Pour une ressource spécifique :
        1. Dans la liste **Services**, sélectionnez **{{site.data.keyword.containershort_notm}}**.
        2. Dans la liste **Région**, sélectionnez une région.
        3. Dans la liste **Instance de service**, sélectionnez le cluster pour lequel envoyer l'invitation à l'utilisateur. Pour identifier l'ID d'un cluster spécifique, exécutez la commande `ibmcloud ks clusters`.

5. Dans la section **Sélectionner des rôles**, choisissez un rôle. 

6. Cliquez sur **Affecter**.

7. Affectez un [rôle Cloud Foundry](/docs/iam/mngcf.html#mngcf).

8. Facultatif : affectez un [rôle d'infrastructure](/docs/iam/infrastructureaccess.html#infrapermission).

<br />






## Autorisation des utilisateurs avec des rôles RBAC Kubernetes personnalisés
{: #rbac}

Les règles d'accès d'{{site.data.keyword.containershort_notm}} correspondent à certains rôles RBAC (Role-Based Access Control) de Kubernetes. Pour autoriser d'autres rôles Kubernetes qui diffèrent de la règle d'accès correspondante, vous pouvez personnaliser les rôles RBAC, puis affecter ces rôles à des personnes ou à des groupes d'utilisateurs.
{: shortdesc}

Par moment, vous aurez peut-être besoin de règles d'accès plus granulaires que celles d'IAM. Pas de problème ! Vous pouvez affecter des règles à des ressources Kubernetes spécifiques pour des utilisateurs ou des groupes. Vous pouvez créer un rôle et le lier à des utilisateurs spécifiques ou à un groupe. Pour plus d'informations, voir [Using RBAC Authorization ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#api-overview) dans la documentation Kubernetes.

Lorsqu'une liaison est créée pour un groupe, elle concerne tout utilisateur qui est ajouté ou supprimé dans ce groupe. Si vous ajoutez un utilisateur dans le groupe, il dispose également de cet accès supplémentaire. S'il est supprimé, son accès est révoqué.
{: tip}

Si vous désirez affecter l'accès à un service, par exemple dans le cadre d'une intégration continue avec le pipeline de distribution continue, vous pouvez utiliser des [comptes de service Kubernetes ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/reference/access-authn-authz/service-accounts-admin/).

**Avant de commencer**

- Ciblez l'[interface CLI de Kubernetes](cs_cli_install.html#cs_cli_configure) sur votre cluster.
- Vérifiez que l'utilisateur ou le groupe dispose au minimum de l'accès `Viewer` au niveau du service.


**Pour personnaliser des rôles RBAC :**

1.  Créez le rôle avec l'accès que vous souhaitez affecter.

    1. Créez un fichier `.yaml` pour définir le rôle avec l'accès que vous souhaitez affecter.

        ```
        kind: Role
        apiVersion: rbac.authorization.k8s.io/v1
        metadata:
          namespace: default
          name: my_role
        rules:
        - apiGroups: [""]
          resources: ["pods"]
          verbs: ["get", "watch", "list"]
        - apiGroups: ["apps", "extensions"]
          resources: ["daemonsets", "deployments"]
          verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
        ```
        {: codeblock}

        <table>
        <caption>Description des composants de ce fichier YAML</caption>
          <thead>
            <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants de ce fichier YAML</th>
          </thead>
          <tbody>
            <tr>
              <td><code>kind</code></td>
              <td>Indiquez `Role` pour octroyer l'accès aux ressources au sein d'un seul espace de nom, ou `ClusterRole` pour l'accès aux ressources sur l'ensemble du cluster.</td>
            </tr>
            <tr>
              <td><code>apiVersion</code></td>
              <td><ul><li>Pour les clusters exécutant Kubernetes 1.8 ou version ultérieure, utilisez `rbac.authorization.k8s.io/v1`. </li><li>Pour les versions antérieures, utilisez `apiVersion: rbac.authorization.k8s.io/v1beta1`.</li></ul></td>
            </tr>
            <tr>
              <td><code>metadata/namespace</code></td>
              <td><ul><li>Pour kind: `Role` : Indiquez l'espace de nom Kubernetes auquel l'accès est octroyé.</li><li>N'utilisez pas la zone `namespace` si vous créez un rôle `ClusterRole` qui s'applique au niveau du cluster.</li></ul></td>
            </tr>
            <tr>
              <td><code>metadata/name</code></td>
              <td>Attribuez un nom au rôle et utilisez ce nom par la suite lorsque vous liez le rôle.</td>
            </tr>
            <tr>
              <td><code>rules/apiGroups</code></td>
              <td><ul><li>Indiquez les groupes d'API Kubernetes avec lesquels vous voulez que les utilisateurs puissent interagir, par exemple `"apps"`, `"batch"` ou `"extensions"`. </li><li>Pour accéder au groupe d'API principal sur le chemin REST `api/v1`, laissez le groupe vide : `[""]`.</li><li>Pour plus d'informations, voir [API groups![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://v1-9.docs.kubernetes.io/docs/reference/api-overview/#api-groups) dans la documentation Kubernetes.</li></ul></td>
            </tr>
            <tr>
              <td><code>rules/resources</code></td>
              <td><ul><li>Indiquez les ressources Kubernetes auxquelles vous souhaitez octroyer l'accès, par exemple `"daemonsets"`, `"deployments"`, `"events"` ou `"ingresses"`.</li><li>Si vous indiquez `"nodes"`, le rôle dans la zone kind doit être `ClusterRole`.</li><li>Pour obtenir la liste des ressources, consultez le tableau intitulé [Resource types![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/reference/kubectl/cheatsheet/) sur la page Kubernetes Cheat Sheet.</li></ul></td>
            </tr>
            <tr>
              <td><code>rules/verbs</code></td>
              <td><ul><li>Indiquez les types d'action que vous souhaitez que les utilisateurs soient en mesure d'effectuer, par exemple `"get"`, `"list"`, `"describe"`, `"create"` ou `"delete"`. </li><li>Pour obtenir la liste complète des verbes, voir la [documentation `kubectl` ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/reference/kubectl/overview/).</li></ul></td>
            </tr>
          </tbody>
        </table>

    2.  Créez le rôle dans votre cluster.

        ```
        kubectl apply -f <path_to_yaml_file>
        ```
        {: pre}

    3.  Vérifiez que le rôle est créé.

        ```
        kubectl get roles
        ```
        {: pre}

2.  Associez des utilisateurs au rôle.

    1. Créez un fichier `.yaml` pour associer les utilisateurs au rôle que vous avez créé. Notez l'unique URL à utiliser pour chaque nom dans 'subjects'.

        ```
        kind: RoleBinding
        apiVersion: rbac.authorization.k8s.io/v1
        metadata:
          name: my_role_team1
          namespace: default
        subjects:
        - kind: User
          name: https://iam.ng.bluemix.net/kubernetes#user1@example.com
          apiGroup: rbac.authorization.k8s.io
        - kind: User
          name: https://iam.ng.bluemix.net/kubernetes#user2@example.com
          apiGroup: rbac.authorization.k8s.io
        - kind: User
          name: system:serviceaccount:<namespace>:<service_account_name>
          apiGroup: rbac.authorization.k8s.io
        roleRef:
          kind: Role
          name: custom-rbac-test
          apiGroup: rbac.authorization.k8s.io
        ```
        {: codeblock}

        <table>
        <caption>Description des composants de ce fichier YAML</caption>
          <thead>
            <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants de ce fichier YAML</th>
          </thead>
          <tbody>
            <tr>
              <td><code>kind</code></td>
              <td>Pour `kind`, indiquez `RoleBinding` pour les deux types de fichiers `.yaml` de rôle : `Role` (espace de nom) et `ClusterRole` (ensemble du cluster).</td>
            </tr>
            <tr>
              <td><code>apiVersion</code></td>
              <td><ul><li>Pour les clusters exécutant Kubernetes 1.8 ou version ultérieure, utilisez `rbac.authorization.k8s.io/v1`. </li><li>Pour les versions antérieures, utilisez `apiVersion: rbac.authorization.k8s.io/v1beta1`.</li></ul></td>
            </tr>
            <tr>
              <td><code>metadata/namespace</code></td>
              <td><ul><li>Pour kind: `Role` : Indiquez l'espace de nom Kubernetes auquel l'accès est octroyé.</li><li>N'utilisez pas la zone `namespace` si vous créez un rôle `ClusterRole` qui s'applique au niveau du cluster.</li></ul></td>
            </tr>
            <tr>
              <td><code>metadata/name</code></td>
              <td>Indiquez le nom de liaison du rôle.</td>
            </tr>
            <tr>
              <td><code>subjects/kind</code></td>
              <td>Pour kind, indiquez `User`.</td>
            </tr>
            <tr>
              <td><code>subjects/name</code></td>
              <td><ul><li>**Pour les utilisateurs individuels** : ajoutez l'adresse e-mail de l'utilisateur à l'URL suivante : `https://iam.ng.bluemix.net/kubernetes#`. Par exemple, `https://iam.ng.bluemix.net/kubernetes#user1@example.com`</li>
              <li>**Pour les comptes de service** : indiquez l'espace de nom et le nom du service. Par exemple : `system:serviceaccount:<namespace>:<service_account_name>`</li></ul></td>
            </tr>
            <tr>
              <td><code>subjects/apiGroup</code></td>
              <td>Utilisez `rbac.authorization.k8s.io`.</td>
            </tr>
            <tr>
              <td><code>roleRef/kind</code></td>
              <td>Entrez la même valeur que pour `kind` dans le fichier `.yaml` du rôle : `Role` ou `ClusterRole`.</td>
            </tr>
            <tr>
              <td><code>roleRef/name</code></td>
              <td>Entrez le nom du fichier `.yaml` du rôle.</td>
            </tr>
            <tr>
              <td><code>roleRef/apiGroup</code></td>
              <td>Utilisez `rbac.authorization.k8s.io`.</td>
            </tr>
          </tbody>
        </table>

    2. Créez la ressource de liaison de rôle (rolebinding) dans votre cluster.

        ```
        kubectl apply -f filepath/my_role_team1.yaml
        ```
        {: pre}

    3.  Vérifiez que la liaison est créée.

        ```
        kubectl get rolebinding
        ```
        {: pre}

Vous venez de créer et de lier un rôle RBAC Kubernetes personnalisé, effectuez à présent le suivi auprès des utilisateurs. Demandez-leur de tester une action qu'ils ont le droit d'effectuer en fonction du rôle, par exemple, supprimer un pod.


<br />



## Personnalisation des droits Infrastructure pour un utilisateur
{: #infra_access}

Lorsque vous définissez des règles d'infrastructure dans Identity and Access Management, des droits associés à un rôle sont attribués à un utilisateur. Certaines règles sont prédéfinies, mais d'autres peuvent être personnalisées. Pour personnaliser ces droits, vous devez vous connecter à l'infrastructure IBM Cloud (SoftLayer) et ajuster les droits dans cette infrastructure.
{: #view_access}

Par exemple, les **utilisateurs de base** peuvent redémarrer un noeud worker, mais ne peuvent pas recharger un noeud worker. Sans attribuer à cette personne des droits **Superutilisateur**, vous pouvez adapter les droits de l'infrastructure IBM Cloud (SoftLayer) et autoriser l'utilisateur à exécuter une commande de rechargement.

Si vous disposez de clusters à zones multiples, le propriétaire de votre compte d'infrastructure IBM Cloud (SoftLayer) doit activer la fonction Spanning VLAN pour que les noeuds situés dans des zones différentes puissent communiquer dans le cluster. Le propriétaire du compte peut également affecter à un utilisateur le droit **Réseau > Gérer spanning VLAN pour réseau** pour que cet utilisateur puisse activer la fonction Spanning VLAN.
{: tip}


1.  Connectez-vous à votre [compte {{site.data.keyword.Bluemix_notm}}](https://console.bluemix.net/), puis sélectionnez **Infrastructure** dans le menu.

2.  Accédez à **Compte** > **Utilisateurs** > **Liste d'utilisateurs**.

3.  Pour modifier les droits, sélectionnez un nom de profil utilisateur ou la colonne **Accès à l'unité**.

4.  Dans l'onglet **Autorisations du portail**, personnalisez l'accès de l'utilisateur. Les droits dont les utilisateurs ont besoin dépendent des ressources d'infrastructure qu'ils doivent utiliser :

    * Utilisez la liste déroulante **Droits rapides** pour affecter le rôle **Superutilisateur** qui octroie tous les droits à l'utilisateur.
    * Utilisez la liste déroulante **Droits rapides** pour affecter le rôle **Utilisateur de base** qui octroie à l'utilisateur certains droits, mais pas la totalité.
    * Si vous ne voulez pas octroyer tous les droits avec le rôle **Superutilisateur** ou si vous devez ajouter des droits au-delà du rôle **Utilisateur de base**, consultez le tableau suivant qui décrit les droits nécessaires pour exécuter des tâches courantes dans {{site.data.keyword.containershort_notm}}.

    <table summary="Droits Infrastructure pour les scénarios {{site.data.keyword.containershort_notm}} courants.">
     <caption>Droits Infrastructure souvent requis pour {{site.data.keyword.containershort_notm}}</caption>
     <thead>
      <th>Tâches courantes dans {{site.data.keyword.containershort_notm}}</th>
      <th>Droits Infrastructure requis par onglet</th>
     </thead>
     <tbody>
       <tr>
         <td><strong>Droits minimum</strong> : <ul><li>Créer un cluster.</li></ul></td>
         <td><strong>Equipements</strong> :<ul><li>Afficher les détails du serveur virtuel</li><li>Réamorcer le serveur et afficher les informations système IPMI (Intelligent Platform Management Interface)</li><li>Emettre les rechargements de système d'exploitation et lancer le noyau de secours</li></ul><strong>Compte</strong> : <ul><li>Ajouter/mettre à niveau des instances cloud</li><li>Ajouter un serveur</li></ul></td>
       </tr>
       <tr>
         <td><strong>Administration de clusters</strong> : <ul><li>Créer, mettre à jour et supprimer des clusters.</li><li>Ajouter, recharger et redémarrer des noeuds worker.</li><li>Afficher les réseaux locaux virtuels (VLAN).</li><li>Créer des sous-réseaux.</li><li>Déployer des pods et charger des services d'équilibreur de charge.</li></ul></td>
         <td><strong>Support</strong> :<ul><li>Afficher les tickets</li><li>Ajouter des tickets</li><li>Editer des tickets</li></ul>
         <strong>Equipements</strong> :<ul><li>Afficher les détails du serveur virtuel</li><li>Réamorcer le serveur et afficher les informations système IPMI (Intelligent Platform Management Interface)</li><li>Mettre à niveau le serveur</li><li>Emettre les rechargements de système d'exploitation et lancer le noyau de secours</li></ul>
         <strong>Services</strong> :<ul><li>Gérer les clés SSH</li></ul>
         <strong>Compte</strong> :<ul><li>Afficher le récapitulatif du compte</li><li>Ajouter/mettre à niveau des instances cloud</li><li>Annuler le serveur</li><li>Ajouter un serveur</li></ul></td>
       </tr>
       <tr>
         <td><strong>Stockage</strong> : <ul><li>Créer des réservations de volumes persistants pour mettre à disposition des volumes persistants.</li><li>Créer et gérer des ressources d'infrastructure de stockage.</li></ul></td>
         <td><strong>Services</strong> :<ul><li>Gérer le stockage</li></ul><strong>Compte</strong> :<ul><li>Ajouter du stockage</li></ul></td>
       </tr>
       <tr>
         <td><strong>Réseau privé</strong> : <ul><li>Gérer les VLAN privés pour la mise en réseau au sein d'un cluster.</li><li>Configurer la connectivité VPN pour les réseaux privés.</li></ul></td>
         <td><strong>Réseau</strong> :<ul><li>Gérer les routes de sous-réseau du réseau</li><li>Gérer les tunnels réseau IPSEC</li><li>Gérer les passerelles réseau</li><li>Administration VPN</li></ul></td>
       </tr>
       <tr>
         <td><strong>Réseau public</strong> :<ul><li>Configurer un équilibreur de charge public ou un réseau Ingress pour exposer des applications.</li></ul></td>
         <td><strong>Equipements</strong> :<ul><li>Gérer les équilibreurs de charge</li><li>Editer le nom d'hôte/domaine</li><li>Gérer le contrôle de port</li></ul>
         <strong>Réseau</strong> :<ul><li>Ajouter la fonction de calcul avec le port réseau public</li><li>Gérer les routes de sous-réseau du réseau</li><li>Ajouter des adresses IP</li></ul>
         <strong>Services</strong> :<ul><li>Gérer DNS, RDNS et WHOIS</li><li>Afficher les certificats (SSL)</li><li>Gérer les certificats (SSL)</li></ul></td>
       </tr>
     </tbody>
    </table>

5.  Pour enregistrer vos modifications, cliquez sur **Modifier droits pour le portail**.

6.  Dans l'onglet **Accès à l'unité**, sélectionnez les unités auxquelles accorder l'accès.

    * Dans la liste déroulante **Type d'unité**, vous pouvez octroyer l'accès à **Tous les serveurs virtuels**.
    * Pour autoriser l'accès utilisateur aux nouvelles unités créées, sélectionnez **Accorder l'accès automatiquement lors de l'ajout de nouveaux appareils**.
    * Pour enregistrer vos modifications, cliquez sur **Mettre à jour l'accès à l'unité**.

Rétromigration de droits ? Cette action peut prendre quelques minutes.
{: tip}

<br />

