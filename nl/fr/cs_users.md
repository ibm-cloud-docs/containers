---

copyright:
  years: 2014, 2018
lastupdated: "2018-09-10"


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
    <dd>Vous devez définir des règles d'accès pour tous les utilisateurs qui utilisent {{site.data.keyword.containerlong_notm}}. La portée d'une règle d'accès s'appuie sur un ou plusieurs rôles définis pour les utilisateurs qui déterminent les actions qu'ils sont autorisés à effectuer. Certaines règles sont prédéfinies, mais d'autres peuvent être personnalisées. La même règle s'applique que l'utilisateur effectue la demande à partir de l'interface graphique {{site.data.keyword.containerlong_notm}} ou de l'interface de ligne de commande (CLI), et ce, même si les actions sont exécutées dans l'infrastructure IBM Cloud (SoftLayer).</dd>

  <dt>Quels sont les types de droits d'accès ?</dt>
    <dd><p><strong>Plateforme</strong> : {{site.data.keyword.containerlong_notm}} est configuré pour utiliser des rôles de plateforme {{site.data.keyword.Bluemix_notm}} permettant de déterminer les actions que peuvent effectuer des personnes sur un cluster. Les droits associés à ce rôle se superposent, c'est-à-dire que le rôle d'éditeur (`Editor`) dispose des mêmes droits que le rôle d'afficheur (`Viewer`), en plus des droits octroyés à un éditeur. Vous pouvez définir ces règles par région. Elles doivent être définies avec des règles d'infrastructure et inclure les rôles RBAC correspondants qui sont automatiquement affectés à l'espace de nom par défaut. Exemples d'actions : créer ou retirer des clusters, ou ajouter des noeuds worker supplémentaires.</p> <p><strong>Infrastructure</strong> : vous pouvez déterminer les niveaux d'accès à votre infrastructure par exemple, les machines de noeud de cluster, les réseaux ou les ressources de stockage. Vous devez définir ce type de règle parallèlement aux règles d'accès à la plateforme {{site.data.keyword.containerlong_notm}}. Pour en savoir plus sur les rôles disponibles, consultez la rubrique [Droits Infrastructure](/docs/iam/infrastructureaccess.html#infrapermission). En plus de l'octroi de rôles d'infrastructure spécifiques, vous devez également accorder l'accès aux unités pour les utilisateurs qui utilisent l'infrastructure. Pour commencer à affecter des rôles, suivez les étapes indiquées dans la rubrique [Personnalisation des droits Infrastructure pour un utilisateur](#infra_access). <strong>Remarque </strong>: assurez-vous que votre compte {{site.data.keyword.Bluemix_notm}} est [configuré avec l'accès au portefeuille d'infrastructure IBM Cloud (SoftLayer)](cs_troubleshoot_clusters.html#cs_credentials) pour que les utilisateurs autorisés puissent effectuer des actions dans le compte d'infrastructure IBM Cloud (SoftLayer) en fonction des droits qui leur sont conférés.</p> <p><strong>RBAC </strong>: le mécanisme de contrôle d'accès basé sur des rôles (RBAC) est une méthode de sécurisation des ressources figurant dans votre cluster qui vous permet de décider qui peut effectuer des actions Kubernetes. Tous les utilisateurs auxquels a été affectée une règle d'accès Plateforme ont un rôle Kubernetes qui leur est automatiquement affecté. Dans Kubernetes, [RBAC (Role Based Access Control) ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#api-overview) détermine les actions possibles d'un utilisateur sur les ressources d'un cluster. <strong>Remarque </strong>: les rôles RBAC sont automatiquement définis en conjonction avec le rôle de plateforme pour l'espace de nom par défaut. En tant qu'administrateur de cluster, vous pouvez [mettre à jour ou affecter des rôles](#rbac) pour d'autres espaces de nom.</p> <p><strong>Cloud Foundry </strong>: les services ne peuvent pas tous être gérés par Cloud IAM. Si vous utilisez l'un de ces services, vous pouvez continuer à utiliser les [rôles d'utilisateur Cloud Foundry](/docs/iam/cfaccess.html#cfaccess) pour contrôler l'accès à vos services. Exemples d'actions : lier un service ou créer un nouvelle instance de service.</p></dd>

  <dt>Comment définir les droits d'accès ?</dt>
    <dd><p>Lorsque vous définissez des droits d'accès pour la plateforme, vous pouvez affecter l'accès à un utilisateur spécifique, à un groupe d'utilisateurs ou au groupe de ressources par défaut. Lorsque vous définissez ces droits d'accès pour la plateforme, des rôles RBAC sont automatiquement configurés pour l'espace de nom par défaut et l'élément RoleBinding est créé.</p>
    <p><strong>Utilisateurs </strong>: vous pouvez avoir un utilisateur en particulier qui nécessite plus ou moins de droits d'accès que les autres membres de votre équipe. Vous pouvez personnaliser les droits d'accès sur une base individuelle de sorte que chaque personne dispose des droits appropriés nécessaires pour accomplir sa tâche.</p>
    <p><strong>Groupes d'accès </strong>:  vous pouvez créer des groupes d'utilisateurs et affecter des droits à un groupe spécifique. Par exemple, vous pouvez rassembler tous vos chefs d'équipe au sein d'un groupe et accorder à ce groupe un accès administrateur. Alors qu'au même moment, votre groupe de développeurs ne bénéficiera que d'un accès en écriture.</p>
    <p><strong>Groupes de ressources </strong>: avec IAM, vous pouvez créer des règles d'accès pour un groupe de ressources et accorder l'accès utilisateur à ce groupe. Ces ressources peuvent faire partie d'un service {{site.data.keyword.Bluemix_notm}} ou vous pouvez également regrouper des ressources sur des instances de service, comme par exemple un cluster {{site.data.keyword.containerlong_notm}} et une application CF.</p> <p>**Important **: {{site.data.keyword.containerlong_notm}} ne prend en charge que le groupe de ressources <code>default</code>. Toutes les ressources liées au cluster sont automatiquement disponibles dans le groupe de ressources <code>default</code>. Si vous disposez d'autres services dans votre compte {{site.data.keyword.Bluemix_notm}} que vous souhaitez utiliser avec votre cluster, ces services doivent également figurer dans le groupe de ressources <code>default</code>.</p></dd>
</dl>


Vous vous sentez dépassé ? Suivez ce tutoriel consacré aux [meilleures pratiques en matière d'organisation des utilisateurs, des équipes et des applications](/docs/tutorials/users-teams-applications.html).
{: tip}

<br />


## Accès au portefeuille d'infrastructure IBM Cloud (SoftLayer)
{: #api_key}

<dl>
  <dt>Pourquoi dois-je accéder au portefeuille d'infrastructure IBM Cloud (SoftLayer) ?</dt>
    <dd>Pour mettre à disposition et travailler avec des clusters dans votre compte, vous devez vérifier que vous avez un compte défini correctement pour accéder au portefeuille d'infrastructure IBM Cloud (SoftLayer). Selon la configuration de votre compte, vous pouvez utiliser la clé d'API IAM ou les données d'identification d'infrastructure que vous avez définies manuellement avec la commande `ibmcloud ks credentials-set`.</dd>

  <dt>Comment fonctionne la clé d'API avec {{site.data.keyword.containerlong_notm}} ?</dt>
    <dd><p>La clé d'API IAM (Identity and Access Management) est définie automatiquement pour une région lorsque la première action qui nécessite la règle d'accès admin {{site.data.keyword.containerlong_notm}} est effectuée. Par exemple, supposons que l'un de vos administrateurs crée le premier cluster dans la région <code>us-south</code>. Pour cette opération, la clé d'API IAM de cet utilisateur est stockée dans le compte correspondant à cette région. La clé d'API est utilisée pour commander l'infrastructure IBM Cloud (SoftLayer), par exemple de nouveaux noeuds worker ou réseaux locaux virtuels (VLAN).</p> <p>Lorsqu'un autre utilisateur effectue une action qui nécessite une interaction avec le portefeuille d'infrastructure IBM Cloud (SoftLayer) dans cette région, par exemple la création d'un nouveau cluster ou le rechargement d'un noeud worker, la clé d'API stockée est utilisée pour déterminer s'il existe des droits suffisants pour effectuer cette action. Pour vous assurer que les actions liées à l'infrastructure dans votre cluster peuvent être effectuées sans problème, affectez à vos administrateurs {{site.data.keyword.containerlong_notm}} la règle d'accès <strong>Superutilisateur</strong> de l'infrastructure.</p> <p>Vous pouvez trouver le propriétaire actuel de la clé d'API en exécutant la commande [<code>ibmcloud ks api-key-info</code>](cs_cli_reference.html#cs_api_key_info). Si vous constatez que la clé d'API stockée pour une région nécessite une mise à jour, vous pouvez le faire en exécutant la commande [<code>ibmcloud ks api-key-reset</code>](cs_cli_reference.html#cs_api_key_reset). Cette commande nécessite la règle d'accès admin {{site.data.keyword.containerlong_notm}} et stocke la clé d'API de l'utilisateur qui exécute cette commande dans le compte. La clé d'API stockée pour la région ne peut pas être utilisée si les données d'identification de l'infrastructure IBM Cloud (SoftLayer) ont été définies manuellement à l'aide de la commande <code>ibmcloud ks credentials-set</code>.</p> <p><strong>Remarque :</strong> assurez-vous de vouloir réinitialiser la clé et d'en mesurer l'impact sur votre application. La clé est utilisée à plusieurs endroits et peut entraîner des modifications avec rupture si elle est modifiée inutilement.</p></dd>

  <dt>Que fait la commande <code>ibmcloud ks credentials-set</code> ?</dt>
    <dd><p>Si vous disposez d'un compte de paiement à la carte {{site.data.keyword.Bluemix_notm}}, vous avez accès au portefeuille d'infrastructure IBM Cloud (SoftLayer) par défaut. Cependant, vous pouvez utiliser un autre compte d'infrastructure IBM Cloud (SoftLayer) dont vous disposez déjà pour commander l'infrastructure pour les clusters au sein d'une région. Vous pouvez lier ce compte d'infrastructure à votre compte {{site.data.keyword.Bluemix_notm}} en utilisant la commande [<code>ibmcloud ks credentials-set</code>](cs_cli_reference.html#cs_credentials_set).</p> <p>Pour supprimer les données d'identification de l'infrastructure IBM Cloud (SoftLayer) définies manuellement, vous pouvez utiliser la commande [<code>ibmcloud ks credentials-unset</code>](cs_cli_reference.html#cs_credentials_unset). Une fois ces données supprimées, la clé d'API IAM est utilisée pour commander l'infrastructure.</p></dd>

  <dt>Y a-t-il une différence entre les données d'identification de l'infrastructure et la clé d'API ?</dt>
    <dd>La clé d'API et la commande <code>ibmcloud ks credentials-set</code> accomplissent la même tâche. Si vous définissez manuellement les données d'identification avec la commande <code>ibmcloud ks credentials-set</code>, ces données d'identification remplacent tous les accès octroyés par la clé d'API. Cependant, si l'utilisateur dont les données d'identification sont stockées ne dispose pas des droits requis pour commander l'infrastructure, les actions liées à l'infrastructure, comme par exemple la création d'un cluster ou le rechargement d'un noeud worker, risquent d'échouer.</dd>
    
  <dt>Comment savoir si les données d'identifications de mon infrastructure sont définies pour utiliser un autre compte ?</dt>
    <dd>Ouvrez l'[interface graphique d'{{site.data.keyword.containerlong_notm}} ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://console.bluemix.net/containers-kubernetes/clusters) et sélectionnez votre cluster. Dans l'onglet **Vue d'ensemble**, recherchez une zone correspondant à un **utilisateur d'infrastructure**. Si vous voyez cette zone, vous n'utilisez pas les données d'identification par défaut de l'infrastructure qui sont fournies avec un compte de type Paiement à la carte dans cette région. La région est définie pour utiliser d'autres données d'identification d'infrastructure à la place.</dd>

  <dt>Existe-t-il un moyen de rendre plus facile l'affectation des droits de l'infrastructure IBM Cloud (SoftLayer) ?</dt>
    <dd><p>En principe, les utilisateurs n'ont pas besoin de droits de l'infrastructure IBM Cloud (SoftLayer) spécifiques. Configurez à la place la clé d'API avec les droits d'infrastructure appropriés et utilisez cette clé d'API dans chaque région où vous désirez avoir des clusters. Lé clé d'API peut appartenir au propriétaire du compte, à un ID fonctionnel ou à un utilisateur en fonction de ce qui est plus facile pour vous à gérer et à contrôler.</p> <p>Pour créer un cluster dans une nouvelle région, assurez-vous que le premier cluster est créé par le propriétaire de la clé d'API que vous avez définie avec les données d'identification de l'infrastructure appropriées. Ensuite, vous pouvez inviter des personnes, des groupes IAM ou des utilisateurs de compte de service dans cette région. Les utilisateurs du compte partagent les données d'identification de la clé d'API pour effectuer des actions de l'infrastructure, comme ajouter des noeuds worker. Pour contrôler les actions de l'infrastructure qu'un utilisateur peut effectuer, affectez le rôle {{site.data.keyword.containerlong_notm}} approprié dans IAM.</p><p>Par exemple, un utilisateur avec le rôle IAM `Viewer` n'est pas autorisé à ajouter un noeud worker. Par conséquent, l'action `worker-add` échoue, même si la clé d'API dispose des droits d'infrastructure corrects. Si vous remplacez le rôle utilisateur par `Operator` dans IAM, l'utilisateur est autorisé à ajouter un noeud worker. L'action `worker-add` réussit car le rôle utilisateur est autorisé et la clé d'API est définie correctement. Vous n'avez pas besoin de modifier les droits de l'infrastructure IBM Cloud (SoftLayer) de l'utilisateur.</p> <p>Pour plus d'informations sur la définition des droits, consultez [Personnalisation des droits Infrastructure pour un utilisateur](#infra_access)</p></dd>
</dl>


<br />



## Description des relations entre les rôles
{: #user-roles}

Avant de vous familiariser avec les rôles et avec les actions pouvant être effectuées avec chacun de ces rôles, il est important de comprendre comment les rôles s'articulent.
{: shortdesc}

La figure suivante présente les rôles dont peuvent avoir besoin les différents types de personnes au sein de votre organisation. Cependant, ces rôles peuvent varier suivant les organisations. Vous pouvez remarquer que certains utilisateurs nécessitent des droits personnalisés pour l'infrastructure. Veillez à lire attentivement la rubrique [Accès au portefeuille d'infrastructure IBM Cloud (SoftLayer)](#api_key) pour vous familiariser avec les droits de l'infrastructure IBM Cloud (SoftLayer) et savoir qui doit en bénéficier. 

![Rôles d'accès {{site.data.keyword.containerlong_notm}}](/images/user-policies.png)

Figure. Droits d'accès {{site.data.keyword.containerlong_notm}} par type de rôle

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
    1. Sélectionnez le groupe de ressources **default**. L'accès à {{site.data.keyword.containerlong_notm}} ne peut être configuré que pour ce groupe de ressources par défaut.
  * Pour une ressource spécifique :
    1. Dans la liste **Services**, sélectionnez **{{site.data.keyword.containerlong_notm}}**.
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
        1. Sélectionnez le groupe de ressources **default**. L'accès à {{site.data.keyword.containerlong_notm}} ne peut être configuré que pour ce groupe de ressources par défaut.
    * Pour une ressource spécifique :
        1. Dans la liste **Services**, sélectionnez **{{site.data.keyword.containerlong_notm}}**.
        2. Dans la liste **Région**, sélectionnez une région.
        3. Dans la liste **Instance de service**, sélectionnez le cluster pour lequel envoyer l'invitation à l'utilisateur. Pour identifier l'ID d'un cluster spécifique, exécutez la commande `ibmcloud ks clusters`.

5. Dans la section **Sélectionner des rôles**, choisissez un rôle. 

6. Cliquez sur **Affecter**.

7. Affectez un [rôle Cloud Foundry](/docs/iam/mngcf.html#mngcf).

8. Facultatif : affectez un [rôle d'infrastructure](/docs/iam/infrastructureaccess.html#infrapermission).

<br />



## Affectation de rôles avec l'interface de ligne de commande (CLI)
{: #add_users_cli}

Vous pouvez ajouter des utilisateurs à un compte {{site.data.keyword.Bluemix_notm}} pour octroyer l'accès à vos clusters en utilisant l'interface de ligne de commande.
{: shortdesc}

**Avant de commencer**

Vérifiez que vous disposez du [rôle Cloud Foundry](/docs/iam/mngcf.html#mngcf) `Manager` pour le compte {{site.data.keyword.Bluemix_notm}} que vous utilisez pour travailler.

**Pour affecter l'accès à un utilisateur spécifique :**

1. Invitez l'utilisateur sur votre compte.
  ```
  ibmcloud account user-invite <user@email.com>
  ```
  {: pre}
2. Créez une règle d'accès IAM afin de définir les droits pour {{site.data.keyword.containerlong_notm}}. Vous pouvez choisir entre les rôles Viewer, Editor, Operator et Administrator.
  ```
  ibmcloud iam user-policy-create <user_email> --service-name containers-kubernetes --roles <role>
  ```
  {: pre}

**Pour affecter l'accès à un groupe** :

1. Si l'utilisateur ne fait pas déjà partie de votre compte, envoyez-lui une invitation.
  ```
  ibmcloud account user-invite <user_email>
  ```
  {: pre}

2. Créez un groupe.
  ```
  ibmcloud iam access-group-create <team_name>
  ```
  {: pre}

3. Ajoutez l'utilisateur à ce groupe.
  ```
  ibmcloud iam access-group-user-add <team_name> <user_email>
  ```
  {: pre}

4. Ajoutez l'utilisateur au groupe. Vous pouvez choisir entre les rôles Viewer, Editor, Operator et Administrator.
  ```
  ibmcloud iam access-group-policy-create <team_name> --service-name containers-kubernetes --roles <role>
  ```
  {: pre}

5. Mettez à jour la configuration de votre cluster pour générer une liaison de rôle (RoleBinding).
  ```
  ibmcloud ks cluster-config
  ```
  {: pre}

  Liaison de rôle :
  ```
  apiVersion: rbac.authorization.k8s.io/v1
  kind: RoleBinding
  metadata:
    name: <binding>
    namespace: default
  roleRef:
    apiGroup: rbac.authorization.k8s.io
    kind: ClusterRole
    name: <role>
  subjects:
  - apiGroup: rbac.authorization.k8s.io
    kind: Group
    name: <group_name>
    namespace: default
  ```
  {: screen}

Les instructions précédentes montrent comment octroyer l'accès d'un groupe d'utilisateurs à toutes les ressources d'{{site.data.keyword.containerlong_notm}}. En tant qu'administrateur, vous pouvez également limiter l'accès au service au niveau de la région ou de l'instance de cluster.
{: tip}

<br />


## Autorisation d'utilisateurs avec des liaisons de rôle RBAC
{: #role-binding}

Tous les clusters sont configurés avec des rôles RBAC prédéfinis qui sont configurés pour l'espace de nom par défaut de votre cluster. Vous pouvez copier les rôles RBAC de l'espace de nom par défaut dans d'autres espaces de nom de votre cluster pour appliquer le même niveau d'accès utilisateur.

**Qu'est-ce qu'une liaison de rôle RBAC ?**

Une liaison de rôle est une règle d'accès spécifique aux ressources Kubernetes. Vous pouvez utiliser des liaisons de rôle pour définir des règles spécifiques aux espaces de nom, aux pods ou à d'autres ressources figurant dans votre cluster. {{site.data.keyword.containerlong_notm}} fournit des rôles RBAC prédéfinis qui correspondent aux rôles de plateforme dans IAM. Lorsque vous affectez un rôle de plateforme IAM à un utilisateur, une liaison de rôle RBAC est automatiquement créée pour l'utilisateur dans l'espace de nom par défaut du cluster.

**Qu'est-ce qu'une liaison de rôle de cluster RBAC ?**

Alors qu'une liaison de rôle RBAC est spécifique à une ressource, telle qu'un espace de nom ou un pod, une liaison de rôle de cluster RBAC peut être utilisée pour définir des droits au niveau du cluster, ce qui inclut tous les espaces de nom. Les liaisons de rôle du cluster sont créées automatiquement pour l'espace de nom par défaut lorsque des rôles de plateforme sont définis. Vous pouvez copier cette liaison de rôle dans d'autres espaces de nom.


<table>
  <tr>
    <th>Rôle de plateforme</th>
    <th>Rôle RBAC</th>
    <th>Liaison de rôle</th>
  </tr>
  <tr>
    <td>Viewer</td>
    <td>View</td>
    <td><code>ibm-view</code></td>
  </tr>
  <tr>
    <td>Editor</td>
    <td>Edit</td>
    <td><code>ibm-edit</code></td>
  </tr>
  <tr>
    <td>Operator</td>
    <td>Admin</td>
    <td><code>ibm-operate</code></td>
  </tr>
  <tr>
    <td>Administrator</td>
    <td>Cluster-admin</td>
    <td><code>ibm-admin</code></td>
  </tr>
</table>

**Y a-t-il des exigences spécifiques lorsque vous utilisez des liaisons de rôle ?**

Pour utiliser des chartes IBM Helm, vous devez installer Tiller dans l'espace de nom `kube-system`. Pour pouvoir installer Tiller, vous devez disposer du rôle [`cluster-admin`](cs_users.html#access_policies)
dans l'espace de nom `kube-system`. Pour les autres chartes Helm, vous pouvez choisir un autre espace de nom. Toutefois, lorsque vous exécutez une commande `helm`, vous devez utiliser l'indicateur `tiller-namespace <namespace>` pour pointer vers l'espace de nom dans lequel est installé Tiller.


### Copie d'une liaison de rôle RBAC

Lorsque vous configurez les règles de votre plateforme, une liaison de rôle de cluster est générée automatiquement pour l'espace de nom par défaut. Vous pouvez copier la liaison dans d'autres espaces de nom en mettant à jour la liaison avec l'espace de nom pour lequel vous voulez définir la règle. Par exemple, admettons que vous disposiez d'une équipe de développeurs nommée `team-a` et que ces développeurs disposent des droits d'accès d'affichage (`view`) sur le service, mais que les droits d'accès en édition (`edit`) leur soient nécessaires pour  accéder à l'espace de nom `teama`. Vous pouvez éditer la liaison de rôle générée automatiquement pour leur fournir l'accès dont ils ont besoin au niveau de la ressource.

1. Créez une liaison de rôle RBAC pour l'espace de nom par défaut en [affectant l'accès avec un rôle de plateforme](#add_users_cli).
  ```
  ibmcloud iam access-policy-create <team_name> --service-name containers-kubernetes --roles <role>
  ```
  {: pre}
  Exemple de sortie :
  ```
  apiVersion: rbac.authorization.k8s.io/v1
  kind: RoleBinding
  metadata:
    name: ibm-view
    namespace: default
  roleRef:
    apiGroup: rbac.authorization.k8s.io
    kind: ClusterRole
    name: View
  subjects:
  - apiGroup: rbac.authorization.k8s.io
    kind: group
    name: team-a
    namespace: default
  ```
  {: screen}
2. Copiez cette configuration dans un autre espace de nom.
  ```
  ibmcloud iam access-policy-create <team_name> --service-name containers-kubernetes --roles <role> --namespace <namespace>
  ```
  {: pre}
  Dans le scénario précédent, j'ai apporté une modification à la configuration pour un autre espace de nom. La configuration mise à jour devrait ressembler à ceci :
  ```
  apiVersion: rbac.authorization.k8s.io/v1
  kind: RoleBinding
  metadata:
    name: ibm-edit
    namespace: teama
  roleRef:
    apiGroup: rbac.authorization.k8s.io
    kind: ClusterRole
    name: edit
  subjects:
  - apiGroup: rbac.authorization.k8s.io
    kind: group
    name: team-a
    namespace: teama
  ```
  {: screen}

<br />




### Création de rôles RBAC Kubernetes personnalisés
{: #rbac}

Pour autoriser d'autres rôles Kubernetes différents de la règle d'accès de plateforme correspondante, vous pouvez personnaliser les rôles RBAC, puis affecter ces rôles à des personnes ou à des groupes d'utilisateurs.
{: shortdesc}

Vous avez besoin des règles d'accès à votre cluster pour offrir plus de granularité qu'avec une règle IAM ? Pas de problème ! Vous pouvez affecter des règles d'accès à des ressources Kubernetes spécifiques à des utilisateurs, des groupes d'utilisateurs (dans les clusters qui exécutent Kubernetes version 1.11 ou ultérieure) ou des comptes de service. Vous pouvez créer un rôle et le lier à des utilisateurs spécifiques ou à un groupe. Pour plus d'informations, voir [Using RBAC Authorization ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#api-overview) dans la documentation Kubernetes.

Lorsqu'une liaison est créée pour un groupe, elle concerne tout utilisateur qui est ajouté ou supprimé dans ce groupe. Si vous ajoutez un utilisateur dans le groupe, il dispose également de cet accès supplémentaire. S'il est supprimé, son accès est révoqué.
{: tip}

Si vous désirez octroyer l'accès à un service, par exemple une chaîne d'outils de distribution continue, vous pouvez utiliser des [comptes de service Kubernetes ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/reference/access-authn-authz/service-accounts-admin/).

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
              <td>Indiquez `Role` pour octroyer l'accès aux ressources au sein d'un seul espace de nom, ou `ClusterRole` pour octroyer l'accès aux ressources à l'échelle du cluster.</td>
            </tr>
            <tr>
              <td><code>apiVersion</code></td>
              <td><ul><li>Pour les clusters exécutant Kubernetes 1.8 ou version ultérieure, utilisez `rbac.authorization.k8s.io/v1`. </li><li>Pour les versions antérieures, utilisez `apiVersion: rbac.authorization.k8s.io/v1beta1`.</li></ul></td>
            </tr>
            <tr>
              <td><code>metadata/namespace</code></td>
              <td><ul><li>Pour la section kind `Role` : indiquez l'espace de nom Kubernetes auquel l'accès est octroyé.</li><li>N'utilisez pas la zone `namespace` si vous créez un rôle `ClusterRole` qui s'applique au niveau du cluster.</li></ul></td>
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
          name: my_role_binding
          namespace: default
        subjects:
        - kind: User
          name: https://iam.ng.bluemix.net/kubernetes#user1@example.com
          apiGroup: rbac.authorization.k8s.io
        - kind: Group
          name: team1
          apiGroup: rbac.authorization.k8s.io
        - kind: ServiceAccount
          name: <service_account_name>
          namespace: <kubernetes_namespace>
        roleRef:
          kind: Role
          name: my_role
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
              <td><ul><li>Pour la section kind `Role` : indiquez l'espace de nom Kubernetes auquel l'accès est octroyé.</li><li>N'utilisez pas la zone `namespace` si vous créez un rôle `ClusterRole` qui s'applique au niveau du cluster.</li></ul></td>
            </tr>
            <tr>
              <td><code>metadata/name</code></td>
              <td>Indiquez le nom de liaison du rôle.</td>
            </tr>
            <tr>
              <td><code>subjects/kind</code></td>
              <td>Indiquez l'une des valeurs suivantes pour kind :
              <ul><li>`User` : liez le rôle RBAC à un utilisateur individuel dans votre compte.</li>
              <li>`Group` : pour les clusters exécutant Kubernetes version 1.11 ou ultérieure, liez le rôle RBAC à un [groupe IAM](/docs/iam/groups.html#groups) dans votre compte.</li>
              <li>`ServiceAccount` : liez le rôle RBAC à un compte de service dans un espace de votre cluster.</li></ul></td>
            </tr>
            <tr>
              <td><code>subjects/name</code></td>
              <td><ul><li>**Pour `User`** : ajoutez l'adresse e-mail de l'utilisateur individuel à l'URL suivante : `https://iam.ng.bluemix.net/kubernetes#`. Par exemple, `https://iam.ng.bluemix.net/kubernetes#user1@example.com`</li>
              <li>**Pour `Group`** : pour les clusters exécutant Kubernetes version 1.11 ou ultérieure, indiquez le nom du [groupe IAM](/docs/iam/groups.html#groups) dans votre compte.</li>
              <li>**Pour `ServiceAccount`** : spécifiez le nom du compte de service.</li></ul></td>
            </tr>
            <tr>
              <td><code>subjects/apiGroup</code></td>
              <td><ul><li>**Pour `User` ou `Group`** : utilisez `rbac.authorization.k8s.io`.</li>
              <li>**Pour `ServiceAccount`** : n'indiquez pas cette zone.</li></ul></td>
            </tr>
            <tr>
              <td><code>subjects/namespace</code></td>
              <td>**Pour `ServiceAccount` uniquement** : indiquez le nom de l'espace de nom Kubernetes dans lequel est déployé le compte de service.</td>
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
        kubectl apply -f filepath/my_role_binding.yaml
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

Si vous disposez de clusters à zones multiples, le propriétaire de votre compte d'infrastructure IBM Cloud (SoftLayer) doit activer la fonction Spanning VLAN pour que les noeuds situés dans des zones différentes puissent communiquer dans le cluster. Le propriétaire du compte peut également affecter à un utilisateur le droit **Réseau > Gérer spanning VLAN pour réseau** pour que cet utilisateur puisse activer la fonction Spanning VLAN. Pour vérifier si la fonction Spanning VLAN est déjà activée, utilisez la [commande](cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`.
{: tip}


1.  Connectez-vous à votre [compte {{site.data.keyword.Bluemix_notm}}](https://console.bluemix.net/), puis sélectionnez **Infrastructure** dans le menu.

2.  Accédez à **Compte** > **Utilisateurs** > **Liste d'utilisateurs**.

3.  Pour modifier les droits, sélectionnez un nom de profil utilisateur ou la colonne **Accès à l'unité**.

4.  Dans l'onglet **Autorisations du portail**, personnalisez l'accès de l'utilisateur. Les droits dont les utilisateurs ont besoin dépendent des ressources d'infrastructure qu'ils doivent utiliser :

    * Utilisez la liste déroulante **Droits rapides** pour affecter le rôle **Superutilisateur** qui octroie tous les droits à l'utilisateur.
    * Utilisez la liste déroulante **Droits rapides** pour affecter le rôle **Utilisateur de base** qui octroie à l'utilisateur certains droits, mais pas la totalité.
    * Si vous ne voulez pas octroyer tous les droits avec le rôle **Superutilisateur** ou si vous devez ajouter des droits au-delà du rôle **Utilisateur de base**, consultez le tableau suivant qui décrit les droits nécessaires pour exécuter des tâches courantes dans {{site.data.keyword.containerlong_notm}}.

    <table summary="Droits Infrastructure pour les scénarios {{site.data.keyword.containerlong_notm}} courants.">
     <caption>Droits Infrastructure souvent requis pour {{site.data.keyword.containerlong_notm}}</caption>
     <thead>
      <th>Tâches courantes dans {{site.data.keyword.containerlong_notm}}</th>
      <th>Droits Infrastructure requis par onglet</th>
     </thead>
     <tbody>
       <tr>
         <td><strong>Droits minimum</strong> : <ul><li>Créer un cluster.</li></ul></td>
         <td><strong>Equipements</strong> :<ul><li>Afficher les détails du serveur virtuel</li><li>Réamorcer le serveur et afficher les informations système IPMI (Intelligent Platform Management Interface)</li><li>Emettre les rechargements de système d'exploitation et lancer le noyau de secours</li></ul><strong>Compte</strong> : <ul><li>Ajouter/mettre à niveau des instances de cloud</li><li>Ajouter un serveur</li></ul></td>
       </tr>
       <tr>
         <td><strong>Administration de clusters</strong> : <ul><li>Créer, mettre à jour et supprimer des clusters.</li><li>Ajouter, recharger et redémarrer des noeuds worker.</li><li>Afficher les réseaux locaux virtuels (VLAN).</li><li>Créer des sous-réseaux.</li><li>Déployer des pods et charger des services d'équilibreur de charge.</li></ul></td>
         <td><strong>Support</strong> :<ul><li>Afficher les tickets</li><li>Ajouter des tickets</li><li>Editer des tickets</li></ul>
         <strong>Equipements</strong> :<ul><li>Afficher les détails du serveur virtuel</li><li>Réamorcer le serveur et afficher les informations système IPMI (Intelligent Platform Management Interface)</li><li>Mettre à niveau le serveur</li><li>Emettre les rechargements de système d'exploitation et lancer le noyau de secours</li></ul>
         <strong>Services</strong> :<ul><li>Gérer les clés SSH</li></ul>
         <strong>Compte</strong> :<ul><li>Afficher le récapitulatif du compte</li><li>Ajouter/mettre à niveau des instances de cloud</li><li>Annuler le serveur</li><li>Ajouter un serveur</li></ul></td>
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

