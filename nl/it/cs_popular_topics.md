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


# Argomenti popolari di {{site.data.keyword.containershort_notm}}
{: #cs_popular_topics}

Scopri cosa vogliono conoscere gli sviluppatori di contenitori in merito a {{site.data.keyword.containerlong}}.
{:shortdesc}

## Argomenti popolari nel marzo 2018
{: #mar18}

<table summary="La tabella mostra gli argomenti popolari. Le righe devono essere lette da sinistra a destra, con la data nella colonna uno, il titolo della funzione nella colonna due e una descrizione nella colonna tre.">
<caption>Argomenti popolari per i contenitori e i cluster Kubernetes nel febbraio 2018</caption>
<thead>
<th>Data</th>
<th>Titolo</th>
<th>Descrizione</th>
</thead>
<tbody>
<tr>
<td> 16 marzo</td>
<td>[Provisioning di un cluster bare metal con Trusted Compute](cs_clusters.html#shared_dedicated_node)</td>
<td>Crea un cluster bare metal che esegue [Kubernetes versione 1.9](cs_versions.html#cs_v19) o successiva e abilita Trusted Compute per verificare possibili tentativi di intrusione nei tuoi nodi di lavoro.</td>
</tr>
<tr>
<td>14 marzo</td>
<td>[Accesso sicuro con {{site.data.keyword.appid_full}}](cs_integrations.html#appid)</td>
<td>Migliora le tue applicazioni in esecuzione in {{site.data.keyword.containershort_notm}} richiedendo agli utenti di effettuare l'accesso.</td>
</tr>
<tr>
<td>13 marzo</td>
<td>[Ubicazione disponibile a San Paolo](cs_regions.html)</td>
<td>San Paolo, in Brasile, è la nuova ubicazione nella regione Stati Uniti Sud. Se hai un firewall, assicurati di [aprire le porte del firewall richieste](cs_firewall.html#firewall) per questa ubicazione e le altre all'interno della regione in cui si trova il tuo cluster.</td>
</tr>
<tr>
<td>12 marzo</td>
<td>[Ti sei appena registrato a {{site.data.keyword.Bluemix_notm}} con un account di prova? Prova un cluster Kubernetes gratuito!](container_index.html#clusters)</td>
<td>Con un [account {{site.data.keyword.Bluemix_notm}}](https://console.bluemix.net/registration/) di prova, puoi distribuire 1 cluster gratuito per 21 giorni per testare le funzionalità di Kubernetes.</td>
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
<td>Aumenta le prestazioni I/O dei tuoi carichi di lavoro con le immagini HVM. Attivale su ogni nodo di lavoro esistente utilizzando il [comando](cs_cli_reference.html#cs_worker_reload) `bx cs worker-reload` o il [comando](cs_cli_reference.html#cs_worker_update) `bx cs worker-update`.</td>
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
<td>In {{site.data.keyword.registryshort_notm}}, puoi firmare e crittografare le immagini per garantirne l'integrità durante la memorizzazione nello spazio dei nomi del tuo registro. Crea i contenitori utilizzando solo contenuti attendibili.</td>
</tr>
<tr>
<td>19 febbraio</td>
<td>[Configura la VPN IPSec strongSwan](cs_vpn.html#vpn-setup)</td>
<td>Distribuisci rapidamente il grafico Helm della VPN IPSec strongSwan per connettere in modo sicuro il cluster {{site.data.keyword.containershort_notm}} al tuo data center in loco senza Vyatta.</td>
</tr>
<tr>
<td>14 febbraio</td>
<td>[Ubicazione disponibile a Seoul](cs_regions.html)</td>
<td>Giusto in tempo per le Olimpiadi, distribuisci un cluster Kubernetes a Seoul nella regione Asia Pacifico Nord. Se hai un firewall, assicurati di [aprire le porte del firewall richieste](cs_firewall.html#firewall) per questa ubicazione e le altre all'interno della regione in cui si trova il tuo cluster.</td>
</tr>
<tr>
<td>8 febbraio</td>
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
<td>[Ubicazioni disponibili a Singapore e Montreal, CA](cs_regions.html)</td>
<td>Singapore e Montreal sono le ubicazioni disponibili nelle regioni Asia Pacifico Nord e Stati Uniti Est di {{site.data.keyword.containershort_notm}}. Se hai un firewall, assicurati di [aprire le porte del firewall richieste](cs_firewall.html#firewall) per queste ubicazioni e le altre all'interno della regione in cui si trova il tuo cluster.</td>
</tr>
<tr>
<td>8 gennaio</td>
<td>[Tipi di macchine migliorate disponibili](cs_cli_reference.html#cs_machine_types)</td>
<td>I tipi di macchine della serie 2 includono l'archiviazione SSD locale e la crittografia del disco. [Migra i tuoi carichi di lavoro](cs_cluster_update.html#machine_type) a questi tipi di macchine per migliorare prestazioni e stabilità.</td>
</tr>
</tbody></table>

## Utilizza la chat per parlare con sviluppatori con interessi simili su Slack
{: #slack}

Puoi vedere di cosa parlano gli altri utenti e porre le tue domande in [{{site.data.keyword.containershort_notm}} Slack. ![External link icon](../icons/launch-glyph.svg "External link icon")](https://ibm-container-service.slack.com)
{:shortdesc}

Suggerimento: se non stai utilizzando un ID IBM per il tuo account {{site.data.keyword.Bluemix_notm}}, [richiedi un invito](https://bxcs-slack-invite.mybluemix.net/) a questo slack.
