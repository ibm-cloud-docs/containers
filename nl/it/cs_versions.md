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



# Azioni di aggiornamento e informazioni sulla versione
{: #cs_versions}

## Tipi di versione Kubernetes
{: #version_types}

{{site.data.keyword.containerlong}} supporta contemporaneamente più versioni di Kubernetes. Quando viene rilasciata una versione più recente (n), sono supportate fino a 2 versioni precedenti (n-2). Le versioni che sono più di 2 precedenti rispetto all'ultima (n-3) sono prima dichiarate obsolete e quindi non più supportate.
{:shortdesc}

**Versioni Kubernetes supportate**:

- Più recente: 1.10.5
- Predefinita: 1.10.5
- Altro: 1.9.9, 1.8.15

</br>

**Versioni obsolete**: quando i cluster sono in esecuzione su una versione Kubernetes obsoleta, hai 30 giorni per controllare ed effettuare l'aggiornamento a una versione di Kubernetes supportata prima che la versione non sia più supportata. Durante il periodo di obsolescenza, il tuo cluster continua a essere pienamente supportato. Tuttavia, non puoi creare nuovi cluster che utilizzano la versione obsoleta.

**Versioni non supportate**: se esegui i cluster in una versione Kubernetes che non è supportata, [controlla i potenziali impatti](#version_types) per gli aggiornamenti e quindi [aggiorna il cluster](cs_cluster_update.html#update) immediatamente per continuare a ricevere il supporto e gli aggiornamenti di sicurezza importanti. 
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
Server Version: v1.10.5+IKS
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
|Patch|x.x.4_1510|IBM e tu|Patch Kubernetes e altri aggiornamenti del componente {{site.data.keyword.Bluemix_notm}} Provider come patch di sicurezza e del sistema operativo. IBM aggiorna i master automaticamente, ma tu applichi le patch ai nodi di lavoro.|
{: caption="Impatti degli aggiornamenti di Kubernetes" caption-side="top"}

Quando gli aggiornamenti diventano disponibili, ricevi una notifica quando visualizzi le informazioni relative ai nodi di lavoro, ad esempio con i comandi `ibmcloud ks workers <cluster>` o `ibmcloud ks worker-get <cluster> <worker>`.
-  **Aggiornamenti principali e secondari**: per prima cosa, [aggiorna il tuo nodo master](cs_cluster_update.html#master) e poi [aggiorna i nodi di lavoro](cs_cluster_update.html#worker_node).
   - Per impostazione predefinita, non puoi aggiornare un master Kubernetes a più di tre versioni secondarie in avanti. Ad esempio, se il master corrente è la versione 1.5 e vuoi aggiornare a 1.8, devi prima aggiornare a 1.7. Puoi forzare l'aggiornamento per continuare, ma l'aggiornamento di più di due versioni secondarie potrebbe causare risultati imprevisti o una condizione di errore.
   - Se utilizzi una versione della CLI `kubectl` che non corrisponde almeno alla versione `major.minor` dei tuoi cluster, potresti riscontrare risultati imprevisti. Assicurati di mantenere aggiornate le [versioni della CLI](cs_cli_install.html#kubectl) e dei cluster Kubernetes.
-  **Aggiornamenti patch**: controlla mensilmente per vedere se è disponibile un aggiornamento e usa il comando `ibmcloud ks worker-update` [](cs_cli_reference.html#cs_worker_update) o `ibmcloud ks worker-reload` [](cs_cli_reference.html#cs_worker_reload) per applicare queste patch di sicurezza e del sistema operativo. Per ulteriori informazioni, vedi [Changelog versione](cs_versions_changelog.html).

<br/>

Queste informazioni riassumono gli aggiornamenti che potrebbero avere un impatto sulle applicazioni distribuite quando aggiorni un cluster a una nuova versione dalla versione precedente.
-  [Azioni di migrazione](#cs_v110) Versione 1.10.
-  [Azioni di migrazione](#cs_v19) Versione 1.9.
-  [Azioni di migrazione](#cs_v18) Versione 1.8.
-  [Archiviazione](#k8s_version_archive) di versioni obsolete o non supportate.

<br/>

Per un elenco completo delle modifiche, esamina le seguenti informazioni:
* [Changelog Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG.md).
* [Changelog versione IBM](cs_versions_changelog.html).

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
<td>La suite di cifratura supportata dal <code>server API Kubernetes</code> e dall'API Kubelet è ora limitata a un sottoinsieme con codifica molto elevata (128 bit o più). Se hai risorse o un'automazione esistenti che utilizzano una cifratura meno sicura e che si basano sulla comunicazione con il <code>server API Kubernetes</code> o l'API Kubelet, abilita una cifratura più elevata prima di aggiornare il master.</td>
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

Prima di iniziare, il tuo master del cluster e tutti i nodi di lavoro devono essere in esecuzione alla versione Kubernetes 1.8 o successiva e devono avere almeno un nodo di lavoro.

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
<td>Taint e tolleranze</td>
<td>Le taint `node.alpha.kubernetes.io/notReady` e `node.alpha.kubernetes.io/unreachable` sono state modificate rispettivamente in `node.kubernetes.io/not-ready` e `node.kubernetes.io/unreachable`.<br>
Nonostante le taint siano state aggiornate automaticamente, devi aggiornare manualmente le tolleranze per queste taint. Per ogni spazio dei nomi tranne `ibm-system` e `kube-system`, determina se è necessario modificare le tolleranze:<br>
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



## Versione 1.8
{: #cs_v18}

<p><img src="images/certified_kubernetes_1x8.png" style="padding-right: 10px;" align="left" alt="Questo badge indica la certificazione Kubernetes versione 1.8 per il servizio IBM Cloud Container."/> {{site.data.keyword.containerlong_notm}} è un prodotto Kubernetes certificato per la versione 1.8 nel programma CNCF Kubernetes Software Conformance Certification. _Kubernetes® è un marchio registrato della Linux Foundation negli Stati Uniti e in altri paesi e viene utilizzato in seguito a una licenza dalla Linux Foundation._</p>

Rivedi le modifiche che potresti dover apportare quando esegui l'aggiornamento dalla precedente versione di Kubernetes alla versione 1.8.

<br/>

### Aggiorna prima il master
{: #18_before}

<table summary="Aggiornamenti di Kubernetes per le versioni 1.8">
<caption>Modifiche da apportare prima di aggiornare il master a Kubernetes 1.8</caption>
<thead>
<tr>
<th>Tipo</th>
<th>Descrizione</th>
</tr>
</thead>
<tbody>
<tr>
<td>Nessuno</td>
<td>Non sono richieste modifiche prima di aggiornare il master</td>
</tr>
</tbody>
</table>

### Aggiorna dopo il master
{: #18_after}

<table summary="Aggiornamenti di Kubernetes per le versioni 1.8">
<caption>Modifiche da apportare dopo aver aggiornato il master a Kubernetes 1.8</caption>
<thead>
<tr>
<th>Tipo</th>
<th>Descrizione</th>
</tr>
</thead>
<tbody>
<tr>
<td>Accesso al dashboard Kubernetes</td>
<td>L'URL per accedere al dashboard Kubernetes nella versione 1.8 è stato modificato e la procedura di accesso include un nuovo passo di autenticazione. Per ulteriori informazioni, vedi [Accesso al dashboard Kubernetes](cs_app.html#cli_dashboard).</td>
</tr>
<tr>
<td>Autorizzazioni del dashboard Kubernetes</td>
<td>Per forzare gli utenti ad accedere con le proprie credenziali per visualizzare le risorse cluster nella versione 1.8, rimuovi l'autorizzazione RBAC ClusterRoleBinding della versione 1.7. Esegui `kubectl delete clusterrolebinding -n kube-system kubernetes-dashboard`.</td>
</tr>
<tr>
<td>`kubectl delete`</td>
<td>Il comando `kubectl delete` non ridimensiona più gli oggetti API del carico di lavoro, come i pod, prima che l'oggetto venga eliminato. Se richiedi che l'oggetto venga ridimensionato, utilizza [`kubectl scale ` ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/reference/kubectl/overview/#scale) prima di eliminare l'oggetto.</td>
</tr>
<tr>
<td>`kubectl run`</td>
<td>Il comando `kubectl run` deve utilizzare più indicatori per `--env` invece di argomenti separati da virgola. Ad esempio, esegui <code>kubectl run --env &lt;x&gt;=&lt;y&gt; --env &lt;z&gt;=&lt;a&gt;</code> e non <code>kubectl run --env &lt;x&gt;=&lt;y&gt;,&lt;z&gt;=&lt;a&gt;</code>. </td>
</tr>
<tr>
<td>`kubectl stop`</td>
<td>Il comando `kubectl stop` non è più disponibile.</td>
</tr>
<tr>
<td>Volumi di dati API in sola lettura</td>
<td>Ora `secret`, `configMap`, `downwardAPI` e i volumi previsti sono montati in sola lettura.
Precedentemente, le applicazioni potevano scrivere i dati in questi volumi che potevano essere ripristinati
automaticamente dal sistema. Questa azione di migrazione è necessaria per risolvere la vulnerabilità di
sicurezza [CVE-2017-1002102](https://cve.mitre.org/cgi-bin/cvename.cgi?name=2017-1002102).
Se le tue applicazioni si basano sul comportamento non sicuro precedente, modificale.</td>
</tr>
</tbody>
</table>

<br />



## Archivio
{: #k8s_version_archive}

### Versione 1.7 (non supportata)
{: #cs_v17}

A partire dal 21 giugno 2018, i cluster {{site.data.keyword.containershort_notm}} che eseguono [Kubernetes versione 1.7](cs_versions_changelog.html#changelog_archive) non sono supportati. I cluster versione 1.7 non possono ricevere gli aggiornamenti di sicurezza o il supporto a meno che non vengano aggiornati alla versione successiva più recente ([Kubernetes 1.8](#cs_v18)).

[Esamina il potenziale impatto](cs_versions.html#cs_versions) di ogni aggiornamento della versione di Kubernetes e quindi [aggiorna i tuoi cluster](cs_cluster_update.html#update) immediatamente almeno alla 1.8.

### Versione 1.5 (non supportata)
{: #cs_v1-5}

A partire dal 4 aprile 2018, i cluster {{site.data.keyword.containershort_notm}} che eseguono [Kubernetes versione 1.5](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.5.md) non sono supportati. I cluster versione 1.5 non possono ricevere gli aggiornamenti di sicurezza o il supporto a meno che non vengano aggiornati alla versione successiva più recente ([Kubernetes 1.8](#cs_v18)).

[Esamina il potenziale impatto](cs_versions.html#cs_versions) di ogni aggiornamento della versione di Kubernetes e quindi [aggiorna i tuoi cluster](cs_cluster_update.html#update) immediatamente almeno alla 1.8.
