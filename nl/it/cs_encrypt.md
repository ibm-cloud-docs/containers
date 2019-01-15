---

copyright:
  years: 2014, 2018
lastupdated: "2018-12-05"

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


# Protezione delle informazioni sensibili nel tuo cluster
{: #encryption}

Proteggi le informazioni sensibili del cluster per garantire l'integrità dei dati e impedire che i tuoi dati vengano esposti a utenti non autorizzati.
{: shortdesc}

Puoi creare dati sensibili su diversi livelli nel tuo cluster che richiedono ciascuno una protezione adeguata.
- **Livello di cluster:** i dati di configurazione del cluster vengono memorizzati nel componente etcd del tuo master Kubernetes. Nei cluster che eseguono Kubernetes versione 1.10 o successive, i dati in etcd sono memorizzati sul disco locale del master Kubernetes e vengono sottoposti a backup su {{site.data.keyword.cos_full_notm}}. I dati vengono crittografati durante il transito su {{site.data.keyword.cos_full_notm}} e quando inattivi. Puoi scegliere di abilitare la crittografia per i tuoi dati etcd sul disco locale del tuo master Kubernetes [abilitando la crittografia {{site.data.keyword.keymanagementservicelong_notm}}](cs_encrypt.html#encryption) per il tuo cluster. I dati etcd per i cluster che eseguono una versione precedente di Kubernetes sono memorizzati su un disco crittografato gestito da IBM e sottoposto a backup giornaliero.
- **Livello di applicazione:** quando distribuisci la tua applicazione, non memorizzare informazioni riservate, quali credenziali o chiavi, nel file di configurazione YAML, nelle mappe di configurazione o negli script. Utilizza invece i [segreti Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/concepts/configuration/secret/). Puoi anche [crittografare i dati nei segreti Kubernetes](#keyprotect) per impedire a utenti non autorizzati di accedere alle informazioni sensibili del cluster.

Per ulteriori informazioni sulla protezione del tuo cluster, vedi [Sicurezza per {{site.data.keyword.containerlong_notm}}](cs_secure.html#security).

![Panoramica della crittografia del cluster](images/cs_encrypt_ov.png)
_Figura: panoramica della crittografia dei dati in un cluster_

1.  **etcd**: etcd è il componente del master che memorizza i dati delle tue risorse Kubernetes, come i file `.yaml` di configurazione degli oggetti e i segreti. Nei cluster che eseguono Kubernetes versione 1.10 o successive, i dati in etcd sono memorizzati sul disco locale del master Kubernetes e vengono sottoposti a backup su {{site.data.keyword.cos_full_notm}}. I dati vengono crittografati durante il transito su {{site.data.keyword.cos_full_notm}} e quando inattivi. Puoi scegliere di abilitare la crittografia per i tuoi dati etcd sul disco locale del tuo master Kubernetes [abilitando la crittografia {{site.data.keyword.keymanagementservicelong_notm}}](#keyprotect) per il tuo cluster. I dati etcd nei cluster che eseguono una versione precedente di Kubernetes sono memorizzati su un disco crittografato gestito da IBM e sottoposto a backup giornaliero. Quando i dati etcd vengono inviati a un pod, i dati vengono crittografati tramite TLS per garantirne la protezione e l'integrità.
2.  **Disco secondario del nodo di lavoro**: il disco secondario del tuo nodo di lavoro è il luogo in cui sono memorizzati il file system del contenitore e le immagini estratte localmente. Il disco è crittografato con una chiave di crittografia LUKS che è univoca per il nodo di lavoro e memorizzata come segreto in etcd, gestito da IBM. Quando ricarichi o aggiorni i tuoi nodi di lavoro, le chiavi LUKS vengono ruotate.
3.  **Archiviazione**: puoi scegliere di memorizzare i dati [configurando l'archiviazione persistente di file, blocchi o oggetti](cs_storage_planning.html#persistent_storage_overview). Le istanze di archiviazione dell'infrastruttura IBM Cloud (SoftLayer) salvano i dati su dischi crittografati, quindi i tuoi dati inattivi vengono crittografati. Inoltre, se scegli l'archiviazione oggetti vengono crittografati anche i tuoi dati in transito.
4.  **Servizi {{site.data.keyword.Bluemix_notm}}**: puoi [integrare i servizi {{site.data.keyword.Bluemix_notm}}](cs_integrations.html#adding_cluster), come {{site.data.keyword.registryshort_notm}} o {{site.data.keyword.watson}}, con il tuo cluster. Le credenziali del servizio sono memorizzate in un segreto salvato in etcd, a cui la tua applicazione può accedere montando il segreto come volume o specificando il segreto come variabile di ambiente nella [tua distribuzione](cs_app.html#secret).
5.  **{{site.data.keyword.keymanagementserviceshort}}**: quando [abiliti {{site.data.keyword.keymanagementserviceshort}}](#keyprotect) nel tuo cluster, una chiave di crittografia dati (DEK) con wrapping viene memorizzata in etcd. La DEK crittografa i segreti nel tuo cluster, incluse le credenziali del servizio e la chiave LUKS. Poiché la chiave root si trova nella tua istanza {{site.data.keyword.keymanagementserviceshort}}, controlli l'accesso ai tuoi segreti crittografati. Per ulteriori informazioni su come funziona la crittografia {{site.data.keyword.keymanagementserviceshort}}, vedi [Crittografia envelope](/docs/services/key-protect/concepts/envelope-encryption.html#envelope-encryption).

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


## Crittografia del disco locale e dei segreti del master Kubernetes utilizzando {{site.data.keyword.keymanagementserviceshort}}
{: #keyprotect}

Puoi proteggere il componente etcd nel tuo master Kubernetes e nei segreti Kubernetes utilizzando [{{site.data.keyword.keymanagementservicefull}} ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](/docs/services/key-protect/index.html#getting-started-with-key-protect) come [provider KMS (key management service) ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/tasks/administer-cluster/kms-provider/) di Kubernetes nel tuo cluster. Il provider KMS è una funzione alpha in Kubernetes per le versioni 1.10 e 1.11.
{: shortdesc}

Per impostazione predefinita, la tua configurazione cluster e i segreti Kubernetes sono memorizzati nel componente etcd del master Kubernetes gestito da IBM. I tuoi nodi di lavoro hanno anche dischi secondari crittografati dalle chiavi LUKS gestite da IBM che sono memorizzate come segreti in etcd. Nei cluster che eseguono Kubernetes versione 1.10 o successive, i dati in etcd sono memorizzati sul disco locale del master Kubernetes e vengono sottoposti a backup su {{site.data.keyword.cos_full_notm}}. I dati vengono crittografati durante il transito su {{site.data.keyword.cos_full_notm}} e quando inattivi. Tuttavia, i dati nel tuo componente etcd sul disco locale del master Kubernetes non vengono crittografati automaticamente finché non abiliti la crittografia {{site.data.keyword.keymanagementserviceshort}} per il tuo cluster. I dati etcd per i cluster che eseguono una versione precedente di Kubernetes sono memorizzati su un disco crittografato gestito da IBM e sottoposto a backup giornaliero.

Quando abiliti {{site.data.keyword.keymanagementserviceshort}} nel tuo cluster, la tua chiave root viene utilizzata per crittografare i dati in etcd, inclusi i segreti LUKS. Ottieni un maggiore controllo sui tuoi dati sensibili crittografando i segreti con la tua chiave root. L'uso della tua propria crittografia aggiunge un livello di sicurezza ai tuoi dati etcd e segreti Kubernetes e ti offre un controllo più dettagliato su chi può accedere alle informazioni sensibili del cluster. Se hai bisogno di rimuovere in modo irreversibile l'accesso a etcd o ai tuoi segreti, puoi eliminare la chiave root.

Se elimini la chiave root nella tua istanza {{site.data.keyword.keymanagementserviceshort}}, in seguito non potrai accedere o rimuovere i dati in etcd o i dati dei segreti presenti nel tuo cluster.
{: important}

Prima di iniziare:
* [Accedi al tuo account. Specifica la regione appropriata e, se applicabile, il gruppo di risorse. Imposta il contesto per il tuo cluster](cs_cli_install.html#cs_cli_configure).
* Verifica che il cluster esegua Kubernetes versione 1.10.8_1524, 1.11.3_1521 o versioni successive, eseguendo `ibmcloud ks cluster-get --cluster <cluster_name_or_ID>` e controllando il campo **Versione**.
* Assicurati di disporre del [ruolo della piattaforma {{site.data.keyword.Bluemix_notm}} IAM **Amministratore**](cs_users.html#platform) per il cluster.
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

Una volta abilitato {{site.data.keyword.keymanagementserviceshort}} nel cluster, i dati in `etcd`, i segreti esistenti e i nuovi segreti che vengono creati nel cluster vengono crittografati automaticamente utilizzando la tua chiave root {{site.data.keyword.keymanagementserviceshort}}. Puoi ruotare la chiave in qualsiasi momento ripetendo questi passi con un nuovo ID della chiave root.
