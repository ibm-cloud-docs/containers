---

copyright:
  years: 2014, 2018
lastupdated: "2018-10-25"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}



# Pourquoi utiliser {{site.data.keyword.containerlong_notm}} ?
{: #cs_ov}

{{site.data.keyword.containerlong}} propose des outils puissants en combinant les conteneurs de Docker, la technologie de Kubernetes, une expérience utilisateur intuitive, ainsi qu'une sécurité et un isolement intégrés pour automatiser le déploiement, l'exploitation, la mise à l'échelle et la surveillance d'applications conteneurisées dans un cluster d'hôtes de calcul. Pour obtenir des informations sur la certification, voir [Compliance on the {{site.data.keyword.Bluemix_notm}} [Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://www.ibm.com/cloud/compliance).
{:shortdesc}


## Avantages de l'utilisation du service
{: #benefits}

Les clusters sont déployés sur des hôtes de calcul qui fournissent des capacités Kubernetes natives et des capacités spécifiques à {{site.data.keyword.IBM_notm}}.
{:shortdesc}

|Avantage|Description|
|-------|-----------|
|Clusters Kubernetes à service exclusif avec isolement de l'infrastructure de traitement, de réseau et de stockage|<ul><li>Créez votre propre infrastructure personnalisée afin de répondre aux besoins de votre organisation.</li><li>Allouez à un maître Kubernetes dédié et sécurisé, des noeuds worker, des réseaux virtuels et un espace de stockage en utilisant les ressources fournies par l'infrastructure IBM Cloud (SoftLayer).</li><li>Le maître Kubernetes entièrement géré est constamment surveillé et mis à jour par {{site.data.keyword.IBM_notm}} pour que votre cluster soit toujours disponible.</li><li>Option permettant de mettre à disposition des noeuds worker en tant que serveurs bare metal avec la fonction Calcul sécurisé.</li><li>Stockez les données persistantes, partagez les données entre les pods Kubernetes et restaurez les données en cas de besoin avec le service de volumes intégré et sécurisé.</li><li>Tirez parti de la prise en charge complète de toutes les API Kubernetes natives.</li></ul>|
| Clusters à zones multiples pour une haute disponibilité accrue | <ul><li>Gérez facilement les noeuds worker d'un même type de machine (UC, mémoire, virtuelle ou physique) avec des pools de noeuds worker.</li><li>Protégez-vous en cas de défaillance d'une zone en répartissant les noeuds uniformément entre les différentes zones et en utilisant des déploiements de pod anti-affinité pour vos applications.</li><li>Réduisez les coûts en utilisant des clusters à zones multiples au lieu de dupliquer les ressources dans un cluster distinct.</li><li>Bénéficiez de l'équilibrage de charge automatique entre vos applications avec l'équilibreur de charge pour zones multiples (MZLB) configuré automatiquement pour vous dans chaque zone du cluster.</li></ul>|
|Conformité en matière de sécurité d'image avec Vulnerability Advisor|<ul><li>Configurez votre propre référentiel dans notre registre d'images privé Docker sécurisé où les images sont stockées et partagées par tous les utilisateurs dans l'organisation.</li><li>Tirez parti de l'analyse automatique des images dans votre registre {{site.data.keyword.Bluemix_notm}} privé.</li><li>Examinez les recommandations spécifiques au système d'exploitation utilisé dans l'image afin de corriger les vulnérabilités potentielles.</li></ul>|
|Surveillance en continu de l'état de santé du cluster|<ul><li>Utilisez le tableau de bord du cluster pour déterminer rapidement et gérer l'état de santé de votre cluster, des noeuds worker et des déploiements de conteneurs.</li><li>Accédez à des métriques de consommation détaillées en utilisant {{site.data.keyword.monitoringlong}} et élargissez rapidement votre cluster pour répondre aux charges de travail.</li><li>Examinez les informations de consignation à l'aide d'{{site.data.keyword.loganalysislong}} pour voir les activités détaillées du cluster.</li></ul>|
|Exposition sécurisée des applications au public|<ul><li>Sélectionnez une adresse IP publique, une route fournie par {{site.data.keyword.IBM_notm}} ou votre propre domaine personnalisé pour accéder à des services dans votre cluster depuis Internet.</li></ul>|
|Intégration de services {{site.data.keyword.Bluemix_notm}}|<ul><li>Vous pouvez ajouter des fonctionnalités supplémentaires à votre application via l'intégration de services {{site.data.keyword.Bluemix_notm}}, tels que les API Watson, Blockchain, des services de données ou Internet of Things (IoT).</li></ul>|
{: caption="Avantages d'{{site.data.keyword.containerlong_notm}}" caption-side="top"}

Prêt à démarrer ? Suivez le [tutoriel de création d'un cluster Kubernetes](cs_tutorials.html#cs_cluster_tutorial).

<br />


## Comparaison d'offres et de leurs combinaisons
{: #differentiation}

Vous pouvez exécuter {{site.data.keyword.containerlong_notm}} dans {{site.data.keyword.Bluemix_notm}} Public ou Dedicated, dans {{site.data.keyword.Bluemix_notm}} Private ou dans une configuration hybride.
{:shortdesc}


<table>
<caption>Différences entre les configurations d'{{site.data.keyword.containerlong_notm}}</caption>
<col width="22%">
<col width="78%">
 <thead>
 <th>Configuration d'{{site.data.keyword.containerlong_notm}}</th>
 <th>Description</th>
 </thead>
 <tbody>
 <tr>
 <td>{{site.data.keyword.Bluemix_notm}} Public
 </td>
 <td>Avec {{site.data.keyword.Bluemix_notm}} Public sur du [matériel partagé ou dédié ou sur des machines bare metal](cs_clusters_planning.html#shared_dedicated_node), vous pouvez héberger vos applications dans des clusters sur le cloud à l'aide d'{{site.data.keyword.containerlong_notm}}. Vous pouvez également créer un cluster avec des pools de noeud worker dans plusieurs zones pour une disponibilité accrue de vos applications. {{site.data.keyword.containerlong_notm}} sur {{site.data.keyword.Bluemix_notm}} Public propose des outils puissants en combinant les conteneurs de Docker, la technologie de Kubernetes, une expérience utilisateur intuitive, ainsi qu'une sécurité et un isolement intégrés pour automatiser le déploiement, l'exploitation, la mise à l'échelle et la surveillance d'applications conteneurisées dans un cluster d'hôtes de calcul.<br><br>Pour plus d'informations, voir [Technologie d'{{site.data.keyword.containerlong_notm}}](cs_tech.html).
 </td>
 </tr>
 <tr>
 <td>{{site.data.keyword.Bluemix_notm}} Dedicated
 </td>
 <td>{{site.data.keyword.Bluemix_notm}} Dedicated offre les mêmes fonctions qu'{{site.data.keyword.containerlong_notm}} sur le cloud qu'{{site.data.keyword.Bluemix_notm}} Public. Cependant, avec un compte {{site.data.keyword.Bluemix_notm}} Dedicated, les [ressources physiques disponibles sont dédiées exclusivement à votre cluster](cs_clusters_planning.html#shared_dedicated_node) et ne sont pas partagées par d'autres clients {{site.data.keyword.IBM_notm}}. Vous pouvez opter pour la mise en place d'un environnement {{site.data.keyword.Bluemix_notm}} Dedicated si vous avez besoin d'isoler votre cluster et les autres services {{site.data.keyword.Bluemix_notm}} que vous utilisez.<br><br>Pour plus d'informations, voir [Initiation aux clusters dans {{site.data.keyword.Bluemix_notm}} Dedicated](cs_dedicated.html#dedicated).
 </td>
 </tr>
 <tr>
 <td>{{site.data.keyword.Bluemix_notm}} Private
 </td>
 <td>{{site.data.keyword.Bluemix_notm}} Private est une plateforme applicative pouvant être installée en local sur vos propres machines. Vous pouvez choisir d'utiliser Kubernetes dans {{site.data.keyword.Bluemix_notm}} Private lorsque vous devez développer et gérer des applications conteneurisées sur site dans votre propre environnement contrôlé et protégé derrière un pare-feu. <br><br>Pour plus d'informations, voir la [documentation du produit {{site.data.keyword.Bluemix_notm}} Private ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_1.2.0/kc_welcome_containers.html).
 </td>
 </tr>
 <tr>
 <td>Configuration hybride
 </td>
 <td>Une configuration hybride est l'utilisation combinée de services qui s'exécutent dans l'environnement {{site.data.keyword.Bluemix_notm}} Public ou Dedicated et d'autres services exécutés sur site, par exemple une application dans l'environnement {{site.data.keyword.Bluemix_notm}} Private. Exemples de configuration hybride : <ul><li>Mise à disposition d'un cluster avec {{site.data.keyword.containerlong_notm}} dans l'environnement {{site.data.keyword.Bluemix_notm}} Public, mais en connectant ce cluster à une base de données sur site.</li><li>Mise à disposition d'un cluster avec {{site.data.keyword.containerlong_notm}} dans l'environnement {{site.data.keyword.Bluemix_notm}} Private et déploiement d'une application dans ce cluster. Cependant, cette application peut utiliser un service {{site.data.keyword.ibmwatson}}, tel que {{site.data.keyword.toneanalyzershort}}, dans l'environnement {{site.data.keyword.Bluemix_notm}} Public.</li></ul><br>Pour activer la communication entre les services qui s'exécutent dans {{site.data.keyword.Bluemix_notm}} Public ou Dedicated et les services qui s'exécutent sur site, vous devez [configurer une connexion VPN](cs_vpn.html). Pour plus d'informations, voir [Utilisation d'{{site.data.keyword.containerlong_notm}} avec {{site.data.keyword.Bluemix_notm}} Private](cs_hybrid.html).
 </td>
 </tr>
 </tbody>
</table>

<br />


## Comparaison des clusters gratuits et standard
{: #cluster_types}

Vous pouvez créer un cluster gratuit ou n'importe quel nombre de clusters standard. Faites-vous la main avec les clusters gratuits pour vous familiariser avec diverses fonctionnalités de Kubernetes ou créez des clusters standard pour exploiter toutes les fonctionnalités de Kubernetes pour déployer des applications. Les clusters gratuits sont supprimés automatiquement au bout de 30 jours.
{:shortdesc}

Si vous disposez d'un cluster gratuit et que vous souhaitez effectuer une mise à niveau pour passer à un cluster standard, vous pouvez [créer un cluster standard](cs_clusters.html#clusters_ui). Déployez ensuite les fichiers YAML des ressources Kubernetes que vous avez créées avec votre cluster gratuit sur le cluster standard.

|Caractéristiques|Clusters gratuits|Clusters standard|
|---------------|-------------|-----------------|
|[Mise en réseau au sein d'un cluster](cs_secure.html#network)|<img src="images/confirm.svg" width="32" alt="Fonction disponible" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Fonction disponible" style="width:32px;" />|
|[Accès à des applications réseau publiques par un service NodePort avec une adresse IP non stable](cs_nodeport.html)|<img src="images/confirm.svg" width="32" alt="Fonction disponible" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Fonction disponible" style="width:32px;" />|
|[Gestion de l'accès utilisateur](cs_users.html#access_policies)|<img src="images/confirm.svg" width="32" alt="Fonction disponible" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Fonction disponible" style="width:32px;" />|
|[Accès au service {{site.data.keyword.Bluemix_notm}} à partir du cluster et des applications](cs_integrations.html#adding_cluster)|<img src="images/confirm.svg" width="32" alt="Fonction disponible" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Fonction disponible" style="width:32px;" />|
|[Espace disque sur le noeud worker pour stockage non persistant](cs_storage_planning.html#non_persistent_overview)|<img src="images/confirm.svg" width="32" alt="Fonction disponible" style="width:32px;" />|<img src="images/confirm.svg" width="32" alt="Fonction disponible" style="width:32px;" />|
| [Possibilité de créer un cluster dans toutes les régions {{site.data.keyword.containerlong_notm}}](cs_regions.html) | | <img src="images/confirm.svg" width="32" alt="Fonction disponible" style="width:32px;" /> |
|[Clusters à zones multiples pour une haute disponibilité accrue](cs_clusters_planning.html#multizone) | |<img src="images/confirm.svg" width="32" alt="Fonction disponible" style="width:32px;" />|
|[Stockage de fichiers NFS persistant avec volumes](cs_storage_file.html#file_storage)| |<img src="images/confirm.svg" width="32" alt="Fonction disponible" style="width:32px;" />|
|[Accès à des applications réseau publiques ou privées par un service d'équilibreur de charge avec une adresse IP stable](cs_loadbalancer.html#planning)| |<img src="images/confirm.svg" width="32" alt="Fonction disponible" style="width:32px;" />|
|[Accès à des applications réseau publiques par un service Ingress avec une adresse IP stable et une URL personnalisable](cs_ingress.html#planning)| |<img src="images/confirm.svg" width="32" alt="Fonction disponible" style="width:32px;" />|
|[Adresses IP publiques portables](cs_subnets.html#review_ip)| |<img src="images/confirm.svg" width="32" alt="Fonction disponible" style="width:32px;" />|
|[Consignation et surveillance](cs_health.html#logging)| |<img src="images/confirm.svg" width="32" alt="Fonction disponible" style="width:32px;" />|
|[Option permettant de mettre à disposition vos noeuds worker sur des serveurs physiques (bare metal)](cs_clusters_planning.html#shared_dedicated_node) | |<img src="images/confirm.svg" width="32" alt="Fonction disponible" style="width:32px;" />|
|[Option permettant de mettre à disposition des noeuds worker bare metal avec la fonction de calcul sécurisé](cs_clusters_planning.html#shared_dedicated_node) | |<img src="images/confirm.svg" width="32" alt="Fonction disponible" style="width:32px;" />|
|[Disponible dans {{site.data.keyword.Bluemix_dedicated_notm}}](cs_dedicated.html#dedicated_environment)| |<img src="images/confirm.svg" width="32" alt="Fonction disponible" style="width:32px;" />|
{: caption="Caractéristiques des clusters gratuits et standard" caption-side="top"}

<br />


## Tarification et facturation
{: #pricing}

Examinez certaines questions qui reviennent souvent à propos de la tarification et de la facturation pour {{site.data.keyword.containerlong_notm}}. Pour les questions relatives au compte, voir les [documents de gestion de la facturation et de l'utilisation](/docs/billing-usage/how_charged.html#charges). Pour obtenir des détails sur les contrats liés à votre compte, consultez les [Conditions et remarques {{site.data.keyword.Bluemix_notm}}](/docs/overview/terms-of-use/notices.html#terms).
{: shortdesc}

### Comment visualiser et organiser mon utilisation ?
{: #usage}

**Comment vérifier ma facturation et mon utilisation ?**<br>
Pour vérifier votre utilisation et les totaux estimés, voir [Affichage de votre utilisation](/docs/billing-usage/viewing_usage.html#viewingusage).

Si vous liez votre compte {{site.data.keyword.Bluemix_notm}} à votre compte d'infrastructure IBM Cloud (SoftLayer), vous recevez une facture consolidée. Pour plus d'informations, voir [Facturation en bloc pour des comptes liés](/docs/billing-usage/linking_accounts.html#unifybillaccounts).

**Puis-je regrouper mes ressources de cloud par équipes ou par services pour la facturation ?**<br>
Vous pouvez [utiliser des groupes de ressources](/docs/resources/bestpractice_rgs.html#bp_resourcegroups) afin de classer vos ressources {{site.data.keyword.Bluemix_notm}}, notamment les clusters, par groupes pour organiser la facturation.

### Comment suis-je facturé ? A l'heure ou au mois ?
{: #monthly-charges}

Vos frais dépendent du type de ressource que vous utilisez et peuvent être fixes, limités, répartis sur différents niveaux ou réservés. Pour plus d'informations, voir [comment vous êtes facturé](/docs/billing-usage/how_charged.html#charges).

Les ressources de l'infrastructure IBM Cloud (SoftLayer) peuvent être facturées à l'heure ou au mois dans {{site.data.keyword.containerlong_notm}}.
* Les noeuds worker de machine virtuelle (VM) sont facturés à l'heure.
* Les noeuds worker physiques (bare metal) sont facturés par ressources mensuelles dans {{site.data.keyword.containerlong_notm}}.
* Pour d'autres ressources d'infrastructure, telles que le stockage de fichiers ou le stockage par blocs, vous pourrez choisir entre une facturation à l'heure ou au mois lorsque vous créez la ressource.

Les ressources mensuelles sont facturées le premier jour du mois pour une utilisation le mois précédent. Si vous commandez une ressource mensuelle au milieu du mois, vous êtes facturé au prorata pour ce mois. Cependant, si vous annulez une ressource mensuelle au milieu du mois, elle vous sera facturée pour le mois complet.

### Puis-je faire une estimation des coûts ?
{: #estimate}

Oui, voir [Estimation de vos coûts](/docs/billing-usage/estimating_costs.html#cost) et l'outil d'[estimation des coûts ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://console.bluemix.net/pricing/). Continuez à lire les informations sur les coûts qui ne sont pas comptabilisés par l'outil d'estimation des coûts, par exemple pour le réseau sortant.

### Comment suis-je facturé lorsque j'utilise {{site.data.keyword.containerlong_notm}} ?
{: #cluster-charges}

Avec les clusters {{site.data.keyword.containerlong_notm}}, vous pouvez utiliser les ressources de calcul, de réseau et de stockage de l'infrastructure IBM Cloud (SoftLayer) avec des services de plateforme, tels que Watson AI ou la base de données DaaS (Database-as-a-Service) Compose. Chaque ressource peut inclure ses propres frais.
* [Noeuds worker](#nodes)
* [Réseau sortant](#bandwidth)
* [Adresses IP de sous-réseau](#subnets)
* [Stockage](#storage)
* [Services {{site.data.keyword.Bluemix_notm}}](#services)

<dl>
<dt id="nodes">Noeuds worker</dt>
  <dd><p>Les clusters peuvent comporter deux types de noeud worker principaux : machines virtuelles ou physiques (bare metal). La disponibilité des types de machine et leur facturation varient suivant la zone dans laquelle vous déployez votre cluster.</p>
  <p>Les <strong>machines virtuelles</strong> présentent une plus grande flexibilité, une durée de mise à disposition plus rapide et plus de fonctions de mise à l'échelle automatique qu'une machine bare metal, pour un meilleur rapport qualité-prix. Toutefois, les machines virtuelles offrent un avantage non négligeable en termes de performances par rapport aux spécifications bare metal, par exemple le débit en Gbit/s sur les réseaux, les seuils de mémoire et de RAM et les options de stockage. Tenez compte de ces facteurs qui ont un impact sur le coût de votre machine virtuelle :</p>
  <ul><li><strong>Matériel partagé ou dédié</strong> : si vous partagez le matériel sous-jacent de la machine virtuelle, le coût est inférieur à du matériel dédié, mais les ressources physiques ne sont pas dédiées à votre machine virtuelle.</li>
  <li><strong>Facturation à l'heure uniquement</strong> : la facturation à l'heure offre une plus grande flexibilité pour commander et annuler rapidement des machines virtuelles.
  <li><strong>Plusieurs niveaux d'heures par mois</strong> : la facturation à l'heure est à plusieurs niveaux. Lorsque votre machine virtuelle est commandée pour un certain niveau d'heures au cours d'un mois, le coût horaire qui vous est facturé diminue. Les niveaux d'heures s'articulent comme suit : 0 à 150 heures, 151 à 290 heures, 291 à 540 heures et 541 heures et plus.</li></ul>
  <p><strong>Les machines physiques (bare metal)</strong> offrent des avantages en termes de hautes performances pour les charges de travail, telles que les données, l'intelligence artificielle et les processeurs graphiques (GPU). De plus, toutes les ressources matérielles sont dédiées à vos charges de travail de sorte à éviter les "voisins bruyants". Tenez compte des facteurs suivants qui ont un impact sur le coût de votre machine bare metal :</p>
  <ul><li><strong>Facturation mensuelle uniquement</strong> : toutes les machines bare metal sont facturées au mois.</li>
  <li><strong>Traitement plus long des commandes</strong> :  comme la commande et l'annulation de serveurs bare metal sont réalisées par un processus manuel via votre compte d'infrastructure IBM Cloud (SoftLayer), l'exécution de ce processus peut prendre plus d'un jour ouvrable.</li></ul>
  <p>Pour obtenir des détails sur les spécifications des machines, voir [Matériel disponible pour les noeuds worker](/docs/containers/cs_clusters_planning.html#shared_dedicated_node).</p></dd>

<dt id="bandwidth">Bande passante publique</dt>
  <dd><p>La bande passante désigne le transfert de données publiques du trafic réseau entrant et sortant, à destination et en provenance de ressources {{site.data.keyword.Bluemix_notm}} dans des centres de données situés dans le monde entier. La bande passante publique est facturée par Go. Vous pouvez consulter le récapitulatif de votre bande passante en vous connectant à la [console {{site.data.keyword.Bluemix_notm}}](https://console.bluemix.net/). Dans le menu, sélectionnez **Infrastructure** puis accédez à la page **Réseau > Bande passante > Récapitulatif**.
  <p>Examinez les facteurs suivants qui ont une incidence sur les frais liés à la bande passante publique :</p>
  <ul><li><strong>Emplacement</strong> : comme pour les noeuds worker, les frais varient en fonction de la zone dans laquelle sont déployées vos ressources.</li>
  <li><strong>Bande passante incluse ou Paiement à la carte</strong> : les machines de vos noeuds worker peuvent être fournies avec une allocation de réseau sortant par mois, par exemple 250 Go pour les machines virtuelles ou 500 Go pour les machines bare metal. Ou bien, l'allocation peut être de type Paiement à la carte en fonction du nombre de Go utilisés.</li>
  <li><strong>Packages à plusieurs niveaux</strong> : lorsque vous avez consommé la bande passante incluse, vous êtes facturé en fonction d'un schéma comportant plusieurs niveaux d'utilisation qui varie selon l'emplacement. Si vous dépassez l'allocation correspondant à un niveau, des frais de transfert de données standard peuvent vous être facturés.</li></ul>
  <p>Pour plus d'informations, voir la page [Bandwidth Packages![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://www.ibm.com/cloud/bandwidth).</p></dd>

<dt id="subnets">Adresses IP de sous-réseau</dt>
  <dd><p>Lorsque vous créez un cluster standard, un sous-réseau portable public avec 8 adresses IP publiques est commandé et facturé sur votre compte tous les mois.</p><p>Si votre compte d'infrastructure comporte déjà des sous-réseaux disponibles, vous pouvez utiliser ces sous-réseaux à la place. Créez le cluster avec l'[indicateur](cs_cli_reference.html#cs_cluster_create) `--no-subnets`, puis [réutilisez vos sous-réseaux](cs_subnets.html#custom).</p>
  </dd>

<dt id="storage">Stockage</dt>
  <dd>Lorsque vous mettez du stockage à disposition, vous pouvez choisir le type et la classe de stockage qui conviennent à votre cas d'utilisation. Les frais facturés varient selon le type de stockage, l'emplacement et les spécifications de l'instance de stockage. Pour choisir la solution de stockage adaptée, voir [Planification de stockage persistant à haute disponibilité](cs_storage_planning.html#storage_planning). Pour plus d'informations, voir :
  <ul><li>[Tarification de stockage de fichiers NFS![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://www.ibm.com/cloud/file-storage/pricing)</li>
  <li>[Tarification de stockage par blocs![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://www.ibm.com/cloud/block-storage/pricing)</li>
  <li>[Plans de stockage d'objets![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://www.ibm.com/cloud-computing/bluemix/pricing-object-storage#s3api)</li></ul></dd>

<dt id="services">Services {{site.data.keyword.Bluemix_notm}}</dt>
  <dd>Chaque service que vous intégrez avec votre cluster a son propre barème de prix. Consultez la documentation de chaque produit et de l'[estimateur de coût ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://console.bluemix.net/pricing/) pour plus d'informations.</dd>

</dl>
