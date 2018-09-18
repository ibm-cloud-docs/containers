---

copyright:
  years: 2014, 2018
lastupdated: "2018-08-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}




# Pianificazione di archiviazione persistente altamente disponibile
{: #storage_planning}

## Opzioni di archiviazione dati non persistente
{: #non_persistent}

Puoi utilizzare le opzioni di archiviazione non persistente se i dati non devono essere memorizzati in modo persistente o se i dati non devono essere condivisi tra le istanze dell'applicazione. Le opzioni di archiviazione
non persistente possono essere utilizzate anche per la verifica dell'unità dei tuoi componenti dell'applicazione o per provare nuove funzioni.
{: shortdesc}

La seguente immagine mostra le opzioni di archiviazione dati non persistente disponibili in {{site.data.keyword.containerlong_notm}}. Queste opzioni sono disponibili per i cluster gratuito e standard.
<p>
<img src="images/cs_storage_nonpersistent.png" alt="Opzioni di archiviazione dati non persistente" width="500" style="width: 500px; border-style: none"/></p>

<table summary="La tabella mostra le opzioni di archiviazione non persistente. Le righe devono essere lette da sinistra a destra, con il numero dell'opzione nella colonna uno, il titolo delle opzioni nella colonna due e una descrizione nella colonna tre." style="width: 100%">
<caption>Opzioni di archiviazione non persistente</caption>
  <thead>
  <th>Opzione</th>
  <th>Descrizione</th>
  </thead>
  <tbody>
    <tr>
      <td>1. All'interno del contenitore o del pod</td>
      <td>I contenitori e i pod sono, come progettati, di breve durata e possono avere un malfunzionamento imprevisto. Tuttavia, puoi scrivere i dati nel file system locale del contenitore per memorizzare i dati tramite il ciclo di vita di un contenitore. I dati all'interno di un contenitore non possono essere condivisi con altri contenitori o pod e vengono persi quando il contenitore ha un arresto anomalo o viene rimosso. Per ulteriori informazioni, consulta [Memorizzazione dei dati in un contenitore](https://docs.docker.com/storage/).</td>
    </tr>
  <tr>
    <td>2. Nel nodo di lavoro</td>
    <td>Ogni nodo di lavoro è configurato con un'archiviazione primaria e secondaria determinata dal tipo di macchina che selezioni per il tuo nodo di lavoro. L'archiviazione primaria viene utilizzata per memorizzare i dati dal sistema operativo e vi si può accedere utilizzando un [volume Kubernetes <code>hostPath</code> ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/concepts/storage/volumes/#hostpath). L'archiviazione secondaria viene utilizzata per memorizzare i dati da `kubelet` e dal motore di runtime del contenitore. Puoi accedere all'archiviazione secondaria utilizzando un [volume Kubernetes <code>emptyDir</code> ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/concepts/storage/volumes/#emptydir)<br/><br/>Mentre i volumi <code>hostPath</code> vengono utilizzati per montare i file dal file system del nodo di lavoro sul tuo pod, <code>emptyDir</code> crea una directory vuota che viene assegnata a un pod nel tuo cluster. Tutti i contenitori in questo pod possono leggere e scrivere su quel volume. Poiché il volume è assegnato
a un pod specifico, i dati non possono essere condivisi con altri pod in una serie di repliche.<br/><br/><p>Un volume <code>hostPath</code> o <code>emptyDir</code> e i relativi dati vengono rimossi quando: <ul><li>Il nodo di lavoro viene eliminato.</li><li>Il nodo di lavoro viene ricaricato o aggiornato.</li><li>Il cluster viene eliminato.</li><li>L'account {{site.data.keyword.Bluemix_notm}} raggiunge uno stato sospeso. </li></ul></p><p>Inoltre, i dati in un volume <code>emptyDir</code> vengono rimossi quando: <ul><li>Il pod assegnato
viene eliminato definitivamente dal nodo di lavoro.</li><li>Il pod assegnato viene pianificato su un altro nodo di lavoro.</li></ul></p><p><strong>Nota:</strong> se il contenitore nel pod ha un arresto anomalo, i dati
nel volume sono ancora disponibili nel nodo di lavoro.</p></td>
    </tr>
    </tbody>
    </table>


## Opzioni di archiviazione dati persistente per l'elevata disponibilità
{: #persistent}

La sfida principale quando crei le applicazioni con stato altamente disponibili è di conservare i dati tra più istanze dell'applicazione in più zone e mantenere i dati sempre sincronizzati. Per i dati altamente disponibili, vuoi assicurarti di avere un database master con più istanze che vengono suddivise tra più data center
o anche tra più regioni. Questo database master deve essere continuamente replicato per mantenere una singola fonte di verità. Tutte le istanze nel tuo cluster devono leggere e scrivere in questo database master. Nel caso un'istanza del master sia inattiva, le altre istanze sostengono il carico di lavoro, per cui non riscontri del tempo di inattività per le tue applicazioni.
{: shortdesc}

La seguente immagine mostra le opzioni che hai a disposizione in {{site.data.keyword.containerlong_notm}} per rendere i tuoi dati altamente disponibili in un cluster standard. L'opzione giusta per te dipende dai seguenti fattori:
  * **Il tuo tipo di applicazione:** ad esempio, potresti avere un'applicazione che deve memorizzare i dati su una base file rispetto che all'interno di un database.
  * **I requisiti legali su dove memorizzare e instradare i dati:** ad esempio, potresti essere obbligato a memorizzare e instradare i dati solo negli Stati Uniti e non poter utilizzare un servizio ubicato in Europa.
  * **Le opzioni di backup e ripristino:** ogni opzione di memorizzazione viene fornita con le funzionalità di backup e ripristino dei dati. Controlla che le opzioni di backup e ripristino disponibili soddisfano i tuoi requisiti del piano di ripristino di emergenza, come la frequenza dei backup o le funzionalità di archiviazione dei dati all'esterno del tuo data center primario.
  * **La replica globale:** per l'elevata disponibilità, potresti voler configurare più istanze di memorizzazione distribuite e replicate tra i data center globalmente.

<br/>
<img src="images/cs_storage_mz-ha.png" alt="Opzioni di alta disponibilità per l'archiviazione persistente"/>

<table summary="La tabella mostra le opzioni di archiviazione persistente: le righe devono essere lette da sinistra a destra, con il numero dell'opzione nella colonna uno, il titolo dell'opzione nella colonna due e una descrizione nella colonna tre." style="width: 100%">
<caption>Opzioni di archiviazione persistente</caption>
  <thead>
  <th>Opzione</th>
  <th>Descrizione</th>
  </thead>
  <tbody>
  <tr>
  <td>1. NFS o archiviazione blocchi</td>
  <td>Con questa opzione, puoi conservare i dati del contenitore e dell'applicazione nella stessa zona utilizzando i volumi persistenti Kubernetes. </br></br><strong>Come posso eseguire il provisioning dell'archiviazione file o blocchi?</strong></br>Per eseguire il provisioning di archiviazione file e archiviazione blocchi in un cluster, [utilizzi i volumi persistenti (o PV; persistent volume) e le attestazioni del volume persistente (o PVC, persistent volume claim).](cs_storage_basics.html#pvc_pv). Le PVC e i PV sono concetti Kubernetes che astraggono l'API per eseguire il provisioning del dispositivo di archiviazione file o blocchi fisico. Puoi creare le PVC e i PV utilizzando il provisioning [dinamico](cs_storage_basics.html#dynamic_provisioning) o [statico](cs_storage_basics.html#static_provisioning). </br></br><strong>Come utilizzo l'archiviazione file o blocchi in un cluster multizona?</strong></br> I dispositivi di archiviazione file e blocchi sono specifici per una zona e non possono essere condivisi tra zone o regioni. Per utilizzare questo tipo di archiviazione in un cluster, devi disporre di almeno un nodo di lavoro nella stessa zona della tua archiviazione. </br></br>Se [esegui dinamicamente il provisioning](cs_storage_basics.html#dynamic_provisioning) dell'archiviazione file e blocchi in un cluster che si estende a più zone, il provisioning dell'archiviazione viene eseguito solo in una (1) zona selezionata su una base round-robin. Per eseguire il provisioning dell'archiviazione persistente in tutte le zone del tuo cluster multizona, ripeti la procedura per eseguire il provisioning dell'archiviazione dinamica per ogni zona. Ad esempio, se il tuo cluster si estende alle zone `dal10`, `dal12` e `dal13`, la prima volta che esegui dinamicamente il provisioning dell'archiviazione persistente potresti eseguire il provisioning dell'archiviazione in `dal10`. Crea altri due PVC per coprire `dal12` e `dal13`. </br></br><strong>Cosa devo fare se voglio condividere i dati tra le zone?</strong></br>Se vuoi condividere i dati tra le zone, utilizza un servizio database cloud, come [{{site.data.keyword.cloudant_short_notm}}](/docs/services/Cloudant/getting-started.html#getting-started-with-cloudant) oppure [{{site.data.keyword.cos_full_notm}}](/docs/services/cloud-object-storage/about-cos.html#about-ibm-cloud-object-storage). </td>
  </tr>
  <tr id="cloud-db-service">
    <td>2. Servizio database cloud</td>
    <td>Con questa opzione, puoi conservare i dati utilizzando un servizio database {{site.data.keyword.Bluemix_notm}},
come [IBM Cloudant NoSQL DB](/docs/services/Cloudant/getting-started.html#getting-started-with-cloudant). </br></br><strong>Come utilizzo un servizio database cloud per il mio cluster multizona?</strong></br>Con un servizio database cloud, i dati vengono archiviati esternamente al cluster nell'istanza del servizio specificata. Il provisioning dell'istanza del servizio viene eseguito in una singola zona. Tuttavia, ogni istanza del servizio viene fornita con un'interfaccia esterna che puoi utilizzare per accedere ai tuoi dati. Quando utilizzi un servizio database per un cluster multizona, puoi condividere i dati tra i cluster, le zone e le regioni. Per rendere la tua istanza del servizio più disponibile, puoi scegliere di configurare più istanze tra le zone e la replica tra le istanze per una maggiore disponibilità. </br></br><strong>Come posso aggiungere un servizio database cloud al mio cluster?</strong></br>Per utilizzare un servizio nel tuo cluster, devi [associare il servizio {{site.data.keyword.Bluemix_notm}}](cs_integrations.html#adding_app) a uno spazio dei nomi nel tuo cluster. Quando associ il servizio al cluster, viene creato un segreto Kubernetes. Il segreto Kubernetes ospita informazioni confidenziali sul servizio,
come ad esempio l'URL del servizio, i tuoi nome utente e password. Puoi montare il segreto
come un volume segreto nel tuo pod e accedere al servizio utilizzando le credenziali nel segreto. Montando il volume segreto in altri pod, puoi inoltre condividere i dati tra i pod. Quando un
contenitore ha un arresto anomalo o viene rimosso un pod da un nodo di lavoro, i dati non vengono rimossi ed è ancora possibile accedervi
da altri pod che montano il volume segreto. </br></br>Alcuni servizi database {{site.data.keyword.Bluemix_notm}} forniscono spazio su disco
per una piccola quantità di dati gratuitamente, in questo modo puoi verificarne le funzioni.</p></td>
  </tr>
  <tr>
    <td>3. Database in loco</td>
    <td>Se i tuoi dati devono essere archiviati in loco per motivi legali, puoi [configurare una connessione VPN](cs_vpn.html#vpn) nel tuo database in loco e utilizzare l'archiviazione esistente, i meccanismi di backup e ripristino nel tuo data center.</td>
  </tr>
  </tbody>
  </table>

{: caption="Tabella. Opzioni di archiviazione dati persistente per le distribuzioni nei cluster Kubernetes" caption-side="top"}
