---

copyright:
  years: 2014, 2017
lastupdated: "2017-12-13"

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

## Sécurité par composant du cluster
{: #cs_security_cluster}

Chaque cluster {{site.data.keyword.containerlong_notm}} dispose de fonctions de sécurité intégrées dans ses noeuds [maître](#cs_security_master) et [worker](#cs_security_worker). Si vous disposez d'un pare-feu, avec d'accéder l'équilibrage de charge depuis l'extérieur du cluster, ou désirez exécuter des commandes `kubectl` depuis votre système local lorsque les règles de réseau d'entreprise empêchent l'accès à des noeuds finaux Internet publics, [ouvrez des ports sur votre pare-feu](#opening_ports). Si vous désirez connecter des applications de votre cluster à un réseau sur site ou à d'autres applications externes à votre cluster, [configurez votre connectivité VPN ](#vpn).
{: shortdesc}

Dans le diagramme suivant, vous voyez que les fonctions de sécurité sont regroupées par maître Kubernetes, noeuds d'agent et images de conteneur.

<img src="images/cs_security.png" width="400" alt="{{site.data.keyword.containershort_notm}} sécurité de cluster" style="width:400px; border-style: none"/>


  <table summary="La première ligne du tableau s'étend sur deux colonnes. Les autres lignes se lisent de gauche à droite. L'emplacement du serveur figure dans la première colonne et les adresses IP pour concordance dans la seconde colonne.">
  <caption>Tableau 1. Fonctions de sécurité</caption>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Paramètres de sécurité de cluster intégrés dans {{site.data.keyword.containershort_notm}}</th>
  </thead>
  <tbody>
    <tr>
      <td>Maître Kubernetes</td>
      <td>Le maître Kubernetes présent dans chaque cluster est géré par IBM et caractérisé par une haute disponibilité. Il inclut des paramètres de sécurité {{site.data.keyword.containershort_notm}} qui assurent la conformité aux règles de sécurité et une communication sécurisée vers et depuis les noeuds d'agent. Des mises à jour sont effectuées par
IBM chaque fois que nécessaire. Le maître Kubernetes dédié régit et surveille depuis une position centralisée toutes les ressources Kubernetes
dans le cluster. En fonction des exigences du déploiement et de la capacité du cluster, le maître Kubernetes planifie automatiquement le déploiement de vos applications conteneurisées entre les noeuds d'agent disponibles. Pour plus d'informations, voir [Sécurité du maître Kubernetes](#cs_security_master).</td>
    </tr>
    <tr>
      <td>Noeud worker</td>
      <td>Les conteneurs sont déployés sur des noeuds d'agent dédiés à un cluster et qui assurent l'isolement du traitement, du réseau et du stockage pour les clients IBM. {{site.data.keyword.containershort_notm}} dispose de fonctions de sécurité intégrées pour sécuriser vos noeuds d'agent sur le réseau privé et public et pour garantir la conformité des noeuds d'agent aux règles de sécurité. Pour plus d'informations, voir [Sécurité des noeuds d'agent](#cs_security_worker). De plus, vous pouvez ajouter des [règles réseau Calico](#cs_security_network_policies) pour spécifier le trafic réseau que vous voulez autoriser ou bloquer vers et depuis un pod d'un noeud worker. </td>
     </tr>
     <tr>
      <td>Images</td>
      <td>En tant qu'administrateur du cluster, vous pouvez configurer votre propre registre d'images Docker sécurisé dans {{site.data.keyword.registryshort_notm}} pour y stocker et partager avec vos utilisateurs du cluster des images Docker. Pour garantir des déploiements de conteneurs sécurisés, chaque image dans
votre registre privé est analysée par Vulnerability Advisor. Vulnerability Advisor est un composant d'{{site.data.keyword.registryshort_notm}} qui détecte des vulnérabilités potentielles, soumet des recommandations de sécurité et des instructions pour résoudre ces vulnérabilités. Pour plus d'informations, voir [Sécurité des images dans {{site.data.keyword.containershort_notm}}](#cs_security_deployment).</td>
    </tr>
  </tbody>
</table>

### Maître Kubernetes
{: #cs_security_master}

Examinez les fonctions de sécurité du maître Kubernetes intégré destinées à
protéger ce dernier et à sécuriser les communications réseau du cluster.
{: shortdesc}

<dl>
  <dt>Maître Kubernetes entièrement géré et dédié</dt>
    <dd>Chaque cluster Kubernetes dans {{site.data.keyword.containershort_notm}} est régi par un maître Kubernetes dédié géré par IBM dans un compte d'infrastructure IBM Cloud (SoftLayer) sous propriété IBM. Le maître Kubernetes est configuré avec les composants dédiés suivants qui ne sont pas partagés avec d'autres clients IBM.
    <ul><li>Magasin  de données etcd : stocke toutes les ressources Kubernetes d'un cluster, telles que services, déploiements et pods. Les éléments Kubernetes ConfigMaps et Secrets sont des données d'application stockées sous forme de paires clé-valeur afin de les utiliser dans une application s'exécutant dans un pod. Les données etcd sont stockées sur un disque géré par IBM et chiffré par TLS lors de leur envoi à un pod pour assurer l'intégrité et la protection des données.</li>
    <li>kube-apiserver : constitue le point d'entrée principal pour toutes les demandes du noeud worker au maître Kubernetes. Le serveur kube-apiserver valide et traite les demandes et a accès en lecture et écriture au magasin de données etcd.</li>
    <li>kube-scheduler : décide où déployer les pods en prenant en compte la capacité du compte et les besoins en performance, les contraintes des règles en matière de matériel et de logiciel, les spécifications d'anti-affinité, et les besoins de la charge de travail. Si aucun noeud worker ne correspond à ces exigences, le pod n'est pas déployé dans le cluster.</li>
    <li>kube-controller-manager : se charge de la surveillance des jeux de répliques et de la création de pods correspondants pour atteindre l'état désiré.</li>
    <li>OpenVPN : composant spécifique à {{site.data.keyword.containershort_notm}} permettant une connectivité réseau sécurisée pour toutes les communications du maître Kubernetes avec les noeuds d'agent.</li></ul></dd>
  <dt>Connectivité réseau TLS sécurisée pour toutes les communications du noeud worker avec le maître Kubernetes</dt>
    <dd>Pour sécuriser les communications réseau vers le maître Kubernetes, {{site.data.keyword.containershort_notm}} génère des certificats TLS qui chiffrent les communications vers et depuis le serveur kube-apiserver et les composant du magasin de données etcd pour chaque cluster. Ces certificats ne sont jamais partagés entre les clusters ou entre les composants du maître Kubernetes.</dd>
  <dt>Connectivité réseau OpenVPN sécurisée pour toutes les communications du maître Kubernetes vers les noeuds d'agent</dt>
    <dd>Bien que Kubernetes sécurise les communications entre le maître Kubernetes et les noeuds d'agent en utilisant le protocole
`https`, aucune authentification n'est fournie par défaut sur le noeud worker. Pour sécuriser ces communications, {{site.data.keyword.containershort_notm}} configure automatiquement une connexion OpenVPN
entre le maître Kubernetes et les noeuds d'agent lors de la création du cluster.</dd>
  <dt>Surveillance continue du réseau maître Kubernetes</dt>
    <dd>Chaque Kubernetes est surveillé en permanence par IBM pour identifier et contrer les attaques de type DOS
(Déni de service) au niveau des processus.</dd>
  <dt>Conformité de sécurité du noeud maître Kubernetes</dt>
    <dd>{{site.data.keyword.containershort_notm}} analyse automatiquement chaque noeud sur lequel le maître Kubernetes est déployé pour détecter des vulnérabilités affectant Kubernetes et identifier les correctifs de sécurité spécifiques au système d'exploitation devant être appliqués pour protection du noeud maître. Si des vulnérabilités sont détectées, {{site.data.keyword.containershort_notm}} applique automatiquement les correctifs appropriés et résout les vulnérabilités pour l'utilisateur.</dd>
</dl>

<br />


### Noeuds d'agent
{: #cs_security_worker}

Examinez les fonctions de sécurité de noeud worker intégrées destinées à protéger l'environnement de noeud worker et à assurer l'isolement des ressources, du réseau et du stockage.
{: shortdesc}

<dl>
  <dt>Isolement de l'infrastructure de traitement, réseau et de stockage</dt>
    <dd>Lorsque vous créez un cluster, des machines virtuelles sont allouées par IBM en tant que noeuds d'agent dans le compte d'infrastructure IBM Cloud (SoftLayer) ou dans le compte d'infrastructure IBM Cloud (SoftLayer) dédié. Les noeuds d'agent sont dédiés à un cluster et n'hébergent pas la charge de travail d'autres clusters.</br> Chaque compte {{site.data.keyword.Bluemix_notm}} est configuré avec des réseaux locaux virtuels d'infrastructure IBM Cloud (SoftLayer) pour garantir des performances réseau satisfaisantes et l'isolement des noeuds d'agent. </br>Pour rendre persistantes les données dans votre cluster, vous pouvez allouer un stockage de fichiers NFS dédié depuis l'infrastructure IBM Cloud (SoftLayer) et tirer parti des fonctions intégrées de sécurité des données de cette plateforme.</dd>
  <dt>Noeud worker sécurisé configuré</dt>
    <dd>Chaque noeud worker est configuré avec un système d'exploitation Ubuntu qui ne peut pas être modifié par l'utilisateur. Afin de protéger ce système d'exploitation face aux attaques potentielles, chaque noeud worker est configuré avec des paramètres de pare-feu avancés imposés par les règles iptable de Linux.</br> Tous les conteneurs s'exécutant sur Kubernetes sont protégés par des paramètres de règles réseau Calico prédéfinies qui sont configurées sur chaque noeud worker lors de la création du cluster. Cette configuration assure une communication réseau sécurisée entre les noeuds d'agent et les pods. Pour limiter davantage les actions qu'un conteneur peut effectuer sur le noeud worker, les utilisateurs peuvent choisir de configurer des [règles AppArmor ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/tutorials/clusters/apparmor/) sur les noeuds d'agent.</br> L'accès SSH est désactivé sur le noeud worker. Si vous souhaitez installer des fonctions supplémentaires sur votre noeud worker, vous pouvez utiliser des [jeux de démons Kubernetes ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset) pour tout ce que vous voulez exécuter sur chaque noeud worker, ou des [travaux Kubernetes ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/) pour les actions ponctuelles que vous devez exécuter.</dd>
  <dt>Conformité à la sécurité de noeud worker Kubernetes</dt>
    <dd>IBM collabore avec des équipes de conseil en sécurité, internes et externes, pour traiter les vulnérabilités de conformité aux règles de sécurité potentielles. IBM maintient l'accès aux noeuds en vue de déployer des correctifs de sécurité usr le système d'exploitation.</br> <b>Important</b> : Redémarrez vos noeuds d'agent régulièrement pour garantir l'installation des mises à jour et des correctifs de sécurité automatiquement déployés dans le système d'exploitation. IBM ne redémarre pas vos noeuds d'agent.</dd>
  <dt>Disque chiffré</dt>
  <dd>Par défaut, {{site.data.keyword.containershort_notm}} fournit deux partitions de données locales SSD chiffrées pour tous les noeuds worker lorsqu'il est provisionné. La première partition n'est pas chiffrée et la seconde partition montée sur _/var/lib/docker_ est déverrouillée lorsqu'elle est provisionnée à l'aide des clés de chiffrement LUKS. Chaque agent dans chaque cluster Kubernetes dispose de sa propre clé de chiffrement LUKS unique, gérée par {{site.data.keyword.containershort_notm}}. Lorsque vous créez un cluster ou ajoutez un noeud worker à un cluster existant, les clés sont extraites de manière sécurisée, puis ignorées une fois que le disque chiffré a été déverrouillé. <p><b>Remarque </b>: le chiffrement peut avoir une incidence sur les performances des E-S disque. Dans le cas de charges de travail exigeant de hautes performances des E-S, testez un cluster avec et sans chiffrement activé pour déterminer s'il convient de désactiver le chiffrement.</p>
  </dd>
  <dt>Support pour les pare-feux réseau d'infrastructure IBM Cloud (SoftLayer)</dt>
    <dd>{{site.data.keyword.containershort_notm}} est compatible avec toutes les [offres de pare-feu d'infrastructure IBM Cloud (SoftLayer) ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://www.ibm.com/cloud-computing/bluemix/network-security). Sur {{site.data.keyword.Bluemix_notm}} Public, vous pouvez mettre en place un pare-feu avec des règles réseau personnalisées afin de promouvoir une sécurité réseau dédiée pour votre cluster et de détecter et de parer à des intrusions réseau. Par exemple, vous pouvez choisir de configurer un [produit Vyatta ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://knowledgelayer.softlayer.com/topic/vyatta-1) qui agira en tant que pare-feu et bloquera le trafic indésirable. Lorsque vous configurez un pare-feu, [vous devez également ouvrir les adresses IP et les ports requis](#opening_ports) pour chaque région de manière à permettre au maître et aux noeuds d'agent de communiquer.</dd>
  <dt>Gardez privés les services ou exposez sélectivement des services et des applications à l'Internet public</dt>
    <dd>Vous pouvez décider de garder privés vos services et applications et d'exploiter les fonctions de sécurité intégrées décrites dans cette rubrique pour assurer une communication sécurisée entre les noeuds d'agent et les pods. Si vous désirez exposer des services et des applications sur l'Internet public, vous
pouvez exploiter la prise en charge d'Ingress et d'un équilibreur de charge pour rendre
vos services accessibles au public de manière sécurisée.</dd>
  <dt>Connectez de manière sécurisée vos noeuds worker et vos applications à un centre de données sur site </dt>
  <dd>Pour connecter vos noeuds worker et vos applications à un centre de données sus site, vous pouvez configurer un noeud final VPN IPSec avec un service Strongswan ou un dispositif de passerelle Vyatta ou un dispositif Fortigate.<br><ul><li><b>Service VPN Strongswan IPSec </b>: vous pouvez définir un [service VPN Strongswan IPSec ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.strongswan.org/) connectant de manière sécurisée votre cluster Kubernetes avec un réseau sur site. Le service VPN Strongswan IPSec fournit un canal de communication de bout en bout sécurisé sur Internet basé sur la suite de protocoles IPSec (Internet Protocol Security) aux normes du secteur. Pour configurer une connexion sécurisée entre votre cluster et un réseau sur site, vous devez disposer d'une passerelle IPsec VPN ou d'un serveur d'infrastructure IBM Cloud (SoftLayer) installés sur votre centre de données sur site. Vous pouvez ensuite [configurer et déployer le service Strongswan IPSec VPN](cs_security.html#vpn) dans un pod Kubernetes.</li><li><b>Dispositif de passerelle Vyatta ou dispositif Fortigate </b>: si vous disposez d'un cluster plus volumineux, vous pouvez choisir de mettre en place en  dispositif de passerelle Vyatta ou un dispositif Fortigate pour configurer un noeud final IPSec VPN. Pour plus d'informations, reportez-vous à cet article de blogue sur la [Connexion d'un cluster à un centre de données sur site![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/blogs/bluemix/2017/07/kubernetes-and-bluemix-container-based-workloads-part4/).</li></ul></dd>
  <dt>Consignation au journal et surveillance en continu de l'activité du cluster</dt>
    <dd>Dans le cas de clusters standard, tous les événements associés au cluster, comme l'ajout d'un noeud worker, la progression d'une mise à jour tournante ou les informations d'utilisation des capacités, peuvent être consignés et surveillés par {{site.data.keyword.containershort_notm}} et envoyés à {{site.data.keyword.loganalysislong_notm}} et à {{site.data.keyword.monitoringlong_notm}}. Pour plus d'informations sur la configuration  de la consignation et de la surveillance, voir [Configuration de journalisation de cluster](https://console.bluemix.net/docs/containers/cs_cluster.html#cs_logging) et [Configuration de la surveillance de cluster](https://console.bluemix.net/docs/containers/cs_cluster.html#cs_monitoring).</dd>
</dl>

### Images
{: #cs_security_deployment}

Gérez la sécurité et l'intégrité de vos images via des fonctions de sécurité intégrées.
{: shortdesc}

<dl>
<dt>Référentiel d'images Docker privé et sécurisé dans {{site.data.keyword.registryshort_notm}}</dt>
<dd>Vous pouvez mettre en place votre propre registre d'images Docker dans un registre d'images privé, à service partagé, haute disponibilité et évolutif, hébergé et géré par IBM, pour construire, stocker en sécurité et partager entre les utilisateurs du cluster vos images Docker.</dd>

<dt>Conformité de l'image avec les règles de sécurité</dt>
<dd>En utilisant {{site.data.keyword.registryshort_notm}}, vous pouvez
exploiter la fonctionnalité intégrée d'analyse de sécurité offerte par Vulnerability Advisor Chaque image envoyée par commande push à votre espace de nom est automatiquement analysée pour détection de vulnérabilités face à une base de données
de problèmes CentOS, Debian, Red Hat et Ubuntu connus. si des vulnérabilités sont détectées, Vulnerability communique des instructions pour les résoudre et garantir l'intégrité et la sécurité de l'image.</dd>
</dl>

Pour examiner l'évaluation des vulnérabilités de vos images, [consultez la documentation de l'assistant de détection des vulnérabilités](/docs/services/va/va_index.html#va_registry_cli).

<br />


## Ouverture des ports et adresses IP requis dans votre pare-feu
{: #opening_ports}

Examinez ces situations pour lesquelles vous aurez peut-être à ouvrir des ports et des adresses IP spécifiques dans vos pare-feux :
* [Pour exécuter des commandes `bx` commands](#firewall_bx) depuis votre système local lorsque les règles réseau de l'entreprise empêchent l'accès à des noeuds finaux Internet publics via des proxies ou des pare-feux.
* [Pour exécuter des commandes `kubectl`](#firewall_kubectl) depuis votre système local lorsque les règles réseau de l'entreprise empêchent l'accès à des noeuds finaux Internet publics via des proxies ou des pare-feux.
* [Pour exécuter des commandes `calicoctl` commands](#firewall_calicoctl) depuis votre système local lorsque les règles réseau de l'entreprise empêchent l'accès à des noeuds finaux Internet publics via des proxies ou des pare-feux. 
* [Pour autoriser la communication entre le maître Kubernetes et les noeuds worker ](#firewall_outbound)lorsqu'un pare-feu a été mis en place pour les noeuds worker ou que les paramètres du pare-feu ont été personnalisés dans votre compte IBM Cloud infrastructure (SoftLayer).
* [Pour accéder au service NodePort, au service LoasBalancer, ou à Ingress depuis l'extérieur du cluster](#firewall_inbound).

### Exécution  de commandes `bx cs` de derrière un pare-feu
{: #firewall_bx}

Si les règles réseau de l'entreprise empêchent l'accès depuis votre système à des noeuds finaux publics via des proxies ou des pare-feux, pour exécuter des commandes `bx cs`, vous devez autoriser l'accès TCP pour {{site.data.keyword.containerlong_notm}}.

1. Autorisez l'accès à `containers.bluemix.net` sur le port 443.
2. Vérifiez votre connexion. Si l'accès est configuré correctement, des navires sont affichés dans la sortie.
   ```
   curl https://containers.bluemix.net/v1/
   ```
   {: pre}

   Exemple de sortie :
   ```
                                     )___(
                              _______/__/_
                     ___     /===========|   ___
    ____       __   [\\\]___/____________|__[///]   __
    \   \_____[\\]__/___________________________\__[//]___
     \                                                    |
      \                                                  /
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

   ```
   {: screen}

### Exécution de commandes `kubectl` de derrière un pare-feu
{: #firewall_kubectl}

Si les règles réseau de l'entreprise empêchent l'accès depuis votre système à des noeuds finaux publics via des proxies ou des pare-feux, pour exécuter des commandes `kubectl`, vous devez autoriser l'accès TCP pour le cluster.

Lorsqu'un cluster est créé, le port dans l'URL maîtresse est affecté aléatoirement sur la plage 20000 à 32767. Vous pouvez choisir d'ouvrir la plage de ports 20000 à 32767 pour n'importe quel cluster pouvant être créé ou bien autoriser l'accès pour un cluster existant spécifique.

Avant de commencer, autorisez l'accès aux commandes [run `bx cs`](#firewall_bx).

Pour autoriser l'accès à un cluster spécifique :

1. Connectez-vous à l'interface de ligne de commande {{site.data.keyword.Bluemix_notm}}. A l'invite, entrez vos données d'identification {{site.data.keyword.Bluemix_notm}}. Si vous disposez d'un compte fédéré, incluez l'option `--sso`.

    ```
    bx login [--sso]
    ```
    {: pre}

2. Sélectionnez la région où réside votre cluster.

   ```
   bx cs region-set
   ```
   {: pre}

3. Obtenez le nom de votre cluster.

   ```
   bx cs clusters
   ```
   {: pre}

4. Extrayez la valeur **Master URL** pour votre cluster.

   ```
   bx cs cluster-get <cluster_name_or_id>
   ```
   {: pre}

   Exemple de sortie :
   ```
   ...
   Master URL:		https://169.46.7.238:31142
   ...
   ```
   {: screen}

5. Autorisez l'accès au **Master URL** sur le port (comme au port `31142` dans l'exemple précédent).

6. Vérifiez votre connexion. 

   ```
   curl --insecure <master_URL>/version
   ```
   {: pre}

   Exemple de commande :
   ```
   curl --insecure https://169.46.7.238:31142/version
   ```
   {: pre}

   Exemple de sortie :
   ```
   {
     "major": "1",
     "minor": "7+",
     "gitVersion": "v1.7.4-2+eb9172c211dc41",
     "gitCommit": "eb9172c211dc4108341c0fd5340ee5200f0ec534",
     "gitTreeState": "clean",
     "buildDate": "2017-11-16T08:13:08Z",
     "goVersion": "go1.8.3",
     "compiler": "gc",
     "platform": "linux/amd64"
   }
   ```
   {: screen}

7. Facultatif : répétez ces étapes pour chaque cluster que vous avec besoin d'exposer.

### Exécution de commandes `calicoctl` de derrière un pare-feu
{: #firewall_calicoctl}

Si les règles réseau de l'entreprise empêchent l'accès depuis votre système à des noeuds finaux publics via des proxies ou des pare-feux, pour exécuter des commandes `calicoctl`, vous devez autoriser l'accès TCP pour les commandes Calico.

Avant de commencer, autorisez l'accès pour exécution de commandes [`bx`](#firewall_bx) et [`kubectl`](#firewall_kubectl).

1. Extrayez l'adresse IP de l'URL maîtresse que vous avez utilisée pour autoriser les commandes that you used to allow the [`kubectl`](#firewall_kubectl).

2. Obtenez le port pour ETCD.

  ```
  kubectl get cm -n kube-system calico-config -o yaml | grep etcd_endpoints
  ```
  {: pre}

3. Autorisez l'accès pour les règles Calico via l'adresse IP et le port ETCD de l'URL maîtresse.

### Autorisation au cluster d'accéder aux ressources de l'infrastructure et à d'autres services
{: #firewall_outbound}

  1.  Notez l'adresse IP publique pour tous vos noeuds d'agent dans le cluster.

      ```
      bx cs workers <cluster_name_or_id>
      ```
      {: pre}

  2.  Autorisez le trafic entrant depuis la source _<each_worker_node_publicIP>_ vers la plage de ports TCP/UDP de destination 20000 à 32767 et le port 443, et aux adresses IP et groupes réseau suivants. Si un pare-feu d'entreprise empêche votre machine locale d'accéder à des noeuds finaux Internet publics, effectuez cette étape tant pour vos noeuds worker source que pour votre machine locale.
      - **Important** : vous devez autoriser le trafic sortant vers le port 443 pour tous les emplacements de la région afin d'équilibrer la charge lors du processus d'amorçage. Par exemple, si votre cluster se trouve au Sud des Etats-Unis, vous devez autoriser le trafic du port 443 vers les adresses IP de les emplacements (dal10, dal12 et dal13).
      <p>
  <table summary="La première ligne du tableau s'étend sur deux colonnes. Les autres lignes se lisent de gauche à droite. L'emplacement du serveur figure dans la première colonne et les adresses IP pour concordance dans la seconde colonne.">
      <thead>
      <th>Région</th>
      <th>Emplacement</th>
      <th>Adresse IP</th>
      </thead>
    <tbody>
      <tr>
        <td>Asie-Pacifique nord</td>
        <td>hkg02<br>tok02</td>
        <td><code>169.56.132.234</code><br><code>161.202.126.210</code></td>
       </tr>
      <tr>
         <td>Asie-Pacifique sud</td>
         <td>mel01<br>syd01<br>syd04</td>
         <td><code>168.1.97.67</code><br><code>168.1.8.195</code><br><code>130.198.64.19, 130.198.66.34</code></td>
      </tr>
      <tr>
         <td>Europe centrale</td>
         <td>ams03<br>fra02<br>mil01<br>par01</td>
         <td><code>169.50.169.106, 169.50.154.194</code><br><code>169.50.56.170, 169.50.56.174</code><br><code>159.122.190.98</code><br><code>159.8.86.149, 159.8.98.170</code></td>
        </tr>
      <tr>
        <td>Sud du Royaume-Uni</td>
        <td>lon02<br>lon04</td>
        <td><code>159.122.242.78</code><br><code>158.175.65.170, 158.175.74.170, 158.175.76.2</code></td>
      </tr>
      <tr>
        <td>Est des Etats-Unis</td>
         <td>tor01<br>wdc06<br>wdc07</td>
         <td><code>169.53.167.50</code><br><code>169.60.73.142</code><br><code>169.61.83.62</code></td>
      </tr>
      <tr>
        <td>Sud des Etats-Unis</td>
        <td>dal10<br>dal12<br>dal13</td>
        <td><code>169.47.234.18, 169.46.7.234</code><br><code>169.47.70.10</code><br><code>169.60.128.2</code></td>
      </tr>
      </tbody>
    </table>
</p>

  3.  Autorisez le trafic réseau sortant depuis les noeuds d'agent vers {{site.data.keyword.registrylong_notm}} :
      - `TCP port 443 FROM <each_worker_node_publicIP> TO <registry_publicIP>`
      - Remplacez <em>&lt;registry_publicIP&gt;</em> par toutes les adresses des régions du registre auxquelles vous voulez autoriser le trafic :
        <p>
<table summary="La première ligne du tableau s'étend sur deux colonnes. Les autres lignes se lisent de gauche à droite. L'emplacement du serveur figure dans la première colonne et les adresses IP pour concordance dans la seconde colonne.">
      <thead>
        <th>Région du conteneur</th>
        <th>Adresse du registre</th>
        <th>Adresse IP du registre</th>
      </thead>
      <tbody>
        <tr>
          <td>Asie-Pacifique nord, Asie-Pacifique sud</td>
          <td>registry.au-syd.bluemix.net</td>
          <td><code>168.1.45.160/27</code></br><code>168.1.139.32/27</code></td>
        </tr>
        <tr>
          <td>Europe centrale</td>
          <td>registry.eu-de.bluemix.net</td>
          <td><code>169.50.56.144/28</code></br><code>159.8.73.80/28</code></td>
         </tr>
         <tr>
          <td>Sud du Royaume-Uni</td>
          <td>registry.eu-gb.bluemix.net</td>
          <td><code>159.8.188.160/27</code></br><code>169.50.153.64/27</code></td>
         </tr>
         <tr>
          <td>Est des Etats-Unis, Sud des Etats-Unis</td>
          <td>registry.ng.bluemix.net</td>
          <td><code>169.55.39.112/28</code></br><code>169.46.9.0/27</code></br><code>169.55.211.0/27</code></td>
         </tr>
        </tbody>
      </table>
</p>

  4.  Facultatif : autorisez le trafic réseau sortant depuis les noeuds d'agent vers les services {{site.data.keyword.monitoringlong_notm}} et {{site.data.keyword.loganalysislong_notm}} :
      - `TCP port 443, port 9095 FROM <each_worker_node_publicIP> TO <monitoring_publicIP>`
      - Remplacez <em>&lt;monitoring_publicIP&gt;</em> par toutes les adresses des régions de surveillance auxquelles vous voulez autoriser le trafic :
        <p><table summary="La première ligne du tableau s'étend sur deux colonnes. Les autres lignes se lisent de gauche à droite. L'emplacement du serveur figure dans la première colonne et les adresses IP pour concordance dans la seconde colonne.">
        <thead>
        <th>Région du conteneur</th>
        <th>Adresse de surveillance</th>
        <th>Adresses IP de surveillance</th>
        </thead>
      <tbody>
        <tr>
         <td>Europe centrale</td>
         <td>metrics.eu-de.bluemix.net</td>
         <td><code>159.122.78.136/29</code></td>
        </tr>
        <tr>
         <td>Sud du Royaume-Uni</td>
         <td>metrics.eu-gb.bluemix.net</td>
         <td><code>169.50.196.136/29</code></td>
        </tr>
        <tr>
          <td>Est des Etats-Unis, Sud des Etats-Unis, Asie-Pacifique nord</td>
          <td>metrics.ng.bluemix.net</td>
          <td><code>169.47.204.128/29</code></td>
         </tr>
         
        </tbody>
      </table>
</p>
      - `TCP port 443, port 9091 FROM <each_worker_node_publicIP> TO <logging_publicIP>`
      - Remplacez <em>&lt;logging_publicIP&gt;</em> par toutes les adresses de journalisation auxquelles vous voulez autoriser le trafic :
        <p><table summary="La première ligne du tableau s'étend sur deux colonnes. Les autres lignes se lisent de gauche à droite. L'emplacement du serveur figure dans la première colonne et les adresses IP pour concordance dans la seconde colonne.">
        <thead>
        <th>Région du conteneur</th>
        <th>Adresse de journalisation</th>
        <th>Adresses IP de journalisation</th>
        </thead>
        <tbody>
          <tr>
            <td>Est des Etats-Unis, Sud des Etats-Unis</td>
            <td>ingest.logging.ng.bluemix.net</td>
            <td><code>169.48.79.236</code><br><code>169.46.186.113</code></td>
           </tr>
          <tr>
           <td>Europe centrale, Sud du Royaume-Uni</td>
           <td>ingest-eu-fra.logging.bluemix.net</td>
           <td><code>158.177.88.43</code><br><code>159.122.87.107</code></td>
          </tr>
          <tr>
           <td>Asie-Pacifique sud, Asie-Pacifique nord</td>
           <td>ingest-au-syd.logging.bluemix.net</td>
           <td><code>130.198.76.125</code><br><code>168.1.209.20</code></td>
          </tr>
         </tbody>
       </table>
</p>

  5. Dans le cas de pare-feux privés, autorisez les plages d'adresses IP privées d'infrastructure IBM Cloud (SoftLayer) appropriées. Consultez [ce lien](https://knowledgelayer.softlayer.com/faq/what-ip-ranges-do-i-allow-through-firewall) en commençant par la section **Backend (private) Network**.
      - Ajoutez tous les [emplacements dans les régions](cs_regions.html#locations) que vous utilisez.
      - Notez que vous devez ajouter l'emplacement dal01 (centre de données).
      - Ouvrez les ports 80 et 443 pour permettre le processus d'amorçage de cluster.

  6. Pour créer des réservations de volume persistant pour le stockage de données, permettez un accès sortant via votre pare-feu aux [adresses IP d'IBM Cloud infrastructure (SoftLayer)](https://knowledgelayer.softlayer.com/faq/what-ip-ranges-do-i-allow-through-firewall) de l'emplacement (centre de données) où réside votre cluster.
      - Pour déterminer l'emplacement (centre de données) de votre cluster, exécutez la commande `bx cs clusters`.
      - Autorisez l'accès à la plage d'adresses IP tant pour le réseau **Frontend (public) network** que **Backend (privé)**.
      - Notez que vous devez ajouter l'emplacement dal01 (centre de données) pour le réseau **Backend (privé)**.

### Accès à NodePort, à l'équilibreur de charge et aux services Ingress de l'extérieur du cluster
{: #firewall_inbound}

Vous pouvez autoriser l'accès entrant au NodePort, à l'équilibreur de charge et aux services Ingress.

<dl>
  <dt>Service NodePort</dt>
  <dd>Ouvrez le port que vous avez configuré lorsque vous avez déployé le service sur les adresses IP publiques pour tous les noeuds worker vers lesquels autoriser le trafic. Pour identifier le port, exécutez la commande `kubectl get svc`. Le port est situé sur la plage 20000 à 32000.<dd>
  <dt>Service LoadBalancer</dt>
  <dd>Ouvrez le port que vous avez configuré lorsque vous avez déployé le service sur l'adresse IP publique du service d'équilibrage de charge.</dd>
  <dt>Ingress</dt>
  <dd>Ouvrez le port 80 pour HTTP ou le port 443 pour HTTPS vers l'adresse IP de l'équilibreur de charge d'application Ingress.</dd>
</dl>

<br />


## Configuration d'une connectivité VPN avec le diagramme Helm du service Strongswan IPSec VPN
{: #vpn}

La connectivité VPN vous permet de connecter de manière sécurisée les applications d'un cluster Kubernetes à un réseau su site. Vous pouvez également connecter des applications externes au cluster à une application s'exécutant au sein de votre cluster. Pour définir une connectivité VPN, vous pouvez utiliser un digramme Helm pour configurer et déployer le [service VPN Strongswan IPSec ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.strongswan.org/) au sein d'un pod Kubernetes. Tous le trafic VPN est ensuite acheminé via ce pod. Pour plus d'informations sur les commandes Helm utilisées pour configurer le diagramme Strongswan, reportez-vous à la [Documentation Helm ![External link icon](../icons/launch-glyph.svg "External link icon")](https://docs.helm.sh/helm/).

Avant de commencer :

- [Créez un cluster standard.](cs_cluster.html#cs_cluster_cli)
- [Si vous utilisez un cluster existant, mettez-le à jour vers la version 1.7.4 ou ultérieure.](cs_cluster.html#cs_cluster_update)
- Le cluster doit disposer au moins d'une adresse IP d'équilibreur de charge publique disponible.
- [Ciblez l'interface CLI de Kubernetes sur le cluster](cs_cli_install.html#cs_cli_configure).

Pour configurer une connectivité VPN avec Strongswan :

1. S'il n'est pas encore activé, installez et initialisez Helm sur votre cluster.

    1. [Installez l'interface de ligne de commande Helm ![External link icon](../icons/launch-glyph.svg "External link icon")](https://docs.helm.sh/using_helm/#installing-helm).

    2. Initialisez Helm et installez `tiller`.

        ```
        helm init
        ```
        {: pre}

    3. Vérifiez que le statut du pod `tiller-deploy` indique `En cours d'exécution` dans votre cluster.

        ```
        kubectl get pods -n kube-system -l app=helm
        ```
        {: pre}

        Exemple de sortie :

        ```
        NAME                            READY     STATUS    RESTARTS   AGE
        tiller-deploy-352283156-nzbcm   1/1       Running   0          10m
        ```
        {: screen}

    4. Ajoutez le référentiel {{site.data.keyword.containershort_notm}} Helm à votre instance Helm.

        ```
        helm repo add bluemix  https://registry.bluemix.net/helm
        ```
        {: pre}

    5. Vérifiez que le diagramme Strongswan est répertorié dans le référentiel Helm.

        ```
        helm search bluemix
        ```
        {: pre}

2. Enregistrer les paramètres de configuration par défaut pour le diagramme Helm Strongswan dans un fichier YAML local.

    ```
    helm inspect values bluemix/strongswan > config.yaml
    ```
    {: pre}

3. Ouvrez le fichier `config.yaml` et apportez les modifications suivantes aux valeurs par défaut en fonction de la configuration VPN souhaitée. Si une propriété a des valeurs qui ont été définies, elles sont répertoriées en commentaires au-dessus de chaque propriété dans le fichier. **Important** : si vous n'avez pas besoin de modifier une propriété, mettez celle-ci en commentaire en la précédant du signe `#`.

    <table>
    <caption>Tableau 2. Description des composants du fichier YAML</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code>overRideIpsecConf</code></td>
    <td>Si vous disposez d'un fichier <code>ipsec.conf</code> existant que vous désirez utiliser, supprimez les accolades (<code>{}</code>) et ajoutez le contenu de votre fichier après cette propriété. Le contenu du fichier doit être mis en retrait. **Remarque :** si vous utilisez votre propre fichier, les éventuelles valeurs des sections <code>ipsec</code>, <code>local</code> et <code>remote</code> ne sont pas utilisées.</td>
    </tr>
    <tr>
    <td><code>overRideIpsecSecrets</code></td>
    <td>Si vous disposez d'un fichier <code>ipsec.secrets</code> existant que vous désirez utiliser, supprimez les accolades (<code>{}</code>) et ajoutez le contenu de votre fichier après cette propriété. Le contenu du fichier doit être mis en retrait. **Remarque :** si vous utilisez votre propre fichier, les éventuelles valeurs de la section <code>preshared</code> ne sont pas utilisées.</td>
    </tr>
    <tr>
    <td><code>ipsec.keyexchange</code></td>
    <td>Si le noeud final de tunnel VPN sur site ne gère pas le protocole <code>ikev2</code> pour initialisation de la connexion, remplacez cette valeur par <code>ikev1</code>.</td>
    </tr>
    <tr>
    <td><code>ipsec.esp</code></td>
    <td>Remplacez cette valeur par la liste des algorithmes de chiffrement/authentification ESP qu'utilise votre noeud final de tunnel VPN sur site pour la connexion.</td>
    </tr>
    <tr>
    <td><code>ipsec.ike</code></td>
    <td>Remplacez cette valeur par la liste des algorithmes de chiffrement/authentification IKE/ISAKMP SA  qu'utilise votre noeud final de tunnel VPN sur site pour la connexion.</td>
    </tr>
    <tr>
    <td><code>ipsec.auto</code></td>
    <td>Si vous désirez que le cluster initialise la connexion VPN, remplacez cette valeur par <code>start</code>.</td>
    </tr>
    <tr>
    <td><code>local.subnet</code></td>
    <td>Remplacez cette valeur par la liste des CIDR de sous-réseau de cluster à exposer sur la connexion VPN avec le réseau local. Cette liste peut inclure les sous-réseaux suivants : <ul><li>CIDR de sous-réseau du pod Kubernetes : <code>172.30.0.0/16</code></li><li>CIDR de sous-réseau du service Kubernetes : <code>172.21.0.0/16</code></li><li>Si vous disposez d'applications exposées par un service NodePort sur le réseau privé, le CIDR de sous-réseau privé du noeud worker. Pour identifier cette valeur, exécutez la commande <code>bx cs subnets | grep <xxx.yyy.zzz></code>, où &lt;xxx.yyy.zzz&gt; correspond aux trois premiers octets de l'adresse IP privée du noeud worker.</li><li>Si vous disposez d'applications exposées par des services LoadBalancer sur le réseau privé, CIDR de sous-réseau priévé ou géré par l'utilisateur du cluster. Pour identifier cs valeurs, exécutez la commande <code>bx cs cluster-get <cluster name> --showResources</code>. Dans la section <b>VLANS</b>, recherchez des CIDRs indiquant <code>false</code> pour <b>Public</b>. </li></ul></td>
    </tr>
    <tr>
    <td><code>local.id</code></td>
    <td>Remplacez cette valeur par l'identificateur chaîne côté cluster Kubernetes local utilisé par votre noeud final de tunnel VPN pour la connexion.</td>
    </tr>
    <tr>
    <td><code>remote.gateway</code></td>
    <td>Remplacez cette valeur par l'adresse IP publique de la passerelle VPN sur site.</td>
    </tr>
    <td><code>remote.subnet</code></td>
    <td>Remplacez cette valeur par la liste des CIDR de sous-réseau privé sur site auxquels le cluster Kubernetes est autorisé à accéder.</td>
    </tr>
    <tr>
    <td><code>remote.id</code></td>
    <td>Remplacez cette valeur par l'identificateur chaîne côté sur site distant que votre noeud final de tunnel VPN utilise pour la connexion.</td>
    </tr>
    <tr>
    <td><code>preshared.secret</code></td>
    <td>Remplacez cette valeur par la valeur confidentielle pré-partagée que votre passerelle de noeud final de tunnel VPN utilise pour la connexion.</td>
    </tr>
    </tbody></table>

4. Enregistrez le fichier `config.yaml` mis à jour.

5. Installez le diagramme Helm sur votre cluster avec le fichier `config.yaml` mis à jour. Les propriétés mises à jour sont stockées dans une mappe de configuration pour votre diagramme.

    ```
    helm install -f config.yaml --namespace=kube-system --name=vpn bluemix/strongswan
    ```
    {: pre}

6. Vérifiez le statut de déploiement du diagramme. Lorsque le diagramme est prêt, la zone **Statut** vers le haut de la sortie indique `Déployé`.

    ```
    helm status vpn
    ```
    {: pre}

7. Une fois le diagramme déployé, vérifiez que les paramètres mis à jour dans le fichier `config.yaml` ont été utilisés.

    ```
    helm get values vpn
    ```
    {: pre}

8. Testez la nouvelle connectivité VPN.
    1. Si le réseau privé virtuel sur la passerelle sur site n'est pas actif, démarrez le réseau privé virtuel.

    2. Définissez ma variable d'environnement `STRONGSWAN_POD`.

        ```
        export STRONGSWAN_POD=$(kubectl get pod -n kube-system -l app=strongswan,release=vpn -o jsonpath='{ .items[0].metadata.name }')
        ```
        {: pre}

    3. Vérifiez le staut du réseau privé virtuel. Un statut `Etabli` indique que la connexion VPN a abouti.

        ```
        kubectl exec -n kube-system  $STRONGSWAN_POD -- ipsec status
        ```
        {: pre}

        Exemple de sortie :
        ```
        Security Associations (1 up, 0 connecting):
            k8s-conn[1]: ESTABLISHED 17 minutes ago, 172.30.244.42[ibm-cloud]...192.168.253.253[on-prem]
            k8s-conn{2}:  INSTALLED, TUNNEL, reqid 12, ESP in UDP SPIs: c78cb6b1_i c5d0d1c3_o
            k8s-conn{2}:   172.21.0.0/16 172.30.0.0/16 === 10.91.152.128/26
        ```
        {: screen}

        **Remarque **:
          - Il est fort probable que le statut du VPN n'indique pas `Etabli` la première fois que vous utilisez ce diagramme Helm. Vous aurez peut-être besoin de vérifier les paramètres de neoud final VPN sur site et de revenir plusieurs fois à l'étape 3 pour modifier le fichier `config.yaml` avant que la connexion n'aboutisse.
          - Si le pod VPN indique l'état `Erreur` ou continue à tomber en panne et à redémarrer, ceci peut être dû , à une validation de paramètres dans le section `ipsec.conf` de la mappe de configuration du diagramme. Pour savoir si tel est la cas, recherchez la présence d'erreurs de validation dans les journaux du pod Strongswan en exécutant la commande `kubectl logs -n kube-system $STRONGSWAN_POD`. En cas d'erreurs de validation, exécutez la commande `helm delete --purge vpn`, revenez à l'étape 3 pour corriger les valeurs incorrectes dans le fichier `config.yaml`, et répétez les étapes 4 à 8. Si votre cluster comporte un grand nombre de noeuds worker, vous pouvez également utiliser la commande `helm upgrade` pour appliquer rapidement vos modifications au lieu d'exécuter les commandes `helm delete` et `helm install`.

    4. Une fois que le statut du VPN indique `Etabli`, testez la connexion avec une commande `ping`. L'exemple suivant envoie une sonde png depuis le pod VPN dans le cluster Kubernetes à l'adresse IP privée de la passerelle VPN sur site. Vérifiez que les valeurs correctes ont été spécifiées pour `remote.subnet` et `local.subnet` dans le fichier de configuration et que la liste de sous-réseaux locaux inclut l'adrese IP source depuis laquelle vous envoyez l'instruction.

        ```
        kubectl exec -n kube-system  $STRONGSWAN_POD -- ping -c 3  <on-prem_gateway_private_IP>
        ```
        {: pre}

Pour désactiver le service VPN Strongswan IPSec :

1. Supprimez le diagramme Helm.

    ```
    helm delete --purge vpn
    ```
    {: pre}

<br />


## Règles réseau
{: #cs_security_network_policies}

Chaque cluster Kubernetes est installé avec un plug-in réseau nommé Calico. Des règles réseau par défaut sont mises en place pour sécuriser
l'interface réseau publique de chaque noeud worker. Vous pouvez exploiter
Calico et les fonctionnalités Kubernetes natives pour configurer des règles réseau supplémentaires pour un cluster si vous avez des exigences de sécurité particulières. Ces règles réseau spécifient le trafic réseau que vous désirez autoriser ou bloquer vers et depuis un pod d'un cluster.
{: shortdesc}

Vous avez le choix entre la fonctionnalités Calico et les fonctionnalités Kubernetes natives pour créer des règles réseau pour votre cluster. Vous pouvez utiliser les règles réseau Kubernetes pour débuter, mais pour des capacités plus robustes, utilisez les règles réseau Calico.

<ul>
  <li>[Règles réseau Kubernetes ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/concepts/services-networking/network-policies/) : quelques options élémentaires sont fournies, comme la possibilité de spécifier quels pods peuvent communiquer entre eux. Le trafic réseau entrant peut être autorisé ou bloqué pour un protocole et un port donnés. Ce trafic peut être filtré en fonction des libellés et des espaces de nom Kubernetes du pod qui tente de se connecter à d'autres pods.</br>Ces règles peuvent être appliquées par le biais de commandes
`kubectl` ou d'API Kubernetes. Lorsque ces règles sont appliquées, elles sont converties en règles réseau
Calico et mises en vigueur par Calico.</li>
  <li>[Règles réseau Calico![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](http://docs.projectcalico.org/v2.4/getting-started/kubernetes/tutorials/advanced-policy) : ces règles sont un sur-ensemble des règles réseau Kubernetes et optimisent les capacités Kubernetes natives en leur ajoutant les fonctionnalités suivantes.</li>
    <ul><ul><li>Autorisation ou blocage du trafic réseau sur des interfaces réseau spécifiques, et non pas seulement le trafic des pods Kubernetes.</li>
    <li>Autorisation ou blocage de trafic réseau entrant (ingress) et sortant (egress).</li>
    <li>[Blocage de trafic (ingress) entrant vers les services Kubernetes LoadBalancer ou NodePort](#cs_block_ingress).</li>
    <li>Autorisation ou blocage de trafic sur la base d'une adresse IP ou CIDR source ou de destination.</li></ul></ul></br>

Ces règles sont appliquées via les commandes `calicoctl`. Calico met en vigueur ces règles, y-compris les éventuelles règles réseau
Kubernetes converties en règles Calico, en configurant des règles Linux iptables sur les noeuds d'agent Kubernetes. Les règles iptables font office de pare-feu pour le noeud worker en définissant les caractéristiques que le trafic réseau doit respecter pour être acheminé à la ressource ciblée.</ul>


### Configuration de règles par défaut
{: #concept_nq1_2rn_4z}

Lorsqu'un cluster est créé, des règles réseau par défaut sont automatiquement configurées pour l'interface réseau publique de chaque noeud public afin de limiter le trafic entrant d'un noeud worker depuis l'Internet public. Ces règles n'affectent pas le trafic entre les pods et sont mises en place pour permettre l'accès aux services Kubernetest Nodeport, Loadbalancer et Ingress.

Des règles par défaut ne sont pas appliquées aux pods directement, mais à l'interface réseau publique d'un noeud worker à l'aide d'un noeud final d'hôte Calico. Quand un noeud final d'hôte est créé dans Calico, tout le trafic vers et depuis l'interface réseau publique de ce noeud worker est bloqué, sauf s'il est autorisé par une règle.

**Important :** prenez soin de ne pas supprimer de règles qui sont appliquées à un noeud final d'hôte à moins de comprendre parfaitement la règle et de savoir que vous n'avez pas besoin du trafic qui est autorisé par cette règle.


 <table summary="La première ligne du tableau s'étend sur deux colonnes. Les autres lignes se lisent de gauche à droite. L'emplacement du serveur figure dans la première colonne et les adresses IP pour concordance dans la seconde colonne.">
 <caption>Tableau 3. Règles par défaut pour chaque cluster</caption>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Règles par défaut pour chaque cluster</th>
  </thead>
  <tbody>
    <tr>
      <td><code>allow-all-outbound</code></td>
      <td>Autorise tout le trafic sortant.</td>
    </tr>
    <tr>
      <td><code>allow-bixfix-port</code></td>
      <td>Autorise le trafic entrant sur le port 52311 vers l'application bigfix à accepter les mises à jour de noeud worker nécessaires.</td>
    </tr>
    <tr>
      <td><code>allow-icmp</code></td>
      <td>Autorise tous les paquets icmp entrants (pings).</td>
     </tr>
    <tr>
      <td><code>allow-node-port-dnat</code></td>
      <td>Autorise le trafic entrant du service nodeport, d'équilibrage de charge et Ingress service vers les ports que ces
services exposent. Notez que le port que ces services exposent sur l'interface publique n'a pas besoin d'être spécifié puisque Kubernetes utilise la conversion d'adresse de réseau de destination (DNAT) pour réacheminer ces demandes de service aux pods corrects. Ce réacheminement intervient avant de les règles de noeud final d'hôte soient appliquées dans des iptables.</td>
   </tr>
   <tr>
      <td><code>allow-sys-mgmt</code></td>
      <td>Autorise les connexions entrantes pour des systèmes d'infrastructure IBM Cloud (SoftLayer) spécifiques utilisés pour gérer les noeuds d'agent.</td>
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

Avant de commencer :

1.  [Installez les interfaces CLI de {{site.data.keyword.containershort_notm}} et de Kubernetes.](cs_cli_install.html#cs_cli_install)
2.  [Créez un cluster léger ou standard.](cs_cluster.html#cs_cluster_ui)
3.  [Ciblez l'interface CLI de Kubernetes sur le cluster](cs_cli_install.html#cs_cli_configure). Incluez l'option `--admin` avec la commande `bx cs
cluster-config`, laquelle est utilisée pour télécharger les fichiers de certificat et d'autorisations. Ce téléchargement inclut également les clés pour le rôle Superutilisateur, dont vous aurez besoin pour exécuter des commandes Calico.

  ```
  bx cs cluster-config <cluster_name> --admin
  ```
  {: pre}

  **Remarque** : L'interface CLI Calico version 1.6.1 est prise en charge.

Pour ajouter des règles réseau, procédez comme suit :
1.  Installez l'interface CLI de Calico.
    1.  [Téléchargez l'interface CLI de Calico ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://github.com/projectcalico/calicoctl/releases/tag/v1.6.1).

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
              mv /<path_to_file>/calicoctl-darwin-amd64 /usr/local/bin/calicoctl
              ```
              {: pre}

        2.  Rendez le fichier exécutable.

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

    1.  Pour Linux et OS X, créez le répertoire `/etc/calico`. Pour Windows, vous pouvez utiliser n'importe quel répertoire.

      ```
      sudo mkdir -p /etc/calico/
      ```
      {: pre}

    2.  Créez un fichier `calicoctl.cfg`.
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
        {: codeblock}

        1.  Extrayez la valeur `<ETCD_URL>`. En cas d'échec de cette commande avec l'erreur `calico-config not found`, consultez cette [rubrique de traitement des incidents](cs_troubleshoot.html#cs_calico_fails).

          -   Linux et OS X :

              ```
              kubectl get cm -n kube-system calico-config -o yaml | grep "etcd_endpoints:" | awk '{ print $2 }'
              ```
              {: pre}

          -   Exemple de sortie :

              ```
              https://169.1.1.1:30001
              ```
              {: screen}

          -   Windows :
            <ol>
            <li>Récupérez les valeurs de configuration calico dans la mappe de configuration. </br><pre class="codeblock"><code>kubectl get cm -n kube-system calico-config -o yaml</code></pre></br>
            <li>Dans la section `data`, localisez la valeur etcd_endpoints. Exemple : <code>https://169.1.1.1:30001</code>
            </ol>

        2.  Extrayez le répertoire `<CERTS_DIR>` dans lequel les certificats Kubernetes sont téléchargés.

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
              ls `dirname $KUBECONFIG` | grep "ca-"
              ```
              {: pre}

            -   Windows :
              <ol><li>Ouvrez le répertoire extrait à la dernière étape.</br><pre class="codeblock"><code>C:\Users\<user>\.bluemix\plugins\container-service\&lt;cluster_name&gt;-admin\</code></pre>
              <li> Localisez le fichier <code>ca-*pem_file</code>.</ol>

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

    -   Examinez toutes les règles réseau Calico et Kubernetes créées pour le cluster. Cette liste inclut des règles qui n'ont peut-être pas encore été appliquées à des pods ou à des hôtes. Pour qu'une règle réseau soit mise en pratique, elle doit identifier une ressource Kubernetes correspondant au sélecteur défini dans la règle réseau
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

    1.  Définissez votre [règle réseau Calico![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](http://docs.projectcalico.org/v2.1/reference/calicoctl/resources/policy) en créant un script de configuration (.yaml). Ces fichiers de configuration incluent les sélecteurs qui décrivent les pods, les espaces de nom ou les hôtes, auxquels s'appliquent ces règles. Reportez-vous à ces [exemples de règles Calico![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](http://docs.projectcalico.org/v2.0/getting-started/kubernetes/tutorials/advanced-policy) pour vous aider à créer vos propres règles.

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

### Blocage du trafic entrant vers les services LoadBalancer ou NodePort.
{: #cs_block_ingress}

Par défaut, les services Kubernetes `NodePort` et `LoadBalancer` sont conçus pour rendre accessible votre application sur toutes les interfaces de cluster publiques et privées. Vous pouvez toutefois bloquer le trafic entrant vers vos services en fonction de la source ou de la destination du trafic. Pour bloquer le trafic, créez des règles réseau `preDNAT` Calico.

Un service Kubernetes LoadBalancer est également un service NodePort. Un service LoadBalancer rend accessible votre application via l'adresse IP et le port de l'équilibreur de charge et la rend accessible via le ou les ports de noeud du service. Les ports de noeud sont accessibles sur toutes les adresses IP (publiques et privées) pour tous les noeuds figurant dans le cluster.

L'administrateur du cluster peut utiliser des règles réseau `preDNAT` Calico pour bloquer :

  - Le trafic vers les services NodePort. Le trafic vers les services LoadBalancer est autorisé.
  - Le trafic basé sur un adresse source ou CIDR.

Quelques utilisations classiques des règles réseau `preDNAT` Calico :

  - Bloquer le trafic vers des ports de noeud publics d'un service LoadBalancer privé.
  - Bloquer le trafic vers des ports de noeud publics sur des clusters qui exécutent des [noeuds d'agent de périphérie](#cs_edge). Le blocage des ports de noeud garantit que les noeuds d'agent de périphérie sont les seuls noeuds d'agent à traiter le trafic entrant.

Les règles réseau `preDNAT` sont pratiques car les règles par défaut de Kubernetes et Calico sont difficiles à appliquer pour protéger les services Kubernetes NodePort et LoadBalancer en raison des règles iptables DNAT générées pour ces services.

Les règles réseau `preDNAT` de Calico génèrent des règles iptables en fonction d'une [ressource de règle réseau Calico
 ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://docs.projectcalico.org/v2.4/reference/calicoctl/resources/policy).

1. Définissez une règle réseau `preDNAT` de Calico pour l'accès entrant aux services Kubernetes.

  Exemple de blocage de tous les ports de noeud :

  ```
  apiVersion: v1
  kind: policy
  metadata:
    name: deny-kube-node-port-services
  spec:
    preDNAT: true
    selector: ibm.role in { 'worker_public', 'master_public' }
    ingress:
    - action: deny
      protocol: tcp
      destination:
        ports:
        - 30000:32767
    - action: deny
      protocol: udp
      destination:
        ports:
        - 30000:32767
  ```
  {: codeblock}

2. Appliquez la règle réseau preDNAT de Calico. Comptez environ 1 minute pour que les modifications de règle
soient appliquées dans tout le cluster.

  ```
  calicoctl apply -f deny-kube-node-port-services.yaml
  ```
  {: pre}

<br />



## Restriction du trafic réseau aux noeuds d'agent de périphérie
{: #cs_edge}

Ajoutez l'étiquette `dedicated=edge` à deux noeuds d'agent ou plus de votre cluster par garantir que Ingress et les équilibreurs de charge sont déployés uniquement sur ces noeuds d'agent.

Les noeuds d'agent de périphérie peuvent améliorer la sécurité de votre cluster en limitant les accès aux noeuds d'agent depuis l'extérieur et en isolant la charge de travail du réseau. Lorsque ces noeuds d'agent sont marqués pour mise en réseau uniquement, les autres charges de travail ne peuvent pas consommer d'unité centrale ou de mémoire ni interférer avec le réseau.

Avant de commencer :

- [Créez un cluster standard.](cs_cluster.html#cs_cluster_cli)
- Vérifiez que votre cluster dispose d'au moins un VLAN public. Les noeuds d'agent de périphérie ne sont pas disponibles pour les clusters avec VLAN privés uniquement.
- [Ciblez l'interface CLI de Kubernetes sur le cluster](cs_cli_install.html#cs_cli_configure).


1. Répertoriez tous les noeuds d'agent présents dans votre cluster. Utilisez l'adresse IP privée de la colonne **NAME** pour identifier les noeuds. Sélectionnez au moins deux noeuds d'agent comme noeuds d'agent de périphérie. L'utilisation d'au moins deux noeuds d'agent améliore la disponibilité des ressource de mise en réseau.

  ```
  kubectl get nodes -L publicVLAN,privateVLAN,dedicated
  ```
  {: pre}

2. Etiquetez les noeuds d'agent `dedicated=edge`. Une fois qu'un noeud worker est marqué avec `dedicated=edge`, tous les équilibreurs de charge et Ingress suivants sont déployés sur un noeud worker de périphérie.

  ```
  kubectl label nodes <node_name> <node_name2> dedicated=edge
  ```
  {: pre}

3. Extrayez tous les services d'équilibreur de charge de votre cluster.

  ```
  kubectl get services --all-namespaces -o jsonpath='{range .items[*]}kubectl get service -n {.metadata.namespace} {.metadata.name} -o yaml | kubectl apply -f - :{.spec.type},{end}' | tr "," "\n" | grep "LoadBalancer" | cut -d':' -f1
  ```
  {: pre}

  Sortie :

  ```
  kubectl get service -n <namespace> <name> -o yaml | kubectl apply -f
  ```
  {: screen}

4. A partir de la sortie de l'étape précédente, copiez et collez chaque ligne `kubectl get service`. Cette commande redéploie l'équilibreur de charge sur un noeud worker de périphérie. Seuls les équilibreurs de charge publics ont besoin d'être redéployés.

  Sortie :

  ```
  service "<name>" configured
  ```
  {: screen}

Vous avez étiqueté des noeuds d'agent avec `dedicated=edge` et redéployé tous les équilibreurs de charge et Ingress existants sur les noeuds d'agent de périphérie. Ensuite, empêchez d'autres[charges de travail de s'exécuter sur des noeuds d'agent de périphérie](#cs_edge_workloads) et [bloquez le trafic entrant vers des ports de noeud sur des noeuds d'agent](#cs_block_ingress).

### Empêcher l'exécution de charges de travail sur des noeuds d'agent de périphérie
{: #cs_edge_workloads}

L'un des avantages des noeuds d'agent de périphérie est qu'ils peuvent être définis pour n'exécuter que des services de mise en réseau. La tolérance `dedicated=edge` implique que tous les services d'équilibreur de charge et Ingress sont déployés uniquement sur les noeuds d'agent étiquetés. Toutefois, pour empêcher d'autres charges de travail de s'exécuter sur des noeuds d'agent de périphérie et de consommer des ressources de noeud worker, vous devez utiliser une [annotation Kubernetes taints![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/).

1. Répertoriez tous les noeuds d'agent étiquetés `edge`.

  ```
  kubectl get nodes -L publicVLAN,privateVLAN,dedicated -l dedicated=edge
  ```
  {: pre}

2. Appliquez à chaque noeud worker une annotation taint qui empêche l'exécution des pods sur le noeud worker et qui supprime du noeud worker ceux qui n'ont pas l'étiquette `edge`. Les pods supprimés sont redéployés sur d'autres noeuds d'agent dont la capacité le permet.

  ```
  kubectl taint node <node_name> dedicated=edge:NoSchedule dedicated=edge:NoExecute
  ```

Maintenant, seuls les pods ayant la tolérance `dedicated=edge` sont déployés sur vos noeuds d'agent de périphérie.
