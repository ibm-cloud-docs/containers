---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-24"

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

Ogni cluster Kubernetes è configurato con un plug-in di rete chiamato Calico. Le politiche di rete predefinite
vengono configurate per proteggere l'interfaccia di rete pubblica di ogni nodo di lavoro. Puoi utilizzare
le funzionalità Calico e Kubernetes native per configurare ulteriori politiche di rete per un cluster
quando hai requisiti di sicurezza univoci. Queste politiche di rete specificano il traffico di rete che vuoi
consentire o bloccare da e verso un pod in un cluster.
{: shortdesc}

Puoi scegliere tra le funzionalità Calico e Kubernetes native per creare politiche di rete per il tuo
cluster. Per iniziare, potresti utilizzare le politiche di rete Kubernetes, ma, per delle funzionalità più
solide, utilizza le politiche di rete Calico.

<ul>
  <li>[Politiche di rete Kubernetes
![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/concepts/services-networking/network-policies/): vengono fornite alcune opzioni di base ad esempio la specifica di quali pod possono comunicare tra loro. Il traffico di rete in entrata può essere consentito o bloccato per un protocollo e una porta Questo traffico può essere filtrato in base alle etichette e agli spazi dei nomi Kubernetes del pod che sta tentando di collegarsi ad altri pod.</br>Queste politiche possono essere applicate utilizzando
i comandi `kubectl` o le API Kubernetes. Quando queste politiche vengono applicate, vengono
convertite in politiche Calico e quindi Calico applica tali politiche.</li>
  <li>[Politiche di rete Calico
![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](http://docs.projectcalico.org/v2.6/getting-started/kubernetes/tutorials/advanced-policy): queste politiche sono un soprainsieme delle politiche di rete Kubernetes e migliorano le funzionalità Kubernetes native con le seguenti
funzioni.</li>
    <ul><ul><li>Consentire o bloccare il traffico di rete su interfacce di rete specifiche, non solo il traffico di pod
Kubernetes.</li>
    <li>Consentire o bloccare il traffico di rete in entrata e in uscita.</li>
    <li>[Bloccare il traffico in entrata ai servizi LoadBalancer o NodePort](#block_ingress).</li>
    <li>Consentire o bloccare il traffico basato sull'indirizzo IP di origine o destinazione o CIDR.</li></ul></ul></br>

Queste politiche vengono applicate utilizzando i comandi `calicoctl`. Calico applica
queste politiche, incluse tutte le politiche di rete Kubernetes convertite in politiche Calico,
configurando le regole iptables di Linux sui nodi di lavoro Kubernetes. Le regole iptables fungono da firewall
per il nodo di lavoro per definire le caratteristiche che il traffico di rete deve soddisfare per essere inoltrato
alla risorsa di destinazione.</ul>

<br />


## Configurazione delle politiche predefinite
{: #default_policy}

Quando si crea un cluster, le politiche di rete predefinite vengono configurate automaticamente per
l'interfaccia di rete pubblica di ogni nodo di lavoro per limitare il traffico in entrata per un nodo di lavoro
dall'Internet pubblico. Queste politiche non influiscono sul traffico tra i pod e sono configurate per consentire l'accesso ai
servizi nodeport, programma di bilanciamento del carico e Ingress di Kubernetes.
{:shortdesc}

Le politiche predefinite non vengono applicate direttamente ai pod; vengono applicate all'interfaccia di rete pubblica di un nodo di lavoro utilizzando un endpoint host Calico. Quando un endpoint host viene creato in Calico, tutto il traffico da e verso l'interfaccia
di rete di tale nodo di lavoro viene bloccato, a meno che il traffico non sia consentito da un politica.

**Importante:** non rimuovere le politiche applicate a un endpoint host a meno che
tu non abbia compreso pienamente la politica e sappia che non hai bisogno del traffico che viene consentito dalla politica.


 <table summary="La prima riga nella tabella si estende su entrambe le colonne. Le rimanenti righe devono essere lette da sinistra a destra, con l'ubicazione del server nella prima colonna e gli indirizzi IP corrispondenti nella seconda colonna.">
 <caption>Politiche predefinite per ogni cluster </caption>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Icona Idea"/> Politiche predefinite per ogni cluster</th>
  </thead>
  <tbody>
    <tr>
      <td><code>allow-all-outbound</code></td>
      <td>Consente tutto il traffico in uscita.</td>
    </tr>
    <tr>
      <td><code>allow-bixfix-port</code></td>
      <td>Consente il traffico in entrata sulla porta 52311 nell'applicazione bigfix per consentire gli aggiornamenti necessari del nodo di lavoro.</td>
    </tr>
    <tr>
      <td><code>allow-icmp</code></td>
      <td>Consente i pacchetti icmp in entrata (ping).</td>
     </tr>
    <tr>
      <td><code>allow-node-port-dnat</code></td>
      <td>Consente il traffico in entrata dei servizi nodeport, programma di bilanciamento del carico e Ingress ai pod a cui vengono
esposti questi servizi. Nota che la porta che questi servizi espongono sull'interfaccia pubblica non deve essere
specificata perché Kubernetes utilizza la conversione dell'indirizzo di rete di destinazione (DNAT) per inoltrare
le richieste di servizio ai pod corretti. L'inoltro avviene prima che le politiche dell'endpoint host
vengano applicate in iptables.</td>
   </tr>
   <tr>
      <td><code>allow-sys-mgmt</code></td>
      <td>Consente le connessioni in entrata per specifici sistemi dell'infrastruttura IBM Cloud (SoftLayer) utilizzati per gestire i nodi di lavoro.</td>
   </tr>
   <tr>
    <td><code>allow-vrrp</code></td>
    <td>Consente i pacchetti vrrp, utilizzati per monitorare e spostare gli indirizzi IP virtuali tra i nodi
di lavoro.</td>
   </tr>
  </tbody>
</table>

<br />


## Aggiunta di politiche di rete
{: #adding_network_policies}

Nella maggior parte dei casi, le politiche predefinite non devono essere modificate. Solo in scenari avanzati
potrebbero essere richieste delle modifiche. Se ritieni di dover apportare modifiche, installa la CLI Calico e crea le tue proprie politiche di rete.
{:shortdesc}

Prima di iniziare:

1.  [Installa le CLI di {{site.data.keyword.containershort_notm}} e Kubernetes.](cs_cli_install.html#cs_cli_install)
2.  [Crea un cluster gratuito o standard.](cs_clusters.html#clusters_ui)
3.  [Indirizza la CLI Kubernetes CLI al
cluster](cs_cli_install.html#cs_cli_configure). Includi l'opzione --admin con il comando bx cs
cluster-config`, che viene utilizzato per scaricare i file di autorizzazione e i certificati. Questo download include inoltre le chiavi per il ruolo Super utente, di cui hai bisogno per eseguire i comandi
Calico.

  ```
  bx cs cluster-config <cluster_name> --admin
  ```
  {: pre}

  **Nota**: è supportata la CLI Calico versione 1.6.1.

Per aggiungere le politiche di rete:
1.  Installa la CLI Calico.
    1.  [Scarica la CLI Calico ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/projectcalico/calicoctl/releases/tag/v1.6.1).

        **Suggerimento:** se utilizzi Windows, installa la CLI Calico
nella stessa directory in cui si trova la CLI {{site.data.keyword.Bluemix_notm}}. Questa configurazione salva alcune modifiche al percorso file
quando esegui il comando in un secondo momento.

    2.  Per gli utenti OSX e Linux, completa la seguente procedura.
        1.  Sposta il file eseguibile nella directory /usr/local/bin.
            -   Linux:

              ```
              mv /<path_to_file>/calicoctl /usr/local/bin/calicoctl
              ```
              {: pre}

            -   OS
X:

              ```
              mv /<path_to_file>/calicoctl-darwin-amd64 /usr/local/bin/calicoctl
              ```
              {: pre}

        2.  Rendi il file eseguibile.

            ```
            chmod +x /usr/local/bin/calicoctl
            ```
            {: pre}

    3.  Verifica la corretta esecuzione dei comandi `calico` controllando la versione client della CLI Calico.

        ```
        calicoctl version
        ```
        {: pre}

    4.  Se le politiche di rete aziendali impediscono l'accesso dal tuo sistema locale agli endpoint pubblici tramite i proxy o i firewall consulta [Esecuzione dei comandi `calicoctl` da dietro un firewall](cs_firewall.html#firewall) per le istruzioni su come consentire l'accesso TCP ai comandi Calico.

2.  Configura la CLI Calico.

    1.  Per Linux e OS X, crea la directory `/etc/calico`. Per Windows, può essere utilizzata qualsiasi directory.

      ```
      sudo mkdir -p /etc/calico/
      ```
      {: pre}

    2.  Crea una file `calicoctl.cfg`.
        -   Linux e OS X:

          ```
          sudo vi /etc/calico/calicoctl.cfg
          ```
          {: pre}

        -   Windows: crea il file con un editor di testo.

    3.  Immetti le seguenti informazioni nel file <code>calicoctl.cfg</code>.

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

        1.  Richiama `<ETCD_URL>`. Se questo comando ha esito negativo con un errore `calico-config not found`,
consulta questo [argomento sulla risoluzione dei problemi](cs_troubleshoot.html#cs_calico_fails).

          -   Linux e OS X:

              ```
              kubectl get cm -n kube-system calico-config -o yaml | grep "etcd_endpoints:" | awk '{ print $2 }'
              ```
              {: pre}

          -   Esempio di
output:

              ```
              https://169.1.1.1:30001
              ```
              {: screen}

          -   Windows:
            <ol>
            <li>Ottieni i valori di configurazione calico dalla mappa di configurazione. </br><pre class="codeblock"><code>kubectl get cm -n kube-system calico-config -o yaml</code></pre></br>
            <li>Nella sezione `data`, individua il valore etcd_endpoints. Esempio: <code>https://169.1.1.1:30001</code>
            </ol>

        2.  Richiama `<CERTS_DIR>`, ossia la directory in cui vengono scaricati i certificati Kubernetes.

            -   Linux e OS X:

              ```
              dirname $KUBECONFIG
              ```
              {: pre}

                Esempio di
output:

              ```
              /home/sysadmin/.bluemix/plugins/container-service/clusters/<cluster_name>-admin/
              ```
              {: screen}

            -   Windows:

              ```
              ECHO %KUBECONFIG%
              ```
              {: pre}

                Esempio di
output:

              ```
              C:/Users/<user>/.bluemix/plugins/container-service/<cluster_name>-admin/kube-config-prod-<location>-<cluster_name>.yml
              ```
              {: screen}

            **Nota**: per ottenere il percorso della directory, rimuovi il nome file `kube-config-prod-<location>-<cluster_name>.yml` dalla fine dell'output.

        3.  Richiama il
<code>ca-*pem_file<code>.

            -   Linux e OS X:

              ```
              ls `dirname $KUBECONFIG` | grep "ca-"
              ```
              {: pre}

            -   Windows:
              <ol><li>Apri la directory che hai richiamato nell'ultimo
passo.</br><pre class="codeblock"><code>C:\Users\<user>\.bluemix\plugins\container-service\&lt;cluster_name&gt;-admin\</code></pre>
              <li> Individua il file <code>ca-*pem_file</code>.</ol>

        4.  Verifica che la configurazione di Calico funzioni
correttamente.

            -   Linux e OS X:

              ```
              calicoctl get nodes
              ```
              {: pre}

            -   Windows:

              ```
              calicoctl get nodes --config=<path_to_>/calicoctl.cfg
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

3.  Esamina le politiche di rete esistenti.

    -   Visualizza l'endpoint host
Calico.

      ```
      calicoctl get hostendpoint -o yaml
      ```
      {: pre}

    -   Visualizza tutte le politiche di rete di Calico e Kubernetes che sono state create per il cluster. Questo elenco contiene politiche che potrebbero non essere ancora applicate a tutti i pod o gli host. Affinché una politica di rete
venga applicata, deve trovare una risorsa Kubernetes che corrisponda al selettore definito
nella politica di rete Calico.

      ```
      calicoctl get policy -o wide
      ```
      {: pre}

    -   Visualizza i dettagli per una politica di
rete.

      ```
      calicoctl get policy -o yaml <policy_name>
      ```
      {: pre}

    -   Visualizza i dettagli di tutte le politiche di rete per il
cluster.

      ```
      calicoctl get policy -o yaml
      ```
      {: pre}

4.  Crea le politiche di rete Calico per consentire o bloccare il traffico.

    1.  Definisci la tua [politica di rete Calico
![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](http://docs.projectcalico.org/v2.6/reference/calicoctl/resources/policy) creando uno script di configurazione (.yaml). Questi file di configurazione includono i selettori
che descrivono a quali pod, spazi dei nomi o host vengono applicate queste politiche. Fai riferimento a queste
[politiche Calico di esempio
![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](http://docs.projectcalico.org/v2.6/getting-started/kubernetes/tutorials/advanced-policy) per informazioni su come creare le tue proprie politiche.

    2.  Applica le politiche al cluster.
        -   Linux e OS X:

          ```
          calicoctl apply -f <policy_file_name.yaml>
          ```
          {: pre}

        -   Windows:

          ```
          calicoctl apply -f <path_to_>/<policy_file_name.yaml> --config=<path_to_>/calicoctl.cfg
          ```
          {: pre}

<br />


## Blocca il traffico in entrata nei servizi LoadBalancer o NodePort.
{: #block_ingress}

Per impostazione predefinita, i servizi Kubernetes `NodePort` e `LoadBalancer` sono progettati per rendere le tue applicazioni disponibili
su tutte le interfacce del cluster private e pubbliche. Tuttavia, puoi bloccare il traffico in entrata ai tuoi servizi in base alla destinazione o all'origine del traffico. Per bloccare il traffico, crea le politiche di rete `preDNAT` Calico.
{:shortdesc}

Un servizio Kubernetes LoadBalancer è anche un servizio NodePort. Un servizio LoadBalancer rende la tua applicazione disponibile per la porta e l'indirizzo IP del programma di bilanciamento del carico e per le porte del nodo del servizio. È possibile accedere alle porte del nodo da ogni indirizzo IP (pubblico e privato) di ogni nodo all'interno del cluster.

L'amministratore del cluster può utilizzare le politiche di rete `preDNAT` Calico per bloccare il:

  - Traffico ai servizi NodePort. Il traffico ai servizi LoadBalancer è consentito.
  - Traffico basato su un indirizzo di origine o un CIDR.

Alcuni utilizzi comuni per le politiche di rete `preDNAT` Calico:

  - Bloccare il traffico verso le porte del nodo pubblico di un servizio LoadBalancer privato.
  - Bloccare il traffico verso le porte del nodo pubblico sui cluster che eseguono i [nodi di lavoro edge](cs_edge.html#edge). Il blocco delle porte del nodo assicura che i nodi di lavoro edge siano gli unici nodi di lavoro a gestire il traffico in entrata.

Le politiche di rete `preDNAT` sono utili perché le politiche predefinite di Kubernetes e Calico sono difficili da applicare per la protezione dei servizi Kubernetes NodePort e LoadBalancer a causa delle regole iptables DNAT generate per questi servizi.

Le politiche di rete `preDNAT` Calico generano le regole iptables in base a una [risorsa della politica di rete
Calico ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://docs.projectcalico.org/v2.6/reference/calicoctl/resources/policy).

1. Definisci una politica di rete `preDNAT` Calico per l'accesso in entrata ai servizi Kubernetes.

  Esempio che blocca tutte le porte del nodo:

  ```
  apiVersion: v1
  kind: policy
  metadata:
    name: deny-kube-node-port-services
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

2. Applica la politica di rete preDNAT Calico. Serve circa 1 minuto
perché le modifiche alla politica vengano applicate nel cluster.

  ```
  calicoctl apply -f deny-kube-node-port-services.yaml
  ```
  {: pre}
