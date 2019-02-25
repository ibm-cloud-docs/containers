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
{:download: .download}
{:faq: data-hd-content-type='faq'}

# Foire aux questions
{: #faqs}

## Qu'est-ce que Kubernetes ?
{: #kubernetes}
{: faq}

Kubernetes est une plateforme open source utilisée pour gérer des charges de travail et des services conteneurisés sur plusieurs hôtes et offrir des outils de gestion pour déployer, automatiser, surveiller et mettre à l'échelle de applications conteneurisées avec une intervention manuelle minimale voire nulle. Tous les conteneurs constituant votre microservice sont regroupés dans des pods. Les pods sont des unités logiques facilitant les opérations de gestion et de reconnaissance. Ces pods s'exécutent sur des hôtes de calcul gérés dans un cluster Kubernetes portable, extensible et à réparation spontanée en cas de défaillance. 
{: shortdesc}

Pour plus d'informations sur Kubernetes, voir la [documentation Kubernetes ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/home/?path=users&persona=app-developer&level=foundational). 

## Comment fonctionne IBM Cloud Kubernetes Service ?
{: #kubernetes_service}
{: faq}

Avec {{site.data.keyword.containerlong_notm}}, vous pouvez créer votre propre cluster Kubernetes pour déployer et gérer des applications conteneurisées sur {{site.data.keyword.Bluemix_notm}}. Vos applications conteneurisées sont hébergées sur des hôtes de calcul de l'infrastructure IBM Cloud (SoftLayer) nommés noeuds worker. Vous pouvez opter pour la mise à disposition de vos hôtes de calcul sous forme de [machines virtuelles](cs_clusters_planning.html#vm) avec des ressources partagées ou dédiées, ou sous forme de [machines bare metal](cs_clusters_planning.html#bm) pouvant être optimisées pour l'utilisation de processeur graphique et de SDS (Software-Defined Storage). Vos noeuds worker sont contrôlés par un maître Kubernetes à haute disponibilité configuré, surveillé et géré par IBM. Vous pouvez utiliser l'API ou l'interface de ligne de commande (CLI) d'{{site.data.keyword.containerlong_notm}} pour travailler avec les ressources d'infrastructure de votre cluster et utiliser l'API ou l'interface CLI de Kubernetes pour gérer vos services et vos déploiements. 

Pour plus d'informatoins sur la configuration des ressources de votre cluster, voir [Architecture de service](cs_tech.html#architecture). Pour obtenir une liste des capacités et des avantages, voir [Pourquoi {{site.data.keyword.containerlong_notm}} ?](cs_why.html#cs_ov).

## Pourquoi dois-je utiliser IBM Cloud Kubernetes Service ?
{: #benefits}
{: faq}

{{site.data.keyword.containerlong_notm}} est une offre Kubernetes gérée qui fournit des outils puissants, une expérience utilisateur intuitive et une sécurité intégrée pour distribuer rapidement des applications que vous pouvez associer à des services de cloud liés à IBM Watson, IA, IoT, DevOps, ainsi qu'à la sécurité et à l'analyse des données. En tant que fournisseur Kubernetes agréé, {{site.data.keyword.containerlong_notm}} fournit une planification intelligente, des fonctions de réparation spontanée, la mise à l'échelle horizontale, la reconnaissance de service et l'équilibrage de charge, des déploiements et rétromigrations automatiques, ainsi que la gestion des configurations et des valeurs confidentielles (secrets). Le service dispose également de fonctions avancées pour simplifier la gestion d'un cluster, la sécurité des conteneurs et les règles d'isolement, la possibilité de concevoir votre propre cluster et des outils opérationnels intégrés pour garantir une certaine cohérence dans les déploiements.

Pour obtenir une présentation détaillée des capacités et des avantages, voir [Pourquoi {{site.data.keyword.containerlong_notm}}](cs_why.html#cs_ov) ? 

## Le service est-il fourni avec un maître et des noeuds Kubernetes gérés ?
{: #managed_master_worker}
{: faq}

Tous les clusters Kubernetes dans {{site.data.keyword.containerlong_notm}} sont contrôlés par un maître Kubernetes dédié géré par IBM dans un compte d'infrastructure {{site.data.keyword.Bluemix_notm}} appartenant à IBM. Le maître Kubernetes, y compris tous les composants du maître, les opérations de calcul, les réseaux et les ressources de stockage, sont surveillés en permanence par des ingénieurs IBM SRE (Site Reliability Engineers). Ces ingénieurs appliquent les dernières normes en matière de sécurité, détectent et éliminent les activités malveillantes et travaillent pour assurer la fiabilité et la disponibilité d'{{site.data.keyword.containerlong_notm}}. Des modules complémentaires, tels que Fluentd pour la consignation, qui sont installés automatiquement lorsque vous mettez à disposition le cluster sont automatiquement mis à jour par IBM. Cependant, vous pouvez envisager de désactiver ces mises à jour automatiques pour certains modules complémentaires et les mettre à jour manuellement indépendamment du maître et des noeuds worker. Pour plus d'informations, voir [Mise à jour de modules complémentaires de cluster](cs_cluster_update.html#addons). 

Régulièrement, Kubernetes publie des [mises à jour principales, secondaires ou des correctifs](cs_versions.html#version_types). Ces mises à jour peuvent affecter la version du serveur d'API Kubernetes ou d'autres composants dans le maître Kubernetes. IBM met à jour automatiquement la version de correctif, mais vous devez mettre à jour les versions principales et secondaires. Pour plus d'informations, voir [Mise à jour du maître Kubernetes](cs_cluster_update.html#master). 

Les noeuds worker dans les clusters standard sont provisionnés dans votre compte d'infrastructure {{site.data.keyword.Bluemix_notm}}. Les noeuds worker sont dédiés à votre compte et il vous incombe de demander des mises à jour de ces noeuds worker fréquemment pour vous assurer que le système d'exploitation des noeuds worker et les composants {{site.data.keyword.containerlong_notm}} appliquent les mises à jour et les correctifs de sécurité les plus récents. Des mises à jour de sécurité et des correctifs sont mis à disposition par les ingénieurs IBM SRE (Site Reliability Engineers) qui surveillent en permanence l'image Linux installée sur vos noeuds worker pour détecter les vulnérabilités et les problèmes de conformité en matière de sécurité. Pour plus d'informations, voir [Mise à jour des noeuds worker](cs_cluster_update.html#worker_node). 

## Le maître et les noeuds worker Kubernetes sont-ils à haute disponibilité ?
{: #ha}
{: faq}

L'architecture et l'infrastructure d'{{site.data.keyword.containerlong_notm}} est conçue pour assurer la fiabilité, réduire les temps d'attente de traitement et favoriser la disponibilité maximale du service. Par défaut, tous les clusters dans {{site.data.keyword.containerlong_notm}} exécutant Kubernetes version 1.10 ou supérieure sont configurés avec plusieurs instances du maître Kubernetes pour assurer la disponibilité et l'accessibilité de vos ressources de cluster, même si une ou plusieurs instances de votre maître Kubernetes sont indisponibles. 

Vous pouvez accentuer la haute disponibilité de votre cluster et protéger votre application des interruptions en répartissant vos charges de travail sur plusieurs noeuds worker dans plusieurs zones d'une région. C'est ce que l'on appelle une configuration de [cluster à zones multiples](cs_clusters_planning.html#multizone) qui garantit que votre application est accessible, même en cas d'indisponibilité d'un noeud worker ou d'une zone complète. 

Pour vous protéger en cas de défaillance complète d'une région, créez [plusieurs clusters et répartissez-les dans des régions {{site.data.keyword.containerlong_notm}}](cs_clusters_planning.html#multiple_clusters). En configurant un équilibreur de charge pour vos clusters, vous pouvez obtenir un équilibrage de charge interrégional et une mise en réseau interrégionale de vos clusters. 

Si vous avez des données qui doivent être disponibles, même en cas de panne, veillez à stocker vos données dans un [stockage persistant](cs_storage_planning.html#storage_planning). 

Pour plus d'informations sur les moyens d'obtenir la haute disponibilité pour votre cluster, voir [Haute disponibilité pour {{site.data.keyword.containerlong_notm}}](cs_ha.html#ha). 

## Quelles sont les options à ma disposition pour sécuriser mon cluster ?
{: #secure_cluster}
{: faq}

Vous pouvez utiliser des fonctions de sécurité intégrées dans {{site.data.keyword.containerlong_notm}} pour protéger les composants dans votre cluster, vos données et les déploiements d'application afin d'assurer la conformité en matière de sécurité et l'intégrité des données. Utilisez ces fonctions pour sécuriser votre serveur d'API Kubernetes, le magasin de données etcd, les noeuds worker, les réseaux, le stockage, les images et les déploiements contre les attaques malveillantes. Vous pouvez également tirer parti des outils de consignation et de surveillance pour détecter les attaques malveillantes et les signes d'utilisation suspecte. 

Pour plus d'informations sur les composants de votre cluster et savoir comment sécuriser chaque composant, voir [Sécurité d'{{site.data.keyword.containerlong_notm}}](cs_secure.html#security). 

## Est-ce que le service propose la prise en charge des processeurs graphiques (GPU) et de la technologie bare metal ? 
{: #bare_metal_gpu}
{: faq}

Oui, vous pouvez mettre à disposition votre noeud worker sous forme de serveur bare metal physique à service exclusif. Les serveurs bare metal offrent des avantages en termes de hautes performances pour les charges de travail, telles que les données, l'intelligence artificielle ou les processeurs graphiques (GPU). De plus, toutes les ressources matérielles sont dédiées à vos charges de travail, vous n'avez donc pas à vous soucier des "voisins bruyants".

Pour plus d'informations sur les versions bare metal disponibles et les différences entre les machines bare metal et les machines virtuelles, voir [Machines physiques (bare metal)](cs_clusters_planning.html#bm).

## Quelles sont les versions de Kubernetes prises en charge par le service ? 
{: #supported_kube_versions}
{: faq}

{{site.data.keyword.containerlong_notm}} prend en charge plusieurs versions de Kubernetes simultanément. Lorsque la version la plus récente (n) est publiée, jusqu'à 2 versions antérieures (n-2) sont prises en charge. Les versions au-delà de deux versions avant la version la plus récente (n-3) sont d'abord dépréciées, puis finissent par ne plus être prises en charge. Les versions suivantes sont prises en charge actuellement : 

- La plus récente : 1.12.3
- Par défaut : 1.10.11
- Autre : 1.11.5

Pour plus d'informations sur les versions prises en charge et les actions de mise à jour que vous devez entreprendre pour passer d'une version à une autre, voir [Informations de version et actions de mise à jour](cs_versions.html#cs_versions).

## Où est disponible ce service ?
{: #supported_regions}
{: faq}

{{site.data.keyword.containerlong_notm}} est disponible dans le monde entier. Vous pouvez créer des clusters standard dans toutes les régions {{site.data.keyword.containerlong_notm}} prises en charge. Les clusters gratuits ne sont disponibles que dans certaines régions.

Pour plus d'informations sur les régions prises en charge, voir [Régions et zones](cs_regions.html#regions-and-zones).

## Quelles sont les normes auxquelles le service est conforme ? 
{: #standards}
{: faq}

{{site.data.keyword.containerlong_notm}} implémente des contrôles de conformité aux normes suivantes : 
- HIPAA
- SOC1
- SOC2 Type 1
- ISAE 3402
- ISO 27001
- ISO 27017
- ISO 27018

## Puis-je utiliser IBM Cloud et d'autres services avec mon cluster ?
{: #integrations}
{: faq}

Vous pouvez ajouter des services d'infrastructure et de plateforme {{site.data.keyword.Bluemix_notm}}, ainsi que des services de fournisseurs tiers à votre cluster {{site.data.keyword.containerlong_notm}} pour activer l'automatisation, renforcer la sécurité ou améliorer vos fonctions de surveillance et de consignation dans le cluster.

Pour obtenir la liste des services pris en charge, voir [Intégration de services](cs_integrations.html#integrations).

## Puis-je connecter mon cluster dans IBM Cloud Public à des applications qui s'exécutent dans mon centre de données local ?
{: #hybrid}
{: faq}

Vous pouvez connecter des services dans {{site.data.keyword.Bluemix_notm}} Public à votre centre de données local pour créer votre propre configuration de cloud hybride. Exemples pour savoir comment vous pouvez tirer parti d'{{site.data.keyword.Bluemix_notm}} Public et Private avec des applications qui s'exécutent dans votre centre de données local : 
- Vous créez un cluster avec {{site.data.keyword.containerlong_notm}} dans {{site.data.keyword.Bluemix_notm}} Public ou Dedicated, mais vous souhaitez connecter votre cluster à une base de données locale.
- Vous créez un cluster Kubernetes dans {{site.data.keyword.Bluemix_notm}} Private au sein de votre propre centre de données et vous déployez des applications sur votre cluster. Toutefois, votre application peut utiliser un service {{site.data.keyword.ibmwatson_notm}}, tel que Tone Analyzer, dans {{site.data.keyword.Bluemix_notm}} Public.

Pour permettre la communication entre des services qui s'exécutent dans {{site.data.keyword.Bluemix_notm}} Public ou Dedicated et des services qui s'exécutent en local, vous devez [configurer une connexion VPN](cs_vpn.html#vpn). Pour connecter votre environnement {{site.data.keyword.Bluemix_notm}} Public ou Dedicated à un environnement {{site.data.keyword.Bluemix_notm}} Private, voir [Utilisation d'{{site.data.keyword.containerlong_notm}} avec {{site.data.keyword.Bluemix_notm}} Private](cs_hybrid.html#hybrid_iks_icp).

Pour obtenir une présentation des offres {{site.data.keyword.containerlong_notm}} prises en charge, voir [Comparaison d'offres et de leurs combinaisons](cs_why.html#differentiation).

## Puis-je déployer IBM Cloud Kubernetes Service dans mon propre centre de données ?
{: #private}
{: faq}

Si vous n'envisagez pas de déplacer vos applications dans {{site.data.keyword.Bluemix_notm}} Public ou Dedicated, mais que vous souhaitez toujours tirer parti des fonctions d'{{site.data.keyword.containerlong_notm}}, vous pouvez installer {{site.data.keyword.Bluemix_notm}} Private. {{site.data.keyword.Bluemix_notm}} Private est une plateforme d'application pouvant être installée en local sur vos propres machines et que vous pouvez utiliser pour développer et gérer des applications conteneurisées sur site dans votre propre environnement contrôlé derrière un pare-feu. 

Pour plus d'informations, voir la [documentation du produit {{site.data.keyword.Bluemix_notm}} Private ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_1.2.0/kc_welcome_containers.html). 

## Comment suis-je facturé lorsque j'utilise IBM Cloud Kubernetes Service ?
{: #charges}
{: faq}

Avec les clusters {{site.data.keyword.containerlong_notm}}, vous pouvez utiliser les ressources de calcul, de réseau et de stockage de l'infrastructure IBM Cloud (SoftLayer) avec des services de plateforme, tels que Watson AI ou la base de données DaaS (Database-as-a-Service) Compose. Chaque ressource peut induire ses propres frais pouvant être [fixes, mesurés, étalés sur plusieurs niveaux ou réservés](/docs/billing-usage/how_charged.html#charges). 
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
  <li><strong>Plusieurs tranches horaires par mois</strong> : la facturation à l'heure est à plusieurs niveaux. Lorsque votre machine virtuelle est commandée pour un certain nombre d'heures par mois, le coût horaire qui vous est facturé diminue. Les tranches horaires s'articulent comme suit : 0 à 150 heures, 151 à 290 heures, 291 à 540 heures et 541 heures et plus.</li></ul>
  <p><strong>Les machines physiques (bare metal)</strong> offrent des avantages en termes de hautes performances pour les charges de travail, telles que les données, l'intelligence artificielle et les processeurs graphiques (GPU). De plus, toutes les ressources matérielles sont dédiées à vos charges de travail de sorte à éviter les "voisins bruyants". Tenez compte des facteurs suivants qui ont un impact sur le coût de votre machine bare metal :</p>
  <ul><li><strong>Facturation mensuelle uniquement</strong> : toutes les machines bare metal sont facturées au mois.</li>
  <li><strong>Traitement plus long des commandes</strong> :  comme la commande et l'annulation de serveurs bare metal sont réalisées par un processus manuel via votre compte d'infrastructure IBM Cloud (SoftLayer), l'exécution de ce processus peut prendre plus d'un jour ouvrable.</li></ul>
  <p>Pour obtenir des détails sur les spécifications des machines, voir [Matériel disponible pour les noeuds worker](/docs/containers/cs_clusters_planning.html#shared_dedicated_node).</p></dd>

<dt id="bandwidth">Bande passante publique</dt>
  <dd><p>La bande passante désigne le transfert de données publiques du trafic réseau entrant et sortant, à destination et en provenance de ressources {{site.data.keyword.Bluemix_notm}} dans des centres de données situés dans le monde entier. La bande passante publique est facturée par Go. Vous pouvez consulter le récapitulatif de votre bande passante en vous connectant à la [console {{site.data.keyword.Bluemix_notm}}](https://console.bluemix.net/). Dans le menu ![Icône de menu](../icons/icon_hamburger.svg "Icône de menu"), sélectionnez **Infrastructure** puis accédez à la page **Réseau > Bande passante > Récapitulatif**.
  <p>Examinez les facteurs suivants qui ont une incidence sur les frais liés à la bande passante publique :</p>
  <ul><li><strong>Emplacement</strong> : comme pour les noeuds worker, les frais varient en fonction de la zone dans laquelle sont déployées vos ressources.</li>
  <li><strong>Bande passante incluse ou Paiement à la carte</strong> : les machines de vos noeuds worker peuvent être fournies avec une allocation de réseau sortant par mois, par exemple 250 Go pour les machines virtuelles ou 500 Go pour les machines bare metal. Ou bien, l'allocation peut être de type Paiement à la carte en fonction du nombre de Go utilisés.</li>
  <li><strong>Packages à plusieurs niveaux</strong> : lorsque vous avez consommé la bande passante incluse, vous êtes facturé en fonction d'un schéma comportant plusieurs niveaux d'utilisation qui varie selon l'emplacement. Si vous dépassez l'allocation correspondant à un niveau, des frais de transfert de données standard peuvent vous être facturés.</li></ul>
  <p>Pour plus d'informations, voir la page [Bandwidth Packages![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://www.ibm.com/cloud/bandwidth).</p></dd>

<dt id="subnets">Adresses IP de sous-réseau</dt>
  <dd><p>Lorsque vous créez un cluster standard, un sous-réseau portable public avec 8 adresses IP publiques est commandé et facturé sur votre compte tous les mois.</p><p>Si votre compte d'infrastructure comporte déjà des sous-réseaux disponibles, vous pouvez utiliser ces sous-réseaux à la place. Créez le cluster avec l'[indicateur](cs_cli_reference.html#cs_cluster_create) `--no-subnets`, puis [réutilisez vos sous-réseaux](cs_subnets.html#custom).</p>
  </dd>

<dt id="storage">Stockage</dt>
  <dd>Lorsque vous mettez du stockage à disposition, vous pouvez choisir le type et la classe de stockage qui conviennent à votre cas d'utilisation. Les frais facturés varient selon le type de stockage, l'emplacement et les spécifications de l'instance de stockage. Certaines solutions de stockage, par exemple le stockage de ficheirs ou le stockage par blocs, vous proposent une sélection de plans horaires ou mensuels. Pour choisir la solution de stockage adaptée, voir [Planification de stockage persistant à haute disponibilité](cs_storage_planning.html#storage_planning). Pour plus d'informations, voir :
  <ul><li>[Tarification de stockage de fichiers NFS![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://www.ibm.com/cloud/file-storage/pricing)</li>
  <li>[Tarification de stockage par blocs![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://www.ibm.com/cloud/block-storage/pricing)</li>
  <li>[Plans de stockage d'objets![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://www.ibm.com/cloud-computing/bluemix/pricing-object-storage#s3api)</li></ul></dd>

<dt id="services">Services {{site.data.keyword.Bluemix_notm}}</dt>
  <dd>Chaque service que vous intégrez avec votre cluster a son propre barème de prix. Consultez la documentation de chaque produit et de l'[estimateur de coût ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://console.bluemix.net/pricing/) pour plus d'informations.</dd>

</dl>

Les ressources mensuelles sont facturées le premier jour du mois pour une utilisation le mois précédent. Si vous commandez une ressource mensuelle au milieu du mois, vous êtes facturé au prorata pour ce mois. Cependant, si vous annulez une ressource mensuelle au milieu du mois, elle vous sera facturée pour le mois complet.
{: note}

## Ma plateforme et mes ressources d'infrastructure sont-elles consolidées dans une seule facture ?
{: #bill}
{: faq}

Lorsque vous utilisez un compte {{site.data.keyword.Bluemix_notm}} facturable, les ressources de l'infrastructure et de la plateforme sont récapitulées dans une facture.
Si vous avez associé votre compte {{site.data.keyword.Bluemix_notm}} et votre compte d'infrastructure IBM Cloud (SoftLayer), vous recevez une [facture consolidée](/docs/customer-portal/linking_accounts.html#unifybillaccounts) pour vos ressources de plateforme et d'infrastructure {{site.data.keyword.Bluemix_notm}}. 

## Puis-je faire une estimation des coûts ?
{: #cost_estimate}
{: faq}

Oui, voir [Estimation de vos coûts](/docs/billing-usage/estimating_costs.html#cost) et l'outil [estimateur de coût ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://console.bluemix.net/pricing/) pour plus d'informations. 

## Puis-je suivre mon utilisation actuelle ? 
{: #usage}
{: faq}

Vous pouvez vérifier votre utilisation actuelle et les totaux mensuels estimés pour vos ressources d'infrastructure et de plateforme {{site.data.keyword.Bluemix_notm}}. Pour plus d'informations, voir [Affichage de votre utilisation](/docs/billing-usage/viewing_usage.html#viewingusage). Pour organiser votre facturation, vous pouvez regrouper vos ressources dans des [groupes de ressources](/docs/resources/bestpractice_rgs.html#bp_resourcegroups). 

