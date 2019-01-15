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
{:important: .important}
{:deprecated: .deprecated}
{:download: .download}


# Protection des informations sensibles dans votre cluster
{: #encryption}

Protégez les informations de cluster sensibles pour assurer l'intégrité des données et éviter d'exposer vos données à des utilisateurs non autorisés.
{: shortdesc}

Vous pouvez créer des données sensibles à différents niveaux dans votre cluster, chaque niveau nécessitant une protection adéquate.
- **Au niveau du cluster :** les données de configuration du cluster sont stockées dans le composant etcd de votre maître Kubernetes. Dans les clusters exécutant Kubernetes version 1.10 ou ultérieure, les données d'etcd sont stockées sur le disque local du maître Kubernetes et sauvegardées dans {{site.data.keyword.cos_full_notm}}. Les données sont chiffrées lors du transit vers {{site.data.keyword.cos_full_notm}} et au repos. Vous pouvez choisir d'activer le chiffrement de vos données etcd sur le disque local de votre maître Kubernetes en [activant le chiffrement {{site.data.keyword.keymanagementservicelong_notm}}](cs_encrypt.html#encryption) pour votre cluster. Les données etcd des clusters exécutant une version antérieure de Kubernetes sont stockées sur un disque chiffré géré par IBM et sauvegardées quotidiennement. 
- **Au niveau de l'application :** lorsque vous déployez votre application, ne stockez pas d'informations confidentielles, par exemple des données d'identification ou des clés, dans le fichier de configuration YAML, les éléments configmap ou les scripts. Utilisez à la place des [valeurs confidentielles (secrets) Kubernetes ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/concepts/configuration/secret/). Vous pouvez également [chiffrer les données dans des valeurs confidentielles Kubernetes](#keyprotect) pour empêcher des utilisateurs non autorisés d'accéder aux informations sensibles de cluster. 

Pour plus d'informations sur la sécurisation de votre cluster, voir [Sécurité d'{{site.data.keyword.containerlong_notm}}](cs_secure.html#security).

![Présentation du chiffrement dans un cluster](images/cs_encrypt_ov.png)
_Figure : Présentation du chiffrement des données dans un cluster_

1.  **etcd** : etcd est le composant du maître qui stocke les données de vos ressources Kubernetes, telles que des valeurs confidentielles (secret) et des fichiers `.yaml` de configuration d'objet. Dans les clusters exécutant Kubernetes version 1.10 ou ultérieure, les données d'etcd sont stockées sur le disque local du maître Kubernetes et sauvegardées dans {{site.data.keyword.cos_full_notm}}. Les données sont chiffrées lors du transit vers {{site.data.keyword.cos_full_notm}} et au repos. Vous pouvez choisir d'activer le chiffrement de vos données etcd sur le disque local de votre maître Kubernetes en [activant le chiffrement {{site.data.keyword.keymanagementservicelong_notm}}](#keyprotect) pour votre cluster. Les données etcd dans les clusters exécutant une version antérieure de Kubernetes sont stockées sur un disque chiffré géré par IBM et sauvegardées quotidiennement. Lorsque ces données sont envoyées à un pod, elles sont chiffrées avec TLS pour garantir leur protection et leur intégrité.
2.  **Disque secondaire du noeud worker** : le disque secondaire de votre noeud worker est l'emplacement de stockage du système de fichiers du conteneur et des images extraites localement. Le disque est chiffré avec une clé de chiffrement LUKS qui est unique au noeud worker et stockée sous forme de valeur confidentielle (secret) dans etcd et dont la gestion est assurée par IBM. Lorsque vous rechargez ou mettez à jour vos noeuds worker, les clés LUKS font l'objet d'une rotation.
3.  **Stockage** : vous pouvez opter pour stocker les données en [configurant du stockage de fichiers, d'objets ou du stockage par blocs persistant](cs_storage_planning.html#persistent_storage_overview). Les instances de stockage de l'infrastructure IBM Cloud (SoftLayer) sauvegardent les données sur des disques chiffrés de sorte qu'elles soient chiffrées lorsqu'elles sont au repos. De plus, si vous choisissez du stockage d'objets, vos données en transit sont également chiffrées.
4.  **Services {{site.data.keyword.Bluemix_notm}}** : vous pouvez [intégrer des services {{site.data.keyword.Bluemix_notm}}](cs_integrations.html#adding_cluster), tels qu'{{site.data.keyword.registryshort_notm}} ou {{site.data.keyword.watson}}, avec votre cluster. Les données d'identification du service sont stockées dans une valeur confidentielle (secret) sauvegardée dans etcd, accessible à votre application en montant cette valeur sous forme de volume ou en la spécifiant sous forme de variable d'environnement dans [votre déploiement](cs_app.html#secret).
5.  **{{site.data.keyword.keymanagementserviceshort}}** : lorsque vous [activez {{site.data.keyword.keymanagementserviceshort}}](#keyprotect) dans votre cluster, une clé de chiffrement de données (DEK) encapsulée est stockée dans etcd. Cette clé DEK chiffre les valeurs confidentielles dans votre cluster, y compris les données d'identification du service et la clé LUKS. Comme la clé racine se trouve dans votre instance {{site.data.keyword.keymanagementserviceshort}}, vous contrôlez l'accès à vos données d'identification chiffrées. Pour plus d'informations sur le mode de fonctionnement du chiffrement {{site.data.keyword.keymanagementserviceshort}}, voir [Chiffrement d'enveloppe](/docs/services/key-protect/concepts/envelope-encryption.html#envelope-encryption).

## Savoir quand utiliser des valeurs confidentielles
{: #secrets}

Les valeurs confidentielles Kubernetes permettent de stocker de manière sécurisée des informations sensibles, comme des noms d'utilisateurs, des mots de passe ou des clés. Si vos informations confidentielles doivent être chiffrées, [activez {{site.data.keyword.keymanagementserviceshort}}](#keyprotect) pour chiffrer les valeurs confidentielles. Pour plus d'informations sur ce que vous pouvez stocker dans les valeurs confidentielles, voir la [documentation de Kubernetes ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/concepts/configuration/secret/).
{:shortdesc}

Passez en revue les tâches suivantes qui nécessitent des valeurs confidentielles.

### Ajout de service dans un cluster
{: #secrets_service}

Lorsque vous liez un service à un cluster, vous n'avez pas besoin de créer une valeur confidentielle pour stocker les données d'identification de votre service. Elle est automatiquement créée pour vous. Pour plus d'informations, voir [Ajout de services Cloud Foundry à des clusters](cs_integrations.html#adding_cluster).

### Chiffrement du trafic vers vos applications avec des valeurs confidentielles TLS
{: #secrets_tls}

L'équilibreur de charge ALB équilibre la charge du trafic réseau HTTP vers les applications de votre cluster. Pour équilibrer la charge des connexions HTTPS entrantes, vous pouvez configurer l'équilibreur de charge ALB pour déchiffrer le trafic réseau et transférer la demande déchiffrée aux applications exposées dans votre cluster. Pour plus d'informations, voir la [documentation sur la configuration d'Ingress](cs_ingress.html#public_inside_3).

De plus, si vous disposez d'applications qui nécessitent le protocole HTTPS et que le trafic soit toujours chiffré, vous pouvez utiliser des valeurs confidentielles d'authentification unidirectionnelle ou mutuelle avec l'annotation `ssl-services`. Pour plus d'informations, voir la [documentation sur les annotations d'Ingress](cs_annotations.html#ssl-services).

### Accès à votre registre avec des données d'identification stockées dans un élément Kubernetes `imagePullSecret`
{: #imagepullsecret}

Lorsque vous créez un cluster, des valeurs confidentielles pour votre registre {{site.data.keyword.registrylong}} sont automatiquement créées pour vous dans l'espace de nom `default` de Kubernetes. Cependant, vous devez [créer votre propre élément imagePullSecret pour votre cluster](cs_images.html#other) si vous envisagez de déployer un conteneur dans les situations suivantes.
* A partir d'une image dans votre registre {{site.data.keyword.registryshort_notm}} vers un autre espace de nom Kubernetes que `default`.
* A partir d'une image dans votre registre {{site.data.keyword.registryshort_notm}} stockée dans une autre région {{site.data.keyword.Bluemix_notm}} ou un autre compte {{site.data.keyword.Bluemix_notm}}.
* A partir d'une image stockée dans un compte {{site.data.keyword.Bluemix_notm}} Dedicated.
* A partir d'une image stockée dans un registre privé externe.

<br />


## Chiffrement du disque local et des valeurs confidentielles du maître Kubernetes à l'aide de {{site.data.keyword.keymanagementserviceshort}}
{: #keyprotect}

Vous pouvez protéger le composant etcd dans votre maître Kubernetes et vos valeurs confidentielles Kubernetes à l'aide d'[{{site.data.keyword.keymanagementservicefull}} ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](/docs/services/key-protect/index.html#getting-started-with-key-protect) en tant que [fournisseur de service de gestion de clés (KMS)![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/tasks/administer-cluster/kms-provider/) Kubernetes dans votre cluster. Le fournisseur KMS est une fonction alpha dans Kubernetes pour les versions 1.10 et 1.11.
{: shortdesc}

Par défaut, la configuration de votre cluster et des valeurs confidentielles Kubernetes sont stockées dans le composant etcd du maître Kubernetes géré par IBM. Vos noeuds worker disposent également de disques secondaires chiffrés au moyen de clés LUKS gérées par IBM qui sont stockées sous forme de valeurs confidentielles (secrets) dans etcd. Dans les clusters exécutant Kubernetes version 1.10 ou ultérieure, les données d'etcd sont stockées sur le disque local du maître Kubernetes et sauvegardées dans {{site.data.keyword.cos_full_notm}}. Les données sont chiffrées lors du transit vers {{site.data.keyword.cos_full_notm}} et au repos. Cependant, les données dans votre composant etcd sur le disque local de votre maître Kubernetes ne sont pas chiffrées automatiquement tant que vous n'avez pas activé le chiffrement {{site.data.keyword.keymanagementserviceshort}} pour votre cluster. Les données etcd des clusters exécutant une version antérieure de Kubernetes sont stockées sur un disque chiffré géré par IBM et sauvegardées quotidiennement. 

Lorsque vous activez {{site.data.keyword.keymanagementserviceshort}} dans votre cluster, votre propre clé racine est utilisée pour chiffrer les données dans etcd, notamment les valeurs confidentielles LUKS. Votre contrôle sur les données sensibles est accru lorsque les valeurs confidentielles sont chiffrées avec votre clé racine. L'utilisation de votre propre chiffrement ajoute une couche de sécurité à vos données etcd et aux valeurs confidentielles Kubernetes, tout en vous offrant un contrôle plus granulaire sur les personnes pouvant accéder aux informations sensibles du cluster. S'il vous arrive d'avoir à retirer l'accès de manière irréversible à etcd ou à vos valeurs confidentielles, vous pouvez supprimer la clé racine.

Si vous supprimez la clé racine dans votre instance {{site.data.keyword.keymanagementserviceshort}}, vous ne pourrez plus accéder ou supprimer des données dans etcd ou les données de vos valeurs confidentielles dans votre cluster par la suite.
{: important}

Avant de commencer :
* [Connectez-vous à votre compte. Ciblez la région appropriée et, le cas échéant, le groupe de ressources. Définissez le contexte de votre cluster](cs_cli_install.html#cs_cli_configure).
* Vérifiez que votre cluster exécute Kubernetes version 1.10.8_1524, 1.11.3_1521 ou ultérieure en exécutant la commande `ibmcloud ks cluster-get --cluster <cluster_name_or_ID>` et en vérifiant la zone **Version**.
* Vérifiez que vous disposez du [rôle de plateforme {{site.data.keyword.Bluemix_notm}} IAM **Administrateur**](cs_users.html#platform) pour le cluster.
* Assurez-vous que la clé d'API définie pour la région dans laquelle se trouve votre cluster est autorisée à utiliser Key Protect. Pour connaître le propriétaire de la clé d'API dont les données d'identification sont stockées pour la région, exécutez la commande `ibmcloud ks api-key-info --cluster <cluster_name_or_ID>`.

Pour activer {{site.data.keyword.keymanagementserviceshort}} ou mettre à jour l'instance ou la clé racine qui a chiffré les données confidentielles dans le cluster :

1.  [Créez une instance {{site.data.keyword.keymanagementserviceshort}}](/docs/services/key-protect/provision.html#provision).

2.  Obtenez l'ID de l'instance de service.

    ```
    ibmcloud resource service-instance <kp_instance_name> | grep GUID
    ```
    {: pre}

3.  [Créez une clé racine](/docs/services/key-protect/create-root-keys.html#create-root-keys). Par défaut, la clé racine est créée sans date d'expiration.

    Vous avez besoin de définir une date d'expiration pour vous conformer à des règles de sécurité internes ? [Créez la clé racine en utilisant l'API](/docs/services/key-protect/create-root-keys.html#api) et incluez le paramètre `expirationDate`. **Important** : avant l'expiration de votre clé racine, vous devez répétez cette procédure pour mettre à jour votre cluster en vue de l'utilisation d'une nouvelle clé racine. Autrement, vous ne pourrez pas déchiffrer vos valeurs confidentielles.
    {: tip}

4.  Notez l'[**ID** de la clé racine](/docs/services/key-protect/view-keys.html#gui).

5.  Obtenez le [noeud final de {{site.data.keyword.keymanagementserviceshort}}](/docs/services/key-protect/regions.html#endpoints) correspondant à votre instance.

6.  Obtenez le nom du cluster pour lequel vous souhaitez activer {{site.data.keyword.keymanagementserviceshort}}.

    ```
    ibmcloud ks clusters
    ```
    {: pre}

7.  Activez {{site.data.keyword.keymanagementserviceshort}} dans votre cluster. Remplissez les indicateurs avec les informations que vous avez récupérées précédemment.

    ```
    ibmcloud ks key-protect-enable --cluster <cluster_name_or_ID> --key-protect-url <kp_endpoint> --key-protect-instance <kp_instance_ID> --crk <kp_root_key_ID>
    ```
    {: pre}

Une fois {{site.data.keyword.keymanagementserviceshort}} activé dans le cluster, les données dans `etcd`, les valeurs confidentielles existantes et les nouvelles valeurs confidentielles créées dans le cluster sont automatiquement chiffrées en utilisant votre clé racine {{site.data.keyword.keymanagementserviceshort}}. Vous pouvez faire tourner votre clé à tout moment en répétant ces étapes avec un nouvel ID de clé racine.
