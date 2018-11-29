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

# Configurazione delle politiche di sicurezza del pod
{: #psp}

Con le [politiche di sicurezza del pod ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/concepts/policy/pod-security-policy/), puoi
configurare le politiche per autorizzare chi può creare e aggiornare i pod in {{site.data.keyword.containerlong}}. I cluster con Kubernetes versioni 1.10.3, 1.9.8 e 1.8.13 o fixpack successivi supportano il controller di ammissione `PodSecurityPolicy` che applica tali politiche. 
{: shortdesc}

Stai utilizzando una versione più vecchia di Kubernetes? [Aggiorna il tuo cluster](cs_cluster_update.html) oggi.
{: tip}

**Perché devo impostare le politiche di sicurezza?**</br>
Come amministratore cluster, vuoi controllare cosa succede nel tuo cluster, specialmente le azioni che influiscono sulla sicurezza o sulla disponibilità del cluster. Le politiche di sicurezza del pod ti consentono di controllare l'uso di contenitori privilegiati, di spazi dei nomi root, di reti host e di porte, di tipi di volume, di file system host, di autorizzazioni Linux come ID di gruppo o di sola lettura e altro.

Con il controller di ammissione `PodSecurityPolicy`, non potrai creare alcun pod fino a quando non [autorizzerai le politiche](#customize_psp). L'impostazione delle politiche di sicurezza del pod può avere effetti secondari involontari, assicurati quindi di eseguire il test di una distribuzione una volta modificata la politica. Per distribuire le applicazioni, tutti gli account utente e di servizio devono essere autorizzati dalle politiche di sicurezza del pod necessarie per distribuire i pod. Ad esempio, se installi le applicazioni utilizzando [Helm](cs_integrations.html#helm_links), il componente tiller di Helm crea i pod e quindi devi disporre della corretta autorizzazione della politica di sicurezza del pod.

Stai provando a controllare quali utenti hanno accesso a {{site.data.keyword.containerlong_notm}}? Vedi [Assegnazione dell'accesso al cluster](cs_users.html#users) per impostare le autorizzazioni IAM e dell'infrastruttura.
{: tip}

**Ci sono politiche configurate per impostazione predefinita? Cosa posso aggiungere?**</br>
Per impostazione predefinita, {{site.data.keyword.containerlong_notm}} configura il controller di ammissione `PodSecurityPolicy` con le [risorse per la gestione cluster {{site.data.keyword.IBM_notm}}](#ibm_psp) che non puoi eliminare o modificare. Inoltre, non puoi disabilitare il controller di ammissione. 

Per impostazione predefinita, le azioni pod non possono essere bloccate. Due risorse RBAC (role-based access control) nel cluster autorizzano invece tutti gli amministratori, gli utenti, i servizi e i nodi a creare pod privilegiati e non privilegiati. Se vuoi impedire che determinati utenti creino o aggiornino i pod, puoi [modificare queste risorse RBAC oppure crearne di tue](#customize_psp).

**Come funziona l'autorizzazione della politica?**</br>
Quando come utente crei direttamente un pod senza utilizzare un controller, ad esempio una distribuzione, le tue credenziali vengono convalidate rispetto alle politiche di sicurezza del pod che hai autorizzato ad utilizzare. Se nessuna politica supporta i requisiti di sicurezza del pod, quest'ultimo non viene creato.

Quando crei un pod utilizzando un controller della risorsa, ad esempio una distribuzione, Kubernetes convalida le credenziali dell'account di servizio del pod rispetto alle politiche di sicurezza del pod che l'account di servizio è autorizzato ad utilizzare. Se nessuna politica supporta i requisiti di sicurezza del pod, il controller ha esito positivo, ma il pod non viene creato.

Per i messaggi di errore comuni, vedi [Distribuzione dei pod non riuscita a causa di una politica di sicurezza del pod](cs_troubleshoot_clusters.html#cs_psp).

## Personalizzazione delle politiche di sicurezza del pod
{: #customize_psp}

Per impedire azioni pod non autorizzate, puoi modificare le risorse della politica di sicurezza del pod esistenti o crearne di tue. Per personalizzare le politiche devi essere un amministratore cluster.
{: shortdesc}

**Quali politiche esistenti posso modificare?**</br>
Per impostazione predefinita, il tuo cluster contiene le seguenti risorse RBAC che consentono agli amministratori
cluster, agli utenti autenticati, agli account di servizio e ai nodi di utilizzare le politiche di sicurezza
del pod `ibm-privileged-psp` e `ibm-restricted-psp`. Queste politiche consentono
agli utenti di creare e aggiornare i pod privilegiati e non privilegiati (limitato).

| Nome | Spazio dei nomi | Tipo | Scopo |
|---|---|---|---|
| `privileged-psp-user` | cluster-wide | `ClusterRoleBinding` | Consente agli amministratori cluster, agli utenti autenticati, agli account di servizio e ai nodi di utilizzare la politica di sicurezza del pod `ibm-privileged-psp`. |
| `restricted-psp-user` | cluster-wide | `ClusterRoleBinding` | Consente agli amministratori cluster, agli utenti autenticati, agli account di servizio e ai nodi di utilizzare la politica di sicurezza del pod `ibm-restricted-psp`. |
{: caption="Risorse RBAC predefinite che puoi modificare" caption-side="top"}

Puoi modificare questi ruoli RBAC per rimuovere o aggiungere gli amministratori, gli utenti, i servizi o i nodi alla politica.

Prima di iniziare: 
*  [Accedi al tuo account. Specifica la regione appropriata e, se applicabile, il gruppo di risorse. Imposta il contesto per il tuo cluster](cs_cli_install.html#cs_cli_configure).
*  Comprendi l'utilizzo dei ruoli RBAC. Per ulteriori informazioni, vedi [Autorizzazione di utenti con ruoli personalizzati di RBAC Kubernetes](cs_users.html#rbac) o la [documentazione Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#api-overview).
*  **Nota**: quando modifichi la configurazione predefinita, puoi impedire l'esecuzione di azioni cluster importanti, ad esempio le distribuzioni pod o gli aggiornamenti cluster. Verifica le tue modifiche in un cluster non di produzione che non viene utilizzato dagli altri team.

**Per modificare le risorse RBAC**:
1.  Richiama il nome del bind del ruolo del cluster RBAC.
    ```
    kubectl get clusterrolebinding
    ```
    {: pre}
    
2.  Scarica il bind del ruolo del cluster come un file `.yaml` che puoi modificare in locale.
    
    ```
    kubectl get clusterrolebinding privileged-psp-user -o yaml > privileged-psp-user.yaml
    ```
    {: pre}
    
    Potresti voler salvare una copia della politica esistente in modo che tu possa ripristinarla nel caso in cui la politica modificata produca risultati non previsti.
    {: tip}
    
    **Esempio di file di bind del ruolo del cluster**:
    
    ```yaml
    apiVersion: rbac.authorization.k8s.io/v1
    kind: ClusterRoleBinding
    metadata:
      creationTimestamp: 2018-06-20T21:19:50Z
      name: privileged-psp-user
      resourceVersion: "1234567"
      selfLink: /apis/rbac.authorization.k8s.io/v1/clusterrolebindings/privileged-psp-user
      uid: aa1a1111-11aa-11a1-aaaa-1a1111aa11a1
    roleRef:
      apiGroup: rbac.authorization.k8s.io
      kind: ClusterRole
      name: ibm-privileged-psp-user
    subjects:
    - apiGroup: rbac.authorization.k8s.io
      kind: Group
      name: system:masters
    - apiGroup: rbac.authorization.k8s.io
      kind: Group
      name: system:nodes
    - apiGroup: rbac.authorization.k8s.io
      kind: Group
      name: system:serviceaccounts
    - apiGroup: rbac.authorization.k8s.io
      kind: Group
      name: system:authenticated
    ```
    {: codeblock}
    
3.  Modifica il file `.yaml` del bind del ruolo del cluster. Per comprendere cosa puoi modificare, esamina la [documentazione Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/concepts/policy/pod-security-policy/). Azioni di esempio:
    
    *   **Account di servizio**: potresti voler autorizzare gli account di servizio in modo che le distribuzioni possano verificarsi solo in specifici spazi dei nomi. Ad esempio, se dedichi la politica per consentire azioni all'interno dello spazio dei nomi `kube-system`, possono verificarsi molte azioni importanti come ad esempio gli aggiornamenti cluster. Tuttavia, le azioni negli altri spazi dei nomi non sono più autorizzate. 
    
        Per dedicare la politica per consentire azioni in uno specifico spazio dei nomi, modifica `system:serviceaccounts` in `system:serviceaccount:<namespace>`.
        ```yaml
        - apiGroup: rbac.authorization.k8s.io
          kind: Group
          name: system:serviceaccount:kube-system
        ```
        {: codeblock}
  
    *   **Utenti**: potresti voler rimuovere l'autorizzazione per tutti gli utenti autenticati per distribuire i pod con accesso privilegiato. Rimuovi la voce `system:authenticated` riportata di seguito.
        ```yaml
        - apiGroup: rbac.authorization.k8s.io
          kind: Group
          name: system:authenticated
        ```
        {: codeblock}

4.  Crea la risorsa di bind del ruolo del cluster modificata nel tuo cluster.

    ```
    kubectl apply -f privileged-psp-user.yaml
    ```
    {: pre}
    
5.  Verifica che la risorsa sia stata modificata.

    ```
    kubectl get clusterrolebinding privileged-psp-user -o yaml
    ```
    {: pre}

</br>
**Per eliminare le risorse RBAC**:
1.  Richiama il nome del bind del ruolo del cluster RBAC.
    ```
    kubectl get clusterrolebinding
    ```
    {: pre}

2.  Elimina il ruolo RBAC che desideri rimuovere.
    ```
    kubectl delete clusterrolebinding privileged-psp-user
    ```
    {: pre}
    
3.  Verifica che il bind del ruolo del cluster RBAC non esista più nel tuo cluster.
    ```
    kubectl get clusterrolebinding
    ```
    {: pre}

</br>
**Per creare la tua politica di sicurezza del pod**:</br>
Per creare la tua risorsa della politica di sicurezza del pod e autorizzare gli utenti con RBAC, esamina la [documentazione Kubernetes ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.io/docs/concepts/policy/pod-security-policy/). 

Assicurati di aver modificato le politiche esistenti in modo che la nuova politica che hai creato non vada in conflitto con quella esistente. Ad esempio, la politica esistente consente agli utenti di creare e aggiornare pod privilegiati. Se crei una politica che non consente agli utenti di creare o aggiornare pod privilegiati, il conflitto tra la nuova politica e quella esistente potrebbe causare risultati imprevisti.

## Descrizione delle risorse predefinite per la gestione cluster {{site.data.keyword.IBM_notm}}
{: #ibm_psp}

Il tuo cluster Kubernetes in {{site.data.keyword.containerlong_notm}} contiene le seguenti politiche di sicurezza del
pod e risorse RBAC correlate per consentire a {{site.data.keyword.IBM_notm}} di gestire correttamente il tuo cluster.
{: shortdesc}

Le risorse RBAC predefinite `privileged-psp-user` e `restricted-psp-user` fanno riferimento alle politiche di sicurezza del pod impostate da {{site.data.keyword.IBM_notm}}. 

**Attenzione**: non devi eliminare o modificare queste risorse.

| Nome | Spazio dei nomi | Tipo | Scopo |
|---|---|---|---|
| `ibm-privileged-psp` | cluster-wide | `PodSecurityPolicy` | Politica per la creazione del pod privilegiato. |
| `ibm-privileged-psp-user` | cluster-wide | `ClusterRole` | Ruolo cluster che consente l'uso della politica di sicurezza del pod `ibm-privileged-psp`. |
| `ibm-privileged-psp-user` | `kube-system` | `RoleBinding` | Consente agli amministratori cluster, agli account di servizio e ai nodi di utilizzare la politica di sicurezza del pod `ibm-privileged-psp` nello spazio dei nomi `kube-system`. |
| `ibm-privileged-psp-user` | `ibm-system` | `RoleBinding` | Consente agli amministratori cluster, agli account di servizio e ai nodi di utilizzare la politica di sicurezza del pod `ibm-privileged-psp` nello spazio dei nomi `ibm-system`. |
| `ibm-privileged-psp-user` | `kubx-cit` | `RoleBinding` | Consente agli amministratori cluster, agli account di servizio e ai nodi di utilizzare la politica di sicurezza del pod `ibm-privileged-psp` nello spazio dei nomi `kubx-cit`. |
| `ibm-restricted-psp` | cluster-wide | `PodSecurityPolicy` | Politica per la creazione di pod non privilegiati o limitati. |
| `ibm-restricted-psp-user` | cluster-wide | `ClusterRole` | Ruolo cluster che consente l'uso della politica di sicurezza del pod `ibm-restricted-psp`. |
{: caption="Risorse delle politiche di sicurezza del pod IBM che non devi modificare" caption-side="top"}
