---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

keywords: kubernetes, nginx, iks multiple ingress controllers

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


# Utilizzo di un tuo controller Ingress
{: #ingress-user_managed}

Usa il tuo controller Ingress su {{site.data.keyword.cloud_notm}} e utilizza il certificato TLS e il nome host fornito da IBM.
{: shortdesc}

Gli ALB (application load balancer) Ingress forniti da IBM si basano su controller NGINX che puoi configurare tramite [annotazioni {{site.data.keyword.cloud_notm}} personalizzate](/docs/containers?topic=containers-ingress_annotation). A seconda di ciò di cui necessita la tua applicazione, puoi voler configurare un tuo controller Ingress personalizzato. Quando utilizzi un tuo controller Ingress invece dell'ALB Ingress fornito da IBM, devi occuparti di fornirne l'immagine, di gestirlo e di aggiornarlo e degli eventuali aggiornamenti correlati alla sicurezza, per preservare l'assenza di vulnerabilità nel tuo controller Ingress. **Nota**: l'inserimento del tuo controller Ingress è supportato solo per fornire un accesso esterno pubblico alle tue applicazioni e non per un accesso esterno privato.

Hai 2 opzioni per utilizzare il tuo controller Ingress:
* [Crea un NLB (network load balancer) per esporre la distribuzione del tuo controller Ingress personalizzato, quindi crea un nome host per l'indirizzo IP dell'NLB](#user_managed_nlb). {{site.data.keyword.cloud_notm}} fornisce il nome host e si occupa automaticamente della generazione e dell'aggiornamento di un certificato SSL jolly per il nome host. Per ulteriori informazioni sui nomi host DNS NLB forniti da IBM, vedi [Registrazione di un nome host NLB](/docs/containers?topic=containers-loadbalancer_hostname).
* [Disabilita la distribuzione ALB fornita da IBM e utilizza il servizio del programma di bilanciamento del carico che ha esposto l'ALB e la registrazione DNS del dominio secondario Ingress fornito da IBM](#user_managed_alb). Questa opzione ti consente di sfruttare il dominio secondario Ingress e il certificato TLS già assegnati al tuo cluster.

## Esposizione del tuo controller Ingress attraverso la creazione di un NLB e di un nome host
{: #user_managed_nlb}

Crea un NLB (network load balancer) per esporre la distribuzione del tuo controller Ingress personalizzato, quindi crea un nome host per l'indirizzo IP dell'NLB.
{: shortdesc}

1. Prepara il file di configurazione per il tuo controller Ingress. Ad esempio, puoi utilizzare il [controller Ingress della community NGINX generico del cloud ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/kubernetes/ingress-nginx/tree/master/deploy/cloud-generic). Se utilizzi il controller della community, modifica il file `kustomization.yaml` attraverso la seguente procedura.
  1. Sostituisci il `namespace: ingress-nginx` with `namespace: kube-system`.
  2. Nella sezione `commonLabels`, sostituisci le etichette `app.kubernetes.io/name: ingress-nginx` e `app.kubernetes.io/part-of: ingress-nginx` con una sola etichetta `app: ingress-nginx`.

2. Distribuisci il tuo controller Ingress. Ad esempio, per utilizzare il controller Ingress della community NGINX generico del cloud, esegui il seguente comando.
    ```
    kubectl apply --kustomize . -n kube-system
    ```
    {: pre}

3. Definisci un programma di bilanciamento del carico per esporre la tua distribuzione Ingress personalizzata.
    ```
    apiVersion: v1
    kind: Service
    metadata:
      name: my-lb-svc
    spec:
      type: LoadBalancer
      selector:
        app: ingress-nginx
      ports:
       - protocol: TCP
           port: 8080
        externalTrafficPolicy: Local
    ```
    {: codeblock}

4. Crea il servizio nel tuo cluster.
    ```
    kubectl apply -f my-lb-svc.yaml
    ```
    {: pre}

5. Ottieni l'indirizzo **EXTERNAL-IP** per il programma di bilanciamento del carico.
    ```
    kubectl get svc my-lb-svc -n kube-system
    ```
    {: pre}

    Nel seguente output di esempio, l'**EXTERNAL-IP** è `168.1.1.1`.
    ```
    NAME         TYPE           CLUSTER-IP       EXTERNAL-IP      PORT(S)            AGE
    my-lb-svc    LoadBalancer   172.21.xxx.xxx   168.1.1.1        80:30104/TCP       2m
    ```
    {: screen}

6. Registra l'indirizzo IP del programma di bilanciamento del carico creando un nome host DNS.
    ```
    ibmcloud ks nlb-dns-create --cluster <cluster_name_or_id> --ip <LB_IP>
    ```
    {: pre}

7. Verifica che il nome host sia stato creato.
  ```
  ibmcloud ks nlb-dnss --cluster <cluster_name_or_id>
  ```
  {: pre}

  Output di esempio:
  ```
  Hostname                                                                                IP(s)              Health Monitor   SSL Cert Status           SSL Cert Secret Name
  mycluster-a1b2cdef345678g9hi012j3kl4567890-0001.us-south.containers.appdomain.cloud     ["168.1.1.1"]      None             created                   <certificate>
  ```
  {: screen}

8. Facoltativo: [Abilita i controlli di integrità sul nome host creando un monitoraggio dell'integrità](/docs/containers?topic=containers-loadbalancer_hostname#loadbalancer_hostname_monitor).

9. Distribuisci le altre risorse necessarie al tuo controller Ingress personalizzato, ad esempio la mappa di configurazione.

10. Crea risorse Ingress per le tue applicazioni. Puoi utilizzare la documentazione di Kubernetes per creare [un file di risorse Ingress ![Icona link esterno](../icons/launch-glyph.svg "Iconalink esterno")](https://kubernetes.io/docs/concepts/services-networking/ingress/) e utilizzare le [annotazioni ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/).
  <p class="tip">Se continui a utilizzare gli ALB forniti da IBM contemporaneamente al tuo controller Ingress personalizzato in un unico cluster, puoi creare risorse Ingress distinte per i tuoi ALB e il controller personalizzato. Nella [risorsa Ingress creata che intendi applicare solo agli ALB IBM](/docs/containers?topic=containers-ingress#ingress_expose_public), aggiungi l'annotazione <code>kubernetes.io/ingress.class: "iks-nginx"</code>.</p>

11. Accedi alla tua applicazione attraverso il nome host del programma di bilanciamento del carico individuato nel passo 7 e il percorso su cui è in ascolto la tua applicazione che hai specificato nel file di risorse Ingress.
  ```
  https://<load_blanacer_host_name>/<app_path>
  ```
  {: codeblock}

## Esponi il tuo controller Ingress utilizzando il programma di bilanciamento del carico esistente e il dominio secondario Ingress
{: #user_managed_alb}

Disabilita la distribuzione ALB fornita da IBM e utilizza il servizio del programma di bilanciamento del carico che ha esposto l'ALB e la registrazione DNS del dominio secondario Ingress fornito da IBM.
{: shortdesc}

1. Ottieni l'ID dell'ALB pubblico predefinito. L'ALB pubblico ha un formato simile a `public-cr18e61e63c6e94b658596ca93d087eed9-alb1`.
    ```
    kubectl get svc -n kube-system | grep alb
    ```
    {: pre}

2. Disabilita l'ALB pubblico predefinito. L'indicatore `--disable-deployment` disabilita la distribuzione ALB fornita da IBM, ma non rimuove la registrazione DNS per il dominio secondario Ingress fornito da IBM o il servizio del programma di bilanciamento del carico usato per esporre il controller Ingress.
    ```
    ibmcloud ks alb-configure --albID <ALB_ID> --disable-deployment
    ```
    {: pre}

3. Prepara il file di configurazione per il tuo controller Ingress. Ad esempio, puoi utilizzare il [controller Ingress della community NGINX generico del cloud ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/kubernetes/ingress-nginx/tree/master/deploy/cloud-generic). Se utilizzi il controller della community, modifica il file `kustomization.yaml` attraverso la seguente procedura.
  1. Sostituisci il `namespace: ingress-nginx` with `namespace: kube-system`.
  2. Nella sezione `commonLabels`, sostituisci le etichette `app.kubernetes.io/name: ingress-nginx` e `app.kubernetes.io/part-of: ingress-nginx` con una sola etichetta `app: ingress-nginx`.
  3. Nella variabile `SERVICE_NAME`, sostituisci `name: ingress-nginx` con `name: <ALB_ID>`. Ad esempio, l'ID ALB del passo 1 potrebbe essere `nome: public-cr18e61e63c6e94b658596ca93d087eed9-alb1`.

4. Distribuisci il tuo controller Ingress. Ad esempio, per utilizzare il controller Ingress della community NGINX generico del cloud, esegui il seguente comando. **Importante**: per continuare a usare il servizio del programma di bilanciamento del carico che espone il controller e il dominio secondario Ingress fornito da IBM, il tuo controller deve essere distribuito nello spazio dei nomi `kube-system`.
    ```
    kubectl apply --kustomize . -n kube-system
    ```
    {: pre}

5. Ottieni l'etichetta sulla tua distribuzione Ingress personalizzata.
    ```
    kubectl get deploy <ingress-controller-name> -n kube-system --show-labels
    ```
    {: pre}

    Nel seguente output di esempio, il valore dell'etichetta è `ingress-nginx`:
    ```
    NAME                       DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE       LABELS
    nginx-ingress-controller   1         1         1            1           1m        app=ingress-nginx
    ```
    {: screen}

6. Utilizzando l'ID ALB ottenuto nel passo 1, apri il servizio del programma di bilanciamento del carico che espone l'ALB IBM.
    ```
    kubectl edit svc <ALB_ID> -n kube-system
    ```
    {: pre}

7. Aggiorna il servizio del programma di bilanciamento del carico in modo che punti alla tua distribuzione Ingress personalizzata. In `spec/selector`, rimuovi l'ID ALB dall'etichetta `app` e aggiungi l'etichetta per il tuo controller Ingress che hai ottenuto nel passo 5.
    ```
    apiVersion: v1
    kind: Service
    metadata:
      ...
    spec:
      clusterIP: 172.21.xxx.xxx
      externalTrafficPolicy: Cluster
      loadBalancerIP: 169.xx.xxx.xxx
      ports:
      - name: http
        nodePort: 31070
        port: 80
        protocol: TCP
        targetPort: 80
      - name: https
        nodePort: 31854
        port: 443
        protocol: TCP
        targetPort: 443
      selector:
        app: <custom_controller_label>
      ...
    ```
    {: codeblock}
    1. Facoltativo: per impostazione predefinita, il servizio del programma di bilanciamento del carico consente il traffico sulla porta 80 e 443. Se il tuo controller Ingress personalizzato richiede una diversa serie di porte, aggiungi tali porte alla sezione `ports`.

8. Salva e chiudi il file di configurazione. L'output è simile al seguente:
    ```
    service "public-cr18e61e63c6e94b658596ca93d087eed9-alb1" edited
    ```
    {: screen}

9. Verifica che ora l'ALB `Selector` punti al tuo controller.
    ```
    kubectl describe svc <ALB_ID> -n kube-system
    ```
    {: pre}

    Output di esempio:
    ```
    Name:                     public-cre58bff97659a4f41bc927362d5a8ee7a-alb1
    Namespace:                kube-system
    Labels:                   app=public-cre58bff97659a4f41bc927362d5a8ee7a-alb1
    Annotations:              service.kubernetes.io/ibm-ingress-controller-public=169.xx.xxx.xxx
                              service.kubernetes.io/ibm-load-balancer-cloud-provider-zone=wdc07
    Selector:                 app=ingress-nginx
    Type:                     LoadBalancer
    IP:                       172.21.xxx.xxx
    IP:                       169.xx.xxx.xxx
    LoadBalancer Ingress:     169.xx.xxx.xxx
    Port:                     port-443  443/TCP
    TargetPort:               443/TCP
    NodePort:                 port-443  30087/TCP
    Endpoints:                172.30.xxx.xxx:443
    Port:                     port-80  80/TCP
    TargetPort:               80/TCP
    NodePort:                 port-80  31865/TCP
    Endpoints:                172.30.xxx.xxx:80
    Session Affinity:         None
    External Traffic Policy:  Cluster
    Events:                   <none>
    ```
    {: screen}

10. Distribuisci le altre risorse necessarie al tuo controller Ingress personalizzato, ad esempio la mappa di configurazione.

11. Se hai un cluster multizona, ripeti questi passi per ciascun ALB.

12. Se hai un cluster multizona, devi configurare un controllo dell'integrità. L'endpoint del controllo di integrità DNS Cloudflare, `albhealth.<clustername>.<region>.containers.appdomain.com`, si aspetta una risposta `200` con `healthy` nel corpo della risposta. Se nessun controllo dell'integrità è impostato per restituire `200` e `healthy`, il controllo dell'integrità rimuove qualsiasi indirizzo IP ALB dal pool di DNS. Puoi modificare la risorsa di controllo dell'integrità esistente o crearne una propria.
  * Per modificare la risorsa di controllo dell'integrità esistente:
      1. Apri la risorsa `alb-health`.
        ```
        kubectl edit ingress alb-health --namespace kube-system
        ```
        {: pre}
      2. Nella sezione `metadata.annotations`, modifica il nome dell'annotazione `ingress.bluemix.net/server-snippets` nell'annotazione supportata dal tuo controller. Ad esempio, puoi utilizzare l'annotazione `nginx.ingress.kubernetes.io/server-snippet`. Non modificare il contenuto del frammento del server.
      3. Salva e chiudi il file. Le tue modifiche vengono applicate automaticamente.
  * Per creare la tua risorsa di controllo dell'integrità, assicurati che il seguente frammento venga restituito a Cloudflare:
    ```
    { return 200 'healthy'; add_header Content-Type text/plain; }
    ```
    {: codeblock}

13. Crea le risorse Ingress per le tue applicazioni seguendo i passi presenti in [Esposizione delle applicazioni all'interno del tuo cluster al pubblico](/docs/containers?topic=containers-ingress#ingress_expose_public).

Ora le tue applicazioni sono esposte dal tuo controller Ingress personalizzato. Per ripristinare la distribuzione ALB fornita da IBM, abilita di nuovo l'ALB. L'ALB viene ridistribuito e il servizio del programma di bilanciamento del carico viene riconfigurato automaticamente per puntare all'ALB.

```
ibmcloud ks alb-configure --albID <alb ID> --enable
```
{: pre}
