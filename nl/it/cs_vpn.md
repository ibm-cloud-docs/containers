---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-29"

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

Con la connettività VPN, puoi collegare in modo sicuro le applicazioni in un cluster Kubernetes a una rete in loco. Puoi anche collegare le applicazioni esterne al tuo cluster a un'applicazione in esecuzione nel tuo cluster.
{:shortdesc}

## Configurazione della connettività VPN con il grafico Helm del servizio VPN IPSec Strongswan 
{: #vpn-setup}

Per configurare la connettività VPN, puoi utilizzare un grafico Helm per configurare e distribuire il [servizio VPN IPSec Strongswan ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.strongswan.org/) all'interno di un pod Kubernetes. Tutto il traffico VPN viene quindi instradato a questo pod. Per ulteriori informazioni sui comandi Helm utilizzati per configurare il grafico Strongswan, consulta la <a href="https://docs.helm.sh/helm/" target="_blank">documentazione Helm <img src="../icons/launch-glyph.svg" alt="Icona link esterno"></a>.
{:shortdesc}

Prima di iniziare:

- [Crea un cluster standard.](cs_clusters.html#clusters_cli)
- [Se stai utilizzando un cluster esistente, aggiornalo alla versione 1.7.4 o successiva.](cs_cluster_update.html#master)
- Il cluster deve avere almeno un indirizzo IP del programma di bilanciamento del carico pubblico.
- [Indirizza la CLI Kubernetes CLI al
cluster](cs_cli_install.html#cs_cli_configure).

Per configurare la connettività VPN con Strongswan:

1. Se non è ancora abilitato, installa e avvia Helm per il tuo cluster.

    1. Installa la <a href="https://docs.helm.sh/using_helm/#installing-helm" target="_blank">CLI Helm <img src="../icons/launch-glyph.svg" alt="Icona link esterno"></a>.

    2. Avvia Helm e installa `tiller`.

        ```
        helm init
        ```
        {: pre}

    3. Verifica che il pod `tiller-deploy` abbia lo stato `Running` nel tuo cluster.

        ```
        kubectl get pods -n kube-system -l app=helm
        ```
        {: pre}

        Output di esempio:

        ```
        NAME                            READY     STATUS    RESTARTS   AGE
        tiller-deploy-352283156-nzbcm   1/1       Running   0          10m
        ```
        {: screen}

    4. Aggiungi il repository Helm {{site.data.keyword.containershort_notm}} alla tua istanza Helm.

        ```
        helm repo add bluemix  https://registry.bluemix.net/helm
        ```
        {: pre}

    5. Verifica che il grafico Strongswan sia elencato nel repository Helm.

        ```
        helm search bluemix
        ```
        {: pre}

2. Salva le impostazioni di configurazione predefinite per il grafico Strongswan Helm in un file YAML locale.

    ```
    helm inspect values bluemix/strongswan > config.yaml
    ```
    {: pre}

3. Apri il file `config.yaml` e effettua le seguenti modifiche dei valori predefiniti in base alla configurazione VPN che desideri. Se una proprietà ha valori specifici tra cui puoi scegliere, questi valori vengono elencati nei commenti sopra ogni proprietà nel file. **Importante**: se non hai bisogno di modificare una proprietà, commenta tale proprietà inserendo un `#` di fronte ad essa.

    <table>
    <caption>Descrizione dei componenti del file YAML</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code>overRideIpsecConf</code></td>
    <td>Se hai un file <code>ipsec.conf</code> esistente che vuoi utilizzare, rimuovi le parentesi graffe (<code>{}</code>) e aggiungi i contenuti del tuo file dopo questa proprietà. I contenuti del file devono essere rientrati. **Nota:** se utilizzi il tuo proprio file, i valori delle sezioni <code>ipsec</code>, <code>local</code> e <code>remote</code> non vengono utilizzati.</td>
    </tr>
    <tr>
    <td><code>overRideIpsecSecrets</code></td>
    <td>Se hai un file <code>ipsec.secrets</code> esistente che vuoi utilizzare, rimuovi le parentesi graffe (<code>{}</code>) e aggiungi i contenuti del tuo file dopo questa proprietà. I contenuti del file devono essere rientrati. **Nota:** se utilizzi il tuo proprio file, i valori della sezione <code>preshared</code> non vengono utilizzati.</td>
    </tr>
    <tr>
    <td><code>ipsec.keyexchange</code></td>
    <td>Se il tuo endpoint del tunnel VPN in loco non supporta <code>ikev2</code> come un protocollo per avviare la connessione, modifica questo valore con <code>ikev1</code>.</td>
    </tr>
    <tr>
    <td><code>ipsec.esp</code></td>
    <td>Modifica questo valore nell'elenco degli algoritmi di codifica/autenticazione ESP che il tuo endpoint del tunnel VPN in loco utilizza per la connessione.</td>
    </tr>
    <tr>
    <td><code>ipsec.ike</code></td>
    <td>Modifica questo valore nell'elenco degli algoritmi di codifica/autenticazione IKE/ISAKMP SA che il tuo endpoint del tunnel VPN in loco utilizza per la connessione.</td>
    </tr>
    <tr>
    <td><code>ipsec.auto</code></td>
    <td>Se vuoi che il cluster avvii la connessione VPN, modifica questo valore con <code>start</code>.</td>
    </tr>
    <tr>
    <td><code>local.subnet</code></td>
    <td>Modifica questo valore nell'elenco dei CIDR della sottorete del cluster per esporre la connessione VPN alla rete in loco. Questo elenco può includere le seguenti sottoreti: <ul><li>CIDR della sottorete del pod Kubernetes: <code>172.30.0.0/16</code></li><li>CIDR della sottorete del servizio Kubernetes: <code>172.21.0.0/16</code></li><li>Se le tue applicazioni vengono esposte da un servizio NodePort sulla rete privata, il CIDR della sottorete privata del nodo di lavoro. Per trovare questo valore, esegui <code>bx cs subnets | grep <xxx.yyy.zzz></code> dove <code>&lt;xxx.yyy.zzz&gt;</code> è i primi tre ottetti dell'indirizzo IP privato del nodo di lavoro.</li><li>Se hai le applicazioni esposte dal servizio LoadBalancer sulla rete privata, i CIDR della sottorete gestita dall'utente o privata del cluster. Per trovare questi valori, esegui <code>bx cs cluster-get <cluster name> --showResources</code>. Nella sezione <b>VLAN</b>, ricerca i CIDR che hanno un valore <b>Pubblico</b> di <code>false</code>.</li></ul></td>
    </tr>
    <tr>
    <td><code>local.id</code></td>
    <td>Modifica questo valore nell'identificativo della stringa per il lato del cluster Kubernetes locale che il tuo endpoint del tunnel VPN in loco utilizza per la connessione.</td>
    </tr>
    <tr>
    <td><code>remote.gateway</code></td>
    <td>Modifica questo valore nell'indirizzo IP pubblico per il gateway VPN in loco.</td>
    </tr>
    <td><code>remote.subnet</code></td>
    <td>Modifica questo valore nell'elenco dei CIDR della sottorete privata in loco a cui ai cluster Kubernetes è consentito di accedere. </td>
    </tr>
    <tr>
    <td><code>remote.id</code></td>
    <td>Modifica questo valore nell'identificativo della stringa per il lato in loco remoto che il tuo endpoint del tunnel VPN utilizza per la connessione. </td>
    </tr>
    <tr>
    <td><code>preshared.secret</code></td>
    <td>Modifica questo valore nel segreto precondiviso che il tuo gateway dell'endpoint del tunnel VPN in loco utilizza per la connessione. </td>
    </tr>
    </tbody></table>

4. Salva il file `config.yaml` aggiornato.

5. Installa il grafico Helm nel tuo cluster con il file `config.yaml` aggiornato. Le proprietà aggiornate vengono archiviate in una mappa di configurazione per il tuo grafico.

    ```
    helm install -f config.yaml --namespace=kube-system --name=vpn bluemix/strongswan
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

8. Verifica la nuova connettività VPN.
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
            k8s-conn[1]: ESTABLISHED 17 minutes ago, 172.30.244.42[ibm-cloud]...192.168.253.253[on-prem]
            k8s-conn{2}: INSTALLED, TUNNEL, reqid 12, ESP in UDP SPIs: c78cb6b1_i c5d0d1c3_o
            k8s-conn{2}: 172.21.0.0/16 172.30.0.0/16 === 10.91.152.128/26
        ```
        {: screen}

      **Nota**:
          - È probabile che lo stato della VPN non sia `ESTABLISHED` la prima volta che utilizzi questo grafico Helm. Potresti dover controllare le impostazioni dell'endpoint della VPN in loco e ritornare al passo 3 per modificare il file `config.yaml` più volte prima che la connessione abbia esito positivo.
          - Se il pod della VPN è in uno stato `ERROR` o continua ad arrestarsi e a riavviarsi, potrebbe essere dovuto alla convalida del parametro dell'impostazione `ipsec.conf` nella mappa di configurazione del grafico. Controlla tutti gli errori di convalida nei log del pod Strongswan eseguendo `kubectl logs -n kube-system $STRONGSWAN_POD`. Se sono presenti degli errori di convalida, esegui `helm delete --purge vpn`, ritorna al passo 3 per correggere i valori non corretti nel file `config.yaml` e ripeti i passi da 4 a 8. Se il tuo cluster ha un numero elevato di nodi di lavoro, puoi anche utilizzare `helm upgrade` per applicare più velocemente le tue modifiche invece di eseguire `helm delete` e `helm install`.

    4. Una volta che la VPN ha uno stato di `ESTABLISHED`, verifica la connessione con `ping`. Il seguente esempio invia un ping dal pod della VPN nel cluster Kubernetes all'indirizzo IP privato del gateway della VPN in loco. Assicurati che siano specificati i valori `remote.subnet` e `local.subnet` corretti nel file di configurazione e che l'elenco di sottoreti locali includa l'indirizzo IP di origine da cui stai inviando il ping.

        ```
        kubectl exec -n kube-system  $STRONGSWAN_POD -- ping -c 3  <on-prem_gateway_private_IP>
        ```
        {: pre}

### Disabilitazione del servizio VPN IPSec Strongswan
{: vpn_disable}

1. Elimina il grafico Helm.

    ```
    helm delete --purge vpn
    ```
    {: pre}
