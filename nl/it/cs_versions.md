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



# Azioni di aggiornamento e informazioni sulla versione
{: #cs_versions}

## Tipi di versione Kubernetes
{: #version_types}

{{site.data.keyword.containerlong}} supporta contemporaneamente più versioni di Kubernetes. Quando viene rilasciata una versione più recente (n), sono supportate fino a 2 versioni precedenti (n-2). Le versioni che sono più di 2 precedenti rispetto all'ultima (n-3) sono prima dichiarate obsolete e quindi non più supportate.
{:shortdesc}

**Versioni Kubernetes supportate**:

- Più recente: 1.11.3
- Predefinita: 1.10.8
- Altro: 1.9.10

</br>

**Versioni obsolete**: quando i cluster sono in esecuzione su una versione Kubernetes obsoleta, hai 30 giorni per controllare ed effettuare l'aggiornamento a una versione di Kubernetes supportata prima che la versione non sia più supportata. Durante il periodo di obsolescenza, il tuo cluster continua a essere pienamente supportato. Tuttavia, non puoi creare nuovi cluster che utilizzano la versione obsoleta.

**Versioni non supportate**: se esegui i cluster in una versione Kubernetes che non è supportata, controlla i potenziali impatti per gli aggiornamenti qui di seguito e quindi [aggiorna il cluster](cs_cluster_update.html#update) immediatamente per continuare a ricevere il supporto e gli aggiornamenti di sicurezza importanti.
*  **Attenzione**: se attendi finché il tuo cluster è a tre o più versioni secondarie indietro rispetto a una versione supportata, devi forzare l'aggiornamento e questo potrebbe causare dei risultati non previsti o una condizione di errore.
*  I cluster non supportati non possono aggiungere o ricaricare i nodi di lavoro esistenti.
*  Dopo che lo hai aggiornato a una versione supportata, il tuo cluster può riprendere le normali operazioni e continuare a ricevere supporto.

</br>

Per controllare la versione del server di un cluster, immetti il seguente comando.

```
kubectl version  --short | grep -i server
```
{: pre}

Output di esempio:

```
Server Version: v1.10.8+IKS
```
{: screen}


## Tipi di aggiornamento
{: #update_types}

Per il tuo cluster Kubernetes sono disponibili tre tipi di aggiornamento: principale, secondario e patch.
{:shortdesc}

|Tipo di aggiornamento|Esempi di etichette di versione|Aggiornato da|Impatto
|-----|-----|-----|-----|
|Principale|1.x.x|Tu|Modifiche di funzionamento per i cluster, inclusi script o distribuzioni|
|Secondario|x.9.x|Tu|Modifiche di funzionamento per i cluster, inclusi script o distribuzioni|
|Patch|x.x.4_1510|IBM e tu|Patch Kubernetes e altri aggiornamenti del componente {{site.data.keyword.Bluemix_notm}} Provider come patch di sicurezza e del sistema operativo. IBM aggiorna i master automaticamente, ma tu applichi le patch ai nodi di lavoro. Vedi ulteriori informazioni sulle patch nella seguente sezione.|
{: caption="Impatti degli aggiornamenti di Kubernetes" caption-side="top"}

Quando gli aggiornamenti diventano disponibili, ricevi una notifica quando visualizzi le informazioni relative ai nodi di lavoro, ad esempio con i comandi `ibmcloud ks workers <cluster>` o `ibmcloud ks worker-get <cluster> <worker>`.
-  **Aggiornamenti principali e secondari**: per prima cosa, [aggiorna il tuo nodo master](cs_cluster_update.html#master) e poi [aggiorna i nodi di lavoro](cs_cluster_update.html#worker_node).
   - Per impostazione predefinita, non puoi aggiornare un master Kubernetes a più di tre versioni secondarie in avanti. Ad esempio, se la versione corrente del tuo master è 1.7 e vuoi aggiornare alla 1.10, devi prima aggiornare alla 1.9. Puoi forzare l'aggiornamento per continuare, ma l'aggiornamento di più di due versioni secondarie potrebbe causare risultati imprevisti o una condizione di errore.
   - Se utilizzi una versione della CLI `kubectl` che non corrisponde almeno alla versione `major.minor` dei tuoi cluster, potresti riscontrare risultati imprevisti. Assicurati di mantenere aggiornate le [versioni della CLI](cs_cli_install.html#kubectl) e dei cluster Kubernetes.
-  **Aggiornamenti patch**: le modifiche tra le patch sono documentate in [Changelog versione](cs_versions_changelog.html). Quando gli aggiornamenti diventano disponibili, ricevi una notifica quando visualizzi informazioni sui nodi master e di lavoro nella GUI o nella CLI, ad esempio con i seguenti comandi: `ibmcloud ks clusters`, `cluster-get`, `workers` o `worker-get`.
   - **Patch di nodi di lavoro**: controlla mensilmente per vedere se è disponibile un aggiornamento e usa il [comando](cs_cli_reference.html#cs_worker_update) `ibmcloud ks worker-update` o il [comando](cs_cli_reference.html#cs_worker_reload) `ibmcloud ks worker-reload` per applicare queste patch di sicurezza e del sistema operativo.
   - **Patch master**: le patch master vengono applicate automaticamente nel corso di diversi giorni, pertanto una versione della patch master potrebbe essere disponibile prima che venga applicata al tuo master. L'automazione degli aggiornamenti ignora anche i cluster che si trovano in uno stato non integro o che hanno operazioni attualmente in corso. Occasionalmente, IBM potrebbe disabilitare gli aggiornamenti automatici per uno specifico fix pack del master, come indicato nel changelog, ad esempio una patch che è necessaria solo se un master viene aggiornato da una versione secondaria a un'altra. In questi casi, puoi scegliere di utilizzare tranquillamente il [comando](cs_cli_reference.html#cs_cluster_update) `ibmcloud ks cluster-update` senza attendere l'applicazione dell'automazione degli aggiornamenti.

</br>

Queste informazioni riassumono gli aggiornamenti che potrebbero avere un impatto sulle applicazioni distribuite quando aggiorni un cluster a una nuova versione dalla versione precedente.
-  [Azioni di migrazione](#cs_v111) Versione 1.11.
-  [Azioni di migrazione](#cs_v110) Versione 1.10.
-  [Azioni di migrazione](#cs_v19) Versione 1.9.
-  [Archiviazione](#k8s_version_archive) di versioni obsolete o non supportate.

<br/>

Per un elenco completo delle modifiche, esamina le seguenti informazioni:
* [Changelog Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG.md).
* [Changelog versione IBM](cs_versions_changelog.html).

</br>

## Versione 1.11
{: #cs_v111}

<p><img src="images/certified_kubernetes_1x11.png" style="padding-right: 10px;" align="left" alt="Questo badge indica che la certificazione Kubernetes versione 1.11 per IBM Cloud Container Service."/> {{site.data.keyword.containerlong_notm}} è un prodotto certificato Kubernetes per la versione 1.11 in base al programma CNCF Kubernetes Software Conformance Certification. _Kubernetes® è un marchio registrato della Linux Foundation negli Stati Uniti e in altri paesi e viene utilizzato in seguito a una licenza dalla Linux Foundation._</p>

Riesamina le modifiche che potresti dover apportare quando esegui l'aggiornamento dalla precedente versione di Kubernetes alla versione 1.11.

**Importante**:
prima di poter aggiornare correttamente un cluster da Kubernetes versione 1.9 o precedente alla versione 1.11, devi seguire la procedura illustrata in [Preparazione dell'aggiornamento a Calico v3](#111_calicov3).

### Aggiorna prima il master
{: #111_before}

<table summary="Aggiornamenti Kubernetes per la versione 1.11">
<caption>Modifiche da apportare prima di aggiornare il master a Kubernetes 1.11</caption>
<thead>
<tr>
<th>Tipo</th>
<th>Descrizione</th>
</tr>
</thead>
<tbody>
<tr>
<td>Nuovo runtime del contenitore Kubernetes `containerd`</td>
<td><strong>Importante</strong>: `containerd` sostituisce Docker come nuovo runtime del contenitore per Kubernetes. Per le azioni che devi eseguire, vedi [Migrazione a `containerd` come runtime del contenitore](#containerd).</td>
</tr>
<tr>
<td>Propagazione del montaggio del volume del contenitore Kubernetes</td>
<td>Il valore predefinito per il campo [`mountPropagation` ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/concepts/storage/volumes/#mount-propagation) per un `VolumeMount` del contenitore è stato modificato da `HostToContainer` a `None`. Questa modifica ripristina la modalità di funzionamento che esisteva in Kubernetes versione 1.9 e precedente. Se le tue specifiche del pod si basano su `HostToContainer` come valore predefinito, eseguine l'aggiornamento.</td>
</tr>
<tr>
<td>Deserializzatore JSON del server API Kubernetes</td>
<td>Il deserializzatore JSON del server API Kubernetes è ora sensibile a maiuscole/minuscole. Questa modifica ripristina la modalità di funzionamento che esisteva in Kubernetes versione 1.7 e precedente. Se le tue definizioni di risorsa JSON utilizzano maiuscole/minuscole non corrette, procedi ad aggiornarle. <br><br>**Nota**: sono interessate solo le richieste server API Kubernetes dirette. La CLI `kubectl` ha continuato a implementare chiavi sensibile a maiuscole/minuscole in Kubernetes versione 1.7 e successive; quindi, se gestisci le tue risorse strettamente con `kubectl`, non sei interessato.</td>
</tr>
</tbody>
</table>

### Aggiorna dopo il master
{: #111_after}

<table summary="Aggiornamenti Kubernetes per la versione 1.11">
<caption>Modifiche da apportare dopo aver aggiornato il master a Kubernetes 1.11</caption>
<thead>
<tr>
<th>Tipo</th>
<th>Descrizione</th>
</tr>
</thead>
<tbody>
<tr>
<td>Configurazione della registrazione cluster</td>
<td>Il componente aggiuntivo del cluster `fluentd` viene aggiornato automaticamente con la versione 1.11, anche quando `logging-autoupdate` è disabilitata.<br><br>
La directory del log del contenitore è stata modificata da `/var/lib/docker/` a `/var/log/pods/`. Se utilizzi una tua soluzione di registrazione che monitora la directory precedente, procedi a un aggiornamento in modo conforme.</td>
</tr>
<tr>
<td>Aggiorna la configurazione di Kubernetes</td>
<td>La configurazione di OpenID Connect per il server API Kubernetes del cluster è stata aggiornata per supportare i gruppi di accesso di {{site.data.keyword.Bluemix_notm}} Identity and Access Management (IAM). Come risultato, devi aggiornare la configurazione Kubernetes del tuo cluster dopo l'aggiornamento del master Kubernetes v1.11 eseguendo `ibmcloud ks cluster-config --cluster <cluster_name_or_ID>`. <br><br>Se non aggiorni la configurazione, le azioni del cluster non riescono con il seguente messaggio di errore: `You must be logged in to the server (Unauthorized).`</td>
</tr>
<tr>
<td>`kubectl` CLI</td>
<td>La CLI `kubectl` per Kubernetes versione 1.11 richiede le API `apps/v1`. Come risultato, la CLI `kubectl` v1.11 non funziona per i cluster che eseguono Kubernetes versione 1.8 o precedenti. Utilizza la versione della CLI `kubectl` che corrisponde alla versione del server API Kubernetes del tuo cluster.</td>
</tr>
<tr>
<td>`kubectl auth can-i`</td>
<td>Ora, quando un utente non è autorizzato, il comando `kubectl auth can-i` non riesce con `exit code 1`. Se i tuoi script si basano sulla modalità di funzionamento precedente, aggiornali.</td>
</tr>
<tr>
<td>`kubectl delete`</td>
<td>Ora, quando si eliminano risorse utilizzando criteri di selezione quali le etichette, il comando `kubectl delete` ignora gli errori `not found` per impostazione predefinita. Se i tuoi script si basano sul comportamento precedente, aggiornarli.</td>
</tr>
<tr>
<td>Funzione `sysctls` di Kubernetes</td>
<td>L'annotazione `security.alpha.kubernetes.io/sysctls` viene ora ignorata. Kubernetes ha invece aggiunto dei campi agli oggetti `PodSecurityPolicy` e `Pod` per specificare e controllare `sysctls`. Per ulteriori informazioni, vedi [Using sysctls in Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/tasks/administer-cluster/sysctl-cluster/). <br><br>Dopo che hai aggiornato i nodi di lavoro e il master del cluster, aggiorna i tuoi oggetti `PodSecurityPolicy` e `Pod` per utilizzare i nuovi campi `sysctls`.</td>
</tr>
</tbody>
</table>

### Migrazione a `containerd` come runtime del contenitore
{: #containerd}

Per i cluster che eseguono Kubernetes versione 1.11 o successive, `containerd` sostituisce Docker come nuovo runtime del contenitore per Kubernetes per migliorare le prestazioni. Se i tuoi pod si basano su Docker come runtime del contenitore Kubernetes, devi aggiornarli per gestire `containerd` come runtime del contenitore. Per ulteriori informazioni, vedi l'[annuncio relativo a containerd di Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/blog/2018/05/24/kubernetes-containerd-integration-goes-ga/).
{: shortdesc}

**Come faccio a sapere se le mie applicazioni si basano su `docker` invece di `containerd`?**<br>
Esempi di volte in cui ti potresti basare su Docker come runtime del contenitore:
*  Se accedi all'API o al Docker Engine direttamente utilizzando contenitori privilegiati, aggiorna i tuoi pod per supportare `containerd` come runtime.
*  Alcuni componenti aggiuntivi di terze parti, come gli strumenti di registrazione e monitoraggio, che installi nel tuo cluster potrebbero basarsi su Docker Engine. Contatta il tuo provider per verificare che gli strumenti siano compatibili con `containerd`.

<br>

**Oltre a basarmi sul runtime, devo eseguire altre azioni di migrazione?**<br>

**Strumento manifest**: se hai delle immagini multipiattaforma create con lo strumento sperimentale `docker manifest` [![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://docs.docker.com/edge/engine/reference/commandline/manifest/) prima di Docker versione 18.06, non puoi estrarre l'immagine da DockerHub utilizzando `containerd`.

Quando controlli gli eventi pod, potresti vedere un errore simile al seguente:
```
failed size validation
```
{: screen}

Per utilizzare un'immagine creata utilizzando lo strumento manifest con `containerd`, scegli dalle seguenti opzioni:

*  Ricrea l'immagine con lo [strumento manifest ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/estesp/manifest-tool).
*  Ricrea l'immagine con lo strumento `docker-manifest` dopo che hai eseguito l'aggiornamento a Docker versione 18.06 o successive.

<br>

**Cosa non è influenzato? Devo modificare il modo in cui distribuisco i miei contenitori?**<br>
In generale, i tuoi processi di distribuzione dei contenitori non cambiano. Puoi continuare a utilizzare un Dockerfile per definire un'immagine Docker e creare un contenitore Docker per le tue applicazioni. Se utilizzi i comandi `docker` per creare immagini ed eseguirne il push a un registro, puoi continuare a usare invece i comandi `docker` o `ibmcloud cr`.

### Preparazione dell'aggiornamento a Calico v3
{: #111_calicov3}

**Importante**: se stai aggiornando un cluster da Kubernetes versione 1.9 o precedente alla versione 1.11, prepara l'aggiornamento di Calico v3 prima di aggiornare il master. Durante l'aggiornamento master a Kubernetes v1.11, non vengono pianificati nuovi pod o nuove politiche di rete Kubernetes o Calico. La quantità di tempo dell'aggiornamento impedisce nuove variazioni di pianificazione. I cluster piccoli possono impiegare pochi minuti, con pochi minuti extra per ogni 10 nodi. I pod e le politiche di rete esistenti continuano ad essere in esecuzione.

**Nota**: se stai aggiornando un cluster da Kubernetes versione 1.10 alla versione 1.11, puoi ignorare questi passi perché sono stati già completati quando hai eseguito l'aggiornamento alla 1.10.

Prima di iniziare, il master del cluster e tutti i nodi di lavoro devono eseguire Kubernetes versione 1.8 o 1.9 e deve essere presente almeno un nodo di lavoro.

1.  Verifica che i tuoi pod Calico siano integri.
    ```
    kubectl get pods -n kube-system -l k8s-app=calico-node -o wide
    ```
    {: pre}

2.  Se tutti i pod non sono nello stato **In esecuzione**, elimina il pod e attendi finché non è in uno stato **In esecuzione** prima di continuare.

3.  Se generi automaticamente le politiche o altre risorse Calico, aggiorna il tuo strumento di automazione per generare queste risorse con la [sintassi Calico v3 ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://docs.projectcalico.org/v3.1/reference/calicoctl/resources/).

4.  Se utilizzi [strongSwan](cs_vpn.html#vpn-setup) per la connettività VPN, il grafico Helm di strongSwan 2.0.0 non funziona con Calico v3 o Kubernetes 1.11. [Aggiorna strongSwan](cs_vpn.html#vpn_upgrade) al grafico Helm 2.1.0, che è compatibile con le versioni precedenti Calico 2.6 e Kubernetes 1.7, 1.8 e 1.9.

5.  [Aggiorna il tuo master del cluster a Kubernetes v1.11](cs_cluster_update.html#master).

<br />


## Versione 1.10
{: #cs_v110}

<p><img src="images/certified_kubernetes_1x10.png" style="padding-right: 10px;" align="left" alt="Questo badge indica la certificazione Kubernetes versione 1.10 per il servizio IBM Cloud Container."/> {{site.data.keyword.containerlong_notm}} è un prodotto certificato Kubernetes per la versione 1.10 con il programma Kubernetes Software Conformance Certification di CNCF. _Kubernetes® è un marchio registrato della Linux Foundation negli Stati Uniti e in altri paesi e viene utilizzato in seguito a una licenza dalla Linux Foundation._</p>

Rivedi le modifiche che potresti dover apportare quando esegui l'aggiornamento dalla precedente versione di Kubernetes alla versione 1.10.

**Importante**: prima di poter correttamente eseguire l'aggiornamento a Kubernetes 1.10, devi seguire la procedura elencata in [Preparazione dell'aggiornamento a Calico v3](#110_calicov3).

<br/>

### Aggiorna prima il master
{: #110_before}

<table summary="Aggiornamenti Kubernetes per la versione 1.10">
<caption>Modifiche da apportare prima di aggiornare il master a Kubernetes 1.10</caption>
<thead>
<tr>
<th>Tipo</th>
<th>Descrizione</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico v3</td>
<td>L'aggiornamento della versione Kubernetes 1.10 aggiorna anche Calico da v2.6.5 a v3.1.1. <strong>Importante</strong>: prima di poter correttamente eseguire l'aggiornamento a Kubernetes v1.10, devi seguire la procedura elencata in [Preparazione dell'aggiornamento a Calico v3](#110_calicov3).</td>
</tr>
<tr>
<td>Politica di rete del dashboard Kubernetes</td>
<td>In Kubernetes 1.10, la politica di rete <code>kubernetes-dashboard</code> nello spazio dei nomi <code>kube-system</code> blocca a tutti i pod di accedere al dashboard Kubernetes. Tuttavia, questo <strong>non</strong> influenza la possibilità di accedere al dashboard dalla console {{site.data.keyword.Bluemix_notm}} o utilizzando <code>kubectl proxy</code>. Se un pod necessita dell'accesso al dashboard, puoi aggiungere un'etichetta <code>kubernetes-dashboard-policy: allow</code> a uno spazio dei nomi e poi distribuire il pod allo spazio dei nomi.</td>
</tr>
<tr>
<td>Accesso API Kubelet</td>
<td>L'autorizzazione API Kubelet è ora delegata al <code>server API Kubernetes</code>. L'accesso all'API Kubelet si basa su <code>ClusterRoles</code> che concede l'autorizzazione ad accedere alle risorse secondarie <strong>node</strong>. Per impostazione predefinita, Kubernetes Heapster ha <code>ClusterRole</code> e <code>ClusterRoleBinding</code>. Tuttavia, se l'API Kubelet viene utilizzata da altri utenti o applicazioni, devi concedere loro l'autorizzazione ad utilizzare l'API. Fai riferimento alla documentazione Kubernetes in [Kubelet authorization![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet-authentication-authorization/).</td>
</tr>
<tr>
<td>Suite di cifratura</td>
<td>La suite di cifratura supportata dal <code>server API Kubernetes</code> e dall'API Kubelet è ora limitata a un sottoinsieme con codifica molto elevata (128 bit o più). Se hai risorse o un'automazione esistenti che utilizzano una cifratura meno sicura e che si basano sulle comunicazioni con il <code>server API Kubernetes</code> o l'API Kubelet, abilita una cifratura più elevata prima di aggiornare il master.</td>
</tr>
<tr>
<td>VPN strongSwan</td>
<td>Se utilizzi [strongSwan](cs_vpn.html#vpn-setup) per la connettività VPN, devi rimuovere il grafico prima di aggiornare il cluster eseguendo `helm delete --purge <release_name>`. Una volta completato l'aggiornamento del cluster, reinstalla il grafico Helm strongSwan.</td>
</tr>
</tbody>
</table>

### Aggiorna dopo il master
{: #110_after}

<table summary="Aggiornamenti Kubernetes per la versione 1.10">
<caption>Modifiche da apportare dopo aver aggiornato il master a Kubernetes 1.10</caption>
<thead>
<tr>
<th>Tipo</th>
<th>Descrizione</th>
</tr>
</thead>
<tbody>
<tr>
<td>Calico v3</td>
<td>Quando il cluster viene aggiornato, tutti i dati Calico esistenti applicati al cluster vengono automaticamente migrati per utilizzare la sintassi Calico v3. Per visualizzare, aggiungere o modificare le risorse Calico con la sintassi Calico v3, aggiorna la tua [configurazione della CLI Calico alla versione 3.1.1](#110_calicov3).</td>
</tr>
<tr>
<td>Indirizzo <code>ExternalIP</code> del nodo</td>
<td>Il campo <code>ExternalIP</code> di un nodo è ora impostato sul valore dell'indirizzo IP pubblico del nodo. Controlla e aggiorna tutte le risorse che dipendono da questo valore.</td>
</tr>
<tr>
<td><code>kubectl port-forward</code></td>
<td>Ora quando utilizzi il comando <code>kubectl port-forward</code>, non supporta più l'indicatore <code>-p</code>. Se i tuoi script si basano sul comportamento precedente, aggiornarli per sostituire l'indicatore <code>-p</code> con il nome del pod.</td>
</tr>
<tr>
<td>Volumi di dati API in sola lettura</td>
<td>Ora `secret`, `configMap`, `downwardAPI` e i volumi previsti sono montati in sola lettura.
Precedentemente, le applicazioni potevano scrivere i dati in questi volumi che potevano essere ripristinati
automaticamente dal sistema. Questa azione di migrazione è necessaria per risolvere la vulnerabilità di
sicurezza [CVE-2017-1002102![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2017-1002102).
Se le tue applicazioni si basano sul comportamento non sicuro precedente, modificale.</td>
</tr>
<tr>
<td>VPN strongSwan</td>
<td>Se utilizzi [strongSwan](cs_vpn.html#vpn-setup) per la connettività VPN e hai eliminato il tuo grafico prima di aggiornare il tuo cluster, puoi ora reinstallare il grafico Helm strongSwan.</td>
</tr>
</tbody>
</table>

### Preparazione dell'aggiornamento a Calico v3
{: #110_calicov3}

Prima di iniziare, il tuo master del cluster e tutti i nodi di lavoro devono essere in esecuzione alla versione Kubernetes 1.8 o successive e devono avere almeno un nodo di lavoro.

**Importante**: prepara l'aggiornamento a Calico v3 prima di aggiornare il master. Durante l'upgrade del master a Kubernetes v1.10, non vengono pianificati nuovi pod o nuove politiche di rete Kubernetes o Calico. La quantità di tempo dell'aggiornamento impedisce nuove variazioni di pianificazione. I cluster piccoli possono impiegare pochi minuti, con pochi minuti extra per ogni 10 nodi. I pod e le politiche di rete esistenti continuano ad essere in esecuzione.

1.  Verifica che i tuoi pod Calico siano integri.
    ```
    kubectl get pods -n kube-system -l k8s-app=calico-node -o wide
    ```
    {: pre}

2.  Se tutti i pod non sono nello stato **In esecuzione**, elimina il pod e attendi finché non è in uno stato **In esecuzione** prima di continuare.

3.  Se generi automaticamente le politiche o altre risorse Calico, aggiorna il tuo strumento di automazione per generare queste risorse con la [sintassi Calico v3 ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://docs.projectcalico.org/v3.1/reference/calicoctl/resources/).

4.  Se utilizzi [strongSwan](cs_vpn.html#vpn-setup) per la connettività VPN, il grafico Helm strongSwan 2.0.0 non funziona con Calico v3 o Kubernetes 1.10. [Aggiorna strongSwan](cs_vpn.html#vpn_upgrade) al grafico Helm 2.1.0, che è compatibile con le versioni precedenti Calico 2.6 e Kubernetes 1.7, 1.8 e 1.9.

5.  [Aggiorna il tuo master del cluster a Kubernetes v1.10](cs_cluster_update.html#master).

<br />


## Versione 1.9
{: #cs_v19}

<p><img src="images/certified_kubernetes_1x9.png" style="padding-right: 10px;" align="left" alt="Questo badge indica la certificazione Kubernetes versione 1.9 per il servizio IBM Cloud Container."/> {{site.data.keyword.containerlong_notm}} è un prodotto certificato Kubernetes per la versione 1.9 con il programma Kubernetes Software Conformance Certification di CNCF. _Kubernetes® è un marchio registrato della Linux Foundation negli Stati Uniti e in altri paesi e viene utilizzato in seguito a una licenza dalla Linux Foundation._</p>

Rivedi le modifiche che potresti dover apportare quando esegui l'aggiornamento dalla precedente versione di Kubernetes alla versione 1.9.

<br/>

### Aggiorna prima il master
{: #19_before}

<table summary="Aggiornamenti di Kubernetes per le versioni 1.9">
<caption>Modifiche da apportare prima di aggiornare il master a Kubernetes 1.9</caption>
<thead>
<tr>
<th>Tipo</th>
<th>Descrizione</th>
</tr>
</thead>
<tbody>
<tr>
<td>API di ammissione webhook</td>
<td>L'API di ammissione, che viene utilizzata quando il server API richiama i webhook del controllo di ammissione, viene spostata da <code>admission.v1alpha1</code> a <code>admission.v1beta1</code>. <em>Devi eliminare tutti i webhook esistenti prima di eseguire l'upgrade del tuo cluster</em> e aggiornare i file di configurazione del webhook in modo che utilizzino l'API più recente. Questa modifica non è compatibile con le versioni precedenti.</td>
</tr>
</tbody>
</table>

### Aggiorna dopo il master
{: #19_after}

<table summary="Aggiornamenti di Kubernetes per le versioni 1.9">
<caption>Modifiche da apportare dopo aver aggiornato il master a Kubernetes 1.9</caption>
<thead>
<tr>
<th>Tipo</th>
<th>Descrizione</th>
</tr>
</thead>
<tbody>
<tr>
<td>Output `kubectl`</td>
<td>Ora, quando utilizzi il comando `kubectl` per specificare `-o custom-columns` e la colonna non viene trovata nell'oggetto, vedrai un output di `<none>`.<br>
In precedenza, l'operazione aveva esito negativo e visualizzavi un messaggio di errore `xxx is not found`. Se i tuoi script si basano sul comportamento precedente, aggiornarli.</td>
</tr>
<tr>
<td>`kubectl patch`</td>
<td>Ora, quando non viene effettuata alcuna modifica alla risorsa che è stata corretta, il comando `kubectl patch` ha esito negativo con `exit code 1`. Se i tuoi script si basano sul comportamento precedente, aggiornarli.</td>
</tr>
<tr>
<td>Autorizzazioni del dashboard Kubernetes</td>
<td>Agli utenti viene richiesto di accedere al dashboard Kubernetes con le proprie credenziali per visualizzare le risorse del cluster. L'autorizzazione RBAC `ClusterRoleBinding` predefinita del dashboard Kubernetes è stata rimossa. Per istruzioni, consulta [Avvio del dashboard Kubernetes](cs_app.html#cli_dashboard).</td>
</tr>
<tr>
<td>Volumi di dati API in sola lettura</td>
<td>Ora `secret`, `configMap`, `downwardAPI` e i volumi previsti sono montati in sola lettura.
Precedentemente, le applicazioni potevano scrivere i dati in questi volumi che potevano essere ripristinati
automaticamente dal sistema. Questa azione di migrazione è necessaria per risolvere la vulnerabilità di
sicurezza [CVE-2017-1002102](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2017-1002102).
Se le tue applicazioni si basano sul comportamento non sicuro precedente, modificale.</td>
</tr>
<tr>
<td>Corruzioni e tolleranze</td>
<td>Le corruzioni `node.alpha.kubernetes.io/notReady` e `node.alpha.kubernetes.io/unreachable` sono state modificate rispettivamente in `node.kubernetes.io/not-ready` e `node.kubernetes.io/unreachable`.<br>
Nonostante le corruzioni siano state aggiornate automaticamente, devi aggiornare manualmente le tolleranze per queste corruzioni. Per ogni spazio dei nomi tranne `ibm-system` e `kube-system`, determina se è necessario modificare le tolleranze:<br>
<ul><li><code>kubectl get pods -n &lt;namespace&gt; -o yaml | grep "node.alpha.kubernetes.io/notReady" && echo "Action required"</code></li><li>
<code>kubectl get pods -n &lt;namespace&gt; -o yaml | grep "node.alpha.kubernetes.io/unreachable" && echo "Action required"</code></li></ul><br>
Se viene restituito `Action required`, modifica di conseguenza le tolleranze del pod.</td>
</tr>
<tr>
<td>API di ammissione webhook</td>
<td>Se hai eliminato i webhook esistenti prima di aver aggiornato il cluster, crea nuovi webhook.</td>
</tr>
</tbody>
</table>

<br />



## Archivio
{: #k8s_version_archive}

### Versione 1.8 (non supportata)
{: #cs_v18}

A partire dal 22 settembre 2018, i cluster {{site.data.keyword.containerlong_notm}} che eseguono [Kubernetes versione 1.8](cs_versions_changelog.html#changelog_archive) non sono supportati. I cluster della versione 1.8 non possono ricevere aggiornamenti di sicurezza o supporto a meno che non vengano aggiornati alla versione successiva più recente ([Kubernetes 1.9](#cs_v19)).

[Esamina il potenziale impatto](cs_versions.html#cs_versions) di ogni aggiornamento della versione di Kubernetes e quindi [aggiorna i tuoi cluster](cs_cluster_update.html#update) immediatamente almeno alla 1.9.

### Versione 1.7 (non supportata)
{: #cs_v17}

A partire dal 21 giugno 2018, i cluster {{site.data.keyword.containerlong_notm}} che eseguono [Kubernetes versione 1.7](cs_versions_changelog.html#changelog_archive) non sono supportati. I cluster della versione 1.7 non possono ricevere aggiornamenti di sicurezza o supporto a meno che non vengano aggiornati alla versione supportata più recente ([Kubernetes 1.9](#cs_v19)).

[Esamina il potenziale impatto](cs_versions.html#cs_versions) di ogni aggiornamento della versione di Kubernetes e quindi [aggiorna i tuoi cluster](cs_cluster_update.html#update) immediatamente almeno alla 1.9.

### Versione 1.5 (non supportata)
{: #cs_v1-5}

A partire dal 4 aprile 2018, i cluster {{site.data.keyword.containerlong_notm}} che eseguono [Kubernetes versione 1.5](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.5.md) non sono supportati. I cluster della versione 1.5 non possono ricevere aggiornamenti di sicurezza o supporto.

Per continuare ad eseguire le tue applicazioni in {{site.data.keyword.containerlong_notm}}, [crea un nuovo cluster](cs_clusters.html#clusters) e [migra le tue applicazioni](cs_app.html#app) nel cluster.
