---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-12"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Configurazione delle sottoreti per i cluster 
{: #subnets}

Modifica il pool di indirizzi IP pubblici o privati portatili disponibili aggiungendo sottoreti al tuo cluster.
{:shortdesc}

In {{site.data.keyword.containershort_notm}}, puoi aggiungere IP portatili
stabili per i servizi Kubernetes aggiungendo delle sottoreti di rete al cluster. In questo caso, le sottoreti non stanno venendo utilizzate con il netmasking per creare la connettività tra uno o più cluster. Invece, le sottoreti sono utilizzate per fornire IP fissi permanenti per un servizio da un cluster che può essere utilizzato per accedere a tale servizio.

Quando crei un cluster standard, {{site.data.keyword.containershort_notm}} fornisce automaticamente una sottorete pubblica portatile con 5 indirizzi IP pubblici e una sottorete privata portatile con 5 indirizzi IP privati. Gli indirizzi IP pubblici e privati portatili sono statici e non cambiano quando viene rimosso un nodo di lavoro o il cluster. Per ogni sottorete, uno degli indirizzi IP pubblici portatili e uno di quelli privati portatili vengono utilizzati per i [programmi di bilanciamento del carico dell'applicazione](cs_ingress.html) che puoi utilizzare per esporre più applicazioni nel tuo cluster. I restanti 4 indirizzi IP pubblici portatili e 4 privati portatili possono essere utilizzati per esporre al pubblico singole applicazioni [creando un servizio di bilanciamento del carico](cs_loadbalancer.html).

**Nota:** gli indirizzi IP pubblici portatili vengono addebitati mensilmente. Se scegli di rimuovere gli indirizzi IP pubblici portatili
dopo il provisioning del tuo cluster, devi comunque pagare l'addebito mensile, anche se li hai utilizzati
solo per un breve periodo di tempo.

## Richiesta di ulteriori sottoreti per il tuo cluster
{: #request}

Puoi aggiungere stabili IP pubblici o privati portatili al cluster assegnando ad esso delle sottoreti.

**Nota:** quando rendi disponibile una sottorete a un cluster, gli indirizzi IP
di questa sottorete vengono utilizzati per scopi di rete cluster. Per evitare conflitti di indirizzi IP, assicurati
di utilizzare una sottorete con un solo cluster. Non utilizzare una sottorete per più cluster o per altri
scopi al di fuori di {{site.data.keyword.containershort_notm}}
contemporaneamente.

Prima di iniziare, [indirizza la tua CLI](cs_cli_install.html#cs_cli_configure) al tuo cluster.

Per creare una sottorete in un account dell'infrastruttura IBM Cloud (SoftLayer) e renderla disponibile per un cluster specificato: 

1. Esegui il provisioning di una sottorete.

    ```
    bx cs cluster-subnet-create <cluster_name_or_id> <subnet_size> <VLAN_ID>
    ```
    {: pre}

    <table>
    <caption>Descrizione dei componenti di questo comando</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti di questo comando</th>
    </thead>
    <tbody>
    <tr>
    <td><code>cluster-subnet-create</code></td>
    <td>Il comando per eseguire il provisioning di una sottorete per il tuo cluster.</td>
    </tr>
    <tr>
    <td><code><em>&lt;cluster_name_or_id&gt;</em></code></td>
    <td>Sostituisci <code>&lt;cluster_name_or_id&gt;</code> con il nome o l'ID del cluster. </td>
    </tr>
    <tr>
    <td><code><em>&lt;subnet_size&gt;</em></code></td>
    <td>Sostituisci <code>&lt;subnet_size&gt;</code> con il numero di indirizzi IP che vuoi aggiungere dalla tua sottorete portatile. I valori accettati sono 8, 16, 32 o 64. <p>**Nota:** quando aggiungi gli indirizzi IP portatili per la tua sottorete, tre indirizzi IP vengono utilizzati per stabilire un collegamento di rete interno al cluster, pertanto non puoi utilizzarli per il tuo programma di bilanciamento del carico dell'applicazione o per creare un servizio di bilanciamento del carico. Ad esempio, se richiedi otto indirizzi IP pubblici portatili, puoi utilizzarne cinque per
esporre le tue applicazioni pubblicamente.</p> </td>
    </tr>
    <tr>
    <td><code><em>&lt;VLAN_ID&gt;</em></code></td>
    <td>Sostituisci <code>&lt;VLAN_ID&gt;</code> con l'ID della VLAN pubblica o privata su cui vuoi assegnare gli indirizzi IP pubblici o privati portatili. Devi selezionare la VLAN pubblica o privata a cui è connesso un nodo di lavoro esistente. Per controllare la VLAN pubblica o privata per un nodo di lavoro, esegui il comando <code>bx cs worker-get &lt;worker_id&gt;</code>. </td>
    </tr>
    </tbody></table>

2.  Verifica che la sottorete sia stata creata e aggiunta correttamente al tuo cluster. Il CIDR della sottorete viene elencato nella sezione **VLAN**.

    ```
    bx cs cluster-get --showResources <cluster name or id>
    ```
    {: pre}

<br />


## Aggiunta di sottoreti personalizzate ed esistenti ai cluster Kubernetes
{: #custom}

Puoi aggiungere sottoreti pubbliche o private portatili esistenti al tuo cluster Kubernetes.

Prima di iniziare, [indirizza la tua CLI](cs_cli_install.html#cs_cli_configure) al tuo cluster.

Se hai una sottorete esistente nel tuo portfolio dell'infrastruttura IBM Cloud (SoftLayer) con regole firewall personalizzate o indirizzi IP disponibili che vuoi utilizzare, crea un cluster senza sottoreti e rendi disponibile la tua sottorete esistente al cluster durante il provisioning.

1.  Identifica la sottorete da utilizzare. Nota l'ID della sottorete e l'ID della VLAN. In questo esempio, l'ID sottorete è 807861 e
l'ID VLAN è 1901230.

    ```
    bx cs subnets
    ```
    {: pre}

    ```
    Getting subnet list...
    OK
    ID        Network                                      Gateway                                   VLAN ID   Type      Bound Cluster   
    553242    203.0.113.0/24                               10.87.15.00                               1565280   private      
    807861    192.0.2.0/24                                 10.121.167.180                            1901230   public

    ```
    {: screen}

2.  Conferma l'ubicazione della VLAN. In questo esempio, l'ubicazione è dal10.

    ```
    bx cs vlans dal10
    ```
    {: pre}

    ```
    Getting VLAN list...
    OK
    ID        Name                  Number   Type      Router   
    1900403   vlan                    1391     private   bcr01a.dal10   
    1901230   vlan                    1180     public   fcr02a.dal10
    ```
    {: screen}

3.  Crea un cluster utilizzando l'ubicazione e l'ID VLAN che hai identificato. Includi l'indicatore `--no-subnet` per impedire la creazione automatica di una nuova sottorete IP pubblica portatile e di una nuova sottorete IP privata portatile.

    ```
    bx cs cluster-create --location dal10 --machine-type u2c.2x4 --no-subnet --public-vlan 1901230 --private-vlan 1900403 --workers 3 --name my_cluster
    ```
    {: pre}

4.  Verifica che la creazione del cluster sia stata richiesta.

    ```
    bx cs clusters
    ```
    {: pre}

    **Nota:** servono fino a 15 minuti perché le macchine del nodo di lavoro siano ordinate e che il cluster
sia configurato e ne sia stato eseguito il provisioning al tuo account.

    Quando è stato terminato il provisioning del tuo cluster,
lo stato del tuo cluster viene modificato in **distribuito**.

    ```
    Name         ID                                   State      Created          Workers   
    my_cluster   paf97e8843e29941b49c598f516de72101   deployed   20170201162433   3
    ```
    {: screen}

5.  Controlla lo stato dei nodi di lavoro.

    ```
    bx cs workers <cluster>
    ```
    {: pre}

    Quando i nodi di lavoro sono pronti, la condizione
passa a **normale** e lo stato è **Pronto**. Quando lo stato del nodo è **Pronto**,
puoi accedere al
cluster.

    ```
    ID                                                  Public IP        Private IP     Machine Type   State      Status  
    prod-dal10-pa8dfcc5223804439c87489886dbbc9c07-w1   169.47.223.113   10.171.42.93   free           normal    Ready
    ```
    {: screen}

6.  Aggiungi la sottorete al tuo cluster specificando l'ID sottorete. Quando rendi disponibile una sottorete a un
cluster, per te viene creata una mappa di configurazione Kubernetes che include tutti gli indirizzi IP pubblici
portatili che puoi utilizzare. Se ancora non esiste alcun programma di bilanciamento del carico dell'applicazione per il tuo cluster, viene automaticamente utilizzato un indirizzo IP pubblico portatile e uno privato per creare i programmi di bilanciamento del carico dell'applicazione pubblico e privato. Tutti gli altri indirizzi IP pubblici e privati portatili possono essere utilizzati per creare i servizi del programma di bilanciamento del carico per le tue applicazioni.

    ```
    bx cs cluster-subnet-add mycluster 807861
    ```
    {: pre}

<br />


## Aggiunta delle sottoreti gestite dall'utente e degli indirizzi IP ai cluster Kubernetes
{: #user_managed}

Fornisci la tua propria sottorete da una rete in loco a cui desideri che {{site.data.keyword.containershort_notm}} acceda. Dopodiché, puoi aggiungere indirizzi IP privati da tale sottorete ai servizi del programma di bilanciamento del carico nel tuo cluster Kubernetes.

Requisiti:
- Le sottoreti gestite dall'utente possono essere aggiunte solo a VLAN private.
- Il limite di lunghezza del prefisso della sottorete è da /24 a /30. Ad esempio, `203.0.113.0/24` specifica 253 indirizzi IP privati utilizzabili, mentre `203.0.113.0/30` specifica 1 indirizzo IP privato utilizzabile.
- Il primo indirizzo IP nella sottorete deve essere utilizzato come gateway della sottorete.

Prima di iniziare:
- Configura l'instradamento del traffico di rete in entrata e in uscita della sottorete esterna. 
- Conferma di disporre di una connettività VPN tra il dispositivo gateway del data center in loco e il Vyatta della rete privata nel tuo portfolio dell'infrastruttura IBM Cloud (SoftLayer) o il servizio VPN Strongswan in esecuzione sul tuo cluster. Per utilizzare un Vyatta, consulta questo post del blog [ ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.ibm.com/blogs/bluemix/2017/07/kubernetes-and-bluemix-container-based-workloads-part4/)]. Per utilizzare Strongswan, consulta [Configurazione della connettività VPN con il servizio VPN IPSec Strongswan](cs_vpn.html).

1. Visualizza l'ID della VLAN privata del tuo cluster. Individua la sezione **VLAN**. Nel campo **User-managed**, identifica l'ID della VLAN con _false_.

    ```
    bx cs cluster-get --showResources <cluster_name>
    ```
    {: pre}

    ```
    VLANs
    VLAN ID   Subnet CIDR         Public       User-managed
    1555503   192.0.2.0/24        true         false
    1555505   198.51.100.0/24     false        false
    ```
    {: screen}

2. Aggiungi la sottorete esterna alla tua VLAN privata. Gli indirizzi IP privati portatili vengono aggiunti alla mappa di configurazione del cluster.

    ```
    bx cs cluster-user-subnet-add <cluster_name> <subnet_CIDR> <VLAN_ID>
    ```
    {: pre}

    Esempio:

    ```
    bx cs cluster-user-subnet-add my_cluster 203.0.113.0/24 1555505
    ```
    {: pre}

3. Verifica che la sottorete fornita dall'utente sia stata aggiunta. Il campo **User-managed** è _true_.

    ```
    bx cs cluster-get --showResources <cluster_name>
    ```
    {: pre}

    ```
    VLANs
    VLAN ID   Subnet CIDR         Public       User-managed
    1555503   192.0.2.0/24        true         false
    1555505   198.51.100.0/24     false        false
    1555505   203.0.113.0/24      false        true
    ```
    {: screen}

4. Aggiungi un servizio del programma di bilanciamento del carico dell'applicazione a un programma di bilanciamento del carico Ingress privato per accedere alla tua applicazione su una rete privata. Se desideri utilizzare un indirizzo IP privato dalla sottorete che hai aggiunto, devi specificare un indirizzo IP quando crei un programma di bilanciamento del carico privato o un programma di bilanciamento del carico Ingress privato. Diversamente, viene scelto a caso un indirizzo IP dalle sottoreti dell'infrastruttura IBM Cloud (SoftLayer) o dalle sottoreti fornite dall'utente sulla VLAN privata. Per ulteriori informazioni, consulta [Configurazione dell'accesso a un'applicazione utilizzando il tipo di servizio LoadBalancer](cs_loadbalancer.html#config) o [Abilitazione del programma di bilanciamento del carico dell'applicazione privato](cs_ingress.html#private_ingress).

<br />


## Gestione di sottoreti e indirizzi IP
{: #manage}

Puoi utilizzare le sottoreti private e pubbliche e gli indirizzi IP per esporre le applicazioni nel tuo cluster e renderle accessibili da internet o da una rete privata.
{:shortdesc}

In {{site.data.keyword.containershort_notm}}, puoi aggiungere IP portatili
stabili per i servizi Kubernetes aggiungendo delle sottoreti di rete al cluster. Quando crei un cluster standard, {{site.data.keyword.containershort_notm}} fornisce automaticamente una sottorete pubblica portatile con 5 indirizzi IP pubblici portatili e una sottorete privata portatile con 5 indirizzi IP privati portatili. Gli indirizzi IP portatili sono
statici e non cambiano alla rimozione di un nodo di lavoro o di un cluster.

Due degli indirizzi IP portatili, uno pubblico e uno privato, vengono utilizzati per i [programmi di bilanciamento del carico dell'applicazione Ingress](cs_ingress.html) che puoi usare per esporre più applicazioni nel tuo cluster. 4 indirizzi IP pubblici portatili e 4 indirizzi IP privati portatili possono essere utilizzati per esporre le applicazioni [creando un servizio di bilanciamento del carico](cs_loadbalancer.html).

**Nota:** gli indirizzi IP pubblici portatili vengono addebitati mensilmente. Se scegli di rimuovere gli indirizzi IP pubblici portatili
dopo il provisioning del tuo cluster, devi comunque pagare l'addebito mensile, anche se li hai utilizzati
solo per un breve periodo di tempo.



1.  Crea un file di configurazione del servizio Kubernetes denominato
`myservice.yaml` e definisci un servizio di tipo `LoadBalancer` con
un indirizzo IP del programma di bilanciamento del carico fittizio. Il seguente esempio utilizza l'indirizzo IP 1.1.1.1 come
indirizzo IP del programma di bilanciamento del carico.

    ```
    apiVersion: v1
    kind: Service
    metadata:
      labels:
        run: myservice
      name: myservice
      namespace: default
    spec:
      ports:
      - port: 80
        protocol: TCP
        targetPort: 80
      selector:
        run: myservice
      sessionAffinity: None
      type: LoadBalancer
      loadBalancerIP: 1.1.1.1
    ```
    {: codeblock}

2.  Crea il servizio nel tuo cluster.

    ```
    kubectl apply -f myservice.yaml
    ```
    {: pre}

3.  Controlla il servizio.

    ```
    kubectl describe service myservice
    ```
    {: pre}

    **Nota:** la creazione di questo servizio non riesce perché il master Kubernetes non può trovare l'indirizzo
IP del programma di bilanciamento del carico specificato nella mappa di configurazione Kubernetes. Quando esegui questo comando, puoi visualizzare il
messaggio di errore e l'elenco di indirizzi IP pubblici disponibili per il cluster.

    ```
    Error on cloud load balancer a8bfa26552e8511e7bee4324285f6a4a for service default/myservice with UID 8bfa2655-2e85-11e7-bee4-324285f6a4af: Requested cloud provider IP 1.1.1.1 is not available. The following cloud provider IPs are available: <list_of_IP_addresses>
    ```
    {: screen}

<br />




## Liberazione degli indirizzi IP utilizzati
{: #free}

Puoi liberare un indirizzo IP portatile utilizzato eliminando il servizio di bilanciamento del carico
che utilizza tale indirizzo IP.

Prima di iniziare, [imposta il contesto per il cluster che desideri utilizzare.](cs_cli_install.html#cs_cli_configure)

1.  Elenca i servizi disponibili nel tuo cluster.

    ```
    kubectl get services
    ```
    {: pre}

2.  Rimuovi il servizio di bilanciamento del carico che utilizza un indirizzo IP pubblico o privato.

    ```
    kubectl delete service <myservice>
    ```
    {: pre}
