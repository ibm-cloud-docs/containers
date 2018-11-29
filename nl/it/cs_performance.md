---

copyright:
  years: 2014, 2018
lastupdated: "2018-10-25"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}

# Ottimizzazione delle prestazioni
{: #kernel}

Se hai dei requisiti di ottimizzazione delle prestazioni specifici, puoi modificare le impostazioni predefinite per i parametri `sysctl` del kernel Linux sui nodi di lavoro e gli spazi di nomi della rete di pod in {{site.data.keyword.containerlong}}.
{: shortdesc}

I nodi di lavoro vengono automaticamente forniti con prestazioni kernel ottimizzate, ma puoi modificare le impostazioni predefinite applicando un oggetto `DaemonSet` Kubernetes personalizzato al tuo cluster. La serie di daemon modifica le impostazioni per tutti i nodi di lavoro esistenti e applica le impostazioni a qualsiasi nuovo nodo di lavoro che viene fornito nel cluster. Nessun pod è interessato.

Per ottimizzare le impostazioni del kernel per i pod dell'applicazione, puoi inserire un initContainer nello YAML `pod/ds/rs/deployment` per ciascuna distribuzione. L'initContainer viene aggiunto a ciascuna distribuzione dell'applicazione che si trova nello spazio dei nomi della rete di pod per cui vuoi ottimizzare le prestazioni.

Ad esempio, gli esempi nelle seguenti sezioni modificano il numero massimo predefinito di connessioni consentito nell'ambiente tramite l'impostazione `net.core.somaxconn` e l'intervallo di porte temporanee tramite l'impostazione `net.ipv4.ip_local_port_range`.

**Avvertenza**: se scegli di modificare le impostazioni predefinite dei parametri del kernel, lo stai facendo a tuo rischio e pericolo. Sei responsabile dell'esecuzione di test sulle eventuali impostazioni modificate e per qualsiasi eventuale interruzione causata dalle impostazioni modificate nel tuo ambiente.

## Ottimizzazione delle prestazioni dei nodi di lavoro
{: #worker}

Applica una [serie di daemon ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) per modificare i parametri kernel sull'host del nodo di lavoro.

**Nota**: devi disporre del [ruolo di accesso Amministratore](cs_users.html#access_policies) per eseguire l'initContainer privilegiato di esempio. Dopo che i contenitori per le distribuzioni sono stati inizializzati, i privilegi vengono eliminati.

1. Salva la seguente serie di daemon in un file denominato `worker-node-kernel-settings.yaml`. Nella sezione `spec.template.spec.initContainers`, aggiungi i campi e i valori per i parametri `sysctl` che vuoi ottimizzare. Questa serie di daemon di esempio modifica i valori dei parametri `net.core.somaxconn` e `net.ipv4.ip_local_port_range`.
    ```
    apiVersion: extensions/v1beta1
    kind: DaemonSet
    metadata:
      name: kernel-optimization
      namespace: kube-system
      labels:
        tier: management
        app: kernel-optimization
    spec:
      template:
        metadata:
          labels:
            name: kernel-optimization
        spec:
          hostNetwork: true
          hostPID: true
          hostIPC: true
          initContainers:
            - command:
                - sh
                - -c
                - sysctl -w net.ipv4.ip_local_port_range="1025 65535"; sysctl -w net.core.somaxconn=32768;
              image: alpine:3.6
              imagePullPolicy: IfNotPresent
              name: sysctl
              resources: {}
              securityContext:
                privileged: true
                capabilities:
                  add:
                    - NET_ADMIN
              volumeMounts:
                - name: modifysys
                  mountPath: /sys
          containers:
            - resources:
                requests:
                  cpu: 0.01
              image: alpine:3.6
              name: sleepforever
              command: ["/bin/sh", "-c"]
              args:
                - >
                  while true; do
                    sleep 100000;
                  done
          volumes:
            - name: modifysys
              hostPath:
                path: /sys
    ```
    {: codeblock}

2. Applica la serie di daemon ai tuoi nodi di lavoro. Le modifiche vengono applicate immediatamente.
    ```
    kubectl apply -f worker-node-kernel-settings.yaml
    ```
    {: pre}

<br />

Per ripristinare i parametri `sysctl` dei tuoi nodi di lavoro ai valori predefiniti impostati da {{site.data.keyword.containerlong_notm}}:

1. Elimina la serie di daemon. Gli initContainer che si applicavano alle impostazioni personalizzate vengono rimossi.
    ```
    kubectl delete ds kernel-optimization
    ```
    {: pre}

2. [Riavvia tutti i nodi di lavoro nel cluster](cs_cli_reference.html#cs_worker_reboot). I nodi di lavoro tornano online con i valori predefiniti applicati.

<br />


## Ottimizzazione delle prestazioni dei pod
{: #pod}

Se hai delle specifiche esigenze di carico di lavoro, puoi applicare una patch [initContainer ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/) per modificare i parametri kernel per i pod dell'applicazione.
{: shortdesc}

**Nota**: devi disporre del [ruolo di accesso Amministratore](cs_users.html#access_policies) per eseguire l'initContainer privilegiato di esempio. Dopo che i contenitori per le distribuzioni sono stati inizializzati, i privilegi vengono eliminati.

1. Salva la seguente patch initContainer in un file denominato `pod-patch.yaml` e aggiungi i campi e i valori per i parametri `sysctl` che vuoi ottimizzare. Questo initContainer di esempio modifica i valori dei parametri `net.core.somaxconn` e `net.ipv4.ip_local_port_range`.
    ```
    spec:
      template:
        spec:
          initContainers:
          - command:
            - sh
            - -c
            - sysctl -e -w net.core.somaxconn=32768;  sysctl -e -w net.ipv4.ip_local_port_range="1025 65535";
            image: alpine:3.6
            imagePullPolicy: IfNotPresent
            name: sysctl
            resources: {}
            securityContext:
              privileged: true
    ```
    {: codeblock}

2. Applica la patch a ciascuna delle tue distribuzioni.
    ```
    kubectl patch deployment <deployment_name> --patch pod-patch.yaml
    ```
    {: pre}

3. Se hai modificato il valore `net.core.somaxconn` nelle impostazioni del kernel, la maggior parte delle applicazioni può utilizzare automaticamente il valore aggiornato. Tuttavia, alcune applicazioni potrebbero richiedere che tu modifichi manualmente il valore corrispondente nel codice dell'applicazione in modo che corrisponda al valore del kernel. Ad esempio, se stai ottimizzando le prestazioni di un pod in cui è in esecuzione un'applicazione NGINX, devi modificare il valore del campo `backlog` nel codice dell'applicazione NGINX in modo che corrisponda. Per ulteriori informazioni, vedi questo [post del blog di NGINX ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.nginx.com/blog/tuning-nginx/).
