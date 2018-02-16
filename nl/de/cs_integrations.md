---

copyright:
  years: 2014, 2018
lastupdated: "2018-01-11"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:pre: .pre}
{:table: .aria-labeledby="caption"}
{:codeblock: .codeblock}
{:tip: .tip}
{:download: .download}


# Integration von Services
{: #integrations}

Sie können verschiedene externe Services und Services im {{site.data.keyword.Bluemix_notm}}-Katalog mit einem Standardcluster in {{site.data.keyword.containershort_notm}} verwenden.
{:shortdesc}

<table summary="Zusammenfassung der Zugriffsmöglichkeiten">
<caption>Tabelle. Integrationsoptionen für Cluster und Apps in Kubernetes</caption>
<thead>
<tr>
<th>Service</th>
<th>Beschreibung</th>
</tr>
</thead>
<tbody>
<tr>
<td>Blockchain</td>
<td>Implementieren Sie eine öffentlich verfügbare Entwicklungsumgebung für IBM Blockchain in einem Kubernetes-Cluster in {{site.data.keyword.containerlong_notm}}. Verwenden Sie diese Umgebung für die Entwicklung und Anpassung Ihres eigenen Blockchain-Netzes, um Apps bereitzustellen, die ein nicht veränderbares Hauptbuch zur Aufzeichnung des Transaktionsprotokolls gemeinsam nutzen. Weitere Informationen finden Sie unter <a href="https://ibm-blockchain.github.io" target="_blank">In einer Cloud-Sandbox entwickeln - IBM Blockchain Platform <img src="../icons/launch-glyph.svg" alt="Symbol für externen Link"></a>. </td>
</tr>
<tr>
<td>Continuous Delivery</td>
<td>Automatisieren Sie die App-Builds und die Containerbereitstellungen in Kubernetes-Clustern mithilfe einer Toolchain. Informationen zur Konfiguration finden Sie in dem Blog <a href="https://developer.ibm.com/recipes/tutorials/deploy-kubernetes-pods-to-the-bluemix-container-service-using-devops-pipelines/" target="_blank">Deploy Kubernetes pods to the {{site.data.keyword.containerlong_notm}} using DevOps Pipelines <img src="../icons/launch-glyph.svg" alt="Symbol für externen Link"></a>. </td>
</tr>
<tr>
<td>Helm</td>
<td> <a href="https://helm.sh/" target="_blank">Helm <img src="../icons/launch-glyph.svg" alt="Symbol für externen Link"></a> ist ein Kubernetes-Paketmanager. Erstellen Sie Helm-Diagramme zum Definieren, Installieren und Durchführen von Upgrades für komplexe Kubernetes-Anwendungen, die in {{site.data.keyword.containerlong_notm}}-Clustern ausgeführt werden. Über den folgenden Link finden Sie weitere Informationen zur Vorgehensweise bei der <a href="https://developer.ibm.com/recipes/tutorials/increase-deployment-velocity-with-kubernetes-helm-charts/" target="_blank">Erhöhung der Bereitstellungsgeschwindigkeit mit Kubernetes-Helm-Diagrammen <img src="../icons/launch-glyph.svg" alt="Symbol für externen Link"></a>. </td>
</tr>
<tr>
<td>Instana</td>
<td> <a href="https://www.instana.com/" target="_blank">Instana <img src="../icons/launch-glyph.svg" alt="Symbol für externen Link"></a> bietet eine Leistungsüberwachung von Infrastrukturen und Apps über eine grafische Benutzerschnittstelle, die automatisch Apps erkennt und zuordnet. Außerdem erfasst Istana alle Anforderungen an Ihre Apps, wodurch Sie Fehlerbehebungen und Ursachenanalysen durchführen können, um zu verhindern, dass Probleme erneut auftreten. Lesen Sie dazu den Blogeintrag zur <a href="https://www.instana.com/blog/precise-visibility-applications-ibm-bluemix-container-service/" target="_blank">Bereitstellung von Istana in {{site.data.keyword.containershort_notm}} <img src="../icons/launch-glyph.svg" alt="Symbol für externen Link"></a>, um weitere Informationen zu erhalten.</td>
</tr>
<tr>
<td>Istio</td>
<td><a href="https://www.ibm.com/cloud/info/istio" target="_blank">Istio <img src="../icons/launch-glyph.svg" alt="Symbol für externen Link"></a> ist ein Open-Source-Service, der Entwicklern eine Möglichkeit zum Verbinden, Sichern, Verwalten und Überwachen
eines Netzes von Microservices, auch als Servicenetz bezeichnet, auf Cloudorchestrierungsplattformen wie Kubernetes bietet. Lesen Sie den Blogbeitrag darüber, <a href="https://developer.ibm.com/dwblog/2017/istio/" target="_blank">wie IBM Istio mitgegründet und auf den Markt gebracht hat <img src="../icons/launch-glyph.svg" alt="Symbol für externen Link"></a>, um weitere Informationen zu dem Open-Source-Projekt zu erhalten. Weitere Informationen zum Installieren von Istio aud Ihrem Kubernetes-Cluster in {{site.data.keyword.containershort_notm}} und zu den ersten Schritten mit einer Beispiel-App erhalten Sie im [Lernprogramm: Microservices mit Istio verwalten](cs_tutorials_istio.html#istio_tutorial).</td>
</tr>
<tr>
<td>Prometheus</td>
<td>Prometheus ist ein Open-Source-Tool für Überwachung, Protokollierung und Benachrichtigung bei Alerts, das speziell für Kubernetes entwickelt wurde, um auf Grundlage der Kubernetes-Protokollierungsinformationen detaillierte Informationen zu Cluster, Workerknoten und Bereitstellungszustand abzurufen. Die CPU-, Speicher-, Ein-/Ausgabe- und Netzaktivität aller aktiven Container in einem Cluster wird erfasst und kann in angepassten Abfragen oder Alerts für die Überwachung der Leistung und der einzelnen Arbeitslasten in Ihrem Cluster verwendet werden.
<p>Gehen Sie wie folgt vor, um Prometheus zu verwenden:</p>
<ol>
<li>Installieren Sie Prometheus, indem Sie die <a href="https://github.com/coreos/prometheus-operator/tree/master/contrib/kube-prometheus" target="_blank">CoreOS-Anweisungen <img src="../icons/launch-glyph.svg" alt="Symbol für externen Link"> befolgen</a>.
<ol>
<li>Wenn Sie den Exportbefehl ausführen, verwenden Sie Ihren 'kube-system'-Namensbereich. <p><code>export NAMESPACE=kube-system hack/cluster-monitoring/deploy</code></p></li>
</ol>
</li>
<li>Bearbeiten Sie nach der erfolgten Bereitstellung von Prometheus in Ihrem Cluster die Prometheus-Datenquelle in Grafana, sodass sie sich auf <code>prometheus.kube-system:30900</code> bezieht.</li>
</ol>
</td>
</tr>
<tr>
<td>{{site.data.keyword.bpshort}}</td>
<td>{{site.data.keyword.bplong}} ist ein Automatisierungstool, das Terraform für die Bereitstellung Ihrer Infrastruktur als Code verwendet. Wenn Sie Ihre Infrastruktur als einzelne Einheit bereitstellen, können Sie diese Cloudressourcendefinitionen in beliebig vielen Umgebungen wiederverwenden. Um einen Kubernetes-Cluster als Ressource mit {{site.data.keyword.bpshort}} zu definieren, versuchen Sie, eine Umgebung mit der Vorlage [container-cluster](https://console.bluemix.net/schematics/templates/details/Cloud-Schematics%2Fcontainer-cluster) zu erstellen. Weitere Informationen zu Schematics finden Sie unter [Informationen zu {{site.data.keyword.bplong_notm}}](/docs/services/schematics/schematics_overview.html#about).</td>
</tr>
<tr>
<td>Weave Scope</td>
<td>Weave Scope liefert eine grafisch orientierte Diagrammdarstellung Ihrer Ressourcen in einem Kubernetes-Cluster unter Einbeziehung von Services, Pods, Containern, Prozessen, Knoten und vielem mehr. Weave Scope stellt interaktive Metriken für CPU und Speicher bereit und bietet Tools, um 'tail'- und 'exec'-Aufrufe in einem Container durchzuführen.<p>Weitere Informationen finden Sie unter [Kubernetes-Clusterressourcen mit Weave Scope und {{site.data.keyword.containershort_notm}} grafisch darstellen](cs_integrations.html#weavescope).</p></li></ol>
</td>
</tr>
</tbody>
</table>

<br />



## Services zu Clustern hinzufügen
{: #adding_cluster}

Sie können eine vorhandene {{site.data.keyword.Bluemix_notm}}-Serviceinstanz
zu Ihrem Cluster hinzufügen, um den Benutzern Ihres Clusters den Zugriff auf den
{{site.data.keyword.Bluemix_notm}}-Service
sowie seine Verwendung zu ermöglichen, wenn sie eine App auf dem Cluster bereitstellen.
{:shortdesc}

Vorbemerkungen:

1. [Richten Sie Ihre CLI](cs_cli_install.html#cs_cli_configure) (Befehlszeilenschnittstelle) auf Ihren Cluster aus.
2. [Fordern Sie eine Instanz des {{site.data.keyword.Bluemix_notm}}-Service](/docs/manageapps/reqnsi.html#req_instance) an.
   **Hinweis:** Zur Erstellung einer Instanz eines Service am Standort 'Washington DC' müssen Sie die CLI verwenden.

**Hinweis:**
<ul><ul>
<li>Es können nur {{site.data.keyword.Bluemix_notm}}-Services
hinzugefügt werden, die Serviceschlüssel unterstützen. Wenn der Service keine Serviceschlüssel unterstützt, dann sollten Sie die Informationen zum Thema [Externen Apps die Verwendung von {{site.data.keyword.Bluemix_notm}}-Services ermöglichen](/docs/manageapps/reqnsi.html#accser_external) lesen.</li>
<li>Der Cluster und die Workerknoten müssen vollständig bereitgestellt werden, bevor Sie einen Service hinzufügen können.</li>
</ul></ul>


Gehen Sie wie folgt vor, um einen Service hinzuzufügen:
2.  Listen Sie verfügbare {{site.data.keyword.Bluemix_notm}}-Services auf.

    ```
    bx service list
    ```
    {: pre}

    CLI-Beispielausgabe:

    ```
    name                      service           plan    bound apps   last operation
    <serviceinstanzname>   <servicename>    spark                create succeeded
    ```
    {: screen}

3.  Notieren Sie unter **name** den Namen der Serviceinstanz, die Sie zu Ihrem Cluster hinzufügen wollen.
4.  Geben Sie den Clusternamensbereich an, den Sie verwenden wollen, um Ihren Service hinzuzufügen. Wählen Sie eine der folgenden Optionen aus.
    -   Lassen Sie eine Liste der vorhandenen Namensbereiche anzeigen und wählen Sie einen Namensbereich aus, den Sie verwenden wollen.

        ```
        kubectl get namespaces
        ```
        {: pre}

    -   Erstellen Sie einen neuen Namensbereich in Ihrem Cluster.

        ```
        kubectl create namespace <name_des_namensbereichs>
        ```
        {: pre}

5.  Fügen Sie den Service zu Ihrem Cluster hinzu.

    ```
    bx cs cluster-service-bind <clustername_oder_-id> <namensbereich> <serviceinstanzname>
    ```
    {: pre}

    Wenn der Service erfolgreich zu Ihrem Cluster hinzugefügt worden ist, wird ein geheimer Schlüssel für den Cluster erstellt, der die Berechtigungsnachweise Ihrer Serviceinstanz enthält. CLI-Beispielausgabe:

    ```
    bx cs cluster-service-bind mycluster mynamespace cleardb
    Binding service instance to namespace...
    OK
    Namespace: mynamespace
    Secret name:     binding-<serviceinstanzname>
    ```
    {: screen}

6.  Stellen Sie sicher, dass der geheime Schlüssel im Namensbereich Ihres Clusters erstellt wurde.

    ```
    kubectl get secrets --namespace=<namensbereich>
    ```
    {: pre}


Um den Service in einem Pod zu verwenden, der im Cluster bereitgestellt ist, können Clusterbenutzer auf die Serviceberechtigungsnachweise des {{site.data.keyword.Bluemix_notm}}-Service zugreifen, indem sie [den geheimen Kubernetes-Schlüssel als Datenträger für geheime Schlüssel an einen Pod anhängen](cs_integrations.html#adding_app).

<br />



## Services zu Apps hinzufügen
{: #adding_app}

Zum Speichern der Detailinformationen und Berechtigungsnachweise für {{site.data.keyword.Bluemix_notm}}-Services und zur Sicherstellung der sicheren Kommunikation zwischen dem Service und dem Cluster werden verschlüsselte Kubernetes-Schlüssel verwendet. Als Clusterbenutzer können Sie auf diesen geheimen Schlüssel zugreifen, indem Sie ihn als Datenträger an einen Pod anhängen.
{:shortdesc}

Führen Sie zunächst den folgenden Schritt aus: [Richten Sie Ihre CLI](cs_cli_install.html#cs_cli_configure) auf Ihren Cluster aus. Stellen Sie sicher, dass der {{site.data.keyword.Bluemix_notm}}-Service, den Sie in Ihrer App verwenden wollen, vom Clusteradministrator [zu dem Cluster hinzugefügt](cs_integrations.html#adding_cluster) wurde.

Geheime Kubernetes-Schlüssel stellen eine sichere Methode zum Speichern vertraulicher Informationen wie Benutzernamen, Kennwörter oder Schlüssel dar. Statt vertrauliche Informationen über Umgebungsvariablen oder direkt in der Dockerfile selbst offenzulegen, müssen geheime Schlüssel als Datenträger für geheime Schlüssel an einen Pod angehängt werden, damit sie von einem aktiven Container in einem Pod zugänglich sind.

Wenn Sie einen Datenträger für geheime Schlüssel an Ihren Pod anhängen, wird im Mountverzeichnis des Datenträgers eine Datei namens 'binding' gespeichert. Diese Datei enthält sämtliche Informationen und Berechtigungsnachweise, die Sie benötigen, um auf den {{site.data.keyword.Bluemix_notm}}-Service zuzugreifen.

1.  Listen Sie die verfügbaren geheimen Schlüssel im Namensbereich Ihres Clusters auf.

    ```
    kubectl get secrets --namespace=<mein_namensbereich>
    ```
    {: pre}

    Beispielausgabe:

    ```
    NAME                                    TYPE                                  DATA      AGE
    binding-<serviceinstanzname>         Opaque                                1         3m

    ```
    {: screen}

2.  Suchen Sie nach einem Schlüssel des Typs **Opaque** und notieren Sie den **Namen** des geheimen Schlüssels. Sollten mehrere geheime Schlüssel vorhanden sein, wenden Sie sich an Ihren Clusteradministrator, damit dieser den geheimen Schlüssel für den gewünschten Service ermittelt.

3.  Öffnen Sie Ihren bevorzugten Editor.

4.  Erstellen Sie eine YAML-Datei, um einen Pod zu konfigurieren, der in der Lage ist, über einen Datenträger für geheime Schlüssel auf die Servicedetails zuzugreifen.

    ```
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
      labels:
        app: secret-test
      name: secret-test
      namespace: <mein_namensbereich>
    spec:
      selector:
        matchLabels:
          app: secret-test
      replicas: 1
      template:
        metadata:
          labels:
            app: secret-test
        spec:
          containers:
          - image: nginx
            name: secret-test
            volumeMounts:
            - mountPath: /opt/service-bind
              name: service-bind-volume
          volumes:
          - name: service-bind-volume
            secret:
              defaultMode: 420
              secretName: binding-<serviceinstanzname>
    ```
    {: codeblock}

    <table>
    <thead>
    <th colspan=2><img src="images/idea.png" alt="Ideensymbol"/> Erklärung der YAML-Dateikomponenten</th>
    </thead>
    <tbody>
    <tr>
    <td><code>volumeMounts/mountPath</code></td>
    <td>Der Name des Datenträgers für geheime Schlüssel, der an den Container angehängt werden soll.</td>
    </tr>
    <tr>
    <td><code>volumes/name</code></td>
    <td>Geben Sie einen Namen für den Datenträger für geheime Schlüssel ein, der an den Container angehängt werden soll.</td>
    </tr>
    <tr>
    <td><code>secret/defaultMode</code></td>
    <td>Legen Sie Schreibschutz für den geheimen Schlüssel des Service fest.</td>
    </tr>
    <tr>
    <td><code>secret/secretName</code></td>
    <td>Geben Sie den Namen des geheimen Schlüssels ein, den Sie zuvor notiert haben.</td>
    </tr></tbody></table>

5.  Erstellen Sie den Pod und hängen Sie den Datenträger für geheime Schlüssel an.

    ```
    kubectl apply -f <yaml-pfad>
    ```
    {: pre}

6.  Stellen Sie sicher, dass der Pod erstellt wurde.

    ```
    kubectl get pods --namespace=<mein_namensbereich>
    ```
    {: pre}

    CLI-Beispielausgabe:

    ```
    NAME                           READY     STATUS    RESTARTS   AGE
    secret-test-1111454598-gfx32   1/1       Running   0          1m
    ```
    {: screen}

7.  Notieren Sie die Namensangabe für Ihren Pod unter **NAME**.
8.  Rufen Sie die Details zum Pod ab und suchen Sie den Namen des geheimen Schlüssels.

    ```
    kubectl describe pod <podname>
    ```
    {: pre}

    Ausgabe:

    ```
    ...
    Volumes:
      service-bind-volume:
        Type:       Secret (Datenträger, der mit einem geheimen Schlüssel belegt ist)
        SecretName: binding-<serviceinstanzname>
    ...
    ```
    {: screen}

    

9.  Konfigurieren Sie Ihre App beim Implementieren so, dass sie die Datei **binding** mit dem geheimen Schlüssel im Mountverzeichnis finden, den JSON-Inhalt parsen und die URL sowie die Berechtigungsnachweise für den Service ermitteln kann, um auf den {{site.data.keyword.Bluemix_notm}}-Service zuzugreifen.

Sie können nun auf die Details für den {{site.data.keyword.Bluemix_notm}}-Service und die zugehörigen Berechtigungsnachweise zugreifen. Um mit Ihrem {{site.data.keyword.Bluemix_notm}}-Service arbeiten zu können, stellen Sie sicher, dass Ihre App so konfiguriert ist, dass sie die Datei mit dem geheimen Schlüssel für den Service im Mountverzeichnis finden, den JSON-Inhalt parsen und die Servicedetails ermitteln kann.

<br />



## Kubernetes-Clusterressourcen grafisch darstellen
{: #weavescope}

Weave Scope liefert eine grafisch orientierte Diagrammdarstellung Ihrer Ressourcen in einem Kubernetes-Cluster unter Einbeziehung von Services, Pods, Containern, Prozessen, Knoten und vielem mehr. Weave Scope stellt interaktive Metriken für CPU und Speicher bereit und bietet Tools, um 'tail'- und 'exec'-Aufrufe in einem Container durchzuführen.
{:shortdesc}

Vorbemerkungen:

-   Denken Sie daran, dass Sie keine Clusterinformationen im öffentlichen Internet offenlegen dürfen. Führen Sie diese Schritte aus, um Weave Scope sicher bereitzustellen und dann lokal über einen Web-Browser auf den Service zuzugreifen.
-   Wenn Sie nicht bereits über einen verfügen, [erstellen Sie einen Standardcluster](cs_clusters.html#clusters_ui). Weave Scope kann die CPU stark belasten, insbesondere die App. Führen Sie Weave Scope daher mit größeren Standardclustern aus, nicht mit Lite-Clustern.
-   [Richten Sie Ihre CLI](cs_cli_install.html#cs_cli_configure) auf Ihren Cluster aus, `kubectl`-Befehle auszuführen.


Gehen Sie wie folgt vor, um Weave Scope mit einem Cluster zu verwenden:
2.  Stellen Sie eine der zur Verfügung gestellten Konfigurationsdatei für die RBAC-Berechtigungen im Cluster bereit.

    Gehen Sie wie folgt vor, um die Schreib-/Leseberechtigung zu aktivieren:

    ```
    kubectl apply -f "https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/weave-scope/weave-scope-rbac.yaml"
    ```
    {: pre}

    Gehen Sie wie folgt vor, um die Schreibberechtigung zu aktivieren:

    ```
    kubectl apply -f "https://raw.githubusercontent.com/IBM-Cloud/kube-samples/master/weave-scope/weave-scope-rbac-readonly.yaml"
    ```
    {: pre}

    Ausgabe:

    ```
    clusterrole "weave-scope-mgr" created
    clusterrolebinding "weave-scope-mgr-role-binding" created
    ```
    {: screen}

3.  Stellen Sie den Weave Scope-Service bereit, auf den über die IP-Adresse des Clusters privat zugegriffen werden kann.

    <pre class="pre">
    <code>kubectl apply --namespace kube-system -f "https://cloud.weave.works/k8s/scope.yaml?k8s-version=$(kubectl version | base64 | tr -d '&bsol;n')"</code>
    </pre>

    Ausgabe:

    ```
    serviceaccount "weave-scope" created
    deployment "weave-scope-app" created
    service "weave-scope-app" created
    daemonset "weave-scope-agent" created
    ```
    {: screen}

4.  Führen Sie einen Befehl zur Portweiterleitung aus, um den Service auf dem Computer zu starten. Da Weave Scope jetzt für den Cluster konfiguriert ist, können Sie diesen Befehl zur Portweiterleitung beim nächsten Zugriff auf Weave Scope ausführen, ohne wieder die vorherigen Konfigurationsschritte ausführen zu müssen.

    ```
    kubectl port-forward -n kube-system "$(kubectl get -n kube-system pod --selector=weave-scope-component=app -o jsonpath='{.items..metadata.name}')" 4040
    ```
    {: pre}

    Ausgabe:

    ```
    Forwarding from 127.0.0.1:4040 -> 4040
    Forwarding from [::1]:4040 -> 4040
    Handling connection for 4040
    ```
    {: screen}

5.  Öffnen Sie Ihren Web-Browser mit der Adresse `http://localhost:4040`. Ohne die Bereitstellung der Standardkomponenten wird das folgende Diagramm angezeigt. Sie können entweder Topologiediagramme oder Tabellen in den Kubernetes-Ressourcen im Cluster anzeigen.

     <img src="images/weave_scope.png" alt="Beispieltopologie von Weave Scope" style="width:357px;" />


[Weitere Informationen zu den Weave Scope-Funktionen ![Symbol für externen Link](../icons/launch-glyph.svg "Symbol für externen Link")](https://www.weave.works/docs/scope/latest/features/).

<br />

