---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

keywords: kubernetes, iks, lb2.0, nlb

subcollection: containers

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
{:download: .download}
{:preview: .preview}



# A propos des équilibreurs de charge de réseau
{: #loadbalancer-about}

Lorsque vous créez un cluster standard, un sous-réseau public portable et un sous-réseau privé portable sont fournis automatiquement par {{site.data.keyword.containerlong}}.
{: shortdesc}

* Le sous-réseau public portable fournit 5 adresses IP utilisables. 1 adresse IP publique portable est utilisée par l'[équilibreur de charge d'application (ALB) Ingress public](/docs/containers?topic=containers-ingress) par défaut. Les 4 autres adresses IP publiques portables peuvent être utilisées pour exposer des applications individuelles sur Internet en créant des services d'équilibreur de charge de réseau (NLB) publics.
* Le sous-réseau privé portable fournit 5 adresses IP utilisables. 1 adresse IP privée portable est utilisée par l'[équilibreur de charge d'application (ALB) Ingress privé](/docs/containers?topic=containers-ingress#private_ingress) par défaut. Les 4 autres adresses IP privées portables peuvent être utilisées pour exposer des applications individuelles sur un réseau privé en créant des services d'équilibreur de charge privés, ou NLB.

Les adresses IP publiques et privées portables sont des adresses IP flottantes statiques et ne changent pas en cas de retrait d'un noeud worker. Si le noeud worker dans lequel figure l'adresse IP de l'équilibreur de charge de réseau est retiré, un démon Keepalived qui surveille en permanence l'adresse IP transfère automatiquement celle-ci sur un autre noeud worker. Vous pouvez affecter n'importe quel port à votre équilibreur de charge de réseau. Le service d'équilibreur de charge de réseau fait office de point d'entrée externe pour les demandes entrantes pour l'application. Pour accéder au NLB depuis Internet, vous pouvez utiliser l'adresse IP publique de votre NLB et le port affecté en utilisant le format `<IP_address>:<port>`. Vous pouvez également créer des entrées DNS pour des NLB en enregistrant les adresses IP NLB avec des noms d'hôte.

Lorsque vous exposez une application avec un service NLB, elle est également automatiquement mise à disposition sur les ports de noeud (NodePort) du service. Les [ports de noeud](/docs/containers?topic=containers-nodeport) sont accessibles sur toutes les adresses IP publiques et privées de tous les noeuds worker figurant dans le cluster. Pour bloquer le trafic vers les ports de noeud lorsque vous utilisez un service d'équilibreur de charge de réseau, voir [Contrôle du trafic entrant vers les services d'équilibreur de charge de réseau (NLB) ou NodePort](/docs/containers?topic=containers-network_policies#block_ingress).

<br />


## Comparaison de l'équilibrage de charge de base et DSR dans les équilibreurs de charge de réseau versions 1.0 et 2.0
{: #comparison}

Lorsque vous créez un équilibreur de charge de réseau, vous pouvez choisir un équilibreur de charge de réseau version 1.0, qui effectue l'équilibrage de charge de base, ou un équilibreur de charge version 2.0, qui effectue l'équilibrage de charge DSR (Direct Server Return). Notez que les équilibreurs de charge de réseau version 2.0 sont en version bêta.
{: shortdesc}

**En quoi les équilibreurs de charge de réseau 1.0 et 2.0 sont-ils semblables ?**

Les équilibreurs de charge de réseau 1.0 et 2.0 sont des équilibreurs de charge de couche 4 qui existent dans l'espace du noyau Linux. Ces deux versions s'exécutent dans le cluster et utilisent des ressources de noeud worker. Par conséquent, la capacité disponible des équilibreurs de charge de réseau est toujours dédiée à votre propre cluster. Par ailleurs, ces deux versions d'équilibreurs de charge de réseau ne mettent pas fin à la connexion. Les connexions sont transférées à un pod d'application à la place.

**En quoi les équilibreurs de charge de réseau 1.0 et 2.0 sont-ils différents ?**

Lorsqu'un client envoie une demande à votre application, l'équilibreur de charge de réseau achemine des paquets de demandes à l'adresse IP du noeud worker où il existe un pod d'application. Les équilibreurs de charge de réseau 1.0 utilisent une conversion d'adresses réseau (NAT) pour réécrire l'adresse IP source du paquet de demandes sur l'adresse IP du noeud worker où il existe un pod d'équilibreur de charge. Lorsque le noeud worker renvoie un paquet de réponses d'application, il utilise l'adresse IP du noeud worker où se trouve l'équilibreur de charge de réseau. L'équilibreur de charge de réseau doit ensuite envoyer le paquet de réponses au client. Pour empêcher la réécriture de l'adresse IP, vous pouvez [activer la conservation de l'adresse IP source](/docs/containers?topic=containers-loadbalancer#node_affinity_tolerations). Cependant, la conservation de l'adresse IP source nécessite que les pods d'équilibreur de charge et les pods d'application s'exécutent sur le même noeud worker pour éviter d'avoir à transférer la demande vers un autre noeud worker. Vous devez ajouter des propriétés d'affinité de noeud et de tolérance aux pods d'application. Pour plus d'informations sur l'équilibrage de charge de base avec des équilibreurs de charge de réseau version 1.0, voir [Version 1.0 : Composants et architecture de l'équilibrage de charge de base](#v1_planning).

Contrairement aux équilibreurs de charge de réseau 1.0, les équilibreurs de charge de réseau 2.0 n'utilisent pas la conversion NAT lors du transfert des demandes aux pods d'application sur d'autres noeuds worker. Lorsqu'un équilibreur de charge de réseau 2.0 achemine une demande client, il utilise un tunnel IP sur IP (IPIP) pour encapsuler le paquet de demandes d'origine dans un autre paquet. Ce paquet comporte une adresse IP source du noeud worker dans lequel se trouve le pod d'équilibreur de charge, ce qui permet au paquet de demandes d'origine de conserver l'adresse IP du client comme adresse IP source. Le noeud worker utilise ensuite le mode DSR (Direct Server Return) pour envoyer le paquet de réponses de l'application à l'adresse IP du client. Le paquet de réponses ignore l'équilibreur de charge de réseau et est envoyé directement au client, réduisant ainsi la quantité de trafic que l'équilibreur de charge de réseau doit traiter. Pour plus d'informations sur l'équilibrage de charge DRS avec des équilibreurs de charge de réseau version 2.0, voir [Version 2.0 : Composants et architecture de l'équilibrage de charge DSR](#planning_ipvs).

<br />


## Composants et architecture d'un équilibreur de charge de réseau 1.0
{: #v1_planning}

L'équilibreur de charge de réseau 1.0 TCP/UDP utilise Iptables, une fonction du noyau Linux, pour équilibrer la charge des demandes sur les pods d'une application.
{: shortdesc}

### Flux de circulation dans un cluster à zone unique
{: #v1_single}

Le diagramme suivant montre comment un équilibreur de charge de réseau 1.0 dirige la communication d'Internet vers une application dans un cluster à zone unique.
{: shortdesc}

<img src="images/cs_loadbalancer_planning.png" width="410" alt="Exposer une application dans {{site.data.keyword.containerlong_notm}} en utilisant un équilibreur de charge de réseau 1.0" style="width:410px; border-style: none"/>

1. Une demande adressée à votre application utilise l'adresse IP publique de votre équilibreur de charge de réseau et le port affecté sur le noeud worker.

2. La demande est automatiquement transmise à l'adresse IP et au port du cluster interne du service NLB. L'adresse IP du cluster interne est accessible uniquement à l'intérieur du cluster.

3. `kube-proxy` achemine la demande vers le service NLB pour l'application.

4. La demande est transférée à l'adresse IP privée du pod d'application. L'adresse IP source du package de demande est remplacée par l'adresse IP publique du noeud worker sur lequel s'exécute le pod d'application. Si plusieurs instances d'application sont déployées dans le cluster, l'équilibreur de charge de réseau achemine les demandes entre les pods d'application.

### Flux de circulation dans un cluster à zones multiples
{: #v1_multi}

Le diagramme suivant montre comment un équilibreur de charge de réseau 1.0 dirige la communication d'Internet vers une application dans un cluster à zones multiples.
{: shortdesc}

<img src="images/cs_loadbalancer_planning_multizone.png" width="500" alt="Utiliser un équilibreur de charge de réseau 1.0 pour équilibrer la charge des applications dans des clusters à zones multiples" style="width:500px; border-style: none"/>

Par défaut, chaque équilibreur de charge de réseau 1.0 est configuré dans une seule zone. Pour assurer la haute disponibilité, vous devez déployer un équilibreur de charge de réseau 1.0 dans toutes les zones où se trouvent vos instances d'application. Les demandes sont traitées par les équilibreurs de charge de réseau dans les différentes zones à tour de rôle. De plus, chaque équilibreur de charge de réseau route les demandes vers les instances d'application au sein de sa propre zone et vers les instances d'application situées dans d'autres zones.

<br />


## Composants et architecture d'un équilibreur de charge de réseau 2.0 (bêta)
{: #planning_ipvs}

Les fonctionnalités de l'équilibreur de charge de réseau 2.0 sont en version bêta. Pour utiliser un équilibreur de charge de réseau 2.0, vous devez [mettre à jour le maître et les noeuds worker de votre cluster](/docs/containers?topic=containers-update) vers la version 1.12 ou ultérieure de Kubernetes.
{: note}

L'équilibreur de charge de réseau 2.0 est un équilibreur de charge de couche 4 qui utilise le serveur IPVS (IP Virtual Server) du noyau Linux. Il prend en charge les protocoles TCP et UDP, s'exécute devant plusieurs noeuds worker et utilise un tunnel IP sur IP (IPIP) pour distribuer le trafic qui arrive sur une adresse IP d'équilibreur de charge de réseau unique sur ces noeuds worker.

Vous souhaitez plus de détails sur les modèles de déploiement d'équilibrage de charge disponibles dans {{site.data.keyword.containerlong_notm}} ? Consultez cet [article de blogue ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://www.ibm.com/blogs/bluemix/2018/10/ibm-cloud-kubernetes-service-deployment-patterns-for-maximizing-throughput-and-availability/).
{: tip}

### Flux de circulation dans un cluster à zone unique
{: #ipvs_single}

Le diagramme suivant montre comment un équilibreur de charge de réseau 2.0 dirige la communication d'Internet vers une application dans un cluster à zone unique.
{: shortdesc}

<img src="images/cs_loadbalancer_ipvs_planning.png" width="600" alt="Exposer une application dans  {{site.data.keyword.containerlong_notm}} en utilisant un équilibreur de charge de réseau 2.0" style="width:600px; border-style: none"/>

1. Une demande client adressée à votre application utilise l'adresse IP publique de votre équilibreur de charge de réseau et le port affecté sur le noeud worker. Dans cet exemple, l'équilibreur de charge de réseau a l'adresse IP virtuelle 169.61.23.130, qui se trouve actuellement sur le noeud worker 10.73.14.25.

2. L'équilibreur de charge de réseau encapsule le paquet de demandes du client (labellisé "CR" dans l'image) dans un paquet IPIP (labellisé "IPIP"). Le paquet de demandes du client conserve l'adresse IP du client comme adresse IP source. Le paquet d'encapsulation IPIP utilise l'adresse IP 10.73.14.25 du noeud worker comme adresse IP source.

3. L'équilibreur de charge de réseau achemine le paquet IPIP vers un noeud worker dans lequel réside un pod d'application, 10.73.14.26. Si plusieurs instances d'application sont déployées dans le cluster, l'équilibreur de charge de réseau achemine les demandes entre les noeuds worker dans lesquels sont déployés les pods d'application.

4. Le noeud worker 10.73.14.26 décompresse le paquet d'encapsulation IPIP, puis décompresse le paquet de demandes du client. Le paquet de demandes du client est transféré au pod d'application sur ce noeud worker.

5. Le noeud worker 10.73.14.26 utilise ensuite l'adresse IP source du paquet de demandes d'origine, l'adresse IP du client, pour renvoyer le paquet de réponses du pod d'application directement au client.

### Flux de circulation dans un cluster à zones multiples
{: #ipvs_multi}

Le trafic dans un cluster à zones multiples suit le même chemin que le [trafic dans un cluster à zone unique](#ipvs_single). Dans un cluster à zones multiples, l'équilibreur de charge de réseau achemine les demandes vers les instances d'application au sein de sa propre zone et vers les instances d'application situées dans d'autres zones. Le diagramme suivant montre comment les équilibreurs de charge de réseau 2.0 de chaque zone dirigent le trafic d'Internet vers une application dans un cluster à zones multiples.
{: shortdesc}

<img src="images/cs_loadbalancer_ipvs_multizone.png" alt="Exposer une application dans {{site.data.keyword.containerlong_notm}} à l'aide d'une équilibreur de charge de réseau 2.0" style="width:500px; border-style: none"/>

Par défaut, chaque équilibreur de charge de réseau 2.0 est configuré dans une seule zone. Vous pouvez obtenir une plus haute disponibilité en déployant un équilibreur de charge de réseau 2.0 dans toutes les zones où vous disposez d'instances d'application.
