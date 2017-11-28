---

copyright:
  years: 2014, 2017
lastupdated: "2017-10-24"

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

La tabella contiene gli aggiornamenti che potrebbero avere impatto sulle applicazioni distribuite quando aggiorni un cluster a una nuova versione. Rivedi [Kubernetes changelog ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG.md) per un elenco completo delle modifiche nelle versioni di Kubernetes.

Per ulteriori informazioni sul processo di aggiornamento, consulta [Aggiornamento cluster](cs_cluster.html#cs_cluster_update) e
[Aggiornamento nodi di lavoro](cs_cluster.html#cs_cluster_worker_update).



## Versione 1.7
{: #cs_v17}

### Aggiorna prima il master
{: #17_before}

<table summary="Aggiornamenti Kubernetes per le versioni 1.7 e 1.6">
<caption>Tabella 1. Modifiche da effettuare prima dell'aggiornamento del master a Kubernetes 1.7</caption>
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
  <li>Esegui questo comando per determinare se hai bisogno di aggiornare i tuoi percorsi di archiviazione.</br>
  ```
  kubectl get pods --all-namespaces -o yaml | grep "\.\." && echo "Action required"
  ```
  </br>

  <li>Se viene restituito `Action required`, modifica ogni pod interessato per fare riferimento al percorso assoluto prima di aggiornare tutti i nodi di lavoro. Se il pod è gestito da un'altra risorsa, come una distribuzione, modifica il [_PodSpec_ ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/api-reference/v1.7/#podspec-v1-core) in tale risorsa.
</ol>
</td>
</tr>
</tbody>
</table>

### Aggiorna dopo il master
{: #17_after}

<table summary="Aggiornamenti Kubernetes per le versioni 1.7 e 1.6">
<caption>Tabella 2. Modifiche da effettuare dopo l'aggiornamento del master a Kubernetes 1.7</caption>
<thead>
<tr>
<th>Tipo</th>
<th>Descrizione
</tr>
</thead>
<tbod>
<tr>
<td>kubectl</td>
<td>Dopo aver aggiornato la CLI `kubectl` alla versione del tuo cluster, questi comandi `kubectl` devono utilizzare più indicatori invece di argomenti separati da virgole. <ul>
 <li>`create role`
 <li>`create clusterrole`
 <li>`create rolebinding`
 <li>`create clusterrolebinding`
 <li>`create secret`
 </ul>
</br>  Ad esempio, esegui `kubectl create role --resource-name <x> --resource-name <y>` e non `kubectl create role --resource-name <x>,<y>`.</td>
</tr>
<tr>
<td>Pianificazione affinità pod</td>
<td> L'annotazione `scheduler.alpha.kubernetes.io/affinity` è obsoleta.
<ol>
  <li>Esegui questo comando per ogni spazio dei nomi ad eccezione di `ibm-system` e `kube-system` per determinare se hai bisogno di aggiornare la pianificazione dell'affinità del pod.</br>
  ```
  kubectl get pods -n <namespace> -o yaml | grep "scheduler.alpha.kubernetes.io/affinity" && echo "Action required"
  ```
  </br>
  <li>Se viene restituito `"Action required"`, modifica i pod interessati in modo che utilizzino il [_PodSpec_ ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/api-reference/v1.7/#podspec-v1-core) campo _affinity_ invece dell'annotazione `scheduler.alpha.kubernetes.io/affinity`.
</ol>
</tr>
<tr>
<td>Politica di rete</td>
<td>L'annotazione `net.beta.kubernetes.io/network-policy` non è più supportata.
<ol>
  <li>Esegui questo comando per determinare se hai bisogno di aggiornare le tue politiche di rete. </br>
  ```
  kubectl get ns -o yaml | grep "net.beta.kubernetes.io/network-policy" | grep "DefaultDeny" && echo "Action required"
  ```
  <li>Se viene restituito `Action required`, aggiungi la seguente politica di rete ad ogni spazio dei nomi Kubernetes che viene elencato.</br>

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

  <li> Con la politica di rete attiva, rimuovi l'annotazione `net.beta.kubernetes.io/network-policy`.
  ```
  kubectl annotate ns <namespace> --overwrite "net.beta.kubernetes.io/network-policy-"
  ```
  </ol>
</tr>
<tr>
<td>Tolleranze </td>
<td>L'annotazione `scheduler.alpha.kubernetes.io/tolerations` non è più supportata.
<ol>
  <li>Esegui questo comando per ogni spazio dei nomi ad eccezione di `ibm-system` e `kube-system` per determinare se hai bisogno di aggiornare le tolleranze. </br>
  ```
  kubectl get pods -n <namespace> -o yaml | grep "scheduler.alpha.kubernetes.io/tolerations" && echo "Action required"
  ```
  </br>

  <li>Se viene restituito `"Action required"`, modifica i pod interessati in modo che utilizzino il [_PodSpec_ ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/api-reference/v1.7/#podspec-v1-core) campo _tolerations_ invece dell'annotazione `scheduler.alpha.kubernetes.io/tolerations`
</ol>
</tr>
<tr>
<td>Corruzioni </td>
<td>L'annotazione `scheduler.alpha.kubernetes.io/taints` non è più supportata.
<ol>
  <li>Esegui questo comando per determinare se hai bisogno di aggiornare le corruzioni. </br>
  ```
  kubectl get nodes -o yaml | grep "scheduler.alpha.kubernetes.io/taints" && echo "Action required"
  ```
  <li>Se viene restituito `"Action required"`, rimuovi l'annotazione `scheduler.alpha.kubernetes.io/taints` per ogni nodo con annotazioni non supportate.</br>
  `kubectl annotate nodes <node> scheduler.alpha.kubernetes.io/taints-`
  <li>Quando viene rimossa un'annotazione non supportata, aggiungi una corruzione ad ogni nodo. Devi avere la CLI `kubectl` alla versione 1.6 o successiva.</br>
  `kubectl taint node <node> <taint>`
  </ol>
</tr>
</tbody>
</table></staging>
