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
{:tsSymptoms: .tsSymptoms}
{:tsCauses: .tsCauses}
{:tsResolve: .tsResolve}



# Risoluzione dei problemi dei cluster e dei nodi di lavoro
{: #cs_troubleshoot_clusters}

Mentre utilizzi {{site.data.keyword.containerlong}}, tieni presente queste tecniche per la risoluzione dei problemi dei tuoi cluster e nodi di lavoro.
{: shortdesc}

Se hai un problema più generale, prova a [eseguire il debug del cluster](cs_troubleshoot.html).
{: tip}

## Impossibile collegarsi al tuo account dell'infrastruttura
{: #cs_credentials}

{: tsSymptoms}
Quando crei un nuovo cluster Kubernetes, ricevi un messaggio di errore simile a uno dei seguenti.

```
We were unable to connect to your IBM Cloud infrastructure (SoftLayer) account.
Creating a standard cluster requires that you have either a
Pay-As-You-Go account that is linked to an IBM Cloud infrastructure (SoftLayer)
account term or that you have used the {{site.data.keyword.containerlong_notm}}
CLI to set your {{site.data.keyword.Bluemix_notm}} Infrastructure API keys.
```
{: screen}

```
{{site.data.keyword.Bluemix_notm}} Infrastructure Exception:
'Item' must be ordered with permission.
```
{: screen}

```
{{site.data.keyword.Bluemix_notm}} Infrastructure Exception:
The user does not have the necessary {{site.data.keyword.Bluemix_notm}}
Infrastructure permissions to add servers
```
{: screen}

{: tsCauses}
Gli account Pagamento a consumo di {{site.data.keyword.Bluemix_notm}} che sono stati creati dopo l'abilitazione del collegamento automatico degli account sono già configurati con l'accesso al portfolio dell'infrastruttura IBM Cloud (SoftLayer). Puoi acquistare le risorse dell'infrastruttura per il tuo cluster senza ulteriori configurazioni.

Gli utenti con altri tipi di account {{site.data.keyword.Bluemix_notm}} o quelli che hanno un account dell'infrastruttura IBM Cloud (SoftLayer) esistente non collegato al loro account {{site.data.keyword.Bluemix_notm}}, devono configurare i propri account per creare i cluster standard. 

Se hai un account Pagamento a consumo valido e ricevi questo messaggio di errore, è possibile che tu non stia utilizzando le credenziali dell'account dell'infrastruttura IBM Cloud (SoftLayer) corrette per accedere alle risorse dell'infrastruttura.

{: tsResolve}
Il proprietario dell'account deve configurare correttamente le credenziali dell'account dell'infrastruttura. Le credenziali dipendono dal tipo di account dell'infrastruttura che stai utilizzando.
*  Se hai un account {{site.data.keyword.Bluemix_notm}} Pagamento a consumo recente, l'account viene fornito con un account dell'infrastruttura collegato che puoi utilizzare.[Verifica che la chiave API dell'infrastruttura sia collegata con le autorizzazioni corrette](#apikey).
*  Se hai un tipo di account {{site.data.keyword.Bluemix_notm}} differente, verifica che puoi accedere al portfolio dell'infrastruttura e che [le credenziali dell'account dell'infrastruttura siano configurate con le autorizzazioni corrette](#credentials).

Per controllare se il tuo cluster utilizza l'account dell'infrastruttura collegato oppure un account dell'infrastruttura differente:
1.  Verifica di avere accesso a un account dell'infrastruttura. Esegui l'accesso alla [console {{site.data.keyword.Bluemix_notm}}![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://console.bluemix.net/) e, dal menu espandibile, fai clic su **Infrastruttura**. Se vedi il dashboard dell'infrastruttura, hai accesso a un account dell'infrastruttura.
2.  Controlla se il tuo cluster utilizza un account dell'infrastruttura differente. Dal menu espandibile, fai clic su **Contenitori > Cluster**.
3.  Dalla tabella, seleziona il tuo cluster. 
4.  Nella scheda **Panoramica**, se vedi un campo **Utente infrastruttura**, il cluster utilizza un account dell'infrastruttura diverso da quello fornito con il tuo account Pagamento a consumo

### Configurazione delle credenziali dell'API dell'infrastruttura per gli account collegati
{: #apikey}

1.  Verifica che l'utente di cui si vuoi utilizzare le credenziali per le azioni dell'infrastruttura disponga delle autorizzazioni corrette.

    1.  Accedi alla [console {{site.data.keyword.Bluemix_notm}}![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://console.bluemix.net/).
        
    2.  Dal menu che si espande, seleziona **Infrastruttura**.
        
    3.  Dalla barra dei menu, seleziona **Account** > **Utenti** > **Elenco utenti**.

    4.  Nella colonna **Chiave API**, verifica che l'utente abbia una chiave API oppure fai clic su **Genera**.

    5.  Verifica o assegna all'utente le [autorizzazioni di infrastruttura corrette](cs_users.html#infra_access).

2.  Reimposta la chiave API per la regione in cui si trova il cluster in modo che appartenga all'utente.
    
    1.  Accedi al terminale come utente corretto.
    
    2.  Reimposta la chiave API su questo utente.
        ```
        ibmcloud ks api-key-reset
        ```
        {: pre}    
    
    3.  Verifica che la chiave API sia impostata.
        ```
        ibmcloud ks api-key-info <cluster_name_or_ID>
        ```
        {: pre}
        
    4.  **Facoltativo**: se hai precedentemente impostato manualmente le credenziali con il comando `ibmcloud ks credentials-set`, rimuovi l'account dell'infrastruttura associato. Ora, la chiave API che hai impostato nei passi secondari precedenti viene utilizzata per ordinare l'infrastruttura.
        ```
        ibmcloud ks credentials-unset
        ```
        {: pre}

3.  **Facoltativo**: se connetti il tuo cluster pubblico a risorse in loco, controlla la tua connettività di rete.

    1.  Controlla la connettività della VLAN di lavoro. 
    2.  Se necessario, [imposta la connettività VPN](cs_vpn.html#vpn).
    3.  [Apri le porte richieste nel tuo firewall](cs_firewall.html#firewall).

### Configurazione delle credenziali dell'account dell'infrastruttura per i diversi account
{: #credentials}

1.  Ottieni l'account dell'infrastruttura che vuoi utilizzare per accedere al portfolio dell'infrastruttura IBM Cloud (SoftLayer). Hai diverse opzioni che dipendono dal tuo tipo di account corrente.

    <table summary="La tabella mostra le opzioni di creazione del cluster standard per tipo di account. Le righe devono essere lette da sinistra a destra, con la descrizione dell'account nella colonna uno e le opzioni per creare un cluster standard nella colonna due.">
    <caption>Opzioni di creazione del cluster standard per tipo di account</caption>
      <thead>
      <th>Descrizione dell'account</th>
      <th>Opzioni per creare un cluster standard</th>
      </thead>
      <tbody>
        <tr>
          <td>Gli **account Lite** non possono eseguire il provisioning dei cluster.</td>
          <td>[Aggiorna il tuo account Lite a un account Pagamento a consumo {{site.data.keyword.Bluemix_notm}}](/docs/account/index.html#paygo) che è configurato con l'accesso al portfolio dell'infrastruttura IBM Cloud (SoftLayer).</td>
        </tr>
        <tr>
          <td>Gli account **Pagamento a consumo recenti** sono forniti con l'accesso al portfolio dell'infrastruttura.</td>
          <td>Puoi creare dei cluster standard. Per risolvere i problemi relativi alle autorizzazioni dell'infrastruttura, vedi [Configurazione delle credenziali dell'API dell'infrastruttura per gli account collegati](#apikey).</td>
        </tr>
        <tr>
          <td>**Gli account Pagamento a consumo meno recenti** che erano stati creati prima che fosse disponibile il collegamento automatico degli account non erano forniti con l'accesso al portfolio dell'infrastruttura IBM Cloud (SoftLayer).<p>Se hai un account dell'infrastruttura IBM Cloud (SoftLayer) esistente, non puoi collegarlo a un vecchio account Pagamento a consumo.</p></td>
          <td><p><strong>Opzione 1: </strong> [Crea un nuovo account Pagamento a consumo](/docs/account/index.html#paygo) che è configurato con l'accesso al portfolio dell'infrastruttura IBM Cloud (SoftLayer). Se scegli questa opzione,
hai due account e fatture {{site.data.keyword.Bluemix_notm}}
separati.</p><p>Per continuare a utilizzare il tuo vecchio account Pagamento a consumo, puoi utilizzare il nuovo account Pagamento a consumo per generare una chiave API per accedere al portfolio dell'infrastruttura IBM Cloud (SoftLayer).</p><p><strong>Opzione 2:</strong> se hai già un account dell'infrastruttura IBM Cloud (SoftLayer) esistente che vuoi utilizzare, puoi impostare le credenziali nel tuo account {{site.data.keyword.Bluemix_notm}}.</p><p>**Nota:** quando colleghi manualmente un account dell'infrastruttura IBM Cloud (SoftLayer), le credenziali vengono utilizzate per ogni azione specifica nell'infrastruttura IBM Cloud (SoftLayer) nel tuo account {{site.data.keyword.Bluemix_notm}}. Devi assicurarti che la chiave API che hai inviato abbia [autorizzazioni dell'infrastruttura sufficienti](cs_users.html#infra_access) in modo che gli utenti possano creare e utilizzare i cluster.</p><p>**Per entrambe le opzioni, continua con il passo successivo**.</p></td>
        </tr>
        <tr>
          <td>**Gli account Sottoscrizione** non sono configurati con l'accesso al portfolio dell'infrastruttura IBM Cloud (SoftLayer).</td>
          <td><p><strong>Opzione 1: </strong> [Crea un nuovo account Pagamento a consumo](/docs/account/index.html#paygo) che è configurato con l'accesso al portfolio dell'infrastruttura IBM Cloud (SoftLayer). Se scegli questa opzione,
hai due account e fatture {{site.data.keyword.Bluemix_notm}}
separati.</p><p>Se vuoi continuare a utilizzare il tuo account Sottoscrizione, puoi utilizzare il nuovo account Pagamento a consumo per generare una chiave API nell'infrastruttura IBM Cloud (SoftLayer). Devi quindi impostare manualmente la chiave API dell'infrastruttura IBM Cloud (SoftLayer) per il tuo account Sottoscrizione. Ricorda che le risorse dell'infrastruttura IBM Cloud (SoftLayer) vengono fatturate attraverso il tuo nuovo account Pagamento a consumo.</p><p><strong>Opzione 2:</strong> se hai già un account dell'infrastruttura IBM Cloud (SoftLayer) esistente che vuoi utilizzare, puoi impostare manualmente le credenziali dell'infrastruttura IBM Cloud (SoftLayer) per il tuo account {{site.data.keyword.Bluemix_notm}}.</p><p>**Nota:** quando colleghi manualmente un account dell'infrastruttura IBM Cloud (SoftLayer), le credenziali vengono utilizzate per ogni azione specifica nell'infrastruttura IBM Cloud (SoftLayer) nel tuo account {{site.data.keyword.Bluemix_notm}}. Devi assicurarti che la chiave API che hai inviato abbia [autorizzazioni dell'infrastruttura sufficienti](cs_users.html#infra_access) in modo che gli utenti possano creare e utilizzare i cluster.</p><p>**Per entrambe le opzioni, continua con il passo successivo**.</p></td>
        </tr>
        <tr>
          <td>**Account dell'infrastruttura IBM Cloud (SoftLayer)**, nessun account {{site.data.keyword.Bluemix_notm}}</td>
          <td><p>[Crea un account Pagamento a consumo](/docs/account/index.html#paygo) che è configurato con l'accesso al portfolio dell'infrastruttura IBM Cloud (SoftLayer). Se scegli questa opzione, viene creato per te un account dell'infrastruttura IBM Cloud (SoftLayer). Hai la fatturazione e due account dell'infrastruttura IBM Cloud (SoftLayer) separati.</p><p>Per impostazione predefinita, il tuo nuovo account {{site.keyword.data.Bluemix_notm}} utilizza il nuovo account dell'infrastruttura. Per continuare a utilizzare il vecchio account dell'infrastruttura, continua con il passo successivo.</p></td>
        </tr>
      </tbody>
      </table>

2.  Verifica che l'utente di cui si vuoi utilizzare le credenziali per le azioni dell'infrastruttura disponga delle autorizzazioni corrette.

    1.  Accedi alla [console {{site.data.keyword.Bluemix_notm}}![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://console.bluemix.net/).
        
    2.  Dal menu che si espande, seleziona **Infrastruttura**.
        
    3.  Dalla barra dei menu, seleziona **Account** > **Utenti** > **Elenco utenti**.

    4.  Nella colonna **Chiave API**, verifica che l'utente abbia una chiave API oppure fai clic su **Genera**.

    5.  Verifica o assegna all'utente le [autorizzazioni di infrastruttura corrette](cs_users.html#infra_access).

3.  Imposta le credenziali dell'API dell'infrastruttura con l'utente per l'account corretto.

    1.  Ottieni le credenziali dell'API dell'infrastruttura dell'utente. **Nota**: le credenziali sono diverse dall'ID IBM.
            
        1.  Dalla tabella di [console {{site.data.keyword.Bluemix_notm}} ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://console.bluemix.net/) **Infrastruttura** > **Account** > **Utenti** > **Elenco utenti**, fai clic su **ID IBM o Nome utente**.
            
        2.  Nella sezione **Informazioni di accesso API**, visualizza il **Nome utente API** e la **Chiave di autenticazione**.    
        
    2.  Imposta le credenziali API dell'infrastruttura da utilizzare.
        ```
        ibmcloud ks credentials-set --infrastructure-username <infrastructure_API_username> --infrastructure-api-key <infrastructure_API_authentication_key>
  
4.  **Facoltativo**: se connetti il tuo cluster pubblico a risorse in loco, controlla la tua connettività di rete.

    1.  Controlla la connettività della VLAN di lavoro. 
    2.  Se necessario, [imposta la connettività VPN](cs_vpn.html#vpn).
    3.  [Apri le porte richieste nel tuo firewall](cs_firewall.html#firewall).

<br />


## Il firewall impedisce l'esecuzione dei comandi della CLI
{: #ts_firewall_clis}

{: tsSymptoms}
Quando esegui i comandi `ibmcloud`, `kubectl` o `calicoctl` dalla CLI, hanno esito negativo.

{: tsCauses}
Puoi avere delle politiche di rete aziendali che impediscono l'accesso dal tuo sistema locale agli endpoint pubblici tramite i proxy o i firewall

{: tsResolve}
[Consenti l'accesso TCP per il funzionamento dei comandi della CLI](cs_firewall.html#firewall). Questa attività richiede una [politica di accesso Amministratore](cs_users.html#access_policies). Verifica la tua [politica di accesso](cs_users.html#infra_access) corrente.


## Il firewall impedisce al cluster di collegarsi alle risorse
{: #cs_firewall}

{: tsSymptoms}
Quando i nodi di lavoro non possono collegarsi, potresti visualizzare molti sintomi diversi. Potresti visualizzare uno dei seguenti messaggi quando kubectl proxy ha esito negativo o tenti di accedere a un servizio nel tuo cluster e la connessione ha un malfunzionamento.

  ```
  Connection refused
  ```
  {: screen}

  ```
  Connection timed out
  ```
  {: screen}

  ```
  Impossibile collegarsi al server: net/http: timeout handshake TLS
  ```
  {: screen}

Se esegui kubectl exec, attach o logs, potresti visualizzare il seguente messaggio.

  ```
  Error from server: error dialing backend: dial tcp XXX.XXX.XXX:10250: getsockopt: connection timed out
  ```
  {: screen}

Se kubectl proxy ha esito positivo, ma il dashboard non è disponibile, potresti visualizzare il seguente messaggio.

  ```
  timeout on 172.xxx.xxx.xxx
  ```
  {: screen}



{: tsCauses}
Potresti aver configurato un altro firewall o personalizzato le tue impostazioni firewall esistenti nel tuo account dell'infrastruttura IBM Cloud (SoftLayer). {{site.data.keyword.containershort_notm}}
richiede che alcuni indirizzi IP e porte siano aperti per consentire la comunicazione dal nodo di lavoro al master Kubernetes e viceversa. Un altro motivo potrebbe essere che i tuoi nodi di lavoro sono bloccati in un loop di ricaricamento.

{: tsResolve}
[Consenti al cluster di accedere alle risorse dell'infrastruttura e ad altri servizi](cs_firewall.html#firewall_outbound). Questa attività richiede una [politica di accesso Amministratore](cs_users.html#access_policies). Verifica la tua [politica di accesso](cs_users.html#infra_access) corrente.

<br />



## L'accesso al tuo nodo di lavoro con SSH non riesce
{: #cs_ssh_worker}

{: tsSymptoms}
Non è possibile accedere al tuo nodo di lavoro utilizzando una connessione SSH.

{: tsCauses}
SSH tramite password non è disponibile sui nodi di lavoro.

{: tsResolve}
Utilizza le [Serie daemon ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) per le azioni che devi eseguire su ogni nodo oppure utilizza i lavori per le azioni a singola ricorrenza che devi eseguire.

<br />


## L'ID dell'istanza bare metal non è congruente con i record di lavoro
{: #bm_machine_id}

{: tsSymptoms}
Quando utilizzi i comandi `ibmcloud ks worker` con il nodo di lavoro bare metal, vedi un messaggio simile al seguente.

```
Instance ID inconsistent with worker records
```
{: screen}

{: tsCauses}
L'ID macchina può diventare incongruente con il record di lavoro {{site.data.keyword.containershort_notm}} quando la macchina riscontra dei problemi hardware. Quando l'infrastruttura IBM Cloud (SoftLayer) risolve questo problema, un componente può subire delle variazioni all'interno del sistema che il servizio non identifica.

{: tsResolve}
Perché {{site.data.keyword.containershort_notm}} identifichi nuovamente la macchina, [ricarica il nodo di lavoro bare metal](cs_cli_reference.html#cs_worker_reload). **Nota**: il ricaricamento aggiorna anche la [versione patch](cs_versions_changelog.html) della macchina.

Puoi anche [eliminare il nodo di lavoro bare metal](cs_cli_reference.html#cs_cluster_rm). **Nota**: le istanze bare metal vengono fatturate mensilmente.

<br />


## `kubectl exec` e `kubectl logs` non funzionano
{: #exec_logs_fail}

{: tsSymptoms}
Se esegui `kubectl exec` o `kubectl logs`, visualizzi il seguente messaggio.

  ```
  <workerIP>:10250: getsockopt: connection timed out
  ```
  {: screen}

{: tsCauses}
La connessione OpenVPN tra il nodo master e i nodi di lavoro non funziona correttamente.

{: tsResolve}
1. Abilita lo [spanning delle VLAN](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) per il tuo account dell'infrastruttura IBM Cloud (SoftLayer).
2. Riavvia il pod client OpenVPN.
  ```
  kubectl delete pod -n kube-system -l app=vpn
  ```
  {: pre}
3. Se ancora visualizzi lo stesso messaggio di errore, il nodo di lavoro su cui è il pod VPN potrebbe non essere integro. Per riavviare il pod VPN e ripianificarlo su un nodo di lavoro diverso, [delimita, trascina e riavvia il nodo di lavoro](cs_cli_reference.html#cs_worker_reboot) su cui è il pod VPN.

<br />


## L'associazione di un servizio a un cluster provoca un errore di stessa denominazione
{: #cs_duplicate_services}

{: tsSymptoms}
Quando esegui `ibmcloud ks cluster-service-bind <cluster_name> <namespace> <service_instance_name>`, visualizzi il seguente messaggio.

```
Multiple services with the same name were found.
Run 'ibmcloud service list' to view available Bluemix service instances...
```
{: screen}

{: tsCauses}
Più istanze del servizio potrebbero avere lo stesso nome in regioni differenti.

{: tsResolve}
Utilizza il GUID del servizio invece del nome dell'istanza del servizio nel comando `ibmcloud ks cluster-service-bind`.

1. [Accedi alla regione che include l'istanza del servizio da associare.](cs_regions.html#bluemix_regions)

2. Ottieni il GUID per l'istanza del servizio.
  ```
  ibmcloud service show <service_instance_name> --guid
  ```
  {: pre}

  Output:
  ```
  Invoking 'cf service <service_instance_name> --guid'...
  <service_instance_GUID>
  ```
  {: screen}
3. Associa nuovamente il servizio al cluster.
  ```
  ibmcloud ks cluster-service-bind <cluster_name> <namespace> <service_instance_GUID>
  ```
  {: pre}

<br />


## L'associazione di un servizio a un cluster provoca un errore di non trovato
{: #cs_not_found_services}

{: tsSymptoms}
Quando esegui `ibmcloud ks cluster-service-bind <cluster_name> <namespace> <service_instance_name>`, visualizzi il seguente messaggio.

```
Binding service to a namespace...
FAILED

The specified IBM Cloud service could not be found. If you just created the service, wait a little and then try to bind it again. To view available IBM Cloud service instances, run 'ibmcloud service list'. (E0023)
```
{: screen}

{: tsCauses}
Per associare i servizi a un cluster, devi avere il ruolo utente di sviluppatore Cloud Foundry per lo spazio in cui è stato eseguito il provisioning dell'istanza del servizio. Inoltre, devi avere l'accesso da editor IAM a {{site.data.keyword.containerlong}}. Per accedere all'istanza del servizio, devi aver eseguito il login allo spazio in cui è stato eseguito il provisioning dell'istanza del servizio.

{: tsResolve}

**Come utente:**

1. Accedi a {{site.data.keyword.Bluemix_notm}}.
   ```
   ibmcloud login
   ```
   {: pre}

2. Specifica l'organizzazione e lo spazio in cui viene eseguito il provisioning dell'istanza del servizio.
   ```
   ibmcloud target -o <org> -s <space>
   ```
   {: pre}

3. Verifica di essere nello spazio corretto elencando le tue istanze del servizio.
   ```
   ibmcloud service list
   ```
   {: pre}

4. Riprova ad associare il servizio. Se ricevi lo stesso messaggio di errore, contatta l'amministratore dell'account e verifica di avere le autorizzazioni necessarie per associare i servizi (consulta la seguente procedura di gestione dell'account).

**Come amministratore dell'account:**

1. Verifica che l'utente che ha riscontrato questo problema abbia le [autorizzazioni di editor per {{site.data.keyword.containerlong}}](/docs/iam/mngiam.html#editing-existing-access).

2. Verifica che l'utente che ha riscontrato questo problema abbia il [ruolo di sviluppatore Cloud Foundry dello spazio](/docs/iam/mngcf.html#updating-cloud-foundry-access) in cui è stato eseguito il provisioning del servizio.

3. Se le autorizzazioni sono corrette, prova ad assegnare un'autorizzazione differente e riassegna l'autorizzazione necessaria.

4. Attendi alcuni minuti, quindi consenti all'utente di riprovare l'associazione al servizio.

5. Se questo non risolve il problema, le autorizzazioni IAM non sono sincronizzate e non puoi risolvere il problema da solo. [Contatta il supporto IBM](/docs/get-support/howtogetsupport.html#getting-customer-support) aprendo un ticket di supporto. Assicurati di fornire l'ID cluster, l'ID utente e l'ID istanza del servizio.
   1. Richiama l'ID cluster.
      ```
      ibmcloud ks clusters
      ```
      {: pre}

   2. Richiama l'ID istanza del servizio.
      ```
      ibmcloud service show <service_name> --guid
      ```
      {: pre}


<br />



## Dopo aver aggiornato o ricaricato un nodo di lavoro, vengono visualizzati i pod e i nodi duplicati
{: #cs_duplicate_nodes}

{: tsSymptoms}
Quando esegui `kubectl get nodes` visualizzi i nodi di lavoro duplicati con la condizione **NotReady**. I nodi di lavoro con la condizione **NotReady** hanno indirizzi IP pubblici, mentre i nodi di lavoro con **Ready** hanno indirizzi IP privati.

{: tsCauses}
I cluster meno recenti hanno i nodi di lavoro elencati per indirizzo IP pubblico del cluster. Ora, i nodi di lavoro sono elencati per indirizzo IP privato del cluster. Quando ricarichi o aggiorni un nodo, l'indirizzo IP viene modificato, ma il riferimento all'indirizzo IP pubblico rimane.

{: tsResolve}
Il servizio non viene interrotto a causa di questi duplicati ma puoi rimuovere i riferimenti al nodo di lavoro precedente dal server API.

  ```
  kubectl delete node <node_name1> <node_name2>
  ```
  {: pre}

<br />


## L'accesso a un pod su un nodo di lavoro non è riuscito a causa di un timeout
{: #cs_nodes_duplicate_ip}

{: tsSymptoms}
Hai eliminato un nodo di lavoro nel tuo cluster e quindi aggiunto un nodo di lavoro. Quando distribuisci un pod o un servizio Kubernetes, la risorsa non può accedere al nodo di lavoro appena creato e la connessione va in timeout.

{: tsCauses}
Se elimini un nodo di lavoro dal tuo cluster e quindi ne aggiungi un altro, è possibile che al nuovo nodo di lavoro venga assegnato l'indirizzo IP privato nel nodo di lavoro eliminato. Calico utilizza questo indirizzo IP come una tag e continua a provare a raggiungere il nodo eliminato.

{: tsResolve}
Aggiorna manualmente i riferimenti all'indirizzo IP privato in modo che puntino al nodo corretto.

1.  Conferma di avere due nodi di lavoro con lo stesso indirizzo **IP privato**. Prendi nota di **IP privato** e **ID** del nodo di lavoro eliminato.

  ```
  ibmcloud ks workers <CLUSTER_NAME>
  ```
  {: pre}

  ```
  ID                                                 Public IP       Private IP       Machine Type   State     Status   Zone   Version
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w1   169.xx.xxx.xxx  10.xxx.xx.xxx    b2c.4x16       normal    Ready    dal10      1.10.5
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w2   169.xx.xxx.xxx  10.xxx.xx.xxx    b2c.4x16       deleted    -       dal10      1.10.5
  ```
  {: screen}

2.  Installa la [CLI Calico](cs_network_policy.html#adding_network_policies).
3.  Elenca i nodi di lavoro disponibili in Calico. Sostituisci <path_to_file> con il percorso locale al file di configurazione Calico.

  ```
  calicoctl get nodes --config=filepath/calicoctl.cfg
  ```
  {: pre}

  ```
  NAME
  kube-dal10-cr9b7371a7faaa46d08e04f046d5e6d8b4-w1
  kube-dal10-cr9b7371a7faaa46d08e04f046d5e6d8b4-w2
  ```
  {: screen}

4.  Elimina il nodo di lavoro duplicato in Calico. Sostituisci NODE_ID con l'ID del nodo di lavoro.

  ```
  calicoctl delete node NODE_ID --config=<path_to_file>/calicoctl.cfg
  ```
  {: pre}

5.  Riavvia il nodo di lavoro che non è stato eliminato.

  ```
  ibmcloud ks worker-reboot CLUSTER_ID NODE_ID
  ```
  {: pre}


Il nodo di lavoro non è più elencato in Calico.

<br />




## La distribuzione dei pod non riesce a causa di una politica di sicurezza dei pod
{: #cs_psp}

{: tsSymptoms}
Dopo la creazione di un pod o l'esecuzione di `kubectl get events` per controllare una distribuzione del pod, vedi un messaggio di errore simile al seguente.

```
unable to validate against any pod security policy
```
{: screen}

{: tsCauses}
[Il controller di ammissione `PodSecurityPolicy` ](cs_psp.html)controlla l'autorizzazione dell'account utente o di servizio, come ad esempio una distribuzione o un tiller Helm, che ha tentato di creare il pod. Se nessuna politica di sicurezza dei pod supporta l'account utente o di servizio, il controller di ammissione ` PodSecurityPolicy` impedisce la creazione dei pod.

Se hai eliminato una delle risorse della politica di sicurezza dei pod per [la gestione del cluster {{site.data.keyword.IBM_notm}}](cs_psp.html#ibm_psp), potresti riscontrare problemi simili.

{: tsResolve}
Assicurati che l'account utente o di servizio sia autorizzato da una politica di sicurezza dei pod. Potresti dover [modificare una politica esistente](cs_psp.html#customize_psp).

Se hai eliminato una risorsa di gestione del cluster {{site.data.keyword.IBM_notm}}, aggiorna il master Kubernetes per ripristinarla.

1.  [Indirizza la tua CLI](cs_cli_install.html#cs_cli_configure) al tuo cluster.
2.  Aggiorna il master Kubernetes per eseguirne il ripristino.

    ```
    ibmcloud ks apiserver-refresh
    ```
    {: pre}


<br />




## Il cluster rimane nello stato In sospeso
{: #cs_cluster_pending}

{: tsSymptoms}
Quando distribuisci il cluster, rimane in uno stato in sospeso e non si avvia.

{: tsCauses}
Se hai appena creato il cluster, i nodi di lavoro potrebbero essere ancora in fase di configurazione. Se hai già atteso per un po', potresti avere una VLAN non valida.

{: tsResolve}

Puoi provare una delle seguenti soluzioni:
  - Controlla lo stato del tuo cluster eseguendo `ibmcloud ks clusters`. Quindi verifica che i nodi di lavoro siano distribuiti eseguendo `ibmcloud ks workers <cluster_name>`.
  - Controlla se la tua VLAN è valida. Perché sia valida, una VLAN deve essere associata a un'infrastruttura in grado di ospitare un nodo di lavoro con archiviazione su disco locale. Puoi [elencare le tue VLAN](/docs/containers/cs_cli_reference.html#cs_vlans) eseguendo `ibmcloud ks vlans <zone>` se la VLAN non viene visualizzata nell'elenco significa che non è valida. Scegli una VLAN diversa.

<br />


## I pod rimangono nello stato in sospeso
{: #cs_pods_pending}

{: tsSymptoms}
Quando esegui `kubectl get pods`, puoi visualizzare i pod
che rimangono in uno stato **In sospeso**.

{: tsCauses}
Se hai appena creato il cluster Kubernetes, i nodi di lavoro potrebbero essere ancora in fase di configurazione. Se questo cluster è un cluster che già esiste, potresti non avere abbastanza capacità nel tuo cluster per distribuire il pod.

{: tsResolve}
Questa attività richiede una [politica di accesso Amministratore](cs_users.html#access_policies). Verifica la tua [politica di accesso](cs_users.html#infra_access) corrente.

Se hai appena creato il cluster Kubernetes, immetti il seguente comando e attendi che il nodo
di lavoro venga inizializzato.

```
kubectl get nodes
```
{: pre}

Se questo cluster è un cluster che già esiste, controlla la capacità del tuo cluster.

1.  Imposta il proxy con il numero di porta predefinito.

  ```
  kubectl proxy
  ```
   {: pre}

2.  Apri il dashboard Kubernetes.

  ```
  http://localhost:8001/ui
  ```
  {: pre}

3.  Controlla di avere abbastanza capacità nel tuo cluster per distribuire il tuo pod.

4.  Se non hai abbastanza capacità nel tuo cluster, ridimensiona il tuo pool di nodi di lavoro per aggiungere ulteriori nodi.

    1.  Esamina le dimensioni e i tipi di macchina attuali dei tuoi pool di nodi di lavoro per decidere quale ridimensionare.

        ```
        ibmcloud ks worker-pools
        ```
        {: pre}

    2.  Ridimensiona i tuoi pool di nodi di lavoro per aggiungere ulteriori nodi a ciascuna zona a cui si estende il pool.

        ```
        ibmcloud ks worker-pool-resize <worker_pool> --cluster <cluster_name_or_ID> --size-per-zone <workers_per_zone>
        ```
        {: pre}

5.  Se i tuoi pod sono ancora nello stato **in attesa** dopo che il nodo di lavoro è stato completamente distribuito,
controlla la [ Documentazione Kubernetes
![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/tasks/debug-application-cluster/debug-pod-replication-controller/#my-pod-stays-pending) per ulteriore risoluzione dei problemi sullo stato in attesa del tuo pod.

<br />




## I contenitori non si avviano
{: #containers_do_not_start}

{: tsSymptoms}
I pod sono stati distribuiti correttamente ai cluster, ma i contenitori non sono avviati.

{: tsCauses}
I contenitori potrebbero non essere stati avviati quando è stata raggiunta la quota del registro.

{: tsResolve}
[Libera archiviazione in {{site.data.keyword.registryshort_notm}}.](../services/Registry/registry_quota.html#registry_quota_freeup)

<br />



## Impossibile installare un grafico Helm con valori di configurazione aggiornati
{: #cs_helm_install}

{: tsSymptoms}
Quando tenti di installare un grafico Helm aggiornato eseguendo `helm install -f config.yaml --namespace=kube-system --name=<release_name> ibm/<chart_name>`, ricevi il messaggio di errore `Error: failed to download "ibm/<chart_name>"`.

{: tsCauses}
L'URL per il repository {{site.data.keyword.Bluemix_notm}} nella tua istanza Helm potrebbe non essere corretto.

{: tsResolve}
Per risolvere i problemi relativi al tuo grafico Helm:

1. Elenca i repository attualmente disponibili nella tua istanza Helm.

    ```
    helm repo list
    ```
    {: pre}

2. Nell'output, verifica che l'URL per il repository {{site.data.keyword.Bluemix_notm}}, `ibm`, sia `https://registry.bluemix.net/helm/ibm`.

    ```
    NAME    URL
    stable  https://kubernetes-charts.storage.googleapis.com
    local   http://127.0.0.1:8888/charts
    ibm     https://registry.bluemix.net/helm/ibm
    ```
    {: screen}

    * Se l'URL non è corretto:

        1. Rimuovi il repository {{site.data.keyword.Bluemix_notm}}.

            ```
            helm repo remove ibm
            ```
            {: pre}

        2. Aggiungi di nuovo il repository {{site.data.keyword.Bluemix_notm}}.

            ```
            helm repo add ibm  https://registry.bluemix.net/helm/ibm
            ```
            {: pre}

    * Se l'URL è corretto, ottieni gli ultimi aggiornamenti dal repository.

        ```
        helm repo update
        ```
        {: pre}

3. Installa il grafico Helm con i tuoi aggiornamenti.

    ```
    helm install -f config.yaml --namespace=kube-system --name=<release_name> ibm/<chart_name>
    ```
    {: pre}

<br />


## Come ottenere aiuto e supporto
{: #ts_getting_help}

Stai ancora avendo problemi con il tuo cluster?
{: shortdesc}

-   Per vedere se {{site.data.keyword.Bluemix_notm}} è disponibile, [controlla la pagina sugli stati {{site.data.keyword.Bluemix_notm}} ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://developer.ibm.com/bluemix/support/#status).
-   Pubblica una domanda in [{{site.data.keyword.containershort_notm}} Slack ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://ibm-container-service.slack.com).

    Se non stai utilizzando un ID IBM per il tuo account {{site.data.keyword.Bluemix_notm}}, [richiedi un invito](https://bxcs-slack-invite.mybluemix.net/) a questo Slack.
    {: tip}
-   Rivedi i forum per controllare se altri utenti hanno riscontrato gli stessi problemi. Quando utilizzi i forum per fare una domanda, contrassegna con una tag la tua domanda in modo che sia visualizzabile dai team di sviluppo {{site.data.keyword.Bluemix_notm}}.

    -   Se hai domande tecniche sullo sviluppo o la distribuzione di cluster o applicazioni con
{{site.data.keyword.containershort_notm}}, inserisci la tua domanda in
[Stack Overflow ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://stackoverflow.com/questions/tagged/ibm-cloud+containers) e contrassegnala con le tag `ibm-cloud`, `kubernetes` e `containers`.
    -   Per domande sul servizio e sulle istruzioni per l'utilizzo iniziale, utilizza il forum
[IBM developerWorks dW Answers ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://developer.ibm.com/answers/topics/containers/?smartspace=bluemix). Includi le tag `ibm-cloud`
e `containers`.
    Consulta [Come ottenere supporto](/docs/get-support/howtogetsupport.html#using-avatar) per ulteriori dettagli sull'utilizzo dei forum.

-   Contatta il supporto IBM aprendo un ticket. Per informazioni su come aprire un ticket di supporto IBM o sui livelli di supporto e sulla gravità dei ticket, consulta [Come contattare il supporto](/docs/get-support/howtogetsupport.html#getting-customer-support).

{: tip}
Quando riporti un problema, includi il tuo ID del cluster. Per ottenere il tuo ID del cluster, esegui `ibmcloud ks clusters`.

