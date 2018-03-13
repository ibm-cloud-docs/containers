---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-29"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# Configuration de la connectivité VPN
{: #vpn}

La connectivité VPN vous permet de connecter de manière sécurisée les applications d'un cluster Kubernetes à un réseau su site. Vous pouvez également connecter des applications externes au cluster à une application s'exécutant au sein de votre cluster.
{:shortdesc}

## Configuration de la connectivité VPN avec le diagramme Helm du service VPN Strongswan IPSec
{: #vpn-setup}

Pour définir une connectivité VPN, vous pouvez utiliser un digramme Helm pour configurer et déployer le [service VPN Strongswan IPSec ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://www.strongswan.org/) au sein d'un pod Kubernetes. Tous le trafic VPN est ensuite acheminé via ce pod. Pour plus d'informations sur les commandes Helm utilisées pour configurer le diagramme Strongswan, reportez-vous à la <a href="https://docs.helm.sh/helm/" target="_blank">documentation Helm<img src="../icons/launch-glyph.svg" alt="Icône de lien externe"></a>.
{:shortdesc}

Avant de commencer :

- [Créez un cluster standard.
](cs_clusters.html#clusters_cli)
- [Si vous utilisez un cluster existant, mettez-le à jour vers la version 1.7.4 ou ultérieure.](cs_cluster_update.html#master)
- Le cluster doit disposer au moins d'une adresse IP d'équilibreur de charge publique disponible.
- [Ciblez l'interface CLI de Kubernetes sur le cluster](cs_cli_install.html#cs_cli_configure).

Pour configurer une connectivité VPN avec Strongswan :

1. S'il n'est pas encore activé, installez et initialisez Helm sur votre cluster.

    1. Installez l'<a href="https://docs.helm.sh/using_helm/#installing-helm" target="_blank">interface de ligne de commande Helm  <img src="../icons/launch-glyph.svg" alt="Icône de lien externe"></a>.

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

3. Ouvrez le fichier `config.yaml` et apportez les modifications suivantes aux valeurs par défaut en fonction de la configuration VPN souhaitée. Si une propriété comporte des valeurs spécifiques parmi lesquelles vous pouvez choisir, ces valeurs sont répertoriées dans des commentaires au-dessus de chaque propriété dans le fichier. **Important** : si vous n'avez pas besoin de modifier une propriété, mettez celle-ci en commentaire en la précédant du signe `#`.

    <table>
    <caption>Description des composants du fichier YAML</caption>
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
    <td>Remplacez cette valeur par la liste des CIDR de sous-réseau de cluster à exposer sur la connexion VPN avec le réseau local. Cette liste peut inclure les sous-réseaux suivants : <ul><li>CIDR de sous-réseau du pod Kubernetes : <code>172.30.0.0/16</code></li><li>CIDR de sous-réseau du service Kubernetes : <code>172.21.0.0/16</code></li><li>Si vos applications sont exposées par un service NodePort sur le réseau privé, CIDR de sous-réseau privé du noeud worker. Pour identifier cette valeur, exécutez la commande <code>bx cs subnets | grep <xxx.yyy.zzz></code>, où <code>&lt;xxx.yyy.zzz&gt;</code> correspond aux trois premiers octets de l'adresse IP privée du noeud worker.</li><li>Si vous disposez d'applications exposées par des services LoadBalancer sur le réseau privé, CIDR de sous-réseau privé ou géré par l'utilisateur du cluster. Pour identifier cs valeurs, exécutez la commande <code>bx cs cluster-get <cluster name> --showResources</code>. Dans la section <b>VLANS</b>, recherchez des CIDR indiquant <code>false</code> pour <b>Public</b>.</li></ul></td>
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
    <td>Remplacez cette valeur par la liste des CIDR de sous-réseau privé sur site auxquels les clusters Kubernetes sont autorisés à accéder.</td>
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

    3. Vérifiez le statut du réseau privé virtuel. Un statut `Etabli` indique que la connexion VPN a abouti.

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
          - Il est probable que le statut du VPN n'indique pas `ESTABLISHED` la première fois que vous utilisez ce diagramme Helm. Vous aurez peut-être besoin de vérifier les paramètres de noeud final VPN sur site et de revenir plusieurs fois à l'étape 3 pour modifier le fichier `config.yaml` avant que la connexion n'aboutisse.
          - Si le pod VPN indique l'état `Erreur` ou continue à tomber en panne et à redémarrer, ceci peut être dû à une validation de paramètres dans le section `ipsec.conf` de la mappe de configuration du diagramme. Recherchez la présence d'erreurs de validation dans les journaux du pod Strongswan en exécutant la commande `kubectl logs -n kube-system $STRONGSWAN_POD`. S'il en existe, exécutez la commande `helm delete --purge vpn`, revenez à l'étape 3 pour corriger les valeurs incorrectes dans le fichier `config.yaml`, puis répétez les étapes 4 à 8. Si votre cluster comporte un grand nombre de noeuds worker, vous pouvez également utiliser la commande `helm upgrade` pour appliquer plus rapidement vos modifications au lieu d'exécuter les commandes `helm delete` et `helm install`.

    4. Une fois que le statut du VPN indique `Etabli`, testez la connexion avec une commande `ping`. L'exemple suivant envoie une sonde png depuis le pod VPN dans le cluster Kubernetes à l'adresse IP privée de la passerelle VPN sur site. Vérifiez que les valeurs correctes ont été spécifiées pour `remote.subnet` et `local.subnet` dans le fichier de configuration et que la liste de sous-réseaux locaux inclut l'adresse IP source depuis laquelle vous envoyez l'instruction.

        ```
        kubectl exec -n kube-system  $STRONGSWAN_POD -- ping -c 3  <on-prem_gateway_private_IP>
        ```
        {: pre}

### Désactivation du service de VPN Strongswan IPSec
{: vpn_disable}

1. Supprimez le diagramme Helm.

    ```
    helm delete --purge vpn
    ```
    {: pre}
