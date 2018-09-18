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


# Configuration de la connectivité VPN
{: #vpn}

La connectivité VPN vous permet de connecter de manière sécurisée les applications d'un cluster Kubernetes sur {{site.data.keyword.containerlong}} à un réseau sur site. Vous pouvez également connecter des applications externes au cluster à une application s'exécutant au sein de votre cluster.
{:shortdesc}

Pour connecter vos noeuds worker et vos applications à un centre de données sur site, vous pouvez configurer l'une des options suivantes.

- **Service VPN IPSec strongSwan** : vous pouvez définir un [service VPN IPSec strongSwan ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://www.strongswan.org/about.html) connectant de manière sécurisée votre cluster Kubernetes avec un réseau sur site. Le service VPN IPSec strongSwan fournit un canal de communication de bout en bout sécurisé sur Internet, basé sur l'ensemble de protocoles IPSec (Internet Protocol Security) aux normes de l'industrie. Pour configurer une connexion sécurisée entre votre cluster et un réseau sur site, [configurez et déployez le service VPN IPSec strongSwan](#vpn-setup) directement dans un pod de votre cluster.

- **Dispositif de routeur virtuel (VRA) ou dispositif de sécurité Fortigate (FSA)** : vous pouvez choisir de configurer un dispositif [VRA](/docs/infrastructure/virtual-router-appliance/about.html) ou [FSA](/docs/infrastructure/fortigate-10g/about.html) pour configurer un point de terminaison VPN IPSec. Cette option est pratique si vous disposez d'un cluster plus important, si vous souhaitez accéder à plusieurs clusters via un seul réseau privé virtuel (VPN) ou si vous avez besoin d'un VPN à base de routes. Pour configurer un dispositif de routeur virtuel (VRA), voir la rubrique sur la [configuration d'une connectivité VPN avec un dispositif VRA](#vyatta).

## Utilisation d'une charte Helm du service VPN IPSec strongSwan
{: #vpn-setup}

Utilisez une charte Helm pour configurer et déployer le service VPN IPsec strongSwan à l'intérieur d'un pod Kubernetes.
{:shortdesc}

Etant donné que strongSwan est intégré dans votre cluster, vous n'avez pas besoin d'un dispositif de passerelle externe. Lorsque la connectivité VPN est établie, des routes sont automatiquement configurées sur tous les noeuds worker dans le cluster. Ces routes permettent d'établir une connectivité bidirectionnelle via le tunnel VPN entre les pods d'un noeud worker et le système distant. Par exemple, le diagramme suivant illustre comment une application dans {{site.data.keyword.containershort_notm}} peut communiquer avec un serveur sur site par le biais d'une connexion VPN strongSwan :

<img src="images/cs_vpn_strongswan.png" width="700" alt="Exposition d'une application dans {{site.data.keyword.containershort_notm}} à l'aide d'un équilibreur de charge" style="width:700px; border-style: none"/>

1. Une application dans votre cluster nommée `myapp` reçoit une demande d'un service Ingress ou LoadBalancer et nécessite une connexion sécurisée aux données de votre réseau sur site.

2. La demande effectuée auprès du centre de données sur site est transmise au pod VPN strongSwan IPSec. L'adresse IP de destination est utilisée pour déterminer quels sont les paquets réseau à envoyer au pod VPN strongSwan IPSec.

3. La demande est chiffrée et envoyée via le tunnel VPN au centre de données sur site.

4. La demande entrante passe par le pare-feu local et est distribuée sur le point de terminaison du tunnel VPN (routeur) où elle est déchiffrée.

5. Le point de terminaison du tunnel VPN (routeur) transfère la demande au serveur sur site ou au mainframe, en fonction de l'adresse IP de destination qui a été indiquée à l'étape 2. Les données nécessaires sont renvoyées via la connexion VPN à `myapp` en utilisant le même processus.

## Remarques relatives au service VPN strongSwan
{: strongswan_limitations}

Avant d'utiliser une charte Helm strongSwan, consultez les remarques et limitations suivantes.

* La charte Helm strongSwan nécessite une conversion NAT transversale pour être activée par le terminal VPN distant. Une conversion NAT transversale nécessite le port UDP 4500 en plus du port par défaut UDP IPSec 500. Ces deux ports UDP doivent être autorisés via un pare-feu configuré.
* La charte Helm strongSwan ne prend pas en charge les VPN IPsec à base de routes.
* La charte Helm strongSwan prend en charge les VPN IPSec utilisant des clés pré-partagées, mais pas les VPN IPSec nécessitant des certificats.
* La charte Helm strongSwan n'autorise pas plusieurs clusters et d'autres ressources IaaS à partager une connexion VPN unique.
* La charte Helm strongSwan s'exécute sous forme de pod Kubernetes à l'intérieur du cluster. Les performances du VPN sont affectées par l'utilisation de la mémoire et du réseau de Kubernetes et des autres pods qui s'exécutent dans le cluster. Si vous disposez d'un environnement exigeant en termes de performances, envisagez l'utilisation d'une solution VPN qui s'exécute en dehors du cluster sur du matériel dédié.
* La charte Helm strongSwan exécute un seul pod VPN comme terminaison de tunnel IPSec. En cas de défaillance du pod, le cluster redémarre un pod. Cependant, vous risquez de faire face à une courte période d'indisponibilité lors du redémarrage du nouveau pod et du rétablissement de la connexion VPN. Si vous nécessitez une reprise sur incident plus rapide ou une solution à haute disponibilité plus élaborée, envisagez l'utilisation d'une solution VPN qui s'exécute en dehors du cluster sur du matériel dédié.
* La charte Helm strongSwan ne fournit pas de métriques ou de surveillance du trafic réseau circulant via la connexion VPN. Pour obtenir la liste des outils de surveillance pris en charge, voir [Services de consignation et de surveillance](cs_integrations.html#health_services).

## Configuration de la charte Helm strongSwan
{: #vpn_configure}

Avant de commencer :
* [Installez une passerelle VPN IPsec dans votre centre de données sur site](/docs/infrastructure/iaas-vpn/set-up-ipsec-vpn.html#setting-up-an-ipsec-connection).
* [Créez un cluster standard](cs_clusters.html#clusters_cli).
* [Ciblez l'interface CLI de Kubernetes sur le cluster](cs_cli_install.html#cs_cli_configure).

### Etape 1 : Obtenez la charte Helm strongSwan
{: #strongswan_1}

1. [Installez Helm pour votre cluster et ajoutez le référentiel {{site.data.keyword.Bluemix_notm}} dans votre instance Helm](cs_integrations.html#helm).

2. Sauvegardez les paramètres de configuration par défaut pour la charte Helm strongSwan dans un fichier YAML local.

    ```
    helm inspect values ibm/strongswan > config.yaml
    ```
    {: pre}

3. Ouvrez le fichier `config.yaml`.

### Etape 2 : Configurez les paramètres de base IPSec
{: #strongswan_2}

Pour contrôler si la connexion VPN est établie, modifiez les paramètres de base IPSec suivants.

Pour plus d'informations sur chacun de ces paramètres, lisez la documentation fournie dans le fichier `config.yaml` de la charte Helm.
{: tip}

1. Si votre point de terminaison de tunnel VPN sur site ne prend pas en charge `ikev2` comme protocole d'initialisation de la connexion, remplacez la valeur de `ipsec.keyexchange` par `ikev1` ou `ike`.
2. Définissez `ipsec.esp` par une liste d'algorithmes de chiffrement et d'authentification ESP utilisés par votre point de terminaison de tunnel VPN pour la connexion.
    * Si `ipsec.keyexchange` est défini avec `ikev1`, ce paramètre doit être spécifié.
    * Si `ipsec.keyexchange` est défini avec `ikev2`, ce paramètre est facultatif.
    * Si vous laissez ce paramètre vide, les algorithmes strongSwan par défaut `aes128-sha1,3des-sha1` sont utilisés pour la connexion.
3. Définissez `ipsec.ike` par une liste d'algorithmes de chiffrement et d'authentification IKE/ISAKMP utilisés par votre point de terminaison de tunnel VPN pour la connexion. Ces algorithmes doivent être spécifiés au format `encryption-integrity[-prf]-dhgroup`.
    * Si `ipsec.keyexchange` est défini avec `ikev1`, ce paramètre doit être spécifié.
    * Si `ipsec.keyexchange` est défini avec `ikev2`, ce paramètre est facultatif.
    * Si vous laissez ce paramètre vide, les algorithmes strongSwan par défaut `aes128-sha1-modp2048,3des-sha1-modp1536` sont utilisés pour la connexion.
4. Remplacez la valeur de `local.id` par une chaîne de votre choix que vous voulez utiliser pour identifier le côté du cluster Kubernetes local utilisé par votre point de terminaison de tunnel VPN. La valeur par défaut est `ibm-cloud`. Certaines mises en oeuvre de VPN nécessitent l'utilisation de l'adresse IP publique du point de terminaison local.
5. Remplacez la valeur de `remote.id` par une chaîne de votre choix que vous voulez utiliser pour identifier le côté du site distant utilisé par votre point de terminaison de tunnel VPN. La valeur par défaut est `on-prem`. Certaines mises en oeuvre de VPN nécessitent l'utilisation de l'adresse IP publique du point de terminaison distant.
6. Remplacez la valeur `preshared.secret` par la valeur confidentielle pré-partagée que votre passerelle de point de terminaison de tunnel VPN utilise pour la connexion. Cette valeur est stockée dans `ipsec.secrets`.
7. Facultatif : définissez `remote.privateIPtoPing` avec une adresse IP privée du sous-réseau distant à interroger par commande ping dans le cadre du test de validation de connectivité Helm.

### Etape 3 : Sélectionnez une connexion VPN entrante ou sortante
{: #strongswan_3}

Lorsque vous configurez une connexion VPN strongSwan, vous déterminez si la connexion VPN est une connexion entrant dans le cluster ou sortant du cluster.
{: shortdesc}

<dl>
<dt>Connexion entrante</dt>
<dd>Le point de terminaison VPN sur site du réseau distant initie la connexion VPN et le cluster est à l'écoute de la connexion.</dd>
<dt>Connexion sortante</dt>
<dd>Le cluster initie la connexion VPN, et le point de terminaison VPN sur site du réseau distant est à l'écoute de la connexion.</dd>
</dl>

Pour établir une connexion VPN entrante, modifiez les paramètres suivants :
1. Vérifiez que le paramètre `ipsec.auto` est défini avec la valeur `add`.
2. Facultatif : définissez  `loadBalancerIP` avec une adresse IP publique portable pour le service VPN strongSwan. La spécification d'une adresse IP est utile lorsque vous avez besoin d'une adresse IP stable, par exemple lorsque vous devez désigner quelles sont les adresses IP autorisées via un pare-feu local. Le cluster doit disposer d'au moins une adresse IP d'équilibreur de charge publique disponible. [Vous pouvez vérifier quelles sont vos adresses IP publiques disponibles](cs_subnets.html#review_ip) ou [libérer une adresse IP utilisée](cs_subnets.html#free).<br>**Remarque **:
    * Si vous laissez ce paramètre vide, une des adresses IP publiques portables disponibles est utilisée. 
    * Vous devez également configurer l'adresse IP publique que vous sélectionnez ou l'adresse IP publique affectée pour le point de terminaison VPN du cluster sur le point de terminaison VPN sur site.

Pour établir une connexion VPN sortante, modifiez les paramètres suivants :
1. Remplacez `ipsec.auto` par `start`.
2. Définissez `remote.gateway` avec l'adresse IP publique du point de terminaison VPN sur site du réseau distant.
3. Sélectionnez l'une des options suivantes pour l'adresse IP du point de terminaison VPN du cluster :
    * **Adresse IP publique de la passerelle privée du cluster** : si vos noeuds worker sont connectés à un VLAN privé uniquement, la demande de VPN sortante est acheminée vers la passerelle privée pour accéder à Internet. L'adresse IP publique de la passerelle privée est utilisée pour la connexion VPN.
    * **Adresse IP publique du noeud worker sur lequel s'exécute le pod strongSwan** : si le noeud worker sur lequel s'exécute le pod strongSwan est connecté à un VLAN public, l'adresse IP publique du noeud worker est utilisée pour la connexion VPN .
        <br>**Remarque **:
        * Si le pod strongSwan est supprimé ou replanifié sur un autre noeud worker du cluster, l'adresse IP publique du VPN change. Le point de terminaison VPN sur site du réseau distant doit autoriser l'établissement de la connexion VPN à partir d'une adresse IP publique de n'importe quel noeud worker du cluster.
        * Si le point de terminaison VPN distant ne peut pas traiter les connexions VPN à partir de plusieurs adresses IP publiques, limitez le nombre de noeuds sur lesquels le pod VPN strongSwan se déploie. Définissez `nodeSelector` avec les adresses IP des noeuds worker spécifiques ou avec le libellé d'un noeud worker. Par exemple, la valeur `kubernetes.io/hostname: 10.232.xx.xx` autorise le pod VPN à se déployer uniquement sur ce noeud worker. La valeur `strongswan: vpn` limite l'exécution du pod aux noeuds worker ayant ce libellé. Vous pouvez utiliser n'importe quel libellé de noeud worker. Pour autoriser l'utilisation d'autres noeuds worker avec différents déploiements de charte Helm, utilisez `strongswan: <release_name>`. Pour garantir la haute disponibilité, sélectionnez au moins deux noeuds worker.
    * **Adresse IP publique du service strongSwan** : pour établir la connexion à l'aide d'une adresse IP du service VPN strongSwan, définissez `connectUsingLoadBalancerIP` avec la valeur `true`. L'adresse IP du service strongSwan est une adresse IP publique portable que vous pouvez spécifier dans le paramètre `loadBalancerIP` ou une adresse IP publique portable disponible qui est automatiquement affectée au service.
        <br>**Remarque **:
        * Si vous optez pour la sélection d'une adresse IP à l'aide du paramètre `loadBalancerIP`, le cluster doit disposer d'au moins une adresse IP du service LoadBalancer public. [Vous pouvez vérifier quelles sont vos adresses IP publiques disponibles](cs_subnets.html#review_ip) ou [libérer une adresse IP utilisée](cs_subnets.html#free).
        * Tous les noeuds worker du cluster doivent se trouver dans le même VLAN public. Sinon, vous devez utiliser le paramètre `nodeSelector` pour vous assurer que le pod VPN se déploie sur un noeud worker du même VLAN public que l'adresse IP `loadBalancerIP`.
        * Si `connectUsingLoadBalancerIP` est défini avec la valeur `true` et `ipsec.keyexchange` avec la valeur `ikev1`, vous devez définir `enableServiceSourceIP` avec la valeur `true`.

### Etape 4 : Accéder aux ressources du cluster via la connexion VPN
{: #strongswan_4}

Déterminez les ressources du cluster qui doivent être accessibles au réseau distant via la connexion VPN.
{: shortdesc}

1. Ajoutez les routages CIDR d'un ou de plusieurs sous-réseaux du cluster dans le paramètre `local.subnet`. Vous devez configurer les CIDR des sous-réseaux locaux sur le point de terminaison VPN sur site. Cette liste peut inclure les sous-réseaux suivants :  
    * CIDR de sous-réseau du pod Kubernetes : `172.30.0.0/16`. La communication bidirectionnelle est activée entre les pods du cluster et un hôte figurant dans les sous-réseaux distants que vous avez répertoriés dans le paramètre `remote.subnet`. Si, pour des raisons de sécurité, vous devez empêcher l'un des hôtes de sous-réseau distant (`remote.subnet`) d'accéder aux pods du cluster, n'ajoutez pas le sous-réseau de pod Kubernetes dans le paramètre `local.subnet`.
    * CIDR de sous-réseau du service Kubernetes : `172.21.0.0/16`. Les adresses IP du service permettent d'exposer plusieurs pods d'application déployés sur plusieurs noeud worker derrière une seule adresse IP.
    * Si vos applications sont exposées par un service NodePort sur le réseau privé ou sur un équilibreur de charge d'application (ALB) Ingress privé, ajoutez le CIDR de sous-réseau privé du noeud worker. Récupérez les trois premiers octets de l'adresse IP privée de votre noeud worker en exécutant la commande `ibmcloud ks worker <cluster_name>`. Par exemple, pour l'adresse IP `10.176.48.xx`, notez `10.176.48`. Obtenez ensuite, le CIDR de sous-réseau privé du noeud worker à l'aide de la commande suivante en remplaçant `<xxx.yyy.zz>` par les octets que vous avez extraits précédemment : `ibmcloud sl subnet list | grep <xxx.yyy.zzz>`.<br>**Remarque** : si un noeud worker est ajouté dans un nouveau sous-réseau privé, vous devez ajouter le CIDR de ce sous-réseau dans le paramètre `local.subnet` et le point de terminaison VPN sur site. Ensuite, la connexion VPN doit être relancée.
    * Si vous disposez d'applications exposées par des services LoadBalancer sur le réseau privé, ajoutez les CIDR des sous-réseaux privés gérés par l'utilisateur du cluster. Pour obtenir ces valeurs, exécutez la commande `ibmcloud ks cluster-get <cluster_name> --showResources`. Dans la section **VLANS**, recherchez des CIDR indiquant `false` pour **Public**.<br>
    **Remarque** : si `ipsec.keyexchange` est défini avec `ikev1`, vous ne pouvez indiquer qu'un seul sous-réseau. Vous pouvez toutefois utiliser le paramètre `localSubnetNAT` pour combiner plusieurs sous-réseaux de cluster dans un seul sous-réseau.

2. Facultatif : remappez les sous-réseaux du cluster en utilisant le paramètre `localSubnetNAT`. La conversion d'adresses réseau NAT pour les sous réseaux fournit une solution de contournement en cas de conflit entre le réseau du cluster et le réseau distant local. Vous pouvez utiliser la conversion NAT pour remapper les sous-réseaux IP locaux privés du cluster, le sous-réseau du pod (172.30.0.0/16) ou le sous-réseau du service de pod (172.21.0.0/16) vers un autre sous-réseau privé. Le tunnel VPN voit les sous-réseaux IP remappés au lieu des sous-réseaux d'origine. Le remappage intervient avant l'envoi des paquets via le tunnel VPN et après l'arrivée des paquets en provenance du tunnel VPN. Vous pouvez exposer les sous-réseaux remappés et non remappés en même temps via le VPN. Pour activer la conversion NAT, vous pouvez ajouter un sous-réseau complet ou des adresses IP individuelles.
    * Si vous ajoutez un sous-réseau complet au format `10.171.42.0/24=10.10.10.0/24`, le remappage s'effectue en mode 1 à 1 : toutes les adresses IP figurant dans le sous-réseau du réseau interne sont mappées au sous-réseau du réseau externe et inversement. 
    * Si vous ajoutez des adresses IP individuelles au format `10.171.42.17/32=10.10.10.2/32,10.171.42.29/32=10.10.10.3/32`, seules ces adresses IP internes sont mappées aux adresses IP externes spécifiées.

3. Facultatif pour les chartes Helm strongSwan à partir de la version 2.2.0 : masquez toutes les adresses IP du cluster derrière une seule adresse IP en définissant la paramètre `enableSingleSourceIP` avec la valeur `true`. Cette option offre l'une des configurations les plus sécurisées pour la connexion VPN car aucune connexion de réseau distant revenant vers le cluster n'est autorisée.
    <br>**Remarque **:
    * Ce paramètre nécessite que tous les flux de données passant par la connexion VPN soient sortants quelle que soit la connexion VPN établie depuis le cluster ou le réseau distant.
    * `local.subnet` doit être défini uniquement à un sous-réseau /32.

4. Facultatif pour les chartes Helm strongSwan à partir de la version 2.2.0 : activez le service strongSwan pour acheminer les demandes entrantes du réseau distant vers un service externe au cluster en utilisant le paramètre `localNonClusterSubnet`.
    <br>**Remarque **:
    * Le service autre que le cluster doit exister sur le même réseau privé ou sur un réseau privé accessible aux noeuds worker.
    * Le noeud worker autre que le cluster ne peut pas initier du trafic vers le réseau distant via la connexion VPN, mais il peut être la cible des demandes entrantes en provenance du réseau distant.
    * Vous devez répertorier les CIDR des sous-réseaux ne faisant pas partie du cluster dans le paramètre `local.subnet`.

### Etape 5 : Accédez aux ressources du réseau distant via la connexion VPN
{: #strongswan_5}

Déterminez les ressources du réseau distant qui doivent être accessibles au cluster via la connexion VPN.
{: shortdesc}

1. Ajoutez les routages CIDR d'un ou de plusieurs sous-réseaux privés sur site dans le paramètre `remote.subnet`. <br>**Remarque** : si `ipsec.keyexchange` est défini avec `ikev1`, vous ne pouvez indiquer qu'un seul sous-réseau.
2. Facultatif pour les chartes Helm strongSwan à partir de la version 2.2.0 : remappez les sous-réseaux du réseau distant en utilisant le paramètre `remoteSubnetNAT`. La conversion d'adresses réseau NAT pour les sous réseaux fournit une solution de contournement en cas de conflit entre le réseau du cluster et le réseau distant local. Vous pouvez utiliser la conversion NAT pour remapper les sous-réseaux IP du réseau distant à un sous-réseau privé différent. Le tunnel VPN voit les sous-réseaux IP remappés au lieu des sous-réseaux d'origine. Le remappage intervient avant l'envoi des paquets via le tunnel VPN et après l'arrivée des paquets en provenance du tunnel VPN. Vous pouvez exposer les sous-réseaux remappés et non remappés en même temps via le VPN.

### Etape 6 : Déployez la charte Helm
{: #strongswan_6}

1. Si vous devez configurer d'autres paramètres avancés, suivez la documentation fournie pour chaque paramètre dans la charte Helm.

2. **Important** : si vous n'avez pas besoin d'un paramètre dans la charte Helm, mettez en commentaire cette propriété en mettant le signe `#` devant.

3. Enregistrez le fichier `config.yaml` mis à jour.

4. Installez la charte Helm dans votre cluster avec le fichier `config.yaml` mis à jour. Les propriétés mises à jour sont stockées dans un fichier configmap de votre charte.

    **Remarque** : si vous avez plusieurs déploiements VPN dans un seul cluster, vous pouvez éviter les conflits de noms et effectuer la distinction entre différents déploiements en choisissant des noms d'édition plus descriptifs que `vpn`. Pour éviter que le nom d'édition soit tronqué, limitez-le à 35 caractères ou moins.

    ```
    helm install -f config.yaml --name=vpn ibm/strongswan
    ```
    {: pre}

5. Vérifiez le statut de déploiement de la charte Helm. Lorsque la charte est prête, la zone **STATUS** vers le haut de la sortie a la valeur `DEPLOYED`.

    ```
    helm status vpn
    ```
    {: pre}

6. Une fois la charte Helm déployée, vérifiez que les paramètres mis à jour dans le fichier `config.yaml` ont été utilisés.

    ```
    helm get values vpn
    ```
    {: pre}

## Test et vérification de la connectivité VPN strongSwan
{: #vpn_test}

Après avoir déployé la charte Helm, testez la connectivité VPN.
{:shortdesc}

1. Si le réseau privé virtuel (VPN) sur la passerelle sur site n'est pas actif, démarrez-le.

2. Définissez la variable d'environnement `STRONGSWAN_POD`.

    ```
    export STRONGSWAN_POD=$(kubectl get pod -l app=strongswan,release=vpn -o jsonpath='{ .items[0].metadata.name }')
    ```
    {: pre}

3. Vérifiez le statut du réseau privé virtuel. Un statut `ESTABLISHED` indique que la connexion VPN a abouti.

    ```
    kubectl exec $STRONGSWAN_POD -- ipsec status
    ```
    {: pre}

    Exemple de sortie :

    ```
    Security Associations (1 up, 0 connecting):
    k8s-conn[1]: ESTABLISHED 17 minutes ago, 172.30.xxx.xxx[ibm-cloud]...192.xxx.xxx.xxx[on-premises]
    k8s-conn{2}: INSTALLED, TUNNEL, reqid 12, ESP in UDP SPIs: c78cb6b1_i c5d0d1c3_o
    k8s-conn{2}: 172.21.0.0/16 172.30.0.0/16 === 10.91.152.xxx/26
    ```
    {: screen}

    **Remarque **:

    <ul>
    <li>Lorsque vous tentez d'établir la connectivité VPN avec la charte Helm strongSwan, il est probable que la première fois, le statut du VPN ne soit pas `ESTABLISHED`. Vous aurez peut-être besoin de vérifier les paramètres du point de terminaison VPN sur site et de modifier le fichier de configuration plusieurs fois avant d'établir une connexion opérationnelle : <ol><li>Exécutez la commande `helm delete --purge <release_name>`</li><li>Corrigez les valeurs incorrectes dans le fichier de configuration.</li><li>Exécutez la commande `helm install -f config.yaml --name=<release_name> ibm/strongswan`</li></ol>Vous pouvez également exécuter d'autres vérifications à l'étape suivante.</li>
    <li>Si le pod VPN est à l'état d'erreur (`ERROR`) ou continue à planter et à redémarrer, cela peut être dû à une validation de paramètres dans la section `ipsec.conf` du fichier configmap de la charte.<ol><li>Recherchez les erreurs de validation éventuelles dans les journaux du pod strongSwan en exécutant la commande `kubectl logs -n $STRONGSWAN_POD`.</li><li>En cas d'erreurs de validation, exécutez la commande `helm delete --purge <release_name>`<li>Corrigez les valeurs incorrectes dans le fichier de configuration.</li><li>Exécutez la commande `helm install -f config.yaml --name=<release_name> ibm/strongswan`</li></ol>Si votre cluster comporte un grand nombre de noeuds worker, vous pouvez également utiliser la commande `helm upgrade` pour appliquer plus rapidement vos modifications au lieu d'exécuter les commandes `helm delete` et `helm install`.</li>
    </ul>

4. Vous pouvez continuer à tester la connectivité VPN en exécutant les cinq tests Helm inclus dans la définition de la charte strongSwan.

    ```
    helm test vpn
    ```
    {: pre}

    * Si tous ces tests ont réussi, la connexion VPN strongSwan est configurée correctement.

    * Si l'un des tests a échoué, passez à l'étape suivante.

5. Affichez la sortie d'un test ayant échoué en consultant les journaux du pod de test.

    ```
    kubectl logs <test_program>
    ```
    {: pre}

    **Remarque** : certains de ces tests ont des conditions requises qui font partie des paramètres facultatifs dans la configuration du VPN. En cas d'échec de certains tests, les erreurs peuvent être acceptables si vous avez indiqué ces paramètres facultatifs. Consultez le tableau suivant pour obtenir des informations sur chaque test et les raisons d'échec possible pour chacun d'eux.

    {: #vpn_tests_table}
    <table>
    <caption>Description des tests Helm de connectivité VPN</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des tests Helm de connectivité VPN</th>
    </thead>
    <tbody>
    <tr>
    <td><code>vpn-strongswan-check-config</code></td>
    <td>Valide la syntaxe du fichier <code>ipsec.conf</code> généré à partir du fichier <code>config.yaml</code>. Ce test peut échouer en raison de valeurs incorrectes dans le fichier <code>config.yaml</code>.</td>
    </tr>
    <tr>
    <td><code>vpn-strongswan-check-state</code></td>
    <td>Vérifie que le statut de la connexion VPN est <code>ESTABLISHED</code>. Ce test peut échouer pour les raisons suivantes :<ul><li>Différences entre les valeurs du fichier <code>config.yaml</code> et les paramètres du point de terminaison VPN sur site.</li><li>Si le cluster est en mode "écoute" (<code>ipsec.auto</code> est défini sur <code>add</code>), la connexion n'est pas établie du côté sur site.</li></ul></td>
    </tr>
    <tr>
    <td><code>vpn-strongswan-ping-remote-gw</code></td>
    <td>Exécute une commande ping sur l'adresse IP publique de <code>remote.gateway</code> que vous avez configurée dans le fichier <code>config.yaml</code>. Ce test peut échouer pour les raisons suivantes :<ul><li>Vous n'avez pas indiqué d'adresse IP de passerelle VPN sur site. Si <code>ipsec.auto</code> est défini sur <code>start</code>, l'adresse IP indiquée dans <code>remote.gateway</code> est obligatoire.</li><li>La connexion VPN n'a pas le statut <code>ESTABLISHED</code>. Voir <code>vpn-strongswan-check-state</code> pour plus d'informations.</li><li>La connectivité VPN est établie (<code>ESTABLISHED</code>), mais les paquets ICMP sont bloqués par un pare-feu.</li></ul></td>
    </tr>
    <tr>
    <td><code>vpn-strongswan-ping-remote-ip-1</code></td>
    <td>Exécute une commande ping sur l'adresse IP privée de <code>remote.privateIPtoPing</code> de la passerelle VPN sur site à partir du pod VPN dans le cluster. Ce test peut échouer pour les raisons suivantes :<ul><li>Vous n'avez pas indiqué d'adresse IP pour <code>remote.privateIPtoPing</code>. Si vous ne l'avez pas indiqué volontairement, cet échec est acceptable.</li><li>Vous n'avez pas indiqué de CIDR de sous-réseau de pod de cluster, <code>172.30.0.0/16</code>, dans la liste <code>local.subnet</code>.</li></ul></td>
    </tr>
    <tr>
    <td><code>vpn-strongswan-ping-remote-ip-2</code></td>
    <td>Exécute une commande ping sur l'adresse IP privée de <code>remote.privateIPtoPing</code> de la passerelle VPN sur site à partir du noeud worker dans le cluster. Ce test peut échouer pour les raisons suivantes :<ul><li>Vous n'avez pas indiqué d'adresse IP pour <code>remote.privateIPtoPing</code>. Si vous ne l'avez pas indiqué volontairement, cet échec est acceptable.</li><li>Vous n'avez pas indiqué le CIDR de sous-réseau privé du noeud worker du cluster dans la liste <code>local.subnet</code>.</li></ul></td>
    </tr>
    </tbody></table>

6. Supprimez la charte Helm en cours.

    ```
    helm delete --purge vpn
    ```
    {: pre}

7. Ouvrez le fichier de configuration `config.yaml` et corrigez les valeurs incorrectes.

8. Enregistrez le fichier `config.yaml` mis à jour.

9. Installez la charte Helm dans votre cluster avec le fichier `config.yaml` mis à jour. Les propriétés mises à jour sont stockées dans un fichier configmap de votre charte.

    ```
    helm install -f config.yaml --name=<release_name> ibm/strongswan
    ```
    {: pre}

10. Vérifiez le statut de déploiement de la charte Helm. Lorsque la charte est prête, la zone **STATUS** vers le haut de la sortie a la valeur `DEPLOYED`.

    ```
    helm status vpn
    ```
    {: pre}

11. Une fois la charte Helm déployée, vérifiez que les paramètres mis à jour dans le fichier `config.yaml` ont été utilisés.

    ```
    helm get values vpn
    ```
    {: pre}

12. Nettoyez les pods du test en cours.

    ```
    kubectl get pods -a -l app=strongswan-test
    ```
    {: pre}

    ```
    kubectl delete pods -l app=strongswan-test
    ```
    {: pre}

13. Réexécutez les tests.

    ```
    helm test vpn
    ```
    {: pre}

<br />


## Mise à niveau de la charte Helm strongSwan
{: #vpn_upgrade}

Vérifiez que votre charte Helm strongSwan est à jour en la mettant à niveau.
{:shortdesc}

Pour mettre à niveau votre charte Helm strongSwan à la version la plus récente :

  ```
  helm upgrade -f config.yaml <release_name> ibm/strongswan
  ```
  {: pre}

**Important** : La charte Helm 2.0.0 strongSwan ne fonctionne pas avec Calico v3 ou Kubernetes 1.10. Avant de [mettre à jour votre cluster à la version 1.10](cs_versions.html#cs_v110), mettez à jour strongSwan pour utiliser la charte Helm 2.2.0, qui est compatible en amont avec Calico 2.6 et Kubernetes 1.8 et 1.9.

Vous effectuez la mise à jour de votre cluster vers Kubernetes 1.10 ? Veillez à supprimer d'abord votre charte Helm strongSwan. Puis, après la mise à jour, réinstallez-la.
{:tip}

### Mise à niveau à partir de la version 1.0.0
{: #vpn_upgrade_1.0.0}

En raison de certains paramètres utilisés dans la version 1.0.0 de la charte Helm, vous ne pouvez pas utiliser la commande `helm upgrade` pour passer de la version 1.0.0 à la version la plus récente.
{:shortdesc}

Pour effectuer la mise à niveau à partir de la version 1.0.0, vous devez supprimer la charte Helm 1.0.0 et installez la version la plus récente :

1. Supprimez la charte Helm 1.0.0.

    ```
    helm delete --purge <release_name>
    ```
    {: pre}

2. Sauvegardez les paramètres de configuration par défaut de la version la plus récente de la charte Helm strongSwan dans un fichier YAML local.

    ```
    helm inspect values ibm/strongswan > config.yaml
    ```
    {: pre}

3. Mettez à jour le fichier de configuration et sauvegardez le fichier avec vos modifications.

4. Installez la charte Helm dans votre cluster avec le fichier `config.yaml` mis à jour.

    ```
    helm install -f config.yaml --name=<release_name> ibm/strongswan
    ```
    {: pre}

En outre, certains paramètres de délai d'attente `ipsec.conf` codés en dur dans la version 1.0.0 sont exposés en tant que propriétés configurables dans les versions ultérieures. Les noms et valeurs par défaut de ces paramètres de délai d'attente `ipsec.conf` configurables ont été également modifiés pour se conformer davantage aux normes strongSwan. Si vous effectuez une mise à niveau de votre charte Helm à partir de la version 1.0.0 et que vous voulez conserver les valeurs par défaut de cette version pour les paramètres de délai d'attente (timeout), ajoutez les nouvelles valeurs dans le fichier de configuration de votre charte avec les anciennes valeurs par défaut.



  <table>
  <caption>Différences des paramètres ipsec.conf entre la version 1.0.0 et la version la plus récente</caption>
  <thead>
  <th>Nom du paramètre dans la version 1.0.0</th>
  <th>Valeur par défaut dans la version 1.0.0</th>
  <th>Nom du paramètre dans la version la plus récente</th>
  <th>Valeur par défaut dans la version la plus récente</th>
  </thead>
  <tbody>
  <tr>
  <td><code>ikelifetime</code></td>
  <td>60m</td>
  <td><code>ikelifetime</code></td>
  <td>3h</td>
  </tr>
  <tr>
  <td><code>keylife</code></td>
  <td>20m</td>
  <td><code>lifetime</code></td>
  <td>1h</td>
  </tr>
  <tr>
  <td><code>rekeymargin</code></td>
  <td>3m</td>
  <td><code>margintime</code></td>
  <td>9m</td>
  </tr>
  </tbody></table>


## Désactivation du service VPN IPsec strongSwan
{: vpn_disable}

Vous pouvez désactiver la connexion VPN en supprimant la charte Helm.
{:shortdesc}

  ```
  helm delete --purge <release_name>
  ```
  {: pre}

<br />


## Utilisation d'un dispositif de routeur virtuel (VRA)
{: #vyatta}

Le [dispositif de routeur virtuel (VRA)](/docs/infrastructure/virtual-router-appliance/about.html) fournit le système d'exploitation Vyatta 5600 le plus récent pour serveurs bare metal x86. Vous pouvez utiliser un dispositif VRA comme passerelle VPN pour vous connecter de manière sécurisée à un réseau sur site.
{:shortdesc}

Tout le trafic réseau public et privé qui entre ou sort des VLAN du cluster est acheminé via le dispositif VRA. Vous pouvez utiliser le dispositif VRA comme point de terminaison VPN pour créer un tunnel IPSec chiffré entre les serveurs dans l'infrastructure IBM Cloud (SoftLayer) et les ressources sur site. Par exemple, le diagramme suivant illustre comment une application sur un noeud worker uniquement privé dans {{site.data.keyword.containershort_notm}} peut communiquer avec un serveur sur site par le biais d'une connexion VPN VRA :

<img src="images/cs_vpn_vyatta.png" width="725" alt="Exposition d'une application dans {{site.data.keyword.containershort_notm}} à l'aide d'un équilibreur de charge" style="width:725px; border-style: none"/>

1. Une application dans votre cluster nommée `myapp2` reçoit une demande d'un service Ingress ou LoadBalancer et nécessite une connexion sécurisée aux données de votre réseau sur site.

2. Etant donné que `myapp2` se trouve sur un noeud worker sur un réseau VLAN privé uniquement, le dispositif VRA fait office de connexion sécurisée entre les noeuds worker et le réseau sur site. Le dispositif VRA utilise l'adresse IP de destination pour déterminer quels sont les paquets réseau à envoyer au réseau sur site.

3. La demande est chiffrée et envoyée via le tunnel VPN au centre de données sur site.

4. La demande entrante passe par le pare-feu local et est distribuée sur le point de terminaison du tunnel VPN (routeur) où elle est déchiffrée.

5. Le point de terminaison du tunnel VPN (routeur) transfère la demande au serveur sur site ou au mainframe, en fonction de l'adresse IP de destination qui a été indiquée à l'étape 2. Les données nécessaires sont renvoyées via la connexion VPN à `myapp2` en utilisant le même processus.

Pour configurer un dispositif de routeur virtuel (VRA) :

1. [Commandez un dispositif VRA](/docs/infrastructure/virtual-router-appliance/getting-started.html).

2. [Configurez le VLAN privé sur le dispositif VRA](/docs/infrastructure/virtual-router-appliance/manage-vlans.html).

3. Pour activer une connexion VPN en utilisant le dispositif VRA, [configurez VRRP sur le dispositif VRA](/docs/infrastructure/virtual-router-appliance/vrrp.html#high-availability-vpn-with-vrrp).

**Remarque** : si vous disposez déjà d'un dispositif de routeur et que vous ajoutez ensuite un cluster, les nouveaux sous-réseaux portables commandés pour le cluster ne sont pas configurés sur ce dispositif. Pour utiliser les services de réseau, vous devez activer le routage entre les sous-réseaux sur le même VLAN en [activant la fonction Spanning VLAN](cs_subnets.html#subnet-routing).
