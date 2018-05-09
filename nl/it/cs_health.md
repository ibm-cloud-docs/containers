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


# Registrazione e monitoraggio dei cluster
{: #health}

Configura la registrazione e il monitoraggio in {{site.data.keyword.containerlong}} per aiutarti a risolvere i problemi e migliorare l'integrità e le prestazioni dei cluster e delle applicazioni Kubernetes.
{: shortdesc}


## Configurazione dell'inoltro dei log
{: #logging}

Con un cluster Kubernetes standard in {{site.data.keyword.containershort_notm}}, puoi inoltrare i log da origini diverse a {{site.data.keyword.loganalysislong_notm}}, a un server syslog esterno o a entrambi.
{: shortdesc}

Se vuoi inoltrare i log da un'origine a entrambi i server di raccolta, devi creare due configurazioni di registrazione.
{: tip}

Controlla la seguente tabella per informazioni sulle diverse origini log.

<table><caption>Caratteristiche delle origini log</caption>
  <thead>
    <tr>
      <th>Origine log</th>
      <th>Caratteristiche</th>
      <th>Percorsi log</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>container</code></td>
      <td>Log per il tuo contenitore in esecuzione in un cluster Kubernetes.</td>
      <td>Tutto ciò che è registrato su STDOUT o STDERR nei tuoi contenitori.</td>
    </tr>
    <tr>
      <td><code>application</code></td>
      <td>Log per la tua applicazione eseguita in un cluster Kubernetes.</td>
      <td>Puoi impostare i percorsi.</td>
    </tr>
    <tr>
      <td><code>worker</code></td>
      <td>Log per i nodi di lavoro della macchina virtuale in un cluster Kubernetes.</td>
      <td><code>/var/log/syslog</code>, <code>/var/log/auth.log</code></td>
    </tr>
    <tr>
      <td><code>kubernetes</code></td>
      <td>Log per il componente di sistema Kubernetes.</td>
      <td><code>/var/log/syslog</code>, <code>/var/log/auth.log</code></td>
    </tr>
    <tr>
      <td><code>ingress</code></td>
      <td>Log per un programma di bilanciamento del carico dell'applicazione Ingress che gestisce il traffico di rete che entra in un cluster.</td>
      <td><code>/var/log/alb/ids/&ast;.log</code>, <code>/var/log/alb/ids/&ast;.err</code>, <code>/var/log/alb/customerlogs/&ast;.log</code>, <code>/var/log/alb/customerlogs/&ast;.err</code></td>
    </tr>
  </tbody>
</table>

Quando configuri la registrazione tramite l'interfaccia utente, devi specificare un'organizzazione e uno spazio. Se vuoi abilitare la registrazione a livello di account, puoi farlo attraverso la CLI.
{: tip}


### Prima di iniziare

1. Verifica le autorizzazioni. Se hai specificato uno spazio quando hai creato il cluster o la configurazione di registrazione, sia il proprietario dell'account che il proprietario della chiave {{site.data.keyword.containershort_notm}} necessitano delle autorizzazioni di Gestore, Sviluppatore o Revisore in quello spazio.
  * Se non sai chi sia il proprietario della chiave {{site.data.keyword.containershort_notm}}, immetti il seguente comando.
      ```
      bx cs api-key-info <cluster_name>
      ```
      {: pre}
  * Per applicare immediatamente le modifiche che hai apportato alle tue autorizzazioni, immetti il seguente comando.
      ```
      bx cs logging-config-refresh <cluster_name>
      ```
      {: pre}

  Per ulteriori informazioni sulla modifica delle politiche di accesso e delle autorizzazioni {{site.data.keyword.containershort_notm}}, vedi [Gestione dell'accesso al cluster](cs_users.html#managing).
  {: tip}

2. [Indirizza la tua CLI](cs_cli_install.html#cs_cli_configure) al cluster in cui si trova l'origine log.

  Se utilizzi un account dedicato, devi accedere all'endpoint {{site.data.keyword.cloud_notm}} pubblico e specificare come destinazione la tua organizzazione e il tuo spazio pubblici per abilitare l'inoltro dei log.
  {: tip}

3. Per inoltrare i log a syslog, configura un server che accetti un protocollo syslog in uno dei due seguenti modi:
  * Configura e gestisci il tuo proprio server o utilizza un provider per gestirlo al tuo posto. Se un provider gestisce il server al tuo posto, richiama l'endpoint di registrazione dal provider di registrazione.
  * Esegui syslog da un contenitore. Ad esempio, puoi utilizzare questo [file .yaml di distribuzione![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/IBM-Cloud/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml) per recuperare un'immagine pubblica Docker che esegue un contenitore in un cluster Kubernetes. L'immagine pubblica la porta `514` sull'indirizzo IP del cluster pubblico e utilizza questo indirizzo IP per configurare l'host syslog.

### Abilitazione dell'inoltro dei log

1. Crea una configurazione di inoltro dei log.
    * Per inoltrare i log a {{site.data.keyword.loganalysisshort_notm}}:
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

    * Per inoltrare i log a syslog:
      ```
      bx cs logging-config-create <my_cluster> --logsource <my_log_source> --namespace <kubernetes_namespace> --hostname <log_server_hostname_or_IP> --port <log_server_port> --type syslog --app-containers <containers> --app-paths <paths_to_logs>
      ```
      {: pre}

  <table>
    <caption>Descrizione dei componenti di questo comando</caption>
  <thead>
    <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti di questo comando</th>
  </thead>
  <tbody>
    <tr>
      <td><code><em>&lt;my_cluster&gt;</em></code></td>
      <td>Il nome o l'ID del cluster.</td>
    </tr>
    <tr>
      <td><code><em>&lt;my_log_source&gt;</em></code></td>
      <td>L'origine da cui vuoi inoltrare i log. I valori accettati sono <code>container</code>, <code>application</code>, <code>worker</code>, <code>kubernetes</code> e <code>ingress</code>.</td>
    </tr>
    <tr>
      <td><code><em>&lt;kubernetes_namespace&gt;</em></code></td>
      <td>Facoltativo: lo spazio dei nomi Kubernetes da cui vuoi inoltrare i log. L'inoltro del log non è supportato per gli spazi dei nomi Kubernetes <code>ibm-system</code> e <code>kube-system</code>. Questo valore è valido solo per l'origine log <code>container</code>. Se non specifichi uno spazio dei nomi, tutti gli spazi dei nomi nel cluster utilizzeranno questa configurazione.</td>
    </tr>
    <tr>
      <td><code><em>&lt;ingestion_URL&gt;</em></code></td>
      <td><p>Per {{site.data.keyword.loganalysisshort_notm}}, utilizza l'[URL di inserimento](/docs/services/CloudLogAnalysis/log_ingestion.html#log_ingestion_urls). Se non specifichi un URL di inserimento, viene utilizzato l'endpoint per la regione in cui hai creato il tuo cluster.</p>
      <p>Per syslog, specifica il nome host o l'indirizzo IP del servizio di raccolta log.</p></td>
    </tr>
    <tr>
      <td><code><em>&lt; port&gt;</em></code></td>
      <td>La porta di inserimento. Se non specifichi una porta, viene utilizzata la porta standard <code>9091</code>.
      <p>Per syslog, specifica la porta del server di raccolta log. Se non specifichi una porta, viene utilizzata la porta standard <code>514</code>.</td>
    </tr>
    <tr>
      <td><code><em>&lt;cluster_space&gt;</em></code></td>
      <td>Facoltativo: il nome dello spazio Cloud Foundry a cui vuoi inviare i log. Quando inoltri i log a {{site.data.keyword.loganalysisshort_notm}}, lo spazio e l'organizzazione sono specificati nel punto di inserimento. Se non specifichi uno spazio, i log vengono inviati al livello dell'account.</td>
    </tr>
    <tr>
      <td><code><em>&lt;cluster_org&gt;</em></code></td>
      <td>Il nome dell'organizzazione Cloud Foundry in cui si trova lo spazio. Questo valore è obbligatorio se hai specificato uno spazio.</td>
    </tr>
    <tr>
      <td><code><em>&lt;type&gt;</em></code></td>
      <td>Il luogo in cui vuoi inoltrare i tuoi log. Le opzioni sono <code>ibm</code>, che inoltra i tuoi log a {{site.data.keyword.loganalysisshort_notm}} e <code>syslog</code>, che inoltra i log a un server esterno.</td>
    </tr>
    <tr>
      <td><code><em>&lt;paths_to_logs&gt;</em></code></td>
      <td>Il percorso sui loro contenitori a cui si collegano le applicazioni. Per inoltrare i log con il tipo di origine <code>application</code>, devi fornire un percorso. Per specificare più di un percorso, utilizza un elenco separato da virgole. Esempio: <code>/var/log/myApp1/*/var/log/myApp2/*</code></td>
    </tr>
    <tr>
      <td><code><em>&lt;containers&gt;</em></code></td>
      <td>Facoltativo: quando inoltri i log dalle applicazioni, puoi specificare il nome del contenitore che contiene la tua applicazione. Puoi specificare più di un contenitore utilizzando un elenco separato da virgole. Se non si specificano i contenitori, i log vengono inoltrati da tutti i contenitori che contengono i percorsi da te forniti.</td>
    </tr>
  </tbody>
  </table>

2. Verifica che la tua configurazione sia corretta in uno dei due seguenti modi:

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

Per aggiornare la tua configurazione, segui la stessa procedura, ma sostituisci `bx cs logging-config-create` con `bx cs logging-config-update`. Assicurati di verificare il tuo aggiornamento.
{: tip}

<br />


## Visualizzazione dei log
{: #view_logs}

Per visualizzare i log dei cluster e dei contenitori, puoi utilizzare le funzioni di registrazione Docker e Kubernetes standard.
{:shortdesc}

### {{site.data.keyword.loganalysislong_notm}}
{: #view_logs_k8s}

Puoi visualizzare i log che hai inoltrato a {{site.data.keyword.loganalysislong_notm}} attraverso il dashboard Kibana.
{: shortdesc}

Se per creare il tuo file di configurazione hai utilizzato i valori predefiniti, i log possono essere trovati nell'account o nell'organizzazione e nello spazio in cui è stato creato il cluster. Se hai specificato un'organizzazione e uno spazio nel tuo file di configurazione, puoi trovare i tuoi log in quello spazio. Per ulteriori informazioni sulla registrazione, consulta [Registrazione di {{site.data.keyword.containershort_notm}}](/docs/services/CloudLogAnalysis/containers/containers_kubernetes.html#containers_kubernetes).

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


## Arresto dell'inoltro dei log
{: #log_sources_delete}

Puoi arrestare l'inoltro dei log eliminando una o tutte le configurazioni di registrazione per un cluster.
{: shortdesc}

1. [Indirizza la tua CLI](cs_cli_install.html#cs_cli_configure) al cluster in cui si trova l'origine log.

2. Elimina la configurazione di registrazione.
<ul>
<li>Per eliminare una configurazione di registrazione:</br>
  <pre><code>bx cs logging-config-rm &lt;my_cluster&gt; --id &lt;log_config_id&gt;</pre></code>
  <table>
    <caption>Descrizione dei componenti di questo comando</caption>
      <thead>
        <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti di questo comando</th>
      </thead>
        <tbody>
        <tr>
          <td><code><em>&lt;my_cluster&gt;</em></code></td>
          <td>Il nome del cluster in cui si trova la configurazione di registrazione.</td>
        </tr>
        <tr>
          <td><code><em>&lt;log_config_id&gt;</em></code></td>
          <td>L'ID della configurazione dell'origine log.</td>
        </tr>
        </tbody>
  </table></li>
<li>Per eliminare tutte le configurazioni di registrazione:</br>
  <pre><code>bx cs logging-config-rm <my_cluster> --all</pre></code></li>
</ul>

<br />


## Configurazione dell'inoltro del log per i log di controllo dell'API Kubernetes
{: #app_forward}

Puoi configurare un webhook attraverso il server API Kubernetes per acquisire qualsiasi chiamata dal tuo cluster. Con un webhook abilitato, i log possono essere inviati a un server remoto.
{: shortdesc}

Per ulteriori informazioni sui log di controllo Kubernetes, consulta l'<a href="https://kubernetes.io/docs/tasks/debug-application-cluster/audit/" target="blank">argomento di controllo <img src="../icons/launch-glyph.svg" alt="Icona link esterno"></a> nella documentazione Kubernetes.

* L'inoltro dei log di controllo dell'API Kubernetes è supportato solo per Kubernetes versione 1.7 e successive.
* Al momento, viene utilizzata una politica di controllo predefinita per tutti i cluster con questa configurazione di registrazione.
* I log di controllo possono essere inoltrati solo a un server esterno.
{: tip}

### Abilitazione dell'inoltro dei log dell'API Kubernetes
{: #audit_enable}

Prima di iniziare:

1. Configura un server di registrazione remoto dove puoi inoltrare i log. Ad esempio, puoi [utilizzare Logstash con Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/tasks/debug-application-cluster/audit/#use-logstash-to-collect-and-distribute-audit-events-from-webhook-backend) per raccogliere gli eventi di controllo.

2. [Indirizza la tua CLI](cs_cli_install.html#cs_cli_configure) al cluster dai cui vuoi vengano raccolti i log di controllo del server API. **Nota**: se utilizzi un account dedicato, devi accedere all'endpoint {{site.data.keyword.cloud_notm}} pubblico e specificare come destinazione la tua organizzazione e il tuo spazio pubblici per abilitare l'inoltro dei log.

Per inoltrare i log di controllo dell'API Kubernetes:

1. Configura il webhook. Se non fornisci alcuna informazione negli indicatori, viene utilizzata una configurazione predefinita.

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
    <td><code><em>&lt;my_cluster&gt;</em></code></td>
    <td>Il nome o l'ID del cluster.</td>
    </tr>
    <tr>
    <td><code><em>&lt;server_URL&gt;</em></code></td>
    <td>L'URL o l'indirizzo IP del servizio di registrazione remoto a cui vuoi inviare i log. Se fornisci un URL server non protetto i certificati vengono ignorati.</td>
    </tr>
    <tr>
    <td><code><em>&lt;CA_cert_path&gt;</em></code></td>
    <td>Il percorso del file per il certificato CA utilizzato per verificare il servizio di registrazione remoto.</td>
    </tr>
    <tr>
    <td><code><em>&lt;client_cert_path&gt;</em></code></td>
    <td>Il percorso del file per il certificato client utilizzato per l'autenticazione con il servizio di registrazione remoto.</td>
    </tr>
    <tr>
    <td><code><em>&lt;client_key_path&gt;</em></code></td>
    <td>Il percorso del file per la chiave client corrispondente utilizzata per il collegamento al servizio di registrazione remoto.</td>
    </tr>
    </tbody></table>

2. Verifica che l'inoltro dei log sia stato abilitato visualizzando l'URL per il servizio di registrazione remoto.

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
    <dd>Il dashboard Kubernetes è un'interfaccia web di amministrazione in cui puoi esaminare lo stato dei nodi di lavoro, trovare risorse Kubernetes, distribuire applicazioni inserite in un contenitore e risolvere problemi con le informazioni di registrazione e monitoraggio. Per ulteriori informazioni su come
accedere al tuo dashboard Kubernetes, consulta [Avvio del dashboard Kubernetes per  {{site.data.keyword.containershort_notm}}](cs_app.html#cli_dashboard).</dd>
  <dt>{{site.data.keyword.monitoringlong_notm}}</dt>
    <dd>Le metriche per i cluster standard si trovano nell'account {{site.data.keyword.Bluemix_notm}} a cui è stato effettuato l'accesso quando è stato creato il cluster Kubernetes. Se quando hai creato il cluster hai specificato uno spazio {{site.data.keyword.Bluemix_notm}}, le metriche si trovano in quello spazio. Le metriche di contenitore sono raccolte automaticamente per tutti i contenitori distribuiti in un cluster. Queste metriche vengono inviate e rese disponibili tramite Grafana. Per ulteriori informazioni sulle metriche, vedi [Monitoraggio per il {{site.data.keyword.containershort_notm}}](/docs/services/cloud-monitoring/containers/monitoring_containers_ov.html#monitoring_bmx_containers_ov).<p>Per accedere al dashboard Grafana, vai a uno dei seguenti URL e seleziona l'account o lo spazio {{site.data.keyword.Bluemix_notm}} in cui hai creato il cluster.<ul><li>Stati Uniti Sud e Stati Uniti Est: https://metrics.ng.bluemix.net</li><li>Regno Unito-Sud: https://metrics.eu-gb.bluemix.net</li><li>Europa centrale: https://metrics.eu-de.bluemix.net</li></ul></p></dd>
</dl>

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

Il sistema Autorecovery di {{site.data.keyword.containerlong_notm}} può essere distribuito nei cluster esistenti di Kubernetes versione 1.7 o successive.
{: shortdesc}

Il sistema Autorecovery utilizza vari controlli per interrogare lo stato di integrità dei nodi di lavoro. Se Autorecovery rileva un nodo di lavoro non integro in base ai controlli configurati, attiva un'azione correttiva come un ricaricamento del sistema operativo sul nodo di lavoro. Viene eseguita un'azione correttiva su un solo nodo di lavoro alla volta. Il nodo di lavoro deve completare correttamente l'azione correttiva prima che qualsiasi altro nodo di lavoro sia sottoposto a un'azione correttiva. Per ulteriori informazioni consulta questo post del blog [Autorecovery  ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.ibm.com/blogs/bluemix/2017/12/autorecovery-utilizes-consistent-hashing-high-availability/).
**NOTA**: Autorecovery richiede che almeno un nodo sia integro per funzionare correttamente. Configura Autorecovery con controlli attivi solo nei cluster con due o più nodi di lavoro.

Prima di iniziare, [indirizza la tua CLI](cs_cli_install.html#cs_cli_configure) al cluster in cui vuoi controllare lo stato dei nodi di lavoro.

1. Crea un file di mappa di configurazione che definisca i tuoi controlli in formato JSON. Ad esempio, il seguente file YAML definisce tre controlli: un controllo HTTP e due controlli del server API Kubernetes.</br>
   **Suggerimento:** definisci ogni controllo come chiave univoca nella sezione dei dati della mappa di configurazione.

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
   <caption>Descrizione dei componenti della mappa di configurazione</caption>
   <thead>
   <th colspan=2><img src="images/idea.png" alt="Icona Idea"/>Descrizione dei componenti della mappa di configurazione</th>
   </thead>
   <tbody>
   <tr>
   <td><code>name</code></td>
   <td>Il nome della configurazione <code>ibm-worker-recovery-checks</code> è una costante e non può essere modificato.</td>
   </tr>
   <tr>
   <td><code>namespace</code></td>
   <td>Lo spazio dei nomi <code>kube-system</code> è una costante e non può essere modificato.</td>
   </tr>
   <tr>
   <td><code>checkhttp.json</code></td>
   <td>Definisce un controllo HTTP che verifica che un server HTTP sia in esecuzione sull'indirizzo IP di ogni nodo sulla porta 80 e restituisca una risposta 200 nel percorso <code>/myhealth</code>. Puoi trovare l'indirizzo IP di un nodo eseguendo <code>kubectl get nodes</code>.
Ad esempio, considera due nodi in un cluster con gli indirizzi IP 10.10.10.1 e 10.10.10.2. In questo esempio, vengono controllate due rotte per le risposte 200 OK: <code>http://10.10.10.1:80/myhealth</code> e <code>http://10.10.10.2:80/myhealth</code>.
Il controllo nel YAML di esempio viene eseguito ogni 3 minuti. Se ha esito negativo per tre volte consecutive, il nodo viene riavviato. Questa azione equivale all'esecuzione di <code>bx cs worker-reboot</code>. Il controllo HTTP non viene disabilitato finché non imposti il campo <b>Abilitato</b> su <code>true</code>.      </td>
   </tr>
   <tr>
   <td><code>checknode.json</code></td>
   <td>Definisce un controllo del nodo dell'API Kubernetes che verifica se ogni nodo è nello stato <code>Ready</code> . Il controllo per un nodo specifico viene considerato un esito negativo se il nodo non è nello stato <code>Ready</code>.
Il controllo nel YAML di esempio viene eseguito ogni 3 minuti. Se ha esito negativo per tre volte consecutive, il nodo viene ricaricato. Questa azione equivale all'esecuzione di <code>bx cs worker-reload</code>. Il controllo del nodo è abilitato finché imposti il campo <b>Abilitato</b> su <code>false</code> o rimuovi il controllo.</td>
   </tr>
   <tr>
   <td><code>checkpod.json</code></td>
   <td>Definisce un controllo di pod dell'API Kubernetes che verifica la percentuale totale dei pod <code>NotReady</code> su un nodo in base ai pod totali assegnati a tale nodo. Il controllo per un nodo specifico viene considerato un esito negativo se la percentuale totale dei pod <code>NotReady</code> è maggiore del valore definito <code>PodFailureThresholdPercent</code>.
Il controllo nel YAML di esempio viene eseguito ogni 3 minuti. Se ha esito negativo per tre volte consecutive, il nodo viene ricaricato. Questa azione equivale all'esecuzione di <code>bx cs worker-reload</code>. Il controllo del pod è abilitato finché imposti il campo <b>Abilitato</b> su <code>false</code> o rimuovi il controllo.</td>
   </tr>
   </tbody>
   </table>


   <table summary="Descrizione dei componenti delle regole individuali">
   <caption>Descrizione dei componenti delle regole individuali</caption>
   <thead>
   <th colspan=2><img src="images/idea.png" alt="Icona Idea"/>Descrizione dei componenti delle regole individuali </th>
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
   <td>Quando il tipo di controllo è <code>HTTP</code>, immetti la porta a cui deve essere associato il server HTTP sui nodi di lavoro. Questa porta deve essere esposta sull'IP di ogni nodo di lavoro nel cluster. Autorecovery richiede un numero di porta costante tra tutti i nodi per il controllo dei server. Utilizza [DaemonSets ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) quando distribuisci un server personalizzato in un cluster.</td>
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
   kubectl apply -f https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/ibm-worker-recovery/ibm-worker-recovery.yml
   ```
   {: pre}

5. Dopo alcuni minuti, puoi controllare la sezione `Events` nell'output del seguente comando per visualizzare l'attività sulla distribuzione di Autorecovery.

    ```
    kubectl -n kube-system describe deployment ibm-worker-recovery
    ```
    {: pre}
