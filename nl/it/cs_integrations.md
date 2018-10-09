---

copyright:
  years: 2014, 2018
lastupdated: "2018-09-10"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}




# Integrazione dei servizi
{: #integrations}

Puoi utilizzare vari servizi esterni e servizi di catalogo con un cluster Kubernetes standard in {{site.data.keyword.containerlong}}.
{:shortdesc}


## Servizi delle applicazioni
{: #application_services}
<table summary="Riepilogo dell'accessibilità">
<caption>Servizi delle applicazioni</caption>
<thead>
<tr>
<th>Servizio</th>
<th>Descrizione</th>
</tr>
</thead>
<tbody>
<tr>
<td>{{site.data.keyword.blockchainfull}}</td>
<td>Distribuisci un ambiente di sviluppo pubblicamente per IBM Blockchain a un cluster Kubernetes in {{site.data.keyword.containerlong_notm}}. Utilizza questo ambiente per sviluppare e personalizzare la tua propria rete blockchain per distribuire le applicazioni che condividono un ledger immutabile per la registrazione della cronologia delle transazioni. Per ulteriori informazioni, consulta
<a href="https://ibm-blockchain.github.io" target="_blank">Sviluppa in un sandbox cloud della piattaforma
IBM Blockchain <img src="../icons/launch-glyph.svg" alt="Icona link esterno"></a>. </td>
</tr>
</tbody>
</table>

<br />



## Servizi DevOps
{: #devops_services}
<table summary="Riepilogo dell'accessibilità">
<caption>Servizi DevOps</caption>
<thead>
<tr>
<th>Servizio</th>
<th>Descrizione</th>
</tr>
</thead>
<tbody>
<tr>
<td>Codeship</td>
<td>Puoi utilizzare <a href="https://codeship.com" target="_blank">Codeship <img src="../icons/launch-glyph.svg" alt="Icona link esterno"></a> per l'integrazione e la consegna continua dei contenitori. Per ulteriori informazioni, consulta <a href="https://www.ibm.com/blogs/bluemix/2017/10/using-codeship-pro-deploy-workloads-ibm-container-service/" target="_blank">Using Codeship Pro To Deploy Workloads to {{site.data.keyword.containerlong_notm}} <img src="../icons/launch-glyph.svg" alt="Icona link esterno"></a>. </td>
</tr>
<tr>
<td>Helm</td>
<td> <a href="https://helm.sh" target="_blank">Helm <img src="../icons/launch-glyph.svg" alt="Icona link esterno"></a> è un gestore del pacchetto Kubernetes. Puoi creare nuovi grafici Helm o utilizzare grafici Helm preesistenti per definire, installare e aggiornare applicazioni Kubernetes complesse eseguite nei cluster {{site.data.keyword.containerlong_notm}}. <p>Per ulteriori informazioni, vedi [Configurazione di Helm in {{site.data.keyword.containerlong_notm}}](cs_integrations.html#helm).</p></td>
</tr>
<tr>
<td>{{site.data.keyword.contdelivery_full}}</td>
<td>Automatizza le creazioni delle tue applicazioni e le distribuzioni del contenitore ai cluster Kubernetes utilizzando una toolchain. Per informazioni sulla configurazione, consulta il blog <a href="https://developer.ibm.com/recipes/tutorials/deploy-kubernetes-pods-to-the-bluemix-container-service-using-devops-pipelines/" target="_blank">Deploy Kubernetes pods to the {{site.data.keyword.containerlong_notm}} using DevOps Pipelines <img src="../icons/launch-glyph.svg" alt="Icona link esterno"></a>. </td>
</tr>
<tr>
<td>Istio</td>
<td><a href="https://www.ibm.com/cloud/info/istio" target="_blank">Istio <img src="../icons/launch-glyph.svg" alt="Icona link esterno"></a> è un servizio open source che offre agli sviluppatori un modo per connettere, proteggere, gestire e monitorare una rete di microservizi, nota anche come rete (mesh) di servizi, su piattaforme di orchestrazione cloud come Kubernetes. Controlla il post del blog relativo a <a href="https://developer.ibm.com/dwblog/2017/istio/" target="_blank">come IBM ha collaborato a fondare e avviato Istio<img src="../icons/launch-glyph.svg" alt="Icona link esterno"></a> per trovare ulteriori informazioni sul progetto open source. Per installare Istio sul tuo cluster Kubernetes in {{site.data.keyword.containerlong_notm}} e iniziare ad utilizzare un'applicazione di esempio, consulta [Tutorial: Managing microservices with Istio](cs_tutorials_istio.html#istio_tutorial).</td>
</tr>
</tbody>
</table>

<br />



## Servizi di registrazione e monitoraggio
{: #health_services}
<table summary="Riepilogo dell'accessibilità">
<caption>Servizi di registrazione e monitoraggio</caption>
<thead>
<tr>
<th>Servizio</th>
<th>Descrizione</th>
</tr>
</thead>
<tbody>
<tr>
<td>CoScale</td>
<td>Monitora i nodi di lavoro, i contenitori, le serie di repliche, i controller della replica e i servizi con <a href="https://www.coscale.com/" target="_blank">CoScale <img src="../icons/launch-glyph.svg" alt="Icona link esterno"></a>. Per ulteriori informazioni, consulta <a href="https://www.ibm.com/blogs/bluemix/2017/06/monitoring-ibm-bluemix-container-service-coscale/" target="_blank">Monitoring {{site.data.keyword.containerlong_notm}} with CoScale <img src="../icons/launch-glyph.svg" alt="Icona link esterno"></a>. </td>
</tr>
<tr>
<td>Datadog</td>
<td>Monitora il tuo cluster e visualizza le metriche delle prestazioni dell'applicazione e dell'infrastruttura con <a href="https://www.datadoghq.com/" target="_blank">Datadog <img src="../icons/launch-glyph.svg" alt="Icona link esterno"></a>. Per ulteriori informazioni, consulta <a href="https://www.ibm.com/blogs/bluemix/2017/07/monitoring-ibm-bluemix-container-service-datadog/" target="_blank">Monitoring {{site.data.keyword.containerlong_notm}} with Datadog <img src="../icons/launch-glyph.svg" alt="Icona link esterno"></a>. </td>
</tr>
<tr>
<td> {{site.data.keyword.cloudaccesstrailfull}}</td>
<td>Monitora l'attività amministrativa eseguita nel tuo cluster analizzando i log tramite Grafana. Per ulteriori informazioni sul servizio, vedi la documentazione del [Programma di traccia dell'attività](/docs/services/cloud-activity-tracker/index.html). Per ulteriori informazioni sui tipi di eventi che puoi tracciare, vedi gli [eventi del Programma di traccia dell'attività](/cs_at_events.html).</td>
</tr>
<tr>
<td>{{site.data.keyword.loganalysisfull}}</td>
<td>Espandi le tue capacità di raccolta, conservazione e ricerca dei log con {{site.data.keyword.loganalysisfull_notm}}. Per ulteriori informazioni, vedi <a href="../services/CloudLogAnalysis/containers/containers_kube_other_logs.html" target="_blank">Abilitazione della raccolta automatica dei log di cluster <img src="../icons/launch-glyph.svg" alt="Icona link esterno"></a>. </td>
</tr>
<tr>
<td>{{site.data.keyword.monitoringlong}}</td>
<td>Espandi le tue capacità di raccolta e conservazione delle metriche definendo regole e avvisi con {{site.data.keyword.monitoringlong_notm}}. Per ulteriori informazioni, vedi <a href="../services/cloud-monitoring/tutorials/container_service_metrics.html" target="_blank">Analizza le metriche in Grafana per un'applicazione distribuita in un cluster Kubernetes <img src="../icons/launch-glyph.svg" alt="Icona link esterno"></a>. </td>
</tr>
<tr>
<td>Instana</td>
<td> <a href="https://www.instana.com/" target="_blank">Instana <img src="../icons/launch-glyph.svg" alt="Icona link esterno"></a> fornisce il monitoraggio delle prestazioni di infrastruttura e applicazioni con una GUI che rileva e associa automaticamente le tue applicazioni. Istana cattura ogni richiesta alle tue applicazioni, che puoi utilizzare per risolvere i problemi ed eseguire l'analisi delle cause principali per evitare che i problemi si ripetano. Per ulteriori informazioni, controlla il post del blog relativo alla <a href="https://www.instana.com/blog/precise-visibility-applications-ibm-bluemix-container-service/" target="_blank">distribuzione di Istana in {{site.data.keyword.containerlong_notm}} <img src="../icons/launch-glyph.svg" alt="Icona link esterno"></a>.</td>
</tr>
<tr>
<td>Prometheus</td>
<td>Prometheus è uno strumento di avviso, registrazione e monitoraggio open source che è stato specificatamente progettato per Kubernetes. Prometheus recupera informazioni dettagliate sul cluster, sui nodi di lavoro e sull'integrità della distribuzione in base alle informazioni di registrazione di Kubernetes. La CPU, la memoria, I/O e l'attività di rete vengono raccolti per ogni contenitore in esecuzione in un cluster. Puoi utilizzare i dati raccolti in query o avvisi personalizzati per monitorare le prestazioni e i carichi di lavoro nel tuo cluster.

<p>Per utilizzare Prometheus, segui le <a href="https://github.com/coreos/prometheus-operator/tree/master/contrib/kube-prometheus" target="_blank">istruzioni CoreOS <img src="../icons/launch-glyph.svg" alt="Icona link esterno"></a>.</p>
</td>
</tr>
<tr>
<td>Sematext</td>
<td>Visualizza le metriche e i log per le tue applicazioni inserite in un contenitore utilizzando <a href="https://sematext.com/" target="_blank">Sematext <img src="../icons/launch-glyph.svg" alt="Icona link esterno"></a>. Per ulteriori informazioni, consulta <a href="https://www.ibm.com/blogs/bluemix/2017/09/monitoring-logging-ibm-bluemix-container-service-sematext/" target="_blank">Monitoring and logging for containers with Sematext <img src="../icons/launch-glyph.svg" alt="Icona link esterno"></a>. </td>
</tr>
<tr>
<td>Sysdig</td>
<td>Acquisisci le metriche dell'applicazione, del contenitore, di statsd e dell'host con un solo punto di strumentazione utilizzando <a href="https://sysdig.com/" target="_blank">Sysdig <img src="../icons/launch-glyph.svg" alt="Icona link esterno"></a>. Per ulteriori informazioni, consulta <a href="https://www.ibm.com/blogs/bluemix/2017/08/monitoring-ibm-bluemix-container-service-sysdig-container-intelligence/" target="_blank">Monitoring {{site.data.keyword.containerlong_notm}} with Sysdig Container Intelligence <img src="../icons/launch-glyph.svg" alt="Icona link esterno"></a>. </td>
</tr>
<tr>
<td>Weave Scope</td>
<td>Weave Scope fornisce un diagramma visivo delle risorse in un cluster Kubernetes,
inclusi i servizi, i pod, i contenitori, i processi, i nodi e altro. Scope fornisce metriche interattive
per la CPU e la memoria e inoltre fornisce strumenti per inserire ed eseguire in un contenitore.<p>Per ulteriori informazioni, consulta [Visualizzazione delle risorse del cluster Kubernetes con Weave Scope e {{site.data.keyword.containerlong_notm}}](cs_integrations.html#weavescope).</p></li></ol>
</td>
</tr>
</tbody>
</table>

<br />



## Servizi di sicurezza
{: #security_services}
<table summary="Riepilogo dell'accessibilità">
<caption>Servizi di sicurezza</caption>
<thead>
<tr>
<th>Servizio</th>
<th>Descrizione</th>
</tr>
</thead>
<tbody>
  <tr id="appid">
    <td>{{site.data.keyword.appid_full}}</td>
    <td>Aggiungi un livello di sicurezza alle tue applicazioni con [{{site.data.keyword.appid_short}}](/docs/services/appid/index.html#gettingstarted) richiedendo agli utenti di effettuare l'accesso. Per autenticare le richieste HTTP/HTTPS web o API nella tua applicazione, puoi integrare {{site.data.keyword.appid_short_notm}} con il tuo servizio Ingress utilizzando l'[annotazione Ingress per l'autenticazione {{site.data.keyword.appid_short_notm}}](cs_annotations.html#appid-auth).</td>
  </tr>
<tr>
<td>Aqua Security</td>
  <td>Come un supplemento al <a href="/docs/services/va/va_index.html" target="_blank">Controllo vulnerabilità</a>, puoi utilizzare <a href="https://www.aquasec.com/" target="_blank">Aqua Security <img src="../icons/launch-glyph.svg" alt="Icona link esterno"></a> per migliorare la sicurezza delle distribuzioni del contenitore riducendo cosa è consentito fare alla tua applicazione. Per ulteriori informazioni, consulta <a href="https://blog.aquasec.com/securing-container-deployments-on-bluemix-with-aqua-security" target="_blank">Securing container deployments on {{site.data.keyword.Bluemix_notm}} with Aqua Security <img src="../icons/launch-glyph.svg" alt="Icona link esterno"></a>. </td>
</tr>
<tr>
<td>{{site.data.keyword.cloudcerts_full}}</td>
<td>Puoi utilizzare <a href="../services/certificate-manager/index.html" target="_blank">{{site.data.keyword.cloudcerts_long}} <img src="../icons/launch-glyph.svg" alt="Icona link esterno"></a> per archiviare e gestire i certificati SSL per le tue applicazioni. Per ulteriori informazioni, consulta <a href="https://www.ibm.com/blogs/bluemix/2018/01/use-ibm-cloud-certificate-manager-ibm-cloud-container-service-deploy-custom-domain-tls-certificates/" target="_blank">Use {{site.data.keyword.cloudcerts_long_notm}} with {{site.data.keyword.containerlong_notm}} to deploy custom domain TLS Certificates <img src="../icons/launch-glyph.svg" alt="Icona link esterno"></a>. </td>
</tr>
<tr>
  <td>{{site.data.keyword.registrylong}}</td>
  <td>Imposta il tuo repository delle immagini Docker protetto in cui puoi memorizzare e condividere in modo sicuro le immagini tra gli utenti cluster. Per ulteriori informazioni, vedi la <a href="/docs/services/Registry/index.html" target="_blank">{{site.data.keyword.registrylong}} documentazione <img src="../icons/launch-glyph.svg" alt="Icona link esterno"></a>.</td>
</tr>
<tr>
<td>NeuVector</td>
<td>Proteggi i contenitori con un firewall nativo nel cloud utilizzando <a href="https://neuvector.com/" target="_blank">NeuVector <img src="../icons/launch-glyph.svg" alt="Icona link esterno"></a>. Per ulteriori informazioni, consulta <a href="https://www.ibm.com/us-en/marketplace/neuvector-container-security" target="_blank">NeuVector Container Security <img src="../icons/launch-glyph.svg" alt="Icona link esterno"></a>. </td>
</tr>
<tr>
<td>Twistlock</td>
<td>Come un supplemento al <a href="/docs/services/va/va_index.html" target="_blank">Controllo vulnerabilità</a>, puoi utilizzare <a href="https://www.twistlock.com/" target="_blank">Twistlock <img src="../icons/launch-glyph.svg" alt="Icona link esterno"></a> per gestire i firewall, la protezione dalle minacce e la risposta agli incidenti. Per ulteriori informazioni, consulta <a href="https://www.ibm.com/blogs/bluemix/2017/07/twistlock-ibm-bluemix-container-service/" target="_blank">Twistlock on {{site.data.keyword.containerlong_notm}} <img src="../icons/launch-glyph.svg" alt="Icona link esterno"></a>. </td>
</tr>
</tbody>
</table>

<br />



## Servizi di archiviazione
{: #storage_services}
<table summary="Riepilogo dell'accessibilità">
<caption>Servizi di archiviazione</caption>
<thead>
<tr>
<th>Servizio</th>
<th>Descrizione</th>
</tr>
</thead>
<tbody>
<tr>
  <td>Heptio Ark</td>
  <td>Puoi utilizzare <a href="https://github.com/heptio/ark" target="_blank">Heptio Ark <img src="../icons/launch-glyph.svg" alt="Icona link esterno"></a> per eseguire il backup e per ripristinare le risorse del cluster e i volumi persistenti. Per ulteriori informazioni, vedi Heptio Ark <a href="https://github.com/heptio/ark/blob/master/docs/use-cases.md#use-cases" target="_blank">Use cases for disaster recovery and cluster migration <img src="../icons/launch-glyph.svg" alt="Icona link esterno"></a>.</td>
</tr>
<tr>
  <td>{{site.data.keyword.cos_full}}</td>
  <td>I dati memorizzati con {{site.data.keyword.cos_short}} vengono crittografati e diffusi tra più posizioni geografiche e vi si accede su HTTP utilizzando un'API REST. Puoi utilizzare l'[immagine ibm-backup-restore](/docs/services/RegistryImages/ibm-backup-restore/index.html) per configurare il servizio per creare backup monouso o pianificati per i dati nei tuoi cluster. Per informazioni generali sul servizio, vedi la <a href="/docs/services/cloud-object-storage/about-cos.html" target="_blank">{{site.data.keyword.cos_short}} documentazione <img src="../icons/launch-glyph.svg" alt="Icona link esterno"></a>.</td>
</tr>
  <tr>
    <td>{{site.data.keyword.cloudantfull}}</td>
    <td>{{site.data.keyword.cloudant_short_notm}} è un DBaaS (document-oriented DataBase as a Service) che memorizza i dati come documenti in formato JSON. Il servizio viene creato per la scalabilità, l'alta disponibilità e la durabilità. Per ulteriori informazioni, vedi la <a href="/docs/services/Cloudant/getting-started.html" target="_blank">{{site.data.keyword.cloudant_short_notm}} documentazione <img src="../icons/launch-glyph.svg" alt="Icona link esterno"></a>.</td>
  </tr>
  <tr>
    <td>{{site.data.keyword.composeForMongoDB_full}}</td>
    <td>{{site.data.keyword.composeForMongoDB}} offre alta disponibilità e ridondanza, backup no-stop in locale e automatizzati, strumenti di monitoraggio, integrazione nei sistemi di avviso, viste dell'analisi delle prestazioni e altro ancora. Per ulteriori informazioni, vedi la <a href="/docs/services/ComposeForMongoDB/index.html" target="_blank">{{site.data.keyword.composeForMongoDB}} documentazione <img src="../icons/launch-glyph.svg" alt="Icona link esterno"></a>.</td>
  </tr>
</tbody>
</table>


<br />



## Aggiunta dei servizi {{site.data.keyword.Bluemix_notm}}
ai cluster
{: #adding_cluster}

Aggiungi i servizi {{site.data.keyword.Bluemix_notm}} per migliorare il tuo cluster Kubernetes con funzionalità supplementari in aree quali l'intelligenza artificiale Watson, i dati, la sicurezza e IoT (Internet of Things).
{:shortdesc}

**Importante:** puoi eseguire il bind solo di servizi che supportano le chiavi del servizio. Per trovare un elenco con i servizi che supportano le chiavi del servizio, vedi [Abilitazione di applicazioni esterne a utilizzare servizi {{site.data.keyword.Bluemix_notm}}](/docs/apps/reqnsi.html#accser_external).

Prima di iniziare, [indirizza la tua CLI](cs_cli_install.html#cs_cli_configure) al tuo cluster.

Per aggiungere un servizio {{site.data.keyword.Bluemix_notm}} al tuo cluster:
1. [Crea un'istanza del servizio {{site.data.keyword.Bluemix_notm}}](/docs/apps/reqnsi.html#req_instance). </br></br>**Nota:** alcuni servizi {{site.data.keyword.Bluemix_notm}} sono disponibili solo in regioni selezionate. Puoi eseguire il bind di un servizio al tuo cluster solo se il servizio è disponibile nella stessa regione del tuo cluster. Inoltre, se vuoi creare un'istanza del servizio nella zona Washington DC, devi utilizzare la CLI.

2. Controlla il tipo di servizio che hai creato e prendi nota del nome (**Name**) dell'istanza del servizio.
   - **Servizi Cloud Foundry:**
     ```
     ibmcloud service list
     ```
     {: pre}

     Output di esempio:
     ```
     name                         service           plan    bound apps   last operation
     <cf_service_instance_name>   <service_name>    spark                create succeeded
     ```
     {: screen}

  - **Servizi abilitati a IAM:**
     ```
     ibmcloud resource service-instances
     ```
     {: pre}

     Output di esempio:
     ```
     Name                          Location   State    Type               Tags   
     <iam_service_instance_name>   <region>   active   service_instance      
     ```
     {: screen}

   Puoi anche vedere i diversi tipi di servizio nel tuo dashboard come **Servizi Cloud Foundry** e **Servizi**.

3. Per i servizi abilitati a IAM, crea un alias Cloud Foundry in modo da poter eseguire il bind di questo servizio al tuo cluster. Se il tuo servizio è già un servizio Cloud Foundry, questo passo non è necessario e puoi continuare con il passo successivo.
   1. Specifica come destinazione un'organizzazione e uno spazio Cloud Foundry.
      ```
      ibmcloud target --cf
      ```
      {: pre}

   2. Crea un alias Cloud Foundry per l'istanza del servizio.
      ```
      ibmcloud resource service-alias-create <service_alias_name> --instance-name <iam_service_instance_name>
      ```
      {: pre}

   3. Verifica che l'alias del servizio venga creato.
      ```
      ibmcloud service list
      ```
      {: pre}

4. Identifica lo spazio dei nomi del cluster che desideri utilizzare per l'aggiunta del tuo servizio. Scegli tra le seguenti opzioni:
   - Elenca gli spazi dei nomi esistenti e scegline uno che desideri utilizzare.
     ```
     kubectl get namespaces
     ```
     {: pre}

   - Crea uno spazio dei nomi nel tuo cluster.
     ```
     kubectl create namespace <namespace_name>
     ```
     {: pre}

5.  Aggiungi il servizio al tuo cluster. Per i servizi abilitati a IAM, assicurati di utilizzare l'alias Cloud Foundry che hai creato in precedenza.
    ```
    ibmcloud ks cluster-service-bind <cluster_name_or_ID> <namespace> <service_instance_name>
    ```
    {: pre}

    Dopo che
il servizio è stato correttamente associato al tuo cluster, viene creato un segreto cluster che contiene le credenziali
della tua istanza del servizio. I segreti vengono automaticamente crittografati in etcd per proteggere i tuoi dati.

    Output di esempio:
    ```
    ibmcloud ks cluster-service-bind mycluster mynamespace cleardb
    Binding service instance to namespace...
    OK
    Namespace:	mynamespace
    Secret name:     binding-<service_instance_name>
    ```
    {: screen}

6.  Verifica le credenziali del servizio nel tuo segreto Kubernetes.
    1. Ottieni i dettagli del segreto e prendi nota del valore **binding**. Il valore **binding** ha una codifica base64 e contiene le credenziali per la tua istanza del servizio in formato JSON.
       ```
       kubectl get secrets binding-<service_instance_name> --namespace=<namespace> -o yaml
       ```
       {: pre}

       Output di esempio:
       ```
       apiVersion: v1
       data:
         binding: <binding>
       kind: Secret
       metadata:
         annotations:
           service-instance-id: 1111aaaa-a1aa-1aa1-1a11-111aa111aa11
           service-key-id: 2b22bb2b-222b-2bb2-2b22-b22222bb2222
         creationTimestamp: 2018-08-07T20:47:14Z
         name: binding-<service_instance_name>
         namespace: <namespace>
         resourceVersion: "6145900"
         selfLink: /api/v1/namespaces/default/secrets/binding-mycloudant
         uid: 33333c33-3c33-33c3-cc33-cc33333333c
       type: Opaque
       ```
       {: screen}

    2. Decodifica il valore di bind.
       ```
       echo "<binding>" | base64 -D
       ```
       {: pre}

       Output di esempio:
       ```
       {"apikey":"KL34Ys893284NGJEPFjgrioJ12NElpow","host":"98765aab-9ce1-7tr3-ba87-bfbab6e6d9d6-bluemix.cloudant.com","iam_apikey_description":"Auto generated apikey during resource-key operation for Instance - crn:v1:bluemix:public:cloudantnosqldb:us-south:a/1234g56789cfe8e6388dd2ec098:98746cw-43d7-49ce-947a-d8fe3eebb381::","iam_apikey_name":"auto-generated-apikey-1234abcde-987f-3t64-9d96-d13775ec5663","iam_role_crn":"crn:v1:bluemix:public:iam::::serviceRole:Writer","iam_serviceid_crn":"crn:v1:bluemix:public:iam-identity::a/1234567890brasge5htn2ec098::serviceid:ServiceId-12345vgh-6c4c-ytr12-af6b-467d30d6ef44","password":"jfiavhui12484fnivhuo472nvei23913c3ff","port":443,"url":"https://25c73aac-9ce1-4c24-ba98-bfbab6e6d9d6-bluemix:ugvioev823inreuiegn43donvri29989wiu9t22@25c73aac-9ce1-4c24-ba98-abdrjio123562lnsb-bluemix.cloudant.com","username":"123b45da-9ce1-4c24-ab12-rinwnwub1294-bluemix"}
       ```
       {: screen}

    3. Facoltativo: confronta le credenziali del servizio che hai decodificato nel passo precedente con le credenziali del servizio che trovi per la tua istanza del servizio nel dashboard {{site.data.keyword.Bluemix_notm}}.

7. Ora che è stato eseguito il bind del tuo servizio al tuo cluster, devi configurare la tua applicazione per [accedere alle credenziali del servizio nel segreto Kubernetes](#adding_app).


## Accesso alle credenziali del servizio dalle tue applicazioni
{: #adding_app}

Per accedere ad un'istanza del servizio {{site.data.keyword.Bluemix_notm}} dalla tua applicazione, devi rendere le credenziali del servizio archiviate nel segreto di Kubernetes disponibili per la tua applicazione.
{: shortdesc}

Le credenziali di un'istanza del servizio hanno una codifica base64 e sono archiviate all'interno del tuo segreto in formato JSON. Per accedere ai dati nel tuo segreto, scegli tra le seguenti opzioni:
- [Monta il segreto come un volume al tuo pod](#mount_secret)
- [Fai riferimento al segreto nelle variabili di ambiente](#reference_secret)

Prima di iniziare:
- [Indirizza la tua CLI](cs_cli_install.html#cs_cli_configure) al tuo cluster.
- [Aggiungi un servizio {{site.data.keyword.Bluemix_notm}} al tuo cluster](#adding_cluster).

### Montaggio del segreto come un volume al tuo pod
{: #mount_secret}

Quando monti un segreto come un volume al tuo pod, un file denominato `binding` viene archiviato nella directory di montaggio del volume. Il file `binding` in formato JSON include tutte le informazioni e le credenziali di cui hai bisogno per accedere al servizio {{site.data.keyword.Bluemix_notm}}.
{: shortdesc}

1.  Elenca i segreti disponibili nel tuo cluster e prendi nota del **nome** del tuo segreto. Cerca un segreto di tipo **Opaque**. Se sono presenti più segreti, contatta il tuo amministratore cluster per identificare il segreto del servizio
corretto.

    ```
    kubectl get secrets
    ```
    {: pre}

    Output di esempio:

    ```
    NAME                                    TYPE                                  DATA      AGE
    binding-<service_instance_name>         Opaque                                1         3m

    ```
    {: screen}

2.  Crea un file YAML per la tua distribuzione Kubernetes e monta il segreto come un volume al tuo pod.
    ```
    apiVersion: apps/v1beta1
    kind: Deployment
    metadata:
      labels:
        app: secret-test
      name: secret-test
      namespace: <my_namespace>
    spec:
      selector:
        matchLabels:
          app: secret-test
      replicas: 1
      template:
        metadata:
          labels:
            app: secret-test
        spec:
          containers:
          - image: registry.bluemix.net/ibmliberty:latest
            name: secret-test
            volumeMounts:
            - mountPath: <mount_path>
              name: <volume_name>
          volumes:
          - name: <volume_name>
            secret:
              defaultMode: 420
              secretName: binding-<service_instance_name>
    ```
    {: codeblock}

    <table>
    <caption>Descrizione dei componenti del file YAML</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code>volumeMounts/mountPath</code></td>
    <td>Il percorso assoluto della directory in cui viene montato il volume nel contenitore.</td>
    </tr>
    <tr>
    <td><code>volumeMounts/name</code></br><code>volumes/name</code></td>
    <td>Il nome del volume per montare il tuo pod.</td>
    </tr>
    <tr>
    <td><code>secret/defaultMode</code></td>
    <td>Le autorizzazioni di lettura e scrittura sul segreto. Utilizza `420` per impostare le autorizzazioni di sola lettura.</td>
    </tr>
    <tr>
    <td><code>secret/secretName</code></td>
    <td>Il nome del segreto di cui hai preso nota nel passo precedente.</td>
    </tr></tbody></table>

3.  Crea il pod e monta il segreto come un volume.
    ```
    kubectl apply -f secret-test.yaml
    ```
    {: pre}

4.  Verifica che il pod sia stato creato.
    ```
    kubectl get pods
    ```
    {: pre}

    Output CLI di esempio:

    ```
    NAME                           READY     STATUS    RESTARTS   AGE
    secret-test-1111454598-gfx32   1/1       Running   0          1m
    ```
    {: screen}

5.  Accedi alle credenziali del servizio.
    1. Accedi al tuo pod.
       ```
       kubectl exec <pod_name> -it bash
       ```
       {: pre}

    2. Vai al tuo percorso di montaggio del volume che hai definito in precedenza ed elenca i file in esso contenuti.
       ```
       cd <volume_mountpath> && ls
       ```
       {: pre}

       Output di esempio:
       ```
       binding
       ```
       {: screen}

       Il file `binding` include le credenziali del servizio che hai archiviato nel segreto Kubernetes.

    4. Visualizza le credenziali del servizio. Le credenziali vengono archiviate come coppie chiave-valore in formato JSON.
       ```
       cat binding
       ```
       {: pre}

       Output di esempio:
       ```
       {"apikey":"KL34Ys893284NGJEPFjgrioJ12NElpow","host":"98765aab-9ce1-7tr3-ba87-bfbab6e6d9d6-bluemix.cloudant.com","iam_apikey_description":"Auto generated apikey during resource-key operation for Instance - crn:v1:bluemix:public:cloudantnosqldb:us-south:a/1234g56789cfe8e6388dd2ec098:98746cw-43d7-49ce-947a-d8fe3eebb381::","iam_apikey_name":"auto-generated-apikey-1234abcde-987f-3t64-9d96-d13775ec5663","iam_role_crn":"crn:v1:bluemix:public:iam::::serviceRole:Writer","iam_serviceid_crn":"crn:v1:bluemix:public:iam-identity::a/1234567890brasge5htn2ec098::serviceid:ServiceId-12345vgh-6c4c-ytr12-af6b-467d30d6ef44","password":"jfiavhui12484fnivhuo472nvei23913c3ff","port":443,"url":"https://25c73aac-9ce1-4c24-ba98-bfbab6e6d9d6-bluemix:ugvioev823inreuiegn43donvri29989wiu9t22@25c73aac-9ce1-4c24-ba98-abdrjio123562lnsb-bluemix.cloudant.com","username":"123b45da-9ce1-4c24-ab12-rinwnwub1294-bluemix"}
       ```
       {: screen}

    5. Configura la tua applicazione per analizzare il contenuto JSON e richiamare le informazioni di cui hai bisogno per accedere al tuo servizio.


### Riferimento al segreto nelle variabili di ambiente
{: #reference_secret}

Puoi aggiungere le credenziali del servizio e altre coppie chiave-valore dal tuo segreto Kubernetes come variabili di ambiente alla tua distribuzione.   
{: shortdesc}

1. Elenca i segreti disponibili nel tuo cluster e prendi nota del **nome** del tuo segreto. Cerca un segreto di tipo **Opaque**. Se sono presenti più segreti, contatta il tuo amministratore cluster per identificare il segreto del servizio
corretto.

    ```
    kubectl get secrets
    ```
    {: pre}

    Output di esempio:

    ```
    NAME                                    TYPE                                  DATA      AGE
    binding-<service_instance_name>         Opaque                                1         3m
    ```
    {: screen}

2. Ottieni i dettagli del tuo segreto per trovare le potenziali coppie chiave-valore a cui puoi fare riferimento come variabili di ambiente nel tuo pod. Le credenziali del servizio sono archiviate nella chiave `binding` del tuo segreto.
   ```
   kubectl get secrets binding-<service_instance_name> --namespace=<namespace> -o yaml
   ```
   {: pre}

   Output di esempio:
   ```
   apiVersion: v1
   data:
     binding: <binding>
   kind: Secret
   metadata:
     annotations:
       service-instance-id: 7123acde-c3ef-4ba2-8c52-439ac007fa70
       service-key-id: 9h30dh8a-023f-4cf4-9d96-d12345ec7890
     creationTimestamp: 2018-08-07T20:47:14Z
     name: binding-<service_instance_name>
     namespace: <namespace>
     resourceVersion: "6145900"
     selfLink: /api/v1/namespaces/default/secrets/binding-mycloudant
     uid: 12345a31-9a83-11e8-ba83-cd49014748f
   type: Opaque
   ```
   {: screen}

3. Crea un file YAML per la tua distribuzione Kubernetes e specifica una variabile di ambiente che fa riferimento alla chiave `binding`.
   ```
   apiVersion: apps/v1beta1
   kind: Deployment
   metadata:
     labels:
       app: secret-test
     name: secret-test
     namespace: <my_namespace>
   spec:
     selector:
       matchLabels:
         app: secret-test
     template:
       metadata:
         labels:
           app: secret-test
       spec:
         containers:
         - image: registry.bluemix.net/ibmliberty:latest
           name: secret-test
           env:
           - name: BINDING
             valueFrom:
               secretKeyRef:
                 name: binding-<service_instance_name>
                 key: binding
     ```
     {: codeblock}

     <table>
     <caption>Descrizione dei componenti del file YAML</caption>
     <thead>
     <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
     </thead>
     <tbody>
     <tr>
     <td><code>containers/env/name</code></td>
     <td>Il nome della tua variabile di ambiente.</td>
     </tr>
     <tr>
     <td><code>env/valueFrom/secretKeyRef/name</code></td>
     <td>Il nome del segreto di cui hai preso nota nel passo precedente.</td>
     </tr>
     <tr>
     <td><code>env/valueFrom/secretKeyRef/key</code></td>
     <td>La chiave che fa parte del tuo segreto e a cui vuoi fare riferimento nella tua variabile di ambiente. Per fare riferimento alle credenziali del servizio, devi utilizzare la chiave <strong>binding</strong> .  </td>
     </tr>
     </tbody></table>

4. Crea il pod che fa riferimento alla chiave `binding` del tuo segreto come una variabile di ambiente.
   ```
   kubectl apply -f secret-test.yaml
   ```
   {: pre}

5. Verifica che il pod sia stato creato.
   ```
   kubectl get pods
   ```
   {: pre}

   Output CLI di esempio:
   ```
   NAME                           READY     STATUS    RESTARTS   AGE
    secret-test-1111454598-gfx32   1/1       Running   0          1m
   ```
   {: screen}

6. Verifica che la variabile di ambiente sia impostata correttamente.
   1. Accedi al tuo pod.
      ```
      kubectl exec <pod_name> -it bash
      ```
      {: pre}

   2. Elenca tutte le variabili di ambiente nel pod.
      ```
      env
      ```
      {: pre}

      Output di esempio:
      ```
      BINDING={"apikey":"KL34Ys893284NGJEPFjgrioJ12NElpow","host":"98765aab-9ce1-7tr3-ba87-bfbab6e6d9d6-bluemix.cloudant.com","iam_apikey_description":"Auto generated apikey during resource-key operation for Instance - crn:v1:bluemix:public:cloudantnosqldb:us-south:a/1234g56789cfe8e6388dd2ec098:98746cw-43d7-49ce-947a-d8fe3eebb381::","iam_apikey_name":"auto-generated-apikey-1234abcde-987f-3t64-9d96-d13775ec5663","iam_role_crn":"crn:v1:bluemix:public:iam::::serviceRole:Writer","iam_serviceid_crn":"crn:v1:bluemix:public:iam-identity::a/1234567890brasge5htn2ec098::serviceid:ServiceId-12345vgh-6c4c-ytr12-af6b-467d30d6ef44","password":"jfiavhui12484fnivhuo472nvei23913c3ff","port":443,"url":"https://25c73aac-9ce1-4c24-ba98-bfbab6e6d9d6-bluemix:ugvioev823inreuiegn43donvri29989wiu9t22@25c73aac-9ce1-4c24-ba98-abdrjio123562lnsb-bluemix.cloudant.com","username":"123b45da-9ce1-4c24-ab12-rinwnwub1294-bluemix"}
      ```
      {: screen}

7. Configura la tua applicazione per leggere la variabile di ambiente e per analizzare il contenuto JSON per richiamare le informazioni di cui hai bisogno per accedere al tuo servizio.

   Codice di esempio in Python:
   ```
   if os.environ.get('BINDING'):
        credentials = json.loads(os.environ.get('BINDING'))
   ```
   {: codeblock}

## Configurazione di Helm in {{site.data.keyword.containerlong_notm}}
{: #helm}

[Helm ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://helm.sh) è un gestore pacchetti di Kubernetes. Puoi creare grafici Helm o utilizzare grafici Helm preesistenti per definire, installare e aggiornare applicazioni Kubernetes complesse eseguite nei cluster {{site.data.keyword.containerlong_notm}}.
{:shortdesc}

Prima di utilizzare i grafici Helm con {{site.data.keyword.containerlong_notm}}, devi installare e inizializzare un'istanza Helm nel tuo cluster. Puoi quindi aggiungere il repository Helm {{site.data.keyword.Bluemix_notm}} alla tua istanza Helm.

Prima di iniziare, [indirizza la tua CLI](cs_cli_install.html#cs_cli_configure) al cluster in cui vuoi utilizzare un grafico Helm.

1. Installa la <a href="https://docs.helm.sh/using_helm/#installing-helm" target="_blank">CLI Helm <img src="../icons/launch-glyph.svg" alt="Icona link esterno"></a>.

2. **Importante**: per mantenere la sicurezza del cluster, crea un account di servizio per Tiller nello spazio dei nomi `kube-system` e un bind del ruolo cluster RBAC Kubernetes per il pod `tiller-deploy`.

    1. Nel tuo editor preferito, crea il seguente file e salvalo come `rbac-config.yaml`. **Nota**: per installare Tiller con l'account di servizio e il bind del ruolo cluster nello spazio dei nomi `kube-system`, devi avere il [ruolo `cluster-admin`](cs_users.html#access_policies). Puoi scegliere uno spazio dei nomi diverso da `kube-system`, ma tutti i grafici Helm IBM devono essere installati in `kube-system`. Quando esegui un comando `helm`, devi usare l'indicatore `tiller-namespace <namespace>` per puntare all'altro spazio dei nomi in cui è installato Tiller.

      ```
      apiVersion: v1
      kind: ServiceAccount
      metadata:
        name: tiller
        namespace: kube-system
      ---
      apiVersion: rbac.authorization.k8s.io/v1
      kind: ClusterRoleBinding
      metadata:
        name: tiller
      roleRef:
        apiGroup: rbac.authorization.k8s.io
        kind: ClusterRole
        name: cluster-admin
      subjects:
        - kind: ServiceAccount
          name: tiller
          namespace: kube-system
      ```
      {: codeblock}

    2. Crea l'account di servizio e il bind del ruolo cluster.

        ```
        kubectl create -f rbac-config.yaml
        ```
        {: pre}

3. Inizializza Helm e installa `tiller` con l'account di servizio che hai creato.

    ```
    helm init --service-account tiller
    ```
    {: pre}

4. Verifica che il pod `tiller-deploy` abbia uno **Status** di `Running` nel tuo cluster.

    ```
    kubectl get pods -n kube-system -l app=helm
    ```
    {: pre}

    Output di esempio:

    ```
    NAME                            READY     STATUS    RESTARTS   AGE
    tiller-deploy-352283156-nzbcm   1/1       Running   0          2m
    ```
    {: screen}

5. Aggiungi il repository Helm {{site.data.keyword.Bluemix_notm}} alla tua istanza Helm.

    ```
    helm repo add ibm  https://registry.bluemix.net/helm/ibm
    ```
    {: pre}

6. Elenca i grafici Helm attualmente disponibili nel repository {{site.data.keyword.Bluemix_notm}}.

    ```
    helm search ibm
    ```
    {: pre}

7. Per ulteriori informazioni su un grafico, elencane le impostazioni e i valori predefiniti.

    Ad esempio, per visualizzare le impostazioni, la documentazione e i valori predefiniti per il grafico Helm del servizio VPN IPSec strongSwan:

    ```
    helm inspect ibm/strongswan
    ```
    {: pre}


### Link Helm correlati
{: #helm_links}

* Per utilizzare il grafico Helm strongSwan, vedi [Configurazione della connettività VPN con il grafico Helm del servizio VPN IPSec strongSwan](cs_vpn.html#vpn-setup).
* Visualizza i grafici Helm disponibili che puoi utilizzare con {{site.data.keyword.Bluemix_notm}} nella GUI [Helm Charts Catalog ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://console.bluemix.net/containers-kubernetes/solutions/helm-charts).
* Ulteriori informazioni sui comandi Helm utilizzati per configurare e gestire i grafici Helm sono disponibili nella <a href="https://docs.helm.sh/helm/" target="_blank">documentazione Helm <img src="../icons/launch-glyph.svg" alt="Icona link esterno"></a>.
* Ulteriori informazioni su come puoi [aumentare la velocità di distribuzione con i grafici Helm Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://developer.ibm.com/recipes/tutorials/increase-deployment-velocity-with-kubernetes-helm-charts/).

## Visualizzazione delle risorse del cluster Kubernetes
{: #weavescope}

Weave Scope fornisce un diagramma visivo delle tue risorse all'interno di un cluster Kubernetes, inclusi servizi, pod, contenitori e altro. Weave Scope fornisce metriche interattive per CPU e memoria e strumenti per l'accodamento e l'esecuzione in un contenitore.
{:shortdesc}

Prima di iniziare:

-   Ricorda di non esporre le informazioni del tuo cluster pubblicamente su internet. Completa questa procedura per distribuire in sicurezza Weave Scope e accedervi da un browser web
localmente.
-   Se non ne hai già uno, [crea un
cluster standard](cs_clusters.html#clusters_ui). Weave Scope può essere intensivo per la CPU, specialmente l'applicazione. Esegui Weave Scope con grandi cluster a pagamento, non con cluster gratuito.
-   [Indirizza la tua
CLI](cs_cli_install.html#cs_cli_configure) al tuo cluster per eseguire i comandi kubectl.


Per utilizzare Weave Scope con un cluster:
2.  Distribuisci uno dei file di configurazione delle autorizzazioni RBAC fornite nel
cluster.

    Per abilitare le autorizzazioni di lettura/scrittura:

    ```
    kubectl apply -f "https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/weave-scope/weave-scope-rbac.yaml"
    ```
    {: pre}

    Per abilitare le autorizzazioni di
sola
lettura:

    ```
    kubectl apply --namespace weave -f "https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/weave-scope/weave-scope-rbac-readonly.yaml"
    ```
    {: pre}

    Output:

    ```
    clusterrole "weave-scope-mgr" created
    clusterrolebinding "weave-scope-mgr-role-binding" created
    ```
    {: screen}

3.  Distribuisci il servizio Weave Scope, che è accessibile privatamente dall'indirizzo IP del cluster.

    <pre class="pre">
    <code>kubectl apply --namespace weave -f "https://cloud.weave.works/k8s/scope.yaml?k8s-version=$(kubectl version | base64 | tr -d '&bsol;n')"</code>
    </pre>

    Output:

    ```
    serviceaccount "weave-scope" created
    deployment "weave-scope-app" created
    service "weave-scope-app" created
    daemonset "weave-scope-agent" created
    ```
    {: screen}

4.  Esegui un comando di inoltro della porta per aprire il servizio nel tuo computer. La volta successiva che accedi a Weave Scope, puoi eseguire questo comando di inoltro della porta senza dover completare nuovamente i precedenti passi di configurazione.

    ```
    kubectl port-forward -n weave "$(kubectl get -n weave pod --selector=weave-scope-component=app -o jsonpath='{.items..metadata.name}')" 4040
    ```
    {: pre}

    Output:

    ```
    Forwarding from 127.0.0.1:4040 -> 4040
    Forwarding from [::1]: :1]:4040 -> 4040
    Handling connection for 4040
    ```
    {: screen}

5.  Apri il tuo browser web in `http://localhost:4040`. Senza i componenti predefiniti distribuiti, viene visualizzato il seguente diagramma. Puoi scegliere di visualizzare i diagrammi della topologia o le tabelle delle risorse Kubernetes nel cluster.

     <img src="images/weave_scope.png" alt="Topologia di esempio da Weave Scope" style="width:357px;" />


[Ulteriori informazioni sulle funzioni Weave Scope ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.weave.works/docs/scope/latest/features/).

<br />

