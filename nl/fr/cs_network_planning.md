---

copyright:
  years: 2014, 2018
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


# Planification réseau d'un cluster
{: #planning}

Avec {{site.data.keyword.containerlong}}, vous pouvez gérer à la fois la mise en réseau externe en rendant les applications accessibles au public ou en privé et la mise en réseau interne au sein de votre cluster.
{: shortdesc}

## Sélection d'un service NodePort, LoadBalancer ou Ingress
{: #external}

Pour rendre vos applications accessibles de l'extérieur à partir de l'[Internet public](#public_access) ou d'un [réseau privé](#private_both_vlans), {{site.data.keyword.containershort_notm}} prend en charge trois services de mise en réseau.
{:shortdesc}

**[Service NodePort](cs_nodeport.html)** (clusters gratuits et standard)
* Exposez un port sur chaque noeud worker et utilisez l'adresse IP publique ou privée d'un noeud worker pour accéder à votre service dans le cluster.
* Iptables est une fonction du noyau Linux qui charge les demandes d'équilibrage de charge entre les pods de l'application, assure un routage réseau à hautes performances et fournit un contrôle d'accès réseau.
* Les adresses publique et privée du noeud worker ne sont pas permanentes. Lorsqu'un noeud worker est supprimé ou recréé, une nouvelle adresse IP publique et une nouvelle adresse IP privée sont affectées au noeud worker.
* Le service NodePort est idéal pour tester l'accès public ou privé. Il peut également être utilisé si vous avez besoin d'un accès public ou privé sur une courte période.

**[Service LoadBalancer](cs_loadbalancer.html)** (clusters standard uniquement)
* Chaque cluster standard est mis à disposition avec quatre adresses IP publiques portables et quatre adresses IP privées portables que vous pouvez utiliser pour créer un équilibreur de charge TCP/UDP externe pour votre application.
* Iptables est une fonction du noyau Linux qui charge les demandes d'équilibrage de charge entre les pods de l'application, assure un routage réseau à hautes performances et fournit un contrôle d'accès réseau.
* Les adresses IP publiques et privées portables affectées à l'équilibreur de charge sont permanentes et ne changent pas lorsqu'un noeud worker est recréé dans le cluster.
* Vous pouvez personnaliser votre équilibreur de charge en exposant n'importe quel port dont votre application a besoin.

**[Ingress](cs_ingress.html)** (clusters standard uniquement)
* Exposez plusieurs application dans un cluster en créant un équilibreur de charge d'application (ALB) externe HTTP ou HTTPS, TCP ou UDP. L'ALB utilise un point d'entrée public ou privé unique et sécurisé pour acheminer les demandes entrantes vers vos applications.
* Vous pouvez utiliser une seule route pour exposer plusieurs applications dans votre cluster sous forme de services.
* Ingress comporte trois composants :
  * La ressource Ingress définit les règles de routage et d'équilibrage de charge des demandes entrantes pour une application.
  * L'équilibreur de charge d'application (ALB) est à l'écoute des demandes de service HTTP, HTTPS, TCP ou UDP entrantes. Il transmet les demandes aux pods des applications en fonction des règles que vous avez définies dans la ressource Ingress.
  * L'équilibreur de charge pour zones multiples (MZLB) gère toutes les demandes entrantes vers vos applications et équilibre la charge des demandes en les répartissant entre les ALB dans les différentes zones.
* Utilisez Ingress pour implémenter votre propre équilibreur de charge ALB avec des règles de routage personnalisées et si vous avez besoin d'une terminaison SSL pour vos applications.

Pour choisir le meilleur service de mise en réseau pour votre application, vous pouvez suivre cet arbre de décisions et cliquez sur l'une des options pour commencer.

<img usemap="#networking_map" border="0" class="image" src="images/networkingdt.png" width="500px" alt="Cette image vous aide à sélectionner l'option réseau optimale pour votre application. Si l'image ne s'affiche pas, l'information est néanmoins disponible dans la documentation." style="width:500px;" />
<map name="networking_map" id="networking_map">
<area href="/docs/containers/cs_nodeport.html" alt="Service Nodeport" shape="circle" coords="52, 283, 45"/>
<area href="/docs/containers/cs_loadbalancer.html" alt="Service LoadBalancer" shape="circle" coords="247, 419, 44"/>
<area href="/docs/containers/cs_ingress.html" alt="Service Ingress" shape="circle" coords="445, 420, 45"/>
</map>

<br />


## Planification de réseau externe public
{: #public_access}

Lorsque vous créez un cluster Kubernetes dans {{site.data.keyword.containershort_notm}}, vous pouvez connecter le cluster à un VLAN public. Le VLAN public détermine l'adresse IP publique qui est affectée à chaque noeud worker, ce qui offre à chaque noeud worker une interface réseau publique.
{:shortdesc}

Pour rendre une application accessible au public sur Internet, vous pouvez créer un service NodePort, LoadBalancer ou Ingress. Pour comparer chaque service, voir [Sélection d'un service NodePort, LoadBalancer ou Ingress](#external).

Le diagramme suivant illustre comment Kubernetes achemine du trafic réseau public dans {{site.data.keyword.containershort_notm}}. 

![{{site.data.keyword.containershort_notm}} Architecture Kubernetes](images/networking.png)

*Plan de données Kubernetes dans {{site.data.keyword.containershort_notm}}*

L'interface réseau publique des noeuds worker tant dans les clusters gratuits que standard est protégée par les règles réseau Calico. Ces règles bloquent par défaut la plupart du trafic entrant. Le trafic entrant nécessaire au fonctionnement de Kubernetes est toutefois autorisé, comme les connexions aux services NodePort, LoadBalancer et Ingress. Pour plus d'informations sur ces règles, y compris comment les modifier, voir [Règles réseau](cs_network_policy.html#network_policies).

<br />


## Planification de réseau privé pour une configuration de VLAN public et privé
{: #private_both_vlans}

Lorsque vous créez un cluster Kubernetes dans {{site.data.keyword.containershort_notm}}, vous devez connecter votre cluster à un VLAN privé. Le VLAN privé détermine l'adresse IP privée qui est affectée à chaque noeud worker, ce qui offre à chaque noeud worker une interface réseau privée.
{:shortdesc}

Lorsque vous souhaitez que vos applications soient toujours connectées à un réseau privé uniquement, vous pouvez utiliser l'interface réseau privée des noeuds worker dans les clusters standard. Cependant, lorsque vos noeuds worker sont connectés à la fois à un VLAN public et à un VLAN privé, vous devez utiliser des règles réseau Calico pour sécuriser votre cluster pour empêcher tout accès public non désiré.

Les sections suivantes présentent les fonctions d'{{site.data.keyword.containershort_notm}} que vous pouvez utiliser pour exposer vos applications sur un réseau privé et sécuriser votre cluster pour empêcher tout accès public non désiré. Vous pouvez éventuellement isoler vos charges de travail en réseau et connectez votre cluster aux ressources dans un réseau sur site.

### Exposition de vos applications avec des services de mise en réseau privés et sécurisation de votre cluster avec des règles réseau Calico
{: #private_both_vlans_calico}

L'interface réseau publique des noeuds worker est protégée par des [paramètres de règles réseau Calico prédéfinis](cs_network_policy.html#default_policy) qui sont configurés sur tous les noeuds worker lors de la création du cluster. Par défaut, tout le trafic réseau sortant est autorisé pour tous les noeuds worker. Le trafic réseau entrant est bloqué, à l'exception de quelques ports qui sont ouverts pour permettre à IBM de surveiller le trafic réseau et d'installer automatiquement les mises à jour de sécurité pour le maître Kubernetes. L'accès au kubelet du noeud worker est sécurisé par un tunnel OpenVPN. Pour plus d'informations, voir la rubrique [Architecture {{site.data.keyword.containershort_notm}}](cs_tech.html).

Si vous exposez vos applications avec l'équilibreur de charge d'application d'un service NodePort, LoadBalancer ou Ingress, les règles Calico par défaut autorisent également le trafic réseau entrant en provenance d'Internet vers ces services. Pour que votre application ne soit accessible qu'à partir d'un réseau privé, vous pouvez choisir d'utiliser uniquement des services NodePort, LoadBalancer ou Ingress privés et bloquer tout trafic public vers ces services.

**NodePort**
* [Créez un service NodePort](cs_nodeport.html). En plus de l'adresse IP publique, un service NodePort est accessible via l'adresse IP privée d'un noeud worker.
* Un service NodePort ouvre un port sur un noeud worker via à la fois l'adresse IP privée et l'adresse IP publique du noeud worker. Vous devez utiliser une [règle réseau Calico preDNAT](cs_network_policy.html#block_ingress) pour bloquer les ports NodePort publics.

**LoadBalancer**
* [Créez un service LoadBalancer privé](cs_loadbalancer.html).
* Un service d'équilibreur de charge avec une adresse IP privée portable dispose toujours d'un port de noeud public ouvert sur chaque noeud worker. Vous devez utiliser une [règle réseau Calico preDNAT](cs_network_policy.html#block_ingress) pour bloquer les ports de noeud publics figurant dedans.

**Ingress**
* Lorsque vous créez un cluster, deux équilibreurs de charge d'application (ALB), un public et un privé, sont créés automatiquement. Comme l'ALB public est activé et l'ALB privé est désactivé par défaut, vous devez [désactiver l'ALB public](cs_cli_reference.html#cs_alb_configure) et [activer l'ALB privé](cs_ingress.html#private_ingress).
* Ensuite, [créez un service Ingress privé](cs_ingress.html#ingress_expose_private).

Pour plus d'informations sur chaque service, voir [Sélection d'un service NodePort, LoadBalancer ou Ingress](#external).

### Facultatif : Isolement des charges de travail réseau dans les noeuds worker de périphérie
{: #private_both_vlans_edge}

Les noeuds worker de périphérie peuvent améliorer la sécurité de votre cluster en limitant les accès aux noeuds worker depuis l'extérieur et en isolant la charge de travail du réseau. Pour garantir que les pods Ingress et LoadBalancer sont déployés uniquement sur les noeuds worker spécifiés, [labellisez les noeuds worker en noeuds de périphérie](cs_edge.html#edge_nodes). Pour éviter l'exécution d'autres charges de travail sur les noeuds de périphérie, [ajoutez une annotation taint aux noeuds de périphérie](cs_edge.html#edge_workloads).

Utilisez ensuite une [règle réseau Calico preDNAT](cs_network_policy.html#block_ingress) pour bloquer le trafic vers les ports de noeud publics sur les clusters qui exécutent des noeuds worker de périphérie. Le blocage des ports de noeud assure que les noeuds worker de périphérie sont les seuls noeuds worker à traiter le trafic entrant.

### Facultatif : Connexion à une base de données sur site en utilisant un VPN strongSwan
{: #private_both_vlans_vpn}

Pour connecter vos noeuds worker et vos applications de manière sécurisée à un réseau sur site, vous devez configurer un [service VPN IPSec strongSwan ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://www.strongswan.org/about.html). Le service VPN IPSec strongSwan fournit un canal de communication de bout en bout sécurisé sur Internet, basé sur l'ensemble de protocoles IPSec (Internet Protocol Security) aux normes de l'industrie. Pour configurer une connexion sécurisée entre votre cluster et un réseau sur site, [configurez et déployez le service VPN IPSec strongSwan](cs_vpn.html#vpn-setup) directement dans un pod de votre cluster.

<br />


## Planification de réseau externe privé pour une configuration de VLAN privé uniquement
{: #private_vlan}

Lorsque vous créez un cluster Kubernetes dans {{site.data.keyword.containershort_notm}}, vous devez connecter votre cluster à un VLAN privé. Le VLAN privé détermine l'adresse IP privée qui est affectée à chaque noeud worker, ce qui offre à chaque noeud worker une interface réseau privée.
{:shortdesc}

Lorsque vos noeuds worker sont connectés uniquement à un VLAN privé, vous pouvez utiliser l'interface réseau privée des noeuds worker pour que vos applications restent connectées uniquement au réseau privé. Vous pouvez ensuite utiliser un dispositif de passerelle pour sécuriser votre cluster en empêchant tout trafic public non désiré.

Les sections suivantes présentent les fonctions d'{{site.data.keyword.containershort_notm}} que vous pouvez utiliser pour sécuriser votre cluster en empêchant tout accès public non désiré, exposer vos applications sur un réseau privé et vous connecter aux ressources dans un réseau sur site.

### Configuration d'une passerelle réseau
{: #private_vlan_gateway}

Si les noeuds worker sont configurés uniquement avec un VLAN privé, vous devez configurer une autre solution pour la connectivité du réseau. Vous pouvez mettre en place un pare-feu avec des règles réseau personnalisées afin d'assurer une sécurité réseau dédiée pour votre cluster standard et détecter et parer à des intrusions réseau. Par exemple, vous pouvez choisir de configurer un [dispositif de routeur virtuel](/docs/infrastructure/virtual-router-appliance/about.html) ou un [dispositif de sécurité Fortigate](/docs/infrastructure/fortigate-10g/about.html) qui fera office de pare-feu et bloquera le trafic indésirable. Lorsque vous configurez un pare-feu, [vous devez également ouvrir les adresses IP et les ports requis](cs_firewall.html#firewall_outbound) pour chaque région de manière à permettre au maître et aux noeuds worker de communiquer. 

**Remarque** : si vous disposez déjà d'un dispositif de routeur et que vous ajoutez ensuite un cluster, les nouveaux sous-réseaux portables commandés pour le cluster ne sont pas configurés sur ce dispositif. Pour utiliser les services de réseau, vous devez activer le routage entre les sous-réseaux sur le même VLAN en [activant la fonction Spanning VLAN](cs_subnets.html#vra-routing).

### Exposition de vos applications avec des services de réseau privé
{: #private_vlan_services}

Pour que votre application ne soit accessible qu'à partir d'un réseau privé, vous pouvez utiliser des services NodePort, LoadBalancer ou Ingress privés. Comme vos noeuds worker ne sont pas connectés à un VLAN public, aucun trafic public n'est acheminé vers ces services.

**NodePort**:
* [Créez un service NodePort privé](cs_nodeport.html). Le service est disponible via l'adresse IP privée d'un noeud worker.
* Dans votre pare-feu privé, ouvrez le port que vous avez configuré lorsque vous avez déployé le service sur les adresses IP privées pour tous les noeuds worker vers lesquels autoriser le trafic. Pour identifier le port, exécutez la commande `kubectl get svc`. Le port est compris dans une plage de 20000 à 32000.

**LoadBalancer**
* [Créez un service LoadBalancer privé](cs_loadbalancer.html). Si votre cluster est disponible uniquement sur un VLAN privé, l'une des quatre adresses IP privées portables disponibles est utilisée.
* Dans votre pare-feu privé, ouvrez le port que vous avez configuré lorsque vous avez déployé le service en indiquant l'adresse IP privée du service d'équilibreur de charge.

**Ingress**:
* Lorsque vous créez un cluster, un équilibreur de charge d'application (ALB) privé est créé automatiquement mais n'est pas activé par défaut. Vous devez [activer l'ALB privé](cs_ingress.html#private_ingress).
* Ensuite, [créez un service Ingress privé](cs_ingress.html#ingress_expose_private).
* Dans votre pare-feu privé, ouvrez le port 80 pour HTTP ou le port 443 pour HTTPS et indiquez l'adresse IP de votre ALB privé.


Pour plus d'informations sur chaque service, voir [Sélection d'un service NodePort, LoadBalancer ou Ingress](#external).

### Facultatif : Connexion à une base de données sur site à l'aide du dispositif de passerelle.
{: #private_vlan_vpn}

Pour connecter vos noeuds worker et vos applications de manière sécurisée à un réseau sur site, vous devez configurer une passerelle VPN. Vous pouvez utiliser le [dispositif de routeur virtuel (VRA)](/docs/infrastructure/virtual-router-appliance/about.html) ou le [dispositif de sécurité Fortigate (FSA)](/docs/infrastructure/fortigate-10g/about.html) que vous avez défini comme pare-feu pour configurer également un point de terminaison VPN IPSec. Pour configurer un dispositif de routeur virtuel (VRA), voir la rubrique sur la [configuration d'une connectivité VPN avec un dispositif VRA](cs_vpn.html#vyatta).

<br />


## Planification réseau au sein d'un cluster
{: #in-cluster}

Tous les pods qui sont déployés sur un noeud worker bénéficient d'une adresse IP privée dans la plage 172.30.0.0/16 et sont uniquement acheminés entre des noeuds worker. Pour éviter des conflits, n'utilisez pas cette plage d'adresses IP sur des noeuds qui communiquent avec vos noeuds worker. Les noeuds worker et les pods peuvent communiquer de manière sécurisée sur le réseau privé en utilisant des adresses IP privées. Toutefois, lorsqu'un pod tombe en panne ou qu'un noeud worker a besoin d'être recréé, une nouvelle adresse IP privée lui est affectée.

Par défaut, il est difficile de suivre des adresses IP privées fluctuantes pour des applications qui doivent être hautement disponibles. En guise d'alternative, vous pouvez utiliser les fonctions de reconnaissance de service Kubernetes intégrées pour exposer les applications sous forme de services IP de cluster sur le réseau privé. Un service Kubernetes regroupe un ensemble de pods et procure une connexion réseau vers ces pods pour d'autres services dans le cluster sans exposer l'adresse IP privée réelle de chaque pod. Les services bénéficient d'une adresse IP interne au cluster accessible uniquement à l'intérieur du cluster.
* **Clusters plus anciens** : dans les clusters créés avant février 2018 dans la zone dal13 ou avant octobre 2017 dans les autres zones, les services bénéficient d'une adresse IP parmi les 254 adresses IP dans la plage 10.10.10.0/24. Si vous atteignez la limite de 254 services et que vous avez besoin d'autres services, vous devez créer un nouveau cluster.
* **Clusters plus récents** : dans les clusters créés après février 2018 dans la zone dal13 ou après octobre 2017 dans les autres zones, les services bénéficient d'une adresse IP parmi les 65 000 adresses IP dans la plage 172.21.0.0/16.

Pour éviter des conflits, n'utilisez pas cette plage d'adresses IP sur des noeuds qui communiquent avec vos noeuds worker. Une entrée de recherche DNS est également créée pour le service et stockée dans le composant `kube-dns` du cluster. L'entrée DNS contient le nom du service, l'espace de nom dans lequel il a été créé et le lien vers l'adresse IP interne au cluster.

Pour accéder à un pod situé derrière un service IP de cluster, les applications peuvent utiliser l'adresse IP interne au cluster du service ou envoyer une demande en utilisant le nom du service. Lorsque vous utilisez le nom du service, ce nom est recherché dans le composant `kube-dns` et la demande est acheminée à l'adresse IP interne au cluster du service. Lorsqu'une demande parvient au service, celui-ci se charge d'envoyer équitablement toutes les demandes aux pods, indépendamment de leurs adresses IP internes au cluster et du noeud worker sur lequel ils sont déployés.
