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


# Configurazione dei servizi NodePort
{: #nodeport}

Rendi disponibile la tua applicazione inserita in un contenitore per l'accesso a Internet utilizzando l'indirizzo IP pubblico di qualsiasi nodo di lavoro in un cluster Kubernetes ed esponendo una porta del nodo. Utilizza questa opzione per la verifica di {{site.data.keyword.containerlong}} e l'accesso pubblico a breve termine.
{:shortdesc}

## Pianificazione della rete esterna con i servizi NodePort
{: #planning}

Esponi una porta pubblica sul tuo nodo di lavoro e utilizza l'indirizzo IP pubblico del nodo di lavoro per accedere al tuo servizio nel cluster pubblicamente da Internet.
{:shortdesc}

Quando esponi la tua applicazione creando un servizio Kubernetes del tipo NodePort, vengono assegnati al servizio
una NodePort nell'intervallo 30000 - 32767 e un indirizzo
IP del cluster interno. Il servizio
NodePort funge da punto di ingresso per le richieste in entrata per la tua applicazione. La NodePort assegnata è pubblicamente esposta nelle impostazioni kubeproxy di ogni nodo di lavoro nel
cluster. Ogni nodo di lavoro inizia ad ascoltare dalla NodePort assegnata per le richieste in entrata per il
servizio. Per accedere al servizio da internet, puoi utilizzare l'indirizzo IP pubblico di ogni nodo di lavoro
che è stato assegnato durante la creazione del cluster e la NodePort nel formato `<ip_address>:<nodeport>`. In aggiunta all'indirizzo IP pubblico, è disponibile un servizio NodePort nell'indirizzo IP privato di un nodo di lavoro.

Il seguente diagramma mostra come viene diretta la comunicazione da Internet a un'applicazione quando è configurato un servizio NodePort:

<img src="images/cs_nodeport_planning.png" width="550" alt="Esponi un'applicazione in {{site.data.keyword.containershort_notm}} utilizzando NodePort" style="width:550px; border-style: none"/>

1. Viene inviata una richiesta alla tua applicazione utilizzando l'indirizzo IP pubblico del tuo nodo di lavoro e la NodePort sul nodo di lavoro.

2. La richiesta viene inoltrata automaticamente alla porta e all'indirizzo IP del cluster interno del servizio NodePort. L'indirizzo IP del cluster interno è accessibile solo all'interno del cluster.

3. `kube-proxy` instrada la richiesta al servizio NodePort Kubernetes per l'applicazione.

4. La richiesta viene inoltrata all'indirizzo IP privato del pod in cui è distribuita l'applicazione. Se nel cluster vengono distribuite più istanze dell'applicazione, il servizio NodePort instrada le richieste tra i pod dell'applicazione.

**Nota:** l'indirizzo IP pubblico del nodo di lavoro non è permanente. Quando un nodo di lavoro viene rimosso
o ricreato, a tale nodo viene assegnato un nuovo indirizzo IP pubblico. Puoi utilizzare NodePort per verificare l'accesso pubblico per la tua applicazione
o se l'accesso pubblico è richiesto solo per un breve periodo. Quando hai bisogno di un indirizzo IP pubblico stabile
e di una maggiore disponibilità per il tuo servizio, esponi la tua applicazione utilizzando un [Servizio LoadBalancer](cs_loadbalancer.html#planning) o [Ingress](cs_ingress.html#planning).

<br />


## Configurazione dell'accesso pubblico a un'applicazione utilizzando il servizio NodePort
{: #config}

Puoi esporre la tua applicazione come un servizio Kubernetes NodePort per i cluster gratuito o standard.
{:shortdesc}

Se ancora non hai un'applicazione pronta, puoi utilizzare un'applicazione di esempio Kubernetes denominata [Guestbook ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/kubernetes/kubernetes/blob/master/examples/guestbook/all-in-one/guestbook-all-in-one.yaml).

1.  Nel file di configurazione della tua applicazione, definisci una sezione per il [servizio ![External link icon](../icons/launch-glyph.svg "External link icon")](https://kubernetes.io/docs/concepts/services-networking/service/). **Nota**: per l'esempio Guestbook, esiste già una sezione del servizio di frontend nel file di configurazione. Per rendere l'applicazione Guestbook disponibile all'esterno, aggiungi il tipo di NodePort e una NodePort compresa nell'intervallo 30000 - 32767 alla sezione del servizio di frontend.

    Esempio:

    ```
    apiVersion: v1
    kind: Service
    metadata:
      name: <my-nodeport-service>
      labels:
        run: <my-demo>
    spec:
      selector:
        run: <my-demo>
      type: NodePort
      ports:
       - port: <8081>
         # nodePort: <31514>

    ```
    {: codeblock}

    <table>
    <caption>Descrizione dei componenti di questo file YAML</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icona idea"/> Descrizione dei componenti della sezione del servizio NodePort</th>
    </thead>
    <tbody>
    <tr>
    <td><code>name</code></td>
    <td>Sostituisci <code><em>&lt;my-nodeport-service&gt;</em></code> con un nome per il tuo servizio NodePort.</td>
    </tr>
    <tr>
    <td><code>run</code></td>
    <td>Sostituisci <code><em>&lt;my-demo&gt;</em></code> con il nome della tua distribuzione.</td>
    </tr>
    <tr>
    <td><code> port</code></td>
    <td>Sostituisci <code><em>&lt;8081&gt;</em></code> con la porta su cui è in ascolto il tuo servizio. </td>
     </tr>
     <tr>
     <td><code>nodePort</code></td>
     <td>Facoltativo: sostituisci <code><em>&lt;31514&gt;</em></code> con un valore NodePort compreso tra 30000 e 32767. Non specificare un NodePort già utilizzato da un altro servizio. Se non assegni un NodePort, ne verrà assegnato uno casuale automaticamente.<br><br>Se vuoi specificare un NodePort e vedere quali NodePort sono già in uso, puoi immettere il seguente comando: <pre class="pre"><code>    kubectl get svc
    </code></pre>Ogni NodePort in utilizzo viene visualizzata nel campo **Porte**.</td>
     </tr>
     </tbody></table>

2.  Salva il file di configurazione aggiornato.

3.  Ripeti questi passi per creare un servizio NodePort per ogni applicazione che vuoi esporre su internet.

**Operazioni successive:**

Quando l'applicazione viene distribuita, puoi utilizzare l'indirizzo IP pubblico di qualsiasi nodo di lavoro e il NodePort per formare l'URL pubblico per accedere all'applicazione da un browser.

1.  Ottieni l'indirizzo IP pubblico per un nodo di lavoro nel cluster.

    ```
    bx cs workers <cluster_name>
    ```
    {: pre}

    Output:

    ```
    ID                                                Public IP   Private IP    Size     State    Status
    prod-dal10-pa215dcf5bbc0844a990fa6b0fcdbff286-w1  192.0.2.23  10.100.10.10  u2c.2x4  normal   Ready
    prod-dal10-pa215dcf5bbc0844a990fa6b0fcdbff286-w2  192.0.2.27  10.100.10.15  u2c.2x4  normal   Ready
    ```
    {: screen}

2.  Se è stato assegnato un NodePort casuale, scopri quale è stato assegnato.

    ```
    kubectl describe service <service_name>
    ```
    {: pre}

    Output:

    ```
    Name:                   <service_name>
    Namespace:              default
    Labels:                 run=<deployment_name>
    Selector:               run=<deployment_name>
    Type:                   NodePort
    IP:                     10.10.10.8
    Port:                   <unset> 8080/TCP
    NodePort:               <unset> 30872/TCP
    Endpoints:              172.30.171.87:8080
    Session Affinity:       None
    No events.
    ```
    {: screen}

    In questo esempio, la NodePort è `30872`.

3.  Forma l'URL con uno degli indirizzi IP pubblici del nodo di lavoro e la NodePort. Esempio: `http://192.0.2.23:30872`
