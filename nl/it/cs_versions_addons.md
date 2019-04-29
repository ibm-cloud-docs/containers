---

copyright:
  years: 2014, 2019
lastupdated: "2019-03-21"

keywords: kubernetes, iks, nginx, ingress controller

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
{:download: .download}



# Changelog per i componenti aggiuntivi del cluster

Il tuo cluster {{site.data.keyword.containerlong}} viene fornito con dei componenti aggiuntivi che vengono aggiornati automaticamente da IBM. Puoi anche disabilitare gli aggiornamenti automatici per alcuni componenti aggiuntivi e aggiornarli manualmente e separatamente dai nodi master e di lavoro. Fai riferimento alle tabelle delle seguenti sezioni per un riepilogo delle modifiche per ogni versione.
{: shortdesc}

## Changelog per il componente aggiuntivo ALB Ingress
{: #alb_changelog}

Visualizza le modifiche alla versione di build per il componente aggiuntivo ALB (application load balancer) Ingress nei tuoi cluster {{site.data.keyword.containerlong_notm}}.
{:shortdesc}

Quando il componente aggiuntivo ALB Ingress viene aggiornato, i contenitori `nginx-ingress` e `ingress-auth` in tutti i pod ALB vengono aggiornati all'ultima versione di build. Per impostazione predefinita, gli aggiornamenti automatici per il componente aggiuntivo sono abilitati, ma puoi disabilitarli e aggiornare manualmente il componente aggiuntivo. Per ulteriori informazioni, vedi [Aggiornamento dell'ALB (application load balancer) Ingress](/docs/containers?topic=containers-update#alb).

Fai riferimento alla seguente tabella per un riepilogo delle modifiche per ogni build del componente aggiuntivo ALB Ingress.

<table summary="Panoramica delle modifiche di build per il componente aggiuntivo ALB (application load balancer) Ingress">
<caption>Changelog per il componente aggiuntivo ALB (application load balancer) Ingress</caption>
<col width="12%">
<col width="12%">
<col width="41%">
<col width="35%">
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
<td>411 / 306</td>
<td>21 marzo 2019</td>
<td>Aggiorna la versione di Go alla 1.12.1.</td>
<td>-</td>
</tr>
<tr>
<td>410 / 305</td>
<td>18 marzo 2019</td>
<td><ul>
<li>Corregge le vulnerabilità per le scansioni di immagini.</li>
<li>Migliora la registrazione per {{site.data.keyword.appid_full}}.</li>
</ul></td>
<td>-</td>
</tr>
<tr>
<td>408 / 304</td>
<td>05 marzo 2019</td>
<td>-</td>
<td>Corregge i bug nell'integrazione di autorizzazione correlata alla funzionalità di disconnessione, alla scadenza dei token e al callback delle autorizzazioni `OAuth`. Queste correzioni sono implementate solo se hai abilitato l'autorizzazione {{site.data.keyword.appid_full_notm}} utilizzando l'annotazione [`appid-auth`](/docs/containers?topic=containers-ingress_annotation#appid-auth). Per implementare queste correzioni, vengono aggiunte delle intestazioni aggiuntive, e questo aumenta la dimensione totale delle intestazioni. A seconda della dimensione delle tue intestazioni e della dimensione totale delle risposte, potresti aver bisogno di regolare le [annotazioni di buffer proxy](/docs/containers?topic=containers-ingress_annotation#proxy-buffer) che utilizzi.</td>
</tr>
<tr>
<td>406 / 301</td>
<td>19 febbraio 2019</td>
<td><ul>
<li>Aggiorna la versione di Go alla 1.11.5.</li>
<li>Corregge le vulnerabilità per le scansioni di immagini.</li>
</ul></td>
<td>-</td>
</tr>
<tr>
<td>404 / 300</td>
<td>31 gennaio 2019</td>
<td>Aggiorna la versione di Go alla 1.11.4.</td>
<td>-</td>
</tr>
<tr>
<td>403 / 295</td>
<td>23 gennaio 2019</td>
<td><ul>
<li>Aggiornamenti alla versione NGINX degli ALB alla 1.15.2.</li>
<li>I certificati TLS forniti da IBM sono ora rinnovati automaticamente 37 giorni prima che scadano invece di 7 giorni.</li>
<li>Aggiunge la funzionalità di disconnessione {{site.data.keyword.appid_full_notm}}: se `/logout` è presente in un percorso {{site.data.keyword.appid_full_notm}}, i cookie vengono rimossi e l'utente viene inviato nuovamente alla pagina di accesso.</li>
<li>Aggiunge un'intestazione alle richieste {{site.data.keyword.appid_full_notm}} per scopi di traccia interna.</li>
<li>Aggiorna la direttiva dell'ubicazione {{site.data.keyword.appid_short_notm}} in modo che l'annotazione `app-id` possa essere utilizzata insieme alle annotazioni `proxy-buffers`, `proxy-buffer-size` e `proxy-busy-buffer-size`.</li>
<li>Corregge un bug in modo che i log informativi non vengano etichettati come errori.</li>
</ul></td>
<td>Disabilita TLS 1.0 e 1.1 per impostazione predefinita. Se i client che si connettono alle tue applicazioni supportano TLS 1.2, non è richiesta alcuna azione. Se hai ancora dei client legacy che richiedono il supporto TLS 1.0 o 1.1, abilita manualmente le versioni TLS richieste attenendoti a [questa procedura](/docs/containers?topic=containers-ingress#ssl_protocols_ciphers). Per ulteriori informazioni su come visualizzare le versioni TLS utilizzate dai tuoi client per accedere alle applicazioni, vedi questo [post del blog {{site.data.keyword.Bluemix_notm}}](https://www.ibm.com/blogs/bluemix/2018/11/ibm-cloud-kubernetes-service-alb-update-tls-1-0-and-1-1-disabled-by-default/).
</td>
</tr>
<tr>
<td>393 / 291</td>
<td>09 gennaio 2019</td>
<td>Aggiunge il supporto per più istanze {{site.data.keyword.appid_full_notm}}.</td>
<td>-</td>
</tr>
<tr>
<td>393 / 282</td>
<td>29 novembre 2018</td>
<td>Migliora le prestazioni per {{site.data.keyword.appid_full_notm}}.</td>
<td>-</td>
</tr>
<tr>
<td>384 / 246</td>
<td>14 novembre 2018</td>
<td>Migliora le funzioni di registrazione e disconnessione per {{site.data.keyword.appid_full_notm}}.</td>
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
