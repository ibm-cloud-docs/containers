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




# Argomenti popolari di {{site.data.keyword.containerlong_notm}}
{: #cs_popular_topics}

Resta al passo con cosa succede in {{site.data.keyword.containerlong}}. Ulteriori informazioni sulle nuove funzioni da esplorare, su un suggerimento per la sperimentazione o su alcuni argomenti popolari che gli altri sviluppatori stanno trovando utili al momento.
{:shortdesc}

## Argomenti popolari nell'ottobre 2018
{: #oct18}

<table summary="La tabella mostra gli argomenti popolari. Le righe devono essere lette da sinistra a destra, con la data nella colonna uno, il titolo della funzione nella colonna due e una descrizione nella colonna tre.">
<caption>Argomenti popolari per i contenitori e i cluster Kubernetes ad agosto 2018</caption>
<thead>
<th>Data</th>
<th>Titolo</th>
<th>Descrizione</th>
</thead>
<tbody>
<tr>
<td>25 ottobre</td>
<td>[Zona disponibile a Milano](cs_regions.html)</td>
<td>Benvenuta Milano, Italia come nuova zona per i cluster a pagamento nella regione Europa Centrale. Precedentemente, Milano era disponibile solo per i cluster gratuiti. Se hai un firewall, assicurati di [aprire le porte del firewall](cs_firewall.html#firewall) per questa e le altre zone all'interno della regione in cui si trova il tuo cluster.</td>
</tr>
<tr>
<td>22 ottobre</td>
<td>[Nuova ubicazione multizona di Londra, `lon05`](cs_regions.html#zones)</td>
<td>La città metropolitana multizona di Londra sostituisce la zona `lon02` con la nuova zona `lon05`, in cui sono disponibili più risorse di infrastruttura rispetto a `lon02`. Crea nuovi cluster multizona con `lon05`. I cluster esistenti con `lon02` sono supportati, ma i nuovi cluster multizona devono utilizzare invece `lon05`.</td>
</tr>
<tr>
<td>05 ottobre</td>
<td>Integrazione con {{site.data.keyword.keymanagementservicefull}}</td>
<td>Puoi crittografare i segreti Kubernetes presenti nel tuo cluster [abilitando {{site.data.keyword.keymanagementserviceshort}} (beta)](cs_encrypt.html#keyprotect).</td>
</tr>
<tr>
<td>04 ottobre</td>
<td>[{{site.data.keyword.registrylong}} è ora integrato con {{site.data.keyword.Bluemix_notm}} IAM (Identity and Access Management)](/docs/services/Registry/iam.html#iam)</td>
<td>Puoi utilizzare IAM per controllare l'accesso alle tue risorse del registro, come l'estrazione, l'inserimento e la creazione di immagini. Quando crei un cluster, crei anche un token del registro in modo che il cluster possa lavorare con il tuo registro. Pertanto, hai bisogno del ruolo di gestione della piattaforma **Amministratore** del registro per creare un cluster. Per abilitare IAM per il tuo account del registro, vedi [Abilitazione dell'applicazione delle politiche per gli utenti esistenti](/docs/services/Registry/registry_users.html#existing_users).</td>
</tr>
<tr>
<td>01 ottobre</td>
<td>[Gruppi di risorse](cs_users.html#resource_groups)</td>
<td>Puoi utilizzare i gruppi di risorse per separare le tue risorse {{site.data.keyword.Bluemix_notm}} in pipeline, dipartimenti o altri raggruppamenti per aiutare ad assegnare l'accesso e misurare l'utilizzo. Adesso, {{site.data.keyword.containerlong_notm}} supporta la creazione di cluster nel gruppo `predefinito` o in un qualsiasi altro gruppo di risorse che crei.</td>
</tr>
</tbody></table>

## Argomenti popolari a settembre 2018
{: #sept18}

<table summary="La tabella mostra gli argomenti popolari. Le righe devono essere lette da sinistra a destra, con la data nella colonna uno, il titolo della funzione nella colonna due e una descrizione nella colonna tre.">
<caption>Argomenti popolari per i contenitori e i cluster Kubernetes ad agosto 2018</caption>
<thead>
<th>Data</th>
<th>Titolo</th>
<th>Descrizione</th>
</thead>
<tbody>
<tr>
<td>25 settembre</td>
<td>[Nuove zone disponibili](cs_regions.html)</td>
<td>Ora hai ancora più opzioni su dove distribuire le tue applicazioni!
<ul><li>Benvenuta San Jose come due nuove zone nella regione Stati Uniti Sud, `sjc03` e `sjc04`. Se hai un firewall, assicurati di [aprire le porte del firewall](cs_firewall.html#firewall) per questa zona e le altre all'interno della regione in cui si trova il tuo cluster.</li>
<li>Con le due nuove zone `tok04` e `tok05`, puoi ora [creare cluster multizona](cs_clusters_planning.html#multizone) a Tokyo nella regione Asia Pacifico Nord.</li></ul></td>
</tr>
<tr>
<td>05 settembre</td>
<td>[Zona disponibile a Oslo](cs_regions.html)</td>
<td>Benvenuta Oslo, Norvegia come nuova zona nella regione Europa Centrale. Se hai un firewall, assicurati di [aprire le porte del firewall](cs_firewall.html#firewall) per questa zona e le altre all'interno della regione in cui si trova il tuo cluster.</td>
</tr>
</tbody></table>

## Argomenti popolari ad agosto 2018
{: #aug18}

<table summary="La tabella mostra gli argomenti popolari. Le righe devono essere lette da sinistra a destra, con la data nella colonna uno, il titolo della funzione nella colonna due e una descrizione nella colonna tre.">
<caption>Argomenti popolari per i contenitori e i cluster Kubernetes ad agosto 2018</caption>
<thead>
<th>Data</th>
<th>Titolo</th>
<th>Descrizione</th>
</thead>
<tbody>
<tr>
<td>31 agosto</td>
<td>{{site.data.keyword.cos_full_notm}} è ora integrato con {{site.data.keyword.containerlong}}</td>
<td>Utilizza le attestazioni del volume persistente (o PVC, persistent volume claim) native di Kubernetes per eseguire il provisioning di {{site.data.keyword.cos_full_notm}} al tuo cluster. L'impiego ottimale di {{site.data.keyword.cos_full_notm}} è per i carichi di lavoro ad alta intensità di lettura e se si desidera archiviare i dati in più zone in un cluster multizona. Inizia [creando una istanza del servizio {{site.data.keyword.cos_full_notm}}](cs_storage_cos.html#create_cos_service) e [installando il plug-in {{site.data.keyword.cos_full_notm}}](cs_storage_cos.html#install_cos) sul tuo cluster. </br></br>Non sei sicuro di quale soluzione di archiviazione potrebbe essere quella giusta per te? Inizia [qui](cs_storage_planning.html#choose_storage_solution) per analizzare i tuoi dati e scegliere la soluzione di archiviazione appropriata per i tuoi dati. </td>
</tr>
<tr>
<td>14 agosto</td>
<td>Aggiorna i tuoi cluster a Kubernetes versione 1.11 per assegnare la priorità dei pod</td>
<td>Dopo che hai aggiornato il tuo cluster a [Kubernetes versione 1.11](cs_versions.html#cs_v111), puoi avvalerti di nuove funzionalità, come ad esempio delle prestazioni del runtime del contenitore aumentate con `containerd` oppure l'[assegnazione della priorità dei pod](cs_pod_priority.html#pod_priority).</td>
</tr>
</tbody></table>

## Argomenti popolari nel luglio 2018
{: #july18}

<table summary="La tabella mostra gli argomenti popolari. Le righe devono essere lette da sinistra a destra, con la data nella colonna uno, il titolo della funzione nella colonna due e una descrizione nella colonna tre.">
<caption>Argomenti popolari per i contenitori e i cluster Kubernetes nel luglio 2018</caption>
<thead>
<th>Data</th>
<th>Titolo</th>
<th>Descrizione</th>
</thead>
<tbody>
<tr>
<td>30 luglio</td>
<td>[Usa il tuo controller Ingress](cs_ingress.html#user_managed)</td>
<td>Hai requisiti di sicurezza particolarmente specifici o altri requisiti personalizzati per il controller Ingress del tuo cluster? Se sì, potresti voler eseguire il tuo controller Ingress invece di quello predefinito.</td>
</tr>
<tr>
<td>10 luglio</td>
<td>Introduzione dei cluster multizona</td>
<td>Vuoi migliorare la disponibilità del cluster? Ora puoi estendere il tuo cluster tra più zone in aree metropolitane selezionate. Per ulteriori informazioni, vedi [Creazione di cluster multizona in {{site.data.keyword.containerlong_notm}}](cs_clusters_planning.html#multizone).</td>
</tr>
</tbody></table>

## Argomenti popolari nel giugno 2018
{: #june18}

<table summary="La tabella mostra gli argomenti popolari. Le righe devono essere lette da sinistra a destra, con la data nella colonna uno, il titolo della funzione nella colonna due e una descrizione nella colonna tre.">
<caption>Argomenti popolari per i contenitori e i cluster Kubernetes nel giugno 2018</caption>
<thead>
<th>Data</th>
<th>Titolo</th>
<th>Descrizione</th>
</thead>
<tbody>
<tr>
<td>13 giugno</td>
<td>Il nome del comando CLI `bx` è stato modificato nel comando CLI `ic`</td>
<td>Quando scarichi la versione più recente della CLI di {{site.data.keyword.Bluemix_notm}}, esegui i comandi utilizzando il prefisso `ic` invece di `bx`. Ad esempio, elenca i tuoi cluster eseguendo `ibmcloud ks clusters`.</td>
</tr>
<tr>
<td>12 giugno</td>
<td>[Politiche di sicurezza del pod](cs_psp.html)</td>
<td>Per i cluster su cui è in esecuzione Kubernetes 1.10.3 o successive, puoi configurare le politiche di sicurezza del
pod per autorizzare chi può creare e aggiornare i pod in {{site.data.keyword.containerlong_notm}}.</td>
</tr>
<tr>
<td>06 giugno</td>
<td>[Supporto TLS per il dominio secondario jolly Ingress fornito da IBM](cs_ingress.html#wildcard_tls)</td>
<td>Per i cluster creati dopo il 6 giugno 2018, il certificato TLS del dominio secondario jolly Ingress fornito da IBM è ora un certificato jolly e può essere usato per il dominio secondario jolly registrato. Per i cluster creati prima del 6 giugno 2018, il certificato TLS verrà aggiornato a un certificato jolly quando verrà rinnovato il certificato TLS corrente.</td>
</tr>
</tbody></table>

## Argomenti popolari nel maggio 2018
{: #may18}


<table summary="La tabella mostra gli argomenti popolari. Le righe devono essere lette da sinistra a destra, con la data nella colonna uno, il titolo della funzione nella colonna due e una descrizione nella colonna tre.">
<caption>Argomenti popolari per i contenitori e i cluster Kubernetes nel maggio 2018</caption>
<thead>
<th>Data</th>
<th>Titolo</th>
<th>Descrizione</th>
</thead>
<tbody>
<tr>
<td>24 maggio</td>
<td>[Nuovo formato del dominio secondario Ingress](cs_ingress.html)</td>
<td>I cluster creati dopo il 24 maggio vengono assegnati a un dominio secondario Ingress in un nuovo formato: <code>&lt;cluster_name&gt;.&lt;region&gt;.containers.appdomain.cloud</code>. Quando utilizzi Ingress per esporre le tue applicazioni, puoi utilizzare il nuovo dominio secondario per accedere alle tue applicazioni da Internet.</td>
</tr>
<tr>
<td>14 maggio</td>
<td>[Aggiornamento: distribuisci i carichi di lavoro nel bare metal GPU nel mondo](cs_app.html#gpu_app)</td>
<td>Se hai un [tipo di macchina GPU (graphics processing unit) bare metal](cs_clusters_planning.html#shared_dedicated_node) nel tuo cluster, puoi pianificare le applicazioni intensive in modo matematico. Il nodo di lavoro GPU può elaborare il carico di lavoro della tua applicazione tramite la CPU e la GPU per aumentare le prestazioni.</td>
</tr>
<tr>
<td>03 maggio</td>
<td>[Container Image Security Enforcement (beta)](/docs/services/Registry/registry_security_enforce.html#security_enforce)</td>
<td>Il tuo team ha bisogno di un piccolo ulteriore aiuto per sapere quale immagine trasmettere nei tuoi contenitori dell'applicazione? Prova Container Image Security Enforcement beta per verificare le immagini del contenitore prima di distribuirle. Disponibile per i cluster che eseguono Kubernetes 1.9 o successive.</td>
</tr>
<tr>
<td>01 maggio</td>
<td>[Distribuisci il dashboard Kubernetes dalla GUI](cs_app.html#cli_dashboard)</td>
<td>Hai mai voluto accedere al dashboard Kubernetes con un clic? Controlla il pulsante **Dashboard Kubernetes** nella GUI {{site.data.keyword.Bluemix_notm}}.</td>
</tr>
</tbody></table>




## Argomenti popolari nell'aprile 2018
{: #apr18}

<table summary="La tabella mostra gli argomenti popolari. Le righe devono essere lette da sinistra a destra, con la data nella colonna uno, il titolo della funzione nella colonna due e una descrizione nella colonna tre.">
<caption>Argomenti popolari per i contenitori e i cluster Kubernetes  nell'aprile 2018</caption>
<thead>
<th>Data</th>
<th>Titolo</th>
<th>Descrizione</th>
</thead>
<tbody>
<tr>
<td>17 aprile</td>
<td>{{site.data.keyword.Bluemix_notm}} Block Storage</td>
<td>Installa il [plugin](cs_storage_block.html#install_block) di {{site.data.keyword.Bluemix_notm}} Block Storage per salvare i dati persistenti nell'archiviazione blocchi. Quindi puoi [creare una nuova](cs_storage_block.html#add_block) archiviazione blocchi o [utilizzarne una esistente](cs_storage_block.html#existing_block) per il tuo cluster.</td>
</tr>
<tr>
<td>13 aprile</td>
<td>[Nuova esercitazione per la migrazione delle applicazioni Cloud Foundry nei cluster](cs_tutorials_cf.html#cf_tutorial)</td>
<td>Hai un'applicazione Cloud Foundry? Impara a distribuire lo stesso codice proveniente da tale applicazione ad un'applicazione che viene eseguita in un cluster Kubernetes.</td>
</tr>
<tr>
<td>05 aprile</td>
<td>[Filtraggio dei log](cs_health.html#filter-logs)</td>
<td>Filtra specifici log per impedire che vengano inoltrati. I log possono essere filtrati per uno specifico spazio dei nomi, nome contenitore, livello di log e stringa di messaggio.</td>
</tr>
</tbody></table>

## Argomenti popolari nel marzo 2018
{: #mar18}

<table summary="La tabella mostra gli argomenti popolari. Le righe devono essere lette da sinistra a destra, con la data nella colonna uno, il titolo della funzione nella colonna due e una descrizione nella colonna tre.">
<caption>Argomenti popolari per i contenitori e i cluster Kubernetes nel marzo 2018</caption>
<thead>
<th>Data</th>
<th>Titolo</th>
<th>Descrizione</th>
</thead>
<tbody>
<tr>
<td>16 marzo</td>
<td>[Provisioning di un cluster bare metal con Trusted Compute](cs_clusters_planning.html#shared_dedicated_node)</td>
<td>Crea un cluster bare metal che esegue [Kubernetes versione 1.9](cs_versions.html#cs_v19) o successive e abilita Trusted Compute per verificare possibili tentativi di intrusione nei tuoi nodi di lavoro.</td>
</tr>
<tr>
<td>14 marzo</td>
<td>[Accesso sicuro con {{site.data.keyword.appid_full}}](cs_integrations.html#appid)</td>
<td>Migliora le tue applicazioni in esecuzione in {{site.data.keyword.containerlong_notm}} richiedendo agli utenti di effettuare l'accesso.</td>
</tr>
<tr>
<td>13 marzo</td>
<td>[Zona disponibile a San Paolo](cs_regions.html)</td>
<td>San Paolo, in Brasile, è una nuova zona nella regione Stati Uniti Sud. Se hai un firewall, assicurati di [aprire le porte del firewall](cs_firewall.html#firewall) per questa zona e le altre all'interno della regione in cui si trova il tuo cluster.</td>
</tr>
<tr>
<td>12 marzo</td>
<td>[Ti sei appena registrato a {{site.data.keyword.Bluemix_notm}} con un account di prova? Prova un cluster Kubernetes gratuito!](container_index.html#clusters)</td>
<td>Con un [account {{site.data.keyword.Bluemix_notm}}](https://console.bluemix.net/registration/) di prova, puoi distribuire un cluster gratuito per 30 giorni per verificare le funzionalità di Kubernetes.</td>
</tr>
</tbody></table>

## Argomenti popolari nel febbraio 2018
{: #feb18}

<table summary="La tabella mostra gli argomenti popolari. Le righe devono essere lette da sinistra a destra, con la data nella colonna uno, il titolo della funzione nella colonna due e una descrizione nella colonna tre.">
<caption>Argomenti popolari per i contenitori e i cluster Kubernetes nel febbraio 2018</caption>
<thead>
<th>Data</th>
<th>Titolo</th>
<th>Descrizione</th>
</thead>
<tbody>
<tr>
<td>27 febbraio</td>
<td>Immagini HVM (hardware virtual machine) per i nodi di lavoro</td>
<td>Aumenta le prestazioni I/O dei tuoi carichi di lavoro con le immagini HVM. Attivale su ogni nodo di lavoro esistente utilizzando il [comando](cs_cli_reference.html#cs_worker_reload) `ibmcloud ks worker-reload` o il [comando](cs_cli_reference.html#cs_worker_update) `ibmcloud ks worker-update`.</td>
</tr>
<tr>
<td>26 febbraio</td>
<td>[Ridimensionamento automatico di KubeDNS](https://kubernetes.io/docs/tasks/administer-cluster/dns-horizontal-autoscaling/)</td>
<td>KubeDNS adesso si ridimensiona con l'espandersi del tuo cluster. Puoi regolare le razioni di ridimensionamento utilizzando il seguente comando: `kubectl -n kube-system edit cm kube-dns-autoscaler`.</td>
</tr>
<tr>
<td>23 febbraio</td>
<td>Visualizza l'IU web per la [registrazione](cs_health.html#view_logs) e le [metriche](cs_health.html#view_metrics)</td>
<td>Visualizza facilmente dati di log e metriche sul tuo cluster e i suoi componenti con un'IU web migliorata. Per l'accesso, vedi la pagina dei dettagli del tuo cluster.</td>
</tr>
<tr>
<td>20 febbraio</td>
<td>Immagini crittografate e [contenuti firmati e attendibili](../services/Registry/registry_trusted_content.html#registry_trustedcontent)</td>
<td>In {{site.data.keyword.registryshort_notm}}, puoi firmare e crittografare le immagini per garantirne l'integrità durante la memorizzazione nello spazio dei nomi del tuo registro. Esegui le tue istanze del contenitore utilizzando solo contenuti attendibili.</td>
</tr>
<tr>
<td>19 febbraio</td>
<td>[Configura la VPN IPSec strongSwan](cs_vpn.html#vpn-setup)</td>
<td>Distribuisci rapidamente il grafico Helm della VPN IPSec strongSwan per connettere in modo sicuro il cluster {{site.data.keyword.containerlong_notm}} al tuo data center in loco senza una VRA (Virtual Router Appliance).</td>
</tr>
<tr>
<td>14 febbraio</td>
<td>[Zona disponibile a Seoul](cs_regions.html)</td>
<td>Giusto in tempo per le Olimpiadi, distribuisci un cluster Kubernetes a Seoul nella regione Asia Pacifico Nord. Se hai un firewall, assicurati di [aprire le porte del firewall](cs_firewall.html#firewall) per questa zona e le altre all'interno della regione in cui si trova il tuo cluster.</td>
</tr>
<tr>
<td>08 febbraio</td>
<td>[Aggiorna Kubernetes 1.9](cs_versions.html#cs_v19)</td>
<td>Rivedi le modifiche da apportare ai tuoi cluster prima di aggiornare a Kubernetes 1.9.</td>
</tr>
</tbody></table>

## Argomenti popolari nel gennaio 2018
{: #jan18}

<table summary="La tabella mostra gli argomenti popolari. Le righe devono essere lette da sinistra a destra, con la data nella colonna uno, il titolo della funzione nella colonna due e una descrizione nella colonna tre.">
<caption>Argomenti popolari per i contenitori e i cluster Kubernetes nel gennaio 2018</caption>
<thead>
<th>Data</th>
<th>Titolo</th>
<th>Descrizione</th>
</thead>
<tbody>
<td>25 gennaio</td>
<td>[Registro globale disponibile](../services/Registry/registry_overview.html#registry_regions)</td>
<td>Con il {{site.data.keyword.registryshort_notm}}, puoi utilizzare il registro globale `registry.bluemix.net` per estrarre le immagini pubbliche fornite da IBM.</td>
</tr>
<tr>
<td>23 gennaio</td>
<td>[Zone disponibili a Singapore e Montreal, CA](cs_regions.html)</td>
<td>Singapore e Montreal sono le zone disponibili nelle regioni Asia Pacifico Nord e Stati Uniti Est di {{site.data.keyword.containerlong_notm}}. Se hai un firewall, assicurati di [aprire le porte del firewall](cs_firewall.html#firewall) per queste zone e le altre all'interno della regione in cui si trova il tuo cluster.</td>
</tr>
<tr>
<td>08 gennaio</td>
<td>[Disponibili varietà avanzate](cs_cli_reference.html#cs_machine_types)</td>
<td>I tipi di macchine virtuali della serie 2 includono l'archiviazione SSD locale e la crittografia del disco. [Sposta i tuoi carichi di lavoro](cs_cluster_update.html#machine_type) a queste varietà per migliorare prestazioni e stabilità.</td>
</tr>
</tbody></table>

## Utilizza la chat per parlare con sviluppatori con interessi simili su Slack
{: #slack}

Puoi vedere di cosa parlano gli altri utenti e porre le tue domande in [{{site.data.keyword.containerlong_notm}} Slack. ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://ibm-container-service.slack.com)
{:shortdesc}

Se non stai utilizzando un ID IBM per il tuo account {{site.data.keyword.Bluemix_notm}}, [richiedi un invito](https://bxcs-slack-invite.mybluemix.net/) a questo Slack.
{: tip}
