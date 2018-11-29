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



# Lernprogramm: Istio in einer {{site.data.keyword.containerlong_notm}} bereitstellen
{: #istio_tutorial}

[Istio ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/cloud/info/istio) ist eine offene Plattform zum Verbinden, Sichern, Verwalten und Beobachten von Services auf Cloudplattformen wie Kubernetes in {{site.data.keyword.containerlong}}. Mit Istio können Sie den Netzverkehr und den Lastausgleich zwischen Mikroservices verwalten, Zugriffsrichtlinien durchsetzen, Serviceidentitäten überprüfen und vieles mehr.
{:shortdesc}

In diesem Lernprogramm sehen Sie, wie Istio zusammen mit vier Mikroservices für eine einfache Beispiel-App für Buchhandlungen namens BookInfo installiert wird. Die Mikroservices umfassen eine Produktwebseite, Buchdetails, Rezensionen und Bewertungen. Wenn Sie die Mikroservices von BookInfo in einem {{site.data.keyword.containerlong}}-Cluster bereitstellen, in dem Istio installiert ist, fügen Sie Istio Envoy-Sidecar-Proxys in die Pods für jeden Mikroservice ein.

## Ziele

-   Istio-Helm-Diagramm in Ihrem Cluster bereitstellen
-   Beispielapp BookInfo bereitstellen
-   Bereitstellung der App BookInfo überprüfen und einen Blick auf die drei Versionen der Bewertungsservices werfen

## Erforderlicher Zeitaufwand

30 Minuten

## Zielgruppe

Dieses Lernprogramm ist für Softwareentwickler und Netzadministratoren konzipiert, die Istio zum ersten Mal verwenden.

## Voraussetzungen

-  [Installieren Sie die IBM Cloud-CLI, das {{site.data.keyword.containerlong_notm}}-Plug-in und die Kubernetes-CLI](cs_cli_install.html#cs_cli_install_steps). Für Istio ist Kubernetes Version 1.9 oder höher erforderlich. Stellen Sie sicher, dass Sie die CLI-Version von `kubectl` installieren, die der Kubernetes-Version Ihres Clusters entspricht.
-  [Erstellen Sie einen Cluster, auf dem Kubernetes Version 1.9 oder höher ausgeführt wird](cs_clusters.html#clusters_cli), oder [aktualisieren Sie einen vorhandenen Cluster auf Version 1.9](cs_versions.html#cs_v19).
-  [Richten Sie die CLI auf Ihren Cluster aus](cs_cli_install.html#cs_cli_configure).

## Lerneinheit 1: Istio herunterladen und installieren
{: #istio_tutorial1}

Istio in Ihren Cluster herunterladen und installieren
{:shortdesc}

1. Installieren Sie Istio unter Verwendung des [IBM Istio-Helm-Diagramms ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://console.bluemix.net/containers-kubernetes/solutions/helm-charts/ibm-charts/ibm-istio).
    1. [Richten Sie Helm in Ihrem Cluster ein und fügen Sie der Helm-Instanz das Repository `ibm-charts` hinzu](cs_integrations.html#helm).
    2.  **Nur bei Helm Version 2.9 oder früher**: Installieren Sie die angepassten Ressourcendefinitionen von Istio.
        ```
        kubectl apply -f https://raw.githubusercontent.com/IBM/charts/master/stable/ibm-istio/templates/crds.yaml
        ```
        {: pre}
    3. Installieren Sie das Helm-Diagramm in Ihrem Cluster.
        ```
        helm install ibm-charts/ibm-istio --name=istio --namespace istio-system
        ```
        {: pre}

2. Stellen Sie sicher, dass die Pods für die 9 Istio-Services und der Pod für Prometheus alle vollständig bereitgestellt sind, bevor Sie fortfahren.
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

Hervorragend! Sie haben Istio erfolgreich in Ihrem Cluster installiert. Stellen Sie im nächsten Schritt die Beispiel-App BookInfo in Ihrem Cluster bereit.


## Lerneinheit 2: App BookInfo bereitstellen
{: #istio_tutorial2}

Stellen Sie die Mikroservices der Beispiel-App BookInfo in Ihrem Kubernetes-Cluster bereit.
{:shortdesc}

Diese vier Mikroservices umfassen eine Produktwebseite, Buchdetails, Rezensionen (mit verschiedenen Versionen des Rezensionsmikroservice) sowie Bewertungen. Wenn Sie BookInfo bereitstellen, werden Envoy Sidecar Proxys als Container in die Pods der Mikroservices Ihrer App eingefügt, bevor die Mikroservice-Pods bereitgestellt werden. Istio verwendet eine erweiterte Version des Envoy-Proxys, um den gesamten eingehenden und ausgehenden Datenverkehr für alle Mikroservices im Servicenetz auszugleichen. Weitere Informationen zu Envoy finden Sie in der [Istio-Dokumentation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://istio.io/docs/concepts/what-is-istio/overview/#envoy).

1. Laden Sie das Istio-Paket herunter, das die erforderlichen BookInfo-Dateien enthält.
    1. Laden Sie Istio entweder direkt von [https://github.com/istio/istio/releases ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://github.com/istio/istio/releases) herunter und extrahieren Sie die Installationsdateien oder rufen Sie die aktuelle Version mithilfe von 'cURL' ab:
       ```
       curl -L https://git.io/getLatestIstio | sh -
       ```
       {: pre}

    2. Ändern Sie das Verzeichnis in die Istio-Dateiadresse.
       ```
       cd <dateipfad>/istio-1.0
       ```
       {: pre}

    3. Fügen Sie den Client `istioctl` zu Ihrer PATH-Variablen hinzu. Führen Sie beispielsweise den folgenden Befehl auf einem MacOS- oder Linux-System aus:
        ```
        export PATH=$PWD/istio-1.0/bin:$PATH
        ```
        {: pre}

2. Ordnen Sie dem Namensbereich `default` die Bezeichnung `istio-injection=enabled` zu.
    ```
    kubectl label namespace default istio-injection=enabled
    ```
    {: pre}

3. Stellen Sie die App BookInfo bereit. Wenn die Mikroservices der App bereitgestellt werden, wird auch der Envoy Sidecar in den einzelnen Mikroservice-Pods bereitgestellt.

   ```
   kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml
   ```
   {: pre}

4. Stellen Sie sicher, dass die Mikroservices und ihre zugehörigen Pods bereitgestellt werden:
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

5. Rufen Sie die öffentliche IP-Adresse für Ihren Cluster ab, um die Bereitstellung der App zu überprüfen.
    * Standardcluster:
        1. Stellen Sie das BookInfo-Gateway bereit, um Ihre App über eine öffentliche Ingress-IP zugänglich zu machen.
            ```
            kubectl apply -f samples/bookinfo/networking/bookinfo-gateway.yaml
            ```
            {: pre}

        2. Legen Sie den Ingress-Host fest.
            ```
            export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
            ```
            {: pre}

        3. Legen Sie den Ingress-Port fest.
            ```
            export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')
            ```
            {: pre}

        4. Erstellen Sie die Umgebungsvariable `GATEWAY_URL`, die den Ingress-Host und -Port verwendet.

           ```
           export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT
           ```
           {: pre}

    * Kostenlose Cluster:
        1. Rufen Sie die öffentliche IP-Adresse eines beliebigen Workerknotens in Ihrem Cluster ab.
            ```
            ibmcloud ks workers <clustername_oder_-id>
            ```
            {: pre}

        2. Erstellen Sie die Umgebungsvariable GATEWAY_URL, die die öffentliche IP-Adresse des Workerknotens verwendet.
            ```
            export GATEWAY_URL=<öffentliche_ip_des_workerknotens>:$(kubectl get svc istio-ingressgateway -n istio-system -o jsonpath='{.spec.ports[0].nodePort}')
            ```
            {: pre}

5. Führen Sie den Befehl 'curl' für die Variable `GATEWAY_URL` aus, um zu prüfen, ob die App BookInfo ausgeführt wird. Die Antwort `200` bedeutet, dass die App BookInfo ordnungsgemäß mit Istio ausgeführt wird.
     ```
     curl -o /dev/null -s -w "%{http_code}\n" http://${GATEWAY_URL}/productpage
     ```
     {: pre}

6.  Zeigen Sie die BookInfo-Webseite in einem Browser an.

    Bei Mac OS oder Linux:
    ```
    open http://$GATEWAY_URL/productpage
    ```
    {: pre}

    Bei Windows:
    ```
    start http://$GATEWAY_URL/productpage
    ```
    {: pre}

7. Versuchen Sie mehrfach, die Seite zu aktualisieren. Verschiedene Versionen des Abschnitts mit den Rezensionen zeigen abwechselnd rote, schwarze oder gar keine Sterne an.

Hervorragend! Sie haben die Beispiel-App BookInfo erfolgreich  mit Istio Envoy-Sidecars bereitgestellt. Im nächsten Schritt können Sie Ihre Ressourcen bereinigen oder weitere Lernprogramme durchführen, um Istio näher zu erkunden.

## Bereinigen
{: #istio_tutorial_cleanup}

Wenn Sie die Arbeit mit Istio abgeschlossen haben und Istio nicht [weiter erkunden](#istio_tutorial_whatsnext) möchten, können Sie Ihre Istio-Ressourcen in Ihrem Cluster bereinigen.
{:shortdesc}

1. Löschen Sie alle BookInfo-Services, -Pods und -Bereitstellungen im Cluster.
    ```
    samples/bookinfo/platform/kube/cleanup.sh
    ```
    {: pre}

2. Deinstallieren Sie die Istio-Helm-Bereitstellung.
    ```
    helm del istio --purge
    ```
    {: pre}

3. Wenn Sie Helm 2.9 oder früher verwendet haben:
    1. Löschen Sie die zusätzliche Jobressource.
      ```
      kubectl -n istio-system delete job --all
      ```
      {: pre}
    2. Optional: Löschen Sie die angepassten Ressourcendefinitionen von Istio.
      ```
      kubectl delete -f https://raw.githubusercontent.com/IBM/charts/master/stable/ibm-istio/templates/crds.yaml
      ```
      {: pre}

## Womit möchten Sie fortfahren?
{: #istio_tutorial_whatsnext}

* Möchten Sie Ihre App sowohl mit {{site.data.keyword.containerlong_notm}} als auch Istio zugänglich machen? Informationen zum Verbinden des {{site.data.keyword.containerlong_notm}}-Ingress-ALB und eines Istio-Gateways finden Sie in diesem [Blogbeitrag ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/blogs/bluemix/2018/09/transitioning-your-service-mesh-from-ibm-cloud-kubernetes-service-ingress-to-istio-ingress/).
* Weitere Anleitungen zur Verwendung von Istio finden Sie in der [Istio-Dokumentation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://istio.io/).
    * [Intelligentes Routing ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://istio.io/docs/guides/intelligent-routing.html): In diesem Beispiel wird die Verwendung der verschiedenen Funktionen zur Verwaltung des Datenverkehrs in Istio aufgezeigt, um in BookInfo Datenverkehr an eine bestimmte Version der Mikroservices für Rezensionen und Bewertungen weiterzuleiten.
    * [Intelligentes Routing ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://istio.io/docs/guides/telemetry.html): In diesem Beispiel wird die Verwendung der verschiedenen Funktionen zur Verwaltung des Datenverkehrs in Istio aufgezeigt, um in BookInfo Datenverkehr an eine bestimmte Version der Mikroservices für Rezensionen und Bewertungen weiterzuleiten.
* Belegen Sie die [Kognitive Klasse: Einführung in Mikroservices mit Istio und IBM Cloud Kubernetes-Service ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cognitiveclass.ai/courses/get-started-with-microservices-istio-and-ibm-cloud-container-service/). **Anmerkung**: Sie können den Abschnitt zur Istio-Installation in diesem Kurs überspringen.
* Sehen Sie sich diesen Blogbeitrag zur Verwendung von [Vistio ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://itnext.io/vistio-visualize-your-istio-mesh-using-netflixs-vizceral-b075c402e18e) an, um Ihr Istio-Servicenetz zu visualisieren.
