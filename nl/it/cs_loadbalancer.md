---

copyright:
  years: 2014, 2018
lastupdated: "2018-02-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Configurazione dei servizi del programma di bilanciamento del carico 
{: #loadbalancer}

Esponi una porta e utilizza un indirizzo IP portatile per il programma di bilanciamento del carico per accedere all'applicazione. Utilizza un indirizzo IP pubblico per rendere un'applicazione accessibile su Internet o un indirizzo IP privato per rendere un'applicazione accessibile sulla rete dell'infrastruttura privata.
{:shortdesc}



## Configurazione dell'accesso a un'applicazione utilizzando il tipo di servizio LoadBalancer
{: #config}

A differenza di un servizio NodePort, l'indirizzo IP portatile del servizio di bilanciamento del carico non dipende
dal nodo di lavoro su cui viene distribuita l'applicazione. Tuttavia, un servizio Kubernetes LoadBalancer è anche un servizio NodePort. Un servizio LoadBalancer rende la tua applicazione disponibile per la porta e l'indirizzo IP del programma di bilanciamento del carico e per le porte del nodo del servizio.
{:shortdesc}

L'indirizzo IP portatile del programma di bilanciamento del carico viene assegnato
automaticamente e non cambia quando aggiungi o rimuovi i nodi di lavoro Il che significa che i servizi del programma di bilanciamento del carico sono più disponibili dei servizi NodePort. Gli utenti possono selezionare qualsiasi porta per
il programma di bilanciamento del carico e non sono limitati all'intervallo di porte di NodePort. Puoi usare i servizi di bilanciamento del carico
per i protocolli TCP e UDP.

**Nota**: i servizi del programma di bilanciamento del carico non supportano la terminazione TLS. Se la tua applicazione richiede la terminazione TLS,
la puoi esporre utilizzando [Ingress](cs_ingress.html) o configurare la tua applicazione per gestire la terminazione TLS.

Prima di iniziare:

-   Questa funzione è disponibile solo per i cluster standard.
-   Devi avere un indirizzo IP pubblico o privato portatile disponibile da assegnare al servizio di bilanciamento del carico.
-   Un servizio del programma di bilanciamento del carico con un indirizzo IP privato portatile dispone ancora di una porta del nodo pubblica aperta per i nodi di lavoro. Per aggiungere una politica di rete per evitare il traffico pubblico, consulta [Blocco del traffico in entrata](cs_network_policy.html#block_ingress).

Per creare un servizio del programma di bilanciamento del carico:

1.  [Distribuisci la tua applicazione al cluster](cs_app.html#app_cli). Quando distribuisci la tua applicazione al cluster,
vengono creati uno o più pod che eseguono la tua applicazione in un
contenitore. Assicurati di aggiungere un'etichetta alla tua distribuzione nella sezione dei metadati del tuo file
di configurazione. Questa etichetta è necessaria per identificare tutti i pod in cui è in esecuzione la tua applicazione, in modo che
possano essere inclusi nel bilanciamento del carico.
2.  Crea un servizio del programma di bilanciamento del carico per l'applicazione che desideri esporre. Per rendere la tua applicazione disponibile
pubblicamente su internet o su una rete privata, crea un servizio Kubernetes per la tua applicazione. Configura il tuo servizio per includere tutti i pod che compongono la tua applicazione nel bilanciamento del carico.
    1.  Crea uno file di configurazione del servizio denominato, ad esempio, `myloadbalancer.yaml`.

    2.  Definisci un servizio del programma di bilanciamento del carico per l'applicazione che vuoi esporre.
        - Se il tuo cluster è su una VLAN pubblica, viene utilizzato un indirizzo IP pubblico portatile. Molti cluster sono su una VLAN pubblica.
        - Se il tuo cluster è disponibile solo su una VLAN privata, viene quindi utilizzato un indirizzo IP privato portatile.
        - Puoi richiedere un indirizzo IP pubblico o privato portatile per un servizio LoadBalancer aggiungendo un'annotazione al file di configurazione.

        Servizio LoadBalancer che utilizza un indirizzo IP predefinito:

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <myservice>
        spec:
          type: LoadBalancer
          selector:
            <selectorkey>:<selectorvalue>
          ports:
           - protocol: TCP
             port: 8080
        ```
        {: codeblock}

        Servizio LoadBalancer che utilizza un'annotazione per specificare un indirizzo IP pubblico o privato:

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: <myservice>
          annotations:
            service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>
        spec:
          type: LoadBalancer
          selector:
            <selectorkey>:<selectorvalue>
          ports:
           - protocol: TCP
             port: 8080
          loadBalancerIP: <private_ip_address>
        ```
        {: codeblock}

        <table>
        <caption>Descrizione dei componenti del servizio del programma di bilanciamento del carico </caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
        </thead>
        <tbody>
        <tr>
          <td><code>name</code></td>
          <td>Sostituisci <em>&lt;myservice&gt;</em> con un nome per il tuo servizio del programma di bilanciamento del carico.</td>
        </tr>
        <tr>
          <td><code>selector</code></td>
          <td>Immetti la coppia di chiave (<em>&lt;selectorkey&gt;</em>) e valore
(<em>&lt;selectorvalue&gt;</em>) dell'etichetta che vuoi utilizzare per indirizzare i pod in cui viene eseguita la tua
applicazione. Ad esempio, se utilizzi il seguente selettore <code>app: code</code>, tutti i pod che hanno
questa etichetta nei rispettivi metadati vengono inclusi nel bilanciamento del carico. Immetti la stessa etichetta che hai utilizzato
quando hai distribuito la tua applicazione al cluster. </td>
        </tr>
        <tr>
          <td><code> port</code></td>
          <td>La porta su cui è in ascolto il servizio.</td>
        </tr>
        <tr>
          <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type:`
          <td>Annotazione per specificare il tipo di LoadBalancer. I valori sono `private` e `public`. Quando crei un LoadBalancer pubblico nei cluster su VLAN pubbliche, questa annotazione non è necessaria.</td>
        </tr>
        <tr>
          <td><code>loadBalancerIP</code></td>
          <td>Quando crei un programma di bilanciamento del carico privato o utilizzi un indirizzo IP portatile specifico per un programma di bilanciamento del carico pubblico, sostituisci <em>&lt;loadBalancerIP&gt;</em> con l'indirizzo IP che vuoi utilizzare. Per ulteriori informazioni, consulta la [documentazione Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/concepts/services-networking/service/#type-loadbalancer).</td>
        </tr>
        </tbody></table>

    3.  Facoltativo: configura un firewall specificando `loadBalancerSourceRanges` nella sezione spec. Per ulteriori informazioni, consulta la [documentazione Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/).

    4.  Crea il servizio nel tuo cluster.

        ```
        kubectl apply -f myloadbalancer.yaml
        ```
        {: pre}

        Quando viene creato il tuo servizio del programma di bilanciamento del carico, viene automaticamente assegnato un
indirizzo IP portatile ad esso. Se non è disponibile alcun indirizzo IP portatile, è impossibile creare il servizio del programma di bilanciamento
del carico.

3.  Verifica che il servizio del programma di bilanciamento del carico sia stato creato correttamente. Sostituisci
_&lt;myservice&gt;_ con il nome del servizio del programma di bilanciamento del carico che hai creato
nel passo precedente.

    ```
    kubectl describe service <myservice>
    ```
    {: pre}

    **Nota:** perché il servizio del programma di bilanciamento del carico venga creato correttamente e l'applicazione sia disponibile potrebbero essere richiesti alcuni minuti.

    Output CLI di esempio:

    ```
    Name:                   <myservice>
    Namespace:              default
    Labels:                 <none>
    Selector:               <selectorkey>=<selectorvalue>
    Type:                   LoadBalancer
    Location:               dal10
    IP:                     10.10.10.90
    LoadBalancer Ingress:   192.168.10.38
    Port:                   <unset> 8080/TCP
    NodePort:               <unset> 32040/TCP
    Endpoints:              172.30.171.87:8080
    Session Affinity:       None
    Events:
    FirstSeen	LastSeen	Count	From			SubObjectPath	Type		Reason			Message
      ---------	--------	-----	----			-------------	--------	------			-------
      10s		10s		1	{service-controller }			Normal		CreatingLoadBalancer	Creating load balancer
      10s		10s		1	{service-controller }			Normal		CreatedLoadBalancer	Created load balancer
    ```
    {: screen}

    L'indirizzo IP **LoadBalancer Ingress** è l'indirizzo IP portatile che è stato assegnato
al tuo servizio del programma di bilanciamento del carico.

4.  Se hai creato un servizio del programma di bilanciamento del carico pubblico, accedi alla tua applicazione da internet.
    1.  Apri il tuo browser web preferito.
    2.  Immetti l'indirizzo IP pubblico portatile del programma di bilanciamento del carico e della porta. Nell'esempio precedente, l'indirizzo IP pubblico portatile `192.168.10.38` è stato assegnato al servizio del programma di bilanciamento del carico.

        ```
        http://192.168.10.38:8080
        ```
        {: codeblock}
