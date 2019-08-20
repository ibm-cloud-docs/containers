---

copyright:
  years: 2014, 2019
lastupdated: "2019-07-31"

keywords: kubernetes, iks, nginx, ingress controller

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



# Ingress-Standardverhalten ändern
{: #ingress-settings}

Nachdem Sie Ihre Apps durch das Erstellen einer Ingress-Ressource zugänglich gemacht haben, können Sie die Ingress-ALBs in Ihrem Cluster weiter konfigurieren, indem Sie die folgenden Optionen festlegen.
{: shortdesc}

## Ports für die Ingress-ALB öffnen
{: #opening_ingress_ports}

Standardmäßig sind nur die Ports 80 und 443 für die Ingress-ALB (Lastausgleichsfunktion für Anwendungen) zugänglich. Um weitere Ports zugänglich zu machen, können Sie die Konfigurationszuordnungsressource `ibm-cloud-provider-ingress-cm` bearbeiten.
{: shortdesc}

1. Bearbeiten Sie die Konfigurationsdatei für die Konfigurationszuordnungsressource (Configmap) `ibm-cloud-provider-ingress-cm`.
    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Fügen Sie den Abschnitt <code>data</code> hinzu und geben Sie die öffentlichen Ports `80`, `443` und allen weiteren Ports, die Sie öffentlich zugänglich machen möchten, durch Semikolons getrennt an.

    Standardmäßig sind Port 80 und 443 geöffnet. Wenn Port 80 und 443 geöffnet bleiben sollen, müssen Sie sie neben allen anderen TCP-Ports einschließen, die Sie im Feld `public-ports` angegeben haben. Ein Port, der nicht angegeben wird, wird geschlossen. Wenn Sie eine private Lastausgleichsfunktion für Anwendungen aktiviert haben, müssen Sie auch alle Ports im Feld `private-ports` angeben, die geöffnet bleiben sollen.
    {: important}

    ```
    apiVersion: v1
    data:
      public-ports: "80;443;<port3>"
      private-ports: "80;443;<port4>"
    kind: ConfigMap
    metadata:
      name: ibm-cloud-provider-ingress-cm
      namespace: kube-system
    ```
    {: codeblock}

    Beispielausgabe, mit der die Ports `80`, `443` und `9443` offen gehalten werden:
    ```
    apiVersion: v1
 data:
   public-ports: "80;443;9443"
 kind: ConfigMap
 metadata:
   name: ibm-cloud-provider-ingress-cm
   namespace: kube-system
    ```
    {: screen}

3. Speichern Sie die Konfigurationsdatei.

4. Stellen Sie sicher, dass die Änderungen an der Konfigurationszuordnung angewendet wurden.
  ```
  kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
  ```
  {: pre}

5. Optional:
  * Zugriff auf eine App über einen nicht standardmäßigen TCP-Port, den Sie mit der Annotation [`tcp-ports`](/docs/containers?topic=containers-ingress_annotation#tcp-ports) geöffnet haben.
  * Änderung der Standardports für den HTTP-Netzverkehr (Port 80) und den HTTPS-Netzverkehr (Port 443) in einen Port, den Sie mit der Annotation [`custom-port`](/docs/containers?topic=containers-ingress_annotation#custom-port) geöffnet haben.

Weitere Informationen zu Konfigurationszuordnungsressourcen (Configmaps) finden Sie in der [Kubernetes-Dokumentation ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/).

<br />


## Quellen-IP-Adresse beibehalten
{: #preserve_source_ip}

Standardmäßig wird die Quellen-IP-Adresse der Clientanforderung nicht beibehalten. Wenn eine Clientanforderung für Ihre App an Ihren Cluster gesendet wird, wird die Anforderung an einen Pod für den LoadBalancer-Service weitergeleitet, der die ALB zugänglich macht. Wenn ein App-Pod nicht auf demselben Workerknoten vorhanden ist wie der Lastausgleichsfunktions-Pod, leitet die Lastausgleichsfunktion die Anforderung an einen App-Pod auf einem anderen Workerknoten weiter. Die Quellen-IP-Adresse des Pakets wird in die öffentliche IP-Adresse des Workerknotens geändert, auf dem der App-Pod ausgeführt wird.
{: shortdesc}

Um die ursprüngliche Quellen-IP-Adresse der Clientanforderung beizubehalten, können Sie [das Beibehalten der Quellen-IP aktivieren ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://kubernetes.io/docs/tutorials/services/source-ip/#source-ip-for-services-with-typeloadbalancer). Das Beibehalten der IP des Clients ist nützlich, z. B. wenn App-Server Sicherheits- und Zugriffssteuerungsrichtlinien genügen müssen.

Wenn Sie [eine ALB inaktivieren](/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli#cs_alb_configure), gehen alle Änderungen an der Quellen-IP, die Sie an dem LoadBalancer-Service vornehmen, der die ALB bereitstellt, verloren. Wenn Sie die ALB erneut aktivieren, müssen Sie auch die Quellen-IP erneut aktivieren.
{: note}

Um die Beibehaltung der Quellen-IP zu aktivieren, bearbeiten Sie den LoadBalancer-Service, der eine Ingress-ALB bereitstellt:

1. Aktivieren Sie die Beibehaltung der Quellen-IP für eine einzelne ALB oder für alle ALBs in Ihrem Cluster.
    * Gehen Sie wie folgt vor, um die Beibehaltung der Quellen-IP für eine einzelne ALB einzurichten:
        1. Rufen Sie die ID der ALB ab, für die Sie die Quellen-IP aktivieren möchten. Die ALB-Services weisen ein Format ähnlich wie `public-cr18e61e63c6e94b658596ca93d087eed9-alb1` für eine öffentliche ALB oder `private-cr18e61e63c6e94b658596ca93d087eed9-alb1` für eine private ALB auf.
            ```
            kubectl get svc -n kube-system | grep alb
            ```
            {: pre}

        2. Öffnen Sie die YAML-Datei für den LoadBalancer-Service, der die ALB bereitstellt.
            ```
            kubectl edit svc <ALB-ID> -n kube-system
            ```
            {: pre}

        3. Ändern Sie unter **`spec`** den Wert von **`externalTrafficPolicy`** von `Cluster` in `Local`.

        4. Speichern und schließen Sie die Konfigurationsdatei. Die Ausgabe ist ähnlich wie die folgende:

            ```
            service "public-cr18e61e63c6e94b658596ca93d087eed9-alb1" edited
            ```
            {: screen}
    * Führen Sie den folgenden Befehl aus, um die Beibehaltung der Quellen-IP für alle öffentlichen ALBs in Ihrem Cluster einzurichten:
        ```
        kubectl get svc -n kube-system | grep alb | awk '{print $1}' | grep "^public" | while read alb; do kubectl patch svc $alb -n kube-system -p '{"spec":{"externalTrafficPolicy":"Local"}}'; done
        ```
        {: pre}

        Beispielausgabe:
        ```
        "public-cr18e61e63c6e94b658596ca93d087eed9-alb1", "public-cr17e61e63c6e94b658596ca92d087eed9-alb2" patched
        ```
        {: screen}

    * Führen Sie den folgenden Befehl aus, um die Beibehaltung der Quellen-IP für alle privaten ALBs in Ihrem Cluster einzurichten:
        ```
        kubectl get svc -n kube-system | grep alb | awk '{print $1}' | grep "^private" | while read alb; do kubectl patch svc $alb -n kube-system -p '{"spec":{"externalTrafficPolicy":"Local"}}'; done
        ```
        {: pre}

        Beispielausgabe:
        ```
        "private-cr18e61e63c6e94b658596ca93d087eed9-alb1", "private-cr17e61e63c6e94b658596ca92d087eed9-alb2" patched
        ```
        {: screen}

2. Stellen Sie sicher, dass die Quellen-IP in den Pod-Protokollen der ALB beibehalten wird.
    1. Rufen Sie die ID eines Pods für die ALB ab, die Sie geändert haben.
        ```
        kubectl get pods -n kube-system | grep alb
        ```
        {: pre}

    2. Öffnen Sie die Protokolle für diesen ALB-Pod. Stellen Sie sicher, dass die IP-Adresse für das Feld `Client` die IP-Adresse der Clientanforderung und nicht die Service-IP-Adresse des LoadBalancer-Service ist.
        ```
        kubectl logs <id_des_alb-pods> nginx-ingress -n kube-system
        ```
        {: pre}

3. Wenn Sie nun nach den Headern für die Anforderungen suchen, die an Ihre Back-End-App gesendet wurden, wird die IP-Adresse des Clients im Header `x-sent-for` angezeigt.

4. Wenn Sie die Quellen-IP nicht mehr beibehalten wollen, können Sie die Änderungen, die Sie an dem Service vorgenommen haben, zurücksetzen.
    * Gehen Sie wie folgt vor, um die Beibehaltung der Quellen-IP für die öffentlichen ALBs zurückzusetzen:
        ```
        kubectl get svc -n kube-system | grep alb | awk '{print $1}' | grep "^public" | while read alb; do kubectl patch svc $alb -n kube-system -p '{"spec":{"externalTrafficPolicy":"Cluster"}}'; done
        ```
        {: pre}
    * Gehen Sie wie folgt vor, um die Beibehaltung der Quellen-IP für die privaten ALBs zurückzusetzen:
        ```
        kubectl get svc -n kube-system | grep alb | awk '{print $1}' | grep "^private" | while read alb; do kubectl patch svc $alb -n kube-system -p '{"spec":{"externalTrafficPolicy":"Cluster"}}'; done
        ```
        {: pre}

<br />


## SSL-Protokolle und SSL-Verschlüsselungen auf HTTP-Ebene konfigurieren
{: #ssl_protocols_ciphers}

Aktivieren Sie SSL-Protokolle und -Verschlüsselungen auf der globalen HTTP-Ebene, indem Sie die Konfigurationszuordnung `ibm-cloud-provider-ingress-cm` bearbeiten.
{:shortdesc}

Zur Umsetzung des Mandats des PCI Security Standards Council inaktiviert der Ingress-Service TLS 1.0 und 1.1 standardmäßig mit der zukünftigen Versionsaktualisierung der Ingress-ALB-Pods am 23. Januar 2019. Die Rollouts der Aktualisierung erfolgen automatisch an alle {{site.data.keyword.containerlong_notm}}-Cluster, für die automatische ALB-Aktualisierungen nicht abgewählt wurden. Wenn die Clients, die eine Verbindung zu Ihren Apps herstellen, TLS 1.2 unterstützen, ist keine Aktion erforderlich. Wenn Sie noch ältere Clients haben, die eine Unterstützung von TLS 1.0 oder 1.1 erfordern, müssen Sie die erforderlichen TLS-Versionen manuell aktivieren. Sie können die Standardeinstellung mit den Schritten in diesem Abschnitt überschreiben, um das Protokoll TLS 1.1 oder 1.0 zu verwenden. Weitere Informationen zum Anzeigen der TLS-Versionen, die Ihre Clients für den Zugriff auf Ihre Apps verwenden, finden Sie in diesem [{{site.data.keyword.cloud_notm}}-Blogeintrag](https://www.ibm.com/blogs/bluemix/2018/11/ibm-cloud-kubernetes-service-alb-update-tls-1-0-and-1-1-disabled-by-default/).
{: important}

Wenn Sie die aktivierten Protokolle für alle Hosts angeben, funktionieren die Parameter TLSv1.1 und TLSv1.2 (1.1.13, 1.0.12) nur, wenn OpenSSL 1.0.1 oder eine höhere Version verwendet wird. Der Parameter TLSv1.3 (1.13.0) funktioniert nur, wenn OpenSSL 1.1.1 mit der Unterstützung von TLSv1.3 erstellt und dann verwendet wird.
{: note}

Gehen Sie wie folgt vor, um die Konfigurationszuordnung zu bearbeiten und SSL-Protokolle und Verschlüsselungen zu aktivieren.

1. Bearbeiten Sie die Konfigurationsdatei für die Konfigurationszuordnungsressource (Configmap) `ibm-cloud-provider-ingress-cm`.

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Fügen Sie SSL-Protokolle und Verschlüsselungen hinzu. Formatieren Sie Verschlüsselungen entsprechend des [OpenSSL-Formats (OpenSSL Library Cipher List Format) ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.openssl.org/docs/man1.0.2/apps/ciphers.html).

   ```
   apiVersion: v1
 data:
   ssl-protocols: "TLSv1 TLSv1.1 TLSv1.2"
   ssl-ciphers: "HIGH:!aNULL:!MD5"
 kind: ConfigMap
 metadata:
   name: ibm-cloud-provider-ingress-cm
   namespace: kube-system
   ```
   {: codeblock}

3. Speichern Sie die Konfigurationsdatei.

4. Stellen Sie sicher, dass die Änderungen an der Konfigurationszuordnung angewendet wurden.

   ```
   kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
   ```
   {: pre}

<br />


## Zeit für Bereitschaftsprüfung beim Neustart von ALB-Pods verlängern
{: #readiness-check}

Sie können die Zeit verlängern, die ALB-Pods für das Parsen großer Ingress-Ressourcendateien zur Verfügung steht, wenn die ALB-Pods erneut gestartet werden.
{: shortdesc}

Wenn ein ALB-Pod z. B. nach einer Aktualisierung erneut gestartet wird, verhindert eine Bereitschaftsprüfung, dass der ALB-Pod versucht, Datenverkehrsanforderungen weiterzuleiten, bis alle Ingress-Ressourcendateien geparst wurden. Diese Bereitschaftsprüfung verhindert, dass Anforderungen verloren gehen, wenn ALB-Pods erneut gestartet werden. Standardmäßig wartet die Bereitschaftsprüfung 15 Sekunden, nachdem der Pod erneut gestartet wurde, um zu prüfen, ob alle Ingress-Dateien geparst wurden. Wenn alle Dateien 15 Sekunden nach dem Neustart des Pods geparst sind,  beginnt der ALB-Pod wieder, die Datenverkehrsanforderungen weiterzuleiten. Wenn 15 Sekunden nach dem Neustart des Pods nicht alle Dateien geparst sind, wird der Datenverkehr vom Pod nicht weitergeleitet, und die Bereitschaftsprüfung prüft weiterhin alle 15 Sekunden auf eine maximale Zeitlimitdauer von 5 Minuten. Nach fünf Minuten beginnt der ALB-Pod, den Datenverkehr weiterzuleiten.

Wenn Sie über sehr große Ingress-Ressourcendateien verfügen, dauert es möglicherweise länger als fünf Minuten, bis alle Dateien geparst sind. Sie können die Standardwerte für die Intervallrate der Bereitschaftsprüfung und für das maximale Gesamtzeitlimit der Bereitschaftsprüfung ändern, indem Sie die Einstellungen `ingress-resource-creation-rate` und `ingress-resource-timeout` zur Configmap `ibm-cloud-provider-ingress-cm` hinzufügen.

1. Bearbeiten Sie die Konfigurationsdatei für die Konfigurationszuordnungsressource (Configmap) `ibm-cloud-provider-ingress-cm`.
    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Fügen Sie im Abschnitt **data** die Einstellungen `ingress-resource-creation-rate` und `ingress-resource-timeout` hinzu. Die Werte können als Sekunden (`s`) und Minuten (`m`) formatiert werden. Beispiel:
   ```
   apiVersion: v1
   data:
     ingress-resource-creation-rate: 1m
     ingress-resource-timeout: 6m
     keep-alive: 8s
     private-ports: 80;443
     public-ports: 80;443
   ```
   {: codeblock}

3. Speichern Sie die Konfigurationsdatei.

4. Stellen Sie sicher, dass die Änderungen an der Konfigurationszuordnung angewendet wurden.
   ```
   kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
   ```
   {: pre}

<br />


## ALB-Leistung optimieren
{: #perf_tuning}

Um die Leistung Ihrer Ingress-ALBs zu optimieren, können Sie die Standardeinstellungen entsprechend Ihren Anforderungen ändern.
{: shortdesc}

### ALB-Socket-Listener zu jedem Workerknoten hinzufügen
{: #reuse-port}

Erhöhen Sie die Anzahl der ALB-Socket-Listener von 'einem pro Cluster' auf 'einen pro Workerknoten', indem Sie die Ingress-Anweisung `reuse-port` verwenden.
{: shortdesc}

Wenn die Option `reuse-port` inaktiviert ist, benachrichtigt ein einzelnes empfangsbereites Socket die Worker über eingehende Verbindungen und alle Workerknoten versuchen, die Verbindung herzustellen. Wenn `reuse-port` jedoch aktiviert ist, gibt es einen Socket-Listener pro Workerknoten für jede ALB-IP-Adresse und Portkombination. Nicht jeder Workerknoten versucht, die Verbindung zu nutzen, sondern der Linux-Kernel bestimmt, welcher verfügbare Socket-Listener die Verbindung erhält. Zugriffskonflikte zwischen den Workern werden so reduziert, was die Leistung verbessern kann. Weitere Informationen zu den Vorteilen und Nachteilen der Anweisung `reuse-port` finden Sie in [diesem NGINX-Blogbeitrag ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.nginx.com/blog/socket-sharding-nginx-release-1-9-1/).

Sie können die Listener skalieren, indem Sie die Ingress-ConfigMap `ibm-cloud-provider-ingress-cm` bearbeiten.

1. Bearbeiten Sie die Konfigurationsdatei für die Konfigurationszuordnungsressource (Configmap) `ibm-cloud-provider-ingress-cm`.
    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Fügen Sie im Abschnitt `metadata` den Eintrag `reuse-port: "true"` hinzu. Beispiel:
   ```
   apiVersion: v1
   data:
     private-ports: 80;443;9443
     public-ports: 80;443
   kind: ConfigMap
   metadata:
     creationTimestamp: "2018-09-28T15:53:59Z"
     name: ibm-cloud-provider-ingress-cm
     namespace: kube-system
     resourceVersion: "24648820"
     selfLink: /api/v1/namespaces/kube-system/configmaps/ibm-cloud-provider-ingress-cm
     uid: b6ca0c36-c336-11e8-bf8c-bee252897df5
     reuse-port: "true"
   ```
   {: codeblock}

3. Speichern Sie die Konfigurationsdatei.

4. Stellen Sie sicher, dass die Änderungen an der Konfigurationszuordnung angewendet wurden.

   ```
   kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
   ```
   {: pre}

### Protokollpufferung und Flush-Zeitlimit aktivieren
{: #access-log}

Standardmäßig protokolliert die Ingress-ALB jede Anforderung, wenn sie eintrifft. Bei einer Umgebung mit hoher Auslastung kann das Protokollieren jeder Anforderung bei ihrem Eintreffen eine erhebliche Zunahme der Platten-E/A-Aktivitäten zur Folge haben. Um kontinuierliche Plattenein-/-ausgabeaktivitäten zu vermeiden, können Sie die Protokollpufferung und das Flush-Zeitlimit für die ALB aktivieren, indem Sie die Ingress-Konfigurationszuordnung `ibm-cloud-provider-ingress-cm` bearbeiten. Wenn die Pufferung aktiviert ist, wird nicht für jeden Protokolleintrag eine separate Schreiboperation durchgeführt, sondern die ALB puffert eine Reihe von Einträgen und schreibt sie in einer einzigen Operation in die Datei.
{: shortdesc}

1. Bearbeiten und erstellen Sie die Konfigurationsdatei für die Konfigurationszuordnungsressource (Configmap) `ibm-cloud-provider-ingress-cm`.

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Bearbeiten Sie die Konfigurationszuordnung.
    1. Aktivieren Sie die Protokollpufferung, indem Sie das Feld `access-log-buffering` hinzufügen und auf `"true"` setzen.

    2. Legen Sie den Schwellenwert fest, bei dem die ALB den Pufferinhalt in das Protokoll schreiben soll.
        * Zeitintervall: Fügen Sie das Feld `flush-interval` hinzu und legen Sie fest, wie häufig die ALB in das Protokoll schreiben soll. Wenn beispielsweise der Standardwert `5m` verwendet wird, schreibt die ALB alle 5 Minuten den Pufferinhalt in das Protokoll.
        * Puffergröße: Fügen Sie das Feld `buffer-size` hinzu und legen Sie fest, wie viel Protokollspeicher in dem Puffer gespeichert werden kann, bevor die ALB den Pufferinhalt in das Protokoll schreibt. Wenn zum Beispiel der Standardwert `100KB` verwendet wird, schreibt die ALB den Pufferinhalt jedes Mal in das Protokoll, wenn die Puffergröße den Wert 100 KB erreicht.
        * Zeitintervall oder Puffergröße: Wenn sowohl `flush-interval` und `buffer-size` festgelegt werden, schreibt die ALB den Pufferinhalt in das Protokoll, abhängig davon, welcher Schwellenparameter zuerst erreicht wird.

    ```
    apiVersion: v1
    kind: ConfigMap
    data:
      access-log-buffering: "true"
      flush-interval: "5m"
      buffer-size: "100KB"
    metadata:
      name: ibm-cloud-provider-ingress-cm
      ...
    ```
   {: codeblock}

3. Speichern Sie die Konfigurationsdatei.

4. Überprüfen Sie, ob Ihre ALB mit den Zugriffsprotokolländerungen konfiguriert wurde.

   ```
   kubectl logs -n kube-system <alb-id> -c nginx-ingress
   ```
   {: pre}

### Anzahl oder Dauer der Keepalive-Verbindungen ändern
{: #keepalive_time}

Keepalive-Verbindungen können eine große Auswirkung auf die Leistung haben, indem sie die CPU- und Netzauslastung zum Öffnen und Schließen von Verbindungen reduzieren. Um die Leistung Ihrer ALBs zu optimieren, können Sie die maximale Anzahl der Keepalive-Verbindungen zwischen der ALB und dem Client ändern und angeben, wie lange die Keepalive-Verbindungen andauern können.
{: shortdesc}

1. Bearbeiten Sie die Konfigurationsdatei für die Konfigurationszuordnungsressource (Configmap) `ibm-cloud-provider-ingress-cm`.

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Ändern Sie die Werte von `keep-alive-requests` und `keep-alive`.
    * `keep-alive-requests`: Die Anzahl der Keepalive-Clientverbindungen, die für die Ingress-ALB geöffnet bleiben können. Der Standardwert ist `4096`.
    * `keep-alive`: Das Zeitlimit in Sekunden, während dessen die Keepalive-Clientverbindung für die Ingress-ALB geöffnet bleibt. Der Standardwert ist `8s`.
   ```
   apiVersion: v1
   data:
     keep-alive-requests: "4096"
     keep-alive: "8s"
   kind: ConfigMap
   metadata:
     name: ibm-cloud-provider-ingress-cm
     namespace: kube-system
   ```
   {: codeblock}

3. Speichern Sie die Konfigurationsdatei.

4. Stellen Sie sicher, dass die Änderungen an der Konfigurationszuordnung angewendet wurden.

   ```
   kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
   ```
   {: pre}

### Einstellung für den Rückstand bei anstehenden Verbindungen ändern
{: #backlog}

Sie können die Standardeinstellung für den Rückstand verringern, um festzulegen, wie viele anstehende Verbindungen in der Serverwarteschlange warten können.
{: shortdesc}

In der Ingress-Konfigurationszuordnung `ibm-cloud-provider-ingress-cm` legt das Feld `backlog` die maximale Anzahl anstehender Verbindungen fest, die in der Serverwarteschlange warten können. Standardmäßig ist `backlog` auf `32768` gesetzt. Sie können den Standardwert überschreiben, indem Sie die Ingress-Konfigurationszuordnung bearbeiten.

1. Bearbeiten Sie die Konfigurationsdatei für die Konfigurationszuordnungsressource (Configmap) `ibm-cloud-provider-ingress-cm`.

    ```
    kubectl edit cm ibm-cloud-provider-ingress-cm -n kube-system
    ```
    {: pre}

2. Ändern Sie den Wert für `backlog` von `32768` in einen geringeren Wert. Der Wert muss gleich oder kleiner als 32768 sein.

   ```
   apiVersion: v1
   data:
     backlog: "32768"
   kind: ConfigMap
   metadata:
     name: ibm-cloud-provider-ingress-cm
     namespace: kube-system
   ```
   {: codeblock}

3. Speichern Sie die Konfigurationsdatei.

4. Stellen Sie sicher, dass die Änderungen an der Konfigurationszuordnung angewendet wurden.

   ```
   kubectl get cm ibm-cloud-provider-ingress-cm -n kube-system -o yaml
   ```
   {: pre}

### Kernelleistung optimieren
{: #ingress_kernel}

Um die Leistung Ihrer Ingress-ALBs zu optimieren, [können Sie auch die `sysctl` Linux-Kernelparameter auf den Workerknoten ändern](/docs/containers?topic=containers-kernel). Workerknoten werden automatisch mit optimierter Kerneloptimierung bereitgestellt. Ändern Sie daher diese Einstellungen nur, wenn Sie bestimmte Anforderungen hinsichtlich der Leistungsoptimierung haben.
{: shortdesc}

<br />

