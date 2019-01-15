---

copyright:
  years: 2014, 2018
lastupdated: "2018-12-05"


---

{:new_window: target="blank"}
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

# Autorizzazioni di accesso utente
{: #understanding}



Quando [assegni le autorizzazioni del cluster](cs_users.html), può essere difficile valutare quale ruolo devi assegnare a un utente. Utilizza le tabelle riportate nelle seguenti sezioni per determinare il livello minimo di autorizzazioni necessarie per eseguire attività comuni in {{site.data.keyword.containerlong}}.
{: shortdesc}

## Piattaforma {{site.data.keyword.Bluemix_notm}} IAM e RBAC Kubernetes
{: #platform}

{{site.data.keyword.containerlong_notm}} è configurato per utilizzare i ruoli {{site.data.keyword.Bluemix_notm}} IAM (Identity and Access Management). I ruoli della piattaforma {{site.data.keyword.Bluemix_notm}} IAM determinano le azioni che gli utenti possono eseguire su un cluster. A ogni utente a cui viene assegnato un ruolo della piattaforma viene assegnato automaticamente anche un ruolo RBAC (role-based access control) di Kubernetes corrispondente nello spazio dei nomi predefinito. Inoltre, i ruoli della piattaforma impostano automaticamente le autorizzazioni di infrastruttura di base per gli utenti. Per impostare le politiche, vedi [Assegnazione delle autorizzazioni della piattaforma {{site.data.keyword.Bluemix_notm}} IAM](cs_users.html#platform). Per ulteriori informazioni sui ruoli RBAC, vedi [Assegnazione delle autorizzazioni RBAC](cs_users.html#role-binding).
{: shortdesc}

La seguente tabella mostra le autorizzazioni di gestione del cluster concesse da ciascun ruolo della piattaforma e le autorizzazioni delle risorse Kubernetes per i ruoli RBAC corrispondenti.

<table summary="La tabella mostra le autorizzazioni utente per i ruoli della piattaforma IAM e le politiche RBAC corrispondenti. Le righe devono essere lette da sinistra a destra, con il ruolo della piattaforma IAM nella colonna uno, l'autorizzazione cluster nella colonna due e il ruolo RBAC corrispondente nella colonna tre.">
<caption>Autorizzazioni di gestione del cluster per piattaforma e ruolo RBAC</caption>
<thead>
    <th>Ruolo piattaforma</th>
    <th>Autorizzazioni di gestione del cluster</th>
    <th>Ruolo RBAC corrispondente e autorizzazioni delle risorse</th>
</thead>
<tbody>
  <tr>
    <td>**Visualizzatore**</td>
    <td>
      Cluster:<ul>
        <li>Visualizzare il nome e l'indirizzo e-mail del proprietario della chiave API {{site.data.keyword.Bluemix_notm}} IAM per un gruppo di risorse e una regione</li>
        <li>Se il tuo account {{site.data.keyword.Bluemix_notm}} utilizza credenziali diverse per accedere al portfolio dell'infrastruttura IBM Cloud (SoftLayer), visualizzare il nome utente dell'infrastruttura</li>
        <li>Elencare o visualizzare i dettagli per i cluster, i nodi di lavoro , i pool di nodi di lavoro, i servizi in un cluster e i webhook</li>
        <li>Visualizzare lo stato di spanning della VLAN per l'account dell'infrastruttura</li>
        <li>Elencare le sottoreti disponibili nell'account dell'infrastruttura</li>
        <li>Quando impostato per un solo cluster: elencare le VLAN a cui è connesso il cluster in una zona</li>
        <li>Quando impostato per tutti i cluster nell'account: elencare tutte le VLAN disponibili in una zona</li></ul>
      Registrazione:<ul>
        <li>Visualizzare l'endpoint di registrazione predefinito per la regione di destinazione</li>
        <li>Elencare o visualizzare i dettagli per le configurazioni di inoltro e filtraggio log</li>
        <li>Visualizzare lo stato per gli aggiornamenti automatici del componente aggiuntivo Fluentd</li></ul>
      Ingress:<ul>
        <li>Elencare o visualizzare i dettagli per gli ALB in un cluster</li>
        <li>Visualizzare i tipi di ALB supportati nella regione</li></ul>
    </td>
    <td>Il ruolo cluster <code>view</code> viene applicato mediante il bind del ruolo <code>ibm-view</code>, che fornisce le seguenti autorizzazioni nello spazio dei nomi <code>default</code>:<ul>
      <li>Accesso in lettura alle risorse nello spazio dei nomi predefinito</li>
      <li>Nessun accesso in lettura ai segreti Kubernetes</li></ul>
    </td>
  </tr>
  <tr>
    <td>**Editor** <br/><br/><strong>Suggerimento</strong>: utilizza questo ruolo per gli sviluppatori dell'applicazione e assegna il ruolo **Sviluppatore** di <a href="#cloud-foundry">Cloud Foundry</a>.</td>
    <td>Questo ruolo ha tutte le autorizzazioni del ruolo Visualizzatore, oltre alle seguenti:</br></br>
      Cluster:<ul>
        <li>Eseguire il bind e l'annullamento del bind dei servizi {{site.data.keyword.Bluemix_notm}} a un cluster</li></ul>
      Registrazione:<ul>
        <li>Creare, aggiornare ed eliminare i webhook di controllo del server API</li>
        <li>Creare webhook del cluster</li>
        <li>Creare ed eliminare le configurazioni di inoltro log per tutti i tipi tranne `kube-audit`</li>
        <li>Aggiornare le configurazioni di inoltro log</li>
        <li>Creare, aggiornare ed eliminare le configurazioni di filtraggio log</li></ul>
      Ingress:<ul>
        <li>Abilitare o disabilitare gli ALB</li></ul>
    </td>
    <td>Il ruolo cluster <code>edit</code> viene applicato mediante il bind del ruolo <code>ibm-edit</code>, che fornisce le seguenti autorizzazioni nello spazio dei nomi <code>default</code>:
      <ul><li>Accesso in lettura/scrittura alle risorse nello spazio dei nomi predefinito</li></ul></td>
  </tr>
  <tr>
    <td>**Operatore**</td>
    <td>Questo ruolo ha tutte le autorizzazioni del ruolo Visualizzatore, oltre alle seguenti:</br></br>
      Cluster:<ul>
        <li>Aggiornare un cluster</li>
        <li>Aggiornare il master Kubernetes</li>
        <li>Aggiungere e rimuovere i nodi di lavoro</li>
        <li>Riavviare, ricaricare e aggiornare i nodi di lavoro</li>
        <li>Creare ed eliminare i pool di nodi di lavoro</li>
        <li>Aggiungere e rimuovere zone dai pool di nodi di lavoro</li>
        <li>Aggiornare la configurazione di rete per una determinata zona nei pool di nodi di lavoro</li>
        <li>Ridimensionare e riequilibrare i pool di nodi di lavoro</li>
        <li>Creare e aggiungere sottoreti a un cluster</li>
        <li>Aggiungere e rimuovere le sottoreti gestite dall'utente in un cluster</li></ul>
    </td>
    <td>Il ruolo cluster <code>admin</code> viene applicato mediante il bind del ruolo cluster <code>ibm-operate</code>, che fornisce le seguenti autorizzazioni:<ul>
      <li>Accesso in lettura/scrittura alle risorse all'interno di uno spazio dei nomi ma non allo spazio dei nomi stesso</li>
      <li>Creare ruoli RBAC all'interno di uno spazio dei nomi</li></ul></td>
  </tr>
  <tr>
    <td>**Amministratore**</td>
    <td>Questo ruolo ha tutte le autorizzazioni dei ruoli editor, operatore e visualizzatore per tutti i cluster in questo account, oltre alle seguenti:</br></br>
      Cluster:<ul>
        <li>Creare cluster gratuiti o standard</li>
        <li>Eliminare i cluster</li>
        <li>Crittografare i segreti Kubernetes utilizzando {{site.data.keyword.keymanagementservicefull}}</li>
        <li>Impostare la chiave API per l'account {{site.data.keyword.Bluemix_notm}} per accedere al portfolio dell'infrastruttura IBM Cloud (SoftLayer) collegato</li>
        <li>Impostare, visualizzare e rimuovere le credenziali dell'infrastruttura per l'account {{site.data.keyword.Bluemix_notm}} per accedere a un portfolio dell'infrastruttura IBM Cloud (SoftLayer) diverso</li>
        <li>Assegnare e modificare i ruoli della piattaforma {{site.data.keyword.Bluemix_notm}} IAM per altri utenti esistenti nell'account</li>
        <li>Quando impostato per tutte le istanze (cluster) {{site.data.keyword.containerlong_notm}} in tutte le regioni: elencare tutte le VLAN disponibili nell'account</ul>
      Registrazione:<ul>
        <li>Creare e aggiornare le configurazioni di inoltro log per il tipo `kube-audit`</li>
        <li>Raccogliere un'istantanea dei log del server API in un bucket di {{site.data.keyword.cos_full_notm}}</li>
        <li>Abilitare e disabilitare gli aggiornamenti automatici per il componente aggiuntivo del cluster Fluentd</li></ul>
      Ingress:<ul>
        <li>Elencare o visualizzare i dettagli per i segreti ALB in un cluster</li>
        <li>Distribuire un certificato dalla tua istanza {{site.data.keyword.cloudcerts_long_notm}} a un ALB</li>
        <li>Aggiornare o rimuovere i segreti ALB da un cluster</li></ul>
      <p class="note">Per creare risorse come macchine, VLAN e sottoreti, gli utenti Amministratore devono disporre del ruolo dell'infrastruttura **Super utente**.</p>
    </td>
    <td>Il ruolo cluster <code>cluster-admin</code> viene applicato mediante il bind del ruolo cluster <code>ibm-admin</code>, che fornisce le seguenti autorizzazioni:
      <ul><li>Accesso in lettura/scrittura alle risorse in ogni spazio dei nomi</li>
      <li>Creare ruoli RBAC all'interno di uno spazio dei nomi</li>
      <li>Accedere al dashboard Kubernetes</li>
      <li>Creare una risorsa Ingress che rende le applicazioni disponibili al pubblico</li></ul>
    </td>
  </tr>
  </tbody>
</table>



## Ruoli Cloud Foundry
{: #cloud-foundry}

I ruoli di Cloud Foundry concedono l'accesso a organizzazioni e spazi all'interno dell'account. Per visualizzare l'elenco dei servizi basati su Cloud Foundry in {{site.data.keyword.Bluemix_notm}}, esegui `ibmcloud service list`. Per ulteriori informazioni, vedi tutti i [ruoli disponibili per l'organizzazione e lo spazio](/docs/iam/cfaccess.html) o la procedura per la [gestione dell'accesso a Cloud Foundry](/docs/iam/mngcf.html) nella documentazione di {{site.data.keyword.Bluemix_notm}} IAM.
{: shortdesc}

La seguente tabella mostra i ruoli di Cloud Foundry richiesti per le autorizzazioni all'azione nel cluster.

<table summary="La tabella mostra le autorizzazioni utente per Cloud Foundry. Le righe devono essere lette da sinistra a destra, con il ruolo Cloud Foundry nella colonna uno e l'autorizzazione cluster nella colonna due.">
  <caption>Autorizzazioni di gestione del cluster per ruolo Cloud Foundry</caption>
  <thead>
    <th>Ruolo Cloud Foundry</th>
    <th>Autorizzazioni di gestione del cluster</th>
  </thead>
  <tbody>
  <tr>
    <td>Ruolo spazio: gestore</td>
    <td>Gestire l'accesso utente a uno spazio {{site.data.keyword.Bluemix_notm}}</td>
  </tr>
  <tr>
    <td>Ruolo spazio: sviluppatore</td>
    <td>
      <ul><li>Creare le istanze del servizio {{site.data.keyword.Bluemix_notm}}</li>
      <li>Eseguire il bind delle istanze del servizio {{site.data.keyword.Bluemix_notm}}
ai cluster</li>
      <li>Visualizzare i log dalla configurazione di inoltro log di un cluster a livello di spazio</li></ul>
    </td>
  </tr>
  </tbody>
</table>

## Ruoli dell'infrastruttura
{: #infra}

Quando un utente con il ruolo di accesso all'infrastruttura **Super utente** [imposta la chiave API per una regione e un gruppo di risorse](cs_users.html#api_key), le autorizzazioni dell'infrastruttura per gli altri utenti dell'account sono impostate dai ruoli della piattaforma {{site.data.keyword.Bluemix_notm}} IAM. Non dovrai modificare le autorizzazioni dell'infrastruttura IBM Cloud (SoftLayer) degli altri utenti. Utilizza la seguente tabella solo per personalizzare le autorizzazioni dell'infrastruttura IBM Cloud (SoftLayer) degli utenti quando non puoi assegnare il ruolo **Super utente** all'utente che imposta la chiave API. Per ulteriori informazioni, vedi [Personalizzazione delle autorizzazioni di infrastruttura](cs_users.html#infra_access).
{: shortdesc}

La seguente tabella mostra le autorizzazioni dell'infrastruttura richieste per completare gruppi di attività comuni.

<table summary="Autorizzazioni dell'infrastruttura per scenari comuni di {{site.data.keyword.containerlong_notm}}.">
 <caption>Autorizzazioni dell'infrastruttura comunemente richieste per {{site.data.keyword.containerlong_notm}}</caption>
 <thead>
  <th>Attività comuni in {{site.data.keyword.containerlong_notm}}</th>
  <th>Autorizzazioni dell'infrastruttura richieste per scheda</th>
 </thead>
 <tbody>
   <tr>
     <td><strong>Autorizzazioni minime</strong>: <ul><li>Crea un cluster.</li></ul></td>
     <td><strong>Dispositivi</strong>:<ul><li>Visualizza i dettagli di Virtual Server</li><li>Riavvia il server e visualizza le informazioni di sistema IPMI</li><li>Emetti i ricaricamenti SO e avvia il kernel di salvataggio</li></ul><strong>Account</strong>: <ul><li>Aggiungi server</li></ul></td>
   </tr>
   <tr>
     <td><strong>Amministrazione cluster</strong>: <ul><li>Crea, aggiorna ed elimina i cluster.</li><li>Aggiungi, ricarica e riavvia i nodi di lavoro.</li><li>Visualizza le VLAN.</li><li>Crea sottoreti.</li><li>Distribuisci i pod e i servizi di bilanciamento del carico.</li></ul></td>
     <td><strong>Supporto</strong>:<ul><li>Visualizza ticket</li><li>Aggiungi ticket</li><li>Modifica ticket</li></ul>
     <strong>Dispositivi</strong>:<ul><li>Visualizza i dettagli hardware</li><li>Visualizza i dettagli di Virtual Server</li><li>Riavvia il server e visualizza le informazioni di sistema IPMI</li><li>Emetti i ricaricamenti SO e avvia il kernel di salvataggio</li></ul>
     <strong>Rete</strong>:<ul><li>Aggiungi calcoli con la porta di rete pubblica</li></ul>
     <strong>Account</strong>:<ul><li>Annulla server</li><li>Aggiungi server</li></ul></td>
   </tr>
   <tr>
     <td><strong>Archiviazione</strong>: <ul><li>Crea attestazioni del volume persistente per il provisioning di volumi persistenti.</li><li>Crea e gestisci risorse dell'infrastruttura di archiviazione.</li></ul></td>
     <td><strong>Servizi</strong>:<ul><li>Gestisci archiviazione</li></ul><strong>Account</strong>:<ul><li>Aggiungi archiviazione</li></ul></td>
   </tr>
   <tr>
     <td><strong>Rete privata</strong>: <ul><li>Gestisci le VLAN private per la rete in cluster</li><li>Configura la connettività VPN per le reti private.</li></ul></td>
     <td><strong>Rete</strong>:<ul><li>Gestisci le rotte di sottorete della rete</li></ul></td>
   </tr>
   <tr>
     <td><strong>Rete pubblica</strong>:<ul><li>Configura la rete Ingress o programma di bilanciamento del carico pubblica per esporre le applicazioni.</li></ul></td>
     <td><strong>Dispositivi</strong>:<ul><li>Modifica nome host/dominio</li><li>Gestisci controllo porta</li></ul>
     <strong>Rete</strong>:<ul><li>Aggiungi calcoli con la porta di rete pubblica</li><li>Gestisci le rotte di sottorete della rete</li><li>Aggiungi indirizzi IP</li></ul>
     <strong>Servizi</strong>:<ul><li>Gestisci DNS, DNS inverso e WHOIS</li><li>Visualizza certificati (SSL)</li><li>Gestisci certificati (SSL)</li></ul></td>
   </tr>
 </tbody>
</table>
