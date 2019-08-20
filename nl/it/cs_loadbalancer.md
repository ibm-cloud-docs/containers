---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

keywords: kubernetes, iks, lb1.0, nlb

subcollection: containers

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
{:preview: .preview}


# Configurazione di un NLB 1.0
{: #loadbalancer}

Esponi una porta e utilizza un indirizzo IP portatile per un NLB (network load balancer) di livello 4 per esporre un'applicazione inserita in un contenitore. Per informazioni sugli NLB versione 1.0, vedi [Componenti e architettura di un NLB 1.0](/docs/containers?topic=containers-loadbalancer-about#v1_planning).
{:shortdesc}

Per iniziare subito, puoi eseguire il seguente comando per creare un programma di bilanciamento del carico 1.0:
```
kubectl expose deploy my-app --port=80 --target-port=8080 --type=LoadBalancer --name my-lb-svc
```
{: pre}

## Configurazione di un NLB 1.0 in un cluster multizona
{: #multi_zone_config}

**Prima di iniziare**:
* Per creare NLB (network load balancer) pubblici in più zone, almeno una VLAN pubblica deve avere delle sottoreti portatili disponibili in ciascuna zona. Per creare NLB privati in più zone, almeno una VLAN privata deve avere delle sottoreti portatili disponibili in ciascuna zona. Puoi aggiungere sottoreti seguendo la procedura in [Configurazione delle sottoreti per i cluster](/docs/containers?topic=containers-subnets).
* Se limiti il traffico di rete ai nodi di lavoro edge, assicurati che almeno 2 [nodi di lavoro edge](/docs/containers?topic=containers-edge#edge) siano abilitati in ogni zona in modo che gli NLB vengano distribuiti in modo uniforme.
* Abilita lo [spanning della VLAN](/docs/infrastructure/vlans?topic=vlans-vlan-spanning#vlan-spanning) per il tuo account dell'infrastruttura IBM Cloud in modo che i tuoi nodi di lavoro possano comunicare tra loro sulla rete privata. Per eseguire questa azione, ti serve l'[autorizzazione dell'infrastruttura](/docs/containers?topic=containers-users#infra_access) **Rete > Gestisci il VLAN Spanning di rete** oppure puoi richiedere al proprietario dell'account di abilitarlo. Per controllare se lo spanning della VLAN è già abilitato, usa il [comando](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get --region <region>`.
* Assicurati di disporre del [ruolo del servizio {{site.data.keyword.cloud_notm}} IAM **Scrittore** o **Gestore**](/docs/containers?topic=containers-users#platform) per lo spazio dei nomi `default`.


Per configurare un servizio NLB 1.0 in un cluster multizona:
1.  [Distribuisci la tua applicazione al cluster](/docs/containers?topic=containers-app#app_cli). Assicurati di aggiungere un'etichetta nella sezione dei metadati del tuo file di configurazione della distribuzione. Questa etichetta è necessaria per identificare tutti i pod in cui è in esecuzione la tua applicazione in modo che possano essere inclusi nel bilanciamento del carico.

2.  Crea un servizio del programma di bilanciamento del carico per l'applicazione che vuoi esporre all'Internet pubblico o a una rete privata.
  1. Crea uno file di configurazione del servizio denominato, ad esempio, `myloadbalancer.yaml`.
  2. Definisci un servizio del programma di bilanciamento del carico per l'applicazione che vuoi esporre. Puoi specificare una zona, una VLAN e un indirizzo IP.

      ```
      apiVersion: v1
      kind: Service
      metadata:
        name: myloadbalancer
        annotations:
          service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>
          service.kubernetes.io/ibm-load-balancer-cloud-provider-zone: "<zone>"
          service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan: "<vlan_id>"
      spec:
        type: LoadBalancer
        selector:
          <selector_key>: <selector_value>
        ports:
         - protocol: TCP
             port: 8080
          loadBalancerIP: <IP_address>
      ```
      {: codeblock}

      <table>
      <caption>Descrizione dei componenti del file YAML</caption>
      <thead>
      <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
      </thead>
      <tbody>
      <tr>
        <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type:</code>
        <td>Annotazione per specificare un programma di bilanciamento del carico <code>private</code> o <code>public</code>.</td>
      </tr>
      <tr>
        <td><code>service.kubernetes.io/ibm-load-balancer-cloud-provider-zone:</code>
        <td>Annotazione per specificare la zona in cui viene distribuito il servizio del programma di bilanciamento del carico. Per vedere le zone, esegui <code>ibmcloud ks zones</code>.</td>
      </tr>
      <tr>
        <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan:`
        <td>Annotazione per specificare una VLAN in cui viene distribuito il servizio del programma di bilanciamento del carico. Per vedere le VLAN, esegui <code>ibmcloud ks vlans --zone <zone></code>.</td>
      </tr>
      <tr>
        <td><code>selector</code></td>
        <td>La chiave (<em>&lt;selector_key&gt;</em>) e il valore (<em>&lt;selector_value&gt;</em>) dell'etichetta che hai utilizzato nella sezione <code>spec.template.metadata.labels</code> dello YAML di distribuzione della tua applicazione.</td>
      </tr>
      <tr>
        <td><code> port</code></td>
        <td>La porta su cui è in ascolto il servizio.</td>
      </tr>
      <tr>
        <td><code>loadBalancerIP</code></td>
        <td>Facoltativo: per creare un programma di bilanciamento del carico privato o per utilizzare uno specifico indirizzo IP portatile per un programma di bilanciamento del carico pubblico, specifica l'indirizzo IP che vuoi utilizzare. L'indirizzo IP deve essere sulla VLAN e sulla zona che specifichi nelle annotazioni. Se non specifichi un indirizzo IP:<ul><li>Se il tuo cluster è su una VLAN pubblica, viene utilizzato un indirizzo IP pubblico portatile. Molti cluster sono su una VLAN pubblica.</li><li>Se il tuo cluster è solo su una VLAN privata, viene utilizzato un indirizzo IP privato portatile.</li></ul></td>
      </tr>
      </tbody></table>

      File di configurazione di esempio per creare un servizio NLB privato 1.0 che utilizza un indirizzo IP specificato sulla VLAN privata `2234945` in `dal12`:

      ```
      apiVersion: v1
      kind: Service
      metadata:
        name: myloadbalancer
        annotations:
          service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: private
          service.kubernetes.io/ibm-load-balancer-cloud-provider-zone: "dal12"
          service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan: "2234945"
      spec:
        type: LoadBalancer
        selector:
          app: nginx
        ports:
         - protocol: TCP
           port: 8080
        loadBalancerIP: 172.21.xxx.xxx
      ```
      {: codeblock}

  3. Facoltativo: rendi disponibile il tuo servizio NLB solo per un intervallo limitato di indirizzi IP, specificando gli IP nel campo `spec.loadBalancerSourceRanges`. `loadBalancerSourceRanges` è implementato da `kube-proxy` nel tuo cluster tramite regole Iptables sui nodi di lavoro. Per ulteriori informazioni, consulta la [documentazione Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/).

  4. Crea il servizio nel tuo cluster.

      ```
      kubectl apply -f myloadbalancer.yaml
      ```
      {: pre}

3. Verifica che il servizio NLB sia stato creato correttamente. Perché il servizio venga creato e l'applicazione sia disponibile potrebbero essere richiesti alcuni minuti.

    ```
    kubectl describe service myloadbalancer
    ```
    {: pre}

    Output CLI di esempio:

    ```
    Name:                   myloadbalancer
    Namespace:              default
    Labels:                 <none>
    Selector:               app=liberty
    Type:                   LoadBalancer
    Zone:                   dal10
    IP:                     172.21.xxx.xxx
    LoadBalancer Ingress:   169.xx.xxx.xxx
    Port:                   <unset> 8080/TCP
    NodePort:               <unset> 32040/TCP
    Endpoints:              172.30.xxx.xxx:8080
    Session Affinity:       None
    Events:
      FirstSeen	LastSeen	Count	From			SubObjectPath	Type	 Reason			          Message
      ---------	--------	-----	----			-------------	----	 ------			          -------
      10s		    10s		    1	    {service-controller }	  Normal CreatingLoadBalancer	Creating load balancer
      10s		    10s		    1	    {service-controller }		Normal CreatedLoadBalancer	Created load balancer
    ```
    {: screen}

    L'indirizzo IP **LoadBalancer Ingress** è l'indirizzo IP portatile assegnato al tuo servizio NLB.

4.  Se hai creato un NLB pubblico, accedi alla tua applicazione da Internet.
    1.  Apri il tuo browser web preferito.
    2.  Immetti l'indirizzo IP pubblico portatile dell'NLB e la porta.

        ```
        http://169.xx.xxx.xxx:8080
        ```
        {: codeblock}    

5. Ripeti i passi da 2 a 4 per aggiungere un NLB versione 1.0 in ciascuna zona.    

6. Se scegli di [abilitare la conservazione dell'IP di origine per un NLB 1.0](#node_affinity_tolerations), assicurati che i pod dell'applicazione vengano pianificati sui nodi di lavoro edge [aggiungendo l'affinità del nodo edge ai pod dell'applicazione](#lb_edge_nodes). I pod dell'applicazione devono essere pianificati nei nodi edge per ricevere le richieste in entrata.

7. Facoltativo: un servizio del programma di bilanciamento del carico rende anche disponibile la tua applicazione sulle NodePort del servizio. Puoi accedere alle [NodePort](/docs/containers?topic=containers-nodeport) da ogni indirizzo IP pubblico e privato per ogni nodo all'interno del cluster. Per bloccare il traffico alle NodePort mentre stai usando un servizio NLB, vedi [Controllo del traffico in entrata nei servizi NLB (network load balancer) o NodePort](/docs/containers?topic=containers-network_policies#block_ingress).

Successivamente, puoi [registrare un nome host NLB](/docs/containers?topic=containers-loadbalancer_hostname).

<br />


## Configurazione di un NLB 1.0 in un cluster a zona singola
{: #lb_config}

**Prima di iniziare**:
* Devi avere un indirizzo IP pubblico o privato portatile disponibile da assegnare al servizio NLB (network load balancer). Per ulteriori informazioni, vedi [Configurazione delle sottoreti per i cluster](/docs/containers?topic=containers-subnets).
* Assicurati di disporre del [ruolo del servizio {{site.data.keyword.cloud_notm}} IAM **Scrittore** o **Gestore**](/docs/containers?topic=containers-users#platform) per lo spazio dei nomi `default`.

Per creare un servizio NLB 1.0 in un cluster a zona singola:

1.  [Distribuisci la tua applicazione al cluster](/docs/containers?topic=containers-app#app_cli). Assicurati di aggiungere un'etichetta alla tua distribuzione nella sezione dei metadati del tuo file
di configurazione. Questa etichetta è necessaria per identificare tutti i pod in cui è in esecuzione la tua applicazione, in modo che
possano essere inclusi nel bilanciamento del carico.
2.  Crea un servizio del programma di bilanciamento del carico per l'applicazione che vuoi esporre all'Internet pubblico o a una rete privata.
    1.  Crea uno file di configurazione del servizio denominato, ad esempio, `myloadbalancer.yaml`.

    2.  Definisci un servizio del programma di bilanciamento del carico per l'applicazione che vuoi esporre.
        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: myloadbalancer
          annotations:
            service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: <public_or_private>
            service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan: "<vlan_id>"
        spec:
          type: LoadBalancer
          selector:
            <selector_key>: <selector_value>
          ports:
           - protocol: TCP
             port: 8080
          loadBalancerIP: <IP_address>
          externalTrafficPolicy: Local
        ```
        {: codeblock}

        <table>
        <caption>Descrizione dei componenti del file YAML</caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti del file YAML</th>
        </thead>
        <tbody>
        <tr>
          <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type:`
          <td>Annotazione per specificare un programma di bilanciamento del carico <code>private</code> o <code>public</code>.</td>
        </tr>
        <tr>
          <td>`service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan:`
          <td>Annotazione per specificare una VLAN in cui viene distribuito il servizio del programma di bilanciamento del carico. Per vedere le VLAN, esegui <code>ibmcloud ks vlans --zone <zone></code>.</td>
        </tr>
        <tr>
          <td><code>selector</code></td>
          <td>La chiave (<em>&lt;selector_key&gt;</em>) e il valore (<em>&lt;selector_value&gt;</em>) dell'etichetta che hai utilizzato nella sezione <code>spec.template.metadata.labels</code> dello YAML di distribuzione della tua applicazione.</td>
        </tr>
        <tr>
          <td><code> port</code></td>
          <td>La porta su cui è in ascolto il servizio.</td>
        </tr>
        <tr>
          <td><code>loadBalancerIP</code></td>
          <td>Facoltativo: per creare un programma di bilanciamento del carico privato o per utilizzare uno specifico indirizzo IP portatile per un programma di bilanciamento del carico pubblico, specifica l'indirizzo IP che vuoi utilizzare. L'indirizzo IP deve essere sulla VLAN che specifichi nelle annotazioni. Se non specifichi un indirizzo IP:<ul><li>Se il tuo cluster è su una VLAN pubblica, viene utilizzato un indirizzo IP pubblico portatile. Molti cluster sono su una VLAN pubblica.</li><li>Se il tuo cluster è solo su una VLAN privata, viene utilizzato un indirizzo IP privato portatile.</li></ul></td>
        </tr>
        </tbody></table>

        File di configurazione di esempio per creare un servizio NLB 1.0 privato che utilizza un indirizzo IP specificato sulla VLAN privata `2234945`:

        ```
        apiVersion: v1
        kind: Service
        metadata:
          name: myloadbalancer
          annotations:
            service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: private
            service.kubernetes.io/ibm-load-balancer-cloud-provider-vlan: "2234945"
        spec:
          type: LoadBalancer
          selector:
            app: nginx
          ports:
           - protocol: TCP
             port: 8080
          loadBalancerIP: 172.21.xxx.xxx
        ```
        {: codeblock}

    3. Facoltativo: rendi disponibile il tuo servizio NLB solo per un intervallo limitato di indirizzi IP, specificando gli IP nel campo `spec.loadBalancerSourceRanges`. `loadBalancerSourceRanges` è implementato da `kube-proxy` nel tuo cluster tramite regole Iptables sui nodi di lavoro. Per ulteriori informazioni, consulta la [documentazione Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/tasks/access-application-cluster/configure-cloud-provider-firewall/).

    4.  Crea il servizio nel tuo cluster.

        ```
        kubectl apply -f myloadbalancer.yaml
        ```
        {: pre}

3.  Verifica che il servizio NLB sia stato creato correttamente. Perché il servizio venga creato e l'applicazione sia disponibile potrebbero essere richiesti alcuni minuti.

    ```
    kubectl describe service myloadbalancer
    ```
    {: pre}

    Output CLI di esempio:

    ```
    Name:                   myloadbalancer
    Namespace:              default
    Labels:                 <none>
    Selector:               app=liberty
    Type:                   LoadBalancer
    Location:               dal10
    IP:                     172.21.xxx.xxx
    LoadBalancer Ingress:   169.xx.xxx.xxx
    Port:                   <unset> 8080/TCP
    NodePort:               <unset> 32040/TCP
    Endpoints:              172.30.xxx.xxx:8080
    Session Affinity:       None
    Events:
      FirstSeen	LastSeen	Count	From			SubObjectPath	Type	 Reason			          Message
      ---------	--------	-----	----			-------------	----	 ------			          -------
      10s		    10s		    1	    {service-controller }	  Normal CreatingLoadBalancer	Creating load balancer
      10s		    10s		    1	    {service-controller }		Normal CreatedLoadBalancer	Created load balancer
    ```
    {: screen}

    L'indirizzo IP **LoadBalancer Ingress** è l'indirizzo IP portatile assegnato al tuo servizio NLB.

4.  Se hai creato un NLB pubblico, accedi alla tua applicazione da Internet.
    1.  Apri il tuo browser web preferito.
    2.  Immetti l'indirizzo IP pubblico portatile dell'NLB e la porta.

        ```
        http://169.xx.xxx.xxx:8080
        ```
        {: codeblock}

5. Se scegli di [abilitare la conservazione dell'IP di origine per un NLB 1.0](#node_affinity_tolerations), assicurati che i pod dell'applicazione vengano pianificati sui nodi di lavoro edge [aggiungendo l'affinità del nodo edge ai pod dell'applicazione](#lb_edge_nodes). I pod dell'applicazione devono essere pianificati nei nodi edge per ricevere le richieste in entrata.

6. Facoltativo: un servizio del programma di bilanciamento del carico rende anche disponibile la tua applicazione sulle NodePort del servizio. Puoi accedere alle [NodePort](/docs/containers?topic=containers-nodeport) da ogni indirizzo IP pubblico e privato per ogni nodo all'interno del cluster. Per bloccare il traffico alle NodePort mentre stai usando un servizio NLB, vedi [Controllo del traffico in entrata nei servizi NLB (network load balancer) o NodePort](/docs/containers?topic=containers-network_policies#block_ingress).

Successivamente, puoi [registrare un nome host NLB](/docs/containers?topic=containers-loadbalancer_hostname#loadbalancer_hostname).

<br />


## Abilitazione della conservazione dell'IP di origine
{: #node_affinity_tolerations}

Questa funzione è disponibile solo per gli NLB versione 1.0. L'indirizzo IP di origine delle richieste del client viene conservato per impostazione predefinita negli NLB versione 2.0.
{: note}

Quando una richiesta del client alla tua applicazione viene inviata al tuo cluster, un pod del servizio del programma di bilanciamento del carico riceve la richiesta. Se sullo stesso nodo di lavoro del pod del servizio del programma di bilanciamento del carico non esiste un pod dell'applicazione, l'NLB inoltra la richiesta a un pod dell'applicazione su un nodo di lavoro diverso. L'indirizzo IP di origine del pacchetto viene modificato con l'indirizzo IP pubblico del nodo di lavoro su cui è in esecuzione il pod del servizio del programma di bilanciamento del carico.
{: shortdesc}

Per conservare l'indirizzo IP di origine originale della richiesta client, puoi [abilitare l'IP di origine ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/#preserving-the-client-source-ip) per i servizi del programma di bilanciamento del carico. La connessione TCP continua fino ai pod dell'applicazione in modo che l'applicazione possa vedere l'indirizzo IP di origine effettivo dell'initiator. La conservazione dell'IP del client è utile quando, ad esempio, i server delle applicazioni devono applicare le politiche di sicurezza e di controllo dell'accesso.

Una volta abilitato l'IP di origine, i pod del servizio di bilanciamento del carico devono inoltrare le richieste solo ai pod dell'applicazione che sono distribuiti nello stesso nodo di lavoro Di norma, i pod del servizio del programma di bilanciamento del carico vengono distribuiti anche ai nodi di lavoro a cui vengono distribuiti i pod dell'applicazione. Tuttavia, ci sono alcune situazioni in cui i pod del bilanciamento del carico e quelli dell'applicazione potrebbero non essere pianificati sullo stesso nodo di lavoro:

* Hai nodi edge contaminati in cui puoi distribuire solo i pod del servizio di bilanciamento del carico. I pod dell'applicazione non possono essere distribuiti in questi nodi.
* Il tuo cluster è connesso a più VLAN pubbliche o private e i tuoi pod dell'applicazione possono essere distribuiti ai nodi di lavoro che sono connessi solo ad una VLAN. I pod del servizio di bilanciamento del carico non possono essere distribuiti in tali nodi di lavoro in quanto l'indirizzo IP dell'NLB è connesso a una VLAN diversa da quella dei nodi di lavoro.

Per forzare la tua applicazione alla distribuzione in specifici nodi di lavoro in cui possono essere distribuiti anche i pod del servizio di bilanciamento del carico, devi aggiungere le regole di affinità e le tolleranze alla tua distribuzione dell'applicazione.

### Aggiunta delle regole di affinità e delle tolleranze del nodo edge
{: #lb_edge_nodes}

Quando [etichetti i nodi di lavoro come nodi edge](/docs/containers?topic=containers-edge#edge_nodes) e inoltre [danneggi i nodi edge](/docs/containers?topic=containers-edge#edge_workloads), i pod del servizio del programma di bilanciamento del carico vengono distribuiti solo in tali nodi edge e i pod dell'applicazione non possono essere distribuiti nei nodi edge. Quando l'IP di origine viene abilitato per il servizio NLB, i pod del programma di bilanciamento del carico nei nodi edge non possono inoltrare le richieste in entrata ai pod della tua applicazione su altri nodi di lavoro.
{:shortdesc}

Per forzare la distribuzione dei tuoi pod dell'applicazione nei nodi edge, aggiungi la [regola di affinità ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#node-affinity-beta-feature) e la [tolleranza ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/#concepts) del nodo edge alla distribuzione dell'applicazione.

Esempio di file YAML di distribuzione con affinità e tolleranza del nodo edge:

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: with-node-affinity
spec:
  selector:
    matchLabels:
      <label_name>: <label_value>
  template:
    spec:
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
            - matchExpressions:
              - key: dedicated
                operator: In
                values:
                - edge
      tolerations:
        - key: dedicated
          value: edge
...
```
{: codeblock}

Entrambe le sezioni **affinity** e **tolerations** hanno `dedicated` come `key` e `edge` come `value`.

### Aggiunta di regole di affinità per più VLAN pubbliche o private
{: #edge_nodes_multiple_vlans}

Quando il tuo cluster è connesso a più VLAN pubbliche o private, i tuoi pod dell'applicazione possono essere distribuiti solo nei nodi di lavoro connessi ad una VLAN. Se l'indirizzo IP dell'NLB è connesso a una VLAN diversa da quella di questi nodi di lavoro, i pod del servizio di bilanciamento del carico non vengono distribuiti in questi nodi.
{:shortdesc}

Quando l'IP di origine è abilitato, pianifica i pod dell'applicazione sui nodi di lavoro che si trovano nella stessa VLAN dell'indirizzo IP dell'NLB aggiungendo una regola di affinità alla distribuzione dell'applicazione.

Prima di iniziare: [accedi al tuo account. Se applicabile, specifica il gruppo di risorse appropriato. Imposta il contesto per il tuo cluster.](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure)

1. Ottieni l'indirizzo IP del servizio NLB. Ricerca l'indirizzo IP nel campo **LoadBalancer Ingress**.
    ```
    kubectl describe service <loadbalancer_service_name>
    ```
    {: pre}

2. Richiama l'ID VLAN a cui è connesso il tuo servizio NLB.

    1. Elenca le VLAN pubbliche portatili per il tuo cluster.
        ```
        ibmcloud ks cluster-get --cluster <cluster_name_or_ID> --showResources
        ```
        {: pre}

        Output di esempio:
        ```
        ...

        Subnet VLANs
        VLAN ID   Subnet CIDR       Public   User-managed
        2234947   10.xxx.xx.xxx/29  false    false
        2234945   169.36.5.xxx/29   true     false
        ```
        {: screen}

    2. Nell'output, sotto **Subnet VLANs**, ricerca il CIDR di sottorete che corrisponde all'indirizzo IP NLB che hai recuperato in precedenza e prendi nota dell'ID VLAN.

        Ad esempio, se l'indirizzo IP del servizio NLB è `169.36.5.xxx`, la sottorete corrispondente nell'output di esempio del precedente passo è `169.36.5.xxx/29`. L'ID VLAN a cui è connessa la sottorete è `2234945`.

3. [Aggiungi una regola di affinità ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#node-affinity-beta-feature) alla distribuzione dell'applicazione per l'ID VLAN di cui hai preso nota nel passo precedente.

    Ad esempio, se hai più VLAN ma desideri che i tuoi pod dell'applicazione vengano distribuiti solo nei nodi di lavoro presenti sulla VLAN pubblica `2234945`:

    ```
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: with-node-affinity
    spec:
      selector:
        matchLabels:
          <label_name>: <label_value>
      template:
        spec:
          affinity:
            nodeAffinity:
              requiredDuringSchedulingIgnoredDuringExecution:
                nodeSelectorTerms:
                - matchExpressions:
                  - key: publicVLAN
                    operator: In
                    values:
                    - "2234945"
    ...
    ```
    {: codeblock}

    Nel file YAML di esempio, la sezione **affinity** ha `publicVLAN` come `key` e `"2234945"` come `value`.

4. Applica il file di configurazione della distribuzione aggiornato.
    ```
    kubectl apply -f with-node-affinity.yaml
    ```
    {: pre}

5. Verifica che i pod dell'applicazione vengano distribuiti nei nodi di lavoro connessi alla VLAN designata.

    1. Elenca i pod nel tuo cluster. Sostituisci `<selector>` con l'etichetta che hai utilizzato per l'applicazione.
        ```
        kubectl get pods -o wide app=<selector>
        ```
        {: pre}

        Output di esempio:
        ```
        NAME                   READY     STATUS              RESTARTS   AGE       IP               NODE
        cf-py-d7b7d94db-vp8pq  1/1       Running             0          15d       172.30.xxx.xxx   10.176.48.78
        ```
        {: screen}

    2. Nell'output, identifica un pod per la tua applicazione. Prendi nota dell'ID **NODE** del nodo di lavoro in cui il pod è attivo.

        Nell'output di esempio del passo precedente, il pod dell'applicazione `cf-py-d7b7d94db-vp8pq` si trova sul nodo di lavoro `10.176.48.78`.

    3. Elenca i dettagli del nodo di lavoro.

        ```
        kubectl describe node <worker_node_ID>
        ```
        {: pre}

        Output di esempio:

        ```
        Name:                   10.xxx.xx.xxx
        Role:
        Labels:                 arch=amd64
                                beta.kubernetes.io/arch=amd64
                                beta.kubernetes.io/os=linux
                                failure-domain.beta.kubernetes.io/region=us-south
                                failure-domain.beta.kubernetes.io/zone=dal10
                                ibm-cloud.kubernetes.io/encrypted-docker-data=true
                                kubernetes.io/hostname=10.xxx.xx.xxx
                                privateVLAN=2234945
                                publicVLAN=2234967
        ...
        ```
        {: screen}

    4. Nella sezione **Labels** dell'output, verifica che la VLAN pubblica o privata sia la VLAN che hai designato nei passi precedenti.
