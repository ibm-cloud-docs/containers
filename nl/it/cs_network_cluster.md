---

copyright:
  years: 2014, 2019
lastupdated: "2019-03-21"

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

# Configurazione della rete del tuo cluster
{: #cs_network_cluster}

Imposta una configurazione di rete nel tuo cluster {{site.data.keyword.containerlong}}.
{:shortdesc}

Questa pagina ti aiuta a impostare la configurazione di rete del tuo cluster. Non sai quale configurazione scegliere? Vedi [Pianificazione della rete del tuo cluster](/docs/containers?topic=containers-cs_network_ov).
{: tip}

## Configurazione della rete del cluster con una VLAN pubblica e una privata
{: #both_vlans}

Configura il tuo cluster con l'accesso a [una VLAN pubblica e a una VLAN privata](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_worker_options). La seguente immagine mostra le opzioni di rete che puoi configurare per il tuo cluster con questa impostazione.
{: shortdesc}

Questa impostazione di rete comprende le seguenti configurazioni di rete obbligatorie durante la creazione del cluster e configurazioni di rete facoltative dopo la creazione del cluster.

1. Se crei il cluster in un ambiente dietro un firewall, [consenti il traffico di rete in uscita verso gli IP pubblici e privati](/docs/containers?topic=containers-firewall#firewall_outbound) per i servizi {{site.data.keyword.Bluemix_notm}} che intendi utilizzare.

2. Crea un cluster connesso a una VLAN pubblica e una VLAN privata. Se crei un cluster multizona, puoi scegliere coppie di VLAN per ogni zona.

3. Scegli come comunicano il master Kubernetes e i tuoi nodi di lavoro.
  * Se nel tuo account {{site.data.keyword.Bluemix_notm}} è abilitato VRF, abilita [endpoint del servizio solo pubblici](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_public), [pubblici e privati](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_both) o [solo privati](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_private).
  * Se non puoi o non vuoi abilitare VRF, abilita [solo l'endpoint del servizio pubblico](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master_public).

4. Dopo aver creato il tuo cluster, puoi configurare le seguenti opzioni di rete:
  * Configura un [servizio di connessione VPN strongSwan](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_vpn_public) per consentire le comunicazioni tra il tuo cluster e una rete in loco o {{site.data.keyword.icpfull_notm}}.
  * Crea [servizi di rilevamento Kubernetes](/docs/containers?topic=containers-cs_network_planning#in-cluster) per consentire le comunicazioni in cluster tra i pod.
  * Crea servizi Ingress, programma di bilanciamento del carico o NodePort [pubblici](/docs/containers?topic=containers-cs_network_planning#public_access) per esporre le applicazioni alle reti pubbliche.
  * Crea servizi Ingress, programma di bilanciamento del carico o NodePort [privati](/docs/containers?topic=containers-cs_network_planning#private_both_vlans) per esporre le applicazioni alle reti private e crea politiche di rete Calico per proteggere il tuo cluster dall'accesso pubblico.
  * Isola i carichi di lavoro di rete nei [nodi di lavoro edge](/docs/containers?topic=containers-cs_network_planning#both_vlans_private_edge).
  * [Isola il tuo cluster sulla rete privata](/docs/containers?topic=containers-cs_network_planning#isolate).

<br />


## Configurazione della rete del cluster con una VLAN solo privata
{: #setup_private_vlan}

Se hai requisiti di sicurezza specifici o hai bisogno di creare politiche di rete e regole di instradamento personalizzate per fornire una sicurezza di rete dedicata, configura il tuo cluster con accesso a [una VLAN solo privata](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_worker_options). La seguente immagine mostra le opzioni di rete che puoi configurare per il tuo cluster con questa impostazione.
{: shortdesc}

Questa impostazione di rete comprende le seguenti configurazioni di rete obbligatorie durante la creazione del cluster e configurazioni di rete facoltative dopo la creazione del cluster.

1. Se crei il cluster in un ambiente dietro un firewall, [consenti il traffico di rete in uscita verso gli IP pubblici e privati](/docs/containers?topic=containers-firewall#firewall_outbound) per i servizi {{site.data.keyword.Bluemix_notm}} che intendi utilizzare.

2. Crea un cluster connesso [solo a una VLAN privata](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_worker_options). Se crei un cluster multizona, puoi scegliere una VLAN privata in ciascuna zona.

3. Scegli come comunicano il master Kubernetes e i tuoi nodi di lavoro.
  * Se nel tuo account {{site.data.keyword.Bluemix_notm}} è abilitato VRF, [abilita un endpoint del servizio privato](#set-up-private-se).
  * Se non puoi o non vuoi abilitare VRF, il master Kubernetes e i tuoi nodi di lavoro non possono connettersi automaticamente al master. Devi configurare il tuo cluster con un'[applicazione gateway](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_vpn_private).

4. Dopo aver creato il tuo cluster, puoi configurare le seguenti opzioni di rete:
  * [Configura un gateway VPN](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_vpn_private) per consentire le comunicazioni tra il tuo cluster e una rete in loco o {{site.data.keyword.icpfull_notm}}. Se in precedenza hai configurato un VRA o FSA per consentire le comunicazioni tra il master e i nodi di lavoro, puoi configurare un endpoint VPN IPSec su VRA o FSA.
  * Crea [servizi di rilevamento Kubernetes](/docs/containers?topic=containers-cs_network_planning#in-cluster) per consentire le comunicazioni in cluster tra i pod.
  * Crea servizi Ingress, programma di bilanciamento del carico o NodePort [privati](/docs/containers?topic=containers-cs_network_planning#plan_private_vlan) per esporre le applicazioni sulle reti private.
  * Isola i carichi di lavoro di rete nei [nodi di lavoro edge](/docs/containers?topic=containers-cs_network_planning#both_vlans_private_edge).
  * [Isola il tuo cluster sulla rete privata](/docs/containers?topic=containers-cs_network_planning#isolate).

<br />


## Modifica delle connessioni VLAN dei tuoi nodi di lavoro
{: #change-vlans}

Quando crei un cluster, scegli se connettere i tuo nodi di lavoro a una VLAN pubblica e a una privata o solo a una VLAN privata. I tuoi nodi di lavoro fanno parte dei pool di nodi di lavoro, che memorizzano i metadati di rete che includono le VLAN da utilizzare per il provisioning dei futuri nodi di lavoro nel pool. Potresti voler modificare la configurazione della connettività VLAN del tuo cluster in un secondo momento, in casi come quelli che seguono.
{: shortdesc}

* Le VLAN del pool di nodi lavoro in una zona esauriscono la capacità e devi eseguire il provisioning di una nuova VLAN che verrà utilizzata dai nodi di lavoro del tuo cluster.
* Hai un cluster con nodi di lavoro che si trovano su VLAN pubbliche e private, ma vuoi passare a un [cluster solo privato](#setup_private_vlan).
* Hai un cluster solo privato, ma vuoi alcuni nodi di lavoro come un pool di [nodi edge](/docs/containers?topic=containers-edge#edge) sulla VLAN pubblica per esporre le tua applicazioni su Internet.

Stai provando a cambiare l'endpoint del servizio per le comunicazioni tra master e nodi di lavoro? Controlla gli argomenti per configurare gli endpoint del servizio [pubblici](#set-up-public-se) e [privati](#set-up-private-se).
{: tip}

Prima di iniziare:
* [Accedi al tuo account. Specifica la regione appropriata e, se applicabile, il gruppo di risorse. Imposta il contesto per il tuo cluster](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure).
* Se i tuoi nodi di lavoro sono autonomi (non fanno parte di un pool), [aggiornali ai pool di nodi di lavoro](/docs/containers?topic=containers-update#standalone_to_workerpool).

Per modificare le VLAN utilizzate da un pool di nodi di lavoro per eseguire il provisioning dei nodi di lavoro:

1. Elenca i nomi dei pool di nodi di lavoro nel tuo cluster.
  ```
  ibmcloud ks worker-pools --cluster <cluster_name_or_ID>
  ```
  {: pre}

2. Determina le zone per uno dei pool di nodi di lavoro. Nell'output, cerca il campo **Zones**.
  ```
  ibmcloud ks worker-pool-get --cluster <cluster_name_or_ID> --worker-pool <pool_name>
  ```
  {: pre}

3. Per ogni zona che hai trovato nel passo precedente, ottieni una VLAN pubblica e una privata disponibili che siano compatibili tra loro.

  1. Controlla le VLAN pubbliche e private disponibili elencate nell'output sotto **Type**.
    ```
    ibmcloud ks vlans --zone <zone>
    ```
    {: pre}

  2. Controlla che le VLAN pubbliche e private nella zona siano compatibili. Per essere compatibili, il **Router** deve avere lo stesso ID pod. In questo output di esempio, gli ID pod **Router** corrispondono: `01a` e `01a`. Se un ID pod fosse `01a` e l'altro `02a`, non potresti impostare questi ID VLAN pubblici e privati per il tuo pool di nodi di lavoro.
    ```
    ID        Name   Number   Type      Router         Supports Virtual Workers
    229xxxx          1234     private   bcr01a.dal12   true
    229xxxx          5678     public    fcr01a.dal12   true
    ```
    {: screen}

  3. Se hai bisogno di ordinare una nuova VLAN pubblica o privata per la zona, puoi farlo mediante la [console {{site.data.keyword.Bluemix_notm}}](/docs/infrastructure/vlans?topic=vlans-ordering-premium-vlans#ordering-premium-vlans) o utilizzando il seguente comando. Ricorda che le VLAN devono essere compatibili, con gli ID pod **Router** corrispondenti come nel passo precedente. Se stai creando una coppia di nuove VLAN pubbliche e private, devono essere compatibili tra loro.
    ```
    ibmcloud sl vlan create -t [public|private] -d <zone> -r <compatible_router>
    ```
    {: pre}

  4. Prendi nota degli ID delle VLAN compatibili.

4. Configura un pool di nodi lavoro con i nuovi metadati della rete VLAN per ogni zona. Puoi creare un nuovo pool di nodi di lavoro o modificarne uno esistente.

  * **Crea un nuovo pool di nodi di lavoro**: vedi [Aggiunta di nodi di lavoro creando un nuovo pool di nodi di lavoro](/docs/containers?topic=containers-clusters#add_pool).

  * **Modifica un pool di nodi di lavoro esistente**: imposta i metadati di rete del pool di nodi di lavoro per utilizzare la VLAN per ogni zona. I nodi di lavoro che sono stati già creati nel pool continuano ad utilizzare le VLAN precedenti, ma i nuovi nodi di lavoro nel pool utilizzeranno i nuovi metadati della VLAN che hai impostato.

    * Esempio per aggiungere VLAN pubbliche e private, ad esempio se passi da solo privato a privato e pubblico:
      ```
      ibmcloud ks zone-network-set --zone <zone> --cluster <cluster_name_or_ID> --worker-pools <pool_name> --private-vlan <private_vlan_id> --public-vlan <public_vlan_id>
      ```
      {: pre}

    * Esempio per aggiungere solo una VLAN privata, ad esempio se passi da VLAN pubbliche e private a solo private quando hai un [account abilitato per VRF che utilizza gli endpoint del servizio](/docs/services/service-endpoint?topic=services/service-endpoint-getting-started#getting-started):
      ```
      ibmcloud ks zone-network-set --zone <zone> --cluster <cluster_name_or_ID> --worker-pools <pool_name> --private-vlan <private_vlan_id> --public-vlan <public_vlan_id>
      ```
      {: pre}

5. Aggiungi i nodi di lavoro al pool di nodi di lavoro ridimensionando il pool.
  ```
  ibmcloud ks worker-pool-resize --cluster <cluster_name_or_ID> --worker-pool <pool_name>  --size-per-zone <number_of_workers_per_zone>
  ```
  {: pre}

  Se vuoi rimuovere i nodi di lavoro che utilizzano i metadati di rete precedenti, modifica il numero di nodi di lavoro per zona per raddoppiare la quantità precedente di nodi di lavoro per zona. Più avanti in questi passi, puoi delimitare, svuotare e rimuovere i nodi di lavoro precedenti.
  {: tip}

6. Verifica che i nuovi nodi di lavoro siano creati con l'**IP pubblico** e **IP privato** appropriato nell'output. Ad esempio, se modifichi il pool di nodi lavoro da una VLAN pubblica e privata a solo privata, i nuovi nodi di lavoro hanno solo un IP privato. Se modifichi il pool di nodi di lavoro da una VLAN solo privata a VLAN pubbliche e private, i nuovi nodi di lavoro hanno IP sia pubblici che privati.
  ```
  ibmcloud ks workers --cluster <cluster_name_or_ID> --worker-pool <pool_name>
  ```
  {: pre}

7. Facoltativo: rimuovi i nodi di lavoro con i metadati di rete precedenti dal pool di nodi di lavoro.
  1. Nell'output del passo precedente, annota l'**ID** e l'**IP privato** dei nodi di lavoro che vuoi rimuovere dal pool.
  2. Contrassegna il nodo di lavoro come non pianificabile in un processo noto come delimitazione. Quando delimiti un nodo di lavoro, lo rendi non disponibile per una futura pianificazione di pod.
    ```
    kubectl cordon <worker_private_ip>
    ```
    {: pre}
  3. Verifica che la pianificazione di pod sia disabilitata per il tuo nodo di lavoro.
    ```
    kubectl get nodes
    ```
    {: pre}
     Il tuo nodo di lavoro è disabilitato per la pianificazione di pod se lo stato visualizza **`SchedulingDisabled`**.
  4. Forza la rimozione dei pod dal tuo nodo di lavoro e la loro ripianificazione sui nodi di lavoro rimanenti nel cluster.
    ```
    kubectl drain <worker_private_ip>
    ```
    {: pre}
     Questo processo può richiedere qualche minuto.
  5. Rimuovi il nodo di lavoro. Utilizza l'ID nodo di lavoro che hai richiamato in precedenza.
    ```
    ibmcloud ks worker-rm --cluster <cluster_name_or_ID> --worker <worker_name_or_ID>
    ```
    {: pre}
  6. Verifica che il nodo di lavoro venga rimosso.
    ```
    ibmcloud ks workers --cluster <cluster_name_or_ID> --worker-pool <pool_name>
    ```
    {: pre}

8. Facoltativo: puoi ripetere i passi 2 - 7 per ogni pool di nodi di lavoro nel tuo cluster. Dopo aver completato questi passi, tutti i nodi di lavoro nel cluster sono configurati con le nuove VLAN.

9. Gli ALB predefiniti nel tuo cluster sono ancora associati alla vecchia VLAN perché i loro indirizzi IP provengono da una sottorete su tale VLAN. Poiché gli ALB non possono essere spostati tra le VLAN, puoi invece [creare ALB sulle nuove VLAN e disabilitare gli ALB sulle vecchie VLAN](/docs/containers?topic=containers-ingress#migrate-alb-vlan).

<br />


## Configurazione dell'endpoint del servizio privato
{: #set-up-private-se}

Nei cluster che eseguono Kubernetes versione 1.11 o successiva, abilita o disabilita l'endpoint del servizio privato per il tuo cluster.
{: shortdesc}

L'endpoint del servizio privato rende il tuo master Kubernetes accessibile privatamente. I tuoi nodi di lavoro e gli utenti del cluster autorizzati possono comunicare con il master Kubernetes sulla rete privata. Per determinare se puoi abilitare l'endpoint del servizio privato, vedi [Pianificazione delle comunicazioni tra master e nodi di lavoro](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master). Nota che non puoi disabilitare l'endpoint del servizio privato dopo averlo abilitato.

**Passi da abilitare durante la creazione del cluster**</br>
1. Abilita [VRF](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#customer-vrf-overview) nel tuo account dell'infrastruttura IBM Cloud (SoftLayer).
2. [Abilita il tuo account {{site.data.keyword.Bluemix_notm}} per l'utilizzo degli endpoint del servizio](/docs/services/service-endpoint?topic=services/service-endpoint-getting-started#getting-started).
3. Se crei il cluster in un ambiente dietro un firewall, [consenti il traffico di rete in uscita verso gli IP pubblici e privati](/docs/containers?topic=containers-firewall#firewall_outbound) per le risorse dell'infrastruttura e per i servizi {{site.data.keyword.Bluemix_notm}} che intendi utilizzare.
4. Crea un cluster:
  * [Crea un cluster con la CLI](/docs/containers?topic=containers-clusters#clusters_cli) e utilizza l'indicatore `--private-service-endpoint`. Se vuoi abilitare anche l'endpoint del servizio pubblico, usa anche l'indicatore `--public-service-endpoint`.
  * [Crea un cluster con l'IU](/docs/containers?topic=containers-clusters#clusters_ui_standard) e seleziona **Private endpoint only**. Se vuoi abilitare anche l'endpoint del servizio pubblico, seleziona **Public and private endpoints**.
5. Se abiliti solo l'endpoint del servizio privato per un cluster in un ambiente dietro un firewall:
  1. Verifica di trovarti nella tua rete privata {{site.data.keyword.Bluemix_notm}} o di essere connesso alla rete privata tramite una connessione VPN.
  2. [Consenti agli utenti del cluster autorizzati di eseguire i comandi `kubectl`](/docs/containers?topic=containers-firewall#firewall_kubectl) per accedere al master tramite l'endpoint del servizio privato. Per eseguire i comandi `kubectl`, gli utenti del tuo cluster devono trovarsi nella tua rete privata {{site.data.keyword.Bluemix_notm}} o connettersi alla rete privata tramite una connessione VPN.
  3. Se il tuo accesso di rete è protetto da un firewall aziendale, devi [consentire l'accesso agli endpoint pubblici per l'API `ibmcloud` e l'API `ibmcloud ks` nel tuo firewall](/docs/containers?topic=containers-firewall#firewall_bx). Anche se tutte le comunicazioni al master passano sulla rete privata, i comandi `ibmcloud` e `ibmcloud ks` devono passare sugli endpoint API pubblici.

  </br>

**Passi da abilitare dopo la creazione del cluster**</br>
1. Abilita [VRF](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#customer-vrf-overview) nel tuo account dell'infrastruttura IBM Cloud (SoftLayer).
2. [Abilita il tuo account {{site.data.keyword.Bluemix_notm}} per l'utilizzo degli endpoint del servizio](/docs/services/service-endpoint?topic=services/service-endpoint-getting-started#getting-started).
3. Abilita l'endpoint del servizio privato.
  ```
  ibmcloud ks cluster-feature-enable private-service-endpoint --cluster <cluster_name_or_ID>
  ```
  {: pre}
4. Aggiorna il server API del master Kubernetes per utilizzare l'endpoint del servizio privato. Puoi seguire la richiesta nella CLI o eseguire manualmente il seguente comando.
  ```
  ibmcloud ks apiserver-refresh --cluster <cluster_name_or_ID>
  ```
  {: pre}

5. [Crea una mappa di configurazione](/docs/containers?topic=containers-update#worker-up-configmap) per controllare il numero massimo di nodi di lavoro che possono essere non disponibili contemporaneamente nel tuo cluster. Quando aggiorni i tuoi nodi di lavoro, la mappa di configurazione aiuta ad evitare tempi di inattività per le tue applicazioni in quanto le applicazioni vengono ripianificate ordinatamente sui nodi di lavoro disponibili.
6. Aggiorna tutti i nodi di lavoro nel tuo cluster per acquisire la configurazione dell'endpoint del servizio privato.

  <p class="important">Immettendo il comando di aggiornamento, i nodi di lavoro vengono ricaricati per acquisire la configurazione dell'endpoint del servizio. Se non è disponibile alcun aggiornamento di nodi di lavoro, devi [ricaricare manualmente i nodi di lavoro](/docs/containers?topic=containers-cs_cli_reference#cs_cli_reference). Se ricarichi, assicurati di delimitare, svuotare e gestire l'ordine per controllare il numero massimo di nodi di lavoro che non sono disponibili contemporaneamente.</p>
  ```
  ibmcloud ks worker-update --cluster <cluster_name_or_ID> --workers <worker1,worker2>
  ```
  {: pre}

8. Se il cluster si trova in un ambiente dietro un firewall:
  * [Consenti agli utenti del cluster autorizzati di eseguire i comandi `kubectl` per accedere al master tramite l'endpoint del servizio privato.](/docs/containers?topic=containers-firewall#firewall_kubectl)
  * [Consenti il traffico di rete in uscita verso gli IP privati](/docs/containers?topic=containers-firewall#firewall_outbound) per le risorse dell'infrastruttura e per i servizi {{site.data.keyword.Bluemix_notm}} che intendi utilizzare.

9. Facoltativo: per utilizzare solo l'endpoint del servizio privato, disabilita l'endpoint del servizio pubblico.
  ```
  ibmcloud ks cluster-feature-disable public-service-endpoint --cluster <cluster_name_or_ID>
  ```
  {: pre}
  </br>

**Passi da disabilitare**</br>
L'endpoint del servizio privato non può essere disabilitato.

## Configurazione dell'endpoint del servizio pubblico
{: #set-up-public-se}

Abilita o disabilita l'endpoint del servizio pubblico per il tuo cluster.
{: shortdesc}

L'endpoint del servizio pubblico rende il tuo master Kubernetes accessibile pubblicamente. I tuoi nodi di lavoro e gli utenti del cluster autorizzati possono comunicare in modo sicuro con il master Kubernetes sulla rete pubblica. Per determinare se puoi abilitare l'endpoint del servizio pubblico, vedi [Pianificazione delle comunicazioni tra i nodi di lavoro e il master Kubernetes](/docs/containers?topic=containers-cs_network_ov#cs_network_ov_master).

**Passi da abilitare durante la creazione del cluster**</br>

1. Se crei il cluster in un ambiente dietro un firewall, [consenti il traffico di rete in uscita verso gli IP pubblici e privati](/docs/containers?topic=containers-firewall#firewall_outbound) per i servizi {{site.data.keyword.Bluemix_notm}} che intendi utilizzare.

2. Crea un cluster:
  * [Crea un cluster con la CLI](/docs/containers?topic=containers-clusters#clusters_cli) e utilizza l'indicatore `--public-service-endpoint`. Se vuoi abilitare anche l'endpoint del servizio privato, usa anche l'indicatore `--private-service-endpoint`.
  * [Crea un cluster con l'IU](/docs/containers?topic=containers-clusters#clusters_ui_standard) e seleziona **Public endpoint only**. Se vuoi abilitare anche l'endpoint del servizio privato, seleziona **Public and private endpoints**.

3. Se crei il cluster in un ambiente dietro un firewall, [consenti agli utenti del cluster autorizzati di eseguire i comandi `kubectl` per accedere al master solo tramite l'endpoint del servizio privato o tramite gli endpoint del servizio pubblici e privati.](/docs/containers?topic=containers-firewall#firewall_kubectl)

  </br>

**Passi da abilitare dopo la creazione del cluster**</br>
Se in precedenza hai disabilitato l'endpoint pubblico, puoi riabilitarlo.
1. Abilita l'endpoint del servizio pubblico.
  ```
  ibmcloud ks cluster-feature-enable public-service-endpoint --cluster <cluster_name_or_ID>
  ```
  {: pre}
2. Aggiorna il server API del master Kubernetes per utilizzare l'endpoint del servizio pubblico. Puoi seguire la richiesta nella CLI o eseguire manualmente il seguente comando.
  ```
  ibmcloud ks apiserver-refresh --cluster <cluster_name_or_ID>
  ```
  {: pre}

  </br>

**Passi da disabilitare**</br>
Per disabilitare l'endpoint del servizio pubblico, devi prima abilitare l'endpoint del servizio privato in modo che i tuoi nodi di lavoro possano comunicare con il master Kubernetes.
1. Abilita l'endpoint del servizio privato.
  ```
  ibmcloud ks cluster-feature-enable private-service-endpoint --cluster <cluster_name_or_ID>
  ```
  {: pre}
2. Aggiorna il server API del master Kubernetes per utilizzare l'endpoint del servizio privato seguendo la richiesta nella CLI o eseguendo manualmente il seguente comando.
  ```
  ibmcloud ks apiserver-refresh --cluster <cluster_name_or_ID>
  ```
  {: pre}
3. [Crea una mappa di configurazione](/docs/containers?topic=containers-update#worker-up-configmap) per controllare il numero massimo di nodi di lavoro che possono essere non disponibili contemporaneamente nel tuo cluster. Quando aggiorni i tuoi nodi di lavoro, la mappa di configurazione aiuta ad evitare tempi di inattività per le tue applicazioni in quanto le applicazioni vengono ripianificate ordinatamente sui nodi di lavoro disponibili.

4. Aggiorna tutti i nodi di lavoro nel tuo cluster per acquisire la configurazione dell'endpoint del servizio privato.

  <p class="important">Immettendo il comando di aggiornamento, i nodi di lavoro vengono ricaricati per acquisire la configurazione dell'endpoint del servizio. Se non è disponibile alcun aggiornamento di nodi di lavoro, devi [ricaricare manualmente i nodi di lavoro](/docs/containers?topic=containers-cs_cli_reference#cs_cli_reference). Se ricarichi, assicurati di delimitare, svuotare e gestire l'ordine per controllare il numero massimo di nodi di lavoro che non sono disponibili contemporaneamente.</p>
  ```
  ibmcloud ks worker-update --cluster <cluster_name_or_ID> --workers <worker1,worker2>
  ```
  {: pre}
5. Disabilita l'endpoint del servizio pubblico.
  ```
  ibmcloud ks cluster-feature-disable public-service-endpoint --cluster <cluster_name_or_ID>
  ```
  {: pre}

## Passaggio dall'endpoint del servizio pubblico all'endpoint del servizio privato
{: #migrate-to-private-se}

Nei cluster che eseguono Kubernetes versione 1.11 o successiva, consenti ai nodi di lavoro di comunicare con il master sulla rete privata anziché sulla rete pubblica abilitando l'endpoint del servizio privato.
{: shortdesc}

Tutti i cluster connessi a una VLAN pubblica e una VLAN privata utilizzano l'endpoint del servizio pubblico per impostazione predefinita. I tuoi nodi di lavoro e gli utenti del cluster autorizzati possono comunicare in modo sicuro con il master Kubernetes sulla rete pubblica. Per consentire ai nodi di lavoro di comunicare con il master Kubernetes sulla rete privata anziché sulla rete pubblica, puoi abilitare l'endpoint del servizio privato. In seguito, puoi facoltativamente disabilitare l'endpoint del servizio pubblico.
* Se abiliti l'endpoint del servizio privato e mantieni abilitato anche l'endpoint del servizio pubblico, i nodi di lavoro comunicano con il master sempre sulla rete privata, ma i tuoi utenti possono comunicare con il master sulla rete pubblica o privata.
* Se abiliti l'endpoint del servizio privato ma disabiliti l'endpoint del servizio pubblico, i nodi di lavoro e gli utenti devono comunicare con il master sulla rete privata.

Nota che non puoi disabilitare l'endpoint del servizio privato dopo averlo abilitato.

1. Abilita [VRF](/docs/infrastructure/direct-link?topic=direct-link-overview-of-virtual-routing-and-forwarding-vrf-on-ibm-cloud#customer-vrf-overview) nel tuo account dell'infrastruttura IBM Cloud (SoftLayer).
2. [Abilita il tuo account {{site.data.keyword.Bluemix_notm}} per l'utilizzo degli endpoint del servizio](/docs/services/service-endpoint?topic=services/service-endpoint-getting-started#getting-started).
3. Abilita l'endpoint del servizio privato.
  ```
  ibmcloud ks cluster-feature-enable private-service-endpoint --cluster <cluster_name_or_ID>
  ```
  {: pre}
4. Aggiorna il server API del master Kubernetes per utilizzare l'endpoint del servizio privato seguendo la richiesta nella CLI o eseguendo manualmente il seguente comando.
  ```
  ibmcloud ks apiserver-refresh --cluster <cluster_name_or_ID>
  ```
  {: pre}
5. [Crea una mappa di configurazione](/docs/containers?topic=containers-update#worker-up-configmap) per controllare il numero massimo di nodi di lavoro che possono essere non disponibili contemporaneamente nel tuo cluster. Quando aggiorni i tuoi nodi di lavoro, la mappa di configurazione aiuta ad evitare tempi di inattività per le tue applicazioni in quanto le applicazioni vengono ripianificate ordinatamente sui nodi di lavoro disponibili.

6.  Aggiorna tutti i nodi di lavoro nel tuo cluster per acquisire la configurazione dell'endpoint del servizio privato.

    <p class="important">Immettendo il comando di aggiornamento, i nodi di lavoro vengono ricaricati per acquisire la configurazione dell'endpoint del servizio. Se non è disponibile alcun aggiornamento di nodi di lavoro, devi [ricaricare manualmente i nodi di lavoro](/docs/containers?topic=containers-cs_cli_reference#cs_cli_reference). Se ricarichi, assicurati di delimitare, svuotare e gestire l'ordine per controllare il numero massimo di nodi di lavoro che non sono disponibili contemporaneamente.</p>
    ```
    ibmcloud ks worker-update --cluster <cluster_name_or_ID> --workers <worker1,worker2>
    ```
    {: pre}

7. Facoltativo: disabilita l'endpoint del servizio pubblico.
  ```
  ibmcloud ks cluster-feature-disable public-service-endpoint --cluster <cluster_name_or_ID>
  ```
  {: pre}
