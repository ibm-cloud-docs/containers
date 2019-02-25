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


# Controllo del traffico con le politiche di rete
{: #network_policies}

Ogni cluster Kubernetes è configurato con un plug-in di rete chiamato Calico. Le politiche di rete predefinite vengono configurate per proteggere l'interfaccia di rete pubblica di ogni nodo di lavoro in {{site.data.keyword.containerlong}}.
{: shortdesc}

Se hai dei requisiti di sicurezza univoci o hai un cluster multizona con lo spanning delle VLAN abilitato, puoi utilizzare Calico e Kubernetes per creare le politiche di rete di un cluster. Con le politiche di rete Kubernetes, specifica il traffico di rete che vuoi consentire o bloccare da e verso un pod in un cluster. Per impostare politiche di rete più avanzate come il blocco del traffico in entrata (ingress) per i servizi del programma di bilanciamento del carico, utilizza le politiche di rete Calico.

<ul>
  <li>
  [Kubernetes network policies ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/concepts/services-networking/network-policies/): queste politiche specificano i pod che possono comunicare con altri pod e con gli endpoint esterni. A partire da Kubernetes versione 1.8, sia il traffico di rete in entrata che in uscita può essere consentito o bloccato in base al protocollo, la porta o gli indirizzi IP di origine e destinazione. Il traffico può inoltre essere filtrato in base alle etichette dello spazio dei nomi e del pod. Le politiche di rete Kubernetes vengono applicate utilizzando i comandi `kubectl` o le API Kubernetes. Quando queste politiche vengono applicate, vengono automaticamente convertite in politiche Calico e quindi Calico applica tali politiche.
  </li>
  <li>
  Politiche di rete Calico per Kubernetes versione [1.10 e cluster successivi ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://docs.projectcalico.org/v3.1/getting-started/kubernetes/tutorials/advanced-policy) o [1.9 e cluster precedenti ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://docs.projectcalico.org/v2.6/getting-started/kubernetes/tutorials/advanced-policy): queste politiche sono un soprainsieme delle politiche di rete Kubernetes e vengono applicate utilizzando i comandi `calicoctl`. Le politiche Calico aggiungono le seguenti funzioni.
    <ul>
    <li>Consentire o bloccare il traffico di rete su interfacce di rete specifiche indipendentemente dall'indirizzo IP di destinazione o dall'origine del pod Kubernetes o dal CIDR</li>
    <li>Consentire o bloccare il traffico di rete per i pod tra gli spazi dei nomi.</li>
    <li>[Bloccare il traffico in entrata (ingress) ai servizi LoadBalancer o NodePort di Kubernetes](#block_ingress).</li>
    </ul>
  </li>
  </ul>

Calico applica queste politiche, incluse tutte le politiche di rete Kubernetes convertite automaticamente in politiche Calico, configurando le regole Iptables di Linux sui nodi di lavoro Kubernetes. Le regole iptables fungono da firewall
per il nodo di lavoro per definire le caratteristiche che il traffico di rete deve soddisfare per essere inoltrato
alla risorsa di destinazione.

Per utilizzare i servizi Ingress e del programma di bilanciamento del carico, usa le politiche di Calico e Kubernetes per gestire il traffico di rete in entrata e in uscita del tuo cluster. Non utilizzare i [gruppi di sicurezza](/docs/infrastructure/security-groups/sg_overview.html#about-security-groups) dell'infrastruttura IBM Cloud (SoftLayer). I gruppi di sicurezza dell'infrastruttura IBM Cloud (SoftLayer) vengono applicati all'interfaccia di rete di un singolo server virtuale per filtrare il traffico a livello dell'hypervisor. Tuttavia, i gruppi di sicurezza non supportano il protocollo VRRP, che viene utilizzato da {{site.data.keyword.containerlong_notm}} per gestire l'indirizzo IP del programma di bilanciamento del carico. Se il protocollo VRRP non è presente per gestire l'IP del programma di bilanciamento del carico, i servizi Ingress e del programma di bilanciamento del carico non funzioneranno correttamente.
{: tip}

<br />


## Politiche di rete Kubernetes e Calico predefinite
{: #default_policy}

Quando viene creato un cluster con una VLAN pubblica, viene creata automaticamente una risorsa HostEndpoint con l'etichetta `ibm.role: worker_public` per ogni nodo di lavoro e la relativa interfaccia di rete pubblica. Per proteggere l'interfaccia di rete pubblica di un nodo di lavoro, vengono applicate le politiche Calico predefinite per ogni endpoint host con l'etichetta `ibm.role: worker_public`.
{:shortdesc}

Queste politiche Calico predefinite consentono tutto il traffico di rete in uscita e il traffico in entrata a componenti cluster specifici, come i servizi Kubernetes NodePort, LoadBalancer e Ingress. Tutto il rimanente traffico di rete in entrata da Internet ai tuoi nodi di lavoro che non è specificato nelle politiche predefinite viene bloccato. Le politiche predefinite non influiscono sul traffico tra i pod

Controlla le seguenti politiche di rete Calico predefinite che vengono automaticamente applicate al tuo cluster.

Non rimuovere le politiche applicate a un endpoint host a meno che tu non abbia compreso pienamente la politica. Assicurati di non aver bisogno del traffico che viene consentito dalla politica.
{: important}

 <table summary="La prima riga nella tabella si estende su entrambe le colonne. Leggi il resto delle righe da sinistra a destra, con la zona server nella colonna uno e gli indirizzi IP corrispondenti nella colonna due.">
 <caption>Politiche Calico predefinite per ogni cluster</caption>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Politiche Calico predefinite per ogni cluster</th>
  </thead>
  <tbody>
    <tr>
      <td><code>allow-all-outbound</code></td>
      <td>Consente tutto il traffico in uscita.</td>
    </tr>
    <tr>
      <td><code>allow-bigfix-port</code></td>
      <td>Consente il traffico in entrata sulla porta 52311 nell'applicazione BigFix per consentire gli aggiornamenti necessari del nodo di lavoro.</td>
    </tr>
    <tr>
      <td><code>allow-icmp</code></td>
      <td>Consente i pacchetti ICMP in entrata (ping).</td>
     </tr>
    <tr>
      <td><code>allow-node-port-dnat</code></td>
      <td>Consente il traffico in entrata dei servizi di porta del nodo, programma di bilanciamento del carico e Ingress ai pod esposti da questi servizi. <strong>Nota</strong>: non hai bisogno di specificare le porte esposte perché Kubernetes utilizza la conversione dell'indirizzo di rete di destinazione (DNAT) per inoltrare le richieste di servizio ai pod corretti. L'inoltro avviene prima che le politiche dell'endpoint host vengano applicate in Iptables.</td>
   </tr>
   <tr>
      <td><code>allow-sys-mgmt</code></td>
      <td>Consente le connessioni in entrata per specifici sistemi dell'infrastruttura IBM Cloud (SoftLayer) utilizzati per gestire i nodi di lavoro.</td>
   </tr>
   <tr>
    <td><code>allow-vrrp</code></td>
    <td>Consente i pacchetti VRRP, utilizzati per monitorare e spostare gli indirizzi IP virtuali tra i nodi di lavoro.</td>
   </tr>
  </tbody>
</table>

Nei cluster Kubernetes versione 1.10 e nei più recenti, viene creata anche una politica Kubernetes predefinita che limita l'accesso al dashboard Kubernetes. Le politiche Kubernetes non vengono applicate all'endpoint host, ma invece al pod `kube-dashboard`. Questa politica si applica ai cluster collegati solo a una VLAN privata e ai cluster collegati a una VLAN privata e pubblica.

<table>
<caption>Politiche Kubernetes predefinite per ogni cluster</caption>
<thead>
<th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Politiche Kubernetes predefinite per ogni cluster</th>
</thead>
<tbody>
 <tr>
  <td><code>kubernetes-dashboard</code></td>
  <td><b>Solo in Kubernetes v1.10 o successive</b>, fornito nello spazio dei nomi <code>kube-system</code>: blocca a tutti i pod l'accesso al dashboard Kubernetes. Questa politica non influenza l'accesso al dashboard dalla console {{site.data.keyword.Bluemix_notm}} o tramite <code>kubectl proxy</code>. Se un pod necessita dell'accesso al dashboard, distribuiscilo in uno spazio dei nomi che ha un'etichetta <code>kubernetes-dashboard-policy: allow</code>.</td>
 </tr>
</tbody>
</table>

<br />


## Installazione e configurazione della CLI Calico
{: #cli_install}

Per visualizzare, gestire e aggiungere le politiche Calico, installare e configurare la CLI Calico.
{:shortdesc}

La compatibilità delle versioni Calico per le politiche e la configurazione della CLI variano in base alla versione Kubernetes del tuo cluster. Per installare e configurare la CLI Calico, fai clic su uno dei seguenti link in base alla tua versione del cluster:

* [Cluster Kubernetes versione 1.10 o successive](#1.10_install)
* [Cluster Kubernetes versione 1.9 o precedenti (obsoleto)](#1.9_install)

Prima di aggiornare il tuo cluster da Kubernetes versione 1.9 o precedenti alla versione 1.10 o successive, rivedi [Preparazione dell'aggiornamento a Calico v3](cs_versions.html#110_calicov3).
{: tip}

### Installa e configura la versione 3.3.1 della CLI Calico per i cluster che eseguono Kubernetes versione 1.10 o successive
{: #1.10_install}

1. [Accedi al tuo account. Specifica la regione appropriata e, se applicabile, il gruppo di risorse. Imposta il contesto per il tuo cluster](cs_cli_install.html#cs_cli_configure). Includi l'opzione `--admin` con il comando `ibmcloud ks
cluster-config`, che viene utilizzato per scaricare i file di autorizzazione e i certificati. Questo download include anche le chiavi per accedere al tuo portfolio dell'infrastruttura ed eseguire i comandi Calico sui tuoi nodi di lavoro.

  ```
  ibmcloud ks cluster-config <cluster_name> --admin
  ```
  {: pre}

2. Scarica il file di configurazione Calico per eseguire tutti i comandi di Calico.
    ```
    ibmcloud ks cluster-config <cluster_name_or_ID> --network
    ```
    {: pre}

3. Per gli utenti OSX e Linux, completa la seguente procedura.
    1. Crea la directory `/etc/calico`.
        ```
        sudo mkdir /etc/calico
        ```
        {: pre}

    2. Sposta nella directory il file di configurazione Calico che hai scaricato precedentemente.
        ```
        sudo mv /Users/<user>/.bluemix/plugins/container-service/clusters/<cluster_name>-admin/calicoctl.cfg /etc/calico
        ```
        {: pre}

4. [Scarica la CLI Calico ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/projectcalico/calicoctl/releases/tag/v3.3.1).

    Se stai utilizzando OSX, scarica la versione `-darwin-amd64`. Se stai utilizzando Windows, installa la CLI Calico nella stessa directory in cui si trova la CLI {{site.data.keyword.Bluemix_notm}}. Questa configurazione salva alcune modifiche al percorso file quando esegui il comando in un secondo momento. Assicurati di salvare il file come `calicoctl.exe`.
    {: tip}

5. Per gli utenti OSX e Linux, completa la seguente procedura.
    1. Sposta il file eseguibile nella directory _/usr/local/bin_.
        - Linux:

          ```
          mv filepath/calicoctl /usr/local/bin/calicoctl
          ```
          {: pre}

        - OS
X:

          ```
          mv filepath/calicoctl-darwin-amd64 /usr/local/bin/calicoctl
          ```
          {: pre}

    2. Rendi il file eseguibile.

        ```
        chmod +x /usr/local/bin/calicoctl
        ```
        {: pre}

6. Se le politiche di rete aziendali utilizzano proxy o firewall che impediscono l'accesso dal tuo sistema locale agli endpoint pubblici, [consenti l'accesso TCP dei comandi Calico](cs_firewall.html#firewall).

7. Verifica che la configurazione di Calico funzioni correttamente.

    - Linux e OS X:

      ```
      calicoctl get nodes
      ```
      {: pre}

    - Windows: utilizza l'indicatore `--config` per puntare al file di configurazione di rete che hai ottenuto nel passo 1. Includi questo indicatore ogni volta che esegui un comando `calicoctl`.

      ```
      calicoctl get nodes --config=filepath/calicoctl.cfg
      ```
      {: pre}

      Output:

      ```
      NAME
              kube-dal10-crc21191ee3997497ca90c8173bbdaf560-w1.cloud.ibm
              kube-dal10-crc21191ee3997497ca90c8173bbdaf560-w2.cloud.ibm
              kube-dal10-crc21191ee3997497ca90c8173bbdaf560-w3.cloud.ibm
      ```
      {: screen}


### Installazione e configurazione della versione 1.6.3 della CLI Calico per i cluster che eseguono Kubernetes versione 1.9 o precedenti (obsoleto)
{: #1.9_install}

La versione 1.9 di Kubernetes è obsoleta e non è supportata a partire dal 27 dicembre 2018. Le versioni precedenti di Kubernetes non sono supportate. Non appena possibile, [aggiorna](cs_cluster_update.html#update) o [crea](cs_clusters.html#clusters) i cluster che eseguono una [versione supportata](cs_versions.html#cs_versions).
{: note}

1. [Accedi al tuo account. Specifica la regione appropriata e, se applicabile, il gruppo di risorse. Imposta il contesto per il tuo cluster](cs_cli_install.html#cs_cli_configure). Includi l'opzione `--admin` con il comando `ibmcloud ks
cluster-config`, che viene utilizzato per scaricare i file di autorizzazione e i certificati. Questo download include anche le chiavi per accedere al tuo portfolio dell'infrastruttura ed eseguire i comandi Calico sui tuoi nodi di lavoro.

  ```
  ibmcloud ks cluster-config <cluster_name> --admin
  ```
  {: pre}


2. [Scarica la CLI Calico ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/projectcalico/calicoctl/releases/tag/v1.6.3).

    Se stai utilizzando OSX, scarica la versione `-darwin-amd64`. Se stai utilizzando Windows, installa la CLI Calico nella stessa directory in cui si trova la CLI {{site.data.keyword.Bluemix_notm}}. Questa configurazione salva alcune modifiche al percorso file quando esegui il comando in un secondo momento.
    {: tip}

3. Per gli utenti OSX e Linux, completa la seguente procedura.
    1. Sposta il file eseguibile nella directory _/usr/local/bin_.
        - Linux:
          ```
          mv filepath/calicoctl /usr/local/bin/calicoctl
          ```
          {: pre}

        - OS
X:
          ```
          mv filepath/calicoctl-darwin-amd64 /usr/local/bin/calicoctl
          ```
          {: pre}

    2. Rendi il file eseguibile.
        ```
        chmod +x /usr/local/bin/calicoctl
        ```
        {: pre}

4. Verifica che i comandi `calicoctl` vengano eseguiti correttamente controllando la versione client della CLI Calico.
    ```
    calicoctl version
    ```
    {: pre}

5. Se le politiche di rete aziendali utilizzano proxy o firewall che impediscono l'accesso dal tuo sistema locale agli endpoint pubblici: consulta [Esecuzione dei comandi `calicoctl` da dietro un firewall](cs_firewall.html#firewall) per le istruzioni su come consentire l'accesso TCP ai comandi Calico.

6. Per Linux e OS X, crea la directory `/etc/calico`. Per Windows, può essere utilizzata qualsiasi directory.
    ```
    sudo mkdir -p /etc/calico/
    ```
    {: pre}

7. Crea una file `calicoctl.cfg`.
    - Linux e OS X:
      ```
      sudo vi /etc/calico/calicoctl.cfg
      ```
      {: pre}

    - Windows: crea il file con un editor di testo.

8. Immetti le seguenti informazioni nel file <code>calicoctl.cfg</code>.

    ```
    apiVersion: v1
    kind: calicoApiConfig
    metadata:
    spec:
        etcdEndpoints: https://<ETCD_HOST>:<ETCD_PORT>
        etcdKeyFile: <CERTS_DIR>/admin-key.pem
        etcdCertFile: <CERTS_DIR>/admin.pem
        etcdCACertFile: <CERTS_DIR>/<ca-*pem_file>
    ```
    {: codeblock}

    1. Richiama `<ETCD_HOST>` e `<ETCD_PORT>`.
        1. Ottieni i valori di configurazione Calico dalla mappa di configurazione `cluster-info`.
            ```
            kubectl get cm -n kube-system cluster-info -o yaml
            ```
            {: pre}

        2. Nella sezione `data`, individua i valori `etcd_host` e `etcd_port`.

    2. Richiama `<CERTS_DIR>`, ossia la directory in cui vengono scaricati i certificati Kubernetes.

        - Linux e OS X:
          ```
          dirname $KUBECONFIG
          ```
          {: pre}

          Output di esempio:
          ```
          /home/sysadmin/.bluemix/plugins/container-service/clusters/<cluster_name>-admin/
          ```
          {: screen}

        - Windows:
          ```
          ECHO %KUBECONFIG%
          ```
          {: pre}

          Output di esempio:
          ```
          C:/Users/<user>/.bluemix/plugins/container-service/mycluster-admin/kube-config-prod-dal10-mycluster.yml
          ```
          {: screen}

        Per ottenere il percorso della directory, rimuovi il nome file `kube-config-prod-<zone>-<cluster_name>.yml` dalla fine dell'output.

    3. Richiama il
`ca-*pem_file`.

        - Linux e OS X:
          ```
          ls `dirname $KUBECONFIG` | grep "ca-"
          ```
          {: pre}

        - Windows:
          1. Apri la directory che hai richiamato nell'ultimo passo.
              ```
              C:\Users\<user>\.bluemix\plugins\container-service\<cluster_name>-admin\
              ```
              {: pre}

          2. Individua il file `ca-*pem_file`.

    4. Verifica che la configurazione di Calico funzioni correttamente.

        - Linux e OS X:
          ```
          calicoctl get nodes
          ```
          {: pre}

        - Windows: utilizza l'indicatore `--config` per puntare al file di configurazione di rete che hai creato. Includi questo indicatore ogni volta che esegui un comando `calicoctl`.
          ```
          calicoctl get nodes --config=filepath/calicoctl.cfg
          ```
          {: pre}

          Output:
          ```
          NAME
              kube-dal10-crc21191ee3997497ca90c8173bbdaf560-w1.cloud.ibm
              kube-dal10-crc21191ee3997497ca90c8173bbdaf560-w2.cloud.ibm
              kube-dal10-crc21191ee3997497ca90c8173bbdaf560-w3.cloud.ibm
          ```
          {: screen}

<br />


## Visualizzazione delle politiche di rete
{: #view_policies}

Visualizza i dettagli per impostazione predefinita e tutte le politiche di rete aggiunte che vengono applicate al tuo cluster.
{:shortdesc}

Prima di iniziare:
1. [Installa e configura la CLI Calico.](#cli_install)
2. [Indirizza la CLI Kubernetes al
cluster](cs_cli_install.html#cs_cli_configure). Includi l'opzione --admin con il comando ibmcloud ks
cluster-config`, che viene utilizzato per scaricare i file di autorizzazione e i certificati. Questo download include anche le chiavi per accedere al tuo portfolio dell'infrastruttura ed eseguire i comandi Calico sui tuoi nodi di lavoro.
    ```
    ibmcloud ks cluster-config <cluster_name> --admin
    ```
    {: pre}

La compatibilità delle versioni Calico per le politiche e la configurazione della CLI variano in base alla versione Kubernetes del tuo cluster. Per installare e configurare la CLI Calico, fai clic su uno dei seguenti link in base alla tua versione del cluster:

* [Cluster Kubernetes versione 1.10 o successive](#1.10_examine_policies)
* [Cluster Kubernetes versione 1.9 o precedenti (obsoleto)](#1.9_examine_policies)

La versione 1.9 di Kubernetes è obsoleta e non è supportata a partire dal 27 dicembre 2018. Le versioni precedenti di Kubernetes non sono supportate. Non appena possibile, [aggiorna](cs_cluster_update.html#update) o [crea](cs_clusters.html#clusters) i cluster che eseguono una [versione supportata](cs_versions.html#cs_versions). Prima di aggiornare il tuo cluster da Kubernetes versione 1.9 o precedenti alla versione 1.10 o successive, rivedi [Preparazione dell'aggiornamento a Calico v3](cs_versions.html#110_calicov3).
{: note}

### Visualizza le politiche di rete nei cluster che eseguono Kubernetes versione 1.10 o successive
{: #1.10_examine_policies}

Gli utenti Linux e Mac non hanno bisogno di includere l'indicatore `--config=filepath/calicoctl.cfg` nei comandi `calicoctl`.
{: tip}

1. Visualizza l'endpoint host Calico.

    ```
    calicoctl get hostendpoint -o yaml --config=filepath/calicoctl.cfg
    ```
    {: pre}

2. Visualizza tutte le politiche di rete di Calico e Kubernetes che sono state create per il cluster. Questo elenco contiene politiche che potrebbero non essere ancora applicate a tutti i pod o gli host. Affinché una politica di rete venga applicata, deve essere trovata una risorsa Kubernetes che corrisponda al selettore definito nella politica di rete Calico.

    [Le politiche di rete ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://docs.projectcalico.org/v3.1/reference/calicoctl/resources/networkpolicy) sono dedicate a spazi dei nomi specifici:
    ```
    calicoctl get NetworkPolicy --all-namespaces -o wide --config=filepath/calicoctl.cfg
    ```
    {:pre}

    [Le politiche di rete globali ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://docs.projectcalico.org/v3.1/reference/calicoctl/resources/globalnetworkpolicy) non sono dedicate a spazi dei nomi specifici:
    ```
    calicoctl get GlobalNetworkPolicy -o wide --config=filepath/calicoctl.cfg
    ```
    {: pre}

3. Visualizza i dettagli per una politica di rete.

    ```
    calicoctl get NetworkPolicy -o yaml <policy_name> --namespace <policy_namespace> --config=filepath/calicoctl.cfg
    ```
    {: pre}

4. Visualizza i dettagli di tutte le politiche di rete globali per il cluster.

    ```
    calicoctl get GlobalNetworkPolicy -o yaml --config=filepath/calicoctl.cfg
    ```
    {: pre}

### Visualizza le politiche di rete nei cluster che eseguono Kubernetes versione 1.9 o precedenti (obsoleto)
{: #1.9_examine_policies}

La versione 1.9 di Kubernetes è obsoleta e non è supportata a partire dal 27 dicembre 2018. Le versioni precedenti di Kubernetes non sono supportate. Non appena possibile, [aggiorna](cs_cluster_update.html#update) o [crea](cs_clusters.html#clusters) i cluster che eseguono una [versione supportata](cs_versions.html#cs_versions).
{: note}

Gli utenti Linux non devono includere l'indicatore `--config=filepath/calicoctl.cfg` nei comandi `calicoctl`.
{: tip}

1. Visualizza l'endpoint host Calico.

    ```
    calicoctl get hostendpoint -o yaml --config=filepath/calicoctl.cfg
    ```
    {: pre}

2. Visualizza tutte le politiche di rete di Calico e Kubernetes che sono state create per il cluster. Questo elenco contiene politiche che potrebbero non essere ancora applicate a tutti i pod o gli host. Affinché una politica di rete venga applicata, deve essere trovata una risorsa Kubernetes che corrisponda al selettore definito nella politica di rete Calico.

    ```
    calicoctl get policy -o wide --config=filepath/calicoctl.cfg
    ```
    {: pre}

3. Visualizza i dettagli per una politica di rete.

    ```
    calicoctl get policy -o yaml <policy_name> --config=filepath/calicoctl.cfg
    ```
    {: pre}

4. Visualizza i dettagli di tutte le politiche di rete per il cluster.

    ```
    calicoctl get policy -o yaml --config=filepath/calicoctl.cfg
    ```
    {: pre}

<br />


## Aggiunta di politiche di rete
{: #adding_network_policies}

Nella maggior parte dei casi, le politiche predefinite non devono essere modificate. Solo in scenari avanzati
potrebbero essere richieste delle modifiche. Se ritieni di dover apportare modifiche, puoi creare le tue politiche di rete.
{:shortdesc}

Per creare le politiche di rete Kubernetes, vedi la [documentazione della politica di rete Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/concepts/services-networking/network-policies/).

Per creare le politiche Calico, utilizza la seguente procedura. La compatibilità delle versioni Calico per le politiche e la configurazione della CLI variano in base alla versione Kubernetes del tuo cluster. Fai clic su uno dei seguenti link in base alla tua versione del cluster:

* [Cluster Kubernetes versione 1.10 o successive](#1.10_create_new)
* [Cluster Kubernetes versione 1.9 o precedenti (obsoleto)](#1.9_create_new)

La versione 1.9 di Kubernetes è obsoleta e non è supportata a partire dal 27 dicembre 2018. Le versioni precedenti di Kubernetes non sono supportate. Non appena possibile, [aggiorna](cs_cluster_update.html#update) o [crea](cs_clusters.html#clusters) i cluster che eseguono una [versione supportata](cs_versions.html#cs_versions). Prima di aggiornare il tuo cluster da Kubernetes versione 1.9 o precedenti alla versione 1.10 o successive, rivedi [Preparazione dell'aggiornamento a Calico v3](cs_versions.html#110_calicov3).
{: tip}

### Aggiunta delle politiche Calico nei cluster che eseguono Kubernetes versione 1.10 o successive
{: #1.10_create_new}

Prima di iniziare:
1. [Installa e configura la CLI Calico.](#cli_install)
2. [Indirizza la CLI Kubernetes al
cluster](cs_cli_install.html#cs_cli_configure). Includi l'opzione --admin con il comando ibmcloud ks
cluster-config`, che viene utilizzato per scaricare i file di autorizzazione e i certificati. Questo download include anche le chiavi per accedere al tuo portfolio dell'infrastruttura ed eseguire i comandi Calico sui tuoi nodi di lavoro.
    ```
    ibmcloud ks cluster-config <cluster_name> --admin
    ```
    {: pre}

1. Definisci la tua [politica di rete Calico ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://docs.projectcalico.org/v3.1/reference/calicoctl/resources/networkpolicy) o [politica di rete globale ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://docs.projectcalico.org/v3.1/reference/calicoctl/resources/globalnetworkpolicy) creando uno script di configurazione (`.yaml`). Questi file di configurazione includono i selettori che descrivono a quali pod, spazi dei nomi o host vengono applicate queste politiche. Fai riferimento a queste [politiche Calico di esempio ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](http://docs.projectcalico.org/v3.1/getting-started/kubernetes/tutorials/advanced-policy) per informazioni su come creare le tue proprie politiche. Nota che i cluster Kubernetes versione 1.10 o successive devono utilizzare la sintassi della politica Calico v3.

2. Applica le politiche al cluster.
    - Linux e OS X:

      ```
      calicoctl apply -f policy.yaml
      ```
      {: pre}

    - Windows:

      ```
      calicoctl apply -f filepath/policy.yaml --config=filepath/calicoctl.cfg
      ```
      {: pre}

### Aggiunta delle politiche Calico nei cluster che eseguono Kubernetes versione 1.9 o precedenti (obsoleto)
{: #1.9_create_new}

La versione 1.9 di Kubernetes è obsoleta e non è supportata a partire dal 27 dicembre 2018. Le versioni precedenti di Kubernetes non sono supportate. Non appena possibile, [aggiorna](cs_cluster_update.html#update) o [crea](cs_clusters.html#clusters) i cluster che eseguono una [versione supportata](cs_versions.html#cs_versions).
{: note}

Prima di iniziare:
1. [Installa e configura la CLI Calico.](#cli_install)
2. [Indirizza la CLI Kubernetes al
cluster](cs_cli_install.html#cs_cli_configure). Includi l'opzione --admin con il comando ibmcloud ks
cluster-config`, che viene utilizzato per scaricare i file di autorizzazione e i certificati. Questo download include anche le chiavi per accedere al tuo portfolio dell'infrastruttura ed eseguire i comandi Calico sui tuoi nodi di lavoro.
    ```
    ibmcloud ks cluster-config <cluster_name> --admin
    ```
    {: pre}

1. Definisci la tua [politica di rete Calico ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](http://docs.projectcalico.org/v2.6/reference/calicoctl/resources/policy) creando uno script di configurazione (`.yaml`). Questi file di configurazione includono i selettori che descrivono a quali pod, spazi dei nomi o host vengono applicate queste politiche. Fai riferimento a queste [politiche Calico di esempio ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](http://docs.projectcalico.org/v2.6/getting-started/kubernetes/tutorials/advanced-policy) per informazioni su come creare le tue proprie politiche. Nota che Kubernetes versione 1.9 o precedenti devono utilizzare la sintassi della politica Calico v2.


2. Applica le politiche al cluster.
    - Linux e OS X:

      ```
      calicoctl apply -f policy.yaml
      ```
      {: pre}

    - Windows:

      ```
      calicoctl apply -f filepath/policy.yaml --config=filepath/calicoctl.cfg
      ```
      {: pre}

<br />


## Controllo del traffico in entrata nei servizi del programma di bilanciamento del carico o NodePort
{: #block_ingress}

[Per impostazione predefinita](#default_policy), i servizi Kubernetes NodePort e LoadBalancer sono progettati per rendere le tue applicazioni disponibili su tutte le interfacce del cluster private e pubbliche. Tuttavia, puoi usare le politiche di Calico per bloccare il traffico in entrata ai tuoi servizi in base all'origine o alla destinazione del traffico.
{:shortdesc}

Le politiche predefinite di Kubernetes e Calico sono difficili da applicare per la protezione dei servizi Kubernetes NodePort e LoadBalancer a causa delle regole Iptables DNAT generate per questi servizi. Tuttavia, le politiche pre-DNAT impediscono al traffico specificato di raggiungere le tue applicazioni perché generano e applicano le regole Iptables prima che Kubernetes utilizzi la DNAT regolare per inoltrare il traffico ai pod.

Alcuni utilizzi comuni per le politiche di rete pre-DNAT di Calico:

  - Blocca il traffico verso le porte del nodo pubblico di un servizio del programma di bilanciamento del carico privato: un servizio del programma di bilanciamento del carico rende la tua applicazione disponibile tramite la porta e l'indirizzo IP del programma di bilanciamento del carico e tramite le porte del nodo del servizio. È possibile accedere alle porte del nodo da ogni indirizzo IP (pubblico e privato) di ogni nodo all'interno del cluster.
  - Blocca il traffico verso le porte del nodo pubblico sui cluster che eseguono i [nodi di lavoro edge](cs_edge.html#edge): il blocco delle porte del nodo assicura che i nodi di lavoro edge siano gli unici nodi di lavoro a gestire il traffico in entrata.
  - Blocca il traffico da determinati indirizzi IP di origine o CIDR (inserimento in blacklist)
  - Consenti il traffico solo da determinati indirizzi IP di origine o CIDR (inserimento in whitelist) e blocca tutto il resto del traffico

Per vedere come inserire in whitelist o in blacklist gli indirizzi IP di origine, prova l'[esercitazione Utilizzo delle politiche di rete Calico per bloccare il traffico](cs_tutorials_policies.html#policy_tutorial). Per ulteriori politiche di rete Calico di esempio che controllano il traffico verso o dal tuo cluster, puoi controllare la [demo della politica stars ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://docs.projectcalico.org/v3.1/getting-started/kubernetes/tutorials/stars-policy/) e la [politica di rete avanzata ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://docs.projectcalico.org/v3.1/getting-started/kubernetes/tutorials/advanced-policy).
{: tip}

1. Definisci una politica di rete pre-DNAT Calico per l'accesso in entrata (inbound traffic) ai servizi Kubernetes.
    * I cluster Kubernetes versione 1.10 o successive devono utilizzare la [sintassi della politica Calico v3 ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://docs.projectcalico.org/v3.1/reference/calicoctl/resources/networkpolicy). I cluster Kubernetes versione 1.9 o precedenti devono utilizzare la [sintassi della politica Calico v2 ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://docs.projectcalico.org/v2.6/reference/calicoctl/resources/policy).

        Risorsa di esempio che blocca tutte le porte del nodo:

        ```
        apiVersion: projectcalico.org/v3
        kind: GlobalNetworkPolicy
        metadata:
          name: deny-nodeports
        spec:
          applyOnForward: true
          ingress:
          - action: Deny
            destination:
              ports:
              - 30000:32767
            protocol: TCP
            source: {}
          - action: Deny
            destination:
              ports:
              - 30000:32767
            protocol: UDP
            source: {}
          preDNAT: true
          selector: ibm.role=='worker_public'
          order: 1100
          types:
          - Ingress
        ```
        {: codeblock}

2. Applica la politica di rete preDNAT Calico. Serve circa 1 minuto
perché le modifiche alla politica vengano applicate nel cluster.

  - Linux e OS X:

    ```
    calicoctl apply -f deny-nodeports.yaml
    ```
    {: pre}

  - Windows:

    ```
    calicoctl apply -f filepath/deny-nodeports.yaml --config=filepath/calicoctl.cfg
    ```
    {: pre}

3. Facoltativo: nei cluster multizona, un MZLB (multizone load balancer) controlla l'integrità degli ALB (application load balancer) Ingress in ciascuna zona del tuo cluster e mantiene aggiornati i risultati della ricerca DNS in base a questi controlli di integrità. Se usi politiche pre-DNAT per bloccare tutto il traffico in entrata ai servizi Ingress, devi anche inserire in whitelist gli [IP IPv4 di Cloudflare ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.cloudflare.com/ips/) usati per controllare l'integrità dei tuoi ALB. Per la procedura su come creare una politica Calico pre-DNAT per inserire in whitelist questi IP, vedi la Lezione 3 dell'[esercitazione della politica di rete Calico](cs_tutorials_policies.html#lesson3).

## Isolamento dei cluster sulla rete privata
{: #isolate_workers}

Se hai un cluster multizona, più VLAN per un cluster a zona singola o più sottoreti sulla stessa VLAN, devi [abilitare lo spanning della VLAN](/docs/infrastructure/vlans/vlan-spanning.html#vlan-spanning) in modo che i tuoi nodi di lavoro possano comunicare tra loro sulla rete privata. Tuttavia, quando lo spanning della VLAN è abilitato, qualsiasi sistema connesso a qualsiasi VLAN privata nello stesso account IBM Cloud può comunicare con i nodi di lavoro.

Puoi isolare il tuo cluster da altri sistemi sulla rete privata applicando delle [politiche di rete privata Calico![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/IBM-Cloud/kube-samples/tree/master/calico-policies/private-network-isolation). Questa serie di politiche Calico ed endpoint host isolano il traffico di rete privata di un cluster dalle altre risorse nella rete privata dell'account.

Le politiche sono mirate all'interfaccia privata del nodo di lavoro (eth0) e alla rete di pod di un cluster.

**Nodi di lavoro**

* L'uscita (egress) dell'interfaccia privata è consentita solo agli IP dei pod, ai nodi di lavoro in questo cluster e alla porta UPD/TCP 53 per l'accesso DNS, alla porta 2049 per la comunicazione con i file server NFS e alle porte 443 e 3260 per la comunicazione con l'archiviazione blocchi.
* L'entrata (ingress) dell'interfaccia privata è consentita solo dai nodi di lavoro nel cluster e solo a DNS, kubelet, ICMP e VRRP.

**Pod**

* Tutta l'entrata (ingress) ai pod è consentita dai nodi di lavoro nel cluster.
* L'uscita (egress) dai pod è limitata solo a IP pubblici, DNS, kubelet e altri pod nel cluster.

Prima di iniziare:
1. [Installa e configura la CLI Calico.](#cli_install)
2. [Indirizza la CLI Kubernetes al
cluster](cs_cli_install.html#cs_cli_configure). Includi l'opzione --admin con il comando ibmcloud ks
cluster-config`, che viene utilizzato per scaricare i file di autorizzazione e i certificati. Questo download include anche le chiavi per accedere al tuo portfolio dell'infrastruttura ed eseguire i comandi Calico sui tuoi nodi di lavoro.
    ```
    ibmcloud ks cluster-config <cluster_name> --admin
    ```
    {: pre}

Per isolare il tuo cluster sulla rete privata utilizzando le politiche Calico:

1. Clona il repository `IBM-Cloud/kube-samples`.
    ```
    git clone https://github.com/IBM-Cloud/kube-samples.git
    ```
    {: pre}

2. Passa alla directory delle politiche private per la versione Calico con cui è compatibile la tua versione del cluster.
    * Cluster Kubernetes versione 1.10 o successive:
      ```
      cd <filepath>/IBM-Cloud/kube-samples/calico-policies/private-network-isolation/calico-v3
      ```
      {: pre}

    * Cluster Kubernetes versione 1.9 o precedenti:
      ```
      cd <filepath>/IBM-Cloud/kube-samples/calico-policies/private-network-isolation/calico-v2
      ```
      {: pre}

3. Configura una politica per l'endpoint host privato.
    1. Apri la politica `generic-privatehostendpoint.yaml`.
    2. Sostituisci `<worker_name>` con il nome di un nodo di lavoro e `<worker-node-private-ip>` con l'indirizzo IP privato per il nodo di lavoro. Per visualizzare gli IP privati dei tuoi nodi di lavoro, esegui `ibmcloud ks workers --cluster <my_cluster>`.
    3. Ripeti questo passo in una nuova sezione per ciascun nodo di lavoro nel tuo cluster. **Nota**: ogni volta che aggiungi un nodo di lavoro a un cluster, devi aggiornare il file degli endpoint host con le nuove voci.

4. Applica tutte le politiche al tuo cluster.
    - Linux e OS X:

      ```
      calicoctl apply -f allow-all-workers-private.yaml
      calicoctl apply -f allow-ibm-ports-private.yaml
      calicoctl apply -f allow-egress-pods.yaml
      calicoctl apply -f allow-icmp-private.yaml
      calicoctl apply -f allow-vrrp-private.yaml
      calicoctl apply -f generic-privatehostendpoint.yaml
      ```
      {: pre}

    - Windows:

      ```
      calicoctl apply -f allow-all-workers-private.yaml --config=filepath/calicoctl.cfg
      calicoctl apply -f allow-ibm-ports-private.yaml --config=filepath/calicoctl.cfg
      calicoctl apply -f allow-egress-pods.yaml --config=filepath/calicoctl.cfg
      calicoctl apply -f allow-icmp-private.yaml --config=filepath/calicoctl.cfg
      calicoctl apply -f allow-vrrp-private.yaml --config=filepath/calicoctl.cfg
      calicoctl apply -f generic-privatehostendpoint.yaml --config=filepath/calicoctl.cfg
      ```
      {: pre}

## Controllo del traffico tra i pod
{: #isolate_services}

Le politiche di Kubernetes proteggono i pod dal traffico di rete interno. Puoi creare politiche di rete Kubernetes semplici per isolare tra loro i microservizi dell'applicazione all'interno di uno spazio dei nomi o tra spazi dei nomi.
{: shortdesc}

Per ulteriori informazioni su come le politiche di rete Kubernetes controllano il traffico da pod a pod e per ulteriori politiche di esempio, vedi la [documentazione Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/concepts/services-networking/network-policies/).
{: tip}

### Isolamento dei servizi dell'applicazione all'interno di uno spazio dei nomi
{: #services_one_ns}

Il seguente scenario dimostra come gestire il traffico tra i microservizi dell'applicazione all'interno di uno spazio dei nomi.

Un team Accounts distribuisce più servizi dell'applicazione in uno spazio dei nomi, ma devono essere isolati per consentire solo le comunicazioni necessarie tra i microservizi sulla rete pubblica. Per l'applicazione Srv1, il team ha servizi di frontend, backend e database. Ogni servizio viene etichettato con l'etichetta `app: Srv1` e l'etichetta `tier: frontend`, `tier: backend` o `tier: db`.

<img src="images/cs_network_policy_single_ns.png" width="200" alt="Usa una politica di rete per gestire il traffico tra gli spazi dei nomi." style="width:200px; border-style: none"/>

Il team Accounts desidera consentire il traffico dal frontend al backend e dal backend al database. Usano le etichette nelle loro politiche di rete per indicare quali flussi di traffico sono consentiti tra i microservizi.

Innanzitutto, creano una politica di rete Kubernetes che consente il traffico dal frontend al backend:

```
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  name: backend-allow
spec:
  podSelector:
    matchLabels:
      app: Srv1
      tier: backend
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: Srv1
          Tier: frontend
```
{: codeblock}

La sezione `spec.podSelector.matchLabels` elenca le etichette per il servizio backend Srv1 in modo che la politica venga applicata solo _a_ tali pod. La sezione `spec.ingress.from.podSelector.matchLabels` elenca le etichette per il servizio frontend Srv1 in modo che ingress sia consentito solo _da_ tali pod.

Quindi, creano una politica di rete Kubernetes simile che consentono il traffico dal backend al database:

```
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  name: db-allow
spec:
  podSelector:
    matchLabels:
      app: Srv1
      tier: db
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: Srv1
          Tier: backend
  ```
  {: codeblock}

La sezione `spec.podSelector.matchLabels` elenca le etichette per il servizio database Srv1 in modo che la politica venga applicata solo _a_ tali pod. La sezione `spec.ingress.from.podSelector.matchLabels` elenca le etichette per il servizio backend Srv1 in modo che ingress sia consentito solo _da_ tali pod.

Il traffico ora può passare dal frontend al backend e dal backend al database. Il database può rispondere al backend e il backend può rispondere al frontend, ma non possono essere stabilite connessioni di traffico inverso.

### Isolamento dei servizi dell'applicazione tra gli spazi dei nomi
{: #services_across_ns}

Il seguente scenario dimostra come gestire il traffico tra i microservizi dell'applicazione tra più spazi dei nomi.

I servizi di proprietà di diversi team secondari devono comunicare, ma sono distribuiti in spazi dei nomi diversi all'interno dello stesso cluster. Il team Accounts distribuisce i servizi frontend, backend e database per l'applicazione Srv1 nello spazio dei nomi accounts. Il team Finance distribuisce i servizi frontend, backend e database per l'applicazione Srv2 nello spazio dei nomi finance. Entrambi i team etichettano ciascun servizio con l'etichetta `app: Srv1` o `app: Srv2` e l'etichetta `tier: frontend`, `tier: backend` o `tier: db`. Etichettano anche gli spazi dei nomi con l'etichetta `usage: accounts` o `usage: finance`.

<img src="images/cs_network_policy_multi_ns.png" width="475" alt="Usa una politica di rete per gestire il traffico tra gli spazi dei nomi." style="width:475px; border-style: none"/>

Srv2 del team Finance deve richiamare le informazioni dal backend Srv1 del team Accounts. Quindi il team Accounts crea una politica di rete Kubernetes che usa le etichette per consentire tutto il traffico dallo spazio dei nomi finance al backend Srv1 nello spazio dei nomi accounts. Il team specifica anche la porta 3111 per isolare l'accesso tramite solo tale porta.

```
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  Namespace: accounts
  name: accounts-allow
spec:
  podSelector:
    matchLabels:
      app: Srv1
      Tier: backend
  ingress:
  - from:
    - NamespaceSelector:
        matchLabels:
          usage: finance
      ports:
        port: 3111
```
{: codeblock}

La sezione `spec.podSelector.matchLabels` elenca le etichette per il servizio backend Srv1 in modo che la politica venga applicata solo _a_ tali pod. La sezione `spec.ingress.from.NamespaceSelector.matchLabels` elenca l'etichetta per lo spazio dei nomi finance in modo che ingress sia consentito solo _dai_ servizi in tale spazio dei nomi.

Il traffico può ora passare dai microservizi finance al backend Srv1 accounts. Il backend Srv1 accounts può rispondere ai microservizi finance, ma non può stabilire una connessione di traffico inverso.

In questo esempio, è consentito tutto il traffico proveniente da tutti i microservizi nello spazio dei nomi finance. Non puoi consentire il traffico da specifici pod dell'applicazione in un altro spazio dei nomi in quanto `podSelector` e `namespaceSelector` non possono essere combinati.

## Registrazione del traffico rifiutato
{: #log_denied}

Per registrare le richieste di traffico rifiutate per specifici pod nel tuo cluster, puoi creare una politica di rete di log Calico.
{: shortdesc}

Quando configuri le politiche di rete per limitare il traffico ai pod dell'applicazione, le richieste di traffico che non sono consentite da queste politiche vengono rifiutate ed eliminate. In alcuni scenari, potresti volere ulteriori informazioni sulle richieste di traffico rifiutate. Ad esempio, potresti notare del traffico insolito che viene continuamente rifiutato da una delle tue politiche di rete. Per monitorare la potenziale minaccia alla sicurezza, puoi impostare la registrazione nei log per eseguire una registrazione ogni volta che la politica rifiuta un'azione tentata su specifici pod dell'applicazione.

Prima di iniziare:
1. [Installa e configura la CLI Calico.](#cli_install) **Nota**: le politiche in questi passi utilizzano la sintassi Calico v3 che è compatibile con i cluster che eseguono Kubernetes versione 1.10 o successive. Per i cluster che eseguono Kubernetes versione 1.9 o precedenti, devi utilizzare la [sintassi della politica Calico v2![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](http://docs.projectcalico.org/v2.6/reference/calicoctl/resources/policy).
2. [Indirizza la CLI Kubernetes al
cluster](cs_cli_install.html#cs_cli_configure). Includi l'opzione --admin con il comando ibmcloud ks
cluster-config`, che viene utilizzato per scaricare i file di autorizzazione e i certificati. Questo download include anche le chiavi per accedere al tuo portfolio dell'infrastruttura ed eseguire i comandi Calico sui tuoi nodi di lavoro.
    ```
    ibmcloud ks cluster-config <cluster_name> --admin
    ```
    {: pre}

Per creare una politica Calico per registrare il traffico rifiutato:

1. Crea o utilizza una politica di rete Kubernetes o Calico esistente che blocca o limita il traffico in entrata. Ad esempio, per controllare il traffico tra i pod, potresti utilizzare la seguente politica Kubernetes di esempio denominata `access-nginx` che limita l'accesso a un'applicazione NGINX. Il traffico in entrata ai pod con etichetta "run=nginx" è consentito solo dai pod con l'etichetta "run=access". Tutto l'altro traffico in entrata ai pod dell'applicazione "run=nginx" viene bloccato.
    ```
    kind: NetworkPolicy
    apiVersion: extensions/v1beta1
    metadata:
      name: access-nginx
    spec:
      podSelector:
        matchLabels:
          run: nginx
      ingress:
        - from:
          - podSelector:
              matchLabels:
                run: access
    ```
    {: codeblock}

2. Applica la politica.
    * Per applicare una politica Kubernetes:
        ```
        kubectl apply -f <policy_name>.yaml
        ```
        {: pre}
        La politica Kubernetes viene automaticamente convertita in una NetworkPolicy Calico in modo che Calico possa applicarla sotto forma di regole Iptables.

    * Per applicare una politica Calico:
        ```
        calicoctl apply -f <policy_name>.yaml --config=<filepath>/calicoctl.cfg
        ```
        {: pre}

3. Se hai applicato una politica Kubernetes, riesamina la sintassi della politica Calico creata automaticamente e copia il valore del campo `spec.selector`.
    ```
    calicoctl get policy -o yaml <policy_name> --config=<filepath>/calicoctl.cfg
    ```
    {: pre}

    Ad esempio, dopo la sua applicazione e conversione, la politica `access-nginx` ha la seguente sintassi Calico v3. Il campo `spec.selector` ha il valore `projectcalico.org/orchestrator == 'k8s' && run == 'nginx'`.
    ```
    apiVersion: projectcalico.org/v3
    kind: NetworkPolicy
    metadata:
      name: access-nginx
    spec:
      ingress:
      - action: Allow
        destination: {}
        source:
          selector: projectcalico.org/orchestrator == 'k8s' && run == 'access'
      order: 1000
      selector: projectcalico.org/orchestrator == 'k8s' && run == 'nginx'
      types:
      - Ingress
    ```
    {: screen}

4. Per registrare tutto il traffico rifiutato dalla politica Calico che hai creato precedentemente, crea una NetworkPolicy Calico denominata `log-denied-packets`. Ad esempio, utilizza la seguente politica per registrare tutti i pacchetti che erano stati negati dalla politica di rete che avevi definito nel passo 1. La politica di log utilizza lo stesso selettore di pod della politica `access-nginx` di esempio, che aggiunge questa politica alla catena di regole Iptables Calico. Utilizzando un numero di ordine più alto, come `3000`, puoi garantire che questa regola venga aggiunta alla fine della catena di regole Iptables. Qualsiasi pacchetto di richiesta dal pod "run=access" che corrisponde alla regola della politica `access-nginx` viene accettata dai pod "run=nginx".  Tuttavia, quando provano ad eseguire una messa in corrispondenza alla regola della politica `access-nginx` di basso ordine, i pacchetti da qualsiasi altra origine vengono rifiutati. Questi pacchetti provano quindi ad eseguire una messa in corrispondenza alla regola della politica `log-denied-packets` di alto ordine. `log-denied-packets` registra gli eventuali pacchetti che le arrivano e, quindi, vengono registrati solo i pacchetti che erano stati rifiutati dai pod "run=nginx". Dopo che i tentativi dei pacchetti sono stati registrati, i pacchetti vengono eliminati.
    ```
    apiVersion: projectcalico.org/v3
    kind: NetworkPolicy
    metadata:
      name: log-denied-packets
    spec:
      types:
      - Ingress
      ingress:
      - action: Log
        destination: {}
        source: {}
      selector: projectcalico.org/orchestrator == 'k8s' && run == 'nginx'
      order: 3000
    ```
    {: codeblock}

    <table>
    <caption>Descrizione dei componenti YAML della politica di log</caption>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Descrizione dei componenti YAML della politica di log</th>
    </thead>
    <tbody>
    <tr>
     <td><code>types</code></td>
     <td>Questa politica <code>Ingress</code> si applica a tutte le richieste di traffico in entrata. Il valore <code>Ingress</code> è un termine generico per tutto il traffico in entrata e non fa riferimento al traffico solo dall'ALB Ingress IBM.</td>
    </tr>
     <tr>
      <td><code>ingress</code></td>
      <td><ul><li><code>action</code>: l'azione <code>Log</code> scrive una voce di log per qualsiasi richiesta che corrisponde a questa politica nel percorso `/var/log/syslog` nel nodo di lavoro.</li><li><code>destination</code>: non è specificata alcuna destinazione perché il <code>selector</code> applica questa politica a tutti i pod con una specifica etichetta.</li><li><code>source</code>: questa politica si applica alle richieste da qualsiasi origine.</td>
     </tr>
     <tr>
      <td><code>selector</code></td>
      <td>Sostituisci &lt;selector&gt; con lo stesso selettore (selector) nel campo `spec.selector` che hai utilizzato nella tua politica Calico dal passo 1 o che hai trovato nella sintassi Calico per la tua politica Kubernetes nel passo 3. Ad esempio, utilizzando il selettore <code>selector: projectcalico.org/orchestrator == 'k8s' && run == 'nginx'</code>, la regola di questa politica viene aggiunta alla stessa catena Iptables della regola della politica di rete di esempio <code>access-nginx</code> nel passo 1. Questa politica si applica solo al traffico di rete in entrata ai pod che utilizzano la stessa etichetta di selettore di pod.</td>
     </tr>
     <tr>
      <td><code>order</code></td>
      <td>Le politiche Calico hanno degli ordini che determinano quando vengono applicate ai pacchetti di richiesta in entrata. Le politiche con ordini più bassi, come <code>1000</code>, sono applicate per prime. Le politiche con ordini più alti sono applicate dopo le politiche con ordini più bassi. Ad esempio, una politica con un ordine molto alto, come <code>3000</code>, viene effettivamente applicata dopo che sono state applicate tutte le politiche con un ordine più basso.</br></br>I pacchetti di richiesta in entrata passano attraverso la catena di regole Iptables e provano a mettere in corrispondenza prima le regole dalle politiche con un ordine più basso. Se corrisponde a una qualsiasi regola, il pacchetto viene accettato. Tuttavia, se un pacchetto non corrisponde ad alcuna regola, arriva all'ultima regola nella catena di regole Iptables con l'ordine più alto. Per assicurarti che questa sia l'ultima politica nella catena, utilizza un ordine molto più alto, come <code>3000</code>, rispetto alla politica che hai creato nel passo 1.</td>
     </tr>
    </tbody>
    </table>

5. Applica la politica.
    ```
    calicoctl apply -f log-denied-packets.yaml --config=<filepath>/calicoctl.cfg
    ```
    {: pre}

6. [Inoltra i log](cs_health.html#configuring) da `/var/log/syslog` a {{site.data.keyword.loganalysislong}} oppure a un server syslog esterno.
