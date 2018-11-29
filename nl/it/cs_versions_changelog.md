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



# Changelog versione
{: #changelog}

Visualizza le informazioni sulle modifiche alla versione per gli aggiornamenti principali, secondari e patch disponibili per i tuoi cluster Kubernetes {{site.data.keyword.containerlong}}. Le modifiche includono gli aggiornamenti ai componenti Kubernetes e {{site.data.keyword.Bluemix_notm}} Provider.
{:shortdesc}

Per ulteriori informazioni sulle versioni principali, secondarie e patch e sulle azioni di migrazione tra le versioni secondarie, vedi [Versioni Kubernetes](cs_versions.html).
{: tip}

Per informazioni sulle modifiche dalla versione precedente, vedi i seguenti changelog.
-  [Changelog](#111_changelog) versione 1.11.
-  [Changelog](#110_changelog) Versione 1.10.
-  [Changelog](#19_changelog) Versione 1.9.
-  [Archivio](#changelog_archive) dei changelog per le versioni obsolete o non supportate.

**Nota**: alcuni changelog sono per i _fix pack del nodo di lavoro_ e si applicano solo ai nodi di lavoro. Devi [applicare queste patch](cs_cli_reference.html#cs_worker_update) per garantire la conformità di sicurezza per i tuoi nodi di lavoro. Altri changelog sono per i _fix pack del master_ e si applicano solo al master del cluster. I fix pack del master potrebbero non essere applicati automaticamente. Puoi scegliere di [applicarli manualmente](cs_cli_reference.html#cs_cluster_update). Per ulteriori informazioni sui tipi di patch, vedi [Tipi di aggiornamento](cs_versions.html#update_types).

</br>

## Changelog Versione 1.11
{: #111_changelog}

Esamina le seguenti modifiche.


### Changelog per il fix pack del master 1.11.3_1527, rilasciato il 15 ottobre 2018
{: #1113_1527}

<table summary="Modifiche apportate a partire dalla versione 1.11.3_1524">
<caption>Modifiche dalla versione 1.11.3_1524</caption>
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
<td>Configurazione Calico</td>
<td>N/D</td>
<td>N/D</td>
<td>È stata corretta l'analisi di disponibilità del contenitore `calico-node` per gestire meglio gli errori del nodo.</td>
</tr>
<tr>
<td>Aggiornamento cluster</td>
<td>N/D</td>
<td>N/D</td>
<td>È stato risolto il problema con l'aggiornamento dei componenti aggiuntivi del cluster quando il master viene aggiornato da una versione non supportata.</td>
</tr>
</tbody>
</table>

### Changelog per il fix pack del nodo di lavoro 1.11.3_1525, rilasciato il 10 ottobre 2018
{: #1113_1525}

<table summary="Modifiche apportate a partire dalla versione 1.11.3_1524">
<caption>Modifiche dalla versione 1.11.3_1524</caption>
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
<td>4.4.0-133</td>
<td>4.4.0-137</td>
<td>Le immagini del nodo di lavoro sono state aggiornate con l'aggiornamento kernel per [CVE-2018-14633, CVE-2018-17182 ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-137.163/changelog).</td>
</tr>
<tr>
<td>Timeout di sessione inattiva</td>
<td>N/D</td>
<td>N/D</td>
<td>Imposta il timeout della sessione inattiva su 5 minuti per motivi di conformità.</td>
</tr>
</tbody>
</table>


### Changelog per 1.11.3_1524, rilasciato il 2 ottobre 2018
{: #1113_1524}

<table summary="Modifiche apportate a partire dalla versione 1.11.3_1521">
<caption>Modifiche dalla versione 1.11.3_1521</caption>
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
<td>containerd</td>
<td>1.1.3</td>
<td>1.1.4</td>
<td>Vedi le [note sulla release di containerd ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/containerd/containerd/releases/tag/v1.1.4).</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.11.3-91</td>
<td>v1.11.3-100</td>
<td>È stato aggiornato il link alla documentazione nei messaggi di errore del programma di bilanciamento del carico.</td>
</tr>
<tr>
<td>Classi di archiviazione file IBM</td>
<td>N/D</td>
<td>N/D</td>
<td>È stato rimosso il parametro duplicato `reclaimPolicy` nelle classi di archiviazione file IBM.<br><br>
Inoltre, adesso quando aggiorni il master del cluster, la classe di archiviazione file IBM predefinita rimane invariata. Se vuoi modificare la classe di archiviazione predefinita, esegui `kubectl patch storageclass <storageclass> -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'` e sostituisci `<storageclass>` con il nome della classe di archiviazione.</td>
</tr>
</tbody>
</table>

### Changelog per 1.11.3_1521, rilasciato il 20 ottobre 2018
{: #1113_1521}

<table summary="Modifiche apportate a partire dalla versione 1.11.2_1516">
<caption>Modifiche dalla versione 1.11.2_1516</caption>
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
<td>v1.11.2-71</td>
<td>v1.11.3-91</td>
<td>Aggiornamento per supportare la release di Kubernetes 1.11.3.</td>
</tr>
<tr>
<td>Classi di archiviazione file IBM</td>
<td>N/D</td>
<td>N/D</td>
<td>È stato rimosso `mountOptions` nelle classi di archiviazione file IBM per utilizzare l'impostazione predefinita fornita dal nodo di lavoro.<br><br>
Inoltre, adesso quando aggiorni il master del cluster, la classe di archiviazione file IBM predefinita rimane `ibmc-file-bronze`. Se vuoi modificare la classe di archiviazione predefinita, esegui `kubectl patch storageclass <storageclass> -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'` e sostituisci `<storageclass>` con il nome della classe di archiviazione.</td>
</tr>
<tr>
<td>Provider KMS (Key Management Service)</td>
<td>N/D</td>
<td>N/D</td>
<td>È stata aggiunta la possibilità di utilizzare il provider KMS (key management service) di Kubernetes nel cluster, per supportare {{site.data.keyword.keymanagementservicefull}}. Quando [abiliti {{site.data.keyword.keymanagementserviceshort}} nel cluster](cs_encrypt.html#keyprotect), tutti i tuoi segreti Kubernetes vengono crittografati.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.11.2</td>
<td>v1.11.3</td>
<td>Vedi le [note sulla release Kubernetes![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/kubernetes/kubernetes/releases/tag/v1.11.3).</td>
</tr>
<tr>
<td>DNS autoscaler di Kubernetes</td>
<td>1.1.2-r2</td>
<td>1.2.0</td>
<td>Vedi le [note sulla release di DNS autoscaler di Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/kubernetes-incubator/cluster-proportional-autoscaler/releases/tag/1.2.0).</td>
</tr>
<tr>
<td>Rotazione dei log</td>
<td>N/D</td>
<td>N/D</td>
<td>Si è passato all'utilizzo dei timer `systemd` anziché `cronjobs` per evitare che `logrotate` non funzioni sui nodi di lavoro che non vengono ricaricati o aggiornati entro 90 giorni. **Nota**: in tutte le versioni precedenti per questa release secondaria, il disco primario si riempie dopo che il lavoro cron ha esito negativo perché i log non vengono ruotati. Il lavoro cron ha esito negativo dopo che il nodo di lavoro resta attivo per 90 giorni senza essere aggiornato o ricaricato. Se i log riempiono l'intero disco primario, il nodo di lavoro entra in uno stato non riuscito. Il nodo di lavoro può essere corretto utilizzando il [comando](cs_cli_reference.html#cs_worker_reload) `ibmcloud ks worker-reload` o il [comando](cs_cli_reference.html#cs_worker_update) `ibmcloud ks worker-update`.</td>
</tr>
<tr>
<td>Scadenza della password root</td>
<td>N/D</td>
<td>N/D</td>
<td>Le password root per i nodi di lavoro scadono dopo 90 giorni per motivi di conformità. Se i tuoi strumenti di automazione devono accedere al nodo di lavoro come root o fanno affidamento su lavori cron eseguiti come root, puoi disabilitare la scadenza della password accedendo al nodo di lavoro ed eseguendo `chage -M -1 root`. **Nota**: se hai requisiti di conformità di sicurezza che impediscono l'esecuzione come root o la rimozione della scadenza della password, non disabilitare la scadenza. Puoi invece [aggiornare](cs_cli_reference.html#cs_worker_update) o [ricaricare](cs_cli_reference.html#cs_worker_reload) i tuoi nodi di lavoro almeno ogni 90 giorni.</td>
</tr>
<tr>
<td>Componenti di runtime del nodo di lavoro (`kubelet`, `kube-proxy`, `containerd`)</td>
<td>N/D</td>
<td>N/D</td>
<td>Sono state rimosse le dipendenze dei componenti di runtime sul disco primario. Questo miglioramento impedisce il malfunzionamento dei nodi di lavoro quando il disco primario viene riempito.</td>
</tr>
<tr>
<td>Systemd</td>
<td>N/D</td>
<td>N/D</td>
<td>Elimina periodicamente le unità di montaggio temporanee per evitare che diventino illimitate. Questa azione risolve il [problema di Kubernetes 57345 ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/kubernetes/kubernetes/issues/57345).</td>
</tr>
</tbody>
</table>

### Changelog per 1.11.2_1516, rilasciato il 4 settembre 2018
{: #1112_1516}

<table summary="Modifiche apportate a partire dalla versione 1.11.2_1514">
<caption>Modifiche a partire dalla versione 1.11.2_1514</caption>
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
<td>v3.1.3</td>
<td>v3.2.1</td>
<td>Vedi le [note sulla release Calico![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://docs.projectcalico.org/v3.2/releases/#v321).</td>
</tr>
<tr>
<td>containerd</td>
<td>1.1.2</td>
<td>1.1.3</td>
<td>Vedi le [note sulla release `containerd` ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/containerd/containerd/releases/tag/v1.1.3).</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.11.2-60</td>
<td>v1.11.2-71</td>
<td>È stata modificata la configurazione del provider cloud per gestire meglio gli aggiornamenti per i servizi del programma di bilanciamento del carico con `externalTrafficPolicy` impostata su `local`.</td>
</tr>
<tr>
<td>Configurazione del plug-in di archiviazione file IBM</td>
<td>N/D</td>
<td>N/D</td>
<td>È stata rimossa la versione NFS predefinita dalle opzioni di montaggio nelle classi di archiviazione file fornite da IBM. Il sistema operativo dell'host ora negozia la versione NFS con il server NFS dell'infrastruttura IBM Cloud (SoftLayer). Per impostare manualmente una specifica versione NFS, o modificare la versione NFS del tuo PV che era stato negoziato dal sistema operativo dell'host, vedi [Modifica della versione NFS predefinita](cs_storage_file.html#nfs_version_class).</td>
</tr>
</tbody>
</table>

### Changelog per il fix pack di nodo di lavoro 1.11.2_1514, rilasciato il 23 agosto 2018
{: #1112_1514}

<table summary="Modifiche apportate a partire dalla versione 1.11.2_1513">
<caption>Modifiche a partire dalla versione 1.11.2_1513</caption>
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
<td>`systemd`</td>
<td>229</td>
<td>230</td>
<td>`systemd` è stato aggiornato per correggere la perdita `cgroup`.</td>
</tr>
<tr>
<td>Kernel</td>
<td>4.4.0-127</td>
<td>4.4.0-133</td>
<td>Le immagini del nodo di lavoro sono state aggiornate con l'aggiornamento kernel per [CVE-2018-3620,CVE-2018-3646 ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://usn.ubuntu.com/3741-1/).</td>
</tr>
</tbody>
</table>

### Changelog per 1.11.2_1513, rilasciato il 14 agosto 2018
{: #1112_1513}

<table summary="Modifiche apportate a partire dalla versione 1.10.5_1518">
<caption>Modifiche a partire dalla versione 1.10.5_1518</caption>
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
<td>containerd</td>
<td>N/D</td>
<td>1.1.2</td>
<td>`containerd` sostituisce Docker come nuovo runtime del contenitore per Kubernetes. Vedi le [note sulla release `containerd` ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/containerd/containerd/releases/tag/v1.1.2). Per le azioni che devi eseguire, vedi [Migrazione a `containerd` come runtime del contenitore](cs_versions.html#containerd).</td>
</tr>
<tr>
<td>Docker</td>
<td>N/D</td>
<td>N/D</td>
<td>`containerd` sostituisce Docker come nuovo runtime del contenitore per Kubernetes, per migliorare le prestazioni. Per le azioni che devi eseguire, vedi [Migrazione a `containerd` come runtime del contenitore](cs_versions.html#containerd).</td>
</tr>
<tr>
<td>etcd</td>
<td>v3.2.14</td>
<td>v3.2.18</td>
<td>Vedi le [note sulla release etcd ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/coreos/etcd/releases/v3.2.18).</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.10.5-118</td>
<td>v1.11.2-60</td>
<td>Aggiornato per supportare la release Kubernetes 1.11. Inoltre, i pod del programma di bilanciamento del carico ora usano la nuova classe di priorità del pod `ibm-app-cluster-critical`.</td>
</tr>
<tr>
<td>Plug-in di archiviazione file IBM</td>
<td>334</td>
<td>338</td>
<td>La versione di `incubator` è stata aggiornata alla 1.8. Il provisioning dell'archiviazione file viene eseguito alla specifica zona da te selezionata. Non puoi aggiornare delle etichette di un'istanza PV (statica) esistente a meno che tu non stia utilizzando un cluster multizona e debba [aggiungere le etichette di regione e zona](cs_storage_basics.html#multizone).</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.10.5</td>
<td>v1.11.2</td>
<td>Vedi le [note sulla release Kubernetes![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/kubernetes/kubernetes/releases/tag/v1.11.2).</td>
</tr>
<tr>
<td>Configurazione Kubernetes</td>
<td>N/D</td>
<td>N/D</td>
<td>La configurazione OpenID Connect è stata aggiornata per il server API Kubernetes del cluster per supportare i gruppi di accesso {{site.data.keyword.Bluemix_notm}} IAM (Identity Access and Management). È stata aggiunta `Priority` all'opzione `--enable-admission-plugins` per il server API Kubernetes del cluster ed è stato configurato il cluster per supportare la priorità dei pod. Per ulteriori informazioni, consulta:
<ul><li>[Gruppi di accesso IAM](cs_users.html#rbac)</li>
<li>[Configurazione della priorità dei pod](cs_pod_priority.html#pod_priority)</li></ul></td>
</tr>
<tr>
<td>Kubernetes Heapster</td>
<td>v1.5.2</td>
<td>v.1.5.4</td>
<td>Sono stati aumentati i limiti di risorsa per il contenitore `heapster-nanny`. Vedi le [note sulla release di Kubernetes Heapster![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/kubernetes/heapster/releases/tag/v1.5.4).</td>
</tr>
<tr>
<td>Configurazione della registrazione</td>
<td>N/D</td>
<td>N/D</td>
<td>La directory dei log del contenitore è ora `/var/log/pods/` invece della precedente `/var/lib/docker/containers/`.</td>
</tr>
</tbody>
</table>

<br />


## Changelog Versione 1.10
{: #110_changelog}

Esamina le seguenti modifiche.

### Changelog per il fix pack del master 1.10.8_1527, rilasciato il 15 ottobre 2018
{: #1108_1527}

<table summary="Modifiche apportate a partire dalla versione 1.10.8_1524">
<caption>Modifiche dalla versione 1.10.8_1524</caption>
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
<td>Configurazione Calico</td>
<td>N/D</td>
<td>N/D</td>
<td>È stata corretta l'analisi di disponibilità del contenitore `calico-node` per gestire meglio gli errori del nodo.</td>
</tr>
<tr>
<td>Aggiornamento cluster</td>
<td>N/D</td>
<td>N/D</td>
<td>È stato risolto il problema con l'aggiornamento dei componenti aggiuntivi del cluster quando il master viene aggiornato da una versione non supportata.</td>
</tr>
</tbody>
</table>

### Changelog per il fix pack del nodo di lavoro 1.10.8_1525, rilasciato il 10 ottobre 2018
{: #1108_1525}

<table summary="Modifiche apportate a partire dalla versione 1.10.8_1524">
<caption>Modifiche dalla versione 1.10.8_1524</caption>
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
<td>4.4.0-133</td>
<td>4.4.0-137</td>
<td>Le immagini del nodo di lavoro sono state aggiornate con l'aggiornamento kernel per [CVE-2018-14633, CVE-2018-17182 ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-137.163/changelog).</td>
</tr>
<tr>
<td>Timeout di sessione inattiva</td>
<td>N/D</td>
<td>N/D</td>
<td>Imposta il timeout della sessione inattiva su 5 minuti per motivi di conformità.</td>
</tr>
</tbody>
</table>


### Changelog per 1.10.8_1524, rilasciato il 2 ottobre 2018
{: #1108_1524}

<table summary="Modifiche apportate a partire dalla versione 1.10.7_1520">
<caption>Modifiche dalla versione 1.10.7_1520</caption>
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
<td>Provider KMS (Key Management Service)</td>
<td>N/D</td>
<td>N/D</td>
<td>È stata aggiunta la possibilità di utilizzare il provider KMS (key management service) di Kubernetes nel cluster, per supportare {{site.data.keyword.keymanagementservicefull}}. Quando [abiliti {{site.data.keyword.keymanagementserviceshort}} nel cluster](cs_encrypt.html#keyprotect), tutti i tuoi segreti Kubernetes vengono crittografati.</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.10.7</td>
<td>v1.10.8</td>
<td>Vedi le [note sulla release Kubernetes![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.8).</td>
</tr>
<tr>
<td>DNS autoscaler di Kubernetes</td>
<td>1.1.2-r2</td>
<td>1.2.0</td>
<td>Vedi le [note sulla release di DNS autoscaler di Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/kubernetes-incubator/cluster-proportional-autoscaler/releases/tag/1.2.0).</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.10.7-146</td>
<td>v1.10.8-172</td>
<td>Aggiornamento per supportare la release di Kubernetes 1.10.8. Inoltre, è stato aggiornato il link alla documentazione nei messaggi di errore del programma di bilanciamento del carico.</td>
</tr>
<tr>
<td>Classi di archiviazione file IBM</td>
<td>N/D</td>
<td>N/D</td>
<td>È stato rimosso `mountOptions` nelle classi di archiviazione file IBM per utilizzare l'impostazione predefinita fornita dal nodo di lavoro. È stato rimosso il parametro duplicato `reclaimPolicy` nelle classi di archiviazione file IBM.<br><br>
Inoltre, adesso quando aggiorni il master del cluster, la classe di archiviazione file IBM predefinita rimane invariata. Se vuoi modificare la classe di archiviazione predefinita, esegui `kubectl patch storageclass <storageclass> -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'` e sostituisci `<storageclass>` con il nome della classe di archiviazione.</td>
</tr>
</tbody>
</table>

### Changelog per il fix pack del nodo di lavoro 1.10.7_1521, rilasciato il 20 settembre 2018
{: #1107_1521}

<table summary="Modifiche apportate a partire dalla versione 1.10.7_1520">
<caption>Modifiche dalla versione 1.10.7_1520</caption>
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
<td>Rotazione dei log</td>
<td>N/D</td>
<td>N/D</td>
<td>Si è passato all'utilizzo dei timer `systemd` anziché `cronjobs` per evitare che `logrotate` non funzioni sui nodi di lavoro che non vengono ricaricati o aggiornati entro 90 giorni. **Nota**: in tutte le versioni precedenti per questa release secondaria, il disco primario si riempie dopo che il lavoro cron ha esito negativo perché i log non vengono ruotati. Il lavoro cron ha esito negativo dopo che il nodo di lavoro resta attivo per 90 giorni senza essere aggiornato o ricaricato. Se i log riempiono l'intero disco primario, il nodo di lavoro entra in uno stato non riuscito. Il nodo di lavoro può essere corretto utilizzando il [comando](cs_cli_reference.html#cs_worker_reload) `ibmcloud ks worker-reload` o il [comando](cs_cli_reference.html#cs_worker_update) `ibmcloud ks worker-update`.</td>
</tr>
<tr>
<td>Componenti di runtime del nodo di lavoro (`kubelet`, `kube-proxy`, `docker`)</td>
<td>N/D</td>
<td>N/D</td>
<td>Sono state rimosse le dipendenze dei componenti di runtime sul disco primario. Questo miglioramento impedisce il malfunzionamento dei nodi di lavoro quando il disco primario viene riempito.</td>
</tr>
<tr>
<td>Scadenza della password root</td>
<td>N/D</td>
<td>N/D</td>
<td>Le password root per i nodi di lavoro scadono dopo 90 giorni per motivi di conformità. Se i tuoi strumenti di automazione devono accedere al nodo di lavoro come root o fanno affidamento su lavori cron eseguiti come root, puoi disabilitare la scadenza della password accedendo al nodo di lavoro ed eseguendo `chage -M -1 root`. **Nota**: se hai requisiti di conformità di sicurezza che impediscono l'esecuzione come root o la rimozione della scadenza della password, non disabilitare la scadenza. Puoi invece [aggiornare](cs_cli_reference.html#cs_worker_update) o [ricaricare](cs_cli_reference.html#cs_worker_reload) i tuoi nodi di lavoro almeno ogni 90 giorni.</td>
</tr>
<tr>
<td>Systemd</td>
<td>N/D</td>
<td>N/D</td>
<td>Elimina periodicamente le unità di montaggio temporanee per evitare che diventino illimitate. Questa azione risolve il [problema di Kubernetes 57345 ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/kubernetes/kubernetes/issues/57345).</td>
</tr>
<tr>
<td>Docker</td>
<td>N/D</td>
<td>N/D</td>
<td>È stato disabilitato il bridge Docker predefinito in modo che per le rotte private venga utilizzato ora l'intervallo di IP `172.17.0.0/16`. Se ti affidi alla creazione di contenitori Docker nei nodi di lavoro eseguendo direttamente i comandi `docker` sull'host o utilizzando un pod che monta il socket Docker, scegli tra le seguenti opzioni. <ul><li>Per garantire la connettività di rete esterna quando crei il contenitore, esegui `docker build . --network host`.</li>
<li>Per creare esplicitamente una rete da utilizzare quando crei il contenitore, esegui `docker network create` e utilizza quindi questa rete.</li></ul>
**Nota**: hai dipendenze sul socket Docker o direttamente su Docker? [Migra a `containerd` invece di `docker` come runtime del contenitore](cs_versions.html#containerd) in modo che i tuoi cluster siano pronti per eseguire Kubernetes versione 1.11 o successive.</td>
</tr>
</tbody>
</table>

### Changelog per 1.10.7_1520, rilasciato il 4 settembre 2018
{: #1107_1520}

<table summary="Modifiche apportate a partire dalla versione 1.10.5_1519">
<caption>Modifiche a partire dalla versione 1.10.5_1519</caption>
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
<td>v3.1.3</td>
<td>v3.2.1</td>
<td>Consulta le [note sulla release Calico ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://docs.projectcalico.org/v3.2/releases/#v321).</td>
</tr>
<tr>
<td>{{site.data.keyword.Bluemix_notm}} Provider</td>
<td>v1.10.5-118</td>
<td>v1.10.7-146</td>
<td>Aggiornato per supportare la release Kubernetes 1.10.7. È stata inoltre modificata la configurazione del provider cloud per gestire meglio gli aggiornamenti per i servizi del programma di bilanciamento del carico con `externalTrafficPolicy` impostata su `local`.</td>
</tr>
<tr>
<td>Plug-in di archiviazione file IBM</td>
<td>334</td>
<td>338</td>
<td>La versione di incubator è stata aggiornata alla 1.8. Il provisioning dell'archiviazione file viene eseguito alla specifica zona da te selezionata. Non puoi aggiornare delle etichette di un'istanza PV (statica) esistente a meno che tu non stia utilizzando un cluster multizona e debba aggiungere le etichette di regione e zona.<br><br> È stata rimossa la versione NFS predefinita dalle opzioni di montaggio nelle classi di archiviazione file fornite da IBM. Il sistema operativo dell'host ora negozia la versione NFS con il server NFS dell'infrastruttura IBM Cloud (SoftLayer). Per impostare manualmente una specifica versione NFS, o modificare la versione NFS del tuo PV che era stato negoziato dal sistema operativo dell'host, vedi [Modifica della versione NFS predefinita](cs_storage_file.html#nfs_version_class).</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.10.5</td>
<td>v1.10.7</td>
<td>Vedi le [note sulla release Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/kubernetes/kubernetes/releases/tag/v1.10.7).</td>
</tr>
<tr>
<td>Configurazione di Kubernetes Heapster</td>
<td>N/D</td>
<td>N/D</td>
<td>Sono stati aumentati i limiti di risorsa per il contenitore `heapster-nanny`.</td>
</tr>
</tbody>
</table>

### Changelog per il fix pack di nodo di lavoro 1.10.5_1519, rilasciato il 23 agosto 2018
{: #1105_1519}

<table summary="Modifiche apportate a partire dalla versione 1.10.5_1518">
<caption>Modifiche a partire dalla versione 1.10.5_1518</caption>
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
<td>`systemd`</td>
<td>229</td>
<td>230</td>
<td>`systemd` è stato aggiornato per correggere la perdita `cgroup`.</td>
</tr>
<tr>
<td>Kernel</td>
<td>4.4.0-127</td>
<td>4.4.0-133</td>
<td>Le immagini del nodo di lavoro sono state aggiornate con l'aggiornamento kernel per [CVE-2018-3620,CVE-2018-3646 ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://usn.ubuntu.com/3741-1/).</td>
</tr>
</tbody>
</table>


### Changelog per il fix pack di nodo di lavoro 1.10.5_1518, rilasciato il 13 agosto 2018
{: #1105_1518}

<table summary="Modifiche apportate a partire dalla versione 1.10.5_1517">
<caption>Modifiche a partire dalla versione 1.10.5_1517</caption>
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
<td>Pacchetti Ubuntu</td>
<td>N/D</td>
<td>N/D</td>
<td>Aggiornamenti ai pacchetti Ubuntu installati.</td>
</tr>
</tbody>
</table>

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
<td>Aggiornato per supportare la release Kubernetes 1.10.3.</td>
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
<td>Il supporto per i [carichi di lavoro del contenitore GPU (graphics processing unit)](cs_app.html#gpu_app) è ora disponibile per la pianificazione e l'esecuzione. Per un elenco di tipi di macchina GPU disponibili, consulta [Hardware per i nodi di lavoro](cs_clusters_planning.html#shared_dedicated_node). Per ulteriori informazioni, consulta la documentazione Kubernetes in [Schedule GPUs ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/tasks/manage-gpus/scheduling-gpus/).</td>
</tr>
</tbody>
</table>

<br />


## Changelog Versione 1.9
{: #19_changelog}

Esamina le seguenti modifiche.

### Changelog per il fix pack del master 1.9.10_1530, rilasciato il 15 ottobre 2018
{: #1910_1530}

<table summary="Modifiche apportate a partire dalla versione 1.9.10_1527">
<caption>Modifiche dalla versione 1.9.10_1527</caption>
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
<td>Aggiornamento cluster</td>
<td>N/D</td>
<td>N/D</td>
<td>È stato risolto il problema con l'aggiornamento dei componenti aggiuntivi del cluster quando il master viene aggiornato da una versione non supportata.</td>
</tr>
</tbody>
</table>

### Changelog per il fix pack del nodo di lavoro 1.9.10_1528, rilasciato il 10 ottobre 2018
{: #1910_1528}

<table summary="Modifiche apportate a partire dalla versione 1.9.10_1527">
<caption>Modifiche dalla versione 1.9.10_1527</caption>
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
<td>4.4.0-133</td>
<td>4.4.0-137</td>
<td>Le immagini del nodo di lavoro sono state aggiornate con l'aggiornamento kernel per [CVE-2018-14633, CVE-2018-17182 ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://changelogs.ubuntu.com/changelogs/pool/main/l/linux/linux_4.4.0-137.163/changelog).</td>
</tr>
<tr>
<td>Timeout di sessione inattiva</td>
<td>N/D</td>
<td>N/D</td>
<td>Imposta il timeout della sessione inattiva su 5 minuti per motivi di conformità.</td>
</tr>
</tbody>
</table>


### Changelog per 1.9.10_1527, rilasciato il 2 ottobre 2018
{: #1910_1527}

<table summary="Modifiche apportate a partire dalla versione 1.9.10_1523">
<caption>Modifiche dalla versione 1.9.10_1523</caption>
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
<td>v1.9.10-192</td>
<td>v1.9.10-219</td>
<td>È stato aggiornato il link alla documentazione nei messaggi di errore del programma di bilanciamento del carico.</td>
</tr>
<tr>
<td>Classi di archiviazione file IBM</td>
<td>N/D</td>
<td>N/D</td>
<td>È stato rimosso `mountOptions` nelle classi di archiviazione file IBM per utilizzare l'impostazione predefinita fornita dal nodo di lavoro. È stato rimosso il parametro duplicato `reclaimPolicy` nelle classi di archiviazione file IBM.<br><br>
Inoltre, adesso quando aggiorni il master del cluster, la classe di archiviazione file IBM predefinita rimane invariata. Se vuoi modificare la classe di archiviazione predefinita, esegui `kubectl patch storageclass <storageclass> -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'` e sostituisci `<storageclass>` con il nome della classe di archiviazione.</td>
</tr>
</tbody>
</table>

### Changelog per il fix pack del nodo di lavoro 1.9.10_1524, rilasciato il 20 settembre 2018
{: #1910_1524}

<table summary="Modifiche apportate a partire dalla versione 1.9.10_1523">
<caption>Modifiche dalla versione 1.9.10_1523</caption>
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
<td>Rotazione dei log</td>
<td>N/D</td>
<td>N/D</td>
<td>Si è passato all'utilizzo dei timer `systemd` anziché `cronjobs` per evitare che `logrotate` non funzioni sui nodi di lavoro che non vengono ricaricati o aggiornati entro 90 giorni. **Nota**: in tutte le versioni precedenti per questa release secondaria, il disco primario si riempie dopo che il lavoro cron ha esito negativo perché i log non vengono ruotati. Il lavoro cron ha esito negativo dopo che il nodo di lavoro resta attivo per 90 giorni senza essere aggiornato o ricaricato. Se i log riempiono l'intero disco primario, il nodo di lavoro entra in uno stato non riuscito. Il nodo di lavoro può essere corretto utilizzando il [comando](cs_cli_reference.html#cs_worker_reload) `ibmcloud ks worker-reload` o il [comando](cs_cli_reference.html#cs_worker_update) `ibmcloud ks worker-update`.</td>
</tr>
<tr>
<td>Componenti di runtime del nodo di lavoro (`kubelet`, `kube-proxy`, `docker`)</td>
<td>N/D</td>
<td>N/D</td>
<td>Sono state rimosse le dipendenze dei componenti di runtime sul disco primario. Questo miglioramento impedisce il malfunzionamento dei nodi di lavoro quando il disco primario viene riempito.</td>
</tr>
<tr>
<td>Scadenza della password root</td>
<td>N/D</td>
<td>N/D</td>
<td>Le password root per i nodi di lavoro scadono dopo 90 giorni per motivi di conformità. Se i tuoi strumenti di automazione devono accedere al nodo di lavoro come root o fanno affidamento su lavori cron eseguiti come root, puoi disabilitare la scadenza della password accedendo al nodo di lavoro ed eseguendo `chage -M -1 root`. **Nota**: se hai requisiti di conformità di sicurezza che impediscono l'esecuzione come root o la rimozione della scadenza della password, non disabilitare la scadenza. Puoi invece [aggiornare](cs_cli_reference.html#cs_worker_update) o [ricaricare](cs_cli_reference.html#cs_worker_reload) i tuoi nodi di lavoro almeno ogni 90 giorni.</td>
</tr>
<tr>
<td>Systemd</td>
<td>N/D</td>
<td>N/D</td>
<td>Elimina periodicamente le unità di montaggio temporanee per evitare che diventino illimitate. Questa azione risolve il [problema di Kubernetes 57345 ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/kubernetes/kubernetes/issues/57345).</td>
</tr>
<tr>
<td>Docker</td>
<td>N/D</td>
<td>N/D</td>
<td>È stato disabilitato il bridge Docker predefinito in modo che per le rotte private venga utilizzato ora l'intervallo di IP `172.17.0.0/16`. Se ti affidi alla creazione di contenitori Docker nei nodi di lavoro eseguendo direttamente i comandi `docker` sull'host o utilizzando un pod che monta il socket Docker, scegli tra le seguenti opzioni. <ul><li>Per garantire la connettività di rete esterna quando crei il contenitore, esegui `docker build . --network host`.</li>
<li>Per creare esplicitamente una rete da utilizzare quando crei il contenitore, esegui `docker network create` e utilizza quindi questa rete.</li></ul>
**Nota**: hai dipendenze sul socket Docker o direttamente su Docker? [Migra a `containerd` invece di `docker` come runtime del contenitore](cs_versions.html#containerd) in modo che i tuoi cluster siano pronti per eseguire Kubernetes versione 1.11 o successive.</td>
</tr>
</tbody>
</table>

### Changelog per 1.9.10_1523, rilasciato il 4 settembre 2018
{: #1910_1523}

<table summary="Modifiche apportate a partire dalla versione 1.9.9_1522">
<caption>Modifiche a partire dalla versione 1.9.9_1522</caption>
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
<td>v1.9.9-167</td>
<td>v1.9.10-192</td>
<td>Aggiornato per supportare la release Kubernetes 1.9.10. È stata inoltre modificata la configurazione del provider cloud per gestire meglio gli aggiornamenti per i servizi del programma di bilanciamento del carico con `externalTrafficPolicy` impostata su `local`.</td>
</tr>
<tr>
<td>Plug-in di archiviazione file IBM</td>
<td>334</td>
<td>338</td>
<td>La versione di incubator è stata aggiornata alla 1.8. Il provisioning dell'archiviazione file viene eseguito alla specifica zona da te selezionata. Non puoi aggiornare delle etichette di un'istanza PV (statica) esistente a meno che tu non stia utilizzando un cluster multizona e debba aggiungere le etichette di regione e zona.<br><br>È stata rimossa la versione NFS predefinita dalle opzioni di montaggio nelle classi di archiviazione file fornite da IBM. Il sistema operativo dell'host ora negozia la versione NFS con il server NFS dell'infrastruttura IBM Cloud (SoftLayer). Per impostare manualmente una specifica versione NFS, o modificare la versione NFS del tuo PV che era stato negoziato dal sistema operativo dell'host, vedi [Modifica della versione NFS predefinita](cs_storage_file.html#nfs_version_class).</td>
</tr>
<tr>
<td>Kubernetes</td>
<td>v1.9.9</td>
<td>v1.9.10</td>
<td>Vedi le [note sulla release Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/kubernetes/kubernetes/releases/tag/v1.9.10).</td>
</tr>
<tr>
<td>Configurazione di Kubernetes Heapster</td>
<td>N/D</td>
<td>N/D</td>
<td>Sono stati aumentati i limiti di risorsa per il contenitore `heapster-nanny`.</td>
</tr>
</tbody>
</table>

### Changelog per il fix pack di nodo di lavoro 1.9.9_1522, rilasciato il 23 agosto 2018
{: #199_1522}

<table summary="Modifiche apportate a partire dalla versione 1.9.9_1521">
<caption>Modifiche a partire dalla versione 1.9.9_1521</caption>
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
<td>`systemd`</td>
<td>229</td>
<td>230</td>
<td>`systemd` è stato aggiornato per correggere la perdita `cgroup`.</td>
</tr>
<tr>
<td>Kernel</td>
<td>4.4.0-127</td>
<td>4.4.0-133</td>
<td>Le immagini del nodo di lavoro sono state aggiornate con l'aggiornamento kernel per [CVE-2018-3620,CVE-2018-3646 ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://usn.ubuntu.com/3741-1/).</td>
</tr>
</tbody>
</table>


### Changelog per il fix pack di nodo di lavoro 1.9.9_1521, rilasciato il 13 agosto 2018
{: #199_1521}

<table summary="Modifiche apportate a partire dalla versione 1.9.9_1520">
<caption>Modifiche a partire dalla versione 1.9.9_1520</caption>
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
<td>Pacchetti Ubuntu</td>
<td>N/D</td>
<td>N/D</td>
<td>Aggiornamenti ai pacchetti Ubuntu installati.</td>
</tr>
</tbody>
</table>

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
<td>Aggiornato per supportare la release Kubernetes 1.9.8.</td>
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
<td><p>Vedi le [note sulla release Kubernetes![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/kubernetes/kubernetes/releases/tag/v1.9.7). Questa release risolve le vulnerabilità [CVE-2017-1002101 ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002101) e [CVE-2017-1002102 ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002102).</p><p><strong>Nota</strong>: ora `secret`, `configMap`, `downwardAPI` e i volumi previsti sono montati come di sola lettura. In precedenza, le applicazioni potevano scrivere i dati in questi volumi ma il sistema poteva ripristinare i dati automaticamente. Se le tue applicazioni si basano sul comportamento non sicuro precedente, modificale.</p></td>
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

<br />


## Archivio
{: #changelog_archive}

Versioni Kubernetes non supportate:
*  [Versione 1.8](#18_changelog)
*  [Versione 1.7](#17_changelog)

### Changelog versione 1.8 (non supportato)
{: #18_changelog}

Esamina le seguenti modifiche.

### Changelog per il fix pack del nodo di lavoro 1.8.15_1521, rilasciato il 20 settembre 2018
{: #1815_1521}

<table summary="Modifiche apportate a partire dalla versione 1.8.15_1520">
<caption>Modifiche dalla versione 1.8.15_1520</caption>
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
<td>Rotazione dei log</td>
<td>N/D</td>
<td>N/D</td>
<td>Si è passato all'utilizzo dei timer `systemd` anziché `cronjobs` per evitare che `logrotate` non funzioni sui nodi di lavoro che non vengono ricaricati o aggiornati entro 90 giorni. **Nota**: in tutte le versioni precedenti per questa release secondaria, il disco primario si riempie dopo che il lavoro cron ha esito negativo perché i log non vengono ruotati. Il lavoro cron ha esito negativo dopo che il nodo di lavoro resta attivo per 90 giorni senza essere aggiornato o ricaricato. Se i log riempiono l'intero disco primario, il nodo di lavoro entra in uno stato non riuscito. Il nodo di lavoro può essere corretto utilizzando il [comando](cs_cli_reference.html#cs_worker_reload) `ibmcloud ks worker-reload` o il [comando](cs_cli_reference.html#cs_worker_update) `ibmcloud ks worker-update`.</td>
</tr>
<tr>
<td>Componenti di runtime del nodo di lavoro (`kubelet`, `kube-proxy`, `docker`)</td>
<td>N/D</td>
<td>N/D</td>
<td>Sono state rimosse le dipendenze dei componenti di runtime sul disco primario. Questo miglioramento impedisce il malfunzionamento dei nodi di lavoro quando il disco primario viene riempito.</td>
</tr>
<tr>
<td>Scadenza della password root</td>
<td>N/D</td>
<td>N/D</td>
<td>Le password root per i nodi di lavoro scadono dopo 90 giorni per motivi di conformità. Se i tuoi strumenti di automazione devono accedere al nodo di lavoro come root o fanno affidamento su lavori cron eseguiti come root, puoi disabilitare la scadenza della password accedendo al nodo di lavoro ed eseguendo `chage -M -1 root`. **Nota**: se hai requisiti di conformità di sicurezza che impediscono l'esecuzione come root o la rimozione della scadenza della password, non disabilitare la scadenza. Puoi invece [aggiornare](cs_cli_reference.html#cs_worker_update) o [ricaricare](cs_cli_reference.html#cs_worker_reload) i tuoi nodi di lavoro almeno ogni 90 giorni.</td>
</tr>
<tr>
<td>Systemd</td>
<td>N/D</td>
<td>N/D</td>
<td>Elimina periodicamente le unità di montaggio temporanee per evitare che diventino illimitate. Questa azione risolve il [problema di Kubernetes 57345 ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/kubernetes/kubernetes/issues/57345).</td>
</tr>
</tbody>
</table>

### Changelog per il fix pack di nodo di lavoro 1.8.15_1520, rilasciato il 23 agosto 2018
{: #1815_1520}

<table summary="Modifiche apportate a partire dalla versione 1.8.15_1519">
<caption>Modifiche a partire dalla versione 1.8.15_1519</caption>
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
<td>`systemd`</td>
<td>229</td>
<td>230</td>
<td>`systemd` è stato aggiornato per correggere la perdita `cgroup`.</td>
</tr>
<tr>
<td>Kernel</td>
<td>4.4.0-127</td>
<td>4.4.0-133</td>
<td>Le immagini del nodo di lavoro sono state aggiornate con l'aggiornamento kernel per [CVE-2018-3620,CVE-2018-3646 ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://usn.ubuntu.com/3741-1/).</td>
</tr>
</tbody>
</table>

### Changelog per il fix pack di nodo di lavoro 1.8.15_1519, rilasciato il 13 agosto 2018
{: #1815_1519}

<table summary="Modifiche apportate a partire dalla versione 1.8.15_1518">
<caption>Modifiche a partire dalla versione 1.8.15_1518</caption>
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
<td>Pacchetti Ubuntu</td>
<td>N/D</td>
<td>N/D</td>
<td>Aggiornamenti ai pacchetti Ubuntu installati.</td>
</tr>
</tbody>
</table>

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
<td>Aggiornato per supportare la release Kubernetes 1.8.13.</td>
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
<td><p>Vedi le [note sulla release Kubernetes![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/kubernetes/kubernetes/releases/tag/v1.8.11). Questa release risolve le vulnerabilità [CVE-2017-1002101 ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002101) e [CVE-2017-1002102 ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002102).</p><p><strong>Nota</strong>: ora `secret`, `configMap`, `downwardAPI` e i volumi previsti sono montati come di sola lettura. In precedenza, le applicazioni potevano scrivere i dati in questi volumi ma il sistema poteva ripristinare i dati automaticamente. Se le tue applicazioni si basano sul comportamento non sicuro precedente, modificale.</p></td>
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

<br />


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
<td><p>Vedi le [note sulla release Kubernetes![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/kubernetes/kubernetes/releases/tag/v1.7.16). Questa release risolve le vulnerabilità [CVE-2017-1002101 ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002101) e [CVE-2017-1002102 ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-1002102).</p><p><strong>Nota</strong>: ora `secret`, `configMap`, `downwardAPI` e i volumi previsti sono montati come di sola lettura. In precedenza, le applicazioni potevano scrivere i dati in questi volumi ma il sistema poteva ripristinare i dati automaticamente. Se le tue applicazioni si basano sul comportamento non sicuro precedente, modificale.</p></td>
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
