---

copyright:
  years: 2014, 2018
lastupdated: "2018-02-02"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Configurazione dei cluster
{: #clusters}

Progetta la configurazione del tuo cluster per la massima capacità e disponibilità.
{:shortdesc}


## Pianificazione configurazione cluster
{: #planning_clusters}

Utilizza i cluster standard per aumentare la disponibilità dell'applicazione. I tuoi utenti hanno meno probabilità di
riscontrare tempi di inattività quando distribuisci la configurazione su più nodi di lavoro e cluster. Le funzionalità integrate, come il bilanciamento del carico e l'isolamento, aumentano la resilienza nei confronti di
potenziali errori con host, reti o applicazioni.
{:shortdesc}

Rivedi la configurazione di questi cluster potenziali ordinati per gradi di disponibilità:

![Fasi di elevata disponibilità per un cluster](images/cs_cluster_ha_roadmap.png)

1.  Un cluster con più nodi di lavoro
2.  Due cluster in esecuzione in ubicazioni diverse nella stessa regione, ognuno con
più nodi di lavoro
3.  Due cluster in esecuzione in regioni diverse, ognuno con più nodi di lavoro

Aumenta la disponibilità del tuo cluster con queste tecniche:

<dl>
<dt>Espandi le applicazioni tra i nodi di lavoro </dt>
<dd>Consenti agli sviluppatori di estendere le loro applicazioni nei contenitori tra più nodi di lavoro per cluster. Un'istanza dell'applicazione in ognuno dei tre nodi di lavoro permette il tempo di inattività di un nodo di lavoro senza interrompere l'utilizzo dell'applicazione. Puoi specificare quanti nodi di lavoro da includere quando crei un cluster dalla GUI [{{site.data.keyword.Bluemix_notm}}](cs_clusters.html#clusters_ui) o dalla CLI [](cs_clusters.html#clusters_cli). Kubernetes limita il numero massimo di nodi di lavoro che puoi avere in un cluster, per cui tieni a mente [il nodo di lavoro e le quote pod ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/admin/cluster-large/).
<pre class="codeblock">
<code>bx cs cluster-create --location &lt;dal10&gt; --workers 3 --public-vlan &lt;my_public_vlan_id&gt; --private-vlan &lt;my_private_vlan_id&gt; --machine-type &lt;u2c.2x4&gt; --name &lt;my_cluster&gt;</code>
</pre>
</dd>
<dt>Espandi le applicazioni tra i cluster</dt>
<dd>Crea più cluster, ognuno con più nodi di lavoro. Se si verifica un'interruzione con un cluster,
gli utenti possono ancora accedere a un'applicazione che viene distribuita anche in un altro cluster.
<p>Cluster
1:</p>
<pre class="codeblock">
<code>bx cs cluster-create --location &lt;dal10&gt; --workers 3 --public-vlan &lt;my_public_vlan_id&gt; --private-vlan &lt;my_private_vlan_id&gt; --machine-type &lt;u2c.2x4&gt; --name &lt;my_cluster1&gt;</code>
</pre>
<p>Cluster
2:</p>
<pre class="codeblock">
<code>bx cs cluster-create --location &lt;dal12&gt; --workers 3 --public-vlan &lt;my_public_vlan_id&gt; --private-vlan &lt;my_private_vlan_id&gt; --machine-type &lt;u2c.2x4&gt;  --name &lt;my_cluster2&gt;</code>
</pre>
</dd>
<dt>Espandi le applicazioni tra i cluster in regioni differenti</dt>
<dd>Quando espandi le applicazioni tra i cluster in regioni differenti puoi permettere il bilanciamento del carico basato sulla regione in cui è l'utente. Se il cluster, l'hardware o anche un'intera ubicazione in una regione vengono disattivati, il traffico viene instradato al contenitore distribuito in un'altra ubicazione.
<p><strong>Importante:</strong> dopo aver configurato il dominio personalizzato, puoi utilizzare questi comandi per creare i cluster. </p>
<p>Ubicazione
1:</p>
<pre class="codeblock">
<code>bx cs cluster-create --location &lt;dal10&gt; --workers 3 --public-vlan &lt;my_public_vlan_id&gt; --private-vlan &lt;my_private_vlan_id&gt; --machine-type &lt;u2c.2x4&gt; --name &lt;my_cluster1&gt;</code>
</pre>
<p>Ubicazione
2:</p>
<pre class="codeblock">
<code>bx cs cluster-create --location &lt;ams03&gt; --workers 3 --public-vlan &lt;my_public_vlan_id&gt; --private-vlan &lt;my_private_vlan_id&gt; --machine-type &lt;u2c.2x4&gt; --name &lt;my_cluster2&gt;</code>
</pre>
</dd>
</dl>

<br />


## Pianificazione configurazione del nodo di lavoro 
{: #planning_worker_nodes}

Un cluster Kubernetes è costituito da nodi di lavoro ed è monitorato e gestito centralmente dal master Kubernetes. Gli amministratori del cluster decidono come configurare il cluster dei nodi di lavoro per garantire che gli utenti del cluster abbiano tutte le risorse per distribuire ed eseguire le applicazioni nel cluster.
{:shortdesc}

Quando crei un cluster standard, i nodi di lavoro vengono ordinati nell'infrastruttura IBM Cloud (SoftLayer) e configurati in {{site.data.keyword.Bluemix_notm}}. A ogni nodo di lavoro viene
assegnato un ID e nome dominio univoco che non deve essere modificato dopo la creazione del cluster. A seconda del livello di isolamento hardware che hai scelto,
i nodi di lavoro possono essere configurati come nodi condivisi o dedicati. Puoi anche scegliere se vuoi che i nodi di lavoro si colleghino a una VLAN pubblica e privata o solo a una VLAN privata. Viene eseguito il provisioning di ogni nodo di lavoro
con un tipo di macchina specifico che determina il numero di vCPU, memoria
e spazio su disco disponibili per i contenitori distribuiti al nodo di lavoro. Kubernetes limita il numero massimo di nodi di lavoro che puoi avere in un cluster. Controlla [nodo di lavoro e quote pod ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/admin/cluster-large/) per ulteriori informazioni.


### Hardware per i nodi di lavoro
{: #shared_dedicated_node}

Ogni nodo di lavoro è configurato come una macchina virtuale su un hardware fisico. Quando crei un cluster standard in {{site.data.keyword.Bluemix_notm}}, devi scegliere se desideri che l'hardware sottostante sia condiviso tra più clienti {{site.data.keyword.IBM_notm}} (più tenant) o che sia dedicato solo a te (tenant singolo).
{:shortdesc}

In una configurazione a più tenant, le risorse fisiche, come ad esempio la CPU e la memoria, vengono condivise tra tutte le
macchine virtuali distribuite allo stesso hardware fisico. Per assicurare che ogni macchina virtuale
possa essere eseguita indipendentemente, un monitoraggio della macchina virtuale, conosciuto anche come hypervisor,
divide le risorse fisiche in entità isolate e le alloca come risorse dedicate
a una macchina virtuale (isolamento hypervisor).

In una configurazione a tenant singolo, tutte le risorse fisiche sono dedicate soltanto a te. Puoi distribuire
più nodi di lavoro come macchine virtuali allo stesso host fisico. In modo simile alla configurazione a più tenant,
l'hypervisor assicura che ogni nodo ottenga la propria condivisione di risorse
fisiche disponibili.

I nodi condivisi sono generalmente più economici dei nodi dedicati perché i costi dell'hardware sottostante
sono condivisi tra più clienti. Tuttavia, quando decidi tra nodi condivisi e dedicati,
potresti voler verificare con il tuo dipartimento legale e discutere sul livello di conformità e isolamento dell'infrastruttura
che il tuo ambiente dell'applicazione necessita.

Quando crei un cluster gratuito, viene automaticamente eseguito il provisioning del tuo nodo di lavoro come nodo condiviso nell'account dell'infrastruttura IBM Cloud (SoftLayer). 

### Connessione VLAN per i nodi di lavoro
{: #worker_vlan_connection}

Quando crei un cluster, ogni cluster viene automaticamente collegato a una VLAN dal tuo account dell'infrastruttura IBM Cloud (SoftLayer). Una VLAN configura un gruppo di
nodi di lavoro come se fossero collegati con lo stesso cavo fisico. La VLAN privata determina l'indirizzo IP privato assegnato a un nodo di lavoro durante la creazione del cluster e la VLAN pubblica determina l'indirizzo IP pubblico assegnato a un nodo di lavoro durante la creazione del cluster.

Per i cluster gratuiti, i nodi di lavoro del cluster vengono collegati a una VLAN privata e a una VLAN pubblica di proprietà di IBM per impostazione predefinita durante la creazione del cluster. Per i cluster standard, puoi collegare i tuoi nodi di lavoro sia a una VLAN pubblica che privata o soltanto a una VLAN privata. Se vuoi collegare i tuoi nodi di lavoro solo a una VLAN privata, puoi designare l'ID di una VLAN privata esistente durante la creazione del cluster. Tuttavia, devi anche configurare una soluzione alternativa per abilitare una connessione sicura tra i nodi di lavoro e il master Kubernetes. Ad esempio, puoi configurare un Vyatta per passare il traffico dai nodi di lavoro della VLAN privata al master Kubernetes. Consulta "Set up a custom Vyatta to securely connect your worker nodes to the Kubernetes master" nella [documentazione dell'infrastruttura IBM Cloud (SoftLayer)](https://knowledgelayer.softlayer.com/procedure/basic-configuration-vyatta) per ulteriori informazioni.

### Limiti di memoria dei nodi di lavoro
{: #resource_limit_node}

{{site.data.keyword.containershort_notm}} imposta un limite di memoria su ogni nodo di lavoro. Quando i pod in esecuzione sul nodo di lavoro superano questo limite di memoria, i pod vengono rimossi. In Kubernetes, questo limite è chiamato [soglia di rimozione rigida![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/tasks/administer-cluster/out-of-resource/#hard-eviction-thresholds).
{:shortdesc}

Se i tuoi pod vengono rimossi frequentemente, aggiungi più nodi di lavoro al tuo cluster o imposta i [limiti di risorsa ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#resource-requests-and-limits-of-pod-and-container) sui pod.

Ogni tipo di macchina ha una diversa capacità di memoria. Quando sul nodo di lavoro è disponibile meno memoria rispetto alla soglia minima consentita, Kubernetes rimuove immediatamente il pod. Il pod viene ripianificato su un altro nodo di lavoro, laddove disponibile.

|Capacità di memoria del nodo di lavoro|Soglia di memoria minima di un nodo di lavoro|
|---------------------------|------------|
|4 GB  | 256 MB |
|16 GB | 1024 MB |
|64 GB | 4096 MB |
|128 GB| 4096 MB |
|242 GB| 4096 MB |

Per verificare la quantità di memoria utilizzata sul tuo nodo di lavoro, esegui [kubectl top node ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#top).



<br />



## Creazione dei cluster con la GUI
{: #clusters_ui}

Un cluster Kubernetes  è una serie di nodi di lavoro organizzati in una
rete. Lo scopo del cluster è di definire una serie di risorse, nodi, reti e dispositivi di archiviazione
che mantengono le applicazioni altamente disponibili. Prima di poter distribuire un'applicazione,
devi creare un cluster e configurare le definizioni per i nodi di lavoro in tale cluster.
{:shortdesc}

Per creare un cluster:
1. Nel catalogo, seleziona **Cluster Kubernetes**.
2. Seleziona una regione in cui distribuire il tuo cluster.
3. Seleziona un tipo di piano del cluster. Puoi scegliere tra **Gratuito** o **Pagamento a consumo**. Con il piano Pagamento a consumo, puoi eseguire il provisioning di un cluster standard con le funzioni come più nodi di lavoro per un ambiente ad elevata disponibilità.
4. Configura i tuoi dettagli del cluster.
    1. Fornisci al tuo cluster un nome, scegli una versione di Kubernetes e seleziona un'ubicazione in cui eseguire la distribuzione. Per prestazioni ottimali, seleziona l'ubicazione fisicamente più vicina a te. Tieni presente che potresti aver bisogno di un'autorizzazione legale prima di poter fisicamente archiviare i dati in un paese straniero se selezioni un'ubicazione al di fuori del tuo paese. 
    2. Seleziona un tipo di macchina e specifica il numero di nodi di lavoro di cui hai bisogno. Il tipo di macchina definisce la quantità di CPU virtuale, di memoria e di spazio disco configurata in ogni nodo di lavoro e resa disponibile ai contenitori. 
    3. Seleziona una VLAN pubblica e privata dal tuo account dell'infrastruttura IBM Cloud (SoftLayer). Entrambe le VLAN comunicano con i nodi di lavoro ma la VLAN pubblica anche con il master Kubernetes gestito da IBM. Puoi utilizzare la stessa VLAN per più cluster.
        **Nota**: se scegli di non selezionare una VLAN pubblica, devi configurare una soluzione alternativa. Consulta [Connessione VLAN per i nodi di lavoro](#worker_vlan_connection) per ulteriori informazioni.
    4. Seleziona un tipo di hardware.
        - **Dedicato**: i tuoi nodi di lavoro sono ospitati sull'infrastruttura che è dedicata al tuo account. Le tue risorse sono completamente isolate.
        - **Condiviso**: le risorse dell'infrastruttura, come l'hypervisor e l'hardware fisico, vengono distribuite tra te e altri clienti IBM, ma ogni nodo di lavoro è accessibile solo a te. Sebbene questa opzione sia meno costosa e sufficiente nella maggior parte dei casi, potresti voler verificare le tue prestazioni e i requisiti dell'infrastruttura con le tue politiche aziendali.
    5. Per impostazione predefinita, **Codifica disco locale** è selezionato. Se scegli di deselezionare la casella di spunta, i dati Docker dell'host non vengono codificati.[Ulteriori informazioni sulla codifica](cs_secure.html#encrypted_disks).
4. Fai clic su **Crea cluster**. Puoi vedere lo stato di avanzamento della distribuzione del nodo di lavoro nella scheda **Nodi di lavoro**. Quando la distribuzione è terminata, puoi vedere se il tuo cluster è pronto nella scheda **Panoramica**.
    **Nota:** a ogni nodo di lavoro viene assegnato
un ID e nome dominio univoco che non deve essere modificato manualmente dopo la creazione del
cluster. La modifica dell'ID o del nome dominio impedisce al master Kubernetes di gestire il tuo
cluster.


**Operazioni successive**

Quando il cluster è attivo e in esecuzione, puoi controllare le seguenti attività:

-   [Installa le CLI per iniziare ad utilizzare
il tuo cluster.](cs_cli_install.html#cs_cli_install)
-   [Distribuisci un'applicazione nel tuo cluster.](cs_app.html#app_cli)
-   [Configura il tuo registro privato in {{site.data.keyword.Bluemix_notm}} per memorizzare e condividere le immagini Docker con altri utenti.](/docs/services/Registry/index.html)
- Se hai un firewall, potresti dover [aprire le porte richieste](cs_firewall.html#firewall) per utilizzare i comandi `bx`, `kubectl` o `calicotl`, per consentire il traffico in uscita dal tuo cluster o per consentire il traffico in entrata per i servizi di rete.

<br />


## Creazione dei cluster con la CLI
{: #clusters_cli}

Un cluster è una serie di nodi di lavoro organizzati in una
rete. Lo scopo del cluster è di definire una serie di risorse, nodi, reti e dispositivi di archiviazione
che mantengono le applicazioni altamente disponibili. Prima di poter distribuire un'applicazione,
devi creare un cluster e configurare le definizioni per i nodi di lavoro in tale cluster.
{:shortdesc}

Per creare un cluster:
1.  Installa la CLI {{site.data.keyword.Bluemix_notm}} e il plugin
[{{site.data.keyword.containershort_notm}}](cs_cli_install.html#cs_cli_install).
2.  Accedi alla CLI {{site.data.keyword.Bluemix_notm}}. Immetti le tue credenziali
{{site.data.keyword.Bluemix_notm}} quando richiesto.

    ```
    bx login
    ```
    {: pre}

    **Nota:** se disponi di un ID federato, utilizza `bx login --sso` per accedere alla CLI {{site.data.keyword.Bluemix_notm}}. Immetti il tuo nome utente e usa l'URL fornito nell'output della CLI per richiamare la tua passcode monouso. Sai che hai un ID federato quando l'accesso ha esito negativo senza
`--sso` e positivo con l'opzione `--sso`.

3. Se disponi di più account {{site.data.keyword.Bluemix_notm}}, seleziona l'account in cui vuoi creare il tuo cluster Kubernetes.

4.  Se vuoi creare o accedere ai cluster Kubernetes in un'altra regione rispetto alla regione {{site.data.keyword.Bluemix_notm}} che hai selezionato precedentemente, esegui `bx cs region-set`.

6.  Crea un cluster.
    1.  Esamina le ubicazioni disponibili. Le ubicazioni che vengono mostrate dipendono dalla regione {{site.data.keyword.containershort_notm}} a cui hai eseguito l'accesso.

        ```
        bx cs locations
        ```
        {: pre}

        Il tuo output della CLI corrisponde alle [ubicazioni di alcune regioni del contenitore](cs_regions.html#locations).

    2.  Scegli un'ubicazione ed esamina i tipi di macchina disponibili in tale ubicazione. Il tipo di macchina specifica le risorse di calcolo virtuali che sono disponibili per ogni nodo
di lavoro.

        ```
        bx cs machine-types <location>
        ```
        {: pre}

        ```
        Getting machine types list...
        OK
        Machine Types
        Name         Cores   Memory   Network Speed   OS             Storage   Server Type
        u2c.2x4      2       4GB      1000Mbps        UBUNTU_16_64   100GB     virtual
        b2c.4x16     4       16GB     1000Mbps        UBUNTU_16_64   100GB     virtual
        b2c.16x64    16      64GB     1000Mbps        UBUNTU_16_64   100GB     virtual
        b2c.32x128   32      128GB    1000Mbps        UBUNTU_16_64   100GB     virtual
        b2c.56x242   56      242GB    1000Mbps        UBUNTU_16_64   100GB     virtual
        ```
        {: screen}

    3.  Controlla se esiste già una VLAN pubblica e privata nell'infrastruttura IBM Cloud (SoftLayer) per questo account.

        ```
        bx cs vlans <location>
        ```
        {: pre}

        ```
        ID        Name                Number   Type      Router  
        1519999   vlan   1355     private   bcr02a.dal10  
        1519898   vlan   1357     private   bcr02a.dal10 
        1518787   vlan   1252     public   fcr02a.dal10 
        1518888   vlan   1254     public    fcr02a.dal10
        ```
        {: screen}

        Se esiste già una VLAN pubblica e privata, nota i router corrispondenti. I router della VLAN privata iniziano sempre con `bcr` (router back-end) e i router
della VLAN pubblica iniziano sempre con `fcr` (router front-end). La combinazione di numeri e lettere
dopo questi prefissi devono corrispondere per utilizzare tali VLAN durante la creazione di un cluster. Nell'output di esempio, le VLAN private
possono essere utilizzate con una qualsiasi VLAN pubblica perché i router includono tutti
`02a.dal10`.

    4.  Esegui il comando `cluster-create`. Puoi scegliere tra un cluster gratuito, che include un nodo di lavoro configurato con 2vCPU e 4 GB di memoria, o un cluster standard, che può includere quanti nodi di lavoro desideri nel tuo account dell'infrastruttura IBM Cloud (SoftLayer). Quando crei un cluster standard, per impostazione predefinita, i dischi del nodo di lavoro vengono codificati, il relativo hardware condiviso tra più clienti IBM e viene effettuato un addebito per ora di utilizzo. </br>Esempio per un cluster standard:

        ```
        bx cs cluster-create --location dal10 --machine-type u2c.2x4 --hardware <shared_or_dedicated> --public-vlan <public_vlan_id> --private-vlan <private_vlan_id> --workers 3 --name <cluster_name> --kube-version <major.minor.patch> 
        ```
        {: pre}

        Esempio per un cluster gratuito:

        ```
        bx cs cluster-create --name my_cluster
        ```
        {: pre}

        <table>
        <caption>Tabella. Descrizione dei componenti del comando <code>bx cs cluster-create</code> </caption>
        <thead>
        <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti di questo comando</th>
        </thead>
        <tbody>
        <tr>
        <td><code>cluster-create</code></td>
        <td>Il comando per creare un cluster nella tua organizzazione {{site.data.keyword.Bluemix_notm}}.</td>
        </tr>
        <tr>
        <td><code>--location <em>&lt;location&gt;</em></code></td>
        <td>Sostituisci <em>&lt;location&gt;</em> con l'ID ubicazione {{site.data.keyword.Bluemix_notm}} in cui vuoi creare
il tuo cluster. [Le ubicazioni disponibili](cs_regions.html#locations) dipendono dalla regione {{site.data.keyword.containershort_notm}} in cui hai
eseguito l'accesso.</td>
        </tr>
        <tr>
        <td><code>--machine-type <em>&lt;machine_type&gt;</em></code></td>
        <td>Se stai creando un cluster standard, scegli un tipo di macchina. Il tipo di macchina specifica le risorse di calcolo virtuali che sono disponibili per ogni nodo
di lavoro. Controlla [Confronto tra i cluster standard e gratuito per {{site.data.keyword.containershort_notm}}](cs_why.html#cluster_types) per ulteriori informazioni. Per i cluster gratuiti, non devi definire il tipo di macchina. </td>
        </tr>
        <tr>
        <td><code>--hardware <em>&lt;shared_or_dedicated&gt;</em></code></td>
        <td>Il livello di isolamento hardware per il nodo di lavoro. Utilizza dedicato per avere risorse fisiche dedicate disponibili solo per te o condiviso per consentire la condivisione delle risorse fisiche con altri clienti IBM. L'impostazione predefinita è condiviso. Questo valore è facoltativo per i cluster standard e non è disponibile per i cluster gratuiti.</td>
        </tr>
        <tr>
        <td><code>--public-vlan <em>&lt;public_vlan_id&gt;</em></code></td>
        <td><ul>
          <li>Per i cluster gratuiti, non devi definire una VLAN pubblica. Il tuo cluster gratuito viene automaticamente collegato alla VLAN pubblica di proprietà di IBM. </li>
          <li>Per un cluster standard, se hai già una VLAN pubblica configurata nel tuo account dell'infrastruttura IBM Cloud (SoftLayer) per quella ubicazione, immetti l'ID della VLAN pubblica. Se non hai ancora una VLAN privata e pubblica nel tuo account, non
specificare questa opzione. {{site.data.keyword.containershort_notm}} crea automaticamente una VLAN pubblica per tuo conto.<br/><br/>
          <strong>Nota</strong>: i router della VLAN privata iniziano sempre con <code>bcr</code> (router back-end) e i router
della VLAN pubblica iniziano sempre con <code>fcr</code> (router front-end). La combinazione di numeri e lettere
dopo questi prefissi devono corrispondere per utilizzare tali VLAN durante la creazione di un cluster.</li>
        </ul></td>
        </tr>
        <tr>
        <td><code>--private-vlan <em>&lt;private_vlan_id&gt;</em></code></td>
        <td><ul><li>Per i cluster gratuiti, non devi definire una VLAN privata. Il tuo cluster gratuito viene automaticamente collegato alla VLAN privata di proprietà di IBM. </li><li>Per un cluster standard, se hai già una VLAN privata configurata nel tuo account dell'infrastruttura IBM Cloud (SoftLayer) per quella ubicazione, immetti l'ID della VLAN privata. Se non hai ancora una VLAN privata e pubblica nel tuo account, non
specificare questa opzione. {{site.data.keyword.containershort_notm}} crea automaticamente una VLAN pubblica per tuo conto.<br/><br/><strong>Nota</strong>: i router della VLAN privata iniziano sempre con <code>bcr</code> (router back-end) e i router
della VLAN pubblica iniziano sempre con <code>fcr</code> (router front-end). La combinazione di numeri e lettere
dopo questi prefissi devono corrispondere per utilizzare tali VLAN durante la creazione di un cluster.</li></ul></td>
        </tr>
        <tr>
        <td><code>--name <em>&lt;name&gt;</em></code></td>
        <td>Sostituisci <em>&lt;name&gt;</em> con un nome per il tuo cluster.</td>
        </tr>
        <tr>
        <td><code>--workers <em>&lt;number&gt;</em></code></td>
        <td>Il numero di nodi di lavoro da includere nel cluster. Se non viene specificata l'opzione <code>--workers</code>,
viene creato 1 nodo di lavoro.</td>
        </tr>
        <tr>
          <td><code>--kube-version <em>&lt;major.minor.patch&gt;</em></code></td>
          <td>La versione di Kubernetes per il nodo master del cluster. Questo valore è facoltativo. Se non specificato, il cluster viene creato con l'impostazione predefinita delle versioni di Kubernetes supportate. Per visualizzare le versioni disponibili. esegui <code>bx cs kube-versions</code>.</td>
        </tr>
        <tr>
        <td><code>--disable-disk-encrypt</code></td>
        <td>Codifica del disco della funzione dei nodi di lavoro predefinita; [ulteriori informazioni](cs_secure.html#encrypted_disks). Se vuoi disabilitare la codifica, includi questa opzione. </td>
        </tr>
        </tbody></table>

7.  Verifica che la creazione del cluster sia stata richiesta.

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
    my_cluster   paf97e8843e29941b49c598f516de72101   deployed   20170201162433   1
    ```
    {: screen}

8.  Controlla lo stato dei nodi di lavoro.

    ```
    bx cs workers <cluster>
    ```
    {: pre}

    Quando i nodi di lavoro sono pronti, la condizione
passa a **normale** e lo stato è **Pronto**. Quando lo stato del nodo è **Pronto**,
puoi accedere al
cluster.

    **Nota:** a ogni nodo di lavoro viene assegnato
un ID e nome dominio univoco che non deve essere modificato manualmente dopo la creazione del
cluster. La modifica dell'ID o del nome dominio impedisce al master Kubernetes di gestire il tuo
cluster.

    ```
    ID                                                  Public IP        Private IP     Machine Type   State      Status  
    prod-dal10-pa8dfcc5223804439c87489886dbbc9c07-w1   169.47.223.113   10.171.42.93   free           normal    Ready
    ```
    {: screen}

9. Configura il cluster che hai creato come il contesto per questa sessione. Completa questi passi di configurazione ogni volta che lavori con il tuo cluster.
    1.  Richiama il comando per impostare la variabile di ambiente e scaricare i file di configurazione Kubernetes.

        ```
        bx cs cluster-config <cluster_name_or_id>
        ```
        {: pre}

        Quando il download dei file di configurazione è terminato, viene visualizzato un comando che puoi utilizzare per impostare il percorso al file di configurazione di Kubernetes locale come una variabile di ambiente.

        Esempio per OS X:

        ```
        export KUBECONFIG=/Users/<nome_utente>/.bluemix/plugins/container-service/clusters/<nome_cluster>/kube-config-prod-dal10-<nome_cluster>.yml
        ```
        {: screen}

    2.  Copia e incolla il comando visualizzato nel tuo terminale per impostare la variabile di ambiente `KUBECONFIG`.
    3.  Verifica che la variabile di ambiente `KUBECONFIG` sia impostata correttamente.

        Esempio per OS X:

        ```
        echo $KUBECONFIG
        ```
        {: pre}

        Output:

        ```
        /Users/<nome_utente>/.bluemix/plugins/container-service/clusters/<nome_cluster>/kube-config-prod-dal10-<nome_cluster>.yml

        ```
        {: screen}

10. Avvia il tuo dashboard Kubernetes con la porta predefinita `8001`.
    1.  Imposta il proxy con il numero di porta predefinito.

        ```
        kubectl proxy
        ```
        {: pre}

        ```
        Inizio di utilizzo su 127.0.0.1:8001
        ```
        {: screen}

    2.  Apri il seguente URL in un browser web per visualizzare il dashboard Kubernetes.

        ```
        http://localhost:8001/ui
        ```
        {: codeblock}


**Operazioni successive**

-   [Distribuisci un'applicazione nel tuo cluster.](cs_app.html#app_cli)
-   [Gestisci il tuo cluster con la riga di comando `kubectl`. ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/user-guide/kubectl/)
-   [Configura il tuo registro privato in {{site.data.keyword.Bluemix_notm}} per memorizzare e condividere le immagini Docker con altri utenti.](/docs/services/Registry/index.html)
- Se hai un firewall, potresti dover [aprire le porte richieste](cs_firewall.html#firewall) per utilizzare i comandi `bx`, `kubectl` o `calicotl`, per consentire il traffico in uscita dal tuo cluster o per consentire il traffico in entrata per i servizi di rete.

<br />


## Stati cluster
{: #states}

Puoi visualizzare lo stato del cluster corrente eseguendo il comando `bx cs clusters` e individuando il campo **Stato**. Lo stato del cluster ti fornisce le informazioni sulla disponibilità e sulla capacità del cluster e i problemi potenziali che possono venire riscontrati.
{:shortdesc}

|Stato cluster|Motivo|
|-------------|------|

|Critico|Il master Kubernetes non può essere raggiunto o tutti i nodi di lavoro nel cluster sono inattivi. <ol><li>Elenca i nodi di lavoro nel tuo cluster.<pre class="pre"><code>bx cs workers &lt;cluser_name_or_id&gt;</code></pre><li>Ottieni i dettagli di ogni nodo di lavoro.<pre class="pre"><code>bx cs worker-get &lt;worker_id&gt;</code></pre></li><li>Controlla i campi <strong>Condizione</strong> e <strong>Stato</strong> per trovare il problema principale per cui il nodo di lavoro è inattivo.<ul><li>Se lo stato del nodo di lavoro mostra <strong>Provision_failed</strong>, potresti non disporre delle autorizzazioni necessarie per eseguire il provisioning di un nodo di lavoro dal portfolio dell'infrastruttura IBM Cloud (SoftLayer). Per trovare le autorizzazioni necessarie, consulta [Configurazione dell'accesso al portfolio dell'infrastruttura IBM Cloud (SoftLayer) per creare cluster Kubernetes standard](cs_infrastructure.html#unify_accounts).</li><li>Se la condizione del nodo di lavoro visualizza <strong>Critico</strong> e lo stato visualizza <strong>Non pronto</strong>, il tuo nodo di lavoro non può collegarsi all'infrastruttura IBM Cloud (SoftLayer). Avvia la risoluzione dei problemi eseguendo prima <code>bx cs worker-reboot --hard CLUSTER WORKER</code>. Se quel comando non ha esito positivo, esegui <code>bx cs worker reload CLUSTER WORKER</code>.</li><li>Se la condizione del nodo di lavoro visualizza <strong>Critico</strong> e lo stato visualizza <strong>Spazio su disco esaurito
</strong>, il tuo nodo di lavoro ha esaurito la capacità. Puoi ridurre il carico di lavoro nel tuo nodo di lavoro o aggiungere un nodo di lavoro al tuo cluster per bilanciare il carico del carico di lavoro.</li><li>Se la condizione del nodo di lavoro visualizza <strong>Critico</strong> e lo stato visualizza <strong>Sconosciuto</strong>, il master Kubernetes non è disponibile. Contatta il supporto {{site.data.keyword.Bluemix_notm}} aprendo un [ticket di supporto {{site.data.keyword.Bluemix_notm}}](/docs/get-support/howtogetsupport.html#using-avatar).</li></ul></li></ol>|

|In distribuzione|Il master Kubernetes non è ancora stato completamente distribuito. Non puoi accedere al tuo cluster.|
|Normale|Tutti i nodi di lavoro in un cluster sono attivi e in esecuzione. Puoi accedere al cluster e distribuire le applicazioni al cluster.|
|In sospeso|Il master Kubernetes è stato distribuito. Sta venendo eseguito il provisioning dei nodi di lavoro e non sono ancora disponibili nel cluster. Puoi accedere al cluster, ma non puoi distribuire le applicazioni al cluster.|

|Avvertenza|Almeno un nodo di lavoro nel cluster non è disponibile, ma altri lo sono e possono subentrare nel carico di lavoro. <ol><li>Elenca i nodi di lavoro nel tuo cluster e prendi nota dell'ID dei nodi di lavoro che visualizzano lo stato <strong>Avvertenza</strong>.<pre class="pre"><code>bx cs workers &lt;cluster_name_or_id&gt;</code></pre><li>Ottieni i dettagli per un nodo di lavoro.<pre class="pre"><code>bx cs worker-get &lt;worker_id&gt;</code></pre><li>Controlla i campi <strong>Condizione</strong>, <strong>Stato</strong> e <strong>Dettagli</strong> per trovare il problema principale per cui il nodo di lavoro è inattivo.</li><li>Se il nodo di lavoro ha quasi raggiunto il limite di spazio disco o di memoria, riduci il carico di lavoro per il tuo nodo di lavoro o aggiungi una nodo di lavoro al tuo cluster per bilanciare il carico del carico di lavoro.</li></ol>|

{: caption="Tabella. Stati cluster" caption-side="top"}

<br />


## Rimozione dei cluster
{: #remove}

Quando non hai più bisogno di un cluster, puoi rimuoverlo in modo che non utilizzi
più risorse.
{:shortdesc}

I cluster gratuiti e standard creati con un account a Pagamento a consumo devono essere rimossi manualmente dall'utente quando non sono più necessari.

Quando elimini un cluster, stai anche eliminando le risorse nel cluster,
inclusi i contenitori, i pod, i servizi associati e i segreti. Se quando elimini il tuo cluster non elimini l'archiviazione, puoi eliminarla attraverso il dashboard dell'infrastruttura IBM Cloud (SoftLayer) nella GUI {{site.data.keyword.Bluemix_notm}}. A causa del ciclo di fatturazione mensile, non è possibile eliminare un'attestazione del volume persistente durante l'ultimo
giorno del mese. Se elimini l'attestazione del volume persistente l'ultimo giorno del mese, l'eliminazione rimane in sospeso fino all'inizio del mese successivo.

**Avvertenza:** non è stato creato alcun backup del tuo cluster o dei tuoi dati nella tua memoria persistente. L'eliminazione di un cluster è permanente e non può essere annullata.

-   Dalla GUI {{site.data.keyword.Bluemix_notm}}
    1.  Seleziona il tuo cluster
e fai clic su **Elimina** dal gruppo **Ulteriori azioni...**.
-   Dalla CLI {{site.data.keyword.Bluemix_notm}}
    1.  Elenca i cluster disponibili.

        ```
        bx cs clusters
        ```
        {: pre}

    2.  Elimina il cluster.

        ```
        bx cs cluster-rm my_cluster
        ```
        {: pre}

    3.  Segui le richieste e scegli se eliminare le risorse del cluster.

Quando rimuovi un cluster, puoi scegliere di rimuovere le sottoreti portatili e l'archiviazione persistente ad esso associato:
- Le sottoreti sono utilizzate per assegnare indirizzi IP pubblici portatili ai servizi di bilanciamento del carico o al tuo programma di bilanciamento del carico dell'applicazione Ingress. Se le mantieni, puoi riutilizzarle in un nuovo cluster o eliminarle manualmente in un secondo momento dal tuo portfolio dell'infrastruttura IBM Cloud (SoftLayer).
- Se hai creato un'attestazione del volume persistente utilizzando una [condivisione file esistente](cs_storage.html#existing), non potrai eliminare la condivisione file quando elimini il cluster. Devi eliminare manualmente in seguito la condivisione file dal tuo portfolio dell'infrastruttura IBM Cloud (SoftLayer).
- L'archiviazione persistente fornisce l'alta disponibilità per i tuoi dati. Se la elimini, non puoi recuperare i tuoi dati.
