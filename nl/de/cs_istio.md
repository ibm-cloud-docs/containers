---

copyright:
  years: 2014, 2019
lastupdated: "2019-03-21"

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


# Verwaltetes Istio-Add-on verwenden (Beta)
{: #istio}

Istio on {{site.data.keyword.containerlong}} stellt eine nahtlose Installation von Istio, automatische Updates und Lebenszyklusmanagementfunktionen für Komponenten der Istio-Steuerebene bereit und ermöglicht die Integration in Protokollierungs- und Überwachungstools für die Plattform.
{: shortdesc}

Durch einen Klick können Sie alle Istio-Kernkomponenten, zusätzliche Trace-, Überwachungs- und Visualisierungsfunktionen sowie die betriebsbereite Beispielapp 'BookInfo' abrufen. Istio on {{site.data.keyword.containerlong_notm}} wird als verwaltetes Add-on angeboten, sodass {{site.data.keyword.Bluemix_notm}} Ihre Istio-Komponenten automatisch auf aktuellem Stand hält.

## Erklärung von Istio on {{site.data.keyword.containerlong_notm}}
{: #istio_ov}

### Was ist Istio?
{: #istio_ov_what_is}

[Istio ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.ibm.com/cloud/info/istio) ist eine offene Plattform für vernetzte Services zum Verbinden, Sichern, Steuern und Beobachten von Microservices auf Cloudplattformen wie Kubernetes in {{site.data.keyword.containerlong_notm}}.
{:shortdesc}

Wenn Sie monolithische Gesamtanwendungen auf eine verteilte Microservice-Architektur verlegen, ergibt sich eine Reihe neuer Herausforderungen, wie zum Beispiel die Steuerung des Datenverkehrs Ihrer Microservices, die Bereitstellung von Dark Launches und Canary-Rollouts Ihrer Services, die Behandlung von Fehlern, die Sicherung der Servicekommunikation, die Beobachtung der Services sowie die Umsetzung konsistenter Zugriffsrichtlinien über die gesamte Palette der Services hinweg. Um diese Schwierigkeiten in den Griff zu bekommen, können Sie auf ein Servicenetz zurückgreifen. Ein Servicenetz stellt ein transparentes und sprachunabhängiges Netz zur Verfügung, über das Sie die Konnektivität zwischen Microservices herstellen, beobachten, schützen und steuern können. Istio bietet Erkenntnisse und Steuerungsmöglichkeiten über das Servicenetz, durch die Sie neben anderen Funktionen den Netzdatenverkehr verwalten, die Auslastung auf Microservices verteilen, Zugriffsrichtlinien durchsetzen und Serviceidentitäten überprüfen können.

Istio in Ihrem Microservicenetz bietet Ihnen zum Beispiel die folgenden Möglichkeiten:
- Sie erhalten einen besseren Einblick in die Apps, die in Ihrem Cluster ausgeführt werden.
- Sie können Canary-Versionen von Apps bereitstellen und den Datenverkehr steuern, der an diese Apps gesendet wird.
- Sie können eine automatische Verschlüsselung von Daten aktivieren, die zwischen Microservices übertragen werden.
- Sie können eine Ratenbegrenzung und attributbasierte Whitelist- und Blacklist-Richtlinien durchsetzen.

Ein Istio-Servicenetz besteht aus einer Datenebene und einer Steuerebene. Die Datenebene besteht aus Envoy-Proxy-Sidecars in jedem App-Pod, die die Kommunikation zwischen Microservices vermitteln. Die Steuerebene besteht aus Pilot, Mixer-Telemetrie und -Richtlinie sowie Citadel. Diese Komponenten wenden Istio-Konfigurationen in Ihrem Cluster an. Weitere Informationen zu diesen Komponenten finden Sie in der [Beschreibung des Add-ons `istio`](#istio_components).

### Was ist Istio on {{site.data.keyword.containerlong_notm}} (Beta)?
{: #istio_ov_addon}

Istio on {{site.data.keyword.containerlong_notm}} wird als verwaltetes Add-on angeboten, das Istio direkt in Ihren Kubernetes-Cluster integriert.
{: shortdesc}

**Wie sieht dies in meinem Cluster aus?**</br>
Wenn Sie das Istio-Add-on installieren, verwenden die Istio-Steuerebene und die Istio-Datenebene die VLANs, mit denen Ihr Cluster bereits verbunden ist. Der Konfigurationsdatenverkehr fließt über das private Netz in Ihrem Cluster und erfordert kein Öffnen zusätzlicher Ports oder IP-Adressen in Ihrer Firewall. Wenn Sie Ihre durch Istio verwalteten Apps mit einem Istio-Gateway zugänglich machen, fließen externe Datenverkehrsanforderungen an die Apps über das öffentliche VLAN.

**Wie funktioniert der Aktualisierungsprozess?**</br>
Die Istio-Version in dem verwalteten Add-on wurde von {{site.data.keyword.Bluemix_notm}} getestet und für die Verwendung in {{site.data.keyword.containerlong_notm}} genehmigt. Darüber hinaus vereinfacht das Istio-Add-on die Wartung Ihrer Istio-Steuerebene, sodass Sie sich auf die Verwaltung Ihrer Microservices konzentrieren können. {{site.data.keyword.Bluemix_notm}} hält alle Ihre Istio-Komponenten auf dem aktuellen Stand, indem Aktualisierungen auf die neueste Version von Istio, die von {{site.data.keyword.containerlong_notm}} unterstützt wird, durch automatische Rollouts zur Verfügung gestellt werden.  

Wenn Sie die neueste Version von Istio verwenden oder Ihre Istio-Installation anpassen müssen, können Sie die Open-Source-Version von Istio installieren, indem Sie die im [Lernprogramm für den Schnelleinstieg in {{site.data.keyword.Bluemix_notm}} ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://istio.io/docs/setup/kubernetes/quick-start-ibm/) erläuterten Schritte ausführen.
{: tip}

**Gibt es Einschränkungen?** </br>
Wenn Sie den [Zugangscontroller zur Durchsetzung der Sicherheit von Container-Images](/docs/services/Registry?topic=registry-security_enforce#security_enforce) in Ihrem Cluster installiert haben, können Sie das verwaltete Istio-Add-on in Ihrem Cluster nicht aktivieren.

<br />


## Was kann ich installieren?
{: #istio_components}

Istio on {{site.data.keyword.containerlong_notm}} wird in Form von drei verwalteten Add-ons in Ihrem Cluster angeboten.
{: shortdesc}

<dl>
<dt>Istio (`istio`)</dt>
<dd>Installiert die Kernkomponenten von Istio, einschließlich Prometheus. Weitere Informationen zu einer der folgenden Steuerebenenkomponenten finden Sie in der [Istio-Dokumentation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://istio.io/docs/concepts/what-is-istio).
  <ul><li>`Envoy` fungiert als Proxy für ein- und ausgehenden Datenverkehr für alle Services im Netz. Envoy wird als Sidecar-Container im selben Pod wie Ihr App-Container bereitgestellt.</li>
  <li>`Mixer` stellt Funktionen zur Telemetrieerfassung und Richtliniensteuerung zur Verfügung.<ul>
    <li>Telemetrie-Pods werden mit einem Prometheus-Endpunkt aktiviert, der alle Telemetriedaten aus den Envoy-Proxy-Sidecars und Services in Ihren App-Pods aggregiert.</li>
    <li>Richtlinienpods setzen die Zugriffssteuerung durch, einschließlich Ratenbegrenzung und Anwendung von Whitelist- und Blacklist-Richtlinien.</li></ul>
  </li>
  <li>`Pilot` stellt eine Serviceerkennung für die Envoy-Sidecars bereit und konfiguriert die Routing-Regeln des Datenverkehrsmanagements für Sidecars.</li>
  <li>`Citadel` arbeitet mit einem Identitäts- und Berechtigungsnachweismanagement, um eine Authentifizierung zwischen Services und von Endbenutzern bereitzustellen.</li>
  <li>`Galley` validiert Konfigurationsänderungen für die anderen Komponenten der Istio-Steuerebene.</li>
</ul></dd>
<dt>Istio-Extras (`istio-extras`)</dt>
<dd>Optional: Installiert [Grafana ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://grafana.com/), [Jaeger ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.jaegertracing.io/) und [Kiali ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.kiali.io/), um zusätzliche Überwachungs-, Trace- und Visualisierungsfunktionen für Istio bereitzustellen.</dd>
<dt>Beispielapp 'BookInfo' (`istio-sample-bookinfo`)</dt>
<dd>Optional: Stellt die [Beispielanwendung 'BookInfo' für Istio ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://istio.io/docs/examples/bookinfo/) bereit. Diese Bereitstellung enthält das Basisdemo-Setup und die Standardzielregeln, sodass Sie die Funktionen von Istio sofort ausprobieren können.</dd>
</dl>

<br>
Sie können die Istio-Add-ons, die in Ihrem Cluster aktiviert sind, immer mit dem folgenden Befehl anzeigen:
```
ibmcloud ks cluster-addons --cluster <clustername_oder_-id>
```
{: pre}

Das verwaltete Add-on `istio` kann in einem kostenlosen Cluster installiert werden. Wenn Sie außerdem die Add-ons `istio-extras` und `istio-sample-bookinfo` installieren möchten, erstellen Sie einen Standardcluster mit mindestens zwei Workerknoten.
{: note}

<br />


## Istio on {{site.data.keyword.containerlong_notm}} installieren
{: #istio_install}

Installieren Sie verwaltete Istio-Add-ons in einem vorhandenen Cluster.
{: shortdesc}

**Vorbereitende Schritte**</br>
* Stellen Sie sicher, dass Sie über die [{{site.data.keyword.Bluemix_notm}} IAM-Servicerolle **Schreibberechtigter** oder **Manager**](/docs/containers?topic=containers-users#platform) für {{site.data.keyword.containerlong_notm}} verfügen.
* [Definieren Sie als Ziel Ihrer CLI einen vorhanden Cluster der Version 1.10 oder höher](/docs/containers?topic=containers-cs_cli_install#cs_cli_configure).
* Wenn Sie Istio zuvor mit dem IBM Helm-Diagramm oder durch eine andere Methode im Cluster installiert haben, [bereinigen Sie diese Istio-Installation](#istio_uninstall_other).

### Verwaltete Istio-Add-ons in der CLI installieren
{: #istio_install_cli}

1. Aktivieren Sie das Add-on `istio`.
  ```
  ibmcloud ks cluster-addon-enable istio --cluster <clustername_oder_-id>
  ```
  {: pre}

2. Optional: Aktivieren Sie das Add-on `istio-extras`.
  ```
  ibmcloud ks cluster-addon-enable istio-extras --cluster <clustername_oder_-id>
  ```
  {: pre}

3. Optional: Aktivieren Sie das Add-on `istio-sample-bookinfo`.
  ```
  ibmcloud ks cluster-addon-enable istio-sample-bookinfo --cluster <clustername_oder_-id>
  ```
  {: pre}

4. Überprüfen Sie, ob die verwalteten Istio-Add-ons, die Sie installiert haben, in diesem Cluster aktiviert sind.
  ```
  ibmcloud ks cluster-addons --cluster <clustername_oder_-id>
  ```
  {: pre}

  Beispielausgabe:
  ```
  Name                      Version
  istio                     1.0.5
  istio-extras              1.0.5
  istio-sample-bookinfo     1.0.5
  ```
  {: screen}

5. Sie können auch die einzelnen Komponenten jedes Add-ons in Ihrem Cluster prüfen.
  - Komponenten von `istio` und `istio-extras`: Stellen Sie sicher, dass die Istio-Services und die entsprechenden Pods bereitgestellt wurden.
    ```
    kubectl get svc -n istio-system
    ```
    {: pre}

    ```
    NAME                     TYPE           CLUSTER-IP       EXTERNAL-IP                                                                    AGE
    grafana                  ClusterIP      172.21.98.154    <none>          3000/TCP                                                       2m
    istio-citadel            ClusterIP      172.21.221.65    <none>          8060/TCP,9093/TCP                                              2m
    istio-egressgateway      ClusterIP      172.21.46.253    <none>          80/TCP,443/TCP                                                 2m
    istio-galley             ClusterIP      172.21.125.77    <none>          443/TCP,9093/TCP                                               2m
    istio-ingressgateway     LoadBalancer   172.21.230.230   169.46.56.125   80:31380/TCP,443:31390/TCP,31400:31400/TCP,5011:31323/TCP,
                                                                              8060:32483/TCP,853:32628/TCP,15030:31601/TCP,15031:31915/TCP   2m
    istio-pilot              ClusterIP      172.21.171.29    <none>          15010/TCP,15011/TCP,8080/TCP,9093/TCP                          2m
    istio-policy             ClusterIP      172.21.140.180   <none>          9091/TCP,15004/TCP,9093/TCP                                    2m
    istio-sidecar-injector   ClusterIP      172.21.248.36    <none>          443/TCP                                                        2m
    istio-telemetry          ClusterIP      172.21.204.173   <none>          9091/TCP,15004/TCP,9093/TCP,42422/TCP                          2m
    jaeger-agent             ClusterIP      None             <none>          5775/UDP,6831/UDP,6832/UDP                                     2m
    jaeger-collector         ClusterIP      172.21.65.195    <none>          14267/TCP,14268/TCP                                            2m
    jaeger-query             ClusterIP      172.21.171.199   <none>          16686/TCP                                                      2m
    kiali                    ClusterIP      172.21.13.35     <none>          20001/TCP                                                      2m
    prometheus               ClusterIP      172.21.105.229   <none>          9090/TCP                                                       2m
    tracing                  ClusterIP      172.21.125.177   <none>          80/TCP                                                         2m
    zipkin                   ClusterIP      172.21.1.77      <none>          9411/TCP                                                       2m
    ```
    {: screen}

    ```
    kubectl get pods -n istio-system
    ```
    {: pre}

    ```
    NAME                                      READY   STATUS    RESTARTS   AGE
    grafana-76dcdfc987-94ldq                  1/1     Running   0          2m
    istio-citadel-869c7f9498-wtldz            1/1     Running   0          2m
    istio-egressgateway-69bb5d4585-qxxbp      1/1     Running   0          2m
    istio-galley-75d7b5bdb9-c9d9n             1/1     Running   0          2m
    istio-ingressgateway-5c8764db74-gh8xg     1/1     Running   0          2m
    istio-pilot-55fd7d886f-vv6fb              2/2     Running   0          2m
    istio-policy-6bb6f6ddb9-s4c8t             2/2     Running   0          2m
    istio-sidecar-injector-7d9845dbb7-r8nq5   1/1     Running   0          2m
    istio-telemetry-7695b4c4d4-tlvn8          2/2     Running   0          2m
    istio-tracing-55bbf55878-z4rd2            1/1     Running   0          2m
    kiali-77566cc66c-kh6lm                    1/1     Running   0          2m
    prometheus-5d5cb44877-lwrqx               1/1     Running   0          2m
    ```
    {: screen}

  - Komponenten von `istio-sample-bookinfo`: Stellen Sie sicher, dass die BookInfo-Microservices und die entsprechenden Pods bereitgestellt wurden.
    ```
    kubectl get svc -n default
    ```
    {: pre}

    ```
    NAME                      TYPE           CLUSTER-IP       EXTERNAL-IP    PORT(S)          AGE
    details                   ClusterIP      172.21.19.104    <none>         9080/TCP         2m
    productpage               ClusterIP      172.21.168.196   <none>         9080/TCP         2m
    ratings                   ClusterIP      172.21.11.131    <none>         9080/TCP         2m
    reviews                   ClusterIP      172.21.117.164   <none>         9080/TCP         2m
    ```
    {: screen}

    ```
    kubectl get pods -n default
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

### Verwaltete Istio-Add-ons in der Benutzerschnittstelle installieren
{: #istio_install_ui}

1. Klicken Sie in Ihrem [Cluster-Dashboard ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cloud.ibm.com/containers-kubernetes/clusters) auf den Namen einer Cluster-Version 1.10 oder höher.

2. Klicken Sie auf die Registerkarte **Add-ons**.

3. Klicken Sie auf der Istio-Karte auf die Option **Installieren**.

4. Das Kontrollkästchen **Istio** ist bereits ausgewählt. Wenn Sie außerdem die Add-ons 'Istio-Extras' und die Beispielapp 'BookInfo' installieren möchten, wählen Sie die Kontrollkästchen **Istio Extras** und **Istio Sample** aus.

5. Klicken Sie auf **Installieren**.

6. Überprüfen Sie auf der Istio-Karte, ob die Add-ons, die Sie aktiviert haben, aufgelistet werden.

Als Nächstes können Sie die Funktionen von Istio in der [Beispielapp 'BookInfo'](#istio_bookinfo) ausprobieren.

<br />


## Beispielapp 'BookInfo' ausprobieren
{: #istio_bookinfo}

Das BookInfo-Add-on (`istio-sample-bookinfo`) stellt die [Beispielanwendung 'BookInfo' für Istio ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://istio.io/docs/examples/bookinfo/) im Namensbereich `default` bereit. Diese Bereitstellung enthält das Basisdemo-Setup und die Standardzielregeln, sodass Sie die Funktionen von Istio sofort ausprobieren können.
{: shortdesc}

Die vier BookInfo-Microservices sind folgende:
* `productpage` ruft die Microservices `details` und `reviews` auf, um die Seite mit Daten zu füllen.
* `details` enthält Buchinformationen.
* `reviews` enthält Buchrezensionen und ruft den Microservice `ratings` auf.
* `ratings` enthält Informationen zur Bewertung eines Buchs, die eine Buchrezension begleiten.

Der Microservice `reviews` hat mehrere Versionen:
* `v1` ruft den Microservice `ratings` nicht auf.
* `v2` ruft den Microservice `ratings` auf und zeigt eine Bewertung in Form von 1 bis 5 schwarzen Sternen an.
* `v3` ruft den Microservice `ratings` auf und zeigt eine Bewertung in Form von 1 bis 5 roten Sternen an.

Die YAML-Bereitstellungsdateien für jeden dieser Microservices werden so geändert, dass Envoy-Sidecar-Proxys zuvor als Container in die Pods der Microservices eingefügt (Injektion) werden, bevor sie bereitgestellt werden. Weitere Informationen zur manuellen Sidecar-Injektion finden Sie in der [Istio-Dokumentation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://istio.io/docs/setup/kubernetes/sidecar-injection/). Die App 'BookInfo' wurde darüber hinaus bereits über eine öffentliche IP-Ingress-Adresse durch ein Istio-Gateway zugänglich gemacht. Beachten Sie, dass die App 'BookInfo' Ihnen zwar den Einstieg erleichtern kann, jedoch nicht für den Produktionseinsatz vorgesehen ist.

[Installieren Sie vor Beginn die verwalteten Add-ons `istio`, `istio-extras` und `istio-sample-bookinfo`](#istio_install) in einem Cluster.

1. Rufen Sie die öffentliche Adresse für Ihren Cluster ab.
  * Standardcluster:
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
      1. Legen Sie den Ingress-Host fest. Dieser Host ist die öffentliche IP-Adresse eines beliebigen Workerknotens in Ihrem Cluster.
        ```
        export INGRESS_HOST=$(kubectl get nodes -o jsonpath='{.items[0].status.addresses[?(@.type=="ExternalIP")].address}')
        ```
        {: pre}

      2. Legen Sie den Ingress-Port fest.
        ```
        export INGRESS_PORT=$(kubectl get svc istio-ingressgateway -n istio-system -o jsonpath='{.spec.ports[0].nodePort}')
        ```
        {: pre}

      3. Erstellen Sie die Umgebungsvariable GATEWAY_URL, die die öffentliche IP-Adresse des Workerknotens und einen Knotenport (NodePort) verwendet.
         ```
         export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT
         ```
         {: pre}

2. Führen Sie den Befehl 'curl' für die Variable `GATEWAY_URL` aus, um zu prüfen, ob die App BookInfo ausgeführt wird. Die Antwort `200` bedeutet, dass die App 'BookInfo' ordnungsgemäß mit Istio ausgeführt wird.
   ```
   curl -o /dev/null -s -w "%{http_code}\n" http://${GATEWAY_URL}/productpage
   ```
   {: pre}

3.  Zeigen Sie die BookInfo-Webseite in einem Browser an.

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

4. Versuchen Sie mehrfach, die Seite zu aktualisieren. Verschiedene Versionen des Abschnitts mit den Rezensionen zeigen abwechselnd rote, schwarze oder gar keine Sterne an.

### Erklärung der Vorgänge
{: #istio_bookinfo_understanding}

Das Beispiel 'BookInfo' demonstriert, wie drei der Datenverkehrsmanagementkomponenten von Istio zusammenarbeiten, um Ingress-Datenverkehr an die App zu leiten.
{: shortdesc}

<dl>
<dt>`Gateway`</dt>
<dd>Das [Gateway ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://istio.io/docs/reference/config/istio.networking.v1alpha3/#Gateway) `bookinfo-gateway` beschreibt eine Lastausgleichsfunktion, den Service `istio-ingressgateway` im Namensbereich `istio-system`, der als Ingress-Einstiegspunkt für HTTP/TCP-Datenverkehr für die BookInfo-App fungiert. Istio konfiguriert die Lastausgleichsfunktion so, dass sie für eingehende Anforderungen an Istio-verwaltete Apps über die Ports empfangsbereit ist, die in der Gateway-Konfigurationsdatei definiert sind.
</br></br>Führen Sie den folgenden Befehl aus, um die Konfigurationsdatei für das BookInfo-Gateway anzuzeigen.
<pre class="pre"><code>kubectl get gateway bookinfo-gateway -o yaml</code></pre></dd>

<dt>`VirtualService`</dt>
<dd>Der [`virtuelle Service (VirtualService)` ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://istio.io/docs/reference/config/istio.networking.v1alpha3/#VirtualService) `bookinfo` definiert die Regeln, die steuern, wie Anforderungen innerhalb des Servicenetzes weitergeleitet werden, indem Microservices als Ziele (`destinations`) definiert werden. In dem virtuellen Service `bookinfo` wird der URI `/productpage` einer Anforderung an den Host `productpage` an Port `9080` geleitet. Auf diese Weise werden alle Anforderungen an die BookInfo-App zuerst an den Microservice `productpage` geleitet, der wiederum die anderen Microservices von BookInfo aufruft.
</br></br>Führen Sie den folgenden Befehl aus, um die Regel des virtuellen Service anzuzeigen, die auf BookInfo angewendet wird.
<pre class="pre"><code>kubectl get virtualservice bookinfo -o yaml</code></pre></dd>

<dt>`DestinationRule`</dt>
<dd>Nachdem das Gateway die Anforderung entsprechend der Regel des virtuellen Service weitergeleitet hat, definieren die Zielregeln ([`DestinationRules` ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://istio.io/docs/reference/config/istio.networking.v1alpha3/#DestinationRule)) `details`, `productpage`, `ratings` und `reviews` Richtlinien, die auf die Anforderung angewendet werden, wenn sie einen Microservice erreicht. Wenn Sie zum Beispiel die Anzeige der BookInfo-Produktseite aktualisieren, sind die Änderungen, die angezeigt werden, das Ergebnis des Microservice `productpage`, der verschiedene Versionen (`v1`, `v2` und `v3`) des Microservice `reviews` zufällig auswählt. Die Versionen werden zufällig ausgewählt, weil die Zielregel `reviews` den Untergruppen (`subsets`) oder den benannten Versionen des Microservice gleiche Gewichtung zuordnet. Diese Untergruppen werden von den Regeln des virtuellen Service verwendet, wenn Datenverkehr an bestimmte Versionen des Service weitergeleitet wird.
</br></br>Führen Sie den folgenden Befehl aus, um die Zielregeln anzuzeigen, die auf BookInfo angewendet werden.
<pre class="pre"><code>kubectl describe destinationrules</code></pre></dd>
</dl>

</br>

Als Nächstes können Sie [BookInfo mithilfe der von IBM bereitgestellten Ingress-Unterdomäne zugänglich machen](#istio_expose_bookinfo) oder das Servicenetz für die BookInfo-App [protokollieren, überwachen, in einem Trace aufzeichnen und visualisieren](#istio_health).

<br />


## Istio on {{site.data.keyword.containerlong_notm}} protokollieren, überwachen, in Trace aufzeichnen und visualisieren
{: #istio_health}

Für das Protokollieren, Überwachen, Tracing und Visualisieren Ihrer Apps, die von Istio on {{site.data.keyword.containerlong_notm}} verwaltet werden, können Sie die Grafana-, Jaeger- und Kiali-Dashboards starten, die im Add-on `istio-extras` installiert wurden, oder LogDNA und Sysdig als Services anderer Anbieter auf Ihren Workerknoten bereitstellen.
{: shortdesc}

### Grafana-, Jaeger- und Kiali-Dashboards starten
{: #istio_health_extras}

Das Istio-Extras-Add-on (`istio-extras`) installiert [Grafana ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://grafana.com/), [Jaeger ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.jaegertracing.io/) und [Kiali ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.kiali.io/). Starten Sie die Dashboards für jeden dieser Services, um zusätzliche Überwachungs-, Trace- und Visualisierungsfunktionen für Istio verfügbar zu machen.
{: shortdesc}

[Installieren Sie vor Beginn die verwalteten Add-ons `istio` und `istio-extras`](#istio_install) in einem Cluster.

**Grafana**</br>
1. Starten Sie die Kubernetes-Portweiterleitung für das Grafana-Dashboard.
  ```
  kubectl -n istio-system port-forward $(kubectl -n istio-system get pod -l app=grafana -o jsonpath='{.items[0].metadata.name}') 3000:3000 &
  ```
  {: pre}

2. Zum Öffnen des Grafana-Dashboards für Istio rufen Sie die folgende URL auf: http://localhost:3000/dashboard/db/istio-mesh-dashboard. Wenn Sie das [BookInfo-Add-on](#istio_bookinfo) installiert haben, zeigt das Istio-Dashboard Metriken für den Datenverkehr an, den Sie generiert haben, als Sie die Produktseite einige Male aktualisiert haben. Weitere Informationen zur Verwendung des Grafana-Dashboards für Istio finden Sie im Abschnitt zum [Anzeigen des Istio-Dashboards ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://istio.io/docs/tasks/telemetry/using-istio-dashboard/) in der Open-Source-Dokumentation zu Istio.

**Jaeger**</br>
1. Starten Sie die Kubernetes-Portweiterleitung für das Jaeger-Dashboard.
  ```
  kubectl -n istio-system port-forward $(kubectl -n istio-system get pod -l app=jaeger -o jsonpath='{.items[0].metadata.name}') 16686:16686 &
  ```
  {: pre}

2. Zum Öffnen der Jaeger-Benutzerschnittstelle (UI) rufen Sie die folgende URL auf: http://localhost:16686.

3. Wenn Sie das [BookInfo-Add-on](#istio_bookinfo) installiert haben, können Sie `productpage` in der Liste **Service** auswählen und auf **Find Traces** klicken. Es werden Traces für den Datenverkehr angezeigt, den Sie generiert haben, als Sie die Produktseite einige Male aktualisiert haben. Weitere Informationen zur Verwendung von Jaeger mit Istio finden Sie im Abschnitt zur [Generierung von Traces mit dem BookInfo-Beispiel ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://istio.io/docs/tasks/telemetry/distributed-tracing/#generating-traces-using-the-bookinfo-sample) in der Open-Source-Dokumentation zu Istio.

**Kiali**</br>
1. Starten Sie die Kubernetes-Portweiterleitung für das Kiali-Dashboard.
  ```
  kubectl -n istio-system port-forward $(kubectl -n istio-system get pod -l app=kiali -o jsonpath='{.items[0].metadata.name}') 20001:20001 &
  ```
  {: pre}

2. Zum Öffnen der Kiali-Benutzerschnittstelle (UI) rufen Sie die folgende URL auf: http://localhost:20001.

3. Geben Sie `admin` als Benutzernamen und als Kennphrase ein. Weitere Informationen zur Verwendung von Kiali zum Visualisieren Ihrer durch Istio verwalteten Microservices finden Sie im Abschnitt zur [Generierung eines Servicediagramms ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://istio.io/docs/tasks/telemetry/kiali/#generating-a-service-graph) in der Open-Source-Dokumentation zu Istio.

### Protokollierung mit {{site.data.keyword.la_full_notm}} einrichten
{: #istio_health_logdna}

Sie können Protokolle für Ihren App-Container und den Envoy-Proxy-Sidecar-Container in jedem Pod nahtlos verwalten, wenn Sie LogDNA auf Ihren Workerknoten bereitstellen, um Protokolle an {{site.data.keyword.loganalysislong}} weiterzuleiten.
{: shortdesc}

Zur Verwendung von [{{site.data.keyword.la_full}}](/docs/services/Log-Analysis-with-LogDNA?topic=LogDNA-about) stellen Sie einen Protokollierungsagenten auf jedem Workerknoten in Ihrem Cluster bereit. Dieser Agent erfasst Protokolle Ihrer Pods aus allen Namensbereichen, einschließlich `kube-system`, mit der Erweiterung `*.log` und in erweiterungslosen Dateien, die im Verzeichnis `/var/log` gespeichert werden. Diese Protokolle umfassen Protokolle aus Ihrem App-Container und aus dem Envoy-Proxy-Sidecar-Container in jedem Pod. Anschließend leitet der Agent die Protokolle an den {{site.data.keyword.la_full_notm}}-Service weiter.

Richten Sie zunächst LogDNA für Ihren Cluster ein, indem Sie die Schritte ausführen, die im Abschnitt zur [Verwaltung von Kubernetes-Clusterprotokollen mit {{site.data.keyword.la_full_notm}}](/docs/services/Log-Analysis-with-LogDNA/tutorials?topic=LogDNA-kube#kube) beschrieben werden.




### Überwachung mit {{site.data.keyword.mon_full_notm}} einrichten
{: #istio_health_sysdig}

Sie können die Leistung und den Allgemeinzustand Ihrer Istio-verwalteten Apps genauer untersuchen, wenn Sie Sysdig auf Ihren Workerknoten bereitstellen, um Metriken an {{site.data.keyword.monitoringlong}} weiterzuleiten.
{: shortdesc}

Mit Istio on {{site.data.keyword.containerlong_notm}} wird Prometheus durch das verwaltete Add-on `istio` in Ihrem Cluster installiert. Die Pods `istio-mixer-telemetry` in Ihrem Cluster sind mit einem Prometheus-Endpunkt annotiert, sodass Prometheus alle Telemetriedatem für Ihre Pods aggregieren kann. Indem Sie einen Sysdig-Agenten auf jedem Workerknoten in Ihrem Cluster bereitstellen, wird Sysdig bereits automatisch aktiviert, um die Daten an diesen Prometheus-Endpunkten zu erkennen und zu erfassen und sie in Ihrem {{site.data.keyword.Bluemix_notm}}-Überwachungsdashboard darzustellen.

Da die gesamte Prometheus-Arbeit erledigt ist, brauchen Sie lediglich Sysdig in Ihrem Cluster bereitzustellen.

1. Richten Sie Sysdig ein, indem Sie die Schritte im Abschnitt zur [Analyse von Metriken für eine App, die in einem Kubernetes-Cluster bereitgestellt ist,](/docs/services/Monitoring-with-Sysdig/tutorials?topic=Sysdig-kubernetes_cluster#kubernetes_cluster) ausführen.

2. [Starten Sie die Sysdig-Benutzerschnittstelle ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](/docs/services/Monitoring-with-Sysdig/tutorials?topic=Sysdig-kubernetes_cluster#kubernetes_cluster_step3).

3. Klicken Sie auf **Add new dashboard** (Neues Dashboard hinzufügen).

4. Suchen Sie nach `Istio` und wählen Sie eines der vordefinierten Istio-Dashboards von Sysdig aus.

Weitere Informationen zum Referenzieren von Metriken und Dashboards, zur Überwachung von internen Istio-Komponenten sowie zur Überwachung von Istio-A/B-Bereitstellungen und Canary-Bereitstellungen finden Sie im Sysdig-Blogbeitrag [How to monitor Istio, the Kubernetes service mesh ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://sysdig.com/blog/monitor-istio/). Suchen Sie nach dem Abschnitt "Monitoring Istio: reference metrics and dashboards".

<br />


## Sidecar-Injektion für Ihre Apps einrichten
{: #istio_sidecar}

Sind Sie bereit, Ihre eigenen Apps mit Istio zu verwalten? Bevor Sie Ihre App bereitstellen, müssen Sie zunächst entscheiden, wie Sie die Envoy-Proxy-Sidecars in Ihre App-Pods einfügen wollen (Injektion).
{: shortdesc}

Jeder App-Pod muss einen Envoy-Proxy-Sidecar ausführen, sodass die Microservices in das Servicenetz eingeschlossen werden können. Sie können sicherstellen, dass Sidecars in jeden App-Pod automatisch oder manuell eingefügt werden. Weitere Informationen zur Sidecar-Injektion finden Sie in der [Istio-Dokumentation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://istio.io/docs/setup/kubernetes/sidecar-injection/).

### Automatische Sidecar-Injektion aktivieren
{: #istio_sidecar_automatic}

Wenn die automatische Sidecar-Injektion aktiviert ist, ist ein Namensbereich für alle neuen Bereitstellungen empfangsbereit und ändert die YAML-Definitionen der Bereitstellungen automatisch, um Sidecars hinzuzufügen. Aktivieren Sie die automatische Sidecar-Injektion für einen Namensbereich, wenn Sie planen, mehrere Apps bereitzustellen, die Sie mit Istio in diesen Namensbereich integrieren wollen. Beachten Sie, dass die automatische Sidecar-Injektion standardmäßig für keinen der Namensbereiche in dem verwalteten Istio-Add-on aktiviert ist.

Gehen Sie wie folgt vor, um die automatische Sidecar-Injektion für einen Namensbereich zu aktivieren:

1. Rufen Sie den Namen der Namensbereiche ab, in denen Sie Istio-verwaltete Apps bereitstellen wollen.
  ```
  kubectl get namespaces
  ```
  {: pre}

2. Versehen Sie den Namensbereich mit der Bezeichnung (Label) `istio-injection=enabled`.
  ```
  kubectl label namespace <namensbereich> istio-injection=enabled
  ```
  {: pre}

3. Stellen Sie Apps in dem Namensbereich mit der Bezeichnung bereit oder stellen Sie Apps, die sich bereits in dem Namensbereich befinden, erneut bereit.
  * Gehen Sie wie folgt vor, um eine App in dem Namensbereich mit der Bezeichnung bereitzustellen:
    ```
    kubectl apply <meine_app>.yaml --namespace <namensbereich>
    ```
    {: pre}
  * Zur erneuten Bereitstellung einer App, die bereits in diesem Namensbereich bereitgestellt ist, löschen Sie den App-Pod, sodass er mit dem eingefügten Sidecar erneut bereitgestellt wird.
    ```
    kubectl delete pod -l app=<meine_app>
    ```
    {: pre}

5. Wenn Sie keinen Service erstellt haben, um Ihre App zugänglich zu machen, erstellen Sie einen Kubernetes-Service. Ihre App muss durch einen Kubernetes-Service zugänglich gemacht werden, damit er als Microservice in das Istio-Servicenetz eingeschlossen werden kann. Stellen Sie sicher, dass Sie die [Istio-Voraussetzungen für Pods und Services ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://istio.io/docs/setup/kubernetes/spec-requirements/) erfüllen.

  1. Definieren Sie einen Service für die App.
    ```
    apiVersion: v1
    kind: Service
    metadata:
      name: myappservice
    spec:
      selector:
        <selektorschlüssel>: <selektorwert>
      ports:
       - protocol: TCP
         port: 8080
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der YAML-Dateikomponenten für den Service</th>
    </thead>
    <tbody>
    <tr>
    <td><code>selector</code></td>
    <td>Geben Sie das Paar aus Bezeichnungsschlüssel (<em>&lt;selektorschlüssel&gt;</em>) und Wert (<em>&lt;selektorwert&gt;</em>) ein, das Sie für die Zielausrichtung auf die Pods, in denen Ihre App ausgeführt wird, verwenden möchten.</td>
     </tr>
     <tr>
     <td><code>port</code></td>
     <td>Der Port, den der Service überwacht.</td>
     </tr>
     </tbody></table>

  2. Erstellen Sie den Service in Ihrem Cluster. Stellen Sie sicher, dass der Service in demselben Namensbereich wie die App bereitgestellt wird.
    ```
    kubectl apply -f myappservice.yaml -n <namensbereich>
    ```
    {: pre}

Die App-Pods sind jetzt in Ihr Istio-Servicenetz integriert, da der Istio-Sidecar-Container parallel zu Ihrem App-Container ausgeführt wird.

### Sidecars manuell einfügen
{: #istio_sidecar_manual}

Wenn Sie die automatische Sidecar-Injektion für einen Namensbereich nicht aktivieren möchten, können Sie den Sidecar manuell in die YAML-Definition einer Bereitstellung einfügen. Fügen Sie Sidecars manuell ein, wenn Apps in einem Namensbereich parallel zu anderen Bereitstellungen ausgeführt werden, in die keine Sidecars automatisch eingefügt werden sollen.

Gehen Sie wie folgt vor, um Sidecars manuell in eine Bereitstellung einzufügen:

1. Laden Sie den `istioctl`-Client herunter.
  ```
  curl -L https://git.io/getLatestIstio | sh -
  ```

2. Navigieren Sie zum Istio-Paketverzeichnis.
  ```
  cd istio-1.0.6
  ```
  {: pre}

3. Fügen Sie den Envoy-Sidecar durch Injektion in die YAML-Definition Ihrer App-Bereitstellung ein.
  ```
  istioctl kube-inject -f <meine_app>.yaml | kubectl apply -f -
  ```
  {: pre}

4. Stellen Sie Ihre App bereit.
  ```
  kubectl apply <meine_app>.yaml
  ```
  {: pre}

5. Wenn Sie keinen Service erstellt haben, um Ihre App zugänglich zu machen, erstellen Sie einen Kubernetes-Service. Ihre App muss durch einen Kubernetes-Service zugänglich gemacht werden, damit er als Microservice in das Istio-Servicenetz eingeschlossen werden kann. Stellen Sie sicher, dass Sie die [Istio-Voraussetzungen für Pods und Services ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://istio.io/docs/setup/kubernetes/spec-requirements/) erfüllen.

  1. Definieren Sie einen Service für die App.
    ```
    apiVersion: v1
    kind: Service
    metadata:
      name: myappservice
    spec:
      selector:
        <selektorschlüssel>: <selektorwert>
      ports:
       - protocol: TCP
         port: 8080
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der YAML-Dateikomponenten für den Service</th>
    </thead>
    <tbody>
    <tr>
    <td><code>selector</code></td>
    <td>Geben Sie das Paar aus Bezeichnungsschlüssel (<em>&lt;selektorschlüssel&gt;</em>) und Wert (<em>&lt;selektorwert&gt;</em>) ein, das Sie für die Zielausrichtung auf die Pods, in denen Ihre App ausgeführt wird, verwenden möchten.</td>
     </tr>
     <tr>
     <td><code>port</code></td>
     <td>Der Port, den der Service überwacht.</td>
     </tr>
     </tbody></table>

  2. Erstellen Sie den Service in Ihrem Cluster. Stellen Sie sicher, dass der Service in demselben Namensbereich wie die App bereitgestellt wird.
    ```
    kubectl apply -f myappservice.yaml -n <namensbereich>
    ```
    {: pre}

Die App-Pods sind jetzt in Ihr Istio-Servicenetz integriert, da der Istio-Sidecar-Container parallel zu Ihrem App-Container ausgeführt wird.

<br />


## Istio-verwaltete Apps über die von IBM bereitgestellte Ingress-Unterdomäne zugänglich machen
{: #istio_expose}

Nachdem Sie die [Envoy-Proxy-Sidecar-Injektion eingerichtet](#istio_sidecar) und Ihre Apps im Istio-Servicenetz bereitgestellt haben, können Sie Ihre Istio-verwalteten Apps für öffentliche Anforderungen über die von IBM bereitgestellte Ingress-Unterdomäne zugänglich machen.
{: shortdesc}

Die {{site.data.keyword.containerlong_notm}}-Lastausgleichsfunktion für Anwendungen (ALB) verwendet die Kubernetes-Ingress-Ressourcen zur Steuerung, wie Datenverkehr an Ihre Apps weitergeleitet wird. Allerdings verwendet Istio [Gateways ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://istio.io/docs/reference/config/istio.networking.v1alpha3/#Gateway) und [virtuelle Services (VirtualServices) ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://istio.io/docs/reference/config/istio.networking.v1alpha3/#VirtualService), um zu steuern, wie Datenverkehr an Ihre Apps weitergeleitet wird. Ein Gateway konfiguriert eine Lastausgleichsfunktion, die als Einstiegspunkt für Ihre Istio-verwalteten Apps fungiert. Virtuelle Services definieren Routing-Regeln, durch die der Datenverkehr ordnungsgemäß an Ihre App-Microservices weitergeleitet wird.

In Standardclustern wird eine von IBM bereitgestellte Ingress-Unterdomäne automatisch Ihrem Cluster zugeordnet, sodass Sie Ihre Apps öffentlich zugänglich machen können. Sie können den DNS-Eintrag für diese Unterdomäne verwenden, um Ihre Istio-verwalteten Apps zugänglich zu machen, indem Sie die {{site.data.keyword.containerlong_notm}}-Standard-ALB mit dem Istio-Ingress-Gateway verbinden.

Sie können zuerst das [Beispiel für das Zugänglichmachen von BookInfo über die von IBM bereitgestellte Ingress-Unterdomäne](#istio_expose_bookinfo) ausprobieren oder [Ihre eigenen Istio-verwalteten Apps öffentlich zugänglich machen, indem Sie das Istio-Gateway und die Ingress-ALB verbinden](#istio_expose_link).

### Beispiel: BookInfo über die von IBM bereitgestellte Ingress-Unterdomäne zugänglich machen
{: #istio_expose_bookinfo}

Wenn Sie das [BookInfo-Add-on](#istio_bookinfo) in Ihrem Cluster aktivieren, wird das Istio-Gateway `bookinfo-gateway` für Sie erstellt. Das Gateway verwendet den virtuellen Istio-Service und Zielrichtlinien, um eine Lastausgleichsfunktion mit dem Namen `istio-ingressgateway` zu konfigurieren, die die BookInfo-App öffentlich zugänglich macht. In den folgenden Schritten erstellen Sie eine Kubernetes-Ingress-Ressource, die eingehende Anforderungen an die {{site.data.keyword.containerlong_notm}}-Ingress-ALB an die Lastausgleichsfunktion `istio-ingressgateway` weiterleitet.
{: shortdesc}

[Aktivieren Sie vor Beginn die verwalteten Add-ons `istio` und `istio-sample-bookinfo`](#istio_install) in einem Cluster.

1. Rufen Sie die von IBM bereitgestellte Ingress-Unterdomäne für Ihren Cluster ab. Wenn Sie TLS verwenden möchten, notieren Sie auch den von IBM bereitgestellten geheimen Ingress-TLS-Schlüssel (Secret) in der Ausgabe.
  ```
  ibmcloud ks cluster-get --cluster <clustername_oder_-id> | grep Ingress
  ```
  {: pre}

  Beispielausgabe:
  ```
  Ingress Subdomain:      mycluster-12345.us-south.containers.appdomain.cloud
  Ingress Secret:         mycluster-12345
  ```
  {: screen}

2. Erstellen Sie eine Ingress-Ressource. Die {{site.data.keyword.containerlong_notm}}-ALB verwendet die Regeln, die in dieser Ressource definiert werden werden, um Datenverkehr an die Istio-Lastausgleichsfunktion weiterzuleiten, die Ihre Istio-verwaltete App zugänglich macht.
  ```
  apiVersion: extensions/v1beta1
  kind: Ingress
  metadata:
    name: myingressresource
    namespace: istio-system
  spec:
    tls:
    - hosts:
      - bookinfo.<ibm-ingress-domäne>
      secretName: <name_des_geheimen_tls-schlüssels>
    rules:
    - host: bookinfo.<ibm-ingress-domäne>
      http:
        paths:
        - path: /
          backend:
            serviceName: istio-ingressgateway
            servicePort: 80
  ```
  {: codeblock}

  <table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der YAML-Dateikomponenten</th>
  </thead>
  <tbody>
  <tr>
  <td><code>tls.hosts</code></td>
  <td>Zur Verwendung von TLS ersetzen Sie <em>&lt;ibm-ingress-domäne&gt;</em> durch die von IBM bereitgestellte Ingress-Unterdomäne. Beachten Sie, dass `bookinfo` Ihrer von IBM bereitgestellten Unterdomäne vorangestellt wird. Der Platzhalter für die von IBM bereitgestellte Ingress-Unterdomäne <code>*.&lt;clustername&gt;.&lt;region&gt;.containers.appdomain.cloud</code> wird standardmäßig für Ihren Cluster registriert.</td>
  </tr>
  <tr>
  <td><code>tls.secretName</code></td>
  <td>Ersetzen Sie <em>&lt;name_des_geheimen_tls-schlüssels&gt;</em> durch den Namen des von IBM bereitgestellten geheimen Ingress-Schlüssels. Das von IBM bereitgestellte TLS-Zertifikat ist ein Platzhalterzertifikat und kann für die Platzhalterunterdomäne verwendet werden.<td>
  </tr>
  <tr>
  <td><code>host</code></td>
  <td>Ersetzen Sie <em>&lt;ibm-ingress-domäne&gt;</em> durch die von IBM bereitgestellte Ingress-Unterdomäne. Beachten Sie, dass `bookinfo` Ihrer von IBM bereitgestellten Unterdomäne vorangestellt wird.</td>
  </tr>
  <tr>
  <td><code>serviceName</code></td>
  <td>Beachten Sie, dass der Servicename das Istio-Ingress-Gateway (<code>istio-ingressgateway</code>) ist, sodass die ALB Anforderungen aus dieser Unterdomäne an den Service der Istio-Lastausgleichsfunktion weiterleitet.</td>
  </tr>
  </tbody></table>

3. Erstellen Sie die Istio-Ressource.
  ```
  kubectl apply -f myingressresource.yaml -n istio-system
  ```
  {: pre}

4. Öffnen Sie die BookInfo-Produktseite in einem Web-Browser.
  - Wenn Sie TLS aktiviert haben:
    ```
    https://bookinfo.<ibm-ingress-domäne>/productpage
    ```
    {: codeblock}
  - Wenn Sie TLS nicht aktiviert haben:
    ```
    http://bookinfo.<ibm-ingress-domäne>/productpage
    ```
    {: codeblock}

5. Versuchen Sie mehrfach, die Seite zu aktualisieren. Die Anforderungen an `http://bookinfo.<IBM-domain>/productpage` werden von der ALB empfangen und an die Lastausgleichsfunktion des Istio-Gateways weitergeleitet. Die verschiedenen Versionen des Microservice `reviews` werden weiterhin zufällig zurückgegeben, weil das Istio-Gateway den virtuellen Service und die Ziel-Routing-Regeln für Microservices verwaltet.

Weitere Informationen zu dem Gateway, zu den Regeln des virtuellen Service und zu den Zielregeln für die BookInfo-App finden Sie unter [Erklärung der Vorgänge](#istio_bookinfo_understanding).

### Eigene Istio-verwaltete Apps durch Verbinden des Istio-Gateways und der Ingress-ALB zugänglich machen
{: #istio_expose_link}

Verwenden Sie die von IBM bereitgestellte Ingress-Unterdomäne für Ihre Istio-verwalteten Apps, indem Sie das Istio-Gateway und die {{site.data.keyword.containerlong_notm}}-ALB verbinden. Die folgenden Schritte zeigen, wie ein Istio-Gateway eingerichtet, ein virtueller Service, der die Datenverkehrsmanagementregeln für Ihre Istio-verwalteten Services definiert, erstellt und die {{site.data.keyword.containerlong_notm}}-Ingress-ALB konfiguriert werden, sodass sie Datenverkehr aus Ihrer von IBM bereitgestellten Unterdomäne an die Lastausgleichsfunktion `istio-ingressgateway` weiterleitet.
{: shortdesc}

Vorbereitende Schritte:
1. [Installieren Sie das verwaltete Add-on `istio`](#istio_install) in einem Cluster.
2. Installieren Sie den `istioctl`-Client.
  1. Laden Sie `istioctl` herunter.
    ```
    curl -L https://git.io/getLatestIstio | sh -
    ```
  2. Navigieren Sie zum Istio-Paketverzeichnis.
    ```
    cd istio-1.0.6
    ```
    {: pre}
3. [Richten Sie die Sidecar-Injektion für Ihre App-Microservices ein, stellen Sie die Microservices in einem Namensbereich bereit und erstellen Sie Kubernetes-Services für die App-Microservices, sodass diese in das Istio-Servicenetz eingeschlossen werden können](#istio_sidecar).

Gehen Sie wie folgt vor, um das Istio-Gateway und die {{site.data.keyword.containerlong_notm}}-ALB zu verbinden:

1. Erstellen Sie ein Gateway. In diesem Beispielgateway wird der Lastausgleichsservice `istio-ingressgateway` verwendet, um den Port 80 für HTTP zugänglich zu machen. Ersetzen Sie `<namensbereich>` durch den Namensbereich, in dem Ihre Istio-verwalteten Microservices bereitgestellt wurden. Wenn Ihre Microservices an einem anderen Port als `80` empfangsbereit sind, fügen Sie diesen Port hinzu. Weitere Informationen zu YAML-Komponenten für Gateways finden Sie in der [Istio-Referenzliteratur ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://istio.io/docs/reference/config/istio.networking.v1alpha3/#Gateway).
  ```
  apiVersion: networking.istio.io/v1alpha3
  kind: Gateway
  metadata:
    name: my-gateway
    namespace: <namensbereich>
  spec:
    selector:
      istio: ingressgateway
    servers:
    - port:
        name: http
        number: 80
        protocol: HTTP
      hosts:
      - '*'
  ```
  {: codeblock}

2. Wenden Sie das Gateway in dem Namensbereich an, in dem Ihre Istio-verwalteten Microservices bereitgestellt wurden.
  ```
  kubectl apply -f my-gateway.yaml -n <namensbereich>
  ```
  {: pre}

3. Erstellen Sie einen virtuellen Service, der das Gateway `my-gateway` verwendet und die Routing-Regeln für Ihre App-Microservices definiert. Weitere Informationen zu YAML-Komponenten für virtuelle Services finden Sie in der [Istio-Referenzliteratur ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://istio.io/docs/reference/config/istio.networking.v1alpha3/#VirtualService).

  Wenn Sie Ihren Microservice bereits mithilfe der {{site.data.keyword.containerlong_notm}}-ALB bereitgestellt haben, stellt Istio ein Konvertierungstool im `istioctl`-Client bereit, dass Ihnen helfen kann, Ingress-Ressourcendefinitionen auf die entsprechenden virtuellen Services zu migrieren. Das Konvertierungstool von [`istioctl` ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://istio.io/docs/reference/commands/istioctl/#istioctl-experimental-convert-ingress) konvertiert Ingress-Ressourcen bestmöglich in virtuelle Services. Beachten Sie, dass Ingress-Annotationen nicht konvertiert werden, weil das Istio-Gateway keine Ingress-Annotationen verwendet. Die Ausgabe zeigt nur einen Ausgangspunkt für Ihre Istio-Ingress-Konfiguration und erfordert wahrscheinlich einige Änderungen. Zur Verwendung des Tools führen Sie den folgenden Befehl aus: `istioctl experimental convert-ingress -f <vorhandene_ingress-ressource>.yaml > my-virtual-service.yaml`
  {: tip}

  ```
  apiVersion: networking.istio.io/v1alpha3
  kind: VirtualService
  metadata:
    name: my-virtual-service
    namespace: <namensbereich>
  spec:
    gateways:
    - my-gateway
    hosts:
    - '*'
    http:
    - match:
      - uri:
          exact: /<servicepfad>
      route:
      - destination:
          host: <servicename>
          port:
            number: 80
  ```
  {: codeblock}

  <table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der YAML-Dateikomponenten</th>
  </thead>
  <tbody>
  <tr>
  <td><code>namespace</code></td>
  <td>Ersetzen Sie <em>&lt;namensbereich&gt;</em> durch den Namensbereich, in dem Ihre Istio-verwalteten Microservices bereitgestellt wurden.</td>
  </tr>
  <tr>
  <td><code>gateways</code></td>
  <td>Beachten Sie, dass <code>my-gateway</code> angegeben wird, sodass das Gateway diese Routing-Regeln des virtuellen Service auf die Istio-Lastausgleichsfunktion anwenden kann.<td>
  </tr>
  <tr>
  <td><code>http.match.uri.exact</code></td>
  <td>Ersetzen Sie <em>&lt;servicepfad&gt;</em> durch den Pfad, über den Ihr Einstiegspunktmicroservice empfangsbereit ist. Beispiel: In der BookInfo-App wird dieser Pfad mit dem Wert <code>/productpage</code> definiert.</td>
  </tr>
  <tr>
  <td><code>http.route.destination.host</code></td>
  <td>Ersetzen Sie <em>&lt;servicename&gt;</em> durch den Namen Ihres Einstiegspunktmicroservice. Beispiel: In der BookInfo-App diente <code>productpage</code> als Einstiegspunktmicroservice, der die anderen App-Microservices aufrief.</td>
  </tr>
  <tr>
  <td><code>http.route.destination.port.number</code></td>
  <td>Wenn Ihr Microservice an einem anderen Port empfangsbereit ist, ersetzen Sie den Wert <em>&lt;80&gt;</em> durch die entsprechende Portnummer.</td>
  </tr>
  </tbody></table>

4. Wenden Sie die Regeln des virtuellen Service in dem Namensbereich an, in dem Ihr Istio-verwalteter Microservice bereitgestellt wurde.
  ```
  kubectl apply -f my-virtual-service.yaml -n <namensbereich>
  ```
  {: pre}

5. Optional: Zum Erstellen von Regeln, die angewendet werden, nachdem Datenverkehr an die einzelnen Microservices weitergeleitet wurde, wie zum Beispiel Regeln zum Senden von Datenverkehr an andere Versionen des einen Microservice, können Sie [`Zielregeln (DestinationRules)` ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://istio.io/docs/reference/config/istio.networking.v1alpha3/#DestinationRule) erstellen und anwenden.

6. Erstellen Sie eine Ingress-Ressourcendatei. Die {{site.data.keyword.containerlong_notm}}-ALB verwendet die in dieser Beispielressource definierten Regeln, um Datenverkehr an die Istio-Lastausgleichsfunktion weiterzuleiten, die Ihren Istio-verwalteten Microservice zugänglich macht.
  ```
  apiVersion: extensions/v1beta1
  kind: Ingress
  metadata:
    name: my-ingress-resource
    namespace: istio-system
  spec:
    rules:
    - host: <unterdomäne>.<ibm-ingress-domäne>
      http:
        paths:
        - path: /
          backend:
            serviceName: istio-ingressgateway
            servicePort: 80
  ```
  {: codeblock}

  <table>
  <thead>
  <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der YAML-Dateikomponenten</th>
  </thead>
  <tbody>
  <tr>
  <td><code>host</code></td>
  <td>Ersetzen Sie <em>&lt;unterdomäne&gt;</em> durch eine Unterdomäne für Ihre App und <em>&lt;ibm-ingress-domäne&gt;</em> durch die von IBM bereitgestellte Ingress-Unterdomäne. Sie können die von IBM bereitgestellte Ingress-Unterdomäne für Ihren Cluster mithilfe des Befehls <code>ibmcloud ks cluster-get --cluster &lt;clustername_oder_-id&gt;</code> ermitteln. Ihre ausgewählte Unterdomäne ist automatisch registriert, weil der Platzhalter für die von IBM bereitgestellte Ingress-Unterdomäne <code>*.&lt;clustername&gt;.&lt;region&gt;.containers.appdomain.cloud</code> standardmäßig für Ihren Cluster registriert wird.</td>
  </tr>
  <tr>
  <td><code>serviceName</code></td>
  <td>Beachten Sie, dass <code>istio-ingressgateway</code> angegeben wird, sodass die ALB eingehende Anforderungen an den Istio-Lastausgleichsservice weiterleitet.</td>
  </tr>
  </tbody></table>

7. Wenden Sie die Ingress-Ressource in dem Namensbereich an, in dem Ihre Istio-verwalteten Microservices bereitgestellt wurden.
  ```
  kubectl apply -f my-ingress-resource.yaml -n <namensbereich>
  ```
  {: pre}

8. Überprüfen Sie in einem Web-Browser, ob der Datenverkehr an Ihre Istio-verwalteten Microservices weitergeleitet wird, indem Sie die URL für den App-Microservice eingeben, auf den zugegriffen werden soll.
  ```
  http://<unterdomäne>.<ibm-ingress-domäne>/<servicepfad>
  ```
  {: codeblock}

<br />


## Istio on {{site.data.keyword.containerlong_notm}} deinstallieren
{: #istio_uninstall}

Wenn Sie Ihre Arbeit mit Istio beendet haben, können Sie die Istio-Ressourcen in Ihrem Cluster bereinigen, indem Sie Istio-Add-ons deinstallieren.
{:shortdesc}

Beachten Sie, dass das Add-on `istio` eine Abhängigkeit für die Add-ons `istio-extras`, `istio-sample-bookinfo` und [`knative`](/docs/containers?topic=containers-knative_tutorial) ist. Das Add-on `istio-extras` ist eine Abhängigkeit für das Add-on `istio-sample-bookinfo`.

### Verwaltete Istio-Add-ons in der CLI deinstallieren
{: #istio_uninstall_cli}

1. Inaktivieren Sie das Add-on `istio-sample-bookinfo`.
  ```
  ibmcloud ks cluster-addon-disable istio-sample-bookinfo --cluster <clustername_oder_-id>
  ```
  {: pre}

2. Inaktivieren Sie das Add-on `istio-extras`.
  ```
  ibmcloud ks cluster-addon-disable istio-extras --cluster <clustername_oder_-id>
  ```
  {: pre}

3. Inaktivieren Sie das Add-on `istio`.
  ```
  ibmcloud ks cluster-addon-disable istio --cluster <clustername_oder_-id> -f
  ```
  {: pre}

4. Überprüfen Sie, ob alle verwalteten Istio-Add-ons in diesem Cluster inaktiviert wurden. In der Ausgabe werden keine Istio-Add-ons zurückgegeben.
  ```
  ibmcloud ks cluster-addons --cluster <clustername_oder_-id>
  ```
  {: pre}

### Verwaltete Istio-Add-ons in der Benutzerschnittstelle deinstallieren
{: #istio_uninstall_ui}

1. Klicken Sie in Ihrem [Cluster-Dashboard ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cloud.ibm.com/containers-kubernetes/clusters) auf den Namen einer Cluster-Version 1.10 oder höher.

2. Klicken Sie auf die Registerkarte **Add-ons**.

3. Klicken Sie auf der Istio-Karte auf das Menüsymbol.

4. Deinstallieren Sie einzelne oder alle Istio-Add-ons.
  - Einzelne Istio-Add-ons:
    1. Klicken Sie auf **Aktualisieren**.
    2. Wählen Sie die Kontrollkästchen für die Add-ons ab, die Sie inaktivieren wollen. Wenn Sie ein Add-on bereinigen, werden andere Add-ons, die das betreffende Add-on als Abhängigkeit erfordern, möglicherweise automatisch bereinigt.
    3. Klicken Sie auf **Aktualisieren**. Die Istio-Add-ons werden inaktiviert und die Ressourcen für diese Add-ons werden aus diesem Cluster entfernt.
  - Alle Istio-Add-ons:
    1. Klicken Sie auf **Deinstallieren**. Alle verwalteten Istio-Add-ons werden in diesem Cluster inaktiviert und alle Istio-Ressourcen in diesem Cluster werden entfernt.

5. Überprüfen Sie auf der Istio-Karte, ob die Add-ons, die Sie deinstalliert haben, noch aufgelistet werden.

<br />


### Andere Istio-Installationen im Cluster deinstallieren
{: #istio_uninstall_other}

Wenn Sie Istio zuvor mit dem IBM Helm-Diagramm oder durch eine andere Methode im Cluster installiert haben, bereinigen Sie diese Istio-Installation, bevor Sie die verwalteten Istio-Add-ons im Cluster aktivieren. Zum Prüfen, ob sich Istio bereits in einem Cluster befindet, führen Sie den Befehl `kubectl get namespaces` aus und suchen Sie in der Ausgabe nach dem Namensbereich `istio-system`.
{: shortdesc}

- Wenn Istio mit dem {{site.data.keyword.Bluemix_notm}}-Helm-Diagramm für Istio installiert wurde:
  1. Deinstallieren Sie die Istio-Helm-Bereitstellung.
    ```
    helm del istio --purge
    ```
    {: pre}

  2. Wenn Helm 2.9 oder früher verwendet wurde, löschen Sie die zusätzliche Jobressource.
    ```
    kubectl -n istio-system delete job --all
    ```
    {: pre}

- Wenn Sie Istio manuell oder mithilfe des Istio-Helm-Diagramms der Community installiert haben, lesen Sie die Informationen in der [Istio-Dokumentation zur Deinstallation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://istio.io/docs/setup/kubernetes/quick-start/#uninstall-istio-core-components).
* Wenn Sie BookInfo zuvor im Cluster installiert haben, bereinigen Sie diese Ressourcen.
  1. Wechseln Sie in das Verzeichnis der Istio-Dateiposition.
    ```
    cd <dateipfad>/istio-1.0.5
    ```
    {: pre}

  2. Löschen Sie alle BookInfo-Services, -Pods und -Bereitstellungen im Cluster.
    ```
    samples/bookinfo/platform/kube/cleanup.sh
    ```
    {: pre}

## Womit möchten Sie fortfahren?
{: #istio_next}

* Weitere Anleitungen zur Verwendung von Istio finden Sie in der [Istio-Dokumentation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://istio.io/).
    * [Intelligentes Routing ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://istio.io/docs/guides/intelligent-routing.html): In diesem Beispiel wird die Verwendung der verschiedenen Funktionen zur Verwaltung des Datenverkehrs in Istio aufgezeigt, um in BookInfo Datenverkehr an eine bestimmte Version der Microservices für Rezensionen und Bewertungen weiterzuleiten.
    * [Intelligentes Routing ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://istio.io/docs/guides/telemetry.html): In diesem Beispiel wird die Verwendung der verschiedenen Funktionen zur Verwaltung des Datenverkehrs in Istio aufgezeigt, um in BookInfo Datenverkehr an eine bestimmte Version der Microservices für Rezensionen und Bewertungen weiterzuleiten.
* Belegen Sie die [Kognitive Klasse: Einführung in Microservices mit Istio und IBM Cloud Kubernetes-Service ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://cognitiveclass.ai/courses/get-started-with-microservices-istio-and-ibm-cloud-container-service/). **Hinweis**: Sie können den Abschnitt zur Istio-Installation in diesem Kurs überspringen.
* Sehen Sie sich diesen Blogbeitrag zur Verwendung von [Istio ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://itnext.io/vistio-visualize-your-istio-mesh-using-netflixs-vizceral-b075c402e18e) zur Visualisierung Ihres Istio-Servicenetzes an.
