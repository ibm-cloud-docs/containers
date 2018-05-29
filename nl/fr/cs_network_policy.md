---

copyright:
  years: 2014, 2018
lastupdated: "2018-4-20"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# Contrôle du trafic à l'aide de règles réseau
{: #network_policies}

Chaque cluster Kubernetes est installé avec un plug-in réseau nommé Calico. Des règles réseau par défaut sont mises en place pour sécuriser l'interface réseau publique de chaque noeud worker dans {{site.data.keyword.containerlong}}.
{: shortdesc}

Vous pouvez exploiter Calico et les fonctionnalités Kubernetes natives pour configurer des règles réseau supplémentaires pour un cluster si vous avez des exigences de sécurité particulières. Ces règles réseau spécifient le trafic réseau que vous désirez autoriser ou bloquer vers et depuis un pod dans un cluster. Vous pouvez utiliser les règles réseau Kubernetes pour débuter, mais pour des capacités plus robustes, utilisez les règles réseau Calico.

<ul>
  <li>[Règles réseau Kubernetes ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/concepts/services-networking/network-policies/) : quelques options élémentaires sont fournies, comme la possibilité de spécifier quels pods peuvent communiquer entre eux. Le trafic réseau entrant peut être autorisé ou bloqué pour un protocole et un port donnés. Ce trafic peut être filtré en fonction des libellés et des espaces de nom Kubernetes du pod qui tente de se connecter à d'autres pods.</br>Ces règles peuvent être appliquées par le biais de commandes `kubectl` ou d'API Kubernetes. Lorsque ces règles sont appliquées, elles sont converties en règles réseau Calico et mises en vigueur par Calico.</li>
  <li>[Règles réseau Calico![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](http://docs.projectcalico.org/v2.6/getting-started/kubernetes/tutorials/advanced-policy) : ces règles sont un sur-ensemble des règles réseau Kubernetes et optimisent les capacités Kubernetes natives en leur ajoutant les fonctionnalités suivantes.</li>
    <ul><ul><li>Autorisation ou blocage du trafic réseau sur des interfaces réseau spécifiques, et non pas seulement le trafic des pods Kubernetes.</li>
    <li>Autorisation ou blocage de trafic réseau entrant (ingress) et sortant (egress).</li>
    <li>[Blocage de trafic (ingress) entrant vers les services Kubernetes LoadBalancer ou NodePort](#block_ingress).</li>
    <li>Autorisation ou blocage de trafic sur la base d'une adresse IP ou CIDR source ou de destination.</li></ul></ul></br>

Ces règles sont appliquées via les commandes `calicoctl`. Calico met en vigueur ces règles, y-compris les éventuelles règles réseau Kubernetes converties en règles Calico, en configurant des règles Linux iptables sur les noeuds worker Kubernetes. Les règles iptables font office de pare-feu pour le noeud worker en définissant les caractéristiques que le trafic réseau doit respecter pour être acheminé vers la ressource ciblée.</ul>

<br />


## Configuration de règles par défaut
{: #default_policy}

Lorsqu'un cluster est créé, des règles réseau par défaut sont définies pour l'interface réseau publique de chaque noeud worker afin de limiter le trafic entrant depuis le réseau Internet public. Ces règles n'affectent pas le trafic entre les pods et permettent l'accès aux services Nodeport, LoadBalancer et Ingress de Kubernetes.
{:shortdesc}

Des règles par défaut ne sont pas appliquées aux pods directement, mais à l'interface réseau publique d'un noeud worker à l'aide d'un noeud final d'hôte Calico. Quand un noeud final d'hôte est créé dans Calico, tout le trafic vers et depuis l'interface réseau publique de ce noeud worker est bloqué, sauf s'il est autorisé par une règle.

**Important :** prenez soin de ne pas supprimer de règles qui sont appliquées à un noeud final d'hôte à moins de comprendre parfaitement la règle et de savoir que vous n'avez pas besoin du trafic qui est autorisé par cette règle.


 <table summary="La première ligne du tableau s'étend sur deux colonnes. Les autres lignes se lisent de gauche à droite. L'emplacement du serveur figure dans la première colonne et les adresses IP pour concordance dans la seconde colonne.">
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
      <td>Autorise le trafic entrant du service nodeport, d'équilibrage de charge et Ingress service vers les ports que ces services exposent. Notez que le port que ces services exposent sur l'interface publique n'a pas besoin d'être spécifié puisque Kubernetes utilise la conversion d'adresse de réseau de destination (DNAT) pour réacheminer ces demandes de service aux pods corrects. Ce réacheminement intervient avant de les règles de noeud final d'hôte soient appliquées dans des iptables.</td>
   </tr>
   <tr>
      <td><code>allow-sys-mgmt</code></td>
      <td>Autorise les connexions entrantes pour des systèmes d'infrastructure IBM Cloud (SoftLayer) spécifiques utilisés pour gérer les noeuds worker.</td>
   </tr>
   <tr>
    <td><code>allow-vrrp</code></td>
    <td>Autorise les paquets vrrp, lesquels sont utilisés pour suivi et déplacement d'adresses IP virtuelles entre noeuds worker.</td>
   </tr>
  </tbody>
</table>

<br />


## Ajout de règles réseau
{: #adding_network_policies}

Dans la plupart des cas, les règles par défaut n'ont pas besoin d'être modifiées. Seuls les scénarios avancés peuvent demander des modifications. Si vous constatez que vous devez apporter des modifications, installez l'interface de ligne de commande de Calico et créez vos propres règles réseau.
{:shortdesc}

Avant de commencer :

1.  [Installez les interfaces CLI de {{site.data.keyword.containershort_notm}} et de Kubernetes.](cs_cli_install.html#cs_cli_install)
2.  [Créez un cluster gratuit ou standard.](cs_clusters.html#clusters_ui)
3.  [Ciblez l'interface CLI de Kubernetes sur le cluster](cs_cli_install.html#cs_cli_configure). Incluez l'option `--admin` avec la commande `bx cs cluster-config`, laquelle est utilisée pour télécharger les fichiers de certificat et d'autorisations. Ce téléchargement inclut également les clés pour le rôle Superutilisateur, dont vous aurez besoin pour exécuter des commandes Calico.

  ```
  bx cs cluster-config <cluster_name> --admin
  ```
  {: pre}

  **Remarque** : L'interface CLI Calico version 1.6.1 est prise en charge.

Pour ajouter des règles réseau, procédez comme suit :
1.  Installez l'interface CLI de Calico.
    1.  [Téléchargez l'interface CLI de Calico ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://github.com/projectcalico/calicoctl/releases/tag/v1.6.1).

        **Astuce :** si vous utilisez Windows, installez l'interface CLI de Calico dans le même répertoire que l'interface CLI d'{{site.data.keyword.Bluemix_notm}}. Cette configuration vous évite diverses modifications de chemin de fichier lorsque vous exécuterez des commandes plus tard.

    2.  Utilisateurs OSX et Linux : procédez comme suit.
        1.  Déplacez le fichier exécutable vers le répertoire /usr/local/bin.
            -   Linux :

              ```
              mv filepath/calicoctl /usr/local/bin/calicoctl
              ```
              {: pre}

            -   OS X :

              ```
              mv filepath/calicoctl-darwin-amd64 /usr/local/bin/calicoctl
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

    4.  Si les règles réseau de l'entreprise empêchent l'accès depuis votre système à des noeuds finaux publics via des proxies ou des pare-feux, voir [Exécution de commandes `calicoctl` derrière un pare-feu](cs_firewall.html#firewall) pour les instructions d'autorisation d'accès TCP pour les commandes Calico.

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

        1.  Extrayez la valeur `<ETCD_URL>`. En cas d'échec de cette commande avec l'erreur `calico-config not found`, consultez cette [rubrique de traitement des incidents](cs_troubleshoot_network.html#cs_calico_fails).

          -   Linux et OS X :

              ```
              kubectl get cm -n kube-system calico-config -o yaml | grep "etcd_endpoints:" | awk '{ print $2 }'
              ```
              {: pre}

          -   Exemple de sortie :

              ```
              https://169.xx.xxx.xxx:30001
              ```
              {: screen}

          -   Windows :
            <ol>
            <li>Récupérez les valeurs de configuration calico dans la mappe de configuration. </br><pre class="codeblock"><code>kubectl get cm -n kube-system calico-config -o yaml</code></pre></br>
            <li>Dans la section `data`, localisez la valeur etcd_endpoints. Exemple : <code>https://169.xx.xxx.xxx:30001</code>
            </ol>

        2.  Extrayez la valeur `<CERTS_DIR>` dans lequel les certificats Kubernetes sont téléchargés.

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
              C:/Users/<user>/.bluemix/plugins/container-service/mycluster-admin/kube-config-prod-dal10-mycluster.yml
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
              calicoctl get nodes --config=filepath/calicoctl.cfg
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

    1.  Définissez votre [règle réseau Calico![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](http://docs.projectcalico.org/v2.6/reference/calicoctl/resources/policy) en créant un script de configuration (.yaml). Ces fichiers de configuration incluent les sélecteurs qui décrivent les pods, les espaces de nom ou les hôtes, auxquels s'appliquent ces règles. Reportez-vous à ces [exemples de règles Calico![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](http://docs.projectcalico.org/v2.6/getting-started/kubernetes/tutorials/advanced-policy) pour vous aider à créer vos propres règles.

    2.  Appliquez les règles au cluster.
        -   Linux et OS X :

          ```
          calicoctl apply -f policy.yaml
          ```
          {: pre}

        -   Windows :

          ```
          calicoctl apply -f filepath/policy.yaml --config=filepath/calicoctl.cfg
          ```
          {: pre}

<br />


## Blocage du trafic entrant vers les services LoadBalancer ou NodePort.
{: #block_ingress}

Par défaut, les services Kubernetes `NodePort` et `LoadBalancer` sont conçus pour rendre accessible votre application sur toutes les interfaces de cluster publiques et privées. Vous pouvez toutefois bloquer le trafic entrant vers vos services en fonction de la source ou de la destination du trafic.
{:shortdesc}

Un service Kubernetes LoadBalancer est également un service NodePort. Un service LoadBalancer rend accessible votre application via l'adresse IP et le port de l'équilibreur de charge et la rend accessible via le ou les ports de noeud du service. Les ports de noeud sont accessibles sur toutes les adresses IP (publiques et privées) pour tous les noeuds figurant dans le cluster.

L'administrateur du cluster peut utiliser des règles réseau `preDNAT` Calico pour bloquer :

  - Le trafic vers les services NodePort. Le trafic vers les services LoadBalancer est autorisé.
  - Le trafic basé sur un adresse source ou CIDR.

Quelques utilisations classiques des règles réseau `preDNAT` Calico :

  - Bloquer le trafic vers des ports de noeud publics d'un service LoadBalancer privé.
  - Bloquer le trafic vers des ports de noeud publics sur des clusters qui exécutent des [noeuds worker de périphérie](cs_edge.html#edge). Le blocage des ports de noeud garantit que les noeuds worker de périphérie sont les seuls noeuds worker à traiter le trafic entrant.

Les règles réseau `preDNAT` sont pratiques car les règles par défaut de Kubernetes et Calico sont difficiles à appliquer pour protéger les services Kubernetes NodePort et LoadBalancer en raison des règles iptables DNAT générées pour ces services.

Les règles réseau `preDNAT` de Calico génèrent des règles iptables en fonction d'une [ressource de règle réseau Calico ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://docs.projectcalico.org/v2.6/reference/calicoctl/resources/policy).

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

