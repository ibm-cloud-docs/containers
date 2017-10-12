---

copyright:
  years: 2014, 2017
lastupdated: "2017-08-14"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip} 
{:download: .download}


# Planification de clusters et d'applications
{: #cs_planning}

{{site.data.keyword.containershort_notm}} propose
plusieurs options pour configurer et personnaliser votre cluster Kubernetes en fonction des exigences fonctionnelles et autres de votre
organisation. Certaines de ces configurations ne peuvent pas être modifiées une fois que le cluster a été créé. En étant d'avance familier avec ces configurations, vous pouvez vous assurer que toutes les ressources requises (comme la mémoire, l'espace disque et les adresses IP) soient disponibles à votre équipe de développement.
{:shortdesc}

## Comparaison des clusters léger et standard
{: #cs_planning_cluster_type}

Vous pouvez créer un cluster léger pour vous familiariser et tester les fonctionnalités Kubernetes ou bien créer un cluster standard pour commencer à implémenter vos applications avec les fonctionnalités Kubernetes complètes. {:shortdesc}

|Caractéristiques|Clusters légers|Clusters standard|
|---------------|-------------|-----------------|
|[Disponible dans {{site.data.keyword.Bluemix_notm}} public](cs_ov.html#public_environment)|<img src="images/confirm.svg" width="32" alt="Fonction disponible" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Fonction disponible" style="width:32px;" />|
|[Réseau privé dans un cluster](#cs_planning_private_network)|<img src="images/confirm.svg" width="32" alt="Fonction disponible" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Fonction disponible" style="width:32px;" />|
|[Accès aux applications publiques par un service Nodeport](#cs_nodeport)|<img src="images/confirm.svg" width="32" alt="Fonction disponible" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Fonction disponible" style="width:32px;" />|
|[Gestion de l'accès utilisateur](cs_cluster.html#cs_cluster_user)|<img src="images/confirm.svg" width="32" alt="Fonction disponible" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Fonction disponible" style="width:32px;" />|
|Accès au service [{{site.data.keyword.Bluemix_notm}} depuis le cluster et les applications](cs_cluster.html#cs_cluster_service)|<img src="images/confirm.svg" width="32" alt="Fonction disponible" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Fonction disponible" style="width:32px;" />|
|[Espace disque sur le noeud d'agent pour stockage](#cs_planning_apps_storage)|<img src="images/confirm.svg" width="32" alt="Fonction disponible" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Fonction disponible" style="width:32px;" />|
|[Stockage de fichiers NFS persistant avec volumes](#cs_planning_apps_storage)||<img src="images/confirm.svg" width="32" alt="Fonction disponible" style="width:32px;" />|
|[Accès aux applications publiques par un service d'équilibrage de charge](#cs_loadbalancer)||<img src="images/confirm.svg" width="32" alt="Fonction disponible" style="width:32px;" />|
|[Accès aux applications publiques par un service Ingress](#cs_ingress)||<img src="images/confirm.svg" width="32" alt="Fonction disponible" style="width:32px;" />|
|[Adresses IP publiques portables](cs_apps.html#cs_cluster_ip_subnet)||<img src="images/confirm.svg" width="32" alt="Fonction disponible" style="width:32px;" />|
|[Disponible dans {{site.data.keyword.Bluemix_notm}} Dedicated (version bêta fermée)](cs_ov.html#dedicated_environment)||<img src="images/confirm.svg" width="32" alt="Fonction disponible" style="width:32px;" />|
{: caption="Table 1. Différences entre les clusters léger et standard" caption-side="top"}

## Configuration de cluster
{: #cs_planning_cluster_config}

Utilisez des clusters standard pour accroître la disponibilité des applications. Vos utilisateurs risquent moins de rencontrer des indisponibilités lorsque vous disséminez votre configuration entre plusieurs noeuds d'agent et clusters. Les fonctions intégrées, telles que l'équilibrage de charge et l'isolement, augmentent la résilience en cas de pannes d'hôtes, de réseaux ou d'applications.
{:shortdesc}

Examinez ces configurations potentielles de cluster, classées par ordre croissant de disponibilité :

[![Niveaux de haute disponibilité pour un cluster](images/cs_cluster_ha_roadmap.png)](https://console.bluemix.net/docs/api/content/containers/images/cs_cluster_ha_roadmap.png)

1.  Un seul cluster avec plusieurs noeuds d'agent
2.  Deux clusters s'exécutant dans des emplacements différents dans
la même région, chacun avec plusieurs noeuds d'agent
3.  Deux clusters s'exécutant dans des régions différentes, chacun avec plusieurs noeuds d'agent

Découvrez comment utiliser ces techniques pour améliorer la disponibilité de votre cluster :

<dl>
<dt>Incluez suffisamment de noeuds d'agent pour disperser les instances d'application</dt>
<dd>Pour une haute disponibilité, permettez à vos développeurs d'application de disséminer leurs conteneurs entre plusieurs noeuds d'agent par
cluster. Trois noeuds d'agent permettent que survienne une indisponibilité d'un noeud d'agent sans interrompre l'utilisation de l'application. Vous pouvez spécifier le nombre de noeuds d'agent à inclure lorsque vous créez un cluster depuis l'[interface graphique {{site.data.keyword.Bluemix_notm}} ](cs_cluster.html#cs_cluster_ui) ou l'[interface CLI](cs_cluster.html#cs_cluster_cli). Kubernetes limite le nombre maximal de noeuds d'agent dont vous pouvez disposer dans un cluster. Pour plus d'informations, voir la rubrique sur les [quotas de noeud d'agent et de nacelle ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/admin/cluster-large/).
<pre class="codeblock">
<code>bx cs cluster-create --location &lt;dal10&gt; --workers 3 --public-vlan &lt;my_public_vlan_id&gt; --private-vlan &lt;my_private_vlan_id&gt; --machine-type &lt;u1c.2x4&gt; --name &lt;my_cluster&gt;</code>
</pre>
</dd>
<dt>Disséminez les applications entre les clusters</dt>
<dd>Créez plusieurs clusters, chacun avec plusieurs noeuds d'agent. Si une indisponibilité affecte un
cluster, les utilisateurs peuvent toujours accéder à une application également déployée dans un autre cluster.
<p>Cluster
1 :</p>
<pre class="codeblock">
<code>bx cs cluster-create --location &lt;dal10&gt; --workers 3 --public-vlan &lt;my_public_vlan_id&gt; --private-vlan &lt;my_private_vlan_id&gt; --machine-type &lt;u1c.2x4&gt; --name &lt;my_cluster1&gt;</code>
</pre>
<p>Cluster
2 :</p>
<pre class="codeblock">
<code>bx cs cluster-create --location &lt;dal12&gt; --workers 3 --public-vlan &lt;my_public_vlan_id&gt; --private-vlan &lt;my_private_vlan_id&gt; --machine-type &lt;u1c.2x4&gt;  --name &lt;my_cluster2&gt;</code>
</pre>
</dd>
<dt>Disséminez les applications entre des clusters dans des régions différentes</dt>
<dd>Lorsque vous disséminez les applications entre des clusters dans des régions différentes, vous pouvez permettre à équilibrage de charge d'intervenir en fonction de la région où est situé l'utilisateur. Si le cluster, un matériel, voire un emplacement complet dans une région tombe
en  panne, le trafic est acheminé au conteneur déployé dans un autre emplacement.
<p><strong>Important :</strong> après avoir configuré votre domaine personnalisé, vous pourriez utiliser les commandes suivantes pour créer les clusters.</p>
<p>Emplacement 1 :</p>
<pre class="codeblock">
<code>bx cs cluster-create --location &lt;dal10&gt; --workers 3 --public-vlan &lt;my_public_vlan_id&gt; --private-vlan &lt;my_private_vlan_id&gt; --machine-type &lt;u1c.2x4&gt; --name &lt;my_cluster1&gt;</code>
</pre>
<p>Emplacement 2 :</p>
<pre class="codeblock">
<code>bx cs cluster-create --location &lt;ams03&gt; --workers 3 --public-vlan &lt;my_public_vlan_id&gt; --private-vlan &lt;my_private_vlan_id&gt; --machine-type &lt;u1c.2x4&gt; --name &lt;my_cluster2&gt;</code>
</pre>
</dd>
</dl>


## Configuration du noeud d'agent
{: #cs_planning_worker_nodes}

Un cluster Kubernetes est composé de noeuds d'agent sous forme de machines virtuelles et le cluster est sous surveillance et gestion centralisée par le maître Kubernetes. Les administrateurs de cluster doivent décider comment configurer le cluster de noeuds d'agent afin de garantir que ses utilisateurs disposent de toutes les ressources nécessaires pour déployer et exécuter des applications dans le cluster.
{:shortdesc}

Lorsque vous créez un cluster standard, les noeuds d'agent sont organisés pour vous dans {{site.data.keyword.BluSoftlayer_full}} et configurés dans in {{site.data.keyword.Bluemix_notm}}. A chaque noeud d'agent sont affectés un ID de noeud d'agent unique et un nom de domaine qui ne doivent pas être modifiés après la création du cluster. Selon le niveau d'isolement du matériel que vous sélectionnez, les noeuds d'agent peuvent être configurés en tant que noeuds partagés ou dédiés. Chaque noeud d'agent
est doté d'un type de machine spécifique qui détermine le nombre d'UC, la mémoire et l'espace disque disponibles pour les conteneurs déployés sur le noeud d'agent. Kubernetes limite le nombre maximal de noeuds d'agent dont vous pouvez disposer dans un cluster. Pour plus d'informations, voir la rubrique sur les [quotas de noeud d'agent et de nacelle ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/admin/cluster-large/).



### Matériel pour les noeuds d'agent
{: #shared_dedicated_node}

Chaque noeud d'agent est installé sous forme de machine virtuelle sur le matériel physique. Lorsque vous créez un cluster
standard dans {{site.data.keyword.Bluemix_notm}} public, vous devez indiquer si le matériel sous-jacent doit être partagé par plusieurs clients {{site.data.keyword.IBM_notm}}
(service partagé) ou vous être dédié (service exclusif). {:shortdesc}

Dans une configuration de service partagé, les ressources physiques (comme l'UC et la mémoire) sont partagées par toutes les
machines virtuelles déployés sur le même matériel physique. Pour permettre à chaque machine virtuelle d'opérer
indépendamment, un moniteur de machine virtuelle, également dénommé hyperviseur,
segmente les ressources physiques en entités isolées et les alloue à une machine virtuelle en tant que ressources dédiés
(isolement par hyperviseur).

Dans une configuration de service exclusif, toutes les ressources physiques vous sont dédiées en exclusivité. Vous pouvez déployer plusieurs noeuds d'agent en tant que machines virtuelles sur le même hôte physique. A l'instar de la configuration de service partagé,
l'hyperviseur veille à ce que chaque noeud d'agent ait sa part des ressources physiques disponibles.

Les noeuds partagés sont généralement moins coûteux que les noeuds dédiés vu que les coûts du matériel sous-jacent sont partagés entre plusieurs clients. Toutefois, lorsque vous choisissez entre noeuds partagés et noeud dédiés, vous devriez contacter votre service juridique pour déterminer le niveau d'isolement de l'infrastructure et de conformité requis par votre environnement d'application.

Lorsque vous créez un cluster léger, votre noeud d'agent est automatiquement mis à disposition en tant que noeud partagé dans le compte {{site.data.keyword.IBM_notm}} {{site.data.keyword.BluSoftlayer_notm}}. 

Lorsque vous créez un cluster dans {{site.data.keyword.Bluemix_notm}} Dedicated, une configuration de service exclusif est utilisée et toutes les ressources physiques vous sont dédiées exclusivement. Vous déployez plusieurs noeuds d'agent en tant que machines virtuelles sur le même hôte physique.

## Déploiements
{: #highly_available_apps}

Plus votre configuration
sera distribuée entre plusieurs noeuds d'agent et clusters, et moins vos utilisateurs seront susceptibles d'encourir des temps d'indisponibilité de votre application.
{:shortdesc}

Examinez ces configurations potentielles d'application, classées par ordre croissant de disponibilité :

[![Niveaux de haute disponibilité pour un cluster](images/cs_app_ha_roadmap.png)](../api/content/containers/images/cs_app_ha_roadmap.png)

1.  Déploiement avec n+2 nacelles gérées par un jeu de répliques.
2.  Déploiement avec n+2 nacelles gérées par un jeu de répliques et disséminées entre plusieurs noeuds
(anti-affinité) sur le même emplacement.
3.  Déploiement avec n+2 nacelles gérées par un jeu de répliques et
disséminées entre plusieurs noeuds (anti-affinité) dans des emplacements différents.
4.  Déploiement avec n+2 nacelles gérées par un jeu de répliques et disséminées entre plusieurs noeuds
(anti-affinité) dans des régions différentes.

Découvrez les techniques qui vous permettent d'améliorer la disponibilité de votre application :

<dl>
<dt>Utilisez des déploiements et des jeux de répliques pour déployer votre application et ses dépendances</dt>
<dd>Un déploiement est une ressource Kubernetes que vous pouvez utiliser pour déclarer tous les composants de votre application et ses dépendances. En décrivant les composants uniques au lieu de consigner toutes les étapes nécessaires et leur ordre de création, vous pouvez vous concentrer sur l'apparence de votre application au moment où elle s'exécutera.

</br>
Lorsque vous déployez plusieurs nacelles, un jeu de répliques est créé automatiquement pour vos déploiements afin de surveiller les nacelles et de garantir que le nombre voulu de nacelles est en opération en tout temps. Lorsqu'une nacelle tombe en panne, le jeu de répliques remplace la nacelle ne répondant plus par une nouvelle.
</br></br>
Vous pouvez utiliser un déploiement pour définir des stratégies de mise à jour de votre application, notamment le nombre de nacelles que vous désirez ajouter lors d'une mise à jour tournante et le nombre de nacelles pouvant être indisponibles à un moment donné. Lorsque vous effectuez une mise à jour tournante, le déploiement vérifie si la révision est fonctionnelle et l'arrête si des échecs sont détectés.
</br>
Les déploiements offrent également la possibilité de déployer simultanément plusieurs révisions avec des indicateurs différents, ce qui vous permet par exemple de tester d'abord un déploiement avant de décider de l'utiliser en environnement de production.
</br></br>
Chaque déploiement conserve un suivi des révisions qui ont été déployées. Vous pouvez utiliser cet historique des révisions pour rétablir une version antérieure si vos mises à jour ne fonctionnent pas comme prévu.</dd>
<dt>Incluez suffisamment de répliques pour répondre à la charge de travail de votre application, plus deux répliques</dt>
<dd>Pour rendre votre application encore plus disponible et réfractaire aux échecs, envisagez d'inclure des répliques supplémentaires au-delà du strict minimum requis pour gérer la charge de travail anticipée. Ces répliques supplémentaires pourront gérer la charge de travail en cas de panne d'une nacelle et avant que le jeu de répliques n'ait encore rétabli la nacelle défaillante. Pour une
protection face à deux défaillances simultanées de nacelles, incluez deux répliques supplémentaires. Cette configuration correspond à un canevas N+2, où N désigne le nombre de nacelles destinées à traiter la charge de travail entrante et +2 indique d'ajouter deux répliques
supplémentaires.</dd>
<dt>Disséminez les nacelles entre plusieurs noeuds (anti-affinité)</dt>
<dd>Lorsque vous créez votre déploiement, vous pouvez déployer toutes les nacelles sur le même noeud d'agent. Cette configuration où les nacelles résident sur le même noeud d'agent est dénommée 'affinité' ou 'collocation'. Pour protéger votre application
contre une défaillance du noeud d'agent, vous pouvez opter lors du déploiement de disséminer les nacelles entre plusieurs noeuds d'agent, et ce en utilisant l'option <strong>podAntiAffinity</strong>. Cette option n'est disponible que pour les clusters standard.

</br></br>
<strong>Remarque :</strong> le fichier YAML suivant s'assure que chaque nacelle soit déployée sur un noeud d'agent différent. Lorsque le nombre de répliques défini dépasse le nombre de noeuds d'agent disponibles dans votre cluster, le nombre de répliques déployées se limite à celui requis pour répondre à l'exigence d'anti-affinité. Les répliques excédentaires demeurent à l'état En attente jusqu'à ce que des noeuds d'agent supplémentaires soient éventuellement ajoutés au cluster.

<pre class="codeblock">
<code>apiVersion: v1
kind: Service
metadata:
  name: wasliberty
  labels:
    app: wasliberty
spec:
  ports:
    # Port à utiliser pour ce service
  - port: 9080
  selector:
    app: wasliberty
  type: NodePort
---
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: wasliberty
spec:
  replicas: 3
  template:
    metadata:
      labels:
        app: wasliberty
      annotations:
        scheduler.alpha.kubernetes.io/affinity: >
            {
              "podAntiAffinity": {
                "requiredDuringSchedulingIgnoredDuringExecution": [
                  {
                    "labelSelector": {
                      "matchExpressions": [
                        {
                          "key": "app",
                          "operator": "In",
                          "values": ["wasliberty"]
                        }
                      ]
                    },
                    "topologyKey": "kubernetes.io/hostname"
                 }
                ]
               }
             }
    spec:
      containers:
      - name: wasliberty
        image: registry.&lt;region&gt;.bluemix.net/ibmliberty
        ports:
          - containerPort: 9080</code></pre>

</dd>
<dt>Dissémination des nacelles entre plusieurs emplacements ou régions</dt>
<dd>Pour protéger votre application en cas d'une défaillance d'un emplacement ou d'une région, vous pouvez créer un second cluster dans un autre emplacement ou une autre région et utiliser un fichier YAML de déploiement afin de déployer un doublon du jeu de répliques pour votre application. En ajoutant une route partagée et un équilibreur de charge devant vos clusters, vous pouvez répartir votre charge de travail entre plusieurs emplacements et régions. Pour plus d'informations sur le partage de route entre clusters, voir <a href="https://console.bluemix.net/docs/containers/cs_cluster.html#cs_cluster" target="_blank">Haute disponibilité des clusters</a>.

Pour plus de détails, examinez les options pour <a href="https://console.bluemix.net/docs/containers/cs_planning.html#cs_planning_cluster_config" target="_blank">les déploiements 'applications à haute disponibilité</a>.</dd>
</dl>

### Déploiement d'application minimal
{: #minimal_app_deployment}

Le déploiement d'application le plus élémentaire dans un cluster léger ou standard peut inclure les composants suivants.
{:shortdesc}

<a href="../api/content/containers/images/cs_app_tutorial_components1.png">![Configuration de déploiement](images/cs_app_tutorial_components1.png)</a>

Exemple de script de configuration pour une application minimale
```
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: ibmliberty
spec:
  replicas: 1
  template:
    metadata:
      labels:
        app: ibmliberty
    spec:
      containers:
      - name: ibmliberty
        image: registry.<region>.bluemix.net/ibmliberty:latest
---
apiVersion: v1
kind: Service
metadata:
  name: ibmliberty-service
  labels:
    app: ibmliberty
spec:
  selector:
    run: ibmliberty
  type: NodePort
  ports:
   - protocol: TCP
     port: 9080
```
{: codeblock}

## Réseau privé
{: #cs_planning_private_network}

La communication réseau sécurisée et privée est réalisée via des réseaux locaux virtuels privés, également dénommés
VLAN privés. Un réseau local virtuel configure un groupe de noeuds d'agent et de nacelles
comme s'ils étaient reliés physiquement au même câble.
{:shortdesc}

Lorsque vous créez un cluster, chaque cluster est automatiquement connecté à un VLAN privé. Le réseau local virtuel privé détermine l'adresse
IP privée qui est affectée à un noeud d'agent lors de la création du cluster.

|Type de cluster|Gestionnaire du VLAN privé pour le cluster|
|------------|-------------------------------------------|
|Clusters légers dans {{site.data.keyword.Bluemix_notm}} public|{{site.data.keyword.IBM_notm}}|
|Clusters Standard dans {{site.data.keyword.Bluemix_notm}} public|Vous dans votre compte {{site.data.keyword.BluSoftlayer_notm}} <p>**Astuce :** Pour avoir accès à tous les VLAN dans votre compte, activez [VLAN Spanning ![External link icon](../icons/launch-glyph.svg "External link icon")](https://knowledgelayer.softlayer.com/procedure/enable-or-disable-vlan-spanning).</p>|
|Clusters standard dans {{site.data.keyword.Bluemix_notm}} Dedicated|{{site.data.keyword.IBM_notm}}|
{: caption="Tableau 2. Responsabilités de gestion de VLAN privé" caption-side="top"}

Une adresse IP privée est également affectée à chaque nacelle déployée sur un noeud d'agent. L'adresse IP affectée aux nacelles est située sur la plage d'adresses IP privées 172.30.0.0/16 et ne sont utilisées que pour le routage entre les noeuds d'agent. Pour éviter des conflits, n'utilisez pas cette plage d'adresses IP sur des noeuds qui communiqueront avec vos noeuds d'agent. Les noeuds d'agent et les nacelles peuvent communiquer de manière sécurisée sur le réseau privé en utilisant les adresses IP privées. Toutefois, lorsqu'une nacelle tombe en panne ou qu'un noeud d'agent a besoin d'être recréé, une nouvelle adresse IP privée lui est affectée.

Etant donné qu'il est ardu de suivre des adresses IP privées fluctuantes pour des applications devant faire l'objet d'une haute disponibilité, vous pouvez utiliser les fonctionnalités Kubernetes intégrées de reconnaissance de service et exposer des applications en tant que services IP de cluster sur le réseau privé dans le cluster. Un service Kubernetes regroupe un ensemble de nacelles et
procure une connexion réseau vers ces nacelles pour d'autres services dans le cluster sans exposer
l'adresse IP privée réelle de chaque nacelle. Lorsque vous créez un service IP de cluster, une adresse IP privée lui est affectée à partir de la plage d'adresses privées 10.10.10.0/24. Comme pour la plage d'adresses privées de nacelles, n'utilisez pas cette plage d'adresses sur des noeuds qui communiqueront avec vos noeuds d'agent. Cette adresse IP n'est accessible que dans le cluster. Vous ne pouvez pas y accéder depuis Internet. En même temps, une entrée de recherche DNS est créée pour le service et stockée dans le composant kube-dns du cluster. L'entrée DNS contient le nom du
service, l'espace de nom dans lequel il a été créé et le lien vers l'adresse IP privée de cluster affectée.

Si une application dans le cluster a besoin d'accéder à une nacelle située derrière un service IP de cluster, elle peut soit utiliser l'adresse IP privée de cluster qui a été affectée au service, soit envoyer une demande en utilisant le nom du service. Lorsque vous utilisez le nom du service, ce nom est recherché dans le composant kube-dns et la demande est acheminée à l'adresse IP privée de cluster du service. Lorsqu'une demande parvient au service, celui-ci se charge d'envoyer équitablement toutes les demandes aux nacelles,
sans considération de leurs adresses IP privées et du noeud d'agent sur lequel elles sont déployées.

Pour plus d'informations sur la création d'un service de type IP de cluster, voir[Kubernetes services ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services---service-types).


## Réseau public
{: #cs_planning_public_network}

Lorsque vous créez un cluster, chaque cluster doit être connecté à un VLAN public. Le réseau local virtuel public détermine l'adresse IP publique affectée à un noeud d'agent lors de la création du cluster.
{:shortdesc}

Une réseau local virtuel public est protégé par un pare-feu {{site.data.keyword.BluSoftlayer_notm}} qui n'autorise pas par défaut une connectivité entrante ou sortante vers Internet. Bien que le maître Kubernetes et les noeuds d'agent communiquent à travers le réseau local virtuel public via les adresses IP publiques qui leur sont affectées, ils ne sont pas accessibles depuis Internet.

|Type de cluster|Gestionnaire du VLAN public pour le cluster|
|------------|------------------------------------------|
|Clusters légers dans {{site.data.keyword.Bluemix_notm}} Public|{{site.data.keyword.IBM_notm}}|
|Clusters Standard dans {{site.data.keyword.Bluemix_notm}} Public|Vous dans votre compte {{site.data.keyword.BluSoftlayer_notm}} |
|Clusters standard dans {{site.data.keyword.Bluemix_notm}} Dedicated|{{site.data.keyword.IBM_notm}}|
{: caption="Tableau 3. Responsabilités de gestion de VLAN" caption-side="top"}

Selon que vous avez créé un cluster léger ou standard, vous pouvez choisir l'une des options suivantes pour exposer une application au public. 

-   [Service de type NodePort](#cs_nodeport) (clusters léger et standard)
-   [Service de type LoadBalancer](#cs_loadbalancer) (clusters standard uniquement)
-   [Ingress](#cs_ingress) (clusters standard uniquement)


### Exposition d'une application sur Internet à l'aide d'un service de type NodePort
{: #cs_nodeport}

Vous pouvez exposer un port public sur votre noeud d'agent et utiliser l'adresse IP publique de ce noeud pour accès public au
service dans le cluster.
{:shortdesc}

[![Exposition d'un service à l'aide d'un service Kubernetes de type NodePort](images/cs_nodeport.png)](https://console.bluemix.net/docs/api/content/containers/images/cs_nodeport.png)

Lorsque vous exposez votre application en créant un service Kubernetes du type NodePort, une valeur NodePort comprise entre 30000 et 32767 et une adresse IP interne de cluster sont affectés au
service. Le service NodePort fait office de point d'entrée externe pour les demandes entrantes vers votre application. Le NodePort affecté est exposé au public dans les paramètres kubeproxy de chaque noeud d'agent dans le
cluster. Chaque noeud d'agent commence à écouter sur le NodePort affecté pour détecter des demandes entrantes pour le
service. Pour accéder au service depuis Internet, vous pouvez utiliser l'adresse IP publique de n'importe quel noeud d'agent
affectée lors de la création du cluster et le service NodePort au format `
<ip_address>:<nodeport>`.

Lorsqu'une demande publique parvient au service NodePort, elle est automatiquement acheminée vers l'adresse IP interne du cluster
du service et réacheminée du composant kubeproxy vers l'adresse IP privée de la nacelle sur laquelle l'application est déployée. L'adresse IP du cluster n'est accessible que dans le cluster. Si plusieurs répliques de votre application s'exécutent dans des nacelles différentes, le composant
kubeproxy équilibre la charge des demandes entrantes entre toutes les répliques.

**Remarque :** gardez à l'esprit que l'adresse IP publique du noeud d'agent n'est pas permanente. Lorsqu'un noeud d'agent est supprimé ou recréé, une nouvelle adresse IP publique lui est affectée. Vous pouvez utiliser le service de type NodePort pour tester l'accès public pour votre application ou lorsque l'accès public n'est nécessaire que pour un temps très bref. Si vous avez besoin d'une adresse IP publique stable et d'une plus grande disponibilité de votre
service, exposez votre application en utilisant un [service de type LoadBalancer](#cs_loadbalancer)
ou [Ingress](#cs_ingress). 

Pour plus d'informations sur la création d'un service de type NodePort avec {{site.data.keyword.containershort_notm}}, voir [Configuration de l'accès public à une application à l'aide du type de service NodePort](cs_apps.html#cs_apps_public_nodeport).


### Exposition d'une application sur Internet à l'aide d'un service de type LoadBalancer
{: #cs_loadbalancer}

Vous pouvez exposez un port et utiliser l'adresse IP publique pour accès à l'application par l'équilibreur de charge.

[![Exposition d'un service à l'aide d'un service Kubernetes de type LoadBalancer](images/cs_loadbalancer.png)](https://console.bluemix.net/docs/api/content/containers/images/cs_loadbalancer.png)

Lorsque vous créez un cluster standard, {{site.data.keyword.containershort_notm}} réclame automatiquement 5 adresses IP publiques portables et les approvisionne à votre compte
{{site.data.keyword.BluSoftlayer_notm}} au cours de la création du cluster. L'une des adresses IP portables est utilisée pour le [contrôleur Ingress](#cs_ingress). 4
adresses IP publiques portables peuvent être utilisées pour exposer des applications au public en créant un service du type LoadBalancer.

Lorsque vous créez un service Kubernetes du type LoadBalancer, un équilibreur de charge externe est créé et l'une des
4 adresses IP publiques disponibles lui est affectée. Si aucune adresse
IP publique portable n'est disponible, la création de votre service LoadBalancer échoue. Le service LoadBalancer fait office de point d'entrée externe pour les demandes entrantes vers votre application. A la différence des services de type NodePort, vous pouvez affecter n'importe quel port à votre équilibreur de charge et n'êtes pas confiné à une plage de ports spécifique. L'adresse IP publique portable affectée au service LoadBalancer est permanente et ne change pas en cas de suppression ou de recréation d'un noeud d'agent, ainsi, le service LoadBalancer est plus disponible que le service NodePort.
Pour accéder au service LoadBalancer depuis
Internet, utilisez l'adresse IP publique de votre équilibreur de charge et le port affecté en utilisant le format `
<ip_address>:<port>`.

Lorsqu'une demande publique parvient au service LoadBalancer, elle est automatiquement acheminée vers l'adresse IP interne du cluster qui a été affectée au service LoadBalancer lors de la création du service. L'adresse IP du cluster n'est accessible que dans le cluster. Depuis l'adresse IP du cluster, les entrantes demandes sont réacheminées vers le composant kubeproxy de votre noeud d'agent et, de là, vers l'adresse IP privée de la nacelle sur laquelle l'application est déployée. Si plusieurs répliques de votre application s'exécutent dans des nacelles différentes, le composant
kubeproxy équilibre la charge des demandes entrantes entre toutes les répliques.

Pour plus d'informations sur la création d'un service de type LoadBalancer avec {{site.data.keyword.containershort_notm}}, voir [Configuration de l'accès public à une application à l'aide du type de service LoadBalancer](cs_apps.html#cs_apps_public_load_balancer).



### Exposition d'une application sur Internet à l'aide d'Ingress
{: #cs_ingress}

Ingress vous permet d'exposer plusieurs services dans votre cluster et de les rendre disponibles au public
via un point d'entrée public unique.

[![Exposition d'un service à l'aide du support Ingress {{site.data.keyword.containershort_notm}}](images/cs_ingress.png)](https://console.bluemix.net/docs/api/content/containers/images/cs_ingress.png)

Au lieu de créer un service d'équilibreur de charge pour chaque application que vous désirez exposer au public, Ingress fournit une route publique unique qui vous permet d'acheminer les demandes publiques vers les applications situées à l'intérieur et à l'extérieur de votre cluster d'après leurs chemins d'accès individuels. Ingress comporte deux composants principaux. La ressource Ingress
définit les règles de routage pour les demandes entrantes destinées à une application. Toutes les ressources Ingress doivent être enregistrées auprès du contrôleur Ingress qui est à l'écoute de demandes de service HTTP ou HTTPS entrantes et qui les réachemine en fonction des règles définies pour chaque ressource Ingress. 

Lorsque vous créez un cluster standard, {{site.data.keyword.containershort_notm}} crée automatiquement un contrôleur Ingress à haute disponibilité pour votre cluster et lui affecte une route publique unique au format `
<cluster_name>.<region>.containers.mybluemix.net`. La route publique est liée à une adresse IP publique portable allouée à votre compte {{site.data.keyword.BluSoftlayer_notm}} lors de la création du cluster.

Pour exposer une application via Ingress, vous devez créer un service Kubernetes pour votre application et enregistrer ce
service auprès du contrôleur Ingress en définissant une ressource Ingress. La ressource Ingress spécifie le chemin
que vous désirez ajouter à la route publique pour former une URL unique pour l'application exposée, comme par exemple : `mycluster.us-south.containers.mybluemix.net/myapp`. Lorsque vous entrez ce chemin dans votre navigateur Web, la demande est envoyée à l'adresse IP publique portable liée du contrôleur Ingress. Le contrôleur vérifie si une règle de routage pour le chemin `myapp` dans le cluster `mycluster` existe. Si une règle correspondante est identifiée, la demande, y-compris le chemin individuel, est acheminée à la nacelle sur laquelle l'application est déployée, en fonction des règles qui ont été définies dans l'objet de ressource Ingress d'origine. Pour que l'application puisse traiter les demandes entrantes, vérifiez que celle-ci est à l'écoute sur le chemin individuel que vous avez défini dans la ressource Ingress.

Vous pouvez configurer le contrôleur Ingress pour gérer le trafic réseau entrant pour les applications pour les scénarios suivants :

-   Utilisation du domaine fourni par IBM sans terminaison TLS
-   Utilisation du domaine fourni par IBM et du certificat TLS sans terminaison TLS
-   Utilisation de votre domaine personnalisé et du certificat TLS pour la terminaison TLS
-   Utilisation du domaine fourni par IBM ou de votre domaine personnalisé et de certificats TLS pour accéder aux applications en dehors de votre cluster
-   Ajout de fonctions à votre contrôleur Ingress à l'aide d'annotations

Pour plus d'informations sur l'utilisation d'Ingress avec {{site.data.keyword.containershort_notm}}, voir [Configuration d'un accès public à une application à l'aide du contrôleur Ingress](cs_apps.html#cs_apps_public_ingress).


## Gestion de l'accès utilisateur
{: #cs_planning_cluster_user}

Vous pouvez octroyer un accès au cluster à d'autres utilisateurs pour garantir que seuls les utilisateurs habilités puissent gérer le cluster et y déployer des applications.
{:shortdesc}

Pour plus d'informations, voir [Gestion des utilisateurs et de l'accès à un cluster dans {{site.data.keyword.containershort_notm}}](cs_cluster.html#cs_cluster_user).


## Registres d'images
{: #cs_planning_images}

Une image Docker est la base de chaque conteneur que vous créez. L'image est créée depuis un
Dockerfile, lequel est un fichier contenant des instructions pour générer l'image. Un Dockerfile peut référencer dans ses
instructions des artefacts de génération stockés séparément, comme une application, sa configuration, et ses dépendances.
{:shortdesc}

Les images sont généralement stockées dans un registre d'images pouvant être accessible au public (registre public)  ou, au contraire, dont l'accès est limité à un petit groupe d'utilisateurs (registre privé). Des registres publics, tel que
Docker Hub, peuvent être utilisés pour vous familiariser avec Docker et Kubernetes en créant créer votre première application conteneurisée dans un
cluster. Dans le cas d'applications d'entreprise, utilisez un registre privé, tel que celui fourni dans
{{site.data.keyword.registryshort_notm}}, pour empêcher l'utilisation et la modification de vos images par des utilisateurs non habilités. Les registres privés sont mis en place par l'administrateur du
cluster pour garantir que les données d'identification pour accès au registre privé sont disponibles aux utilisateurs du
cluster.

Vous pouvez utiliser plusieurs registres avec {{site.data.keyword.containershort_notm}} pour déployer des applications dans votre cluster.

|Registre|Description|Avantage|
|--------|-----------|-------|
|[{{site.data.keyword.registryshort_notm}}](/docs/services/Registry/index.html)|Cette option vous permet de mettre en place votre propre référentiel d'images Docker sécurisé dans {{site.data.keyword.registryshort_notm}} où vous pourrez stocker en sécurité vos images et les partager avec les autres utilisateurs du cluster.|<ul><li>Gestion de l'accès aux images dans votre compte.</li><li>Utilisation d'images et d'exemples d'application fournis par {{site.data.keyword.IBM_notm}}, comme {{site.data.keyword.IBM_notm}} Liberty,  en tant qu'image parent à laquelle vous ajouterez votre propre code d'application.  </li><li>Analyse automatique des images pour détection de vulnérabilités potentielles par Vulnerability Advisor et soumission de recommandations spécifiques au système d'exploitation pour les corriger.</li></ul>|
|Tout autre registre privé|Connexion de n'importe quel registre privé existant à votre cluster en créant un élément [imagePullSecret ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/containers/images/). Cette valeur est utilisée pour enregistrer de manière sécurisée l'URL de votre registre URL et ses données d'identification dans une valeur confidentielle
Kubernetes.|<ul><li>Utilisation de registres privés existants indépendants de leur source (Docker Hub, registres dont l'organisation est propriétaire, autres registres Cloud privés).</li></ul>|
|Public Docker Hub|Cette option permet d'utiliser directement des images publiques existantes de Docker Hub quand vous n'avez pas besoin de modifier le fichier Dockerfile. <p>**Remarque :** Gardez à l'esprit que cette option peut ne pas satisfaire les exigences de sécurité de votre organisation (par exemple, en matière de gestion des accès, d'analyse des vulnérabilités ou de protection des données confidentielles de l'application).</p>|<ul><li>Aucune configuration supplémentaire du cluster n'est nécessaire.</li><li>Inclut un certain nombre d'applications en code source ouvert.</li></ul>|
{: caption="Tableau 4. Options de registre d'images public et privé" caption-side="top"}

Une fois que vous avez configuré un registre d'images, les utilisateurs du cluster peuvent utiliser les images pour le déploiement de leurs applications dans le cluster.

Pour plus d'informations sur l'accès à un registre public ou privé et sur l'utilisation d'une image pour créer
votre conteneur, voir [Utilisation de registres d'images privé et public avec {{site.data.keyword.containershort_notm}}](cs_cluster.html#cs_apps_images). 


## Stockage de données persistantes
{: #cs_planning_apps_storage}

De par sa conception la durée de vie d'un conteneur est brève. Toutefois, vous disposez de plusieurs options pour rendre persistantes les données en cas de reprise en ligne d'un conteneur et pour partager les données entre les conteneurs.
{:shortdesc}

[![Options de stockage persistant pour les déploiements dans des clusters Kubernetes](images/cs_planning_apps_storage.png)](https://console.bluemix.net/docs/api/content/containers/images/cs_planning_apps_storage.png)

|Option|Description|
|------|-----------|
|Option 1 : Utiliser `/emptyDir` pour rendre persistantes les données à l'aide de l'espace disque disponible sur le noeud d'agent<p>Cette fonction est disponible pour les clusters léger et standard.</p>|Avec cette option, vous pouvez créer un volume vide sur l'espace disque du noeud d'agent affecté à une nacelle. Le conteneur dans cette nacelle peut lire et écrire sur ce volume. Comme le volume est affecté à une nacelle spécifique, les données ne peuvent pas être partagées avec d'autres nacelles dans un jeu de répliques.<p>Un volume `/emptyDir` et ses données sont supprimés lorsque la nacelle affectée est supprimée définitivement du noeud d'agent.</p><p>**Remarque :** si le conteneur à l'intérieur de la nacelle tombe en panne, les données du volume restent disponibles sur le noeud d'agent. </p><p>Pour plus d'informations, voir[Volumes Kubernetes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/storage/volumes/).</p>|
|Option 2 : Créer une réservation de volume persistant pour allouer un stockage NFS persistant à votre déploiement<p>Cette fonction n'est disponible que pour les clusters standard. </p>|Avec cette option, vous pouvez disposer d'un stockage persistant de données d'application et de conteneur via un nombre illimité de partages de fichiers NFS et de volumes persistants. Vous créez une [réservation de volume persistant](cs_apps.html) pour déclencher une demande de stockage de fichiers NFS. {{site.data.keyword.containershort_notm}} fournit des classes de stockage prédéfinies qui déterminent les plages de taille du stockage, les IOPS, et les droit d'accès en lecture et écriture sur le volume. Vous pouvez choisir entre ces classes de stockage lorsque vous créez votre réservation de volume persistant. Après que vous soumettez une réservation de volume persistant, {{site.data.keyword.containershort_notm}} alloue dynamiquement un volume persistant hébergé sur un stockage de fichiers NFS.[ Vous pouvez monter la réservation de volume persistant](cs_apps.html#cs_apps_volume_claim) en tant que volume sur votre nacelle pour permettre au contenir dans votre nacelle de lire et d'écrire dans le volume. Les volumes persistants peuvent être partagés entre les nacelles du même jeu de répliques ou avec d'autres nacelles dans le même
cluster.<p>Lorsqu'un conteneur tombe en panne ou qu'une nacelle est retirée d'un noeud d'agent, les données ne sont pas perdues et restent accessibles aux autres nacelles qui montent le volume. Les réservations de volume persistant sont hébergées sur un stockage permanent, mais il n'existe aucune sauvegarde correspondante. Si vous avez besoin d'une sauvegarde de vos données, créez manuellement une copie de sauvegarde.
</p><p>**Remarque :** le stockage de partages de fichiers NFS persistants est facturé sur une base mensuelle. Si vous mettez en place un stockage persistant pour votre cluster et le retirez immédiatement, vous devez quand même régler les
frais mensuels pour le stockage persistant, même si vous ne l'avez utilisé que brièvement.</p>|
|Option 3 : Lier un service de base de données {{site.data.keyword.Bluemix_notm}}
à votre nacelle<p>Cette fonction est disponible pour les clusters léger et standard.</p>|Avec cette option, vous pouvez rendre persistantes les données et y accéder à l'aide d'un service cloud de base de données {{site.data.keyword.Bluemix_notm}}. Lorsque vous liez le service
{{site.data.keyword.Bluemix_notm}} à un espace de nom dans votre
cluster, une valeur confidentielle Kubernetes est créée. Cette valeur contient des informations confidentielles sur le
service, comme son URL, votre nom d'utilisateur et mot de passe. Vous pouvez monter le
volume en tant que volume secret sur votre nacelle et accéder au service en utilisant les données d'identification dans la valeur confidentielle. En montant le volume sur sur d'autres nacelles, vous pouvez également partager les données entre les nacelles.<p>Lorsqu'un conteneur tombe en panne ou qu'une nacelle est retirée d'un noeud d'agent, les données ne sont pas perdues et restent accessibles aux autres nacelles qui montent le volume secret.</p><p>La plupart
des services de base de données {{site.data.keyword.Bluemix_notm}} proposent un espace disque
gratuit pour une petite quantité de données, de sorte que vous pouvez tester ses caractéristiques.</p><p>Pour plus d'informations sur la liaison d'un service {{site.data.keyword.Bluemix_notm}} service à une nacelle, voir [Ajout de services {{site.data.keyword.Bluemix_notm}} à des applications dans {{site.data.keyword.containershort_notm}}](cs_apps.html#cs_apps_service).</p>|
{: caption="Tableau 5. Options de stockage persistant pour les déploiements dans des clusters Kubernetes" caption-side="top"}


## Surveillance de l'état de santé
{: #cs_planning_health}

Vous pouvez utiliser les fonctions standard de Kubernetes et de Docker pour surveiller l'état de santé de votre
cluster et des applications qui y sont déployées.
{:shortdesc}
<dl>
<dt>Page des informations détaillées sur le cluster dans {{site.data.keyword.Bluemix_notm}}</dt>
<dd>{{site.data.keyword.containershort_notm}} fournit des informations sur l'état de santé et la capacité de votre
cluster et sur l'utilisation de vos ressources de cluster. Vous pouvez utiliser cette page de l'interface graphique pour étendre votre cluster, gérer votre stockage persistant et ajouter des fonctionnalités supplémentaires à votre cluster via une liaison de service {{site.data.keyword.Bluemix_notm}}. Pour visualiser cette page, accédez à votre Tableau de bord **{{site.data.keyword.Bluemix_notm}}** et sélectionnez un cluster.</dd>
<dt>Tableau de bord Kubernetes</dt>
<dd>Le tableau de bord Kubernetes est une interface Web d'administration que vous pouvez utiliser pour examiner l'état de santé de vos noeuds d'agent, rechercher des ressources Kubernetes, déployer des applications conteneurisées, et résoudre les incidents liés aux applications à l'aide des informations des journaux et de surveillance. Pour plus d'informations sur l'accès à votre tableau de bord Kubernetes, voir [Lancement du tableau de bord Kubernetes pour {{site.data.keyword.containershort_notm}}](cs_apps.html#cs_cli_dashboard).</dd>
<dt>Journaux Docker</dt>
<dd>Vous pouvez exploiter les capacités de journalisation intégrées de Docker pour examiner les activités sur les flux de sortie
STDOUT et STDERR standard. Pour plus d'informations, voir [Affichage des journaux pour un conteneur s'exécutant dans un cluster Kubernetes](/docs/services/CloudLogAnalysis/containers/logging_containers_other_logs.html#logging_containers_collect_data).</dd>
<dt>Surveillance et journalisation</dt>
<dd>{{site.data.keyword.containershort_notm}} prend
en charge des fonctions de surveillance et de journalisation supplémentaires pour les
clusters standard. Les journaux et les métriques sont consignés dans l'espace
{{site.data.keyword.Bluemix_notm}} auquel vous étiez connecté lors de la création du cluster
Kubernetes.<ul><li>Les métriques de conteneur sont collectées automatiquement pour tous les conteneurs déployés dans un cluster. Ces métriques sont envoyées et mises à disposition via Grafana. Pour plus d'informations sur les métriques, voir
[Surveillance d'{{site.data.keyword.containershort_notm}}](/docs/services/cloud-monitoring/containers/analyzing_metrics_bmx_ui.html#analyzing_metrics_bmx_ui).<p>Pour accéder au tableau de bord Grafana, accédez à `https://metrics.<region>.bluemix.net`. Sélectionnez l'organisation et l'espace {{site.data.keyword.Bluemix_notm}} où vous avez créé le cluster.</p></li><li>Les journaux de conteneur sont surveillés et réacheminés depuis l'extérieur du conteneur. Vous pouvez accéder aux journaux d'un conteneur via le tableau de bord Kibana. Pour plus d'informations sur la journalisation, voir [Journalisation pour {{site.data.keyword.containershort_notm}}](/docs/services/CloudLogAnalysis/index.html#getting-started-with-cla).<p>Pour accéder au tableau de bord Kibana, accédez à `https://logging.<region>.bluemix.net`. Sélectionnez l'organisation et l'espace {{site.data.keyword.Bluemix_notm}} où vous avez créé le cluster.</p></li></ul></dd>
</dl>

### Autres outils de surveillance de l'état de santé
{: #concept_xrh_dhj_wz}

Vous pouvez configurer d'autres outils pour disposer de capacités de journalisation et de surveillance supplémentaires.
<dl>
<dt>Prometheus</dt>
<dd>Prometheus est un outil à code source ouvert de surveillance, de journalisation et d'alerte conçu spécifiquement pour Kubernetes afin d'extraire des informations détaillées sur le cluster, les noeuds d'agent et l'état de santé du déploiement à partir des informations de journalisation de Kubernetes. Pour obtenir des informations de configuration, voir [Intégration de services avec les {{site.data.keyword.containershort_notm}}](#cs_planning_integrations).</dd>
</dl>


## Intégrations
{: #cs_planning_integrations}

Vous pouvez utiliser divers services externes, ainsi que des services du catalogue {{site.data.keyword.Bluemix_notm}}, avec un cluster standard dans {{site.data.keyword.containershort_notm}}.
{:shortdesc}

<table summary="Récapitulatif de l'accessibilité">
<caption>Tableau 6. Options d'intégration pour les clusters et les applications dans Kubernetes</caption>
<thead>
<tr>
<th>Service</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td>IBM Blockchain</td>
<td>Permet de déployer un environnement de développement disponible publiquement pour IBM Blockchain sur un cluster Kubernetes dans {{site.data.keyword.containerlong_notm}}. Utilisez cet environnement pour développer et personnaliser votre propre réseau de blockchain afin de déployer des applications qui partagent un grand livre non modifiable dédié à l'enregistrement de l'historique des transactions. Pour plus d'informations, voir <a href="https://ibm-blockchain.github.io" target="_blank">Develop in a cloud sandbox
IBM Blockchain Platform <img src="../icons/launch-glyph.svg" alt="External link icon"></a>. </td>
</tr>
<tr>
<td>Istio</td>
<td>Istio est un service open source qui permet aux développeurs de connecter, de sécuriser, de gérer et de surveiller un réseau de microservices, également dénommé maillage de services, sur les plateformes d'orchestration de cloud telles que
Kubernetes. Istio offre la possibilité de gérer le trafic réseau, d'équilibrer la charge entre les
microservices, de mettre en vigueur des règles d'accès, et de vérifier l'identité des services sur le maillage des services. Pour installer
Istio sur votre cluster Kubernetes dans {{site.data.keyword.containershort_notm}}, voir la <a href="https://istio.io/docs/tasks/installing-istio.html" target="_blank">rubrique d'installation <img src="../icons/launch-glyph.svg" alt="External link icon"></a> dans la documentation Istio. Pour examiner un exemple de parcours de développeur montrant comment utiliser Istio avec Kubernetes, voir <a href="https://developer.ibm.com/code/journey/manage-microservices-traffic-using-istio/" target="_blank">Manage microservices traffic using Istio <img src="../icons/launch-glyph.svg" alt="External link icon"></a>.</td>
</tr>
<tr>
<td>Prometheus</td>
<td>Prometheus est un outil à code source ouvert de surveillance, de journalisation et d'alerte conçu spécifiquement pour Kubernetes afin d'extraire des informations détaillées sur le cluster, les noeuds d'agent et l'état de santé du déploiement à partir des informations de journalisation de Kubernetes. Les informations d'utilisation de l'UC, de la mémoire et du réseau de tous les conteneurs en activité sont collectées et peuvent être utilisées dans des interrogations ou des alertes personnalisées pour surveiller les
performances et les charges de travail de votre cluster.
<p>Pour utiliser Prometheus, procédez comme suit :</p>
<ol>
<li>Installez Prometheus en suivant <a href="https://github.com/coreos/prometheus-operator/tree/master/contrib/kube-prometheus" target="_blank">les instructions CoreOS<img src="../icons/launch-glyph.svg" alt="External link icon"></a>.
<ol>
<li>Lorsque vous exécutez la commande export, utilisez votre espace de nom kube-system. <p><code>export NAMESPACE=kube-system hack/cluster-monitoring/deploy</code></p></li>
</ol>
</li>
<li>Une fois que Prometheus a été déployé dans votre cluster, éditez dans Grafana la source de données Prometheus pour se référer à
<code>prometheus.kube-system:30900</code>.</li>
</ol>
</td>
</tr>
<tr>
<td>Weave Scope</td>
<td>Weave Scope produit un diagramme visuel de vos ressources dans un cluster Kubernetes,
notamment des services, nacelles, conteneurs, processus, noeuds, et autres. Weave Scope fournit des métriques interactives
sur l'utilisation de l'UC et de la mémoire, ainsi que des outils pour suivi et exécution dans un conteneur.<p>Pour plus d'informations, voir[Visualisation de ressources de cluster Kubernetes via Weave Scope et {{site.data.keyword.containershort_notm}}](cs_cluster.html#cs_weavescope).</p></li></ol>
</td>
</tr>
</tbody>
</table>


## Accédez au portefeuille {{site.data.keyword.BluSoftlayer_notm}}
{: #cs_planning_unify_accounts}

Pour créer un cluster Kubernetes standard, vous devez avoir accès au portefeuille {{site.data.keyword.BluSoftlayer_notm}}. Cet accès est nécessaire pour réclamer des ressources d'infrastructure payantes, telles que des noeuds d'agent, des adresses IP publiques portables ou un stockage persistant pour votre
cluster.
{:shortdesc}

Les comptes {{site.data.keyword.Bluemix_notm}} de type Paiement à la carte créés après l'activation de la liaison automatique de compte étant déjà configurés pour un accès au portefeuille {{site.data.keyword.BluSoftlayer_notm}}, vous pouvez acquérir des ressources d'infrastructure pour votre cluster sans configuration supplémentaire.

Les utilisateurs dotés d'autres types de compte {{site.data.keyword.Bluemix_notm}},
ou disposant d'un compte {{site.data.keyword.BluSoftlayer_notm}} existant non lié à leur compte
{{site.data.keyword.Bluemix_notm}}, doivent
configurer leurs comptes pour créer des clusters standard.

Consultez le tableau suivant pour identifier les options disponibles pour chaque type de compte.

|Type de compte|Description|Options disponibles pour création d'un cluster standard|
|------------|-----------|----------------------------------------------|
|Comptes d'essai gratuit|Les comptes d'essai gratuit ne peuvent pas accéder au portefeuille {{site.data.keyword.BluSoftlayer_notm}}.<p>Si vous disposez d'un compte
{{site.data.keyword.BluSoftlayer_notm}}, vous pouvez le lier à votre compte d'essai gratuit.</p>|<ul><li>Option 1 : [Mettez à niveau votre compte d'essai gratuit vers un compte {{site.data.keyword.Bluemix_notm}} de type Paiement à la carte](/docs/pricing/billable.html#upgradetopayg)
configuré pour accéder au portefeuille {{site.data.keyword.BluSoftlayer_notm}}.</li><li>Option 2 : [Liez votre compte d'essai gratuit à un compte {{site.data.keyword.BluSoftlayer_notm}} existant](/docs/pricing/linking_accounts.html#unifyingaccounts).<p>Après leur liaison, votre compte d'essai gratuit est mis à niveau automatiquement vers un compte de type Paiement à la carte. Lorsque vous liez vos comptes,
vous êtes facturé via {{site.data.keyword.Bluemix_notm}} pour les ressources {{site.data.keyword.Bluemix_notm}} et {{site.data.keyword.BluSoftlayer_notm}}.</p><p>**Remarque :** le compte {{site.data.keyword.BluSoftlayer_notm}} que vous liez doit être configuré avec des droits superutilisateur. </p></li></ul>|
|Anciens comptes de type Paiement à la carte|Les comptes de type Paiement à la carte créés avant que la liaison automatique de compte ne soit disponible ne disposaient pas d'un accès au portefeuille {{site.data.keyword.BluSoftlayer_notm}}.<p>Si vous disposez d'un compte {{site.data.keyword.BluSoftlayer_notm}} existant, vous ne pouvez pas le lier à un ancien compte de type Paiement à la carte. </p>|<ul><li>Option 1 : [Créez un nouveau compte de type Paiement à la carte](/docs/pricing/billable.html#billable) configuré avec accès au portefeuille {{site.data.keyword.BluSoftlayer_notm}}. Si vous sélectionnez cette option, vous disposerez de deux comptes {{site.data.keyword.Bluemix_notm}} avec facturation distincte.<p>Si vous désirez continuer à utiliser votre ancien compte Pay-As-You-Go (Paiement à la carte) pour créer des clusters standard, vous pouvez utiliser le nouveau pour générer une clé d'API pour accéder au portefeuille {{site.data.keyword.BluSoftlayer_notm}}. Vous devez alors configurer la clé d'API pour votre ancien compte
Pay-As-You-Go (Paiement à la carte). Pour plus d'informations, voir [Génération d'une clé d'API pour d'anciens comptes Pay-As-You-Go et Subscription](#old_account). Rappelez-vous que les ressources {{site.data.keyword.BluSoftlayer_notm}} sont facturées via votre nouveau compte
Pay-As-You-Go (Paiement à la carte).</p></li><li>Option 2 : si vous disposez déjà d'un compte {{site.data.keyword.BluSoftlayer_notm}} existant que vous désirez utiliser, vous pouvez
[définir vos données d'identification](cs_cli_reference.html#cs_credentials_set) pour votre compte
{{site.data.keyword.Bluemix_notm}}.<p>**Remarque :** le compte {{site.data.keyword.BluSoftlayer_notm}} que vous utilisez avec votre compte {{site.data.keyword.Bluemix_notm}} doit être configuré avec des droits superutilisateur. </p></li></ul>|
|Comptes d'abonnement|Les comptes d'abonnement ne sont pas configurés pour accès au portefeuille {{site.data.keyword.BluSoftlayer_notm}}.|<ul><li>Option 1 : [Créez un nouveau compte Pay-As-You-Go (Paiement à la carte)](/docs/pricing/billable.html#billable) configuré avec accès au portefeuille {{site.data.keyword.BluSoftlayer_notm}}. Si vous sélectionnez cette option, vous disposerez de deux comptes {{site.data.keyword.Bluemix_notm}} avec facturation distincte.<p>Si vous désirez continuer à utiliser votre compte Subscription (Abonnement) pour créer des clusters standard, vous pouvez utiliser votre nouveau compte Pay-As-You-Go (Paiement à la carte) pour générer une clé d'API pour accéder au portefeuille {{site.data.keyword.BluSoftlayer_notm}}. Vous devez ensuite configurer votre clé d'API pour votre compte
Subscription. Pour plus d'informations, voir [Génération d'une clé d'API pour d'anciens comptes Pay-As-You-Go et Subscription](#old_account). Rappelez-vous que les ressources {{site.data.keyword.BluSoftlayer_notm}} sont facturées via votre nouveau compte
Pay-As-You-Go (Paiement à la carte).</p></li><li>Option 2 : si vous disposez déjà d'un compte {{site.data.keyword.BluSoftlayer_notm}} existant que vous désirez utiliser, vous pouvez
[définir vos données d'identification](cs_cli_reference.html#cs_credentials_set) pour votre compte
{{site.data.keyword.Bluemix_notm}}.<p>**Remarque :** le compte {{site.data.keyword.BluSoftlayer_notm}} que vous utilisez avec votre compte {{site.data.keyword.Bluemix_notm}} doit être configuré avec des droits superutilisateur. </p></li></ul>|
|Comptes {{site.data.keyword.BluSoftlayer_notm}}, sans compte {{site.data.keyword.Bluemix_notm}}|Pour créer un cluster standard, vous devez disposer d'un compte {{site.data.keyword.Bluemix_notm}}.|<ul><li>Option 1 : [Créez un nouveau compte Pay-As-You-Go (Paiement à la carte)](/docs/pricing/billable.html#billable) configuré avec accès au portefeuille {{site.data.keyword.BluSoftlayer_notm}}. Si vous sélectionnez cette option, une nouvelle
{{site.data.keyword.BluSoftlayer_notm}} est créée pour vous. Vous disposez de
deux comptes {{site.data.keyword.BluSoftlayer_notm}} et de facturations distincts.</li><li>Option 2 : [Créez un compte d'essai gratuit](/docs/pricing/free.html#pricing) et [liez-le à votre compte {{site.data.keyword.BluSoftlayer_notm}} existant](/docs/pricing/linking_accounts.html#unifyingaccounts). Après leur liaison, votre compte d'essai gratuit est mis à niveau automatiquement vers un compte Pay-As-You-Go (Paiement à la carte). Lorsque vous liez vos comptes,
vous êtes facturé via {{site.data.keyword.Bluemix_notm}} pour les ressources {{site.data.keyword.Bluemix_notm}} et {{site.data.keyword.BluSoftlayer_notm}}.<p>**Remarque :** le compte {{site.data.keyword.BluSoftlayer_notm}} que vous liez doit être configuré avec des droits superutilisateur. </p></li></ul>|
{: caption="Tableau 7. Options disponibles pour création de clusters standard avec des comptes non liés à un compte {{site.data.keyword.BluSoftlayer_notm}}" caption-side="top"}


### Génération d'une clé d'API {{site.data.keyword.BluSoftlayer_notm}} pour son utilisation avec des comptes
{{site.data.keyword.Bluemix_notm}}
{: #old_account}

Si vous désirez continuer à utiliser votre ancien compte Pay-As-You-Go (Paiement à la carte) ou Subscription (Abonnement) pour créer des clusters standard, vous devez générer une clé d'API avec votre nouveau compte Pay-As-You-Go et la configurer pour votre ancien compte.
{:shortdesc}

Avant de commencer, créez un compte {{site.data.keyword.Bluemix_notm}}
de type Pay-As-You-Go (Paiement à la carte) lequel est automatiquement configuré avec accès au portefeuille {{site.data.keyword.BluSoftlayer_notm}}.

1.  Connectez-vous au portail [{{site.data.keyword.BluSoftlayer_notm}}  ![External link icon](../icons/launch-glyph.svg "External link icon")](https://control.softlayer.com/) à l'aide de l'{{site.data.keyword.ibmid}} et du mot de passe que vous avez créés pour votre nouveau compte de type Paiement à la carte. 
2.  Sélectionnez **Compte**, puis **Utilisateurs**.
3.  Cliquez sur **Générer** afin de générer une clé d'API {{site.data.keyword.BluSoftlayer_notm}} pour votre nouveau compte Pay-As-You-Go (Paiement à la carte).
4.  Copiez la clé d'API.
5.  Depuis l'interface CLI, connectez-vous à {{site.data.keyword.Bluemix_notm}} à l'aide de l'{{site.data.keyword.ibmid}} et du mot de passe de votre ancien compte de type Paiement à la carte ou Abonnement. 

  ```
  bx login
  ```
  {: pre}

6.  Configurez la clé d'API que vous avez générée pour accès au portefeuille {{site.data.keyword.BluSoftlayer_notm}}. Remplacez `<API_KEY>` par la clé d'API et `<USERNAME>` par l'{{site.data.keyword.ibmid}} de votre nouveau compte de type Paiement à la carte. 

  ```
  bx cs credentials-set --infrastructure-api-key <API_KEY> --infrastructure-username <USERNAME>
  ```
  {: pre}

7.  Commencez à [créer des clusters standard](cs_cluster.html#cs_cluster_cli).

**Remarque :** pour examiner votre clé d'API après l'avoir générée, suivez les étapes 1 et 2, puis dans la section
**Clé d'API**, cliquez sur **Afficher** pour visualiser la clé d'API pour votre ID utilisateur.  
