---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-30"

keywords: kubernetes, iks

subcollection: containers

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


# Informazioni sulla versione e azioni di aggiornamento
{: #cs_versions}

## Tipi di versione Kubernetes
{: #version_types}

{{site.data.keyword.containerlong}} supporta contemporaneamente più versioni di Kubernetes. Quando viene rilasciata una versione più recente (n), sono supportate fino a 2 versioni precedenti (n-2). Le versioni che sono più di 2 precedenti rispetto all'ultima (n-3) sono prima dichiarate obsolete e quindi non più supportate.
{:shortdesc}


**Versioni Kubernetes supportate**:
*   Più recente: 1.14.4
*   Predefinita: 1.13.8
*   Altre: 1.12.10

**Versioni Kubernetes obsolete e non supportate**:
*   Obsoleta: N/D
*   Non supportate: 1.5, 1.7, 1.8, 1.9, 1.10, 1.11  

</br>

**Versioni obsolete**: quando i cluster sono in esecuzione su una versione Kubernetes obsoleta, hai un minimo di 45 giorni per controllare ed effettuare l'aggiornamento a una versione di Kubernetes supportata prima che la versione non sia più supportata. Durante il periodo di deprecazione, il tuo cluster è ancora funzionante, ma potrebbe richiedere aggiornamenti a una release supportata per correggere le vulnerabilità di sicurezza. Ad esempio, puoi aggiungere e ricaricare i nodi di lavoro, ma non puoi creare nuovi cluster che utilizzano la versione obsoleta quando la data non supportata dista 45 giorni o meno.

**Versioni non supportate**: se i tuoi cluster eseguono una versione Kubernetes che non è supportata, controlla i seguenti potenziali impatti degli aggiornamenti e, quindi, [aggiorna il cluster](/docs/containers?topic=containers-update#update) immediatamente per continuare a ricevere il supporto e gli importanti aggiornamenti della sicurezza. I cluster non supportati non possono aggiungere o ricaricare i nodi di lavoro esistenti. Puoi appurare se il tuo cluster non è supportato (**unsupported**) esaminando il campo **State** nell'output del comando `ibmcloud ks clusters` oppure nella [console {{site.data.keyword.containerlong_notm}} ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://cloud.ibm.com/kubernetes/clusters).

Se attendi finché il tuo cluster arriva a tre o più versioni secondarie dalla versione più vecchia supportata, non puoi aggiornarlo. Invece, [crea un nuovo cluster](/docs/containers?topic=containers-clusters#clusters), [distribuisci le tue applicazioni](/docs/containers?topic=containers-app#app) nel nuovo cluster ed [elimina](/docs/containers?topic=containers-remove) il cluster non supportato.<br><br>Per evitare questo problema, aggiorna i cluster obsoleti a una versione supportata che non sia precedente alle ultime tre versioni, ad esempio da 1.11 a 1.12, poi esegui l'aggiornamento all'ultima versione, la 1.14. Se i nodi di lavoro eseguono una versione che precede di tre o quattro versioni quella del master, potresti osservare un malfunzionamento dei pod, che assumono stati quali `MatchNodeSelector`, `CrashLoopBackOff` o `ContainerCreating`, finché non aggiorni i nodi di lavoro alla stessa versione del master. Dopo che effettui l'aggiornamento a una versione supportata, il tuo cluster può riprendere le normali operazioni e continuare a ricevere supporto.
{: important}

</br>

Per controllare la versione del server di un cluster, immetti il seguente comando.
```
kubectl version  --short | grep -i server
```
{: pre}

Output di esempio:
```
Server Version: v1.13.8+IKS
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
|Patch|x.x.4_1510|IBM e tu|Patch Kubernetes e altri aggiornamenti del componente {{site.data.keyword.cloud_notm}} Provider come patch di sicurezza e del sistema operativo. IBM aggiorna i master automaticamente, ma tu applichi le patch ai nodi di lavoro. Vedi ulteriori informazioni sulle patch nella seguente sezione.|
{: caption="Impatti degli aggiornamenti di Kubernetes" caption-side="top"}

Quando gli aggiornamenti diventano disponibili, ricevi una notifica quando visualizzi le informazioni relative ai nodi di lavoro, ad esempio con i comandi `ibmcloud ks workers --cluster <cluster>` o `ibmcloud ks worker-get --cluster <cluster> --worker <worker>`.
-  **Aggiornamenti principali e secondari (1.x)**: per prima cosa, [aggiorna il tuo nodo master](/docs/containers?topic=containers-update#master) e poi [aggiorna i nodi di lavoro](/docs/containers?topic=containers-update#worker_node). I nodi di lavoro non possono eseguire una versione principale o secondaria di Kubernetes che sia superiore ai master.
   - Non puoi aggiornare un master Kubernetes a più di tre versioni secondarie in avanti. Ad esempio, se la versione corrente del tuo master è 1.11 e vuoi aggiornarlo alla 1.14, devi prima aggiornarlo alla 1.12.
   - Se utilizzi una versione della CLI `kubectl` che corrisponde almeno alla versione `major.minor` dei tuoi cluster, potresti riscontrare risultati imprevisti. Assicurati di mantenere aggiornate le [versioni della CLI](/docs/containers?topic=containers-cs_cli_install#kubectl) e dei cluster Kubernetes.
-  **Aggiornamenti patch (x.x.4_1510)**: le modifiche tra le patch sono documentate in [Changelog versione](/docs/containers?topic=containers-changelog). Le patch master sono applicate automaticamente ma avvii tu gli aggiornamenti delle patch di nodi di lavoro. I nodi di lavoro possono anche eseguire versioni patch superiori ai master. Man mano che gli aggiornamenti diventano disponibili, ricevi una notifica quando visualizzi informazioni sui nodi master e di lavoro nella console {{site.data.keyword.cloud_notm}} o nella CLI, ad esempio con i seguenti comandi: `ibmcloud ks clusters`, `cluster-get`, `workers` o `worker-get`.
   - **Patch di nodi di lavoro**: controlla mensilmente se sono disponibili aggiornamenti e utilizza il [comando `ibmcloud ks worker-update`](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_update) o il [comando `ibmcloud ks worker-reload`](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_worker_reload) per applicare queste patch di sicurezza e del sistema operativo. Durante un aggiornamento o un caricamento, viene ricreata l'immagine della macchina del nodo di lavoro e i dati vengono eliminati se non sono [archiviati all'esterno del nodo di lavoro](/docs/containers?topic=containers-storage_planning#persistent_storage_overview).
   - **Patch master**: le patch master vengono applicate automaticamente nel corso di diversi giorni, pertanto una versione della patch master potrebbe essere disponibile prima che venga applicata al tuo master. L'automazione degli aggiornamenti ignora anche i cluster che si trovano in uno stato non integro o che hanno operazioni attualmente in corso. Occasionalmente, IBM potrebbe disabilitare gli aggiornamenti automatici per uno specifico fix pack del master, come indicato nel changelog, ad esempio una patch che è necessaria solo se un master viene aggiornato da una versione secondaria a un'altra. In questi casi, puoi scegliere di utilizzare tranquillamente il [comando `ibmcloud ks cluster-update`](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_update) manualmente, senza attendere l'applicazione dell'automazione degli aggiornamenti.

</br>

{: #prep-up}
Queste informazioni riassumono gli aggiornamenti che potrebbero avere un impatto sulle applicazioni distribuite quando aggiorni un cluster a una nuova versione dalla versione precedente.

-  [Azioni di preparazione](#cs_v114) per la versione 1.14.
-  [Azioni di preparazione](#cs_v113) per la versione 1.13.
-  [Azioni di preparazione](#cs_v112) per la versione 1.12.
-  [Archivio](#k8s_version_archive) di versioni non supportate.

<br/>

Per un elenco completo delle modifiche, esamina le seguenti informazioni:
* [Changelog Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG.md).
* [Changelog versione IBM](/docs/containers?topic=containers-changelog).

</br>

## Cronologia delle release
{: #release-history}

La seguente tabella registra la cronologia delle release della versione {{site.data.keyword.containerlong_notm}}. Puoi utilizzare queste informazioni per finalità di pianificazione, ad esempio per stimare i termini temporali generali di quando una specifica release potrebbe diventare non supportata. Dopo che la community Kubernetes ha rilasciato un aggiornamento della versione, il team di IBM inizia un processo di consolidamento e verifica della release per gli ambienti {{site.data.keyword.containerlong_notm}}. Le date di disponibilità e di cessazione del supporto della release dipendono dai risultati di questi test, dagli aggiornamenti della community, dalle patch di sicurezza e delle modifiche della tecnologia tra le versioni. Pianifica di tenere la versione del tuo master cluster e dei tuoi nodi di lavoro aggiornata in base alla politica di supporto della versione `n-2`.
{: shortdesc}

{{site.data.keyword.containerlong_notm}} è stato inizialmente generalmente disponibile con Kubernetes versione 1.5. Le date di release o di cessazione del supporto previste sono soggette a variazioni. Per andare ai passi di preparazione dell'aggiornamento della versione, fai clic sul numero di versione.

Le date contrassegnate con un simbolo che sembra un pugnale (`†`) non sono definitive e sono soggette a variazioni.
{: important}

<table summary="Questa tabella mostra la cronologia delle release per {{site.data.keyword.containerlong_notm}}.">
<caption>Cronologia delle release per {{site.data.keyword.containerlong_notm}}.</caption>
<col width="20%" align="center">
<col width="20%">
<col width="30%">
<col width="30%">
<thead>
<tr>
<th>Supportata?</th>
<th>Versione</th>
<th>{{site.data.keyword.containerlong_notm}}<br>data di rilascio</th>
<th>{{site.data.keyword.containerlong_notm}}<br>data di cessazione del supporto</th>
</tr>
</thead>
<tbody>  
<tr>
  <td><img src="images/checkmark-filled.png" align="left" width="32" style="width:32px;" alt="Questa versione è supportata."/></td>
  <td>[1.14](#cs_v114)</td>
  <td>7 maggio 2019</td>
  <td>Aprile 2020 `†`</td>
</tr>
<tr>
  <td><img src="images/checkmark-filled.png" align="left" width="32" style="width:32px;" alt="Questa versione è supportata."/></td>
  <td>[1.13](#cs_v113)</td>
  <td>05 febbraio 2019</td>
  <td>Gennaio 2020 `†`</td>
</tr>
<tr>
  <td><img src="images/checkmark-filled.png" align="left" width="32" style="width:32px;" alt="Questa versione è supportata."/></td>
  <td>[1.12](#cs_v112)</td>
  <td>07 novembre 2018</td>
  <td>Ottobre 2019 `†`</td>
</tr>
<tr>
  <td><img src="images/close-filled.png" align="left" width="32" style="width:32px;" alt="Questa versione non è supportata."/></td>
  <td>[1.11](#cs_v111)</td>
  <td>14 agosto 2018</td>
  <td>20 luglio 2019</td>
</tr>
<tr>
  <td><img src="images/close-filled.png" align="left" width="32" style="width:32px;" alt="Questa versione non è supportata."/></td>
  <td>[1.10](#cs_v110)</td>
  <td>01 maggio 2018</td>
  <td>16 maggio 2019</td>
</tr>
<tr>
  <td><img src="images/close-filled.png" align="left" width="32" style="width:32px;" alt="Questa versione non è supportata."/></td>
  <td>[1.9](#cs_v19)</td>
  <td>08 febbraio 2018</td>
  <td>27 dicembre 2018</td>
</tr>
<tr>
  <td><img src="images/close-filled.png" align="left" width="32" style="width:32px;" alt="Questa versione non è supportata."/></td>
  <td>[1.8](#cs_v18)</td>
  <td>08 novembre 2017</td>
  <td>22 settembre 2018</td>
</tr>
<tr>
  <td><img src="images/close-filled.png" align="left" width="32" style="width:32px;" alt="Questa versione non è supportata."/></td>
  <td>[1.7](#cs_v17)</td>
  <td>19 settembre 2017</td>
  <td>21 giugno 2018</td>
</tr>
<tr>
  <td><img src="images/close-filled.png" align="left" width="32" style="width:32px;" alt="Questa versione non è supportata."/></td>
  <td>1.6</td>
  <td>N/D</td>
  <td>N/D</td>
</tr>
<tr>
  <td><img src="images/close-filled.png" align="left" width="32" style="width:32px;" alt="Questa versione non è supportata."/></td>
  <td>[1.5](#cs_v1-5)</td>
  <td>23 maggio 2017</td>
  <td>04 aprile 2018</td>
</tr>
</tbody>
</table>

<br />


## Versione 1.14
{: #cs_v114}

<p><img src="images/certified_kubernetes_1x14.png" style="padding-right: 10px;" align="left" alt="Questo badge indica la certificazione Kubernetes versione 1.14 per {{site.data.keyword.containerlong_notm}}."/> {{site.data.keyword.containerlong_notm}} è un prodotto certificato Kubernetes per la versione 1.14 secondo il programma Kubernetes Software Conformance Certification di CNCF. _Kubernetes® è un marchio registrato della Linux Foundation negli Stati Uniti e in altri paesi e viene utilizzato in seguito a una licenza dalla Linux Foundation._</p>

Riesamina le modifiche che potresti dover apportare quando esegui l'aggiornamento dalla precedente versione di Kubernetes alla versione 1.14.
{: shortdesc}

Kubernetes 1.14 introduce nuove funzionalità da esplorare. Prova il nuovo [progetto `kustomize` ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/kubernetes-sigs/kustomize) che puoi utilizzare per facilitare la scrittura, la personalizzazione e il riuso delle configurazioni YAML delle risorse Kubernetes. Oppure consulta la nuova [documentazione della CLI `kubectl` ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubectl.docs.kubernetes.io/).
{: tip}

### Aggiorna prima del master
{: #114_before}

La seguente tabella mostra le azioni che devi eseguire prima di aggiornare il master Kubernetes.
{: shortdesc}

<table summary="Aggiornamenti Kubernetes per la versione 1.14">
<caption>Modifiche da apportare prima di aggiornare il master a Kubernetes 1.14</caption>
<thead>
<tr>
<th>Tipo</th>
<th>Descrizione</th>
</tr>
</thead>
<tbody>
<tr>
<td>Modifica della struttura della directory del log dei pod CRI</td>
<td>L'interfaccia di runtime del contenitore (CRI) ha modificato la struttura della directory del log dei pod da `/var/log/pods/<UID>` a `/var/log/pods/<NAMESPACE_NAME_UID>`. Se le tue applicazioni escludono Kubernetes e la CRI per accedere direttamente ai log dei pod sui nodi di lavoro, aggiornarle in modo che gestiscano entrambe le strutture delle directory. Questa modifica non influisce sull'accesso ai log dei pod tramite Kubernetes, ad esempio tramite `kubectl logs`.</td>
</tr>
<tr>
<td>I controlli dell'integrazione non seguono più i reindirizzamenti</td>
<td>Le analisi di attività e disponibilità del controllo dell'integrità che utilizzano un `HTTPGetAction` non seguono più i reindirizzamenti ai nomi host diversi dalla richiesta di analisi originale. Questi reindirizzamenti non locali restituiscono invece una risposta `Success` e viene generato un evento con motivazione `ProbeWarning` per indicare che il reindirizzamento è stato ignorato. Se in precedenza per eseguire i controlli dell'integrità per i vari endpoint dei nomi host ti affidavi al reindirizzamento, devi eseguire la logica del controllo di integrità al di fuori del `kubelet`. Ad esempio, invece di reindirizzare la richiesta di analisi potresti delegare l'endpoint esterno.</td>
</tr>
<tr>
<td>Non supportato: provider DNS del cluster KubeDNS</td>
<td>CoreDNS è ora l'unico provider DNS del cluster supportato per i cluster che eseguono Kubernetes versione 1.14 e successive. Se aggiorni alla versione 1.14 un cluster esistente che utilizza KubeDNS come provider DNS del cluster, durante l'aggiornamento KubeDNS viene migrato automaticamente a CoreDNS. Quindi, prima di aggiornare il cluster, valuta la possibilità di [configurare CoreDNS come provider DNS del cluster](/docs/containers?topic=containers-cluster_dns#set_coredns) e verificarlo. Ad esempio, se la tua applicazione si basa su un client DNS meno recente, potresti dover [aggiornare l'applicazione o personalizzare CoreDNS](/docs/containers?topic=containers-cs_troubleshoot_network#coredns_issues).<br><br>CoreDNS supporta la [specifica del DNS del cluster ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/kubernetes/dns/blob/master/docs/specification.md#25---records-for-external-name-services) per immettere un nome dominio come campo `ExternalName` del servizio Kubernetes. Il provider di DNS del cluster precedente, KubeDNS, non rispetta la specifica DNS del cluster e, pertanto, consente gli indirizzi IP per `ExternalName`. Se qualche servizio Kubernetes utilizza indirizzi IP invece di DNS, devi aggiornare l'`ExternalName` a DNS per la continuazione del funzionamento.</td>
</tr>
<tr>
<td>Non supportato: funzione alpha `Initializers` di Kubernetes</td>
<td>La funzione alpha `Initializers` di Kubernetes, la versione API `admissionregistration.k8s.io/v1alpha1`, il plug-in del controller di ammissione `Initializers` e l'utilizzo del campo API `metadata.initializers` sono stati rimossi. Se utilizzi `Initializers`, passa all'uso di [webhook di ammissione Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/reference/access-authn-authz/extensible-admission-controllers/) ed elimina gli eventuali oggetti API `InitializerConfiguration` esistenti prima di aggiornare il cluster.</td>
</tr>
<tr>
<td>Non supportato: contaminazioni alfa nodi</td>
<td>L'utilizzo delle contaminazioni `node.alpha.kubernetes.io/notReady` e `node.alpha.kubernetes.io/unreachable` non è più supportato. Se ti affidi a queste contaminazioni, aggiorna le tue applicazioni in modo che utilizzino invece le contaminazioni `node.kubernetes.io/not-ready` e `node.kubernetes.io/unreachable`.</td>
</tr>
<tr>
<td>Non supportato: documenti Swagger API Kubernetes</td>
<td>I documenti dell'API degli schemi `swagger/*`, `/swagger.json` e `/swagger-2.0.0.pb-v1` sono stati rimossi e sostituiti dai documenti sull'API dello schema `/openapi/v2`. I documenti su Swagger sono diventati obsoleti nel momento in cui sono stati resi disponibili i documenti OpenAPI in Kubernetes versione 1.10. Inoltre, il server API Kubernetes ora aggrega solo gli schemi OpenAPI dagli endpoint `/openapi/v2` dei server API aggregati. Il fallback da aggregare da `/swagger.json` è stato rimosso. Se hai installato applicazioni che forniscono estensioni API Kubernetes, assicurati che supportino i documenti sull'API dello schema `/openapi/v2`.</td>
</tr>
<tr>
<td>Non supportato e obsoleto: Seleziona metriche</td>
<td>Esamina le metriche [Kubernetes obsolete e rimosse ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.14.md#removed-and-deprecated-metrics). Se utilizzi una qualsiasi di queste metriche obsolete, passa alla metrica sostitutiva disponibile.</td>
</tr>
</tbody>
</table>

### Aggiorna dopo il master
{: #114_after}

La seguente tabella mostra le azioni che devi eseguire dopo aver aggiornato il master Kubernetes.
{: shortdesc}

<table summary="Aggiornamenti Kubernetes per la versione 1.14">
<caption>Modifiche da apportare dopo che aggiorni il master a Kubernetes 1.14</caption>
<thead>
<tr>
<th>Tipo</th>
<th>Descrizione</th>
</tr>
</thead>
<tbody>
<tr>
<td>Non supportato: `kubectl --show-all`</td>
<td>L'indicatore `--show-all` e l'indicatore abbreviato `-a` non sono più supportati. Se i tuoi script si basano su questi indicatori, aggiornali.</td>
</tr>
<tr>
<td>Politiche RBAC predefinite di Kubernetes per gli utenti autenticati</td>
<td>Le politiche RBAC (Role-based Access Control) predefinite di Kubernetes non concedono più l'accesso alle [API di rilevamento e controllo delle autorizzazioni agli utenti non autenticati ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#discovery-roles). Questa modifica si applica solo ai nuovi cluster versione 1.14. Se aggiorni un cluster da una versione precedente, gli utenti non autenticati hanno ancora accesso alle API di rilevamento e controllo delle autorizzazioni. Se vuoi aggiornare il cluster al valore predefinito più sicuro per gli utenti non autenticati, rimuovi il gruppo `system:unauthenticated` del bind dei ruoli del cluster `system:basic-user` e `system:discovery`.</td>
</tr>
<tr>
<td>Obsoleto: query Prometheus che utilizzano le etichette `pod_name` e `container_name`</td>
<td>Aggiorna le query Prometheus che rispondono alle etichette `pod_name` o `container_name` in modo che utilizzino invece le etichette `pod` o `container`. Un esempio di query che potrebbero utilizzare queste etichette obsolete include le metriche di analisi kubelet. Le etichette `pod_name` e `container_name` obsolete diventano non supportate nella release successiva di Kubernetes.</td>
</tr>
</tbody>
</table>

<br />


## Versione 1.13
{: #cs_v113}

<p><img src="images/certified_kubernetes_1x13.png" style="padding-right: 10px;" align="left" alt="Questo badge indica la certificazione Kubernetes versione 1.13 per {{site.data.keyword.containerlong_notm}}."/> {{site.data.keyword.containerlong_notm}} è un prodotto certificato Kubernetes per la versione 1.13 secondo il programma Kubernetes Software Conformance Certification di CNCF. _Kubernetes® è un marchio registrato della Linux Foundation negli Stati Uniti e in altri paesi e viene utilizzato in seguito a una licenza dalla Linux Foundation._</p>

Riesamina le modifiche che potresti dover apportare quando esegui l'aggiornamento dalla precedente versione di Kubernetes alla versione 1.13.
{: shortdesc}

### Aggiorna prima del master
{: #113_before}

La seguente tabella mostra le azioni che devi eseguire prima di aggiornare il master Kubernetes.
{: shortdesc}

<table summary="Aggiornamenti Kubernetes per la versione 1.13">
<caption>Modifiche da apportare prima di aggiornare il master a Kubernetes 1.13</caption>
<thead>
<tr>
<th>Tipo</th>
<th>Descrizione</th>
</tr>
</thead>
<tbody>
<tr>
<td>N/D</td>
<td></td>
</tr>
</tbody>
</table>

### Aggiorna dopo il master
{: #113_after}

La seguente tabella mostra le azioni che devi eseguire dopo aver aggiornato il master Kubernetes.
{: shortdesc}

<table summary="Aggiornamenti Kubernetes per la versione 1.13">
<caption>Modifiche da apportare dopo aver aggiornato il master a Kubernetes 1.13</caption>
<thead>
<tr>
<th>Tipo</th>
<th>Descrizione</th>
</tr>
</thead>
<tbody>
<tr>
<td>CoreDNS disponibile come nuovo provider DNS del cluster predefinito</td>
<td>CoreDNS è ora il provider DNS predefinito per i nuovi cluster in Kubernetes 1.13 e versioni successive. Se aggiorni un cluster esistente alla 1.13 che utilizza KubeDNS come provider DNS del cluster, KubeDNS continua a essere il provider DNS del cluster. Tuttavia, puoi scegliere di [utilizzare invece CoreDNS](/docs/containers?topic=containers-cluster_dns#dns_set). Ad esempio, potresti eseguire un test delle tue applicazioni su CoreDNS in preparazione del prossimo aggiornamento della versione di Kubernetes per assicurarti che non hai bisogno di [aggiornare l'applicazione o personalizzare CoreDNS](/docs/containers?topic=containers-cs_troubleshoot_network#coredns_issues).
<br><br>CoreDNS supporta la [specifica del DNS del cluster ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/kubernetes/dns/blob/master/docs/specification.md#25---records-for-external-name-services) per immettere un nome dominio come campo `ExternalName` del servizio Kubernetes. Il provider di DNS del cluster precedente, KubeDNS, non rispetta la specifica DNS del cluster e, pertanto, consente gli indirizzi IP per `ExternalName`. Se qualche servizio Kubernetes utilizza indirizzi IP invece di DNS, devi aggiornare l'`ExternalName` a DNS per la continuazione del funzionamento.</td>
</tr>
<tr>
<td>Output `kubectl` per `Deployment` e `StatefulSet`</td>
<td>L'output `kubectl` per `Deployment` e `StatefulSet` ora include una colonna `Ready` ed è più leggibile. Se i tuoi script si basano sul comportamento precedente, aggiornarli.</td>
</tr>
<tr>
<td>Output `kubectl` per `PriorityClass`</td>
<td>L'output `kubectl` per `PriorityClass` ora include una colonna `Value`. Se i tuoi script si basano sul comportamento precedente, aggiornarli.</td>
</tr>
<tr>
<td>`kubectl get componentstatuses`</td>
<td>Il comando `kubectl get componentstatuses` non notifica correttamente l'integrità di alcuni componenti master Kubernetes perché tali componenti non sono più accessibili dal server API Kubernetes ora che `localhost` e le porte non sicure (HTTP) sono disabilitate. Dopo l'introduzione dei master altamente disponibili in Kubernetes versione 1.10, ogni master Kubernetes è configurato con più istanze `apiserver`, `controller-manager`, `scheduler` ed `etcd`. Esamina invece l'integrità del cluster controllando la [console {{site.data.keyword.cloud_notm}} ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://cloud.ibm.com/kubernetes/landing) oppure utilizzando il [comando](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_get) `ibmcloud ks cluster-get`.</td>
</tr>
<tr>
<tr>
<td>Non supportato: `kubectl run-container`</td>
<td>Il comando `kubectl run-container` è stato rimosso. Utilizza invece il comando `kubectl run`.</td>
</tr>
<tr>
<td>`kubectl rollout undo`</td>
<td>Quando esegui `kubectl rollout undo` per una revisione che non esiste, viene restituito un errore. Se i tuoi script si basano sul comportamento precedente, aggiornarli.</td>
</tr>
<tr>
<td>Obsoleto: annotazione `scheduler.alpha.kubernetes.io/critical-pod`</td>
<td>L'annotazione `scheduler.alpha.kubernetes.io/critical-pod` è ora obsoleta. Modifica i pod che si basano su questa annotazione per utilizzare invece la [priorità dei pod](/docs/containers?topic=containers-pod_priority#pod_priority).</td>
</tr>
</tbody>
</table>

### Aggiorna dopo i nodi di lavoro
{: #113_after_workers}

La seguente tabella mostra le azioni che devi eseguire dopo che hai aggiornato i tuoi nodi di lavoro.
{: shortdesc}

<table summary="Aggiornamenti Kubernetes per la versione 1.13">
<caption>Modifiche da apportare dopo che hai aggiornato i tuoi nodi di lavoro a Kubernetes 1.13</caption>
<thead>
<tr>
<th>Tipo</th>
<th>Descrizione</th>
</tr>
</thead>
<tbody>
<tr>
<td>containerd `cri` stream server</td>
<td>In containerd versione 1.2, il server di stream del plugin `cri` ora è in ascolto su una porta casuale, `http://localhost:0`. Questa modifica supporta il proxy di streaming `kubelet` e fornisce un'interfaccia di streaming più sicura per le operazioni `exec` e `logs` di contenitore. In precedenza, il server di stream `cri` era in ascolto sull'interfaccia di rete privata del nodo di lavoro utilizzando la porta 10010. Se le tue applicazioni utilizzano il plugin `cri` del contenitore e si basano sulla modalità di funzionamento precedente, eseguine l'aggiornamento.</td>
</tr>
</tbody>
</table>

<br />



## Versione 1.12
{: #cs_v112}

<p><img src="images/certified_kubernetes_1x12.png" style="padding-right: 10px;" align="left" alt="Questo badge indica la certificazione Kubernetes versione 1.12 per il servizio IBM Cloud Container."/> {{site.data.keyword.containerlong_notm}} è un prodotto certificato Kubernetes per la versione 1.12 con il programma Kubernetes Software Conformance Certification di CNCF. _Kubernetes® è un marchio registrato della Linux Foundation negli Stati Uniti e in altri paesi e viene utilizzato in seguito a una licenza dalla Linux Foundation._</p>

Riesamina le modifiche che potresti dover apportare quando esegui l'aggiornamento dalla precedente versione di Kubernetes alla versione 1.12.
{: shortdesc}

### Aggiorna prima del master
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
<td>L'account di servizio di `default` `kube-system` non ha più l'accesso **cluster-admin** all'API Kubernetes. Se distribuisci funzioni o componenti aggiuntivi come [Helm](/docs/containers?topic=containers-helm#public_helm_install) che richiedono l'accesso ai processi nel tuo cluster, configura un [account di servizio ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/reference/access-authn-authz/service-accounts-admin/). Se hai bisogno di tempo per creare e configurare singoli account di servizio con le autorizzazioni appropriate, puoi concedere temporaneamente il ruolo **cluster-admin** con il seguente bind del ruolo cluster: `kubectl create clusterrolebinding kube-system:default --clusterrole=cluster-admin --serviceaccount=kube-system:default`</td>
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
<td>API per Kubernetes</td>
<td>L'API Kubernetes sostituisce le API obsolete nel seguente modo:
<ul><li><strong>apps/v1</strong>: l'API Kubernetes `apps/v1` sostituisce le API `apps/v1beta1` e `apps/v1alpha`. L'API `apps/v1` sostituisce anche l'API `extensions/v1beta1` per le risorse `daemonset`, `deployment`, `replicaset` e `statefulset`. Il progetto Kubernetes sta deprecando ed eliminando gradualmente il supporto per le precedenti API dall'`apiserver` Kubernetes e dal client `kubectl`.</li>
<li><strong>networking.k8s.io/v1</strong>: l'API `networking.k8s.io/v1` sostituisce l'API `extensions/v1beta1` per le risorse NetworkPolicy.</li>
<li><strong>policy/v1beta1</strong>: l'API `policy/v1beta1` sostituisce l'API `extensions/v1beta1` per le risorse `podsecuritypolicy`.</li></ul>
<br><br>Aggiorna tutti i campi `apiVersion` del tuo YAML per utilizzare l'API Kubernetes appropriata prima che le API dichiarate obsolete diventino non supportate. Inoltre, consulta la [documentazione di Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) per controllare le modifiche relative ad `apps/v1`, come le seguenti.
<ul><li>Dopo la creazione di una distribuzione, il campo `.spec.selector` è immutabile.</li>
<li>Il campo `.spec.rollbackTo` è obsoleto. Utilizza invece il comando `kubectl rollout undo`.</li></ul></td>
</tr>
<tr>
<td>CoreDNS disponibile come provider DNS del cluster</td>
<td>Il progetto Kubernetes è in fase di transizione per supportare CoreDNS anziché il DNS Kubernetes (KubeDNS) corrente. Nella versione 1.12, il DNS predefinito del cluster rimane KubeDNS, ma puoi [scegliere di utilizzare CoreDNS](/docs/containers?topic=containers-cluster_dns#dns_set).</td>
</tr>
<tr>
<td>`kubectl apply --force`</td>
<td>Adesso, quando forzi un'azione di applicazione (`kubectl apply --force`) sulle risorse che non possono essere aggiornate, come i campi immutabili nei file YAML, le risorse vengono invece ricreate. Se i tuoi script si basano sul comportamento precedente, aggiornarli.</td>
</tr>
<tr>
<td>`kubectl get componentstatuses`</td>
<td>Il comando `kubectl get componentstatuses` non notifica correttamente l'integrità di alcuni componenti master Kubernetes perché tali componenti non sono più accessibili dal server API Kubernetes ora che `localhost` e le porte non sicure (HTTP) sono disabilitate. Dopo l'introduzione dei master altamente disponibili in Kubernetes versione 1.10, ogni master Kubernetes è configurato con più istanze `apiserver`, `controller-manager`, `scheduler` ed `etcd`. Esamina invece l'integrità del cluster controllando la [console {{site.data.keyword.cloud_notm}} ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://cloud.ibm.com/kubernetes/landing) oppure utilizzando il [comando](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_cluster_get) `ibmcloud ks cluster-get`.</td>
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
<td>L'interfaccia utente web di [Container Advisor (cAdvisor) ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/google/cadvisor) che kubelet utilizzava avviando `--cadvisor-port` viene rimossa da Kubernetes 1.12. Se hai ancora bisogno di eseguire cAdvisor, [distribuisci cAdvisor come serie di daemon ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/google/cadvisor/tree/master/deploy/kubernetes).<br><br>Nella serie di daemon, specifica la sezione delle porte in modo che sia possibile raggiungere cAdvisor tramite `http://node-ip:4194`, come nel seguente esempio. I pod cAdvisor non funzionano finché i nodi di lavoro non vengono aggiornati alla 1.12, perché le versioni precedenti di kubelet usano la porta host 4194 per cAdvisor.
<pre class="screen"><code>ports:
          - name: http
            containerPort: 8080
            hostPort: 4194
            protocol: TCP</code></pre></td>
</tr>
<tr>
<td>Dashboard Kubernetes</td>
<td>Se accedi al dashboard tramite `kubectl proxy`, il pulsante **SKIP** nella pagina di accesso viene rimosso. [Utilizza invece un **Token** per eseguire l'accesso](/docs/containers?topic=containers-app#cli_dashboard).</td>
</tr>
<tr>
<td id="metrics-server">Server delle metriche di Kubernetes</td>
<td>Il server delle metriche di Kubernetes sostituisce Kubernetes Heapster (obsoleto a partire da Kubernetes versione 1.8) come provider di metriche del cluster. Se esegui più di 30 pod per nodo di lavoro nel tuo cluster, [regola la configurazione di `metrics-server` per le prestazioni](/docs/containers?topic=containers-kernel#metrics).
<p>Il dashboard Kubernetes non funziona con il `metrics-server`. Se vuoi visualizzare le metriche in un dashboard, scegli tra le seguenti opzioni.</p>
<ul><li>[Configura Grafana per analizzare le metriche](/docs/services/cloud-monitoring/tutorials?topic=cloud-monitoring-container_service_metrics#container_service_metrics) utilizzando il Dashboard di monitoraggio del cluster.</li>
<li>Distribuisci [Heapster ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/kubernetes/heapster) nel tuo cluster.
<ol><li>Copia i file [YAML ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/kubernetes/kubernetes/blob/release-1.12/cluster/addons/cluster-monitoring/heapster-rbac.yaml) `heapster-rbac`, [YAML ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/kubernetes/kubernetes/blob/release-1.12/cluster/addons/cluster-monitoring/standalone/heapster-service.yaml) `heapster-service` e [YAML ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/kubernetes/kubernetes/blob/release-1.12/cluster/addons/cluster-monitoring/standalone/heapster-controller.yaml) `heapster-controller`.</li>
<li>Modifica il file YAML `heapster-controller` sostituendo le seguenti stringhe.
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

<br />


## Archivio
{: #k8s_version_archive}

Trova una panoramica delle versioni Kubernetes che non sono supportate in {{site.data.keyword.containerlong_notm}}.
{: shortdesc}

### Versione 1.11 (non supportata)
{: #cs_v111}

A partire dal 20 luglio 2019, i cluster {{site.data.keyword.containerlong_notm}} che eseguono [Kubernetes versione 1.11](/docs/containers?topic=containers-changelog#changelog_archive) non sono supportati. I cluster della versione 1.11 non possono ricevere aggiornamenti di sicurezza o supporto a meno che non vengano aggiornati alla versione successiva più recente.
{: shortdesc}

[Riesamina il potenziale impatto](/docs/containers?topic=containers-cs_versions#cs_versions) di ciascun aggiornamento della versione di Kubernetes e [aggiorna quindi i tuoi cluster](/docs/containers?topic=containers-update#update) immediatamente almeno alla 1.12.

### Versione 1.10 (non supportata)
{: #cs_v110}

A partire dal 16 maggio 2019, i cluster {{site.data.keyword.containerlong_notm}} che eseguono [Kubernetes versione 1.10](/docs/containers?topic=containers-changelog#changelog_archive) non sono supportati. I cluster della versione 1.10 non possono ricevere aggiornamenti di sicurezza o supporto a meno che non vengano aggiornati alla versione successiva più recente.
{: shortdesc}

[Riesamina il potenziale impatto](/docs/containers?topic=containers-cs_versions#cs_versions) di ciascun aggiornamento della versione di Kubernetes e [aggiorna quindi i tuoi cluster](/docs/containers?topic=containers-update#update) a [Kubernetes versione 1.12](#cs_v112).

### Versione 1.9 (non supportata)
{: #cs_v19}

A partire dal 27 dicembre 2018, i cluster {{site.data.keyword.containerlong_notm}} che eseguono [Kubernetes versione 1.9](/docs/containers?topic=containers-changelog#changelog_archive) non sono supportati. I cluster della versione 1.9 non possono ricevere aggiornamenti di sicurezza o supporto a meno che non vengano aggiornati alla versione successiva più recente.
{: shortdesc}

Per continuare ad eseguire le tue applicazioni in {{site.data.keyword.containerlong_notm}}, [crea un nuovo cluster](/docs/containers?topic=containers-clusters#clusters) e [distribuisci le tue applicazioni](/docs/containers?topic=containers-app#app) al nuovo cluster.

### Versione 1.8 (non supportata)
{: #cs_v18}

A partire dal 22 settembre 2018, i cluster {{site.data.keyword.containerlong_notm}} che eseguono [Kubernetes versione 1.8](/docs/containers?topic=containers-changelog#changelog_archive) non sono supportati. I cluster della versione 1.8 non possono ricevere aggiornamenti di sicurezza o supporto.
{: shortdesc}

Per continuare ad eseguire le tue applicazioni in {{site.data.keyword.containerlong_notm}}, [crea un nuovo cluster](/docs/containers?topic=containers-clusters#clusters) e [distribuisci le tue applicazioni](/docs/containers?topic=containers-app#app) al nuovo cluster.

### Versione 1.7 (non supportata)
{: #cs_v17}

A partire dal 21 giugno 2018, i cluster {{site.data.keyword.containerlong_notm}} che eseguono [Kubernetes versione 1.7](/docs/containers?topic=containers-changelog#changelog_archive) non sono supportati. I cluster della versione 1.7 non possono ricevere aggiornamenti di sicurezza o supporto.
{: shortdesc}

Per continuare ad eseguire le tue applicazioni in {{site.data.keyword.containerlong_notm}}, [crea un nuovo cluster](/docs/containers?topic=containers-clusters#clusters) e [distribuisci le tue applicazioni](/docs/containers?topic=containers-app#app) al nuovo cluster.

### Versione 1.5 (non supportata)
{: #cs_v1-5}

A partire dal 4 aprile 2018, i cluster {{site.data.keyword.containerlong_notm}} che eseguono [Kubernetes versione 1.5](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.5.md) non sono supportati. I cluster della versione 1.5 non possono ricevere aggiornamenti di sicurezza o supporto.
{: shortdesc}

Per continuare ad eseguire le tue applicazioni in {{site.data.keyword.containerlong_notm}}, [crea un nuovo cluster](/docs/containers?topic=containers-clusters#clusters) e [distribuisci le tue applicazioni](/docs/containers?topic=containers-app#app) al nuovo cluster.
