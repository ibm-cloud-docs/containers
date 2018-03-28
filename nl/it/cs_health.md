---

copyright:
  years: 2014, 2018
lastupdated: "2018-02-02"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Registrazione e monitoraggio dei cluster 
{: #health}

Configura la registrazione e il monitoraggio del cluster per aiutarti a risolvere i problemi con i tuoi cluster e applicazioni e a monitorare l'integrità e le prestazioni dei tuoi cluster.
{:shortdesc}

## Configurazione della registrazione cluster
{: #logging}

Puoi inviare i log in una posizione specifica per l'elaborazione o l'archiviazione di lungo termine. Su un cluster Kubernetes in {{site.data.keyword.containershort_notm}}, puoi abilitare l'inoltro dei log per il tuo cluster e scegliere la posizione in cui i log verranno inoltrati. **Nota**: l'inoltro dei log è supportato solo per i cluster standard.
{:shortdesc}

Puoi inoltrare i tuoi log per le origini dei log quali contenitori, applicazioni, nodi di lavoro, cluster Kubernetes e controller Ingress. Rivedi la seguente tabella per informazioni su ciascuna origine log. 

|Origine log|Caratteristiche|Percorsi log|
|----------|---------------|-----|
|`container`|Log per il tuo contenitore in esecuzione in un cluster Kubernetes. |-|
|`application`|Log per la tua applicazione eseguita in un cluster Kubernetes.|`/var/log/apps/**/*.log`, `/var/log/apps/**/*.err`|
|`worker`|Log per i nodi di lavoro della macchina virtuale in un cluster Kubernetes.|`/var/log/syslog`, `/var/log/auth.log`|
|`kubernetes`|Log per il componente di sistema Kubernetes.|`/var/log/kubelet.log`, `/var/log/kube-proxy.log`|
|`ingress`|Log per un programma di bilanciamento del carico dell'applicazione Ingress che gestisce il traffico di rete in arrivo in un cluster Kubernetes. |`/var/log/alb/ids/*.log`, `/var/log/alb/ids/*.err`, `/var/log/alb/customerlogs/*.log`, `/var/log/alb/customerlogs/*.err`|
{: caption="Caratteristiche delle origini log " caption-side="top"}

## Abilitazione dell'inoltro dei log 
{: #log_sources_enable}

Puoi inoltrare i log a {{site.data.keyword.loganalysislong_notm}} o a un server syslog esterno. Se vuoi inoltrare i log da un'origine log a entrambi i server di raccolta log, devi creare due configurazioni di registrazione. **Nota**: per inoltrare i log per le applicazioni, consulta [Abilitazione dell'inoltro dei log per le applicazioni](#apps_enable).
{:shortdesc}

Prima di iniziare:

1. Se vuoi inoltrare i log a un server syslog esterno, puoi configurare un server che accetti un protocollo syslog in due modi:
  * Configura e gestisci il tuo proprio server o utilizza un provider per gestirlo al tuo posto. Se un provider gestisce il server al tuo posto, richiama l'endpoint di registrazione dal provider di registrazione.
  * Esegui syslog da un contenitore. Ad esempio, puoi utilizzare questo [file .yaml di distribuzione![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/IBM-Bluemix/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml) per recuperare un'immagine pubblica Docker che esegue un contenitore in un cluster Kubernetes. L'immagine pubblica la porta `514` sull'indirizzo IP del cluster pubblico e utilizza questo indirizzo IP per configurare l'host syslog.

2. [Indirizza la tua CLI](cs_cli_install.html#cs_cli_configure) al cluster in cui si trova l'origine log.

Per abilitare l'inoltro dei log per un contenitore, un nodo di lavoro, un componente di sistema Kubernetes, un'applicazione o il programma di bilanciamento del carico dell'applicazione Ingress:

1. Crea una configurazione di inoltro dei log.

  * Per inoltrare i log a {{site.data.keyword.loganalysislong_notm}}:

    ```
    bx cs logging-config-create <my_cluster> --logsource <my_log_source> --namespace <kubernetes_namespace> --hostname <ingestion_URL> --port <ingestion_port> --space <cluster_space> --org <cluster_org> --type ibm
    ```
    {: pre}

    <table>
    <caption>Descrizione dei componenti di questo comando</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti di questo comando</th>
    </thead>
    <tbody>
    <tr>
    <td><code>logging-config-create</code></td>
    <td>Il comando per creare una configurazione di inoltro dei log {{site.data.keyword.loganalysislong_notm}}.</td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td>Sostituisci <em>&lt;my_cluster&gt;</em> con il nome o l'ID del cluster.</td>
    </tr>
    <tr>
    <td><code>--logsource <em>&lt;my_log_source&gt;</em></code></td>
    <td>Sostituisci <em>&lt;my_log_source&gt;</em> con l'origine log. I valori accettati sono <code>container</code>, <code>application</code>, <code>worker</code>, <code>kubernetes</code> e <code>ingress</code>.</td>
    </tr>
    <tr>
    <td><code><em>&lt;kubernetes_namespace&gt;</em></code></td>
    <td>Sostituisci <em>&lt;kubernetes_namespace&gt;</em> con lo spazio dei nomi Kubernetes a cui vuoi inoltrare i log. L'inoltro del log non è supportato per gli spazi dei nomi Kubernetes <code>ibm-system</code> e <code>kube-system</code>. Questo valore è valido solo per l'origine del log del contenitore ed è facoltativo. Se non specifichi uno spazio dei nomi, tutti gli spazi dei nomi nel cluster utilizzeranno questa configurazione.</td>
    </tr>
    <tr>
    <td><code>--hostname <em>&lt;ingestion_URL&gt;</em></code></td>
    <td>Sostituisci <em>&lt;ingestion_URL&gt;</em> con l'URL di inserimento {{site.data.keyword.loganalysisshort_notm}}. Puoi trovare l'elenco degli URL di inserimento disponibili [qui](/docs/services/CloudLogAnalysis/log_ingestion.html#log_ingestion_urls). Se non specifichi un URL di inserimento, viene utilizzato l'endpoint della regione in cui è stato creato il tuo cluster.</td>
    </tr>
    <tr>
    <td><code>--port <em>&lt;ingestion_port&gt;</em></code></td>
    <td>Sostituisci <em>&lt;ingestion_port&gt;</em> con la porta di inserimento. Se non specifichi una porta, viene utilizzata la porta standard <code>9091</code>.</td>
    </tr>
    <tr>
    <td><code>--space <em>&lt;cluster_space&gt;</em></code></td>
    <td>Sostituisci <em>&lt;cluster_space&gt;</em> con il nome dello spazio Cloud Foundry a cui vuoi inviare i log. Se non specifichi uno spazio, i log vengono inviati al livello dell'account.</td>
    </tr>
    <tr>
    <td><code>--org <em>&lt;cluster_org&gt;</em></code></td>
    <td>Sostituisci <em>&lt;cluster_org&gt;</em> con il nome dell'organizzazione Cloud Foundry in cui si trova lo spazio. Questo valore è obbligatorio se hai specificato uno spazio.</td>
    </tr>
    <tr>
    <td><code>--type ibm</code></td>
    <td>Il tipo di logo per l'invio dei log a {{site.data.keyword.loganalysisshort_notm}}.</td>
    </tr>
    </tbody></table>

  * Per inoltrare i log a un server syslog esterno:

    ```
    bx cs logging-config-create <my_cluster> --logsource <my_log_source> --namespace <kubernetes_namespace> --hostname <log_server_hostname_or_IP> --port <log_server_port> --type syslog
    ```
    {: pre}

    <table>
    <caption>Descrizione dei componenti di questo comando</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti di questo comando</th>
    </thead>
    <tbody>
    <tr>
    <td><code>logging-config-create</code></td>
    <td>Il comando per creare una configurazione di inoltro dei log syslog. </td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td>Sostituisci <em>&lt;my_cluster&gt;</em> con il nome o l'ID del cluster.</td>
    </tr>
    <tr>
    <td><code>--logsource <em>&lt;my_log_source&gt;</em></code></td>
    <td>Sostituisci <em>&lt;my_log_source&gt;</em> con l'origine log. I valori accettati sono <code>container</code>, <code>application</code>, <code>worker</code>, <code>kubernetes</code> e <code>ingress</code>.</td>
    </tr>
    <tr>
    <td><code><em>&lt;kubernetes_namespace&gt;</em></code></td>
    <td>Sostituisci <em>&lt;kubernetes_namespace&gt;</em> con lo spazio dei nomi Kubernetes a cui vuoi inoltrare i log. L'inoltro del log non è supportato per gli spazi dei nomi Kubernetes <code>ibm-system</code> e <code>kube-system</code>. Questo valore è valido solo per l'origine del log del contenitore ed è facoltativo. Se non specifichi uno spazio dei nomi, tutti gli spazi dei nomi nel cluster utilizzeranno questa configurazione.</td>
    </tr>
    <tr>
    <td><code>--hostname <em>&lt;log_server_hostname_or_IP&gt;</em></code></td>
    <td>Sostituisci <em>&lt;log_server_hostname&gt;</em> con il nome host o l'indirizzo IP del servizio di raccolta del log. </td>
    </tr>
    <tr>
    <td><code>--port <em>&lt;log_server_port&gt;</em></code></td>
    <td>Sostituisci <em>&lt;log_server_port&gt;</em> con la porta del server di raccolta del log. Se non specifichi una porta, viene utilizzata la porta standard <code>514</code>.</td>
    </tr>
    <tr>
    <td><code>--type syslog</code></td>
    <td>Il tipo di log per l'invio dei log a un server syslog esterno. </td>
    </tr>
    </tbody></table>

2. Verifica che la configurazione di inoltro del log sia stata creata.

    * Per elencare tutte le configurazioni di registrazione nel cluster:
      ```
      bx cs logging-config-get <my_cluster>
      ```
      {: pre}

      Output di esempio:

      ```
      Id                                    Source       Namespace     Host                          Port   Org      Space      Protocol     Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  kubernetes   -             172.30.162.138                5514   -        -          syslog       /var/log/kubelet.log,/var/log/kube-proxy.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  application  -             ingest.logging.ng.bluemix.net 9091   my_org   my_space   ibm          /var/log/apps/**/*.log,/var/log/apps/**/*.err
      8a284f1a-451c-4c48-b1b4-a4e6b977264e  containers   my-namespace  myhostname.common             5514   -        -          syslog       -
      ```
      {: screen}

    * Per elencare le configurazioni di registrazione per un tipo di origine log:
      ```
      bx cs logging-config-get <my_cluster> --logsource worker
      ```
      {: pre}

      Output di esempio:

      ```
      Id                                    Source    Namespace   Host                            Port   Org    Space     Protocol    Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  worker    -           ingest.logging.ng.bluemix.net   9091   -      -         ibm         /var/log/syslog,/var/log/auth.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  worker    -           172.30.162.138                  5514   -      -         syslog      /var/log/syslog,/var/log/auth.log
      ```
      {: screen}


### Abilitazione dell'inoltro dei log per le applicazioni
{: #apps_enable}

I log delle applicazioni devono essere vincolati a una directory specifica sul nodo host. Puoi farlo montando un volume del percorso host nei contenitori con un percorso di montaggio. Questo percorso di montaggio funge da directory sui tuoi contenitori in cui vengono inviati i log delle applicazioni. La directory del percorso host predefinita, `/var/log/apps`, viene creata automaticamente quando crei il montaggio del volume.

Rivedi i seguenti aspetti dell'inoltro dei log dell'applicazione:
* I log vengono letti in modo ricorsivo dal percorso /var/log/apps. Ciò significa che puoi inserire i log dell'applicazione nelle sottodirectory del percorso /var/log/apps.
* Vengono inoltrati solo i file di log dell'applicazione con le estensioni `.log` o `.err`.
* Quando abiliti l'inoltro dei log per la prima volta, i log dell'applicazione vengono messi in coda invece di essere letti dall'inizio. Ciò significa che il contenuto di eventuali log già presenti prima che la registrazione dell'applicazione venisse abilitata non viene letto. I log vengono letti dal punto in cui la registrazione è stata abilitata. Tuttavia, una volta che l'inoltro dei log è stato abilitato, i log vengono sempre prelevati dal punto in cui erano stati interrotti.
* Quando monti il volume del percorso host `/var/log/apps` nei contenitori, tutti i contenitori scrivono in questa stessa directory. Ciò significa che se i tuoi contenitori scrivono nello stesso nome file, i contenitori scriveranno nello stesso identico file sull'host. Se questa non è la tua intenzione, puoi impedire ai tuoi contenitori di sovrascrivere gli stessi file di log nominando i file di log da ciascun contenitore in modo diverso.
* Poiché tutti i contenitori scrivono nello stesso nome file, non utilizzare questo metodo per inoltrare i log dell'applicazione per le serie di repliche. Puoi invece scrivere i log dall'applicazione in STDOUT e STDERR, che vengono prelevati come log del contenitore. Per inoltrare i log dell'applicazione scritti in STDOUT e STDERR, segui la procedura in [Abilitazione dell'inoltro dei log](cs_health.html#log_sources_enable).

Prima di iniziare, [indirizza la tua CLI](cs_cli_install.html#cs_cli_configure) al cluster in cui si trova l'origine log.

1. Apri il file di configurazione `.yaml` per il pod dell'applicazione.

2. Aggiungi i seguenti `volumeMounts` e `volumes` al file di configurazione:

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

2. Monta il volume nel pod.

    ```
    kubectl apply -f <local_yaml_path>
    ```
    {:pre}

3. Per creare una configurazione di inoltro dei log, segui la procedura indicata in [Abilitazione dell'inoltro dei log](cs_health.html#log_sources_enable).

<br />


## Aggiornamento della configurazione di inoltro dei log 
{: #log_sources_update}

Puoi aggiornare una configurazione di registrazione per un contenitore, un nodo di lavoro, un componente di sistema Kubernetes, un'applicazione o il programma di bilanciamento del carico dell'applicazione Ingress.
{: shortdesc}

Prima di iniziare:

1. Se modifichi il server di raccolta log in un server syslog, puoi configurare un server che accetti un protocollo syslog in due modi:
  * Configura e gestisci il tuo proprio server o utilizza un provider per gestirlo al tuo posto. Se un provider gestisce il server al tuo posto, richiama l'endpoint di registrazione dal provider di registrazione.
  * Esegui syslog da un contenitore. Ad esempio, puoi utilizzare questo [file .yaml di distribuzione![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/IBM-Bluemix/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml) per recuperare un'immagine pubblica Docker che esegue un contenitore in un cluster Kubernetes. L'immagine pubblica la porta `514` sull'indirizzo IP del cluster pubblico e utilizza questo indirizzo IP per configurare l'host syslog.

2. [Indirizza la tua CLI](cs_cli_install.html#cs_cli_configure) al cluster in cui si trova l'origine log.

Per modificare i dettagli di una configurazione di registrazione:

1. Aggiorna la configurazione di registrazione.

    ```
    bx cs logging-config-update <my_cluster> --id <log_config_id> --logsource <my_log_source> --hostname <log_server_hostname_or_IP> --port <log_server_port> --space <cluster_space> --org <cluster_org> --type <logging_type>
    ```
    {: pre}

    <table>
    <caption>Descrizione dei componenti di questo comando</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti di questo comando</th>
    </thead>
    <tbody>
    <tr>
    <td><code>logging-config-update</code></td>
    <td>Il comando per aggiornare la configurazione di inoltro dei log per la tua origine log.</td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td>Sostituisci <em>&lt;my_cluster&gt;</em> con il nome o l'ID del cluster.</td>
    </tr>
    <tr>
    <td><code>--id <em>&lt;log_config_id&gt;</em></code></td>
    <td>Sostituisci <em>&lt;log_config_id&gt;</em> con l'ID della configurazione dell'origine log.</td>
    </tr>
    <tr>
    <td><code>--logsource <em>&lt;my_log_source&gt;</em></code></td>
    <td>Sostituisci <em>&lt;my_log_source&gt;</em> con l'origine log. I valori accettati sono <code>container</code>, <code>application</code>, <code>worker</code>, <code>kubernetes</code> e <code>ingress</code>.</td>
    </tr>
    <tr>
    <td><code>--hostname <em>&lt;log_server_hostname_or_IP&gt;</em></code></td>
    <td>Quando il tipo di registrazione è <code>syslog</code>, sostituisci <em>&lt;log_server_hostname_or_IP&gt;</em> con il nome host o l'indirizzo IP del servizio di raccolta del log. Quando il tipo di registrazione è <code>ibm</code>, sostituisci <em>&lt;log_server_hostname&gt;</em> con l'URL di inserimento {{site.data.keyword.loganalysislong_notm}}. Puoi trovare l'elenco degli URL di inserimento disponibili [qui](/docs/services/CloudLogAnalysis/log_ingestion.html#log_ingestion_urls). Se non specifichi un URL di inserimento, viene utilizzato l'endpoint della regione in cui è stato creato il tuo cluster.</td>
    </tr>
    <tr>
    <td><code>--port <em>&lt;log_collector_port&gt;</em></code></td>
    <td>Sostituisci <em>&lt;log_server_port&gt;</em> con la porta del server di raccolta del log. Se non specifichi una porta, viene utilizzata la porta standard <code>514</code> per <code>syslog</code> e <code>9091</code> per <code>ibm</code>.</td>
    </tr>
    <tr>
    <td><code>--space <em>&lt;cluster_space&gt;</em></code></td>
    <td>Sostituisci <em>&lt;cluster_space&gt;</em> con il nome dello spazio Cloud Foundry a cui vuoi inviare i log. Questo valore è valido solo per il tipo di log <code>ibm</code> ed è facoltativo. Se non specifichi uno spazio, i log vengono inviati al livello dell'account.</td>
    </tr>
    <tr>
    <td><code>--org <em>&lt;cluster_org&gt;</em></code></td>
    <td>Sostituisci <em>&lt;cluster_org&gt;</em> con il nome dell'organizzazione Cloud Foundry in cui si trova lo spazio. Questo valore è valido solo per il tipo di log <code>ibm</code> ed è obbligatorio se hai specificato uno spazio.</td>
    </tr>
    <tr>
    <td><code>--type <em>&lt;logging_type&gt;</em></code></td>
    <td>Sostituisci <em>&lt;logging_type&gt;</em> con il nuovo protocollo di inoltro dei log che vuoi utilizzare. Al momento, sono supportati <code>syslog</code> e <code>ibm</code>.</td>
    </tr>
    </tbody></table>

2. Verifica che la configurazione di inoltro del log sia stata aggiornata.

    * Per elencare tutte le configurazioni di registrazione nel cluster:

      ```
      bx cs logging-config-get <my_cluster>
      ```
      {: pre}

      Output di esempio:

      ```
      Id                                    Source       Namespace     Host                          Port   Org      Space      Protocol     Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  kubernetes   -             172.30.162.138                5514   -        -          syslog       /var/log/kubelet.log,/var/log/kube-proxy.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  application  -             ingest.logging.ng.bluemix.net 9091   my_org   my_space   ibm          /var/log/apps/**/*.log,/var/log/apps/**/*.err
      8a284f1a-451c-4c48-b1b4-a4e6b977264e  containers   my-namespace  myhostname.common             5514   -        -          syslog       -
      ```
      {: screen}

    * Per elencare le configurazioni di registrazione per un tipo di origine log:

      ```
      bx cs logging-config-get <my_cluster> --logsource worker
      ```
      {: pre}

      Output di esempio:

      ```
      Id                                    Source    Namespace   Host                            Port   Org    Space     Protocol    Paths
      f4bc77c0-ee7d-422d-aabf-a4e6b977264e  worker    -           ingest.logging.ng.bluemix.net   9091   -      -         ibm         /var/log/syslog,/var/log/auth.log
      5bd9c609-13c8-4c48-9d6e-3a6664c825a9  worker    -           172.30.162.138                  5514   -      -         syslog      /var/log/syslog,/var/log/auth.log
      ```

      {: screen}

<br />


## Arresto dell'inoltro dei log
{: #log_sources_delete}

Puoi arrestare l'inoltro dei log eliminando la configurazione di registrazione.

Prima di iniziare, [indirizza la tua CLI](cs_cli_install.html#cs_cli_configure) al tuo cluster in cui si trova l'origine log.

1. Elimina la configurazione di registrazione.

    ```
    bx cs logging-config-rm <my_cluster> --id <log_config_id>
    ```
    {: pre}
    Sostituisci <em>&lt;my_cluster&gt;</em> con il nome del cluster in cui si trova la configurazione di registrazione e <em>&lt;log_config_id&gt;</em> con l'ID della configurazione dell'origine log.

<br />


## Configurazione dell'inoltro del log per i log di controllo dell'API Kubernetes 
{: #app_forward}

I log di controllo dell'API Kubernetes acquisiscono tutte le chiamate dal server dell'API Kubernetes dal tuo cluster. Per iniziare a raccogliere i log di controllo dell'API Kubernetes, puoi configurare il server dell'API Kubernetes per impostare un backend webhook per il tuo cluster. Questo backend webhook abilita l'invio dei log a un server remoto. Per ulteriori informazioni sui log di controllo Kubernetes, consulta l'<a href="https://kubernetes.io/docs/tasks/debug-application-cluster/audit/" target="_blank">argomento di controllo <img src="../icons/launch-glyph.svg" alt="Icona link esterno"></a> nella documentazione Kubernetes.

**Nota**:
* L'inoltro dei log di controllo dell'API Kubernetes è supportato solo per la versione Kubernetes 1.7 e più recente.
* Al momento, viene utilizzata una politica di controllo predefinita per tutti i cluster con questa configurazione di registrazione.

### Abilitazione dell'inoltro dei log dell'API Kubernetes 
{: #audit_enable}

Prima di iniziare:

1. Configura un server di registrazione remota dove puoi inoltrare i log. Ad esempio, puoi [utilizzare Logstash con Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/tasks/debug-application-cluster/audit/#use-logstash-to-collect-and-distribute-audit-events-from-webhook-backend) per raccogliere gli eventi di controllo.

2. [Indirizza la tua CLI](cs_cli_install.html#cs_cli_configure) al cluster dai cui vuoi vengano raccolti i log di controllo del server API.

Per inoltrare i log di controllo dell'API Kubernetes:

1. Imposta il backend webhook per la configurazione del server API. Una configurazione webhook viene creata in base alle informazioni che fornisci negli indicatori di questo comando. Se non fornisci alcuna informazione negli indicatori, viene utilizzata una configurazione webhook predefinita.

    ```
    bx cs apiserver-config-set audit-webhook <my_cluster> --remoteServer <server_URL_or_IP> --caCert <CA_cert_path> --clientCert <client_cert_path> --clientKey <client_key_path>
    ```
    {: pre}

    <table>
    <caption>Descrizione dei componenti di questo comando</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti di questo comando</th>
    </thead>
    <tbody>
    <tr>
    <td><code>apiserver-config-set</code></td>
    <td>Il comando per impostare un'opzione per la configurazione del server API Kubernetes del cluster.</td>
    </tr>
    <tr>
    <td><code>audit-webhook</code></td>
    <td>Il comando secondario per impostare la configurazione webhook di controllo per il server dell'API Kubernetes del cluster.</td>
    </tr>
    <tr>
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td>Sostituisci <em>&lt;my_cluster&gt;</em> con il nome o l'ID del cluster.</td>
    </tr>
    <tr>
    <td><code>--remoteServer <em>&lt;server_URL&gt;</em></code></td>
    <td>Sostituisci <em>&lt;server_URL&gt;</em> con l'URL o l'indirizzo IP del servizio di registrazione remota a cui vuoi inviare i log. Se fornisci un URL del server non sicuro, vengono ignorati tutti i certificati. </td>
    </tr>
    <tr>
    <td><code>--caCert <em>&lt;CA_cert_path&gt;</em></code></td>
    <td>Sostituisci <em>&lt;CA_cert_path&gt;</em> con il percorso del file di un certificato CA utilizzato per verificare il servizio di registrazione remota.</td>
    </tr>
    <tr>
    <td><code>--clientCert <em>&lt;client_cert_path&gt;</em></code></td>
    <td>Sostituisci <em>&lt;client_cert_path&gt;</em> con il percorso del file di un certificato client utilizzato per l'autenticazione con il servizio di registrazione remota.</td>
    </tr>
    <tr>
    <td><code>--clientKey <em>&lt;client_key_path&gt;</em></code></td>
    <td>Sostituisci <em>&lt;client_key_path&gt;</em> con il percorso del file della chiave client corrispondente utilizzata per il collegamento al servizio di registrazione remota.</td>
    </tr>
    </tbody></table>

2. Verifica che l'inoltro dei log sia stato abilitato visualizzando l'URL per il servizio di registrazione remota.

    ```
    bx cs apiserver-config-get audit-webhook <my_cluster>
    ```
    {: pre}

    Output di esempio:
    ```
    OK
    Server:			https://8.8.8.8
    ```
    {: screen}

3. Applica l'aggiornamento della configurazione riavviando il master Kubernetes.

    ```
    bx cs apiserver-refresh <my_cluster>
    ```
    {: pre}

### Arresto dell'inoltro dei log dell'API Kubernetes 
{: #audit_delete}

Puoi arrestare l'inoltro dei log di controllo disabilitando la configurazione backend webhook per il server API del cluster. 

Prima di iniziare, [indirizza la tua CLI](cs_cli_install.html#cs_cli_configure) al cluster da cui vuoi arrestare la raccolta dei log di controllo dell'API.

1. Disabilita la configurazione backend webhook per il server API del cluster.

    ```
    bx cs apiserver-config-unset audit-webhook <my_cluster>
    ```
    {: pre}

2. Applica l'aggiornamento della configurazione riavviando il master Kubernetes.

    ```
    bx cs apiserver-refresh <my_cluster>
    ```
    {: pre}

<br />


## Visualizzazione dei log
{: #view_logs}

Per visualizzare i log dei cluster e dei contenitori, puoi utilizzare le funzioni di registrazione Docker e Kubernetes standard.
{:shortdesc}

### {{site.data.keyword.loganalysislong_notm}}
{: #view_logs_k8s}

Per i cluster standard, i log si trovano nell'account {{site.data.keyword.Bluemix_notm}} al quale hai effettuato l'accesso quando hai creato il cluster Kubernetes. Se hai specificato uno spazio {{site.data.keyword.Bluemix_notm}} quando hai creato il cluster o la configurazione di registrazione, i log vengono posizionati in tale spazio. I log vengono monitorati e inoltrati all'esterno del contenitore. Puoi accedere ai log per un contenitore utilizzando il dashboard Kibana. Per ulteriori informazioni sulla registrazione, consulta [Registrazione di {{site.data.keyword.containershort_notm}}](/docs/services/CloudLogAnalysis/containers/containers_kubernetes.html#containers_kubernetes).

**Nota**: se hai specificato uno spazio quando hai creato il cluster o la configurazione di registrazione, il proprietario dell'account deve disporre delle autorizzazioni di Gestore, Sviluppatore o Revisore in quello spazio per visualizzare i log. Per ulteriori informazioni sulla modifica delle politiche di accesso e delle autorizzazioni {{site.data.keyword.containershort_notm}}, vedi [Gestione dell'accesso al cluster](cs_users.html#managing). Una volta modificate le autorizzazioni, potrebbero essere necessarie fino a 24 ore prima di poter visualizzare i log.

Per accedere al dashboard Kibana, vai a uno dei seguenti URL e seleziona l'account o lo spazio {{site.data.keyword.Bluemix_notm}} in cui hai creato il cluster.
- Stati Uniti Sud e Stati Uniti Est: https://logging.ng.bluemix.net
- Regno Unito-Sud: https://logging.eu-gb.bluemix.net
- EU-Central: https://logging.eu-fra.bluemix.net
- AP-South: https://logging.au-syd.bluemix.net

Per ulteriori informazioni sulla visualizzazione dei log, vedi [Passaggio a Kibana da un browser web](/docs/services/CloudLogAnalysis/kibana/launch.html#launch_Kibana_from_browser).

### Log Docker
{: #view_logs_docker}

Puoi sfruttare le funzionalità di registrazione Docker integrate per controllare le attività per i flussi di output
STDOUT e STDERR standard. Per ulteriori informazioni, vedi [Visualizzazione dei log di un contenitore in esecuzione in un cluster Kubernetes](/docs/services/CloudLogAnalysis/containers/containers_kubernetes.html#containers_kubernetes).

<br />


## Configurazione del monitoraggio dei cluster
{: #monitoring}

Le metriche ti aiutano a monitorare l'integrità e le prestazioni dei tuoi cluster. Puoi configurare il monitoraggio dell'integrità per i nodi di lavoro per rilevare e correggere automaticamente tutti i nodi di lavoro che entrano in uno stato di danneggiamento o non operativo. **Nota**: il monitoraggio è supportato solo per i cluster standard.
{:shortdesc}

## Visualizzazione delle metriche
{: #view_metrics}

Puoi utilizzare le funzioni Kubernetes e Docker standard per monitorare l'integrità del tuo cluster e delle applicazioni.
{:shortdesc}

<dl>
<dt>Pagina dei dettagli del cluster in {{site.data.keyword.Bluemix_notm}}</dt>
<dd>{{site.data.keyword.containershort_notm}} fornisce informazioni sull'integrità
e capacità del tuo cluster e sull'utilizzo delle tue risorse del cluster. Puoi utilizzare questa GUI per ridimensionare il tuo cluster, utilizzare la tua archiviazione persistente e aggiungere ulteriori funzionalità al cluster attraverso il bind del servizio {{site.data.keyword.Bluemix_notm}}. Per visualizzare la pagina dei dettagli del cluster,
vai al tuo **Dashboard {{site.data.keyword.Bluemix_notm}}** e seleziona un cluster.</dd>
<dt>Dashboard Kubernetes</dt>
<dd>Il dashboard Kubernetes è un'interfaccia web di amministrazione in cui puoi esaminare l'integrità dei tuoi nodi di lavoro, trovare le risorse Kubernetes, distribuire le applicazioni inserite in un contenitore e per risolvere i problemi delle applicazioni utilizzando le informazioni di monitoraggio e registrazione. Per ulteriori informazioni su come
accedere al tuo dashboard Kubernetes, consulta [Avvio del dashboard Kubernetes per  {{site.data.keyword.containershort_notm}}](cs_app.html#cli_dashboard).</dd>
<dt>{{site.data.keyword.monitoringlong_notm}}</dt>
<dd>Le metriche per i cluster standard si trovano nell'account {{site.data.keyword.Bluemix_notm}} a cui è stato effettuato l'accesso quando è stato creato il cluster Kubernetes. Se quando hai creato il cluster hai specificato uno spazio {{site.data.keyword.Bluemix_notm}}, le metriche si trovano in quello spazio. Le metriche di contenitore sono raccolte automaticamente per tutti i contenitori distribuiti in un cluster. Queste metriche vengono inviate e rese disponibili tramite Grafana. Per ulteriori informazioni sulle metriche, vedi [Monitoraggio per il {{site.data.keyword.containershort_notm}}](/docs/services/cloud-monitoring/containers/monitoring_containers_ov.html#monitoring_bmx_containers_ov).<p>Per accedere al dashboard Grafana, vai a uno dei seguenti URL e seleziona l'account o lo spazio {{site.data.keyword.Bluemix_notm}} in cui hai creato il cluster.<ul><li>Stati Uniti Sud e Stati Uniti Est: https://metrics.ng.bluemix.net</li><li>Regno Unito-Sud: https://metrics.eu-gb.bluemix.net</li></ul></p></dd></dl>

### Altri strumenti di monitoraggio dell'integrità
{: #health_tools}

Puoi configurare altri strumenti per ulteriori funzionalità di monitoraggio.
<dl>
<dt>Prometheus</dt>
<dd>Prometheus è uno strumento di monitoraggio, registrazione e avviso open source progettato per Kubernetes. Lo strumento recupera informazioni dettagliate sul cluster, sui nodi di lavoro e sull'integrità della distribuzione in base alle informazioni di registrazione di Kubernetes. Per le informazioni di configurazione, consulta [Integrazione dei servizi con {{site.data.keyword.containershort_notm}}](cs_integrations.html#integrations).</dd>
</dl>

<br />


## Configurazione del monitoraggio dell'integrità per i nodi di lavoro con Autorecovery
{: #autorecovery}

Il sistema Autorecovery di {{site.data.keyword.containerlong_notm}} può essere distribuito nei cluster esistenti di Kubernetes versione 1.7 o successive. Il sistema Autorecovery utilizza vari controlli per interrogare lo stato di integrità dei nodi di lavoro. Se Autorecovery rileva un nodo di lavoro non integro in base ai controlli configurati, attiva un'azione correttiva come un ricaricamento del sistema operativo sul nodo di lavoro. Viene eseguita un'azione correttiva su un solo nodo di lavoro alla volta. Il nodo di lavoro deve completare correttamente l'azione correttiva prima che qualsiasi altro nodo di lavoro sia sottoposto a un'azione correttiva. Per ulteriori informazioni consulta questo post del blog [Autorecovery  ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.ibm.com/blogs/bluemix/2017/12/autorecovery-utilizes-consistent-hashing-high-availability/).
**NOTA**: Autorecovery richiede che almeno un nodo sia integro per funzionare correttamente. Configura Autorecovery con controlli attivi solo nei cluster con due o più nodi di lavoro.

Prima di iniziare, [indirizza la tua CLI](cs_cli_install.html#cs_cli_configure) al cluster in cui vuoi controllare lo stato dei nodi di lavoro.

1. Crea un file di mappa di configurazione che definisca i tuoi controlli in formato JSON. Ad esempio, il seguente file YAML definisce tre controlli: un controllo HTTP e due controlli del server API Kubernetes. **Nota**: ogni controllo ha bisogno di essere definito come una chiave univoca nella sezione dei dati della mappa di configurazione.

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


<table summary="Descrizione dei componenti della mappa di configurazione">
<caption>Descrizione dei componenti della mappa di configurazione </caption>
<thead>
<th colspan=2><img src="images/idea.png"/>Descrizione dei componenti della mappa di configurazione</th>
</thead>
<tbody>
<tr>
<td><code>name</code></td>
<td>Il nome della configurazione <code>ibm-worker-recovery-checks</code> è una costante e non può essere modificato.</td>
</tr>
<tr>
<td><code>spazio dei nomi</code></td>
<td>Lo spazio dei nomi <code>kube-system</code> è una costante e non può essere modificato.</td>
</tr>
<tr>
<td><code>checkhttp.json</code></td>
<td>Definisce un controllo HTTP che verifica che un server HTTP sia in esecuzione sull'indirizzo IP di ogni nodo sulla porta 80 e restituisca una risposta 200 nel percorso <code>/myhealth</code>. Puoi trovare l'indirizzo IP di un nodo eseguendo <code>kubectl get nodes</code>.
Ad esempio, considera due nodi in un cluster con gli indirizzi IP 10.10.10.1 e 10.10.10.2. In questo esempio, vengono controllate due rotte per le risposte 200 OK: <code>http://10.10.10.1:80/myhealth</code> e <code>http://10.10.10.2:80/myhealth</code>.
Il controllo nel precedente YAML di esempio viene eseguito ogni 3 minuti. Se ha esito negativo per 3 volte consecutive, il nodo viene riavviato. Questa azione equivale all'esecuzione di <code>bx cs worker-reboot</code>. Il controllo HTTP non viene disabilitato finché non imposti il campo <b>Abilitato</b> su <code>true</code>.</td>
</tr>
<tr>
<td><code>checknode.json</code></td>
<td>Definisce un controllo del nodo dell'API Kubernetes che verifica se ogni nodo è nello stato <code>Ready</code> . Il controllo per un nodo specifico viene considerato un esito negativo se il nodo non è nello stato <code>Ready</code>.
Il controllo nel precedente YAML di esempio viene eseguito ogni 3 minuti. Se ha esito negativo per 3 volte consecutive, il nodo viene ricaricato. Questa azione equivale all'esecuzione di <code>bx cs worker-reload</code>. Il controllo del nodo è abilitato finché imposti il campo <b>Abilitato</b> su <code>false</code> o rimuovi il controllo.</td>
</tr>
<tr>
<td><code>checkpod.json</code></td>
<td>Definisce un controllo del pod dell'API Kubernetes che verifica la percentuale totale di pod <code>NotReady</code> in un nodo in base ai pod totali assegnati a tale nodo. Il controllo per un nodo specifico viene considerato un esito negativo se la percentuale totale dei pod <code>NotReady</code> è maggiore del valore definito <code>PodFailureThresholdPercent</code>.
Il controllo nel precedente YAML di esempio viene eseguito ogni 3 minuti. Se ha esito negativo per 3 volte consecutive, il nodo viene ricaricato. Questa azione equivale all'esecuzione di <code>bx cs worker-reload</code>. Il controllo del pod è abilitato finché imposti il campo <b>Abilitato</b> su <code>false</code> o rimuovi il controllo. </td>
</tr>
</tbody>
</table>


<table summary="Descrizione dei componenti delle regole individuali">
<caption>Descrizione dei componenti delle regole individuali </caption>
<thead>
<th colspan=2><img src="images/idea.png"/>Descrizione dei componenti delle regole individuali </th>
</thead>
<tbody>
<tr>
<td><code>Check</code></td>
<td>Immetti il tipo di controllo che vuoi venga utilizzato da Autorecovery. <ul><li><code>HTTP</code>: Autorecovery richiama i server HTTP in esecuzione su ciascun nodo per determinare se i nodi vengono eseguiti correttamente.</li><li><code>KUBEAPI</code>: Autorecovery richiama il server API Kubernetes e legge i dati sullo stato di integrità riportati dai nodi di lavoro.</li></ul></td>
</tr>
<tr>
<td><code>Resource</code></td>
<td>Quando il tipo di controllo è <code>KUBEAPI</code>, immetti il tipo di risorsa che vuoi venga controllata da Autorecovery. I valori accettati sono <code>NODE</code> o <code>PODS</code>.</td>
</tr>
<tr>
<td><code>FailureThreshold</code></td>
<td>Immetti la soglia per il numero di controlli non riusciti consecutivi. Quando viene raggiunta questa soglia, Autorecovery attiva l'azione correttiva specificata. Ad esempio, se il valore è 3 e Autorecovery non riesce ad eseguire un controllo configurato tre volte consecutive, Autorecovery attiva l'azione correttiva associata al controllo.</td>
</tr>
<tr>
<td><code>PodFailureThresholdPercent</code></td>
<td>Quando il tipo di risorsa è <code>PODS</code>, immetti la soglia per la percentuale di pod su un nodo di lavoro che può trovarsi in uno stato [NotReady ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/#define-readiness-probes). Questa percentuale si basa sul numero totale di pod pianificati su un nodo di lavoro. Quando un controllo determina che la percentuale di pod non integri è maggiore della soglia, il controllo conta come un errore.</td>
</tr>
<tr>
<td><code>CorrectiveAction</code></td>
<td>Immetti l'azione da eseguire quando viene raggiunta la soglia di errore. Un'azione correttiva viene eseguita solo mentre nessun altro nodo di lavoro viene riparato e quando questo nodo di lavoro non si trova in un periodo di raffreddamento da un'azione precedente. <ul><li><code>REBOOT</code>: riavvia il nodo di lavoro.</li><li><code>RELOAD</code>: ricarica tutte le configurazioni necessarie per il nodo di lavoro da un sistema operativo pulito.</li></ul></td>
</tr>
<tr>
<td><code>CooloffSeconds</code></td>
<td>Immetti il numero di secondi in cui Autorecovery deve attendere di immettere un'altra azione correttiva per un nodo per il quale è già stata emessa un'azione correttiva. Il periodo di raffreddamento inizia nel momento in cui viene emessa un'azione correttiva.</td>
</tr>
<tr>
<td><code>IntervalSeconds</code></td>
<td>Immetti il numero di secondi tra i controlli consecutivi. Ad esempio, se il valore è 180, Autorecovery esegue il controllo su ciascun nodo ogni 3 minuti.</td>
</tr>
<tr>
<td><code>TimeoutSeconds</code></td>
<td>Immetti il numero massimo di secondi impiegati da una chiamata di controllo al database prima che Autorecovery termini l'operazione di chiamata. Il valore per <code>TimeoutSeconds</code> deve essere inferiore al valore per <code>IntervalSeconds</code>.</td>
</tr>
<tr>
<td><code>Porta</code></td>
<td>Quando il tipo di controllo è <code>HTTP</code>, immetti la porta a cui deve essere associato il server HTTP sui nodi di lavoro. Questa porta deve essere esposta sull'IP di ogni nodo di lavoro nel cluster. Autorecovery richiede un numero di porta costante tra tutti i nodi per il controllo dei server. Utilizza [DaemonSets ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) quando distribuisci un server personalizzato in un cluster.</td>
</tr>
<tr>
<td><code>ExpectedStatus</code></td>
<td>Quando il tipo di controllo è <code>HTTP</code>, immetti lo stato del server HTTP che prevedi venga restituito dal controllo. Ad esempio, un valore di 200 indica che prevedi una risposta <code>OK</code> dal server.</td>
</tr>
<tr>
<td><code>Route</code></td>
<td>Quando il tipo di controllo è <code>HTTP</code>, immetti il percorso che viene richiesto dal server HTTP. Questo valore è in genere il percorso delle metriche per il server in esecuzione su tutti i nodi di lavoro.</td>
</tr>
<tr>
<td><code>Enabled</code></td>
<td>Immetti <code>true</code> per abilitare il controllo o <code>false</code> per disabilitarlo.</td>
</tr>
</tbody>
</table>

2. Crea la mappa di configurazione nel tuo cluster.

    ```
    kubectl apply -f <my_file.yaml>
    ```
    {: pre}

3. Verifica di aver creato la mappa di configurazione con il nome `ibm-worker-recovery-checks` nello spazio dei nomi `kube-system` con i controlli appropriati.

    ```
    kubectl -n kube-system get cm ibm-worker-recovery-checks -o yaml
    ```
    {: pre}


4. Distribuisci Autorecovery nel tuo cluster applicando questo file YAML.

   ```
   kubectl apply -f https://raw.githubusercontent.com/IBM-Bluemix/kube-samples/master/ibm-worker-recovery/ibm-worker-recovery.yml
   ```
   {: pre}

5. Dopo alcuni minuti, puoi controllare la sezione `Events` nell'output del seguente comando per visualizzare l'attività sulla distribuzione di Autorecovery.

    ```
    kubectl -n kube-system describe deployment ibm-worker-recovery
    ```
    {: pre}
