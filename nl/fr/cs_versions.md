---

copyright:
  years: 2014, 2018
lastupdated: "2018-12-06"

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
{:note: .note}
{:important: .important}
{:deprecated: .deprecated}
{:download: .download}



# Informations de version et actions de mise à jour
{: #cs_versions}

## Types de version Kubernetes
{: #version_types}

{{site.data.keyword.containerlong}} prend en charge plusieurs versions de Kubernetes simultanément. Lorsque la version la plus récente (n) est publiée, jusqu'à 2 versions antérieures (n-2) sont prises en charge. Les versions au-delà de deux versions avant la version la plus récente (n-3) sont d'abord dépréciées, puis finissent par ne plus être prises en charge.
{:shortdesc}

**Versions de Kubernetes prises en charge** :
- La plus récente : 1.12.3
- Par défaut : 1.10.11
- Autre : 1.11.5

</br>

**Versions dépréciées** : lorsque des clusters s'exécutent sur une version de Kubernetes dépréciée, vous disposez de 30 jours pour vérifier et passer à une version Kubernetes prise en charge. Passé ce délai, votre version ne sera plus prise en charge. Au cours de la période de dépréciation, votre cluster est toujours opérationnel mais peut nécessiter des mises à jour vers une version prise en charge pour corriger des vulnérabilités de sécurité. Vous ne pouvez pas créer de nouveaux clusters utilisant la version dépréciée.

**Versions non prises en charge** : si vous exécutez des clusters sur une version de Kubernetes qui n'est pas prise en charge, consultez les impacts potentiels concernant les mises à jour ci-dessous, puis [mettez à jour le cluster](cs_cluster_update.html#update) immédiatement pour continuer à recevoir les mises à jour de sécurité importantes et l'aide du support.
*  **Attention** : si vous attendez que votre cluster soit à une version secondaire au moins trois fois inférieure à une version prise en charge, vous devez forcer la mise à jour, ce qui peut occasionner des résultats inattendus ou provoquer des incidents.
*  Dans les clusters non pris en charge, il est impossible d'ajouter ou de recharger des noeuds worker.
*  Une fois que vous avez mis à jour le cluster pour passer à une version prise en charge, il peut effectuer à nouveau des opérations normales et continuer à recevoir l'aide du support.

</br>

Pour vérifier la version du serveur d'un cluster, exécutez la commande suivante.

```
kubectl version  --short | grep -i server
```
{: pre}

Exemple de sortie :

```
Server Version: v1.10.11+IKS
```
{: screen}


## Types de mise à jour
{: #update_types}

Votre cluster Kubernetes dispose de trois types de mise à jour : principale, secondaire et correctif.
{:shortdesc}

|Type de mise à jour|Exemples de libellé de version|Mis à jour par|Impact
|-----|-----|-----|-----|
|Principale|1.x.x|Vous|Modifications d'opérations pour les clusters, y compris scripts ou déploiements.|
|Secondaire|x.9.x|Vous|Modifications d'opérations pour les clusters, y compris scripts ou déploiements.|
|Correctif|x.x.4_1510|IBM et vous|Correctifs Kubernetes, ainsi que d'autres mises à jour du composant {{site.data.keyword.Bluemix_notm}} Provider, tels que des correctifs de sécurité et de système d'exploitation. IBM met automatiquement à jour les maîtres, mais c'est à vous d'appliquer les correctifs à vos noeuds worker. Vous trouverez plus d'informations sur les correctifs dans la section suivante.|
{: caption="Impacts des mises à jour Kubernetes" caption-side="top"}

A mesure que des mises à jour deviennent disponibles, vous en êtes informé lorsque vous affichez des informations sur les noeuds worker, par exemple avec les commandes `ibmcloud ks workers <cluster>` ou `ibmcloud ks worker-get <cluster> <worker>`.
-  **Mises à jour principale et secondaire** : commencez d'abord par [mettre à jour votre noeud maître](cs_cluster_update.html#master), puis [mettez à jour vos noeuds worker](cs_cluster_update.html#worker_node).
   - Par défaut, vous ne pouvez pas mettre à jour le maître Kubernetes au-delà de trois niveaux de version secondaire. Par exemple, si votre version actuelle du maître est 1.9 et que vous voulez passer à la version 1.12, vous devez d'abord passer à la version 1.10. Vous pouvez forcer la mise à jour pour continuer, mais effectuer une mise à jour au-delà de deux niveaux de version secondaire par rapport à la version en cours risque d'entraîner des résultats inattendus ou provoquer des incidents.
   - Si vous utilisez une version d'interface CLI `kubectl` qui ne correspond pas au moins à la version principale et secondaire (`major.minor`) de vos clusters, vous risquez d'obtenir des résultats inattendus. Assurez-vous de maintenir votre cluster Kubernetes et les [versions CLI](cs_cli_install.html#kubectl) à jour.
-  **Mises à jour de correctif** : les modifications sur les correctifs sont documentées dans le [Journal des modifications de version](cs_versions_changelog.html). Dès que des mises à jour deviennent disponibles, vous en êtes informé lorsque vous affichez des informations sur le maître ou les noeuds worker dans la console {{site.data.keyword.Bluemix_notm}} ou l'interface de ligne de commande (CLI), par exemple en exécutant les commandes suivantes : `ibmcloud ks clusters`, `cluster-get`, `workers` ou `worker-get`.
   - **Correctifs de noeud worker** : vérifiez tous les mois pour voir s'il y a une mise à jour disponible et utilisez la [commande](cs_cli_reference.html#cs_worker_update) `ibmcloud ks worker-update` ou la [commande](cs_cli_reference.html#cs_worker_reload) `ibmcloud ks worker-reload` pour appliquer ces correctifs de sécurité et de système d'exploitation. Notez que durant une mise à jour ou un rechargement, la machine de votre noeud worker est réimagée et les données sont supprimées si elles ne sont pas [stockées hors du noeud worker](cs_storage_planning.html#persistent_storage_overview).
   - **Correctifs du maître** : les correctifs du maître sont appliqués automatiquement sur plusieurs jours, de sorte que la version d'un correctif de maître s'affiche comme étant disponible avant d'être appliquée à votre maître. L'automatisation de la mise à jour ignore également les clusters qui ne sont pas dans un état sain ou dont les opérations sont encore en cours d'exécution. Occasionnellement, IBM peut désactiver les mises à jour automatiques pour un groupe de correctifs de maître spécifique, comme indiqué dans le journal des modifications, par exemple un correctif nécessaire uniquement si un maître est mis à jour d'une version secondaire à une autre. Pour chacun de ces cas de figure, vous pouvez choisir d'utiliser la [commande](cs_cli_reference.html#cs_cluster_update) `ibmcloud ks cluster-update` vous-même en toute sécurité sans attendre l'application de la mise à jour automatique.

</br>

Ces informations récapitulent les mises à jour susceptibles d'avoir un impact sur les applications déployées lorsque vous mettez à jour un cluster vers une nouvelle version à partir de la version précédente.
-  [Actions de préparation](#cs_v112) - Version 1.12.
-  [Actions de préparation](#cs_v111) - Version 1.11.
-  [Actions de préparation](#cs_v110) - Version 1.10.
-  [Archive](#k8s_version_archive) des versions dépréciées ou non prises en charge.

<br/>

Pour obtenir la liste complète des modifications, consultez les informations suivantes :
* [Journal des modifications de Kubernetes ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG.md).
* [Journal des modifications de version IBM](cs_versions_changelog.html).

</br>

## Version 1.12
{: #cs_v112}

<p><img src="images/certified_kubernetes_1x12.png" style="padding-right: 10px;" align="left" alt="Ce badge indique une certification Kubernetes version 1.12 pour IBM Cloud Container Service."/> {{site.data.keyword.containerlong_notm}} est un produit certifié Kubernetes pour la version 1.12 sous le programme CNCF de certification de conformité logicielle de Kubernetes. _Kubernetes® est une marque de la Fondation Linux aux Etats-Unis et dans d'autres pays et est utilisé dans le cadre d'une licence de la Fondation Linux._</p>

Passez en revue les modifications que vous devrez peut-être apporter lors d'une mise à jour de la version Kubernetes précédente vers la version 1.12.
{: shortdesc}

### Mise à jour avant le maître
{: #112_before}

Le tableau suivant présente les actions que vous devez effectuer avant de mettre à jour le maître Kubernetes. 
{: shortdesc}

<table summary="Mise à jour de Kubernetes pour la version 1.12">
<caption>Modifications à effectuer avant la mise à jour du maître vers Kubernetes 1.12</caption>
<thead>
<tr>
<th>Type</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes Metrics Server</td>
<td>Si le serveur de métriques Kubernetes `metric-server` est déployé dans votre cluster, vous devez le retirer avant de mettre à jour le cluster à la version 1.12 de Kubernetes. Ce retrait permet d'éviter les conflits avec le serveur `metric-server` déployé lors de la mise à jour.</td>
</tr>
<tr>
<td>Liaisons de rôle pour le compte de service `kube-system` `default`</td>
<td>Le compte de service `kube-system` `default` n'a plus l'accès **cluster-admin** à l'API Kubernetes. Si vous déployez des fonctions ou des modules complémentaires de type [Helm](cs_integrations.html#helm) qui nécessitent l'accès aux processus dans votre cluster, configurez un [compte de service ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/reference/access-authn-authz/service-accounts-admin/). Si vous avez besoin de temps pour créer et configurer des comptes de service individuels avec les droit appropriés, vous pouvez accorder provisoirement le rôle **cluster-admin** avec la liaison de rôle de cluster suivante : `kubectl create clusterrolebinding kube-system:default --clusterrole=cluster-admin --serviceaccount=kube-system:default`</td>
</tr>
</tbody>
</table>

### Mise à jour après le maître
{: #112_after}

Le tableau suivant présente les actions que vous devez effectuer après avoir mis à jour le maître Kubernetes. 
{: shortdesc}

<table summary="Mise à jour de Kubernetes pour la version 1.12">
<caption>Modifications à effectuer après la mise à jour du maître vers Kubernetes 1.12</caption>
<thead>
<tr>
<th>Type</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>API Kubernetes `apps/v1`</td>
<td>L'API Kubernetes `apps/v1` remplace les API `extensions`, `apps/v1beta1` et `apps/v1alpha`. Le projet Kubernetes déprécie et arrête progressivement la prise en charge des API précédentes du serveur d'API Kubernetes `apiserver` et du client `kubectl`.<br><br>Vous devez procéder à la mise à jour de toutes les zones `apiVersion` de votre fichier YAML pour utiliser l'API `apps/v1`. Consultez aussi la [documentation Kubernetes ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) pour les modifications liées à l'API `apps/v1`, par exemple :
<ul><li>Après avoir créé un déploiement, la zone `.spec.selector` est non modifiable.</li>
<li>La zone `.spec.rollbackTo` est dépréciée. Utilisez à la place la commande `kubectl rollout undo`.</li></ul></td>
</tr>
<tr>
<td>CoreDNS disponible en tant que fournisseur DNS de cluster</td>
<td>Le projet Kubernetes est en train d'évoluer pour prendre en charge CoreDNS à la place de Kubernetes DNS (KubeDNS) utilisé actuellement. Dans la version 1.12, le serveur DNS de cluster par défaut est toujours KubeDNS, mais vous pouvez [choisir d'utiliser CoreDNS](cs_cluster_update.html#dns).</td>
</tr>
<tr>
<td>`kubectl apply --force`</td>
<td>Désormais, lorsque vous forcez une action d'application (`kubectl apply --force`) sur des ressources qui ne peuvent pas être mises à jour, par exemple des zones non modifiables dans des fichiers YAML, les ressources sont recréées à la place. Si vos scripts reposent sur le comportement antérieur, mettez-les à jour.</td>
</tr>
<tr>
<td>`kubectl logs --interactive`</td>
<td>L'indicateur `--interactive` n'est plus pris en charge pour les journaux `kubectl logs`. Mettez à jour toute automatisation utilisant cet indicateur.</td>
</tr>
<tr>
<td>`kubectl patch`</td>
<td>Si la commande `patch` n'aboutit à aucun changement (correctif redondant), la commande n'existe plus avec un code retour `1`. Si vos scripts reposent sur le comportement antérieur, mettez-les à jour.</td>
</tr>
<tr>
<td>`kubectl version -c`</td>
<td>L'indicateur d'abréviation `-c` n'est plus pris en charge. Utilisez à la place l'indicateur `--client` complet. Mettez à jour toute automatisation utilisant cet indicateur.</td>
</tr>
<tr>
<td>`kubectl wait`</td>
<td>Si aucun sélecteur correspondant n'est trouvé, la commande imprime désormais un message d'erreur avec en sortie le code retour `1`. Si vos scripts reposent sur le comportement antérieur, mettez-les à jour.</td>
</tr>
<tr>
<td>Port kubelet cAdvisor</td>
<td>L'interface utilisateur Web [Container Advisor (cAdvisor) ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://github.com/google/cadvisor) qui était utilisée au démarrage de `--cadvisor-port` a été retirée de Kubernetes 1.12. Si vous devez exécuter cAdvisor, [déployez cAdvisor en tant que DaemonSet ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://github.com/google/cadvisor/tree/master/deploy/kubernetes).<br><br>Dans le DaemonSet, indiquez la section ports pour que cAdvisor puissent être accessible via `http://node-ip:4194`, comme suit. Notez que les pods de cAdvisor échouent tant que les noeuds worker ne sont pas mis à jour à la version 1.12, car les versions précédentes de kubelet utilisent le port d'hôte 4194 pour cAdvisor.
<pre class="screen"><code>ports:
          - name: http
            containerPort: 8080
            hostPort: 4194
            protocol: TCP</code></pre></td>
</tr>
<tr>
<td>Tableau de bord Kubernetes</td>
<td>Si vous accédez au tableau de bord via `kubectl proxy`, le bouton **SKIP** sur la page de connexion a été retiré. Utilisez à la place un **Jeton** pour vous connecter.</td>
</tr>
<tr>
<td id="metrics-server">Kubernetes Metrics Server</td>
<td>Le serveur Kubernetes Metrics Server remplace Kubernetes Heapster (déprécié depuis la version 1.8 de Kubernetes) comme fournisseur de métriques de cluster. Si vous exécutez plus de 30 pods par noeud worker dans votre cluster, [ajustez la configuration du serveur `metrics-server` à des fins de performances](cs_performance.html#metrics).
<p>Le tableau de bord Kubernetes ne fonctionne pas avec le serveur `metrics-server`. Si vous souhaitez afficher des métriques dans un tableau de bord, faites votre sélection parmi les options suivantes.</p>
<ul><li>[Configurez Grafana pour analyser les métriques](/docs/services/cloud-monitoring/tutorials/container_service_metrics.html#container_service_metrics) en utilisant le tableau de bord de surveillance de cluster.</li>
<li>Déployez [Heapster ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://github.com/kubernetes/heapster) dans votre cluster.
<ol><li>Copiez les fichiers [YAML ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://github.com/kubernetes/kubernetes/blob/release-1.12/cluster/addons/cluster-monitoring/heapster-rbac.yaml) `heapster-rbac`, [YAML ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://github.com/kubernetes/kubernetes/blob/release-1.12/cluster/addons/cluster-monitoring/standalone/heapster-service.yaml) `heapster-service` et  [YAML ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://github.com/kubernetes/kubernetes/blob/release-1.12/cluster/addons/cluster-monitoring/standalone/heapster-controller.yaml) `heapster-controller`.</li>
<li>Editez le fichier YAML `heapster-controller` en remplaçant les chaînes suivantes.
<ul><li>Remplacez `{{ nanny_memory }}` par `90Mi`</li>
<li>Remplacez `{{ base_metrics_cpu }}` par `80m`</li>
<li>Remplacez `{{ metrics_cpu_per_node }}` par `0.5m`</li>
<li>Remplacez `{{ base_metrics_memory }}` par `140Mi`</li>
<li>Remplacez `{{ metrics_memory_per_node }}` par `4Mi`</li>
<li>Remplacez `{{ heapster_min_cluster_size }}` par `16`</li></ul></li>
<li>Appliquez les fichiers YAML `heapster-rbac`, `heapster-service` et `heapster-controller` à votre cluster en exécutant la commande `kubectl apply -f`.</li></ol></li></ul></td>
</tr>
<tr>
<td>API Kubernetes `rbac.authorization.k8s.io/v1`</td>
<td>L'API Kubernetes `rbac.authorization.k8s.io/v1` (prise en charge à partir de la version 1.8 de Kubernetes) remplace les API `rbac.authorization.k8s.io/v1alpha1` et `rbac.authorization.k8s.io/v1beta1`. Vous ne pouvez plus créer des objets RBAC tels que des rôles ou des liaisons de rôle avec l'API `v1alpha` qui n'est plus prise en charge. Les objets RBAC existants sont convertis pour passer à l'API `v1`.</td>
</tr>
</tbody>
</table>

## Version 1.11
{: #cs_v111}

<p><img src="images/certified_kubernetes_1x11.png" style="padding-right: 10px;" align="left" alt="Ce badge indique une certification Kubernetes version 1.11 pour IBM Cloud Container Service."/> {{site.data.keyword.containerlong_notm}} est un produit certifié Kubernetes pour la version 1.11 sous le programme CNCF de certification de conformité logicielle de Kubernetes. _Kubernetes® est une marque de la Fondation Linux aux Etats-Unis et dans d'autres pays et est utilisé dans le cadre d'une licence de la Fondation Linux._</p>

Passez en revue les modifications que vous devrez peut-être apporter lors d'une mise à jour de la version Kubernetes précédente vers la version 1.11.
{: shortdesc}

Pour pouvoir effectuer la mise à jour d'un cluster de Kubernetes version 1.9 ou antérieure à la version 1.11, vous devez suivre les étapes indiquées dans [Préparation à la mise à jour vers Calico v3](#111_calicov3).
{: important}

### Mise à jour avant le maître
{: #111_before}

Le tableau suivant présente les actions que vous devez effectuer avant de mettre à jour le maître Kubernetes. 
{: shortdesc}

<table summary="Mises à jour Kubernetes pour la version 1.11">
<caption>Modifications à effectuer avant la mise à jour du maître vers Kubernetes 1.11</caption>
<thead>
<tr>
<th>Type</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Configuration de la haute disponibilité (HA) du noeud maître du cluster</td>
<td>Mise à jour de la configuration du noeud maître du cluster pour accroître la haute disponibilité (HA). Désormais, les clusters ont trois répliques du maître Kubernetes configurées de sorte que chaque maître soit déployé sur des hôtes physiques distincts. Par ailleurs, si votre cluster se trouve dans une zone compatible avec plusieurs zones, les maîtres sont répartis sur les différentes zones.<br><br>Pour connaître les actions que vous devez effectuer, voir [Mise à jour des maîtres de cluster pour la haute disponibilité](#ha-masters). Ces actions de préparation sont applicables dans les cas suivants :<ul>
<li>Si vous disposez d'un pare-feu ou de règles réseau Calico personnalisées.</li>
<li>Si vous utilisez les ports d'hôte `2040` ou `2041` sur vos noeuds worker.</li>
<li>Si vous avez utilisé l'adresse IP du noeud maître du cluster pour accéder au maître depuis le cluster.</li>
<li>Si vous disposez d'un processus automatique pour appeler l'API ou l'interface de ligne de commande Calico (`calicoctl`), par exemple pour créer des règles Calico.</li>
<li>Si vous utilisez des règles réseau Kubernetes ou Calico pour contrôler l'accès du trafic sortant du pod vers le maître.</li></ul></td>
</tr>
<tr>
<td>Nouvel environnement d'exécution de container `containerd` de Kubernetes</td>
<td><p class="important">`containerd` est le nouvel environnement de conteneur de Kubernetes qui remplace Docker. Pour connaître les actions que vous devez effectuer, voir [Mise à jour vers l'environnement de conteneur `containerd`](#containerd).</p></td>
</tr>
<tr>
<td>Chiffrement des données dans etcd</td>
<td>Auparavant, les données etcd étaient stockées sur une instance de stockage de fichiers NFS d'un maître chiffrée au repos. Désormais, les données etcd sont stockées sur le disque local du maître et sauvegardées dans {{site.data.keyword.cos_full_notm}}. Les données sont chiffrées lors du transit vers {{site.data.keyword.cos_full_notm}} et au repos. Cependant, les données etcd sur le disque local du maître ne sont pas chiffrées. Si vous souhaitez que les données etcd locales de votre maître soient chiffrées, [activez {{site.data.keyword.keymanagementservicelong_notm}} dans votre cluster](cs_encrypt.html#keyprotect).</td>
</tr>
<tr>
<td>Propagation de montage pour les volumes de conteneur Kubernetes</td>
<td>La valeur par défaut de la [zone `mountPropagation` ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/concepts/storage/volumes/#mount-propagation) pour un montage de volume (`VolumeMount`) de conteneur est passée de `HostToContainer` à `None`. Cette modification rétablit le comportement qui prévalait dans Kubernetes version 1.9 et antérieure. Si les spécifications de vos pods s'appuient sur `HostToContainer` (valeur par défaut), procédez à leur mise à jour.</td>
</tr>
<tr>
<td>Désérialiseur JSON du serveur d'API Kubernetes</td>
<td>Le désérialiseur JSON du serveur d'API Kubernetes est désormais sensible à la casse. Cette modification rétablit le comportement qui prévalait dans Kubernetes version 1.7 et antérieure. Si vos définitions de ressource JSON utilisent une casse incorrecte, procédez à leur mise à jour. <br><br>Seules les demandes directes du serveur d'API Kubernetes sont impactées. L'interface de ligne de commande `kubectl` continue à appliquer des clés sensibles à la casse à partir de la version 1.7 de Kubernetes, par conséquent si vous effectuez la gestion de vos ressources uniquement avec `kubectl`, vous n'êtes pas concerné.</td>
</tr>
</tbody>
</table>

### Mise à jour après le maître
{: #111_after}

Le tableau suivant présente les actions que vous devez effectuer après avoir mis à jour le maître Kubernetes. 
{: shortdesc}

<table summary="Mises à jour Kubernetes pour la version 1.11">
<caption>Modifications à effectuer après la mise à jour du maître vers Kubernetes 1.11</caption>
<thead>
<tr>
<th>Type</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Configuration de la consignation pour les clusters</td>
<td>Le module complémentaire de cluster `fluentd` est automatiquement mis à jour à la version 1.11, même lorsque la mise à jour automatique de la consignation (`logging-autoupdate`) est désactivée.<br><br>
Le répertoire de consignation du conteneur `/var/lib/docker/` a été remplacé par `/var/log/pods/`. Si vous utilisez votre propre solution de consignation qui surveille l'ancien répertoire, effectuez la mise à jour en conséquence.</td>
</tr>
<tr>
<td>Actualisation de la configuration de Kubernetes</td>
<td>La configuration OpenID Connect pour le serveur d'API Kubernetes du cluster a été mise à jour pour prendre en charge les groupes d'accès {{site.data.keyword.Bluemix_notm}} Identity and Access Management (IAM). Par conséquent, vous devez actualiser la configuration Kubernetes de votre cluster après la mise à jour du maître Kubernetes v1.11 en exécutant la commande `ibmcloud ks cluster-config --cluster <cluster_name_or_ID>`. <br><br>Si vous ne le faites pas, les actions du cluster échouent avec un message d'erreur de ce type : `You must be logged in to the server (Unauthorized).`</td>
</tr>
<tr>
<td>Interface de ligne de commande (CLI) `kubectl`</td>
<td>L'interface CLI `kubectl` pour Kubernetes version 1.11 nécessite les API `apps/v1`. Par conséquent, l'interface CLI `kubectl` v1.11 ne fonctionne pas pour les clusters qui exécutent Kubernetes avec une version inférieure ou égale à 1.8. Utilisez la version de l'interface CLI `kubectl` qui correspond à celle du serveur d'API Kubernetes de votre cluster.</td>
</tr>
<tr>
<td>`kubectl auth can-i`</td>
<td>Désormais, lorsqu'un utilisateur n'est pas autorisé, la commande `kubectl auth can-i` échoue avec le message `exit code 1`. Si vos scripts reposent sur le comportement antérieur, mettez-les à jour.</td>
</tr>
<tr>
<td>`kubectl delete`</td>
<td>Désormais, lors de la suppression de ressources à l'aide de critères de sélection, tels que des libellés, la commande `kubectl delete` ignore les erreurs de type `not found` par défaut. Si vos scripts reposent sur le comportement antérieur, mettez-les à jour.</td>
</tr>
<tr>
<td>Fonction `sysctls` de Kubernetes</td>
<td>L'annotation `security.alpha.kubernetes.io/sysctls` est désormais ignorée. A la place, Kubernetes a ajouté des zones dans les objets `PodSecurityPolicy` et `Pod` pour spécifier et contrôler `sysctls`. Pour plus d'informations, voir l'[utilisation de sysctls dans Kubernetes ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/tasks/administer-cluster/sysctl-cluster/). <br><br>Après avoir mis à jour le maître et les noeuds worker du cluster, procédez à la mise à jour des objets `PodSecurityPolicy` et `Pod` pour l'utilisation des nouvelles zones de `sysctls`.</td>
</tr>
</tbody>
</table>

### Mise à jour des maîtres de cluster pour la haute disponibilité dans Kubernetes 1.11
{: #ha-masters}

Pour les clusters qui exécutent Kubernetes version [1.10.8_1530](#110_ha-masters), 1.11.3_1531 ou ultérieure, la configuration du maître de cluster est mise à jour pour augmenter la haute disponibilité (HA). Désormais, les clusters ont trois répliques du maître Kubernetes configurées de sorte que chaque maître soit déployé sur des hôtes physiques distincts. Par ailleurs, si votre cluster se trouve dans une zone compatible avec plusieurs zones, les maîtres sont répartis sur les différentes zones.
{: shortdesc}

Lorsque vous mettez à jour votre cluster à cette version de Kubernetes à partir de la version 1.9 ou d'un correctif antérieur de la version 1.10 ou 1.11, vous devez effectuer ces étapes de préparation. Pour vous laisser du temps, les mises à jour automatiques du maître sont temporairement désactivées. Pour plus d'informations et pour en savoir plus sur le déroulement, consultez l'[article de blogue sur la haute disponibilité du maître](https://www.ibm.com/blogs/bluemix/2018/10/increased-availability-with-ha-masters-in-the-kubernetes-service-actions-you-must-take/).
{: tip}

Passez en revue les situations suivantes nécessitant des modifications pour tirer le meilleur parti d'une configuration à haute disponibilité du maître :
* Si vous disposez d'un pare-feu ou de règles réseau Calico personnalisées.
* Si vous utilisez les ports d'hôte `2040` ou `2041` sur vos noeuds worker.
* Si vous avez utilisé l'adresse IP du noeud maître du cluster pour accéder au maître depuis le cluster.
* Si vous disposez d'un processus automatique pour appeler l'API ou l'interface de ligne de commande Calico (`calicoctl`), par exemple pour créer des règles Calico.
* Si vous utilisez des règles réseau Kubernetes ou Calico pour contrôler l'accès du trafic sortant du pod vers le maître.

<br>
**Mise à jour de votre pare-feu ou de vos règles réseau d'hôte Calico personnalisées pour les maîtres à haute disponibilité** :</br>
{: #ha-firewall}
Si vous utilisez un pare-feu ou des règles réseau d'hôte Calico personnalisées pour contrôler la sortie de vos noeuds worker, autorisez le trafic sortant vers les ports et les adresses IP pour toutes les zones au sein de la région où se trouve votre cluster. Voir [Autorisation au cluster d'accéder aux ressources de l'infrastructure et à d'autres services](cs_firewall.html#firewall_outbound).

<br>
**Réservation des ports d'hôte `2040` et `2041` sur vos noeuds worker**:</br>
{: #ha-ports}
Pour autoriser l'accès au maître du cluster dans une configuration à haute disponibilité, vous devez laisser les ports d'hôte `2040` et `2041` disponibles sur tous les noeuds worker.
* Mettez à jour les pods avec `hostPort` défini avec `2040` ou `2041` pour utiliser d'autres ports.
* Mettez à jour les pods avec `hostNetwork` défini avec `true` à l'écoute sur les ports `2040` ou `2041` pour utiliser d'autres ports.

Pour vérifier si vos pods utilisent actuellement les ports `2040` ou `2041`, ciblez votre cluster et exécutez la commande suivante.

```
kubectl get pods --all-namespaces -o yaml | grep "hostPort: 204[0,1]"
```
{: pre}

<br>
**Utilisation de l'adresse IP du cluster ou le domaine du service `kubernetes` pour accéder au maître depuis le cluster** :</br>
{: #ha-incluster}
Pour accéder au maître de cluster dans une configuration à haute disponibilité depuis le cluster, utilisez l'une des options suivantes :
* L'adresse IP du cluster du service `kubernetes`, dont la valeur par défaut est : `https://172.21.0.1`
* Le nom de domaine du service `kubernetes`, dont la valeur par défaut est : `https://kubernetes.default.svc.cluster.local`

Si vous avez utilisé auparavant l'adresse IP du maître du cluster, cette méthode fonctionne toujours. Cependant, pour une disponibilité accrue, effectuez une mise à jour pour utiliser l'adresse IP du cluster ou le nom de domaine du service `kubernetes`.

<br>
**Configuration de Calico pour accéder au maître en dehors du cluster avec une configuration à haute disponibilité (HA)** :</br>
{: #ha-outofcluster}
Les données stockées dans l'élément configmap `calico-config` dans l'espace de nom `kube-system` sont modifiées pour prendre en charge la configuration du maître à haute disponibilité. En particulier, la valeur `etcd_endpoints` prend désormais en charge l'accès au sein du cluster uniquement. L'utilisation de cette valeur pour configurer l'interface CLI de Calico pour l'accès en dehors du cluster ne fonctionne plus.

Utilisez à la place les données stockées dans l'élément configmap `cluster-info` dans l'espace de nom `kube-system`. Utilisez notamment les valeurs `etcd_host` et `etcd_port` pour configurer le noeud final de l'[interface de ligne de commande (CLI) Calico](cs_network_policy.html#cli_install) pour accéder au maître avec une configuration à haute disponibilité en dehors du cluster.

<br>
**Mise à jour des règles réseau Kubernetes ou Calico** :</br>
{: #ha-networkpolicies}
Vous avez besoin d'effectuer d'autres actions si vous utilisez des [règles réseau Kubernetes ou Calico](cs_network_policy.html#network_policies) pour contrôler l'accès de la sortie du pod au maître du cluster et vous utilisez actuellement :
*  L'adresse IP du cluster du service Kubernetes, que vous pouvez obtenir en exécutant la commande `kubectl get service kubernetes -o yaml | grep clusterIP`.
*  Le nom de domaine du service Kubernetes dont la valeur par défaut est `https://kubernetes.default.svc.cluster.local`.
*  L'adresse IP du maître du cluster, que vous pouvez obtenir en exécutant la commande `kubectl cluster-info | grep Kubernetes`.

La procédure suivante indique comment mettre à jour vos règles réseau Kubernetes. Pour mettre à jour des règles réseau Calico, répétez cette procédure avec quelques légères modifications de syntaxe des règles et `calicoctl` pour rechercher des règles et en mesurer l'impact.
{: note}

Avant de commencer : [connectez-vous à votre compte. Ciblez la région appropriée et, le cas échéant, le groupe de ressources. Définissez le contexte de votre cluster](cs_cli_install.html#cs_cli_configure).

1.  Obtenez l'adresse IP du maître de cluster.
    ```
    kubectl cluster-info | grep Kubernetes
    ```
    {: pre}

2.  Recherchez les règles réseau Kubernetes pour en mesurer l'impact. Si aucun fichier YAML n'est renvoyé, votre cluster n'est pas impacté et vous n'avez pas besoin d'effectuer d'autres modifications.
    ```
    kubectl get networkpolicies --all-namespaces -o yaml | grep <cluster-master-ip>
    ```
    {: pre}

3.  Passez en revue le fichier YAML. Par exemple, si votre cluster utilise la règle réseau Kubernetes suivante pour autoriser les pods de l'espace de nom `default` à accéder au maître du cluster via l'adresse IP de cluster du service `kubernetes` ou l'adresse IP du maître du cluster, vous devez mettre à jour la règle.
    ```
    apiVersion: extensions/v1beta1
    kind: NetworkPolicy
    metadata:
      name: all-master-egress
      namespace: default
    spec:
      egress:
      # Allow access to cluster master using kubernetes service cluster IP address
      # or domain name or cluster master IP address.
      - ports:
        - protocol: TCP
        to:
        - ipBlock:
            cidr: 161.202.126.210/32
      # Allow access to Kubernetes DNS in order to resolve the kubernetes service
      # domain name.
      - ports:
        - protocol: TCP
          port: 53
        - protocol: UDP
          port: 53
      podSelector: {}
      policyTypes:
      - Egress
    ```
    {: screen}

4.  Révisez la règle réseau Kubernetes pour autoriser le trafic sortant vers l'adresse IP du proxy du maître au sein du cluster `172.20.0.1`. Pour l'instant, conservez l'adresse IP du maître de cluster. Par exemple, l'exemple de règle réseau précédent a été modifié comme suit.

    Si vous aviez configuré vos règles de sortie pour ouvrir uniquement l'adresse IP unique et le port pour le maître Kubernetes unique, utilisez désormais la plage d'adresses IP du proxy du maître au sein du cluster 172.20.0.1/32 et le port 2040.
    {: tip}

    ```
    apiVersion: extensions/v1beta1
    kind: NetworkPolicy
    metadata:
      name: all-master-egress
      namespace: default
    spec:
      egress:
      # Allow access to cluster master using kubernetes service cluster IP address
      # or domain name.
      - ports:
        - protocol: TCP
        to:
        - ipBlock:
            cidr: 172.20.0.1/32
        - ipBlock:
            cidr: 161.202.126.210/32
      # Allow access to Kubernetes DNS in order to resolve the kubernetes service domain name.
      - ports:
        - protocol: TCP
          port: 53
        - protocol: UDP
          port: 53
      podSelector: {}
      policyTypes:
      - Egress
    ```
    {: screen}

5.  Appliquez la règle réseau révisée à votre cluster.
    ```
    kubectl apply -f all-master-egress.yaml
    ```
    {: pre}

6.  Après avoir complété toutes les [actions de préparation](#ha-masters) (y compris ces étapes), [mettez à jour votre maître de cluster](cs_cluster_update.html#master) avec le groupe de correctifs du maître HA.

7.  Une fois la mise à jour effectuée, retirez l'adresse IP du maître de cluster de la règle réseau. Par exemple, dans la règle réseau précédente, retirez les lignes suivantes, puis appliquez à nouveau la règle.

    ```
    - ipBlock:
        cidr: 161.202.126.210/32
    ```
    {: screen}

    ```
    kubectl apply -f all-master-egress.yaml
    ```
    {: pre}

### Mise à jour vers l'environnement de conteneur `containerd`
{: #containerd}

Pour les clusters qui exécutent Kubernetes version 1.11 ou ultérieure, `containerd` remplace Docker et devient le nouvel environnement d'exécution de conteneur pour Kubernetes afin d'améliorer les performances. Si vos pods reposent sur l'environnement d'exécution de conteneur Docker pour Kubernetes, vous devez les mettre à jour pour utiliser `containerd` comme environnement d'exécution de conteneur. Pour plus d'informations, voir l'[annonce Kubernetes sur containerd ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/blog/2018/05/24/kubernetes-containerd-integration-goes-ga/).
{: shortdesc}

**Comment savoir si mes applications reposent sur `docker` au lieu de `containerd` ?**<br>
Exemples de fois où vous pouvez vous appuyer sur l'environnement d'exécution de conteneur Docker :
*  Si vous accédez au moteur Docker ou directement à l'API en utilisant des conteneurs privilégiés, mettez à jour vos pods pour prendre en charge `containerd` comme environnement d'exécution. Par exemple, vous pouvez appeler le socket Docker directement pour lancer les conteneurs ou effectuer d'autres opérations Docker. Le socket Docker est passé de `/var/run/docker.sock` à `/run/containerd/containerd.sock`. Le protocole utilisé dans le socket `containerd` est légèrement différent de celui de Docker. Essayez de mettre à jour votre application pour utiliser le socket `containerd`. Pour continuer à utiliser le socket Docker, envisagez d'utiliser [Docker-inside-Docker (DinD) ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://hub.docker.com/_/docker/).
*  Certains modules complémentaires de tiers, par exemple les outils de consignation et de surveillance, que vous installez dans votre cluster peuvent reposer sur le moteur Docker. Vérifiez auprès de votre fournisseur que les outils sont bien compatibles avec containerd. Les cas d'utilisations possibles sont :
   - Votre outil de consignation peut utiliser le répertoire `stderr/stdout` du conteneur `/var/log/pods/<pod_uuid>/<container_name>/*.log` pour accéder aux journaux. Dans Docker, ce répertoire est un lien symbolique vers `/var/data/cripersistentstorage/containers/<container_uuid>/<container_uuid>-json.log` alors que dans `containerd` vous accédez directement au répertoire sans recourir à un lien symbolique.
   - Votre outil de surveillance accède directement au socket Docker. Le socket Docker est passé de `/var/run/docker.sock` à `/run/containerd/containerd.sock`.

<br>

**Outre le recours à l'environnement d'exécution, dois-je effectuer d'autres actions de préparation ?**<br>

**Outil de manifeste** : si vous disposez d'images multiplateformes générées avec l'[outil ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://docs.docker.com/edge/engine/reference/commandline/manifest/) expérimental `docker manifest` avant Docker version 18.06, vous ne pouvez pas extraire l'image de DockerHub en utilisant `containerd`.

Lorsque vous vérifiez les événements de pod, vous pourrez voir s'afficher une erreur de ce type :
```
failed size validation
```
{: screen}

Pour utiliser une image générée à l'aide de l'outil de manifeste avec `containerd`, choisissez l'une des options suivantes.

*  Régénérez l'image avec l'[outil de manifeste ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://github.com/estesp/manifest-tool).
*  Régénérez l'image avec l'outil `docker-manifest` après avoir mis à jour Docker à la version 18.06 ou ultérieure.

<br>

**Qu'est-ce qui n'est pas affecté ? Dois-je modifier ma façon de déployer des conteneurs ?**<br>
En général, vos processus de déploiement de conteneur ne changent pas. Vous pouvez toujours utiliser un fichier Dockerfile pour définir une image Docker et construire un conteneur Docker pour vos applications. Si vous utilisez des commandes `docker` pour construire et insérer des images dans un registre, vous pouvez continuer à utiliser `docker` ou utiliser à la place des commandes `ibmcloud cr`.

### Préparation à la mise à jour vers Calico v3
{: #111_calicov3}

Si vous effectuez la mise à jour d'un cluster de Kubernetes version 1.9 ou antérieure à la version 1.11, préparez la mise à jour Calico v3 avant de mettre à jour le maître. Durant la mise à niveau du maître vers Kubernetes v1.11, les nouveaux pods et les nouvelles règles réseau de Kubernetes ou Calico ne sont plus planifiés. La durée pendant laquelle la mise à jour empêche toute nouvelle planification varie. Cette durée peut être de quelques minutes pour les clusters de petite taille avec des minutes supplémentaires pour chaque lot de 10 noeuds. Les règles réseau et les pods poursuivent leur exécution.
{: shortdesc}

Si vous effectuez la mise à jour d'un cluster de Kubernetes version 1.10 à la version 1.11, sautez ces étapes car vous les avez déjà effectuées lorsque vous êtes passé à la version 1.10.
{: note}

Avant de commencer, le maître, ainsi que tous les noeuds worker de votre cluster doivent exécuter Kubernetes version 1.8 ou 1.9, et votre cluster doit comporter au moins un noeud worker.

1.  Vérifiez que vos pods Calico sont sains.
    ```
    kubectl get pods -n kube-system -l k8s-app=calico-node -o wide
    ```
    {: pre}

2.  Si un pod n'est pas à l'état **Running**, supprimez-le ou attendez qu'il soit à l'état **Running** avant de continuer. Si le pod ne revient pas à l'état **Running** :
    1.  Vérifiez les zones **State** et **Status** du noeud worker.
        ```
        ibmcloud ks workers --cluster <cluster_name_or_ID>
        ```
        {: pre}
    2.  Si l'état du noeud worker n'est pas **Normal**, suivez la procédure de [débogage des noeuds worker](cs_troubleshoot.html#debug_worker_nodes). Par exemple, un état **Critical** ou **Unknown** est souvent résolu en [rechargeant le noeud worker](cs_cli_reference.html#cs_worker_reload).

3.  Si vous générez automatiquement des règles Calico ou d'autres ressources Calico, mettez à jour vos outils d'automatisation pour générer ces ressources avec la [syntaxe de Calico v3 ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://docs.projectcalico.org/v3.1/reference/calicoctl/resources/).

4.  Si vous utilisez [strongSwan](cs_vpn.html#vpn-setup) pour la connectivité VPN, la charte Helm 2.0.0 strongSwan ne fonctionne pas avec Calico v3 ou Kubernetes 1.11. [Mettez à jour strongSwan](cs_vpn.html#vpn_upgrade) avec la charte Helm 2.1.0, qui offre une compatibilité en amont avec Calico 2.6 et Kubernetes 1.7, 1.8 et 1.9.

5.  [Mettez à jour votre maître de cluster vers Kubernetes v1.11](cs_cluster_update.html#master).

<br />


## Version 1.10
{: #cs_v110}

<p><img src="images/certified_kubernetes_1x10.png" style="padding-right: 10px;" align="left" alt="Ce badge indique une certification Kubernetes version 1.10 pour IBM Cloud Container Service."/> {{site.data.keyword.containerlong_notm}} est un produit certifié Kubernetes pour la version 1.10 sous le programme CNCF de certification de conformité logicielle de Kubernetes. _Kubernetes® est une marque de la Fondation Linux aux Etats-Unis et dans d'autres pays et est utilisé dans le cadre d'une licence de la Fondation Linux._</p>

Passez en revue les modifications que vous devrez peut-être apporter lors d'une mise à jour de la version Kubernetes précédente vers la version 1.10.
{: shortdesc}

Pour pouvoir effectuer la mise à jour vers Kubernetes 1.10, vous devez suivre les étapes indiquées dans [Préparation à la mise à jour vers Calico v3](#110_calicov3).
{: important}

<br/>

### Mise à jour avant le maître
{: #110_before}

Le tableau suivant présente les actions que vous devez effectuer avant de mettre à jour le maître Kubernetes. 
{: shortdesc}

<table summary="Mises à jour Kubernetes pour la version 1.10">
<caption>Modifications à effectuer avant la mise à jour du maître vers Kubernetes 1.10</caption>
<thead>
<tr>
<th>Type</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico v3</td>
<td>La mise à jour vers Kubernetes version 1.10 fait également passer Calico de la version 2.6.5 à la version 3.1.1. <strong>Important</strong> : pour pouvoir effectuer la mise à jour vers Kubernetes v1.10, vous devez suivre les étapes indiquées dans [Préparation à la mise à jour vers Calico v3](#110_calicov3).</td>
</tr>
<tr>
<td>Configuration de la haute disponibilité (HA) du noeud maître du cluster</td>
<td>Mise à jour de la configuration du noeud maître du cluster pour accroître la haute disponibilité (HA). Désormais, les clusters ont trois répliques du maître Kubernetes configurées de sorte que chaque maître soit déployé sur des hôtes physiques distincts. Par ailleurs, si votre cluster se trouve dans une zone compatible avec plusieurs zones, les maîtres sont répartis sur les différentes zones.<br><br>Pour connaître les actions que vous devez effectuer, voir [Mise à jour des maîtres de cluster pour la haute disponibilité](#110_ha-masters). Ces actions de préparation sont applicables dans les cas suivants :<ul>
<li>Si vous disposez d'un pare-feu ou de règles réseau Calico personnalisées.</li>
<li>Si vous utilisez les ports d'hôte `2040` ou `2041` sur vos noeuds worker.</li>
<li>Si vous avez utilisé l'adresse IP du noeud maître du cluster pour accéder au maître depuis le cluster.</li>
<li>Si vous disposez d'un processus automatique pour appeler l'API ou l'interface de ligne de commande Calico (`calicoctl`), par exemple pour créer des règles Calico.</li>
<li>Si vous utilisez des règles réseau Kubernetes ou Calico pour contrôler l'accès du trafic sortant du pod vers le maître.</li></ul></td>
</tr>
<tr>
<td>Règle réseau du tableau de bord Kubernetes</td>
<td>Dans Kubernetes 1.10, la règle réseau <code>kubernetes-dashboard</code> dans l'espace de nom <code>kube-system</code> bloque l'accès de tous les pods au tableau de bord Kubernetes. Mais elle <strong>n'affecte pas</strong> la possibilité d'accéder au tableau de bord à partir de la console {{site.data.keyword.Bluemix_notm}} ou via le proxy <code>kubectl proxy</code>. Si un pod nécessite l'accès au tableau de bord, vous pouvez ajouter un libellé <code>kubernetes-dashboard-policy: allow</code> à un espace de nom puis déployer le pod sur cet espace de nom.</td>
</tr>
<tr>
<td>Accès à l'API Kubelet</td>
<td>L'autorisation d'accès à l'API Kubelet est désormais déléguée au <code>serveur d'API Kubernetes</code>. L'accès à l'API Kubelet est basé sur les rôles de cluster (<code>ClusterRoles</code>) qui octroient le droit d'accès aux sous-ressources de <strong>noeud</strong>. Par défaut, Kubernetes Heapster dispose des rôles <code>ClusterRole</code> et <code>ClusterRoleBinding</code>. Cependant, si l'API Kubelet est utilisée par d'autres utilisateurs ou applications, vous devez leur accorder le droit d'utiliser l'API. Consultez la documentation Kubernetes sur l'[autorisation d'accès à Kubelet![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet-authentication-authorization/).</td>
</tr>
<tr>
<td>Suites de chiffrement</td>
<td>Les suites de chiffrement prises en charge sur le <code>serveur d'API Kubernetes</code> et l'API Kubelet sont désormais limitées à un sous-ensemble avec un niveau de chiffrement élevé (128 bits ou plus). Si vous disposez d'automatisation ou de ressources utilisant un niveau de chiffrement plus faible et qui s'appuient sur la communication avec le <code>serveur d'API Kubernetes</code> ou l'API Kubelet, activez un support de chiffrement plus fort avant d'effectuer la mise à jour du maître.</td>
</tr>
<tr>
<td>VPN strongSwan</td>
<td>Si vous utilisez [strongSwan](cs_vpn.html#vpn-setup) pour la connectivité VPN, vous devez supprimer la charte avant de mettre à jour le cluster en exécutant la commande `helm delete --purge <release_name>`. Une fois la mise à jour du cluster terminée, réinstallez la charte Helm strongSwan.</td>
</tr>
</tbody>
</table>

### Mise à jour après le maître
{: #110_after}

Le tableau suivant présente les actions que vous devez effectuer après avoir mis à jour le maître Kubernetes. 
{: shortdesc}

<table summary="Mises à jour Kubernetes pour la version 1.10">
<caption>Modifications à effectuer après la mise à jour du maître vers Kubernetes 1.10</caption>
<thead>
<tr>
<th>Type</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico v3</td>
<td>Lorsque le cluster est mis à jour, toutes les données existantes de Calico appliquées au cluster sont automatiquement migrées pour utiliser la syntaxe de Calico v3. Pour afficher, ajouter ou modifier des ressources Calico avec la syntaxe de Calico v3, mettez à jour la [configuration de l'interface de ligne de commande de Calico pour passer à la version 3.1.1](#110_calicov3).</td>
</tr>
<tr>
<td>Adresse IP externe (<code>ExternalIP</code>) du noeud</td>
<td>La zone <code>ExternalIP</code> d'un noeud est désormais définie avec la valeur de l'adresse IP publique du noeud. Vérifiez et mettez à jour toutes les ressources qui dépendent de cette valeur.</td>
</tr>
<tr>
<td><code>kubectl port-forward</code></td>
<td>Désormais quand vous utilisez la commande <code>kubectl port-forward</code>, elle ne prend plus en charge l'indicateur <code>-p</code>. Si vos scripts s'appuient sur le comportement précédent, mettez-les à jour pour remplacer l'indicateur <code>-p</code> par le nom du pod.</td>
</tr>
<tr>
<td>Indicateur `kubectl --show-all, -a`</td>
<td>L'indicateur `--show-all, -a`, qui s'applique uniquement aux commandes de pod lisibles par l'utilisateur (et non aux appels d'API), est déprécié et n'est plus pris en charge dans les versions à venir. Cet indicateur est utilisé pour afficher les pods à un état terminal. Pour suivre les informations sur les applications et les conteneurs interrompus, [configurez le transfert des journaux dans votre cluster](cs_health.html#health).</td>
</tr>
<tr>
<td>Volumes de données d'API en lecture seule</td>
<td>Désormais les éléments `secret`, `configMap`, `downwardAPI` et les volumes projetés sont montés en lecture seule.
Auparavant, les applications étaient autorisées à écrire des données dans ces volumes qui pouvaient être
automatiquement rétablies par le système. Cette modification est requise pour corriger
la vulnérabilité de sécurité [CVE-2017-1002102![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2017-1002102).
Si vos applications s'appuient sur ce comportement peu fiable en matière de sécurité, modifiez-les en conséquence.</td>
</tr>
<tr>
<td>VPN strongSwan</td>
<td>Si vous utilisez [strongSwan](cs_vpn.html#vpn-setup) pour la connectivité VPN et que vous avez supprimé votre charte avant de mettre à jour le cluster, vous pouvez à présent réinstaller la charte Helm strongSwan.</td>
</tr>
</tbody>
</table>

### Mise à jour des maîtres de cluster pour la haute disponibilité dans Kubernetes 1.10
{: #110_ha-masters}

Pour les clusters qui exécutent Kubernetes version 1.10.8_1530, [1.11.3_1531](#ha-masters) ou ultérieure, la configuration du maître de cluster est mise à jour pour augmenter la haute disponibilité (HA). Désormais, les clusters ont trois répliques du maître Kubernetes configurées de sorte que chaque maître soit déployé sur des hôtes physiques distincts. Par ailleurs, si votre cluster se trouve dans une zone compatible avec plusieurs zones, les maîtres sont répartis sur les différentes zones.
{: shortdesc}

Lorsque vous mettez à jour votre cluster à cette version de Kubernetes à partir de la version 1.9 ou d'un correctif antérieur de la version 1.10, vous devez effectuer ces étapes de préparation. Pour vous laisser du temps, les mises à jour automatiques du maître sont temporairement désactivées. Pour plus d'informations et pour en savoir plus sur le déroulement, consultez l'[article de blogue sur la haute disponibilité du maître](https://www.ibm.com/blogs/bluemix/2018/10/increased-availability-with-ha-masters-in-the-kubernetes-service-actions-you-must-take/).
{: tip}

Passez en revue les situations suivantes nécessitant des modifications pour tirer le meilleur parti d'une configuration à haute disponibilité du maître :
* Si vous disposez d'un pare-feu ou de règles réseau Calico personnalisées.
* Si vous utilisez les ports d'hôte `2040` ou `2041` sur vos noeuds worker.
* Si vous avez utilisé l'adresse IP du noeud maître du cluster pour accéder au maître depuis le cluster.
* Si vous disposez d'un processus automatique pour appeler l'API ou l'interface de ligne de commande Calico (`calicoctl`), par exemple pour créer des règles Calico.
* Si vous utilisez des règles réseau Kubernetes ou Calico pour contrôler l'accès du trafic sortant du pod vers le maître.

<br>
**Mise à jour de votre pare-feu ou de vos règles réseau d'hôte Calico personnalisées pour les maîtres à haute disponibilité** :</br>
{: #110_ha-firewall}
Si vous utilisez un pare-feu ou des règles réseau d'hôte Calico personnalisées pour contrôler la sortie de vos noeuds worker, autorisez le trafic sortant vers les ports et les adresses IP pour toutes les zones au sein de la région où se trouve votre cluster. Voir [Autorisation au cluster d'accéder aux ressources de l'infrastructure et à d'autres services](cs_firewall.html#firewall_outbound).

<br>
**Réservation des ports d'hôte `2040` et `2041` sur vos noeuds worker**:</br>
{: #110_ha-ports}
Pour autoriser l'accès au maître du cluster dans une configuration à haute disponibilité, vous devez laisser les ports d'hôte `2040` et `2041` disponibles sur tous les noeuds worker.
* Mettez à jour les pods avec `hostPort` défini avec `2040` ou `2041` pour utiliser d'autres ports.
* Mettez à jour les pods avec `hostNetwork` défini avec `true` à l'écoute sur les ports `2040` ou `2041` pour utiliser d'autres ports.

Pour vérifier si vos pods utilisent actuellement les ports `2040` ou `2041`, ciblez votre cluster et exécutez la commande suivante.

```
kubectl get pods --all-namespaces -o yaml | grep "hostPort: 204[0,1]"
```
{: pre}

<br>
**Utilisation de l'adresse IP du cluster ou le domaine du service `kubernetes` pour accéder au maître depuis le cluster** :</br>
{: #110_ha-incluster}
Pour accéder au maître de cluster dans une configuration à haute disponibilité depuis le cluster, utilisez l'une des options suivantes :
* L'adresse IP du cluster du service `kubernetes`, dont la valeur par défaut est : `https://172.21.0.1`
* Le nom de domaine du service `kubernetes`, dont la valeur par défaut est : `https://kubernetes.default.svc.cluster.local`

Si vous avez utilisé auparavant l'adresse IP du maître du cluster, cette méthode fonctionne toujours. Cependant, pour une disponibilité accrue, effectuez une mise à jour pour utiliser l'adresse IP du cluster ou le nom de domaine du service `kubernetes`.

<br>
**Configuration de Calico pour accéder au maître en dehors du cluster avec une configuration à haute disponibilité (HA)** :</br>
{: #110_ha-outofcluster}
Les données stockées dans l'élément configmap `calico-config` dans l'espace de nom `kube-system` sont modifiées pour prendre en charge la configuration du maître à haute disponibilité. En particulier, la valeur `etcd_endpoints` prend désormais en charge l'accès au sein du cluster uniquement. L'utilisation de cette valeur pour configurer l'interface CLI de Calico pour l'accès en dehors du cluster ne fonctionne plus.

Utilisez à la place les données stockées dans l'élément configmap `cluster-info` dans l'espace de nom `kube-system`. Utilisez notamment les valeurs `etcd_host` et `etcd_port` pour configurer le noeud final de l'[interface de ligne de commande (CLI) Calico](cs_network_policy.html#cli_install) pour accéder au maître avec une configuration à haute disponibilité en dehors du cluster.

<br>
**Mise à jour des règles réseau Kubernetes ou Calico** :</br>
{: #110_ha-networkpolicies}
Vous avez besoin d'effectuer d'autres actions si vous utilisez des [règles réseau Kubernetes ou Calico](cs_network_policy.html#network_policies) pour contrôler l'accès de la sortie du pod au maître du cluster et vous utilisez actuellement :
*  L'adresse IP du cluster du service Kubernetes, que vous pouvez obtenir en exécutant la commande `kubectl get service kubernetes -o yaml | grep clusterIP`.
*  Le nom de domaine du service Kubernetes dont la valeur par défaut est `https://kubernetes.default.svc.cluster.local`.
*  L'adresse IP du maître du cluster, que vous pouvez obtenir en exécutant la commande `kubectl cluster-info | grep Kubernetes`.

La procédure suivante indique comment mettre à jour vos règles réseau Kubernetes. Pour mettre à jour des règles réseau Calico, répétez cette procédure avec quelques légères modifications de syntaxe des règles et `calicoctl` pour rechercher des règles et en mesurer l'impact.
{: note}

Avant de commencer : [connectez-vous à votre compte. Ciblez la région appropriée et, le cas échéant, le groupe de ressources. Définissez le contexte de votre cluster](cs_cli_install.html#cs_cli_configure).

1.  Obtenez l'adresse IP du maître de cluster.
    ```
    kubectl cluster-info | grep Kubernetes
    ```
    {: pre}

2.  Recherchez les règles réseau Kubernetes pour en mesurer l'impact. Si aucun fichier YAML n'est renvoyé, votre cluster n'est pas impacté et vous n'avez pas besoin d'effectuer d'autres modifications.
    ```
    kubectl get networkpolicies --all-namespaces -o yaml | grep <cluster-master-ip>
    ```
    {: pre}

3.  Passez en revue le fichier YAML. Par exemple, si votre cluster utilise la règle réseau Kubernetes suivante pour autoriser les pods de l'espace de nom `default` à accéder au maître du cluster via l'adresse IP de cluster du service `kubernetes` ou l'adresse IP du maître du cluster, vous devez mettre à jour la règle.
    ```
    apiVersion: extensions/v1beta1
    kind: NetworkPolicy
    metadata:
      name: all-master-egress
      namespace: default
    spec:
      egress:
      # Allow access to cluster master using kubernetes service cluster IP address
      # or domain name or cluster master IP address.
      - ports:
        - protocol: TCP
        to:
        - ipBlock:
            cidr: 161.202.126.210/32
      # Allow access to Kubernetes DNS in order to resolve the kubernetes service
      # domain name.
      - ports:
        - protocol: TCP
          port: 53
        - protocol: UDP
          port: 53
      podSelector: {}
      policyTypes:
      - Egress
    ```
    {: screen}

4.  Révisez la règle réseau Kubernetes pour autoriser le trafic sortant vers l'adresse IP du proxy du maître au sein du cluster `172.20.0.1`. Pour l'instant, conservez l'adresse IP du maître de cluster. Par exemple, l'exemple de règle réseau précédent a été modifié comme suit.

    Si vous aviez configuré vos règles de sortie pour ouvrir uniquement l'adresse IP unique et le port pour le maître Kubernetes unique, utilisez désormais la plage d'adresses IP du proxy du maître au sein du cluster 172.20.0.1/32 et le port 2040.
    {: tip}

    ```
    apiVersion: extensions/v1beta1
    kind: NetworkPolicy
    metadata:
      name: all-master-egress
      namespace: default
    spec:
      egress:
      # Allow access to cluster master using kubernetes service cluster IP address
      # or domain name.
      - ports:
        - protocol: TCP
        to:
        - ipBlock:
            cidr: 172.20.0.1/32
        - ipBlock:
            cidr: 161.202.126.210/32
      # Allow access to Kubernetes DNS in order to resolve the kubernetes service domain name.
      - ports:
        - protocol: TCP
          port: 53
        - protocol: UDP
          port: 53
      podSelector: {}
      policyTypes:
      - Egress
    ```
    {: screen}

5.  Appliquez la règle réseau révisée à votre cluster.
    ```
    kubectl apply -f all-master-egress.yaml
    ```
    {: pre}

6.  Après avoir complété toutes les [actions de préparation](#ha-masters) (y compris ces étapes), [mettez à jour votre maître de cluster](cs_cluster_update.html#master) avec le groupe de correctifs du maître HA.

7.  Une fois la mise à jour effectuée, retirez l'adresse IP du maître de cluster de la règle réseau. Par exemple, dans la règle réseau précédente, retirez les lignes suivantes, puis appliquez à nouveau la règle.

    ```
    - ipBlock:
        cidr: 161.202.126.210/32
    ```
    {: screen}

    ```
    kubectl apply -f all-master-egress.yaml
    ```
    {: pre}

### Préparation à la mise à jour vers Calico v3
{: #110_calicov3}

Avant de commencer, le maître, ainsi que tous les noeuds worker de votre cluster doivent exécuter Kubernetes version 1.8 ou ultérieure, et votre cluster doit comporter au moins un noeud worker.
{: shortdesc}

Préparez la mise à jour vers Calico v3 avant de mettre à jour le maître. Durant la mise à niveau du maître vers Kubernetes v1.10, les nouveaux pods et les nouvelles règles réseau de Kubernetes ou Calico ne sont plus planifiés. La durée pendant laquelle la mise à jour empêche toute nouvelle planification varie. Cette durée peut être de quelques minutes pour les clusters de petite taille avec des minutes supplémentaires pour chaque lot de 10 noeuds. Les règles réseau et les pods poursuivent leur exécution.
{: important}

1.  Vérifiez que vos pods Calico sont sains.
    ```
    kubectl get pods -n kube-system -l k8s-app=calico-node -o wide
    ```
    {: pre}

2.  Si un pod n'est pas à l'état **Running**, supprimez-le ou attendez qu'il soit à l'état **Running** avant de continuer. Si le pod ne revient pas à l'état **Running** :
    1.  Vérifiez les zones **State** et **Status** du noeud worker.
        ```
        ibmcloud ks workers --cluster <cluster_name_or_ID>
        ```
        {: pre}
    2.  Si l'état du noeud worker n'est pas **Normal**, suivez la procédure de [débogage des noeuds worker](cs_troubleshoot.html#debug_worker_nodes). Par exemple, un état **Critical** ou **Unknown** est souvent résolu en [rechargeant le noeud worker](cs_cli_reference.html#cs_worker_reload).

3.  Si vous générez automatiquement des règles Calico ou d'autres ressources Calico, mettez à jour vos outils d'automatisation pour générer ces ressources avec la [syntaxe de Calico v3 ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://docs.projectcalico.org/v3.1/reference/calicoctl/resources/).

4.  Si vous utilisez [strongSwan](cs_vpn.html#vpn-setup) pour la connectivité VPN, la charte Helm 2.0.0 strongSwan ne fonctionne pas avec Calico v3 ou Kubernetes 1.10. [Mettez à jour strongSwan](cs_vpn.html#vpn_upgrade) avec la charte Helm 2.1.0, qui offre une compatibilité en amont avec Calico 2.6 et Kubernetes 1.7, 1.8 et 1.9.

5.  [Mettez à jour votre maître de cluster vers Kubernetes v1.10](cs_cluster_update.html#master).

<br />


## Archive
{: #k8s_version_archive}

Recherchez une présentation des versions de Kubernetes qui ne sont pas prises en charge dans {{site.data.keyword.containerlong_notm}}. 
{: shortdesc}

### Version 1.9 (dépréciée, non prise en charge depuis le 27 décembre 2018)
{: #cs_v19}

<p><img src="images/certified_kubernetes_1x9.png" style="padding-right: 10px;" align="left" alt="Ce badge indique une certification Kubernetes version 1.9 pour IBM Cloud Container Service."/> {{site.data.keyword.containerlong_notm}} est un produit certifié Kubernetes pour la version 1.9 sous le programme CNCF de certification de conformité logicielle de Kubernetes. _Kubernetes® est une marque de la Fondation Linux aux Etats-Unis et dans d'autres pays et est utilisé dans le cadre d'une licence de la Fondation Linux._</p>

Passez en revue les modifications que vous devrez peut-être apporter lors d'une mise à jour de la version Kubernetes précédente vers la version 1.9.
{: shortdesc}

<br/>

### Mise à jour avant le maître
{: #19_before}

Le tableau suivant présente les actions que vous devez effectuer avant de mettre à jour le maître Kubernetes. 
{: shortdesc}

<table summary="Mises à jour Kubernetes pour la version 1.9">
<caption>Modifications à effectuer avant la mise à jour du maître vers la version Kubernetes 1.9</caption>
<thead>
<tr>
<th>Type</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>API d'admission webhook</td>
<td>L'API d'admission, qui est utilisée lorsque le serveur d'API appelle des webhooks de contrôle d'admission, est passée de <code>admission.v1alpha1</code> à <code>admission.v1beta1</code>. <em>Vous devez supprimer les éventuels webhooks existants avant de mettre à niveau votre cluster</em> et mettre à jour les fichiers de configuration webhook afin d'utiliser l'API la plus récente. Cette modification n'est pas compatible en amont.</td>
</tr>
</tbody>
</table>

### Mise à jour après le maître
{: #19_after}

Le tableau suivant présente les actions que vous devez effectuer après avoir mis à jour le maître Kubernetes. 
{: shortdesc}

<table summary="Mises à jour Kubernetes pour la version 1.9">
<caption>Modifications à effectuer après la mise à jour du maître vers la version Kubernetes 1.9</caption>
<thead>
<tr>
<th>Type</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>Sortie `kubectl`</td>
<td>A présent, lorsque vous utilisez la commande `kubectl` en spécifiant `-o custom-columns` et que la colonne est introuvable dans l'objet, la sortie indique `<none>`.<br>
Auparavant, l'opération échouait et un message d'erreur `xxx is not found` (xxx introuvable) était affiché. Si vos scripts reposent sur le comportement antérieur, mettez-les à jour.</td>
</tr>
<tr>
<td>`kubectl patch`</td>
<td>Maintenant, lorsqu'aucune modification n'est apportée à la ressource concernée, la commande `kubectl patch` échoue avec `exit code 1`. Si vos scripts reposent sur le comportement antérieur, mettez-les à jour.</td>
</tr>
<tr>
<td>Droits d'accès au tableau de bord Kubernetes</td>
<td>Les utilisateurs doivent se connecter au tableau de bord Kubernetes avec leurs données d'identification pour afficher les ressources du cluster. L'autorisation RBAC `ClusterRoleBinding` du tableau de bord Kubernetes par défaut est supprimée. Pour les instructions correspondantes, voir [Lancement du tableau de bord Kubernetes](cs_app.html#cli_dashboard).</td>
</tr>
<tr>
<td>Volumes de données d'API en lecture seule</td>
<td>Désormais les éléments `secret`, `configMap`, `downwardAPI` et les volumes projetés sont montés en lecture seule.
Auparavant, les applications étaient autorisées à écrire des données dans ces volumes qui pouvaient être
automatiquement rétablies par le système. Cette modification est requise pour corriger la vulnérabilité
de sécurité [CVE-2017-1002102](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2017-1002102).
Si vos applications s'appuient sur ce comportement peu fiable en matière de sécurité, modifiez-les en conséquence.</td>
</tr>
<tr>
<td>Annotations taint et tolerations</td>
<td>Les annotations taint `node.alpha.kubernetes.io/notReady` et `node.alpha.kubernetes.io/unreachable` sont remplacées respectivement par `node.kubernetes.io/not-ready` et `node.kubernetes.io/unreachable`.<br>
Bien que ces annotations taint soient mises à jour automatiquement, vous devez mettre à jour manuellement leurs annotations tolerations. Pour chaque espace de nom à l'exception d'`ibm-system` et de `kube-system`, déterminez si vous devez modifier les annotations tolerations :<br>
<ul><li><code>kubectl get pods -n &lt;namespace&gt; -o yaml | grep "node.alpha.kubernetes.io/notReady" && echo "Action required"</code></li><li>
<code>kubectl get pods -n &lt;namespace&gt; -o yaml | grep "node.alpha.kubernetes.io/unreachable" && echo "Action required"</code></li></ul><br>
Si `Action required` est renvoyé, modifiez les annotations tolerations de pod en conséquence.</td>
</tr>
<tr>
<td>API d'admission webhook</td>
<td>Si vous avez supprimé des webhooks existants avant de mettre à jour le cluster, créez de nouveaux webhooks.</td>
</tr>
</tbody>
</table>

### Version 1.8 (non prise en charge)
{: #cs_v18}

A partir du 22 septembre 2018, les clusters {{site.data.keyword.containerlong_notm}} qui exécutent [Kubernetes version 1.8](cs_versions_changelog.html#changelog_archive) ne sont plus pris en charge. Les clusters de la version 1.8 ne peuvent pas recevoir des mises à jour ou du support sauf s'ils ont été mis à jour à la version suivante la plus récente ([Kubernetes 1.9](#cs_v19)).
{: shortdesc}

[Consultez l'impact potentiel](cs_versions.html#cs_versions) de chaque mise à jour de version Kubernetes, puis [mettez à jour vos clusters](cs_cluster_update.html#update) pour passer immédiatement à la version 1.9 ou ultérieure.

### Version 1.7 (non prise en charge)
{: #cs_v17}

A partir du 21 juin 2018, les clusters {{site.data.keyword.containerlong_notm}} qui exécutent [Kubernetes version 1.7](cs_versions_changelog.html#changelog_archive) ne sont plus pris en charge. Les clusters de la version 1.7 ne peuvent pas recevoir des mises à jour ou du support sauf s'ils ont été mis à jour à la version suivante prise en charge la plus récente ([Kubernetes 1.9](#cs_v19)).
{: shortdesc}

[Consultez l'impact potentiel](cs_versions.html#cs_versions) de chaque mise à jour de version Kubernetes, puis [mettez à jour vos clusters](cs_cluster_update.html#update) pour passer immédiatement à la version 1.9 ou ultérieure.

### Version 1.5 (non prise en charge)
{: #cs_v1-5}

A partir du 4 avril 2018, les clusters {{site.data.keyword.containerlong_notm}} qui exécutent [Kubernetes version 1.5](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.5.md) ne sont plus pris en charge. Les clusters de la version 1.5 ne peuvent pas recevoir des mises à jour ou du support.
{: shortdesc}

Pour continuer à exécuter vos applications dans {{site.data.keyword.containerlong_notm}}, [créez un nouveau cluster](cs_clusters.html#clusters) et [déployez vos applications](cs_app.html#app) dans le nouveau cluster.
