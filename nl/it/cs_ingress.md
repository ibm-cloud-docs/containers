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


# Esposizione delle applicazioni con Ingress
{: #ingress}

Esponi più applicazioni nel tuo cluster Kubernetes creando risorse Ingress che vengono gestite dal programma di bilanciamento del carico dell'applicazione fornito da IBM in {{site.data.keyword.containerlong}}.
{:shortdesc}

## Componenti Ingress e architettura
{: #planning}

Ingress è un servizio Kubernetes che bilancia i carichi di lavoro del traffico di rete nel tuo cluster inoltrando le richieste pubbliche o private alle tue applicazioni. Puoi utilizzare Ingress per esporre più servizi dell'applicazione ad una rete pubblica o privata utilizzando una rotta pubblica o privata univoca.
{:shortdesc}

**Cosa viene fornito con Ingress?**</br>
Ingress è composto da tre componenti:
<dl>
<dt>Risorsa Ingress</dt>
<dd>Per esporre un'applicazione utilizzando Ingress, devi creare un servizio Kubernetes per la tua applicazione e registrare questo servizio con Ingress definendo una risorsa Ingress. La risorsa Ingress è una risorsa Kubernetes che definisce le regole su come instradare le richieste in entrata per le applicazioni. La risorsa Ingress specifica anche il percorso ai tuoi servizi dell'applicazione che vengono accodati all'instradamento pubblico per formare un URL applicazione univoco come ad esempio `mycluster.us-south.containers.appdomain.cloud/myapp1`. <br></br>**Nota**: a partire dal 24 maggio 2018, il formato del dominio secondario Ingress cambia per i nuovi cluster. Il nome della regione o della zona incluso nel nuovo formato del dominio secondario viene generato in base alla zona in cui è stato creato il cluster. Se hai dipendenze pipeline sui nomi dominio dell'applicazione coerenti, puoi usare il tuo dominio personalizzato invece del dominio secondario Ingress fornito da IBM.<ul><li>A tutti i cluster creati dopo il 24 maggio 2018 viene assegnato un dominio secondario nel nuovo formato, <code>&lt;cluster_name&gt;.&lt;region_or_zone&gt;.containers.appdomain.cloud</code>.</li><li>I cluster a zona singola creati dopo il 24 maggio 2018 continuano a usare il dominio secondario assegnato nel vecchio formato, <code>&lt;cluster_name&gt;.&lt;region&gt;.containers.mybluemix.net</code>.</li><li>Se modifichi un cluster a zona singola creato prima del 24 maggio 2018 in uno multizona [aggiungendo una zona al cluster](cs_clusters.html#add_zone) per la prima volta, il cluster continuerà a usare il dominio secondario assegnato nel vecchio formato,
<code>&lt;cluster_name&gt;.&lt;region&gt;.containers.mybluemix.net</code> e gli verrà assegnato anche un dominio secondario nel nuovo formato, <code>&lt;cluster_name&gt;.&lt;region_or_zone&gt;.containers.appdomain.cloud</code>. Possono essere utilizzati entrambi i domini secondari.</li></ul></br>**Cluster multizona**: la risorsa Ingress è globale ed è necessaria solo una risorsa Ingress per spazio dei nomi per un cluster multizona.</dd>
<dt>ALB (programma di bilanciamento del carico dell'applicazione)</dt>
<dd>L'ALB è un programma di bilanciamento del carico esterno che ascolta le richieste del servizio HTTP, HTTPS, TCP o UDP in entrata. L'ALB inoltra quindi le richieste al pod dell'applicazione appropriato in base alle regole definire nella risorsa Ingress. Quando crei un cluster standard, {{site.data.keyword.containershort_notm}} crea automaticamente un ALB altamente disponibile per il tuo cluster e gli assegna una rotta pubblica univoca. La rotta pubblica è collegata a un indirizzo IP pubblico portatile che viene fornito nel tuo account dell'infrastruttura IBM Cloud (SoftLayer) durante la creazione del cluster. Viene inoltre creato automaticamente un ALB privato predefinito, ma non viene automaticamente abilitato.<br></br>**Cluster multizona**: quando aggiungi una zona al tuo cluster, viene aggiunta una sottorete pubblica portatile e viene creato e abilitato automaticamente un nuovo ALB pubblico sulla sottorete in tale zona. Tutti gli ALB pubblici predefiniti nel tuo cluster condividono un instradamento pubblico ma hanno indirizzi IP diversi. In ciascuna zona viene creato automaticamente anche un ALB privato predefinito, ma non viene abilitato automaticamente.</dd>
<dt>MZLB (programma di bilanciamento del carico multizona)</dt>
<dd><p>**Cluster multizona**: ogni volta che modifichi un cluster da zona singola a multizona [aggiungendo una zona al cluster](cs_clusters.html#add_zone) per la prima volta, viene creato e distribuito automaticamente un MZLB in ogni zona in cui hai nodi di lavoro. L'integrità di MZLB controlla gli ALB in ciascuna zona del tuo cluster e tiene aggiornati i risultati della ricerca DNS in base a questi controlli di integrità. Ad esempio, se i tuoi ALB hanno indirizzi IP `1.1.1.1`, `2.2.2.2` e `3.3.3.3`, una normale operazione di ricerca DNS del tuo dominio secondario Ingress restituisce tutti e 3 gli IP, il client accede a uno di essi in modo casuale. Se l'ALB con indirizzo IP `3.3.3.3` diventa non disponibile per un qualsiasi motivo, il controllo di integrità MZLB avrà esito negativo, la ricerca DNS restituirà gli IP ALB `1.1.1.1` e `2.2.2.2` disponibili e il client accederà a uno degli IP ALB disponibili.</p>
<p>I programmi di bilanciamento del carico MZLB per gli ALB pubblici usano solo il dominio secondario Ingress fornito da IBM. Se usi solo ALB privati, devi controllare manualmente l'integrità degli ALB e aggiornare i risultati di ricerca DNS. Se usi ALB pubblici che usano un dominio personalizzato, puoi includere gli ALB nel bilanciamento del carico di MZLB creando un CNAME nella tua voce DNS per inoltrare le richieste dal tuo dominio personalizzato al dominio secondario Ingress fornito da IBM per il tuo cluster.</p>
<p><strong>Nota</strong>: se usi politiche di rete ante-DNAT per bloccare tutto il traffico in entrata ai servizi Ingress, devi anche inserire in whitelist gli <a href="https://www.cloudflare.com/ips/">IP IPv4 di Cloudflare <img src="../icons/launch-glyph.svg" alt="Icona link esterno"></a> usati per controllare l'integrità dei tuoi ALB. Per la procedura su come creare una politica Calico ante-DNAT per inserire in whitelist questi IP, vedi la Lezione 3 dell'<a href="cs_tutorials_policies.html#lesson3">esercitazione della politica di rete Calico</a>.</dd>
</dl>

**In che modo viene effettuata una richiesta alla mia applicazione con Ingress in un cluster a zona singola?**</br>
Il seguente diagramma mostra in che modo Ingress indirizza la comunicazione da internet a un'applicazione in un cluster a zona singola:

<img src="images/cs_ingress_singlezone.png" alt="Esponi un'applicazione in un cluster a zona singola utilizzando Ingress" style="border-style: none"/>

1. Un utente invia una richiesta alla tua applicazione accedendo all'URL dell'applicazione. Questo URL è l'URL pubblico per la tua applicazione esposta a cui è aggiunto il percorso della risorsa Ingress, ad esempio `mycluster.us-south.containers.appdomain.cloud/myapp`.

2. Un servizio di sistema DNS risolve il nome host nell'URL nell'indirizzo IP pubblico portatile del programma di bilanciamento del carico che espone l'ALB nel tuo cluster.

3. In base all'indirizzo IP risolto, il client invia la richiesta al servizio del programma di bilanciamento del carico che espone l'ALB.

4. Il servizio del programma di bilanciamento del carico instrada la richiesta all'ALB.

5. L'ALB verifica se esiste una regola di instradamento per il percorso `myapp` nel cluster. Se viene trovata una regola corrispondente, la richiesta viene inoltrata in base alle regole definite nella risorsa Ingress al pod in cui è distribuita l'applicazione. L'indirizzo IP di origine del pacchetto viene modificato con l'indirizzo IP dell'indirizzo IP pubblico del nodo di lavoro su cui è in esecuzione il pod dell'applicazione. Se nel cluster vengono distribuite più istanze dell'applicazione, l'ALB bilancia il carico delle richieste tra i pod dell'applicazione.

**In che modo viene effettuata una richiesta alla mia applicazione con Ingress in un cluster multizona?**</br>
Il seguente diagramma mostra in che modo Ingress indirizza la comunicazione da internet a un'applicazione in un cluster multizona:

<img src="images/cs_ingress_multizone.png" alt="Esponi un'applicazione in un cluster multizona utilizzando Ingress" style="border-style: none"/>

1. Un utente invia una richiesta alla tua applicazione accedendo all'URL dell'applicazione. Questo URL è l'URL pubblico per la tua applicazione esposta a cui è aggiunto il percorso della risorsa Ingress, ad esempio `mycluster.us-south.containers.appdomain.cloud/myapp`.

2. Un servizio di sistema DNS, che funge da programma di bilanciamento del carico globale, risolve il nome host nell'URL in un indirizzo IP disponibile che è stato riportato come integro da MZLB. MZLB controlla continuamente gli indirizzi IP pubblici portatili dei servizi di bilanciamento del carico che espongono gli ALB pubblici nel tuo cluster. Gli indirizzi IP vengono risolti in un ciclo round-robin, ciò garantisce che le richieste vengono bilanciate equamente tra gli ALB integri nelle varie zone.

3. Il client invia la richiesta all'indirizzo IP del servizio del programma di bilanciamento del carico che espone un ALB.

4. Il servizio del programma di bilanciamento del carico instrada la richiesta all'ALB.

5. L'ALB verifica se esiste una regola di instradamento per il percorso `myapp` nel cluster. Se viene trovata una regola corrispondente, la richiesta viene inoltrata in base alle regole definite nella risorsa Ingress al pod in cui è distribuita l'applicazione. L'indirizzo IP di origine del pacchetto viene modificato con l'indirizzo IP dell'indirizzo IP pubblico del nodo di lavoro su cui è in esecuzione il pod dell'applicazione. Se nel cluster vengono distribuite più istanze dell'applicazione, l'ALB bilancia il carico delle richieste tra i pod dell'applicazione tra tutte le zone.

<br />


## Prerequisiti
{: #config_prereqs}

Prima di iniziare ad utilizzare Ingress, controlla i seguenti prerequisiti.
{:shortdesc}

**Prerequisiti per tutte le configurazioni Ingress:**
- Ingress è disponibile solo per i cluster standard e richiede almeno due nodi di lavoro per zona per garantire l'alta disponibilità e l'applicazione di aggiornamenti periodici.
- La configurazione di Ingress richiede una [politica di accesso Amministratore](cs_users.html#access_policies). Verifica la tua [politica di accesso](cs_users.html#infra_access) corrente.

**Prerequisiti per l'uso di Ingress in cluster multizona**:
 - Se limiti il traffico di rete a [nodo di lavoro edge](cs_edge.html), devi abilitare almeno 2 nodo di lavoro edge in ciascuna zona per l'alta disponibilità dei pod Ingress. [Crea un pool di nodi di lavoro del nodo edge](cs_clusters.html#add_pool) che si estenda tra tutte le zone del tuo cluster e che abbia almeno 2 nodi di lavoro per zona.
 - Per abilitare la comunicazione sulla rete privata tra i nodi di lavoro che si trovano in zone diverse, devi abilitare lo [spanning delle VLAN](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning). 
 - Se una zona presenta un malfunzionamento, potresti riscontrare malfunzionamenti intermittenti nelle richieste all'ALB Ingress in tale zona.

<br />


## Pianificazione della rete per spazi dei nomi singoli o multipli
{: #multiple_namespaces}

È necessaria almeno una risorsa Ingress per lo spazio dei nomi in cui hai delle applicazioni da esporre.
{:shortdesc}

<dl>
<dt>Tutte le applicazioni sono in uno spazio dei nomi</dt>
<dd>Se le applicazioni nel tuo cluster sono tutte nello stesso spazio dei nomi, è necessaria almeno una risorsa Ingress per definire le regole di instradamento delle applicazioni qui esposte. Ad esempio, se hai `app1` e `app2` esposte dai servizi in uno spazio dei nomi di sviluppo, puoi creare una risorsa Ingress nello spazio dei nomi. La risorsa specifica `domain.net` come host e registra i percorsi su cui è in ascolto ogni applicazione con `domain.net`.
<br></br><img src="images/cs_ingress_single_ns.png" width="300" alt="È necessaria almeno una risorsa per spazio dei nomi" style="width:300px; border-style: none"/>
</dd>
<dt>Le applicazioni sono in più spazi dei nomi</dt>
<dd>Se le applicazioni nel tuo cluster sono in spazi dei nomi differenti, devi creare almeno una risorsa per spazio dei nomi per definire le regole delle applicazioni qui esposte. Per registrare più risorse Ingress con l'ALB Ingress del cluster, devi utilizzare un dominio jolly. Quando viene registrato un dominio jolly come `*.domain.net`, tutti i domini multipli vengono risolti nello stesso host. Quindi, puoi creare una risorsa Ingress in ogni spazio dei nomi e specificare un dominio secondario diverso in ogni risorsa Ingress.
<br><br>
Ad esempio, considera il seguente scenario:<ul>
<li>Hai due versioni della stessa applicazione, `app1` e `app3`, per scopi di test.</li>
<li>Distribuisci le applicazioni in due spazi dei nomi differenti all'interno dello stesso cluster: `app1` nello spazio dei nomi di sviluppo e `app3` in quello di preparazione.</li></ul>
Per utilizzare lo stesso ALB del cluster per gestire il traffico a queste applicazioni, crea i seguenti servizi e risorse:<ul>
<li>Un servizio Kubernetes nello spazio dei nomi di sviluppo per esporre `app1`.</li>
<li>Una risorsa Ingress nello spazio dei nodi di sviluppo che specifica l'host come `dev.domain.net`.</li>
<li>Un servizio Kubernetes nello spazio dei nomi di preparazione per esporre `app3`.</li>
<li>Una risorsa Ingress nello spazio dei nomi di preparazione che specifica l'host come `stage.domain.net`.</li></ul></br>
<img src="images/cs_ingress_multi_ns.png" alt="All'interno di uno spazio dei nomi, utilizza i domini secondari in una o più risorse" style="border-style: none"/>
Ora, entrambi gli URL risolvono lo stesso dominio e sono anche serviti dallo stesso ALB. Tuttavia, poiché la risorsa nello spazio dei nomi di preparazione viene registrata nel dominio secondario `stage`, l'ALB Ingress instrada correttamente le richieste dall'URL `stage.domain.net/app3` solo a `app3`.</dd>
</dl>

{: #wildcard_tls}
**Nota**:
* Il dominio secondario jolly Ingress fornito da IBM, `*.<cluster_name>.<region>.containers.appdomain.cloud`, viene registrato per impostazione predefinita per il tuo cluster. Per i cluster creati dopo il 6 giugno 2018, il certificato TLS del dominio secondario jolly Ingress fornito da IBM è un certificato jolly e può essere usato per il dominio secondario jolly registrato. Per i cluster creati prima del 6 giugno 2018, il certificato TLS verrà aggiornato a un certificato jolly quando verrà rinnovato il certificato TLS corrente.
* Se vuoi utilizzare un dominio personalizzato, devi registrarlo come un dominio jolly come ad esempio `*.custom_domain.net`. Per utilizzare TLS, devi ottenere un certificato jolly.

### Più domini all'interno di uno spazio dei nomi.

All'interno di uno spazio dei nomi individuale, puoi utilizzare un dominio per accedere a tutte le applicazioni nello spazio dei nomi. Se vuoi utilizzare domini differenti per le applicazioni all'interno di uno spazio dei nomi individuale, utilizza un dominio jolly. Quando viene registrato un dominio jolly come `*.mycluster.us-south.containers.appdomain.cloud`, tutti i domini multipli vengono risolti dallo stesso host. Quindi, puoi utilizzare una risorsa per specificare più host del dominio secondario in tale risorsa. In alternativa, puoi creare più risorse Ingress nello spazio dei nomi e specificare un dominio secondario diverso in ogni risorsa Ingress.

<img src="images/cs_ingress_single_ns_multi_subs.png" alt="È necessaria almeno una risorsa per spazio dei nomi." style="border-style: none"/>

**Nota**:
* Il dominio secondario jolly Ingress fornito da IBM, `*.<cluster_name>.<region>.containers.appdomain.cloud`, viene registrato per impostazione predefinita per il tuo cluster. Per i cluster creati dopo il 6 giugno 2018, il certificato TLS del dominio secondario jolly Ingress fornito da IBM è un certificato jolly e può essere usato per il dominio secondario jolly registrato. Per i cluster creati prima del 6 giugno 2018, il certificato TLS verrà aggiornato a un certificato jolly quando verrà rinnovato il certificato TLS corrente.
* Se vuoi utilizzare un dominio personalizzato, devi registrarlo come un dominio jolly come ad esempio `*.custom_domain.net`. Per utilizzare TLS, devi ottenere un certificato jolly.

<br />


## Esposizione delle applicazioni all'interno del tuo cluster al pubblico
{: #ingress_expose_public}

Esponi le applicazioni all'interno del tuo cluster al pubblico utilizzando l'ALB Ingress pubblico.
{:shortdesc}

Prima di iniziare:

* Esamina i [prerequisiti](#config_prereqs) Ingress.
* [Indirizza la tua CLI](cs_cli_install.html#cs_cli_configure) al tuo cluster per eseguire i comandi `kubectl`.

### Passo 1: Distribuisci le applicazioni e crea i servizi dell'applicazione.
{: #public_inside_1}

Inizia distribuendo le tue applicazioni e creando i servizi Kubernetes per esporle.
{: shortdesc}

1.  [Distribuisci la tua applicazione al cluster](cs_app.html#app_cli). Assicurati di aggiungere un'etichetta alla tua distribuzione nella sezione dei metadati del tuo file di configurazione, ad esempio `app: code`. Questa etichetta è necessaria per identificare tutti i pod in cui è in esecuzione la tua applicazione in modo che possano essere inclusi nel bilanciamento del carico Ingress.

2.   Crea un servizio Kubernetes per ogni applicazione che desideri esporre. La tua applicazione deve essere esposta da un servizio Kubernetes per poter essere inclusa dall'ALB cluster nel bilanciamento del carico Ingress.
      1.  Apri il tuo editor preferito e crea un file di configurazione del servizio denominato, ad esempio, `myappservice.yaml`.
      2.  Definisci un servizio per l'applicazione che l'ALB esporrà.

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
          <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file del servizio ALB</th>
          </thead>
          <tbody>
          <tr>
          <td><code>selector</code></td>
          <td>Immetti la coppia di chiave (<em>&lt;selector_key&gt;</em>) e valore (<em>&lt;selector_value&gt;</em>) dell'etichetta che vuoi utilizzare per indirizzare i pod in cui viene eseguita la tua applicazione. Per indirizzare i tuoi pod e includerli nel bilanciamento del carico di servizio, assicurati che i valori di <em>&lt;selector_key&gt;</em> e <em>&lt;selector_value&gt;</em> siano gli stessi della coppia chiave/valore nella sezione <code>spec.template.metadata.labels</code> del tuo yaml di distribuzione.</td>
           </tr>
           <tr>
           <td><code> port</code></td>
           <td>La porta su cui è in ascolto il servizio.</td>
           </tr>
           </tbody></table>
      3.  Salva le modifiche.
      4.  Crea il servizio nel tuo cluster. Se le applicazioni vengono distribuite in più spazi dei nomi nel tuo cluster, assicurati che il servizio venga distribuito nello stesso spazio dei nomi dell'applicazione che vuoi esporre.

          ```
          kubectl apply -f myappservice.yaml [-n <namespace>]
          ```
          {: pre}
      5.  Ripeti questi passi per ogni applicazione che vuoi esporre.


### Passo 2: Seleziona un dominio dell'applicazione e la terminazione TLS.
{: #public_inside_2}

Quando configuri l'ALB pubblico, scegli il dominio tramite il quale saranno accessibili le tue applicazioni e se utilizzare la terminazione TLS.
{: shortdesc}

<dl>
<dt>Dominio</dt>
<dd>Puoi utilizzare il dominio fornito da IBM, come <code>mycluster-12345.us-south.containers.appdomain.cloud/myapp</code>, per accedere alla tua applicazione da internet. Per utilizzare invece un dominio personalizzato, puoi impostare un record CNAME per associarlo al dominio fornito da IBM o impostare un record con il tuo provider DNS utilizzando l'indirizzo IP pubblico dell'ALB.</dd>
<dt>Terminazione TLS</dt>
<dd>Il carico ALB bilancia il traffico di rete HTTP alle applicazioni nel tuo cluster. Per bilanciare anche il traffico delle connessioni HTTPS in entrata, puoi configurare l'ALB per decodificare il traffico di rete e inoltrare la richiesta decodificata alle applicazioni esposte nel tuo cluster. <ul><li>Se usi il dominio secondario Ingress fornito da IBM, puoi usare il certificato TLS fornito da IBM. I certificati TLS forniti da IBM vengono firmati da LetsEncrypt e vengono gestiti completamente da IBM. I certificati scadono ogni 90 giorni e vengono rinnovati automaticamente 7 giorni prima della scadenza.</li><li>Se usi un dominio personalizzato, puoi usare il tuo certificato TLS per gestire la terminazione TLS. Se hai applicazioni in un unico spazio dei nomi, puoi importare o creare un segreto TLS per il certificato in questo stesso spazio dei nomi. Se hai applicazioni in più spazi dei nomi, importa o crea un segreto TLS per il certificato nello spazio dei nomi <code>default</code> in modo tale che l'ALB possa accedere e usare il certificato in ogni spazio dei nomi.</li></ul></dd>
</dl>

Per utilizzare il dominio Ingress fornito da IBM:
1. Ottieni i dettagli del tuo cluster. Sostituisci _&lt;cluster_name_or_ID&gt;_ con il nome del cluster in cui sono distribuite le applicazioni che vuoi esporre.

    ```
    ibmcloud ks cluster-get <cluster_name_or_ID>
    ```
    {: pre}

    Output di esempio:

    ```
    Name:                   mycluster
    ID:                     18a61a63c6a94b658596ca93d087aad9
    State:                  normal
    Created:                2018-01-12T18:33:35+0000
    Zone:                   dal10
    Master URL:             https://169.xx.xxx.xxx:26268
    Ingress Subdomain:      mycluster-12345.us-south.containers.appdomain.cloud
    Ingress Secret:         <tls_secret>
    Workers:                3
    Version:                1.10.5
    Owner Email:            owner@email.com
    Monitoring Dashboard:   <dashboard_URL>
    ```
    {: screen}
2. Ottieni il dominio fornito da IBM nel campo **Dominio secondario Ingress**. Se vuoi utilizzare TLS, ottieni anche il segreto TLS fornito da IBM nel campo **Segreto Ingress**.
    **Nota**: per informazioni sulla certificazione TLS jolly, vedi [questa nota](#wildcard_tls).

Per utilizzare un dominio personalizzato:
1.    Crea un dominio personalizzato. Per registrare il tuo dominio personalizzato, utilizza il provider DNS (Domain Name Service) o il DNS [{{site.data.keyword.Bluemix_notm}}](/docs/infrastructure/dns/getting-started.html#getting-started-with-dns).
      * Se le applicazioni che vuoi che Ingress esponga in spazi dei nomi differenti in un cluster, registra il dominio personalizzato come un dominio jolly, ad esempio `*.custom_domain.net`.

2.  Configura il tuo dominio per instradare il traffico di rete in entrata all'ALB fornito da IBM. Scegli tra queste opzioni:
    -   Definisci un alias per il tuo dominio personalizzato specificando il dominio fornito da IBM come un record di nome canonico (CNAME). Per trovare il dominio Ingress fornito da IBM, esegui `ibmcloud ks cluster-get <cluster_name>` e cerca il campo **Dominio secondario Ingress**.
    -   Associa il tuo dominio personalizzato all'indirizzo IP pubblico portatile dell'ALB fornito da IBM aggiungendo l'indirizzo IP come record. Per trovare l'indirizzo IP pubblico portatile dell'ALB, esegui `ibmcloud ks alb-get <public_alb_ID>`.
3.   Facoltativo: per utilizzare TLS, importa o crea un certificato TLS e un segreto chiave. Se usi un dominio jolly, assicurati di importare o creare un certificato jolly nello spazio dei nomi <code>default</code> in modo che l'ALB possa accedere e usare il certificato in ciascuno spazio dei nomi.
      * Se in {{site.data.keyword.cloudcerts_long_notm}} è memorizzato un certificato TLS che vuoi utilizzare, puoi importare il suo segreto associato nel tuo cluster immettendo il seguente comando:
        ```
        ibmcloud ks alb-cert-deploy --secret-name <secret_name> --cluster <cluster_name_or_ID> --cert-crn <certificate_crn>
        ```
        {: pre}
      * Se non hai un certificato TLS pronto, segui questa procedura:
        1. Crea un certificato e una chiave TLS per il tuo dominio codificati in formato PEM.
        2. Crea un segreto che utilizza il certificato e la chiave TLS. Sostituisci <em>&lt;tls_secret_name&gt;</em> con un nome per il tuo segreto Kubernetes, <em>&lt;tls_key_filepath&gt;</em> con il percorso al tuo file della chiave TLS personalizzato e <em>&lt;tls_cert_filepath&gt;</em> con il percorso al tuo file del certificato TLS personalizzato.
          ```
          kubectl create secret tls <tls_secret_name> --key=<tls_key_filepath> --cert=<tls_cert_filepath>
          ```
          {: pre}


### Passo 3: Crea la risorsa Ingress
{: #public_inside_3}

Le risorse Ingress definiscono le regole di instradamento che l'ALB utilizza per instradare il traffico al tuo servizio dell'applicazione.
{: shortdesc}

**Nota:** se il tuo cluster ha più spazi dei nomi in cui sono esposte le applicazioni, è necessaria almeno una risorsa Ingress per spazio dei nomi. Tuttavia, ogni spazio dei nomi deve utilizzare un host diverso. Devi registrare un dominio jolly e specificare un dominio secondario differente in ogni risorsa. Per ulteriori informazioni, vedi [Pianificazione della rete per spazi dei nomi singoli o multipli](#multiple_namespaces).

1. Apri il tuo editor preferito e crea un file di configurazione Ingress denominato, ad esempio, `myingressresource.yaml`.

2. Definisci una risorsa Ingress nel tuo file di configurazione che utilizza il dominio fornito da IBM o il tuo dominio personalizzato per instradare il traffico di rete in entrata ai servizi che hai creato in precedenza.

    YAML di esempio che non utilizza TLS:
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

    YAML di esempio che utilizza TLS:
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
    <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code>tls/hosts</code></td>
    <td>Per utilizzare TLS, sostituisci <em>&lt;domain&gt;</em> con il dominio secondario Ingress fornito da IBM o con il tuo dominio personalizzato.

    </br></br>
    <strong>Nota:</strong><ul><li>Se le tue applicazioni sono esposte dai servizi in spazi dei nomi differenti in un cluster, aggiungi un dominio secondario jolly all'inizio del dominio, ad esempio `subdomain1.custom_domain.net` o `subdomain1.mycluster.us-south.containers.appdomain.cloud`. Utilizza un dominio secondario univoco per ogni risorsa che crei nel cluster.</li><li>Non utilizzare &ast; per il tuo host o lascia vuota la proprietà host per evitare errori durante la creazione di Ingress.</li></ul></td>
    </tr>
    <tr>
    <td><code>tls/secretName</code></td>
    <td><ul><li>Se usi il dominio Ingress fornito da IBM, sostituisci <em>&lt;tls_secret_name&gt;</em> con il nome del segreto Ingress fornito da IBM.</li><li>Se usi un dominio personalizzato, sostituisci <em>&lt;tls_secret_name&gt;</em> con il segreto che hai creato precedentemente che contiene il tuo certificato TLS personalizzato e la tua chiave. Se hai importato un certificato da {{site.data.keyword.cloudcerts_short}}, puoi eseguire <code>ibmcloud ks alb-cert-get --cluster <cluster_name_or_ID> --cert-crn <certificate_crn></code> per vedere i segreti associati a un certificato TLS.</li><ul><td>
    </tr>
    <tr>
    <td><code>host</code></td>
    <td>Sostituisci <em>&lt;domain&gt;</em> con il dominio secondario Ingress fornito da IBM o con il tuo dominio personalizzato.

    </br></br>
    <strong>Nota:</strong><ul><li>Se le tue applicazioni sono esposte dai servizi in spazi dei nomi differenti in un cluster, aggiungi un dominio secondario jolly all'inizio del dominio, ad esempio `subdomain1.custom_domain.net` o `subdomain1.mycluster.us-south.containers.appdomain.cloud`. Utilizza un dominio secondario univoco per ogni risorsa che crei nel cluster.</li><li>Non utilizzare &ast; per il tuo host o lascia vuota la proprietà host per evitare errori durante la creazione di Ingress.</li></ul></td>
    </tr>
    <tr>
    <td><code>path</code></td>
    <td>Sostituisci <em>&lt;app_path&gt;</em> con una barra o il percorso su cui è in ascolto la tua applicazione. Il percorso viene aggiunto al dominio personalizzato o fornito da IBM per creare una rotta univoca alla tua applicazione. Quando immetti questa rotta in un browser web, il traffico di rete viene instradato all'ALB. L'ALB cerca il servizio associato e invia il traffico di rete al servizio. Il servizio inoltra quindi il traffico ai pod su cui è in esecuzione l'applicazione.
    </br></br>
    Molte applicazioni non sono in ascolto su uno specifico percorso, ma utilizzano il percorso root e una porta specificata. In questo caso, definisci il percorso root come <code>/</code> e non specificare un percorso individuale per la tua applicazione. Esempi: <ul><li>Per <code>http://domain/</code>, immetti <code>/</code> come percorso.</li><li>Per <code>http://domain/app1_path</code>, immetti <code>/app1_path</code> come percorso.</li></ul>
    </br>
    <strong>Suggerimento:</strong> per configurare Ingress affinché sia in ascolto su un percorso diverso da quello su cui è in ascolto la tua applicazione, puoi utilizzare l'[annotazione di riscrittura](cs_annotations.html#rewrite-path).</td>
    </tr>
    <tr>
    <td><code>serviceName</code></td>
    <td>Sostituisci <em>&lt;app1_service&gt;</em> e <em>&lt;app2_service&gt;</em> e così via, con il nome dei servizi che hai creato per esporre le tue applicazioni. Se le tue applicazioni sono esposte dai servizi in spazi dei nomi differenti nel cluster, includi solo i servizi dell'applicazione presenti nello stesso spazio dei nomi. Devi creare una risorsa Ingress per ogni spazio dei nomi in cui hai delle applicazioni da esporre.</td>
    </tr>
    <tr>
    <td><code>servicePort</code></td>
    <td>La porta su cui è in ascolto il tuo servizio. Utilizza la stessa porta che hai definito quando hai creato il servizio Kubernetes per la tua applicazione.</td>
    </tr>
    </tbody></table>

3.  Crea la risorsa Ingress per il tuo cluster. Assicurati che la risorsa venga distribuita nello stesso spazio dei nomi dei servizi dell'applicazione che hai specificato nella risorsa.

    ```
    kubectl apply -f myingressresource.yaml -n <namespace>
    ```
    {: pre}
4.   Verifica che la risorsa Ingress sia stata creata correttamente.

      ```
      kubectl describe ingress myingressresource
      ```
      {: pre}

      1. Se i messaggi negli eventi descrivono un errore nella configurazione della tua risorsa, modifica i valori nel file di risorsa e riapplica il file per la risorsa.


La tua risorsa Ingress viene creata nello stesso spazio dei nomi dei tuoi servizi dell'applicazione. Le tue applicazioni in questo spazio dei nomi vengono registrate con l'ALB Ingress del cluster.

### Passo 4: Accedi alla tua applicazione da internet
{: #public_inside_4}

In un browser web, immetti l'URL del servizio dell'applicazione a cui accedere.

```
https://<domain>/<app1_path>
```
{: pre}

Se hai esposto più applicazioni, accedi a queste applicazioni modificando il percorso accodato all'URL.

```
https://<domain>/<app2_path>
```
{: pre}

Se utilizzi un dominio jolly per esporre le applicazioni in spazi dei nomi differenti, accedi a queste applicazioni con i rispettivi domini secondari.

```
http://<subdomain1>.<domain>/<app1_path>
```
{: pre}

```
http://<subdomain2>.<domain>/<app1_path>
```
{: pre}


<br />


## Esposizione delle applicazioni all'esterno del tuo cluster al pubblico
{: #external_endpoint}

Esponi le applicazioni all'esterno del tuo cluster al pubblico includendole nel programma di bilanciamento del carico ALB Ingress pubblico. Le richieste pubbliche in entrata sul dominio fornito da IBM o sul tuo dominio personalizzato vengono inoltrate automaticamente all'applicazione esterna.
{:shortdesc}

Prima di iniziare:

-   Esamina i [prerequisiti](#config_prereqs) Ingress.
-   Assicurati che l'applicazione esterna che desideri includere nel bilanciamento del carico del cluster sia accessibile mediante un indirizzo IP pubblico.
-   [Indirizza la tua CLI](cs_cli_install.html#cs_cli_configure) al tuo cluster per eseguire i comandi `kubectl`.

### Passo 1: Crea un servizio dell'applicazione e un endpoint esterno
{: #public_outside_1}

Inizia creando un servizio Kubernetes per esporre l'applicazione esterna e configurando un endpoint esterno Kubernetes per l'applicazione.
{: shortdesc}

1.  Crea un servizio Kubernetes per il tuo cluster che inoltrerà le richieste in entrata a un endpoint esterno che avrai già creato.
    1.  Apri il tuo editor preferito e crea un file di configurazione del servizio denominato, ad esempio, `myexternalservice.yaml`.
    2.  Definisci un servizio per l'applicazione che l'ALB esporrà.

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
        <caption>Descrizione dei componenti del file del servizio ALB</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>metadata/name</code></td>
        <td>Sostituisci <em>&lt;myexternalservice&gt;</em> con un nome per il tuo servizio.<p>Ulteriori informazioni sulla [protezione delle tue informazioni personali](cs_secure.html#pi) quando utilizzi le risorse Kubernetes.</p></td>
        </tr>
        <tr>
        <td><code> port</code></td>
        <td>La porta su cui è in ascolto il servizio.</td>
        </tr></tbody></table>

    3.  Salva le modifiche.
    4.  Crea il servizio Kubernetes per il tuo cluster.

        ```
        kubectl apply -f myexternalservice.yaml
        ```
        {: pre}
2.  Configura un endpoint Kubernetes che definisce la posizione esterna dell'applicazione che desideri includere nel bilanciamento del carico del cluster.
    1.  Apri il tuo editor preferito e crea un file di configurazione endpoint denominato, ad esempio, `myexternalendpoint.yaml`.
    2.  Definisci il tuo endpoint esterno. Includi tutti gli indirizzi IP pubblici e le porte che puoi utilizzare per accedere alla tua applicazione esterna.

        ```
        kind: Endpoints
        apiVersion: v1
        metadata:
          name: myexternalendpoint
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
        <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Sostituisci <em>&lt;myexternalendpoint&gt;</em> con il nome del servizio Kubernetes che hai creato in precedenza.</td>
        </tr>
        <tr>
        <td><code>ip</code></td>
        <td>Sostituisci <em>&lt;external_IP&gt;</em> con gli indirizzi IP pubblici per la connessione alla tua applicazione esterna.</td>
         </tr>
         <td><code> port</code></td>
         <td>Sostituisci <em>&lt;external_port&gt;</em> con la porta su cui è in ascolto la tua applicazione esterna.</td>
         </tbody></table>

    3.  Salva le modifiche.
    4.  Crea l'endpoint Kubernetes per il tuo cluster.

        ```
        kubectl apply -f myexternalendpoint.yaml
        ```
        {: pre}

### Passo 2: Seleziona un dominio dell'applicazione e la terminazione TLS.
{: #public_outside_2}

Quando configuri l'ALB pubblico, scegli il dominio tramite il quale saranno accessibili le tue applicazioni e se utilizzare la terminazione TLS.
{: shortdesc}

<dl>
<dt>Dominio</dt>
<dd>Puoi utilizzare il dominio fornito da IBM, come <code>mycluster-12345.us-south.containers.appdomain.cloud/myapp</code>, per accedere alla tua applicazione da internet. Per utilizzare invece un dominio personalizzato, puoi impostare un record CNAME per associarlo al dominio fornito da IBM o impostare un record con il tuo provider DNS utilizzando l'indirizzo IP pubblico dell'ALB.</dd>
<dt>Terminazione TLS</dt>
<dd>Il carico ALB bilancia il traffico di rete HTTP alle applicazioni nel tuo cluster. Per bilanciare anche il traffico delle connessioni HTTPS in entrata, puoi configurare l'ALB per decodificare il traffico di rete e inoltrare la richiesta decodificata alle applicazioni esposte nel tuo cluster. <ul><li>Se usi il dominio secondario Ingress fornito da IBM, puoi usare il certificato TLS fornito da IBM. I certificati TLS forniti da IBM vengono firmati da LetsEncrypt e vengono gestiti completamente da IBM. I certificati scadono ogni 90 giorni e vengono rinnovati automaticamente 7 giorni prima della scadenza.</li><li>Se usi un dominio personalizzato, puoi usare il tuo certificato TLS per gestire la terminazione TLS. Se hai applicazioni in un unico spazio dei nomi, puoi importare o creare un segreto TLS per il certificato in questo stesso spazio dei nomi. Se hai applicazioni in più spazi dei nomi, importa o crea un segreto TLS per il certificato nello spazio dei nomi <code>default</code> in modo tale che l'ALB possa accedere e usare il certificato in ogni spazio dei nomi.</li></ul></dd>
</dl>

Per utilizzare il dominio Ingress fornito da IBM:
1. Ottieni i dettagli del tuo cluster. Sostituisci _&lt;cluster_name_or_ID&gt;_ con il nome del cluster in cui sono distribuite le applicazioni che vuoi esporre.

    ```
    ibmcloud ks cluster-get <cluster_name_or_ID>
    ```
    {: pre}

    Output di esempio:

    ```
    Name:                   mycluster
    ID:                     18a61a63c6a94b658596ca93d087aad9
    State:                  normal
    Created:                2018-01-12T18:33:35+0000
    Zone:                   dal10
    Master URL:             https://169.xx.xxx.xxx:26268
    Ingress Subdomain:      mycluster-12345.us-south.containers.appdomain.cloud
    Ingress Secret:         <tls_secret>
    Workers:                3
    Version:                1.10.5
    Owner Email:            owner@email.com
    Monitoring Dashboard:   <dashboard_URL>
    ```
    {: screen}
2. Ottieni il dominio fornito da IBM nel campo **Dominio secondario Ingress**. Se vuoi utilizzare TLS, ottieni anche il segreto TLS fornito da IBM nel campo **Segreto Ingress**. **Nota**: per informazioni sulla certificazione TLS jolly, vedi [questa nota](#wildcard_tls).

Per utilizzare un dominio personalizzato:
1.    Crea un dominio personalizzato. Per registrare il tuo dominio personalizzato, utilizza il provider DNS (Domain Name Service) o il DNS [{{site.data.keyword.Bluemix_notm}}](/docs/infrastructure/dns/getting-started.html#getting-started-with-dns).
      * Se le applicazioni che vuoi che Ingress esponga in spazi dei nomi differenti in un cluster, registra il dominio personalizzato come un dominio jolly, ad esempio `*.custom_domain.net`.

2.  Configura il tuo dominio per instradare il traffico di rete in entrata all'ALB fornito da IBM. Scegli tra queste opzioni:
    -   Definisci un alias per il tuo dominio personalizzato specificando il dominio fornito da IBM come un record di nome canonico (CNAME). Per trovare il dominio Ingress fornito da IBM, esegui `ibmcloud ks cluster-get <cluster_name>` e cerca il campo **Dominio secondario Ingress**.
    -   Associa il tuo dominio personalizzato all'indirizzo IP pubblico portatile dell'ALB fornito da IBM aggiungendo l'indirizzo IP come record. Per trovare l'indirizzo IP pubblico portatile dell'ALB, esegui `ibmcloud ks alb-get <public_alb_ID>`.
3.   Facoltativo: per utilizzare TLS, importa o crea un certificato TLS e un segreto chiave. Se usi un dominio jolly, assicurati di importare o creare un certificato jolly nello spazio dei nomi <code>default</code> in modo che l'ALB possa accedere e usare il certificato in ciascuno spazio dei nomi.
      * Se in {{site.data.keyword.cloudcerts_long_notm}} è memorizzato un certificato TLS che vuoi utilizzare, puoi importare il suo segreto associato nel tuo cluster immettendo il seguente comando:
        ```
        ibmcloud ks alb-cert-deploy --secret-name <secret_name> --cluster <cluster_name_or_ID> --cert-crn <certificate_crn>
        ```
        {: pre}
      * Se non hai un certificato TLS pronto, segui questa procedura:
        1. Crea un certificato e una chiave TLS per il tuo dominio codificati in formato PEM.
        2. Crea un segreto che utilizza il certificato e la chiave TLS. Sostituisci <em>&lt;tls_secret_name&gt;</em> con un nome per il tuo segreto Kubernetes, <em>&lt;tls_key_filepath&gt;</em> con il percorso al tuo file della chiave TLS personalizzato e <em>&lt;tls_cert_filepath&gt;</em> con il percorso al tuo file del certificato TLS personalizzato.
          ```
          kubectl create secret tls <tls_secret_name> --key=<tls_key_filepath> --cert=<tls_cert_filepath>
          ```
          {: pre}


### Passo 3: Crea la risorsa Ingress
{: #public_outside_3}

Le risorse Ingress definiscono le regole di instradamento che l'ALB utilizza per instradare il traffico al tuo servizio dell'applicazione.
{: shortdesc}

**Nota:** se stai esponendo più applicazioni esterne e i servizi che hai creato per le applicazioni nel [Passo 1](#public_outside_1) sono in spazi dei nomi differenti, è necessaria almeno una risorsa Ingress per spazio dei nomi. Tuttavia, ogni spazio dei nomi deve utilizzare un host diverso. Devi registrare un dominio jolly e specificare un dominio secondario differente in ogni risorsa. Per ulteriori informazioni, vedi [Pianificazione della rete per spazi dei nomi singoli o multipli](#multiple_namespaces).

1. Apri il tuo editor preferito e crea un file di configurazione Ingress denominato, ad esempio, `myexternalingress.yaml`.

2. Definisci una risorsa Ingress nel tuo file di configurazione che utilizza il dominio fornito da IBM o il tuo dominio personalizzato per instradare il traffico di rete in entrata ai servizi che hai creato in precedenza.

    YAML di esempio che non utilizza TLS:
    ```
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: myexternalingress
    spec:
      rules:
      - host: <domain>
        http:
          paths:
          - path: /<external_app1_path>
            backend:
              serviceName: <app1_service>
              servicePort: 80
          - path: /<external_app2_path>
            backend:
              serviceName: <app2_service>
              servicePort: 80
    ```
    {: codeblock}

    YAML di esempio che utilizza TLS:
    ```
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: myexternalingress
    spec:
      tls:
      - hosts:
        - <domain>
        secretName: <tls_secret_name>
      rules:
      - host: <domain>
        http:
          paths:
          - path: /<external_app1_path>
            backend:
              serviceName: <app1_service>
              servicePort: 80
          - path: /<external_app2_path>
            backend:
              serviceName: <app2_service>
              servicePort: 80
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code>tls/hosts</code></td>
    <td>Per utilizzare TLS, sostituisci <em>&lt;domain&gt;</em> con il dominio secondario Ingress fornito da IBM o con il tuo dominio personalizzato.

    </br></br>
    <strong>Nota:</strong><ul><li>Se i tuoi servizi dell'applicazione sono in spazi dei nomi differenti nel cluster, aggiungi un dominio secondario jolly all'inizio del dominio, ad esempio `subdomain1.custom_domain.net` o `subdomain1.mycluster.us-south.containers.appdomain.cloud`. Utilizza un dominio secondario univoco per ogni risorsa che crei nel cluster.</li><li>Non utilizzare &ast; per il tuo host o lascia vuota la proprietà host per evitare errori durante la creazione di Ingress.</li></ul></td>
    </tr>
    <tr>
    <td><code>tls/secretName</code></td>
    <td><ul><li>Se usi il dominio Ingress fornito da IBM, sostituisci <em>&lt;tls_secret_name&gt;</em> con il nome del segreto Ingress fornito da IBM.</li><li>Se usi un dominio personalizzato, sostituisci <em>&lt;tls_secret_name&gt;</em> con il segreto che hai creato precedentemente che contiene il tuo certificato TLS personalizzato e la tua chiave. Se hai importato un certificato da {{site.data.keyword.cloudcerts_short}}, puoi eseguire <code>ibmcloud ks alb-cert-get --cluster <cluster_name_or_ID> --cert-crn <certificate_crn></code> per vedere i segreti associati a un certificato TLS.</li><ul><td>
    </tr>
    <tr>
    <td><code>rules/host</code></td>
    <td>Sostituisci <em>&lt;domain&gt;</em> con il dominio secondario Ingress fornito da IBM o con il tuo dominio personalizzato.

    </br></br>
    <strong>Nota:</strong><ul><li>Se le tue applicazioni sono esposte dai servizi in spazi dei nomi differenti in un cluster, aggiungi un dominio secondario jolly all'inizio del dominio, ad esempio `subdomain1.custom_domain.net` o `subdomain1.mycluster.us-south.containers.appdomain.cloud`. Utilizza un dominio secondario univoco per ogni risorsa che crei nel cluster.</li><li>Non utilizzare &ast; per il tuo host o lascia vuota la proprietà host per evitare errori durante la creazione di Ingress.</li></ul></td>
    </tr>
    <tr>
    <td><code>path</code></td>
    <td>Sostituisci <em>&lt;external_app_path&gt;</em> con una barra o il percorso su cui è in ascolto la tua applicazione. Il percorso viene aggiunto al dominio personalizzato o fornito da IBM per creare una rotta univoca alla tua applicazione. Quando immetti questa rotta in un browser web, il traffico di rete viene instradato all'ALB. L'ALB cerca il servizio associato e invia il traffico di rete al servizio. Il servizio inoltra quindi il traffico all'applicazione esterna. Per poter ricevere il traffico di rete in entrata, l'applicazione deve essere configurata per l'ascolto su questo percorso.
    </br></br>
    Molte applicazioni non sono in ascolto su uno specifico percorso, ma utilizzano il percorso root e una porta specificata. In questo caso, definisci il percorso root come <code>/</code> e non specificare un percorso individuale per la tua applicazione. Esempi: <ul><li>Per <code>http://domain/</code>, immetti <code>/</code> come percorso.</li><li>Per <code>http://domain/app1_path</code>, immetti <code>/app1_path</code> come percorso.</li></ul>
    </br></br>
    <strong>Suggerimento:</strong> per configurare Ingress affinché sia in ascolto su un percorso diverso da quello su cui è in ascolto la tua applicazione, puoi utilizzare l'[annotazione di riscrittura](cs_annotations.html#rewrite-path).</td>
    </tr>
    <tr>
    <td><code>serviceName</code></td>
    <td>Sostituisci <em>&lt;app1_service&gt;</em> e <em>&lt;app2_service&gt;</em>, ecc. con il nome dei servizi che hai creato per esporre le tue applicazioni esterne. Se le tue applicazioni sono esposte dai servizi in spazi dei nomi differenti nel cluster, includi solo i servizi dell'applicazione presenti nello stesso spazio dei nomi. Devi creare una risorsa Ingress per ogni spazio dei nomi in cui hai delle applicazioni da esporre.</td>
    </tr>
    <tr>
    <td><code>servicePort</code></td>
    <td>La porta su cui è in ascolto il tuo servizio. Utilizza la stessa porta che hai definito quando hai creato il servizio Kubernetes per la tua applicazione.</td>
    </tr>
    </tbody></table>

3.  Crea la risorsa Ingress per il tuo cluster. Assicurati che la risorsa venga distribuita nello stesso spazio dei nomi dei servizi dell'applicazione che hai specificato nella risorsa.

    ```
    kubectl apply -f myexternalingress.yaml -n <namespace>
    ```
    {: pre}
4.   Verifica che la risorsa Ingress sia stata creata correttamente.

      ```
      kubectl describe ingress myingressresource
      ```
      {: pre}

      1. Se i messaggi negli eventi descrivono un errore nella configurazione della tua risorsa, modifica i valori nel file di risorsa e riapplica il file per la risorsa.


La tua risorsa Ingress viene creata nello stesso spazio dei nomi dei tuoi servizi dell'applicazione. Le tue applicazioni in questo spazio dei nomi vengono registrate con l'ALB Ingress del cluster.

### Passo 4: Accedi alla tua applicazione da internet
{: #public_outside_4}

In un browser web, immetti l'URL del servizio dell'applicazione a cui accedere.

```
https://<domain>/<app1_path>
```
{: pre}

Se hai esposto più applicazioni, accedi a queste applicazioni modificando il percorso accodato all'URL.

```
https://<domain>/<app2_path>
```
{: pre}

Se utilizzi un dominio jolly per esporre le applicazioni in spazi dei nomi differenti, accedi a queste applicazioni con i rispettivi domini secondari.

```
http://<subdomain1>.<domain>/<app1_path>
```
{: pre}

```
http://<subdomain2>.<domain>/<app1_path>
```
{: pre}


<br />


## Abilitazione di un ALB privato predefinito
{: #private_ingress}

Quando crei un cluster standard, in ogni zona in cui hai nodi di lavoro, viene creato un ALB fornito da IBM e viene assegnato un indirizzo IP privato portatile e una rotta privata. Tuttavia, l'ALB privato predefinito in ciascuna zona non viene abilitato automaticamente. Per usare l'ALB privato predefinito per bilanciare il carico del traffico di rete privato alle tue applicazioni, devi innanzitutto abilitarlo con l'indirizzo IP privato portatile fornito da IBM o con il tuo indirizzo IP privato portatile.
{:shortdesc}

**Nota**: se quando hai creato il cluster hai utilizzato l'indicatore `--no-subnet`, devi aggiungere una sottorete privata portatile o una sottorete gestita dall'utente prima di poter abilitare l'ALB privato. Per ulteriori informazioni, vedi [Richiesta di più sottoreti per il tuo cluster](cs_subnets.html#request).

Prima di iniziare:

-   Esamina le opzioni per la pianificazione dell'accesso privato alle applicazioni quando i nodi di lavoro vengono connessi a [una VLAN pubblica e a una privata](cs_network_planning.html#private_both_vlans) oppure [solo a una VLAN privata](cs_network_planning.html#private_vlan).
-   [Indirizza la tua CLI](cs_cli_install.html#cs_cli_configure) al tuo cluster.

Per abilitare un ALB privato predefinito utilizzando l'indirizzo IP privato portatile fornito da IBM preassegnato:

1. Ottieni l'ID dell'ALB privato predefinito che vuoi abilitare. Sostituisci <em>&lt;cluster_name&gt;</em> con il nome del cluster in cui viene distribuita l'applicazione che vuoi esporre.

    ```
    ibmcloud ks albs --cluster <cluster_name>
    ```
    {: pre}

    Il campo **Status** per gli ALB privati è _disabled_.
    ```
    ALB ID                                            Enabled   Status     Type      ALB IP          Zone
    private-cr6d779503319d419aa3b4ab171d12c3b8-alb1   false     disabled   private   -               dal10
    private-crb2f60e9735254ac8b20b9c1e38b649a5-alb2   false     disabled   private   -               dal12
    public-cr6d779503319d419aa3b4ab171d12c3b8-alb1    true      enabled    public    169.xx.xxx.xxx  dal10
    public-crb2f60e9735254ac8b20b9c1e38b649a5-alb2    true      enabled    public    169.xx.xxx.xxx  dal12
    ```
    {: screen}
    Nei cluster multizona, il suffisso numerato sull'ID ALB indica l'ordine in cui è stato aggiunto l'ALB.
    * Ad esempio, il suffisso `-alb1` sull'ALB `private-cr6d779503319d419aa3b4ab171d12c3b8-alb1` indica che è stato il primo ALB privato predefinito che è stato creato. È presente nella zona in cui hai creato il cluster. Nell'esempio sopra riportato, il cluster è stato creato in `dal10`.
    * Il suffisso `-alb2` nell'ALB `private-crb2f60e9735254ac8b20b9c1e38b649a5-alb2` indica che è stato il secondo ALB privato predefinito che è stato creato. È presente nella seconda zona che hai aggiunto al tuo cluster. Nell'esempio sopra riportato, la seconda zona è `dal12`.

2. Abilita l'ALB privato. Sostituisci <em>&lt;private_ALB_ID&gt;</em> con l'ID dell'ALB privato indicato nell'output nel passo precedente.

   ```
   ibmcloud ks alb-configure --albID <private_ALB_ID> --enable
   ```
   {: pre}

<br>
Per abilitare l'ALB privato utilizzando il tuo proprio indirizzo IP privato portatile:

1. Configura la sottorete gestita dall'utente dell'indirizzo IP che hai scelto per instradare il traffico sulla VLAN privata del tuo cluster.

   ```
   ibmcloud ks cluster-user-subnet-add <cluster_name> <subnet_CIDR> <private_VLAN_ID>
   ```
   {: pre}

   <table>
   <thead>
   <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del comando</th>
   </thead>
   <tbody>
   <tr>
   <td><code>&lt;cluster_name&gt;</code></td>
   <td>Il nome o l'ID del cluster in cui l'applicazione che vuoi esporre viene distribuita.</td>
   </tr>
   <tr>
   <td><code>&lt;subnet_CIDR&gt;</code></td>
   <td>Il CIDR della tua sottorete gestita dall'utente.</td>
   </tr>
   <tr>
   <td><code>&lt;private_VLAN_ID&gt;</code></td>
   <td>Un ID della VLAN privata disponibile. Puoi trovare l'ID di una VLAN privata disponibile eseguendo `ibmcloud ks vlans`.</td>
   </tr>
   </tbody></table>

2. Elenca gli ALB disponibili nel tuo cluster per ottenere l'ID dell'ALB privato.

    ```
    ibmcloud ks albs --cluster <cluster_name>
    ```
    {: pre}

    Il campo **Status** per l'ALB privato è _disabled_.
    ```
    ALB ID                                            Enabled   Status     Type      ALB IP          Zone
    private-cr6d779503319d419ea3b4ab171d12c3b8-alb1   false     disabled   private   -               dal10
    public-cr6d779503319d419ea3b4ab171d12c3b8-alb1    true      enabled    public    169.xx.xxx.xxx  dal10
    ```
    {: screen}

3. Abilita l'ALB privato. Sostituisci <em>&lt;private_ALB_ID&gt;</em> con l'ID dell'ALB privato indicato nell'output nel passo precedente e <em>&lt;user_IP&gt;</em> con l'indirizzo IP dalla sottorete gestita dall'utente che vuoi utilizzare.

   ```
   ibmcloud ks alb-configure --albID <private_ALB_ID> --enable --user-ip <user_IP>
   ```
   {: pre}

<br />


## Esposizione delle applicazioni su una rete privata
{: #ingress_expose_private}

Esponi le applicazioni a una rete privata utilizzando l'ALB Ingress privato.
{:shortdesc}

Prima di iniziare:
* Esamina i [prerequisiti](#config_prereqs) Ingress.
* Esamina le opzioni per la pianificazione dell'accesso privato alle applicazioni quando i nodi di lavoro vengono connessi a [una VLAN pubblica e a una privata](cs_network_planning.html#private_both_vlans) oppure [solo a una VLAN privata](cs_network_planning.html#private_vlan).
    * VLAN pubblica e privata: per usare il provider DNS esterno predefinito, devi [configurare i nodi edge con l'accesso pubblico](cs_edge.html#edge) e [configurare una VRA (Virtual Router Appliance) ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.ibm.com/blogs/bluemix/2017/07/kubernetes-and-bluemix-container-based-workloads-part4/).
    * Solo VLAN privata: devi configurare un [servizio DNS che sia disponibile sulla rete privata ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/).
* [Abilita il programma di bilanciamento del carico dell'applicazione privato](#private_ingress).

### Passo 1: Distribuisci le applicazioni e crea i servizi dell'applicazione.
{: #private_1}

Inizia distribuendo le tue applicazioni e creando i servizi Kubernetes per esporle.
{: shortdesc}

1.  [Distribuisci la tua applicazione al cluster](cs_app.html#app_cli). Assicurati di aggiungere un'etichetta alla tua distribuzione nella sezione dei metadati del tuo file di configurazione, ad esempio `app: code`. Questa etichetta è necessaria per identificare tutti i pod in cui è in esecuzione la tua applicazione in modo che possano essere inclusi nel bilanciamento del carico Ingress.

2.   Crea un servizio Kubernetes per ogni applicazione che desideri esporre. La tua applicazione deve essere esposta da un servizio Kubernetes per poter essere inclusa dall'ALB cluster nel bilanciamento del carico Ingress.
      1.  Apri il tuo editor preferito e crea un file di configurazione del servizio denominato, ad esempio, `myappservice.yaml`.
      2.  Definisci un servizio per l'applicazione che l'ALB esporrà.

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
          <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file del servizio ALB</th>
          </thead>
          <tbody>
          <tr>
          <td><code>selector</code></td>
          <td>Immetti la coppia di chiave (<em>&lt;selector_key&gt;</em>) e valore (<em>&lt;selector_value&gt;</em>) dell'etichetta che vuoi utilizzare per indirizzare i pod in cui viene eseguita la tua applicazione. Per indirizzare i tuoi pod e includerli nel bilanciamento del carico di servizio, assicurati che i valori di <em>&lt;selector_key&gt;</em> e <em>&lt;selector_value&gt;</em> siano gli stessi della coppia chiave/valore nella sezione <code>spec.template.metadata.labels</code> del tuo yaml di distribuzione.</td>
           </tr>
           <tr>
           <td><code> port</code></td>
           <td>La porta su cui è in ascolto il servizio.</td>
           </tr>
           </tbody></table>
      3.  Salva le modifiche.
      4.  Crea il servizio nel tuo cluster. Se le applicazioni vengono distribuite in più spazi dei nomi nel tuo cluster, assicurati che il servizio venga distribuito nello stesso spazio dei nomi dell'applicazione che vuoi esporre.

          ```
          kubectl apply -f myappservice.yaml [-n <namespace>]
          ```
          {: pre}
      5.  Ripeti questi passi per ogni applicazione che vuoi esporre.


### Passo 2: Associa il tuo dominio personalizzato e seleziona la terminazione TLS
{: #private_2}

Quando configuri l'ALB privato, utilizzi il dominio personalizzato tramite il quale saranno accessibili le tue applicazioni e scegli se utilizzare la terminazione TLS.
{: shortdesc}

Il carico ALB bilancia il traffico di rete HTTP alle tue applicazioni. Per bilanciare anche il traffico delle connessioni HTTPS in entrata, puoi configurare l'ALB per utilizzare il tuo certificato TLS per decodificare il traffico di rete. L'ALB poi inoltra la richiesta decodificata alle applicazioni esposte nel tuo cluster.
1.   Crea un dominio personalizzato. Per registrare il tuo dominio personalizzato, utilizza il provider DNS (Domain Name Service) o il DNS [{{site.data.keyword.Bluemix_notm}}](/docs/infrastructure/dns/getting-started.html#getting-started-with-dns).
      * Se le applicazioni che vuoi che Ingress esponga in spazi dei nomi differenti in un cluster, registra il dominio personalizzato come un dominio jolly, ad esempio `*.custom_domain.net`.

2. Associa il tuo dominio personalizzato all'indirizzo IP privato portatile dell'ALB privato fornito da IBM aggiungendo l'indirizzo IP come record. Per trovare l'indirizzo IP privato portatile dell'ALB privato, esegui `ibmcloud ks albs --cluster <cluster_name>`.
3.   Facoltativo: per utilizzare TLS, importa o crea un certificato TLS e un segreto chiave. Se usi un dominio jolly, assicurati di importare o creare un certificato jolly nello spazio dei nomi <code>default</code> in modo che l'ALB possa accedere e usare il certificato in ciascuno spazio dei nomi.
      * Se in {{site.data.keyword.cloudcerts_long_notm}} è memorizzato un certificato TLS che vuoi utilizzare, puoi importare il suo segreto associato nel tuo cluster immettendo il seguente comando:
        ```
        ibmcloud ks alb-cert-deploy --secret-name <secret_name> --cluster <cluster_name_or_ID> --cert-crn <certificate_crn>
        ```
        {: pre}
      * Se non hai un certificato TLS pronto, segui questa procedura:
        1. Crea un certificato e una chiave TLS per il tuo dominio codificati in formato PEM.
        2. Crea un segreto che utilizza il certificato e la chiave TLS. Sostituisci <em>&lt;tls_secret_name&gt;</em> con un nome per il tuo segreto Kubernetes, <em>&lt;tls_key_filepath&gt;</em> con il percorso al tuo file della chiave TLS personalizzato e <em>&lt;tls_cert_filepath&gt;</em> con il percorso al tuo file del certificato TLS personalizzato.
          ```
          kubectl create secret tls <tls_secret_name> --key=<tls_key_filepath> --cert=<tls_cert_filepath>
          ```
          {: pre}


### Passo 3: Crea la risorsa Ingress
{: #pivate_3}

Le risorse Ingress definiscono le regole di instradamento che l'ALB utilizza per instradare il traffico al tuo servizio dell'applicazione.
{: shortdesc}

**Nota:** se il tuo cluster ha più spazi dei nomi in cui sono esposte le applicazioni, è necessaria almeno una risorsa Ingress per spazio dei nomi. Tuttavia, ogni spazio dei nomi deve utilizzare un host diverso. Devi registrare un dominio jolly e specificare un dominio secondario differente in ogni risorsa. Per ulteriori informazioni, vedi [Pianificazione della rete per spazi dei nomi singoli o multipli](#multiple_namespaces).

1. Apri il tuo editor preferito e crea un file di configurazione Ingress denominato, ad esempio, `myingressresource.yaml`.

2.  Definisci una risorsa Ingress nel tuo file di configurazione che utilizza il tuo dominio personalizzato per instradare il traffico di rete in entrata ai servizi che hai creato in precedenza.

    YAML di esempio che non utilizza TLS:
    ```
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: myingressresource
      annotations:
        ingress.bluemix.net/ALB-ID: "<private_ALB_ID>"
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

    YAML di esempio che utilizza TLS:
    ```
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: myingressresource
      annotations:
        ingress.bluemix.net/ALB-ID: "<private_ALB_ID>"
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
    <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code>ingress.bluemix.net/ALB-ID</code></td>
    <td>Sostituisci <em>&lt;private_ALB_ID&gt;</em> con l'ID del tuo ALB privato. Esegui <code>ibmcloud ks albs --cluster <my_cluster></code> per trovare l'ID ALB. Per ulteriori informazioni su questa annotazione Ingress, consulta [Instradamento del programma di bilanciamento del carico dell'applicazione privato](cs_annotations.html#alb-id).</td>
    </tr>
    <tr>
    <td><code>tls/hosts</code></td>
    <td>Per utilizzare TLS, sostituisci <em>&lt;domain&gt;</em> con il tuo dominio personalizzato.

    </br></br>
    <strong>Nota:</strong><ul><li>Se le tue applicazioni sono esposte dai servizi in spazi dei nomi differenti in un cluster, aggiungi un dominio secondario jolly all'inizio del dominio, ad esempio `subdomain1.custom_domain.net`. Utilizza un dominio secondario univoco per ogni risorsa che crei nel cluster.</li><li>Non utilizzare &ast; per il tuo host o lascia vuota la proprietà host per evitare errori durante la creazione di Ingress.</li></ul></td>
    </tr>
    <tr>
    <td><code>tls/secretName</code></td>
    <td>Sostituisci <em>&lt;tls_secret_name&gt;</em> con il nome del segreto che hai creato in precedenza e che contiene la tua chiave e il tuo certificato TLS personalizzati. Se hai importato un certificato da {{site.data.keyword.cloudcerts_short}}, puoi eseguire <code>ibmcloud ks alb-cert-get --cluster <cluster_name_or_ID> --cert-crn <certificate_crn></code> per vedere i segreti associati a un certificato TLS.
    </tr>
    <tr>
    <td><code>host</code></td>
    <td>Sostituisci <em>&lt;domain&gt;</em> con il tuo dominio personalizzato.
    </br></br>
    <strong>Nota:</strong><ul><li>Se le tue applicazioni sono esposte dai servizi in spazi dei nomi differenti in un cluster, aggiungi un dominio secondario jolly all'inizio del dominio, ad esempio `subdomain1.custom_domain.net`. Utilizza un dominio secondario univoco per ogni risorsa che crei nel cluster.</li><li>Non utilizzare &ast; per il tuo host o lascia vuota la proprietà host per evitare errori durante la creazione di Ingress.</li></ul></td>
    </td>
    </tr>
    <tr>
    <td><code>path</code></td>
    <td>Sostituisci <em>&lt;app_path&gt;</em> con una barra o il percorso su cui è in ascolto la tua applicazione. Il percorso viene aggiunto al dominio personalizzato per creare una rotta univoca alla tua applicazione. Quando immetti questa rotta in un browser web, il traffico di rete viene instradato all'ALB. L'ALB cerca il servizio associato e invia il traffico di rete al servizio. Il servizio inoltra quindi il traffico ai pod su cui è in esecuzione l'applicazione.
    </br></br>
    Molte applicazioni non sono in ascolto su uno specifico percorso, ma utilizzano il percorso root e una porta specificata. In questo caso, definisci il percorso root come <code>/</code> e non specificare un percorso individuale per la tua applicazione. Esempi: <ul><li>Per <code>http://domain/</code>, immetti <code>/</code> come percorso.</li><li>Per <code>http://domain/app1_path</code>, immetti <code>/app1_path</code> come percorso.</li></ul>
    </br>
    <strong>Suggerimento:</strong> per configurare Ingress affinché sia in ascolto su un percorso diverso da quello su cui è in ascolto la tua applicazione, puoi utilizzare l'[annotazione di riscrittura](cs_annotations.html#rewrite-path).</td>
    </tr>
    <tr>
    <td><code>serviceName</code></td>
    <td>Sostituisci <em>&lt;app1_service&gt;</em> e <em>&lt;app2_service&gt;</em> e così via, con il nome dei servizi che hai creato per esporre le tue applicazioni. Se le tue applicazioni sono esposte dai servizi in spazi dei nomi differenti nel cluster, includi solo i servizi dell'applicazione presenti nello stesso spazio dei nomi. Devi creare una risorsa Ingress per ogni spazio dei nomi in cui hai delle applicazioni da esporre.</td>
    </tr>
    <tr>
    <td><code>servicePort</code></td>
    <td>La porta su cui è in ascolto il tuo servizio. Utilizza la stessa porta che hai definito quando hai creato il servizio Kubernetes per la tua applicazione.</td>
    </tr>
    </tbody></table>

3.  Crea la risorsa Ingress per il tuo cluster. Assicurati che la risorsa venga distribuita nello stesso spazio dei nomi dei servizi dell'applicazione che hai specificato nella risorsa.

    ```
    kubectl apply -f myingressresource.yaml -n <namespace>
    ```
    {: pre}
4.   Verifica che la risorsa Ingress sia stata creata correttamente.

      ```
      kubectl describe ingress myingressresource
      ```
      {: pre}

      1. Se i messaggi negli eventi descrivono un errore nella configurazione della tua risorsa, modifica i valori nel file di risorsa e riapplica il file per la risorsa.


La tua risorsa Ingress viene creata nello stesso spazio dei nomi dei tuoi servizi dell'applicazione. Le tue applicazioni in questo spazio dei nomi vengono registrate con l'ALB Ingress del cluster.

### Passo 4: Accedi alla tua applicazione dalla tua rete privata
{: #private_4}

1. Prima di poter accedere alla tua applicazione, assicurati di poter accedere a un servizio DNS.
  * VLAN pubblica e privata: per usare il provider DNS esterno predefinito, devi [configurare i nodi edge con l'accesso pubblico](cs_edge.html#edge) e [configurare una VRA (Virtual Router Appliance) ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.ibm.com/blogs/bluemix/2017/07/kubernetes-and-bluemix-container-based-workloads-part4/).
  * Solo VLAN privata: devi configurare un [servizio DNS che sia disponibile sulla rete privata ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/).

2. Dall'interno del tuo firewall della rete privata, immetti l'URL del servizio dell'applicazione in un browser web.

```
https://<domain>/<app1_path>
```
{: pre}

Se hai esposto più applicazioni, accedi a queste applicazioni modificando il percorso accodato all'URL.

```
https://<domain>/<app2_path>
```
{: pre}

Se utilizzi un dominio jolly per esporre le applicazioni in spazi dei nomi differenti, accedi a queste applicazioni con i rispettivi domini secondari.

```
http://<subdomain1>.<domain>/<app1_path>
```
{: pre}

```
http://<subdomain2>.<domain>/<app1_path>
```
{: pre}


Per un'esercitazione completa su come proteggere le comunicazioni tra i microservizi nei tuoi cluster utilizzando l'ALB privato con TLS, consulta [questo post del blog ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://medium.com/ibm-cloud/secure-microservice-to-microservice-communication-across-kubernetes-clusters-using-a-private-ecbe2a8d4fe2).

<br />


## Personalizzazione di una risorsa Ingress con le annotazioni
{: #annotations}

Per aggiungere funzionalità al tuo ALB Ingress, puoi aggiungere le annotazioni specifiche di IBM come metadati in una risorsa Ingress.
{: shortdesc}

Inizia con alcune delle annotazioni usate più comunemente.
* [redirect-to-https](cs_annotations.html#redirect-to-https): converte le richieste client HTTP non sicure in HTTPS.
* [rewrite-path](cs_annotations.html#rewrite-path): instrada il traffico di rete in entrata a un percorso diverso su cui è in ascolto la tua applicazione di backend.
* [ssl-services](cs_annotations.html#ssl-services): usa TLS per crittografare il traffico verso le tue applicazioni upstream che richiedono HTTPS.
* [client-max-body-size](cs_annotations.html#client-max-body-size): imposta la dimensione massima del corpo che il client può inviare come parte di una richiesta. 

Per un elenco completo delle annotazioni supportate, vedi [Personalizzazione di Ingress con le annotazioni](cs_annotations.html).

<br />


## Apertura delle porte nell'ALB Ingress
{: #opening_ingress_ports}

Per impostazione predefinita, solo le porte 80 e 443 sono esposte nell'ALB Ingress. Per esporre altre porte, puoi modificare la risorsa della mappa di configurazione `ibm-cloud-provider-ingress-cm`.
{:shortdesc}

1. Crea e apri una versione locale del file di configurazione per la risorsa della mappa di configurazione `ibm-cloud-provider-ingress-cm`.

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Aggiungi una sezione <code>data</code> e specifica le porte pubbliche `80`, `443` e le altre porte che vuoi esporre separate da un punto e virgola (;).

    **Importante**: per impostazione predefinita, le porte 80 e 443 sono aperte. Se vuoi mantenere le porte 80 e 443 aperte, devi includerle in aggiunta a tutte le altre porte che specifichi nel campo `public-ports`. Qualsiasi porta che non sia specificata viene chiusa. Se hai abilitato un ALB privato, devi inoltre specificare tutte le porte che vuoi mantenere aperte nel campo `private-ports`.

    ```
    apiVersion: v1
    data:
      public-ports: "80;443;<port3>"
      private-ports: "80;443;<port4>"
    kind: ConfigMap
    metadata:
      name: ibm-cloud-provider-ingress-cm
      namespace: kube-system
    ```
    {: codeblock}

    Esempio che mantiene le porte `80`, `443` e `9443` aperte:
    ```
    apiVersion: v1
 data:
   public-ports: "80;443;9443"
 kind: ConfigMap
 metadata:
   name: ibm-cloud-provider-ingress-cm
   namespace: kube-system
    ```
    {: screen}

3. Salva il file di configurazione.

4. Verifica che le modifiche alla mappa di configurazione siano state applicate.

 ```
 kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
 ```
 {: pre}

Per ulteriori informazioni sulle risorse della mappa di configurazione, consulta la [documentazione di Kubernetes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/).

<br />


## Conservazione dell'indirizzo IP di origine
{: #preserve_source_ip}

Per impostazione predefinita, l'indirizzo IP di origine della richiesta client non viene conservato. Quando una richiesta client alla tua applicazione viene inviata al tuo cluster, la richiesta viene instradata a un pod per il servizio di programma di bilanciamento del carico che espone l'ALB. Se sullo stesso nodo di lavoro del pod del servizio del programma di bilanciamento del carico non esiste un pod dell'applicazione, il programma di bilanciamento inoltra la richiesta a un pod dell'applicazione su un nodo di lavoro diverso. L'indirizzo IP di origine del pacchetto viene modificato con l'indirizzo IP pubblico del nodo di lavoro su cui è in esecuzione il pod dell'applicazione.

Per conservare l'indirizzo IP di origine originale della richiesta client, puoi [abilitare la conservazione dell'IP di origine ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/tutorials/services/source-ip/#source-ip-for-services-with-typeloadbalancer). La conservazione dell'IP del client è utile quando, ad esempio, i server delle applicazioni devono applicare le politiche di sicurezza e di controllo dell'accesso.

**Nota**: se [disabiliti un ALB](cs_cli_reference.html#cs_alb_configure), le modifiche dell'IP di origine che apporti al servizio di bilanciamento del carico che espone l'ALB andranno perse. Quando riabiliti l'ALB, devi abilitare di nuovo l'IP di origine.

Per abilitare la conservazione dell'IP di origine, modifica il servizio del programma di bilanciamento del carico che espone un ALB Ingress: 

1. Abilita la conservazione dell'IP di origine per un singolo ALB o per tutti gli ALB nel tuo cluster.
    * Per impostare la conservazione dell'IP di origine per un singolo ALB:
        1. Ottieni l'ID dell'ALB per il quale vuoi abilitare l'IP di origine. I servizi ALB hanno un formato simile a `public-cr18e61e63c6e94b658596ca93d087eed9-alb1` per un ALB pubblico o `private-cr18e61e63c6e94b658596ca93d087eed9-alb1` per un ALB privato.
            ```
            kubectl get svc -n kube-system | grep alb
            ```
            {: pre}

        2. Apri il file YAML per il servizio del programma di bilanciamento del carico che espone l'ALB.
            ```
            kubectl edit svc <ALB_ID> -n kube-system
            ```
            {: pre}

        3. In **spec**, modifica il valore di **externalTrafficPolicy** da `Cluster` a `Local`.

        4. Salva e chiudi il file di configurazione. L'output è simile al seguente: 

            ```
            service "public-cr18e61e63c6e94b658596ca93d087eed9-alb1" edited
            ```
            {: screen}
    * Per impostare la conservazione dell'IP di origine per tutti gli ALB pubblici nel tuo cluster, esegui questo comando:
        ```
        kubectl get svc -n kube-system | grep alb | awk '{print $1}' | grep "^public" | while read alb; do kubectl patch svc $alb -n kube-system -p '{"spec":{"externalTrafficPolicy":"Local"}}'; done
        ```
        {: pre}

        Output di esempio:
        ```
        "public-cr18e61e63c6e94b658596ca93d087eed9-alb1", "public-cr17e61e63c6e94b658596ca92d087eed9-alb2" patched
        ```
        {: screen}

    * Per impostare la conservazione dell'IP di origine per tutti gli ALB privati nel tuo cluster, esegui questo comando:
        ```
        kubectl get svc -n kube-system | grep alb | awk '{print $1}' | grep "^private" | while read alb; do kubectl patch svc $alb -n kube-system -p '{"spec":{"externalTrafficPolicy":"Local"}}'; done
        ```
        {: pre}

        Output di esempio:
        ```
        "private-cr18e61e63c6e94b658596ca93d087eed9-alb1", "private-cr17e61e63c6e94b658596ca92d087eed9-alb2" patched
        ```
        {: screen}

2. Verifica che l'IP di origine venga conservato nei log dei tuoi pod ALB. 
    1. Ottieni l'ID di un pod per l'ALB che hai modificato.
        ```
        kubectl get pods -n kube-system | grep alb
        ```
        {: pre}

    2. Apri i log relativi a tale pod ALB. Verifica che l'indirizzo IP per il campo `client` sia l'indirizzo IP della richiesta client invece dell'indirizzo IP del servizio del programma di bilanciamento del carico.
        ```
        kubectl logs <ALB_pod_ID> nginx-ingress -n kube-system
        ```
        {: pre}

3. Ora, quando nelle intestazioni ricerchi le richieste inviate alla tua applicazione backend, puoi vedere l'indirizzo IP del client nell'intestazione `x-forwarded-for`.

4. Se non vuoi più conservare l'IP di origine, puoi ripristinare le modifiche apportate al servizio. 
    * Per ripristinare la conservazione dell'IP di origine per i tuoi ALB pubblici:
        ```
        kubectl get svc -n kube-system | grep alb | awk '{print $1}' | grep "^public" | while read alb; do kubectl patch svc $alb -n kube-system -p '{"spec":{"externalTrafficPolicy":"Cluster"}}'; done
        ```
        {: pre}
    * Per ripristinare la conservazione dell'IP di origine per i tuoi ALB privati:
        ```
        kubectl get svc -n kube-system | grep alb | awk '{print $1}' | grep "^private" | while read alb; do kubectl patch svc $alb -n kube-system -p '{"spec":{"externalTrafficPolicy":"Cluster"}}'; done
        ```
        {: pre}

<br />


## Configurazione di protocolli SSL e cifrature SSL a livello di HTTP
{: #ssl_protocols_ciphers}

Abilita i protocolli e le cifrature SSL a livello globale HTTP modificando la mappa di configurazione `ibm-cloud-provider-ingress-cm`.
{:shortdesc}

Per impostazione predefinita, il protocollo 1.2 TLS viene utilizzato per tutte le configurazioni Ingress che utilizzano il dominio fornito da IBM. Puoi sovrascrivere il valore predefinito invece di utilizzare i protocolli 1.1 o 1.0 TLS seguendo questa procedura.

**Nota**: quando specifichi i protocolli abilitati per tutti gli host, i parametri TLSv1.1 e TLSv1.2 (1.1.13, 1.0.12) funzionano solo quando viene utilizzato OpenSSL 1.0.1 o superiore. Il parametro TLSv1.3 (1.13.0) funziona solo quando viene utilizzato OpenSSL 1.1.1 sviluppato con il supporto TLSv1.3.

Per modificare la mappa di configurazione per l'abilitazione di protocolli e cifrature SSL:

1. Crea e apri una versione locale del file di configurazione per la risorsa della mappa di configurazione `ibm-cloud-provider-ingress-cm`.

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Aggiungi i protocolli e le cifrature SSL. Formatta le cifrature in base al [formato dell'elenco di cifrature della libreria OpenSSL ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.openssl.org/docs/man1.0.2/apps/ciphers.html).

   ```
   apiVersion: v1
 data:
   ssl-protocols: "TLSv1 TLSv1.1 TLSv1.2"
   ssl-ciphers: "HIGH:!aNULL:!MD5"
 kind: ConfigMap
 metadata:
   name: ibm-cloud-provider-ingress-cm
   namespace: kube-system
   ```
   {: codeblock}

3. Salva il file di configurazione.

4. Verifica che le modifiche alla mappa di configurazione siano state applicate.

   ```
   kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
   ```
   {: pre}

<br />


## Ottimizzazione delle prestazioni
{: #perf_tuning}

Per ottimizzare le prestazioni dei tuoi ALB Ingress, puoi modificare le impostazioni predefinite in base alle tue necessità.
{: shortdesc}



### Aumento del tempo di connessione keepalive
{: #keepalive_time}

Le connessioni keepalive possono avere un impatto maggiore sulle prestazioni riducendo il sovraccarico di CPU e di rete necessari per aprire e chiudere le connessioni. Per ottimizzare le prestazioni dei tuoi ALB, puoi modificare l'impostazione predefinita del tempo keepalive per le connessioni tra l'ALB e il client.
{: shortdesc}

Nella mappa di configurazione Ingress `ibm-cloud-provider-ingress-cm`, il campo `keep-alive` imposta il timeout, in secondi, durante il quale la connessione client keepalive rimane aperta nell'ALB Ingress. Per impostazione predefinita, `keep-alive` è impostato su `8s`. Puoi sovrascrivere il valore predefinito modificando la mappa di configurazione Ingress. 

1. Crea e apri una versione locale del file di configurazione per la risorsa della mappa di configurazione `ibm-cloud-provider-ingress-cm`.

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Modifica il valore di `keep-alive` da `8s` a un valore più grande 

   ```
   apiVersion: v1
   data:
     keep-alive: "8s"
   kind: ConfigMap
   metadata:
     name: ibm-cloud-provider-ingress-cm
     namespace: kube-system
   ```
   {: codeblock}

3. Salva il file di configurazione.

4. Verifica che le modifiche alla mappa di configurazione siano state applicate.

   ```
   kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
   ```
   {: pre}

<br />


## Configurazione di un controller Ingress gestito dall'utente
{: #user_managed}

Esegui il tuo controllo Ingress su {{site.data.keyword.Bluemix_notm}} mentre usi il dominio secondario Ingress fornito da IBM e il certificato TLS assegnato al tuo cluster.
{: shortdesc}

La configurazione del tuo controller Ingress personalizzato può essere utile quando hai requisiti Ingress specifici. Quando esegui il tuo controller Ingress invece dell'ALB Ingress fornito da IBM, sei responsabile della fornitura della sua immagine, della sua gestione e del suo aggiornamento. 

1. Ottieni l'ID dell'ALB pubblico predefinito. L'ALB pubblico ha un formato simile a `public-cr18e61e63c6e94b658596ca93d087eed9-alb1`.
    ```
    kubectl get svc -n kube-system | grep alb
    ```
    {: pre}

2. Disabilita l'ALB pubblico predefinito. L'indicatore `--disable-deployment` disabilita la distribuzione ALB fornita da IBM, ma non rimuove la registrazione DNS per il dominio secondario Ingress fornito da IBM o il servizio del programma di bilanciamento del carico usato per esporre il controller Ingress.
    ```
    ibmcloud ks alb-configure --alb-ID <ALB_ID> --disable-deployment
    ```
    {: pre}

3. Prepara il file di configurazione per il tuo controller Ingress. Ad esempio, puoi usare il file di configurazione YAML per il [controller Ingress della community conginx ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/kubernetes/ingress-nginx/blob/master/deploy/mandatory.yaml).

4. Distribuisci il tuo controller Ingress. **Importante**: per continuare a usare il servizio del programma di bilanciamento del carico che espone il controller e il dominio secondario Ingress fornito da IBM, il tuo controller deve essere distribuito nello spazio dei nomi `kube-system`.
    ```
    kubectl apply -f customingress.yaml -n kube-system
    ```
    {: pre}

5. Ottieni l'etichetta sulla tua distribuzione Ingress personalizzata.
    ```
    kubectl get deploy nginx-ingress-controller -n kube-system --show-labels
    ```
    {: pre}

    Nel seguente output di esempio, il valore dell'etichetta è `ingress-nginx`:
    ```
    NAME                       DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE       LABELS
    nginx-ingress-controller   1         1         1            1           1m        app=ingress-nginx
    ```
    {: screen}

5. Usando l'ID ALB sei entrato nel passo 1, l'apertura del servizio del programma di bilanciamento del carico che espone l'ALB.
    ```
    kubectl edit svc <ALB_ID> -n kube-system
    ```
    {: pre}

6. Aggiorna il servizio del programma di bilanciamento del carico in modo che punti alla tua distribuzione Ingress personalizzata. In `spec/selector`, rimuovi l'ID ALB dall'etichetta `app` e aggiungi l'etichetta per il tuo controller Ingress che hai ottenuto nel passo 5.
    ```
    apiVersion: v1
    kind: Service
    metadata:
      ...
    spec:
      clusterIP: 172.21.xxx.xxx
      externalTrafficPolicy: Cluster
      loadBalancerIP: 169.xx.xxx.xxx
      ports:
      - name: http
        nodePort: 31070
        port: 80
        protocol: TCP
        targetPort: 80
      - name: https
        nodePort: 31854
        port: 443
        protocol: TCP
        targetPort: 443
      selector:
        app: <custom_controller_label>
      ...
    ```
    {: codeblock}
    1. Facoltativo: per impostazione predefinita, il servizio del programma di bilanciamento del carico consente il traffico sulla porta 80 e 443. Se il tuo controller Ingress personalizzato richiede una diversa serie di porte, aggiungi tali porte alla sezione `ports`.

7. Salva e chiudi il file di configurazione. L'output è simile al seguente:
    ```
    service "public-cr18e61e63c6e94b658596ca93d087eed9-alb1" edited
    ```
    {: screen}

8. Verifica che ora l'ALB `Selector` punti al tuo controller.
    ```
    kubectl describe svc <ALB_ID> -n kube-system
    ```
    {: pre}

    Output di esempio:
    ```
    Name:                     public-cre58bff97659a4f41bc927362d5a8ee7a-alb1
    Namespace:                kube-system
    Labels:                   app=public-cre58bff97659a4f41bc927362d5a8ee7a-alb1
    Annotations:              service.kubernetes.io/ibm-ingress-controller-public=169.xx.xxx.xxx
                              service.kubernetes.io/ibm-load-balancer-cloud-provider-zone=wdc07
    Selector:                 app=ingress-nginx
    Type:                     LoadBalancer
    IP:                       172.21.xxx.xxx
    IP:                       169.xx.xxx.xxx
    LoadBalancer Ingress:     169.xx.xxx.xxx
    Port:                     port-443  443/TCP
    TargetPort:               443/TCP
    NodePort:                 port-443  30087/TCP
    Endpoints:                172.30.xxx.xxx:443
    Port:                     port-80  80/TCP
    TargetPort:               80/TCP
    NodePort:                 port-80  31865/TCP
    Endpoints:                172.30.xxx.xxx:80
    Session Affinity:         None
    External Traffic Policy:  Cluster
    Events:                   <none>
    ```
    {: screen}

8. Distribuisci le altre risorse necessarie al tuo controller Ingress personalizzato, ad esempio la mappa di configurazione. 

9. Se hai un cluster multizona, ripeti questi passi per ciascun ALB.

10. Crea le risorse Ingress per le tue applicazioni seguendo i passi presenti in [Esposizione delle applicazioni all'interno del tuo cluster al pubblico](#ingress_expose_public).

Ora le tue applicazioni sono esposte dal tuo controller Ingress personalizzato. Per ripristinare la distribuzione ALB fornita da IBM, abilita di nuovo l'ALB. L'ALB viene ridistribuito e il servizio del programma di bilanciamento del carico viene riconfigurato automaticamente per puntare all'ALB.

```
ibmcloud ks alb-configure --alb-ID <alb ID> --enable
```
{: pre}
