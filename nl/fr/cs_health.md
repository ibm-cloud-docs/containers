---

copyright:
  years: 2014, 2018
lastupdated: "2018-03-14"

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

Configurez les fonctions de journalisation et de surveillance dans {{site.data.keyword.containerlong}} pour vous aider à identifier et résoudre les incidents et améliorer la santé et les performances de vos applications et clusters Kubernetes.
{: shortdesc}


## Configuration du transfert de journaux
{: #logging}

Avec un cluster Kubernetes standard dans {{site.data.keyword.containershort_notm}}, vous pouvez transférer des journaux de sources différentes dans {{site.data.keyword.loganalysislong_notm}} et/ou sur un serveur syslog externe.
{: shortdesc}

Pour transférer les journaux d'une source vers les deux serveurs collecteurs, vous devez créer deux configurations de journalisation.
{: tip}

Recherchez dans le tableau suivant les informations concernant les différentes sources de journal.

<table><caption>Caractéristiques de la source de journal</caption>
  <thead>
    <tr>
      <th>Source de journal</th>
      <th>Caractéristiques</th>
      <th>Chemins d'accès au journal</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>conteneur</code></td>
      <td>Journaux pour votre conteneur s'exécutant dans un cluster Kubernetes.</td>
      <td>Tout ce qui est consigné dans STDOUT ou STDERR dans vos conteneurs.</td>
    </tr>
    <tr>
      <td><code>application</code></td>
      <td>Journaux de votre application qui s'exécute dans un cluster Kubernetes.</td>
      <td>Vous pouvez définir les chemins d'accès.</td>
    </tr>
    <tr>
      <td><code>worker</code></td>
      <td>Journaux des noeuds worker de machine virtuelle dans un cluster Kubernetes.</td>
      <td><code>/var/log/syslog</code>, <code>/var/log/auth.log</code></td>
    </tr>
    <tr>
      <td><code>kubernetes</code></td>
      <td>Journaux du composant système Kubernetes.</td>
      <td><code>/var/log/syslog</code>, <code>/var/log/auth.log</code></td>
    </tr>
    <tr>
      <td><code>ingress</code></td>
      <td>Journaux d'un équilibreur de charge d'application Ingress qui gère le trafic réseau entrant dans un cluster.</td>
      <td><code>/var/log/alb/ids/&ast;.log</code>, <code>/var/log/alb/ids/&ast;.err</code>, <code>/var/log/alb/customerlogs/&ast;.log</code>, <code>/var/log/alb/customerlogs/&ast;.err</code></td>
    </tr>
  </tbody>
</table>

Lorsque vous configurez la journalisation dans l'interface utilisateur, vous devez indiquer une organisation et un espace. Pour activer la journalisation au niveau du compte, vous pouvez le faire via l'interface de ligne de commande (CLI).
{: tip}


### Avant de commencer

1. Vérifiez les droits. Si vous avez indiqué un espace lors de la création du cluster ou de la configuration de journalisation, le propriétaire du compte et le propriétaire de la clé d'API {{site.data.keyword.containershort_notm}} doivent disposer des droits Responsable, Développeur ou Auditeur dans cet espace.
  * Si vous ne savez pas qui est le propriétaire de la clé d'API {{site.data.keyword.containershort_notm}}, exécutez la commande suivante.
      ```
      bx cs api-key-info <cluster_name>
      ```
      {: pre}
  * Pour appliquer immédiatement les modifications que vous avez apportées à vos droits, exécutez la commande suivante.
      ```
      bx cs logging-config-refresh <cluster_name>
      ```
      {: pre}

  Pour plus d'informations sur la modification des droits et règles d'accès {{site.data.keyword.containershort_notm}}, voir [Gestion de l'accès au cluster](cs_users.html#managing).
  {: tip}

2. [Ciblez avec votre interface de ligne de commande](cs_cli_install.html#cs_cli_configure) le cluster où se trouve la source de journal.

  Si vous utilisez un compte dédié, vous devez vous connecter au noeud final {{site.data.keyword.cloud_notm}} public et cibler votre organisation et votre espace publics afin d'activer le transfert des journaux.
  {: tip}

3. Pour transférer les journaux à syslog, configurez un serveur qui accepte un protocole syslog, en utilisant l'une de ces deux méthodes :
  * Configurer et gérer votre propre serveur ou confier la gestion du serveur à un fournisseur. Dans ce cas, obtenez le noeud final de journalisation du fournisseur de journalisation.
  * Exécuter syslog à partir d'un conteneur. Par exemple, vous pouvez utiliser ce [fichier de déploiement .yaml ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://github.com/IBM-Cloud/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml) pour extraire une image publique Docker qui exécute un conteneur dans un cluster Kubernetes. L'image publie le port `514` sur l'adresse IP du cluster public et utilise cette adresse pour configurer l'hôte syslog.

### Activation du transfert de journal

1. Créez une configuration de transfert de journaux.
    * Pour transférer les journaux vers {{site.data.keyword.loganalysisshort_notm}} :
      ```
      bx cs logging-config-create <my_cluster> --logsource <my_log_source> --namespace <kubernetes_namespace> --hostname <ingestion_URL> --port <ingestion_port> --space <cluster_space> --org <cluster_org> --type ibm --app-containers <containers> --app-paths <paths_to_logs>
      ```
      {: pre}

      ```
      $ cs logging-config-create zac2 --logsource application --app-paths '/var/log/apps.log' --app-containers 'zac1,zac2,zac3'
      Creating logging configuration for application logs in cluster zac2...
      OK
      Id                                     Source        Namespace   Host                                    Port    Org   Space   Protocol   Application Containers   Paths
      aa2b415e-3158-48c9-94cf-f8b298a5ae39   application   -           ingest.logging.stage1.ng.bluemix.net✣   9091✣   -     -       ibm        zac1,zac2,zac3           /var/log/apps.log
      ```
      {: screen}

    * Pour transférer des journaux vers syslog :
      ```
      bx cs logging-config-create <my_cluster> --logsource <my_log_source> --namespace <kubernetes_namespace> --hostname <log_server_hostname_or_IP> --port <log_server_port> --type syslog --app-containers <containers> --app-paths <paths_to_logs>
      ```
      {: pre}

  <table>
    <caption>Description des composantes de cette commande</caption>
  <thead>
    <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composantes de cette commande</th>
  </thead>
  <tbody>
    <tr>
      <td><code><em>&lt;my_cluster&gt;</em></code></td>
      <td>Nom ou ID du cluster.</td>
    </tr>
    <tr>
      <td><code><em>&lt;my_log_source&gt;</em></code></td>
      <td>Source depuis laquelle transférer les journaux. Valeurs admises : <code>container</code>, <code>application</code>, <code>worker</code>, <code>kubernetes</code> et <code>ingress</code>.</td>
    </tr>
    <tr>
      <td><code><em>&lt;kubernetes_namespace&gt;</em></code></td>
      <td>Facultatif : Espace de nom Kubernetes depuis lequel vous désirez transférer des journaux. Le transfert des journaux n'est pas pris en charge pour les espaces de nom Kubernetes <code>ibm-system</code> et <code>kube-system</code>. Cette valeur n'est valide que pour la source de journal <code>container</code>. Si vous n'indiquez pas d'espace de nom, tous les espaces de nom du cluster utilisent cette configuration.</td>
    </tr>
    <tr>
      <td><code><em>&lt;ingestion_URL&gt;</em></code></td>
      <td><p>Pour {{site.data.keyword.loganalysisshort_notm}}, utilisez l'[URL d'ingestion](/docs/services/CloudLogAnalysis/log_ingestion.html#log_ingestion_urls). Si vous n'en indiquez pas, le noeud final de la région dans laquelle vous avez créé le cluster est utilisé.</p>
      <p>Pour syslog, indiquez le nom d'hôte ou l'adresse IP du service collecteur de journal.</p></td>
    </tr>
    <tr>
      <td><code><em>&lt;port&gt;</em></code></td>
      <td>Port d'ingestion. Si vous n'en indiquez aucun, le port standard, <code>9091</code>, est utilisé.
      <p>Pour syslog, indiquez le port du serveur collecteur de journal. Si vous n'indiquez pas de port, le port standard <code>514</code> est utilisé.</td>
    </tr>
    <tr>
      <td><code><em>&lt;cluster_space&gt;</em></code></td>
      <td>Facultatif : Nom de l'espace Cloud Foundry auquel envoyer les journaux. Lors du transfert des journaux vers {{site.data.keyword.loganalysisshort_notm}}, l'espace et l'organisation sont indiqués dans le point d'ingestion. Si vous n'en indiquez aucun, les journaux sont envoyés au niveau du compte.</td>
    </tr>
    <tr>
      <td><code><em>&lt;cluster_org&gt;</em></code></td>
      <td>Nom de l'organisation Cloud Foundry où réside l'espace. Cette valeur est obligatoire si vous avez spécifié un espace.</td>
    </tr>
    <tr>
      <td><code><em>&lt;type&gt;</em></code></td>
      <td>Destination de transfert de vos journaux. Les options possibles sont : <code>ibm</code> pour transférer vos journaux vers {{site.data.keyword.loganalysisshort_notm}} et <code>syslog</code> pour les transférer vers un serveur externe.</td>
    </tr>
    <tr>
      <td><code><em>&lt;paths_to_logs&gt;</em></code></td>
      <td>Chemin dans leurs conteneurs utilisé par les applications pour la journalisation. Pour transférer des journaux avec le type de source <code>application</code>, vous devez indiquer un chemin. Pour indiquer plusieurs chemins, utilisez une liste séparée par des virgules. Exemple : <code>/var/log/myApp1/*/var/log/myApp2/*</code></td>
    </tr>
    <tr>
      <td><code><em>&lt;containers&gt;</em></code></td>
      <td>Facultatif : Lorsque vous transférez les journaux depuis une application, vous pouvez indiquer le nom du conteneur contenant votre application. Vous pouvez spécifier plusieurs conteneurs en utilisant une liste séparée par des virgules. Si aucun conteneur n'est indiqué, les journaux sont transférés à partir de tous les conteneurs contenant les chemins que vous avez fournis.</td>
    </tr>
  </tbody>
  </table>

2. Vérifiez que votre configuration est correcte à l'aide d'une des deux méthodes :

    * Pour répertorier toutes les configurations de journalisation dans le cluster :
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

    * Pour répertorier les configurations de journalisation d'un seul type de source de journal :
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

Pour effectuer une mise à jour de votre configuration, procédez comme suit en remplaçant `bx cs logging-config-create` par `bx cs logging-config-update`. N'oubliez pas de vérifier votre mise à jour.
{: tip}

<br />


## Affichage des journaux
{: #view_logs}

Pour afficher les journaux des clusters et des conteneurs, vous pouvez utiliser les fonctions de journalisation standard de Kubernetes et Docker.
{:shortdesc}

### {{site.data.keyword.loganalysislong_notm}}
{: #view_logs_k8s}

Vous pouvez afficher les journaux que vous avez tranférés vers {{site.data.keyword.loganalysislong_notm}} via le tableau de bord Kibana.
{: shortdesc}

Si vous avez utilisé les valeurs par défaut pour créer le fichier de configuration, vos journaux peuvent se trouver dans le compte, ou dans l'organisation et dans l'espace dans lesquels a été créé le cluster. Si vous avez indiqué une organisation et un espace dans votre fichier de configuration, vous pourrez trouver vos journaux dans cet espace. Pour plus d'informations sur la journalisation, voir [Journalisation pour {{site.data.keyword.containershort_notm}}](/docs/services/CloudLogAnalysis/containers/containers_kubernetes.html#containers_kubernetes).

Pour accéder au tableau de bord Kibana, accédez à l'une des URL suivantes et sélectionnez le compte ou l'espace {{site.data.keyword.Bluemix_notm}} dans lequel vous avez créé le cluster.
- Sud et Est des Etats-Unis : https://logging.ng.bluemix.net
- Sud du Royaume-Uni : https://logging.eu-gb.bluemix.net
- Europe centrale : https://logging.eu-fra.bluemix.net
- Asie-Pacifique sud : https://logging.au-syd.bluemix.net

Pour plus d'informations sur l'affichage des journaux, voir [Accès à Kibana à partir d'un navigateur Web](/docs/services/CloudLogAnalysis/kibana/launch.html#launch_Kibana_from_browser).

### Journaux Docker
{: #view_logs_docker}

Vous pouvez exploiter les capacités de journalisation intégrées de Docker pour examiner les activités sur les flux de sortie
STDOUT et STDERR standard. Pour plus d'informations, voir [Affichage des journaux pour un conteneur s'exécutant dans un cluster Kubernetes](/docs/services/CloudLogAnalysis/containers/containers_kubernetes.html#containers_kubernetes).

<br />


## Arrêt du transfert de journaux
{: #log_sources_delete}

Vous pouvez arrêter le transfert des journaux en supprimant une ou toutes les configurations de journalisation d'un cluster.
{: shortdesc}

1. [Ciblez avec votre interface de ligne de commande](cs_cli_install.html#cs_cli_configure) le cluster où se trouve la source de journal.

2. Supprimez la configuration de journalisation.
<ul>
<li>Pour supprimer une configuration de journalisation :</br>
  <pre><code>bx cs logging-config-rm &lt;my_cluster&gt; --id &lt;log_config_id&gt;</pre></code>
  <table>
    <caption>Description des composantes de cette commande</caption>
      <thead>
        <th colspan=2><img src="images/idea.png" alt="Icône Idée"/> Description des composantes de cette commande</th>
      </thead>
        <tbody>
        <tr>
          <td><code><em>&lt;my_cluster&gt;</em></code></td>
          <td>Nom du cluster dans lequel figure la configuration de journalisation.</td>
        </tr>
        <tr>
          <td><code><em>&lt;log_config_id&gt;</em></code></td>
          <td>ID de la configuration de source de journal.</td>
        </tr>
        </tbody>
  </table></li>
<li>Pour supprimer toutes les configurations de journalisation :</br>
  <pre><code>bx cs logging-config-rm <my_cluster> --all</pre></code></li>
</ul>

<br />


## Configuration du transfert de journaux pour les journaux d'audit d'API Kubernetes
{: #app_forward}

Vous pouvez configurer un webhook via le serveur d'API Kubernetes pour capturer tous les appels depuis votre cluster. Lorsqu'un webhook est activé, les journaux peuvent être envoyés à un serveur distant.
{: shortdesc}

Pour plus d'informations sur les journaux d'audit Kubernetes, reportez-vous à la <a href="https://kubernetes.io/docs/tasks/debug-application-cluster/audit/" target="blank">rubrique consacrée à l'audit <img src="../icons/launch-glyph.svg" alt="Icône de lien externe"></a> dans la documentation Kubernetes.

* Le transfert des journaux d'audit d'API Kubernetes n'est pris en charge qu'à partir de la version 1.7 de Kubernetes.
* Actuellement, une règle d'audit par défaut est utilisée pour tous les clusters avec cette configuration de journalisation.
* Les journaux d'audit peuvent être transférés uniquement vers un serveur externe.
{: tip}

### Activation du transfert de journal d'audit d'API Kubernetes
{: #audit_enable}

Avant de commencer :

1. Configurez un serveur de journalisation distant auquel vous pourrez transférer les journaux. Vous pouvez, par exemple, [utiliser Logstash avec Kubernetes ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/tasks/debug-application-cluster/audit/#use-logstash-to-collect-and-distribute-audit-events-from-webhook-backend) afin de collecter des événements d'audit.

2. [Ciblez votre interface de ligne de commande ](cs_cli_install.html#cs_cli_configure) sur le cluster depuis lequel vous désirez collecter des journaux d'audit de serveur d'API. **Remarque** : Si vous utilisez un compte dédié, vous devez vous connecter au noeud final {{site.data.keyword.cloud_notm}} public et cibler votre organisation et votre espace publics afin d'activer le transfert des journaux.
  

Pour transférer des journaux d'audit d'API Kubernetes, procédez comme suit :

1. Configurez le webhook. Si vous ne soumettez pas d'informations dans les indicateurs, une configuration par défaut est utilisée.

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
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td>Nom ou ID du cluster.</td>
    </tr>
    <tr>
    <td><code><em>&lt;server_URL&gt;</em></code></td>
    <td>URL ou adresse IP du service de journalisation distant auquel vous souhaitez envoyer les journaux. Les certificats sont ignorés si vous fournissez une URL de serveur non sécurisée.</td>
    </tr>
    <tr>
    <td><code><em>&lt;CA_cert_path&gt;</em></code></td>
    <td>Chemin de fichier du certificat de l'autorité de certification utilisé pour vérifier le service de journalisation distant.</td>
    </tr>
    <tr>
    <td><code><em>&lt;client_cert_path&gt;</em></code></td>
    <td>Chemin de fichier du certificat client utilisé pour l'authentification auprès du service de journalisation distant.</td>
    </tr>
    <tr>
    <td><code><em>&lt;client_key_path&gt;</em></code></td>
    <td>Chemin de fichier de la clé du client correspondant utilisée pour la connexion au service de journalisation distant.</td>
    </tr>
    </tbody></table>

2. Vérifiez que le transfert de journaux a été activé en affichant l'URL du service de journalisation distant.

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

### Arrêt du transfert de journaux d'audit d'API Kubernetes
{: #audit_delete}

Vous pouvez cesser le transfert de journaux d'audit en désactivant la configuration de backend webhook pour le serveur d'API du cluster.

Avant de commencer, [ciblez avec votre interface de ligne de commande (CLI)](cs_cli_install.html#cs_cli_configure) le cluster depuis lequel vous désirez cesser de collecter des journaux d'audit de serveur d'API.

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


## Configuration de la surveillance de cluster
{: #monitoring}

Des métriques vous aident à surveiller l'état de santé et les performances de vos clusters. Vous pouvez configurer la surveillance de l'état de santé des noeuds worker de manière à détecter et à rectifier automatiquement tout noeud worker dont l'état s'est dégradé ou qui n'est plus opérationnel. **Remarque** : la surveillance n'est prise en charge que pour les clusters standard.
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
    <dd>Le tableau de bord Kubernetes est une interface Web d'administration dans laquelle vous pouvez examiner l'état de santé de vos noeuds worker, rechercher des ressources Kubernetes, déployer des applications conteneurisées et résoudre les incidents liés aux applications avec les informations de journalisation et de surveillance. Pour plus d'informations sur l'accès à votre tableau de bord Kubernetes, voir [Lancement du tableau de bord Kubernetes pour {{site.data.keyword.containershort_notm}}](cs_app.html#cli_dashboard).</dd>
  <dt>{{site.data.keyword.monitoringlong_notm}}</dt>
    <dd>Les métriques des clusters standard se trouvent dans le compte {{site.data.keyword.Bluemix_notm}} connecté lorsque vous avez créé le cluster Kubernetes. Si vous avez spécifié un espace {{site.data.keyword.Bluemix_notm}} lorsque vous avez créé le cluster, les métriques se trouvent dans cet espace. Les métriques de conteneur sont collectées automatiquement pour tous les conteneurs déployés dans un cluster. Ces métriques sont envoyées et mises à disposition via Grafana. Pour plus d'informations sur les métriques, voir [Surveillance d'{{site.data.keyword.containershort_notm}}](/docs/services/cloud-monitoring/containers/monitoring_containers_ov.html#monitoring_bmx_containers_ov).<p>Pour accéder au tableau de bord Grafana, accédez à l'une des URL suivantes et sélectionnez le compte ou l'espace {{site.data.keyword.Bluemix_notm}} dans lequel vous avez créé le cluster.<ul><li>Sud et Est des Etats-Unis : https://metrics.ng.bluemix.net</li><li>Sud du Royaume-Uni : https://metrics.eu-gb.bluemix.net</li><li>Europe centrale : https://metrics.eu-de.bluemix.net</li></ul></p></dd>
</dl>

### Autres outils de surveillance de l'état de santé
{: #health_tools}

Vous pouvez configurer d'autres outils pour disposer de capacités de surveillance supplémentaires.
<dl>
  <dt>Prometheus</dt>
    <dd>Prometheus est un outil open source de surveillance, de journalisation et d'alerte conçu pour Kubernetes. Cet outil extrait des informations détaillées sur le cluster, les noeuds worker et l'état de santé du déploiement à partir des informations de journalisation de Kubernetes. Pour obtenir des informations de configuration, voir [Intégration de services avec {{site.data.keyword.containershort_notm}}](cs_integrations.html#integrations).</dd>
</dl>

<br />


## Configuration de la surveillance de l'état de santé des noeuds worker avec le système de reprise automatique
{: #autorecovery}

Le système de reprise automatique d'{{site.data.keyword.containerlong_notm}} peut être déployé dans des clusters existants de Kubernetes version 1.7 ou ultérieure.
{: shortdesc}

Le système de reprise automatique effectue diverses vérifications pour obtenir l'état de santé des noeuds worker. Si le système de reprise automatique détecte un mauvais état de santé d'un noeud worker d'après les vérifications configurées, il déclenche une mesure corrective (par exemple, un rechargement du système d'exploitation) sur le noeud worker. Un seul noeud worker à la fois fait l'objet d'une mesure corrective. La mesure corrective doit réussir sur le noeud worker pour que d'autre noeuds worker bénéficient d'une mesure corrective. Pour plus d'informations, reportez-vous à cet [article du blogue Autorecovery ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://www.ibm.com/blogs/bluemix/2017/12/autorecovery-utilizes-consistent-hashing-high-availability/).
**REMARQUE** : Le système de reprise automatique nécessite qu'au moins un noeud worker soit opérationnel pour fonctionner correctement. Configurez le système de reprise automatique avec des vérifications actives uniquement dans les clusters contenant au moins deux noeuds worker.

Avant de commencer, [ciblez avec votre interface de ligne de commande](cs_cli_install.html#cs_cli_configure) le cluster dans lequel vous voulez vérifier les statuts des noeuds worker.

1. Créez un fichier de mappe de configuration (ConfigMap) qui définit vos vérifications au format JSON. Par exemple, le fichier YAML suivant définit trois vérifications : une vérification HTTP et deux vérifications de serveur d'API Kubernetes.</br>
   **Astuce :** définissez chaque vérification sous forme de clé unique dans la section data de la mappe de configuration.

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

   <table summary="Description des composants de configmap">
   <caption>Description des composants de configmap</caption>
   <thead>
   <th colspan=2><img src="images/idea.png" alt="Icône Idée"/>Description des composants de configmap</th>
   </thead>
   <tbody>
   <tr>
   <td><code>name</code></td>
   <td>Le nom de configuration <code>ibm-worker-recovery-checks</code> est une constante et ne peut pas être modifié.</td>
   </tr>
   <tr>
   <td><code>namespace</code></td>
   <td>L'espace de nom <code>kube-system</code> est une constante et ne peut pas être modifié.</td>
   </tr>
   <tr>
   <td><code>checkhttp.json</code></td>
   <td>Définit une vérification HTTP qui s'assure qu'un serveur HTTP est en opération sur l'adresse IP de chaque noeud sur le port 80 et renvoie une réponse 200 sur le chemin <code>/myhealth</code>. Vous pouvez identifier l'adresse IP d'un noeud en exécutant la commande <code>kubectl get nodes</code>.
Par exemple, envisagez deux noeuds dans un cluster avec les adresses IP 10.10.10.1 et 10.10.10.2. Dans cet exemple, deux routes sont vérifiées pour renvoi de réponses 200 OK : <code>http://10.10.10.1:80/myhealth</code> et <code>http://10.10.10.2:80/myhealth</code>.
La vérification dans l'exemple YAML s'exécute toutes les 3 minutes. Si elle échoue à trois reprises, le noeud est réamorcé. Cette action est équivalente à la commande <code>bx cs worker-reboot</code>. La vérification HTTP est désactivée jusqu'à ce que vous affectiez à la zone <b>Enabled</b> la valeur <code>true</code>.      </td>
   </tr>
   <tr>
   <td><code>checknode.json</code></td>
   <td>Définit une vérification de noeud d'API Kubernetes pour s'assurer que l'état de chaque noeud indique <code>Ready</code> (Prêt). La vérification d'un noeud spécifique compte comme un échec si le noeud n'est pas à l'état <code>Ready</code>.
La vérification dans l'exemple YAML s'exécute toutes les 3 minutes. Si elle échoue à trois reprises, le noeud est rechargé. Cette action est équivalente à la commande <code>bx cs worker-reload</code>. La vérification de noeud est activée tant que vous n'affectez pas à la zone <b>Enabled</b> la valeur <code>false</code> ou supprimez la vérification.</td>
   </tr>
   <tr>
   <td><code>checkpod.json</code></td>
   <td>Définit une vérification de pod d'API Kubernetes qui vérifie le pourcentage total de pods <code>NotReady</code> sur un noeud par rapport à tous les pods qui sont affectés à ce noeud. La vérification d'un noeud spécifique compte comme un échec si le pourcentage total de pods à l'état <code>NotReady</code> est supérieur à la valeur définie pour <code>PodFailureThresholdPercent</code>.
La vérification dans l'exemple YAML s'exécute toutes les 3 minutes. Si elle échoue à trois reprises, le noeud est rechargé. Cette action est équivalente à la commande <code>bx cs worker-reload</code>. La vérification de pod est activée tant que vous n'affectez pas à la zone <b>Enabled</b> la valeur <code>false</code> ou supprimez la vérification.</td>
   </tr>
   </tbody>
   </table>


   <table summary="Description des composants de règle individuelle">
   <caption>Description des composants de règle individuelle</caption>
   <thead>
   <th colspan=2><img src="images/idea.png" alt="Icône Idée"/>Description des composants de règle individuelle </th>
   </thead>
   <tbody>
   <tr>
   <td><code>Check</code></td>
   <td>Indiquez le type de vérification que le système de reprise automatique doit effectuer. <ul><li><code>HTTP</code> : La reprise automatique appelle les serveurs HTTP qui s'exécutent sur chaque noeud afin de déterminer si les noeuds s'exécutent correctement.</li><li><code>KUBEAPI</code> : La reprise automatique appelle le serveur d'API Kubernetes et lit les données d'état de santé renvoyées par les noeuds worker.</li></ul></td>
   </tr>
   <tr>
   <td><code>Resource</code></td>
   <td>Lorsque le type de vérification est <code>KUBEAPI</code>, entrez le type de ressource que le système de reprise automatique doit vérifier. Les valeurs admises sont <code>NODE</code> ou <code>PODS</code>.</td>
   </tr>
   <tr>
   <td><code>FailureThreshold</code></td>
   <td>Indiquez le seuil du nombre d'échecs de vérification consécutifs. Lorsque ce seuil est atteint, le système de reprise automatique déclenche la mesure corrective spécifiée. Par exemple, si la valeur de seuil est 3 et qu'une vérification configurée de la reprise automatique échoue trois fois consécutivement, le système de reprise automatique déclenche la mesure corrective associée à la vérification.</td>
   </tr>
   <tr>
   <td><code>PodFailureThresholdPercent</code></td>
   <td>Lorsque le type de ressource est <code>PODS</code>, indiquez le seuil du pourcentage de pods sur un noeud worker pouvant présenter l'état [NotReady ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/#define-readiness-probes). Ce pourcentage se base sur le nombre total de pods planifiés d'un noeud worker. Lorsqu'une vérification détermine que le pourcentage de pods ayant un mauvais état de santé est supérieur au seuil spécifié, la vérification compte comme un échec.</td>
   </tr>
   <tr>
   <td><code>CorrectiveAction</code></td>
   <td>Indiquez l'action à exécuter lorsque le seuil d'échec est atteint. Une mesure corrective ne s'exécute que si aucun autre noeud worker ne fait l'objet d'une réparation et si le noeud worker traité n'est pas hors fonction en raison d'une action précédente. <ul><li><code>REBOOT</code> : Réamorce le noeud worker.</li><li><code>RELOAD</code> : Recharge toutes les configurations requises pour le noeud worker à partir d'un système d'exploitation propre.</li></ul></td>
   </tr>
   <tr>
   <td><code>CooloffSeconds</code></td>
   <td>Indiquez le nombre de secondes que doit attendre la reprise automatique avant de lancer une autre mesure corrective pour un noeud qui a déjà fait l'objet d'une mesure corrective. Ce délai d'attente commence au moment où la mesure corrective est émise.</td>
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
   <td>Lorsque le type de vérification est <code>HTTP</code>, indiquez le port auquel le serveur HTTP doit se lier sur les noeuds worker. Ce port doit être exposé sur l'adresse IP de chaque noeud worker du cluster. La reprise automatique a besoin d'un numéro de port constant sur tous les noeuds pour vérifier les serveurs. Utilisez des [DaemonSets ![Icône de lien externe](../icons/launch-glyph.svg "Icône de lien externe")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) lorsque vous déployez un serveur personnalisé dans un cluster.</td>
   </tr>
   <tr>
   <td><code>ExpectedStatus</code></td>
   <td>Lorsque le type de vérification est <code>HTTP</code>, indiquez le statut du serveur HTTP que la vérification doit renvoyer. Par exemple, la valeur 200 indique que vous escomptez une réponse <code>OK</code> du serveur.</td>
   </tr>
   <tr>
   <td><code>Route</code></td>
   <td>Lorsque le type de vérification est <code>HTTP</code>, indiquez le chemin demandé au serveur HTTP. Cette valeur correspond généralement au chemin des métriques du serveur qui s'exécute sur tous les noeuds worker.</td>
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

4. Déployez le système de reprise automatique dans votre cluster en appliquant ce fichier YAML.

   ```
   kubectl apply -f https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/ibm-worker-recovery/ibm-worker-recovery.yml
   ```
   {: pre}

5. Au bout de quelques minutes, vous pouvez vérifier la section `Events` dans la sortie de la commande suivante pour visualiser l'activité sur le déploiement du système de reprise automatique.

    ```
    kubectl -n kube-system describe deployment ibm-worker-recovery
    ```
    {: pre}
