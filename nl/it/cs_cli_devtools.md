---

copyright:
  years: 2014, 2017
lastupdated: "2017-08-14"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip} 
{:download: .download}


# Riferimenti CLI per la gestione dei cluster
{: #cs_cli_reference}

Fai riferimento a questi comandi per creare e gestire i cluster.
{:shortdesc}

**Suggerimento:** Stai cercando i comandi `bx cr`? Consulta i riferimenti CLI [{{site.data.keyword.registryshort_notm}}](/docs/cli/plugins/registry/index.html#containerregcli). Stai cercando i comandi `kubectl`? Consulta la [Documentazione Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/user-guide/kubectl/v1.5/).

 
<!--[https://github.ibm.com/alchemy-containers/armada-cli ![External link icon](../icons/launch-glyph.svg "External link icon")](https://github.ibm.com/alchemy-containers/armada-cli)-->

<table summary="Comandi per la creazione dei cluster in {{site.data.keyword.Bluemix_notm}}">
 <thead>
    <th colspan=5>Comandi per la creazione dei cluster in {{site.data.keyword.Bluemix_notm}}</th>
 </thead>
 <tbody>
 <tr>
    <td>[bx cs cluster-config](cs_cli_reference.html#cs_cluster_config)</td>
    <td>[bx cs cluster-create](cs_cli_reference.html#cs_cluster_create)</td> 
    <td>[bx cs cluster-get](cs_cli_reference.html#cs_cluster_get)</td>
    <td>[bx cs cluster-rm](cs_cli_reference.html#cs_cluster_rm)</td>
    <td>[bx cs cluster-service-bind](cs_cli_reference.html#cs_cluster_service_bind)</td>
 </tr>
 <tr>
    <td>[bx cs cluster-service-unbind](cs_cli_reference.html#cs_cluster_service_unbind)</td>
    <td>[bx cs cluster-services](cs_cli_reference.html#cs_cluster_services)</td> 
    <td>[bx cs cluster-subnet-add](cs_cli_reference.html#cs_cluster_subnet_add)</td>
    <td>[bx cs clusters](cs_cli_reference.html#cs_clusters)</td>
    <td>[bx cs credentials-set](cs_cli_reference.html#cs_credentials_set)</td>
 </tr>
 <tr>
   <td>[bx cs credentials-unset](cs_cli_reference.html#cs_credentials_unset)</td>
   <td>[bx cs locations](cs_cli_reference.html#cs_datacenters)</td> 
   <td>[bx cs help](cs_cli_reference.html#cs_help)</td>
   <td>[bx cs init](cs_cli_reference.html#cs_init)</td>
   <td>[bx cs machine-types](cs_cli_reference.html#cs_machine_types)</td>
   </tr>
 <tr>
    <td>[bx cs subnets](cs_cli_reference.html#cs_subnets)</td>
    <td>[bx cs vlans](cs_cli_reference.html#cs_vlans)</td> 
    <td>[bx cs webhook-create](cs_cli_reference.html#cs_webhook_create)</td>
    <td>[bx cs worker-add](cs_cli_reference.html#cs_worker_add)</td>
    <td>[bx cs worker-get](cs_cli_reference.html#cs_worker_get)</td>
    </tr>
 <tr>
   <td>[bx cs worker-reboot](cs_cli_reference.html#cs_worker_reboot)</td>
   <td>[bx cs worker-reload](cs_cli_reference.html#cs_worker_reload)</td> 
   <td>[bx cs worker-rm](cs_cli_reference.html#cs_worker_rm)</td>
   <td>[bx cs workers](cs_cli_reference.html#cs_workers)</td>
   <td></td>
  </tr>
 </tbody>
 </table> 
    
**Suggerimento:** per visualizzare la versione del plugin {{site.data.keyword.containershort_notm}}, esegui il seguente comando.

```
bx plugin list
```
{: pre}



## Comandi bx cs
{: #cs_commands}

### bx cs cluster-config CLUSTER [--admin]
{: #cs_cluster_config}

Dopo aver eseguito l'accesso, scarica i certificati e i dati di configurazione Kubernetes per collegare il tuo cluster ed esegui i comandi `kubectl`. I file vengono scaricati in `user_home_directory/.bluemix/plugins/container-service/clusters/<cluster_name>`.

**Opzioni comando**:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>(Obbligatorio) Il nome o l'ID del cluster.</dd>

   <dt><code>--admin</code></dt>
   <dd>(Facoltativo) Scarica i certificati e i file di autorizzazione per il ruolo rbac Amministratore. Gli utenti con questi file possono eseguire azioni di amministrazione sul cluster, ad esempio la rimozione del
cluster.</dd>
   </dl>

**Esempi**:

```
bx cs cluster-config my_cluster
```
{: pre}



### bx cs cluster-create [--file FILE_LOCATION][--hardware HARDWARE] --location LOCATION --machine-type MACHINE_TYPE --name NAME [--no-subnet][--private-vlan PRIVATE_VLAN] [--public-vlan PUBLIC_VLAN][--workers WORKER]
{: #cs_cluster_create}

Per creare un cluster nella tua organizzazione.

<strong>Opzioni comando</strong>

<dl>
   <dt><code>--file <em>FILE_LOCATION</em></code></dt>

   <dd>(Facoltativo per i cluster standard. Non disponibile per i cluster lite.) Il percorso del file YAML per creare il tuo cluster standard. Invece di definire le caratteristiche del cluster utilizzando le opzioni fornite in questo comando, puoi utilizzare un file YAML.

    <p><strong>Nota:</strong> se fornisci la stessa opzione nel comando come parametro nel file YAML, il valore nel comando ha la precedenza rispetto al valore nel YAML. Ad esempio, definisci un'ubicazione nel tuo file YAML e utilizzi l'opzione <code>--location</code> nel comando, il valore che hai immesso nell'opzione del comando sovrascrive il valore nel file YAML.

    <pre class="codeblock"><code>
    name: <em>&lt;cluster_name&gt;</em>
    location: <em>&lt;location&gt;</em>
    machine-type: <em>&lt;machine_type&gt;</em>
    private-vlan: <em>&lt;private_vlan&gt;</em>
    public-vlan: <em>&lt;public_vlan&gt;</em>
    hardware: <em>&lt;shared_or_dedicated&gt;</em>
    workerNum: <em>&lt;number_workers&gt;</em></code></pre>


    <table>
    <caption>Tabella 1.Descrizione dei componenti del file YAML</caption>
    <thead>
    <th colspan=2><img src="images/idea.png"/> Descrizione dei
componenti del file YAML</th>
    </thead>
    <tbody>
    <tr>
    <td><code><em>name</em></code></td>
    <td>Sostituisci <code><em>&lt;cluster_name&gt;</em></code> con un nome per il tuo cluster.</td> 
    </tr>
    <tr>
    <td><code><em>location</em></code></td>
    <td>Sostituisci <code><em>&lt;location&gt;</em></code> con l'ubicazione in cui vuoi creare il tuo cluster. Le ubicazioni disponibili dipendono dalla regione in cui ha eseguito l'accesso. Per elencare le ubicazioni disponibili, esegui <code>bx cs locations</code>. </td> 
     </tr>
     <tr>
     <td><code><em>machine-type</em></code></td>
     <td>Sostituisci <code><em>&lt;machine_type&gt;</em></code> con il tipo di macchina che vuoi utilizzare per i tuoi nodi di lavoro. Per elencare tutti i tipi di macchina disponibili per la tua ubicazione, esegui <code>bx cs machine-types <em>&lt;location&gt;</em></code>.</td> 
     </tr>
     <tr>
     <td><code><em>private-vlan</em></code></td>
     <td>Sostituisci <code><em>&lt;private_vlan&gt;</em></code> con l'ID della VLAN privata che vuoi utilizzare per i tuoi nodi di lavoro. Per elencare le VLAN disponibili, esegui <code>bx cs vlans <em>&lt;location&gt;</em></code> e ricerca i router VLAN che iniziano con <code>bcr</code> (router di back-end).</td> 
     </tr>
     <tr>
     <td><code><em>public-vlan</em></code></td>
     <td>Sostituisci <code><em>&lt;public_vlan&gt;</em></code> con l'ID della VLAN pubblica che vuoi utilizzare per i tuoi nodi di lavoro. Per elencare le VLAN disponibili, esegui <code>bx cs vlans <em>&lt;location&gt;</em></code> e ricerca i router VLAN che iniziano con <code>fcr</code> (router di front-end).</td> 
     </tr>
     <tr>
     <td><code><em>hardware</em></code></td>
     <td>Il livello di isolamento hardware per il nodo di lavoro. Utilizza dedicato se vuoi avere risorse fisiche dedicate disponibili solo per te o condiviso per consentire la condivisione delle risorse fisiche con altri clienti IBM. L'impostazione predefinita è
<code>condiviso</code>.</td> 
     </tr>
     <tr>
     <td><code><em>workerNum</em></code></td>
     <td>Sostituisci <code><em>&lt;number_workers&gt;</em></code> con il numero di nodi di lavoro che vuoi distribuire.</td> 
     </tr>
     </tbody></table>
    </p></dd>
    
    <dt><code>--hardware <em>HARDWARE</em></code></dt>
    <dd>(Facoltativo per i cluster standard. Non disponibile per i cluster lite.) Il livello di isolamento hardware per il nodo di lavoro. Utilizza dedicato se vuoi avere risorse fisiche dedicate disponibili solo per te o condiviso per consentire la condivisione delle risorse fisiche con altri clienti IBM. L'impostazione predefinita è condiviso.</dd>

    <dt><code>--location <em>LOCATION</em></code></dt>
    <dd>(Obbligatorio per i cluster standard. Facoltativo per i cluster lite.) L'ubicazione in cui vuoi creare il cluster. Le ubicazioni disponibili
dipendono dalla regione {{site.data.keyword.Bluemix_notm}} in cui hai
eseguito l'accesso. Per
prestazioni ottimali, seleziona la regione fisicamente più vicina a te.

        <p>Le ubicazioni disponibili sono:<ul><li>Stati Uniti Sud<ul><li>dal10 [Dallas]</li><li>dal12 [Dallas]</li></ul></li><li>Regno Unito - Sud<ul><li>lon02 [London]</li><li>lon04 [London]</li></ul></li><li>Europa centrale<ul><li>ams03 [Amsterdam]</li><li>ra02 [Frankfurt]</li></ul></li><li>Asia Pacifico Sud<ul><li>syd01 [Sydney]</li><li>syd04 [Sydney]</li></ul></li></ul>
        </p>

        <p><strong>Nota:</strong> quando selezioni una posizione ubicata al di fuori del tuo paese, tieni presente che potresti aver bisogno di un'autorizzazione legale prima di poter fisicamente archiviare i dati in un paese straniero.</p>
        </dd>

    <dt><code>--machine-type <em>MACHINE_TYPE</em></code></dt>
    <dd>(Obbligatorio per i cluster standard. Non disponibile per i cluster lite.) Il tipo di macchina che scegli influisce sulla quantità di memoria e spazio disco
disponibile per i contenitori distribuiti al tuo nodo di lavoro. Per elencare i tipi di macchina disponibili, consulta [bx cs machine-types <em>LOCATION</em>](cs_cli_reference.html#cs_machine_types).</dd>

    <dt><code>--name <em>NAME</em></code></dt>
    <dd>(Obbligatorio) Il nome per il cluster.</dd>

    <dt><code>--no-subnet</code></dt>
    <dd>Includi l'indicatore per creare un cluster senza una sottorete portatile. L'impostazione predefinita è di non utilizzare l'indicatore
e di creare una sottorete nel tuo portfolio {{site.data.keyword.BluSoftlayer_full}}.</dd>

    <dt><code>--private-vlan <em>PRIVATE_VLAN</em></code></dt>
    <dd>(Non disponibile per i cluster lite.)

        <ul>
        <li>Se si tratta del primo cluster che crei in questa ubicazione, non includere questo indicatore. Alla creazione dei cluster, viene creata per te una VLAN privata.</li>
        <li>Se hai creato prima un cluster in questa ubicazione o hai creato prima una VLAN privata in {{site.data.keyword.BluSoftlayer_notm}}, devi specificare tale
VLAN privata.

            <p><strong>Nota:</strong> le VLAN pubbliche e private che specifichi con il comando create devono corrispondere. I router della VLAN privata iniziano sempre con <code>bcr</code> (router back-end) e i router
della VLAN pubblica iniziano sempre con <code>fcr</code> (router front-end). La combinazione di numeri e lettere
dopo questi prefissi devono corrispondere per utilizzare tali VLAN durante la creazione di un cluster. Per creare un cluster, non utilizzare
VLAN pubbliche e private che non corrispondono.</p></li>
        </ul>

    <p>Per scoprire se già hai una VLAN privata per una specifica ubicazione o per trovare il nome di una
VLAN privata esistente, esegui <code>bx cs vlans <em>&lt;location&gt;</em></code>.</p></dd>

    <dt><code>--public-vlan <em>PUBLIC_VLAN</em></code></dt>
    <dd>(Non disponibile per i cluster lite.)

        <ul>
        <li>Se si tratta del primo cluster che crei in questa ubicazione, non utilizzare questo indicatore. Alla creazione
del cluster, viene creata per te una VLAN pubblica.</li>
        <li>Se hai creato prima un cluster in questa ubicazione o hai creato prima una VLAN pubblica in {{site.data.keyword.BluSoftlayer_notm}}, devi specificare tale
VLAN pubblica.

            <p><strong>Nota:</strong> le VLAN pubbliche e private che specifichi con il comando create devono corrispondere. I router della VLAN privata iniziano sempre con <code>bcr</code> (router back-end) e i router
della VLAN pubblica iniziano sempre con <code>fcr</code> (router front-end). La combinazione di numeri e lettere
dopo questi prefissi devono corrispondere per utilizzare tali VLAN durante la creazione di un cluster. Per creare un cluster, non utilizzare
VLAN pubbliche e private che non corrispondono.</p></li>
        </ul>

    <p>Per scoprire se già hai una VLAN pubblica per una specifica ubicazione o per trovare il nome di una
VLAN pubblica esistente, esegui <code>bx cs vlans <em>&lt;location&gt;</em></code>.</p></dd>

    <dt><code>--workers WORKER</code></dt>
    <dd>(Facoltativo per i cluster standard. Non disponibile per i cluster lite.) Il numero di nodi di lavoro che vuoi distribuire nel tuo cluster. Se non specifici
questa opzione, viene creato un cluster con 1 nodo di lavoro.

    <p><strong>Nota:</strong> a ogni nodo di lavoro viene assegnato
un ID e nome dominio univoco che non deve essere modificato manualmente dopo la creazione del
cluster. La modifica dell'ID o del nome dominio impedisce al master Kubernetes di gestire il tuo
cluster.</p></dd>
  </dl>

**Esempi**:

  my_public_vlan_id --private-vlan my_private_vlan_id --name my_cluster
  ```
  {: pre}
    
  </staging>
  
  Esempio per un cluster standard:
  {: #example_cluster_create}

  ```
  bx cs cluster-create --location dal10 --public-vlan my_public_vlan_id --private-vlan my_private_vlan_id --machine-type u1c.2x4 --name my_cluster --hardware shared --workers 2
  ```
  {: pre}

  Esempio per un cluster lite:

  ```
  bx cs cluster-create --name my_cluster
  ```
  {: pre}

  Esempio per un ambiente {{site.data.keyword.Bluemix_notm}} dedicato:

  ```

  bx cs cluster-create --machine-type machine-type --workers number --name cluster_name

  ```
  {: pre}


### bx cs cluster-get CLUSTER
{: #cs_cluster_get}

Visualizzare le informazioni su un cluster nella tua organizzazione.

<strong>Opzioni comando</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>(Obbligatorio) Il nome o l'ID del cluster.</dd>
   </dl>

**Esempi**:

  ```
  bx cs cluster-get my_cluster
  ```
  {: pre}


### bx cs cluster-rm [-f] CLUSTER
{: #cs_cluster_rm}

Rimuovi un cluster dalla tua organizzazione.

<strong>Opzioni comando</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>(Obbligatorio) Il nome o l'ID del cluster.</dd>

   <dt><code>-f</code></dt>
   <dd>(Facoltativo) Utilizza questa opzione per forzare la rimozione di un cluster senza richiedere l'intervento dell'utente.</dd>
   </dl>

**Esempi**:

  ```
  bx cs cluster-rm my_cluster
  ```
  {: pre}


### bx cs cluster-service-bind CLUSTER KUBERNETES_NAMESPACE SERVICE_INSTANCE_GUID
{: #cs_cluster_service_bind}

Aggiungi un servizio {{site.data.keyword.Bluemix_notm}} a un cluster.

**Suggerimento:** Per gli utenti {{site.data.keyword.Bluemix_notm}} dedicato, consulta [Aggiunta dei servizi {{site.data.keyword.Bluemix_notm}} ai cluster in {{site.data.keyword.Bluemix_notm}} dedicato (Chiuso beta)](cs_cluster.html#binding_dedicated).

<strong>Opzioni comando</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>(Obbligatorio) Il nome o l'ID del cluster.</dd>

   <dt><code><em>KUBERNETES_NAMESPACE</em></code></dt>
   <dd>(Obbligatorio) Il nome dello spazio dei nomi Kubernetes.</dd>

   <dt><code><em>SERVICE_INSTANCE_GUID</em></code></dt>
   <dd>(Obbligatorio) L'ID dell'istanza del servizio {{site.data.keyword.Bluemix_notm}}
di cui vuoi eseguire il bind.</dd>
   </dl>

**Esempi**:

  ```
  bx cs cluster-service-bind my_cluster my_namespace my_service_instance_GUID
  ```
  {: pre}


### bx cs cluster-service-unbind CLUSTER KUBERNETES_NAMESPACE SERVICE_INSTANCE_GUID
{: #cs_cluster_service_unbind}

Rimuovi un servizio {{site.data.keyword.Bluemix_notm}} da un cluster.

**Nota:** quando rimuovi un servizio {{site.data.keyword.Bluemix_notm}},
le credenziali del servizio vengono rimosse dal cluster. Se un pod sta ancora utilizzando il servizio,
si verificherà un errore perché non è possibile trovare le credenziali del servizio.

<strong>Opzioni comando</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>(Obbligatorio) Il nome o l'ID del cluster.</dd>

   <dt><code><em>KUBERNETES_NAMESPACE</em></code></dt>
   <dd>(Obbligatorio) Il nome dello spazio dei nomi Kubernetes.</dd>

   <dt><code><em>SERVICE_INSTANCE_GUID</em></code></dt>
   <dd>(Obbligatorio) L'ID dell'istanza del servizio {{site.data.keyword.Bluemix_notm}}
che vuoi rimuovere.</dd>
   </dl>

**Esempi**:

  ```
  bx cs cluster-service-unbind my_cluster my_namespace my_service_instance_GUID
  ```
  {: pre}


### bx cs cluster-services CLUSTER [--namespace KUBERNETES_NAMESPACE] [--all-namespaces]
{: #cs_cluster_services}

Elencare i servizi associati a uno o a tutti gli spazi dei nomi Kubernetes in un cluster. Se non viene specificata
alcuna opzione, vengono visualizzati i servizi per lo spazio dei nomi predefinito.

<strong>Opzioni comando</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>(Obbligatorio) Il nome o l'ID del cluster.</dd>

   <dt><code>--namespace <em>KUBERNETES_NAMESPACE</em></code>, <code>-n
<em>KUBERNETES_NAMESPACE</em></code></dt>
   <dd>(Facoltativo) Includi i servizi associati a uno specifico spazio dei nomi in un cluster.</dd>

   <dt><code>--all-namespaces</code></dt>
    <dd>(Facoltativo) Includi i servizi associati a tutti gli spazi dei nomi in un cluster.</dd>
    </dl>

**Esempi**:

  ```
  bx cs cluster-services my_cluster --namespace my_namespace
  ```
  {: pre}


### bx cs cluster-subnet-add CLUSTER SUBNET
{: #cs_cluster_subnet_add}

Rendere disponibile una sottorete in un account {{site.data.keyword.BluSoftlayer_notm}} per un cluster specificato.

**Nota:** quando rendi disponibile una sottorete a un cluster, gli indirizzi IP
di questa sottorete vengono utilizzati per scopi di rete cluster. Per evitare conflitti di indirizzi IP, assicurati
di utilizzare una sottorete con un solo cluster. Non utilizzare una sottorete per più cluster o per altri
scopi al di fuori di {{site.data.keyword.containershort_notm}}
contemporaneamente.

<strong>Opzioni comando</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>(Obbligatorio) Il nome o l'ID del cluster.</dd>

   <dt><code><em>SUBNET</em></code></dt>
   <dd>(Obbligatorio) L'ID della sottorete.</dd>
   </dl>

**Esempi**:

  ```
  bx cs cluster-subnet-add my_cluster subnet
  ```
  {: pre}

### bx cs clusters
{: #cs_clusters}

Visualizzare un elenco di cluster nella tua organizzazione.

<strong>Opzioni comando</strong>:

  None

**Esempi**:

  ```
  bx cs clusters
  ```
  {: pre}


### bx cs credentials-set --infrastructure-api-key API_KEY --infrastructure-username USERNAME
{: #cs_credentials_set}

Configura le credenziali dell'account {{site.data.keyword.BluSoftlayer_notm}} per il tuo account {{site.data.keyword.Bluemix_notm}}. Queste credenziali
ti consentono di accedere al portfolio di {{site.data.keyword.BluSoftlayer_notm}}
attraverso il tuo account {{site.data.keyword.Bluemix_notm}}.

<strong>Opzioni comando</strong>:

   <dl>
   <dt><code>--infrastructure-username <em>USERNAME</em></code></dt>
   <dd>(Obbligatorio) Un nome utente dell'account {{site.data.keyword.BluSoftlayer_notm}}.</dd>
   </dl>

   <dt><code>--infrastructure-api-key <em>API_KEY</em></code></dt>
   <dd>(Obbligatorio) Una chiave API dell'account {{site.data.keyword.BluSoftlayer_notm}}.
   
 <p>
  Per generare una chiave API:
    
  <ol>
  <li>Accedi al portale [{{site.data.keyword.BluSoftlayer_notm}} ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://control.softlayer.com/).</li>
  <li>Seleziona <strong>Account</strong> e quindi <strong>Utenti</strong>.</li>
  <li>Fai clic su <strong>Genera</strong> per generare una chiave API {{site.data.keyword.BluSoftlayer_notm}} per il tuo account.</li>
  <li>Copia la chiave API da utilizzare in questo comando.</li>
  </ol>

  Per visualizzare la tua chiave API esistente:
  <ol>
  <li>Accedi al portale [{{site.data.keyword.BluSoftlayer_notm}} ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://control.softlayer.com/).</li>
  <li>Seleziona <strong>Account</strong> e quindi <strong>Utenti</strong>.</li>
  <li>Fai clic su <strong>Visualizza</strong> per vedere la tua chiave API esistente.</li>
  <li>Copia la chiave API da utilizzare in questo comando.</li>
  </ol></p></dd>
    
**Esempi**:

  ```
  bx cs credentials-set --infrastructure-api-key API_KEY --infrastructure-username USERNAME
  ```
  {: pre}


### bx cs credentials-unset
{: #cs_credentials_unset}

Rimuovere le credenziali dell'account {{site.data.keyword.BluSoftlayer_notm}} dal tuo account {{site.data.keyword.Bluemix_notm}}. Una volta rimosse
le credenziali, non potrai più accedere al portfolio di {{site.data.keyword.BluSoftlayer_notm}} attraverso il tuo account {{site.data.keyword.Bluemix_notm}}.

<strong>Opzioni comando</strong>:

   None

**Esempi**:

  ```
  bx cs credentials-unset
  ```
  {: pre}


### bx cs locations
{: #cs_datacenters}

Visualizzare un elenco di ubicazioni disponibili in cui creare un cluster.

<strong>Opzioni comando</strong>:

   None

**Esempi**:

  ```
  bx cs locations
  ```
  {: pre}


### bx cs help
{: #cs_help}

Visualizzare un elenco di comandi e parametri supportati.

<strong>Opzioni comando</strong>:

   None

**Esempi**:

  ```
  bx cs help
  ```
  {: pre}


### bx cs init [--host HOST]
{: #cs_init}

Inizializzare il plugin {{site.data.keyword.containershort_notm}} o specificare la regione in cui desideri creare o accedere ai cluster Kubernetes.

<strong>Opzioni comando</strong>:

   <dl>
   <dt><code>--host <em>HOST</em></code></dt>
   <dd>(Facoltativo) L'endpoint API {{site.data.keyword.containershort_notm}}
che vuoi utilizzare. Esempi:

    <ul>
    <li>Stati Uniti Sud:

    <pre class="codeblock">
    <code>bx cs init --host https://us-south.containers.bluemix.net</code>
    </pre></li>

    <li>Regno Unito - Sud:

    <pre class="codeblock">
    <code>bx cs init --host https://uk-south.containers.bluemix.net</code>
    </pre></li>

    <li>Europa centrale:

    <pre class="codeblock">
    <code>bx cs init --host https://eu-central.containers.bluemix.net</code>
    </pre></li>

    <li>Asia Pacifico Sud:

    <pre class="codeblock">
    <code>bx cs init --host https://ap-south.containers.bluemix.net</code>
    </pre></li></ul>
</dd>
</dl>


### bx cs machine-types LOCATION
{: #cs_machine_types}

Visualizzare un elenco di tipi di macchina disponibili per i tuoi nodi di lavoro. Ogni tipo di macchina include
la quantità di CPU virtuale, memoria e spazio su disco per ogni nodo di lavoro nel cluster.

<strong>Opzioni comando</strong>:

   <dl>
   <dt><em>LOCATION</em></dt>
   <dd>(Obbligatorio) Immetti l'ubicazione in cui vuoi elencare i tipi di macchina disponibili. Le
ubicazioni disponibili sono: <ul><li>Stati Uniti Sud<ul><li>dal10 [Dallas]</li><li>dal12 [Dallas]</li></ul></li><li>Regno Unito - Sud<ul><li>lon02 [London]</li><li>lon04 [London]</li></ul></li><li>Europa centrale<ul><li>ams03 [Amsterdam]</li><li>ra02 [Frankfurt]</li></ul></li><li>Asia Pacifico Sud<ul><li>syd01 [Sydney]</li><li>syd04 [Sydney]</li></ul></li></ul></dd></dl>
   
**Esempi**:

  ```
  bx cs machine-types LOCATION
  ```
  {: pre}


### bx cs subnets
{: #cs_subnets}

Visualizzare un elenco di sottoreti disponibili in un account {{site.data.keyword.BluSoftlayer_notm}}.

<strong>Opzioni comando</strong>:

   None

**Esempi**:

  ```
  bx cs subnets
  ```
  {: pre}


### bx cs vlans LOCATION
{: #cs_vlans}

Elencare le VLAN pubbliche e private disponibili per un'ubicazione nel tuo account {{site.data.keyword.BluSoftlayer_notm}}. Per elencare le VLAN disponibili,
devi avere un account a pagamento.

<strong>Opzioni comando</strong>:

   <dl>
   <dt>LOCATION</dt>
   <dd>(Obbligatorio) Immetti l'ubicazione in cui vuoi elencare le tue VLAN pubbliche e private. Le
ubicazioni disponibili sono: <ul><li>Stati Uniti Sud<ul><li>dal10 [Dallas]</li><li>dal12 [Dallas]</li></ul></li><li>Regno Unito - Sud<ul><li>lon02 [London]</li><li>lon04 [London]</li></ul></li><li>Europa centrale<ul><li>ams03 [Amsterdam]</li><li>ra02 [Frankfurt]</li></ul></li><li>Asia Pacifico Sud<ul><li>syd01 [Sydney]</li><li>syd04 [Sydney]</li></ul></li></ul></dd>
   </dl>
   
**Esempi**:

  ```
  bx cs vlans dal10
  ```
  {: pre}


### bx cs webhook-create --cluster CLUSTER --level LEVEL --type slack --URL URL
{: #cs_webhook_create}

Creare webhook.

<strong>Opzioni comando</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>(Obbligatorio) Il nome o l'ID del cluster.</dd>

   <dt><code>--level <em>LEVEL</em></code></dt>
   <dd>(Facoltativo) Il livello di notifica, come ad esempio <code>Normal</code> o
<code>Warning</code>. <code>Warning</code> è il valore predefinito.</dd>

   <dt><code>--type <em>slack</em></code></dt>
   <dd>(Obbligatorio) Il tipo di webhook, come ad esempio slack. È supportato solo slack. </dd>

   <dt><code>--URL <em>URL</em></code></dt>
   <dd>(Obbligatorio) L'URL del webhook.</dd>
   </dl>

**Esempi**:

  ```
  bx cs webhook-create --cluster my_cluster --level Normal --type slack --URL http://github.com/<mywebhook>
  ```
  {: pre}


### bx cs worker-add --cluster CLUSTER [--file FILE_LOCATION] [--hardware HARDWARE] --machine-type MACHINE_TYPE --number NUMBER --private-vlan PRIVATE_VLAN --public-vlan PUBLIC_VLAN
{: #cs_worker_add}

Aggiungere i nodi di lavoro al tuo cluster standard.

<strong>Opzioni comando</strong>:

   <dl>
   <dt><code>--cluster <em>CLUSTER</em></code></dt>
   <dd>(Obbligatorio) Il nome o l'ID del cluster.</dd>

    <dt><code>--file <em>FILE_LOCATION</em></dt>
    <dd>Il percorso al file YAML per aggiungere i nodi di lavoro al tuo cluster. Invece di definire ulteriori nodi di lavoro utilizzando le opzioni fornite in questo comando, puoi utilizzare un file YAML.

        <p><strong>Nota:</strong> se fornisci la stessa opzione nel comando come parametro nel file YAML, il valore nel comando ha la precedenza rispetto al valore nel YAML. Ad esempio, definisci un tipo di macchina nel tuo file YAML e utilizzi l'opzione --machine-type nel comando, il valore che hai immesso nell'opzione del comando sovrascrive il valore nel file YAML.

      <pre class="codeblock"><code>
      name: <em>&lt;cluster_name_or_id&gt;</em>
      location: <em>&lt;location&gt;</em>
      machine-type: <em>&lt;machine_type&gt;</em>
      private-vlan: <em>&lt;private_vlan&gt;</em>
      public-vlan: <em>&lt;public_vlan&gt;</em>
      hardware: <em>&lt;shared_or_dedicated&gt;</em>
      workerNum: <em>&lt;number_workers&gt;</em></code></pre>
        
        <table>
        <caption>Tabella 2.Descrizione dei componenti del file YAML</caption>
        <thead>
        <th colspan=2><img src="images/idea.png"/> Descrizione dei
componenti del file YAML</th>
        </thead>
        <tbody>
        <tr>
        <td><code><em>name</em></code></td>
        <td>Sostituisci <code><em>&lt;cluster_name_or_id&gt;</em></code> con il nome o l'ID del cluster in cui desideri aggiungere nodi di lavoro.</td> 
        </tr>
        <tr>
        <td><code><em>location</em></code></td>
        <td>Sostituisci <code><em>&lt;location&gt;</em></code> con l'ubicazione in cui vuoi distribuire i tuoi nodi di lavoro. Le ubicazioni disponibili dipendono dalla regione in cui ha eseguito l'accesso. Per elencare le ubicazioni disponibili, esegui <code>bx cs locations</code>.</td> 
        </tr>
        <tr>
        <td><code><em>machine-type</em></code></td>
        <td>Sostituisci <code><em>&lt;machine_type&gt;</em></code> con il tipo di macchina che vuoi utilizzare per i tuoi nodi di lavoro. Per elencare tutti i tipi di macchina disponibili per la tua ubicazione, esegui <code>bx cs machine-types <em>&lt;location&gt;</em></code>.</td> 
        </tr>
        <tr>
        <td><code><em>private-vlan</em></code></td>
        <td>Sostituisci <code><em>&lt;private_vlan&gt;</em></code> con l'ID della VLAN privata che vuoi utilizzare per i tuoi nodi di lavoro. Per elencare le VLAN disponibili, esegui <code>bx cs vlans <em>&lt;location&gt;</em></code> e ricerca i router VLAN che iniziano con <code>bcr</code> (router di back-end).</td> 
        </tr>
        <tr>
        <td><code>public-vlan</code></td>
        <td>Sostituisci <code>&lt;public_vlan&gt;</code> con l'ID della VLAN pubblica che vuoi utilizzare per i tuoi nodi di lavoro. Per elencare le VLAN disponibili, esegui <code>bx cs vlans &lt;location&gt;</code> e ricerca i router VLAN che iniziano con <code>fcr</code> (router di front-end).</td> 
        </tr>
        <tr>
        <td><code>hardware</code></td>
        <td>Il livello di isolamento hardware per il nodo di lavoro. Utilizza dedicato se vuoi avere risorse fisiche dedicate disponibili solo per te o condiviso per consentire la condivisione delle risorse fisiche con altri clienti IBM. L'impostazione predefinita è condiviso.</td> 
        </tr>
        <tr>
        <td><code>workerNum</code></td>
        <td>Sostituisci <code><em>&lt;number_workers&gt;</em></code> con il numero di nodi di lavoro che vuoi distribuire.</td> 
        </tr>
        </tbody></table></p></dd>

    <dt><code>--hardware <em>HARDWARE</em></dt>
    <dd>(Facoltativo) Il livello di isolamento hardware per il nodo di lavoro. Utilizza dedicato se vuoi avere risorse fisiche dedicate disponibili solo per te o condiviso per consentire la condivisione delle risorse fisiche con altri clienti IBM. L'impostazione predefinita è condiviso.</dd>

    <dt><code>--machine-type <em>MACHINE_TYPE</em></dt>
    <dd>(Obbligatorio) Il tipo di macchina che scegli influisce sulla quantità di memoria e spazio disco
disponibile per i contenitori distribuiti al tuo nodo di lavoro. Per elencare i tipi di macchina disponibili, consulta [bx cs machine-types LOCATION](cs_cli_reference.html#cs_machine_types).</dd>

    <dt><code>--number <em>NUMBER</em></dt>
    <dd>(Obbligatorio) Un numero intero che rappresenta il numero di nodi di lavoro da creare nel cluster.</dd>

    <dt><code>--private-vlan <em>PRIVATE_VLAN</em></dt>
    <dd>(Obbligatorio) Se hai una rete VLAN privata disponibile da utilizzare nell'ubicazione, devi specificare
la VLAN. Se si tratta del primo cluster che crei in questa ubicazione, non utilizzare questo indicatore. Una VLAN privata viene creata per conto tuo.

        <p><strong>Nota:</strong> le VLAN pubbliche e private che specifichi con il comando create devono corrispondere. I router della VLAN privata iniziano sempre con <code>bcr</code> (router back-end) e i router
della VLAN pubblica iniziano sempre con <code>fcr</code> (router front-end). La combinazione di numeri e lettere
dopo questi prefissi devono corrispondere per utilizzare tali VLAN durante la creazione di un cluster. Per creare un cluster, non utilizzare
VLAN pubbliche e private che non corrispondono.</p></dd>

    <dt><code>--public-vlan <em>PUBLIC_VLAN</em></dt>
    <dd>(Obbligatorio) Se hai una rete VLAN pubblica disponibile da utilizzare nell'ubicazione, devi specificare
la VLAN. Se si tratta del primo cluster che crei in questa ubicazione, non utilizzare questo indicatore. Una VLAN pubblica viene creata per conto tuo.

        <p><strong>Nota:</strong> le VLAN pubbliche e private che specifichi con il comando create devono corrispondere. I router della VLAN privata iniziano sempre con <code>bcr</code> (router back-end) e i router
della VLAN pubblica iniziano sempre con <code>fcr</code> (router front-end). La combinazione di numeri e lettere
dopo questi prefissi devono corrispondere per utilizzare tali VLAN durante la creazione di un cluster. Per creare un cluster, non utilizzare
VLAN pubbliche e private che non corrispondono.</p></dd>
        </dl>

**Esempi**:

  ```
  bx cs worker-add --cluster my_cluster --number 3 --public-vlan my_public_vlan_id --private-vlan my_private_vlan_id --machine-type u1c.2x4 --hardware shared
  ```
  {: pre}

  Esempio per {{site.data.keyword.Bluemix_notm}} dedicato:

  ```
  bx cs worker-add --cluster my_cluster --number 3 --machine-type u1c.2x4
  ```
  {: pre}


### bx cs worker-get WORKER_NODE_ID
{: #cs_worker_get}

Visualizzare i dettagli di un nodo di lavoro.

<strong>Opzioni comando</strong>:

   <dl>
   <dt><em>WORKER_NODE_ID</em></dt>
   <dd>L'ID per un nodo di lavoro. Esegui <code>bx cs workers <em>CLUSTER</em></code> per visualizzare gli ID per i nodi di lavoro in un cluster.</dd>
   </dl>

**Esempi**:

  ```
  bx cs worker-get WORKER_NODE_ID
  ```
  {: pre}


### bx cs worker-reboot [-f] [--hard] CLUSTER WORKER [WORKER]
{: #cs_worker_reboot}

Riavviare i nodi di lavoro in un cluster. Se è presente un problema con un nodo di lavoro, tenta prima
di riavviarlo. Se il riavvio non risolve il problema, tenta il comando `worker-reload`. Lo stato dei nodi di lavoro non cambia durante il riavvio. Lo stato di avanzamento rimane `deployed`, ma lo stato viene aggiornato.

<strong>Opzioni comando</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>(Obbligatorio) Il nome o l'ID del cluster.</dd>

   <dt><code>-f</code></dt>
   <dd>(Facoltativo) Utilizza questa opzione per forzare il riavvio del nodo di lavoro senza richiedere l'intervento dell'utente.</dd>

   <dt><code>--hard</code></dt>
   <dd>(Facoltativo) Utilizza questa opzione per effettuare un riavvio forzato di un nodo di lavoro togliendo l'alimentazione
al nodo di lavoro. Utilizza questa opzione se il nodo di lavoro non risponde o ha un blocco
Docker.</dd>

   <dt><code><em>WORKER</em></code></dt>
   <dd>(Obbligatorio) Il nome o l'ID di uno o più nodi di lavoro. Utilizza uno spazio per elencare più
nodi di lavoro.</dd>
   </dl>

**Esempi**:

  ```
  bx cs worker-reboot my_cluster my_node1 my_node2
  ```
  {: pre}


### bx cs worker-reload [-f] CLUSTER WORKER [WORKER]
{: #cs_worker_reload}

Ricaricare i nodi di lavoro in un cluster. Se è presente un problema con un nodo di lavoro, tenta prima
di riavviarlo. Se il riavvio non risolve il problema, tenta il comando `worker-reload`, che riavvia tutte le configurazioni necessarie per il nodo di lavoro.

<strong>Opzioni comando</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>(Obbligatorio) Il nome o l'ID del cluster.</dd>

   <dt><code>-f</code></dt>
   <dd>(Facoltativo) Utilizza questa opzione per forzare il ricaricamento di un nodo di lavoro senza richiedere l'intervento dell'utente.</dd>

   <dt><code><em>WORKER</em></code></dt>
   <dd>(Obbligatorio) Il nome o l'ID di uno o più nodi di lavoro. Utilizza uno spazio per elencare più
nodi di lavoro.</dd>
   </dl>

**Esempi**:

  ```
  bx cs worker-reload my_cluster my_node1 my_node2
  ```
  {: pre}

### bx cs worker-rm [-f] CLUSTER WORKER [WORKER]
{: #cs_worker_rm}

Rimuovere uno o più nodi di lavoro da un cluster.

<strong>Opzioni comando</strong>:

   <dl>
   <dt><code><em>CLUSTER</em></code></dt>
   <dd>(Obbligatorio) Il nome o l'ID del cluster.</dd>

   <dt><code>-f</code></dt>
   <dd>(Facoltativo) Utilizza questa opzione per forzare la rimozione di un nodo di lavoro senza richiedere l'intervento dell'utente.</dd>

   <dt><code><em>WORKER</em></code></dt>
   <dd>(Obbligatorio) Il nome o l'ID di uno o più nodi di lavoro. Utilizza uno spazio per elencare più
nodi di lavoro.</dd>
   </dl>

**Esempi**:

  ```
  bx cs worker-rm my_cluster my_node1 my_node2
  ```
  {: pre}

### bx cs workers CLUSTER
{: #cs_workers}

Visualizzare un elenco di nodi di lavoro e lo stato di ciascun cluster.

<strong>Opzioni comando</strong>:

   <dl>
   <dt><em>CLUSTER</em></dt>
   <dd>(Obbligatorio) Il nome o l'ID del cluster in cui elenchi i nodi di lavoro disponibili.</dd>
   </dl>

**Esempi**:

  ```
  bx cs workers mycluster
  ```
  {: pre}

## Stati cluster
{: #cs_cluster_states}

Puoi visualizzare lo stato del cluster corrente eseguendo il comando bx cs clusters e individuando il campo **State**. Lo stato del cluster ti fornisce le informazioni sulla disponibilità e sulla capacità del cluster e i problemi potenziali che possono venire riscontrati.
{:shortdesc}

|Stato cluster|Motivo|
|-------------|------|
|Distribuzione in corso|Il master Kubernetes non è ancora stato completamente distribuito. Non puoi accedere al cluster.|
|In attesa|Il master Kubernetes è stato distribuito. Sta venendo eseguito il provisioning dei nodi di lavoro e non sono ancora disponibili nel cluster. Puoi accedere al cluster, ma non puoi distribuire le applicazioni al cluster.|
|Normale|Tutti i nodi di lavoro in un cluster sono attivi e in esecuzione. Puoi accedere al cluster e distribuire le applicazioni al cluster.|
|Avvertenza|Almeno un nodo di lavoro nel cluster non è disponibile, ma altri lo sono e possono subentrare nel carico di lavoro. <ol><li>Elenca i nodi di lavoro nel tuo cluster e prendi nota dell'ID dei nodi di lavoro che visualizzano lo stato <strong>Avvertenza</strong>.<pre class="pre"><code>bx cs workers &lt;cluster_name_or_id&gt;</code></pre><li>Ottieni i dettagli per un nodo di lavoro.<pre class="pre"><code>bx cs worker-get &lt;worker_id&gt;</code></pre><li>Controlla i campi <strong>Cndizione</strong>, <strong>Stato</strong> e <strong>Dettagli</strong> per trovare il problema principale per cui il nodo di lavoro è inattivo.</li><li>Se il nodo di lavoro ha quasi raggiunto il limite di spazio disco o di memoria, riduci il carico di lavoro per il tuo nodo di lavoro o aggiungi una nodo di lavoro al tuo cluster per bilanciare il carico del carico di lavoro.</li></ol>|
|Critico|Il master Kubernetes non può essere raggiunto o tutti i nodi di lavoro nel cluster sono inattivi. <ol><li>Elenca i nodi di lavoro nel tuo cluster.<pre class="pre"><code>bx cs workers &lt;cluser_name_or_id&gt;</code></pre><li>Ottieni i dettagli di ogni nodo di lavoro. <pre class="pre"><code>bx cs worker-get &lt;worker_id&gt;</code></pre></li><li>Controlla i campi <strong>Cndizione</strong>, <strong>Stato</strong> e <strong>Dettagli</strong> per trovare il problema principale per cui il nodo di lavoro è inattivo. </li><li>Se lo stato del nodo di lavoro visualizza <strong>Provision_failed</strong>, potresti non disporre delle autorizzazioni necessarie per eseguire il provisioning di un nodo di lavoro dal portfolio {{site.data.keyword.BluSoftlayer_notm}}. Per trovare le autorizzazioni necessarie, consulta [Configurazione dell'accesso al portfolio {{site.data.keyword.BluSoftlayer_notm}} per creare cluster Kubernetes standard](cs_planning.html#cs_planning_unify_accounts).</li><li>Se la condizione del nodo di lavoro visualizza <strong>Critico</strong> e lo stato visualizza <strong>Spazio su disco esaurito</strong>, il tuo nodo di lavoro ha esaurito la capacità. Puoi ridurre il carico di lavoro nel tuo nodo di lavoro o aggiungere un nodo di lavoro al tuo cluster per bilanciare il carico del carico di lavoro.</li><li>Se la condizione del nodo di lavoro visualizza <strong>Critico</strong> e lo stato visualizza <strong>Sconosciuto</strong>, il master Kubernetes non è disponibile. Contatta il supporto {{site.data.keyword.Bluemix_notm}} aprendo un ticket di supporto [{{site.data.keyword.Bluemix_notm}}](/docs/support/index.html#contacting-support).</li></ol>|
{: caption="Tabella 3. Stati cluster" caption-side="top"}
