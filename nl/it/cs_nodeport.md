---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-24"

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

Rendi la tua applicazione disponibile per l'accesso Internet utilizzando l'indirizzo IP pubblico di un qualsiasi nodo di lavoro in un cluster ed esponendo una porta del nodo. Utilizza questa opzione per la verifica e per un accesso pubblico
a breve termine.
{:shortdesc}

## Configurazione dell'accesso pubblico a un'applicazione utilizzando il tipo di servizio NodePort
{: #config}

Puoi esporre la tua applicazione come un servizio Kubernetes NodePort per i cluster gratuito o standard.
{:shortdesc}

**Nota:** l'indirizzo IP pubblico di un nodo di lavoro non è permanente. Se è necessario ricreare un nodo di lavoro,
 a tale nodo viene assegnato un nuovo indirizzo IP pubblico. Se hai bisogno di un indirizzo IP pubblico stabile
e di una maggiore disponibilità per il tuo servizio, esponi la tua applicazione utilizzando un [Servizio LoadBalancer](cs_loadbalancer.html) o [Ingress](cs_ingress.html).

Se ancora non hai un'applicazione pronta, puoi utilizzare un'applicazione di esempio Kubernetes denominata [Guestbook ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/kubernetes/kubernetes/blob/master/examples/guestbook/all-in-one/guestbook-all-in-one.yaml).

1.  Nel file di configurazione della tua applicazione, definisci una sezione [del servizio ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/concepts/services-networking/service/).

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
     <td>Facoltativo: sostituisci <code><em>&lt;31514&gt;</em></code> con un valore NodePort compreso tra 30000 e 32767. Non specificare un NodePort già utilizzato da un altro servizio. Se non assegni un NodePort, ne
verrà assegnato uno casuale automaticamente.<br><br>Se vuoi specificare un NodePort e vedere quali NodePort sono già in uso, puoi immettere il seguente comando:<pre class="pre"><code>    kubectl get svc
    </code></pre>Ogni NodePort in utilizzo viene visualizzata nel campo **Porte**.</td>
     </tr>
     </tbody></table>


    Per l'esempio Guestbook, già esiste una sezione del servizio di frontend nel file di configurazione. Per rendere l'applicazione Guestbook disponibile all'esterno, aggiungi il tipo di NodePort e una NodePort compresa nell'intervallo 30000 - 32767 alla sezione del servizio di frontend.

    ```
    apiVersion: v1
    kind: Service
    metadata:
      name: frontend
      labels:
        app: guestbook
        tier: frontend
    spec:
      type: NodePort
      ports:
      - port: 80
        nodePort: 31513
      selector:
        app: guestbook
        tier: frontend
    ```
    {: codeblock}

2.  Salva il file di configurazione aggiornato.

3.  Ripeti questi passi per creare un servizio NodePort per ogni applicazione che vuoi esporre su internet.

**Operazioni successive:**

Quando l'applicazione viene distribuita, puoi utilizzare l'indirizzo IP pubblico di qualsiasi nodo di lavoro e il NodePort
per formare l'URL pubblico per accedere all'applicazione da un browser.

1.  Ottieni l'indirizzo IP pubblico per un nodo di lavoro
nel cluster.

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

2.  Se è stato assegnato un NodePort casuale, scopri quale è stato
assegnato.

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
