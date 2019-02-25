---

copyright:
  years: 2014, 2018
lastupdated: "2018-12-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:note: .note}
{:important: .important}
{:deprecated: .deprecated}
{:note: .note}
{:important: .important}
{:deprecated: .deprecated}
{:download: .download}



# Informazioni sulla versione e azioni di aggiornamento
{: #cs_versions}

## Tipi di versione Kubernetes
{: #version_types}

{{site.data.keyword.containerlong}} supporta contemporaneamente più versioni di Kubernetes. Quando viene rilasciata una versione più recente (n), sono supportate fino a 2 versioni precedenti (n-2). Le versioni che sono più di 2 precedenti rispetto all'ultima (n-3) sono prima dichiarate obsolete e quindi non più supportate.
{:shortdesc}

**Versioni Kubernetes supportate**:
- Più recente: 1.12.3
- Predefinita: 1.10.11
- Altre: 1.11.5

</br>

**Versioni obsolete**: quando i cluster sono in esecuzione su una versione Kubernetes obsoleta, hai 30 giorni per controllare ed effettuare l'aggiornamento a una versione di Kubernetes supportata prima che la versione non sia più supportata. Durante il periodo di deprecazione, il tuo cluster è ancora funzionante, ma potrebbe richiedere aggiornamenti a una release supportata per correggere le vulnerabilità di sicurezza. Non puoi creare nuovi cluster che utilizzano la versione obsoleta.

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
Server Version: v1.10.11+IKS
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

Man mano che gli aggiornamenti diventano disponibili, ricevi una notifica quando visualizzi le informazioni relative ai nodi di lavoro, ad esempio con i comandi `ibmcloud ks workers <cluster>` o `ibmcloud ks worker-get <cluster> <worker>`.
-  **Aggiornamenti principali e secondari**: per prima cosa, [aggiorna il tuo nodo master](cs_cluster_update.html#master) e poi [aggiorna i nodi di lavoro](cs_cluster_update.html#worker_node).
   - Per impostazione predefinita, non puoi aggiornare un master Kubernetes a più di tre versioni secondarie in avanti. Ad esempio, se la versione corrente del tuo master è 1.9 e vuoi aggiornare alla 1.12, devi prima aggiornare alla 1.10. Puoi forzare l'aggiornamento per continuare, ma l'aggiornamento di più di due versioni secondarie potrebbe causare risultati imprevisti o una condizione di errore.
   - Se utilizzi una versione della CLI `kubectl` che corrisponde almeno alla versione `major.minor` dei tuoi cluster, potresti riscontrare risultati imprevisti. Assicurati di mantenere aggiornate le [versioni della CLI](cs_cli_install.html#kubectl) e dei cluster Kubernetes.
-  **Aggiornamenti patch**: le modifiche tra le patch sono documentate in [Changelog versione](cs_versions_changelog.html). Man mano che gli aggiornamenti diventano disponibili, ricevi una notifica quando visualizzi informazioni sui nodi master e di lavoro nella console {{site.data.keyword.Bluemix_notm}} o nella CLI, ad esempio con i seguenti comandi: `ibmcloud ks clusters`, `cluster-get`, `workers` o `worker-get`.
   - **Patch di nodi di lavoro**: controlla mensilmente per vedere se è disponibile un aggiornamento e usa il [comando](cs_cli_reference.html#cs_worker_update) `ibmcloud ks worker-update` o il [comando](cs_cli_reference.html#cs_worker_reload) `ibmcloud ks worker-reload` per applicare queste patch di sicurezza e del sistema operativo. Nota che durante un aggiornamento o un caricamento, viene ricreata l'immagine della macchina del nodo di lavoro e i dati vengono eliminati se non sono [archiviati all'esterno del nodo di lavoro](cs_storage_planning.html#persistent_storage_overview).
   - **Patch master**: le patch master vengono applicate automaticamente nel corso di diversi giorni, pertanto una versione della patch master potrebbe essere disponibile prima che venga applicata al tuo master. L'automazione degli aggiornamenti ignora anche i cluster che si trovano in uno stato non integro o che hanno operazioni attualmente in corso. Occasionalmente, IBM potrebbe disabilitare gli aggiornamenti automatici per uno specifico fix pack del master, come indicato nel changelog, ad esempio una patch che è necessaria solo se un master viene aggiornato da una versione secondaria a un'altra. In questi casi, puoi scegliere di utilizzare tranquillamente il [comando](cs_cli_reference.html#cs_cluster_update) `ibmcloud ks cluster-update` senza attendere l'applicazione dell'automazione degli aggiornamenti.

</br>

Queste informazioni riassumono gli aggiornamenti che potrebbero avere un impatto sulle applicazioni distribuite quando aggiorni un cluster a una nuova versione dalla versione precedente.
-  [Azioni di preparazione](#cs_v112) per la versione 1.12.
-  [Azioni di preparazione](#cs_v111) per la versione 1.11.
-  [Azioni di preparazione](#cs_v110) per la versione 1.10.
-  [Archiviazione](#k8s_version_archive) di versioni obsolete o non supportate.

<br/>

Per un elenco completo delle modifiche, esamina le seguenti informazioni:
* [Changelog Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG.md).
* [Changelog versione IBM](cs_versions_changelog.html).

</br>

## Versione 1.12
{: #cs_v112}

<p><img src="images/certified_kubernetes_1x12.png" style="padding-right: 10px;" align="left" alt="Questo badge indica la certificazione Kubernetes versione 1.12 per il servizio IBM Cloud Container."/> {{site.data.keyword.containerlong_notm}} è un prodotto certificato Kubernetes per la versione 1.12 con il programma Kubernetes Software Conformance Certification di CNCF. _Kubernetes® è un marchio registrato della Linux Foundation negli Stati Uniti e in altri paesi e viene utilizzato in seguito a una licenza dalla Linux Foundation._</p>

Rivedi le modifiche che potresti dover apportare quando esegui l'aggiornamento dalla precedente versione di Kubernetes alla versione 1.12.
{: shortdesc}

### Aggiorna prima il master
{: #112_before}

La seguente tabella mostra le azioni che devi eseguire prima di aggiornare il master Kubernetes. 
{: shortdesc}

<table summary="Aggiornamenti Kubernetes per la versione 1.12">
<caption>Modifiche da apportare prima di aggiornare il master a Kubernetes 1.12</caption>
<thead>
<tr>
<th>Tipo</th>
<th>Descrizione</th>
</tr>
</thead>
<tbody>
<tr>
<td>Server delle metriche di Kubernetes</td>
<td>Se attualmente hai il `metric-server` di Kubernetes distribuito nel tuo cluster, devi rimuovere il `metric-server` prima di aggiornare il cluster a Kubernetes 1.12. Questa rimozione impedisce i conflitti con il `metric-server` che viene distribuito durante l'aggiornamento.</td>
</tr>
<tr>
<td>Bind del ruolo per l'account di servizio `default` `kube-system`</td>
<td>L'account di servizio di `default` `kube-system` non ha più l'accesso **cluster-admin** all'API Kubernetes. Se distribuisci funzioni o componenti aggiuntivi come [Helm](cs_integrations.html#helm) che richiedono l'accesso ai processi nel tuo cluster, configura un [account di servizio ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/reference/access-authn-authz/service-accounts-admin/). Se hai bisogno di tempo per creare e configurare singoli account di servizio con le autorizzazioni appropriate, puoi concedere temporaneamente il ruolo **cluster-admin** con il seguente bind del ruolo cluster: `kubectl create clusterrolebinding kube-system:default --clusterrole=cluster-admin --serviceaccount=kube-system:default`</td>
</tr>
</tbody>
</table>

### Aggiorna dopo il master
{: #112_after}

La seguente tabella mostra le azioni che devi eseguire dopo aver aggiornato il master Kubernetes. 
{: shortdesc}

<table summary="Aggiornamenti Kubernetes per la versione 1.12">
<caption>Modifiche da apportare dopo aver aggiornato il master a Kubernetes 1.12</caption>
<thead>
<tr>
<th>Tipo</th>
<th>Descrizione</th>
</tr>
</thead>
<tbody>
<tr>
<td>API Kubernetes `apps/v1`</td>
<td>L'API Kubernetes `apps/v1` sostituirà le API `extensions`, `apps/v1beta1` e `apps/v1alpha`. Il progetto Kubernetes sta deprecando ed eliminando gradualmente il supporto per le precedenti API dall'`apiserver` Kubernetes e dal client `kubectl`.<br><br>Devi aggiornare tutti i campi `apiVersion` del tuo YAML per utilizzare `apps/v1`. Inoltre, consulta la [documentazione di Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) per controllare le modifiche relative ad `apps/v1`, come le seguenti.
<ul><li>Dopo la creazione di una distribuzione, il campo `.spec.selector` è immutabile.</li>
<li>Il campo `.spec.rollbackTo` è obsoleto. Utilizza invece il comando `kubectl rollout undo`.</li></ul></td>
</tr>
<tr>
<td>CoreDNS disponibile come provider DNS del cluster</td>
<td>Il progetto Kubernetes è in fase di transizione per supportare CoreDNS anziché il DNS Kubernetes (KubeDNS) corrente. Nella versione 1.12, il DNS predefinito del cluster rimane KubeDNS, ma puoi [scegliere di utilizzare CoreDNS](cs_cluster_update.html#dns).</td>
</tr>
<tr>
<td>`kubectl apply --force`</td>
<td>Adesso, quando forzi un'azione di applicazione (`kubectl apply --force`) sulle risorse che non possono essere aggiornate, come i campi immutabili nei file YAML, le risorse vengono invece ricreate. Se i tuoi script si basano sul comportamento precedente, aggiornarli.</td>
</tr>
<tr>
<td>`kubectl logs --interactive`</td>
<td>L'indicatore `--interactive` non è più supportato per `kubectl logs`. Aggiorna qualsiasi automazione che utilizza questo indicatore.</td>
</tr>
<tr>
<td>`kubectl patch`</td>
<td>Se il comando `patch` non produce alcuna modifica (una patch ridondante), il comando non esce più con un codice di ritorno `1`. Se i tuoi script si basano sul comportamento precedente, aggiornarli.</td>
</tr>
<tr>
<td>`kubectl version -c`</td>
<td>L'indicatore abbreviato `-c` non è più supportato. Utilizza invece l'indicatore completo `--client`. Aggiorna qualsiasi automazione che utilizza questo indicatore.</td>
</tr>
<tr>
<td>`kubectl wait`</td>
<td>Se non vengono trovati selettori corrispondenti, il comando ora stampa un messaggio di errore ed esce con un codice di ritorno `1`. Se i tuoi script si basano sul comportamento precedente, aggiornarli.</td>
</tr>
<tr>
<td>kubelet cAdvisor port</td>
<td>L'interfaccia utente web di [Container Advisor (cAdvisor) ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/google/cadvisor) che kubelet utilizzava avviando `--cadvisor-port` viene rimossa da Kubernetes 1.12. Se hai ancora bisogno di eseguire cAdvisor, [distribuisci cAdvisor come serie di daemon ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/google/cadvisor/tree/master/deploy/kubernetes).<br><br>Nella serie di daemon, specifica la sezione delle porte in modo che sia possibile raggiungere cAdvisor tramite `http://node-ip:4194`, come nel seguente esempio. Nota che i pod cAdvisor non funzionano finché i nodi di lavoro non vengono aggiornati alla 1.12, perché le versioni precedenti di kubelet usano la porta host 4194 per cAdvisor.
<pre class="screen"><code>ports:
          - name: http
            containerPort: 8080
            hostPort: 4194
            protocol: TCP</code></pre></td>
</tr>
<tr>
<td>Dashboard Kubernetes</td>
<td>Se accedi al dashboard tramite `kubectl proxy`, il pulsante **SKIP** nella pagina di accesso viene rimosso. Per accedere, utilizza invece un **Token**.</td>
</tr>
<tr>
<td id="metrics-server">Server delle metriche di Kubernetes</td>
<td>Il server delle metriche di Kubernetes sostituisce Kubernetes Heapster (obsoleto a partire da Kubernetes versione 1.8) come provider di metriche del cluster. Se esegui più di 30 pod per nodo di lavoro nel tuo cluster, [regola la configurazione di `metrics-server` per le prestazioni](cs_performance.html#metrics).
<p>Il dashboard Kubernetes non funziona con il `metrics-server`. Se vuoi visualizzare le metriche in un dashboard, scegli tra le seguenti opzioni.</p>
<ul><li>[Configura Grafana per analizzare le metriche](/docs/services/cloud-monitoring/tutorials/container_service_metrics.html#container_service_metrics) utilizzando il Dashboard di monitoraggio del cluster.</li>
<li>Distribuisci [Heapster ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/kubernetes/heapster) nel tuo cluster.
<ol><li>Copia i file [YAML ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/kubernetes/kubernetes/blob/release-1.12/cluster/addons/cluster-monitoring/heapster-rbac.yaml) `heapster-rbac`, [YAML ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/kubernetes/kubernetes/blob/release-1.12/cluster/addons/cluster-monitoring/standalone/heapster-service.yaml) `heapster-service` e [YAML ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/kubernetes/kubernetes/blob/release-1.12/cluster/addons/cluster-monitoring/standalone/heapster-controller.yaml) `heapster-controller`.</li>
<li>Modifica il file YALM `heapster-controller` sostituendo le seguenti stringhe.
<ul><li>Sostituisci `{{ nanny_memory }}` con `90Mi`</li>
<li>Sostituisci `{{ base_metrics_cpu }}` con `80m`</li>
<li>Sostituisci `{{ metrics_cpu_per_node }}` con `0.5m`</li>
<li>Sostituisci `{{ base_metrics_memory }}` con `140Mi`</li>
<li>Sostituisci `{{ metrics_memory_per_node }}` con `4Mi`</li>
<li>Sostituisci `{{ heapster_min_cluster_size }}` con `16`</li></ul></li>
<li>Applica i file YAML `heapster-rbac`, `heapster-service` e `heapster-controller` al tuo cluster eseguendo il comando `kubectl apply -f`.</li></ol></li></ul></td>
</tr>
<tr>
<td>API Kubernetes `rbac.authorization.k8s.io/v1`</td>
<td>L'API Kubernetes `rbac.authorization.k8s.io/v1` (supportata a partire da Kubernetes 1.8) sostituirà l'API `rbac.authorization.k8s.io/v1alpha1` e `rbac.authorization.k8s.io/v1beta1`. Non puoi più creare oggetti RBAC come i ruoli o i bind del ruolo con l'API `v1alpha` non supportata. Gli oggetti RBAC esistenti vengono convertiti nell'API `v1`.</td>
</tr>
</tbody>
</table>

## Versione 1.11
{: #cs_v111}

<p><img src="images/certified_kubernetes_1x11.png" style="padding-right: 10px;" align="left" alt="Questo badge indica la certificazione Kubernetes versione 1.11 per il servizio IBM Cloud Container."/> {{site.data.keyword.containerlong_notm}} è un prodotto certificato Kubernetes per la versione 1.11 con il programma Kubernetes Software Conformance Certification di CNCF. _Kubernetes® è un marchio registrato della Linux Foundation negli Stati Uniti e in altri paesi e viene utilizzato in seguito a una licenza dalla Linux Foundation._</p>

Riesamina le modifiche che potresti dover apportare quando esegui l'aggiornamento dalla precedente versione di Kubernetes alla versione 1.11.
{: shortdesc}

Prima di poter aggiornare correttamente un cluster da Kubernetes versione 1.9 o precedente alla versione 1.11, devi seguire la procedura illustrata in [Preparazione dell'aggiornamento a Calico v3](#111_calicov3).
{: important}

### Aggiorna prima il master
{: #111_before}

La seguente tabella mostra le azioni che devi eseguire prima di aggiornare il master Kubernetes. 
{: shortdesc}

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
<td>Configurazione dell'alta disponibilità (HA) del master cluster</td>
<td>È stata aggiornata la configurazione del master cluster per aumentare l'alta disponibilità (HA). I cluster ora dispongono di tre repliche del master Kubernetes che vengono configurate con ciascun master distribuito su host fisici separati. Inoltre, se il tuo cluster si trova in una zona che supporta il multizona, i master vengono estesi tra le zone.<br><br>Per le azioni che devi eseguire, vedi [Aggiornamento a master cluster altamente disponibili](#ha-masters). Queste azioni di preparazione si applicano:<ul>
<li>Se hai un firewall o politiche di rete Calico personalizzate.</li>
<li>Se utilizzi le porte host `2040` o `2041` sui tuoi nodi di lavoro.</li>
<li>Se hai utilizzato l'indirizzo IP del master cluster per l'accesso in cluster al master.</li>
<li>Se disponi dell'automazione che richiama l'API o la CLI Calico (`calicoctl`), ad esempio per creare le politiche Calico.</li>
<li>Se utilizzi le politiche di rete di Kubernetes o Calico per controllare l'accesso in uscita dei pod al master.</li></ul></td>
</tr>
<tr>
<td>Nuovo runtime del contenitore Kubernetes `containerd`</td>
<td><p class="important">`containerd` sostituisce Docker come nuovo runtime del contenitore per Kubernetes. Per le azioni che devi eseguire, vedi [Aggiornamento a `containerd` come runtime del contenitore](#containerd).</p></td>
</tr>
<tr>
<td>Crittografia dei dati in etcd</td>
<td>In precedenza, i dati etcd erano archiviati sull'istanza di archiviazione file NFS del master che veniva crittografata quando inattiva. Ora, i dati etcd vengono archiviati sul disco locale del master e sottoposti a backup in {{site.data.keyword.cos_full_notm}}. I dati vengono crittografati durante il transito su {{site.data.keyword.cos_full_notm}} e quando inattivi. Tuttavia, i dati etcd sul disco locale del master non vengono crittografati. Se vuoi che i dati etcd locali del master vengano crittografati, [abilita {{site.data.keyword.keymanagementservicelong_notm}} nel tuo cluster](cs_encrypt.html#keyprotect).</td>
</tr>
<tr>
<td>Propagazione del montaggio del volume del contenitore Kubernetes</td>
<td>Il valore predefinito per il campo [`mountPropagation` ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/concepts/storage/volumes/#mount-propagation) per un `VolumeMount` del contenitore è stato modificato da `HostToContainer` a `None`. Questa modifica ripristina la modalità di funzionamento che esisteva in Kubernetes versione 1.9 e precedente. Se le tue specifiche del pod si basano su `HostToContainer` come valore predefinito, eseguine l'aggiornamento.</td>
</tr>
<tr>
<td>Deserializzatore JSON del server API Kubernetes</td>
<td>Il deserializzatore JSON del server API Kubernetes è ora sensibile a maiuscole/minuscole. Questa modifica ripristina la modalità di funzionamento che esisteva in Kubernetes versione 1.7 e precedente. Se le tue definizioni di risorsa JSON utilizzano maiuscole/minuscole non corrette, procedi ad aggiornarle. <br><br>Sono interessate solo le richieste dirette del server API Kubernetes. La CLI `kubectl` ha continuato a implementare chiavi sensibile a maiuscole/minuscole in Kubernetes versione 1.7 e successive; quindi, se gestisci le tue risorse strettamente con `kubectl`, non sei interessato.</td>
</tr>
</tbody>
</table>

### Aggiorna dopo il master
{: #111_after}

La seguente tabella mostra le azioni che devi eseguire dopo aver aggiornato il master Kubernetes. 
{: shortdesc}

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

### Aggiornamento a master cluster altamente disponibili in Kubernetes 1.11
{: #ha-masters}

Per i cluster che eseguono Kubernetes versione [1.10.8_1530](#110_ha-masters), 1.11.3_1531 o successive, la configurazione del master cluster viene aggiornata per aumentare l'alta disponibilità (HA). I cluster ora dispongono di tre repliche del master Kubernetes che vengono configurate con ciascun master distribuito su host fisici separati. Inoltre, se il tuo cluster si trova in una zona che supporta il multizona, i master vengono estesi tra le zone.
{: shortdesc}

Quando aggiorni il tuo cluster a questa versione di Kubernetes dalla versione 1.9 o una precedente patch di 1.10 o 1.11, devi seguire questi passi di preparazione. Per darti il tempo, gli aggiornamenti automatici del master sono temporaneamente disabilitati. Per ulteriori informazioni e la sequenza temporale, consulta il [post del blog sul master HA](https://www.ibm.com/blogs/bluemix/2018/10/increased-availability-with-ha-masters-in-the-kubernetes-service-actions-you-must-take/).
{: tip}

Esamina le seguenti situazioni in cui devi apportare modifiche per sfruttare appieno la configurazione dei master HA:
* Se hai un firewall o politiche di rete Calico personalizzate.
* Se utilizzi le porte host `2040` o `2041` sui tuoi nodi di lavoro.
* Se hai utilizzato l'indirizzo IP del master cluster per l'accesso in cluster al master.
* Se disponi dell'automazione che richiama l'API o la CLI Calico (`calicoctl`), ad esempio per creare le politiche Calico.
* Se utilizzi le politiche di rete di Kubernetes o Calico per controllare l'accesso in uscita dei pod al master.

<br>
**Aggiornamento del tuo firewall o delle politiche di rete host Calico personalizzate per i master HA**:</br>
{: #ha-firewall}
Se utilizzi un firewall o delle politiche di rete host Calico personalizzate per controllare l'uscita dai tuoi nodi di lavoro, consenti il traffico in uscita alle porte e agli indirizzi IP per tutte le zone all'interno della regione in cui si trova il tuo cluster. Vedi [Concessione al cluster dell'accesso alle risorse dell'infrastruttura e ad altri servizi](cs_firewall.html#firewall_outbound).

<br>
**Riserva delle porte host `2040` e `2041` sui tuoi nodi di lavoro**:</br>
{: #ha-ports}
Per consentire l'accesso al master cluster in una configurazione HA, devi lasciare disponibili le porte host `2040` e `2041` su tutti i nodi di lavoro.
* Aggiorna tutti i pod con `hostPort` impostata su `2040` o `2041` per utilizzare porte diverse.
* Aggiorna tutti i pod con `hostNetwork` impostata su `true` che è in ascolto sulle porte `2040` o `2041` per utilizzare porte diverse.

Per verificare se i tuoi pod stanno attualmente utilizzando le porte `2040` o `2041`, specifica il tuo cluster e immetti il seguente comando.

```
kubectl get pods --all-namespaces -o yaml | grep "hostPort: 204[0,1]"
```
{: pre}

<br>
**Utilizzo dell'IP o del dominio del cluster del servizio `kubernetes` per l'accesso in cluster al master**:</br>
{: #ha-incluster}
Per accedere al master cluster in una configurazione HA all'interno del cluster, utilizza una delle seguenti opzioni:
* L'indirizzo IP del cluster del servizio `kubernetes`, che per impostazione predefinita è: `https://172.21.0.1`
* Il nome di dominio del servizio `kubernetes`, che per impostazione predefinita è: `https://kubernetes.default.svc.cluster.local`

Se in precedenza hai utilizzato l'indirizzo IP del master cluster, questo metodo continua a funzionare. Tuttavia, per una migliore disponibilità, esegui l'aggiornamento per utilizzare l'indirizzo IP o il nome di dominio del cluster del servizio `kubernetes`.

<br>
**Configurazione di Calico per l'accesso fuori dal cluster al master con configurazione HA**:</br>
{: #ha-outofcluster}
I dati archiviati nella mappa di configurazione `calico-config` nello spazio dei nomi `kube-system` vengono modificati per supportare la configurazione del master HA. In particolare, il valore `etcd_endpoints` supporta ora solo l'accesso in cluster. L'utilizzo di questo valore per configurare la CLI di Calico per l'accesso dall'esterno del cluster non funziona più.

Utilizza invece i dati archiviati nella mappa di configurazione `cluster-info` nello spazio dei nomi `kube-system`. In particolare, utilizza i valori `etcd_host` ed `etcd_port` per configurare l'endpoint per la [CLI Calico](cs_network_policy.html#cli_install) per accedere al master con configurazione HA dall'esterno del cluster.

<br>
**Aggiornamento delle politiche di rete di Kubernetes o Calico**:</br>
{: #ha-networkpolicies}
Devi eseguire ulteriori azioni se utilizzi le [politiche di rete di Kubernetes o Calico](cs_network_policy.html#network_policies) per controllare l'accesso in uscita dei pod al master cluster e se attualmente utilizzi:
*  L'IP del cluster del servizio Kubernetes, che puoi ottenere eseguendo `kubectl get service kubernetes -o yaml | grep clusterIP`.
*  Il nome di dominio del servizio Kubernetes, che per impostazione predefinita è `https://kubernetes.default.svc.cluster.local`.
*  L'IP del master cluster, che puoi ottenere eseguendo `kubectl cluster-info | grep Kubernetes`.

I seguenti passi descrivono come aggiornare le tue politiche di rete di Kubernetes. Per aggiornare le politiche di rete di Calico, ripeti questi passi con alcune modifiche minori alla sintassi della politica e con `calicoctl` per cercare le politiche per gli impatti.
{: note}

Prima di iniziare: [accedi al tuo account. Specifica la regione appropriata e, se applicabile, il gruppo di risorse. Imposta il contesto per il tuo cluster](cs_cli_install.html#cs_cli_configure).

1.  Ottieni l'indirizzo IP del tuo master cluster.
    ```
    kubectl cluster-info | grep Kubernetes
    ```
    {: pre}

2.  Cerca le tue politiche di rete Kubernetes per gli impatti. Se non viene restituito alcun YAML, il tuo cluster non subisce alcun impatto e non devi apportare ulteriori modifiche.
    ```
    kubectl get networkpolicies --all-namespaces -o yaml | grep <cluster-master-ip>
    ```
    {: pre}

3.  Esamina il file YAML. Ad esempio, se il tuo cluster utilizza la seguente politica di rete Kubernetes per consentire ai pod nello spazio dei nomi `default` di accedere al master cluster tramite l'IP del cluster o l'IP del master cluster del servizio `kubernetes`, dovrai aggiornare la politica.
    ```
    apiVersion: extensions/v1beta1
    kind: NetworkPolicy
    metadata:
      name: all-master-egress
      namespace: default
    spec:
      egress:
      # Allow access to cluster master using kubernetes service cluster IP address
      # or domain name or cluster master IP address.
      - ports:
        - protocol: TCP
        to:
        - ipBlock:
            cidr: 161.202.126.210/32
      # Allow access to Kubernetes DNS in order to resolve the kubernetes service
      # domain name.
      - ports:
        - protocol: TCP
          port: 53
        - protocol: UDP
          port: 53
      podSelector: {}
      policyTypes:
      - Egress
    ```
    {: screen}

4.  Rivedi la politica di rete Kubernetes per consentire l'uscita all'indirizzo IP del proxy master nel cluster `172.20.0.1`. Per ora, mantieni l'indirizzo IP del master cluster. Ad esempio, il precedente esempio di politica di rete cambia come riportato di seguito.

    Se in precedenza hai configurato le tue politiche di uscita per aprire solo il singolo indirizzo IP e la porta per il singolo master Kubernetes, ora utilizza l'intervallo di indirizzi IP del proxy master nel cluster 172.20.0.1/32 e la porta 2040.
    {: tip}

    ```
    apiVersion: extensions/v1beta1
    kind: NetworkPolicy
    metadata:
      name: all-master-egress
      namespace: default
    spec:
      egress:
      # Allow access to cluster master using kubernetes service cluster IP address
      # or domain name.
      - ports:
        - protocol: TCP
        to:
        - ipBlock:
            cidr: 172.20.0.1/32
        - ipBlock:
            cidr: 161.202.126.210/32
      # Allow access to Kubernetes DNS in order to resolve the kubernetes service domain name.
      - ports:
        - protocol: TCP
          port: 53
        - protocol: UDP
          port: 53
      podSelector: {}
      policyTypes:
      - Egress
    ```
    {: screen}

5.  Applica la politica di rete rivista al tuo cluster.
    ```
    kubectl apply -f all-master-egress.yaml
    ```
    {: pre}

6.  Dopo aver completato tutte le [azioni di preparazione](#ha-masters) (inclusi questi passi), [aggiorna il tuo master cluster](cs_cluster_update.html#master) al fix pack del master HA.

7.  Al termine dell'aggiornamento, rimuovi l'indirizzo IP del master cluster dalla politica di rete. Ad esempio, dalla politica di rete precedente, rimuovi le seguenti righe e quindi riapplica la politica.

    ```
    - ipBlock:
        cidr: 161.202.126.210/32
    ```
    {: screen}

    ```
    kubectl apply -f all-master-egress.yaml
    ```
    {: pre}

### Aggiornamento a `containerd` come runtime del contenitore
{: #containerd}

Per i cluster che eseguono Kubernetes versione 1.11 o successive, `containerd` sostituisce Docker come nuovo runtime del contenitore per Kubernetes per migliorare le prestazioni. Se i tuoi pod si basano su Docker come runtime del contenitore Kubernetes, devi aggiornarli per gestire `containerd` come runtime del contenitore. Per ulteriori informazioni, vedi l'[annuncio relativo a containerd di Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/blog/2018/05/24/kubernetes-containerd-integration-goes-ga/).
{: shortdesc}

**Come faccio a sapere se le mie applicazioni si basano su `docker` invece di `containerd`?**<br>
Esempi di volte in cui ti potresti basare su Docker come runtime del contenitore:
*  Se accedi all'API o al Docker Engine direttamente utilizzando contenitori privilegiati, aggiorna i tuoi pod per supportare `containerd` come runtime. Ad esempio, potresti richiamare direttamente il socket Docker per avviare i contenitori o per eseguire altre operazioni di Docker. Il socket Docker è cambiato da `/var/run/docker.sock` a `/run/containerd/containerd.sock`. Il protocollo utilizzato nel socket `containerd` è leggermente diverso da quello usato in Docker. Prova ad aggiornare la tua applicazione al socket `containerd`. Se vuoi continuare a utilizzare il socket Docker, prova a utilizzare [Docker-inside-Docker (DinD) ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://hub.docker.com/_/docker/).
*  Alcuni componenti aggiuntivi di terze parti, come gli strumenti di registrazione e monitoraggio, che installi nel tuo cluster potrebbero basarsi su Docker Engine. Contatta il tuo provider per verificare che gli strumenti siano compatibili con containerd. Possibili casi di utilizzo includono:
   - Il tuo strumento di registrazione potrebbe utilizzare la directory `/var/log/pods/<pod_uuid>/<container_name>/*.log` del contenitore `stderr/stdout` per accedere ai log. In Docker, questa directory è un collegamento simbolico a `/var/data/cripersistentstorage/containers/<container_uuid>/<container_uuid>-json.log` mentre in `containerd` accedi direttamente alla directory senza un collegamento simbolico.
   - Il tuo strumento di monitoraggio accede direttamente al socket Docker. Il socket Docker è cambiato da `/var/run/docker.sock` a `/run/containerd/containerd.sock`.

<br>

**Oltre a basarmi sul runtime, devo eseguire altre azioni di preparazione?**<br>

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

Se stai aggiornando un cluster da Kubernetes versione 1.9 o precedente alla versione 1.11, prepara l'aggiornamento di Calico v3 prima di aggiornare il master. Durante l'aggiornamento master a Kubernetes v1.11, non vengono pianificati nuovi pod o nuove politiche di rete Kubernetes o Calico. La quantità di tempo dell'aggiornamento impedisce nuove variazioni di pianificazione. I cluster piccoli possono impiegare pochi minuti, con pochi minuti extra per ogni 10 nodi. I pod e le politiche di rete esistenti continuano ad essere in esecuzione.
{: shortdesc}

Se stai aggiornando un cluster da Kubernetes versione 1.10 alla versione 1.11, puoi ignorare questi passi perché li hai completati quando hai eseguito l'aggiornamento alla 1.10.
{: note}

Prima di iniziare, il master del cluster e tutti i nodi di lavoro devono eseguire Kubernetes versione 1.8 o 1.9 e deve essere presente almeno un nodo di lavoro.

1.  Verifica che i tuoi pod Calico siano integri.
    ```
    kubectl get pods -n kube-system -l k8s-app=calico-node -o wide
    ```
    {: pre}

2.  Se tutti i pod non sono nello stato **In esecuzione**, elimina il pod e attendi finché non è in uno stato **In esecuzione** prima di continuare. Se il pod non ritorna a uno stato **In esecuzione**:
    1.  Controlla le **Condizioni** e lo **Stato** del nodo di lavoro.
        ```
        ibmcloud ks workers --cluster <cluster_name_or_ID>
        ```
        {: pre}
    2.  Se lo stato del nodo di lavoro non è **Normale**, segui la procedura per il [Debug dei nodi di lavoro](cs_troubleshoot.html#debug_worker_nodes). Ad esempio, uno stato **Critico** o **Sconosciuto** viene spesso risolto [ricaricando il nodo di lavoro](cs_cli_reference.html#cs_worker_reload).

3.  Se generi automaticamente le politiche o altre risorse Calico, aggiorna il tuo strumento di automazione per generare queste risorse con la [sintassi Calico v3 ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://docs.projectcalico.org/v3.1/reference/calicoctl/resources/).

4.  Se utilizzi [strongSwan](cs_vpn.html#vpn-setup) per la connettività VPN, il grafico Helm di strongSwan 2.0.0 non funziona con Calico v3 o Kubernetes 1.11. [Aggiorna strongSwan](cs_vpn.html#vpn_upgrade) al grafico Helm 2.1.0, che è compatibile con le versioni precedenti Calico 2.6 e Kubernetes 1.7, 1.8 e 1.9.

5.  [Aggiorna il tuo master del cluster a Kubernetes v1.11](cs_cluster_update.html#master).

<br />


## Versione 1.10
{: #cs_v110}

<p><img src="images/certified_kubernetes_1x10.png" style="padding-right: 10px;" align="left" alt="Questo badge indica la certificazione Kubernetes versione 1.10 per il servizio IBM Cloud Container."/> {{site.data.keyword.containerlong_notm}} è un prodotto certificato Kubernetes per la versione 1.10 con il programma Kubernetes Software Conformance Certification di CNCF. _Kubernetes® è un marchio registrato della Linux Foundation negli Stati Uniti e in altri paesi e viene utilizzato in seguito a una licenza dalla Linux Foundation._</p>

Rivedi le modifiche che potresti dover apportare quando esegui l'aggiornamento dalla precedente versione di Kubernetes alla versione 1.10.
{: shortdesc}

Prima di poter eseguire correttamente l'aggiornamento a Kubernetes 1.10, devi seguire la procedura indicata in [Preparazione dell'aggiornamento a Calico v3](#110_calicov3).
{: important}

<br/>

### Aggiorna prima il master
{: #110_before}

La seguente tabella mostra le azioni che devi eseguire prima di aggiornare il master Kubernetes. 
{: shortdesc}

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
<td>Configurazione dell'alta disponibilità (HA) del master cluster</td>
<td>È stata aggiornata la configurazione del master cluster per aumentare l'alta disponibilità (HA). I cluster ora dispongono di tre repliche del master Kubernetes che vengono configurate con ciascun master distribuito su host fisici separati. Inoltre, se il tuo cluster si trova in una zona che supporta il multizona, i master vengono estesi tra le zone.<br><br>Per le azioni che devi eseguire, vedi [Aggiornamento a master cluster altamente disponibili](#110_ha-masters). Queste azioni di preparazione si applicano:<ul>
<li>Se hai un firewall o politiche di rete Calico personalizzate.</li>
<li>Se utilizzi le porte host `2040` o `2041` sui tuoi nodi di lavoro.</li>
<li>Se hai utilizzato l'indirizzo IP del master cluster per l'accesso in cluster al master.</li>
<li>Se disponi dell'automazione che richiama l'API o la CLI Calico (`calicoctl`), ad esempio per creare le politiche Calico.</li>
<li>Se utilizzi le politiche di rete di Kubernetes o Calico per controllare l'accesso in uscita dei pod al master.</li></ul></td>
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

La seguente tabella mostra le azioni che devi eseguire dopo aver aggiornato il master Kubernetes. 
{: shortdesc}

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
<td>Indicatore `kubectl --show-all, -a`</td>
<td>L'indicatore `--show-all, -a`, che si applicava solo ai comandi pod leggibili (non alle chiamate API), è obsoleto e non è supportato nelle versioni future. L'indicatore viene utilizzato per visualizzare i pod in uno stato terminale. Per tenere traccia delle informazioni su applicazioni e contenitori terminati, [configura l'inoltro dei log nel tuo cluster](cs_health.html#health).</td>
</tr>
<tr>
<td>Volumi di dati API in sola lettura</td>
<td>Ora `secret`, `configMap`, `downwardAPI` e i volumi previsti sono montati in sola lettura.
Precedentemente, le applicazioni potevano scrivere i dati in questi volumi che potevano essere ripristinati
automaticamente dal sistema. Questa modifica è necessaria per correggere
la vulnerabilità di sicurezza [CVE-2017-1002102![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2017-1002102).
Se le tue applicazioni si basano sul comportamento non sicuro precedente, modificale.</td>
</tr>
<tr>
<td>VPN strongSwan</td>
<td>Se utilizzi [strongSwan](cs_vpn.html#vpn-setup) per la connettività VPN e hai eliminato il tuo grafico prima di aggiornare il tuo cluster, puoi ora reinstallare il grafico Helm strongSwan.</td>
</tr>
</tbody>
</table>

### Aggiornamento a master cluster altamente disponibili in Kubernetes 1.10
{: #110_ha-masters}

Per i cluster che eseguono Kubernetes versione 1.10.8_1530, [1.11.3_1531](#ha-masters) o successive, la configurazione del master cluster viene aggiornata per aumentare l'alta disponibilità (HA). I cluster ora dispongono di tre repliche del master Kubernetes che vengono configurate con ciascun master distribuito su host fisici separati. Inoltre, se il tuo cluster si trova in una zona che supporta il multizona, i master vengono estesi tra le zone.
{: shortdesc}

Quando aggiorni il tuo cluster a questa versione di Kubernetes dalla versione 1.9 o una precedente patch di 1.10, devi seguire questi passi di preparazione. Per darti il tempo, gli aggiornamenti automatici del master sono temporaneamente disabilitati. Per ulteriori informazioni e la sequenza temporale, consulta il [post del blog sul master HA](https://www.ibm.com/blogs/bluemix/2018/10/increased-availability-with-ha-masters-in-the-kubernetes-service-actions-you-must-take/).
{: tip}

Esamina le seguenti situazioni in cui devi apportare modifiche per sfruttare appieno la configurazione dei master HA:
* Se hai un firewall o politiche di rete Calico personalizzate.
* Se utilizzi le porte host `2040` o `2041` sui tuoi nodi di lavoro.
* Se hai utilizzato l'indirizzo IP del master cluster per l'accesso in cluster al master.
* Se disponi dell'automazione che richiama l'API o la CLI Calico (`calicoctl`), ad esempio per creare le politiche Calico.
* Se utilizzi le politiche di rete di Kubernetes o Calico per controllare l'accesso in uscita dei pod al master.

<br>
**Aggiornamento del tuo firewall o delle politiche di rete host Calico personalizzate per i master HA**:</br>
{: #110_ha-firewall}
Se utilizzi un firewall o delle politiche di rete host Calico personalizzate per controllare l'uscita dai tuoi nodi di lavoro, consenti il traffico in uscita alle porte e agli indirizzi IP per tutte le zone all'interno della regione in cui si trova il tuo cluster. Vedi [Concessione al cluster dell'accesso alle risorse dell'infrastruttura e ad altri servizi](cs_firewall.html#firewall_outbound).

<br>
**Riserva delle porte host `2040` e `2041` sui tuoi nodi di lavoro**:</br>
{: #110_ha-ports}
Per consentire l'accesso al master cluster in una configurazione HA, devi lasciare disponibili le porte host `2040` e `2041` su tutti i nodi di lavoro.
* Aggiorna tutti i pod con `hostPort` impostata su `2040` o `2041` per utilizzare porte diverse.
* Aggiorna tutti i pod con `hostNetwork` impostata su `true` che è in ascolto sulle porte `2040` o `2041` per utilizzare porte diverse.

Per verificare se i tuoi pod stanno attualmente utilizzando le porte `2040` o `2041`, specifica il tuo cluster e immetti il seguente comando.

```
kubectl get pods --all-namespaces -o yaml | grep "hostPort: 204[0,1]"
```
{: pre}

<br>
**Utilizzo dell'IP o del dominio del cluster del servizio `kubernetes` per l'accesso in cluster al master**:</br>
{: #110_ha-incluster}
Per accedere al master cluster in una configurazione HA all'interno del cluster, utilizza una delle seguenti opzioni:
* L'indirizzo IP del cluster del servizio `kubernetes`, che per impostazione predefinita è: `https://172.21.0.1`
* Il nome di dominio del servizio `kubernetes`, che per impostazione predefinita è: `https://kubernetes.default.svc.cluster.local`

Se in precedenza hai utilizzato l'indirizzo IP del master cluster, questo metodo continua a funzionare. Tuttavia, per una migliore disponibilità, esegui l'aggiornamento per utilizzare l'indirizzo IP o il nome di dominio del cluster del servizio `kubernetes`.

<br>
**Configurazione di Calico per l'accesso fuori dal cluster al master con configurazione HA**:</br>
{: #110_ha-outofcluster}
I dati archiviati nella mappa di configurazione `calico-config` nello spazio dei nomi `kube-system` vengono modificati per supportare la configurazione del master HA. In particolare, il valore `etcd_endpoints` supporta ora solo l'accesso in cluster. L'utilizzo di questo valore per configurare la CLI di Calico per l'accesso dall'esterno del cluster non funziona più.

Utilizza invece i dati archiviati nella mappa di configurazione `cluster-info` nello spazio dei nomi `kube-system`. In particolare, utilizza i valori `etcd_host` ed `etcd_port` per configurare l'endpoint per la [CLI Calico](cs_network_policy.html#cli_install) per accedere al master con configurazione HA dall'esterno del cluster.

<br>
**Aggiornamento delle politiche di rete di Kubernetes o Calico**:</br>
{: #110_ha-networkpolicies}
Devi eseguire ulteriori azioni se utilizzi le [politiche di rete di Kubernetes o Calico](cs_network_policy.html#network_policies) per controllare l'accesso in uscita dei pod al master cluster e se attualmente utilizzi:
*  L'IP del cluster del servizio Kubernetes, che puoi ottenere eseguendo `kubectl get service kubernetes -o yaml | grep clusterIP`.
*  Il nome di dominio del servizio Kubernetes, che per impostazione predefinita è `https://kubernetes.default.svc.cluster.local`.
*  L'IP del master cluster, che puoi ottenere eseguendo `kubectl cluster-info | grep Kubernetes`.

I seguenti passi descrivono come aggiornare le tue politiche di rete di Kubernetes. Per aggiornare le politiche di rete di Calico, ripeti questi passi con alcune modifiche minori alla sintassi della politica e con `calicoctl` per cercare le politiche per gli impatti.
{: note}

Prima di iniziare: [accedi al tuo account. Specifica la regione appropriata e, se applicabile, il gruppo di risorse. Imposta il contesto per il tuo cluster](cs_cli_install.html#cs_cli_configure).

1.  Ottieni l'indirizzo IP del tuo master cluster.
    ```
    kubectl cluster-info | grep Kubernetes
    ```
    {: pre}

2.  Cerca le tue politiche di rete Kubernetes per gli impatti. Se non viene restituito alcun YAML, il tuo cluster non subisce alcun impatto e non devi apportare ulteriori modifiche.
    ```
    kubectl get networkpolicies --all-namespaces -o yaml | grep <cluster-master-ip>
    ```
    {: pre}

3.  Esamina il file YAML. Ad esempio, se il tuo cluster utilizza la seguente politica di rete Kubernetes per consentire ai pod nello spazio dei nomi `default` di accedere al master cluster tramite l'IP del cluster o l'IP del master cluster del servizio `kubernetes`, dovrai aggiornare la politica.
    ```
    apiVersion: extensions/v1beta1
    kind: NetworkPolicy
    metadata:
      name: all-master-egress
      namespace: default
    spec:
      egress:
      # Allow access to cluster master using kubernetes service cluster IP address
      # or domain name or cluster master IP address.
      - ports:
        - protocol: TCP
        to:
        - ipBlock:
            cidr: 161.202.126.210/32
      # Allow access to Kubernetes DNS in order to resolve the kubernetes service
      # domain name.
      - ports:
        - protocol: TCP
          port: 53
        - protocol: UDP
          port: 53
      podSelector: {}
      policyTypes:
      - Egress
    ```
    {: screen}

4.  Rivedi la politica di rete Kubernetes per consentire l'uscita all'indirizzo IP del proxy master nel cluster `172.20.0.1`. Per ora, mantieni l'indirizzo IP del master cluster. Ad esempio, il precedente esempio di politica di rete cambia come riportato di seguito.

    Se in precedenza hai configurato le tue politiche di uscita per aprire solo il singolo indirizzo IP e la porta per il singolo master Kubernetes, ora utilizza l'intervallo di indirizzi IP del proxy master nel cluster 172.20.0.1/32 e la porta 2040.
    {: tip}

    ```
    apiVersion: extensions/v1beta1
    kind: NetworkPolicy
    metadata:
      name: all-master-egress
      namespace: default
    spec:
      egress:
      # Allow access to cluster master using kubernetes service cluster IP address
      # or domain name.
      - ports:
        - protocol: TCP
        to:
        - ipBlock:
            cidr: 172.20.0.1/32
        - ipBlock:
            cidr: 161.202.126.210/32
      # Allow access to Kubernetes DNS in order to resolve the kubernetes service domain name.
      - ports:
        - protocol: TCP
          port: 53
        - protocol: UDP
          port: 53
      podSelector: {}
      policyTypes:
      - Egress
    ```
    {: screen}

5.  Applica la politica di rete rivista al tuo cluster.
    ```
    kubectl apply -f all-master-egress.yaml
    ```
    {: pre}

6.  Dopo aver completato tutte le [azioni di preparazione](#ha-masters) (inclusi questi passi), [aggiorna il tuo master cluster](cs_cluster_update.html#master) al fix pack del master HA.

7.  Al termine dell'aggiornamento, rimuovi l'indirizzo IP del master cluster dalla politica di rete. Ad esempio, dalla politica di rete precedente, rimuovi le seguenti righe e quindi riapplica la politica.

    ```
    - ipBlock:
        cidr: 161.202.126.210/32
    ```
    {: screen}

    ```
    kubectl apply -f all-master-egress.yaml
    ```
    {: pre}

### Preparazione dell'aggiornamento a Calico v3
{: #110_calicov3}

Prima di iniziare, il tuo master del cluster e tutti i nodi di lavoro devono essere in esecuzione alla versione Kubernetes 1.8 o successive e devono avere almeno un nodo di lavoro.
{: shortdesc}

Prepara l'aggiornamento a Calico v3 prima di aggiornare il master. Durante l'upgrade del master a Kubernetes v1.10, non vengono pianificati nuovi pod o nuove politiche di rete Kubernetes o Calico. La quantità di tempo dell'aggiornamento impedisce nuove variazioni di pianificazione. I cluster piccoli possono impiegare pochi minuti, con pochi minuti extra per ogni 10 nodi. I pod e le politiche di rete esistenti continuano ad essere in esecuzione.
{: important}

1.  Verifica che i tuoi pod Calico siano integri.
    ```
    kubectl get pods -n kube-system -l k8s-app=calico-node -o wide
    ```
    {: pre}

2.  Se tutti i pod non sono nello stato **In esecuzione**, elimina il pod e attendi finché non è in uno stato **In esecuzione** prima di continuare. Se il pod non ritorna a uno stato **In esecuzione**:
    1.  Controlla le **Condizioni** e lo **Stato** del nodo di lavoro.
        ```
        ibmcloud ks workers --cluster <cluster_name_or_ID>
        ```
        {: pre}
    2.  Se lo stato del nodo di lavoro non è **Normale**, segui la procedura per il [Debug dei nodi di lavoro](cs_troubleshoot.html#debug_worker_nodes). Ad esempio, uno stato **Critico** o **Sconosciuto** viene spesso risolto [ricaricando il nodo di lavoro](cs_cli_reference.html#cs_worker_reload).

3.  Se generi automaticamente le politiche o altre risorse Calico, aggiorna il tuo strumento di automazione per generare queste risorse con la [sintassi Calico v3 ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://docs.projectcalico.org/v3.1/reference/calicoctl/resources/).

4.  Se utilizzi [strongSwan](cs_vpn.html#vpn-setup) per la connettività VPN, il grafico Helm strongSwan 2.0.0 non funziona con Calico v3 o Kubernetes 1.10. [Aggiorna strongSwan](cs_vpn.html#vpn_upgrade) al grafico Helm 2.1.0, che è compatibile con le versioni precedenti Calico 2.6 e Kubernetes 1.7, 1.8 e 1.9.

5.  [Aggiorna il tuo master del cluster a Kubernetes v1.10](cs_cluster_update.html#master).

<br />


## Archivio
{: #k8s_version_archive}

Trova una panoramica delle versioni Kubernetes che non sono supportate in {{site.data.keyword.containerlong_notm}}. 
{: shortdesc}

### Versione 1.9 (obsoleta, non supportata dal 27 dicembre 2018)
{: #cs_v19}

<p><img src="images/certified_kubernetes_1x9.png" style="padding-right: 10px;" align="left" alt="Questo badge indica la certificazione Kubernetes versione 1.9 per il servizio IBM Cloud Container."/> {{site.data.keyword.containerlong_notm}} è un prodotto certificato Kubernetes per la versione 1.9 con il programma Kubernetes Software Conformance Certification di CNCF. _Kubernetes® è un marchio registrato della Linux Foundation negli Stati Uniti e in altri paesi e viene utilizzato in seguito a una licenza dalla Linux Foundation._</p>

Rivedi le modifiche che potresti dover apportare quando esegui l'aggiornamento dalla precedente versione di Kubernetes alla versione 1.9.
{: shortdesc}

<br/>

### Aggiorna prima il master
{: #19_before}

La seguente tabella mostra le azioni che devi eseguire prima di aggiornare il master Kubernetes. 
{: shortdesc}

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

La seguente tabella mostra le azioni che devi eseguire dopo aver aggiornato il master Kubernetes. 
{: shortdesc}

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
automaticamente dal sistema. Questa modifica è necessaria per correggere
la vulnerabilità di sicurezza [CVE-2017-1002102](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2017-1002102).
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

### Versione 1.8 (non supportata)
{: #cs_v18}

A partire dal 22 settembre 2018, i cluster {{site.data.keyword.containerlong_notm}} che eseguono [Kubernetes versione 1.8](cs_versions_changelog.html#changelog_archive) non sono supportati. I cluster della versione 1.8 non possono ricevere aggiornamenti di sicurezza o supporto a meno che non vengano aggiornati alla versione successiva più recente ([Kubernetes 1.9](#cs_v19)).
{: shortdesc}

[Esamina il potenziale impatto](cs_versions.html#cs_versions) di ogni aggiornamento della versione di Kubernetes e quindi [aggiorna i tuoi cluster](cs_cluster_update.html#update) immediatamente almeno alla 1.9.

### Versione 1.7 (non supportata)
{: #cs_v17}

A partire dal 21 giugno 2018, i cluster {{site.data.keyword.containerlong_notm}} che eseguono [Kubernetes versione 1.7](cs_versions_changelog.html#changelog_archive) non sono supportati. I cluster della versione 1.7 non possono ricevere aggiornamenti di sicurezza o supporto a meno che non vengano aggiornati alla versione supportata più recente ([Kubernetes 1.9](#cs_v19)).
{: shortdesc}

[Esamina il potenziale impatto](cs_versions.html#cs_versions) di ogni aggiornamento della versione di Kubernetes e quindi [aggiorna i tuoi cluster](cs_cluster_update.html#update) immediatamente almeno alla 1.9.

### Versione 1.5 (non supportata)
{: #cs_v1-5}

A partire dal 4 aprile 2018, i cluster {{site.data.keyword.containerlong_notm}} che eseguono [Kubernetes versione 1.5](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.5.md) non sono supportati. I cluster della versione 1.5 non possono ricevere aggiornamenti di sicurezza o supporto.
{: shortdesc}

Per continuare ad eseguire le tue applicazioni in {{site.data.keyword.containerlong_notm}}, [crea un nuovo cluster](cs_clusters.html#clusters) e [distribuisci le tue applicazioni](cs_app.html#app) al nuovo cluster.
