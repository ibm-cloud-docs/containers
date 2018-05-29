---

copyright:
  years: 2014, 2018
lastupdated: "2018-4-20"

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
Quando crei un nuovo cluster Kubernetes, ricevi il seguente messaggio.

```
We were unable to connect to your IBM Cloud infrastructure (SoftLayer) account.
Creating a standard cluster requires that you have either a Pay-As-You-Go account
that is linked to an IBM Cloud infrastructure (SoftLayer) account term or that you have used the {{site.data.keyword.Bluemix_notm}}
Container Service CLI to set your {{site.data.keyword.Bluemix_notm}} Infrastructure API keys.
```
{: screen}

{: tsCauses}
Gli utenti con un account {{site.data.keyword.Bluemix_notm}} non collegato, devono creare un nuovo account Pagamento a consumo o aggiungere manualmente le chiavi API dell'infrastruttura IBM Cloud (SoftLayer) utilizzando la CLI {{site.data.keyword.Bluemix_notm}}.

{: tsResolve}
Per aggiungere le credenziali al tuo account {{site.data.keyword.Bluemix_notm}}:

1.  Contattata l'amministratore della tua infrastruttura IBM Cloud (SoftLayer) per ottenere il tuo nome utente e chiave API.

    **Nota:** l'account dell'infrastruttura IBM Cloud (SoftLayer) da te utilizzato deve essere configurato con autorizzazioni di SuperUser per creare correttamente i cluster standard.

2.  Aggiungi le credenziali.

  ```
  bx cs credentials-set --infrastructure-username <username> --infrastructure-api-key <api_key>
  ```
  {: pre}

3.  Crea un cluster standard.

  ```
  bx cs cluster-create --location dal10 --public-vlan my_public_vlan_id --private-vlan my_private_vlan_id --machine-type u2c.2x4 --name my_cluster --hardware shared --workers 2
  ```
  {: pre}

<br />


## Il firewall impedisce l'esecuzione dei comandi della CLI
{: #ts_firewall_clis}

{: tsSymptoms}
Quando esegui i comandi `bx`, `kubectl` o `calicoctl` dalla CLI, hanno esito negativo.

{: tsCauses}
Puoi avere delle politiche di rete aziendali che impediscono l'accesso dal tuo sistema locale agli endpoint pubblici tramite i proxy o i firewall

{: tsResolve}
[Consenti l'accesso TCP per il funzionamento dei comandi della CLI](cs_firewall.html#firewall). Questa attività richiede una [politica di accesso Amministratore](cs_users.html#access_policies). Verifica la tua [politica di accesso](cs_users.html#infra_access) corrente.


## Il firewall impedisce al cluster di collegarsi alle risorse
{: #cs_firewall}

{: tsSymptoms}
Quando il nodo di lavoro non può collegarsi, potresti visualizzare molti sintomi diversi. Potresti visualizzare uno dei seguenti messaggi quando kubectl proxy ha esito negativo o tenti di accedere a un servizio nel tuo cluster e la connessione ha un malfunzionamento.

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
Potresti aver configurato un firewall aggiuntivo o personalizzato le tue impostazioni firewall esistenti nel tuo account dell'infrastruttura IBM Cloud (SoftLayer). {{site.data.keyword.containershort_notm}}
richiede che alcuni indirizzi IP e porte siano aperti per consentire la comunicazione dal nodo di lavoro al master Kubernetes e viceversa. Un altro motivo potrebbe essere che i tuoi nodi di lavoro sono bloccati in un loop di ricaricamento.

{: tsResolve}
[Consenti al cluster di accedere alle risorse dell'infrastruttura e ad altri servizi](cs_firewall.html#firewall_outbound). Questa attività richiede una [politica di accesso Amministratore](cs_users.html#access_policies). Verifica la tua [politica di accesso](cs_users.html#infra_access) corrente.

<br />



## L'accesso al tuo nodo di lavoro con SSH non riesce
{: #cs_ssh_worker}

{: tsSymptoms}
Non è possibile accedere al tuo nodo di lavoro utilizzando la connessione SSH.

{: tsCauses}
SSH tramite password è disabilitata per i nodi di lavoro.

{: tsResolve}
Utilizza le [Serie daemon
![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/)per qualsiasi operazione che devi eseguire su ogni nodo o lavoro
per qualsiasi azione monouso che devi eseguire.

<br />



## L'associazione di un servizio a un cluster provoca un errore di stessa denominazione
{: #cs_duplicate_services}

{: tsSymptoms}
Quando esegui `bx cs cluster-service-bind <cluster_name> <namespace> <service_instance_name>` visualizzi il seguente messaggio.

```
Multiple services with the same name were found.
Run 'bx service list' to view available Bluemix service instances...
```
{: screen}

{: tsCauses}
Più istanze del servizio potrebbero avere lo stesso nome in regioni differenti.

{: tsResolve}
Utilizza la GUI del servizio invece del nome dell'istanza del servizio nel comando `bx cs cluster-service-bind`.

1. [Accedi alla regione che include l'istanza del servizio da associare.](cs_regions.html#bluemix_regions)

2. Ottieni il GUID per l'istanza del servizio.
  ```
  bx service show <service_instance_name> --guid
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
  bx cs cluster-service-bind <cluster_name> <namespace> <service_instance_GUID>
  ```
  {: pre}

<br />



## Dopo aver aggiornato o ricaricato un nodo di lavoro, vengono visualizzati i pod e i nodi duplicati
{: #cs_duplicate_nodes}

{: tsSymptoms}
Quando esegui `kubectl get nodes` visualizzi i nodi di lavoro duplicati con lo stato **NotReady**. I nodi di lavoro con lo stato **NotReady** hanno indirizzi IP pubblici, mentre i nodi di lavoro con **Ready** hanno indirizzi IP privati.

{: tsCauses}
I cluster meno recenti avevano i nodi di lavoro elencati per indirizzo IP pubblico del cluster. Ora, i nodi di lavoro sono elencati per indirizzo IP privato del cluster. Quando ricarichi o aggiorni un nodo, l'indirizzo IP viene modificato, ma il riferimento all'indirizzo IP pubblico rimane.

{: tsResolve}
Non sono presenti interruzioni del servizio dovute a questi duplicati, ma devi rimuovere i riferimenti al nodo di lavoro precedente dal server API.

  ```
  kubectl delete node <node_name1> <node_name2>
  ```
  {: pre}

<br />


## Dopo aver aggiornato o ricaricato un nodo di lavoro, le applicazioni ricevono errori RBAC DENY
{: #cs_rbac_deny}

{: tsSymptoms}
Dopo aver eseguito l'aggiornamento a Kubernetes versione 1.7, le applicazioni ricevono errori `RBAC DENY`.

{: tsCauses}
A partire da [Kubernetes versione 1.7](cs_versions.html#cs_v17), le applicazioni eseguite nello spazio dei nomi `default` non dispongono più di privilegi di amministratore del cluster sull'API Kubernetes per la sicurezza avanzata. 

Se la tua applicazione viene eseguita nello spazio dei nomi `default`, usa `default ServiceAccount` e accedi all'API Kubernetes, è influenzata da questa modifica di Kubernetes. Per ulteriori informazioni, consulta [la documentazione Kubernetes![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/admin/authorization/rbac/#upgrading-from-15).

{: tsResolve}
Prima di iniziare, [indirizza la tua CLI](cs_cli_install.html#cs_cli_configure) al tuo cluster.

1.  **Azione temporanea**: quando aggiorni le politiche RBAC della tua applicazione, potresti voler ripristinare temporaneamente i valori precedenti di `ClusterRoleBinding` per `default ServiceAccount` nello spazio dei nomi `default`.

    1.  Copia il seguente file `.yaml`.

        ```yaml
        kind: ClusterRoleBinding
        apiVersion: rbac.authorization.k8s.io/v1beta1
        metadata:
         name: admin-binding-nonResourceURLSs-default
        subjects:
          - kind: ServiceAccount
            name: default
            namespace: default
        roleRef:
         kind: ClusterRole
         name: admin-role-nonResourceURLSs
         apiGroup: rbac.authorization.k8s.io
        ---
        kind: ClusterRoleBinding
        apiVersion: rbac.authorization.k8s.io/v1beta1
        metadata:
         name: admin-binding-resourceURLSs-default
        subjects:
          - kind: ServiceAccount
            name: default
            namespace: default
        roleRef:
         kind: ClusterRole
         name: admin-role-resourceURLSs
         apiGroup: rbac.authorization.k8s.io
        ```

    2.  Applica i file `.yaml` al tuo cluster.

        ```
        kubectl apply -f FILENAME
        ```
        {: pre}

2.  [Crea le risorse di autorizzazione RBAC![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/admin/authorization/rbac/#api-overview) per aggiornare l'accesso di amministratore `ClusterRoleBinding`.

3.  Se hai creato un bind temporaneo del ruolo cluster, rimuovilo. 

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
  bx cs workers <CLUSTER_NAME>
  ```
  {: pre}

  ```
  ID                                                 Public IP       Private IP       Machine Type   State     Status   Location   Version
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w1   169.xx.xxx.xxx  10.xxx.xx.xxx    b2c.4x16       normal    Ready    dal10      1.8.11
  kube-dal10-cr9b7371a7fcbe46d08e04f046d5e6d8b4-w2   169.xx.xxx.xxx  10.xxx.xx.xxx    b2c.4x16       deleted    -       dal10      1.8.11
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
  bx cs worker-reboot CLUSTER_ID NODE_ID
  ```
  {: pre}


Il nodo di lavoro non è più elencato in Calico.

<br />


## Il cluster rimane nello stato In sospeso
{: #cs_cluster_pending}

{: tsSymptoms}
Quando distribuisci il cluster, rimane in uno stato in sospeso e non si avvia.

{: tsCauses}
Se hai appena creato il cluster, i nodi di lavoro potrebbero essere ancora in fase di configurazione. Se sei rimasto in attesa per un po', potresti avere una VLAN non valida.

{: tsResolve}

Puoi provare una delle seguenti soluzioni:
  - Controlla lo stato del tuo cluster eseguendo `bx cs clusters`. Quindi verifica che i nodi di lavoro siano distribuiti eseguendo `bx cs workers <cluster_name>`.
  - Controlla se la tua VLAN è valida. Perché sia valida, una VLAN deve essere associata a un'infrastruttura in grado di ospitare un nodo di lavoro con archiviazione su disco locale. Puoi [elencare le tue VLAN](/docs/containers/cs_cli_reference.html#cs_vlans) eseguendo `bx cs vlans LOCATION`; se la VLAN non viene visualizzata nell'elenco significa che non è valida. Scegli una VLAN diversa.

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

4.  Se non hai abbastanza capacità nel tuo cluster, aggiungi un altro nodo di lavoro al cluster.

  ```
  bx cs worker-add <cluster_name_or_ID> 1
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
-   Pubblica una domanda in [{{site.data.keyword.containershort_notm}} Slack. ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://ibm-container-service.slack.com)
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

-   Contatta il supporto IBM aprendo un ticket. Per informazioni su come aprire un ticket di supporto IBM o sui livelli di supporto e sulla gravità dei ticket,
consulta [Come contattare il supporto](/docs/get-support/howtogetsupport.html#getting-customer-support).

{:tip}
Quando riporti un problema, includi il tuo ID del cluster. Per ottenere il tuo ID del cluster, esegui `bx cs clusters`.


