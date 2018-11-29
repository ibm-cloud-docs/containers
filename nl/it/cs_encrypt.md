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


# Protezione delle informazioni sensibili nel tuo cluster
{: #encryption}

Per impostazione predefinita, il tuo cluster {{site.data.keyword.containerlong}} utilizza dischi crittografati per memorizzare informazioni come le configurazioni in `etcd` o nel file system del contenitore che viene eseguito sui dischi secondari del nodo di lavoro. Quando distribuisci la tua applicazione, non memorizzare informazioni riservate, quali credenziali o chiavi, nel file di configurazione YAML, nelle mappe di configurazione o negli script. Utilizza invece i [segreti Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/concepts/configuration/secret/). Puoi anche crittografare i dati nei segreti Kubernetes per impedire agli utenti non autorizzati di accedere a informazioni riservate sui cluster.
{: shortdesc}

Per ulteriori informazioni sulla protezione del tuo cluster, vedi [Sicurezza per {{site.data.keyword.containerlong_notm}}](cs_secure.html#security).



## Utilizzo dei segreti
{: #secrets}

I segreti Kubernetes rappresentano un modo sicuro per memorizzare informazioni riservate, quali nome utente, password o
chiavi. Se hai bisogno di informazioni riservate crittografate, [abilita {{site.data.keyword.keymanagementserviceshort}}](#keyprotect) per crittografare i segreti. Per ulteriori informazioni sugli elementi che possono essere memorizzati nei segreti, vedi la [documentazione Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/concepts/configuration/secret/).
{:shortdesc}

Esamina le seguenti attività che richiedono segreti.

### Aggiunta di un servizio a un cluster
{: #secrets_service}

Quando esegui il bind di un servizio a un cluster, non devi creare un segreto per memorizzare le tue credenziali del servizio. Viene creato automaticamente per te. Per ulteriori informazioni, vedi [Aggiunta di servizi Cloud Foundry ai cluster](cs_integrations.html#adding_cluster).

### Crittografia del traffico alle tue applicazione con i segreti TLS
{: #secrets_tls}

Il carico ALB bilancia il traffico di rete HTTP alle applicazioni nel tuo cluster. Per bilanciare anche il traffico delle connessioni HTTPS in entrata, puoi configurare l'ALB per decodificare il traffico di rete e inoltrare la richiesta decodificata alle applicazioni esposte nel tuo cluster. Per ulteriori informazioni, vedi la [documentazione sulla configurazione Ingress](cs_ingress.html#public_inside_3).

Inoltre, se hai applicazioni che richiedono il protocollo HTTPS e il traffico deve rimanere crittografato, puoi utilizzare i segreti di autenticazione unidirezionale o reciproca con l'annotazione `ssl-services`. Per ulteriori informazioni, vedi la [documentazione sulle annotazioni Ingress](cs_annotations.html#ssl-services).

### Accesso al tuo registro con le credenziali memorizzate in un `imagePullSecret` Kubernetes 
{: #imagepullsecret}

Quando crei un cluster, i segreti per le tue credenziali {{site.data.keyword.registrylong}} vengono creati automaticamente per te nello spazio dei nomi Kubernetes `default`. Tuttavia, devi [creare il tuo proprio imagePullSecret per il cluster](cs_images.html#other) se vuoi distribuire un contenitore nelle seguenti situazioni.
* Da un'immagine nel tuo registro {{site.data.keyword.registryshort_notm}} a uno spazio dei nomi Kubernetes diverso da `default`.
* Da un'immagine nel tuo registro {{site.data.keyword.registryshort_notm}} che è memorizzata in una diversa regione {{site.data.keyword.Bluemix_notm}} o in un diverso account {{site.data.keyword.Bluemix_notm}}.
* Da un'immagine che è memorizzata in un account {{site.data.keyword.Bluemix_notm}} dedicato.
* Da un'immagine che è memorizzata in un registro privato esterno.

<br />


## Crittografia dei segreti Kubernetes utilizzando {{site.data.keyword.keymanagementserviceshort}}
{: #keyprotect}

Puoi crittografare i tuoi segreti Kubernetes utilizzando [{{site.data.keyword.keymanagementservicefull}} ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](/docs/services/key-protect/index.html#getting-started-with-key-protect) come [provider KMS (key management service) ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/tasks/administer-cluster/kms-provider/) di Kubernetes nel tuo cluster. Il provider KMS è una funzione alpha in Kubernetes per le versioni 1.10 e 1.11.
{: shortdesc}

Per impostazione predefinita, i segreti Kubernetes vengono memorizzati su un disco crittografato nel componente `etcd` del master Kubernetes gestito da IBM. I tuoi nodi di lavoro hanno anche dischi secondari crittografati dalle chiavi LUKS gestite da IBM che sono memorizzate come segreti nel cluster. Quando abiliti {{site.data.keyword.keymanagementserviceshort}} nel tuo cluster, la tua chiave root viene utilizzata per crittografare i segreti Kubernetes, inclusi i segreti LUKS. Ottieni un maggiore controllo sui tuoi dati sensibili crittografando i segreti con la tua chiave root. L'uso della tua crittografia aggiunge un livello di sicurezza ai tuoi segreti Kubernetes e ti offre un controllo più dettagliato su chi può accedere alle informazioni sensibili sui cluster. Se hai bisogno di rimuovere in modo irreversibile l'accesso ai tuoi segreti, puoi eliminare la chiave root.

**Importante**: se elimini la chiave root nella tua istanza {{site.data.keyword.keymanagementserviceshort}}, in seguito non potrai accedere o rimuovere i dati dai segreti nel tuo cluster.

Prima di iniziare:
* [Accedi al tuo account. Specifica la regione appropriata e, se applicabile, il gruppo di risorse. Imposta il contesto per il tuo cluster](cs_cli_install.html#cs_cli_configure).
* Verifica che il cluster esegua Kubernetes versione 1.10.8_1524, 1.11.3_1521 o versioni successive, eseguendo `ibmcloud ks cluster-get --cluster <cluster_name_or_ID>` e controllando il campo **Versione**.
* Assicurati di avere le [autorizzazioni di **Amministratore**](cs_users.html#access_policies) per completare questi passi.
* Assicurati che la chiave API impostata per la regione in cui si trova il tuo cluster sia autorizzata a utilizzare Key Protect. Per controllare il proprietario della chiave API di cui sono state memorizzate le credenziali per la regione, esegui `ibmcloud ks api-key-info --cluster <cluster_name_or_ID>`.

Per abilitare {{site.data.keyword.keymanagementserviceshort}} o per aggiornare l'istanza o la chiave root che crittografa i segreti nel cluster:

1.  [Crea un'istanza {{site.data.keyword.keymanagementserviceshort}}](/docs/services/key-protect/provision.html#provision).

2.  Ottieni l'ID dell'istanza del servizio.

    ```
    ibmcloud resource service-instance <kp_instance_name> | grep GUID
    ```
    {: pre}

3.  [Crea una chiave root](/docs/services/key-protect/create-root-keys.html#create-root-keys). Per impostazione predefinita, la chiave root viene creata senza una data di scadenza.

    Devi impostare una data di scadenza per rispettare le politiche di sicurezza interne? [Crea la chiave root utilizzando l'API](/docs/services/key-protect/create-root-keys.html#api) e includi il parametro `expirationDate`. **Importante**: prima che la tua chiave root scada, devi ripetere questi passi per aggiornare il cluster in modo da utilizzare una nuova chiave root. In caso contrario, non puoi decrittografare i tuoi segreti.
    {: tip}

4.  Prendi nota dell'[**ID** della chiave root](/docs/services/key-protect/view-keys.html#gui).

5.  Richiama l'[endpoint {{site.data.keyword.keymanagementserviceshort}}](/docs/services/key-protect/regions.html#endpoints) della tua istanza.

6.  Ottieni il nome del cluster per il quale desideri abilitare {{site.data.keyword.keymanagementserviceshort}}.

    ```
    ibmcloud ks clusters
    ```
    {: pre}

7.  Abilita {{site.data.keyword.keymanagementserviceshort}} nel tuo cluster. Compila gli indicatori con le informazioni che hai precedentemente recuperato.

    ```
    ibmcloud ks key-protect-enable --cluster <cluster_name_or_ID> --key-protect-url <kp_endpoint> --key-protect-instance <kp_instance_ID> --crk <kp_root_key_ID>
    ```
    {: pre}

Una volta abilitato {{site.data.keyword.keymanagementserviceshort}} nel cluster, i segreti esistenti e i nuovi segreti che vengono creati nel cluster vengono automaticamente crittografati utilizzando la tua chiave root {{site.data.keyword.keymanagementserviceshort}}. Puoi ruotare la chiave in qualsiasi momento ripetendo questi passi con un nuovo ID della chiave root.
