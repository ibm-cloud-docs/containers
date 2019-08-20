---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

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
{:download: .download}
{:preview: .preview}


# Note sulla release
{: #iks-release}

Utilizza le note sulla release per informazioni sulle ultime modifiche apportate alla documentazione di {{site.data.keyword.containerlong}} raggruppate per mese.
{:shortdesc}

Le seguenti icone sono utilizzate per indicare se una nota sulla release si applica solo a una specifica piattaforma del contenitore. Se non viene utilizzata alcuna icona, la nota sulla release si applica a entrambi i cluster OpenShift e Kubernetes della community.<br>
<img src="images/logo_kubernetes.svg" alt="Icona di Kubernetes" width="15" style="width:15px; border-style: none"/> si applica solo ai cluster Kubernetes della community<br>
<img src="images/logo_openshift.svg" alt="Icona di OpenShift" width="15" style="width:15px; border-style: none"/> si applica solo ai cluster OpenShift, rilasciati come beta il 5 giugno 2019.
{: note}

## Agosto 2019
{: #aug19}

<table summary="La tabella mostra le note sulla release. Le righe devono essere lette da sinistra a destra, con la data nella colonna uno, il titolo della funzione nella colonna due e una descrizione nella colonna tre.">
<caption>Aggiornamenti della documentazione di agosto 2019</caption>
<thead>
<th>Data</th>
<th>Descrizione</th>
</thead>
<tbody>
<tr>
  <td>1° agosto 2019</td>
  <td><img src="images/logo_openshift.svg" alt="Icona di OpenShift" width="15" style="width:15px; border-style: none"/> <strong>Red Hat OpenShift on IBM Cloud</strong>: Red Hat OpenShift on IBM Cloud è generalmente disponibile a partire dal 1° agosto 2019 alle 0:00 UTC. Tutti i cluster beta scadono entro 30 giorni. Puoi [creare un cluster GA](/docs/openshift?topic=openshift-openshift_tutorial) e quindi ridistribuire tutte le applicazioni da te utilizzate nei cluster beta prima che i cluster beta vengano rimossi.<br><br>Poiché la logica {{site.data.keyword.containerlong_notm}} e l'infrastruttura cloud sottostante sono uguali, molti argomenti sono riutilizzati nella documentazione per i cluster [Kubernetes della community](/docs/containers?topic=containers-getting-started) e [OpenShift](/docs/openshift?topic=openshift-getting-started), come ad esempio questo argomento sulle note sulla release.</td>
</tr>
</tbody></table>

## Luglio 2019
{: #jul19}

<table summary="La tabella mostra le note sulla release. Le righe devono essere lette da sinistra a destra, con la data nella colonna uno, il titolo della funzione nella colonna due e una descrizione nella colonna tre.">
<caption>Aggiornamenti della documentazione {{site.data.keyword.containerlong_notm}} di luglio 2019</caption>
<thead>
<th>Data</th>
<th>Descrizione</th>
</thead>
<tbody>
<tr>
  <td>30 luglio 2019</td>
  <td><ul>
  <li><strong>Changelog della CLI</strong>: la pagina di changelog del plugin della CLI {{site.data.keyword.containerlong_notm}} per la [release della versione 0.3.95](/docs/containers?topic=containers-cs_cli_changelog) è stata aggiornata.</li>
  <li><strong>Changelog di ALB Ingress</strong>: l'immagine `nginx-ingress` ALB è stata aggiornata alla build 515 per il [controllo della disponibilità dei pod ALB](/docs/containers?topic=containers-cluster-add-ons-changelog#alb_changelog).</li>
  <li><strong>Rimozione delle sottoreti da un cluster</strong>: è stata aggiunta la procedura per rimuovere le sottoreti [in un account dell'infrastruttura IBM Cloud](/docs/containers?topic=containers-subnets#remove-sl-subnets) o [in una rete in loco](/docs/containers?topic=containers-subnets#remove-user-subnets) da un cluster. </li>
  </ul></td>
</tr>
<tr>
  <td>26 luglio 2019</td>
  <td><img src="images/logo_openshift.svg" alt="Icona di OpenShift" width="15" style="width:15px; border-style: none"/> <strong>Red Hat OpenShift on IBM Cloud</strong>: sono stati aggiunti gli argomenti relativi a [integrazioni](/docs/openshift?topic=openshift-openshift_integrations), [ubicazioni](/docs/openshift?topic=openshift-regions-and-zones) e [vincoli del contesto di sicurezza](/docs/openshift?topic=openshift-openshift_scc). Solo stati aggiunti i ruoli del cluster `basic-users` e `self-provisioning` all'argomento relativo alla [sincronizzazione dei ruoli del servizio IAM a RBAC](/docs/openshift?topic=openshift-access_reference#service).</td>
</tr>
<tr>
  <td>23 luglio 2019</td>
  <td><strong>Changelog di Fluentd</strong>: corregge le [vulnerabilità Alpine](/docs/containers?topic=containers-cluster-add-ons-changelog#fluentd_changelog).</td>
</tr>
<tr>
  <td>22 luglio 2019</td>
  <td><ul>
  <li><img src="images/logo_kubernetes.svg" alt="Icona di Kubernetes" width="15" style="width:15px; border-style: none"/> <strong>Politica della versione</strong>: Il periodo di [deprecazione della versione](/docs/containers?topic=containers-cs_versions#version_types) è stato aumentato da 30 a 45 giorni.</li>
      <li><img src="images/logo_kubernetes.svg" alt="Icona di Kubernetes" width="15" style="width:15px; border-style: none"/> <strong>Changelog delle versioni</strong>: sono stati aggiornati i changelog per gli aggiornamenti patch dei nodi di lavoro [1.14.4_1526](/docs/containers?topic=containers-changelog#1144_1526_worker), [1.13.8_1529](/docs/containers?topic=containers-changelog#1138_1529_worker) e [1.12.10_1560](/docs/containers?topic=containers-changelog#11210_1560_worker).</li>
    <li><img src="images/logo_kubernetes.svg" alt="Icona di Kubernetes" width="15" style="width:15px; border-style: none"/> <strong>Changelog delle versioni</strong>: la [versione 1.11](/docs/containers?topic=containers-changelog#111_changelog) non è supportata.</li></ul>
  </td>
</tr>
<tr>
  <td>19 luglio 2019</td>
  <td><img src="images/logo_openshift.svg" alt="Icona di OpenShift" width="15" style="width:15px; border-style: none"/> <strong>Red Hat OpenShift on IBM Cloud</strong>: è stata aggiunta la [documentazione di Red Hat OpenShift on IBM Cloud a un repository separato](/docs/openshift?topic=openshift-getting-started). Poiché la logica {{site.data.keyword.containerlong_notm}} e l'infrastruttura cloud sottostante sono uguali, molti argomenti sono riutilizzati nella documentazione peri cluster OpenShift e Kubernetes della community, come ad esempio questo argomento sulle note sulla release.
  </td>
</tr>
<tr>
  <td>17 luglio 2019</td>
  <td><strong>Changelog di ALB Ingress</strong>: [corregge le vulnerabilità `rbash`](/docs/containers?topic=containers-cluster-add-ons-changelog#alb_changelog).
  </td>
</tr>
<tr>
  <td>15 luglio 2019</td>
  <td><ul>
  <li><img src="images/logo_kubernetes.svg" alt="Icona di Kubernetes" width="15" style="width:15px; border-style: none"/> <strong>ID cluster e nodo di lavoro</strong>: il formato ID per i cluster e i nodi di lavoro è cambiato. I cluster e i nodi di lavoro esistenti mantengono i loro ID esistenti. Se hai un'automazione che si basa sul formato precedente, aggiornala per i nuovi cluster.<ul>
  <li>**ID cluster**: nel formato regex `{a-v0-9}[7]{a-z0-9}[2]{a-v0-9}[11]`</li>
  <li>**ID nodo di lavoro**: nel formato `kube-<cluster_ID>-<cluster_name_truncated>-<resource_group_truncated>-<worker_ID>`</li></ul></li>
  <li><strong>Changelog di ALB Ingress</strong>: l'[immagine ALB `nginx-ingress` è stata aggiornata alla build 497](/docs/containers?topic=containers-cluster-add-ons-changelog#alb_changelog).</li>
  <li><strong>Risoluzione dei problemi dei cluster</strong>: è stata aggiunta una [procedura di risoluzione dei problemi](/docs/containers?topic=containers-cs_troubleshoot_clusters#cs_totp) per quando non puoi gestire i cluster e i nodi di lavoro perché l'opzione TOTP (time-based one-time passcode), ossia una passcode monouso basata sul tempo, è abilitata per il tuo account.</li>
  <li><img src="images/logo_kubernetes.svg" alt="Icona di Kubernetes" width="15" style="width:15px; border-style: none"/> <strong>Changelog delle versioni</strong>: sono stati aggiornati i changelog per gli aggiornamenti fix pack del master [1.14.4_1526](/docs/containers?topic=containers-changelog#1144_1526), [1.13.8_1529](/docs/containers?topic=containers-changelog#1138_1529) e [1.12.10_1560](/docs/containers?topic=containers-changelog#11210_1560).</li></ul>
  </td>
</tr>
<tr>
  <td>8 luglio 2019</td>
  <td><ul>
  <li><strong>Rete dell'applicazione</strong>: puoi ora trovare informazioni sul collegamento in rete dell'applicazione con gli NLB e gli ALB Ingress nelle seguenti pagine:
    <ul><li>[Bilanciamento del carico DSR e di base con gli NLB (network load balancer)](/docs/containers?topic=containers-cs_sitemap#sitemap-nlb)</li>
    <li>[Bilanciamento del carico HTTPS con gli ALB (application load balancer) Ingress](/docs/containers?topic=containers-cs_sitemap#sitemap-ingress)</li></ul>
  </li>
  <li><img src="images/logo_kubernetes.svg" alt="Icona di Kubernetes" width="15" style="width:15px; border-style: none"/> <strong>Changelog delle versioni</strong>: sono stati aggiornati i changelog per gli aggiornamenti patch del nodo di lavoro [1.14.3_1525](/docs/containers?topic=containers-changelog#1143_1525), [1.13.7_1528](/docs/containers?topic=containers-changelog#1137_1528), [1.12.9_1559](/docs/containers?topic=containers-changelog#1129_1559) e [1.11.10_1564](/docs/containers?topic=containers-changelog#11110_1564).</li></ul>
  </td>
</tr>
<tr>
  <td>2 luglio 2019</td>
  <td><strong>Changelog della CLI</strong>: la pagina di changelog del plugin della CLI {{site.data.keyword.containerlong_notm}} per la [release della versione 0.3.58](/docs/containers?topic=containers-cs_cli_changelog) è stata aggiornata.</td>
</tr>
<tr>
  <td>1° luglio 2019</td>
  <td><ul>
  <li><strong>Autorizzazioni dell'infrastruttura</strong>: sono stati aggiornati i [ruoli dell'infrastruttura classica](/docs/containers?topic=containers-access_reference#infra) necessari per i casi d'uso comuni.</li>
  <li><img src="images/logo_openshift.svg" alt="Icona di OpenShift" width="15" style="width:15px; border-style: none"/> <strong>Domande frequenti di OpenShift</strong>: le [domande frequenti](/docs/containers?topic=containers-faqs#container_platforms) sono state ampliate per includere le informazioni sui cluster OpenShift.</li>
  <li><strong>Protezione delle applicazioni gestite da Istio con {{site.data.keyword.appid_short_notm}}</strong>: sono state aggiunte le informazioni sull'[adattatore App Identity and Access](/docs/containers?topic=containers-istio#app-id).</li>
  <li><strong>Servizio VPN strongSwan</strong>: se installi strongSwan in un cluster multizona e utilizzi l'impostazione `enableSingleSourceIP=true`, puoi ora [impostare `local.subnet` sulla variabile `%zoneSubnet` e utilizzare `local.zoneSubnet` per specificare un indirizzo IP come una sottorete /32 per ciascuna zona del cluster](/docs/containers?topic=containers-vpn#strongswan_4).</li>
  </ul></td>
</tr>
</tbody></table>


## Giugno 2019
{: #jun19}

<table summary="La tabella mostra le note sulla release. Le righe devono essere lette da sinistra a destra, con la data nella colonna uno, il titolo della funzione nella colonna due e una descrizione nella colonna tre.">
<caption>Aggiornamenti della documentazione {{site.data.keyword.containerlong_notm}} di giugno 2019</caption>
<thead>
<th>Data</th>
<th>Descrizione</th>
</thead>
<tbody>
<tr>
  <td>24 giugno 2019</td>
  <td><ul>
  <li><strong>Politiche di rete Calico</strong>: è stato aggiunto un insieme di [politiche Calico pubbliche](/docs/containers?topic=containers-network_policies#isolate_workers_public) ed è stato ampliato l'insieme di [politiche Calico private](/docs/containers?topic=containers-network_policies#isolate_workers) per proteggere il tuo cluster sulle reti pubbliche e private.</li>
  <li><strong>Changelog di ALB Ingress</strong>: l'[immagine ALB `nginx-ingress` è stata aggiornata alla build 477](/docs/containers?topic=containers-cluster-add-ons-changelog#alb_changelog).</li>
  <li><img src="images/logo_kubernetes.svg" alt="Icona di Kubernetes" width="15" style="width:15px; border-style: none"/> <strong>Limitazioni del servizio</strong>: è stata aggiornata la [limitazione del numero massimo di pod per ogni nodo di lavoro](/docs/containers?topic=containers-ibm-cloud-kubernetes-service-technology#tech_limits). Per i nodi di lavoro che eseguono Kubernetes 1.13.7_1527, 1.14.3_1524 o versioni successive e che hanno più di 11 core CPU, i nodi di lavoro possono supportare 10 pod per ogni core, fino a un limite di 250 pod per ogni nodo di lavoro.</li>
  <li><img src="images/logo_kubernetes.svg" alt="Icona di Kubernetes" width="15" style="width:15px; border-style: none"/> <strong>Changelog delle versioni</strong>: sono stati aggiunti i changelog per gli aggiornamenti patch del nodo di lavoro [1.14.3_1524](/docs/containers?topic=containers-changelog#1143_1524), [1.13.7_1527](/docs/containers?topic=containers-changelog#1137_1527), [1.12.9_1558](/docs/containers?topic=containers-changelog#1129_1558) e [1.11.10_1563](/docs/containers?topic=containers-changelog#11110_1563).</li>
  </ul></td>
</tr>
<tr>
  <td>21 giugno 2019</td>
  <td><ul>
  <li><img src="images/logo_openshift.svg" alt="Icona di OpenShift" width="15" style="width:15px; border-style: none"/> <strong>Accesso ai cluster OpenShift</strong>: è stata aggiunta la procedura per [automatizzare l'accesso a un cluster OpenShift utilizzando un token di accesso OpenShift](/docs/containers?topic=containers-cs_cli_install#openshift_cluster_login).</li>
  <li><img src="images/logo_kubernetes.svg" alt="Icona di Kubernetes" width="15" style="width:15px; border-style: none"/> <strong>Accesso al master Kubernetes tramite l'endpoint del servizio privato</strong>: è stata aggiunta la procedura per [modificare il file di configurazione Kubernetes locale](/docs/containers?topic=containers-clusters#access_on_prem) quando entrambi gli endpoint del servizio pubblico e privato sono abilitati ma desideri accedere al master Kubernetes solo tramite l'endpoint del servizio privato.</li>
  <li><img src="images/logo_openshift.svg" alt="Icona di OpenShift" width="15" style="width:15px; border-style: none"/> <strong>Risoluzione dei problemi dei cluster OpenShift</strong>: è stata aggiunta una [sezione di risoluzione dei problemi](/docs/openshift?topic=openshift-openshift_tutorial#openshift_troubleshoot) all'esercitazione Creazione di un cluster Red Hat OpenShift on IBM Cloud (beta).</li>
  </ul></td>
</tr>
<tr>
  <td>18 giugno 2019</td>
  <td><ul>
  <li><strong>Changelog della CLI</strong>: la pagina del changelog del plugin della CLI {{site.data.keyword.containerlong_notm}} è stata aggiornata per la [release delle versioni 0.3.47 e 0.3.49](/docs/containers?topic=containers-cs_cli_changelog).</li>
  <li><strong>Changelog di ALB Ingress</strong>: sono state aggiornate l'[immagine `nginx-ingress` ALB alla build 473 e l'immagine `ingress-auth` alla build 331](/docs/containers?topic=containers-cluster-add-ons-changelog#alb_changelog).</li>
  <li><strong>Versioni dei componenti aggiuntivi gestiti</strong>: è stata aggiornata la versione del componente aggiuntivo gestito da Istio alla 1.1.7 e quella del componente aggiuntivo gestito da Knative alla 0.6.0.</li>
  <li><strong>Rimozione dell'archiviazione persistente</strong>: sono state aggiornate le informazioni relative alla modalità di fatturazione a tuo carico quando [elimini l'archiviazione persistente](/docs/containers?topic=containers-cleanup).</li>
  <li><strong>Bind del servizio con endpoint privato</strong>: [è stata aggiunta la procedura](/docs/containers?topic=containers-service-binding) di modalità di creazione manuale delle credenziali del servizio con l'endpoint del servizio privato quando esegui il bind del servizio al tuo cluster.</li>
  <li><img src="images/logo_kubernetes.svg" alt="Icona di Kubernetes" width="15" style="width:15px; border-style: none"/> <strong>Changelog delle versioni</strong>: sono stati aggiornati i changelog per gli aggiornamenti patch [1.14.3_1523](/docs/containers?topic=containers-changelog#1143_1523), [1.13.7_1526](/docs/containers?topic=containers-changelog#1137_1526), [1.12.9_1557](/docs/containers?topic=containers-changelog#1129_1557) e [1.11.10_1562](/docs/containers?topic=containers-changelog#11110_1562).</li>
  </ul></td>
</tr>
<tr>
  <td>14 giugno 2019</td>
  <td><ul>
  <li><strong>Risoluzione dei problemi di `kubectl`</strong>: è stato aggiunto un [argomento di risoluzione dei problemi](/docs/containers?topic=containers-cs_troubleshoot_clusters#kubectl_fails) per quando hai una versione del client `kubectl` con uno scarto di 2 o più versioni dalla versione del server o dalla versione OpenShift di `kubectl`, che non funziona con i cluster Kubernetes della community,</li>
  <li><strong>Pagina di destinazione delle esercitazioni</strong>: la pagina dei link correlati è stata sostituita con una nuova [pagina di destinazione delle esercitazioni](/docs/containers?topic=containers-tutorials-ov) per tutte le esercitazioni specifiche per {{site.data.keyword.containershort_notm}}.</li>
  <li><img src="images/logo_kubernetes.svg" alt="Icona di Kubernetes" width="15" style="width:15px; border-style: none"/> <strong>Esercitazione per creare un cluster e distribuire un'applicazione</strong>: sono state combinate in un'[esercitazione](/docs/containers?topic=containers-cs_cluster_tutorial) completa le esercitazioni per creare i cluster e distribuire le applicazioni.</li>
  <li><strong>Utilizzo delle sottoreti esistenti per creare un cluster</strong>: per [riutilizzare le sottoreti da un cluster non necessario quando crei un nuovo cluster](/docs/containers?topic=containers-subnets#subnets_custom), le sottoreti devono essere sottoreti gestite dall'utente che hai aggiunto manualmente da una rete in loco. Tutte le sottoreti che erano precedentemente ordinate automaticamente durante la creazione del cluster vengono immediatamente eliminate dopo che elimini un cluster e non puoi riutilizzare queste sottoreti per creare un nuovo cluster.</li>
  </ul></td>
</tr>
<tr>
  <td>12 giugno 2019</td>
  <td><strong>Aggregazione dei ruoli del cluster</strong>: è stata aggiunta la procedura per [ampliare le autorizzazioni esistenti degli utenti aggregando i ruoli del cluster](/docs/containers?topic=containers-users#rbac_aggregate).</td>
</tr>
<tr>
  <td>7 giugno 2019</td>
  <td><ul>
  <li><strong>Accesso al master Kubernetes tramite l'endpoint del servizio privato</strong>: è stata aggiunta la [procedura](/docs/containers?topic=containers-clusters#access_on_prem) per esporre l'endpoint del servizio privato tramite un programma di bilanciamento del carico privato. Dopo aver completato questa procedura, gli utenti del cluster autorizzati possono accedere al master Kubernetes mediante una connessione VPN o {{site.data.keyword.cloud_notm}} Direct Link.</li>
  <li><strong>{{site.data.keyword.BluDirectLink}}</strong>: è stato aggiunto {{site.data.keyword.cloud_notm}} Direct Link alle pagine sulla [connettività VPN](/docs/containers?topic=containers-vpn) e sul [cloud ibrido](/docs/containers?topic=containers-hybrid_iks_icp) come modo per creare una connessione diretta e privata tra i tuoi ambienti di rete remoti e {{site.data.keyword.containerlong_notm}} senza instradamento sull'Internet pubblico.</li>
  <li><strong>Changelog ALB Ingress</strong>: è stata aggiornata l'[immagine `ingress-auth` ALB alla build 330](/docs/containers?topic=containers-cluster-add-ons-changelog#alb_changelog).</li>
  <li><img src="images/logo_openshift.svg" alt="Icona di OpenShift" width="15" style="width:15px; border-style: none"/> <strong>OpenShift beta</strong>: [è stata aggiunta una lezione](/docs/openshift?topic=openshift-openshift_tutorial#openshift_logdna_sysdig) relativa alla modalità di modifica delle distribuzioni di applicazioni per i vincoli di contesto di sicurezza privilegiati per i componenti aggiuntivi {{site.data.keyword.la_full_notm}} e {{site.data.keyword.mon_full_notm}}.</li>
  </ul></td>
</tr>
<tr>
  <td>6 giugno 2019</td>
  <td><ul>
  <li><strong>Changelog Fluentd</strong>: è stato aggiunto un [changelog della versione di Fluentd](/docs/containers?topic=containers-cluster-add-ons-changelog#fluentd_changelog).</li>
  <li><strong>Changelog ALB Ingress</strong>: è stata aggiornata l'[immagine `nginx-ingress` ALB alla build 470](/docs/containers?topic=containers-cluster-add-ons-changelog#alb_changelog).</li>
  </ul></td>
</tr>
<tr>
  <td>5 giugno 2019</td>
  <td><ul>
  <li><strong>Riferimenti CLI</strong>: è stata aggiornata la [pagina dei riferimenti CLI](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli) per riflettere più modifiche per la [release della versione 0.3.34](/docs/containers?topic=containers-cs_cli_changelog) del plugin della CLI {{site.data.keyword.containerlong_notm}}.</li>
  <li><img src="images/logo_openshift.svg" alt="Icona di OpenShift" width="15" style="width:15px; border-style: none"/> <strong>Novità. Cluster Red Hat OpenShift on IBM Cloud (beta)</strong>: con Red Hat OpenShift on IBM Cloud beta, puoi creare cluster {{site.data.keyword.containerlong_notm}} con i nodi di lavoro che vengono installati con il software della piattaforma di orchestrazione dei contenitori OpenShift. Ottieni tutti i vantaggi del servizio {{site.data.keyword.containerlong_notm}} gestito per l'ambiente della tua infrastruttura cluster, insieme agli [strumenti e al catalogo OpenShift ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://docs.openshift.com/container-platform/3.11/welcome/index.html) eseguiti su Red Hat Enterprise Linux per le tue distribuzioni dell'applicazione. Per iniziare, vedi [Esercitazione: Creazione di un cluster Red Hat OpenShift on IBM Cloud (beta)](/docs/openshift?topic=openshift-openshift_tutorial).</li>
  </ul></td>
</tr>
<tr>
  <td>4 giugno 2019</td>
  <td><ul>
  <li><img src="images/logo_kubernetes.svg" alt="Icona di Kubernetes" width="15" style="width:15px; border-style: none"/> <strong>Changelog versione</strong>: sono stati aggiornati i changelog per le release patch [1.14.2_1521](/docs/containers?topic=containers-changelog#1142_1521), [1.13.6_1524](/docs/containers?topic=containers-changelog#1136_1524), [1.12.9_1555](/docs/containers?topic=containers-changelog#1129_1555) e [1.11.10_1561](/docs/containers?topic=containers-changelog#11110_1561).</li></ul>
  </td>
</tr>
<tr>
  <td>3 giugno 2019</td>
  <td><ul>
  <li><strong>Utilizzo di un tuo controller Ingress</strong>: è stata aggiornata la [procedura](/docs/containers?topic=containers-ingress-user_managed) per riflettere le modifiche al controller della community predefinito e richiedere un controllo dell'integrità per gli indirizzi IP del controller nei cluster multizona.</li>
  <li><strong>{{site.data.keyword.cos_full_notm}}</strong>: è stata aggiornata la [procedura](/docs/containers?topic=containers-object_storage#install_cos) per installare il plugin {{site.data.keyword.cos_full_notm}} con o senza il server Helm, Tiller.</li>
  <li><strong>Changelog ALB Ingress</strong>: è stata aggiornata l'[immagine `nginx-ingress` ALB alla build 467](/docs/containers?topic=containers-cluster-add-ons-changelog#alb_changelog).</li>
  <li><strong>Kustomize</strong>: è stato aggiunto un esempio di [riutilizzo dei file di configurazione Kubernetes tra più ambienti con Kustomize](/docs/containers?topic=containers-app#kustomize).</li>
  <li><strong>Razee</strong>: è stato aggiunto [Razee ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/razee-io/Razee) alle integrazioni supportate per visualizzare le informazioni di distribuzione nel cluster e automatizzare la distribuzione delle risorse Kubernetes. </li></ul>
  </td>
</tr>
</tbody></table>


## Maggio 2019
{: #may19}

<table summary="La tabella mostra le note sulla release. Le righe devono essere lette da sinistra a destra, con la data nella colonna uno, il titolo della funzione nella colonna due e una descrizione nella colonna tre.">
<caption>Aggiornamenti della documentazione {{site.data.keyword.containerlong_notm}} di maggio 2019</caption>
<thead>
<th>Data</th>
<th>Descrizione</th>
</thead>
<tbody>
<tr>
  <td>30 maggio 2019</td>
  <td><ul>
  <li><strong>Riferimenti CLI</strong>: è stata aggiornata la [pagina dei riferimenti CLI](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli) per riflettere più modifiche per la [release della versione 0.3.33](/docs/containers?topic=containers-cs_cli_changelog) del plugin della CLI {{site.data.keyword.containerlong_notm}}.</li>
  <li><strong>Risoluzione dei problemi dell'archiviazione</strong>: <ul>
  <li>È stato aggiunto un argomento per la risoluzione dei problemi dell'archiviazione file e blocchi relativo agli [stati in sospeso del PVC](/docs/containers?topic=containers-cs_troubleshoot_storage#file_pvc_pending).</li>
  <li>È stato aggiunto un argomento per la risoluzione dei problemi dell'archiviazione blocchi per quando [un'applicazione non può accedere o scrivere sul PVC](/docs/containers?topic=containers-cs_troubleshoot_storage#block_app_failures).</li>
  </ul></li>
  </ul></td>
</tr>
<tr>
  <td>28 maggio 2019</td>
  <td><ul>
  <li><strong>Changelog dei componenti aggiuntivi del cluster</strong>: è stata aggiornata l'[immagine `nginx-ingress` ALB alla build 462](/docs/containers?topic=containers-cluster-add-ons-changelog).</li>
  <li><strong>Risoluzione dei problemi del registro</strong>: è stato aggiunto un [argomento sulla risoluzione dei problemi](/docs/containers?topic=containers-cs_troubleshoot_clusters#ts_image_pull_create) per quando il tuo cluster non riesce a estrarre le immagini da {{site.data.keyword.registryfull}} a causa di un errore durante la creazione del cluster.
  </li>
  <li><strong>Risoluzione dei problemi dell'archiviazione</strong>: <ul>
  <li>È stato aggiunto un argomento per il [debug degli errori dell'archiviazione persistente](/docs/containers?topic=containers-cs_troubleshoot_storage#debug_storage).</li>
  <li>È stato aggiunto un argomento sulla risoluzione dei problemi relativi agli [errori di creazione del PVC a causa di autorizzazioni mancanti](/docs/containers?topic=containers-cs_troubleshoot_storage#missing_permissions).</li>
  </ul></li>
  </ul></td>
</tr>
<tr>
  <td>23 maggio 2019</td>
  <td><ul>
  <li><strong>Riferimenti CLI</strong>: è stata aggiornata la [pagina dei riferimenti CLI](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli) per riflettere più modifiche per la [release della versione 0.3.28](/docs/containers?topic=containers-cs_cli_changelog) del plugin della CLI {{site.data.keyword.containerlong_notm}}.</li>
  <li><strong>Changelog dei componenti aggiuntivi del cluster</strong>: è stata aggiornata l'[immagine `nginx-ingress` ALB alla build 457](/docs/containers?topic=containers-cluster-add-ons-changelog).</li>
  <li><strong>Stati del cluster e dei nodi di lavoro</strong>: è stata aggiornata la [pagina Registrazione e monitoraggio](/docs/containers?topic=containers-health#states) per aggiungere tabelle di riferimento sugli stati del cluster e dei nodi di lavoro.</li>
  <li><strong>Pianificazione e creazione del cluster</strong>: puoi ora trovare informazioni sulla pianificazione, creazione e rimozione del cluster e sulla pianificazione di rete nelle seguenti pagine:
    <ul><li>[Pianificazione della configurazione di rete del tuo cluster](/docs/containers?topic=containers-plan_clusters)</li>
    <li>[Pianificazione del tuo cluster per l'alta disponibilità](/docs/containers?topic=containers-ha_clusters)</li>
    <li>[Pianificazione della configurazione dei tuoi nodi di lavoro](/docs/containers?topic=containers-planning_worker_nodes)</li>
    <li>[Creazione dei cluster](/docs/containers?topic=containers-clusters)</li>
    <li>[Aggiunta di nodi di lavoro e di zone ai cluster](/docs/containers?topic=containers-add_workers)</li>
    <li>[Rimozione dei cluster](/docs/containers?topic=containers-remove)</li>
    <li>[Modifica degli endpoint del servizio o delle connessioni VLAN](/docs/containers?topic=containers-cs_network_cluster)</li></ul>
  </li>
  <li><strong>Aggiornamenti della versione del cluster</strong>: è stata aggiornata la [politica delle versioni non supportate](/docs/containers?topic=containers-cs_versions) per indicare che non puoi aggiornare il cluster se la versione del master è a tre o più versioni indietro rispetto alla più vecchia versione supportata. Puoi vedere se il cluster **non è supportato** esaminando il campo **State** quando elenchi i cluster.</li>
  <li><strong>Istio</strong>: è stata aggiornata la [pagina di Istio](/docs/containers?topic=containers-istio) per rimuovere la limitazione che impedisce a Istio di funzionare nei cluster connessi solo a una VLAN privata. È stato aggiunto un passo all'[argomento Aggiornamento di componenti aggiuntivi gestiti](/docs/containers?topic=containers-managed-addons#updating-managed-add-ons) per ricreare i gateway Istio che utilizzano le sezioni TLS al termine dell'aggiornamento del componente aggiuntivo gestito da Istio.</li>
  <li><strong>Argomenti popolari</strong>: gli argomenti popolari sono stati sostituiti con questa pagina delle note sulla release per le nuove funzioni e gli aggiornamenti specifici di {{site.data.keyword.containershort_notm}}. Per le informazioni più recenti sui prodotti {{site.data.keyword.cloud_notm}}, controlla gli [Annunci](https://www.ibm.com/cloud/blog/announcements).</li>
  </ul></td>
</tr>
<tr>
  <td>20 maggio 2019</td>
  <td><ul>
  <li><strong>Changelog di versione</strong>: sono stati aggiunti i [changelog di fix pack dei nodi di lavoro](/docs/containers?topic=containers-changelog).</li>
  </ul></td>
</tr>
<tr>
  <td>16 maggio 2019</td>
  <td><ul>
  <li><strong>Riferimenti CLI</strong>: è stata aggiornata la [pagina dei riferimenti CLI](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli) per aggiungere gli endpoint COS per i comandi `logging-collect` e per chiarire che `apiserver-refresh` riavvia i componenti master Kubernetes.</li>
  <li><strong>Non supportato: Kubernetes versione 1.10</strong>: [Kubernetes versione 1.10](/docs/containers?topic=containers-cs_versions#cs_v114) non è più supportato.</li>
  </ul></td>
</tr>
<tr>
  <td>15 maggio 2019</td>
  <td><ul>
  <li><strong>Versione Kubernetes predefinita</strong>: la versione predefinita di Kubernetes è ora la 1.13.6.</li>
  <li><strong>Limiti del servizio</strong>: è stato aggiunto un [argomento sulle limitazioni del servizio](/docs/containers?topic=containers-ibm-cloud-kubernetes-service-technology#tech_limits).</li>
  </ul></td>
</tr>
<tr>
  <td>13 maggio 2019</td>
  <td><ul>
  <li><strong>Changelog di versione</strong>: è stato aggiunto che sono disponibili nuovi aggiornamenti patch per [1.14.1_1518](/docs/containers?topic=containers-changelog#1141_1518), [1.13.6_1521](/docs/containers?topic=containers-changelog#1136_1521), [1.12.8_1552](/docs/containers?topic=containers-changelog#1128_1552), [1.11.10_1558](/docs/containers?topic=containers-changelog#11110_1558) e [1.10.13_1558](/docs/containers?topic=containers-changelog#11013_1558).</li>
  <li><strong>Tipi di nodo di lavoro</strong>: sono stati rimossi tutti i [tipi di nodi di lavoro della macchina virtuale](/docs/containers?topic=containers-planning_worker_nodes#vm) che hanno 48 o più core per [stato cloud ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://cloud.ibm.com/status?component=containers-kubernetes&selected=status). Puoi ancora eseguire il provisioning di [nodi di lavoro bare metal](/docs/containers?topic=containers-plan_clusters#bm) con 48 o più core.</li></ul></td>
</tr>
<tr>
  <td>08 maggio 2019</td>
  <td><ul>
  <li><strong>API</strong>: è stato aggiunto un link alla [documentazione swagger sull'API globale ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://containers.cloud.ibm.com/global/swagger-global-api/#/).</li>
  <li><strong>Cloud Object Storage</strong>: [è stata aggiunta una guida alla risoluzione dei problemi per Cloud Object Storage](/docs/containers?topic=containers-cs_troubleshoot_storage#cos_pvc_pending) nei tuoi cluster {{site.data.keyword.containerlong_notm}}.</li>
  <li><strong>Strategia Kubernetes</strong>: è stato aggiunto l'argomento [Quali conoscenze e competenze tecniche mi conviene avere prima che sposti le mie applicazioni su {{site.data.keyword.containerlong_notm}}?](/docs/containers?topic=containers-strategy#knowledge).</li>
  <li><strong>Kubernetes versione 1.14</strong>: è stato aggiunto che la [release di Kubernetes 1.14](/docs/containers?topic=containers-cs_versions#cs_v114) è certificata.</li>
  <li><strong>Argomenti di riferimento</strong>: sono state aggiornate le informazioni per varie operazioni di bind del servizio, `logging` e `nlb` nelle pagine di riferimento per l'[accesso utente](/docs/containers?topic=containers-access_reference) e la [CLI](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli).</li></ul></td>
</tr>
<tr>
  <td>7 maggio 2019</td>
  <td><ul>
  <li><strong>Provider DNS del cluster</strong>: [vengono spiegati i vantaggi di CoreDNS](/docs/containers?topic=containers-cluster_dns) ora che i cluster che eseguono Kubernetes 1.14 e versioni successive supportano solo CoreDNS.</li>
  <li><strong>Nodi edge</strong>: è stato aggiunto il supporto del programma di bilanciamento del carico privato per i [nodi edge](/docs/containers?topic=containers-edge).</li>
  <li><strong>Cluster gratuiti</strong>: è stato chiarito dove sono supportati i [cluster gratuiti](/docs/containers?topic=containers-regions-and-zones#regions_free).</li>
  <li><strong>Novità! Integrazioni</strong>: sono state aggiunte e ristrutturate le informazioni su [servizi {{site.data.keyword.cloud_notm}} e integrazioni di terze parti](/docs/containers?topic=containers-ibm-3rd-party-integrations), sulle [integrazioni popolari](/docs/containers?topic=containers-supported_integrations) e sulle [collaborazioni](/docs/containers?topic=containers-service-partners).</li>
  <li><strong>Novità! Kubernetes versione 1.14</strong>: crea o aggiorna i tuoi cluster in [Kubernetes 1.14](/docs/containers?topic=containers-cs_versions#cs_v114).</li>
  <li><strong>La versione 1.11 di Kubernetes è obsoleta</strong>: [aggiorna](/docs/containers?topic=containers-update) tutti i cluster che eseguono [Kubernetes 1.11](/docs/containers?topic=containers-cs_versions#cs_v111) prima che non siano più supportati.</li>
  <li><strong>Autorizzazioni</strong>: è stata aggiunta una FAQ, [Quali politiche di accesso assegno agli utenti del mio cluster?](/docs/containers?topic=containers-faqs#faq_access)</li>
  <li><strong>Pool di nodi di lavoro</strong>: sono state aggiunte istruzioni su come [applicare le etichette ai pool di nodi di lavoro esistenti](/docs/containers?topic=containers-add_workers#worker_pool_labels).</li>
  <li><strong>Argomenti di riferimento</strong>: per supportare le nuove funzioni come Kubernetes 1.14, sono state aggiornate le pagine di riferimento per i [changelog](/docs/containers?topic=containers-changelog#changelog).</li></ul></td>
</tr>
<tr>
  <td>01 maggio 2019</td>
  <td><strong>Assegnazione dell'accesso all'infrastruttura</strong>: è stata revisionata la [procedura per assegnare le autorizzazioni IAM per l'apertura dei casi di supporto](/docs/containers?topic=containers-users#infra_access).</td>
</tr>
</tbody></table>


