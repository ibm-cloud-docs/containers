---

copyright:
  years: 2014, 2018
lastupdated: "2018-10-25"

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

Modifica il pool di indirizzi IP pubblici e privati portatili disponibili per i servizi del programma di bilanciamento del carico aggiungendo sottoreti al tuo cluster Kubernetes.
{:shortdesc}

## VLAN, sottoreti e IP predefiniti per i cluster
{: #default_vlans_subnets}

Durante la creazione del cluster, i nodi di lavoro del cluster e le sottoreti predefinite vengono automaticamente connessi a una VLAN.

### VLAN
{: #vlans}

Quando crei un cluster, i nodi di lavoro del cluster vengono connessi automaticamente a una VLAN. Una VLAN configura un gruppo di nodi di lavoro e pod come se fossero collegati allo stesso cavo fisico e fornisce un canale per la connettività tra i nodi di lavoro e i pod.

<dl>
<dt>VLAN per i cluster gratuiti</dt>
<dd>Per i cluster gratuiti, i nodi di lavoro del cluster sono connessi a una VLAN privata e a una VLAN pubblica di proprietà di IBM per impostazione predefinita. Poiché IBM controlla le VLAN, le sottoreti e gli indirizzi IP, non puoi creare dei cluster multizona o aggiungere sottoreti al tuo cluster e puoi solo utilizzare i servizi NodePort per esporre la tua applicazione.</dd>
<dt>VLAN per i cluster standard</dt>
<dd>Nei cluster standard, la prima volta che crei un cluster in una zona, viene automaticamente eseguito il provisioning di una VLAN pubblica e di una VLAN privata in tale zona per tuo conto nel tuo account dell'infrastruttura IBM Cloud (SoftLayer). Per ogni cluster successivo che crei in tale zona, puoi riutilizzare la stessa VLAN pubblica e privata perché più cluster possono condividere le VLAN.</br></br>Puoi collegare i tuoi nodi di lavoro a una VLAN pubblica e alla VLAN privata o solo alla VLAN privata. Se vuoi collegare i tuoi nodi di lavoro solo a una VLAN privata, puoi utilizzare l'ID di una VLAN privata esistente o [creare una VLAN privata](/docs/cli/reference/ibmcloud/cli_vlan.html#ibmcloud-sl-vlan-create) e utilizzare l'ID durante la creazione del cluster.</dd></dl>

Per visualizzare le VLAN di cui viene eseguito il provisioning in ciascuna zona per il tuo account, esegui `ibmcloud ks vlans <zone>.` Per visualizzare le VLAN su cui viene eseguito il provisioning di un singolo cluster, esegui `ibmcloud ks cluster-get <cluster_name_or_ID> --showResources` e cerca la sezione **Subnet VLANs**.

**Nota**:
* Se hai più VLAN per un cluster, più sottoreti sulla stessa VLAN o un cluster multizona, devi abilitare lo [spanning della VLAN](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) per il tuo account dell'infrastruttura IBM Cloud (SoftLayer) in modo che i tuoi nodi di lavoro possano comunicare tra loro sulla rete privata. Per eseguire questa azione, ti serve l'[autorizzazione dell'infrastruttura](cs_users.html#infra_access) **Rete > Gestisci il VLAN Spanning di rete** oppure puoi richiedere al proprietario dell'account di abilitarlo. Per controllare se lo spanning di VLAN è già abilitato, usa il [comando](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`. Se stai utilizzando {{site.data.keyword.BluDirectLink}}, devi invece utilizzare una [VRF (Virtual Router Function)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf). Per abilitare la VRF, contatta il tuo rappresentante dell'account dell'infrastruttura IBM Cloud (SoftLayer).
* L'infrastruttura IBM Cloud (SoftLayer) gestisce le VLAN di cui viene eseguito automaticamente il provisioning quando crei il tuo primo cluster in una zona. Se lasci che una VLAN diventi inutilizzata, come ad esempio rimuovendo tutti i nodi di lavoro da essa, l'infrastruttura IBM Cloud (SoftLayer) la reclama. In seguito, se hai bisogno di una nuova VLAN, [contatta il supporto {{site.data.keyword.Bluemix_notm}}](/docs/infrastructure/vlans/order-vlan.html#order-vlans).

### Sottoreti e indirizzi IP
{: #subnets_ips}

In aggiunta ai nodi di lavoro e ai pod, sulle VLAN viene eseguito automaticamente anche il provisioning delle sottoreti. Le sottoreti forniscono la connettività di rete ai tuoi componenti del cluster assegnando loro degli indirizzi IP.

Delle seguenti reti viene eseguito automaticamente il provisioning sulle VLAN pubbliche e private predefinite:

**Sottoreti VLAN pubbliche**
* La sottorete pubblica primaria determina gli indirizzi IP pubblici che vengono assegnati ai nodi di lavoro durante la creazione del cluster. Più cluster nella stessa VLAN possono condividere una sottorete pubblica primaria.
* La sottorete pubblica portatile è associata solo a un singolo cluster e fornisce al cluster 8 indirizzi IP pubblici. 3 IP sono riservati per le funzioni dell'infrastruttura Cloud IBM (SoftLayer). 1 IP viene utilizzato dall'ALB Ingress pubblico predefinito e 4 IP possono essere utilizzati per creare servizi di rete del programma di bilanciamento del carico pubblico. Gli IP pubblici portatili sono indirizzi IP fissi e permanenti che possono essere utilizzati per accedere ai servizi del programma di bilanciamento del carico su Internet. Se hai bisogno di più di 4 IP per i programmi di bilanciamento del carico pubblico, vedi [Aggiunta di indirizzi IP portatili](#adding_ips).

**Sottoreti VLAN private**
* La sottorete privata primaria determina gli indirizzi IP privati che vengono assegnati ai nodi di lavoro durante la creazione del cluster. Più cluster nella stessa VLAN possono condividere una sottorete privata primaria.
* La sottorete privata portatile è associata solo a un singolo cluster e fornisce al cluster 8 indirizzi IP privati. 3 IP sono riservati per le funzioni dell'infrastruttura Cloud IBM (SoftLayer). 1 IP viene utilizzato dall'ALB Ingress privato predefinito e 4 IP possono essere utilizzati per creare servizi di rete del programma di bilanciamento del carico privato. Gli IP privati portatili sono indirizzi IP fissi e permanenti che possono essere utilizzati per accedere ai servizi del programma di bilanciamento del carico su Internet. Se hai bisogno di più di 4 IP per i programmi di bilanciamento del carico privato, vedi [Aggiunta di indirizzi IP portatili](#adding_ips).

Per visualizzare tutte le sottoreti di cui viene eseguito il provisioning nel tuo account, esegui `ibmcloud ks subnets`. Per visualizzare le sottoreti private portatili e le sottoreti pubbliche portatili associate a un singolo cluster, puoi eseguire `ibmcloud ks cluster-get <cluster_name_or_ID> --showResources` e cerca la sezione **Subnet VLANs**.

**Nota**: in {{site.data.keyword.containerlong_notm}}, le VLAN hanno un limite di 40 sottoreti. Se raggiungi questo limite, controlla prima se puoi [riutilizzare le sottoreti nella VLAN per creare nuovi cluster](#custom). Se hai bisogno di una nuova VLAN, ordinane una [contattando il supporto {{site.data.keyword.Bluemix_notm}}](/docs/infrastructure/vlans/order-vlan.html#order-vlans). Quindi [crea un cluster](cs_cli_reference.html#cs_cluster_create) che utilizzi questa nuova VLAN.

<br />


## Utilizzo di sottoreti personalizzate o esistenti per creare un cluster
{: #custom}

Quando crei un cluster standard, le sottoreti vengono create automaticamente per tuo conto. Tuttavia, invece di utilizzare le sottoreti di cui viene eseguito il provisioning automaticamente, puoi utilizzare le sottoreti portatili esistenti dal tuo account dell'infrastruttura IBM Cloud (Softlayer) oppure riutilizzare le sottoreti da un cluster eliminato.
{:shortdesc}

Utilizza questa opzione per mantenere stabili gli indirizzi IP statici tra le rimozioni e le creazioni di cluster o per ordinare blocchi di indirizzi IP più grandi.

**Nota:** gli indirizzi IP pubblici portatili vengono addebitati mensilmente. Se rimuovi gli indirizzi IP pubblici portatili dopo aver eseguito il provisioning del tuo cluster, devi comunque pagare l'addebito mensile anche se li hai utilizzati solo per un breve periodo di tempo.

Prima di iniziare:
- [Accedi al tuo account. Specifica la regione appropriata e, se applicabile, il gruppo di risorse. Imposta il contesto per il tuo cluster](cs_cli_install.html#cs_cli_configure).
- Per riutilizzare le sottoreti da un cluster di cui non hai più bisogno, elimina il cluster non necessario. Crea il nuovo cluster immediatamente perché le sottoreti vengono eliminate entro 24 ore se non le riutilizzi.

   ```
   ibmcloud ks cluster-rm <cluster_name_or_ID>
   ```
   {: pre}

Per utilizzare una sottorete esistente nel tuo portfolio dell'infrastruttura IBM Cloud (SoftLayer) con regole firewall personalizzate o indirizzi IP disponibili:

1. Ottieni l'ID della sottorete che vuoi utilizzare e l'ID della VLAN su cui si trova la sottorete.

    ```
    ibmcloud ks subnets
    ```
    {: pre}

    In questo output di esempio, l'ID sottorete è `1602829` e l'ID VLAN è `2234945`:
    ```
    Getting subnet list...
    OK
    ID        Network             Gateway          VLAN ID   Type      Bound Cluster
    1550165   10.xxx.xx.xxx/26    10.xxx.xx.xxx    2234947   private
    1602829   169.xx.xxx.xxx/28   169.xx.xxx.xxx   2234945   public
    ```
    {: screen}

2. [Crea un cluster](cs_clusters.html#clusters_cli) utilizzando l'ID VLAN che hai identificato. Includi l'indicatore `--no-subnet` per impedire la creazione automatica di una nuova sottorete IP pubblica portatile e di una nuova sottorete IP privata portatile.

    ```
    ibmcloud ks cluster-create --zone dal10 --machine-type b2c.4x16 --no-subnet --public-vlan 2234945 --private-vlan 2234947 --workers 3 --name my_cluster
    ```
    {: pre}
    Se non riesci a ricordare qual è la zona in cui si trova la VLAN per l'indicatore `--zone`, puoi controllare se la VLAN si trova in una specifica zona eseguendo `ibmcloud ks vlans <zone>`.
    {: tip}

3.  Verifica che il cluster sia stato creato. **Nota:** servono fino a 15 minuti perché le macchine del nodo di lavoro siano ordinate e il cluster sia configurato e ne sia stato eseguito il provisioning al tuo account.

    ```
    ibmcloud ks clusters
    ```
    {: pre}

    Quando il provisioning del tuo cluster è stato eseguito completamente, lo stato (**State**) cambia in `deployed`.

    ```
    Name         ID                                   State      Created          Workers   Zone   Version
    mycluster    aaf97a8843a29941b49a598f516da72101   deployed   20170201162433   3         dal10      1.10.8
    ```
    {: screen}

4.  Controlla lo stato dei nodi di lavoro.

    ```
    ibmcloud ks workers <cluster_name_or_ID>
    ```
    {: pre}

    Prima di continuare al passo successivo, i nodi di lavoro devono essere pronti. Lo stato (**State**) cambia in `normal` e la condizione (**Status**) è `Ready`.

    ```
    ID                                                  Public IP        Private IP     Machine Type   State      Status   Zone   Version
    prod-dal10-pa8dfcc5223804439c87489886dbbc9c07-w1    169.xx.xxx.xxx   10.xxx.xx.xxx  free           normal     Ready    dal10      1.10.8
    ```
    {: screen}

5.  Aggiungi la sottorete al tuo cluster specificando l'ID sottorete. Quando rendi disponibile una sottorete a un cluster, per te viene creata una mappa di configurazione Kubernetes che include tutti gli indirizzi IP pubblici portatili che puoi utilizzare. Se non esiste alcun ALB Ingress nella zona dove si trova la VLAN della sottorete, vengono automaticamente utilizzati un indirizzo IP privato e uno pubblico portatili per creare gli ALB pubblico e privato per tale zona. Puoi utilizzare tutti gli altri indirizzi IP pubblici e privati portatili dalla sottorete per creare i servizi del programma di bilanciamento del carico per le tue applicazioni.

    ```
    ibmcloud ks cluster-subnet-add mycluster 807861
    ```
    {: pre}

6. **Importante**: per abilitare le comunicazioni tra i nodi di lavoro che si trovano su sottoreti differenti nella stessa VLAN, devi [abilitare l'instradamento tra le sottoreti sulla stessa VLAN](#subnet-routing).

<br />


## Gestione degli indirizzi IP portatili esistenti
{: #managing_ips}

Per impostazione predefinita, 4 indirizzi IP pubblici portatili e 4 privati portatili possono essere utilizzati per esporre le singole applicazioni alla rete pubblica o privata [creando un servizio di programma di bilanciamento del carico](cs_loadbalancer.html). Per creare un servizio di programma di bilanciamento del carico, devi avere almeno un (1) indirizzo IP portatile del tipo corretto disponibile. Puoi visualizzare gli indirizzi IP portatili disponibili oppure liberare un indirizzo IP portatile utilizzato.

### Visualizzazione degli indirizzi IP pubblici portatili disponibili
{: #review_ip}

Per elencare tutti gli indirizzi IP portatili nel tuo cluster, sia quelli usati che quelli disponibili, puoi eseguire:

```
kubectl get cm ibm-cloud-provider-vlan-ip-config -n kube-system -o yaml
```
{: pre}

Per elencare solo gli indirizzi IP pubblici portatili disponibili per creare i programmi di bilanciamento del carico, puoi utilizzare la seguente procedura:

Prima di iniziare: [accedi al tuo account. Specifica la regione appropriata e, se applicabile, il gruppo di risorse. Imposta il contesto per il tuo cluster](cs_cli_install.html#cs_cli_configure).

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

    **Nota:** la creazione di questo servizio non riesce perché il master Kubernetes non può trovare l'indirizzo IP del programma di bilanciamento del carico specificato nella mappa di configurazione Kubernetes. Quando esegui questo comando, puoi visualizzare il messaggio di errore e l'elenco di indirizzi IP pubblici disponibili per il cluster.

    ```
    Error on cloud load balancer a8bfa26552e8511e7bee4324285f6a4a for service default/myservice with UID 8bfa2655-2e85-11e7-bee4-324285f6a4af: Requested cloud provider IP 1.1.1.1 is not available. The following cloud provider IP addresses are available: <list_of_IP_addresses>
    ```
    {: screen}

<br />


### Liberazione degli indirizzi IP utilizzati
{: #free}

Puoi liberare un indirizzo IP portatile utilizzato eliminando il servizio di bilanciamento del carico
che utilizza tale indirizzo IP.
{:shortdesc}

Prima di iniziare: [accedi al tuo account. Specifica la regione appropriata e, se applicabile, il gruppo di risorse. Imposta il contesto per il tuo cluster](cs_cli_install.html#cs_cli_configure).

1.  Elenca i servizi disponibili nel tuo cluster.

    ```
    kubectl get services
    ```
    {: pre}

2.  Rimuovi il servizio di bilanciamento del carico che utilizza un indirizzo IP pubblico o privato.

    ```
    kubectl delete service <service_name>
    ```
    {: pre}

<br />


## Aggiunta di indirizzi IP portatili
{: #adding_ips}

Per impostazione predefinita, 4 indirizzi IP pubblici portatili e 4 privati portatili possono essere utilizzati per esporre le singole applicazioni alla rete pubblica o privata [creando un servizio di programma di bilanciamento del carico](cs_loadbalancer.html). Per creare più di 4 programmi di bilanciamento del carico pubblici e 4 privati, puoi ottenere ulteriori indirizzi IP portatili aggiungendo delle sottoreti di rete al cluster.

**Nota:**
* Quando rendi disponibile una sottorete a un cluster, gli indirizzi IP di questa sottorete vengono utilizzati per scopi di rete del cluster. Per evitare conflitti di indirizzi IP, assicurati di utilizzare una sottorete con un solo cluster. Non utilizzare una sottorete per più cluster o per altri
scopi al di fuori di {{site.data.keyword.containerlong_notm}}
contemporaneamente.
* Gli indirizzi IP pubblici portatili vengono addebitati mensilmente. Se rimuovi gli indirizzi IP pubblici portatili dopo aver eseguito il provisioning della tua sottorete, devi comunque pagare l'addebito mensile anche se li hai utilizzati solo per un breve periodo di tempo.

### Aggiunta di IP portatili ordinando più sottoreti
{: #request}

Puoi ottenere più indirizzi IP portatili per i servizi di programma di bilanciamento del carico creando una nuova sottorete in un account dell'infrastruttura IBM Cloud (SoftLayer) e rendendola disponibile al tuo cluster specificato.
{:shortdesc}

Prima di iniziare: [accedi al tuo account. Specifica la regione appropriata e, se applicabile, il gruppo di risorse. Imposta il contesto per il tuo cluster](cs_cli_install.html#cs_cli_configure).

1. Esegui il provisioning di una sottorete.

    ```
    ibmcloud ks cluster-subnet-create <cluster_name_or_id> <subnet_size> <VLAN_ID>
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
    <td>Sostituisci <code>&lt;cluster_name_or_id&gt;</code> con il nome o l'ID del cluster.</td>
    </tr>
    <tr>
    <td><code><em>&lt;subnet_size&gt;</em></code></td>
    <td>Sostituisci <code>&lt;subnet_size&gt;</code> con il numero di indirizzi IP che vuoi aggiungere dalla tua sottorete portatile. I valori accettati sono 8, 16, 32 o 64. <p>**Nota:** quando aggiungi gli indirizzi IP portatili per la tua sottorete, tre indirizzi IP vengono utilizzati per stabilire un collegamento di rete interno al cluster. Non puoi utilizzare questi tre indirizzi IP per il tuo programma di bilanciamento del carico dell'applicazione o per creare un servizio di bilanciamento del carico. Ad esempio, se richiedi otto indirizzi IP pubblici portatili, puoi utilizzarne cinque per esporre le tue applicazioni pubblicamente.</p> </td>
    </tr>
    <tr>
    <td><code><em>&lt;VLAN_ID&gt;</em></code></td>
    <td>Sostituisci <code>&lt;VLAN_ID&gt;</code> con l'ID della VLAN pubblica o privata su cui vuoi assegnare gli indirizzi IP pubblici o privati portatili. Devi selezionare la VLAN pubblica o privata a cui è connesso un nodo di lavoro esistente. Per esaminare la VLAN pubblica o privata per un nodo di lavoro, esegui il comando <code>ibmcloud ks worker-get &lt;worker_id&gt;</code>. <Il provisioning della sottorete viene eseguito nella stessa zona in cui si trova la VLAN.</td>
    </tr>
    </tbody></table>

2. Verifica che la sottorete sia stata creata e aggiunta correttamente al tuo cluster. Il CIDR della sottorete viene elencato nella sezione **Subnet VLANs**.

    ```
    ibmcloud ks cluster-get --showResources <cluster_name_or_ID>
    ```
    {: pre}

    Nell'output di esempio, è stata aggiunta una seconda sottorete alla VLAN pubblica `2234945`:
    ```
    Subnet VLANs
    VLAN ID   Subnet CIDR          Public   User-managed
    2234947   10.xxx.xx.xxx/29     false    false
    2234945   169.xx.xxx.xxx/29    true     false
    2234945   169.xx.xxx.xxx/29    true     false
    ```
    {: screen}

3. **Importante**: per abilitare le comunicazioni tra i nodi di lavoro che si trovano su sottoreti differenti nella stessa VLAN, devi [abilitare l'instradamento tra le sottoreti sulla stessa VLAN](#subnet-routing).

<br />


### Aggiunta di IP privati portatili utilizzando le sottoreti gestite dall'utente
{: #user_managed}

Puoi ottenere più IP privati portatili per i servizi di programma di bilanciamento del carico rendendo una sottorete per una rete in loco disponibile al tuo cluster specificato.
{:shortdesc}

Requisiti:
- Le sottoreti gestite dall'utente possono essere aggiunte solo a VLAN private.
- Il limite di lunghezza del prefisso della sottorete è da /24 a /30. Ad esempio, `169.xx.xxx.xxx/24` specifica 253 indirizzi IP privati utilizzabili, mentre `169.xx.xxx.xxx/30` specifica 1 indirizzo IP privato utilizzabile.
- Il primo indirizzo IP nella sottorete deve essere utilizzato come gateway della sottorete.

Prima di iniziare:
- Configura l'instradamento del traffico di rete in entrata e in uscita della sottorete esterna.
- Conferma di disporre di connettività VPN tra il gateway di rete del data center in loco e la VRA (Virtual Router Appliance) di rete privata o il servizio VPN strongSwan in esecuzione nel tuo cluster. Per ulteriori informazioni, vedi [Configurazione della connettività VPN](cs_vpn.html).

Per aggiungere una sottorete da una rete in loco:

1. Visualizza l'ID della VLAN privata del tuo cluster. Individua la sezione **Subnet VLANs**. Nel campo **User-managed**, identifica l'ID della VLAN con _false_.

    ```
    ibmcloud ks cluster-get --showResources <cluster_name>
    ```
    {: pre}

    ```
    Subnet VLANs
  VLAN ID   Subnet CIDR         Public   User-managed
  2234947   10.xxx.xx.xxx/29    false    false
  2234945   169.xx.xxx.xxx/29  true    false
    ```
    {: screen}

2. Aggiungi la sottorete esterna alla tua VLAN privata. Gli indirizzi IP privati portatili vengono aggiunti alla mappa di configurazione del cluster.

    ```
    ibmcloud ks cluster-user-subnet-add <cluster_name> <subnet_CIDR> <VLAN_ID>
    ```
    {: pre}

    Esempio:

    ```
    ibmcloud ks cluster-user-subnet-add mycluster 10.xxx.xx.xxx/24 2234947
    ```
    {: pre}

3. Verifica che la sottorete fornita dall'utente sia stata aggiunta. Il campo **User-managed** è _true_.

    ```
    ibmcloud ks cluster-get --showResources <cluster_name>
    ```
    {: pre}

    In questo output di esempio, una seconda sottorete è stata aggiunta alla VLAN privata `2234947`:
    ```
    Subnet VLANs
    VLAN ID   Subnet CIDR       Public   User-managed
    2234947   10.xxx.xx.xxx/29  false    false
    2234945   169.xx.xxx.xxx/29 true     false
    2234947   10.xxx.xx.xxx/24  false    true
    ```
    {: screen}

4. [Abilita l'instradamento tra sottoreti sulla stessa VLAN](#subnet-routing).

5. Aggiungi un [servizio di programma di bilanciamento del carico privato](cs_loadbalancer.html) oppure abilita un [ALB Ingress privato](cs_ingress.html#private_ingress) per accedere alla tua applicazione sulla rete privata. Per utilizzare un indirizzo IP privato dalla sottorete che hai aggiunto, devi specificare un indirizzo IP dal CIDR della sottorete. Diversamente, viene scelto a caso un indirizzo IP dalle sottoreti dell'infrastruttura IBM Cloud (SoftLayer) o dalle sottoreti fornite dall'utente sulla VLAN privata.

<br />


## Gestione dell'instradamento di sottorete
{: #subnet-routing}

Se hai più VLAN per un cluster, più sottoreti sulla stessa VLAN o un cluster multizona, devi abilitare lo [spanning della VLAN](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) per il tuo account dell'infrastruttura IBM Cloud (SoftLayer) in modo che i tuoi nodi di lavoro possano comunicare tra loro sulla rete privata. Per eseguire questa azione, ti serve l'[autorizzazione dell'infrastruttura](cs_users.html#infra_access) **Rete > Gestisci il VLAN Spanning di rete** oppure puoi richiedere al proprietario dell'account di abilitarlo. Per controllare se lo spanning di VLAN è già abilitato, usa il [comando](/docs/containers/cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`. Se stai utilizzando {{site.data.keyword.BluDirectLink}}, devi invece utilizzare una [VRF (Virtual Router Function)](/docs/infrastructure/direct-link/subnet-configuration.html#more-about-using-vrf). Per abilitare la VRF, contatta il tuo rappresentante dell'account dell'infrastruttura IBM Cloud (SoftLayer).

Esamina i seguenti scenari in cui è richiesto anche lo spanning delle VLAN.

### Abilitazione dell'instradamento tra sottoreti primarie sulla stessa VLAN
{: #vlan-spanning}

Quando crei un cluster, viene eseguito il provisioning di una sottorete che termina per `/26` sulla VLAN primaria privata predefinita. Una sottorete primaria privata può fornire gli IP per un massimo di 62 nodi di lavoro.
{:shortdesc}

Questo limite di 62 nodi di lavoro potrebbe essere superato da un cluster di grandi dimensioni o da diversi cluster più piccoli di una singola regione che si trovano sulla stessa VLAN. Quando viene raggiunto il limite di 62 nodi di lavoro, viene ordinata una seconda sottorete primaria privata nella stessa VLAN.

Per garantire che i nodi di lavoro in queste sottoreti primarie sulla stessa VLAN possano comunicare, devi attivare lo spanning delle VLAN. Per istruzioni, vedi [Abilita o disabilita lo spanning delle VLAN](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning).

Per controllare se lo spanning della VLAN è già abilitato, utilizza il [comando](cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`.
{: tip}

### Gestione dell'instradamento di sottorete per le applicazioni gateway
{: #vra-routing}

Quando crei un cluster, vengono ordinate una sottorete pubblica e una privata portatili sulle VLAN a cui è connesso il cluster. Queste sottoreti forniscono gli indirizzi IP per i servizi di rete di programma di bilanciamento del carico e Ingress.

Tuttavia, se hai un'applicazione router esistente, come ad esempio una [VRA (Virtual Router Appliance)](/docs/infrastructure/virtual-router-appliance/about.html#about), le sottoreti portatili appena aggiunte dalle VLAN a cui è connesso il cluster non sono configurate sul router. Per utilizzare i servizi di rete di programma di bilanciamento del carico o Ingress, devi assicurarti che i dispositivi di rete possano eseguire l'instradamento tra sottoreti differenti sulla stessa VLAN [abilitando lo spanning delle VLAN](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning).

Per controllare se lo spanning della VLAN è già abilitato, utilizza il [comando](cs_cli_reference.html#cs_vlan_spanning_get) `ibmcloud ks vlan-spanning-get`.
{: tip}
