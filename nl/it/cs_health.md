---

copyright:
  years: 2014, 2018
lastupdated: "2018-12-06"

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


# Registrazione e monitoraggio
{: #health}

Configura la registrazione e il monitoraggio in {{site.data.keyword.containerlong}} per aiutarti a risolvere i problemi e migliorare l'integrità e le prestazioni dei cluster e delle applicazioni Kubernetes.
{: shortdesc}

Cerchi altri servizi di registrazione {{site.data.keyword.Bluemix_notm}} o di terze parti da poter aggiungere al tuo cluster? Controlla le [integrazioni di registrazione e monitoraggio](cs_integrations.html#health_services), tra cui [{{site.data.keyword.la_full_notm}} con LogDNA](/docs/services/Log-Analysis-with-LogDNA/tutorials/kube.html#kube).
{: note}

## Descrizione del cluster e inoltro del log dell'applicazione
{: #logging}

Il monitoraggio continuo e la registrazione costituiscono la chiave per rilevare gli attacchi al tuo cluster e per risolvere i problemi nel momento in cui si verificano. Monitorando continuamente il tuo cluster, puoi meglio comprenderne la capacità e la disponibilità delle risorse disponibili per la tua applicazione. Ciò ti consente di prepararti di conseguenza per proteggere le tue applicazioni da tempi di inattività. Per configurare la registrazione, devi utilizzare un cluster Kubernetes standard in {{site.data.keyword.containerlong_notm}}.
{: shortdesc}


**IBM monitora il mio cluster?**

Ogni master Kubernetes viene continuamente monitorato da IBM. {{site.data.keyword.containerlong_notm}} esegue automaticamente la scansione di ogni nodo in cui viene distribuito il master Kubernetes alla ricerca di vulnerabilità trovate nelle correzioni di sicurezza specifiche del sistema operativo e di Kubernetes. Se vengono trovate delle vulnerabilità,
{{site.data.keyword.containerlong_notm}} automaticamente applica le correzioni
e risolve le vulnerabilità per conto dell'utente per garantire la protezione del nodo master. Sei responsabile del monitoraggio e dell'analisi dei log per il resto del tuo cluster.

**Come vengono raccolti i log?**

I log vengono raccolti dal componente aggiuntivo [Fluentd ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.fluentd.org/) nel tuo cluster. Quando crei una configurazione di registrazione per un'origine nel tuo cluster, il componente aggiuntivo Fluentd raccoglie i log dai percorsi relativi a tale origine. I log vengono inoltrati a {{site.data.keyword.loganalysisshort_notm}} o a un server syslog esterno.

**Quali sono le origini per cui posso configurare la registrazione?**

Nella seguente immagine puoi vedere l'ubicazione delle origini per cui puoi configurare la registrazione.

<img src="images/log_sources.png" width="550" alt="Origini log nel cluster" style="width:550px; border-style: none"/>

1. `worker`: informazioni specifiche per la configurazione dell'infrastruttura del tuo nodo di lavoro. I log del nodo di lavoro vengono acquisiti in syslog e contengono eventi del sistema operativo. In `auth.log` puoi trovare informazioni sulle richieste di autenticazione che vengono effettuate al sistema operativo.</br>**Percorsi**:
    * `/var/log/syslog`
    * `/var/log/auth.log`

2. `container`: informazioni che vengono registrate da un contenitore in esecuzione.</br>**Percorsi**: qualsiasi cosa scritta in `STDOUT` o `STDERR`.

3. `application`: informazioni sugli eventi che si verificano a livello dell'applicazione. Potrebbe essere una notifica indicante che si è verificato un evento, ad esempio un accesso riuscito, un'avvertenza relativa all'archiviazione o altre operazioni che possono essere eseguite a livello dell'applicazione.</br>**Percorsi**: puoi impostare i percorsi a cui vengono inoltrati i tuoi log. Tuttavia, per poter inviare i log, devi utilizzare un percorso assoluto nella tua configurazione della registrazione altrimenti i log non potranno essere letti. Se il tuo percorso viene montato nel tuo nodo di lavoro, potresti aver creato un symlink. Esempio: se il percorso specificato è `/usr/local/spark/work/app-0546/0/stderr` ma i log in realtà vanno a `/usr/local/spark-1.0-hadoop-1.2/work/app-0546/0/stderr`, i log non potranno essere letti.

4. `storage`: informazioni sull'archiviazione persistente configurata nel tuo cluster. I log di archiviazione possono aiutarti a configurare dashboard e avvisi di determinazione dei problemi come parte delle tue release di produzione e pipeline DevOps. **Nota**: i percorsi`/var/log/kubelet.log` e `/var/log/syslog` contengono anche log di archiviazione, ma i log di questi percorsi vengono raccolti dalle origini log `kubernetes` e `worker`.</br>**Percorsi**:
    * `/var/log/ibmc-s3fs.log`
    * `/var/log/ibmc-block.log`

  **Pod**:
    * `portworx-***`
    * `ibmcloud-block-storage-attacher-***`
    * `ibmcloud-block-storage-driver-***`
    * `ibmcloud-block-storage-plugin-***`
    * `ibmcloud-object-storage-plugin-***`

5. `kubernetes`: informazioni da kubelet, kube-proxy e altri eventi Kubernetes che si verificano nello spazio dei nomi kube-system del nodo di lavoro.</br>**Percorsi**:
    * `/var/log/kubelet.log`
    * `/var/log/kube-proxy.log`
    * `/var/log/event-exporter/1..log`

6. `kube-audit`: informazioni sulle azioni relative al cluster che vengono inviate al server API Kubernetes, inclusi l'ora, l'utente e la risorsa interessata.

7. `ingress`: informazioni sul traffico di rete che entra in un cluster tramite l'ALB Ingress. Per informazioni di configurazione specifiche, controlla la [documentazione Ingress](cs_ingress_health.html#ingress_logs).</br>**Percorsi**:
    * `/var/log/alb/ids/*.log`
    * `/var/log/alb/ids/*.err`
    * `/var/log/alb/customerlogs/*.log`
    * `/var/log/alb/customerlogs/*.err`

</br>

**Quali sono le opzioni di configurazione a mia disposizione?**

La tabella riportata di seguito mostra le diverse opzioni a tua disposizione quando configuri la registrazione e le relative descrizioni.

<table>
<caption> Descrizione delle opzioni di configurazione della registrazione</caption>
  <thead>
    <th>Opzione</th>
    <th>Descrizione</th>
  </thead>
  <tbody>
    <tr>
      <td><code><em>&lt;cluster_name_or_ID&gt;</em></code></td>
      <td>Il nome o l'ID del cluster.</td>
    </tr>
    <tr>
      <td><code><em>--log_source</em></code></td>
      <td>L'origine da cui vuoi inoltrare i log. I valori accettati sono <code>container</code>, <code>application</code>, <code>worker</code>, <code>kubernetes</code>, <code>ingress</code>, <code>storage</code> e <code>kube-audit</code>. Questo argomento supporta un elenco separato da virgole delle origini log per cui applicare la configurazione. Se non fornisci un'origine log, le configurazioni di registrazione vengono create per le origini log <code>container</code> e <code>ingress</code>.</td>
    </tr>
    <tr>
      <td><code><em>--type</em></code></td>
      <td>Il luogo in cui vuoi inoltrare i tuoi log. Le opzioni sono <code>ibm</code>, che inoltra i tuoi log a {{site.data.keyword.loganalysisshort_notm}} e <code>syslog</code>, che inoltra i log a un server esterno.</td>
    </tr>
    <tr>
      <td><code><em>--namespace</em></code></td>
      <td>Facoltativo: lo spazio dei nomi Kubernetes da cui vuoi inoltrare i log. L'inoltro del log non è supportato per gli spazi dei nomi Kubernetes <code>ibm-system</code> e <code>kube-system</code>. Questo valore è valido solo per l'origine log <code>container</code>. Se non specifichi uno spazio dei nomi, tutti gli spazi dei nomi nel cluster utilizzeranno questa configurazione.</td>
    </tr>
    <tr>
      <td><code><em>--hostname</em></code></td>
      <td><p>Per {{site.data.keyword.loganalysisshort_notm}}, utilizza l'[URL di inserimento](/docs/services/CloudLogAnalysis/log_ingestion.html#log_ingestion_urls). Se non specifichi un URL di inserimento, viene utilizzato l'endpoint per la regione in cui hai creato il tuo cluster.</p>
      <p>Per syslog, specifica il nome host o l'indirizzo IP del servizio di raccolta log.</p></td>
    </tr>
    <tr>
      <td><code><em>--port</em></code></td>
      <td>La porta di inserimento. Se non specifichi una porta, viene utilizzata la porta standard <code>9091</code>.
      <p>Per syslog, specifica la porta del server di raccolta log. Se non specifichi una porta, viene utilizzata la porta standard <code>514</code>.</td>
    </tr>
    <tr>
      <td><code><em>--space</em></code></td>
      <td>Facoltativo: il nome dello spazio Cloud Foundry a cui vuoi inviare i log. Quando inoltri i log a {{site.data.keyword.loganalysisshort_notm}}, lo spazio e l'organizzazione sono specificati nel punto di inserimento. Se non specifichi uno spazio, i log vengono inviati al livello dell'account. Se devi specificare uno spazio, devi anche specificare un'organizzazione.</td>
    </tr>
    <tr>
      <td><code><em>--org</em></code></td>
      <td>Facoltativo: il nome dell'organizzazione Cloud Foundry in cui si trova lo spazio. Questo valore è obbligatorio se hai specificato uno spazio.</td>
    </tr>
    <tr>
      <td><code><em>--app-containers</em></code></td>
      <td>Facoltativo: per inoltrare i log dalle applicazioni, puoi specificare il nome del contenitore che contiene la tua applicazione. Puoi specificare più di un contenitore utilizzando un elenco separato da virgole. Se non si specificano i contenitori, i log vengono inoltrati da tutti i contenitori che contengono i percorsi da te forniti.</td>
    </tr>
    <tr>
      <td><code><em>--app-paths</em></code></td>
      <td>Il percorso su un contenitore a cui accedono le applicazioni. Per inoltrare i log con il tipo di origine <code>application</code>, devi fornire un percorso. Per specificare più di un percorso, utilizza un elenco separato da virgole. Esempio: <code>/var/log/myApp1/*,/var/log/myApp2/*</code></td>
    </tr>
    <tr>
      <td><code><em>--syslog-protocol</em></code></td>
      <td>Quando il tipo di registrazione è <code>syslog</code>, il protocollo del livello di trasporto. Puoi usare i seguenti protocolli: `udp`, `tls` o `tcp`. Quando esegui l'inoltro a un server rsyslog con il protocollo <code>udp</code>, i log superiori a 1KB vengono troncati.</td>
    </tr>
    <tr>
      <td><code><em>--ca-cert</em></code></td>
      <td>Obbligatorio: quando il tipo di registrazione è <code>syslog</code> e il protocollo è <code>tls</code>, il nome del segreto Kubernetes che contiene il certificato di autorità di certificazione (CA, certificate authority).</td>
    </tr>
    <tr>
      <td><code><em>--verify-mode</em></code></td>
      <td>Quando il tipo di registrazione è <code>syslog</code> e il protocollo è <code>tls</code>, la modalità di verifica. I valori supportati sono <code>verify-peer</code> e il valore predefinito <code>verify-none</code>.</td>
    </tr>
    <tr>
      <td><code><em>--skip-validation</em></code></td>
      <td>Facoltativo: ignora la convalida dei nomi di organizzazione e spazio quando vengono specificati. La mancata convalida riduce il tempo di elaborazione, ma una configurazione di registrazione non valida non inoltrerà correttamente i log.</td>
    </tr>
  </tbody>
</table>

**Sono responsabile dell'aggiornamento di Fluentd per la registrazione?**

Per apportare modifiche alle configurazioni della registrazione o del filtraggio, la versione del componente aggiuntivo per la registrazione Fluentd deve essere la più recente. Per impostazione predefinita, gli aggiornamenti automatici per il componente aggiuntivo sono abilitati. Per disabilitare gli aggiornamenti automatici, vedi [Aggiornamento dei componenti aggiuntivi del cluster: Fluentd per la registrazione](cs_cluster_update.html#logging).

**Posso usare la mia soluzione di registrazione?**

Se hai esigenze speciali, puoi configurare la tua propria soluzione di registrazione nel cluster. Nei cluster che eseguono Kubernetes versione 1.11 o successiva, puoi raccogliere i log del contenitore dal percorso `/var/log/pods/`. Nei cluster che eseguono Kubernetes versione 1.10 o precedenti, puoi raccogliere i log del contenitore dal percorso `/var/lib/docker/containers/`.

<br />


## Configurazione dell'inoltro dei log
{: #configuring}

Puoi configurare la registrazione per {{site.data.keyword.containerlong_notm}} tramite la console o la CLI.
{: shortdesc}

### Abilitazione dell'inoltro dei log con la console {{site.data.keyword.Bluemix_notm}}
{: #enable-forwarding-ui}

Puoi configurare l'inoltro del log nel dashboard {{site.data.keyword.containerlong_notm}}. Il completamento di questo processo può richiedere alcuni minuti, per cui se non visualizzi i log immediatamente, prova ad attendere alcuni minuti e poi ricontrolla.

Per creare una configurazione a livello di account, per uno specifico spazio dei nomi del contenitore o per la registrazione dell'applicazione, usa la CLI.
{: tip}

1. Passa alla scheda **Panoramica** del dashboard.
2. Seleziona lo spazio e l'organizzazione Cloud Foundry dai quali desideri inoltrare i log. Quando configuri l'inoltro del log nel dashboard, i log vengono inviati all'endpoint {{site.data.keyword.loganalysisshort_notm}} predefinito del tuo cluster. Per inoltrare i log a un server esterno o a un altro endpoint {{site.data.keyword.loganalysisshort_notm}}, puoi utilizzare la CLI per configurare la registrazione.
3. Seleziona le origini log dalle quali desideri inoltrare i log.
4. Fai clic su **Crea**.

</br>
</br>

### Abilitazione dell'inoltro dei log con la CLI
{: #enable-forwarding}

Puoi creare una configurazione per la registrazione cluster. Puoi differenziare tra le diverse opzioni di registrazione usando gli indicatori.

**Inoltro dei log a IBM**

1. Verifica le autorizzazioni.
    1. Assicurati di disporre del [ruolo della piattaforma {{site.data.keyword.Bluemix_notm}} IAM **Editor** o **Amministratore**](cs_users.html#platform).
    2. Se quando hai creato il cluster hai specificato uno spazio, sia tu che il proprietario della chiave API {{site.data.keyword.containerlong_notm}} dovete disporre del [ruolo Cloud Foundry **Sviluppatore**](/docs/iam/mngcf.html) in tale spazio.
      * Se non sai chi sia il proprietario della chiave API {{site.data.keyword.containerlong_notm}}, immetti il seguente comando.
          ```
          ibmcloud ks api-key-info <cluster_name>
          ```
          {: pre}
      * Per applicare immediatamente le modifiche che hai apportato, immetti il seguente comando.
          ```
          ibmcloud ks logging-config-refresh <cluster_name>
          ```
          {: pre}

2.  Per il cluster in cui si trova l'origine log: [accedi al tuo account. Specifica la regione appropriata e, se applicabile, il gruppo di risorse. Imposta il contesto per il tuo cluster](cs_cli_install.html#cs_cli_configure).

    Se utilizzi un account dedicato, devi accedere all'endpoint {{site.data.keyword.cloud_notm}} pubblico e specificare come destinazione la tua organizzazione e il tuo spazio pubblici per abilitare l'inoltro dei log.
    {: tip}

3. Crea una configurazione di inoltro dei log.
    ```
    ibmcloud ks logging-config-create <cluster_name_or_ID> --logsource <log_source> --type ibm --namespace <kubernetes_namespace> --hostname <log_server_hostname_or_IP> --port <log_server_port> --space <cluster_space> --org <cluster_org> --app-containers <containers> --app-paths <paths_to_logs> --skip-validation
    ```
    {: pre}

  * Esempio di configurazione della registrazione del contenitore per lo spazio dei nomi predefinito e output:
    ```
    ibmcloud ks logging-config-create mycluster
    Creating cluster mycluster logging configurations...
    OK
    ID                                      Source      Namespace    Host                                 Port    Org  Space   Server Type   Protocol   Application Containers   Paths
    4e155cf0-f574-4bdb-a2bc-76af972cae47    container       *        ingest.logging.eu-gb.bluemix.net✣   9091✣    -     -        ibm           -                  -               -
    ✣ Indicates the default endpoint for the {{site.data.keyword.loganalysisshort_notm}} service.
    ```
    {: screen}

  * Esempio di configurazione della registrazione dell'applicazione e output:
    ```
    ibmcloud ks logging-config-create cluster2 --logsource application --app-paths '/var/log/apps.log' --app-containers 'container1,container2,container3'
    Creating logging configuration for application logs in cluster cluster2...
    OK
    Id                                     Source        Namespace   Host                                    Port    Org   Space   Server Type   Protocol   Application Containers               Paths
    aa2b415e-3158-48c9-94cf-f8b298a5ae39   application    -          ingest.logging.ng.bluemix.net✣  9091✣    -      -          ibm         -        container1,container2,container3      /var/log/apps.log
    ✣ Indicates the default endpoint for the {{site.data.keyword.loganalysisshort_notm}} service.
    ```
    {: screen}

Se hai applicazioni eseguite nei tuoi contenitori che non possono essere configurate per scrivere i log in STDOUT o STDERR, puoi creare una configurazione di registrazione per inoltrare i log dai file di log dell'applicazione.
{: tip}

</br>
</br>


**Inoltro dei log al tuo server sui protocolli `udp` o `tcp`**

1. Assicurati di disporre del [ruolo della piattaforma {{site.data.keyword.Bluemix_notm}} IAM **Editor** o **Amministratore**](cs_users.html#platform).

2. Per il cluster in cui si trova l'origine log: [accedi al tuo account. Specifica la regione appropriata e, se applicabile, il gruppo di risorse. Imposta il contesto per il tuo cluster](cs_cli_install.html#cs_cli_configure). **Nota**: se utilizzi un account dedicato, devi accedere all'endpoint {{site.data.keyword.cloud_notm}} pubblico e specificare come destinazione la tua organizzazione e il tuo spazio pubblici per abilitare l'inoltro dei log.

3. Per inoltrare i log a syslog, configura un server che accetti un protocollo syslog in uno dei due seguenti modi:
  * Configura e gestisci il tuo proprio server o utilizza un provider per gestirlo al tuo posto. Se un provider gestisce il server al tuo posto, richiama l'endpoint di registrazione dal provider di registrazione.

  * Esegui syslog da un contenitore. Ad esempio, puoi utilizzare questo [file .yaml di distribuzione ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/IBM-Cloud/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml) per recuperare un'immagine pubblica Docker che esegue un contenitore nel tuo cluster. L'immagine pubblica la porta `514` sull'indirizzo IP del cluster pubblico e utilizza questo indirizzo IP per configurare l'host syslog.

  Puoi vedere i tuoi log come JSON validi rimuovendo i prefissi syslog. Per eseguire tale operazione, aggiungi il seguente codice all'inizio del tuo file <code>etc/rsyslog.conf</code> in cui è in esecuzione il tuo server rsyslog: <code>$template customFormat,"%msg%\n"</br>$ActionFileDefaultTemplate customFormat</code>
  {: tip}

4. Crea una configurazione di inoltro dei log.
    ```
    ibmcloud ks logging-config-create <cluster_name_or_ID> --logsource <log_source> --namespace <kubernetes_namespace> --hostname <log_server_hostname_or_IP> --port <log_server_port> --type syslog --app-containers <containers> --app-paths <paths_to_logs> --syslog-protocol <protocol> --skip-validation
    ```
    {: pre}

</br>
</br>


**Inoltro dei log al tuo server sul protocollo `tls`**

I passi riportati di seguito sono istruzioni generali. Prima di utilizzare il contenitore in un ambiente di produzione, assicurati che vengano soddisfatti i requisiti di sicurezza necessari.
{: tip}

1. Assicurati di disporre del [ruolo della piattaforma {{site.data.keyword.Bluemix_notm}} IAM **Editor** o **Amministratore**](cs_users.html#platform).

2. Per il cluster in cui si trova l'origine log: [accedi al tuo account. Specifica la regione appropriata e, se applicabile, il gruppo di risorse. Imposta il contesto per il tuo cluster](cs_cli_install.html#cs_cli_configure). **Nota**: se utilizzi un account dedicato, devi accedere all'endpoint {{site.data.keyword.cloud_notm}} pubblico e specificare come destinazione la tua organizzazione e il tuo spazio pubblici per abilitare l'inoltro dei log.

3. Imposta un server che accetti un protocollo syslog in uno dei due seguenti modi:
  * Configura e gestisci il tuo proprio server o utilizza un provider per gestirlo al tuo posto. Se un provider gestisce il server al tuo posto, richiama l'endpoint di registrazione dal provider di registrazione.

  * Esegui syslog da un contenitore. Ad esempio, puoi utilizzare questo [file .yaml di distribuzione ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/IBM-Cloud/kube-samples/blob/master/deploy-apps-clusters/deploy-syslog-from-kube.yaml) per recuperare un'immagine pubblica Docker che esegue un contenitore nel tuo cluster. L'immagine pubblica la porta `514` sull'indirizzo IP del cluster pubblico e utilizza questo indirizzo IP per configurare l'host syslog. Dovrai inserire l'autorità di certificazione (CA, certificate authority) pertinente e i certificati del lato server e aggiornare il file `syslog.conf` per abilitare `tls` sul tuo server.

4. Salva il tuo certificato dell'autorità di certificazione (CA, certificate authority) in un file denominato `ca-cert`. Deve essere esattamente questo nome.

5. Crea un segreto nello spazio dei nomi `kube-system` per il file `ca-cert`. Quando crei la tua configurazione di registrazione, utilizzerai il nome del segreto per l'indicatore `--ca-cert`.
    ```
    kubectl -n kube-system create secret generic --from-file=ca-cert
    ```
    {: pre}

6. Crea una configurazione di inoltro dei log.
    ```
    ibmcloud ks logging-config-create <cluster name or id> --logsource <log source> --type syslog --syslog-protocol tls --hostname <ip address of syslog server> --port <port for syslog server, 514 is default> --ca-cert <secret name> --verify-mode <defaults to verify-none>
    ```
    {: pre}

</br>
</br>


### Verifica dell'inoltro dei log
{: verify-logging}

Puoi verificare che la tua configurazione sia impostata correttamente in uno dei due seguenti modi:

* Per elencare tutte le configurazioni di registrazione in un cluster:
    ```
    ibmcloud ks logging-config-get <cluster_name_or_ID>
    ```
    {: pre}

* Per elencare le configurazioni di registrazione per un tipo di origine log:
    ```
    ibmcloud ks logging-config-get <cluster_name_or_ID> --logsource <source>
    ```
    {: pre}

</br>
</br>

### Aggiornamento dell'inoltro dei log
{: #updating-forwarding}

Puoi aggiornare una configurazione di registrazione che hai già creato.

1. Aggiorna una configurazione di inoltro dei log.
    ```
    ibmcloud ks logging-config-update <cluster_name_or_ID> <log_config_id> --namespace <namespace> --type <server_type> --syslog-protocol <protocol> --logsource <source> --hostname <hostname_or_ingestion_URL> --port <port> --space <cluster_space> --org <cluster_org> --app-containers <containers> --app-paths <paths_to_logs>
    ```
    {: pre}

</br>
</br>

### Arresto dell'inoltro dei log
{: #log_sources_delete}

Puoi arrestare l'inoltro dei log eliminando una o tutte le configurazioni di registrazione per un cluster.
{: shortdesc}

1. Per il cluster in cui si trova l'origine log: [accedi al tuo account. Specifica la regione appropriata e, se applicabile, il gruppo di risorse. Imposta il contesto per il tuo cluster](cs_cli_install.html#cs_cli_configure).

2. Elimina la configurazione di registrazione.
  <ul>
  <li>Per eliminare una configurazione di registrazione:</br>
    <pre><code>ibmcloud ks logging-config-rm &lt;cluster_name_or_ID&gt; --id &lt;log_config_ID&gt;</pre></code></li>
  <li>Per eliminare tutte le configurazioni di registrazione:</br>
    <pre><code>ibmcloud ks logging-config-rm <my_cluster> --all</pre></code></li>
  </ul>

</br>
</br>

### Visualizzazione dei log
{: #view_logs}

Per visualizzare i log per i cluster e i contenitori, puoi utilizzare le funzioni di registrazione di runtime del contenitore e Kubernetes standard.
{:shortdesc}

**{{site.data.keyword.loganalysislong_notm}}**
{: #view_logs_k8s}

Puoi visualizzare i log che hai inoltrato a {{site.data.keyword.loganalysislong_notm}} attraverso il dashboard Kibana.
{: shortdesc}

Se per creare il tuo file di configurazione hai utilizzato i valori predefiniti, i log possono essere trovati nell'account o nell'organizzazione e nello spazio in cui è stato creato il cluster. Se hai specificato un'organizzazione e uno spazio nel tuo file di configurazione, puoi trovare i tuoi log in quello spazio. Per ulteriori informazioni sulla registrazione, consulta [Registrazione di {{site.data.keyword.containerlong_notm}}](/docs/services/CloudLogAnalysis/containers/containers_kubernetes.html#containers_kubernetes).

Per accedere al dashboard Kibana, vai a uno dei seguenti URL e seleziona l'account o lo spazio {{site.data.keyword.Bluemix_notm}} in cui hai configurato l'inoltro dei log per il cluster.
- Stati Uniti Sud e Stati Uniti Est: https://logging.ng.bluemix.net
- Regno Unito-Sud: https://logging.eu-gb.bluemix.net
- Europa centrale: https://logging.eu-fra.bluemix.net
- Asia Pacifico Sud e Asia Pacifico Nord: https://logging.au-syd.bluemix.net

Per ulteriori informazioni sulla visualizzazione dei log, vedi [Passaggio a Kibana da un browser web](/docs/services/CloudLogAnalysis/kibana/launch.html#launch_Kibana_from_browser).

</br>

**Log del contenitore**

Puoi avvalerti delle funzionalità di registrazione di runtime del contenitore integrate per riesaminare le attività sui flussi di output
STDOUT e STDERR standard. Per ulteriori informazioni, vedi [Visualizzazione dei log di un contenitore in esecuzione in un cluster Kubernetes](/docs/services/CloudLogAnalysis/containers/containers_kubernetes.html#containers_kubernetes).

<br />


## Filtraggio dei log
{: #filter-logs}

Puoi scegliere quali log inoltrare filtrando specifici log per un periodo di tempo. Puoi differenziare tra le diverse opzioni di filtraggio usando gli indicatori.

<table>
<caption>Descrizione delle opzioni per il filtraggio log</caption>
  <thead>
    <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione delle opzioni di filtraggio log</th>
  </thead>
  <tbody>
    <tr>
      <td>&lt;cluster_name_or_ID&gt;</td>
      <td>Obbligatorio: il nome o l'ID del cluster per il quale desideri filtrare i log.</td>
    </tr>
    <tr>
      <td><code>&lt;log_type&gt;</code></td>
      <td>Il tipo di log a cui desideri applicare il filtro. Attualmente sono supportati <code>all</code>, <code>container</code> e <code>host</code>.</td>
    </tr>
    <tr>
      <td><code>&lt;configs&gt;</code></td>
      <td>Facoltativo: un elenco separato da virgole dei tuoi ID di configurazione di registrazione. Se non viene fornito, il filtro viene applicato a tutte le configurazioni di registrazione cluster passate al filtro. Puoi visualizzare le configurazioni di registrazione che corrispondono al filtro utilizzando l'opzione <code>--show-matching-configs</code>.</td>
    </tr>
    <tr>
      <td><code>&lt;kubernetes_namespace&gt;</code></td>
      <td>Facoltativo: lo spazio dei nomi Kubernetes da cui vuoi inoltrare i log. Questo indicatore si applica solo quando utilizzi il tipo di log <code>container</code>.</td>
    </tr>
    <tr>
      <td><code>&lt;container_name&gt;</code></td>
      <td>Facoltativo: il nome del contenitore da cui desideri filtrare i log.</td>
    </tr>
    <tr>
      <td><code>&lt;logging_level&gt;</code></td>
      <td>Facoltativo: filtra i log che si trovano al livello specificato e a quelli inferiori ad esso. I valori accettabili nel loro ordine canonico sono <code>fatal</code>, <code>error</code>, <code>warn/warning</code>, <code>info</code>, <code>debug</code> e <code>trace</code>. Ad esempio, se hai filtrato i log a livello <code>info</code>, vengono filtrati anche <code>debug</code> e <code>trace</code>. **Nota**: puoi utilizzare questo indicatore solo quando i messaggi di log sono in formato JSON e contengono un campo di livello. Per visualizzare i tuoi messaggi in JSON, aggiungi l'indicatore <code>--json</code> al comando.</td>
    </tr>
    <tr>
      <td><code>&lt;message&gt;</code></td>
      <td>Facoltativo: filtra i log che contengono un messaggio specificato scritto come un'espressione regolare.</td>
    </tr>
    <tr>
      <td><code>&lt;filter_ID&gt;</code></td>
      <td>Facoltativo: l'ID del filtro di log.</td>
    </tr>
    <tr>
      <td><code>--show-matching-configs</code></td>
      <td>Facoltativo: mostra le configurazioni di registrazione a cui applicare ciascun filtro.</td>
    </tr>
    <tr>
      <td><code>--all</code></td>
      <td>Facoltativo: elimina tutti i tuoi filtri di inoltro del log.</td>
    </tr>
  </tbody>
</table>


1. Crea un filtro di registrazione.
  ```
  ibmcloud ks logging-filter-create <cluster_name_or_ID> --type <log_type> --logging-configs <configs> --namespace <kubernetes_namespace> --container <container_name> --level <logging_level> --regex-message <message>
  ```
  {: pre}

2. Visualizza il filtro di log che hai creato.

  ```
  ibmcloud ks logging-filter-get <cluster_name_or_ID> --id <filter_ID> --show-matching-configs
  ```
  {: pre}

3. Aggiorna il filtro di log che hai creato.
  ```
  ibmcloud ks logging-filter-update <cluster_name_or_ID> --id <filter_ID> --type <server_type> --logging-configs <configs> --namespace <kubernetes_namespace --container <container_name> --level <logging_level> --regex-message <message>
  ```
  {: pre}

4. Elimina un filtro di log che hai creato.

  ```
  ibmcloud ks logging-filter-rm <cluster_name_or_ID> --id <filter_ID> [--all]
  ```
  {: pre}

<br />



## Configurazione dell'inoltro del log per i log di controllo dell'API Kubernetes
{: #api_forward}

Kubernetes controlla automaticamente tutti gli eventi trasmessi tramite il tuo apiserver. Puoi inoltrare gli eventi a {{site.data.keyword.loganalysisshort_notm}} o a un server esterno.
{: shortdesc}


Per ulteriori informazioni sui log di controllo Kubernetes, consulta l'<a href="https://kubernetes.io/docs/tasks/debug-application-cluster/audit/" target="blank">argomento di controllo <img src="../icons/launch-glyph.svg" alt="Icona link esterno"></a> nella documentazione Kubernetes.

* L'inoltro dei log di controllo dell'API Kubernetes è supportato solo per Kubernetes versione 1.9 e successive.
* Al momento, viene utilizzata una politica di controllo predefinita per tutti i cluster con questa configurazione di registrazione.
* Al momento, i filtri non sono supportati.
* Può essere presente solo una configurazione `kube-audit` per cluster, ma puoi inoltrare i log a {{site.data.keyword.loganalysisshort_notm}} e a un server esterno creando una configurazione di registrazione e un webhook.
* Devi disporre del [ruolo della piattaforma {{site.data.keyword.Bluemix_notm}} IAM **Amministratore**](cs_users.html#platform) per il cluster.


### Invio dei log di controllo a {{site.data.keyword.loganalysisshort_notm}}
{: #audit_enable_loganalysis}

Puoi inoltrare il tuoi log di controllo del server API Kubernetes a {{site.data.keyword.loganalysisshort_notm}}

**Prima di iniziare**

1. Verifica le autorizzazioni. Se hai specificato uno spazio quando hai creato il cluster o la configurazione di registrazione, sia il proprietario dell'account che il proprietario della chiave {{site.data.keyword.containerlong_notm}} necessitano delle autorizzazioni di Gestore, Sviluppatore o Revisore in quello spazio.

2. Per il cluster da cui vuoi raccogliere i log di controllo del server API: [accedi al tuo account. Specifica la regione appropriata e, se applicabile, il gruppo di risorse. Imposta il contesto per il tuo cluster](cs_cli_install.html#cs_cli_configure). **Nota**: se utilizzi un account dedicato, devi accedere all'endpoint {{site.data.keyword.cloud_notm}} pubblico e specificare come destinazione la tua organizzazione e il tuo spazio pubblici per abilitare l'inoltro dei log.

**Inoltro dei log**

1. Crea una configurazione di registrazione.

    ```
    ibmcloud ks logging-config-create <cluster_name_or_ID> --logsource kube-audit --space <cluster_space> --org <cluster_org> --hostname <ingestion_URL> --type ibm
    ```
    {: pre}

    Esempio di comando e output:

    ```
    ibmcloud ks logging-config-create myCluster --logsource kube-audit
    Creating logging configuration for kube-audit logs in cluster myCluster...
    OK
    Id                                     Source      Namespace   Host                                   Port     Org    Space   Server Type   Protocol  Application Containers   Paths
    14ca6a0c-5bc8-499a-b1bd-cedcf40ab850   kube-audit    -         ingest-au-syd.logging.bluemix.net✣    9091✣     -       -         ibm          -              -                  -

    ✣ Indicates the default endpoint for the {{site.data.keyword.loganalysisshort_notm}} service.

    ```
    {: screen}

    <table>
    <caption>Descrizione dei componenti di questo comando</caption>
      <thead>
        <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti di questo comando</th>
      </thead>
      <tbody>
        <tr>
          <td><code><em>&lt;cluster_name_or_ID&gt;</em></code></td>
          <td>Il nome o l'ID del cluster.</td>
        </tr>
        <tr>
          <td><code><em>&lt;ingestion_URL&gt;</em></code></td>
          <td>L'endpoint a cui vuoi inoltrare i log. Se non specifichi un [URL di inserimento](/docs/services/CloudLogAnalysis/log_ingestion.html#log_ingestion_urls), viene utilizzato l'endpoint per la regione in cui hai creato il tuo cluster.</td>
        </tr>
        <tr>
          <td><code><em>&lt;cluster_space&gt;</em></code></td>
          <td>Facoltativo: il nome dello spazio Cloud Foundry a cui vuoi inviare i log. Quando inoltri i log a {{site.data.keyword.loganalysisshort_notm}}, lo spazio e l'organizzazione sono specificati nel punto di inserimento. Se non specifichi uno spazio, i log vengono inviati al livello dell'account.</td>
        </tr>
        <tr>
          <td><code><em>&lt;cluster_org&gt;</em></code></td>
          <td>Il nome dell'organizzazione Cloud Foundry in cui si trova lo spazio. Questo valore è obbligatorio se hai specificato uno spazio.</td>
        </tr>
      </tbody>
    </table>

2. Visualizza la tua configurazione di registrazione del cluster per verificare che sia stata implementata nel modo che volevi.

    ```
    ibmcloud ks logging-config-get <cluster_name_or_ID>
    ```
    {: pre}

    Esempio di comando e output:
    ```
    ibmcloud ks logging-config-get myCluster
    Retrieving cluster myCluster logging configurations...
    OK
    Id                                     Source        Namespace   Host                                 Port    Org   Space   Server Type  Protocol  Application Containers   Paths
    a550d2ba-6a02-4d4d-83ef-68f7a113325c   container     *           ingest-au-syd.logging.bluemix.net✣  9091✣   -     -         ibm           -          -              -
    14ca6a0c-5bc8-499a-b1bd-cedcf40ab850   kube-audit    -           ingest-au-syd.logging.bluemix.net✣  9091✣   -     -         ibm           -          -              -       
    ```
    {: screen}

3. Facoltativo: se vuoi arrestare l'inoltro dei log di controllo, puoi [eliminare la tua configurazione](#log_sources_delete).

<br />



### Invio dei log di controllo a un server esterno
{: #audit_enable}

**Prima di iniziare**

1. Configura un server di registrazione remoto dove puoi inoltrare i log. Ad esempio, puoi [utilizzare Logstash con Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/tasks/debug-application-cluster/audit/#use-logstash-to-collect-and-distribute-audit-events-from-webhook-backend) per raccogliere gli eventi di controllo.

2. Per il cluster da cui vuoi raccogliere i log di controllo del server API: [accedi al tuo account. Specifica la regione appropriata e, se applicabile, il gruppo di risorse. Imposta il contesto per il tuo cluster](cs_cli_install.html#cs_cli_configure). **Nota**: se utilizzi un account dedicato, devi accedere all'endpoint {{site.data.keyword.cloud_notm}} pubblico e specificare come destinazione la tua organizzazione e il tuo spazio pubblici per abilitare l'inoltro dei log.

Per inoltrare i log di controllo dell'API Kubernetes:

1. Configura il webhook. Se non fornisci alcuna informazione negli indicatori, viene utilizzata una configurazione predefinita.

    ```
    ibmcloud ks apiserver-config-set audit-webhook <cluster_name_or_ID> --remoteServer <server_URL_or_IP> --caCert <CA_cert_path> --clientCert <client_cert_path> --clientKey <client_key_path>
    ```
    {: pre}

  <table>
  <caption>Descrizione dei componenti di questo comando</caption>
    <thead>
      <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti di questo comando</th>
    </thead>
    <tbody>
      <tr>
        <td><code><em>&lt;cluster_name_or_ID&gt;</em></code></td>
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
    </tbody>
  </table>

2. Verifica che l'inoltro dei log sia stato abilitato visualizzando l'URL per il servizio di registrazione remoto.

    ```
    ibmcloud ks apiserver-config-get audit-webhook <cluster_name_or_ID>
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
    ibmcloud ks apiserver-refresh <cluster_name_or_ID>
    ```
    {: pre}

4. Facoltativo: se vuoi arrestare l'inoltro dei log di controllo, puoi disabilitare la tua configurazione.
    1. Per il cluster da cui vuoi interrompere la raccolta dei log di controllo del server API: [accedi al tuo account. Specifica la regione appropriata e, se applicabile, il gruppo di risorse. Imposta il contesto per il tuo cluster](cs_cli_install.html#cs_cli_configure).
    2. Disabilita la configurazione back-end webhook per il server API del cluster.

        ```
        ibmcloud ks apiserver-config-unset audit-webhook <cluster_name_or_ID>
        ```
        {: pre}

    3. Applica l'aggiornamento della configurazione riavviando il master Kubernetes.

        ```
        ibmcloud ks apiserver-refresh <cluster_name_or_ID>
        ```
        {: pre}

<br />


## Raccolta dei log master
{: #collect_master}

Con {{site.data.keyword.containerlong_notm}}, puoi eseguire in qualsiasi momento un'istantanea dei tuoi log master per raccoglierli in un bucket {{site.data.keyword.cos_full_notm}}. L'istantanea include tutto ciò che viene inviato tramite il server API, come la pianificazione di pod, le distribuzioni o le politiche RBAC.
{: shortdesc}

Poiché i log del server API Kubernetes vengono trasmessi automaticamente, vengono anche eliminati automaticamente per fare spazio ai nuovi log in arrivo. Mantenendo un'istantanea dei log di un momento specifico, puoi meglio risolvere i problemi, esaminare le differenze di utilizzo e individuare i modelli per mantenere applicazioni più sicure.

**Prima di iniziare**

* [Esegui il provisioning di un'istanza](https://console.bluemix.net/docs/services/cloud-object-storage/basics/developers.html#provision-an-instance-of-ibm-cloud-object-storage) di {{site.data.keyword.cos_short}} dal catalogo {{site.data.keyword.Bluemix_notm}}.
* Assicurati di disporre del [ruolo della piattaforma {{site.data.keyword.Bluemix_notm}} IAM **Amministratore**](cs_users.html#platform) per il cluster.

**Creazione di un'istantanea**

1. Crea un bucket di Object Storage tramite la console {{site.data.keyword.Bluemix_notm}} seguendo [questa esercitazione introduttiva](https://console.bluemix.net/docs/services/cloud-object-storage/getting-started.html#create-buckets).

2. Genera le [credenziali del servizio HMAC](/docs/services/cloud-object-storage/iam/service-credentials.html) nel bucket che hai creato.
  1. Nella scheda **Credenziali del servizio** del dashboard {{site.data.keyword.cos_short}}, fai clic su **Nuova credenziale**.
  2. Fornisci alle credenziali HMAC il ruolo del servizio `Scrittore`.
  3. Nel campo **Aggiungi parametri di configurazione inline **, specifica `{"HMAC":true}`.

3. Tramite la CLI, effettua una richiesta per un'istantanea dei tuoi log master.

  ```
  ibmcloud ks logging-collect --cluster <cluster name or ID>  --type <type_of_log_to_collect> --cos-bucket <COS_bucket_name> --cos-endpoint <location_of_COS_bucket> --hmac-key-id <HMAC_access_key_ID> --hmac-key <HMAC_access_key> --type <log_type>
  ```
  {: pre}

  Comando e risposta di esempio:

  ```
  ibmcloud ks logging-collect --cluster mycluster --cos-bucket mybucket --cos-endpoint s3-api.us-geo.objectstorage.softlayer.net --hmac-key-id e2e7f5c9fo0144563c418dlhi3545m86 --hmac-key c485b9b9fo4376722f692b63743e65e1705301ab051em96j
  There is no specified log type. The default master will be used.
  Submitting log collection request for master logs for cluster mycluster...
  OK
  The log collection request was successfully submitted. To view the status of the request run ibmcloud ks logging-collect-status mycluster.
  ```
  {: screen}

4. Controlla lo stato della tua richiesta. Il completamento dell'istantanea potrebbe richiedere alcuni minuti, ma puoi verificare se la richiesta è stata completata o meno. Puoi trovare il nome del file che contiene i tuoi log master nella risposta e utilizzare la console {{site.data.keyword.Bluemix_notm}} per scaricare il file.

  ```
  ibmcloud ks logging-collect-status --cluster <cluster_name_or_ID>
  ```
  {: pre}

  Output di esempio:

  ```
  ibmcloud ks logging-collect-status --cluster mycluster
  Getting the status of the last log collection request for cluster mycluster...
  OK
  State     Start Time             Error   Log URLs
  success   2018-09-18 16:49 PDT   - s3-api.us-geo.objectstorage.softlayer.net/mybucket/master-0-0862ae70a9ae6c19845ba3pc0a2a6o56-1297318756.tgz
  s3-api.us-geo.objectstorage.softlayer.net/mybucket/master-1-0862ae70a9ae6c19845ba3pc0a2a6o56-1297318756.tgz
  s3-api.us-geo.objectstorage.softlayer.net/mybucket/master-2-0862ae70a9ae6c19845ba3pc0a2a6o56-1297318756.tgz
  ```
  {: screen}

<br />


## Visualizzazione delle metriche
{: #view_metrics}

Le metriche ti aiutano a monitorare l'integrità e le prestazioni dei tuoi cluster. Puoi utilizzare le funzioni di runtime del contenitore e Kubernetes standard per monitorare l'integrità dei tuoi cluster e delle tue applicazioni. **Nota**: il monitoraggio è supportato solo per i cluster standard.
{:shortdesc}

<dl>
  <dt>Pagina dei dettagli del cluster in {{site.data.keyword.Bluemix_notm}}</dt>
    <dd>{{site.data.keyword.containerlong_notm}} fornisce informazioni sull'integrità
e capacità del tuo cluster e sull'utilizzo delle tue risorse del cluster. Puoi utilizzare questa console per ridimensionare il tuo cluster, gestire la tua archiviazione persistente e aggiungere ulteriori funzionalità al cluster attraverso il bind del servizio {{site.data.keyword.Bluemix_notm}}. Per visualizzare la pagina dei dettagli del cluster,
vai al tuo **Dashboard {{site.data.keyword.Bluemix_notm}}** e seleziona un cluster.</dd>
  <dt>Dashboard Kubernetes</dt>
    <dd>Il dashboard Kubernetes è un'interfaccia web di amministrazione in cui puoi esaminare lo stato dei nodi di lavoro, trovare risorse Kubernetes, distribuire applicazioni inserite in un contenitore e risolvere problemi con le informazioni di registrazione e monitoraggio. Per ulteriori informazioni su come
accedere al tuo dashboard Kubernetes, consulta [Avvio del dashboard Kubernetes per {{site.data.keyword.containerlong_notm}}](cs_app.html#cli_dashboard).</dd>
  <dt>{{site.data.keyword.monitoringlong_notm}}</dt>
    <dd><p>Le metriche per i cluster standard si trovano nell'account {{site.data.keyword.Bluemix_notm}} a cui è stato effettuato l'accesso quando è stato creato il cluster Kubernetes. Se quando hai creato il cluster hai specificato uno spazio {{site.data.keyword.Bluemix_notm}}, le metriche si trovano in quello spazio. Le metriche di contenitore sono raccolte automaticamente per tutti i contenitori distribuiti in un cluster. Queste metriche vengono inviate e rese disponibili tramite Grafana. Per ulteriori informazioni sulle metriche, vedi [Monitoraggio per il {{site.data.keyword.containerlong_notm}}](/docs/services/cloud-monitoring/containers/monitoring_containers_ov.html#monitoring_bmx_containers_ov).</p>
    <p>Per accedere al dashboard Grafana, vai a uno dei seguenti URL e seleziona l'account o lo spazio {{site.data.keyword.Bluemix_notm}} in cui hai creato il cluster.</p> <table summary="La prima riga nella tabella si estende su entrambe le colonne. Le righe rimanenti devono essere lette da sinistra a destra, con la zona server nella colonna uno e gli indirizzi IP corrispondenti nella colonna due.">
  <caption>Gli indirizzi IP da aprire per il traffico di monitoraggio</caption>
        <thead>
        <th>Regione {{site.data.keyword.containerlong_notm}}</th>
        <th>Indirizzo di monitoraggio</th>
        <th>Indirizzi IP di monitoraggio</th>
        </thead>
      <tbody>
        <tr>
         <td>Europa Centrale</td>
         <td>metrics.eu-de.bluemix.net</td>
         <td><code>158.177.65.80/30</code></td>
        </tr>
        <tr>
         <td>Regno Unito Sud</td>
         <td>metrics.eu-gb.bluemix.net</td>
         <td><code>169.50.196.136/29</code></td>
        </tr>
        <tr>
          <td>Stati Uniti Est, Stati Uniti Sud, Asia Pacifico Nord, Asia Pacifico Sud</td>
          <td>metrics.ng.bluemix.net</td>
          <td><code>169.47.204.128/29</code></td>
         </tr>
         
        </tbody>
      </table>
 </dd>
  <dt>{{site.data.keyword.mon_full_notm}}</dt>
  <dd>Ottieni visibilità operativa sulle prestazioni e sull'integrità delle tue applicazioni distribuendo Sysdig come servizio di terze parti ai tuoi nodi di lavoro per inoltrare le metriche a {{site.data.keyword.monitoringlong}}. Per ulteriori informazioni, vedi [Analyzing metrics for an app that is deployed in a Kubernetes cluster](/docs/services/Monitoring-with-Sysdig/tutorials/kubernetes_cluster.html#kubernetes_cluster). **Nota**: {{site.data.keyword.mon_full_notm}} non supporta il runtime del contenitore `containerd`. Se usi {{site.data.keyword.mon_full_notm}} con i cluster della versione 1.11 o successive, non vengono raccolte tutte le metriche del contenitore.</dd>
</dl>

Per evitare conflitti quando si utilizza il servizio di metrica integrato, assicurati che i cluster tra i gruppi di risorse e le regioni abbiano nomi univoci.
{: tip}

### Altri strumenti di monitoraggio dell'integrità
{: #health_tools}

Puoi configurare altri strumenti per ulteriori funzionalità di monitoraggio.
<dl>
  <dt>Prometheus</dt>
    <dd>Prometheus è uno strumento di monitoraggio, registrazione e avviso open source progettato per Kubernetes. Lo strumento recupera informazioni dettagliate sul cluster, sui nodi di lavoro e sull'integrità della distribuzione in base alle informazioni di registrazione di Kubernetes. Per le informazioni di configurazione, consulta [Integrazione dei servizi con {{site.data.keyword.containerlong_notm}}](cs_integrations.html#integrations).</dd>
</dl>

<br />


## Configurazione del monitoraggio dell'integrità per i nodi di lavoro con Autorecovery
{: #autorecovery}

Il sistema Autorecovery di {{site.data.keyword.containerlong_notm}} può essere distribuito nei cluster esistenti di Kubernetes versione 1.9 o successive.
{: shortdesc}

Il sistema Autorecovery utilizza vari controlli per interrogare lo stato di integrità dei nodi di lavoro. Se Autorecovery rileva un nodo di lavoro non integro in base ai controlli configurati, attiva un'azione correttiva come un ricaricamento del sistema operativo sul nodo di lavoro. Viene eseguita un'azione correttiva su un solo nodo di lavoro alla volta. Il nodo di lavoro deve completare correttamente l'azione correttiva prima che qualsiasi altro nodo di lavoro sia sottoposto a un'azione correttiva. Per ulteriori informazioni consulta questo post del blog [Autorecovery ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.ibm.com/blogs/bluemix/2017/12/autorecovery-utilizes-consistent-hashing-high-availability/).</br> </br>

Autorecovery richiede che almeno un nodo sia integro per funzionare correttamente. Configura Autorecovery con controlli attivi solo nei cluster con due o più nodi di lavoro.
{: note}

Prima di iniziare:
- Verifica di disporre del [ruolo della piattaforma {{site.data.keyword.Bluemix_notm}} IAM **Amministratore**](cs_users.html#platform).
- [Accedi al tuo account. Specifica la regione appropriata e, se applicabile, il gruppo di risorse. Imposta il contesto per il tuo cluster](cs_cli_install.html#cs_cli_configure).

1. [Installa Helm per il tuo cluster e aggiungi il repository {{site.data.keyword.Bluemix_notm}} alla tua istanza Helm](cs_integrations.html#helm).

2. Crea un file di mappa di configurazione che definisca i tuoi controlli in formato JSON. Ad esempio, il seguente file YAML definisce tre controlli: un controllo HTTP e due controlli del server API Kubernetes. Fai riferimento alle tabelle che seguono il file YAML di esempio per informazioni sui tre tipi di controlli e sui componenti individuali dei controlli.
</br>
   **Suggerimento:** definisci ogni controllo come una chiave univoca nella sezione `data` della mappa di configurazione.

   ```
   kind: ConfigMap
   apiVersion: v1
   metadata:
     name: ibm-worker-recovery-checks
     namespace: kube-system
   data:
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
   <td><code>checknode.json</code></td>
   <td>Definisce un controllo del nodo dell'API Kubernetes che verifica se ogni nodo di lavoro è nello stato <code>Ready</code>. Il controllo per un nodo di lavoro specifico viene considerato un esito negativo se il nodo di lavoro non è nello stato <code>Ready</code>. Il controllo nel YAML di esempio viene eseguito ogni 3 minuti. Se ha esito negativo per tre volte consecutive, il nodo di lavoro viene ricaricato. Questa azione equivale all'esecuzione di <code>ibmcloud ks worker-reload</code>.<br></br>Il controllo del nodo è abilitato finché imposti il campo <b>Abilitato</b> su <code>false</code> o rimuovi il controllo.</td>
   </tr>
   <tr>
   <td><code>checkpod.json</code></td>
   <td>
   Definisce un controllo di pod dell'API Kubernetes che verifica la percentuale totale dei pod <code>NotReady</code> su un nodo di lavoro in base ai pod totali assegnati a tale nodo di lavoro. Il controllo per un nodo di lavoro specifico viene considerato un esito negativo se la percentuale totale dei pod <code>NotReady</code> è maggiore del valore definito <code>PodFailureThresholdPercent</code>. Il controllo nel YAML di esempio viene eseguito ogni 3 minuti. Se ha esito negativo per tre volte consecutive, il nodo di lavoro viene ricaricato. Questa azione equivale all'esecuzione di <code>ibmcloud ks worker-reload</code>. Ad esempio, il valore predefinito per <code>PodFailureThresholdPercent</code> è 50%. Se la percentuale dei pod <code>NotReady</code> è maggiore del 50% per tre volte consecutive, il nodo di lavoro viene ricaricato. <br></br>Per impostazione predefinita, vengono controllati i pod presenti in tutti gli spazi dei nomi. Per limitare il controllo ai soli pod presenti in un determinato spazio dei nomi, aggiungi il campo <code>Spazio dei nomi</code> al controllo. Il controllo del pod è abilitato finché imposti il campo <b>Abilitato</b> su <code>false</code> o rimuovi il controllo.
   </td>
   </tr>
   <tr>
   <td><code>checkhttp.json</code></td>
   <td>Definisce un controllo HTTP che controlla se un server HTTP in esecuzione sul tuo nodo di lavoro è integro. Per utilizzare questo controllo, devi distribuire un server HTTP su ogni nodo di lavoro presente nel tuo cluster utilizzando una [serie di daemon ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/). Devi implementare un controllo dell'integrità che troverai nel percorso <code>/myhealth</code> e che può verificare se il tuo server HTTP è integro. Puoi definire altri percorsi modificando il parametro <strong>Route</strong>. Se il server HTTP è integro, devi restituire il codice di risposta HTTP definito in <strong>ExpectedStatus</strong>. Il server HTTP deve essere configurato per essere in ascolto su un indirizzo IP privato del nodo di lavoro. Puoi trovare l'indirizzo IP privato eseguendo <code>kubectl get nodes</code>.<br></br>
   Ad esempio, considera due nodi in un cluster con gli indirizzi IP privati 10.10.10.1 e 10.10.10.2. In questo esempio, vengono controllate due rotte alla ricerca di una risposta 200 HTTP: <code>http://10.10.10.1:80/myhealth</code> e <code>http://10.10.10.2:80/myhealth</code>.
   Il controllo nel YAML di esempio viene eseguito ogni 3 minuti. Se ha esito negativo per tre volte consecutive, il nodo di lavoro viene riavviato. Questa azione equivale all'esecuzione di <code>ibmcloud ks worker-reboot</code>.<br></br>Il controllo HTTP non viene disabilitato finché non imposti il campo <b>Abilitato</b> su <code>true</code>.</td>
   </tr>
   </tbody>
   </table>

   <table summary="Descrizione dei componenti individuali dei controlli">
   <caption>Descrizione dei componenti individuali dei controlli</caption>
   <thead>
   <th colspan=2><img src="images/idea.png" alt="Icona Idea"/>Descrizione dei componenti individuali dei controlli </th>
   </thead>
   <tbody>
   <tr>
   <td><code>Check</code></td>
   <td>Immetti il tipo di controllo che vuoi venga utilizzato da Autorecovery. <ul><li><code>HTTP</code>: Autorecovery richiama i server HTTP in esecuzione su ciascun nodo per determinare se i nodi vengono eseguiti correttamente.</li><li><code>KUBEAPI</code>: Autorecovery richiama il server API Kubernetes e legge i dati sullo stato di integrità riportati dai nodi di lavoro.</li></ul></td>
   </tr>
   <tr>
   <td><code>Resource</code></td>
   <td>Quando il tipo di controllo è <code>KUBEAPI</code>, immetti il tipo di risorsa che vuoi venga controllata da Autorecovery. I valori accettati sono <code>NODE</code> o <code>POD</code>.</td>
   </tr>
   <tr>
   <td><code>FailureThreshold</code></td>
   <td>Immetti la soglia per il numero di controlli non riusciti consecutivi. Quando viene raggiunta questa soglia, Autorecovery attiva l'azione correttiva specificata. Ad esempio, se il valore è 3 e Autorecovery non riesce ad eseguire un controllo configurato tre volte consecutive, Autorecovery attiva l'azione correttiva associata al controllo.</td>
   </tr>
   <tr>
   <td><code>PodFailureThresholdPercent</code></td>
   <td>Quando il tipo di risorsa è <code>POD</code>, immetti la soglia per la percentuale di pod su un nodo di lavoro che può trovarsi in uno stato [NotReady ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/#define-readiness-probes). Questa percentuale si basa sul numero totale di pod pianificati su un nodo di lavoro. Quando un controllo determina che la percentuale di pod non integri è maggiore della soglia, il controllo conta come un errore.</td>
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
   <td>Quando il tipo di controllo è <code>HTTP</code>, immetti la porta a cui deve essere associato il server HTTP sui nodi di lavoro. Questa porta deve essere esposta sull'IP di ogni nodo di lavoro nel cluster. Autorecovery richiede un numero di porta costante tra tutti i nodi per il controllo dei server. Utilizza le [serie di daemon ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) quando distribuisci un server personalizzato in un cluster.</td>
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
   <tr>
   <td><code>Spazio dei nomi</code></td>
   <td> Facoltativo: per limitare <code>checkpod.json</code> al controllo dei soli pod presenti in uno spazio dei nomi, aggiungi il campo <code>Spazio dei nomi</code> e immetti lo spazio dei nomi.</td>
   </tr>
   </tbody>
   </table>

3. Crea la mappa di configurazione nel tuo cluster.

    ```
    kubectl apply -f ibm-worker-recovery-checks.yaml
    ```
    {: pre}

3. Verifica di aver creato la mappa di configurazione con il nome `ibm-worker-recovery-checks` nello spazio dei nomi `kube-system` con i controlli appropriati.

    ```
    kubectl -n kube-system get cm ibm-worker-recovery-checks -o yaml
    ```
    {: pre}

4. Distribuisci Autorecovery nel tuo cluster installando il grafico Helm `ibm-worker-recovery`.

    ```
    helm install --name ibm-worker-recovery ibm/ibm-worker-recovery  --namespace kube-system
    ```
    {: pre}

5. Dopo alcuni minuti, puoi controllare la sezione `Events` nell'output del seguente comando per visualizzare l'attività sulla distribuzione di Autorecovery.

    ```
    kubectl -n kube-system describe deployment ibm-worker-recovery
    ```
    {: pre}

6. Se non stai visualizzando dell'attività nella distribuzione di Autorecovery, puoi controllare la distribuzione Helm eseguendo i test inclusi nella definizione del grafico di Autorecovery.

    ```
    helm test ibm-worker-recovery
    ```
    {: pre}
