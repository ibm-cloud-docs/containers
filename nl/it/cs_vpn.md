---

copyright:
  years: 2014, 2018
lastupdated: "2018-03-16"

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

Per collegare i tuoi nodi di lavoro e le tue applicazioni a un data center in loco, puoi configurare un endpoint IPSec VPN con un servizio strongSwan o con un'applicazione gateway Vyatta o un'applicazione Fortigate.

- **Servizio VPN IPSec strongSwan**: puoi configurare un [Servizio VPN IPSec strongSwan![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.strongswan.org/) che collega in modo sicuro il tuo cluster Kubernetes a una rete in loco. Il servizio VPN IPSec strongSwan fornisce un canale di comunicazione end-to-end sicuro su Internet basato sulla suite di protocolli IPsec (Internet Protocol Security) standard del settore. Per configurare una connessione sicura tra il tuo cluster e una rete in loco, devi installare un gateway VPN IPsec nel tuo data center in loco. Quindi, puoi [configurare e distribuire il servizio VPN IPSec strongSwan](#vpn-setup) in un pod Kubernetes.

- **Applicazione gateway Vyatta o applicazione Fortigate**: se hai un cluster più grande, vuoi accedere a risorse non Kubernetes tramite VPN o vuoi accedere a più cluster su una singola VPN, potresti scegliere di configurare un'applicazione gateway Vyatta o un'applicazione Fortigate per configurare un endpoint VPN IPSec. Per ulteriori informazioni, consulta questo post del blog [Connecting a cluster to an on-premises data center ![External link icon](../icons/launch-glyph.svg "External link icon")](https://www.ibm.com/blogs/bluemix/2017/07/kubernetes-and-bluemix-container-based-workloads-part4/).

## Configurazione della connettività VPN con il grafico Helm del servizio VPN IPSec strongSwan
{: #vpn-setup}

Utilizza un grafico Helm per configurare e distribuire il servizio VPN IPSec strongSwan all'interno di un pod Kubernetes. Tutto il traffico VPN viene quindi instradato a questo pod.
{:shortdesc}

Per ulteriori informazioni sui comandi Helm utilizzati per configurare il grafico strongSwan, consulta la <a href="https://docs.helm.sh/helm/" target="_blank">documentazione Helm <img src="../icons/launch-glyph.svg" alt="External link icon"></a>.


### Configura il grafico Helm strongSwan
{: #vpn_configure}

Prima di iniziare:
* Devi installare un gateway VPN IPsec nel tuo data center in loco.
* [Crea un cluster standard](cs_clusters.html#clusters_cli) o [aggiorna un cluster esistente alla versione 1.7.4 o successiva](cs_cluster_update.html#master).
* Il cluster deve avere almeno un indirizzo IP del programma di bilanciamento del carico pubblico. [Puoi verificare se visualizzare i tuoi indirizzi IP pubblici disponibili](cs_subnets.html#manage) o [liberare un indirizzo IP utilizzato](cs_subnets.html#free).
* [Indirizza la CLI Kubernetes al
cluster](cs_cli_install.html#cs_cli_configure).

Per configurare il grafico Helm:

1. [Installa Helm per il tuo cluster e aggiungi il repository {{site.data.keyword.Bluemix_notm}} alla tua istanza Helm](cs_integrations.html#helm).

2. Salva le impostazioni di configurazione predefinite per il grafico Helm strongSwan in un file YAML locale.

    ```
    helm inspect values ibm/strongswan > config.yaml
    ```
    {: pre}

3. Apri il file `config.yaml` e effettua le seguenti modifiche dei valori predefiniti in base alla configurazione VPN che desideri. Puoi trovare le descrizioni per le impostazioni più avanzate nei commenti del file di configurazione.

    **Importante**: se non hai bisogno di modificare una proprietà, commenta tale proprietà inserendo un `#` di fronte ad essa.

    <table>
    <col width="22%">
    <col width="78%">
    <caption>Descrizione dei componenti del file YAML</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code>localSubnetNAT</code></td>
    <td>NAT (Network Address Translation) per le sottoreti fornisce una soluzione temporanea per i conflitti di sottorete tra le reti locali e installate in loco. Puoi utilizzare NAT per riassociare le sottoreti IP locali private del cluster, la sottorete del pod (172.30.0.0/16) o la sottorete del servizio pod (172.21.0.0/16) a una sottorete privata diversa. Il tunnel VPN vede le sottoreti IP riassociate invece delle sottoreti originali. La riassociazione avviene prima che i pacchetti vengano inviati attraverso il tunnel VPN e dopo che i pacchetti arrivano dal tunnel VPN. Puoi esporre contemporaneamente entrambe le sottoreti riassociate e non riassociate sulla VPN. <br><br>Per abilitare NAT, puoi aggiungere un'intera sottorete o singoli indirizzi IP. Se aggiungi un'intera sottorete (nel formato <code>10.171.42.0/24=10.10.10.0/24</code>), per la riassociazione si applica un rapporto di 1 a 1: tutti gli indirizzi IP nella sottorete della rete interna vengono associati alla sottorete della rete esterna e viceversa. Se aggiungi singoli indirizzi IP (nel formato <code>10.171.42.17/32=10.10.10.2/32,10.171.42.29/32=10.10.10.3/32</code>), solo quegli indirizzi IP interni vengono associati agli indirizzi IP esterni specificati.<br><br>Se utilizzi questa opzione, la sottorete locale esposta tramite la connessione VPN è la sottorete "esterna" a cui viene associata la sottorete "interna". </td>
    </tr>
    <tr>
    <td><code>loadBalancerIP</code></td>
    <td>Aggiungi un indirizzo IP pubblico portatile da una sottorete assegnata a questo cluster che vuoi utilizzare per il servizio VPN strongSwan. Se la connessione VPN viene avviata dal gateway in loco (<code>ipsec.auto</code> è impostato su <code>add</code>), puoi utilizzare questa proprietà per configurare un indirizzo IP pubblico persistente sul gateway in loco per il cluster. Questo valore è facoltativo.</td>
    </tr>
    <tr>
    <td><code>nodeSelector</code></td>
    <td>Per limitare i nodi a cui distribuisce il pod VPN strongSwan, aggiungi l'indirizzo IP di un nodo di lavoro specifico o di un'etichetta del nodo di lavoro. Ad esempio, il valore <code>kubernetes.io/hostname: 10.184.110.141</code> limita il pod VPN all'esecuzione solo su quel nodo di lavoro. Il valore <code>strongswan: vpn</code> limita il pod VPN all'esecuzione su qualsiasi nodo di lavoro con quell'etichetta. Puoi utilizzare qualsiasi etichetta del nodo di lavoro, ma si consiglia di utilizzare: <code>strongswan: &lt;release_name&gt;</code> in modo che i diversi nodi di lavoro possano essere utilizzati con distribuzioni diverse di questo grafico.<br><br>Se la connessione VPN viene avviata dal cluster (<code>ipsec.auto</code> è impostato su <code>start</code>), puoi utilizzare questa proprietà per limitare gli indirizzi IP di origine della connessione VPN che vengono esposti al gateway in loco. Questo valore è facoltativo.</td>
    </tr>
    <tr>
    <td><code>ipsec.keyexchange</code></td>
    <td>Se il tuo endpoint del tunnel VPN in loco non supporta <code>ikev2</code> come protocollo per inizializzare la connessione, modifica questo valore in <code>ikev1</code> o <code>ike</code>.</td>
    </tr>
    <tr>
    <td><code>ipsec.esp</code></td>
    <td>Aggiungi l'elenco di algoritmi di crittografia/autenticazione ESP utilizzati dall'endpoint del tunnel VPN in loco per la connessione. Questo valore è facoltativo. Se lasci vuoto questo campo, per la connessione vengono utilizzati gli algoritmi strongSwan predefiniti <code>aes128-sha1,3des-sha1</code>.</td>
    </tr>
    <tr>
    <td><code>ipsec.ike</code></td>
    <td>Aggiungi l'elenco di algoritmi di crittografia/autenticazione IKE/ISAKMP SA utilizzati dall'endpoint del tunnel VPN in loco per la connessione. Questo valore è facoltativo. Se lasci vuoto questo campo, per la connessione vengono utilizzati gli algoritmi strongSwan predefiniti <code>aes128-sha1-modp2048,3des-sha1-modp1536</code>.</td>
    </tr>
    <tr>
    <td><code>ipsec.auto</code></td>
    <td>Se vuoi che il cluster avvii la connessione VPN, modifica questo valore in <code>start</code>.</td>
    </tr>
    <tr>
    <td><code>local.subnet</code></td>
    <td>Modifica questo valore nell'elenco dei CIDR della sottorete del cluster per esporre la connessione VPN alla rete in loco. Questo elenco può includere le seguenti sottoreti: <ul><li>CIDR della sottorete del pod Kubernetes: <code>172.30.0.0/16</code></li><li>CIDR della sottorete del servizio Kubernetes: <code>172.21.0.0/16</code></li><li>Se le tue applicazioni vengono esposte da un servizio NodePort sulla rete privata, il CIDR della sottorete privata del nodo di lavoro. Per trovare questo valore, esegui <code>bx cs subnets | grep <xxx.yyy.zzz></code> dove <code>&lt;xxx.yyy.zzz&gt;</code> è i primi tre ottetti dell'indirizzo IP privato del nodo di lavoro.</li><li>Se le applicazioni sono esposte dai servizi LoadBalancer sulla rete privata, i CIDR della sottorete gestita dall'utente o privata del cluster. Per trovare questi valori, esegui <code>bx cs cluster-get <cluster name> --showResources</code>. Nella sezione <b>VLAN</b>, ricerca i CIDR che hanno un valore <b>Pubblico</b> di <code>false</code>.</li></ul></td>
    </tr>
    <tr>
    <td><code>local.id</code></td>
    <td>Modifica questo valore nell'identificativo della stringa per il lato del cluster Kubernetes locale che il tuo endpoint del tunnel VPN in loco utilizza per la connessione.</td>
    </tr>
    <tr>
    <td><code>remote.gateway</code></td>
    <td>Modifica questo valore nell'indirizzo IP pubblico per il gateway VPN in loco. Se <code>ipsec.auto</code> è impostato su <code>start</code>, questo valore è obbligatorio.</td>
    </tr>
    <td><code>remote.subnet</code></td>
    <td>Modifica questo valore nell'elenco dei CIDR della sottorete privata in loco a cui ai cluster Kubernetes è consentito di accedere.</td>
    </tr>
    <tr>
    <td><code>remote.id</code></td>
    <td>Modifica questo valore nell'identificativo della stringa per il lato in loco remoto che il tuo endpoint del tunnel VPN utilizza per la connessione.</td>
    </tr>
    <tr>
    <td><code>remote.privateIPtoPing</code></td>
    <td>Aggiungi l'indirizzo IP privato nella sottorete remota che verrà utilizzato dai programmi di convalida di test Helm per i test di connettività ping VPN. Questo valore è facoltativo.</td>
    </tr>
    <tr>
    <td><code>preshared.secret</code></td>
    <td>Modifica questo valore nel segreto precondiviso che il tuo gateway dell'endpoint del tunnel VPN in loco utilizza per la connessione. Questo valore è memorizzato in <code>ipsec.secrets</code>.</td>
    </tr>
    </tbody></table>

4. Salva il file `config.yaml` aggiornato.

5. Installa il grafico Helm nel tuo cluster con il file `config.yaml` aggiornato. Le proprietà aggiornate sono memorizzate in una mappa di configurazione per il tuo grafico.

    **Nota**: se hai più distribuzioni VPN in un singolo cluster, puoi evitare conflitti di denominazione e differenziare le distribuzioni scegliendo nomi di release più descrittivi rispetto a `vpn`. Per evitare il troncamento del nome della release, limita il nome a 35 caratteri o meno.

    ```
    helm install -f config.yaml --namespace=kube-system --name=vpn ibm/strongswan
    ```
    {: pre}

6. Controlla lo stato di distribuzione del grafico. Quando il grafico è pronto, il campo **STATO** vicino alla parte superiore dell'output ha un valore di `DEPLOYED`.

    ```
    helm status vpn
    ```
    {: pre}

7. Una volta che il grafico è stato distribuito, verifica che le impostazioni aggiornate nel file `config.yaml` siano state utilizzate.

    ```
    helm get values vpn
    ```
    {: pre}


### Esegui il test e la verifica della connettività VPN
{: #vpn_test}

Dopo aver distribuito il tuo grafico Helm, verifica la connettività VPN.
{:shortdesc}

1. Se la VPN nel gateway in loco non è attiva, avviala.

2. Imposta la variabile di ambiente `STRONGSWAN_POD`.

    ```
    export STRONGSWAN_POD=$(kubectl get pod -n kube-system -l app=strongswan,release=vpn -o jsonpath='{ .items[0].metadata.name }')
    ```
    {: pre}

3. Controlla lo stato della VPN. Uno stato di `ESTABLISHED` significa che la connessione VPN ha avuto esito positivo.

    ```
    kubectl exec -n kube-system  $STRONGSWAN_POD -- ipsec status
    ```
    {: pre}

    Output di esempio:

    ```
    Security Associations (1 up, 0 connecting):
    k8s-conn[1]: ESTABLISHED 17 minutes ago, 172.30.244.42[ibm-cloud]...192.168.253.253[on-premises]
    k8s-conn{2}: INSTALLED, TUNNEL, reqid 12, ESP in UDP SPIs: c78cb6b1_i c5d0d1c3_o
    k8s-conn{2}: 172.21.0.0/16 172.30.0.0/16 === 10.91.152.128/26
    ```
    {: screen}

    **Nota**:

    <ul>
    <li>Quando tenti di stabilire la connettività VPN con il grafico Helm strongSwan per la prima volta, è probabile che lo stato della VPN non sia `ESTABLISHED`. Potresti dover verificare le impostazioni dell'endpoint VPN in loco e modificare il file di configurazione più volte prima che la connessione abbia esito positivo: <ol><li>Esegui `helm delete --purge <release_name>`</li><li>Correggi i valori errati nel file di configurazione.</li><li>Esegui `helm install -f config.yaml --namespace=kube-system --name=<release_name> ibm/strongswan`</li></ol>Puoi anche eseguire più controlli nel passo successivo.</li>
    <li>Se il pod VPN è in uno stato `ERROR` o continua ad arrestarsi e a riavviarsi, potrebbe essere dovuto alla convalida dei parametri delle impostazioni `ipsec.conf` nella mappa di configurazione del grafico.<ol><li>Controlla eventuali errori di convalida nei log del pod strongSwan eseguendo `kubectl logs -n kube-system $STRONGSWAN_POD`.</li><li>Se sono presenti errori di convalida, esegui `helm delete --purge <release_name>`<li>Correggi i valori errati nel file di configurazione.</li><li>Esegui `helm install -f config.yaml --namespace=kube-system --name=<release_name> ibm/strongswan`</li></ol>Se il tuo cluster ha un numero elevato di nodi di lavoro, puoi anche utilizzare `helm upgrade` per applicare più velocemente le tue modifiche invece di eseguire `helm delete` e `helm install`.</li>
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
    kubectl logs -n kube-system <test_program>
    ```
    {: pre}

    **Nota**: alcuni dei test hanno requisiti che sono impostazioni facoltative nella configurazione VPN. Se alcuni test non riescono, gli errori potrebbero essere accettabili a seconda che queste impostazioni facoltative siano state specificate o meno. Fai riferimento alla seguente tabella per ulteriori informazioni su ciascun test e sul perché potrebbe non riuscire.

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
    <td>Verifica che la connessione VPN abbia lo stato <code>ESTABLISHED</code>. Questo test potrebbe non riuscire per i seguenti motivi:<ul><li>Differenze tra i valori nel file <code>config.yaml</code> e le impostazioni dell'endpoint VPN in loco.</li><li>Se il cluster è in modalità "ascolto" (<code>ipsec.auto</code> è impostato su <code>add</code>), la connessione non viene stabilita sul lato in loco.</li></ul></td>
    </tr>
    <tr>
    <td><code>vpn-strongswan-ping-remote-gw</code></td>
    <td>Esegue il ping dell'indirizzo IP pubblico <code>remote.gateway</code> che hai configurato nel file <code>config.yaml</code>. Questo test potrebbe non riuscire per i seguenti motivi:<ul><li>Non hai specificato un indirizzo IP del gateway VPN in loco. Se <code>ipsec.auto</code> è impostato su <code>start</code>, l'indirizzo IP <code>remote.gateway</code> è obbligatorio.</li><li>La connessione VPN non ha lo stato <code>ESTABLISHED</code>. Vedi <code>vpn-strongswan-check-state</code> per ulteriori informazioni.</li><li>La connettività VPN ha lo stato <code>ESTABLISHED</code>, ma i pacchetti ICMP vengono bloccati da un firewall.</li></ul></td>
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
    helm install -f config.yaml --namespace=kube-system --name=<release_name> ibm/strongswan
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

12. Ripulisci i pod di test correnti.

    ```
    kubectl get pods -a -n kube-system -l app=strongswan-test
    ```
    {: pre}

    ```
    kubectl delete pods -n kube-system -l app=strongswan-test
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
  helm upgrade -f config.yaml --namespace kube-system <release_name> ibm/strongswan
  ```
  {: pre}


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
    helm install -f config.yaml --namespace=kube-system --name=<release_name> ibm/strongswan
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
