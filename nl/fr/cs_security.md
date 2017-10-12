---

copyright:
  years: 2014, 2017
lastupdated: "2017-08-15"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Sécurité d'{{site.data.keyword.containerlong_notm}}
{: #cs_security}

Vous pouvez utiliser les fonctions de sécurité intégrées pour l'analyse des risques et la protection de la sécurité. Ces fonctions vous aident à protéger l'infrastructure de votre cluster et la communication réseau, à isoler vos ressources de traitement, et à garantir la conformité aux règles de sécurité dans les composants de votre infrastructure et les déploiements de conteneurs.
{: shortdesc}

<a href="https://console.bluemix.net/docs/api/content/containers/images/cs_security.png">Sécurité de cluster <img src="images/cs_security.png" width="400" alt="{{site.data.keyword.containershort_notm}}" style="width:400px;" /></a>

<table summary="La première ligne du tableau s'étend sur deux colonnes. Les autres lignes se lisent de gauche à droite. L'emplacement du serveur figure dans la première colonne et les adresses IP pour concordance dans la seconde colonne.">
      <thead>
  <th colspan=2><img src="images/idea.png"/> Paramètres de sécurité de cluster intégrés dans {{site.data.keyword.containershort_notm}}</th>
  </thead>
  <tbody>
    <tr>
      <td>Maître Kubernetes</td>
      <td>Le maître Kubernetes présent dans chaque cluster est géré par IBM et caractérisé par une haute disponibilité.
Il inclut des paramètres de sécurité {{site.data.keyword.containershort_notm}} qui assurent la conformité aux règles de sécurité et une communication sécurisée vers et depuis les noeuds d'agent. Des mises à jour sont effectuées par
IBM chaque fois que nécessaire. Le maître Kubernetes dédié régit et surveille depuis une position centralisée toutes les ressources Kubernetes
dans le cluster. En fonction des exigences du déploiement et de la capacité du cluster, le maître Kubernetes planifie automatiquement le déploiement de vos applications conteneurisées entre les noeuds d'agent disponibles. Pour plus d'informations, voir [Sécurité du maître Kubernetes](#cs_security_master).</td>
    </tr>
    <tr>
      <td>Noeud d'agent</td>
      <td>Les conteneurs sont déployés sur des noeuds d'agent dédiés à un cluster et qui assurent l'isolement du traitement, du réseau et du stockage pour les clients IBM. {{site.data.keyword.containershort_notm}} dispose de fonctions de sécurité intégrées pour sécuriser vos noeuds d'agent sur le réseau privé et public et pour garantir la conformité des noeuds d'agent aux règles de sécurité. Pour plus d'informations, voir [Sécurité des noeuds d'agent](#cs_security_worker).</td>
     </tr>
     <tr>
      <td>Images</td>
      <td>En tant qu'administrateur du cluster, vous pouvez configurer votre propre registre d'images Docker sécurisé dans {{site.data.keyword.registryshort_notm}} pour y stocker et partager avec vos utilisateurs du cluster des images Docker. Pour garantir des déploiements de conteneurs sécurisés, chaque image dans
votre registre privé est analysée par Vulnerability Advisor. Vulnerability Advisor est un composant d'{{site.data.keyword.registryshort_notm}} qui détecte des vulnérabilités potentielles, soumet des recommandations de sécurité et des instructions pour résoudre ces vulnérabilités. Pour plus d'informations, voir [Sécurité des images dans {{site.data.keyword.containershort_notm}}](#cs_security_deployment).</td>
    </tr>
  </tbody>
</table>

## Maître Kubernetes
{: #cs_security_master}

Examinez les fonctions de sécurité du maître Kubernetes intégré destinées à
protéger ce dernier et à sécuriser les communications réseau du cluster.
{: shortdesc}

<dl>
  <dt>Maître Kubernetes entièrement géré et dédié</dt>
    <dd>Chaque cluster Kubernetes dans {{site.data.keyword.containershort_notm}}
est régi par un maître Kubernetes dédié géré par IBM dans un compte {{site.data.keyword.BluSoftlayer_full}} sous propriété IBM. Le maître Kubernetes est configuré avec les composants dédiés suivants qui ne sont pas partagés avec d'autres clients IBM.
    <ul><ul><li>Magasin  de données etcd : stocke toutes les ressources Kubernetes d'un cluster, telles que services, déploiements et nacelles. Les éléments Kubernetes ConfigMaps et Secrets sont des données d'application stockées sous forme de paires clé-valeur afin de les utiliser dans une application s'exécutant dans une nacelle. Les données etcd sont stockées sur un disque géré par
IBM et chiffré par TLS lors de leur envoi à une nacelle pour assurer l'intégrité et la protection des données.
    <li>kube-apiserver : constitue le point d'entrée principal pour toutes les demandes du noeud d'agent au maître
Kubernetes. Le serveur kube-apiserver valide et traite les demandes et a accès en lecture et écriture au magasin de données
etcd.
    <li><kube-scheduler : décide où déployer les nacelles en prenant en compte la capacité du compte et les besoins en performances, les contraintes des règles en matière de matériel et de logiciel, les spécifications d'anti-affinité, et les besoins de la charge de travail. Si aucun noeud d'agent ne correspond à ces exigences, la nacelle n'est pas déployée dans le cluster.
    <li>kube-controller-manager : se charge de la surveillance des jeux de répliques et de la création de nacelles correspondantes pour atteindre l'état désiré.
    <li>OpenVPN : composant {{site.data.keyword.containershort_notm}} spécifique permettant une connectivité réseau sécurisée pour toutes les communications du maître Kubernetes avec les noeuds d'agent.</ul></ul></dd>
  <dt>Connectivité réseau TLS sécurisée pour toutes les communications du noeud d'agent avec le maître Kubernetes</dt>
    <dd>Pour sécuriser les communications réseau vers le maître Kubernetes, {{site.data.keyword.containershort_notm}} génère des certificats TLS qui chiffrent les communications vers et depuis le serveur kube-apiserver et les composant du magasin de données etcd pour chaque cluster. Ces certificats ne sont jamais partagés entre les clusters ou entre les composants du maître Kubernetes.</dd>
  <dt>Connectivité réseau OpenVPN sécurisée pour toutes les communications du maître Kubernetes vers les noeuds d'agent</dt>
    <dd>Bien que Kubernetes sécurise les communications entre le maître Kubernetes et les noeuds d'agent en utilisant le protocole
`https`, aucune authentification n'est fournie par défaut sur le noeud d'agent. Pour sécuriser ces communications, {{site.data.keyword.containershort_notm}} configure automatiquement une connexion OpenVPN
entre le maître Kubernetes et les noeuds d'agent lors de la création du cluster.</dd>
  <dt>Surveillance continue du réseau maître Kubernetes</dt>
    <dd>Chaque Kubernetes est surveillé en permanence par IBM pour identifier et contrer les attaques de type DOS
(Déni de service) au niveau des processus.</dd>
  <dt>Conformité de sécurité du noeud maître Kubernetes</dt>
    <dd>{{site.data.keyword.containershort_notm}} analyse automatiquement chaque noeud sur lequel le maître Kubernetes est déployé pour détecter des vulnérabilités affectant Kubernetes et identifier les correctifs de sécurité spécifiques au système d'exploitation devant être appliqués pour protection du noeud maître. Si des vulnérabilités sont détectées, {{site.data.keyword.containershort_notm}} applique automatiquement les correctifs appropriés et résout les vulnérabilités pour l'utilisateur.</dd>
</dl>  

## Noeuds d'agent
{: #cs_security_worker}

Examinez les fonctions de sécurité de noeud d'agent intégrées destinées à protéger l'environnement de noeud d'agent et à assurer l'isolement des ressources, du réseau et du stockage.
{: shortdesc}

<dl>
  <dt>Isolement de l'infrastructure de traitement, réseau et de stockage</dt>
    <dd>Lorsque vous créez un cluster, des machines virtuelles sont allouées par IBM en tant que noeuds d'agent dans le compte {{site.data.keyword.BluSoftlayer_notm}} ou dans le compte {{site.data.keyword.BluSoftlayer_notm}} Dedicated. Les noeuds d'agent sont dédiés à un cluster et n'hébergent pas la charge de travail d'autres clusters.</br> Chaque compte {{site.data.keyword.Bluemix_notm}} est configuré avec des réseaux locaux virtuels {{site.data.keyword.BluSoftlayer_notm}} pour garantir des performances réseau satisfaisantes et l'isolement des noeuds d'agent. </br>Pour rendre persistantes les données dans votre cluster, vous pouvez
allouer un stockage de fichiers NFS depuis {{site.data.keyword.BluSoftlayer_notm}} et tirer parti des fonctions de sécurité intégrées de cette plateforme.</dd>
  <dt>Noeud d'agent sécurisé configuré</dt>
    <dd>Chaque noeud d'agent est configuré avec un système d'exploitation Ubuntu qui ne
peut pas être modifié par l'utilisateur. Afin de protéger ce système d'exploitation
face aux attaques potentielles, chaque noeud d'agent est configuré avec des paramètres
de pare-feu avancés imposés par les règles iptable de Linux.</br> Tous les conteneurs
s'exécutant sur Kubernetes sont protégés par des paramètres de règles réseau Calico
prédéfinies qui sont configurées sur chaque
noeud d'agent lors de la création du cluster. Cette configuration assure une communication réseau sécurisée entre les noeuds d'agent et les nacelles. Pour
limiter davantage les actions qu'un conteneur peut effectuer sur le noeud d'agent, les
utilisateurs peuvent choisir de configurer des [règles AppArmor ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/tutorials/clusters/apparmor/) sur les noeuds d'agent. </br> Par défaut, l'accès SSH de l'utilisateur
root est désactivé sur le noeud d'agent. Si vous souhaitez installer des fonctions
supplémentaires sur votre noeud d'agent, vous pouvez utiliser des [jeux de démons Kubernetes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset) pour tout ce que vous voulez exécuter sur chaque noeud
d'agent, ou des [travaux Kubernetes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/) pour les actions ponctuelles que vous devez exécuter. </dd>
  <dt>Conformité à la sécurité de noeud d'agent Kubernetes</dt>
    <dd>IBM collabore avec des équipes, tant internes qu'externes, de conseil en sécurité pour identifier des problèmes potentiels de conformité aux règles de sécurité sur les noeuds d'agent et diffuse régulièrement des mises à jour des règles de conformité et des correctifs de sécurité pour parer aux vulnérabilités éventuelles détectées. Les mises à jour et les correctifs de sécurité sont automatiquement déployés par IBM sur le système d'exploitation du noeud d'agent. Pour ce faire, IBM accède via SSH aux noeuds d'agent.</br> <b>Remarque</b> : Certaines mises à jour nécessitent le redémarrage d'un noeud d'agent. Toutefois, IBM ne redémarre pas les noeuds d'agent lors de l'installation de mises à jour ou de correctifs de sécurité. Il est conseillé aux utilisateurs de redémarrer régulièrement les noeuds d'agent pour
permettre à l'installation des mises à jour et des correctifs de sécurité de s'achever.</dd>
  <dt>Prise en charge des pare-feux réseau SoftLayer</dt>
    <dd>{{site.data.keyword.containershort_notm}} est compatible avec toutes les offres de pare-feu [{{site.data.keyword.BluSoftlayer_notm}} ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/cloud-computing/bluemix/network-security). Sur {{site.data.keyword.Bluemix_notm}} public, vous pouvez mettre en place un pare-feu avec des règles réseau personnalisées afin de promouvoir une sécurité réseau dédiée pour votre cluster et de détecter et de parer à des intrusions réseau. Par exemple, vous pouvez choisir de configurer un [produit Vyatta ![External link icon](../icons/launch-glyph.svg "External link icon")](https://knowledgelayer.softlayer.com/topic/vyatta-1) qui agira en tant que pare-feu et bloquera le trafic indésirable. Lorsque vous configurez un pare-feu, [vous devez également ouvrir les adresses IP et les ports requis](#opening_ports) pour chaque région de manière à permettre au maître et aux noeuds d'agent de communiquer. Sur {{site.data.keyword.Bluemix_notm}} Dedicated, les pare-feux, DataPower, Fortigate et DNS sont déjà configurés dans le cadre de l'environnement de déploiement dédié standard. </dd>
  <dt>Gardez privés les services ou exposez sélectivement des services et des applications à l'Internet public</dt>
    <dd>Vous pouvez décider de garder privés vos services et applications et d'exploiter les fonctions de sécurité intégrées décrites dans cette rubrique pour assurer une communication sécurisée entre les noeuds d'agent et les nacelles. Si vous désirez exposer des services et des applications sur l'Internet public, vous
pouvez exploiter la prise en charge d'Ingress et d'un équilibreur de charge pour rendre
vos services accessibles au public de manière sécurisée.</dd>
  <dt>Connectez vos noeuds d'agent et vos applications de manière sécurisée à un centre de données sur site</dt>
    <dd>Vous pouvez mettre en place un produit Vyatta Gateway Appliance ou Fortigate Appliance pour configurer un noeud final IPSec VPN qui connecte votre cluster Kubernetes à un centre de données sur site. Via un tunnel chiffré, tous les services qui s'exécutent dans votre cluster Kubernetes peuvent communiquer de manière sécurisée avec des applications sur site, telles que des annuaires d'utilisateurs, des bases de données ou des grands systèmes. Pour plus d'informations, voir [Connexion d'un cluster à un centre de données sur site ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/blogs/bluemix/2017/07/kubernetes-and-bluemix-container-based-workloads-part4/).</dd>
  <dt>Consignation au journal et surveillance en continu de l'activité du cluster</dt>
    <dd>Dans le cas des clusters standard, tous les événements associés au cluster (tels que l'ajout d'un noeud d'agent, la progression d'une mise à jour tournante ou les informations sur l'utilisation des capacités) sont consignés au journal et surveillés par
{{site.data.keyword.containershort_notm}} qui les envoie aux services IBM Monitoring et
Logging Service.</dd>
</dl>

### Ouverture des ports et adresses IP requis dans votre pare-feu
{: #opening_ports}

Lorsque vous configurez un pare-feu pour vos noeuds d'agent ou que vous personnalisez les paramètres de pare-feu dans votre compte {{site.data.keyword.BluSoftlayer_notm}}, vous devez ouvrir certains ports et certaines adresses IP de manière à permettre au noeud d'agent et au maître Kubernetes de communiquer. 

1.  Notez l'adresse IP publique pour tous vos noeuds d'agent dans le cluster. 

    ```
    bx cs workers <cluster_name_or_id>
    ```
    {: pre}

2.  Dans votre pare-feu, autorisez les connexions suivantes vers et depuis vos noeuds d'agent. 

  ```
  TCP port 443 FROM <each_worker_node_publicIP> TO registry.<region>.bluemix.net, apt.dockerproject.org
  ```
  {: codeblock}

    <ul><li>Pour la connectivité SORTANTE depuis vos noeuds d'agent, autorisez le trafic réseau sortant depuis le noeud d'agent source vers la plage de ports TCP/UDP de destination 20000 à 32767 pour `
<each_worker_node_publicIP>`, et les adresses IP et groupes de réseaux suivants :</br>
    

    <table summary="La première ligne du tableau s'étend sur deux colonnes. Les autres lignes se lisent de gauche à droite. L'emplacement du serveur figure dans la première colonne et les adresses IP pour concordance dans la seconde colonne.">
      <thead>
      <th colspan=2><img src="images/idea.png"/> Adresses IP sortantes</th>
      </thead>
    <tbody>
      <tr>
        <td>ams03</td>
        <td><code>169.50.169.110</code></td>
      </tr>
      <tr>
        <td>dal10</td>
        <td><code>169.46.7.238</code></td>
       </tr>
       <tr>
        <td>dal12</td>
        <td><code>169.47.70.10</code></td>
       </tr>
       <tr>
        <td>fra02</td>
        <td><code>169.50.56.174</code></td>
       </tr>
      </tbody>
      <tr>
       <td>lon02</td>
       <td><code>159.122.242.78</code></td>
      </tr>
      <tr>
       <td>lon04</td>
       <td><code>158.175.65.170</code></td>
      </tr>
      <tr>
       <td>syd01</td>
       <td><code>168.1.8.195</code></td>
      </tr>
      <tr>
       <td>syd04</td>
       <td><code>130.198.64.19</code></td>
      </tr>
    </table>
</ul>


## Règles réseau
{: #cs_security_network_policies}

Chaque cluster Kubernetes est installé avec un plug-in réseau nommé Calico. Des règles réseau par défaut sont mises en place pour sécuriser
l'interface réseau publique de chaque noeud d'agent. Vous pouvez exploiter
Calico et les fonctionnalités Kubernetes natives pour configurer des règles réseau supplémentaires pour un cluster si vous avez des exigences de sécurité particulières. Ces règles réseau spécifient le trafic réseau que vous désirez autoriser ou bloquer vers et depuis une nacelle d'un cluster.
{: shortdesc}

Vous avez le choix entre la fonctionnalités Calico et les fonctionnalités Kubernetes natives pour créer des règles réseau pour votre cluster. Vous pouvez utiliser les règles réseau Kubernetes pour débuter, mais pour des capacités plus robustes, utilisez les règles réseau Calico.

<ul><li>[Règles réseau Kubernetes ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/services-networking/network-policies/) : quelques options élémentaires sont fournies, comme la possibilité de spécifier quelles nacelles peuvent communiquer entre elles. Le trafic réseau entrant vers les nacelles peut être autorisé ou bloqué pour un protocole et un port donnés, et sur la base des libellés et des espaces de nom Kubernetes de la nacelle qui tente de s'y connecter.</br>Ces règles peuvent être appliquées par le biais de commandes
`kubectl` ou d'API Kubernetes. Lorsque ces règles sont appliquées, elles sont converties en règles réseau
Calico et mises en vigueur par Calico.
<li>[Règles réseau Calico![External link icon](../icons/launch-glyph.svg "External link icon")](http://docs.projectcalico.org/v2.0/getting-started/kubernetes/tutorials/advanced-policy) : ces règles sont un sur-ensemble des règles réseau Kubernetes et optimisent les capacités Kubernetes natives en leur ajoutant les fonctionnalités suivantes.
<ul><ul><li>Autorisation ou blocage du trafic réseau sur des interfaces réseau spécifiques, et non pas seulement le trafic des nacelles Kubernetes.<li>Autorisation ou blocage de trafic réseau entrant (ingress) et sortant (egress).<li>Autorisation ou blocage de trafic sur la base d'une adresse IP ou CIDR source ou de destination.</ul></ul></br>
Ces règles sont appliquées via les commandes `calicoctl`. Calico met en vigueur ces règles, y-compris les éventuelles règles réseau
Kubernetes converties en règles Calico, en configurant des règles Linux iptables sur les noeuds d'agent Kubernetes. Les règles iptables font office de pare-feu pour le noeud d'agent en définissant les caractéristiques que le trafic réseau doit respecter pour être acheminé à la ressource ciblée.</ul>


### Configuration de règles par défaut
{: #concept_nq1_2rn_4z}

Lorsqu'un cluster est créé, des règles réseau par défaut sont automatiquement configurées pour l'interface réseau publique de chaque noeud public afin de limiter le trafic entrant d'un noeud d'agent depuis l'Internet public. Ces règles n'affectent pas le trafic entre les nacelles et son mises en place pour permettre l'accès au port de noeud Kubernetes, à l'équilibreur de charge et aux services Ingress.

Des règles par défaut ne sont pas appliquées aux nacelles directement, mais à l'interface réseau publique d'un noeud d'agent à l'aide d'un [noeud final d'hôte ![External link icon](../icons/launch-glyph.svg "External link icon")](http://docs.projectcalico.org/v2.0/getting-started/bare-metal/bare-metal) Calico. Quand un noeud final d'hôte est créé dans Calico, tout le trafic vers et depuis l'interface réseau publique de ce noeud d'agent est bloqué, sauf s'il est autorisé par une règle.

Notez qu'il n'existe pas de règle pour autoriser le trafic SSH et donc l'accès SSH via l'interface réseau publique est bloqué, tout comme tous les autres ports qui ne sont pas ouverts par une règle. L'accès SSH, et un autre accès, est disponible sur l'interface réseau privée de chaque noeud d'agent.

**Important :** prenez soin de ne pas supprimer de règles qui sont appliquées à un noeud final d'hôte à moins de comprendre parfaitement la règle et de savoir que vous n'avez pas besoin du trafic qui est autorisé par cette règle. 



  <table summary="La première ligne du tableau s'étend sur deux colonnes. Les autres lignes se lisent de gauche à droite. L'emplacement du serveur figure dans la première colonne et les adresses IP pour concordance dans la seconde colonne.">
      <thead>
  <th colspan=2><img src="images/idea.png"/> Règles par défaut définies pour chaque cluster </th>
  </thead>
  <tbody>
    <tr>
      <td><code>allow-all-outbound</code></td>
      <td>Autorise tout le trafic sortant.</td>
    </tr>
    <tr>
      <td><code>allow-icmp</code></td>
      <td>Autorise tous les paquets icmp entrants (pings).</td>
     </tr>
     <tr>
      <td><code>allow-kubelet-port</code></td>
      <td>Autorise tout le trafic entrant sur le port 10250, lequel est le port utilisé par le kubelet. Cette règle permet aux commandes `kubectl logs` et `kubectl exec` de fonctionner correctement dans le cluster Kubernetes.</td>
    </tr>
    <tr>
      <td><code>allow-node-port-dnat</code></td>
      <td>Autorise le trafic entrant du service nodeport, d'équilibrage de charge et Ingress service vers les ports que ces
services exposent. Notez que le port que ces services exposent sur l'interface publique n'a pas besoin d'être spécifié puisque Kubernetes utilise la conversion d'adresse de réseau de destination pour réacheminer ces demandes de service aux nacelles correctes. Ce réacheminement intervient avant de les règles de noeud final d'hôte soient appliquées dans des iptables.</td>
   </tr>
   <tr>
      <td><code>allow-sys-mgmt</code></td>
      <td>Autorise les connexions entrantes pour des systèmes {{site.data.keyword.BluSoftlayer_notm}} spécifiques utilisés pour gérer les noeuds d'agent.</td>
   </tr>
   <tr>
    <td><code>allow-vrrp</code></td>
    <td>Autorise les paquets vrrp, lesquels sont utilisés pour suivi et déplacement d'adresses IP virtuelles entre noeuds d'agent.</td>
   </tr>
  </tbody>
</table>


### Ajout de règles réseau
{: #adding_network_policies}

Dans la plupart des cas, les règles par défaut n'ont pas besoin d'être modifiées. Seuls les scénarios avancés peuvent demander des modifications. Si vous constatez qu'il vous faut apporter de telles modifications, installez l'interface CLI de Calico et créez vos propres règles réseau.

Avant de commencer, procédez comme suit.

1.  [Installez les interfaces CLI de {{site.data.keyword.containershort_notm}} et de Kubernetes.](cs_cli_install.html#cs_cli_install)
2.  [Créez un cluster léger ou standard.](cs_cluster.html#cs_cluster_ui)
3.  [Ciblez l'interface CLI de Kubernetes sur le cluster](cs_cli_install.html#cs_cli_configure). Incluez l'option `--admin` avec la commande `bx cs
cluster-config`, laquelle est utilisée pour télécharger les fichiers de certificat et d'autorisations. Ce téléchargement inclut également les clés pour le rôle rbac Administrator, dont vous aurez besoin pour exécuter des commandes Calico.

  ```
  bx cs cluster-config <cluster_name> 
  ```
  {: pre}


Pour ajouter des règles réseau, procédez comme suit :
1.  Installez l'interface CLI de Calico.
    1.  [Téléchargez l'interface CLI de Calico ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.com/projectcalico/calicoctl/releases/).

        **Astuce :** si vous utilisez Windows, installez l'interface CLI de Calico dans le même répertoire que l'interface CLI de {{site.data.keyword.Bluemix_notm}}. Cette configuration vous évite diverses modifications de chemin de fichier lorsque vous exécuterez des commandes plus tard.

    2.  Utilisateurs OSX et Linux : procédez comme suit.
        1.  Déplacez le fichier exécutable vers le répertoire /usr/local/bin. 
            -   Linux :

              ```
              mv /<path_to_file>/calicoctl /usr/local/bin/calicoctl
              ```
              {: pre}

            -   OS
X :

              ```
              mv /<path_to_file>/calico-darwin-amd64 /usr/local/bin/calicoctl
              ```
              {: pre}

        2.  Convertissez le fichier binaire en exécutable.

            ```
            chmod +x /usr/local/bin/calicoctl
            ```
            {: pre}

    3.  Assurez-vous que les commandes `calico` se sont correctement exécutées en vérifiant la version du client CLI de Calico.

        ```
        calicoctl version
        ```
        {: pre}

2.  Configurez l'interface CLI de Calico.

    1.  Pour Linux et OS X, créez le répertoire '/etc/calico'. Pour Windows, vous pouvez utiliser n'importe quel répertoire.

      ```
      mkdir -p /etc/calico/
      ```
      {: pre}

    2.  Créez un fichier 'calicoctl.cfg'. 
        -   Linux et OS X :

          ```
          sudo vi /etc/calico/calicoctl.cfg
          ```
          {: pre}

        -   Windows : créez le fichier à l'aide d'un éditeur de texte.

    3.  Entrez les informations suivantes dans le fichier <code>calicoctl.cfg</code>.

      ```
      apiVersion: v1
      kind: calicoApiConfig
      metadata:
      spec:
          etcdEndpoints: <ETCD_URL>
          etcdKeyFile: <CERTS_DIR>/admin-key.pem
          etcdCertFile: <CERTS_DIR>/admin.pem
          etcdCACertFile: <CERTS_DIR>/<ca-*pem_file>
      ```
      {: pre}

        1.  Récupérez l'`<ETCD_URL>`.

          -   Linux et OS X :

              ```
              kubectl describe pod -n kube-system `kubectl get pod -n kube-system | grep calico-policy-controller | awk '{print $1}'` | grep ETCD_ENDPOINTS | awk '{print $2}'
              ```
              {: pre}

          -   Exemple de sortie :

              ```
              https://169.1.1.1:30001
              ```
              {: screen}

          -   Windows :
            <ol>
            <li>Extrayez la liste des nacelles dans l'espace de nom kube-system et localisez la nacelle du contrôleur Calico. </br><pre class="codeblock"><code>kubectl get pod -n kube-system</code></pre></br>Exemple :</br><pre class="screen"><code>calico-policy-controller-1674857634-k2ckm</code></pre>
            <li>Affichez les détails de la nacelle du contrôleur Calico.</br> <pre class="codeblock"><code>kubectl describe pod -n kube-system calico-policy-controller-&lt;ID&gt;</code></pre>
            <li>Localisez la valeur des noeuds finaux ETCD. Exemple : <code>https://169.1.1.1:30001</code>
            </ol>

        2.  Récupérez `<CERTS_DIR>`, le répertoire dans lequel les certificats Kubernetes sont téléchargés. 

            -   Linux et OS X :

              ```
              dirname $KUBECONFIG
              ```
              {: pre}

                Exemple de sortie :

              ```
              /home/sysadmin/.bluemix/plugins/container-service/clusters/<cluster_name>-admin/
              ```
              {: screen}

            -   Windows :

              ```
              ECHO %KUBECONFIG%
              ```
              {: pre}

                Exemple de sortie :

              ```
              C:/Users/<user>/.bluemix/plugins/container-service/<cluster_name>-admin/kube-config-prod-<location>-<cluster_name>.yml
              ```
              {: screen}

            **Remarque** : pour obtenir le chemin de répertoire, retirez le nom de fichier `kube-config-prod-<location>-<cluster_name>.yml` à la fin de la sortie. 

        3.  Extrayez la valeur <code>ca-*pem_file<code>.

            -   Linux et OS X :

              ```
              ls `dirname $KUBECONFIG` | grep ca-.*pem
              ```
              {: pre}

            -   Windows :
              <ol><li>Ouvrez le répertoire extrait à la dernière étape.</br><pre class="codeblock"><code>C:\Users\<user>\.bluemix\plugins\container-service\&#60;cluster_name&#62;-admin\</code></pre>
              <li> Localisez le fichier <code>ca-*pem_file</code>. </ol>

        4.  Vérifiez que la configuration Calico fonctionne correctement.

            -   Linux et OS X :

              ```
              calicoctl get nodes
              ```
              {: pre}

            -   Windows :

              ```
              calicoctl get nodes --config=<path_to_>/calicoctl.cfg
              ```
              {: pre}

              Sortie :

              ```
              NAME
              kube-dal10-crc21191ee3997497ca90c8173bbdaf560-w1.cloud.ibm
              kube-dal10-crc21191ee3997497ca90c8173bbdaf560-w2.cloud.ibm
              kube-dal10-crc21191ee3997497ca90c8173bbdaf560-w3.cloud.ibm
              ```
              {: screen}

3.  Examinez les règles réseau existantes.

    -   Examinez le noeud final d'hôte Calico.

      ```
      calicoctl get hostendpoint -o yaml
      ```
      {: pre}

    -   Examinez toutes les règles réseau Calico et Kubernetes créées pour le cluster. Cette liste inclut des règles qui n'ont peut-être pas encore été appliquées à des nacelles ou à des hôtes. Pour qu'une règle réseau soit mise en pratique, elle doit identifier une ressource Kubernetes correspondant au sélecteur défini dans la règle réseau
Calico.

      ```
      calicoctl get policy -o wide
      ```
      {: pre}

    -   Affichez les informations détaillées d'une règle réseau.

      ```
      calicoctl get policy -o yaml <policy_name>
      ```
      {: pre}

    -   Affichez les informations détaillées de toutes les règles réseau pour le cluster.

      ```
      calicoctl get policy -o yaml
      ```
      {: pre}

4.  Créez les règles réseau Calico afin d'autoriser ou de bloquer le trafic.

    1.  Définissez votre [règle réseau Calico![External link icon](../icons/launch-glyph.svg "External link icon")](http://docs.projectcalico.org/v2.1/reference/calicoctl/resources/policy) en créant un script de configuration (.yaml). Ces fichiers de configuration incluent les sélecteurs qui décrivent les nacelles, les espaces de nom, ou les hôtes, auxquels s'appliquent ces règles. Reportez-vous à ces [exemples de règles Calico![External link icon](../icons/launch-glyph.svg "External link icon")](http://docs.projectcalico.org/v2.0/getting-started/kubernetes/tutorials/advanced-policy) pour vous aider à créer vos propres règles.

    2.  Appliquez les règles au cluster.
        -   Linux et OS X :

          ```
          calicoctl apply -f <policy_file_name.yaml>
          ```
          {: pre}

        -   Windows :

          ```
          calicoctl apply -f <path_to_>/<policy_file_name.yaml> --config=<path_to_>/calicoctl.cfg
          ```
          {: pre}


## Images
{: #cs_security_deployment}

Gérez la sécurité et l'intégrité de vos images via des fonctions de sécurité intégrées.
{: shortdesc}

### Référentiel d'images Docker privé et sécurisé dans {{site.data.keyword.registryshort_notm}} :

 Vous pouvez mettre en place votre propre registre d'images Docker dans un registre d'images privé, à service partagé, haute disponibilité et évolutif, hébergé et géré par IBM, pour construire, stocker en sécurité et partager entre les utilisateurs du cluster vos images Docker.

### Conformité de l'image avec les règles de sécurité : 

En utilisant {{site.data.keyword.registryshort_notm}}, vous pouvez
exploiter la fonctionnalité intégrée d'analyse de sécurité offerte par Vulnerability Advisor Chaque image envoyée par commande push à votre espace de nom est automatiquement analysée pour détection de vulnérabilités face à une base de données
de problèmes CentOS, Debian, Red Hat et Ubuntu connus. si des vulnérabilités sont détectées, Vulnerability communique des instructions pour les résoudre et garantir l'intégrité et la sécurité de l'image.

Pour examiner l'évaluation des vulnérabilités de votre image, procédez comme suit :

1.  Dans le **catalogue**, sélectionnez **Conteneurs**.
2.  Sélectionnez l'image dont vous désirez consulter l'évaluation des vulnérabilités.
3.  Dans la section **Evaluation des vulnérabilités**, cliquez sur **Afficher le rapport**.
