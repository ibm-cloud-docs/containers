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



# Configurazione di Ingress
{: #ingress}

Esponi più applicazioni nel tuo cluster Kubernetes creando risorse Ingress che vengono gestite dall'ALB (application load balancer) fornito da IBM in {{site.data.keyword.containerlong}}.
{:shortdesc}

## YAML di esempio
{: #sample_ingress}

Utilizza questi file YAML di esempio per iniziare rapidamente a specificare la tua risorsa Ingress.
{: shortdesc}

**Risorsa Ingress per esporre pubblicamente un'applicazione**</br>

Hai già completato le seguenti attività?
- Distribuisci l'applicazione
- Crea il servizio dell'applicazione
- Seleziona il nome di dominio e il segreto TLS

Puoi utilizzare il seguente YAML di distribuzione per creare una risorsa Ingress:

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

**Risorsa Ingress per esporre privatamente un'applicazione**</br>

Hai già completato le seguenti attività?
- Abilita l'ALB privato
- Distribuisci l'applicazione
- Crea il servizio dell'applicazione
- Registra il nome di dominio personalizzato e il segreto TLS

Puoi utilizzare il seguente YAML di distribuzione per creare una risorsa Ingress:

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


## Prerequisiti
{: #config_prereqs}

Prima di iniziare ad utilizzare Ingress, controlla i seguenti prerequisiti.
{:shortdesc}

**Prerequisiti per tutte le configurazioni Ingress:**
- Ingress è disponibile solo per i cluster standard e richiede almeno due nodi di lavoro per ogni zona per garantire l'alta disponibilità e l'applicazione di aggiornamenti periodici. Se hai un solo nodo di lavoro in una zona, l'ALB non può ricevere gli aggiornamenti automatici. Quando gli aggiornamenti automatici vengono distribuiti ai pod ALB, il pod viene ricaricato. Tuttavia, i pod ALB hanno regole di anti-affinità per garantire che solo un pod sia pianificato su ciascun nodo di lavoro per l'alta disponibilità. Poiché è presente un solo pod ALB su un nodo di lavoro, il pod non viene riavviato in modo che il traffico non venga interrotto. Il pod ALB viene aggiornato alla versione più recente solo quando elimini il vecchio pod manualmente, in modo che il nuovo pod aggiornato possa essere pianificato.
- La configurazione di Ingress richiede i seguenti [ruoli {{site.data.keyword.cloud_notm}} IAM](/docs/containers?topic=containers-users#platform):
    - Ruolo della piattaforma **Amministratore** per il cluster
    - Ruolo del servizio **Gestore** in tutti gli spazi dei nomi

**Prerequisiti per l'uso di Ingress in cluster multizona**:
 - Se limiti il traffico di rete a [nodo di lavoro edge](/docs/containers?topic=containers-edge), devi abilitare almeno due nodi di lavoro edge in ciascuna zona per l'alta disponibilità dei pod Ingress. [Crea un pool di nodi di lavoro del nodo edge](/docs/containers?topic=containers-add_workers#add_pool) che si estenda tra tutte le zone del tuo cluster e che abbia almeno due nodi di lavoro per zona.
 - Se hai più VLAN per un cluster, più sottoreti sulla stessa VLAN o un cluster multizona, devi abilitare una [VRF (Virtual Router Function)](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud) per il tuo account dell'infrastruttura IBM Cloud in modo che i tuoi nodi di lavoro possano comunicare tra loro sulla rete privata. Per abilitare VRF, [contatta il tuo rappresentante dell'account dell'infrastruttura IBM Cloud](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#how-you-can-initiate-the-conversion). Per controllare se una VRF è già abilitata, utilizza il comando `ibmcloud account show`. Se non puoi o non vuoi abilitare VRF, abilita lo [spanning della VLAN](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning). Per eseguire questa azione, ti serve l'[autorizzazione dell'infrastruttura](/docs/containers?topic=containers-users#infra_access) **Rete > Gestisci il VLAN Spanning di rete** oppure puoi richiedere al proprietario dell'account di abilitarlo. Per controllare se lo spanning della VLAN è già abilitato, utilizza il [comando `ibmcloud ks vlan-spanning-get --region <region>`](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_vlan_spanning_get).
 - Se una zona presenta un malfunzionamento, potresti riscontrare malfunzionamenti intermittenti nelle richieste all'ALB Ingress in tale zona.

<br />


## Pianificazione della rete per spazi dei nomi singoli o multipli
{: #multiple_namespaces}

È richiesta una risorsa Ingress per ogni spazio dei nomi in cui hai le applicazioni che vuoi esporre.
{:shortdesc}

### Tutte le applicazioni sono in uno spazio dei nomi
{: #one-ns}

Se le applicazioni nel tuo cluster si trovano tutte nello stesso spazio dei nomi, è richiesta una risorsa Ingress per definire le regole di instradamento per le applicazioni che sono esposte lì. Ad esempio, se hai `app1` e `app2` esposte dai servizi in uno spazio dei nomi di sviluppo, puoi creare una risorsa Ingress nello spazio dei nomi. La risorsa specifica `domain.net` come host e registra i percorsi su cui è in ascolto ogni applicazione con `domain.net`.
{: shortdesc}

<img src="images/cs_ingress_single_ns.png" width="270" alt="È richiesta una risorsa per spazio dei nomi" style="width:270px; border-style: none"/>

### Le applicazioni sono in più spazi dei nomi
{: #multi-ns}

Se le applicazioni nel tuo cluster si trovano in spazi dei nomi differenti, devi creare una risorsa per ogni spazio dei nomi per definire le regole per le applicazioni che sono esposte lì.
{: shortdesc}

Tuttavia, puoi definire un nome host in una sola risorsa. Non puoi definire lo stesso nome host in più risorse. Per registrare più risorse Ingress con lo stesso nome host, devi utilizzare un dominio jolly. Quando viene registrato un dominio jolly come `*.domain.net`, più domini secondari possono essere risolti tutti nello stesso host. Quindi, puoi creare una risorsa Ingress in ogni spazio dei nomi e specificare un dominio secondario diverso in ogni risorsa Ingress.

Ad esempio, considera il seguente scenario:
* Hai due versioni della stessa applicazione, `app1` e `app3`, per scopi di test.
* Distribuisci le applicazioni in due spazi dei nomi differenti all'interno dello stesso cluster: `app1` nello spazio dei nomi di sviluppo e `app3` in quello di preparazione.

Per utilizzare lo stesso ALB del cluster per gestire il traffico a queste applicazioni, crea i seguenti servizi e risorse:
* Un servizio Kubernetes nello spazio dei nomi di sviluppo per esporre `app1`.
* Una risorsa Ingress nello spazio dei nodi di sviluppo che specifica l'host come `dev.domain.net`.
* Un servizio Kubernetes nello spazio dei nomi di preparazione per esporre `app3`.
* Una risorsa Ingress nello spazio dei nomi di preparazione che specifica l'host come `stage.domain.net`.
</br>
<img src="images/cs_ingress_multi_ns.png" width="625" alt="All'interno di uno spazio dei nomi, utilizza i domini secondari in una o più risorse" style="width:625px; border-style: none"/>

Ora, entrambi gli URL risolvono lo stesso dominio e sono anche serviti dallo stesso ALB. Tuttavia, poiché la risorsa nello spazio dei nomi di preparazione viene registrata nel dominio secondario `stage`, l'ALB Ingress instrada correttamente le richieste dall'URL `stage.domain.net/app3` solo a `app3`.

{: #wildcard_tls}
Il dominio secondario jolly Ingress fornito da IBM, `*.<cluster_name>.<region>.containers.appdomain.cloud`, viene registrato per impostazione predefinita per il tuo cluster. Il certificato TLS fornito da IBM è un certificato jolly e può essere utilizzato per il dominio secondario jolly. Se vuoi utilizzare un dominio personalizzato, devi registrarlo come un dominio jolly come ad esempio `*.custom_domain.net`. Per utilizzare TLS, devi ottenere un certificato jolly.
{: note}

### Più domini all'interno di uno spazio dei nomi.
{: #multi-domains}

All'interno di uno spazio dei nomi individuale, puoi utilizzare un dominio per accedere a tutte le applicazioni nello spazio dei nomi. Se vuoi utilizzare domini differenti per le applicazioni all'interno di uno spazio dei nomi individuale, utilizza un dominio jolly. Quando viene registrato un dominio jolly come `*.mycluster.us-south.containers.appdomain.cloud`, tutti i domini multipli vengono risolti dallo stesso host. Quindi, puoi utilizzare una risorsa per specificare più host del dominio secondario in tale risorsa. In alternativa, puoi creare più risorse Ingress nello spazio dei nomi e specificare un dominio secondario diverso in ogni risorsa Ingress.
{: shortdesc}

<img src="images/cs_ingress_single_ns_multi_subs.png" width="625" alt="È richiesta una risorsa per spazio dei nomi." style="width:625px; border-style: none"/>

Il dominio secondario jolly Ingress fornito da IBM, `*.<cluster_name>.<region>.containers.appdomain.cloud`, viene registrato per impostazione predefinita per il tuo cluster. Il certificato TLS fornito da IBM è un certificato jolly e può essere utilizzato per il dominio secondario jolly. Se vuoi utilizzare un dominio personalizzato, devi registrarlo come un dominio jolly come ad esempio `*.custom_domain.net`. Per utilizzare TLS, devi ottenere un certificato jolly.
{: note}

<br />


## Esposizione delle applicazioni all'interno del tuo cluster al pubblico
{: #ingress_expose_public}

Esponi le applicazioni all'interno del tuo cluster al pubblico utilizzando l'ALB Ingress pubblico.
{:shortdesc}

Prima di iniziare:

* Esamina i [prerequisiti](#config_prereqs) Ingress.
* [Accedi al tuo account. Se applicabile, specifica il gruppo di risorse appropriato. Imposta il contesto per il tuo cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

### Passo 1: Distribuisci le applicazioni e crea i servizi dell'applicazione.
{: #public_inside_1}

Inizia distribuendo le tue applicazioni e creando i servizi Kubernetes per esporle.
{: shortdesc}

1.  [Distribuisci la tua applicazione al cluster](/docs/containers?topic=containers-app#app_cli). Assicurati di aggiungere un'etichetta alla tua distribuzione nella sezione dei metadati del tuo file di configurazione, ad esempio `app: code`. Questa etichetta è necessaria per identificare tutti i pod in cui è in esecuzione la tua applicazione in modo che possano essere inclusi nel bilanciamento del carico Ingress.

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
          <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML del servizio ALB</th>
          </thead>
          <tbody>
          <tr>
          <td><code>selector</code></td>
          <td>Immetti la coppia di chiave (<em>&lt;selector_key&gt;</em>) e valore (<em>&lt;selector_value&gt;</em>) dell'etichetta che vuoi utilizzare per indirizzare i pod in cui viene eseguita la tua applicazione. Per indirizzare i tuoi pod e includerli nel bilanciamento del carico di servizio, assicurati che i valori di <em>&lt;selector_key&gt;</em> e <em>&lt;selector_value&gt;</em> siano gli stessi della coppia chiave/valore nella sezione <code>spec.template.metadata.labels</code> del tuo YAML di distribuzione.</td>
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


### Passo 2: Seleziona un dominio dell'applicazione
{: #public_inside_2}

Quando configuri l'ALB pubblico, scegli il dominio tramite il quale saranno accessibili le tue applicazioni.
{: shortdesc}

Puoi utilizzare il dominio fornito da IBM, come `mycluster-12345.us-south.containers.appdomain.cloud/myapp`, per accedere alla tua applicazione da Internet. Per utilizzare invece un dominio personalizzato, puoi impostare un record CNAME per associarlo al dominio fornito da IBM o impostare un record con il tuo provider DNS che utilizza l'indirizzo IP pubblico dell'ALB.

**Per utilizzare il dominio Ingress fornito da IBM:**

Ottieni il dominio fornito da IBM. Sostituisci `<cluster_name_or_ID>` con il nome del cluster in cui viene distribuita l'applicazione.
```
ibmcloud ks cluster-get --cluster <cluster_name_or_ID> | grep Ingress
```
{: pre}

Output di esempio:
```
Ingress Subdomain:      mycluster-12345.us-south.containers.appdomain.cloud
Ingress Secret:         <tls_secret>
```
{: screen}

**Per utilizzare un dominio personalizzato:**
1.    Crea un dominio personalizzato. Per registrare il tuo dominio personalizzato, utilizza il provider DNS (Domain Name Service) o il [DNS {{site.data.keyword.cloud_notm}}](/docs/infrastructure/dns?topic=dns-getting-started).
      * Se le applicazioni che vuoi che Ingress esponga si trovano in spazi dei nomi diversi in un cluster, registra il dominio personalizzato come dominio jolly, ad esempio `*.custom_domain.net`.

2.  Configura il tuo dominio per instradare il traffico di rete in entrata all'ALB fornito da IBM. Scegli tra queste opzioni:
    -   Definisci un alias per il tuo dominio personalizzato specificando il dominio fornito da IBM come un record di nome canonico (CNAME). Per trovare il dominio Ingress fornito da IBM, esegui `ibmcloud ks cluster-get --cluster <cluster_name>` e cerca il campo **Dominio secondario Ingress**. L'utilizzo di un CNAME è preferito perché IBM fornisce dei controlli dell'integrità automatici sul dominio secondario IBM e rimuove gli eventuali IP malfunzionanti dalla risposta DNS.
    -   Associa il tuo dominio personalizzato all'indirizzo IP pubblico portatile del controller fornito da IBM aggiungendo l'indirizzo IP come un record A. Per trovare l'indirizzo IP pubblico portatile dell'ALB, esegui `ibmcloud ks alb-get --albID  <public_alb_ID>`.

### Passo 3: Seleziona la terminazione TLS
{: #public_inside_3}

Dopo aver scelto il dominio dell'applicazione, scegli se utilizzare la terminazione TLS.
{: shortdesc}

L'ALB bilancia il carico del traffico di rete HTTP alle applicazioni nel tuo cluster. Per bilanciare anche il traffico delle connessioni HTTPS in entrata, puoi configurare l'ALB per decodificare il traffico di rete e inoltrare la richiesta decodificata alle applicazioni esposte nel tuo cluster.

* Se usi il dominio secondario Ingress fornito da IBM, puoi usare il certificato TLS fornito da IBM. I certificati TLS forniti da IBM vengono firmati da LetsEncrypt e vengono gestiti completamente da IBM. I certificati scadono ogni 90 giorni e vengono rinnovati automaticamente 37 giorni prima della scadenza. Per ulteriori informazioni sulla certificazione TLS jolly, vedi [questa nota](#wildcard_tls).
* Se usi un dominio personalizzato, puoi usare il tuo certificato TLS per gestire la terminazione TLS. L'ALB verifica innanzitutto la presenza di un segreto nello spazio dei nomi in cui si trova l'applicazione, poi nello spazio dei nomi di `default` e infine in `ibm-cert-store`. Se hai applicazioni in un unico spazio dei nomi, puoi importare o creare un segreto TLS per il certificato in questo stesso spazio dei nomi. Se hai applicazioni in più spazi dei nomi, importa o crea un segreto TLS per il certificato nello spazio dei nomi `default` in modo tale che l'ALB possa accedere e usare il certificato in ogni spazio dei nomi. Nelle risorse Ingress che definisci per ogni spazio dei nomi, specifica il nome del segreto che si trova nello spazio dei nomi predefinito. Per ulteriori informazioni sulla certificazione TLS jolly, vedi [questa nota](#wildcard_tls).**Nota**:i certificati TLS che contengono le chiavi precondivise (TLS-PSK) non sono supportati.

**Se utilizzi il dominio Ingress fornito da IBM:**

Ottieni il segreto TLS fornito da IBM per il tuo cluster.
```
ibmcloud ks cluster-get --cluster <cluster_name_or_ID> | grep Ingress
```
{: pre}

Output di esempio:
```
Ingress Subdomain:      mycluster-12345.us-south.containers.appdomain.cloud
Ingress Secret:         <tls_secret>
```
{: screen}
</br>

**Se utilizzi un dominio personalizzato:**

Se in {{site.data.keyword.cloudcerts_long_notm}} è memorizzato un certificato TLS che vuoi utilizzare, puoi importare il suo segreto associato nel tuo cluster immettendo il seguente comando:

```
ibmcloud ks alb-cert-deploy --secret-name <secret_name> --cluster <cluster_name_or_ID> --cert-crn <certificate_crn>
```
{: pre}

Assicurati di non creare il segreto con lo stesso nome del segreto Ingress fornito da IBM. Puoi ottenere il nome del segreto Ingress fornito da IBM eseguendo `ibmcloud ks cluster-get --cluster <cluster_name_or_ID> | grep Ingress`.
{: note}

Quando importi un certificato con questo comando, il segreto del certificato viene creato in uno spazio dei nomi chiamato `ibm-cert-store`. Un riferimento a questo segreto viene quindi creato nello spazio dei nomi `default`, a cui può accedere qualsiasi risorsa Ingress in qualsiasi spazio dei nomi. Quando l'ALB elabora le richieste, segue questo riferimento per raccogliere e utilizzare il segreto del certificato dallo spazio dei nomi `ibm-cert-store`.

</br>

Se non hai un certificato TLS pronto, segui questa procedura:
1. Genera un certificato e una chiave di autorità di certificazione (CA, certificate authority) dal tuo provider di certificati. Se disponi del tuo proprio dominio, acquista un certificato TLS ufficiale per il dominio. Assicurati che il [CN ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://support.dnsimple.com/articles/what-is-common-name/) sia diverso per ciascun certificato.
2. Converti il certificato e la chiave in base64.
   1. Codifica il certificato e la chiave in base64 e salva il valore con codifica base64 in un nuovo file.
      ```
      openssl base64 -in tls.key -out tls.key.base64
      ```
      {: pre}

   2. Visualizza il valore con codifica base64 per il certificato e la chiave.
      ```
      cat tls.key.base64
      ```
      {: pre}

3. Crea un file YAML del segreto utilizzando il certificato e la chiave.
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

4. Crea il certificato come segreto Kubernetes.
     ```
     kubectl apply -f ssl-my-test
     ```
     {: pre}
     Assicurati di non creare il segreto con lo stesso nome del segreto Ingress fornito da IBM. Puoi ottenere il nome del segreto Ingress fornito da IBM eseguendo `ibmcloud ks cluster-get --cluster <cluster_name_or_ID> | grep Ingress`.
     {: note}


### Passo 4: Crea la risorsa Ingress
{: #public_inside_4}

Le risorse Ingress definiscono le regole di instradamento che l'ALB utilizza per instradare il traffico al tuo servizio dell'applicazione.
{: shortdesc}

Se il tuo cluster ha più spazi dei nomi in cui sono esposte le applicazioni, è richiesta una risorsa Ingress per ogni spazio dei nomi. Tuttavia, ogni spazio dei nomi deve utilizzare un host diverso. Devi registrare un dominio jolly e specificare un dominio secondario differente in ogni risorsa. Per ulteriori informazioni, vedi [Pianificazione della rete per spazi dei nomi singoli o multipli](#multiple_namespaces).
{: note}

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
    <td><code>tls.hosts</code></td>
    <td>Per utilizzare TLS, sostituisci <em>&lt;domain&gt;</em> con il dominio secondario Ingress fornito da IBM o con il tuo dominio personalizzato.

    </br></br>
    <strong>Nota:</strong><ul><li>Se le tue applicazioni sono esposte dai servizi in spazi dei nomi differenti in un cluster, aggiungi un dominio secondario jolly all'inizio del dominio, ad esempio `subdomain1.custom_domain.net` o `subdomain1.mycluster.us-south.containers.appdomain.cloud`. Utilizza un dominio secondario univoco per ogni risorsa che crei nel cluster.</li><li>Non utilizzare &ast; per il tuo host o lascia vuota la proprietà host per evitare errori durante la creazione di Ingress.</li></ul></td>
    </tr>
    <tr>
    <td><code>tls.secretName</code></td>
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
    <strong>Suggerimento:</strong> per configurare Ingress affinché sia in ascolto su un percorso diverso da quello su cui è in ascolto la tua applicazione, puoi utilizzare l'[annotazione di riscrittura](/docs/containers?topic=containers-ingress_annotation#rewrite-path).</td>
    </tr>
    <tr>
    <td><code>serviceName</code></td>
    <td>Sostituisci <em>&lt;app1_service&gt;</em> e <em>&lt;app2_service&gt;</em> e così via, con il nome dei servizi che hai creato per esporre le tue applicazioni. Se le tue applicazioni sono esposte dai servizi in spazi dei nomi differenti nel cluster, includi solo i servizi dell'applicazione presenti nello stesso spazio dei nomi. Devi creare una risorsa Ingress per ogni spazio dei nomi in cui hai delle applicazioni che vuoi esporre.</td>
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

      1. Se i messaggi negli eventi descrivono un errore nella configurazione della tua risorsa, modifica i valori nel file di risorse e riapplica il file per la risorsa.


La tua risorsa Ingress viene creata nello stesso spazio dei nomi dei tuoi servizi dell'applicazione. Le tue applicazioni in questo spazio dei nomi vengono registrate con l'ALB Ingress del cluster.

### Passo 5: Accedi alla tua applicazione da Internet
{: #public_inside_5}

In un browser web, immetti l'URL del servizio dell'applicazione a cui accedere.
{: shortdesc}

```
https://<domain>/<app1_path>
```
{: codeblock}

Se hai esposto più applicazioni, accedi a queste applicazioni modificando il percorso accodato all'URL.

```
https://<domain>/<app2_path>
```
{: codeblock}

Se utilizzi un dominio jolly per esporre le applicazioni in diversi spazi dei nomi, accedi a queste applicazioni con i relativi domini secondari.

```
http://<subdomain1>.<domain>/<app1_path>
```
{: codeblock}

```
http://<subdomain2>.<domain>/<app1_path>
```
{: codeblock}


Hai problemi a connetterti alla tua applicazione tramite Ingress? Prova ad eseguire il [debug di Ingress](/docs/containers?topic=containers-cs_troubleshoot_debug_ingress).
{: tip}

<br />


## Esposizione delle applicazioni all'esterno del tuo cluster al pubblico
{: #external_endpoint}

Esponi le applicazioni all'esterno del tuo cluster al pubblico includendole nel programma di bilanciamento del carico ALB Ingress pubblico. Le richieste pubbliche in entrata sul dominio fornito da IBM o sul tuo dominio personalizzato vengono inoltrate automaticamente all'applicazione esterna.
{: shortdesc}

Prima di iniziare:

* Esamina i [prerequisiti](#config_prereqs) Ingress.
* Assicurati che l'applicazione esterna che desideri includere nel bilanciamento del carico del cluster sia accessibile mediante un indirizzo IP pubblico.
* [Accedi al tuo account. Se applicabile, specifica il gruppo di risorse appropriato. Imposta il contesto per il tuo cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

Per esporre al pubblico le applicazioni che si trovano all'esterno del cluster:

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
        <td><code>metadata.name</code></td>
        <td>Sostituisci <em><code>&lt;myexternalservice&gt;</code></em> con un nome per il tuo servizio.<p>Ulteriori informazioni sulla [protezione delle tue informazioni personali](/docs/containers?topic=containers-security#pi) quando utilizzi le risorse Kubernetes.</p></td>
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
        <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code>name</code></td>
        <td>Sostituisci <em><code>&lt;myexternalendpoint&gt;</code></em> con il nome del servizio Kubernetes che hai creato in precedenza.</td>
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

3. Continua con i passi indicati in "Esposizione delle applicazioni all'interno del tuo cluster al pubblico", [Passo 2: Seleziona un dominio dell'applicazione](#public_inside_2).

<br />


## Esposizione delle applicazioni su una rete privata
{: #ingress_expose_private}

Esponi le applicazioni a una rete privata utilizzando l'ALB Ingress privato.
{:shortdesc}

Per utilizzare un ALB privato, devi prima abilitarlo. Poiché ai cluster con solo VLAN private non viene assegnato un dominio secondario Ingress fornito da IBM, non viene creato alcun segreto Ingress durante la configurazione del cluster. Per esporre le tue applicazioni alla rete privata, devi registrare l'ALB con un dominio personalizzato e, facoltativamente, importare il tuo proprio certificato TLS.

Prima di iniziare:
* Esamina i [prerequisiti](#config_prereqs) Ingress.
* Esamina le opzioni per la pianificazione dell'accesso privato alle applicazioni quando i nodi di lavoro vengono connessi a [una VLAN pubblica e a una VLAN privata](/docs/containers?topic=containers-cs_network_planning#private_both_vlans) oppure [solo a una VLAN privata](/docs/containers?topic=containers-cs_network_planning#plan_private_vlan).
    * Se i tuoi nodi di lavoro sono connessi solo a una VLAN privata, devi configurare un [servizio DNS che sia disponibile sulla rete privata ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/).

### Passo 1: Distribuisci le applicazioni e crea i servizi dell'applicazione.
{: #private_1}

Inizia distribuendo le tue applicazioni e creando i servizi Kubernetes per esporle.
{: shortdesc}

1.  [Distribuisci la tua applicazione al cluster](/docs/containers?topic=containers-app#app_cli). Assicurati di aggiungere un'etichetta alla tua distribuzione nella sezione dei metadati del tuo file di configurazione, ad esempio `app: code`. Questa etichetta è necessaria per identificare tutti i pod in cui è in esecuzione la tua applicazione in modo che possano essere inclusi nel bilanciamento del carico Ingress.

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
          <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML del servizio ALB</th>
          </thead>
          <tbody>
          <tr>
          <td><code>selector</code></td>
          <td>Immetti la coppia di chiave (<em>&lt;selector_key&gt;</em>) e valore (<em>&lt;selector_value&gt;</em>) dell'etichetta che vuoi utilizzare per indirizzare i pod in cui viene eseguita la tua applicazione. Per indirizzare i tuoi pod e includerli nel bilanciamento del carico di servizio, assicurati che i valori di <em>&lt;selector_key&gt;</em> e <em>&lt;selector_value&gt;</em> siano gli stessi della coppia chiave/valore nella sezione <code>spec.template.metadata.labels</code> del tuo YAML di distribuzione.</td>
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


### Passo 2: Abilita l'ALB privato predefinito
{: #private_ingress}

Quando crei un cluster standard, in ogni zona in cui hai nodi di lavoro, viene creato un ALB fornito da IBM e viene assegnato un indirizzo IP privato portatile e una rotta privata. Tuttavia, l'ALB privato predefinito in ciascuna zona non viene abilitato automaticamente. Per usare l'ALB privato predefinito per bilanciare il carico del traffico di rete privato alle tue applicazioni, devi innanzitutto abilitarlo con l'indirizzo IP privato portatile fornito da IBM o con il tuo indirizzo IP privato portatile.
{:shortdesc}

Se quando hai creato il cluster hai utilizzato l'indicatore `--no-subnet`, devi aggiungere una sottorete privata portatile o una sottorete gestita dall'utente prima di poter abilitare l'ALB privato. Per ulteriori informazioni, vedi [Richiesta di più sottoreti per il tuo cluster](/docs/containers?topic=containers-subnets#request).
{: note}

**Per abilitare un ALB privato predefinito utilizzando l'indirizzo IP privato portatile fornito da IBM preassegnato:**

1. Ottieni l'ID dell'ALB privato predefinito che vuoi abilitare. Sostituisci <em>&lt;cluster_name&gt;</em> con il nome del cluster in cui viene distribuita l'applicazione che vuoi esporre.

    ```
    ibmcloud ks albs --cluster <cluster_name>
    ```
    {: pre}

    Il campo **Status** per gli ALB privati è _disabled_.
    ```
    ALB ID                                            Enabled   Status     Type      ALB IP          Zone    Build                          ALB VLAN ID
    private-crdf253b6025d64944ab99ed63bb4567b6-alb1   false     disabled   private   -               dal10   ingress:411/ingress-auth:315   2234947
    public-crdf253b6025d64944ab99ed63bb4567b6-alb1    true      enabled    public    169.xx.xxx.xxx  dal10   ingress:411/ingress-auth:315   2234945
    ```
    {: screen}
    Nei cluster multizona, il suffisso numerato sull'ID ALB indica l'ordine in cui è stato aggiunto l'ALB.
    * Ad esempio, il suffisso `-alb1` sull'ALB `private-cr6d779503319d419aa3b4ab171d12c3b8-alb1` indica che è stato il primo ALB privato predefinito che è stato creato. È presente nella zona in cui hai creato il cluster. Nell'esempio precedente, il cluster è stato creato in `dal10`.
    * Il suffisso `-alb2` nell'ALB `private-crb2f60e9735254ac8b20b9c1e38b649a5-alb2` indica che è stato il secondo ALB privato predefinito che è stato creato. È presente nella seconda zona che hai aggiunto al tuo cluster. Nell'esempio precedente, la seconda zona è `dal12`.

2. Abilita l'ALB privato. Sostituisci <em>&lt;private_ALB_ID&gt;</em> con l'ID dell'ALB privato indicato nell'output nel passo precedente.

   ```
   ibmcloud ks alb-configure --albID <private_ALB_ID> --enable
   ```
   {: pre}

3. **Cluster multizona**: per l'alta disponibilità, ripeti la procedura precedente per l'ALB privato in ciascuna zona.

<br>
**Per abilitare l'ALB privato utilizzando il tuo proprio indirizzo IP privato portatile:**

1. Elenca gli ALB disponibili nel tuo cluster. Prendi nota dell'ID dell'ALB privato e della zona in cui si trova l'ALB.

 ```
 ibmcloud ks albs --cluster <cluster_name>
 ```
 {: pre}

 Il campo **Status** per l'ALB privato è _disabled_.
 ```
 ALB ID                                            Enabled   Status     Type      ALB IP          Zone    Build                          ALB VLAN ID
    private-crdf253b6025d64944ab99ed63bb4567b6-alb1   false     disabled   private   -               dal10   ingress:411/ingress-auth:315   2234947
    public-crdf253b6025d64944ab99ed63bb4567b6-alb1    true      enabled    public    169.xx.xxx.xxx  dal10   ingress:411/ingress-auth:315   2234945
 ```
 {: screen}

 2. Configura la sottorete gestita dall'utente dell'indirizzo IP che hai scelto per instradare il traffico sulla VLAN privata in tale zona.

   ```
   ibmcloud ks cluster-user-subnet-add --cluster <cluster_name> --subnet-cidr <subnet_CIDR> --private-vlan <private_VLAN>
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
   <td>L'ID della VLAN privata. Questo valore è obbligatorio. L'ID deve essere per una VLAN privata nella stessa zona dell'ALB privato. Per visualizzare le VLAN private per questa zona in cui si trovano i nodi di lavoro, esegui `ibmcloud ks workers --cluster <cluster_name_or_ID>` e prendi nota dell'ID di un nodo di lavoro in tale zona. Utilizzando l'ID del nodo di lavoro, esegui `ibmcloud ks worker-get --worker <worker_id> --cluster <cluster_name_or_id>`. Nell'output, prendi nota dell'ID della VLAN privata (**Private VLAN**).</td>
   </tr>
   </tbody></table>

3. Abilita l'ALB privato. Sostituisci <em>&lt;private_ALB_ID&gt;</em> con l'ID per l'ALB privato e <em>&lt;user_IP&gt;</em> con l'indirizzo IP dalla tua sottorete gestita dell'utente che desideri utilizzare.
   ```
   ibmcloud ks alb-configure --albID <private_ALB_ID> --enable --user-ip <user_IP>
   ```
   {: pre}

4. **Cluster multizona**: per l'alta disponibilità, ripeti la procedura precedente per l'ALB privato in ciascuna zona.

### Passo 3: Associa il tuo dominio personalizzato
{: #private_3}

Ai cluster con solo VLAN private non viene assegnato un dominio secondario Ingress fornito da IBM. Quando configuri l'ALB privato, esponi le tue applicazioni utilizzando un dominio personalizzato.
{: shortdesc}

**Cluster con solo VLAN private:**

1. Se i tuoi nodi di lavoro sono connessi solo a una VLAN privata, devi configurare il tuo proprio [servizio DNS disponibile sulla tua rete privata ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/).
2. Crea un dominio personalizzato tramite il tuo provider DNS. Se le applicazioni che vuoi che Ingress esponga si trovano in spazi dei nomi diversi in un cluster, registra il dominio personalizzato come dominio jolly, ad esempio *.custom_domain.net`.
3. Utilizzando il tuo servizio DNS privato, associa il tuo dominio personalizzato agli indirizzi IP privati portatili degli ALB aggiungendo gli indirizzi IP come record A. Per trovare gli indirizzi IP privati portatili degli ALB, esegui `ibmcloud ks alb-get --albID <private_alb_ID>` per ciascun ALB.

**Cluster con VLAN private e pubbliche:**

1.    Crea un dominio personalizzato. Per registrare il tuo dominio personalizzato, utilizza il provider DNS (Domain Name Service) o il [DNS {{site.data.keyword.cloud_notm}}](/docs/infrastructure/dns?topic=dns-getting-started).
      * Se le applicazioni che vuoi che Ingress esponga si trovano in spazi dei nomi diversi in un cluster, registra il dominio personalizzato come dominio jolly, ad esempio `*.custom_domain.net`.

2.  Associa il tuo dominio personalizzato agli indirizzi IP privati portatili degli ALB aggiungendo gli indirizzi IP come record A. Per trovare gli indirizzi IP privati portatili degli ALB, esegui `ibmcloud ks alb-get --albID <private_alb_ID>` per ciascun ALB.

### Passo 4: Seleziona la terminazione TLS
{: #private_4}

Dopo aver associato il tuo dominio personalizzato, scegli se utilizzare la terminazione TLS.
{: shortdesc}

L'ALB bilancia il carico del traffico di rete HTTP alle applicazioni nel tuo cluster. Per bilanciare anche il traffico delle connessioni HTTPS in entrata, puoi configurare l'ALB per decodificare il traffico di rete e inoltrare la richiesta decodificata alle applicazioni esposte nel tuo cluster.

Poiché ai cluster con solo VLAN private non viene assegnato un dominio Ingress fornito da IBM, non viene creato alcun segreto Ingress durante la configurazione del cluster. Puoi utilizzare il tuo proprio certificato TLS per gestire la terminazione TLS.  L'ALB verifica innanzitutto la presenza di un segreto nello spazio dei nomi in cui si trova l'applicazione, poi nello spazio dei nomi di `default` e infine in `ibm-cert-store`. Se hai applicazioni in un unico spazio dei nomi, puoi importare o creare un segreto TLS per il certificato in questo stesso spazio dei nomi. Se hai applicazioni in più spazi dei nomi, importa o crea un segreto TLS per il certificato nello spazio dei nomi `default` in modo tale che l'ALB possa accedere e usare il certificato in ogni spazio dei nomi. Nelle risorse Ingress che definisci per ogni spazio dei nomi, specifica il nome del segreto che si trova nello spazio dei nomi predefinito. Per ulteriori informazioni sulla certificazione TLS jolly, vedi [questa nota](#wildcard_tls).**Nota**:i certificati TLS che contengono le chiavi precondivise (TLS-PSK) non sono supportati.

Se in {{site.data.keyword.cloudcerts_long_notm}} è memorizzato un certificato TLS che vuoi utilizzare, puoi importare il suo segreto associato nel tuo cluster immettendo il seguente comando:

```
ibmcloud ks alb-cert-deploy --secret-name <secret_name> --cluster <cluster_name_or_ID> --cert-crn <certificate_crn>
```
{: pre}

Quando importi un certificato con questo comando, il segreto del certificato viene creato in uno spazio dei nomi chiamato `ibm-cert-store`. Un riferimento a questo segreto viene quindi creato nello spazio dei nomi `default`, a cui può accedere qualsiasi risorsa Ingress in qualsiasi spazio dei nomi. Quando l'ALB elabora le richieste, segue questo riferimento per raccogliere e utilizzare il segreto del certificato dallo spazio dei nomi `ibm-cert-store`.

### Passo 5: Crea la risorsa Ingress
{: #private_5}

Le risorse Ingress definiscono le regole di instradamento che l'ALB utilizza per instradare il traffico al tuo servizio dell'applicazione.
{: shortdesc}

Se il tuo cluster ha più spazi dei nomi in cui sono esposte le applicazioni, è richiesta una risorsa Ingress per ogni spazio dei nomi. Tuttavia, ogni spazio dei nomi deve utilizzare un host diverso. Devi registrare un dominio jolly e specificare un dominio secondario differente in ogni risorsa. Per ulteriori informazioni, vedi [Pianificazione della rete per spazi dei nomi singoli o multipli](#multiple_namespaces).
{: note}

1. Apri il tuo editor preferito e crea un file di configurazione Ingress denominato, ad esempio, `myingressresource.yaml`.

2.  Definisci una risorsa Ingress nel tuo file di configurazione che utilizza il tuo dominio personalizzato per instradare il traffico di rete in entrata ai servizi che hai creato in precedenza.

    YAML di esempio che non utilizza TLS:
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

    YAML di esempio che utilizza TLS:
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
    <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code>ingress.bluemix.net/ALB-ID</code></td>
    <td>Sostituisci <em>&lt;private_ALB_ID&gt;</em> con l'ID del tuo ALB privato. Se hai un cluster multizona e hai abilitato più ALB privati, includi l'ID di ciascun ALB. Esegui <code>ibmcloud ks albs --cluster <my_cluster></code> per trovare gli ID ALB. Per ulteriori informazioni su questa annotazione Ingress, consulta [Instradamento dell'ALB (application load balancer) privato](/docs/containers?topic=containers-ingress_annotation#alb-id).</td>
    </tr>
    <tr>
    <td><code>tls.hosts</code></td>
    <td>Per utilizzare TLS, sostituisci <em>&lt;domain&gt;</em> con il tuo dominio personalizzato.</br></br><strong>Nota:</strong><ul><li>Se le tue applicazioni sono esposte dai servizi in spazi dei nomi differenti in un cluster, aggiungi un dominio secondario jolly all'inizio del dominio, ad esempio `subdomain1.custom_domain.net`. Utilizza un dominio secondario univoco per ogni risorsa che crei nel cluster.</li><li>Non utilizzare &ast; per il tuo host o lascia vuota la proprietà host per evitare errori durante la creazione di Ingress.</li></ul></td>
    </tr>
    <tr>
    <td><code>tls.secretName</code></td>
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
    <strong>Suggerimento:</strong> per configurare Ingress affinché sia in ascolto su un percorso diverso da quello su cui è in ascolto la tua applicazione, puoi utilizzare l'[annotazione di riscrittura](/docs/containers?topic=containers-ingress_annotation#rewrite-path).</td>
    </tr>
    <tr>
    <td><code>serviceName</code></td>
    <td>Sostituisci <em>&lt;app1_service&gt;</em> e <em>&lt;app2_service&gt;</em> e così via, con il nome dei servizi che hai creato per esporre le tue applicazioni. Se le tue applicazioni sono esposte dai servizi in spazi dei nomi differenti nel cluster, includi solo i servizi dell'applicazione presenti nello stesso spazio dei nomi. Devi creare una risorsa Ingress per ogni spazio dei nomi in cui hai delle applicazioni che vuoi esporre.</td>
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

      1. Se i messaggi negli eventi descrivono un errore nella configurazione della tua risorsa, modifica i valori nel file di risorse e riapplica il file per la risorsa.


La tua risorsa Ingress viene creata nello stesso spazio dei nomi dei tuoi servizi dell'applicazione. Le tue applicazioni in questo spazio dei nomi vengono registrate con l'ALB Ingress del cluster.

### Passo 6: Accedi alla tua applicazione dalla rete privata
{: #private_6}

1. Prima di poter accedere alla tua applicazione, assicurati di poter accedere a un servizio DNS.
  * VLAN pubblica e privata: per usare il provider DNS esterno predefinito, devi [configurare i nodi edge con l'accesso pubblico](/docs/containers?topic=containers-edge#edge) e [configurare una VRA (Virtual Router Appliance) ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.ibm.com/blogs/bluemix/2017/07/kubernetes-and-bluemix-container-based-workloads-part4/).
  * Solo VLAN privata: devi configurare un [servizio DNS che sia disponibile sulla rete privata ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/).

2. Dall'interno del tuo firewall della rete privata, immetti l'URL del servizio dell'applicazione in un browser web.

```
https://<domain>/<app1_path>
```
{: codeblock}

Se hai esposto più applicazioni, accedi a queste applicazioni modificando il percorso accodato all'URL.

```
https://<domain>/<app2_path>
```
{: codeblock}

Se utilizzi un dominio jolly per esporre le applicazioni in diversi spazi dei nomi, accedi a queste applicazioni con i relativi domini secondari.

```
http://<subdomain1>.<domain>/<app1_path>
```
{: codeblock}

```
http://<subdomain2>.<domain>/<app1_path>
```
{: codeblock}


Per un'esercitazione completa su come proteggere le comunicazioni tra i microservizi nei tuoi cluster utilizzando l'ALB privato con TLS, consulta [questo post del blog ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://medium.com/ibm-cloud/secure-microservice-to-microservice-communication-across-kubernetes-clusters-using-a-private-ecbe2a8d4fe2).
{: tip}
