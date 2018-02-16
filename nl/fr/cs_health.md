---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-12"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Journalisation et surveillance des clusters
{: #health}

Configurez la journalisation et la surveillance des clusters pour faciliter la résolution de problèmes pouvant affecter vos clusters et applications et la surveillance de la santé et des performances de vos clusters.
{:shortdesc}

## Configuration de la journalisation de cluster
{: #logging}

Vous pouvez envoyer des journaux à un emplacement spécifique pour leur traitement ou stockage à long terme. Sur un cluster Kubernetes dans {{site.data.keyword.containershort_notm}}, vous pouvez activer le transfert de journaux pour votre cluster et choisir l'emplacement de destination de vos transferts de journaux. **Remarque** : le transfert de journaux n'est pris en charge que pour les clusters standard.
{:shortdesc}

Vous pouvez réacheminer les journaux de sources de journal telles que des conteneurs, des applications, des noeuds worker, des clusters Kubernetes et des contrôleurs Ingress. Examinez le tableau suivant pour plus d'information sur chaque source de journal.

|Source de journal|Caractéristiques|Chemins d'accès aux journaux|
|----------|---------------|-----|
|`conteneur`|Journaux pour votre conteneur s'exécutant dans un cluster Kubernetes.|-|
|`application`|Journaux de votre application qui s'exécute dans un cluster Kubernetes.|`/var/log/apps/**/*.log`, `/var/log/apps/**/*.err`|
|`agent`|Journaux des noeuds d'agent de machine virtuelle dans un cluster Kubernetes.|`/var/log/syslog`, `/var/log/auth.log`|
|`kubernetes`|Journaux du composant système Kubernetes.|`/var/log/kubelet.log`, `/var/log/kube-proxy.log`|
|`ingress`|Journaux pour un équilibreur de charge d'application, géré par le conteneur Ingress et qui régit le trafic réseau entrant dans un cluster Kubernetes.|`/var/log/alb/ids/*.log`, `/var/log/alb/ids/*.err`, `/var/log/alb/customerlogs/*.log`, `/var/log/alb/customerlogs/*.err`|
{: caption="Caractéristiques de la source de journal" caption-side="top"}

## Activation du transfert de journal
{: #log_sources_enable}

Vous pouvez transférer des journaux vers {{site.data.keyword.loganalysislong_notm}} ou vers un serveur syslog externe. Si vous voulez transférer des journaux depuis une source de journal vers les deux serveurs collecteurs de journal, vous devez créer deux configurations de journalisation. **Remarque **: pour réacheminer des journaux d'applications, voir [Activation du transfert de journaux pour des applications](#apps_enable).
{:shortdesc}

Avant de commencer :

1. Si vous voulez transférer des journaux vers un serveur syslog externe, vous pouvez configurer un serveur qui accepte un protocole syslog de deux manières :
  * Configurer et gérer votre propre serveur ou confier la gestion du serveur à un fournisseur. Dans ce cas, obtenez le noeud final de journalisation du fournisseur de journalisation.
  * Exécuter syslog à partir d'un conteneur. Par exemple, vous pouvez utiliser ce [fichier de déploiement .yaml ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://github.com/IBM-Bluemix/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml) pour extraire une image publique Docker qui exécute un conteneur dans un cluster Kubernetes. L'image publie le port `514` sur l'adresse IP du cluster public et utilise cette adresse pour configurer l'hôte syslog.

2. [Ciblez avec votre interface de ligne de commande](cs_cli_install.html#cs_cli_configure) le cluster où se trouve la source de journal.

Pour activer le transfert de journal pour un conteneur, un noeud worker, un composant du système Kubernetes ou un équilibreur de charge d'application :

1. Créez une configuration de transfert de journaux.

  * Pour transférer les journaux vers {{site.data.keyword.loganalysislong_notm}} :

    ```
    bx cs logging-config-create <my_cluster> --logsource <my_log_source> --namespace <kubernetes_namespace> --hostname <ingestion_URL> --port <ingestion_port> --space <cluster_space> --org <cluster_org> --type ibm
    ```
    {: pre}

    <table>
    <caption>Description des composantes de cette commande</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composantes de cette commande</th>
    </thead>
    <tbody>
    <tr>
    <td><code>logging-config-create</code></td>
    <td>Commande de création d'une configuration de transfert de journal {{site.data.keyword.loganalysislong_notm}}.</td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td>Remplacez <em>&lt;my_cluster&gt;</em> par le nom ou l'ID du cluster.</td>
    </tr>
    <tr>
    <td><code>--logsource <em>&lt;my_log_source&gt;</em></code></td>
    <td>Remplacez <em>&lt;my_log_source&gt;</em> par la source de journal. Valeurs admises : <code>container</code>, <code>application</code>, <code>worker</code>, <code>kubernetes</code> et <code>ingress</code>.</td>
    </tr>
    <tr>
    <td><code><em>&lt;kubernetes_namespace&gt;</em></code></td>
    <td>Remplacez <em>&lt;kubernetes_namespace&gt;</em> par l'espace de nom Kubernetes depuis lequel vous désirez acheminer des journaux. Le transfert des journaux n'est pas pris en charge pour les espaces de nom Kubernetes <code>ibm-system</code> et <code>kube-system</code>. Cette valeur n'est valide que pour la source de journal de conteneur et est facultative. Si vous n'indiquez pas d'espace de nom, tous les espaces de nom du cluster utilisent cette configuration.</td>
    </tr>
    <tr>
    <td><code>--hostname <em>&lt;ingestion_URL&gt;</em></code></td>
    <td>Remplacez <em>&lt;ingestion_URL&gt;</em> par l'URL d'ingestion {{site.data.keyword.loganalysisshort_notm}}. Vous trouverez [ici](/docs/services/CloudLogAnalysis/log_ingestion.html#log_ingestion_urls) la liste des URL d'ingestion disponibles. Si vous n'en indiquez aucune, le noeud final de la région où a été créé votre cluster est utilisé.</td>
    </tr>
    <tr>
    <td><code>--port <em>&lt;ingestion_port&gt;</em></code></td>
    <td>Remplacez <em>&lt;ingestion_port&gt;</em> par le port d'ingestion. Si vous n'en spécifiez pas un, le port standard, <code>9091</code>, est utilisé.</td>
    </tr>
    <tr>
    <td><code>--space <em>&lt;cluster_space&gt;</em></code></td>
    <td>Remplacez <em>&lt;cluster_space&gt;</em> par le nom de l'espace Cloud Foundry auquel vous désirez envoyer les journaux. Si vous n'en spécifiez pas un, les journaux sont envoyés au niveau du compte.</td>
    </tr>
    <tr>
    <td><code>--org <em>&lt;cluster_org&gt;</em></code></td>
    <td>Remplacez <em>&lt;cluster_org&gt;</em> par le nom de l'organisation Cloud Foundry où réside votre espace. Cette valeur est obligatoire si vous avez spécifié un espace.</td>
    </tr>
    <tr>
    <td><code>--type ibm</code></td>
    <td>Type de journal pour l'envoi de journaux à {{site.data.keyword.loganalysisshort_notm}}.</td>
    </tr>
    </tbody></table>

  * Pour transférer les journaux vers un serveur syslog externe :

    ```
    bx cs logging-config-create <my_cluster> --logsource <my_log_source> --namespace <kubernetes_namespace> --hostname <log_server_hostname_or_IP> --port <log_server_port> --type syslog
    ```
    {: pre}

    <table>
    <caption>Description des composantes de cette commande</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composantes de cette commande</th>
    </thead>
    <tbody>
    <tr>
    <td><code>logging-config-create</code></td>
    <td>Commande de création d'une configuration de transfert de journal syslog.</td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td>Remplacez <em>&lt;my_cluster&gt;</em> par le nom ou l'ID du cluster.</td>
    </tr>
    <tr>
    <td><code>--logsource <em>&lt;my_log_source&gt;</em></code></td>
    <td>Remplacez <em>&lt;my_log_source&gt;</em> par la source de journal. Valeurs admises : <code>container</code>, <code>application</code>, <code>worker</code>, <code>kubernetes</code> et <code>ingress</code>.</td>
    </tr>
    <tr>
    <td><code><em>&lt;kubernetes_namespace&gt;</em></code></td>
    <td>Remplacez <em>&lt;kubernetes_namespace&gt;</em> par l'espace de nom Kubernetes depuis lequel vous désirez acheminer des journaux. Le transfert des journaux n'est pas pris en charge pour les espaces de nom Kubernetes <code>ibm-system</code> et <code>kube-system</code>. Cette valeur n'est valide que pour la source de journal de conteneur et est facultative. Si vous n'indiquez pas d'espace de nom, tous les espaces de nom du cluster utilisent cette configuration.</td>
    </tr>
    <tr>
    <td><code>--hostname <em>&lt;log_server_hostname_or_IP&gt;</em></code></td>
    <td>Remplacez <em>&lt;log_server_hostname&gt;</em> par le nom d'hôte ou l'adresse IP du service de collecteur de journal.</td>
    </tr>
    <tr>
    <td><code>--port <em>&lt;log_server_port&gt;</em></code></td>
    <td>Remplacez <em>&lt;log_server_port&gt;</em> par le port du serveur collecteur de journal. Si vous n'indiquez pas de port, le port standard <code>514</code> est utilisé.</td>
    </tr>
    <tr>
    <td><code>--type syslog</code></td>
    <td>Type de journal pour envoi de journaux à un serveur syslog externe.</td>
    </tr>
    </tbody></table>

2. Vérifiez que la configuration de transfert des journaux a été créée.

    * Pour répertorier toutes les configurations de journalisation du cluster :
      ```
      bx cs logging-config-get <my_cluster>
      ```
      {: pre}

      Exemple de sortie :

      ```
      Id                                    Source       Namespace     Host                          Port   Org      Space      Protocol     Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  kubernetes   -             172.30.162.138                5514   -        -          syslog       /var/log/kubelet.log,/var/log/kube-proxy.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  application  -             ingest.logging.ng.bluemix.net 9091   my_org   my_space   ibm          /var/log/apps/**/*.log,/var/log/apps/**/*.err
      8a284f1a-451c-4c48-b1b4-a4e6b977264e  containers   my-namespace  myhostname.common             5514   -        -          syslog       -
      ```
      {: screen}

    * Pour répertorier les configurations de journalisation d'un type de source de journal :
      ```
      bx cs logging-config-get <my_cluster> --logsource worker
      ```
      {: pre}

      Exemple de sortie :

      ```
      Id                                    Source    Namespace   Host                            Port   Org    Space     Protocol    Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  worker    -           ingest.logging.ng.bluemix.net   9091   -      -         ibm         /var/log/syslog,/var/log/auth.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  worker    -           172.30.162.138                  5514   -      -         syslog      /var/log/syslog,/var/log/auth.log
      ```
      {: screen}


### Activation du transfert de journaux pour des applications
{: #apps_enable}

Les journaux issus d'applications doivent être cantonnés à un répertoire spécifique sur le noeud principal. Pour ce faire, montez un volume de chemin d'accès d'hôte sur vos conteneurs avec un chemin de montage. Ce chemin de montage sert de répertoire sur les conteneurs où sont envoyés les journaux d'application. Le répertoire de chemin d'accès d'hôte prédéfini, `/var/log/apps`, est automatiquement créé à la création du montage du volume.

Prenez connaissance des aspects suivants concernant le transfert de journaux d'application :
* Les journaux sont lus de façon récursive depuis le chemin /var/log/apps. Cela signifie que vous pouvez placer des journaux d'application dans des sous-répertoires du chemin /var/log/apps.
* Seuls les fichiers journaux d'application ayant l'extension `.log` ou `.err` sont transférés.
* Lorsque vous activez le transfert de journaux pour la première fois, les journaux d'application sont lus depuis la fin au lieu du début. Cela signifie que le contenu des journaux déjà présents avant activation du transfert de journaux n'est pas lu. Les journaux sont lus à partir du point où la consignation a été activée. Toutefois, après l'activation initiale du transfert de journaux, ceux-ci sont toujours prélevés à partir du point de dernier prélèvement.
* Lorsque vous montez le volume de chemin d'hôte `/var/log/apps` sur des conteneurs, ces derniers écrivent tous dans le même répertoire. Cela signifie que si vos conteneurs écrivent dans le même nom de fichier, il écriront dans exactement le même fichier sur l'hôte. Si cela ne vous convient pas, vous pouvez empêcher vos conteneurs de réécrire dans les mêmes fichiers journaux en nommant les fichiers journaux de chaque conteneur différemment.
* Etant donné que tous les conteneurs écrivent dans le même nom de fichier, n'utilisez pas cette méthode pour transférer des journaux d'application pour des jeux de répliques. Vous pouvez à la place consigner les journaux de l'application vers la sortie STDOUT et STDERR, lesquelles sont collectées comme journaux du conteneur. Pour transférer des journaux d'application consignés dans les sorties STDOUT et STDERR, suivez les étapes de la section [Activation du transfert des journaux](cs_health.html#log_sources_enable).

Avant de commencer, [ciblez avec votre interface de ligne de commande](cs_cli_install.html#cs_cli_configure) le cluster où se trouve la source de journal.

1. Ouvrez le fichier de configuration `.yaml` du pod de l'application.

2. Ajoutez les éléments `volumeMounts` et `volumes` dans le fichier de configuration :

    ```
    apiVersion: v1
    kind: Pod
    metadata:
      name: <pod_name>
    containers:
    - name: fluentd
      image: "<your_registry_image>"
      volumeMounts:
        # Docker paths
          - mountPath: /var/log/my-app-log-files-directory
            name: app-log
    volumes:
    - name: app-log
      hostPath:
        path: /var/log/apps
    ```
    {: codeblock}

2. Montez le volume sur le pod.

    ```
    kubectl apply -f <local_yaml_path>
    ```
    {:pre}

3. Pour créer une configuration de transfert des journaux, suivez les étapes de la section [Activation du transfert des journaux](cs_health.html#log_sources_enable).

<br />


## Mise à jour de la configuration d'acheminement de journal
{: #log_sources_update}

Vous pouvez mettre à jour une configuration de journalisation pour un conteneur, une application, un noeud worker, un composant du système Kubernetes ou un équilibreur de charge d'application Ingress.
{: shortdesc}

Avant de commencer :

1. Si vous modifiez le serveur collecteur de journal en syslog, vous pouvez configurer un serveur qui accepte un protocole syslog de deux manières :
  * Configurer et gérer votre propre serveur ou confier la gestion du serveur à un fournisseur. Dans ce cas, obtenez le noeud final de journalisation du fournisseur de journalisation.
  * Exécuter syslog à partir d'un conteneur. Par exemple, vous pouvez utiliser ce [fichier de déploiement .yaml ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://github.com/IBM-Bluemix/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml) pour extraire une image publique Docker qui exécute un conteneur dans un cluster Kubernetes. L'image publie le port `514` sur l'adresse IP du cluster public et utilise cette adresse pour configurer l'hôte syslog.

2. [Ciblez avec votre interface de ligne de commande](cs_cli_install.html#cs_cli_configure) le cluster où se trouve la source de journal.

Pour modifier les détails d'une configuration de journalisation :

1. Mettez à jour la configuration de journalisation.

    ```
    bx cs logging-config-update <my_cluster> --id <log_config_id> --logsource <my_log_source> --hostname <log_server_hostname_or_IP> --port <log_server_port> --space <cluster_space> --org <cluster_org> --type <logging_type>
    ```
    {: pre}

    <table>
    <caption>Description des composantes de cette commande</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composantes de cette commande</th>
    </thead>
    <tbody>
    <tr>
    <td><code>logging-config-update</code></td>
    <td>Commande de mise à jour de la configuration de transfert des journaux pour votre source de journal.</td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td>Remplacez <em>&lt;my_cluster&gt;</em> par le nom ou l'ID du cluster.</td>
    </tr>
    <tr>
    <td><code>--id <em>&lt;log_config_id&gt;</em></code></td>
    <td>Remplacez <em>&lt;log_config_id&gt;</em> par l'ID de la configuration de source de journal.</td>
    </tr>
    <tr>
    <td><code>--logsource <em>&lt;my_log_source&gt;</em></code></td>
    <td>Remplacez <em>&lt;my_log_source&gt;</em> par la source de journal. Valeurs admises : <code>container</code>, <code>application</code>, <code>worker</code>, <code>kubernetes</code> et <code>ingress</code>.</td>
    </tr>
    <tr>
    <td><code>--hostname <em>&lt;log_server_hostname_or_IP&gt;</em></code></td>
    <td>Si le type de journalisation correspond à <code>syslog</code>, remplacez <em>&lt;log_server_hostname_or_IP&gt;</em> par le nom d'hôte ou l'adresse IP du service de collecteur de journal. Si le type de journalisation correspond à <code>ibm</code>, remplacez <em>&lt;log_server_hostname&gt;</em> par l'URL d'ingestion {{site.data.keyword.loganalysislong_notm}}URL. Vous trouverez [ici](/docs/services/CloudLogAnalysis/log_ingestion.html#log_ingestion_urls) la liste des URL d'ingestion disponibles. Si vous n'en indiquez aucune, le noeud final de la région où a été créé votre cluster est utilisé.</td>
    </tr>
    <tr>
    <td><code>--port <em>&lt;log_collector_port&gt;</em></code></td>
    <td>Remplacez <em>&lt;log_server_port&gt;</em> par le port du serveur collecteur de journal. Si vous ne spécifiez pas de port, le port standard <code>514</code> est utilisé pour <code>syslog</code> et le port <code>9091</code> pour <code>ibm</code>.</td>
    </tr>
    <tr>
    <td><code>--space <em>&lt;cluster_space&gt;</em></code></td>
    <td>Remplacez <em>&lt;cluster_space&gt;</em> par le nom de l'espace Cloud Foundry auquel vous désirez envoyer les journaux. Cette valeur est facultative et n'est valide que pour le type de journal <code>ibm</code>. Si vous n'en spécifiez pas un, les journaux sont envoyés au niveau du compte.</td>
    </tr>
    <tr>
    <td><code>--org <em>&lt;cluster_org&gt;</em></code></td>
    <td>Remplacez <em>&lt;cluster_org&gt;</em> par le nom de l'organisation Cloud Foundry où réside votre espace. Cette valeur n'est valide que pour le type de journal <code>ibm</code> et est obligatoire si vous avez spécifié un espace.</td>
    </tr>
    <tr>
    <td><code>--type <em>&lt;logging_type&gt;</em></code></td>
    <td>Remplacez <em>&lt;logging_type&gt;</em> par le nouveau protocole de transfert de journaux que vous voulez utiliser. Actuellement, <code>syslog</code> et <code>ibm</code> sont pris en charge.</td>
    </tr>
    </tbody></table>

2. Vérifiez que la configuration de transfert des journaux a été mise à jour.

    * Pour répertorier toutes les configurations de journalisation du cluster :

      ```
      bx cs logging-config-get <my_cluster>
      ```
      {: pre}

      Exemple de sortie :

      ```
      Id                                    Source       Namespace     Host                          Port   Org      Space      Protocol     Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  kubernetes   -             172.30.162.138                5514   -        -          syslog       /var/log/kubelet.log,/var/log/kube-proxy.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  application  -             ingest.logging.ng.bluemix.net 9091   my_org   my_space   ibm          /var/log/apps/**/*.log,/var/log/apps/**/*.err
      8a284f1a-451c-4c48-b1b4-a4e6b977264e  containers   my-namespace  myhostname.common             5514   -        -          syslog       -
      ```
      {: screen}

    * Pour répertorier les configurations de journalisation d'un type de source de journal :

      ```
      bx cs logging-config-get <my_cluster> --logsource worker
      ```
      {: pre}

      Exemple de sortie :

      ```
      Id                                    Source    Namespace   Host                            Port   Org    Space     Protocol    Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  worker    -           ingest.logging.ng.bluemix.net   9091   -      -         ibm         /var/log/syslog,/var/log/auth.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  worker    -           172.30.162.138                  5514   -      -         syslog      /var/log/syslog,/var/log/auth.log
      ```

      {: screen}

<br />


## Arrêt du transfert de journaux
{: #log_sources_delete}

Vous pouvez arrêter de transférer les journaux en supprimant la configuration de journalisation.

Avant de commencer, [ciblez avec votre interface de ligne de commande](cs_cli_install.html#cs_cli_configure) le cluster où se trouve la source de journal.

1. Supprimez la configuration de journalisation.

    ```
    bx cs logging-config-rm <my_cluster> --id <log_config_id>
    ```
    {: pre}
    Remplacez <em>&lt;my_cluster&gt;</em> par le nom du cluster dans lequel se trouve la configuration de journalisation et <em>&lt;log_config_id&gt;</em> par l'ID de la configuration de source de journalisation

<br />


## Configuration du transfert de journaux pour les journaux d'audit d'API Kubernetes
{: #app_forward}

Les journaux d'audit d'API Kubernetes capturent tous les appels au serveur d'API Kubernetes depuis votre cluster. Pour commencer à collecter les journaux d'audit d'API Kubernetes, vous pouvez configurer le serveur d'API Kubernetes afin de mettre en place un backend webhook pour votre cluster. Ce backend webhook permet aux journaux d'être envoyés à un serveur distant. Pour plus d'informations sur les journaux d'audit Kubernetes, reportez-vous à la the <a href="https://kubernetes.io/docs/tasks/debug-application-cluster/audit/" target="_blank">rubrique consacrée à l'audit <img src="../icons/launch-glyph.svg" alt="Icône de lien externe"></a> dans la documentation Kubernetes.

**Remarque **:
* L'acheminement des journaux d'audit d'API Kubernetes n'est pris en charge que pour Kubernetes version 1.7 et ultérieure.
* Actuellement, une règle d'audit pas défaut est utilisée pour tous les clusters avec cette configuration de journalisation.

### Activation de l'acheminement de journal d'audit d'API Kubernetes
{: #audit_enable}

Avant de commencer :

1. Configurez un serveur de journalisation distant auquel vous pourrez acheminer les journaux. Vous pouvez, par exemple, [utiliser Logstash avec Kubernetes ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/tasks/debug-application-cluster/audit/#use-logstash-to-collect-and-distribute-audit-events-from-webhook-backend) afin de collecter des événements d'audit.

2. [Ciblez votre interface de ligne de commande ](cs_cli_install.html#cs_cli_configure) sur le cluster depuis lequel vous désirez collecter des journaux d'audit de serveur d'API.

Pour acheminer des journaux d'audit d'API Kubernetes, procédez comme suit :

1. Définissez le backend webhook pour la configuration de serveur d'API. Une configuration webhook est créée compte tenu des informations que vous soumettez dans les indicateurs de cette commande. Si vous ne soumettez pas d'informations dans les indicateurs, une configuration webhook par défaut est utilisée.

    ```
    bx cs apiserver-config-set audit-webhook <my_cluster> --remoteServer <server_URL_or_IP> --caCert <CA_cert_path> --clientCert <client_cert_path> --clientKey <client_key_path>
    ```
    {: pre}

    <table>
    <caption>Description des composantes de cette commande</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composantes de cette commande</th>
    </thead>
    <tbody>
    <tr>
    <td><code>apiserver-config-set</code></td>
    <td>Commande permettant de définir une option pour la configuration de serveur d'API Kubernetes du cluster.</td>
    </tr>
    <tr>
    <td><code>audit-webhook</code></td>
    <td>Sous-commande permettant de définir la configuration webhook d'audit pour le serveur d'API Kubernetes du cluster.</td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td>Remplacez <em>&lt;my_cluster&gt;</em> par le nom ou l'ID du cluster.</td>
    </tr>
    <tr>
    <td><code>--remoteServer <em>&lt;server_URL&gt;</em></code></td>
    <td>Remplacez <em>&lt;server_URL&gt;</em> par l'URL ou l'adresse IP du service de journalisation distant auquel vous désirez envoyer les journaux. Si vous indiquez une URL de serveur non sécurisée, les éventuels certificats sont ignorés.</td>
    </tr>
    <tr>
    <td><code>--caCert <em>&lt;CA_cert_path&gt;</em></code></td>
    <td>Remplacez <em>&lt;CA_cert_path&gt;</em> par le chemin de fichier du certificat d'autorité de certification utilisé pour vérifier le service de journalisation distant.</td>
    </tr>
    <tr>
    <td><code>--clientCert <em>&lt;client_cert_path&gt;</em></code></td>
    <td>Remplacez <em>&lt;client_cert_path&gt;</em> par le chemin de fichier du certificat client utilisé pour authentification vis à vis du service de journalisation distant.</td>
    </tr>
    <tr>
    <td><code>--clientKey <em>&lt;client_key_path&gt;</em></code></td>
    <td>Remplacez <em>&lt;client_key_path&gt;</em> par le chemin de fichier de la clé client correspondante utilisée pour connexion au service de journalisation distant.</td>
    </tr>
    </tbody></table>

2. Vérifiez que l'acheminement de journaux a été activé en examinant l'URL du service de journalisation distant.

    ```
    bx cs apiserver-config-get audit-webhook <my_cluster>
    ```
    {: pre}

    Exemple de sortie :
    ```
    OK
    Server:			https://8.8.8.8
    ```
    {: screen}

3. Appliquez la mise à jour de la configuration en redémarrant le maître Kubernetes.

    ```
    bx cs apiserver-refresh <my_cluster>
    ```
    {: pre}

### Arrêt de l'acheminement de journaux d'audit d'API Kubernetes
{: #audit_delete}

Vous pouvez cesser l'acheminement de journaux d'audit en désactivant la configuration de backend webhook pour le serveur d'API du cluster.

Avant de commencer, [ciblez votre interface de ligne de commande (CLI)](cs_cli_install.html#cs_cli_configure) sur le cluster depuis lequel vous désirez cesser de collecter des journaux d'audit de serveur d'API.

1. Désactivez la configuration de serveur dorsal webhook pour le serveur d'API du cluster.

    ```
    bx cs apiserver-config-unset audit-webhook <my_cluster>
    ```
    {: pre}

2. Appliquez la mise à jour de la configuration en redémarrant le maître Kubernetes.

    ```
    bx cs apiserver-refresh <my_cluster>
    ```
    {: pre}

<br />


## Affichage des journaux
{: #view_logs}

Pour afficher les journaux des clusters et des conteneurs, vous pouvez utiliser les fonctions de journalisation standard de Kubernetes et Docker.
{:shortdesc}

### {{site.data.keyword.loganalysislong_notm}}
{: #view_logs_k8s}

Pour les clusters standard, les journaux se trouvent dans le compte {{site.data.keyword.Bluemix_notm}} où vous vous êtes connecté lorsque vous avez créé le cluster Kubernetes. Si vous avez spécifié un espace {{site.data.keyword.Bluemix_notm}} lorsque vous avez créé le cluster ou la configuration de journalisation, les journaux sont situés dans cet espace. Les journaux sont surveillés et réacheminés depuis l'extérieur du conteneur. Vous pouvez accéder aux journaux d'un conteneur via le tableau de bord Kibana. Pour plus d'informations sur la journalisation, voir [Journalisation pour {{site.data.keyword.containershort_notm}}](/docs/services/CloudLogAnalysis/containers/containers_kubernetes.html#containers_kubernetes).

**Remarque **: si vous avez spécifié un espace lors de la création du cluster ou de la configuration de journalisation, le propriétaire du compte doit disposer des droits Responsable, Développeur ou Auditeur dans cet espace pour afficher les journaux. Pour plus d'informations sur la modification des {{site.data.keyword.containershort_notm}} droits et règles d'accès, voir [Gestion de l'accès au cluster](cs_users.html#managing). Une fois les droits modifiés, il peut s'écouler jusqu'à 24 heures avant que les journaux commencent à s'afficher.

Pour accéder au tableau de bord Kibana, accédez à l'une des URL suivantes et sélectionnez le compte ou l'espace {{site.data.keyword.Bluemix_notm}} dans lequel vous avez créé le cluster.
- Sud et Est des Etats-Unis : https://logging.ng.bluemix.net
- Sud du Royaume-Uni et Europe centrale : https://logging.eu-fra.bluemix.net
- Asie-Pacifique sud : https://logging.au-syd.bluemix.net

Pour plus d'informations sur l'affichage des journaux, voir [Accès à Kibana à partir d'un navigateur Web](/docs/services/CloudLogAnalysis/kibana/launch.html#launch_Kibana_from_browser).

### Journaux Docker
{: #view_logs_docker}

Vous pouvez exploiter les capacités de journalisation intégrées de Docker pour examiner les activités sur les flux de sortie
STDOUT et STDERR standard. Pour plus d'informations, voir [Affichage des journaux pour un conteneur s'exécutant dans un cluster Kubernetes](/docs/services/CloudLogAnalysis/containers/containers_kubernetes.html#containers_kubernetes).

<br />


## Configuration de la surveillance de cluster
{: #monitoring}

Des métriques vous aident à surveiller l'état de santé et les performances de vos clusters. Vous pouvez configurer la surveillance de l'état de santé des noeuds d'agent de manière à détecter et à rectifier automatiquement tout agent dont l'état s'est dégradé ou qui n'est plus opérationnel. **Remarque** : la surveillance n'est prise en charge que pour les clusters standard.
{:shortdesc}

## Affichage des métriques
{: #view_metrics}

Vous pouvez utiliser les fonctions standard de Kubernetes et Docker pour surveiller l'état de santé de vos clusters et de vos applications.
{:shortdesc}

<dl>
<dt>Page des informations détaillées sur le cluster dans {{site.data.keyword.Bluemix_notm}}</dt>
<dd>{{site.data.keyword.containershort_notm}} fournit des informations sur l'état de santé et la capacité de votre
cluster et sur l'utilisation de vos ressources de cluster. Vous pouvez utiliser cette page de l'interface graphique pour étendre votre cluster, gérer votre stockage persistant et ajouter des fonctionnalités supplémentaires à votre cluster via une liaison de service {{site.data.keyword.Bluemix_notm}}. Pour visualiser cette page, accédez à votre Tableau de bord **{{site.data.keyword.Bluemix_notm}}** et sélectionnez un cluster.</dd>
<dt>Tableau de bord Kubernetes</dt>
<dd>Le tableau de bord Kubernetes est une interface Web d'administration dans laquelle vous pouvez examiner l'état de santé de vos noeuds d'agent, rechercher des ressources Kubernetes, déployer des applications conteneurisées et résoudre les incidents liés aux applications à l'aide des informations des journaux et de surveillance. Pour plus d'informations sur l'accès à votre tableau de bord Kubernetes, voir [Lancement du tableau de bord Kubernetes pour {{site.data.keyword.containershort_notm}}](cs_app.html#cli_dashboard).</dd>
<dt>{{site.data.keyword.monitoringlong_notm}}</dt>
<dd>Les métriques des clusters standard se trouvent dans le compte {{site.data.keyword.Bluemix_notm}} connecté lorsque vous avez créé le cluster Kubernetes. Si vous avez spécifié un espace {{site.data.keyword.Bluemix_notm}} lorsque vous avez créé le cluster, les métriques se trouvent dans cet espace. Les métriques de conteneur sont collectées automatiquement pour tous les conteneurs déployés dans un cluster. Ces métriques sont envoyées et mises à disposition via Grafana. Pour plus d'informations sur les métriques, voir [Surveillance d'{{site.data.keyword.containershort_notm}}](/docs/services/cloud-monitoring/containers/monitoring_containers_ov.html#monitoring_bmx_containers_ov).<p>Pour accéder au tableau de bord Grafana, accédez à l'une des URL suivantes et sélectionnez le compte ou l'espace {{site.data.keyword.Bluemix_notm}} dans lequel vous avez créé le cluster.<ul><li>Sud et Est des Etats-Unis : https://metrics.ng.bluemix.net</li><li>Sud du Royaume-Uni : https://metrics.eu-gb.bluemix.net</li></ul></p></dd></dl>

### Autres outils de surveillance de l'état de santé
{: #health_tools}

Vous pouvez configurer d'autres outils pour disposer de capacités de surveillance supplémentaires.
<dl>
<dt>Prometheus</dt>
<dd>Prometheus est un outil open source de surveillance, de journalisation et d'alerte conçu pour Kubernetes. Cet outils extrait des informations détaillées sur le cluster, les noeuds d'agent et l'état de santé du déploiement à partir des informations de journalisation de Kubernetes. Pour obtenir des informations de configuration, voir [Intégration de services avec les {{site.data.keyword.containershort_notm}}](cs_integrations.html#integrations).</dd>
</dl>

<br />


## Configuration de la surveillance de l'état de santé des noeuds d'agent avec le système de reprise automatique
{: #autorecovery}

Le système de reprise automatique d'{{site.data.keyword.containerlong_notm}} peut être déployé dans des clusters existants de Kubernetes version 1.7 ou ultérieure. Le système de reprise automatique effectue diverses vérifications pour obtenir l'état de santé des noeuds d'agent. Si le système de reprise automatique détecte un mauvais état de santé d'un noeud worker d'après les vérifications configurées, il déclenche une mesure corrective (par exemple, un rechargement du système d'exploitation) sur le noeud worker. Un seul noeud worker à la fois fait l'objet d'une mesure corrective. La mesure corrective doit réussir sur le noeud worker pour que d'autre noeuds d'agent bénéficient d'une mesure corrective. Pour plus d'informations, reportez-vous à cet [article du blogue Autorecovery ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://www.ibm.com/blogs/bluemix/2017/12/autorecovery-utilizes-consistent-hashing-high-availability/).
**REMARQUE** : Le système de reprise automatique nécessite qu'au moins un noeud worker soit opérationnel pour fonctionner correctement. Configurez le système de reprise automatique avec des vérifications actives uniquement dans les clusters contenant au moins deux noeuds d'agent.

Avant de commencer, [ciblez avec votre interface de ligne de commande](cs_cli_install.html#cs_cli_configure) le cluster dans lequel vous voulez vérifier les statuts des noeuds d'agent.

1. Créez un fichier de mappe de configuration qui définit vos vérifications au format JSON. Par exemple, le fichier YAML suivant définit trois vérifications : une vérification HTTP et deux vérifications de serveur d'API Kubernetes. **Remarque **: Chaque vérification doit être définie sous forme de clé unique dans la section des données de la mappe de configuration.

    ```
    kind: ConfigMap
    apiVersion: v1
    metadata:
      name: ibm-worker-recovery-checks
      namespace: kube-system
    data:
      checkhttp.json: |
        {
          "Check":"HTTP",
          "FailureThreshold":3,
          "CorrectiveAction":"REBOOT",
          "CooloffSeconds":1800,
          "IntervalSeconds":180,
          "TimeoutSeconds":10,
          "Port":80,
          "ExpectedStatus":200,
          "Route":"/myhealth",
          "Enabled":false
        }
      checknode.json: |
        {
          "Check":"KUBEAPI",
          "Resource":"NODE",
          "FailureThreshold":3,
          "CorrectiveAction":"RELOAD",
          "CooloffSeconds":1800,
          "IntervalSeconds":180,
          "TimeoutSeconds":10,
          "Enabled":true
        }
      checkpod.json: |
        {
          "Check":"KUBEAPI",
          "Resource":"POD",
          "PodFailureThresholdPercent":50,
          "FailureThreshold":3,
          "CorrectiveAction":"RELOAD",
          "CooloffSeconds":1800,
          "IntervalSeconds":180,
          "TimeoutSeconds":10,
          "Enabled":true
      }
    ```
    {:codeblock}


    <table summary="Description des composants de la mappe de configuration">
    <caption>Description des composants de la mappe de configuration</caption>
      <thead>
        <th colspan=2><img src="images/idea.png"/>Description des composants de la mappe de configuration</th>
      </thead>
      <tbody>
       <tr>
          <td><code>name</code></td>
          <td>Le nom de configuration <code>ibm-worker-recovery-checks</code> est une constante et ne peut pas être modifié.</td>
       </tr>
       <tr>
          <td><code>espace de nom</code></td>
          <td>L'espace de nom <code>kube-system</code> est une constante et ne peut pas être modifié.</td>
       </tr>
      <tr>
          <td><code>checkhttp.json</code></td>
          <td>Définit une vérification HTTP qui s'assure qu'un serveur HTTP est en opération sur l'adresse IP de chaque noeud sur le port 80 et renvoie une réponse 200 sur le chemin <code>/myhealth</code>. Vous pouvez identifier l'adresse IP d'un noeud en exécutant la commande <code>kubectl get nodes</code>.
               Par exemple, envisagez deux noeuds dans un cluster avec les adresses IP 10.10.10.1 et 10.10.10.2. Dans cet exemple, deux routes sont vérifiées pour renvoi de réponses 200 OK : <code>http://10.10.10.1:80/myhealth</code> et <code>http://10.10.10.2:80/myhealth</code>.
               La vérification dans l'exemple YAML ci-dessus s'exécute toutes les 3 minutes. Si elle échoue consécutivement trois fois, le noeud est réamorcé. Cette action est équivalente à la commande <code>bx cs worker-reboot</code>. La vérification HTTP est désactivée jusqu'à ce que vous affectiez à la zone <b>Enabled</b> la valeur <code>true</code>.</td>
        </tr>
        <tr>
          <td><code>checknode.json</code></td>
          <td>Définit une vérification de noeud d'API Kubernetes pour s'assurer que l'état de chaque noeud indique <code>Ready</code> (Prêt). La vérification d'un noeud spécifique compte comme un échec si le noeud n'est pas à l'état <code>Ready</code>.
               La vérification dans l'exemple YAML ci-dessus s'exécute toutes les 3 minutes. Si elle échoue consécutivement trois fois, le noeud est rechargé. Cette action est équivalente à la commande <code>bx cs worker-reload</code>. La vérification de noeud est activée tant que vous n'affectez pas à la zone <b>Enabled</b> la valeur <code>false</code> ou supprimez la vérification.</td>
        </tr>
        <tr>
          <td><code>checkpod.json</code></td>
          <td>Définit une vérification de pod d'API Kubernetes qui vérifie le pourcentage total de pods <code>NotReady</code> sur un noeud par rapport à tous les pods affectés à ce noeud. La vérification d'un noeud spécifique compte comme un échec si le pourcentage total de pods à l'état <code>NotReady</code> est supérieur à la valeur définie pour <code>PodFailureThresholdPercent</code>.
               La vérification dans l'exemple YAML ci-dessus s'exécute toutes les 3 minutes. Si elle échoue consécutivement trois fois, le noeud est rechargé. Cette action est équivalente à la commande <code>bx cs worker-reload</code>. La vérification de pod est activée tant que vous n'affectez pas à la zone <b>Enabled</b> la valeur <code>false</code> ou supprimez la vérification.</td>
        </tr>
      </tbody>
    </table>


    <table summary="Description des composants de règles individuelles">
    <caption>Description des composants de règles individuelles</caption>
      <thead>
        <th colspan=2><img src="images/idea.png"/>Description des composants de règles individuelles </th>
      </thead>
      <tbody>
       <tr>
           <td><code>Check</code></td>
           <td>Indiquez le type de vérification que le système de reprise automatique doit effectuer. <ul><li><code>HTTP</code> : La reprise automatique appelle les serveur HTTP qui s'exécutent sur chaque noeud afin de déterminer si les noeuds s'exécutent correctement.</li><li><code>KUBEAPI</code> : La reprise automatique appelle le serveur d'API Kubernetes et lit les données d'état de santé renvoyées par les noeuds d'agent.</li></ul></td>
           </tr>
       <tr>
           <td><code>Resource</code></td>
           <td>Lorsque le type de vérification est <code>KUBEAPI</code>, entrez le type de ressource que le système de reprise automatique doit vérifier. Les valeurs admises sont <code>NODE</code> ou <code>PODS</code>.</td>
           </tr>
       <tr>
           <td><code>FailureThreshold</code></td>
           <td>Indiquez le seuil du nombre consécutif d'échec de vérification. Lorsque ce seuil est atteint, le système de reprise automatique déclenche la mesure corrective spécifiée. Par exemple, si la valeur de seuil est 3 et qu'une vérification configurée de la reprise automatique échoue trois fois consécutivement, le système de reprise automatique déclenche la mesure corrective associée à la vérification.</td>
       </tr>
       <tr>
           <td><code>PodFailureThresholdPercent</code></td>
           <td>Lorsque le type de ressource est <code>PODS</code>, indiquez le seuil du pourcentage de pods sur un noeud worker pouvant présenter l'état [NotReady ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/#define-readiness-probes). Ce pourcentage se base sur le nombre total de pods planifiés d'un noeud worker. Lorsqu'une vérification détermine que le pourcentage de pods ayant un mauvais état de santé est supérieur au seuil spécifié, la vérification compte comme un échec.</td>
           </tr>
        <tr>
            <td><code>CorrectiveAction</code></td>
            <td>Indiquez l'action à exécuter lorsque le seuil d'échec est atteint. Une mesure corrective ne s'exécute que si aucun autre agent ne fait l'objet d'une réparation et si le noeud worker traité n'est pas hors fonction en raison d'une action précédente. <ul><li><code>REBOOT</code> : Réamorce le noeud worker.</li><li><code>RELOAD</code> : Recharge toutes les configurations requises pour le noeud worker à partir d'un système d'exploitation propre.</li></ul></td>
            </tr>
        <tr>
            <td><code>CooloffSeconds</code></td>
            <td>Indiquez le nombre de secondes que doit attendre la reprise automatique avant de lancer une autre mesure corrective pour un noeud qui a déjà fait l'objet d'une mesure corrective. Le délai d'attente commence au moment où la mesure corrective est émise.</td>
            </tr>
        <tr>
            <td><code>IntervalSeconds</code></td>
            <td>Indiquez l'intervalle en secondes entre chaque vérification. Par exemple, avec la valeur 180, la reprise automatique exécute une vérification sur chaque noeud toutes les 3 minutes.</td>
            </tr>
        <tr>
            <td><code>TimeoutSeconds</code></td>
            <td>Indiquez le nombre de secondes que prend un appel de vérification à la base de données avant que la reprise automatique mette fin à l'opération d'appel. La valeur de <code>TimeoutSeconds</code> doit être inférieure à la valeur de <code>IntervalSeconds</code>.</td>
            </tr>
        <tr>
            <td><code>Port</code></td>
            <td>Lorsque le type de vérification est <code>HTTP</code>, indiquez le port auquel le serveur HTTP doit se lier sur les noeuds d'agent. Ce port doit être exposé sur l'adresse IP de chaque noeud worker du cluster. La reprise automatique a besoin d'un numéro de port constant sur tous les noeuds pour vérifier les serveurs. Utilisez [DaemonSets ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/)lors du déploiement d'un serveur personnalisé dans un cluster.</td>
            </tr>
        <tr>
            <td><code>ExpectedStatus</code></td>
            <td>Lorsque le type de vérification est <code>HTTP</code>, indiquez le statut du serveur HTTP que la vérification doit renvoyer. Par exemple, la valeur 200 indique que vous escomptez une réponse <code>OK</code> du serveur.</td>
            </tr>
        <tr>
            <td><code>Route</code></td>
            <td>Lorsque le type de vérification est <code>HTTP</code>, indiquez le chemin demandé au serveur HTTP. Cette valeur correspond généralement au chemin des métriques du serveur qui s'exécute sur tous les noeuds d'agent.</td>
            </tr>
        <tr>
            <td><code>Enabled</code></td>
            <td>Entrez <code>true</code> pour activer la vérification ou <code>false</code> pour la désactiver.</td>
            </tr>
      </tbody>
    </table>

2. Créez la mappe de configuration dans votre cluster.

    ```
    kubectl apply -f <my_file.yaml>
    ```
    {: pre}

3. Vérifiez que vous avez créé la mappe de configuration nommée `ibm-worker-recovery-checks` dans l'espace de nom `kube-system` avec les vérifications appropriées.

    ```
    kubectl -n kube-system get cm ibm-worker-recovery-checks -o yaml
    ```
    {: pre}

4. Vérifiez que vous avez créé une valeur confidentielle de commande docker pull nommée `international-registry-docker-secret` dans l'espace de nom `kube-system`. La reprise automatique est hébergée dans le registre Docker international de {{site.data.keyword.registryshort_notm}}. Si vous n'avez pas créé de valeur confidentielle de registre Docker contenant des données d'identification valides pour le registre international, créez-en un pour exécuter le système de reprise automatique.

    1. Installez le plug-in {{site.data.keyword.registryshort_notm}}.

        ```
        bx plugin install container-registry -r Bluemix
        ```
        {: pre}

    2. Ciblez le registre international.

        ```
        bx cr region-set international
        ```
        {: pre}

    3. Créez un jeton de registre international.

        ```
        bx cr token-add --non-expiring --description internationalRegistryToken
        ```
        {: pre}

    4. Définissez la variable d'environnement `INTERNATIONAL_REGISTRY_TOKEN` avec le jeton que vous avez créé.

        ```
        INTERNATIONAL_REGISTRY_TOKEN=$(bx cr token-get $(bx cr tokens | grep internationalRegistryToken | awk '{print $1}') -q)
        ```
        {: pre}

    5. Définissez la variable d'environnement `DOCKER_EMAIL` avec l'utilisateur en cours. Votre adresse électronique n'est requise que pour exécuter la commande `kubectl` à l'étape suivante.

        ```
        DOCKER_EMAIL=$(bx target | grep "User" | awk '{print $2}')
        ```
        {: pre}

    6. Créez la valeur confidentielle de la commande docker pull.

        ```
        kubectl -n kube-system create secret docker-registry international-registry-docker-secret --docker-username=token --docker-password="$INTERNATIONAL_REGISTRY_TOKEN" --docker-server=registry.bluemix.net --docker-email="$DOCKER_EMAIL"
        ```
        {: pre}

5. Déployez le système de reprise automatique dans votre cluster en appliquant ce fichier YAML.

   ```
   kubectl apply -f https://raw.githubusercontent.com/IBM-Bluemix/kube-samples/master/ibm-worker-recovery/ibm-worker-recovery.yml
   ```
   {: pre}

6. A bout de quelques minutes, vous pouvez vérifier la section `Events` dans la sortie de la commande suivante pour visualiser l'activité sur le déploiement du système de reprise automatique.

    ```
    kubectl -n kube-system describe deployment ibm-worker-recovery
    ```
    {: pre}
