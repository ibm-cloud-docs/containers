---

copyright:
  years: 2014, 2018
lastupdated: "2018-02-02"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Configuration de clusters
{: #clusters}

Concevez la configuration de vos clusters en vue d'une disponibilité et d'une capacité maximale.
{:shortdesc}


## Planification de la configuration d'un cluster
{: #planning_clusters}

Utilisez des clusters standards pour accroître la disponibilité des applications. Vos utilisateurs risquent moins de rencontrer des indisponibilités lorsque vous disséminez votre configuration entre plusieurs noeuds d'agent et clusters. Les fonctions intégrées, telles que l'équilibrage de charge et l'isolement, augmentent la résilience en cas de pannes d'hôtes, de réseaux ou d'applications.
{:shortdesc}

Examinez ces configurations potentielles de cluster, classées par ordre croissant de disponibilité :

![Niveaux de haute disponibilité pour un cluster](images/cs_cluster_ha_roadmap.png)

1.  Un seul cluster avec plusieurs noeuds d'agent
2.  Deux clusters s'exécutant dans des emplacements différents dans la même région, chacun avec plusieurs noeuds d'agent
3.  Deux clusters s'exécutant dans des régions différentes, chacun avec plusieurs noeuds d'agent

Augmentez la disponibilité de votre cluster à l'aide des techniques suivantes :

<dl>
<dt>Diffusez les applications entre les noeuds worker</dt>
<dd>Permettez aux développeurs de répartir leurs applications dans des conteneurs sur plusieurs noeuds worker par cluster. Une instance d'application dans chacun de trois noeuds worker permet une indisponibilité d'un noeud worker sans interrompre l'utilisation de l'application. Vous pouvez configurer le nombre de noeuds worker à inclure lorsque vous créez un cluster depuis l'[interface graphique {{site.data.keyword.Bluemix_notm}}](cs_clusters.html#clusters_ui) ou l'[interface de ligne de commande](cs_clusters.html#clusters_cli). Kubernetes limitant le nombre maximal de noeuds worker que vous pouvez avoir dans un cluster, gardez présent à l'esprit [les quotas de noeud worker et de pod![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/admin/cluster-large/).
<pre class="codeblock">
<code>bx cs cluster-create --location &lt;dal10&gt; --workers 3 --public-vlan &lt;my_public_vlan_id&gt; --private-vlan &lt;my_private_vlan_id&gt; --machine-type &lt;u2c.2x4&gt; --name &lt;my_cluster&gt;</code>
</pre>
</dd>
<dt>Disséminez les applications entre les clusters</dt>
<dd>Créez plusieurs clusters, chacun avec plusieurs noeuds d'agent. Si une indisponibilité affecte un
cluster, les utilisateurs peuvent toujours accéder à une application également déployée dans un autre cluster.
<p>Cluster
1 :</p>
<pre class="codeblock">
<code>bx cs cluster-create --location &lt;dal10&gt; --workers 3 --public-vlan &lt;my_public_vlan_id&gt; --private-vlan &lt;my_private_vlan_id&gt; --machine-type &lt;u2c.2x4&gt; --name &lt;my_cluster1&gt;</code>
</pre>
<p>Cluster 2 :</p>
<pre class="codeblock">
<code>bx cs cluster-create --location &lt;dal12&gt; --workers 3 --public-vlan &lt;my_public_vlan_id&gt; --private-vlan &lt;my_private_vlan_id&gt; --machine-type &lt;u2c.2x4&gt;  --name &lt;my_cluster2&gt;</code>
</pre>
</dd>
<dt>Disséminez les applications entre des clusters dans des régions différentes</dt>
<dd>Lorsque vous disséminez les applications entre clusters dans différentes régions, vous pouvez permettre un équilibrage de charge basé sur la région où est situé l'utilisateur. Si le cluster, un matériel, voire un emplacement complet dans une région tombe
en  panne, le trafic est acheminé au conteneur déployé dans un autre emplacement.
<p><strong>Important :</strong> après avoir configuré un domaine personnalisé, vous pouvez utiliser ces commandes pour créer les clusters.</p>
<p>Emplacement 1 :</p>
<pre class="codeblock">
<code>bx cs cluster-create --location &lt;dal10&gt; --workers 3 --public-vlan &lt;my_public_vlan_id&gt; --private-vlan &lt;my_private_vlan_id&gt; --machine-type &lt;u2c.2x4&gt; --name &lt;my_cluster1&gt;</code>
</pre>
<p>Emplacement 2 :</p>
<pre class="codeblock">
<code>bx cs cluster-create --location &lt;ams03&gt; --workers 3 --public-vlan &lt;my_public_vlan_id&gt; --private-vlan &lt;my_private_vlan_id&gt; --machine-type &lt;u2c.2x4&gt; --name &lt;my_cluster2&gt;</code>
</pre>
</dd>
</dl>

<br />


## Planification de la configuration de noeud worker
{: #planning_worker_nodes}

Un cluster Kubernetes est composé de noeuds worker et est surveillé et géré de manière centralisée par le maître Kubernetes. Les administrateurs du cluster décident comment configurer le cluster de noeuds worker pour garantir que les utilisateurs du cluster disposent de toutes les ressources pour d&ployer et exécuter des applications dans le cluster.
{:shortdesc}

Lorsque vous créez un cluster standard, les noeuds d'agent sont organisés pour vous dans l'infrastructure IBM Cloud (SoftLayer) et configurés dans {{site.data.keyword.Bluemix_notm}}. A chaque noeud worker sont affectés un ID de noeud worker unique et un nom de domaine qui ne doivent pas être modifiés après la création du cluster. Selon le niveau d'isolement du matériel que vous sélectionnez, les noeuds d'agent peuvent être configurés en tant que noeuds partagés ou dédiés. Vous pouvez également décider si vos noeuds worker doivent se connecter à un VLAN public et à un VLAN privé, ou seulement à un VLAN privé. Chaque noeud worker est doté d'un type de machine spécifique qui détermine le nombre d'UC, la mémoire et l'espace disque disponibles pour les conteneurs déployés sur le noeud worker. Kubernetes limite le nombre maximal de noeuds d'agent dont vous pouvez disposer dans un cluster. Pour plus d'informations, voir la rubrique sur les [quotas de noeud worker et de pod ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/admin/cluster-large/).


### Matériel pour les noeuds d'agent
{: #shared_dedicated_node}

Chaque noeud worker est installé sous forme de machine virtuelle sur le matériel physique. Lorsque vous créez un cluster standard dans {{site.data.keyword.Bluemix_notm}}, vous devez décider si le matériel sous-jacent doit être partagé par plusieurs clients {{site.data.keyword.IBM_notm}} (service partagé) ou vous être dédié exclusivement (service exclusif).
{:shortdesc}

Dans une configuration de service partagé, les ressources physiques (comme l'UC et la mémoire) sont partagées par toutes les machines virtuelles déployés sur le même matériel physique. Pour permettre à chaque machine virtuelle d'opérer indépendamment, un moniteur de machine virtuelle, également dénommé hyperviseur, segmente les ressources physiques en entités isolées et les alloue à une machine virtuelle en tant que ressources dédiés (isolement par hyperviseur).

Dans une configuration de service exclusif, toutes les ressources physiques vous sont dédiées en exclusivité. Vous pouvez déployer plusieurs noeuds d'agent en tant que machines virtuelles sur le même hôte physique. A l'instar de la configuration de service partagé, l'hyperviseur veille à ce que chaque noeud worker ait sa part des ressources physiques disponibles.

Les noeuds partagés sont généralement moins coûteux que les noeuds dédiés vu que les coûts du matériel sous-jacent sont partagés entre plusieurs clients. Toutefois, lorsque vous choisissez entre noeuds partagés et noeud dédiés, vous devriez contacter votre service juridique pour déterminer le niveau d'isolement de l'infrastructure et de conformité requis par votre environnement d'application.

Lorsque vous créez un cluster gratuit, votre noeud worker est automatiquement provisionné en tant que noeud partagé dans le compte IBM Cloud infrastructure (SoftLayer).

### Connexion de réseau virtuel (VLAN) pour noeuds worker
{: #worker_vlan_connection}

Lorsque vous créez un cluster, chaque cluster est automatiquement connecté à un réseau local virtuel depuis votre compte IBM Cloud Infrastructure (SoftLayer). Un réseau local virtuel configure un groupe de noeuds d'agent et de pods comme s'ils étaient reliés physiquement au même câble. Le réseau privé virtuel privé détermine l'adresse IP privée affectée à un noeud worker lors de la création du cluster, et le réseau virtuel public, l'adresse IP publique affectée au noeud worker.

Dans le cas de clusters gratuits, les noeuds worker du cluster sont connectés lors de la création du cluster à un réseau virtuel public et à un réseau privé virtuel dont IBM est le propriétaire. Dans le cas de clusters standards, vous pouvez connecter vos noeuds worker à la fois à un réseau virtuel public et à un réseau virtuel privé, ou seulement à un réseau virtuel privé. Si vous désirez connecter vos noeuds worker seulement à un réseau privé, vous pouvez spécifier l'ID d'un réseau virtuel privé existant lors de la création du cluster. Vous devez toutefois configurer une solution alternative pour permettre une connexion sécurisée entre les noeuds worker et le maître Kubernetes. Vous pourriez, par exemple, configurer un Vyatta pour transmettre le trafic des noeuds worker du réseau virtuel privé au maître Kubernetes. Voir "Configuration d'un Vyatta personnalisé pour connexion sécurisée de vos noeuds worker au maître Kubernetes" dans la [documentation d'IBM Cloud infrastructure (SoftLayer)](https://knowledgelayer.softlayer.com/procedure/basic-configuration-vyatta) pour plus d'informations.

### Limite de mémoire des noeuds d'agent
{: #resource_limit_node}

{{site.data.keyword.containershort_notm}} définit une limite de mémoire sur chaque noeud worker. Lorsque des pods qui s'exécutent sur le noeud worker dépassent cette limite de mémoire, ils sont supprimés. Dans Kubernetes, cette limite est appelée [seuil d’éviction immédiate![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/tasks/administer-cluster/out-of-resource/#hard-eviction-thresholds).
{:shortdesc}

Si vos pods sont fréquemment supprimés, ajoutez des noeuds d'agent à votre cluster ou définissez des [limites de ressource![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#resource-requests-and-limits-of-pod-and-container) sur vos pods.

Chaque type de machine dispose d'une capacité mémoire différente. Lorsque la quantité de mémoire disponible sur le noeud worker est inférieure au seuil mininum autorisé, Kubernetes supprime immédiatement le pod. Le pod est replanifié sur un autre noeud worker disponible.

|Capacité mémoire du noeud worker|Seuil minimum de mémoire du noeud worker|
|---------------------------|------------|
|4 Go  | 256 Mo |
|16 Go | 1024 Mo |
|64 Go | 4096 Mo |
|128 Go| 4096 Mo |
|242 Go| 4096 Mo |

Pour vérifier la quantité de mémoire utilisée sur un noeud worker, exécutez [kubectl top node ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#top).



<br />



## Création de clusters depuis l'interface graphique
{: #clusters_ui}

Un cluster Kubernetes est un ensemble de noeuds d'agent organisés dans un réseau. L'objet de ce cluster est de définir un ensemble de ressources, de noeuds, de réseaux et de périphériques de stockage permettant d'assurer une haute disponibilité des applications. Avant de pouvoir déployer une application, vous devez créer un cluster et spécifier les définitions des noeuds d'agent dans ce cluster.
{:shortdesc}

Pour créer un cluster, procédez comme suit :
1. Dans le catalogue, sélectionnez **Cluster Kubernetes**.
2. Sélectionnez une région dans lequel déployer votre cluster.
3. Sélectionnez un type de plan de cluster. Vous avez le choix entre **Free** (Gratuit) ou **Pay-As-You-Go** (Paiement à la carte). Avec le plan Paiement à la carte, vous pouvez mettre à disposition un cluster standard avec des fonctions, telles que des noeuds d'agent multiples pour un environnement à haute disponibilité.
4. Configurez les détails de votre cluster.
    1. Attribuez un nom à votre cluster, sélectionnez une version de Kubernetes et l'emplacement dans lequel déployer votre cluster. Pour performances optimales, sélectionnez l'emplacement physiquement le plus proche. N'oubliez pas si vous sélectionnez un emplacement hors de votre pays que vous aurez peut-être besoin d'une autorisation des autorités pour stocker physiquement des données à l'étranger.
    2. Sélectionnez un type de machine et indiquez le nombre de noeuds d'agent dont vous avez besoin. Le type de machine définit le nombre d'UC virtuelles, la mémoire et l'espace disque configurés dans chaque noeud worker et rendus disponibles aux conteneurs.
    3. Sélectionnez un réseau local virtuel (VLAN) public et un VLAN privé à partir de votre compte d'infrastructure IBM Cloud (SoftLayer). Ces deux réseaux VLAN communiquent entre les noeuds d'agent mais le réseau VLAN public communique également avec le noeud maître Kubernetes géré par IBM. Vous pouvez utiliser le même VLAN pour plusieurs clusters.
        **Remarque** : si vous choisissez de ne pas sélectionner de VLAN public, vous devez configurer une solution alternative. Voir [Connexion de réseau virtuel pour noeuds worker](#worker_vlan_connection) pour plus d'informations.
    4. Sélectionnez un type de matériel.
        - **Dédié **: vos noeuds worker sont hébergés sur l'infrastructure dédiée à votre compte. Vos ressources sont complètement isolées.
        - **Partagé **: les ressources de l'infrastructure, comme l'hyperviseur et le matériel physique, sont partagées avec d'autres clients IBM, mais chaque noeud worker est accessible uniquement par vous. Bien que cette solution soit moins onéreuse et généralement suffisante, vérifiez cependant les consignes de votre entreprise quant aux exigences en termes de performance et d'infrastructure.
    5. Par défaut, l'option **Chiffrer le disque local** est sélectionnée. Si vous décochez cette case, les données Docker de l'hôte ne sont pas chiffrées. [En savoir plus sur le chiffrement](cs_secure.html#encrypted_disks).
4. Cliquez sur **Créer un cluster**. Vous pouvez voir la progression du déploiement du noeud worker dans l'onglet **Noeuds d'agent**. Une fois le déploiement terminé, vous pouvez voir si le cluster est prêt dans l'onglet **Vue d'ensemble**.
    **Remarque :** A chaque noeud worker sont affectés un ID de noeud worker unique et un nom de domaine qui ne doivent pas être modifiés manuellement après la création du cluster. La modification de l'ID ou du domaine empêcherait le maître
Kubernetes de gérer votre cluster.


**Etape suivante ?**

Une fois le cluster opérationnel, vous pouvez réaliser les tâches suivantes :

-   [Installer les interfaces de ligne de commande pour commencer à utiliser votre cluster.](cs_cli_install.html#cs_cli_install)
-   [Déployer une application dans votre cluster.](cs_app.html#app_cli)
-   [Configurer votre propre registre privé dans {{site.data.keyword.Bluemix_notm}} pour stocker et partager des images Docker avec d'autres utilisateurs.](/docs/services/Registry/index.html)
- Si vous utilisez un pare-feu, vous devrez peut-être [ouvrir les ports requis](cs_firewall.html#firewall) afin d'utiliser les commandes `bx`, `kubectl` ou `calicotl`, autoriser le trafic sortant de votre cluster ou le trafic entrant pour les services réseau.

<br />


## Création de clusters depuis l'interface CLI
{: #clusters_cli}

Un cluster est un ensemble de noeuds d'agent organisés dans un réseau. L'objet de ce cluster est de définir un ensemble de ressources, de noeuds, de réseaux et de périphériques de stockage permettant d'assurer une haute disponibilité des applications. Avant de pouvoir déployer une application, vous devez créer un cluster et spécifier les définitions des noeuds d'agent dans ce cluster.
{:shortdesc}

Pour créer un cluster, procédez comme suit :
1.  Installez l'interface de ligne de commande {{site.data.keyword.Bluemix_notm}} et le [plug-in {{site.data.keyword.containershort_notm}}](cs_cli_install.html#cs_cli_install).
2.  Connectez-vous à l'interface de ligne de commande {{site.data.keyword.Bluemix_notm}}. A l'invite, entrez vos données
d'identification {{site.data.keyword.Bluemix_notm}}.

    ```
    bx login
    ```
    {: pre}

    **Remarque :** si vous possédez un ID fédéré, exécutez la commande `bx login --sso` pour vous connecter à l'interface de ligne de commande {{site.data.keyword.Bluemix_notm}}. Entrez votre nom d'utilisateur et utilisez l'URL mentionnée dans la sortie CLI pour extraire votre code d'accès à usage unique. Si la connexion échoue alors que vous omettez l'option `--sso` et aboutit en incluant l'option `--sso`, ceci indique que votre ID est fédéré.

3. Si vous disposez de plusieurs comptes {{site.data.keyword.Bluemix_notm}}, sélectionnez le compte que vous voulez utiliser pour créer votre cluster Kubernetes.

4.  Si vous désirez créer ou accéder à des clusters Kubernetes dans une région {{site.data.keyword.Bluemix_notm}} autre que celle que vous aviez sélectionnée auparavant, exécutez la commande `bx cs region-set`.

6.  Créez un cluster.
    1.  Examinez les emplacements disponibles. Les emplacements affichés dépendent de la région {{site.data.keyword.containershort_notm}} à laquelle vous êtes connecté.

        ```
        bx cs locations
        ```
        {: pre}

        La sortie de l'interface de ligne de commande correspond aux [emplacements de la région du conteneur](cs_regions.html#locations).

    2.  Sélectionnez un emplacement et examinez les types de machine disponibles sur celui-ci. Le type de machine spécifie les ressources de traitement virtuelles disponibles pour chaque noeud worker.

        ```
        bx cs machine-types <location>
        ```
        {: pre}

        ```
        Getting machine types list...
        OK
        Machine Types
        Name         Cores   Memory   Network Speed   OS             Storage   Server Type
        u2c.2x4      2       4GB      1000Mbps        UBUNTU_16_64   100GB     virtual
        b2c.4x16     4       16GB     1000Mbps        UBUNTU_16_64   100GB     virtual
        b2c.16x64    16      64GB     1000Mbps        UBUNTU_16_64   100GB     virtual
        b2c.32x128   32      128GB    1000Mbps        UBUNTU_16_64   100GB     virtual
        b2c.56x242   56      242GB    1000Mbps        UBUNTU_16_64   100GB     virtual
        ```
        {: screen}

    3.  Vérifiez s'il existe des réseaux VLAN public et privé dans l'infrastructure IBM Cloud (SoftLayer) pour ce compte.

        ```
        bx cs vlans <location>
        ```
        {: pre}

        ```
        ID        Name                Number   Type      Router  
        1519999   vlan   1355     private   bcr02a.dal10  
        1519898   vlan   1357     private   bcr02a.dal10 
        1518787   vlan   1252     public   fcr02a.dal10 
        1518888   vlan   1254     public    fcr02a.dal10
        ```
        {: screen}

        S'il existe déjà un réseau virtuel public et privé, notez les routeurs correspondants. Les routeurs de VLAN privé commencent toujours par `bcr` (routeur dorsal) et les routeurs de VLAN public par `fcr` (routeur frontal). Le numéro et la combinaison de lettres après ces préfixes doivent correspondre pour pouvoir utiliser ces réseaux locaux virtuels lors de la création d'un cluster. Dans l'exemple de sortie, n'importe quel réseau local virtuel privé peut être utilisé avec l'un des réseaux publics virtuels privés vu que les routeurs incluent tous `02a.dal10`.

    4.  Exécutez la commande `cluster-create`. Vous avez le choix entre un cluster gratuit, lequel inclut un noeud worker configuré avec 2 UC virtuelles et 4 Go de mémoire, et un cluster standard, doté d'autant de noeuds worker que vous le désirez dans votre compte IBM Cloud infrastructure (SoftLayer). Lorsque vous créez un cluster standard, par défaut, les disques de noeud worker sont chiffrés, son matériel est partagé par plusieurs clients IBM et il est facturé par heures d'utilisation. </br>Exemple pour un cluster standard :

        ```
        bx cs cluster-create --location dal10 --machine-type u2c.2x4 --hardware <shared_or_dedicated> --public-vlan <public_vlan_id> --private-vlan <private_vlan_id> --workers 3 --name <cluster_name> --kube-version <major.minor.patch>
        ```
        {: pre}

        Exemple pour un cluster gratuit :

        ```
        bx cs cluster-create --name my_cluster
        ```
        {: pre}

        <table>
        <caption>Table. Description des composants de la commande <code>bx cs cluster-create</code></caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composantes de cette commande</th>
        </thead>
        <tbody>
        <tr>
        <td><code>cluster-create</code></td>
        <td>Commande de création d'un cluster dans votre organisation {{site.data.keyword.Bluemix_notm}}.</td>
        </tr>
        <tr>
        <td><code>--location <em>&lt;location&gt;</em></code></td>
        <td>Remplacez <em>&lt;location&gt;</em> par l'ID de l'emplacement {{site.data.keyword.Bluemix_notm}} où vous désirez créer votre cluster. Les [emplacements disponibles](cs_regions.html#locations) dépendent de la région {{site.data.keyword.containershort_notm}} à laquelle vous êtes connecté.</td>
        </tr>
        <tr>
        <td><code>--machine-type <em>&lt;machine_type&gt;</em></code></td>
        <td>Si vous créez un cluster standard, choisissez un type de machine. Le type de machine spécifie les ressources de traitement virtuelles disponibles pour chaque noeud worker. Consultez la rubrique [Comparaison de clusters gratuits et standards {{site.data.keyword.containershort_notm}}](cs_why.html#cluster_types) pour plus d'informations. Dans le cas de clusters gratuits, vous n'avez pas besoin de définir le type de machine.</td>
        </tr>
        <tr>
        <td><code>--hardware <em>&lt;shared_or_dedicated&gt;</em></code></td>
        <td>Niveau d'isolation du matériel pour votre noeud worker. Utilisez dedicated pour que toutes les ressources physiques vous soient dédiées exclusivement ou shared pour permettre leur partage avec d'autres clients IBM. La valeur par défaut est shared. Cette valeur est facultative pour les clusters standards et n'est pas disponible pour les clusters gratuits.</td>
        </tr>
        <tr>
        <td><code>--public-vlan <em>&lt;public_vlan_id&gt;</em></code></td>
        <td><ul>
          <li>Dans le cas de clusters gratuits, vous n'avez pas besoin de définir de réseau local virtuel public. Votre cluster gratuit est automatiquement connecté à un VLAN public dont IBM est propriétaire.</li>
          <li>Pour un cluster standard, si vous disposez déjà d'un VLAN public configuré dans votre compte d'infrastructure IBM Cloud (SoftLayer) pour cet emplacement, entrez l'ID du VLAN public. Si vous ne disposez pas d'un VLAN public et d'un VLAN privé dans votre compte, ne spécifiez pas cette option. {{site.data.keyword.containershort_notm}} crée automatiquement un VLAN public pour vous.<br/><br/>
          <strong>Remarque</strong> : les routeurs de VLAN privé commencent toujours par <code>bcr</code> (routeur dorsal) et les routeurs de VLAN public par <code>fcr</code> (routeur frontal). Le numéro et la combinaison de lettres après ces préfixes doivent correspondre pour pouvoir utiliser ces réseaux locaux virtuels lors de la création d'un cluster.</li>
        </ul></td>
        </tr>
        <tr>
        <td><code>--private-vlan <em>&lt;private_vlan_id&gt;</em></code></td>
        <td><ul><li>Dans le cas de clusters gratuits, vous n'avez pas besoin de définir de réseau local virtuel privé. Votre cluster gratuit est automatiquement connecté à un VLAN privé dont IBM est propriétaire.</li><li>Pour un cluster standard, si vous disposez déjà d'un VLAN privé configuré dans votre compte d'infrastructure IBM Cloud (SoftLayer) pour cet emplacement, entrez l'ID du VLAN privé. Si vous ne disposez pas d'un VLAN public et d'un VLAN privé dans votre compte, ne spécifiez pas cette option. {{site.data.keyword.containershort_notm}} crée automatiquement un VLAN public pour vous.<br/><br/><strong>Remarque</strong> : les routeurs de VLAN privé commencent toujours par <code>bcr</code> (routeur dorsal) et les routeurs de VLAN public par <code>fcr</code> (routeur frontal). Le numéro et la combinaison de lettres après ces préfixes doivent correspondre pour pouvoir utiliser ces réseaux locaux virtuels lors de la création d'un cluster.</li></ul></td>
        </tr>
        <tr>
        <td><code>--name <em>&lt;name&gt;</em></code></td>
        <td>Remplacez <em>&lt;name&gt;</em> par le nom de votre cluster.</td>
        </tr>
        <tr>
        <td><code>--workers <em>&lt;number&gt;</em></code></td>
        <td>Nombre de noeuds d'agent à inclure dans le cluster. Si l'option <code>--workers</code> n'est pas spécifiée, 1 noeud worker est créé.</td>
        </tr>
        <tr>
          <td><code>--kube-version <em>&lt;major.minor.patch&gt;</em></code></td>
          <td>Version Kubernetes du noeud maître du cluster. Cette valeur est facultative. Sans spécification, le cluster est créé avec les versions Kubernetes prises en charge par défaut. Pour connaître les versions disponibles, exécutez la commande <code>bx cs kube-versions</code>.</td>
        </tr>
        <tr>
        <td><code>--disable-disk-encrypt</code></td>
        <td>Les noeuds Worker exploitent par défaut le chiffrement de disque ; [En savoir plus](cs_secure.html#encrypted_disks). Incluez cette option si vous désirez désactiver le chiffrement.</td>
        </tr>
        </tbody></table>

7.  Vérifiez que la création du cluster a été demandée.

    ```
    bx cs clusters
    ```
    {: pre}

    **Remarque :** la réservation des postes de noeud worker et la mise en place et la mise à disposition du cluster dans votre compte peuvent prendre jusqu'à 15 minutes.

    Lorsque la mise à disposition de votre cluster est finalisée, le statut du cluster passe à **deployed**.

    ```
    Name         ID                                   State      Created          Workers
    my_cluster   paf97e8843e29941b49c598f516de72101   deployed   20170201162433   1
    ```
    {: screen}

8.  Vérifiez le statut des noeuds d'agent.

    ```
    bx cs workers <cluster>
    ```
    {: pre}

    Lorsque les noeuds d'agent sont prêts, l'état passe à **normal** et le statut indique **Ready**. Lorsque le statut du noeud indique **Ready**, vous pouvez accéder au cluster.

    **Remarque :** A chaque noeud worker sont affectés un ID de noeud worker unique et un nom de domaine qui ne doivent pas être modifiés manuellement après la création du cluster. La modification de l'ID ou du domaine empêcherait le maître
Kubernetes de gérer votre cluster.

    ```
    ID                                                  Public IP        Private IP     Machine Type   State      Status
    prod-dal10-pa8dfcc5223804439c87489886dbbc9c07-w1   169.47.223.113   10.171.42.93   free           normal    Ready
    ```
    {: screen}

9. Définissez le cluster que vous avez créé comme contexte de cette session. Effectuez ces étapes de configuration à chaque fois que vous utilisez votre cluster.
    1.  Obtenez la commande permettant de définir la variable d'environnement et téléchargez les fichiers de configuration Kubernetes.

        ```
        bx cs cluster-config <cluster_name_or_id>
        ```
        {: pre}

        Une fois les fichiers de configuration téléchargés, une commande s'affiche ; elle vous
permet de définir le chemin vers le fichier de configuration Kubernetes local en tant que
variable d'environnement.

        Exemple pour OS X :

        ```
        export KUBECONFIG=/Users/<user_name>/.bluemix/plugins/container-service/clusters/<cluster_name>/kube-config-prod-dal10-<cluster_name>.yml
        ```
        {: screen}

    2.  Copiez et collez la commande qui s'affiche sur votre terminal pour définir la variable d'environnement `KUBECONFIG`.
    3.  Vérifiez que la variable d'environnement `KUBECONFIG` est correctement définie.

        Exemple pour OS X :

        ```
        echo $KUBECONFIG
        ```
        {: pre}

        Sortie :

        ```
        /Users/<user_name>/.bluemix/plugins/container-service/clusters/<cluster_name>/kube-config-prod-dal10-<cluster_name>.yml

        ```
        {: screen}

10. Lancez le tableau de bord Kubernetes via le port par défaut `8001`.
    1.  Affectez le numéro de port par défaut au proxy.

        ```
        kubectl proxy
        ```
        {: pre}

        ```
        Starting to serve on 127.0.0.1:8001
        ```
        {: screen}

    2.  Ouvrez l'URL suivante dans un navigateur Web pour accéder au tableau de bord Kubernetes.

        ```
        http://localhost:8001/ui
        ```
        {: codeblock}


**Etape suivante ?**

-   [Déployer une application dans votre cluster.](cs_app.html#app_cli)
-   [Gérez votre cluster à l'aide de la ligne de commande `kubectl`. ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/user-guide/kubectl/)
-   [Configurer votre propre registre privé dans {{site.data.keyword.Bluemix_notm}} pour stocker et partager des images Docker avec d'autres utilisateurs.](/docs/services/Registry/index.html)
- Si vous utilisez un pare-feu, vous devrez peut-être [ouvrir les ports requis](cs_firewall.html#firewall) afin d'utiliser les commandes `bx`, `kubectl` ou `calicotl`, autoriser le trafic sortant de votre cluster ou le trafic entrant pour les services réseau.

<br />


## Etats de cluster
{: #states}

Vous pouvez vérifier l'état actuel du cluster en exécutant la commande `bx cs clusters` et en accédant à la zone **State**. L'état du cluster vous donne des informations sur la disponibilité et de la capacité du cluster, et sur les problèmes qui se sont éventuellement produits.
{:shortdesc}

|Etat du cluster|Cause|
|-------------|------|

|Critique| Le maître Kubernetes est inaccessible ou tous les noeuds worker du cluster sont arrêtés. <ol><li>Affichez la liste des noeuds d'agent présents dans votre cluster.<pre class="pre"><code>bx cs workers &lt;cluster_name_or_id&gt;</code></pre><li>Affichez les détails relatifs à chaque noeud worker.<pre class="pre"><code>bx cs worker-get &lt;worker_id&gt;</code></pre></li><li>Passez en revue les zones <strong>State</strong> (Etat) et <strong>Status</strong> (Statut) pour identifier la cause principale de la panne du noeud worker.<ul><li>Si l'état du noeud worker est <strong>Provision_failed</strong>, vous ne disposez peut-être pas des droits nécessaires pour mettre à disposition un noeud worker à partir du portefeuille d'infrastructure IBM Cloud (SoftLayer). Pour identifier les droits nécessaires, voir [Configuration de l'accès au portefeuille d'infrastucture IBM Cloud (SoftLayer) pour créer des clusters Kubernetes standard](cs_infrastructure.html#unify_accounts).</li><li>Si l'état du noeud worker indique <strong>Critical</strong> (Critique) et son statut <strong>Not Ready</strong> (Non prêt), il se peut que votre noeud worker ne parvienne pas à se connecter à l'infrastructure IBM Cloud(SoftLayer). Lancez l'identification et la résolution des problèmes en exécutant d'abord la commande <code>bx cs worker-reboot --hard CLUSTER WORKER</code>. Si cette commande n'aboutit pas, exécutez la commande <code>bx cs worker reload CLUSTER WORKER</code>.</li><li>Si l'état du noeud worker indique <strong>Critical</strong> (Critique) et son statut <strong>Out of disk
</strong> (Disque saturé), ceci indique que votre noeud a épuisé sa capacité. Vous pouvez réduire la charge de travail sur votre noeud worker ou ajouter un noeud worker à votre cluster pour contribuer à l'équilibrage de la charge de travail.</li><li>Si l'état du noeud worker indique <strong>Critical</strong> (Critique) et son statut <strong>Unknown</strong> (Inconnu), le maître Kubernetes n'est pas disponible. Contactez le support {{site.data.keyword.Bluemix_notm}} en ouvrant un [ticket de demande de service {{site.data.keyword.Bluemix_notm}}](/docs/get-support/howtogetsupport.html#using-avatar).</li></ul></li></ol>|

|En cours de déploiement| Le déploiement du maître Kubernetes n'est pas terminé. Vous ne pouvez pas encore accéder à votre cluster.|
|Normal| All Tous les noeuds worker du cluster sont opérationnels. Vous pouvez accéder au cluster et y déployer des applications.|
|En attente| Le maître Kubernetes a été déployé. La mise à disposition des noeuds d'agent est en cours. Ces derniers ne sont pas encore disponibles dans le cluster. Vous pouvez accéder au cluster, mais ne pouvez pas encore y déployer des applications.|

|Avertissement| Au moins un noeud worker du cluster n'est pas accessible, mais d'autres sont disponibles et peuvent assumer la charge de travail. <ol><li>Répertoriez les noeuds d'agent présents dans votre cluster et notez l'ID des noeuds d'agent dont l'état indique <strong>Warning</strong>.<pre class="pre"><code>bx cs workers &lt;cluster_name_or_id&gt;</code></pre><li>Affichez les détails relatifs à votre noeud worker.<pre class="pre"><code>bx cs worker-get &lt;worker_id&gt;</code></pre><li>Passez en revue les champs <strong>State</strong>, <strong>Status</strong> et <strong>Details</strong> pour identifier la principale cause de l'arrêt du noeud worker.</li><li>Si votre noeud worker a pratiquement atteint sa limite en termes de mémoire ou d'espace disque, réduisez la charge de travail sur votre noeud worker ou ajoutez un noeud worker à votre cluster pour contribuer à l'équilibrage de la charge de travail.</li></ol>|

{: caption="Table. Etats de cluster" caption-side="top"}

<br />


## Suppression de clusters
{: #remove}

Lorsque vous avez fini d'utiliser un cluster, vous pouvez le supprimer afin qu'il ne consomme plus de ressources.
{:shortdesc}

Les clusters gratuits et standards créés avec un compte de type Paiement à la carte doivent être supprimés manuellement par l'utilisateur lorsque vous n'en avez plus besoin.

Lorsque vous supprimez un cluster, vous supprimez également les ressources sur le cluster, notamment les conteneurs, les pods, les services liés et les valeurs confidentielles. ISi vous ne supprimez pas l'espace de stockage lorsque vous supprimez votre cluster, vous pouvez le supprimer via le tableau de bord d'infrastructure IBM Cloud (SoftLayer) l'interface graphique {{site.data.keyword.Bluemix_notm}}. En raison du cycle de facturation mensuel, une réservation de volume persistant ne peut pas être supprimée le dernier jour du mois. Si vous supprimez la réservation de volume persistant le dernier jour du mois, la suppression reste en attente jusqu'au début du mois suivant.

**Avertissement :** aucune sauvegarde de votre cluster ou de vos données n'est effectuée dans votre stockage persistant. La suppression d'un cluster est définitive et irréversible.

-   Dans l'interface graphique {{site.data.keyword.Bluemix_notm}}
    1.  Sélectionnez votre cluster et cliquez sur **Supprimer** dans le menu **Plus d'actions...**.
-   Depuis l'interface CLI de {{site.data.keyword.Bluemix_notm}}
    1.  Répertoriez les clusters disponibles.

        ```
        bx cs clusters
        ```
        {: pre}

    2.  Supprimez le cluster.

        ```
        bx cs cluster-rm my_cluster
        ```
        {: pre}

    3.  Suivez les invites et indiquez si vous souhaitez supprimer les ressources de cluster.

Lorsque vous supprimez un cluster, vous pouvez supprimer les sous-réseaux portables et le stockage persistant associés au cluster :
- Les sous-réseaux sont utilisés pour affecter des adresses IP portables publiques aux services d'équilibreur de charge ou à votre équilibreur de charge d'application Ingress. Si vous les conservez, vous pouvez les réutiliser dans un nouveau cluster ou les supprimer manuellement ultérieurement de votre portefeuille d'infrastructure IBM Cloud (SoftLayer).
- Si vous avez créé une réservation de volume persistant via un [partage de fichiers existant](cs_storage.html#existing), vous ne pouvez pas supprimer ce dernier lorsque vous supprimez le cluster. Vous devez ultérieurement supprimer ce partage de fichiers manuellement de votre portefeuille d'infrastructure IBM Cloud (SoftLayer).
- Un stockage persistant procure une haute disponibilité à vos données. Si vous le supprimez, vous ne pouvez pas récupérer vos données.
