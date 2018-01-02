---

copyright:
  years: 2014, 2017
lastupdated: "2017-11-03"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# Versioni di Kubernetes per {{site.data.keyword.containerlong_notm}}
{: #cs_versions}

Rivedi le versioni di Kubernetes disponibili in {{site.data.keyword.containerlong}}.
{:shortdesc}

{{site.data.keyword.containershort_notm}} supporta diverse versioni di Kubernetes. La versione predefinita viene utilizzata quando crei o aggiorni un cluster, a meno che non specifichi una versione diversa. Le versioni di Kubernetes disponibili sono:
- 1.8.2
- 1.7.4 (versione predefinita)
- 1.5.6

Le seguenti informazioni riassumono gli aggiornamenti che potrebbero avere un impatto sulle applicazioni distribuite quando aggiorni un cluster a una nuova versione. Rivedi [Kubernetes changelog ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG.md) per un elenco completo delle modifiche nelle versioni di Kubernetes.

Per ulteriori informazioni sul processo di aggiornamento, consulta [Aggiornamento cluster](cs_cluster.html#cs_cluster_update) e
[Aggiornamento nodi di lavoro](cs_cluster.html#cs_cluster_worker_update).

## Tipi di aggiornamento
{: #version_types}

Kubernetes fornisce questi tipi di aggiornamento della versione:
{:shortdesc}

|Tipo di aggiornamento|Esempi di etichette di versione|Aggiornato da|Impatto
|-----|-----|-----|-----|
|Principale|1.x.x|Tu|Modifiche di funzionamento per i cluster, inclusi script o distribuzioni|
|Secondario|x.5.x|Tu|Modifiche di funzionamento per i cluster, inclusi script o distribuzioni|
|Patch|x.x.3|IBM e tu|Nessuna modifica agli script o alle distribuzioni. IBM aggiorna i master automaticamente, ma tu applichi le patch ai nodi di lavoro.|
{: caption="Impatti degli aggiornamenti di Kubernetes" caption-side="top"}

Per impostazione predefinita, non puoi aggiornare un master Kubernetes più di due versioni secondarie in avanti. Ad esempio, se il master corrente è la versione 1.5 e vuoi aggiornare a 1.8, devi prima aggiornare a 1.7. Puoi forzare l'aggiornamento per continuare, ma l'aggiornamento di più di due versioni secondarie potrebbe causare risultati imprevisti.

## Versione 1.8
{: #cs_v18}
Rivedi le modifiche che potresti dover apportare durante l'aggiornamento a Kubernetes versione 1.8.

### Aggiorna prima il master
{: #18_before}

<table summary="Aggiornamenti di Kubernetes per le versioni 1.8">
<caption>Modifiche da apportare prima di aggiornare il master a Kubernetes 1.8</caption>
<thead>
<tr>
<th>Tipo</th>
<th>Descrizione
</tr>
</thead>
<tbody>
<tr>
<td colspan='2'>Nessuna modifica richiesta prima di aggiornare il master</td>
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
<th>Descrizione
</tr>
</thead>
<tbody>
<tr>
<td>Accesso al dashboard Kubernetes</td>
<td>L'URL per accedere al dashboard Kubernetes nella versione 1.8 è cambiato e il processo di accesso include un nuovo passo di autenticazione. Per ulteriori informazioni, vedi [Accesso al dashboard Kubernetes](cs_apps.html#cs_cli_dashboard).</td>
</tr>
<tr>
<tr>
<td>Autorizzazioni del dashboard Kubernetes</td>
<td>Per forzare gli utenti ad accedere con le proprie credenziali per visualizzare le risorse cluster nella versione 1.8, rimuovi l'autorizzazione RBAC ClusterRoleBinding della versione 1.7. Esegui `kubectl delete clusterrolebinding -n kube-system kubernetes-dashboard`.</td>
</tr>
<tr>
<td>`kubectl delete`</td>
<td>Il comando `kubectl delete` non ridimensiona più gli oggetti API del carico di lavoro, come i pod, prima che l'oggetto venga eliminato. Se richiedi che l'oggetto venga ridimensionato, utilizza [kubectl scale ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/user-guide/kubectl/v1.8/#scale) prima di eliminare l'oggetto.</td>
</tr>
<tr>
<td>`kubectl run`</td>
<td>Il comando `kubectl run` deve utilizzare più indicatori per `--env` invece degli argomenti separati da virgola. Ad esempio, esegui `kubectl run --env <x>=<y> --env <z>=<k>` and not `kubectl run --env <x>=<y>,<z>=<k>`.</td>
</tr>
<td>`kubectl stop`</td>
<td>Il comando `kubectl stop` non è più disponibile.</td>
</tr>
</tbody>
</table>


## Versione 1.7
{: #cs_v17}

Rivedi le modifiche che potresti dover apportare durante l'aggiornamento a Kubernetes versione 1.7.

### Aggiorna prima il master
{: #17_before}

<table summary="Aggiornamenti Kubernetes per le versioni 1.7 e 1.6">
<caption>Modifiche da apportare prima di aggiornare il master a Kubernetes 1.7</caption>
<thead>
<tr>
<th>Tipo</th>
<th>Descrizione
</tr>
</thead>
<tbody>
<tr>
<td>Archiviazione</td>
<td>Gli script di configurazione con `hostPath` e `mountPath` con riferimenti alle directory principali come `../to/dir` non sono consentiti. Modifica i percorsi con percorsi assoluti semplici, ad esempio, `/path/to/dir`.
<ol>
  <li>Determina se è necessario modificare i percorsi di archiviazione:</br>
  ```
  kubectl get pods --all-namespaces -o yaml | grep "\.\." && echo "Action required"
  ```
  </br>

  <li>Se viene restituito `Action required`, modifica i pod per fare riferimento al percorso assoluto prima di aggiornare tutti i tuoi nodi di lavoro. Se il pod appartiene a un'altra risorsa, ad esempio una distribuzione, modifica il [_PodSpec_ ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/api-reference/v1.7/#podspec-v1-core) all'interno di quella risorsa.
</ol>
</td>
</tr>
</tbody>
</table>

### Aggiorna dopo il master
{: #17_after}

<table summary="Aggiornamenti Kubernetes per le versioni 1.7 e 1.6">
<caption>Modifiche da apportare dopo aver aggiornato il master a Kubernetes 1.7</caption>
<thead>
<tr>
<th>Tipo</th>
<th>Descrizione
</tr>
</thead>
<tbody>
<tr>
<td>kubectl</td>
<td>Dopo l'aggiornamento della CLI `kubectl`, questi comandi `kubectl create` devono utilizzare più indicatori anziché argomenti separati da virgola:<ul>
 <li>`role`
 <li>`clusterrole`
 <li>`rolebinding`
 <li>`clusterrolebinding`
 <li>`secret`
 </ul>
</br>  Ad esempio, esegui `kubectl create role --resource-name <x> --resource-name <y>` e non `kubectl create role --resource-name <x>,<y>`.</td>
</tr>
<tr>
<td>Pianificazione affinità pod</td>
<td> L'annotazione `scheduler.alpha.kubernetes.io/affinity` è obsoleta.
<ol>
  <li>Per ogni spazio dei nomi tranne `ibm-system` e `kube-system`, determina se è necessario aggiornare la pianificazione dell'affinità dei pod:</br>
  ```
  kubectl get pods -n <namespace> -o yaml | grep "scheduler.alpha.kubernetes.io/affinity" && echo "Action required"
  ```
  </br>
  <li>Se viene restituito `"Action required"`, utilizza il campo _affinity_ [_PodSpec_ ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/api-reference/v1.7/#podspec-v1-core) invece dell'annotazione `scheduler.alpha.kubernetes.io/affinity`.
</ol>
</tr>
<tr>
<td>Politica di rete</td>
<td>L'annotazione `net.beta.kubernetes.io/network-policy` non è più disponibile.
<ol>
  <li>Determina se è necessario modificare le politiche:</br>
  ```
  kubectl get ns -o yaml | grep "net.beta.kubernetes.io/network-policy" | grep "DefaultDeny" && echo "Action required"
  ```
  <li>Se viene restituito `"Action required"`, aggiungi la seguente politica di rete a ogni spazio dei nomi Kubernetes elencato:</br>

  <pre class="codeblock">
  <code>
  kubectl create -n &lt;namespace&gt; -f - &lt;&lt;EOF
  kind: NetworkPolicy
  apiVersion: networking.k8s.io/v1
  metadata:
    name: default-deny
    namespace: &lt;namespace&gt;
  spec:
    podSelector: {}
  EOF
  </code>
  </pre>

  <li> Dopo aver aggiunto la politica di rete, rimuovi l'annotazione `net.beta.kubernetes.io/network-policy`:
  ```
  kubectl annotate ns <namespace> --overwrite "net.beta.kubernetes.io/network-policy-"
  ```
  </ol>
</tr>
<tr>
<td>Tolleranze</td>
<td>L'annotazione `scheduler.alpha.kubernetes.io/tolerations` non è più disponibile.
<ol>
  <li>Per ogni spazio dei nomi tranne `ibm-system` e `kube-system`, determina se è necessario modificare le tolleranze:</br>
  ```
  kubectl get pods -n <namespace> -o yaml | grep "scheduler.alpha.kubernetes.io/tolerations" && echo "Action required"
  ```
  </br>

  <li>Se viene restituito `"Action required"`, utilizza il campo _tolerations_ [_PodSpec_ ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/api-reference/v1.7/#podspec-v1-core) invece dell'annotazione `scheduler.alpha.kubernetes.io/tolerations`
</ol>
</tr>
<tr>
<td>Corruzioni</td>
<td>L'annotazione `scheduler.alpha.kubernetes.io/taints` non è più disponibile.
<ol>
  <li>Determina se è necessario modificare le corruzioni:</br>
  ```
  kubectl get nodes -o yaml | grep "scheduler.alpha.kubernetes.io/taints" && echo "Action required"
  ```
  <li>Se viene restituito `"Action required"`, rimuovi l'annotazione `scheduler.alpha.kubernetes.io/taints` per ogni nodo:</br>
  `kubectl annotate nodes <node> scheduler.alpha.kubernetes.io/taints-`
  <li>Aggiungi una corruzione a ogni nodo:</br>
  `kubectl taint node <node> <taint>`
  </ol>
</tr>
<tr>
<td>DNS pod StatefulSet</td>
<td>I pod StatefulSet perdono le loro voci DNS Kubernetes dopo l'aggiornamento del master. Per ripristinare le voci DNS, elimina i pod StatefulSet. Kubernetes ricrea i pod e ripristina automaticamente le voci DNS. Per ulteriori informazioni, vedi [Problemi di Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/kubernetes/kubernetes/issues/48327).
</tr>
</tbody>
</table>
