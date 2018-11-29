---

copyright:
  years: 2014, 2018
lastupdated: "2018-10-25"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Protection des informations sensibles dans votre cluster
{: #encryption}

Par défaut, votre cluster {{site.data.keyword.containerlong}} utilise des disques chiffrés pour stocker des informations, telles que des configurations dans `etcd` ou le système de fichiers de conteneur qui s'exécute sur les disques secondaires du noeud worker. Lorsque vous déployez votre application, ne stockez pas d'informations confidentielles, telles que des données d'identification ou des clés, dans le fichier YAML de configuration, les objets configmap ou les scripts. Utilisez à la place des [valeurs confidentielles (secrets) Kubernetes ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/concepts/configuration/secret/). Vous pouvez également chiffrer les données dans des valeurs confidentielles Kubernetes pour empêcher des utilisateurs non autorisés d'accéder aux informations sensibles de cluster.
{: shortdesc}

Pour plus d'informations sur la sécurisation de votre cluster, voir [Sécurité d'{{site.data.keyword.containerlong_notm}}](cs_secure.html#security).



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


## Chiffrement de valeurs confidentielles Kubernetes à l'aide de {{site.data.keyword.keymanagementserviceshort}}
{: #keyprotect}

Vous pouvez chiffrer vos valeurs confidentielles Kubernetes à l'aide d'[{{site.data.keyword.keymanagementservicefull}} ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](/docs/services/key-protect/index.html#getting-started-with-key-protect) en tant que [fournisseur de service de gestion des clés (KMS) ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/tasks/administer-cluster/kms-provider/) dans votre cluster. Le fournisseur KMS est une fonction alpha dans Kubernetes pour les versions 1.10 et 1.11.
{: shortdesc}

Par défaut, les valeurs confidentielles Kubernetes sont stockées sur un disque chiffré dans le composant `etcd` du maître Kubernetes géré par IBM. Vos noeuds worker disposent également de disques secondaires chiffrés par des clés LUKS gérées par IBM stockées sous forme de valeurs confidentielles dans le cluster. Lorsque vous activez {{site.data.keyword.keymanagementserviceshort}} dans votre cluster, votre propre clé racine est utilisée pour chiffrer les valeurs confidentielles Kubernetes, notamment les valeurs confidentielles LUKS. Votre contrôle sur les données sensibles est accru lorsque les valeurs confidentielles sont chiffrées avec votre clé racine. L'utilisation de votre propre chiffrement ajoute une couche de sécurité à vos valeurs confidentielles Kubernetes et vous offre un contrôle plus granulaire sur les personnes pouvant accéder aux informations sensibles de cluster. S'il vous arrive d'avoir à retirer l'accès de manière irréversible à vos valeurs confidentielles, vous pouvez supprimer la clé racine.

**Important** : si vous supprimez la clé racine (root) dans votre instance {{site.data.keyword.keymanagementserviceshort}}, vous ne pourrez plus accéder ou supprimer les données des valeurs confidentielles dans votre cluster.

Avant de commencer :
* [Connectez-vous à votre compte. Ciblez la région appropriée et, le cas échéant, le groupe de ressources. Définissez le contexte de votre cluster](cs_cli_install.html#cs_cli_configure).
* Vérifiez que votre cluster exécute Kubernetes version 1.10.8_1524, 1.11.3_1521 ou ultérieure en exécutant la commande `ibmcloud ks cluster-get --cluster <cluster_name_or_ID>` et en vérifiant la zone **Version**.
* Vérifiez que vous disposez des [droits **Administrateur**](cs_users.html#access_policies) pour exécuter cette procédure.
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

Une fois {{site.data.keyword.keymanagementserviceshort}} activé dans le cluster, les valeurs confidentielles existantes et les nouvelles valeurs confidentielles créées dans le cluster sont automatiquement chiffrées en utilisant votre clé racine {{site.data.keyword.keymanagementserviceshort}}. Vous pouvez faire tourner votre clé à tout moment en répétant ces étapes avec un nouvel ID de clé racine.
