---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

keywords: kubernetes, iks, nginx, ingress controller

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



# A propos des ALB Ingress
{: #ingress-about}

Ingress est un service Kubernetes qui permet d'équilibrer les charges de travail du trafic réseau dans votre cluster en transférant des demandes publiques ou privées à vos applications. Vous pouvez utiliser Ingress pour exposer plusieurs services d'application sur un réseau public ou privé en utilisant une seule route publique ou privée.
{: shortdesc}

## Quels sont les composants fournis avec Ingress ?
{: #ingress_components}

Ingress est constitué de ressources Ingress, d'équilibreurs de charge d'application (ALB) et de l'équilibreur de charge à zones multiples (MZLB).
{: shortdesc}

### Ressource Ingress
{: #ingress-resource}

Pour exposer une application à l'aide d'Ingress, vous devez créer un service Kubernetes pour votre application et enregistrer ce service auprès d'Ingress en définissant une ressource Ingress. La ressource Ingress est une ressource Kubernetes qui définit les règles de routage des demandes entrantes pour les applications. Elle spécifie également le chemin d'accès à vos services d'application, qui sont ajoutés à la route publique pour composer une URL d'application unique, telle que `mycluster.us-south.containers.appdomain.cloud/myapp1`.
{: shortdesc}

Une ressource Ingress est requise pour chaque espace de nom hébergeant les applications que vous souhaitez exposer.
* Si les applications de votre cluster figurent toutes dans le même espace de nom, une ressource Ingress est requise pour définir les règles de routage pour les applications exposées à cet endroit. Notez que si vous souhaitez utiliser différents domaines pour les applications figurant dans un même espace de nom, vous pouvez utiliser un domaine générique pour spécifier plusieurs hôtes de sous-domaine dans une ressource. 
* Si les applications de votre cluster figurent dans différents espaces de nom, vous devez créer une ressource par espace de nom pour définir les règles des applications exposées à cet endroit. Vous devez utiliser un domaine générique et indiquer un sous-domaine différent dans chaque ressource Ingress. 

Pour plus d'informations, voir [Planification réseau pour un ou plusieurs espaces de nom](/docs/containers?topic=containers-ingress#multiple_namespaces).

A partir du 24 mai 2018, le format du sous-domaine Ingress a changé pour les nouveaux clusters. Le nom de la région ou de la zone inclus dans le nouveau format de sous-domaine est généré en fonction de la zone dans laquelle a été créé le cluster. Si vous avez des dépendances de pipeline sur des noms de domaine d'application cohérents, vous pouvez utiliser vos propres domaines personnalisés à la place du sous-domaine Ingress fourni par IBM.
{: note}

* Tous les clusters créés après le 24 mai 2018 se voient affecter un sous-domaine dans le nouveau format `<cluster_name>.<region_or_zone>.containers.appdomain.cloud`.
* Les clusters à zone unique créés avant le 24 mai 2018 continuent d'utiliser le sous-domaine affecté dans l'ancien format, `<cluster_name>.<region>.containers.mybluemix.net`.
* Si vous remplacez un cluster à zone unique créé avant le 24 mai 2018 par un cluster à zones multiples en [ajoutant une zone au cluster](/docs/containers?topic=containers-add_workers#add_zone) pour la première fois, le cluster continue à utiliser le sous-domaine affecté dans l'ancien format, `<cluster_name>.<region>.containers.mybluemix.net`, et se voit affecter un sous-domaine au nouveau format `<cluster_name>.<region_or_zone>.containers.appdomain.cloud`. Vous pouvez utiliser l'un ou l'autre de ces sous-domaines.

### Equilibreur de charge d'application (ALB)
{: #alb-about}

L'équilibreur de charge d'application (ALB) est un équilibreur de charge externe qui est à l'écoute des demandes de service HTTP, HTTPS ou TCP entrantes. L'ALB transfère ensuite les demandes au pod d'application approprié suivant les règles définies dans la ressource Ingress.
{: shortdesc}

Lorsque vous créez un cluster standard, {{site.data.keyword.containerlong_notm}} crée automatiquement un ALB à haute disponibilité pour votre cluster et lui affecte une route publique unique. La route publique est liée à une adresse IP publique portable qui est mise à disposition dans votre compte d'infrastructure IBM Cloud lors de la création du cluster. Un équilibreur de charge d'application (ALB) privé par défaut est également créé automatiquement, mais n'est pas activé automatiquement.

**Clusters à zones multiples** : lorsque vous ajoutez une zone dans votre cluster, un sous-réseau public portable est ajouté et un nouvel équilibreur de charge ALB est automatiquement créé et activé sur le sous-réseau dans cette zone. Tous les ALB publics par défaut dans votre cluster partagent une route publique mais ont des adresses IP distinctes. Un ALB privé par défaut est créé automatiquement dans chaque zone mais il n'est pas activé automatiquement.

### Equilibreur de charge pour zones multiples (MZLB)
{: #mzlb}

**Clusters à zones multiples** : dès que vous créez un cluster à zones multiples ou que vous [ajoutez une zone à un cluster à zone unique](/docs/containers?topic=containers-add_workers#add_zone), un équilibreur de charge pour zones multiples (MZLB) Cloudflare est automatiquement créé et déployé de sorte à avoir 1 équilibreur de charge MZLB pour chaque région. L'équilibreur de charge MZLB place les adresses IP de vos équilibreurs de charge d'application (ALB) derrière le même sous-domaine et active des diagnostics d'intégrité sur ces adresses IP pour déterminer si elles sont disponibles ou pas.

Par exemple, si vous disposez de noeuds worker dans 3 zones dans la région Est des Etats-Unis, le sous-domaine `yourcluster.us-east.containers.appdomain.cloud` comporte 3 adresses IP d'ALB. L'équilibreur de charge MZLB réalise des diagnostics d'intégrité de l'adresse IP ALB publique dans chaque zone d'une région et conserve les résultats de recherche DNS à jour en fonction de ces diagnostics. Par exemple, si vos ALB ont les adresses IP `1.1.1.1`, `2.2.2.2` et `3.3.3.3`, une opération normale de recherche DNS de votre sous-domaine Ingress renvoie ces trois adresses IP, dont 1 est accessible au client de manière aléatoire. Si l'ALB avec l'adresse IP `3.3.3.3` devient indisponible pour une raison quelconque, par exemple en cas de défaillance d'une zone, le diagnostic d'intégrité correspondant à cette zone échoue, l'équilibreur de charge MZLB retire du sous-domaine l'adresse IP ayant échoué et la recherche de DNS renvoie uniquement les adresses IP d'ALB `1.1.1.1` et `2.2.2.2` qui sont saines. Le sous-domaine dispose d'une durée de vie (TTL) de 30 secondes. Au bout de 30 secondes, les nouvelles applications client peuvent accéder à une seule des adresses IP d'ALB saines.

Dans de rares cas, certaines résolutions DNS ou applications client peuvent continuer à utiliser l'adresse IP d'ALB qui n'est pas saine après la durée de vie de 30 secondes. Ces applications client peuvent expérimenter une longue durée de chargement tant que le client n'abandonne pas l'adresse IP `3.3.3.3` pour tenter de se connecter à  l'adresse IP `1.1.1.1` ou `2.2.2.2`. En fonction du navigateur client ou des paramètres de l'application client, le délai peut varier de quelques secondes à la totalité du délai d'attente TCP.

L'équilibreur de charge MZLB équilibre les charges des ALB publics utilisant uniquement le sous-domaine Ingress fourni par IBM. Si vous n'utilisez que des ALB privés, vous devez vérifier manuellement l'intégrité de vos ALB et mettre à jour les résultats de recherche DNS. Si vous avez recours à des ALB publics utilisant un domaine personnalisé, vous pouvez inclure ces ALB dans l'équilibrage de charge du MZLB en créant un enregistrement CNAME dans votre entrée DNS pour transférer les demandes de votre domaine personnalisé au sous-domaine Ingress fourni par IBM pour votre cluster.

Si vous utilisez les règles réseau Pre-DNAT Calico pour bloquer tout le trafic entrant vers les services Ingress, vous devez également inclure dans la liste blanche les [adresses IP IPV4 de Cloudflare ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://www.cloudflare.com/ips/)  qui sont utilisées pour effectuer des diagnostics d'intégrité de vos ALB. Pour obtenir les étapes nécessaires permettant de créer une règle Pre-DNAT Calico afin de mettre ces adresses IP sur liste blanche, voir la [Leçon 3 du tutoriel sur les règles réseau de Calico](/docs/containers?topic=containers-policy_tutorial#lesson3).
{: note}

<br />


## Comment sont affectées les adresses IP dans les ALB Ingress ?
{: #ips}

Lorsque vous créez un cluster standard, un sous-réseau public portable et un sous-réseau privé portable sont fournis automatiquement par {{site.data.keyword.containerlong_notm}}. Par défaut, le cluster utilise automatiquement :
* 1 adresse IP publique portable du sous-réseau public portable correspondant à l'ALB Ingress public par défaut.
* 1 adresse IP privée portable du sous-réseau privé portable correspondant à l'ALB Ingress privé par défaut.
{: shortdesc}

Si vous disposez d'un cluster à zones multiples, un ALB public par défaut et un ALB privé par défaut sont automatiquement créés dans chaque zone. Toutes les adresses IP de vos ALB publics par défaut se trouvent derrière le même sous-domaine fourni par IBM pour votre cluster.

Les adresses IP publiques et privées portables sont des adresses IP flottantes statiques et ne changent pas en cas de retrait d'un noeud worker. Si le noeud worker est retiré,  un démon `Keepalived` contrôlant l'adresse IP en permanence, replanifie les pods d'ALB qui résidaient sur ce noeud worker dans un autre noeud worker figurant dans cette zone. Les pods d'ALB replanifiés conservent la même adresse IP statique. Pendant la durée de vie de votre cluster, l'adresse IP d'ALB dans chaque zone ne change pas. Si vous retirez une zone de votre cluster, l'adresse IP d'ALB de cette zone est retirée.

Pour voir les adresses IP affectées à vos ALB, vous pouvez exécuter la commande suivante.
```
ibmcloud ks albs --cluster <cluster_name_or_id>
```
{: pre}

Pour plus d'informations sur ce qui arrive aux adresses IP d'ALB en cas de défaillance d'une zone, voir la définition du [composant d'équilibreur de charge pour zones multiples](#ingress_components).



<br />


## Comment une demande accède à mon application avec Ingress dans un cluster à zone unique ?
{: #architecture-single}



Le diagramme suivant illustre comment Ingress dirige la communication d'Internet vers une application dans un cluster à zone unique :

<img src="images/cs_ingress_singlezone.png" width="800" alt="Exposition d'une application dans une zone unique en utilisant Ingress" style="width:800px; border-style: none"/>

1. Un utilisateur envoie une demande à votre application en accédant à l'URL de votre application. Il s'agit de l'URL publique de votre application exposée avec le chemin de la ressource Ingress ajouté à la suite, par exemple `mycluster.us-south.containers.appdomain.cloud/myapp`.

2. Un service système DNS résout le sous-domaine dans l'URL avec une adresse IP publique portable de l'équilibreur de charge qui expose l'ALB dans votre cluster.

3. En fonction de l'adresse IP résolue, le client envoie une demande au service d'équilibreur de charge qui expose l'ALB.

4. Le service d'équilibreur de charge achemine la demande à l'ALB.

5. L'équilibreur de charge ALB vérifie s'il existe une règle de routage pour le chemin `myapp` dans le cluster. Si une règle correspondante est trouvée, la demande est transmise en fonction des règles que vous avez définies dans la ressource Ingress au pod sur lequel est déployée l'application. L'adresse IP source du package est remplacée par l'adresse IP publique du noeud worker sur lequel s'exécute le pod d'application. Si plusieurs instances sont déployées dans le cluster, l'équilibreur de charge ALB équilibre les demandes entre les pods d'application.

<br />


## Comment une demande accède à  mon application avec Ingress dans un cluster à zones multiples ?
{: #architecture-multi}

Le diagramme suivant illustre comment Ingress dirige la communication d'Internet vers une application dans un cluster à zones multiples :

<img src="images/cs_ingress_multizone.png" width="800" alt="Exposition d'une application dans un cluster à zones multiples en utilisant Ingress" style="width:800px; border-style: none"/>

1. Un utilisateur envoie une demande à votre application en accédant à l'URL de votre application. Il s'agit de l'URL publique de votre application exposée avec le chemin de la ressource Ingress ajouté à la suite, par exemple `mycluster.us-south.containers.appdomain.cloud/myapp`.

2. Un service système DNS, qui fait office d'équilibreur de charge global, résout le sous-domaine dans l'URL avec une adresse IP disponible qui a été signalée comme saine par l'équilibreur de charge MZLB. Le MZLB vérifie en continu les adresses IP publiques portables des services d'équilibreur de charge qui exposent des ALB publics dans chaque zone de votre cluster. Les adresses IP sont résolues à tour de rôle, garantissant ainsi que les demandes sont équilibrées de manière égale parmi les ALB sains figurant dans les différentes zones.

3. Le client envoie la demande à l'adresse IP du service d'équilibreur de charge qui expose un ALB.

4. Le service d'équilibreur de charge achemine la demande à l'ALB.

5. L'équilibreur de charge ALB vérifie s'il existe une règle de routage pour le chemin `myapp` dans le cluster. Si une règle correspondante est trouvée, la demande est transmise en fonction des règles que vous avez définies dans la ressource Ingress au pod sur lequel est déployée l'application. L'adresse IP source du package est remplacée par l'adresse IP publique du noeud worker sur lequel s'exécute le pod d'application. Si plusieurs instances sont déployées dans le cluster, l'équilibreur de charge ALB équilibre les demandes entre les pods d'application sur toutes les zones.
