---

copyright:
  years: 2014, 2018
lastupdated: "2018-4-20"

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

IBM applica automaticamente gli aggiornamenti a livello di patch al tuo master, ma devi [aggiornare i tuoi nodi di lavoro](cs_cluster_update.html#worker_node). Controlla mensilmente gli aggiornamenti. Quando gli aggiornamenti diventano disponibili, riceverai una notifica quando visualizzerai le informazioni relative ai nodi di lavoro, ad esempio con i comandi `bx cs workers <cluster>` o `bx cs worker-get <cluster> <worker>`.

Per un riepilogo delle azioni di migrazione, vedi [Versioni Kubernetes](cs_versions.html).
{: tip}

Per informazioni sulle modifiche dalla versione precedente, vedi i seguenti changelog.
-  [Changelog](#18_changelog) Versione 1.8.
-  [Changelog](#17_changelog) Versione 1.7.


## Changelog Versione 1.8
{: #18_changelog}

Esamina le seguenti modifiche.

### Changelog per 1.8.11_1509
{: #1811_1509}

<table summary="Modifiche dalla versione 1.8.8_1507">
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
<td>Vedi le [note sulla release Kubernetes![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/kubernetes/kubernetes/releases/tag/v1.8.11).</td>
</tr>
<tr>
<td>Sospensione immagine contenitore</td>
<td>3.0</td>
<td>3.1</td>
<td>Rimuove i processi zombie orfani ereditati. </td>
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

## Changelog Versione 1.7
{: #17_changelog}

Esamina le seguenti modifiche.

### Changelog per 1.7.16_1511
{: #1716_1511}

<table summary="Modifiche dalla versione 1.7.4_1509">
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
<td>Vedi le [note sulla release Kubernetes![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/kubernetes/kubernetes/releases/tag/v1.7.16).</td>
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

