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



# Configuration d'Ingress
{: #ingress}

Vous pouvez exposer plusieurs applications dans votre cluster Kubernetes en créant des ressources Ingress gérées par l'équilibreur de charge d'application (ALB) fourni par IBM dans {{site.data.keyword.containerlong}}.
{:shortdesc}

## Exemples de fichiers YAML
{: #sample_ingress}

Utilisez ces exemples de fichiers YAML pour commencer rapidement par spécifier votre ressource Ingress.
{: shortdesc}

**Ressource Ingress pour exposer une application au public**</br>

Avez-vous déjà effectué les opérations suivantes ?
- Déployer une application
- Créer un service d'application
- Sélectionner un nom de domaine et un secret TLS

Vous pouvez utiliser le fichier YAML de déploiement suivant pour créer une ressource Ingress :

```
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingressresource
spec:
  tls:
  - hosts:
    - <domain>
    secretName: <tls_secret_name>
  rules:
  - host: <domain>
    http:
      paths:
      - path: /<app1_path>
        backend:
          serviceName: <app1_service>
          servicePort: 80
      - path: /<app2_path>
        backend:
          serviceName: <app2_service>
          servicePort: 80
```
{: codeblock}

</br>

**Ressource Ingress pour exposer une application en privé**</br>

Avez-vous déjà effectué les opérations suivantes ?
- Activer un équilibreur de charge d'application (ALB) privé
- Déployer une application
- Créer un service d'application
- Enregistrer un nom de domaine personnalisé et un secret TLS

Vous pouvez utiliser le fichier YAML de déploiement suivant pour créer une ressource Ingress :

```
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: myingressresource
  annotations:
    ingress.bluemix.net/ALB-ID: "<private_ALB_ID_1>;<private_ALB_ID_2>"
spec:
  tls:
  - hosts:
    - <domain>
    secretName: <tls_secret_name>
  rules:
  - host: <domain>
    http:
      paths:
      - path: /<app1_path>
        backend:
          serviceName: <app1_service>
          servicePort: 80
      - path: /<app2_path>
        backend:
          serviceName: <app2_service>
          servicePort: 80
```
{: codeblock}

<br />


## Conditions prérequises
{: #config_prereqs}

Avant d'utiliser Ingress, consultez les prérequis suivants.
{:shortdesc}

**Prérequis pour toutes les configurations Ingress :**
- Ingress n'est disponible que pour les clusters standard et nécessite au moins deux noeuds worker par zone pour garantir une haute disponibilité et l'application régulière de mises à jour. Si vous n'avez qu'un seul noeud worker dans une zone, l'ALB ne peut pas recevoir de mises à jour automatiques. Lorsque des mises à jour automatiques sont déployées sur des pods d'ALB, ces pods sont rechargés. Toutefois, les pods d'ALB ont des règles d'anti-affinité pour garantir qu'il n'y a qu'un seul pod planifié sur chaque noeud worker pour la haute disponibilité. Ainsi, le pod n'est pas redémarré et le trafic n'est pas interrompu. Le pod d'ALB est mis à jour vers la dernière version, uniquement lorsque vous supprimez l'ancien pod manuellement de sorte que le nouveau pod mis à jour puisse être planifié.
- La configuration d'Ingress nécessite les [rôles {{site.data.keyword.cloud_notm}} IAM](/docs/containers?topic=containers-users#platform) suivants :
    - Rôle de plateforme **Administrateur** pour le cluster
    - Rôle de service **Responsable** dans tous les espaces de nom

**Prérequis pour utiliser Ingress dans les clusters à zones multiples** :
 - Si vous limitez le trafic réseau aux [noeuds worker de périphérie](/docs/containers?topic=containers-edge), au moins deux noeuds worker de périphérie doivent être activés dans chaque zone pour assurer la haute disponibilité des pods Ingress. [Créez un pool de noeuds worker de périphérie](/docs/containers?topic=containers-add_workers#add_pool) couvrant toutes les zones de votre cluster et comportant au moins deux noeuds worker par zone. 
 - Si vous disposez de plusieurs VLAN pour un cluster, de plusieurs sous-réseaux sur le même VLAN ou d'un cluster à zones multiples, vous devez activer une fonction [VRF (Virtual Router Function)](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud) pour votre compte d'infrastructure IBM Cloud de sorte que vos noeuds worker puissent communiquer entre eux sur le réseau privé. Pour activer la fonction VRF, [contactez le représentant de votre compte d'infrastructure IBM Cloud](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#how-you-can-initiate-the-conversion). Pour vérifier si la fonction VRF est déjà activée, utilisez la commande `ibmcloud account show`. Si vous ne parvenez pas à activer la fonction VRF ou si vous ne souhaitez pas le faire, activez la fonction [Spanning VLAN](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning). Pour effectuer cette action, vous devez disposer du [droit d'infrastructure](/docs/containers?topic=containers-users#infra_access) **Réseau > Gérer le spanning VLAN pour réseau**, ou vous pouvez demander au propriétaire du compte de l'activer. Pour vérifier si le spanning VLAN est déjà activé, utilisez la [commande](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get --region <region>`.

 - En cas d'échec d'une zone, vous pourrez constater des défaillances intermittentes au niveau des demandes adressées à l'ALB Ingress dans cette zone.

<br />


## Planification réseau pour un ou plusieurs espaces de nom
{: #multiple_namespaces}

Une ressource Ingress est requise pour chaque espace de nom hébergeant les applications que vous souhaitez exposer.
{:shortdesc}

### Toutes les applications se trouvent dans un espace de nom
{: #one-ns}

Si les applications de votre cluster figurent toutes dans le même espace de nom, une ressource Ingress est requise pour définir les règles de routage pour les applications exposées à cet endroit. Par exemple, si les applications `app1` et `app2` sont exposées par des services dans un espace de nom de développement, vous pouvez créer une ressource Ingress dans cet espace de nom. La ressource indique `domain.net` comme hôte et enregistre les chemins où chaque application est à l'écoute avec `domain.net`.
{: shortdesc}

<img src="images/cs_ingress_single_ns.png" width="270" alt="Une ressource par espace de nom est requise." style="width:270px; border-style: none"/>

### Les applications se trouvent dans plusieurs espaces de nom
{: #multi-ns}

Si les applications de votre cluster figurent dans différents espaces de nom, vous devez créer une ressource par espace de nom pour définir les règles des applications exposées à cet endroit.
{: shortdesc}

Vous ne pouvez toutefois définir un nom d'hôte que dans une seule ressource. Vous ne pouvez pas définir le même nom d'hôte dans plusieurs ressources. Pour enregistrer plusieurs ressources Ingress avec le même nom d'hôte, vous devez utiliser un domaine générique. Lorsqu'un domaine générique, tel que `*.domain.net` est enregistré, plusieurs sous-domaines peuvent tous être résolus avec le même hôte. Ensuite, vous pouvez créer une ressource Ingress dans chaque espace de nom et spécifier un sous-domaine différent dans chaque ressource Ingress.

Vous pouvez par exemple, envisager le scénario suivant :
* Vous disposez de deux versions de la même application, `app1` et `app3`, à des fins de test.
* Vous déployez les applications dans deux espaces de nom différents au sein du même cluster : `app1` dans l'espace de nom de développement et `app3` dans l'espace de nom de préproduction.

Pour utiliser le même équilibreur de charge ALB du cluster pour gérer le trafic vers ces applications, vous créez les ressources et services suivants :
* Un service Kubernetes dans votre espace de nom de développement pour exposer `app1`.
* Une ressource Ingress dans l'espace de nom de développement qui spécifie l'hôte sous la forme `dev.domain.net`.
* Un service Kubernetes dans l'espace de nom de préproduction pour exposer `app3`.
* Une ressource Ingress dans l'espace de nom de préproduction qui spécifie l'hôte sous la forme `stage.domain.net`.
</br>
<img src="images/cs_ingress_multi_ns.png" width="625" alt="Dans un espace de nom, utilisez des sous-domaines dans une ou plusieurs ressources" style="width:625px; border-style: none"/>


Désormais, les deux URL sont résolues avec le même domaine et sont donc traitées par le même équilibreur de charge ALB. Cependant, comme la ressource dans l'espace de nom de préproduction est enregistrée avec le sous-domaine `stage`, l'équilibreur de charge ALB Ingress achemine correctement les demandes de l'URL `stage.domain.net/app3` uniquement vers `app3`.

{: #wildcard_tls}
Le sous-domaine générique Ingress fourni par IBM, `*.<cluster_name>.<region>.containers.appdomain.cloud`, est enregistré par défaut pour votre cluster. Le certificat TLS fourni par IBM est un certificat générique pouvant être utilisé pour le sous-domaine générique. Pour utiliser un domaine personnalisé, vous devez enregistrer le domaine personnalisé en tant que domaine générique, par exemple : `*.custom_domain.net`. Pour utiliser TLS, vous devez obtenir un certificat générique.
{: note}

### Plusieurs domaines au sein d'un espace de nom
{: #multi-domains}

Dans un espace de nom individuel, vous pouvez utiliser un domaine pour accéder à toutes les applications dans l'espace de nom. Si vous souhaitez utiliser différents domaines pour les applications figurant dans un espace de nom, utilisez un domaine générique. Lorsqu'un domaine générique, tel que `*.mycluster.us-south.containers.appdomain.cloud` est enregistré, plusieurs sous-domaines sont résolus avec le même hôte. Vous pouvez ensuite utiliser une ressource pour spécifier plusieurs hôtes de sous-domaines multiples dans cette ressource. Autrement, vous pouvez créer plusieurs ressources Ingress dans l'espace de nom et indiquer un sous-domaine différent dans chaque ressource Ingress.
{: shortdesc}

<img src="images/cs_ingress_single_ns_multi_subs.png" width="625" alt="Une ressource par espace de nom est requise." style="width:625px; border-style: none"/>

Le sous-domaine générique Ingress fourni par IBM, `*.<cluster_name>.<region>.containers.appdomain.cloud`, est enregistré par défaut pour votre cluster. Le certificat TLS fourni par IBM est un certificat générique pouvant être utilisé pour le sous-domaine générique. Pour utiliser un domaine personnalisé, vous devez enregistrer le domaine personnalisé en tant que domaine générique, par exemple : `*.custom_domain.net`. Pour utiliser TLS, vous devez obtenir un certificat générique.
{: note}

<br />


## Exposition au public d'applications figurant dans votre cluster
{: #ingress_expose_public}

Exposez les applications figurant dans votre cluster au public à l'aide de l'équilibreur de charge d'application (ALB) Ingress public.
{:shortdesc}

Avant de commencer :

* Consultez les [prérequis](#config_prereqs) d'Ingress. 
* [Connectez-vous à votre compte. Le cas échéant, ciblez le groupe de ressources approprié. Définissez le contexte pour votre cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

### Etape 1 : Déployez des applications et créez des services d'application
{: #public_inside_1}

Commencez par déployer vos applications et créer des services Kubernetes pour les exposer.
{: shortdesc}

1.  [Déployez votre application sur le cluster](/docs/containers?topic=containers-app#app_cli). Prenez soin d'ajouter un libellé à votre déploiement dans la section "metadata" de votre fichier de configuration, par exemple `app: code`. Ce libellé est nécessaire pour identifier tous les pods dans lesquels s'exécute votre application afin de pouvoir inclure ces pods dans l'équilibrage de charge Ingress.

2.   Créez un service Kubernetes pour chaque application que vous désirez exposer. Votre application doit être exposée par un service Kubernetes pour que l'équilibreur de charge ALB du cluster puisse l'inclure dans l'équilibrage de charge Ingress.
      1.  Ouvrez l'éditeur de votre choix et créez un fichier de configuration de service nommé, par exemple, `myappservice.yaml`.
      2.  Définissez un service pour l'application qu'exposera l'équilibreur de charge ALB.

          ```
          apiVersion: v1
          kind: Service
          metadata:
            name: myappservice
          spec:
            selector:
              <selector_key>: <selector_value>
            ports:
             - protocol: TCP
               port: 8080
          ```
          {: codeblock}

          <table>
          <thead>
          <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML du service ALB</th>
          </thead>
          <tbody>
          <tr>
          <td><code>selector</code></td>
          <td>Entrez la paire clé de libellé (<em>&lt;selector_key&gt;</em>) et valeur (<em>&lt;selector_value&gt;</em>) que vous désirez utiliser pour cibler les pods dans lesquels s'exécute votre application. Pour cibler vos pods et les inclure dans l'équilibrage de charge du service, assurez-vous que <em>&lt;selector_key&gt;</em> et <em>&lt;selector_value&gt;</em> sont identiques à la paire clé/valeur dans la section <code>spec.template.metadata.labels</code> du fichier YAML de déploiement.</td>
           </tr>
           <tr>
           <td><code>port</code></td>
           <td>Port sur lequel le service est à l'écoute.</td>
           </tr>
           </tbody></table>
      3.  Sauvegardez vos modifications.
      4.  Créez le service dans votre cluster. Si les applications sont déployées dans plusieurs espaces de nom dans votre cluster, vérifiez que le service se déploie dans le même espace de nom que l'application que vous souhaitez exposer.

          ```
          kubectl apply -f myappservice.yaml [-n <namespace>]
          ```
          {: pre}
      5.  Répétez ces étapes pour chaque application que vous désirez exposer.


### Etape 2 : Sélectionnez un domaine d'application
{: #public_inside_2}

Lorsque vous configurez l'équilibreur de charge d'application (ALB) public, vous choisissez le domaine via lequel vos applications seront accessibles.
{: shortdesc}

Vous pouvez utiliser le domaine fourni par IBM, par exemple `mycluster-12345.us-south.containers.appdomain.cloud/myapp`, pour accéder à votre application sur Internet. Pour utiliser un domaine personnalisé à la place, vous pouvez configurer un enregistrement CNAME pour mapper votre domaine personnalisé au domaine fourni par IBM ou configurer un enregistrement A avec votre fournisseur de DNS qui utilise l'adresse IP publique de l'équilibreur de charge d'application. 

**Pour utiliser le domaine Ingress fourni par IBM :**

Obtenez le domaine fourni par IBM. Remplacez `<cluster_name_or_ID>` par le nom du cluster sur lequel l'application est déployée.
```
ibmcloud ks cluster-get --cluster <cluster_name_or_ID> | grep Ingress
```
{: pre}

Exemple de sortie :
```
Ingress Subdomain:      mycluster-12345.us-south.containers.appdomain.cloud
Ingress Secret:         <tls_secret>
```
{: screen}

**Pour utiliser un domaine personnalisé :**
1.    Créez un domaine personnalisé. Pour enregistrer votre domaine personnalisé, travaillez en collaboration avec votre fournisseur de DNS (Domain Name Service) ou [{{site.data.keyword.cloud_notm}} DNS](/docs/infrastructure/dns?topic=dns-getting-started).
      * Si les applications que vous souhaitez exposer via Ingress se trouvent dans différents espaces de nom sur un cluster, enregistrez le domaine personnalisé en tant que domaine générique, par exemple `*.custom_domain.net`.

2.  Configurez votre domaine pour acheminer le trafic réseau entrant à l'équilibreur de charge ALB fourni par IBM. Sélectionnez l'une des options suivantes :
    -   Définir un alias pour votre domaine personnalisé en spécifiant le domaine fourni par IBM sous forme d'enregistrement de nom canonique (CNAME). Pour identifier le domaine Ingress fourni par IBM, exécutez la commande `ibmcloud ks cluster-get --cluster <cluster_name>` et recherchez la zone **Sous-domaine Ingress**. L'utilisation de CNAME est privilégiée car IBM fournit des diagnostics d'intégrité automatiques sur le sous-domaine IBM et retire toutes les adresses IP défaillantes dans la réponse DNS.
    -   Mappez votre domaine personnalisé à l'adresse IP publique portable de l'équilibreur de charge d'application fourni par IBM en ajoutant l'adresse IP en tant qu'enregistrement A. Pour identifier l'adresse IP publique portable de l'équilibreur de charge d'application, exécutez la commande `ibmcloud ks alb-get --albID  <public_alb_ID>`.

### Etape 3 : Sélectionnez une terminaison TLS
{: #public_inside_3}

Après avoir choisi le domaine de l'application, vous déterminez s'il faut utiliser une terminaison TLS.
{: shortdesc}

L'équilibreur de charge ALB équilibre la charge du trafic réseau HTTP vers les applications de votre cluster. Pour équilibrer la charge des connexions HTTPS entrantes, vous pouvez configurer l'équilibreur de charge ALB pour déchiffrer le trafic réseau et transférer la demande déchiffrée aux applications exposées dans votre cluster.

* Si vous utilisez le sous-domaine Ingress fourni par IBM, vous pouvez utiliser le certificat TLS fourni par IBM. Les certificats TLS fournis par IBM sont signés par LetsEncrypt et sont entièrement gérés par IBM. Ces certificats arrivent à expiration tous les 90 jours et sont automatiquement renouvelés 37 jours avant leur date d'expiration. Pour plus d'informations sur la certification TLS générique, voir [cette remarque](#wildcard_tls). 
* Si vous utilisez un domaine personnalisé, vous pouvez utiliser votre propre certificat TLS pour gérer la terminaison TLS. L'ALB recherche d'abord un secret dans l'espace de nom où se trouve l'application, puis dans l'espace de nom `default` et pour finir dans `ibm-cert-store`. Si vos applications figurent dans un seul domaine, vous pouvez importer ou créer un secret TLS  pour le certificat dans ce même espace de nom. Si vos applications sont réparties sur plusieurs espaces de nom, importez ou créez un secret TLS pour le certificat dans l'espace de nom `default` de sorte que l'équilibreur de charge ALB puisse accéder au certificat et l'utiliser dans tous les espaces de nom. Dans les ressources Ingress que vous définissez pour chaque espace de nom, indiquez le nom du secret qui figure dans l'espace de nom par défaut. Pour plus d'informations sur la certification TLS générique, voir [cette remarque](#wildcard_tls). **Remarque** : les certificats TLS qui contiennent des clés pré-partagées (TLS-PSK) ne sont pas pris en charge.

**Si vous utilisez le domaine Ingress fourni par IBM :**

Obtenez le secret TLS fourni par IBM pour votre cluster.
```
ibmcloud ks cluster-get --cluster <cluster_name_or_ID> | grep Ingress
```
{: pre}

Exemple de sortie :
```
Ingress Subdomain:      mycluster-12345.us-south.containers.appdomain.cloud
Ingress Secret:         <tls_secret>
```
{: screen}
</br>

**Si vous utilisez un domaine personnalisé :**

Si un certificat TLS que vous désirez utiliser est stocké dans {{site.data.keyword.cloudcerts_long_notm}}, vous pouvez importer le secret qui lui est associé dans votre cluster en exécutant la commande suivante :

```
ibmcloud ks alb-cert-deploy --secret-name <secret_name> --cluster <cluster_name_or_ID> --cert-crn <certificate_crn>
```
{: pre}

Vérifiez que vous n'avez pas créé un secret ayant le même nom que le secret Ingress fourni par IBM. Vous pouvez obtenir le nom du secret Ingress fourni par IBM en exécutant la commande `ibmcloud ks cluster-get --cluster <cluster_name_or_ID> | grep Ingress`.
{: note}

Lorsque vous importez un certificat avec cette commande, le secret de certificat est créé dans un espace de nom nommé `ibm-cert-store`. La référence à ce secret est ensuite créée dans l'espace de nom `default`, accessible à n'importe quelle ressource Ingress d'un espace de nom. Lorsque l'équilibreur de charge d'application traite les demandes, il suit cette référence pour récupérer et utiliser cette valeur de secret du certificat depuis l'espace de nom `ibm-cert-store`.

</br>

Si vous ne disposez pas de certificat TLS, procédez comme suit :
1. Procurez-vous un certificat d'autorité de certification et une clé auprès de votre fournisseur de certificat. Si vous disposez de votre propre domaine, achetez un certificat TLS officiel pour votre domaine. Vérifiez que l'élément [CN ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://support.dnsimple.com/articles/what-is-common-name/) est différent pour chaque certificat.
2. Convertissez le certificat et la clé en base 64.
   1. Codez le certificat et la clé en base 64 et sauvegardez la valeur codée en base 64 dans un nouveau fichier.
      ```
      openssl base64 -in tls.key -out tls.key.base64
      ```
      {: pre}

   2. Affichez la valeur codée en base 64 pour votre certificat et votre clé.
      ```
      cat tls.key.base64
      ```
      {: pre}

3. Créez un fichier de secret YAML en utilisant le certificat et la clé.
     ```
     apiVersion: v1
     kind: Secret
     metadata:
       name: ssl-my-test
     type: Opaque
     data:
       tls.crt: <client_certificate>
       tls.key: <client_key>
     ```
     {: codeblock}

4. Créez le certificat en tant que secret Kubernetes.
     ```
   kubectl apply -f ssl-my-test
   ```
     {: pre}
Vérifiez que vous n'avez pas créé un secret ayant le même nom que le secret Ingress fourni par IBM. Vous pouvez obtenir le nom du secret Ingress fourni par IBM en exécutant la commande `ibmcloud ks cluster-get --cluster <cluster_name_or_ID> | grep Ingress`.
     {: note}


### Etape 4 : Créez la ressource Ingress
{: #public_inside_4}

Les ressources Ingress définissent les règles de routage utilisées par l'équilibreur de charge d'application (ALB) pour acheminer le trafic vers votre service d'application.
{: shortdesc}

Si votre cluster dispose de plusieurs espaces de nom dans lesquels sont exposées les applications, une ressource Ingress est requise par espace de nom. En revanche, chaque espace de nom doit utiliser un hôte différent. Vous devez enregistrer un domaine générique et indiquer un sous-domaine différent dans chaque ressource. Pour plus d'informations, voir [Planification réseau pour un ou plusieurs espaces de nom](#multiple_namespaces).
{: note}

1. Ouvrez l'éditeur de votre choix et créez un fichier de configuration Ingress nommé, par exemple, `myingressresource.yaml`.

2. Définissez dans votre fichier de configuration une ressource Ingress utilisant le domaine fourni par IBM ou votre domaine personnalisé pour acheminer le trafic réseau entrant aux services que vous avez créés auparavant.

    Exemple de fichier YAML n'utilisant pas TLS :
    ```
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: myingressresource
    spec:
      rules:
      - host: <domain>
        http:
          paths:
          - path: /<app1_path>
            backend:
              serviceName: <app1_service>
              servicePort: 80
          - path: /<app2_path>
            backend:
              serviceName: <app2_service>
              servicePort: 80
    ```
    {: codeblock}

    Exemple de fichier YAML utilisant TLS :
    ```
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: myingressresource
    spec:
      tls:
      - hosts:
        - <domain>
        secretName: <tls_secret_name>
      rules:
      - host: <domain>
        http:
          paths:
          - path: /<app1_path>
            backend:
              serviceName: <app1_service>
              servicePort: 80
          - path: /<app2_path>
            backend:
              serviceName: <app2_service>
              servicePort: 80
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code>tls.hosts</code></td>
    <td>Pour utiliser TLS, remplacez <em>&lt;domain&gt;</em> par le sous-domaine Ingress fourni par IBM ou par votre domaine personnalisé.

    </br></br>
    <strong>Remarque :</strong><ul><li>Si vos applications sont exposées par des services dans différents espaces de nom, ajoutez un sous-domaine générique au début du domaine, par exemple `subdomain1.custom_domain.net` ou `subdomain1.mycluster.us-south.containers.appdomain.cloud`. Utilisez un sous-domaine unique pour chaque ressource que vous créez dans le cluster.</li><li>N'utilisez pas &ast; pour votre hôte ou laissez la propriété host vide pour éviter des erreurs lors de la création de la ressource Ingress.</li></ul></td>
    </tr>
    <tr>
    <td><code>tls.secretName</code></td>
    <td><ul><li>Si vous utilisez le domaine Ingress fourni par IBM, remplacez le nom du secret TLS (<em>&lt;tls_secret_name&gt;</em>) par le nom du secret Ingress fourni par IBM.</li><li>Si vous utilisez un domaine personnalisé, remplacez <em>&lt;tls_secret_name&gt;</em> par le secret que vous avez créé auparavant et qui contient votre certificat et votre clé TLS personnalisés. Si vous avez importé un certificat depuis {{site.data.keyword.cloudcerts_short}}, vous pouvez exécuter la commande <code>ibmcloud ks alb-cert-get --cluster <cluster_name_or_ID> --cert-crn <certificate_crn></code> pour examiner les secrets qui sont associés à un certificat TLS.</li><ul><td>
    </tr>
    <tr>
    <td><code>host</code></td>
    <td>Remplacez <em>&lt;domain&gt;</em> par le sous-domaine Ingress fourni par IBM ou par votre domaine personnalisé.

    </br></br>
    <strong>Remarque :</strong><ul><li>Si vos applications sont exposées par des services dans différents espaces de nom, ajoutez un sous-domaine générique au début du domaine, par exemple `subdomain1.custom_domain.net` ou `subdomain1.mycluster.us-south.containers.appdomain.cloud`. Utilisez un sous-domaine unique pour chaque ressource que vous créez dans le cluster.</li><li>N'utilisez pas &ast; pour votre hôte ou laissez la propriété host vide pour éviter des erreurs lors de la création de la ressource Ingress.</li></ul></td>
    </tr>
    <tr>
    <td><code>path</code></td>
    <td>Remplacez <em>&lt;app_path&gt;</em> par une barre oblique ou par le chemin sur lequel votre application est à l'écoute. Le chemin est ajouté au domaine fourni par IBM ou à votre domaine personnalisé de manière à créer une route unique vers votre application. Lorsque vous indiquez cette route dans un navigateur Web, le trafic réseau est acheminé vers l'équilibreur de charge ALB. L'équilibreur de charge ALB recherche le service associé et lui envoie le trafic réseau. Le service transfère ensuite le trafic aux pods sur lesquels s'exécute l'application.
    </br></br>
    De nombreuses applications ne sont pas à l'écoute sur un chemin spécifique mais utilisent le chemin racine et un port spécifique. Dans ce cas, définissez le chemin racine sous la forme <code>/</code>, sans spécifier de chemin individuel pour votre application. Exemples : <ul><li>Pour <code>http://domain/</code>, entrez <code>/</code> comme chemin.</li><li>Pour <code>http://domain/app1_path</code>, entrez <code>/app1_path</code> comme chemin.</li></ul>
    </br>
    <strong>Astuce :</strong> pour configurer Ingress pour qu'il soit à l'écoute sur un chemin différent de celui où votre application est à l'écoute, vous pouvez utiliser l'[annotation rewrite](/docs/containers?topic=containers-ingress_annotation#rewrite-path).</td>
    </tr>
    <tr>
    <td><code>serviceName</code></td>
    <td>Remplacez <em>&lt;app1_service&gt;</em> et <em>&lt;app2_service&gt;</em>, et ainsi de suite, par le nom des services que vous avez créés pour exposer vos applications. Si vos applications sont exposées par des services dans différents espaces de nom dans le cluster, incluez uniquement les services d'application figurant dans le même espace de nom. Vous devez créer une ressource Ingress pour chaque espace de nom contenant des applications que vous souhaitez exposer. </td>
    </tr>
    <tr>
    <td><code>servicePort</code></td>
    <td>Port sur lequel votre service est à l'écoute. Utilisez le même port que celui que vous avez défini lors de la création du service Kubernetes pour votre application.</td>
    </tr>
    </tbody></table>

3.  Créez la ressource Ingress pour votre cluster. Veillez à ce que la ressource se déploie dans le même espace de nom que les services d'application que vous avez spécifiés dans la ressource.

    ```
    kubectl apply -f myingressresource.yaml -n <namespace>
    ```
    {: pre}
4.   Vérifiez que la création de la ressource Ingress a abouti.

      ```
      kubectl describe ingress myingressresource
      ```
      {: pre}

      1. Si les messages compris dans les événements indiquent une erreur dans la configuration de votre ressource, modifiez les valeurs du fichier de votre ressource et réappliquez le fichier correspondant à la ressource.


Votre ressource Ingress est créée dans le même espace de nom que vos services d'application. Vos applications figurant dans cet espace de nom sont enregistrées avec l'équilibreur de charge ALB Ingress du cluster.

### Etape 5 : Accédez à votre application sur Internet
{: #public_inside_5}

Dans un navigateur Web, entrez l'URL du service d'application auquel accéder.
{: shortdesc}

```
https://<domain>/<app1_path>
```
{: codeblock}

Si vous exposez plusieurs applications, accédez à ces applications en modifiant le chemin ajouté à l'URL.

```
https://<domain>/<app2_path>
```
{: codeblock}

Si vous utilisez un domaine générique pour exposer des applications dans différents espaces de nom, accédez à ces applications avec leurs propres sous-domaines.

```
http://<subdomain1>.<domain>/<app1_path>
```
{: codeblock}

```
http://<subdomain2>.<domain>/<app1_path>
```
{: codeblock}


Vous rencontrez des difficultés pour connecter votre application via Ingress ? Essayez de [déboguer Ingress](/docs/containers?topic=containers-cs_troubleshoot_debug_ingress).
{: tip}

<br />


## Exposition au public d'applications résidant hors de votre cluster
{: #external_endpoint}

Exposez des applications résidant hors de votre cluster au public en les incluant dans l'équilibrage de charge de l'ALB Ingress public. Les demandes publiques entrantes sur le domaine fourni par IBM ou sur votre domaine personnalisé sont transmises automatiquement à l'application externe.
{: shortdesc}

Avant de commencer :

* Consultez les [prérequis](#config_prereqs) d'Ingress. 
* Vérifiez que l'application externe que vous désirez englober dans l'équilibrage de charge du cluster est accessible via une adresse IP publique.
* [Connectez-vous à votre compte. Le cas échéant, ciblez le groupe de ressources approprié. Définissez le contexte pour votre cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

Pour exposer au public des applications résidant hors de votre cluster :

1.  Créez un service Kubernetes pour votre cluster qui transmettra les demandes entrantes au noeud final externe que vous allez créer.
    1.  Ouvrez l'éditeur de votre choix et créez un fichier de configuration de service nommé, par exemple, `myexternalservice.yaml`.
    2.  Définissez un service pour l'application qu'exposera l'équilibreur de charge ALB.

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: myexternalservice
        spec:
          ports:
           - protocol: TCP
             port: 8080
        ```
        {: codeblock}

        <table>
        <caption>Description des composants du fichier du service ALB</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>metadata.name</code></td>
        <td>Remplacez <em><code>&lt;myexternalservice&gt;</code></em> par le nom de votre service.<p>Découvrez comment [sécuriser vos informations personnelles](/docs/containers?topic=containers-security#pi) lorsque vous utilisez des ressources Kubernetes.</p></td>
        </tr>
        <tr>
        <td><code>port</code></td>
        <td>Port sur lequel le service est à l'écoute.</td>
        </tr></tbody></table>

    3.  Sauvegardez vos modifications.
    4.  Créez le service Kubernetes pour votre cluster.

        ```
        kubectl apply -f myexternalservice.yaml
        ```
        {: pre}
2.  Configurez un noeud final Kubernetes définissant l'emplacement externe de l'application que vous désirez inclure dans l'équilibrage de charge du cluster.
    1.  Ouvrez l'éditeur de votre choix et créez un fichier de configuration de noeud final nommé, par exemple, `myexternalendpoint.yaml`.
    2.  Définissez votre noeud final externe. Incluez toutes les adresses IP publiques et les ports pouvant être utilisés pour accéder à votre application externe.

        ```
        kind: Endpoints
        apiVersion: v1
        metadata:
          name: myexternalservice
        subsets:
          - addresses:
              - ip: <external_IP1>
              - ip: <external_IP2>
            ports:
              - port: <external_port>
        ```
        {: codeblock}

        <table>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Remplacez <em><code>&lt;myexternalendpoint&gt;</code></em> par le nom du service Kubernetes que vous avez créé plus tôt.</td>
        </tr>
        <tr>
        <td><code>ip</code></td>
        <td>Remplacez <em>&lt;external_IP&gt;</em> par les adresses IP publiques permettant de se connecter à votre application externe.</td>
         </tr>
         <td><code>port</code></td>
         <td>Remplacez <em>&lt;external_port&gt;</em> par le port sur lequel votre application externe est à l'écoute.</td>
         </tbody></table>

    3.  Sauvegardez vos modifications.
    4.  Créez le noeud final Kubernetes pour votre cluster.

        ```
        kubectl apply -f myexternalendpoint.yaml
        ```
        {: pre}

3. Poursuivez en suivant les étapes indiquées dans "Exposition au public d'applications figurant dans votre cluster", [Etape 2 : Sélectionnez une domaine d'application](#public_inside_2).

<br />


## Exposition d'applications sur un réseau privé
{: #ingress_expose_private}

Exposez des applications sur un réseau privé en utilisant l'équilibreur de charge ALB Ingress privé.
{:shortdesc}

Pour utiliser un ALB privé, vous devez d'abord activer l'ALB privé. Les clusters avec VLAN privé uniquement n'ayant pas de sous-domaine Ingress fourni par IBM, aucun secret Ingress n'est créé lors de la configuration du cluster. Pour exposer vos applications sur le réseau privé, vous devez enregistrer votre ALB avec un domaine personnalisé, et éventuellement, importer votre propre certificat TLS.

Avant de commencer :
* Consultez les [prérequis](#config_prereqs) d'Ingress. 
* Passez en revue les options permettant de planifier l'accès privé aux applications lorsque les noeuds worker sont connectés à [un VLAN public et un VLAN privé](/docs/containers?topic=containers-cs_network_planning#private_both_vlans) ou [uniquement à un VLAN privé](/docs/containers?topic=containers-cs_network_planning#plan_private_vlan).
    * Si vos noeuds worker sont connectés uniquement à un VLAN privé, vous devez configurer un [service DNS disponible sur le réseau privé ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/).

### Etape 1 : Déployez des applications et créez des services d'application
{: #private_1}

Commencez par déployer vos applications et créer des services Kubernetes pour les exposer.
{: shortdesc}

1.  [Déployez votre application sur le cluster](/docs/containers?topic=containers-app#app_cli). Prenez soin d'ajouter un libellé à votre déploiement dans la section "metadata" de votre fichier de configuration, par exemple `app: code`. Ce libellé est nécessaire pour identifier tous les pods dans lesquels s'exécute votre application afin de pouvoir inclure ces pods dans l'équilibrage de charge Ingress.

2.   Créez un service Kubernetes pour chaque application que vous désirez exposer. Votre application doit être exposée par un service Kubernetes pour que l'équilibreur de charge ALB du cluster puisse l'inclure dans l'équilibrage de charge Ingress.
      1.  Ouvrez l'éditeur de votre choix et créez un fichier de configuration de service nommé, par exemple, `myappservice.yaml`.
      2.  Définissez un service pour l'application qu'exposera l'équilibreur de charge ALB.

          ```
          apiVersion: v1
          kind: Service
          metadata:
            name: myappservice
          spec:
            selector:
              <selector_key>: <selector_value>
            ports:
             - protocol: TCP
               port: 8080
          ```
          {: codeblock}

          <table>
          <thead>
          <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML du service ALB</th>
          </thead>
          <tbody>
          <tr>
          <td><code>selector</code></td>
          <td>Entrez la paire clé de libellé (<em>&lt;selector_key&gt;</em>) et valeur (<em>&lt;selector_value&gt;</em>) que vous désirez utiliser pour cibler les pods dans lesquels s'exécute votre application. Pour cibler vos pods et les inclure dans l'équilibrage de charge du service, assurez-vous que <em>&lt;selector_key&gt;</em> et <em>&lt;selector_value&gt;</em> sont identiques à la paire clé/valeur dans la section <code>spec.template.metadata.labels</code> du fichier YAML de déploiement.</td>
           </tr>
           <tr>
           <td><code>port</code></td>
           <td>Port sur lequel le service est à l'écoute.</td>
           </tr>
           </tbody></table>
      3.  Sauvegardez vos modifications.
      4.  Créez le service dans votre cluster. Si les applications sont déployées dans plusieurs espaces de nom dans votre cluster, vérifiez que le service se déploie dans le même espace de nom que l'application que vous souhaitez exposer.

          ```
          kubectl apply -f myappservice.yaml [-n <namespace>]
          ```
          {: pre}
      5.  Répétez ces étapes pour chaque application que vous désirez exposer.


### Etape 2 : Activez l'équilibreur de charge d'application (ALB) privé par défaut
{: #private_ingress}

Lorsque vous créez un cluster standard, un équilibreur de charge d'application (ALB) privé fourni par IBM est créé dans chaque zone dans laquelle vous avez des noeuds worker, et une adresse IP privée portable ainsi qu'un chemin privé lui sont affectés. Toutefois, l'équilibreur de charge ALB privé par défaut figurant dans chaque zone n'est pas automatiquement activé. Pour utiliser l'ALB privé par défaut pour équilibrer la charge du trafic réseau privé vers vos applications, vous devez d'abord l'activer avec l'adresse IP privée portable fournie par IBM, ou votre propre adresse IP privée portable.
{:shortdesc}

Si vous avez utilisé l'indicateur `--no-subnet` lors de la création du cluster, vous devez ajouter un sous-réseau privé portable ou un sous-réseau géré par l'utilisateur avant de pouvoir activer l'équilibreur de charge ALB privé. Pour plus d'informations, voir [Demande de sous-réseaux supplémentaires pour votre cluster](/docs/containers?topic=containers-subnets#request).
{: note}

**Pour activer un ALB privé par défaut à l'aide d'une adresse IP privée portable pré-affectée fournie par IBM :**

1. Obtenez l'ID de l'ALB privé par défaut que vous souhaitez activer. Remplacez <em>&lt;cluster_name&gt;</em> par le nom du cluster sur lequel l'application que vous voulez exposer est déployée.

    ```
    ibmcloud ks albs --cluster <cluster_name>
    ```
    {: pre}

    La zone **Status** correspondant aux ALB privés est désactivée (_disabled_).
    ```
    ALB ID                                            Enabled   Status     Type      ALB IP          Zone    Build                          ALB VLAN ID
    private-crdf253b6025d64944ab99ed63bb4567b6-alb1   false     disabled   private   -               dal10   ingress:411/ingress-auth:315   2234947
    public-crdf253b6025d64944ab99ed63bb4567b6-alb1    true      enabled    public    169.xx.xxx.xxx  dal10   ingress:411/ingress-auth:315   2234945
    ```
    {: screen}
    Dans les clusters à zones multiples, le suffixe comportant des chiffres dans l'ID d'ALB indique l'ordre dans lequel l'ALB a été ajouté.
    * Par exemple, le suffixe `-alb1` dans l'ALB `private-cr6d779503319d419aa3b4ab171d12c3b8-alb1` indique qu'il s'agit du premier équilibreur de charge ALB privé par défaut créé. Il se trouve dans la zone dans laquelle vous avez créé le cluster. Dans l'exemple précédent, le cluster a été créé dans `dal10`. 
    * Le suffixe `-alb2` pour l'ALB `private-crb2f60e9735254ac8b20b9c1e38b649a5-alb2` indique qu'il s'agit du deuxième ALB privé par défaut créé. Il se trouve dans la deuxième zone que vous avez ajoutée dans votre cluster. Dans l'exemple précédent, il s'agit de la zone `dal12`. 

2. Activez l'équilibreur de charge d'application privé. Remplacez <em>&lt;private_ALB_ID&gt;</em> par l'ID de l'ALB privé indiqué dans la sortie de l'étape précédente.

   ```
   ibmcloud ks alb-configure --albID <private_ALB_ID> --enable
   ```
   {: pre}

3. **Clusters à zones multiples** : pour assurer la haute disponibilité, répétez les étapes précédentes pour l'ALB privé dans chaque zone. 

<br>
**Pour activer l'équilibreur de charge ALB privé en utilisant votre propre adresse IP privée portable :**

1. Répertoriez les équilibreurs de charge d'application disponibles dans votre cluster.
    Notez l'ID d'un équilibreur de charge d'application privé et la zone dans laquelle il se trouve. 

 ```
 ibmcloud ks albs --cluster <cluster_name>
 ```
 {: pre}

 La zone **Status** pour l'ALB privé indique qu'il est désactivé (_disabled_).
 ```
 ALB ID                                            Enabled   Status     Type      ALB IP          Zone    Build                          ALB VLAN ID
    private-crdf253b6025d64944ab99ed63bb4567b6-alb1   false     disabled   private   -               dal10   ingress:411/ingress-auth:315   2234947
    public-crdf253b6025d64944ab99ed63bb4567b6-alb1    true      enabled    public    169.xx.xxx.xxx  dal10   ingress:411/ingress-auth:315   2234945
 ```
 {: screen}

 2. Configurez le sous-réseau géré par l'utilisateur de l'adresse IP que vous avez choisie pour acheminer le trafic sur le VLAN privé dans cette zone. 

   ```
   ibmcloud ks cluster-user-subnet-add --cluster <cluster_name> --subnet-cidr <subnet_CIDR> --private-vlan <private_VLAN>
   ```
   {: pre}

   <table>
   <thead>
   <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composantes de la commande</th>
   </thead>
   <tbody>
   <tr>
   <td><code>&lt;cluster_name&gt;</code></td>
   <td>Nom ou ID du cluster dans lequel l'application que vous voulez exposer est déployée.</td>
   </tr>
   <tr>
   <td><code>&lt;subnet_CIDR&gt;</code></td>
   <td>CIDR de votre sous-réseau géré par l'utilisateur.</td>
   </tr>
   <tr>
   <td><code>&lt;private_VLAN_ID&gt;</code></td>
   <td>ID du VLAN privé. Cette valeur est obligatoire. L'ID doit être celui d'un VLAN privé dans la même zone que l'ALB privé. Pour afficher les VLAN privés de cette zone dans lesquels ces noeuds worker résident, exécutez la commande `ibmcloud ks workers --cluster <cluster_name_or_ID>` et notez l'ID d'un noeud worker dans cette zone. A l'aide de l'ID de noeud worker, exécutez `ibmcloud ks worker-get --worker <worker_id> --cluster <cluster_name_or_id>`. Dans la sortie, notez l'ID **Private VLAN**. </td>
   </tr>
   </tbody></table>

3. Activez l'équilibreur de charge ALB privé. Remplacez <em>&lt;private_ALB_ID&gt;</em> par l'ID de l'ALB privé et <em>&lt;user_IP&gt;</em> par l'adresse IP du sous-réseau géré par l'utilisateur que vous désirez utiliser. 
   ```
   ibmcloud ks alb-configure --albID <private_ALB_ID> --enable --user-ip <user_IP>
   ```
   {: pre}

4. **Clusters à zones multiples** : pour assurer la haute disponibilité, répétez les étapes précédentes pour l'ALB privé dans chaque zone. 

### Etape 3 : Mappez votre domaine personnalisé
{: #private_3}

Les clusters avec VLAN privé uniquement n'ont pas de sous-domaine Ingress fourni par IBM. Lorsque vous configurez l'ALB privé, exposez vos applications en utilisant un domaine personnalisé.
{: shortdesc}

**Clusters avec VLAN privé uniquement :**

1. Si vos noeuds worker sont connectés uniquement à un VLAN privé, vous devez configurer votre propre [service DNS disponible sur votre réseau privé ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/).
2. Créez un domaine personnalisé via votre fournisseur DNS. Si les applications que vous souhaitez exposer via Ingress se trouvent dans différents espaces de nom sur un cluster, enregistrez le domaine personnalisé en tant que domaine générique, par exemple *.custom_domain.net.
3. A l'aide de votre service DNS privé, mappez votre domaine personnalisé avec les adresses IP privées portables des ALB en ajoutant les adresses IP sous forme d'enregistrements A. Pour identifier les adresses IP privées portables des ALB, exécutez la commande `ibmcloud ks alb-get --albID <private_alb_ID>` pour chaque ALB.

**Clusters avec VLAN privé et public :**

1.    Créez un domaine personnalisé. Pour enregistrer votre domaine personnalisé, travaillez en collaboration avec votre fournisseur de DNS (Domain Name Service) ou [{{site.data.keyword.cloud_notm}} DNS](/docs/infrastructure/dns?topic=dns-getting-started).
      * Si les applications que vous souhaitez exposer via Ingress se trouvent dans différents espaces de nom sur un cluster, enregistrez le domaine personnalisé en tant que domaine générique, par exemple `*.custom_domain.net`.

2.  Mappez votre domaine personnalisé avec les adresses IP privées portables des ALB en ajoutant les adresses IP sous forme d'enregistrements A. Pour identifier les adresses IP privées portables des ALB, exécutez la commande `ibmcloud ks alb-get --albID <private_alb_ID>` pour chaque ALB.

### Etape 4 : Sélectionnez une terminaison TLS
{: #private_4}

Après avoir mappé votre domaine personnalisé, déterminez s'il faut utiliser une terminaison TLS.
{: shortdesc}

L'équilibreur de charge ALB équilibre la charge du trafic réseau HTTP vers les applications de votre cluster. Pour équilibrer la charge des connexions HTTPS entrantes, vous pouvez configurer l'équilibreur de charge ALB pour déchiffrer le trafic réseau et transférer la demande déchiffrée aux applications exposées dans votre cluster.

Les clusters avec VLAN privé uniquement n'ayant pas de domaine Ingress fourni par IBM, aucun secret Ingress n'est créé lors de la configuration du cluster. Vous pouvez utiliser votre propre certificat TLS pour gérer la terminaison TLS.  L'ALB recherche d'abord un secret dans l'espace de nom où se trouve l'application, puis dans l'espace de nom `default` et pour finir dans `ibm-cert-store`. Si vos applications figurent dans un seul domaine, vous pouvez importer ou créer un secret TLS  pour le certificat dans ce même espace de nom. Si vos applications sont réparties sur plusieurs espaces de nom, importez ou créez un secret TLS pour le certificat dans l'espace de nom `default` de sorte que l'équilibreur de charge ALB puisse accéder au certificat et l'utiliser dans tous les espaces de nom. Dans les ressources Ingress que vous définissez pour chaque espace de nom, indiquez le nom du secret qui figure dans l'espace de nom par défaut. Pour plus d'informations sur la certification TLS générique, voir [cette remarque](#wildcard_tls). **Remarque** : les certificats TLS qui contiennent des clés pré-partagées (TLS-PSK) ne sont pas pris en charge.

Si un certificat TLS que vous désirez utiliser est stocké dans {{site.data.keyword.cloudcerts_long_notm}}, vous pouvez importer le secret qui lui est associé dans votre cluster en exécutant la commande suivante :

```
ibmcloud ks alb-cert-deploy --secret-name <secret_name> --cluster <cluster_name_or_ID> --cert-crn <certificate_crn>
```
{: pre}

Lorsque vous importez un certificat avec cette commande, la valeur de secret du certificat est créée dans un espace de nom nommé `ibm-cert-store`. La référence à ce secret est ensuite créée dans l'espace de nom `default`, accessible à n'importe quelle ressource Ingress d'un espace de nom. Lorsque l'équilibreur de charge d'application traite les demandes, il suit cette référence pour récupérer et utiliser cette valeur de secret du certificat depuis l'espace de nom `ibm-cert-store`.

### Etape 5 : Créez la ressource Ingress
{: #private_5}

Les ressources Ingress définissent les règles de routage utilisées par l'équilibreur de charge d'application (ALB) pour acheminer le trafic vers votre service d'application.
{: shortdesc}

Si votre cluster dispose de plusieurs espaces de nom dans lesquels sont exposées les applications, une ressource Ingress est requise par espace de nom. En revanche, chaque espace de nom doit utiliser un hôte différent. Vous devez enregistrer un domaine générique et indiquer un sous-domaine différent dans chaque ressource. Pour plus d'informations, voir [Planification réseau pour un ou plusieurs espaces de nom](#multiple_namespaces).
{: note}

1. Ouvrez l'éditeur de votre choix et créez un fichier de configuration Ingress nommé, par exemple, `myingressresource.yaml`.

2.  Définissez dans votre fichier de configuration une ressource Ingress utilisant votre domaine personnalisé pour acheminer le trafic réseau entrant aux services que vous avez créés auparavant.

    Exemple de fichier YAML n'utilisant pas TLS :
    ```
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: myingressresource
      annotations:
        ingress.bluemix.net/ALB-ID: "<private_ALB_ID_1>;<private_ALB_ID_2>"
    spec:
      rules:
      - host: <domain>
        http:
          paths:
          - path: /<app1_path>
            backend:
              serviceName: <app1_service>
              servicePort: 80
          - path: /<app2_path>
            backend:
              serviceName: <app2_service>
              servicePort: 80
    ```
    {: codeblock}

    Exemple de fichier YAML utilisant TLS :
    ```
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: myingressresource
      annotations:
        ingress.bluemix.net/ALB-ID: "<private_ALB_ID_1>;<private_ALB_ID_2>"
    spec:
      tls:
      - hosts:
        - <domain>
        secretName: <tls_secret_name>
      rules:
      - host: <domain>
        http:
          paths:
          - path: /<app1_path>
            backend:
              serviceName: <app1_service>
              servicePort: 80
          - path: /<app2_path>
            backend:
              serviceName: <app2_service>
              servicePort: 80
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composants du fichier YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code>ingress.bluemix.net/ALB-ID</code></td>
    <td>Remplacez <em>&lt;private_ALB_ID&gt;</em> par l'ID de votre équilibreur de charge ALB privé. Si vous disposez d'un cluster à zones multiples et que vous avez activé plusieurs ALB privés, incluez l'ID de chaque ALB. Exécutez la commande <code>ibmcloud ks albs --cluster <my_cluster></code> pour identifier les ID d'ALB. Pour plus d'informations sur cette annotation Ingress, voir [Routage de l'équilibreur de charge d'application privé](/docs/containers?topic=containers-ingress_annotation#alb-id).</td>
    </tr>
    <tr>
    <td><code>tls.hosts</code></td>
    <td>Pour utiliser TLS, remplacez <em>&lt;domain&gt;</em> par votre domaine personnalisé.</br></br><strong>Remarque :</strong><ul><li>Si vos applications sont exposées par des services dans différents espaces de nom dans un cluster, ajoutez un sous-domaine générique au début du domaine, par exemple `subdomain1.custom_domain.net`. Utilisez un sous-domaine unique pour chaque ressource que vous créez dans le cluster.</li><li>N'utilisez pas &ast; pour votre hôte ou laissez la propriété host vide pour éviter des erreurs lors de la création de la ressource Ingress.</li></ul></td>
    </tr>
    <tr>
    <td><code>tls.secretName</code></td>
    <td>Remplacez <em>&lt;tls_secret_name&gt;</em> par le nom du secret que vous avez créé auparavant et qui contient votre certificat et votre clé TLS personnalisés. Si vous avez importé un certificat depuis {{site.data.keyword.cloudcerts_short}}, vous pouvez exécuter la commande <code>ibmcloud ks alb-cert-get --cluster <cluster_name_or_ID> --cert-crn <certificate_crn></code> pour examiner les secrets qui sont associés à un certificat TLS.
    </tr>
    <tr>
    <td><code>host</code></td>
    <td>Remplacez <em>&lt;domain&gt;</em> par votre domaine personnalisé.
    </br></br>
    <strong>Remarque :</strong><ul><li>Si vos applications sont exposées par des services dans différents espaces de nom dans un cluster, ajoutez un sous-domaine générique au début du domaine, par exemple `subdomain1.custom_domain.net`. Utilisez un sous-domaine unique pour chaque ressource que vous créez dans le cluster.</li><li>N'utilisez pas &ast; pour votre hôte ou laissez la propriété host vide pour éviter des erreurs lors de la création de la ressource Ingress.</li></ul></td>
    </td>
    </tr>
    <tr>
    <td><code>path</code></td>
    <td>Remplacez <em>&lt;app_path&gt;</em> par une barre oblique ou par le chemin sur lequel votre application est à l'écoute. Le chemin est ajouté à votre domaine personnalisé de manière à créer une route unique vers votre application. Lorsque vous indiquez cette route dans un navigateur Web, le trafic réseau est acheminé vers l'équilibreur de charge ALB. L'équilibreur de charge ALB recherche le service associé et lui envoie le trafic réseau. Le service transfère ensuite le trafic aux pods sur lesquels s'exécute l'application.
    </br></br>
    De nombreuses applications ne sont pas à l'écoute sur un chemin spécifique mais utilisent le chemin racine et un port spécifique. Dans ce cas, définissez le chemin racine sous la forme <code>/</code>, sans spécifier de chemin individuel pour votre application. Exemples : <ul><li>Pour <code>http://domain/</code>, entrez <code>/</code> comme chemin.</li><li>Pour <code>http://domain/app1_path</code>, entrez <code>/app1_path</code> comme chemin.</li></ul>
    </br>
    <strong>Astuce :</strong> pour configurer Ingress pour qu'il soit à l'écoute sur un chemin différent de celui où votre application est à l'écoute, vous pouvez utiliser l'[annotation rewrite](/docs/containers?topic=containers-ingress_annotation#rewrite-path).</td>
    </tr>
    <tr>
    <td><code>serviceName</code></td>
    <td>Remplacez <em>&lt;app1_service&gt;</em> et <em>&lt;app2_service&gt;</em>, et ainsi de suite, par le nom des services que vous avez créés pour exposer vos applications. Si vos applications sont exposées par des services dans différents espaces de nom dans le cluster, incluez uniquement les services d'application figurant dans le même espace de nom. Vous devez créer une ressource Ingress pour chaque espace de nom contenant des applications que vous souhaitez exposer. </td>
    </tr>
    <tr>
    <td><code>servicePort</code></td>
    <td>Port sur lequel votre service est à l'écoute. Utilisez le même port que celui que vous avez défini lors de la création du service Kubernetes pour votre application.</td>
    </tr>
    </tbody></table>

3.  Créez la ressource Ingress pour votre cluster. Veillez à ce que la ressource se déploie dans le même espace de nom que les services d'application que vous avez spécifiés dans la ressource.

    ```
    kubectl apply -f myingressresource.yaml -n <namespace>
    ```
    {: pre}
4.   Vérifiez que la création de la ressource Ingress a abouti.

      ```
      kubectl describe ingress myingressresource
      ```
      {: pre}

      1. Si les messages compris dans les événements indiquent une erreur dans la configuration de votre ressource, modifiez les valeurs du fichier de votre ressource et réappliquez le fichier correspondant à la ressource.


Votre ressource Ingress est créée dans le même espace de nom que vos services d'application. Vos applications figurant dans cet espace de nom sont enregistrées avec l'équilibreur de charge ALB Ingress du cluster.

### Etape 6 : Accédez à votre application à partir de votre réseau privé
{: #private_6}

1. Avant d'accéder à votre application, vérifiez que vous pouvez accéder à un service DNS.
  * VLAN public et privé : pour utiliser le fournisseur de DNS externe par défaut, vous devez [configurer des noeuds de périphérie avec l'accès public](/docs/containers?topic=containers-edge#edge) et [configurer un dispositif de routeur virtuel ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://www.ibm.com/blogs/bluemix/2017/07/kubernetes-and-bluemix-container-based-workloads-part4/).
  * VLAN privé uniquement : vous devez configurer un [service DNS disponible sur le réseau privé ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/).

2. A l'intérieur de votre pare-feu de réseau privé, entrez l'URL du service d'application dans un navigateur Web.

```
https://<domain>/<app1_path>
```
{: codeblock}

Si vous exposez plusieurs applications, accédez à ces applications en modifiant le chemin ajouté à l'URL.

```
https://<domain>/<app2_path>
```
{: codeblock}

Si vous utilisez un domaine générique pour exposer des applications dans différents espaces de nom, accédez à ces applications avec leurs propres sous-domaines.

```
http://<subdomain1>.<domain>/<app1_path>
```
{: codeblock}

```
http://<subdomain2>.<domain>/<app1_path>
```
{: codeblock}


Pour obtenir un tutoriel complet sur la sécurisation d'une communication de microservice à microservice entre vos clusters en utilisant l'équilibreur de charge ALB avec TLS, consultez [cet article de blogue ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://medium.com/ibm-cloud/secure-microservice-to-microservice-communication-across-kubernetes-clusters-using-a-private-ecbe2a8d4fe2).
{: tip}
