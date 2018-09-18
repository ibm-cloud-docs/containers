---

copyright:
  years: 2017, 2018
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


# Evénements {{site.data.keyword.cloudaccesstrailshort}}
{: #at_events}

Vous pouvez afficher et gérer des activités initiées par l'utilisateur ou effectuer un audit de ces activités dans votre cluster {{site.data.keyword.containershort_notm}} en utilisant le service {{site.data.keyword.cloudaccesstrailshort}}.
{: shortdesc}

## Recherche des informations
{: #at-find}

Les événements {{site.data.keyword.cloudaccesstrailshort}} sont disponibles dans le **domaine de compte** {{site.data.keyword.cloudaccesstrailshort}} qui se trouve dans la région {{site.data.keyword.Bluemix_notm}} où les événements sont générés. Les événements {{site.data.keyword.cloudaccesstrailshort}} sont disponibles dans le **domaine espace** {{site.data.keyword.cloudaccesstrailshort}} associé à votre espace Cloud Foundry dans lequel le service {{site.data.keyword.cloudaccesstrailshort}} est mis à disposition.

Pour surveiller les activités d'administration :

1. Connectez-vous à votre compte {{site.data.keyword.Bluemix_notm}}.
2. Dans le catalogue, mettez à disposition une instance du service {{site.data.keyword.cloudaccesstrailshort}} dans le même compte que votre instance {{site.data.keyword.containershort_notm}}.
3. Dans l'onglet  **Gérer** du tableau de bord {{site.data.keyword.cloudaccesstrailshort}}, cliquez sur **Afficher dans Kibana**.
4. Définissez la période pour laquelle vous désirez consulter les journaux. La valeur par défaut est 15 min.
5. Dans la liste **Zones disponibles**, cliquez sur **type**. Cliquez sur l'icône représentant une loupe pour qu'**Activity Tracker** limite les journaux uniquement à ceux dont le suivi est assuré par le service.
6. Vous pouvez utiliser les autres zones disponibles pour affiner la recherche.



## Suivi des événements
{: #events}

Consultez les tableaux suivants pour obtenir la liste des événements envoyés à {{site.data.keyword.cloudaccesstrailshort}}.

Pour plus d'informations sur le fonctionnement de ce service, voir les [documents sur {{site.data.keyword.cloudaccesstrailshort}}](/docs/services/cloud-activity-tracker/index.html).

Pour plus d'informations sur les actions de Kubernetes suivies, consultez la [documentation de Kubernetes![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/home/).

<table>
  <tr>
    <th>Action</th>
    <th>Description</th>
  </tr>
  <tr>
    <td><code>bindings.create</code></td>
    <td>Une liaison a été créée.</td>
  </tr>
  <tr>
    <td><code>configmaps.create</code></td>
    <td>Une mappe de configuration a été créée.</td>
  </tr>
  <tr>
    <td><code>configmaps.delete</code></td>
    <td>Une mappe de configuration a été supprimée.</td>
  </tr>
  <tr>
    <td><code>configmaps.patch</code></td>
    <td>Un correctif d'application a été appliqué à la mappe de configuration.</td>
  </tr>
  <tr>
    <td><code>configmaps.update</code></td>
    <td>Une mappe de configuration a été mise à jour.</td>
  </tr>
  <tr>
    <td><code>events.create</code></td>
    <td>Un événement a été créé.</td>
  </tr>
  <tr>
    <td><code>events.delete</code></td>
    <td>Un événement a été supprimé.</td>
  </tr>
  <tr>
    <td><code>events.patch</code></td>
    <td>Un correctif a été appliqué à un événement.</td>
  </tr>
  <tr>
    <td><code>events.update</code></td>
    <td>Un événement a été mis à jour.</td>
  </tr>
  <tr>
    <td><code>limitranges.create</code></td>
    <td>Une limite de plage a été créée.</td>
  </tr>
  <tr>
    <td><code>limitranges.delete</code></td>
    <td>Une limite de plage a été supprimée.</td>
  </tr>
  <tr>
    <td><code>limitranges.patch</code></td>
    <td>Un correctif a été appliqué à une limite de plage.</td>
  </tr>
  <tr>
    <td><code>limitranges.update</code></td>
    <td>Une limite de plage a été mise à jour.</td>
  </tr>
  <tr>
    <td><code>namespaces.create</code></td>
    <td>Un espace de nom a été créé.</td>
  </tr>
  <tr>
    <td><code>namespaces.delete</code></td>
    <td>Un espace de nom a été supprimé.</td>
  </tr>
  <tr>
    <td><code>namespaces.patch</code></td>
    <td>Un correctif a été appliqué à un espace de nom.</td>
  </tr>
  <tr>
    <td><code>namespaces.update</code></td>
    <td>Un espace de nom a été mis à jour.</td>
  </tr>
  <tr>
    <td><code>nodes.create</code></td>
    <td>Un noeud a été créé.</td>
  </tr>
  <tr>
    <td><code>nodes.delete</code></td>
    <td>Un noeud a été supprimé.</td>
  </tr>
  <tr>
    <td><code>nodes.delete</code></td>
    <td>Un noeud a été supprimé.</td>
  </tr>
  <tr>
    <td><code>nodes.patch</code></td>
    <td>Un correctif a été appliqué à un noeud.</td>
  </tr>
  <tr>
    <td><code>nodes.update</code></td>
    <td>Un noeud a été mis à jour.</td>
  </tr>
  <tr>
    <td><code>persistentvolumeclaims.create</code></td>
    <td>Une réservation de volume persistant a été créée.</td>
  </tr>
  <tr>
    <td><code>persistentvolumeclaims.delete</code></td>
    <td>Une réservation de volume persistant a été supprimée.</td>
  </tr>
  <tr>
    <td><code>persistentvolumeclaims.patch</code></td>
    <td>Un correctif a été appliqué à une réservation de volume persistant.</td>
  </tr>
  <tr>
    <td><code>persistentvolumeclaims.update</code></td>
    <td>Une réservation de volume persistant a été mise à jour.</td>
  </tr>
  <tr>
    <td><code>persistentvolumes.create</code></td>
    <td>Un volume persistant a été créé.</td>
  </tr>
  <tr>
    <td><code>persistentvolumes.delete</code></td>
    <td>Un volume persistant a été supprimé.</td>
  </tr>
  <tr>
    <td><code>persistentvolumes.patch</code></td>
    <td>Un correctif a été appliqué à un volume persistant.</td>
  </tr>
  <tr>
    <td><code>persistentvolumes.update</code></td>
    <td>Un volume persistant a été mis à jour.</td>
  </tr>
  <tr>
    <td><code>pods.create</code></td>
    <td>Un pod a été créé.</td>
  </tr>
  <tr>
    <td><code>pods.delete</code></td>
    <td>Un pod a été supprimé.</td>
  </tr>
  <tr>
    <td><code>pods.patch</code></td>
    <td>Un correctif a été appliqué à un pod.</td>
  </tr>
  <tr>
    <td><code>pods.update</code></td>
    <td>Un pod a été mis à jour.</td>
  </tr>
  <tr>
    <td><code>podtemplates.create</code></td>
    <td>Un modèle de pod a été créé.</td>
  </tr>
  <tr>
    <td><code>podtemplates.delete</code></td>
    <td>Un modèle de pod a été supprimé.</td>
  </tr>
  <tr>
    <td><code>podtemplates.patch</code></td>
    <td>Un correctif a été appliqué à un modèle de pod.</td>
  </tr>
  <tr>
    <td><code>podtemplates.update</code></td>
    <td>Un modèle de pod a été mis à jour.</td>
  </tr>
  <tr>
    <td><code>replicationcontrollers.create</code></td>
    <td>Un contrôleur de réplication a été créé.</td>
  </tr>
  <tr>
    <td><code>replicationcontrollers.delete</code></td>
    <td>Un contrôleur de réplication a été supprimé.</td>
  </tr>
  <tr>
    <td><code>replicationcontrollers.patch</code></td>
    <td>Un correctif a été appliqué à un contrôleur de réplication.</td>
  </tr>
  <tr>
    <td><code>replicationcontrollers.update</code></td>
    <td>Un contrôleur de réplication a été supprimé.</td>
  </tr>
  <tr>
    <td><code>resourcequotas.create</code></td>
    <td>Un quota de ressources a été créé.</td>
  </tr>
  <tr>
    <td><code>resourcequotas.delete</code></td>
    <td>Un quota de ressources a été supprimé.</td>
  </tr>
  <tr>
    <td><code>resourcequotas.patch</code></td>
    <td>Un correctif a été appliqué à un quota de ressources.</td>
  </tr>
  <tr>
    <td><code>resourcequotas.update</code></td>
    <td>Un quota de ressources a été mis à jour.</td>
  </tr>
  <tr>
    <td><code>secrets.create</code></td>
    <td>Une valeur confidentielle a été créée.</td>
  </tr>
  <tr>
    <td><code>secrets.deleted</code></td>
    <td>Une valeur confidentielle a été supprimée.</td>
  </tr>
  <tr>
    <td><code>secrets.get</code></td>
    <td>Une valeur confidentielle a été affichée.</td>
  </tr>
  <tr>
    <td><code>secrets.patch</code></td>
    <td>Un correctif a été appliqué à une valeur confidentielle.</td>
  </tr>
  <tr>
    <td><code>secrets.updated</code></td>
    <td>Une valeur confidentielle a été mise à jour.</td>
  </tr>
  <tr>
    <td><code>serviceaccounts.create</code></td>
    <td>Un compte de service a été créé.</td>
  </tr>
  <tr>
    <td><code>serviceaccounts.deleted</code></td>
    <td>Un compte de service a été supprimé.</td>
  </tr>
  <tr>
    <td><code>serviceaccounts.patch</code></td>
    <td>Un correctif a été appliqué à un compte de service.</td>
  </tr>
  <tr>
    <td><code>serviceaccounts.updated</code></td>
    <td>Un compte de service a été mis à jour.</td>
  </tr>
  <tr>
    <td><code>services.create</code></td>
    <td>Un service a été créé.</td>
  </tr>
  <tr>
    <td><code>services.deleted</code></td>
    <td>Un service a été supprimé.</td>
  </tr>
  <tr>
    <td><code>services.patch</code></td>
    <td>Un correctif a été appliqué à un service.</td>
  </tr>
  <tr>
    <td><code>services.updated</code></td>
    <td>Un service a été mis à jour.</td>
  </tr>
  <tr>
    <td><code>mutatingwebhookconfigurations.create</code></td>
    <td>Dans Kubernetes version 1.9 et ultérieure, une configuration de webhook de mutation a été créée.</td>
  </tr>
  <tr>
    <td><code>mutatingwebhookconfigurations.delete</code></td>
    <td>Dans Kubernetes version 1.9 et ultérieure, une configuration de webhook de mutation a été supprimée.</td>
  </tr>
  <tr>
    <td><code>mutatingwebhookconfigurations.patch</code></td>
    <td>Dans Kubernetes version 1.9 et ultérieure, un correctif a été appliqué à une configuration de weekhook de mutation.</td>
  </tr>
  <tr>
    <td><code>mutatingwebhookconfigurations.update</code></td>
    <td>Dans Kubernetes version 1.9 et ultérieure, une configuration de webhook de mutation a été mise à jour.</td>
  </tr>
  <tr>
    <td><code>validatingwebhookconfigurations.create</code></td>
    <td>Dans Kubernetes version 1.9 et ultérieure, une configuration de webhook de validation a été créée.</td>
  </tr>
  <tr>
    <td><code>validatingwebhookconfigurations.delete</code></td>
    <td>Dans Kubernetes version 1.9 et ultérieure, une configuration de webhook de validation a été supprimée.</td>
  </tr>
  <tr>
    <td><code>validatingwebhookconfigurations.patch</code></td>
    <td>Dans Kubernetes version 1.9 et ultérieure, un correctif a été appliqué à une configuration de webhook de validation.</td>
  </tr>
  <tr>
    <td><code>validatingwebhookconfigurations.update</code></td>
    <td>Dans Kubernetes version 1.9 et ultérieure, une configuration de webhook de validation a été mise à jour.</td>
  </tr>
  <tr>
    <td><code>externaladmissionhookconfigurations.create</code></td>
    <td>Dans Kubernetes version 1.8, une configuration de type externaladmissionhookconfiguration a été créée.</td>
  </tr>
  <tr>
    <td><code>externaladmissionhookconfigurations.delete</code></td>
    <td>Dans Kubernetes version 1.8, une configuration de type externaladmissionhookconfiguration a été supprimée.</td>
  </tr>
  <tr>
    <td><code>externaladmissionhookconfigurations.patch</code></td>
    <td>Dans Kubernetes version 1.8, un correctif a été appliqué à une configuration de type externaladmissionhookconfiguration.</td>
  </tr>
  <tr>
    <td><code>externaladmissionhookconfigurations.update</code></td>
    <td>Dans Kubernetes version 1.8, une configuration de type externaladmissionhookconfiguration a été mise à jour.</td>
  </tr>
  <tr>
    <td><code>controllerrevisions.create</code></td>
    <td>Une révision de contrôleur a été créée.</td>
  </tr>
  <tr>
    <td><code>controllerrevisions.delete</code></td>
    <td>Une révision de contrôleur a été supprimée.</td>
  </tr>
  <tr>
    <td><code>controllerrevisions.patch</code></td>
    <td>Un correctif a été appliqué à une révision de contrôleur.</td>
  </tr>
  <tr>
    <td><code>controllerrevisions.update</code></td>
    <td>Une révision de contrôleur a été mise à jour.</td>
  </tr>
  <tr>
    <td><code>daemonsets.create</code></td>
    <td>Un DaemonSet a été créé.</td>
  </tr>
  <tr>
    <td><code>daemonsets.delete</code></td>
    <td>Un DaemonSet a été supprimé.</td>
  </tr>
  <tr>
    <td><code>daemonsets.patch</code></td>
    <td>Un correctif a été appliqué à un DaemonSet.</td>
  </tr>
  <tr>
    <td><code>daemonsets.update</code></td>
    <td>Un DaemonSet a été mis à jour.</td>
  </tr>
  <tr>
    <td><code>deployments.create</code></td>
    <td>Un déploiement a été créé.</td>
  </tr>
  <tr>
    <td><code>deployments.delete</code></td>
    <td>Un déploiement a été supprimé.</td>
  </tr>
  <tr>
    <td><code>deployments.patch</code></td>
    <td>Un correctif a été appliqué à un déploiement.</td>
  </tr>
  <tr>
    <td><code>deployments.update</code></td>
    <td>Un déploiement a été mis à jour.</td>
  </tr>
  <tr>
    <td><code>replicasets.create</code></td>
    <td>Un jeu de répliques a été créé.</td>
  </tr>
  <tr>
    <td><code>replicasets.delete</code></td>
    <td>Un jeu de répliques a été supprimé.</td>
  </tr>
  <tr>
    <td><code>replicasets.patch</code></td>
    <td>Un correctif a été appliqué à un jeu de répliques.</td>
  </tr>
  <tr>
    <td><code>replicasets.update</code></td>
    <td>Un jeu de répliques a été mis à jour.</td>
  </tr>
  <tr>
    <td><code>statefulsets.create</code></td>
    <td>Un objet StatefulSet a été créé.</td>
  </tr>
  <tr>
    <td><code>statefulsets.delete</code></td>
    <td>Un objet StatefulSet a été supprimé.</td>
  </tr>
  <tr>
    <td><code>statefulsets.patch</code></td>
    <td>Un correctif a été appliqué à un objet StatefulSet.</td>
  </tr>
  <tr>
    <td><code>statefulsets.update</code></td>
    <td>Un objet StatefulSet a été mis à jour.</td>
  </tr>
  <tr>
    <td><code>tokenreviews.create</code></td>
    <td>Un objet TokenReview a été créé.</td>
  </tr>
  <tr>
    <td><code>localsubjectaccessreviews.create</code></td>
    <td>Une révision d'accès de type LocalSubjectAccessReview a été créée.</td>
  </tr>
  <tr>
    <td><code>selfsubjectaccessreviews.create</code></td>
    <td>Une révision d'accès de type SelfSubjectAccessReview a été créée.</td>
  </tr>
  <tr>
    <td><code>selfsubjectrulesreviews.create</code></td>
    <td>Une révision d'accès de type SelfSubjectRulesReview a été créée.</td>
  </tr>
  <tr>
    <td><code>subjectaccessreviews.create</code></td>
    <td>Une révision d'accès de type SubjectAccessReview a été créée.</td>
  </tr>
  <tr>
    <td><code>horizontalpodautoscalers.create</code></td>
    <td>Une règle de mise à l'échelle de pod horizontale a été créée.</td>
  </tr>
  <tr>
    <td><code>horizontalpodautoscalers.delete</code></td>
    <td>Une règle de mise à l'échelle de pod horizontale a été supprimée.</td>
  </tr>
  <tr>
    <td><code>horizontalpodautoscalers.patch</code></td>
    <td>Un correctif a été appliqué à une règle de mise à l'échelle de pod horizontale.</td>
  </tr>
  <tr>
    <td><code>horizontalpodautoscalers.update</code></td>
    <td>Une règle de mise à l'échelle de pod horizontale a été mise à jour.</td>
  </tr>
  <tr>
    <td><code>jobs.create</code></td>
    <td>Un travail a été créé.</td>
  </tr>
  <tr>
    <td><code>jobs.delete</code></td>
    <td>Un travail a été supprimé.</td>
  </tr>
  <tr>
    <td><code>jobs.patch</code></td>
    <td>Un correctif a été appliqué à un travail.</td>
  </tr>
  <tr>
    <td><code>jobs.update</code></td>
    <td>Un travail a été mis à jour.</td>
  </tr>
  <tr>
    <td><code>certificatesigningrequests.create</code></td>
    <td>Une demande de signature de certificat a été créée.</td>
  </tr>
  <tr>
    <td><code>certificatesigningrequests.delete</code></td>
    <td>Une demande de signature de certificat a été supprimée.</td>
  </tr>
  <tr>
    <td><code>certificatesigningrequests.patch</code></td>
    <td>Un correctif a été appliqué à une demande de signature de certificat.</td>
  </tr>
  <tr>
    <td><code>certificatesigningrequests.update</code></td>
    <td>Une demande de signature de certificat a été mise à jour.</td>
  </tr>
  <tr>
    <td><code>ingresses.create</code></td>
    <td>Un équilibreur de charge d'application (ALB) Ingress a été créé.</td>
  </tr>
  <tr>
    <td><code>ingresses.delete</code></td>
    <td>Un équilibreur de charge d'application (ALB) Ingress a été supprimé.</td>
  </tr>
  <tr>
    <td><code>ingresses.patch</code></td>
    <td>Un correctif a été appliqué à un équilibreur de charge d'application (ALB) Ingress.</td>
  </tr>
  <tr>
    <td><code>ingresses.update</code></td>
    <td>Un équilibreur de charge d'application (ALB) Ingress a été mis à jour.</td>
  </tr>
  <tr>
    <td><code>networkpolicies.create</code></td>
    <td>Une règle réseau a été créée.</td>
  </tr>
  <tr>
    <td><code>networkpolicies.delete</code></td>
    <td>Une règle réseau a été supprimée.</td>
  </tr>
  <tr>
    <td><code>networkpolicies.patch</code></td>
    <td>Un correctif a été appliqué à une règle réseau.</td>
  </tr>
  <tr>
    <td><code>networkpolicies.update</code></td>
    <td>Une règle réseau a été mise à jour.</td>
  </tr>
  <tr>
    <td><code>podsecuritypolicies.create</code></td>
    <td>Pour Kubernetes version 1.10 et ultérieure, une politique de sécurité de pod a été créée.</td>
  </tr>
  <tr>
    <td><code>podsecuritypolicies.delete</code></td>
    <td>Pour Kubernetes version 1.10 et ultérieure, une politique de sécurité de pod a été supprimée.</td>
  </tr>
  <tr>
    <td><code>podsecuritypolicies.patch</code></td>
    <td>Pour Kubernetes version 1.10 et ultérieure, un correctif a été appliqué à une politique de sécurité de pod.</td>
  </tr>
  <tr>
    <td><code>podsecuritypolicies.update</code></td>
    <td>Pour Kubernetes version 1.10 et ultérieure, une politique de sécurité de pod a été mise à jour.</td>
  </tr>
  <tr>
    <td><code>poddisruptionbudgets.create</code></td>
    <td>Un objet PodDisruptionBudget a été créé.</td>
  </tr>
  <tr>
    <td><code>poddisruptionbudgets.delete</code></td>
    <td>Un objet PodDisruptionBudget a été supprimé.</td>
  </tr>
  <tr>
    <td><code>poddisruptionbudgets.patch</code></td>
    <td>Un correctif a été appliqué à un objet PodDisruptionBudget.</td>
  </tr>
  <tr>
    <td><code>poddisruptionbudgets.update</code></td>
    <td>Un objet PodDisruptionBudget a été mis à jour.</td>
  </tr>
  <tr>
    <td><code>clusterbindings.create</code></td>
    <td>Une liaison de rôle de cluster a été créée.</td>
  </tr>
  <tr>
    <td><code>clusterbindings.deleted</code></td>
    <td>Une liaison de rôle de cluster a été supprimée.</td>
  </tr>
  <tr>
    <td><code>clusterbindings.patched</code></td>
    <td>Un correctif a été appliqué à une liaison de rôle de cluster.</td>
  </tr>
  <tr>
    <td><code>clusterbindings.updated</code></td>
    <td>Une liaison de rôle de cluster a été mise à jour.</td>
  </tr>
  <tr>
    <td><code>clusterroles.create</code></td>
    <td>Un rôle de cluster a été créé.</td>
  </tr>
  <tr>
    <td><code>clusterroles.deleted</code></td>
    <td>Un rôle de cluster a été supprimé.</td>
  </tr>
  <tr>
    <td><code>clusterroles.patched</code></td>
    <td>Un correctif a été appliqué à un rôle de cluster.</td>
  </tr>
  <tr>
    <td><code>clusterroles.updated</code></td>
    <td>Un rôle de cluster a été mis à jour.</td>
  </tr>
  <tr>
    <td><code>rolebindings.create</code></td>
    <td>Une liaison de rôle a été créée.</td>
  </tr>
  <tr>
    <td><code>rolebindings.deleted</code></td>
    <td>Une liaison de rôle a été supprimée.</td>
  </tr>
  <tr>
    <td><code>rolebindings.patched</code></td>
    <td>Un correctif a été appliqué à une liaison de rôle.</td>
  </tr>
  <tr>
    <td><code>rolebindings.updated</code></td>
    <td>Une liaison de rôle a été mise à jour.</td>
  </tr>
  <tr>
    <td><code>roles.create</code></td>
    <td>Un rôle a été créé.</td>
  </tr>
  <tr>
    <td><code>roles.deleted</code></td>
    <td>Un rôle a été supprimé.</td>
  </tr>
  <tr>
    <td><code>roles.patched</code></td>
    <td>Un correctif à été appliqué à un rôle.</td>
  </tr>
  <tr>
    <td><code>roles.updated</code></td>
    <td>Un rôle a été mis à jour.</td>
  </tr>
  <tr>
    <td><code>podpresets.create</code></td>
    <td>Un paramètre de pod prédéfini a été créé.</td>
  </tr>
  <tr>
    <td><code>podpresets.deleted</code></td>
    <td>Un paramètre de pod prédéfini a été supprimé.</td>
  </tr>
  <tr>
    <td><code>podpresets.patched</code></td>
    <td>Un correctif a été appliqué à un paramètre de pod prédéfini.</td>
  </tr>
  <tr>
    <td><code>podpresets.updated</code></td>
    <td>Un paramètre de pod prédéfini a été mis à jour.</td>
  </tr>
</table>
