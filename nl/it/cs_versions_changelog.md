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



# Changelog versione
{: #changelog}

Visualizza le informazioni sulle modifiche alla versione per gli aggiornamenti principali, secondari e patch disponibili per i tuoi cluster Kubernetes {{site.data.keyword.containerlong}}. Le modifiche includono gli aggiornamenti ai componenti Kubernetes e {{site.data.keyword.Bluemix_notm}} Provider.
{:shortdesc}

IBM applica automaticamente gli aggiornamenti a livello di patch al tuo master, ma devi [aggiornare la patch dei tuoi nodi di lavoro](cs_cluster_update.html#worker_node). Sia per i nodi master che per i nodi di lavoro, devi applicare gli aggiornamenti [principali e secondari](cs_versions.html#update_types) . Controlla mensilmente gli aggiornamenti. Quando gli aggiornamenti diventano disponibili, ricevi una notifica quando visualizzi informazioni sui nodi master e di lavoro nella GUI o nella CLI, ad esempio con i seguenti comandi: `ibmcloud ks clusters`, `cluster-get`, `workers` o `worker-get`.

Per un riepilogo delle azioni di migrazione, vedi [Versioni Kubernetes](cs_versions.html).
{: tip}

Per informazioni sulle modifiche dalla versione precedente, vedi i seguenti changelog.
-  [Changelog](#110_changelog) Versione 1.10.
-  [Changelog](#19_changelog) Versione 1.9.
-  [Changelog](#18_changelog) Versione 1.8.
-  [Archivio](#changelog_archive) dei changelog per le versioni obsolete o non supportate.

## Changelog Versione 1.10
{: #110_changelog}

Esamina le seguenti modifiche.

### Changelog per 1.10.5_1517, rilasciato il 27 luglio 2018
{: #1105_1517}

<table summary="Modifiche apportate a partire dalla versione 1.10.3_1514">
<caption>Modifiche a partire dalla versione 1.10.3_1514</caption>
<thead>
<tr>
<th>Componente</th>
<th>Precedente</th>
<th>Corrente</th>
<th>Descrizione</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>v3.1.1</td>
<td>v3.1.3</td>
<td>Consulta le [note sulla release Calico ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://docs.projectcalico.org/v3.1/releases/#v313).</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.10.3-85</td>
<td>v1.10.5-118</td>
<td>Aggiornato per supportare la release Kubernetes 1.10.5. Inoltre, gli eventi `create failure` del servizio LoadBalancer ora includono qualsiasi errore di sottorete portatile.</td>
</tr>
<tr>
<td>Plug-in di archiviazione file IBM</td>
<td>320</td>
<td>334</td>
<td>Il timeout per la creazione di volumi persistenti è stato aumentato da 15 a 30 minuti. Il tipo di fatturazione predefinito è stato modificato in oraria (`hourly`). Sono state aggiunte delle opzioni di montaggio alle classi di archiviazione predefinite. Nell'istanza di archiviazione file NFS nel tuo account dell'infrastruttura IBM Cloud (SoftLayer), il campo **Note** è stato modificato in formato JSON ed è stato aggiunto lo spazio dei nomi Kubernetes a cui viene distribuito il PV. Per supportare i cluster multizona, sono state aggiunte le etichette di zona e regione ai volumi persistenti.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.10.3</td>
<td>v1.10.5</td>
<td>Vedi le [note sulla release Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.5).</td>
</tr>
<tr>
<td>Kernel</td>
<td>N/D</td>
<td>N/D</td>
<td>Miglioramenti secondari alle impostazioni di rete dei nodi di lavoro per i carichi di lavoro di rete ad elevate prestazioni.</td>
</tr>
<tr>
<td>CLient OpenVPN</td>
<td>N/D</td>
<td>N/D</td>
<td>La distribuzione del client OpenVPN `vpn` che viene eseguita nello spazio dei nomi `kube-system` è ora gestita dall'`addon-manager` Kubernetes.</td>
</tr>
</tbody>
</table>

### Changelog per il fix pack di nodo di lavoro 1.10.3_1514, rilasciato il 3 luglio 2018
{: #1103_1514}

<table summary="Modifiche apportate a partire dalla versione 1.10.3_1513">
<caption>Modifiche a partire dalla versione 1.10.3_1513</caption>
<thead>
<tr>
<th>Componente</th>
<th>Precedente</th>
<th>Corrente</th>
<th>Descrizione</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>N/D</td>
<td>N/D</td>
<td>`sysctl` ottimizzato per i carichi di lavoro di rete ad elevate prestazioni.</td>
</tr>
</tbody>
</table>


### Changelog per il fix pack di nodo di lavoro 1.10.3_1513, rilasciato il 21 giugno 2018
{: #1103_1513}

<table summary="Modifiche apportate a partire dalla versione 1.10.3_1512">
<caption>Modifiche a partire dalla versione 1.10.3_1512</caption>
<thead>
<tr>
<th>Componente</th>
<th>Precedente</th>
<th>Corrente</th>
<th>Descrizione</th>
</tr>
</thead>
<tbody>
<tr>
<td>Docker</td>
<td>N/D</td>
<td>N/D</td>
<td>Per i tipi di macchina non crittografati, il disco secondario viene ripulito ottenendo un file system nuovo quando ricarichi o aggiorni il nodo di lavoro.</td>
</tr>
</tbody>
</table>

### Changelog per 1.10.3_1512, rilasciato il 12 giugno 2018
{: #1103_1512}

<table summary="Modifiche apportate a partire dalla versione 1.10.1_1510">
<caption>Modifiche a partire dalla versione 1.10.1_1510</caption>
<thead>
<tr>
<th>Componente</th>
<th>Precedente</th>
<th>Corrente</th>
<th>Descrizione</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>v1.10.1</td>
<td>v1.10.3</td>
<td>Vedi le [note sulla release Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.3).</td>
</tr>
<tr>
<td>Configurazione Kubernetes</td>
<td>N/D</td>
<td>N/D</td>
<td>È stata aggiunta `PodSecurityPolicy` all'opzione `--enable-admission-plugins` per il server API Kubernetes del cluster ed è stato configurato il cluster per supportare le politiche di sicurezza del pod. Per ulteriori informazioni, vedi [Configurazione delle politiche di sicurezza del pod](cs_psp.html).</td>
</tr>
<tr>
<td>Configurazione di kubelet</td>
<td>N/D</td>
<td>N/D</td>
<td>È stata abilitata l'opzione `--authentication-token-webhook` per supportare i token di account di servizio e di connessione API per l'autenticazione presso l'endpoint HTTPS `kubelet`.</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.10.1-52</td>
<td>v1.10.3-85</td>
<td>Aggiornato per supportare la release Kubernetes 1.10.3. </td>
</tr>
<tr>
<td>CLient OpenVPN</td>
<td>N/D</td>
<td>N/D</td>
<td>È stato aggiunto `livenessProbe` alla distribuzione `vpn` del client OpenVPN che viene eseguita nello spazio dei nomi `kube-system`.</td>
</tr>
<tr>
<td>Aggiornamento kernel</td>
<td>4.4.0-116</td>
<td>4.4.0-127</td>
<td>Nuove immagini di nodo di lavoro con l'aggiornamento kernel per [CVE-2018-3639 ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-3639).</td>
</tr>
</tbody>
</table>



### Changelog per il fix pack di nodo di lavoro 1.10.1_1510, rilasciato il 18 maggio 2018
{: #1101_1510}

<table summary="Modifiche apportate a partire dalla versione 1.10.1_1509">
<caption>Modifiche dalla versione 1.10.1_1509</caption>
<thead>
<tr>
<th>Componente</th>
<th>Precedente</th>
<th>Corrente</th>
<th>Descrizione</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>N/D</td>
<td>N/D</td>
<td>Correzione per risolvere un bug che si è verificato se hai utilizzato il plug-in dell'archiviazione blocchi.</td>
</tr>
</tbody>
</table>

### Changelog per il fix pack di nodo di lavoro 1.10.1_1509, rilasciato il 16 maggio 2018
{: #1101_1509}

<table summary="Modifiche apportate a partire dalla versione 1.10.1_1508">
<caption>Modifiche dalla versione 1.10.1_1508</caption>
<thead>
<tr>
<th>Componente</th>
<th>Precedente</th>
<th>Corrente</th>
<th>Descrizione</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>N/D</td>
<td>N/D</td>
<td>I dati che archivi nella directory root `kubelet` sono ora salvati nel disco secondario più grande della tua macchina del nodo di lavoro.</td>
</tr>
</tbody>
</table>

### Changelog per 1.10.1_1508, rilasciato il 01 maggio 2018
{: #1101_1508}

<table summary="Modifiche apportate a partire dalla versione 1.9.7_1510">
<caption>Modifiche dalla versione 1.9.7_1510</caption>
<thead>
<tr>
<th>Componente</th>
<th>Precedente</th>
<th>Corrente</th>
<th>Descrizione</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico</td>
<td>v2.6.5</td>
<td>v3.1.1</td>
<td>Consulta le [note sulla release Calico ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://docs.projectcalico.org/v3.1/releases/#v311).</td>
</tr>
<tr>
<td>Kubernetes Heapster</td>
<td>v1.5.0</td>
<td>v1.5.2</td>
<td>Vedi le [note sulla release Kubernetes Heapster ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/kubernetes/heapster/releases/tag/v1.5.2).</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.9.7</td>
<td>v1.10.1</td>
<td>Vedi le [note sulla release Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.1).</td>
</tr>
<tr>
<td>Configurazione Kubernetes</td>
<td>N/D</td>
<td>N/D</td>
<td>Aggiunto <code>StorageObjectInUseProtection</code> all'opzione <code>--enable-admission-plugins</code> del server dell'API Kubernetes del cluster.</td>
</tr>
<tr>
<td>DNS Kubernetes</td>
<td>1.14.8</td>
<td>1.14.10</td>
<td>Consulta le [note sulla release della DNS Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/kubernetes/dns/releases/tag/1.14.10).</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.9.7-102</td>
<td>v1.10.1-52</td>
<td>Aggiornato per supportare la release Kubernetes 1.10.</td>
</tr>
<tr>
<td>Supporto GPU</td>
<td>N/D</td>
<td>N/D</td>
<td>Il supporto per i [carichi di lavoro del contenitore GPU (graphics processing unit)](cs_app.html#gpu_app) è ora disponibile per la pianificazione e l'esecuzione. Per un elenco di tipi di macchina GPU disponibili, consulta [Hardware per i nodi di lavoro](cs_clusters.html#shared_dedicated_node). Per ulteriori informazioni, consulta la documentazione Kubernetes in [Schedule GPUs ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/tasks/manage-gpus/scheduling-gpus/).</td>
</tr>
</tbody>
</table>

## Changelog Versione 1.9
{: #19_changelog}

Esamina le seguenti modifiche.

### Changelog per 1.9.9_1520, rilasciato il 27 luglio 2018
{: #199_1520}

<table summary="Modifiche apportate a partire dalla versione 1.9.8_1517">
<caption>Modifiche a partire dalla versione 1.9.8_1517</caption>
<thead>
<tr>
<th>Componente</th>
<th>Precedente</th>
<th>Corrente</th>
<th>Descrizione</th>
</tr>
</thead>
<tbody>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.9.8-141</td>
<td>v1.9.9-167</td>
<td>Aggiornato per supportare la release Kubernetes 1.9.9. Inoltre, gli eventi `create failure` del servizio LoadBalancer ora includono qualsiasi errore di sottorete portatile.</td>
</tr>
<tr>
<td>Plug-in di archiviazione file IBM</td>
<td>320</td>
<td>334</td>
<td>Il timeout per la creazione di volumi persistenti è stato aumentato da 15 a 30 minuti. Il tipo di fatturazione predefinito è stato modificato in oraria (`hourly`). Sono state aggiunte delle opzioni di montaggio alle classi di archiviazione predefinite. Nell'istanza di archiviazione file NFS nel tuo account dell'infrastruttura IBM Cloud (SoftLayer), il campo **Note** è stato modificato in formato JSON ed è stato aggiunto lo spazio dei nomi Kubernetes a cui viene distribuito il PV. Per supportare i cluster multizona, sono state aggiunte le etichette di zona e regione ai volumi persistenti.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.9.8</td>
<td>v1.9.9</td>
<td>Vedi le [note sulla release Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/kubernetes/kubernetes/releases/tag/v1.9.9).</td>
</tr>
<tr>
<td>Kernel</td>
<td>N/D</td>
<td>N/D</td>
<td>Miglioramenti secondari alle impostazioni di rete dei nodi di lavoro per i carichi di lavoro di rete ad elevate prestazioni.</td>
</tr>
<tr>
<td>CLient OpenVPN</td>
<td>N/D</td>
<td>N/D</td>
<td>La distribuzione del client OpenVPN `vpn` che viene eseguita nello spazio dei nomi `kube-system` è ora gestita dall'`addon-manager` Kubernetes.</td>
</tr>
</tbody>
</table>

### Changelog per il fix pack di nodo di lavoro 1.9.8_1517, rilasciato il 3 luglio 2018
{: #198_1517}

<table summary="Modifiche apportate a partire dalla versione 1.9.8_1516">
<caption>Modifiche a partire dalla versione 1.9.8_1516</caption>
<thead>
<tr>
<th>Componente</th>
<th>Precedente</th>
<th>Corrente</th>
<th>Descrizione</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>N/D</td>
<td>N/D</td>
<td>`sysctl` ottimizzato per i carichi di lavoro di rete ad elevate prestazioni.</td>
</tr>
</tbody>
</table>


### Changelog per il fix pack di nodo di lavoro 1.9.8_1516, rilasciato il 21 giugno 2018
{: #198_1516}

<table summary="Modifiche apportate a partire dalla versione 1.9.8_1515">
<caption>Modifiche a partire dalla versione 1.9.8_1515</caption>
<thead>
<tr>
<th>Componente</th>
<th>Precedente</th>
<th>Corrente</th>
<th>Descrizione</th>
</tr>
</thead>
<tbody>
<tr>
<td>Docker</td>
<td>N/D</td>
<td>N/D</td>
<td>Per i tipi di macchina non crittografati, il disco secondario viene ripulito ottenendo un file system nuovo quando ricarichi o aggiorni il nodo di lavoro.</td>
</tr>
</tbody>
</table>

### Changelog per 1.9.8_1515, rilasciato il 19 giugno 2018
{: #198_1515}

<table summary="Modifiche apportate a partire dalla versione 1.9.7_1513">
<caption>Modifiche a partire dalla versione 1.9.7_1513</caption>
<thead>
<tr>
<th>Componente</th>
<th>Precedente</th>
<th>Corrente</th>
<th>Descrizione</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>v1.9.7</td>
<td>v1.9.8</td>
<td>Vedi le [note sulla release Kubernetes![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/kubernetes/kubernetes/releases/tag/v1.9.8).</td>
</tr>
<tr>
<td>Configurazione Kubernetes</td>
<td>N/D</td>
<td>N/D</td>
<td>È stata aggiunta PodSecurityPolicy all'opzione --admission-control per il server API Kubernetes del cluster ed è stato configurato il cluster per supportare le politiche di sicurezza del pod. Per ulteriori informazioni, vedi [Configurazione delle politiche di sicurezza del pod](cs_psp.html).</td>
</tr>
<tr>
<td>IBM Cloud Provider</td>
<td>v1.9.7-102</td>
<td>v1.9.8-141</td>
<td>Aggiornato per supportare la release Kubernetes 1.9.8. </td>
</tr>
<tr>
<td>CLient OpenVPN</td>
<td>N/D</td>
<td>N/D</td>
<td>È stato aggiunto <code>livenessProbe</code> alla distribuzione <code>vpn</code> del client OpenVPN che viene eseguita nello spazio dei nomi <code>kube-system</code>.</td>
</tr>
</tbody>
</table>


### Changelog per il fix pack di nodo di lavoro 1.9.7_1513, rilasciato l'11 giugno 2018
{: #197_1513}

<table summary="Modifiche apportate a partire dalla versione 1.9.7_1512">
<caption>Modifiche a partire dalla versione 1.9.7_1512</caption>
<thead>
<tr>
<th>Componente</th>
<th>Precedente</th>
<th>Corrente</th>
<th>Descrizione</th>
</tr>
</thead>
<tbody>
<tr>
<td>Aggiornamento kernel</td>
<td>4.4.0-116</td>
<td>4.4.0-127</td>
<td>Nuove immagini di nodo di lavoro con l'aggiornamento kernel per [CVE-2018-3639 ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-3639).</td>
</tr>
</tbody>
</table>

### Changelog per il fix pack di nodo di lavoro 1.9.7_1512, rilasciato il 18 maggio 2018
{: #197_1512}

<table summary="Modifiche apportate a partire dalla versione 1.9.7_1511">
<caption>Modifiche dalla versione 1.9.7_1511</caption>
<thead>
<tr>
<th>Componente</th>
<th>Precedente</th>
<th>Corrente</th>
<th>Descrizione</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>N/D</td>
<td>N/D</td>
<td>Correzione per risolvere un bug che si è verificato se hai utilizzato il plug-in dell'archiviazione blocchi.</td>
</tr>
</tbody>
</table>

### Changelog per il fix pack di nodo di lavoro 1.9.7_1511, rilasciato il 16 maggio 2018
{: #197_1511}

<table summary="Modifiche apportate a partire dalla versione 1.9.7_1510">
<caption>Modifiche dalla versione 1.9.7_1510</caption>
<thead>
<tr>
<th>Componente</th>
<th>Precedente</th>
<th>Corrente</th>
<th>Descrizione</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>N/D</td>
<td>N/D</td>
<td>I dati che archivi nella directory root `kubelet` sono ora salvati nel disco secondario più grande della tua macchina del nodo di lavoro.</td>
</tr>
</tbody>
</table>

### Changelog per 1.9.7_1510, rilasciato il 30 aprile 2018
{: #197_1510}

<table summary="Modifiche apportate a partire dalla versione 1.9.3_1506">
<caption>Modifiche dalla versione 1.9.3_1506</caption>
<thead>
<tr>
<th>Componente</th>
<th>Precedente</th>
<th>Corrente</th>
<th>Descrizione</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>v1.9.3</td>
<td>v1.9.7	</td>
<td><p>Vedi le [note sulla release Kubernetes![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/kubernetes/kubernetes/releases/tag/v1.9.7). Questa release risolve le vulnerabilità [CVE-2017-1002101 ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002101) e [CVE-2017-1002102 ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002102).</p><p><strong>Nota</strong>: ora `secret`, `configMap`, `downwardAPI` e i volumi previsti sono montati come di sola lettura. In precedenza, le applicazioni potevano scrivere i dati in questi volumi che il sistema poteva ripristinare automaticamente. Se le tue applicazioni si basano sul comportamento non sicuro precedente, modificale.</p></td>
</tr>
<tr>
<td>Configurazione Kubernetes</td>
<td>N/D</td>
<td>N/D</td>
<td>Aggiunto `admissionregistration.k8s.io/v1alpha1=true` all'opzione `--runtime-config` del server dell'API Kubernetes del cluster.</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.9.3-71</td>
<td>v1.9.7-102</td>
<td>I servizi `NodePort` e `LoadBalancer` ora supportano [la conservazione dell'IP di origine client](cs_loadbalancer.html#node_affinity_tolerations) impostando `service.spec.externalTrafficPolicy` su `Local`.</td>
</tr>
<tr>
<td></td>
<td></td>
<td></td>
<td>Corregge la configurazione di tolleranza del [nodo edge](cs_edge.html#edge) per i cluster meno recenti.</td>
</tr>
</tbody>
</table>

## Changelog Versione 1.8
{: #18_changelog}

Esamina le seguenti modifiche.

### Changelog per 1.8.15_1518, rilasciato il 27 luglio 2018
{: #1815_1518}

<table summary="Modifiche apportate a partire dalla versione 1.8.13_1516">
<caption>Modifiche a partire dalla versione 1.8.13_1516</caption>
<thead>
<tr>
<th>Componente</th>
<th>Precedente</th>
<th>Corrente</th>
<th>Descrizione</th>
</tr>
</thead>
<tbody>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.8.13-176</td>
<td>v1.8.15-204</td>
<td>Aggiornato per supportare la release Kubernetes 1.8.15. Inoltre, gli eventi `create failure` del servizio LoadBalancer ora includono qualsiasi errore di sottorete portatile.</td>
</tr>
<tr>
<td>Plug-in di archiviazione file IBM</td>
<td>320</td>
<td>334</td>
<td>Il timeout per la creazione di volumi persistenti è stato aumentato da 15 a 30 minuti. Il tipo di fatturazione predefinito è stato modificato in oraria (`hourly`). Sono state aggiunte delle opzioni di montaggio alle classi di archiviazione predefinite. Nell'istanza di archiviazione file NFS nel tuo account dell'infrastruttura IBM Cloud (SoftLayer), il campo **Note** è stato modificato in formato JSON ed è stato aggiunto lo spazio dei nomi Kubernetes a cui viene distribuito il PV. Per supportare i cluster multizona, sono state aggiunte le etichette di zona e regione ai volumi persistenti.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.8.13</td>
<td>v1.8.15</td>
<td>Vedi le [note sulla release Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/kubernetes/kubernetes/releases/tag/v1.8.15).</td>
</tr>
<tr>
<td>Kernel</td>
<td>N/D</td>
<td>N/D</td>
<td>Miglioramenti secondari alle impostazioni di rete dei nodi di lavoro per i carichi di lavoro di rete ad elevate prestazioni.</td>
</tr>
<tr>
<td>CLient OpenVPN</td>
<td>N/D</td>
<td>N/D</td>
<td>La distribuzione del client OpenVPN `vpn` che viene eseguita nello spazio dei nomi `kube-system` è ora gestita dall'`addon-manager` Kubernetes.</td>
</tr>
</tbody>
</table>

### Changelog per il fix pack di nodo di lavoro 1.8.13_1516, rilasciato il 3 luglio 2018
{: #1813_1516}

<table summary="Modifiche apportate a partire dalla versione 1.8.13_1515">
<caption>Modifiche a partire dalla versione 1.8.13_1515</caption>
<thead>
<tr>
<th>Componente</th>
<th>Precedente</th>
<th>Corrente</th>
<th>Descrizione</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kernel</td>
<td>N/D</td>
<td>N/D</td>
<td>`sysctl` ottimizzato per i carichi di lavoro di rete ad elevate prestazioni.</td>
</tr>
</tbody>
</table>


### Changelog per il fix pack di nodo di lavoro 1.8.13_1515, rilasciato il 21 giugno 2018
{: #1813_1515}

<table summary="Modifiche apportate a partire dalla versione 1.8.13_1514">
<caption>Modifiche a partire dalla versione 1.8.13_1514</caption>
<thead>
<tr>
<th>Componente</th>
<th>Precedente</th>
<th>Corrente</th>
<th>Descrizione</th>
</tr>
</thead>
<tbody>
<tr>
<td>Docker</td>
<td>N/D</td>
<td>N/D</td>
<td>Per i tipi di macchina non crittografati, il disco secondario viene ripulito ottenendo un file system nuovo quando ricarichi o aggiorni il nodo di lavoro.</td>
</tr>
</tbody>
</table>

### Changelog 1.8.13_1514, rilasciato il 19 giugno 2018
{: #1813_1514}

<table summary="Modifiche apportate a partire dalla versione 1.8.11_1512">
<caption>Modifiche a partire dalla versione 1.8.11_1512</caption>
<thead>
<tr>
<th>Componente</th>
<th>Precedente</th>
<th>Corrente</th>
<th>Descrizione</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>v1.8.11</td>
<td>v1.8.13</td>
<td>Vedi le [note sulla release Kubernetes![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/kubernetes/kubernetes/releases/tag/v1.8.13).</td>
</tr>
<tr>
<td>Configurazione Kubernetes</td>
<td>N/D</td>
<td>N/D</td>
<td>È stata aggiunta PodSecurityPolicy all'opzione --admission-control per il server API Kubernetes del cluster ed è stato configurato il cluster per supportare le politiche di sicurezza del pod. Per ulteriori informazioni, vedi [Configurazione delle politiche di sicurezza del pod](cs_psp.html).</td>
</tr>
<tr>
<td>IBM Cloud Provider</td>
<td>v1.8.11-126</td>
<td>v1.8.13-176</td>
<td>Aggiornato per supportare la release Kubernetes 1.8.13. </td>
</tr>
<tr>
<td>CLient OpenVPN</td>
<td>N/D</td>
<td>N/D</td>
<td>È stato aggiunto <code>livenessProbe</code> alla distribuzione <code>vpn</code> del client OpenVPN che viene eseguita nello spazio dei nomi <code>kube-system</code>.</td>
</tr>
</tbody>
</table>


### Changelog per il fix pack di nodo di lavoro 1.8.11_1512, rilasciato l'11 giugno 2018
{: #1811_1512}

<table summary="Modifiche apportate a partire dalla versione 1.8.11_1511">
<caption>Modifiche a partire dalla versione 1.8.11_1511</caption>
<thead>
<tr>
<th>Componente</th>
<th>Precedente</th>
<th>Corrente</th>
<th>Descrizione</th>
</tr>
</thead>
<tbody>
<tr>
<td>Aggiornamento kernel</td>
<td>4.4.0-116</td>
<td>4.4.0-127</td>
<td>Nuove immagini di nodo di lavoro con l'aggiornamento kernel per [CVE-2018-3639 ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-3639).</td>
</tr>
</tbody>
</table>


### Changelog per il fix pack di nodo di lavoro 1.8.11_1511, rilasciato il 18 maggio 2018
{: #1811_1511}

<table summary="Modifiche apportate a partire dalla versione 1.8.11_1510">
<caption>Modifiche dalla versione 1.8.11_1510</caption>
<thead>
<tr>
<th>Componente</th>
<th>Precedente</th>
<th>Corrente</th>
<th>Descrizione</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>N/D</td>
<td>N/D</td>
<td>Correzione per risolvere un bug che si è verificato se hai utilizzato il plug-in dell'archiviazione blocchi.</td>
</tr>
</tbody>
</table>

### Changelog per il fix pack di nodo di lavoro 1.8.11_1510, rilasciato il 16 maggio 2018
{: #1811_1510}

<table summary="Modifiche apportate a partire dalla versione 1.8.11_1509">
<caption>Modifiche dalla versione 1.8.11_1509</caption>
<thead>
<tr>
<th>Componente</th>
<th>Precedente</th>
<th>Corrente</th>
<th>Descrizione</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>N/D</td>
<td>N/D</td>
<td>I dati che archivi nella directory root `kubelet` sono ora salvati nel disco secondario più grande della tua macchina del nodo di lavoro.</td>
</tr>
</tbody>
</table>


### Changelog per 1.8.11_1509, rilasciato il 19 aprile 2018
{: #1811_1509}

<table summary="Modifiche apportate a partire dalla versione 1.8.8_1507">
<caption>Modifiche dalla versione 1.8.8_1507</caption>
<thead>
<tr>
<th>Componente</th>
<th>Precedente</th>
<th>Corrente</th>
<th>Descrizione</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>v1.8.8</td>
<td>v1.8.11	</td>
<td><p>Vedi le [note sulla release Kubernetes![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/kubernetes/kubernetes/releases/tag/v1.8.11). Questa release risolve le vulnerabilità [CVE-2017-1002101 ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002101) e [CVE-2017-1002102 ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002102).</p><p><strong>Nota</strong>: ora `secret`, `configMap`, `downwardAPI` e i volumi previsti sono montati come di sola lettura. In precedenza, le applicazioni potevano scrivere i dati in questi volumi che il sistema poteva ripristinare automaticamente. Se le tue applicazioni si basano sul comportamento non sicuro precedente, modificale.</p></td>
</tr>
<tr>
<td>Sospensione immagine contenitore</td>
<td>3.0</td>
<td>3.1</td>
<td>Rimuove i processi zombie orfani ereditati.</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.8.8-86</td>
<td>v1.8.11-126</td>
<td>I servizi `NodePort` e `LoadBalancer` ora supportano [la conservazione dell'IP di origine client](cs_loadbalancer.html#node_affinity_tolerations) impostando `service.spec.externalTrafficPolicy` su `Local`.</td>
</tr>
<tr>
<td></td>
<td></td>
<td></td>
<td>Corregge la configurazione di tolleranza del [nodo edge](cs_edge.html#edge) per i cluster meno recenti.</td>
</tr>
</tbody>
</table>

## Archivio
{: #changelog_archive}

### Changelog versione 1.7 (non supportato)
{: #17_changelog}

Esamina le seguenti modifiche.

#### Changelog per il fix pack di nodo di lavoro 1.7.16_1514, rilasciato l'11 giugno 2018
{: #1716_1514}

<table summary="Modifiche apportate a partire dalla versione 1.7.16_1513">
<caption>Modifiche a partire dalla versione 1.7.16_1513</caption>
<thead>
<tr>
<th>Componente</th>
<th>Precedente</th>
<th>Corrente</th>
<th>Descrizione</th>
</tr>
</thead>
<tbody>
<tr>
<td>Aggiornamento kernel</td>
<td>4.4.0-116</td>
<td>4.4.0-127</td>
<td>Nuove immagini di nodo di lavoro con l'aggiornamento kernel per [CVE-2018-3639 ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-3639).</td>
</tr>
</tbody>
</table>

#### Changelog per il fix pack di nodo di lavoro 1.7.16_1513, rilasciato il 18 maggio 2018
{: #1716_1513}

<table summary="Modifiche apportate a partire dalla versione 1.7.16_1512">
<caption>Modifiche dalla versione 1.7.16_1512</caption>
<thead>
<tr>
<th>Componente</th>
<th>Precedente</th>
<th>Corrente</th>
<th>Descrizione</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>N/D</td>
<td>N/D</td>
<td>Correzione per risolvere un bug che si è verificato se hai utilizzato il plug-in dell'archiviazione blocchi.</td>
</tr>
</tbody>
</table>

#### Changelog per il fix pack di nodo di lavoro 1.7.16_1512, rilasciato il 16 maggio 2018
{: #1716_1512}

<table summary="Modifiche apportate a partire dalla versione 1.7.16_1511">
<caption>Modifiche dalla versione 1.7.16_1511</caption>
<thead>
<tr>
<th>Componente</th>
<th>Precedente</th>
<th>Corrente</th>
<th>Descrizione</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubelet</td>
<td>N/D</td>
<td>N/D</td>
<td>I dati che archivi nella directory root `kubelet` sono ora salvati nel disco secondario più grande della tua macchina del nodo di lavoro.</td>
</tr>
</tbody>
</table>

#### Changelog per 1.7.16_1511, rilasciato il 19 aprile 2018
{: #1716_1511}

<table summary="Modifiche apportate a partire dalla versione 1.7.4_1509">
<caption>Modifiche dalla versione 1.7.4_1509</caption>
<thead>
<tr>
<th>Componente</th>
<th>Precedente</th>
<th>Corrente</th>
<th>Descrizione</th>
</tr>
</thead>
<tbody>
<tr>
<td>Kubernetes</td>
<td>v1.7.4</td>
<td>v1.7.16	</td>
<td><p>Vedi le [note sulla release Kubernetes![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/kubernetes/kubernetes/releases/tag/v1.7.16). Questa release risolve le vulnerabilità [CVE-2017-1002101 ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002101) e [CVE-2017-1002102 ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002102).</p><p><strong>Nota</strong>: ora `secret`, `configMap`, `downwardAPI` e i volumi previsti sono montati come di sola lettura. In precedenza, le applicazioni potevano scrivere i dati in questi volumi che il sistema poteva ripristinare automaticamente. Se le tue applicazioni si basano sul comportamento non sicuro precedente, modificale.</p></td>
</tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.7.4-133</td>
<td>v1.7.16-17</td>
<td>I servizi `NodePort` e `LoadBalancer` ora supportano [la conservazione dell'IP di origine client](cs_loadbalancer.html#node_affinity_tolerations) impostando `service.spec.externalTrafficPolicy` su `Local`.</td>
</tr>
<tr>
<td></td>
<td></td>
<td></td>
<td>Corregge la configurazione di tolleranza del [nodo edge](cs_edge.html#edge) per i cluster meno recenti.</td>
</tr>
</tbody>
</table>
