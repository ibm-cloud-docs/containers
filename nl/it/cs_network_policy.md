---

copyright:
  years: 2014, 2018
lastupdated: "2018-08-06"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Controllo del traffico con le politiche di rete
{: #network_policies}

Ogni cluster Kubernetes è configurato con un plugin di rete chiamato Calico. Le politiche di rete predefinite vengono configurate per proteggere l'interfaccia di rete pubblica di ogni nodo di lavoro in {{site.data.keyword.containerlong}}.
{: shortdesc}

Se hai dei requisiti di sicurezza univoci o hai un cluster multizona con lo spanning delle VLAN abilitato, puoi utilizzare Calico e Kubernetes per creare le politiche di rete di un cluster. Con le politiche di rete Kubernetes, specifica il traffico di rete che vuoi consentire o bloccare da e verso un pod in un cluster. Per impostare politiche di rete avanzate come il blocco del traffico in entrata (ingress) per i servizi LoadBalancer, utilizza le politiche di rete Calico.

<ul>
  <li>
  [Kubernetes network policies ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/concepts/services-networking/network-policies/): queste politiche specificano i pod che possono comunicare con altri pod e con gli endpoint esterni. A partire da Kubernetes versione 1.8, sia il traffico di rete in entrata che in uscita può essere consentito o bloccato in base al protocollo, la porta o gli indirizzi IP di origine e destinazione. Il traffico può inoltre essere filtrato in base alle etichette dello spazio dei nomi e del pod. Le politiche di rete Kubernetes vengono applicate utilizzando i comandi `kubectl` o le API Kubernetes. Quando queste politiche vengono applicate, vengono automaticamente convertite in politiche Calico e quindi Calico applica tali politiche.
  </li>
  <li>
  Politiche di rete Calico per Kubernetes versione [1.10 e cluster successivi ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://docs.projectcalico.org/v3.1/getting-started/kubernetes/tutorials/advanced-policy) o [1.9 e cluster precedenti ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://docs.projectcalico.org/v2.6/getting-started/kubernetes/tutorials/advanced-policy): queste politiche sono un soprainsieme delle politiche di rete Kubernetes e vengono applicate utilizzando i comandi `calicoctl`. Le politiche Calico aggiungono le seguenti funzioni.
    <ul>
    <li>Consentire o bloccare il traffico di rete su interfacce di rete specifiche indipendentemente dall'indirizzo IP di destinazione o dall'origine del pod Kubernetes o dal CIDR</li>
    <li>Consentire o bloccare il traffico di rete per i pod tra gli spazi dei nomi.</li>
    <li>[Bloccare il traffico in entrata (ingress) ai servizi LoadBalancer o NodePort Kubernetes](#block_ingress).</li>
    </ul>
  </li>
  </ul>

Calico applica
queste politiche, incluse tutte le politiche di rete Kubernetes convertite automaticamente in politiche Calico,
configurando le regole iptables di Linux sui nodi di lavoro Kubernetes. Le regole iptables fungono da firewall
per il nodo di lavoro per definire le caratteristiche che il traffico di rete deve soddisfare per essere inoltrato
alla risorsa di destinazione.

Per usare i servizi Ingress e LoadBalancer, usa le politiche di Calico e Kubernetes per gestire il traffico di rete in entrata e in uscita del tuo cluster. Non utilizzare i [gruppi di sicurezza](/docs/infrastructure/security-groups/sg_overview.html#about-security-groups) dell'infrastruttura IBM Cloud (SoftLayer). I gruppi di sicurezza dell'infrastruttura IBM Cloud (SoftLayer) vengono applicati all'interfaccia di rete di un singolo server virtuale per filtrare il traffico a livello dell'hypervisor. Tuttavia, i gruppi di sicurezza non supportano il protocollo VRRP, che viene utilizzato da {{site.data.keyword.containershort_notm}} per gestire l'indirizzo IP dei LoadBalancer. Se il protocollo VRRP non è presente per gestire l'IP del LoadBalancer, i servizi Ingress e LoadBalancer non funzioneranno correttamente.
{: tip}

<br />


## Politiche di rete Kubernetes e Calico predefinite
{: #default_policy}

Quando viene creato un cluster con una VLAN pubblica, viene creata automaticamente una risorsa HostEndpoint con l'etichetta `ibm.role: worker_public` per ogni nodo di lavoro e la relativa interfaccia di rete pubblica. Per proteggere l'interfaccia di rete pubblica di un nodo di lavoro, vengono applicate le politiche Calico predefinite per ogni endpoint host con l'etichetta `ibm.role: worker_public`.
{:shortdesc}

Queste politiche Calico predefinite consentono tutto il traffico di rete in uscita e il traffico in entrata a componenti cluster specifici, come i servizi Kubernetes NodePort, LoadBalancer e Ingress. Tutto il rimanente traffico di rete in entrata da internet ai tuoi nodi di lavoro che non è specificato nelle politiche predefinite viene bloccato. Le politiche predefinite non influiscono sul traffico tra i pod

Controlla le seguenti politiche di rete Calico predefinite che vengono automaticamente applicate al tuo cluster.

**Importante:** non rimuovere le politiche applicate a un endpoint host a meno che tu non abbia compreso pienamente la politica. Assicurati di non aver bisogno del traffico che viene consentito dalla politica.

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
      <td>Consente il traffico in entrata dei servizi NodePort, LoadBalancer e Ingress ai pod a cui vengono esposti questi servizi. <strong>Nota</strong>: non hai bisogno di specificare le porte esposte perché Kubernetes utilizza la conversione dell'indirizzo di rete di destinazione (DNAT) per inoltrare le richieste di servizio ai pod corretti. L'inoltro avviene prima che le politiche dell'endpoint host
vengano applicate in iptables.</td>
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
  <td><b>Solo in Kubernetes v1.10</b>, fornito nello spazio dei nomi <code>kube-system</code>: blocca a tutti i pod di accedere al dashboard Kubernetes. Questa politica non influenza l'accesso al dashboard dalla IU {{site.data.keyword.Bluemix_notm}} o utilizzando <code>kubectl proxy</code>. Se un pod necessita dell'accesso al dashboard, distribuiscilo in uno spazio dei nomi che ha un'etichetta <code>kubernetes-dashboard-policy: allow</code>.</td>
 </tr>
</tbody>
</table>

<br />


## Installazione e configurazione della CLI Calico
{: #cli_install}

Per visualizzare, gestire e aggiungere le politiche Calico, installare e configurare la CLI Calico.
{:shortdesc}

La compatibilità delle versioni Calico per le politiche e la configurazione della CLI variano in base alla versione Kubernetes del tuo cluster. Per installare e configurare la CLI Calico, fai clic su uno dei seguenti link in base alla tua versione del cluster:

* [Cluster Kubernetes versione 1.10 o successiva](#1.10_install)
* [Cluster Kubernetes versione 1.9 o precedente](#1.9_install)

Prima di aggiornare il tuo cluster da Kubernetes versione 1.9 o precedente alla versione 1.10 o successiva, rivedi [Preparazione dell'aggiornamento a Calico v3](cs_versions.html#110_calicov3).
{: tip}

### Installa e configura la versione 3.1.1 della CLI Calico per i cluster che sono in esecuzione in Kubernetes versione 1.10 o successiva
{: #1.10_install}

Prima di iniziare, [indirizza la CLI Kubernetes al cluster](cs_cli_install.html#cs_cli_configure). Includi l'opzione `--admin` con il comando `ibmcloud ks
cluster-config`, che viene utilizzato per scaricare i file di autorizzazione e i certificati. Questo download include inoltre le chiavi per il ruolo Super utente, di cui hai bisogno per eseguire i comandi
Calico.

  ```
  ibmcloud ks cluster-config <cluster_name> --admin
  ```
  {: pre}

Per installare e configurare la versione 3.1.1 della CLI Calico:

1. [Scarica la CLI Calico ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/projectcalico/calicoctl/releases/tag/v3.1.1).

    Se stai utilizzando OSX, scarica la versione `-darwin-amd64`. Se stai utilizzando Windows, installa la CLI Calico nella stessa directory in cui si trova la CLI {{site.data.keyword.Bluemix_notm}}. Questa configurazione salva alcune modifiche al percorso file quando esegui il comando in un secondo momento. Assicurati di salvare il file come `calicoctl.exe`.
    {: tip}

2. Per gli utenti OSX e Linux, completa la seguente procedura.
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

3. Verifica la corretta esecuzione dei comandi `calico` controllando la versione client della CLI Calico.

    ```
    calicoctl version
    ```
    {: pre}

4. Se le politiche di rete aziendali utilizzano proxy o firewall che impediscono l'accesso dal tuo sistema locale agli endpoint pubblici, [consenti l'accesso TCP dei comandi Calico](cs_firewall.html#firewall).

5. Per Linux e OS X, crea la directory `/etc/calico`. Per Windows, può essere utilizzata qualsiasi directory.

  ```
  sudo mkdir -p /etc/calico/
  ```
  {: pre}

6. Crea una file `calicoctl.cfg`.
    - Linux e OS X:

      ```
      sudo vi /etc/calico/calicoctl.cfg
      ```
      {: pre}

    - Windows: crea il file con un editor di testo.

7. Immetti le seguenti informazioni nel file <code>calicoctl.cfg</code>.

    ```
    apiVersion: projectcalico.org/v3
    kind: CalicoAPIConfig
    metadata:
    spec:
        datastoreType: etcdv3
        etcdEndpoints: <ETCD_URL>
        etcdKeyFile: <CERTS_DIR>/admin-key.pem
        etcdCertFile: <CERTS_DIR>/admin.pem
        etcdCACertFile: <CERTS_DIR>/<ca-*pem_file>
    ```
    {: codeblock}

    1. Richiama `<ETCD_URL>`.

      - Linux e OS X:

          ```
          kubectl get cm -n kube-system calico-config -o yaml | grep "etcd_endpoints:" | awk '{ print $2 }'
          ```
          {: pre}

          Output di esempio:

          ```
          https://169.xx.xxx.xxx:30000
          ```
          {: screen}

      - Windows:
        <ol>
        <li>Ottieni i valori di configurazione calico dalla mappa di configurazione. </br><pre class="codeblock"><code>kubectl get cm -n kube-system calico-config -o yaml</code></pre></br>
        <li>Nella sezione `data`, individua il valore etcd_endpoints. Esempio: <code>https://169.xx.xxx.xxx:30000</code>
        </ol>

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

            Esempio di
output:

          ```
          C:/Users/<user>/.bluemix/plugins/container-service/mycluster-admin/kube-config-prod-dal10-mycluster.yml
          ```
          {: screen}

        **Nota**: per ottenere il percorso della directory, rimuovi il nome file `kube-config-prod-<zone>-<cluster_name>.yml` dalla fine dell'output.

    3. Richiama il
`ca-*pem_file`.

        - Linux e OS X:

          ```
          ls `dirname $KUBECONFIG` | grep "ca-"
          ```
          {: pre}

        - Windows:
          <ol><li>Apri la directory che hai richiamato nell'ultimo passo.</br><pre class="codeblock"><code>C:\Users\<user>\.bluemix\plugins\container-service\&lt;cluster_name&gt;-admin\</code></pre>
          <li> Individua il file <code>ca-*pem_file</code>.</ol>

8. Salva il file e assicurati di trovarti nella directory in cui si trova il file.

9. Verifica che la configurazione di Calico funzioni correttamente.

    - Linux e OS X:

      ```
      calicoctl get nodes
      ```
      {: pre}

    - Windows:

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


### Installazione e configurazione della versione 1.6.3 della CLI Calico per i cluster che sono in esecuzione in Kubernetes versione 1.9 o precedente
{: #1.9_install}

Prima di iniziare, [indirizza la CLI Kubernetes al cluster](cs_cli_install.html#cs_cli_configure). Includi l'opzione `--admin` con il comando `ibmcloud ks
cluster-config`, che viene utilizzato per scaricare i file di autorizzazione e i certificati. Questo download include inoltre le chiavi per il ruolo Super utente, di cui hai bisogno per eseguire i comandi
Calico.

  ```
  ibmcloud ks cluster-config <cluster_name> --admin
  ```
  {: pre}

Per installare e configurare la versione 1.6.3 della CLI Calico:

1. [Scarica la CLI Calico ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/projectcalico/calicoctl/releases/tag/v1.6.3).

    Se stai utilizzando OSX, scarica la versione `-darwin-amd64`. Se stai utilizzando Windows, installa la CLI Calico nella stessa directory in cui si trova la CLI {{site.data.keyword.Bluemix_notm}}. Questa configurazione salva alcune modifiche al percorso file quando esegui il comando in un secondo momento.
    {: tip}

2. Per gli utenti OSX e Linux, completa la seguente procedura.
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

3. Verifica la corretta esecuzione dei comandi `calico` controllando la versione client della CLI Calico.

    ```
    calicoctl version
    ```
    {: pre}

4. Se le politiche di rete aziendali utilizzano proxy o firewall che impediscono l'accesso dal tuo sistema locale agli endpoint pubblici: consulta [Esecuzione dei comandi `calicoctl` da dietro un firewall](cs_firewall.html#firewall) per le istruzioni su come consentire l'accesso TCP ai comandi Calico.

5. Per Linux e OS X, crea la directory `/etc/calico`. Per Windows, può essere utilizzata qualsiasi directory.
    ```
    sudo mkdir -p /etc/calico/
    ```
    {: pre}

6. Crea una file `calicoctl.cfg`.
    - Linux e OS X:

      ```
      sudo vi /etc/calico/calicoctl.cfg
      ```
      {: pre}

    - Windows: crea il file con un editor di testo.

7. Immetti le seguenti informazioni nel file <code>calicoctl.cfg</code>.

    ```
    apiVersion: v1
      kind: calicoApiConfig
      metadata:
      spec:
          etcdEndpoints: <ETCD_URL>
          etcdKeyFile: <CERTS_DIR>/admin-key.pem
          etcdCertFile: <CERTS_DIR>/admin.pem
          etcdCACertFile: <CERTS_DIR>/<ca-*pem_file>
    ```
    {: codeblock}

    1. Richiama `<ETCD_URL>`.

      - Linux e OS X:

          ```
          kubectl get cm -n kube-system calico-config -o yaml | grep "etcd_endpoints:" | awk '{ print $2 }'
          ```
          {: pre}

      - Esempio di
output:

          ```
          https://169.xx.xxx.xxx:30001
          ```
          {: screen}

      - Windows:
        <ol>
        <li>Ottieni i valori di configurazione calico dalla mappa di configurazione. </br><pre class="codeblock"><code>kubectl get cm -n kube-system calico-config -o yaml</code></pre></br>
        <li>Nella sezione `data`, individua il valore etcd_endpoints. Esempio: <code>https://169.xx.xxx.xxx:30001</code>
        </ol>

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

        **Nota**: per ottenere il percorso della directory, rimuovi il nome file `kube-config-prod-<zone>-<cluster_name>.yml` dalla fine dell'output.

    3. Richiama il
`ca-*pem_file`.

        - Linux e OS X:

          ```
          ls `dirname $KUBECONFIG` | grep "ca-"
          ```
          {: pre}

        - Windows:
          <ol><li>Apri la directory che hai richiamato nell'ultimo passo.</br><pre class="codeblock"><code>C:\Users\<user>\.bluemix\plugins\container-service\&lt;cluster_name&gt;-admin\</code></pre>
          <li> Individua il file <code>ca-*pem_file</code>.</ol>

    4. Verifica che la configurazione di Calico funzioni correttamente.

        - Linux e OS X:

          ```
          calicoctl get nodes
          ```
          {: pre}

        - Windows:

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

          **Importante**: gli utenti Windows e OS X devono includere l'indicatore `--config=filepath/calicoctl.cfg` ogni volta che esegui un comando `calicoctl`.

<br />


## Visualizzazione delle politiche di rete
{: #view_policies}

Visualizza i dettagli per impostazione predefinita e tutte le politiche di rete aggiunte che vengono applicate al tuo cluster.
{:shortdesc}

Prima di iniziare:
1. [Installa e configura la CLI Calico.](#cli_install)
2. [Indirizza la CLI Kubernetes al
cluster](cs_cli_install.html#cs_cli_configure). Includi l'opzione --admin con il comando ibmcloud ks
cluster-config`, che viene utilizzato per scaricare i file di autorizzazione e i certificati. Questo download include inoltre le chiavi per il ruolo Super utente, di cui hai bisogno per eseguire i comandi
Calico.
    ```
    ibmcloud ks cluster-config <cluster_name> --admin
    ```
    {: pre}

La compatibilità delle versioni Calico per le politiche e la configurazione della CLI variano in base alla versione Kubernetes del tuo cluster. Per installare e configurare la CLI Calico, fai clic su uno dei seguenti link in base alla tua versione del cluster:

* [Cluster Kubernetes versione 1.10 o successiva](#1.10_examine_policies)
* [Cluster Kubernetes versione 1.9 o precedente](#1.9_examine_policies)

Prima di aggiornare il tuo cluster da Kubernetes versione 1.9 o precedente alla versione 1.10 o successiva, rivedi [Preparazione dell'aggiornamento a Calico v3](cs_versions.html#110_calicov3).
{: tip}

### Visualizza le politiche di rete nei cluster che sono in esecuzione in Kubernetes versione 1.10 o successiva
{: #1.10_examine_policies}

Gli utenti Linux non devono includere l'indicatore `--config=filepath/calicoctl.cfg` nei comandi `calicoctl`.
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

### Visualizza le politiche di rete nei cluster che sono in esecuzione in Kubernetes versione 1.9 o precedente
{: #1.9_examine_policies}

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

Per creare le politiche Calico, utilizza la seguente procedura.

Prima di iniziare:
1. [Installa e configura la CLI Calico.](#cli_install)
2. [Indirizza la CLI Kubernetes al
cluster](cs_cli_install.html#cs_cli_configure). Includi l'opzione --admin con il comando ibmcloud ks
cluster-config`, che viene utilizzato per scaricare i file di autorizzazione e i certificati. Questo download include inoltre le chiavi per il ruolo Super utente, di cui hai bisogno per eseguire i comandi
Calico.
    ```
    ibmcloud ks cluster-config <cluster_name> --admin
    ```
    {: pre}

La compatibilità delle versioni Calico per le politiche e la configurazione della CLI variano in base alla versione Kubernetes del tuo cluster. Fai clic su uno dei seguenti link in base alla tua versione del cluster:

* [Cluster Kubernetes versione 1.10 o successiva](#1.10_create_new)
* [Cluster Kubernetes versione 1.9 o precedente](#1.9_create_new)

Prima di aggiornare il tuo cluster da Kubernetes versione 1.9 o precedente alla versione 1.10 o successiva, rivedi [Preparazione dell'aggiornamento a Calico v3](cs_versions.html#110_calicov3).
{: tip}

### Aggiunta delle politiche Calico nei cluster che sono in esecuzione in Kubernetes versione 1.10 o successiva
{: #1.10_create_new}

1. Definisci la tua [politica di rete Calico ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://docs.projectcalico.org/v3.1/reference/calicoctl/resources/networkpolicy) o [politica di rete globale ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://docs.projectcalico.org/v3.1/reference/calicoctl/resources/globalnetworkpolicy) creando uno script di configurazione (`.yaml`). Questi file di configurazione includono i selettori che descrivono a quali pod, spazi dei nomi o host vengono applicate queste politiche. Fai riferimento a queste [politiche Calico di esempio ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](http://docs.projectcalico.org/v3.1/getting-started/kubernetes/tutorials/advanced-policy) per informazioni su come creare le tue proprie politiche.
    **Nota**: i cluster Kubernetes versione 1.10 o successiva devono utilizzare la sintassi della politica Calico v3.

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

### Aggiunta delle politiche Calico nei cluster che sono in esecuzione in Kubernetes versione 1.9 o precedente
{: #1.9_create_new}

1. Definisci la tua [politica di rete Calico ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](http://docs.projectcalico.org/v2.6/reference/calicoctl/resources/policy) creando uno script di configurazione (`.yaml`). Questi file di configurazione includono i selettori che descrivono a quali pod, spazi dei nomi o host vengono applicate queste politiche. Fai riferimento a queste [politiche Calico di esempio ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](http://docs.projectcalico.org/v2.6/getting-started/kubernetes/tutorials/advanced-policy) per informazioni su come creare le tue proprie politiche.
    **Nota**: i cluster Kubernetes versione 1.9 o precedente devono utilizzare la sintassi della politica Calico v2.


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


## Controllo del traffico in entrata nei servizi LoadBalancer o NodePort
{: #block_ingress}

[Per impostazione predefinita](#default_policy), i servizi Kubernetes NodePort e LoadBalancer sono progettati per rendere le tue applicazioni disponibili su tutte le interfacce del cluster private e pubbliche. Tuttavia, puoi usare le politiche di Calico per bloccare il traffico in entrata ai tuoi servizi in base all'origine o alla destinazione del traffico.
{:shortdesc}

Un servizio Kubernetes LoadBalancer è anche un servizio NodePort. Un servizio LoadBalancer rende la tua applicazione disponibile per la porta e l'indirizzo IP LoadBalancer e per le NodePort del servizio. È possibile accedere alle NodePort da ogni indirizzo IP (pubblico e privato) di ogni nodo all'interno del cluster.

L'amministratore del cluster può utilizzare le politiche di rete `ante-DNAT` Calico per bloccare il:

  - Traffico ai servizi NodePort. Il traffico ai servizi LoadBalancer è consentito.
  - Traffico basato su un indirizzo di origine o un CIDR.

Alcuni utilizzi comuni per le politiche di rete `ante-DNAT` Calico:

  - Bloccare il traffico verso le NodePort pubbliche di un servizio LoadBalancer privato.
  - Bloccare il traffico verso le NodePort pubbliche sui cluster che eseguono i [nodi di lavoro edge](cs_edge.html#edge). Il blocco delle NodePort assicura che i nodi di lavoro edge siano gli unici nodi di lavoro a gestire il traffico in entrata.

Le politiche predefinite di Kubernetes e Calico sono difficili da applicare per la protezione dei servizi Kubernetes NodePort e LoadBalancer a causa delle regole iptables DNAT generate per questi servizi.

Le politiche di rete `ante-DNAT` Calico possono aiutarti perché generano le regole iptables in base a una
risorsa della politica di rete Calico. I cluster Kubernetes versione 1.10 o successiva utilizzano le [politiche di rete con la sintassi `calicoctl.cfg` v3 ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://docs.projectcalico.org/v3.1/reference/calicoctl/resources/networkpolicy). I cluster Kubernetes versione 1.9 o precedente utilizzano le [politiche con la sintassi `calicoctl.cfg` v2 ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://docs.projectcalico.org/v2.6/reference/calicoctl/resources/policy).

1. Definisci una politica di rete `ante-DNAT` Calico per l'accesso in entrata (traffico in entrata) ai servizi Kubernetes.

    * I cluster Kubernetes versione 1.10 o successiva devono utilizzare la sintassi della politica Calico v3.

        Risorsa di esempio che blocca tutte le NodePort:

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

    * I cluster Kubernetes versione 1.9 o precedente devono utilizzare la sintassi della politica Calico v2.

        Risorsa di esempio che blocca tutte le NodePort:

        ```
        apiVersion: v1
        kind: policy
        metadata:
          name: deny-nodeports
        spec:
          preDNAT: true
          selector: ibm.role in { 'worker_public', 'master_public' }
          ingress:
          - action: deny
            protocol: tcp
            destination:
              ports:
              - 30000:32767
          - action: deny
            protocol: udp
            destination:
              ports:
              - 30000:32767
        ```
        {: codeblock}

2. Applica la politica di rete ante-DNAT Calico. Serve circa 1 minuto
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

3. Facoltativo: nei cluster multizona, l'integrità MZLB controlla gli ALB in ciascuna zona del tuo cluster e tiene aggiornati i risultati della ricerca DNS in base a questi controlli di integrità. Se usi politiche ante-DNAT per bloccare tutto il traffico in entrata ai servizi Ingress, devi anche inserire in whitelist gli [IP IPv4 di Cloudflare ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.cloudflare.com/ips/) usati per controllare l'integrità dei tuoi ALB. Per la procedura su come creare una politica Calico ante-DNAT per inserire in whitelist questi IP, vedi la Lezione 3 dell'[esercitazione della politica di rete Calico](cs_tutorials_policies.html#lesson3).

Per vedere come inserire in whitelist o in blacklist gli indirizzi IP di origine, prova l'[esercitazione Utilizzo delle politiche di rete Calico per bloccare il traffico](cs_tutorials_policies.html#policy_tutorial). Per ulteriori politiche di rete Calico di esempio che controllano il traffico verso o dal tuo cluster, puoi controllare la [demo della politica stars ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://docs.projectcalico.org/v3.1/getting-started/kubernetes/tutorials/stars-policy/) e la [politica di rete avanzata ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://docs.projectcalico.org/v3.1/getting-started/kubernetes/tutorials/advanced-policy).
{: tip}

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

I servizi di proprietà di diversi team secondari devono comunicare, ma sono distribuiti in spazi dei nomi diversi all'interno dello stesso cluster. Il team Accounts distribuisce i servizi frontend, backend e database per l'applicazione Srv1 nello spazio dei nomi accounts. Il team Finance distribuisce i servizi frontend, backend e database per l'applicazione Srv2 nello spazio dei nomi finance. Entrambi i team etichettano ciascun servizio con l'etichetta `app: Srv1` o `app: Srv2` e l'etichetta `tier: frontend`, `tier: backend` o `tier: db`. Etichettano anche gli spazi dei nomi con l'etichetta `usage: finance` o `usage: accounts`.

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

**Nota**: non puoi consentire il traffico da pod dell'applicazione specifici a un altro spazio dei nomi in quanto `podSelector` e `namespaceSelector` non possono essere combinati. In questo esempio, è consentito tutto il traffico proveniente da tutti i microservizi nello spazio dei nomi finance. 
