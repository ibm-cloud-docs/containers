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


# Configurazione della connettività VPN
{: #vpn}

Con la connettività VPN, puoi collegare in modo sicuro le applicazioni di un cluster Kubernetes su {{site.data.keyword.containerlong}} a una rete in loco. Puoi anche collegare le applicazioni esterne al tuo cluster a un'applicazione in esecuzione nel tuo cluster.
{:shortdesc}

Per collegare i tuoi nodi di lavoro e applicazioni a un data center in loco, puoi configurare una delle seguenti opzioni.

- **Servizio VPN IPSec strongSwan**: puoi configurare un [Servizio VPN IPSec strongSwan![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.strongswan.org/about.html) che collega in modo sicuro il tuo cluster Kubernetes a una rete in loco. Il servizio VPN IPSec strongSwan fornisce un canale di comunicazione end-to-end protetto su Internet basato sulla suite di protocolli IPSec (Internet Protocol Security) standard del settore. Per configurare una connessione protetta tra il tuo cluster e una rete in loco, [configura e distribuisci il servizio VPN IPSec strongSwan](#vpn-setup) direttamente in un pod nel tuo cluster.

- **VRA (Virtual Router Appliance) o FSA (Fortigate Security Appliance)**: puoi scegliere di configurare una [VRA](/docs/infrastructure/virtual-router-appliance/about.html) o una [FSA](/docs/infrastructure/fortigate-10g/about.html) per configurare un endpoint VPN IPSec. Questa opzione è utile quando hai un cluster più grande, vuoi accedere a più cluster su una singola VPN o hai bisogno di una VPN basata sugli instradamenti. Per configurare una VRA, vedi [Configurazione della connettività VPN con VRA](#vyatta).

## Utilizzo del grafico Helm del servizio VPN IPSec strongSwan
{: #vpn-setup}

Utilizza un grafico Helm per configurare e distribuire il servizio VPN IPSec strongSwan all'interno di un pod Kubernetes.
{:shortdesc}

Poiché strongSwan è integrato con il tuo cluster, non hai bisogno di un dispositivo gateway esterno. Quando viene stabilita la connettività VPN, le rotte vengono configurate automaticamente su tutti i nodi di lavoro nel cluster. Queste rotte consentono una connettività a due vie tramite il tunnel VPN tra i pod su un qualsiasi nodo di lavoro e il sistema remoto. Ad esempio, il seguente diagramma mostra in che modo un'applicazione in {{site.data.keyword.containerlong_notm}} può comunicare con un server in loco tramite una connessione VPN strongSwan:

<img src="images/cs_vpn_strongswan.png" width="700" alt="Esponi un'applicazione in {{site.data.keyword.containerlong_notm}} utilizzando un programma di bilanciamento del carico" style="width:700px; border-style: none"/>

1. Un'applicazione nel tuo cluster, `myapp`, riceve una richiesta da un servizio Ingress o LoadBalancer e deve connettersi in modo sicuro alla tua rete in loco.

2. La richiesta al data center in loco viene inoltrata al pod VPN strongSwan IPSec. L'indirizzo IP di destinazione viene utilizzato per determinare quali pacchetti di rete inviare al pod VPN strongSwan IPSec.

3. La richiesta viene crittografata e inviata sul tunnel VPN nel data center in loco.

4. La richiesta in entrata passa attraverso il firewall in loco e viene consegnata all'endpoint del tunnel VPN (router) in cui viene decrittografata.

5. L'endpoint del tunnel VPN (router) inoltra la richiesta al mainframe o al server in loco a seconda dell'indirizzo IP di destinazione specificato nel passo 2. I dati necessari vengono reinviati tramite la connessione VPN a `myapp` seguendo lo stesso processo.

## Considerazioni sul servizio VPN strongSwan
{: strongswan_limitations}

Prima di utilizzare il grafico Helm strongSwan, esamina le considerazioni e le limitazioni riportate di seguito.

* Il grafico Helm strongSwan richiede che l'endpoint VPN remoto abiliti l'attraversamento NAT. L'attraversamento NAT richiede la porta UDP 4500 in aggiunta alla porta UDP IPSec predefinita 500. Entrambe le porte UDP devono essere consentite attraverso qualsiasi firewall configurato.
* Il grafico Helm strongSwan non supporta le VPN IPSec basate sugli instradamenti.
* Il grafico Helm strongSwan supporta le VPN IPSec che utilizzano chiavi precondivise ma non supporta le VPN IPSec che richiedono i certificati.
* Il grafico Helm strongSwan non consente a più cluster e ad altre risorse IaaS di condividere una singola connessione VPN.
* Il grafico Helm strongSwan viene eseguito come un pod Kubernetes all'interno del cluster. Le prestazioni della VPN sono influenzate dall'utilizzo della memoria e della rete di Kubernetes e di altri pod che sono in esecuzione nel cluster. Se hai un ambiente critico per le prestazioni, considera l'utilizzo di una soluzione VPN eseguita esternamente al cluster su hardware dedicato.
* Il grafico Helm strongSwan esegue un singolo pod VPN come endpoint del tunnel IPSec. Se si verifica un malfunzionamento del pod, il cluster lo riavvia. Tuttavia, potresti riscontrare un breve tempo di inattività mentre il nuovo pod viene avviato e la connessione VPN viene ristabilita. Se hai bisogno di un ripristino a seguito di un errore più rapido oppure una soluzione ad alta disponibilità più elaborata, considera l'utilizzo di una soluzione VPN eseguita esternamente al cluster su hardware dedicato.
* Il grafico Helm strongSwan non fornisce le metriche o il monitoraggio del traffico di rete che transita sulla connessione VPN. Per un elenco degli strumenti di monitoraggio supportati, consulta [Servizi di registrazione e monitoraggio](cs_integrations.html#health_services).

## Configurazione del grafico Helm strongSwan
{: #vpn_configure}

Prima di iniziare:
* [Installa un gateway VPN IPSec nel tuo data center in loco](/docs/infrastructure/iaas-vpn/set-up-ipsec-vpn.html#setting-up-an-ipsec-connection).
* [Crea un cluster standard](cs_clusters.html#clusters_cli).
* [Indirizza la CLI Kubernetes al
cluster](cs_cli_install.html#cs_cli_configure).

### Passo 1: Ottieni il grafico Helm strongSwan
{: #strongswan_1}

1. [Installa Helm per il tuo cluster e aggiungi il repository {{site.data.keyword.Bluemix_notm}} alla tua istanza Helm](cs_integrations.html#helm).

2. Salva le impostazioni di configurazione predefinite per il grafico Helm strongSwan in un file YAML locale.

    ```
    helm inspect values ibm/strongswan > config.yaml
    ```
    {: pre}

3. Apri il file `config.yaml`.

### Passo 2: Configura le impostazioni IPSec di base
{: #strongswan_2}

Per controllare lo stabilimento della connessione VPN, modifica le seguenti impostazioni IPSec di base.

Per ulteriori informazioni su ciascuna impostazione, leggi la documentazione fornita nel file `config.yaml` per il grafico Helm.
{: tip}

1. Se il tuo endpoint del tunnel VPN in loco non supporta `ikev2` come protocollo per inizializzare la connessione, modifica il valore di `ipsec.keyexchange` in `ikev1` oppure `ike`.
2. Imposta `ipsec.esp` su un elenco degli algoritmi di autenticazione e crittografia ESP utilizzati dal tuo endpoint del tunnel VPN in loco per la connessione.
    * Se `ipsec.keyexchange` è impostata su `ikev1`, devi specificare questa impostazione.
    * Se `ipsec.keyexchange` è impostata su `ikev2`, questa impostazione è facoltativa.
    * Se lasci vuota questa impostazione, per la connessione vengono utilizzati gli algoritmi strongSwan `aes128-sha1,3des-sha1` predefiniti.
3. Imposta `ipsec.ike` su un elenco degli algoritmi di autenticazione e crittografia IKE/ISAKMP SA utilizzati dal tuo endpoint del tunnel VPN in loco per la connessione. Gli algoritmi devono essere specifici nel formato `encryption-integrity[-prf]-dhgroup`.
    * Se `ipsec.keyexchange` è impostata su `ikev1`, devi specificare questa impostazione.
    * Se `ipsec.keyexchange` è impostata su `ikev2`, questa impostazione è facoltativa.
    * Se lasci vuota questa impostazione, per la connessione vengono utilizzati gli algoritmi strongSwan `aes128-sha1-modp2048,3des-sha1-modp1536` predefiniti.
4. Modifica il valore di `local.id` in qualsiasi stringa che vuoi usare per identificare il lato cluster Kubernetes locale utilizzato dal tuo endpoint del tunnel VPN. Il valore predefinito è `ibm-cloud`. Alcune implementazioni VPN richiedono che tu utilizzi l'indirizzo IP pubblico per l'endpoint locale.
5. Modifica il valore di `remote.id` in qualsiasi stringa che vuoi usare per identificare il lato in loco remoto utilizzato dal tuo endpoint del tunnel VPN. Il valore predefinito è `on-prem`. Alcune implementazioni VPN richiedono che tu utilizzi l'indirizzo IP pubblico per l'endpoint remoto.
6. Modifica il valore di `preshared.secret` nel segreto precondiviso utilizzato dal tuo gateway dell'endpoint del tunnel VPN in loco per la connessione. Questo valore è memorizzato in `ipsec.secrets`.
7. Facoltativo: imposta `remote.privateIPtoPing` su qualsiasi indirizzo IP privato nella sottorete remota di cui eseguire il ping come parte del test di convalida della connettività Helm.

### Passo 3: Seleziona la connessione VPN in entrata o in uscita
{: #strongswan_3}

Quando configuri una connessione VPN strongSwan, scegli se la connessione VPN è in entrata al cluster o in uscita dal cluster.
{: shortdesc}

<dl>
<dt>In entrata</dt>
<dd>L'endpoint VPN in loco dalla rete remota avvia la connessione VPN e il cluster è in ascolto per la connessione.</dd>
<dt>In uscita</dt>
<dd>Il cluster avvia la connessione VPN e l'endpoint VPN in loco dalla rete remota è in ascolto per la connessione.</dd>
</dl>

Per stabilire una connessione VPN in entrata, modifica le seguenti impostazioni:
1. Verifica che `ipsec.auto` sia impostata su `add`.
2. Facoltativo: imposta `loadBalancerIP` su un indirizzo IP pubblico portatile per il servizio VPN strongSwan. La specifica di un indirizzo IP è utile quando hai bisogno di un indirizzo IP stabile, ad esempio quando devi designare quali indirizzi IP sono consentiti attraverso un firewall in loco. Il cluster deve avere almeno un indirizzo IP del programma di bilanciamento del carico pubblico. [Puoi verificare se visualizzare i tuoi indirizzi IP pubblici disponibili](cs_subnets.html#review_ip) o [liberare un indirizzo IP utilizzato](cs_subnets.html#free).<br>**Nota**:
    * Se lasci vuota questa impostazione, viene utilizzato uno degli indirizzi IP pubblici portatili disponibili.
    * Devi anche configurare l'indirizzo IP pubblico che selezioni per l'endpoint VPN, o l'indirizzo IP pubblico ad esso assegnato, sull'endpoint VPN in loco.

Per stabilire una connessione VPN in uscita, modifica le seguenti impostazioni:
1. Modifica `ipsec.auto` in `start`.
2. Imposta `remote.gateway` sull'indirizzo IP pubblico per l'endpoint VPN in loco nella rete remota.
3. Scegli una delle seguenti opzioni per l'indirizzo IP per l'endpoint VPN del cluster:
    * **Indirizzo IP pubblico del gateway privato del cluster**: se i tuoi nodi di lavoro sono connessi solo a una VLAN privata, la richiesta VPN in uscita viene instradata tramite il gateway privato per raggiungere internet. L'indirizzo IP pubblico del gateway privato viene utilizzato per la connessione VPN.
    * **Indirizzo IP pubblico del nodo di lavoro dove è in esecuzione il pod strongSwan**: se il nodo di lavoro dove è in esecuzione il pod strongSwan è connesso a una VLAN pubblica, l'indirizzo IP pubblico del nodo di lavoro viene utilizzato per la connessione VPN.
        <br>**Nota**:
        * Se il pod strongSwan viene eliminato e ripianificato su un nodo di lavoro differente nel cluster, l'indirizzo IP pubblico della VPN cambia. L'endpoint VPN in loco della rete remota deve consentire lo stabilimento della connessione VPN dall'indirizzo IP pubblico di uno qualsiasi dei nodi di lavoro del cluster.
        * Se l'endpoint VPN remoto non è in grado di gestire le connessioni VPN da più indirizzi IP pubblici, limita i nodi a cui viene distribuito il pod VPN strongSwan. Imposta `nodeSelector` sugli indirizzi IP degli specifici nodi di lavoro o un'etichetta di nodo di lavoro. Ad esempio, il valore `kubernetes.io/hostname: 10.232.xx.xx` consente la distribuzione del pod VPN solo su tale nodo di lavoro. Il valore `strongswan: vpn` limita il pod VPN all'esecuzione su qualsiasi nodo di lavoro con quell'etichetta. Puoi utilizzare qualsiasi etichetta di nodo di lavoro. Per consentire l'utilizzo di nodi di lavoro differenti con distribuzioni di grafico helm differenti, utilizza `strongswan: <release_name>`. Per l'alta disponibilità, seleziona almeno due nodi di lavoro.
    * **Indirizzo IP pubblico del servizio strongSwan**: per stabilire la connessione utilizzando l'indirizzo IP del servizio VPN strongSwan, imposta `connectUsingLoadBalancerIP` su `true`. L'indirizzo IP del servizio strongSwan è un indirizzo IP pubblico portatile che puoi specificare nell'impostazione `loadBalancerIP` oppure un indirizzo IP pubblico portatile disponibile che viene assegnato automaticamente al servizio.
        <br>**Nota**:
        * Se scegli di selezionare un indirizzo IP utilizzando l'impostazione `loadBalancerIP`, il cluster deve avere almeno un indirizzo IP del programma di bilanciamento del carico pubblico disponibile. [Puoi verificare se visualizzare i tuoi indirizzi IP pubblici disponibili](cs_subnets.html#review_ip) o [liberare un indirizzo IP utilizzato](cs_subnets.html#free).
        * Tutti i nodi di lavoro del cluster devono trovarsi sulla stessa VLAN pubblica. In caso contrario, devi utilizzare l'impostazione `nodeSelector` per assicurarti che il pod VPN venga distribuito in un nodo di lavoro sulla stessa VLAN pubblica di `loadBalancerIP`.
        * Se `connectUsingLoadBalancerIP` è impostata su `true` e `ipsec.keyexchange` è impostata su `ikev1`, devi impostare `enableServiceSourceIP` su `true`.

### Passo 4: Accesso alle risorse del cluster sulla connessione VPN
{: #strongswan_4}

Determina le risorse cluster che devono essere accessibili dalla rete remota sulla connessione VPN.
{: shortdesc}

1. Aggiungi i CIDR di una o più sottoreti del cluster all'impostazione `local.subnet`. Devi configurare i CIDR della sottorete locale sull'endpoint VPN in loco. Questo elenco può includere le seguenti sottoreti:  
    * CIDR della sottorete del pod Kubernetes: `172.30.0.0/16`. Le comunicazioni bidirezionali sono abilitate tra tutti i pod del cluster e uno qualsiasi degli host nelle sottoreti di rete remota che elenchi nell'impostazione `remote.subnet`. Se devi evitare che qualsiasi host `remote.subnet` acceda ai pod del cluster per motivi di sicurezza, non aggiungere la sottorete pod Kubernetes all'impostazione `local.subnet`.
    * CIDR della sottorete del servizio Kubernetes: `172.21.0.0/16`. Gli indirizzi IP del servizio forniscono un modo per esporre più pod dell'applicazione distribuiti su diversi nodi di lavoro dietro un singolo IP.
    * Se le tue applicazioni vengono esposte da un servizio NodePort sulla rete privata o un ALB Ingress privato, aggiungi il CIDR di sottorete privata del nodo di lavoro. Richiama i primi tre ottetti del tuo indirizzo IP privato del tuo lavoro eseguendo `ibmcloud ks worker <cluster_name>`. Ad esempio, se è `10.176.48.xx`, prendi nota di `10.176.48`. Successivamente, ottieni il CIDR della sottorete privata del nodo di lavoro eseguendo il seguente comando, sostituendo `<xxx.yyy.zz>` con l'ottetto che avevi richiamato in precedenza: `ibmcloud sl subnet list | grep <xxx.yyy.zzz>`.<br>**Nota**: se un nodo di lavoro viene aggiunto a una nuova sottorete privata, devi aggiungere il nuovo CIDR della sottorete privata sia all'impostazione `local.subnet` che all'endpoint VPN in loco. Bisogna quindi riavviare la connessione VPN.
    * Se hai delle applicazioni esposte dai servizi LoadBalancer sulla rete privata, aggiungi i CIDR della sottorete gestita dall'utente privata del cluster. Per trovare questi valori, esegui `ibmcloud ks cluster-get <cluster_name> --showResources`. Nella sezione **VLAN**, ricerca i CIDR che hanno un valore **Pubblico** di `false`.<br>
    **Nota**: se `ipsec.keyexchange` è impostata su `ikev1`, puoi specificare solo una sottorete. Puoi tuttavia utilizzare l'impostazione `localSubnetNAT` per combinare più sottoreti del cluster in una singola sottorete.

2. Facoltativo: riassocia le sottoreti del cluster utilizzando l'impostazione `localSubnetNAT`. NAT (Network Address Translation) per le sottoreti fornisce una soluzione temporanea per i conflitti di sottorete tra la rete del cluster e la rete remota in loco. Puoi utilizzare NAT per riassociare le sottoreti IP locali private del cluster, la sottorete del pod (172.30.0.0/16) o la sottorete del servizio pod (172.21.0.0/16) a una sottorete privata diversa. Il tunnel VPN vede le sottoreti IP riassociate invece delle sottoreti originali. La riassociazione avviene prima che i pacchetti vengano inviati attraverso il tunnel VPN e dopo che i pacchetti arrivano dal tunnel VPN. Puoi esporre contemporaneamente entrambe le sottoreti riassociate e non riassociate sulla VPN. Per abilitare NAT, puoi aggiungere un'intera sottorete o singoli indirizzi IP.
    * Se aggiungi un'intera sottorete nel formato `10.171.42.0/24=10.10.10.0/24`, per la riassociazione si applica un rapporto di 1 a 1: tutti gli indirizzi IP nella sottorete della rete interna vengono associati alla sottorete della rete esterna e viceversa.
    * Se aggiungi singoli indirizzi IP nel formato `10.171.42.17/32=10.10.10.2/32,10.171.42.29/32=10.10.10.3/32`, solo quegli indirizzi IP interni vengono associati agli indirizzi IP esterni specificati.

3. Facoltativo per i grafici Helm strongSwan versione 2.2.0 e successive: nascondi tutti gli indirizzi IP del cluster dietro un singolo indirizzo IP impostando `enableSingleSourceIP` su `true`. Questa opzione fornisce una delle configurazioni più sicure per la connessione VPN perché non è consentita alcuna connessione dalla rete remota che vada nuovamente nel cluster.
    <br>**Nota**:
    * Questa impostazione richiede che tutto il flusso di dati sulla connessione VPN sia in uscita indipendentemente dal fatto che la connessione VPN sia stabilita dal cluster o dalla rete remota.
    * `local.subnet` deve essere impostato su una singola sottorete /32.

4. Facoltativo per i grafici Helm strongSwan versione 2.2.0 e successive: abilita il servizio strongSwan per instradare le richieste in entrata dalla rete remota al servizio che esiste esternamente al cluster utilizzando impostazione `localNonClusterSubnet`.
    <br>**Nota**:
    * Il servizio non cluster deve esistere sulla stessa rete privata o su una rete privata che sia raggiungibile dai nodi di lavoro.
    * Il nodo di lavoro non cluster non può avviare il traffico alla rete remota tramite la connessione VPN, ma il nodo non cluster può essere la destinazione di richieste in entrata dalla rete remota.
    * Devi elencare i CIDR delle sottoreti non cluster nell'impostazione `local.subnet`.

### Passo 5: Accesso alle risorse di rete remota sulla connessione VPN
{: #strongswan_5}

Determina quali risorse di rete remota devono essere accessibili dal cluster sulla connessione VPN.
{: shortdesc}

1. Aggiungi i CIDR di una o più sottoreti private in loco all'impostazione `remote.subnet`.
    <br>**Nota**: se `ipsec.keyexchange` è impostata su `ikev1`, puoi specificare solo una sottorete.
2. Facoltativo per i grafici Helm strongSwan versione 2.2.0 e successive: riassocia le sottoreti di rete remota utilizzando l'impostazione `remoteSubnetNAT`. NAT (Network Address Translation) per le sottoreti fornisce una soluzione temporanea per i conflitti di sottorete tra la rete del cluster e la rete remota in loco. Puoi utilizzare NAT per riassociare le sottoreti IP della rete remota a una sottorete privata differente. Il tunnel VPN vede le sottoreti IP riassociate invece delle sottoreti originali. La riassociazione avviene prima che i pacchetti vengano inviati attraverso il tunnel VPN e dopo che i pacchetti arrivano dal tunnel VPN. Puoi esporre contemporaneamente entrambe le sottoreti riassociate e non riassociate sulla VPN.

### Passo 6: Distribuisci il grafico Helm
{: #strongswan_6}

1. Se devi configurare delle impostazioni più avanzate, attieniti alla documentazione fornita per ciascuna impostazione nel grafico Helm.

2. **Importante**: se non hai bisogno di un'impostazione nel grafico Helm, indica tale proprietà come commento inserendo un carattere `#` davanti ad essa.

3. Salva il file `config.yaml` aggiornato.

4. Installa il grafico Helm nel tuo cluster con il file `config.yaml` aggiornato. Le proprietà aggiornate sono memorizzate in una mappa di configurazione per il tuo grafico.

    **Nota**: se hai più distribuzioni VPN in un singolo cluster, puoi evitare conflitti di denominazione e differenziare le distribuzioni scegliendo nomi di release più descrittivi rispetto a `vpn`. Per evitare il troncamento del nome della release, limita il nome a 35 caratteri o meno.

    ```
    helm install -f config.yaml --name=vpn ibm/strongswan
    ```
    {: pre}

5. Controlla lo stato di distribuzione del grafico. Quando il grafico è pronto, il campo **STATO** vicino alla parte superiore dell'output ha un valore di `DEPLOYED`.

    ```
    helm status vpn
    ```
    {: pre}

6. Una volta che il grafico è stato distribuito, verifica che le impostazioni aggiornate nel file `config.yaml` siano state utilizzate.

    ```
    helm get values vpn
    ```
    {: pre}

## Test e verifica della connettività VPN strongSwan
{: #vpn_test}

Dopo aver distribuito il tuo grafico Helm, verifica la connettività VPN.
{:shortdesc}

1. Se la VPN nel gateway in loco non è attiva, avviala.

2. Imposta la variabile di ambiente `STRONGSWAN_POD`.

    ```
    export STRONGSWAN_POD=$(kubectl get pod -l app=strongswan,release=vpn -o jsonpath='{ .items[0].metadata.name }')
    ```
    {: pre}

3. Controlla lo stato della VPN. Uno stato di `ESTABLISHED` significa che la connessione VPN ha avuto esito positivo.

    ```
    kubectl exec $STRONGSWAN_POD -- ipsec status
    ```
    {: pre}

    Output di esempio:

    ```
    Security Associations (1 up, 0 connecting):
    k8s-conn[1]: ESTABLISHED 17 minutes ago, 172.30.xxx.xxx[ibm-cloud]...192.xxx.xxx.xxx[on-premises]
    k8s-conn{2}: INSTALLED, TUNNEL, reqid 12, ESP in UDP SPIs: c78cb6b1_i c5d0d1c3_o
    k8s-conn{2}: 172.21.0.0/16 172.30.0.0/16 === 10.91.152.xxx/26
    ```
    {: screen}

    **Nota**:

    <ul>
    <li>Quando tenti di stabilire la connettività VPN con il grafico Helm strongSwan per la prima volta, è probabile che lo stato della VPN non sia `ESTABLISHED`. Potresti dover verificare le impostazioni dell'endpoint VPN in loco e modificare il file di configurazione più volte prima che la connessione abbia esito positivo: <ol><li>Esegui `helm delete --purge <release_name>`</li><li>Correggi i valori errati nel file di configurazione.</li><li>Esegui `helm install -f config.yaml --name=<release_name> ibm/strongswan`</li></ol>Puoi anche eseguire più controlli nel passo successivo.</li>
    <li>Se il pod VPN è in uno stato `ERROR` o continua ad arrestarsi e a riavviarsi, potrebbe essere dovuto alla convalida dei parametri delle impostazioni `ipsec.conf` nella mappa di configurazione del grafico.<ol><li>Controlla eventuali errori di convalida nei log del pod strongSwan eseguendo `kubectl logs -n $STRONGSWAN_POD`.</li><li>Se sono presenti errori di convalida, esegui `helm delete --purge <release_name>`<li>Correggi i valori errati nel file di configurazione.</li><li>Esegui `helm install -f config.yaml --name=<release_name> ibm/strongswan`</li></ol>Se il tuo cluster ha un numero elevato di nodi di lavoro, puoi anche utilizzare `helm upgrade` per applicare più velocemente le tue modifiche invece di eseguire `helm delete` e `helm install`.</li>
    </ul>

4. Puoi testare ulteriormente la connettività VPN eseguendo i cinque test Helm inclusi nella definizione del grafico strongSwan.

    ```
    helm test vpn
    ```
    {: pre}

    * Se tutti i test hanno esito positivo, la tua connessione VPN strongSwan è configurata correttamente.

    * Se un test non riesce, vai al passo successivo.

5. Visualizza l'output di un test non riuscito nei log del pod di test.

    ```
    kubectl logs <test_program>
    ```
    {: pre}

    **Nota**: alcuni dei test hanno requisiti che sono impostazioni facoltative nella configurazione VPN. Se alcuni test non riescono, gli errori potrebbero essere accettabili a seconda che queste impostazioni facoltative siano state specificate o meno. Fai riferimento alla seguente tabella per informazioni su ciascun test e sul perché potrebbe non riuscire.

    {: #vpn_tests_table}
    <table>
    <caption>Descrizione dei test di connettività VPN Helm</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei test di connettività VPN Helm</th>
    </thead>
    <tbody>
    <tr>
    <td><code>vpn-strongswan-check-config</code></td>
    <td>Convalida la sintassi del file <code>ipsec.conf</code> che viene generato dal file <code>config.yaml</code>. Questo test potrebbe non riuscire a causa di valori non corretti nel file <code>config.yaml</code>.</td>
    </tr>
    <tr>
    <td><code>vpn-strongswan-check-state</code></td>
    <td>Verifica che la connessione VPN abbia lo stato <code>ESTABLISHED</code>. Questo test potrebbe non riuscire per i seguenti motivi:<ul><li>Differenze tra i valori nel file <code>config.yaml</code> e le impostazioni dell'endpoint VPN in loco.</li><li>Se il cluster è in modalità "ascolto" (<code>ipsec.auto</code> è impostata su <code>add</code>), la connessione non viene stabilita sul lato in loco.</li></ul></td>
    </tr>
    <tr>
    <td><code>vpn-strongswan-ping-remote-gw</code></td>
    <td>Esegue il ping dell'indirizzo IP pubblico <code>remote.gateway</code> che hai configurato nel file <code>config.yaml</code>. Questo test potrebbe non riuscire per i seguenti motivi:<ul><li>Non hai specificato un indirizzo IP del gateway VPN in loco. Se <code>ipsec.auto</code> è impostata su <code>start</code>, l'indirizzo IP <code>remote.gateway</code> è obbligatorio.</li><li>La connessione VPN non ha lo stato <code>ESTABLISHED</code>. Vedi <code>vpn-strongswan-check-state</code> per ulteriori informazioni.</li><li>La connettività VPN ha lo stato <code>ESTABLISHED</code>, ma i pacchetti ICMP vengono bloccati da un firewall.</li></ul></td>
    </tr>
    <tr>
    <td><code>vpn-strongswan-ping-remote-ip-1</code></td>
    <td>Esegue il ping dell'indirizzo IP privato <code>remote.privateIPtoPing</code> del gateway VPN in loco dal pod VPN nel cluster. Questo test potrebbe non riuscire per i seguenti motivi:<ul><li>Non hai specificato un indirizzo IP <code>remote.privateIPtoPing</code>. Se non hai specificato un indirizzo IP intenzionalmente, questo errore è accettabile.</li><li>Non hai specificato il CIDR della sottorete pod del cluster, <code>172.30.0.0/16</code>, nell'elenco <code>local.subnet</code>.</li></ul></td>
    </tr>
    <tr>
    <td><code>vpn-strongswan-ping-remote-ip-2</code></td>
    <td>Esegue il ping dell'indirizzo IP privato <code>remote.privateIPtoPing</code> del gateway VPN in loco dal nodo di lavoro nel cluster. Questo test potrebbe non riuscire per i seguenti motivi:<ul><li>Non hai specificato un indirizzo IP <code>remote.privateIPtoPing</code>. Se non hai specificato un indirizzo IP intenzionalmente, questo errore è accettabile.</li><li>Non hai specificato il CIDR della sottorete privata del nodo di lavoro del cluster nell'elenco <code>local.subnet</code>.</li></ul></td>
    </tr>
    </tbody></table>

6. Elimina il grafico Helm corrente.

    ```
    helm delete --purge vpn
    ```
    {: pre}

7. Apri il file `config.yaml` e correggi i valori errati.

8. Salva il file `config.yaml` aggiornato.

9. Installa il grafico Helm nel tuo cluster con il file `config.yaml` aggiornato. Le proprietà aggiornate sono memorizzate in una mappa di configurazione per il tuo grafico.

    ```
    helm install -f config.yaml --name=<release_name> ibm/strongswan
    ```
    {: pre}

10. Controlla lo stato di distribuzione del grafico. Quando il grafico è pronto, il campo **STATO** vicino alla parte superiore dell'output ha un valore di `DEPLOYED`.

    ```
    helm status vpn
    ```
    {: pre}

11. Una volta che il grafico è stato distribuito, verifica che le impostazioni aggiornate nel file `config.yaml` siano state utilizzate.

    ```
    helm get values vpn
    ```
    {: pre}

12. Elimina i pod di test correnti.

    ```
    kubectl get pods -a -l app=strongswan-test
    ```
    {: pre}

    ```
    kubectl delete pods -l app=strongswan-test
    ```
    {: pre}

13. Esegui di nuovo i test.

    ```
    helm test vpn
    ```
    {: pre}

<br />


## Aggiornamento del grafico Helm strongSwan
{: #vpn_upgrade}

Assicurati che il tuo grafico Helm strongSwan sia aggiornato.
{:shortdesc}

Per aggiornare il tuo grafico Helm strongSwan all'ultima versione:

  ```
  helm upgrade -f config.yaml <release_name> ibm/strongswan
  ```
  {: pre}

**Importante**: il grafico Helm strongSwan 2.0.0 non funziona con Calico v3 o Kubernetes 1.10. Prima di [aggiornare il tuo cluster alla 1.10](cs_versions.html#cs_v110), aggiorna strongSwan al grafico Helm 2.2.0, che è compatibile con le versioni precedenti Calico 2.6 e Kubernetes 1.8 e 1.9.

Stai aggiornando il tuo cluster a Kubernetes 1.10? Assicurati di eliminare prima il tuo grafico Helm strongSwan. Quindi, dopo l'aggiornamento, reinstallalo.
{:tip}

### Aggiornamento dalla versione 1.0.0
{: #vpn_upgrade_1.0.0}

A causa di alcune delle impostazioni utilizzate nel grafico Helm versione 1.0.0, non puoi utilizzare `helm upgrade` per aggiornare dalla versione 1.0.0 alla versione più recente.
{:shortdesc}

Per eseguire l'aggiornamento dalla versione 1.0.0, devi eliminare il grafico 1.0.0 e installare la versione più recente:

1. Elimina il grafico Helm versione 1.0.0.

    ```
    helm delete --purge <release_name>
    ```
    {: pre}

2. Salva le impostazioni di configurazione predefinite per la versione più recente del grafico Helm strongSwan in un file YAML locale.

    ```
    helm inspect values ibm/strongswan > config.yaml
    ```
    {: pre}

3. Aggiorna il file di configurazione e salva il file con le tue modifiche.

4. Installa il grafico Helm nel tuo cluster con il file `config.yaml` aggiornato.

    ```
    helm install -f config.yaml --name=<release_name> ibm/strongswan
    ```
    {: pre}

Inoltre, alcune impostazioni di timeout `ipsec.conf` che erano state codificate in modo sicuro nella versione 1.0.0 sono esposte come proprietà configurabili nelle versioni successive. Anche i nomi e i valori predefiniti di alcune di queste impostazioni di timeout `ipsec.conf` configurabili sono stati modificati per essere più coerenti con gli standard strongSwan. Se aggiorni il tuo grafico Helm dalla versione 1.0.0 e vuoi mantenere i valori predefiniti di tale versione per le impostazioni di timeout, aggiungi le nuove impostazioni al file di configurazione del grafico con i vecchi valori predefiniti.



  <table>
  <caption>Differenze nelle impostazioni ipsec.conf tra la versione 1.0.0 e la versione più recente</caption>
  <thead>
  <th>Nome impostazione 1.0.0</th>
  <th>Valore predefinito 1.0.0</th>
  <th>Nome impostazione versione più recente</th>
  <th>Valore predefinito versione più recente</th>
  </thead>
  <tbody>
  <tr>
  <td><code>ikelifetime</code></td>
  <td>60m</td>
  <td><code>ikelifetime</code></td>
  <td>3h</td>
  </tr>
  <tr>
  <td><code>keylife</code></td>
  <td>20m</td>
  <td><code>lifetime</code></td>
  <td>1h</td>
  </tr>
  <tr>
  <td><code>rekeymargin</code></td>
  <td>3m</td>
  <td><code>margintime</code></td>
  <td>9m</td>
  </tr>
  </tbody></table>


## Disabilitazione del servizio VPN IPSec strongSwan
{: vpn_disable}

Puoi disabilitare la connessione VPN eliminando il grafico Helm.
{:shortdesc}

  ```
  helm delete --purge <release_name>
  ```
  {: pre}

<br />


## Utilizzo di una VRA (Virtual Router Appliance)
{: #vyatta}

La VRA ([)](/docs/infrastructure/virtual-router-appliance/about.html) fornisce il sistema operativo Vyatta 5600 più recente per i server bare metal x86. Puoi utilizzare una VRA come un gateway VPN per connetterti in modo sicuro ad una rete in loco.
{:shortdesc}

Tutto il traffico di rete pubblico e privato che entra o esce dalle VLAN del cluster viene instradato tramite una VRA. Puoi utilizzare la VRA come un endpoint VPN per creare un tunnel IPSec crittografato tra i server nell'infrastruttura IBM Cloud (SoftLayer) e le risorse in loco. Ad esempio, il seguente diagramma mostra in che modo un'applicazione su un nodo di lavoro solamente privato in {{site.data.keyword.containerlong_notm}} può comunicare con un server in loco tramite una connessione VPN VRA:

<img src="images/cs_vpn_vyatta.png" width="725" alt="Esponi un'applicazione in {{site.data.keyword.containerlong_notm}} utilizzando un programma di bilanciamento del carico" style="width:725px; border-style: none"/>

1. Un'applicazione nel tuo cluster, `myapp2`, riceve una richiesta da un servizio Ingress o LoadBalancer e deve connettersi in modo sicuro alla tua rete in loco.

2. Poiché `myapp2` si trova su un nodo di lavoro che si trova solo su una VLAN privata, la VRA funge da connessione protetta tra i nodi di lavoro e la rete in loco. La VRA usa l'indirizzo IP di destinazione per determinare quali pacchetti di rete inviare alla rete in loco.

3. La richiesta viene crittografata e inviata sul tunnel VPN nel data center in loco.

4. La richiesta in entrata passa attraverso il firewall in loco e viene consegnata all'endpoint del tunnel VPN (router) in cui viene decrittografata.

5. L'endpoint del tunnel VPN (router) inoltra la richiesta al mainframe o al server in loco a seconda dell'indirizzo IP di destinazione specificato nel passo 2. I dati necessari vengono reinviati tramite la connessione VPN a `myapp2` seguendo lo stesso processo.

Per configurare una VRA (Virtual Router Appliance):

1. [Ordina una VRA](/docs/infrastructure/virtual-router-appliance/getting-started.html).

2. [Configura la VLAN privata nella VRA](/docs/infrastructure/virtual-router-appliance/manage-vlans.html).

3. Per abilitare una connessione VPN utilizzando la VRA, [configura VRRP nella VRA](/docs/infrastructure/virtual-router-appliance/vrrp.html#high-availability-vpn-with-vrrp).

**Nota**: se hai un'applicazione router esistente e aggiungi quindi un cluster, le nuove sottoreti portatili ordinate per il cluster non sono configurate sull'applicazione router. Per utilizzare i servizi di rete, devi abilitare l'instradamento tra le sottoreti sulla stessa VLAN [abilitando lo spanning delle VLAN](cs_subnets.html#subnet-routing). Per controllare se lo spanning di VLAN è già abilitato, usa il [comando](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`.
