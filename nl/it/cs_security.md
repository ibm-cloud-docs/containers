---

copyright:
  years: 2014, 2017
lastupdated: "2017-10-24"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Sicurezza per {{site.data.keyword.containerlong_notm}}
{: #cs_security}

Puoi utilizzare le funzioni di sicurezza integrate per l'analisi dei rischi e la protezione di sicurezza. Queste funzioni
ti aiutano a proteggere la tua infrastruttura cluster e comunicazione di rete, isolare le tue risorse di calcolo e
assicurare la conformità di sicurezza tra i tuoi componenti dell'infrastruttura e
le distribuzioni del contenitore.
{: shortdesc}

<a href="https://console.bluemix.net/docs/api/content/containers/images/cs_security.png" >Sicurezza cluster <img src="images/cs_security.png" width="400" alt="{{site.data.keyword.containershort_notm}} " style="width:400px; border-style: none"/></a>


  <table summary="La prima riga nella tabella si estende su entrambe le colonne. Le rimanenti righe devono essere lette da sinistra a destra, con l'ubicazione del server nella prima colonna e gli indirizzi IP corrispondenti nella seconda colonna.">
  <thead>
  <th colspan=2><img src="images/idea.png"/>Impostazioni di sicurezza cluster integrate in {{site.data.keyword.containershort_notm}}</th>
  </thead>
  <tbody>
    <tr>
      <td>Master Kubernetes</td>
      <td>Il master Kubernetes in ogni cluster viene gestito da IBM ed è altamente disponibile. Include le impostazioni di sicurezza {{site.data.keyword.containershort_notm}}
che assicurano la conformità di sicurezza e la comunicazione protetta dai/ai nodi
di lavoro. Gli aggiornamenti vengono eseguiti da
IBM quando necessario. Il master Kubernetes dedicato controlla e monitora in modo centralizzato tutte le risorse Kubernetes
nel cluster. In base ai requisiti di distribuzione e alla capacità nel cluster, il master
Kubernetes automaticamente pianifica le tue applicazioni contenute nel contenitore per la distribuzione nei nodi
di lavoro disponibili. Per ulteriori informazioni, consulta [Sicurezza master Kubernetes](#cs_security_master).</td>
    </tr>
    <tr>
      <td>Nodo di lavoro</td>
      <td>I contenitori sono distribuiti su nodi di lavoro dedicati a un cluster e assicurano
l'isolamento di calcolo, di rete e di archiviazione ai clienti IBM. {{site.data.keyword.containershort_notm}} fornisce funzioni di sicurezza integrate per
mantenere protetti i tuoi nodi di lavoro sulla rete pubblica e privata e per assicurare la conformità
di sicurezza del nodo di lavoro. Per ulteriori informazioni, consulta [Sicurezza nodo di lavoro](#cs_security_worker).</td>
     </tr>
     <tr>
      <td>Immagini</td>
      <td>Come amministratore del cluster, puoi configurare il tuo proprio repository delle immagini Docker
in {{site.data.keyword.registryshort_notm}} dove puoi archiviare e condividere le immagini
Docker tra i tuoi utenti del cluster. Per assicurare le distribuzioni del contenitore sicure, ogni immagine nel tuo registro privato viene scansionata dal
controllo vulnerabilità. Il controllo vulnerabilità è un componente di {{site.data.keyword.registryshort_notm}} che esegue le scansioni per le vulnerabilità potenziali,
effettua raccomandazioni di sicurezza e fornisce le istruzioni per risolvere le vulnerabilità. Per ulteriori informazioni, consulta [Sicurezza immagine in {{site.data.keyword.containershort_notm}}](#cs_security_deployment).</td>
    </tr>
  </tbody>
</table>

<br />


## Master Kubernetes
{: #cs_security_master}

Riesamina le funzioni di sicurezza del master Kubernetes integrate per proteggere il master Kubernetes
e la comunicazione di rete del cluster.
{: shortdesc}

<dl>
  <dt>Master Kubernetes dedicato completamente gestito</dt>
    <dd>Ogni cluster Kubernetes in {{site.data.keyword.containershort_notm}}
è controllato da un master Kubernetes dedicato gestito da IBM in un account dell'infrastruttura IBM Bluemix (SoftLayer) di proprietà di IBM. Il master Kubernetes è configurato con i seguenti componenti dedicati che non sono condivisi con altri clienti IBM.
    <ul><li>etcd data store: archivia tutte le risorse Kubernetes di un cluster, come servizi, distribuzioni e pod. Le mappe di configurazione e i segreti Kubernetes sono dati dell'applicazione che vengono archiviati come coppie chiave-valore in modo che possano essere utilizzati da un'applicazione che viene eseguita in un pod. I dati in etcd sono archiviati su un disco crittografato gestito da IBM e crittografati tramite TLS quando vengono inviati a un pod per garantire la protezione e l'integrità dei dati.</li>
    <li>kube-apiserver: funge da punto di ingresso principale per tutte le richieste dal nodo di lavoro al master
Kubernetes. kube-apiserver convalida ed elabora le richiese e può leggere e scrivere in
etcd data store.</li>
    <li>kube-scheduler: decide dove distribuire i pod, tenendo conto dei bisogni di prestazioni e capacità dell'account,
i vincoli della politica software, le specifiche dell'anti-affinità e i requisiti
del carico di lavoro. Se non è possibile trovare alcun nodo di lavoro che corrisponda ai requisiti, il pod
non viene distribuito nel cluster.</li>
    <li>kube-controller-manager: responsabile del monitoraggio delle serie di repliche e della creazione dei pod corrispondenti
per archiviare lo stato desiderato.</li>
    <li>OpenVPN: componente specifico di {{site.data.keyword.containershort_notm}}
per fornire la connettività di rete protetta per tutti i master Kubernetes alla comunicazione del nodo di lavoro. </li></ul></dd>
  <dt>Connettività di rete protetta TLS per tutti i nodi di lavoro alla comunicazione master Kubernetes</dt>
    <dd>Per proteggere la comunicazione di rete al master Kubernetes, {{site.data.keyword.containershort_notm}} genera i certificati
TLS che codificano la comunicazione dai/ai componenti kube-apiserver e etcd data store per ogni cluster. Questi certificati non sono mai condivisi tra i cluster o tra i componenti master Kubernetes.</dd>
  <dt>Connettività di rete protetta OpenVPN per tutti i master Kubernetes alla comunicazione del nodo di lavoro</dt>
    <dd>Anche se Kubernetes protegge la comunicazione tra il master Kubernetes e i nodi di lavoro utilizzando il protocollo
`https`, non viene fornita alcuna autenticazione al nodo di lavoro per
impostazione predefinita. Per garantire questa comunicazione, {{site.data.keyword.containershort_notm}} configura automaticamente una connessione OpenVPN
tra il master Kubernetes e il nodo di lavoro quando viene creato il cluster.</dd>
  <dt>Monitoraggio della rete del master Kubernetes continuo</dt>
    <dd>Ogni master Kubernetes è continuamente monitorato da IBM per controllare e rimediare agli attacchi
DOS (Denial-Of-Service) al livello del processo.</dd>
  <dt>Conformità di sicurezza del nodo master Kubernetes</dt>
    <dd>{{site.data.keyword.containershort_notm}} esegue la scansione automaticamente di ogni nodo
in cui viene distribuito il master Kubernetes alla ricerca di vulnerabilità trovate nelle correzioni di sicurezza specifiche del sistema operativo e di Kubernetes
che devono essere applicate per assicurare la protezione al nodo master. Se vengono trovate della vulnerabilità,
{{site.data.keyword.containershort_notm}} automaticamente applica le correzioni
e risolve le vulnerabilità per conto dell'utente.</dd>
</dl>

<br />


## Nodi di lavoro
{: #cs_security_worker}

Riesamina le funzioni di sicurezza integrate dei nodi di lavoro per proteggere l'ambiente di tali nodi
e per garantire l'isolamento di risorse, rete e archiviazione.
{: shortdesc}

<dl>
  <dt>Isolamento dell'infrastruttura di calcolo, di rete e di archiviazione</dt>
    <dd>Quando crei un cluster, IBM esegue il provisioning delle macchine virtuali come nodi di lavoro nell'account dell'infrastruttura IBM Bluemix
(SoftLayer) del cliente o nell'account dell'infrastruttura IBM Bluemix (SoftLayer) dedicato di IBM. I nodi di lavoro sono dedicati a un cluster e non ospitano i carichi di lavoro di altri cluster.</br> Ogni account {{site.data.keyword.Bluemix_notm}} è configurato con le VLAN dell'infrastruttura IBM Bluemix (SoftLayer) per garantire prestazioni di rete di qualità
e l'isolamento sui nodi di lavoro. </br>Per conservare i dati nel tuo cluster, puoi
eseguire il provisioning dell'archivio file basato su NFS dedicato dall'infrastruttura IBM Bluemix (SoftLayer) e utilizzare le funzioni di protezione dei dati integrate
di questa piattaforma.</dd>
  <dt>Configurazione di nodi di lavoro protetti</dt>
    <dd>Ogni nodo di lavoro è configurato con un sistema operativo Ubuntu che non può essere modificato dall'utente. Per proteggere il sistema operativo dei nodi di lavoro da potenziali attacchi, ogni nodo di lavoro è configurato con delle impostazioni del firewall avanzate che sono implementate dalle regole iptable di Linux.</br> Tutti i contenitori in esecuzione su
Kubernetes sono protetti da impostazioni di rete Calico predefinite configurate su ogni nodo di lavoro durante
la creazione del cluster. Questa configurazione garantisce la comunicazione di rete tra i nodi di lavoro e i pod. Per limitare ulteriormente le azioni che un contenitore può eseguire sul nodo di lavoro, gli utenti possono scegliere di configurare le
[politiche AppArmor ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/tutorials/clusters/apparmor/) nei nodi di lavoro.</br> Per impostazione predefinita, l'accesso SSH per l'utente root è disabilitato sul nodo di lavoro. Se vuoi installare delle funzioni aggiuntive sul nodo di lavoro, puoi utilizzare
le [serie daemon Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset) per tutto quello che vuoi eseguire su ogni nodo di lavoro oppure i
[lavori Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/) per qualsiasi azione a singola ricorrenza che vuoi eseguire.</dd>
  <dt>Conformità di sicurezza del nodo di lavoro Kubernetes</dt>
    <dd>IBM collabora con team di sicurezza esterni e interni per risolvere le vulnerabilità di conformità di sicurezza potenziali. IBM mantiene l'accesso SSH ai nodi di lavoro per distribuire gli aggiornamenti e le patch di sicurezza al sistema operativo. </br> <b>Importante</b>: riavvia regolarmente i nodi
di lavoro per assicurarti che l'installazione di aggiornamenti e patch di sicurezza venga automaticamente distribuita al sistema operativo. IBM non riavvia i tuoi nodi di lavoro.</dd>
  <dt>Supporto per i firewall della rete dell'infrastruttura IBM Bluemix (SoftLayer)</dt>
    <dd>{{site.data.keyword.containershort_notm}} è compatibile con tutte le offerte firewall dell'[Infrastruttura
IBM Bluemix (SoftLayer) ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.ibm.com/cloud-computing/bluemix/network-security). Su {{site.data.keyword.Bluemix_notm}} pubblico,
puoi configurare un firewall con politiche di rete personalizzate per fornire
una sicurezza di rete dedicata al tuo cluster e per rilevare e risolvere intrusioni di rete. Ad esempio, puoi scegliere di configurare [Vyatta ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://knowledgelayer.softlayer.com/topic/vyatta-1) ad agire come tuo firewall e bloccare il traffico indesiderato. Quando configuri un firewall, [devi anche aprire le porte e gli indirizzi IP necessari](#opening_ports) per ogni regione in modo che il master e i nodi di lavoro possano comunicare. Si {{site.data.keyword.Bluemix_notm}} dedicato,
i firewall, DataPower, Fortigate e DNS sono già configurati come parte della distribuzione dell'ambiente dedicato standard.</dd>
  <dt>Mantieni i servizi privati o esponi selettivamente i sevizi e le applicazioni a internet pubblicamente</dt>
    <dd>Puoi scegliere di mantenere privati i tuoi servizi e le tue applicazioni e di utilizzare le funzioni di sicurezza integrate
descritte in questo argomento per garantire la comunicazione protetta tra i nodi di lavoro e i pod. Per esporre i servizi e le applicazioni pubblicamente su internet, puoi utilizzare il supporto Ingress e il programma di bilanciamento del carico per
rendere in modo sicuro i tuoi servizi pubblicamente disponibili.</dd>
  <dt>Collega in modo sicuro i tuoi nodi di lavoro e applicazioni a un data center in loco</dt>
    <dd>Puoi configurare un'applicazione gateway Vyatta o un'applicazione Fortigate per configurare un endpoint VPN IPSec che collega il tuo cluster Kubernetes a un data center in loco. In un tunnel crittografato, tutti i servizi che esegui nel tuo cluster Kubernetes possono comunicare in modo sicuro con le applicazioni in loco, come ad esempio le directory utente, i database o i mainframe. Per ulteriori informazioni, consulta [Connecting a cluster to an on-premise data center ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.ibm.com/blogs/bluemix/2017/07/kubernetes-and-bluemix-container-based-workloads-part4/).</dd>
  <dt>Registrazione e monitoraggio continuo dell'attività del cluster</dt>
    <dd>Per i cluster standard, tutti gli eventi correlati al cluster, come l'aggiunta di un nodo di lavoro, lo stato di avanzamento dell'aggiornamento in sequenza o le informazioni sull'utilizzo della capacità sono registrati e monitorati da {{site.data.keyword.containershort_notm}}
e inviati al servizio di monitoraggio e registrazione di IBM.</dd>
</dl>

### Apertura delle porte e degli indirizzi IP necessari nel tuo firewall
{: #opening_ports}

Controlla le seguenti situazioni in cui potresti aver bisogno di aprire porte e indirizzi IP specifici nei tuoi firewall:
* Per consentire la comunicazione tra il master Kubernetes e i nodi di lavoro quando è configurato un firewall per i nodi di lavoro o le impostazioni del firewall sono personalizzate nel tuo account dell'infrastruttura IBM Bluemix (SoftLayer)
* Per accedere al programma di bilanciamento del carico o al controller Ingress dall'esterno del cluster
* Per eseguire i comandi `kubectl` dal tuo sistema locale quando le politiche di rete aziendali impediscono l'accesso agli endpoint di rete pubblici tramite proxy o firewall.

  1.  Prendi nota dell'indirizzo IP pubblico di tutti i nodi di lavoro nel cluster.

      ```
      bx cs workers <cluster_name_or_id>
      ```
      {: pre}

  2.  Nel tuo firewall per la connettività IN USCITA dai tuoi nodi di lavoro, consenti il traffico di rete in uscita dal nodo di lavoro
di origine alle porte TCP/UDP di destinazione comprese nell'intervallo 20000-32767 e la portata 443 per `<each_worker_node_publicIP>` e i seguenti indirizzi IP e gruppi di rete.
      - **Importante**: devi consentire il traffico in uscita alla porta 443 e a tutte le ubicazioni nella regione tra di loro, per bilanciare il carico durante il processo di avvio. Ad esempio, se il tuo cluster è in Stati Uniti Sud, devi consentire il traffico dalla porta 443 per dal10 e dal12 e da dal10 e dal12 tra loro.
      <p>
  <table summary="La prima riga nella tabella si estende su entrambe le colonne. Le rimanenti righe devono essere lette da sinistra a destra, con l'ubicazione del server nella prima colonna e gli indirizzi IP corrispondenti nella seconda colonna.">
      <thead>
      <th>Regione</th>
      <th>Ubicazione</th>
      <th>indirizzo IP</th>
      </thead>
    <tbody>
      <tr>
         <td>Asia Pacifico Sud</td>
         <td>mel01<br>syd01</td>
         <td><code>168.1.97.67</code><br><code>168.1.8.195</code></td>
      </tr>
      <tr>
         <td>Europa Centrale</td>
         <td>ams03<br>fra02</td>
         <td><code>169.50.169.110</code><br><code>169.50.56.174</code></td>
        </tr>
      <tr>
        <td>Regno Unito Sud</td>
        <td>lon02<br>lon04</td>
        <td><code>159.122.242.78</code><br><code>158.175.65.170</code></td>
      </tr>
      <tr>
        <td>Stati Uniti Est </td>
         <td>wdc06<br>wdc07</td>
         <td><code>169.60.73.142</code><br><code>169.61.83.62</code></td>
      </tr>
      <tr>
        <td>Stati Uniti Sud</td>
        <td>dal10<br>dal12<br>dal13</td>
        <td><code>169.46.7.238</code><br><code>169.47.70.10</code><br><code>169.60.128.2</code></td>
      </tr>
      </tbody>
    </table>
</p>

  3.  Consenti il traffico di rete in uscita dai nodi di lavoro a {{site.data.keyword.registrylong_notm}}:
      - `TCP port 443 FROM <each_worker_node_publicIP> TO <registry_publicIP>`
      - Sostituisci <em>&lt;registry_publicIP&gt;</em> con tutti gli indirizzi delle regioni del registro per cui desideri consentire il traffico:
        <p>      
<table summary="La prima riga nella tabella si estende su entrambe le colonne. Le rimanenti righe devono essere lette da sinistra a destra, con l'ubicazione del server nella prima colonna e gli indirizzi IP corrispondenti nella seconda colonna.">
        <thead>
        <th colspan=2><img src="images/idea.png"/> Indirizzi IP registro</th>
        </thead>
      <tbody>
        <tr>
          <td>registry.au-syd.bluemix.net</td>
          <td><code>168.1.45.160/27</code></br><code>168.1.139.32/27</code></td>
        </tr>
        <tr>
          <td>registry.eu-de.bluemix.net</td>
          <td><code>169.50.56.144/28</code></br><code>159.8.73.80/28</code></td>
         </tr>
         <tr>
          <td>registry.eu-gb.bluemix.net</td>
          <td><code>159.8.188.160/27</code></br><code>169.50.153.64/27</code></td>
         </tr>
         <tr>
          <td>registry.ng.bluemix.net</td>
          <td><code>169.55.39.112/28</code></br><code>169.46.9.0/27</code></br><code>169.55.211.0/27</code></td>
         </tr>
        </tbody>
      </table>
</p>

  4.  Facoltativo: consenti il traffico di rete in uscita dai nodi di lavoro ai servizi {{site.data.keyword.monitoringlong_notm}} e {{site.data.keyword.loganalysislong_notm}}:
      - `TCP port 443, port 9095 FROM <each_worker_node_publicIP> TO <monitoring_publicIP>`
      - Sostituisci <em>&lt;monitoring_publicIP&gt;</em> con tutti gli indirizzi delle regioni di monitoraggio per cui desideri consentire il traffico:
        <p><table summary="La prima riga nella tabella si estende su entrambe le colonne. Le rimanenti righe devono essere lette da sinistra a destra, con l'ubicazione del server nella prima colonna e gli indirizzi IP corrispondenti nella seconda colonna.">
        <thead>
        <th colspan=2><img src="images/idea.png"/> Monitoraggio indirizzi IP pubblici</th>
        </thead>
      <tbody>
        <tr>
         <td>metrics.eu-de.bluemix.net</td>
         <td><code>159.122.78.136/29</code></td>
        </tr>
        <tr>
         <td>metrics.eu-gb.bluemix.net</td>
         <td><code>169.50.196.136/29</code></td>
        </tr>
        <tr>
          <td>metrics.ng.bluemix.net</td>
          <td><code>169.47.204.128/29</code></td>
         </tr>
         
        </tbody>
      </table>
</p>
      - `TCP port 443, port 9091 FROM <each_worker_node_publicIP> TO <logging_publicIP>`
      - Sostituisci <em>&lt;logging_publicIP&gt;</em> con tutti gli indirizzi delle regioni di registrazione per cui desideri consentire il traffico:
        <p><table summary="La prima riga nella tabella si estende su entrambe le colonne. Le rimanenti righe devono essere lette da sinistra a destra, con l'ubicazione del server nella prima colonna e gli indirizzi IP corrispondenti nella seconda colonna.">
        <thead>
        <th colspan=2><img src="images/idea.png"/> Registrazione indirizzi IP pubblici</th>
        </thead>
      <tbody>
        <tr>
         <td>ingest.logging.eu-de.bluemix.net</td>
         <td><code>169.50.25.125</code></td>
        </tr>
        <tr>
         <td>ingest.logging.eu-gb.bluemix.net</td>
         <td><code>169.50.115.113</code></td>
        </tr>
        <tr>
          <td>ingest.logging.ng.bluemix.net</td>
          <td><code>169.48.79.236</code><br><code>169.46.186.113</code></td>
         </tr>
        </tbody>
      </table>
</p>

  5. Per i firewall privati, consenti gli intervalli di IP privati dell'infrastruttura IBM Bluemix (SoftLayer) appropriati. Consulta [questo link](https://knowledgelayer.softlayer.com/faq/what-ip-ranges-do-i-allow-through-firewall) a iniziare dalla sezione **Backend (private) Network**.
      - Aggiungi tutte le [ubicazioni nelle regioni](cs_regions.html#locations) che stai utilizzando
      - Tieni presente che devi aggiungere l'ubicazione dal01 (data center)
      - Apri le porte 80 e 443 per consentire il processo di avvio del cluster

  6. Facoltativo: per accedere al programma di bilanciamento del carico dall'esterno della VLAN, apri la porta per il traffico di rete in entrata per l'indirizzo IP specifico di tale programma di bilanciamento del carico.

  7. Facoltativo: per accedere al controller Ingress dall'esterno della VLAN, apri la porta 80 o 443 per il traffico di rete in entrata per l'indirizzo IP specifico di tale controller Ingress, a seconda di quale porta hai configurato.

<br />


## Politiche di rete
{: #cs_security_network_policies}

Ogni cluster Kubernetes è configurato con un plug-in di rete chiamato Calico. Le politiche di rete predefinite
vengono configurate per proteggere l'interfaccia di rete pubblica di ogni nodo di lavoro. Puoi utilizzare
le funzionalità Calico e Kubernetes native per configurare ulteriori politiche di rete per un cluster
quando hai requisiti di sicurezza univoci. Queste politiche di rete specificano il traffico di rete che vuoi
consentire o bloccare da e verso un pod in un cluster.
{: shortdesc}

Puoi scegliere tra le funzionalità Calico e Kubernetes native per creare politiche di rete per il tuo
cluster. Per iniziare, potresti utilizzare le politiche di rete Kubernetes, ma, per delle funzionalità più
solide, utilizza le politiche di rete Calico.

<ul>
  <li>[Politiche di rete Kubernetes
![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/concepts/services-networking/network-policies/): vengono fornite alcune opzioni di base ad esempio la specifica di quali pod possono comunicare tra loro. Il traffico di rete in entrata può essere consentito o bloccato per un protocollo e una porta Questo traffico può essere filtrato in base alle etichette e agli spazi dei nomi Kubernetes del pod che sta tentando di collegarsi ad altri pod.</br>Queste politiche possono essere applicate utilizzando
i comandi `kubectl` o le API Kubernetes. Quando queste politiche vengono applicate, vengono
convertite in politiche Calico e quindi Calico applica tali politiche.</li>
  <li>[Politiche di rete Calico
![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](http://docs.projectcalico.org/v2.4/getting-started/kubernetes/tutorials/advanced-policy): queste politiche sono un soprainsieme delle politiche di rete Kubernetes e migliorano le funzionalità Kubernetes native con le seguenti
funzioni.</li>
    <ul><ul><li>Consentire o bloccare il traffico di rete su interfacce di rete specifiche, non solo il traffico di pod
Kubernetes.</li>
    <li>Consentire o bloccare il traffico di rete in entrata e in uscita.</li>
    <li>[Bloccare il traffico in entrata ai servizi LoadBalancer o NodePort](#cs_block_ingress).</li>
    <li>Consentire o bloccare il traffico basato sull'indirizzo IP di origine o destinazione o CIDR.</li></ul></ul></br>

Queste politiche vengono applicate utilizzando i comandi `calicoctl`. Calico applica
queste politiche, incluse tutte le politiche di rete Kubernetes convertite in politiche Calico,
configurando le regole iptables di Linux sui nodi di lavoro Kubernetes. Le regole iptables fungono da firewall
per il nodo di lavoro per definire le caratteristiche che il traffico di rete deve soddisfare per essere inoltrato
alla risorsa di destinazione.</ul>


### Configurazione delle politiche predefinite
{: #concept_nq1_2rn_4z}

Quando si crea un cluster, le politiche di rete predefinite vengono configurate automaticamente per
l'interfaccia di rete pubblica di ogni nodo di lavoro per limitare il traffico in entrata per un nodo di lavoro
dall'Internet pubblico. Queste politiche non influiscono sul traffico tra i pod e sono configurate per consentire l'accesso ai
servizi nodeport, programma di bilanciamento del carico e Ingress di Kubernetes.

Le politiche predefinite non vengono applicate direttamente ai pod; vengono applicate all'interfaccia di rete pubblica
di un nodo di lavoro utilizzando un [endpoint host
![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](http://docs.projectcalico.org/v2.0/getting-started/bare-metal/bare-metal). Quando un endpoint host viene creato in Calico, tutto il traffico da e verso l'interfaccia
di rete di tale nodo di lavoro viene bloccato, a meno che il traffico non sia consentito da un politica.

Nota che non esiste una politica per consentire SSH, pertanto l'accesso SSH attraverso l'interfaccia di rete pubblica
è bloccato, così come tutte le altre porte che non hanno una politica per aprirle. L'accesso SSH, oltre ad altri tipi di accesso,
è disponibile sull'interfaccia di rete privata di ogni nodo di lavoro.

**Importante:** non rimuovere le politiche applicate a un endpoint host a meno che
tu non abbia compreso pienamente la politica e sappia che non hai bisogno del traffico che viene consentito dalla politica.


 <table summary="La prima riga nella tabella si estende su entrambe le colonne. Le rimanenti righe devono essere lette da sinistra a destra, con l'ubicazione del server nella prima colonna e gli indirizzi IP corrispondenti nella seconda colonna.">
  <thead>
  <th colspan=2><img src="images/idea.png"/> Politiche predefinite per ogni cluster</th>
  </thead>
  <tbody>
    <tr>
      <td><code>allow-all-outbound</code></td>
      <td>Consente tutto il traffico in uscita.</td>
    </tr>
    <tr>
      <td><code>allow-icmp</code></td>
      <td>Consente i pacchetti icmp in entrata (ping).</td>
     </tr>
     <tr>
      <td><code>allow-kubelet-port</code></td>
      <td>Consente tutto il traffico in entrata alla porta 10250, che è la porta utilizzata da kubelet. Questa politica permette a `kubectl logs` e `kubectl exec` di funzionare correttamente
nel cluster Kubernetes.</td>
    </tr>
    <tr>
      <td><code>allow-node-port-dnat</code></td>
      <td>Consente il traffico in entrata dei servizi nodeport, programma di bilanciamento del carico e Ingress ai pod a cui vengono
esposti questi servizi. Nota che la porta che questi servizi espongono sull'interfaccia pubblica non deve essere
specificata perché Kubernetes utilizza la conversione dell'indirizzo di rete di destinazione (DNAT) per inoltrare
le richieste di servizio ai pod corretti. L'inoltro avviene prima che le politiche dell'endpoint host
vengano applicate in iptables.</td>
   </tr>
   <tr>
      <td><code>allow-sys-mgmt</code></td>
      <td>Consente le connessioni in entrata per specifici sistemi dell'infrastruttura IBM Bluemix (SoftLayer) utilizzati per gestire i
nodi di lavoro.</td>
   </tr>
   <tr>
    <td><code>allow-vrrp</code></td>
    <td>Consente i pacchetti vrrp, utilizzati per monitorare e spostare gli indirizzi IP virtuali tra i nodi
di lavoro.</td>
   </tr>
  </tbody>
</table>


### Aggiunta di politiche di rete
{: #adding_network_policies}

Nella maggior parte dei casi, le politiche predefinite non devono essere modificate. Solo in scenari avanzati
potrebbero essere richieste delle modifiche. Se ritieni di dover apportare modifiche, installa la CLI Calico e crea
le tue proprie politiche di rete.

Prima di iniziare:

1.  [Installa le CLI di {{site.data.keyword.containershort_notm}} e Kubernetes.](cs_cli_install.html#cs_cli_install)
2.  [Crea un cluster lite o standard.](cs_cluster.html#cs_cluster_ui)
3.  [Indirizza la CLI Kubernetes CLI al
cluster](cs_cli_install.html#cs_cli_configure). Includi l'opzione --admin con il comando bx cs
cluster-config`, che viene utilizzato per scaricare i file di autorizzazione e i certificati. Questo download include inoltre le chiavi per il ruolo Super utente, di cui hai bisogno per eseguire i comandi
Calico. 

  ```
  bx cs cluster-config <cluster_name> --admin
  ```
  {: pre}

  **Nota**: la versione della CLI Calico 1.4.0 è supportata.

Per aggiungere le politiche di rete:
1.  Installa la CLI Calico.
    1.  [Scarica la CLI Calico ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/projectcalico/calicoctl/releases/tag/v1.4.0).

        **Suggerimento:** se utilizzi Windows, installa la CLI Calico
nella stessa directory in cui si trova la CLI {{site.data.keyword.Bluemix_notm}}. Questa configurazione salva alcune modifiche al percorso file
quando esegui il comando in un secondo momento.

    2.  Per gli utenti OSX e Linux, completa la seguente procedura.
        1.  Sposta il file eseguibile nella directory /usr/local/bin.
            -   Linux:

              ```
              mv /<path_to_file>/calicoctl /usr/local/bin/calicoctl
              ```
              {: pre}

            -   OS
X:

              ```
              mv /<path_to_file>/calicoctl-darwin-amd64 /usr/local/bin/calicoctl
              ```
              {: pre}

        2.  Rendi il file eseguibile.

            ```
            chmod +x /usr/local/bin/calicoctl
            ```
            {: pre}

    3.  Verifica la corretta esecuzione dei comandi `calico` controllando la versione client della CLI Calico.

        ```
        calicoctl version
        ```
        {: pre}

2.  Configura la CLI Calico.

    1.  Per Linux e OS X, crea la directory `/etc/calico`. Per Windows, può essere utilizzata qualsiasi directory.

      ```
      sudo mkdir -p /etc/calico/
      ```
      {: pre}

    2.  Crea una file `calicoctl.cfg`.
        -   Linux e OS X:

          ```
          sudo vi /etc/calico/calicoctl.cfg
          ```
          {: pre}

        -   Windows: crea il file con un editor di testo.

    3.  Immetti le seguenti informazioni nel file <code>calicoctl.cfg</code>.

        ```
        apiVersion: v1
      kind: calicoApiConfig
      metadata:
      spec:
          etcdEndpoints: <ETCD_URL>
          etcdKeyFile: <CERTS_DIR>/admin-key.pem
          etcdCertFile: <CERTS_DIR>/admin.pem
          etcdCACertFile: <CERTS_DIR>/<ca-*pem_file>
        ```
        {: codeblock}

        1.  Richiama `<ETCD_URL>`. Se questo comando ha esito negativo con un errore `calico-config not found`,
consulta questo [argomento sulla risoluzione dei problemi](cs_troubleshoot.html#cs_calico_fails).

          -   Linux e OS X:

              ```
              kubectl get cm -n kube-system calico-config -o yaml | grep "etcd_endpoints:" | awk '{ print $2 }'
              ```
              {: pre}

          -   Esempio di
output:

              ```
              https://169.1.1.1:30001
              ```
              {: screen}

          -   Windows:
            <ol>
            <li>Ottieni i valori di configurazione calico dalla mappa di configurazione. </br><pre class="codeblock"><code>kubectl get cm -n kube-system calico-config -o yaml</code></pre></br>
            <li>Nella sezione `data`, individua il valore etcd_endpoints. Esempio: <code>https://169.1.1.1:30001</code>
            </ol>

        2.  Richiama `<CERTS_DIR>`, ossia la directory in cui vengono scaricati i certificati Kubernetes.

            -   Linux e OS X:

              ```
              dirname $KUBECONFIG
              ```
              {: pre}

                Esempio di
output:

              ```
              /home/sysadmin/.bluemix/plugins/container-service/clusters/<cluster_name>-admin/
              ```
              {: screen}

            -   Windows:

              ```
              ECHO %KUBECONFIG%
              ```
              {: pre}

                Esempio di
output:

              ```
              C:/Users/<user>/.bluemix/plugins/container-service/<cluster_name>-admin/kube-config-prod-<location>-<cluster_name>.yml
              ```
              {: screen}

            **Nota**: per ottenere il percorso della directory, rimuovi il nome file `kube-config-prod-<location>-<cluster_name>.yml` dalla fine dell'output.

        3.  Richiama il
<code>ca-*pem_file<code>.

            -   Linux e OS X:

              ```
              ls `dirname $KUBECONFIG` | grep "ca-"
              ```
              {: pre}

            -   Windows:
              <ol><li>Apri la directory che hai richiamato nell'ultimo
passo.</br><pre class="codeblock"><code>C:\Users\<user>\.bluemix\plugins\container-service\&lt;cluster_name&gt;-admin\</code></pre>
              <li> Individua il file <code>ca-*pem_file</code>.</ol>

        4.  Verifica che la configurazione di Calico funzioni
correttamente.

            -   Linux e OS X:

              ```
              calicoctl get nodes
              ```
              {: pre}

            -   Windows:

              ```
              calicoctl get nodes --config=<path_to_>/calicoctl.cfg
              ```
              {: pre}

              Output:

              ```
              NAME
              kube-dal10-crc21191ee3997497ca90c8173bbdaf560-w1.cloud.ibm
              kube-dal10-crc21191ee3997497ca90c8173bbdaf560-w2.cloud.ibm
              kube-dal10-crc21191ee3997497ca90c8173bbdaf560-w3.cloud.ibm
              ```
              {: screen}

3.  Esamina le politiche di rete esistenti.

    -   Visualizza l'endpoint host
Calico.

      ```
      calicoctl get hostendpoint -o yaml
      ```
      {: pre}

    -   Visualizza tutte le politiche di rete di Calico e Kubernetes che sono state create per il cluster. Questo elenco contiene politiche che potrebbero non essere ancora applicate a tutti i pod o gli host. Affinché una politica di rete
venga applicata, deve trovare una risorsa Kubernetes che corrisponda al selettore definito
nella politica di rete Calico.

      ```
      calicoctl get policy -o wide
      ```
      {: pre}

    -   Visualizza i dettagli per una politica di
rete.

      ```
      calicoctl get policy -o yaml <policy_name>
      ```
      {: pre}

    -   Visualizza i dettagli di tutte le politiche di rete per il
cluster.

      ```
      calicoctl get policy -o yaml
      ```
      {: pre}

4.  Crea le politiche di rete Calico per consentire o bloccare il traffico.

    1.  Definisci la tua [politica di rete Calico
![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](http://docs.projectcalico.org/v2.1/reference/calicoctl/resources/policy) creando uno script di configurazione (.yaml). Questi file di configurazione includono i selettori
che descrivono a quali pod, spazi dei nomi o host vengono applicate queste politiche. Fai riferimento a queste
[politiche Calico di esempio
![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](http://docs.projectcalico.org/v2.0/getting-started/kubernetes/tutorials/advanced-policy) per informazioni su come creare le tue proprie politiche.

    2.  Applica le politiche al cluster.
        -   Linux e OS X:

          ```
          calicoctl apply -f <policy_file_name.yaml>
          ```
          {: pre}

        -   Windows:

          ```
          calicoctl apply -f <path_to_>/<policy_file_name.yaml> --config=<path_to_>/calicoctl.cfg
          ```
          {: pre}

### Bloccare il traffico in entrata ai servizi LoadBalancer o NodePort.
{: #cs_block_ingress}

Per impostazione predefinita, i servizi Kubernetes `NodePort` e `LoadBalancer` sono progettati per rendere le tue applicazioni disponibili
su tutte le interfacce del cluster private e pubbliche. Tuttavia, puoi bloccare il traffico in entrata ai tuoi servizi in base alla destinazione o all'origine del traffico. Per bloccare il traffico, crea le politiche di rete `preDNAT` Calico.

Un servizio Kubernetes LoadBalancer è anche un servizio NodePort. Un servizio LoadBalancer rende la tua applicazione disponibile per la porta e l'indirizzo IP del programma di bilanciamento del carico e per le porte del nodo del servizio. È possibile accedere alle porte del nodo da ogni indirizzo IP (pubblico e privato) di ogni nodo all'interno del cluster.

L'amministratore del cluster può utilizzare il blocco delle politiche di rete `preDNAT` Calico:

  - Traffico ai servizi NodePort. Il traffico ai servizi LoadBalancer è consentito.
  - Traffico basato su un indirizzo di origine o un CIDR.

Un vantaggio di queste funzioni è che l'amministratore del cluster può bloccare il traffico alle porte del nodo pubbliche di un servizio LoadBalancer privato. L'amministratore può anche abilitare l'accesso all'elenco degli elementi consentiti ai servizi NodePort o LoadBalancer. Le politiche di rete `preDNAT` sono utili perché le politiche predefinite di Kubernetes e Calico sono difficili da applicare per la protezione dei servizi Kubernetes NodePort e LoadBalancer a causa delle regole iptables DNAT generate per questi servizi.

Le politiche di rete `preDNAT` Calico generano le regole iptables in base a una [risorsa della politica di rete
Calico ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://docs.projectcalico.org/v2.4/reference/calicoctl/resources/policy).

1. Definisci una politica di rete `preDNAT` Calico per l'accesso in entrata ai servizi Kubernetes. Questo esempio
blocca tutte le porte dei nodi.

  ```
  apiVersion: v1
  kind: policy
  metadata:
    name: deny-kube-node-port-services
  spec:
    preDNAT: true
    selector: ibm.role in { 'worker_public', 'master_public' }
    ingress:
    - action: deny
      protocol: tcp
      destination:
        ports:
        - 30000:32767
    - action: deny
      protocol: udp
      destination:
        ports:
        - 30000:32767
  ```
  {: codeblock}

2. Applica la politica di rete preDNAT Calico. Serve circa 1 minuto
perché le modifiche alla politica vengano applicate nel cluster.

  ```
  /opt/bin/calicoctl apply -f deny-kube-node-port-services.yaml
  ```
  {: pre}

<br />


## Immagini
{: #cs_security_deployment}

Gestisci la sicurezza e l'integrità delle tue immagini con le funzioni di sicurezza integrate.
{: shortdesc}

### Repository delle immagini privato Docker sicuro in {{site.data.keyword.registryshort_notm}}:

 Puoi configurare
il tuo proprio repository delle immagini Docker in un multi-tenant, altamente disponibile e il registro delle immagini privato scalabile
ospitato da IBM per creare, archiviare in modo sicuro e condividere le immagini
Docker tra più utenti del cluster.

### Conformità della sicurezza dell'immagine:

Quando utilizzi {{site.data.keyword.registryshort_notm}},
puoi utilizzare la scansione di sicurezza integrata fornita dal Controllo vulnerabilità. Ogni immagine trasmessa al tuo spazio dei nomi
viene automaticamente scansionata alla ricerca di vulnerabilità
con un database di problemi CentOS, Debian, Red Hat e Ubuntu conosciuti. Se vengono trovate delle vulnerabilità,
il Controllo vulnerabilità fornisce le istruzioni su come risolverli per garantire la sicurezza e l'integrità dell'immagine.

Per
visualizzare la valutazione della vulnerabilità per la tua immagine:

1.  Da **catalog**, nella sezione Containers, seleziona **Container Registry**.
2.  Nella pagina **Private Repositories**, nella tabella **Repositories**, identifica l'immagine.
3.  Nella colonna **Security Report**, fai clic sullo stato dell'immagine per richiamarne la valutazione della vulnerabilità.
