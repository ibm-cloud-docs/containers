---

copyright:
  years: 2014, 2018
lastupdated: "2018-09-11"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}



# Esercitazione: Installazione di Istio in {{site.data.keyword.containerlong_notm}}
{: #istio_tutorial}

[Istio ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://www.ibm.com/cloud/info/istio) è una piattaforma aperta per connettere, proteggere, controllare e osservare i servizi su piattaforme cloud quali Kubernetes in {{site.data.keyword.containerlong}}. Con Istio, puoi gestire il traffico di rete, bilanciare il carico tra i microservizi, applicare le politiche di accesso, verificare l'identità del servizio e molto altro.
{:shortdesc}

In questa esercitazione, puoi vedere come installare Istio insieme a quattro microservizi per un'applicazione della libreria fittizia semplice denominata BookInfo. I microservizi includono una pagina web del prodotto, i dettagli sul libro, le recensioni e le valutazioni. Quando distribuisci i microservizi di BookInfo in un cluster {{site.data.keyword.containerlong}} in cui è installato Istio, inserisci i proxy sidecar Istio Envoy nei pod di ogni microservizio.

## Obiettivi

-   Distribuisci il grafico Istio Helm nel tuo cluster
-   Distribuisci un'applicazione di esempio BookInfo
-   Verifica il round robin e la distribuzione dell'applicazione BookInfo tramite le tre versioni del servizio di valutazione

## Tempo richiesto

30 minuti

## Destinatari

Questa esercitazione è destinata agli sviluppatori software e agli amministratori di rete che stanno utilizzando Istio per la prima volta.

## Prerequisiti

-  [Installa la CLI IBM Cloud, il plug-in {{site.data.keyword.containerlong_notm}} e la CLI Kubernetes](cs_cli_install.html#cs_cli_install_steps). Istio richiede la versione Kubernetes 1.9 o superiore. Assicurati di installare la versione della CLI `kubectl` che corrisponde alla versione Kubernetes del tuo cluster.
-  [Crea un cluster che esegue Kubernetes versione 1.9 o successive](cs_clusters.html#clusters_cli), oppure [aggiorna un cluster esistente alla versione 1.9](cs_versions.html#cs_v19).
-  [Indirizza la CLI al tuo cluster](cs_cli_install.html#cs_cli_configure).

## Lezione 1: Scarica e installa Istio
{: #istio_tutorial1}

Scarica e installa Istio nel tuo cluster.
{:shortdesc}

1. Installa Istio utilizzando il [grafico IBM Istio Helm ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://console.bluemix.net/containers-kubernetes/solutions/helm-charts/ibm/ibm-istio).
    1. [Configura Helm nel tuo cluster e aggiungi il repository IBM alla tua istanza Helm](cs_integrations.html#helm).
    2.  **Solo per Helm versione 2.9 o precedenti**: Installa le definizioni di risorse personalizzate di Istio.
        ```
        kubectl apply -f https://raw.githubusercontent.com/IBM/charts/master/stable/ibm-istio/templates/crds.yaml
        ```
        {: pre}
    3. Installa il grafico Helm nel tuo cluster.
        ```
        helm install ibm/ibm-istio --name=istio --namespace istio-system
        ```
        {: pre}

2. Prima di continuare, assicurati che i pod per i servizi Istio 9 e il pod per Prometheus siano tutti completamente distribuiti
    ```
    kubectl get pods -n istio-system
    ```
    {: pre}

    ```
    NAME                                       READY     STATUS      RESTARTS   AGE
    istio-citadel-748d656b-pj9bw               1/1       Running     0          2m
    istio-egressgateway-6c65d7c98d-l54kg       1/1       Running     0          2m
    istio-galley-65cfbc6fd7-bpnqx              1/1       Running     0          2m
    istio-ingressgateway-f8dd85989-6w6nj       1/1       Running     0          2m
    istio-pilot-5fd885964b-l4df6               2/2       Running     0          2m
    istio-policy-56f4f4cbbd-2z2bk              2/2       Running     0          2m
    istio-sidecar-injector-646655c8cd-rwvsx    1/1       Running     0          2m
    istio-statsd-prom-bridge-7fdbbf769-8k42l   1/1       Running     0          2m
    istio-telemetry-8687d9d745-mwjbf           2/2       Running     0          2m
    prometheus-55c7c698d6-f4drj                1/1       Running     0          2m
    ```
    {: screen}

Ottimo lavoro! Hai correttamente installato Istio nel tuo cluster. Successivamente, distribuisci l'applicazione di esempio BookInfo nel tuo cluster.


## Lezione 2: Distribuisci l'applicazione BookInfo
{: #istio_tutorial2}

Distribuisci i microservizi dell'applicazione di esempio BookInfo nel tuo cluster Kubernetes.
{:shortdesc}

Questi quattro microservizi includono una pagina web del prodotto, i dettagli sul libro, le recensioni (con diverse versioni del microservizio di recensione) e le valutazioni. Quando distribuisci BookInfo, vengono inseriti i proxy sidecar Envoy come dei contenitori nei pod dei tuoi microservizi dell'applicazione prima che i pod del microservizio vengano distribuiti. Istio utilizza una versione estesa del proxy Envoy per mediare tutto il traffico in entrata e in uscita per tutti i microservizi nella rete di servizi. Per ulteriori informazioni su Envoy, consulta la [documentazione di Istio ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://istio.io/docs/concepts/what-is-istio/overview/#envoy).

1. Scarica il pacchetto Istio che contiene i file BookInfo necessari.
    1. Scarica Istio direttamente da [https://github.com/istio/istio/releases ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://github.com/istio/istio/releases) ed estrai i file di installazione oppure ottieni la versione più recente utilizzando cURL:
       ```
       curl -L https://git.io/getLatestIstio | sh -
       ```
       {: pre}

    2. Modifica la directory con l'ubicazione del file Istio.
       ```
       cd <filepath>/istio-1.0
       ```
       {: pre}

    3. Aggiungi il client `istioctl` al tuo PERCORSO. Ad esempio, immetti il seguente comando su un sistema MacOS o Linux:
        ```
        export PATH=$PWD/istio-1.0/bin:$PATH
        ```
        {: pre}

2. Etichetta lo spazio dei nomi `default` con `istio-injection=enabled`.
    ```
    kubectl label namespace default istio-injection=enabled
    ```
    {: pre}

3. Distribuisci l'applicazione BookInfo. Quando vengono distribuiti i microservizi dell'applicazione, viene distribuito anche il sidecar Envoy in ogni pod del microservizio.

   ```
   kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml
   ```
   {: pre}

4. Assicurati che i microservizi e loro pod corrispondenti siano stati distribuiti:
    ```
    kubectl get svc
    ```
    {: pre}

    ```
    NAME                      TYPE           CLUSTER-IP       EXTERNAL-IP    PORT(S)          AGE
    details                   ClusterIP      172.21.19.104    <none>         9080/TCP         1m
    productpage               ClusterIP      172.21.168.196   <none>         9080/TCP         1m
    ratings                   ClusterIP      172.21.11.131    <none>         9080/TCP         1m
    reviews                   ClusterIP      172.21.117.164   <none>         9080/TCP         1m
    ```
    {: screen}

    ```
    kubectl get pods
    ```
    {: pre}

    ```
    NAME                                     READY     STATUS      RESTARTS   AGE
    details-v1-6865b9b99d-7v9h8              2/2       Running     0          2m
    productpage-v1-f8c8fb8-tbsz9             2/2       Running     0          2m
    ratings-v1-77f657f55d-png6j              2/2       Running     0          2m
    reviews-v1-6b7f6db5c5-fdmbq              2/2       Running     0          2m
    reviews-v2-7ff5966b99-zflkv              2/2       Running     0          2m
    reviews-v3-5df889bcff-nlmjp              2/2       Running     0          2m
    ```
    {: screen}

5. Per verificare la distribuzione dell'applicazione, ottieni l'indirizzo pubblico per il tuo cluster.
    * Cluster standard:
        1. Per esporre la tua applicazione su un IP ingress pubblico, distribuisci il gateway BookInfo.
            ```
            kubectl apply -f samples/bookinfo/networking/bookinfo-gateway.yaml
            ```
            {: pre}

        2. Imposta l'host ingress.
            ```
            export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
            ```
            {: pre}

        3. Imposta la porta ingress.
            ```
            export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')
            ```
            {: pre}

        4. Crea una variabile di ambiente `GATEWAY_URL` che utilizza l'host e la porta ingress.

           ```
           export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT
           ```
           {: pre}

    * Cluster gratuiti:
        1. Ottieni l'indirizzo IP pubblico di qualsiasi nodo di lavoro nel tuo cluster.
            ```
            ibmcloud ks workers <cluster_name_or_ID>
            ```
            {: pre}

        2. Crea una variabile di ambiente GATEWAY_URL che utilizza l'indirizzo IP pubblico del nodo di lavoro.
            ```
            export GATEWAY_URL=<worker_node_public_IP>:$(kubectl get svc istio-ingressgateway -n istio-system -o jsonpath='{.spec.ports[0].nodePort}')
            ```
            {: pre}

5. Esegui il curl della variabile `GATEWAY_URL` per controllare che l'applicazione BookInfo sia in esecuzione. Una risposta `200` significa che l'applicazione BookInfo è in esecuzione correttamente con Istio.
     ```
     curl -o /dev/null -s -w "%{http_code}\n" http://${GATEWAY_URL}/productpage
     ```
     {: pre}

6.  Visualizza la pagina web di BookInfo in un browser.

    Per Mac OS o Linux:
    ```
    open http://$GATEWAY_URL/productpage
    ```
    {: pre}

    Per Windows:
    ```
    start http://$GATEWAY_URL/productpage
    ```
    {: pre}

7. Prova ad aggiornare la pagina diverse volte. Differenti versioni della sezione delle recensioni ruotano e visualizzano le stelle rosse, nere e nessuna stella.

Ottimo lavoro! Hai correttamente distribuito l'applicazione di esempio BookInfo con i sidecar Istio Envoy. Successivamente, puoi ripulire le tue risorse o continuare con ulteriori esercitazioni per esplorare ulteriormente Istio.

## Ripulitura
{: #istio_tutorial_cleanup}

Se hai terminato di utilizzare Istio e non vuoi [continuare l'esplorazione](#istio_tutorial_whatsnext), puoi ripulire le risorse Istio nel tuo cluster.
{:shortdesc}

1. Elimina tutti i servizi, i pod e le distribuzioni di BookInfo nel cluster.
    ```
    samples/bookinfo/platform/kube/cleanup.sh
    ```
    {: pre}

2. Disinstalla la distribuzione Istio Helm.
    ```
    helm del istio --purge
    ```
    {: pre}

3. **Facoltativo**: se stai utilizzando Helm 2.9 o precedenti e hai applicato le definizioni di risorse personalizzate di Istio, eliminale.
    ```
    kubectl delete -f https://raw.githubusercontent.com/IBM/charts/master/stable/ibm-istio/templates/crds.yaml
    ```
    {: pre}

## Operazioni successive
{: #istio_tutorial_whatsnext}

* Per esplorare ulteriormente Istio, puoi trovare ulteriori guide nella [documentazione di Istio ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://istio.io/).
    * [Intelligent Routing ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://istio.io/docs/guides/intelligent-routing.html): questo esempio mostra come instradare il traffico a una versione specifica dei microservizi delle valutazioni e delle recensioni di BookInfo utilizzando le funzionalità di gestione del traffico di Istio.
    * [In-Depth Telemetry ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://istio.io/docs/guides/telemetry.html): questo esempio include come ottenere metriche, log e tracce uniformi tra i microservizi di BookInfo utilizzando Istio Mixer e il proxy Envoy.
* Segui il corso [Cognitive Class: Getting started with Microservices with Istio and IBM Cloud Kubernetes Service ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://cognitiveclass.ai/courses/get-started-with-microservices-istio-and-ibm-cloud-container-service/). **Nota**: puoi tralasciare la sezione relativa all'installazione di Istio di questo corso.
* Controlla questo post del blog relativo all'utilizzo di [Vistio ![Icona link esterno](../icons/launch-glyph.svg "Icona link esterno")](https://itnext.io/vistio-visualize-your-istio-mesh-using-netflixs-vizceral-b075c402e18e) per visualizzare la tua rete di servizi Istio.
