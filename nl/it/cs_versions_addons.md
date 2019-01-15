---

copyright:
  years: 2014, 2018
lastupdated: "2018-12-05"

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
{:download: .download}


# Changelog per i componenti aggiuntivi del cluster

Il tuo cluster {{site.data.keyword.containerlong}} viene fornito con dei componenti aggiuntivi che vengono aggiornati automaticamente da IBM. Puoi anche disabilitare gli aggiornamenti automatici per alcuni componenti aggiuntivi e aggiornarli manualmente e separatamente dai nodi master e di lavoro. Fai riferimento alle tabelle delle seguenti sezioni per un riepilogo delle modifiche per ogni versione.
{: shortdesc}

## Changelog per il componente aggiuntivo ALB Ingress
{: #alb_changelog}

Visualizza le modifiche alla versione di build per il componente aggiuntivo ALB (application load balancer) Ingress nei tuoi cluster {{site.data.keyword.containerlong_notm}}.
{:shortdesc}

Quando il componente aggiuntivo ALB Ingress viene aggiornato, i contenitori `nginx-ingress` e `ingress-auth` in tutti i pod ALB vengono aggiornati all'ultima versione di build. Per impostazione predefinita, gli aggiornamenti automatici per il componente aggiuntivo sono abilitati, ma puoi disabilitarli e aggiornare manualmente il componente aggiuntivo. Per ulteriori informazioni, vedi [Aggiornamento dell'ALB (application load balancer) Ingress](cs_cluster_update.html#alb).

Fai riferimento alla seguente tabella per un riepilogo delle modifiche per ogni build del componente aggiuntivo ALB Ingress.

<table summary="Panoramica delle modifiche di build per il componente aggiuntivo ALB (application load balancer) Ingress">
<caption>Changelog per il componente aggiuntivo ALB (application load balancer) Ingress</caption>
<thead>
<tr>
<th>Build `nginx-ingress` / `ingress-auth`</th>
<th>Data di rilascio</th>
<th>Modifiche senza interruzione del servizio</th>
<th>Modifiche con interruzione del servizio</th>
</tr>
</thead>
<tbody>
<tr>
<td>393 / 282</td>
<td>29 novembre 2018</td>
<td>Migliora le prestazioni per {{site.data.keyword.appid_full}}.</td>
<td>-</td>
</tr>
<tr>
<td>384 / 246</td>
<td>14 novembre 2018</td>
<td>Migliora le funzioni di registrazione e disconnessione per {{site.data.keyword.appid_full}}.</td>
<td>Sostituisce il certificato autofirmato per `*.containers.mybluemix.net` con il certificato firmato da LetsEncrypt che viene generato automaticamente e utilizzato dal cluster. Il certificato autofirmato `*.containers.mybluemix.net` viene rimosso.</td>
</tr>
<tr>
<td>350 / 192</td>
<td>05 novembre 2018</td>
<td>Aggiunge il supporto per abilitare e disabilitare gli aggiornamenti automatici del componente aggiuntivo ALB Ingress.</td>
<td>-</td>
</tr>
</tbody>
</table>
